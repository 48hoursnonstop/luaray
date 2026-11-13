---
docs_examples: true
---
# Aplicar un callback sobre varios ejes

`lr.apply_over_axes(callback, input, axes)` invoca una función sobre todo el array
intermedio, un eje cada vez. `axes` es un entero Lua distinto de cero o una tabla
densa de ejes. Los positivos empiezan en uno; los negativos cuentan desde el
final. Se procesan en el orden indicado, incluidas las repeticiones.

```lua
local lr = require("luaray")
local values = lr.arange(24):reshape({2, 3, 4})
local totals = lr.apply_over_axes(lr.sum, values, {1, 3})
assert(totals.shape[1] == 1 and totals.shape[3] == 1)
assert(totals:get(1, 1, 1) == 60)
assert(totals:get(1, 3, 1) == 124)
```

## Restaurar los ejes reducidos

El callback recibe `(array, axis)`. Si devuelve una dimensión menos, se inserta
una dimensión de tamaño uno en ese eje. Si devuelve el mismo rango, se usa
directamente, aunque cambie la forma. Otros cambios de rango generan un error.
Cada invocación posterior recibe el resultado anterior con sus ejes restaurados.

```lua
local order = {}
local kept = lr.apply_over_axes(function(array, axis)
  order[#order+1] = axis
  return lr.sum(array, {axis = axis, keepdims = true})
end, values, {1, -1})
assert(order[1] == 1 and order[2] == 3)
assert(kept:get(1, 2, 1) == 92)
local invalid = pcall(lr.apply_over_axes, function() return 5 end, values, 1)
assert(not invalid) -- El escalar pierde más de uno de los tres ejes.
```

El callback comprueba los ejes según su operación. Los negativos se normalizan
una vez respecto al rango original antes de la llamada, como en la referencia;
no se añade una validación global de límites. Los resultados se convierten a
ndarrays. Para un resultado escalar, un ndarray tipado conserva un dtype explícito;
los números Lua siguen la inferencia habitual de tipos escalares.

## Identidad, cambios y selección vacía

Una tabla vacía de ejes devuelve la entrada convertida sin invocar la función.
Devolver la misma entrada conserva su identidad. Solo se reserva almacenamiento
nuevo si la operación lo requiere. Modificar una vista intermedia puede cambiar
la entrada original. Los errores se propagan sin cambiar su identidad y conservan
las escrituras anteriores. Se aceptan tablas Lua invocables.

```lua
assert(rawequal(lr.apply_over_axes(7, values, {}), values))
local unchanged = lr.apply_over_axes(function(array) return array end, values, 2)
assert(rawequal(unchanged, values))
local reduced = lr.apply_over_axes(lr.sum, {1, 2, 3}, 1)
assert(reduced.shape[1] == 1 and reduced[1] == 6)
```

`squeeze()` también conserva ahora la identidad si no elimina ningún eje,
incluida una selección vacía explícita. Si elimina ejes de tamaño uno, sigue
devolviendo una vista compartida.

```lua
local matrix = lr.ones({2, 3})
assert(rawequal(lr.squeeze(matrix), matrix))
local singleton = lr.ones({1, 3})
assert(rawequal(lr.squeeze(singleton, {}), singleton))
local squeezed = lr.squeeze(singleton)
assert(not rawequal(squeezed, singleton))
assert(lr.shares_memory(squeezed, singleton))
```

## Compatibilidad

La referencia aprobó **129 600 casos /4 188 479 comprobaciones** y 196 comprobaciones Lua permanentes. Se normalizaron explícitamente 8 774 resultados escalares de callbacks a ndarrays de dimensión cero, con la inferencia de tipos y escritura de Lua; no se afirma equivalencia con los objetos escalares Python. Los valores/metadatos de arrays y las llamadas se comparan tras esa adaptación. El corpus se regeneró exactamente.

La API es parcial. Los ejes usan enteros y tablas Lua; no hay ejes ndarray,
protocolos Python Boolean/float ni despacho externo. Las secuencias Lua se
convierten antes de leer su rango. Los resultados escalares Lua se convierten
a ndarrays; no reproducen las clases escalares Python. No se certifican todas
las subclases, dtypes, funciones de usuario ni ABI.

Para callbacks sobre secciones unidimensionales usa
[apply_along_axis](axis_callbacks.md). Para una sola reducción de varios ejes,
las opciones axis/keepdims del reductor pueden ser más directas.
