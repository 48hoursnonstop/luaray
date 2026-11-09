## 0.109 — NumPy2.5.3 binary math, strings and logical promotion

Ten hashes in NUMPY_2_5_3_BINARY109_FILE_HASHES.sha256 pin generated signatures,
integer fmod loops and real/half arithmetic, complex power source, dispatching.cpp
logical_ufunc_promoter, string_ufuncs.cpp addition/descriptor resolution and
string_buffer.h content lengths, plus source tests. Existing NumPy BSD attribution
is retained. ln_binary_math.c provides two independently registered numeric
operations and descriptor-aware string-add methods for the shared add registry.

Fmod uses dividend-sign integer modulo with explicit zero/-1 guards, and the
appropriate real/half fmod precision. Float_power registers only double,
longdouble, complex128 and clongdouble signatures, preserving weak scalar
precision until that forced resolution. Scalar/table Lua entry points parse
options before pushing rooted temporaries and keep ndarray/scalar strength.

The original coercion references exposed two older gaps. S/U add now sums
metadata widths, canonicalizes Unicode byte order, trims trailing padding and
retains embedded NUL. Existing staged output supports casts/truncation and shared
views. Excess widths are rejected before allocation, even for zero-sized arrays.
Binary logical operations now use the source boolean promoter. Weak tiny real/
imaginary values become truth before narrow numeric conversion; fixed-width
strings use nonempty stored contents. Unary logical_not remains separately scoped.

Four new fixtures preserve observed behavior; historical numerical assertions
remain unchanged. The native registry count increases71 to73 for two functions;
string addition adds signatures rather than new function names. Full143-fixture
regression and the directed25-unit sanitizer audit passed. English/Spanish docs
record scalar return adaptation, raw Lua string class semantics, numeric tolerance
and remaining protocols. No Python runtime is introduced.

## 0.108 — NumPy2.5.3 typed unary loops and physical iteration

Ten source/test hashes in NUMPY_2_5_3_UNARY108_FILE_HASHES.sha256 pin signatures
from generate_umath.py, scalar/half/complex formulas from loops.c.src, modular
integer behavior from loops_autovec.dispatch.c.src, FP/SIMD math dispatch and
npy_math_internal.h.src angle constants. The existing NumPy BSD attribution is
retained. ln_unary_math.c registers ten operations independently of the legacy
binary-op enum, with three equivalent public aliases. The shared Lua unary
entry point parses options before coercing ordinary scalar/table inputs.

Complex-square differential tests exposed two source-level requirements: the
FMA product ordering used by eligible SIMD paths, and traversal of the actual
KEEPORDER axis permutation rather than always taking the last logical axis.
The generalized iterator now uses its computed physical permutation. Existing
staged output/writeback remains safe for shared views. Exact equal memory ranges
are vector-eligible in upstream loops_utils.h.src; they do not imply a scalar
fallback. Thirty-eight additional strict cases verify layouts, masks, in-place
and reversed overlapping writeback. No per-call alias-context extension was
needed. Full139-fixture regression passed after the iterator change.

Integer square uses explicit unsigned modular operations without signed C UB.
Integer reciprocal zero preserves the audited x86 results without undefined
infinity-to-integer casts. Other ABI/CPU dispatch and nondefault rounding modes
remain uncertified. General complex square/reciprocal tolerances and all API
limits are stated in English/Spanish docs. New fixtures use NumPy2.5.3; historical
fixtures retain their provenance and assertions except the intentional native
registry count increase61 to71 and release version assertions. No Python runtime.

## 0.107 — NumPy2.5.3 creation and explicit Lua ownership

Creation/conversion follows multiarraymodule.c array/asarray/contiguity entry
points and _prepend_ones, ctors.c NewLikeArrayWithShape, and numeric.py's full/
zeros_like/ones_like/full_like compositions. _function_base_impl.py supplies
asarray_chkfinite's inexact-only check. C/F/A/K allocation, conditional copying,
identity, read-only propagation and rank-changing K fallback are executed through
the actual native Lua API. The new independently compiled lua_creation.c uses
lua_array_api.h's explicit borrowed/rooted/owned boundary with the metatable module.

arraytypes.c scalar setitem and datetime.c object conversion distinguish scalar
integer construction from raw numeric array casting into generic datetime.
The misplaced transfer-layer rejection moved to scalar packing; known temporal
userdata uses its typed raw setter. Generic temporal descriptors inherit source
units during conversion. Date scalar unsized strings use actual ISO width;
timedelta scalar discovery retains legacy width21. Fixed-string empty descriptors
finalize at the constructor minimum1. Fourteen source/test hashes are pinned in
NUMPY_2_5_3_CREATION107_FILE_HASHES.sha256. NumPy BSD attribution is retained.

The pre-existing LuaRay astype numeric-to-generic-datetime restriction remains
at its own adapter boundary, preserving the old string-cast regression contract.
It is explicitly a partial compatibility difference, not a claim about NumPy2.5.3
root Array API astype parity. Old assertions were retained. New creation functions
use source-derived raw-array casts. New original oracle/source are2.5.3; older
frozen fixtures retain their recorded provenance. No Python runtime is introduced.

## 0.106 — NumPy2.5.3 sequence sampling and native Dragon4

ln_sampling follows _core/function_base.py linear/log/geometric composition,
including array_converter.c weak-scalar resolution, typed arange, subnormal
fallback, endpoint assignment, integer floor and sign/log rotation. The dedicated
creation allocator follows ctors.c NewLikeArray KEEPORDER and is shared by roll.
Ufunc trivial-loop output allocation follows ufunc_object.c. Complex-to-real
casting preserves arraytypes.c.src's original component type; dispatched complex
multiply follows loops_arithm_fp's FMA operand order on supporting hosts.

The licensed numerical portion of dragon4.c and enums from dragon4.h were
adapted to native ABI types and thread-local scratch. Python entry wrappers,
interpreter headers and PyErr calls were removed. Native bounded caller-owned
output replaces Python Unicode creation. The original MIT copyright/license and
NumPy attribution remain in the imported source/private header; NumPy BSD license
is bundled. tools/import_dragon4.py checks the exact upstream C hash and reproduces
the native import. Scalar string conventions/cutoffs follow scalartypes.c.src.
Seventeen source/test hashes are pinned in
NUMPY_2_5_3_SAMPLING106_FILE_HASHES.sha256. New original oracle/source are2.5.3;
older fixtures retain their recorded provenance. No Python runtime is introduced.

## 0.105 — NumPy2.5.3 FFT helpers and actual compute precision

ln_fft_helpers follows fft/_helper.py frequency-bin and roll compositions, and
fft/_pocketfft.py hfft/ihfft conjugation and norm swapping. Typed frequency
spacing uses the existing native weak-scalar ufunc resolver. Conjugation follows
NpyIter KEEPORDER; zero-stride roll allocation follows ctors.c's stride sorting.
_pocketfft.py normalization and _pocketfft_umath.cpp exact input loops establish
half normalization and retained float32/complex64 computation with wider output.
Unsupported dtype validation precedes output-driven promotion. Read-only output
checks prevent writes. Source/tests are pinned in the nine-file
NUMPY_2_5_3_FFT105_FILE_HASHES.sha256. NumPy BSD license and bundled PocketFFT
license/attribution remain included. Source and executable oracle are2.5.3;
older fixtures retain their own recorded provenance. No Python runtime dependency.

## 0.104 — NumPy2.5.3 where/select and API availability

ln_select follows multiarraymodule.c:PyArray_Where and _function_base_impl.py:
select. The existing generic iterator supplies where's KEEPORDER and cast
buffering; nontrivial element widths convert selected values only. Select
preserves separate condition/value broadcasting, default unsafe fill, reversed
same-kind masked writes and C-output. Shape folding follows _stride_tricks_impl's
batches so many conditions do not inherit the legacy64-operand limit.

Shared dtype preparation retains weak numeric values. Temporal common dtype
now rejects uint64 as the inspected promotion semantics require. Ndarray
sequence items retain strong0-D views, including choose's1-D choices. Original
cases exposed these defects; no reference expectations were altered to hide them.
Twelve inspected source/test hashes are pinned in
NUMPY_2_5_3_SELECT104_FILE_HASHES.sha256. Source and executable oracle are2.5.3.

The new API inventory introspects pinned NumPy public callable names and queries
an actual compiled Lua module/prototypes. It measures direct name availability,
classifies every available binding as partial, and separately justifies the
Python exception-class/Lua-error adaptation. It is not full behavioral coverage.

## 0.103 — NumPy 2.5.3 nonzero and condition selection

ln_condition follows item_selection.c:PyArray_Nonzero and PyArray_Compress,
numeric.py:flatnonzero and _function_base_impl.py:extract. Coordinate storage
is an owned (count,ndim) integer array with per-axis strided views, including
valid shared empty data and rank-64 metadata. C-order coordinates are adapted
to positive Lua indices; the returned Python tuple becomes a Lua table.

Compress snapshots nonzero condition positions before calling the verified
raise-mode take engine. Extract flattens condition/source independently. Short
conditions and overlong false tails retain upstream behavior; no extra exact-
length requirement is imposed. Raw Lua compress conditions are packed to bool;
strong arrays use supported dtype truth conversion. Methods and public wrapper
semantics were inspected together with relevant numeric/multiarray/function-
base tests. Eight source/test hashes are pinned in
NUMPY_2_5_3_CONDITION103_FILE_HASHES.sha256. Source and executable oracle are
2.5.3; older frozen fixture provenance is unchanged.

## 0.102 — NumPy 2.5.3 choose and temporal dtype transfer

ln_choose follows item_selection.c:PyArray_Choose / legacy MultiIter C traversal,
common writable-contiguous choices, safe intp selectors, staged raise/dtype/
choice-overlap output and raw linear direct-output writes. Lua positions are
explicitly one-based; negative raise choices remain invalid. Weak numeric
choice conversion follows PyArray_ConvertToCommonType, including uint8 wrapping.

Actual source-derived differences are retained: unsafe direct-output spans are
rejected before modifying memory, and extreme wrap uses modulo rather than
repeated subtraction. Unsafe upstream overruns were not executed. Safe spans
and resulting unexpected logical-view backing states are original references.

Shared datetime conversion follows dtype_transfer.c and datetime_strings.c:
fixed ISO capacity errors, partial ASCII cells, buffered Unicode, NaT and Linux
year snprintf capacity behavior. Cross-kind date/delta unsafe casts preserve
raw ticks; same-kind unit conversion remains distinct. Ten source/test/header
hashes are pinned in NUMPY_2_5_3_CHOOSE102_FILE_HASHES.sha256. Executable oracle and
source are NumPy 2.5.3; historical oracle metadata remains unchanged.

## 0.101 — NumPy 2.5.3 along-axis functions and MapIter

`ln_along.{c,h}` follows numpy/lib/_shape_base_impl.py's take_along_axis,
put_along_axis and _make_along_axis_idx: orthogonal index ranges, matching rank,
bidirectional broadcasting and public default/explicit-axis differences.
The flat path follows iterators.c:iter_array, preserving writable contiguous
views and read-only noncontiguous copies. Source and executable oracle are 2.5.3.

Shared ln_mapping corrections follow mapping.c's overlapping index snapshots,
MapIter KEEPORDER output and buffered input casts, and nditer_constr.c's stable
axis ordering / negative-stride rules. An 8,192-element all-fancy conversion
buffer reproduces tested post-error boundaries. General mixed slice/subspace
buffering remains a separate compatibility area. Original reference values and
metadata were not replaced with idealized order or atomic-write expectations.

Nine inspected implementation/test files are pinned in
NUMPY_2_5_3_ALONG101_FILE_HASHES.sha256. Upstream shape-base tests informed explicit
bidirectional broadcast cases. Earlier oracle provenance remains unchanged.

## 0.100 — NumPy 2.5.3 take and legacy string conversion

The native ln_take subsystem follows item_selection.c's PyArray_TakeFrom and
npy_fasttake_impl: axis shape replacement, same-kind index conversion,
C-contiguous source, staged/typed output, preconversion and per-index chunk
loads. Lua coordinates are explicitly adapted. Public methods/wrappers and
reference tests were inspected; hashes are pinned in
NUMPY_2_5_3_TAKE100_FILE_HASHES.sha256. Legacy string conversion was additionally
checked with actual NumPy astype/copyback behavior for truncation errors,
failed-cell preservation and embedded NUL characters.

The wrap algorithm uses modulo instead of repeated addition/subtraction.
The empty-axis zero-trailing-chunk infinite loop is deliberately rejected;
one actual NumPy subprocess timeout confirms the representative call. Three
retained variants remain outside the 6,704 original parity cases. NumPy source
and executable oracle are both 2.5.3; earlier 2.3.5 fixtures are unchanged.
No Python implementation is executed in the normal Lua runtime.

## 0.99.1 — inverse-exponential precision on older libm

The same NumPy distributions.c inverse-CDF expression is evaluated in double
before float32 rounding to avoid observed glibc 2.39 log1pf errors. Uniform input
precision and PCG64 consumption are unchanged. This is an explicit numerical
evaluation difference from a direct platform log1pf call, verified against the
existing exact oracle and 80-digit arithmetic. No cross-platform bit guarantee
for all functions is inferred. The official diagnostic package metadata is at
https://packages.ubuntu.com/noble/amd64/libc6/download ; tested archive SHA-256
ff5557d99b51f761c4b7c92368b9cc45565eda17df9bf9eb4b134d09825008be.
The library was extracted locally and only diagnostic functions loaded; actual
Ubuntu full-suite results come from remote CI 42526947924.

## 0.99 — NumPy 2.5.3 raw masked assignment

`ln_write.c` follows array_assign_array.c, array_assign_scalar.c, shape.c's
stride permutation, dtype_transfer.c's raw iterators, mask-run wrapper and
128-element multistep casts. Lua literal resolution follows multiarraymodule.c
and abstractdtypes.c. Shared dtype transfer fixes preserve source identity bytes,
memmove overlap and complex real-component temporal conversion. Ten inspected
source/test hashes are pinned by `NUMPY_2_5_3_MEMORY99_FILE_HASHES.sha256`.

Both source and new executable oracle are NumPy 2.5.3. Original post-error and
aliasing outcomes are preserved, including non-atomic cases and the descriptor-
width-dependent cast buffer boundary. No altered reference is used to hide them.
Historical NumPy 2.3.5 oracle provenance is unchanged.

## 0.98 — NumPy 2.5.3 indexed and selected writes

`src/ln_write.c` derives from `PyArray_PutTo` in
`numpy/_core/src/multiarray/item_selection.c` and `arr_place` in
`numpy/_core/src/multiarray/compiled_base.c`. Public wrappers in
`numpy/_core/fromnumeric.py` and `numpy/lib/_function_base_impl.py` and their
upstream tests were inspected. Conversion source anchors are dtype_transfer.c
and lowlevel_strided_loops.c.src. Eight actual file hashes are pinned in
`NUMPY_2_5_3_WRITE98_FILE_HASHES.sha256` and the NumPy license is retained.

This version uses **NumPy 2.5.3 for both source and the executable oracle**.
It does not relabel prior frozen fixtures generated using NumPy 2.3.5.
Positive index translation is the documented Lua adaptation. Forty unavailable
numeric-byte-order states retain their original outputs and are classified
separately from supported put/place comparisons. Live place aliasing and put's
partial/discarded error mutation are preserved rather than replaced by idealized
snapshot expectations.

## 0.94 — NumPy 2.5.3 scalar subtype hierarchy and Unicode scalars

- `numpy/_core/numerictypes.py`: public `issubdtype` class/type coercion semantics.
- `numpy/_core/src/multiarray/convert_datatype.c`: scalar minimum DType selection.
- `numpy/_core/src/multiarray/abstractdtypes.c`: abstract DType classes and semantics.
- Source hashes: `NUMPY_2_5_3_DTYPE94_FILE_HASHES.sha256`; executable oracle: NumPy 2.3.5.

## 0.93 — NumPy 2.5.3 DType scalar selection

Audited the scalar range selection in `numpy/_core/src/multiarray/convert_datatype.c`
and `abstractdtypes.c`. Source-file SHA-256 values are in
`NUMPY_2_5_3_DTYPE93_FILE_HASHES.sha256`. Runtime differential oracle: NumPy
2.3.5, recorded fixtures, no runtime Python dependency in LuaRay.

## 0.92 — ndarray.astype memory order and casting (NumPy 2.5.3)

- `numpy/_core/src/multiarray/methods.c`: `ndarray.astype` argument parsing and copy behavior.
- `numpy/_core/src/multiarray/ctors.c`: array allocation and memory-order decisions.
- `numpy/_core/src/multiarray/can_cast_table.h`: builtin casting safety.
- `numpy/_core/src/multiarray/convert_datatype.c`: dtype casting and transfer logic.
- Four upstream source hashes are pinned in `NUMPY_2_5_3_DTYPE92_FILE_HASHES.sha256`; executable reference is NumPy 2.3.5.

## 0.91 — NumPy 2.5.3 DType promotion source reference

- `numpy/_core/src/multiarray/common_dtype.c`: DType class common-dtype ordering.
- `numpy/_core/src/multiarray/convert_datatype.c`: type resolution and promotion.
- `numpy/_core/src/multiarray/array_coercion.c`: descriptor discovery and coercion.
- SHA-256 checksums of all three upstream files pinned in
  `NUMPY_2_5_3_DTYPE91_FILE_HASHES.sha256`.
- The executable NumPy 2.3.5 oracle was independently frozen into
  `tests/dtype91_differential_generated.lua`.

## 0.90 — exact integer table inputs and Fortran-stride validation (NumPy 2.5.3)

- `numpy/random/_bounded_integers.pyx.in`: integer bounds and NumPy's
  dtype-specialized sampling/array iteration; source hash retained in
  `NUMPY_2_5_3_RANDOM90_FILE_HASHES.sha256`.
- `numpy/random/_generator.pyx`: `Generator.integers` signature and
  argument-coercion semantics.
- `src/lua_module.c`: resolves rounding of all-integer Lua table bounds by
  preserving `int64`; sampler in `src/ln_random.c` remains unchanged.
- Reproduced 5,880 tests with NumPy 2.3.5; includes Fortran-transposed and
  negative-stride cases; no Fortran mismatch observed in this expanded set.

## 0.89 — array-like bounds for `Generator.integers` (NumPy 2.5.3)

- `numpy/random/_generator.pyx`: dispatches native bounded samplers for the nine supported integer/bool dtypes.
- `numpy/random/_bounded_integers.pyx.in`: array parameter coercion, broadcast iteration, bounds validation, `endpoint` semantics and small-integer buffering. Certain Fortran-order input views still differ in NumPy's multi-iterator traversal/output mapping; this limitation is recorded explicitly rather than hidden.
- The C sampler remains in `src/ln_random.c`; no Python dependency at runtime.
- NumPy 2.5.3 source hashes were checked against the supplied tarball. Executable differential fixture uses NumPy 2.3.5.

## 0.88 — native Generator `out` buffer support

- `numpy/random/_generator.pyx`: `Generator.standard_normal` and `Generator.standard_exponential` accept an `out` array and separate float32/float64 paths, with `zig`/`inv` exponential methods.
- Physical fill order for Fortran-contiguous outputs verified experimentally against the NumPy 2.3.5 executable reference.
- `numpy/random/src/distributions/distributions.c`: native Ziggurat/inverse distribution kernels already ported to LuaRay.
- Source NumPy 2.5.3 SHA-256 evidence: `NUMPY_2_5_3_RANDOM88_FILE_HASHES.sha256`.

## 0.87 — Zipf / hypergeometric vectorization (NumPy 2.5.3)

- `numpy/random/_generator.pyx`: integer count coercion and broadcasting for `hypergeometric`, scalar and array parameters for `zipf`, shape and validation semantics.
- `numpy/random/src/distributions/distributions.c`: Zipf rejection kernel; native `src/ln_random.c` reuses established implementation.
- `numpy/random/src/distributions/distributions.c` and related hypergeometric native sampling: existing `src/ln_hypergeometric.c` remains unchanged.
- Source hashes in `NUMPY_2_5_3_RANDOM87_FILE_HASHES.sha256` are independently verified against the provided NumPy 2.5.3 source tarball.
- NumPy 2.3.5 is the executable reference for frozen fixtures; no runtime Python bridge.

## 0.86 — broadcasted Student-t, von Mises and triangular (NumPy 2.5.3)

- `numpy/random/_generator.pyx`: `Generator.standard_t`, `Generator.vonmises`,
  `Generator.triangular` argument broadcasting and shape behavior.
- `numpy/random/src/distributions/distributions.c`: native rejection / inverse
  sampling kernels already ported to `src/ln_random.c` in earlier LuaRay releases.
- Both source file SHA-256 values are pinned in
  `NUMPY_2_5_3_RANDOM86_FILE_HASHES.sha256` and independently compared to the
  user's original NumPy source archive.
- Frozen executable reference: NumPy 2.3.5. Python is used only to regenerate
  reproducible fixtures, never as a runtime dependency of LuaRay.

## 0.85 — noncentral distribution broadcasting (NumPy 2.5.3)

- `numpy/random/_generator.pyx`: `Generator.noncentral_chisquare`,
  `Generator.noncentral_f` and NumPy's three-parameter `cont` broadcast handling.
- `numpy/random/src/distributions/distributions.c`: native PCG64 rejection
  sampling paths that LuaRay had already ported into `src/ln_random.c`.
- SHA-256 of both upstream sources pinned in
  `NUMPY_2_5_3_RANDOM85_FILE_HASHES.sha256` and independently verified against
  the provided NumPy 2.5.3 archive.
- The executable reference NumPy 2.3.5 is used *only* for frozen oracle fixture
  generation; no Python runtime is used by LuaRay.

## 0.84 — vector binomial and negative_binomial (NumPy 2.5.3)

The binomial-family vectorized entrypoints follow NumPy 2.5.3 `numpy/random/_generator.pyx` argument broadcasting and `numpy/random/src/distributions/distributions.c` native binomial inversion, BTPE, Gamma/Poisson random draw order. The files are pinned by `NUMPY_2_5_3_RANDOM84_FILE_HASHES.sha256`; relevant adapted C distributions retain NumPy's BSD-3-Clause license. Native LuaRay requires no Python at runtime. The differential executable oracle is NumPy 2.3.5. Defensive guardrails for extreme parameters remain; this is not full behavioral parity for every input.

## 0.83 — vector geometric / poisson (NumPy 2.5.3)

- `numpy/random/_generator.pyx`: `Generator.geometric` and `Generator.poisson`
  argument validation, C-order broadcasting and sample shapes.
- `numpy/random/src/distributions/distributions.c`: NumPy geometric and Poisson
  samplers; matching C counterparts were already implemented by LuaRay.
- SHA-256 of original NumPy 2.5.3 sources recorded in
  `NUMPY_2_5_3_RANDOM83_FILE_HASHES.sha256`.
- NumPy 2.3.5 is used to produce frozen differential fixtures only.
  The LuaRay runtime does not invoke Python.

## 0.82 — Wald and logseries NumPy 2.5.3 broadcasting

- `numpy/random/_generator.pyx`: `Generator.wald` and `Generator.logseries` output/size argument behavior and NumPy iterator broadcasting.
- `numpy/random/src/distributions/distributions.c`: `random_wald` / `random_logseries` native samplers, already ported to C in LuaRay.
- NumPy 2.5.3 source hashes: `NUMPY_2_5_3_RANDOM82_FILE_HASHES.sha256`, independently extracted from the user's NumPy archive.
- Executable differential oracle: NumPy 2.3.5, embedded as static Lua data; Python not needed in LuaRay runtime.

## 0.81 — Generator.standard_gamma nonfinite parameters and `out` (NumPy 2.5.3)

- `numpy/random/_generator.pyx`: `Generator.standard_gamma` uses `cont` / `cont_f` with output-buffer dtype/shape checks; NumPy's C rejection sampler accepts NaN and positive infinity.
- `numpy/random/src/distributions/distributions.c`: `random_standard_gamma` / `_f`; preserved rejection branches and PCG64 draw semantics.
- Source SHA-256 in `NUMPY_2_5_3_RANDOM81_FILE_HASHES.sha256`, verified from the provided NumPy 2.5.3 archive.
- Installed NumPy 2.3.5 provided independent executable fixtures; LuaRay runtime needs no Python.

## 0.80 — Generator.standard_gamma broadcasting (NumPy 2.5.3)

- `numpy/random/_generator.pyx`: `Generator.standard_gamma`'s dtype dispatch to `cont` / `cont_f`, size handling and parameter broadcasting.
- `numpy/random/src/distributions/distributions.c`: `random_standard_gamma`, `random_standard_gamma_f` (already natively ported in `src/ln_random.c`).
- Source hashes: `NUMPY_2_5_3_RANDOM80_FILE_HASHES.sha256` extracted and verified from the user's NumPy 2.5.3 tarball.
- Executable test oracle is locally installed NumPy 2.3.5; Python is not a runtime dependency.

## 0.77 — Generator parameter broadcasting (NumPy 2.5.3)

- `numpy/random/_generator.pyx`: `Generator.normal`, `Generator.uniform` and
  `Generator.exponential` call NumPy's `cont` helper for native random loops
  and broadcasted parameter iteration. `uniform` subtracts arrays before
  entering `cont`, and rejects invalid range values.
- `numpy/random/src/distributions/distributions.c`: native float64 sampling
  kernels already ported to `src/ln_random.c`; release 0.77 adds only their
  Lua ndarray/table broadcast adapter.
- Upstream SHA-256 in `NUMPY_2_5_3_RANDOM77_FILE_HASHES.sha256` verified from
  the user's `numpy-2.5.3.tar.gz`. NumPy BSD-3-Clause license applies.
- Frozen differential values were generated with installed NumPy 2.3.5,
  used exclusively as an offline executable reference.

## 0.74 — Generator.choice (NumPy 2.5.3)

- `numpy/random/_generator.pyx`, `Generator.choice`: 4 weighted/unweighted and replacement/no-replacement branches; shape and axis mapping; `shuffle` tuning threshold and tail-shuffle optimization for large populations.
- `numpy/random/_generator.pyx`, `_shuffle_int`: bounded integer Fisher–Yates for Floyd final shuffle and partial tail shuffle. Unlike `shuffle`/`permuted`, NumPy choice uses Lemire bounded64 draws rather than `random_interval`.
- Exact upstream source hash is in `NUMPY_2_5_3_CHOICE74_FILE_HASHES.sha256`. NumPy BSD-3-Clause license applies (see `THIRD_PARTY_NUMPY_LICENSE.txt`).
- Runtime tests compare against independently installed NumPy 2.3.5; these tests are bundled as static Lua fixtures, so LuaRay requires no Python runtime.

## 0.73 — Generator.permuted (NumPy 2.5.3)

- `numpy/random/_generator.pyx`: `Generator.permuted`,
  `PyArray_IterAllButAxis`, `_shuffle_raw_wrap` and `_shuffle_raw` for
  per-fiber Fisher–Yates with PCG64 mask rejection. `out` implements
  matching safe assignment and guards input/output aliasing.
- Source verification: `NUMPY_2_5_3_PERMUTED73_FILE_HASHES.sha256`.
- Public API uses Lua 1-based axes and positional arguments for optional
  axis/out. NumPy 2.3.5 was the executable oracle; 2.5.3 the pinned source.

## 0.72 — shuffle/permutation (NumPy 2.5.3)

- `numpy/random/_generator.pyx`: `_shuffle_raw`, `Generator.shuffle`,
  `Generator.permutation`, including `permutation` indexing semantics for
  dimension >1 and zero-sized arrays.
- `numpy/random/src/distributions/distributions.c`: `random_interval` masked
  rejection, consuming `next_uint32` or `next_uint64` according to range.
- SHA-256 reference: `NUMPY_2_5_3_SHUFFLE72_FILE_HASHES.sha256`.
- Algorithms adapted under NumPy BSD-3-Clause license (see
  `THIRD_PARTY_NUMPY_LICENSE.txt`). Source is NumPy 2.5.3; executable oracle
  obtained from local NumPy 2.3.5.

## 0.70 — Wald and logarithmic-series (NumPy 2.5.3)

- `numpy/random/src/distributions/distributions.c`: original
  `random_wald` and `random_logseries`, adapted to `ln_pcg64_*` primitives
  without altering branch order, floating-point operation sequence or
  PCG64 consumption.
- `numpy/random/_generator.pyx`: public `Generator.wald` and
  `Generator.logseries` method signatures, parameter domains and output dtype.
- Exact source SHA-256 values:
  `NUMPY_2_5_3_WALD_LOGSERIES_FILE_HASHES.sha256`.
- License: NumPy BSD-3-Clause (`THIRD_PARTY_NUMPY_LICENSE.txt`).
- NumPy 2.3.5 is an independent executable fixture oracle, not a runtime
  dependency. Scalar parameters only; vectorized broadcasting not claimed.

## 0.69 — Dirichlet (NumPy 2.5.3)

- `numpy/random/_generator.pyx`, `Generator.dirichlet`: exact
  small-alpha (`alpha.max() < 0.1`) conditional and two sampling loops.
- Small alpha: right-to-left cumulative concentrations, then
  `random_beta` stick-breaking (including zero-sum and zero-tail exits).
- Otherwise: sequential `random_standard_gamma` and normalization.
- `numpy/random/src/distributions/distributions.c`: Beta and Gamma
  native implementations already ported earlier; `ln_dirichlet.c` reuses
  their NumPy-compatible LuaRay native equivalents.
- Exact source hashes: `NUMPY_2_5_3_DIRICHLET_FILE_HASHES.sha256`.
- Source/license: NumPy BSD-3-Clause (`THIRD_PARTY_NUMPY_LICENSE.txt`).
- NumPy 2.3.5 is an independent *executable test oracle*, not the
  implementation source or an execution dependency.
- Verified scalar concentration vectors and sample shapes; no claims
  of complete NumPy random-module parity or ABI compatibility.

## 0.68 — Multinomial (NumPy 2.5.3)

- `numpy/random/src/distributions/distributions.c`, function
  `random_multinomial`: sequential binomial draws; leftover mass assigned
  to the final category, preserving exact PCG64 consumption.
- `numpy/random/_generator.pyx`, method `Generator.multinomial`:
  validation of probabilities, shape and sample count.
- SHA-256 values: `NUMPY_2_5_3_MULTINOMIAL_FILE_HASHES.sha256`.
- NumPy BSD-3-Clause attribution: `THIRD_PARTY_NUMPY_LICENSE.txt`.
- NumPy 2.3.5 used as *executable oracle*, 2.5.3 as *source reference*.

## 0.67 — Multivariate hypergeometric (NumPy 2.5.3)

NumPy 2.5.3 is the source of the two algorithms:

- `numpy/random/src/distributions/random_mvhg_marginals.c`: sequential
  univariate hypergeometric draws and complement optimization.
- `numpy/random/src/distributions/random_mvhg_count.c`: shuffle/count method;
  its choices buffer persists across successive variates.
- `numpy/random/src/distributions/random_hypergeometric.c`: underlying
  1-D sampler shared with LuaRay 0.66.
- `numpy/random/_generator.pyx`: argument validation and output shape.

Pinned upstream SHA-256 values are listed in
`NUMPY_2_5_3_MVHG_FILE_HASHES.sha256`. The NumPy BSD-3-Clause license is
preserved in `THIRD_PARTY_NUMPY_LICENSE.txt`. NumPy 2.3.5 was the executable
oracle for verification; the LuaRay runtime needs neither Python nor NumPy.

## 0.66 — Hypergeometric (NumPy 2.5.3)

The code was adapted from these NumPy 2.5.3 source files:

- `numpy/random/src/distributions/random_hypergeometric.c` — small-sample and
  HRUA samplers, drawing order and decision boundary.
- `numpy/random/src/distributions/logfactorial.c` — lookup table and Stirling
  approximation used by HRUA.
- `numpy/random/src/distributions/distributions.c` — masked `random_interval`.
- `numpy/random/_generator.pyx` — argument validation and public signature.

Pinned hashes: `NUMPY_2_5_3_HYPERGEOMETRIC_FILE_HASHES.sha256`.
NumPy 2.3.5 served as the executable oracle, not the source of the port.
The adapted code retains NumPy BSD-3-Clause licensing and requires no Python
runtime.

## 0.64 — geometric sampling (NumPy 2.5.3)

The geometric sampler follows `random_geometric_search`,
`random_geometric_inversion`, and `random_geometric` from
`numpy/random/src/distributions/distributions.c`, with the public
`Generator.geometric` signature documented in `numpy/random/_generator.pyx`.
Source hashes are in `NUMPY_2_5_3_GEOMETRIC_FILE_HASHES.sha256`.
The independently executed oracle was NumPy 2.3.5.

## 0.59 — chi-square / Fisher F (NumPy 2.5.3)

The scalar algorithms `random_chisquare` and `random_f` in
`numpy/random/src/distributions/distributions.c` are ported to native C;
`numpy/random/_generator.pyx` documents the parameter/shape signatures.
`NUMPY_2_5_3_DISTRIBUTIONS59_FILE_HASHES.sha256` records exact SHA-256 values
from the supplied NumPy 2.5.3 archive. All differential fixture expectations
were generated using executable NumPy 2.3.5, not from the LuaRay implementation.
The runtime does not use Python or NumPy.

## 0.57 — Pareto II, power and triangular (NumPy 2.5.3)

Native formulas from `numpy/random/src/distributions/distributions.c`, and
public parameter validation/behavior from `numpy/random/_generator.pyx`.
Exact SHA-256 fingerprints appear in
`NUMPY_2_5_3_DISTRIBUTIONS57_FILE_HASHES.sha256` and refer to the **source**
archive supplied by the user. NumPy 2.3.5 provided the executed differential
results, including exact output and PCG64 state checks. No Python is required
for LuaRay's runtime.

## 0.56 — Gumbel, logistic, Rayleigh and Weibull (NumPy 2.5.3)

Referenced `numpy/random/src/distributions/distributions.c` and
`numpy/random/_generator.pyx` from the supplied NumPy 2.5.3 tarball.
NumPy's Gumbel and logistic formulas reject endpoint draws; Rayleigh
uses standard exponential sampling; Weibull shape zero consumes no bits.
`NUMPY_2_5_3_DISTRIBUTIONS56_FILE_HASHES.sha256` records the source
hashes. The executable expected-output oracle was NumPy 2.3.5.

## 0.53 native Ziggurat normal sampling — NumPy 2.5.3

Inspected `numpy/random/src/distributions/distributions.c` and
`numpy/random/src/distributions/ziggurat_constants.h`, including the distinct
float32/float64 `random_standard_normal` algorithms. The Ziggurat lookup
tables are redistributed under NumPy's existing BSD-3-Clause license.
`NUMPY_2_5_3_NORMAL_FILE_HASHES.sha256` pins the upstream files exactly.
The executable comparator is NumPy 2.3.5, not NumPy 2.5.3.

## 0.51 random PCG64 — NumPy 2.5.3 release source

Inspected `numpy/random/bit_generator.pyx` for SeedSequence entropy mixing
and generate_state byte ordering, `_pcg64.pyx` for PCG64 seed-state word order,
`numpy/random/src/pcg64/pcg64.h` for the 128-bit PCG transition and XSL-RR
output permutation, and the NumPy random distribution implementation for
53-bit float64 conversion. Exact release-source SHA-256 checksums are in
`NUMPY_2_5_3_RANDOM_FILE_HASHES.sha256`. Differential execution was against
installed NumPy 2.3.5, not compiled NumPy 2.5.3. The LuaRay implementation
is standalone native C and does not require the NumPy C code at runtime.

## 0.50 average — NumPy 2.5.3 source

Examined `numpy/lib/_function_base_impl.py` for weighted `average`,
weight dimensionality, return dtype promotion, zero weight sums, and
`returned` behavior, and `numpy/_core/_methods.py` for unweighted mean
behavior. Specific file hashes are pinned in
`NUMPY_2_5_3_AVERAGE_FILE_HASHES.sha256`. The executable oracle is the
available NumPy 2.3.5, **not** NumPy 2.5.3.

## 0.49 logical reductions — NumPy 2.5.3 release

Inspected the public signatures and axis/keepdims rules for `any`, `all`,
`count_nonzero` in `numpy/_core/fromnumeric.py`, NumPy internal boolean
reduction implementations in `numpy/_core/_methods.py`, and the native
`count_nonzero` entrypoints in the NumPy multiarray sources. Exact source
hashes of files present in the supplied release archive are pinned by
`NUMPY_2_5_3_TRUTH_FILE_HASHES.sha256`. NumPy 2.3.5 was used for differential
execution because 2.5.3 was provided as source, not a built oracle.

## 0.48 cumulative accumulations — NumPy 2.5.3 sources

Compared cumsum/cumprod's `axis=None`, result dtype, and `out` behavior in
`numpy/_core/fromnumeric.py` against NumPy's nan-aware implementations in
`numpy/lib/_nanfunctions_impl.py`, plus reduction implementation machinery
in `numpy/_core/_methods.py`. File content is pinned in
`NUMPY_2_5_3_CUMULATIVE_FILE_HASHES.sha256`; the executable fixture oracle
is NumPy 2.3.5, not a claimed execution of 2.5.3.

# Upstream source of truth

Primary source: official `numpy/numpy` **GitHub Download ZIP** for `main`.

Pinned upstream commit:

`286e698f1dcf601648b165f48485ceaeec9c6231` (2026-10-06)

The extracted `pyproject.toml` reports `version = "2.6.0.dev0"`.

The local development environment also contains the NumPy 2.5.3 release tarball for release-vs-main comparisons, but it is not the primary implementation source.

GitHub ZIP archives omit Git submodule payloads. Top-level NumPy sources are present; submodules such as `numpy/_core/src/highway` must be materialized separately when those components are ported.

## Source files directly inspected/ported

### ndarray layout, shape, strides and broadcasting

- `numpy/_core/include/numpy/ndarraytypes.h`
  - numerical/layout portion of `PyArrayObject_fields`;
  - `NPY_TYPES`, scalar-kind and array-flag values;
  - `NPY_BUFSIZE = 8192`.
- `numpy/_core/include/numpy/dtype_api.h`
  - `PyArray_DTypeMeta` versus `PyArray_Descr` responsibility split;
  - DType flags and class slots (`default_descr`, `common_dtype`, `common_instance`);
  - ArrayMethod separation between class signatures and resolved descriptors.
- `numpy/_core/src/common/templ_common.h.src`
  - `npy_mul_sizes_with_overflow`.
- `numpy/_core/src/common/array_assign.c`
  - `broadcast_strides`.
- `numpy/_core/src/multiarray/ctors.c`
  - dimension validation, zero-size allocation/stride behavior, `_array_fill_strides`.
- `numpy/_core/src/multiarray/flagsobject.c`
  - `_UpdateContiguousFlags`.
- `numpy/_core/src/multiarray/iterators.c`
  - `PyArray_Broadcast` shape discovery and mismatch semantics.
- `numpy/_core/src/multiarray/shape.c`
  - `_reshape_with_copy_arg`, `_attempt_nocopy_reshape`, unknown-dimension handling and copy-if-needed reshape flow.

### DType promotion, packing and assignment

- `numpy/_core/src/multiarray/can_cast_table.h`
  - builtin safe-cast rules (`FITS`, `UFITS`, `IFITS`).
- `numpy/_core/src/multiarray/scalartypes.c.src`
  - `_npy_type_promotion_table`, scalar kinds and next-larger-type chains.
- `numpy/_core/src/multiarray/dtypemeta.c`
  - builtin common-DType behavior and weak Python scalar rules, adapted to Lua integer/number host scalars.
- `numpy/_core/src/multiarray/convert_datatype.c`
- `numpy/_core/src/multiarray/common_dtype.c`
  - traced `PyArray_PromoteTypes`, `PyArray_ResultType` and `PyArray_CommonDType`.
- `numpy/_core/src/multiarray/array_coercion.c`
  - `PyArray_Pack` scalar storage path.
- `numpy/_core/src/multiarray/arraytypes.c.src`
  - strict `*_safe_pyint_setitem` integer overflow checks.
- `numpy/_core/src/multiarray/abstractdtypes.c`
  - Python scalar descriptor discovery, used to identify the host-runtime replacement boundary.
- `numpy/_core/src/multiarray/array_assign_scalar.c`
  - `PyArray_AssignRawScalar` / `raw_array_assign_scalar`: pack once, then raw strided assignment.

### Basic and advanced indexing / assignment

- `numpy/_core/src/multiarray/mapping.c`
  - `prepare_index_noarray` / `prepare_index`;
  - `get_item_pointer` and `get_view_from_index`;
  - scalar-vs-0D behavior from `array_subscript`;
  - `array_boolean_subscript` and `array_assign_boolean_subscript`;
  - `mapiter_fill_info`, `PyArray_MapIterCheckIndices`, `PyArray_MapIterNew`, `_get_transpose` / `PyArray_MapIterSwapAxes`;
  - advanced get/set iteration ordering and repeated-index behavior.
- `numpy/_core/src/multiarray/mapping.h`
  - `PyArrayMapIterObject` fields and index flag layout used to define the host-neutral mapping plan.
- `numpy/_core/src/multiarray/array_assign_array.c`
  - ndarray RHS assignment broadcasting, leading-unit-dimension stripping, and overlap-safe assignment flow.
- `numpy/_core/src/multiarray/lowlevel_strided_loops.c.src`
  - `mapiter_trivial_get/set` and `mapiter_get/set` traversal structure in addition to numeric cast loops.
- `numpy/_core/src/multiarray/shape.c`
  - `PyArray_CreateSortedStridePerm`, used by MapIter output stride construction.

### DType transfer and buffered ufunc iteration

- `numpy/_core/src/multiarray/lowlevel_strided_loops.c.src`
  - generated builtin numeric source→destination strided cast loop structure.
- `numpy/_core/src/multiarray/dtype_transfer.c`
  - `PyArray_GetDTypeTransferFunction`, `define_cast_for_descrs`, aligned/strided transfer organization.
- `numpy/_core/src/multiarray/nditer_constr.c`
  - `NPY_OP_ITFLAG_CAST` setup and `npyiter_find_buffering_setup`;
  - `npyiter_find_best_axis_ordering`;
  - `npyiter_flip_negative_strides`;
  - `COPY_IF_OVERLAP` temporary-output allocation/writeback setup.
- `numpy/_core/src/multiarray/nditer_api.c`
  - `npyiter_coalesce_axes`;
  - `npyiter_copy_to_buffers` / `npyiter_copy_from_buffers`;
  - reusable transfer-buffer behavior.
- `numpy/_core/src/multiarray/nditer_impl.h`
  - iterator/buffer data layout and cast/buffer flags used to trace the execution path.
- `numpy/_core/src/multiarray/legacy_dtype_implementation.c`
  - default `NPY_SAME_KIND_CASTING` decision path for builtin DTypes.
- `numpy/_core/src/multiarray/convert_datatype.c`
  - builtin `dtype_kind_to_ordering` used by same-kind casting.
- `numpy/_core/src/common/mem_overlap.c` / `mem_overlap.h`
  - stride-derived byte-bound overlap precheck from `solve_may_share_memory`;
  - internal-overlap logic traced for COPY_IF_OVERLAP semantics.

The current native implementation ports a real-numeric binary-ufunc NpyIter subset: two read operands, one writable output, and optional boolean ARRAYMASK. It performs source-derived axis ordering, all-negative-stride flipping, axis coalescing, keep-order output stride construction, buffered input casts, masked buffered output casts, and COPY_IF_OVERLAP-style temporary/writeback handling. Input transfer buffers are reused when the same source chunk recurs. The buffer cap remains NumPy's `NPY_BUFSIZE` (8192 elements).

Overlap detection is intentionally conservative at this stage: the port uses the stride-derived byte-bound stage of NumPy's overlap solver. NumPy's bounded Diophantine `solve_may_share_memory` / full internal-overlap solver is not yet ported, so the native path may allocate a temporary in cases NumPy can prove non-overlapping. This changes performance, not the intended result semantics. Full/general NpyIter state/flag coverage is not claimed yet.

### Ufunc inner loops and reductions

- `numpy/_core/src/umath/fast_loop_macros.h`
  - legacy strided-loop ABI and contiguous/scalar fast-path organization.
- `numpy/_core/src/umath/loops.h.src`
  - bool `add -> logical_or`, `multiply -> logical_and` aliases.
- `numpy/_core/src/umath/loops.c.src`
- `numpy/_core/src/umath/loops_arithm_fp.dispatch.c.src`
- `numpy/_core/src/umath/loops_autovec.dispatch.c.src`
  - add/subtract/multiply elementwise loops and floating divide loop structure, plus add/multiply reduction structure.
- `numpy/_core/src/umath/loops_utils.h.src`
  - `PW_BLOCKSIZE = 128` and `*_pairwise_sum` implementation, ported for float32/float64/longdouble add reductions.
- `numpy/_core/src/umath/ufunc_type_resolution.c`
  - `PyUFunc_SubtractionTypeResolver` including the bool-subtract rejection;
  - `PyUFunc_TrueDivisionTypeResolver` / `PyUFunc_DivisionTypeResolver`, including integer/bool true-divide resolution.
- `numpy/_core/src/multiarray/npy_static_data.c`
  - `default_truediv_type_tup = (double, double, double)` used by integer/bool true division.
- `numpy/_core/code_generators/generate_umath.py`
  - generated signature/dispatch definitions for add, subtract, multiply and divide.
- `numpy/_core/src/umath/ufunc_object.c`
  - external-loop ufunc execution (`execute_ufunc_loop`) and its iterator/output-overlap setup;
  - `reducelike_promote_and_resolve` default bool/integer widening for add/multiply reductions;
  - reduction loop argument expansion.
- `numpy/_core/src/umath/reduction.c`
- `numpy/_core/src/umath/reduction.h`
  - `PyUFunc_ReduceWrapper`, identity/buffer/reduction iterator flow.
- `numpy/_core/src/multiarray/number.c`
- `numpy/_core/src/multiarray/calculation.c`
  - `PyArray_GenericReduceFunction`, `PyArray_Sum`, `PyArray_Prod`, `PyArray_Mean` call paths.
- `numpy/_core/_methods.py`
  - current public `_mean` default dtype rules: bool/integer→float64, inexact types retain dtype (float16 special-case now follows the native half DType path).

## Upstream tests translated/adapted or used as invariants

- `numpy/_core/tests/test_numeric.py::TestBroadcast::test_broadcast_in_args`
- `numpy/_core/tests/test_numeric.py::TestBroadcast::test_shape_mismatch_error_message`
- `numpy/_core/tests/test_api.py::test_contiguous_flags`
- broadcasting, ufunc `out`/`where`, output casting/order, and overlap cases from `numpy/_core/tests/test_ufunc.py`
- basic integer/slice/ellipsis/newaxis, fancy/boolean MapIter, repeated-index assignment and ndarray-RHS semantics from `numpy/_core/tests/test_indexing.py`
- reduction dtype/empty/axis behavior traced against the upstream ufunc/reduction tests and development oracle.

Additional differential suites are generated against Python NumPy only as a development oracle. Upstream source and upstream tests remain the implementation specification.

NumPy's BSD license is copied verbatim into `THIRD_PARTY_NUMPY_LICENSE.txt`.

## Extended reductions, accumulate and reduceat

The current `sum`/`prod`/`mean` extensions and add/multiply accumulate/reduceat paths were traced through:

- `numpy/_core/src/umath/ufunc_object.c`
  - `reducelike_promote_and_resolve`;
  - `PyUFunc_Accumulate`;
  - `PyUFunc_Reduceat`;
  - accumulator/output DType resolution and prefix/segment loop setup.
- `numpy/_core/src/umath/reduction.c` / `reduction.h`
  - multi-axis reduction wrapper, identities, initial values, `where`, output preparation and iterator setup.
- `numpy/_core/_methods.py`
  - current `mean` accumulation/count/division behavior, including the ordering of output casting relative to final division.
- `numpy/_core/tests/test_ufunc.py`
  - reduce/accumulate/reduceat axis, dtype, out, repeated-index and error invariants.
- `numpy/_core/tests/test_multiarray.py`
  - public reduction/product behavior used as cross-checks.

The Lua API changes only the public coordinate convention: axes and positive `reduceat` starts are 1-based. Negative axes count from the end. Negative `reduceat` entries are also accepted as a deliberate Lua-surface adaptation and normalized before entering the native reduceat core; Python NumPy itself rejects negative reduceat indices.

## Matmul / initial BLAS path

The native matmul implementation is derived from:

- `numpy/_core/src/umath/matmul.c.src`
  - generalized-ufunc core signature `(m?,n),(n,p?)->(m?,p?)`;
  - `*_matmul_inner_noblas` traversal;
  - boolean OR-of-AND behavior;
  - `is_blasable2d`;
  - matrix/matrix BLAS selection and transpose/leading-dimension rules.
- `numpy/_core/src/umath/matmul.h.src`
  - generated matmul helper declarations/template structure.
- `numpy/_core/src/common/cblasfuncs.c` / `cblasfuncs.h`
  - NumPy's CBLAS integration patterns and matrix-product dispatch context.
- `numpy/_core/src/common/npy_cblas.h`
  - CBLAS abstraction/bounds context used by the upstream core.
- `numpy/_core/src/multiarray/multiarraymodule.c`
  - `PyArray_MatrixProduct2`, inspected specifically to keep `dot`/matrix-product semantics separate from the matmul gufunc.
- `numpy/_core/tests/test_multiarray.py`
  - `MatmulCommon` / `TestMatmul` shape, dtype, boolean, `out`, non-contiguous output and overlap invariants.
- `numpy/_core/tests/test_ufunc.py`
  - gufunc/output/iterator semantics relevant to matmul execution.

Current BLAS coverage now includes NumPy-derived level-1 vector dot, level-2 GEMV and level-3 GEMM selection for homogeneous BLASable float32/float64 matmul cores. Mixed-DType operands, negative/non-BLASable layouts, zero-core cases, and unsupported special shapes use the source-derived native strided kernel. NumPy's temporary packing for non-BLASable float matrices, SYRK recognition, and scalar/AXPY micro-specializations remain future work.
## Dot / inner / outer

The distinct product APIs added in 0.9.0-dev were traced through:

- `numpy/_core/src/multiarray/multiarraymodule.c`
  - `PyArray_MatrixProduct2`: last axis of `a` contracts with the second-to-last axis of `b` for `b.ndim > 1`, with result dimensions `a[:-1] + b[:-2] + b[-1:]`;
  - scalar operands fall through to multiply except when the float/double CBLAS matrix-product selector intercepts them;
  - `PyArray_InnerProduct`: swaps the final two axes of the second operand before delegating to matrix product.
- `numpy/_core/src/multiarray/common.c`
  - `new_array_for_sum`: non-scalar `dot(out=)` requires exact dtype/dimensionality/shape and a writable aligned C-contiguous output, with overlap-safe temporary/writeback.
- `numpy/_core/src/multiarray/arraytypes.c.src`
  - builtin `*_dot` loops, including float/double CBLAS dot chunking and boolean OR-of-AND.
- `numpy/_core/src/common/cblasfuncs.c` / `npy_cblas.h`
  - float/double scalar/vector/matrix CBLAS dispatch, stride eligibility, DOT/GEMV/GEMM selection and C-order result behavior.
- `numpy/_core/numeric.py`
  - `outer`: `multiply(a.ravel()[:, newaxis], b.ravel()[newaxis, :], out)`, so flattening is logical C order and output casting follows ufunc rules rather than dot's strict output contract.
- `numpy/_core/tests/test_multiarray.py` and `numpy/_core/tests/test_numeric.py`
  - dot/matrix-product shapes, output constraints, inner/outer invariants and numerical behavior used as source tests alongside the differential oracle.

Lua changes only host-language surface conventions; the contraction rules are not reinterpreted. `dot` is deliberately not implemented as an alias of `matmul`.


## Sorting, partitioning and searchsorted (0.10.0-dev)

The native numeric sorting/searching tranche was traced directly through:

- `numpy/_core/src/multiarray/item_selection.c`
  - `_new_sortlike`, `_new_argsortlike`, `PyArray_Sort`, `PyArray_ArgSort`;
  - `PyArray_Partition`, `PyArray_ArgPartition`, kth preparation;
  - `PyArray_SearchSorted`, including common-DType conversion, contiguous needles, optional sorter validation and cache-oriented haystack copying.
- `numpy/_core/src/npysort/quicksort_generic.cpp` / `quicksort.hpp`
  - generic introsort structure, small-sort threshold and heap fallback.
- `numpy/_core/src/npysort/heapsort.cpp`
  - heap fallback used by introsort.
- `numpy/_core/src/npysort/selection.hpp` / `selection_methods.cpp`
  - introselect, pivot-stack reuse, median-of-medians fallback and multiple-kth behavior.
- `numpy/_core/src/npysort/binsearch.cpp`
  - batched numeric left/right binary search and optional sorter-index path.
- `numpy/_core/src/common/numpy_tag.hpp`
  - numeric total ordering used by sorting/searching, including NaN-at-end behavior and `less_equal = !less(reverse)`.
- `numpy/_core/src/multiarray/ctors.c` and `shape.c`
  - KEEPORDER output allocation / sorted-stride permutation used by `np.sort`/`np.partition` copies.
- `numpy/_core/fromnumeric.py`
  - public `sort`, `argsort`, `partition`, `argpartition`, and `searchsorted` wrappers/semantics.
- `numpy/_core/tests/test_multiarray.py`
  - searchsorted NaN, side, sorter, shape/dtype and error invariants; sorting/selection public behavior.

Lua adaptation: positive axes/kth values and index-array results are 1-based. `searchsorted` returns insertion positions in `[1, N+1]`; optional sorter entries are also 1-based at the Lua surface. The internal port remains zero-based. Partition output order beyond the requested kth guarantees is intentionally treated as unspecified, matching NumPy. Stable sorting remains unported and is rejected explicitly.


## Comparison, logical, min/max and unary ufunc catalogue (0.11.0-dev)

This tranche was traced through the generated builtin ufunc definitions and their concrete native loops:

- `numpy/_core/code_generators/generate_umath.py`
  - signatures and resolver families for comparisons, logical ufuncs, min/max and unary predicates/sign operations.
- `numpy/_core/src/umath/loops.c.src`
  - exact `LONGLONG_Qq_bool_*` / `LONGLONG_qQ_bool_*` mixed signed/unsigned 64-bit comparison loops; these are ported directly so values above 2**53 are never routed through float64.
- `numpy/_core/src/umath/loops_comparison.dispatch.c.src`
  - builtin comparison loop shape and boolean outputs.
- `numpy/_core/src/umath/loops_logical.dispatch.cpp` and `loops_autovec.dispatch.c.src`
  - logical truth-value loops for bool/real numeric types.
- `numpy/_core/src/umath/loops_minmax.dispatch.c.src`
  - `maximum`/`minimum`, including NaN-propagating floating behavior and bool aliases.
- `numpy/_core/src/umath/loops_unary.dispatch.c.src` and `loops_autovec.dispatch.c.src`
  - negative/absolute/positive/sign and isnan/isinf/isfinite/signbit/logical-not behavior for the exposed builtin types.
- `numpy/_core/src/umath/ufunc_type_resolution.c`
  - comparison and uniform-operation resolver behavior, including bool restrictions.
- `numpy/_core/src/multiarray/array_coercion.c` / `arraytypes.c.src`
  - integer scalar packing invariants used to fix exact Lua integer storage above 2**53.
- `numpy/_core/tests/test_ufunc.py`
  - comparison, logical, min/max, unary, `out`/`where`, dtype and edge-case invariants used alongside differential testing.

LuaRay's NpyIter numeric executor now accepts distinct resolved input DTypes for the two operands. This is required by the upstream qQ/Qq comparison signatures and is a closer match to NumPy's per-operand ufunc loop descriptors than the earlier single-common-input-DType executor.


## Arithmetic, bitwise and mathematical ufuncs + native float16 (0.12.0-dev)

The 0.12 tranche extends the source-derived ufunc catalogue and introduces native half-precision storage. The implementation was traced through:

- `numpy/_core/src/common/half_private.hpp`
  - float/double↔half bit conversion, ties-to-even rounding, signed zero, subnormal, Inf/NaN and comparison behavior.
- `numpy/_core/src/npymath/halffloat.cpp`
  - public half conversion/comparison helpers and half divmod behavior used by generated numeric loops.
- `numpy/_core/src/umath/loops_arithmetic.dispatch.c.src`
  - integer floor-divide and arithmetic edge-case structure.
- `numpy/_core/src/umath/loops_modulo.dispatch.c.src`
  - modulo/remainder loop behavior and signed floor-mod rules.
- `numpy/_core/src/umath/loops_umath_fp.dispatch.c.src`
  - floating mathematical loop families used for `sqrt`, `exp`, `log`, `sin`, `cos`, and `tan`.
- `numpy/_core/src/umath/loops.c.src`, `loops_autovec.dispatch.c.src`, and `generate_umath.py`
  - power, copysign, bitwise, half wrappers, loop signatures and resolver registrations.
- `numpy/_core/tests/test_half.py`
  - half conversion/rounding/comparison and edge-case invariants.
- `numpy/_core/tests/test_umath.py` and `test_umath_accuracy.py`
  - arithmetic/modulo/power and mathematical ufunc dtype/value invariants.

LuaRay stores float16 values as native 16-bit payloads. The conversion routines are direct C translations of NumPy's bit-level algorithms; floating-status flag plumbing (`FloatStatus::RaiseOverflow/Underflow` / NumPy fp-status APIs) is intentionally not claimed yet because LuaRay does not expose that state machine. Mathematical float16 loops currently perform the same half→float computation→half storage shape used by NumPy's generated half wrappers for the supported operations.


## Native complex DTypes and complex elementary math (0.13.0-dev)

The complex tranche was traced directly through:

- `numpy/_core/src/umath/loops.c.src`
  - complex add/subtract/multiply/divide, comparison/logical loops, sign/predicates, min/max/fmin/fmax and pairwise summation;
- `numpy/_core/src/common/numpy_tag.hpp`
  - complex total-order less/greater rules used by sort/searchsorted;
- `numpy/_core/src/npymath/npy_math_complex.c.src`
  - `npy_cexp*`, `npy_clog*`, `npy_csqrt*`, `npy_cpow*`, scaled-exp helpers and the msun-derived `ccosh/csinh/ctanh` paths used by complex cos/sin/tan;
- `numpy/_core/src/umath/funcs.inc.src`
  - complex elementary ufunc wrappers and their mapping to NumPy's npymath functions;
- `numpy/_core/src/multiarray/dtype_transfer.c`, `scalartypes.c.src`, `dtypemeta.c`, and `can_cast_table.h`
  - real/complex transfer and promotion behavior;
- `numpy/_core/tests/test_umath.py` / `test_umath_accuracy.py`
  - complex ufunc edge/value invariants used alongside the generated differential oracle.

Lua adaptation: complex values are stored in native `ln_cfloat`, `ln_cdouble`, and `ln_clongdouble` real/imag structs and surfaced to Lua as `luaray.complex` userdata. Python object/scalar plumbing is not retained. Positive indexing remains 1-based at the Lua API; numerical algorithms and dtype resolution remain source-derived.


## Extended elementary math and complex CBLAS (0.14.0-dev)

This tranche was traced through:

- `numpy/_core/src/umath/loops_umath_fp.dispatch.c.src`
  - real scalar/SIMD loop families and scalar fallbacks for `sinh`, `cosh`, `tanh`, `exp2`, `log2`, `log10`, `expm1`, `log1p`, and `cbrt`;
- `numpy/_core/src/umath/funcs.inc.src`
  - complex wrappers/formulas for exp2/log2/log10/expm1/log1p and hyperbolic ufunc wiring;
- `numpy/_core/src/npymath/npy_math_complex.c.src`
  - configured/portable complex hyperbolic behavior, including Inf/NaN/signed-zero branches;
- `numpy/_core/src/common/npy_cblas_base.h` and `numpy/_core/src/common/cblasfuncs.c`
  - NumPy CBLAS dtype/stride dispatch patterns and complex BLAS integration;
- `numpy/_core/src/multiarray/vdot.c`
  - explicit distinction between unconjugated dot products and conjugating `vdot`; LuaRay uses DOTU for `dot`/`matmul`;
- `numpy/_core/src/umath/matmul.c.src` and `numpy/_core/src/multiarray/multiarraymodule.c`
  - matrix-product core semantics and fallback context.

Lua adaptation changes only the host/runtime surface. Complex64/complex128 compatible cores call CBLAS DOTU/GEMV/GEMM; complex256, mixed DTypes and layouts rejected by the selector retain the source-derived native strided implementation. `cbrt` remains real-only because the upstream ufunc has no complex loop.


## Inverse math and native PocketFFT (0.15.0-dev)

Inverse trigonometric/hyperbolic work was traced through:

- `numpy/_core/src/umath/loops_umath_fp.dispatch.c.src` and `generate_umath.py`
  - real/half resolver and loop families for `arcsin`, `arccos`, `arctan`, `arcsinh`, `arccosh`, `arctanh`, `arctan2`, and `hypot`;
- `numpy/_core/src/umath/funcs.inc.src` and `numpy/_core/src/npymath/npy_math_complex.c.src`
  - complex inverse-function wiring and NumPy's configured C99-vs-portable implementation boundary;
- `numpy/_core/tests/test_umath.py` and `test_umath_accuracy.py`
  - branch-cut, signed-zero, dtype and numerical invariants used with the generated differential oracle.

FFT work was traced through:

- `numpy/fft/_pocketfft.py`
  - `_raw_fft`, `_cook_nd_args`, `_raw_fftnd`, dtype/norm resolution, crop/pad rules, real-transform ordering and `out=` surface behavior;
- `numpy/fft/_pocketfft_umath.cpp`
  - gufunc iteration, contiguous-buffer transfer and PocketFFT plan execution for complex-to-complex, real-to-complex and complex-to-real transforms;
- `numpy/fft/tests/test_pocketfft.py`
  - transform direction, normalization, dtype, real-transform and edge-case invariants.

The numerical FFT engine is PocketFFT, the same submodule family consumed by NumPy. GitHub's Download ZIP does not carry submodule contents, so `src/third_party/pocketfft/` is pinned separately to PocketFFT commit `33ae5dc94c9cdc7f1c78346504a85de87cadaa12`, the exact commit referenced by the pinned NumPy main tree. The files were recovered from the uploaded official NumPy source distribution only after their Git blob IDs were checked against that pinned commit. `POCKETFFT_FILE_HASHES.sha256` records the exact vendored payload.

Lua adaptation changes only the host API: positive axes are 1-based, negative axes retain end-relative meaning, and `{s={}}` spells NumPy's empty transform sequence because an empty Lua table is otherwise reserved for the common options-table form. The FFT runtime is native C++/Lua and does not load Python/CPython.


## LAPACK-backed linalg (0.16.0-dev)

The exact supplied NumPy `main` archive is now available locally. It identifies itself as **NumPy 2.6.0.dev0**, and all **85/85** source/test hashes that predated the linalg work match the existing project pin. The linalg port was re-audited against the same tree rather than retaining the temporary NumPy 2.3.5-only audit from the previous continuation session.

Direct source-of-truth files include:

- `numpy/linalg/_linalg.py`
  - `_commonType`, argument/shape rules, `solve`, `inv`, `slogdet`, `det`, `cholesky`, `qr`, `eig*`, `eigh*`, `svd` and high-level Hermitian-SVD behavior;
- `numpy/linalg/umath_linalg.cpp`
  - gufunc-side matrix packing, LAPACK calls, real-`GEEV` conjugate-pair conversion, empty-SVD initialization, and error signaling;
- `numpy/linalg/tests/test_linalg.py`
  - DType, stack, empty, UPLO, decomposition/reconstruction and error invariants;
- `numpy/linalg/meson.build`
  - native linalg/LAPACK build boundary.

Those four files are now included in `UPSTREAM_FILE_HASHES.sha256`, bringing the directly pinned upstream file set to **89 files**.

The Lua-native 0.16 adaptation calls LAPACK directly through its Fortran ABI:

- `solve` / `inv`: `GESV`;
- `det` / `slogdet`: `GETRF`;
- `cholesky`: `POTRF`;
- `qr`: `GEQRF` plus `ORGQR`/`UNGQR`.

The CPython/gufunc host machinery is not retained as a runtime dependency; its observable validation, DType and layout responsibilities are re-expressed against LuaRay's ndarray/runtime while the numerical LAPACK boundary is preserved.

## Eigenvalue decomposition and SVD continuation (0.17.0-dev)

The same exact NumPy `main` sources were used for the second linalg tranche:

- `eig` / `eigvals` follow the `GEEV` paths. For real matrices, LAPACK's paired real columns are reconstructed into conjugate complex eigenvectors as done by NumPy's native linalg code. Current NumPy main casts `eig`/`eigvals` outputs to the complex counterpart of `result_t` unconditionally, so LuaRay intentionally returns complex DTypes for real input even when the spectrum is purely real.
- `eigh` / `eigvalsh` follow `SYEVD` / `HEEVD`, preserve `UPLO`, and inherit LAPACK's Hermitian convention that only the real diagonal is used.
- `svd` / `svdvals` follow `GESDD`, including stacked operation, full/reduced matrices, values-only mode and NumPy's explicit identity initialization for empty full-SVD outputs.
- `svd(..., hermitian=True)` ports the Python-level NumPy path: `eigh`/`eigvalsh`, absolute eigenvalues, descending argsort/take-along-axis behavior, and sign transfer into `Vh`.

Lua-specific syntax is adapted only at the host boundary: `UPLO` can be passed as a string or option-table field, SVD keyword-style arguments use an options table, and tuple-like NumPy results become multiple Lua returns. Matrix indexing/axes remain internally zero-based; only the Lua-facing boundary uses Lua's 1-based model. No Python/CPython code participates at runtime.


## Least squares and high-level linalg continuation (0.18.0-dev)

The 0.18 tranche was audited against the same exact uploaded NumPy `main` files already pinned in `UPSTREAM_FILE_HASHES.sha256`:

- `numpy/linalg/_linalg.py`
  - `lstsq`, `pinv`, `matrix_rank`, `norm`, `cond`, `_commonType`, empty-array shortcuts, tolerance defaults/broadcasting, and NaN-to-Inf condition-number normalization;
- `numpy/linalg/umath_linalg.cpp`
  - `GELSD_PARAMS`, real/complex workspace queries, `call_gelsd`, and the `lstsq` gufunc packing/residual/rank behavior;
- `numpy/linalg/tests/test_linalg.py`
  - empty `pinv` DType regressions, `rcond`/`rtol` conflicts, rank tolerances, longdouble/clongdouble norm regressions, signed-integer-min norm behavior, invalid norm orders/axes, least-squares edge cases, and condition-number nonfinite behavior;
- `numpy/linalg/meson.build`
  - native LAPACK linkage boundary.

The numerical boundary for `lstsq` is preserved as `DGELSD` / `ZGELSD`. `pinv`, `matrix_rank`, `norm`, and `cond` are high-level NumPy algorithms rather than new independent numerical algorithms: LuaRay ports their observable logic onto its existing SVD/eigh/inverse primitives. In particular, current-main's empty integer `pinv` result uses the computation dtype (`float64`), overriding the older NumPy 2.3.5 development oracle behavior.

Lua adaptation replaces Python keyword-only syntax with options tables and translates positive axes at the host boundary. The native implementation remains zero-based. Because a Lua table cannot distinguish an absent field from a field explicitly assigned `nil`, Python's distinction between omitted `rtol` and explicit `rtol=None` has no literal syntax-equivalent; the ordinary omitted-argument NumPy default is preserved, while numeric/ndarray `rtol` is exposed directly.

## NumPy linalg public-surface closure (0.19.0-dev)

The 0.19 tranche closes the functional public surface listed by the exact pinned NumPy main tree. `numpy/linalg/__init__.py` is now itself pinned in `UPSTREAM_FILE_HASHES.sha256`, bringing the direct source/test audit to **90 files**. Its `__all__` is checked against LuaRay's exported `np.linalg` table; all numerical/function entries are implemented. `LinAlgError` is intentionally not reproduced as a Python exception class: equivalent failure conditions are raised through Lua's native error mechanism.

Source-of-truth behavior for the new functions comes primarily from:

- `numpy/linalg/_linalg.py`: `matrix_power`, `tensorsolve`, `tensorinv`, `outer`, `multi_dot`, `diagonal`, `trace`, `cross`, `matmul`, `tensordot`, `matrix_transpose`, `matrix_norm`, `vector_norm`, and `vecdot` wrappers/algorithms;
- `numpy/linalg/tests/test_linalg.py`: matrix powers, tensor shape/error rules, matrix-chain products, strict linalg-outer dimensionality, last-two-axis diagonal/trace behavior, 3-vector cross products, empty norm behavior, and Array-API aliases;
- `numpy/_core/numeric.py`: cross-product broadcasting/promotion and contraction behavior used by the linalg aliases;
- `numpy/_core/fromnumeric.py`: last-two-axis matrix transpose semantics;
- the previously pinned dot/matmul/reduction sources for the numerical primitives reused underneath these wrappers.

LuaRay preserves the upstream decomposition instead of inventing parallel algorithms: tensor solve/inverse lower into reshapes/permutations plus the existing LAPACK solve/inverse paths; `multi_dot` uses matrix-chain dynamic programming; `tensordot` lowers into permutation/reshape plus native dot; `matrix_power` uses native matmul/inverse and binary exponentiation; `diagonal` remains a read-only view; and `vecdot` conjugates its first operand before the existing product machinery.

The host boundary keeps Lua indexing coherent: positive axes are 1-based and negatives remain end-relative, while `ind`, exponent values, and integer `axes=N` contraction counts are not shifted. Lua 5.4 has fixed-width integers rather than Python arbitrary-precision integers, so `matrix_power` cannot literally accept exponents outside the Lua integer range; this is recorded as a host-language representational difference rather than silently approximating large Python integers with floating point.


## Generic ufunc registry and N-input/N-output iterator (0.20.0-dev)

The 0.20 engine tranche is traced against exact files that were already part of the 90-file upstream pin, so the direct source/test hash count remains unchanged:

- `numpy/_core/code_generators/generate_umath.py`: builtin ufunc arity/signatures and loop families. In the pinned tree, `frexp` is `1 -> 2` with floating mantissa plus integer exponent output, `modf` is `1 -> 2`, `divmod` is `2 -> 2`, and `ldexp` is a heterogeneous `2 -> 1` float/integer-signature ufunc;
- `numpy/_core/src/umath/loops.c.src`: concrete `frexp`, `modf`, `ldexp`, half, and integer/floating loop behavior;
- `numpy/_core/src/umath/loops_modulo.dispatch.c.src`: floating `divmod`/floor-division/remainder behavior and edge conventions;
- `numpy/_core/src/umath/ufunc_object.c`: ufunc execution/output preparation and iterator responsibilities;
- `numpy/_core/src/multiarray/nditer_constr.c` and `nditer_api.c`: operand broadcasting, buffering, casting, output allocation, mask/writeback and external-loop responsibilities used to shape the Lua-native iterator boundary;
- `numpy/_core/tests/test_umath.py` and `test_ufunc.py`: multi-output value/DType, strided `frexp`, `modf`/`divmod`, output tuple, `where`, and error invariants.

LuaRay does not reproduce `PyUFuncObject`, `PyArrayMethodObject`, `PyArray_DTypeMeta`, Python tuple ownership, or CPython reference counting. Instead it preserves the responsibilities that affect observable NumPy behavior in two host-neutral components: `ln_ufunc` stores `nin`, `nout`, registered dtype signatures, kernels and resolver callbacks; `ln_nditer_multi` executes a resolved loop over arbitrary numeric input/output operand counts with broadcasting, input casting, output allocation/casting/writeback, masks and overlap-safe temporaries.

The first registry-only operations are `frexp`, `modf`, `divmod`, and `ldexp`. They intentionally do not extend the legacy `ln_binary_op` enum. That older 56-operation path remains temporarily in place for already validated single-output ufuncs, so 0.20 is a compatibility-preserving architectural foundation rather than a flag-day rewrite of all existing ufuncs.


## Registry migration and generalized KEEPORDER (0.21.0-dev)

The 0.21 migration uses exact upstream files already present in the **90-file** source/test pin, principally `numpy/_core/code_generators/generate_umath.py`, `numpy/_core/src/umath/ufunc_object.c`, `numpy/_core/src/multiarray/nditer_constr.c`, `numpy/_core/src/multiarray/nditer_api.c`, the pinned umath loop/dispatch sources, and `numpy/_core/tests/test_umath.py` / `test_ufunc.py`. No new upstream hash entry is required for this tranche, so the direct audit remains **90/90**.

Nineteen pre-existing public operations now have real `ln_ufunc` registry entries: `add`, `subtract`, `multiply`, `true_divide`; `equal`, `not_equal`, `less`, `less_equal`, `greater`, `greater_equal`; and `negative`, `absolute`, `positive`, `sign`, `logical_not`, `isnan`, `isinf`, `isfinite`, `signbit`. Their host-neutral registry metadata separates arity, DType signatures/resolution and strided execution. Existing NumPy-derived numerical loops are reused, with a small unary ABI adapter where needed, instead of duplicating the numerical implementation. Mixed `int64`/`uint64` comparisons retain their exact source-derived loops rather than promoting through floating point.

`ln_nditer_multi` also now carries the NpyIter KEEPORDER responsibility across arbitrary participating operands. The output-axis order is selected from broadcast operand strides using the same stable stride-ordering idea as upstream rather than the 0.20 first-input C/F shortcut. This preserves observable output strides for nontrivial transposed and negative-stride inputs while keeping the iterator independent of the mathematical operation being executed.

The Lua public boundary is migrated incrementally: ndarray↔ndarray function/operator paths for these operations use the generic registry, but weak Lua scalar promotion deliberately remains on the existing compatibility bridge in 0.21. That distinction is documented rather than hidden because weak-scalar resolution belongs in the future generic DType resolver. The legacy enum remains at 56 values and is not itself treated as the long-term dispatch architecture.


## Weak-scalar promotion and second registry migration (0.22.0-dev)

The 0.22 tranche remains within the existing **90/90 exact upstream file pin**. The main source-of-truth paths are `numpy/_core/src/umath/ufunc_object.c` (`mark_pyscalar_operand` and weak Python-scalar dispatch), `numpy/_core/src/umath/dispatching.cpp` (promotion/dispatch responsibilities), `numpy/_core/tests/test_nep50_promotions.py` (weak-scalar value/range semantics), `numpy/_core/code_generators/generate_umath.py`, the pinned ufunc loop sources, and the NpyIter construction/API sources already audited in 0.20/0.21.

LuaRay does not recreate Python abstract scalar DTypes or temporary `PyArrayObject` flags. Instead, Lua booleans, integers, floating numbers, and native complex userdata enter `ln_ufunc` as weak host-neutral operands. The resolver applies the same observable builtin-numeric promotion/range rules and then materializes a temporary 0-D ndarray in the resolved loop DType. This is the Lua-native equivalent of the responsibility served by NumPy's Python-scalar marking machinery, not a copy of its CPython representation.

The newly migrated registry families are logical binary operations, min/max and NaN-ignoring min/max, floor division/remainder/power, integer bitwise operations, `copysign`, `arctan2`, and `hypot`. Integer-power negative-exponent validation is carried by a generic per-chunk validator hook in `ln_nditer_multi`, preserving masked execution semantics without teaching the iterator any ufunc name or legacy operation ID.


## Transcendental unary registry closure (0.23.0-dev)

This tranche remains within the existing **90/90 exact upstream source/test pin**. The principal source-of-truth files are already-pinned `numpy/_core/code_generators/generate_umath.py`, the real/half/complex umath loop sources, `numpy/_core/src/umath/ufunc_object.c`, the NpyIter construction/API sources, and the upstream umath tests. `generate_umath.py` is authoritative for the loop families: the migrated unary transcendentals expose inexact signatures; integer/bool inputs are accepted through safe loop resolution rather than dedicated integer kernels; complex signatures exist where upstream defines them; `cbrt` has no complex loop.

LuaRay registers all 21 remaining unary transcendental/inverse operations in `ln_ufunc` and reuses the existing NumPy-derived native loops through the same host-neutral unary ABI adapter used by the first migration. With these registrations the host-neutral registry has **60 entries**: four operations that were registry-native from 0.20 plus every one of the legacy 56 numeric `LN_OP_*` operations. Public unary and binary ufunc wrappers now require the registry and no longer fall back to the legacy specialized executor. The enum is still retained internally as a kernel-selection identifier and for older reduction/low-level code, so the internal cleanup can proceed independently of public semantic compatibility.


## DType class / descriptor split (0.24.0-dev)

The 0.24 architecture tranche adds `numpy/_core/include/numpy/dtype_api.h` to the exact source pin, bringing the directly verified upstream set to **91/91 files**. Together with the already-pinned `ndarraytypes.h`, `dtypemeta.c`, `common_dtype.c`, `abstractdtypes.c`, and `ufunc_object.c`, it is the implementation specification for separating DType **class-level behavior** from concrete descriptor instances.

LuaRay does not port `PyArray_DTypeMeta` as a Python metaclass. Its host-neutral `ln_dtype_class` retains the responsibilities needed by the numerical runtime: stable class identity, class flags, default descriptor, class-level common-DType selection, and same-class common-instance resolution. `ln_dtype_descr` corresponds to the concrete descriptor role and carries class ownership plus byte order, itemsize, alignment, flags, and metadata. Current builtin numerics are singleton/non-parametric, but arrays now explicitly store descriptor instances and ufunc loop signatures explicitly store DType classes. A separate per-call resolution step converts the selected class signature into concrete descriptors before `ln_nditer_multi` executes the loop, preserving an existing input descriptor whenever it already belongs to the selected class.

This intentionally ports the capability implemented by NumPy's DTypeMeta/ArrayMethod descriptor machinery while omitting CPython type objects, Python scalar-discovery objects, reference counting, and metaclass dispatch. Parameterized descriptors are the next consumer of this boundary; none are claimed in 0.24 itself.


## Parameterized datetime64/timedelta64 DTypes (0.25.0-dev)

The direct source pin expands from 91 to **93/93 exact files** by adding `numpy/_core/src/multiarray/datetime.c` and `numpy/_core/tests/test_datetime.py`. Existing pinned `numpy/_core/code_generators/generate_umath.py`, `numpy/_core/src/umath/loops.c.src`, `numpy/_core/src/umath/ufunc_type_resolution.c`, `ndarraytypes.h`, and `dtype_api.h` provide the remaining ufunc/DType contracts.

LuaRay ports the observable responsibilities rather than CPython descriptors: temporal values are int64 payloads with `NPY_DATETIME_NAT == INT64_MIN`, while concrete `ln_dtype_descr` instances carry `(base unit, multiplier)` metadata. NumPy's metadata greatest-common-divisor/conversion and strict nonlinear timedelta rules determine class common instances and casts. The ufunc ArrayMethod-style concrete-descriptor hook resolves temporal loop descriptors per invocation before `ln_nditer_multi`; this is required because two arrays may share the same DType class and legacy type number while still requiring a metadata conversion.

The arithmetic/comparison/unary/minmax loops are ports of the pinned `loops.c.src` semantics. NumPy-main's newer signed-int64 overflow contract is preserved for temporal add/subtract, including rejecting a mathematically valid result equal to the NaT sentinel and allowing NaT inputs to propagate. LuaRay implements the host-neutral error preflight in the ufunc validator and keeps the raw kernel itself free of signed-C undefined behavior so masked invalid positions can be computed-and-discarded safely.

`test_datetime.py` is also the source of truth for extended-unit parsing and historical quirks. Full ISO datetime string parsing/formatting from NumPy's datetime string machinery is intentionally not claimed in 0.25; constructors currently accept integer counts with explicit units and `NaT`, while the descriptor/runtime/ufunc semantics are established first.


## ISO datetime string parsing/formatting (0.26.0-dev)

The direct upstream audit expands from 93 to **95/95 exact files** by pinning `numpy/_core/src/multiarray/datetime_strings.c` and `numpy/_core/src/multiarray/datetime_strings.h` from the supplied NumPy `main` archive. These files, together with the already-pinned `datetime.c` and `test_datetime.py`, are the implementation specification for parsing text into NumPy datetime structures, selecting inferred temporal units, applying timezone offsets, calendar/int64 conversion, and rendering datetime payloads back to strings.

LuaRay ports those responsibilities into `ln_datetime_strings` without Python Unicode objects, warnings objects, or `tzinfo` instances. The public Lua boundary accepts ISO-like strings in `np.datetime64` and datetime-array construction, performs common-descriptor discovery before ndarray allocation when a generic `datetime64` DType is requested, and exposes scalar `np.datetime_as_string`. Explicit Python timezone objects are replaced only where a host-natural representation exists (`"naive"`, `"UTC"`, `"local"`, or integer minute offsets); no fake `ZoneInfo` hierarchy is introduced.

The integer conversion code follows upstream's arithmetic semantics, including historical wrap behavior for extreme femtosecond/attosecond values, but expresses wrapping with unsigned arithmetic so the C implementation itself contains no signed-overflow UB. The source test corpus is authoritative where an older installed NumPy oracle differs or emits host-specific warnings. Array-valued `datetime_as_string` output is deliberately deferred until LuaRay has an actual string/unicode ndarray DType rather than a Lua-table approximation.


## Legacy fixed-width strings/unicode (0.27.0-dev)

The direct audit expands from 95 to **98/98 exact upstream files** by adding `numpy/_core/src/multiarray/descriptor.c`, `numpy/_core/tests/test_strings.py`, and `numpy/_core/tests/test_unicode.py`. They complement the already-pinned `legacy_dtype_implementation.c`, `arraytypes.c.src`, `convert_datatype.c`, `dtype_transfer.c`, `dtypemeta.c`, and DType API headers used to define legacy `NPY_STRING`/`NPY_UNICODE` descriptor construction, width/itemsize semantics, comparison ordering, padding/truncation, byte swapping, transfer/cast behavior and current regression expectations.

LuaRay maps these responsibilities onto host-neutral parameterized `ln_dtype_class`/`ln_dtype_descr` objects. `S<n>` is fixed-width raw bytes; `U<n>` is fixed-width UCS4 storage with explicit byte order. Lua strings are the host boundary: explicit `S` consumes their bytes directly, while `U` validates/decodes UTF-8 and counts Unicode code points for descriptor discovery. This is a Lua-native replacement for Python `bytes`/`str` host objects; no CPython Unicode representation is retained.

Comparison loops are registered through the generic ufunc/ArrayMethod-style mechanism with descriptor-aware per-call loop data carrying concrete widths/endianness. The iterator remains DType-agnostic. Current NumPy-main tests explicitly reject default mixed legacy `S`/`U` comparison ufunc dispatch, and LuaRay preserves that behavior. Numeric↔string formatting/parsing casts and NumPy's newer variable-width `StringDType` are not claimed in 0.27.

With real Unicode ndarrays available, the array branch of NumPy's datetime string formatter can now return `U` ndarrays instead of being deferred. Output width is derived from the already-pinned `datetime_strings.c` `NpyDatetime_GetDatetimeISO8601StrLen` rules, so this extension reuses the upstream datetime implementation contract rather than inventing a string-table representation.


## Legacy string/numeric/temporal casting and discovery (0.28.0-dev)

The direct audit expands from 98 to **99/99 exact upstream files** by adding `numpy/_core/tests/test_casting_unittests.py`. Together with the already-pinned `convert_datatype.c`, `dtype_transfer.c`, `array_coercion.c`, `datetime.c`, `test_api.py`, `test_datetime.py`, `test_strings.py`, and `test_unicode.py`, it is the source of truth for the legacy string/numeric/temporal transfer matrix and descriptor sizing rules.

LuaRay now ports default `astype`/transfer behavior across legacy fixed-width `S`/`U`, builtin numeric DTypes, and temporal DTypes. Generic string target widths are derived from the source DType contract rather than the observed text value; string-to-numeric conversion follows NumPy parsing semantics; numeric/temporal transfers preserve raw count/NaT behavior; generic `datetime64` discovery from string arrays resolves a concrete common temporal descriptor before allocation. Mixed Lua string/numeric discovery uses the same descriptor-sizing responsibilities instead of treating strings as an unrelated host-only type.

This tranche does **not** claim NumPy's complete public cast-policy surface. `astype(casting=...)`, `np.can_cast`, explicit ufunc signature forcing, and modern variable-width `StringDType` remain future work. The installed NumPy 2.3.5 development oracle is used only where its behavior matches the supplied main tree; the supplied 2.6.0.dev0 source remains authoritative.

## Casting policy and `same_value` astype (0.29.0-dev)

The direct upstream audit expands from 99 to **102/102 exact files** by adding `numpy/_core/src/multiarray/conversion_utils.c`, `numpy/_core/src/multiarray/methods.c`, and `numpy/_core/tests/test_conversion_utils.py`. They complement the already-pinned `can_cast_table.h`, `convert_datatype.c`, `lowlevel_strided_loops.c.src`, `datetime.c`, and `test_casting_unittests.py`.

LuaRay ports the responsibility split visible in those sources rather than Python argument-converter objects. The normal casting converter accepts exactly `no`, `equiv`, `safe`, `same_kind`, and `unsafe`; `np.can_cast` uses only that set. The `astype` boundary uses the extended converter and additionally accepts `same_value`. Descriptor-level safety is resolved from concrete numeric, fixed-width string/unicode, and temporal descriptors. Numeric `same_value` follows the generated low-level loop contract: destination range is checked before conversion, finite values must be preserved exactly, NaN/Inf are only value-preserving for floating/complex destinations, and complex-to-real requires zero imaginary part. Temporal same-value conversion follows the safe metadata rules in `datetime.c`.

The Lua implementation does not reproduce `PyArray_CastingConverter`, `PyArrayMethod_Context`, or Python exception machinery. It provides host-neutral parser/policy functions and a value-checking transfer preflight used by ndarray `astype`, then executes the existing native descriptor transfer.


## Concatenate and stack source audit (0.30.0-dev)

The **separately supplied NumPy 2.5.3 release source** is the exact additional
source reference for this tranche; it does not replace the original main
commit pin above. Its six audited, byte-exact sources and tests are pinned in
`NUMPY_2_5_3_JOIN_FILE_HASHES.sha256`:

- `numpy/_core/src/multiarray/multiarraymodule.c`: the
  `PyArray_ConcatenateInto` / `PyArray_ConcatenateArrays` native entrypoints,
  input sequence validation, axis=None flattening, result-shape checks,
  `out`/`dtype` exclusivity, and same-kind default casting.
- `numpy/_core/shape_base.py`: stack semantics as expanded views plus
  concatenation along an inserted axis, and dtype/out/casting arguments.
- `numpy/_core/src/multiarray/shape.c`: ndarray dimensions, strides and
  reshape/contiguity background used by joining views.
- `numpy/_core/src/multiarray/convert_datatype.c`: result DType promotion
  and descriptor-level casting semantics.
- `numpy/_core/tests/test_shape_base.py` and
  `numpy/_core/tests/test_multiarray.py`: shape manipulation, stacking and
  concatenation regression expectations.

LuaRay moves the source-defined operations to `src/ln_join.[ch]`, reusing
`ln_common_dtype_descr`, `ln_cast_strided_numeric`, and the native ndarray
buffer/view model. C-order coordinate iteration replaces upstream's Python
sequence handling and C-iterator glue, while the Lua adapter handles the
1-based axis contract and nested-table input construction. Python is used
only to generate a frozen **355-case** differential oracle from local NumPy
2.3.5. Cross-version cases with differing semantics must be assessed against
the supplied 2.5.3 sources instead; no claim of executing NumPy 2.5.3 is made.


## Split / array_split / hsplit / vsplit / dsplit source audit (0.31.0-dev)

The user-supplied **NumPy 2.5.3** release archive defines splitting in
`numpy/lib/_shape_base_impl.py` (`array_split`, `split`, `hsplit`, `vsplit`,
`dsplit`) and validates it in `numpy/lib/tests/test_shape_base.py`. The
core shape-base tests in `numpy/_core/tests/test_shape_base.py` supply related
view and indexing behavior. These three exact source files are recorded in
`NUMPY_2_5_3_SPLIT_FILE_HASHES.sha256`. The original pinned NumPy-main
source hashes are retained unchanged.

The source-defined split contract is ported to the host-neutral
`src/ln_split.[ch]` using NumPy-style half-open integer slice boundaries and
`ln_array_view` (with refcounted owner, shape/stride metadata and no data
copying); `src/lua_module.c` adapts public 1-based positive axes, explicit
integer/list/1-D-ndarray boundaries and Lua userdata ownership. Integer
`split` enforces equal division; `array_split` uses quotient/remainder,
assigning the extra elements to the earliest sections. The `hsplit`,
`vsplit`, `dsplit` variants enforce upstream rank constraints and select
their source-defined axes. Negative/out-of-bounds boundaries are normalized
with slice clipping, not indexing errors. A zero-volume view retains its
allocation without potentially invalid pointer advancement.

The separately installed local NumPy **2.3.5** executable generated the
5,557-case frozen oracle (4,432 accepted, 1,125 rejected), against which
LuaRay passes. The supplied 2.5.3 source archive was read and hashed; no
NumPy 2.5.3 executable tests are claimed. Runtime execution remains native
C/Lua only, without CPython or a NumPy library dependency.


## Axis/view manipulation source audit (0.32.0-dev)

The separately supplied NumPy **2.5.3** source tarball was inspected for
`flip`, `rot90`, `flipud`, `fliplr`, `transpose`, `swapaxes`, `moveaxis`,
`expand_dims`, and `squeeze`. The relevant host-independent contracts are
adapted into `src/ln_axis.[ch]`, with a Lua 1-based host adapter in
`src/lua_module.c`. The exact SHA-256 hashes of the ten source/test files
are in `NUMPY_2_5_3_AXIS_FILE_HASHES.sha256`:

- `_core/numeric.py`: moveaxis permutation/axis normalization;
- `_core/fromnumeric.py`: transpose/swapaxes/squeeze;
- `lib/_function_base_impl.py`: flip/rot90;
- `lib/_twodim_base_impl.py`: flipud/fliplr;
- `lib/_shape_base_impl.py`: expand_dims;
- their corresponding `_core` and `lib` tests.

The implementation uses NumPy's `ndarray` metadata model: all array-valued
results are allocation-sharing views with refcounted owner preservation,
noncontiguous/negative byte strides, concrete DType descriptors and writeable
flags. `expand_dims` reuses the existing source-derived `reshape` to preserve
nontrivial singleton strides; if a view cannot be obtained in an unsupported
corner case, it uses a metadata-only shared-owner fallback rather than
copying the array. An empty-volume reversed array does not advance a pointer
past its allocation. The 0-D `flip` index behavior yields a Lua scalar as
upstream yields a NumPy scalar.

The generated **4,544-case** suite freezes reference results obtained from
local NumPy **2.3.5**, because the supplied NumPy 2.5.3 archive is source
only. The previous 46 suites pass unchanged. Nothing in the native LuaRay
runtime calls into NumPy or CPython.

## Native broadcasting / stride tricks source audit (0.33.0-dev)

The independently supplied `numpy-2.5.3.tar.gz` was inspected for
`broadcast_to`, `broadcast_arrays`, and `broadcast_shapes`, alongside the
common-array-assignment stride and multidimensional iterator machinery. The
five source/test SHA-256 fingerprints are in
`NUMPY_2_5_3_BROADCAST_FILE_HASHES.sha256`. In particular,
`numpy/lib/_stride_tricks_impl.py` contains `_broadcast_to` using an
`nditer`-derived strided view, a read-only result for `broadcast_to`, and
historical writable behavior for `broadcast_arrays` where the base permits it.
The C translation in `ln_axis_broadcast_to` builds a shared-owner array view
with NumPy-compatible zero strides for repeated axes. `broadcast_arrays`
keeps existing strides when no shape expansion is necessary, while
`broadcast_shapes` uses the already-native multiarray shape merger.

The full new 3,077-case differential matrix was frozen against **NumPy
2.3.5** installed locally; the NumPy 2.5.3 archive was used as a verified
source reference and was not executable as 2.5.3. There is no NumPy,
Python, or CPython runtime dependency in LuaRay.


## Native `tile` / `repeat` implementation audit (0.34.0-dev)

The supplied NumPy **2.5.3** source tarball (not an installed 2.5.3
binary) was referenced for:

- `numpy/lib/_shape_base_impl.py`: `tile` rank promotion, shape multiplication,
  copy and repeated block semantics;
- `numpy/_core/fromnumeric.py`: `repeat` dispatch and its optional axis;
- `numpy/_core/src/multiarray/item_selection.c`: `PyArray_Repeat` source
  sequence expansion rules, axis and count validation;
- the upstream `_core` and `lib` shape/numeric/multiarray test files.

Their content fingerprints are pinned in
`NUMPY_2_5_3_REPEAT_FILE_HASHES.sha256`. The native code in
`src/ln_repeat.[ch]` implements the supported fixed-width data model with
independent allocations; no NumPy or Python runtime is linked. The executable
oracle used to generate the 8,030 cases was locally installed **NumPy 2.3.5**.
The full historical regeneration target exceeded its execution limit; all
49 frozen/generated suites were run independently and passed.

## LuaRay 0.35: `roll` and `rollaxis`

The supplied NumPy **2.5.3** `numpy/_core/numeric.py` implementation is the
source of truth for slice-based rolling, repeated-axis shift accumulation,
flatten-first behavior and `rollaxis` insertion positions. Its tests in
`numpy/_core/tests/test_numeric.py` were inspected as an additional
reference. The two SHA-256 values are recorded in
`NUMPY_2_5_3_ROLL_FILE_HASHES.sha256`. Test expectations were generated
using NumPy 2.3.5 installed in the development environment; this does not
claim execution of NumPy 2.5.3.

## LuaRay 0.36: minimum-dimensional views

The `atleast_1d`, `atleast_2d`, and `atleast_3d` functions were implemented
against `numpy/_core/shape_base.py` in the supplied **NumPy 2.5.3** source
archive, with the corresponding shape-base and multiarray test files as
references. `NUMPY_2_5_3_ATLEAST_FILE_HASHES.sha256` pins those exact archive
members. Native `ln_axis_atleast` in `src/ln_axis.c` uses shared-ownership
views and NumPy newaxis-style zero strides for inserted singleton dimensions,
with byte-sized scalar strides for reshaped 0-D inputs. Lua `atleast_function`
converts array-likes once, retains each input alive through view construction,
and returns a single ndarray or a table of ndarrays according to arity.

The 483-case generated oracle used installed NumPy **2.3.5** as the runnable
reference. It is not a claim that NumPy 2.5.3 itself was installed/executed.
No portion of the native runtime depends on CPython or NumPy.

## Convenience shape stacks: 0.37.0-dev

NumPy 2.5.3 archive (`NUMPY_2_5_3_SHAPE_STACK_FILE_HASHES.sha256`):
`numpy/_core/shape_base.py` (`hstack`, `vstack`, `dstack`, `column_stack`,
`row_stack`) and `numpy/_core/tests/test_shape_base.py`. LuaRay adds
native host-layer rank normalization to the existing `ln_join_arrays`
and `ln_axis` implementations rather than invoking NumPy.
NumPy 2.3.5 was used only to generate and validate development fixtures.

## LuaRay 0.38: copy-producing append and delete

NumPy 2.5.3 archive, under the exact paths recorded in
`NUMPY_2_5_3_APPEND_DELETE_FILE_HASHES.sha256`:
`numpy/lib/_function_base_impl.py` (`append`, `delete`),
`numpy/lib/tests/test_function_base.py`, and the general array construction
and flattening references in `numpy/_core/numeric.py` and
`numpy/_core/tests/test_numeric.py`.

`append` is reimplemented using the existing native join kernel. `delete`
uses a C mask-to-positions transfer kernel (not a Python bridge), supporting
sequences/slices/boolean masks and arbitrary source strides, with Lua
1-based public indices. The executable differential oracle was the
locally installed NumPy 2.3.5, not a binary of the provided 2.5.3 tarball.
Exact advanced-index deletion output memory-order matching remains pending.


## LuaRay 0.39: native insertion

From the user-provided NumPy 2.5.3 release tarball, `numpy/lib/_function_base_impl.py`
(`insert`, including the scalar vs sequence index branch, stable mergesort,
1-D boolean indices and dtype coercion), and
`numpy/lib/tests/test_function_base.py` are the exact reference sources.
Their SHA-256 checksums are preserved in
`NUMPY_2_5_3_INSERT_FILE_HASHES.sha256`. The executable comparison used
only locally installed NumPy 2.3.5 at test-generation time. LuaRay's
production implementation is entirely C and Lua 5.4.

## 0.40.0-dev consolidation

Builtin numeric plus legacy S/U common-descriptor promotion now uses the
existing native legacy-width table (`src/ln_dtype_transfer.c`) and the
fixed-width DType class machinery (`src/ln_string.c`). The pinned NumPy
2.5.3 descriptor and casting source references from the previous string and
joining work continue to apply; no new upstream source paths were introduced.

## 0.41 statistical reduction reference

Supplied NumPy 2.5.3 release sources:

- `numpy/_core/_methods.py`: `_var` and `_std`, two-pass mean/center/square,
  DType promotion and `ddof` / `where` behavior.
- `numpy/_core/tests/test_multiarray.py` and `numpy/_core/tests/test_numeric.py`:
  existing NumPy core regression expectations.

Exact source SHA-256 digests: `NUMPY_2_5_3_STATS_FILE_HASHES.sha256`.
The executable development oracle remains locally installed NumPy 2.3.5.

## LuaRay 0.43: selection and peak-to-peak reductions

The user-supplied NumPy 2.5.3 release was examined for the public
`argmin`/`argmax`/`ptp` semantics in `numpy/_core/fromnumeric.py`, the
native reduction implementation in `numpy/_core/src/multiarray/calculation.c`,
and relevant NumPy core tests. File content SHA-256 references are pinned in
`NUMPY_2_5_3_SELECTION_FILE_HASHES.sha256`. Runtime C uses the pre-existing
LuaRay DType-native comparisons and reduction output logic, not Python.
The differential oracle is the locally installed NumPy 2.3.5. LuaRay's
public indices are intentionally one-based; the generator adds one to
NumPy's indices before comparing.

## LuaRay 0.44: percentile, quantile and median

The user-supplied NumPy **2.5.3** release tarball was inspected for the
public quantile/median algorithms, sorting/interpolation variants and tests:

- `numpy/lib/_function_base_impl.py`
- `numpy/lib/tests/test_function_base.py`
- `numpy/_core/function_base.py`
- `numpy/_core/tests/test_function_base.py`

Their SHA-256 references are pinned in
`NUMPY_2_5_3_QUANTILE_FILE_HASHES.sha256`.
The executable test oracle was NumPy **2.3.5**; no claim is made that NumPy
2.5.3 was built or executed. The Lua implementation does not embed Python.

## LuaRay 0.46: nan-aware arithmetic and statistical reductions

Reviewed these exact files from the user-supplied NumPy 2.5.3 archive:
`numpy/lib/_nanfunctions_impl.py`, `numpy/lib/tests/test_nanfunctions.py`,
`numpy/_core/_methods.py`, and `numpy/_core/fromnumeric.py`. Their source
SHA-256 values are recorded in
`NUMPY_2_5_3_NANREDUCTIONS_FILE_HASHES.sha256`.
The native C code is LuaRay's own implementation of the corresponding
semantics, reusing its established reduction kernels; NumPy 2.3.5 was the
locally installed executable differential oracle.

## LuaRay 0.47: NaN-aware extrema and arg extrema

Source reference NumPy 2.5.3: `numpy/lib/_nanfunctions_impl.py` and
`numpy/lib/tests/test_nanfunctions.py`, with reduction behavior from
`numpy/_core/_methods.py`. The exact upstream SHA-256 digests are recorded
in `NUMPY_2_5_3_NANEXTREMA_FILE_HASHES.sha256`.
NumPy 2.3.5 is the executable test oracle. The port implements
`nanmin`, `nanmax`, `nanargmin`, `nanargmax` natively; `nanptp` is absent
from the NumPy 2.3.5 API and is not presented as a compatibility function.
LuaRay's indexing remains one-based. Runtime warnings from NumPy are
not emitted, and all-NaN payload handling is not guaranteed bit-for-bit.

## 0.52 PCG64 bounded-integer sampling

NumPy 2.5.3 `_generator.pyx`, `_bounded_integers.pyx.in`, and
`src/distributions/distributions.c` (Lemire sampling and packed-bit
buffers), together with `src/pcg64/pcg64.h` (32-bit cached halves), were
inspected. Exact hashes: `NUMPY_2_5_3_INTEGERS_FILE_HASHES.sha256`.

## 0.54 — exponential PCG64 distribution source audit

Reviewed the exact user-provided NumPy 2.5.3 files:
`numpy/random/src/distributions/distributions.c` (Ziggurat exponential
and inverse-CDF sampling), `numpy/random/src/distributions/ziggurat_constants.h`
(exponential tables), and `numpy/random/_generator.pyx` (API validation,
float32/float64 and `exponential(scale)` behavior). Exact hashes are in
`NUMPY_2_5_3_EXPONENTIAL_FILE_HASHES.sha256`.
The Ziggurat constants are already retained under NumPy's BSD-3-Clause
license in `src/third_party/numpy_ziggurat_constants.h`. The C kernels
were ported for native LuaRay; no NumPy/Python runtime dependency exists.
The independent oracle was executable NumPy 2.3.5.

## 0.55 lognormal / Cauchy / Laplace distributions

Reference NumPy 2.5.3 `numpy/random/src/distributions/distributions.c`:
`random_lognormal`, `random_standard_cauchy`, `random_laplace`, with the
NumPy `Generator` signatures in `numpy/random/_generator.pyx`.
Executable differential oracle was NumPy 2.3.5, generated via
`tools/generate_distributions55_differential.py`.

## 0.58 — Gamma, Beta, standard_gamma

Audited supplied NumPy 2.5.3 source `numpy/random/src/distributions/distributions.c`
(`random_standard_gamma`, `random_standard_gamma_f`, `random_gamma`,
`random_beta`) and `numpy/random/_generator.pyx` for signature behavior.
`NUMPY_2_5_3_DISTRIBUTIONS58_FILE_HASHES.sha256` pins the inspected
source files. The native implementation is tested against executable
NumPy 2.3.5 and does not call Python or NumPy during execution.


## 0.60 — noncentral distributions

The original `random_poisson_mult`, `random_poisson_ptrs`,
`random_noncentral_chisquare` and `random_noncentral_f` algorithms come from
NumPy 2.5.3 `numpy/random/src/distributions/distributions.c`;
`NUMPY_2_5_3_DISTRIBUTIONS60_FILE_HASHES.sha256` records the source's
SHA-256. The numerical oracle was executable NumPy 2.3.5.
No NumPy, Python or CPython runtime dependency is introduced.


## 0.61 — Poisson public API

`Generator.poisson(lam=1.0, size=None)` is based on NumPy 2.5.3 source
`numpy/random/src/distributions/distributions.c` (`random_poisson_mult`,
`random_poisson_ptrs`, `random_poisson`) and
`numpy/random/_generator.pyx` (public signature). These exact source files
are pinned by `NUMPY_2_5_3_POISSON_FILE_HASHES.sha256`.
The independent executable oracle is NumPy 2.3.5; 8,492 exact result,
shape, DType and next-PCG64-word checks were performed against it.
The implementation reuses the 0.60 scalar Poisson kernel, with no Python
runtime dependency and a documented scalar intensity cap of 1e12.

## 0.62 — Binomial distribution

The native `Generator.binomial` implementation is adapted from NumPy 2.5.3
`numpy/random/src/distributions/distributions.c`: `random_binomial`,
`random_binomial_inversion` and `random_binomial_btpe`. Public argument
conventions were cross-checked with NumPy's `random/_generator.pyx`.
The inspected upstream SHA-256 fingerprints are recorded in
`NUMPY_2_5_3_BINOMIAL_FILE_HASHES.sha256`; the bundled NumPy BSD license
continues to apply to adapted C source. Differential expectations were
independently produced by NumPy 2.3.5. No Python/NumPy runtime dependency.

## 0.63 — Negative binomial distribution

Native `Generator.negative_binomial` is based on NumPy 2.5.3
`numpy/random/src/distributions/distributions.c` (`random_negative_binomial`),
with `numpy/random/_generator.pyx` used to check public semantics.
`NUMPY_2_5_3_NEGATIVE_BINOMIAL_FILE_HASHES.sha256` pins both source files.
It uses the existing native Gamma and Poisson implementations without
calling NumPy/Python during execution. The oracle was NumPy 2.3.5.


## 0.65 — Zipf

`ln_pcg64_zipf` follows the `random_zipf` rejection sampler in NumPy
2.5.3 `numpy/random/src/distributions/distributions.c`; the method's
public signature comes from `numpy/random/_generator.pyx`.
Their SHA-256 checksums are in
`NUMPY_2_5_3_ZIPF_FILE_HASHES.sha256`. The NumPy BSD-3-Clause license is
included. Numerical and stream oracle: executable NumPy 2.3.5, not the
source archive. Python/NumPy are not linked into LuaRay.

## 0.71 — Standard Student's t and von Mises

The native functions `ln_pcg64_standard_t` and `ln_pcg64_vonmises` were
ported from NumPy 2.5.3 `numpy/random/src/distributions/distributions.c`
(`random_standard_t` and `random_vonmises`). The callable interface and
argument shape were cross-checked against
`numpy/random/_generator.pyx`. The files' SHA-256 fingerprints are stored in
`NUMPY_2_5_3_STUDENT_VONMISES_FILE_HASHES.sha256`; code originating from
NumPy is subject to its bundled BSD-3-Clause license. A standalone
reproducible reference generator in `tools/generate_distributions71_differential.py`
uses independently installed NumPy 2.3.5 to build the committed oracle.
Python is not linked into LuaRay.

## 0.78 — Generator parameter broadcasting

The public NumPy 2.5.3 `Generator` signatures and parameter-domain rules come
from `numpy/random/_generator.pyx`; existing LuaRay samplers in `ln_random.c`
follow `numpy/random/src/distributions/distributions.c`. SHA-256 reference
hashes are in `NUMPY_2_5_3_RANDOM78_FILE_HASHES.sha256`. The original NumPy
code is BSD-3-Clause licensed (`THIRD_PARTY_NUMPY_LICENSE.txt`). This release
adds broadcasting in the Lua API, not new native random algorithms. The 2.3.5
NumPy environment supplies independent executable test reference values and
never participates in LuaRay runtime execution.

## 0.79 — Generator rejection-sampler parameter broadcasting

The reference signatures and validation come from NumPy 2.5.3
`numpy/random/_generator.pyx`; sampling order follows
`numpy/random/src/distributions/distributions.c` for Gamma, Beta, Chi-square
and Fisher F. The fingerprints of these upstream sources are stored in
`NUMPY_2_5_3_RANDOM79_FILE_HASHES.sha256`. NumPy's bundled BSD-3-Clause
license is included as `THIRD_PARTY_NUMPY_LICENSE.txt`. NumPy 2.3.5 produces
independent executable test values; no CPython runtime is linked.

## Memory / masked assignment reference (0.97)

NumPy 2.5.3 common/mem_overlap.c, array_assign_array.c, array_assign_scalar.c, item_selection.c, and test_mem_overlap.py are recorded in `NUMPY_2_5_3_MEMORY97_FILE_HASHES.sha256`. The test oracle executed in this environment is NumPy 2.3.5.
