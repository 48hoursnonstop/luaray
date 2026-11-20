#include "ln_einsum.h"

#include <assert.h>
#include <stdio.h>
#include <string.h>

int main(void)
{
    ln_error err = {0};
    const ln_dtype *f64 = ln_dtype_by_num(LN_DOUBLE);
    const ln_dtype *f32 = ln_dtype_by_num(LN_FLOAT);
    const ln_intp square[2] = {2, 2};
    ln_array *a = ln_array_new(2, square, f64, 0, 0, &err);
    ln_array *b = ln_array_new(2, square, f64, 0, 0, &err);
    assert(a && b);
    const double av[] = {1, 2, 3, 4}, bv[] = {5, 6, 7, 8};
    memcpy(a->data, av, sizeof(av));
    memcpy(b->data, bv, sizeof(bv));

    ln_einsum_input matmul[] = {{a, {0, 2}}, {b, {2, 1}}};
    ln_array *matrix = ln_einsum(matmul, 2, 3, 2, NULL, 'F', LN_SAFE_CASTING, NULL, &err);
    assert(matrix && (matrix->flags & LN_ARRAY_F_CONTIGUOUS));
    const double expected[] = {19, 43, 22, 50};
    assert(memcmp(matrix->data, expected, sizeof(expected)) == 0);
    ln_array_free(matrix);

    ln_einsum_input diag[] = {{a, {0, 0}}};
    ln_array *view = ln_einsum(diag, 1, 1, 1, NULL, 'K', LN_SAFE_CASTING, NULL, &err);
    assert(view && view->strides[0] == 3 * (ln_intp)sizeof(double));
    assert(view->owner == a->owner && !(view->flags & LN_ARRAY_OWNDATA));
    ln_array_free(view);
    ln_array *narrow = ln_array_new(2, square, f32, 0, 0, &err);
    assert(narrow);
    assert(!ln_einsum(matmul, 2, 3, 2, NULL, 'K', LN_SAFE_CASTING, narrow, &err));
    ln_array_free(narrow);

    const ln_intp as[2] = {3, 0}, bs[2] = {0, 2};
    ln_array *empty_a = ln_array_new(2, as, f64, 0, 0, &err);
    ln_array *empty_b = ln_array_new(2, bs, f64, 0, 0, &err);
    assert(empty_a && empty_b);
    ln_einsum_input empty_inputs[] = {{empty_a, {0, 2}}, {empty_b, {2, 1}}};
    ln_array *zero = ln_einsum(empty_inputs, 2, 3, 2, NULL, 'C', LN_SAFE_CASTING, NULL, &err);
    const double zeros[6] = {0};
    assert(zero && ln_array_size(zero) == 6 && memcmp(zero->data, zeros, sizeof(zeros)) == 0);
    ln_array_free(zero);
    ln_array_free(empty_a);
    ln_array_free(empty_b);
    ln_array_free(a);
    ln_array_free(b);
    puts("Einstein contraction native regression passed");
    return 0;
}
