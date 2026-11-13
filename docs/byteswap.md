---
docs_examples: true
---
# Swapping payload bytes

`a:byteswap()` returns an independent writable array whose payload bytes have
been reversed within each numeric component. `a:byteswap(true)` modifies the
existing allocation and returns the same Lua userdata. The dtype descriptor,
including its byte order and temporal metadata, stays unchanged.

```lua
local lr = require("luaray")
local values = lr.array({0x0102, 0x0304}, "uint16")
local swapped = values:byteswap()
assert(swapped:tolist()[1] == 0x0201)
assert(values:tolist()[1] == 0x0102)
assert(swapped.dtype == values.dtype)
assert(not lr.shares_memory(values, swapped))
```

This operation changes storage rather than performing a numeric conversion.
Integer, floating and temporal items reverse their full storage width. Complex
items reverse the real and imaginary components separately. Unicode reverses
each four-byte UCS-4 code point. Boolean, one-byte numeric and fixed byte-string
items stay unchanged. Object, structured and variable-width string dtypes are
outside the supported array model.

## In-place mutation and views

```lua
local reversed = lr.flip(values, 1)
assert(rawequal(reversed:byteswap({inplace=true}), reversed))
assert(values:tolist()[1] == 0x0201)
reversed:byteswap(true)
assert(values:tolist()[1] == 0x0102)
```

The method accepts a Boolean or `{inplace=boolean}`; false, nil or an empty
options table selects a copy. Extra arguments and unknown options are errors.
In-place swapping updates all views of the allocation. Negative strides,
unaligned addresses, broadcast strides and overlapping views use the source
iteration rules. A complex run swaps all real components before its imaginary
components; this distinction matters when items overlap. Repeating an in-place
swap is not guaranteed to undo itself for overlapping layouts.

## Copy layout and read-only input

```lua
values:setflags(false)
assert(not pcall(function() values:byteswap(true) end))
local writable = values:byteswap(false)
assert(writable.flags.writeable and not values.flags.writeable)
local columns = lr.asfortranarray(lr.array({{1, 2}, {3, 4}}, "int16"))
assert(columns:byteswap().flags.f_contiguous)
```

The copy follows the source's ANYORDER allocation: Fortran-only contiguous
input retains F layout; other noncontiguous input becomes C contiguous. It owns
new storage and is writable. An in-place request rejects read-only arrays even
when empty or when the dtype's swap would leave bytes unchanged. A copy of S0
or U0 uses the constructor's minimum width; an in-place swap retains width zero.

## Text and extended precision

```lua
local text = lr.array({"λ", "ab"}, "U2")
local bytes = text:tobytes()
local swapped_text = text:byteswap()
assert(swapped_text:byteswap():tobytes() == bytes)
assert(swapped_text:byteswap():tolist()[1] == "λ")
```

Since byte order metadata is unchanged, swapped Unicode may contain invalid
code points. Inspect its bytes or restore the matching representation before
decoding it. Extended floating types reverse their entire component storage,
including ABI padding, rather than only their significant value bytes. No
floating-point computation is involved in swapping the payload.

## Zero-width memory queries

```lua
local storage = lr.arange(32, "uint8")
local zero = lr.ndarray({2, 3}, {
  dtype="S0", buffer=storage, offset=4, strides={2, 4},
})
assert(lr.may_share_memory(zero, zero))
assert(not lr.shares_memory(zero, zero))
```

Memory queries preserve an upstream zero-width corner case: positive stride
extents can overlap even when no element has bytes. The exact source solver
omits the width term and reflects one operand about `end-1`; bounds overlap can
therefore report true while the exact query reports false even for the same
array. LuaRay now retains this behavior within its existing exact-query work
and memory limits. Arrays with zero element count still never overlap. This
query convention does not make zero-width writes touch storage.

## Executed references

The implementation passed **9,504 NumPy 2.5.3 byteswap cases / 190,320 exact
checks** across 24 dtypes, empty/scalar/3D inputs, C/F copies, read-only states,
and bounded negative, unaligned, zero-stride and overlapping layouts. Every
initialized payload byte is compared, including longdouble padding; those raw
payloads are never decoded as numerical or Unicode values. Full backing buffers
are checked after mutation.

Another **36,000 cases / 72,000 checks** verify exact and bounds-only memory
queries with zero-width S/U and mixed-width views. The two corpora regenerate
exactly. Permanent Lua regressions add 108 checks, and the native harness checks
ownership, read-only rejection, complete component payloads and write order.
APIs remain partial: foreign array protocols, general object/structured dtypes,
all host ABIs and the source's full unbounded overlap solver are not certified.
