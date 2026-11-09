#ifndef LUARAY_ROUND_H
#define LUARAY_ROUND_H
#include "ln_core.h"
/* *out may be a borrowed destination or NULL. Newly allocated output transfers
 * to the caller on success; caller destinations retain actual partial writes. */
int ln_array_round(const ln_array *a,int decimals,ln_array **out,ln_error *err);
#endif
