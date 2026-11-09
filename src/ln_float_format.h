#ifndef LUARAY_FLOAT_FORMAT_H
#define LUARAY_FLOAT_FORMAT_H
#include <stddef.h>
/* NumPy2.5.3 scalar str precision/cutoffs; component omits a trailing .0.
 * Copies from unaligned input into caller-owned output. Returns length or -1.
 * Supported type numbers: HALF/FLOAT/DOUBLE/LONGDOUBLE. No interpreter API. */
int ln_float_format(const char *src,int type_num,int component,char *buf,size_t cap);
#endif
