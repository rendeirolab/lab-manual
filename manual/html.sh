# Add newline at end of each file
find . -type f -name "*.md" -exec sed -i -e '$a\\n' {} \;
# Add horizontal ruler at end of each file
find . -type f -name "*.md" -exec sed -i -e '$a<hr>' {} \;

# Now convert all .md files to .html
cp style.css build/html
cat ORDER | pandoc \
    -V toc-title="Table of contents" \
    --css https://raw.githubusercontent.com/simov/markdown-viewer/master/themes/github.css \
    --css style.css \
    --toc \
    --toc-depth 2 \
    --metadata-file=metadata.yaml \
    --pdf-engine pdflatex \
    -s `xargs` \
    -o build/html/rendeiro-lab_manual.html

# Delete last 3 lines of each file
find . -type f -name "*.md" -exec sed -i -e '$ d' {} \;
find . -type f -name "*.md" -exec sed -i -e '$ d' {} \;
find . -type f -name "*.md" -exec sed -i -e '$ d' {} \;
