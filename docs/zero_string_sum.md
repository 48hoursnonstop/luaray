---
docs_examples: true
---
# Summing zero-width strings

Fixed-width string addition concatenates its operands. For `S0` and `U0`,
concatenation retains width zero, so these descriptors also support `lr.sum`.
Ordinary nonzero-width strings still reject sum: concatenation would change the
reduction dtype. This operation is mostly relevant when working with raw typed
buffers; ordinary array constructors normalize empty string widths to one.

```lua
local lr = require("luaray")
local raw = lr.ndarray({2, 3}, lr.dtype("S0"))
local result = lr.sum(raw, {axis = 1, keepdims = true})
assert(lr.dtype(result.dtype).str == "|S1")
assert(result.shape[1] == 1 and result.shape[2] == 3)
assert(result:get(1, 3) == "")
assert(result.strides[1] == 0 and result.strides[2] == 0)
assert(not result.flags.c_contiguous and result.flags.owndata)
```

Fresh output normalizes its width to one but retains the reduction iterator's
zero strides. Its initialized characters are empty strings. A typed zero-width
`out` retains its own descriptor. A scalar return follows the usual Lua string
convention; it does not retain a separate NumPy bytes/string scalar class.

```lua
local out = lr.ndarray({3}, lr.dtype("S0"))
assert(rawequal(lr.sum(raw, {axis = 1, out = out}), out))
assert(lr.dtype(out.dtype).str == "|S0")
assert(lr.sum(lr.ndarray({1}, lr.dtype("U0"))) == "")
```

String addition has no registered reduction identity. An empty reduced axis
therefore needs `initial`; numeric/Boolean seeds are converted to width zero.
An ndarray-valued `where` mask also requires `initial`, even when all entries
are true. Mask shape and dtype are checked normally.

```lua
local empty = lr.ndarray({3, 0}, lr.dtype("U0"))
assert(not pcall(lr.sum, empty, {axis = 2}))
local seeded = lr.sum(empty, {axis = 2, initial = 0})
assert(seeded.shape[1] == 3 and seeded[2] == "")
assert(not pcall(lr.sum, raw, {axis = 1, where = lr.array(true)}))
local masked = lr.sum(raw, {axis = 1, where = lr.array(false), initial = 0})
assert(masked[1] == "" and masked[3] == "")
```

The string addition method is not reorderable: at most one axis may be reduced
in a call. An empty axis table is allowed. Separately, scalar reduction axes
accept Lua `1`/`-1`, but a nonempty axis table is invalid for a scalar ndarray,
matching the source distinction between a scalar axis and an axis tuple.

```lua
assert(not pcall(lr.sum, raw)) -- All axes would select two dimensions.
assert(not pcall(lr.sum, raw, {axis = {1, 2}}))
local unselected = lr.sum(raw, {axis = {}})
assert(unselected.shape[1] == 2 and unselected.shape[2] == 3)
local scalar = lr.array(5)
assert(lr.sum(scalar, 1) == 5)
assert(not pcall(lr.sum, scalar, {axis = {1}}))
```

The reference passed **64,000 cases /734,542 checks** and 247 permanent Lua checks, plus a native harness and a C++ header/link smoke. Another 2,892 scalar string returns were normalized to the Lua contract. The 180 dtype/output groups ran in fresh NumPy processes to isolate observed history-dependent dispatch changes; those changes are not emulated. The corpus regenerated exactly. Disjoint numeric outputs retain committed seeds when a non-scalar string input fails conversion; scalar inputs fail before output initialization. General input/mask-overlap failure writeback remains uncertified.

This remains a partial string/reduction API. General string seeds, variable-width
StringDType, object arrays, Python scalar classes and foreign dispatch are not
implemented. Unicode outputs use the native descriptor; other host ABIs remain
uncertified.
