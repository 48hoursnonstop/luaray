---
docs_examples: true
---
# Arrays from existing buffers

`lr.frombuffer(storage, dtype, count, offset)` creates a one-dimensional view of
existing bytes. It does not parse text or copy the payload. Storage can be a
binary Lua string or a C-contiguous LuaRay ndarray. The default dtype is float64,
count defaults to all remaining elements, and the default byte offset is zero.

## Read binary data

```lua
local lr = require("luaray")
local bytes = string.pack("i4i4", 123, -456)
local values = lr.frombuffer(bytes, "int32")
assert(values.shape[1] == 2 and values.strides[1] == 4)
assert(values[1] == 123 and values[2] == -456)
assert(lr.frombuffer(bytes, "int32", 1, 4)[1] == -456)
```

Offsets count bytes from zero, following the binary-buffer convention. Array
indices still start at one. Every negative count means all remaining complete
elements. With an inferred count, the remaining length must be a multiple of
itemsize. An explicit nonnegative count may leave unused trailing bytes. An
offset at the end permits an empty result. Negative or excessive offsets,
insufficient storage and zero-width dtypes raise errors.

## Share mutable array storage

```lua
local source = lr.array({1, 2, 3}, "int32")
local tail = lr.frombuffer(source, "int32", 2, 4)
tail[1] = 77
assert(source[2] == 77 and lr.shares_memory(source, tail))
source = nil
collectgarbage("collect")
assert(tail[2] == 3)
```

Array buffers retain the existing storage owner. The returned dtype reinterprets
the bytes; it does not convert the source values. Writeability follows the source.
Noncontiguous arrays and arrays that are only Fortran-contiguous are rejected.
Unaligned offsets are accepted; the native array records their actual alignment.

## Immutable strings and lifetime

```lua
assert(not pcall(function() values:fill(0) end))
assert(not pcall(function() values[1] = 0 end))
local independent = lr.copy(values)
independent[1] = 9
assert(values[1] == 123 and not lr.shares_memory(values, independent))
```

Lua strings are immutable, so every string-backed array and its views are read
only, including empty arrays. Copy explicitly when writable storage is needed.
The engine pins the string until its final native view is collected, even if the
creating coroutine has already been collected. Releasing one view cannot
invalidate another. Copies own independent writable storage.

```lua
local other = lr.frombuffer(bytes, "uint8", 4, 2)
assert(lr.shares_memory(values, other))
local left = lr.frombuffer(bytes, "uint8", 2)
local right = lr.frombuffer(bytes, "uint8", 2, 4)
assert(not lr.shares_memory(left, right))
```

Memory queries inspect physical byte ranges rather than assuming that distinct
owners cannot overlap. The existing exact-query work limits still apply.

## Native boundary and compatibility

The native API offers `ln_array_from_buffer` with an optional release callback
and context. Ownership transfers only on successful construction; the callback
runs once after the last view is released. A null callback leaves lifetime with
the caller. The pointer must be nonnull even for zero bytes. Array-backed
construction shares the existing owner. Storage acquired through Lua must not
outlive its Lua state.

This API is partially compatible with NumPy 2.5.3. Python's arbitrary buffer,
`like` and subclass protocols are not Lua interfaces. Object, structured and
variable-width string dtypes remain unavailable, as do non-native numeric endian
descriptors. Supported fixed-width text and Unicode descriptors retain their
existing rules. `frombuffer` preserves bytes, including noncanonical Boolean
storage and extended-precision values; it does not validate arbitrary Unicode
payloads or add decoding protocols.

The reference suite checks raw bytes, dtype, shape, strides, ranges, errors,
sharing and write-through state. Maintained Lua/native tests additionally check
GC, creating-coroutine collection, final release, unaligned reads, read-only
writes and overlapping external owners.
