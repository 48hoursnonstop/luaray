# Decimal rounding

LuaRay 0.113.0-dev implements `np.round`, `np.around` and `a:round` from
NumPy 2.5.3 calculation.c. It uses the actual typed multiply/rint/divide
composition rather than a host-language scalar rounding approximation.

```lua
local np = require('luaray')
local a = np.array({1.25, 2.5}, 'float32')
local r = a:round(1)
local out = np.empty({2}, 'float64')
assert(rawequal(np.round(a, {decimals=1, out=out}), out))
assert(np.round({15,25}, -1):tolist()[2] == 20)
```

Accepted forms are `np.round(input, decimals, out)`,
`np.round(input, {decimals=...,out=...})`, and the equivalent ndarray method.
Decimals default to zero and must be a Lua integer within the native C int
range; booleans are also accepted as 0/1. Ordinary Lua inputs use the existing
constructor. Scalar outputs remain typed rank-zero ndarrays. Unknown options,
binary-NUL keys and duplicate output arguments raise Lua errors.

For nonnegative decimals, integer inputs copy without arithmetic; they retain
every bit even beyond floating precision. With output, same-kind assignment is
used. A readonly integer array can be its own identical output because no write
is necessary. Default outputs are independent and writable.

Zero-decimal real floating rounding uses rint, including ties to even under the
default rounding mode. Bool is not an integer dtype here: zero-decimal bool
rounding without output produces float16, while other decimal counts can fail
their output casting rule. Negative-decimal integer rounding uses the source's
float64 working array, then casts back; it is not exact integer arithmetic.

For other decimal counts, the first operation computes at its resolved input
precision and writes to `out`; rint and the final operation then work on that
output dtype. A wider output can therefore change intermediate precision.
Complex input is handled differently: each component is rounded independently
at input component precision, then assigned to the destination component.
The new component and scaling engines are shared with ordinary public calls.

The power-of-ten factor reproduces the source's double-precision multiplication
order. Once its exponent reaches 309 the value is positive infinity; LuaRay
returns that stabilized result directly, avoiding the upstream linear loop
for INT_MIN/MAX decimal counts. Bounded source factors and native integer
extremes are tested separately; billion-step upstream calls were not executed.

## Errors and partial output

Output must have the same element count initially; subsequent assignment or
ufunc rules still enforce compatible shapes and casting. NumPy can modify
output before a later stage fails. For complex input with a noncomplex output,
the real component may be written before setting the imaginary part fails.

The root functions also preserve fromnumeric.py's retry: a TypeError from an
existing ndarray method triggers one `_wrapit` retry. The ndarray method itself
does not retry. For example:

```lua
local td = np.array({1}, 'timedelta64[h]')
assert(not pcall(np.round, td, 1, td))
assert(np.astype(td, 'int64'):tolist()[1] == 100) -- two partial multiplications
local once = np.array({1}, 'timedelta64[h]')
assert(not pcall(function() once:round(1, once) end))
assert(np.astype(once, 'int64'):tolist()[1] == 10)
```

Internal error categories distinguish the retry-relevant failures; the Lua API
still raises ordinary Lua errors, not Python exception objects. `ln_error` gained
an internal category field in this development release, so rebuild all native
objects when updating source. Release archives are verified from clean builds.

## Floating timedelta scaling

Round exposed a missing prerequisite: timedelta multiplied/divided by floating
numbers. Native m*d, d*m and m/d signatures now compute in double, preserve
temporal units, truncate finite ticks, propagate NaT and preserve masks/output
conversions. Float16/32/64/longdouble coefficients follow the source double loop.
Integer timedelta scaling, timedelta ratios and complete temporal arithmetic
remain unimplemented; they are not approximated through a floating signature.
Out-of-range double-to-tick NaT results were audited on x86; other ABIs need
separate certification.

## Executed scope

Original NumPy 2.5.3 references: rounding **2,780 cases /141,112 checks**;
rounding output **2,346 /189,964**; floating time scaling **3,100 /150,416**.
Total **8,226 /481,492 exact checks**, including signed zero, C/F/strided/
reversed/broadcast layouts, all scoped numeric precisions, temporal units,
NaN/Inf, output identities, aliases and real post-error backing states.
Native C tests and 42 directed Lua checks also passed.

Complete subclass/device/foreign-array protocols, all Python argument forms,
floating warnings/rounding modes, every ABI and full temporal arithmetic remain
incomplete. Callable availability does not imply full behavioral parity.

```sh
make round113-test CXXFLAGS='-O0 -g -std=c++11 -Wall -Wextra -Wpedantic'
make full-test CXXFLAGS='-O0 -g -std=c++11 -Wall -Wextra -Wpedantic'
make sanitize-round113
```

Nine source/test hashes: `NUMPY_2_5_3_ROUND113_FILE_HASHES.sha256`. See
[unary math](unary_math.md), [component views](components.md),
[casting/creation](creation.md) and [API inventory](api_inventory.md).
