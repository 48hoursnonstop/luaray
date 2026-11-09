#!/usr/bin/env python3
"""Extract the licensed NumPy2.5.3 numerical Dragon4 core; no Python C API."""
from pathlib import Path
import argparse,hashlib
p=argparse.ArgumentParser();p.add_argument('source',type=Path);args=p.parse_args()
root=Path(__file__).resolve().parents[1]
s=(args.source/'numpy/_core/src/multiarray/dragon4.c').read_text()
h=(args.source/'numpy/_core/src/multiarray/dragon4.h').read_text()
assert hashlib.sha256(s.encode()).hexdigest()=='e09cfef237f1c47fec6c11926e23ed2222404d1e4357b5d65e65a2daf9d83949','unexpected upstream Dragon4 source'
body=s[:s.index('\n\n/*\n * Here we define two Dragon4 entry functions')]
body=body.replace('#include "dragon4.h"\n#include <numpy/npy_common.h>', '#include "ln_float_format_private.h"')
body='\n'.join(line for line in body.splitlines() if 'PyErr_SetString(' not in line)+'\n'
a=body.index(' * Dummy implementation of a memory manager for BigInts.')
b=body.index(' * Each call to dragon4 uses 7 BigInts.',a)
body=body[:a]+' * Thread-local numerical scratch, reused synchronously. The native wrapper\n * copies the result into caller-owned storage before returning.\n *\n'+body[b:]
assert 'PyObject' not in body and 'PyErr_' not in body
(root/'src/ln_dragon4.inc').write_text(body)
enums=h[h.index('typedef enum DigitMode'):h.index('#define make_dragon4_typedecl')]
(root/'src/ln_float_format_private.h').write_text(h[:h.index('#ifndef')]+'''/* Native ABI shim for the licensed NumPy2.5.3 Dragon4 numerical core. */
#ifndef LUARAY_FLOAT_FORMAT_PRIVATE_H
#define LUARAY_FLOAT_FORMAT_PRIVATE_H
#include <stdint.h>
#include <float.h>
typedef uint8_t npy_uint8;
typedef uint16_t npy_uint16;
typedef uint32_t npy_uint32;
typedef uint64_t npy_uint64;
typedef int32_t npy_int32;
typedef int npy_bool;
typedef uint16_t npy_half;
typedef float npy_float32;
typedef double npy_float64;
typedef long double npy_float80;
typedef long double npy_float96;
typedef long double npy_float128;
#define NPY_FALSE 0
#define NPY_TLS _Thread_local
#if LDBL_MANT_DIG == 64 && __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
#if __SIZEOF_LONG_DOUBLE__ == 16
#define NPY_FLOAT128 1
#define HAVE_LDOUBLE_INTEL_EXTENDED_16_BYTES_LE 1
#elif __SIZEOF_LONG_DOUBLE__ == 12
#define HAVE_LDOUBLE_INTEL_EXTENDED_12_BYTES_LE 1
#else
#error Unsupported long double storage for native Dragon4
#endif
#elif LDBL_MANT_DIG == 113
#define NPY_FLOAT128 1
#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
#define HAVE_LDOUBLE_IEEE_QUAD_LE 1
#else
#define HAVE_LDOUBLE_IEEE_QUAD_BE 1
#endif
#elif LDBL_MANT_DIG != 53
#error Unsupported long double representation for native Dragon4
#endif
'''+enums+'\n#endif\n')
print('Imported numeric Dragon4 core; source SHA256',hashlib.sha256(s.encode()).hexdigest())
