---
docs_examples: true
---
# Generadores aleatorios

Crea un generador PCG64 con `lr.random.default_rng(seed)`. Cada generador
mantiene su propio estado. Usa la misma semilla y repite las llamadas para
reproducir la secuencia en la misma versión de LuaRay. Los métodos del
generador usan la sintaxis `:` de Lua.

```lua
local lr = require("luaray")
local rng = lr.random.default_rng(42)
local samples = rng:random({2, 3})
local replay = lr.random.default_rng(42)
assert(lr.array_equal(samples, replay:random({2, 3})))
```

## Muestrear enteros en un intervalo

`integers(low, high, size, dtype, endpoint)` incluye `low` y excluye `high`
de forma predeterminada. Usa `endpoint = true` para incluir ambos extremos.
Pasa una tabla con la forma para obtener un ndarray u omite el tamaño para
obtener un escalar.

```lua
local dice = rng:integers(1, 7, {10}, "int32")
for _, face in ipairs(dice:tolist()) do
  assert(face >= 1 and face <= 6)
end
```

Busca `numpy.random.Generator` en el [inventario de API](api_inventory.md)
para consultar métodos de distribución y muestreo. La
[portabilidad numérica](portability.md) explica cómo los cálculos de punto
flotante afectan los valores generados.
