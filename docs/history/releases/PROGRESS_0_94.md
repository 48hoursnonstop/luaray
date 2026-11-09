# LuaRay 0.94.0-dev — scalar-DType hierarchy and UTF-8 strings

## Implemented

- Added `np.issubdtype(left, right)` for the native DType classes represented by LuaRay names. The abstract NumPy scalar-class hierarchy is represented with strings such as `number`, `integer`, `signedinteger`, `floating`, `inexact`, `complexfloating`, `flexible`, `character` and `generic`. Leaf classes include `bool_`, `bytes_`, `str_`, `datetime64` and `timedelta64`.
- Comparisons respect signed/unsigned classes, exact numeric scalar types, temporal classes and string classes. Distinct concrete numeric precisions are not subclasses of one another.
- NumPy treats `timedelta64` as a subclass of signed integer and numeric scalar classes; this otherwise surprising behavior is preserved.
- `np.min_scalar_type(value)` now accepts native Lua UTF-8 string scalars, returning the fixed-width Unicode DType descriptor `<U{codepoint_count}>`, including `<U1` for an empty string. Embedded zero bytes and non-BMP Unicode are handled correctly; invalid UTF-8 is rejected.
- No Python interpreter is required at LuaRay runtime.

## Actual execution

- `tests/dtype94_differential_generated.lua`: 1,849 subtype comparisons covering 26 supported concrete dtype names and 17 scalar classes, plus 94 Unicode scalar cases: **1,943/1,943 passed** vs NumPy 2.3.5; five rejection checks also passed.
- `make -j6 full-test` in the development tree: **110/110 differential fixture files**, native C tests, Lua regressions passed.
- Targeted ASan/UBSan on the changed `src/lua_module.c`: **1,943/1,943 cases passed** with leak detection disabled; linked dependencies were not instrumented.
- The NumPy 2.5.3 source files corresponding to the scalar hierarchy and coercion logic were extracted from the supplied upstream tarball and hashed in `NUMPY_2_5_3_DTYPE94_FILE_HASHES.sha256`.
- The Python oracle can be regenerated independently via `python3 tools/generate_dtype94_oracle.py` (Python is a testing dependency only).

## Limitations

- The Lua API accepts dtype and abstract-class **names**, not NumPy Python class objects. Directly passing an ndarray to `issubdtype` is not supported; pass its `.dtype` field instead.
- Object, void and structured DType *instances*, third-party custom DTypes, and subclass hooks are not implemented. These class names are supported only as comparison categories where applicable.
- Invalid UTF-8 is rejected because Lua strings can contain arbitrary bytes while NumPy Python Unicode strings cannot.
- The project-wide, fully instrumented sanitizer audit remains pending.
