# LuaRay 0.86.0-dev — Student-t, von Mises, triangular parameter broadcasting

## Implemented

- `Generator.standard_t(df, size)` now accepts NumPy-style broadcastable Lua tables, 0-D or multidimensional `ndarray` parameters, transposed and negative-stride views. Positive, zero, negative, nonfinite parameters preserve the native NumPy-ported sampler behavior where compatible.
- `Generator.vonmises(mu, kappa, size)` broadcasts its two parameters, using the existing PCG64 native implementations of small / middle / large concentration regimes and rejection sampling.
- `Generator.triangular(left, mode, right, size)` broadcasts three independent numeric parameters, including mixed scalars and arrays. Validates the entire parameter space before consuming any PCG64 state. Three-way shape logic is shared with previous noncentral distribution support.
- Scalar Lua calls retain the original scalar entrypoints and their algorithmic behavior. Native Lua + C execution; no Python runtime bridge.

## Executed tests (this release)

- `python tools/generate_random86_oracle.py`: **990** independent NumPy 2.3.5 comparisons; SHA-256 of generated fixture unchanged by re-generation.
- `make random86-test`: PASS. 990/990 differential cases compare values (tolerance 8e-12), `float64` dtype, shapes and **exact next PCG64 word**; includes NaN/Inf, empty outputs, transposed and reversed views, scalar and arrays.
- Regression: **24** invalid calls rejected before random consumption; **30,000** actual samples checked for empirical moments and bounds; executable Lua example passed.
- `make -j8 full-test`: PASS; **100/100** differential fixture files plus previous C and Lua tests.
- Targeted AddressSanitizer / UndefinedBehaviorSanitizer: PASS for `src/lua_module.c` when running regression and the 990-case fixture, linked to **uninstrumented** dependency objects. Not a whole-project sanitizer audit.
- Upstream `numpy/random/_generator.pyx` and `numpy/random/src/distributions/distributions.c` NumPy 2.5.3 SHA-256 verified against the provided source tarball.

## Known limits

- NumPy 2.3.5 is the executable reference available in this environment; NumPy 2.5.3 is the source reference. Unprobed changes between these releases are not claimed compatible.
- Floating-point transcendentals and LAPACK-dependent paths can vary by platform; differential checks are bounded numerical comparisons rather than a universal bit-for-bit guarantee.
- The scope of this release is broadcasting for three existing native samplers, not full parity with all `numpy.random` functionality.
