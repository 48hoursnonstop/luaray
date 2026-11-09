# Reality predicates and real_if_close

LuaRay 0.112.0-dev implements five NumPy 2.5.3 functions natively, building on
the component views and shared dtype/ufunc engine. Python is a development
oracle only.

```lua
local np = require('luaray')
local z = np.array({np.complex(1,0), np.complex(2,1)}, 'complex64')
local real_elements = np.isreal(z) -- {true,false}
local complex_elements = np.iscomplex(z) -- {false,true}
assert(np.iscomplexobj(z)) -- checks dtype, even if every imag value were zero
assert(not np.isrealobj(z))
local near = np.array({np.complex(1,1e-6)}, 'complex64')
local r = np.real_if_close(near) -- float32 component view
np.copyto(r, 7, 'unsafe') -- changes the real part of near
```

| Function | Contract |
| --- | --- |
| `iscomplex(a)` | Imaginary component differs from zero; noncomplex inputs produce C-order false arrays |
| `isreal(a)` | Imaginary component equals zero; real noncomplex input follows its C/F imaginary-zero layout |
| `iscomplexobj(a)` | Lua boolean indicating a complex dtype, independent of values |
| `isrealobj(a)` | Lua boolean indicating a noncomplex dtype |
| `real_if_close(a, tol)` | Return a real component view if every imaginary magnitude is strictly below the threshold; otherwise retain the input identity |

Value predicates produce independent writable bool arrays; scalar results follow
LuaRay's typed rank-zero ndarray convention. NaN imaginary values are complex;
a NaN real component with zero imaginary component is real for these predicates.
Following NumPy, strings and datetime produce false isreal results, while
timedelta produces true. These functions do not replace isfinite checks.

`real_if_close` defaults to tolerance 100. Tolerances greater than one are
multiplied by the component dtype's machine epsilon; tolerances at most one are
absolute. Conversion to component precision happens before multiplication and
comparison. The comparison is strict, so equality at the threshold does not
convert. Empty complex arrays convert even with negative/NaN tolerance because
the all-reduction is vacuously true. NaN or infinite imaginary values prevent
conversion with a finite threshold; infinity is not less than an infinite
threshold. Real inputs return unchanged before inspecting tolerance.

Lua numeric/integer/boolean tolerances are supported; nil means the default.
Array-valued tolerances, full subclass/device/foreign-array protocols, object
and structured dtypes, all warning/FP status behavior and every ABI remain
uncertified or unsupported. Views preserve source writeability and ownership.

## Complex string conversion correction

The legacy Lua astype API exposes ndarray.astype string conversions. NumPy's
arraytypes.c constructs a two-double complex value first, including when the
destination is clongdouble. LuaRay now follows that precision, accepts valid
underflow/overflow results, signed unit imaginary forms such as `1-j`, and
surrounding parenthesis whitespace. It rejects malformed underscores, C-only
hex/nan-payload syntax and embedded NUL in nonboolean numeric strings. Bool
casts still use nonempty stored contents. Complete Unicode decimal/whitespace
grammar and locale-independent parsing remain pending; NumPy's root numeric-only
Array API astype signature is not claimed by this legacy Lua extension.

The closeness references construct exact x87 imaginary values through native
ldexp, stack and component writes. Decimal complex strings cannot preserve such
references because upstream itself rounds those strings through complex128.

Original NumPy 2.5.3 evidence: predicates **2,652 cases /158,028 checks**;
closeness **4,170 /313,989**; text conversion **612 /6,699**. Combined
**7,434 /478,716 exact checks**, including nextafter boundaries, fifteen dtypes,
layouts, empty arrays, NaN/Inf, ownership, identity and actual writes. Native C
and 53 directed Lua checks also passed. All APIs remain implemented_partial.

```sh
make -j4 full-test
make reference-test
```

Six source/test hashes: [pinned source hashes](../../compatibility/numpy-source.sha256).
See [component views](components.md), [layout](layout.md) and
[API availability](api_inventory.md).
