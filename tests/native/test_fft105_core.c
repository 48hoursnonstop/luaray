#include "ln_fft_helpers.h"
#include "ln_complex.h"
#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

int main(void)
{
    ln_error err={0};
    const ln_dtype *f64=ln_dtype_by_name("float64"),*c128=ln_dtype_by_name("complex128");
    ln_array *spacing=ln_array_new(0,NULL,f64,0,0,&err);assert(spacing);
    memcpy(spacing->data,(double[]){0.5},8);
    ln_array *out=ln_fft_frequency(4,spacing,1,0,&err);assert(out&&out->dimensions[0]==4);
    assert(memcmp(out->data,(double[]){0,0.5,-1,-0.5},32)==0);ln_array_free(out);
    out=ln_fft_frequency(5,spacing,1,1,&err);assert(out&&out->dimensions[0]==3);
    assert(((double *)out->data)[2]==0.8);ln_array_free(out);
    assert(!ln_fft_frequency(0,spacing,1,0,&err));
    assert(!ln_fft_frequency(-1,spacing,1,0,&err));
    out=ln_fft_frequency(-1,spacing,1,1,&err);assert(out&&ln_array_size(out)==0);ln_array_free(out);
    out=ln_fft_frequency(0,spacing,0,1,&err);assert(out&&ln_array_size(out)==1&&isnan(*(double *)out->data));ln_array_free(out);
    assert(!ln_fft_frequency(1,NULL,0,0,&err));assert(!ln_fft_frequency(1,spacing,0,2,&err));
    ln_intp n=5;ln_array *a=ln_array_new(1,&n,f64,0,0,&err);assert(a);
    memcpy(a->data,(double[]){0,1,2,3,4},40);
    out=ln_fft_shift(a,NULL,-1,0,&err);assert(out);
    assert(memcmp(out->data,(double[]){3,4,0,1,2},40)==0);
    ln_array *back=ln_fft_shift(out,NULL,-1,1,&err);assert(back&&memcmp(back->data,a->data,40)==0);
    ln_array_free(out);ln_array_free(back);
    int axes[]={0,0};out=ln_fft_shift(a,axes,2,0,&err);assert(out);
    assert(memcmp(out->data,(double[]){1,2,3,4,0},40)==0);ln_array_free(out);
    out=ln_fft_shift(a,NULL,0,0,&err);assert(out&&out!=a&&memcmp(out->data,a->data,40)==0);ln_array_free(out);
    axes[0]=1;assert(!ln_fft_shift(a,axes,1,0,&err));
    assert(!ln_fft_shift(a,NULL,1,0,&err));assert(!ln_fft_shift(a,NULL,-2,0,&err));
    assert(!ln_fft_shift(NULL,NULL,0,0,&err));assert(!ln_fft_shift(spacing,NULL,-1,0,&err));
    ln_intp three=3;ln_array *h=ln_array_new(1,&three,f64,0,0,&err);assert(h);
    memcpy(h->data,(double[]){1,2,3},24);
    out=ln_fft_hfft(h,4,0,LN_FFT_NORM_BACKWARD,NULL,&err);assert(out);
    assert(memcmp(out->data,(double[]){8,-2,0,-2},32)==0);
    back=ln_fft_ihfft(out,4,0,LN_FFT_NORM_BACKWARD,NULL,&err);assert(back&&back->descr==c128);
    assert(((ln_cdouble *)back->data)[1].real==2&&((ln_cdouble *)back->data)[1].imag==0);
    ln_array_free(back);
    ln_array *dest=ln_array_new(1,&(ln_intp){4},f64,0,0,&err);assert(dest);
    memset(dest->data,0,32);dest->flags&=~LN_ARRAY_WRITEABLE;
    assert(ln_fft_copy_into(out,dest,&err)<0);assert(((double *)dest->data)[0]==0);
    dest->flags|=LN_ARRAY_WRITEABLE;assert(ln_fft_copy_into(out,dest,&err)==0);
    ln_array_free(dest);ln_array_free(out);
    ln_array *invalid=ln_array_new(1,&three,ln_dtype_by_name("U4"),0,1,&err);assert(invalid);
    assert(!ln_fft_fft(invalid,3,0,0,LN_FFT_NORM_ORTHO,c128,&err));
    assert(!ln_fft_irfft(invalid,3,0,LN_FFT_NORM_ORTHO,f64,&err));
    assert(!ln_fft_hfft(invalid,3,0,LN_FFT_NORM_ORTHO,f64,&err));
    assert(!ln_fft_hfft(NULL,3,0,LN_FFT_NORM_BACKWARD,NULL,&err));
    assert(!ln_fft_ihfft(NULL,3,0,LN_FFT_NORM_BACKWARD,NULL,&err));
    assert(!ln_fft_hfft(h,3,0,(ln_fft_norm)99,NULL,&err));
    assert(!ln_fft_ihfft(h,3,0,(ln_fft_norm)-1,NULL,&err));
    assert(!ln_fft_hfft(h,0,0,LN_FFT_NORM_BACKWARD,NULL,&err));
    assert(!ln_fft_ihfft(h,3,1,LN_FFT_NORM_BACKWARD,NULL,&err));
    assert(memcmp(h->data,(double[]){1,2,3},24)==0);
    ln_array_free(invalid);ln_array_free(h);ln_array_free(a);ln_array_free(spacing);
    puts("fft105 native core: passed");return 0;
}
