/* NumPy 2.5.5 ctors.c, arraytypes.c.src and numpyos.c text scanning. */
#define _GNU_SOURCE
#include "ln_fromstring.h"
#include "ln_fromiter.h"
#include "ln_complex.h"
#include "ln_half.h"
#include <errno.h>
#include <limits.h>
#include <locale.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>

static ln_array *bad(ln_error *err,const char *message)
{
    if(err)snprintf(err->message,sizeof err->message,"%s",message);
    return NULL;
}

static int space(char c)
{
    return c==' '||(c>='\t'&&c<='\r');
}

static int alnum(char c)
{
    return (c>='0'&&c<='9')||(c>='a'&&c<='z')||(c>='A'&&c<='Z');
}

static const char *skip_space(const char *p)
{
    while(space(*p))++p;
    return p;
}

static long double read_real(const char *start,const char **next,int extended,locale_t locale)
{
    const char *p=skip_space(start);
    const char *number=p+(*p=='-'||*p=='+');
    if(strncasecmp(number,"nan",3)==0){
        number+=3;
        if(*number=='('){
            ++number;
            while(alnum(*number)||*number=='_')++number;
            if(*number==')')++number;
        }
        *next=number;
        return NAN;
    }
    if(strncasecmp(number,"inf",3)==0){
        number+=3;
        *next=number+(strncasecmp(number,"inity",5)==0?5:0);
        return *p=='-'?-INFINITY:INFINITY;
    }
    /* The binary64 source path accepts decimal prefixes only. */
    if(!extended&&number[0]=='0'&&(number[1]=='x'||number[1]=='X')){
        *next=number+1;
        return *p=='-'?-0.0L:0.0L;
    }
    char *end;
    long double value=extended?strtold_l(p,&end,locale):strtod_l(p,&end,locale);
    *next=end;
    if(end==p)return extended?0:-1;
    return value;
}

#define STORE(type,value) do {type packed=(type)(value);memcpy(dst,&packed,sizeof packed);} while(0)
static const char *read_element(const char *start,char *dst,const ln_dtype *dt,locale_t locale)
{
    const char *next=start;
    switch(dt->type_num){
    case LN_BOOL: case LN_HALF: case LN_FLOAT: case LN_DOUBLE: case LN_LONGDOUBLE:
    case LN_CFLOAT: case LN_CDOUBLE: {
        long double real=read_real(start,&next,dt->type_num==LN_LONGDOUBLE,locale);
        switch(dt->type_num){
        case LN_BOOL:STORE(uint8_t,real!=0);break;
        case LN_HALF:STORE(uint16_t,ln_double_to_half((double)real));break;
        case LN_FLOAT:STORE(float,real);break;
        case LN_DOUBLE:STORE(double,real);break;
        case LN_LONGDOUBLE:STORE(long double,real);break;
        default:{
            long double imag=0;
            if(*next=='+'||*next=='-'){
                long double component=read_real(next,&next,0,locale);
                if(*next=='j'){imag=component;++next;}
            }else if(*next=='j'){imag=real;real=0;++next;}
            if(dt->type_num==LN_CFLOAT){ln_cfloat z={(float)real,(float)imag};memcpy(dst,&z,sizeof z);}
            else{ln_cdouble z={(double)real,(double)imag};memcpy(dst,&z,sizeof z);}
            break;
        }
        }
        break;
    }
    case LN_DATETIME: case LN_TIMEDELTA: case LN_LONGLONG: case LN_ULONGLONG:{
        char *end;
        if(dt->type_num==LN_ULONGLONG){unsigned long long v=strtoull_l(start,&end,10,locale);STORE(unsigned long long,v);}
        else{long long v=strtoll_l(start,&end,10,locale);STORE(int64_t,v);}
        next=end;
        break;
    }
    default:{
        /* CPython's legacy long parser skips space on both sides of a sign.
         * Its unsigned version accepts digits directly, without a sign. */
        const char *p=skip_space(start);
        int negative=0,uns=dt->kind=='u';
        if(!uns&&(*p=='+'||*p=='-')){negative=*p=='-';p=skip_space(p+1);}
        char *end=NULL;
        unsigned long magnitude=0;
        errno=0;
        if(*p>='0'&&*p<='9')magnitude=strtoul_l(p,&end,10,locale);
        next=end?end:p;
        unsigned long value=magnitude;
        if(!uns){
            unsigned long limit=(unsigned long)LONG_MAX+(unsigned)negative;
            if(errno==ERANGE||magnitude>limit)value=LONG_MAX;
            else if(negative)value=0UL-magnitude;
        }
        switch(dt->type_num){
        case LN_BYTE:case LN_UBYTE:STORE(uint8_t,value);break;
        case LN_SHORT:case LN_USHORT:STORE(uint16_t,value);break;
        case LN_INT:case LN_UINT:STORE(unsigned int,value);break;
        default:STORE(unsigned long,value);break;
        }
        break;
    }
    }
    return next;
}
#undef STORE

static const char *skip_separator(const char *start,const char *end,const char *sep,int *status)
{
    const char *p=start;
    while(p<end){
        if(!*sep){*status=p==start?-1:0;return p;}
        if(*sep==' '){
            if(!space(*p)){++sep;continue;}
        }else if(*p!=*sep){*status=-1;return p;}
        else ++sep;
        ++p;
    }
    *status=1;
    return p;
}

ln_array *ln_array_fromstring(const char *text,size_t length,const ln_dtype *dtype,
                             ln_intp count,const char *separator,size_t sep_length,ln_error *err)
{
    if(!text||length>INTPTR_MAX)return bad(err,"invalid input text span");
    if(!separator||!sep_length||sep_length>SIZE_MAX-3||memchr(separator,0,sep_length))
        return bad(err,"fromstring requires a nonempty text separator");
    if(!dtype||!dtype->elsize||dtype->kind=='S'||dtype->kind=='U'||dtype->type_num==LN_CLONGDOUBLE)
        return bad(err,"dtype does not support fromstring text parsing");
    ln_array *result=ln_fromiter_new(dtype,0,err);
    if(!result||count==0)return result;
    char *buffer=malloc(length+1),*sep=malloc(sep_length+3);
    locale_t locale=newlocale(LC_ALL_MASK,"C",NULL);
    ln_intp written=0;
    const char *failure=NULL;
    if(!buffer||!sep||!locale){failure="cannot allocate text parser state";goto fail;}
    memcpy(buffer,text,length);buffer[length]=0;
    char *target=sep;
    if(!space(separator[0]))*target++=' ';
    for(size_t i=0;i<sep_length;++i){
        char c=separator[i];
        if(!space(c))*target++=c;
        else if(target==sep||target[-1]!=' ')*target++=' ';
    }
    *target=0;
    const char *p=buffer,*end=buffer+length;
    while(p<end&&(count<0||written<count)){
        /* A local element avoids growing the result for failed scans. */
        unsigned char cell[sizeof(ln_clongdouble)]={0};
        if(dtype->elsize>sizeof cell){failure="unsupported text element width";goto fail;}
        const char *next=read_element(p,(char*)cell,dtype,locale);
        if(next==p){failure="unmatched data in fromstring input";goto fail;}
        if(ln_fromiter_reserve(result,written,err)<0)goto fail;
        memcpy(result->data+written*(ln_intp)dtype->elsize,cell,dtype->elsize);
        ++written;
        if(written==count)break;
        int status;
        p=skip_separator(next,end,sep,&status);
        if(status<0){failure="unmatched separator in fromstring input";goto fail;}
        if(status>0)break;
    }
    if(count>0&&written<count){failure="fromstring read fewer elements than count";goto fail;}
    if(ln_fromiter_finish(result,written,err)<0)goto fail;
    /* NumPy shrinks its initial positive-capacity allocation in place. */
    if(!written)result->strides[0]=(ln_intp)dtype->elsize;
    free(buffer);free(sep);freelocale(locale);
    return result;
fail:
    free(buffer);free(sep);if(locale)freelocale(locale);
    ln_array_free(result);
    return failure?bad(err,failure):NULL;
}
