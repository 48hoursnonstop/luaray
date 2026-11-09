# LuaRay 0.69.0-dev progress

## Delivered

- Native `Generator.dirichlet(alpha, size)` with NumPy 2.5.3's
  Gamma normalization and Beta stick-breaking for tiny concentrations.
- Lua table and numeric-ndarray concentration vectors; multidimensional
  batch shapes, empty vectors, all-zero parameters and zero-sized shapes.
- Differential oracle (`tests/generate_distributions69_oracle.py`) and
  checked-in fixture (`tests/distributions69_differential_generated.lua`).
- 9,582 exact Dirichlet comparisons to NumPy 2.3.5, including post-PCG64
  state, interleaved draws and validation error cases.
- `make full-test`: **82/82** differential fixture files passing.
- Directed ASan/UBSan native C regression passing with leak detection.
- Attribution and SHA-256 upstream source pinning.

## Not yet implemented

- Broadcasting of distribution input parameters beyond accepted scalar
  or one-dimensional vector forms.
- General complete coverage of NumPy random Generator and RandomState.
- Portability qualification across different libc/libm and architectures.

See `README.md` and `TEST_RESULTS.md` for reproducibility and scope.
