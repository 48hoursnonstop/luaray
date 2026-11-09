---
docs_examples: true
---
# Matrices de Vandermonde

Una matriz de Vandermonde organiza las potencias de cada valor de entrada en
columnas. Sirve para evaluar y ajustar polinomios.

## Firmas

| Llamada | Comportamiento |
| --- | --- |
| `lr.vander(x)` | Matriz cuadrada con potencias decrecientes. |
| `lr.vander(x, n, increasing)` | Selecciona el número y orden de las columnas. |
| `lr.vander(x, {n=..., increasing=true})` | Tabla de opciones; `n` va en minúscula. |

`x` debe ser unidimensional. El número de columnas predeterminado es su longitud.
`n` debe ser un entero Lua no negativo e `increasing` un booleano.
Si se omite, `increasing` vale false.

## Construye potencias decrecientes

```lua
local lr = require("luaray")
local x = lr.array({1, 2, 3}, "int32")
local powers = lr.vander(x)
assert(powers.shape[1] == 3 and powers.shape[2] == 3)
assert(powers:get(2, 1) == 4)
assert(powers:get(2, 2) == 2 and powers:get(2, 3) == 1)
```

Las columnas contienen `x^(n-1), ..., x, 1`. Las potencias se generan por
multiplicación acumulada en el dtype promovido del resultado. La columna
constante vale uno incluso con entradas cero, infinitas o NaN.

## Cambia el orden o número de columnas

```lua
local increasing = lr.vander(x, {n=4, increasing=true})
assert(increasing:get(2, 1) == 1)
assert(increasing:get(2, 4) == 8)
assert(lr.vander(x, 0).shape[2] == 0)
```

El orden creciente contiene `1, x, x^2, ...`. Cero columnas producen una matriz
vacía. El resultado tiene almacenamiento nuevo, escribible y en orden C, incluso
si la entrada está invertida, tiene strides o es de solo lectura.

El dtype es el común entre la entrada y el entero nativo. En la plataforma
probada de 64 bits, los enteros estrechos y booleanos pasan a int64, float32 a
float64 y complex64 a complex128. Mezclar uint64 con el entero nativo con signo
produce float64, como en NumPy: los valores unsigned grandes pueden redondearse.

## Ajusta un polinomio cuadrático

```lua
local samples = lr.array({0., 1., 2.}, "float64")
local values = lr.array({1., 4., 9.}, "float64")
local coefficients = lr.linalg.solve(lr.vander(samples), values)
assert(math.abs(coefficients[1] - 1) < 1e-12)
assert(math.abs(coefficients[2] - 2) < 1e-12)
assert(math.abs(coefficients[3] - 1) < 1e-12)
```

El orden decreciente asigna los coeficientes a `x^2`, `x` y la constante.
El ejemplo recupera `x^2 + 2x + 1`.

## Compatibilidad

Disponible desde **0.120.0-dev**. Las referencias exactas cubren formas, promoción
de dtype, strides, conservación de entrada, escritura, enteros y valores
flotantes especiales. Los casos aleatorios generales flotantes/complejos usan
una tolerancia relativa fijada previamente de `3e-15`; los metadatos y referencias
ordinarias siguen siendo exactos.

Las cadenas y timedelta pueden producir matrices de cero o una columna, como
en la referencia. Con más columnas requieren un bucle de multiplicación
acumulada: esos dtypes producen un error incluso con entradas vacías. Datetime
no tiene un dtype común con el entero nativo.

Objetos, estructuras, dispatch externo, protocolos de subclases/advertencias
Python y todos los ABI siguen fuera del contrato verificado. La API mantiene
[compatibilidad parcial](api_inventory.md).
