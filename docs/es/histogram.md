---
docs_examples: true
---

# Histogramas y densidades

`lr.histogram(values, options)` devuelve los conteos y después los bordes.
Los valores se leen en orden lógico C. Cada intervalo incluye su borde
izquierdo. El último también incluye su borde derecho.

```lua
local lr = require("luaray")
local counts, edges = lr.histogram({-1, 0, 1, 2, 2.9, 3, 4}, {
  bins = 3, range = {0, 3}
})
assert(table.concat(counts:tolist(), ",") == "1,1,3")
assert(edges[1] == 0 and edges[4] == 3)
```

Se puede usar un conteo de intervalos, un vector de bordes o un estimador
como se describe en [Elegir bordes de un histograma](histogram_edges.md).
Los valores fuera de esos bordes se ignoran.

```lua
local weights = lr.array({2, 5, 7, 11}, "int16")
local weighted = lr.histogram({1, 2, 2, 3}, {bins = {1, 2, 3}, weights = weights})
assert(weighted.dtype == "int16" and weighted[1] == 2 and weighted[2] == 23)
local density, edges = lr.histogram({0, 1, 2, 3, 4}, {
  bins = {0, 1, 4}, density = true
})
assert(math.abs(lr.sum(lr.multiply(density, lr.diff(edges))) - 1) < 2e-15)
```

Los pesos deben tener la misma forma que la entrada. Cada intervalo
acumula sus pesos en el dtype de estos. La densidad divide cada conteo
entre el ancho del intervalo y la suma de conteos. Con anchos positivos
y un peso total distinto de cero, la integral vale uno.
