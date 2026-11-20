---
docs_examples: true
---

# Unique values and slices

`lr.unique(input, options)` returns sorted distinct values. By default it
flattens the input in C order. Set `axis` to compare whole slices as
lexicographic rows along a one-based or negative axis.

```lua
local lr = require("luaray")
local input = lr.array({3, 1, 3, 2, 1}, "int32")
local values, first, inverse, counts = lr.unique(input, {
  return_index = true, return_inverse = true, return_counts = true
})
assert(table.concat(values:tolist(), ",") == "1,2,3")
assert(table.concat(first:tolist(), ",") == "2,4,1")
assert(table.concat(lr.take(values, inverse):tolist(), ",") == "3,1,3,2,1")
assert(table.concat(counts:tolist(), ",") == "2,1,2")
```

Enabled auxiliary outputs appear in the order above. Both index arrays use
one-based positions. For an explicit axis in a multidimensional array, the
inverse is a vector along that axis. Otherwise it has the input shape.

```lua
local a = lr.array({{3, 2}, {1, 1}, {3, 2}})
local rows, first = lr.unique(a, {axis = 1, return_index = true})
assert(rows.shape[1] == 2 and rows[1][1] == 1 and first[2] == 1)
local all = lr.unique_all({7, 3, 7})
assert(all.values[1] == 3 and all.counts[2] == 2)
```

`unique_values` returns the values array. `unique_counts`, `unique_inverse`
and `unique_all` return tables with the relevant fields `values`,
`indices`, `inverse_indices` and `counts`. The Array API functions use
`equal_nan = false`. `unique` defaults to `equal_nan = true` for flat numeric
inputs. LuaRay uses a deterministic sorted order even when `sorted = false`.
