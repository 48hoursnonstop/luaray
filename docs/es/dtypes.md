---
docs_examples: true
---
# Descriptores dtype reutilizables

`lr.dtype(specification)` crea un descriptor nativo inmutable. Describe memoria
y conversión, sin contener valores de array. Sin argumento, o con nil, selecciona
float64. Un descriptor existente devuelve la misma userdata.

```lua
local lr = require("luaray")
local dtype = lr.dtype("float64")
assert(dtype.name == "float64" and dtype.kind == "f" and dtype.char == "d")
assert(dtype.itemsize == 8 and dtype.isnative and not dtype.hasobject)
assert(rawequal(lr.dtype(dtype), dtype))
assert(lr.dtype(dtype.str) == dtype)
```

## Propiedades

| Propiedad | Significado para los descriptores escalares admitidos |
| --- | --- |
| name | Nombre canónico NumPy, como float64, bytes24 o str96 |
| str | Formato de memoria, con endian, ancho y unidad temporal |
| kind, char, num | Categoría, código de carácter y número de tipo nativo |
| itemsize, alignment | Tamaño y alineación del elemento en bytes |
| byteorder | `=`, `\|`, `<` o `>`; el endian nativo se normaliza a `=` |
| flags | Flags del descriptor; Unicode incluye NEEDS_INIT (8) |
| isnative, hasobject | Orden nativo y clasificación de objetos contenidos |
| ndim, shape, base | Cero, secuencia vacía y el propio descriptor |
| fields, names, subdtype, metadata | Nil en los tipos escalares admitidos |
| isalignedstruct | Falso; aún no hay descriptores estructurados |
| descr | Secuencia nueva con nombre de campo vacío y formato de memoria |

El ancho Unicode cuenta puntos de código UCS-4: U3 ocupa 12 bytes y se llama
str96. S3 ocupa tres bytes y se llama bytes24. Estos nombres difieren de sus
formatos de memoria. Longdouble muestra el nombre NumPy de su ancho, como
float128 en la ABI comprobada; conserva la precisión real de esa ABI.

La igualdad compara equivalencia de descriptores concretos, incluidos ancho,
endian y unidad temporal. Los aliases enteros equivalentes pueden tener códigos
y números de tipo diferentes. Compara descriptores entre sí: Lua no invoca la
igualdad de userdata contra un string. `tostring(dtype)` sigue la representación
NumPy de los tipos escalares admitidos.

## Usarlos con arrays

```lua
local values = lr.array({1, 2, 3}, dtype)
local integers = lr.astype(values, lr.dtype("int32"))
assert(integers.dtype == "int32")
assert(lr.frombuffer(values, lr.dtype("uint8")).shape[1] == 24)
assert(lr.can_cast(lr.dtype("int32"), dtype))
assert(lr.dtype(lr.promote_types(lr.dtype("int8"), dtype)) == dtype)
```

El lector compartido se usa en constructores de creación/conversión/like,
`arange`, `astype`, `view`, `frombuffer`, controles dtype de matrices, uniones,
reducciones, acumulaciones y muestreo. `require` delega en la creación.
`can_cast`, `issubdtype`, `promote_types` y `result_type` admiten descriptores.
Las funciones de promoción conservan sus resultados string Lua existentes.

La propiedad `array.dtype` también conserva su string de almacenamiento Lua.
Usa `lr.dtype(array.dtype)` para inspeccionarla. Se conservan nombres como
longdouble y longlong, aunque el `name` NumPy del descriptor difiera. Otros
lectores antiguos, incluidos algunos controles de generadores aleatorios, aún
exigen strings; no se certifican descriptores en todas las APIs públicas.

## Resolver anchos sin modificar el descriptor

```lua
local unicode = lr.empty({3}, lr.dtype("U4"))
assert(unicode[1] == "" and unicode[3] == "")
local unsized = lr.dtype("S0")
local joined = lr.concatenate({lr.array({1}, "int32"), lr.array({2}, "int32")},
  {dtype = unsized, casting = "unsafe"})
assert(joined.itemsize == 11 and joined[1] == "1" and joined[2] == "2")
assert(unsized.itemsize == 0)
```

Las asignaciones Unicode respetan NEEDS_INIT, también en `empty` y `empty_like`:
los puntos de código nuevos son cero. Los valores de `empty` numérico siguen sin
inicializar. Un descriptor de ancho cero sigue siendo de ancho cero; creación,
casts, muestreo y uniones resuelven otro descriptor según su contrato.

Una unión sin ancho lo resuelve desde los descriptores de entrada, sin mirar
valores. Una única entrada Unicode de la misma clase conserva su endian;
combinar instancias normaliza mediante common-instance. El cast final del
muestreo usa el ancho de formato del dtype de cálculo.

## Aliases y errores

```lua
assert(lr.dtype("float") == lr.dtype("float64"))
assert(lr.dtype("f") == lr.dtype("float32"))
assert(lr.dtype("longlong") == lr.dtype("int64"))
assert(lr.dtype("longlong").itemsize == lr.dtype("int64").itemsize)
assert(not pcall(function() dtype.itemsize = 1 end))
```

`float` pasa a significar correctamente float64. Usa float32 o `f` para precisión
simple. Se admiten códigos numéricos de carácter/ancho y prefijos de endian
nativo. No se admiten descriptores numéricos o temporales con endian no nativo;
sí Unicode fijo con endian no nativo. Especificaciones inválidas o con NUL
incrustado fallan sin seleccionar un tipo alternativo.

La compatibilidad con NumPy 2.5.3 es parcial. No se implementan clases escalares
Python, ctypes, protocolos externos, descriptores de estructuras/subarrays/objetos/
void/StringDType, opciones align/copy/metadata del constructor, `type`, `isbuiltin`,
`newbyteorder` ni otras propiedades no listadas. Las propiedades no admitidas
fallan. Esto no implica compatibilidad completa con clases dtype ni protocolos
Python. Consulta [operaciones temporales](temporal_scaling.md) y
[verificación](development/validation.md).

La frontera nativa ofrece formato y equivalencia mediante `ln_dtype_info.h`, con
buffers de salida del llamador. Los bindings obtienen descriptores inmutables
prestados mediante `ln_lua_check_dtype`. El uso normal no requiere Python.
