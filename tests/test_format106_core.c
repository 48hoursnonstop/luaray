#include "ln_float_format.h"
#include "ln_dtype_transfer.h"
#include <assert.h>
#include <float.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <threads.h>
#include "format106_reference.h"
#define COUNT(a) (sizeof(a)/sizeof((a)[0]))
static unsigned long cases;
static void check_cast(const void *input,int type,const char *text)
{
    ln_error err={{0}};unsigned char ascii[130],unicode[514];
    const ln_dtype *dtype=ln_dtype_by_num(type);
    memset(ascii,0xa5,sizeof(ascii));memset(unicode,0xa5,sizeof(unicode));
    assert(ln_cast_strided_numeric(input,0,dtype,(char *)ascii+1,0,ln_dtype_by_name("S128"),1,&err)==0);
    if(strcmp((char *)ascii+1,text)){fprintf(stderr,"ASCII type%d: %s != %s\n",type,ascii+1,text);assert(0);}
    assert(ascii[0]==0xa5&&ascii[129]==0xa5);
    assert(ln_cast_strided_numeric(input,0,dtype,(char *)unicode+1,0,ln_dtype_by_name("U128"),1,&err)==0);
    size_t length=strlen(text);
    for(size_t i=0;i<128;++i){uint32_t cp;memcpy(&cp,unicode+1+i*4,4);assert(cp==(i<length?(unsigned char)text[i]:0));}
    assert(unicode[0]==0xa5&&unicode[513]==0xa5);cases++;
}
static int thread_format(void *arg)
{
    unsigned id=*(unsigned *)arg;
    for(unsigned i=0;i<2048;++i){uint16_t bits=(uint16_t)(i*31+id*11);char buf[64];
        assert(ln_float_format((const char *)&bits,LN_HALF,0,buf,sizeof(buf))>=0);
        assert(strcmp(buf,format106_half_expected[bits])==0);
    }
    return 0;
}
int main(void)
{
    for(unsigned i=0;i<65536;++i){uint16_t bits=(uint16_t)i;check_cast(&bits,LN_HALF,format106_half_expected[i]);}
    for(size_t i=0;i<COUNT(format106_single);++i){uint32_t bits=(uint32_t)format106_single[i].bits;check_cast(&bits,LN_FLOAT,format106_single[i].text);}
    for(size_t i=0;i<COUNT(format106_double);++i){uint64_t bits=format106_double[i].bits;check_cast(&bits,LN_DOUBLE,format106_double[i].text);}
    for(size_t i=0;i<COUNT(format106_csingle);++i){uint32_t bits[]={(uint32_t)format106_csingle[i].real,(uint32_t)format106_csingle[i].imag};check_cast(bits,LN_CFLOAT,format106_csingle[i].text);}
    for(size_t i=0;i<COUNT(format106_cdouble);++i){uint64_t bits[]={format106_cdouble[i].real,format106_cdouble[i].imag};check_cast(bits,LN_CDOUBLE,format106_cdouble[i].text);}
#if LDBL_MANT_DIG == 64 && __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
    for(size_t i=0;i<COUNT(format106_extended);++i){long double x=0;memcpy(&x,format106_extended[i].bytes,10);check_cast(&x,LN_LONGDOUBLE,format106_extended[i].text);}
#endif
    double value=0;char buf[64];memset(buf,'!',sizeof(buf));
    assert(ln_float_format((const char *)&value,LN_DOUBLE,0,buf,1)<0&&buf[0]=='!');
    assert(ln_float_format(NULL,LN_DOUBLE,0,buf,sizeof(buf))<0);
    assert(ln_float_format((const char *)&value,LN_INT,0,buf,sizeof(buf))<0);
    assert(ln_float_format((const char *)&value,LN_DOUBLE,0,NULL,sizeof(buf))<0);
    assert(ln_float_format((const char *)&value,LN_DOUBLE,0,buf,0)<0);
    thrd_t threads[8];unsigned ids[8];
    for(unsigned i=0;i<8;++i){ids[i]=i;assert(thrd_create(&threads[i],thread_format,&ids[i])==thrd_success);}
    for(unsigned i=0;i<8;++i){int result;assert(thrd_join(threads[i],&result)==thrd_success&&result==0);}
    printf("format106 native reference: %lu raw-bit states, %lu ASCII/Unicode comparisons; 8 threads/16384 calls passed\n",cases,cases*2);
    return 0;
}
