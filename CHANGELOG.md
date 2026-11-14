# Changelog

## Unreleased

- Standardized Lua documentation examples and API references on the `lr` alias.

- Published a searchable documentation website with topic navigation, page outlines,
  English/Spanish switching, mobile navigation, and light/dark appearance.
- Added getting-started and array fundamentals guides with executable Lua examples.

- Reduced the main source tree to the library, subject-based examples, maintained
  tests, and current English/Spanish documentation.
- Moved generated oracle data and development generators out of the main tree.
  `make reference-test` checks the current engine against the verified 0.116 corpus.
- Simplified the build and CI without changing numerical kernels or the release version.

## 0.159.0-dev

Added native fromiter with checked geometric buffer growth, count-limited or
end-of-stream consumption, direct scalar packing and original Lua callback
error propagation. Typed rank-zero values retain native precision and casting;
ordinary values retain strict scalar bounds. Accepts callable Lua objects and
coroutine.wrap producers; buffers remain rooted during callbacks and GC.

Validated 11,367 NumPy 2.5.4 cases /153,738 checks, 58 permanent Lua checks,
a native allocation/overflow harness and C++ header/link execution. New English
and Spanish guides execute their examples. Python object/length-hint protocols,
like dispatch, structured/subarray dtypes and higher-rank elements remain
unsupported. Counts are strict Lua integers and nil marks end of stream.

## 0.158.0-dev

Updated the primary behavioral reference to NumPy 2.5.4. Preserves historical
source pins and oracle attribution. Empty retained axes and empty axis tuples
now work in ordinary quantiles/medians, keepdims results have retained views
with zero reduced-axis strides, medians preserve the source's K layout, and
fraction-vector promotion preserves longdouble. Condition-number min/max norms
now propagate inverse NaNs correctly; temporal accumulation validates output
classes even for empty inputs.

Validated 61,332 new focused cases / 617,872 checks against NumPy 2.5.4 plus
2,700 regenerated historical quantile cases. Added 130 permanent Lua checks,
a native harness, C++ header/link execution and executable EN/ES quantile guides.
The immutable 0.116 reference archive remains unchanged; 40 explicit former
rejections are updated to stronger source-defined success assertions after
extraction. Every original numeric assertion is preserved. The NumPy empty-axis
unpackbits defect was also reproduced with the actual 2.5.4 interpreter.

## 0.157.0-dev

Added native packbits/unpackbits with big/little bit order, zero padding,
C flattening or explicit axes, signed/noncanonical Boolean truth values,
unpack count trimming/extension and independent uint8 results. Handles
C/F, reversed, stepped, broadcast, read-only and unaligned inputs. Preserves
the pinned source's explicit-axis rank limit and legacy bitorder parsing.

Validated 37,640 NumPy 2.5.3 cases / 250,644 checks, 201 permanent Lua checks,
a native harness and C++ header/link execution. The corpus regenerates exactly.
Another 358 undefined source-output cases are excluded: expanding an empty
packed axis to a positive count uses defined zeros in LuaRay, rather than
NumPy 2.5.3's uninitialized output. Added executable English/Spanish guides.

## 0.156.0-dev

Added native bincount for zero-origin category data, independent writable output,
optional float64 weights and minimum lengths. Includes sequential accumulation,
integer/Boolean coercion, strided/read-only/unaligned inputs, checked output size
and NumPy's empty-input weight bypass. Lua bindings offer positional arguments
or a strict weights/minlength options table.

Validated 6,937 NumPy 2.5.3 cases / 50,126 checks, 93 permanent Lua checks,
a native harness and C++ header/link execution. The corpus regenerates exactly;
48 oversized/source-overflow cases are excluded. Added executable English/Spanish
guides, including zero-origin labels versus one-based result indexing.

## 0.155.0-dev

Added native ravel_multi_index and unravel_index, using one-based Lua locations,
C/F logical order, broadcasting and per-axis raise/wrap/clip modes. Scalar inputs
return Lua integers; array coordinates are writable views of owned interleaved
storage. Added shared KEEPORDER axis planning without increasing ufunc operands.
Corrected six defensive multiplication-overflow checks in take/indexing to use
the helper's Boolean failure result.

Validated 40,822 NumPy 2.5.3 cases / 391,028 checks, 168 permanent Lua checks,
a native harness and C++ header/link execution. The corpus regenerates exactly.
Location rebasing, scalar representation and narrow/Boolean operand upcasts are
explicit adaptations. Another 1,472 unrepresentable-location cases and unsafe
upstream inputs were excluded. Added executable English/Spanish documentation.

## 0.154.0-dev

Added native invert/bitwise_count/left_shift/right_shift/gcd/lcm ArrayMethods,
four public aliases and Lua ~ / << / >> operators. Includes signed-magnitude
counts, checked shifts, arithmetic sign extension, fixed-width wrapping,
broadcasting, output masks and default-versus-uniform alias resolution.
Fixed noncanonical Boolean-to-numeric conversion and symmetric numeric alias
promotion. New integer functions reject unsupported option-table keys.

Validated 144,844 NumPy 2.5.3 cases / 3,318,010 checks, 6,242 new permanent Lua
checks, a native harness and C++ header/link execution. Both corpora regenerate
exactly; all 256 Boolean payloads are included. Scalar ufunc returns explicitly
follow LuaRay's typed rank-zero convention. Added executable English/Spanish guides.

Corrected the private sanitizer driver to derive rebuilds from its declared
harness list and verify ASan symbols in every listed object. The 0.153 release
received a published correction and a successful repeat audit of its unchanged
source; its initial report overstated the instrumented harness count by one.

## 0.153.0-dev

Added apply_over_axes with ordered/repeated axis callbacks, shared intermediate
state, singleton restoration, scalar-result coercion and preserved callback errors.
Fixed squeeze identity when no axes are removed and scalar reduction axis-table
validation. Implemented zero-width fixed-string sum, descriptor/out resolution,
initialized zero-stride results, masks and typed seeds including Boolean provenance.
Disjoint numeric outputs preserve committed seeds after string conversion errors.

Validated 193,600 NumPy 2.5.3 cases / 4,923,021 checks and 443 new Lua checks plus
a native harness and C++ header/link smoke. Scalar callback representations and
string returns are explicitly normalized to Lua conventions; 180 fresh reference
process groups avoid observed NumPy dtype/output dispatch-cache history. Added
executable English/Spanish guides. Full scalar-class and overlap failure-writeback
compatibility remains uncertified.

## 0.152.0-dev

Added apply_along_axis with shared one-dimensional callback views, C-order
invocation, first-result dtype/shape allocation, result-axis insertion and
broadcast assignment. Supports trailing Lua parameters including nil, callable
objects, read-only inputs and unchanged callback errors with prior writes retained.

Validated 60,768 NumPy 2.5.3 cases / 1,226,968 checks and 191 permanent Lua checks.
Reference axes use one-based Lua positions and keyword parameters map to Lua
arguments. Added executable English/Spanish guides; foreign subclasses and full
NumPy scalar classes remain unsupported.

## 0.151.0-dev

Added lazy ndindex iteration over one-based Lua coordinate snapshots with
C-order traversal, independent iterator/shape state, scalar/zero/Boolean shape
semantics and checked dimension arguments. No Cartesian product count or eager
axis allocation is needed; logical rank is independent of ndarray rank limits.

Validated 1,254 NumPy 2.5.3 cases / 39,746 checks and 91 permanent Lua checks.
Reference coordinates are normalized to Lua positions; large products compare
bounded prefixes only. Native-only tests exercise huge lazy dimensions without
attempting unsafe upstream range allocation. Added executable EN/ES guides.

## 0.150.0-dev

Added fromfunction: builds dense coordinate views, invokes a Lua callable once
and forwards its return values without coercion. Supports descriptor/string
coordinate dtypes, callable objects, trailing Lua context parameters, nil arity,
mutable/read-only views and unchanged callback errors.

Validated 2,160 NumPy 2.5.3 cases / 1,172,364 checks and 103 permanent Lua checks.
Reference keyword context maps to Lua positional parameters; tuple results map
to Lua multiple returns. Added executable English/Spanish callback guides.

## 0.149.0-dev

Added indices, ix_ and argwhere through the native range, layout, assignment
and nonzero engines with a Lua orchestration module. Includes dense/sparse
coordinate grids, retained mesh views, Boolean selection positions, grouped
nonzero locations, scalar/nil behavior and checked high-rank shapes.

Coordinate grid data retains NumPy's zero origin. Boolean mesh and argwhere
locations retain LuaRay's one-based index convention with explicit reference
normalization. Validated 6,063 NumPy 2.5.3 cases / 474,263 checks and 150 permanent
Lua checks. Added executable English/Spanish coordinate/indexing guides.

## 0.148.0-dev

Added ndarray conj/conjugate methods: real numeric input retains identity,
complex input uses the native conjugate engine, and optional outputs preserve
assignment/casting, broadcasting, aliasing and read-only semantics.

Validated 28,140 NumPy 2.5.3 cases / 340,632 checks and 82 permanent Lua checks.
Twenty-four complex scalar reference results are explicitly normalized to the
existing Lua rank-zero ndarray convention; numerical bytes remain exact and
representation/writeability checks follow that declared adaptation. Expanded
and enabled execution of the English/Spanish component documentation.

## 0.147.0-dev

Added native per-item getfield/setfield views and writes with retained shape,
strides and storage ownership, checked byte offsets, broadcasting and alias
handling. Ordinary sequences retain CopyObject rank limits and partial-prefix
writes on equal-shape packing failures. Typed arrays keep unsafe array casts.

Preserved temporal scalar packing separately from array casting, including
signed item/bounds rules, date text truncation and duration cast width limits.
Shared full temporal scalar text formatting with the existing cast subsystem.
Validated 233,460 NumPy 2.5.3 cases / 2,680,078 exact checks, 104 permanent Lua
checks and native regressions. Added executable English/Spanish field guides.

## 0.146.0-dev

Added native `ndarray:byteswap` with independent ANYORDER copies or in-place
mutation, preserved dtype metadata, complete component payloads, Unicode code
points and source write ordering for overlapping views. Read-only in-place
requests fail even for empty arrays and no-op dtypes.

Corrected exact/bounds memory queries for zero-width strided arrays, retaining
the upstream reflected-address solver corner case. Validated 45,504 NumPy
2.5.3 cases / 262,320 exact checks across two reproducible corpora, 108 permanent
Lua checks and native regressions. Added executable English/Spanish guides.

## 0.145.0-dev

Added native `resize` and `ndarray:resize`: independent C-order repetition,
empty-input zero filling, physical in-place growth/shrink and checked storage
ownership. Lua aliases follow the same userdata; reallocation with live views
is blocked even when refcheck=false. Shape-only changes can retain shared storage.
Read-only Unicode growth is initialized deliberately; numeric tails stay unspecified.

Corrected default Unicode concatenation endian resolution and zero-width
reshape contiguity flags. Validated 18,248 NumPy 2.5.3 cases / 313,948 exact
checks, 156 permanent Lua checks and native ownership/boundary regressions.
Added executable English/Spanish resizing guides. All Lua docs use `lr`.

## 0.144.0-dev

Added native datetime/timedelta arange with common-unit resolution, calendar
conversion, relative endpoints, default ticks and checked allocation bounds.
Explicit numeric dtypes retain the source numeric dispatcher, temporal item
conversion and scalar/array packing distinctions. Existing legacy calls remain.

Corrected datetime metadata factors and common-class promotion. Temporal ufunc
inputs now enforce default same-kind casting separately from promotion. Shared
integer-item classification moved into the native datetime subsystem.

Validated 65,082 NumPy 2.5.3 cases / 301,408 exact checks across three corpora,
plus 98 permanent Lua checks and native regressions. Unsafe/oversized source
states are excluded explicitly. Added executable English/Spanish temporal guides.

## 0.143.0-dev

Extended arange to numeric rank-zero array arguments. Native dtype promotion
and arithmetic preserve the source distinctions between original arrays and
computed scalars, including initial packing bounds, intermediate precision and
complex length selection. Read-only and unaligned inputs stay unchanged;
results own independent writable storage. Temporal ranges remain pending.

Validated 17,508 NumPy 2.5.3 cases / 250,603 exact checks, 35 new permanent Lua
checks and native regressions. Significant longdouble bytes are exact; padding
is canonicalized in input fixtures and omitted from value comparisons. Added
executable English/Spanish documentation for typed range arguments.

## 0.142.0-dev

Expanded arange from the legacy stop-only helper to native numeric scalar
start/stop/step ranges, preserving legacy integer-stop/positional-dtype conversion
and adding descriptor and option-table controls. Supports numeric/Boolean/complex output with source
initial scalar conversion, effective typed increments, integer wrap and complex
length rules. Typed ndarray and temporal range arguments remain pending.

Validated 12,901 NumPy 2.5.3 cases / 129,151 exact checks and 125 permanent Lua
checks plus native regressions. Extended-precision padding bytes are excluded;
significant numeric payloads are checked exactly. Added executable EN/ES guides.

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
