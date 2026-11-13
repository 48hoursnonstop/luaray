---
docs_examples: true
---
# Counting categories

`lr.bincount(labels, weights, minlength)` counts nonnegative integer category
values. Labels are **data with zero origin**: result element one counts label
zero, element two counts label one, and so on. Repeated values add to the same
bin; missing categories remain zero. The result owns writable, independent
one-dimensional storage.

```lua
local lr = require("luaray")
local counts = lr.bincount({0, 1, 1, 3, 2, 1, 7})
assert(counts[1] == 1 and counts[2] == 3)
assert(counts[5] == 0 and counts[8] == 1)
assert(counts.dtype == "int64") -- native intp on this 64-bit host
```

## Weighted sums

Supply a one-dimensional weight array or Lua sequence with the same length as
the labels. Each weight adds to its label's bin, in logical input order.
Weighted nonempty results use `float64`. An options table can express `weights`
and `minlength` together; other keys are rejected. An empty second table is an
empty weight sequence, so omit the argument for an unweighted count.

```lua
local sums = lr.bincount({0, 0, 1}, {
  weights = {2, 3, 4}, minlength = 3
})
assert(sums.dtype == "float64")
assert(sums[1] == 5 and sums[2] == 4 and sums[3] == 0)
```

Typed weights must safely cast to `float64`; complex, longdouble, string and
temporal weight arrays are rejected. Ordinary numeric Lua sequences use their
inferred dtype. Sequential addition preserves floating-point order effects;
this operation does not sort labels or replace accumulation with a reduction.

```lua
local sums = lr.bincount({0, 0, 0}, {1e16, -1e16, 1})
assert(sums[1] == 1)
local reversed = lr.array({1e16, -1e16, 1}):get(lr.s(nil, nil, -1))
assert(lr.bincount({0, 0, 0}, reversed)[1] == 0)
```

## Minimum output length

`minlength` is a nonnegative Lua integer. The actual length is the larger of
that minimum and the largest label plus one. Positional weights can be `nil`
when only a minimum is wanted. Omitted or `nil` minimum means zero in Lua.

```lua
local counts = lr.bincount({0, 1}, nil, 4)
assert(counts.size == 4 and counts[3] == 0 and counts[4] == 0)
assert(not pcall(lr.bincount, {0}, nil, -1))
assert(not pcall(lr.bincount, {0}, nil, true))
```

## Layout and ownership

Read-only, reversed, stepped, broadcast and unaligned inputs are read in logical
sequence order. The result shares no input bytes. Integer and Boolean label
arrays convert to native pointer-width signed integers; wide unsigned payloads
can wrap and subsequently fail the nonnegative check. Boolean truth is label
zero or one, including noncanonical raw Boolean bytes.

```lua
local labels = lr.array({0, 1, 1, 3}, "int32")
local reversed = labels:get(lr.s(nil, nil, -1))
reversed:setflags(false)
local counts = lr.bincount(reversed)
assert(counts[2] == 2 and not lr.shares_memory(counts, labels))
counts[1] = 99
assert(labels[1] == 0 and not reversed.flags.writeable)
```

## Empty inputs and invalid labels

An ordinary empty sequence is accepted. A typed input must still have integer
or Boolean dtype and rank one. Empty labels return native-integer zeros and
ignore weights entirely, including their shape, dtype or convertibility.
Floating, complex, string and temporal labels are rejected even when empty.
Negative labels, invalid ranks and mismatched nonempty weights also fail.

```lua
local empty = lr.bincount({}, function() error("unused weights") end, 3)
assert(empty.dtype == "int64" and empty.size == 3 and empty[1] == 0)
assert(not pcall(lr.bincount, lr.empty({0}, "float64")))
assert(not pcall(lr.bincount, {-1}))
assert(not pcall(lr.bincount, {0, 1}, {2}))
```

Bincount passed **6,937 cases /50,126 checks**, 93 permanent Lua checks, a native harness and C++ header/link execution. They check bytes, dtype, shape, strides, flags, independent output, unchanged inputs, conversions, extremes, sequential sums, empty inputs and unaligned/read-only layouts. Another 48 enormous-allocation/source-overflow cases are excluded, not counted as passes. The corpus regenerated exactly. Serializers normalize six longdouble ABI padding bytes, including unaligned buffers; all ten significant bytes remain checked.

The API remains partial. Foreign array/index protocols, typed scalar `minlength`,
Python scalar classes, numeric strings in ordinary weight sequences and warning/
exception-class fidelity remain unsupported. A maximum-intp label is rejected
before size addition, avoiding the upstream signed-overflow path. Huge
allocations, all host ABIs and every combination are not certified.
