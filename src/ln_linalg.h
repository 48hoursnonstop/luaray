#ifndef LUARAY_LINALG_H
#define LUARAY_LINALG_H

#include "ln_core.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Lua-native adaptation of NumPy's numpy.linalg execution boundary.
 *
 * Public dtype behavior mirrors numpy/linalg/_linalg.py::_commonType:
 * float32/complex64 retain their result dtype but are evaluated in
 * double/complex128; integers/bool evaluate and return float64 unless a
 * complex operand promotes the result to complex128. float16, longdouble and
 * complex256 are intentionally unsupported by this linalg-lite path, matching
 * upstream numpy.linalg.
 */
ln_array *ln_linalg_solve(const ln_array *a, const ln_array *b, ln_error *err);
ln_array *ln_linalg_inv(const ln_array *a, ln_error *err);
ln_array *ln_linalg_det(const ln_array *a, ln_error *err);
int ln_linalg_slogdet(const ln_array *a, ln_array **sign, ln_array **logabsdet,
                      ln_error *err);
ln_array *ln_linalg_cholesky(const ln_array *a, int upper, ln_error *err);

typedef enum ln_qr_mode {
    LN_QR_REDUCED = 0,
    LN_QR_COMPLETE = 1,
    LN_QR_R = 2,
    LN_QR_RAW = 3,
    LN_QR_ECONOMIC = 4
} ln_qr_mode;
/* reduced/complete -> q+r, r -> r only, raw -> q(h)+tau, economic -> q only. */
int ln_linalg_qr(const ln_array *a, ln_qr_mode mode,
                 ln_array **q_or_h, ln_array **r_or_tau, ln_error *err);

ln_array *ln_linalg_eigvals(const ln_array *a, ln_error *err);
int ln_linalg_eig(const ln_array *a, ln_array **w, ln_array **v, ln_error *err);
ln_array *ln_linalg_eigvalsh(const ln_array *a, int upper, ln_error *err);
int ln_linalg_eigh(const ln_array *a, int upper, ln_array **w, ln_array **v, ln_error *err);
int ln_linalg_svd(const ln_array *a, int full_matrices, int compute_uv, int hermitian,
                  ln_array **u, ln_array **s, ln_array **vh, ln_error *err);
ln_array *ln_linalg_svdvals(const ln_array *a, ln_error *err);

/* Linear least squares, mirroring numpy.linalg.lstsq. `rank` is scalar; the
 * remaining outputs are newly allocated arrays. rcond_is_default selects the
 * NumPy 2.x default eps*max(M,N); otherwise the supplied rcond is passed to
 * GELSD verbatim (so -1 requests LAPACK machine precision). */
int ln_linalg_lstsq(const ln_array *a, const ln_array *b, double rcond,
                    int rcond_is_default, ln_array **x, ln_array **residuals,
                    ln_intp *rank, ln_array **s, ln_error *err);
ln_array *ln_linalg_pinv(const ln_array *a, double rcond,
                           const ln_array *rcond_array, int hermitian,
                           ln_error *err);
int ln_linalg_matrix_rank(const ln_array *a, int hermitian,
                          int has_tol, double tol, const ln_array *tol_array,
                          int has_rtol, double rtol, const ln_array *rtol_array,
                          ln_array **rank_array, ln_intp *scalar_rank,
                          int *is_scalar, ln_error *err);
typedef enum ln_norm_kind {
    LN_NORM_DEFAULT = 0,
    LN_NORM_FRO = 1,
    LN_NORM_NUC = 2,
    LN_NORM_POSINF = 3,
    LN_NORM_NEGINF = 4,
    LN_NORM_NUMBER = 5
} ln_norm_kind;
ln_array *ln_linalg_norm(const ln_array *a, ln_norm_kind kind, double ord,
                         const int *axes, int naxes, int axis_is_none,
                         int keepdims, ln_error *err);
ln_array *ln_linalg_cond(const ln_array *a, ln_norm_kind kind, double ord,
                         ln_error *err);

/* High-level numpy.linalg surface.  These are source-derived compositions of
 * the native ndarray/product/LAPACK primitives above, mirroring
 * numpy/linalg/_linalg.py rather than reimplementing the underlying algebra. */
ln_array *ln_linalg_matrix_power(const ln_array *a, int64_t n, ln_error *err);
ln_array *ln_linalg_tensorinv(const ln_array *a, int ind, ln_error *err);
ln_array *ln_linalg_tensorsolve(const ln_array *a, const ln_array *b,
                                const int *axes, int naxes, ln_error *err);
ln_array *ln_linalg_tensordot(const ln_array *a, const ln_array *b,
                              const int *axes_a, const int *axes_b,
                              int naxes, ln_error *err);
ln_array *ln_linalg_multi_dot(const ln_array *const *arrays, int narr,
                              ln_error *err);
ln_array *ln_linalg_outer(const ln_array *a, const ln_array *b, ln_error *err);
ln_array *ln_linalg_diagonal(const ln_array *a, ln_intp offset, ln_error *err);
ln_array *ln_linalg_trace(const ln_array *a, ln_intp offset,
                          const ln_dtype *dtype, ln_error *err);
ln_array *ln_linalg_matrix_transpose(const ln_array *a, ln_error *err);
ln_array *ln_linalg_cross(const ln_array *a, int axis_a,
                          const ln_array *b, int axis_b, int axis_out,
                          ln_error *err);
ln_array *ln_linalg_vecdot(const ln_array *a, int axis_a,
                           const ln_array *b, int axis_b, ln_error *err);
ln_array *ln_linalg_vector_norm(const ln_array *a, ln_norm_kind kind,
                                double ord, const int *axes, int naxes,
                                int axis_is_none, int keepdims,
                                ln_error *err);

#ifdef __cplusplus
}
#endif
#endif
