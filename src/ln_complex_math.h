#ifndef LUARAY_LN_COMPLEX_MATH_H
#define LUARAY_LN_COMPLEX_MATH_H

#include "ln_complex.h"

/*
 * Complex elementary functions adapted from NumPy's pinned
 * numpy/_core/src/npymath/npy_math_complex.c.src.  These functions keep the
 * component-wise edge-case handling used by NumPy instead of delegating the
 * whole operation to libc complex functions.
 */
ln_cfloat ln_cfloat_cexp(ln_cfloat z);
ln_cdouble ln_cdouble_cexp(ln_cdouble z);
ln_clongdouble ln_clongdouble_cexp(ln_clongdouble z);

ln_cfloat ln_cfloat_clog(ln_cfloat z);
ln_cdouble ln_cdouble_clog(ln_cdouble z);
ln_clongdouble ln_clongdouble_clog(ln_clongdouble z);

ln_cfloat ln_cfloat_csqrt(ln_cfloat z);
ln_cdouble ln_cdouble_csqrt(ln_cdouble z);
ln_clongdouble ln_clongdouble_csqrt(ln_clongdouble z);

ln_cfloat ln_cfloat_cpow(ln_cfloat a, ln_cfloat b);
ln_cdouble ln_cdouble_cpow(ln_cdouble a, ln_cdouble b);
ln_clongdouble ln_clongdouble_cpow(ln_clongdouble a, ln_clongdouble b);

ln_cfloat ln_cfloat_ccos(ln_cfloat z);
ln_cdouble ln_cdouble_ccos(ln_cdouble z);
ln_clongdouble ln_clongdouble_ccos(ln_clongdouble z);
ln_cfloat ln_cfloat_csin(ln_cfloat z);
ln_cdouble ln_cdouble_csin(ln_cdouble z);
ln_clongdouble ln_clongdouble_csin(ln_clongdouble z);
ln_cfloat ln_cfloat_ctan(ln_cfloat z);
ln_cdouble ln_cdouble_ctan(ln_cdouble z);
ln_clongdouble ln_clongdouble_ctan(ln_clongdouble z);

ln_cfloat ln_cfloat_csinh(ln_cfloat z);
ln_cdouble ln_cdouble_csinh(ln_cdouble z);
ln_clongdouble ln_clongdouble_csinh(ln_clongdouble z);
ln_cfloat ln_cfloat_ccosh(ln_cfloat z);
ln_cdouble ln_cdouble_ccosh(ln_cdouble z);
ln_clongdouble ln_clongdouble_ccosh(ln_clongdouble z);
ln_cfloat ln_cfloat_ctanh(ln_cfloat z);
ln_cdouble ln_cdouble_ctanh(ln_cdouble z);
ln_clongdouble ln_clongdouble_ctanh(ln_clongdouble z);

ln_cfloat ln_cfloat_cexp2(ln_cfloat z);
ln_cdouble ln_cdouble_cexp2(ln_cdouble z);
ln_clongdouble ln_clongdouble_cexp2(ln_clongdouble z);
ln_cfloat ln_cfloat_clog2(ln_cfloat z);
ln_cdouble ln_cdouble_clog2(ln_cdouble z);
ln_clongdouble ln_clongdouble_clog2(ln_clongdouble z);
ln_cfloat ln_cfloat_clog10(ln_cfloat z);
ln_cdouble ln_cdouble_clog10(ln_cdouble z);
ln_clongdouble ln_clongdouble_clog10(ln_clongdouble z);
ln_cfloat ln_cfloat_cexpm1(ln_cfloat z);
ln_cdouble ln_cdouble_cexpm1(ln_cdouble z);
ln_clongdouble ln_clongdouble_cexpm1(ln_clongdouble z);
ln_cfloat ln_cfloat_clog1p(ln_cfloat z);
ln_cdouble ln_cdouble_clog1p(ln_cdouble z);
ln_clongdouble ln_clongdouble_clog1p(ln_clongdouble z);

/* NumPy npy_math_complex.c.src configured C99 inverse-function path. */
ln_cfloat ln_cfloat_casin(ln_cfloat z);
ln_cdouble ln_cdouble_casin(ln_cdouble z);
ln_clongdouble ln_clongdouble_casin(ln_clongdouble z);
ln_cfloat ln_cfloat_cacos(ln_cfloat z);
ln_cdouble ln_cdouble_cacos(ln_cdouble z);
ln_clongdouble ln_clongdouble_cacos(ln_clongdouble z);
ln_cfloat ln_cfloat_catan(ln_cfloat z);
ln_cdouble ln_cdouble_catan(ln_cdouble z);
ln_clongdouble ln_clongdouble_catan(ln_clongdouble z);
ln_cfloat ln_cfloat_casinh(ln_cfloat z);
ln_cdouble ln_cdouble_casinh(ln_cdouble z);
ln_clongdouble ln_clongdouble_casinh(ln_clongdouble z);
ln_cfloat ln_cfloat_cacosh(ln_cfloat z);
ln_cdouble ln_cdouble_cacosh(ln_cdouble z);
ln_clongdouble ln_clongdouble_cacosh(ln_clongdouble z);
ln_cfloat ln_cfloat_catanh(ln_cfloat z);
ln_cdouble ln_cdouble_catanh(ln_cdouble z);
ln_clongdouble ln_clongdouble_catanh(ln_clongdouble z);

#endif
