---
docs_examples: true
---
# Gradientes numéricos

`lr.gradient(valores, opciones)` estima primeras derivadas con diferencias centradas
en el interior y diferencias unilaterales en los extremos de cada eje. A diferencia
de [diff](differences.md), cada resultado conserva la forma de la entrada.

## Derivar valores muestreados

```lua
local lr = require("luaray")
local values = lr.array({0, 1, 4, 9}, "float64")
local derivative = lr.gradient(values, {edge_order=2})
assert(derivative[1] == 0 and derivative[2] == 2)
assert(derivative[3] == 4 and derivative[4] == 6)
```

El espaciado predeterminado es uno. `edge_order=1` usa estimaciones de primer orden
en los extremos; `edge_order=2` usa segundo orden y necesita al menos tres muestras
en cada eje elegido. El interior usa segundo orden en ambos casos.

| Opción | Significado |
| --- | --- |
| `axis` | Un entero Lua, una secuencia de ejes u omitido para todos. |
| `spacing` | Un escalar para todos los ejes elegidos o una secuencia de espaciados escalares/vectores de coordenadas en el orden de los ejes. |
| `edge_order` | Uno de forma predeterminada; dos selecciona extremos de segundo orden. |

Los ejes positivos empiezan en uno; los negativos cuentan desde el final. Las
opciones enteras requieren enteros Lua reales. Un eje devuelve un ndarray; varios
devuelven una secuencia Lua de ndarrays en el orden indicado. Ningún eje, incluida
una entrada escalar, devuelve una secuencia vacía.

## Coordenadas irregulares

```lua
local coordinates = lr.array({0, 1, 3, 6, 10}, "int64")
local quadratic = lr.square(coordinates)
local slope = lr.gradient(quadratic, {spacing=coordinates, edge_order=2})
assert(math.abs(slope[3] - 6) < 1e-12)
assert(math.abs(slope[5] - 20) < 1e-12)
```

Cada vector de coordenadas debe tener una dimensión y coincidir con la longitud
de su eje. Con un eje se puede pasar un vector tipado directamente. Una secuencia
Lua de coordenadas necesita una tabla exterior: `spacing={{0, 1, 3, 6, 10}}`.
Así se distingue de los espaciados por eje. Las coordenadas enteras se convierten
a float64 antes de restar. Las coordenadas repetidas pueden dar valores no finitos.

## Varios ejes y resultados independientes

```lua
local grid = lr.arange(12):reshape({3, 4})
local derivatives = lr.gradient(grid, {axis={2, 1}, spacing={2, 4}})
assert(#derivatives == 2)
assert(derivatives[1]:get(2, 3) == 0.5)
assert(derivatives[2]:get(2, 3) == 1)
assert(not lr.shares_memory(derivatives[1], grid))
```

Cada derivada es escribible e independiente de la entrada y de los otros resultados.
Se aceptan vistas Fortran, transpuestas, invertidas, con broadcasting o de solo
lectura. Las reglas nativas de `empty_like` determinan los strides. Los datos enteros
se convierten a float64; los flotantes y complejos conservan su dtype. La resta
booleana no está implementada y produce un error.

## Fechas y duraciones

```lua
local dates = lr.array({0, 2, 8}, "datetime64[ms]")
local elapsed = lr.gradient(dates, {spacing=2})
assert(elapsed.dtype == "timedelta64[ms]")
assert(lr.astype(elapsed, "int64")[2] == 2)
```

Las fechas se reinterpretan como duraciones con la misma unidad. La aritmética
conserva esa unidad y trunca fracciones de ticks hacia cero. Un espaciado entero
usa división entera exacta; uno flotante usa el bucle double. Los vectores de
coordenadas de duración siguen la clasificación de NumPy como subtipo entero:
sus ticks se convierten a float64. Véase [escalar duraciones](temporal_scaling.md).

## Compatibilidad

Disponible desde **0.129.0-dev**, con los coeficientes y orden de operaciones de
NumPy 2.5.3. La tabla de opciones Lua sustituye los espaciados variádicos de Python.
Los escalares tipados conservan su tipo; los números y complejos Lua ordinarios
usan aritmética escalar débil. Una entrada float64 de una dimensión con espaciado
complejo ordinario y extremos de segundo orden reproduce el rechazo de asignación
escalar de la referencia fijada.

Las referencias comprueban forma, dtype, strides, escritura independiente, estado
de la entrada, ejes, extremos, coordenadas uniformes/irregulares y valores temporales
/no finitos. Las tolerancias absolutas más relativas son: float16 `5e-3`, float32
/complex64 `5e-6` y tipos más amplios `2e-12`. El error observado en el nuevo corpus
fue cero. Siguen pendientes object, estructuras, protocolos externos/subclases,
todas las clases escalares Python y la identidad de avisos/excepciones. La
compatibilidad de esta API es parcial.
