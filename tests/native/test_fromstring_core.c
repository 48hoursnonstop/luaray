#include "ln_fromstring.h"
#include <assert.h>
#include <stdint.h>
#include <string.h>

int main(void)
{
    ln_error error = {0};
    const ln_dtype *i64 = ln_dtype_by_num(LN_LONGLONG);
    /* The parser must not read past length or require an input NUL byte. */
    const char input[] = {'1', ',', '2', '3'};
    const char comma = ',';
    ln_array *result = ln_array_fromstring(input, 3, i64, -1, &comma, 1, &error);
    assert(result && ln_array_size(result) == 2);
    assert(memcmp(result->data, (int64_t[]){1,2}, sizeof(int64_t)*2) == 0);
    ln_array_free(result);
    assert(!ln_array_fromstring(input, 3, i64, 3, &comma, 1, &error));
    assert(strstr(error.message, "fewer elements"));
    result = ln_array_fromstring(input, 0, i64, -1, &comma, 1, &error);
    assert(result && ln_array_size(result) == 0 && result->strides[0] == 8);
    ln_array_free(result);
    return 0;
}
