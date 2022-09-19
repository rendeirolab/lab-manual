# Rendeiro lab manual

Welcome to the Rendeiro lab!
This is the lab manual, with all the information about the lab's culture and procedures.

## Building the manual

To HTML:

```bash
pandoc \
    --toc \
    --metadata-file=metadata.yaml \
    --css style.css \
    -s README.md manual/*.md \
    -o rendeiro-lab_manual.html
```

To PDF (requires wkhtmltopdf dependency):

```bash
pandoc \
    --toc \
    -f gfm -t html5 \
    --metadata-file=metadata.yaml \
    --css https://raw.githubusercontent.com/simov/markdown-viewer/master/themes/github.css \
    -s README.md manual/*.md \
    -o rendeiro-lab_manual.pdf
```

\\newpage

## Editing content

Edit or create files either directly at Github or locally. Make sure you open a pull request with a brief (one line) description of what the changes are.

To add a table of contents to each document, use [mdformat-toc](https://github.com/hukkin/mdformat-toc).
Simply add `<!-- mdformat-toc start -->` to the desired location of the document, and run `mdformat <file.md>` to generate it.

## Sources of inspiration

- https://github.com/alylab/labmanual
- https://github.com/getzlab/getzlab.github.io
