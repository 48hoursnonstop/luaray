local lr = require("luaray")
local holidays = lr.array({1, 1, 2, 5, math.mininteger}, "datetime64[D]")
local calendar = lr.busdaycalendar{holidays=holidays}
assert(lr.array_equal(calendar.weekmask,{true,true,true,true,true,false,false}))
assert(lr.array_equal(calendar.holidays:view("int64"),{1,5}))
local mask = calendar.weekmask
mask[1]=false
assert(calendar.weekmask[1])
local snapshot = calendar.holidays
snapshot:view("int64")[1]=17000
assert(calendar.holidays:view("int64")[1]==1)
assert(not pcall(function() calendar.weekmask=mask end))

local dates = lr.array({{-1,0,1},{2,4,5}}, {dtype="datetime64[D]",order="F"})
local active = lr.is_busday(dates,{calendar=calendar})
assert(active.flags.f_contiguous)
assert(lr.array_equal(active,{{true,true,false},{false,true,false}}))
local weekend = lr.busdaycalendar{weekmask="SatSun"}
assert(lr.array_equal(lr.is_busday({0,1,2,3},{calendar=weekend}),{false,false,true,true}))
assert(lr.is_busday("1970-01-02"))
assert(not lr.is_busday("NaT"))
local out = lr.zeros({2,2},"int8")
assert(rawequal(lr.is_busday({0,2},{out=out}),out))
assert(lr.array_equal(out,{{1,0},{1,0}}))
assert(not pcall(lr.busdaycalendar,{weekmask="0000000"}))
assert(not pcall(lr.is_busday, lr.array({0,1},"datetime64[h]")))
assert(not pcall(lr.is_busday, {0,1},{calendar=calendar,holidays={}}))
print("Business day calendar regression passed")
