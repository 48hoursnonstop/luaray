# LuaRay 0.99.1-dev — float32 inverse-exponential portability

The first Ubuntu 24.04 CI of 0.99 failed an unchanged exact exponential fixture:
1.0481541156768799 versus 1.0481542348861694. The new masked-write corpus had
already passed there. The failure was reproduced by directly loading the official
Ubuntu glibc 2.39 libm, extracted under .dev after SHA-256 validation, and comparing
the exact PCG64 float32 inputs. No system library was installed or replaced.

Three discrepancies at seed-zero draws 11/14/16 were checked with 80-digit Decimal
arithmetic. Evaluating -log1p(-u) in double and rounding to float32 agrees with
those references. PCG64 inputs, consumption and next raw word are unchanged.
No frozen values or tolerances were weakened. The full Arch binary cannot load
Ubuntu's older libc ABI; real Ubuntu validation was instead provided by GitHub.

- Corrected-code CI run **42526947924** on **965203b** passed all **116 fixture
  files**, native/Lua tests and both public dynamic-module examples on Ubuntu.
- Local Arch full-test passed, including **17,376 unchanged exact exponential
  comparisons** and four explicit rounding/next-state assertions.
- Release-version metadata assertions now require 0.99.1; numeric data untouched.
- The release gate performs a fresh extraction, native rebuild, full regression,
  public examples and manifest/SHA validation. Its report/log records final output.
- Directed sanitizer scope for this patch additionally instruments ln_random;
  other dependencies remain uninstrumented and leak detection remains disabled.
  The actual run log records whether this added gate passed.

This is a precision/portability correction to the tested inverse-exponential
path. It is not a promise of universal libm/CPU bit identity or complete NumPy
compatibility. Prior blocked dtype states and subsystem limits remain.
English/Spanish explanation: docs/{en,es}/portability.md. tools/probe_libm.py
reproduces the three library comparisons without NumPy.

Next native take work is isolated on branch take100 at .dev/take100; do not include
unfinished sources in this patch archive. Keep verified release archives immutable.
