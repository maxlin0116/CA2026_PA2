#!/usr/bin/env bash
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_DIR="/home/maxlin0116/CA/B14901037_PA2/diagram"
mkdir -p "$OUT_DIR"

for f in single stall forward; do
    pdflatex -interaction=nonstopmode -output-directory="$SCRIPT_DIR" "$SCRIPT_DIR/$f.tex" >/dev/null
    pdftoppm -png -r 220 -singlefile "$SCRIPT_DIR/$f.pdf" "$OUT_DIR/$f"
    rm -f "$SCRIPT_DIR/$f.aux" "$SCRIPT_DIR/$f.log"
    echo "Generated $OUT_DIR/$f.png"
done
