#include "ln_random.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
int main(void){
    const double alphas[]={1.2,1.5,2.0,3.0,5.0,10.0,1025.0,2000.0};
    ln_pcg64 x,y;
    for(uint64_t seed=0;seed<16;seed++){
        ln_pcg64_seed(&x,seed);ln_pcg64_seed(&y,seed);
        for(int i=0;i<2000;i++){
            double a=alphas[(i+seed)%8];
            int64_t u=ln_pcg64_zipf(&x,a),v=ln_pcg64_zipf(&y,a);
            assert(u>=1 && u==v);
        }
        assert(ln_pcg64_next64(&x)==ln_pcg64_next64(&y));
    }
    ln_pcg64_seed(&x,42);ln_pcg64_seed(&y,42);
    assert(ln_pcg64_zipf(&x,1025)==1);
    assert(ln_pcg64_next64(&x)==ln_pcg64_next64(&y));
    puts("distributions65 native tests passed");
    return 0;
}
