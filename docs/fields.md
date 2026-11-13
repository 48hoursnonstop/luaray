---
docs_examples: true
---
# Per-item byte fields

`a:getfield(dtype, offset)` returns a view of a byte region inside every element.
`a:setfield(value, dtype, offset)` assigns to that region and returns nil. The
byte offset defaults to **zero**. This reinterprets storage; it does not convert
the parent array to a different dtype or add a new axis.

```lua
local lr = require("luaray")
local records = lr.zeros({3}, "uint64")
local channel = records:getfield(lr.dtype("uint8"), 1)
assert(channel.shape[1] == 3 and channel.strides[1] == 8)
assert(not channel.flags.owndata)
assert(lr.shares_memory(records, channel))
records:setfield({10, 20, 30}, "uint8", 1)
assert(channel:tolist()[2] == 20)
```

For each element, only the selected field bytes change. Shape and strides stay
those of the parent; dtype and data address change. The field can consequently
be noncontiguous or unaligned. Its own flags reflect that representation. It
retains the allocation after the original Lua userdata is collected.

| Array | Shape | Element stride | Bytes exposed per item |
| --- | --- | --- | --- |
| `records` | `{3}` | 8 | 8 |
| `records:getfield("uint8", 1)` | `{3}` | 8 | 1 at byte offset 1 |

## Bounds and descriptor rules

```lua
assert(not pcall(function() records:getfield("uint16", 7) end))
assert(not pcall(function() records:getfield("uint8", -1) end))
local empty_field = records:getfield("S0", 8)
assert(empty_field.size == 3 and empty_field.itemsize == 0)
local empty = lr.zeros({0}, "uint64"):getfield("uint8", 7)
assert(empty.size == 0)
```

The requested item width plus offset must fit inside the original item width,
even for empty arrays. Offsets must be Lua integers in the source C-int range.
A descriptor or supported dtype string is required; explicit nil selects
float64. S0/U0 retain width zero. Read-only input yields a read-only field view.
The existing numeric-endian and dtype restrictions still apply; this is not a
structured-record dtype implementation.

## Broadcasting and typed input

```lua
local matrix = lr.zeros({2, 3}, "uint64")
matrix:setfield({1, 2, 3}, "uint8")
assert(matrix:getfield("uint8"):tolist()[2][3] == 3)
local scalar = lr.zeros({}, "uint64")
assert(not pcall(function() scalar:setfield({1}, "uint8") end))
scalar:setfield(lr.array({1}, "int32"), "uint8")
assert(scalar:getfield("uint8"):tolist() == 1)
```

Ordinary Lua sequences are discovered with the destination's maximum rank.
Typed ndarray values instead retain the source array-assignment rules, including
leading unit axes and unsafe dtype conversion. For example, an int32 array
containing 257 wraps to 1 when assigned to a uint8 field; a Lua integer 257 is
out of range. Broadcasting preserves the parent bytes outside each field.
Read-only destinations always reject assignment.

## State after an assignment error

```lua
local destination = lr.zeros({3}, "uint64")
assert(not pcall(function()
  destination:setfield({1, 257, 2}, "uint8")
end))
assert(destination:getfield("uint8"):tolist()[1] == 1)
assert(destination:getfield("uint8"):tolist()[2] == 0)
```

A sequence with exactly the destination shape is packed directly in logical
order. A later conversion error can leave an earlier prefix written, as in
NumPy's CopyObject path. Shape discovery happens first. A sequence requiring
broadcasting is packed into a temporary before assignment, so a packing error
there leaves the destination unchanged. Array-valued input uses the native
assignment engine's overlap handling.

## Temporal scalar packing

```lua
scalar:setfield(lr.datetime64(3, "D"), "U1")
assert(scalar:getfield("U1"):tolist() == "1") -- Truncated scalar date text.
assert(not pcall(function()
  scalar:setfield(lr.datetime64(3, "D"), "int32")
end))
scalar:setfield(lr.array(lr.datetime64(3, "D")), "int32")
assert(scalar:getfield("int32"):tolist() == 3) -- Typed raw-tick cast.
```

Temporal userdata and temporal ndarrays retain distinct scalar/array conversion
paths. Signed integer fields require the scalar's item representation to be an
integer and enforce its bounds. Scalar dates pack their displayed text into
string fields; timedelta text follows the source cast's 21-character limit,
even with wider output. Displayed duration counts include the unit multiplier
and its defined signed wrapping. These rules do not alter global `tostring`.

## Field view lifetime

```lua
local retained
 do
  local owner = lr.zeros({2}, "uint64")
  retained = owner:getfield("uint8", 2)
 end
collectgarbage("collect")
retained:fill(7)
assert(retained:tolist()[2] == 7)
```

A live field view also prevents its owner's byte-changing `resize`, because it
retains the same native buffer. See [resizing arrays](resize.md). Field reads
can expose arbitrary bit patterns; decode numerical or Unicode values only
when those bytes represent valid values for the selected dtype.

## Verification and limits

NumPy 2.5.3 references passed **233,460 cases / 2,680,078 exact checks**:
79,632 getfield cases and 153,828 setfield cases. They compare raw payloads,
initialized padding, shapes, strides, descriptors, flags, sharing, entire base
buffers, acceptance and state after errors. Coverage includes read-only,
transposed, reversed, C/F, empty and scalar inputs; scalar/array distinctions;
broadcasting; partial sequence errors; and temporal units, multipliers and NaT.
Both corpora regenerate exactly. Permanent Lua regressions add 104 checks; the
native harness verifies bounds, lifetime, empty offsets and temporal formatting.

Both methods remain partial. Object/structured/StringDType, foreign protocols,
general nested typed arrays or temporal userdata inside Lua sequences, every
Unicode/numeric conversion corner and all host ABIs remain unsupported or
uncertified. Existing memory-query work limits also apply to field views.
