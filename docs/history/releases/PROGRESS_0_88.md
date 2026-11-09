# LuaRay 0.88.0-dev — `standard_normal` and `standard_exponential` output buffers

## Implemented

- `Generator.standard_normal(size=nil, dtype="float64", out=nil)` supports writing into a provided `ndarray`, preserving its object identity and checking shape/dtype/contiguity/writeability/alignment before PCG64 is advanced.
- `Generator.standard_exponential(size=nil, dtype="float64", method="zig", out=nil)` supports the same output-buffer interface for both `zig` and `inv`, separately for native `float32` and `float64` kernels.
- Both C- and Fortran-contiguous `out` arrays are supported. Fortran arrays are filled in physical memory order, as in NumPy; this is different from a C-order logical traversal.
- No Python/NumPy runtime dependency; the existing C Ziggurat/inverse kernels remain intact.

## Executed tests

- Differential reference: NumPy 2.3.5; 1,008 cases compare values, dtype, shape, output object identity, and the next PCG64 word.
- Rejection tests: 14 invalid combinations; all verified not to advance PCG64.
- `make random88-test`: PASS.
- `make -j8 full-test`: PASS, 102/102 differential fixture files plus C/Lua tests.
- ASan/UBSan instrumented `src/lua_module.c`, with other objects uninstrumented: PASS for 1,008 cases and 14 rejection tests; not a project-wide sanitizer audit.
- Independent tests include zero-sized and 0-dimensional outputs, explicit/implicit size, scalar returns, Fortran transposes and both exponential methods.
- Regenerate new oracle with `python3 tools/generate_random88_oracle.py` in a development environment with NumPy 2.3.5.

## Limits

- Only native-endian float32 and float64 output dtypes are supported.
- Non-contiguous or negative-stride outputs are rejected as in the upstream fill path. Other NumPy random API gaps remain.
- The source of NumPy 2.5.3 was used for interface comparison; executable differential comparison used NumPy 2.3.5.
