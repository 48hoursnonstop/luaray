#ifndef LUARAY_FFT_HELPERS_H
#define LUARAY_FFT_HELPERS_H
#include "ln_fft.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Spacing is a numeric ndarray, with raw_scalar indicating ordinary Lua
 * scalar division semantics. Typed spacing retains ndarray ufunc precision. */
ln_array *ln_fft_frequency(ln_intp n,const ln_array *spacing,int raw_scalar,
                           int real_only,ln_error *err);
/* axes are normalized zero-based; count=-1 selects all axes, count=0 none. */
ln_array *ln_fft_shift(const ln_array *input,const int *axes,int count,
                       int inverse,ln_error *err);
ln_array *ln_fft_hfft(const ln_array *input,ln_intp n,int axis,ln_fft_norm norm,
                       const ln_dtype *out_dtype,ln_error *err);
ln_array *ln_fft_ihfft(const ln_array *input,ln_intp n,int axis,ln_fft_norm norm,
                        const ln_dtype *out_dtype,ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
