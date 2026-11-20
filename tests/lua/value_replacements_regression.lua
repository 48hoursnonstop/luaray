local lr = require("luaray")

local values = lr.array({0/0, math.huge, -math.huge, -0.0, 2}, "float16")
local cleaned = lr.nan_to_num(values, {nan=5, posinf=6, neginf=-1})
assert(lr.array_equal(cleaned, {5, 6, -1, 0, 2}) and lr.isnan(values[1]))
assert(lr.signbit(cleaned[4]))
local reversed = lr.flip(values)
assert(rawequal(lr.nan_to_num(reversed, {copy=false}), reversed))
assert(lr.array_equal(values, {0, 65504, -65504, 0, 2}))
local z = lr.array({lr.complex(math.huge, 0/0), lr.complex(-math.huge, 4)}, "complex64")
local result = lr.nan_to_num(z, {nan=9, posinf=8, neginf=-7})
assert(lr.array_equal(lr.real(result), {8, -7}))
assert(lr.array_equal(lr.imag(result), {9, 4}))
assert(lr.nan_to_num(lr.array(math.huge,"longdouble")).dtype=="longdouble")
assert(not pcall(lr.nan_to_num, {0/0}, {copy=false}))
local readonly = lr.broadcast_to(lr.array(math.huge), {3})
assert(not pcall(lr.nan_to_num, readonly, {copy=false}))

local x = lr.array({-2, -1, 0, 1, 2})
local n = 0
local parts = lr.piecewise(x, {lr.less(x,0), lr.greater_equal(x,0), lr.equal(x,0)}, {
  function(v,k) n=n+1; assert(v.size==2); return lr.multiply(lr.negative(v),k) end,
  1,
  5
}, 3)
assert(n==1 and lr.array_equal(parts, {6, 3, 5, 1, 1}))
assert(lr.piecewise(lr.array(3), {true,false}, {function(v) return 2*v end, 0}):item()==6)
local unused = function() error("callback should be skipped") end
assert(lr.array_equal(lr.piecewise(x, {lr.greater(x,100)}, {unused,5}), {5,5,5,5,5}))
local matrix = lr.array({{1,2},{3,4},{5,6}})
local rows = lr.piecewise(matrix, {true,false,true}, {function(v) return v*2 end, 9})
assert(lr.array_equal(rows, {{2,4},{9,9},{10,12}}))
assert(not pcall(lr.piecewise, x, {{true},{false,true}}, {1,2}))

assert(rawequal(lr.pow,lr.power) and lr.pow(2,5):item()==32)
local fixed = lr.empty({3},"float64")
assert(rawequal(lr.fix({-1.2,0.3,2.9},fixed),fixed))
assert(lr.array_equal(fixed,{-1,0,2}))
print("Value replacement and piecewise regression passed")
