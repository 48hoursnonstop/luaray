#ifndef LUARAY_DATETIME_STRINGS_H
#define LUARAY_DATETIME_STRINGS_H

#include "ln_datetime.h"
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct ln_datetimestruct {
    int64_t year;
    int month, day, hour, min, sec;
    int us, ps, as;
} ln_datetimestruct;

typedef enum ln_datetime_string_casting {
    LN_DT_CAST_SAFE = 0,
    LN_DT_CAST_SAME_KIND = 1,
    LN_DT_CAST_UNSAFE = 2,
    LN_DT_CAST_SAME_VALUE = 3
} ln_datetime_string_casting;

typedef enum ln_datetime_timezone_mode {
    LN_DT_TZ_NAIVE = 0,
    LN_DT_TZ_UTC = 1,
    LN_DT_TZ_LOCAL = 2,
    LN_DT_TZ_OFFSET = 3
} ln_datetime_timezone_mode;

/* Host-neutral ports of NumPy datetime.c/datetime_strings.c. */
int ln_datetime_parse_iso8601(const char *str,
                              const ln_dtype_descr *requested,
                              const ln_dtype_descr **out_descr,
                              int64_t *out_value,
                              int *out_had_timezone,
                              ln_error *err);
int ln_datetime_value_to_struct(int64_t value, const ln_datetime_meta *meta,
                                ln_datetimestruct *out, ln_error *err);
int ln_datetime_struct_to_value(const ln_datetimestruct *dts,
                                const ln_datetime_meta *meta,
                                int64_t *out, ln_error *err);
int ln_datetime_format_iso8601(int64_t value, const ln_datetime_meta *meta,
                               ln_datetime_unit unit, int auto_unit,
                               ln_datetime_timezone_mode timezone,
                               int timezone_offset_minutes,
                               ln_datetime_string_casting casting,
                               char *out, size_t outlen, ln_error *err);

int ln_datetime_iso8601_strlen(int local, ln_datetime_unit base);

#ifdef __cplusplus
}
#endif
#endif
