# Offboarding

It is important to be aware well in advance of the procedure for offboarding and to communicate the expectations and requirements involved in it.

The PI communicates and starts the procedure, and verifies that all steps are done. If you are leaving, start as soon as your last day is known.

## Checklist for the leaving team member

### Data cleaning

Clean up, annotate, and hand over or archive your scientific data. Arrange a meeting with your Data Management representative to plan this (see the [data management intranet](https://cemmat.sharepoint.com/sites/data-management)).

Your data may be in the following places:

- CeMM HPC
- Hilde workstation
- CeMM shared folders (e.g. for photos):
  - `smb://int.cemm.at/data/media`
  - `smb://int.cemm.at/data/groupdata`
  - `smb://int.cemm.at/data/labs`
  - `smb://int.cemm.at/data/home/<CEMM_USERNAME>`
- Personal OneDrive
- Lab OneDrive

#### Code archive

Make sure all your project code is pushed to GitHub, to the project's repository in the [lab's GitHub organization](https://github.com/rendeirolab).

#### Cluster/Hilde data cleaning

1. For finished or stale projects, follow the instructions in [data archiving](data_archiving.md).
1. For ongoing projects, if you still need access to CeMM HPC, discuss it with the PI first. Then contact the Intellectual Property (IP) section and IT for specific instructions.

#### Private files

You may ask IT for a USB hard drive to back up your private files. Do not copy scientific data to private devices or private cloud storage.

Prepare the handover of your laptop or desktop computer: move all scientific data to shared storage and remove any private data.

Empty the following folders:

- Your personal OneDrive
- `smb://int.cemm.at/data/home/<CEMM_USERNAME>`
- Home directory on Hilde
- Home directory on CeMM HPC

### Computer and accounts

#### Return your computer

Return your computer to IT. If it still works, IT resets it to a clean state so it can be given to someone else. You can leave it with IT or buy it. The price is 50 EUR if the computer is more than 3 years old (as of 2026).

#### Account cleaning

Your email account is property of CeMM. It will not be transferred to you, and you will not have access to it after your employment contract ends. Delete or move private conversations, and tell collaborators and journals your new email address before you leave. Also update your email and affiliation on accounts such as ORCID and GitHub.

### Office cleaning

Empty your office desk, lab bench, freezer drawers, etc. Dispose of any chemicals, toxic materials, and confidential documents you no longer need properly.

Prepare your keys (office, lab, locker) and your magnetic card for handover.

### Records cleaning

See the [record keeping section](record_keeping.md).

- Do a final check of your lab journal(s). For any questions, contact Pedro, head of the IP section, before you return the lab journal.
- Make sure your digital notes are up to date and stored in the lab's records (see [Lab Notebooks](record_keeping.md#lab-notebooks)).
- Make sure your grants, presentations, and manuscripts are properly recorded in the lab OneDrive (see [Shared OneDrive Folder](record_keeping.md#shared-onedrive-folder)).
- Do a final check of your time recordings in SAGE, our time-tracking system.
- Hand over any documents, databases, contracts, licenses, and SOPs that are important to your colleagues.
- Leave your contact details with HR for any open legal, patent, salary, and tax issues.

## Checklist for the PI

1. Ask the departing team member for their CeMM-independent contact information.
1. Ask the departing team member whether they consent to be listed as alumni on the lab website.
1. Agree on a successor for each of their projects. Update the owner in the Lab Project Registry and the contact in the project's `cemm_metadata.json` (see [record keeping](record_keeping.md) and [research](research.md)).
1. Agree on who finishes their open manuscripts and who is the corresponding author.
1. Check with HR and IT that their CeMM accounts (email, VPN) are closed.
1. Remove the team member from:
   - Microsoft team
   - Mailing list
   - Signal group (see [communication and meetings](communication_and_meetings.md))
   - GitHub ([https://github.com/rendeirolab](https://github.com/rendeirolab))
   - Weights & Biases ([https://wandb.ai/rendeiro-group](https://wandb.ai/rendeiro-group))
   - HuggingFace ([https://huggingface.co/RendeiroLab](https://huggingface.co/RendeiroLab))
   - Lab infrastructure: Hilde workstation, Cytomine, VMs, etc. (see [infrastructure](infrastructure.md))
   - Azure data archive (see [data archiving](data_archiving.md#when-someone-leaves-the-lab))
