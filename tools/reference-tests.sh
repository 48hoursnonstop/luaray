#!/usr/bin/env sh
# Compare the current native module with the original 0.116 oracle corpus.
set -eu
root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
build=${LUARAY_BUILD_DIR:-$root/build}
version=0.116.0-dev
expected=1a875996b22e4ab883b7a0deca68274a61c7cfcdb5ef6232b7ba3acc0072c9b6
archive=${LUARAY_REFERENCE_ARCHIVE:-$root/releases/luaray-$version-source.tar.gz}
if [ ! -r "$archive" ]; then
    archive="$root/.dev/reference-$version.tar.gz"
    mkdir -p "$root/.dev"
    if [ ! -r "$archive" ]; then
        curl --fail --location --retry 3 \
            "https://github.com/48hoursnonstop/luaray/releases/download/v$version/luaray-$version-source.tar.gz" \
            --output "$archive"
    fi
fi
printf '%s  %s\n' "$expected" "$archive" | sha256sum --check -
mkdir -p "$root/.dev"
stage=$(mktemp -d "$root/.dev/reference-run.XXXXXX")
trap 'rm -rf -- "$stage"' EXIT HUP INT TERM
tar -xzf "$archive" -C "$stage"
reference="$stage/luaray-$version"
(
    cd "$reference"
    count=0
    for fixture in tests/*_differential_generated.lua; do
        "$build/lua_runner" "$fixture"
        count=$((count + 1))
    done
    for fixture in tests/permuted73_part_*.lua tests/random78_edge_generated.lua tests/random79_edge_generated.lua; do
        "$build/lua_runner" "$fixture"
    done
    printf 'Passed %s differential fixture files and extended random references\n' "$count"
)
# The large formatting table also stays outside the default source checkout.
cd "$root"
compiler=${CC:-cc}
"$compiler" -std=c11 -O2 -Isrc -I"$reference/tests" \
    "$reference/tests/test_format106_core.c" -L"$build" \
    -Wl,-rpath,"$build" -l:luaray_core.so -lm -pthread -o "$stage/format-reference"
"$stage/format-reference"
