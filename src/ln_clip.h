#ifndef LUARAY_CLIP_H
#define LUARAY_CLIP_H
#include "ln_ufunc.h"
const ln_ufunc *ln_clip_ufunc(void);
/* a is a rooted, borrowed ndarray; NULL bounds mean None. Output has the
 * same ownership contract as ln_ufunc_execute. */
int ln_array_clip(const ln_array *a,const ln_ufunc_operand *minimum,
        const ln_ufunc_operand *maximum,ln_array **out,const ln_array *where,
        ln_error *err);
#endif
