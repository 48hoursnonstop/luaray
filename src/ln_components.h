#ifndef LUARAY_COMPONENTS_H
#define LUARAY_COMPONENTS_H
#include "ln_core.h"
/* Always returns an owned header: complex components share storage, real
 * noncomplex inputs retain identity at the Lua boundary, other imag is zero/RO. */
ln_array *ln_component_part(const ln_array *a,int imaginary,ln_error *err);
ln_array *ln_component_reality(const ln_array *a,int real,ln_error *err);
/* The caller releases the returned header, even when identity is set. */
ln_array *ln_component_close(const ln_array *a,long double tolerance,
                             int *identity,ln_error *err);
#endif
