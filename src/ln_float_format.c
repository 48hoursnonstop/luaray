/* Native string boundary for the licensed numerical core in ln_dragon4.inc. */
#include "ln_float_format.h"
#include "ln_core.h"
#include "ln_half.h"
#include "ln_dragon4.inc"

int ln_float_format(const char *src,int type_num,int component,char *buf,size_t cap)
{
    if(!src||!buf||!cap)return -1;
    long double value;ln_half half=0;float single=0;double dbl=0;long double extended=0;
    switch(type_num) {
        case LN_HALF:memcpy(&half,src,sizeof(half));value=ln_half_to_float(half);break;
        case LN_FLOAT:memcpy(&single,src,sizeof(single));value=single;break;
        case LN_DOUBLE:memcpy(&dbl,src,sizeof(dbl));value=dbl;break;
        case LN_LONGDOUBLE:memcpy(&extended,src,sizeof(extended));value=extended;break;
        default:return -1;
    }
    long double absolute=fabsl(value),maximum=type_num==LN_HALF?1e3L:type_num==LN_FLOAT?1e6L:1e16L;
    Dragon4_Options opt;
    opt.scientific=!(isnan(value)||value==0||(absolute<maximum&&absolute>=1e-4L));
    opt.digit_mode=DigitMode_Unique;opt.cutoff_mode=CutoffMode_TotalLength;
    opt.precision=-1;opt.min_digits=-1;opt.sign=0;
    opt.trim_mode=component||opt.scientific?TrimMode_DptZeros:TrimMode_LeaveOneZero;
    opt.digits_left=-1;opt.digits_right=-1;opt.exp_digits=-1;
    int count=-1;
    switch(type_num) {
        case LN_HALF:count=Dragon4_PrintFloat_IEEE_binary16(&half,&opt);break;
        case LN_FLOAT:count=Dragon4_PrintFloat_IEEE_binary32(&single,&opt);break;
        case LN_DOUBLE:count=Dragon4_PrintFloat_IEEE_binary64(&dbl,&opt);break;
        case LN_LONGDOUBLE:
#if defined(HAVE_LDOUBLE_INTEL_EXTENDED_16_BYTES_LE)
            count=Dragon4_PrintFloat_Intel_extended128(&extended,&opt);
#elif defined(HAVE_LDOUBLE_INTEL_EXTENDED_12_BYTES_LE)
            count=Dragon4_PrintFloat_Intel_extended96(&extended,&opt);
#elif defined(HAVE_LDOUBLE_IEEE_QUAD_LE)
            count=Dragon4_PrintFloat_IEEE_binary128_le(&extended,&opt);
#elif defined(HAVE_LDOUBLE_IEEE_QUAD_BE)
            count=Dragon4_PrintFloat_IEEE_binary128_be(&extended,&opt);
#elif LDBL_MANT_DIG == 53
            dbl=(double)extended;count=Dragon4_PrintFloat_IEEE_binary64(&dbl,&opt);
#endif
            break;
    }
    if(count<0||(size_t)count>=cap)return -1;
    memcpy(buf,_bigint_static.repr,(size_t)count+1);return count;
}
