# LuaRay 0.84.0-dev — Binomial-family vectorization

## Implemented

- `Generator.binomial(n,p,size)` and `Generator.negative_binomial(n,p,size)` accept Lua tables and NumPy-style ndarrays as broadcastable parameters, including int64 count arrays, float32 probability arrays, transposed/reversed views, 0-D arrays, multidimensional explicit `size`, and empty outputs.
- Uses existing native PCG64 inversion/BTPE and Gamma-Poisson samplers in C-order. Integer `int64` results; no Python runtime.
- Validates every broadcast parameter before drawing, even for size-zero outputs; invalid calls do not consume random bits. Rejects floating `ndarray` count inputs for binomial to match NumPy's integer-array casting rules.
- Existing scalar calls remain on the tested scalar paths.

## Verified by execution

- `tests/random84_differential_generated.lua`: **750/750** independently frozen NumPy 2.3.5 cases with exact values, shapes, int64 dtype and following PCG64 64-bit word.
- Oracle reproducibility: re-generated the fixture with `tools/generate_random84_oracle.py`; bytewise SHA-256 identical.
- `tests/random84_regression.lua`: **25** negative cases without PCG64 advancement, shape/view regressions and **40,000** empirical samples.
- `examples/random84.lua`: executed successfully.
- `make -j8 full-test`: **98/98** checked-in differential fixture files plus C/Lua regression targets passed.
- Targeted AddressSanitizer/UndefinedBehaviorSanitizer compilation for `src/lua_module.c`, linked to normal dependencies: differential and regression suites passed (not a whole-codebase sanitizer audit).

## Constraints

- `binomial` retains scalar defensive limit `n <= 1e12`; `negative_binomial` retains `n <= 1e6` and `p >= 0.001` to avoid unsafe output conversion. These are LuaRay implementation limits, not NumPy API limits.
- Floating `ndarray` n is rejected for `binomial`; a Python list of fractional n values is handled differently by NumPy and a Lua table is not a perfect substitute for a Python object.
- NumPy 2.5.3 is the source baseline (SHA256 in `NUMPY_2_5_3_RANDOM84_FILE_HASHES.sha256`); available executable reference is NumPy 2.3.5. Matching PCG64 and sample values is platform-dependent for libm edge cases.
- Full NumPy coverage and whole-project sanitizer compliance are not claimed.
