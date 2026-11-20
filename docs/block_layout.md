---
docs_examples: true
---

# Block assembly and zero trimming

`lr.block(values)` assembles an ndarray from nested Lua lists of blocks.
The innermost lists join along the last axis. Each level outward moves
the join to the preceding axis. Operands with lower rank gain leading
axes of length one.

```lua
local lr = require("luaray")
local left = lr.array({{1, 2}, {3, 4}})
local right = lr.array({{5}, {6}})
local top = lr.block({left, right})
local result = lr.block({{left, right}, {top}})
assert(lr.array_equal(result, {{1, 2, 5}, {3, 4, 6}, {1, 2, 5}, {3, 4, 6}}))
```

Use ndarrays or scalars as leaves. Every branch must have the same list
depth. Shapes must match outside the axis joined at each level. The
result owns its storage.

`lr.trim_zeros(values, trim, axis)` removes boundary slices made
entirely of zeros. Omit `axis` to crop every axis, or pass one axis or
a list of axes. Use `"f"` to trim the front, `"b"` for the back or
`"fb"` for both.

```lua
local values = lr.array({{0, 0, 0}, {0, 5, 0}, {0, 6, 0}, {0, 0, 0}})
local crop = lr.trim_zeros(values)
assert(lr.array_equal(crop, {{5}, {6}}))
assert(lr.shares_memory(crop, values))
```

An ndarray crop is a view. A one-dimensional Lua list returns a Lua
list. On an all-zero array the selected axes have length zero.

## Validation

**3,575 cases / 83,056 checks** passed with NumPy 2.5.5. The checks cover nested block dimensions, matching non-join axes, large Fortran outputs, boundary slices and storage sharing. One-dimensional Lua lists remain Lua lists after trimming.
