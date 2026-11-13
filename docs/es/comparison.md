---
docs_examples: true
---
# Igualdad y tolerancias numéricas

Usa `array_equal` para formas idénticas e igualdad exacta, `array_equiv` para
permitir broadcasting e `isclose`/`allclose` para tolerancias numéricas. Estas
funciones no modifican las entradas.

## Igualdad exacta y forma

```lua
local lr = require("luaray")
assert(lr.array_equal({1, 2}, lr.array({1, 2}, "float32")))
assert(not lr.array_equal({1, 2}, {{1, 2}}))
assert(lr.array_equiv({{1, 2}, {1, 2}}, {1, 2}))
assert(not lr.array_equiv({1, 2}, {1, 2, 3}))
```

`array_equal(a, b, {equal_nan=false})` exige formas idénticas, pero los dtypes
pueden diferir. `array_equiv(a, b)` comprueba primero el broadcasting y después
todos los elementos. Ambos devuelven un booleano Lua. Si falla la conversión de
la entrada ordinaria, devuelven false; esto no oculta errores posteriores de
aritmética o metadatos.

Los arrays numéricos y de texto son distintos en lugar de fallar solo por falta
de una firma de comparación. Bytes y Unicode también son distintos. Otros errores,
como unidades temporales de calendario/fijas incompatibles, siguen propagándose.
Las formas vacías coincidentes son iguales cuando su ruta de comparación admite
los dtypes correspondientes.

## NaN e identidad

```lua
local missing = lr.array({0/0}, "float64")
assert(not lr.array_equal(missing, missing))
assert(lr.array_equal(missing, missing, {equal_nan=true}))
local real_missing = lr.array({lr.complex(0/0, 1)}, "complex128")
local imag_missing = lr.array({lr.complex(1, 0/0)}, "complex128")
assert(lr.array_equal(real_missing, imag_missing, {equal_nan=true}))
```

Con `equal_nan=true`, los NaN correspondientes son iguales. En valores complejos,
un NaN en cualquiera de sus componentes marca el valor completo como ausente.
NaT sigue la semántica temporal de `isnan`. Sin esta opción, NaN/NaT siguen siendo
distintos incluso al compararlos consigo mismos.

La referencia tiene un atajo de identidad con `equal_nan=true`: un ndarray nativo
comparado consigo mismo es igual antes de detectar NaN. Por eso un array de strings
separado puede fallar por `isnan` no implementado mientras el objeto idéntico
devuelve true. Se conservan estas rutas de la referencia.

## Tolerancias y broadcasting

```lua
local close = lr.isclose({1, 2, 3}, {1.000001, 2, 4})
assert(close.dtype == "bool" and close[1] and close[2] and not close[3])
assert(lr.allclose({1, 2}, {1.000001, 2}))
local bounds = lr.isclose({1, 1.01}, {1, 1}, {rtol=0, atol={0, 0.02}})
assert(bounds[1] and bounds[2])
```

`isclose(a, b, {rtol=1e-5, atol=1e-8, equal_nan=false})` devuelve un ndarray
booleano. `allclose` usa las mismas opciones y devuelve un booleano Lua. Los valores
finitos cumplen `abs(a-b) <= atol + rtol*abs(b)`. La expresión toma `b` como
referencia, por lo que no es simétrica. Las tolerancias relativas y absolutas
pueden ser arrays con broadcasting. Los infinitos iguales son cercanos; los de
signos opuestos no. `equal_nan` requiere un booleano Lua. Las formas incompatibles
producen error en estas funciones de tolerancia.

Los resultados de `isclose` son arrays escribibles independientes, incluidos arrays
de rango cero para entradas escalares. Los arrays tipados conservan sus reglas
de promoción; los escalares Lua ordinarios permanecen débiles donde la referencia
usa escalares Python. Las entradas derechas enteras pasan a aritmética flotante,
evitando problemas de valor absoluto con el mínimo entero. La precisión extendida
se conserva dentro de los arrays nativos durante el cálculo.

## Comparaciones temporales

```lua
local elapsed = lr.array({0, 1, 2}, "timedelta64[h]")
assert(lr.allclose(elapsed, elapsed, {rtol=0, atol=0}))
local missing = lr.array({1, math.mininteger}, "timedelta64[h]")
assert(lr.isnan(missing)[2] and not lr.any(lr.isinf(missing)))
```

Las duraciones conservan su unidad. Una tolerancia absoluta entera o de duración
compatible puede funcionar; la tolerancia absoluta flotante predeterminada no
siempre permite sumar duraciones. `isnan` reconoce NaT, `isinf` es false para
valores temporales e `isfinite` excluye NaT. Las comparaciones de duración admiten
booleanos, enteros con signo y enteros pequeños sin signo como ticks; uint64 no
tiene firma de comparación. La [aritmética temporal](temporal_scaling.md) explica
los desplazamientos enteros y las escrituras tras errores.

## Compatibilidad

Disponible desde **0.134.0-dev**, basada en `numeric.py` de NumPy 2.5.3 y la
comparación de ndarrays. Lua usa tablas de opciones y booleanos para `equal_nan`.
No se implementan los objetos de avisos/estado de error flotante ni la identidad
de excepciones Python; se ejecuta la aritmética predeterminada con tolerancias no
finitas. Siguen pendientes object, estructuras y todos los protocolos externos,
de subclases y escalares Python. Las API son parcialmente compatibles. Las
referencias comprueban resultados booleanos exactos, dtype, forma, strides,
estados de entrada y escrituras reales. Los casos de precisión extendida conservan
sus bits de valor mediante vistas de bytes nativas.
