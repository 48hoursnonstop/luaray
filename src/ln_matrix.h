#ifndef LUARAY_MATRIX_H
#define LUARAY_MATRIX_H
#include "ln_core.h"
/* Native axes are zero-based. Inputs are borrowed; results own their headers. */
ln_array *ln_matrix_diagonal(const ln_array *a,ln_intp offset,int axis1,int axis2,ln_error *err);
ln_array *ln_matrix_diag(const ln_array *a,ln_intp offset,int flatten,ln_error *err);
/* With out==NULL the result is owned. Otherwise the returned pointer is the
 * borrowed output, written only after a successful staged reduction. */
ln_array *ln_matrix_trace(const ln_array *a,ln_intp offset,int axis1,int axis2,
        const ln_dtype *dtype,ln_array *out,ln_error *err);
ln_array *ln_matrix_tri(ln_intp rows,ln_intp columns,ln_intp k,const ln_dtype *dtype,ln_error *err);
ln_array *ln_matrix_trilu(const ln_array *a,ln_intp k,int upper,ln_error *err);
ln_array *ln_matrix_vander(const ln_array *x,ln_intp columns,int increasing,ln_error *err);
ln_array *ln_matrix_eye(ln_intp rows,ln_intp columns,ln_intp k,const ln_dtype *dtype,int fortran,ln_error *err);
ln_array *ln_matrix_diag_indices(ln_intp n,ln_error *err);
/* Outputs are separate contiguous one-based index vectors owned by the caller. */
int ln_matrix_trilu_indices(ln_intp rows,ln_intp columns,ln_intp k,int upper,
                           ln_array **outputs,ln_error *err);
/* Values are read live in logical C order, cycling rather than broadcasting. */
int ln_matrix_fill_diagonal(ln_array *a,const ln_array *values,int wrap,ln_error *err);
#endif
