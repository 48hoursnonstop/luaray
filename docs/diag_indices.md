---
docs_examples: true
---
# Diagonal indices

Use diagonal indices to read or replace the main diagonal with the ordinary
advanced indexing API. Unlike `diagonal`, which returns a read-only view, these
helpers return coordinates for indexing the original array.

## Signatures

| Function | Result |
| --- | --- |
| `lr.diag_indices(n, ndim)` | A sequence of `ndim` index vectors; default `ndim=2`. |
| `lr.diag_indices(n, {ndim=...})` | Options-table form. |
| `lr.diag_indices_from(a)` | Coordinates for an ndarray with at least two equally sized axes. |

Coordinates are **one-based**, like all LuaRay indexing. Each vector contains
`1` through `n`, using the platform's native signed index dtype (`int64` on x86-64).
Dimensions require Lua integers. Negative `n` produces empty vectors; nonpositive
`ndim` produces an empty sequence after constructing the vector.

## Read and replace a diagonal

```lua
local lr = require("luaray")
local matrix = lr.arange(9):reshape({3, 3})
local coordinates = lr.diag_indices_from(matrix)
local diagonal = matrix:get(table.unpack(coordinates))
assert(diagonal[1] == 0 and diagonal[3] == 8)
matrix:set(7, table.unpack(coordinates))
assert(matrix:get(1, 1) == 7 and matrix:get(3, 3) == 7)
assert(matrix:get(1, 2) == 1)
```

`table.unpack` passes one index vector per axis. Advanced reads create independent
arrays; assignment writes into the original storage. The coordinate vectors do
not share storage with the input, but entries within the returned sequence refer
to the **same vector**. Changing one entry's elements changes all repeated entries.

## Index higher-dimensional arrays

```lua
local cube = lr.zeros({2, 2, 2}, "int16")
local coordinates = lr.diag_indices(2, {ndim=3})
assert(rawequal(coordinates[1], coordinates[3]))
cube:set(9, table.unpack(coordinates))
assert(cube:get(1, 1, 1) == 9 and cube:get(2, 2, 2) == 9)
assert(cube:get(1, 2, 1) == 0)
```

`diag_indices_from` requires an actual ndarray. Raw Lua tables, rank-zero/rank-one
arrays and arrays whose axes have different lengths raise errors. For a rectangular
matrix, use explicit coordinates or [a diagonal view](matrices.md) to read values.

## Assign numeric values to string arrays

```lua
local labels = lr.zeros({2, 2}, "U4")
labels:set(true, table.unpack(lr.diag_indices(2)))
assert(labels:get(1, 1) == "True" and labels:get(1, 2) == "")
labels:set(0/0, 1, 1)
assert(labels:get(1, 1) == "nan")
```

Numeric, Boolean and complex scalars use the shared native string-casting formatter
for basic, Boolean-mask and advanced assignment. Fixed-width destinations truncate
the formatted text. Constructors use this formatter too, preserving floating
precision, pure-imaginary notation and canonical unsigned `nan` text.

## Compatibility

Available since **0.122.0-dev**. NumPy 2.5.3 references compare coordinates after
an explicit zero-to-one-based adaptation, dtype, aliasing, read copies, actual
backing writes, empty/rank boundaries and scalar string formatting. Lua sequence
returns replace Python tuples. Python index objects, subclass dispatch and complete
foreign scalar protocols remain unsupported. These APIs remain partially compatible.
