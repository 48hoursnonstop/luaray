#include "ln_ufunc_loops.h"
#include "ln_half.h"
#include "ln_complex.h"
#include "ln_complex_math.h"

#include <assert.h>
#include <stdint.h>
#include <math.h>
#include <string.h>
#include <limits.h>

/*
 * Direct port/adaptation of the baseline arithmetic inner-loop structure in:
 *
 *   numpy/_core/src/umath/loops_autovec.dispatch.c.src
 *   numpy/_core/src/umath/loops_arithm_fp.dispatch.c.src
 *   numpy/_core/src/umath/loops.c.src
 *   numpy/_core/src/umath/fast_loop_macros.h
 *
 * upstream NumPy commit 286e698f1dcf601648b165f48485ceaeec9c6231.
 *
 * NumPy's NPY_CPU_DISPATCH/SIMD layer depends on NumPy build-time generated
 * headers.  This file keeps the same strided-loop ABI and its contiguous /
 * scalar fast-path organization, while replacing only that generated dispatch
 * shell.  It therefore provides a native baseline onto which the actual SIMD
 * dispatch sources can be attached as that part of the port lands.
 *
 * Signed integer functions are compiled with -fwrapv (see Makefile), matching
 * NumPy's observable modular overflow while avoiding undefined signed overflow.
 */

#define LN_BINARY_DEFS \
    char *ip1 = args[0], *ip2 = args[1], *op1 = args[2]; \
    ln_intp is1 = steps[0], is2 = steps[1], os1 = steps[2]; \
    ln_intp n = dimensions[0]; \
    ln_intp i

#define LN_BINARY_LOOP \
    LN_BINARY_DEFS; \
    for (i = 0; i < n; i++, ip1 += is1, ip2 += is2, op1 += os1)

#define LN_IS_BINARY_REDUCE \
    (assert(dimensions[0] != 0), \
     args[0] == args[2] && steps[0] == steps[2] && steps[0] == 0)

#define LN_IS_BINARY_CONT(tin, tout) \
    (steps[0] == (ln_intp)sizeof(tin) && \
     steps[1] == (ln_intp)sizeof(tin) && \
     steps[2] == (ln_intp)sizeof(tout))

#define LN_IS_BINARY_CONT_S1(tin, tout) \
    (steps[0] == 0 && steps[1] == (ln_intp)sizeof(tin) && \
     steps[2] == (ln_intp)sizeof(tout))

#define LN_IS_BINARY_CONT_S2(tin, tout) \
    (steps[0] == (ln_intp)sizeof(tin) && steps[1] == 0 && \
     steps[2] == (ln_intp)sizeof(tout))

#define LN_BASE_BINARY_LOOP(tin, tout, op) \
    LN_BINARY_LOOP { \
        const tin in1 = *(const tin *)ip1; \
        const tin in2 = *(const tin *)ip2; \
        tout *out = (tout *)op1; \
        op; \
    }

#define LN_BASE_BINARY_LOOP_S(tin, tout, cin, cinp, vin, vinp, op) \
    do { \
        const tin cin = *(const tin *)(cinp); \
        char *ip1 = args[0], *ip2 = args[1], *op1 = args[2]; \
        ln_intp is1 = steps[0], is2 = steps[1], os1 = steps[2]; \
        ln_intp n = dimensions[0]; \
        ln_intp i; \
        (void)ip1; (void)ip2; (void)is1; (void)is2; \
        for (i = 0; i < n; i++, (vinp) += ((vinp) == ip1 ? is1 : is2), op1 += os1) { \
            const tin vin = *(const tin *)(vinp); \
            tout *out = (tout *)op1; \
            op; \
        } \
    } while (0)

/* Explicit scalar branches are written out rather than relying on the macro
 * pointer-identity trick in NumPy's generated header; numerical behavior and
 * strided-loop organization are the same. */
#define LN_BINARY_LOOP_FAST(tin, tout, op) \
    do { \
        if (LN_IS_BINARY_CONT(tin, tout)) { \
            LN_BASE_BINARY_LOOP(tin, tout, op); \
        } \
        else if (LN_IS_BINARY_CONT_S1(tin, tout)) { \
            const tin scalar = *(const tin *)args[0]; \
            char *ip2_ = args[1], *op1_ = args[2]; \
            ln_intp n_ = dimensions[0], is2_ = steps[1], os1_ = steps[2]; \
            for (ln_intp i_ = 0; i_ < n_; ++i_, ip2_ += is2_, op1_ += os1_) { \
                const tin in1 = scalar; \
                const tin in2 = *(const tin *)ip2_; \
                tout *out = (tout *)op1_; \
                op; \
            } \
        } \
        else if (LN_IS_BINARY_CONT_S2(tin, tout)) { \
            const tin scalar = *(const tin *)args[1]; \
            char *ip1_ = args[0], *op1_ = args[2]; \
            ln_intp n_ = dimensions[0], is1_ = steps[0], os1_ = steps[2]; \
            for (ln_intp i_ = 0; i_ < n_; ++i_, ip1_ += is1_, op1_ += os1_) { \
                const tin in1 = *(const tin *)ip1_; \
                const tin in2 = scalar; \
                tout *out = (tout *)op1_; \
                op; \
            } \
        } \
        else { \
            LN_BASE_BINARY_LOOP(tin, tout, op); \
        } \
    } while (0)

#define LN_BINARY_REDUCE(TYPE, OP) \
    do { \
        TYPE io1 = *(TYPE *)args[0]; \
        char *ip2_ = args[1]; \
        ln_intp n_ = dimensions[0], is2_ = steps[1]; \
        for (ln_intp i_ = 0; i_ < n_; ++i_, ip2_ += is2_) { \
            const TYPE in2 = *(const TYPE *)ip2_; \
            io1 OP in2; \
        } \
        *(TYPE *)args[0] = io1; \
    } while (0)

#define DEFINE_ARITH_LOOPS(NAME, TYPE) \
    static void ln_##NAME##_add(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { \
        (void)func; \
        if (LN_IS_BINARY_REDUCE) { \
            LN_BINARY_REDUCE(TYPE, +=); \
        } else { \
            LN_BINARY_LOOP_FAST(TYPE, TYPE, *out = (TYPE)(in1 + in2)); \
        } \
    } \
    static void ln_##NAME##_subtract(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { \
        (void)func; \
        if (LN_IS_BINARY_REDUCE) { \
            LN_BINARY_REDUCE(TYPE, -=); \
        } else { \
            LN_BINARY_LOOP_FAST(TYPE, TYPE, *out = (TYPE)(in1 - in2)); \
        } \
    } \
    static void ln_##NAME##_multiply(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { \
        (void)func; \
        if (LN_IS_BINARY_REDUCE) { \
            LN_BINARY_REDUCE(TYPE, *=); \
        } else { \
            LN_BINARY_LOOP_FAST(TYPE, TYPE, *out = (TYPE)(in1 * in2)); \
        } \
    }

/* NumPy loops.h aliases BOOL_add->logical_or and BOOL_multiply->logical_and. */
static void
ln_BOOL_add(char **args, const ln_intp *dimensions, const ln_intp *steps, void *func)
{
    (void)func;
    LN_BINARY_LOOP_FAST(uint8_t, uint8_t, *out = (uint8_t)(!!in1 || !!in2));
}

static void
ln_BOOL_multiply(char **args, const ln_intp *dimensions, const ln_intp *steps, void *func)
{
    (void)func;
    LN_BINARY_LOOP_FAST(uint8_t, uint8_t, *out = (uint8_t)(!!in1 && !!in2));
}

DEFINE_ARITH_LOOPS(BYTE, int8_t)
DEFINE_ARITH_LOOPS(UBYTE, uint8_t)
DEFINE_ARITH_LOOPS(SHORT, int16_t)
DEFINE_ARITH_LOOPS(USHORT, uint16_t)
DEFINE_ARITH_LOOPS(INT, int32_t)
DEFINE_ARITH_LOOPS(UINT, uint32_t)
DEFINE_ARITH_LOOPS(LONG, long)
DEFINE_ARITH_LOOPS(ULONG, unsigned long)
DEFINE_ARITH_LOOPS(LONGLONG, long long)
DEFINE_ARITH_LOOPS(ULONGLONG, unsigned long long)

/*
 * Direct port of loops_utils.h.src:*_pairwise_sum and the reduction branch in
 * loops_arithm_fp.dispatch.c.src / loops.c.src.  NumPy uses this for add
 * reductions so floating-point error grows O(log n), not O(n).
 */
#define LN_PW_BLOCKSIZE 128

#define DEFINE_PAIRWISE_SUM(NAME, TYPE) \
    static TYPE ln_##NAME##_pairwise_sum(char *a, ln_intp n, ln_intp stride) { \
        if (n < 8) { \
            TYPE res = (TYPE)-0.0; \
            for (ln_intp i = 0; i < n; ++i) { \
                res += *(TYPE *)(a + i * stride); \
            } \
            return res; \
        } \
        else if (n <= LN_PW_BLOCKSIZE) { \
            TYPE r[8], res; \
            r[0] = *(TYPE *)(a + 0 * stride); \
            r[1] = *(TYPE *)(a + 1 * stride); \
            r[2] = *(TYPE *)(a + 2 * stride); \
            r[3] = *(TYPE *)(a + 3 * stride); \
            r[4] = *(TYPE *)(a + 4 * stride); \
            r[5] = *(TYPE *)(a + 5 * stride); \
            r[6] = *(TYPE *)(a + 6 * stride); \
            r[7] = *(TYPE *)(a + 7 * stride); \
            ln_intp i; \
            for (i = 8; i < n - (n % 8); i += 8) { \
                r[0] += *(TYPE *)(a + (i + 0) * stride); \
                r[1] += *(TYPE *)(a + (i + 1) * stride); \
                r[2] += *(TYPE *)(a + (i + 2) * stride); \
                r[3] += *(TYPE *)(a + (i + 3) * stride); \
                r[4] += *(TYPE *)(a + (i + 4) * stride); \
                r[5] += *(TYPE *)(a + (i + 5) * stride); \
                r[6] += *(TYPE *)(a + (i + 6) * stride); \
                r[7] += *(TYPE *)(a + (i + 7) * stride); \
            } \
            res = ((r[0] + r[1]) + (r[2] + r[3])) + \
                  ((r[4] + r[5]) + (r[6] + r[7])); \
            for (; i < n; ++i) { \
                res += *(TYPE *)(a + i * stride); \
            } \
            return res; \
        } \
        else { \
            ln_intp n2 = n / 2; \
            n2 -= n2 % 8; \
            return ln_##NAME##_pairwise_sum(a, n2, stride) + \
                   ln_##NAME##_pairwise_sum(a + n2 * stride, n - n2, stride); \
        } \
    }

DEFINE_PAIRWISE_SUM(FLOAT, float)
DEFINE_PAIRWISE_SUM(DOUBLE, double)
DEFINE_PAIRWISE_SUM(LONGDOUBLE, long double)

#define DEFINE_FP_ARITH_LOOPS(NAME, TYPE) \
    static void ln_##NAME##_add(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { \
        (void)func; \
        if (LN_IS_BINARY_REDUCE) { \
            TYPE *acc = (TYPE *)args[0]; \
            *acc += ln_##NAME##_pairwise_sum(args[1], dimensions[0], steps[1]); \
        } else { \
            LN_BINARY_LOOP_FAST(TYPE, TYPE, *out = (TYPE)(in1 + in2)); \
        } \
    } \
    static void ln_##NAME##_subtract(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { \
        (void)func; \
        if (LN_IS_BINARY_REDUCE) { \
            LN_BINARY_REDUCE(TYPE, -=); \
        } else { \
            LN_BINARY_LOOP_FAST(TYPE, TYPE, *out = (TYPE)(in1 - in2)); \
        } \
    } \
    static void ln_##NAME##_multiply(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { \
        (void)func; \
        if (LN_IS_BINARY_REDUCE) { \
            LN_BINARY_REDUCE(TYPE, *=); \
        } else { \
            LN_BINARY_LOOP_FAST(TYPE, TYPE, *out = (TYPE)(in1 * in2)); \
        } \
    } \
    static void ln_##NAME##_true_divide(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { \
        (void)func; \
        if (LN_IS_BINARY_REDUCE) { \
            LN_BINARY_REDUCE(TYPE, /=); \
        } else { \
            LN_BINARY_LOOP_FAST(TYPE, TYPE, *out = (TYPE)(in1 / in2)); \
        } \
    }

DEFINE_FP_ARITH_LOOPS(FLOAT, float)
DEFINE_FP_ARITH_LOOPS(DOUBLE, double)
DEFINE_FP_ARITH_LOOPS(LONGDOUBLE, long double)

/*
 * Additional arithmetic loops ported from:
 *   loops_arithmetic.dispatch.c.src  (integer floor_divide)
 *   loops_modulo.dispatch.c.src      (integer remainder)
 *   loops.c.src                      (integer power, floating modulo/power/copysign)
 *   npymath/npy_math_internal.h.src  (floating divmod convention)
 *   loops_autovec.dispatch.c.src     (integer bitwise operations)
 */
#define DEFINE_SIGNED_DIVMOD_POWER(NAME, TYPE, MINV) \
    static TYPE ln_##NAME##_floor_scalar(TYPE n, TYPE d) { \
        if (d == 0) return (TYPE)0; \
        if (n == (TYPE)(MINV) && d == (TYPE)-1) return (TYPE)(MINV); \
        TYPE r = (TYPE)(n / d); \
        if (((n > 0) != (d > 0)) && ((TYPE)(r * d) != n)) r--; \
        return r; \
    } \
    static TYPE ln_##NAME##_rem_scalar(TYPE a, TYPE b) { \
        if (b == 0 || (a == (TYPE)(MINV) && b == (TYPE)-1)) return (TYPE)0; \
        TYPE r = (TYPE)(a % b); \
        if (!((a > 0) == (b > 0) || r == 0)) r = (TYPE)(r + b); \
        return r; \
    } \
    static TYPE ln_##NAME##_pow_scalar(TYPE base, TYPE exp) { \
        if (exp < 0) return (TYPE)0; /* rejected before entering the loop */ \
        TYPE out = (TYPE)1; \
        while (exp > 0) { \
            if (exp & 1) out = (TYPE)(out * base); \
            exp = (TYPE)(exp >> 1); \
            if (exp) base = (TYPE)(base * base); \
        } \
        return out; \
    } \
    static void ln_##NAME##_floor_divide(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=ln_##NAME##_floor_scalar(in1,in2));} \
    static void ln_##NAME##_remainder(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=ln_##NAME##_rem_scalar(in1,in2));} \
    static void ln_##NAME##_power(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=ln_##NAME##_pow_scalar(in1,in2));} \
    static void ln_##NAME##_bitwise_and(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=(TYPE)(in1 & in2));} \
    static void ln_##NAME##_bitwise_or(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=(TYPE)(in1 | in2));} \
    static void ln_##NAME##_bitwise_xor(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=(TYPE)(in1 ^ in2));} \
    static void ln_##NAME##_fmax(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=(in1>in2)?in1:in2);} \
    static void ln_##NAME##_fmin(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=(in1<in2)?in1:in2);}

#define DEFINE_UNSIGNED_DIVMOD_POWER(NAME, TYPE) \
    static TYPE ln_##NAME##_pow_scalar(TYPE base, TYPE exp) { \
        TYPE out = (TYPE)1; \
        while (exp > 0) { \
            if (exp & 1) out = (TYPE)(out * base); \
            exp = (TYPE)(exp >> 1); \
            if (exp) base = (TYPE)(base * base); \
        } \
        return out; \
    } \
    static void ln_##NAME##_floor_divide(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=(in2==0)?(TYPE)0:(TYPE)(in1/in2));} \
    static void ln_##NAME##_remainder(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=(in2==0)?(TYPE)0:(TYPE)(in1%in2));} \
    static void ln_##NAME##_power(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=ln_##NAME##_pow_scalar(in1,in2));} \
    static void ln_##NAME##_bitwise_and(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=(TYPE)(in1 & in2));} \
    static void ln_##NAME##_bitwise_or(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=(TYPE)(in1 | in2));} \
    static void ln_##NAME##_bitwise_xor(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=(TYPE)(in1 ^ in2));} \
    static void ln_##NAME##_fmax(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=(in1>in2)?in1:in2);} \
    static void ln_##NAME##_fmin(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=(in1<in2)?in1:in2);}

DEFINE_SIGNED_DIVMOD_POWER(BYTE, int8_t, SCHAR_MIN)
DEFINE_UNSIGNED_DIVMOD_POWER(UBYTE, uint8_t)
DEFINE_SIGNED_DIVMOD_POWER(SHORT, int16_t, SHRT_MIN)
DEFINE_UNSIGNED_DIVMOD_POWER(USHORT, uint16_t)
DEFINE_SIGNED_DIVMOD_POWER(INT, int32_t, INT_MIN)
DEFINE_UNSIGNED_DIVMOD_POWER(UINT, uint32_t)
DEFINE_SIGNED_DIVMOD_POWER(LONG, long, LONG_MIN)
DEFINE_UNSIGNED_DIVMOD_POWER(ULONG, unsigned long)
DEFINE_SIGNED_DIVMOD_POWER(LONGLONG, long long, LLONG_MIN)
DEFINE_UNSIGNED_DIVMOD_POWER(ULONGLONG, unsigned long long)

#undef DEFINE_SIGNED_DIVMOD_POWER
#undef DEFINE_UNSIGNED_DIVMOD_POWER

/* bool bitwise aliases are logical operations upstream.  floor/remainder/power
 * do not resolve to the bool loop (the resolver chooses int8), but definitions
 * are provided defensively for the generic table. */
static void ln_BOOL_bitwise_and(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(uint8_t,uint8_t,*out=(uint8_t)(!!in1 && !!in2));}
static void ln_BOOL_bitwise_or(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(uint8_t,uint8_t,*out=(uint8_t)(!!in1 || !!in2));}
static void ln_BOOL_bitwise_xor(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(uint8_t,uint8_t,*out=(uint8_t)(!!in1 != !!in2));}
static void ln_BOOL_floor_divide(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(uint8_t,uint8_t,*out=(uint8_t)(in2?in1/in2:0));}
static void ln_BOOL_remainder(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(uint8_t,uint8_t,(void)in1;(void)in2;*out=(uint8_t)0);}
static void ln_BOOL_power(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(uint8_t,uint8_t,*out=(uint8_t)((in2==0)||in1));}
static void ln_BOOL_fmax(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(uint8_t,uint8_t,*out=(uint8_t)(!!in1||!!in2));}
static void ln_BOOL_fmin(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(uint8_t,uint8_t,*out=(uint8_t)(!!in1&&!!in2));}

#define DEFINE_FP_EXTRA(NAME, TYPE, FMODFN, FLOORFN, COPYSIGNFN, POWFN, FMAXFN, FMINFN) \
    static TYPE ln_##NAME##_divmod_scalar(TYPE a, TYPE b, TYPE *modulus) { \
        TYPE mod = FMODFN(a,b); \
        if (!b) { *modulus=mod; return (TYPE)(a/b); } \
        TYPE div=(TYPE)((a-mod)/b), floordiv; \
        if (mod) { if (isless(b,(TYPE)0)!=isless(mod,(TYPE)0)) { mod=(TYPE)(mod+b); div=(TYPE)(div-1); } } \
        else mod=COPYSIGNFN((TYPE)0,b); \
        if (div) { floordiv=FLOORFN(div); if (isgreater((TYPE)(div-floordiv),(TYPE)0.5)) floordiv=(TYPE)(floordiv+1); } \
        else floordiv=COPYSIGNFN((TYPE)0,(TYPE)(a/b)); \
        *modulus=mod; return floordiv; \
    } \
    static TYPE ln_##NAME##_floor_scalar(TYPE a, TYPE b){TYPE m;if(!b)return (TYPE)(a/b);return ln_##NAME##_divmod_scalar(a,b,&m);} \
    static TYPE ln_##NAME##_rem_scalar(TYPE a, TYPE b){TYPE m;if(!b)return FMODFN(a,b);ln_##NAME##_divmod_scalar(a,b,&m);return m;} \
    static void ln_##NAME##_floor_divide(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=ln_##NAME##_floor_scalar(in1,in2));} \
    static void ln_##NAME##_remainder(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=ln_##NAME##_rem_scalar(in1,in2));} \
    static void ln_##NAME##_power(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=(TYPE)POWFN(in1,in2));} \
    static void ln_##NAME##_fmax(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=(TYPE)FMAXFN(in1,in2));} \
    static void ln_##NAME##_fmin(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=(TYPE)FMINFN(in1,in2));} \
    static void ln_##NAME##_copysign(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=(TYPE)COPYSIGNFN(in1,in2));}

DEFINE_FP_EXTRA(FLOAT,float,fmodf,floorf,copysignf,powf,fmaxf,fminf)
DEFINE_FP_EXTRA(DOUBLE,double,fmod,floor,copysign,pow,fmax,fmin)
DEFINE_FP_EXTRA(LONGDOUBLE,long double,fmodl,floorl,copysignl,powl,fmaxl,fminl)
#undef DEFINE_FP_EXTRA

/* Unary transcendental baseline loops.  These mirror the scalar fallback of
 * loops_unary_fp.dispatch.c.src / loops_exponent_log.dispatch.c.src /
 * loops_trigonometric.dispatch.cpp once the type resolver has selected the
 * float32/float64/longdouble loop. */
#define DEFINE_FP_MATH_UNARY(NAME, TYPE, SQRTFN, EXPFN, LOGFN, SINFN, COSFN, TANFN) \
    static void ln_##NAME##_sqrt(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,(void)in2;*out=(TYPE)SQRTFN(in1));} \
    static void ln_##NAME##_exp(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,(void)in2;*out=(TYPE)EXPFN(in1));} \
    static void ln_##NAME##_log(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,(void)in2;*out=(TYPE)LOGFN(in1));} \
    static void ln_##NAME##_sin(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,(void)in2;*out=(TYPE)SINFN(in1));} \
    static void ln_##NAME##_cos(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,(void)in2;*out=(TYPE)COSFN(in1));} \
    static void ln_##NAME##_tan(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,(void)in2;*out=(TYPE)TANFN(in1));}

DEFINE_FP_MATH_UNARY(FLOAT,float,sqrtf,expf,logf,sinf,cosf,tanf)
DEFINE_FP_MATH_UNARY(DOUBLE,double,sqrt,exp,log,sin,cos,tan)
DEFINE_FP_MATH_UNARY(LONGDOUBLE,long double,sqrtl,expl,logl,sinl,cosl,tanl)

#define DEFINE_FP_MATH_EXT(NAME, TYPE, SINHFN, COSHFN, TANHFN, EXP2FN, LOG2FN, LOG10FN, EXPM1FN, LOG1PFN, CBRTFN) \
    static void ln_##NAME##_sinh(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,(void)in2;*out=(TYPE)SINHFN(in1));} \
    static void ln_##NAME##_cosh(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,(void)in2;*out=(TYPE)COSHFN(in1));} \
    static void ln_##NAME##_tanh(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,(void)in2;*out=(TYPE)TANHFN(in1));} \
    static void ln_##NAME##_exp2(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,(void)in2;*out=(TYPE)EXP2FN(in1));} \
    static void ln_##NAME##_log2(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,(void)in2;*out=(TYPE)LOG2FN(in1));} \
    static void ln_##NAME##_log10(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,(void)in2;*out=(TYPE)LOG10FN(in1));} \
    static void ln_##NAME##_expm1(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,(void)in2;*out=(TYPE)EXPM1FN(in1));} \
    static void ln_##NAME##_log1p(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,(void)in2;*out=(TYPE)LOG1PFN(in1));} \
    static void ln_##NAME##_cbrt(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,(void)in2;*out=(TYPE)CBRTFN(in1));}

DEFINE_FP_MATH_EXT(FLOAT,float,sinhf,coshf,tanhf,exp2f,log2f,log10f,expm1f,log1pf,cbrtf)
DEFINE_FP_MATH_EXT(DOUBLE,double,sinh,cosh,tanh,exp2,log2,log10,expm1,log1p,cbrt)
DEFINE_FP_MATH_EXT(LONGDOUBLE,long double,sinhl,coshl,tanhl,exp2l,log2l,log10l,expm1l,log1pl,cbrtl)
#undef DEFINE_FP_MATH_EXT

/* Inverse trigonometric/hyperbolic scalar fallbacks from the same generated
 * loops_umath_fp.dispatch.c.src family. */
#define DEFINE_FP_MATH_INV(NAME, TYPE, ASINFN, ACOSFN, ATANFN, ASINHFN, ACOSHFN, ATANHFN) \
    static void ln_##NAME##_arcsin(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,(void)in2;*out=(TYPE)ASINFN(in1));} \
    static void ln_##NAME##_arccos(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,(void)in2;*out=(TYPE)ACOSFN(in1));} \
    static void ln_##NAME##_arctan(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,(void)in2;*out=(TYPE)ATANFN(in1));} \
    static void ln_##NAME##_arcsinh(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,(void)in2;*out=(TYPE)ASINHFN(in1));} \
    static void ln_##NAME##_arccosh(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,(void)in2;*out=(TYPE)ACOSHFN(in1));} \
    static void ln_##NAME##_arctanh(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,(void)in2;*out=(TYPE)ATANHFN(in1));}
DEFINE_FP_MATH_INV(FLOAT,float,asinf,acosf,atanf,asinhf,acoshf,atanhf)
DEFINE_FP_MATH_INV(DOUBLE,double,asin,acos,atan,asinh,acosh,atanh)
DEFINE_FP_MATH_INV(LONGDOUBLE,long double,asinl,acosl,atanl,asinhl,acoshl,atanhl)
#undef DEFINE_FP_MATH_INV

#define DEFINE_FP_BINARY_GEOM(NAME, TYPE, ATAN2FN, HYPOTFN) \
    static void ln_##NAME##_arctan2(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=(TYPE)ATAN2FN(in1,in2));} \
    static void ln_##NAME##_hypot(char **args,const ln_intp*dimensions,const ln_intp*steps,void*f){(void)f;LN_BINARY_LOOP_FAST(TYPE,TYPE,*out=(TYPE)HYPOTFN(in1,in2));}
DEFINE_FP_BINARY_GEOM(FLOAT,float,atan2f,hypotf)
DEFINE_FP_BINARY_GEOM(DOUBLE,double,atan2,hypot)
DEFINE_FP_BINARY_GEOM(LONGDOUBLE,long double,atan2l,hypotl)
#undef DEFINE_FP_BINARY_GEOM


/*
 * HALF loops are direct C adaptations of NumPy main's HALF section in
 * loops.c.src, loops_half.dispatch.c.src, and HALF_absolute in
 * loops_autovec.dispatch.c.src.  NumPy represents binary16 as uint16_t and
 * performs arithmetic/transcendentals through float before rounding back to
 * half.  Keep the bit-level comparisons/predicates to preserve signed-zero and
 * NaN behavior without relying on the host compiler's _Float16 support.
 */
static inline ln_half ln_half_load(const char *p)
{
    ln_half h;
    memcpy(&h, p, sizeof(h));
    return h;
}

static inline void ln_half_store(char *p, ln_half h)
{
    memcpy(p, &h, sizeof(h));
}

static float
ln_HALF_pairwise_sum(char *a, ln_intp n, ln_intp stride)
{
    if (n < 8) {
        float res = -0.0f;
        for (ln_intp i = 0; i < n; ++i) {
            res += ln_half_to_float(ln_half_load(a + i * stride));
        }
        return res;
    }
    if (n <= LN_PW_BLOCKSIZE) {
        float r[8], res;
        for (int k = 0; k < 8; ++k) {
            r[k] = ln_half_to_float(ln_half_load(a + (ln_intp)k * stride));
        }
        ln_intp i;
        for (i = 8; i < n - (n % 8); i += 8) {
            for (int k = 0; k < 8; ++k) {
                r[k] += ln_half_to_float(ln_half_load(a + (i + k) * stride));
            }
        }
        res = ((r[0] + r[1]) + (r[2] + r[3])) +
              ((r[4] + r[5]) + (r[6] + r[7]));
        for (; i < n; ++i) {
            res += ln_half_to_float(ln_half_load(a + i * stride));
        }
        return res;
    }
    ln_intp n2 = n / 2;
    n2 -= n2 % 8;
    return ln_HALF_pairwise_sum(a, n2, stride) +
           ln_HALF_pairwise_sum(a + n2 * stride, n - n2, stride);
}

#define LN_HALF_BINARY_BODY(EXPR) \
    do { \
        char *p0=args[0], *p1=args[1], *po=args[2]; \
        for (ln_intp i=0; i<d[0]; ++i, p0+=s[0], p1+=s[1], po+=s[2]) { \
            const ln_half h1=ln_half_load(p0), h2=ln_half_load(p1); \
            const float in1=ln_half_to_float(h1), in2=ln_half_to_float(h2); \
            ln_half_store(po, (EXPR)); \
        } \
    } while (0)

static void ln_HALF_add(char **args,const ln_intp*d,const ln_intp*s,void*f)
{
    (void)f;
    if ((assert(d[0] != 0), args[0]==args[2] && s[0]==s[2] && s[0]==0)) {
        float acc=ln_half_to_float(ln_half_load(args[0]));
        acc += ln_HALF_pairwise_sum(args[1], d[0], s[1]);
        ln_half_store(args[0], ln_float_to_half(acc));
        return;
    }
    LN_HALF_BINARY_BODY(ln_float_to_half(in1 + in2));
}
static void ln_HALF_subtract(char **args,const ln_intp*d,const ln_intp*s,void*f)
{
    (void)f;
    if ((assert(d[0] != 0), args[0]==args[2] && s[0]==s[2] && s[0]==0)) {
        float acc=ln_half_to_float(ln_half_load(args[0]));
        char *p=args[1];
        for(ln_intp i=0;i<d[0];++i,p+=s[1]) acc-=ln_half_to_float(ln_half_load(p));
        ln_half_store(args[0],ln_float_to_half(acc)); return;
    }
    LN_HALF_BINARY_BODY(ln_float_to_half(in1 - in2));
}
static void ln_HALF_multiply(char **args,const ln_intp*d,const ln_intp*s,void*f)
{
    (void)f;
    if ((assert(d[0] != 0), args[0]==args[2] && s[0]==s[2] && s[0]==0)) {
        float acc=ln_half_to_float(ln_half_load(args[0]));
        char *p=args[1];
        for(ln_intp i=0;i<d[0];++i,p+=s[1]) acc*=ln_half_to_float(ln_half_load(p));
        ln_half_store(args[0],ln_float_to_half(acc)); return;
    }
    LN_HALF_BINARY_BODY(ln_float_to_half(in1 * in2));
}
static void ln_HALF_true_divide(char **args,const ln_intp*d,const ln_intp*s,void*f)
{
    (void)f;
    if ((assert(d[0] != 0), args[0]==args[2] && s[0]==s[2] && s[0]==0)) {
        float acc=ln_half_to_float(ln_half_load(args[0]));
        char *p=args[1];
        for(ln_intp i=0;i<d[0];++i,p+=s[1]) acc/=ln_half_to_float(ln_half_load(p));
        ln_half_store(args[0],ln_float_to_half(acc)); return;
    }
    LN_HALF_BINARY_BODY(ln_float_to_half(in1 / in2));
}
static void ln_HALF_floor_divide(char **args,const ln_intp*d,const ln_intp*s,void*f)
{(void)f; (void)d; (void)s; LN_HALF_BINARY_BODY(ln_float_to_half(ln_FLOAT_floor_scalar(in1,in2)));}
static void ln_HALF_remainder(char **args,const ln_intp*d,const ln_intp*s,void*f)
{(void)f; (void)d; (void)s; LN_HALF_BINARY_BODY(ln_float_to_half(ln_FLOAT_rem_scalar(in1,in2)));}
static void ln_HALF_power(char **args,const ln_intp*d,const ln_intp*s,void*f)
{(void)f; (void)d; (void)s; LN_HALF_BINARY_BODY(ln_float_to_half(powf(in1,in2)));}
static void ln_HALF_copysign(char **args,const ln_intp*d,const ln_intp*s,void*f)
{
    (void)f; char *p0=args[0],*p1=args[1],*po=args[2];
    for(ln_intp i=0;i<d[0];++i,p0+=s[0],p1+=s[1],po+=s[2])
        ln_half_store(po,ln_half_copysign(ln_half_load(p0),ln_half_load(p1)));
}

#define LN_HALF_BOOL_BINARY(NAME, EXPR) \
static void ln_HALF_##NAME(char **args,const ln_intp*d,const ln_intp*s,void*f) { \
    (void)f; char *p0=args[0],*p1=args[1],*po=args[2]; \
    for(ln_intp i=0;i<d[0];++i,p0+=s[0],p1+=s[1],po+=s[2]) { \
        ln_half h1=ln_half_load(p0), h2=ln_half_load(p1); uint8_t v=(uint8_t)(EXPR); memcpy(po,&v,1); \
    } \
}
LN_HALF_BOOL_BINARY(equal, ln_half_eq(h1,h2))
LN_HALF_BOOL_BINARY(not_equal, ln_half_ne(h1,h2))
LN_HALF_BOOL_BINARY(less, ln_half_lt(h1,h2))
LN_HALF_BOOL_BINARY(less_equal, ln_half_le(h1,h2))
LN_HALF_BOOL_BINARY(greater, ln_half_gt(h1,h2))
LN_HALF_BOOL_BINARY(greater_equal, ln_half_ge(h1,h2))
LN_HALF_BOOL_BINARY(logical_and, !ln_half_iszero(h1) && !ln_half_iszero(h2))
LN_HALF_BOOL_BINARY(logical_or, !ln_half_iszero(h1) || !ln_half_iszero(h2))
LN_HALF_BOOL_BINARY(logical_xor, (!ln_half_iszero(h1)) != (!ln_half_iszero(h2)))
#undef LN_HALF_BOOL_BINARY

#define LN_HALF_SELECT_BINARY(NAME, EXPR) \
static void ln_HALF_##NAME(char **args,const ln_intp*d,const ln_intp*s,void*f) { \
    (void)f; char *p0=args[0],*p1=args[1],*po=args[2]; \
    for(ln_intp i=0;i<d[0];++i,p0+=s[0],p1+=s[1],po+=s[2]) { \
        ln_half h1=ln_half_load(p0), h2=ln_half_load(p1); ln_half_store(po,(EXPR)); \
    } \
}
LN_HALF_SELECT_BINARY(maximum, (ln_half_ge(h1,h2)||ln_half_isnan(h1))?h1:h2)
LN_HALF_SELECT_BINARY(minimum, (ln_half_le(h1,h2)||ln_half_isnan(h1))?h1:h2)
LN_HALF_SELECT_BINARY(fmax, (ln_half_ge(h1,h2)||ln_half_isnan(h2))?h1:h2)
LN_HALF_SELECT_BINARY(fmin, (ln_half_le(h1,h2)||ln_half_isnan(h2))?h1:h2)
#undef LN_HALF_SELECT_BINARY

#define LN_HALF_UNARY_HALF(NAME, EXPR) \
static void ln_HALF_##NAME(char **args,const ln_intp*d,const ln_intp*s,void*f) { \
    (void)f; char *pi=args[0],*po=args[2]; \
    for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]) { ln_half h=ln_half_load(pi); ln_half_store(po,(EXPR)); } \
}
LN_HALF_UNARY_HALF(negative, (ln_half)(h^0x8000u))
LN_HALF_UNARY_HALF(absolute, (ln_half)(h&0x7fffu))
LN_HALF_UNARY_HALF(positive, h)
LN_HALF_UNARY_HALF(sign, ln_half_isnan(h)?h:(ln_half_iszero(h)?LN_HALF_ZERO:(ln_half_signbit(h)?LN_HALF_NEGONE:LN_HALF_ONE)))
#undef LN_HALF_UNARY_HALF

#define LN_HALF_UNARY_BOOL(NAME, EXPR) \
static void ln_HALF_##NAME(char **args,const ln_intp*d,const ln_intp*s,void*f) { \
    (void)f; char *pi=args[0],*po=args[2]; \
    for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]) { ln_half h=ln_half_load(pi); uint8_t v=(uint8_t)(EXPR); memcpy(po,&v,1); } \
}
LN_HALF_UNARY_BOOL(logical_not, ln_half_iszero(h))
LN_HALF_UNARY_BOOL(isnan, ln_half_isnan(h))
LN_HALF_UNARY_BOOL(isinf, ln_half_isinf(h))
LN_HALF_UNARY_BOOL(isfinite, ln_half_isfinite(h))
LN_HALF_UNARY_BOOL(signbit, ln_half_signbit(h))
#undef LN_HALF_UNARY_BOOL

#define LN_HALF_MATH(NAME, FN) \
static void ln_HALF_##NAME(char **args,const ln_intp*d,const ln_intp*s,void*f) { \
    (void)f; char *pi=args[0],*po=args[2]; \
    for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]) { \
        float x=ln_half_to_float(ln_half_load(pi)); ln_half_store(po,ln_float_to_half(FN(x))); \
    } \
}
LN_HALF_MATH(sqrt,sqrtf)
LN_HALF_MATH(exp,expf)
LN_HALF_MATH(log,logf)
LN_HALF_MATH(sin,sinf)
LN_HALF_MATH(cos,cosf)
LN_HALF_MATH(tan,tanf)
LN_HALF_MATH(sinh,sinhf)
LN_HALF_MATH(cosh,coshf)
LN_HALF_MATH(tanh,tanhf)
LN_HALF_MATH(exp2,exp2f)
LN_HALF_MATH(log2,log2f)
LN_HALF_MATH(log10,log10f)
LN_HALF_MATH(expm1,expm1f)
LN_HALF_MATH(log1p,log1pf)
LN_HALF_MATH(cbrt,cbrtf)
LN_HALF_MATH(arcsin,asinf)
LN_HALF_MATH(arccos,acosf)
LN_HALF_MATH(arctan,atanf)
LN_HALF_MATH(arcsinh,asinhf)
LN_HALF_MATH(arccosh,acoshf)
LN_HALF_MATH(arctanh,atanhf)
#undef LN_HALF_MATH

#define LN_HALF_BINARY_MATH(NAME, FN) \
static void ln_HALF_##NAME(char **args,const ln_intp*d,const ln_intp*s,void*f) { \
    (void)f; char *p0=args[0],*p1=args[1],*po=args[2]; \
    for(ln_intp i=0;i<d[0];++i,p0+=s[0],p1+=s[1],po+=s[2]) { \
        float a=ln_half_to_float(ln_half_load(p0)); float b=ln_half_to_float(ln_half_load(p1)); \
        ln_half_store(po,ln_float_to_half(FN(a,b))); \
    } \
}
LN_HALF_BINARY_MATH(arctan2,atan2f)
LN_HALF_BINARY_MATH(hypot,hypotf)
#undef LN_HALF_BINARY_MATH
#undef LN_HALF_BINARY_BODY
#undef DEFINE_FP_MATH_UNARY



/*
 * Complex baseline loops are direct C adaptations of the COMPLEX LOOPS block
 * in numpy/_core/src/umath/loops.c.src at the pinned upstream commit.  Storage
 * is the same adjacent real/imag pair used by NumPy's legacy complex dtypes.
 */
#define DEFINE_COMPLEX_LOOPS(NAME, FTYPE, CTYPE, ABSFN, HYPOTFN) \
    static void ln_##NAME##_pairwise_sum(FTYPE *rr, FTYPE *ri, char *a, ln_intp n, ln_intp stride) { \
        if (n < 4) { \
            *rr=(FTYPE)-0.0; *ri=(FTYPE)-0.0; \
            for(ln_intp i=0;i<n;++i){ CTYPE z; memcpy(&z,a+i*stride,sizeof(z)); *rr+=z.real; *ri+=z.imag; } \
            return; \
        } \
        if (n <= LN_PW_BLOCKSIZE/2) { \
            FTYPE r[8]; CTYPE z; \
            memcpy(&z,a+0*stride,sizeof(z)); r[0]=z.real; r[1]=z.imag; \
            memcpy(&z,a+1*stride,sizeof(z)); r[2]=z.real; r[3]=z.imag; \
            memcpy(&z,a+2*stride,sizeof(z)); r[4]=z.real; r[5]=z.imag; \
            memcpy(&z,a+3*stride,sizeof(z)); r[6]=z.real; r[7]=z.imag; \
            ln_intp i; \
            for(i=4;i<n-(n%4);i+=4){ \
                memcpy(&z,a+(i+0)*stride,sizeof(z)); r[0]+=z.real; r[1]+=z.imag; \
                memcpy(&z,a+(i+1)*stride,sizeof(z)); r[2]+=z.real; r[3]+=z.imag; \
                memcpy(&z,a+(i+2)*stride,sizeof(z)); r[4]+=z.real; r[5]+=z.imag; \
                memcpy(&z,a+(i+3)*stride,sizeof(z)); r[6]+=z.real; r[7]+=z.imag; \
            } \
            *rr=(r[0]+r[2])+(r[4]+r[6]); *ri=(r[1]+r[3])+(r[5]+r[7]); \
            for(;i<n;++i){memcpy(&z,a+i*stride,sizeof(z));*rr+=z.real;*ri+=z.imag;} \
            return; \
        } \
        ln_intp n2=n/2; n2-=n2%4; FTYPE rr1,ri1,rr2,ri2; \
        ln_##NAME##_pairwise_sum(&rr1,&ri1,a,n2,stride); \
        ln_##NAME##_pairwise_sum(&rr2,&ri2,a+n2*stride,n-n2,stride); \
        *rr=rr1+rr2; *ri=ri1+ri2; \
    } \
    static CTYPE ln_##NAME##_mul_scalar(CTYPE a, CTYPE b) { \
        CTYPE z; z.real=a.real*b.real-a.imag*b.imag; z.imag=a.real*b.imag+a.imag*b.real; return z; \
    } \
    static CTYPE ln_##NAME##_div_scalar(CTYPE a, CTYPE b) { \
        CTYPE z; FTYPE abr=(FTYPE)ABSFN(b.real); FTYPE abi=(FTYPE)ABSFN(b.imag); \
        if(abr>=abi){ \
            if(abr==0){ z.real=a.real/abr; z.imag=a.imag/abi; } \
            else { FTYPE rat=b.imag/b.real; FTYPE scl=(FTYPE)1/(b.real+b.imag*rat); z.real=(a.real+a.imag*rat)*scl; z.imag=(a.imag-a.real*rat)*scl; } \
        } else { \
            FTYPE rat=b.real/b.imag; FTYPE scl=(FTYPE)1/(b.imag+b.real*rat); z.real=(a.real*rat+a.imag)*scl; z.imag=(a.imag*rat-a.real)*scl; \
        } \
        return z; \
    } \
    static void ln_##NAME##_add(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; \
        if ((assert(d[0]!=0),args[0]==args[2]&&s[0]==s[2]&&s[0]==0)) { \
            CTYPE acc; memcpy(&acc,args[0],sizeof(acc)); FTYPE rr,ri; ln_##NAME##_pairwise_sum(&rr,&ri,args[1],d[0],s[1]); acc.real+=rr;acc.imag+=ri;memcpy(args[0],&acc,sizeof(acc));return; \
        } \
        char *p0=args[0],*p1=args[1],*po=args[2]; for(ln_intp i=0;i<d[0];++i,p0+=s[0],p1+=s[1],po+=s[2]){ CTYPE a,b,z;memcpy(&a,p0,sizeof(a));memcpy(&b,p1,sizeof(b));z.real=a.real+b.real;z.imag=a.imag+b.imag;memcpy(po,&z,sizeof(z)); } \
    } \
    static void ln_##NAME##_subtract(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *p0=args[0],*p1=args[1],*po=args[2]; for(ln_intp i=0;i<d[0];++i,p0+=s[0],p1+=s[1],po+=s[2]){ CTYPE a,b,z;memcpy(&a,p0,sizeof(a));memcpy(&b,p1,sizeof(b));z.real=a.real-b.real;z.imag=a.imag-b.imag;memcpy(po,&z,sizeof(z)); } \
    } \
    static void ln_##NAME##_multiply(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; \
        if ((assert(d[0]!=0),args[0]==args[2]&&s[0]==s[2]&&s[0]==0)) { CTYPE acc;memcpy(&acc,args[0],sizeof(acc));char *p=args[1];for(ln_intp i=0;i<d[0];++i,p+=s[1]){CTYPE b;memcpy(&b,p,sizeof(b));acc=ln_##NAME##_mul_scalar(acc,b);}memcpy(args[0],&acc,sizeof(acc));return; } \
        char *p0=args[0],*p1=args[1],*po=args[2]; for(ln_intp i=0;i<d[0];++i,p0+=s[0],p1+=s[1],po+=s[2]){ CTYPE a,b,z;memcpy(&a,p0,sizeof(a));memcpy(&b,p1,sizeof(b));z=ln_##NAME##_mul_scalar(a,b);memcpy(po,&z,sizeof(z)); } \
    } \
    static void ln_##NAME##_true_divide(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *p0=args[0],*p1=args[1],*po=args[2]; for(ln_intp i=0;i<d[0];++i,p0+=s[0],p1+=s[1],po+=s[2]){ CTYPE a,b,z;memcpy(&a,p0,sizeof(a));memcpy(&b,p1,sizeof(b));z=ln_##NAME##_div_scalar(a,b);memcpy(po,&z,sizeof(z)); } \
    } \
    static void ln_##NAME##_equal(char **args,const ln_intp*d,const ln_intp*s,void*f){(void)f;char*p0=args[0],*p1=args[1],*po=args[2];for(ln_intp i=0;i<d[0];++i,p0+=s[0],p1+=s[1],po+=s[2]){CTYPE a,b;memcpy(&a,p0,sizeof(a));memcpy(&b,p1,sizeof(b));uint8_t v=(uint8_t)LN_COMPLEX_EQ(a.real,a.imag,b.real,b.imag);memcpy(po,&v,1);}} \
    static void ln_##NAME##_not_equal(char **args,const ln_intp*d,const ln_intp*s,void*f){(void)f;char*p0=args[0],*p1=args[1],*po=args[2];for(ln_intp i=0;i<d[0];++i,p0+=s[0],p1+=s[1],po+=s[2]){CTYPE a,b;memcpy(&a,p0,sizeof(a));memcpy(&b,p1,sizeof(b));uint8_t v=(uint8_t)LN_COMPLEX_NE(a.real,a.imag,b.real,b.imag);memcpy(po,&v,1);}} \
    static void ln_##NAME##_less(char **args,const ln_intp*d,const ln_intp*s,void*f){(void)f;char*p0=args[0],*p1=args[1],*po=args[2];for(ln_intp i=0;i<d[0];++i,p0+=s[0],p1+=s[1],po+=s[2]){CTYPE a,b;memcpy(&a,p0,sizeof(a));memcpy(&b,p1,sizeof(b));uint8_t v=(uint8_t)LN_COMPLEX_LT(a.real,a.imag,b.real,b.imag);memcpy(po,&v,1);}} \
    static void ln_##NAME##_less_equal(char **args,const ln_intp*d,const ln_intp*s,void*f){(void)f;char*p0=args[0],*p1=args[1],*po=args[2];for(ln_intp i=0;i<d[0];++i,p0+=s[0],p1+=s[1],po+=s[2]){CTYPE a,b;memcpy(&a,p0,sizeof(a));memcpy(&b,p1,sizeof(b));uint8_t v=(uint8_t)LN_COMPLEX_LE(a.real,a.imag,b.real,b.imag);memcpy(po,&v,1);}} \
    static void ln_##NAME##_greater(char **args,const ln_intp*d,const ln_intp*s,void*f){(void)f;char*p0=args[0],*p1=args[1],*po=args[2];for(ln_intp i=0;i<d[0];++i,p0+=s[0],p1+=s[1],po+=s[2]){CTYPE a,b;memcpy(&a,p0,sizeof(a));memcpy(&b,p1,sizeof(b));uint8_t v=(uint8_t)LN_COMPLEX_GT(a.real,a.imag,b.real,b.imag);memcpy(po,&v,1);}} \
    static void ln_##NAME##_greater_equal(char **args,const ln_intp*d,const ln_intp*s,void*f){(void)f;char*p0=args[0],*p1=args[1],*po=args[2];for(ln_intp i=0;i<d[0];++i,p0+=s[0],p1+=s[1],po+=s[2]){CTYPE a,b;memcpy(&a,p0,sizeof(a));memcpy(&b,p1,sizeof(b));uint8_t v=(uint8_t)LN_COMPLEX_GE(a.real,a.imag,b.real,b.imag);memcpy(po,&v,1);}} \
    static void ln_##NAME##_logical_and(char **args,const ln_intp*d,const ln_intp*s,void*f){(void)f;char*p0=args[0],*p1=args[1],*po=args[2];for(ln_intp i=0;i<d[0];++i,p0+=s[0],p1+=s[1],po+=s[2]){CTYPE a,b;memcpy(&a,p0,sizeof(a));memcpy(&b,p1,sizeof(b));uint8_t v=(uint8_t)((a.real||a.imag)&&(b.real||b.imag));memcpy(po,&v,1);}} \
    static void ln_##NAME##_logical_or(char **args,const ln_intp*d,const ln_intp*s,void*f){(void)f;char*p0=args[0],*p1=args[1],*po=args[2];for(ln_intp i=0;i<d[0];++i,p0+=s[0],p1+=s[1],po+=s[2]){CTYPE a,b;memcpy(&a,p0,sizeof(a));memcpy(&b,p1,sizeof(b));uint8_t v=(uint8_t)((a.real||a.imag)||(b.real||b.imag));memcpy(po,&v,1);}} \
    static void ln_##NAME##_logical_xor(char **args,const ln_intp*d,const ln_intp*s,void*f){(void)f;char*p0=args[0],*p1=args[1],*po=args[2];for(ln_intp i=0;i<d[0];++i,p0+=s[0],p1+=s[1],po+=s[2]){CTYPE a,b;memcpy(&a,p0,sizeof(a));memcpy(&b,p1,sizeof(b));uint8_t v=(uint8_t)((!!(a.real||a.imag))!=(!!(b.real||b.imag)));memcpy(po,&v,1);}} \
    static void ln_##NAME##_negative(char **args,const ln_intp*d,const ln_intp*s,void*f){(void)f;char*pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a,z;memcpy(&a,pi,sizeof(a));z.real=-a.real;z.imag=-a.imag;memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_positive(char **args,const ln_intp*d,const ln_intp*s,void*f){(void)f;char*pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a;memcpy(&a,pi,sizeof(a));memcpy(po,&a,sizeof(a));}} \
    static void ln_##NAME##_absolute(char **args,const ln_intp*d,const ln_intp*s,void*f){(void)f;char*pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a;memcpy(&a,pi,sizeof(a));FTYPE v=(FTYPE)HYPOTFN(a.real,a.imag);memcpy(po,&v,sizeof(v));}} \
    static void ln_##NAME##_sign(char **args,const ln_intp*d,const ln_intp*s,void*f){(void)f;char*pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a,z;memcpy(&a,pi,sizeof(a));FTYPE h=(FTYPE)HYPOTFN(a.real,a.imag);if(isnan(h)){z.real=(FTYPE)NAN;z.imag=(FTYPE)NAN;}else if(isinf(h)){if(isinf(a.real)){if(isinf(a.imag)){z.real=(FTYPE)NAN;z.imag=(FTYPE)NAN;}else{z.real=a.real>0?1:-1;z.imag=0;}}else{z.real=0;z.imag=a.imag>0?1:-1;}}else if(h==0){z.real=0;z.imag=0;}else{z.real=a.real/h;z.imag=a.imag/h;}memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_logical_not(char **args,const ln_intp*d,const ln_intp*s,void*f){(void)f;char*pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a;memcpy(&a,pi,sizeof(a));uint8_t v=(uint8_t)!(a.real||a.imag);memcpy(po,&v,1);}} \
    static void ln_##NAME##_isnan(char **args,const ln_intp*d,const ln_intp*s,void*f){(void)f;char*pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a;memcpy(&a,pi,sizeof(a));uint8_t v=(uint8_t)(isnan(a.real)||isnan(a.imag));memcpy(po,&v,1);}} \
    static void ln_##NAME##_isinf(char **args,const ln_intp*d,const ln_intp*s,void*f){(void)f;char*pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a;memcpy(&a,pi,sizeof(a));uint8_t v=(uint8_t)(isinf(a.real)||isinf(a.imag));memcpy(po,&v,1);}} \
    static void ln_##NAME##_isfinite(char **args,const ln_intp*d,const ln_intp*s,void*f){(void)f;char*pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a;memcpy(&a,pi,sizeof(a));uint8_t v=(uint8_t)(isfinite(a.real)&&isfinite(a.imag));memcpy(po,&v,1);}} \
    static void ln_##NAME##_maximum(char **args,const ln_intp*d,const ln_intp*s,void*f){(void)f;char*p0=args[0],*p1=args[1],*po=args[2];for(ln_intp i=0;i<d[0];++i,p0+=s[0],p1+=s[1],po+=s[2]){CTYPE a,b,z;memcpy(&a,p0,sizeof(a));memcpy(&b,p1,sizeof(b));z=a;if(!(isnan(a.real)||isnan(a.imag)||LN_COMPLEX_GE(a.real,a.imag,b.real,b.imag)))z=b;memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_minimum(char **args,const ln_intp*d,const ln_intp*s,void*f){(void)f;char*p0=args[0],*p1=args[1],*po=args[2];for(ln_intp i=0;i<d[0];++i,p0+=s[0],p1+=s[1],po+=s[2]){CTYPE a,b,z;memcpy(&a,p0,sizeof(a));memcpy(&b,p1,sizeof(b));z=a;if(!(isnan(a.real)||isnan(a.imag)||LN_COMPLEX_LE(a.real,a.imag,b.real,b.imag)))z=b;memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_fmax(char **args,const ln_intp*d,const ln_intp*s,void*f){(void)f;char*p0=args[0],*p1=args[1],*po=args[2];for(ln_intp i=0;i<d[0];++i,p0+=s[0],p1+=s[1],po+=s[2]){CTYPE a,b,z;memcpy(&a,p0,sizeof(a));memcpy(&b,p1,sizeof(b));z=(isnan(b.real)||isnan(b.imag)||LN_COMPLEX_GE(a.real,a.imag,b.real,b.imag))?a:b;memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_fmin(char **args,const ln_intp*d,const ln_intp*s,void*f){(void)f;char*p0=args[0],*p1=args[1],*po=args[2];for(ln_intp i=0;i<d[0];++i,p0+=s[0],p1+=s[1],po+=s[2]){CTYPE a,b,z;memcpy(&a,p0,sizeof(a));memcpy(&b,p1,sizeof(b));z=(isnan(b.real)||isnan(b.imag)||LN_COMPLEX_LE(a.real,a.imag,b.real,b.imag))?a:b;memcpy(po,&z,sizeof(z));}}

DEFINE_COMPLEX_LOOPS(CFLOAT,float,ln_cfloat,fabsf,hypotf)
DEFINE_COMPLEX_LOOPS(CDOUBLE,double,ln_cdouble,fabs,hypot)
DEFINE_COMPLEX_LOOPS(CLONGDOUBLE,long double,ln_clongdouble,fabsl,hypotl)
#undef DEFINE_COMPLEX_LOOPS

/* Complex elementary loops call the NumPy-derived numerical kernels in
 * ln_complex_math.c.  The ufunc ABI stays the same 3-pointer strided ABI. */
#define DEFINE_COMPLEX_ELEMENTARY_LOOPS(NAME, CTYPE, PFX) \
    static void ln_##NAME##_power(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *p0=args[0],*p1=args[1],*po=args[2]; \
        for(ln_intp i=0;i<d[0];++i,p0+=s[0],p1+=s[1],po+=s[2]){ \
            CTYPE a,b,z;memcpy(&a,p0,sizeof(a));memcpy(&b,p1,sizeof(b));z=PFX##_cpow(a,b);memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_sqrt(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a,z;memcpy(&a,pi,sizeof(a));z=PFX##_csqrt(a);memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_exp(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a,z;memcpy(&a,pi,sizeof(a));z=PFX##_cexp(a);memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_log(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a,z;memcpy(&a,pi,sizeof(a));z=PFX##_clog(a);memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_sin(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a,z;memcpy(&a,pi,sizeof(a));z=PFX##_csin(a);memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_cos(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a,z;memcpy(&a,pi,sizeof(a));z=PFX##_ccos(a);memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_tan(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a,z;memcpy(&a,pi,sizeof(a));z=PFX##_ctan(a);memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_sinh(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a,z;memcpy(&a,pi,sizeof(a));z=PFX##_csinh(a);memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_cosh(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a,z;memcpy(&a,pi,sizeof(a));z=PFX##_ccosh(a);memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_tanh(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a,z;memcpy(&a,pi,sizeof(a));z=PFX##_ctanh(a);memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_exp2(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a,z;memcpy(&a,pi,sizeof(a));z=PFX##_cexp2(a);memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_log2(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a,z;memcpy(&a,pi,sizeof(a));z=PFX##_clog2(a);memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_log10(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a,z;memcpy(&a,pi,sizeof(a));z=PFX##_clog10(a);memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_expm1(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a,z;memcpy(&a,pi,sizeof(a));z=PFX##_cexpm1(a);memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_log1p(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a,z;memcpy(&a,pi,sizeof(a));z=PFX##_clog1p(a);memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_arcsin(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a,z;memcpy(&a,pi,sizeof(a));z=PFX##_casin(a);memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_arccos(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a,z;memcpy(&a,pi,sizeof(a));z=PFX##_cacos(a);memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_arctan(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a,z;memcpy(&a,pi,sizeof(a));z=PFX##_catan(a);memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_arcsinh(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a,z;memcpy(&a,pi,sizeof(a));z=PFX##_casinh(a);memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_arccosh(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a,z;memcpy(&a,pi,sizeof(a));z=PFX##_cacosh(a);memcpy(po,&z,sizeof(z));}} \
    static void ln_##NAME##_arctanh(char **args,const ln_intp*d,const ln_intp*s,void*f){ \
        (void)f; char *pi=args[0],*po=args[2];for(ln_intp i=0;i<d[0];++i,pi+=s[0],po+=s[2]){CTYPE a,z;memcpy(&a,pi,sizeof(a));z=PFX##_catanh(a);memcpy(po,&z,sizeof(z));}}
DEFINE_COMPLEX_ELEMENTARY_LOOPS(CFLOAT,ln_cfloat,ln_cfloat)
DEFINE_COMPLEX_ELEMENTARY_LOOPS(CDOUBLE,ln_cdouble,ln_cdouble)
DEFINE_COMPLEX_ELEMENTARY_LOOPS(CLONGDOUBLE,ln_clongdouble,ln_clongdouble)
#undef DEFINE_COMPLEX_ELEMENTARY_LOOPS

/*
 * Comparisons/logicals/minmax below are direct scalar baseline adaptations of:
 *   loops_comparison.dispatch.c.src
 *   loops_autovec.dispatch.c.src / loops.c.src logical loops
 *   loops_minmax.dispatch.c.src
 * NumPy's generated SIMD dispatch is intentionally replaced by the same
 * strided scalar ABI until the CPU-dispatch layer itself is ported.
 */
#define DEFINE_COMPARE_LOGICAL_MINMAX(NAME, TYPE) \
    static void ln_##NAME##_equal(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { (void)func; \
        LN_BINARY_LOOP_FAST(TYPE, uint8_t, *out = (uint8_t)(in1 == in2)); } \
    static void ln_##NAME##_not_equal(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { (void)func; \
        LN_BINARY_LOOP_FAST(TYPE, uint8_t, *out = (uint8_t)(in1 != in2)); } \
    static void ln_##NAME##_less(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { (void)func; \
        LN_BINARY_LOOP_FAST(TYPE, uint8_t, *out = (uint8_t)(in1 < in2)); } \
    static void ln_##NAME##_less_equal(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { (void)func; \
        LN_BINARY_LOOP_FAST(TYPE, uint8_t, *out = (uint8_t)(in1 <= in2)); } \
    static void ln_##NAME##_greater(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { (void)func; \
        LN_BINARY_LOOP_FAST(TYPE, uint8_t, *out = (uint8_t)(in1 > in2)); } \
    static void ln_##NAME##_greater_equal(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { (void)func; \
        LN_BINARY_LOOP_FAST(TYPE, uint8_t, *out = (uint8_t)(in1 >= in2)); } \
    static void ln_##NAME##_logical_and(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { (void)func; \
        LN_BINARY_LOOP_FAST(TYPE, uint8_t, *out = (uint8_t)(!!in1 && !!in2)); } \
    static void ln_##NAME##_logical_or(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { (void)func; \
        LN_BINARY_LOOP_FAST(TYPE, uint8_t, *out = (uint8_t)(!!in1 || !!in2)); } \
    static void ln_##NAME##_logical_xor(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { (void)func; \
        LN_BINARY_LOOP_FAST(TYPE, uint8_t, *out = (uint8_t)(!!in1 != !!in2)); } \
    static void ln_##NAME##_maximum(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { (void)func; \
        LN_BINARY_LOOP_FAST(TYPE, TYPE, *out = (in1 > in2) ? in1 : in2); } \
    static void ln_##NAME##_minimum(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { (void)func; \
        LN_BINARY_LOOP_FAST(TYPE, TYPE, *out = (in1 < in2) ? in1 : in2); }

#define DEFINE_FP_COMPARE_LOGICAL_MINMAX(NAME, TYPE, ISNANFN) \
    static void ln_##NAME##_equal(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { (void)func; \
        LN_BINARY_LOOP_FAST(TYPE, uint8_t, *out = (uint8_t)(in1 == in2)); } \
    static void ln_##NAME##_not_equal(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { (void)func; \
        LN_BINARY_LOOP_FAST(TYPE, uint8_t, *out = (uint8_t)(in1 != in2)); } \
    static void ln_##NAME##_less(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { (void)func; \
        LN_BINARY_LOOP_FAST(TYPE, uint8_t, *out = (uint8_t)(in1 < in2)); } \
    static void ln_##NAME##_less_equal(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { (void)func; \
        LN_BINARY_LOOP_FAST(TYPE, uint8_t, *out = (uint8_t)(in1 <= in2)); } \
    static void ln_##NAME##_greater(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { (void)func; \
        LN_BINARY_LOOP_FAST(TYPE, uint8_t, *out = (uint8_t)(in1 > in2)); } \
    static void ln_##NAME##_greater_equal(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { (void)func; \
        LN_BINARY_LOOP_FAST(TYPE, uint8_t, *out = (uint8_t)(in1 >= in2)); } \
    static void ln_##NAME##_logical_and(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { (void)func; \
        LN_BINARY_LOOP_FAST(TYPE, uint8_t, *out = (uint8_t)(!!in1 && !!in2)); } \
    static void ln_##NAME##_logical_or(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { (void)func; \
        LN_BINARY_LOOP_FAST(TYPE, uint8_t, *out = (uint8_t)(!!in1 || !!in2)); } \
    static void ln_##NAME##_logical_xor(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { (void)func; \
        LN_BINARY_LOOP_FAST(TYPE, uint8_t, *out = (uint8_t)(!!in1 != !!in2)); } \
    static void ln_##NAME##_maximum(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { (void)func; \
        LN_BINARY_LOOP_FAST(TYPE, TYPE, *out = (in1 >= in2 || ISNANFN(in1)) ? in1 : in2); } \
    static void ln_##NAME##_minimum(char **args, const ln_intp *dimensions, \
            const ln_intp *steps, void *func) { (void)func; \
        LN_BINARY_LOOP_FAST(TYPE, TYPE, *out = (in1 <= in2 || ISNANFN(in1)) ? in1 : in2); }

/* BOOL maximum/minimum are logical_or/logical_and in loops.h.src. */
DEFINE_COMPARE_LOGICAL_MINMAX(BOOL, uint8_t)
DEFINE_COMPARE_LOGICAL_MINMAX(BYTE, int8_t)
DEFINE_COMPARE_LOGICAL_MINMAX(UBYTE, uint8_t)
DEFINE_COMPARE_LOGICAL_MINMAX(SHORT, int16_t)
DEFINE_COMPARE_LOGICAL_MINMAX(USHORT, uint16_t)
DEFINE_COMPARE_LOGICAL_MINMAX(INT, int32_t)
DEFINE_COMPARE_LOGICAL_MINMAX(UINT, uint32_t)
DEFINE_COMPARE_LOGICAL_MINMAX(LONG, long)
DEFINE_COMPARE_LOGICAL_MINMAX(ULONG, unsigned long)
DEFINE_COMPARE_LOGICAL_MINMAX(LONGLONG, long long)
DEFINE_COMPARE_LOGICAL_MINMAX(ULONGLONG, unsigned long long)
DEFINE_FP_COMPARE_LOGICAL_MINMAX(FLOAT, float, isnan)
DEFINE_FP_COMPARE_LOGICAL_MINMAX(DOUBLE, double, isnan)
DEFINE_FP_COMPARE_LOGICAL_MINMAX(LONGDOUBLE, long double, isnan)

#undef DEFINE_COMPARE_LOGICAL_MINMAX
#undef DEFINE_FP_COMPARE_LOGICAL_MINMAX

/* Direct port of loops.c.src LONGLONG_Qq_bool_* / qQ_bool_*.
 * These signatures are required because casting signed/unsigned 64-bit inputs
 * to the ordinary common dtype (float64) loses integer ordering information. */
#define DEFINE_MIXED64_COMPARE(NAME, OP) \
    static void ln_U64_I64_##NAME(char **args,const ln_intp *dimensions, \
            const ln_intp *steps,void *func){(void)func; \
        char *p0=args[0],*p1=args[1],*po=args[2]; \
        for(ln_intp i=0;i<dimensions[0];++i,p0+=steps[0],p1+=steps[1],po+=steps[2]){ \
            uint64_t in1; int64_t in2; uint8_t out; \
            memcpy(&in1,p0,sizeof(in1)); memcpy(&in2,p1,sizeof(in2)); \
            out=(uint8_t)(in2<0 ? (0 OP in2) : (in1 OP (uint64_t)in2)); \
            memcpy(po,&out,sizeof(out)); \
        }} \
    static void ln_I64_U64_##NAME(char **args,const ln_intp *dimensions, \
            const ln_intp *steps,void *func){(void)func; \
        char *p0=args[0],*p1=args[1],*po=args[2]; \
        for(ln_intp i=0;i<dimensions[0];++i,p0+=steps[0],p1+=steps[1],po+=steps[2]){ \
            int64_t in1; uint64_t in2; uint8_t out; \
            memcpy(&in1,p0,sizeof(in1)); memcpy(&in2,p1,sizeof(in2)); \
            out=(uint8_t)(in1<0 ? (in1 OP 0) : ((uint64_t)in1 OP in2)); \
            memcpy(po,&out,sizeof(out)); \
        }}

DEFINE_MIXED64_COMPARE(equal, ==)
DEFINE_MIXED64_COMPARE(not_equal, !=)
DEFINE_MIXED64_COMPARE(less, <)
DEFINE_MIXED64_COMPARE(less_equal, <=)
DEFINE_MIXED64_COMPARE(greater, >)
DEFINE_MIXED64_COMPARE(greater_equal, >=)
#undef DEFINE_MIXED64_COMPARE

ln_strided_binary_loop
ln_get_mixed_comparison_loop(ln_binary_op op,const ln_dtype *a,const ln_dtype *b)
{
    if (!a || !b || a->elsize != 8 || b->elsize != 8) return NULL;
    int iu = a->kind == 'i' && b->kind == 'u';
    int ui = a->kind == 'u' && b->kind == 'i';
    if (!iu && !ui) return NULL;
    switch(op){
        case LN_OP_EQUAL: return iu ? ln_I64_U64_equal : ln_U64_I64_equal;
        case LN_OP_NOT_EQUAL: return iu ? ln_I64_U64_not_equal : ln_U64_I64_not_equal;
        case LN_OP_LESS: return iu ? ln_I64_U64_less : ln_U64_I64_less;
        case LN_OP_LESS_EQUAL: return iu ? ln_I64_U64_less_equal : ln_U64_I64_less_equal;
        case LN_OP_GREATER: return iu ? ln_I64_U64_greater : ln_U64_I64_greater;
        case LN_OP_GREATER_EQUAL: return iu ? ln_I64_U64_greater_equal : ln_U64_I64_greater_equal;
        default:return NULL;
    }
}

/* Unary loops use the same 3-pointer ABI in LuaRay's NpyIter executor.  The
 * second readable pointer is intentionally ignored.  The scalar operations are
 * direct adaptations of loops_unary.dispatch.c.src, loops_autovec.dispatch.c.src,
 * loops.c.src, and loops_logical.dispatch.cpp. */
#define LN_UNARY_VIA_BINARY(TYPE, OUTTYPE, EXPR) \
    LN_BINARY_LOOP_FAST(TYPE, OUTTYPE, (void)in2; *out = (EXPR))

#define DEFINE_UNSIGNED_UNARY(NAME, TYPE) \
    static void ln_##NAME##_negative(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,TYPE,(TYPE)(-in1));} \
    static void ln_##NAME##_absolute(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,TYPE,in1);} \
    static void ln_##NAME##_positive(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,TYPE,in1);} \
    static void ln_##NAME##_sign(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,TYPE,(TYPE)(in1>0?1:0));} \
    static void ln_##NAME##_logical_not(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,uint8_t,(uint8_t)!in1);} \
    static void ln_##NAME##_isnan(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,uint8_t,((void)in1,(uint8_t)0));} \
    static void ln_##NAME##_isinf(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,uint8_t,((void)in1,(uint8_t)0));} \
    static void ln_##NAME##_isfinite(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,uint8_t,((void)in1,(uint8_t)1));} \
    static void ln_##NAME##_signbit(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,uint8_t,((void)in1,(uint8_t)0));}

#define DEFINE_SIGNED_UNARY(NAME, TYPE) \
    static void ln_##NAME##_negative(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,TYPE,(TYPE)(-in1));} \
    static void ln_##NAME##_absolute(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,TYPE,(TYPE)(in1>=0?in1:-in1));} \
    static void ln_##NAME##_positive(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,TYPE,(TYPE)(+in1));} \
    static void ln_##NAME##_sign(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,TYPE,(TYPE)(in1>0?1:(in1<0?-1:0)));} \
    static void ln_##NAME##_logical_not(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,uint8_t,(uint8_t)!in1);} \
    static void ln_##NAME##_isnan(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,uint8_t,((void)in1,(uint8_t)0));} \
    static void ln_##NAME##_isinf(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,uint8_t,((void)in1,(uint8_t)0));} \
    static void ln_##NAME##_isfinite(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,uint8_t,((void)in1,(uint8_t)1));} \
    static void ln_##NAME##_signbit(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,uint8_t,(uint8_t)(in1<0));}

#define DEFINE_FLOAT_UNARY(NAME, TYPE, FABSFN, ISNANFN, ISINFFN, ISFINITEFN, SIGNBITFN) \
    static void ln_##NAME##_negative(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,TYPE,(TYPE)(-in1));} \
    static void ln_##NAME##_absolute(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,TYPE,(TYPE)FABSFN(in1));} \
    static void ln_##NAME##_positive(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,TYPE,(TYPE)(+in1));} \
    static void ln_##NAME##_sign(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,TYPE,(TYPE)(in1>0?1:(in1<0?-1:(in1==0?0:in1))));} \
    static void ln_##NAME##_logical_not(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,uint8_t,(uint8_t)!in1);} \
    static void ln_##NAME##_isnan(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,uint8_t,(uint8_t)(ISNANFN(in1)!=0));} \
    static void ln_##NAME##_isinf(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,uint8_t,(uint8_t)(ISINFFN(in1)!=0));} \
    static void ln_##NAME##_isfinite(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,uint8_t,(uint8_t)(ISFINITEFN(in1)!=0));} \
    static void ln_##NAME##_signbit(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(TYPE,uint8_t,(uint8_t)(SIGNBITFN(in1)!=0));}

/* bool absolute is identity; logical/predicate loops match the bool aliases in
 * loops_logical.dispatch.cpp and loops_autovec.dispatch.c.src. */
static void ln_BOOL_negative(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(uint8_t,uint8_t,(uint8_t)(-in1));}
static void ln_BOOL_positive(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(uint8_t,uint8_t,(uint8_t)in1);}
static void ln_BOOL_sign(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(uint8_t,uint8_t,(uint8_t)(in1>0));}
static void ln_BOOL_absolute(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(uint8_t,uint8_t,(uint8_t)!!in1);}
static void ln_BOOL_logical_not(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(uint8_t,uint8_t,(uint8_t)!in1);}
static void ln_BOOL_isnan(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(uint8_t,uint8_t,((void)in1,(uint8_t)0));}
static void ln_BOOL_isinf(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(uint8_t,uint8_t,((void)in1,(uint8_t)0));}
static void ln_BOOL_isfinite(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(uint8_t,uint8_t,((void)in1,(uint8_t)1));}
static void ln_BOOL_signbit(char **args,const ln_intp *dimensions,const ln_intp *steps,void*f){(void)f;LN_UNARY_VIA_BINARY(uint8_t,uint8_t,((void)in1,(uint8_t)0));}

DEFINE_SIGNED_UNARY(BYTE, int8_t)
DEFINE_UNSIGNED_UNARY(UBYTE, uint8_t)
DEFINE_SIGNED_UNARY(SHORT, int16_t)
DEFINE_UNSIGNED_UNARY(USHORT, uint16_t)
DEFINE_SIGNED_UNARY(INT, int32_t)
DEFINE_UNSIGNED_UNARY(UINT, uint32_t)
DEFINE_SIGNED_UNARY(LONG, long)
DEFINE_UNSIGNED_UNARY(ULONG, unsigned long)
DEFINE_SIGNED_UNARY(LONGLONG, long long)
DEFINE_UNSIGNED_UNARY(ULONGLONG, unsigned long long)
DEFINE_FLOAT_UNARY(FLOAT, float, fabsf, isnan, isinf, isfinite, signbit)
DEFINE_FLOAT_UNARY(DOUBLE, double, fabs, isnan, isinf, isfinite, signbit)
DEFINE_FLOAT_UNARY(LONGDOUBLE, long double, fabsl, isnan, isinf, isfinite, signbit)

#undef LN_UNARY_VIA_BINARY
#undef DEFINE_UNSIGNED_UNARY
#undef DEFINE_SIGNED_UNARY
#undef DEFINE_FLOAT_UNARY


/* Multi-output loops ported from NumPy loops.c.src / loops_exponent_log.dispatch.c.src.
 * Argument order is [inputs..., outputs...], identical to the upstream ufunc
 * inner-loop ABI. */
#define LN_UNARY_TWO_OUT(TYPE, BODY) do { \
    char *ip=args[0], *op1=args[1], *op2=args[2]; \
    for (ln_intp i=0;i<dimensions[0];++i,ip+=steps[0],op1+=steps[1],op2+=steps[2]) { \
        TYPE in1; memcpy(&in1,ip,sizeof(in1)); BODY; \
    } \
} while(0)

#define LN_BINARY_TWO_OUT(TYPE, BODY) do { \
    char *ip1=args[0], *ip2=args[1], *op1=args[2], *op2=args[3]; \
    for (ln_intp i=0;i<dimensions[0];++i,ip1+=steps[0],ip2+=steps[1],op1+=steps[2],op2+=steps[3]) { \
        TYPE in1,in2; memcpy(&in1,ip1,sizeof(in1)); memcpy(&in2,ip2,sizeof(in2)); BODY; \
    } \
} while(0)

#define DEFINE_FP_MULTIOUT(NAME, TYPE, MODFFN, FREXPFN) \
static void ln_##NAME##_modf2(char **args,const ln_intp *dimensions,const ln_intp *steps,void *func) { \
    (void)func; LN_UNARY_TWO_OUT(TYPE, { TYPE ipart; TYPE frac=(TYPE)MODFFN(in1,&ipart); memcpy(op1,&frac,sizeof(frac)); memcpy(op2,&ipart,sizeof(ipart)); }); \
} \
static void ln_##NAME##_frexp2(char **args,const ln_intp *dimensions,const ln_intp *steps,void *func) { \
    (void)func; char *ip=args[0],*op1=args[1],*op2=args[2]; \
    for(ln_intp i=0;i<dimensions[0];++i,ip+=steps[0],op1+=steps[1],op2+=steps[2]) { TYPE in1,mant; int ex=0; memcpy(&in1,ip,sizeof(in1)); mant=(TYPE)FREXPFN(in1,&ex); memcpy(op1,&mant,sizeof(mant)); memcpy(op2,&ex,sizeof(ex)); } \
} \
static void ln_##NAME##_divmod2(char **args,const ln_intp *dimensions,const ln_intp *steps,void *func) { \
    (void)func; LN_BINARY_TWO_OUT(TYPE, { TYPE rem; TYPE q=ln_##NAME##_divmod_scalar(in1,in2,&rem); memcpy(op1,&q,sizeof(q)); memcpy(op2,&rem,sizeof(rem)); }); \
}

DEFINE_FP_MULTIOUT(FLOAT,float,modff,frexpf)
DEFINE_FP_MULTIOUT(DOUBLE,double,modf,frexp)
DEFINE_FP_MULTIOUT(LONGDOUBLE,long double,modfl,frexpl)
#undef DEFINE_FP_MULTIOUT

#define DEFINE_INT_DIVMOD2(NAME, TYPE) \
static void ln_##NAME##_divmod2(char **args,const ln_intp *dimensions,const ln_intp *steps,void *func) { \
    (void)func; LN_BINARY_TWO_OUT(TYPE, { TYPE q=ln_##NAME##_floor_scalar(in1,in2); TYPE r=ln_##NAME##_rem_scalar(in1,in2); memcpy(op1,&q,sizeof(q)); memcpy(op2,&r,sizeof(r)); }); \
}
DEFINE_INT_DIVMOD2(BYTE,int8_t)
DEFINE_INT_DIVMOD2(SHORT,int16_t)
DEFINE_INT_DIVMOD2(INT,int32_t)
DEFINE_INT_DIVMOD2(LONG,long)
DEFINE_INT_DIVMOD2(LONGLONG,long long)
#undef DEFINE_INT_DIVMOD2

#define DEFINE_UINT_DIVMOD2(NAME, TYPE) \
static void ln_##NAME##_divmod2(char **args,const ln_intp *dimensions,const ln_intp *steps,void *func) { \
    (void)func; LN_BINARY_TWO_OUT(TYPE, { TYPE q=in2?(TYPE)(in1/in2):(TYPE)0; TYPE r=in2?(TYPE)(in1%in2):(TYPE)0; memcpy(op1,&q,sizeof(q)); memcpy(op2,&r,sizeof(r)); }); \
}
DEFINE_UINT_DIVMOD2(UBYTE,uint8_t)
DEFINE_UINT_DIVMOD2(USHORT,uint16_t)
DEFINE_UINT_DIVMOD2(UINT,uint32_t)
DEFINE_UINT_DIVMOD2(ULONG,unsigned long)
DEFINE_UINT_DIVMOD2(ULONGLONG,unsigned long long)
#undef DEFINE_UINT_DIVMOD2

static void ln_HALF_modf2(char **args,const ln_intp *dimensions,const ln_intp *steps,void *func) {
    (void)func; char *ip=args[0],*op1=args[1],*op2=args[2];
    for(ln_intp i=0;i<dimensions[0];++i,ip+=steps[0],op1+=steps[1],op2+=steps[2]) {
        float in=ln_half_to_float(ln_half_load(ip)), ipart; float frac=modff(in,&ipart);
        ln_half_store(op1,ln_float_to_half(frac)); ln_half_store(op2,ln_float_to_half(ipart));
    }
}
static void ln_HALF_frexp2(char **args,const ln_intp *dimensions,const ln_intp *steps,void *func) {
    (void)func; char *ip=args[0],*op1=args[1],*op2=args[2];
    for(ln_intp i=0;i<dimensions[0];++i,ip+=steps[0],op1+=steps[1],op2+=steps[2]) {
        float in=ln_half_to_float(ln_half_load(ip)); int ex=0; float mant=frexpf(in,&ex);
        ln_half_store(op1,ln_float_to_half(mant)); memcpy(op2,&ex,sizeof(ex));
    }
}
static void ln_HALF_divmod2(char **args,const ln_intp *dimensions,const ln_intp *steps,void *func) {
    (void)func; char *ip1=args[0],*ip2=args[1],*op1=args[2],*op2=args[3];
    for(ln_intp i=0;i<dimensions[0];++i,ip1+=steps[0],ip2+=steps[1],op1+=steps[2],op2+=steps[3]) {
        float a=ln_half_to_float(ln_half_load(ip1)),b=ln_half_to_float(ln_half_load(ip2)),r;
        float q=ln_FLOAT_divmod_scalar(a,b,&r); ln_half_store(op1,ln_float_to_half(q)); ln_half_store(op2,ln_float_to_half(r));
    }
}

#undef LN_UNARY_TWO_OUT
#undef LN_BINARY_TWO_OUT

#define DEFINE_LDEXP_LOOPS(NAME, TYPE, LDEXPFN, LOADHALF, STOREHALF) \
static void ln_##NAME##_ldexp_i32(char **args,const ln_intp *dimensions,const ln_intp *steps,void *func) { \
    (void)func; char *ip1=args[0],*ip2=args[1],*op=args[2]; \
    for(ln_intp i=0;i<dimensions[0];++i,ip1+=steps[0],ip2+=steps[1],op+=steps[2]) { TYPE x; int e; LOADHALF; memcpy(&e,ip2,sizeof(e)); TYPE y=(TYPE)LDEXPFN(x,e); STOREHALF; } \
} \
static void ln_##NAME##_ldexp_i64(char **args,const ln_intp *dimensions,const ln_intp *steps,void *func) { \
    (void)func; char *ip1=args[0],*ip2=args[1],*op=args[2]; \
    for(ln_intp i=0;i<dimensions[0];++i,ip1+=steps[0],ip2+=steps[1],op+=steps[2]) { TYPE x; int64_t e64; LOADHALF; memcpy(&e64,ip2,sizeof(e64)); int e; if((int64_t)(int)e64==e64)e=(int)e64; else e=e64>0?INT_MAX:INT_MIN; TYPE y=(TYPE)LDEXPFN(x,e); STOREHALF; } \
}

#define LN_LOAD_NATIVE do { memcpy(&x,ip1,sizeof(x)); } while(0)
#define LN_STORE_NATIVE do { memcpy(op,&y,sizeof(y)); } while(0)
DEFINE_LDEXP_LOOPS(FLOAT,float,ldexpf,LN_LOAD_NATIVE,LN_STORE_NATIVE)
DEFINE_LDEXP_LOOPS(DOUBLE,double,ldexp,LN_LOAD_NATIVE,LN_STORE_NATIVE)
DEFINE_LDEXP_LOOPS(LONGDOUBLE,long double,ldexpl,LN_LOAD_NATIVE,LN_STORE_NATIVE)
#undef LN_LOAD_NATIVE
#undef LN_STORE_NATIVE
#define LN_LOAD_HALF do { x=ln_half_to_float(ln_half_load(ip1)); } while(0)
#define LN_STORE_HALF do { ln_half_store(op,ln_float_to_half(y)); } while(0)
DEFINE_LDEXP_LOOPS(HALF,float,ldexpf,LN_LOAD_HALF,LN_STORE_HALF)
#undef LN_LOAD_HALF
#undef LN_STORE_HALF
#undef DEFINE_LDEXP_LOOPS

ln_strided_loop ln_get_frexp_loop(ln_dtype_num t) {
    switch(t) { case LN_HALF:return ln_HALF_frexp2; case LN_FLOAT:return ln_FLOAT_frexp2; case LN_DOUBLE:return ln_DOUBLE_frexp2; case LN_LONGDOUBLE:return ln_LONGDOUBLE_frexp2; default:return NULL; }
}
ln_strided_loop ln_get_modf_loop(ln_dtype_num t) {
    switch(t) { case LN_HALF:return ln_HALF_modf2; case LN_FLOAT:return ln_FLOAT_modf2; case LN_DOUBLE:return ln_DOUBLE_modf2; case LN_LONGDOUBLE:return ln_LONGDOUBLE_modf2; default:return NULL; }
}
ln_strided_loop ln_get_divmod_loop(ln_dtype_num t) {
    switch(t) {
        case LN_BYTE:return ln_BYTE_divmod2; case LN_UBYTE:return ln_UBYTE_divmod2;
        case LN_SHORT:return ln_SHORT_divmod2; case LN_USHORT:return ln_USHORT_divmod2;
        case LN_INT:return ln_INT_divmod2; case LN_UINT:return ln_UINT_divmod2;
        case LN_LONG:return ln_LONG_divmod2; case LN_ULONG:return ln_ULONG_divmod2;
        case LN_LONGLONG:return ln_LONGLONG_divmod2; case LN_ULONGLONG:return ln_ULONGLONG_divmod2;
        case LN_HALF:return ln_HALF_divmod2; case LN_FLOAT:return ln_FLOAT_divmod2;
        case LN_DOUBLE:return ln_DOUBLE_divmod2; case LN_LONGDOUBLE:return ln_LONGDOUBLE_divmod2;
        default:return NULL;
    }
}

ln_strided_loop ln_get_ldexp_loop(ln_dtype_num ft, ln_dtype_num et) {
    int wide = ln_dtype_by_num(et) && ln_dtype_by_num(et)->elsize == 8;
    switch(ft) {
        case LN_HALF: return wide ? ln_HALF_ldexp_i64 : ln_HALF_ldexp_i32;
        case LN_FLOAT: return wide ? ln_FLOAT_ldexp_i64 : ln_FLOAT_ldexp_i32;
        case LN_DOUBLE: return wide ? ln_DOUBLE_ldexp_i64 : ln_DOUBLE_ldexp_i32;
        case LN_LONGDOUBLE: return wide ? ln_LONGDOUBLE_ldexp_i64 : ln_LONGDOUBLE_ldexp_i32;
        default: return NULL;
    }
}

ln_strided_binary_loop
ln_get_add_loop(ln_dtype_num type_num)
{
    switch (type_num) {
        case LN_BOOL: return ln_BOOL_add;
        case LN_BYTE: return ln_BYTE_add;
        case LN_UBYTE: return ln_UBYTE_add;
        case LN_SHORT: return ln_SHORT_add;
        case LN_USHORT: return ln_USHORT_add;
        case LN_INT: return ln_INT_add;
        case LN_UINT: return ln_UINT_add;
        case LN_LONG: return ln_LONG_add;
        case LN_ULONG: return ln_ULONG_add;
        case LN_LONGLONG: return ln_LONGLONG_add;
        case LN_ULONGLONG: return ln_ULONGLONG_add;
        case LN_HALF: return ln_HALF_add;
        case LN_FLOAT: return ln_FLOAT_add;
        case LN_DOUBLE: return ln_DOUBLE_add;
        case LN_LONGDOUBLE: return ln_LONGDOUBLE_add;
        case LN_CFLOAT: return ln_CFLOAT_add;
        case LN_CDOUBLE: return ln_CDOUBLE_add;
        case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_add;
        default: return NULL;
    }
}

ln_strided_binary_loop
ln_get_subtract_loop(ln_dtype_num type_num)
{
    switch (type_num) {
        case LN_BYTE: return ln_BYTE_subtract;
        case LN_UBYTE: return ln_UBYTE_subtract;
        case LN_SHORT: return ln_SHORT_subtract;
        case LN_USHORT: return ln_USHORT_subtract;
        case LN_INT: return ln_INT_subtract;
        case LN_UINT: return ln_UINT_subtract;
        case LN_LONG: return ln_LONG_subtract;
        case LN_ULONG: return ln_ULONG_subtract;
        case LN_LONGLONG: return ln_LONGLONG_subtract;
        case LN_ULONGLONG: return ln_ULONGLONG_subtract;
        case LN_HALF: return ln_HALF_subtract;
        case LN_FLOAT: return ln_FLOAT_subtract;
        case LN_DOUBLE: return ln_DOUBLE_subtract;
        case LN_LONGDOUBLE: return ln_LONGDOUBLE_subtract;
        case LN_CFLOAT: return ln_CFLOAT_subtract;
        case LN_CDOUBLE: return ln_CDOUBLE_subtract;
        case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_subtract;
        default: return NULL;
    }
}

ln_strided_binary_loop
ln_get_multiply_loop(ln_dtype_num type_num)
{
    switch (type_num) {
        case LN_BOOL: return ln_BOOL_multiply;
        case LN_BYTE: return ln_BYTE_multiply;
        case LN_UBYTE: return ln_UBYTE_multiply;
        case LN_SHORT: return ln_SHORT_multiply;
        case LN_USHORT: return ln_USHORT_multiply;
        case LN_INT: return ln_INT_multiply;
        case LN_UINT: return ln_UINT_multiply;
        case LN_LONG: return ln_LONG_multiply;
        case LN_ULONG: return ln_ULONG_multiply;
        case LN_LONGLONG: return ln_LONGLONG_multiply;
        case LN_ULONGLONG: return ln_ULONGLONG_multiply;
        case LN_HALF: return ln_HALF_multiply;
        case LN_FLOAT: return ln_FLOAT_multiply;
        case LN_DOUBLE: return ln_DOUBLE_multiply;
        case LN_LONGDOUBLE: return ln_LONGDOUBLE_multiply;
        case LN_CFLOAT: return ln_CFLOAT_multiply;
        case LN_CDOUBLE: return ln_CDOUBLE_multiply;
        case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_multiply;
        default: return NULL;
    }
}

ln_strided_binary_loop
ln_get_true_divide_loop(ln_dtype_num type_num)
{
    switch (type_num) {
        case LN_HALF: return ln_HALF_true_divide;
        case LN_FLOAT: return ln_FLOAT_true_divide;
        case LN_DOUBLE: return ln_DOUBLE_true_divide;
        case LN_LONGDOUBLE: return ln_LONGDOUBLE_true_divide;
        case LN_CFLOAT: return ln_CFLOAT_true_divide;
        case LN_CDOUBLE: return ln_CDOUBLE_true_divide;
        case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_true_divide;
        default: return NULL;
    }
}

ln_strided_binary_loop
ln_get_binary_loop(ln_binary_op op, ln_dtype_num type_num)
{
    switch (op) {
        case LN_OP_ADD: return ln_get_add_loop(type_num);
        case LN_OP_SUBTRACT: return ln_get_subtract_loop(type_num);
        case LN_OP_MULTIPLY: return ln_get_multiply_loop(type_num);
        case LN_OP_TRUE_DIVIDE: return ln_get_true_divide_loop(type_num);
        case LN_OP_EQUAL:
        case LN_OP_NOT_EQUAL:
        case LN_OP_LESS:
        case LN_OP_LESS_EQUAL:
        case LN_OP_GREATER:
        case LN_OP_GREATER_EQUAL:
        case LN_OP_LOGICAL_AND:
        case LN_OP_LOGICAL_OR:
        case LN_OP_LOGICAL_XOR:
        case LN_OP_MAXIMUM:
        case LN_OP_MINIMUM:
        case LN_OP_NEGATIVE:
        case LN_OP_ABSOLUTE:
        case LN_OP_POSITIVE:
        case LN_OP_SIGN:
        case LN_OP_LOGICAL_NOT:
        case LN_OP_ISNAN:
        case LN_OP_ISINF:
        case LN_OP_ISFINITE:
        case LN_OP_SIGNBIT:
        case LN_OP_FLOOR_DIVIDE:
        case LN_OP_REMAINDER:
        case LN_OP_POWER:
        case LN_OP_BITWISE_AND:
        case LN_OP_BITWISE_OR:
        case LN_OP_BITWISE_XOR:
        case LN_OP_FMAX:
        case LN_OP_FMIN:
        case LN_OP_COPYSIGN:
        case LN_OP_SQRT:
        case LN_OP_EXP:
        case LN_OP_LOG:
        case LN_OP_SIN:
        case LN_OP_COS:
        case LN_OP_TAN:
        case LN_OP_SINH:
        case LN_OP_COSH:
        case LN_OP_TANH:
        case LN_OP_EXP2:
        case LN_OP_LOG2:
        case LN_OP_LOG10:
        case LN_OP_EXPM1:
        case LN_OP_LOG1P:
        case LN_OP_CBRT:
        case LN_OP_ARCSIN:
        case LN_OP_ARCCOS:
        case LN_OP_ARCTAN:
        case LN_OP_ARCSINH:
        case LN_OP_ARCCOSH:
        case LN_OP_ARCTANH:
        case LN_OP_ARCTAN2:
        case LN_OP_HYPOT:
            break;
        default: return NULL;
    }
    #define LN_RET_CASE(NAME) \
        case LN_BOOL: return ln_BOOL_##NAME; \
        case LN_BYTE: return ln_BYTE_##NAME; \
        case LN_UBYTE: return ln_UBYTE_##NAME; \
        case LN_SHORT: return ln_SHORT_##NAME; \
        case LN_USHORT: return ln_USHORT_##NAME; \
        case LN_INT: return ln_INT_##NAME; \
        case LN_UINT: return ln_UINT_##NAME; \
        case LN_LONG: return ln_LONG_##NAME; \
        case LN_ULONG: return ln_ULONG_##NAME; \
        case LN_LONGLONG: return ln_LONGLONG_##NAME; \
        case LN_ULONGLONG: return ln_ULONGLONG_##NAME; \
        case LN_HALF: return ln_HALF_##NAME; \
        case LN_FLOAT: return ln_FLOAT_##NAME; \
        case LN_DOUBLE: return ln_DOUBLE_##NAME; \
        case LN_LONGDOUBLE: return ln_LONGDOUBLE_##NAME
    switch (op) {
        case LN_OP_EQUAL: switch (type_num) { LN_RET_CASE(equal); case LN_CFLOAT: return ln_CFLOAT_equal; case LN_CDOUBLE: return ln_CDOUBLE_equal; case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_equal; default: return NULL; }
        case LN_OP_NOT_EQUAL: switch (type_num) { LN_RET_CASE(not_equal); case LN_CFLOAT: return ln_CFLOAT_not_equal; case LN_CDOUBLE: return ln_CDOUBLE_not_equal; case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_not_equal; default: return NULL; }
        case LN_OP_LESS: switch (type_num) { LN_RET_CASE(less); case LN_CFLOAT: return ln_CFLOAT_less; case LN_CDOUBLE: return ln_CDOUBLE_less; case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_less; default: return NULL; }
        case LN_OP_LESS_EQUAL: switch (type_num) { LN_RET_CASE(less_equal); case LN_CFLOAT: return ln_CFLOAT_less_equal; case LN_CDOUBLE: return ln_CDOUBLE_less_equal; case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_less_equal; default: return NULL; }
        case LN_OP_GREATER: switch (type_num) { LN_RET_CASE(greater); case LN_CFLOAT: return ln_CFLOAT_greater; case LN_CDOUBLE: return ln_CDOUBLE_greater; case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_greater; default: return NULL; }
        case LN_OP_GREATER_EQUAL: switch (type_num) { LN_RET_CASE(greater_equal); case LN_CFLOAT: return ln_CFLOAT_greater_equal; case LN_CDOUBLE: return ln_CDOUBLE_greater_equal; case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_greater_equal; default: return NULL; }
        case LN_OP_LOGICAL_AND: switch (type_num) { LN_RET_CASE(logical_and); case LN_CFLOAT: return ln_CFLOAT_logical_and; case LN_CDOUBLE: return ln_CDOUBLE_logical_and; case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_logical_and; default: return NULL; }
        case LN_OP_LOGICAL_OR: switch (type_num) { LN_RET_CASE(logical_or); case LN_CFLOAT: return ln_CFLOAT_logical_or; case LN_CDOUBLE: return ln_CDOUBLE_logical_or; case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_logical_or; default: return NULL; }
        case LN_OP_LOGICAL_XOR: switch (type_num) { LN_RET_CASE(logical_xor); case LN_CFLOAT: return ln_CFLOAT_logical_xor; case LN_CDOUBLE: return ln_CDOUBLE_logical_xor; case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_logical_xor; default: return NULL; }
        case LN_OP_MAXIMUM: switch (type_num) { LN_RET_CASE(maximum); case LN_CFLOAT: return ln_CFLOAT_maximum; case LN_CDOUBLE: return ln_CDOUBLE_maximum; case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_maximum; default: return NULL; }
        case LN_OP_MINIMUM: switch (type_num) { LN_RET_CASE(minimum); case LN_CFLOAT: return ln_CFLOAT_minimum; case LN_CDOUBLE: return ln_CDOUBLE_minimum; case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_minimum; default: return NULL; }
        case LN_OP_NEGATIVE: switch (type_num) { LN_RET_CASE(negative); case LN_CFLOAT: return ln_CFLOAT_negative; case LN_CDOUBLE: return ln_CDOUBLE_negative; case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_negative; default: return NULL; }
        case LN_OP_ABSOLUTE: switch (type_num) { LN_RET_CASE(absolute); case LN_CFLOAT: return ln_CFLOAT_absolute; case LN_CDOUBLE: return ln_CDOUBLE_absolute; case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_absolute; default: return NULL; }
        case LN_OP_POSITIVE: switch (type_num) { LN_RET_CASE(positive); case LN_CFLOAT: return ln_CFLOAT_positive; case LN_CDOUBLE: return ln_CDOUBLE_positive; case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_positive; default: return NULL; }
        case LN_OP_SIGN: switch (type_num) { LN_RET_CASE(sign); case LN_CFLOAT: return ln_CFLOAT_sign; case LN_CDOUBLE: return ln_CDOUBLE_sign; case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_sign; default: return NULL; }
        case LN_OP_LOGICAL_NOT: switch (type_num) { LN_RET_CASE(logical_not); case LN_CFLOAT: return ln_CFLOAT_logical_not; case LN_CDOUBLE: return ln_CDOUBLE_logical_not; case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_logical_not; default: return NULL; }
        case LN_OP_ISNAN: switch (type_num) { LN_RET_CASE(isnan); case LN_CFLOAT: return ln_CFLOAT_isnan; case LN_CDOUBLE: return ln_CDOUBLE_isnan; case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_isnan; default: return NULL; }
        case LN_OP_ISINF: switch (type_num) { LN_RET_CASE(isinf); case LN_CFLOAT: return ln_CFLOAT_isinf; case LN_CDOUBLE: return ln_CDOUBLE_isinf; case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_isinf; default: return NULL; }
        case LN_OP_ISFINITE: switch (type_num) { LN_RET_CASE(isfinite); case LN_CFLOAT: return ln_CFLOAT_isfinite; case LN_CDOUBLE: return ln_CDOUBLE_isfinite; case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_isfinite; default: return NULL; }
        case LN_OP_SIGNBIT: switch (type_num) { LN_RET_CASE(signbit); default: return NULL; }
        case LN_OP_FLOOR_DIVIDE: switch (type_num) { LN_RET_CASE(floor_divide); default: return NULL; }
        case LN_OP_REMAINDER: switch (type_num) { LN_RET_CASE(remainder); default: return NULL; }
        case LN_OP_POWER: switch (type_num) { LN_RET_CASE(power); case LN_CFLOAT: return ln_CFLOAT_power; case LN_CDOUBLE: return ln_CDOUBLE_power; case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_power; default: return NULL; }
        case LN_OP_FMAX: switch (type_num) { LN_RET_CASE(fmax); case LN_CFLOAT: return ln_CFLOAT_fmax; case LN_CDOUBLE: return ln_CDOUBLE_fmax; case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_fmax; default: return NULL; }
        case LN_OP_FMIN: switch (type_num) { LN_RET_CASE(fmin); case LN_CFLOAT: return ln_CFLOAT_fmin; case LN_CDOUBLE: return ln_CDOUBLE_fmin; case LN_CLONGDOUBLE: return ln_CLONGDOUBLE_fmin; default: return NULL; }
        case LN_OP_BITWISE_AND:
            switch(type_num){
                case LN_BOOL:return ln_BOOL_bitwise_and; case LN_BYTE:return ln_BYTE_bitwise_and; case LN_UBYTE:return ln_UBYTE_bitwise_and;
                case LN_SHORT:return ln_SHORT_bitwise_and; case LN_USHORT:return ln_USHORT_bitwise_and; case LN_INT:return ln_INT_bitwise_and;
                case LN_UINT:return ln_UINT_bitwise_and; case LN_LONG:return ln_LONG_bitwise_and; case LN_ULONG:return ln_ULONG_bitwise_and;
                case LN_LONGLONG:return ln_LONGLONG_bitwise_and; case LN_ULONGLONG:return ln_ULONGLONG_bitwise_and; default:return NULL;}
        case LN_OP_BITWISE_OR:
            switch(type_num){
                case LN_BOOL:return ln_BOOL_bitwise_or; case LN_BYTE:return ln_BYTE_bitwise_or; case LN_UBYTE:return ln_UBYTE_bitwise_or;
                case LN_SHORT:return ln_SHORT_bitwise_or; case LN_USHORT:return ln_USHORT_bitwise_or; case LN_INT:return ln_INT_bitwise_or;
                case LN_UINT:return ln_UINT_bitwise_or; case LN_LONG:return ln_LONG_bitwise_or; case LN_ULONG:return ln_ULONG_bitwise_or;
                case LN_LONGLONG:return ln_LONGLONG_bitwise_or; case LN_ULONGLONG:return ln_ULONGLONG_bitwise_or; default:return NULL;}
        case LN_OP_BITWISE_XOR:
            switch(type_num){
                case LN_BOOL:return ln_BOOL_bitwise_xor; case LN_BYTE:return ln_BYTE_bitwise_xor; case LN_UBYTE:return ln_UBYTE_bitwise_xor;
                case LN_SHORT:return ln_SHORT_bitwise_xor; case LN_USHORT:return ln_USHORT_bitwise_xor; case LN_INT:return ln_INT_bitwise_xor;
                case LN_UINT:return ln_UINT_bitwise_xor; case LN_LONG:return ln_LONG_bitwise_xor; case LN_ULONG:return ln_ULONG_bitwise_xor;
                case LN_LONGLONG:return ln_LONGLONG_bitwise_xor; case LN_ULONGLONG:return ln_ULONGLONG_bitwise_xor; default:return NULL;}
        case LN_OP_COPYSIGN:
            switch(type_num){case LN_HALF:return ln_HALF_copysign;case LN_FLOAT:return ln_FLOAT_copysign;case LN_DOUBLE:return ln_DOUBLE_copysign;case LN_LONGDOUBLE:return ln_LONGDOUBLE_copysign;default:return NULL;}
        case LN_OP_SQRT:
            switch(type_num){case LN_HALF:return ln_HALF_sqrt;case LN_FLOAT:return ln_FLOAT_sqrt;case LN_DOUBLE:return ln_DOUBLE_sqrt;case LN_LONGDOUBLE:return ln_LONGDOUBLE_sqrt;case LN_CFLOAT:return ln_CFLOAT_sqrt;case LN_CDOUBLE:return ln_CDOUBLE_sqrt;case LN_CLONGDOUBLE:return ln_CLONGDOUBLE_sqrt;default:return NULL;}
        case LN_OP_EXP:
            switch(type_num){case LN_HALF:return ln_HALF_exp;case LN_FLOAT:return ln_FLOAT_exp;case LN_DOUBLE:return ln_DOUBLE_exp;case LN_LONGDOUBLE:return ln_LONGDOUBLE_exp;case LN_CFLOAT:return ln_CFLOAT_exp;case LN_CDOUBLE:return ln_CDOUBLE_exp;case LN_CLONGDOUBLE:return ln_CLONGDOUBLE_exp;default:return NULL;}
        case LN_OP_LOG:
            switch(type_num){case LN_HALF:return ln_HALF_log;case LN_FLOAT:return ln_FLOAT_log;case LN_DOUBLE:return ln_DOUBLE_log;case LN_LONGDOUBLE:return ln_LONGDOUBLE_log;case LN_CFLOAT:return ln_CFLOAT_log;case LN_CDOUBLE:return ln_CDOUBLE_log;case LN_CLONGDOUBLE:return ln_CLONGDOUBLE_log;default:return NULL;}
        case LN_OP_SIN:
            switch(type_num){case LN_HALF:return ln_HALF_sin;case LN_FLOAT:return ln_FLOAT_sin;case LN_DOUBLE:return ln_DOUBLE_sin;case LN_LONGDOUBLE:return ln_LONGDOUBLE_sin;case LN_CFLOAT:return ln_CFLOAT_sin;case LN_CDOUBLE:return ln_CDOUBLE_sin;case LN_CLONGDOUBLE:return ln_CLONGDOUBLE_sin;default:return NULL;}
        case LN_OP_COS:
            switch(type_num){case LN_HALF:return ln_HALF_cos;case LN_FLOAT:return ln_FLOAT_cos;case LN_DOUBLE:return ln_DOUBLE_cos;case LN_LONGDOUBLE:return ln_LONGDOUBLE_cos;case LN_CFLOAT:return ln_CFLOAT_cos;case LN_CDOUBLE:return ln_CDOUBLE_cos;case LN_CLONGDOUBLE:return ln_CLONGDOUBLE_cos;default:return NULL;}
        case LN_OP_TAN:
            switch(type_num){case LN_HALF:return ln_HALF_tan;case LN_FLOAT:return ln_FLOAT_tan;case LN_DOUBLE:return ln_DOUBLE_tan;case LN_LONGDOUBLE:return ln_LONGDOUBLE_tan;case LN_CFLOAT:return ln_CFLOAT_tan;case LN_CDOUBLE:return ln_CDOUBLE_tan;case LN_CLONGDOUBLE:return ln_CLONGDOUBLE_tan;default:return NULL;}
        case LN_OP_SINH:
            switch(type_num){case LN_HALF:return ln_HALF_sinh;case LN_FLOAT:return ln_FLOAT_sinh;case LN_DOUBLE:return ln_DOUBLE_sinh;case LN_LONGDOUBLE:return ln_LONGDOUBLE_sinh;case LN_CFLOAT:return ln_CFLOAT_sinh;case LN_CDOUBLE:return ln_CDOUBLE_sinh;case LN_CLONGDOUBLE:return ln_CLONGDOUBLE_sinh;default:return NULL;}
        case LN_OP_COSH:
            switch(type_num){case LN_HALF:return ln_HALF_cosh;case LN_FLOAT:return ln_FLOAT_cosh;case LN_DOUBLE:return ln_DOUBLE_cosh;case LN_LONGDOUBLE:return ln_LONGDOUBLE_cosh;case LN_CFLOAT:return ln_CFLOAT_cosh;case LN_CDOUBLE:return ln_CDOUBLE_cosh;case LN_CLONGDOUBLE:return ln_CLONGDOUBLE_cosh;default:return NULL;}
        case LN_OP_TANH:
            switch(type_num){case LN_HALF:return ln_HALF_tanh;case LN_FLOAT:return ln_FLOAT_tanh;case LN_DOUBLE:return ln_DOUBLE_tanh;case LN_LONGDOUBLE:return ln_LONGDOUBLE_tanh;case LN_CFLOAT:return ln_CFLOAT_tanh;case LN_CDOUBLE:return ln_CDOUBLE_tanh;case LN_CLONGDOUBLE:return ln_CLONGDOUBLE_tanh;default:return NULL;}
        case LN_OP_EXP2:
            switch(type_num){case LN_HALF:return ln_HALF_exp2;case LN_FLOAT:return ln_FLOAT_exp2;case LN_DOUBLE:return ln_DOUBLE_exp2;case LN_LONGDOUBLE:return ln_LONGDOUBLE_exp2;case LN_CFLOAT:return ln_CFLOAT_exp2;case LN_CDOUBLE:return ln_CDOUBLE_exp2;case LN_CLONGDOUBLE:return ln_CLONGDOUBLE_exp2;default:return NULL;}
        case LN_OP_LOG2:
            switch(type_num){case LN_HALF:return ln_HALF_log2;case LN_FLOAT:return ln_FLOAT_log2;case LN_DOUBLE:return ln_DOUBLE_log2;case LN_LONGDOUBLE:return ln_LONGDOUBLE_log2;case LN_CFLOAT:return ln_CFLOAT_log2;case LN_CDOUBLE:return ln_CDOUBLE_log2;case LN_CLONGDOUBLE:return ln_CLONGDOUBLE_log2;default:return NULL;}
        case LN_OP_LOG10:
            switch(type_num){case LN_HALF:return ln_HALF_log10;case LN_FLOAT:return ln_FLOAT_log10;case LN_DOUBLE:return ln_DOUBLE_log10;case LN_LONGDOUBLE:return ln_LONGDOUBLE_log10;case LN_CFLOAT:return ln_CFLOAT_log10;case LN_CDOUBLE:return ln_CDOUBLE_log10;case LN_CLONGDOUBLE:return ln_CLONGDOUBLE_log10;default:return NULL;}
        case LN_OP_EXPM1:
            switch(type_num){case LN_HALF:return ln_HALF_expm1;case LN_FLOAT:return ln_FLOAT_expm1;case LN_DOUBLE:return ln_DOUBLE_expm1;case LN_LONGDOUBLE:return ln_LONGDOUBLE_expm1;case LN_CFLOAT:return ln_CFLOAT_expm1;case LN_CDOUBLE:return ln_CDOUBLE_expm1;case LN_CLONGDOUBLE:return ln_CLONGDOUBLE_expm1;default:return NULL;}
        case LN_OP_LOG1P:
            switch(type_num){case LN_HALF:return ln_HALF_log1p;case LN_FLOAT:return ln_FLOAT_log1p;case LN_DOUBLE:return ln_DOUBLE_log1p;case LN_LONGDOUBLE:return ln_LONGDOUBLE_log1p;case LN_CFLOAT:return ln_CFLOAT_log1p;case LN_CDOUBLE:return ln_CDOUBLE_log1p;case LN_CLONGDOUBLE:return ln_CLONGDOUBLE_log1p;default:return NULL;}
        case LN_OP_CBRT:
            switch(type_num){case LN_HALF:return ln_HALF_cbrt;case LN_FLOAT:return ln_FLOAT_cbrt;case LN_DOUBLE:return ln_DOUBLE_cbrt;case LN_LONGDOUBLE:return ln_LONGDOUBLE_cbrt;default:return NULL;}
        case LN_OP_ARCSIN:
            switch(type_num){case LN_HALF:return ln_HALF_arcsin;case LN_FLOAT:return ln_FLOAT_arcsin;case LN_DOUBLE:return ln_DOUBLE_arcsin;case LN_LONGDOUBLE:return ln_LONGDOUBLE_arcsin;case LN_CFLOAT:return ln_CFLOAT_arcsin;case LN_CDOUBLE:return ln_CDOUBLE_arcsin;case LN_CLONGDOUBLE:return ln_CLONGDOUBLE_arcsin;default:return NULL;}
        case LN_OP_ARCCOS:
            switch(type_num){case LN_HALF:return ln_HALF_arccos;case LN_FLOAT:return ln_FLOAT_arccos;case LN_DOUBLE:return ln_DOUBLE_arccos;case LN_LONGDOUBLE:return ln_LONGDOUBLE_arccos;case LN_CFLOAT:return ln_CFLOAT_arccos;case LN_CDOUBLE:return ln_CDOUBLE_arccos;case LN_CLONGDOUBLE:return ln_CLONGDOUBLE_arccos;default:return NULL;}
        case LN_OP_ARCTAN:
            switch(type_num){case LN_HALF:return ln_HALF_arctan;case LN_FLOAT:return ln_FLOAT_arctan;case LN_DOUBLE:return ln_DOUBLE_arctan;case LN_LONGDOUBLE:return ln_LONGDOUBLE_arctan;case LN_CFLOAT:return ln_CFLOAT_arctan;case LN_CDOUBLE:return ln_CDOUBLE_arctan;case LN_CLONGDOUBLE:return ln_CLONGDOUBLE_arctan;default:return NULL;}
        case LN_OP_ARCSINH:
            switch(type_num){case LN_HALF:return ln_HALF_arcsinh;case LN_FLOAT:return ln_FLOAT_arcsinh;case LN_DOUBLE:return ln_DOUBLE_arcsinh;case LN_LONGDOUBLE:return ln_LONGDOUBLE_arcsinh;case LN_CFLOAT:return ln_CFLOAT_arcsinh;case LN_CDOUBLE:return ln_CDOUBLE_arcsinh;case LN_CLONGDOUBLE:return ln_CLONGDOUBLE_arcsinh;default:return NULL;}
        case LN_OP_ARCCOSH:
            switch(type_num){case LN_HALF:return ln_HALF_arccosh;case LN_FLOAT:return ln_FLOAT_arccosh;case LN_DOUBLE:return ln_DOUBLE_arccosh;case LN_LONGDOUBLE:return ln_LONGDOUBLE_arccosh;case LN_CFLOAT:return ln_CFLOAT_arccosh;case LN_CDOUBLE:return ln_CDOUBLE_arccosh;case LN_CLONGDOUBLE:return ln_CLONGDOUBLE_arccosh;default:return NULL;}
        case LN_OP_ARCTANH:
            switch(type_num){case LN_HALF:return ln_HALF_arctanh;case LN_FLOAT:return ln_FLOAT_arctanh;case LN_DOUBLE:return ln_DOUBLE_arctanh;case LN_LONGDOUBLE:return ln_LONGDOUBLE_arctanh;case LN_CFLOAT:return ln_CFLOAT_arctanh;case LN_CDOUBLE:return ln_CDOUBLE_arctanh;case LN_CLONGDOUBLE:return ln_CLONGDOUBLE_arctanh;default:return NULL;}
        case LN_OP_ARCTAN2:
            switch(type_num){case LN_HALF:return ln_HALF_arctan2;case LN_FLOAT:return ln_FLOAT_arctan2;case LN_DOUBLE:return ln_DOUBLE_arctan2;case LN_LONGDOUBLE:return ln_LONGDOUBLE_arctan2;default:return NULL;}
        case LN_OP_HYPOT:
            switch(type_num){case LN_HALF:return ln_HALF_hypot;case LN_FLOAT:return ln_FLOAT_hypot;case LN_DOUBLE:return ln_DOUBLE_hypot;case LN_LONGDOUBLE:return ln_LONGDOUBLE_hypot;default:return NULL;}
        default: return NULL;
    }
    #undef LN_RET_CASE
}
