---
docs_examples: true
---
# Arrays from an iterator

`lr.fromiter(iterator, dtype, count)` builds an owned one-dimensional array from
a Lua iterator function. Each call returns one value. A missing return or `nil`
ends the stream; `false` is an ordinary Boolean element. Extra returns are ignored.
The dtype argument is required; explicit `nil` selects float64.

```lua
local lr = require("luaray")
local position = 0
local values = lr.fromiter(function()
  position = position + 1
  if position <= 4 then return position * position end
end, "int64")
assert(values.size == 4 and values[4] == 16)
assert(values.flags.owndata and values.flags.writeable)
```

## Limit consumption

The default count, `-1`, reads to the end. A nonnegative count preallocates the
requested length and consumes exactly that many values. An early end raises a
Lua error. The iterator remains at its consumed position after success or failure.
A count/options table is also accepted.

```lua
local position = 0
local function nextvalue()
  position = position + 1
  return position
end
local prefix = lr.fromiter(nextvalue, "int16", {count = 3})
assert(prefix[3] == 3 and position == 3)
assert(nextvalue() == 4)
assert(lr.fromiter(nextvalue, "int16", 0).size == 0 and position == 4)
```

Only `-1` means unlimited. Counts below `-1` return an empty array without
fetching values, following the pinned source. Counts must be Lua integers;
Boolean and floating counts are rejected. Even zero-count calls validate the
iterator and dtype. Unsized `S0`/`U0` strings are rejected before fetching.

## Conversion and typed values

Each value is packed directly into the requested dtype. Ordinary Lua integers
outside an integer destination's range raise an error. Typed rank-zero arrays
instead follow native scalar casting, including wrapping integer casts.
Ordinary numbers passed to complex dtypes follow double-component scalar
conversion; typed extended-precision values retain their significant bytes.

```lua
assert(not pcall(lr.fromiter, function() return 256 end, "uint8", 1))
local wrapped = lr.fromiter(function()
  return lr.array(256, "int64")
end, "uint8", 1)
assert(wrapped[1] == 0)
local flags = {false, true, false}
local index = 0
local booleans = lr.fromiter(function()
  index = index + 1
  return flags[index]
end, "bool")
assert(booleans.size == 3 and booleans[1] == false)
```

A typed rank-zero array can preserve uint64 values above the Lua integer range,
longdouble components, temporal units, and fixed-width text without converting
through a Lua number. Read-only and unaligned scalar sources are accepted.
Higher-rank ndarray elements are unsupported; sequences are accepted only as
Boolean truth values (empty is false, nonempty is true).

```lua
local scalar = lr.ndarray({}, {
  dtype = "uint64", buffer = string.rep("\255", 8)
})
local wide = lr.fromiter(function() return scalar end, "uint64", 2)
assert(wide:tobytes() == string.rep("\255", 16))
```

## Callable objects and coroutines

A Lua table or userdata with a function-valued `__call` is accepted. Closures can
adapt generic iterators and external streams. A `coroutine.wrap` producer is
also usable; the constructor itself does not suspend across callback calls.

```lua
local producer = coroutine.wrap(function()
  for i = 1, 3 do coroutine.yield(i * 2) end
end)
local values = lr.fromiter(producer, "float64")
assert(values[1] == 2 and values[3] == 6)
```

## Errors and ownership

Iterator errors propagate their original Lua error value. Array storage stays
rooted across callbacks and garbage collection, including buffer growth.
A failed constructor returns no partially built array; completed iterator side
effects remain visible. Unknown options are errors.

```lua
local marker = {}
local ok, value = pcall(lr.fromiter, function() error(marker) end, "float64")
assert(not ok and rawequal(value, marker))
assert(not pcall(lr.fromiter, function() end, "S0", 0))
assert(not pcall(lr.fromiter, function() end, "int64", {like = {}}))
```

The native buffer follows the source's 50% growth strategy and shrinks to the
written length. It uses existing checked native allocation and scalar casting;
values are not first collected into a Lua list. Python iterable/length-hint,
foreign object, structured/subarray dtype and `like` protocols are unsupported.
A callback that returns `nil` cannot use that value as an element. Temporal
scalar userdata retain the existing constructor's conversion limits; use typed
rank-zero arrays for raw scalar casting. API compatibility remains partial.

## 0.159.0-dev verification

Fromiter passed **11,367 cases /153,738 checks** against NumPy2.5.4:6,874 accepted inputs and4,493 expected failures, with58 permanent Lua checks, a native growth/overflow harness and C++ header/link execution. References compare exact significant bytes, dtype/layout/flags, source states, count/EOF/error ordering and consumed values; callback errors preserve the original Lua object. Twenty real NaN arrays use numerical classification; x87 ABI padding is omitted. Both corpora regenerated exactly.

