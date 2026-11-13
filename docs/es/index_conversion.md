---
docs_examples: true
---
# Índices planos y posiciones de coordenadas

`lr.ravel_multi_index(coordinates, shape, options)` convierte coordenadas en
posiciones planas. `lr.unravel_index(indices, shape, options)` realiza la
conversión inversa. Las posiciones empiezan en **uno**, incluido el resultado
plano. La forma puede ser un entero Lua no negativo para un eje o una tabla
densa de dimensiones enteras. No se reserva el array de destino.

```lua
local lr = require("luaray")
local flat = lr.ravel_multi_index({4, 5}, {7, 6})
assert(flat == 23)
local point = lr.unravel_index(flat, {7, 6})
assert(point[1] == 4 and point[2] == 5)
```

## Operandos y broadcasting

Indica un operando por eje de destino. Cada operando puede ser un escalar, una
secuencia Lua o un ndarray entero. Se combinan mediante broadcasting; la salida
plana tiene esa forma. También se admite un ndarray cuyo primer eje contiene
los operandos de coordenadas. Los resultados planos escalares son enteros Lua.

`lr.indices` produce datos numéricos desde cero. Suma uno antes de usarlos como
posiciones Lua.

```lua
local coordinates = lr.indices({2, 3}) + 1
local positions = lr.ravel_multi_index(coordinates, {2, 3})
assert(positions:get(1, 1) == 1 and positions:get(2, 3) == 6)
local broadcast = lr.ravel_multi_index({
  lr.array({{1}, {2}}, "int32"), lr.array({1, 2, 3}, "int32")
}, {2, 3})
assert(broadcast:get(2, 2) == 5)
```

## Orden lógico C y F

El orden predeterminado es C: el último eje de destino cambia más rápido. En F
cambia más rápido el primero. Esto selecciona el cálculo lógico de posiciones;
los strides físicos del resultado siguen el orden KEEPORDER del iterador. Solo
se admiten C/F, también en minúsculas.

```lua
assert(lr.ravel_multi_index({2, 1}, {2, 3}) == 4)
assert(lr.ravel_multi_index({2, 1}, {2, 3}, {order = "F"}) == 2)
local point = lr.unravel_index(4, {2, 3}, {order = "F"})
assert(point[1] == 2 and point[2] == 2)
```

## Modos de límites

Ravel admite `mode = "raise"` por defecto, `"wrap"` o `"clip"`, para todos los
ejes o como tabla con un modo por eje. Sus códigos numéricos son 2, 1 y 0.
Las posiciones positivas se convierten restando uno; las negativas conservan
su signo. Raise exige coordenadas convertidas no negativas dentro del rango.
Wrap usa módulo; clip limita los valores negativos convertidos al primer
elemento. **Cero es inválido cuando se recorre**, también en wrap/clip.

```lua
assert(lr.ravel_multi_index({-1, 99}, {2, 3}, {
  mode = {"wrap", "clip"}
}) == 6)
assert(lr.ravel_multi_index({-1, -1}, {2, 3}, {mode = "clip"}) == 1)
assert(not pcall(lr.ravel_multi_index, {0, 1}, {2, 3}, {mode = "wrap"}))
```

Unravel exige posiciones planas válidas y no tiene modo de límites. Los índices
tipados admitidos se convierten con same-kind al entero con signo de ancho de
puntero; un unsigned de ancho completo puede hacer wrap antes de comprobar el
rango. Se rechazan arrays de índices flotantes, complejos, cadenas y temporales.

## Vistas y propiedad de la memoria

Unravel devuelve una tabla con un resultado por eje. Los índices escalares
producen coordenadas enteras Lua. Los arrays producen vistas ndarray escribibles
de un buffer nuevo de coordenadas intercaladas, con la misma forma lógica que
los índices. Esas vistas no son propietarias ni comparten datos de entrada.
Los campos pueden tener límites de direcciones solapados sin compartir bytes.

```lua
local input = lr.array({1, 6}, "int64")
local coordinates = lr.unravel_index(input, {2, 3})
assert(coordinates[1].strides[1] == 16)
assert(not coordinates[1].flags.owndata)
assert(not lr.shares_memory(coordinates[1], coordinates[2]))
assert(lr.may_share_memory(coordinates[1], coordinates[2]))
coordinates[1]:fill(2)
assert(coordinates[2][2] == 3 and input[2] == 6)
```

Conservar una sola vista mantiene vivo su buffer. Las salidas son escribibles
aunque la entrada sea de solo lectura. Las vistas vacías conservan sus strides
intercalados compatibles.

## Destinos vacíos y escalares

Una forma con dimensión cero no contiene posiciones, pero los índices vacíos
tipados pueden producir salidas vacías. Una forma vacía representa un escalar:
su única posición plana es uno y no tiene ejes de coordenadas. Unravel solo
acepta un índice escalar para ese destino; rechaza un array de índices, incluso
vacío. Una secuencia Lua vacía ordinaria no infiere dtype entero de índices.

```lua
local empty = lr.unravel_index(lr.array({}, "int64"), {0, 3})
assert(#empty == 2 and empty[1].size == 0)
assert(empty[2].strides[1] == 16)
assert(lr.ravel_multi_index({}, {}) == 1)
assert(#lr.unravel_index(1, {}) == 0)
assert(not pcall(lr.unravel_index, lr.array({}, "int64"), {}))
```

## Límites enteros y de rango

Los productos de dimensiones y strides compatibles se comprueban contra `intp`.
Se rechazan dimensiones negativas incluso después de una dimensión cero. Ravel
admite hasta 63 ejes de destino; unravel, hasta 64 ejes de destino y arrays de
índices de rango 63. Los operandos de coordenadas y las salidas planas pueden
tener rango 64.

```lua
local shape = {math.maxinteger}
assert(lr.ravel_multi_index({math.maxinteger}, shape) == math.maxinteger)
assert(lr.unravel_index(math.maxinteger, shape)[1] == math.maxinteger)
assert(not pcall(lr.ravel_multi_index, {1, 1}, {math.maxinteger, 2}))
assert(not pcall(lr.unravel_index, 1, {math.maxinteger, 2}))
```

Se usa la convención de índices Lua tras la conversión entera. Boolean true es
la posición uno; false se convierte al cero inválido. Usa coordenadas enteras
explícitas al traducir datos Boolean numéricos de NumPy. Se rechazan opciones
desconocidas y nombres de modo con NUL incrustado.

```lua
assert(lr.ravel_multi_index({true}, 3) == 1)
assert(not pcall(lr.unravel_index, false, 3))
assert(not pcall(lr.unravel_index, 1.0, 3))
assert(not pcall(lr.ravel_multi_index, {1}, 3, {dtype = "int64"}))
```

Las conversiones de índices aprobaron **40 822 casos /391 028 comprobaciones**: 32 128 ravel y 8 694 unravel, con 168 comprobaciones Lua permanentes, una prueba nativa y cabeceras/enlace C++. Se verifican posiciones, dtype, forma, strides, flags, C/F y KEEPORDER, modos de límites, broadcasting, vistas compartidas, escrituras e independencia de la entrada. El corpus se regeneró exactamente. Se adaptaron 105 704 valores de entrada a posiciones Lua, se ampliaron 11 312 arrays estrechos/Boolean y se normalizaron 4 932 retornos escalares. Se excluyeron otros 1 472 casos (3 136 operandos) que no permiten representar la posición intp máxima al sumar uno, además de entradas inseguras del origen; no cuentan como aprobados.

Las API siguen parciales. Tablas y formas enteras Lua sustituyen los protocolos
Python de formas y secuencias. No hay clases escalares NumPy, despacho externo
ni endian numérico no nativo. No se certifican todas las ABI, disposiciones
externas malformadas, límites de recursos ni combinaciones de entradas.
