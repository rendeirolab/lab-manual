find . -type f -name "*.md" -exec sed -i -e '$a\\n' {} \;
find . -type f -name "*.md" -exec sed -i -e '$a<hr>' {} \;

cat ORDER | pandoc \
    --toc \
    -f gfm \
    -t html5 \
    --metadata-file=metadata.yaml \
    --css style.css \
    --pdf-engine=wkhtmltopdf \
    --pdf-engine-opt='--enable-local-file-access' \
    -s `xargs` \
    -o build/pdf/rendeiro-lab_manual.pdf
    # --lua-filter pagebreak.lua \
    # --pdf-engine-opt='--enable-internal-links' \
    # --css https://raw.githubusercontent.com/simov/markdown-viewer/master/themes/github.css

find . -type f -name "*.md" -exec sed -i -e '$ d' {} \;
find . -type f -name "*.md" -exec sed -i -e '$ d' {} \;
find . -type f -name "*.md" -exec sed -i -e '$ d' {} \;
