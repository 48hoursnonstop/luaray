# Vistas tipadas de memoria y bytes

LuaRay0.115.0-dev añade `a:view(dtype)`, `a:tobytes(order)`, `a.itemsize` y
`a.nbytes`. Operan sobre memoria real sin Python.

```lua
local lr = require('luaray')
local a = lr.array({1.0}, 'float32')
local bits = a:view('uint32')
assert(bits:tolist()[1] == 1065353216)
assert(lr.shares_memory(a, bits))
assert(a:tobytes() == string.pack('f', 1.0))
bits:set(0, 1)
assert(a:tolist()[1] == 0.0)
```

`view` reinterpreta bytes; `astype` convierte valores. Sin dtype o con nil,
crea otra cabecera con el mismo tipo. La memoria sigue viva aunque se recolecte
el userdata original, y una vista de solo lectura conserva esa protección.
Reinterpretar unidades temporales cambia su significado sin escalar los ticks.

Si los tamaños de elemento coinciden, mantiene forma y strides incluso con
vistas invertidas, no contiguas o broadcast. Cambiar itemsize solo ajusta el
último eje: debe ser contiguo, salvo longitud uno o array vacío. El tamaño menor
debe dividir al original; el mayor debe dividir los bytes del último eje.
Un escalar solo permite tamaños iguales. Se comprueban desbordamientos.

Las nuevas vistas pueden quedar desalineadas. Se recalcula ese atributo y se
usan cargas/escrituras escalares mediante memcpy, búferes alineados en los
iteradores y valores de trabajo alineados en reducciones y acumulaciones.
Las pruebas ejecutan operaciones reales sobre desplazamientos de uno y tres bytes.

`tobytes` devuelve un string binario Lua que incluye NUL y padding; no incluye
huecos entre elementos de una vista. Acepta orden o `{order='F'}`, sin distinguir
mayúsculas. C recorre primero el último eje; F el primero; A elige F únicamente
si la entrada es exclusivamente Fortran. K conserva la peculiaridad de
NumPy2.5.3: C para números/bytes/tiempos, KEEPORDER para Unicode. Por eso K y C
pueden diferir en un array Unicode Fortran. Nil/predeterminado usa C.

Los oráculos comparan bytes inicializados de forma determinista, metadatos,
memoria compartida y escrituras reales. Otro conjunto compara aritmética y
reducciones desalineadas. Los bytes congelados corresponden al ABI x86-64
little-endian; no se certifican todos los ABI ni algoritmos consumidores.
El padding de longdouble puede diferir entre valores construidos por separado.

La interfaz acepta nombres de dtype o [descriptores nativos](dtypes.md), sin subclases Python. Objetos, tipos
estructurados/subarray/void, StringDType variable y endian numérico no nativo
siguen pendientes. Se conserva el endian de Unicode fijo. No se añade pickle ni
serialización de archivos. La [referencia inglesa](../byte_views.md) detalla
el alcance; todas las APIs continúan clasificadas como parciales.

[Intercambiar bytes](byteswap.md) explica la modificación del almacenamiento sin cambiar el dtype.

[Campos por elemento](fields.md) cubre vistas y escrituras en una región de bytes de cada elemento.
