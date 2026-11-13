# Conditional values: where and select

LuaRay 0.104.0-dev adds native `lr.where` and `lr.select`. Where uses the existing
generalized ndarray iterator; select combines separate broadcasting groups and
masked assignment. Neither executes Python at runtime.

```lua
local lr = require('luaray')
local a = lr.array({{1,2,3},{4,5,6}}, 'int32')
local result = lr.where(lr.greater(a,3), a, 0)
-- {{0,0,0},{4,5,6}}
local piecewise = lr.select({lr.less(a,3), lr.greater(a,4)}, {-1,9}, 0)
-- {{-1,-1,0},{0,9,9}}
```

## where

`lr.where(condition, x, y)` broadcasts the three operands and returns a new
ndarray. The dtype is resolved from x/y using supported strong/weak promotion.
Numeric Lua scalars are weak; typed arrays retain their descriptors. Weak values
are packed into the resolved dtype with its scalar overflow checks. A uint8
array paired with Lua integer 300 raises an overflow error; using a strong
int64 array for 300 instead promotes the output to int64.

Conditions accept supported array truth conversion: zero/empty strings are
false, nonzero/nonempty strings and NaN are true. Output allocation follows
KEEPORDER across all operands, including unselected ones. F-order inputs can
produce F-order output; conflicting operand orders resolve in C order. Inputs
remain unchanged. Even an all-scalar call returns a **zero-dimensional ndarray**;
use `lr.where(true,1,2):get()` to read its value.

`lr.where(condition)` returns the same Lua table of one-based coordinate arrays
as [nonzero](condition_selection.md). A scalar condition is invalid for this
unary form. Supplying exactly two operands is an error.

The source distinguishes conversion paths by common element size. At widths
1/2/4/8/16 bytes, both values are converted through iterator buffers before
selection. Other widths convert only the chosen value. For example, an
unselected invalid ASCII byte in an S1 operand can succeed with a U3 result
(12 bytes) but fail with U4 (16 bytes). Original references retain this behavior.

## select

`lr.select(conditions, choices [, default])` requires equal, nonempty sequences.
A sequence may be a Lua table or an ndarray whose first axis enumerates its
items. Conditions must be boolean arrays/scalars; numeric arrays are rejected.
Choices/default determine a common dtype with supported weak scalar promotion.
Default is Lua integer zero when omitted.

Conditions broadcast together, while choices and default broadcast as a second
group. Those shapes then broadcast into the output shape. Output is a new
C-contiguous ndarray, including zero-dimensional results. It is filled from the
default before choices are copied in reverse order, preserving **first matching
condition wins**. Broadcasting handles condition counts beyond the legacy
64-operand iterator limit through shape batches; 128 conditions are executed.

Choice/default conversion retains the source's distinction: default filling uses
unsafe conversion, and each choice uses same_kind masked assignment after
broadcasting. Thus a uint8 choice with default 300 can fill with 44. A weak
integer choice that becomes a signed int64 array can fail same_kind assignment
into uint8, even when its condition is false. Separate group broadcasting also
preserves whether a source remains scalar and is converted eagerly. The tests
cover actual errors, including unselected values and fixed-string ASCII failures.

Weak numeric values combined with string/datetime choices can raise promotion
errors. For string choices, supply a compatible explicit default. General
object/structured dtype promotion is not implemented.

## Shared corrections and evidence

The audit corrected uint64/timedelta common-type promotion: those strong dtypes
now raise, matching upstream. Ndarray sequence iteration preserves scalar items
as strong 0-D views, including one-dimensional ndarray choices in choose.
All 3,481 previous choose cases still pass.

The original audit covered a C suite, **65 Lua checks** and two original
NumPy 2.5.3 corpora: **1,487 where cases / 59,988 checks**, and **1,961 select
cases / 19,688 checks**, total **3,448 / 79,676**. They include dtype pairs,
weak values, layout/strides, shape errors, binary strings, scalar ndarray
identity and multi-condition precedence.

Run `make full-test` for maintained C/Lua regressions and `make reference-test`
for the external frozen corpus. Both run without Python. See
[validation](development/validation.md) for the original generators and
historical sanitizer scope.

The [API inventory](api_inventory.md) separately measures callable availability.
Object/structured/variable-width string arrays, non-native numeric endian,
subclasses, full Python exception/warning fidelity and complete NumPy parity
remain incomplete. Earlier explicit differences and blocked states remain.
