---
docs_examples: true
---

# Cumulative sums and products

`lr.cumulative_sum(input, options)` and `lr.cumulative_prod(input, options)`
accumulate along a single axis. The options table accepts `axis`, `dtype`,
`out`, and `include_initial`. With `include_initial = true`, the result begins
with 0 for a sum or 1 for a product. That axis grows by one, including when
the input axis is empty.

```lua
local lr = require("luaray")
local values = lr.array({{2, 3}, {4, 5}}, "int16")
local sums = lr.cumulative_sum(values, {axis = -1, include_initial = true})
assert(sums.shape[2] == 3)
assert(sums[1][1] == 0 and sums[1][3] == 5)
assert(sums[2][3] == 9)
```

Use a one-based or negative axis. A scalar becomes a length-one array. For
one-dimensional input the axis defaults to 1. Multidimensional input requires
an explicit axis. `cumsum` and `cumprod` retain their default flattening behavior.

```lua
local out = lr.empty({2, 3}, "float32")
local products = lr.cumulative_prod(values, {
  axis = 2, include_initial = true, dtype = "float32", out = out
})
assert(rawequal(products, out))
assert(products[2][1] == 1 and products[2][3] == 20)
```

The dtype selects the accumulator precision. An output array must have the
exact result shape and be writable. Strided outputs, including views that
overlap the input, are accepted. The function returns the supplied array.
