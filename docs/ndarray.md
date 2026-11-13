---
docs_examples: true
---
# Construct arrays and buffer layouts

`lr.ndarray(shape, dtype, options)` creates an owned array, or a view when
`options.buffer` is supplied. Prefer [`zeros`, `empty` or `array`](./creation.md)
for ordinary data construction. This low-level constructor exposes byte offsets
and strides without copying or converting existing storage.

## Allocate by shape

```lua
local lr = require("luaray")
local values = lr.ndarray({2, 3}, "int32", {order="F"})
values:fill(7)
assert(values.strides[1] == 4 and values.strides[2] == 8)
assert(values.flags.owndata and values.flags.f_contiguous)
assert(lr.sum(values) == 42)
```

Shape is an integer or a dense table of Lua integers; `{}` means rank zero.
The maximum rank is 64. Dtype defaults to float64 and accepts a string or a
[`dtype` descriptor](./dtypes.md). Options can occupy the second argument when
dtype is omitted: `lr.ndarray({2, 3}, {dtype="int32", order="F"})`.

Order is `C` by default. `F` selects column-major strides; `A` and `K` select C,
following the upstream constructor. Lowercase letters also work. Without a
buffer, storage is owned and writable. Numeric and byte-string values are
uninitialized; fill them before reading. Unicode storage is zero-initialized.
An owned allocation ignores offset, but its supplied value must be an integer.

## Share storage with explicit strides

```lua
local backing = lr.array({10, 20, 30, 40}, "int32")
local reverse = lr.ndarray(3, {
  dtype="int32", buffer=backing, offset=8, strides=-4,
})
assert(reverse[1] == 30 and reverse[3] == 10)
reverse[2] = 99
assert(backing[2] == 99 and lr.shares_memory(reverse, backing))
```

Offsets and strides count **bytes**, with offsets starting at zero. Array
indices still start at one. Strides can be positive, negative or zero, and must
have the same rank as shape. A scalar stride is accepted for rank one. Explicit
strides determine layout regardless of order. Zero strides repeat the same
memory; writes affect every logical element that shares that address.

```lua
local repeated = lr.ndarray(3, {
  dtype="int32", buffer=backing, offset=4, strides=0,
})
repeated:fill(12)
assert(repeated[3] == 12 and backing[2] == 12)
```

Array buffers may be C- or F-contiguous; other views are rejected. Unlike this
constructor, [`frombuffer`](./buffers.md) requires C-contiguous array buffers.
The available byte window is the supplied array's logical nbytes, rather than
the entire underlying allocation. A view retains the existing storage owner
and inherits the supplied array's write permission. It does not convert values.

## Read binary strings

```lua
local binary = string.pack("i4i4", 123, -456)
local parsed = lr.ndarray({2}, "int32", {buffer=binary})
assert(parsed[1] == 123 and parsed[2] == -456)
assert(not parsed.flags.writeable and not parsed.flags.owndata)
assert(not pcall(function() parsed[1] = 0 end))
local inferred = lr.ndarray(-1, "int32", {buffer=binary .. "xx"})
assert(inferred.size == 2)
```

String-backed storage stays read only, including empty arrays. The engine pins
the string until its last view is collected, even if the creating coroutine has
already been collected. Native arrays acquired through Lua must not outlive
their Lua state. Copy explicitly to obtain independent writable data.

Only a rank-one shape of `-1` is inferred, and only with a buffer. The inferred
count discards incomplete trailing bytes; `frombuffer` instead requires an
exact multiple when it infers count. Other negative dimensions are errors.
For explicit strides, the upstream pre-inference check is retained and an
additional check validates the actual resulting footprint. Prefer an explicit
shape when constructing a strided view.

## Empty arrays and zero-width strings

```lua
local empty = lr.ndarray({2, 0}, {strides={400, -20}})
assert(empty.nbytes == 0 and empty.strides[1] == 0 and empty.strides[2] == 0)
local strings = lr.ndarray({2, 3}, "U0")
assert(strings.itemsize == 0 and strings.nbytes == 0)
assert(strings:tolist()[2][3] == "")
assert(lr.empty({2}, "U0").itemsize == 4)
```

Owned zero-byte allocations reset strides to zero, even when explicit strides
were supplied. Borrowed empty arrays retain their layout strides. `S0` and `U0`
remain genuinely zero-width here; ordinary `empty` normalizes their widths.
Zero-width dtypes cannot infer `-1` from a buffer. Contiguity flags follow the
upstream constructor's distinction between default and explicit zero-width
strides; recomputing flags can change them.

## Safety and compatibility

Available since **0.141.0-dev**, with partial NumPy 2.5.3 compatibility. Byte
bounds and products are checked before forming pointers or allocating storage.
Negative/excessive buffer offsets, insufficient real storage, inferred-stride
footprints outside the buffer and excessive element counts raise errors.
This deliberately rejects unsafe combinations the upstream constructor can
accept. Empty external buffers cannot stand in for a nonempty payload.

Options are limited to `dtype`, `buffer`, `offset`, `strides` and `order`.
Unknown keys, sparse shapes, noninteger layout entries and duplicate dtype
arguments are rejected. Python buffer/subclass/foreign-array protocols and
structured, object and variable-width dtypes are unavailable. Existing dtype
and byte-view limitations apply; raw buffers do not validate Unicode contents.

The native boundary is `ln_array_construct`: an optional retained contiguous
array supplies the storage window. It borrows rather than consumes that array;
the result retains its owner. External pointers can first be wrapped with
`ln_array_from_buffer`, whose release callback runs after the last view dies.
