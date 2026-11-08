# LuaRay 0.83.0-dev — geometric and poisson broadcasting

## Implementation

- Added native Lua-to-C parameter broadcasting for `Generator.geometric(p, size)`
  and `Generator.poisson(lam, size)` through the existing numerical iterator.
- Supports Lua tables, float32/float64/int64 ndarray parameters, transposes,
  inverted strides, scalar/0-D arguments, explicit multidimensional and empty
  output shapes. Results use `int64` and PCG64 sampling in output C order.
- The existing geometric search/inversion and Poisson multiplication/PTRS
  samplers were not changed. Scalar routes remain compatible.
- All vector parameters are validated before sampling, including when the
  requested output size is zero. Geometric requires finite `0<p<=1`;
  Poisson requires finite `0<=lam<=1e12` (existing defensive cap).

## Execution

- 1,296 frozen cases from NumPy 2.3.5 via
  `tools/generate_random83_oracle.py` — exact samples/shapes/dtype and next
  PCG64 raw word, 12 seeds, multiple broadcast shapes and boundary regimes.
- 16 rejection/no-PCG64-consumption tests and 40,000 samples for empirical
  distribution checks; executable Lua example.
- `make -j8 full-test`: 97 differential fixture files passed, as did native
  tests and Lua regressions. Version assertions updated from 0.82 to 0.83.

## Limits

- NumPy 2.5.3 is the pinned source reference; available executable oracle is
  NumPy 2.3.5. Full NumPy API and entire-project sanitizer coverage are not
  claimed. Poisson >1e12 is still rejected as a conservative safety bound.
