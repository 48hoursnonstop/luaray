---
docs_examples: true
---

# Transposing, joining and unstacking arrays

`lr.matrix_transpose(a)` swaps the last two axes and keeps leading batch axes
in place. `lr.permute_dims(a, axes)` accepts any full axis permutation.
Both return views that share the original storage.

```lua
local lr = require("luaray")
local batch = lr.array({{{1, 2, 3}, {4, 5, 6}}, {{7, 8, 9}, {10, 11, 12}}})
local transposed = lr.matrix_transpose(batch)
assert(transposed.shape[1] == 2 and transposed.shape[2] == 3)
assert(transposed[2][3][2] == 12)
assert(lr.shares_memory(batch, transposed))
```

`lr.unstack(a, axis)` returns a Lua table of slices in axis order. The axis
defaults to 1. Negative axes count from the end. For an input of rank two or
higher, each slice is a view with one fewer axis. A vector yields scalar
elements. An empty selected axis yields an empty table.

```lua
local columns = lr.unstack(batch, -1)
assert(#columns == 3)
columns[3]:set(99, 2, 2)
assert(batch[2][2][3] == 99)
local joined = lr.concat({columns[1], columns[2]}, {axis = 2})
assert(joined.shape[2] == 4)
```

`lr.concat` shares the `concatenate` implementation and accepts the same
one-based axis, dtype, casting and output options. Unlike an unstacked view,
a new concatenation owns its storage.
