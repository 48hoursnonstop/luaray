local lr = require('luaray')
local a = lr.array({{1,2},{3,4}},'int32')
local b = lr.matvec(a,{2,1})
assert(b[1] == 4 and b[2] == 10)
local out = lr.empty({3,2},'float64')
assert(rawequal(lr.matvec(a,{2,1},{out=out}),out))
assert(out[3][1] == 4 and out[3][2] == 10)

local z = lr.complex(1,2)
local r = lr.vecmat({z},{{lr.complex(3,4),1}})
assert(r[1] == lr.complex(11,-2) and r[2] == lr.complex(1,-2))
assert(lr.vecdot({z},{lr.complex(3,4)}) == lr.complex(11,-2))
assert(lr.vdot({{z}},{{lr.complex(3,4)}}) == lr.complex(11,-2))
assert(lr.vdot(lr.array({2,3},'timedelta64[h]'),lr.array({3,4},'timedelta64[h]')) == lr.timedelta64(18,'h'))

local shape={}
for axis=1,64 do shape[axis]=1 end
shape[64]=2
local high=lr.reshape(lr.array({1,2},'int16'),shape)
local reduced=lr.linalg.vecdot(high,high)
assert(reduced.ndim==63 and reduced:item()==5)

local bytes=string.char(0)..string.pack('<d',2)..string.pack('<d',5)
local unaligned=lr.ndarray({2},{dtype='float64',buffer=bytes,offset=1})
assert(not unaligned.flags.aligned)
assert(lr.vecdot(unaligned,unaligned)==29)
assert(not pcall(lr.matvec, lr.array({1,2}), lr.array({1,2})))
assert(not pcall(lr.vecdot, lr.array({1,2}), lr.array({1})))
assert(not pcall(lr.vdot,lr.array(1),{1,2}))
local bad=lr.empty({3,3})
assert(not pcall(lr.matvec,a,{2,1},bad))
print('Vector products regression passed')
