#include "ln_stats.h"
#include "ln_axis.h"
#include "ln_complex.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

static double dbl(const ln_array *a,ln_intp i){double v;memcpy(&v,a->data+(a->nd?i*a->strides[0]:0),sizeof(v));return v;}
static ln_intp idx(const ln_array *a,ln_intp i){ln_intp v;memcpy(&v,a->data+(a->nd?i*a->strides[0]:0),sizeof(v));return v;}
int main(void){
 ln_error e={0};
 ln_array *a=ln_array_new(2,(ln_intp[]){2,3},ln_dtype_by_num(LN_DOUBLE),0,0,&e);
 assert(a);
 double vals[]={NAN,5,1,2,NAN,6};memcpy(a->data,vals,sizeof(vals));
 ln_array *mn=ln_stats_nan_extrema(a,(uint8_t[]){0,1},0,NULL,0,0,0,0,0,NULL,&e);
 assert(mn&&mn->nd==1&&dbl(mn,0)==1&&dbl(mn,1)==2);ln_array_free(mn);
 ln_array *mx=ln_stats_nan_extrema(a,(uint8_t[]){1,0},0,NULL,0,0,0,0,1,NULL,&e);
 assert(mx&&dbl(mx,0)==2&&dbl(mx,1)==5&&dbl(mx,2)==6);ln_array_free(mx);
 ln_array *ix=ln_stats_nan_argextrema(a,1,0,0,NULL,&e);
 assert(ix&&idx(ix,0)==3&&idx(ix,1)==1);ln_array_free(ix);
 ix=ln_stats_nan_argextrema(a,-1,0,1,NULL,&e);
 assert(ix&&idx(ix,0)==6);ln_array_free(ix);
 /* Writing into the source after reduction must not corrupt input reads. */
 ln_array *overlap=ln_array_view(a,1,(ln_intp[]){2},(ln_intp[]){a->strides[0]},a->data,&e);
 assert(overlap);
 mn=ln_stats_nan_extrema(a,(uint8_t[]){0,1},0,NULL,0,0,0,0,0,overlap,&e);
 assert(mn&&dbl(overlap,0)==1&&dbl(overlap,1)==2);ln_array_free(mn);
 ln_array_free(overlap);ln_array_free(a);
 /* All NaN remains NaN for nanmin/max, but is invalid for nanargmin/max. */
 a=ln_array_new(1,(ln_intp[]){2},ln_dtype_by_num(LN_DOUBLE),0,0,&e);assert(a);
 double ns[]={NAN,NAN};memcpy(a->data,ns,sizeof(ns));
 mn=ln_stats_nan_extrema(a,NULL,0,NULL,0,0,0,0,0,NULL,&e);
 assert(mn&&isnan(dbl(mn,0)));ln_array_free(mn);
 assert(!ln_stats_nan_argextrema(a,-1,0,0,NULL,&e));
 ln_array_free(a);
 /* Exact unsigned 64-bit ordering must not go through double. */
 a=ln_array_new(1,(ln_intp[]){3},ln_dtype_by_num(LN_ULONGLONG),0,0,&e);assert(a);
 uint64_t big[]={UINT64_MAX-2,UINT64_MAX,UINT64_MAX-1};memcpy(a->data,big,sizeof(big));
 mn=ln_stats_nan_extrema(a,NULL,0,NULL,0,0,0,0,0,NULL,&e);
 assert(mn&&memcmp(mn->data,&big[0],sizeof(big[0]))==0);ln_array_free(mn);
 ix=ln_stats_nan_argextrema(a,-1,0,1,NULL,&e);
 assert(ix&&idx(ix,0)==2);ln_array_free(ix);ln_array_free(a);
 /* Negative strides and NaN in the imaginary component. */
 a=ln_array_new(1,(ln_intp[]){3},ln_dtype_by_num(LN_CDOUBLE),0,0,&e);assert(a);
 ln_cdouble c[]={ {1,2},{NAN,1},{3,4} };memcpy(a->data,c,sizeof(c));
 ln_array *reverse=ln_array_view(a,1,(ln_intp[]){3},(ln_intp[]){-(ln_intp)sizeof(ln_cdouble)},a->data+2*sizeof(ln_cdouble),&e);assert(reverse);
 ix=ln_stats_nan_argextrema(reverse,-1,0,1,NULL,&e);
 assert(ix&&idx(ix,0)==1);ln_array_free(ix);ln_array_free(reverse);ln_array_free(a);
 puts("nan extrema native core: ok");return 0;
}
