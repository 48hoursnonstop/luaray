#ifndef LUARAY_RAW_FILE_H
#define LUARAY_RAW_FILE_H
#include "ln_core.h"
#include <stdio.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Files are borrowed. Offset is relative to the current file position. */
ln_array *ln_read_raw_file(FILE *file,const ln_dtype *dtype,ln_intp count,
                           int64_t offset,ln_error *err);
int ln_write_raw_file(FILE *file,const ln_array *array,ln_error *err);
#ifdef __cplusplus
}
#endif
#endif
