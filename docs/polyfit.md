---
docs_examples: true
---

# Fitting polynomials

`lr.polyfit(x, y, degree, options)` fits coefficients in decreasing
power order by least squares. `x` is a vector of sample locations.
`y` is a vector, or a matrix with one response series per column.

```lua
local lr = require("luaray")
local x = lr.array({0, 1, 2, 3, 4})
local y = lr.array({3, 6, 11, 18, 27})
local coefficients = lr.polyfit(x, y, 2)
assert(lr.allclose(coefficients, {1, 2, 3}))
assert(lr.allclose(lr.polyval(coefficients, x), y))
```

Use `w` to apply one weight per observation before squaring the residual.
`rcond` sets the relative singular-value cutoff. The default is the
number of observations multiplied by the precision of the floating x dtype.

```lua
local coefficients, residuals, rank, singular, rcond = lr.polyfit(x, y, 2, {
  w = {1, 2, 3, 1, 2},
  full = true
})
assert(rank == 3 and singular.size == 3 and rcond > 0)
assert(residuals[1] < 1e-20)
```

With `full = true` the additional results are residuals, rank, singular
values and the cutoff. Otherwise `cov = true` returns scaled covariance
as a second result. Use `cov = "unscaled"` to omit the residual scaling.
For multiple responses the scaled covariance has one matrix per response
along its last axis.
