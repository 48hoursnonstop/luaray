#include "ln_random.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
int main(void) {
ln_pcg64 r;
ln_pcg64_seed(&r,UINT64_C(42));
assert(ln_pcg64_hypergeometric(&r,5,5,4) == 2);
assert(ln_pcg64_next64(&r)==UINT64_C(12864169557245331597));
ln_pcg64_seed(&r,UINT64_C(42));
assert(ln_pcg64_hypergeometric(&r,15,15,15) == 7);
assert(ln_pcg64_next64(&r)==UINT64_C(15838336090824644132));
ln_pcg64_seed(&r,UINT64_C(42));
assert(ln_pcg64_hypergeometric(&r,150,250,10) == 3);
assert(ln_pcg64_next64(&r)==UINT64_C(15838336090824644132));
ln_pcg64_seed(&r,UINT64_C(42));
assert(ln_pcg64_hypergeometric(&r,150,250,11) == 4);
assert(ln_pcg64_next64(&r)==UINT64_C(15838336090824644132));
ln_pcg64_seed(&r,UINT64_C(42));
assert(ln_pcg64_hypergeometric(&r,150,250,390) == 147);
assert(ln_pcg64_next64(&r)==UINT64_C(15838336090824644132));
ln_pcg64_seed(&r,UINT64_C(42));
assert(ln_pcg64_hypergeometric(&r,999999999,1,900000000) == 899999999);
assert(ln_pcg64_next64(&r)==UINT64_C(15838336090824644132));
ln_pcg64_seed(&r,UINT64_C(17));
assert(ln_pcg64_hypergeometric(&r,1,99,50) == 0);
assert(ln_pcg64_next64(&r)==UINT64_C(10288570923761897802));
ln_pcg64_seed(&r,UINT64_C(1));
assert(ln_pcg64_hypergeometric(&r,0,50,35) == 0);
assert(ln_pcg64_next64(&r)==UINT64_C(10138214101031189034));
for(uint64_t seed=0;seed<16;seed++){
ln_pcg64 a,b; ln_pcg64_seed(&a,seed);ln_pcg64_seed(&b,seed);
for(int i=0;i<1000;i++){
int64_t g=(i%2)?300:120, bad=(i%3)?600:150, sample=(i%4)?20:180;
int64_t x=ln_pcg64_hypergeometric(&a,g,bad,sample);
int64_t y=ln_pcg64_hypergeometric(&b,g,bad,sample);
assert(x==y && x>=0 && x<=g && x<=sample);
}
assert(ln_pcg64_next64(&a)==ln_pcg64_next64(&b));
}
puts("distributions66 native tests passed"); return 0; }
