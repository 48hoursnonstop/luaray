---
docs_examples: true
---
# Rellenar una diagonal

`fill_diagonal` escribe la diagonal principal sin construir arrays de coordenadas.
Modifica el destino y no devuelve ningún valor.

| Firma | Significado |
| --- | --- |
| `lr.fill_diagonal(a, values, wrap)` | `wrap` es false por defecto. |
| `lr.fill_diagonal(a, values, {wrap=...})` | Forma con tabla de opciones. |

El destino debe ser un ndarray escribible con al menos dos dimensiones. Las matrices
pueden ser rectangulares; en arrays de más dimensiones todos los ejes deben medir
lo mismo. `wrap` exige un booleano Lua y solo afecta a matrices altas.

## Repetir una secuencia

```lua
local lr = require("luaray")
local matrix = lr.zeros({3, 4}, "int64")
assert(lr.fill_diagonal(matrix, {2, 7}) == nil)
assert(matrix:get(1, 1) == 2 and matrix:get(2, 2) == 7)
assert(matrix:get(3, 3) == 2 and matrix:get(1, 2) == 0)
```

Un escalar rellena todos los elementos seleccionados. Los arrays y las secuencias
anidadas se recorren en orden C lógico y se repiten si la diagonal es más larga.
Los valores vacíos no modifican el destino. La entrada se valida y convierte
incluso cuando el destino no tiene elementos diagonales. Un destino de solo lectura falla.

## Continuar en una matriz alta

```lua
local tall = lr.zeros({5, 3}, "int16")
lr.fill_diagonal(tall, {1, 2}, true)
assert(tall:get(1, 1) == 1 and tall:get(2, 2) == 2)
assert(tall:get(3, 3) == 1 and tall:get(5, 1) == 2)
```

Con `wrap=false`, el relleno termina al acabar la diagonal principal. Con
`wrap=true`, las posiciones planas continúan cada `columnas+1` elementos, de modo
que una fila posterior puede recibir otro valor en su primera columna. Es la
convención histórica de NumPy.

## Escribir mediante vistas y valores compartidos

```lua
local base = lr.zeros({3, 3}, "float64")
lr.fill_diagonal(lr.flip(base, 1), {3, 4, 5})
assert(base:get(3, 1) == 3 and base:get(2, 2) == 4)
assert(base:get(1, 3) == 5)
```

Las disposiciones Fortran, transpuestas e invertidas se recorren lógicamente y
las escrituras llegan al original. Los arrays de valores del mismo dtype se leen
**durante la escritura**: si comparten memoria con el destino, una escritura puede
cambiar una lectura posterior. Así funciona el iterador plano de referencia.
Pasa una copia explícita de los valores si quieres conservar su estado inicial.
Una conversión necesaria de dtype crea almacenamiento separado.

## Conversiones de escalares y arrays

```lua
local small = lr.zeros({2, 2}, "int8")
lr.fill_diagonal(small, lr.array({256}, "int64"))
assert(small:get(1, 1) == 0)
assert(not pcall(function() lr.fill_diagonal(small, 256) end))
```

Los arrays tipados usan conversión unsafe: int64 `256` se convierte en int8 cero.
Un entero Lua ordinario se compara con los límites del destino y produce un error.
Los strings, complejos y valores temporales usan la conversión compartida de
asignación; el texto de ancho fijo se trunca para ajustarlo al destino.

## Compatibilidad

Disponible desde **0.124.0-dev**. Las referencias exactas de NumPy 2.5.3 cubren
valores, dtype, forma, strides, almacenamiento original, errores de solo lectura,
vacíos, repetición, wrap, fallos de conversión y escrituras con valores compartidos.
Los protocolos Python de subclases, escalares externos y advertencias/excepciones
siguen incompletos. La API conserva [compatibilidad parcial](api_inventory.md).
