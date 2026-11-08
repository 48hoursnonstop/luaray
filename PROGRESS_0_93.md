# LuaRay 0.93.0-dev — scalar DType audit

## Implementation

- Added `np.min_scalar_type(value)` for native Lua boolean, signed 64-bit integer, numeric floating-point and LuaRay complex scalars; preserves the source dtype for LuaRay ndarrays and temporal scalar userdata.
- NumPy-compatible integer width boundaries (`int8/16/32/64` for negative values, `uint8/16/32/64` for nonnegative values) and Python float range thresholds (`65000`, `3.4e38`). Handles NaN and infinity for native floating-point scalars.
- Follows the scalar selection logic in NumPy 2.5.3 `convert_datatype.c` (source hashes recorded).
- Audited preexisting `astype(order=..., copy=...)` on additional empty, singleton, permuted, and flipped 1D/3D views; no change needed for the 1,488 cases compared.

## Actual executed verification

- NumPy 2.3.5 reference: **4,557/4,557** new `min_scalar_type` differential cases (integer boundaries and random 64-bit values; float magnitudes, NaN/inf; complex magnitudes; ndarray DType identity, bool).
- NumPy 2.3.5 reference: **1,488/1,488** additional `astype` layout differential comparisons (strides, data, copy identity).
- Frozen fixtures regenerated with the included Python generators and SHA-256 compared byte-for-byte.
- `make -j8 full-test`: **109/109** differential fixture files, plus C and Lua regression suites, passed in development extraction.
- Targeted AddressSanitizer + UndefinedBehaviorSanitizer on `src/lua_module.c`: both new differential suites passed, leak detection disabled; other linked objects not instrumented.

## Explicit limitations

- Native Lua strings are not yet supported as Unicode scalars by `min_scalar_type`; arrays with string DTypes preserve their descriptor.
- No CPython dtype object or NumPy subclass semantics; LuaRay returns a DType name string.
- `min_scalar_type` covers values representable in standard Lua 5.4 and LuaRay complex scalar userdata, not arbitrary-precision Python ints or all NumPy scalar classes.
- Full-library sanitizer and cross-platform audits remain open.
