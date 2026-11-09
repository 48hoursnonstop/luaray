---
docs_examples: true
---
# Matrices triangulares

Crea una máscara triangular inferior o conserva el triángulo superior/inferior
de datos existentes. Las tres funciones devuelven ndarrays nuevos y escribibles.

## Firmas

| Función | Comportamiento |
| --- | --- |
| `lr.tri(n, m, k, dtype)` | Crea una máscara; valores predeterminados: `m=n`, `k=0`, `dtype="float64"`. |
| `lr.tri(n, {m=..., k=..., dtype=...})` | Forma con tabla de opciones. |
| `lr.tril(a, k)` | Conserva elementos sobre o debajo de la diagonal `k`. |
| `lr.triu(a, k)` | Conserva elementos sobre o encima de la diagonal `k`. |

`tril` y `triu` también aceptan `{k=...}`. Un offset positivo mueve el límite
arriba de la diagonal principal; uno negativo, abajo. Dimensiones y offsets deben
ser enteros Lua. No se reproducen las conversiones Python obsoletas de float a índice.

## Crea una máscara

```lua
local lr = require("luaray")
local mask = lr.tri(2, {m=3})
assert(mask.shape[1] == 2 and mask.shape[2] == 3)
assert(mask:get(1, 1) == 1 and mask:get(1, 2) == 0)
assert(mask:get(2, 2) == 1)

local strict = lr.tri(3, {k=-1, dtype="int8"})
assert(strict:get(1, 1) == 0 and strict:get(2, 1) == 1)
```

Las dimensiones negativas producen ejes vacíos, como las secuencias de referencia.
Un dtype booleano devuelve una máscara booleana. Los demás convierten esa máscara:
las cadenas fijas contienen `"True"` y `"False"`, truncadas al ancho indicado.
`S` y `U` sin ancho infieren cinco caracteres. Los tipos temporales contienen ticks cero o uno.

## Conserva un triángulo

```lua
local a = lr.array({{1, 2, 3}, {4, 5, 6}}, "float64")
local lower = lr.tril(a)
local upper = lr.triu(a, 1)
assert(lower:get(1, 2) == 0 and lower:get(2, 2) == 5)
assert(upper:get(2, 2) == 0 and upper:get(2, 3) == 6)
assert(not lr.shares_memory(a, lower))
```

Los valores descartados se convierten en ceros del dtype. Para cadenas fijas,
el cero es una cadena vacía, a diferencia de la conversión booleana de `tri`.
`tril` y `triu` siguen la promoción de selección, incluido el orden de bytes nativo
en resultados Unicode. Una entrada escalar es inválida. Un vector de longitud `n`
se combina con una máscara `n × n` y devuelve una matriz.

## Aplica la máscara a un lote

```lua
local batch = lr.asfortranarray(lr.arange(24):reshape({2, 3, 4}))
local lower_batch = lr.tril(batch)
assert(lower_batch:get(2, 3, 1) == 20)
assert(lower_batch:get(2, 1, 2) == 0)
assert(batch:get(2, 1, 2) == 13)
```

Los últimos dos ejes forman cada matriz; los ejes iniciales identifican lotes.
Se admiten vistas invertidas, transpuestas, broadcast y Fortran. La selección
usa iteración KEEPORDER al estilo NumPy: el resultado puede tener una disposición
distinta del orden C ordinario. Cada matriz conserva la misma regla triangular.

## Selecciona o modifica elementos triangulares

Los helpers de índices devuelven una secuencia Lua con un vector de filas y otro
de columnas. Sus coordenadas empiezan en **uno**. Los dos vectores tienen memoria
contigua e independiente; modificar uno no cambia el otro.

| Función | Valores predeterminados y entrada |
| --- | --- |
| `lr.tril_indices(n, k, m)` | Triángulo inferior; `k=0`, `m=n`. |
| `lr.triu_indices(n, k, m)` | Triángulo superior; `k=0`, `m=n`. |
| `lr.tril_indices(n, {k=..., m=...})` | Forma con opciones; también válida para `triu_indices`. |
| `lr.tril_indices_from(a, k)` | Usa las dos dimensiones de un ndarray real. |
| `lr.triu_indices_from(a, {k=...})` | Forma con opciones; también válida para el helper inferior. |

El orden posicional de índices es **`n, k, m`**; `tri` usa `n, m, k`.
Los helpers `_from` admiten matrices rectangulares y rechazan tablas Lua y arrays
cuyo rango no sea dos. El dtype, los valores y la disposición física de la entrada
no cambian las coordenadas. Las filas están ordenadas y las columnas aumentan
dentro de cada fila.

```lua
local matrix = lr.arange(12):reshape({3, 4})
local indices = lr.triu_indices_from(matrix, 1)
local selected = matrix:get(table.unpack(indices))
assert(selected.size == 6 and selected[1] == 1 and selected[6] == 11)
matrix:set(-1, table.unpack(indices))
assert(matrix:get(1, 2) == -1 and matrix:get(3, 4) == -1)
assert(matrix:get(3, 1) == 8)
```

Las lecturas avanzadas crean arrays independientes; la asignación modifica el
original, incluidas vistas transpuestas e invertidas escribibles. Las dimensiones
negativas o un triángulo excluido producen vectores vacíos. Su stride es cero,
como en la asignación por indexación booleana de referencia. Los offsets extremos
siguen las mismas reglas de construcción de secuencias que las matrices triangulares.

## Compatibilidad

Disponible desde **0.119.0-dev**. Las referencias exactas NumPy 2.5.3 cubren valores,
dtypes, strides, dimensiones vacías/negativas, lotes, copias, ceros tipados y
escrituras reales. Los offsets extremos conservan las reglas de índices de ancho
fijo de la referencia, incluidos errores de conversión y máscaras envueltas
cerca del límite entero. El código nativo usa aritmética unsigned definida para ello.

Las opciones desconocidas y argumentos adicionales producen errores Lua. Objetos,
estructuras, protocolos externos y fidelidad completa de advertencias/excepciones
Python siguen pendientes. Las funciones conservan [compatibilidad parcial](api_inventory.md).

Los helpers de índices están disponibles desde **0.123.0-dev**, con comparaciones
exactas de coordenadas, memoria, lecturas/escrituras avanzadas y estado del original
frente a NumPy 2.5.3.
