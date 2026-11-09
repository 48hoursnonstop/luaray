#include "ln_random.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
static uint64_t bits(double x){uint64_t u;memcpy(&u,&x,8);return u;}
int main(void){
  ln_pcg64 r;
  ln_pcg64_seed(&r,42);
  assert(bits(ln_pcg64_noncentral_chisquare(&r,.5,20.))==UINT64_C(0x403f9c98968a1636));
  assert(ln_pcg64_next64(&r)==UINT64_C(0x181c01b5339381eb));
  ln_pcg64_seed(&r,42);
  assert(bits(ln_pcg64_noncentral_chisquare(&r,5.,4.))==UINT64_C(0x40277f4aa3744d08));
  assert(ln_pcg64_next64(&r)==UINT64_C(0xb286b60e1600888d));
  ln_pcg64_seed(&r,42);
  assert(bits(ln_pcg64_noncentral_f(&r,2.5,5.,20.))==UINT64_C(0x401eb476f6fc947b));
  assert(ln_pcg64_next64(&r)==UINT64_C(0xf9c262ed86c7538c));
  for(unsigned seed=0;seed<20;seed++){
    ln_pcg64 a,b;
    ln_pcg64_seed(&a,seed);ln_pcg64_seed(&b,seed);
    for(int i=0;i<1000;i++){
      double df=(i%2)?1.5:.5;
      assert(bits(ln_pcg64_noncentral_chisquare(&a,df,0.0))==bits(ln_pcg64_chisquare(&b,df)));
    }
    assert(ln_pcg64_next64(&a)==ln_pcg64_next64(&b));
  }
  puts("distributions60 native tests passed");
  return 0;
}
