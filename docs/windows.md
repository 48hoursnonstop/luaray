---
docs_examples: true
---

# Window functions and sinc

`lr.bartlett(length)`, `lr.blackman(length)`, `lr.hamming(length)` and
`lr.hanning(length)` return symmetric tapering windows. Multiply a window
by a signal of the same length before taking its Fourier transform to
change its spectral leakage.

```lua
local lr = require("luaray")
local window = lr.hanning(5)
assert(lr.allclose(window, {0, 0.5, 1, 0.5, 0}))
local signal = lr.array({1, 2, 3, 4, 5})
assert(lr.allclose(lr.multiply(signal, window), {0, 1, 3, 2, 0}))
```

`lr.kaiser(length, beta)` uses the modified Bessel function `lr.i0(x)`.
The parameter `beta` controls how strongly the window tapers.
`lr.sinc(x)` evaluates the normalized sinc, with value one at zero and
`sin(pi*x)/(pi*x)` elsewhere.

```lua
assert(lr.array_equal(lr.kaiser(5, 0), {1, 1, 1, 1, 1}))
assert(lr.allclose(lr.i0({0, 1}), {1, 1.26606587775}))
assert(lr.allclose(lr.sinc({0, 0.5, 1}), {1, 2/math.pi, 0}))
```

Window lengths are normally integers. A length of one gives a window
containing one, and zero or a negative length gives an empty window.
`i0` accepts real inputs and preserves existing floating dtypes. `sinc`
also accepts complex inputs.

## Validation

**1,059 cases / 35,879 checks** passed with NumPy 2.5.5. The checks cover five window functions, Bessel I0 and normalized sinc with typed scalars, strided arrays, finite and nonfinite inputs and floating dtypes.
