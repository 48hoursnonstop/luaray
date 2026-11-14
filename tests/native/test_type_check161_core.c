#include "ln_type_check.h"
#include <assert.h>
#include <stdio.h>
int main(void){
 ln_error error={0};const ln_dtype *i=ln_dtype_by_name("int64"),*q=ln_dtype_by_name("longlong");
 assert(ln_isdtype_class(i,i,&error)==1);assert(ln_isdtype_class(i,q,&error)==0);
 assert(ln_isdtype_class(ln_dtype_by_name("S3"),ln_dtype_by_name("S8"),&error)==1);
 assert(ln_isdtype_class(ln_dtype_by_name("datetime64[D]"),ln_dtype_by_name("datetime64[ns]"),&error)==1);
 assert(ln_isdtype_kind(i,"integral",8,&error)==1);
 assert(ln_isdtype_kind(ln_dtype_by_name("bool"),"numeric",7,&error)==0);
 assert(ln_isdtype_kind(i,"numeric\0ignored",15,&error)<0);
 assert(ln_isdtype_kind(NULL,"numeric",7,&error)<0);assert(ln_isdtype_class(i,NULL,&error)<0);
 const ln_dtype *types[]={ln_dtype_by_name("float16"),i,ln_dtype_by_name("complex64"),ln_dtype_by_name("longdouble")};
 assert(ln_common_inexact_type(NULL,0,&error)->type_num==LN_HALF);
 assert(ln_common_inexact_type(types,1,&error)->type_num==LN_HALF);
 assert(ln_common_inexact_type(types,2,&error)->type_num==LN_DOUBLE);
 assert(ln_common_inexact_type(types,3,&error)->type_num==LN_CDOUBLE);
 assert(ln_common_inexact_type(types,4,&error)->type_num==LN_CLONGDOUBLE);
 const ln_dtype *duration[]={ln_dtype_by_name("timedelta64[h]")};
 assert(ln_common_inexact_type(duration,1,&error)->type_num==LN_DOUBLE);
 assert(ln_isdtype_kind(duration[0],"numeric",7,&error)==0);
 const ln_dtype *bad[]={ln_dtype_by_name("bool")};assert(!ln_common_inexact_type(bad,1,&error));
 bad[0]=NULL;assert(!ln_common_inexact_type(bad,1,&error));assert(!ln_common_inexact_type(NULL,1,&error));
 puts("type_check161 native: scalar-class identity, categories, precision selection and duration rules passed");return 0;
}
