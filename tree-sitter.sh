package: tree-sitter
version: "v0.25.3"
tag: "v0.25.3"
source: https://github.com/tree-sitter/tree-sitter
requires:
  - "GCC-Toolchain:(?!osx)"
license: MIT
build_requires:
  - alibuild-recipe-tools
---
#!/bin/bash -e

# Build and install the C library
make -C "$SOURCEDIR" ${JOBS:+-j$JOBS} PREFIX="$INSTALLROOT" install

# Download the pre-built CLI binary from GitHub releases
mkdir -p "$INSTALLROOT/bin"
case "$(uname -s)-$(uname -m)" in
  Darwin-arm64) CLI_ASSET="tree-sitter-macos-arm64" ;;
  Darwin-x86_64) CLI_ASSET="tree-sitter-macos-x64" ;;
  Linux-x86_64) CLI_ASSET="tree-sitter-linux-x64" ;;
  Linux-aarch64) CLI_ASSET="tree-sitter-linux-arm64" ;;
  *) echo "Unsupported platform for tree-sitter CLI"; exit 1 ;;
esac

CLI_URL="https://github.com/tree-sitter/tree-sitter/releases/download/${PKGVERSION}/${CLI_ASSET}.gz"
curl -fsSL "$CLI_URL" | gunzip > "$INSTALLROOT/bin/tree-sitter"
chmod +x "$INSTALLROOT/bin/tree-sitter"

# Modulefile
MODULEDIR="$INSTALLROOT/etc/modulefiles"
mkdir -p "$MODULEDIR"
alibuild-generate-module --bin --lib --root > "$MODULEDIR/$PKGNAME"
