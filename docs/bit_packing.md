---
docs_examples: true
---
# Packing and unpacking bits

`lr.packbits` stores the truth value of eight integer or Boolean elements in
one `uint8` byte. Zero becomes a zero bit; every nonzero integer becomes one.
`lr.unpackbits` expands `uint8` bytes into a `uint8` array of zero/one values.
Both functions return owned, writable storage independent of their input.

```lua
local lr = require("luaray")
local values = lr.array({1, 0, -2, 0, 1, 0, 1, 0, 1}, "int16")
local packed = lr.packbits(values)
assert(packed.dtype == "uint8" and packed.size == 2)
assert(packed[1] == 170 and packed[2] == 128)
```

## Bit order and trailing zeros

`bitorder = "big"` is the default: the first truth value occupies the most
significant bit. `"little"` puts it in the least significant bit. Packing pads
an incomplete last byte with zero bits. Keep the original length when you want
to remove that padding during unpacking.

```lua
local packed_little = lr.packbits(values, {bitorder = "little"})
assert(packed_little[1] == 85 and packed_little[2] == 1)
local restored = lr.unpackbits(packed_little, {
  bitorder = "little", count = values.size
})
assert(restored.size == 9 and restored[3] == 1 and restored[9] == 1)
```

## Flattening and axes

With no axis, input is flattened in logical C order: the last dimension changes
fastest. An explicit axis preserves the other dimensions. Lua positive axes
start at one; negative axes count from the end. Axis zero is invalid. Scalar
inputs are treated as length-one arrays.

```lua
local matrix = lr.array({{1, 0, 1}, {0, 1, 0}}, "int32")
local rows = lr.packbits(matrix, {axis = 2})
assert(rows:get(1, 1) == 160 and rows:get(2, 1) == 64)
assert(lr.packbits(matrix)[1] == 168)
local expanded = lr.unpackbits(rows, {axis = -1, count = 3})
assert(expanded.shape[1] == 2 and expanded.shape[2] == 3)
assert(expanded:get(2, 2) == 1)
```

## Selecting the number of unpacked bits

A nonnegative `count` sets the output length along the chosen axis. A shorter
count keeps the first bits; a longer count appends zeros. A negative count trims
that many bits from the end of the available `8 * byte_count` bits. Trimming
more than the available bits is an error. Counts must be Lua integers.

```lua
local byte = lr.array({128}, "uint8")
local padded = lr.unpackbits(byte, {count = 10})
assert(padded.size == 10 and padded[1] == 1 and padded[10] == 0)
local trimmed = lr.unpackbits(byte, {count = -7})
assert(trimmed.size == 1 and trimmed[1] == 1)
assert(not pcall(lr.unpackbits, byte, {count = -9}))
```

## Views and output layout

Reversed, stepped, broadcast, read-only and unaligned arrays are supported.
Explicit-axis results use Fortran order when input is exclusively Fortran
contiguous; otherwise they use C order. Empty results follow the normal empty
array stride rules. Inputs retain their bytes and permissions.

```lua
local source = lr.asfortranarray(matrix)
source:setflags(false)
local packed_rows = lr.packbits(source, {axis = 2})
assert(packed_rows.strides[1] == 1 and packed_rows.strides[2] == 2)
assert(not lr.shares_memory(packed_rows, source))
packed_rows:fill(0)
assert(source:get(1, 1) == 1 and not source.flags.writeable)
```

## Empty inputs and accepted controls

Expanding an empty packed axis to a positive count produces defined zeros in
LuaRay. **This deliberately differs from the pinned NumPy 2.5.3 implementation**:
its empty-input iterator can skip initialization and return undefined bytes.
Those source outputs are excluded from parity comparisons; the zero-fill policy
has separate permanent Lua and native tests. No input address arithmetic is performed for an empty packed axis,
including views with extreme strides.

```lua
local zeros = lr.unpackbits(lr.empty({3, 0}, "uint8"), {
  axis = 2, count = 9
})
assert(zeros.shape[1] == 3 and zeros.shape[2] == 9)
assert(lr.count_nonzero(zeros) == 0)
assert(not pcall(lr.packbits, lr.array({1.0}, "float64")))
assert(not pcall(lr.unpackbits, {1, 2})) -- explicitly construct uint8 input
```

Options tables accept `axis` and `bitorder`; unpacking additionally accepts
`count`. Positional forms are `lr.packbits(input, axis, bitorder)` and
`lr.unpackbits(input, axis, count, bitorder)`. Omitted or `nil` controls use the
defaults. Do not combine an options table with positional controls. Unknown
keys and embedded-NUL option/order names are rejected. Use the canonical order
names above; legacy prefix parsing follows the pinned source (pack accepts
`big`/`little` prefixes, unpack accepts a first `b`/`l`).

Bit packing passed **37,640 cases /250,644 checks**: 15,029 pack and 22,611 unpack cases; 7,958 valid inputs and 29,682 expected rejections. Permanent regressions add 201 Lua checks, a native harness and C++ header/link execution. Checks include bytes, dtype, shape, strides, flags, independent output, unchanged inputs, orders/axes, count, boundaries and every Boolean byte payload. Another 16,804 nonnegative axes were adapted to Lua positions. The corpus regenerated exactly. Another 358 upstream states with uninitialized output are excluded from parity; LuaRay zero filling is tested separately.

The APIs remain partial. The source's legacy explicit-axis iterator has a
32-dimension limit, preserved here; flattening accepts supported arrays up to
64 dimensions. Typed scalar axis/count, foreign array/index protocols, Python
scalar classes and exact warning/exception classes are not implemented. The
implementation uses scalar native loops; equivalent SIMD performance, every
host ABI, huge allocations and all input combinations are not certified.
