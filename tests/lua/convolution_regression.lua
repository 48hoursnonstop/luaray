local lr = require("luaray")

local signal = lr.array({1, 2, 3, 4}, "int32")
local kernel = lr.array({1, -1}, "int32")
local full = lr.convolve(signal, kernel)
assert(full.dtype == "int32")
assert(lr.array_equal(full, {1, 1, 1, 1, -4}))
assert(lr.array_equal(lr.convolve(kernel, signal, "same"), {1, 1, 1, 1}))
assert(lr.array_equal(lr.correlate(signal, kernel), {-1, -1, -1}))
assert(lr.array_equal(lr.correlate(kernel, signal, "full"), {4, -1, -1, -1, -1}))
assert(lr.array_equal(lr.convolve(lr.flip(signal), {1, 0, 2}, "same"), {3, 10, 7, 4}))

local x = {lr.complex(1, 2), lr.complex(3, 4)}
local y = {lr.complex(2, -1), lr.complex(0, 1)}
local correlation = lr.correlate(x, y, "full")
assert(lr.array_equal(lr.real(correlation), {2, 4, 2}))
assert(lr.array_equal(lr.imag(correlation), {-1, 2, 11}))
assert(lr.array_equal(lr.convolve(lr.array(2), signal), {2, 4, 6, 8}))

assert(not pcall(lr.convolve, {}, signal))
assert(not pcall(lr.correlate, signal, {{1, 2}}))
assert(not pcall(lr.convolve, signal, kernel, "unknown"))
assert(lr.array_equal(signal, {1, 2, 3, 4}))
print("Convolution and correlation regression passed")
