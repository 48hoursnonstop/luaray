---
docs_examples: true
---

# Reemplazar valores no finitos y evaluar por partes

`lr.nan_to_num(values, options)` reemplaza NaN por cero y los infinitos
por el mayor o menor valor finito del dtype flotante. Cambia los
reemplazos con `nan`, `posinf` y `neginf`, que también admiten arreglos
compatibles con broadcasting. En valores complejos las reglas se
aplican por separado a las partes real e imaginaria.

```lua
local lr = require("luaray")
local values = lr.array({0/0, math.huge, -math.huge, 4}, "float32")
local finite = lr.nan_to_num(values, {nan = 0, posinf = 10, neginf = -10})
assert(lr.array_equal(finite, {0, 10, -10, 4}))
assert(lr.isnan(values[1]))
```

Por defecto se crea una copia. Usa `copy = false` para reemplazar
directamente en un ndarray modificable. Los enteros y booleanos
conservan sus valores.

`lr.piecewise(values, conditions, functions, ...)` aplica cada función
solo a los valores que selecciona su máscara booleana. Puedes pasar
una constante en lugar de una función. Una entrada adicional al final
cubre los valores restantes, que de otro modo quedan en cero. Si hay
solapamiento, prevalece la última máscara. Los argumentos adicionales
se pasan a las funciones.

```lua
local x = lr.array({-2, -1, 0, 1, 2})
local y = lr.piecewise(x, {lr.less(x, 0), lr.greater(x, 0)}, {
  function(v, scale) return -v * scale end,
  1,
  5
}, 3)
assert(lr.array_equal(y, {6, 3, 5, 1, 1}))
```

`lr.pow` es un alias de `lr.power`. La función histórica `lr.fix(x, out)`
trunca hacia cero, igual que `lr.trunc`.

## Validación

Aprobaron **2 025 casos / 46 176 comprobaciones** con NumPy 2.5.5. Las pruebas cubren reemplazos sobre copias o vistas, componentes complejos, callbacks con máscaras y los dos alias numéricos. Se comparan las posiciones de NaN y los demás bytes exactos de las entradas modificadas.
