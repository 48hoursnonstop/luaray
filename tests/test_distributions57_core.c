#include "ln_random.h"
#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

static uint64_t bits(double x) { uint64_t u; memcpy(&u,&x,sizeof(u));return u; }

int main(void)
{
    ln_pcg64 r,a,b;
    ln_pcg64_seed(&r,42);
    assert(bits(ln_pcg64_pareto(&r,2.))==UINT64_C(0x40029dec455fb40a));
    assert(ln_pcg64_next64(&r)==UINT64_C(0x705a5661a791ffc1));
    ln_pcg64_seed(&r,42);
    assert(bits(ln_pcg64_power(&r,2.))==UINT64_C(0x3fee853914e85e89));
    assert(ln_pcg64_next64(&r)==UINT64_C(0x705a5661a791ffc1));
    ln_pcg64_seed(&r,42);
    assert(bits(ln_pcg64_triangular(&r,-2.,0.,5.))==UINT64_C(0x40017f7f306e0c3a));
    assert(ln_pcg64_next64(&r)==UINT64_C(0x705a5661a791ffc1));

    ln_pcg64_seed(&a,421);ln_pcg64_seed(&b,421);
    for(int i=0;i<10000;i++){
        double x=ln_pcg64_pareto(&a,.125);
        double y=expm1(ln_pcg64_standard_exponential(&b)/.125);
        assert(bits(x)==bits(y));
        x=ln_pcg64_power(&a,3.);
        y=pow(-expm1(-ln_pcg64_standard_exponential(&b)),1./3.);
        assert(bits(x)==bits(y));
        x=ln_pcg64_triangular(&a,-2.,0.,5.);
        double u=ln_pcg64_next_double(&b);
        double base=7.,leftbase=2.,ratio=leftbase/base;
        y=u<=ratio?-2.+sqrt(u*(leftbase*base)):5.-sqrt((1.-u)*(5.*base));
        assert(bits(x)==bits(y));
    }
    assert(ln_pcg64_next64(&a)==ln_pcg64_next64(&b));
    puts("distributions57 native sampler tests passed");
    return 0;
}
