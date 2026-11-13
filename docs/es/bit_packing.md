---
docs_examples: true
---
# Empaquetar y desempaquetar bits

`lr.packbits` guarda la verdad de ocho elementos enteros o Boolean en un byte
`uint8`. El cero se convierte en un bit cero; cualquier entero no nulo, en uno.
`lr.unpackbits` expande bytes `uint8` a un array `uint8` de ceros y unos.
Ambas funciones devuelven memoria propia, escribible e independiente de la entrada.

```lua
local lr = require("luaray")
local values = lr.array({1, 0, -2, 0, 1, 0, 1, 0, 1}, "int16")
local packed = lr.packbits(values)
assert(packed.dtype == "uint8" and packed.size == 2)
assert(packed[1] == 170 and packed[2] == 128)
```

## Orden de bits y ceros finales

`bitorder = "big"` es el valor predeterminado: la primera verdad ocupa el bit
más significativo. `"little"` la coloca en el menos significativo. Al empaquetar,
se completa el último byte con bits cero. Conserva la longitud original para
quitar ese relleno al desempaquetar.

```lua
local packed_little = lr.packbits(values, {bitorder = "little"})
assert(packed_little[1] == 85 and packed_little[2] == 1)
local restored = lr.unpackbits(packed_little, {
  bitorder = "little", count = values.size
})
assert(restored.size == 9 and restored[3] == 1 and restored[9] == 1)
```

## Aplanado y ejes

Sin eje, la entrada se aplana en orden lógico C: la última dimensión cambia
más rápido. Un eje explícito conserva las demás dimensiones. Los ejes Lua
positivos empiezan en uno; los negativos cuentan desde el final. El eje cero
es inválido. Las entradas escalares se tratan como arrays de longitud uno.

```lua
local matrix = lr.array({{1, 0, 1}, {0, 1, 0}}, "int32")
local rows = lr.packbits(matrix, {axis = 2})
assert(rows:get(1, 1) == 160 and rows:get(2, 1) == 64)
assert(lr.packbits(matrix)[1] == 168)
local expanded = lr.unpackbits(rows, {axis = -1, count = 3})
assert(expanded.shape[1] == 2 and expanded.shape[2] == 3)
assert(expanded:get(2, 2) == 1)
```

## Elegir la cantidad de bits

Un `count` no negativo fija la longitud de salida en el eje elegido. Una
cantidad menor conserva los primeros bits; una mayor añade ceros. Un valor
negativo recorta esa cantidad desde el final de los `8 * byte_count` bits
disponibles. Recortar más bits de los disponibles produce un error. Las
cantidades deben ser enteros Lua.

```lua
local byte = lr.array({128}, "uint8")
local padded = lr.unpackbits(byte, {count = 10})
assert(padded.size == 10 and padded[1] == 1 and padded[10] == 0)
local trimmed = lr.unpackbits(byte, {count = -7})
assert(trimmed.size == 1 and trimmed[1] == 1)
assert(not pcall(lr.unpackbits, byte, {count = -9}))
```

## Vistas y disposición de salida

Se admiten arrays invertidos, con pasos, broadcast, de solo lectura y sin
alinear. Las salidas con eje explícito usan orden Fortran cuando la entrada
es exclusivamente contigua Fortran; en otro caso, C. Los resultados vacíos
siguen las reglas normales de strides vacíos. Las entradas conservan sus
bytes y permisos.

```lua
local source = lr.asfortranarray(matrix)
source:setflags(false)
local packed_rows = lr.packbits(source, {axis = 2})
assert(packed_rows.strides[1] == 1 and packed_rows.strides[2] == 2)
assert(not lr.shares_memory(packed_rows, source))
packed_rows:fill(0)
assert(source:get(1, 1) == 1 and not source.flags.writeable)
```

## Entradas vacías y controles admitidos

Expandir un eje empaquetado vacío a una cantidad positiva produce ceros
definidos en LuaRay. **Es una diferencia deliberada frente a NumPy 2.5.3**:
su iterador de entrada vacía puede omitir la inicialización y devolver bytes
indefinidos. Esas salidas se excluyen de las comparaciones de paridad; la
política de ceros tiene pruebas Lua y nativas permanentes separadas. No se calculan direcciones de entrada para un eje empaquetado vacío,
incluidas vistas con strides extremos.

```lua
local zeros = lr.unpackbits(lr.empty({3, 0}, "uint8"), {
  axis = 2, count = 9
})
assert(zeros.shape[1] == 3 and zeros.shape[2] == 9)
assert(lr.count_nonzero(zeros) == 0)
assert(not pcall(lr.packbits, lr.array({1.0}, "float64")))
assert(not pcall(lr.unpackbits, {1, 2})) -- construir explícitamente un uint8
```

Las tablas de opciones admiten `axis` y `bitorder`; al desempaquetar, también
`count`. Las formas posicionales son `lr.packbits(input, axis, bitorder)` y
`lr.unpackbits(input, axis, count, bitorder)`. Los controles omitidos o `nil`
usan los valores predeterminados. No combines una tabla de opciones con
controles posicionales. Se rechazan claves desconocidas y nombres con NUL.
Usa los nombres de orden canónicos anteriores; el análisis heredado sigue el
origen fijado: pack acepta prefijos `big`/`little`; unpack, una primera `b`/`l`.

El empaquetado de bits aprobó **37 640 casos /250 644 comprobaciones**: 15 029 pack y 22 611 unpack; 7 958 entradas válidas y 29 682 rechazos esperados. Incluye 201 comprobaciones Lua permanentes, una prueba nativa y cabeceras/enlace C++. Se verifican bytes, dtype, forma, strides, flags, memoria independiente, entradas intactas, órdenes/ejes, count, límites y todos los bytes Boolean. Se adaptaron 16 804 ejes no negativos a posiciones Lua. El corpus se regeneró exactamente. Otros 358 estados del origen con salida sin inicializar se excluyen de paridad; la política LuaRay de ceros se prueba por separado.

Las API siguen parciales. Se conserva el límite de 32 dimensiones del iterador
heredado de ejes explícitos; el aplanado admite arrays compatibles de hasta
64 dimensiones. No se implementan ejes/cantidades escalares tipados,
protocolos externos de arrays/índices, clases escalares Python ni clases
exactas de advertencias/excepciones. Se usan bucles nativos escalares: no se
certifican rendimiento SIMD equivalente, todos los ABI, reservas enormes
ni todas las combinaciones de entrada.
