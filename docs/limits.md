---
docs_examples: true
---
# Numeric limits

`lr.finfo(dtype)` describes a native floating-point format. `lr.iinfo(dtype)`
reports integer endpoints. Pass a dtype name or `lr.dtype` descriptor. A Lua
floating number selects float64, a Lua integer selects int64, and a Lua complex
scalar selects complex128. The function rejects incompatible types.

```lua
local lr = require("luaray")
local single = lr.finfo("float32")
assert(single.bits == 32 and single.nmant == 23)
assert(single.eps == 2^-23 and single.epsneg == 2^-24)
local signed = lr.iinfo(lr.dtype("int16"))
assert(signed.min == -32768 and signed.max == 32767)
```

## Floating-point fields

`bits` is the storage width; `nmant` counts stored mantissa bits. `eps` measures
the gap above one, while `epsneg` measures the gap below one. `min` and `max`
are finite endpoints. `minexp`, `maxexp`, `machep`, `negep`, `nexp` and `iexp`
describe binary exponents; `precision` and `resolution` describe decimal digits.
The dtype field is a descriptor.

```lua
local info = lr.finfo("float32")
local one = lr.array(1, info.dtype)
local step = lr.array(info.eps, info.dtype)
assert(lr.add(one, step):tolist() == 1 + info.eps)
assert(info.min == -info.max)
assert(info.minexp == -126 and info.maxexp == 128)
```

`tiny` and `smallest_normal` are aliases for the smallest positive normal value.
`smallest_subnormal` describes the smallest positive subnormal value. Subnormals
have less precision than normal values; these constants describe the format,
not the behavior of every external floating-point environment.

```lua
local half = lr.finfo("float16")
assert(half.tiny == 2^-14 and half.smallest_normal == half.tiny)
assert(half.smallest_subnormal == 2^-24)
assert(half.precision == 3)
```

## Complex formats and caching

Complex information describes its real component. Complex64 resolves to
float32, complex128 to float64, and clongdouble to longdouble. Floating records
are cached by this resolved dtype; integer calls return separate records.
Records are immutable Lua userdata. Their short string representations follow
LuaRay conventions rather than NumPy's multi-line report.

```lua
local real = lr.finfo("float32")
local complex = lr.finfo("complex64")
assert(rawequal(real, complex) and complex.dtype == lr.dtype("float32"))
assert(not pcall(function() real.eps = 1 end))
assert(not rawequal(lr.iinfo("int32"), lr.iinfo("int32")))
```

## Lossless wide constants

Half, float32 and float64 floating fields are returned as Lua numbers. Longdouble
floating fields are independent typed rank-zero arrays, so their precision and
exponent range survive the Lua boundary. Changing a returned array does not
change its record. The same rule preserves the uint64 maximum, which exceeds
the signed Lua integer range; all other integer endpoints are Lua integers.

```lua
local extended = lr.finfo("longdouble")
assert(extended.max.ndim == 0 and extended.max.dtype == "longdouble")
local bytes = extended.max:tobytes():sub(1, 10)
local copy = extended.max
copy:fill(0)
assert(extended.max:tobytes():sub(1, 10) == bytes)
local unsigned = lr.iinfo("uint64")
assert(unsigned.min == 0 and unsigned.max:tobytes() == string.rep("\255", 8))
assert(lr.iinfo("int64").min == math.mininteger)
```

Use native array operations with these wide values. Converting them to a Lua
number can lose precision, underflow, or overflow. The significant-byte example
above reflects the tested x86 longdouble ABI; other ABIs need separate validation.

## Invalid inputs and scope

Boolean, string and temporal dtypes have no supported numeric-limit record.
Array instances are rejected; pass their `.dtype` instead. There is no default
dtype argument. Unknown fields and record writes raise Lua errors.

```lua
local values = lr.array({1, 2, 3}, "float32")
assert(lr.finfo(values.dtype).bits == 32)
assert(not pcall(lr.finfo, values))
assert(not pcall(lr.iinfo, "bool"))
assert(not pcall(lr.finfo, nil))
```

Constants follow the pinned NumPy source and native C format limits. Full Python
scalar classes, mutation/cached-property behavior, textual formatting, foreign
custom dtypes, non-native numeric endian and every host ABI are not reproduced.
The API remains classified as partially compatible.

## 0.160.0-dev verification

Numeric limits passed **260 cases /2,849 checks** against NumPy2.5.4, plus62 permanent Lua checks, a native limits harness and C++ header/link execution. All public fields, real/complex mapping, integer endpoints, aliases, input validation and dtype metadata compare exactly. Longdouble constants and uint64 maximum use independent typed scalar adaptations; x87 padding is omitted. Cache identity and immutable records are explicit Lua contracts. The corpus regenerated exactly.

