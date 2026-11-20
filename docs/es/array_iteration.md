---
docs_examples: true
---

# Recorrer valores de un arreglo

`lr.ndenumerate(array)` produce una tabla independiente con la
coordenada indexada desde uno y su valor. Visita los elementos en orden
lógico C, con el último eje cambiando más rápido. El recorrido también
se aplica a vistas transpuestas e invertidas.

```lua
local lr = require("luaray")
local values = lr.array({{1, 2}, {3, 4}})
local total = 0
for coordinate, value in lr.ndenumerate(values) do
  total = total + coordinate[1] * value
end
assert(total == 17)
```

`lr.broadcast(a, b, ...)` recorre juntos arreglos con formas
compatibles. Cada paso devuelve una tabla con un valor por operando.
El iterador lee de vistas de broadcasting, así que los cambios en una
entrada se ven en las lecturas posteriores.

```lua
local product = lr.broadcast({1, 2}, {{3}, {4}})
assert(product.size == 4 and product.ndim == 2)
local values = {}
for pair in product do
  values[#values + 1] = pair[1] * pair[2]
end
assert(table.concat(values, ",") == "3,6,4,8")
product:reset()
assert(product.index == 0 and product:next()[1] == 1)
```

El iterador expone `shape`, `size`, `ndim` y `numiter` como propiedades
de solo lectura. `index` cuenta cuántas tuplas se han devuelto.
Tanto una llamada directa como `next()` avanzan el mismo iterador.
Usa `reset()` para volver al inicio.
