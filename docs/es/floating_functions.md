---
docs_examples: true
---

# Vecinos de punto flotante y sumas estables

`lr.nextafter(x, toward)` devuelve el valor de punto flotante adyacente a
cada elemento de `x` en dirección a `toward`. `lr.spacing(x)` mide la
separación según las reglas de NumPy para el dtype seleccionado. Para valores
negativos, float16 avanza hacia infinito positivo. float32, float64 y
longdouble avanzan hacia fuera y devuelven una separación negativa.
Ambos signos de cero dan el menor subnormal positivo con `spacing`.

```lua
local lr = require("luaray")
local x = lr.array({1, -1, 0}, "float32")
assert(lr.nextafter(x, 2.0)[1] == 1 + 2^-23)
assert(lr.spacing(x)[2] == -2^-23)
assert(lr.spacing(x)[3] == 2^-149)
```

`lr.heaviside(x, at_zero)` devuelve 0 si el valor es negativo, 1 si es
positivo y `at_zero` para ambos signos de cero. Una entrada NaN devuelve NaN.
`lr.logaddexp(x, y)` evalúa el logaritmo natural de `exp(x) + exp(y)`
sin aplicar la exponencial directamente al operando mayor.
`lr.logaddexp2` usa base 2.

```lua
local steps = lr.heaviside({-2, 0, 3}, 0.5)
assert(steps[1] == 0 and steps[2] == 0.5 and steps[3] == 1)
assert(lr.logaddexp({1000}, -1000)[1] == 1000)
assert(lr.logaddexp2({12}, 12)[1] == 13)
```

Estas ufuncs reales admiten broadcasting y las opciones `out` y `where`.
El dtype sigue la precisión de las entradas y las reglas de promoción.
`spacing` devuelve NaN para ambos signos de infinito. En la plataforma x87
probada, también devuelve NaN para la mayor magnitud finita de longdouble,
igual que NumPy 2.5.5.
