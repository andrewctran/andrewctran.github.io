#!/bin/bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$REPO_DIR"

RHEO_VERSION="v$(grep '^version' rheo.toml | sed 's/version = "\(.*\)"/\1/')"

case "$(uname -s)-$(uname -m)" in
  Linux-x86_64) RHEO_TARGET="x86_64-unknown-linux-gnu" ;;
  Linux-aarch64) RHEO_TARGET="aarch64-unknown-linux-gnu" ;;
  Darwin-x86_64) RHEO_TARGET="x86_64-apple-darwin" ;;
  Darwin-arm64) RHEO_TARGET="aarch64-apple-darwin" ;;
  *) echo "Unsupported platform: $(uname -s)-$(uname -m)" >&2; exit 1 ;;
esac

RHEO_CACHE="$REPO_DIR/.rheo-binary/$RHEO_VERSION-$RHEO_TARGET"
RHEO_BIN="$RHEO_CACHE/rheo"

if [ ! -x "$RHEO_BIN" ]; then
  echo "Downloading rheo $RHEO_VERSION ($RHEO_TARGET)..."
  mkdir -p "$RHEO_CACHE"
  TMP_ZIP="$(mktemp)"
  curl -fsSL "https://github.com/freecomputinglab/rheo/releases/download/$RHEO_VERSION/rheo-$RHEO_TARGET.zip" -o "$TMP_ZIP"
  unzip -o -q "$TMP_ZIP" -d "$RHEO_CACHE"
  rm "$TMP_ZIP"
  chmod +x "$RHEO_BIN"
fi

OUT="build/html"

# rheo leaves behind files it did not write, so a removed asset would
# otherwise linger in local builds.
rm -rf "$OUT"

"$RHEO_BIN" --version
"$RHEO_BIN" compile . --html

if [ ! -f "$OUT/index.html" ]; then
  echo "Error: $OUT/index.html not found after compilation" >&2
  exit 1
fi

# rheo publishes only the pages and the stylesheet, so GitHub Pages' CNAME
# is copied in after the compile.
cp CNAME "$OUT/CNAME"

echo "Built $(find "$OUT" -name '*.html' | wc -l | tr -d ' ') HTML file(s) into $OUT"
