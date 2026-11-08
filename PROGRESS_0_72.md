# LuaRay 0.72.0-dev — verification and status

## Implemented

- `Generator.permutation` for integral sizes, ndarray and table inputs.
- `Generator.shuffle` for ndarray and dense Lua table in-place shuffling.
- Native 32-/64-bit masked rejection `ln_pcg64_interval`, conserving RNG state.
- 1-based Lua axis mapping; multidimensional/empty arrays; strided views;
  numeric, boolean and fixed-width Unicode dtypes.
- NumPy parity when `permutation` shuffles a nonempty axis within an
  otherwise empty multidimensional array (the index vector still consumes RNG).

## Real executions performed

1. Native C test: 60 NumPy golden permutations plus 20 high-range interval
   cases, including exact next-PCG64 raw values. Passed.
2. Lua differential test: 2,948 independently generated NumPy 2.3.5 cases,
   74,552 assertions/checks across shapes, dtypes, axes, strides, and source
   immutability. Passed.
3. Lua invariant/error regression test: passed.
4. Example `examples/random_shuffle72.lua`: executed successfully.
5. `make full-test`: 85/85 checked-in differential fixture files passed,
   along with the native tests and regressions.
6. Directed `-fsanitize=address,undefined` on modified random C sampler and
   new C fixture passed. Full-project sanitizer build timed out, so there is
   no full-project sanitizer claim.

## Boundaries

- Source target: NumPy 2.5.3; executable reference: NumPy 2.3.5.
- Not yet included: `Generator.permuted`, `Generator.choice` and vectorized
  parameters across many other random distributions.
- Lua tables are sequence-like, not a general mutable Python object adapter.
- Overlapping-memory ndarray views need additional aliasing tests.
- No claim of platform-independent bit-for-bit behavior.

Build/replay does not require Python or NumPy. To regenerate oracle tests only:
`python3 tools/generate_shuffle72_oracle.py`.
