#ifndef LUARAY_UFUNC_H
#define LUARAY_UFUNC_H

#include "ln_core.h"
#include "ln_ufunc_loops.h"
#include "ln_nditer_multi.h"

#ifdef __cplusplus
extern "C" {
#endif

#define LN_UFUNC_MAXARGS 8

typedef enum ln_ufunc_operand_kind {
    LN_UFUNC_OPERAND_ARRAY = 0,
    LN_UFUNC_WEAK_BOOL,
    LN_UFUNC_WEAK_INT,
    LN_UFUNC_WEAK_FLOAT,
    LN_UFUNC_WEAK_COMPLEX,
    LN_UFUNC_WEAK_STRING
} ln_ufunc_operand_kind;

typedef struct ln_ufunc_operand {
    ln_ufunc_operand_kind kind;
    const ln_array *array;
    int boolean;
    int64_t integer;
    double floating;
    long double real;
    long double imag;
    const char *string;
    size_t string_len;
} ln_ufunc_operand;

typedef struct ln_ufunc ln_ufunc;
typedef struct ln_ufunc_loop ln_ufunc_loop;
typedef int (*ln_ufunc_descr_resolve_fn)(const ln_ufunc *ufunc,
        const ln_ufunc_loop *method,const ln_array *const *inputs,
        const ln_dtype_descr **descrs,ln_error *err);
typedef int (*ln_ufunc_loop_data_resolve_fn)(const ln_ufunc_loop *method,
        const ln_dtype_descr *const *descrs, void **loop_data, ln_error *err);
typedef void (*ln_ufunc_loop_data_free_fn)(void *loop_data);

struct ln_ufunc_loop {
    /* ArrayMethod-like signature at the DType-class level.  Concrete
     * descriptors are resolved separately for each invocation. */
    const ln_dtype_class *classes[LN_UFUNC_MAXARGS];
    ln_strided_loop loop;
    void *data;
    ln_nditer_validate_fn validate;
    void *validate_data;
    /* ArrayMethod-style concrete descriptor resolution for parametric DTypes. */
    ln_ufunc_descr_resolve_fn resolve_descrs;
    /* NumPy get_loop receives concrete descriptors.  Parametric kernels whose
     * inner-loop context depends on itemsize/metadata can prepare per-call
     * loop data here without teaching the iterator about the DType. */
    ln_ufunc_loop_data_resolve_fn resolve_loop_data;
    ln_ufunc_loop_data_free_fn free_loop_data;
};

typedef struct ln_ufunc_resolution {
    const ln_ufunc_loop *method;
    const ln_dtype_descr *descrs[LN_UFUNC_MAXARGS];
} ln_ufunc_resolution;

typedef int (*ln_ufunc_resolve_fn)(const ln_ufunc *ufunc,
        const ln_array *const *inputs,
        const ln_ufunc_loop **resolved,
        ln_error *err);

struct ln_ufunc {
    const char *name;
    int nin;
    int nout;
    const ln_ufunc_loop *loops;
    size_t nloops;
    ln_ufunc_resolve_fn resolve;
};

/* Host-neutral ufunc registry.  Registered signatures are DType classes,
 * matching the role of NumPy ArrayMethod DTypeMeta signatures without
 * PyArray_DTypeMeta/PyObject ownership machinery.  Concrete descriptor
 * instances are resolved separately before iteration. */
const ln_ufunc *ln_ufunc_by_name(const char *name);
size_t ln_ufunc_registry_count(void);

/* Execute a ufunc.  `outputs` has ufunc->nout entries; NULL entries are
 * allocated using the resolved output descriptor and replaced in-place.
 * Non-NULL outputs are borrowed and receive same_kind-cast writeback.
 * All outputs share NumPy's broadcast shape. */
int ln_ufunc_execute(const ln_ufunc *ufunc,
        const ln_array *const *inputs,
        ln_array **outputs,
        const ln_array *where,
        ln_error *err);

/* Execute with host-language scalar operands kept weak until loop resolution.
 * At least one operand must be an ndarray for now; scalar-only calls remain a
 * separate public-API concern. */
int ln_ufunc_execute_operands(const ln_ufunc *ufunc,
        const ln_ufunc_operand *operands,
        ln_array **outputs,
        const ln_array *where,
        ln_error *err);

#ifdef __cplusplus
}
#endif
#endif
