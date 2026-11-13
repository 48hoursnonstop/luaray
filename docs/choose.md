# Selecting between arrays: choose

LuaRay 0.102.0-dev implements `lr.choose` and `ndarray:choose` through a native
C subsystem. Choices and selectors broadcast together; runtime uses no Python.

```lua
local lr = require('luaray')
local selector = lr.array({1,2,1}, 'int64')
local a = lr.choose(selector, {{10,11,12},{20,21,22}})
-- {10,21,12}
local b = selector:choose({10,20}) -- {10,20,10}
```

## Arguments and modes

`lr.choose(selector, choices [, mode_or_options])` and
`selector:choose(choices [, mode_or_options])` accept a mode string or a table
with `mode` and `out`. The default is raise. Choices are a sequence of 1–63
arrays/scalars, or an ndarray whose first axis enumerates the choices.
Every choice and the selector must broadcast to one common shape.

Positive choice positions start at **1**. Zero is invalid when traversed.
In raise mode, **negative selectors are invalid**, following NumPy choose.
Wrap mode reduces translated selectors modulo the number of choices; clip
mode clamps them to the first/last choice. Negative wrap selects from the end;
negative clip selects the first. These rules differ from take's raise mode.

Selectors are first inferred as arrays, then safely converted to native signed
pointer-width integers. Floating, complex, string and uint64 selector arrays
are rejected even if their values look like small integers. Integer Lua tables
are supported; an untyped empty table retains its usual inferred dtype.

Choices resolve a common dtype, then become writable, aligned, C-contiguous
arrays. Numeric Lua scalars participate as weak types. Their subsequent
conversion follows NumPy choose's array conversion: for example, combining a
uint8 choice array with Lua integer 300 retains uint8 and converts 300 to 44.
This differs from direct put-value overflow checking. Strong typed arrays
participate through their full descriptors. Weak numeric/string or datetime
promotion errors and actual conversion failures are included in the corpus.

Without out, a non-scalar result is a fresh C-contiguous ndarray. A scalar
result uses the existing Lua numeric/boolean/string/complex/temporal form.
With out, the same ndarray is returned, including zero-dimensional outputs.

## Output and shared storage

Out must be writable and match the broadcast result shape exactly. Raise mode,
choice/output overlap and a different output dtype use a temporary result.
Unlike take, choose does **not** preconvert the old output values. Cast-back
can still fail after updating earlier elements or buffers. Compatible direct
output in wrap/clip can alter later live selector values; original shared
negative-coordinate cases verify this behavior.

NumPy 2.5.3 directly increments the output data pointer in wrap/clip even when
out has noncontiguous strides. LuaRay preserves that observable behavior **when
the raw span fits in the owning buffer**. Thus cells outside the logical view
can change. In raise mode, staged writeback respects the view's strides.
Use a contiguous out for ordinary direct-output behavior.

The native implementation rejects a direct raw span that would exceed the
owning allocation. Reversed views near the buffer end and writable zero-stride
views can trigger this guard. Two variants, each tested in wrap/clip, are
retained separately from parity. Unsafe upstream memory-corrupting calls were
**not executed**. In-bounds strided, transposed and reversed output states were
executed upstream and compared exactly. A borrowed C output without ownership
metadata also cannot use this unchecked direct path.

## Temporal string conversion corrections

The choose audit exposed shared datetime conversion defects. Fixed-width date
strings now error when ISO formatting cannot fit, instead of silently
truncating. Direct ASCII casts preserve NumPy's failed-cell prefix; Unicode
casts stage 128-element blocks and leave the current block unchanged on error.
Tests cover NaT, 12 date units, width boundaries and 127/128/129.
The observed Linux year-only equal-capacity snprintf result is retained.
Unsafe datetime-to-timedelta and reverse conversions preserve integer ticks;
unit scaling applies within the same temporal kind.

## Evidence and limitations

The original audit covered a native C suite, **69 Lua checks** (including guarded
variants outside parity) and **3,481 NumPy 2.5.3 cases / 101,519 checks**.
Fixtures verify values, shape, strides, dtype, output identity and backing states
after errors. Run `make full-test` for maintained regressions and
`make reference-test` for the frozen corpus. See [validation](development/validation.md)
for external reference tooling and the scope of historical sanitizer audits.

Extreme native wrap tests use mathematical modulo; upstream repeated-subtraction
loops were not executed for those huge values. Object/structured/variable-width
string dtypes, non-native numeric endian, exact Python warnings/exceptions and
all NumPy parity remain incomplete. Earlier blocked endian states and take's
hang rejection remain recorded separately. This is not an overall completion
percentage.
