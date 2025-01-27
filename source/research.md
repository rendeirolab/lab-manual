# Research

## Project life cycle

### Initializing a project

1. Register your project in the lab's project register:
   1. Go to https://cemmat.sharepoint.com/sites/rendeirolab and find the 'Lab project register.xlsx' or directly at https://cemmat.sharepoint.com/:x:/r/sites/rendeirolab/\_layouts/15/Doc.aspx?sourcedoc=%7B4c72f84b-f33b-4162-a5e8-f05556fdf66b%7D&action=editnew
   1. Start a new row for your project and increment the `Project ID` by one.
   1. Choose an intuitive name for the project, avoiding adding personal information e.g. collaborator names.
1. Create a project directory structure from the lab's template: `cookiecutter gh:rendeirolab/_project_template`
1. Create a git repository on GitHub (https://github.com/rendeirolab) with the same name as the project, make a first commit and push to Github.
1. Create a directory for the project in the CeMM cluster at: `/research/groups/lab_rendeiro/projects/`
   1. Create a directory inside called `data` to store raw data.
1. Create a directory for the project in the CeMM cluster at: `/nobackup/groups/lab_rendeiro/projects/`
   2\. Create a soft link between `/research/.../data` and `/nobackup/.../data`
1. Create a `cemm_metadata.json` file in `/research/groups/lab_rendeiro/projects/$PROJECT/`
1. Create a `cemm_metadata.json` file in `/nobackup/groups/lab_rendeiro/projects/$PROJECT/`

You can find various metadata JSON templates at `/research/groups/lab_rendeiro/projects/_templates/`.

Make sure to validate your JSON files, e.g.:

```bash
# pip install jsonvalidate
wget http://metadata.int.cemm.at/latest/cemm_metadata_schema.json
jsonvalidate -i cemm_metadata.json cemm_metadata_schema.json
```

### Developing a project

> [!CAUTION]
> TODO

### Maintaining files for a project

Make sure to maintain your metadata JSON files, in line with the existing data on disk.

### Reporting research

No powerpoint!

#### Publications

> [!CAUTION]
> TODO

#### Authorship

> [!CAUTION]
> TODO

## Tools and technologies of standard use within the lab

### File types of digital data

Below are the preferred types of technology to be used in the lab:

- documentation: Markdown
- programming language: Python
- image files: OME-TIFF
- tabular form files: CSV (or csv.gz), Parquet
- plots: SVG, PDF

## Engaging in new projects

> [!CAUTION]
> TODO

## Meta-science

- The Night Science Series (https://night-science.org/genome-biology-miniseries/)
- The Night Science Podcast (https://night-science.org/the-night-science-podcast/)
- The importance of stupidity in scientific research (https://doi.org/10.1242/jcs.033340)
- Parachute use to prevent death and major trauma when jumping from aircraft: randomized controlled trial (http://dx.doi.org/10.1136/bmj.k5094)
