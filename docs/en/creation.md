# Array creation, conversion and copying

LuaRay creates real native ndarray storage and views. Its creation kernel and
separately compiled Lua bindings share an explicit ownership interface; Python
is only a development oracle. Existing numeric/string/temporal casts and copyto
supply conversion and filling semantics.

```lua
local np = require('luaray')
local a = np.array({{1,2,3},{4,5,6}}, 'int32')
assert(np.asarray(a) == a)
local independent = a:copy()
independent:set(99, 1, 1) -- value first; a stays unchanged
local view = np.array(a, {copy=false, ndmin=3})
local filled = np.full_like(a, 7, {dtype='float32', shape={3,2}, order='F'})
local finite = np.asarray_chkfinite({1,2,3})
```

## Lua calling conventions

Conversion functions accept input, an optional dtype string or options table,
and an optional options table after a positional dtype. For example:
`np.asarray(a, 'float32', {order='C'})` or
`np.asarray(a, {dtype='float32', order='C'})`.

| Function | Options | Defaults |
| --- | --- | --- |
| array | dtype, order, copy, ndmin, subok | K, copy=true, ndmin=0 |
| asarray / asanyarray | dtype, order, copy | K, copy=if_needed |
| ascontiguousarray / asfortranarray | dtype, fixed order | C / F, rank at least1 |
| asarray_chkfinite | dtype, order | K |
| copy / ndarray:copy | order; root copy also subok | root K / method C |
| empty_like / zeros_like / ones_like | dtype, order, shape, subok | prototype dtype/shape, K |
| full_like | same, with fill value after prototype | prototype dtype/shape, K |
| empty / zeros / ones | dtype, order | float64, C |
| full | dtype, order; fill value after shape | fill dtype, C |

`np.copy(a, 'F')` and `a:copy('F')` are also supported. Shape constructors accept
a Lua integer or a table of dimensions; `{}` means scalar shape. Like constructors
accept a shape override in the options table. Only C/F order is accepted by
empty/zeros/ones/full, matching the source constructor restriction. Unknown
options, duplicate dtypes, unsupported options and invalid orders raise Lua errors.
Device/like dispatch, ndarray-valued shape arguments and NumPy's complete
positional signatures are not implemented.

## Copying and identity

copy accepts true (always), false (never), or `'if_needed'`. The named value
represents NumPy's copy=None policy: Lua nil removes a table field and therefore
selects the function's default. This distinction matters for array, whose default
is always copy, versus asarray/asanyarray, whose default is copy when necessary.

Compatible existing arrays return the original userdata under an if-needed or
never-copy policy. Dtype changes or required C/F contiguity force allocation;
copy=false then raises. Ordinary Lua scalars/tables and native temporal scalar
userdata require array allocation and reject copy=false. A dtype-preserving copy
of a read-only input is independently writable; a reused view stays read-only.

ndmin applies to array. Leading dimensions of length1 become a view sharing the
selected array's data. Negative ndmin is ignored, matching the executed pinned
source; the maximum rank is64. Explicit Lua stack reservation supports deep
construction and tolist conversion. Both are tested in a fresh Lua process.

Root copy defaults to KEEPORDER; ndarray:copy defaults to C. K copies preserve
physical axis order while materializing positive dense strides, including
transposes, reversed/sliced arrays, zero-stride broadcasts and3-D permutations.
A chooses F for F-only input when allocating, C otherwise. An existing array
converted with order=A and no required copy can retain noncontiguous strides;
A does not force contiguity in that source fast path. C/F conversions require
the stated layout. ascontiguousarray/asfortranarray promote scalars to rank1.

## Filling and like constructors

Like constructors allocate independent storage. K order follows the prototype's
axis permutation when the rank is unchanged, including shape changes. A rank
change falls back to C order. Empty and singleton shapes are tested separately.
Fixed string descriptors with unspecified width use the constructor minimum of
one character. The scalar/table array constructor also finalizes empty strings
at width1. Full array conversion can infer a larger width from the source dtype.

zeros/zeros_like clear the actual storage, including fixed strings (empty text),
complex values and temporal tick zero. ones/ones_like and full/full_like execute
the existing unsafe copyto path. Values broadcast into the requested shape.
Without dtype, full first materializes its fill value and uses that dtype. Like
constructors use the prototype dtype unless explicitly overridden.

Weak scalar versus strong array conversion remains observable:

```lua
-- Rejects scalar300 outside uint8 bounds:
-- np.full(2, 300, 'uint8')
local wrapped = np.full(2, np.array(300, 'int64'), 'uint8') -- {44,44}
```

The same distinction applies to full_like. Empty constructors really allocate
uninitialized storage. Reference tests inspect their metadata, then write valid
data before comparing values; no uninitialized contents are treated as expected
results. Inputs to independent constructors remain unchanged.

## Finite and temporal conversion

asarray_chkfinite first performs ordinary conversion, then rejects NaN/Inf for
floating and complex dtypes. Integer, boolean, string and temporal arrays follow
the source's non-inexact bypass. Finite checks handle empty arrays and reused
read-only input without mutation.

Native datetime/timedelta scalar userdata retains its strong descriptor during
materialization. Requested generic temporal dtypes inherit source temporal units,
including cross-kind conversion. An unsized string target for a datetime scalar
uses its actual ISO string width; timedelta scalars retain the source's legacy
width21. Scalar NaT, multipliers and numeric/string conversions are tested.

Numeric array casts into a generic datetime descriptor preserve raw integer
ticks. Scalar integer construction requires a specified unit, even for the
minimum signed integer bit pattern; a typed datetime NaT remains valid. Scalar
packing and array casting are separate operations. Generic temporal warnings
and the entire Python scalar/type protocol are not reproduced.

The historical LuaRay np.astype/ndarray:astype numeric-to-generic-datetime
restriction remains a documented partial-compatibility contract. Construction
uses its own source-derived array-cast path. Existing legacy regression assertions
were retained. This does not claim NumPy2.5.3's numeric-only root Array API astype
contract or complete ndarray method parity.

## Evidence and scope

Original NumPy2.5.3: conversion4,726 cases /454,982 checks; copying740 /77,978;
like constructors5,624 /485,242; dense constructors1,461 /23,546. Total
**12,551 /1,041,748**. Tests compare values, dtype, shape, strides, actual errors,
identity, exact sharing queries and real writes through results, including
propagation into shared input views and rejection of read-only writes. Native
boundary tests,164 direct Lua checks and a fresh-process rank64 test add coverage.
The generator reproduces all four frozen files exactly with the pinned oracle.

Full regression, sanitizer and clean archive execution are recorded separately
in TEST_RESULTS.md and the versioned release verification JSON/log. The API
inventory measures observed callable names only; all remain partially compatible.
Object/structured/variable strings, non-native numeric endian, foreign array
protocols, general subclasses, all warnings/exceptions and complete coercion are
not certified. Nested sequences containing ndarrays or temporal scalar userdata
are not fully implemented. subok is validated, but only the native array class
exists. Earlier blocked states and deliberate differences remain separate.
