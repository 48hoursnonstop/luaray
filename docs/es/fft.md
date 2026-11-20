---
docs_examples: true
---
# Transformadas de Fourier

Usa `lr.fft` para transformar señales muestreadas. LuaRay ejecuta las
transformadas nativas con PocketFFT. Los ejes positivos empiezan en 1 y los
negativos cuentan desde el final.

## Transformar y recuperar una señal real

`rfft` almacena los intervalos de frecuencia no negativos de una señal real
como valores complejos. Al aplicar `irfft`, pasa la longitud original para
conservar las longitudes impares.

```lua
local lr = require("luaray")
local signal = lr.array({1, 2, 4, 2, 1}, "float64")
local spectrum = lr.fft.rfft(signal)
assert(spectrum.size == 3)
local restored = lr.fft.irfft(spectrum, { n = signal.size })
assert(lr.allclose(restored, signal))
```

Usa `fft` e `ifft` para trabajar con un espectro complejo completo. Con la
normalización predeterminada `"backward"`, la inversa incluye el escalado por
longitud. La [guía de funciones FFT](fft_helpers.md) explica los argumentos,
las salidas, las frecuencias, los desplazamientos y las transformadas hermitianas.

## Transformar dos dimensiones

```lua
local image = lr.array({{1, 2}, {3, 4}}, "float64")
local frequencies = lr.fft.fft2(image)
assert(lr.allclose(lr.fft.ifft2(frequencies), image))
```

Consulta [ventanas y sinc](windows.md) para ponderar muestras y
[convolución](convolution.md) para calcular convoluciones directas y
correlaciones cruzadas.
