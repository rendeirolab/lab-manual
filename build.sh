#!/usr/bin/env bash
# Build the manual as a single HTML file and a PDF.
# Page order is read from the ORDER file (created by `make set_order`).
# Sources are copied to a staging directory, so files in the repository are never modified.
set -euo pipefail

VERSION=${VERSION:-$(git describe --tags --always --dirty 2>/dev/null || echo "dev")}
HTML=build/html/rendeiro-lab_manual.html
PDF=build/pdf/rendeiro-lab_manual.pdf

read -ra ORDER < ORDER

STAGE=$(mktemp -d)
trap 'rm -rf "$STAGE"' EXIT

# Set version
sed -e "s/<VERSION>/$VERSION/g" metadata.yaml > "$STAGE/metadata.yaml"

# Add a page break after each file except the last one
LAST=$((${#ORDER[@]} - 1))
for i in "${!ORDER[@]}"; do
    FILE=${ORDER[$i]}
    mkdir -p "$STAGE/$(dirname "$FILE")"
    cp "$FILE" "$STAGE/$FILE"
    if [ "$i" -lt "$LAST" ]; then
        printf '\n\n<div style="page-break-after: always;"></div>\n' >> "$STAGE/$FILE"
    fi
done

# Convert to HTML
mkdir -p "$(dirname "$HTML")" "$(dirname "$PDF")"
(cd "$STAGE" && pandoc \
    -V toc-title='Table of contents' \
    --embed-resources \
    --standalone \
    --css="$OLDPWD/assets/style.css" \
    --toc \
    --toc-depth 1 \
    -t html5 \
    --metadata-file=metadata.yaml \
    -o "$OLDPWD/$HTML" \
    "${ORDER[@]}")

# Copy images
cp -r assets build/html/

# Add content inside 'container'
sed -i 's/<body>/<body><div class="container">/g' "$HTML"
sed -i 's/<\/body>/<\/div><\/body>/g' "$HTML"

# Convert to PDF
wkhtmltopdf \
    --enable-internal-links \
    --enable-local-file-access \
    --header-center "Rendeiro lab manual" \
    --header-font-size 8 \
    --footer-center "[page]/[topage]" \
    --footer-font-size 8 \
    "$HTML" \
    "$PDF"
