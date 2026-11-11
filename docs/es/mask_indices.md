---
docs_examples: true
---
# Seleccionar índices mediante un callback

`lr.mask_indices(n, mask_function, k)` crea una matriz entera real `n × n` de unos,
llama una vez a `mask_function(matriz, k)` y devuelve coordenadas donde su resultado
es distinto del cero numérico. `k` vale cero por defecto.

## Leer y modificar una región triangular

```lua
local lr = require("luaray")
local coordinates = lr.mask_indices(3, lr.triu, 1)
local matrix = lr.arange(9):reshape({3, 3})
local selected = matrix:get(table.unpack(coordinates))
assert(selected.size == 3 and selected[1] == 1 and selected[3] == 5)
matrix:set(-1, table.unpack(coordinates))
assert(matrix:get(1, 2) == -1 and matrix:get(3, 1) == 6)
```

Las coordenadas empiezan en **uno** y siguen el orden C lógico del resultado.
`tril` y `triu` pueden usarse como callbacks. Si no necesitas uno, usa los
[helpers de índices triangulares](triangles.md) directamente.

## Escribir un callback Lua

```lua
local count = 0
local coordinates = lr.mask_indices(2, function(matrix, parameter)
  count = count + 1
  assert(parameter == "skip first")
  matrix:set(0, 1, 1)
  return matrix
end, "skip first")
assert(count == 1 and coordinates[1].size == 3)
```

El callback recibe almacenamiento nativo escribible con el dtype de índice de
la plataforma: `int64` en Linux x86-64 probado. Puede modificar la entrada o
retornar otro array. `k` se pasa sin cambios, incluidos nil explícito, false,
strings y tablas. Se admiten tablas invocables con `__call`. Los errores del
callback llegan al llamador.

## Devolver otra forma o una secuencia

```lua
local coordinates = lr.mask_indices(2, function()
  return {0, 2, -1}
end)
assert(#coordinates == 1)
assert(coordinates[1][1] == 2 and coordinates[1][2] == 3)
```

El primer valor devuelto se convierte con `asarray`; se ignoran los demás.
Admitir secuencias Lua ordinarias es una adaptación explícita. Sus referencias
NumPy usan un callback que devuelve un ndarray. La cantidad de vectores depende
del rango del resultado, no de la matriz inicial. Un resultado escalar es inválido
porque `nonzero` rechaza el rango cero. Una selección vacía produce vectores vacíos.

## Comparaciones de texto y tipos temporales

```lua
local all = lr.mask_indices(2, function()
  return lr.zeros({2, 2}, "U4")
end)
assert(all[1].size == 4)
local none = lr.mask_indices(2, function()
  return lr.zeros({2, 2}, "timedelta64[h]")
end)
assert(none[1].size == 0)
```

La referencia usa la comparación de ndarray contra cero numérico, que difiere
de su ufunc `not_equal` para ciertos dtypes. El texto y datetime son distintos
del cero numérico, incluidos texto vacío y ticks datetime cero. Timedelta compara
sus ticks con cero; los ticks NaT quedan seleccionados. Los valores numéricos,
booleanos y complejos usan el motor nativo de comparación. La composición Lua
conserva estas reglas explícitamente.

## Compatibilidad

Disponible desde **0.127.0-dev**. El tamaño exige un entero Lua no negativo.
Los argumentos extra, resultados inválidos y errores de callbacks fallan.
Se contrastan dtype, strides, coordenadas, entrada y parámetros del callback,
lecturas/escrituras avanzadas y almacenamiento original sin cambios con NumPy
2.5.3. La composición ejecuta Lua sobre kernels nativos, sin Python. Siguen
pendientes object, dispatch externo e identidad de advertencias/excepciones
Python; la compatibilidad es parcial.
