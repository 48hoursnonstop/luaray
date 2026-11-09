# Changelog

## Unreleased

- Reduced the main source tree to the library, subject-based examples, maintained
  tests, and current English/Spanish documentation.
- Moved generated oracle data and development generators out of the main tree.
  `make reference-test` checks the current engine against the verified 0.116 corpus.
- Simplified the build and CI without changing numerical kernels or the release version.

## 0.116.0-dev

Added cross products and coordinate grids, including NumPy differential references,
shared-view checks, and directed ASan/UBSan validation.

[All releases and their original verification records](https://github.com/48hoursnonstop/luaray/releases)
remain available. Published tags and assets are unchanged.
