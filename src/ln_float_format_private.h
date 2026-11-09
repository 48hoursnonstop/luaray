/*
 * Copyright (c) 2014 Ryan Juckett
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 */

/*
 * This file contains a modified version of Ryan Juckett's Dragon4
 * implementation, obtained from https://www.ryanjuckett.com,
 * which has been ported from C++ to C and which has
 * modifications specific to printing floats in numpy.
 *
 * Ryan Juckett's original code was under the Zlib license; he gave numpy
 * permission to include it under the MIT license instead.
 */
/* Native ABI shim for the licensed NumPy2.5.3 Dragon4 numerical core. */
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
typedef enum DigitMode
{
    /* Round digits to print shortest uniquely identifiable number. */
    DigitMode_Unique,
    /* Output the digits of the number as if with infinite precision */
    DigitMode_Exact,
} DigitMode;

typedef enum CutoffMode
{
    /* up to cutoffNumber significant digits */
    CutoffMode_TotalLength,
    /* up to cutoffNumber significant digits past the decimal point */
    CutoffMode_FractionLength,
} CutoffMode;

typedef enum TrimMode
{
    TrimMode_None,         /* don't trim zeros, always leave a decimal point */
    TrimMode_LeaveOneZero, /* trim all but the zero before the decimal point */
    TrimMode_Zeros,        /* trim all trailing zeros, leave decimal point */
    TrimMode_DptZeros,     /* trim trailing zeros & trailing decimal point */
} TrimMode;


#endif
