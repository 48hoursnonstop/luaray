---
docs_examples: true
---
# Numeric ranges with arange

`lr.arange(start, stop, step, dtype)` creates an independent, writable
one-dimensional array. Stop is excluded. A single numeric argument means
`start=0`; the default step is one. This numeric interface is available from
**0.142.0-dev**. The earlier `lr.arange(stop, dtype)` spelling remains supported.

## Choose a direction and step

```lua
local lr = require("luaray")
local increasing = lr.arange(2, 9, 2)
assert(increasing.size == 4 and increasing[4] == 8)
local decreasing = lr.arange(5, 0, -2)
assert(decreasing.size == 3 and decreasing[3] == 1)
assert(lr.arange(5, 0).size == 0)
```

Arguments can be Lua integers, numbers, booleans or `lr.complex` values.
Integer/Boolean arguments infer the host's native index integer dtype, which is
int64 on the supported 64-bit Linux target. A floating argument selects float64;
a complex argument selects complex128. A zero step raises an error, including
when start equals stop. Nonfinite or excessive lengths are rejected before
allocation. Negative lengths produce an empty array.

## Select the output dtype

```lua
local samples = lr.arange(0, 1, 0.25, lr.dtype("float32"))
assert(samples.dtype == "float32" and samples.size == 4)
assert(samples[4] == 0.75)
local other = lr.arange(0, 1, 0.25, {dtype="float32"})
assert(lr.array_equal(samples, other))
assert(lr.arange(3, "int32").dtype == "int32")
```

A trailing dtype string, descriptor or `{dtype=...}` table is accepted after
one, two or three numeric arguments. A nil stop means the single-argument form;
a nil step means one. An explicit trailing nil leaves dtype inferred. Unknown
option keys and excess arguments are errors.

The historical two-argument call with an integer stop and positional dtype
keeps its earlier per-index conversion contract. This includes Boolean ranges
longer than two elements. Use an options table for NumPy constructor semantics
with an integer stop:

```lua
local legacy = lr.arange(4, "bool")
assert(legacy.size == 4 and legacy[1] == false and legacy[4] == true)
assert(not pcall(function() lr.arange(4, {dtype="bool"}) end))
```

Both dtype strings and descriptors select that legacy form. Its numeric values
correspond to converting consecutive integer indices; temporal descriptors mean
raw consecutive ticks. As before, nonempty legacy string output is rejected,
while an empty result retains its descriptor width. Fractional stops and calls
with start/stop or an options table use the new scalar constructor rules.

All existing native numeric scalar dtypes are supported, including half,
longdouble and complex256. The new constructor permits at most two Boolean
elements and rejects string/Unicode dtypes even for empty ranges. Existing
non-native-endian dtype limitations remain in force.

## Understand the effective increment

```lua
local truncated = lr.arange(0, 3, 0.5, "int32")
assert(truncated.size == 6 and truncated[6] == 0)
local rounded = lr.arange(100000000, 100000005, 1, "float32")
assert(rounded.size == 5 and rounded[5] == 100000000)
local wrapped = lr.arange(120, 140, 3, "int8")
assert(wrapped[3] == 126 and wrapped[4] == -127)
```

Following NumPy, length uses the original arguments, while the fill loop uses
`dtype(start + step) - dtype(start)`. The first two values undergo scalar
conversion and its bounds checks; subsequent integer values wrap to the output
width. Floating fill uses the output precision, with float arithmetic for half.
It does not repeatedly add the original step. Small increments may disappear
after conversion, and floating rounding can affect length and endpoint behavior.
Use [`linspace`](./sampling.md) when a fixed sample count is the requirement.

## Complex arguments

```lua
local diagonal_bound = lr.arange(0, lr.complex(3, 3), 1)
assert(diagonal_bound.dtype == "complex128" and diagonal_bound.size == 3)
assert(diagonal_bound[3].real == 2 and diagonal_bound[3].imag == 0)
local empty = lr.arange(0, lr.complex(3, 3), lr.complex(1, 1))
assert(empty.size == 0)
```

Complex input arguments require a complex output dtype. Their source rule takes
the smaller of the ceilings of the real and imaginary parts of
`(stop-start)/step`; a real quotient from entirely real arguments uses the
ordinary rule even with complex output. This can produce unintuitive empty
ranges. Scalar complex calculations use binary64 components. Infinite complex
steps retain the source's signed-zero recovery; invalid NaN lengths raise errors.

## Compatibility and verification

The numeric scalar interface has partial NumPy 2.5.3 compatibility. Typed ndarray
arguments, datetime/timedelta ranges, foreign numeric and Python `like`/device
protocols are not supported by this interface yet. Python arbitrary-precision
integer arguments outside Lua's integer range are not representable; internal
integer differences and initial sums use checked wider arithmetic.

The native boundary is `ln_array_arange`, taking three scalar
`ln_ufunc_operand` values and an optional output descriptor. It returns an owned
array or an error; borrowed inputs are not modified. Filling runs in native code.

References check acceptance, dtype, layout, flags, writable independence and raw
numeric payloads exactly. On the reference x86 host, the six padding bytes of
each 16-byte longdouble component are omitted; its ten significant bytes remain
exactly checked. Padding is not numerical data and is not certified. Oversized
test allocations and integers outside Lua's domain are excluded explicitly.
