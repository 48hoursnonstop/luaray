---
docs_examples: true
---

# Sumas y productos acumulados

`lr.cumulative_sum(input, options)` y `lr.cumulative_prod(input, options)`
acumulan los valores de un eje. La tabla de opciones admite `axis`, `dtype`,
`out` e `include_initial`. Con `include_initial = true`, la suma comienza en 0
y el producto en 1. La longitud del eje aumenta en uno, incluso si estaba vacío.

```lua
local lr = require("luaray")
local values = lr.array({{2, 3}, {4, 5}}, "int16")
local sums = lr.cumulative_sum(values, {axis = -1, include_initial = true})
assert(sums.shape[2] == 3)
assert(sums[1][1] == 0 and sums[1][3] == 5)
assert(sums[2][3] == 9)
```

Los ejes se numeran desde 1. También puedes usar un eje negativo. Un escalar se
convierte en un array de longitud uno. En una dimensión el eje predeterminado
es 1. Los arrays multidimensionales requieren un eje explícito. `cumsum` y
`cumprod` siguen aplanando la entrada si omites el eje.

```lua
local out = lr.empty({2, 3}, "float32")
local products = lr.cumulative_prod(values, {
  axis = 2, include_initial = true, dtype = "float32", out = out
})
assert(rawequal(products, out))
assert(products[2][1] == 1 and products[2][3] == 20)
```

El dtype selecciona la precisión del acumulador. El array de salida debe tener
la forma exacta del resultado y permitir escritura. Se aceptan vistas con
strides, incluso si se solapan con la entrada. La función devuelve ese array.

## Validación

Aprobaron **6 492 casos / 81 720 comprobaciones** con NumPy 2.5.5. Las pruebas comparan dtype, forma, strides, elementos de identidad, casos escalares y vacíos, y toda la memoria base de salidas con strides o solapamiento. El acumulador nativo valida la conversión del texto existente antes de sustituir los valores de salida.
