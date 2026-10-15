<div style="page-break-after: always;"></div>

# Lab manual

Welcome to the Rendeiro Lab Manual.

This manual provides comprehensive information about the lab's culture, procedures, and workflows to ensure a collaborative and efficient research environment.

The manual is hosted in the [`lab-manual`](https://github.com/rendeirolab/lab-manual/) repository on GitHub. It is written in [Markdown](https://daringfireball.net/projects/markdown/) and can be converted to HTML and PDF using [Pandoc](https://pandoc.org/).

This manual is open source and maintained collaboratively. Anyone on GitHub can propose changes.

## Editing the manual

To contribute an addition or change to the manual:

1. Edit or create files directly [on GitHub](https://github.com/rendeirolab/lab-manual), or locally on your computer.
2. Submit a pull request with a clear, one-line description of the changes made.
3. Follow best practices by adding reviewers and referencing related issues, if applicable.

Tip: to add a table of contents to a new document, use [mdformat-toc](https://github.com/hukkin/mdformat-toc). Insert ```<!-- mdformat-toc start -->``` where the table of contents should appear, and run `mdformat <file.md>` on the edited file, or `make format` to format all.

### Building the manual locally

To preview changes locally before committing to GitHub and deploying on the lab website, you can build the manual locally using the provided tools. Ensure you have the necessary dependencies installed:

- [Pandoc](https://pandoc.org/installing.html)
- [wkhtmltopdf](https://wkhtmltopdf.org/downloads.html)
- [mdformat](https://github.com/hukkin/mdformat) with the [mdformat-gfm](https://github.com/hukkin/mdformat-gfm) plugin

On Debian/Ubuntu, `make requirements` installs them.

To streamline the development process the project includes a [Makefile](https://github.com/rendeirolab/lab-manual/blob/main/Makefile). Key targets include:

- **`format`**: Formats Markdown files consistently using `mdformat`.
- **`build`**: Converts the manual into a single HTML file using `pandoc` and generates a PDF file using `wkhtmltopdf`.
- **`clean`**: Removes generated files to ensure a fresh build.

Styling for the manual is controlled by a custom [CSS file](assets/style.css), which ensures a nice appearance in both HTML and PDF formats.

### Releases

Versions are named by date (`YYYY-MM-DD`). To make a release, update [CHANGELOG.md](https://github.com/rendeirolab/lab-manual/blob/main/CHANGELOG.md) and the `version` and `date-released` fields in [CITATION.cff](https://github.com/rendeirolab/lab-manual/blob/main/CITATION.cff), then create a GitHub release with a tag of the same name.
The build workflow attaches the HTML and PDF versions of the manual to the release, and [Zenodo](https://zenodo.org/) archives it with a DOI.

## Citing the manual

If you use or adapt this manual, please cite it. Citation metadata is in [CITATION.cff](https://github.com/rendeirolab/lab-manual/blob/main/CITATION.cff), and the "Cite this repository" button on the [GitHub page](https://github.com/rendeirolab/lab-manual) exports it in common formats.

## License

The manual is licensed under the [Creative Commons Attribution 4.0 International License (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/). See [LICENSE](https://github.com/rendeirolab/lab-manual/blob/main/LICENSE).

## Acknowledgements

We thank the following labs for sharing their open-source lab manuals, which inspired this project:

- [Aly Lab Manual](https://github.com/alylab/labmanual)
- [Getz Lab Manual](https://github.com/getzlab/getzlab.github.io)
