#ifndef LUARAY_BUSDAY_H
#define LUARAY_BUSDAY_H

#include "ln_core.h"

/* Date operands and holidays use native datetime64[D] ticks. The holiday
 * vector is sorted, unique and filtered by the supplied seven-day weekmask. */
ln_array *ln_busday_count(const ln_array *start, const ln_array *end,
                          const ln_array *weekmask, const ln_array *holidays,
                          ln_error *err);

#endif
