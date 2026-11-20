local lr = require("luaray")

local a = lr.fromstring("1, 2, -3", {sep = ",", dtype = "int16"})
assert(a.dtype == "int16" and a.ndim == 1 and a.flags.owndata)
assert(a[1] == 1 and a[2] == 2 and a[3] == -3)
assert(lr.fromstring("1 ; ; 2", {sep = "; ;", count = 2})[2] == 2)
assert(lr.fromstring("1,2,ignored", {sep = ",", count = 2}).size == 2)
assert(lr.fromstring("ignored", {sep = ",", count = 0}).size == 0)

local z = lr.fromstring("2-3j,4j", {sep = ",", dtype = lr.dtype("complex128")})
assert(z[1].real == 2 and z[1].imag == -3)
assert(z[2].real == 0 and z[2].imag == 4)
local u = lr.fromstring("18446744073709551615", {sep = " ", dtype = "uint64"})
assert(u:tobytes() == string.rep("\255", 8))
assert(lr.fromstring("200", {sep = ",", dtype = "int8"})[1] == -56)

for _, case in ipairs({
    {"1,2", {sep = ",", count = 3}},
    {"1\0,2", {sep = ","}},
    {"1,@", {sep = ","}},
    {"1", {sep = ""}},
    {"1", {sep = "\0"}},
    {"1", {sep = ",", dtype = "S4"}},
    {"1", {sep = ",", dtype = "clongdouble"}},
    {"1", {sep = ",", count = 1.5}},
    {"1", {sep = ",", offset = 1}},
}) do
    assert(not pcall(lr.fromstring, case[1], case[2]))
end
print("fromstring regression passed")
