# LuaRay 0.91.0-dev — DType promotion compatibility

## Implemented

- Added public `np.promote_types(dtype1, dtype2)` using the native `ln_promote_dtype` DType-class/descriptor promotion mechanism.
- Added public `np.result_type(...)` over dtype names, existing ndarrays and weak Lua booleans, integers, floating-point values and `np.complex` scalars.
- Preserved NumPy 2.x's **n-ary dtype-kind promotion**. A naive left-fold wrongly infers `float64` for `int8`, `uint16`, `float16`; the NumPy-compatible result is `float32`.
- Returns canonical LuaRay dtype-name strings rather than CPython's `numpy.dtype` objects. No Python is involved at runtime.
- Both functions work for supported string and datetime/timedelta descriptor pairs as exercised by the fixture.

## Executed verification

- Python-generated frozen NumPy 2.3.5 differential fixture: **3,556 cases** comprising **3,468 matching results** and **88 expected rejections**, including all 14^3=2,744 three-way numeric dtype combinations.
- Independent 0.91 Lua regression: passes, including examples with weak scalar behavior, nested combinations, datetime and invalid inputs.
- `make -j8 full-test`: **105/105 differential fixture files**, plus prior native C and Lua regressions: passed.
- `make dtype91-test`: passed.
- NumPy 2.5.3 source files recorded in `NUMPY_2_5_3_DTYPE91_FILE_HASHES.sha256` (upstream-source reference). NumPy 2.3.5 is the executable fixture oracle.

## Limitations

- LuaRay's dtype names are strings instead of Python dtype objects. `np.promote_types` expects two dtype names rather than type objects.
- `np.result_type` supports dtype names, native ndarrays and supported Lua numeric scalars, not arbitrary Lua tables or user-defined DTypes.
- No guarantee of bitwise identity across unknown/custom/structured dtypes. More dtype descriptor variants remain to be implemented.
- `result_type`'s kind-sorted reduction has only been differential-tested on the listed numeric and selected parametric cases; it is not a complete certification of NumPy's DType system.
