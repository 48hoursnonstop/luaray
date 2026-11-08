/* NumPy 2.5.3 Generator.dirichlet, _generator.pyx (BSD-3-Clause).
 * For small alphas, right-to-left accumulated concentration and beta
 * stick-breaking avoid underflow/0/0 in gamma normalization.
 * Caller supplies a zero-filled output array and validates alpha/size. */
#include "ln_random.h"
#include <stddef.h>


void ln_pcg64_dirichlet(ln_pcg64 *rng, const double *alpha,
                        size_t k, size_t nvariates, double *out, double *scratch)
{
    if (k == 0 || nvariates == 0) return;
    double maxalpha = alpha[0];
    for (size_t j=1; j<k; ++j)
        if (alpha[j] > maxalpha) maxalpha = alpha[j];
    if (maxalpha < 0.1) {
        double *csum = scratch;
        double sum = 0.0;
        for (size_t j=k; j-- > 0;) {
            sum += alpha[j];
            csum[j] = sum;
        }
        if (sum > 0.0) {
            for (size_t i=0; i<nvariates; i++) {
                double acc=1.0;
                double *v=out+i*k;
                for (size_t j=0; j+1<k; j++) {
                    double b=ln_pcg64_beta(rng,alpha[j],csum[j+1]);
                    v[j]=acc*b;
                    acc*=1.0-b;
                    if (csum[j+1]==0.0) break;
                }
                v[k-1]=acc;
            }
        }
    } else {
        for (size_t i=0; i<nvariates; i++) {
            double acc=0.0;
            double *v=out+i*k;
            for (size_t j=0; j<k; j++) {
                v[j]=ln_pcg64_standard_gamma(rng,alpha[j]);
                acc+=v[j];
            }
            double invacc=1.0/acc;
            for (size_t j=0; j<k; j++) v[j]*=invacc;
        }
    }
}
