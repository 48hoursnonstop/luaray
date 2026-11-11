---
docs_examples: true
---
# Contraer ejes de tensores

`lr.tensordot(a, b, axes)` multiplica dos arrays y suma sobre pares de ejes
seleccionados. Los ejes restantes de `a` aparecen primero en el resultado,
seguidos de los de `b`. Admite ndarrays, secuencias Lua rectangulares o escalares.

## Multiplicación matricial y contracción completa

```lua
local lr = require("luaray")
local a = lr.arange(6):reshape({2, 3})
local b = lr.arange(12):reshape({3, 4})
local matrix = lr.tensordot(a, b, 1)
assert(matrix.shape[1] == 2 and matrix.shape[2] == 4)
assert(matrix:get(1, 1) == 20 and matrix:get(2, 4) == 92)
local dot = lr.tensordot({1, 2}, {3, 4}, 1)
assert(dot.ndim == 0 and dot:tolist() == 11)
```

Un entero `axes=n` contrae los últimos `n` ejes de `a` con los primeros `n` de `b`.
Las longitudes de cada par deben coincidir. El valor predeterminado es dos; un
conteo negativo equivale a cero, como en la referencia fijada. Exige enteros Lua.

## Seleccionar ejes individuales

```lua
local tensor = lr.arange(12):reshape({2, 3, 2})
local result = lr.tensordot(tensor, tensor, {axes={{3, 1}, {3, 1}}})
assert(result.shape[1] == 3 and result.shape[2] == 3)
assert(result:get(1, 1) == 86)
local same = lr.tensordot(a, b, {-1, 1})
assert(same:get(1, 1) == 20)
```

Los ejes positivos empiezan en **uno**; los negativos cuentan desde el final.
Usa `{axes_a, axes_b}` directamente o `{axes={axes_a, axes_b}}`. Cada miembro
puede ser un entero o una secuencia. Ambas listas deben medir lo mismo y no
repetir ejes normalizados. Una tabla de opciones vacía usa dos ejes por defecto.

## Formar un producto tensorial

```lua
local product = lr.tensordot({1, 2}, {3, 4}, {axes=0})
assert(product.shape[1] == 2 and product.shape[2] == 2)
assert(product:get(2, 2) == 8)
local explicit = lr.tensordot({1, 2}, {3, 4}, {{}, {}})
assert(explicit:get(1, 2) == 4)
```

Sin pares de ejes, el producto no suma y conserva todos los ejes de entrada.
El [producto de Kronecker](kron.md), en cambio, combina longitudes de ejes
correspondientes para formar bloques.

## Vacíos, dtypes y memoria

```lua
local empty_sum = lr.tensordot(lr.zeros({2, 0}, "int8"),
                              lr.zeros({0, 3}, "int8"), 1)
assert(empty_sum.shape[1] == 2 and empty_sum.shape[2] == 3)
assert(empty_sum.dtype == "int8" and empty_sum:get(2, 3) == 0)
assert(not lr.shares_memory(matrix, a))
```

El resultado es un ndarray independiente y escribible, también cuando tiene
rango cero. Los ejes contraídos vacíos producen ceros tipados; los ejes restantes
vacíos siguen vacíos. La promoción fuerte y el motor compartido `dot` determinan
la precisión. Los complejos se multiplican **sin conjugación**. Los booleanos
usan la contracción lógica de referencia. Se admiten vistas invertidas,
transpuestas, broadcast y Fortran.

El producto legacy de timedelta usa ticks enteros tras convertirlos a una unidad
común. Aplica wrapping entero y no propaga NaT como la multiplicación ordinaria
de duraciones. Los productos mixtos con flotantes que requieren almacenamiento
NumPy object siguen bloqueados por ese dtype no disponible.

## Compatibilidad

Disponible desde **0.126.0-dev**. Las permutaciones, reshape y productos se
contrastan con NumPy 2.5.3; los ejes se adaptan a Lua. Un resultado que supera
los 64 ejes de la compilación falla antes de escribir buffers nativos de forma.
Siguen pendientes object/structured, protocolos externos y subclases. La API
conserva [compatibilidad parcial](api_inventory.md). Consulta el alcance de las
comparaciones exactas y numéricas en [verificación](development/validation.md).

El signo de componentes cero de resultados BLAS puede variar entre proveedores;
las diferencias observadas se cuentan explícitamente.
