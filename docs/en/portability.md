# Numerical portability

LuaRay 0.99.1 corrects the float32 inverse-exponential path while preserving its
24-bit uniform input and exact PCG64 consumption. Older `log1pf` implementations
can differ by one float32 ULP. On Ubuntu glibc 2.39, seed zero's draw 11 produced
1.0481541156768799, whereas the frozen reference is 1.0481542348861694. An
80-digit Decimal calculation agrees with the latter; draws 14 and 16 exposed
two further differences.

The sampler now evaluates the same `-log1p(-u)` expression in double precision
and rounds once to float32. No fixture expectations or tolerances were changed.
The existing 17,376 exponential comparisons and explicit three-value/next-PCG64
regressions pass. Native GitHub CI run 42526947924 passed all 116 fixture files
and both public examples on Ubuntu 24.04; the local Arch regression also passed.
The versioned release gate and its later CI runs are recorded separately.

For diagnosis, `python3 tools/probe_libm.py /path/to/libm.so.6` loads only that
library in the current process and compares the three exact inputs to 80-digit
arithmetic. It needs no NumPy. The inspected official Ubuntu package was
`libc6_2.39-0ubuntu8.9_amd64.deb`, SHA-256
`ff5557d99b51f761c4b7c92368b9cc45565eda17df9bf9eb4b134d09825008be`.
It was extracted under `.dev` without installing or replacing system libraries.
Running the full Arch binary against that older libc is not ABI-compatible;
the successful Ubuntu run is real remote CI, not a local emulated full build.

This correction is limited to the tested inverse-exponential path. It does not
promise bit identity for every transcendental function, all libraries, CPU
targets or platforms. Existing API/dtype and original mismatch records remain.
