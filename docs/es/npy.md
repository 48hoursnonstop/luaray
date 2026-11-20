---
docs_examples: true
---

# Guardar y cargar arrays NPY

`lr.save(file, array)` y `lr.load(file)` intercambian arrays individuales
en el formato NPY de NumPy. Cada registro guarda su dtype, forma, orden de
memoria y bytes. Se admite una ruta o un archivo de Lua abierto.

```lua
local lr = require("luaray")
local source = lr.asfortranarray(lr.array({{1, 2, 3}, {5, 7, 11}}, "int16"))
local file = assert(io.tmpfile())
lr.save(file, source)
assert(file:seek("set", 0) == 0)
local values = lr.load(file)
assert(lr.array_equal(source, values))
assert(values.dtype == "int16" and values.flags.f_contiguous)
assert(file:close())
```

Al guardar por ruta se agrega `.npy` si falta la extensión. La lectura
usa la ruta tal como se escribió. Un archivo abierto permanece abierto y
avanza un registro después de cada operación.

```lua
local file = assert(io.tmpfile())
lr.save(file, lr.array(7, "uint8"), {version = 2})
lr.save(file, lr.array(11, "uint8"), {version = 3})
assert(file:seek("set", 0) == 0)
assert(lr.load(file):item() == 7)
assert(lr.load(file):item() == 11)
assert(file:close())
```

La versión de salida predeterminada es 1.0. La opción `version` admite los
enteros 1, 2 o 3 para 1.0, 2.0 o 3.0. La lectura acepta las tres versiones y
comprueba el tamaño de la cabecera antes de leerla. Usa `max_header_size` para
ajustar el límite en bytes. El valor predeterminado es 10 000.

Se admiten descriptores numéricos y temporales nativos, cadenas de bytes de
ancho fijo y Unicode. Usa [archivos binarios de arrays](raw_files.md) si el
dtype y la forma se guardan por separado.
