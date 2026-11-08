# LuaRay 0.74.0-dev — Generator.choice

## Implemented

- `Generator.choice(a, size=nil, replace=true, p=nil, axis=1, shuffle=true)`, implemented directly in C in `src/lua_module.c` using LuaRay's PCG64.
- Both replacement modes and optional 1-D weights. Floyd hash-set, tail shuffle for populations >10,000, and weighted `np.unique` first-appearance sampling semantics.
- Works with integer populations, Lua list inputs, 0-D integer ndarrays, multidimensional/strided populations, multidimensional samples, scalar vs shape-0 output, positive and negative axes (Lua indices start at 1), and supported ndarray dtypes.
- Preserves dtype and source immutability when sampling from ndarray or Lua list.

## Tests executed

- `make choice74-test`: passed Lua regression, example, and 4,650 differential NumPy 2.3.5 cases with data/dtype/shape and next PCG64 comparison. Includes dense/sparse/nonuniform probabilities, replacement and without, `shuffle`, large-population tail branch, empty shapes and arbitrary axes.
- `make full-test`: passed; 88/88 independent differential fixtures and native/Lua tests.
- Instrumented Lua API object with ASan/UBSan passed the 4,650 differential cases; the complete ASan/UBSan project rebuild timed out (backend uninstrumented).

## Limitations

- Lua call syntax uses **1-based axes** and positional optional arguments, not Python keyword syntax.
- Scalar uint64 population sizes exceeding Lua signed int64 range are not supported; extreme allocations remain bounded by available memory.
- `p` must be a numeric Lua table or a numeric 1-D ndarray. Python object arrays and Python-specific index protocols are outside the native Lua API.
- Behavioral parity is tested against installed NumPy 2.3.5; NumPy 2.5.3 is the pinned source target. No claim of exhaustive compatibility or complete random-module parity.
