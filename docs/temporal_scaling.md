---
docs_examples: true
---
# Scale durations

Multiply `timedelta64` arrays by integer or floating coefficients. The result
keeps the duration unit. Integer coefficients use exact int64 arithmetic;
floating coefficients compute in double and truncate finite ticks.

## Integer multiplication

```lua
local lr = require("luaray")
local hours = lr.array({1, 2, 3}, "timedelta64[h]")
local doubled = lr.multiply(hours, 2)
assert(doubled.dtype == "timedelta64[h]")
assert(lr.astype(doubled, "int64")[3] == 6)
```

Both operand orders are supported. Boolean and signed/unsigned integer arrays
resolve to the int64 coefficient signature. uint64 coefficients are cast to int64,
including its wrap convention. A coefficient is an integer, so an int64 value
whose bits equal the NaT sentinel is not itself treated as a missing duration.
A NaT **duration** propagates unchanged, including when multiplied by zero.

## Floating multiplication and division

```lua
local fractional = lr.multiply(hours, 0.5)
assert(lr.astype(fractional, "int64")[1] == 0)
assert(lr.astype(fractional, "int64")[3] == 1)
local divided = lr.true_divide(hours, 2.0)
assert(lr.astype(divided, "int64")[2] == 1)
```

Float16/32/64/longdouble coefficients use the upstream double loop. An out-of-range
or nonfinite floating result becomes NaT on the audited x86 platform. This differs
from integer multiplication, which raises on overflow or a product equal to the
NaT sentinel. Complete temporal arithmetic remains partially implemented.

## Integer division and duration ratios

```lua
local ticks = lr.array({7, -7}, "timedelta64[h]")
local quotient = lr.true_divide(ticks, 2)
assert(lr.astype(quotient, "int64")[1] == 3)
assert(lr.astype(quotient, "int64")[2] == -3)
local ratio = lr.true_divide(lr.array({1, 2}, "timedelta64[D]"),
  lr.array({12, 24}, "timedelta64[h]"))
assert(ratio.dtype == "float64" and ratio[1] == 2 and ratio[2] == 2)
```

Since **0.129.0-dev**, integer divisors use exact int64 division, truncating toward
zero without converting ticks to double. NaT input or a zero integer divisor
produces NaT. Boolean and complex divisors are rejected. Unsigned divisors follow
the reference's int64 conversion rules.

Dividing two durations first converts both to a common unit, then computes a
float64 ratio. NaT produces NaN; zero denominators give IEEE infinity or NaN.
Incompatible calendar/fixed units raise. Broadcasting, output masks and aliased
float64 output views are supported. Unit conversions retain their checked bounds.

## Masks and outputs

```lua
local out = lr.full({3}, 99, "timedelta64[h]")
assert(rawequal(lr.multiply(hours, 3, {
  out=out, where=lr.array({true, false, true}, "bool"),
}), out))
assert(lr.astype(out, "int64")[1] == 3)
assert(lr.astype(out, "int64")[2] == 99)
assert(lr.astype(out, "int64")[3] == 9)
```

Output units are converted after multiplication. Unit conversion checks the
reference's int64 intermediate multiplication and negative floor-adjustment bounds,
so even a mathematically representable quotient can raise if an intermediate
would overflow. Masks exclude false positions from writes and overflow checks.

## Output state after an error

An integer multiplication error can occur after valid writes. Unmasked operations
preserve the completed prefix in traversal order. Negative in-place views can
traverse physical storage forward, which reverses the logical prefix.
Masked legacy loops can continue with later groups of true mask elements after
an earlier group overflows. Do not assume an operation that raises left `out` untouched.

The NumPy 2.5.3 reference can flush uninitialized output-buffer suffixes when an
integer loop fails and the output also converts units. Repeated real runs produced
different suffix values and sometimes different overflow messages. LuaRay preserves
unwritten output cells. Those cases compare only the defined prefix and metadata;
full compatibility for the undefined suffix is not claimed.

## Integer offsets and partial writes

```lua
local dates = lr.array({0, 1}, "datetime64[D]")
local shifted = lr.add(dates, 2)
assert(lr.astype(shifted, "int64")[2] == 3)
```

Since **0.134.0-dev**, integer addition/subtraction uses ticks of the temporal
unit. Boolean, signed and unsigned integers are supported in arithmetic. Addition
accepts both orders; integer minus datetime is rejected, while integer minus
timedelta is supported. Uint64 can participate in arithmetic even though its
comparison signature is unsupported. NaT propagates. If addition/subtraction
overflows, completed elements and mask runs are preserved before the error;
the operation is not atomic.

Since **0.135.0-dev**, datetime casts involving years/months pass through the
calendar rather than average duration scaling. Negative years, leap boundaries,
metadata multipliers and source integer wrap rules are covered by direct
conversion references. Duration casts keep their separate average-unit rules.

## Compatibility

Floating scaling has been available since **0.113.0-dev**; integer multiplication
since **0.125.0-dev**. Tests cover native values, units, NaT, broadcasting, typed and
ordinary coefficients, masks, output identity, reversed views, overflow writeback
and the 8192-element iterator boundary. Foreign scalar classes, exact Python
exceptions/warnings, all possible buffer layouts and non-x86 floating conversion
behavior remain uncertified. See [validation](development/validation.md).
