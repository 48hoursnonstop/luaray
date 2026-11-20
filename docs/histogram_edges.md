---
docs_examples: true
---

# Choosing histogram edges

`lr.histogram_bin_edges(values, options)` returns the boundaries of a
histogram. Set `bins` to a positive integer for equal-width intervals.
The default is 10 bins. An optional `range = {minimum, maximum}` sets the
outer boundaries. Otherwise they are derived from the input.

```lua
local lr = require("luaray")
local values = lr.array({1, 2, 3, 4, 8, 10})
local edges = lr.histogram_bin_edges(values, {bins = 3})
assert(edges.size == 4 and edges[1] == 1 and edges[4] == 10)
assert(edges[2] == 4 and edges[3] == 7)
```

An explicit vector of edges can contain repeated values and must be
nondecreasing. An estimator name selects the number of equal-width bins
from the values inside the range.

```lua
local automatic = lr.histogram_bin_edges(values, {bins = "auto"})
assert(automatic.size == 5)
assert(automatic[1] == 1 and automatic[5] == 10)
local explicit = lr.array({0, 2, 2, 12}, "float32")
assert(rawequal(lr.histogram_bin_edges(values, {bins = explicit}), explicit))
```

The estimators are `auto`, `fd`, `doane`, `scott`, `stone`, `rice`,
`sturges` and `sqrt`. They use real unweighted data. The `weights` option
checks an array's shape when using a fixed count or explicit edges.
