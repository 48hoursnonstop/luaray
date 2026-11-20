---
docs_examples: true
---
# Signed infinity

`lr.isposinf` and `lr.isneginf` identify positive and negative infinity,
respectively. Finite values and NaN produce false. Results are independent
Boolean arrays, with the input's shape and native KEEPORDER layout.

```lua
local lr = require("luaray")
local values = lr.array({-math.huge, 0, math.huge, 0/0}, "float64")
local positive = lr.isposinf(values)
local negative = lr.isneginf(values)
assert(positive[3] and not positive[1] and not positive[4])
assert(negative[1] and not negative[3])
```

## Scalar and sequence inputs

Ordinary Lua sequences use the existing array constructor. Scalar results use
LuaRay's typed rank-zero array convention. False and zero are ordinary inputs;
neither is treated as an omitted value.

```lua
assert(lr.isposinf(math.huge).ndim == 0)
assert(lr.isposinf(math.huge):tolist() == true)
assert(lr.isneginf(-math.huge):tolist() == true)
assert(lr.isposinf({1, math.huge, 2})[2])
assert(lr.isneginf(false):tolist() == false)
```

## Existing output arrays

Pass an output ndarray as the second argument. It is returned unchanged in
identity. The input must broadcast into its shape; a larger compatible output
is allowed. Boolean results convert to the output dtype through the native
logical ufunc engine, including numeric, fixed text and duration outputs.

```lua
local output = lr.full({2, 4}, 9, "int16")
local result = lr.isposinf(values, output)
assert(rawequal(result, output))
assert(output:get(1, 3) == 1 and output:get(2, 1) == 0)
local text = lr.empty({4}, "S3")
lr.isneginf(values, text)
assert(text[1] == "Tru" and text[3] == "Fal")
```

## Shared and strided storage

Both input masks are evaluated before output writes. An output sharing memory
with the input therefore uses the original values, including reversed outputs.
Readonly and unaligned inputs are accepted; output permission and broadcasting
rules are enforced by native ufuncs.

```lua
local shared = lr.array({-math.huge, 0, math.huge})
local reversed = lr.flip(shared, 1)
lr.isposinf(shared, reversed)
assert(shared[1] == 1 and shared[3] == 0)
local readonly = lr.array({math.huge})
readonly:setflags(false)
assert(lr.isposinf(readonly)[1] and not readonly.flags.writeable)
```

## Invalid inputs and controls

Complex inputs are rejected even if their imaginary parts are zero or the
array is empty. Their infinity sign is ambiguous. Fixed string inputs and
unsupported signbit dtypes also reject before output writes. Only the optional
output ndarray is accepted; there is no where/options-table argument.

```lua
local output = lr.full({1}, 9, "float64")
assert(not pcall(lr.isposinf, lr.array({lr.complex(1, 0)}), output))
assert(output[1] == 9)
assert(not pcall(lr.isneginf, lr.empty({0}, "complex128")))
assert(not pcall(lr.isposinf, values, {out = output}))
```

## Implementation and limits

The Lua layer composes native `isinf`, `signbit`, `logical_not` and `logical_and`
operations, following the source evaluation order. It does not loop through
Lua numbers, so extended precision and strided storage retain native behavior.
This composition allocates temporary masks.

```lua
local extended = lr.array({-math.huge, math.huge}, "longdouble")
assert(lr.isneginf(extended)[1] and lr.isposinf(extended)[2])
local empty = lr.empty({0, 3}, "float32")
assert(lr.isposinf(empty).size == 0)
```

Full Python scalar/subclass/foreign protocols, exception classes, warning and
floating-status behavior, custom dtypes and every ABI remain uncertified. The
functions remain classified as partially compatible.
