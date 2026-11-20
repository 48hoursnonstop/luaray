---
docs_examples: true
---

# Ubicar valores en intervalos

`lr.digitize(values, edges, right)` devuelve etiquetas de intervalos con
la misma forma que la entrada. El array unidimensional de bordes puede
crecer o decrecer y admite bordes repetidos.

```lua
local lr = require("luaray")
local x = lr.array({-1, 0, 4, 10})
local labels = lr.digitize(x, {0, 5, 10})
assert(table.concat(labels:tolist(), ",") == "0,1,1,3")
```

Para bordes crecientes y el valor predeterminado `right = false`, el
intervalo `i` incluye `edges[i]` y termina antes de `edges[i + 1]`.
Con `right = true` empieza después de `edges[i]` e incluye
`edges[i + 1]`. Los bordes decrecientes invierten las desigualdades.
Las etiquetas van de cero al número de bordes e incluyen los dos
intervalos exteriores.

```lua
assert(lr.digitize(5, {10, 5, 0}) == 1)
assert(lr.digitize(5, {10, 5, 0}, true) == 2)
```

Los bordes deben convertirse de forma segura a float64 para comprobar
su orden. La búsqueda conserva el dtype común de bordes y valores, con
la precisión de los enteros grandes. Para posiciones de inserción
directas y arrays de texto o temporales, usa `lr.searchsorted`, cuyas
posiciones empiezan en 1.

## Validación

Aprobaron **1 972 casos / 25 932 comprobaciones** con NumPy 2.5.5. Las pruebas cubren bordes ascendentes y descendentes, bordes iguales, las dos reglas de frontera, búsqueda numérica y tipada, índices ordenados y claves con strides.
