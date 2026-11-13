---
docs_examples: true
---
# Rangos numéricos con arange

`lr.arange(start, stop, step, dtype)` crea un array independiente, escribible y
de rango uno. Stop se excluye. Un único argumento numérico implica `start=0`;
el paso predeterminado es uno. Esta interfaz está disponible desde
**0.142.0-dev**. Se conserva la forma anterior `lr.arange(stop, dtype)`.

## Elegir dirección y paso

```lua
local lr = require("luaray")
local increasing = lr.arange(2, 9, 2)
assert(increasing.size == 4 and increasing[4] == 8)
local decreasing = lr.arange(5, 0, -2)
assert(decreasing.size == 3 and decreasing[3] == 1)
assert(lr.arange(5, 0).size == 0)
```

Los argumentos pueden ser enteros, números, booleanos o valores `lr.complex`.
Los enteros/booleanos infieren el dtype entero de índices del host, int64 en el
Linux de 64 bits soportado. Un argumento flotante selecciona float64; uno
complejo selecciona complex128. Un paso cero es un error, aunque start y stop
sean iguales. Se rechazan longitudes no finitas o excesivas antes de reservar.
Una longitud negativa produce un array vacío.

## Seleccionar el dtype de salida

```lua
local samples = lr.arange(0, 1, 0.25, lr.dtype("float32"))
assert(samples.dtype == "float32" and samples.size == 4)
assert(samples[4] == 0.75)
local other = lr.arange(0, 1, 0.25, {dtype="float32"})
assert(lr.array_equal(samples, other))
assert(lr.arange(3, "int32").dtype == "int32")
```

Se acepta un nombre dtype, descriptor o tabla `{dtype=...}` después de uno, dos
o tres argumentos numéricos. Un stop nil equivale a omitirlo; un step nil
selecciona uno. Un nil final explícito deja inferir el dtype. Se rechazan claves
desconocidas y argumentos excesivos.

La llamada histórica de dos argumentos con stop entero y dtype posicional
conserva la conversión individual de índices. Esto incluye rangos booleanos de
más de dos elementos. Usa una tabla de opciones para las reglas del constructor
NumPy con un stop entero:

```lua
local legacy = lr.arange(4, "bool")
assert(legacy.size == 4 and legacy[1] == false and legacy[4] == true)
assert(not pcall(function() lr.arange(4, {dtype="bool"}) end))
```

Tanto los nombres dtype como sus descriptores seleccionan esa forma heredada.
Sus valores numéricos equivalen a convertir índices enteros consecutivos; los
descriptores temporales representan ticks consecutivos. Como antes, se rechazan
cadenas no vacías, mientras un resultado vacío conserva el ancho del descriptor.
Los stops fraccionarios, las llamadas start/stop y las tablas de opciones usan
las nuevas reglas escalares.

Se soportan los dtypes numéricos escalares nativos existentes, incluidos half,
longdouble y complex256. El nuevo constructor admite un máximo de dos elementos
booleanos y rechaza dtypes string/Unicode incluso para rangos vacíos. Se mantienen
los límites existentes sobre dtypes con endianness no nativo.

## Entender el incremento efectivo

```lua
local truncated = lr.arange(0, 3, 0.5, "int32")
assert(truncated.size == 6 and truncated[6] == 0)
local rounded = lr.arange(100000000, 100000005, 1, "float32")
assert(rounded.size == 5 and rounded[5] == 100000000)
local wrapped = lr.arange(120, 140, 3, "int8")
assert(wrapped[3] == 126 and wrapped[4] == -127)
```

Como en NumPy, la longitud utiliza los argumentos originales, pero el bucle
usa `dtype(start + step) - dtype(start)`. Los dos primeros valores se convierten
con los límites propios de escalares; los enteros siguientes hacen wrap al ancho
de salida. El bucle flotante usa la precisión de salida; half calcula en float.
No suma repetidamente el paso original. Un incremento pequeño puede desaparecer
al convertirlo, y el redondeo puede afectar a la longitud y al extremo final.
Usa [`linspace`](./sampling.md) si necesitas fijar el número de muestras.

## Argumentos complejos

```lua
local diagonal_bound = lr.arange(0, lr.complex(3, 3), 1)
assert(diagonal_bound.dtype == "complex128" and diagonal_bound.size == 3)
assert(diagonal_bound[3].real == 2 and diagonal_bound[3].imag == 0)
local empty = lr.arange(0, lr.complex(3, 3), lr.complex(1, 1))
assert(empty.size == 0)
```

Los argumentos complejos requieren un dtype complejo de salida. La regla
original toma el menor techo de las partes real e imaginaria de
`(stop-start)/step`. Con argumentos exclusivamente reales se usa la regla
normal, incluso con salida compleja. Esto puede producir rangos vacíos poco
intuitivos. Los cálculos escalares complejos usan componentes binary64. Los
pasos complejos infinitos conservan la recuperación de ceros con signo del
original; las longitudes NaN inválidas producen errores.

## Compatibilidad y verificación

La interfaz numérica escalar tiene compatibilidad parcial con NumPy 2.5.3.
Todavía no admite argumentos ndarray tipados, rangos datetime/timedelta ni
protocolos Python de tipos externos, `like` o dispositivos. Los enteros Python
fuera del rango Lua no son representables; las diferencias y sumas iniciales
internas usan aritmética más amplia y comprobada.

La interfaz nativa `ln_array_arange` recibe tres escalares `ln_ufunc_operand` y
un descriptor de salida opcional. Devuelve un array con memoria propia o un
error; no modifica las entradas prestadas. El relleno se ejecuta en código nativo.

Las referencias comprueban exactamente aceptación, dtype, disposición, flags,
independencia escribible y payload binario. En el host x86 de referencia se
omiten los seis bytes de padding de cada componente longdouble de 16 bytes;
sus diez bytes significativos se comprueban exactamente. No se certifica el
padding. Se excluyen explícitamente reservas excesivas de prueba y enteros
fuera del dominio Lua.
