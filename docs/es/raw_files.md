---
docs_examples: true
---
# Archivos binarios de arrays

`lr.fromfile(archivo, {dtype = "float64"})` lee elementos binarios nativos
en un ndarray propio de una dimensión. `array:tofile(archivo)` escribe el
array en orden lógico C. Ambas funciones aceptan una ruta o un archivo Lua
abierto.

```lua
local lr = require("luaray")
local source = lr.array({{1, 2}, {3, 4}}, "int16")
local file = assert(io.tmpfile())
lr.transpose(source):tofile(file)
assert(file:seek("set", 0) == 0)
local values = lr.fromfile(file, {dtype = "int16"})
assert(values.size == 4 and values[2] == 3)
assert(file:close())
```

La lectura admite `dtype` (float64 por defecto), `count` y `offset`. El
desplazamiento en bytes es relativo a la posición actual. Un count negativo
lee todos los elementos completos que quedan en un archivo posicionable.
Un count positivo lee hasta esa cantidad de elementos completos.

```lua
local file = assert(io.tmpfile())
assert(file:write("xx" .. string.pack("<i2i2", 7, 9)))
assert(file:seek("set", 0) == 0)
local first = lr.fromfile(file, {dtype = "int16", offset = 2, count = 1})
assert(first[1] == 7 and file:seek() == 4)
assert(file:close())
```

Los ejemplos usan el orden nativo little-endian de la plataforma probada.
El formato guarda los bytes de los elementos. Conserva el dtype, el orden
de bytes y la forma por separado al compartir archivos. Una ruta de salida
reemplaza el archivo. Un archivo abierto se escribe desde la posición actual
y queda abierto. Esta API admite datos binarios. Para una cadena de texto
numérico en memoria, consulta [Leer texto numérico](fromstring.md).

## Validación

Aprobaron **2 826 casos / 34 186 comprobaciones** con NumPy 2.5.5. La batería compara bytes, dtype y forma, conteos, offsets con signo, posición final del archivo y escritura en orden C desde arrays transpuestos, invertidos y de solo lectura. La lectura binaria usa descriptores nativos con itemsize distinto de cero. Los formatos de texto tienen un alcance de compatibilidad separado.
