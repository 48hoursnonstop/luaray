---
docs_examples: true
---
# Fourier transforms

Use `lr.fft` to transform sampled signals. LuaRay uses PocketFFT for the
native transforms. FFT axes follow LuaRay's positive one-based and negative
from-the-end conventions.

## Transform a real signal and recover it

`rfft` stores the nonnegative frequency bins of a real signal as complex values.
When applying `irfft`, pass the original length to preserve odd lengths.

```lua
local lr = require("luaray")
local signal = lr.array({1, 2, 4, 2, 1}, "float64")
local spectrum = lr.fft.rfft(signal)
assert(spectrum.size == 3)
local restored = lr.fft.irfft(spectrum, { n = signal.size })
assert(lr.allclose(restored, signal))
```

Use `fft` and `ifft` for a full complex spectrum. With the default
`"backward"` normalization, the inverse includes the length scaling. The
[FFT helpers](fft_helpers.md) guide covers arguments, output arrays, frequency
bins, spectrum shifts and Hermitian transforms.

## Transform two dimensions

```lua
local image = lr.array({{1, 2}, {3, 4}}, "float64")
local frequencies = lr.fft.fft2(image)
assert(lr.allclose(lr.fft.ifft2(frequencies), image))
```

See [windows and sinc](windows.md) for sample weighting and
[convolution](convolution.md) for direct convolution and cross-correlation.
