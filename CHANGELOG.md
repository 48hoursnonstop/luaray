# Changelog

## Unreleased

- Published a searchable documentation website with topic navigation, page outlines,
  English/Spanish switching, mobile navigation, and light/dark appearance.
- Added getting-started and array fundamentals guides with executable Lua examples.

- Reduced the main source tree to the library, subject-based examples, maintained
  tests, and current English/Spanish documentation.
- Moved generated oracle data and development generators out of the main tree.
  `make reference-test` checks the current engine against the verified 0.116 corpus.
- Simplified the build and CI without changing numerical kernels or the release version.

## 0.130.0-dev

Added Lua-native `trapezoid` over native typed differences, arithmetic and
reductions. Supports coordinate/spacing arrays, axes and broadcasting, preserved
integer operation order, duration units/NaT and typed rank-zero results. Added
maintained regressions and executable English/Spanish integration guides.

## 0.129.0-dev

Added Lua-native `gradient` with uniform and uneven coordinates, selectable axes,
first/second-order endpoints, typed stencils, independent outputs and temporal
inputs. Added exact int64 duration division and common-unit float64 duration
ratios to native ufunc dispatch, including masks, NaT and aliased outputs.
Added executable English/Spanish gradient guides and expanded duration reference.

## 0.128.0-dev

Added Lua-native `diff` and `ediff1d` with repeated differences, one-based axes,
source dtype rules, boundary values, stable-empty termination and temporal/Boolean
behavior. Fixed shared multi-input trivial ufunc result allocation and
concatenate/stack stride ordering, including F/singleton/empty layouts. Added
executable EN/ES finite-difference guides and differential layout regressions.

## 0.127.0-dev

Added Lua-composed `mask_indices` over native creation, comparison and nonzero
kernels. Supports real writable callback inputs, unchanged parameter forwarding,
callable tables, sequence-return adaptation, reference text/time comparison and
one-based coordinate views. Added EN/ES guides; API inventory probes the public
Lua entry point rather than only the private native module.

## 0.126.0-dev

Added root `tensordot` with one-based arbitrary axis pairs, ordinary Lua inputs,
negative/zero counts and typed scalar results. Guarded native contraction shape
buffers against results above64 dimensions. Fixed common-unit conversion in dot,
added legacy raw-tick timedelta dot and rejected unsupported empty-result dtypes.
Added executable EN/ES guides and explicit BLAS/object-dtype comparison limits.

## 0.125.0-dev

Added `kron` with strong-array coercion, interleaved axes, typed multiplication,
C-order reshape, independent storage and reference rank boundaries. Added exact
int64 duration multiplication with NaT propagation and overflow validation.
The shared iterator now preserves defined error writes, negative in-place
traversal and legacy masked-run continuation. Temporal conversion checks pinned
intermediate int64 bounds. Added EN/ES block-product and duration guides;
undefined upstream buffered failure suffixes are explicitly excluded from parity.

## 0.124.0-dev

Added `fill_diagonal` with direct logical writes, repeated C-order values,
rectangular and higher-rank diagonals, historical tall-matrix wrap and live
overlapping reads. Reused typed assignment conversion for scalar bounds, string
parsing and complex-to-Boolean values. Added executable English/Spanish guides.

## 0.123.0-dev

Added `tril_indices`, `triu_indices` and both `_from` helpers with one-based,
independent contiguous coordinate vectors, rectangular matrices, empty-selection
layouts and pinned extreme-offset behavior. Extended executable EN/ES triangular
guides with real advanced reads and writes.

## 0.122.0-dev

Added `diag_indices` and `diag_indices_from` with shared one-based coordinate
vectors and actual advanced read/write integration. Fixed numeric, Boolean and
complex scalar assignment to fixed-width strings, and reused native formatting
for constructors to preserve precision, pure-imaginary notation and NaN spelling.
Added executable English/Spanish guides.

## 0.121.0-dev

Added native `eye` and `identity` with rectangular shapes, offset diagonals,
C/Fortran order, typed zero/one construction, CPU device validation and pinned
NumPy temporal-unit/empty-assignment behavior. Added EN/ES identity guides.

## 0.120.0-dev

Added native `vander` with source-ordered multiply accumulation, native-int dtype
promotion, increasing/decreasing columns, typed empty/string/duration edge cases,
and independently writable results. Added EN/ES polynomial-fitting examples.

## 0.119.0-dev

Added `tri`, `tril`, and `triu`, preserving boolean-to-dtype mask conversion,
KEEPORDER batch layouts, typed zeros, Unicode byte-order promotion, and defined
fixed-width index wrapping. Added EN/ES guides and differential boundary tests.

## 0.118.0-dev

Added root and ndarray `trace` with arbitrary axes, dtype/output handling, staged
alias-safe writes, and shared `linalg.trace` execution. Added timedelta reduction,
NaT propagation, unit conversion, legacy dtype resolution and EN/ES reference guides.

## 0.117.0-dev

Added `diagonal`, `diag`, `diagflat`, and `ndarray:diagonal`, including general axes,
read-only shared views, C-order flattening, dtype-preserving matrix construction,
and overflow checks. Added English/Spanish matrix documentation and numerical references.

## 0.116.0-dev

Added cross products and coordinate grids, including NumPy differential references,
shared-view checks, and directed ASan/UBSan validation.

[All releases and their original verification records](https://github.com/48hoursnonstop/luaray/releases)
remain available. Published tags and assets are unchanged.
