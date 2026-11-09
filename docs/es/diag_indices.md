---
docs_examples: true
---
# Índices diagonales

Usa los índices diagonales para leer o sustituir la diagonal principal mediante
indexación avanzada. Los helpers devuelven coordenadas para acceder al array
original; `diagonal`, en cambio, devuelve una vista de solo lectura.

## Firmas

| Función | Resultado |
| --- | --- |
| `lr.diag_indices(n, ndim)` | Secuencia de `ndim` vectores de índices; por defecto `ndim=2`. |
| `lr.diag_indices(n, {ndim=...})` | Forma con tabla de opciones. |
| `lr.diag_indices_from(a)` | Coordenadas de un ndarray con al menos dos ejes de igual tamaño. |

Las coordenadas empiezan en **uno**, como toda la indexación de LuaRay. Cada vector
contiene los valores de `1` a `n`, con el dtype de índice entero de la plataforma
(`int64` en x86-64). Las dimensiones deben ser enteros Lua. Un `n` negativo produce
vectores vacíos; un `ndim` no positivo produce una secuencia vacía tras construir el vector.

## Leer y sustituir una diagonal

```lua
local lr = require("luaray")
local matrix = lr.arange(9):reshape({3, 3})
local coordinates = lr.diag_indices_from(matrix)
local diagonal = matrix:get(table.unpack(coordinates))
assert(diagonal[1] == 0 and diagonal[3] == 8)
matrix:set(7, table.unpack(coordinates))
assert(matrix:get(1, 1) == 7 and matrix:get(3, 3) == 7)
assert(matrix:get(1, 2) == 1)
```

`table.unpack` pasa un vector por eje. Las lecturas avanzadas crean arrays
independientes; la asignación modifica el almacenamiento original. Las coordenadas
no comparten memoria con la entrada, pero los elementos de la secuencia devuelta
se refieren al **mismo vector**: cambiar uno modifica todos los elementos repetidos.

## Indexar arrays de más dimensiones

```lua
local cube = lr.zeros({2, 2, 2}, "int16")
local coordinates = lr.diag_indices(2, {ndim=3})
assert(rawequal(coordinates[1], coordinates[3]))
cube:set(9, table.unpack(coordinates))
assert(cube:get(1, 1, 1) == 9 and cube:get(2, 2, 2) == 9)
assert(cube:get(1, 2, 1) == 0)
```

`diag_indices_from` exige un ndarray real. Rechaza tablas Lua, arrays de rango
cero o uno y arrays cuyos ejes tengan longitudes distintas. Para una matriz
rectangular puedes usar coordenadas explícitas o [una vista diagonal](matrices.md)
si solo necesitas leer.

## Asignar valores numéricos a arrays de strings

```lua
local labels = lr.zeros({2, 2}, "U4")
labels:set(true, table.unpack(lr.diag_indices(2)))
assert(labels:get(1, 1) == "True" and labels:get(1, 2) == "")
labels:set(0/0, 1, 1)
assert(labels:get(1, 1) == "nan")
```

Los escalares numéricos, booleanos y complejos usan el formateador nativo compartido
al asignarse mediante índices básicos, máscaras booleanas o índices avanzados.
El destino trunca el texto según su ancho fijo. Los constructores también usan
este formateador, conservando la precisión, la notación imaginaria pura y `nan` sin signo.

## Compatibilidad

Disponible desde **0.122.0-dev**. Las referencias de NumPy 2.5.3 comparan coordenadas
con adaptación explícita de base cero a uno, dtype, aliasing, copias de lectura,
escrituras reales, límites de rango y vacíos, y formato de escalares. Las secuencias
Lua sustituyen las tuplas Python. No se admiten objetos índice de Python, dispatch
de subclases ni todos los protocolos de escalares externos. La compatibilidad sigue siendo parcial.
