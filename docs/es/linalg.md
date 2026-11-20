---
docs_examples: true
---
# Álgebra lineal

Usa `lr.linalg` para resolver sistemas lineales, factorizar matrices, calcular
normas y examinar matrices. El motor nativo usa BLAS y LAPACK. Consulta
[productos de matrices y vectores](vector_products.md) para multiplicar arrays
o contraer ejes.

## Resolver un sistema cuadrado

`solve(A, b)` encuentra un vector `x` que satisface `A @ x = b` en notación
matemática. En Lua, calcula el producto con `lr.matmul`. El ejemplo comprueba
el residuo.

```lua
local lr = require("luaray")
local A = lr.array({{3, 1}, {1, 2}}, "float64")
local b = lr.array({9, 8}, "float64")
local x = lr.linalg.solve(A, b)
assert(lr.allclose(x, {2, 3}))
assert(lr.allclose(lr.matmul(A, x), b))
```

Usa `lstsq` para resolver un sistema por mínimos cuadrados. Usa `inv` cuando
necesites la matriz inversa y `det` cuando necesites el determinante.

## Examinar una matriz

```lua
local values = lr.linalg.svdvals(A)
assert(values.shape[1] == 2)
assert(values:get(1) >= values:get(2))
assert(lr.allclose(lr.linalg.det(A), 5))
```

El [inventario de API](api_inventory.md) enumera los nombres disponibles de
`numpy.linalg`. Las factorizaciones pueden variar según la implementación de
LAPACK. Consulta la [portabilidad numérica](portability.md) al interpretar
tolerancias.
