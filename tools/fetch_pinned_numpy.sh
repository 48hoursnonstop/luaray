#!/usr/bin/env sh
set -eu
COMMIT=286e698f1dcf601648b165f48485ceaeec9c6231
OUT="${1:-$HOME/Downloads}"
TREE="$OUT/numpy-source-$COMMIT"
ARCHIVE="$OUT/numpy-$COMMIT.tar.gz"
rm -rf "$TREE"
git clone --filter=blob:none --recursive https://github.com/numpy/numpy.git "$TREE"
git -C "$TREE" checkout "$COMMIT"
git -C "$TREE" submodule update --init --recursive
tar --exclude='.git' --exclude='*/.git' -czf "$ARCHIVE" -C "$OUT" "numpy-source-$COMMIT"
printf '%s\n' "$ARCHIVE"
