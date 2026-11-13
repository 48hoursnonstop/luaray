---
docs_examples: true
---
# Componentes real e imaginario

LuaRay 0.111.0-dev proporciona `lr.real(a)`, `lr.imag(a)`, `a.real` y `a.imag`
mediante módulos nativos y Lua independientes. No requiere Python.

```lua
local lr = require('luaray')
local z = lr.array({lr.complex(1,2), lr.complex(3,4)}, 'complex64')
local real, imag = z.real, lr.imag(z) -- vistas float32, stride de 8 bytes
lr.copyto(real, 7, 'unsafe') -- z queda {7+2j,7+4j}
lr.copyto(imag, -3, 'unsafe') -- z queda {7-3j,7-3j}
assert(lr.shares_memory(real, z))
assert(not lr.shares_memory(real, imag)) -- componentes intercalados distintos
assert(lr.may_share_memory(real, imag)) -- intervalos de direcciones solapados
```

Complex64, complex128 y clongdouble producen vistas float32, float64 y
longdouble. Conservan forma y strides; el puntero imaginario avanza un componente
real. Se recalculan las marcas de contigüidad para el dtype menor. Las vistas
retienen el búfer y su estado de solo lectura, incluidas entradas transpuestas,
invertidas, con saltos y broadcast.

Para un ndarray no complejo, real devuelve el mismo userdata Lua. Imaginary
crea ceros independientes con la misma forma y tipo, orden Fortran cuando
corresponde, y solo lectura. Sigue también a NumPy para S/U y tipos temporales:
los ceros son cadenas vacías o ticks temporales cero. `lr.copy(a.imag)` produce
almacenamiento independiente escribible si lo necesitas.

Los escalares y tablas rectangulares usan el constructor existente. Los
resultados escalares siguen la convención de ndarray tipado de rango cero.
La sustitución directa `a.real = values` sigue sin implementarse; escribe sobre
la vista mediante índices o `copyto`. No se declara compatibilidad completa de
setters, subclases, dispositivos ni protocolos externos.

La referencia original NumPy 2.5.3 ejecuta **3 300 casos / 273 192 comprobaciones
exactas** en quince tipos, escalares/vacíos, varias disposiciones, ambas formas
de llamada, identidad, memoria compartida, escritura y cambios reales en el
respaldo. Las pruebas C y 33 comprobaciones Lua verifican offsets, propiedad
después de GC, intercalado y errores. Todas las API siguen parciales. Cinco
hashes fijan las fuentes en [pinned source hashes](https://github.com/48hoursnonstop/luaray/blob/main/compatibility/numpy-source.sha256).

```sh
make -j4 full-test
make reference-test
```

Véanse [disposición](layout.md), [creación](creation.md) e
[inventario](api_inventory.md). El inventario excluye propiedades no invocables
y no representa compatibilidad global.

## Métodos de conjugación

`a:conj()` y `a:conjugate()` comparten un binding nativo. Un array numérico real,
incluidos los booleanos, devuelve el mismo userdata. Una entrada compleja
produce valores conjugados independientes. El método tiene una ruta distinta
de la asignación/resolución de tipos del ufunc raíz `lr.conjugate(a)`.

```lua
local values = lr.array({1, 2, 3}, "float64")
assert(rawequal(values:conj(), values))
local truth = lr.array({true, false}, "bool")
assert(rawequal(truth:conjugate(), truth) and truth:conj().dtype == "bool")
```

```lua
local source = lr.array({lr.complex(1, 2), lr.complex(3, -4)}, "complex64")
local conjugated = source:conjugate()
assert(lr.imag(conjugated):tolist()[1] == -2)
assert(lr.imag(source):tolist()[1] == 2)
assert(not lr.shares_memory(source, conjugated))
```

Puedes pasar un array de salida directamente o como `{out=array}`. Se devuelve
ese mismo userdata. Las entradas reales usan asignación same-kind y las
complejas usan el ejecutor existente del ufunc conjugate. Broadcasting, strides
negativos y salidas solapadas siguen esos motores. Se rechazan entradas de
strings y temporales. Fallan opciones desconocidas, argumentos extra y salidas
que no sean arrays; el único control opcional del método es la salida.

```lua
local output = lr.zeros({2}, "complex64")
assert(rawequal(source:conj({out=output}), output))
source:setflags(false)
assert(rawequal(source:conjugate(output), output))
assert(not pcall(function() source:conj(source) end))
```

Una fuente de solo lectura puede producir conjugados independientes escribibles
o usar una salida escribible separada. La identidad de entradas reales conserva
sus flags. Una salida compleja que comparte el array debe ser escribible. Los
resultados complejos de rango cero sin salida siguen la convención unaria de
LuaRay: ndarray propio, escribible y de rango cero. NumPy devuelve un escalar.
Se conservan sus bytes numéricos y dtype; las comprobaciones de representación,
escritura y estado posterior usan expresamente la adaptación Lua, sin declarar
paridad de objetos escalares.

```lua
local point = lr.array(lr.complex(1, 2), "complex64")
local result = point:conj()
assert(result.ndim == 0 and result.flags.owndata and result.flags.writeable)
assert(lr.imag(result):tolist() == -2)
```

La referencia del método aprobó **28 140 casos / 340 632 comprobaciones** frente
a NumPy 2.5.3: salidas explícitas, errores de dtype/casting, broadcasting y F,
solo lectura y solapamiento, NaN, infinitos, ceros con signo y estados base tras
escritura real. Los valores/metadatos son exactos dentro de la adaptación
indicada; longdouble omite padding de la ABI. Se normalizaron **24 resultados
escalares** a la convención Lua de array de rango cero. El corpus se regenera
exactamente y la regresión permanente añade 82 comprobaciones Lua. Ambos
métodos siguen siendo parciales; no se certifican protocolos externos,
subclases, todas las ABI ni todos los controles keyword del ufunc.
