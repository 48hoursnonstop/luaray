---
docs_examples: true
---
# Construir arrays y vistas de buffers

`lr.ndarray(shape, dtype, options)` crea un array con memoria propia, o una
vista si se proporciona `options.buffer`. Para crear datos normalmente, usa
[`zeros`, `empty` o `array`](./creation.md). Este constructor permite especificar
offsets y strides en bytes sin copiar ni convertir la memoria existente.

## Reservar memoria por forma

```lua
local lr = require("luaray")
local values = lr.ndarray({2, 3}, "int32", {order="F"})
values:fill(7)
assert(values.strides[1] == 4 and values.strides[2] == 8)
assert(values.flags.owndata and values.flags.f_contiguous)
assert(lr.sum(values) == 42)
```

La forma es un entero o una tabla densa de enteros Lua; `{}` indica rango cero.
El rango máximo es 64. El dtype predeterminado es float64 y acepta un nombre o
un [descriptor dtype](./dtypes.md). Las opciones pueden ocupar el segundo
argumento: `lr.ndarray({2, 3}, {dtype="int32", order="F"})`.

El orden predeterminado es `C`. `F` dispone los datos por columnas; `A` y `K`
seleccionan C, siguiendo el constructor original. Se aceptan letras minúsculas.
Sin buffer, la memoria es propia y escribible. Los valores numéricos y las
cadenas de bytes no se inicializan: rellénalos antes de leerlos. Unicode sí
se inicializa a cero. El offset se ignora sin buffer, aunque debe ser entero.

## Compartir memoria con strides explícitos

```lua
local backing = lr.array({10, 20, 30, 40}, "int32")
local reverse = lr.ndarray(3, {
  dtype="int32", buffer=backing, offset=8, strides=-4,
})
assert(reverse[1] == 30 and reverse[3] == 10)
reverse[2] = 99
assert(backing[2] == 99 and lr.shares_memory(reverse, backing))
```

Offsets y strides se expresan en **bytes**; los offsets empiezan en cero. Los
índices de arrays siguen empezando en uno. Se aceptan strides positivos,
negativos o cero, con el mismo rango que la forma. Un stride escalar sirve para
rango uno. Los strides explícitos determinan la disposición independientemente
de order. Un stride cero repite una dirección: escribir cambia todos los
elementos lógicos que comparten esa dirección.

```lua
local repeated = lr.ndarray(3, {
  dtype="int32", buffer=backing, offset=4, strides=0,
})
repeated:fill(12)
assert(repeated[3] == 12 and backing[2] == 12)
```

El buffer puede ser un array contiguo C o F; se rechazan otras vistas. En cambio,
[`frombuffer`](./buffers.md) requiere buffers de arrays contiguos C. La ventana
disponible es nbytes del array suministrado, no toda la reserva subyacente. La
vista retiene al propietario de la memoria y hereda el permiso de escritura
del array suministrado. No convierte sus valores.

## Leer cadenas binarias

```lua
local binary = string.pack("i4i4", 123, -456)
local parsed = lr.ndarray({2}, "int32", {buffer=binary})
assert(parsed[1] == 123 and parsed[2] == -456)
assert(not parsed.flags.writeable and not parsed.flags.owndata)
assert(not pcall(function() parsed[1] = 0 end))
local inferred = lr.ndarray(-1, "int32", {buffer=binary .. "xx"})
assert(inferred.size == 2)
```

Las cadenas producen memoria de solo lectura, incluso para arrays vacíos. El
motor retiene la cadena hasta que se recoge su última vista, aunque ya se haya
recogido la corrutina creadora. Los arrays adquiridos mediante Lua no deben
sobrevivir a su estado Lua. Copia explícitamente para obtener memoria propia.

Solo se infiere una forma de rango uno con valor `-1`, y solo con buffer. El
conteo descarta bytes finales incompletos; `frombuffer` exige un múltiplo exacto
cuando infiere el conteo. Otras dimensiones negativas son errores. Con strides
explícitos se conserva la comprobación previa de NumPy y se añade otra sobre
el rango real después de inferir. Es preferible dar una forma explícita para
vistas con strides personalizados.

## Arrays vacíos y cadenas de ancho cero

```lua
local empty = lr.ndarray({2, 0}, {strides={400, -20}})
assert(empty.nbytes == 0 and empty.strides[1] == 0 and empty.strides[2] == 0)
local strings = lr.ndarray({2, 3}, "U0")
assert(strings.itemsize == 0 and strings.nbytes == 0)
assert(strings:tolist()[2][3] == "")
assert(lr.empty({2}, "U0").itemsize == 4)
```

Las reservas propias de cero bytes ponen todos los strides a cero, aunque se
indicaran explícitamente. Los arrays vacíos con buffer conservan sus strides.
Aquí `S0` y `U0` mantienen ancho cero; `empty` normaliza sus anchos. Los dtypes
de ancho cero no pueden inferir `-1`. Los flags de contigüidad conservan la
distinción original entre strides predeterminados y explícitos de ancho cero;
recalcular los flags puede cambiarlos.

## Seguridad y compatibilidad

Disponible desde **0.141.0-dev**, con compatibilidad parcial con NumPy 2.5.3.
Los límites y productos se comprueban antes de formar punteros o reservar
memoria. Se rechazan offsets negativos/excesivos, memoria real insuficiente,
vistas inferidas fuera del buffer y conteos excesivos. Esto rechaza
deliberadamente combinaciones inseguras que el constructor original admite.
Un buffer externo vacío no puede proporcionar datos de tamaño positivo.

Las únicas opciones son `dtype`, `buffer`, `offset`, `strides` y `order`. Se
rechazan claves desconocidas, formas dispersas, entradas no enteras y dtype
duplicado. No hay protocolos Python de buffers, subclases ni arrays externos,
ni dtypes estructurados, object o de ancho variable. Siguen vigentes los límites
de dtype y vistas binarias; los buffers no validan el contenido Unicode.

La interfaz nativa es `ln_array_construct`: un array contiguo retenido opcional
proporciona la ventana de memoria. El constructor no consume ese array; el
resultado retiene al propietario. Los punteros externos pueden envolverse con
`ln_array_from_buffer`: su callback se ejecuta al desaparecer la última vista.
