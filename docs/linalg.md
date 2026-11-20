---
docs_examples: true
---
# Linear algebra

Use `lr.linalg` for linear systems, factorizations, norms and matrix diagnostics.
The native backend uses BLAS and LAPACK. Use [matrix and vector products](vector_products.md)
for multiplying arrays or contracting axes.

## Solve a square system

`solve(A, b)` finds a vector `x` such that `A @ x = b` in mathematical notation.
Call `lr.matmul` to calculate the product in Lua. This example checks the residual.

```lua
local lr = require("luaray")
local A = lr.array({{3, 1}, {1, 2}}, "float64")
local b = lr.array({9, 8}, "float64")
local x = lr.linalg.solve(A, b)
assert(lr.allclose(x, {2, 3}))
assert(lr.allclose(lr.matmul(A, x), b))
```

Use `lstsq` for a least-squares system. Use `inv` when you specifically need
the inverse matrix and `det` when you need the determinant.

## Inspect a matrix

```lua
local values = lr.linalg.svdvals(A)
assert(values.shape[1] == 2)
assert(values:get(1) >= values:get(2))
assert(lr.allclose(lr.linalg.det(A), 5))
```

The [API inventory](api_inventory.md) lists the available `numpy.linalg` names.
Results from factorizations can vary with the LAPACK implementation. Read the
[numerical portability notes](portability.md) when interpreting tolerances.
