# LuaRay 0.80.0-dev — Standard Gamma broadcasting and independent dtype paths

## Implemented

- Expanded `Generator.standard_gamma(shape, size=nil, dtype="float64")` from scalar-only shapes to numeric Lua tables and native ndarrays, using existing right-aligned broadcast rules.
- Supports broadcasted shapes with float32, float64 and integer ndarray data, including strided/transposed/reversed views. `size` may be inferred from shape or supplied explicitly.
- Preserves the two independent NumPy C standard-gamma sampling algorithms: `ln_pcg64_standard_gamma()` for float64 and `ln_pcg64_standard_gamma_f()` for float32. Output is a true typed ndarray. A scalar 0-D input without explicit size returns a Lua scalar.
- Validates every parameter before allocating/sampling; invalid parameters do not consume PCG64. Handles empty output size without drawing random values.

## Executed verification

- `tools/generate_random80_oracle.py` generated 1,000 reproducible independent NumPy 2.3.5 cases; checks include sampled values (2e-12 float64 and 2e-6 float32 tolerance), shapes, types and exact next raw PCG64 word. 1,000/1,000 PASS.
- `tests/random80_regression.lua`: 7 negative test scenarios and invalid-size/no-PCG64-advance checks; PASS.
- `tests/random80_statistical.lua`: 120,000 sampled values across both dtypes, empirical mean and variance checks at shapes 1, 2, 5; PASS.
- `examples/random80.lua`: executed; PASS.
- `make -j8 full-test` (development tree): PASS, 94 differential fixtures plus all historical C and Lua regressions.

## Limitations

- NumPy supports `out` for this function; current Lua binding has not yet exposed that fourth method parameter.
- NaN and infinity in shape ndarrays are intentionally rejected even though NumPy accepts nonfinite cases; their draw-state fidelity is not established.
- Frozen test reference executes NumPy 2.3.5, pinned source is NumPy 2.5.3; numerical rounding can vary with compiler/libm.
- Full-project sanitizer coverage is not claimed.
