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

On the CeMM cluster, use **Podman** for directory isolation (not speed): mount project `data` **read-only**, write only under `/nobackup/.../results`, and do **not** mount `$HOME`. The job script loads Podman (`module load podman`). For partitions, QoS, and GPUs, use the [CeMM cluster documentation](https://cemmat.sharepoint.com/sites/IT-Resources); `tinyq` in the examples is CPU-only.

Scripts: [`examples/podman/01_bash.sbatch`](examples/podman/01_bash.sbatch) (`python:3.12-slim`), [`examples/podman/02_lazyslide.sbatch`](examples/podman/02_lazyslide.sbatch) (`ghcr.io/rendeirolab/lazyslide:v0.12.0`). Keep [`extract.py`](examples/podman/extract.py) next to `02_lazyslide.sbatch`. Submit **from that directory** so Slurm finds the files (`#SBATCH --output` and `extract.py` use the submit dir). `DATA` must already exist; `OUT` is created.

```bash
cd source/examples/podman   # or copy the three files somewhere on the cluster

PROJECT=my_project
DATA=/research/lab_rendeiro/projects/${PROJECT}/data
OUT=/nobackup/lab_rendeiro/projects/${PROJECT}/results/container-demo

sbatch --export=ALL,DATA="$DATA",OUT="$OUT" 01_bash.sbatch
sbatch --export=ALL,DATA="$DATA",OUT="$OUT" 02_lazyslide.sbatch

# Optional: a slide under DATA (path inside the container is /data/...)
# sbatch --export=ALL,DATA="$DATA",OUT="$OUT",SLIDE=/data/slide.svs 02_lazyslide.sbatch
```

Without `SLIDE`, LazySlide runs `zs.datasets.sample()` and writes `sample.zarr` in `OUT`. Logs: `podman-bash-<jobid>.out` and `podman-lazyslide-<jobid>.out` in the submit directory.

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
