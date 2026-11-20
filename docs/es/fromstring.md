---
docs_examples: true
---
# Leer texto numérico

Usa `lr.fromstring(texto, {sep = ",", dtype = "float64"})` para leer valores
delimitados en un array propio unidimensional. El separador es obligatorio.
El dtype predeterminado es float64.

```lua
local lr = require("luaray")
local values = lr.fromstring("1, 2, -3", {sep = ",", dtype = "int16"})
assert(values[1] == 1 and values[3] == -3)
assert(values.flags.owndata)
```

Un separador puede contener varios caracteres. Los espacios del separador
coinciden con secuencias de espacios ASCII. Un separador compuesto solo por
espacios permite leer valores separados por cualquier espacio ASCII.

```lua
local xy = lr.fromstring("3.5\t -2.0", {sep = " "})
assert(xy[1] == 3.5 and xy[2] == -2)
local pair = lr.fromstring("1 :: 2", {sep = "::"})
assert(pair.size == 2)
```

Usa `count` para leer un prefijo. Un count negativo lee hasta el final. Cero
devuelve un array vacío. Un count positivo exige esa cantidad de valores.
Así se evitan los elementos sin inicializar que NumPy 2.5.5 puede devolver
cuando el texto termina antes.

```lua
local prefix = lr.fromstring("1,2,skip", {sep = ",", count = 2})
assert(prefix.size == 2 and prefix[2] == 2)
assert(not pcall(lr.fromstring, "1", {sep = ",", count = 2}))
```

Se admiten enteros, booleanos, flotantes reales, complex64, complex128 y ticks
enteros para dtypes temporales. El texto entero sigue las reglas de conversión
del lector nativo. Las cadenas de ancho fijo y clongdouble carecen de un
lector en el origen. Para datos binarios, usa `frombuffer`.
