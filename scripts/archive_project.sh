#!/usr/bin/env bash
# archive_project.sh — package a lab project and upload it to Azure Blob Storage (Archive tier).
#
# Source:  https://github.com/rendeirolab/lab-manual/blob/main/scripts/archive_project.sh
# Get it:  curl -fsSLO https://raw.githubusercontent.com/rendeirolab/lab-manual/main/scripts/archive_project.sh
#          chmod +x archive_project.sh
# Help:    ./archive_project.sh --help
# Docs:    https://github.com/rendeirolab/lab-manual/blob/main/source/data_archiving.md
#
# Written 2026-10 (tested with Azure CLI 2.91, AzCopy 10.28, GNU tar 1.30, pigz 2.4).
# Needs GNU tools (tar, find, coreutils): runs on the Linux cluster, not on macOS.
# Test:    bash scripts/test_archive_project.sh
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: archive_project.sh [options] <project> <owner-email>

Packs <project> into .tar.gz files, uploads them to the Azure Archive tier,
checks the upload, and adds a line to the inventory file.
It never deletes anything on the cluster. Running it again reuses tarballs
that were already built, and skips files that were already uploaded.

What to run, in order:
  --check          Only check that the needed programs are installed.
  --dry-run        Show the project size and links to data outside the project.
  --package-only   Build the tarballs and checksums. No upload.
  (no mode)        Build (or reuse) the tarballs, then upload and check them.

Options (all optional except --account for uploading):
  --account NAME     Azure storage account name. Can also be set with
                     the STORAGE_ACCOUNT environment variable.
  --exclude PATTERN  Leave out files/folders matching PATTERN. The pattern
                     starts with the project name and may contain *, e.g.
                       --exclude 'myproj/data/public_downloads'
                       --exclude 'myproj/output/*/*/tmp'
                     Repeat --exclude for several patterns.
  --split DIR        Make one tarball per sub-folder of <project>/DIR
                     (e.g. one per experiment); other files in DIR stay in the
                     main tarball. Useful for big projects, so a restore can
                     fetch one part instead of everything.
                     Repeat --split for several folders.
  --threads N        CPU threads for compression (default: 8).
  --level N          Compression level 1-9 (default: 6). Level 1 is much
                     faster and compresses image data about as well.
  --projects-root D  Folder that contains <project>
                     (default: /nobackup/lab_rendeiro/projects).
  --research-root D  If D/<project> also exists, it is packed as a second
                     tarball (default: /research/lab_rendeiro/projects).
  --staging D        Where tarballs are written; needs free space about the
                     size of the project (default: /nobackup/lab_rendeiro/archive_staging).
  --inventory FILE   CSV file that lists everything archived
                     (default: <staging>/inventory.csv).
  -h, --help         Show this help.

Always left out: .venv, .venv.*, __pycache__, .ruff_cache, .pytest_cache,
.ipynb_checkpoints, .cache, dask-logs, .nextflow, .nextflow.log*, wandb,
libpod, .containers, slurm-*.out, dcgm-gpu-stats-*.out.
The project's .git folder IS kept.

The project folder must contain an ARCHIVE.md describing the data.
EOF
}

# ---------------------------------------------------------------- arguments
MODE=upload
ACCOUNT="${STORAGE_ACCOUNT:-}"
EXTRA_EXCLUDES=()
SPLIT_DIRS=()
THREADS=8
LEVEL=6
PROJECTS_ROOT=/nobackup/lab_rendeiro/projects
RESEARCH_ROOT=/research/lab_rendeiro/projects
STAGING_ROOT=/nobackup/lab_rendeiro/archive_staging
INVENTORY=""
POSITIONAL=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --check)          MODE=check ;;
    --dry-run)        MODE=dry-run ;;
    --package-only)   MODE=package ;;
    --account)        ACCOUNT="$2"; shift ;;
    --exclude)        EXTRA_EXCLUDES+=("$2"); shift ;;
    --split)          SPLIT_DIRS+=("${2%/}"); shift ;;
    --threads)        THREADS="$2"; shift ;;
    --level)          LEVEL="$2"; shift ;;
    --projects-root)  PROJECTS_ROOT="$2"; shift ;;
    --research-root)  RESEARCH_ROOT="$2"; shift ;;
    --staging)        STAGING_ROOT="$2"; shift ;;
    --inventory)      INVENTORY="$2"; shift ;;
    -h|--help)        usage; exit 0 ;;
    -*)               echo "Unknown option: $1 (see --help)" >&2; exit 2 ;;
    *)                POSITIONAL+=("$1") ;;
  esac
  shift
done

log() { printf '[%s] %s\n' "$(date +%T)" "$*"; }
die() { log "ERROR: $*"; exit 1; }

# ---------------------------------------------------------------- prerequisites
hint() {
  case "$1" in
    az)        echo "Azure CLI. Install with 'uv tool install azure-cli' (if that fails, add '--prerelease allow')
               or 'pip install --user azure-cli'. If it is installed but not found, its folder is not
               on your PATH (for uv: run 'uv tool update-shell' and open a new shell)." ;;
    azcopy)    echo "AzCopy v10. Try 'module load azcopy', or download from https://aka.ms/downloadazcopy-v10-linux,
               unpack it, and copy the 'azcopy' file into a folder on your PATH (e.g. ~/bin)." ;;
    pigz)      echo "Parallel gzip. Try 'module load pigz' or 'conda install -c conda-forge pigz', or ask HPC admins." ;;
    *)         echo "Standard Linux tool; ask HPC admins." ;;
  esac
}
check_tools() {  # check_tools <tool>... ; returns 1 if any is missing
  local missing=0 t
  for t in "$@"; do
    if command -v "$t" >/dev/null 2>&1; then
      printf '  OK       %-10s %s\n' "$t" "$(command -v "$t")"
    else
      printf '  MISSING  %-10s %s\n' "$t" "$(hint "$t")"; missing=1
    fi
  done
  return $missing
}
PACK_TOOLS=(tar pigz sha256sum openssl base64 find awk du)
UPLOAD_TOOLS=(az azcopy)

if [[ "$MODE" == check ]]; then
  echo "Needed to build tarballs:"; ok=0; check_tools "${PACK_TOOLS[@]}" || ok=1
  echo "Needed to upload:";         check_tools "${UPLOAD_TOOLS[@]}" || ok=1
  if command -v az >/dev/null 2>&1; then
    if az account show >/dev/null 2>&1; then echo "  OK       Azure login as $(az account show --query user.name -o tsv)"
    else echo "  NOT LOGGED IN  run: az login --use-device-code"; ok=1; fi
  fi
  exit $ok
fi

[[ ${#POSITIONAL[@]} -eq 2 ]] || { usage >&2; exit 2; }
PROJECT="${POSITIONAL[0]}"
OWNER="${POSITIONAL[1]}"
STAGING="$STAGING_ROOT/$PROJECT"
INVENTORY="${INVENTORY:-$STAGING_ROOT/inventory.csv}"
DATE="$(date +%F)"
DELETE_AFTER="$(date -d '+10 years' +%F)"

check_tools "${PACK_TOOLS[@]}" >/dev/null || { check_tools "${PACK_TOOLS[@]}"; die "missing programs (see above)"; }

# Folders/files that are always left out (matched by name, at any depth).
DEFAULT_EXCLUDES=(.venv '.venv.*' __pycache__ .ruff_cache .pytest_cache .ipynb_checkpoints
  .cache dask-logs .nextflow '.nextflow.log*' wandb libpod .containers 'slurm-*.out' 'dcgm-gpu-stats-*.out')
TAR_EXCLUDES=()
for x in "${DEFAULT_EXCLUDES[@]}"; do TAR_EXCLUDES+=(--exclude="$x"); done
for x in "${EXTRA_EXCLUDES[@]}";   do TAR_EXCLUDES+=(--exclude="$x"); done

# ---------------------------------------------------------------- checks + symlink audit
SRC="$PROJECTS_ROOT/$PROJECT"
[[ -d "$SRC" ]] || die "$SRC not found (use --projects-root if the project lives elsewhere)"
[[ -f "$SRC/ARCHIVE.md" ]] || die "$SRC/ARCHIVE.md is missing; write it first (template: https://github.com/rendeirolab/lab-manual/blob/main/source/data_archiving.md)"

ROOTS=("$PROJECTS_ROOT")
# A matching folder under --research-root is packed too, unless it is just a symlink.
if [[ -d "$RESEARCH_ROOT/$PROJECT" && ! -L "$RESEARCH_ROOT/$PROJECT" ]]; then
  ROOTS+=("$RESEARCH_ROOT")
fi

mkdir -p "$STAGING"
log "Looking for symlinks that point outside the project"
: > "$STAGING/external_symlinks.txt"
# A link is external if its fully resolved target is outside <project> under both roots
# (so relative links and symlinked roots are handled too).
IN1=$(readlink -m "$PROJECTS_ROOT/$PROJECT"); IN2=$(readlink -m "$RESEARCH_ROOT/$PROJECT")
inside() { [[ $1 == "$IN1" || $1 == "$IN1"/* || $1 == "$IN2" || $1 == "$IN2"/* ]]; }
for root in "${ROOTS[@]}"; do
  args=("$root/$PROJECT" '(')
  for x in "${DEFAULT_EXCLUDES[@]}"; do args+=(-name "$x" -o); done
  args+=(-false ')' -prune -o)
  for x in "${EXTRA_EXCLUDES[@]}"; do args+=(-path "$root/$x" -prune -o); done
  args+=(-type l -print0)
  find "${args[@]}" 2>/dev/null | while IFS= read -r -d '' link; do
    inside "$(readlink -m -- "$link")" || printf '%s -> %s\n' "$link" "$(readlink -- "$link")"
  done >> "$STAGING/external_symlinks.txt" || true
done
n_ext=$(wc -l < "$STAGING/external_symlinks.txt")
log "$n_ext links point outside the project. Only the links are archived, not the data they point to."
log "  List: $STAGING/external_symlinks.txt  (mention this data in ARCHIVE.md)"

if [[ "$MODE" == dry-run ]]; then
  for root in "${ROOTS[@]}"; do
    log "Size of $root/$PROJECT (largest last):"
    du -sh --apparent-size "$root/$PROJECT"/* "$root/$PROJECT"/.[!.]* 2>/dev/null | sort -h
  done
  exit 0
fi

# ---------------------------------------------------------------- package
# make_tarball <root> <tarball> <member>...
# One pass writes the tarball; a second, parallel pass lists it (which also tests it)
# and computes SHA-256 and MD5. Unfinished files end in .part and are rebuilt next time.
make_tarball() {
  local root=$1 tb=$2; shift 2
  TARBALLS+=("$tb")
  if [[ -s "$tb" && -s "$tb.filelist.txt" && -s "$tb.sha256" && -s "$tb.md5" ]]; then
    log "Reusing $(basename "$tb")"; return
  fi
  log "Packing $* -> $(basename "$tb")"
  tar -C "$root" "${TAR_EXCLUDES[@]}" "${SPLIT_EXCLUDES[@]}" -cf - "$@" \
    | pigz -"$LEVEL" -p "$THREADS" > "$tb.part"
  log "Testing $(basename "$tb") and computing checksums"
  ( pigz -dc "$tb.part" | tar -tvf - > "$tb.filelist.txt.part" ) & local p1=$!
  ( sha256sum < "$tb.part" | awk -v n="./$(basename "$tb")" '{print $1"  "n}' > "$tb.sha256.part" ) & local p2=$!
  ( openssl dgst -md5 -binary < "$tb.part" | base64 > "$tb.md5.part" ) & local p3=$!
  wait $p1 || die "$tb is damaged (could not be read back)"
  wait $p2 || die "checksum failed for $tb"
  wait $p3 || die "checksum failed for $tb"
  mv "$tb.part" "$tb"
  for x in filelist.txt sha256 md5; do mv "$tb.$x.part" "$tb.$x"; done
}

TARBALLS=()
for root in "${ROOTS[@]}"; do
  tag=$([[ "$root" == "$PROJECTS_ROOT" ]] && echo nobackup || echo research)
  # Each sub-folder of a --split folder gets its own tarball. Everything else, including
  # files directly in the --split folder, stays in the main tarball.
  SPLIT_EXCLUDES=(); SPLIT_MEMBERS=()
  for d in "${SPLIT_DIRS[@]}"; do
    for child in "$root/$PROJECT/$d"/*/; do
      [[ -d "$child" ]] || continue   # folder missing, or no sub-folders
      m="$d/$(basename "$child")"
      SPLIT_MEMBERS+=("$m"); SPLIT_EXCLUDES+=(--exclude="$PROJECT/$m")
    done
  done
  make_tarball "$root" "$STAGING/$PROJECT.$tag.tar.gz" "$PROJECT"
  SPLIT_EXCLUDES=()
  for m in "${SPLIT_MEMBERS[@]}"; do
    make_tarball "$root" "$STAGING/$PROJECT.$tag.${m//\//-}.tar.gz" "$PROJECT/$m"
  done
done

( cd "$STAGING" && cat ./*.tar.gz.sha256 > SHA256SUMS )
cp "$SRC/ARCHIVE.md" "$STAGING/ARCHIVE.md"
total=$(du -ch --apparent-size "${TARBALLS[@]}" | tail -1 | cut -f1)
if [[ "$MODE" == package ]]; then
  log "Done packing: ${#TARBALLS[@]} tarball(s), $total, in $STAGING"
  log "Next: run the same command again without --package-only to upload."
  exit 0
fi

# ---------------------------------------------------------------- upload
[[ -n "$ACCOUNT" ]] || die "no storage account given (use --account NAME or set STORAGE_ACCOUNT)"
check_tools "${UPLOAD_TOOLS[@]}" >/dev/null || { check_tools "${UPLOAD_TOOLS[@]}"; die "missing programs (see above)"; }
az account show >/dev/null 2>&1 || die "not logged in to Azure; run: az login --use-device-code"
# Stop now, not after the upload, if the inventory cannot be updated at the end.
inv=$INVENTORY; [[ -e "$inv" ]] || inv=$(dirname "$INVENTORY")
[[ -w "$inv" ]] || die "cannot write to $inv (ask HPC admins to make it group-writable)"
export AZCOPY_AUTO_LOGIN_TYPE=AZCLI   # AzCopy reuses the 'az login' session
BLOB_URL="https://$ACCOUNT.blob.core.windows.net"

META="project=$PROJECT;owner=$OWNER;archived_by=$USER;archive_date=$DATE;delete_after=$DELETE_AFTER"
for tb in "${TARBALLS[@]}"; do
  log "Uploading $(basename "$tb") to archive/$PROJECT/ (Archive tier)"
  azcopy copy "$tb" "$BLOB_URL/archive/$PROJECT/$(basename "$tb")" \
    --block-blob-tier Archive --put-md5 --metadata "$META" --overwrite false
done
# ---------------------------------------------------------------- verify
for tb in "${TARBALLS[@]}"; do
  name="$PROJECT/$(basename "$tb")"
  read -r remote_md5 tier < <(az storage blob show --auth-mode login --account-name "$ACCOUNT" \
    -c archive -n "$name" --query "[properties.contentSettings.contentMd5, properties.blobTier]" -o tsv | paste - -)
  local_md5=$(cat "$tb.md5")
  [[ "$local_md5" == "$remote_md5" ]] || die "MD5 mismatch for $name (local $local_md5, Azure $remote_md5). Do not delete anything; ask for help."
  log "OK $name  md5=$local_md5  tier=$tier"
done

# ---------------------------------------------------------------- manifests
# After the check above, so a failed or repeated archive never overwrites the manifests of an existing one.
log "Uploading ARCHIVE.md, checksums and file lists to manifests/$PROJECT/"
azcopy copy "$STAGING/*" "$BLOB_URL/manifests/$PROJECT/" \
  --include-pattern 'ARCHIVE.md;SHA256SUMS;*.filelist.txt;external_symlinks.txt' \
  --block-blob-tier Cool --put-md5 --overwrite true

# ---------------------------------------------------------------- inventory
[[ -f "$INVENTORY" ]] || echo "project,owner,archived_by,archive_date,delete_after,bytes,blobs,external_symlinks,account" > "$INVENTORY"
bytes=$(du -cb --apparent-size "${TARBALLS[@]}" | tail -1 | cut -f1)
echo "$PROJECT,$OWNER,$USER,$DATE,$DELETE_AFTER,$bytes,${#TARBALLS[@]},$n_ext,$ACCOUNT" >> "$INVENTORY"
log "All done: ${#TARBALLS[@]} file(s), $total, archived. Inventory: $INVENTORY"
log "The local tarballs are still in $STAGING. Delete them (and the project) only after sign-off."
