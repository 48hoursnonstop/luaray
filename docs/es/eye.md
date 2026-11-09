---
docs_examples: true
---
# Matrices identidad y rectangulares

Usa `identity` para una identidad cuadrada y `eye` cuando necesites una forma
rectangular, otra diagonal o almacenamiento Fortran.

## Firmas

| Función | Valores predeterminados |
| --- | --- |
| `lr.eye(n, m, k, dtype, order)` | `m=n`, `k=0`, float64, orden C. |
| `lr.eye(n, {m=..., k=..., dtype=..., order=..., device="cpu"})` | Tabla de opciones. |
| `lr.identity(n, dtype)` | Identidad cuadrada en orden C; float64 por omisión. |
| `lr.identity(n, {dtype=...})` | Tabla de opciones. |

Dimensiones y offsets deben ser enteros Lua. Las dimensiones negativas producen
un error. `order` acepta C/F sin distinguir mayúsculas; el dispositivo opcional es
exactamente `"cpu"`. Opciones, dispositivos o argumentos adicionales inválidos producen errores.

## Empieza con una matriz identidad

```lua
local lr = require("luaray")
local identity = lr.identity(3, "float64")
assert(identity:get(1, 1) == 1 and identity:get(1, 2) == 0)
local vector = lr.array({2., 4., 6.}, "float64")
local unchanged = lr.matmul(identity, vector)
assert(unchanged[1] == 2 and unchanged[3] == 6)
```

Multiplicar por una identidad conserva un vector compatible. La matriz es un
ndarray ordinario y escribible, sin una representación simbólica especial.

## Selecciona diagonal y orden de memoria

```lua
local upper = lr.eye(2, {m=3, k=1, dtype="int16", order="F"})
assert(upper:get(1, 2) == 1 and upper:get(2, 3) == 1)
assert(upper:get(1, 1) == 0)
assert(upper.strides[1] == 2 and upper.strides[2] == 4)
```

Un offset positivo sitúa unos encima de la diagonal principal; uno negativo,
debajo. Fuera de la matriz se obtienen ceros. C y F describen el almacenamiento
físico; los valores indexados siguen la misma regla diagonal.

## Usa matrices tipadas o vacías

```lua
local labels = lr.eye(2, {dtype="U4"})
assert(labels:get(1, 1) == "1" and labels:get(1, 2) == "")
local empty = lr.eye(0, 3)
assert(empty.shape[1] == 0 and empty.shape[2] == 3)
```

Las cadenas almacenan `"1"` en la diagonal y texto vacío fuera de ella. S/U sin
ancho usan un carácter. Los booleanos contienen true/false; los tipos temporales
con unidad, ticks uno/cero. Un datetime genérico falla al alcanzarse la asignación
del escalar uno, incluso con una diagonal vacía. La salida temprana de referencia
para `k >= m` permite ceros datetime genéricos. Especifica una unidad en el uso ordinario.

## Compatibilidad

Disponible desde **0.121.0-dev**. Las referencias exactas NumPy 2.5.3 cubren valores,
forma, dtype, strides, permisos, dimensiones vacías, offsets extremos y orden C/F.
Los objetos índice Python, dispatch `like`, objetos/estructuras y fidelidad de
advertencias/excepciones siguen pendientes. Las APIs mantienen
[compatibilidad parcial](api_inventory.md).
