# LuaRay 0.78.0-dev — Additional Generator parameter broadcasting

## Implemented

- Native parameter broadcasting for `Generator.lognormal(mean, sigma, size)`, `laplace(loc, scale, size)`, `gumbel(loc, scale, size)`, `logistic(loc, scale, size)`, `rayleigh(scale, size)`, `weibull(a, size)`, `pareto(a, size)` and `power(a, size)`.
- Parameters may be Lua numeric tables or numeric ndarrays (including float32, float64 and signed integer input, transposed and negative-stride views). Right-aligned NumPy-style broadcasting; optional explicit `size` must match the broadcast result. Outputs are native float64 ndarrays, or Lua number for no `size` with a scalar result.
- Existing scalar sampling paths and the algorithms in `ln_random.c` remain untouched. The new path invokes the existing NumPy-compatible C samplers for each broadcasted output position, iterated in logical C order.
- Parameter validation happens before sampling, so invalid shape/domain requests do not advance PCG64. Zero-size outputs validate nonempty parameter arrays first. These eight distributions allow NaN parameters in vectorized paths, as NumPy does; negative scales or forbidden zero/negative shapes raise an error.

## Actual execution

- `make random78-test`: **PASS**, including an example executed in Lua.
- `tests/random78_differential_generated.lua`: **2,000/2,000** randomized independent NumPy 2.3.5 cases, checking numeric outputs (up to relative 8e-13), exact result shapes, and the exact subsequent PCG64 64-bit word. Includes multidimensional operands, transposed, reversed, float32, float64 and int64 inputs.
- `tests/random78_edge_generated.lua`: **114/114** NumPy cases covering NaN, infinity, tiny/huge parameters and zero-element outputs, including exact PCG64 continuation.
- `tests/random78_regression.lua`: **PASS**, with 11 invalid-input cases that must not consume RNG state.
- `tools/generate_random78_oracle.py` and `tools/generate_random78_edge_oracle.py`: produced byte-for-byte identical committed fixtures when re-executed using NumPy 2.3.5.
- `make -j6 full-test`: **PASS**, all **92/92** differential fixture suites, native C and Lua tests.
- Targeted ASan/UBSan: compiled `src/lua_module.c` with both sanitizers and ran the new regression and both NumPy fixture files. **PASS** with leak detection; other linked source objects were not sanitizer-instrumented.

## Limits

- This increment concerns only the eight listed distributions; others still have their prior scalar limitations. Their scalar-path behavior is preserved, including some stricter historical validation of NaN parameters.
- Differential test execution uses NumPy **2.3.5**; upstream source pinned to **2.5.3**. Math library/CPU variations may prevent cross-platform bit-for-bit floating-point identity even when PCG64 state matches.
- Does not provide Python keyword syntax, dtype objects or comprehensive `numpy.random` API parity.
