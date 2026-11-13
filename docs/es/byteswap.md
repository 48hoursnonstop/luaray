---
docs_examples: true
---
# Intercambiar bytes de los datos

`a:byteswap()` devuelve un array independiente y escribible con los bytes
invertidos dentro de cada componente numérico. `a:byteswap(true)` modifica la
asignación existente y devuelve el mismo userdata Lua. El descriptor dtype,
incluidos orden de bytes y metadatos temporales, no cambia.

```lua
local lr = require("luaray")
local values = lr.array({0x0102, 0x0304}, "uint16")
local swapped = values:byteswap()
assert(swapped:tolist()[1] == 0x0201)
assert(values:tolist()[1] == 0x0102)
assert(swapped.dtype == values.dtype)
assert(not lr.shares_memory(values, swapped))
```

La operación modifica el almacenamiento, sin conversión numérica. Enteros,
flotantes y valores temporales invierten su ancho completo. Los complejos
invierten por separado las componentes real e imaginaria. Unicode invierte
cada punto de código UCS-4 de cuatro bytes. Booleanos, números de un byte y
strings de bytes conservan sus datos. Objetos, dtypes estructurados y strings
de ancho variable quedan fuera del modelo de arrays admitido.

## Modificación y vistas

```lua
local reversed = lr.flip(values, 1)
assert(rawequal(reversed:byteswap({inplace=true}), reversed))
assert(values:tolist()[1] == 0x0201)
reversed:byteswap(true)
assert(values:tolist()[1] == 0x0102)
```

El método acepta un booleano o `{inplace=boolean}`; false, nil o una tabla vacía
seleccionan una copia. Los argumentos extra y las opciones desconocidas fallan.
El intercambio en el sitio afecta a todas las vistas de la asignación. Strides
negativos, direcciones desalineadas, broadcasting y vistas solapadas siguen el
orden de iteración original. En cada recorrido complejo se intercambian todas
las componentes reales antes de las imaginarias; importa si los elementos se
solapan. Repetir el intercambio en una vista solapada no garantiza deshacerlo.

## Disposición de la copia y solo lectura

```lua
values:setflags(false)
assert(not pcall(function() values:byteswap(true) end))
local writable = values:byteswap(false)
assert(writable.flags.writeable and not values.flags.writeable)
local columns = lr.asfortranarray(lr.array({{1, 2}, {3, 4}}, "int16"))
assert(columns:byteswap().flags.f_contiguous)
```

La copia usa la asignación ANYORDER del código original: una entrada contigua
solo en orden Fortran conserva F; otras entradas no contiguas pasan a C. La
salida posee almacenamiento nuevo y escribible. La modificación en el sitio
rechaza arrays de solo lectura incluso vacíos o con dtypes cuyo intercambio no
cambiaría bytes. Copiar S0/U0 usa el ancho mínimo del constructor; la operación
en el sitio conserva el ancho cero.

## Texto y precisión extendida

```lua
local text = lr.array({"λ", "ab"}, "U2")
local bytes = text:tobytes()
local swapped_text = text:byteswap()
assert(swapped_text:byteswap():tobytes() == bytes)
assert(swapped_text:byteswap():tolist()[1] == "λ")
```

El orden de bytes del descriptor no cambia: Unicode intercambiado puede tener
puntos de código inválidos. Inspecciona sus bytes o restaura la representación
correspondiente antes de decodificarlo. Los flotantes extendidos invierten todo
el almacenamiento de cada componente, incluido el padding de la ABI. No se
realizan cálculos flotantes sobre esos datos.

## Consultas de memoria de ancho cero

```lua
local storage = lr.arange(32, "uint8")
local zero = lr.ndarray({2, 3}, {
  dtype="S0", buffer=storage, offset=4, strides={2, 4},
})
assert(lr.may_share_memory(zero, zero))
assert(not lr.shares_memory(zero, zero))
```

Las consultas conservan un caso particular upstream: unos strides con extensión
positiva pueden solaparse aunque ningún elemento tenga bytes. El solver exacto
omite el término de ancho y refleja un operando respecto a `end-1`. La consulta
de límites puede devolver verdadero mientras la exacta devuelve falso incluso
para el mismo array. LuaRay conserva ahora este comportamiento dentro de sus
límites existentes de trabajo y memoria para consultas exactas. Un array con
cero elementos nunca se solapa. Esta convención no hace que las escrituras de
ancho cero toquen memoria.

## Referencias ejecutadas

La implementación aprobó **9 504 casos NumPy 2.5.3 / 190 320 comprobaciones
exactas** de byteswap con 24 dtypes, entradas vacías/escalares/3D, copias C/F,
solo lectura y disposiciones acotadas con strides negativos, desalineación,
strides cero y solapamiento. Se compara cada byte inicializado, incluido el
padding longdouble; los datos brutos no se decodifican como valores numéricos
ni Unicode. Se verifica el buffer base completo tras la modificación.

Otros **36 000 casos / 72 000 comprobaciones** validan consultas exactas y de
límites con vistas S/U de ancho cero y mezclas de anchos. Los dos corpus se
regeneran exactamente. La regresión Lua permanente añade 108 comprobaciones;
la prueba nativa cubre propiedad, rechazo de solo lectura, datos completos de
componentes y orden de escritura. Las APIs siguen siendo parciales: no se
certifican protocolos externos, objetos/dtypes estructurados generales, todas
las ABI ni el solver original completo sin límites de trabajo.
