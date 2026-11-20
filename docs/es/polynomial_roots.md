---
docs_examples: true
---

# Raíces y polinomios característicos

`lr.roots(coefficients)` calcula las raíces de un polinomio con los
coeficientes en orden descendente de potencia. Los coeficientes cero
del final aportan raíces en cero. La implementación calcula con LAPACK
los valores propios de la matriz compañera del polinomio.

```lua
local lr = require("luaray")
local roots = lr.roots({1, -3, 2})
assert(lr.allclose(lr.sort(roots), {1, 2}))
local z = lr.roots({1, 0, 1})
assert(lr.allclose(lr.sort(lr.imag(z)), {-1, 1}))
```

`lr.poly(roots)` construye el polinomio mónico con esas raíces.
También puedes pasar una matriz cuadrada no vacía para obtener su
polinomio característico.

```lua
assert(lr.array_equal(lr.poly({1, 2, 3}), {1, -6, 11, -6}))
local a = lr.array({{1, 0}, {0, 2}})
assert(lr.allclose(lr.poly(a), {1, -3, 2}))
```

El orden de las raíces puede variar según la compilación de LAPACK.
Compáralas como una colección sin orden cuando este no importe. El
cálculo usa los dtypes reales y complejos admitidos por LAPACK.
`lr.mintypecode(codes, typeset, default)` selecciona un carácter de tipo
siguiendo la precedencia histórica de NumPy.

## Validación

Aprobaron **770 casos / 8 436 comprobaciones** con NumPy 2.5.5. Las pruebas cubren coeficientes mónicos, polinomios característicos, matrices compañeras, raíces cero al final y precedencia de caracteres de tipo. Las raíces se comparan como multiconjuntos entre compilaciones de LAPACK.
