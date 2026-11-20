---
docs_examples: true
---

# Covarianza y correlación

`lr.cov(observations, options)` devuelve la matriz de covarianza muestral.
`lr.corrcoef(observations, options)` devuelve la matriz de correlación de
Pearson. Por defecto, cada fila es una variable. Usa `rowvar = false` cuando
las variables ocupen columnas. Pasa un segundo conjunto de variables como
`y`, con el mismo número de observaciones.

```lua
local lr = require("luaray")
local x = lr.array({{0, 1, 2}, {0, 2, 4}})
local cov = lr.cov(x)
assert(lr.allclose(cov, {{1, 2}, {2, 4}}))
local corr = lr.corrcoef(lr.transpose(x), {rowvar = false})
assert(lr.allclose(corr, {{1, 1}, {1, 1}}))
```

La covarianza divide por el número de observaciones menos uno por defecto.
Usa `bias = true` para dividir por el total, o especifica `ddof`.
`fweights` indica frecuencias enteras no negativas y `aweights` indica
pesos reales no negativos. Pasa un valor por observación.

```lua
local weighted = lr.cov(x, {fweights = {1, 2, 1}})
assert(lr.allclose(weighted, {{2/3, 4/3}, {4/3, 8/3}}))
local scalar_cov = lr.cov({0, 1, 2})
assert(scalar_cov.ndim == 0 and scalar_cov:item() == 1)
```

El dtype predeterminado tiene al menos la precisión de `float64`.
Usa `dtype` para pedir otro tipo flotante o complejo. La covarianza compleja
usa el conjugado y la correlación recorta cada componente por separado.
Una sola variable produce una covarianza de dimensión cero. Su correlación
usa la conversión escalar de LuaRay para ese dtype. La correlación de una
variable constante es indefinida.

## Validación

Aprobaron **2 479 casos / 102 908 comprobaciones** con NumPy 2.5.5. Las pruebas cubren filas y columnas, observaciones ponderadas y sin ponderar, conjugación compleja y normalización. En 1 200 componentes con divisor cero y numerador finito cercano a cero, las pruebas aceptan NaN o infinito según la compilación de BLAS.
