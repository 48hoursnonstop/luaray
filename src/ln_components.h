#ifndef LUARAY_COMPONENTS_H
#define LUARAY_COMPONENTS_H
#include "ln_core.h"
/* Always returns an owned header: complex components share storage, real
 * noncomplex inputs retain identity at the Lua boundary, other imag is zero/RO. */
ln_array *ln_component_part(const ln_array *a,int imaginary,ln_error *err);
#endif
