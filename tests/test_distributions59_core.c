#include "ln_random.h"
#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
static uint64_t bits(double x){uint64_t v;memcpy(&v,&x,sizeof v);return v;}
int main(void){
  ln_pcg64 r,a,b;
  ln_pcg64_seed(&r,42);
  assert(bits(ln_pcg64_chisquare(&r,2.5))==UINT64_C(0x4003d8e8d0b12b86));
  assert(ln_pcg64_next64(&r)==UINT64_C(0xdbcd12c26eda1624));
  ln_pcg64_seed(&r,42);
  assert(bits(ln_pcg64_f(&r,3.,5.))==UINT64_C(0x3fe77bac5297cc01));
  assert(ln_pcg64_next64(&r)==UINT64_C(0x181c01b5339381eb));
  ln_pcg64_seed(&a,315);ln_pcg64_seed(&b,315);
  for(int i=0;i<20000;i++){
      double df=(i%5==0)?.125:(i%5==1?1.:(i%5==2?2.:(i%5==3?3.5:100.)));
      assert(bits(ln_pcg64_chisquare(&a,df))==bits(2.*ln_pcg64_standard_gamma(&b,df/2.)));
  }
  assert(ln_pcg64_next64(&a)==ln_pcg64_next64(&b));
  ln_pcg64_seed(&a,42);ln_pcg64_seed(&b,42);
  for(int i=0;i<12000;i++){
      double df1=(i%2)?3.:.5;
      double df2=(i%3)?5.:1.;
      double x=ln_pcg64_f(&a,df1,df2);
      double numerator=ln_pcg64_chisquare(&b,df1)*df2;
      double denominator=ln_pcg64_chisquare(&b,df2)*df1;
      assert(bits(x)==bits(numerator/denominator));
  }
  assert(ln_pcg64_next64(&a)==ln_pcg64_next64(&b));
  puts("distributions59 native PCG64 tests passed");
  return 0;
}
