---
docs_examples: true
---

# Ventanas y función sinc

`lr.bartlett(length)`, `lr.blackman(length)`, `lr.hamming(length)` y
`lr.hanning(length)` devuelven ventanas simétricas de atenuación. Multiplica
una ventana por una señal de la misma longitud antes de calcular su
transformada de Fourier para modificar su fuga espectral.

```lua
local lr = require("luaray")
local window = lr.hanning(5)
assert(lr.allclose(window, {0, 0.5, 1, 0.5, 0}))
local signal = lr.array({1, 2, 3, 4, 5})
assert(lr.allclose(lr.multiply(signal, window), {0, 1, 3, 2, 0}))
```

`lr.kaiser(length, beta)` usa la función de Bessel modificada
`lr.i0(x)`. El parámetro `beta` controla cuánto atenúa la ventana.
`lr.sinc(x)` evalúa la sinc normalizada, con valor uno en cero y
`sin(pi*x)/(pi*x)` en el resto del dominio.

```lua
assert(lr.array_equal(lr.kaiser(5, 0), {1, 1, 1, 1, 1}))
assert(lr.allclose(lr.i0({0, 1}), {1, 1.26606587775}))
assert(lr.allclose(lr.sinc({0, 0.5, 1}), {1, 2/math.pi, 0}))
```

Las longitudes de las ventanas suelen ser enteras. Una longitud de uno
da una ventana con un solo uno. Una longitud cero o negativa devuelve
una ventana vacía. `i0` admite entradas reales y conserva el dtype
flotante de la entrada. `sinc` también admite entradas complejas.

## Validación

Aprobaron **1 059 casos / 35 879 comprobaciones** con NumPy 2.5.5. Las pruebas cubren cinco ventanas, la función de Bessel I0 y la sinc normalizada con escalares tipados, arreglos con strides, valores finitos y no finitos y dtypes flotantes.
