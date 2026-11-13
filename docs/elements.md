---
docs_examples: true
---
# Read one element and fill an array

`array:item()` extracts a detached element. `array:fill(value)` packs one scalar
and writes it throughout the existing array. Both support ordinary and strided
views through the native ndarray storage model.

## Flat indices and coordinates

```lua
local lr = require("luaray")
local matrix = lr.arange(6):reshape({2, 3})
assert(matrix:item(4) == 3)
assert(matrix:item({2, 3}) == 5)
assert(matrix:item(-1) == 5)
assert(lr.asfortranarray(matrix):item(4) == 3)
```

Flat indices follow logical C order, regardless of physical storage order.
Positive Lua indices start at one; negative indices count from the end. Zero is
invalid. Indices must be Lua integers. A table with one index also means a flat
index; a longer table supplies one coordinate per dimension. No index, or an
empty table, requires exactly one element. Empty arrays and out-of-range indices
raise. One coordinate table replaces Python's variadic coordinate arguments.

## Preserve values outside Lua's numeric range

```lua
local original = lr.astype(lr.array({"18446744073709551615"}), "uint64")
local scalar = original:item()
assert(scalar.ndim == 0 and scalar.dtype == "uint64")
assert(lr.astype(scalar, "U40"):tolist() == "18446744073709551615")
scalar:set(7)
assert(lr.astype(original, "U40")[1] == "18446744073709551615")
```

Ordinary Boolean, integer, floating, complex and text elements use the library's
Lua scalar representations. Longdouble and complex256/clongdouble return a detached
typed rank-zero ndarray. Uint64 values above the signed Lua integer maximum use
the same typed representation. Keep these values in native arithmetic to retain
precision; string casts provide exact integer display. The result owns its value
and remains valid after the source is collected.

Temporal elements return LuaRay's temporal scalar userdata, preserving ticks,
unit and NaT. This replaces Python's datetime/timedelta/None item conversions.
The selected native value remains intact. Read-only and unaligned input views
are accepted; extracted typed scalars do not share the source buffer.

## Fill in place

```lua
assert(matrix:fill(7) == nil)
assert(matrix:get(2, 3) == 7 and matrix.shape[1] == 2)
local narrow = lr.zeros({2}, "int8")
assert(not pcall(function() narrow:fill(256) end))
narrow:fill(lr.array(256, "int64"))
assert(narrow[1] == 0 and narrow[2] == 0)
```

`fill` returns nil and keeps the array's shape, strides and allocation. Views write
through to their backing storage. Read-only destinations raise, including empty
ones. Scalar packing occurs before any destination write and also runs for empty
arrays, so invalid values still raise. Ordinary Lua scalars use assignment bounds;
a typed rank-zero value uses the source's scalar casting path and can narrow.

For most dtypes, sequences and arrays with nonzero rank are invalid scalar values.
Boolean packing follows truth conversion: an empty ordinary sequence is false,
a nonempty sequence is true, and a typed array must contain exactly one element.
A complex Lua scalar cannot fill a real array; a complex rank-zero ndarray can
use the source's cast that discards the imaginary component.

## Scalar aliases and temporal units

```lua
local storage = lr.array({1, 2, 3, 4}, "int64")
local alias = storage:get(lr.s(2, 3)):reshape({})
storage:fill(alias)
assert(storage[1] == 2 and storage[4] == 2)
local dates = lr.zeros({2}, "datetime64[D]")
dates:fill(lr.datetime64(-1, "Y"))
assert(lr.astype(dates, "int64")[1] == -365)
```

The scalar value is captured before writing an aliased destination. Datetime
calendar conversion uses actual years/months, including dates before the epoch;
duration conversions retain their average-year/month rules. Temporal scalar and
rank-zero array packing can differ, following NumPy's distinct paths. Calendar
versus fixed duration scalar assignment requires `same_kind` compatibility.

## Compatibility

Available since **0.135.0-dev**, derived from NumPy 2.5.3 ndarray methods, scalar
packing and datetime conversion sources. Lua indices and typed precision-preserving
item results are explicit adaptations. The shared calendar fixes include source
integer wrap behavior executed without signed-overflow undefined behavior.
Timedelta string casts retain the source's 21-character limit.

Unit-factor availability is resolved before iteration, including empty arrays.
Scalar and array false-mask shortcuts follow their separate source paths.

References check selected values, native precision, shapes, strides, backing
writes, aliasing, read-only and empty cases, NaT and scalar conversion errors.
The APIs remain partially compatible: object/structured dtypes, full foreign and
Python scalar protocols, warning objects and all host ABIs are not certified.
