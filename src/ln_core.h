#ifndef LUARAY_CORE_H
#define LUARAY_CORE_H

#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define LN_MAXDIMS 64

/* Values intentionally track NumPy's enum NPY_TYPES for the legacy dtypes. */
typedef enum ln_dtype_num {
    LN_BOOL=0,
    LN_BYTE=1, LN_UBYTE=2,
    LN_SHORT=3, LN_USHORT=4,
    LN_INT=5, LN_UINT=6,
    LN_LONG=7, LN_ULONG=8,
    LN_LONGLONG=9, LN_ULONGLONG=10,
    LN_FLOAT=11, LN_DOUBLE=12, LN_LONGDOUBLE=13,
    LN_CFLOAT=14, LN_CDOUBLE=15, LN_CLONGDOUBLE=16,
    LN_STRING=18, LN_UNICODE=19,
    LN_DATETIME=21, LN_TIMEDELTA=22, LN_HALF=23
} ln_dtype_num;

typedef enum ln_binary_op {
    LN_OP_ADD = 0,
    LN_OP_SUBTRACT = 1,
    LN_OP_MULTIPLY = 2,
    LN_OP_TRUE_DIVIDE = 3,
    LN_OP_EQUAL = 4,
    LN_OP_NOT_EQUAL = 5,
    LN_OP_LESS = 6,
    LN_OP_LESS_EQUAL = 7,
    LN_OP_GREATER = 8,
    LN_OP_GREATER_EQUAL = 9,
    LN_OP_LOGICAL_AND = 10,
    LN_OP_LOGICAL_OR = 11,
    LN_OP_LOGICAL_XOR = 12,
    LN_OP_MAXIMUM = 13,
    LN_OP_MINIMUM = 14,
    /* Unary ufuncs reuse the same native NpyIter executor with a duplicated
     * read operand; their inner loops ignore args[1]. */
    LN_OP_NEGATIVE = 15,
    LN_OP_ABSOLUTE = 16,
    LN_OP_POSITIVE = 17,
    LN_OP_SIGN = 18,
    LN_OP_LOGICAL_NOT = 19,
    LN_OP_ISNAN = 20,
    LN_OP_ISINF = 21,
    LN_OP_ISFINITE = 22,
    LN_OP_SIGNBIT = 23,
    LN_OP_FLOOR_DIVIDE = 24,
    LN_OP_REMAINDER = 25,
    LN_OP_POWER = 26,
    LN_OP_BITWISE_AND = 27,
    LN_OP_BITWISE_OR = 28,
    LN_OP_BITWISE_XOR = 29,
    LN_OP_FMAX = 30,
    LN_OP_FMIN = 31,
    LN_OP_COPYSIGN = 32,
    LN_OP_SQRT = 33,
    LN_OP_EXP = 34,
    LN_OP_LOG = 35,
    LN_OP_SIN = 36,
    LN_OP_COS = 37,
    LN_OP_TAN = 38,
    LN_OP_SINH = 39,
    LN_OP_COSH = 40,
    LN_OP_TANH = 41,
    LN_OP_EXP2 = 42,
    LN_OP_LOG2 = 43,
    LN_OP_LOG10 = 44,
    LN_OP_EXPM1 = 45,
    LN_OP_LOG1P = 46,
    LN_OP_CBRT = 47,
    LN_OP_ARCSIN = 48,
    LN_OP_ARCCOS = 49,
    LN_OP_ARCTAN = 50,
    LN_OP_ARCSINH = 51,
    LN_OP_ARCCOSH = 52,
    LN_OP_ARCTANH = 53,
    LN_OP_ARCTAN2 = 54,
    LN_OP_HYPOT = 55
} ln_binary_op;

typedef enum ln_reduce_op {
    LN_REDUCE_SUM = 0,
    LN_REDUCE_PROD = 1,
    LN_REDUCE_MEAN = 2
} ln_reduce_op;

typedef intptr_t ln_intp;

enum {
    LN_ARRAY_C_CONTIGUOUS = 0x0001,
    LN_ARRAY_F_CONTIGUOUS = 0x0002,
    LN_ARRAY_OWNDATA      = 0x0004,
    LN_ARRAY_ALIGNED      = 0x0100,
    LN_ARRAY_WRITEABLE    = 0x0400,
    LN_ARRAY_DEFAULT      = LN_ARRAY_C_CONTIGUOUS | LN_ARRAY_OWNDATA |
                            LN_ARRAY_ALIGNED | LN_ARRAY_WRITEABLE
};

/*
 * LuaRay DType model.  NumPy 2.x separates the DType class
 * (PyArray_DTypeMeta: promotion/discovery/behavior) from a concrete
 * descriptor instance (PyArray_Descr: itemsize/alignment/metadata).
 * LuaRay keeps the same semantic split without Python type machinery.
 */
typedef struct ln_dtype_class ln_dtype_class;
typedef struct ln_dtype_descr ln_dtype_descr;
typedef struct ln_dtype_class_slots ln_dtype_class_slots;

enum {
    LN_DTYPE_CLASS_LEGACY_NUMERIC = 1u << 0,
    LN_DTYPE_CLASS_PARAMETRIC     = 1u << 1,
    LN_DTYPE_CLASS_ABSTRACT       = 1u << 2
};

struct ln_dtype_class_slots {
    const ln_dtype_descr *(*default_descr)(const ln_dtype_class *cls);
    const ln_dtype_class *(*common_dtype)(const ln_dtype_class *self,
                                          const ln_dtype_class *other);
    const ln_dtype_descr *(*common_instance)(const ln_dtype_descr *a,
                                              const ln_dtype_descr *b);
};

struct ln_dtype_class {
    const char *name;
    char kind;
    ln_dtype_num legacy_type_num;
    uint64_t flags;
    const ln_dtype_descr *singleton;
    const ln_dtype_class_slots *slots;
};

enum { LN_DTYPE_NEEDS_INIT = 8 };

struct ln_dtype_descr {
    const ln_dtype_class *cls;
    /* Legacy convenience fields retained during the numeric-core migration.
     * Future parametric descriptors may share a class while differing in
     * itemsize/metadata. */
    ln_dtype_num type_num;
    const char *name;
    char kind;
    char byteorder;
    uint64_t flags;
    size_t elsize;
    size_t alignment;
    const void *metadata;
};

/* Transitional source compatibility for numerical subsystems.  New engine
 * code should spell ln_dtype_descr explicitly. */
typedef ln_dtype_descr ln_dtype;

typedef void (*ln_buffer_release)(void *data, void *context);

typedef struct ln_buffer {
    char *ptr;
    size_t nbytes;
    size_t refs;
    int readonly;
    /* Last logical permission of the owning root; retained after its header
     * is freed so surviving views preserve base-permission decisions. */
    int root_writeable;
    ln_buffer_release release;
    void *context;
} ln_buffer;

typedef struct ln_array {
    /* Mirrors the numerical/layout portion of NumPy's PyArrayObject_fields. */
    char *data;
    int nd;
    ln_intp *dimensions;
    ln_intp *strides;
    ln_buffer *owner;
    const ln_dtype_descr *descr;
    int flags;
} ln_array;

typedef enum ln_error_kind {
    LN_ERROR_NONE=0,LN_ERROR_TYPE,LN_ERROR_VALUE,LN_ERROR_MEMORY,LN_ERROR_OVERFLOW
} ln_error_kind;
typedef struct ln_error {
    char message[512];
    /* Internal control flow (e.g. NumPy _wrapfunc TypeError retry); not a
     * complete Python exception hierarchy at the public Lua boundary. */
    ln_error_kind kind;
} ln_error;

/*
 * Host-neutral basic-index description. This mirrors the information NumPy's
 * mapping.c:get_view_from_index consumes after CPython has parsed index objects.
 * Integer values and slice starts are normalized to zero-based element offsets.
 */
typedef enum ln_index_kind {
    LN_INDEX_INTEGER = 1,
    LN_INDEX_SLICE = 2,
    LN_INDEX_ELLIPSIS = 3,
    LN_INDEX_NEWAXIS = 4,
    /* Integer ndarray used for advanced/fancy indexing. */
    LN_INDEX_FANCY = 5,
    /* 0-D boolean advanced index. Does not consume an input axis. */
    LN_INDEX_0D_BOOL = 6
} ln_index_kind;

typedef struct ln_index {
    ln_index_kind kind;
    /* INTEGER: zero-based element index. ELLIPSIS: number of covered axes. */
    ln_intp value;
    /* SLICE: normalized first element, stride multiplier, and result length. */
    ln_intp start;
    ln_intp step;
    ln_intp length;
    /* FANCY / 0D_BOOL: index array. Borrowed for the duration of the call. */
    const ln_array *array;
    /* FANCY converted from a boolean mask: original boolean axis length;
     * -1 for an ordinary integer indexing array. */
    ln_intp boolean_axis_size;
} ln_index;

const ln_dtype_descr *ln_dtype_by_name(const char *name);
const ln_dtype_descr *ln_dtype_by_num(ln_dtype_num num);
const ln_dtype_class *ln_dtype_class_by_name(const char *name);
const ln_dtype_class *ln_dtype_class_by_num(ln_dtype_num num);
const ln_dtype_class *ln_dtype_class_of(const ln_dtype_descr *descr);
const ln_dtype_descr *ln_dtype_default_descr(const ln_dtype_class *cls);
int ln_dtype_same_class(const ln_dtype_descr *a, const ln_dtype_descr *b);
const ln_dtype_class *ln_common_dtype_class(const ln_dtype_class *a,
                                             const ln_dtype_class *b);
const ln_dtype_descr *ln_common_dtype_descr(const ln_dtype_descr *a,
                                             const ln_dtype_descr *b);
/* Compatibility spelling for older numerical subsystems. */
const ln_dtype_descr *ln_promote_dtype(const ln_dtype_descr *a,
                                        const ln_dtype_descr *b);

int ln_mul_sizes_with_overflow(ln_intp *r, ln_intp a, ln_intp b);
ln_intp ln_array_size(const ln_array *a);
void ln_array_fill_strides(ln_intp *strides, const ln_intp *dims, int nd,
                           size_t itemsize, int inflag, int *objflags);
void ln_update_contiguous_flags(ln_array *a);
int ln_broadcast_strides(int ndim, const ln_intp *shape,
                         int strides_ndim, const ln_intp *strides_shape,
                         const ln_intp *strides, const char *strides_name,
                         ln_intp *out_strides, ln_error *err);
int ln_broadcast_shape(int narr, const ln_array *const *arrs,
                       int *out_nd, ln_intp *out_shape, ln_error *err);

/* External storage is borrowed; release/context transfer only on success and
 * are invoked once after the last array/view disappears. NULL release is a
 * caller-managed lifetime. Byte offsets are zero-based, unlike array indices. */
ln_array *ln_array_from_buffer(void *data,size_t nbytes,const ln_dtype *dtype,
    ln_intp count,ln_intp offset,int writeable,ln_buffer_release release,
    void *context,ln_error *err);
ln_array *ln_array_from_array_buffer(const ln_array *source,const ln_dtype *dtype,
    ln_intp count,ln_intp offset,ln_error *err);
/* Conservative physical-byte overlap, independent of storage-owner identity. */
int ln_arrays_may_overlap(const ln_array *a,const ln_array *b);
/* -1 leaves an option unchanged; 0/1 clear/set. Unsupported writeback-if-copy
 * state is not introduced by this interface. */
int ln_array_setflags(ln_array *a,int write,int align,ln_error *err);

ln_array *ln_array_new(int nd, const ln_intp *dims, const ln_dtype_descr *dtype,
                       int fortran, int zeroed, ln_error *err);
/* New independent storage using the prototype's physical K-order axes. */
ln_array *ln_array_new_keeporder(const ln_array *prototype,const ln_dtype *dtype,
                                 ln_error *err);
ln_array *ln_array_view(const ln_array *base, int nd, const ln_intp *dims,
                        const ln_intp *strides, char *data, ln_error *err);
ln_array *ln_array_index_axis0(const ln_array *base, ln_intp lua_index,
                               ln_error *err);
ln_array *ln_array_reshape_c(const ln_array *base, int nd,
                             const ln_intp *dims, ln_error *err);
ln_array *ln_array_transpose(const ln_array *base, ln_error *err);
ln_array *ln_array_basic_view(const ln_array *base, const ln_index *indices,
                              int index_num, ln_error *err);
void ln_array_free(ln_array *a);

int ln_array_get_number(const ln_array *a, const ln_intp *indices0,
                        double *out, int64_t *out_i, int *is_integer,
                        ln_error *err);
int ln_array_set_number(ln_array *a, const ln_intp *indices0,
                        double v, int64_t vi, int is_integer,
                        ln_error *err);
/* Lua-scalar analogue of NumPy PyArray_Pack for currently supported numerics. */
int ln_array_pack_number(ln_array *a, const ln_intp *indices0,
                         double v, int64_t vi, int is_integer,
                         ln_error *err);
/* Fixed-width S/U scalar access at the UTF-8 Lua boundary. */
int ln_array_pack_string(ln_array *a, const ln_intp *indices0,
                         const char *s, size_t nbytes, ln_error *err);
int ln_array_get_string(const ln_array *a, const ln_intp *indices0,
                        char **out, size_t *out_nbytes, ln_error *err);
/* Complex scalar access/packing for NumPy complex64/128/longdouble. */
int ln_array_get_complex(const ln_array *a, const ln_intp *indices0,
                         long double *real, long double *imag, ln_error *err);
int ln_array_pack_complex(ln_array *a, const ln_intp *indices0,
                          long double real, long double imag, ln_error *err);
int ln_array_assign_complex(ln_array *dst, long double real, long double imag,
                            ln_error *err);
/* Scalar assignment through an arbitrary strided view. Numeric analogue of
 * PyArray_AssignRawScalar/raw_array_assign_scalar for the supported dtypes. */
int ln_array_assign_scalar(ln_array *dst, double v, int64_t vi,
                           int is_integer, ln_error *err);
ln_array *ln_binary_add(const ln_array *a, const ln_array *b, ln_error *err);
ln_array *ln_binary_subtract(const ln_array *a, const ln_array *b, ln_error *err);
ln_array *ln_binary_multiply(const ln_array *a, const ln_array *b, ln_error *err);
ln_array *ln_binary_true_divide(const ln_array *a, const ln_array *b, ln_error *err);
/* Extended ufunc execution through the native NpyIter subset. */
ln_array *ln_binary_array_op_where(const ln_array *a, const ln_array *b,
                                   const ln_array *where, ln_binary_op op,
                                   ln_error *err);
int ln_binary_array_op_into(const ln_array *a, const ln_array *b,
                            ln_array *out, const ln_array *where,
                            ln_binary_op op, ln_error *err);
/* Shared builtin-numeric ufunc promotion used by the legacy executor and
 * the generic registry while the builtin dtype family is being migrated. */
const ln_dtype *ln_resolve_binary_dtype(const ln_dtype *a, const ln_dtype *b,
        ln_binary_op op, ln_error *err);

/* Host-neutral weak-scalar promotion helpers derived from NumPy NEP 50
 * handling.  These expose promotion semantics without any Python scalar
 * objects; callers materialize the scalar only after the loop dtype resolves. */
const ln_dtype *ln_resolve_weak_scalar_dtype(const ln_array *a,
        int scalar_is_integer, int64_t vi, ln_binary_op op, ln_error *err);
const ln_dtype *ln_resolve_weak_bool_dtype(const ln_array *a,
        ln_binary_op op, ln_error *err);
const ln_dtype *ln_resolve_weak_complex_dtype(const ln_array *a,
        ln_binary_op op, ln_error *err);

ln_array *ln_binary_scalar_op(const ln_array *a, double v, int64_t vi,
                              int scalar_is_integer, ln_binary_op op,
                              int scalar_left, ln_error *err);
ln_array *ln_binary_scalar_bool_op(const ln_array *a, int truth,
                                   ln_binary_op op, int scalar_left,
                                   ln_error *err);
ln_array *ln_binary_scalar_op_where(const ln_array *a, double v, int64_t vi,
                                    int scalar_is_integer, const ln_array *where,
                                    ln_binary_op op, int scalar_left,
                                    ln_error *err);
int ln_binary_scalar_op_into(const ln_array *a, double v, int64_t vi,
                             int scalar_is_integer, ln_array *out,
                             const ln_array *where, ln_binary_op op,
                             int scalar_left, ln_error *err);
ln_array *ln_binary_scalar_bool_op_where(const ln_array *a, int truth,
                                         const ln_array *where, ln_binary_op op,
                                         int scalar_left, ln_error *err);
int ln_binary_scalar_bool_op_into(const ln_array *a, int truth, ln_array *out,
                                  const ln_array *where, ln_binary_op op,
                                  int scalar_left, ln_error *err);
ln_array *ln_binary_scalar_complex_op_where(const ln_array *a,
        long double real, long double imag, const ln_array *where,
        ln_binary_op op, int scalar_left, ln_error *err);
int ln_binary_scalar_complex_op_into(const ln_array *a,
        long double real, long double imag, ln_array *out,
        const ln_array *where, ln_binary_op op, int scalar_left,
        ln_error *err);
ln_array *ln_binary_scalar_complex_op(const ln_array *a,
        long double real, long double imag, ln_binary_op op,
        int scalar_left, ln_error *err);
/* Compatibility wrapper used by the existing add/multiply tests. */
ln_array *ln_binary_scalar(const ln_array *a, double v, int64_t vi,
                           int scalar_is_integer, int multiply, ln_error *err);
/* Unary ufunc execution over the same NpyIter-derived executor. */
ln_array *ln_unary_array_op_where(const ln_array *a, const ln_array *where,
                                  ln_binary_op op, ln_error *err);
int ln_unary_array_op_into(const ln_array *a, ln_array *out,
                           const ln_array *where, ln_binary_op op,
                           ln_error *err);
/* Extended reduction core derived from ufunc_object.c/reduction.c.
 * axis_flags has one entry per input dimension (1 = reduce).  For a 0-D
 * input it may be NULL.  `where` must be boolean and broadcastable to `a`.
 * `initial` is meaningful for sum/prod; mean ignores it.  The *_into form
 * computes through a temporary accumulator and casts into `out`, matching
 * NumPy's COPY_IF_OVERLAP safety for reductions. */
/* initial_is_integer: 0 floating, 1 integer, 2 Boolean seed provenance. */
ln_array *ln_reduce_ex(const ln_array *a, const uint8_t *axis_flags,
                       int keepdims, const ln_dtype *dtype,
                       const ln_array *where, ln_reduce_op op,
                       int has_initial, double initial_v, int64_t initial_i,
                       int initial_is_integer, ln_error *err);
int ln_reduce_into_ex(const ln_array *a, const uint8_t *axis_flags,
                      int keepdims, const ln_dtype *dtype, ln_array *out,
                      const ln_array *where, ln_reduce_op op,
                      int has_initial, double initial_v, int64_t initial_i,
                      int initial_is_integer, ln_error *err);

/* add/multiply ufunc accumulate.  axis is zero-based and must name one
 * existing axis.  Accumulation keeps the resolved computation dtype across
 * the entire prefix and only casts each prefix value when writing `out`. */
ln_array *ln_accumulate_ex(const ln_array *a, int axis, const ln_dtype *dtype,
                           ln_reduce_op op, ln_error *err);
int ln_accumulate_into_ex(const ln_array *a, int axis, const ln_dtype *dtype,
                          ln_array *out, ln_reduce_op op, ln_error *err);

/* add/multiply ufunc reduceat.  indices are already normalized zero-based
 * element positions by the host binding. */
ln_array *ln_reduceat_ex(const ln_array *a, const ln_intp *indices,
                         ln_intp nindices, int axis, const ln_dtype *dtype,
                         ln_reduce_op op, ln_error *err);
int ln_reduceat_into_ex(const ln_array *a, const ln_intp *indices,
                        ln_intp nindices, int axis, const ln_dtype *dtype,
                        ln_array *out, ln_reduce_op op, ln_error *err);

/* Legacy single-axis wrappers retained for the existing C tests.  axis is
 * zero-based; -1 means all axes. */
ln_array *ln_reduce_add(const ln_array *a, int axis, ln_error *err);
ln_array *ln_reduce_multiply(const ln_array *a, int axis, ln_error *err);
ln_array *ln_mean_reduce(const ln_array *a, int axis, ln_error *err);
double ln_mean_all(const ln_array *a, ln_error *err);

#ifdef __cplusplus
}
#endif
#endif
