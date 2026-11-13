---
docs_examples: true
---
# Arrays desde un callback Lua

`lr.fromfunction(callback, dimensions, options, ...parameters)` construye
rejillas densas y llama al callback **una vez**, con un array por dimensión.
Devuelve sus resultados sin convertirlos. Las coordenadas empiezan en cero,
como `lr.indices`; su dtype por defecto es float64.

```lua
local lr = require("luaray")
local calls = 0
local values = lr.fromfunction(function(row, column)
  calls = calls + 1
  return row * 10 + column
end, {2, 3})
assert(calls == 1 and values:get(2,3) == 12)
assert(values.dtype == "float64")
```

Todos los arrays de coordenadas tienen la forma solicitada. La aritmética usa
operadores nativos y broadcasting; el callback no se evalúa una vez por elemento.
Puede ser una función Lua/C o un valor con metamétodo Lua `__call`. Solo se
admite la opción `dtype`, mediante string o descriptor.

```lua
local diagonal = lr.fromfunction(function(i, j)
  return lr.equal(i, j)
end, {3, 3}, {dtype="int32"})
assert(diagonal.dtype == "bool")
assert(diagonal:get(2,2) and not diagonal:get(1,2))
```

Usa comparaciones explícitas como `lr.equal` para resultados elemento a elemento.
El dtype de las coordenadas controla los argumentos, sin imponer tipo ni forma
a la salida del callback.

## Parámetros extra y resultados

Los parámetros Lua extra se añaden después de las coordenadas y conservan nil
y el número de argumentos. Es la interfaz Lua para el contexto del callback:
el forwarding de keywords Python se representa mediante parámetros posicionales.
También puedes capturar contexto en un closure o pasar una tabla con nombres.

```lua
local shifted = lr.fromfunction(function(i, j, scale, offset)
  return i * scale + j + offset
end, {2, 3}, nil, 3, 0.5)
assert(shifted:get(2,3) == 5.5)
```

No hay conversión ni asignación adicional alrededor de los resultados.
Escalares, tablas, funciones, arrays, nil y retornos múltiples mantienen su
significado Lua. Una lista vacía de dimensiones no pasa coordenadas.

```lua
local token = {name="result"}
local a, b, c = lr.fromfunction(function()
  return nil, false, token
end, {})
assert(a == nil and b == false and rawequal(c, token))
local count = lr.fromfunction(function(...) return select('#', ...) end, {})
assert(count == 0)
```

## Vistas, cambios y errores

Los argumentos son vistas de la nueva rejilla densa. El callback puede
modificarlos, marcar una vista como solo lectura o devolverla directamente.
Las vistas conservan su asignación nativa tras la llamada y la recolección.

```lua
local axis = lr.fromfunction(function(i) return i end, {3}, {dtype="float32"})
collectgarbage("collect")
assert(not axis.flags.owndata and axis.dtype == "float32")
axis:set(7, 1)
assert(axis:get(1) == 7)
```

La rejilla se construye antes de llamar al callback. Las dimensiones inválidas
o un dtype de coordenadas no admitido fallan antes de ejecutarlo. Sus errores
se propagan sin reemplazarlos ni convertirlos.

```lua
local ran = false
assert(not pcall(function()
  lr.fromfunction(function() ran = true end, {-1, 3})
end))
assert(not ran)
local marker = {}
local ok, err = pcall(function()
  lr.fromfunction(function() error(marker) end, {1})
end)
assert(not ok and rawequal(err, marker))
```

Las rejillas densas añaden un eje interno, por lo que se admiten hasta 63
dimensiones solicitadas. Los ejes vacíos también producen coordenadas y llaman
al callback una vez. No se implementan `like` ni dispatch externo; las opciones
desconocidas fallan. La aridad y los retornos múltiples siguen las reglas Lua.

## Referencias ejecutadas

La referencia NumPy 2.5.3 aprobó **2 160 casos / 1 172 364 comprobaciones**.
Cubre dtypes, formas inválidas/vacías/escalares/de alto rango, una sola ejecución,
objetos invocables, resultados escalares/arrays/múltiples, identidad y memoria
compartida, cambios, solo lectura y errores. El contexto keyword original se
mapeó a parámetros Lua extra y las tuplas a retornos múltiples. Los datos
numéricos y metadatos son exactos dentro de esas convenciones; longdouble omite
padding de ABI. El corpus se regenera exactamente y la regresión Lua permanente
añade 103 comprobaciones. La API sigue siendo parcial: protocolos externos,
dtypes de objetos generales, todas las interacciones de callbacks y todas las
ABI siguen sin soporte o sin certificar.
