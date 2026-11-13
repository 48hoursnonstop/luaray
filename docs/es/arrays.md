---
docs_examples: true
---
# Fundamentos de arrays

Un ndarray almacena valores con un mismo dtype y una forma. Úsalo para calcular
sobre colecciones completas sin escribir bucles sobre tablas Lua.

## Crea un array

```lua
local lr = require("luaray")
local a = lr.array({{1, 2, 3}, {4, 5, 6}}, "float64")

assert(a.ndim == 2)            -- número de ejes
assert(a.shape[1] == 2)        -- dos filas
assert(a.shape[2] == 3)        -- tres columnas
assert(a.size == 6)            -- número total de elementos
assert(a.dtype == "float64")
```

La forma es una tabla Lua de dimensiones. `{2, 3}` describe dos filas y tres
columnas. Especifica el dtype cuando importe la precisión, el tamaño o el rango
entero. [Creación y copias](creation.md) explica constructores y conversiones.

## Lee y escribe valores

Los índices positivos empiezan en **1**. Los negativos cuentan desde el final;
el cero es inválido. `get()` accede a varios ejes y `set()` asigna un valor.
En `set(value, index, ...)`, el valor va **primero**.

```lua
assert(a:get(2, 3) == 6)
assert(a:get(-1, -1) == 6)
a:set(60, 2, 3)
assert(a:get(2, 3) == 60)

local row = a[1]              -- vista de la primera fila
row[2] = 20
assert(a:get(1, 2) == 20)
```

En un array multidimensional, indexar el primer eje devuelve una vista de los
ejes restantes. En un array unidimensional devuelve un valor.
`a:tolist()` convierte el array en datos Lua anidados.

## Selecciona un slice

`lr.slice(start, stop, step)` tiene un límite final **exclusivo**. Usa `nil` para
omitir un límite y un paso negativo para recorrer al revés. Los slices básicos
comparten memoria con el original.

```lua
local values = lr.array({10, 20, 30, 40, 50}, "int32")
local middle = values[lr.slice(2, 5)] -- {20, 30, 40}
assert(middle.size == 3 and middle[3] == 40)

local reversed = values[lr.slice(nil, nil, -1)]
assert(reversed[1] == 50)
reversed[1] = 99
assert(values[5] == 99)
```

Usa `a:get(spec1, spec2, ...)` para seleccionar en varios ejes. `lr.ellipsis`
representa los ejes restantes y `lr.newaxis` añade una dimensión de longitud uno.

## Calcula elemento a elemento

Los operadores aritméticos actúan sobre cada elemento. Las funciones con nombre
resuelven raíces, potencias, recortes y trigonometría.

```lua
local x = lr.array({1, 4, 9}, "float64")
local y = lr.sqrt(x) * 2
assert(y[1] == 2 and y[2] == 4 and y[3] == 6)
```

Consulta las firmas en [operaciones unarias](unary_math.md),
[operaciones binarias](binary_math.md) y [recorte](clip.md).

## Combina formas con broadcasting

El broadcasting compara dimensiones desde la derecha. Cada par debe tener la
misma longitud o incluir una dimensión de longitud uno. Así puedes combinar
un vector con todas las filas de una matriz:

```lua
local matrix = lr.array({{1, 2, 3}, {4, 5, 6}}, "float64")
local offsets = lr.array({10, 20, 30}, "float64")
local shifted = matrix + offsets
assert(shifted:get(1, 1) == 11)
assert(shifted:get(2, 3) == 36)
```

Las formas `{2, 3}` y `{3}` producen `{2, 3}`. Las formas `{2, 3}` y `{2}`
son incompatibles: sus últimas dimensiones tienen longitudes 3 y 2.

## Reduce un eje

Sin un eje, se reduce todo el array. Los ejes positivos empiezan en uno:
el eje 1 combina filas; el eje 2 combina columnas en esta matriz.

```lua
assert(lr.sum(matrix) == 21)
local row_totals = lr.sum(matrix, 2)
assert(row_totals[1] == 6 and row_totals[2] == 15)
local column_totals = lr.sum(matrix, 1)
assert(column_totals[1] == 5 and column_totals[3] == 9)
```

Una reducción completa puede devolver un escalar Lua. Si conserva ejes,
devuelve un ndarray. El tipo de retorno y las opciones dependen de la operación.

## Elige una vista o una copia

Una vista comparte memoria. Una copia tiene almacenamiento independiente.
Usa `copy()` antes de editar si necesitas conservar el array original.

```lua
local view = matrix[1]
local independent = matrix:copy()
assert(lr.shares_memory(matrix, view))
assert(not lr.shares_memory(matrix, independent))
independent:set(100, 1, 1)
assert(matrix:get(1, 1) == 1)
```

Cambiar la forma o transponer puede devolver vistas. [Forma y disposición](layout.md)
explica copias, strides, aplanado y contigüidad. [Escrituras con máscara](masked_writes.md)
explica cómo afecta la memoria compartida a las asignaciones.
