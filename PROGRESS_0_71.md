# LuaRay 0.71.0-dev — verified progress

Implemented native `Generator.standard_t(df, size=nil)` and
`Generator.vonmises(mu, kappa, size=nil)`, matching NumPy 2.5.3's C sampling
algorithms for scalar parameters. Stream-consuming PCG64 functions,
zero-dimensional and multidimensional shapes are covered.

## Verification executed

- NumPy 2.3.5 oracle: **2,538 independent cases / 16,074 strict exact
  assertions**, including normal-vs-Gamma draw sequence, von Mises branches
  `kappa < 1e-8`, `1e-8 <= kappa < 1e-5`, `1e-5 <= kappa <= 1e6` and
  `kappa > 1e6`, exceptional input values and post-sample PCG64 state.
- New native C test: 100,000 draws per sampler, deterministic stream
  agreement and statistical estimates.
- New Lua regression and runnable example passed.
- `make full-test`: all **84/84 differential fixtures passed**, along with
  the rest of the project tests.
- Directed Clang ASan and UBSan on the modified C random sampler passed
  with leak detection enabled. Not whole-project sanitizer certification.

## Limitations

Distribution arguments must be scalar Lua numbers; parameter broadcasting
and fully identical argument conversion semantics are not implemented.
Bit-identical results are verified only in the local tested environment,
not guaranteed for every CPU, C library or compiler.
