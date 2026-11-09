#ifndef LUARAY_TIME_SCALE_H
#define LUARAY_TIME_SCALE_H
#include "ln_ufunc.h"
void ln_time_scale_method(ln_ufunc_loop *method,int temporal_index,int divide);
void ln_time_integer_multiply_method(ln_ufunc_loop *method,int temporal_index);
int ln_time_scale_resolve(const ln_ufunc *u,const ln_array *const *inputs,
                          const ln_ufunc_loop **method,ln_error *err);
#endif
