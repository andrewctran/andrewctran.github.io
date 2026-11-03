#!/bin/bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$REPO_DIR"

RHEO="$REPO_DIR/bin/rheo"
OUT="build/html"

# rheo leaves behind files it did not write, so a removed asset would
# otherwise linger in local builds.
rm -rf "$OUT"

"$RHEO" --version
"$RHEO" compile . --html

if [ ! -f "$OUT/index.html" ]; then
  echo "Error: $OUT/index.html not found after compilation" >&2
  exit 1
fi

# rheo publishes only the pages and the stylesheet, so GitHub Pages' CNAME
# is copied in after the compile.
cp CNAME "$OUT/CNAME"

echo "Built $(find "$OUT" -name '*.html' | wc -l | tr -d ' ') HTML file(s) into $OUT"
