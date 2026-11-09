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
NaT sentinel. Integer division, duration ratios and complete temporal arithmetic
remain unsupported.

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

## Compatibility

Floating scaling has been available since **0.113.0-dev**; integer multiplication
since **0.125.0-dev**. Tests cover native values, units, NaT, broadcasting, typed and
ordinary coefficients, masks, output identity, reversed views, overflow writeback
and the 8192-element iterator boundary. Foreign scalar classes, exact Python
exceptions/warnings, all possible buffer layouts and non-x86 floating conversion
behavior remain uncertified. See [validation](development/validation.md).
