# LuaRay 0.77.0-dev — Generator parameter broadcasting

## Implemented

- Native broadcasting of **numeric scalar, Lua-table, and ndarray parameters** for `Generator.normal(loc, scale, size)`, `Generator.uniform(low, high, size)`, and `Generator.exponential(scale, size)`. No Python runtime or NumPy shared library.
- Output shape is inferred by standard right-aligned NumPy broadcasting when `size=nil`. An explicit `size` must be compatible with the broadcast parameter dimensions. `size={}` produces a 0-dimensional ndarray if all operands are scalar-compatible.
- Numeric parameters can be `float32`, `float64`, signed integer, and boolean ndarrays. Reads use native dtype accessors, preserving transposed and negative-stride views without copying them.
- Output is `float64`; iteration and the PCG64 random draw sequence follow C-order logical output positions independent of input memory strides.
- Parameter shape and range validation run **before** any random draws. Validation examines parameter broadcast positions even if explicit output has zero elements, matching NumPy's invalid-scale behavior for `size=(0,)`.
- Pre-existing all-scalar implementation paths remain unchanged, preventing regressions in the established NumPy PCG64 oracle fixtures.

## Verification performed

- `make random77-test`: **PASS**; 1,560 independent NumPy 2.3.5 cases across scalar/table/ndarray inputs, multidimensional shapes, transposed and reversed views, `float32`, `float64` and `int64` parameters. Checks numeric results (relative tolerance `4e-13`), shape and exact next PCG64 64-bit word.
- `tests/random77_regression.lua`: **PASS**; direct samples and **nine** invalid-input cases verifying errors without advancing PCG64.
- `examples/random77.lua`: **PASS**; actually executed in native Lua runner.
- `tools/generate_random77_oracle.py`: independently regenerates the same fixture byte-for-byte using NumPy 2.3.5.
- `make -j6 full-test`: **PASS** in the development tree, including **91/91** differential test files plus existing C and Lua test targets.

## Boundaries

- Vectorized parameter support in this release is **only** for `normal`, `uniform`, and `exponential`. Other distributions still have scalar parameter limitations.
- Differential executable is NumPy 2.3.5, although the pinned upstream source is NumPy 2.5.3. This is not a full cross-platform bit-identity guarantee.
- No Python keyword-argument syntax, object dtype, or automatic Python-compatible `Generator` serialization. Invalid or overflowing bounds may have different error messages.
- Full-project ASan/UBSan coverage is **not** claimed for this release.
