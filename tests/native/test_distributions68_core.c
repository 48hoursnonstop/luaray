#include "ln_random.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
int main(void) {
    const double p[]={0.2,0.3,0.5};
    const int64_t expected[]={5,5,10,6,6,8,2,11,7,5,7,8,2,6,12,3,9,8};
    ln_pcg64 rng;ln_pcg64_seed(&rng,42);
    int64_t out[18]={0};
    ln_pcg64_multinomial(&rng,20,p,3,6,out);
    assert(memcmp(out,expected,sizeof(out))==0);
    assert(ln_pcg64_next64(&rng)==UINT64_C(11877215088116289030));
    for(int seed=0;seed<8;seed++){
        ln_pcg64_seed(&rng,(uint64_t)seed);
        double pp[]={0.0,0.0,0.5,0.01};
        int64_t v[400]={0};
        ln_pcg64_multinomial(&rng,50,pp,4,100,v);
        for(int i=0;i<100;i++){
            int64_t sum=0;
            for(int j=0;j<4;j++){assert(v[i*4+j]>=0);sum+=v[i*4+j];}
            assert(sum==50);
        }
    }
    puts("distributions68 native tests passed");
    return 0;
}
