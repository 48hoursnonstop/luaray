# LuaRay 0.90.0-dev — exact 64-bit table bounds and view-order audit

## Implementation

- `Generator.integers` recognizes all-integer Lua tables and creates an
  `int64` ndarray without any intermediary double conversion. This prevents
  lost low bits for `2**53 < n <= INT64_MAX` and respects `INT64_MIN`
  when expressed in Lua using `math.mininteger`.
- Mixed floating-point tables remain on the earlier float64 conversion path.
- Existing 8/16/32/64-bit bounded samplers and per-call caches are unchanged.
- Extensive new Fortran/transpose/flip/row/column/broadcast and wide signed
  bound differential coverage was generated from executable NumPy.

## Executed validation

- NumPy 2.3.5 differential: **5,880/5,880**, comparing all output values,
  dtypes, shapes and next PCG64 word; `tools/generate_random90_oracle.py`.
- Independent Lua regression: **11/11** checks, including four rejected
  ranges with unchanged PCG64, plus executable example.
- `make -j8 full-test`: PASS, **104/104** differential fixture files and all
  existing C/Lua regressions.
- Directed `src/lua_module.c` ASan/UBSan: PASS for both new test files.
- NumPy 2.5.3 upstream SHA-256 preserved and rechecked.

## Important constraints

- The Fortran-view mismatch noted by 0.89 was not reproduced in the larger
  0.90 oracle; the source of that earlier observation is not established.
  No unnecessary rewrite of the integer iteration algorithm was made.
- Lua numeric scalars cannot represent unsigned integers above INT64_MAX.
  Exact `uint64` upper bounds in that range remain unsupported.
- Lua floating-point *table* members undergo double conversion when mixed
  with non-integral floating-point members.
- Sanitizer instrumentation only covered the Lua API module and not the
  complete native dependency graph.
- NumPy 2.5.3 is source reference; installed NumPy 2.3.5 is executable oracle.
