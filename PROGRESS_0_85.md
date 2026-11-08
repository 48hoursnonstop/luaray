# LuaRay 0.85.0-dev — vectorized noncentral distributions

## Implemented

- `Generator.noncentral_chisquare(df, nonc, size)` accepts scalar, Lua-table, and ndarray parameters with NumPy-style broadcasting; supports 0-D arrays, multidimensional output, empty outputs and negative-stride/transpose views.
- `Generator.noncentral_f(dfnum, dfden, nonc, size)` accepts *three* independently broadcasted parameter inputs, including mixed scalar/array combinations.
- Both continue using the NumPy-ported C PCG64 sampling kernels without Python runtime and keep scalar entrypoints intact. Vector calls validate the complete parameter broadcast space before drawing, including requests for an empty output.

## Actually executed in this development environment

- `python3 tools/generate_random85_oracle.py`: generated **648 independent frozen NumPy 2.3.5 comparison cases**. SHA-256 equality before/after re-generation verified.
- `make random85-test`: PASS; 648/648 differential cases, including output values (relative/absolute tolerance 2e-12), shapes, float64 types and **exact next PCG64 word**. Also 16 invalid-parameter/no-draw checks, 20,000 empirical samples and the runnable example.
- `make -j8 full-test`: PASS, **99/99 differential fixture files** and existing native C/Lua tests.
- AddressSanitizer/UndefinedBehaviorSanitizer: PASS in targeted rebuild of `src/lua_module.c`, running both random85 suites against uninstrumented dependency objects. **Not** a whole-project sanitizer audit.
- Original NumPy 2.5.3 source file hashes verified using the user's upstream archive, pinned in `NUMPY_2_5_3_RANDOM85_FILE_HASHES.sha256`.

## Known differences / limitations

- The prior conservative noncentrality bound `nonc <= 1e12` remains in effect to avoid unchecked Poisson conversions. This is not an upstream NumPy limit.
- Scalar and vector `NaN` / infinite parameters are currently rejected (or not claimed compatible) even in cases where NumPy permits them. This release targets finite valid inputs and validates before drawing.
- Floating transcendental rounding is platform dependent. Matching oracle output under 2e-12 tolerance is not a general guarantee of bitwise portability.
- Only the two changed entrypoints were audited in detail; this is not a blanket claim of NumPy 2.5.3 API parity.
