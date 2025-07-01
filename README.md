<div style="page-break-after: always;"></div>

# Lab manual

Welcome to the Rendeiro Lab Manual.

This manual provides comprehensive information about the lab's culture, procedures, and workflows to ensure a collaborative and efficient research environment.

The manual is hosted in the [`lab-manual`](https://github.com/rendeirolab/lab-manual/) repository on GitHub. It is written in [Markdown](https://daringfireball.net/projects/markdown/) and can be converted to HTML and PDF using [Pandoc](https://pandoc.org/).

This manual is open source and maintained collaboratively. Anyone on GitHub can propose changes.

## Building the manual

The project includes a [Makefile](https://github.com/rendeirolab/lab-manual/blob/main/Makefile) to streamline the development process.

Key targets include:

- **`format`**: Formats Markdown files consistently using `mdformat`.
- **`build`**: Converts the manual into a single HTML file using `pandoc` and generates a PDF file using `wkhtmltopdf`.
- **`clean`**: Removes generated files to ensure a fresh build.

Styling for the manual is controlled by a custom [CSS file](assets/style.css), which ensures a nice appearance in both HTML and PDF formats.

## Editing content

To contribute:
1. Edit or create files directly on GitHub or locally on your system.
2. Submit a pull request with a clear, one-line description of the changes made.
3. Follow best practices by adding reviewers and referencing related issues, if applicable.

For adding a table of contents to any document, use [mdformat-toc](https://github.com/hukkin/mdformat-toc). Insert ```<!-- mdformat-toc start -->``` where the table of contents should appear, and run `mdformat <file.md>` on the edited file, or `make format` to format all.

## Acknowledgements

We thank the following labs for sharing their open-source lab manuals, which inspired this project:

- [Aly Lab Manual](https://github.com/alylab/labmanual)
- [Getz Lab Manual](https://github.com/getzlab/getzlab.github.io)


## TODO

Some outstanding tasks to improve the manual's content, style and accessibility:

- [x] Improve and include [public data page](source/public_data.md)
- [x] Add additional resources on project planning
- [x] Add section on 'Developing a project'
- [x] Add section on 'Publications'
- [x] Add section on 'Authorship'
- [x] Add section on 'Engaging in new projects'
- [x] Remove hackaton ideas section from 'Communication'
- [ ] Add proper `href` for all links
- [ ] Align all file names with `h1` heading (for easy linking and easier website deploy)
- [ ] Update build and dependencies docs
- [ ] Website deployment
    - [x] Set up
    - [x] Fix `ul`, `ol` and `table` styling
    - [x] Fix intra-manual links (ending .md)
    - [x] Fix Python code blocks highlighting
    - [ ] Build only on tagged versions, not on `main`
