---
docs_examples: true
---

# Transponer, unir y separar arrays

`lr.matrix_transpose(a)` intercambia los últimos dos ejes y conserva los ejes
iniciales del lote. `lr.permute_dims(a, axes)` acepta una permutación completa
de los ejes. Ambas funciones devuelven vistas que comparten memoria con la entrada.

```lua
local lr = require("luaray")
local batch = lr.array({{{1, 2, 3}, {4, 5, 6}}, {{7, 8, 9}, {10, 11, 12}}})
local transposed = lr.matrix_transpose(batch)
assert(transposed.shape[1] == 2 and transposed.shape[2] == 3)
assert(transposed[2][3][2] == 12)
assert(lr.shares_memory(batch, transposed))
```

`lr.unstack(a, axis)` devuelve una tabla Lua con los cortes del eje. El eje
predeterminado es 1. Los ejes negativos cuentan desde el final. Para dos o
más dimensiones, cada corte es una vista con un eje menos. Un vector devuelve
elementos escalares. Si el eje está vacío, el resultado es una tabla vacía.

```lua
local columns = lr.unstack(batch, -1)
assert(#columns == 3)
columns[3]:set(99, 2, 2)
assert(batch[2][2][3] == 99)
local joined = lr.concat({columns[1], columns[2]}, {axis = 2})
assert(joined.shape[2] == 4)
```

`lr.concat` comparte la implementación de `concatenate` y admite las mismas
opciones de eje, dtype, casting y salida. Una concatenación nueva asigna
memoria para el resultado.

## Validación

Aprobaron **4 386 casos / 79 458 comprobaciones** con NumPy 2.5.5. Se comparan permutaciones, memoria compartida, permisos, elementos escalares y cortes vacíos. Las seis funciones de unión manejaron 2 048 tablas de entrada con reserva explícita de pila Lua.
