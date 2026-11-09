# Clipping values

LuaRay 0.114.0-dev implements `np.clip(a, lower, upper, options)` and
`a:clip(lower, upper, options)` with a native fused, three-input uniform kernel.
A missing or `nil` bound is open. The options table supports `out` and `where`;
alternatively pass the output ndarray directly, followed by an optional mask.
Unknown options and embedded-NUL option names raise errors. Ordinary Lua inputs
use the existing constructor; scalar results are typed rank-zero ndarrays.

```lua
local np = require('luaray')
local a = np.array({-2, 0, 4}, 'float32')
assert(np.clip(a, 0, 3):tolist()[3] == 3)
local out = np.full({3}, 7, 'float32')
assert(rawequal(a:clip(nil, 2, {
  out = out, where = np.array({true, false, true})
}), out))
assert(out:tolist()[2] == 7)
```

All inputs broadcast together. Supplied output must match the result shape,
be writable and accept the computed dtype with `same_kind` casting. Masks must
be boolean ndarrays (or scalar number/boolean); masked-out output values remain.
Overlapping input/output/bound views are staged by the shared iterator. Reversed,
transposed, Fortran and broadcast inputs retain their logical values.

Integer inputs remove weak integer lower bounds at or below the dtype minimum,
and upper bounds at or above its maximum, before dtype resolution. Strong typed
bounds do not receive this shortcut. Thus clipping uint8 with Lua limits -999
and 999 preserves uint8, whereas strong int8 limits can promote it. All strong
descriptors and weak scalar kinds resolve before actual scalar packing: a second
floating bound can prevent an integer overflow. Remaining out-of-range weak
integers raise even for empty inputs.

The supported uniform signatures cover bool, fixed integers, half/float/double/
long double, all three complex widths and datetime/timedelta. Temporal metadata
uses the common descriptor; compatible integer/timedelta combinations preserve
units, and NaT propagates. Incompatible date/time or nonlinear units raise. The
shared minimum/maximum/fmin/fmax temporal resolver now also accepts compatible
strong integer/timedelta operands. Integer time scaling remains separate work.

One open bound delegates to minimum or maximum. Two open bounds delegate to
positive: boolean and datetime positive still raise. Reversed finite limits
follow the actual kernel, typically producing the upper bound.

## NaN, signed zero and buffering

This is not two independently resolved maximum/minimum calls. The fused kernel
resolves one dtype for all three operands. Floating scalar-bound loops use strict
comparisons, preserving input signed zero on ties; generic floating loops select
the second operand on ties. Half comparisons retain the first on ties, and
complex comparisons use the source's lexicographic ordering and NaN propagation.

NumPy's iterator may convert or expand a broadcast bound to a dense buffer and
thereby select the generic loop. The uniform iterator has a source-derived
non-reduction buffer cost plan with the reference's default 8192-element limit;
physical traversal remains in bounded rows. A converted globally constant input
retains stride zero. Tests include the cost changes around 4096 and 8192, casts,
Fortran/reversed layouts, masks and aliasing. This planner is currently selected
for the fused clip kernel; it does not declare every other iterator behavior
complete. Python `setbufsize`, custom floating modes and all host layouts remain
outside the verified contract.

## Current limits

This Lua interface accepts positional lower/upper limits, not Python keyword
aliases `a_min`, `a_max`, `min` or `max`. Ufunc `dtype`, `casting`, `order`,
`signature`, `subok` and device/custom dispatch are not accepted by this binding.
Object, structured and variable-width StringDType arrays are unavailable; fixed
strings have no clip signature. Non-native numeric endian remains unsupported.
Warnings, exception classes, NaN payloads, foreign DTypes and every architecture
are not certified. See the measured records in `compatibility/` and
[validation results](../development/validation.md); a callable binding does not imply full API compatibility.
