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

Desde **0.143.0-dev**, también se aceptan argumentos ndarray numéricos de rango
cero. Su aritmética conserva el dtype de entrada antes de convertir al dtype
de salida; las reglas específicas se describen más abajo.

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

## Argumentos tipados de rango cero

```lua
local bound = lr.array(3, "float32")
bound:setflags(false)
local range = lr.arange(bound)
assert(range.dtype == "float64" and range.size == 3 and range[3] == 2)
assert(not bound.flags.writeable and not lr.shares_memory(range, bound))
```

Los arrays deben tener rango cero; se rechaza un vector de un solo elemento.
Se admiten fuentes de solo lectura y desalineadas: permanecen intactas y el
resultado tiene memoria independiente. La inferencia parte del entero de
índices nativo y promociona las entradas. Float32 produce float64 por defecto;
longdouble conserva su clase más amplia. La aritmética intermedia sigue el
dtype de entrada, incluidos el wrap entero y la precisión half.

```lua
local typed_start = lr.array(256, "int64")
local one = lr.arange(typed_start, 257, 1, {dtype="uint8"})
assert(one.size == 1 and one[1] == 0)
assert(not pcall(function()
  lr.arange(typed_start, 258, 1, {dtype="uint8"})
end))
assert(typed_start:tolist() == 256)
```

El original distingue el array inicial del escalar obtenido al sumar start y
step. La primera conversión a entero comprueba los límites nativos y después
reduce el ancho; el escalar siguiente comprueba los límites del dtype de salida.
Así, el ejemplo de un elemento hace wrap a cero, pero un segundo elemento
produciría un error. La suma se evalúa incluso si basta un elemento; el segundo
valor solo se convierte a la salida cuando se necesita.

La conversión escalar también puede cambiar la precisión: un array int64 inicial
convertido a longdouble pasa por binary64; un array longdouble conserva sus
bits significativos. Esto difiere de convertir explícitamente el array entero
a longdouble antes de usarlo como argumento del rango.

```lua
local narrow_complex = lr.array(lr.complex(3, -3), "complex64")
local wide_complex = lr.array(lr.complex(3, -3), "complex128")
assert(lr.arange(0, narrow_complex, 1).size == 3)
assert(lr.arange(0, wide_complex, 1).size == 0)
assert(lr.arange(0, wide_complex, 1, {dtype="float64"}).size == 3)
```

El escalar obtenido de aritmética complex128 participa en la regla de longitud
compleja; complex64 y complex256 convierten la parte real para obtenerla. Una
salida no compleja también usa esa conversión para resultados tipados. Los arrays
complex64/complex128 iniciales rechazan la conversión escalar real o entera
normal; longdouble utiliza una ruta distinta. Estas reglas reproducen el código
de referencia y no definen un intervalo complejo general. No se reproducen ni
certifican las políticas de advertencias flotantes.

## Compatibilidad y verificación

La interfaz numérica tiene compatibilidad parcial con NumPy 2.5.3.
Los rangos de fechas y duraciones se describen en [rangos temporales](./temporal_ranges.md).
Todavía no admite protocolos Python de tipos externos, `like` o dispositivos. Los enteros Python
fuera del rango Lua no son representables; las diferencias y sumas iniciales
internas usan aritmética más amplia y comprobada.

La interfaz nativa `ln_array_arange` recibe tres valores `ln_ufunc_operand`,
incluidos arrays numéricos de rango cero, y
un descriptor de salida opcional. Devuelve un array con memoria propia o un
error; no modifica las entradas prestadas. El relleno se ejecuta en código nativo.

Las referencias comprueban exactamente aceptación, dtype, disposición, flags,
independencia escribible y payload binario. En el host x86 de referencia se
omiten los seis bytes de padding de cada componente longdouble de 16 bytes;
sus diez bytes significativos se comprueban exactamente. No se certifica el
padding. Se excluyen explícitamente reservas excesivas de prueba y enteros
fuera del dominio Lua.
