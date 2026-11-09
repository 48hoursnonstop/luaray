#include "ln_random.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>

int main(void) {
    ln_pcg64 a,b;
    const int64_t n[]={0,1,5,10,61,100,1000,100000,1000000000};
    const double p[]={0.0,1.0,0.0001,0.1,0.3,0.5,0.7,0.9,0.9999};
    for (int seed=0;seed<24;seed++) {
        ln_pcg64_seed(&a,(uint64_t)seed);
        ln_pcg64_seed(&b,(uint64_t)seed);
        for(int i=0;i<3000;i++) {
            int64_t trials=n[i%9];double prob=p[(i*7)%9];
            int64_t value=ln_pcg64_binomial(&a,trials,prob);
            assert(value>=0 && value<=trials);
            assert(value==ln_pcg64_binomial(&b,trials,prob));
        }
        assert(ln_pcg64_next64(&a)==ln_pcg64_next64(&b));
    }
    ln_pcg64_seed(&a,42);ln_pcg64_seed(&b,42);
    for(int i=0;i<10000;i++)assert(ln_pcg64_binomial(&a,0,0.5)==0);
    assert(ln_pcg64_next64(&a)==ln_pcg64_next64(&b));
    puts("distributions62 native tests passed");
    return 0;
}
