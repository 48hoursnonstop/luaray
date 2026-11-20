---
docs_examples: true
---

# Multidimensional histograms

`lr.histogram2d(x, y, options)` returns the histogram, x edges and y edges.
`lr.histogramdd(samples, options)` returns the histogram and a list of
edge vectors. For a two-dimensional ndarray of samples, each row is a
point and each column is a coordinate. A Lua list can supply one vector
per coordinate.

```lua
local lr = require("luaray")
local grid, xedges, yedges = lr.histogram2d({0, 0, 2, 2}, {0, 2, 0, 2}, {
  bins = {0, 1, 2}
})
assert(lr.array_equal(grid, {{1, 1}, {1, 1}}))
assert(lr.array_equal(xedges, yedges))
```

Use one integer bin count for every dimension, or provide a count or edge
vector for each dimension. In `histogram2d`, a list of three or more edges can
supply the same boundaries for both dimensions. The last interval includes its
right edge. Points outside the boundaries are discarded.

```lua
local points = lr.array({{0, 0, 0}, {2, 1, 1}, {1, 1, 1}})
local counts, edges = lr.histogramdd(points, {
  bins = {2, 2, 2},
  range = {{0, 2}, false, false}
})
assert(counts:get(1, 1, 1) == 1 and counts:get(2, 2, 2) == 2)
assert(#edges == 3)
```

An optional `range` supplies a pair of endpoints for each axis. Use
`false` to infer an axis range from its data. Pass one real weight per
sample with `weights`. When `density = true`, each bin is divided by the total
in-range mass and by the bin volume. Empty bins and zero-width intervals
follow floating-point division rules.

## Validation

**1,311 cases / 75,968 checks** passed with NumPy 2.5.5. The checks cover both sample layouts, typed and shared edge vectors, weights, density, outlier exclusion and the result strides for sliced count matrices.
