# LuaRay 0.76.0-dev — Generator.bytes and random dtype/out

## Implemented

- `Generator.bytes(length)`: native binary Lua strings, little-endian packing of cached PCG64 uint32 draws exactly as NumPy 2.5.3 (`self.integers(..., dtype=uint32).astype('<u4').tobytes()`). Embedded `\0` bytes preserved. Even `bytes(0)` follows the upstream uint32-consumption behavior.
- `Generator.random(size=nil, dtype='float64', out=nil)`: float32 uses NumPy-compatible uint32 draw/cast (`next_uint32 >> 8`) rather than rounding a float64 result; existing float64 output preserved.
- `out` accepts an existing, writable, C-contiguous LuaRay ndarray with matching dtype and shape, or infers shape from `out` when `size=nil`. Same object is returned. Invalid `out` is rejected before consuming PCG64.

## Compatibility limitations

- Lua strings are binary-safe rather than Python `bytes`, and Lua float32 scalar values return the Lua numeric type, since Lua has no distinct float32 scalar.
- Negative byte lengths are rejected intentionally, whereas some NumPy 2.3.5 negative lengths can produce unusual values due to signed rounding. The valid API domain is nonnegative lengths.
- No Python keyword-argument syntax. `dtype` accepts the strings `float32` and `float64`.
- `out` must be C-contiguous; views with strides are rejected, consistent with NumPy's fill-function requirement.
- Python remains only an offline differential-test oracle: no runtime dependence.

## Tests

- `make random76-test`: stored NumPy 2.3.5 independent oracle fixture, explicit validation regression, and runnable example.
- `make full-test` also runs historical C and Lua tests and every differential fixture, including 0.76.
