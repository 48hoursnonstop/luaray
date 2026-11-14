---
docs_examples: true
---
# Cuantiles y medianas

`lr.median`, `lr.quantile` y `lr.percentile` seleccionan valores de arrays
numéricos reales. Las fracciones van de cero a uno; los percentiles, de cero
a 100. La interpolación predeterminada es `"linear"`. Se conserva la entrada.

```lua
local lr = require("luaray")
local values = lr.array({1, 2, 3, 4}, "float64")
assert(lr.median(values) == 2.5)
assert(lr.quantile(values, 0.25) == 1.75)
assert(lr.percentile(values, 25) == 1.75)
```

## Ejes y dimensiones conservadas

Omitir `axis` reduce todo el array. Los ejes positivos empiezan en uno; los
negativos cuentan desde el final. Una tabla selecciona varios ejes.
`keepdims = true` conserva los ejes reducidos con longitud uno mediante una
vista con strides cero en esos ejes. Los demás ejes mantienen su orden.

```lua
local matrix = lr.array({{1, 2, 3}, {4, 5, 6}}, "float64")
local rows = lr.median(matrix, {axis = 2})
assert(rows[1] == 2 and rows[2] == 5)
local columns = lr.median(matrix, {axis = 1, keepdims = true})
assert(columns:get(1, 2) == 3.5)
assert(columns.strides[1] == 0 and not columns.flags.owndata)
```

Las medianas conservan el orden físico de los ejes restantes según KEEPORDER
y el preprocesado multieje del origen. Los cuantiles usan la reserva en orden
C del origen. La vista conserva vivo su propio resultado; no comparte los
datos de la entrada original.

## Fracciones y dtype de salida

Una fracción escalar produce un escalar al reducir todos los ejes. Un vector
añade una dimensión inicial a la salida. Los enteros usan resultados flotantes
para interpolar; los métodos discontinuos conservan su dtype. Los vectores de
fracciones participan en la promoción, incluida la conservación de `longdouble`.

```lua
local q = lr.quantile(values, {0.25, 0.5, 0.75})
assert(q.size == 3 and q[1] == 1.75 and q[3] == 3.25)
local wide = lr.array({1, 2, 3, 4}, "longdouble")
assert(lr.quantile(wide, {0.25, 0.5}).dtype == "longdouble")
assert(lr.quantile(lr.array({1, 2, 3, 4}, "int32"), 0.25, {
  method = "lower"
}) == 1)
```

Se admiten `linear`, `lower`, `higher`, `nearest`, `midpoint` e `inverted_cdf`.
La mediana no admite un método. Las fracciones deben ser un número o un vector
Lua/tipado unidimensional no vacío. Sus valores siguen pasando internamente
por parámetros de precisión double, incluso las fracciones longdouble tipadas:
conservar el dtype de salida no certifica precisión fraccional extendida.

## Ejes vacíos conservados en NumPy 2.5.4

Una dimensión de longitud cero conservada puede dar un resultado vacío válido.
NumPy 2.5.4 corrige el reshape multieje que rechazaba algunas de estas llamadas.
LuaRay sigue ese comportamiento, incluida la dimensión del vector de fracciones.

```lua
local empty = lr.empty({0, 3, 4}, "float32")
local q = lr.quantile(empty, {0.25, 0.5}, {axis = {2, 3}})
assert(q.shape[1] == 2 and q.shape[2] == 0)
local median = lr.median(empty, {axis = {2, 3}, keepdims = true})
assert(median.shape[1] == 0 and median.shape[2] == 1 and median.shape[3] == 1)
assert(not median.flags.owndata)
```

## Selección de ejes vacía

`axis = {}` no selecciona ejes. Cada elemento existente se trata como una
porción de un elemento; las formas vacías conservadas siguen vacías. No equivale
a omitir `axis`. Una porción *reducida* vacía sigue rechazando cuantiles
ordinarios. Su mediana es NaN; LuaRay no reproduce las advertencias Python.

```lua
local empty = lr.empty({3, 0}, "float64")
local q = lr.quantile(empty, 0.25, {axis = {}})
assert(q.shape[1] == 3 and q.shape[2] == 0)
assert(not pcall(lr.quantile, empty, 0.25, {axis = 2}))
local median = lr.median(empty, {axis = 2})
assert(median.size == 3 and median[1] ~= median[1])
```

## Buffers de salida existentes

`out` debe tener la forma exacta y ser escribible. Una llamada correcta devuelve
ese mismo userdata. Se admiten `keepdims`, `axis`, `out` y los métodos anteriores;
no se implementan pesos ni modificación de la entrada como espacio de trabajo.

```lua
local output = lr.zeros({2}, "float64")
local result = lr.quantile(matrix, 0.5, {axis = 2, out = output})
assert(rawequal(result, output) and output[1] == 2 and output[2] == 5)
assert(not pcall(lr.quantile, matrix, 0.5, {axis = 2, out = lr.zeros({3})}))
assert(not pcall(lr.quantile, values, 0.5, {weights = {1, 1, 1, 1}}))
```

Las API siguen parciales. No se certifican paridad general de bits flotantes,
todos los dtypes, cuantiles ponderados, los métodos restantes, vectores de
fracciones vacíos, protocolos externos ni clases exactas de escalares,
excepciones y advertencias Python. La actualización a NumPy 2.5.4 tiene
referencias propias; los corpus históricos conservan su atribución original.

## Verificación de 0.158.0-dev

La migración a NumPy 2.5.4 aprobó **61 332 casos nuevos /617 872 comprobaciones**, más **2 700 casos históricos de cuantiles regenerados** (sus aserciones individuales no se incluyen en617 872). Incluye ejes conservados vacíos, selección vacía de ejes, orden K de medianas, vistas keepdims, promoción, álgebra lineal no finita y validación de acumulaciones. Otras130 comprobaciones Lua y la prueba nativa cubren keepdims escalar, vida de memoria y strides extremos en reducciones vacías. Los NaN se comparan por clasificación numérica y se omite padding x87. Los controles finitos de álgebra lineal usan tolerancia absoluta+relativa3e-6 para precisión simple y2e-12 para tipos amplios; la tolerancia histórica de cuantiles permanece0.002. Los cuatro corpus se regeneraron exactamente.

