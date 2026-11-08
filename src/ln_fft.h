#ifndef LUARAY_FFT_H
#define LUARAY_FFT_H

#include "ln_core.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef enum ln_fft_norm {
    LN_FFT_NORM_BACKWARD = 0,
    LN_FFT_NORM_ORTHO = 1,
    LN_FFT_NORM_FORWARD = 2
} ln_fft_norm;

/* NumPy _pocketfft.py/_pocketfft_umath.cpp adapted to host-neutral ln_array.
 * axis is normalized zero-based. n must be >= 1. */
ln_array *ln_fft_fft(const ln_array *a, ln_intp n, int axis,
                     int inverse, ln_fft_norm norm,
                     const ln_dtype *requested_out_dtype, ln_error *err);
ln_array *ln_fft_rfft(const ln_array *a, ln_intp n, int axis,
                      ln_fft_norm norm, const ln_dtype *requested_out_dtype,
                      ln_error *err);
ln_array *ln_fft_irfft(const ln_array *a, ln_intp n, int axis,
                       ln_fft_norm norm, const ln_dtype *requested_out_dtype,
                       ln_error *err);

/* Copy an FFT result into an explicit out array using NumPy's default
 * same_kind output-cast rule for the numeric subset. */
int ln_fft_copy_into(const ln_array *src, ln_array *dst, ln_error *err);

#ifdef __cplusplus
}
#endif
#endif
