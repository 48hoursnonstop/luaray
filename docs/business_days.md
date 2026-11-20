---
docs_examples: true
---

# Business day calendars

`lr.busdaycalendar(options)` describes the weekdays and holidays used
for business day calculations. Monday through Friday are business
days by default. `weekmask` accepts seven Boolean values, a seven-digit
zero/one string or a string of weekday abbreviations beginning with
`Mon` for Monday. `holidays` accepts a vector of day dates.

```lua
local lr = require("luaray")
local calendar = lr.busdaycalendar{
  weekmask = "Mon Tue Wed Thu Fri",
  holidays = {"2026-11-16", "2026-11-16", "2026-11-14"}
}
assert(calendar.holidays.size == 1)
assert(calendar.weekmask[1] and not calendar.weekmask[6])
```

Calendars are immutable. Their `weekmask` and `holidays` properties
return copies. Holidays are sorted and deduplicated, with NaT or
already excluded weekdays removed.

```lua
local dates = lr.array({"2026-11-14", "2026-11-16", "2026-11-17"}, "datetime64[D]")
local valid = lr.is_busday(dates, {calendar = calendar})
assert(lr.array_equal(valid, {false, false, true}))
assert(not lr.is_busday("NaT"))
```

`lr.is_busday(dates, options)` accepts day arrays or ordinary Lua
date strings and day numbers. Pass a custom calendar, or pass
`weekmask` and `holidays` directly. Scalar queries return a Boolean.
An optional writable `out` array receives the broadcast results.

## Validation

**597 cases / 6,824 checks** passed with NumPy 2.5.5. The checks cover weekday masks, sorted unique holidays, NaT, safe date conversion, scalar and broadcast queries, and writable output arrays.
