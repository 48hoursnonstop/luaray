# LuaRay 0.79.0-dev — Broadcast-aware rejection-sampling distributions

## Implemented

- Added native parameter broadcasting to `Generator.gamma(shape, scale=1, size=nil)`, `beta(a, b, size=nil)`, `chisquare(df, size=nil)` and `f(dfnum, dfden, size=nil)`.
- Accept numeric Lua tables and NumPy-style ndarrays, including `float32`, `float64`, `int64`, transposed and negative-stride views. Output dimensions are inferred by right-aligned broadcasting, or checked against explicit `size`.
- Data remain native LuaRay float64 arrays, and C samplers are the existing NumPy 2.5.3-based `ln_pcg64_gamma`, `ln_pcg64_beta`, `ln_pcg64_chisquare` and `ln_pcg64_f`. Each output is sampled in logical C order; no Python runtime or NumPy bridge.
- Input shape and domain are validated before sampling, including requests for empty output shapes; invalid arguments do not consume PCG64 draws. Scalar sampler paths were not changed.

## Verification performed

- `make random79-test`: pass, including **1,040** independently generated NumPy 2.3.5 differential cases (value/shape/type and exact subsequent PCG64 word), **48** special-case differential cases, 16 invalid-input/no-PCG64-advance tests, and a runnable Lua example.
- `make -j6 full-test`: pass, **93/93** differential fixture files and legacy C/Lua tests (development tree).
- Targeted AddressSanitizer/UndefinedBehaviorSanitizer on `src/lua_module.c`: pass for the regression, all 1,040 randomized cases and 48 edge cases. Other native modules were linked without sanitizer instrumentation.
- Oracle generators: `tools/generate_random79_oracle.py`, `tools/generate_random79_edge_oracle.py`.
- Upstream NumPy 2.5.3 code fingerprints: `NUMPY_2_5_3_RANDOM79_FILE_HASHES.sha256`.

## Remaining limitations

- The new vectorized routes deliberately reject NaN and infinite parameters, although NumPy accepts some nonfinite inputs; this requires independent testing of the special-value draw ordering before changing behavior. Historical scalar routes retain their prior validation policy.
- No broadcasting support is added to `standard_gamma(dtype=float32)` or other rejection samplers in this release.
- Differential fixtures use installed NumPy 2.3.5, with NumPy 2.5.3 as the pinned source reference; C library rounding can differ by platform.
- Full-project sanitizer coverage is not claimed.
