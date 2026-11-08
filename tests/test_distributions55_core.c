#include "ln_random.h"
#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

static uint64_t bits(double x) { uint64_t v; memcpy(&v,&x,sizeof(v)); return v; }

int main(void) {
    ln_pcg64 r;
    ln_pcg64_seed(&r,42);
    assert(bits(ln_pcg64_lognormal(&r,0.,1.))==UINT64_C(0x3ff5b32a03def96e));
    assert(ln_pcg64_next64(&r)==UINT64_C(0x705a5661a791ffc1));
    ln_pcg64_seed(&r,42);
    assert(bits(ln_pcg64_standard_cauchy(&r))==UINT64_C(0xbfd2c08a136db696));
    assert(ln_pcg64_next64(&r)==UINT64_C(0xdbcd12c26eda1624));
    ln_pcg64_seed(&r,42);
    assert(bits(ln_pcg64_laplace(&r,-2.,.75))==UINT64_C(0xbff679346e6a54fc));
    assert(ln_pcg64_next64(&r)==UINT64_C(0x705a5661a791ffc1));
    ln_pcg64 a,b;
    ln_pcg64_seed(&a,1234);ln_pcg64_seed(&b,1234);
    for(int i=0;i<2000;i++) {
        double x=ln_pcg64_lognormal(&a,0.25,2.);
        double expected=exp(0.25+2.*ln_pcg64_standard_normal(&b));
        assert(bits(x)==bits(expected));
    }
    assert(ln_pcg64_next64(&a)==ln_pcg64_next64(&b));
    ln_pcg64_seed(&a,9876);ln_pcg64_seed(&b,9876);
    for(int i=0;i<2000;i++) {
        double x=ln_pcg64_standard_cauchy(&a);
        double left=ln_pcg64_standard_normal(&b),right=ln_pcg64_standard_normal(&b);
        assert(bits(x)==bits(left/right));
    }
    assert(ln_pcg64_next64(&a)==ln_pcg64_next64(&b));
    puts("distributions55 native sampler tests passed");
    return 0;
}
