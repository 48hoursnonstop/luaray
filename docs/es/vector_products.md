---
docs_examples: true
---

# Productos de matrices y vectores

`lr.matvec(a, b)` contrae una matriz con un vector. Las últimas dos
dimensiones de `a` son las filas y las columnas. La última dimensión de
`b` debe coincidir con las columnas. Los ejes iniciales admiten broadcasting.

```lua
local lr = require("luaray")
local matrix = lr.array({{1, 2}, {3, 4}})
local result = lr.matvec(matrix, {2, 1})
assert(result[1] == 4 and result[2] == 10)
local repeats = lr.empty({3, 2}, "float64")
assert(rawequal(lr.matvec(matrix, {2, 1}, {out = repeats}), repeats))
assert(repeats[3][2] == 10)
```

`lr.vecmat(a, b)` contrae la última dimensión de un vector con la
penúltima de una matriz. `lr.vecdot(a, b)` contrae la última dimensión de
ambas entradas. Las dos conjugan la primera entrada con dtypes complejos.
`lr.vdot(a, b)` también conjuga la primera entrada y aplana ambos arrays en
orden C antes de la contracción.

```lua
local a = lr.array({lr.complex(1, 2)})
local b = lr.array({lr.complex(3, 4)})
assert(lr.vecdot(a, b) == lr.complex(11, -2))
assert(lr.vdot(a:reshape({1, 1}), b) == lr.complex(11, -2))
```

`matvec`, `vecmat` y `vecdot` admiten un ndarray de salida o una tabla con
un campo `out`. Las dimensiones de la contracción deben coincidir. Los ejes
iniciales pueden ampliar el lote por broadcasting. La función devuelve el
array suministrado. Para contraer otro eje, usa `lr.linalg.vecdot` con un
índice desde 1 o un eje negativo.
