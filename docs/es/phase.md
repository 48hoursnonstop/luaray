---
docs_examples: true
---
# Desenvolver fases y ángulos

`lr.unwrap(valores, opciones)` elimina saltos producidos al representar una fase
en un intervalo periódico. Suma múltiplos del periodo para mantener cercanas las
muestras consecutivas y conserva la primera muestra de cada eje elegido.

## Radianes

```lua
local lr = require("luaray")
local phase = lr.unwrap({0, math.pi/2, -math.pi, -math.pi/2, 0})
assert(math.abs(phase[3] - math.pi) < 1e-12)
assert(math.abs(phase[5] - 2*math.pi) < 1e-12)
```

El periodo predeterminado es `2*math.pi` y el umbral de discontinuidad es la mitad
del periodo. `unwrap` procesa valores de fase muestreados, no números complejos
directamente. Las entradas complejas fallan al calcular el resto.

| Opción | Valor predeterminado | Significado |
| --- | --- | --- |
| `period` | `2*math.pi` | Intervalo sobre el que se repite la entrada. |
| `discont` | `period/2` | No corregir diferencias menores que este umbral. |
| `axis` | `-1` | Eje que se procesa; los ejes Lua positivos empiezan en uno. |

## Periodos y umbrales propios

```lua
local turns = lr.array({0, 1, 2, -1, 0}, "int64")
local continuous = lr.unwrap(turns, {period=4})
assert(continuous.dtype == "int64")
assert(continuous[4] == 3 and continuous[5] == 4)
local unchanged = lr.unwrap(turns, {period=4, discont=4})
assert(unchanged[4] == -1)
```

Un umbral inferior a medio periodo no fuerza correcciones que agranden el salto.
En la mitad exacta de un periodo par, una diferencia positiva conserva su signo.
Los periodos enteros impares usan un semintervalo entero sin ambigüedad de borde.
Las diferencias enteras y las correcciones acumuladas siguen la aritmética nativa
con desbordamiento modular, sin convertir todas las entradas a float64.

## Resultados independientes por eje

```lua
local grid = lr.array({{0, 1, 2, -1}, {0, 1, 2, -1}}, "float32")
local continuous = lr.unwrap(grid, {axis=2, period=4})
assert(continuous.dtype == "float32" and continuous:get(2, 4) == 3)
assert(not lr.shares_memory(continuous, grid))
continuous:set(99, 1, 1)
assert(grid:get(1, 1) == 0)
```

El resultado es una copia escribible con el dtype promovido. Se admiten vistas
Fortran, transpuestas, invertidas, con broadcasting o de solo lectura. Los ejes
vacíos devuelven copias vacías; una entrada escalar es inválida. Las correcciones
NaN/no finitas se propagan por la suma acumulada. La implementación conserva el
comportamiento aritmético de los periodos cero o negativos de la referencia.

Los periodos tipados conservan sus reglas de dtype y broadcasting. Un vector de
periodos flotantes puede expandirse contra las diferencias adyacentes. Un array
de periodos enteros con varios elementos falla porque la decisión de ambigüedad
de borde requiere una condición escalar. `result_type` decide la promoción de
escalares ordinarios y tipados.

## Compatibilidad

Disponible desde **0.131.0-dev**, basada en NumPy 2.5.3. Lua usa una tabla de
opciones y ejes enteros estrictos. Las referencias comprueban valores, dtype,
forma, strides, escritura independiente y entrada/memoria intactas, con periodos
pares/impares, umbrales, vistas, no finitos y límites enteros. Tolerancias absolutas
más relativas: half `5e-3`, float32 `5e-6` y tipos más amplios `2e-12`. Siguen
pendientes object/estructuras, protocolos externos/subclases, todas las clases
escalares Python y la identidad exacta de avisos/excepciones. La compatibilidad de
esta API es parcial.
