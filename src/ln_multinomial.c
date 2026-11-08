/* NumPy 2.5.3 multinomial sequential-binomial sampler (BSD-3-Clause).
 * Values and PCG64 state follow random_multinomial in distributions.c.
 * Caller validates n, pvals and zero-initializes the output. */
#include "ln_random.h"
#include <stdint.h>
#include <stddef.h>

void ln_pcg64_multinomial(ln_pcg64 *rng, int64_t n, const double *pvals,
                           size_t k, size_t nvariates, int64_t *out)
{
    for(size_t i=0; i<nvariates; i++) {
        double remaining_p=1.0;
        int64_t dn=n;
        int64_t *v=out+i*k;
        for(size_t j=0; j+1<k; j++) {
            v[j]=ln_pcg64_binomial(rng,dn,pvals[j]/remaining_p);
            dn-=v[j];
            if(dn<=0) break;
            remaining_p-=pvals[j];
        }
        if(dn>0) v[k-1]=dn;
    }
}
