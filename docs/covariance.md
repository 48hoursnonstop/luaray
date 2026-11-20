---
docs_examples: true
---

# Covariance and correlation

`lr.cov(observations, options)` returns a sample covariance matrix.
`lr.corrcoef(observations, options)` returns the corresponding Pearson
correlation matrix. Each row is a variable by default. Set `rowvar = false`
when variables are columns. Pass a second set of variables as `y` with the
same number of observations.

```lua
local lr = require("luaray")
local x = lr.array({{0, 1, 2}, {0, 2, 4}})
local cov = lr.cov(x)
assert(lr.allclose(cov, {{1, 2}, {2, 4}}))
local corr = lr.corrcoef(lr.transpose(x), {rowvar = false})
assert(lr.allclose(corr, {{1, 1}, {1, 1}}))
```

Covariance defaults to dividing by the observation count minus one.
Set `bias = true` to divide by the full count, or set `ddof` explicitly.
`fweights` specifies nonnegative integer repetition counts. `aweights`
specifies nonnegative real weights. Supply one value per observation.

```lua
local weighted = lr.cov(x, {fweights = {1, 2, 1}})
assert(lr.allclose(weighted, {{2/3, 4/3}, {4/3, 8/3}}))
local scalar_cov = lr.cov({0, 1, 2})
assert(scalar_cov.ndim == 0 and scalar_cov:item() == 1)
```

The default dtype has at least the precision of `float64`; use `dtype`
to request another floating or complex dtype. Complex covariance uses
conjugation, and correlation clips the two components separately.
A single variable produces a zero-dimensional covariance array. Its
correlation uses the library's scalar conversion for its dtype. A constant
variable has undefined correlation.

## Validation

**2,479 cases / 102,908 checks** passed with NumPy 2.5.5. The checks cover rows and columns, weighted and unweighted observations, complex conjugation and normalization. For 1,200 components with zero normalization and a near-zero finite reference numerator, the checks allow either NaN or infinity across BLAS builds.
