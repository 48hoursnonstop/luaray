---
docs_examples: true
---
# Equality and numerical tolerances

Use `array_equal` for matching shapes and exact element equality, `array_equiv`
when broadcasting is allowed, and `isclose`/`allclose` for numerical tolerances.
These functions do not modify either input.

## Exact equality and shape

```lua
local lr = require("luaray")
assert(lr.array_equal({1, 2}, lr.array({1, 2}, "float32")))
assert(not lr.array_equal({1, 2}, {{1, 2}}))
assert(lr.array_equiv({{1, 2}, {1, 2}}, {1, 2}))
assert(not lr.array_equiv({1, 2}, {1, 2, 3}))
```

`array_equal(a, b, {equal_nan=false})` requires identical shapes, but matching
dtypes are not required. `array_equiv(a, b)` first checks broadcasting and then
compares all elements. Both return a Lua Boolean. Failed ordinary input coercion
returns false; this does not suppress later arithmetic or metadata errors.

Numeric arrays and text arrays are unequal rather than raising solely because
no comparison signature exists. Bytes and Unicode likewise remain distinct.
Other errors, such as incompatible calendar/fixed duration units, still propagate.
Empty matching shapes compare equal when the selected comparison path supports
their dtypes.

## NaN and identity

```lua
local missing = lr.array({0/0}, "float64")
assert(not lr.array_equal(missing, missing))
assert(lr.array_equal(missing, missing, {equal_nan=true}))
local real_missing = lr.array({lr.complex(0/0, 1)}, "complex128")
local imag_missing = lr.array({lr.complex(1, 0/0)}, "complex128")
assert(lr.array_equal(real_missing, imag_missing, {equal_nan=true}))
```

With `equal_nan=true`, corresponding NaN values compare equal. For complex values,
a NaN in either component marks the entire value as missing. NaT follows the
source's temporal `isnan` behavior. Exact equality without that option still
compares NaN/NaT unequal.

The source has an identity shortcut with `equal_nan=true`: the same native ndarray
compares equal to itself before NaN detection. A separate string array can therefore
raise from unsupported `isnan` even when the identical string object returns true.
The implementation preserves these source paths rather than guessing from dtype names.

## Tolerances and broadcasting

```lua
local close = lr.isclose({1, 2, 3}, {1.000001, 2, 4})
assert(close.dtype == "bool" and close[1] and close[2] and not close[3])
assert(lr.allclose({1, 2}, {1.000001, 2}))
local bounds = lr.isclose({1, 1.01}, {1, 1}, {rtol=0, atol={0, 0.02}})
assert(bounds[1] and bounds[2])
```

`isclose(a, b, {rtol=1e-5, atol=1e-8, equal_nan=false})` returns a Boolean ndarray.
`allclose` uses the same options and returns a Lua Boolean. Finite values satisfy
`abs(a-b) <= atol + rtol*abs(b)`. This expression treats `b` as the reference, so
it is not symmetric. Relative and absolute tolerances can broadcast as arrays.
Equal infinities compare close; opposite infinities do not. `equal_nan` must be
a Lua Boolean. Incompatible shapes raise for closeness rather than returning false.

Results from `isclose` are independent writable arrays, including rank-zero arrays
for scalar input. Native typed arrays retain their promotion rules; ordinary Lua
scalars stay weak where the source uses ordinary Python scalars. Integer right
inputs promote to floating arithmetic, avoiding integer-minimum absolute-value
problems. Extended precision remains inside native arrays during the calculation.

## Temporal comparisons

```lua
local elapsed = lr.array({0, 1, 2}, "timedelta64[h]")
assert(lr.allclose(elapsed, elapsed, {rtol=0, atol=0}))
local missing = lr.array({1, math.mininteger}, "timedelta64[h]")
assert(lr.isnan(missing)[2] and not lr.any(lr.isinf(missing)))
```

Durations retain their unit. An integer or compatible duration absolute tolerance
can work; the default floating absolute tolerance need not be valid for duration
addition. `isnan` recognizes NaT, `isinf` is false for temporal values, and
`isfinite` excludes NaT. Duration comparisons accept Boolean/signed integer and
small unsigned arrays as ticks; uint64 has no matching comparison signature.
[Temporal arithmetic](temporal_scaling.md) describes integer offsets and error writes.

## Compatibility

Available since **0.134.0-dev**, derived from NumPy 2.5.3 `numeric.py` and ndarray
rich-comparison rules. Lua uses options tables and Boolean `equal_nan` values.
The native floating warning/error-state API and full Python exception identity
are not implemented; default nonfinite tolerance arithmetic is executed. Object,
structured, foreign/subclass and complete Python scalar protocols remain unsupported.
The APIs remain partially compatible. Frozen references check exact Boolean
results, dtype, shape, strides, input states and actual output writes. Extended
precision boundary fixtures preserve value bits through native byte views.
