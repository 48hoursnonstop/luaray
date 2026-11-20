---
docs_examples: true
---

# Histogramas multidimensionales

`lr.histogram2d(x, y, options)` devuelve el histograma y los bordes de
los ejes x e y. `lr.histogramdd(samples, options)` devuelve el histograma
y una lista de vectores de bordes. En un ndarray bidimensional de
muestras, cada fila es un punto y cada columna es una coordenada. Una
lista de Lua puede pasar un vector por coordenada.

```lua
local lr = require("luaray")
local grid, xedges, yedges = lr.histogram2d({0, 0, 2, 2}, {0, 2, 0, 2}, {
  bins = {0, 1, 2}
})
assert(lr.array_equal(grid, {{1, 1}, {1, 1}}))
assert(lr.array_equal(xedges, yedges))
```

Usa un entero para fijar el número de intervalos en todas las
dimensiones, o pasa un conteo o vector de bordes por dimensión. En
`histogram2d`, una lista de tres o más bordes puede definir los mismos
límites para ambos ejes. El último intervalo incluye su borde derecho.
Los puntos que caen fuera de los límites se descartan.

```lua
local points = lr.array({{0, 0, 0}, {2, 1, 1}, {1, 1, 1}})
local counts, edges = lr.histogramdd(points, {
  bins = {2, 2, 2},
  range = {{0, 2}, false, false}
})
assert(counts:get(1, 1, 1) == 1 and counts:get(2, 2, 2) == 2)
assert(#edges == 3)
```

La opción `range` admite un par de extremos por eje. Usa `false` para
inferir el rango del eje a partir de sus datos. Pasa un peso real por
muestra con `weights`. Con `density = true`, cada intervalo se divide por
la masa total dentro del rango y por su volumen. Los intervalos vacíos
o de ancho cero siguen las reglas de división de punto flotante.
