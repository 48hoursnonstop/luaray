---
docs_examples: true
---

# Bloques y recorte de ceros

`lr.block(values)` arma un ndarray con listas de bloques anidadas.
Las listas más internas se concatenan por el último eje. Cada nivel
hacia afuera mueve la unión al eje anterior. Los operandos con menos
dimensiones ganan ejes iniciales de longitud uno.

```lua
local lr = require("luaray")
local left = lr.array({{1, 2}, {3, 4}})
local right = lr.array({{5}, {6}})
local top = lr.block({left, right})
local result = lr.block({{left, right}, {top}})
assert(lr.array_equal(result, {{1, 2, 5}, {3, 4, 6}, {1, 2, 5}, {3, 4, 6}}))
```

Usa ndarrays o escalares en las hojas. Todas las ramas deben tener la
misma profundidad. Las formas deben coincidir fuera del eje de unión
de cada nivel. El resultado tiene almacenamiento propio.

`lr.trim_zeros(values, trim, axis)` quita cortes exteriores formados
solo por ceros. Omite `axis` para recortar todos los ejes, o pasa un eje
o una lista de ejes. Usa `"f"` para recortar el inicio, `"b"` para el
final o `"fb"` para ambos.

```lua
local values = lr.array({{0, 0, 0}, {0, 5, 0}, {0, 6, 0}, {0, 0, 0}})
local crop = lr.trim_zeros(values)
assert(lr.array_equal(crop, {{5}, {6}}))
assert(lr.shares_memory(crop, values))
```

El recorte de un ndarray es una vista. Una lista unidimensional de Lua
devuelve otra lista de Lua. Si todos los datos son cero, los ejes
seleccionados quedan con longitud cero.

## Validación

Aprobaron **3 575 casos / 83 056 comprobaciones** con NumPy 2.5.5. Las pruebas cubren dimensiones de bloques anidados, formas fuera del eje de unión, salidas grandes en orden Fortran, cortes exteriores y memoria compartida. El recorte de una lista unidimensional de Lua conserva la lista.
