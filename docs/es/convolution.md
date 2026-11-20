---
docs_examples: true
---

# Convolución y correlación cruzada

`lr.convolve(a, b, mode)` calcula la convolución lineal discreta de dos
entradas unidimensionales. `lr.correlate(a, b, mode)` calcula la correlación
cruzada y conjuga la segunda entrada cuando contiene valores complejos.

`"full"` incluye todos los desplazamientos con solapamiento, incluso los
parciales de los extremos. Es el modo predeterminado de la convolución.
`"valid"` incluye solo el solapamiento completo y es el modo predeterminado de
la correlación. `"same"` devuelve el segmento central con la longitud de la
entrada más larga.

```lua
local lr = require("luaray")
local signal = lr.array({1, 2, 3, 4})
local kernel = lr.array({1, -1})
local filtered = lr.convolve(signal, kernel, "valid")
assert(lr.array_equal(filtered, {1, 1, 1}))
assert(lr.array_equal(lr.correlate(signal, kernel), {-1, -1, -1}))
```

Intercambiar los operandos de la correlación cruzada invierte la dirección del
desplazamiento y, para valores complejos, conjuga el resultado.

```lua
local a = {lr.complex(1, 2), lr.complex(3, 4)}
local b = {lr.complex(2, -1), lr.complex(0, 1)}
local c = lr.correlate(a, b, "full")
assert(lr.array_equal(lr.real(c), {2, 4, 2}))
assert(lr.array_equal(lr.imag(c), {-1, 2, 11}))
```

Ambas entradas deben contener al menos un valor. LuaRay también admite un
escalar como entrada de longitud uno. Las combinaciones de dtypes que requieren
el dtype objeto de NumPy generan un error.
