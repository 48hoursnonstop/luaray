# LuaRay 0.87.0-dev — vectorized Zipf and hypergeometric

## Implemented

- `Generator.zipf(a, size)` supports broadcasting over Lua tables and ndarray parameters, including float32, float64, integer, transposed, reversed and multidimensional views. Zipf still returns int64 values and preserves native C Zipf rejection sampling and PCG64 order. `a=+inf` is accepted.
- `Generator.hypergeometric(ngood, nbad, nsample, size)` broadcasts three independent parameters and uses the original C hypergeometric direct/HRUA samplers. For a numeric Lua table, fractional counts truncate toward zero before validation, like NumPy sequences; a float dtype ndarray remains invalid, whereas integral/bool ndarrays are accepted. Count bounds preserve the prior 0.86 scalar limits.
- All broadcast parameters are validated before random draws, even for zero-sized outputs, and a zero-dimensional broadcast without explicit size returns a scalar.
- Native Lua + C runtime; NumPy/Python only used to generate independent test data.

## Executed verification

- NumPy 2.3.5 reference generator: **1,380 independent calls**, with C-order output values, int64 dtype, shape and next PCG64 word checked. Seeds include 0, 1, 2, 3, 42, 1234, and large values; paths include zero-dimension outputs, transposed and reversed arrays, extreme Zipf concentration, scalar and sequence values, non-integral sequences and boolean int arrays.
- `make random87-test`: PASS. 19 negative-input/no-PCG64-consumption regression cases; 20,000 sampled values with moment / support assertions; Lua API example PASS.
- `make -j8 full-test`: PASS, **101/101 differential fixture files**, native C and Lua regressions.
- ASan/UBSan targeted at the modified `src/lua_module.c` with other dependency objects uninstrumented: PASS on random87 regression and 1,380 differential cases; not a whole-project sanitizer audit.
- Upstream NumPy 2.5.3 `_generator.pyx` and `distributions.c` SHA-256 verified directly against the user-provided NumPy tarball; see `NUMPY_2_5_3_RANDOM87_FILE_HASHES.sha256`.

## Current limits

- Executable oracle is NumPy 2.3.5; NumPy 2.5.3 was audited as source. This release does not imply complete compatibility with every upstream version or dtype.
- Retains the NumPy-like `<1e9` counts bound on ngood and nbad; ignores potential numpy longdouble-specific conversion behavior.
- All-project ASan/UBSan execution remains outstanding. This release only vectorizes two already implemented samplers, not the full `numpy.random` surface.
