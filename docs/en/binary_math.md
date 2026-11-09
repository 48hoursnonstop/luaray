# Binary mathematics and input coercion

LuaRay 0.109.0-dev adds native `fmod` and `float_power`, broadens ordinary Lua
inputs to existing binary calls, and implements fixed-width string addition
and source-derived boolean promotion. These run in Lua/C/C++ without Python.

## Remainders and powers

```lua
local np = require('luaray')
assert(np.fmod(-5, 3):tolist() == -2)
assert(np.remainder(-5, 3):tolist() == 1)
assert(np.float_power(2, -3):tolist() == 0.125)
local huge = np.float_power(np.array({2}, 'int8'), 300)
assert(huge.dtype == 'float64') -- promotes before converting the exponent
```

`fmod(a,b)` retains the sign of the dividend. Integer division by zero and
minimum-signed-integer modulo -1 produce zero without invoking undefined C
division. Half computes in float32; float32, float64 and longdouble use their
corresponding native fmod functions. Complex/string/time inputs have no fmod
signature. Bool inputs resolve to an integer loop. Mixed numeric inputs choose
the first signature that safely accepts both types.

`float_power(a,b)` always computes at least in float64 or complex128, preserving
longdouble/clongdouble when needed. It supports negative integer exponents.
Weak Lua scalars preserve their default precision until this forced signature
is resolved, so an int8 input does not make exponent 300 overflow prematurely.
Negative real bases with fractional powers produce NaN; supply an explicitly
complex input for a complex result. Existing native power/complex kernels are
shared, with separate signature resolution from integer-preserving `power`.

## Ordinary Lua inputs

```lua
local sum = np.add({1,2,3}, 2) -- {3,4,5}
local broadcast = np.multiply({{1},{2}}, {10,20,30}) -- shape {2,3}
local scalar = np.add(1, 2) -- typed int64 rank-zero ndarray
print(scalar:tolist()) -- 3

local out = np.full({3}, 99, 'float64')
assert(rawequal(np.fmod({5,6,7}, 3, {
  out=out, where=np.array({true,false,true}),
}), out)) -- {2,99,1}
```

Existing binary arithmetic, comparison, logical, bitwise, extrema, copysign,
arctan2 and hypot entry points now accept scalars and rectangular Lua tables.
Two ordinary scalars materialize as their natural typed rank-zero arrays.
Tables materialize through the existing constructor. An ordinary scalar paired
with a table/ndarray keeps weak scalar resolution; an explicit rank-zero
ndarray retains its strong dtype. Constructor limitations still apply, including
incomplete nested ndarray/foreign-object and string-to-numeric table coercion.

Options are parsed before allocating temporary operands on the Lua stack.
Two non-nil operands are required. `operation(a,b,{out=...,where=...})` and
`operation(a,b,out,where)` use the same broadcast/mask/writeback path. Output
shape must match the broadcast result exactly; it must be writable and permit
`same_kind` output casting. Existing output identity is retained. Masked-off
output values retain their contents. Without output, masked-off contents are
uninitialized. Overlapping input/output views are evaluated through safe staging.

## Fixed-width strings

```lua
assert(np.add('λ', '🙂'):tolist() == 'λ🙂')
local a = np.array({'a\0b', 'x\0'}, 'S4')
local b = np.array({'c', 'y'}, 'S4')
local c = np.add(a, b) -- |S8: {'a\0bc', 'xy'}
```

Addition has native S+S and U+U signatures. The result descriptor reserves the
sum of declared input widths; the actual contents concatenate after trimming
trailing zero padding from each input. Embedded NUL values are preserved.
Unicode loops canonicalize byte order before iteration. Narrower explicit
outputs truncate through normal string casts. Sum lengths exceeding INT_MAX
bytes are rejected during descriptor resolution, including for empty arrays.
Mixed S/U and numeric/string addition are rejected. Variable StringDType is
not implemented. Lua strings normally become Unicode; a weak Lua string paired
with an explicit S/U array follows that array's class. Lua does not provide
separate Python-style str and bytes scalar classes here; use an explicit dtype
when raw byte semantics matter. Output casts can still fail, for example an
ASCII-only S-to-U conversion containing a non-ASCII byte.

## Logical promotion

NumPy's binary logical promoter converts supported inputs to bool before
calculation. This differs from rounding a weak scalar in the other operand's
floating dtype: `logical_and(float16_array, 1e-100)` must see a true scalar.
LuaRay now preserves that truth value, including tiny imaginary components.
Fixed-width strings use their nonempty stored contents, not numeric parsing:
`'0'` and `'False'` are true, an empty string is false. This describes binary
logical operations; unary logical_not has its own supported signatures.

## Verification and remaining scope

Original NumPy 2.5.3 references cover **4,986 cases / 514,816 checks**:
fmod 1,428 / 189,111; float_power 1,428 / 205,745; binary coercion 784 / 18,244;
string addition and boolean promotion 1,346 / 101,716. Values, metadata, errors,
output identity, source/backing mutations, layouts, masks, shared outputs,
integer extremes, special values, Unicode, byte order, padding and width overflow
are checked. Fmod/coercion/string values compare exactly. General float_power,
power, arctan2 and hypot comparisons allow relative error 2e-12; observed maximum
relative error was about 3.23e-15 (absolute 3.20e-14) in float_power.

Native C boundary tests and 303 directed Lua checks also passed. All functions
remain `implemented_partial`. Full dtype/casting/order/device/subclass protocols,
ufunc objects/methods, warning categories, FP status and nondefault rounding
modes are incomplete. Scalar results deliberately remain typed ndarrays. These
measurements are scoped compatibility evidence, not overall NumPy completion.

```sh
make -j4 full-test
make reference-test
```

See [unary mathematics](unary_math.md), [creation](creation.md) and the
[availability inventory](api_inventory.md). Source hashes are recorded in
[pinned source hashes](../../compatibility/numpy-source.sha256); existing NumPy BSD attribution remains.
