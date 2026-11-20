---
docs_examples: true
---

# Histograms and densities

`lr.histogram(values, options)` returns the bin counts followed by the
edges. Values are read in logical C order. Each interval includes its left
edge. The last interval also includes its right edge.

```lua
local lr = require("luaray")
local counts, edges = lr.histogram({-1, 0, 1, 2, 2.9, 3, 4}, {
  bins = 3, range = {0, 3}
})
assert(table.concat(counts:tolist(), ",") == "1,1,3")
assert(edges[1] == 0 and edges[4] == 3)
```

Use a bin count, a vector of edges, or an estimator name as described in
[Choosing histogram edges](histogram_edges.md). Values outside the range
of the returned edges are ignored.

```lua
local weights = lr.array({2, 5, 7, 11}, "int16")
local weighted = lr.histogram({1, 2, 2, 3}, {bins = {1, 2, 3}, weights = weights})
assert(weighted.dtype == "int16" and weighted[1] == 2 and weighted[2] == 23)
local density, edges = lr.histogram({0, 1, 2, 3, 4}, {
  bins = {0, 1, 4}, density = true
})
assert(math.abs(lr.sum(lr.multiply(density, lr.diff(edges))) - 1) < 2e-15)
```

Weights must have the same shape as the input. With weights, each bin
accumulates its weights in their dtype. Density divides each count by its
bin width and the sum of counts. This gives unit integral for positive
widths and nonzero total weight.

## Validation

**1,022 cases / 35,125 checks** passed with NumPy 2.5.5. The checks cover weighted and unweighted counts, right-inclusive last bins, density, complex weights, nonfinite data and arrays spanning multiple processing blocks.
