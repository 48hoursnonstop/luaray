---
docs_examples: true
---
# Límites numéricos

`lr.finfo(dtype)` describe un formato flotante nativo. `lr.iinfo(dtype)` devuelve
los extremos enteros. Aceptan nombres dtype o descriptores `lr.dtype`. Un número
flotante Lua selecciona float64, un entero selecciona int64 y un escalar complejo
Lua selecciona complex128. Cada función rechaza los tipos incompatibles.

```lua
local lr = require("luaray")
local single = lr.finfo("float32")
assert(single.bits == 32 and single.nmant == 23)
assert(single.eps == 2^-23 and single.epsneg == 2^-24)
local signed = lr.iinfo(lr.dtype("int16"))
assert(signed.min == -32768 and signed.max == 32767)
```

## Campos de punto flotante

`bits` es el ancho de almacenamiento y `nmant` cuenta bits de mantisa almacenados.
`eps` mide la distancia sobre uno; `epsneg`, la distancia por debajo. `min` y
`max` son extremos finitos. `minexp`, `maxexp`, `machep`, `negep`, `nexp` e `iexp`
describen exponentes binarios; `precision` y `resolution`, dígitos decimales.
El campo dtype es un descriptor.

```lua
local info = lr.finfo("float32")
local one = lr.array(1, info.dtype)
local step = lr.array(info.eps, info.dtype)
assert(lr.add(one, step):tolist() == 1 + info.eps)
assert(info.min == -info.max)
assert(info.minexp == -126 and info.maxexp == 128)
```

`tiny` y `smallest_normal` son el menor valor positivo normal.
`smallest_subnormal` es el menor positivo subnormal. Los subnormales tienen menos
precisión que los normales; las constantes describen el formato, no el
comportamiento de todos los entornos externos de punto flotante.

```lua
local half = lr.finfo("float16")
assert(half.tiny == 2^-14 and half.smallest_normal == half.tiny)
assert(half.smallest_subnormal == 2^-24)
assert(half.precision == 3)
```

## Complejos y caché

La información compleja describe su componente real: complex64 se resuelve a
float32, complex128 a float64 y clongdouble a longdouble. Los registros flotantes
se comparten por ese dtype resuelto; cada llamada entera crea otro registro.
Son userdata Lua inmutables. Su representación textual corta sigue las
convenciones LuaRay, no el informe multilínea de NumPy.

```lua
local real = lr.finfo("float32")
local complex = lr.finfo("complex64")
assert(rawequal(real, complex) and complex.dtype == lr.dtype("float32"))
assert(not pcall(function() real.eps = 1 end))
assert(not rawequal(lr.iinfo("int32"), lr.iinfo("int32")))
```

## Constantes amplias sin pérdidas

Los campos flotantes half, float32 y float64 son números Lua. Los campos
longdouble son arrays tipados de rango cero independientes, para conservar su
precisión y rango de exponentes. Modificar un array devuelto no cambia el
registro. La misma regla conserva el máximo uint64, que excede el entero Lua
con signo; los otros extremos enteros son enteros Lua.

```lua
local extended = lr.finfo("longdouble")
assert(extended.max.ndim == 0 and extended.max.dtype == "longdouble")
local bytes = extended.max:tobytes():sub(1, 10)
local copy = extended.max
copy:fill(0)
assert(extended.max:tobytes():sub(1, 10) == bytes)
local unsigned = lr.iinfo("uint64")
assert(unsigned.min == 0 and unsigned.max:tobytes() == string.rep("\255", 8))
assert(lr.iinfo("int64").min == math.mininteger)
```

Usa operaciones nativas de arrays con esos valores amplios. Convertirlos en un
número Lua puede perder precisión, subdesbordar o desbordar. El ejemplo de bytes
significativos refleja la ABI x86 longdouble comprobada; otras ABI necesitan
validación independiente.

## Entradas inválidas y alcance

Los dtypes booleanos, de cadenas o temporales no tienen registro compatible.
Se rechazan instancias de array; pasa `.dtype`. No hay dtype predeterminado.
Los campos desconocidos y las escrituras en registros producen error Lua.

```lua
local values = lr.array({1, 2, 3}, "float32")
assert(lr.finfo(values.dtype).bits == 32)
assert(not pcall(lr.finfo, values))
assert(not pcall(lr.iinfo, "bool"))
assert(not pcall(lr.finfo, nil))
```

Las constantes siguen el origen NumPy fijado y los límites del formato C nativo.
No se reproducen todas las clases escalares Python, mutación/cached properties,
formato textual, dtypes externos, endian numérico no nativo ni todas las ABI.
La API permanece clasificada como parcialmente compatible.

## Verificación de 0.160.0-dev

Los límites numéricos aprobaron **260 casos /2 849 comprobaciones** contra NumPy2.5.4, más62 comprobaciones Lua, una prueba nativa y cabeceras/enlace C++. Se comparan exactamente campos públicos, mapeo real/complejo, extremos enteros, alias, validación y metadatos dtype. Las constantes longdouble y el máximo uint64 usan escalares tipados independientes; se omite padding x87. La identidad en caché e inmutabilidad son contratos Lua explícitos. El corpus se regeneró exactamente.

