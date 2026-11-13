---
docs_examples: true
---
# Consultar dimensiones y cantidad de elementos

`lr.shape`, `lr.ndim` y `lr.size` consultan un ndarray o convierten una entrada Lua
admitida con el descubrimiento nativo. Los ndarrays existentes se consultan
directamente: no se copian ni recorren sus elementos, no cambian sus flags y no
se exige permiso de escritura.

```lua
local lr = require("luaray")
local matrix = lr.arange(6):reshape({2, 3})
local shape = lr.shape(matrix)
assert(shape[1] == 2 and shape[2] == 3)
assert(lr.ndim(matrix) == 2 and lr.size(matrix) == 6)
assert(lr.size(matrix, 1) == 2 and lr.size(matrix, -1) == 3)
shape[1] = 99
assert(lr.shape(matrix)[1] == 2)
```

`shape` devuelve una secuencia Lua nueva con las longitudes de dimensiones.
Modificarla no cambia la forma del array. `ndim` devuelve el rango. Sin eje,
`size` devuelve el total de elementos; con eje devuelve la longitud de ese eje.
Los resultados enteros usan enteros Lua. En un vector coinciden longitud y tamaño
total; en varias dimensiones, la longitud del primer eje no es el total.

## Escalares, secuencias y ejes

```lua
assert(lr.ndim(7) == 0 and lr.size(7) == 1 and #lr.shape(7) == 0)
assert(lr.ndim({{}, {}}) == 2 and lr.size({{}, {}}) == 0)
assert(lr.size({{1, 2}, {3, 4}}, -1) == 2)
assert(not pcall(function() lr.size(matrix, 0) end))
assert(not pcall(function() lr.shape({{1, 2}, {3}}) end))
```

Los ejes positivos empiezan en uno. Los negativos cuentan desde el final; cero,
ejes fuera de rango y valores no enteros fallan. Nil indica ausencia de eje.
Los escalares tienen rango cero, forma `{}` y un elemento; no admiten eje.
Cualquier dimensión vacía hace cero el total. Las secuencias irregulares fallan
mediante las comprobaciones de creación existentes.

Las secuencias y escalares Lua admitidos usan descubrimiento nativo, que puede
asignar memoria temporal. Ndarrays anidados, objetos externos, protocolos de
atributos/arrays Python, dtypes de objetos/estructuras y nil escalar mantienen las
limitaciones de creación. Para un ndarray existente no hace falta memoria de
datos temporal.

## Vistas grandes y de solo lectura

```lua
local huge = lr.broadcast_to(lr.array(1, "int8"), {2^30, 2^20})
assert(lr.size(huge) == 2^50 and lr.ndim(huge) == 2)
assert(lr.size(huge, 1) == 2^30 and not huge.flags.writeable)
local readonly = lr.frombuffer(string.pack("i4i4", 1, 2), "int32")
assert(lr.size(readonly) == 2 and not readonly.flags.writeable)
```

La vista grande conserva un único byte almacenado. Las consultas usan la forma,
incluso strides cero, sin evaluar sus elementos. La misma ruta directa admite
rango 64, vistas invertidas/transpuestas, buffers inmutables y memoria no alineada.
No lee valores escalares ni modifica la propiedad de memoria.

La compatibilidad con `fromnumeric.py` de NumPy 2.5.3 es parcial. Secuencias Lua
reemplazan las tuplas de forma y los ejes siguen la base uno de Lua. Las
referencias comprueban formas, rangos, aceptación de ejes, totales enteros y
estados intactos de entrada/base. No certifican protocolos o tipos no admitidos.
