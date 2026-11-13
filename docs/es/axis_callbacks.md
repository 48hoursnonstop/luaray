---
docs_examples: true
---
# Aplicar un callback a lo largo de un eje

`lr.apply_along_axis(callback, axis, input, ...)` invoca una función Lua sobre cada
sección unidimensional de un eje. Los ejes positivos empiezan en uno; los negativos
cuentan desde el final. Los demás ejes se recorren en orden C. Es útil cuando el
cálculo se expresa naturalmente para un vector.

```lua
local lr = require("luaray")
local values = lr.array({{1, 2, 3}, {4, 5, 6}}, "int16")
local rows = lr.apply_along_axis(lr.sum, 2, values)
assert(rows:tolist()[1] == 6 and rows:tolist()[2] == 15)
local columns = lr.apply_along_axis(lr.sum, 1, values)
assert(columns:tolist()[1] == 5 and columns:tolist()[3] == 9)
```

## Forma y tipo del resultado

El primer resultado del callback determina el dtype y la forma que reemplaza al
eje elegido. Un escalar elimina el eje; un vector lo reemplaza y una matriz inserta
dos dimensiones. Los resultados posteriores se asignan al mismo buffer tipado,
con las reglas habituales de conversión y broadcasting. Para devolver un vector,
usa una tabla Lua o ndarray: solo se usa el primer valor devuelto por Lua.

```lua
local diagonal = lr.apply_along_axis(lr.diag, -1, values)
assert(diagonal.ndim == 3 and diagonal.shape[1] == 2)
assert(diagonal:get(2, 3, 3) == 6)
local lengths = lr.apply_along_axis(function(row)
  return {row.size, 123}
end, 1, values)
assert(lengths.shape[1] == 2 and lengths.shape[2] == 3)
assert(lengths:get(2, 3) == 123)
```

Devuelve un ndarray tipado cuando importe su precisión. Los números Lua siguen
la inferencia habitual de dtype de LuaRay. Si la entrada tiene un eje y el
callback devuelve un escalar, el resultado es un ndarray de dimensión cero.
El resultado tiene almacenamiento independiente; su disposición viene de la
construcción del buffer y su transposición, así que puede no ser contiguo en C.

```lua
local scalar = lr.apply_along_axis(lr.sum, 1, {2, 3, 4})
assert(scalar.ndim == 0 and scalar:item() == 9)
local copied = lr.apply_along_axis(function(row) return row end, 1, values)
assert(not lr.shares_memory(copied, values))
assert(copied.flags.f_contiguous)
```

## Parámetros y vistas compartidas

Los argumentos adicionales se reenvían en cada invocación, incluidos los nil
explícitos. Una tabla de contexto puede sustituir a los argumentos con nombre de
Python. Se aceptan tablas Lua invocables. La sección comparte memoria con la
entrada: modificarla cambia la entrada, y esos cambios permanecen si falla una
invocación posterior. Las vistas de entrada de solo lectura siguen protegidas.
Los errores del callback se propagan sin cambiar su identidad.

```lua
local scaled = lr.apply_along_axis(function(row, scale, context)
  assert(context.label == "scale")
  return row * scale
end, 2, values, 3, {label = "scale"})
assert(scaled:get(2, 3) == 18)
local mutable = lr.array({{1, 2}, {3, 4}})
lr.apply_along_axis(function(row) row:fill(7); return row end, 2, mutable)
assert(mutable:get(1, 1) == 7 and mutable:get(2, 2) == 7)
```

## Ejes vacíos y límites

Un eje seleccionado vacío produce vectores vacíos si las otras dimensiones
permiten iterar. Un cero entre esas otras dimensiones impide invocar el callback
y genera un error. Los ejes inválidos se rechazan antes de llamar a la función.

```lua
local calls = 0
local result = lr.apply_along_axis(function(row)
  calls = calls + 1
  assert(row.size == 0)
  return 5
end, 2, lr.empty({2, 0}))
assert(calls == 2 and result:tolist()[2] == 5)
assert(not pcall(lr.apply_along_axis, lr.sum, 1, lr.empty({2, 0})))
```

La referencia aprobó **60 768 casos / 1 226 968 comprobaciones**: ejes positivos
y negativos, orden de llamadas y metadatos de las vistas retenidas, inserción de
formas, disposición, bytes, escrituras compartidas, solo lectura, fallos de
callbacks, resultados cambiantes y entradas inválidas con dtypes numéricos,
cadenas fijas y temporales. El corpus se regeneró exactamente. Las regresiones
permanentes añaden 191 comprobaciones Lua, incluidos parámetros nil, identidad de
errores y el límite de 64 dimensiones.

La API sigue parcial. No hay subclases Python de ndarray, dtypes object/structured,
despacho de arrays externos ni clases escalares NumPy. Los argumentos con nombre
se expresan como parámetros Lua adicionales; los ejes usan posiciones Lua. No se
certifican todos los posibles callbacks, conversiones ni ABI. Para pasar rejillas
numéricas a una función una sola vez, consulta [fromfunction](fromfunction.md).
