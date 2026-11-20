#ifndef LUARAY_MEMBERSHIP_H
#define LUARAY_MEMBERSHIP_H
#include "ln_core.h"

/* A NULL result with fallback=1 means the caller may use sorting. */
ln_array *ln_isin_table(const ln_array *values,const ln_array *keys,int invert,
                        int force,int *fallback,ln_error *err);
#endif
