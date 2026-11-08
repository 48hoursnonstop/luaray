## LuaRay 0.103.0-dev — nonzero and condition-based extraction

Native `nonzero`, `flatnonzero`, `compress` and `extract` now provide C-order
coordinates and selected values through a dedicated condition subsystem and
the tested take engine. Nonzero preserves interleaved coordinate strides;
method forms and advanced-index composition are executed through the Lua API.

Read the [English condition reference](docs/en/condition_selection.md) or
[referencia en español](docs/es/condition_selection.md). **3,089 NumPy 2.5.3
cases / 121,704 checks**, 95 Lua checks and native tests passed. Full regression
contains **124 fixture files**; runtime remains Lua/native C/C++.

## LuaRay 0.102.0-dev — native array selection

`np.choose` / `ndarray:choose` now broadcast selectors and choices through a
native C engine, with weak/strong dtype resolution, modes and real output/alias
semantics. Shared date casts now preserve short-buffer errors and ASCII/Unicode
error boundaries; cross-kind temporal casts preserve integer ticks.

Read the [English choose reference](docs/en/choose.md) or
[referencia de choose en español](docs/es/choose.md). **3,481 NumPy 2.5.3 cases /
101,519 checks**, 69 Lua checks and native tests passed; full regression contains
**120 fixture files**. Two owning-buffer guard variants remain outside parity.

## LuaRay 0.101.0-dev — gather and assign along an axis

`np.take_along_axis` and `np.put_along_axis` now use native orthogonal advanced
indices, with multidimensional broadcasting, iterator memory order, protected
shared operands and buffered dtype conversion. The explicit flat path preserves
NumPy's distinction between writable C-contiguous views and read-only copies.

Read the [English API reference](docs/en/along_axis.md) or
[referencia de API en español](docs/es/along_axis.md). **5,660 original NumPy
2.5.3 cases / 540,651 checks**, 85 Lua checks and native tests passed. The full
regression contains **119 fixture files**. Runtime remains Lua and native C/C++.

## LuaRay 0.100.0-dev — native indexed gathering

`np.take(input, indices, axis_or_options)` and `input:take(...)` gather through
the C ndarray engine, with one-based Lua coordinates, axes, bounds modes,
scalar results and actual out/overlap/error semantics. String conversion now
preserves a failed ASCII output cell and embedded NUL data.

Read the [English take reference](docs/en/take.md) or
[referencia de take en español](docs/es/take.md). New evidence: **6,704 NumPy
2.5.3 cases / 324,615 checks**, 63 Lua checks and native tests. Full regression:
**117 fixture files**. Three deliberate empty-axis hang-class rejections remain
outside parity counts. No Python runtime is used.

## LuaRay 0.99.1-dev — float32 numerical portability

Correct inverse-exponential rounding across older/newer libm versions without
changing PCG64 consumption or weakening exact reference checks. See the
[English portability record](docs/en/portability.md) and
[registro de portabilidad en español](docs/es/portability.md). All 116 native
fixture files passed on Ubuntu CI and locally on Arch with the correction.

## LuaRay 0.99.0-dev — source-derived masked assignment

`copyto` now follows weak-scalar dtype rules, literal/array mask conversion,
destination-stride traversal, live shared masks, overlap direction, leading
singleton source dimensions and conversion/error boundaries. `putmask` accepts
numeric/complex/string masks and distinguishes empty Lua values from strong
array casting. Protected writeback remains distinct from place's live values.

See [English masked-write contracts](docs/en/masked_writes.md) and
[contratos de escritura con máscara en español](docs/es/masked_writes.md).
`make memory99-test` executes the new NumPy 2.5.3 corpus. Complete NumPy parity
is not claimed; numeric byte-order descriptors remain pending.

## LuaRay 0.98.0-dev — indexed and selected writes

Native `np.put(a, indices, values, mode)` / `a:put(...)` and
`np.place(a, mask, values)` now execute through the actual ndarray engine.
They preserve C-order traversal, cyclic values, views, conversion rules and
upstream alias/error behavior. Positive indices are Lua one-based; zero is
invalid. No Python runtime is used.

Read the [English writing guide](docs/en/writing.md) or
[guía de escritura en español](docs/es/writing.md) for contracts and limits.
`make write98-test` runs the native core, Lua regressions, original NumPy 2.5.3
put/place fixtures and explicitly separated blocked byte-order cases.

The Makefile now discovers an installed CBLAS library through pkg-config,
including Arch's separate `libcblas`; it does not install dependencies.

## LuaRay 0.97.0-dev — masked writes and memory checks

New native API: `np.copyto`, `np.putmask`, `np.shares_memory`, and
`np.may_share_memory`. `copyto` takes `(destination, source, casting, where)`;
`putmask` takes `(destination, boolean_mask, values)`.

```lua
local np = require('luaray_core')
local a = np.array({1,2,3,4}, 'int32')
np.putmask(a, {true,false,true,false}, {9,8})
assert(a:get(1) == 9 and a:get(3) == 9)
```

**Release provenance:** rebuilt on top of the 0.94.0-dev source archive
because the 0.95 and 0.96 archives were not accessible in this session. The
memory APIs were reimplemented; this is not a byte-identical recovery of
those prior deliveries. Read `PROGRESS_0_97.md` for limitations and tests.

## LuaRay 0.94.0-dev — scalar DType hierarchy and Unicode

`np.issubdtype(a, b)` now checks numeric, flexible-string, boolean and temporal
scalar type hierarchy using Lua DType/class name strings. Lua scalar UTF-8
strings are now supported by `np.min_scalar_type`:

```lua
local np = require('luaray_core')
assert(np.issubdtype('int16','signedinteger'))
assert(np.issubdtype('timedelta64[ns]','integer'))
assert(not np.issubdtype('float32','integer'))
assert(np.min_scalar_type('mañana') == '<U6')
assert(np.min_scalar_type('🐈') == '<U1')
```

`make dtype94-test` executes 1,943 NumPy-derived differential comparisons.
See `PROGRESS_0_94.md` for the input contracts, evidence and limitations.

## LuaRay 0.93.0-dev — DType audit

Added `np.min_scalar_type(value)` for Lua numeric, boolean, complex scalars, existing
ndarrays and temporal scalars. Integers are classified into the smallest matching
signed/unsigned builtin type, while floats and complex values follow NumPy's
minimum scalar range rules. For example:

```lua
local np = require('luaray_core')
assert(np.min_scalar_type(255) == 'uint8')
assert(np.min_scalar_type(256) == 'uint16')
assert(np.min_scalar_type(-129) == 'int16')
assert(np.min_scalar_type(1.0) == 'float16')
assert(np.min_scalar_type(np.complex(3,4)) == 'complex64')
```

`make dtype93-test` runs the 4,557 NumPy-derived scalar checks and the
1,488 extended `astype` layout checks. Full test includes both fixtures.
See `PROGRESS_0_93.md` for supported inputs and known limitations.

## 0.92.0-dev — ndarray.astype order and copy

`np.astype(a, dtype, {copy=false, order='K', casting='unsafe'})` and
`a:astype(dtype, {copy=false, order='F'})` now support NumPy-style identity
and memory-order selection. The `K` mode preserves source stride-axis order
when allocating converted non-contiguous views. Invalid order and copy options
are rejected. The existing casting-rule argument remains supported.

The 0.92 differential fixtures contain **4,724 NumPy 2.3.5 comparisons**
across `astype` and `can_cast`; run `make dtype92-test` or `make full-test`.
See `PROGRESS_0_92.md` for scope and limitations.

## 0.91.0-dev — public DType promotion APIs

`np.promote_types("int16", "float32")` and `np.result_type(...)` now expose the
existing native DType promotion engine. The latter accepts ndarray inputs,
dtype-name strings and weak Lua numeric/bool/complex scalars; a NumPy-compatible
kind-ordered reduction avoids incorrect chained promotion for 3+ dtypes.
DType results are returned as Lua strings rather than Python objects.

```lua
local np = require('luaray_core')
assert(np.promote_types('uint8','int8') == 'int16')
assert(np.result_type('int8','uint16','float16') == 'float32')
assert(np.result_type(np.array({1},'float32'),2.5) == 'float32')
```

The new 0.91 fixture has **3,556 differential cases**. Run
`make dtype91-test` or `make full-test`. Details and limitations are in
`PROGRESS_0_91.md`.

## 0.90.0-dev — exact 64-bit Lua table bounds and Fortran-view verification

`Generator.integers()` now recognizes all-integer Lua tables and converts them
to native `int64` arrays rather than to `float64`. That preserves bounds above
`2**53`, including `math.mininteger`, and avoids silent rounding of ranges.
Mixed floating-point tables continue to use `float64` conversion. The new
Fortran/transpose/negative-stride differential suite checked the output's
values **and the next PCG64 value** against NumPy 2.3.5, including `uint64`
outputs inside Lua's signed-integer representable range.

`make random90-test` runs **5,880** executable NumPy differential cases,
11 Lua-specific regression checks and a working Lua example. The full suite
contains **104 differential fixture files**. A prior 0.89 report mentioned a
possible Fortran view placement mismatch: the expanded 0.90 tests could not
reproduce it; the old report is retained as historical evidence rather than
silently edited. Exact `uint64` bounds greater than `INT64_MAX` remain
unsupported. See `PROGRESS_0_90.md`.

## 0.89.0-dev — vectorized `Generator.integers` bounds

`Generator.integers(low, high, size, dtype, endpoint)` now accepts array-like `low` and `high` arguments (Lua tables, `ndarray`, and broadcasted shapes). Integer array values use exact integer reads rather than float64 conversion; native PCG64/bounded integer samplers remain in C. All nine native integer/bool dtypes are supported, plus scalar broadcasting, explicit shapes, endpoint and reversed views.

```lua
local np = require('luaray_core')
local rng = np.random.default_rng(42)
local values = rng:integers({{1},{10}}, {{15,20,50}}, nil, 'int16')
assert(values.shape[1] == 2 and values.shape[2] == 3)
```

`make random89-test` runs **4,782** frozen NumPy 2.3.5 comparison calls, **11** rejected-input/no-RNG-advance cases and an actual Lua example. The original 0.89 tests excluded some Fortran-transposed views and did not preserve large integer values in Lua tables. Version 0.90 addresses those cases; see `PROGRESS_0_90.md`.

## 0.88.0-dev — standard RNG output buffers

`Generator.standard_normal(size, dtype, out)` and `Generator.standard_exponential(size, dtype, method, out)` now accept writable C- or Fortran-contiguous ndarray output buffers. `out` returns the same ndarray and is filled in physical memory order. This preserves NumPy PCG64 consumption and `float32`/`float64` sampling paths.

`make random88-test` runs 1,008 NumPy differential cases, 14 pre-draw validation cases and an example. `PROGRESS_0_88.md` contains executed verification details.

## 0.87.0-dev — vectorized Zipf and hypergeometric

`Generator.zipf(a, size)` and `Generator.hypergeometric(ngood, nbad,
nsample, size)` now accept broadcastable numeric tables, ndarray parameters,
noncontiguous/transposed and negative-stride views.  The underlying C PCG64
samplers are unchanged. Hypergeometric ndarray counts must have integral or
boolean dtype; Lua numeric sequences convert to integer counts first.

```lua
local np = require('luaray_core')
local r = np.random.default_rng(87)
local z = r:zipf({{1.5}, {3}}, {2,3})
local h = r:hypergeometric({{5}, {10}}, {{20,40,60}}, 3)
print(z.dtype, h.shape[1], h.shape[2])
```

`make random87-test` executes a frozen **1,380-case** NumPy 2.3.5 oracle,
19 rejected-input checks, 20,000 statistical samples and a Lua example.
Full coverage and limits: `PROGRESS_0_87.md`.

## 0.86.0-dev — vectorized t, von Mises, triangular distributions

Three NumPy `Generator` families now broadcast Lua tables and native `ndarray`
parameters including transposed, noncontiguous and negative-stride views:
`standard_t(df, size)`, `vonmises(mu, kappa, size)` and
`triangular(left, mode, right, size)`. Scalar paths are preserved.

```lua
local np = require('luaray_core')
local rng = np.random.default_rng(86)
local t = rng:standard_t({{0.5}, {5}}, {2, 3})
local v = rng:vonmises({{0}, {1}}, {{0, 1e-6, 2}})
local x = rng:triangular({{0}, {0.2}}, {{0.5, 1, 2}}, 3)
print(t.shape[1], v.shape[2], x.dtype)
```

`make random86-test` runs a frozen **990-case** NumPy 2.3.5 reference fixture,
24 invalid-input checks with PCG64 unchanged, 30,000 empirical samples and an
executable Lua example. Full results and limitations in `PROGRESS_0_86.md`.
Upstream NumPy 2.5.3 provenance is pinned by
`NUMPY_2_5_3_RANDOM86_FILE_HASHES.sha256`.

## 0.85 — vectorized noncentral chi-square and noncentral F

`Generator.noncentral_chisquare(df, nonc, size)` and
`Generator.noncentral_f(dfnum, dfden, nonc, size)` now accept broadcastable
numeric Lua tables and `ndarray` parameters (including transposed and
reversed views). The original scalar PCG64 C samplers are reused and the
three-parameter F family has independent multidimensional broadcasting.

```lua
local np = require('luaray_core')
local rng = np.random.default_rng(85)
local a = rng:noncentral_chisquare({{0.5}, {2}}, {{0, 1, 20}})
local b = rng:noncentral_f({{0.5}, {2}}, {{4, 8, 16}}, {{0.1, 1, 20}})
print(a.shape[1], a.shape[2], b.dtype)
```

`make random85-test` runs the 648-case frozen NumPy 2.3.5 oracle and
additional regression/statistical checks. See `PROGRESS_0_85.md` for
precise coverage and remaining limitations, and
`NUMPY_2_5_3_RANDOM85_FILE_HASHES.sha256` for upstream source provenance.

# LuaRay — NumPy ported toward native Lua

**LuaRay** is an active **source port of NumPy to native Lua**. It is not a NumPy-inspired replacement, Python bridge, CPython embedding layer, subprocess wrapper, RPC shim, or FFI call into Python.

Current snapshot: **0.87.0-dev**.

## 0.84.0-dev — vectorized binomial families

`rng:binomial(n, p, size)` and `rng:negative_binomial(n, p, size)` now broadcast `n` and `p` from Lua tables and ndarrays, preserving native PCG64 sequences. Both return `int64`. Reuses NumPy 2.5.3-compatible C algorithms for binomial inversion/BTPE and Gamma-Poisson. Runs in Lua without Python. `make random84-test` executes 750 fixed NumPy 2.3.5 comparison cases, 25 negative tests, 40,000 empirical samples and an executable example. `make full-test` runs 98 accumulated differential suites. See `PROGRESS_0_84.md` for guardrails and limits.

## 0.83.0-dev — vector geometric and Poisson sampling

`rng:geometric(p, size=nil)` and `rng:poisson(lam, size=nil)` now accept
parameter Lua tables and native ndarrays (including strided views), broadcasting
shapes from the right and supporting explicit output shapes. Sample arrays use
`int64`; scalar calls retain the established native algorithms and PCG64 behavior.

```lua
local np=require('luaray_core')
local rng=np.random.default_rng(83)
local g=rng:geometric({{.2},{.8}}, {2,3})
local p=rng:poisson({1,5,20}, {2,3})
assert(g.dtype=='int64' and p.dtype=='int64')
```

`make random83-test` runs 1,296 frozen NumPy 2.3.5 comparisons, 16
invalid-input/no-draw checks, 40,000 empirical samples and an executable Lua
example. The sampler C code is unchanged; only its parameter broadcasting
adapter was extended. See `PROGRESS_0_83.md`.

## 0.82.0-dev — Wald and logseries parameter broadcasting

`rng:wald(mean, scale, size=nil)` and `rng:logseries(p, size=nil)` now accept
multidimensional Lua tables and native ndarrays (including float32 and int64
parameter arrays, transposed views and negative strides). Shapes broadcast
from the right, with optional explicit output size. Results are true `float64`
and `int64` ndarrays respectively. Scalar calls retain their original native
samplers and PCG64 behavior.

```lua
local np=require('luaray_core')
local r=np.random.default_rng(42)
local w=r:wald({{1},{2}}, {{.5,2,4}})
local l=r:logseries({.1,.5,.9}, {2,3})
assert(w.shape[1]==2 and w.shape[2]==3 and w.dtype=='float64')
assert(l.shape[1]==2 and l.shape[2]==3 and l.dtype=='int64')
```

`make random82-test` runs 483 frozen NumPy 2.3.5 differential cases,
16 rejected-without-draw validations, 40,000 statistical smoke samples,
and a standalone Lua example. `make full-test` runs these plus 96 total
differential fixture files and native/Lua regressions. Results and limits
are detailed in `PROGRESS_0_82.md`.

## 0.81.0-dev — `standard_gamma` special values and output buffers

`rng:standard_gamma(shape, size=nil, dtype="float64", out=nil)` now supports
`NaN` and positive-infinite concentration parameters with NumPy-compatible
PCG64 advancement, and writes directly into a writable, C-contiguous output
`ndarray` of the requested dtype and matching shape. `out` can provide the
implicit output shape; incompatible explicit `size`, dtype and broadcasting
arguments are rejected before drawing any random values.

```lua
local np = require('luaray_core')
local rng = np.random.default_rng(42)
local out = np.zeros({2,3}, 'float32')
assert(rawequal(rng:standard_gamma({{0.5},{2}}, nil, 'float32', out), out))
```

`make random81-test` executes 1,500 independently generated NumPy 2.3.5
comparisons, 12 no-draw validation checks and a runnable Lua example. The
historical 0.58 and 0.80 tests have been updated where they previously treated
NaN/+Inf as invalid. `make full-test` passed 95 differential fixture files.
See `PROGRESS_0_81.md` for limitations and detailed checks.

## 0.80.0-dev — `Generator.standard_gamma` parameter broadcasting

`rng:standard_gamma(shape, size=nil, dtype="float64")` now accepts multidimensional
Lua tables and native ndarrays with C-order broadcasting, including float32,
float64, int64, transposed views and negative strides. Both output dtypes use
NumPy-compatible **independent** sampling (float32 is not a float64 cast).

```lua
local np = require('luaray_core')
local r = np.random.default_rng(42)
local x = r:standard_gamma({{0.5}, {2.0}}, {2, 3}, 'float32')
assert(x.shape[1]==2 and x.shape[2]==3 and x.dtype=='float32')
```

`make random80-test` verifies 1,000 offline NumPy 2.3.5 differential fixtures,
invalid-input regressions, an empirical mean/variance check (120,000 samples)
and a runnable example. `make full-test` runs this alongside 94 differential
fixture files. As of 0.81, the previously missing `out` and nonfinite-shape cases are
implemented. Python keyword syntax is not part of the Lua API.
See `PROGRESS_0_80.md` for the historical 0.80 scope.

## 0.79.0-dev — Rejection-sampling distributions with broadcasting

`Generator.gamma`, `beta`, `chisquare` and `f` now accept numeric arrays,
Lua tables, strided parameter views and compatible multidimensional sizes.
The native C sampling algorithms preserve PCG64 draw order, including the
small-alpha Beta branch. Test with `make random79-test`; see
`PROGRESS_0_79.md` for detailed coverage and nonfinite-input limitations.

```lua
local np = require('luaray_core')
local r = np.random.default_rng(42)
local gamma = r:gamma({{0.5}, {2.0}}, {{0.2, 1.0, 2.0}})
assert(gamma.shape[1] == 2 and gamma.shape[2] == 3)
```

## 0.78.0-dev — Eight more vectorized random distributions

Native parameter broadcasting now covers `lognormal`, `laplace`, `gumbel`,
`logistic`, `rayleigh`, `weibull`, `pareto` and `power`. Arrays and Lua tables
can broadcast over different dimensions, including transposed or reverse-stride
views. These paths reuse NumPy-compatible native C algorithms without Python.

```lua
local np = require('luaray_core')
local rng = np.random.default_rng(42)
local samples = rng:lognormal({{0}, {1}}, {{0.2, 0.5, 1.0}})
assert(samples.shape[1] == 2 and samples.shape[2] == 3)
```

Run `make random78-test` for the 2,000 randomized NumPy comparisons, 114
extreme-value comparisons, Lua regression and runnable example. Full suite:
`make full-test`. See `PROGRESS_0_78.md` for supported cases and caveats.

## 0.77.0-dev — Generator parameter broadcasting

`rng:normal(loc, scale, size)`, `rng:uniform(low, high, size)`, and
`rng:exponential(scale, size)` now accept broadcastable numeric parameters
as Lua tables or ndarrays (including transposed and reversed views), not only
scalars. `size=nil` infers the broadcast shape. Explicit output dimensions
must be compatible. Draw values and next PCG64 state were verified in
**1,560 independent NumPy 2.3.5 cases**, plus validation and examples.

```lua
local np = require('luaray_core')
local g = np.random.default_rng(42)
local samples = g:normal({{0},{10}}, {{1,2,3}}) -- shape {2,3}
```

See `PROGRESS_0_77.md` and `make random77-test`.

## 0.76.0-dev — Generator.bytes and random(dtype, out)

The PCG64 generator now supports binary-safe `rng:bytes(length)` and
`rng:random(size, dtype, out)`, including a true float32 uint32 draw stream
and writing directly into a matching existing ndarray. Both reproduce the
NumPy 2.5.3 PCG64 consumption rules, including zero-length byte requests.
See `PROGRESS_0_76.md` and `make random76-test`.

## 0.75.0-dev — Generator.multivariate_normal

Native float64 multivariate Gaussian samples with NumPy-style `svd`, `eigh` and `cholesky` methods, positional `size`, covariance validation, and PCG64 draw-state compatibility. See `PROGRESS_0_75.md` and `make mvn75-test`.

## 0.74.0-dev — Generator.choice

New native `Generator.choice(a, size=nil, replace=true, p=nil, axis=1, shuffle=true)` follows NumPy 2.5.3's selection algorithms (Lua axes are 1-based):

- Unweighted **with replacement**: NumPy PCG64 bounded integers.
- Unweighted **without replacement**: Floyd's sampling with an open-addressed hash table and bounded64 draws, or NumPy's tail Fisher–Yates path for large populations. `shuffle=false` preserves the NumPy draw order.
- Weighted **with replacement**: cumulative probabilities, normalized cumulative distribution, binary `searchsorted(..., side='right')`, double-precision uniform draws.
- Weighted **without replacement**: repeated unique weighted draws, reweighting after each batch (not naive roulette sampling).
- Population may be a non-negative Lua integer, 0-D integer ndarray, a Lua list or an ndarray. `size` supports scalar count, a table of dimensions, an empty shape table, or `nil`. Multidimensional input uses `axis`; negative axes are supported. The result preserves the population dtype, including native fixed-width strings and booleans.
- Probabilities `p` accept Lua numeric tables or 1-D numeric ndarrays with length and normalization validation. Optional flags are positional: no Python keyword arguments are assumed.

```lua
local np = require('luaray_core')
local r = np.random.default_rng(42)
local weighted = r:choice({"red", "green", "blue"}, 6, true, {0.2,0.3,0.5})
local no_replacement = r:choice(10, 4, false)
local columns = r:choice(np.arange(12,'int64'):reshape({3,4}), {2,2}, false, nil, 2)
```

`make choice74-test` executes the Lua regression and example plus 4,650 frozen independent NumPy 2.3.5 differential cases; `make full-test` includes 88 differential files. NumPy is only an offline oracle: Python is **not** called by the module. Source target remains NumPy 2.5.3. See `PROGRESS_0_74.md` for the choice limitations.

`make mvn75-test` runs the native C factor regression, a 30,000-sample empirical covariance check, 1,020 frozen NumPy 2.3.5 differential comparisons (PCG64 state, dtype, shape and values), and the Lua example. `make full-test` includes 89 differential fixtures. Source target is NumPy 2.5.3; see `PROGRESS_0_75.md` for numerical tolerance and known limitations.

## 0.73.0-dev — Generator.permuted

New native `Generator.permuted(x, axis=nil, out=nil)` based on NumPy 2.5.3:

- **`axis=nil`** shuffles all elements as a flattened array in source storage
  traversal order (`order='K'`).  A *new* ndarray is returned by default.
- **`axis=1`** (Lua) shuffles values independently along each first-axis
  fiber.  Other 1-based positive and negative axes work too; unlike
  `shuffle`, the remaining fibers are permuted **independently**.
- **`out`** can be a writable ndarray of the same shape and safely castable
  dtype.  The returned value is the same `out` object.  Aliasing and
  overlapping source/output views are protected by a source snapshot.
- Accepts dense Lua list inputs via native ndarray conversion. Handles
  C/F-order arrays, transposes, negative strides, zero-length dimensions,
  builtin numeric/complex/boolean, fixed-width strings and datetime dtypes.

```lua
local np = require('luaray_core')
local rng = np.random.default_rng(42)
local original = np.arange(12, 'int64'):reshape({3,4})
local rows_independently = rng:permuted(original, 2)
local flattened = rng:permuted(original)
local out = np.zeros({3,4}, 'int64')
assert(rawequal(rng:permuted(original, 2, out), out))
```

**Executed verification:** 11,244 generated NumPy 2.3.5 cases plus 120
extra dtype/PCG64 cases; `make permuted73-test`, full native/Lua regression,
86 previous differential files, and the runnable example all passed.
The algorithms are taken from the bundled NumPy 2.5.3 source; runtime is
native Lua/C, with no Python interpreter or NumPy shared library.

**Boundary:** out-of-place copies of unusual non-C/F contiguous views may
not preserve the same physical memory layout as NumPy's `copy(order='K')`;
contents and tested PCG64 state match. Object/reference dtypes and keyword
arguments are not available in the Lua interface. The full native codebase
was not sanitizer-validated in this release.

## 0.72.0-dev — Generator permutation and shuffle

New NumPy 2.5.3 native algorithms:

- `rng:permutation(n)` creates an `int64` ndarray with a random permutation of
  the integers `0` through `n-1` (NumPy's zero-based values).
- `rng:permutation(a, axis=1)` returns a shuffled copy of an ndarray or Lua
  sequence, preserving dtype and leaving input unchanged. Lua axis numbering
  is **1-based** (`axis=2` corresponds to NumPy `axis=1`). An integer input
  ignores `axis`, as in NumPy.
- `rng:shuffle(a, axis=1)` changes an ndarray or Lua list **in place** and
  returns `nil`; arbitrary strided ndarray views, multidimensional row/column
  permutations, and fixed-width Unicode dtypes are supported.

The core uses NumPy's `random_interval` bitmasked rejection algorithm,
including its 32-bit PCG64 cache, rather than `Generator.integers()`' Lemire
bounded sampler. For `permutation` of higher-dimensional empty arrays, the
index-array shuffling behavior and RNG state consumption are preserved.

```lua
local np = require("luaray_core")
local rng = np.random.default_rng(42)
local ids = rng:permutation(10)
local a = np.arange(12, "int64"):reshape({3,4})
rng:shuffle(a, 2)           -- permute columns in place
local b = rng:permutation(a,1)  -- return independently permuted rows
```

**Executed validation:** `make shuffle72-test` passed 2,948 NumPy 2.3.5
cases / 74,552 Lua comparisons, 60 native C permutation fixtures, 20
high-range 64-bit mask tests, and the runnable example. `make full-test`
passed 85/85 frozen differential fixtures. See `PROGRESS_0_72.md`.

**Limitations:** `shuffle` on Lua tables targets dense 1D sequences; the
ndarray API supports native LuaRay dtypes, not NumPy object/reference dtypes.
Strided views with overlapping memory locations require further work. NumPy
2.3.5 was used as the executable oracle; 2.5.3's original C/Cython source is
the implementation reference. No Python runtime dependency.

## 0.71.0-dev — Student's t and von Mises distributions

Two additional `numpy.random.Generator` distributions are implemented in
native C, based on NumPy 2.5.3 algorithms:

- `rng:standard_t(df, size=nil)` samples Student's t using a normal draw
  followed by a Gamma draw; `df > 0` (NaN and infinity reproduce the tested
  NumPy exceptional behavior).
- `rng:vonmises(mu, kappa, size=nil)` samples circular von Mises angles,
  including low-concentration uniform draws, Best-Fisher rejection and
  wrapped-normal fallback above `kappa=1e6`.

Without `size`, both return a Lua number; with `size`, they return a float64
ndarray. `size={}` gives a zero-dimensional ndarray and zero dimensions are
supported. Only scalar distribution parameters are currently supported; no
NumPy parameter broadcasting. PCG64 stream and values are exactly matched to
an independently executed NumPy 2.3.5 fixture on the test host.

```lua
local np = require("luaray_core")
local rng = np.random.default_rng(42)
local student = rng:standard_t(5, {2,3})
local circular = rng:vonmises(0.8, 4, {2,3})
print(student:get(1,1), circular:get(1,1))
```

**Verification:** `make distributions71-test` and `make full-test`, including
**84/84** differential fixture files; the new independent fixture validates
**16,074 exact comparisons** in **2,538 test cases** (data, shapes, dtype,
PCG64 post-state); native statistical checks of 100,000 samples per sampler;
Clang AddressSanitizer/UndefinedBehaviorSanitizer for modified sampler plus
its new native C tests. NumPy is required only when regenerating the fixture,
not to build or execute LuaRay.

## 0.70.0-dev — Wald and logarithmic-series distributions

Two NumPy 2.5.3 `Generator` distributions are now implemented as native C
samplers behind Lua methods, with exact PCG64 state accounting:

- `rng:wald(mean, scale, size=nil)`: inverse Gaussian / Wald random samples,
  returned as Lua number without `size`, otherwise a `float64` ndarray.
  Both scalar arguments must be positive and not NaN; NumPy's infinity
  parameters are accepted, including their platform-dependent NaN results.
- `rng:logseries(p, size=nil)`: Fisher logarithmic-series samples as a Lua
  integer or `int64` ndarray. The probability is a scalar in `[0,1)`;
  `p=0` returns 1 but still consumes one uniform, as NumPy does.
- Both support scalar, zero-dimensional, empty, and multidimensional output
  shapes. **Array-valued/broadcasted parameters are not yet supported.**

```lua
local np = require("luaray_core")
local rng = np.random.default_rng(42)
local w = rng:wald(2, 5, {2, 3})
local s = rng:logseries(0.8, {2, 3})
assert(w.dtype == "float64" and s.dtype == "int64")
```

**Executed verification:** 10,144 strict NumPy 2.3.5 comparisons cover outputs,
shapes, dtypes, mixed-generator calls, invalid parameters and next PCG64
words, plus native C and Lua regression tests and a runnable example.
NumPy 2.5.3's `random_wald` and `random_logseries` in `distributions.c`
are the source algorithms; pin hashes and licensing in `UPSTREAM.md`.
LuaRay itself does not require Python/NumPy at build time or runtime.

## 0.69.0-dev — Dirichlet distribution

Native `np.random.default_rng(seed):dirichlet(alpha, size=nil)` generates
float64 random simplex vectors, matching `Generator.dirichlet` in the
supplied **NumPy 2.5.3** source. `alpha` is a one-dimensional numeric Lua
sequence or ndarray; `size` adds leading sample dimensions. Without
`size`, the result is a 1-D ndarray. The output shape is always
`{*size, #alpha}`. Empty category vectors, all-zero concentrations and
zero-size dimensions are supported.

The exact upstream dual-algorithm choice is implemented in C:

- `max(alpha) < 0.1`: right-to-left cumulative concentration followed by
  Beta stick-breaking; protects low-concentration samples from Gamma
  underflow without advancing RNG state for all-zero `alpha`.
- Otherwise: sequential standard-Gamma draws followed by vector
  normalization, reproducing PCG64 word consumption.

```lua
local np = require("luaray_core")
local rng = np.random.default_rng(42)
local samples = rng:dirichlet({1.5, 2.0, 3.0}, {2, 3})
assert(samples.dtype == "float64")
assert(samples.shape[1] == 2 and samples.shape[2] == 3 and samples.shape[3] == 3)
```

**Verification executed:** `make full-test` passed all **82/82** checked-in
NumPy differential suites (81 previous); the new independent **NumPy 2.3.5**
oracle passed **9,582/9,582 exact comparisons** (outputs, shape, dtype,
PCG64 post-state and validation). Native C regression, Lua regression and
literal example passed. The changed native sampler and random core passed
a directed Clang ASan/UBSan native regression with leak detection; this
is not whole-project sanitizer coverage. NumPy/Python are only used to
regenerate development fixtures, never to compile or run LuaRay.

**Current limits:** concentration values must be finite, nonnegative,
1-D, and at most one million categories; some nonfinite values accepted
by upstream are deliberately rejected. Output can contain zeros or NaNs
for NumPy-defined degenerate cases. Floating-point bit equality outside
tested math libraries/platforms is not guaranteed. The NumPy 2.5.3
algorithm and source hash pins are described in `UPSTREAM.md` and
`NUMPY_2_5_3_DIRICHLET_FILE_HASHES.sha256`.

## 0.68.0-dev — multinomial distribution

- `rng:multinomial(n, pvals, size=nil)` samples native `int64` vectors with
  `n` trials over the categories in `pvals`. It uses sequential draws from
  the pre-existing NumPy-compatible binomial sampler in the same order as
  upstream `random_multinomial` (NumPy 2.5.3).
- `pvals` accepts a 1-D numeric Lua table or ndarray. The **last category
  receives all remaining trials**; NumPy does not require the probabilities
  to total exactly 1. We validate that individual probabilities are finite
  and in `[0,1]`, and `sum(pvals[:-1]) <= 1 + 1e-12`.
- Omitted size returns an array with shape `{#pvals}`; explicit size adds
  leading sample dimensions. `n` is a scalar Lua integer in `[0,1e12]`;
  broadcasted `n` and multidimensional/broadcasted `pvals` are not yet
  implemented, and some NumPy implicit integer casts are deliberately rejected.
- **58,790/58,790 exact fixture comparisons** against NumPy 2.3.5: values,
  shape, dtype, next raw PCG64 word, interleaved generation and validation.
  `make full-test` passes **81/81 differential suites** including 80 previous.
  `make distributions68-test` runs native C, Lua regression, generated fixture
  and literally executed example. NumPy/Python are only needed to regenerate
  the reference fixture; not at runtime.
- Directed ASan/UBSan with leak checks passed on the modified random core,
  multinomial sampler, Lua adapter and 0.68 tests. The other objects were
  not instrumented; this is not whole-project sanitizer validation.

```lua
local np = require("luaray_core")
local rng = np.random.default_rng(42)
local outcomes = rng:multinomial(20, {0.2, 0.3, 0.5}, {2, 3})
```

## 0.66 — NumPy-compatible hypergeometric distribution

- `rng:hypergeometric(ngood, nbad, nsample, size=nil)` returns a scalar
  integer or an independent `int64` ndarray, using **native C** with NumPy's
  direct small-sample algorithm and HRUA ratio-of-uniforms rejection sampler.
- The direct path implements NumPy's **masked random_interval**, consuming
  `next_uint32` and preserving PCG64's 32-bit cache. It must not be replaced
  with the Lemire bounded generator used by `integers()`.
- `ngood` and `nbad` are scalar Lua integers in `[0, 10^9)`; `nsample` is a
  scalar nonnegative integer at most `ngood + nbad`. No parameter broadcasting.
  These are intentionally narrower than NumPy's array-valued input API.
- **63,544/63,544 exact comparisons** from independent NumPy 2.3.5 oracles
  verified output, shapes, DTypes, post-sample PCG64 words, interleaved calls,
  degenerate populations, algorithm boundary conditions, and invalid inputs.
- `make full-test` passed **79/79** checked-in differential fixtures.
  Native C regression and the literal executable Lua example also passed.
- Directed AddressSanitizer + UndefinedBehaviorSanitizer with leak checks
  passed for the changed `ln_random.c`, `ln_hypergeometric.c`, `lua_module.c`
  and the native tests; other objects were not instrumented.
- NumPy 2.5.3 supplied the source algorithm and logfactorial lookup table;
  Python/NumPy is needed **only to regenerate reference fixtures**, not to
  compile or run LuaRay. Native code covered by NumPy's BSD-3-Clause license
  is attributed, and upstream SHA-256 values are pinned separately.

## 0.67.0-dev — multivariate hypergeometric distribution

- `rng:multivariate_hypergeometric(colors, nsample, size=nil, method="marginals")`
  samples vectors of `int64` counts without replacement. `colors` is a
  dense one-dimensional Lua table or an integer `ndarray`; `nsample` is
  a nonnegative scalar integer. An omitted `size` yields a 1-D ndarray,
  while explicit `size` adds sampling dimensions before the color axis.
- Supports both NumPy 2.5.3 sampling algorithms: **marginals** (sequential
  univariate hypergeometric draws, with complement optimization) and
  **count** (partial Fisher–Yates shuffle of a persistent population buffer).
  The `count` buffer is deliberately reused across output samples, preserving
  NumPy's exact PCG64 state/output behavior.
- **41,492/41,492 exact differential checks** against NumPy 2.3.5, including
  both algorithms, dimensions, outputs, integer DTypes, multiple seeds, empty
  inputs, edge cases, state transition checks and invalid-argument handling.
  NumPy is required only to regenerate tests, not to execute LuaRay.
- `make distributions67-test` runs the native C regression, Lua regression,
  differential fixture and an executable example that has been run literally.
  `make full-test` passes **80/80** checked-in differential fixtures.
- Directed ASan/UBSan with leak checking passed for the PCG64 sampler,
  hypergeometric core, new multivariate sampler and Lua adapter. Other
  objects were linked without sanitizers; this is not a whole-project check.

**Deliberate limits:** `marginals` requires `sum(colors) < 10^9` (as NumPy).
`count` currently caps `sum(colors)` at 2,000,000 to limit temporary memory
(NumPy allows larger values). `colors` may contain at most 1,000,000 entries;
parameter broadcasting is not supported. Only integral 1-D arrays and integer
Lua tables are accepted. Exact PCG64 reproducibility was checked on this
platform, not asserted across every compiler/libm combination.

```lua
local np = require('luaray_core')
local rng = np.random.default_rng(42)
local samples = rng:multivariate_hypergeometric({12,8,5}, 10, {2,3})
local counted = rng:multivariate_hypergeometric({12,8,5}, 10, 4, 'count')
```

## Upstream source of truth

Primary implementation source: the exact supplied official `numpy/numpy` `main` source archive. No network checkout is required for this snapshot.

Pinned upstream tree:

`286e698f1dcf601648b165f48485ceaeec9c6231` (`main`, 2026-10-06)

The original pinned main tree identifies itself as NumPy `2.6.0.dev0` in `pyproject.toml`.
For the **0.30 joining, 0.31 splitting, 0.32 axis/view manipulation, 0.33 broadcasting, and 0.34 repetition implementations**, the independently supplied NumPy **2.5.3** release archive was also audited. `NUMPY_2_5_3_JOIN_FILE_HASHES.sha256` pins six joining sources/tests and `NUMPY_2_5_3_SPLIT_FILE_HASHES.sha256` pins three splitting sources/tests, while `NUMPY_2_5_3_AXIS_FILE_HASHES.sha256` pins ten axis-related sources/tests from that exact archive; these do not replace the original main-tree pin.

`UPSTREAM.md` records the NumPy implementation paths inspected for the port. `UPSTREAM_FILE_HASHES.sha256` pins the exact contents of those source/test files. GitHub ZIP archives omit Git submodule payloads; submodule-backed components such as Highway/SIMD are therefore not claimed as present yet.

## Native core currently implemented

- native `nansum`, `nanprod`, `nanmean`, `nanvar` and `nanstd` use
  the existing C reduction kernels with a separate, contiguous NaN-exclusion
  mask. A user `where` boolean mask is combined with NaN exclusion without
  modifying the input. Supports one-based scalar/tuple axes, `keepdims`,
  floating/complex/boolean/integer inputs, noncontiguous and negative-stride
  views, dtype options where supported by the underlying reduction, and
  alias-safe `out`. Sum/product retain `initial`; variance/std support `ddof`
  and `correction`. Inputs with no selected elements produce the NumPy
  reduction identities or NaNs. As with the original reduction kernel, full
  NumPy intermediate rounding fidelity and integer calculation DTypes for
  variance are not yet implemented, and NumPy warnings are not emitted;

## 0.55 — lognormal, standard_cauchy and laplace

Added three NumPy-compatible **PCG64 distributions in native C**:

- `rng:lognormal(mean=0, sigma=1, size=nil)` uses `exp(mean + sigma * standard_normal)`.
- `rng:standard_cauchy(size=nil)` uses the ratio of two consecutive standard normal draws.
- `rng:laplace(loc=0, scale=1, size=nil)` uses the same piecewise inverse-transform and zero rejection as NumPy.

All use NumPy `float64`, support scalar results, integers and Lua shape tables,
including empty and zero-dimensional arrays; size omitted returns a Lua number.
The `mean`, `sigma`, `loc` and `scale` inputs are **scalar only**; negative or NaN
scale is rejected before consuming RNG state. Sample arrays are independent
native C allocations. Exactly the same PCG64 stream is consumed as NumPy for
the tested parameters and seeds; no Python dependency exists at runtime.

The literal example is `examples/random_distributions55.lua` and is invoked
by `make distributions55-test`. The differential fixture contains **14,772
exact comparisons** generated independently from executable NumPy 2.3.5,
including eight seeds, mixed samplers and checks of subsequent PCG64 state.
`make full-test` passes **68/68 checked-in differential files**, including
all prior 67. Directed ASan/UBSan and leak checking passed, with only
`ln_random.c`, `lua_module.c` and the native new test instrumented.

Source: NumPy **2.5.3** `numpy/random/src/distributions/distributions.c`
and `_generator.pyx`; both pinned in
`NUMPY_2_5_3_DISTRIBUTIONS55_FILE_HASHES.sha256`.

**Limitations:** No vectorized parameter broadcasting. Exact numerical results
were verified on this host and are not guaranteed bit-identical across all
platform/libm implementations.

## 0.54 — reproducible exponential distributions

`rng:standard_exponential(size, dtype, method)` implements both NumPy's
256-segment exponential Ziggurat (`method='zig'`, default) and inverse-CDF
(`method='inv'`) sampling in native C. The independent `float32` and
`float64` paths reproduce NumPy's PCG64 32/64-bit consumption.
`rng:exponential(scale, size)` implements NumPy's double-precision scaled
exponential sampler using a nonnegative scalar scale (defaults to 1).
Omitting `size` returns a Lua number; an integer or shape table, including
`{}` for a scalar ndarray and empty dimensions, returns an ndarray.

```lua
local np = require('luaray_core')
local rng = np.random.default_rng(42)
local waits = rng:standard_exponential({2, 3})
local fast = rng:standard_exponential(4, 'float32')
local inverse = rng:standard_exponential(4, 'float64', 'inv')
local minutes = rng:exponential(2.5, {2, 3})
```

A *separate executed example* lives in `examples/random_exponential_054.lua`.
`make exponential-test` runs a Lua regression and **17,376 exact**
NumPy 2.3.5 oracle comparisons for eight seeds, both methods, both dtypes,
shapes (including empty/0D), long Ziggurat streams, scaled exponential,
rejected arguments, and interleaved calls to existing samplers.
The full suite passes **67/67 differential fixture files**.
NumPy 2.5.3 code is the development source reference; NumPy 2.3.5
is the independently executed oracle. These algorithms require no Python
at LuaRay runtime. The existing NumPy BSD-3-Clause constant tables already
contain the exponential values; their original source is recorded in
`NUMPY_2_5_3_EXPONENTIAL_FILE_HASHES.sha256`.

**Limitations:** `exponential` accepts only a scalar scale, not vectorized
parameter arrays. The optional `out=` parameter of NumPy's
`standard_exponential` is not yet implemented. Results are exact on the
tested environment; cross-platform identical transcendental rounding is
not promised. The Lua API uses positional arguments instead of Python
keyword arguments.

## 0.53 — PCG64 Ziggurat normal distributions

`rng:standard_normal(size, dtype)` now reproduces NumPy's separate **float64**
and **float32** Ziggurat algorithms. `dtype` defaults to `float64` and supports
`float32`; the float32 path uses NumPy's 32-bit stream consumption, not a
rounded double sample. `rng:normal(loc, scale, size)` uses scalar location and
nonnegative scalar scale (defaults 0 and 1) to generate double-precision
normally distributed results. With `size` absent, the result is a Lua number;
with an integer or shape table, it is a native ndarray, including zero-length
and zero-dimensional shapes (`size={}`).

```lua
local np = require('luaray_core')
local rng = np.random.default_rng(42)
local z = rng:standard_normal({2, 3})
local single_precision = rng:standard_normal(8, 'float32')
local measurements = rng:normal(100, 15, {2, 3})
```

All randomness is generated locally in C; **no Python dependency at runtime**.
The source matches NumPy's 256-table Ziggurat logic, with NumPy BSD-3-Clause
licensed tables shipped in `src/third_party/numpy_ziggurat_constants.h`.
`THIRD_PARTY_NUMPY_LICENSE.txt` retains upstream license terms and
`NUMPY_2_5_3_NORMAL_FILE_HASHES.sha256` pins the original source files.

The `tests/normal_differential_generated.lua` fixture compares **11,768
exact values, DTypes, shapes and subsequent PCG64 raw states** against
executable NumPy 2.3.5 across eight seeds, including long sequences, rare
rejection paths and mixed use of float32, float64 and integer sampling.
`make normal-test` runs the native and Lua regressions plus that fixture;
`make full-test` runs all **66** differential fixtures. The fixture generator
requires NumPy only if expected outputs are regenerated.

**Limitations:** `normal` accepts only scalar `loc` and `scale` (not ndarray
parameters or broadcasting). `standard_normal` currently supports only
float32 and float64. Lua's optional `size` and `dtype` are positional; keyword
arguments from Python are not part of the Lua API. Cross-libm bit-for-bit
identity is not guaranteed across every OS/compiler/CPU despite exact tests
in this environment. This is not a cryptographically secure generator.

## 0.52 — native `Generator.integers` (exact discrete-uniform sampling)

`rng:integers(low [, high [, size [, dtype [, endpoint]]]])` now samples
bounded integer and boolean DTypes with the same PCG64 input consumption and
Lemire unbiased rejection algorithm as NumPy 2.3.5 for the supported scalar
bounds. The default `dtype` is `int64`; `dtype` may be `int8`, `uint8`,
`int16`, `uint16`, `int32`, `uint32`, `int64`, `uint64` or `bool`. It returns a
Lua integer (or boolean) when `size` is omitted, or a native `ndarray` for a
size integer or table shape. `endpoint=true` makes the upper bound inclusive;
with no `high`, the interval starts at zero. Zero-length arrays consume no
random bits. NumPy-compatible 32-bit half-word caching and packed 8/16-bit
(and bool) buffering preserve exact sequences when generating arrays of
small DTypes. The 8/16/boolean chunk buffers reset for each `integers` call;
PCG64's 32-bit half-word cache persists between calls and is invalidated by
`advance`/`reseed` as in NumPy.

```lua
local np = require('luaray_core')
local rng = np.random.default_rng(42)
local samples = rng:integers(0, 10, {3,4}, 'int32')
local flags = rng:integers(0, 2, 8, 'bool')
local inclusive = rng:integers(-5, 5, 20, 'int64', true)
```

**Limits:** This Lua-native interface currently accepts only scalar bounds
represented exactly by signed Lua 64-bit integers, not vectorized bounds or
`uint64` endpoints above the signed Lua range. There is no `out` parameter,
matching NumPy's `Generator.integers` signature. `dtype`/`endpoint` are
positional rather than Python keyword arguments. `random`, `uniform` and
`integers` are *not* cryptographically secure. No Python runtime required.

The checked-in oracle `tests/integers_differential_generated.lua` has
**5,250 exact value, dtype and shape comparisons** against installed NumPy
2.3.5, across five seeds, eight integer/one boolean DType, exclusive/inclusive
endpoints, scalar/vector/multidimensional sizes and 32/64-bit-sized spans.
`make integers-test` runs the regression and differential suites; `make
full-test` now executes **65** different checked-in differential fixtures.
`make oracle-test` can regenerate the additional integers fixture using NumPy
on the developer's machine. NumPy 2.5.3 source references are pinned in
`NUMPY_2_5_3_INTEGERS_FILE_HASHES.sha256`.

## 0.51 native PCG64 and the first Generator API

`np.random.default_rng(seed)` now creates an independent native C-backed
Generator using the **PCG64** bit generator and the **NumPy SeedSequence
(pool_size=4)** algorithm. For **nonnegative scalar integer seeds that fit a
signed Lua 64-bit integer**, the generated PCG64 uint64 stream and the
`float64` values returned by `random()` match NumPy 2.3.5 **exactly**. NumPy
2.5.3's random source archive is the implementation reference (pinned source
checksums in `NUMPY_2_5_3_RANDOM_FILE_HASHES.sha256`). This is not a bridge to
Python, and the generator never calls Python at runtime.

```lua
local np = require('luaray_core')
local rng = np.random.default_rng(42)
print(rng:random())            -- 0.7739560485559633
local values = rng:random({2,3}) -- independent float64 ndarray, shape 2x3
local scaled = rng:uniform(-5,5,{2,3})
local raw = rng:raw_hex()       -- next unsigned 64-bit value as 16 hex digits
rng:reseed(42)                  -- reset stream
rng:advance(100)               -- skip 100 64-bit PCG64 draws
```

`random(size)` supports no size (Lua number), an integer length, or a table of
shape dimensions; an empty shape table creates a zero-dimensional ndarray.
`uniform(low, high, size)` supports finite scalar bounds and those same sizes.
An omitted seed is read from the operating system's `/dev/urandom` (not a
predictable clock seed). Each Generator owns its state; there is no global
mutable RNG. `raw_hex` exposes all 64 raw bits without losing precision at
the Lua-number boundary. `advance` and `reseed` are LuaRay conveniences.

**Not implemented in the 0.51 historical release:** the NumPy `SeedSequence` class, entropy arrays,
spawn keys, 64-bit seeds above Lua's signed integer range, Python-style
`BitGenerator.state`, `integers`, `standard_normal`, other probability
distributions, `float32` output and vector-valued uniform bounds. The
prototype requires a compiler supporting unsigned 128-bit integers (GCC or
Clang on modern Omarchy/Linux) and `/dev/urandom` for omitted seeds. `random`
and `uniform` are not cryptographically secure. These limitations are
intentional rather than silently pretending full NumPy Generator coverage.

`make full-test` now runs **64** frozen differential suites (the previous 63
plus **1,080 exact new seed/PCG64/float64/shape/uniform comparisons**) and
native/regression random tests. `make oracle-test` regenerates the additional
random fixture with installed NumPy for development; the shipped
`make full-test` never needs NumPy or Python. Directed ASan/UBSan testing
instruments the new core, Lua adapter and random fixtures; other numerical
modules are not instrumented in this pass.

## 0.50 weighted averages

`average` is now a native C-backed reduction. Examples:

```lua
local np = require("luaray_core")
local x = np.array({{1,2,3}, {4,5,6}}, "float64")
local w = np.array({1,2,3}, "float64")
local avg, sumw = np.average(x, {axis=2, weights=w, returned=true})
-- avg: [2.3333333333, 5.3333333333]; sumw: [6, 6]
```

`axis` follows LuaRay's **1-based axes** (negative axes and lists supported),
`keepdims` is supported, and `weights` may be an ndarray or numeric Lua
sequence. Weights must have the same shape as the data, or be one-dimensional
and match a single selected axis; scalar weights with `axis={}` are allowed.
The result dtype follows NumPy's numeric promotion rules (integer/bool data
promote to at least float64). `returned=true` produces **two Lua return
values**, rather than Python's tuple. Result and sum-of-weights have matching
shape and dtype. All calculations happen in C; Python is used only to
regenerate the optional comparative tests.

The 0.50 differential fixture checks **1,500 cases** against executable NumPy
2.3.5 (727 valid computations and 773 expected rejections), with documented
tolerances. Full-test passes all **63** checked-in differential fixtures. Native regression includes exact source reads of `uint64` values,
complex-valued weights, reversed views and zero-weight rejections. The kernel
is not bitwise-identical to NumPy's accumulation for every floating-point
input, and object/text/temporal weighting is deliberately unsupported.

## 0.49 truth and population reductions

`any`, `all`, and `count_nonzero` are implemented by a shared native C
stride-aware reduction kernel, with module functions and array methods. They
honor LuaRay's 1-based axis indices, axis tuples, `keepdims`, and arbitrary
noncontiguous, transposed and reversed views. `any`/`all` support broadcasted
boolean `where` masks and alias-safe `out`. `count_nonzero` does **not** take
`where` or `out`, matching NumPy's public signature. The default empty-slice
identities are respectively `false`, `true`, and integer zero. Integer,
float, complex, temporal, boolean and fixed-width string truthiness is tested
using source bytes, never converting 64-bit integers to floating point.

The 0.49 fixed-seed oracle suite contains **3,200/3,200** comparisons against
NumPy 2.3.5. A clean native C regression verifies exact uint64, negative
strides, masked empties, NaN, and wide empty Unicode arrays. `make full-test`
passed with **62/62** checked-in differential fixture files. Directed ASan/
UBSan with leak detection passed on the modified native truth kernel, Lua
adapter and new tests; other objects remained uninstrumented. The NumPy 2.5.3
release source checksums are recorded in
`NUMPY_2_5_3_TRUTH_FILE_HASHES.sha256`.

## 0.48 cumulative operations

`cumsum`, `cumprod`, `nancumsum`, and `nancumprod` are now exposed as both
module functions and ndarray methods. Without an axis, they flatten the input
in logical C order, including reversed and transposed views; an explicit axis
uses LuaRay's one-based axis semantics. All four honor supported `dtype` and
`out` options. The NaN-aware variants replace NaNs by the sum/product identity
in a separate native buffer before accumulation: the input remains untouched,
all-NaN positions contribute 0 or 1, and integer and complex representations
are preserved without converting the source through Python or `double`.

They reuse the pre-existing native `add_accumulate` and `multiply_accumulate`
kernels. Accumulation results may still differ from NumPy for particular
floating-point rounding patterns and unsupported DTypes. NumPy warnings are
not emitted; LuaRay uses Lua's 1-based explicit axis indices.

The runtime currently includes:

- native `nanmedian`, `nanquantile` and `nanpercentile`, which ignore NaNs independently
  in each reduction slice while preserving the original input storage. Support
  Lua 1-based axes and tuples, `keepdims`, scalar or vector quantiles, `out`,
  non-contiguous and negative-stride views, real numeric and boolean inputs,
  and the six quantile methods implemented in 0.44. Entirely NaN-valued or
  empty slices yield NaN without requiring Python or NumPy at runtime.
  NumPy's runtime warnings are not surfaced; complex, strings, datetime,
  multi-dimensional q, weighted quantiles and additional interpolation
  methods remain unsupported and are rejected explicitly;

- native real-numeric `median`, `quantile`, and `percentile`, supporting LuaRay
  one-based axes/axis tuples, `keepdims`, scalar and vector quantiles, `out`,
  strided and transposed input, and six NumPy quantile methods (`linear`,
  `lower`, `higher`, `nearest`, `midpoint`, `inverted_cdf`). Median supports
  empty reductions (NaN); selected discontinuous methods preserve the exact
  original integer payload, including uint64. Supported NumPy signature
  aspects are intentionally partial: no complex, datetime, Unicode, weighted
  quantiles, empty q vector, higher-dimensional q, advanced interpolation
  methods, or `overwrite_input`. Unsupported options are rejected;



- native `argmin`, `argmax` and `ptp` reductions with numeric and complex DTypes, arbitrary negative strides, `keepdims`, explicit axis selection, NumPy-aligned first-occurrence ties and overlap-safe `out`. Position results are **one-based**, by design, rather than NumPy's zero-based indices;

- native statistical `var` and `std` reductions with arbitrary-rank axis tuples, Lua 1-based axes, `keepdims`, `where` masks, floating-point `ddof` / `correction`, explicit floating/complex computation DTypes and `out=` with alias-safe staging; no Python runtime dependency;

- native copy-producing `append`, `delete`, and `insert`, including flattening, one-based index sequences, boolean masks, slices, stable insertion at repeated positions, and native value broadcasting;

- native `ndarray` storage with native heap memory, dimensions, strides, flags, dtype descriptor and shared-buffer view ownership;
- native `roll` (independent allocated copy) and `rollaxis` (shared zero-copy view), supporting multiple/repeated axes and per-axis shifts, C-order flattening, non-C non-F memory order, negative/transposed/empty inputs, fixed-width DTypes and Lua 1-based axis coordinates;
- native independent array copies `tile` and `repeat` / `repeat_elements`, with arbitrary-rank shape multiplication, per-element or scalar repeat counts, C-order flattening, fixed-width DType preservation, and transposed or negative-stride inputs;
- native zero-copy broadcasting views `broadcast_to` and `broadcast_arrays` and shape algebra `broadcast_shapes`, with NumPy-compatible zero strides, preservation of parameterized DTypes, and read-only `broadcast_to` results;
- native zero-copy axis views `transpose` (explicit permutations), `swapaxes`, `moveaxis`, `expand_dims`, `squeeze`, `flip`, `flipud`, `fliplr`, `rot90`; source-derived singleton stride behavior, arbitrary negative strides and shared allocation;
- native view-based `split`, `array_split`, `hsplit`, `vsplit`, and `dsplit`: shared-buffer slices along arbitrary axes, exact and uneven integer sections, explicit boundaries, empty pieces, transposes/negative strides, and preserved parameterized DType descriptors;
- native `concatenate` and `stack` array joining, with Lua 1-based axes, flattening, dtype promotion, casting policies, parameterized DTypes, arbitrary input/output strides and alias-safe `out=` staging;
- NumPy-derived C/F contiguity, zero-sized-array behavior, reshape/view/copy rules, transpose and negative/zero strides;
- broadcasting shape/stride rules derived from `PyArray_Broadcast` and `broadcast_strides`;
- builtin numeric DTypes: `bool`, signed/unsigned 8/16/32/64-bit integers, native `float16`, `float32`, `float64`, `longdouble`, plus native `complex64`, `complex128`, and `complex256`;
- fixed-width legacy string DTypes `S<n>` (raw bytes) and `U<n>` (UCS4 code points), with parametric itemsize/byteorder descriptors, UTF-8 Lua-boundary conversion, width discovery/truncation, endian-aware Unicode transfer, string-family casts, numeric/text common-DType width promotion, descriptor-aware comparisons/weak string scalars, and ndarray-valued `datetime_as_string`;
- first parameterized temporal DTypes: `datetime64[unit]` and `timedelta64[unit]`, represented as int64 payloads plus concrete descriptor metadata `(base unit, multiplier)`, including NumPy unit/divisor parsing, NaT, metadata promotion/casting, Lua scalar userdata, arithmetic/comparisons, `maximum`/`minimum`/`fmax`/`fmin`, `isnat`/`isfinite`, and timedelta unary/sign behavior; NumPy-derived ISO date/time parsing/formatting, unit inference, timezone-offset normalization, temporal string-array coercion and scalar `datetime_as_string` formatting are now supported;
- a host-neutral NumPy-2-style DType split: `ln_dtype_class` carries class identity/behavior slots (`default_descr`, `common_dtype`, `common_instance`) while `ln_dtype_descr` carries concrete itemsize/alignment/metadata; builtin numerics currently use singleton descriptors, but ndarray and ufunc execution now traffic in concrete descriptors separately from class-level ufunc signatures;
- source-derived safe-cast/promotion behavior for that subset plus Lua weak integer/number/boolean scalar handling;
- `PyArray_Pack`-style scalar range validation and numeric strided dtype-transfer loops;
- Lua 1-based basic integer indexing, negative indexing, slices, ellipsis and newaxis;
- advanced/fancy integer indexing, boolean masks, MapIter-style axis placement/result strides and repeated-index assignment;
- scalar and ndarray-valued indexed assignment with RHS broadcasting and overlap-safe copies;
- binary ufunc execution for add/subtract/multiply/true-divide through source-derived strided inner loops;
- arithmetic/bitwise ufuncs `floor_divide`, `remainder`/`mod`, `power`, `bitwise_and`, `bitwise_or`, `bitwise_xor`, plus `fmax`, `fmin`, and `copysign`, including integer division/remainder edge cases and masked negative-integer-power validation;
- mathematical ufuncs `sqrt`, `exp`, `log`, `sin`, `cos`, `tan`, `sinh`, `cosh`, `tanh`, `exp2`, `log2`, `log10`, `expm1`, `log1p`, real `cbrt`, inverse trig/hyperbolic `arcsin`/`arccos`/`arctan`/`arcsinh`/`arccosh`/`arctanh`, plus real `arctan2` and `hypot`, with NumPy-derived dtype resolution, KEEPORDER, `out=` and `where=` semantics and configured complex branch behavior where NumPy exposes complex loops;
- comparison ufuncs `equal`, `not_equal`, `less`, `less_equal`, `greater`, `greater_equal`, including the exact mixed signed/unsigned 64-bit `qQ/Qq` loops rather than lossy float promotion;
- logical ufuncs `logical_and`, `logical_or`, `logical_xor`, plus `maximum`/`minimum` with NumPy NaN propagation;
- unary `negative`, `absolute`/`abs`, `positive`, `sign`, `logical_not`, `isnan`, `isinf`, `isfinite`, and `signbit`, including NumPy bool rejection rules and modular signed-min behavior;
- bool add/multiply semantics, bool-subtract rejection and integer/bool true-divide→`float64` resolution;
- a native NpyIter subset with source-derived axis ordering, negative-stride flipping, coalescing, reusable cast buffers, keep-order outputs, `out=`, `where=`, same-kind output casting and overlap temporary/writeback;
- a host-neutral generic ufunc registry plus generalized numeric iterator path (`ln_ufunc` + `ln_nditer_multi`) with independent `nin`/`nout`, registered dtype signatures, resolver callbacks, N-input broadcasting/casting, N-output allocation/writeback, `out`/`where`, overlap-safe temporaries, generalized NpyIter-derived KEEPORDER axis selection, and host-neutral weak-scalar operands resolved before 0-D materialization; **60 ufuncs** are now registered: the four registry-native multi/heterogeneous-output operations plus every one of the 56 legacy numeric `LN_OP_*` operations. Public unary/binary ufunc calls and ndarray operator paths now require the registry rather than silently falling back to the legacy executor; the enum remains only as an internal kernel identifier/compatibility source for older lower-level machinery;
- `sum`, `prod`, `mean` with multiple axes, `dtype`, `out`, `keepdims`, `initial` where applicable, and `where`;
- source-derived pairwise floating summation (`PW_BLOCKSIZE = 128`) for supported floating reductions;
- `add.accumulate` / `multiply.accumulate` equivalents with dtype/out semantics;
- `add.reduceat` / `multiply.reduceat` equivalents, including NumPy's descending/repeated-index first-element rule;
- native `matmul` gufunc dimensional semantics `(m?,n),(n,p?)->(m?,p?)`, including vectors, matrices, batched broadcasting, mixed dtypes, boolean matmul, negative/non-contiguous strides and `out=`;
- source-derived CBLAS level-1/2/3 fast paths for homogeneous BLASable `float32`/`float64` and `complex64`/`complex128` product cores: unconjugated vector dot (`sdot`/`ddot`, `cdotu`/`zdotu`), matrix-vector/vector-matrix (`sgemv`/`dgemv`, `cgemv`/`zgemv`) and matrix-matrix (`sgemm`/`dgemm`, `cgemm`/`zgemm`), with the strided kernel as fallback;
- native `dot` with NumPy's distinct higher-rank contraction semantics, strict non-scalar `out=` C-array/dtype rules, scalar CBLAS-vs-ufunc quirk, and `a:dot(b)`;
- native `inner` via NumPy's last-axis contraction semantics and `outer` via C-order flatten + multiply semantics, including `outer(..., {out=...})`;
- numeric `sort`/`argsort` using the source-derived introsort structure, plus `partition`/`argpartition` using introselect, including K-order copy/layout behavior and NaN-at-end ordering;
- numeric `searchsorted` from `PyArray_SearchSorted`/`binsearch.cpp`, including left/right insertion, common-dtype casting, strided 1-D haystacks and optional 1-based Lua `sorter`;
- native complex scalar userdata (`np.complex`) and complex ndarray construction/casting/promotion, arithmetic/comparisons/logicals, reductions/accumulate, generic-strided matmul/dot/inner/outer, NumPy total-order sorting/searching, and complex power/elementary/inverse math;
- native PocketFFT-backed `np.fft.fft`, `ifft`, `rfft`, `irfft`, plus `fftn`, `ifftn`, `rfftn`, `irfftn`, `fft2`, `ifft2`, `rfft2`, and `irfft2`, including NumPy dtype resolution, crop/zero-pad, norms, K-order layouts, repeated axes, `s=-1`, and explicit `out=` behavior;
- LAPACK-backed and source-derived `np.linalg` surface: `solve`, `tensorsolve`, `tensorinv`, `inv`, `det`, `slogdet`, `cholesky`, `qr`, `eig`, `eigvals`, `eigh`, `eigvalsh`, `svd`, `svdvals`, `lstsq`, `pinv`, `matrix_rank`, `norm`, `cond`, `matrix_power`, `multi_dot`, `outer`, `diagonal`, `trace`, `cross`, `tensordot`, `matmul`, `matrix_transpose`, `matrix_norm`, `vector_norm`, and `vecdot`; this includes stacked matrices where NumPy supports them, arbitrary strides, NumPy `_commonType` rules, real/complex paths, tolerance broadcasting, longdouble direct-norm paths, decomposition edge cases, and QR modes `reduced`, `complete`, `r`, `raw`, and legacy `economic`;
- Lua userdata/metatables and `+`, `-`, `*`, `/`, `//`, `%`, `^`, `&`, `|`, binary `~` (xor), and unary `-` operators.

The shared module directly links against Lua 5.4, BLAS, and LAPACK plus ordinary system libraries. It does **not** link against Python or CPython.

## Lua surface

The canonical module name is `luaray` / `luaray_core`. `lua/lunumpy.lua` and `luaopen_lunumpy_core` remain only as temporary compatibility aliases for pre-rename snapshots.

```lua
local np = require("luaray")

local a = np.array({1, 2, 3, 4})
local b = a * 2
assert(np.mean(b) == 5)

local x = np.reshape(np.arange(24), {2, 3, 4})
local v = x:get(2, np.slice(1, nil, 2), np.slice(2, 4))
local reversed = x:get(np.ellipsis, np.slice(nil, nil, -1))
x:set(99, 2, np.slice(1, nil, 2), np.ellipsis)

local fancy = np.array({1, 3}, np.int64)
local picked = x:get(fancy)
local mask = np.array({true, false}, np.bool)
local first_block = x:get(mask)

local out = np.array({100, 100, 100}, np.int64)
local where = np.array({true, false, true}, np.bool)
np.add(np.array({1, 2, 3}, np.int8),
       np.array({10, 20, 30}, np.int8),
       {out=out, where=where})

local cmp = np.greater(np.array({1, 4, 2}), np.array({2, 3, 2}))
local clipped_hi = np.minimum(np.array({1.0, 8.0}), 5.0)
local finite = np.isfinite(np.array({1.0, math.huge, 0/0}))
local signs = np.sign(np.array({-2.0, 0.0, 3.0}, np.float32))

local h = np.array({0.25, 1.0, 4.0}, np.float16)
local roots = np.sqrt(h)       -- float16 result
local waves = np.sin(h)
local rem = np.remainder(np.array({-7, 7}), np.array({3, -3}))
local bits = np.bitwise_xor(np.array({5, 7}, np.uint8),
                            np.array({3, 1}, np.uint8))

local q = np.reshape(np.arange(24, np.int16), {2, 3, 4})
local s = np.sum(q, {
    axis={1, 3},
    dtype=np.float32,
    keepdims=true,
    initial=10,
    where=np.ones({2, 3, 4}, np.bool)
})

local acc = np.add_accumulate(np.array({100,100,100}, np.int8))
local ra = np.add_reduceat(np.arange(5), {1, 4, 2})

local m1 = np.reshape(np.arange(12, np.float64), {3, 4})
local m2 = np.reshape(np.arange(20, np.float64), {4, 5})
local mm = np.matmul(m1, m2)
local mm2 = m1:matmul(m2)

local d = np.dot(m1, m2)
local d2 = m1:dot(m2)
local ip = np.inner(np.array({1,2,3}), np.array({4,5,6}))
local op = np.outer(np.array({1,2}), np.array({3,4,5}))

local sorted = np.sort(np.array({3,1,2}))
local order = np.argsort(np.array({30,10,20})) -- {2,3,1}, Lua indices
local part = np.partition(np.array({8,3,5,1}), 2)
local pos = np.searchsorted(np.array({1,3,5,7}), 4) -- 3

local spectrum = np.fft.fft(np.array({0.0, 1.0, 0.0, 0.0}))
local image_freq = np.fft.fft2(np.ones({8, 8}, np.float32))
local volume_freq = np.fft.rfftn(np.ones({4, 6, 8}, np.float32), {axes={1,3}})
```

### Index and axis convention

Positive Lua indices are **1-based**. Negative indices count from the end. Index `0` is invalid.

`np.slice(start, stop, step)` keeps NumPy's half-open slicing model, but positive bounds are expressed in the Lua 1-based coordinate system:

```lua
np.slice()               -- full axis
np.slice(2, 5)           -- positions 2, 3, 4
np.slice(nil, nil, -1)   -- reverse axis
```

Reduction/accumulate/reduceat axes use the same convention: axis `1` is the first dimension, axis `-1` is the last dimension, and axis `0` is invalid. For `reduceat`, positive index entries are 1-based and negative entries count from the end. That negative-index acceptance is a deliberate Lua-surface adaptation; Python NumPy's `reduceat` rejects negative indices.

For reductions, `axis={}` means NumPy's `axis=()` — reduce no axes. It does **not** mean “all axes”. Omitting `axis` reduces all axes for `sum`, `prod`, and `mean`.

### Extended reductions

Supported examples:

```lua
np.sum(a, 2)
np.sum(a, {axis={1,3}, dtype=np.float32, keepdims=true,
           initial=5, where=mask, out=dest})
np.prod(a, {axis={}, initial=2})
np.mean(a, {axis=-1, dtype=np.float64, where=mask, out=dest})

np.add_accumulate(a, {axis=2, dtype=np.int64, out=dest})
np.multiply_accumulate(a, 1)

np.add_reduceat(a, {1,4,2}, {axis=2, dtype=np.int64, out=dest})
np.multiply_reduceat(a, indices_ndarray, -1)
```

### Matmul

```lua
np.matmul(a, b)
np.matmul(a, b, out_array)
np.matmul(a, b, {out=out_array})
a:matmul(b)
```

Lua has no `@` operator, so no fake operator is introduced. `np.dot` is implemented separately from `matmul`, following `PyArray_MatrixProduct2`: for non-scalar contractions, `out=` must have the exact result dtype/shape and be a writable aligned C-contiguous array. `np.inner` follows `PyArray_InnerProduct`; `np.outer` follows `numeric.py` by flattening both operands in C order and applying multiply.

### Sorting / searching

`np.sort`, `np.argsort`, `np.partition`, and `np.argpartition` use Lua 1-based axis/kth conventions. `argsort`/`argpartition` return **1-based indices**. The current NumPy-main behavior maps the legacy `heapsort` flag to the default unstable quicksort path; stable sorting is not yet ported and is rejected explicitly rather than silently approximated.

`np.searchsorted(a, v, side)` returns **1-based insertion positions** in `1..#a+1`. An optional `sorter` is also expressed with 1-based Lua indices and is normalized internally to NumPy's zero-based binary-search core.

```lua
local a = np.array({10, 30, 50})
assert(np.searchsorted(a, 20) == 2)
assert(np.searchsorted(a, 30, "right") == 3)

local u = np.array({30, 10, 20})
local sorter = np.argsort(u)
assert(np.searchsorted(u, 25, {sorter=sorter}) == 3)
```

## Build and tests

The current environment has the Lua 5.4 shared runtime but no Lua development headers/executable. `src/lua_compat.h` therefore declares the small Lua 5.4 ABI surface needed by this bootstrap. A CBLAS-compatible BLAS library is required for the product fast paths, and a Fortran-ABI LAPACK library is required for `np.linalg`.

```sh
make full-test

# Development only: generates expected values with Python NumPy,
# then executes them through the native Lua runtime.
make oracle-test
```

Current generated differential coverage:

- 220 add/multiply + broadcasting cases;
- 5 buffered mixed-DType stress cases;
- 250 basic-indexing cases;
- 260 scalar-casting cases;
- 180 reshape cases;
- 240 basic indexed-assignment cases;
- 182 basic `sum`/`prod` cases;
- 141 basic `mean` cases;
- 300 advanced indexing cases;
- 180 advanced assignment cases;
- 393 subtract/true-divide array/scalar cases;
- 355 NpyIter/`out`/`where` cases;
- 325 extended reduction cases;
- 264 accumulate cases;
- 286 reduceat cases;
- 306 matmul cases;
- 486 `dot`/`inner`/`outer` cases;
- 565 sorting/selection cases;
- 366 `searchsorted` cases;
- 1,382 comparison/logical/minmax/unary-uFunc catalogue cases;
- 1,360 floor-divide/remainder/power/bitwise/fmin/fmax/copysign cases;
- 663 mathematical `sqrt`/`exp`/`log`/`sin`/`cos`/`tan` cases;
- 755 native `float16` conversion/promotion/ufunc/reduction/product/sorting/searching cases;
- 929 native complex DType/arithmetic/reduction/product/sorting/searching cases;
- 207 complex power/elementary-math edge cases;
- 346 extended real/complex math cases for `sinh`/`cosh`/`tanh`, `exp2`, `log2`, `log10`, `expm1`, `log1p`, and real `cbrt`;
- 270 inverse trig/hyperbolic + `arctan2`/`hypot` cases;
- 335 PocketFFT 1-D cases;
- 327 PocketFFT n-D/2-D cases;
- 256 all-pairs DType-promotion cases;
- 474 LAPACK `solve`/`inv`/`det`/`slogdet`/`cholesky` cases;
- 149 LAPACK QR cases;
- 618 LAPACK eigenvalue/SVD cases;
- 609 advanced linalg cases for `lstsq`/`pinv`/`matrix_rank`/`norm`/`cond`;
- 723 linalg public-surface cases for `matrix_power`, tensor solvers, `multi_dot`, `outer`, `diagonal`/`trace`, `cross`, `tensordot`, `matmul`, matrix/vector norm wrappers, transpose, and `vecdot`;
- 329 generic-registry cases for `frexp`, `modf`, `divmod`, and `ldexp`, including multi-output `out`/`where`, dtype signatures, broadcasting, negative strides, signed zero, and casting/error paths;
- 215 registry-migration cases for migrated arithmetic/comparison/unary ufuncs, including signed/unsigned 64-bit comparison loops, operators, `out`/`where`, negative strides, and exact KEEPORDER result strides;
- 1,065 weak-scalar/second-wave registry cases covering both scalar sides, NEP-50 value fitting/range errors, 16 newly migrated binary ufunc families, `out`/`where`, operators, complex/inexact promotion, and exact uint64↔negative-integer comparisons;
- 338 unary-registry migration cases covering all 21 transcendental/inverse unary ufuncs, safe integer→inexact loop selection, complex signatures/rejections, `out`/`where`, KEEPORDER, signed zero and Lua aliases.

Total: **17,557 generated differential cases** across **43 generated suites**, plus fixed smoke/error-path assertions.

The normal core, Lua smoke, and all generated differential suites pass. The linalg/QR/eigen/SVD/advanced/surface paths also pass targeted ASan + UBSan validation; PocketFFT is reused from the already-built normal object during the targeted sanitizer run because instrumenting its header-only translation unit exceeds the execution limit in this environment.

Python/NumPy is used only as a **development-time oracle** by generator scripts. It is not loaded or invoked by the module or Lua runner.

## Important unported scope

This is not complete NumPy. Major remaining work includes:

- the full/public NpyIter state machine and all iterator flags plus NumPy's complete bounded-Diophantine overlap solver; 0.21 now has an internal arbitrary numeric N-input/N-output executor, but it is not yet a complete NpyIter port;
- complete DType machinery beyond the currently exposed numeric, temporal, and fixed-width legacy `S`/`U` subset: modern variable-width `StringDType`, object, structured/subarray/custom DTypes and the broader NumPy scalar/DType machinery; the default transfer/discovery matrix for legacy strings is now present, while the full public casting-policy surface (`casting=`, `can_cast`) remains future work;
- further evolution of the ufunc/ArrayMethod-style resolver toward descriptor-aware DTypes and generic ufunc methods. All 56 currently implemented legacy numeric operations now have registry entries and public calls no longer fall back to the legacy executor, but the old enum is still used internally as a compact kernel identifier and by older reduction/low-level paths;
- additional reduction operations and generic ufunc methods/kwargs beyond the currently ported add/multiply reduction family;
- remaining upstream BLAS selector details: temporary packing for otherwise non-BLASable floating matrices, SYRK recognition, and scalar/AXPY micro-specializations;
- top-level product APIs still missing from the main namespace, notably `vdot`, `vecdot`, `tensordot`, `einsum`, `einsum_path`, `kron`, and aliases that currently exist only under `np.linalg`;
- stable sorting (`stable=true` / stable argsort) and the broader searching/set-operation family (`unique`, `isin`, `nonzero` public API, etc.);
- `np.linalg` is now functionally closed for the numeric public functions in the pinned `__all__`; Python's `LinAlgError` class itself is intentionally replaced by native Lua errors, while broader array-like coercion and nonnumeric DTypes remain general-runtime work;
- remaining FFT surface such as `hfft`/`ihfft`, frequency/shift helpers, and additional helper APIs;
- random generators/distributions;
- file I/O (`.npy`, `.npz`, text, memory mapping);
- most high-level Python-authored NumPy APIs.

The implementation intentionally prefers narrow, source-derived compatibility over claiming broad APIs that only resemble NumPy.


## Native complex DTypes and elementary math (0.13.0-dev)

LuaRay now exposes `complex64`, `complex128`, and `complex256` as native adjacent real/imag storage, plus `np.complex(real, imag)` host scalar userdata. The implementation was traced through:

- `numpy/_core/src/umath/loops.c.src` for complex arithmetic, comparisons, logicals, sign/predicates, min/max and pairwise addition;
- `numpy/_core/src/common/numpy_tag.hpp` for NumPy's complex total ordering used by sorting/searching;
- `numpy/_core/src/npymath/npy_math_complex.c.src` for scaled complex exponential, logarithm, square root, power and the msun-derived hyperbolic/trigonometric edge handling;
- `numpy/_core/src/umath/funcs.inc.src` for the ufunc-to-npymath complex elementary-function wiring;
- the existing DType transfer/promotion sources for real↔complex casts and weak Python-complex-style promotion behavior.

Complex arrays participate in broadcasting, views/indexing/assignment, ufunc execution, reductions, accumulate, the generic strided product kernels, sorting/argsort/searchsorted and the supported elementary math family. LuaRay's BLAS selector now includes homogeneous BLASable complex64/complex128 DOTU, GEMV and GEMM paths in addition to float32/float64. Non-BLASable layouts, mixed DTypes, complex256 and other unsupported BLAS cases continue through the native source-derived strided kernels.

The `npy_math_complex.c.src` port preserves NumPy's explicit finite/Inf/NaN/signed-zero branches instead of replacing the implementation wholesale with libc complex wrappers. Where NumPy's configured C99 path differs from its portable msun fallback (notably `tan(±Inf+0j)` on this platform), LuaRay reproduces the configured upstream observable result. NumPy floating-status flag plumbing is still not exposed and is not claimed.


## Extended elementary math and complex CBLAS (0.14.0-dev)

The 0.14 tranche extends the source-derived elementary-math family with `sinh`, `cosh`, `tanh`, `exp2`, `log2`, `log10`, `expm1`, `log1p`, and real `cbrt`. Real float32/float64/longdouble loops follow the scalar fallback shape in `loops_umath_fp.dispatch.c.src`; float16 uses the existing half→float→half path. Complex implementations for the functions NumPy exposes on complex DTypes are translated from `funcs.inc.src` and `npy_math_complex.c.src`, preserving the configured upstream Inf/NaN/signed-zero behavior rather than delegating the full contract to libc complex functions. NumPy does not expose a complex `cbrt` loop, so LuaRay rejects complex input instead of inventing one.

The BLAS selector now also uses NumPy-style **unconjugated** complex products for compatible contiguous/strided cores: `cblas_cdotu_sub`/`cblas_zdotu_sub`, `cblas_cgemv`/`cblas_zgemv`, and `cblas_cgemm`/`cblas_zgemm`. This is deliberately DOTU, not DOTC, because NumPy `dot`/`matmul` do not conjugate operands. Complex256 and non-BLASable layouts retain the generic strided kernels.


## Inverse math and native PocketFFT (0.15.0-dev)

The 0.15 tranche adds the inverse trigonometric/hyperbolic ufunc family (`arcsin`, `arccos`, `arctan`, `arcsinh`, `arccosh`, `arctanh`) plus real `arctan2` and `hypot`. Real loops follow the generated NumPy ufunc families; complex inverse functions follow NumPy's configured C99-complex path on this platform and are differential-tested around branch cuts, signed zero, infinities and NaNs. `arctan2` and `hypot` remain real-only because NumPy does not expose complex loops for them.

FFT support is now native and uses the same PocketFFT implementation family as NumPy. `ln_fft.cpp` adapts the host-neutral numerical work from `numpy/fft/_pocketfft_umath.cpp` and the high-level dtype/norm/crop/pad rules from `numpy/fft/_pocketfft.py`. Because GitHub Download ZIP omits Git submodule payloads, the PocketFFT header/license/readme are pinned separately to NumPy main's exact PocketFFT submodule commit and their hashes are recorded in `POCKETFFT_FILE_HASHES.sha256`. No Python code participates at runtime.

The public FFT surface currently includes 1-D `fft`/`ifft`/`rfft`/`irfft` and the `_raw_fftnd` family `fftn`/`ifftn`/`rfftn`/`irfftn` plus the 2-D aliases. Lua axes are 1-based (negative axes still count from the end). The n-D wrapper ports `_cook_nd_args` semantics including repeated axes, crop/zero-padding, `s=-1`, the `irfftn` default final length, and transform ordering. Since Lua cannot distinguish an empty positional sequence from an empty options table, `np.fft.fftn(a,{})` means default options; the no-transform `s=()` case is written explicitly as `np.fft.fftn(a,{s={}})`.


## LAPACK-backed linalg (0.16.0-dev)

The first native `np.linalg` tranche calls LAPACK directly through its Fortran ABI rather than reimplementing factorizations in Lua:

- `solve`: `GESV`, including NumPy-style vector-vs-matrix RHS handling and broadcast batch dimensions;
- `inv`: `GESV` against an identity matrix;
- `det` / `slogdet`: `GETRF`, pivot parity, diagonal phase/sign and log-absolute accumulation;
- `cholesky`: `POTRF`, with lower and upper outputs;
- `qr`: `GEQRF` followed by `ORGQR`/`UNGQR` where an explicit Q is requested.

The public result DTypes follow `numpy.linalg._linalg._commonType`: integer/bool inputs use and return `float64`, `float32`/`complex64` compute through double/complex-double LAPACK and cast the result back, and `float64`/`complex128` remain at their precision. As in NumPy's LAPACK-backed decomposition boundary, `float16`, `longdouble`, and `complex256` are rejected rather than silently coerced. Pure arithmetic `norm` paths separately preserve NumPy's supported `longdouble`/`clongdouble` behavior; SVD-based norm orders still reject those DTypes, matching upstream. QR supports stacked matrices and NumPy's `reduced`, `complete`, `r`, `raw`, and legacy `economic` modes; Lua returns multiple values where NumPy returns tuple-like result objects.


## Eigenvalue decomposition and SVD (0.17.0-dev)

The second native `np.linalg` tranche was ported against the supplied NumPy `main` source tree (`2.6.0.dev0`) and extends the LAPACK boundary with:

- `eig` / `eigvals`: `GEEV`; real LAPACK conjugate-pair eigenvectors are rebuilt as complex vectors using NumPy's `GEEV` representation rules;
- `eigh` / `eigvalsh`: `SYEVD` for real matrices and `HEEVD` for complex Hermitian matrices, including `UPLO` behavior and ignored imaginary diagonal components;
- `svd` / `svdvals`: `GESDD`, including stacked inputs, full/reduced matrices, `compute_uv=false`, real/complex result DTypes, and empty full-SVD identity outputs;
- `svd(..., {hermitian=true})`: the high-level NumPy path built from `eigh`/`eigvalsh`, absolute eigenvalues, descending reordering, and sign transfer into `Vh`.

A current-main semantic detail is preserved deliberately: `eig` and `eigvals` return a complex result DType for real inputs even when every computed eigenvalue is real. This differs from older NumPy releases that could downcast such results to a real DType. Eigenvector/SVD validation does not compare arbitrary vector signs/phases directly; the differential suite checks eigenvalues/singular values plus the defining residual/reconstruction identities.


## Least squares and high-level linalg helpers (0.18.0-dev)

The third native `np.linalg` tranche follows the same exact supplied NumPy `main` tree and adds:

- `lstsq`: direct `DGELSD` / `ZGELSD`, including NumPy 2.x default `rcond`, vector/matrix right-hand sides, rank, singular values, residual-shape rules, real/complex paths, and zero-size systems;
- `pinv`: the upstream reduced-SVD construction, Hermitian shortcut, NumPy cutoff rule, empty-matrix DType fix, and scalar or ndarray `rcond`/`rtol` broadcasting against matrix stacks;
- `matrix_rank`: SVD/Hermitian-SVD rank detection, NumPy's default `max(M,N)*eps` threshold, scalar/vector special cases, and broadcastable `tol`/`rtol` that can expand the result batch shape;
- `norm`: vector and matrix orders, arbitrary one/two-axis reductions, `keepdims`, Frobenius/nuclear/SVD norms, strict Lua 1-based positive axes, and the upstream `longdouble`/`clongdouble` direct p-norm regressions;
- `cond`: SVD-based `None`/`±2`, inverse+norm paths for square-matrix orders, stacked matrices, singular matrices, and NumPy-main NaN/Inf normalization behavior.

The Lua boundary intentionally uses an options table where Python uses keyword-only arguments, for example `np.linalg.norm(a, {ord=2, axis=2, keepdims=true})` and `np.linalg.pinv(a, {rcond=tol, hermitian=true})`. Positive axes are always 1-based; `axis=0` is rejected rather than accepted as an accidental alias for the first axis. Internally the numerical code remains zero-based.

`np.array` now also accepts scalar numeric/boolean/complex input and creates a genuine 0-D ndarray. This was required to reproduce `matrix_rank`'s scalar behavior rather than special-casing Lua numbers inside linalg.


## NumPy linalg public-surface closure (0.19.0-dev)

The fourth linalg tranche audits `numpy/linalg/__init__.py`, `numpy/linalg/_linalg.py`, `numpy/linalg/tests/test_linalg.py`, and the core product helpers used by the Array-API-compatible aliases. `UPSTREAM_FILE_HASHES.sha256` now pins **90 exact upstream files**, including `numpy/linalg/__init__.py` so the exported surface itself is part of the source-of-truth audit.

LuaRay now implements every functional name in the pinned `numpy.linalg.__all__`: `matrix_power`, `solve`, `tensorsolve`, `tensorinv`, `inv`, `cholesky`, `eigvals`, `eigvalsh`, `pinv`, `slogdet`, `det`, `svd`, `svdvals`, `eig`, `eigh`, `lstsq`, `norm`, `qr`, `cond`, `matrix_rank`, `multi_dot`, `trace`, `diagonal`, `cross`, `outer`, `tensordot`, `matmul`, `matrix_transpose`, `matrix_norm`, `vector_norm`, and `vecdot`. The remaining `LinAlgError` export is Python exception machinery, not a numerical API; LuaRay maps those failure conditions to native Lua errors rather than manufacturing a Python-style exception class.

The new implementations deliberately compose existing native primitives instead of introducing duplicate algorithms: `matrix_power` uses matmul/inverse with exponentiation by squaring; tensor inversion/solving reshape and permute into the existing LAPACK paths; `multi_dot` uses NumPy's matrix-chain dynamic-programming rule; `tensordot` lowers contractions to permute/reshape plus native dot; `cross`, `diagonal`, `trace`, and matrix transpose are native stride/view/reduction operations; `matrix_norm` and `vector_norm` reuse the already-ported norm semantics; and `vecdot` conjugates the first operand then executes the existing product machinery.

Lua host conventions remain localized to the boundary. Positive axis values are 1-based, negative axes count from the end, while quantities such as `tensorinv`'s `ind`, integer powers, and `tensordot(..., axes=N)` are counts and are therefore not index-shifted. `matrix_power(a, 1)` preserves the input userdata identity as NumPy preserves the input array object. Python arbitrary-precision integer exponents have no literal Lua 5.4 integer equivalent, so the public exponent is limited to Lua's integer range; the matrix-power algorithm itself is not otherwise narrowed.


## Generic ufunc engine and multi-output execution (0.20.0-dev)

The 0.20 tranche begins replacing the bootstrap `LN_OP_*` executor with a host-neutral ufunc architecture derived from NumPy's generated ufunc signatures, ArrayMethod-style loop selection responsibilities, and NpyIter external-loop execution model.

The new path is deliberately split into independent layers:

```text
ln_ufunc
  arity + loop registry + dtype signatures + resolver
        ↓
ln_nditer_multi
  N inputs + N outputs + broadcasting/casting/out/where/writeback
        ↓
strided native kernel
```

`frexp` (`1 -> 2`), `modf` (`1 -> 2`), `divmod` (`2 -> 2`) and `ldexp` (`2 -> 1` with heterogeneous float/integer signatures) are the first operations implemented exclusively through this path. They are **not** additional `LN_OP_*` enum values. Lua naturally exposes NumPy's tuple-like multi-output result as multiple return values, e.g. `local mantissa, exponent = np.frexp(a)`. Multi-output `out` is an indexed Lua table and may be partial, for example `{out={[1]=mantissa_out}}`; missing result slots are allocated by the resolved loop.

This tranche is an architectural migration, not a claim that all legacy ufuncs already use the new registry. The existing 56 enum-backed operations continue to use the older specialized executor while their tested behavior remains unchanged. Future work can migrate them incrementally without changing the public API, while multi-output and heterogeneous signatures no longer require new special-case executor shapes.


## Registry migration and generalized KEEPORDER (0.21.0-dev)

The 0.21 engine tranche continues against the same exact **90-file** upstream source/test pin. No additional upstream file was needed: the source-of-truth material for this migration was already pinned in `numpy/_core/code_generators/generate_umath.py`, `numpy/_core/src/umath/ufunc_object.c`, `numpy/_core/src/multiarray/nditer_constr.c`, `nditer_api.c`, the generated/dispatch loop sources, and the core ufunc tests.

Nineteen previously enum-backed operations are now registered in the host-neutral `ln_ufunc` engine in addition to the four 0.20 registry-only operations. The migrated set is `add`, `subtract`, `multiply`, `true_divide`, `equal`, `not_equal`, `less`, `less_equal`, `greater`, `greater_equal`, `negative`, `absolute`, `positive`, `sign`, `logical_not`, `isnan`, `isinf`, `isfinite`, and `signbit`. Their registry entries preserve source-derived DType resolution, including bool-subtract rejection, integer/bool true-divide to `float64`, complex absolute-to-real output, and exact mixed signed/unsigned 64-bit comparison loops. Existing native numerical loops are reused through host-neutral adapters rather than rewritten.

`ln_nditer_multi` now ports the NpyIter KEEPORDER axis-ordering responsibility across arbitrary participating inputs, pre-existing outputs and masks. Allocated or temporary outputs derive their strides from the broadcast operand stride ordering rather than the earlier first-input C/F-contiguity shortcut. Differential coverage checks observable result strides for transposed and mixed positive/negative-stride views in addition to values and DTypes.

For migrated operations, ndarray↔ndarray function calls and the corresponding Lua arithmetic/comparison operator paths execute through `ln_ufunc` + `ln_nditer_multi`. Weak Lua scalar promotion remains deliberately routed through the existing compatibility bridge in this snapshot because NumPy's weak-scalar resolution is a separate semantic responsibility that should be migrated into the resolver rather than approximated ad hoc. The legacy `LN_OP_*` enum therefore remains at 56 values; 0.21 reduces public dependence on it without claiming that the migration is complete.


## Weak-scalar resolver and second registry migration (0.22.0-dev)

The 0.22 engine tranche removes the weak-scalar compatibility bridge for registered binary ufuncs. Lua booleans, integers, floating numbers, and `np.complex` scalars are represented as host-neutral **weak operands** until loop resolution. Only after the NumPy-derived promotion logic selects a concrete loop DType is the scalar materialized as a temporary 0-D ndarray. This preserves NEP-50-style behavior such as `uint8 + 2 -> uint8`, `float32 + 2.0 -> float32`, `float32 + 2j -> complex64`, comparison of `uint8` with an out-of-range integer without arithmetic overflow, and arithmetic range errors such as `uint8 + 300`.

Sixteen additional existing binary ufuncs now route through `ln_ufunc` + `ln_nditer_multi`: `logical_and`, `logical_or`, `logical_xor`, `maximum`, `minimum`, `floor_divide`, `remainder`, `power`, `bitwise_and`, `bitwise_or`, `bitwise_xor`, `fmax`, `fmin`, `copysign`, `arctan2`, and `hypot`. Their existing source-derived numerical loops are reused; the legacy enum does not grow. Together with the previous tranche this brings the registry to **39 ufuncs** while `LN_OP_*` remains at **56 values**.

The generalized iterator gained an optional host-neutral per-chunk validation hook. Integer `power` uses it to reproduce NumPy's masked negative-integer-exponent error before invoking the strided kernel, including `where` semantics, instead of smuggling operation IDs back into the iterator. This keeps `ln_nditer_multi` independent of ufunc names while still supporting operation-time validation required by observable NumPy behavior.


## Transcendental registry closure (0.23.0-dev)

The 0.23 tranche migrates the remaining 21 enum-backed unary transcendental functions into `ln_ufunc`: `sqrt`, `exp`, `log`, `sin`, `cos`, `tan`, `sinh`, `cosh`, `tanh`, `exp2`, `log2`, `log10`, `expm1`, `log1p`, real-only `cbrt`, and `arcsin`, `arccos`, `arctan`, `arcsinh`, `arccosh`, `arctanh`. The registered signatures follow the exact pinned `generate_umath.py` inexact-loop families: bool/integer inputs resolve by safe casting to the first representable floating loop (`int8 -> float16`, `int16 -> float32`, wider integers -> float64), while complex inputs require an actual complex loop. `cbrt` therefore continues to reject complex input rather than inventing a loop absent upstream.

The public ufunc boundary is now closed over the currently implemented builtin numeric catalogue: the registry contains **60 ufuncs** (the four registry-native 0.20 operations plus all **56** legacy `LN_OP_*` operations). Binary functions/operators and unary functions no longer contain compatibility fallback execution paths; a missing registry entry is treated as an internal error. The 56-value enum is deliberately retained for now only as an internal identifier used to select already-ported native kernels and by older low-level/reduction machinery, so this is not yet a claim that every internal switch has been eliminated.

A dedicated **338-case** differential suite checks the migrated unary family across integer/float/complex DType resolution, upstream complex rejection for `cbrt`, generic `out`/`where` writeback, NpyIter-derived KEEPORDER strides, signed-zero preservation, and Lua aliases (`asin`, `acos`, `atan`, `asinh`, `acosh`, `atanh`).


## DType class / descriptor foundation (0.24.0-dev)

The 0.24 engine tranche ports the architectural distinction NumPy 2.x makes between a **DType class** and a **concrete descriptor instance**, without reproducing Python metaclass machinery. `ln_dtype_class` is the Lua-native class-level object; it owns the stable name/kind identity, legacy numeric type number where applicable, class flags, a default descriptor, and host-neutral behavior slots for default-descriptor lookup, common-DType selection, and same-class common-instance resolution. `ln_dtype_descr` is the array-attached instance; it carries the owning class plus byte order, itemsize, alignment, instance flags, and a metadata pointer.

Builtin numeric DTypes remain non-parametric singleton descriptors in this release, so public numeric behavior is intentionally unchanged. The important change is where the engine draws its boundaries: `ln_array.descr` is explicitly a concrete descriptor; promotion is exposed as class-level common-DType followed by common-descriptor resolution; and `ln_ufunc_loop` signatures now store DType **classes** rather than concrete descriptors. Immediately before iteration, a per-call `ln_ufunc_resolution` materializes the concrete descriptor list. If an input already carries a descriptor belonging to the selected class, that descriptor is preserved rather than replaced blindly by the class singleton.

This mirrors the responsibility split in NumPy's `PyArray_DTypeMeta` / `PyArray_Descr` and ArrayMethod descriptor-resolution API while discarding `PyTypeObject`, Python object discovery, CPython references, and metaclass mechanics. No string/datetime/structured DType is claimed yet; 0.24 is the compatibility-preserving substrate required before a class can legitimately have multiple descriptor instances.


## First parameterized DTypes: datetime64 / timedelta64 (0.25.0-dev)

The first consumer of the 0.24 class/descriptor split is NumPy's temporal DType family. `datetime64` and `timedelta64` share class-level behavior but each concrete array carries an interned `ln_dtype_descr` with NumPy-style metadata `(base unit, multiplier)`. The parser accepts the upstream unit spellings and rational-unit reductions used by `test_datetime.py` (for example `Y/4 -> 3M`, `D/120 -> 12m`, `fs/100 -> 10as`, Greek `μs`) and preserves the historical `W/13 -> 0Y` quirk present in the pinned source.

The generic ufunc resolver now performs per-call concrete-descriptor resolution for temporal methods. This permits observable signatures such as `datetime64[D] + timedelta64[h] -> datetime64[h]`, `datetime64[D] - datetime64[h] -> timedelta64[h]`, and strict rejection of incompatible nonlinear `timedelta64[Y]`/linear-unit promotion. `ln_nditer_multi` compares concrete descriptor identity rather than only legacy type numbers, so metadata-only casts are buffered and executed even when both operands are type number 21 or 22.

Implemented temporal ufunc behavior includes add/subtract with NumPy-main overflow rules, all six comparisons with NaT semantics, timedelta `negative`/`positive`/`absolute`/`sign`, `isnat`, `isfinite`, and temporal `maximum`/`minimum`/`fmax`/`fmin`. `out=` and `where=` honor same-kind temporal metadata casts. The arithmetic kernels avoid signed-C overflow even for masked elements; the validator raises only for active positions, matching the observable upstream overflow contract.

The current Lua scalar constructors accept integer counts plus an explicit unit (or `"NaT"`), and array indexing returns metadata-preserving temporal scalar userdata. Full NumPy ISO date/time string parsing/formatting and the broader datetime API remain future work; this release is the first real parameterized-DType runtime tranche, not a claim that NumPy datetime support is complete.


## NumPy ISO datetime strings (0.26.0-dev)

The second temporal tranche ports the host-neutral behavior of `numpy/_core/src/multiarray/datetime_strings.c` / `.h` on top of the parameterized DType runtime introduced in 0.25. `np.datetime64` now accepts ISO-like NumPy datetime strings and infers the concrete temporal descriptor when no unit is supplied; generic `np.array(..., "datetime64")` first discovers a common precision across all temporal/string elements before allocating the ndarray, so mixed inputs such as year-only plus day-precision strings resolve to one common concrete descriptor rather than being parsed independently into a generic shell.

The parser covers signed years, month/day/time components, `T` or space separators, fractional seconds through attosecond precision, `NaT`, empty-string NaT, `today`, `now`, `Z`, and numeric UTC offsets. Calendar-to-int64 conversion deliberately preserves NumPy's historical two's-complement wrap behavior at extreme `fs`/`as` precision while implementing that arithmetic without C signed-overflow undefined behavior. Numeric timezone offsets are normalized to UTC exactly as the upstream parser does.

Scalar formatting is exposed as `np.datetime_as_string` and through datetime scalar stringification. It supports NumPy-style explicit units and `unit="auto"`, casting modes, and Lua-native timezone choices `"naive"`, `"UTC"`, `"local"`, or an integer minute offset. The Python API's arbitrary `tzinfo`/`ZoneInfo` objects have no literal Lua analogue and are not emulated. Likewise, NumPy's warning object emitted for timezone-bearing datetime parsing is not claimed because LuaRay currently has no Python-style warnings subsystem; the value normalization itself is preserved.

`np.datetime_as_string` supports both scalar and ndarray inputs as of 0.27. Array output is a real fixed-width Unicode ndarray whose width follows NumPy's `NpyDatetime_GetDatetimeISO8601StrLen` contract; no Lua-table string approximation is used. Input arrays/tables of strings remain supported when constructing datetime arrays.


## Fixed-width legacy strings/unicode (0.27.0-dev)

The first string-DType tranche ports NumPy's legacy fixed-width `NPY_STRING` / `NPY_UNICODE` descriptor model rather than jumping directly to the newer variable-width `StringDType`. `S<n>` stores exactly `n` raw bytes per element with NUL padding/truncation. `U<n>` stores exactly `n` UCS4 code points (four bytes each), preserves descriptor byte order (`<U`, `>U`), and converts to/from Lua's byte-string host boundary as strict UTF-8. Width discovery for ordinary Lua-string tables therefore counts Unicode code points, not UTF-8 bytes; explicit `S` remains byte-oriented.

Both families are real parameterized `ln_dtype_descr` instances owned by stable DType classes. Same-class common-instance resolution chooses the larger width. String/unicode strided transfers preserve NumPy's padding, truncation and Unicode byte-swapping behavior; legacy `S -> U` and ASCII-compatible `U -> S` transfers are supported. Numeric/text strided transfers provide C-native formatting and parsing for supported numeric DTypes. As of 0.40, common-DType discovery also promotes builtin numeric + legacy S/U descriptors using NumPy's legacy maximum-width tables. This is not an assertion of exact formatting parity for every floating-point/complex edge case; object, custom and temporal/text promotion remain unsupported.

The six comparison ufuncs (`equal`, `not_equal`, `less`, `less_equal`, `greater`, `greater_equal`) use descriptor-aware registry loop data, so operands with different widths/byte orders are compared without teaching `ln_nditer_multi` string semantics. Weak Lua string scalars remain weak until the strong `S`/`U` class is known. Current NumPy-main behavior for default mixed legacy `S`/`U` comparison is preserved: there is no matching loop unless an explicit cast/signature is requested, so LuaRay rejects that combination instead of inventing implicit Unicode promotion.

This tranche also removes the previous scalar-only restriction from `np.datetime_as_string`: ndarray input now returns a genuine `U` ndarray, including NumPy-compatible output widths (`U28` for day formatting, `U38` for seconds, `U62` for explicit `unit="auto"`) and keep-order layout for transposed/F-like inputs. The modern variable-width `StringDType` (`T`) and the broader `numpy.strings` high-level API remain separate future work.


## Legacy string/numeric/temporal casting and discovery (0.28.0-dev)

The second legacy-string tranche ports the source-derived transfer behavior between fixed-width `S`/`U`, builtin numeric DTypes, and temporal DTypes. `np.astype(a, dtype)` and `a:astype(dtype)` now route through the native dtype-transfer machinery rather than formatting through Lua tables. Generic `S`/`U` targets choose a descriptor width from the source DType (`int64 -> U21`, `float64 -> U32`, `complex64/128 -> U64`, etc.), while explicit fixed-width targets preserve NumPy truncation semantics. String-to-numeric parsing covers NumPy-style whitespace/underscores, boolean truth-by-nonempty-string, finite/non-finite floating forms and complex forms such as `(1+2j)`/`-3j`.

Temporal transfers are included in the same matrix: numeric values cast to explicit `datetime64[unit]`/`timedelta64[unit]` counts, generic `datetime64` rejects non-NaT numeric values, temporal-to-numeric casts expose raw int64 counts (including NaT as `INT64_MIN`), and legacy strings parse/format through the existing datetime implementation. Generic `datetime64` requested from an `S`/`U` array discovers a common concrete unit before allocation. Mixed Lua-string/numeric table discovery now promotes to a correctly sized Unicode descriptor rather than rejecting the mixture or selecting width from observed numeric text alone.

The public cast-policy API is intentionally narrower than NumPy in this snapshot: default `astype` transfer semantics are implemented, but `astype(casting=...)`, `np.can_cast`, explicit ufunc signature forcing for mixed `S`/`U`, and the newer variable-width `StringDType` remain separate work.

## Descriptor casting policy and value-preserving astype (0.29.0-dev)

LuaRay now exposes NumPy-style descriptor casting policy through `np.can_cast(from, to, casting)` and `np.astype` / `ndarray:astype` options. The five normal policy levels are `no`, `equiv`, `safe`, `same_kind`, and `unsafe`; their ordering is resolved from concrete descriptors rather than only legacy type numbers, so fixed-width `S/U` lengths/byteorder and datetime/timedelta unit metadata participate in the decision.

`ndarray:astype(..., {casting="same_value"})` additionally ports NumPy-main's value-dependent cast mode. It is intentionally **not** accepted by `np.can_cast`, matching the separate upstream converter. Numeric elements are checked before conversion for destination range and exact value preservation; finite float/complex narrowing must round-trip without changing the value, NaN/Inf are accepted only into floating/complex destinations, and complex-to-real requires an exactly zero imaginary component. Temporal `same_value` follows NumPy's safe metadata conversion rule. The transfer path avoids executing out-of-range C integer casts while performing the check.

Lua host scalars remain weak/untyped and are therefore rejected by `np.can_cast`, as NumPy 2 rejects untyped Python scalars for that API. DType names, ndarrays, and temporal scalar userdata provide concrete source descriptors.


## Native array joining (0.30.0-dev)

The 0.30 tranche ports the array-joining responsibilities of NumPy 2.5.3's
`numpy/_core/src/multiarray/multiarraymodule.c` (`PyArray_ConcatenateInto`,
`PyArray_ConcatenateArrays`) and `numpy/_core/shape_base.py` (`stack`).
`ln_join_arrays` is a **host-neutral native C engine**, not a Lua implementation
that repeatedly calls Python or NumPy. It implements shape checking, source
DType common-instance promotion, per-input descriptor casting, C-order
flattening, stack-axis insertion, arbitrary strided input/output copying,
empty and zero-dimensional cases, and conservative temporary-buffer staging
when `out` aliases an input.

```lua
local np = require("luaray")
local a = np.array({{1, 2}, {3, 4}}, np.int16)
local b = np.array({{5, 6}, {7, 8}}, np.float32)
local joined = np.concatenate({a, b}, 1) -- join rows: shape {4, 2}
local stacked = np.stack({a, b}, -1)      -- shape {2, 2, 2}
local flat = np.concatenate({a, b}, false) -- axis=None, flattened in C order
local casted = np.concatenate({a, b}, {dtype="float64", casting="safe"})
local out = np.zeros({4, 2}, np.float64)
assert(np.concatenate({a, b}, {out=out}) == out)
```

LuaRay uses **1-based positive axis numbers**, preserves negative axes, and
accepts `false` for NumPy's `axis=None` on `concatenate`. An options table may
be passed as the second argument (`{axis=2, dtype="float64"}`) or as the third
argument after an explicit axis. `stack` inserts a new dimension; its default
axis is 1. Sequence elements can be existing LuaRay ndarrays or Lua array
tables converted at the Lua boundary. Unlike Python's general iterable input,
passing an ndarray *directly* as the first argument is not supported: supply
a Lua table of arrays. As in upstream NumPy, `out` and `dtype` cannot be
provided together. Supported casting policies are `no`, `equiv`, `safe`,
`same_kind` (default), and `unsafe`; `same_value` is specific to `astype`.

**Verification:** 355/355 newly generated joining differential cases against
local NumPy 2.3.5, additional targeted Lua/native regressions, and the earlier
44/44 frozen differential suites (22,110 prior cases) all pass, for
**22,465/22,465 cases across 45 generated suites**. Source-level semantics
were checked against the supplied official NumPy 2.5.3 release archive; a
NumPy 2.5.3 executable oracle was not available in the local environment.
This is coverage of the implemented joining subset, **not** a declaration
that NumPy's complete array-manipulation API has been ported.


### Building on Omarchy / Arch

The Makefile checks for an **existing Lua 5.4** library through
`pkg-config` or known library directories; it no longer assumes a Debian
multiarch path. BLAS/LAPACK can be customized with `BLAS_LIBS` and
`LAPACK_LIBS`. No dependency installer is bundled or run automatically.
Before installing anything, check what is present:

```sh
command -v gcc make pkg-config
pkg-config --libs lua5.4 2>/dev/null || ldconfig -p | grep 'liblua5.4'
ldconfig -p | grep -E 'lib(blas|lapack)\.so'
make full-test
```

The native module targets the **Lua 5.4 ABI**. Finding Lua 5.5 alone is not
sufficient; do not silently link it in place of Lua 5.4.


## Native zero-copy splitting (0.31.0-dev)

The 0.31 tranche ports the slicing responsibilities from NumPy 2.5.3's
`numpy/lib/_shape_base_impl.py` and the upstream shape-base tests. Unlike
`concatenate` and `stack`, each split result is a **view**: it shares the
input ndarray's refcounted native allocation and remains valid even if the
original Lua userdata is collected. The original and split views observe one
another's writes. No Python subprocess, NumPy/CPython runtime, or Python FFI
is involved.

```lua
local np = require('luaray')
local a = np.array({1,2,3,4,5,6}, np.int64)
local equal = np.split(a, 3)         -- three views of two elements each
local uneven = np.array_split(a, 4)  -- sizes 2, 2, 1, 1
local cuts = np.split(a, {2,4})      -- [1,2], [3,4], [5,6]
equal[1][2] = 99                   -- modifies a[2] through shared storage

local m = np.reshape(a, {2,3})
local columns = np.hsplit(m, 3)     -- split along Lua axis 2
local rows = np.vsplit(m, 2)        -- split along Lua axis 1
-- np.dsplit is available for ndarrays with >=3 dimensions
```

Positive axes are **Lua 1-based**; negative axes retain NumPy's conventional
meaning. Split indices denote the number of elements preceding a boundary,
so `{2,4}` splits *after* elements 2 and 4 (the same numeric split-index
convention as NumPy, independent of 1-based element access). Out-of-range
boundaries are clipped; negative boundaries count from the axis end, and
unsorted boundaries are allowed and may create empty sections. `split`
requires equal division when given an integer; `array_split` distributes the
remainder across earlier sections. `hsplit` works for 1-D and higher arrays;
`vsplit` needs at least 2 dimensions and `dsplit` at least 3. Explicit
boundaries can be Lua tables or 1-D integer ndarrays.

The public splitting API currently requires a LuaRay ndarray argument, rather
than automatically converting an arbitrary nested Lua table. Section counts
above one million are rejected to bound the number of returned Lua objects;
this is a host-side resource safety limit, not an upstream NumPy semantic.

**Verification:** 5,557/5,557 newly generated split-family differential
cases against local NumPy 2.3.5, native C and Lua storage-ownership
regressions, all 45 previous suites, and targeted ASan+UBSan tests on the
changed C/Lua adapter code. The resulting baseline is **28,022/28,022
cases across 46 generated suites**. NumPy 2.5.3 was audited as source code
rather than run as an executable oracle. These results validate the covered
operations; no entire-NumPy API coverage claim is made.



## Axis manipulation / zero-copy views (0.32.0-dev)

This tranche introduces nine new array-manipulation operations. Every
**ndarray-valued** result is a shared-buffer view: no copying or Python runtime
is required, and subsequent writes through the view modify the original.
`flip` of a 0-D ndarray follows NumPy by returning a Lua scalar rather than
an ndarray. NumPy 2.5.3's source files are pinned in
`NUMPY_2_5_3_AXIS_FILE_HASHES.sha256`.

```lua
local np = require('luaray')
local image = np.reshape(np.arange(12, 'float32'), {3,4})
local rotated = np.rot90(image)          -- shape {4,3}, counterclockwise
local mirrored = np.fliplr(image)        -- horizontal reversed-stride view
local f = np.flip(image, {1,2})         -- reverse both axes
local sw = np.swapaxes(image, 1,2)      -- same as explicit transpose here
local tr = np.transpose(image, {2,1})   -- explicit permutation
local batch = np.expand_dims(image, 1)  -- shape {1,3,4}
local again = np.squeeze(batch, 1)      -- shape {3,4}
local moved = np.moveaxis(batch, 1,-1)  -- shape {3,4,1}
mirrored:set(42,1,1)
assert(image:get(1,4) == 42)            -- the original changed too
```

The positive-axis convention remains **Lua 1-based** (zero is rejected);
negative axes retain NumPy semantics. Axis sequences are Lua tables, e.g.
`{3,1,2}`. `rot90(array,k,{axis1,axis2})` defaults to `k=1` and axes
`{1,2}`. `flip(array)` flips every axis; `flip(array,{})` flips none.
`squeeze(array)` removes all length-one axes, while `squeeze(array,{})`
removes none. The axis functions currently require an ndarray rather than
implicitly converting arbitrary Lua tables.

**Verification:** NumPy 2.3.5 executable oracle: **4,544/4,544** new
axis-family differential cases (4,320 accepted, 224 deliberately rejected),
including per-element content, dimensions, concrete DTypes and byte strides
for nonempty inputs. Noncontiguous transposes, negative strides, zero sizes,
0-D scalar behavior, write-through aliasing, ownership after garbage
collection, temporal and Unicode descriptors, and invalid axes were tested.
All previous 46 generated differential suites still pass, yielding
**32,566/32,566 cases across 47 suites**. ASan+UBSan validation covers
native C modules and the Lua adapter, except for an uninstrumented reused
PocketFFT object; this is **not** an all-object sanitizer claim.
The 2.5.3 archive was used as source reference, not a runnable 2.5.3 oracle.


## Broadcasting and shared-storage views (0.33.0-dev)

LuaRay now implements NumPy's `broadcast_to`, `broadcast_arrays`, and
`broadcast_shapes` in native C. Broadcasting changes shape/stride metadata
without allocating or copying an expanded element buffer. The returned view
retains an owning reference to its input allocation. Broadcasting a dimension
of length one uses a **zero byte stride**, while already-shaped inputs to
`broadcast_arrays` retain their original strides, including noncontiguous
layouts. Unlike `broadcast_to`, `broadcast_arrays` follows the NumPy 2.5.3
source's compatibility path and retains input writeability (unless the input
is already readonly); writing to the repeated zero-stride cells can modify
multiple logical positions at once. Be cautious with this behavior.

```lua
local np = require('luaray')
local row = np.array({10, 20, 30}, 'float64')
local matrix = np.broadcast_to(row, {4, 3})
assert(matrix:get(4, 2) == 20)
assert(matrix.strides[1] == 0)
assert(not pcall(function() matrix:set(90, 1, 1) end)) -- readonly view

local parts = np.broadcast_arrays(
    np.array({{1}, {2}}, 'float64'), np.array({10, 20, 30}, 'float64'))
assert(parts[1].shape[1] == 2 and parts[1].shape[2] == 3)
local output_shape = np.broadcast_shapes({2, 1}, {1, 3}) -- {2, 3}
```

`broadcast_to(value, shape)` accepts a LuaRay ndarray or a value convertible
by the native `array` constructor, plus a shape as a Lua table of dimensions
(or a single integer for a 1-D shape). `broadcast_arrays(a, b, ...)` accepts
up to 64 arrays/array-like inputs and returns a Lua table of views;
`broadcast_shapes(shape1, ...)` returns a Lua table of dimensions. Normal
Lua indexing remains 1-based; shape dimensions are counts rather than indices.

**Verification:** 3,077 generated NumPy 2.3.5 oracle cases: 1,034 successful
comparisons and 2,043 correctly rejected inputs, covering scalar/empty/zero
axes, negative and transposed strides, `int32`, `float64`, `bool`, Unicode,
multiple-array shape inference and rejection cases. A separate Lua regression
checks read-only behavior, ownership after garbage collection, write-through,
shape overflow, and temporal descriptors. All 47 earlier suites also pass,
for **35,643/35,643 across 48 suites**. ASan/UBSan instruments the two
modified C translation units (`ln_axis.c`, `lua_module.c`); unchanged objects
including PocketFFT remain uninstrumented, so an all-object sanitizer pass
is not claimed. NumPy 2.5.3 source hashes appear in
`NUMPY_2_5_3_BROADCAST_FILE_HASHES.sha256`. The executable reference was the
locally installed NumPy 2.3.5, not a compiled NumPy 2.5.3.


## Repeated copies: `tile` and `repeat` (0.34.0-dev)

LuaRay 0.34 adds two host-neutral C implementations (`src/ln_repeat.[ch]`),
without invoking CPython, NumPy, or a Python subprocess:

```lua
local np = require('luaray')
local a = np.array({10, 20, 30}, 'int32')
local tiled = np.tile(a, {2, 1})      -- {{10,20,30},{10,20,30}}
local repeated = np.repeat_elements(a, {1, 0, 3}) -- {10,30,30,30}
local by_axis = np.repeat_elements(np.reshape(np.arange(6), {2, 3}), 2, 2)
-- NumPy's exact symbol is available as np["repeat"](a, counts, axis).
-- Lua reserves the keyword `repeat`, so `np.repeat(a, ...)` is not valid Lua.
```

`tile(a, repetitions)` takes a scalar integer or a Lua table of integer
counts (also an integer ndarray). `repeat_elements(a, repetitions, axis)`
takes a scalar count or per-element counts. The optional `axis` uses **Lua
1-based positive indexing** and NumPy-compatible negative axes. Omitting it
(or passing `false`) flattens in C order; a scalar input can be repeated as a
1-D result. Both functions allocate new independently writable arrays and
copy exact DType payloads (including `float16`, complex, Unicode and temporal
metadata); unlike `broadcast_to`, they are **not** zero-copy. Already-F-only
contiguous arrays retain Fortran order when `tile` only copies once.

The copy kernels check shape/count overflow before allocation and support
empty dimensions, non-contiguous/transposed arrays, negative strides and
zero-stride broadcast views. The Lua adapter accepts float counts in `repeat`
when NumPy's scalar/sequence conversion does; integer-typed ndarray repeat
counts obey the more restrictive ndarray casting rules. The implementation
is a fixed-size-DType subset, not support for NumPy object arrays or arbitrary
Python extension DTypes.

**Validation:** 8,030 new frozen cases compared with NumPy 2.3.5: 7,176
successful output matches and 854 input rejections; compare shape, values,
concrete DType and byte strides for nonempty arrays. All 48 previous
suites passed as well, giving **43,673/43,673 cases across 49 suites**.
Native C tests, Lua regression, `make full-test`, and directed ASan/UBSan
runs of `ln_repeat.c` plus the Lua adapter passed. Existing unchanged
objects (including PocketFFT) were linked but not re-instrumented.
The full `make oracle-test` regeneration run exceeded the execution window;
all 49 frozen/generated test files were executed separately and passed.
Source fingerprints from the supplied NumPy 2.5.3 archive are in
`NUMPY_2_5_3_REPEAT_FILE_HASHES.sha256`.

## Minimum-dimensional views (0.36.0-dev)

`np.atleast_1d`, `np.atleast_2d` and `np.atleast_3d` promote input
scalars, Lua tables, and ndarrays to the requested minimum rank **without
copying existing ndarray storage**:

```lua
local np = require('luaray')
local a = np.array({10, 20, 30}, 'int32')
local row = np.atleast_2d(a)    -- (1, 3); strides (0, 4)
local volume = np.atleast_3d(a) -- (1, 3, 1); strides (0, 4, 0)
row:set(77, 1, 2)
assert(a[2] == 77)             -- shared storage
local list = np.atleast_2d(5, a) -- returns a Lua table of two arrays
assert(#list == 2)
```

For a single argument the result is an ndarray; with zero or multiple
arguments it is a Lua array-table of ndarray results, matching NumPy's
single-vs-sequence policy. Scalar reshapes retain element-size byte strides;
newaxis insertions into non-scalar arrays have zero strides. Source DType,
negative and transposed strides, writeability and owner lifetime are retained.
As with the rest of LuaRay, axes and indices are 1-based in the Lua surface.

This release also fixes a constructor discovery edge case: an empty Lua table
without an explicit DType now defaults to `float64`, matching NumPy, rather
than incorrectly selecting `bool`.

The differential oracle adds **483 comparisons** with NumPy 2.3.5, covering
four explicit DTypes, 0–4 dimensions, empty/scalar arrays, negative and
transposed strides, scalar/table inputs and variadic calls. **51/51 suites
and 64,801/64,801 cumulative cases** passed, as did the new native C and
Lua regression tests. Directed ASan/UBSan instrumented the changed C axis
implementation and Lua adapter plus the native test; unchanged objects
(including PocketFFT) remained uninstrumented. The NumPy 2.5.3 reference
source SHA-256 hashes are recorded in
`NUMPY_2_5_3_ATLEAST_FILE_HASHES.sha256`.

## Rolling arrays (0.35.0-dev)

Two operations from `numpy/_core/numeric.py` in the supplied **NumPy 2.5.3**
source archive are implemented in native C (`src/ln_roll.[ch]` and
`src/ln_axis.c` via the Lua adapter):

```lua
local np = require('luaray')
local a = np.reshape(np.arange(12, 'int32'), {3, 4})
local moved = np.roll(a, 1, 2)     -- shift each row right by one
local rotated = np.roll(a, {1, -2}, {1, 2})  -- positive axes are 1-based
local view = np.rollaxis(a, 2, 1) -- swap row and column axes, no copy
assert(moved:get(1, 1) == 3)
assert(view.shape[1] == 4 and view.shape[2] == 3)
```

`np.roll(a, shift, axis)` preserves the concrete DType and produces an
independently owned ndarray, even for shift zero. The optional axis omitted,
`nil` or `false` means C-order flattening before rolling and then restoring
the input shape. Positive axes and insertion boundaries are 1-based, and
negative axes count from the end. Shift may be an integer, boolean, finite
floating scalar (truncated like NumPy), Lua table, or 0/1-D numeric ndarray;
axis can be an integer or Lua sequence. Repeated axes sum their shifts modulo
axis length. Non-contiguous arrays, C/F order, permutations, negative strides,
zero-sized dimensions and Unicode/temporal metadata are preserved as values.
`rollaxis` returns a shared-storage view (like NumPy), not a copy.

Compatibility limits: LuaRay's public axis convention differs from Python's
0-based convention; uint64 ndarray shift counts are currently rejected instead
of silently narrowing values beyond signed int64. Multidimensional shift
arrays and object-DType payloads are not supported in this API subset.

**Validation:** `tools/generate_roll_differential.py` freezes **20,645**
NumPy 2.3.5 comparisons (**18,230** valid and **2,415** rejected cases).
All **49** historical suites remain green; **64,318/64,318** cases pass
across **50** suites, plus C-native roll tests and Lua regressions. Targeted
ASan+UBSan instrumented `src/ln_roll.c`, `src/lua_module.c`, and the native
roll harness; it passed regression and differential tests. Unchanged
translation units including PocketFFT were linked uninstrumented.
The exact NumPy 2.5.3 source fingerprints are recorded in
`NUMPY_2_5_3_ROLL_FILE_HASHES.sha256`.

## Shape-aware convenience stacking (0.37.0-dev)

LuaRay now provides `np.hstack`, `np.vstack`, `np.row_stack`,
`np.dstack` and `np.column_stack`. They are native Lua/C operations built
on the existing `ln_axis` rank-adjustment views and `ln_join` array
copy/casting engine; NumPy and Python are **not** required at runtime.

```lua
local np = require('luaray')
local a = np.array({1, 2, 3}, 'int16')
local b = np.array({4, 5, 6}, 'int16')
assert(np.hstack({a, b}).size == 6)
local columns = np.column_stack({a, b}) -- shape {3,2}
assert(columns:get(2, 2) == 5)
local rows = np.vstack({a, b})           -- shape {2,3}
local pages = np.dstack({a, b})           -- shape {1,3,2}
```

Each call accepts one **Lua sequence** containing arrays, nested Lua
tables or scalars. For `hstack` 0-D inputs first become 1-D, and the
concatenation axis is 1 for vectors or 2 for higher-rank inputs; for
`vstack`/`row_stack` inputs become at least 2-D and concatenate on axis
1; `dstack` uses at least 3-D arrays and axis 3; `column_stack` turns
1-D inputs into column vectors before axis-2 concatenation. All public
axis labels are Lua-style (1-based) but results follow NumPy's shapes.
The final array is an independently owned copy. Concrete DType metadata,
transposed/negative-stride source views and empty dimensions are
preserved during transfer. `hstack`, `vstack` and deprecated NumPy alias
`row_stack` accept a second Lua options table (`dtype`, `casting`);
`dstack` and `column_stack` do not accept it (as in NumPy 2.3/2.5).

**Validation:** 2,875 new frozen NumPy 2.3.5 comparisons (1,219 successful
outputs and 1,656 expected invalid-input rejections), alongside native
core tests, Lua regression, all 51 previous differential suites and the
new suite: **52/52 suites, 67,676/67,676 cases**. Directed ASan/UBSan
of `lua_module.c`, `ln_axis.c` and `ln_join.c` passed; other native
objects were linked uninstrumented. Existing numeric-to-Unicode DType
promotion is not yet supported by the shared concatenation core; cross-
family cases of that form are not included in the passing comparison
count. Reference source checksums are recorded in
`NUMPY_2_5_3_SHAPE_STACK_FILE_HASHES.sha256`.


## Copy-producing array editing (0.38.0-dev)

LuaRay implements `np.append(arr, values, axis)` and `np.delete(arr, obj, axis)`
without Python or NumPy at runtime. Both create new, independent native
arrays. As elsewhere in LuaRay, explicit axes and integer element positions
are **1-based**; negative element positions count from the end.

```lua
local np = require('luaray')
local a = np.array({10, 20, 30, 40}, 'int16')
assert(np.append(a, {50, 60}):tolist()[6] == 60)
assert(np.delete(a, {2, 4}):tolist()[2] == 30)
assert(np.delete(a, np.slice(2, 4)):tolist()[2] == 40)
assert(np.delete(a, {false, true, false, true}):tolist()[2] == 30)
```

`append` delegates copying, dtype promotion and conversion to the existing
native `ln_join_arrays` kernel. If `axis` is omitted or `nil`, both inputs
are concatenated in flattened C order; an explicit axis must be compatible
with the ranks/shapes of both arguments. As in NumPy, `append` does **not**
modify its input.

`delete` has a dedicated C kernel (`src/ln_delete.c`) that preserves the
source DType descriptor and copies from arbitrary positive, negative and
transposed strides. It supports integer scalar indices, Lua integer
sequences, 1-D integer index ndarrays, full-length boolean masks (Lua
tables or boolean ndarrays), and `np.slice(start, stop, step)` tokens. The
slice uses half-open bounds; positive bounds are 1-based, including the
exclusive `stop`. When `axis` is `nil`, deletion is performed on the
C-order-flattened source, returning a 1-D result. Repeated positions are
removed only once; invalid axes, positions or mask lengths raise an error.

The subset is tested for values, shape and dtype. **Exact output memory order
and strides of NumPy's advanced-index `delete` cases are not yet reproduced**;
outputs currently use C-contiguous storage. Structured/object/custom DTypes
are not yet supported. The shared join kernel retains its pre-existing
cross-family numeric↔Unicode promotion limitation, also affecting `append`.

The fixture generator `tools/generate_append_delete_differential.py` uses an
installed NumPy executable **only at development/test time**. NumPy 2.5.3
sources (`numpy/lib/_function_base_impl.py` and its tests) were inspected as
code reference and pinned in `NUMPY_2_5_3_APPEND_DELETE_FILE_HASHES.sha256`.


## Native array insertion (0.39.0-dev)

`np.insert(array, positions, values, axis=nil)` completes LuaRay's
`append`/`delete`/`insert` manipulation group. The new implementation is a
host-independent C kernel (`src/ln_insert.c`) plus Lua 5.4 argument handling,
with **no Python dependency at runtime**.

```lua
local np = require('luaray')
local a = np.array({10, 20, 30}, 'int32')
assert(np.insert(a, 2, 99):tolist()[2] == 99)
assert(np.insert(a, {2, 2}, {7, 8}):tolist()[3] == 8)
assert(np.insert(a, 4, {40, 50}):tolist()[5] == 50)
```

Positive insertion positions start at **1**; `N+1` denotes the end of the
axis. Negative positions count from the end. Unlike ordinary indexing,
`N+1` is a valid insertion position. The axis argument follows the same
one-based convention. With no explicit axis the input is traversed in
C-order and output is one-dimensional. NumPy-compatible positions may be a
scalar integer, integer table, one-dimensional integer ndarray, boolean
mask ndarray, boolean table or `np.slice(...)`. A 0-D integer ndarray behaves
as a scalar index. Slices retain LuaRay's one-based half-open endpoints.

Insertion positions are stable when repeated or unsorted. As in NumPy,
`positions=2` and `positions={2}` differ in multidimensional insertion:
the scalar path moves the leading value dimension into the insertion axis,
while the sequence path preserves value dimension order. A sequence with
exactly one position can still insert more than one value.

The operation returns an independent result and accepts non-contiguous,
reversed and transposed source arrays, including zero-size arrays. It
preserves the source's concrete DType and casts inserted numeric values
into that DType. Same-kind fixed-width Unicode/byte-string insertion
handles width changes and padding.

Known differences: outputs currently use **C-contiguous** storage instead
of inheriting NumPy's F-order allocation for certain inputs; some value-dependent
string/numeric formatting cases, object/structured/custom DTypes, large-rank values
exceeding the source rank, and some historical NumPy quirks involving
negative insertion positions on empty axes are not yet covered. DType
transfer is limited to the native transfer implementations available.
Boolean Lua tables are accepted as masks even though the installed NumPy
2.3.5 oracle raises an exception on plain Python boolean lists; boolean
NumPy *ndarrays* are compared directly in the oracle suite.

The generator `tools/generate_insert_differential.py` freezes **10,256**
comparisons against **NumPy 2.3.5** (9,102 valid results; 1,154 invalid
inputs). Expected values, shapes and DTypes are compared, not byte strides.
NumPy **2.5.3** source was inspected as the implementation reference and
pinned in `NUMPY_2_5_3_INSERT_FILE_HASHES.sha256`.

## Core consolidation (0.40.0-dev)

No additional public NumPy function is claimed for this milestone. This update
repairs legacy builtin numeric + `S<n>` / `U<n>` common-DType discovery. The
resulting width is `max(string width, numeric type's worst-case formatted
width)`, so mixed `concatenate`, `stack` and other common-DType consumers no
longer reject that supported combination. The original C-native formatting
and strided transfer paths are reused; NumPy's arbitrary custom/object DTypes
and exact formatting for all exotic floating-point values remain outside the
port's tested scope. Temporal/text automatic promotion is still rejected.

The bounded broadcast-shape diagnostic builder was also hardened for rank-64
incompatible shapes, preventing out-of-bounds pointer arithmetic in error
formatting. Tests cover this path at the native C level.

`make full-test` now runs **all checked-in differential suites** through
`make fixture-test`, not only the ten recent suites. The fixture target needs
only the compiled LuaRay runner and checked-in Lua oracles; it does **not**
require NumPy or Python. `make oracle-test` still regenerates selected fixtures
with development-time Python/NumPy, and remains a distinct heavier command.

The new `tools/generate_promotion_differential.py` produced **2,020 NumPy 2.3.5
oracle comparisons** (2,016 valid numeric/string operations and four expected
temporal/text rejections), across multiple DTypes, ranks, axis selections,
and operand orders. The checked-in `tests/promotion_differential_generated.lua`
can run independently without Python.

## Statistical variance and standard deviation (0.41.0-dev)

`np.var(a, {axis=2, ddof=1})` and `np.std(a, {axis={1,3}, keepdims=true})`
use the native `ln_stats.c` kernel. For ndarray inputs, `a:var(...)`
and `a:std(...)` are also available. The argument `axis` follows LuaRay's
**one-based** convention; an empty axis table requests no reduction.

The implementation calculates the mean and squared deviations in two passes,
respects arbitrarily strided input/output arrays, broadcasts `where` masks,
and only commits into `out` after the input has been fully read. Numeric
integers and booleans accumulate to float64 by default; float and complex
inputs preserve their corresponding floating output precision, with complex
variance returning a real result. An explicit complex computation DType is
supported. `ddof` or `correction` can be fractional; specifying both is an
error. Empty/insufficient slices propagate NaN/Inf as applicable.

**Compatibility limits:** intermediate arithmetic uses float64/complex128
rather than reproducing each intermediate NumPy float16/float32 rounding
operation. Differential tests therefore use a documented relative tolerance
(5e-3 for float16 inputs; 5e-4 otherwise). Higher-precision edge cases,
complex256 precision parity, and exact NumPy output memory ordering remain
unverified. An explicit integral `dtype` is **rejected**, because NumPy's
integer-accumulator truncation semantics are not yet implemented; implicit
integer/bool input promotion works. The NumPy 2.5.3 `mean=` optimization
parameter is not implemented yet and is explicitly rejected rather than
silently ignored.

`tools/generate_stats_differential.py` generates **1,600** NumPy **2.3.5**
oracle comparisons in `tests/stats_differential_generated.lua`, including
scalars, empty shapes, complex arrays, masks, `keepdims`, multi-axis reductions,
fractional `ddof`, and DTypes. Separate `tests/stats_regression.lua` covers
transposed/negative-stride sources, noncontiguous `out`, buffer aliasing,
broadcast `where`, and invalid calls. NumPy **2.5.3** source reference is
pinned in `NUMPY_2_5_3_STATS_FILE_HASHES.sha256`.


## DType-preserving minimum and maximum (0.42.0-dev)

`np.min` / `np.amin` and `np.max` / `np.amax` are implemented directly
in the native `ln_stats.c` reduction kernel. `a:min()`, `a:amin()`,
`a:max()` and `a:amax()` are available on ndarray userdata.

```lua
local np = require("luaray")
local a = np.array({{3, 1, 9}, {-2, 5, 4}}, np.int64)
assert(np.min(a) == -2)
assert(np.max(a) == 9)
assert(np.amin(a, {axis = 1}):tolist()[1] == -2) -- Lua-based axis
assert(np.max(a, {axis = 2, keepdims = true}).shape[2] == 1)
local masked = np.min(a, {where = np.array({{true,false,true},
                                              {true,false,true}}, np.bool),
                          initial = 100})
assert(masked == -2)
```

The native C implementation preserves the source numeric DType (bool,
integer, unsigned integer, float16/32/64/longdouble, and complex), operates
on strided views and broadcast boolean masks, and supports `initial`,
`keepdims`, empty outputs, no-reduction `axis={}`, and `out` with staged
writeback to protect overlapping inputs. Floating NaNs propagate, complex
values are compared lexicographically, and signed-zero ties preserve the
last operand's sign. LuaRay axes remain **one-based**.

**Current limits:** legacy string, Unicode, datetime/timedelta and custom
DTypes are not yet handled by these extrema reductions. Complex-valued
`initial` arguments are not implemented; real numeric/boolean `initial` is.
Out-of-range integer `initial` values are rejected for integer DTypes.
Exact output memory-layout parity for all special strides has not been
established. These limitations are explicit rather than silently replacing
NumPy's behavior.

`tools/generate_extrema_differential.py` produces 2,400 cases from executable
NumPy **2.3.5**: 1,838 successful output comparisons (DType, shape and values)
and 562 expected errors. The tests include masks, empty arrays, NaNs,
complex values, many axes and `keepdims`; direct Lua/C regression tests
cover aliasing, noncontiguous `out`, and signed zero. NumPy **2.5.3** source
files are hash-pinned in `NUMPY_2_5_3_EXTREMA_FILE_HASHES.sha256`.

## Arg extrema and peak-to-peak (0.43.0-dev)

`argmin` and `argmax` operate on the logical C-order flattened array by
 default, or over one selected axis, with `keepdims` and integer `out`.
Indices are **one-based** throughout the Lua-facing API: NumPy output `0`
corresponds to LuaRay output `1`. Their returned dtype is native pointer-width
signed integer. First ties win, including the first NaN; input strides can
be positive, negative or transposed. Python/NumPy is not used at runtime.

`ptp` produces `amax - amin` with source DType semantics and supports
multiple axes, `keepdims` and overlap-safe `out`. Boolean subtraction is
rejected, as with NumPy. Signed small-integer outputs can wrap: users should
cast to a wider DType before `ptp` to avoid that wrap.

```lua
local np = require('luaray_core')
local x = np.array({{3,1,9},{-2,5,4}}, np.int64)
assert(np.argmin(x) == 4)  -- one-based flat index
assert(np.argmax(x) == 3)
assert(np.ptp(x) == 11)
```

NumPy 2.5.3 source reference: `_core/fromnumeric.py`, `_core/_methods.py`,
`_core/src/multiarray/calculation.c` and test sources, pinned in
`NUMPY_2_5_3_SELECTION_FILE_HASHES.sha256`. The local executable oracle
is NumPy 2.3.5. `tools/generate_selection_differential.py` regenerates
9,360 deterministic comparisons (7,308 successful outputs, 2,052 rejected
inputs); no Python is needed to execute the stored Lua fixture.

Limitations: text, datetime and custom DTypes are not yet supported by these
three reductions. Only a single axis is accepted for `argmin`/`argmax`,
matching NumPy; `ptp` supports the tuple-of-axes equivalent through Lua
axis tables. Exact NumPy memory-layout choices and every specialized `out`
casting variation have not been established. `ptp` inherits the existing
numeric reduction and subtraction behavior of the LuaRay kernel.

## LuaRay 0.44 example — quantiles (native C)

```lua
local np = require('luaray_core')
local a = np.array({{1, 4, 7}, {2, 5, 8}}, np.float64)
local med = np.median(a, {axis=2}) -- ndarray [4, 5]
local pct = np.percentile(a, {25, 50, 75}, {axis=1})
local q = np.quantile(a, 0.5, {method='lower'})
```

Inputs use LuaRay's **1-based** axis convention. The built-in NumPy fixture
requires Python for generating oracles, not at runtime. NumPy 2.5.3 is the
source reference and NumPy 2.3.5 was the executable comparator. `q` must be
scalar or a nonempty one-dimensional Lua list / ndarray. `method` is
supported on `quantile` and `percentile`, not on `median`. Quantile result
DTypes depend on q's scalar/list/DType form, as with NumPy; NumPy-equivalent
edge cases outside the tested subset remain future work.

## LuaRay 0.47 — NaN-aware extrema

Native C functions `nanmin`, `nanmax`, `nanargmin`, and `nanargmax`
are available on the module and on ndarray instances. NaNs are skipped
per reduction slice; all-NaN slices return NaN for `nanmin`/`nanmax`
and error for `nanargmin`/`nanargmax`. As everywhere in LuaRay, returned
indices are **one-based**, unlike NumPy. `nanptp` is not a NumPy 2.3.5 API
and is deliberately not exposed.

```lua
local np = require('luaray_core')
local a = np.array({3, 0/0, 1}, np.float64)
assert(np.nanmin(a) == 1)
assert(np.nanargmax(a) == 1) -- LuaRay one-based index
```


## 0.56 — gumbel, logistic, rayleigh, weibull

Four additional native C distributions are exposed on a PCG64 Generator:
`rng:gumbel(loc, scale, size)`, `rng:logistic(loc, scale, size)`,
`rng:rayleigh(scale, size)`, and `rng:weibull(a, size)`. Default
parameters match NumPy (0,1 for Gumbel and logistic; 1 for Rayleigh
and Weibull). Scalars and arbitrary Lua shape tables are supported, with
`float64` ndarray results. Parameters are scalar only.

These functions reproduce the NumPy 2.5.3 *source algorithms*, including
rejecting special uniform draws for Gumbel/logistic and not advancing PCG64
for Weibull shape zero. Negative scale/shape errors are rejected before
consumption. `rayleigh`/`weibull` allow NaN arguments as NumPy does.

`make distributions56-test` executes the native C sampler test, Lua
regressions, a **25,124-comparison** fixture frozen from NumPy 2.3.5,
and the literal runnable example in `examples/random_distributions56.lua`.
`make full-test` additionally runs all historical suites. The differential
fixture checks both values (exact double comparison, treating NaNs
semantically) and subsequent PCG64 state. Because the exact generated
values depend on platform libm, bitwise compatibility across arbitrary
platforms is not guaranteed. NumPy is not required at LuaRay runtime.


## 0.57 — Pareto II, power and triangular distributions

Adds native C samplers with scalar parameters: `rng:pareto(a, size)`,
`rng:power(a, size)` and `rng:triangular(left, mode, right, size)`.
Pareto and power consume NumPy's standard-exponential Ziggurat sampler,
not an alternate uniform transformation. Triangular uses the same single
uniform draw and branch as NumPy. Values and the following PCG64 word were
compared **exactly** for 19,362 oracle checks against executable NumPy 2.3.5.
The generator exercises scalar, 0D, empty, multidimensional and long
mixed-distribution runs. Rejected parameters leave PCG64 unchanged.

Use `make distributions57-test` to run native C assertions, Lua regression,
NumPy differential fixture and the literal example
`examples/random_distributions57.lua`. The complete `make full-test` runs
70 checked-in differential fixture files, including all 69 preceding suites.
A directed ASan/UBSan run with leak detection passed on the changed random
core, Lua adapter, native test and new differential fixture; other native
components were linked without instrumentation. Validation is not a proof
against all memory faults.

**Limitations:** all shape/distribution arguments are scalars, except `size`;
parameter broadcasting is not supported. The current Lua API uses 1-based
array indexing and supports Lua numeric arguments; exact floating-point
results may vary across platforms with different math libraries. NumPy 2.5.3
was the inspected source reference, while NumPy 2.3.5 was the executable oracle.


## 0.58 — native Gamma / Beta families

- `rng:standard_gamma(shape, size=nil, dtype="float64")`: native shape-based gamma;
  supports `float64` and the independently sampled `float32` path.
- `rng:gamma(shape, scale=1, size=nil)`: native scaled gamma, `float64` output.
- `rng:beta(a, b, size=nil)`: native beta, including Johnk rejection for
  small parameters, Marsaglia-Tsang gamma paths and the tiny-shape branch.

The new `make distributions58-test` validates both native C and Lua execution,
including `examples/random_distributions58.lua` run **literally**. The
replayable NumPy oracle includes 51,886 comparisons across eight seeds,
multidimensional and empty shapes, long interleaved PCG64 streams and
invalid arguments. Double-precision results and observable PCG64 state are
compared exactly; `standard_gamma(float32)` values are compared with a
**relative tolerance of 3e-5** (minimum absolute tolerance 3e-12), while
PCG64 state remains exact. Platform libm differences may affect rounding.

Limitations: scalar distribution parameters only; no parameter broadcasting;
NumPy's positive-infinity parameter handling is not supported and explicitly
rejected instead of looping. No complex or arbitrary-precision parameters.
`standard_gamma` returns a Lua number for scalar output, so its float32
scalar cannot carry a NumPy-style dtype tag. Reference code was NumPy 2.5.3;
executed oracle was NumPy 2.3.5. No Python is required at runtime.

## 0.59 — PCG64 chi-square and Fisher-Snedecor F

The NumPy 2.5.3 scalar implementations of `random_chisquare` and `random_f`
are now available in native C as `rng:chisquare(df, size=nil)` and
`rng:f(dfnum, dfden, size=nil)`. Both sample `float64` and support nil,
integer and Lua table sizes, including 0-dimensional and empty shapes.
The chi-square sampler computes `2 * standard_gamma(df/2)`; the F sampler
combines **two consecutive** chi-square draws using the original NumPy
multiplication/division order, preserving the PCG64 stream.

```lua
local np = require('luaray_core')
local rng = np.random.default_rng(42)
local chi = rng:chisquare(4, {2, 3})
local fisher = rng:f(5, 10, {2, 3})
```

The example above is executed literally by `make distributions59-test` from
`examples/random_distributions59.lua`. The new independent oracle generator
is `tools/generate_distributions59_differential.py` and the checked-in fixture
contains **36,792 exact comparisons** against executable NumPy 2.3.5:
output values, shapes, dtypes, and the next raw PCG64 word are checked.
`make full-test` executes **72 differential fixture files** (71 historical).
Source code reference: NumPy 2.5.3 `random/src/distributions/distributions.c`
and `random/_generator.pyx`, hashes recorded in
`NUMPY_2_5_3_DISTRIBUTIONS59_FILE_HASHES.sha256`.

**Limitations:** only positive, finite scalar degrees of freedom; NumPy may
accept some non-finite parameters that are deliberately rejected here.
Vectorized parameter broadcasting is not implemented. Exact floating-point
agreement was observed on the test platform, not guaranteed across libm
implementations. NumPy is not required to run LuaRay.


## 0.60 — noncentral chi-square and noncentral Fisher F

LuaRay adds the native NumPy-style `Generator` methods
`noncentral_chisquare(df, nonc, size=nil)` and
`noncentral_f(dfnum, dfden, nonc, size=nil)`.  They preserve
PCG64 consumption order.  The chi-square sampler uses a shifted standard
normal above df=1 and a Poisson/chi-square mixture at df<=1.  Poisson uses
NumPy's multiplicative algorithm below intensity 10 and Hoermann PTRS
at higher intensity; both require zero Python code at runtime.

The checked-in `tools/generate_distributions60_differential.py` produces
12,728 exact reference comparisons with NumPy 2.3.5 (eight seeds, multiple
shapes, empty outputs, df=1 threshold, Poisson branch threshold, interleaved
samples, and observable PCG64 state). The reference C source is NumPy 2.5.3.
Use `make distributions60-test` or `make full-test` (now 73 fixture suites).
`examples/random_distributions60.lua` was executed literally.

Conservative limitations: finite positive scalar degrees of freedom,
finite scalar noncentrality 0 to 1e12, no broadcasting of distribution
parameters, no NaN/Inf noncentrality (NumPy accepts some). Exact double
comparisons apply to the test environment and are not guaranteed across libm
implementations. `noncentral_f` and `noncentral_chisquare` are not the same
as the central distributions, except when nonc=0.

## 0.61.0-dev — public Poisson distribution

`rng:poisson(lam, size)` samples Poisson-distributed `int64` values. `lam`
may be omitted (default 1). The result is a Lua integer when `size` is
omitted and a native `int64` ndarray when `size` is present (including `{}`
for a zero-dimensional ndarray). LuaRay reuses the PCG64 Poisson kernels
ported in 0.60, with multiplicative sampling for `lam < 10` and PTRS rejection
for `lam >= 10`. `lam = 0` returns zeros without consuming the generator state.

```lua
local np = require("luaray_core")
local rng = np.random.default_rng(42)
local daily = rng:poisson(4, {2, 3})
local peak = rng:poisson(25)
```

Validation: `make distributions61-test` checks a native C test, the independent
NumPy 2.3.5 differential fixture (8,492 exact checks), Lua regressions and an
example executed literally. `make full-test` also runs all 74 accumulated
fixtures. The test generator lives at
`tools/generate_distributions61_differential.py` and requires NumPy only to
*regenerate the oracle*, never at LuaRay runtime.

Scope: scalar, finite `0 <= lam <= 1e12`; array-valued/broadcasting `lam`,
non-finite intensities and higher intensities are not yet supported.
Cross-platform bitwise identity of all floating-point rejection paths is not
claimed. See `UPSTREAM.md` and `TEST_RESULTS.md`.

## 0.62.0-dev — NumPy-compatible Binomial generator

`rng:binomial(n, p, size=nil)` draws native `int64` binomial samples. A scalar
result is returned as a Lua integer when `size` is omitted; otherwise the
result is an `int64` `ndarray` with the requested shape, including `size={}`
for a zero-dimensional array.

The native implementation ports NumPy 2.5.3's **inversion** and **BTPE**
(Kachitvichyanukul–Schmeiser) sampling algorithms, including the branch at
`min(p,1-p)*n <= 30`. It preserves sample results and observed PCG64 bit
consumption for the validated inputs. The bundled NumPy license applies to
adapted upstream C source. Source checksums are recorded in
`NUMPY_2_5_3_BINOMIAL_FILE_HASHES.sha256`.

```lua
local np=require("luaray_core")
local rng=np.random.default_rng(42)
local outcomes=rng:binomial(20,0.35,{2,3})
```

Run `make distributions62-test` for native C tests, Lua regression, the
NumPy 2.3.5 differential oracle (41,342 exact comparisons), and the literal
example in `examples/random_distributions62.lua`. Run `make full-test` for
all 75 accumulated differential fixtures. The fixture can be regenerated with
`python tools/generate_distributions62_differential.py` if NumPy is installed;
NumPy/Python is **not** needed to build or execute LuaRay.

**Scope limitations:** `n` must be a Lua integer in `[0,1e12]`; `p` must be a
finite scalar in `[0,1]`. Array-valued parameters, very large trial counts,
nonintegral trial arguments and structured/object DTypes are not supported.
This version does not guarantee bit-for-bit equivalence across different
platform math libraries.

## 0.64.0-dev — Native negative binomial (Gamma–Poisson)

`rng:negative_binomial(n, p, size=nil)` reproduces the NumPy 2.5.3
Gamma–Poisson mixture. It accepts positive **fractional** shape parameters,
probabilities in the documented supported range, and returns `int64` results.
As in NumPy, the `p=1` case still invokes the Gamma sampler before Poisson,
so the PCG64 bit stream advances even when the returned value is zero.

```lua
local np=require('luaray_core')
local rng=np.random.default_rng(42)
local failures=rng:negative_binomial(5,0.35,{2,3})
local waiting=rng:negative_binomial(2.5,0.7,{4})
```

The exact literal example with shape checks is
`examples/random_distributions63.lua`. Run `make distributions63-test`
for native C, regression, NumPy 2.3.5 oracle (**19,980 exact comparisons**)
and example; `make full-test` checks all **76 differential fixture files**.
The C test independently checks **64,000** deterministic outputs.
Upstream source SHA-256 values are pinned in
`NUMPY_2_5_3_NEGATIVE_BINOMIAL_FILE_HASHES.sha256`.
Python is needed only to *regenerate* the fixture, not to build or run LuaRay.

**Current scope:** `n` must be a finite scalar in `(0,1e6]`, `p` must be a
finite scalar in `[0.001,1]`. NumPy accepts some values outside these
bounds, but LuaRay deliberately rejects them to guard its signed-integer
Poisson implementation. No broadcasting of parameters yet. Exact results
and PCG64 state were checked on this machine; other platforms' libm
rounding may differ. All validation counts refer to tested inputs rather
than full NumPy semantics or ABI equivalence.

## 0.64.0-dev — NumPy-compatible geometric distribution

`np.random.default_rng(seed):geometric(p, size)` produces native `int64`
geometric samples (number of Bernoulli trials until the first success).
The implementation ports NumPy 2.5.3's two sampling paths: direct search
for `p >= 1/3` and standard-exponential inversion for `p < 1/3`, including
PCG64 state consumption when `p=1`. `p` must be a finite scalar in `(0,1]`.
`size` is optional and may describe arbitrary dimensions including empty
ones. Results with explicit size are arrays; omitted size returns a Lua
integer. Parameter broadcasting remains unimplemented.

`make distributions64-test` runs the native test, Lua regression, 7,280
exact NumPy 2.3.5 differential checks and the literal executable example
`examples/random_distributions64.lua`. `make full-test` covers 77 checked-in
differential suites including the previous 76. Oracle fixture can be regenerated
by `python tests/generate_distributions64_oracle.py` (Python/NumPy needed only
for generating validation data, never for the LuaRay runtime).

NumPy 2.5.3 release source is pinned in
`NUMPY_2_5_3_GEOMETRIC_FILE_HASHES.sha256`. Cross-platform exact `libm`
rounding is not guaranteed.


## 0.65.0-dev — NumPy-compatible Zipf distribution

`rng:zipf(a, size)` generates native signed 64-bit samples from Zipf's
zeta distribution using the rejection sampler in NumPy 2.5.3. Scalar
`a` must satisfy `a > 1` and must not be NaN; `+inf` is supported and
returns one without advancing PCG64. NumPy's `a >= 1025` fast path
also returns one without consuming random state. Omitted `size` yields a
Lua integer; `size={}` yields a zero-dimensional `int64` ndarray; shapes
containing zero dimensions produce empty ndarrays without consuming bits.

```lua
local np = require('luaray_core')
local rng = np.random.default_rng(42)
local frequencies = rng:zipf(2.0, {2, 3})
local sample = rng:zipf(4.0)
```

The entire executable example is included in
`examples/random_distributions65.lua` and has been executed literally.
Run `make distributions65-test` for native C validation, Lua regressions,
**11,336** exact NumPy 2.3.5 oracle checks (including the subsequent PCG64
word and invalid-argument tests), and the example. `make full-test` covers
**78** differential fixture files. The frozen oracle is regenerated by
`python3 tests/generate_distributions65_oracle.py` in an environment with
NumPy, but neither Python nor NumPy is needed to build/run LuaRay.

The implementation uses the NumPy 2.5.3 source algorithm under the
NumPy BSD-3-Clause license, with hashes in
`NUMPY_2_5_3_ZIPF_FILE_HASHES.sha256`. Exact replay was validated here;
it is not guaranteed across systems with different math libraries.
Only scalar parameters are supported; argument broadcasting remains
unimplemented. The fast path's return of 1 at very high `a` is NumPy's
specified numerical approximation, not mathematically exact sampling.

### 0.97.0-dev (reconstructed branch)

Provides `shares_memory`, `may_share_memory`, `copyto` and `putmask` in the native Lua module.
This release is reconstructed from the available 0.94 source because the 0.95–0.96 release archives were not available.
`shares_memory` enforces work and memory limits on very large noncontiguous views.
`copyto` buffers converted values and masks before mutation, including aliased views.
`putmask` has positional repeat semantics and snapshot protection.
