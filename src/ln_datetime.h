#ifndef LUARAY_DATETIME_H
#define LUARAY_DATETIME_H
#include "ln_core.h"
#ifdef __cplusplus
extern "C" {
#endif

typedef enum ln_datetime_unit {
    LN_FR_ERROR=-1, LN_FR_Y=0, LN_FR_M=1, LN_FR_W=2,
    LN_FR_D=4, LN_FR_h=5, LN_FR_m=6, LN_FR_s=7,
    LN_FR_ms=8, LN_FR_us=9, LN_FR_ns=10, LN_FR_ps=11,
    LN_FR_fs=12, LN_FR_as=13, LN_FR_GENERIC=14
} ln_datetime_unit;

typedef struct ln_datetime_meta { ln_datetime_unit base; int num; } ln_datetime_meta;
#define LN_DATETIME_NAT INT64_MIN

const ln_dtype_class *ln_datetime_dtype_class(int timedelta);
const ln_dtype_descr *ln_datetime_default_dtype(int timedelta);
const ln_dtype_descr *ln_datetime_parse_dtype(const char *typestr, ln_error *err);
const ln_dtype_descr *ln_datetime_make_dtype(int timedelta, ln_datetime_meta meta, ln_error *err);
const ln_datetime_meta *ln_datetime_metadata(const ln_dtype_descr *dtype);
/* Whether the pinned source's Python item representation is an integer.
 * Returns -1 on invalid metadata/conversion; no Python runs in this helper. */
int ln_datetime_integer_item(int64_t ticks,const ln_dtype *dtype,ln_error *err);
int ln_datetime_metadata_gcd(const ln_datetime_meta *a,const ln_datetime_meta *b,
        int strict_a,int strict_b,ln_datetime_meta *out,ln_error *err);
int ln_datetime_conversion_factor(const ln_datetime_meta *src,const ln_datetime_meta *dst,
        int64_t *num,int64_t *den,ln_error *err);
int ln_datetime_cast_value(int64_t value,const ln_datetime_meta *src,const ln_datetime_meta *dst,
        int64_t *out,ln_error *err);
int ln_datetime_can_cast_metadata(const ln_datetime_meta *src,const ln_datetime_meta *dst,
        int timedelta,int safe);
int ln_datetime_can_cast_same_kind(const ln_datetime_meta *src,const ln_datetime_meta *dst,
        int timedelta);

/* Host-neutral ports of NumPy's datetime/timedelta ufunc loops. */
int ln_datetime_add_checked(int64_t a,int64_t b,int64_t *out,ln_error *err);
void ln_datetime_add_loop(char **args,const ln_intp *dimensions,const ln_intp *steps,void *data);
void ln_datetime_subtract_loop(char **args,const ln_intp *dimensions,const ln_intp *steps,void *data);
void ln_datetime_compare_loop(char **args,const ln_intp *dimensions,const ln_intp *steps,void *data);
void ln_datetime_minmax_loop(char **args,const ln_intp *dimensions,const ln_intp *steps,void *data);
void ln_timedelta_negative_loop(char **args,const ln_intp *dimensions,const ln_intp *steps,void *data);
void ln_timedelta_positive_loop(char **args,const ln_intp *dimensions,const ln_intp *steps,void *data);
void ln_timedelta_absolute_loop(char **args,const ln_intp *dimensions,const ln_intp *steps,void *data);
void ln_timedelta_sign_loop(char **args,const ln_intp *dimensions,const ln_intp *steps,void *data);
void ln_datetime_isnat_loop(char **args,const ln_intp *dimensions,const ln_intp *steps,void *data);
void ln_datetime_isinf_loop(char **args,const ln_intp *dimensions,const ln_intp *steps,void *data);
void ln_datetime_isfinite_loop(char **args,const ln_intp *dimensions,const ln_intp *steps,void *data);
const char *ln_datetime_unit_name(ln_datetime_unit unit);

#ifdef __cplusplus
}
#endif
#endif
