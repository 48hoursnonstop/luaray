# LuaRay 0.92.0-dev — ndarray.astype memory-order and copy audit

## Implementation

- Extended both `np.astype(array, dtype, opts)` and `array:astype(dtype, opts)` with `opts.copy` (boolean, default `true`) and `opts.order` (`C`, `F`, `A`, `K`, default `K`). Previous casting-string and `{casting=...}` syntax remains supported.
- With `copy=false`, return the exact same Lua ndarray userdata when the dtype and requested memory order already match. Otherwise allocate and convert, preserving the source.
- Support NumPy-like `K` physical memory-axis ordering when copying noncontiguous/transposed/negative-stride views; `A` selects Fortran for F-only inputs and C otherwise.
- Reject invalid `copy` and `order` option types/values.
- Existing descriptor-level `np.can_cast` implementation was audited without altering its rules.

## Tests actually executed (NumPy 2.3.5 executable oracle)

- `tests/dtype92_differential_generated.lua`: **2,304/2,304** NumPy-derived cases; checks output dtype, each stride, every element and Lua array identity across six source dtypes, eight input layouts, six target dtypes, four memory orders and both copy modes.
- `tests/dtype92_can_cast_differential_generated.lua`: **2,420/2,420** dtype-pair / casting-rule cases, including numeric, Unicode, bytes, datetime and timedelta descriptors.
- `tests/dtype92_regression.lua`: identity and copying on contiguous, transposed and reversed views; conversion rules and negative cases: passed.
- Development-tree `make -j8 full-test`: **107/107** differential fixture files, all earlier C and Lua tests: passed.
- Targeted ASan+UBSan build of `src/lua_module.c` passed the new regression and both differential suites, with `detect_leaks=0` (other linked objects were not instrumented).
- NumPy 2.5.3 source files and SHA-256 recorded in `NUMPY_2_5_3_DTYPE92_FILE_HASHES.sha256` from user-provided upstream archive.

## Limits

- Tested only built-in supported DTypes. User-defined/structured/object DTypes are not yet implemented.
- `copy=false` returns the same LuaRay `ndarray` userdata (rather than a CPython object). Not all NumPy subclass semantics apply.
- No full-project sanitizer audit or multi-platform compatibility proof.
