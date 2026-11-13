---
docs_examples: true
---
# Operaciones enteras

LuaRay ofrece inversión de bits, conteos, desplazamientos, máximo común divisor
y mínimo común múltiplo mediante el motor nativo de arrays. Estas operaciones
admiten dtypes enteros, broadcasting y vistas con strides.

```lua
local lr = require("luaray")
local values = lr.array({-7, -1, 0, 7}, "int8")
assert(lr.invert(values)[1] == 6)
assert((~values)[4] == -8)
local counts = lr.bitwise_count(values)
assert(counts[1] == 3 and counts[2] == 1)
assert(lr.dtype(counts.dtype).name == "uint8")
```

`bitwise_count` cuenta los bits del **valor absoluto** de cada elemento con signo.
Por tanto, el conteo de `-1` es uno. Su dtype de salida siempre es uint8. La
inversión booleana es negación lógica; su conteo es cero o uno.

## Desplazamientos y ancho fijo

`left_shift` y `right_shift` también admiten los operadores Lua `<<` y `>>`.
El desplazamiento derecho con signo extiende el bit de signo. Los resultados
usan enteros de ancho fijo, por lo que desplazar a la izquierda puede desbordar
con wrap. Un conteo negativo o excesivo produce cero a la izquierda y cero o
extensión del signo a la derecha. Es la semántica de arrays NumPy: los conteos
negativos no invierten la dirección.

```lua
local signed = lr.array({-8, 7}, "int8")
assert((signed >> 1)[1] == -4)
assert((signed << -1)[1] == 0)
assert((signed >> 64)[1] == -1)
local bytes = lr.array({255}, "uint8")
assert((bytes << 1)[1] == 254)
assert(not pcall(function() return bytes << 256 end))
```

Un entero Lua combinado con un array usa comprobación de límites de escalar débil
antes de ejecutar. El conteo 256 no cabe en un operando uint8 y se rechaza.
Los arrays enteros de tipos distintos usan la resolución de bucles de cada
operación; int64/uint64 no tienen un bucle entero común seguro. Se rechazan
operandos flotantes, complejos, cadenas y temporales, incluso arrays vacíos de
esos tipos. Los desplazamientos Boolean calculan en int8.

## Broadcasting y salida con máscara

La tabla opcional admite `out` y `where`. Otras claves se rechazan; estas
funciones aún no implementan todos los controles dtype/casting/order de NumPy.
Usa una salida inicializada si necesitas valores definidos fuera de la máscara.

```lua
local grid = lr.left_shift(lr.array({{1}, {2}}, "int16"),
                          lr.array({0, 1, 2}, "int16"))
assert(grid:get(2, 3) == 8)
local out = lr.full({3}, 99, {dtype = "int16"})
local returned = lr.right_shift({1, 2, 3}, 1, {
  out = out, where = lr.array({true, false, true})
})
assert(rawequal(returned, out))
assert(out[1] == 0 and out[2] == 99 and out[3] == 1)
```

Las salidas siguen las comprobaciones compartidas de casting same-kind y
escritura. Las entradas de solo lectura pueden producir arrays nuevos. Las
salidas solapadas se almacenan temporalmente cuando hace falta para conservar
los valores de entrada pendientes.

```lua
local shared = lr.array({1, 2, 3}, "int8")
local reversed = lr.flip(shared, 1)
lr.left_shift(shared, 1, {out = reversed})
assert(shared[1] == 6 and shared[2] == 4 and shared[3] == 2)
```

## Máximo común divisor y mínimo común múltiplo

`gcd` y `lcm` usan magnitudes enteras absolutas. El par cero/cero devuelve cero;
el MCM también es cero cuando cualquiera de los operandos es cero. Se rechazan
combinaciones exclusivamente Boolean, pero Boolean/entero puede promoverse a un
dtype entero.

```lua
local common = lr.gcd(lr.array({-12, 0, 18}, "int16"), 6)
local multiple = lr.lcm(lr.array({-12, 0, 18}, "int16"), 6)
assert(common[1] == 6 and common[2] == 6 and common[3] == 6)
assert(multiple[1] == 12 and multiple[2] == 0 and multiple[3] == 18)
assert(not pcall(lr.gcd, lr.array({true}), lr.array({false})))
```

El wrap de ancho fijo también se aplica al MCM y a un MCD con signo cuyo
resultado positivo no cabe en su dtype. Las magnitudes mínimas con signo se
calculan sin desbordar una negación C con signo.

```lua
local minimum = lr.array({math.mininteger}, "int64")
assert(lr.bitwise_count(minimum)[1] == 1)
assert(lr.gcd(minimum, 0)[1] == math.mininteger)
assert(lr.lcm(minimum, 1)[1] == math.mininteger)
```

## Buffers Boolean y alias enteros

Convertir un buffer Boolean a un dtype numérico usa su valor de verdad, aunque
sus bytes crudos sean 2 o 255. Una copia de identidad Boolean conserva esos
bytes. La promoción de alias enteros equivalentes ya no depende del orden de
los argumentos. Los desplazamientos y MCD/MCM aún pueden elegir clases de alias
distintas por sus reglas de resolución diferentes, como en upstream.

```lua
local payload = string.char(0, 2, 255)
local raw = lr.ndarray({3}, {dtype = "bool", buffer = payload})
local numeric = lr.astype(raw, "int8")
assert(numeric[1] == 0 and numeric[2] == 1 and numeric[3] == 1)
assert(raw:tobytes() == payload)
local forward = lr.dtype(lr.promote_types("longlong", "int64"))
local reverse = lr.dtype(lr.promote_types("int64", "longlong"))
assert(forward.char == reverse.char)
```

## Nombres y resultados escalares

`bitwise_not` y `bitwise_invert` son alias de `invert`. `bitwise_left_shift` y
`bitwise_right_shift` son alias de los desplazamientos correspondientes. Las
llamadas escalares ordinarias devuelven ndarrays tipados de dimensión cero,
como las operaciones unarias/binarias existentes de LuaRay.

```lua
assert(lr.bitwise_not == lr.invert and lr.bitwise_invert == lr.invert)
assert(lr.bitwise_left_shift == lr.left_shift)
assert(lr.bitwise_right_shift == lr.right_shift)
local scalar = lr.bitwise_count(7)
assert(scalar.ndim == 0 and scalar:item() == 3)
assert(not pcall(lr.invert, values, {dtype = "int16"}))
```

Las referencias aprobaron **144 844 casos /3 318 010 comprobaciones**: 143 680 casos de operaciones y 1 164 de conversiones Boolean/promoción. Se comprueban bytes, dtype.char/num, forma, strides, flags, máscaras, salidas solapadas, límites y estados después de errores. Se normalizaron 2 120 escalares NumPy al contrato Lua de arrays tipados de dimensión cero; no se afirma equivalencia con objetos escalares Python. Las regresiones permanentes añaden 6 242 comprobaciones Lua, una prueba nativa y una prueba C++ de cabeceras/enlace. Ambos corpus se regeneraron exactamente. El endian numérico no nativo y la conversión histórica a datetime genérico siguen fuera de alcance.

Las API siguen parciales. No hay métodos completos de objetos ufunc, despacho
externo, clases escalares Python, dtypes object ni endian numérico no nativo.
No se certifican todas las políticas de advertencias, ABI ni combinaciones de
operandos. Consulta [descriptores dtype](dtypes.md) y [portabilidad numérica](portability.md).
