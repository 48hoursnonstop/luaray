# LuaRay 0.70.0-dev — executed progress

Two native NumPy 2.5.3 Generator distributions were added:

- `wald(mean, scale, size=nil)` — float64, inverse Gaussian sampler using
  `random_standard_normal` plus the PCG64 acceptance uniform.
- `logseries(p, size=nil)` — int64 logarithmic-series sampler using the
  branch-equivalent NumPy rejection method.

Implementation: `src/ln_random.c`, `src/ln_random.h`, `src/lua_module.c`.
Native Lua interface supports scalar parameters and array-valued `size`,
including empty and zero-dimensional arrays. No Python runtime.

## Executed verification

- NumPy 2.3.5 independent oracle: **10,144/10,144** exact comparisons
  (values, dtypes, shapes, PCG64 post-state, interleaving and invalid
  arguments). NumPy 2.5.3 supplied the reference algorithm.
- Native C regression executed, including a deterministic stream check and
  **100,000 Wald + 100,000 logseries samples**. Sample means for `wald(1.7,
  2.2)` and `logseries(0.8)` were **1.701796** and **2.496120**, versus
  theoretical **1.700000** and **2.485340**.
- Lua API regression and executable example completed successfully.
- Clang AddressSanitizer / UndefinedBehaviorSanitizer with leak detection:
  native random sampler and new C tests passed; **not** whole-project
  sanitizer coverage.
- `make full-test` completed with **83/83** differential fixture files.
- Upstream NumPy 2.5.3 hashes recorded in
  `NUMPY_2_5_3_WALD_LOGSERIES_FILE_HASHES.sha256`.

## Limitations

No parameter broadcasting for `wald` or `logseries`; validations are
explicit, not complete NumPy argument coercion. Matching expected numerical
outputs on the tested platform does not guarantee bit-identical behavior
on every operating system or compiler.
