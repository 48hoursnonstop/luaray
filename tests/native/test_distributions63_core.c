#include "ln_random.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
int main(void) {
    const double ns[]={0.125,0.5,1,2,3.25,5,10,100,1000,1000000};
    const double ps[]={0.001,0.01,0.1,0.25,0.5,0.75,0.99,1.0};
    ln_pcg64 a,b;
    for(int seed=0;seed<16;seed++){
        ln_pcg64_seed(&a,(uint64_t)seed);
        ln_pcg64_seed(&b,(uint64_t)seed);
        for(int k=0;k<4000;k++){
            double n=ns[(unsigned)k%10],p=ps[(unsigned)(k*7)%8];
            int64_t x=ln_pcg64_negative_binomial(&a,n,p);
            int64_t y=ln_pcg64_negative_binomial(&b,n,p);
            assert(x>=0 && x==y);
        }
        assert(ln_pcg64_next64(&a)==ln_pcg64_next64(&b));
    }
    ln_pcg64_seed(&a,42);ln_pcg64_seed(&b,42);
    /* Unlike a trivial constant shortcut, p=1 consumes Gamma bits. */
    assert(ln_pcg64_negative_binomial(&a,2.0,1.0)==0);
    assert(ln_pcg64_next64(&a)!=ln_pcg64_next64(&b));
    puts("distributions63 native tests passed");
    return 0;
}
