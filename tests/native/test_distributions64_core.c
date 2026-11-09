#include "ln_random.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
int main(void)
{
    const double probs[]={1e-18,0.000001,0.01,0.2,1.0/3.0,0.5,0.99,1.0};
    ln_pcg64 a,b;
    for(uint64_t seed=0;seed<16;seed++) {
        ln_pcg64_seed(&a,seed);ln_pcg64_seed(&b,seed);
        for(int k=0;k<4000;k++) {
            double p=probs[(unsigned)(k*7)%8];
            int64_t x=ln_pcg64_geometric(&a,p),y=ln_pcg64_geometric(&b,p);
            assert(x>=1 && x==y);
        }
        assert(ln_pcg64_next64(&a)==ln_pcg64_next64(&b));
    }
    ln_pcg64_seed(&a,42);ln_pcg64_seed(&b,42);
    assert(ln_pcg64_geometric(&a,1.0)==1);
    /* Even p=1 samples a uniform in NumPy search algorithm. */
    assert(ln_pcg64_next64(&a)!=ln_pcg64_next64(&b));
    puts("distributions64 native tests passed");
    return 0;
}
