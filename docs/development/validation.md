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
[vector/grid reference](../vectors_and_grids.md) describes the contract.

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
reports 409 of 675 scoped names as available and classifies all available APIs
as partial; it is not a measure of overall NumPy completion.

## Current source-tree checks

LuaRay **0.152.0-dev** passed **67 native suites**, **122 Lua suites**, seven public
examples and 318 executable documentation blocks. Diagonal references retain **47,886 cases / 4,571,474 checks**. Trace references
passed **20,861 cases / 853,519 exact checks** against NumPy 2.5.3, including
metadata, dtype/output resolution, aliasing, temporal units and backing states.

Triangular references passed **18,142 cases / 1,754,183 exact checks**, including
batch storage order, typed mask conversion, empty axes, and extreme index rules.

Vandermonde references passed **11,584 cases / 441,741 checks**. Ordinary cases
and metadata compare exactly; general random floating/complex values use a fixed
relative3e-15 budget. Observed absolute and relative numerical errors were zero.

Identity/eye references passed **13,335 cases / 261,220 exact checks**, including
C/F order, dtype conversion, offsets, empty axes and temporal unit requirements.

Diagonal-index and scalar-string references passed **1,766 cases / 81,899 exact checks**, including one-based coordinate adaptation, repeated-vector identity, real advanced writes, fixed-width scalar assignment and constructor formatting.

Triangular-index helpers passed **9,908 cases / 487,084 exact checks**, covering independent contiguous vectors, rectangular/empty dimensions, extreme offsets, advanced read/write and backing states across dtypes and views.

Fill-diagonal references passed **29,960 cases / 1,292,460 exact checks**, including logical flat traversal, repetition/wrap, scalar/typed conversion differences, read-only destinations and progressive shared-memory values.

Kronecker/integer-duration references passed **13,776 cases / 1,018,781 checks**. General random complex64 kron values use relative3e-7 and wider values3e-15, with observed error zero. Integer-duration tests cover NaT, coefficient casts, masks, unit-conversion bounds, defined overflow writes and buffer boundaries. In **176 buffered conversion failures**, NumPy produced nondeterministic uninitialized suffixes; those cases compare only the defined prefix and full metadata. The observation log is a separate release asset.

Tensordot executed **22,615 cases / 2,304,132 checks**: **22,461 parity-eligible cases**, plus **154 object-result cases explicitly blocked**. General random contractions use absolute+relative3e-6 for float32/complex64 and2e-12 for wider types. Observed maxima were absolute1.9073486328125e-6 and relative1.3520483676605e-5. BLAS result zeros accept either sign, with44 observed differences; input and non-BLAS result zero signs remain exact. Tests cover the native output-rank guard and legacy duration-dot units/wrapping.

Callback-mask references passed **2,551 cases / 152,065 exact checks**, covering real callback inputs, parameter forwarding, numeric/text/temporal masks, view layouts, one-based coordinates, actual indexed writes and the explicit Lua-sequence adaptation. The API inventory now probes the public Lua entry point, including Lua-composed functions.

Finite differences and join layouts passed **56,404 cases / 2,620,156 exact checks**:34,210 diff/ediff1d cases and22,194 concatenate/stack cases. Scope includes padding, identity, real writable/backing states, Boolean/unsigned/time dtypes, NaT/nonfinite values, empty dimensions and C/F/strided layouts. The maximum Lua order was executed locally; the matching enormous NumPy loop was not run.

Gradient and duration division passed **31,024 cases /1,250,944 checks**:25,750 gradient cases and5,274 division cases. Gradient absolute+relative budgets are5e-3 for half,5e-6 for float32/complex64 and2e-12 for wider types; observed numerical errors were zero. Exact metadata, unchanged inputs, writable independent results, common units, NaT, masks and aliased output views are checked. The42 permanent Lua checks exercise public behavior and argument errors.

Trapezoidal integration passed **7,341 cases /260,004 checks** and31 permanent Lua checks. Scope includes uniform/uneven/decreasing coordinates, axes and broadcasting, views, empty dimensions, integer wrap, NaT and temporal units. Absolute+relative budgets are5e-3 for half,5e-6 for float32/complex64 and2e-12 for wider types. Observed maxima were absolute8.8817841970013e-16 and relative2.6737044432591e-16; metadata and input/backing states compare exactly.

Phase unwrapping passed **5,462 cases /291,583 checks**, with28 permanent Lua checks. Scope includes even/odd/zero/negative periods, weak/typed promotion, thresholds and broadcasting, views, NaN and int64 extremes. Results are checked for independent writable storage. Absolute+relative budgets are5e-3 for half,5e-6 for float32 and2e-12 for wider types; observed errors were zero.

Phase angles passed **3,212 cases /307,602 checks**, with22 permanent Lua checks. Scope includes signed complex zeros, degrees/radians, real/complex promotion, views and nonfinite values. Relative budgets are2e-3 for half,3e-6 for float32 and2e-12 for wider types. Observed maxima were absolute1.52587890625e-05 and relative1.4020190897517e-07. Signed zeros, metadata and input/backing states compare exactly.

Linear interpolation passed **1,531 cases /137,255 checks**, with37 permanent Lua checks. Scope includes real/complex results, scalar/empty queries, conversions, boundaries, periodic grids, views, nonfinite values and guess-assisted search. Of these,68 tied periodic cases use the NumPy kernel after its generic portable quicksort;12 differ from its default CPU path and are not declared equivalent. The absolute+relative budget is2e-12, with zero observed error against the declared reference; metadata and input/backing states compare exactly.

Equality, closeness and temporal core passed **27,384 cases /1,186,383 exact checks**:8,482 equality,4,478 closeness and14,424 temporal cases. The48 permanent Lua checks and new native test exercise shapes, broadcasting, weak/typed promotion, NaN/NaT, identity, writable independence, extended-precision thresholds, integer offsets, masks and completed writes before overflow. Extended inputs avoid float64 serialization and normalize x87 padding. Warning/error-state objects and all floating ABIs are not certified.

Elements, filling and calendar casts passed **26, 844 cases /684, 401 exact checks**: 11, 813 item, 10, 801 fill and 4, 230 casting/metadata-resolution cases. The 56 permanent Lua checks and new native test include logical C indices, coordinates, detached lossless values, GC, unaligned storage, scalar aliases, Boolean packing, empties, NaT, temporal scalar conversions and calendar limits. Unit factors resolve before iteration, including zero elements; scalar and array false-mask shortcuts remain distinct. All 161 historical references pass again without changing their assertions.

Buffer construction passed **17,290 cases /229,717 exact checks** covering raw bytes, dtype, shape, strides, ranges, errors, sharing and write-through states. The 48 permanent Lua checks and new native test include GC, creating-coroutine collection, final release, immutable sources, alignment and overlapping external owners. Expanded instrumentation exposed and helped fix an earlier scalar-assignment temporary that was too small for complex256.

Flags passed **12,510 cases /1,684,290 exact checks** covering layout, ownership, aliases, bits, root/view permissions, alignment, snapshots and failure rollback. The 46 permanent Lua checks and new native test include array retention and logical permissions of roots whose original headers are no longer exposed. `uic`/WRITEBACKIFCOPY remains unimplemented.

Requirements and creation passed **18,430 cases /1,116,960 exact checks**, with 36 permanent Lua checks and expanded native regressions. They verify identity, flags, layout, conversions, sharing and backing states after writes, including immutable and physically unaligned buffers. Dtype-changing ANYORDER transfers preserve axis order; same-dtype ANYORDER copies retain their separate contract.

Metadata queries passed **892 cases /50,182 exact checks**, with 35 permanent Lua checks. They verify shapes, ranks, integer counts, axis acceptance and unchanged states, including rank64 and huge broadcast views without data traversal. Existing Lua creation/protocol restrictions remain explicit.

Dtype descriptors and their dependencies passed **12,398 cases /294,470 checks**: 1,208 property/relation, 2,790 argument, 7,680 temporal/reduction-selection and 720 unsized-join cases. The 64 permanent Lua checks and new native test cover initialized Unicode, aliases, casts, NaT and overflow. A C++ header/link smoke test also passed. Durations and metadata are exact; numeric sampling uses relative2e-3 for half,3e-6 for float32/complex64 and2e-12 for wider types. Reducers use relative3e-6 for float32/complex64 and2e-12 for wider types; zero is exact. Historical references still pass with their assertions unchanged.

The ndarray constructor passed **24,204 cases /240,870 exact checks** of acceptance, bytes, dtype, shape, strides, flags, sharing and writes. Another 2,420 unsafe or unverified upstream parameter states were skipped; these are not compatibility passes. String-body alignment above eight bytes is host dependent and omitted; array and owned alignment remain exact. The 62 permanent Lua checks and native harness cover GC, coroutines, permissions and safety rejection. Corpus regeneration was exact and a C++ header/link smoke test passed.

Numeric arange passed **12,901 cases /129,151 exact checks**, plus 125 permanent Lua checks and a native harness. References compare significant bytes, initial conversion, effective increments, wrapping, complex lengths, errors and metadata. Another 138 oversized or outside-Lua-integer inputs were excluded. On the tested x86 ABI, each longdouble component has ten significant bytes checked and six padding bytes omitted. Regeneration was exact and a C++ header/link smoke test passed. Typed ndarray arguments and temporal ranges remain pending.

Typed rank-zero arange arguments passed **17,508 cases /250,603 exact checks**, 35 new Lua checks and a native harness. Read-only/unaligned sources retain their data and permissions; references cover intermediate precision, initial conversion, integer bounds and complex length selection. Another 56 oversized allocations and 70 rejected source-array constructions were excluded before arange execution. Longdouble input-fixture padding is zeroed and omitted from comparisons; all ten significant bytes per component remain exact. Regeneration was exact and the C++ header/link smoke passed. Temporal ranges remain pending.

Temporal ranges and their dependencies passed **65,082 cases /301,408 exact checks**: 28,086 range/numeric-dispatch, 33,124 unit-promotion and 3,872 operation/casting cases. Another 98 new Lua checks, the native harness and C++ header/link smoke passed. Temporal ticks compare all eight bytes; numeric longdouble omits six padding bytes per component and checks ten significant bytes. Another 1,190 unsafe/oversized states and 308 argument-construction errors were excluded before range execution, not counted as compatibility. Verified relative-NaT and scalar/array conversion quirks are retained. All three corpora regenerated exactly.

Resize and layout/Unicode regressions passed **18,248 cases /313,948 exact checks**: 7,776 repeated copies, 7,128 method cases and 3,344 regressions. Another 156 new Lua checks, the native ownership/reallocation harness and C++ header/link execution passed. Only initialized bytes are compared; undefined read-only growth tails are never read. Longdouble omits ABI padding. All three corpora regenerated exactly.

Byteswap and zero-width memory queries passed **45,504 cases /262,320 exact checks**: 9,504 swaps and 36,000 exact/bounds query pairs. Another 108 new Lua checks, the native harness and C++ header/link execution passed. All initialized bytes, including longdouble padding, are checked without decoding raw payloads. Both corpora regenerated exactly.

Getfield/setfield passed **233,460 cases /2,680,078 exact checks**: 79,632 views and 153,828 assignments. Another 104 new Lua checks, the native harness and C++ header/link execution passed. Initialized bytes, full backing states, partial failures, scalar/array distinctions and metadata compare exactly. Both corpora regenerated exactly.

The conj/conjugate methods passed **28,140 cases /340,632 checks** and 82 permanent Lua checks. Source/output identity, casting, aliasing, read-only and post-write states include NaN/inf/signed zeros. Twenty-four NumPy scalar results were explicitly normalized to the Lua unary rank-zero array convention: numerical bytes/dtypes are exact, while representation/writeability checks follow that declared adaptation rather than claiming scalar-object parity. Longdouble omits ABI padding. The corpus regenerated exactly.

Indices/ix_/argwhere passed **6,063 cases /474,263 checks** and 150 permanent Lua checks: 1,344 grids, 2,539 meshes and 2,180 location queries. Values, metadata, sharing and real writes/backing states include empty/scalar/read-only inputs and up to 64 dimensions. Grids preserve zero-based data. Another 438 Boolean axes and 13,671 argwhere coordinate values were normalized to one-based Lua locations; metadata remains directly compared. Longdouble omits ABI padding. All three corpora regenerated exactly.

Fromfunction passed **2,160 cases /1,172,364 checks** and 103 permanent Lua checks: invocation/argument/return counts, values, metadata, identity, sharing, mutation and errors. Source keyword context was mapped to trailing Lua parameters and tuples to multiple returns; the implementation does not coerce results. Coordinate data retains zero origin. Longdouble omits ABI padding. The corpus regenerated exactly.

Ndindex passed **1,254 cases /39,746 checks** and 91 permanent Lua checks: C traversal, independent snapshots, exhaustion, scalar/empty/Boolean/invalid shapes and high rank. Another 26,626 coordinates were normalized to one-based Lua positions. Large Cartesian products compare bounded prefixes, not exhaustive traversal. Native regressions test huge lazy dimensions without attempting upstream eager allocation. The corpus regenerated exactly.

Apply_along_axis passed **60,768 cases /1,226,968 checks** and 191 permanent Lua checks: axes and callback order, shared views, exact payloads/metadata, first-result dtype/shape, dimension insertion and broadcasting, mutation, read-only and error paths. Positive axes were normalized to Lua positions and Python keyword context to Lua arguments. The corpus regenerated exactly; longdouble ABI padding is explicitly omitted.

The directed ASan/UBSan run instrumented `ln_write`, `lua_elements`, `ln_dtype_transfer`, `ln_datetime_strings`, `ln_join`, `ln_condition`, `ln_dot`, `ln_matrix`, `ln_linalg`, `lua_matrix`, `lua_module`, `ln_time_scale`, `ln_ufunc`, `ln_nditer_multi`, `ln_datetime`, `ln_core`, `lua_buffers`, `ln_mapping`, `ln_nditer`, `ln_take`, `ln_choose`, `lua_flags`, `ln_components`, `ln_creation`, `lua_metadata`, `ln_dtype_info`, `lua_dtype`, `ln_string`, `lua_creation`, `lua_bytes`, `ln_sampling`, `ln_constructor`, `lua_constructor`, `ln_arange`, `lua_arange`, `ln_arange_time`, `ln_resize`, `lua_resize`, `ln_layout`, `ln_bytes`, `lua_components`, plus the Lua runner and fourteen native harnesses. All maintained suites and all 54 cumulative reference corpora passed. Other dependencies were not fully instrumented; leak detection was disabled. Packaging verifies the executable-source fingerprint.

## Release integrity

Release assets include a source archive, its SHA-256 checksum, and a separate
verification JSON. The archive contains `PROJECT_SHA256SUMS`, generated during
packaging. This manifest is not kept in the working tree, where ordinary edits
would immediately make it stale.

The release tooling preserved in the source package verifies the embedded
manifest after extracting the archive,
then builds and executes its checks from that clean source directory. Verified
assets and release tags remain immutable.
