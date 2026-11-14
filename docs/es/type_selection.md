---
docs_examples: true
---
# Clasificar y seleccionar tipos

`lr.isdtype(dtype, kind)` compara un descriptor dtype real con una clase escalar
o categoría. `lr.common_type(...)` elige un dtype inexacto desde ndarrays.
Devuelve un descriptor que puede pasarse a constructores de arrays.

```lua
local lr = require("luaray")
local single = lr.dtype("float32")
assert(lr.isdtype(single, "real floating"))
assert(not lr.isdtype(single, "integral"))
local selected = lr.common_type(lr.ones({2}, "float32"), lr.ones({2}, "int16"))
assert(selected == lr.dtype("float64"))
```

## Categorías

Los nombres reconocidos son `bool`, `signed integer`, `unsigned integer`,
`integral`, `real floating`, `complex floating` y `numeric`. Integral incluye
enteros con y sin signo. Numeric incluye enteros y flotantes reales/complejos;
excluye booleanos, texto, datetime y timedelta.

```lua
assert(lr.isdtype(lr.dtype("uint64"), "integral"))
assert(lr.isdtype(lr.dtype("complex64"), "numeric"))
assert(not lr.isdtype(lr.dtype("bool"), "numeric"))
assert(not lr.isdtype(lr.dtype("timedelta64[h]"), "integral"))
```

## Clases escalares y almacenamiento equivalente

Un selector descriptor compara clases escalares. Ignora anchos de cadenas y
unidades temporales, como el origen fijado. Igual ancho no implica igual clase:
en el Linux comprobado, int64 y longlong tienen clases escalares diferentes.
Esto difiere de la igualdad de descriptores.

```lua
assert(lr.isdtype(lr.dtype("S3"), lr.dtype("S8")))
assert(lr.isdtype(lr.dtype("datetime64[D]"), lr.dtype("datetime64[ns]")))
assert(lr.dtype("int64") == lr.dtype("longlong"))
assert(not lr.isdtype(lr.dtype("int64"), lr.dtype("longlong")))
```

El primer argumento debe ser un descriptor: usa `lr.dtype(values.dtype)` para un
array. Una cadena selectora es categoría, nunca nombre dtype; usa un descriptor
para un tipo concreto. Los alias siguen el constructor existente, con sus
mismos límites de tipos externos y endian.

## Varios selectores

Una secuencia Lua densa representa la tupla del origen. El resultado es verdadero
si coincide algún selector; una secuencia vacía da falso. Se validan todos los
elementos, también los posteriores a una coincidencia. Las secuencias anidadas
y categorías desconocidas producen error. Nil no puede ser elemento de una
secuencia densa.

```lua
local single = lr.dtype("float32")
assert(lr.isdtype(single, {"integral", "real floating"}))
assert(not lr.isdtype(single, {}))
assert(not pcall(lr.isdtype, single, {"real floating", "invalid"}))
assert(not pcall(lr.isdtype, "float32", "numeric"))
assert(not pcall(lr.isdtype, single, "float32"))
```

## Precisión inexacta común

`common_type` elige float16, float32, float64 o longdouble, o su formato complejo
correspondiente si existe algún argumento complejo. Los enteros fuerzan al
menos float64; float32 con complex64 conserva complex64 salvo que otro argumento
necesite más precisión. Solo examina metadatos dtype: forma, vacíos, strides y
permisos de escritura no cambian el resultado.

```lua
local half = lr.ones({2}, "float16")
local single = lr.ones({2}, "float32")
local complex = lr.ones({2}, "complex64")
assert(lr.common_type(half) == lr.dtype("float16"))
assert(lr.common_type(single, complex) == lr.dtype("complex64"))
assert(lr.common_type(complex, lr.empty({0}, "int8")) == lr.dtype("complex128"))
assert(lr.common_type() == lr.dtype("float16"))
```

El resultado float16 sin argumentos sigue el origen. Se rechazan arrays
booleanos, de texto y datetime. Timedelta sigue otra regla del origen: su clase
es subclase entera para `common_type` y selecciona al menos float64, aunque
`isdtype` la excluye de las categorías integral/numeric.

```lua
local duration = lr.zeros({0}, "timedelta64[h]")
assert(lr.common_type(duration) == lr.dtype("float64"))
assert(not lr.isdtype(lr.dtype(duration.dtype), "numeric"))
assert(not pcall(lr.common_type, lr.zeros({0}, "bool")))
assert(not pcall(lr.common_type, {1, 2}))
```

El resultado común Lua es un descriptor, no una clase escalar Python. Los
argumentos deben ser ndarrays reales. No se certifican instancias escalares
Python, despacho de subclases/externo, tipos estructurados/object/StringDType
variable ni todas las ABI. Las API siguen clasificadas como parciales.

## Verificación de 0.161.0-dev

La clasificación y selección de tipos aprobó **5 468 casos /18 625 comprobaciones** contra NumPy2.5.4:4 320 entradas válidas y1 148 rechazos esperados. Otras39 comprobaciones Lua, una prueba nativa y cabeceras/enlace C++ aprobaron. Las comparaciones exactas incluyen clases/categorías, validación completa, tuplas vacías/inválidas, precisión inexacta, reglas de duraciones y estados de entrada. Las secuencias densas Lua representan tuplas; el tipo común se devuelve como descriptor. Los dos corpus se regeneraron exactamente.

