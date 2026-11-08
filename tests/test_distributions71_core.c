#include "ln_random.h"
#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>

int main(void)
{
    ln_pcg64 rng;
    ln_pcg64_seed(&rng,42);
    double t=ln_pcg64_standard_t(&rng,3.0);
    assert(fabs(t-0.6174653977237295)<1e-15);
    assert(ln_pcg64_next64(&rng)==UINT64_C(12864169557245331597));

    ln_pcg64_seed(&rng,42);
    double angle=ln_pcg64_vonmises(&rng,1.0,2.5);
    assert(fabs(angle-2.4074451126221064)<1e-14);
    assert(ln_pcg64_next64(&rng)==UINT64_C(12864169557245331597));

    ln_pcg64_seed(&rng,7);
    double s_t=0.0,s_t2=0.0,s_cos=0.0,s_sin=0.0;
    enum { COUNT = 100000 };
    for(int i=0;i<COUNT;i++){
        double x=ln_pcg64_standard_t(&rng,5.0);
        assert(isfinite(x));
        s_t+=x;s_t2+=x*x;
        double a=ln_pcg64_vonmises(&rng,0.8,4.0);
        assert(isfinite(a) && a>=-3.141592653589794 && a<=3.141592653589794);
        s_cos+=cos(a);s_sin+=sin(a);
    }
    double mean=s_t/COUNT, var=s_t2/COUNT-mean*mean;
    assert(fabs(mean)<0.04);
    assert(fabs(var-5.0/3.0)<0.10);
    /* Direction of circular mean should recover prescribed mu. */
    double direction=atan2(s_sin,s_cos);
    assert(fabs(direction-0.8)<0.04);
    printf("100000 standard_t(5): mean %.6f var %.6f; 100000 vonmises(0.8,4): circular mean %.6f\n",mean,var,direction);
    puts("distributions71 native tests passed");
    return 0;
}
