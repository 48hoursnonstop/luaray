---
docs_examples: true
---

# Sumación de Einstein

`lr.einsum(subscripts, operands..., options)` evalúa una contracción de
tensores. Cada letra identifica un eje. Los ejes cuyas etiquetas no
aparecen en la salida se suman. Cuando se omite la salida, las etiquetas
que aparecen una sola vez se conservan en orden alfabético.

```lua
local lr = require("luaray")
local a = lr.array({{1, 2}, {3, 4}})
local b = lr.array({{5, 6}, {7, 8}})
local product = lr.einsum("ij,jk->ik", a, b)
assert(lr.array_equal(product, {{19, 22}, {43, 50}}))
assert(lr.einsum("ii", a) == 5)
```

Las etiquetas repetidas dentro de un operando seleccionan su diagonal y
requieren ejes de igual longitud. Los puntos suspensivos representan ejes
sin nombre que se alinean desde la derecha para el broadcasting. Inclúyelos
en la salida si representan uno o más ejes. Una permutación o diagonal de
un solo operando y sin sumas devuelve una vista si se omite `out`.

```lua
local diagonal = lr.einsum("ii->i", a)
assert(lr.shares_memory(diagonal, a))
local batch = lr.stack({a, b})
assert(lr.array_equal(lr.einsum("...ij,jk->...ik", batch, b), lr.matmul(batch, b)))
```

Usa `dtype` para elegir el tipo del cálculo, `casting` para fijar la regla
de conversión y `order` para seleccionar el orden de memoria. Por defecto,
la conversión es segura y se conserva el orden de memoria. Pasa un ndarray
modificable como `out` para guardar el resultado ahí. Si se omite el dtype
de cálculo, el dtype de salida participa en la promoción. Las contracciones
usan el cálculo nativo directo y los subíndices se pasan como cadena.

## Validación

Aprobaron **1 041 casos / 33 943 comprobaciones** con NumPy 2.5.5. Las pruebas cubren la forma directa con cadenas, etiquetas repetidas e implícitas, broadcasting con puntos suspensivos, vistas modificables, conversiones, contracciones vacías y tolerancias de redondeo. Quedan pendientes las rutas optimizadas y la notación de listas.
