#include "ln_random.h"
#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
int main(void)
{
    ln_pcg64 w, l, r;
    ln_pcg64_seed(&w, 42);
    ln_pcg64_seed(&l, 42);
    ln_pcg64_seed(&r, 42);
    /* Compare stream consumption from the reference generator. */
    double d=ln_pcg64_wald(&w, 1.0, 1.0);
    assert(d>0.0 && fabs(d-0.7381927415603216)<1e-15);
    assert(ln_pcg64_next64(&w)==UINT64_C(15838336090824644132));
    assert(ln_pcg64_logseries(&l, 0.0)==1);
    (void)ln_pcg64_next_double(&r);
    assert(ln_pcg64_next64(&l)==ln_pcg64_next64(&r));
    ln_pcg64_seed(&r, 17);
    double wald_sum=0.0, logseries_sum=0.0;
    enum {N=100000};
    for(int i=0; i<N; i++) {
        double val=ln_pcg64_wald(&r, 1.7, 2.2);
        assert(isfinite(val) && val>0.0);
        wald_sum += val;
        int64_t count=ln_pcg64_logseries(&r, 0.8);
        assert(count>=1);
        logseries_sum += (double)count;
    }
    /* Statistical sanity checks supplement, not replace, exact fixtures. */
    double wmean=wald_sum/N;
    double lmean=logseries_sum/N;
    double expected_log=-0.8/((1.0-0.8)*log1p(-0.8));
    assert(fabs(wmean-1.7)<0.04);
    assert(fabs(lmean-expected_log)<0.12);
    printf("100000 Wald samples: mean %.6f (expected 1.700000)\n",wmean);
    printf("100000 logseries samples: mean %.6f (expected %.6f)\n",lmean,expected_log);
    puts("distributions70 native tests passed");
    return 0;
}
