# LuaRay 0.75.0-dev — Generator.multivariate_normal

## Implemented

- `Generator.multivariate_normal(mean, cov, size=nil, check_valid='warn', tol=1e-8, method='svd')` as native Lua/C. Uses NumPy 2.5.3's scalar/shape semantics, PCG64 Ziggurat draws, output float64, and dense LAPACK factorizations.
- `svd` via LAPACK DGESDD (NumPy default), `eigh` via DSYEVD, `cholesky` via DPOTRF. Correct factor orientation, `sqrt(abs(eigenvalues))` for the `eigh` method, and the default SVD reconstruction test for non-PSD covariance.
- Strict real-numeric, one-dimensional mean and square covariance; accepts Lua tables and LuaRay ndarrays including strided arrays and float32 inputs; optional multidimensional `size` including zero-dimensional samples.
- `check_valid`: `raise` errors on non-PSD matrices; `warn` emits a message on standard error; `ignore` continues with the factor. Cholesky rejects non-positive-definite matrices regardless of this option, like NumPy.
- Draws standard normals before factorization, maintaining PCG64 draw order even if a decomposition then fails.

## Tests executed

- **1,020 NumPy 2.3.5 differential cases** across `svd`/`eigh`/`cholesky`, dims 1–6, various seeds, float32 inputs, singular/near-singular/diagonal/correlated matrices, and multidimensional/empty `size`, comparing output data, dtype, shape, and the subsequent PCG64 state.
- Numerical comparisons use relative+absolute tolerance `2e-6`, including near-singular decompositions where NumPy's bundled LAPACK and system LAPACK produce small differences in eigenvectors/factors. Simple well-conditioned golden outputs are also verified to `1e-12`.
- Native C LAPACK-factor tests passed under AddressSanitizer and UndefinedBehaviorSanitizer with leak detection enabled. Includes positive-definite, indefinite, singular, 1x1, and invalid-dimension cases.
- Native Lua validation regression, independent 30,000-sample empirical mean/covariance check, and Lua example passed.
- `make full-test`: **89/89 differential fixtures** and previous native/Lua regressions passed in the development tree.

## Known limitations

- Lua optional arguments are positional; arrays and axes follow LuaRay conventions, not Python keyword syntax.
- No structured warning object: for `check_valid='warn'`, LuaRay emits a diagnostic to standard error, rather than Python's `RuntimeWarning` object.
- Results of singular and ill-conditioned decompositions can differ slightly between LAPACK implementations despite preserving statistical properties and PCG64 bit consumption. No exact bit-for-bit claim for output values across BLAS/LAPACK vendors.
- Nonfinite or complex mean/cov inputs are not a compatibility focus. No claim of full NumPy 2.5.3 coverage outside the verified cases.
