---
docs_examples: true
---
# Exigir una disposición de memoria utilizable

`lr.require(input, dtype, requirements)` devuelve un ndarray que cumple las
condiciones de memoria solicitadas. Conserva una entrada adecuada y copia cuando
lo exige una condición o conversión de dtype. Permite preparar arrays para código
nativo con contratos de memoria más estrictos.

## Seleccionar requisitos

```lua
local lr = require("luaray")
local source = lr.arange(6):reshape({2, 3})
assert(rawequal(lr.require(source), source))
assert(rawequal(lr.require(source, nil, "C"), source))
local prepared = lr.require(source, "float32", {"F", "O", "W", "A"})
assert(prepared.dtype == "float32" and prepared.flags.fnc)
assert(prepared.flags.owndata and prepared.flags.writeable and prepared.flags.aligned)
assert(lr.array_equal(prepared, source) and not lr.shares_memory(prepared, source))
```

| Abreviatura | Nombres largos | Condición |
| --- | --- | --- |
| C | C_CONTIGUOUS, CONTIGUOUS | Contiguo en C |
| F | F_CONTIGUOUS, FORTRAN | Contiguo en Fortran |
| A | ALIGNED | Memoria alineada para su dtype |
| W | WRITEABLE | Array escribible |
| O | OWNDATA | Posee su asignación de memoria |
| E | ENSUREARRAY | Clase base; LuaRay tiene una única clase nativa de array |

No se distingue entre mayúsculas y minúsculas. Una tabla debe ser una secuencia
densa de strings. Los duplicados son inocuos. Un string se interpreta carácter
a carácter: `"COW"` solicita C, O y W; los nombres largos van en una secuencia.
C y F juntos fallan aunque la entrada esté vacía o ya cumpla ambos. Los nombres
desconocidos, elementos que no sean strings y claves inválidas fallan.

## Copiar entradas inmutables o no alineadas

```lua
local packed = string.pack("i4i4", 1, 2)
local readonly = lr.frombuffer(packed, "int32")
assert(rawequal(lr.require(readonly, nil, "C"), readonly))
local writable = lr.require(readonly, nil, "W")
writable[1] = 7
assert(readonly[1] == 1 and writable.flags.writeable)
local unaligned = lr.frombuffer("x" .. packed, "int32", 2, 1)
local aligned = lr.require(unaligned, nil, {"ALIGNED", "OWNDATA"})
assert(aligned.flags.aligned and aligned.flags.owndata)
assert(lr.array_equal(aligned, unaligned))
```

Una copia satisface requisitos A, O o W incumplidos sin modificar los flags de
la entrada. Pedir C/F también puede exigir copiar. Una fuente de solo lectura
puede devolverse intacta si no se solicitó escritura. Poseer la memoria y no
solaparse son conceptos distintos; usa las consultas de memoria si importa
compartir almacenamiento.

## Orden de conversión e identidad

```lua
local expanded = lr.broadcast_to(lr.arange(3), {2, 3})
local converted = lr.require(expanded, "float64", "A")
assert(converted.strides[1] == 8 and converted.strides[2] == 16)
assert(expanded:copy("A").flags.c_contiguous)
```

Sin requisitos—nil, false, string vacío o secuencia vacía—se usa `asanyarray`, con
su KEEPORDER predeterminado. Los requisitos no vacíos usan la conversión de
arrays con C, F o, en otro caso, ANYORDER. Cambiar dtype mediante ANYORDER puede
conservar el orden físico de ejes, incluso con strides de broadcasting. Una
copia posterior del mismo dtype mediante `copy("A")` sigue otro contrato. El
motor compartido de creación conserva esa distinción; no se falsean strides.

Los escalares conservan rango cero; exigir C o F no impone una dimensión mínima.
Un ndarray adecuado conserva su identidad userdata Lua. Las entradas Lua normales
se convierten con la API de creación existente. Dtype nil conserva el de entrada.

## Compatibilidad

El porte de NumPy 2.5.3 `_core/_asarray.py:require` es parcial. No se admiten
`like`, dispatch de subclases, iterables/diccionarios arbitrarios de requisitos,
clases dtype ni protocolos externos Python. E se cumple con la única clase de
array nativo Lua. Los strings dtype y las fuentes admitidas conservan las
restricciones del motor: endian numérico no nativo, objetos, estructuras y
StringDType de ancho variable siguen pendientes.

Las referencias comparan aceptación, valores, dtype, forma, strides, identidad,
flags, memoria compartida y estados de entrada/base después de escrituras reales.
Incluyen fuentes bloqueadas, alineación desactivada manualmente, direcciones no
alineadas y buffers inmutables. No se certifican todos los protocolos/dtypes ni
la fidelidad completa de errores y avisos Python.
