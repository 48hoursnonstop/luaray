# LuaRay 0.89.0-dev — vectorized `Generator.integers`

## Implemented

- `low` and `high` can be Lua integers, numeric tables, or native ndarray arguments. Both bounds broadcast using right-aligned axes; an explicit `size` takes precedence and must be compatible. If `high=nil`, array-valued `low` acts as the upper bound and the lower bound is zero.
- Preserves nine integer/bool dtypes (`int8`, `uint8`, `int16`, `uint16`, `int32`, `uint32`, `int64`, `uint64`, `bool`), optional `endpoint`, `size`, zero-sized output, signed/unsigned bounds, zero-dimensional ndarray scalar results and negative-stride bounds.
- Reads signed integer ndarray values losslessly (including values beyond 2**53), rather than converting them to double. Uses the existing bounded integer kernels and per-call small-type cache to reproduce PCG64.
- Performs elementwise validation before the first random draw and returns errors without consuming PCG64 on invalid populated bounds.

## Executed tests

- NumPy 2.3.5 generated reference: **4,782/4,782** passing calls, with results, shape, dtype and next PCG64 value compared. `python3 tools/generate_random89_oracle.py` regenerates the reference.
- `make random89-test`: PASS; eleven rejected inputs, an independent scalar/shape/endpoints regression and a standalone Lua example.
- `make -j8 full-test`: PASS with **103/103** differential fixture files and all prior C/Lua regressions.
- Targeted sanitizer of `src/lua_module.c` with ASan/UBSan: PASS on all new cases. All dependencies were linked without sanitizer instrumentation; this is not a full-project audit.
- NumPy 2.5.3 source hashes independently confirmed against the original tarball.

## Limitations / planned follow-up

- Fortran-transposed ndarray bounds have a known differential **value-placement mismatch** for certain shapes. This special view ordering remains unsupported for exact NumPy parity; it was not included in the 4,782 passing calls. Contiguous and negative-stride cases tested successfully.
- The Lua numeric scalar model cannot express exact `uint64` bounds above `INT64_MAX`; this case is rejected rather than rounded. Large integer values in *numeric Lua tables* first undergo a `float64` ndarray conversion; for exact integers beyond 2**53 use an `int64` ndarray.
- Some discrepancies in validation of empty-output and exotic dtype representations remain possible. NumPy 2.5.3 is the source reference; NumPy 2.3.5 is the executable oracle.
- Whole-project memory sanitizer pass is outstanding.
