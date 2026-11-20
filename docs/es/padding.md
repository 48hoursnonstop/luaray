---
docs_examples: true
---

# Relleno de arreglos

`lr.pad(array, widths, mode, options)` extiende uno o más ejes y devuelve
un arreglo nuevo con el dtype de la entrada. Un ancho se aplica a ambos
extremos de todos los ejes. Un par indica los anchos anterior y posterior.
Una lista de pares permite elegir los anchos de cada eje.

```lua
local lr = require("luaray")
local a = lr.array({{1, 2}, {3, 4}}, "int32")
local columns = lr.pad(a, {axes = {[-1] = {1, 2}}})
assert(lr.array_equal(columns, {{0, 1, 2, 0, 0}, {0, 3, 4, 0, 0}}))
```

La tabla `axes` es una alternativa a la lista completa. Sus ejes positivos
empiezan en uno y los negativos cuentan desde el final. Los ejes omitidos
conservan su tamaño original.

| Modo | Cómo llena las celdas nuevas | Opciones |
| --- | --- | --- |
| `constant` | Una constante, cero por defecto | `constant_values` |
| `edge` | Repite el valor más cercano de la entrada | |
| `wrap` | Repite periódicamente la entrada | |
| `reflect`, `symmetric` | Refleja los datos y repite el extremo en el modo simétrico | `reflect_type` |
| `linear_ramp` | Interpola entre un valor exterior y el extremo de la entrada | `end_values` |
| `maximum`, `minimum`, `mean`, `median` | Usa un estadístico de los valores cercanos a cada extremo | `stat_length` |
| `empty` | Deja las celdas nuevas sin inicializar | |

Las opciones de valores o longitudes admiten un valor, un par o una lista
de pares. Con `reflect_type = "odd"`, cada muestra reflejada se resta
del doble del valor del extremo. El valor predeterminado es `"even"`.
Los modos estadísticos usan el eje completo por defecto.

```lua
local x = lr.array({1, 2, 3})
local reflected = lr.pad(x, {2, 1}, "reflect", {reflect_type = "odd"})
assert(lr.array_equal(reflected, {-1, 0, 1, 2, 3, 4}))
local repeated = lr.pad(x, {2, 1}, "wrap")
assert(lr.array_equal(repeated, {2, 3, 1, 2, 3, 1}))
```

Para personalizar el relleno, pasa una función Lua como modo. La función
recibe una vista de vector modificable, su par de anchos, el eje indexado
desde uno y la tabla de opciones. Escribe en la vista para actualizar el
arreglo devuelto.

```lua
local custom = lr.pad({1, 2}, 1, function(vector, widths, axis, options)
  vector:set(options.value + axis, lr.s(1, widths[1] + 1))
  vector:set(options.value, lr.s(-widths[2], nil))
end, {value = 10})
assert(lr.array_equal(custom, {11, 1, 2, 10}))
```

## Validación

Aprobaron **5 965 casos / 1 708 673 comprobaciones** con NumPy 2.5.5. Las pruebas cubren los modos estándar y el relleno con callbacks de Lua, anchos por eje, entradas con strides y en orden Fortran, conversiones de dtype y reflejos repetidos. En el modo vacío se comprueban los metadatos y la copia del interior.
