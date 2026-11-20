---
docs_examples: true
---

# Iterating over array values

`lr.ndenumerate(array)` yields an independent one-based coordinate
table and its value. It visits elements in logical C order, with the
last axis changing fastest. The traversal order also applies to
transposed and reversed views.

```lua
local lr = require("luaray")
local values = lr.array({{1, 2}, {3, 4}})
local total = 0
for coordinate, value in lr.ndenumerate(values) do
  total = total + coordinate[1] * value
end
assert(total == 17)
```

`lr.broadcast(a, b, ...)` iterates arrays with compatible shapes
together. Each step returns a table with one element per operand. The
iterator reads from broadcast views, so edits to an input array are
visible on subsequent reads.

```lua
local product = lr.broadcast({1, 2}, {{3}, {4}})
assert(product.size == 4 and product.ndim == 2)
local values = {}
for pair in product do
  values[#values + 1] = pair[1] * pair[2]
end
assert(table.concat(values, ",") == "3,6,4,8")
product:reset()
assert(product.index == 0 and product:next()[1] == 1)
```

The iterator exposes read-only `shape`, `size`, `ndim` and `numiter`.
`index` counts how many tuples have been returned. Both direct calls
and `next()` advance the same iterator. Use `reset()` to restart.
