---
docs_examples: true
---
# Arrays desde un iterador

`lr.fromiter(iterador, dtype, count)` crea un array propio de una dimensión desde
una función iteradora Lua. Cada llamada devuelve un valor. No devolver nada o
devolver `nil` termina el flujo; `false` es un elemento booleano normal. Se
ignoran retornos adicionales. El argumento dtype es obligatorio; `nil` explícito
selecciona float64.

```lua
local lr = require("luaray")
local position = 0
local values = lr.fromiter(function()
  position = position + 1
  if position <= 4 then return position * position end
end, "int64")
assert(values.size == 4 and values[4] == 16)
assert(values.flags.owndata and values.flags.writeable)
```

## Limitar el consumo

El count predeterminado, `-1`, lee hasta el final. Un count no negativo reserva
la longitud solicitada y consume exactamente esa cantidad. Un final anticipado
produce un error Lua. El iterador queda en la posición consumida tras éxito o
error. También se acepta una tabla de opciones con count.

```lua
local position = 0
local function nextvalue()
  position = position + 1
  return position
end
local prefix = lr.fromiter(nextvalue, "int16", {count = 3})
assert(prefix[3] == 3 and position == 3)
assert(nextvalue() == 4)
assert(lr.fromiter(nextvalue, "int16", 0).size == 0 and position == 4)
```

Solo `-1` significa ilimitado. Los counts inferiores a `-1` devuelven un array
vacío sin pedir valores, como el origen fijado. Count debe ser un entero Lua;
se rechazan booleanos y flotantes. Incluso con count cero se validan iterador y
dtype. Las cadenas sin ancho `S0`/`U0` se rechazan antes de consumir valores.

## Conversión y valores tipados

Cada valor se empaqueta directamente en el dtype solicitado. Un entero Lua fuera
del rango entero de destino produce error. Los arrays tipados de rango cero
siguen el cast escalar nativo, incluidos casts enteros con desbordamiento modular.
Los números ordinarios para dtype complejo pasan por componentes double;
los valores tipados de precisión extendida conservan sus bytes significativos.

```lua
assert(not pcall(lr.fromiter, function() return 256 end, "uint8", 1))
local wrapped = lr.fromiter(function()
  return lr.array(256, "int64")
end, "uint8", 1)
assert(wrapped[1] == 0)
local flags = {false, true, false}
local index = 0
local booleans = lr.fromiter(function()
  index = index + 1
  return flags[index]
end, "bool")
assert(booleans.size == 3 and booleans[1] == false)
```

Un array de rango cero conserva uint64 por encima del rango entero Lua,
componentes longdouble, unidades temporales y texto de ancho fijo sin pasar por
un número Lua. Se aceptan escalares de solo lectura o no alineados. No se
aceptan elementos ndarray de mayor rango; las secuencias solo se admiten como
verdad booleana (vacía es falso, no vacía es verdadero).

```lua
local scalar = lr.ndarray({}, {
  dtype = "uint64", buffer = string.rep("\255", 8)
})
local wide = lr.fromiter(function() return scalar end, "uint64", 2)
assert(wide:tobytes() == string.rep("\255", 16))
```

## Objetos invocables y corrutinas

Se acepta una tabla o userdata Lua con un `__call` que sea función. Una closure
puede adaptar iteradores genéricos y flujos externos. También puede usarse un
productor `coroutine.wrap`; el constructor no se suspende a través del callback.

```lua
local producer = coroutine.wrap(function()
  for i = 1, 3 do coroutine.yield(i * 2) end
end)
local values = lr.fromiter(producer, "float64")
assert(values[1] == 2 and values[3] == 6)
```

## Errores y propiedad

Los errores del iterador propagan el valor Lua original. La memoria del array
permanece protegida durante callbacks, recolección de basura y crecimiento.
Un constructor fallido no devuelve el array parcial; los efectos ya producidos
en el iterador se conservan. Las opciones desconocidas producen error.

```lua
local marker = {}
local ok, value = pcall(lr.fromiter, function() error(marker) end, "float64")
assert(not ok and rawequal(value, marker))
assert(not pcall(lr.fromiter, function() end, "S0", 0))
assert(not pcall(lr.fromiter, function() end, "int64", {like = {}}))
```

El buffer nativo sigue la estrategia de crecimiento del 50% del origen y se
reduce a la longitud escrita. Usa asignación comprobada y casts escalares
nativos; no reúne primero los valores en una lista Lua. No admite protocolos
Python de iteración/length-hint, objetos externos, dtype estructurado/subarray ni
`like`. Un callback que devuelve `nil` no puede usarlo como elemento. Los
userdata escalares temporales conservan los límites de conversión existentes;
usa arrays tipados de rango cero para casts escalares crudos. La API sigue parcial.

## Verificación de 0.159.0-dev

Fromiter aprobó **11 367 casos /153 738 comprobaciones** contra NumPy2.5.4:6 874 entradas válidas y4 493 errores esperados, con58 comprobaciones Lua, una prueba nativa de crecimiento/desbordamiento y cabeceras/enlace C++. Se comparan bytes significativos exactos, dtype/disposición/flags, estados de entrada, orden count/EOF/error y valores consumidos; los errores del callback conservan el objeto Lua original. Veinte arrays NaN reales usan clasificación numérica; se omite padding ABI x87. Los dos corpus se regeneraron exactamente.

