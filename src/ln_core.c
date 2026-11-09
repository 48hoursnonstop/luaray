#include "ln_core.h"
#include "ln_layout.h"
#include "ln_dtype_transfer.h"
#include "ln_ufunc_loops.h"
#include "ln_nditer.h"
#include "ln_half.h"
#include "ln_complex.h"
#include "ln_datetime.h"
#include "ln_string.h"

#include <assert.h>
#include <limits.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
 * Numerical/layout routines in this file are ports/adaptations of NumPy:
 *   numpy/_core/include/numpy/ndarraytypes.h
 *   numpy/_core/src/common/array_assign.c
 *   numpy/_core/src/common/templ_common.h.src
 *   numpy/_core/src/multiarray/ctors.c
 *   numpy/_core/src/multiarray/flagsobject.c
 *   numpy/_core/src/multiarray/iterators.c
 * pinned at upstream commit 286e698f1dcf601648b165f48485ceaeec9c6231.
 * CPython object allocation/errors/refcounts are replaced by native structs.
 */

/* Builtin numeric DType classes and their singleton descriptors.
 *
 * This is the Lua-native analogue of NumPy's builtin DTypeMeta objects plus
 * their singleton PyArray_Descr instances.  The class intentionally carries
 * no CPython type/refcount state; descriptor-specific size/alignment/metadata
 * live in ln_dtype_descr. */
typedef struct ln_builtin_dtype_spec {
    ln_dtype_num type_num;
    const char *name;
    char kind;
    size_t elsize;
    size_t alignment;
} ln_builtin_dtype_spec;

static const ln_builtin_dtype_spec DTYPE_SPECS[] = {
    {LN_BOOL, "bool", 'b', 1, _Alignof(uint8_t)},
    {LN_BYTE, "int8", 'i', 1, _Alignof(int8_t)},
    {LN_UBYTE, "uint8", 'u', 1, _Alignof(uint8_t)},
    {LN_SHORT, "int16", 'i', 2, _Alignof(int16_t)},
    {LN_USHORT, "uint16", 'u', 2, _Alignof(uint16_t)},
    {LN_INT, "int32", 'i', 4, _Alignof(int32_t)},
    {LN_UINT, "uint32", 'u', 4, _Alignof(uint32_t)},
#if LONG_MAX == INT64_MAX
    {LN_LONG, "int64", 'i', 8, _Alignof(int64_t)},
    {LN_ULONG, "uint64", 'u', 8, _Alignof(uint64_t)},
#else
    {LN_LONG, "long", 'i', sizeof(long), _Alignof(long)},
    {LN_ULONG, "ulong", 'u', sizeof(unsigned long), _Alignof(unsigned long)},
#endif
    {LN_LONGLONG, "longlong", 'i', sizeof(long long), _Alignof(long long)},
    {LN_ULONGLONG, "ulonglong", 'u', sizeof(unsigned long long), _Alignof(unsigned long long)},
    {LN_FLOAT, "float32", 'f', 4, _Alignof(float)},
    {LN_DOUBLE, "float64", 'f', 8, _Alignof(double)},
    {LN_LONGDOUBLE, "longdouble", 'f', sizeof(long double), _Alignof(long double)},
    {LN_CFLOAT, "complex64", 'c', sizeof(ln_cfloat), _Alignof(ln_cfloat)},
    {LN_CDOUBLE, "complex128", 'c', sizeof(ln_cdouble), _Alignof(ln_cdouble)},
    {LN_CLONGDOUBLE, "complex256", 'c', sizeof(ln_clongdouble), _Alignof(ln_clongdouble)},
    {LN_HALF, "float16", 'f', 2, _Alignof(uint16_t)}
};
static const size_t NDTYPES = sizeof(DTYPE_SPECS)/sizeof(DTYPE_SPECS[0]);
static ln_dtype_class DTYPE_CLASSES[sizeof(DTYPE_SPECS)/sizeof(DTYPE_SPECS[0])];
static ln_dtype_descr DTYPE_DESCRS[sizeof(DTYPE_SPECS)/sizeof(DTYPE_SPECS[0])];
static int dtype_registry_ready = 0;

static const ln_dtype_descr *builtin_default_descr(const ln_dtype_class *cls);
static const ln_dtype_class *builtin_common_dtype(const ln_dtype_class *self,
                                                   const ln_dtype_class *other);
static const ln_dtype_descr *builtin_common_instance(const ln_dtype_descr *a,
                                                       const ln_dtype_descr *b);
static const ln_dtype_class_slots BUILTIN_DTYPE_SLOTS = {
    builtin_default_descr, builtin_common_dtype, builtin_common_instance
};

static void
init_dtype_registry(void)
{
    if (dtype_registry_ready) return;
    for (size_t i = 0; i < NDTYPES; ++i) {
        const ln_builtin_dtype_spec *s = &DTYPE_SPECS[i];
        DTYPE_CLASSES[i].name = s->name;
        DTYPE_CLASSES[i].kind = s->kind;
        DTYPE_CLASSES[i].legacy_type_num = s->type_num;
        DTYPE_CLASSES[i].flags = LN_DTYPE_CLASS_LEGACY_NUMERIC;
        DTYPE_CLASSES[i].singleton = &DTYPE_DESCRS[i];
        DTYPE_CLASSES[i].slots = &BUILTIN_DTYPE_SLOTS;

        DTYPE_DESCRS[i].cls = &DTYPE_CLASSES[i];
        DTYPE_DESCRS[i].type_num = s->type_num;
        DTYPE_DESCRS[i].name = s->name;
        DTYPE_DESCRS[i].kind = s->kind;
        DTYPE_DESCRS[i].byteorder = '=';
        DTYPE_DESCRS[i].flags = 0;
        DTYPE_DESCRS[i].elsize = s->elsize;
        DTYPE_DESCRS[i].alignment = s->alignment;
        DTYPE_DESCRS[i].metadata = NULL;
    }
    dtype_registry_ready = 1;
}

static void seterr(ln_error *err, const char *msg) {
    if (err) {
        snprintf(err->message, sizeof(err->message), "%s", msg ? msg : "LuaRay error");
    }
}

const ln_dtype_descr *ln_dtype_by_num(ln_dtype_num num) {
    if (num == LN_STRING) return ln_string_default_dtype(0);
    if (num == LN_UNICODE) return ln_string_default_dtype(1);
    if (num == LN_DATETIME) return ln_datetime_default_dtype(0);
    if (num == LN_TIMEDELTA) return ln_datetime_default_dtype(1);
    init_dtype_registry();
    for (size_t i = 0; i < NDTYPES; ++i)
        if (DTYPE_DESCRS[i].type_num == num) return &DTYPE_DESCRS[i];
    return NULL;
}

const ln_dtype_class *ln_dtype_class_by_num(ln_dtype_num num) {
    const ln_dtype_descr *descr = ln_dtype_by_num(num);
    return descr ? descr->cls : NULL;
}

const ln_dtype_descr *ln_dtype_by_name(const char *name) {
    if (!name) return ln_dtype_by_num(LN_DOUBLE);
    { const ln_dtype_descr *dt = ln_datetime_parse_dtype(name, NULL); if (dt) return dt; }
    { const ln_dtype_descr *dt = ln_string_parse_dtype(name, NULL); if (dt) return dt; }
    init_dtype_registry();
    for (size_t i = 0; i < NDTYPES; ++i)
        if (strcmp(DTYPE_DESCRS[i].name, name) == 0) return &DTYPE_DESCRS[i];
    if (strcmp(name, "double") == 0 || strcmp(name, "f8") == 0) return ln_dtype_by_num(LN_DOUBLE);
    if (strcmp(name, "float") == 0 || strcmp(name, "f4") == 0) return ln_dtype_by_num(LN_FLOAT);
    if (strcmp(name, "half") == 0 || strcmp(name, "f2") == 0) return ln_dtype_by_num(LN_HALF);
    if (strcmp(name, "complex64") == 0 || strcmp(name, "c8") == 0) return ln_dtype_by_num(LN_CFLOAT);
    if (strcmp(name, "complex128") == 0 || strcmp(name, "complex") == 0 || strcmp(name, "c16") == 0) return ln_dtype_by_num(LN_CDOUBLE);
    if (strcmp(name, "complex256") == 0 || strcmp(name, "clongdouble") == 0 || strcmp(name, "c32") == 0) return ln_dtype_by_num(LN_CLONGDOUBLE);
    if (strcmp(name, "int64") == 0 || strcmp(name, "i8") == 0)
        return sizeof(long) == 8 ? ln_dtype_by_num(LN_LONG) : ln_dtype_by_num(LN_LONGLONG);
    if (strcmp(name, "uint64") == 0 || strcmp(name, "u8") == 0)
        return sizeof(unsigned long) == 8 ? ln_dtype_by_num(LN_ULONG) : ln_dtype_by_num(LN_ULONGLONG);
    if (strcmp(name, "i4") == 0) return ln_dtype_by_num(LN_INT);
    return NULL;
}

const ln_dtype_class *ln_dtype_class_by_name(const char *name) {
    const ln_dtype_descr *descr = ln_dtype_by_name(name);
    return descr ? descr->cls : NULL;
}

const ln_dtype_class *ln_dtype_class_of(const ln_dtype_descr *descr) {
    return descr ? descr->cls : NULL;
}

static const ln_dtype_descr *builtin_default_descr(const ln_dtype_class *cls) {
    return cls ? cls->singleton : NULL;
}

const ln_dtype_descr *ln_dtype_default_descr(const ln_dtype_class *cls) {
    if (!cls) return NULL;
    if (cls->slots && cls->slots->default_descr) return cls->slots->default_descr(cls);
    return cls->singleton;
}

int ln_dtype_same_class(const ln_dtype_descr *a, const ln_dtype_descr *b) {
    return a && b && a->cls == b->cls;
}

/*
 * Source-derived port of NumPy's legacy builtin promotion machinery.
 *
 * NumPy source of truth at the pinned commit:
 *   numpy/_core/src/multiarray/can_cast_table.h
 *   numpy/_core/src/multiarray/scalartypes.c.src:initialize_casting_tables
 *   numpy/_core/src/multiarray/dtypemeta.c:default_builtin_common_dtype
 *
 * NumPy constructs _npy_type_promotion_table from safe-cast rules, scalar
 * kinds, and the "next larger type" chain.  We execute the same algorithm
 * here for the fixed real numeric legacy DTypes currently exposed by Lua.
 * HALF/complex type numbers participate internally in the search exactly as
 * in NumPy even though this first tranche does not expose those descriptors.
 */
enum {
    LN_CFLOAT_INTERNAL = LN_CFLOAT,
    LN_CDOUBLE_INTERNAL = LN_CDOUBLE,
    LN_CLONGDOUBLE_INTERNAL = LN_CLONGDOUBLE,
    LN_HALF_INTERNAL = LN_HALF,
    LN_NTYPES_LEGACY_INTERNAL = 24
};

enum {
    LN_BOOL_SCALAR = 0,
    LN_INTPOS_SCALAR = 1,
    LN_INTNEG_SCALAR = 2,
    LN_FLOAT_SCALAR = 3,
    LN_COMPLEX_SCALAR = 4,
    LN_OBJECT_SCALAR = 5,
    LN_NSCALARKINDS = 6
};

static size_t npy_base_size_for_type(int t) {
    switch (t) {
        case LN_BYTE: case LN_UBYTE: return sizeof(int8_t);
        case LN_SHORT: case LN_USHORT: return sizeof(int16_t);
        case LN_INT: case LN_UINT: return sizeof(int);
        case LN_LONG: case LN_ULONG: return sizeof(long);
        case LN_LONGLONG: case LN_ULONGLONG: return sizeof(long long);
        case LN_HALF_INTERNAL: return 2;
        case LN_FLOAT: case LN_CFLOAT_INTERNAL: return sizeof(float);
        case LN_DOUBLE: case LN_CDOUBLE_INTERNAL: return sizeof(double);
        case LN_LONGDOUBLE: case LN_CLONGDOUBLE_INTERNAL: return sizeof(long double);
        default: return 0;
    }
}

static int npy_is_signed_int_type(int t) {
    return t == LN_BYTE || t == LN_SHORT || t == LN_INT ||
           t == LN_LONG || t == LN_LONGLONG;
}
static int npy_is_unsigned_int_type(int t) {
    return t == LN_UBYTE || t == LN_USHORT || t == LN_UINT ||
           t == LN_ULONG || t == LN_ULONGLONG;
}
static int npy_is_float_type(int t) {
    return t == LN_HALF_INTERNAL || t == LN_FLOAT || t == LN_DOUBLE ||
           t == LN_LONGDOUBLE;
}
static int npy_is_complex_type(int t) {
    return t == LN_CFLOAT_INTERNAL || t == LN_CDOUBLE_INTERNAL ||
           t == LN_CLONGDOUBLE_INTERNAL;
}

/* FITS/UFITS/IFITS are direct translations of can_cast_table.h. */
static int npy_fits(int from, int to) {
    return npy_base_size_for_type(from) <= npy_base_size_for_type(to);
}
static int npy_ufits(int from, int to) {
    return npy_base_size_for_type(from) < npy_base_size_for_type(to);
}
static int npy_ifits(int from, int to) {
    size_t fs = npy_base_size_for_type(from), ts = npy_base_size_for_type(to);
    return fs < ts || (fs == ts && fs >= sizeof(double));
}

static int npy_can_cast_safely_numeric(int from, int to) {
    if (from == to) return 1;
    if (from == LN_BOOL) {
        /* Numeric subset of NumPy's bool row. */
        return (to >= LN_BOOL && to <= LN_CLONGDOUBLE_INTERNAL) || to == LN_HALF_INTERNAL;
    }
    if (npy_is_signed_int_type(from)) {
        if (npy_is_signed_int_type(to)) return npy_fits(from, to);
        if (npy_is_unsigned_int_type(to)) return 0;
        if (npy_is_float_type(to)) return npy_ifits(from, to);
        if (npy_is_complex_type(to)) {
            int real_to = to == LN_CFLOAT_INTERNAL ? LN_FLOAT :
                          to == LN_CDOUBLE_INTERNAL ? LN_DOUBLE : LN_LONGDOUBLE;
            return npy_ifits(from, real_to);
        }
        return 0;
    }
    if (npy_is_unsigned_int_type(from)) {
        if (npy_is_signed_int_type(to)) return npy_ufits(from, to);
        if (npy_is_unsigned_int_type(to)) return npy_fits(from, to);
        if (npy_is_float_type(to)) return npy_ifits(from, to);
        if (npy_is_complex_type(to)) {
            int real_to = to == LN_CFLOAT_INTERNAL ? LN_FLOAT :
                          to == LN_CDOUBLE_INTERNAL ? LN_DOUBLE : LN_LONGDOUBLE;
            return npy_ifits(from, real_to);
        }
        return 0;
    }
    if (npy_is_float_type(from)) {
        if (npy_is_float_type(to)) return npy_fits(from, to);
        if (npy_is_complex_type(to)) {
            int real_to = to == LN_CFLOAT_INTERNAL ? LN_FLOAT :
                          to == LN_CDOUBLE_INTERNAL ? LN_DOUBLE : LN_LONGDOUBLE;
            return npy_fits(from, real_to);
        }
        return 0;
    }
    if (npy_is_complex_type(from)) {
        if (!npy_is_complex_type(to)) return 0;
        int real_from = from == LN_CFLOAT_INTERNAL ? LN_FLOAT :
                        from == LN_CDOUBLE_INTERNAL ? LN_DOUBLE : LN_LONGDOUBLE;
        int real_to = to == LN_CFLOAT_INTERNAL ? LN_FLOAT :
                      to == LN_CDOUBLE_INTERNAL ? LN_DOUBLE : LN_LONGDOUBLE;
        return npy_fits(real_from, real_to);
    }
    return 0;
}

static int npy_scalar_kind_for_type(int t) {
    if (t == LN_BOOL) return LN_BOOL_SCALAR;
    if (npy_is_unsigned_int_type(t)) return LN_INTPOS_SCALAR;
    if (npy_is_signed_int_type(t)) return LN_INTNEG_SCALAR;
    if (npy_is_float_type(t)) return LN_FLOAT_SCALAR;
    if (npy_is_complex_type(t)) return LN_COMPLEX_SCALAR;
    return LN_OBJECT_SCALAR;
}

static int npy_next_larger_type(int t) {
    switch (t) {
        case LN_BYTE: return LN_SHORT;
        case LN_UBYTE: return LN_USHORT;
        case LN_SHORT: return LN_INT;
        case LN_USHORT: return LN_UINT;
        case LN_INT: return LN_LONG;
        case LN_UINT: return LN_ULONG;
        case LN_LONG: return LN_LONGLONG;
        case LN_ULONG: return LN_ULONGLONG;
        case LN_LONGLONG: case LN_ULONGLONG: return -1;
        case LN_HALF_INTERNAL: return LN_FLOAT;
        case LN_FLOAT: return LN_DOUBLE;
        case LN_DOUBLE: return LN_LONGDOUBLE;
        case LN_LONGDOUBLE: return -1;
        case LN_CFLOAT_INTERNAL: return LN_CDOUBLE_INTERNAL;
        case LN_CDOUBLE_INTERNAL: return LN_CLONGDOUBLE_INTERNAL;
        case LN_CLONGDOUBLE_INTERNAL: return -1;
        default: return -1;
    }
}

static int npy_smallest_type_of_kind(int kind) {
    switch (kind) {
        case LN_BOOL_SCALAR: return LN_BOOL;
        case LN_INTPOS_SCALAR: return LN_UBYTE;
        case LN_INTNEG_SCALAR: return LN_BYTE;
        case LN_FLOAT_SCALAR: return LN_HALF_INTERNAL;
        case LN_COMPLEX_SCALAR: return LN_CFLOAT_INTERNAL;
        default: return -1;
    }
}

static int npy_promote_type_num(int i, int j) {
    if (i == j) return i;
    if (npy_can_cast_safely_numeric(i, j)) return j;
    if (npy_can_cast_safely_numeric(j, i)) return i;

    int iskind = npy_scalar_kind_for_type(i);
    int jskind = npy_scalar_kind_for_type(j);
    int skind, k;
    if (iskind > jskind) { skind = iskind; k = i; }
    else { skind = jskind; k = j; }

    for (;;) {
        k = npy_next_larger_type(k);
        if (k < 0) {
            ++skind;
            if (skind < LN_NSCALARKINDS) k = npy_smallest_type_of_kind(skind);
            else return -1;
            if (k < 0) return -1;
        }
        if (npy_can_cast_safely_numeric(i, k) &&
                npy_can_cast_safely_numeric(j, k)) return k;
    }
}

static const ln_dtype_class *
builtin_common_dtype(const ln_dtype_class *self, const ln_dtype_class *other)
{
    if (!self || !other) return NULL;
    int common = npy_promote_type_num(self->legacy_type_num, other->legacy_type_num);
    if (common < LN_BOOL || (common > LN_CLONGDOUBLE && common != LN_HALF)) return NULL;
    return ln_dtype_class_by_num((ln_dtype_num)common);
}

static const ln_dtype_descr *
builtin_common_instance(const ln_dtype_descr *a, const ln_dtype_descr *b)
{
    if (!a || !b || a->cls != b->cls) return NULL;
    return ln_dtype_default_descr(a->cls);
}

const ln_dtype_class *
ln_common_dtype_class(const ln_dtype_class *a, const ln_dtype_class *b)
{
    if (!a || !b) return NULL;
    if ((a->flags & LN_DTYPE_CLASS_PARAMETRIC) || (b->flags & LN_DTYPE_CLASS_PARAMETRIC)) {
        if (a->slots && a->slots->common_dtype) {
            const ln_dtype_class *common = a->slots->common_dtype(a, b);
            if (common) return common;
        }
        if (b->slots && b->slots->common_dtype) return b->slots->common_dtype(b, a);
        return NULL;
    }
    if (a->slots && a->slots->common_dtype) {
        const ln_dtype_class *common = a->slots->common_dtype(a, b);
        if (common) return common;
    }
    if (b->slots && b->slots->common_dtype) return b->slots->common_dtype(b, a);
    return NULL;
}

const ln_dtype_descr *
ln_common_dtype_descr(const ln_dtype_descr *a, const ln_dtype_descr *b)
{
    if (!a || !b) return NULL;
    const ln_dtype_class *cls = ln_common_dtype_class(a->cls, b->cls);
    if (!cls) return NULL;
    if (cls->slots && cls->slots->common_instance) {
        const ln_dtype_descr *common = cls->slots->common_instance(a, b);
        if (common) return common;
        /* A parametric DType uses common_instance to resolve metadata.
         * Failure is meaningful (for example m8[Y] with m8[D]) and must not
         * silently collapse to the class default/generic descriptor. */
        if (cls->flags & LN_DTYPE_CLASS_PARAMETRIC) return NULL;
    }
    /* Fixed-size builtin numerical cross-class promotion lands on the target
     * class singleton. */
    return ln_dtype_default_descr(cls);
}

const ln_dtype_descr *ln_promote_dtype(const ln_dtype_descr *a, const ln_dtype_descr *b) {
    return ln_common_dtype_descr(a, b);
}

/* Port of NumPy templ_common.h.src:npy_mul_sizes_with_overflow. */
int ln_mul_sizes_with_overflow(ln_intp *r, ln_intp a, ln_intp b) {
#if defined(__has_builtin)
#  if __has_builtin(__builtin_mul_overflow)
    return __builtin_mul_overflow(a, b, r);
#  endif
#elif defined(__GNUC__)
    return __builtin_mul_overflow(a, b, r);
#endif
    assert(a >= 0 && b >= 0);
    *r = (ln_intp)((uintptr_t)a * (uintptr_t)b);
    return a != 0 && b > INTPTR_MAX / a;
}

ln_intp ln_array_size(const ln_array *a) {
    if (!a) return 0;
    ln_intp n = 1;
    for (int i = 0; i < a->nd; ++i) {
        if (a->dimensions[i] == 0) return 0;
        if (ln_mul_sizes_with_overflow(&n, n, a->dimensions[i])) return -1;
    }
    return n;
}

/* Port of NumPy ctors.c:_array_fill_strides. */
void ln_array_fill_strides(ln_intp *strides, const ln_intp *dims, int nd,
                           size_t itemsize, int inflag, int *objflags) {
    int i;
    int not_cf_contig = 0;
    int nod = 0;
    for (i = 0; i < nd; i++) {
        if (dims[i] != 1) {
            if (nod) { not_cf_contig = 1; break; }
            nod = 1;
        }
    }
    if ((inflag & (LN_ARRAY_F_CONTIGUOUS|LN_ARRAY_C_CONTIGUOUS)) == LN_ARRAY_F_CONTIGUOUS) {
        for (i = 0; i < nd; i++) {
            strides[i] = (ln_intp)itemsize;
            if (dims[i]) itemsize *= (size_t)dims[i]; else not_cf_contig = 0;
        }
        if (not_cf_contig) *objflags = ((*objflags)|LN_ARRAY_F_CONTIGUOUS) & ~LN_ARRAY_C_CONTIGUOUS;
        else *objflags |= LN_ARRAY_F_CONTIGUOUS|LN_ARRAY_C_CONTIGUOUS;
    } else {
        for (i = nd - 1; i >= 0; i--) {
            strides[i] = (ln_intp)itemsize;
            if (dims[i]) itemsize *= (size_t)dims[i]; else not_cf_contig = 0;
        }
        if (not_cf_contig) *objflags = ((*objflags)|LN_ARRAY_C_CONTIGUOUS) & ~LN_ARRAY_F_CONTIGUOUS;
        else *objflags |= LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS;
    }
}

/* Port of NumPy flagsobject.c:_UpdateContiguousFlags. */
void ln_update_contiguous_flags(ln_array *a) {
    ln_intp sd = (ln_intp)a->descr->elsize;
    int is_c = 1;
    for (int i = a->nd - 1; i >= 0; --i) {
        ln_intp dim = a->dimensions[i];
        if (dim == 0) {
            a->flags |= LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS;
            return;
        }
        if (dim != 1) {
            if (a->strides[i] != sd) is_c = 0;
            sd *= dim;
        }
    }
    if (is_c) a->flags |= LN_ARRAY_C_CONTIGUOUS; else a->flags &= ~LN_ARRAY_C_CONTIGUOUS;
    sd = (ln_intp)a->descr->elsize;
    for (int i = 0; i < a->nd; ++i) {
        ln_intp dim = a->dimensions[i];
        if (dim != 1) {
            if (a->strides[i] != sd) { a->flags &= ~LN_ARRAY_F_CONTIGUOUS; return; }
            sd *= dim;
        }
    }
    a->flags |= LN_ARRAY_F_CONTIGUOUS;
}

static void shape_string(int nd, const ln_intp *shape, char *buf, size_t cap) {
    if (!cap) return;
    /* Individual dimension formatting always fits in a local scratch buffer;
     * only in-bounds bytes are appended to the bounded error-message buffer. */
    size_t p = 0;
    buf[0] = '\0';
    const char *open = "(";
    if (cap > 1) { buf[p++] = *open; buf[p] = '\0'; }
    for (int i = 0; i < nd; i++) {
        char item[64];
        int n = snprintf(item, sizeof(item), "%s%lld%s", i ? ", " : "",
                         (long long)shape[i], nd == 1 ? "," : "");
        if (n < 0) return;
        size_t len = (size_t)n < sizeof(item) ? (size_t)n : sizeof(item) - 1;
        size_t avail = cap - 1 - p;
        size_t copy = len < avail ? len : avail;
        if (copy) memcpy(buf + p, item, copy);
        p += copy;
        buf[p] = '\0';
    }
    if (p < cap - 1) { buf[p++] = ')'; buf[p] = '\0'; }
}

/* Direct numerical port of NumPy common/array_assign.c:broadcast_strides. */
int ln_broadcast_strides(int ndim, const ln_intp *shape,
                         int strides_ndim, const ln_intp *strides_shape,
                         const ln_intp *strides, const char *strides_name,
                         ln_intp *out_strides, ln_error *err) {
    int idim, idim_start = ndim - strides_ndim;
    if (idim_start < 0) goto broadcast_error;
    for (idim = ndim - 1; idim >= idim_start; --idim) {
        ln_intp v = strides_shape[idim - idim_start];
        if (v == 1) out_strides[idim] = 0;
        else if (v != shape[idim]) goto broadcast_error;
        else out_strides[idim] = strides[idim - idim_start];
    }
    for (idim = 0; idim < idim_start; ++idim) out_strides[idim] = 0;
    return 0;
broadcast_error: {
        char s1[128], s2[128], msg[384];
        shape_string(strides_ndim, strides_shape, s1, sizeof(s1));
        shape_string(ndim, shape, s2, sizeof(s2));
        snprintf(msg,sizeof(msg),"could not broadcast %s from shape %s into shape %s",strides_name?strides_name:"input",s1,s2);
        seterr(err,msg);
        return -1;
    }
}

/* Port of NumPy iterators.c:PyArray_Broadcast shape discovery. */
int ln_broadcast_shape(int narr, const ln_array *const *arrs,
                       int *out_nd, ln_intp *out_shape, ln_error *err) {
    int nd = 0, src_iter = -1;
    if (narr < 0 || narr > 64) { seterr(err,"Need at least 0 and at most 64 array objects."); return -1; }
    for (int i=0;i<narr;i++) if (arrs[i]->nd > nd) nd = arrs[i]->nd;
    for (int i=0;i<nd;i++) {
        out_shape[i] = 1;
        for (int j=0;j<narr;j++) {
            int k = i + arrs[j]->nd - nd;
            if (k >= 0) {
                ln_intp tmp = arrs[j]->dimensions[k];
                if (tmp == 1) continue;
                if (out_shape[i] == 1) { out_shape[i] = tmp; src_iter = j; }
                else if (out_shape[i] != tmp) {
                    char s1[128],s2[128],msg[512];
                    shape_string(arrs[src_iter]->nd,arrs[src_iter]->dimensions,s1,sizeof(s1));
                    shape_string(arrs[j]->nd,arrs[j]->dimensions,s2,sizeof(s2));
                    snprintf(msg,sizeof(msg),"shape mismatch: objects cannot be broadcast to a single shape.  Mismatch is between arg %d with shape %s and arg %d with shape %s.",src_iter,s1,j,s2);
                    seterr(err,msg); return -1;
                }
            }
        }
    }
    ln_intp n=1;
    for (int i=0;i<nd;i++) if (ln_mul_sizes_with_overflow(&n,n,out_shape[i])) { seterr(err,"broadcast dimensions too large."); return -1; }
    *out_nd=nd; return 0;
}

static ln_buffer *buffer_new(size_t nbytes, int zeroed) {
    ln_buffer *b = (ln_buffer *)calloc(1,sizeof(*b));
    if (!b) return NULL;
    size_t alloc = nbytes ? nbytes : 1;
    b->ptr = zeroed ? (char *)calloc(1,alloc) : (char *)malloc(alloc);
    if (!b->ptr) { free(b); return NULL; }
    b->nbytes = alloc; b->refs = 1; return b;
}
static void buffer_incref(ln_buffer *b){ if(b) b->refs++; }
static void buffer_decref(ln_buffer *b){ if(b && --b->refs==0){ free(b->ptr); free(b);} }

ln_array *ln_array_new(int nd, const ln_intp *dims, const ln_dtype_descr *dtype,
                       int fortran, int zeroed, ln_error *err) {
    if (!dtype) { seterr(err,"invalid dtype"); return NULL; }
    if (nd < 0 || nd > LN_MAXDIMS) { seterr(err,"maximum supported dimension for an ndarray is 64"); return NULL; }
    ln_array *a=(ln_array*)calloc(1,sizeof(*a)); if(!a){seterr(err,"out of memory");return NULL;}
    a->nd=nd; a->descr=dtype; a->flags=LN_ARRAY_DEFAULT;
    if (nd>0) {
        a->dimensions=(ln_intp*)malloc((size_t)2*nd*sizeof(ln_intp));
        if(!a->dimensions){free(a);seterr(err,"out of memory");return NULL;}
        a->strides=a->dimensions+nd;
    }
    ln_intp nbytes=(ln_intp)dtype->elsize; int is_zero=0;
    for(int i=0;i<nd;i++) {
        a->dimensions[i]=dims[i];
        if(dims[i]==0){is_zero=1;continue;}
        if(dims[i]<0){ln_array_free(a);seterr(err,"negative dimensions are not allowed");return NULL;}
        if(ln_mul_sizes_with_overflow(&nbytes,nbytes,dims[i])){ln_array_free(a);seterr(err,"array is too big; `arr.size * arr.dtype.itemsize` is larger than the maximum possible size.");return NULL;}
    }
    if(is_zero)nbytes=0;
    if(nd>0) ln_array_fill_strides(a->strides,a->dimensions,nd,dtype->elsize,fortran?LN_ARRAY_F_CONTIGUOUS:LN_ARRAY_C_CONTIGUOUS,&a->flags);
    else a->flags|=LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS;
    a->owner=buffer_new((size_t)nbytes,zeroed); if(!a->owner){ln_array_free(a);seterr(err,"out of memory");return NULL;}
    a->data=a->owner->ptr;
    if(nbytes==0) for(int i=0;i<nd;i++) a->strides[i]=0; /* matches NumPy ctor */
    return a;
}

ln_array *ln_array_view(const ln_array *base, int nd, const ln_intp *dims,
                        const ln_intp *strides, char *data, ln_error *err) {
    if(!base || nd<0 || nd>LN_MAXDIMS){seterr(err,"invalid view");return NULL;}
    ln_array *v=(ln_array*)calloc(1,sizeof(*v)); if(!v){seterr(err,"out of memory");return NULL;}
    v->nd=nd; v->descr=base->descr; v->owner=base->owner; buffer_incref(v->owner); v->data=data;
    v->flags=(base->flags & (LN_ARRAY_ALIGNED|LN_ARRAY_WRITEABLE));
    if(nd>0){v->dimensions=(ln_intp*)malloc((size_t)2*nd*sizeof(ln_intp));if(!v->dimensions){ln_array_free(v);seterr(err,"out of memory");return NULL;}v->strides=v->dimensions+nd;memcpy(v->dimensions,dims,(size_t)nd*sizeof(ln_intp));memcpy(v->strides,strides,(size_t)nd*sizeof(ln_intp));}
    ln_update_contiguous_flags(v); return v;
}

ln_array *ln_array_index_axis0(const ln_array *base, ln_intp lua_index, ln_error *err) {
    if(!base || base->nd==0){seterr(err,"too many indices for array: array is 0-dimensional");return NULL;}
    ln_intp n=base->dimensions[0]; ln_intp idx;
    if(lua_index>0) idx=lua_index-1; else if(lua_index<0) idx=n+lua_index; else {seterr(err,"index 0 is invalid in Lua's 1-based indexing model");return NULL;}
    if(idx<0||idx>=n){seterr(err,"index out of bounds");return NULL;}
    if(base->nd==1){seterr(err,"scalar-index");return NULL;}
    return ln_array_view(base,base->nd-1,base->dimensions+1,base->strides+1,base->data+idx*base->strides[0],err);
}

static void advance_index(int nd,const ln_intp*shape,ln_intp*idx);

ln_array *ln_array_reshape_c(const ln_array *base,int nd,const ln_intp *dims,ln_error *err)
{return ln_layout_reshape(base,nd,dims,'C',-1,err);}

ln_array *ln_array_transpose(const ln_array *base, ln_error *err) {
    ln_intp dims[LN_MAXDIMS],strides[LN_MAXDIMS];
    for(int i=0;i<base->nd;i++){dims[i]=base->dimensions[base->nd-1-i];strides[i]=base->strides[base->nd-1-i];}
    return ln_array_view(base,base->nd,dims,strides,base->data,err);
}

/*
 * Port/adaptation of numpy/_core/src/multiarray/mapping.c:
 * get_view_from_index().  NumPy's function receives npy_index_info entries
 * after CPython-specific parsing.  LuaRay performs host parsing in the Lua
 * binding and passes the same numerical information here: integer axes move
 * the data pointer, slices scale strides and shape, ellipsis copies axes, and
 * newaxis inserts a length-one zero-stride dimension.
 */
ln_array *
ln_array_basic_view(const ln_array *base, const ln_index *indices,
                    int index_num, ln_error *err)
{
    if (!base || index_num < 0 || index_num > LN_MAXDIMS * 2) {
        seterr(err, "invalid basic index");
        return NULL;
    }

    ln_intp new_strides[LN_MAXDIMS];
    ln_intp new_shape[LN_MAXDIMS];
    int new_dim = 0;
    int orig_dim = 0;
    char *data_ptr = base->data;

    for (int i = 0; i < index_num; ++i) {
        const ln_index *ix = &indices[i];
        switch (ix->kind) {
            case LN_INDEX_INTEGER:
                if (orig_dim >= base->nd) {
                    seterr(err, "too many indices for array");
                    return NULL;
                }
                if (ix->value < 0 || ix->value >= base->dimensions[orig_dim]) {
                    seterr(err, "index out of bounds");
                    return NULL;
                }
                data_ptr += base->strides[orig_dim] * ix->value;
                orig_dim += 1;
                break;

            case LN_INDEX_ELLIPSIS:
                if (ix->value < 0 || orig_dim + ix->value > base->nd) {
                    seterr(err, "invalid ellipsis expansion");
                    return NULL;
                }
                for (ln_intp j = 0; j < ix->value; ++j) {
                    if (new_dim >= LN_MAXDIMS) {
                        seterr(err, "number of dimensions must be within [0, 64]");
                        return NULL;
                    }
                    new_strides[new_dim] = base->strides[orig_dim];
                    new_shape[new_dim] = base->dimensions[orig_dim];
                    new_dim += 1;
                    orig_dim += 1;
                }
                break;

            case LN_INDEX_SLICE:
                if (orig_dim >= base->nd) {
                    seterr(err, "too many indices for array");
                    return NULL;
                }
                if (ix->step == 0 || ix->length < 0) {
                    seterr(err, "invalid normalized slice");
                    return NULL;
                }
                if (new_dim >= LN_MAXDIMS) {
                    seterr(err, "number of dimensions must be within [0, 64]");
                    return NULL;
                }
                if (ix->length == 0) {
                    /* NumPy normalizes empty basic slices to start=0, step=1. */
                    new_shape[new_dim] = 0;
                    new_strides[new_dim] = base->strides[orig_dim];
                }
                else {
                    ln_intp last = ix->start + (ix->length - 1) * ix->step;
                    if (ix->start < 0 || ix->start >= base->dimensions[orig_dim] ||
                            last < 0 || last >= base->dimensions[orig_dim]) {
                        seterr(err, "normalized slice is out of bounds");
                        return NULL;
                    }
                    data_ptr += base->strides[orig_dim] * ix->start;
                    new_shape[new_dim] = ix->length;
                    new_strides[new_dim] = base->strides[orig_dim] * ix->step;
                }
                new_dim += 1;
                orig_dim += 1;
                break;

            case LN_INDEX_NEWAXIS:
                if (new_dim >= LN_MAXDIMS) {
                    seterr(err, "number of dimensions must be within [0, 64]");
                    return NULL;
                }
                new_strides[new_dim] = 0;
                new_shape[new_dim] = 1;
                new_dim += 1;
                break;

            default:
                seterr(err, "unsupported basic index kind");
                return NULL;
        }
    }

    if (orig_dim != base->nd) {
        seterr(err, "basic index did not consume all array dimensions");
        return NULL;
    }
    return ln_array_view(base, new_dim, new_shape, new_strides, data_ptr, err);
}

void ln_array_free(ln_array *a){if(!a)return;buffer_decref(a->owner);free(a->dimensions);free(a);}

static void advance_index(int nd,const ln_intp*shape,ln_intp*idx);

static char *ptr_at(const ln_array *a, const ln_intp *idx, ln_error *err){
    char *p=a->data; for(int i=0;i<a->nd;i++){if(idx[i]<0||idx[i]>=a->dimensions[i]){seterr(err,"index out of bounds");return NULL;}p+=idx[i]*a->strides[i];}return p;
}

static double read_double(const char *p,const ln_dtype *d){
    switch(d->type_num){case LN_BOOL:return *(const uint8_t*)p!=0;case LN_BYTE:return *(const int8_t*)p;case LN_UBYTE:return *(const uint8_t*)p;case LN_SHORT:return *(const int16_t*)p;case LN_USHORT:return *(const uint16_t*)p;case LN_INT:return *(const int32_t*)p;case LN_UINT:return *(const uint32_t*)p;case LN_LONG:return (double)*(const long*)p;case LN_ULONG:return (double)*(const unsigned long*)p;case LN_LONGLONG:return (double)*(const long long*)p;case LN_ULONGLONG:return (double)*(const unsigned long long*)p;case LN_FLOAT:return *(const float*)p;case LN_DOUBLE:return *(const double*)p;case LN_LONGDOUBLE:return (double)*(const long double*)p;case LN_HALF:{uint16_t h;memcpy(&h,p,2);return ln_half_to_double(h);}default:return NAN;}}
static int64_t read_i64(const char *p,const ln_dtype *d){
    switch(d->type_num){case LN_BOOL:return *(const uint8_t*)p!=0;case LN_BYTE:return *(const int8_t*)p;case LN_UBYTE:return *(const uint8_t*)p;case LN_SHORT:return *(const int16_t*)p;case LN_USHORT:return *(const uint16_t*)p;case LN_INT:return *(const int32_t*)p;case LN_UINT:return *(const uint32_t*)p;case LN_LONG:return *(const long*)p;case LN_ULONG:return (int64_t)*(const unsigned long*)p;case LN_LONGLONG:return *(const long long*)p;case LN_ULONGLONG:return (int64_t)*(const unsigned long long*)p;case LN_DATETIME:case LN_TIMEDELTA:return *(const int64_t*)p;default:return (int64_t)read_double(p,d);}}
static uint64_t read_u64(const char *p,const ln_dtype *d){
    switch(d->type_num){case LN_BOOL:return *(const uint8_t*)p!=0;case LN_UBYTE:return *(const uint8_t*)p;case LN_USHORT:return *(const uint16_t*)p;case LN_UINT:return *(const uint32_t*)p;case LN_ULONG:return (uint64_t)*(const unsigned long*)p;case LN_ULONGLONG:return (uint64_t)*(const unsigned long long*)p;default:return (uint64_t)read_i64(p,d);}}
static int integer_scalar_fits_dtype(int64_t v,const ln_dtype *d){
    switch(d->type_num){
        case LN_BYTE:return v>=INT8_MIN&&v<=INT8_MAX;
        case LN_UBYTE:return v>=0&&v<=UINT8_MAX;
        case LN_SHORT:return v>=INT16_MIN&&v<=INT16_MAX;
        case LN_USHORT:return v>=0&&v<=UINT16_MAX;
        case LN_INT:return v>=INT32_MIN&&v<=INT32_MAX;
        case LN_UINT:return v>=0&&(uint64_t)v<=UINT32_MAX;
        case LN_LONG:
            if(sizeof(long)==8)return 1;
            return v>=LONG_MIN&&v<=LONG_MAX;
        case LN_ULONG:
            return v>=0 && (sizeof(unsigned long)==8 || (uint64_t)v<=ULONG_MAX);
        case LN_LONGLONG:return 1;
        case LN_ULONGLONG:return v>=0;
        default:return 0;
    }
}
static void write_number(char *p,const ln_dtype *d,double v,int64_t vi,int is_integer){
    /* Do not use `(is_integer ? vi : v)` for integer destinations: C's
     * conditional operator would convert `vi` to double first and lose exact
     * Lua integers above 2**53.  NumPy's PyArray_Pack integer path keeps the
     * PyLong value exact until the concrete integer setitem cast. */
    switch(d->type_num){
        case LN_BOOL:      *(uint8_t*)p=(uint8_t)(is_integer ? (vi!=0) : (v!=0)); break;
        case LN_BYTE:      *(int8_t*)p=is_integer ? (int8_t)vi : (int8_t)v; break;
        case LN_UBYTE:     *(uint8_t*)p=is_integer ? (uint8_t)vi : (uint8_t)v; break;
        case LN_SHORT:     *(int16_t*)p=is_integer ? (int16_t)vi : (int16_t)v; break;
        case LN_USHORT:    *(uint16_t*)p=is_integer ? (uint16_t)vi : (uint16_t)v; break;
        case LN_INT:       *(int32_t*)p=is_integer ? (int32_t)vi : (int32_t)v; break;
        case LN_UINT:      *(uint32_t*)p=is_integer ? (uint32_t)vi : (uint32_t)v; break;
        case LN_LONG:      *(long*)p=is_integer ? (long)vi : (long)v; break;
        case LN_ULONG:     *(unsigned long*)p=is_integer ? (unsigned long)(uint64_t)vi : (unsigned long)v; break;
        case LN_LONGLONG:  *(long long*)p=is_integer ? (long long)vi : (long long)v; break;
        case LN_ULONGLONG: *(unsigned long long*)p=is_integer ? (unsigned long long)(uint64_t)vi : (unsigned long long)v; break;
        case LN_FLOAT:     *(float*)p=(float)(is_integer?(double)vi:v); break;
        case LN_DOUBLE:    *(double*)p=(is_integer?(double)vi:v); break;
        case LN_LONGDOUBLE:*(long double*)p=is_integer?(long double)vi:(long double)v; break;
        case LN_CFLOAT:{ln_cfloat z={(float)(is_integer?(double)vi:v),0.0f};memcpy(p,&z,sizeof(z));break;}
        case LN_CDOUBLE:{ln_cdouble z={(is_integer?(double)vi:v),0.0};memcpy(p,&z,sizeof(z));break;}
        case LN_CLONGDOUBLE:{ln_clongdouble z={is_integer?(long double)vi:(long double)v,0.0L};memcpy(p,&z,sizeof(z));break;}
        case LN_HALF:{uint16_t h=ln_double_to_half(is_integer?(double)vi:v);memcpy(p,&h,2);break;}
        case LN_DATETIME: case LN_TIMEDELTA: *(int64_t*)p=is_integer?vi:(int64_t)v; break;
        case LN_STRING: case LN_UNICODE: break; /* rejected by public numeric setter */
    }
}

int ln_array_get_number(const ln_array *a,const ln_intp *indices0,double *out,int64_t *out_i,int *is_integer,ln_error *err){if(a&&ln_string_is_dtype(a->descr)){seterr(err,"string scalar requires string accessor");return -1;}char*p=ptr_at(a,indices0,err);if(!p)return-1;if(a->descr->kind=='c'){seterr(err,"complex scalar requires complex accessor");return -1;}if(a->descr->kind=='f'){*is_integer=0;*out=read_double(p,a->descr);return 0;}if(a->descr->kind=='u'){uint64_t u=read_u64(p,a->descr);if(u>(uint64_t)INT64_MAX){/* Lua 5.4 has signed 64-bit integers only. Preserve sign/magnitude by crossing the host boundary as a Lua number until native NumPy-like scalar userdata lands. */*is_integer=0;*out=(double)u;return 0;}}*is_integer=1;*out_i=read_i64(p,a->descr);return 0;}
int ln_array_set_number(ln_array *a,const ln_intp *indices0,double v,int64_t vi,int is_integer,ln_error *err){if(!a){seterr(err,"array is null");return -1;}if(ln_string_is_dtype(a->descr)){seterr(err,"cannot assign numeric scalar to string ndarray without an explicit string cast");return -1;}if(!(a->flags&LN_ARRAY_WRITEABLE)){seterr(err,"assignment destination is read-only");return-1;}char*p=ptr_at(a,indices0,err);if(!p)return-1;write_number(p,a->descr,v,vi,is_integer);return 0;}


int ln_array_pack_string(ln_array *a,const ln_intp *indices0,const char *s,size_t nbytes,ln_error *err){
    if(!a||!ln_string_is_dtype(a->descr)){seterr(err,"destination dtype is not a string dtype");return -1;}
    if(!(a->flags&LN_ARRAY_WRITEABLE)){seterr(err,"assignment destination is read-only");return -1;}
    char *p=ptr_at(a,indices0,err);if(!p)return -1;
    return ln_string_pack_utf8(a->descr,p,s,nbytes,err);
}

int ln_array_get_string(const ln_array *a,const ln_intp *indices0,char **out,size_t *out_nbytes,ln_error *err){
    if(!a||!ln_string_is_dtype(a->descr)){seterr(err,"source dtype is not a string dtype");return -1;}
    char *p=ptr_at(a,indices0,err);if(!p)return -1;
    return ln_string_unpack_utf8(a->descr,p,out,out_nbytes,err);
}

int ln_array_get_complex(const ln_array *a,const ln_intp *indices0,long double *real,long double *imag,ln_error *err){
    char *p=ptr_at(a,indices0,err); if(!p)return -1;
    if(a->descr->kind!='c'){seterr(err,"array dtype is not complex");return -1;}
    switch(a->descr->type_num){
        case LN_CFLOAT:{ln_cfloat z;memcpy(&z,p,sizeof(z));*real=z.real;*imag=z.imag;return 0;}
        case LN_CDOUBLE:{ln_cdouble z;memcpy(&z,p,sizeof(z));*real=z.real;*imag=z.imag;return 0;}
        case LN_CLONGDOUBLE:{ln_clongdouble z;memcpy(&z,p,sizeof(z));*real=z.real;*imag=z.imag;return 0;}
        default:seterr(err,"unsupported complex dtype");return -1;
    }
}

int ln_array_pack_complex(ln_array *a,const ln_intp *indices0,long double real,long double imag,ln_error *err){
    if(!(a->flags&LN_ARRAY_WRITEABLE)){seterr(err,"assignment destination is read-only");return -1;}
    if(a->descr->kind!='c'){seterr(err,"cannot convert complex scalar to non-complex dtype");return -1;}
    char *p=ptr_at(a,indices0,err); if(!p)return -1;
    switch(a->descr->type_num){
        case LN_CFLOAT:{ln_cfloat z={(float)real,(float)imag};memcpy(p,&z,sizeof(z));return 0;}
        case LN_CDOUBLE:{ln_cdouble z={(double)real,(double)imag};memcpy(p,&z,sizeof(z));return 0;}
        case LN_CLONGDOUBLE:{ln_clongdouble z={real,imag};memcpy(p,&z,sizeof(z));return 0;}
        default:seterr(err,"unsupported complex dtype");return -1;
    }
}

int ln_array_assign_complex(ln_array *dst,long double real,long double imag,ln_error *err){
    if(!dst){seterr(err,"invalid assignment destination");return -1;}
    if(!(dst->flags&LN_ARRAY_WRITEABLE)){seterr(err,"assignment destination is read-only");return -1;}
    unsigned char scalar[32]={0};
    if(dst->descr->elsize>sizeof(scalar)){seterr(err,"complex dtype too large for scalar assignment");return -1;}
    ln_array tmp;memset(&tmp,0,sizeof(tmp));tmp.data=(char*)scalar;tmp.nd=0;tmp.descr=dst->descr;
    tmp.flags=LN_ARRAY_WRITEABLE|LN_ARRAY_ALIGNED|LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS;
    if(ln_array_pack_complex(&tmp,NULL,real,imag,err)<0)return -1;
    ln_intp total=ln_array_size(dst);if(total<0){seterr(err,"array is too big");return -1;}if(total==0)return 0;
    if(dst->nd==0){memcpy(dst->data,scalar,dst->descr->elsize);return 0;}
    ln_intp idx[LN_MAXDIMS]={0};
    for(ln_intp n=0;n<total;++n){char*p=dst->data;for(int d=0;d<dst->nd;++d)p+=idx[d]*dst->strides[d];memcpy(p,scalar,dst->descr->elsize);advance_index(dst->nd,dst->dimensions,idx);}return 0;
}

static int floating_scalar_fits_integer_dtype(long double v,const ln_dtype *d){
    switch(d->type_num){
        case LN_BYTE:return v>=INT8_MIN&&v<=INT8_MAX;
        case LN_UBYTE:return v>=0&&v<=UINT8_MAX;
        case LN_SHORT:return v>=INT16_MIN&&v<=INT16_MAX;
        case LN_USHORT:return v>=0&&v<=UINT16_MAX;
        case LN_INT:return v>=INT32_MIN&&v<=INT32_MAX;
        case LN_UINT:return v>=0&&v<=UINT32_MAX;
        case LN_LONG:return v>=(long double)LONG_MIN&&v<=(long double)LONG_MAX;
        case LN_ULONG:return v>=0&&v<=(long double)ULONG_MAX;
        case LN_LONGLONG:return v>=(long double)LLONG_MIN&&v<=(long double)LLONG_MAX;
        case LN_ULONGLONG:return v>=0&&v<=(long double)ULLONG_MAX;
        default:return 0;
    }
}

/*
 * Numeric subset of array_coercion.c:PyArray_Pack plus the strict integer
 * checks in arraytypes.c.src:*_safe_pyint_setitem.  Python object discovery is
 * replaced by Lua integer/number classification, but concrete integer dtypes
 * retain NumPy's out-of-range errors rather than silently wrapping.
 */
int ln_array_pack_number(ln_array *a,const ln_intp *indices0,double v,int64_t vi,int is_integer,ln_error *err){
    if(!(a->flags&LN_ARRAY_WRITEABLE)){seterr(err,"assignment destination is read-only");return-1;}
    char *p=ptr_at(a,indices0,err); if(!p)return-1;
    const ln_dtype *d=a->descr;
    if(d->type_num==LN_BOOL || d->kind=='f' || d->kind=='c' || d->kind=='M' || d->kind=='m'){
        if ((d->kind=='M'||d->kind=='m') && !is_integer) { seterr(err,"datetime/timedelta numeric construction requires an integer count"); return -1; }
        /* Scalar setitem requires a specified datetime unit; numeric array
         * casts preserve raw ticks even with a generic destination descriptor. */
        if(d->type_num==LN_DATETIME&&ln_datetime_metadata(d)->base==LN_FR_GENERIC) {
            seterr(err,"Cannot create a NumPy datetime other than NaT with generic units");return -1;
        }
        write_number(p,d,v,vi,is_integer); return 0;
    }
    if(is_integer){
        if(!integer_scalar_fits_dtype(vi,d)){
            char msg[192];
            snprintf(msg,sizeof(msg),"Lua integer %lld out of bounds for %s",(long long)vi,d->name);
            seterr(err,msg); return -1;
        }
        write_number(p,d,v,vi,1); return 0;
    }
    if(isnan(v)){seterr(err,"cannot convert float NaN to integer");return-1;}
    if(!isfinite(v)){seterr(err,"cannot convert float infinity to integer");return-1;}
    long double tv=truncl((long double)v);
    if(!floating_scalar_fits_integer_dtype(tv,d)){
        char msg[192];
        snprintf(msg,sizeof(msg),"Lua number %.17g out of bounds for %s",v,d->name);
        seterr(err,msg); return -1;
    }
    /* write_number performs C's truncation toward zero, matching PyLong conversion. */
    write_number(p,d,v,0,0); return 0;
}

/*
 * Numeric port/adaptation of array_assign_scalar.c:
 * PyArray_AssignRawScalar/raw_array_assign_scalar.
 *
 * NumPy first casts/packs the scalar into the destination dtype and then
 * repeats that already-cast element through a raw strided iterator.  Doing
 * the conversion once is observably important (range errors happen before
 * any destination element is modified) and also keeps the hot assignment
 * loop native and byte-oriented.
 */
int
ln_array_assign_scalar(ln_array *dst, double v, int64_t vi,
                       int is_integer, ln_error *err)
{
    if (!dst) {
        seterr(err, "invalid assignment destination");
        return -1;
    }
    if (!(dst->flags & LN_ARRAY_WRITEABLE)) {
        seterr(err, "assignment destination is read-only");
        return -1;
    }

    /* Supported numeric item sizes are all <= long double on this build. */
    union {
        long double ld;
        unsigned long long ull;
        unsigned char bytes[sizeof(long double) > sizeof(unsigned long long)
                            ? sizeof(long double) : sizeof(unsigned long long)];
    } scalar;
    memset(&scalar, 0, sizeof(scalar));

    ln_array scalar_array;
    memset(&scalar_array, 0, sizeof(scalar_array));
    scalar_array.data = (char *)scalar.bytes;
    scalar_array.nd = 0;
    scalar_array.descr = dst->descr;
    scalar_array.flags = LN_ARRAY_WRITEABLE | LN_ARRAY_ALIGNED |
                         LN_ARRAY_C_CONTIGUOUS | LN_ARRAY_F_CONTIGUOUS;

    /* Pack before touching dst, matching NumPy's fail-before-iteration path. */
    if (ln_array_pack_number(&scalar_array, NULL, v, vi, is_integer, err) < 0) {
        return -1;
    }

    ln_intp total = ln_array_size(dst);
    if (total < 0) {
        seterr(err, "array is too big");
        return -1;
    }
    if (total == 0) {
        return 0;
    }

    size_t itemsize = dst->descr->elsize;
    if (dst->nd == 0) {
        memcpy(dst->data, scalar.bytes, itemsize);
        return 0;
    }

    ln_intp idx[LN_MAXDIMS] = {0};
    for (ln_intp n = 0; n < total; ++n) {
        char *p = dst->data;
        for (int d = 0; d < dst->nd; ++d) {
            p += idx[d] * dst->strides[d];
        }
        memcpy(p, scalar.bytes, itemsize);
        advance_index(dst->nd, dst->dimensions, idx);
    }
    return 0;
}

static void advance_index(int nd,const ln_intp*shape,ln_intp*idx){for(int i=nd-1;i>=0;i--){idx[i]++;if(idx[i]<shape[i])return;idx[i]=0;}}

/* NPY_BUFSIZE is also used by the reduction transfer path below.
 * Binary ufunc buffering now lives in ln_nditer.c, which ports axis ordering,
 * coalescing, masked writeback and COPY_IF_OVERLAP in addition to casts. */
#define LN_UFUNC_BUFSIZE 8192 /* NumPy ndarraytypes.h:NPY_BUFSIZE */

static int
is_integer_or_bool_dtype(const ln_dtype *dt)
{
    return dt->type_num == LN_BOOL || dt->kind == 'i' || dt->kind == 'u';
}

static int
is_comparison_op(ln_binary_op op)
{
    return op >= LN_OP_EQUAL && op <= LN_OP_GREATER_EQUAL;
}

static int
is_logical_op(ln_binary_op op)
{
    return op >= LN_OP_LOGICAL_AND && op <= LN_OP_LOGICAL_XOR;
}

static int
is_mixed_signed_unsigned_64(const ln_dtype *a, const ln_dtype *b)
{
    if (a->elsize != 8 || b->elsize != 8) return 0;
    return (a->kind == 'i' && b->kind == 'u') ||
           (a->kind == 'u' && b->kind == 'i');
}

static const ln_dtype *
real_dtype_of_complex(const ln_dtype *dt)
{
    if (!dt || dt->kind != 'c') return dt;
    switch (dt->type_num) {
        case LN_CFLOAT: return ln_dtype_by_num(LN_FLOAT);
        case LN_CDOUBLE: return ln_dtype_by_num(LN_DOUBLE);
        case LN_CLONGDOUBLE: return ln_dtype_by_num(LN_LONGDOUBLE);
        default: return NULL;
    }
}

static const ln_dtype *
binary_output_dtype(const ln_dtype *input_dtype, ln_binary_op op)
{
    if (is_comparison_op(op) || is_logical_op(op) ||
            op == LN_OP_LOGICAL_NOT || op == LN_OP_ISNAN ||
            op == LN_OP_ISINF || op == LN_OP_ISFINITE ||
            op == LN_OP_SIGNBIT) return ln_dtype_by_num(LN_BOOL);
    if (op == LN_OP_ABSOLUTE && input_dtype->kind == 'c')
        return real_dtype_of_complex(input_dtype);
    return input_dtype;
}

/* Numeric subset of the builtin ufunc type resolvers in
 * ufunc_type_resolution.c.  Add/multiply/subtract use the uniform promotion
 * table; subtraction rejects the bool loop.  True divide has NumPy's special
 * integer/bool -> float64 resolver before selecting the floating loop. */
static int
is_bitwise_op(ln_binary_op op)
{
    return op == LN_OP_BITWISE_AND || op == LN_OP_BITWISE_OR ||
           op == LN_OP_BITWISE_XOR;
}

static int
is_divmod_power_op(ln_binary_op op)
{
    return op == LN_OP_FLOOR_DIVIDE || op == LN_OP_REMAINDER ||
           op == LN_OP_POWER;
}

/* Builtin float-only loop selection used by copysign (and later unary math).
 * NumPy's legacy loop resolver chooses the first floating loop to which all
 * operands can be safely cast.  float16 participates explicitly before
 * float32/float64/longdouble, matching NumPy's builtin loop ordering. */
static const ln_dtype *
resolve_float_only_pair(const ln_dtype *a, const ln_dtype *b, ln_error *err)
{
    const int candidates[] = {LN_HALF, LN_FLOAT, LN_DOUBLE, LN_LONGDOUBLE};
    for (size_t i=0;i<sizeof(candidates)/sizeof(candidates[0]);++i) {
        int t=candidates[i];
        if (npy_can_cast_safely_numeric(a->type_num,t) &&
            npy_can_cast_safely_numeric(b->type_num,t)) return ln_dtype_by_num((ln_dtype_num)t);
    }
    seterr(err,"no floating loop can safely represent operands");
    return NULL;
}

const ln_dtype *
ln_resolve_binary_dtype(const ln_dtype *a, const ln_dtype *b,
                     ln_binary_op op, ln_error *err)
{
    const ln_dtype *dt;
    if (op == LN_OP_COPYSIGN || op == LN_OP_ARCTAN2 || op == LN_OP_HYPOT) {
        return resolve_float_only_pair(a,b,err);
    }
    if (op == LN_OP_TRUE_DIVIDE &&
            is_integer_or_bool_dtype(a) && is_integer_or_bool_dtype(b)) {
        dt = ln_dtype_by_num(LN_DOUBLE);
    }
    else {
        dt = ln_promote_dtype(a,b);
    }
    if (!dt) {
        seterr(err,"dtype promotion failed");
        return NULL;
    }
    if (op == LN_OP_SUBTRACT && dt->type_num == LN_BOOL) {
        seterr(err,
            "numpy boolean subtract, the `-` operator, is not supported, "
            "use the bitwise_xor, the `^` operator, or the logical_xor function instead.");
        return NULL;
    }
    if (op == LN_OP_TRUE_DIVIDE && dt->kind != 'f' && dt->kind != 'c') {
        seterr(err,"no true_divide loop for resolved dtype");
        return NULL;
    }
    if (is_bitwise_op(op) && !(dt->kind == 'i' || dt->kind == 'u' || dt->type_num == LN_BOOL)) {
        seterr(err,"bitwise operation is not supported for the resolved dtype");
        return NULL;
    }
    /* floor_divide/remainder/power have no bool loop in generate_umath.py;
     * bool,bool therefore resolves to the first safe integer loop (int8). */
    if (is_divmod_power_op(op) && dt->type_num == LN_BOOL)
        dt = ln_dtype_by_num(LN_BYTE);
    if ((op == LN_OP_FLOOR_DIVIDE || op == LN_OP_REMAINDER) && dt->kind == 'c') {
        seterr(err,"floor_divide/remainder are not supported for complex dtypes");
        return NULL;
    }
    return dt;
}

static ln_array *
binary_impl(const ln_array *a,const ln_array *b,ln_binary_op op,ln_error*err)
{
    const ln_dtype*dt=ln_resolve_binary_dtype(a->descr,b->descr,op,err);
    if(!dt)return NULL;
    if (is_comparison_op(op) && is_mixed_signed_unsigned_64(a->descr,b->descr)) {
        return ln_nditer_binary_new_ex2(a,b,NULL,a->descr,b->descr,
                                        ln_dtype_by_num(LN_BOOL),op,err);
    }
    return ln_nditer_binary_new_ex(a,b,NULL,dt,binary_output_dtype(dt,op),op,err);
}

ln_array *
ln_binary_array_op_where(const ln_array *a, const ln_array *b,
                         const ln_array *where, ln_binary_op op,
                         ln_error *err)
{
    const ln_dtype *dt=ln_resolve_binary_dtype(a->descr,b->descr,op,err);
    if(!dt)return NULL;
    if (is_comparison_op(op) && is_mixed_signed_unsigned_64(a->descr,b->descr)) {
        return ln_nditer_binary_new_ex2(a,b,where,a->descr,b->descr,
                                        ln_dtype_by_num(LN_BOOL),op,err);
    }
    return ln_nditer_binary_new_ex(a,b,where,dt,binary_output_dtype(dt,op),op,err);
}

int
ln_binary_array_op_into(const ln_array *a, const ln_array *b,
                        ln_array *out, const ln_array *where,
                        ln_binary_op op, ln_error *err)
{
    const ln_dtype *dt=ln_resolve_binary_dtype(a->descr,b->descr,op,err);
    if(!dt)return -1;
    if (is_comparison_op(op) && is_mixed_signed_unsigned_64(a->descr,b->descr)) {
        return ln_nditer_binary_into_ex2(a,b,out,where,a->descr,b->descr,
                                         ln_dtype_by_num(LN_BOOL),op,err);
    }
    return ln_nditer_binary_into_ex(a,b,out,where,dt,binary_output_dtype(dt,op),op,err);
}

ln_array *ln_binary_add(const ln_array*a,const ln_array*b,ln_error*err)
{return binary_impl(a,b,LN_OP_ADD,err);}
ln_array *ln_binary_subtract(const ln_array*a,const ln_array*b,ln_error*err)
{return binary_impl(a,b,LN_OP_SUBTRACT,err);}
ln_array *ln_binary_multiply(const ln_array*a,const ln_array*b,ln_error*err)
{return binary_impl(a,b,LN_OP_MULTIPLY,err);}
ln_array *ln_binary_true_divide(const ln_array*a,const ln_array*b,ln_error*err)
{return binary_impl(a,b,LN_OP_TRUE_DIVIDE,err);}

const ln_dtype *
ln_resolve_weak_scalar_dtype(const ln_array *a, int scalar_is_integer,
                          int64_t vi, ln_binary_op op, ln_error *err)
{
    const ln_dtype *dt = NULL;
    if (op == LN_OP_COPYSIGN || op == LN_OP_ARCTAN2 || op == LN_OP_HYPOT) {
        if (a->descr->kind == 'c') { seterr(err,"float-only ufunc is not supported for complex dtypes"); return NULL; }
        if (a->descr->kind == 'f') return a->descr;
        if (!scalar_is_integer) return ln_dtype_by_num(LN_DOUBLE);
        /* NumPy's weak Python-int resolver does not let a bool array pin the
         * loop to half: bool + weak int first acquires the default integer
         * strength and the first safe floating loop is float64.  A weak bool
         * reaches resolve_weak_bool_dtype instead and still selects half. */
        if (a->descr->type_num == LN_BOOL) return ln_dtype_by_num(LN_DOUBLE);
        if (a->descr->elsize <= 1) return ln_dtype_by_num(LN_HALF);
        return a->descr->elsize <= 2 ? ln_dtype_by_num(LN_FLOAT) : ln_dtype_by_num(LN_DOUBLE);
    }
    if (is_bitwise_op(op) && !scalar_is_integer) {
        seterr(err,"bitwise operation is not supported for floating weak scalars");
        return NULL;
    }
    if (op == LN_OP_TRUE_DIVIDE) {
        if (a->descr->kind == 'f' || a->descr->kind == 'c') {
            /* Weak Python/Lua scalar defers to an existing inexact dtype. */
            dt = a->descr;
        }
        else {
            /* integer/bool with either an integer or floating scalar resolves
             * to the default true-divide floating loop. */
            dt = ln_dtype_by_num(LN_DOUBLE);
        }
        return dt;
    }

    if(scalar_is_integer){
        if (is_comparison_op(op) || is_logical_op(op)) {
            if (a->descr->kind == 'f' || a->descr->kind == 'c') dt = a->descr;
            else if (is_comparison_op(op) && a->descr->kind == 'u' && a->descr->elsize == 8 && vi < 0)
                dt = ln_dtype_by_name("int64");
            else if (a->descr->kind == 'u' && a->descr->elsize == 8 && vi < 0)
                dt = ln_dtype_by_num(LN_LONGDOUBLE);
            else if ((a->descr->kind == 'i' || a->descr->kind == 'u') &&
                     integer_scalar_fits_dtype(vi, a->descr)) dt = a->descr;
            else dt = ln_dtype_by_name("int64");
        }
        else if(a->descr->type_num==LN_BOOL) dt=ln_dtype_by_name("int64");
        else if(a->descr->kind=='i'||a->descr->kind=='u'){
            if(!integer_scalar_fits_dtype(vi,a->descr)){
                char msg[192];
                snprintf(msg,sizeof(msg),"Lua integer %lld out of bounds for %s",
                         (long long)vi,a->descr->name);
                seterr(err,msg);
                return NULL;
            }
            dt=a->descr;
        }
        else if(a->descr->kind=='f'||a->descr->kind=='c') dt=a->descr;
    }
    else {
        dt=(a->descr->kind=='f'||a->descr->kind=='c')?a->descr:ln_dtype_by_num(LN_DOUBLE);
    }
    if (!dt) seterr(err,"dtype promotion failed");
    if (op == LN_OP_SUBTRACT && dt && dt->type_num == LN_BOOL) {
        seterr(err,
            "numpy boolean subtract, the `-` operator, is not supported, "
            "use the bitwise_xor, the `^` operator, or the logical_xor function instead.");
        return NULL;
    }
    return dt;
}

static int
make_weak_scalar_array(double v, int64_t vi, int scalar_is_integer,
                       const ln_dtype *dt, ln_array *scalar_arr,
                       unsigned char *storage, ln_error *err)
{
    memset(storage,0,sizeof(long double) > sizeof(unsigned long long)
                     ? sizeof(long double) : sizeof(unsigned long long));
    memset(scalar_arr,0,sizeof(*scalar_arr));
    scalar_arr->data=(char *)storage;
    scalar_arr->nd=0;
    scalar_arr->descr=dt;
    scalar_arr->flags=LN_ARRAY_WRITEABLE|LN_ARRAY_ALIGNED|
                      LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS;
    return ln_array_pack_number(scalar_arr,NULL,v,vi,scalar_is_integer,err);
}

static ln_array *
execute_weak_scalar_loop(const ln_array *a, double v, int64_t vi,
                         int scalar_is_integer, const ln_dtype *dt,
                         const ln_array *where,
                         ln_binary_op op, int scalar_left, ln_error *err)
{
    unsigned char storage[sizeof(long double) > sizeof(unsigned long long)
                          ? sizeof(long double) : sizeof(unsigned long long)];
    ln_array scalar_arr;
    if (make_weak_scalar_array(v,vi,scalar_is_integer,dt,
                              &scalar_arr,storage,err)<0) return NULL;
    if (is_comparison_op(op) && is_mixed_signed_unsigned_64(a->descr,dt)) {
        if (scalar_left) return ln_nditer_binary_new_ex2(&scalar_arr,a,where,dt,a->descr,
                                                         ln_dtype_by_num(LN_BOOL),op,err);
        return ln_nditer_binary_new_ex2(a,&scalar_arr,where,a->descr,dt,
                                        ln_dtype_by_num(LN_BOOL),op,err);
    }
    if (scalar_left) {
        return ln_nditer_binary_new_ex(&scalar_arr,a,where,dt,binary_output_dtype(dt,op),op,err);
    }
    return ln_nditer_binary_new_ex(a,&scalar_arr,where,dt,binary_output_dtype(dt,op),op,err);
}

static int
execute_weak_scalar_into(const ln_array *a, double v, int64_t vi,
                         int scalar_is_integer, const ln_dtype *dt,
                         ln_array *out, const ln_array *where,
                         ln_binary_op op, int scalar_left, ln_error *err)
{
    unsigned char storage[sizeof(long double) > sizeof(unsigned long long)
                          ? sizeof(long double) : sizeof(unsigned long long)];
    ln_array scalar_arr;
    if (make_weak_scalar_array(v,vi,scalar_is_integer,dt,
                              &scalar_arr,storage,err)<0) return -1;
    if (is_comparison_op(op) && is_mixed_signed_unsigned_64(a->descr,dt)) {
        if (scalar_left) return ln_nditer_binary_into_ex2(&scalar_arr,a,out,where,dt,a->descr,
                                                          ln_dtype_by_num(LN_BOOL),op,err);
        return ln_nditer_binary_into_ex2(a,&scalar_arr,out,where,a->descr,dt,
                                         ln_dtype_by_num(LN_BOOL),op,err);
    }
    if (scalar_left) {
        return ln_nditer_binary_into_ex(&scalar_arr,a,out,where,dt,binary_output_dtype(dt,op),op,err);
    }
    return ln_nditer_binary_into_ex(a,&scalar_arr,out,where,dt,binary_output_dtype(dt,op),op,err);
}

ln_array *
ln_binary_scalar_op_where(const ln_array*a,double v,int64_t vi,int scalar_is_integer,
                          const ln_array *where, ln_binary_op op,int scalar_left,
                          ln_error*err)
{
    if(!a){seterr(err,"invalid array");return NULL;}
    const ln_dtype *dt=ln_resolve_weak_scalar_dtype(a,scalar_is_integer,vi,op,err);
    if(!dt)return NULL;
    return execute_weak_scalar_loop(a,v,vi,scalar_is_integer,dt,where,op,scalar_left,err);
}

int
ln_binary_scalar_op_into(const ln_array*a,double v,int64_t vi,int scalar_is_integer,
                         ln_array *out,const ln_array *where,ln_binary_op op,
                         int scalar_left,ln_error*err)
{
    if(!a||!out){seterr(err,"invalid array");return -1;}
    const ln_dtype *dt=ln_resolve_weak_scalar_dtype(a,scalar_is_integer,vi,op,err);
    if(!dt)return -1;
    return execute_weak_scalar_into(a,v,vi,scalar_is_integer,dt,out,where,op,scalar_left,err);
}

ln_array *
ln_binary_scalar_op(const ln_array*a,double v,int64_t vi,int scalar_is_integer,
                    ln_binary_op op,int scalar_left,ln_error*err)
{
    return ln_binary_scalar_op_where(a,v,vi,scalar_is_integer,NULL,op,scalar_left,err);
}

const ln_dtype *
ln_resolve_weak_bool_dtype(const ln_array *a, ln_binary_op op, ln_error *err)
{
    const ln_dtype *dt;
    if (op == LN_OP_COPYSIGN || op == LN_OP_ARCTAN2 || op == LN_OP_HYPOT) {
        if (a->descr->kind == 'c') { seterr(err,"float-only ufunc is not supported for complex dtypes"); return NULL; }
        if (a->descr->kind == 'f') dt = a->descr;
        else if (a->descr->type_num == LN_BOOL || a->descr->elsize <= 1) dt = ln_dtype_by_num(LN_HALF);
        else dt = a->descr->elsize <= 2 ? ln_dtype_by_num(LN_FLOAT) : ln_dtype_by_num(LN_DOUBLE);
    }
    else if (op == LN_OP_TRUE_DIVIDE) {
        dt = (a->descr->kind == 'f' || a->descr->kind == 'c') ? a->descr : ln_dtype_by_num(LN_DOUBLE);
    }
    else if (is_divmod_power_op(op) && a->descr->type_num == LN_BOOL) {
        dt = ln_dtype_by_num(LN_BYTE);
    }
    else {
        dt = a->descr;
    }
    if (is_bitwise_op(op) && !(dt->kind == 'i' || dt->kind == 'u' || dt->type_num == LN_BOOL)) {
        seterr(err,"bitwise operation is not supported for the resolved dtype");
        return NULL;
    }
    if (op == LN_OP_SUBTRACT && dt->type_num == LN_BOOL) {
        seterr(err,
            "numpy boolean subtract, the `-` operator, is not supported, "
            "use the bitwise_xor, the `^` operator, or the logical_xor function instead.");
        return NULL;
    }
    return dt;
}

ln_array *
ln_binary_scalar_bool_op_where(const ln_array *a, int truth,
                               const ln_array *where, ln_binary_op op,
                               int scalar_left, ln_error *err)
{
    if(!a){seterr(err,"invalid array");return NULL;}
    const ln_dtype *dt=ln_resolve_weak_bool_dtype(a,op,err);
    if(!dt)return NULL;
    return execute_weak_scalar_loop(a,(double)truth,(int64_t)truth,1,
                                    dt,where,op,scalar_left,err);
}

int
ln_binary_scalar_bool_op_into(const ln_array *a, int truth, ln_array *out,
                              const ln_array *where, ln_binary_op op,
                              int scalar_left, ln_error *err)
{
    if(!a||!out){seterr(err,"invalid array");return -1;}
    const ln_dtype *dt=ln_resolve_weak_bool_dtype(a,op,err);
    if(!dt)return -1;
    return execute_weak_scalar_into(a,(double)truth,(int64_t)truth,1,
                                    dt,out,where,op,scalar_left,err);
}

ln_array *
ln_binary_scalar_bool_op(const ln_array *a, int truth, ln_binary_op op,
                         int scalar_left, ln_error *err)
{
    return ln_binary_scalar_bool_op_where(a,truth,NULL,op,scalar_left,err);
}

const ln_dtype *
ln_resolve_weak_complex_dtype(const ln_array *a, ln_binary_op op, ln_error *err)
{
    if (!a || !a->descr) { seterr(err,"invalid array"); return NULL; }
    if (is_bitwise_op(op) || op == LN_OP_FLOOR_DIVIDE || op == LN_OP_REMAINDER ||
            op == LN_OP_COPYSIGN) {
        seterr(err,"operation is not supported for complex dtypes");
        return NULL;
    }
    const ln_dtype *dt = NULL;
    if (a->descr->kind == 'c') dt = a->descr;
    else if (a->descr->kind == 'f') {
        if (a->descr->type_num == LN_HALF || a->descr->type_num == LN_FLOAT)
            dt = ln_dtype_by_num(LN_CFLOAT);
        else if (a->descr->type_num == LN_DOUBLE)
            dt = ln_dtype_by_num(LN_CDOUBLE);
        else
            dt = ln_dtype_by_num(LN_CLONGDOUBLE);
    }
    else {
        /* NumPy weak Python-complex scalar acquires default complex strength
         * when paired with exact integer/bool dtypes. */
        dt = ln_dtype_by_num(LN_CDOUBLE);
    }
    return dt;
}

static int
make_weak_complex_scalar_array(long double real, long double imag,
                               const ln_dtype *dt, ln_array *scalar_arr,
                               unsigned char *storage, ln_error *err)
{
    memset(storage,0,sizeof(ln_clongdouble));
    memset(scalar_arr,0,sizeof(*scalar_arr));
    scalar_arr->data=(char *)storage;
    scalar_arr->nd=0;
    scalar_arr->descr=dt;
    scalar_arr->flags=LN_ARRAY_WRITEABLE|LN_ARRAY_ALIGNED|
                      LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS;
    return ln_array_pack_complex(scalar_arr,NULL,real,imag,err);
}

ln_array *
ln_binary_scalar_complex_op_where(const ln_array *a, long double real,
        long double imag, const ln_array *where, ln_binary_op op,
        int scalar_left, ln_error *err)
{
    const ln_dtype *dt=ln_resolve_weak_complex_dtype(a,op,err);
    if(!dt)return NULL;
    unsigned char storage[sizeof(ln_clongdouble)];
    ln_array scalar_arr;
    if(make_weak_complex_scalar_array(real,imag,dt,&scalar_arr,storage,err)<0)return NULL;
    if(scalar_left)
        return ln_nditer_binary_new_ex(&scalar_arr,a,where,dt,binary_output_dtype(dt,op),op,err);
    return ln_nditer_binary_new_ex(a,&scalar_arr,where,dt,binary_output_dtype(dt,op),op,err);
}

int
ln_binary_scalar_complex_op_into(const ln_array *a, long double real,
        long double imag, ln_array *out, const ln_array *where,
        ln_binary_op op, int scalar_left, ln_error *err)
{
    const ln_dtype *dt=ln_resolve_weak_complex_dtype(a,op,err);
    if(!dt)return -1;
    unsigned char storage[sizeof(ln_clongdouble)];
    ln_array scalar_arr;
    if(make_weak_complex_scalar_array(real,imag,dt,&scalar_arr,storage,err)<0)return -1;
    if(scalar_left)
        return ln_nditer_binary_into_ex(&scalar_arr,a,out,where,dt,binary_output_dtype(dt,op),op,err);
    return ln_nditer_binary_into_ex(a,&scalar_arr,out,where,dt,binary_output_dtype(dt,op),op,err);
}

ln_array *
ln_binary_scalar_complex_op(const ln_array *a, long double real,
        long double imag, ln_binary_op op, int scalar_left, ln_error *err)
{
    return ln_binary_scalar_complex_op_where(a,real,imag,NULL,op,scalar_left,err);
}

ln_array *
ln_binary_scalar(const ln_array*a,double v,int64_t vi,int scalar_is_integer,
                 int multiply,ln_error*err)
{
    return ln_binary_scalar_op(a,v,vi,scalar_is_integer,
        multiply ? LN_OP_MULTIPLY : LN_OP_ADD,0,err);
}

static int
is_float_math_unary_op(ln_binary_op op)
{
    return op == LN_OP_SQRT || op == LN_OP_EXP || op == LN_OP_LOG ||
           op == LN_OP_SIN || op == LN_OP_COS || op == LN_OP_TAN ||
           op == LN_OP_SINH || op == LN_OP_COSH || op == LN_OP_TANH ||
           op == LN_OP_EXP2 || op == LN_OP_LOG2 || op == LN_OP_LOG10 ||
           op == LN_OP_EXPM1 || op == LN_OP_LOG1P || op == LN_OP_CBRT ||
           op == LN_OP_ARCSIN || op == LN_OP_ARCCOS || op == LN_OP_ARCTAN ||
           op == LN_OP_ARCSINH || op == LN_OP_ARCCOSH || op == LN_OP_ARCTANH;
}

static const ln_dtype *
resolve_unary_input_dtype(const ln_array *a, ln_binary_op op, ln_error *err)
{
    if (!is_float_math_unary_op(op)) return a->descr;
    if (a->descr->kind == 'c') return a->descr;
    const int candidates[] = {LN_HALF, LN_FLOAT, LN_DOUBLE, LN_LONGDOUBLE};
    for (size_t i=0;i<sizeof(candidates)/sizeof(candidates[0]);++i) {
        int t=candidates[i];
        if (npy_can_cast_safely_numeric(a->descr->type_num,t)) return ln_dtype_by_num((ln_dtype_num)t);
    }
    seterr(err,"no floating unary loop can safely represent input");
    return NULL;
}

static int
validate_unary_op_dtype(const ln_array *a, ln_binary_op op, ln_error *err)
{
    if (a->descr->kind == 'c' && op == LN_OP_SIGNBIT) {
        seterr(err, "ufunc 'signbit' not supported for complex input");
        return -1;
    }
    if (a->descr->kind == 'c' && op == LN_OP_CBRT) {
        seterr(err, "ufunc 'cbrt' not supported for complex input");
        return -1;
    }
    if (a->descr->type_num == LN_BOOL) {
        if (op == LN_OP_NEGATIVE) {
            seterr(err,
                "The numpy boolean negative, the `-` operator, is not supported, "
                "use the `~` operator or the logical_not function instead.");
            return -1;
        }
        if (op == LN_OP_POSITIVE || op == LN_OP_SIGN) {
            seterr(err, "ufunc did not contain a loop with signature matching bool input");
            return -1;
        }
    }
    return 0;
}

ln_array *
ln_unary_array_op_where(const ln_array *a, const ln_array *where,
                        ln_binary_op op, ln_error *err)
{
    if (!a) { seterr(err, "invalid array"); return NULL; }
    if (validate_unary_op_dtype(a, op, err) < 0) return NULL;
    const ln_dtype *dt = resolve_unary_input_dtype(a,op,err);
    if (!dt) return NULL;
    return ln_nditer_binary_new_ex(a, a, where, dt,
            binary_output_dtype(dt, op), op, err);
}

int
ln_unary_array_op_into(const ln_array *a, ln_array *out,
                       const ln_array *where, ln_binary_op op, ln_error *err)
{
    if (!a || !out) { seterr(err, "invalid array"); return -1; }
    if (validate_unary_op_dtype(a, op, err) < 0) return -1;
    const ln_dtype *dt = resolve_unary_input_dtype(a,op,err);
    if (!dt) return -1;
    return ln_nditer_binary_into_ex(a, a, out, where, dt,
            binary_output_dtype(dt, op), op, err);
}


/*
 * Reduction core adapted from:
 *   numpy/_core/src/umath/ufunc_object.c:reducelike_promote_and_resolve
 *   numpy/_core/src/umath/reduction.c:PyUFunc_ReduceWrapper
 *   numpy/_core/_methods.py:_mean
 *
 * CPython descriptor/object plumbing is replaced by concrete ln_dtype and
 * Lua-scalar packing, while reduction axes, keepdims, dtype/out interaction,
 * identities, where masking, and COPY_IF_OVERLAP-style temporary output are
 * kept in the native core.
 */
static const ln_dtype *
default_add_multiply_reduce_dtype(const ln_dtype *src)
{
    if (src->type_num == LN_BOOL) {
        return ln_dtype_by_name("int64");  /* npy_intp on this 64-bit build */
    }
    if ((src->kind == 'i' || src->kind == 'u') && src->elsize < sizeof(ln_intp)) {
        return src->kind == 'u' ? ln_dtype_by_name("uint64")
                                : ln_dtype_by_name("int64");
    }
    return src;
}

static const ln_dtype *
resolve_reduction_dtype(const ln_array *a, const ln_dtype *requested,
                        const ln_dtype *out_dtype, ln_reduce_op op)
{
    if (requested) return requested;
    if (op == LN_REDUCE_MEAN) {
        /* _methods.py:_mean: integer and bool default to float64; inexact
         * input retains its dtype.  `out` does not override this choice. */
        return (a->descr->kind == 'f' || a->descr->kind == 'c') ? a->descr : ln_dtype_by_num(LN_DOUBLE);
    }
    /* ufunc_object.c:reducelike_promote_and_resolve historically lets an
     * explicit out dtype seed resolution when dtype= was not supplied. */
    if (out_dtype) return ln_promote_dtype(a->descr, out_dtype);
    return default_add_multiply_reduce_dtype(a->descr);
}

static int
reduce_stream_into(char *acc, const char *src, ln_intp src_stride,
                   ln_intp count, const ln_dtype *src_dtype,
                   const ln_dtype *reduce_dtype, int multiply,
                   char *cast_buffer, ln_error *err)
{
    if (count <= 0) return 0;
    ln_strided_binary_loop loop = multiply
        ? ln_get_multiply_loop(reduce_dtype->type_num)
        : ln_get_add_loop(reduce_dtype->type_num);
    if (!loop) {
        seterr(err, "no reduction inner loop for dtype");
        return -1;
    }

    if (src_dtype->type_num == reduce_dtype->type_num) {
        char *args[3] = {acc, (char *)src, acc};
        ln_intp dimensions[1] = {count};
        ln_intp steps[3] = {0, src_stride, 0};
        loop(args, dimensions, steps, NULL);
        return 0;
    }

    for (ln_intp offset = 0; offset < count; offset += LN_UFUNC_BUFSIZE) {
        ln_intp chunk = count - offset;
        if (chunk > LN_UFUNC_BUFSIZE) chunk = LN_UFUNC_BUFSIZE;
        const char *chunk_src = src + offset * src_stride;
        if (ln_cast_strided_numeric(chunk_src, src_stride, src_dtype,
                cast_buffer, (ln_intp)reduce_dtype->elsize,
                reduce_dtype, chunk, err) < 0) {
            return -1;
        }
        char *args[3] = {acc, cast_buffer, acc};
        ln_intp dimensions[1] = {chunk};
        ln_intp steps[3] = {0, (ln_intp)reduce_dtype->elsize, 0};
        loop(args, dimensions, steps, NULL);
    }
    return 0;
}

static int
pack_reduce_seed(char *dst, const ln_dtype *dtype, int multiply,
                 int has_initial, double initial_v, int64_t initial_i,
                 int initial_is_integer, ln_error *err)
{
    if (!has_initial) {
        write_number(dst, dtype, multiply ? 1.0 : 0.0,
                     multiply ? 1 : 0, 1);
        return 0;
    }
    ln_array scalar;
    memset(&scalar, 0, sizeof(scalar));
    scalar.data = dst;
    scalar.nd = 0;
    scalar.descr = dtype;
    scalar.flags = LN_ARRAY_WRITEABLE | LN_ARRAY_ALIGNED |
                   LN_ARRAY_C_CONTIGUOUS | LN_ARRAY_F_CONTIGUOUS;
    return ln_array_pack_number(&scalar, NULL, initial_v, initial_i,
                                initial_is_integer, err);
}

static int
reduction_shape(const ln_array *a, const uint8_t *axis_flags, int keepdims,
                int *out_nd, ln_intp *out_dims)
{
    int od = 0;
    for (int d = 0; d < a->nd; ++d) {
        int reduced = axis_flags && axis_flags[d];
        if (reduced) {
            if (keepdims) out_dims[od++] = 1;
        }
        else {
            out_dims[od++] = a->dimensions[d];
        }
    }
    *out_nd = od;
    return 0;
}

static void
reduction_keeporder_strides(ln_array *out, const ln_array *a,
                            const uint8_t *axis_flags, int keepdims)
{
    if (out->nd == 0 || a->nd == 0 || ln_array_size(out) == 0) return;
    int order[LN_MAXDIMS];
    ln_intp estride[LN_MAXDIMS];
    for (int i = 0; i < a->nd; ++i) {
        int d = a->nd - 1 - i;  /* NpyIter AXISDATA: inner/C-last first */
        order[i] = d;
        estride[d] = a->dimensions[d] <= 1 ? 0 :
                     (a->strides[d] < 0 ? -a->strides[d] : a->strides[d]);
    }
    /* Single-operand form of npyiter_find_best_axis_ordering.  Zero-stride
     * singleton axes are ambiguous and therefore remain stable. */
    for (int i = 1; i < a->nd; ++i) {
        int cand = order[i], pos = i;
        if (estride[cand] == 0) continue;
        for (int j = i - 1; j >= 0; --j) {
            int prev = order[j];
            if (estride[prev] == 0) continue;
            if (estride[prev] > estride[cand]) pos = j;
            else break;
        }
        if (pos != i) {
            for (int j = i; j > pos; --j) order[j] = order[j - 1];
            order[pos] = cand;
        }
    }
    int out_axis_for_input[LN_MAXDIMS];
    int od = 0;
    for (int d = 0; d < a->nd; ++d) {
        if (axis_flags && axis_flags[d] && !keepdims) out_axis_for_input[d] = -1;
        else out_axis_for_input[d] = od++;
    }
    ln_intp stride = (ln_intp)out->descr->elsize;
    for (int i = 0; i < a->nd; ++i) {
        int oa = out_axis_for_input[order[i]];
        if (oa < 0) continue;
        out->strides[oa] = stride;
        stride *= out->dimensions[oa];
    }
    ln_update_contiguous_flags(out);
}

/* PyUFunc_Reduceat builds an outer NpyIter with op_axes such that the
 * reduction axis is absent (-1) from the input operand and is supplied by the
 * 1-D index operand instead.  For KEEPORDER allocation this makes the input
 * stride on that axis effectively zero.  Singleton input axes are likewise
 * normalized to zero by NpyIter.  The stable ambiguity rules below are the
 * single-input projection of npyiter_find_best_axis_ordering for that setup. */
static void
reduceat_keeporder_strides(ln_array *out, const ln_array *a, int axis)
{
    if (out->nd == 0 || a->nd == 0 || ln_array_size(out) == 0) return;
    int order[LN_MAXDIMS];
    ln_intp estride[LN_MAXDIMS];
    for (int i = 0; i < a->nd; ++i) {
        int d = a->nd - 1 - i;
        order[i] = d;
        estride[d] = (d == axis || a->dimensions[d] <= 1) ? 0 :
                     (a->strides[d] < 0 ? -a->strides[d] : a->strides[d]);
    }
    for (int i = 1; i < a->nd; ++i) {
        int cand = order[i], pos = i;
        if (estride[cand] == 0) continue;
        for (int j = i - 1; j >= 0; --j) {
            int prev = order[j];
            if (estride[prev] == 0) continue;  /* ambiguous: keep scanning */
            if (estride[prev] > estride[cand]) pos = j;
            else break;
        }
        if (pos != i) {
            for (int j = i; j > pos; --j) order[j] = order[j - 1];
            order[pos] = cand;
        }
    }
    ln_intp stride = (ln_intp)out->descr->elsize;
    for (int i = 0; i < out->nd; ++i) {
        int d = order[i];
        out->strides[d] = stride;
        stride *= out->dimensions[d];
    }
    ln_update_contiguous_flags(out);
}

static int
same_shape_exact(const ln_array *a, int nd, const ln_intp *dims)
{
    if (!a || a->nd != nd) return 0;
    for (int d = 0; d < nd; ++d) if (a->dimensions[d] != dims[d]) return 0;
    return 1;
}

static int
copy_cast_same_shape_core(const ln_array *src, ln_array *dst, ln_error *err)
{
    if (!same_shape_exact(dst, src->nd, src->dimensions)) {
        seterr(err, "output parameter has the wrong shape for reduction");
        return -1;
    }
    if (!(dst->flags & LN_ARRAY_WRITEABLE)) {
        seterr(err, "output array is not writeable");
        return -1;
    }
    ln_intp total = ln_array_size(src);
    if (total < 0) { seterr(err, "array is too big"); return -1; }
    if (total == 0) return 0;
    if (src->nd == 0) {
        return ln_cast_strided_numeric(src->data, 0, src->descr,
                dst->data, 0, dst->descr, 1, err);
    }
    ln_intp coord[LN_MAXDIMS] = {0};
    for (ln_intp i = 0; i < total; ++i) {
        const char *sp = src->data;
        char *dp = dst->data;
        for (int d = 0; d < src->nd; ++d) {
            sp += coord[d] * src->strides[d];
            dp += coord[d] * dst->strides[d];
        }
        if (ln_cast_strided_numeric(sp, 0, src->descr,
                dp, 0, dst->descr, 1, err) < 0) return -1;
        advance_index(src->nd, src->dimensions, coord);
    }
    return 0;
}

static int
mean_divide_accumulator(char *p, const ln_dtype *dtype, ln_intp count)
{
    if (count == 0) {
        switch (dtype->type_num) {
            case LN_HALF: { ln_half h=LN_HALF_NAN; memcpy(p,&h,sizeof(h)); return 0; }
            case LN_FLOAT: *(float *)p = NAN; return 0;
            case LN_DOUBLE: *(double *)p = NAN; return 0;
            case LN_LONGDOUBLE: *(long double *)p = NAN; return 0;
            case LN_CFLOAT: { ln_cfloat z={NAN,NAN}; memcpy(p,&z,sizeof(z)); return 0; }
            case LN_CDOUBLE: { ln_cdouble z={NAN,NAN}; memcpy(p,&z,sizeof(z)); return 0; }
            case LN_CLONGDOUBLE: { ln_clongdouble z={NAN,NAN}; memcpy(p,&z,sizeof(z)); return 0; }
            /* Matches the common NumPy invalid-float-to-integer result on
             * this platform after true_divide(..., out=integer, unsafe). */
            case LN_BOOL: *(uint8_t *)p = 1; return 0;
            case LN_BYTE: *(int8_t *)p = 0; return 0;
            case LN_SHORT: *(int16_t *)p = 0; return 0;
            case LN_INT: *(int32_t *)p = INT32_MIN; return 0;
            case LN_LONG:
                *(long *)p = LONG_MIN; return 0;
            case LN_LONGLONG: *(long long *)p = LLONG_MIN; return 0;
            case LN_UBYTE: *(uint8_t *)p = 0; return 0;
            case LN_USHORT: *(uint16_t *)p = 0; return 0;
            case LN_UINT: *(uint32_t *)p = 0; return 0;
            case LN_ULONG: *(unsigned long *)p = 0; return 0;
            case LN_ULONGLONG: *(unsigned long long *)p = 0; return 0;
            default: return -1;
        }
    }
    switch (dtype->type_num) {
        case LN_BOOL:
            /* bool true_divide cast back to bool preserves truth value. */
            return 0;
        case LN_BYTE: *(int8_t *)p = (int8_t)(*(int8_t *)p / count); return 0;
        case LN_UBYTE: *(uint8_t *)p = (uint8_t)(*(uint8_t *)p / (ln_intp)count); return 0;
        case LN_SHORT: *(int16_t *)p = (int16_t)(*(int16_t *)p / count); return 0;
        case LN_USHORT: *(uint16_t *)p = (uint16_t)(*(uint16_t *)p / (ln_intp)count); return 0;
        case LN_INT: *(int32_t *)p = (int32_t)(*(int32_t *)p / count); return 0;
        case LN_UINT: *(uint32_t *)p = (uint32_t)(*(uint32_t *)p / (uint64_t)count); return 0;
        case LN_LONG: *(long *)p = (long)(*(long *)p / count); return 0;
        case LN_ULONG: *(unsigned long *)p = (unsigned long)(*(unsigned long *)p / (unsigned long)count); return 0;
        case LN_LONGLONG: *(long long *)p = (long long)(*(long long *)p / count); return 0;
        case LN_ULONGLONG: *(unsigned long long *)p = (unsigned long long)(*(unsigned long long *)p / (unsigned long long)count); return 0;
        case LN_HALF: { ln_half h; memcpy(&h,p,sizeof(h)); h=ln_float_to_half(ln_half_to_float(h)/(float)count); memcpy(p,&h,sizeof(h)); return 0; }
        case LN_FLOAT: *(float *)p /= (float)count; return 0;
        case LN_DOUBLE: *(double *)p /= (double)count; return 0;
        case LN_LONGDOUBLE: *(long double *)p /= (long double)count; return 0;
        case LN_CFLOAT: { ln_cfloat z; memcpy(&z,p,sizeof(z)); z.real/=(float)count; z.imag/=(float)count; memcpy(p,&z,sizeof(z)); return 0; }
        case LN_CDOUBLE: { ln_cdouble z; memcpy(&z,p,sizeof(z)); z.real/=(double)count; z.imag/=(double)count; memcpy(p,&z,sizeof(z)); return 0; }
        case LN_CLONGDOUBLE: { ln_clongdouble z; memcpy(&z,p,sizeof(z)); z.real/=(long double)count; z.imag/=(long double)count; memcpy(p,&z,sizeof(z)); return 0; }
        default: return -1;
    }
}

static int
fill_mean_counts(const ln_array *a, const uint8_t *axis_flags, int keepdims,
                 const ln_array *where, int out_nd, const ln_intp *out_dims,
                 ln_intp *counts, ln_error *err)
{
    ln_intp out_total = 1;
    if (out_nd > 0) {
        out_total = 1;
        for (int d = 0; d < out_nd; ++d) {
            if (ln_mul_sizes_with_overflow(&out_total, out_total, out_dims[d])) {
                seterr(err, "array is too big"); return -1;
            }
        }
    }
    if (out_total > 0) memset(counts, 0, (size_t)out_total * sizeof(*counts));

    if (!where) {
        ln_intp c = 1;
        for (int d = 0; d < a->nd; ++d) {
            if (axis_flags && axis_flags[d]) {
                if (ln_mul_sizes_with_overflow(&c, c, a->dimensions[d])) {
                    seterr(err, "array is too big"); return -1;
                }
            }
        }
        for (ln_intp i = 0; i < out_total; ++i) counts[i] = c;
        return 0;
    }

    if (where->descr->type_num != LN_BOOL) {
        seterr(err, "where mask must have bool dtype"); return -1;
    }
    ln_intp wstrides[LN_MAXDIMS] = {0};
    if (ln_broadcast_strides(a->nd, a->dimensions, where->nd,
            where->dimensions, where->strides, "where mask",
            wstrides, err) < 0) return -1;
    ln_intp total = ln_array_size(a);
    if (total < 0) { seterr(err, "array is too big"); return -1; }
    ln_intp coord[LN_MAXDIMS] = {0};
    for (ln_intp i = 0; i < total; ++i) {
        const char *mp = where->data;
        for (int d = 0; d < a->nd; ++d) mp += coord[d] * wstrides[d];
        if (*(const uint8_t *)mp) {
            ln_intp linear = 0;
            int od = 0;
            for (int d = 0; d < a->nd; ++d) {
                ln_intp oi;
                if (axis_flags && axis_flags[d]) {
                    if (!keepdims) continue;
                    oi = 0;
                }
                else oi = coord[d];
                linear = linear * out_dims[od] + oi;
                od++;
            }
            counts[linear]++;
        }
        advance_index(a->nd, a->dimensions, coord);
    }
    return 0;
}

static int
divide_mean_output(ln_array *out, const ln_intp *counts, ln_error *err)
{
    ln_intp total = ln_array_size(out);
    if (total < 0) { seterr(err, "array is too big"); return -1; }
    if (out->nd == 0) {
        if (mean_divide_accumulator(out->data, out->descr, counts[0]) < 0) {
            seterr(err, "mean requires a supported numeric output dtype"); return -1;
        }
        return 0;
    }
    ln_intp coord[LN_MAXDIMS] = {0};
    for (ln_intp i = 0; i < total; ++i) {
        char *p = out->data;
        for (int d = 0; d < out->nd; ++d) p += coord[d] * out->strides[d];
        if (mean_divide_accumulator(p, out->descr, counts[i]) < 0) {
            seterr(err, "mean requires a supported numeric output dtype"); return -1;
        }
        advance_index(out->nd, out->dimensions, coord);
    }
    return 0;
}

static ln_array *
reduce_general_new(const ln_array *a, const uint8_t *axis_flags,
                   int keepdims, const ln_dtype *requested_dtype,
                   const ln_dtype *out_dtype_for_resolution,
                   const ln_array *where, ln_reduce_op op,
                   int has_initial, double initial_v, int64_t initial_i,
                   int initial_is_integer, ln_error *err)
{
    if (!a) { seterr(err, "invalid reduction input"); return NULL; }
    if (op == LN_REDUCE_MEAN) has_initial = 0;
    const ln_dtype *rdt = resolve_reduction_dtype(
            a, requested_dtype, out_dtype_for_resolution, op);
    if (!rdt) { seterr(err, "reduction dtype resolution failed"); return NULL; }

    int out_nd = 0;
    ln_intp out_dims[LN_MAXDIMS] = {0};
    reduction_shape(a, axis_flags, keepdims, &out_nd, out_dims);
    ln_array *out = ln_array_new(out_nd, out_nd ? out_dims : NULL,
                                 rdt, 0, 0, err);
    if (!out) return NULL;
    reduction_keeporder_strides(out, a, axis_flags, keepdims);

    ln_intp out_total = ln_array_size(out);
    if (out_total < 0) { seterr(err, "array is too big"); goto fail; }

    unsigned char seed[32];
    if (rdt->elsize > sizeof(seed)) {
        seterr(err, "reduction dtype too large for scalar seed");
        goto fail;
    }
    int multiply = (op == LN_REDUCE_PROD);
    if (pack_reduce_seed((char *)seed, rdt, multiply,
            has_initial, initial_v, initial_i, initial_is_integer, err) < 0) {
        goto fail;
    }
    for (ln_intp i = 0; i < out_total; ++i) {
        memcpy(out->data + (size_t)i * rdt->elsize, seed, rdt->elsize);
    }

    ln_intp *mean_counts = NULL;
    if (op == LN_REDUCE_MEAN && out_total > 0) {
        mean_counts = (ln_intp *)calloc((size_t)out_total, sizeof(ln_intp));
        if (!mean_counts) { seterr(err, "out of memory"); goto fail; }
    }

    ln_intp where_strides[LN_MAXDIMS] = {0};
    if (where) {
        if (where->descr->type_num != LN_BOOL) {
            seterr(err, "where mask must have bool dtype");
            goto fail_counts;
        }
        if (ln_broadcast_strides(a->nd, a->dimensions, where->nd,
                where->dimensions, where->strides, "where mask",
                where_strides, err) < 0) goto fail_counts;
    }

    int nreduce = 0, reduce_axis = -1;
    for (int d = 0; d < a->nd; ++d) {
        if (axis_flags && axis_flags[d]) { nreduce++; reduce_axis = d; }
    }
    ln_intp total = ln_array_size(a);
    if (total < 0) { seterr(err, "array is too big"); goto fail_counts; }

    char *cast_buffer = NULL;
    if (a->descr->type_num != rdt->type_num) {
        cast_buffer = (char *)malloc((size_t)LN_UFUNC_BUFSIZE * rdt->elsize);
        if (!cast_buffer) { seterr(err, "out of memory"); goto fail_counts; }
    }

    /* Fast paths mirror reduction.c's external-loop intent and preserve the
     * pairwise floating add loop for contiguous/full and single-axis cases. */
    if (!where && nreduce == a->nd && a->nd > 0 &&
            ((a->flags & LN_ARRAY_C_CONTIGUOUS) ||
             (a->flags & LN_ARRAY_F_CONTIGUOUS))) {
        if (out_total > 0 && reduce_stream_into(out->data, a->data,
                (ln_intp)a->descr->elsize, total, a->descr, rdt,
                multiply, cast_buffer, err) < 0) goto fail_cast;
        if (mean_counts && out_total > 0) mean_counts[0] = total;
    }
    else if (!where && nreduce == 1 && a->nd > 0) {
        ln_intp out_coord[LN_MAXDIMS] = {0};
        for (ln_intp oi = 0; oi < out_total; ++oi) {
            char *acc = out->data;
            for (int od = 0; od < out_nd; ++od) acc += out_coord[od] * out->strides[od];
            const char *stream = a->data;
            int od = 0;
            for (int d = 0; d < a->nd; ++d) {
                if (d == reduce_axis) {
                    if (keepdims) od++;
                    continue;
                }
                stream += out_coord[od++] * a->strides[d];
            }
            if (reduce_stream_into(acc, stream, a->strides[reduce_axis],
                    a->dimensions[reduce_axis], a->descr, rdt,
                    multiply, cast_buffer, err) < 0) goto fail_cast;
            if (mean_counts) {
                ln_intp linear = (ln_intp)((acc - out->data) / (ln_intp)rdt->elsize);
                mean_counts[linear] = a->dimensions[reduce_axis];
            }
            advance_index(out_nd, out_dims, out_coord);
        }
    }
    else {
        ln_strided_binary_loop loop = multiply
            ? ln_get_multiply_loop(rdt->type_num)
            : ln_get_add_loop(rdt->type_num);
        if (!loop) { seterr(err, "no reduction inner loop for dtype"); goto fail_cast; }
        unsigned char onebuf[32];
        if (rdt->elsize > sizeof(onebuf)) {
            seterr(err, "reduction dtype too large for scalar buffer");
            goto fail_cast;
        }
        ln_intp coord[LN_MAXDIMS] = {0};
        for (ln_intp i = 0; i < total; ++i) {
            const char *sp = a->data;
            for (int d = 0; d < a->nd; ++d) sp += coord[d] * a->strides[d];

            int selected = 1;
            if (where) {
                const char *mp = where->data;
                for (int d = 0; d < a->nd; ++d) mp += coord[d] * where_strides[d];
                selected = (*(const uint8_t *)mp != 0);
            }
            if (selected) {
                char *acc = out->data;
                int od = 0;
                for (int d = 0; d < a->nd; ++d) {
                    if (axis_flags && axis_flags[d]) {
                        if (keepdims) od++;
                    }
                    else {
                        acc += coord[d] * out->strides[od++];
                    }
                }
                const char *vp = sp;
                if (a->descr->type_num != rdt->type_num) {
                    if (ln_cast_strided_numeric(sp, 0, a->descr,
                            (char *)onebuf, 0, rdt, 1, err) < 0) goto fail_cast;
                    vp = (const char *)onebuf;
                }
                char *args[3] = {acc, (char *)vp, acc};
                ln_intp dim1[1] = {1};
                ln_intp steps[3] = {0, 0, 0};
                loop(args, dim1, steps, NULL);
                if (mean_counts) {
                    ln_intp linear = (ln_intp)((acc - out->data) / (ln_intp)rdt->elsize);
                    mean_counts[linear]++;
                }
            }
            advance_index(a->nd, a->dimensions, coord);
        }
    }

    free(cast_buffer);
    if (op == LN_REDUCE_MEAN) {
        for (ln_intp i = 0; i < out_total; ++i) {
            if (mean_divide_accumulator(out->data + (size_t)i * rdt->elsize,
                    rdt, mean_counts[i]) < 0) {
                seterr(err, "mean requires a supported numeric reduction dtype");
                goto fail_counts;
            }
        }
    }
    free(mean_counts);
    return out;

fail_cast:
    free(cast_buffer);
fail_counts:
    free(mean_counts);
fail:
    ln_array_free(out);
    return NULL;
}

ln_array *
ln_reduce_ex(const ln_array *a, const uint8_t *axis_flags,
             int keepdims, const ln_dtype *dtype,
             const ln_array *where, ln_reduce_op op,
             int has_initial, double initial_v, int64_t initial_i,
             int initial_is_integer, ln_error *err)
{
    return reduce_general_new(a, axis_flags, keepdims, dtype, NULL, where, op,
                              has_initial, initial_v, initial_i,
                              initial_is_integer, err);
}

int
ln_reduce_into_ex(const ln_array *a, const uint8_t *axis_flags,
                  int keepdims, const ln_dtype *dtype, ln_array *out,
                  const ln_array *where, ln_reduce_op op,
                  int has_initial, double initial_v, int64_t initial_i,
                  int initial_is_integer, ln_error *err)
{
    if (!out) { seterr(err, "invalid reduction output"); return -1; }
    int expect_nd = 0;
    ln_intp expect_dims[LN_MAXDIMS] = {0};
    reduction_shape(a, axis_flags, keepdims, &expect_nd, expect_dims);
    if (!same_shape_exact(out, expect_nd, expect_dims)) {
        seterr(err, "output parameter has the wrong shape for reduction");
        return -1;
    }
    if (!(out->flags & LN_ARRAY_WRITEABLE)) {
        seterr(err, "output array is not writeable");
        return -1;
    }
    if (op == LN_REDUCE_MEAN) {
        /* _methods.py:_mean first executes sum(..., out=out) and only then
         * true_divide(..., out=out, casting='unsafe').  This is observable
         * when dtype= differs from out.dtype (e.g. uint8 accumulator into a
         * float32 out), so do not divide the accumulator before casting. */
        const ln_dtype *mean_dtype;
        if (dtype) mean_dtype = dtype;
        else if (a->descr->kind == 'f' || a->descr->kind == 'c') mean_dtype = ln_promote_dtype(a->descr, out->descr);
        else mean_dtype = ln_dtype_by_num(LN_DOUBLE);
        ln_array *tmp = reduce_general_new(a, axis_flags, keepdims, mean_dtype,
                NULL, where, LN_REDUCE_SUM, 0, 0, 0, 1, err);
        if (!tmp) return -1;
        int rc = copy_cast_same_shape_core(tmp, out, err);
        ln_array_free(tmp);
        if (rc < 0) return -1;
        ln_intp nout = ln_array_size(out);
        if (nout < 0) { seterr(err, "array is too big"); return -1; }
        ln_intp *counts = (ln_intp *)calloc((size_t)(nout > 0 ? nout : 1), sizeof(ln_intp));
        if (!counts) { seterr(err, "out of memory"); return -1; }
        if (fill_mean_counts(a, axis_flags, keepdims, where,
                expect_nd, expect_dims, counts, err) < 0) {
            free(counts); return -1;
        }
        rc = divide_mean_output(out, counts, err);
        free(counts);
        return rc;
    }

    ln_array *tmp = reduce_general_new(a, axis_flags, keepdims, dtype,
            out->descr, where, op, has_initial, initial_v, initial_i,
            initial_is_integer, err);
    if (!tmp) return -1;
    int rc = copy_cast_same_shape_core(tmp, out, err);
    ln_array_free(tmp);
    return rc;
}

static const ln_dtype *
resolve_accumulate_dtype(const ln_array *a, const ln_dtype *requested,
                         const ln_dtype *out_dtype)
{
    if (requested) return requested;
    if (out_dtype) return ln_promote_dtype(a->descr, out_dtype);
    return default_add_multiply_reduce_dtype(a->descr);
}

static ln_array *
accumulate_general_new(const ln_array *a, int axis, const ln_dtype *requested,
                       const ln_dtype *out_dtype_for_resolution,
                       ln_reduce_op op, ln_error *err)
{
    if (!a || a->nd == 0) {
        seterr(err, "cannot accumulate on a scalar");
        return NULL;
    }
    if (axis < 0 || axis >= a->nd) {
        seterr(err, "axis out of bounds");
        return NULL;
    }
    if (op != LN_REDUCE_SUM && op != LN_REDUCE_PROD) {
        seterr(err, "unsupported accumulate operation");
        return NULL;
    }
    const ln_dtype *dt = resolve_accumulate_dtype(a, requested,
                                                   out_dtype_for_resolution);
    if (!dt) {
        seterr(err, "accumulate dtype resolution failed");
        return NULL;
    }

    ln_array *work = ln_array_new(a->nd, a->dimensions, dt, 0, 0, err);
    if (!work) return NULL;
    uint8_t no_reduce[LN_MAXDIMS] = {0};
    reduction_keeporder_strides(work, a, no_reduce, 0);

    ln_intp axis_len = a->dimensions[axis];
    if (axis_len == 0 || ln_array_size(work) == 0) return work;

    ln_strided_binary_loop loop = (op == LN_REDUCE_PROD)
        ? ln_get_multiply_loop(dt->type_num)
        : ln_get_add_loop(dt->type_num);
    if (!loop) {
        ln_array_free(work);
        seterr(err, "no accumulate inner loop for dtype");
        return NULL;
    }

    ln_intp outer_dims[LN_MAXDIMS] = {0};
    int outer_nd = 0;
    ln_intp outer_total = 1;
    for (int d = 0; d < a->nd; ++d) {
        if (d == axis) continue;
        outer_dims[outer_nd++] = a->dimensions[d];
        if (ln_mul_sizes_with_overflow(&outer_total, outer_total, a->dimensions[d])) {
            ln_array_free(work);
            seterr(err, "array is too big");
            return NULL;
        }
    }
    if (outer_nd == 0) outer_total = 1;

    unsigned char curbuf[32];
    if (dt->elsize > sizeof(curbuf)) {
        ln_array_free(work);
        seterr(err, "accumulate dtype too large for scalar buffer");
        return NULL;
    }
    ln_intp ocoord[LN_MAXDIMS] = {0};
    for (ln_intp oi = 0; oi < outer_total; ++oi) {
        const char *src0 = a->data;
        char *dst0 = work->data;
        int od = 0;
        for (int d = 0; d < a->nd; ++d) {
            if (d == axis) continue;
            src0 += ocoord[od] * a->strides[d];
            dst0 += ocoord[od] * work->strides[d];
            od++;
        }

        if (ln_cast_strided_numeric(src0, 0, a->descr,
                dst0, 0, dt, 1, err) < 0) {
            ln_array_free(work);
            return NULL;
        }
        for (ln_intp k = 1; k < axis_len; ++k) {
            const char *sp = src0 + k * a->strides[axis];
            char *prev = dst0 + (k - 1) * work->strides[axis];
            char *cur = dst0 + k * work->strides[axis];
            const char *vp = sp;
            if (a->descr->type_num != dt->type_num) {
                if (ln_cast_strided_numeric(sp, 0, a->descr,
                        (char *)curbuf, 0, dt, 1, err) < 0) {
                    ln_array_free(work);
                    return NULL;
                }
                vp = (const char *)curbuf;
            }
            char *args[3] = {prev, (char *)vp, cur};
            ln_intp one[1] = {1};
            ln_intp steps[3] = {0, 0, 0};
            loop(args, one, steps, NULL);
        }
        advance_index(outer_nd, outer_dims, ocoord);
    }
    return work;
}

ln_array *
ln_accumulate_ex(const ln_array *a, int axis, const ln_dtype *dtype,
                 ln_reduce_op op, ln_error *err)
{
    return accumulate_general_new(a, axis, dtype, NULL, op, err);
}

int
ln_accumulate_into_ex(const ln_array *a, int axis, const ln_dtype *dtype,
                      ln_array *out, ln_reduce_op op, ln_error *err)
{
    if (!out) { seterr(err, "invalid accumulate output"); return -1; }
    if (!same_shape_exact(out, a->nd, a->dimensions)) {
        seterr(err, "provided out is the wrong size for the accumulation");
        return -1;
    }
    if (!(out->flags & LN_ARRAY_WRITEABLE)) {
        seterr(err, "output array is not writeable");
        return -1;
    }
    ln_array *tmp = accumulate_general_new(a, axis, dtype, out->descr, op, err);
    if (!tmp) return -1;
    int rc = copy_cast_same_shape_core(tmp, out, err);
    ln_array_free(tmp);
    return rc;
}

static ln_array *
reduceat_general_new(const ln_array *a, const ln_intp *indices,
                     ln_intp nindices, int axis, const ln_dtype *requested,
                     const ln_dtype *out_dtype_for_resolution,
                     ln_reduce_op op, ln_error *err)
{
    if (!a || a->nd == 0) {
        seterr(err, "cannot reduceat on a scalar");
        return NULL;
    }
    if (axis < 0 || axis >= a->nd) {
        seterr(err, "axis out of bounds");
        return NULL;
    }
    if (op != LN_REDUCE_SUM && op != LN_REDUCE_PROD) {
        seterr(err, "unsupported reduceat operation");
        return NULL;
    }
    if (nindices < 0) {
        seterr(err, "invalid reduceat indices");
        return NULL;
    }
    ln_intp axis_len = a->dimensions[axis];
    for (ln_intp i = 0; i < nindices; ++i) {
        if (indices[i] < 0 || indices[i] >= axis_len) {
            seterr(err, "reduceat index out of bounds");
            return NULL;
        }
    }

    const ln_dtype *dt = resolve_accumulate_dtype(a, requested,
                                                   out_dtype_for_resolution);
    if (!dt) {
        seterr(err, "reduceat dtype resolution failed");
        return NULL;
    }

    ln_intp out_dims[LN_MAXDIMS];
    memcpy(out_dims, a->dimensions, (size_t)a->nd * sizeof(ln_intp));
    out_dims[axis] = nindices;
    ln_array *work = ln_array_new(a->nd, out_dims, dt, 0, 0, err);
    if (!work) return NULL;
    reduceat_keeporder_strides(work, a, axis);
    if (ln_array_size(work) == 0) return work;

    ln_strided_binary_loop loop = (op == LN_REDUCE_PROD)
        ? ln_get_multiply_loop(dt->type_num)
        : ln_get_add_loop(dt->type_num);
    if (!loop) {
        ln_array_free(work);
        seterr(err, "no reduceat inner loop for dtype");
        return NULL;
    }

    ln_intp outer_dims[LN_MAXDIMS] = {0};
    int outer_nd = 0;
    ln_intp outer_total = 1;
    for (int d = 0; d < a->nd; ++d) {
        if (d == axis) continue;
        outer_dims[outer_nd++] = a->dimensions[d];
        if (ln_mul_sizes_with_overflow(&outer_total, outer_total,
                                       a->dimensions[d])) {
            ln_array_free(work);
            seterr(err, "array is too big");
            return NULL;
        }
    }
    if (outer_nd == 0) outer_total = 1;

    char *cast_buffer = NULL;
    if (a->descr->type_num != dt->type_num) {
        if (dt->elsize > SIZE_MAX / LN_UFUNC_BUFSIZE) {
            ln_array_free(work);
            seterr(err, "reduceat cast buffer is too large");
            return NULL;
        }
        cast_buffer = (char *)malloc((size_t)LN_UFUNC_BUFSIZE * dt->elsize);
        if (!cast_buffer) {
            ln_array_free(work);
            seterr(err, "out of memory allocating reduceat cast buffer");
            return NULL;
        }
    }
    ln_intp ocoord[LN_MAXDIMS] = {0};
    for (ln_intp oi = 0; oi < outer_total; ++oi) {
        const char *src_base = a->data;
        char *dst_base = work->data;
        int od = 0;
        for (int d = 0; d < a->nd; ++d) {
            if (d == axis) continue;
            src_base += ocoord[od] * a->strides[d];
            dst_base += ocoord[od] * work->strides[d];
            od++;
        }

        for (ln_intp j = 0; j < nindices; ++j) {
            ln_intp start = indices[j];
            ln_intp end = (j == nindices - 1) ? axis_len : indices[j + 1];
            ln_intp count = end - start;
            char *dst = dst_base + j * work->strides[axis];
            const char *sp0 = src_base + start * a->strides[axis];
            if (ln_cast_strided_numeric(sp0, 0, a->descr,
                    dst, 0, dt, 1, err) < 0) {
                free(cast_buffer);
                ln_array_free(work);
                return NULL;
            }
            if (count > 1) {
                ln_intp remain = count - 1;
                const char *sp = src_base + (start + 1) * a->strides[axis];
                if (a->descr->type_num == dt->type_num) {
                    char *args[3] = {dst, (char *)sp, dst};
                    ln_intp dims[1] = {remain};
                    ln_intp steps[3] = {0, a->strides[axis], 0};
                    loop(args, dims, steps, NULL);
                }
                else {
                    while (remain > 0) {
                        ln_intp chunk = remain > LN_UFUNC_BUFSIZE ? LN_UFUNC_BUFSIZE : remain;
                        if (ln_cast_strided_numeric(sp, a->strides[axis], a->descr,
                                cast_buffer, (ln_intp)dt->elsize, dt,
                                chunk, err) < 0) {
                            free(cast_buffer);
                            ln_array_free(work);
                            return NULL;
                        }
                        char *args[3] = {dst, cast_buffer, dst};
                        ln_intp dims[1] = {chunk};
                        ln_intp steps[3] = {0, (ln_intp)dt->elsize, 0};
                        loop(args, dims, steps, NULL);
                        sp += chunk * a->strides[axis];
                        remain -= chunk;
                    }
                }
            }
        }
        advance_index(outer_nd, outer_dims, ocoord);
    }
    free(cast_buffer);
    return work;
}

ln_array *
ln_reduceat_ex(const ln_array *a, const ln_intp *indices,
               ln_intp nindices, int axis, const ln_dtype *dtype,
               ln_reduce_op op, ln_error *err)
{
    return reduceat_general_new(a, indices, nindices, axis, dtype, NULL, op, err);
}

int
ln_reduceat_into_ex(const ln_array *a, const ln_intp *indices,
                    ln_intp nindices, int axis, const ln_dtype *dtype,
                    ln_array *out, ln_reduce_op op, ln_error *err)
{
    if (!out) { seterr(err, "invalid reduceat output"); return -1; }
    if (a->nd == 0) { seterr(err, "cannot reduceat on a scalar"); return -1; }
    if (axis < 0 || axis >= a->nd) { seterr(err, "axis out of bounds"); return -1; }
    if (out->nd != a->nd) {
        seterr(err, "provided out is the wrong size for reduceat"); return -1;
    }
    for (int d = 0; d < a->nd; ++d) {
        ln_intp expect = (d == axis) ? nindices : a->dimensions[d];
        if (out->dimensions[d] != expect) {
            seterr(err, "provided out is the wrong size for reduceat"); return -1;
        }
    }
    if (!(out->flags & LN_ARRAY_WRITEABLE)) {
        seterr(err, "output array is not writeable"); return -1;
    }
    ln_array *tmp = reduceat_general_new(a, indices, nindices, axis, dtype,
                                         out->descr, op, err);
    if (!tmp) return -1;
    int rc = copy_cast_same_shape_core(tmp, out, err);
    ln_array_free(tmp);
    return rc;
}

static void
legacy_axis_flags(const ln_array *a, int axis, uint8_t *flags)
{
    memset(flags, 0, LN_MAXDIMS);
    if (axis == -1) {
        for (int d = 0; d < a->nd; ++d) flags[d] = 1;
    }
    else if (a->nd > 0 && axis >= 0 && axis < a->nd) {
        flags[axis] = 1;
    }
}

ln_array *
ln_reduce_add(const ln_array *a, int axis, ln_error *err)
{
    if (!a || (axis != -1 && ((a->nd > 0 && (axis < 0 || axis >= a->nd)) ||
                              (a->nd == 0 && axis != 0)))) {
        seterr(err, "axis out of bounds"); return NULL;
    }
    uint8_t flags[LN_MAXDIMS]; legacy_axis_flags(a, axis, flags);
    return ln_reduce_ex(a, flags, 0, NULL, NULL, LN_REDUCE_SUM,
                        0, 0, 0, 1, err);
}

ln_array *
ln_reduce_multiply(const ln_array *a, int axis, ln_error *err)
{
    if (!a || (axis != -1 && ((a->nd > 0 && (axis < 0 || axis >= a->nd)) ||
                              (a->nd == 0 && axis != 0)))) {
        seterr(err, "axis out of bounds"); return NULL;
    }
    uint8_t flags[LN_MAXDIMS]; legacy_axis_flags(a, axis, flags);
    return ln_reduce_ex(a, flags, 0, NULL, NULL, LN_REDUCE_PROD,
                        0, 0, 0, 1, err);
}

ln_array *
ln_mean_reduce(const ln_array *a, int axis, ln_error *err)
{
    if (!a || (axis != -1 && ((a->nd > 0 && (axis < 0 || axis >= a->nd)) ||
                              (a->nd == 0 && axis != 0)))) {
        seterr(err, "axis out of bounds"); return NULL;
    }
    uint8_t flags[LN_MAXDIMS]; legacy_axis_flags(a, axis, flags);
    return ln_reduce_ex(a, flags, 0, NULL, NULL, LN_REDUCE_MEAN,
                        0, 0, 0, 1, err);
}

double ln_mean_all(const ln_array*a,ln_error*err){ln_intp n=ln_array_size(a);if(n<0){seterr(err,"array too large");return NAN;}if(n==0){return NAN;}long double sum=0;ln_intp idx[LN_MAXDIMS]={0};for(ln_intp i=0;i<n;i++){char*p=a->data;for(int d=0;d<a->nd;d++)p+=idx[d]*a->strides[d];sum+=(long double)read_double(p,a->descr);advance_index(a->nd,a->dimensions,idx);}return(double)(sum/(long double)n);}
