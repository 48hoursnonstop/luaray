#include "ln_half.h"
#include <string.h>

/* Direct C translation of NumPy main:
 * numpy/_core/src/common/half_private.hpp and npymath/halffloat.cpp.
 * Floating-point status flag plumbing is intentionally outside this tranche;
 * bit conversion and round-to-nearest-ties-even behavior are preserved. */
static uint32_t fbits(float f){uint32_t u;memcpy(&u,&f,sizeof u);return u;}
static uint64_t dbits(double d){uint64_t u;memcpy(&u,&d,sizeof u);return u;}
static float ffrom(uint32_t u){float f;memcpy(&f,&u,sizeof f);return f;}
static double dfrom(uint64_t u){double d;memcpy(&d,&u,sizeof d);return d;}

static uint16_t from_float_bits(uint32_t f)
{
    uint32_t f_exp,f_sig; uint16_t h_sgn,h_exp,h_sig;
    h_sgn=(uint16_t)((f&0x80000000u)>>16); f_exp=f&0x7f800000u;
    if(f_exp>=0x47800000u){
        if(f_exp==0x7f800000u){
            f_sig=f&0x007fffffu;
            if(f_sig){uint16_t r=(uint16_t)(0x7c00u+(f_sig>>13));if(r==0x7c00u)r++;return (uint16_t)(h_sgn+r);}
            return (uint16_t)(h_sgn+0x7c00u);
        }
        return (uint16_t)(h_sgn+0x7c00u);
    }
    if(f_exp<=0x38000000u){
        if(f_exp<0x33000000u)return h_sgn;
        f_exp>>=23; f_sig=0x00800000u+(f&0x007fffffu);
        f_sig>>=(113-f_exp);
        if(((f_sig&0x00003fffu)!=0x00001000u)||(f&0x000007ffu))f_sig+=0x00001000u;
        h_sig=(uint16_t)(f_sig>>13); return (uint16_t)(h_sgn+h_sig);
    }
    h_exp=(uint16_t)((f_exp-0x38000000u)>>13); f_sig=f&0x007fffffu;
    if((f_sig&0x00003fffu)!=0x00001000u)f_sig+=0x00001000u;
    h_sig=(uint16_t)(f_sig>>13); h_sig=(uint16_t)(h_sig+h_exp);
    return (uint16_t)(h_sgn+h_sig);
}

static uint16_t from_double_bits(uint64_t d)
{
    uint64_t d_exp,d_sig; uint16_t h_sgn,h_exp,h_sig;
    h_sgn=(uint16_t)((d&0x8000000000000000ULL)>>48); d_exp=d&0x7ff0000000000000ULL;
    if(d_exp>=0x40f0000000000000ULL){
        if(d_exp==0x7ff0000000000000ULL){
            d_sig=d&0x000fffffffffffffULL;
            if(d_sig){uint16_t r=(uint16_t)(0x7c00u+(d_sig>>42));if(r==0x7c00u)r++;return (uint16_t)(h_sgn+r);}
            return (uint16_t)(h_sgn+0x7c00u);
        }
        return (uint16_t)(h_sgn+0x7c00u);
    }
    if(d_exp<=0x3f00000000000000ULL){
        if(d_exp<0x3e60000000000000ULL)return h_sgn;
        d_exp>>=52; d_sig=0x0010000000000000ULL+(d&0x000fffffffffffffULL);
        d_sig<<=(d_exp-998);
        if((d_sig&0x003fffffffffffffULL)!=0x0010000000000000ULL)d_sig+=0x0010000000000000ULL;
        h_sig=(uint16_t)(d_sig>>53); return (uint16_t)(h_sgn+h_sig);
    }
    h_exp=(uint16_t)((d_exp-0x3f00000000000000ULL)>>42); d_sig=d&0x000fffffffffffffULL;
    if((d_sig&0x000007ffffffffffULL)!=0x0000020000000000ULL)d_sig+=0x0000020000000000ULL;
    h_sig=(uint16_t)(d_sig>>42); h_sig=(uint16_t)(h_sig+h_exp);
    return (uint16_t)(h_sgn+h_sig);
}

static uint32_t to_float_bits(uint16_t h)
{
    uint16_t h_exp=h&0x7c00u; uint32_t f_sgn=((uint32_t)h&0x8000u)<<16;
    if(h_exp==0){
        uint16_t h_sig=h&0x03ffu; if(!h_sig)return f_sgn;
        h_sig<<=1; while((h_sig&0x0400u)==0){h_sig<<=1;h_exp++;}
        uint32_t f_exp=((uint32_t)(127-15-h_exp))<<23;
        uint32_t f_sig=((uint32_t)(h_sig&0x03ffu))<<13;
        return f_sgn+f_exp+f_sig;
    }
    if(h_exp==0x7c00u)return f_sgn+0x7f800000u+(((uint32_t)(h&0x03ffu))<<13);
    return f_sgn+(((uint32_t)(h&0x7fffu)+0x1c000u)<<13);
}

static uint64_t to_double_bits(uint16_t h)
{
    uint16_t h_exp=h&0x7c00u; uint64_t d_sgn=((uint64_t)h&0x8000u)<<48;
    if(h_exp==0){
        uint16_t h_sig=h&0x03ffu; if(!h_sig)return d_sgn;
        h_sig<<=1; while((h_sig&0x0400u)==0){h_sig<<=1;h_exp++;}
        uint64_t d_exp=((uint64_t)(1023-15-h_exp))<<52;
        uint64_t d_sig=((uint64_t)(h_sig&0x03ffu))<<42;
        return d_sgn+d_exp+d_sig;
    }
    if(h_exp==0x7c00u)return d_sgn+0x7ff0000000000000ULL+(((uint64_t)(h&0x03ffu))<<42);
    return d_sgn+(((uint64_t)(h&0x7fffu)+0xfc000u)<<42);
}

float ln_half_to_float(ln_half h){return ffrom(to_float_bits(h));}
double ln_half_to_double(ln_half h){return dfrom(to_double_bits(h));}
ln_half ln_float_to_half(float f){return from_float_bits(fbits(f));}
ln_half ln_double_to_half(double d){return from_double_bits(dbits(d));}
int ln_half_iszero(ln_half h){return (h&0x7fffu)==0;}
int ln_half_isnan(ln_half h){return ((h&0x7c00u)==0x7c00u)&&((h&0x03ffu)!=0);}
int ln_half_isinf(ln_half h){return (h&0x7fffu)==0x7c00u;}
int ln_half_isfinite(ln_half h){return (h&0x7c00u)!=0x7c00u;}
int ln_half_signbit(ln_half h){return (h&0x8000u)!=0;}
static int half_equal_nonan(ln_half a,ln_half b){return a==b||((a|b)==0x8000u);}
static int half_less_nonan(ln_half a,ln_half b){int sa=(a&0x8000u)!=0,sb=(b&0x8000u)!=0;return sa==sb ? ((sa^(a<b))&&(a!=b)) : sa&&((a|b)!=0x8000u);}
static int half_le_nonan(ln_half a,ln_half b){int sa=(a&0x8000u)!=0,sb=(b&0x8000u)!=0;return sa==sb ? ((sa^(a<b))||(a==b)) : sa||((a|b)==0x8000u);}
int ln_half_eq(ln_half a,ln_half b){return !(ln_half_isnan(a)||ln_half_isnan(b))&&half_equal_nonan(a,b);}
int ln_half_ne(ln_half a,ln_half b){return !ln_half_eq(a,b);}
int ln_half_lt(ln_half a,ln_half b){return !(ln_half_isnan(a)||ln_half_isnan(b))&&half_less_nonan(a,b);}
int ln_half_le(ln_half a,ln_half b){return !(ln_half_isnan(a)||ln_half_isnan(b))&&half_le_nonan(a,b);}
int ln_half_gt(ln_half a,ln_half b){return ln_half_lt(b,a);}
int ln_half_ge(ln_half a,ln_half b){return ln_half_le(b,a);}
ln_half ln_half_copysign(ln_half x,ln_half y){return (ln_half)((x&0x7fffu)|(y&0x8000u));}
