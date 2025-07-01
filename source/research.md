# Research

## Project life cycle

### Initializing a project

1. Register your project in the lab's project register:
   1. Go to [https://cemmat.sharepoint.com/sites/rendeirolab](https://cemmat.sharepoint.com/sites/rendeirolab) and find the 'Lab project register.xlsx' or directly [here](https://cemmat.sharepoint.com/:x:/r/sites/rendeirolab/\_layouts/15/Doc.aspx?sourcedoc=%7B4c72f84b-f33b-4162-a5e8-f05556fdf66b%7D&action=editnew).
   1. Start a new row for your project and increment the `Project ID` by one.
   1. Choose an intuitive name for the project, avoiding adding personal information e.g. collaborator names.
1. Create a project directory structure from the lab's template: `cookiecutter gh:rendeirolab/_project_template`
1. Create a git repository on GitHub ([https://github.com/rendeirolab](https://github.com/rendeirolab)) with the same name as the project, make a first commit and push to Github.
1. Create a directory for the project in the CeMM cluster at: `/research/groups/lab_rendeiro/projects/`
   1. Create a directory inside called `data` to store raw data.
1. Create a directory for the project in the CeMM cluster at: `/nobackup/groups/lab_rendeiro/projects/`
   1. Create a soft link between `/research/.../data` and `/nobackup/.../data`
1. Create a `cemm_metadata.json` file in `/research/groups/lab_rendeiro/projects/$PROJECT/`
1. Create a `cemm_metadata.json` file in `/nobackup/groups/lab_rendeiro/projects/$PROJECT/`

You can find various metadata JSON templates at `/research/groups/lab_rendeiro/projects/_templates/`.

Make sure to validate your JSON files, e.g.:

```bash
wget --no-check-certificate https://metadata.int.cemm.at/latest/cemm_metadata_schema.json
uvx check-jsonschema --schemafile cemm_metadata_schema.json cemm_metadata.json 
```

### Developing a project

See the [Project Planning](project_planning.md) section for conceptual details on how to design and develop a project.

From a practical standpoint, also refeer to the lab's [Project Template](https://github.com/rendeirolab/_project_template) for instructions on how to set up a project repository, and how to structure your project files.

### Project management

- Make sure to maintain the `cemm_metadata.json` files in line with the existing data on disk.
- Version control: Use `git` for all code and analysis scripts. Commit frequently with descriptive messages.
- Naming conventions: Adhere to consistent and descriptive naming conventions for files and directories to ensure clarity and ease of access.
- File organization: Maintain a clear and logical directory structure for each project, separating raw data, processed data, scripts, results, and documentation.
- Data backup: Backup only original data, or timestamped versions of processed data. Use the CeMM cluster's `/research/groups/lab_rendeiro/projects/$PROJECT` directory for this purpose.

### Reporting research

Figures are the core of communicating reserach:
- Figures are crucial for communicating research. We encourage lab members to:
- Conceptualize figures early: Sketch potential figures during project development to visualize your story and refine experimental design. This "Figure Zero" mentality focuses work on key data that supports your narrative.
- Assemble figures often: Don't wait until the end. Assemble plots into draft figures iteratively as data comes in. This helps identify gaps, maintain quality, and keeps publication as the ultimate goal.
- Leverage vector graphics: Figures created as vector graphics (SVG, PDF) are highly versatile. They scale without resolution loss and can be reused efficiently across publications, presentations, grants, and posters, saving significant time.

PowerPoint, often due to misuse, can be detrimental to effective communication by:
- Enforcing rigid structure: Its linear format can oversimplify complex ideas, losing nuance.
- Encouraging style over substance: Time is often spent on aesthetics rather than refining the core message.
- "Death by PowerPoint": Poorly constructed slides can bore and disengage the audience.

By focusing on making figures proactively and using them to communicate (instead of PowerPoint), you'll develop your skills of visual story telling, enable you to tailor your analysis more directly to the a final figure plant and accelerate the path to publication.

## Tools and technologies of standard use within the lab

### File types of digital data

Below are the preferred types of technology to be used in the lab to ensure consistency and efficiency:

- Documentation: Markdown (for manuals, READMEs, lab notebooks)
- Programming language: Python (primary language for data analysis and scripting)
- Image files: OME-TIFF (for high-resolution images with extensive metadata support)
- Tabular form files: CSV (or csv.gz), Parquet (for efficient storage and retrieval of tabular data)
- Plots: SVG, PDF (for vector graphics that scale without pixelation)

## Engaging in new projects

Be receptive to input and suggestions from others on collaborating and engaging in new projects.

However, a careful balance between finishing existing projects and starting new ones is crucial. 

Consult with Andre before committing to new projects, especially if they involve significant time investment or resources. 


## Meta-science

- The Night Science Series ([https://night-science.org/genome-biology-miniseries/](https://night-science.org/genome-biology-miniseries/))
- The Night Science Podcast ([https://night-science.org/the-night-science-podcast/](https://night-science.org/the-night-science-podcast/))
- The importance of stupidity in scientific research ([https://doi.org/10.1242/jcs.033340](https://doi.org/10.1242/jcs.033340))
- Parachute use to prevent death and major trauma when jumping from aircraft: randomized controlled trial ([http://dx.doi.org/10.1136/bmj.k5094](http://dx.doi.org/10.1136/bmj.k5094))
