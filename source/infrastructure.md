# Lab infrastructure

This document describes the infrastructure used in the lab, including CeMM-provided or our own infrastructure.
So far it details only computational infrastructure.

## Lab infrastructure

#### Hardware

- Hilde workstation: [setting up and maintaining the hilde workstation: hilde_workstation.md](https://github.com/rendeirolab/labdocs/blob/main/hilde_workstation.md)
  - Usage can be booked through its dedicated calendar:
    - HTML: https://outlook.office365.com/owa/calendar/92e5463911e04b688330fbd26c75faab@cemm.oeaw.ac.at/7dce5f2f61f84753bca69c49a309581114314229400116418487/calendar.html
    - ICS: https://outlook.office365.com/owa/calendar/92e5463911e04b688330fbd26c75faab@cemm.oeaw.ac.at/7dce5f2f61f84753bca69c49a309581114314229400116418487/calendar.ics

#### VMs

- Cytomine: [setting up and maintaining the cytomine VM: cytomine.md](https://github.com/rendeirolab/labdocs/blob/main/cytomine.md)

#### Cloud resources

[Read the documentation on using Azure web services here: azure.md](https://github.com/rendeirolab/labdocs/blob/main/azure.md)

## CeMM infrastructure

Refer to the [CeMM Intranet documentation](https://cemmat.sharepoint.com/sites/Intranet) for updated information.
Below are a few notes on things which are not covered there:

#### Cluster containers (Podman)

On the CeMM cluster, load Podman with `module load podman`. Use the [CeMM cluster documentation](https://cemmat.sharepoint.com/sites/IT-Resources) for partitions, QoS, and GPUs; do not copy those flags from memory.

Containers are for **directory isolation**, not speed. Mount project `data` **read-only**, write only under `/nobackup/.../results`, and do **not** mount `$HOME`:

```bash
DATA=/research/lab_rendeiro/projects/$PROJECT/data \
OUT=/nobackup/lab_rendeiro/projects/$PROJECT/results/container-demo \
sbatch 01_bash.sbatch
```

Runnable copies live in [`source/examples/podman/`](examples/podman/). The bash example uses `python:3.12-slim`. The LazySlide example uses `ghcr.io/rendeirolab/lazyslide:v0.12.0` and needs [`extract.py`](examples/podman/extract.py) next to the sbatch file.

Bash (list `/data`, write only to `/out`):

```bash
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
```

LazySlide feature extraction (`resnet50`, writes a zarr store to `/out`):

```bash
#!/bin/bash
# DATA=/path/to/data OUT=/path/to/results sbatch 02_lazyslide.sbatch
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
```

#### Printing from Linux

CeMM has Canon iR-ADV C5735/5740 printers. They support IPP printing through CUPS.

Install CUPS:

```bash
sudo apt-get install cups
```

Add printers:

```bash
sudo lpadmin -p CeMM_level_2 -E -v ipp://193.171.185.37/ipp -m everywhere
sudo lpadmin -p CeMM_level_3 -E -v ipp://193.171.185.212/ipp -m everywhere
sudo lpadmin -p CeMM_level_4 -E -v ipp://193.171.185.39/ipp -m everywhere
sudo lpadmin -p CeMM_level_5 -E -v ipp://193.171.185.40/ipp -m everywhere
sudo lpadmin -p CeMM_level_6 -E -v ipp://193.171.185.38/ipp -m everywhere
sudo lpadmin -p CeMM_level_7 -E -v ipp://193.171.185.41/ipp -m everywhere
```
