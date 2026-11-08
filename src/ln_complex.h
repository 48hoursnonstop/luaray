#ifndef LUARAY_COMPLEX_H
#define LUARAY_COMPLEX_H

#include <math.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct { float real, imag; } ln_cfloat;
typedef struct { double real, imag; } ln_cdouble;
typedef struct { long double real, imag; } ln_clongdouble;
typedef struct { long double real, imag; } ln_complex_value;

static inline int ln_complex_truth_ld(ln_complex_value z) {
    return z.real != 0.0L || z.imag != 0.0L;
}
static inline int ln_complex_isnan_ld(ln_complex_value z) {
    return isnan(z.real) || isnan(z.imag);
}
static inline int ln_complex_isinf_ld(ln_complex_value z) {
    return isinf(z.real) || isinf(z.imag);
}
static inline int ln_complex_isfinite_ld(ln_complex_value z) {
    return isfinite(z.real) && isfinite(z.imag);
}

/* ufunc comparison ordering from numpy/_core/src/umath/loops.c.src. */
#define LN_COMPLEX_EQ(ar,ai,br,bi) ((ar)==(br) && (ai)==(bi))
#define LN_COMPLEX_NE(ar,ai,br,bi) ((ar)!=(br) || (ai)!=(bi))
#define LN_COMPLEX_GT(ar,ai,br,bi) (((ar)>(br) && !isnan(ai) && !isnan(bi)) || ((ar)==(br) && (ai)>(bi)))
#define LN_COMPLEX_GE(ar,ai,br,bi) (((ar)>(br) && !isnan(ai) && !isnan(bi)) || ((ar)==(br) && (ai)>=(bi)))
#define LN_COMPLEX_LT(ar,ai,br,bi) (((ar)<(br) && !isnan(ai) && !isnan(bi)) || ((ar)==(br) && (ai)<(bi)))
#define LN_COMPLEX_LE(ar,ai,br,bi) (((ar)<(br) && !isnan(ai) && !isnan(bi)) || ((ar)==(br) && (ai)<=(bi)))

/* Sort/search ordering ported from common/numpy_tag.hpp::complex_type. */
#define LN_DEFINE_COMPLEX_SORT_CMP(NAME, T) \
static inline int ln_##NAME##_sort_less(T ar,T ai,T br,T bi) { \
    if (ar < br) return (ai == ai) || (bi != bi); \
    if (ar > br) return (bi != bi) && (ai == ai); \
    if (ar == br || (ar != ar && br != br)) return ai < bi || (bi != bi && ai == ai); \
    return br != br; \
} \
static inline int ln_##NAME##_sort_greater(T ar,T ai,T br,T bi) { \
    if (ar > br) return (ai == ai) || (bi != bi); \
    if (ar < br) return (bi != bi) && (ai == ai); \
    if (ar == br || (ar != ar && br != br)) return ai > bi || (bi != bi && ai == ai); \
    return br != br; \
}

LN_DEFINE_COMPLEX_SORT_CMP(cfloat,float)
LN_DEFINE_COMPLEX_SORT_CMP(cdouble,double)
LN_DEFINE_COMPLEX_SORT_CMP(clongdouble,long double)
#undef LN_DEFINE_COMPLEX_SORT_CMP

#ifdef __cplusplus
}
#endif
#endif
