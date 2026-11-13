---
docs_examples: true
---
# Date and duration ranges

From **0.144.0-dev**, `lr.arange` constructs datetime64 and timedelta64 ranges
using native unit resolution and calendar conversion. A range owns its output
and excludes the stopping value.

## Walk through calendar dates

```lua
local lr = require("luaray")
local dates = lr.arange("2020-02-28", "2020-03-02", {dtype="datetime64[D]"})
local labels = lr.datetime_as_string(dates)
assert(dates.size == 3)
assert(labels[1] == "2020-02-28" and labels[2] == "2020-02-29")
assert(labels[3] == "2020-03-01")
```

A temporal dtype selects the temporal engine. Without an explicit dtype,
temporal arguments select it; ISO strings alone require a temporal dtype.
Date ranges require both start and stop. A concrete dtype
fixes the output unit and multiplier. A generic datetime/timedelta dtype keeps
its class while detecting units from the arguments. Integers used as dates
require a concrete unit when they are converted.

```lua
local months = lr.arange(
  lr.datetime64("2020-01"), lr.datetime64("2020-06"), lr.timedelta64(2, "M")
)
assert(months.dtype == "datetime64[M]" and months.size == 3)
assert(lr.datetime_as_string(months)[2] == "2020-03")
```

Units `Y` and `M` describe calendar years and months. Other units range from
weeks to attoseconds. An explicit dtype converts each argument with the source's
same-kind rules before calculating the tick count. Without a concrete dtype,
the engine resolves a common unit across the arguments. A datetime cannot be
used as a step. Mixing nonlinear duration units with linear units can raise an
error even when all arguments are temporal.

## Choose a duration step

```lua
local durations = lr.arange(
  lr.timedelta64(0, "h"), lr.timedelta64(3, "h"), lr.timedelta64(30, "m")
)
local ticks = lr.astype(durations, "int64")
assert(durations.dtype == "timedelta64[m]" and durations.size == 6)
assert(ticks[1] == 0 and ticks[2] == 30 and ticks[6] == 150)
```

The default step is one tick of the resolved unit. A single duration argument
starts at zero; `lr.arange(lr.timedelta64(3, "h"))` yields 0, 1 and 2 hours.
Raw integers and complete decimal strings can supply duration tick counts.
Bare floating numbers are rejected by the temporal constructor, including a
floating `1.0`; use a Lua integer or a timedelta step.

## Use a relative stopping value

```lua
local start = lr.datetime64("2020-01-01")
local relative = lr.arange(start, 3)
assert(relative.dtype == "datetime64[D]" and relative.size == 3)
assert(lr.datetime_as_string(relative)[3] == "2020-01-03")
```

For a datetime range, an integer or timedelta stop is an offset added to start
after unit conversion. A datetime or ISO-string stop is an absolute endpoint.
All resulting ticks are int64. Zero steps and NaT ticks are rejected after
relative endpoints are normalized. The upstream order allows some relative
NaT offsets to lose their marker and produce an empty range; regressions retain
that quirk. Ordinary NaT endpoints remain invalid.

The established two-argument `lr.arange(integer_stop, positional_dtype)` helper
keeps its [legacy index-conversion contract](./arange.md#select-the-output-dtype).
Use an options table for the temporal constructor's single-argument rules.

## Numeric output from temporal arguments

```lua
local start_ns = lr.timedelta64(0, "ns")
local stop_ns = lr.timedelta64(5, "ns")
local truncated = lr.arange(start_ns, stop_ns, 2, {dtype="int64"})
local ratio = lr.arange(start_ns, stop_ns, lr.timedelta64(2, "ns"), {dtype="int64"})
assert(truncated.size == 2 and truncated[2] == 2)
assert(ratio.size == 3 and ratio[3] == 4)
```

An explicit numeric dtype selects the numeric engine, as in NumPy. Its temporal
intermediates preserve their source arithmetic: duration divided by an integer
truncates to duration ticks, while duration divided by duration yields a numeric
ratio. Conversion to a numeric length and output also depends on the source
item representation. Generic, year/month and fine-resolution durations can
have integer items; ordinary day/microsecond durations cannot. Original arrays
and temporal scalars retain their distinct integer packing rules. These rules follow the pinned source.

## Input memory and native API

```lua
local bound = lr.array(3, "timedelta64[h]")
bound:setflags(false)
local independent = lr.arange(bound)
assert(independent.flags.owndata and independent.flags.writeable)
assert(not bound.flags.writeable and not lr.shares_memory(bound, independent))
```

Temporal scalars and rank-zero datetime/timedelta arrays are accepted.
Read-only and unaligned time buffers stay unchanged. Higher-rank arrays and
ordinary numeric arrays passed into the temporal converter are rejected.
Existing dtype/endian and foreign-object limitations remain in force.

The native interface `ln_array_arange_time` accepts optional start/step operands,
a required stop and an optional dtype. Temporal scalar values use rank-zero
time arrays; strings and integer operands preserve their native tags. The
numeric interface retains scalar provenance through `scalar_object` when the
binding represents a scalar object with a rank-zero array. Rebuild native
consumers against the matching development headers.

## Verification and limits

Compatibility is partial against NumPy 2.5.3. Tests compare temporal ticks,
units, multipliers, shape, flags, errors and unchanged source storage. Separate
references check promotion and arithmetic because their casting rules differ.
Numeric longdouble outputs compare significant bytes and omit ABI padding.
Floating warning policies, Python datetime/foreign protocols and all value/ABI
combinations are not certified.

Relative endpoint addition and length numerators are checked before allocation.
States that overflow upstream's signed int64 arithmetic are rejected explicitly;
the oracle excludes those unsafe states and oversized allocations. Zero unit
multipliers are also rejected before conversion. Exclusions are recorded
separately and never counted as compatibility passes.
