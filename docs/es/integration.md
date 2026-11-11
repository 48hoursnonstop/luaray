---
docs_examples: true
---
# Integración trapezoidal

`lr.trapezoid(y, opciones)` estima una integral sumando las áreas de trapecios
entre muestras adyacentes. Elimina el eje elegido de la forma del resultado.

## Muestras equidistantes

```lua
local lr = require("luaray")
local values = lr.array({1, 2, 3}, "float64")
local integral = lr.trapezoid(values)
assert(integral.ndim == 0 and integral:tolist() == 4)
assert(lr.trapezoid(values, {dx=2}):tolist() == 8)
```

| Opción | Valor predeterminado | Significado |
| --- | --- | --- |
| `axis` | `-1` | Eje de integración; los ejes Lua positivos empiezan en uno. |
| `dx` | `1.0` | Espaciado entre muestras cuando se omiten las coordenadas. |
| `x` | Omitido | Coordenadas; sustituye a `dx`. |

Una entrada de una dimensión devuelve un ndarray tipado de rango cero. Su valor
Lua se obtiene con `:tolist()`. El resultado tipado conserva precisión y unidades
temporales durante la reducción. Una entrada escalar es inválida. Cero o una
muestra produce una integral cero.

## Coordenadas y dirección

```lua
local irregular = lr.trapezoid({0, 1, 9}, {x={0, 1, 3}})
assert(irregular:tolist() == 10.5)
local reverse = lr.trapezoid({1, 2, 3}, {x={8, 6, 4}})
assert(reverse:tolist() == -8)
```

Las coordenadas se usan en su orden original; no se ordenan. Coordenadas
decrecientes invierten el signo. Un vector `x` de una dimensión se diferencia y
adapta al eje elegido. Las coordenadas multidimensionales usan el eje solicitado
antes del broadcasting y siguen las reglas normales de forma. Se admiten arrays
tipados o secuencias Lua rectangulares como coordenadas y espaciados.

## Integrar filas o columnas

```lua
local grid = lr.arange(6):reshape({2, 3})
local rows = lr.trapezoid(grid)
assert(rows[1] == 2 and rows[2] == 8)
local columns = lr.trapezoid(grid, {axis=1})
assert(columns[1] == 1.5 and columns[3] == 3.5)
assert(not lr.shares_memory(rows, grid))
```

Los resultados son escribibles e independientes de la entrada. Se admiten vistas
Fortran, transpuestas, invertidas, con broadcasting o de solo lectura. El orden
de cálculo sigue la referencia: suma de muestras adyacentes, multiplicación por
el espaciado, división entre `2.0` y suma final. La suma entera puede desbordar
antes de dividir; no se convierte previamente a float64. La suma booleana usa la
operación booleana nativa.

## Muestras temporales

```lua
local hours = lr.array({1, 2, 3}, "timedelta64[h]")
local accumulated = lr.trapezoid(hours)
assert(accumulated.dtype == "timedelta64[h]")
assert(lr.astype(accumulated, "int64"):tolist() == 3)
```

La aritmética de duraciones conserva unidades y trunca fracciones de ticks en
cada división intermedia. La suma temporal envuelve ticks int64 y propaga NaT.
Las coordenadas datetime aportan diferencias de duración; sumar muestras datetime
no está implementado. Se mantienen las reglas de conversión entre unidades de
calendario y unidades fijas.

## Compatibilidad

Disponible desde **0.130.0-dev**, basada en NumPy 2.5.3. Lua usa una tabla de
opciones y resultados tipados de rango cero. Las tolerancias absolutas más
relativas son: half `5e-3`, float32/complex64 `5e-6` y tipos más amplios `2e-12`.
Los metadatos y el estado de entrada/memoria se verifican por separado de forma
exacta. Siguen pendientes protocolos externos/subclases, todas las clases
escalares/avisos Python, object/estructuras y todas las disposiciones posibles.
La compatibilidad de esta API es parcial.
