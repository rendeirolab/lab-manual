
# Add modifications
## Version
VERSION=$(git describe --tags)
sed -i -e "s/<VERSION>/$VERSION/g" metadata.yaml

readarray -d ' ' ORDER < ORDER

## Add newline at end of each file
echo ${ORDER[@]:0:11} | xargs sed -i -e '$a\\n'
## Add a page break after each file
echo ${ORDER[@]:0:11} | xargs sed -i -e '$a<div style="page-break-after: always;"></div>'

# Convert to PDF
cat ORDER | pandoc \
    -V toc-title='Table of contents' \
    --css https://raw.githubusercontent.com/simov/markdown-viewer/master/themes/github.css \
    --css style.css \
    --toc \
    --toc-depth 1 \
    -t html5 \
    --metadata-file=metadata.yaml \
    --pdf-engine=wkhtmltopdf \
    --pdf-engine-opt='--enable-internal-links' \
    --pdf-engine-opt='--enable-local-file-access' \
    -s `xargs` \
    -o build/pdf/rendeiro-lab_manual.pdf


# Undo modifications
## Remove version
sed -i -e "s/$VERSION/<VERSION>/g" metadata.yaml
## Delete last 3 lines of each file
echo ${ORDER[@]:0:11} | xargs sed -i -e '$ d'
echo ${ORDER[@]:0:11} | xargs sed -i -e '$ d'
echo ${ORDER[@]:0:11} | xargs sed -i -e '$ d'
