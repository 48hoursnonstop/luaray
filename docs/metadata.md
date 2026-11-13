---
docs_examples: true
---
# Query dimensions and element counts

`lr.shape`, `lr.ndim` and `lr.size` query an ndarray or convert a supported Lua
array-like input through the native discovery path. Existing ndarrays are read
directly: these queries do not copy or traverse their elements, change flags or
require writable storage.

```lua
local lr = require("luaray")
local matrix = lr.arange(6):reshape({2, 3})
local shape = lr.shape(matrix)
assert(shape[1] == 2 and shape[2] == 3)
assert(lr.ndim(matrix) == 2 and lr.size(matrix) == 6)
assert(lr.size(matrix, 1) == 2 and lr.size(matrix, -1) == 3)
shape[1] = 99
assert(lr.shape(matrix)[1] == 2)
```

`shape` returns a fresh Lua sequence of dimension lengths. Editing that sequence
does not reshape the array. `ndim` returns the rank. `size` without an axis
returns the total element count, including all axes; with an axis it returns that
axis's length. Integer results use Lua integers. A vector's length and its total
size agree; a multidimensional array's first-axis length is not its total size.

## Scalars, sequences and axes

```lua
assert(lr.ndim(7) == 0 and lr.size(7) == 1 and #lr.shape(7) == 0)
assert(lr.ndim({{}, {}}) == 2 and lr.size({{}, {}}) == 0)
assert(lr.size({{1, 2}, {3, 4}}, -1) == 2)
assert(not pcall(function() lr.size(matrix, 0) end))
assert(not pcall(function() lr.shape({{1, 2}, {3}}) end))
```

Positive axes start at one. Negative axes count from the end; zero, out-of-range
axes and non-integer values raise. Nil means no axis. Scalars have rank zero,
shape `{}` and one element; an axis is invalid for them. Empty dimensions make
total size zero. Ragged sequences fail through the existing creation checks.

Ordinary Lua sequences and supported scalar values use native array discovery,
which can allocate temporary storage. Nested ndarrays, arbitrary foreign objects,
Python attribute/array protocols, object/structured dtypes and nil scalar input
retain the creation API's existing limitations. No temporary data allocation is
needed when the input is already an ndarray.

## Large and read-only views

```lua
local huge = lr.broadcast_to(lr.array(1, "int8"), {2^30, 2^20})
assert(lr.size(huge) == 2^50 and lr.ndim(huge) == 2)
assert(lr.size(huge, 1) == 2^30 and not huge.flags.writeable)
local readonly = lr.frombuffer(string.pack("i4i4", 1, 2), "int32")
assert(lr.size(readonly) == 2 and not readonly.flags.writeable)
```

The large view still references one stored byte. Queries work from its shape,
including zero strides, without evaluating a trillion elements. The same direct
path handles rank-64 arrays, reversed/transposed views, immutable buffers and
unaligned storage. It neither reads scalar values nor changes ownership.

This is partially compatible with NumPy 2.5.3 `fromnumeric.py`. Lua sequences
replace Python shape tuples, and axes use Lua's one-based convention. References
check shapes, ranks, axis acceptance, integer counts and unchanged input/backing
states. Unsupported creation/protocol cases are not certified by these queries.
