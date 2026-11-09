# Unary mathematics

LuaRay 0.108.0-dev implements these NumPy 2.5.3 operations through a separate
native registry and the shared dtype, broadcasting and iterator engine.
Python is not a runtime dependency.

| Operation | Meaning | Accepted numeric loop families |
| --- | --- | --- |
| `floor(x)` | Round toward negative infinity | Bool, integers, real floats |
| `ceil(x)` | Round toward positive infinity | Bool, integers, real floats |
| `trunc(x)` | Discard the fractional part | Bool, integers, real floats |
| `rint(x)` | Round to the nearest integer, ties to even under default rounding | Real and complex floats |
| `fabs(x)` | Real absolute value | Real floats |
| `conjugate(x)`, `conj(x)` | Negate the imaginary component | Integers, real and complex floats |
| `square(x)` | Multiply by itself | Integers, real and complex floats |
| `reciprocal(x)` | Compute one divided by the input | Integers, real and complex floats |
| `degrees(x)`, `rad2deg(x)` | Convert radians to degrees | Real floats |
| `radians(x)`, `deg2rad(x)` | Convert degrees to radians | Real floats |

Numeric inputs without an exact registered signature safely cast to the first
matching loop. For example, `conjugate(bool)` and `square(bool)` use int8;
`rint(int8)` uses float16, while `rint(int64)` uses float64. Floor, ceil and
trunc preserve integer and bool dtypes, including values beyond float precision.
Complex input is rejected when the operation has no complex loop. Strings,
datetime/timedelta, object and structured arrays have no registered loop here.

## Calling from Lua

```lua
local np = require('luaray')
local values = np.array({-2.5, -0.5, 0.5, 2.5}, 'float32')
local rounded = np.rint(values) -- {-2, -0, 0, 2}, float32
local angles = np.deg2rad({0, 90, 180})
local scalar = np.square(3) -- typed 0-D ndarray, int64 value 9
print(scalar:tolist())

local out = np.full({4}, 99, 'float64')
local same = np.ceil(values, {
  out = out,
  where = np.array({true, false, true, false}, 'bool'),
})
assert(rawequal(same, out)) -- {-2, 99, 1, 99}
```

All operations take `operation(input, {out=..., where=...})`. The existing
`operation(input, output_array, where)` form also works. Output must have the
exact broadcast result shape, be writable and permit a `same_kind` output cast.
Masks must have bool dtype and broadcast to the result. Masked-off positions
retain their previous output values. Without `out`, masked-off values are
uninitialized and must not be relied on. Overlapping views are evaluated through
safe temporary output and writeback; input and backing-array states are tested.

The shared unary entry point now accepts ordinary Lua numbers, booleans,
complex values and rectangular tables for existing operations such as sin,
sqrt and isnan too. Coercion follows `np.array` and retains its limitations.
Options are parsed before coercion pushes temporary arrays onto the Lua stack.
Results remain typed ndarrays, including rank-zero inputs; unlike NumPy's
scalar return objects, they preserve their dtype explicitly inside the Lua API.

## Precision and boundaries

Float16 arithmetic computes in float32 and rounds once to half. Float32,
float64 and longdouble retain their corresponding computation precision.
Angle constants are rounded at that precision before multiplication.
Integer square uses unsigned modular arithmetic rather than C signed-overflow
behavior. Integer reciprocals truncate: ±1 retain their reciprocal and other
nonzero values return zero. For zero, the audited x86 NumPy loops yield the
minimum signed value for int32/int64, and zero for smaller signed or unsigned
types. LuaRay implements those results explicitly without undefined infinity
to integer conversions. Other ABIs require separate verification.

Complex square follows NumPy's FMA product ordering on eligible FMA hosts and
uses the scalar formula otherwise. Iteration traverses the physical KEEPORDER
axis permutation; a Fortran array therefore follows its contiguous axis too.
Complex reciprocal uses the source's scaled real/imaginary formula. Signed
zero, NaN and infinities are checked separately. NumPy warning categories and
floating status/errstate APIs are not fully reproduced. Nondefault process
rounding modes, every CPU dispatch choice, endian layout and longdouble ABI
are not certified.

## Verification and scope

Three original NumPy 2.5.3 fixture files cover **5,589 cases / 501,064 checks**:
rounding 2,135 / 176,894; algebra 1,746 / 186,658; angles 1,708 / 137,512.
They check values, dtypes, shapes, strides, output identity, acceptance and actual
source/backing writes for C/F/transposed/reversed/strided/broadcast layouts,
zero-dimensional and empty inputs, masks, overlapping and read-only outputs,
integer extremes and sampled half bit patterns. Observed numeric error was zero.
All values compare exactly except general complex square/reciprocal cases,
which allow relative error 6e-7 for complex64 and 2e-15 for wider complex types.
The 38 additional FMA layout/writeback cases require exact agreement.

Native C boundary tests and 358 directed Lua checks cover invalid shapes,
read-only outputs, masks and coercion through the existing unary operations.
These measurements are behavioral evidence within that scope. All functions
remain `implemented_partial`; complete ufunc objects/methods, positional NumPy
keywords, device/subclass protocols, warnings and every dtype combination are
not implemented. Aliases provide equivalent calls, not NumPy ufunc identity.

```sh
make -j4 full-test
make reference-test
```

Source hashes: [pinned source hashes](https://github.com/48hoursnonstop/luaray/blob/main/compatibility/numpy-source.sha256). See
[API inventory](api_inventory.md), [creation](creation.md) and
[sampling](sampling.md) for related contracts.
