---
docs_examples: true
---

# Operaciones con coeficientes polinómicos

Los coeficientes se ordenan de mayor a menor potencia. `{1, -2, 3}`
representa `x² - 2x + 3`. `lr.polyadd` y `lr.polysub` alinean los
términos constantes. `lr.polymul` multiplica polinomios mediante
convolución discreta.

```lua
local lr = require("luaray")
local p = lr.polymul({1, -1}, {1, 1})
assert(lr.array_equal(p, {1, 0, -1}))
assert(lr.array_equal(lr.polyadd(p, {3}), {1, 0, 2}))
```

`lr.polyder(coefficients, order)` deriva el polinomio.
`lr.polyint(coefficients, order, constants)` lo integra. El orden
predeterminado es uno. Las constantes de integración son cero por
defecto y pueden pasarse como un escalar o un vector con una entrada
por integración.

```lua
local coefficients = lr.polyint({2, 4}, 1, 10)
assert(lr.array_equal(coefficients, {1, 4, 10}))
assert(lr.array_equal(lr.polyder(coefficients), {2, 4}))
assert(lr.array_equal(lr.polyval(coefficients, {0, 1, 2}), {10, 15, 22}))
```

`lr.polyval(coefficients, x)` evalúa con el método de Horner. Los
puntos de evaluación pueden ser un escalar o un ndarray. Los
coeficientes y puntos complejos siguen la promoción numérica.
