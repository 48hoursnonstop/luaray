---
docs_examples: true
---

# Polynomial coefficient operations

Polynomial coefficients are ordered from highest to lowest power.
`{1, -2, 3}` represents `x² - 2x + 3`. `lr.polyadd` and `lr.polysub`
align constant terms. `lr.polymul` multiplies two polynomials through
discrete convolution.

```lua
local lr = require("luaray")
local p = lr.polymul({1, -1}, {1, 1})
assert(lr.array_equal(p, {1, 0, -1}))
assert(lr.array_equal(lr.polyadd(p, {3}), {1, 0, 2}))
```

`lr.polyder(coefficients, order)` differentiates the polynomial.
`lr.polyint(coefficients, order, constants)` integrates it. The
default order is one. The integration constants default to zero and
can be supplied as one scalar or a vector with one entry per integration.

```lua
local coefficients = lr.polyint({2, 4}, 1, 10)
assert(lr.array_equal(coefficients, {1, 4, 10}))
assert(lr.array_equal(lr.polyder(coefficients), {2, 4}))
assert(lr.array_equal(lr.polyval(coefficients, {0, 1, 2}), {10, 15, 22}))
```

`lr.polyval(coefficients, x)` evaluates using Horner's method. The
evaluation points can be a scalar or an ndarray. Complex coefficients
and points follow numeric promotion.
