<div style="page-break-after: always;"></div>

# Lab manual

This is the lab manual, with all the information about the lab's culture and procedures.

The manual is available in the [`labdocs repository`](https://github.com/rendeirolab/labdocs/tree/main/manual) on Github.

It is written in [Markdown](https://daringfireball.net/projects/markdown/), but can be converted to HTML and PDF using [Pandoc](https://pandoc.org/).

It can be maintained and edited by anyone on Github.

## Building the manual

A [Makefile](https://github.com/rendeirolab/labdocs/blob/main/manual/Makefile) is available in the [`labdocs repository`](https://github.com/rendeirolab/labdocs/tree/main/manual).

Converting the manual to a single HTML file:

```bash
pandoc \
    --toc \
    --metadata-file=metadata.yaml \
    --css style.css \
    -s README.md manual/*.md \
    -o rendeiro-lab_manual.html
```

Converting the manual to a single PDF file (requires wkhtmltopdf dependency):

```bash
pandoc \
    --toc \
    -f gfm -t html5 \
    --metadata-file=metadata.yaml \
    --css https://raw.githubusercontent.com/simov/markdown-viewer/master/themes/github.css \
    -s README.md manual/*.md \
    -o rendeiro-lab_manual.pdf
```

## Editing content

Edit or create files either directly at Github or locally. Make sure you open a pull request with a brief (one line) description of what the changes are.

To add a table of contents to each document, use [mdformat-toc](https://github.com/hukkin/mdformat-toc).
Simply add `<!-- mdformat-toc start -->` to the desired location of the document, and run `mdformat <file.md>` to generate it.

## Sources of inspiration

- https://github.com/alylab/labmanual
- https://github.com/getzlab/getzlab.github.io
