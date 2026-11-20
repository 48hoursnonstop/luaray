---
docs_examples: true
---

# Elegir bordes de un histograma

`lr.histogram_bin_edges(values, options)` devuelve los límites de un
histograma. Usa un entero positivo en `bins` para intervalos del mismo
ancho. El valor predeterminado es 10. La opción
`range = {mínimo, máximo}` fija los extremos. De lo contrario se calculan
a partir de los datos.

```lua
local lr = require("luaray")
local values = lr.array({1, 2, 3, 4, 8, 10})
local edges = lr.histogram_bin_edges(values, {bins = 3})
assert(edges.size == 4 and edges[1] == 1 and edges[4] == 10)
assert(edges[2] == 4 and edges[3] == 7)
```

Un vector explícito admite bordes repetidos y debe estar ordenado de menor
a mayor. Un estimador elige la cantidad de intervalos del mismo ancho con
los datos del rango seleccionado.

```lua
local automatic = lr.histogram_bin_edges(values, {bins = "auto"})
assert(automatic.size == 5)
assert(automatic[1] == 1 and automatic[5] == 10)
local explicit = lr.array({0, 2, 2, 12}, "float32")
assert(rawequal(lr.histogram_bin_edges(values, {bins = explicit}), explicit))
```

Los estimadores disponibles son `auto`, `fd`, `doane`, `scott`, `stone`,
`rice`, `sturges` y `sqrt`. Usan datos reales sin pesos. Con un conteo de
intervalos o bordes explícitos, la opción `weights` verifica la forma
del array.
