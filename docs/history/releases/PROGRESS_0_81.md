# LuaRay 0.81.0-dev — standard_gamma nonfinite + out

## Implemented

- `Generator.standard_gamma(shape, size=nil, dtype="float64", out=nil)` now permits NaN and +Inf in scalar/array shape inputs (negative values and -Inf still reject). The original NumPy-standard Gamma rejection branch is invoked, including its PCG64 consumption for nonfinite inputs. No special-value shortcuts.
- Explicit `out` accepts native writable, C-contiguous float32/float64 ndarrays matching selected dtype and explicit size, or provides implicit `size` when size=nil. Returns the identical ndarray userdata, writes into its buffer and rejects bad shape/dtype/strides before sampling.
- Broadcast validation and complete parameter validation happen before sampling, even for zero-size outputs. Preserves separate float32 and float64 sampling paths.
- Previous 0.58 and 0.80 regression expectations updated for NaN/+Inf after verifying upstream behavior.

## Executed verification

- 1,500 independently generated NumPy 2.3.5 samples (standard gamma, finite/NaN/+Inf, both dtypes, scalar/ndarray/table and non-contiguous parameter views; positional out, size and state PCG64). All pass with numerical tolerance 2e-6 float32 / 2e-12 float64; PCG64 tail exact.
- 12 invalid-input cases rejected with no change in PCG64; runnable Lua example and output-identity assertions pass.
- Directed AddressSanitizer + UndefinedBehaviorSanitizer build of `src/lua_module.c`, running regression + all new 1,500 differential cases: pass. Underlying libraries were not sanitizer-instrumented.
- Development-tree `make -j12 full-test` passed, including 95 differential fixture files, native C and existing Lua regressions.

## Limitations

- Compiled NumPy executable comparison uses installed NumPy 2.3.5; source target is NumPy 2.5.3. Differences between math libraries/platforms may affect final digits.
- No complete whole-project memory-sanitizer audit or independent API inventory is claimed.
- The positional Lua API does not implement Python's keyword-argument syntax.
