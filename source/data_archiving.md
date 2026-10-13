# Data archiving

How to archive a finished or stale lab project to the lab's Azure storage, and how to get it back.
Use it when a project ends (see [research](research.md)) or when someone leaves the lab (see [offboarding](offboarding.md)).

> Last update: October 2026.
> Names, versions and links may have changed since then. If something here does not match what you see, ask the PI or CeMM IT.

**Archive details**

|                               |                                                                                                                |
| ----------------------------- | -------------------------------------------------------------------------------------------------------------- |
| Storage account               | `strendeiroarchive` (resource group `rg-rendeiro-archive`, subscription "Rendeiro Dev")                        |
| Archive script                | [`scripts/archive_project.sh`](https://github.com/rendeirolab/lab-manual/blob/main/scripts/archive_project.sh) |
| Staging folder on the cluster | `/nobackup/lab_rendeiro/archive_staging/` (tarballs and `inventory.csv`)                                       |
| Who can give access           | PI (André Rendeiro) or CeMM IT                                                                                 |

## Before you start (once per person)

1. **Ask for access.** Ask the PI or IT for the role **Storage Blob Data Contributor** on the resource group **rg-rendeiro-archive**.

1. **Use the right network.** Uploads and downloads only work from the CeMM cluster or a CeMM office computer, not from home or VPN.

1. **Get the script.** Save it in your home folder and run it from there. It works with absolute paths, so it does not matter where your project is.

   ```bash
   cd ~
   curl -fsSLO https://raw.githubusercontent.com/rendeirolab/lab-manual/main/scripts/archive_project.sh
   chmod +x archive_project.sh
   ./archive_project.sh --help
   ```

1. **Check that the needed programs are installed:**

   ```bash
   ./archive_project.sh --check
   ```

   Install anything marked `MISSING`. The script prints a hint for each:

   | Program                                 | What it's for              | How to get it                                                                                                                                                                   |
   | --------------------------------------- | -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
   | `az` (Azure CLI)                        | login and checking uploads | `uv tool install azure-cli` (if that fails, add `--prerelease allow`), or `pip install --user azure-cli`                                                                        |
   | `azcopy` (v10)                          | uploading and downloading  | `module load azcopy` if the cluster has it, otherwise download from <https://aka.ms/downloadazcopy-v10-linux> and put the `azcopy` file in a folder on your PATH (e.g. `~/bin`) |
   | `pigz`                                  | fast compression           | usually installed; otherwise `module load pigz`, `conda install -c conda-forge pigz`, or ask HPC admins                                                                         |
   | `tar`, `sha256sum`, `openssl`, `base64` | packing and checksums      | standard on Linux                                                                                                                                                               |

   If a program is installed but `--check` still says `MISSING`, the shell can't find it because its folder is not on your `PATH`. After a `uv` install, run `uv tool update-shell` and open a new terminal.

1. **Log in to Azure.** Open the link it prints and enter the code:

   ```bash
   az login --use-device-code
   az account set --subscription "Rendeiro Dev"
   export AZCOPY_AUTO_LOGIN_TYPE=AZCLI   # lets azcopy reuse this login; add the line to ~/.bashrc to keep it
   ```

   Run `./archive_project.sh --check` again; it should now say `Azure login as <you>, subscription 'Rendeiro Dev'`.

## Archive a project

The script works on projects in `/nobackup/lab_rendeiro/projects/` on the cluster. If data is only on the Hilde workstation, copy it into the project folder on the cluster first.

1. **Work on a compute node,** not the login node, inside `tmux` or `screen` so a dropped connection does not stop the work. Example (partition names may differ):

   ```bash
   srun -p interactiveq -c 16 --mem 16G -t 12:00:00 --pty bash
   ```

   For very large projects (several TB), use the `sbatch` example in step 7 instead.

1. **Push your code.** Commit and push everything to GitHub, then check:

   ```bash
   git -C /nobackup/lab_rendeiro/projects/<project> status -sb
   ```

   It should list no changed files and show no `[ahead N]` next to the branch name.

1. **Write `ARCHIVE.md`** in the project folder using the [template](#template-for-the-archive-description) at the end of this page.

1. **Look at the project:**

   ```bash
   ./archive_project.sh --dry-run <project> <owner-email>
   ```

   `<project>` is the folder name in `/nobackup/lab_rendeiro/projects/` (no spaces), not a path. `<owner-email>` is the email of the person responsible for the data.

   This prints folder sizes and counts the links that point to data outside the project. The links are listed in `/nobackup/lab_rendeiro/archive_staging/<project>/external_symlinks.txt`. That data is not archived, so mention it in `ARCHIVE.md`.

1. **Decide what to leave out.** Always left out: `.venv`, caches, SLURM logs, `wandb/` (local W&B run files), `.nextflow` and Podman folders (`./archive_project.sh --help` has the full list). The `.git` folder is kept. You decide on the rest, for example:

   - public data you can download again (TCGA, CAMELYON, …)
   - other labs' data
   - temporary copies that can be regenerated

   Write down what you leave out in `ARCHIVE.md`. If the project has personal or clinical data, ask the PI before you archive it, and say so in `ARCHIVE.md`.

1. **Build the tarballs** (nothing is uploaded yet):

   ```bash
   ./archive_project.sh --package-only [options] <project> <owner-email>
   ```

   Options you may want:

   | Option              | When to use it                                                                                                                                                                            | Example                        |
   | ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------ |
   | `--exclude PATTERN` | Leave out a folder. The pattern starts with the project name and may use `*`. Repeat for several.                                                                                         | `--exclude 'myproj/data/tcga'` |
   | `--split DIR`       | Big projects: one tarball per sub-folder of `DIR` (e.g. per experiment), so you can later restore one part. Files directly in `DIR` stay in the main tarball. Repeat for several folders. | `--split results`              |
   | `--level 1`         | Faster compression. Works well for image data.                                                                                                                                            |                                |
   | `--threads N`       | Use more CPUs (default 8). Match what you requested from SLURM.                                                                                                                           | `--threads 16`                 |

   You get one tarball for the `/nobackup` folder (`<project>.nobackup.tar.gz`) and, if `/research/lab_rendeiro/projects/<project>` is a real folder (not a link), one for it too (`<project>.research.tar.gz`). They are written to `/nobackup/lab_rendeiro/archive_staging/<project>/`, which needs about as much free space as the project.

   If the run stops partway, run the same command again; finished tarballs are reused. This also means that changed options are ignored for finished tarballs: to rebuild with other options, delete that folder first.

1. **Upload.** Run the **same command with the same options** again, but without `--package-only` and with the storage account:

   ```bash
   ./archive_project.sh --account strendeiroarchive [same options] <project> <owner-email>
   ```

   At the end, each file should show `OK ... tier=Archive`. If you see `MD5 mismatch`, stop, do not delete anything, and ask for help.

   An archive is never overwritten, so a project name can be archived only once. To archive the same project again, ask the PI or IT to move or delete the old archive first.

   For very large projects (several TB), run steps 6 and 7 as one job. The script packs, then uploads:

   ```bash
   sbatch -p <partition> -c 16 --mem 16G -t <time-limit> \
     --wrap "$HOME/archive_project.sh --threads 16 --account strendeiroarchive [options] <project> <owner-email>"
   ```

1. **Record it.** Check that the script added your project to the inventory:

   ```bash
   grep <project> /nobackup/lab_rendeiro/archive_staging/inventory.csv
   ```

   Then mark the project as archived in the Lab Project Registry (see [record keeping](record_keeping.md)) and tell the PI and your Data Management representative that the project is archived. Deleting the project also deletes its `cemm_metadata.json` files.

1. **Clean up only after the PI agrees, and at least 7 days after upload.** First check the manifest (see [Look inside an archive](#look-inside-an-archive)). Then check that these are the right folders and delete them:

   ```bash
   ls -d /nobackup/lab_rendeiro/archive_staging/<project> /nobackup/lab_rendeiro/projects/<project> /research/lab_rendeiro/projects/<project>
   rm -rf /nobackup/lab_rendeiro/archive_staging/<project>
   rm -rf /nobackup/lab_rendeiro/projects/<project>
   rm -rf /research/lab_rendeiro/projects/<project>     # if it exists
   ```

## Look inside an archive

This is quick and very cheap. It needs the login and subscription from "Before you start".

```bash
azcopy copy "https://strendeiroarchive.blob.core.windows.net/manifests/<project>/*" ./<project>-manifest/ --recursive
```

Open `ARCHIVE.md`, the `*.filelist.txt` files (what is in each tarball) and `external_symlinks.txt` (data that was not archived). You can also browse the **manifests** container in the Azure portal from a CeMM office computer.

## Get a project back

This needs the login and subscription from "Before you start".

1. **Find the tarball name** you need in the file list (see [Look inside an archive](#look-inside-an-archive)). Names look like `<project>.nobackup.tar.gz`, `<project>.research.tar.gz` or, for `--split`, `<project>.nobackup.<DIR>-<subfolder>.tar.gz`. By lab convention the `data` folder lives under `/research` and is only linked from `/nobackup`, so you need the `research` tarball to get the data.
1. **Request it.** This takes up to 15 hours:
   ```bash
   az storage blob copy start --auth-mode login --account-name strendeiroarchive \
     --source-container archive --source-blob "<project>/<tarball>" \
     --destination-container restore --destination-blob "<project>/<tarball>" \
     --tier Hot --rehydrate-priority Standard
   ```
1. **Check if it's ready.** Repeat every few hours until it says `success`:
   ```bash
   az storage blob show --auth-mode login --account-name strendeiroarchive \
     -c restore -n "<project>/<tarball>" --query properties.copy.status -o tsv
   ```
1. **Download and unpack** in the folder where the project should live (`/nobackup/lab_rendeiro/projects/`, or `/research/lab_rendeiro/projects/` for the `research` tarball). The tarball contains a top-level `<project>/` folder.
   ```bash
   azcopy copy "https://strendeiroarchive.blob.core.windows.net/restore/<project>/<tarball>" ./
   tar -I pigz -xf <tarball>
   ```
   To check the download, copy `SHA256SUMS` from the manifest next to the tarball and run `sha256sum -c --ignore-missing SHA256SUMS`.

The copy in `restore` deletes itself after 14 days, and the archive itself is never changed.

## When someone leaves the lab

See also the checklist for the PI in [offboarding](offboarding.md).

1. Before they leave, they archive their finished or stale projects (see [Archive a project](#archive-a-project)).
1. Ask IT to remove their **Storage Blob Data Contributor** role.
1. Update the owner in `inventory.csv` if needed.
1. Ask HPC admins to transfer ownership of their cluster folders to the new owner.

## Things that happen automatically

- Archives are **deleted 10 years after upload**.
- Files deleted by mistake can be recovered for **30 days**. Ask IT.

## Template for the archive description

Save this as `ARCHIVE.md` in the project folder:

```markdown
# <project>
- Owner: <name, email>
- Archived by: <name>, <date>
- What it is: <2–3 sentences>
- Papers: <DOI or "none">
- Code: <GitHub link + commit>
- What's included: <folders, sizes>
- What's left out and why: <e.g. data/tcga — public, can be downloaded again>
- Data stored elsewhere (not archived): <paths, who owns it>
- Personal/clinical data?: <yes/no, ethics reference; ask the PI before archiving such data>
- How to rerun: <short instructions>
```
