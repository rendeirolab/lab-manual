#!/bin/bash
# DATA=/path/to/data OUT=/path/to/results sbatch 01_bash.sbatch
# Mounts: DATA:/data:ro OUT:/out:rw. $HOME is not mounted.
#SBATCH --job-name=podman-bash
#SBATCH --output=podman-bash-%j.out
#SBATCH --partition=tinyq
#SBATCH --qos=tinyq
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=00:20:00

set -euo pipefail
. /etc/profile.d/modules.sh
module load podman

PROJECT="${PROJECT:-CHANGE_ME}"
DATA="${DATA:-/research/lab_rendeiro/projects/${PROJECT}/data}"
OUT="${OUT:-/nobackup/lab_rendeiro/projects/${PROJECT}/results/container-demo}"
IMAGE="${IMAGE:-docker.io/library/python:3.12-slim}"

mkdir -p "$OUT"
podman run --rm --read-only --tmpfs /tmp:rw,exec --userns=keep-id --network=host \
  -e HOME=/tmp -v "$DATA:/data:ro" -v "$OUT:/out:rw" "$IMAGE" \
  bash -c '
    set -euo pipefail
    echo "PWD=$(pwd) HOME=$HOME hostname=$(hostname)"
    echo "=== /data (read-only) ==="
    ls -la /data
    date -u +"started %Y-%m-%dT%H:%M:%SZ" > /out/timestamp.txt
    first=$(find /data -maxdepth 1 -type f | head -n 1 || true)
    [[ -n "$first" ]] && cp -a "$first" /out/copied_input
    { echo "id=$(id)"; echo "HOME=$HOME"; echo "ls /data:"; ls -la /data; } > /out/log.txt
    echo "only in container" > /tmp/container_only.txt
    echo "wrote /tmp/container_only.txt inside the container (will not appear on the host)"
    ls -la /out
  '

echo "Host OUT=$OUT"
ls -la "$OUT"
echo "Host /tmp/container_only.txt should be absent:"
if [[ -e /tmp/container_only.txt ]]; then
  echo "  unexpected: /tmp/container_only.txt exists on the host" >&2
  exit 1
fi
echo "  (absent on host, as expected)"
