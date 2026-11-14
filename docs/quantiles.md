---
docs_examples: true
---
# Quantiles and medians

`lr.median`, `lr.quantile` and `lr.percentile` select values from real numeric
arrays. Quantile fractions run from zero to one; percentiles from zero to 100.
The default interpolation method is `"linear"`. Inputs are preserved.

```lua
local lr = require("luaray")
local values = lr.array({1, 2, 3, 4}, "float64")
assert(lr.median(values) == 2.5)
assert(lr.quantile(values, 0.25) == 1.75)
assert(lr.percentile(values, 25) == 1.75)
```

## Axes and retained dimensions

Omitting `axis` reduces the whole array. Positive axes start at one; negative
axes count from the end. A table selects several axes. `keepdims = true`
retains reduced axes with length one as a view with zero strides on those axes.
Unreduced dimensions preserve their order.

```lua
local matrix = lr.array({{1, 2, 3}, {4, 5, 6}}, "float64")
local rows = lr.median(matrix, {axis = 2})
assert(rows[1] == 2 and rows[2] == 5)
local columns = lr.median(matrix, {axis = 1, keepdims = true})
assert(columns:get(1, 2) == 3.5)
assert(columns.strides[1] == 0 and not columns.flags.owndata)
```

Medians retain the physical order of the remaining axes through the source's
KEEPORDER rules and multi-axis preprocessing. Quantile outputs use the source's
C allocation order. A retained view keeps its own result buffer alive; it does
not share the original input's data.

## Fractions and result dtype

A scalar fraction gives a scalar result when all axes are reduced. A fraction
vector adds a leading output dimension. Integer inputs use floating results
for interpolation; discontinuous methods retain the input dtype. Fraction
vectors participate in dtype promotion, including preserving `longdouble`.

```lua
local q = lr.quantile(values, {0.25, 0.5, 0.75})
assert(q.size == 3 and q[1] == 1.75 and q[3] == 3.25)
local wide = lr.array({1, 2, 3, 4}, "longdouble")
assert(lr.quantile(wide, {0.25, 0.5}).dtype == "longdouble")
assert(lr.quantile(lr.array({1, 2, 3, 4}, "int32"), 0.25, {
  method = "lower"
}) == 1)
```

Supported methods are `linear`, `lower`, `higher`, `nearest`, `midpoint` and
`inverted_cdf`. Median does not accept a method. Fractions must be a number or
a nonempty one-dimensional Lua/typed vector. Internally fraction values still
pass through double-precision parameters, including typed longdouble fractions;
preserving a result dtype does not certify extended fractional precision.

## Empty retained axes in NumPy 2.5.4

A zero-length dimension that is retained can produce a valid empty result.
NumPy 2.5.4 fixes the multi-axis reshape that previously rejected some of these
calls. LuaRay follows that behavior, including the fraction-vector dimension.

```lua
local empty = lr.empty({0, 3, 4}, "float32")
local q = lr.quantile(empty, {0.25, 0.5}, {axis = {2, 3}})
assert(q.shape[1] == 2 and q.shape[2] == 0)
local median = lr.median(empty, {axis = {2, 3}, keepdims = true})
assert(median.shape[1] == 0 and median.shape[2] == 1 and median.shape[3] == 1)
assert(not median.flags.owndata)
```

## An empty axis selection

`axis = {}` selects no axes. Each existing element is treated as a one-element
slice; empty retained shapes remain empty. This differs from omitting `axis`.
An empty *reduced* slice still rejects ordinary quantiles. Its median is NaN;
LuaRay does not reproduce Python's warning machinery.

```lua
local empty = lr.empty({3, 0}, "float64")
local q = lr.quantile(empty, 0.25, {axis = {}})
assert(q.shape[1] == 3 and q.shape[2] == 0)
assert(not pcall(lr.quantile, empty, 0.25, {axis = 2}))
local median = lr.median(empty, {axis = 2})
assert(median.size == 3 and median[1] ~= median[1])
```

## Existing output buffers

`out` must have the exact output shape and be writable. Successful calls return
that same userdata. `keepdims`, `axis`, `out` and the supported method are the
available controls; weights and overwrite-input behavior are not implemented.

```lua
local output = lr.zeros({2}, "float64")
local result = lr.quantile(matrix, 0.5, {axis = 2, out = output})
assert(rawequal(result, output) and output[1] == 2 and output[2] == 5)
assert(not pcall(lr.quantile, matrix, 0.5, {axis = 2, out = lr.zeros({3})}))
assert(not pcall(lr.quantile, values, 0.5, {weights = {1, 1, 1, 1}}))
```

The APIs remain partial. General floating interpolation bit parity, every dtype,
weighted quantiles, the remaining interpolation methods, empty fraction vectors,
foreign protocols and exact Python scalar/exception/warning classes are not
certified. The NumPy 2.5.4 update has its own references; historical corpora
retain their original version attribution.

## 0.158.0-dev verification

The NumPy 2.5.4 migration passed **61,332 new focused cases /617,872 checks**, plus **2,700 regenerated historical quantile cases** (their individual assertion count is excluded from617,872). It covers empty retained axes, empty axis selections, median K-order layout, retained keepdims views, dtype promotion, nonfinite linear algebra and accumulation output validation. Another130 permanent Lua checks and the native harness cover scalar keepdims, retained storage and extreme strides on empty reductions. NaN outputs compare numerical classification; x87 padding is omitted. Finite linalg controls use absolute+relative3e-6 for single precision and2e-12 for wider types; the historical quantile tolerance remains0.002. All four corpora regenerated exactly.

