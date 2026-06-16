#!/usr/bin/env bash
# build.sh — compile a tailored document to PDF and report its page count.
# Usage: ./build.sh <application-dir> [name]
#   name defaults to "cv".  Reads <application-dir>/<name>.tex, writes
#   <application-dir>/<name>.pdf (byproducts removed).
#   e.g.  ./build.sh applications/<dir>              -> cv.tex  -> cv.pdf
#         ./build.sh applications/<dir> cover-letter -> cover-letter.tex -> cover-letter.pdf
# Page target: 2 for the CV, 1 for everything else (cover letters). The script
# prints the page count and warns when it exceeds the target, so the generation
# step can iterate to fit (see CLAUDE.md).
set -euo pipefail

DIR="${1:?usage: build.sh <application-dir> [name]}"
DIR="${DIR%/}"
NAME="${2:-cv}"
TEX="$DIR/$NAME.tex"
[ -f "$TEX" ] || { echo "error: $TEX not found" >&2; exit 1; }

case "$NAME" in
  cv) TARGET=2 ;;
  *)  TARGET=1 ;;
esac

PDFLATEX="$(command -v pdflatex || echo /Library/TeX/texbin/pdflatex)"
[ -x "$PDFLATEX" ] || { echo "error: pdflatex not found" >&2; exit 1; }

# Run twice so references resolve; capture the last run to read the page count.
out=""
for _ in 1 2; do
  out="$("$PDFLATEX" -interaction=nonstopmode -halt-on-error -output-directory "$DIR" "$TEX")"
done

rm -f "$DIR/$NAME.aux" "$DIR/$NAME.log" "$DIR/$NAME.out"

# Join wrapped log lines first (pdflatex wraps "Output written on <path> (N pages)").
pages="$(printf '%s' "$out" | tr -d '\n' | sed -n 's/.*Output written on [^()]*(\([0-9][0-9]*\) page.*/\1/p')"
echo "built: $DIR/$NAME.pdf (${pages:-?} pages)"
if [ -n "${pages:-}" ] && [ "$pages" -gt "$TARGET" ]; then
  echo "WARNING: ${pages} pages > ${TARGET}-page target — trim to fit." >&2
fi
