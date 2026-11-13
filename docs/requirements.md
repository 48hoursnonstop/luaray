---
docs_examples: true
---
# Require a usable memory layout

`lr.require(input, dtype, requirements)` returns an ndarray that satisfies the
requested memory conditions. It preserves a suitable input and copies when a
condition or dtype conversion requires new storage. This is useful before
passing arrays to native consumers with stricter memory contracts.

## Select requirements

```lua
local lr = require("luaray")
local source = lr.arange(6):reshape({2, 3})
assert(rawequal(lr.require(source), source))
assert(rawequal(lr.require(source, nil, "C"), source))
local prepared = lr.require(source, "float32", {"F", "O", "W", "A"})
assert(prepared.dtype == "float32" and prepared.flags.fnc)
assert(prepared.flags.owndata and prepared.flags.writeable and prepared.flags.aligned)
assert(lr.array_equal(prepared, source) and not lr.shares_memory(prepared, source))
```

| Short name | Long names | Required condition |
| --- | --- | --- |
| C | C_CONTIGUOUS, CONTIGUOUS | C-contiguous |
| F | F_CONTIGUOUS, FORTRAN | F-contiguous |
| A | ALIGNED | Dtype-aligned storage |
| W | WRITEABLE | Writable array |
| O | OWNDATA | Owns its allocation |
| E | ENSUREARRAY | Base array class; LuaRay has one native array class |

Names are case-insensitive. A requirements table must be a dense sequence of
strings. Duplicates are harmless. A string is interpreted character by character,
so `"COW"` requests C, O and W; use a sequence for long names. C and F together
raise even when the input is empty or already satisfies both. Unknown names,
non-string entries and invalid sequence keys raise.

## Copy immutable or unaligned input

```lua
local packed = string.pack("i4i4", 1, 2)
local readonly = lr.frombuffer(packed, "int32")
assert(rawequal(lr.require(readonly, nil, "C"), readonly))
local writable = lr.require(readonly, nil, "W")
writable[1] = 7
assert(readonly[1] == 1 and writable.flags.writeable)
local unaligned = lr.frombuffer("x" .. packed, "int32", 2, 1)
local aligned = lr.require(unaligned, nil, {"ALIGNED", "OWNDATA"})
assert(aligned.flags.aligned and aligned.flags.owndata)
assert(lr.array_equal(aligned, unaligned))
```

A copy satisfies unmet A, O or W conditions rather than changing the original
array's flags. C/F layout requests may also require copying. Read-only input can
be returned unchanged when writeability was not requested. Owning storage and
nonoverlapping storage are different concepts; use memory queries when sharing
itself matters.

## Conversion order and identity

```lua
local expanded = lr.broadcast_to(lr.arange(3), {2, 3})
local converted = lr.require(expanded, "float64", "A")
assert(converted.strides[1] == 8 and converted.strides[2] == 16)
assert(expanded:copy("A").flags.c_contiguous)
```

With no requirements—nil, false, an empty string or an empty sequence—conversion
uses `asanyarray`, retaining its default KEEPORDER behavior. Nonempty requirements
use the source's array-conversion path with C, F or otherwise ANYORDER. A dtype
change through ANYORDER can retain physical axis order, including broadcast
strides. A later same-dtype `copy("A")` uses the distinct copy contract. The shared
creation engine preserves this distinction; requirements do not relabel strides.

Scalars remain rank zero; requiring C or F does not impose a minimum dimension.
Suitable ndarrays retain Lua userdata identity. Ordinary Lua inputs are converted
through the existing creation API. Input dtype is retained when dtype is nil.

## Compatibility

This is a partial port of NumPy 2.5.3 `_core/_asarray.py:require`. Python `like`,
subclass dispatch, arbitrary iterable/dictionary requirements, dtype classes and
foreign array protocols are unsupported. E is satisfied by the sole native Lua
array class. Dtype strings and supported source kinds retain the creation
engine's documented restrictions, including non-native numeric endian, object,
structured and variable-width StringDType gaps.

References compare acceptance, values, dtype, shape, strides, identity, flags,
sharing and input/backing states after actual writes. They include read-only,
manually unaligned, physically unaligned and immutable buffer sources. Full
Python exception/warning fidelity and every dtype/protocol remain uncertified.
