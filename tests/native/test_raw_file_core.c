#include "ln_raw_file.h"
#include <assert.h>
#include <stdint.h>
#include <string.h>

int main(void)
{
    ln_error err = {0};
    const ln_dtype *dtype = ln_dtype_by_num(LN_INT);
    FILE *file = tmpfile();
    assert(file);
    int32_t values[] = {10,20,30};
    assert(fwrite(values, sizeof *values, 3, file) == 3);
    assert(fputc('x', file) == 'x');
    rewind(file);
    ln_array *array = ln_read_raw_file(file, dtype, -1, 4, &err);
    assert(array && ln_array_size(array) == 2 && ftell(file) == 12);
    assert(memcmp(array->data, values+1, 8) == 0);
    assert(fseek(file, 0, SEEK_END) == 0);
    assert(ln_write_raw_file(file, array, &err) == 0 && ftell(file) == 21);
    ln_array_free(array);
    assert(fseek(file, 13, SEEK_SET) == 0);
    array = ln_read_raw_file(file, dtype, 4, 0, &err);
    assert(array && ln_array_size(array) == 2 && ftell(file) == 21);
    assert(memcmp(array->data, values+1, 8) == 0);
    ln_array_free(array);
    fclose(file);
}
