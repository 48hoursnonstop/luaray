# Linear, logarithmic and geometric sampling

LuaRay's native sequence engine composes its ndarray iterator, dtype resolver,
arithmetic ufuncs and memory-layout allocator. Runtime requires Lua/native
libraries; NumPy2.5.3 supplies development reference values only.

```lua
local np = require('luaray')
local samples, step = np.linspace(-1, 1, 5, {retstep=true})
-- samples: {-1, -.5, 0, .5, 1}; step: .5
local powers = np.logspace(0, 2, 3) -- {1, 10, 100}
local geometric = np.geomspace(-1, -16, 3) -- {-1, -4, -16}
local rows = np.linspace(np.array({1,2}, 'float32'), 3,
                         {num=3, axis=-1})
-- {{1,2,3}, {2,2.5,3}}, float32
```

## Lua signatures

All three functions accept `(start, stop [, num [, options]])` or
`(start, stop, options)`. Endpoints accept supported numeric ndarrays, scalars
and tables. Options are num (default50), endpoint (true), axis (1), dtype (inferred),
retstep (linspace only) and base (logspace only,10.0). Unknown options, duplicate
counts, inappropriate base/retstep options and extra arguments raise Lua errors.
An explicit device argument and NumPy's entire positional signature are not
implemented. Use the Lua options table for endpoint/dtype/axis/step/base.

num must be a nonnegative Lua integer; the source-derived boolean count path
also accepts false/true as0/1. Floating counts, including2.0, are rejected. Axis
is an integer in the result rank: positive coordinates start at1, negative axes
count from the end. The new sample dimension defaults to the front; axis=-1
puts it last. Result rank cannot exceed64. Endpoint broadcasting, incompatible
shapes, empty dimensions and rank boundaries are executed against the oracle.

## linspace

The computation dtype preserves the source converter's weak scalar versus
strong ndarray promotion, then ensures floating/complex evaluation. Integer-only
endpoints normally compute float64; float16/float32 array endpoints retain their
precision when combined with compatible weak Lua scalars. Explicit output dtype
does not replace that computation dtype. LuaRay spells the native extended real
type `longdouble`; on the tested x86 ABI NumPy calls its16-byte storage float128.
The reference harness maps that spelling while checking native width/strides.

The engine computes a typed delta, typed arange, step multiplication and start
addition. Endpoint=true uses count-1 as the divisor, and explicitly assigns the
last endpoint when count>1. A zero step in any broadcast cell triggers NumPy's
whole-array subnormal fallback: divide the indices first, then multiply delta.
Half normalization and intermediate rounding are retained, including large half
index/divisor overflow and IEEE values for counts65504 and65536.

`retstep=true` returns two Lua values. A scalar step becomes a Lua number or
complex scalar; a broadcast step remains a typed ndarray. count=0, or count=1
with endpoint=true, returns a scalar NaN step. count=1 with endpoint=false uses
the endpoint delta. The result is always an ndarray. Inputs remain unchanged;
new sample arrays own independent storage. Arrays may retain an internal owner
through a moved-axis view; no input storage is shared.

For an integer output dtype, linspace floors the computed values before casting:
`linspace(-1,1,5,{dtype='int8'})` produces `{-1,-1,0,0,1}`. Complex computation
cannot use that real floor path. Bool/fixed-width string and supported numeric
output conversions follow native array casts. Object/structured/variable-width
StringDType and complete parametric-output inference are not supported.

## logspace

logspace evaluates linspace exponents and then `base ** exponents`. A weak Lua
base retains ufunc scalar promotion; a typed base retains its array dtype. A
non-scalar base contributes to endpoint rank/broadcast validation and receives
the sample dimension at the requested axis before power broadcasting.

An explicit dtype casts the power result after computation. It does not increase
the preceding power precision: float32 power cast to float64 still contains
float32 rounding. Integer output casts truncate, unlike linspace's floor step.
Invalid real powers can produce NaN/Inf according to the native arithmetic;
full NumPy warning/error-state control is not implemented.

## geomspace

geomspace rejects zero endpoints, including requests with zero samples. It
promotes endpoint arrays with the requested dtype (float64 when omitted) and a
weak floating count. It copies endpoints in KEEPORDER, rotates the first endpoint
to the positive real axis using its sign, interpolates log10 values through
logspace, corrects endpoints before inverse rotation, then casts the result.
This preserves negative-real and tested complex paths. Opposite-sign real
endpoints can produce interior NaNs rather than an automatic complex result.

The default computation is at least float64/complex128. Explicit float32/complex64
can retain narrower strong-array computation. Complex inverse rotation follows
the source multiply rounding. On FMA hosts an original real component8 can
become7.9999995 after rotation/unrotation and cast to integer7; endpoints are
corrected before unrotation, matching upstream's actual algorithm.

## Shared numerical and allocation corrections

The native creation allocator centralizes NumPy NewLikeArray KEEPORDER physical
axis sorting, including zero strides and3-D permutations. Roll reuses it. Sampling
casts use it rather than replacing the layout with general iterator allocation.
Exact contiguous ufunc inputs with a scalar partner allocate canonical C/F
outputs, preserving NumPy's singleton strides.

Complex-to-real casts retain the original component type rather than routing
float32/float64 through long double. A complex64 real component38935.516 now
casts to int8 value23 on the tested ABI. Complex64/128 non-reduction multiplication
uses the source's fused operand ordering when the host provides FMA; reductions
and extended precision retain the baseline. This is not a complete SIMD port or
certification of every hardware-dependent integer conversion/alias path.

Real/complex fixed-string casts now use the licensed NumPy Dragon4 numerical
core, with native ABI types, thread-local scratch and caller-owned output. Python
wrappers, Python exceptions and interpreter headers are absent. Shortest strings
retain original precision, signed zero, nonfinite cases and scientific cutoffs:
1e3 for half,1e6 for float32 and1e16 for double/extended. Complex components omit
unneeded `.0`; NaN sign handling follows the source. Existing NumPy BSD and
Dragon4 MIT attribution are preserved. The ABI shim supports common extended,
quad and double long-double layouts; only Linux x86 extended storage was executed
in this development environment. Other architecture branches remain unverified.

## Executed evidence and limits

Original NumPy2.5.3 sequences: **2,478 linspace /504,645 checks**, **1,542 logspace
/154,195**, **1,392 geomspace /150,473**: **5,412 /809,313**. Values, actual errors,
shape, dtype, strides, step and endpoint states are checked. They cover typed/weak
values, complex paths, output casts, empty/singleton/rank64 boundaries, subnormals,
large half counts, reversed/sliced/F/broadcast/3-D layouts and array bases.

Linspace values compare exactly, with observed error0. Logspace/geomspace use
computation-precision tolerances before explicit output casts: absolute+relative
2e-3 for half,3e-6 for float32/complex64,2e-12 for wider computation. Integer,
bool, string values and metadata compare exactly. A source audit confirmed
NumPy's SVML power dispatch versus native libm powf rounding; output widening
cannot remove that difference. The initial output-dtype-based tolerance was
corrected for that reason. Maximum normalized error `abs(error)/max(1,abs(ref))`
was1.1393306865162e-7 for logspace and1.9546212523884e-7 for geomspace. Logspace's
maximum absolute error9.2233720368548e18 occurs at large powers; normalized error
provides the useful scale. Geomspace maximum absolute error was9.5367431640625e-7.

A separate C oracle checks **70,828 raw-bit states**: all65,536 half encodings,
2,063 float32,2,063 float64,576 complex64,576 complex128 and14 x86 extended values.
It passed **141,656 exact ASCII/Unicode comparisons**, unaligned buffers and
output guards. Eight threads performed16,384 additional formatter calls. Native
sampling boundary tests and154 direct Lua checks also passed. Full regression,
final sanitizer and clean-package results are recorded in [validation results](../development/validation.md) and
the versioned release verification JSON/log. The raw-bit corpus is ABI-specific;
regeneration requires the pinned NumPy interpreter on the same tested ABI.

All available APIs remain partially compatible. Full warning/subclass/exception
fidelity, every dtype/count/base combination, non-native numeric endian and every
hardware-specific rounding/cast behavior are not certified. Earlier blocked
states and explicit differences remain separate. Name availability in the API
inventory is not an overall completion percentage.
