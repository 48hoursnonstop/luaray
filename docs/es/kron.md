---
docs_examples: true
---
# Producto de Kronecker

`lr.kron(a, b)` sustituye cada elemento de `a` por un bloque de `b` multiplicado
por ese valor. Admite dos ndarrays, secuencias Lua rectangulares o escalares y
devuelve un ndarray independiente y escribible.

## Construye una matriz de bloques

```lua
local lr = require("luaray")
local weights = lr.array({{1, 2}, {3, 4}}, "int32")
local blocks = lr.kron(weights, lr.eye(2))
assert(blocks.shape[1] == 4 and blocks.shape[2] == 4)
assert(blocks:get(1, 1) == 1 and blocks:get(1, 3) == 2)
assert(blocks:get(3, 1) == 3 and blocks:get(3, 3) == 4)
assert(blocks:get(1, 2) == 0)
```

Cada bloque 2×2 es la identidad multiplicada por su peso. Las dimensiones de
los operandos se multiplican; no se contraen como en el producto matricial ordinario.

## Combina rangos distintos

```lua
local tensor = lr.kron(lr.ones({2, 1, 2}, "int16"),
                       lr.ones({2, 3}, "int16"))
assert(tensor.shape[1] == 2 and tensor.shape[2] == 2)
assert(tensor.shape[3] == 6)
```

El rango menor se completa con ejes de longitud uno a la izquierda. Cada eje `d`
del resultado mide `a.shape[d] * b.shape[d]` tras esa adaptación. Los ejes vacíos
siguen vacíos. El orden conserva la regla de bloques en cada dimensión.

## Dtypes y escalares

```lua
local vector = lr.array({1, 2}, "int8")
local scaled = lr.kron(vector, 2)
assert(scaled.dtype == "int64" and scaled[2] == 4)
local narrow = lr.kron(vector, lr.array(2, "int8"))
assert(narrow.dtype == "int8")
```

Las entradas se convierten en arrays tipados fuertes antes de multiplicarse.
Un entero Lua ordinario aporta int64, sin seguir la promoción débil de escalares.
Los escalares tipados explícitos conservan su descriptor. Los productos booleanos
usan multiplicación lógica; los complejos usan aritmética compleja. Las firmas
no admitidas, como productos de cadenas fijas o datetime, fallan.
[Las duraciones pueden multiplicarse por enteros o flotantes](temporal_scaling.md).

## Vistas, copias y límites de rango

Las entradas invertidas, transpuestas, broadcast y Fortran conservan sus valores
lógicos. El resultado no comparte memoria con ninguna entrada. Sus strides siguen
la multiplicación nativa y un reshape en orden C; la forma no determina por sí sola
su disposición física.

La construcción intercala ejes, como la referencia, y necesita el doble del rango
expandido. El límite ordinario es 32 en una compilación de 64 dimensiones. Un
escalar **a la derecha** usa una ruta previa de multiplicación que admite un array
izquierdo de mayor rango. Un escalar izquierdo se expande antes de esa comprobación,
conservando la asimetría de la referencia. Los límites producen errores explícitos.

Los resultados escalares siguen la convención de ndarray tipado de rango cero.
Los argumentos adicionales y las secuencias no rectangulares fallan.

## Compatibilidad

Disponible desde **0.125.0-dev**. Las referencias NumPy 2.5.3 cubren promoción,
orden de bloques, forma, strides, vacíos, vistas, memoria independiente, escritura,
firmas temporales y límites de rango. Los casos ordinarios se comparan exactamente.
Los productos complejos64 generales usan tolerancia relativa `3e-7`; los flotantes
y complejos más anchos, `3e-15`. El error observado fue cero en el corpus aleatorio
nuevo. Siguen pendientes subclases y protocolos externos de arrays/escalares;
la API conserva [compatibilidad parcial](api_inventory.md).
