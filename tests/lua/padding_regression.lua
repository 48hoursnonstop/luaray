local lr = require("luaray")

local a = lr.array({{1, 2}, {3, 4}}, {order="F", dtype="int32"})
local original = a:tobytes()
local b = lr.pad(a, {axes={[-1]={1, 2}}})
assert(lr.array_equal(b, {{0, 1, 2, 0, 0}, {0, 3, 4, 0, 0}}))
assert(b.dtype == "int32" and b.flags.owndata and b.flags.f_contiguous)
assert(not lr.shares_memory(a, b) and a:tobytes() == original)
assert(lr.array_equal(lr.pad(a, 1, "constant", {constant_values={{10, 20}, {30, 40}}}),
    {{30, 10, 10, 40}, {30, 1, 2, 40}, {30, 3, 4, 40}, {30, 20, 20, 40}}))

assert(lr.array_equal(lr.pad({1, 2, 3}, {7, 5}, "wrap"),
    {3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2}))
assert(lr.array_equal(lr.pad({1, 2, 3}, {4, 2}, "reflect", {reflect_type="odd"}),
    {-3, -2, -1, 0, 1, 2, 3, 4, 5}))
assert(lr.array_equal(lr.pad({1, 2, 3}, {2, 3}, "symmetric"), {2, 1, 1, 2, 3, 3, 2, 1}))
assert(lr.array_equal(lr.pad({2, 4}, {2, 3}, "linear_ramp"), {0, 1, 2, 4, 2, 1, 0}))
assert(lr.array_equal(lr.pad({1, 4}, 1, "mean"), {2, 1, 4, 2}))
local dates = lr.array({3, 1, 2}, "datetime64[D]")
assert(lr.array_equal(lr.pad(dates, 1, "maximum"):view("int64"), {3, 3, 1, 2, 3}))
local complex = lr.array({lr.complex(2, 1), lr.complex(1, 0), lr.complex(3, 2)})
assert(lr.pad(complex, 1, "median")[1] == lr.complex(2, 1))

local calls = {}
local custom = lr.pad(a, 1, function(vector, widths, axis, config)
    calls[axis] = (calls[axis] or 0) + 1
    vector:set(config.value, lr.s(1, widths[1]+1))
    vector:set(config.value, lr.s(-widths[2], nil))
end, {value=8})
assert(calls[1] == 4 and calls[2] == 4)
assert(lr.array_equal(custom, {{8, 8, 8, 8}, {8, 1, 2, 8}, {8, 3, 4, 8}, {8, 8, 8, 8}}))

local empty_padded = lr.pad(a, 2, "empty")
assert(lr.array_equal(empty_padded:get(lr.s(3, 5), lr.s(3, 5)), a))
assert(not pcall(lr.pad, a, -1))
assert(not pcall(lr.pad, lr.empty({0, 3}), 1, "edge"))
assert(not pcall(lr.pad, a, 1, "mean", {constant_values=2}))
assert(not pcall(lr.pad, a, {axes={[1]=0, [-2]=1}}))
print("Array padding regression passed")
