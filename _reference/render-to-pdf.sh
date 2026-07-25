#!/usr/bin/env bash
# Render a trip page to PDF — the offline copy for the plane.
#
# The web page is the primary artifact now; this is the secondary path for
# when someone wants it on paper or without signal.
#
#   ./_reference/render-to-pdf.sh public/2026-12-sea/index.html SEA-Itinerary.pdf
#
# Why this script exists rather than "just print":
#   - There is no pandoc or wkhtmltopdf on this machine; headless Chrome is it.
#   - Chrome intermittently HANGS when rendering from the Dropbox/CloudStorage
#     path (stuck GPU process, PDF never written). So we always copy to a local
#     temp dir, render there, and copy the result back.
# Learned the hard way on the Hong Kong itinerary, Jul 2026.

set -euo pipefail

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
SRC="${1:?usage: render-to-pdf.sh <input.html> [output.pdf]}"
OUT="${2:-${SRC%.html}.pdf}"

[ -x "$CHROME" ] || { echo "Google Chrome not found at $CHROME"; exit 1; }
[ -f "$SRC" ]    || { echo "No such file: $SRC"; exit 1; }

SRC_ABS="$(cd "$(dirname "$SRC")" && pwd)/$(basename "$SRC")"
SRC_DIR="$(dirname "$SRC_ABS")"

# Clear any hung headless Chrome from a previous run.
pkill -9 -f "Google Chrome.*headless" 2>/dev/null || true

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

# Rebuild the site layout inside the temp dir so the page's relative
# "../assets/site.css" resolves exactly as it does when served.
#   $TMP/site/assets/…      $TMP/site/<pagedir>/index.html
mkdir -p "$TMP/site/$(basename "$SRC_DIR")"
cp -R "$SRC_DIR"/. "$TMP/site/$(basename "$SRC_DIR")/"
[ -d "$SRC_DIR/../assets" ] && cp -R "$SRC_DIR/../assets" "$TMP/site/assets"

PAGE="$TMP/site/$(basename "$SRC_DIR")/$(basename "$SRC_ABS")"

"$CHROME" --headless --disable-gpu --no-sandbox \
  --virtual-time-budget=8000 \
  --no-pdf-header-footer \
  --print-to-pdf="$TMP/out.pdf" \
  "file://$PAGE" >/dev/null 2>&1

[ -f "$TMP/out.pdf" ] || { echo "Render failed — no PDF produced."; exit 1; }
cp "$TMP/out.pdf" "$OUT"

if command -v pdfinfo >/dev/null 2>&1; then
  echo "→ $OUT  ($(pdfinfo "$OUT" | awk '/^Pages/{print $2}') pages)"
else
  echo "→ $OUT"
fi
