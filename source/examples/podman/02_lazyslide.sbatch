#!/bin/bash
# DATA=/path/to/data OUT=/path/to/results sbatch --export=ALL,DATA="$DATA",OUT="$OUT" 02_lazyslide.sbatch
# Keep extract.py next to this script. Mounts: DATA:/data:ro OUT:/out:rw. $HOME is not mounted.
#SBATCH --job-name=podman-lazyslide
#SBATCH --output=podman-lazyslide-%j.out
#SBATCH --partition=tinyq
#SBATCH --qos=tinyq
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=01:00:00

set -euo pipefail
. /etc/profile.d/modules.sh
module load podman

PROJECT="${PROJECT:-CHANGE_ME}"
DATA="${DATA:-/research/lab_rendeiro/projects/${PROJECT}/data}"
OUT="${OUT:-/nobackup/lab_rendeiro/projects/${PROJECT}/results/container-demo}"
SLIDE="${SLIDE:-}"
HERE="${SLURM_SUBMIT_DIR:-$(cd "$(dirname "$0")" && pwd)}"
IMAGE="${IMAGE:-ghcr.io/rendeirolab/lazyslide:v0.12.0}"

mkdir -p "$OUT"
podman run --rm --read-only --tmpfs /tmp:rw,exec --userns=keep-id --network=host \
  -e HOME=/tmp -e TMPDIR=/tmp \
  -e HF_HOME=/tmp/hf_home -e TORCH_HOME=/tmp/torch -e XDG_CACHE_HOME=/tmp/cache \
  -e SLIDE="$SLIDE" \
  -v "$DATA:/data:ro" -v "$OUT:/out:rw" -v "$HERE/extract.py:/app/extract.py:ro" \
  "$IMAGE" \
  python /app/extract.py

echo "Host OUT=$OUT"
ls -la "$OUT"
