---
docs_examples: true
---

# Locating values in bins

`lr.digitize(values, edges, right)` returns bin labels with the same shape
as the input. The one-dimensional edges may increase or decrease. Repeated
edges are valid.

```lua
local lr = require("luaray")
local x = lr.array({-1, 0, 4, 10})
local labels = lr.digitize(x, {0, 5, 10})
assert(table.concat(labels:tolist(), ",") == "0,1,1,3")
```

For increasing edges and the default `right = false`, bin `i` includes
`edges[i]` and ends before `edges[i + 1]`. With `right = true`, it starts
after `edges[i]` and includes `edges[i + 1]`. Decreasing edges reverse the
inequalities. Labels range from zero to the number of edges, including the
two outside bins.

```lua
assert(lr.digitize(5, {10, 5, 0}) == 1)
assert(lr.digitize(5, {10, 5, 0}, true) == 2)
```

Edges must safely convert to float64 for the monotonicity check. The actual
insertion search preserves the common dtype of edges and queries. This retains
large integer precision. For direct insertion positions and typed text or
temporal arrays, use `lr.searchsorted`, whose positions start at 1.

## Validation

**1,972 cases / 25,932 checks** passed with NumPy 2.5.5. The checks cover increasing and decreasing bins, equal edges, both boundary rules, numeric and typed search, sorted-indices inputs and strided keys.
