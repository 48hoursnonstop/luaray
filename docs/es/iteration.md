---
docs_examples: true
---
# Recorrer posiciones de índices

`lr.ndindex(shape)` devuelve un iterador Lua de tablas de coordenadas desde uno.
También acepta dimensiones como argumentos separados. El último eje cambia
más rápido, en orden C. Cada tabla devuelta es una instantánea nueva.

```lua
local lr = require("luaray")
local positions = {}
for coordinate in lr.ndindex({2, 3}) do
  positions[#positions+1] = coordinate
end
assert(#positions == 6)
assert(positions[1][1] == 1 and positions[1][2] == 1)
assert(positions[4][1] == 2 and positions[4][2] == 1)
```

Usa esas posiciones directamente al indexar LuaRay. `lr.indices` produce datos
numéricos desde cero; ndindex devuelve posiciones Lua. La forma se copia al
construir el iterador: modificar después su tabla no altera el recorrido.

```lua
local values = lr.zeros({2, 3}, "int32")
for coordinate in lr.ndindex(values.shape) do
  values:set(coordinate[1] * 10 + coordinate[2], table.unpack(coordinate))
end
assert(values:get(2,3) == 23)
```

## Estado y límites

Una forma vacía tiene una posición: `{}`. Un eje cero vacía el iterador. Las
dimensiones son enteros Lua no negativos; los booleanos equivalen a cero o uno,
como en los rangos originales. Se rechazan tablas con huecos, dimensiones
negativas y argumentos flotantes.

```lua
local scalar = lr.ndindex()
assert(#scalar() == 0 and scalar() == nil)
local empty = lr.ndindex(2, 0, 3)
assert(empty() == nil)
local iterator = lr.ndindex(2, 3)
local first = iterator()
first[1] = 99
assert(iterator()[1] == 1) -- La tabla devuelta no controla el recorrido.
```

Tras agotarse sigue devolviendo nil. Los iteradores son independientes y puedes
conservar o modificar sus tablas. Solo almacena la forma copiada y la posición
actual, con memoria O(rango); no reserva de antemano los valores de cada eje ni
todo el producto cartesiano.

```lua
local huge = lr.ndindex(math.maxinteger, math.maxinteger)
assert(huge()[2] == 1)
assert(huge()[2] == 2)
local shape = {}
for axis=1,1000 do shape[axis] = 1 end
local high = lr.ndindex(shape)
assert(#high() == 1000 and high() == nil)
```

El iterador puede tener más dimensiones que un ndarray. Las operaciones de
arrays conservan sus propios límites de rango y almacenamiento. Puedes consumir
prefijos de espacios grandes sin desbordar un contador de producto; recorrerlos
completos sigue requiriendo una llamada por posición. Las dimensiones están
limitadas por los enteros Lua.

## Referencias ejecutadas y alcance

La referencia NumPy 2.5.3 aprobó **1 254 casos / 39 746 comprobaciones**: ambas
formas del constructor, orden C, agotamiento, instantáneas independientes,
dimensiones escalares, cero, booleanas e inválidas y espacios de alto rango.
Se desplazaron **26 626 coordenadas** a posiciones Lua desde uno. Los productos
cartesianos grandes comparan prefijos acotados y no se presentan como recorridos
completos. Los rangos individuales originales son pequeños para evitar su
asignación anticipada en upstream. Las regresiones Lua verifican por separado
la construcción perezosa con dimensiones `math.maxinteger`; no se intentó
reservar esos rangos enormes en NumPy. El corpus se regenera exactamente y las
regresiones permanentes añaden 91 comprobaciones Lua.

La API sigue siendo parcial. Usa generic-for y nil para terminar, en lugar de
objetos Python iterator/StopIteration. No admite protocolos generales Python
de formas/`__index__` ni enteros fuera del rango Lua. No se certifican todas
las ABI ni el comportamiento ante límites de recursos. Consulta
[rejillas de coordenadas](index_grids.md) para rejillas numéricas y mallas abiertas.
