---
docs_examples: true
---
# Diferencias finitas

`diff` resta valores adyacentes sobre un eje. `ediff1d` aplana primero la entrada
en orden C lógico. Ambas usan aritmética nativa tipada y admiten ndarrays o
secuencias Lua rectangulares.

## Diferencias de primer orden y sucesivas

```lua
local lr = require("luaray")
local values = lr.array({1, 4, 9}, "int64")
local first = lr.diff(values)
assert(first[1] == 3 and first[2] == 5)
assert(lr.diff(values, 2)[1] == 2)
```

Cada paso calcula `out[i] = a[i+1] - a[i]`. El orden predeterminado es uno; el
orden dos repite la operación sobre las primeras diferencias. El orden debe ser
un entero Lua no negativo. El eje seleccionado termina vacío al agotarse los
pares. La implementación devuelve ese resultado vacío estable sin repetir pasos
innecesarios para órdenes enormes.

| Firma | Valores predeterminados |
| --- | --- |
| `lr.diff(a, n, axis)` | `n=1`, `axis=-1`. |
| `lr.diff(a, {n=..., axis=..., prepend=..., append=...})` | Forma con opciones. |
| `lr.ediff1d(a, {to_begin=..., to_end=...})` | Sin padding por defecto. |

Los ejes positivos empiezan en uno; los negativos cuentan desde el final.
`ediff1d` usa una tabla de opciones en lugar del padding posicional de Python.

## Seleccionar un eje y añadir límites

```lua
local matrix = lr.arange(6):reshape({2, 3})
local rows = lr.diff(matrix, {axis=1})
assert(rows.shape[1] == 1 and rows.shape[2] == 3)
assert(rows:get(1, 3) == 3)
local bounded = lr.diff(values, {prepend=0, append=16})
assert(bounded.size == 4 and bounded[1] == 1 and bounded[4] == 7)
```

Un límite escalar se expande a una sección de un elemento sobre el eje indicado.
Los límites array deben tener el mismo rango y coincidir en los demás ejes.
La concatenación promueve el dtype antes de restar. Se admiten entradas Fortran,
transpuestas, invertidas y broadcast; los kernels nativos determinan los strides.

`n=0` devuelve la entrada original inmediatamente y conserva identidad y permisos
de escritura. Una tabla Lua sigue siendo tabla y se ignoran eje y padding.
Los órdenes positivos exigen al menos una dimensión y producen arrays
independientes y escribibles.

## Aplanar y completar las diferencias

```lua
local flat = lr.ediff1d({{1, 4}, {9, 16}}, {to_begin=0, to_end=99})
assert(flat.size == 5)
assert(flat[1] == 0 and flat[2] == 3 and flat[4] == 7 and flat[5] == 99)
local narrow = lr.ediff1d(lr.array({1, 4}, "int8"), {to_begin=256})
assert(narrow.dtype == "int8" and narrow[1] == 0 and narrow[2] == 3)
```

`ediff1d` calcula las diferencias antes de añadir los límites al resultado y
aplana también los arrays de padding. Con padding, conserva el dtype de entrada;
los límites deben cumplir `same_kind`. Una conversión entera estrecha puede hacer
wrapping. Un límite flotante para entrada entera falla en lugar de promoverla.
Incluso un padding vacío participa en la validación de dtype.

## Booleanos, unsigned y tipos temporales

```lua
local events = lr.diff({true, true, false})
assert(events.dtype == "bool" and not events[1] and events[2])
local wrapped = lr.diff(lr.array({1, 0}, "uint8"))
assert(wrapped[1] == 255)
local dates = lr.array({1, 3, 8}, "datetime64[ms]")
local elapsed = lr.diff(dates)
assert(elapsed.dtype == "timedelta64[ms]")
assert(lr.astype(elapsed, "int64")[2] == 5)
```

`diff` booleano detecta cambios mediante desigualdad. `ediff1d` usa resta y
rechaza booleanos. Las diferencias unsigned conservan dtype y hacen wrapping;
no se convierten automáticamente en signed. Los complejos no se conjugan. Las
diferencias datetime producen timedelta con la unidad correspondiente; la resta
de duraciones conserva la unidad. Un `ediff1d` datetime con padding puede fallar
porque su salida datetime obligatoria no admite timedelta bajo `same_kind`.

## Compatibilidad

Disponible desde **0.128.0-dev**. Las referencias NumPy 2.5.3 cubren valores,
dtype, disposición, vacíos, órdenes, ejes, padding, tipos especiales, NaT,
no finitos, identidad y estados posteriores a escrituras reales. Las pruebas
locales ejecutan el orden entero máximo nativo; no se ejecuta su enorme bucle
upstream. Siguen pendientes object/structured, protocolos externos/subclases y
fidelidad completa de argumentos, advertencias y excepciones Python. La
compatibilidad permanece parcial.
