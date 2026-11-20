---
docs_examples: true
---

# Counting business days

`lr.busday_count(first, last, options)` counts business days from the
start date to the end date, including the start and excluding the end.
Reversed intervals return a negative count and still exclude the end
date in the direction of travel.

```lua
local lr = require("luaray")
assert(lr.busday_count("1970-01-01", "1970-01-08") == 5)
assert(lr.busday_count("1970-01-01", "1970-01-04") == 2)
assert(lr.busday_count("1970-01-04", "1970-01-01") == -1)
```

Use ISO date strings or typed day arrays. Two arrays broadcast to a shared
shape. Pass `calendar` or supply `weekmask` and `holidays` directly. With a
calendar, its normalized holiday list is reused across queries.

```lua
local calendar = lr.busdaycalendar{holidays = {"1970-01-02"}}
local starts = lr.array({"1970-01-01", "1970-01-02"}, "datetime64[D]")
local counts = lr.busday_count(starts, "1970-01-08", {calendar = calendar})
assert(lr.array_equal(counts, {4, 3}))
```

A scalar query returns a Lua integer. An array query returns an `intp`
array unless you supply an `out` array. NaT endpoints and counts outside
the native integer range raise an error. The native kernel skips full
weeks and uses binary searches to locate holidays in the interval.

## Validation

**346 cases / 5,125 checks** passed with NumPy 2.5.5. The checks cover signed intervals, endpoint rules, typed day casting, weekend masks, normalized holidays and broadcasting. The native tests also exercise NaT and overflow at the representable tick limits.
