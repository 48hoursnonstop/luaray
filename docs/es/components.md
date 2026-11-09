# Componentes real e imaginario

LuaRay 0.111.0-dev proporciona `np.real(a)`, `np.imag(a)`, `a.real` y `a.imag`
mediante módulos nativos y Lua independientes. No requiere Python.

```lua
local np = require('luaray')
local z = np.array({np.complex(1,2), np.complex(3,4)}, 'complex64')
local real, imag = z.real, np.imag(z) -- vistas float32, stride de 8 bytes
np.copyto(real, 7, 'unsafe') -- z queda {7+2j,7+4j}
np.copyto(imag, -3, 'unsafe') -- z queda {7-3j,7-3j}
assert(np.shares_memory(real, z))
assert(not np.shares_memory(real, imag)) -- componentes intercalados distintos
assert(np.may_share_memory(real, imag)) -- intervalos de direcciones solapados
```

Complex64, complex128 y clongdouble producen vistas float32, float64 y
longdouble. Conservan forma y strides; el puntero imaginario avanza un componente
real. Se recalculan las marcas de contigüidad para el dtype menor. Las vistas
retienen el búfer y su estado de solo lectura, incluidas entradas transpuestas,
invertidas, con saltos y broadcast.

Para un ndarray no complejo, real devuelve el mismo userdata Lua. Imaginary
crea ceros independientes con la misma forma y tipo, orden Fortran cuando
corresponde, y solo lectura. Sigue también a NumPy para S/U y tipos temporales:
los ceros son cadenas vacías o ticks temporales cero. `np.copy(a.imag)` produce
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
hashes fijan las fuentes en [pinned source hashes](../../compatibility/numpy-source.sha256).

```sh
make -j4 full-test
make reference-test
```

Véanse [disposición](layout.md), [creación](creation.md) e
[inventario](api_inventory.md). El inventario excluye propiedades no invocables
y no representa compatibilidad global.
