VERSION=$(git describe --tags)
sed -i -e "s/<VERSION>/$VERSION/g" metadata.yaml

readarray -d ' ' ORDER < ORDER

## Add newline at end of each file
echo ${ORDER[@]:0:12} | xargs sed -i -e '$a\\n'
## Add horizontal ruler at end of each file
echo ${ORDER[@]:0:12} | xargs sed -i -e '$a<hr>'

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

# Undo modifications
## Remove version
sed -i -e "s/$VERSION/<VERSION>/g" metadata.yaml
## Delete last 3 lines of each file
echo ${ORDER[@]:0:12} | xargs sed -i -e '$ d'
echo ${ORDER[@]:0:12} | xargs sed -i -e '$ d'
echo ${ORDER[@]:0:12} | xargs sed -i -e '$ d'
