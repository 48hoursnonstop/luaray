---
docs_examples: true
---
# Consultar la disposición y controlar la escritura

`array.flags` muestra disposición, alineación, propiedad y permiso de escritura
del array nativo. `array:setflags` cambia escritura o el flag de alineación sin
copiar memoria ni reorganizar elementos.

## Consultar flags

```lua
local lr = require("luaray")
local matrix = lr.arange(6):reshape({2, 3}):copy()
assert(matrix.flags.c_contiguous and matrix.flags.owndata)
assert(not matrix.flags.f_contiguous)
local column_major = lr.asfortranarray(matrix)
assert(lr.isfortran(column_major))
assert(not lr.isfortran(lr.array({1, 2})))
```

C y F pueden ser verdaderos a la vez en escalares, vectores, dimensiones de
longitud uno y arrays vacíos. `lr.isfortran(array)` exige contigüidad F y **no** C.
Recibe un ndarray y no convierte otros valores Lua de manera implícita.

El objeto expone `c_contiguous`/`contiguous`, `f_contiguous`/`fortran`, `owndata`,
`aligned`, `writeable`, `writebackifcopy`, `fnc`, `forc`, `behaved`, `carray`,
`farray` y la máscara nativa `num`. Admite los nombres NumPy en mayúsculas y
abreviaturas como `flags["C"]`, `flags["W"]` y `flags["A"]`. En Lua los atributos
y las claves de texto comparten el mismo espacio. Las claves desconocidas fallan.
Los predicados compuestos siguen la fuente fijada, incluido FARRAY.
`writebackifcopy` es falso: el motor no expone ese protocolo de propiedad.

## Bloquear el propietario y sus vistas

```lua
local view = matrix:view()
assert(matrix:setflags({write = false}) == nil)
assert(not matrix.flags.writeable and view.flags.writeable)
view[1][1] = 9
assert(matrix[1][1] == 9)
view:setflags(false)
assert(not pcall(function() view:setflags(true) end))
matrix:setflags(true)
view:setflags(true)
assert(view.flags.writeable)
```

El bloqueo afecta a ese encabezado de array. Las vistas escribibles anteriores
conservan su permiso. Para reactivar una vista se consulta el permiso lógico
actual del propietario raíz, conservado aunque se recolecte su userdata Lua.
Un array propietario puede desbloquear su asignación mutable. La memoria de una
cadena es físicamente inmutable y nunca admite escritura. Las vistas de buffers
de arrays consultan su raíz. La parte imaginaria de una entrada real crea un
propietario bloqueado; sus vistas no pueden desbloquearse hasta desbloquearlo.

## Alineación y cambios fallidos

```lua
local bytes = string.pack("i4i4", 1, 2)
local unaligned = lr.frombuffer("x" .. bytes, "int32", 2, 1)
assert(not unaligned.flags.aligned)
assert(not pcall(function() unaligned:setflags(nil, true) end))
local readonly = lr.frombuffer(bytes, "int32")
local previous = readonly.flags.num
assert(not pcall(function() readonly:setflags(true, false) end))
assert(readonly.flags.num == previous)
```

`setflags(write, align)` admite booleanos opcionales; nil conserva la opción.
La otra forma es `setflags({write = false, align = false})`. Se puede desactivar
ALIGNED aunque la memoria esté alineada. Para activarlo se comprueban dirección
y strides utilizados; los arrays vacíos están alineados. Si falla la activación
de escritura, se restauran los cambios de alineación anteriores. Reactivar flags
no copia ni realinea memoria. Ambas formas devuelven nil.

## Los objetos guardados son instantáneas

```lua
local saved = matrix.flags
saved.writeable = false
assert(saved.writeable and not matrix.flags.writeable)
saved.writeable = true
assert(matrix.flags.writeable)
```

Como en NumPy 2.5.3, cada objeto conserva los bits del momento de creación.
Escribir `writeable` o `aligned` modifica su array, pero no la instantánea
anterior. Consulta de nuevo `array.flags` para obtener el estado actual. El
objeto retiene el array durante GC. La igualdad compara bits guardados. La
representación textual Lua es descriptiva y no reproduce el formato Python.

Los demás flags son de solo lectura. Modificar `uic`/WRITEBACKIFCOPY no está
admitido: no se simula su protocolo Python de separación de base y escritura
diferida. Las opciones exigen booleanos Lua, no objetos arbitrarios con
conversión de verdad Python. Los avisos de objetos/subclases y el comportamiento
Python completo no están certificados. La compatibilidad es parcial; se
comprueban disposición, cambios de estado, instantáneas, alineación y restauración.
