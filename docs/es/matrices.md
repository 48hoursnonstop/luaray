---
docs_examples: true
---
# Diagonales y construcción de matrices

Extrae una diagonal como vista compartida de solo lectura o construye una
matriz independiente a partir de una secuencia de valores.

## Firmas

| Función | Resultado |
| --- | --- |
| `lr.diagonal(a, offset, axis1, axis2)` | Vista de solo lectura; valores predeterminados: `0, 1, 2`. |
| `a:diagonal(offset, axis1, axis2)` | La misma operación como método ndarray. |
| `lr.diagonal(a, {offset=0, axis1=1, axis2=2})` | Forma con tabla de opciones. |
| `lr.diag(v, k)` | Construye una matriz desde un vector o extrae la diagonal de una matriz. |
| `lr.diagflat(v, k)` | Aplana en orden C y construye una matriz. |

`k` vale cero si se omite; también se acepta `{k=...}`. Un offset positivo
selecciona una diagonal superior y uno negativo una inferior. Los ejes positivos
empiezan en uno; los negativos cuentan desde el final. Las opciones desconocidas,
índices no enteros, ejes repetidos y argumentos adicionales producen errores Lua.

## Extrae una diagonal

```lua
local lr = require("luaray")
local a = lr.array({{1, 2, 3}, {4, 5, 6}}, "int32")
local diagonal = lr.diagonal(a)
assert(diagonal[1] == 1 and diagonal[2] == 5)
assert(a:diagonal(1)[2] == 6) -- diagonal superior: {2, 6}
assert(lr.diag(a, -1)[1] == 4)
```

Con una entrada bidimensional, `diag` devuelve una vista compartida de solo
lectura igual que `diagonal`. Un offset fuera de las dimensiones seleccionadas
devuelve una vista vacía con el dtype original.

## Entiende la memoria compartida

```lua
assert(lr.shares_memory(a, diagonal))
a:set(50, 2, 2)
assert(diagonal[2] == 50)
assert(not pcall(function() diagonal[1] = 99 end))

local independent = diagonal:copy()
independent[1] = 99
assert(a:get(1, 1) == 1)
```

La vista mantiene vivo el almacenamiento aunque se recolecte la variable
original. Usa `copy()` si necesitas un resultado independiente y escribible.
Extraer una diagonal conserva strides negativos y no contiguos sin copiar a
memoria densa.

## Elige ejes en un array multidimensional

```lua
local volume = lr.arange(24):reshape({2, 3, 4})
local selected = lr.diagonal(volume, {axis1=1, axis2=3})
assert(selected.shape[1] == 3 and selected.shape[2] == 2)
assert(selected:get(2, 2) == 17)
```

Se eliminan los dos ejes seleccionados. Los demás conservan su orden y se añade
al final el eje diagonal, cuyo stride es la suma de los strides seleccionados.
`lr.diagonal` usa los **primeros dos ejes**; `lr.linalg.diagonal`, los **últimos
dos**. Especifica los ejes al trabajar con lotes de matrices.

## Construye una matriz nueva

```lua
local upper = lr.diag({2, 4, 6}, 1)
assert(upper.shape[1] == 4 and upper.shape[2] == 4)
assert(upper:get(1, 2) == 2 and upper:get(3, 4) == 6)
assert(upper:get(1, 1) == 0)

local flat = lr.diagflat(a.T, -1)
assert(flat.shape[1] == 7 and flat:get(2, 1) == 1)
assert(flat:get(5, 4) == 50)
```

El lado mide `número_de_valores + abs(k)`. La matriz tiene almacenamiento nuevo,
escribible y en orden C. Conserva el dtype de la entrada convertida; fuera de la
diagonal contiene ceros, incluidas cadenas fijas vacías y ticks temporales cero.
`diag` acepta rango uno o dos; `diagflat`, cualquier rango, incluidos escalares
y arrays vacíos. Las entradas transpuestas o invertidas se aplanan en orden C lógico.

## Compatibilidad

Disponible desde **0.117.0-dev**, con referencias exactas NumPy 2.5.3 para valores,
dtype, forma, strides, memoria compartida, permisos y estados del almacenamiento.
El offset de extracción sigue el rango C `int` de NumPy. La construcción detecta
desbordamiento de forma antes de reservar memoria. Un offset negativo extremo
devuelve una vista vacía segura; no se usa como referencia la ruta de upstream
que desborda al negar un entero con signo.

Siguen aplicándose los límites de dtype y coerción del constructor. Object,
estructuras, endian numérico no nativo, subclases Python y fidelidad completa de
advertencias/excepciones siguen pendientes. Estas APIs conservan compatibilidad
parcial. Consulta el [inventario](api_inventory.md) y la
[verificación](development/validation.md).
