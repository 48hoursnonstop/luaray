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

## 0.141.0-dev

Added the native `ndarray` constructor with owned allocation or retained C/F
buffers, byte offsets, positive/negative/zero strides and rank-one inference.
String buffers are pinned and read only. Zero-width S0/U0 descriptors retain
their width. Bounds and element products are checked before pointer formation;
unsafe upstream inferred layouts and invalid real buffers are rejected.

Validated 24,204 NumPy 2.5.3 cases / 240,870 exact checks, 62 permanent Lua
checks and a native ownership/range regression. Skipped 2,420 unsafe or
unverified upstream parameter states; these are not compatibility passes.
Added executable English/Spanish constructor documentation. Compatibility
remains partial; no foreign buffer, subclass or unsupported dtype protocols.

## 0.140.0-dev

Added immutable native dtype descriptors with scalar metadata, formatting,
equivalence and shared readers for core array/casting/selection APIs. Corrected
`float` to float64, native character/width aliases, equivalent integer aliases
and Unicode endian cast safety. Unicode allocations now honor NEEDS_INIT.
Unsized join/sampling outputs resolve real widths. Added timedelta sum/mean/
accumulation with NaT and checked overflow, and validated reduction dtype classes
before empty shortcuts. Documented the distinct legacy cumulative metadata rule.
Added native/Lua regressions, four differential corpora and English/Spanish guides.

## 0.139.0-dev

Added `shape`, `ndim` and `size` queries over native ndarray metadata and the
existing Lua array-like discovery path. Axis queries retain one-based positive
and negative-from-end conventions. Added tests for empty/ragged sequences,
rank-64 inputs, immutable buffers and huge zero-stride views without data
iteration, plus English/Spanish guides.

## 0.138.0-dev

Added `require` for C/F layout, alignment, writeability and storage ownership,
preserving suitable input identity and copying when needed. Fixed shared array
creation so dtype-changing ANYORDER conversions retain axis order separately
from same-dtype ANYORDER copies. Added regression and differential evidence for
immutable/unaligned buffers and English/Spanish memory-requirement guides.

## 0.137.0-dev

Added ndarray flag objects, write/alignment `setflags` and `isfortran`. Retained
logical root permissions across view lifetimes, distinguished existing writable
views from later re-enabling, and preserved alignment rollback on failed write
changes. Flag objects retain their arrays and source snapshot semantics. Added
native/Lua regressions and English/Spanish guides; writeback-if-copy mutation
remains explicitly unsupported.

## 0.136.0-dev

Added genuine zero-copy `frombuffer` for binary Lua strings and C-contiguous
ndarrays. External owners have explicit release callbacks, immutable string
storage is pinned through the last view, and creating coroutines may be collected
safely. Physical overlap detection now handles independently acquired owners.
Also fixed an earlier complex256 scalar-assignment temporary overflow exposed by
expanded instrumentation. Added native/Lua lifetime and alias tests plus an
English/Spanish buffer guide.

## 0.135.0-dev

Added native ndarray `item` and `fill`, with logical flat/coordinate indexing,
detached precision-preserving scalars, scalar packing before writes and alias
capture. Fixed shared datetime year/month calendar casts, defined source wrap
behavior and temporal text limits. Resolve temporal metadata before iteration,
including empty arrays, and preserve scalar/array false-mask distinctions.
Added maintained native/Lua tests and
English/Spanish guides for element access and filling.

## 0.134.0-dev

Added `array_equal`, `array_equiv`, `isclose` and `allclose` with source-derived
shape, broadcasting, scalar promotion and NaN rules. Added temporal isnan/isinf,
integer offset arithmetic/comparisons and preservation of completed overflow
writes. Added native/Lua regressions, exact extended-precision reference inputs
and executable English/Spanish equality guides.

## 0.133.0-dev

Added Lua-native `interp` with real/complex samples, guess-assisted searching,
optional slope caching, boundary fills, periodic normalization and source-derived
nonfinite fallbacks. Preserves safe/nonperiodic versus explicit/periodic dtype
conversion and typed rank-zero results. Added executable EN/ES guides. Periodic
sorting follows portable NumPy quicksort; differences from CPU-specific unstable
tie ordering remain documented and measured separately.

## 0.132.0-dev

Added Lua-native `angle` using typed real/imaginary views, native arctan2 and
optional degree scaling. Preserves complex signed-zero conventions and result
dtypes, with independent writable outputs. Extended the English/Spanish phase
guide with executable complex-phase and unwrap examples.

## 0.131.0-dev

Added Lua-native `unwrap` for phase continuity with selectable axes, periods,
discontinuity thresholds, source integer half-interval parity, typed promotion,
broadcasting and cumulative corrections. Added writable-copy and extreme-value
regressions plus executable English/Spanish phase guides.

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
