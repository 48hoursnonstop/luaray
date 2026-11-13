/* Concrete descriptor presentation: NumPy descriptor.c and _dtype.py.
 * Native arithmetic and storage retain the existing descriptor classes. */
#include "ln_dtype_info.h"
#include "ln_dtype_transfer.h"
#include <stdio.h>
#include <string.h>
static char hostorder(void){uint16_t one=1;return *(unsigned char*)&one?'<':'>';}
char ln_dtype_char(const ln_dtype *dtype)
{
    switch(dtype->type_num){
      case LN_BOOL:return '?';case LN_BYTE:return 'b';case LN_UBYTE:return 'B';
      case LN_SHORT:return 'h';case LN_USHORT:return 'H';case LN_INT:return 'i';case LN_UINT:return 'I';
      case LN_LONG:return 'l';case LN_ULONG:return 'L';case LN_LONGLONG:return 'q';case LN_ULONGLONG:return 'Q';
      case LN_HALF:return 'e';case LN_FLOAT:return 'f';case LN_DOUBLE:return 'd';case LN_LONGDOUBLE:return 'g';
      case LN_CFLOAT:return 'F';case LN_CDOUBLE:return 'D';case LN_CLONGDOUBLE:return 'G';
      case LN_STRING:return 'S';case LN_UNICODE:return 'U';case LN_DATETIME:return 'M';case LN_TIMEDELTA:return 'm';
    }
    return 0;
}
char ln_dtype_byteorder(const ln_dtype *dtype)
{
    if(dtype->kind=='S'||dtype->elsize==1)return '|';
    return dtype->byteorder==hostorder()?'=':dtype->byteorder;
}
int ln_dtype_equivalent(const ln_dtype *a,const ln_dtype *b)
{
    return a&&b&&a->kind==b->kind&&a->elsize==b->elsize&&ln_dtype_cast_safety(a,b)==LN_NO_CASTING;
}
static int checked(int written,size_t capacity,ln_error *err)
{
    if(written<0||(size_t)written>=capacity){if(err)snprintf(err->message,sizeof err->message,"dtype representation exceeds buffer");return -1;}
    return 0;
}
int ln_dtype_name(const ln_dtype *d,char *out,size_t capacity,ln_error *err)
{
    int written;
    switch(d->kind){
      case 'b':written=snprintf(out,capacity,"bool");break;
      case 'i':written=snprintf(out,capacity,"int%zu",d->elsize*8);break;
      case 'u':written=snprintf(out,capacity,"uint%zu",d->elsize*8);break;
      case 'f':written=snprintf(out,capacity,"float%zu",d->elsize*8);break;
      case 'c':written=snprintf(out,capacity,"complex%zu",d->elsize*8);break;
      case 'S':case 'U':
        written=d->elsize?snprintf(out,capacity,"%s%zu",d->kind=='S'?"bytes":"str",d->elsize*8):
                         snprintf(out,capacity,"%s",d->kind=='S'?"bytes":"str");break;
      default:written=snprintf(out,capacity,"%s",d->name);break;
    }
    return checked(written,capacity,err);
}
int ln_dtype_typestr(const ln_dtype *d,char *out,size_t capacity,ln_error *err)
{
    char order=ln_dtype_byteorder(d);if(order=='=')order=hostorder();
    const char *metadata=(d->kind=='M'||d->kind=='m')?strchr(d->name,'['):NULL;
    size_t width=d->kind=='U'?d->elsize/4:d->elsize;
    return checked(snprintf(out,capacity,"%c%c%zu%s",order,d->kind,width,metadata?metadata:""),capacity,err);
}
