---
docs_examples: true
---

# Polynomial roots and characteristic polynomials

`lr.roots(coefficients)` finds the roots of a polynomial whose
coefficients descend by power. Trailing zero coefficients contribute
roots at zero. The implementation solves the eigenvalue problem for
the polynomial's companion matrix using LAPACK.

```lua
local lr = require("luaray")
local roots = lr.roots({1, -3, 2})
assert(lr.allclose(lr.sort(roots), {1, 2}))
local z = lr.roots({1, 0, 1})
assert(lr.allclose(lr.sort(lr.imag(z)), {-1, 1}))
```

`lr.poly(roots)` forms the monic polynomial with those roots.
Pass a nonempty square matrix instead to form its characteristic
polynomial.

```lua
assert(lr.array_equal(lr.poly({1, 2, 3}), {1, -6, 11, -6}))
local a = lr.array({{1, 0}, {0, 2}})
assert(lr.allclose(lr.poly(a), {1, -3, 2}))
```

Root order may vary by LAPACK build. Compare roots as an unordered
collection when order does not matter. The solver uses the supported
real and complex LAPACK dtypes. `lr.mintypecode(codes, typeset, default)`
selects a legacy type character using NumPy's type code precedence.
