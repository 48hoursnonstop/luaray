---
docs_examples: true
---

# Ordenar fechas, texto y valores complejos

`lr.sort(values, options)` ordena por el último eje de forma
predeterminada. Usa `axis` para elegir otro eje o `descending = true`
para invertir la comparación. `lr.argsort` devuelve posiciones
indexadas desde uno en el mismo eje. Las cadenas de bytes de ancho
fijo se comparan por bytes y las cadenas Unicode por puntos de
código. Las fechas y duraciones se ordenan por sus ticks, con NaT
al final en ambos sentidos.

```lua
local lr = require("luaray")
local dates = lr.array({3, 1, math.mininteger, -1}, "datetime64[D]")
local ranks = lr.argsort(dates)
assert(lr.array_equal(ranks, {4, 2, 1, 3}))
local sorted = lr.sort(dates):view("int64")
assert(lr.array_equal(sorted, {-1, 1, 3, math.mininteger}))
```

`lr.sort_complex(values)` ordena por el último eje y devuelve un
arreglo complejo. Si la entrada es compleja, compara primero la parte
real y después la imaginaria. El resultado conserva el dtype complejo
de entrada. Para datos reales, el dtype complejo se elige según el
dtype de origen.

```lua
local z = lr.sort_complex({lr.complex(2, -1), lr.complex(1, 3), lr.complex(1, -2)})
assert(lr.array_equal(lr.real(z), {1, 1, 2}))
assert(lr.array_equal(lr.imag(z), {-2, 3, -1}))
```
