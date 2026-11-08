#ifndef LUARAY_STRING_H
#define LUARAY_STRING_H

#include "ln_core.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Legacy fixed-width NumPy string DTypes: NPY_STRING (S) and
 * NPY_UNICODE (U).  Lua strings are UTF-8 at the public boundary for U;
 * S stores raw bytes. */
const ln_dtype_descr *ln_string_parse_dtype(const char *name, ln_error *err);
const ln_dtype_descr *ln_string_make_dtype(int unicode_kind, size_t nchars,
                                            char byteorder, ln_error *err);
const ln_dtype_descr *ln_string_default_dtype(int unicode_kind);
int ln_string_is_dtype(const ln_dtype_descr *dt);
size_t ln_string_nchars(const ln_dtype_descr *dt);

/* UTF-8/Lua boundary helpers. */
int ln_string_utf8_codepoints(const char *s, size_t nbytes, size_t *out,
                              ln_error *err);
int ln_string_pack_utf8(const ln_dtype_descr *dt, char *dst,
                        const char *s, size_t nbytes, ln_error *err);
int ln_string_unpack_utf8(const ln_dtype_descr *dt, const char *src,
                          char **out, size_t *out_nbytes, ln_error *err);

/* Descriptor-aware fixed-width transfer/comparison. */
int ln_string_cast_one(const char *src, const ln_dtype_descr *src_dt,
                       char *dst, const ln_dtype_descr *dst_dt,
                       ln_error *err);
int ln_string_compare_one(const char *a, const ln_dtype_descr *adt,
                          const char *b, const ln_dtype_descr *bdt,
                          int *cmp, ln_error *err);

#ifdef __cplusplus
}
#endif
#endif
