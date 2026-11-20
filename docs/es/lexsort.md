---
docs_examples: true
---

# Ordenación estable por varias claves

`lr.lexsort(keys, axis)` devuelve los índices desde 1 que ordenan cada corte
lexicográficamente. Pasa claves de la misma forma en una tabla Lua o pon cada
clave en un corte del primer eje de un ndarray. La última clave es la
principal, la anterior desempata y los empates completos conservan su orden.

```lua
local lr = require("luaray")
local names = lr.array({"Zoe", "Ada", "Ada", "Lin"}, "U3")
local scores = lr.array({2, 2, 1, 2})
local order = lr.lexsort({names, scores})
assert(table.concat(order:tolist(), ",") == "3,2,4,1")
assert(lr.take(names, order)[4] == "Zoe")
```

El eje predeterminado es el último. Admite posiciones positivas y negativas.
El array de índices tiene la misma forma que cada clave.

```lua
local minor = lr.array({{2, 1, 3}, {1, 0, 2}})
local major = lr.array({{0, 0, 0}, {1, 2, 1}})
local order = lr.lexsort({minor, major}, 2)
assert(table.concat(order[1]:tolist(), ",") == "2,1,3")
assert(table.concat(order[2]:tolist(), ",") == "1,3,2")
```

Se admiten claves numéricas, complejas, de texto fijo y temporales. Las claves
Unicode con orden de bytes no nativo siguen la inversión por elemento de NumPy
2.5.5. Para ordenar por puntos de código, convierte esas claves a Unicode
nativo antes de llamar la función.
