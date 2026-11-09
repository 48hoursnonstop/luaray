# Validation

## Released baseline

[LuaRay 0.116.0-dev](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev)
passed a clean source extraction and rebuild, all **161 differential fixture
files**, and **19 public Lua examples**. The exact release commit also passed
[GitHub CI](https://github.com/48hoursnonstop/luaray/actions/runs/42567717315).

The release added 8,141 cross/meshgrid cases and 787,265 checks. General complex
cross comparisons use fixed budgets of 6e-7 for complex64 and 2e-15 for wider
complex types, scaled by `max(1, abs(component))`. Metadata, ordinary exact
references, and grid state comparisons retain exact assertions. The
[vector/grid reference](../en/vectors_and_grids.md) describes the contract.

The directed ASan/UBSan audit passed with **38 C units and one C++ unit**,
20 native suites, and 78 Lua suites. Other linked dependencies were not fully
instrumented; leak detection was disabled. This audit does not certify every
algorithm, external BLAS/LAPACK routine, host ABI, or floating-point environment.

## Reproduce checks

```sh
make -j4 full-test CXXFLAGS='-O0 -g -std=c++11 -Wall -Wextra -Wpedantic'
make examples
make reference-test
```

`full-test` executes the maintained native and Lua regressions. `reference-test`
obtains the immutable 0.116 source archive, verifies SHA-256, and executes its
161 differential fixture files plus extended random and formatting references
against the current engine. The generated data is cached outside the tracked tree.
Both targets run without Python or NumPy.

The complete oracle generators and directed sanitizer tooling remain in the
[released source package](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev).
Use that separate workspace to regenerate fixtures or reproduce the historical
`sanitize-vector116` audit. Recent generators assert NumPy 2.5.3; older fixtures
retain their original NumPy 2.3.5 attribution.

`compatibility/current.json` records the release-specific behavioral evidence.
`compatibility/api_inventory.json` records runtime availability. The latter
reports 352 of 675 scoped names as available and classifies all available APIs
as partial; it is not a measure of overall NumPy completion.

## Current source-tree checks

The source-tree cleanup passed a clean native build, **54 native suites**,
**86 Lua suites**, and **seven public examples** on Linux. External reference
validation passed all **161 differential files**, 23 extended permutation parts,
the two additional random edge fixtures, and the 70,828-state formatting reference.
The current kernels were used for these checks; no numerical source was changed.

## Release integrity

Release assets include a source archive, its SHA-256 checksum, and a separate
verification JSON. The archive contains `PROJECT_SHA256SUMS`, generated during
packaging. This manifest is not kept in the working tree, where ordinary edits
would immediately make it stale.

The release tooling preserved in the source package verifies the embedded
manifest after extracting the archive,
then builds and executes its checks from that clean source directory. Verified
assets and release tags remain immutable.
