---
docs_examples: true
---
# Contar categorías

`lr.bincount(labels, weights, minlength)` cuenta valores de categorías enteros
no negativos. Las etiquetas son **datos con origen cero**: el primer elemento
del resultado cuenta la etiqueta cero; el segundo, la uno. Los valores repetidos
se acumulan en su categoría y las categorías ausentes quedan en cero. La salida
es unidimensional, escribible y dueña de memoria independiente.

```lua
local lr = require("luaray")
local counts = lr.bincount({0, 1, 1, 3, 2, 1, 7})
assert(counts[1] == 1 and counts[2] == 3)
assert(counts[5] == 0 and counts[8] == 1)
assert(counts.dtype == "int64") -- intp nativo en este host de 64 bits
```

## Sumas ponderadas

Indica un array unidimensional de pesos o una secuencia Lua con la misma
longitud que las etiquetas. Cada peso se añade a su categoría, siguiendo el
orden lógico de entrada. Las salidas ponderadas no vacías usan `float64`.
Una tabla de opciones admite `weights` y `minlength`; rechaza otras claves.
Una segunda tabla vacía es una secuencia de pesos vacía: omite el argumento
para obtener un conteo sin pesos.

```lua
local sums = lr.bincount({0, 0, 1}, {
  weights = {2, 3, 4}, minlength = 3
})
assert(sums.dtype == "float64")
assert(sums[1] == 5 and sums[2] == 4 and sums[3] == 0)
```

Los pesos tipados deben convertirse con seguridad a `float64`. Se rechazan
arrays de pesos complejos, longdouble, cadenas y temporales. Las secuencias
numéricas Lua usan el dtype inferido. La suma secuencial conserva los efectos
del orden en punto flotante; no se ordenan las etiquetas ni se reemplaza la
acumulación por una reducción.

```lua
local sums = lr.bincount({0, 0, 0}, {1e16, -1e16, 1})
assert(sums[1] == 1)
local reversed = lr.array({1e16, -1e16, 1}):get(lr.s(nil, nil, -1))
assert(lr.bincount({0, 0, 0}, reversed)[1] == 0)
```

## Longitud mínima

`minlength` es un entero Lua no negativo. La longitud real es el máximo entre
ese mínimo y la etiqueta mayor más uno. Los pesos posicionales pueden ser `nil`
para indicar solamente el mínimo. Un mínimo omitido o `nil` significa cero
en Lua.

```lua
local counts = lr.bincount({0, 1}, nil, 4)
assert(counts.size == 4 and counts[3] == 0 and counts[4] == 0)
assert(not pcall(lr.bincount, {0}, nil, -1))
assert(not pcall(lr.bincount, {0}, nil, true))
```

## Disposición y memoria

Las entradas de solo lectura, invertidas, con pasos, broadcast o sin alinear
se recorren en orden lógico. La salida no comparte bytes con las entradas.
Las etiquetas enteras y Boolean se convierten al entero con signo del ancho
de puntero; los valores unsigned anchos pueden desbordarse en esa conversión
y fallar después la comprobación de no negativos. La verdad booleana es la
etiqueta cero o uno, incluidos bytes Boolean no canónicos.

```lua
local labels = lr.array({0, 1, 1, 3}, "int32")
local reversed = labels:get(lr.s(nil, nil, -1))
reversed:setflags(false)
local counts = lr.bincount(reversed)
assert(counts[2] == 2 and not lr.shares_memory(counts, labels))
counts[1] = 99
assert(labels[1] == 0 and not reversed.flags.writeable)
```

## Entradas vacías y etiquetas inválidas

Se admite una secuencia ordinaria vacía. Un array tipado debe seguir siendo
unidimensional y de dtype entero o Boolean. Las etiquetas vacías devuelven
ceros enteros nativos e ignoran los pesos por completo, incluidos su forma,
dtype o posibilidad de conversión. Las etiquetas flotantes, complejas, cadenas
y temporales se rechazan incluso vacías. También fallan los valores negativos,
los rangos inválidos y las longitudes incompatibles de pesos no vacíos.

```lua
local empty = lr.bincount({}, function() error("unused weights") end, 3)
assert(empty.dtype == "int64" and empty.size == 3 and empty[1] == 0)
assert(not pcall(lr.bincount, lr.empty({0}, "float64")))
assert(not pcall(lr.bincount, {-1}))
assert(not pcall(lr.bincount, {0, 1}, {2}))
```

Bincount aprobó **6 937 casos /50 126 comprobaciones**, 93 comprobaciones Lua permanentes, una prueba nativa y cabeceras/enlace C++. Se comprueban bytes, dtype, forma, strides, flags, memoria independiente, entradas intactas, conversiones, valores extremos, acumulación secuencial, entradas vacías y layouts sin alinear/de solo lectura. Se excluyeron 48 casos de reserva enorme/desbordamiento del origen; no cuentan como aprobados. El corpus se regeneró exactamente. Los seis bytes de padding longdouble se normalizan al serializar, incluidos los buffers sin alinear; se conservan sus diez bytes significativos.

La API sigue parcial. No se admiten protocolos externos de arrays/índices,
`minlength` escalar tipado, clases escalares Python, cadenas numéricas en pesos
ordinarios ni fidelidad de advertencias/clases de excepción. La etiqueta intp
máxima se rechaza antes de sumar el tamaño, evitando el desbordamiento con
signo del origen. No se certifican reservas enormes, todos los ABI ni cada
combinación posible.
