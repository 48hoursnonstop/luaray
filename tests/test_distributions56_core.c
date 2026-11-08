#include "ln_random.h"
#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

static uint64_t bits(double x) { uint64_t u; memcpy(&u, &x, sizeof(u)); return u; }

int main(void)
{
    ln_pcg64 r,a,b;
    ln_pcg64_seed(&r,42);
    assert(bits(ln_pcg64_gumbel(&r,-2.5,.25))==UINT64_C(0xc004cb267d89971a));
    assert(ln_pcg64_next64(&r)==UINT64_C(0x705a5661a791ffc1));
    ln_pcg64_seed(&r,42);
    assert(bits(ln_pcg64_logistic(&r,2.25,3.))==UINT64_C(0x4017c4f934a63fe3));
    assert(ln_pcg64_next64(&r)==UINT64_C(0x705a5661a791ffc1));
    ln_pcg64_seed(&r,42);
    assert(bits(ln_pcg64_rayleigh(&r,.125))==UINT64_C(0x3fd18ae02667631e));
    assert(ln_pcg64_next64(&r)==UINT64_C(0x705a5661a791ffc1));
    ln_pcg64_seed(&r,42);
    assert(bits(ln_pcg64_weibull(&r,3.))==UINT64_C(0x3ff56f32cab2cfcf));
    assert(ln_pcg64_next64(&r)==UINT64_C(0x705a5661a791ffc1));
    ln_pcg64_seed(&r,42);
    assert(ln_pcg64_weibull(&r,0.)==0.);
    assert(ln_pcg64_next64(&r)==UINT64_C(0xc621fbcd16d92688));
    ln_pcg64_seed(&a,421);ln_pcg64_seed(&b,421);
    for (int i=0;i<10000;i++) {
        double x=ln_pcg64_rayleigh(&a,2.5);
        double y=2.5*sqrt(2.*ln_pcg64_standard_exponential(&b));
        assert(bits(x)==bits(y));
        x=ln_pcg64_weibull(&a,3.);
        y=pow(ln_pcg64_standard_exponential(&b),1./3.);
        assert(bits(x)==bits(y));
    }
    assert(ln_pcg64_next64(&a)==ln_pcg64_next64(&b));
    puts("distributions56 native sampler tests passed");
    return 0;
}
