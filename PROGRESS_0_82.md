# LuaRay 0.82.0-dev — Wald/logseries broadcasting

## Changes

- `Generator.wald(mean, scale, size)` now accepts Lua tables and native ndarrays with right-aligned shape broadcasting, transposed/negative-stride input views, and explicit multidimensional sizes. Uses the existing native float64 Wald sampler for each element in C order; positive infinity is accepted as in NumPy; zero, negative values and NaN are rejected before drawing.
- `Generator.logseries(p, size)` similarly accepts vectorized parameters, output dtype `int64`, and validates all probability elements (`0 <= p < 1`, finite) before consuming PCG64. Zero-sized output and scalar/0-D parameters are supported.
- Scalar calls are left on their preexisting code paths; no changes were made to core sampling algorithms or PCG64 implementation.

## Tests actually executed

- `tools/generate_random82_oracle.py` produced 483 independent NumPy 2.3.5 cases covering seven seeds, varied parameters and broadcasted sizes, including zero-length outputs. Fixture checks nested results (1e-12 tolerance), shape, dtype and **exact next raw PCG64 word**. `tests/random82_differential_generated.lua`: 483/483 pass.
- `tests/random82_regression.lua`: 16 expected-invalid arguments rejected without advancing PCG64, matrix and reversed-view shape/dtype checks and 40,000 generated scalar samples (wide statistical mean thresholds): passed.
- `examples/random82.lua`: executed successfully.
- Development-tree `make -j8 full-test`: passed, all 96 checked-in differential fixture files plus C/Lua regression targets.
- Directed ASan/UBSan instrumentation of `src/lua_module.c`, with remaining linked objects uninstrumented: new regression and differential suites passed with leak detection enabled. This is not a whole-project sanitizer audit.

## Limits

- Executable oracle is installed NumPy 2.3.5. NumPy 2.5.3 is the pinned source reference (`NUMPY_2_5_3_RANDOM82_FILE_HASHES.sha256`). LuaRay does not load Python at runtime.
- Existing scalar algorithms are reused; generalized vectorization of other random functions and whole-project audit remain unfinished.
- Source-port compatibility is not yet complete. Floating-point results may vary in low bits across libm/platforms.
