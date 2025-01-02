# Add newline at end of each file
find . -type f -name "*.md" -exec sed -i -e '$a\\n' {} \;
# Add a page break after each file
find . -type f -name "*.md" -exec sed -i -e '$a<div style="page-break-after: always;"></div>' {} \;

sed -i -e '$a\\n' metadata.yaml
sed -i -e '$a<div style="page-break-after: always;"></div>' metadata.yaml

# Now convert to PDF
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

# Delete last 3 lines of each file
find . -type f -name "*.md" -exec sed -i -e '$ d' {} \;
find . -type f -name "*.md" -exec sed -i -e '$ d' {} \;
find . -type f -name "*.md" -exec sed -i -e '$ d' {} \;

sed -i -e '$d' metadata.yaml
sed -i -e '$d' metadata.yaml
sed -i -e '$d' metadata.yaml
