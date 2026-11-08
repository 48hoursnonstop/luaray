#ifndef LN_MULTIVARIATE_NORMAL_H
#define LN_MULTIVARIATE_NORMAL_H
#include <stddef.h>
/* cov and factor are n*n row-major float64. check: 0=ignore, 1=warn, 2=raise.
   method: 0=svd (NumPy default), 1=eigh, 2=cholesky.
   Returns 0 on success, -1 on failure, and sets *warning for an invalid
   covariance when check=warn and method is not cholesky. */
int ln_mvn_factor(const double *cov, size_t n, int method, int check,
                  double tol, double *factor, int *warning,
                  char *err, size_t errcap);
#endif
