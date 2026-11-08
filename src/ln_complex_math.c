/*
 * Portions adapted from NumPy's npy_math_complex.c.src, which contains code
 * from the FreeBSD msun library:
 *
 * Copyright (c) 2007, 2011 David Schultz <das@FreeBSD.ORG>
 * Copyright (c) 2012 Stephen Montgomery-Smith <stephen@FreeBSD.ORG>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
#include "ln_complex_math.h"

#include <float.h>
#include <math.h>
#include <complex.h>
#include <stdint.h>

/*
 * Direct adaptation of the elementary-function core in
 * numpy/_core/src/npymath/npy_math_complex.c.src (pinned upstream main).
 * LuaRay uses real/imag structs rather than NumPy's npy_c* helpers.  Floating
 * status-flag plumbing (npy_set_floatstatus_*) is intentionally not exposed by
 * LuaRay yet; the numerical return paths are preserved.
 */

#define LN_LOG2_CONST 0.693147180559945309417232121458176568L

#define DEFINE_COMPLEX_MATH(PFX, CTYPE, RTYPE, \
        FABS, EXP, COS, SIN, FREXP, LDEXP, COPYSIGN, LOG, HYPOT, LOG1P, SQRT, \
        SINH, COSH, TAN, ATAN2, TMAX, TMIN, TMANT, SLOW, SUP, KVAL, BIG, HUGE, TANHHUGE) \
static inline CTYPE PFX##_pack(RTYPE r, RTYPE i) { CTYPE z; z.real=r; z.imag=i; return z; } \
static inline CTYPE PFX##_mul(CTYPE a, CTYPE b) { \
    return PFX##_pack(a.real*b.real-a.imag*b.imag, a.real*b.imag+a.imag*b.real); \
} \
static inline CTYPE PFX##_div(CTYPE a, CTYPE b) { \
    RTYPE abr=(RTYPE)FABS(b.real), abi=(RTYPE)FABS(b.imag); \
    if (abr >= abi) { \
        if (abr == (RTYPE)0 && abi == (RTYPE)0) return PFX##_pack(a.real/abr,a.imag/abi); \
        RTYPE rat=b.imag/b.real, scl=(RTYPE)1/(b.real+b.imag*rat); \
        return PFX##_pack((a.real+a.imag*rat)*scl,(a.imag-a.real*rat)*scl); \
    } \
    RTYPE rat=b.real/b.imag, scl=(RTYPE)1/(b.imag+b.real*rat); \
    return PFX##_pack((a.real*rat+a.imag)*scl,(a.imag*rat-a.real)*scl); \
} \
static CTYPE PFX##_scaled_cexp(RTYPE x, RTYPE y, int expt) { \
    const int k=(KVAL); const RTYPE kln2=(RTYPE)((long double)k*LN_LOG2_CONST); \
    RTYPE mant,mantcos,mantsin; int ex,excos,exsin; \
    mant=(RTYPE)FREXP(EXP(x-kln2),&ex); \
    mantcos=(RTYPE)FREXP(COS(y),&excos); \
    mantsin=(RTYPE)FREXP(SIN(y),&exsin); \
    expt += ex+k; \
    return PFX##_pack((RTYPE)LDEXP(mant*mantcos,expt+excos), \
                      (RTYPE)LDEXP(mant*mantsin,expt+exsin)); \
} \
CTYPE PFX##_cexp(CTYPE z) { \
    RTYPE r=z.real,i=z.imag,x,c,s; \
    if (isfinite(r)) { \
        if (r >= (RTYPE)(SLOW) && r <= (RTYPE)(SUP)) return PFX##_scaled_cexp(r,i,0); \
        x=(RTYPE)EXP(r); c=(RTYPE)COS(i); s=(RTYPE)SIN(i); \
        if (isfinite(i)) return PFX##_pack(x*c,x*s); \
        return PFX##_pack((RTYPE)NAN,(RTYPE)COPYSIGN((RTYPE)NAN,i)); \
    } \
    if (isnan(r)) { \
        if (i == (RTYPE)0) return z; \
        return PFX##_pack(r,(RTYPE)COPYSIGN((RTYPE)NAN,i)); \
    } \
    if (r > (RTYPE)0) { \
        if (i == (RTYPE)0) return PFX##_pack(r,i); \
        if (isfinite(i)) { c=(RTYPE)COS(i); s=(RTYPE)SIN(i); return PFX##_pack(r*c,r*s); } \
        return PFX##_pack(r,(RTYPE)NAN); \
    } \
    if (isfinite(i)) { \
        x=(RTYPE)EXP(r); c=(RTYPE)COS(i); s=(RTYPE)SIN(i); return PFX##_pack(x*c,x*s); \
    } \
    return PFX##_pack((RTYPE)0,(RTYPE)0); \
} \
CTYPE PFX##_clog(CTYPE z) { \
    RTYPE ax=(RTYPE)FABS(z.real), ay=(RTYPE)FABS(z.imag), rr,ri; \
    if (isgreater(ax,(RTYPE)(TMAX)/(RTYPE)4) || isgreater(ay,(RTYPE)(TMAX)/(RTYPE)4)) { \
        rr=(RTYPE)LOG(HYPOT(ax/(RTYPE)2,ay/(RTYPE)2))+(RTYPE)LN_LOG2_CONST; \
    } else if (isless(ax,(RTYPE)(TMIN)) && isless(ay,(RTYPE)(TMIN))) { \
        if (isgreater(ax,(RTYPE)0) || isgreater(ay,(RTYPE)0)) { \
            rr=(RTYPE)LOG(HYPOT(LDEXP(ax,(TMANT)),LDEXP(ay,(TMANT))))-(RTYPE)(TMANT)*(RTYPE)LN_LOG2_CONST; \
        } else { \
            rr=(RTYPE)-1.0/z.real; rr=(RTYPE)COPYSIGN(rr,(RTYPE)-1); \
            ri=(RTYPE)ATAN2(z.imag,z.real); return PFX##_pack(rr,ri); \
        } \
    } else { \
        RTYPE h=(RTYPE)HYPOT(ax,ay); \
        if (isgreaterequal(h,(RTYPE)0.71) && islessequal(h,(RTYPE)1.73)) { \
            RTYPE am=isgreater(ax,ay)?ax:ay, an=isgreater(ax,ay)?ay:ax; \
            rr=(RTYPE)LOG1P((am-(RTYPE)1)*(am+(RTYPE)1)+an*an)/(RTYPE)2; \
        } else rr=(RTYPE)LOG(h); \
    } \
    ri=(RTYPE)ATAN2(z.imag,z.real); return PFX##_pack(rr,ri); \
} \
CTYPE PFX##_csqrt(CTYPE z) { \
    RTYPE a=z.real,b=z.imag,t; int scale; \
    const RTYPE thresh=(RTYPE)(TMAX)/((RTYPE)1+(RTYPE)1.41421356237309504880168872420969808L); \
    if (a==(RTYPE)0 && b==(RTYPE)0) return PFX##_pack((RTYPE)0,b); \
    if (isinf(b)) return PFX##_pack((RTYPE)INFINITY,b); \
    if (isnan(a)) { t=(b-b)/(b-b); return PFX##_pack(a,t); } \
    if (isinf(a)) { \
        if (signbit(a)) return PFX##_pack((RTYPE)FABS(b-b),(RTYPE)COPYSIGN(a,b)); \
        return PFX##_pack(a,(RTYPE)COPYSIGN(b-b,b)); \
    } \
    if (FABS(a)>=thresh || FABS(b)>=thresh) { a*=(RTYPE)0.25; b*=(RTYPE)0.25; scale=1; } else scale=0; \
    CTYPE out; \
    if (a >= (RTYPE)0) { t=(RTYPE)SQRT((a+(RTYPE)HYPOT(a,b))*(RTYPE)0.5); out=PFX##_pack(t,b/((RTYPE)2*t)); } \
    else { t=(RTYPE)SQRT((-a+(RTYPE)HYPOT(a,b))*(RTYPE)0.5); out=PFX##_pack((RTYPE)FABS(b)/((RTYPE)2*t),(RTYPE)COPYSIGN(t,b)); } \
    if (scale) { out.real*=(RTYPE)2; } \
    return out; \
} \
CTYPE PFX##_cpow(CTYPE a, CTYPE b) { \
    intptr_t n; RTYPE ar=a.real,ai=a.imag,br=b.real,bi=b.imag; \
    if (br==(RTYPE)0 && bi==(RTYPE)0) return PFX##_pack((RTYPE)1,(RTYPE)0); \
    if (ar==(RTYPE)0 && ai==(RTYPE)0) { \
        if (br>(RTYPE)0) return PFX##_pack((RTYPE)0,(RTYPE)0); \
        volatile RTYPE tmp=(RTYPE)INFINITY; tmp-= (RTYPE)INFINITY; (void)tmp; \
        return PFX##_pack((RTYPE)NAN,(RTYPE)NAN); \
    } \
    n=(intptr_t)br; \
    if (bi==(RTYPE)0 && br>(RTYPE)-100 && br<(RTYPE)100 && (RTYPE)n==br) { \
        if (n==1) return a; \
        if (n==2) return PFX##_mul(a,a); \
        if (n==3) return PFX##_mul(a,PFX##_mul(a,a)); \
        intptr_t nn=n<0?-n:n,mask=1; CTYPE aa=PFX##_pack((RTYPE)1,(RTYPE)0),p=a; \
        while (1) { if (nn&mask) aa=PFX##_mul(aa,p); mask<<=1; if (nn<mask || mask<=0) break; p=PFX##_mul(p,p); } \
        return n<0 ? PFX##_div(PFX##_pack((RTYPE)1,(RTYPE)0),aa) : aa; \
    } \
    CTYPE l=PFX##_clog(a); return PFX##_cexp(PFX##_pack(l.real*br-l.imag*bi,l.real*bi+l.imag*br)); \
} \
CTYPE PFX##_ccosh(CTYPE z) { \
    RTYPE x=z.real,y=z.imag,h,absx; int xf=isfinite(x),yf=isfinite(y); \
    if (xf && yf) { \
        if (y==(RTYPE)0) return PFX##_pack((RTYPE)COSH(x),x*y); \
        absx=(RTYPE)FABS(x); \
        if (absx<(RTYPE)(BIG)) return PFX##_pack((RTYPE)COSH(x)*(RTYPE)COS(y),(RTYPE)SINH(x)*(RTYPE)SIN(y)); \
        if (absx<(RTYPE)(SLOW)) { h=(RTYPE)EXP(absx)*(RTYPE)0.5; return PFX##_pack(h*(RTYPE)COS(y),(RTYPE)COPYSIGN(h,x)*(RTYPE)SIN(y)); } \
        if (absx<(RTYPE)(SUP)) { CTYPE q=PFX##_scaled_cexp(absx,y,-1); return PFX##_pack(q.real,q.imag*(RTYPE)COPYSIGN((RTYPE)1,x)); } \
        h=(RTYPE)(HUGE)*x; return PFX##_pack(h*h*(RTYPE)COS(y),h*(RTYPE)SIN(y)); \
    } \
    if (x==(RTYPE)0 && !yf) return PFX##_pack(y-y,(RTYPE)COPYSIGN((RTYPE)0,x*(y-y))); \
    if (y==(RTYPE)0 && !xf) return PFX##_pack(x*x,(RTYPE)COPYSIGN((RTYPE)0,x)*y); \
    if (xf && !yf) return PFX##_pack(y-y,x*(y-y)); \
    if (isinf(x)) { if (!yf) return PFX##_pack(x*x,x*(y-y)); return PFX##_pack((x*x)*(RTYPE)COS(y),x*(RTYPE)SIN(y)); } \
    return PFX##_pack((x*x)*(y-y),(x+x)*(y-y)); \
} \
CTYPE PFX##_csinh(CTYPE z) { \
    RTYPE x=z.real,y=z.imag,h,absx; int xf=isfinite(x),yf=isfinite(y); \
    if (xf && yf) { \
        if (y==(RTYPE)0) return PFX##_pack((RTYPE)SINH(x),y); \
        absx=(RTYPE)FABS(x); \
        if (absx<(RTYPE)(BIG)) return PFX##_pack((RTYPE)SINH(x)*(RTYPE)COS(y),(RTYPE)COSH(x)*(RTYPE)SIN(y)); \
        if (absx<(RTYPE)(SLOW)) { h=(RTYPE)EXP(absx)*(RTYPE)0.5; return PFX##_pack((RTYPE)COPYSIGN(h,x)*(RTYPE)COS(y),h*(RTYPE)SIN(y)); } \
        if (x<(RTYPE)(SUP)) { CTYPE q=PFX##_scaled_cexp(absx,y,-1); return PFX##_pack(q.real*(RTYPE)COPYSIGN((RTYPE)1,x),q.imag); } \
        h=(RTYPE)(HUGE)*x; return PFX##_pack(h*(RTYPE)COS(y),h*h*(RTYPE)SIN(y)); \
    } \
    if (x==(RTYPE)0 && !yf) return PFX##_pack((RTYPE)COPYSIGN((RTYPE)0,x*(y-y)),y-y); \
    if (y==(RTYPE)0 && !xf) { if (isnan(x)) return z; return PFX##_pack(x,(RTYPE)COPYSIGN((RTYPE)0,y)); } \
    if (xf && !yf) return PFX##_pack(y-y,x*(y-y)); \
    if (!xf && !isnan(x)) { if (!yf) return PFX##_pack(x*x,x*(y-y)); return PFX##_pack(x*(RTYPE)COS(y),(RTYPE)INFINITY*(RTYPE)SIN(y)); } \
    return PFX##_pack((x*x)*(y-y),(x+x)*(y-y)); \
} \
CTYPE PFX##_ctanh(CTYPE z) { \
    RTYPE x=z.real,y=z.imag,t,beta,s,rho,denom; \
    /* NumPy's configured C99 ctanh path on this platform preserves a zero \
     * real component for 0 + i*Inf/NaN, whereas the portable msun fallback \
     * returns NaN + i*NaN. Mirror the configured upstream result. */ \
    if (x==(RTYPE)0 && !isfinite(y)) return PFX##_pack(x,y-y); \
    if (!isfinite(x)) { \
        if (isnan(x)) return PFX##_pack(x,y==(RTYPE)0?y:x*y); \
        return PFX##_pack((RTYPE)COPYSIGN((RTYPE)1,x),(RTYPE)COPYSIGN((RTYPE)0,isinf(y)?y:(RTYPE)SIN(y)*(RTYPE)COS(y))); \
    } \
    if (!isfinite(y)) return PFX##_pack(y-y,y-y); \
    if (FABS(x)>=(RTYPE)(TANHHUGE)) { RTYPE emx=(RTYPE)EXP(-(RTYPE)FABS(x)); return PFX##_pack((RTYPE)COPYSIGN((RTYPE)1,x),(RTYPE)4*(RTYPE)SIN(y)*(RTYPE)COS(y)*emx*emx); } \
    t=(RTYPE)TAN(y); beta=(RTYPE)1+t*t; s=(RTYPE)SINH(x); rho=(RTYPE)SQRT((RTYPE)1+s*s); denom=(RTYPE)1+beta*s*s; \
    return PFX##_pack((beta*rho*s)/denom,t/denom); \
} \
CTYPE PFX##_ccos(CTYPE z) { CTYPE q=PFX##_ccosh(PFX##_pack(-z.imag,z.real)); return q; } \
CTYPE PFX##_csin(CTYPE z) { CTYPE q=PFX##_csinh(PFX##_pack(-z.imag,z.real)); return PFX##_pack(q.imag,-q.real); } \
CTYPE PFX##_ctan(CTYPE z) { \
    /* On platforms where NumPy configures HAVE_CTAN*, the C99 path keeps a \
     * zero imaginary component for non-finite real inputs.  Preserve that \
     * configured upstream behavior before using the portable msun fallback. */ \
    if (z.imag==(RTYPE)0 && !isfinite(z.real)) return PFX##_pack(z.real-z.real,z.imag); \
    CTYPE q=PFX##_ctanh(PFX##_pack(-z.imag,z.real)); return PFX##_pack(q.imag,-q.real); \
}

DEFINE_COMPLEX_MATH(ln_cfloat,ln_cfloat,float,
    fabsf,expf,cosf,sinf,frexpf,ldexpf,copysignf,logf,hypotf,log1pf,sqrtf,
    sinhf,coshf,tanf,atan2f,FLT_MAX,FLT_MIN,FLT_MANT_DIG,
    88.722839f,192.69492f,235,9.0f,1.70141183e38f,11.0f)

DEFINE_COMPLEX_MATH(ln_cdouble,ln_cdouble,double,
    fabs,exp,cos,sin,frexp,ldexp,copysign,log,hypot,log1p,sqrt,
    sinh,cosh,tan,atan2,DBL_MAX,DBL_MIN,DBL_MANT_DIG,
    710.47586007394386,1454.9159319953251,1799,22.0,8.9884656743115795e307,22.0)

#if LDBL_MAX_EXP == DBL_MAX_EXP
#define LN_LD_BIG 22.0L
#define LN_LD_HUGE 8.9884656743115795e307L
#else
#define LN_LD_BIG 24.0L
#define LN_LD_HUGE 5.94865747678615882543e4931L
#endif
DEFINE_COMPLEX_MATH(ln_clongdouble,ln_clongdouble,long double,
    fabsl,expl,cosl,sinl,frexpl,ldexpl,copysignl,logl,hypotl,log1pl,sqrtl,
    sinhl,coshl,tanl,atan2l,LDBL_MAX,LDBL_MIN,LDBL_MANT_DIG,
    11357.216553474703895L,22756.021937783004509L,19547,LN_LD_BIG,LN_LD_HUGE,42.0L)
#undef LN_LD_BIG
#undef LN_LD_HUGE
#undef DEFINE_COMPLEX_MATH

/* Direct adaptations of numpy/_core/src/umath/funcs.inc.src complex helpers.
 * These intentionally build on the NumPy-derived clog/cexp kernels above. */
#define DEFINE_COMPLEX_FUNCS_INC(PFX, CTYPE, RTYPE, EXP, EXPM1, SIN, COS, LOG, HYPOT, ATAN2) \
CTYPE PFX##_cexp2(CTYPE z) { \
    CTYPE a; a.real=(RTYPE)(z.real*(RTYPE)0.693147180559945309417232121458176568L); \
    a.imag=(RTYPE)(z.imag*(RTYPE)0.693147180559945309417232121458176568L); \
    return PFX##_cexp(a); \
} \
CTYPE PFX##_clog2(CTYPE z) { CTYPE r=PFX##_clog(z); \
    r.real=(RTYPE)(r.real*(RTYPE)1.44269504088896340735992468100189214L); \
    r.imag=(RTYPE)(r.imag*(RTYPE)1.44269504088896340735992468100189214L); return r; } \
CTYPE PFX##_clog10(CTYPE z) { CTYPE r=PFX##_clog(z); \
    r.real=(RTYPE)(r.real*(RTYPE)0.434294481903251827651128918916605082L); \
    r.imag=(RTYPE)(r.imag*(RTYPE)0.434294481903251827651128918916605082L); return r; } \
CTYPE PFX##_cexpm1(CTYPE z) { \
    RTYPE a=(RTYPE)SIN(z.imag/(RTYPE)2); CTYPE r; \
    r.real=(RTYPE)(EXPM1(z.real)*COS(z.imag)-(RTYPE)2*a*a); \
    r.imag=(RTYPE)(EXP(z.real)*SIN(z.imag)); return r; \
} \
CTYPE PFX##_clog1p(CTYPE z) { CTYPE r; \
    RTYPE h=(RTYPE)HYPOT(z.real+(RTYPE)1,z.imag); \
    r.real=(RTYPE)LOG(h); r.imag=(RTYPE)ATAN2(z.imag,z.real+(RTYPE)1); return r; \
}

DEFINE_COMPLEX_FUNCS_INC(ln_cfloat,ln_cfloat,float,expf,expm1f,sinf,cosf,logf,hypotf,atan2f)
DEFINE_COMPLEX_FUNCS_INC(ln_cdouble,ln_cdouble,double,exp,expm1,sin,cos,log,hypot,atan2)
DEFINE_COMPLEX_FUNCS_INC(ln_clongdouble,ln_clongdouble,long double,expl,expm1l,sinl,cosl,logl,hypotl,atan2l)
#undef DEFINE_COMPLEX_FUNCS_INC


/*
 * NumPy npy_math_complex.c.src decorates the platform C99 complex functions
 * when HAVE_CASIN*, HAVE_CACOS*, HAVE_CATAN*, HAVE_CASINH*, HAVE_CACOSH*,
 * and HAVE_CATANH* are configured.  The pinned Linux build target provides
 * these functions, so LuaRay follows that exact configured upstream path
 * rather than substituting algebraic identities with different branch-cut
 * behavior.  Storage remains LuaRay's adjacent real/imag structs.
 */
#define DEFINE_C99_COMPLEX_INVERSES(PFX, CTYPE, RTYPE, CTYPE99, PACK, CREALFN, CIMAGFN, \
                                    ASINFN, ACOSFN, ATANFN, ASINHFN, ACOSHFN, ATANHFN) \
static inline CTYPE PFX##_from_c99(CTYPE99 w) { CTYPE z; z.real=(RTYPE)CREALFN(w); z.imag=(RTYPE)CIMAGFN(w); return z; } \
CTYPE PFX##_casin(CTYPE z)  { return PFX##_from_c99(ASINFN(PACK(z.real,z.imag))); } \
CTYPE PFX##_cacos(CTYPE z)  { return PFX##_from_c99(ACOSFN(PACK(z.real,z.imag))); } \
CTYPE PFX##_catan(CTYPE z)  { return PFX##_from_c99(ATANFN(PACK(z.real,z.imag))); } \
CTYPE PFX##_casinh(CTYPE z) { return PFX##_from_c99(ASINHFN(PACK(z.real,z.imag))); } \
CTYPE PFX##_cacosh(CTYPE z) { return PFX##_from_c99(ACOSHFN(PACK(z.real,z.imag))); } \
CTYPE PFX##_catanh(CTYPE z) { return PFX##_from_c99(ATANHFN(PACK(z.real,z.imag))); }

DEFINE_C99_COMPLEX_INVERSES(ln_cfloat, ln_cfloat, float, float _Complex,
                            CMPLXF, crealf, cimagf, casinf, cacosf, catanf,
                            casinhf, cacoshf, catanhf)
DEFINE_C99_COMPLEX_INVERSES(ln_cdouble, ln_cdouble, double, double _Complex,
                            CMPLX, creal, cimag, casin, cacos, catan,
                            casinh, cacosh, catanh)
DEFINE_C99_COMPLEX_INVERSES(ln_clongdouble, ln_clongdouble, long double, long double _Complex,
                            CMPLXL, creall, cimagl, casinl, cacosl, catanl,
                            casinhl, cacoshl, catanhl)
#undef DEFINE_C99_COMPLEX_INVERSES
