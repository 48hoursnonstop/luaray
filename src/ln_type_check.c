/* NumPy2.5.4 numerictypes.py:isdtype and _type_check_impl.py:common_type. */
#include "ln_type_check.h"
#include <stdio.h>
#include <string.h>
static int bad(ln_error *err,const char *text)
{if(err)snprintf(err->message,sizeof err->message,"%s",text);return -1;}
int ln_isdtype_class(const ln_dtype *dtype,const ln_dtype *kind,ln_error *err)
{
 if(!dtype||!kind)return bad(err,"isdtype requires dtype descriptors");
 return dtype->type_num==kind->type_num;
}
int ln_isdtype_kind(const ln_dtype *dtype,const char *kind,size_t length,ln_error *err)
{
 if(!dtype||!kind)return bad(err,"isdtype requires a dtype and kind");
 char c=dtype->kind;
 #define KIND(name,value) if(length==sizeof(name)-1&&!memcmp(kind,name,sizeof(name)-1))return (value);
 KIND("bool",c=='b') KIND("signed integer",c=='i') KIND("unsigned integer",c=='u')
 KIND("integral",c=='i'||c=='u') KIND("real floating",c=='f')
 KIND("complex floating",c=='c') KIND("numeric",c=='i'||c=='u'||c=='f'||c=='c')
 #undef KIND
 return bad(err,"unknown dtype kind name");
}
const ln_dtype *ln_common_inexact_type(const ln_dtype *const *dtypes,size_t count,ln_error *err)
{
 if(count&&!dtypes){bad(err,"common_type requires dtype descriptors");return NULL;}
 int precision=0,complex=0;
 for(size_t i=0;i<count;++i){
  const ln_dtype *dtype=dtypes[i];int p;
  if(!dtype){bad(err,"common_type requires dtype descriptors");return NULL;}
  /* Source timedelta64 is an integer scalar subclass for common_type,
   * while isdtype's explicit integer-category sets exclude it. */
  if(dtype->kind=='i'||dtype->kind=='u'||dtype->kind=='m')p=2;
  else switch(dtype->type_num){
   case LN_HALF:p=0;break;
   case LN_FLOAT:p=1;break;
   case LN_DOUBLE:p=2;break;
   case LN_LONGDOUBLE:p=3;break;
   case LN_CFLOAT:p=1;break;
   case LN_CDOUBLE:p=2;break;
   case LN_CLONGDOUBLE:p=3;break;
   default:bad(err,"cannot get a common inexact type for a nonnumeric array");return NULL;
  }
  if(dtype->kind=='c')complex=1;
  if(p>precision)precision=p;
 }
 static const int types[2][4]={{LN_HALF,LN_FLOAT,LN_DOUBLE,LN_LONGDOUBLE},{-1,LN_CFLOAT,LN_CDOUBLE,LN_CLONGDOUBLE}};
 return ln_dtype_by_num(types[complex][precision]);
}
