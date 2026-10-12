#!/usr/bin/env bash
# Regression test for archive_project.sh: runs --package-only on a throwaway project.
# Needs the same GNU tools as the script. Run it on the cluster: bash scripts/test_archive_project.sh
set -euo pipefail
here=$(cd "$(dirname "$0")" && pwd)
tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
P=$tmp/projects R=$tmp/research S=$tmp/staging

mkdir -p "$P"/proj/{code,results/exp1,results/.hidden} "$P/proj2" "$R/proj/data" "$tmp/outside"
echo test > "$P/proj/ARCHIVE.md"
touch "$P/proj/code/a.py" "$P/proj/results/summary.csv" "$P/proj/results/exp1/a" \
      "$P/proj/results/.hidden/b" "$R/proj/data/raw"
ln -s "$R/proj/data" "$P/proj/data"               # into the project (other root): not external
ln -s ../results/exp1 "$P/proj/code/inside_rel"   # relative, stays inside: not external
ln -s "$tmp/outside" "$P/proj/abs_out"            # absolute, leaves the project: external
ln -s ../../outside "$P/proj/rel_out"             # relative, leaves the project: external
ln -s "$P/proj2" "$P/proj/sibling"                # other project, same name prefix: external

bash "$here/archive_project.sh" --package-only --split results \
  --projects-root "$P" --research-root "$R" --staging "$S" proj me@example.org > "$tmp/log" 2>&1 \
  || { cat "$tmp/log"; exit 1; }

fail=0
files=$(cat "$S"/proj/*.filelist.txt)
for f in code/a.py results/summary.csv results/exp1/a results/.hidden/b data/raw; do
  grep -q "$f" <<<"$files" || { echo "FAIL: $f is in no tarball"; fail=1; }
done
ext=$(cat "$S/proj/external_symlinks.txt")
for l in abs_out rel_out sibling; do
  grep -q "/proj/$l ->" <<<"$ext" || { echo "FAIL: $l not listed as external"; fail=1; }
done
for l in /proj/data inside_rel; do
  ! grep -q "$l ->" <<<"$ext" || { echo "FAIL: $l wrongly listed as external"; fail=1; }
done

# Upload flow with stub az/azcopy (no Azure): they only record calls and echo the local md5.
bin=$tmp/bin; calls=$tmp/calls; mkdir -p "$bin"
cat > "$bin/azcopy" <<'EOF'
#!/usr/bin/env bash
echo "$*" >> "$CALLS"
EOF
cat > "$bin/az" <<'EOF'
#!/usr/bin/env bash
name=; args=("$@")
for i in "${!args[@]}"; do [[ ${args[$i]} == -n ]] && name=${args[$((i+1))]}; done
if [[ $name ]]; then   # az storage blob show -n NAME: md5 and tier of the uploaded blob
  if [[ -n ${BAD_MD5:-} ]]; then echo wrongmd5; else cat "$STAGING_DIR/$name.md5"; fi
  echo Archive
fi
EOF
chmod +x "$bin/az" "$bin/azcopy"
upload() {
  : > "$calls"
  PATH=$bin:$PATH CALLS=$calls STAGING_DIR=$S USER=${USER:-tester} \
    bash "$here/archive_project.sh" --account fake --staging "$S" --projects-root "$P" \
    --research-root "$R" --split results proj me@example.org > "$tmp/log" 2>&1
}

touch "$S/inventory.csv"; chmod a-w "$S/inventory.csv"   # 1. inventory not writable: upload nothing
if upload; then echo "FAIL: ran with unwritable inventory"; fail=1; fi
[[ ! -s $calls ]] || { echo "FAIL: uploaded although inventory is not writable"; fail=1; }
chmod u+w "$S/inventory.csv"

if BAD_MD5=1 upload; then echo "FAIL: md5 mismatch not detected"; fail=1; fi   # 2. md5 mismatch
! grep -q manifests "$calls" || { echo "FAIL: manifests uploaded despite md5 mismatch"; fail=1; }
! grep -q '^proj,' "$S/inventory.csv" || { echo "FAIL: inventory line despite md5 mismatch"; fail=1; }

upload || { echo "FAIL: upload run failed"; cat "$tmp/log"; fail=1; }   # 3. normal run
[[ $(grep -c archive/proj/ "$calls") == 3 ]] || { echo "FAIL: expected 3 tarball uploads"; fail=1; }
tail -1 "$calls" | grep -q manifests/proj/ || { echo "FAIL: manifests not uploaded last"; fail=1; }
grep -q '^proj,me@example.org,' "$S/inventory.csv" || { echo "FAIL: no inventory line"; fail=1; }

[[ $fail == 0 ]] && echo PASS
exit $fail
