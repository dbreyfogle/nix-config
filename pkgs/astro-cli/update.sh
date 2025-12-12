#!/usr/bin/env nix-shell
#!nix-shell -i bash -p curl gnused nix-prefetch

set -euo pipefail

ROOT="$(dirname "$(readlink -f "$0")")"
NIX_DRV="$ROOT/package.nix"
if [ ! -f "$NIX_DRV" ]; then
  echo "ERROR: cannot find package.nix in $ROOT"
  exit 1
fi

fetch_hash() {
  ARCH="$1"
  URL="https://github.com/astronomer/astro-cli/releases/download/v${ASTRO_VER}/astro_${ASTRO_VER}_${ARCH}.tar.gz"
  nix-hash --to-sri --type sha256 "$(nix-prefetch-url --type sha256 "$URL")"
}

replace_hash() {
  PLATFORM_NAME="$1"
  HASH="$2"
  sed -i "/\"$PLATFORM_NAME\"/,/};/ s#hash = \"sha256-[^\"]*\"#hash = \"$HASH\"#" "$NIX_DRV"
}

ASTRO_VER=$(curl -s "https://api.github.com/repos/astronomer/astro-cli/releases/latest" | sed -n 's/.*"tag_name": *"v\([^"]*\)".*/\1/p')

sed -i "s/version = \"[^\"]*\"/version = \"$ASTRO_VER\"/" "$NIX_DRV"

ASTRO_LINUX_AMD64_HASH=$(fetch_hash "linux_amd64")
ASTRO_LINUX_ARM64_HASH=$(fetch_hash "linux_arm64")
ASTRO_DARWIN_AMD64_HASH=$(fetch_hash "darwin_amd64")
ASTRO_DARWIN_ARM64_HASH=$(fetch_hash "darwin_arm64")

replace_hash "x86_64-linux" "$ASTRO_LINUX_AMD64_HASH"
replace_hash "aarch64-linux" "$ASTRO_LINUX_ARM64_HASH"
replace_hash "x86_64-darwin" "$ASTRO_DARWIN_AMD64_HASH"
replace_hash "aarch64-darwin" "$ASTRO_DARWIN_ARM64_HASH"
