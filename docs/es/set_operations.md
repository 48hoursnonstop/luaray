---
docs_examples: true
---

# Operaciones de conjuntos

`lr.union1d`, `lr.intersect1d`, `lr.setdiff1d` y `lr.setxor1d` operan sobre
los valores de dos arrays aplanados en orden C.

| Operación | Valores devueltos |
| --- | --- |
| `union1d(a, b)` | Valores de alguna de las entradas |
| `intersect1d(a, b)` | Valores presentes en ambas entradas |
| `setdiff1d(a, b)` | Valores de `a` ausentes de `b` |
| `setxor1d(a, b)` | Valores presentes en exactamente una entrada |

```lua
local lr = require("luaray")
local a = lr.array({3, 1, 3, 2})
local b = lr.array({1, 2, 2, 5})
assert(table.concat(lr.union1d(a, b):tolist(), ",") == "1,2,3,5")
assert(table.concat(lr.setdiff1d(a, b):tolist(), ",") == "3")
assert(table.concat(lr.setxor1d(a, b):tolist(), ",") == "3,5")
```

Usa `return_indices = true` en `intersect1d` para recibir dos arrays
adicionales con las primeras posiciones desde 1 en las entradas aplanadas.

```lua
local values, left, right = lr.intersect1d(a, b, {return_indices = true})
assert(table.concat(values:tolist(), ",") == "1,2")
assert(table.concat(left:tolist(), ",") == "2,4")
assert(table.concat(right:tolist(), ",") == "1,2")
```

Las tres operaciones con opciones admiten `assume_unique = true` cuando
ambas entradas contienen valores distintos. Con esa opción, `setdiff1d`
conserva el orden de la primera entrada. Por defecto devuelve un conjunto
ordenado.
