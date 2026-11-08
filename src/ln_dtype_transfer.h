#ifndef LUARAY_DTYPE_TRANSFER_H
#define LUARAY_DTYPE_TRANSFER_H

#include "ln_core.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef enum ln_casting {
    LN_NO_CASTING = 0,
    LN_EQUIV_CASTING = 1,
    LN_SAFE_CASTING = 2,
    LN_SAME_KIND_CASTING = 3,
    LN_UNSAFE_CASTING = 4,
    LN_SAME_VALUE_CASTING = 64
} ln_casting;

/* NumPy-style casting policy on concrete descriptors.  The return value of
 * ln_dtype_cast_safety is the minimum policy required for the cast, or -1 if
 * no transfer exists in the current runtime. */
int ln_parse_casting(const char *name, ln_casting *out);
int ln_parse_casting_same_value(const char *name, ln_casting *out);
const char *ln_casting_name(ln_casting casting);
int ln_dtype_cast_safety(const ln_dtype_descr *from, const ln_dtype_descr *to);
int ln_dtype_can_cast(const ln_dtype_descr *from, const ln_dtype_descr *to,
                      ln_casting casting);
int ln_dtype_supports_same_value(const ln_dtype_descr *from, const ln_dtype_descr *to);
int ln_cast_same_value_one(const char *src, const ln_dtype_descr *from,
                           const ln_dtype_descr *to, ln_error *err);

/* Required legacy fixed-width string capacity for casting FROM.  This is the
 * descriptor-level counterpart of NumPy's cast_to_string_resolve_descriptors. */
size_t ln_legacy_string_width_for_dtype(const ln_dtype_descr *src);

/*
 * Numeric strided transfer loop, modeled after NumPy's dtype-transfer layer:
 *
 *   numpy/_core/src/multiarray/dtype_transfer.c
 *   numpy/_core/src/multiarray/lowlevel_strided_loops.c.src
 *
 * The current port only exposes builtin real numeric legacy dtypes.  This
 * function therefore implements the homogeneous numeric casts needed by the
 * buffered ufunc iterator subset.  Source and destination may be unaligned;
 * values are loaded/stored with memcpy like NumPy's unaligned loops.
 */
int ln_cast_strided_numeric(const char *src, ln_intp src_stride,
                            const ln_dtype *src_dtype,
                            char *dst, ln_intp dst_stride,
                            const ln_dtype *dst_dtype,
                            ln_intp count, ln_error *err);

#ifdef __cplusplus
}
#endif
#endif
