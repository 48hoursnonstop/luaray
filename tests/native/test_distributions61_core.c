#include "ln_random.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>

int main(void) {
    ln_pcg64 r;
    const double lam[]={0.0,0.5,9.999999,10.0,10.000001,100.0,1000000.0,1000000000000.0};
    const int64_t first[]={0,1,15,13,13,109,1000845,1000000845379LL};
    const uint64_t next[]={UINT64_C(0xc621fbcd16d92688),UINT64_C(0x20cc0e168362d113),
        UINT64_C(0xc973e041cbfde031),UINT64_C(0x718397ca8ba13e23),
        UINT64_C(0x718397ca8ba13e23),UINT64_C(0x5eec9e8b80171029),
        UINT64_C(0x20cc0e168362d113),UINT64_C(0x20cc0e168362d113)};
    for(size_t j=0;j<sizeof(lam)/sizeof(lam[0]);j++) {
        ln_pcg64_seed(&r,42);
        assert(ln_pcg64_poisson(&r,lam[j])==first[j]);
        for(int i=1;i<4;i++) (void)ln_pcg64_poisson(&r,lam[j]);
        assert(ln_pcg64_next64(&r)==next[j]);
    }
    for(int seed=0;seed<20;seed++) {
        ln_pcg64 a,b;
        ln_pcg64_seed(&a,(uint64_t)seed);ln_pcg64_seed(&b,(uint64_t)seed);
        for(int i=0;i<500;i++) assert(ln_pcg64_poisson(&a,0.0)==0);
        assert(ln_pcg64_next64(&a)==ln_pcg64_next64(&b));
        for(int i=0;i<500;i++) {
            double rate=(i%3)==0?0.1:((i%3)==1?9.9:1000.0);
            assert(ln_pcg64_poisson(&a,rate)==ln_pcg64_poisson(&b,rate));
        }
        assert(ln_pcg64_next64(&a)==ln_pcg64_next64(&b));
    }
    puts("distributions61 native tests passed");
    return 0;
}
