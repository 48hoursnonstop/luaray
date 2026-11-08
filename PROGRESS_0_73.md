# LuaRay 0.73.0-dev — verified development

## Native implementation

`numpy.random.Generator.permuted` is implemented in `src/lua_module.c`:
- independent PCG64 Fisher–Yates shuffle for each axis fiber;
- storage-order flattening when axis is absent;
- optional same-shape writable `out`, safe numerical casts and aliases;
- 1-based Lua axes; vector/table inputs; multiple native dtype families.

## Actual execution

- `make permuted73-test`: passed.
- `make full-test`: passed, 87/87 frozen differential fixtures.
- NumPy 2.3.5 frozen independent oracle: 11,244 regular cases plus
  120 extra dtype cases (Unicode, bytes, complex, float16, datetime).
- Matched next PCG64 values for each reference case.
- ASan/UBSan full native rebuild timed out, so no sanitizer claim.

## Scope and limits

Pinned original implementation is NumPy 2.5.3. Python is used solely for
regenerating offline oracle fixtures. No Python at runtime. Memory-order
metadata for arbitrary non-contiguous out-of-place copies is not yet
NumPy-exact; contents and tested state are. There is no Python-style
`out=` keyword syntax in Lua.
