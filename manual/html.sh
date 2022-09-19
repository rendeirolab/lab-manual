find . -type f -name "*.md" -exec sed -i -e '$a\\n' {} \;
find . -type f -name "*.md" -exec sed -i -e '$a\\\newpage' {} \;
cat ORDER | pandoc \
    --toc \
    --metadata-file=metadata.yaml \
    --css style.css \
    --pdf-engine pdflatex \
    -s `xargs` \
    -o build/html/rendeiro-lab_manual.html
find . -type f -name "*.md" -exec sed -i -e '$ d' {} \;
find . -type f -name "*.md" -exec sed -i -e '$ d' {} \;
find . -type f -name "*.md" -exec sed -i -e '$ d' {} \;
