---
docs_examples: true
---
# Rejillas de coordenadas y posiciones

`lr.indices` construye rejillas de coordenadas. `lr.ix_` forma una malla abierta
con vectores. `lr.argwhere` agrupa posiciones no nulas en filas. Un módulo Lua
usa los motores nativos existentes de rangos, disposición, asignación y nonzero.

## Rejillas de coordenadas

```lua
local lr = require("luaray")
local coordinates = lr.indices({2, 3})
local rows, columns = coordinates:get(1), coordinates:get(2)
assert(rows:tolist()[2][3] == 1)
assert(columns:tolist()[2][3] == 2)
assert(coordinates.shape[1] == 2 and coordinates.flags.owndata)
```

Los **valores empiezan en cero**, conservando los datos numéricos de NumPy. Los
argumentos de indexación Lua empiezan en uno: suma uno a esos valores al usarlos
como índices Lua. El primer eje selecciona la rejilla. Para `{2,3}`, la salida
tiene forma `{2,2,3}`: la primera rejilla varía por filas y la segunda por
columnas. El dtype por defecto es `intp` nativo.

Usa `lr.indices(dimensions, dtype, options)` o incluye dtype en las opciones.
Las dimensiones son una tabla densa de enteros Lua. Solo se admiten `dtype` y
`sparse` booleano. El dtype puede ser string o descriptor.

```lua
local sparse = lr.indices({2, 3}, {dtype="float32", sparse=true})
assert(sparse[1].shape[1] == 2 and sparse[1].shape[2] == 1)
assert(sparse[2].shape[1] == 1 and sparse[2].shape[2] == 3)
local sum = sparse[1] + sparse[2] -- Broadcasting nativo a {2,3}.
assert(sum:tolist()[2][3] == 3)
assert(not lr.shares_memory(sparse[1], sparse[2]))
```

La salida sparse es una tabla Lua con un array por eje. Cada uno es una vista
de su propio rango; los demás ejes tienen longitud uno. La salida densa posee
su asignación. Las rejillas densas admiten hasta 63 dimensiones por el eje
adicional de coordenadas; las sparse admiten 64. Las dimensiones vacías y las
listas de rango cero siguen los constructores originales. La ruta sparse
original puede convertir stops negativos en ejes vacíos mediante reshape; la
asignación densa rechaza dimensiones negativas. Sparse de rango cero devuelve
`{}` y no inspecciona un dtype sin uso. Los dtypes siguen arange moderno,
incluidas sus restricciones de longitud booleana y de tipos temporales/strings.

## Mallas abiertas de índices

```lua
local matrix = lr.array({{10,11,12}, {20,21,22}, {30,31,32}})
local mesh = lr.ix_({1, 3}, {false, true, true})
local selected = matrix:get(table.unpack(mesh))
assert(selected:tolist()[1][1] == 11)
assert(selected:tolist()[2][2] == 32)
assert(mesh[1].shape[1] == 2 and mesh[1].shape[2] == 1)
assert(mesh[2]:tolist()[1][1] == 2)
```

Cada entrada debe convertirse en un array de un eje. Los valores numéricos y
dtypes se conservan; los vectores booleanos producen **posiciones desde uno**,
como `lr.nonzero`. Proporciona posiciones Lua como `{1,3}` para indexar arrays.
La salida es una tabla de vistas reshape, con un eje activo por entrada. Las
entradas numéricas comparten almacenamiento con sus vistas; las selecciones
booleanas usan coordenadas nuevas. Una tabla Lua vacía se convierte en intp;
un array vacío ya tipado conserva su dtype. Otros dtypes pueden formar vistas,
pero el indexador de arrays sigue exigiendo índices válidos.

## Agrupar posiciones no nulas

```lua
local locations = lr.argwhere(lr.greater(matrix, 20))
assert(locations.shape[1] == 5 and locations.shape[2] == 2)
assert(locations:get(1,1) == 2 and locations:get(1,2) == 2)
assert(not locations.flags.owndata and locations.flags.f_contiguous)
assert(not lr.shares_memory(locations, matrix))
```

Cada fila contiene la posición desde uno de un valor no nulo, en orden C lógico.
Para rango N, la salida tiene forma `{selected_count,N}`. Es una vista escribible
de coordenadas nuevas y no comparte datos de entrada. Un escalar verdadero
genera `{1,0}`; uno falso genera `{0,0}`. Nil es un escalar falso; omitir el
argumento es un error. La conversión de verdad incluye valores NaN/NaT no nulos.
Usa `lr.nonzero(a)` si necesitas arrays separados para indexación avanzada;
`argwhere` produce una matriz de filas de coordenadas.

```lua
assert(lr.argwhere(true).shape[1] == 1)
assert(lr.argwhere(true).shape[2] == 0)
assert(lr.argwhere(nil).shape[1] == 0)
local values = lr.array({1, 3})
local retained = lr.ix_(values)[1]
values = nil
collectgarbage("collect")
retained:set(2, 1)
assert(retained:tolist()[1] == 2)
```

Las vistas conservan sus buffers después de que Lua recolecte el userdata
original. Las vistas de entradas de solo lectura mantienen sus flags; las
coordenadas booleanas nuevas son escribibles. Escribir sobre una malla numérica
puede modificar el almacenamiento de entrada.

## Verificación y alcance

Las referencias NumPy 2.5.3 aprobaron **6 063 casos / 474 263 comprobaciones**:
indices 1 344 / 352 179; ix_ 2 539 / 79 816; argwhere 2 180 / 42 268. Comparan
valores, dtypes, forma/strides/flags, memoria compartida y escrituras/estados base,
incluidas entradas vacías, escalares, de solo lectura, con saltos y de alto rango.
Las rejillas numéricas conservan sus valores. Se normalizaron **438 ejes** de
posiciones booleanas y se desplazaron **13 671 valores de argwhere** a la
convención Lua existente desde uno. Los metadatos se comparan directamente;
longdouble omite padding de ABI. Los tres corpus se regeneran exactamente. La
regresión Lua permanente añade 150 comprobaciones.

Las APIs siguen siendo parciales. Objetos/dtypes estructurados/StringDType,
protocolos externos, todas las coerciones de secuencias anidadas, todas las ABI
y los protocolos Python de keywords y objetos de forma siguen sin soporte o
sin certificar. Estas funciones no certifican todas las operaciones que puedan
aplicarse después a sus arrays.
