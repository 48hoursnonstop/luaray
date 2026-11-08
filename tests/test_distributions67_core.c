#include "ln_random.h"
#include <assert.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
int main(void) {
  const int64_t colors[]={15,15,10};
  const int64_t marginal[]={4,3,5,3,6,3,2,5,5,4,5,3,6,6,0,2,7,3};
  const int64_t count[]={5,6,1,6,3,3,4,5,3,7,1,4,5,4,3,3,4,5};
  for(int method=0;method<2;method++){
    ln_pcg64 r;ln_pcg64_seed(&r,42);
    int64_t values[18]={0};
    assert(ln_pcg64_multivariate_hypergeometric(&r,colors,3,40,12,6,method,values)==0);
    assert(memcmp(values,method?count:marginal,sizeof values)==0);
    assert(ln_pcg64_next64(&r)==(method?UINT64_C(10491423285918525769):UINT64_C(4185738689873690421)));
  }
  for(uint64_t seed=0;seed<8;seed++){
    ln_pcg64 a,b;ln_pcg64_seed(&a,seed);ln_pcg64_seed(&b,seed);
    for(int method=0;method<2;method++){
      int64_t x[150]={0},y[150]={0};
      assert(ln_pcg64_multivariate_hypergeometric(&a,colors,3,40,20,50,method,x)==0);
      assert(ln_pcg64_multivariate_hypergeometric(&b,colors,3,40,20,50,method,y)==0);
      assert(memcmp(x,y,sizeof x)==0);
      for(int i=0;i<50;i++){
         int64_t total=0;
         for(int j=0;j<3;j++){int64_t v=x[i*3+j];assert(v>=0 && v<=colors[j]);total+=v;}
         assert(total==20);
      }
    }
    assert(ln_pcg64_next64(&a)==ln_pcg64_next64(&b));
  }
  puts("distributions67 native tests passed");
  return 0;
}
