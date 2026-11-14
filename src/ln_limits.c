/* NumPy2.5.4 getlimits.py and arraytypes.c.src get_constant.
 * Host C limits describe supported native scalar formats; no runtime probing
 * through Python or decimal string approximations is involved. */
#include "ln_limits.h"
#include "ln_half.h"
#include <float.h>
#include <math.h>
#include <stdio.h>
#include <string.h>
static int bad(ln_error *err,const char *message)
{if(err)snprintf(err->message,sizeof err->message,"%s",message);return -1;}
static int exponent_bits(int extent)
{int bits=0;unsigned bound=1;while(bound<(unsigned)extent){bound<<=1;bits++;}return bits;}
int ln_finfo(const ln_dtype *dtype,ln_float_info *info,ln_error *err)
{
 if(!dtype||!info)return bad(err,"finfo requires a floating dtype");
 int type=dtype->type_num;
 if(type==LN_CFLOAT)dtype=ln_dtype_by_num(LN_FLOAT);
 else if(type==LN_CDOUBLE)dtype=ln_dtype_by_num(LN_DOUBLE);
 else if(type==LN_CLONGDOUBLE)dtype=ln_dtype_by_num(LN_LONGDOUBLE);
 if(dtype->kind!='f')return bad(err,"finfo requires a floating or complex dtype");
 memset(info,0,sizeof(*info));info->dtype=dtype;info->bits=(int)dtype->elsize*8;
 switch(dtype->type_num){
 case LN_HALF:
  info->nmant=10;info->minexp=-14;info->maxexp=16;info->precision=3;
  info->eps=0x1p-10L;info->maximum=65504;info->smallest_normal=0x1p-14L;info->smallest_subnormal=0x1p-24L;
  info->resolution=ln_half_to_float(ln_float_to_half(powf(10.0f,-3.0f)));break;
 case LN_FLOAT:
  info->nmant=FLT_MANT_DIG-1;info->minexp=FLT_MIN_EXP-1;info->maxexp=FLT_MAX_EXP;info->precision=FLT_DIG;
  info->eps=FLT_EPSILON;info->maximum=FLT_MAX;info->smallest_normal=FLT_MIN;info->smallest_subnormal=nextafterf(0.0f,1.0f);
  info->resolution=powf(10.0f,-FLT_DIG);break;
 case LN_DOUBLE:
  info->nmant=DBL_MANT_DIG-1;info->minexp=DBL_MIN_EXP-1;info->maxexp=DBL_MAX_EXP;info->precision=DBL_DIG;
  info->eps=DBL_EPSILON;info->maximum=DBL_MAX;info->smallest_normal=DBL_MIN;info->smallest_subnormal=nextafter(0.0,1.0);
  info->resolution=pow(10.0,-DBL_DIG);break;
 case LN_LONGDOUBLE:
  info->nmant=LDBL_MANT_DIG-1;info->minexp=LDBL_MIN_EXP-1;info->maxexp=LDBL_MAX_EXP;info->precision=LDBL_DIG;
  info->eps=LDBL_EPSILON;info->maximum=LDBL_MAX;info->smallest_normal=LDBL_MIN;info->smallest_subnormal=nextafterl(0.0L,1.0L);
  info->resolution=powl(10.0L,-LDBL_DIG);break;
 default:return bad(err,"unsupported floating dtype for finfo");
 }
 info->minimum=-info->maximum;info->epsneg=info->eps/2;
 info->machep=-info->nmant;info->negep=-info->nmant-1;
 info->iexp=exponent_bits(info->maxexp-info->minexp);
 info->nexp=exponent_bits(info->maxexp-info->minexp+2);return 0;
}
int ln_iinfo(const ln_dtype *dtype,ln_integer_info *info,ln_error *err)
{
 if(!dtype||!info||(dtype->kind!='i'&&dtype->kind!='u')||!dtype->elsize||dtype->elsize>8)
  return bad(err,"iinfo requires an integer dtype");
 memset(info,0,sizeof(*info));info->dtype=dtype;info->kind=dtype->kind;info->bits=(int)dtype->elsize*8;
 if(dtype->kind=='u')info->maximum=info->bits==64?UINT64_MAX:((UINT64_C(1)<<info->bits)-1);
 else{
  info->maximum=info->bits==64?(uint64_t)INT64_MAX:((UINT64_C(1)<<(info->bits-1))-1);
  info->minimum=-(int64_t)info->maximum-1;
 }
 return 0;
}
