#include "ln_random.h"
#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
static uint64_t bits(double x){uint64_t v;memcpy(&v,&x,8);return v;}
static uint32_t bitsf(float x){uint32_t v;memcpy(&v,&x,4);return v;}
int main(void){
    ln_pcg64 r,a,b;
    ln_pcg64_seed(&r,42);
    assert(bits(ln_pcg64_standard_gamma(&r,0.125))==UINT64_C(0x3fc07ab7617da636));
    assert(ln_pcg64_next64(&r)==UINT64_C(0xdbcd12c26eda1624));
    ln_pcg64_seed(&r,42);
    assert(bits(ln_pcg64_gamma(&r,2.,3.))==UINT64_C(0x40191a100a28102f));
    assert(ln_pcg64_next64(&r)==UINT64_C(0xdbcd12c26eda1624));
    ln_pcg64_seed(&r,42);
    assert(bits(ln_pcg64_beta(&r,2.,3.))==UINT64_C(0x3fd5a88a20b42051));
    assert(ln_pcg64_next64(&r)==UINT64_C(0x181c01b5339381eb));
    ln_pcg64_seed(&r,42);
    assert(bits(ln_pcg64_beta(&r,1e-110,1e-110))==0);
    assert(ln_pcg64_next64(&r)==UINT64_C(0x705a5661a791ffc1));
    ln_pcg64_seed(&r,42);
    assert(bitsf(ln_pcg64_standard_gamma_f(&r,2.))==UINT32_C(0x3feda71f));
    assert(ln_pcg64_next64(&r)==UINT64_C(0x705a5661a791ffc1));
    /* Compare identical drawing order between compositional paths. */
    ln_pcg64_seed(&a,315);ln_pcg64_seed(&b,315);
    for(int i=0;i<10000;i++){
        double shape=(i%3==0)?0.125:(i%3==1?1.:3.5);
        double x=ln_pcg64_gamma(&a,shape,2.5);
        double y=2.5*ln_pcg64_standard_gamma(&b,shape);
        assert(bits(x)==bits(y));
    }
    assert(ln_pcg64_next64(&a)==ln_pcg64_next64(&b));
    puts("distributions58 native tests passed");return 0;
}
