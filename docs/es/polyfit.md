---
docs_examples: true
---

# Ajuste polinómico

`lr.polyfit(x, y, degree, options)` ajusta por mínimos cuadrados
coeficientes en orden descendente de potencia. `x` es un vector
de puntos de muestreo. `y` es un vector o una matriz con una serie
de observaciones por columna.

```lua
local lr = require("luaray")
local x = lr.array({0, 1, 2, 3, 4})
local y = lr.array({3, 6, 11, 18, 27})
local coefficients = lr.polyfit(x, y, 2)
assert(lr.allclose(coefficients, {1, 2, 3}))
assert(lr.allclose(lr.polyval(coefficients, x), y))
```

Usa `w` para aplicar un peso por observación antes de elevar al
cuadrado el residuo. `rcond` fija el umbral relativo de los valores
singulares. Por defecto, multiplica la precisión del dtype flotante
de x por el número de observaciones.

```lua
local coefficients, residuals, rank, singular, rcond = lr.polyfit(x, y, 2, {
  w = {1, 2, 3, 1, 2},
  full = true
})
assert(rank == 3 and singular.size == 3 and rcond > 0)
assert(residuals[1] < 1e-20)
```

Con `full = true` también se devuelven residuos, rango, valores
singulares y el umbral. Fuera de ese modo, `cov = true` devuelve como
segundo resultado la covarianza escalada. Usa `cov = "unscaled"`
para omitir el escalado por residuos. Para varias series de respuesta,
la covarianza escalada contiene una matriz por serie en el último eje.
