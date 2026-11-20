---
docs_examples: true
---

# Pertenencia por elemento

`lr.isin(element, test_elements, options)` devuelve un array booleano con la
forma de `element`. Cada posición indica si su valor aparece en alguna
posición de `test_elements`, independientemente de la forma de este último.

```lua
local lr = require("luaray")
local values = lr.array({{0, 2, 3}, {1, 5, 2}}, "uint8")
local mask = lr.isin(values, {2, 5})
assert(mask[1][2] and mask[2][2] and not mask[1][1])
local absent = lr.isin(values, {2, 5}, {invert = true})
assert(absent[1][1] and not absent[2][2])
```

Por defecto usa una tabla de búsqueda acotada cuando las entradas enteras
lo permiten. `kind = "table"` solicita esa búsqueda con entradas booleanas
o enteras. `kind = "sort"` desactiva la tabla. La ruta general compara
directamente conjuntos de claves pequeños y ordena de forma estable los
grandes. Usa `assume_unique = true` si ambas entradas ya contienen valores
distintos.

```lua
local all = lr.arange(1, 40, 1)
local selected = lr.arange(20, 60, 1)
local mask = lr.isin(all, selected, {kind = "sort", assume_unique = true})
assert(not mask[19] and mask[20] and mask[39])
```

La inversión complementa la máscara de pertenencia. Los NaN se comparan
como distintos incluso si el array de claves contiene NaN. La ruta entera
admite mezclas con y sin signo sin convertirlas a punto flotante.
