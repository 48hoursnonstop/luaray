---
docs_examples: true
---

# Valores y cortes únicos

`lr.unique(input, options)` devuelve los valores distintos en orden. Por
defecto aplana la entrada en orden C. Usa `axis` para comparar cortes
completos en orden lexicográfico. Los ejes admiten posiciones desde 1 y
posiciones negativas.

```lua
local lr = require("luaray")
local input = lr.array({3, 1, 3, 2, 1}, "int32")
local values, first, inverse, counts = lr.unique(input, {
  return_index = true, return_inverse = true, return_counts = true
})
assert(table.concat(values:tolist(), ",") == "1,2,3")
assert(table.concat(first:tolist(), ",") == "2,4,1")
assert(table.concat(lr.take(values, inverse):tolist(), ",") == "3,1,3,2,1")
assert(table.concat(counts:tolist(), ",") == "2,1,2")
```

Los resultados auxiliares aparecen en ese orden cuando los solicitas.
Ambos arrays de índices usan posiciones desde 1. Con un eje explícito en
un array multidimensional, el inverso es un vector a lo largo del eje.
En los demás casos conserva la forma de la entrada.

```lua
local a = lr.array({{3, 2}, {1, 1}, {3, 2}})
local rows, first = lr.unique(a, {axis = 1, return_index = true})
assert(rows.shape[1] == 2 and rows[1][1] == 1 and first[2] == 1)
local all = lr.unique_all({7, 3, 7})
assert(all.values[1] == 3 and all.counts[2] == 2)
```

`unique_values` devuelve el array de valores. `unique_counts`,
`unique_inverse` y `unique_all` devuelven tablas con los campos que
corresponden entre `values`, `indices`, `inverse_indices` y `counts`.
Las funciones de Array API usan `equal_nan = false`. `unique` usa
`equal_nan = true` por defecto para entradas numéricas aplanadas.
LuaRay conserva un orden determinista incluso con `sorted = false`.
