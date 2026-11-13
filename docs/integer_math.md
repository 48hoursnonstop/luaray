---
docs_examples: true
---
# Integer operations

LuaRay provides bit inversion, population counts, shifts, greatest common
divisors and least common multiples through the native array engine. These
operations support integer dtypes, broadcasting and strided views.

```lua
local lr = require("luaray")
local values = lr.array({-7, -1, 0, 7}, "int8")
assert(lr.invert(values)[1] == 6)
assert((~values)[4] == -8)
local counts = lr.bitwise_count(values)
assert(counts[1] == 3 and counts[2] == 1)
assert(lr.dtype(counts.dtype).name == "uint8")
```

`bitwise_count` counts bits in the **absolute value** of each signed element.
Consequently, the count for `-1` is one. Its output dtype is always uint8.
Boolean inversion is logical negation; Boolean population counts are zero or one.

## Shifts and fixed-width results

`left_shift` and `right_shift` also support Lua's `<<` and `>>` array operators.
Signed right shifts extend the sign bit. Results use fixed-width integer
arithmetic, so left shifts can wrap. A negative or oversized count produces
zero for a left shift, and zero or sign extension for a right shift. These are
NumPy array semantics; negative counts do not reverse the shift direction.

```lua
local signed = lr.array({-8, 7}, "int8")
assert((signed >> 1)[1] == -4)
assert((signed << -1)[1] == 0)
assert((signed >> 64)[1] == -1)
local bytes = lr.array({255}, "uint8")
assert((bytes << 1)[1] == 254)
assert(not pcall(function() return bytes << 256 end))
```

A Lua integer paired with an array follows weak-scalar bounds checking before
execution. A count such as 256 cannot be represented in a uint8 operand and is
therefore rejected. Typed mixed integer arrays use the operation's loop
resolution; int64/uint64 pairs have no safely castable common integer loop.
Floating, complex, string and temporal operands are rejected, including empty
arrays of those types. Boolean shifts use an int8 calculation dtype.

## Broadcasting and masked output

The optional table supports `out` and `where`. Unknown keys are rejected; full
NumPy ufunc dtype/casting/order controls are not implemented by these functions.
Use an initialized output with a mask when you need defined values everywhere.

```lua
local grid = lr.left_shift(lr.array({{1}, {2}}, "int16"),
                          lr.array({0, 1, 2}, "int16"))
assert(grid:get(2, 3) == 8)
local out = lr.full({3}, 99, {dtype = "int16"})
local returned = lr.right_shift({1, 2, 3}, 1, {
  out = out, where = lr.array({true, false, true})
})
assert(rawequal(returned, out))
assert(out[1] == 0 and out[2] == 99 and out[3] == 1)
```

Outputs follow the shared same-kind casting and writable checks. Read-only
inputs can produce new arrays. Overlapping outputs are staged when necessary
so writes do not destroy input values needed later.

```lua
local shared = lr.array({1, 2, 3}, "int8")
local reversed = lr.flip(shared, 1)
lr.left_shift(shared, 1, {out = reversed})
assert(shared[1] == 6 and shared[2] == 4 and shared[3] == 2)
```

## Greatest common divisor and least common multiple

`gcd` and `lcm` use absolute integer magnitudes. A zero/zero pair returns zero;
LCM is also zero when either operand is zero. All-Boolean combinations are
rejected, while a Boolean/integer combination can promote to an integer dtype.

```lua
local common = lr.gcd(lr.array({-12, 0, 18}, "int16"), 6)
local multiple = lr.lcm(lr.array({-12, 0, 18}, "int16"), 6)
assert(common[1] == 6 and common[2] == 6 and common[3] == 6)
assert(multiple[1] == 12 and multiple[2] == 0 and multiple[3] == 18)
assert(not pcall(lr.gcd, lr.array({true}), lr.array({false})))
```

Fixed-width wrapping also applies to LCM and to a signed GCD whose positive
mathematical result cannot fit its dtype. Minimum signed magnitudes are computed
without overflowing a signed C negation.

```lua
local minimum = lr.array({math.mininteger}, "int64")
assert(lr.bitwise_count(minimum)[1] == 1)
assert(lr.gcd(minimum, 0)[1] == math.mininteger)
assert(lr.lcm(minimum, 1)[1] == math.mininteger)
```

## Boolean buffers and integer aliases

Converting a Boolean buffer to a numeric dtype uses truth, even when its raw
bytes are values such as 2 or 255. A Boolean-to-Boolean identity copy retains
those bytes. Promotion between equivalent integer aliases is now independent
of argument order. Default shift-loop selection and uniform GCD/LCM promotion
can still select different alias classes, matching their separate source rules.

```lua
local payload = string.char(0, 2, 255)
local raw = lr.ndarray({3}, {dtype = "bool", buffer = payload})
local numeric = lr.astype(raw, "int8")
assert(numeric[1] == 0 and numeric[2] == 1 and numeric[3] == 1)
assert(raw:tobytes() == payload)
local forward = lr.dtype(lr.promote_types("longlong", "int64"))
local reverse = lr.dtype(lr.promote_types("int64", "longlong"))
assert(forward.char == reverse.char)
```

## Names and scalar results

`bitwise_not` and `bitwise_invert` are aliases of `invert`.
`bitwise_left_shift` and `bitwise_right_shift` alias the corresponding shifts.
Ordinary scalar calls return typed zero-dimensional ndarrays, following LuaRay's
existing unary/binary convention.

```lua
assert(lr.bitwise_not == lr.invert and lr.bitwise_invert == lr.invert)
assert(lr.bitwise_left_shift == lr.left_shift)
assert(lr.bitwise_right_shift == lr.right_shift)
local scalar = lr.bitwise_count(7)
assert(scalar.ndim == 0 and scalar:item() == 3)
assert(not pcall(lr.invert, values, {dtype = "int16"}))
```

References passed **144,844 cases /3,318,010 checks**: 143,680 operation cases and 1,164 Boolean transfer/promotion cases. They check bytes, dtype.char/num, shape, strides, flags, masks, overlapping outputs, boundaries and post-error states. Another 2,120 NumPy scalars were normalized to the typed Lua rank-zero array contract; Python scalar-object parity is not claimed. Permanent regressions add 6,242 Lua checks, a native harness and C++ header/link execution. Both corpora regenerated exactly. Non-native numeric endian and the historical generic-datetime cast contract remain outside this scope.

The APIs remain partial. They do not expose full ufunc object methods, foreign
dispatch, Python scalar classes, object dtypes or non-native numeric endian.
All warning policies, host ABIs and arbitrary operand combinations are not
certified. See [dtype descriptors](dtypes.md) and [numerical portability](portability.md).
