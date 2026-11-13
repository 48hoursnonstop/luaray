local lr=require('luaray')
local checks=0
local function check(value)checks=checks+1;assert(value)end
local function reject(call)check(not pcall(call))end
local function values(a,expected)
 check(a.ndim==1 and a.size==#expected and a.flags.owndata and a.flags.writeable)
 for i,v in ipairs(expected)do check(a[i]==v)end
end
values(lr.arange(5),{0,1,2,3,4})
values(lr.arange(2,8,2),{2,4,6})
values(lr.arange(5,0,-2),{5,3,1})
values(lr.arange(-2),{})
values(lr.arange(4,1),{})
values(lr.arange(5,'float32'),{0,1,2,3,4})
check(lr.arange(5,lr.dtype('float32')).dtype=='float32')
values(lr.arange(0,1,.25,{dtype=lr.dtype('float32')}),{0,.25,.5,.75})
check(lr.arange(2.0).dtype=='float64')
check(lr.arange(true).dtype=='int64')
values(lr.arange(3,nil),{0,1,2})
values(lr.arange(3,nil,2),{0,2})
values(lr.arange(2,5,nil,'int32'),{2,3,4})
reject(function()lr.arange(0,3,1,'bool')end)
values(lr.arange(2,'bool'),{false,true})
values(lr.arange(4,'bool'),{false,true,true,true})
values(lr.arange(4,lr.dtype('bool')),{false,true,true,true})
reject(function()lr.arange(4,{dtype='bool'})end)
check(lr.arange(0,'U0').itemsize==0)
values(lr.arange(120,140,3,'int8'),{120,123,126,-127,-124,-121,-118})
values(lr.arange(250,270,3,'uint8'),{250,253,0,3,6,9,12})
values(lr.arange(0,3,.5,'int32'),{0,0,0,0,0,0})
values(lr.arange(100000000,100000005,1,'float32'),{100000000,100000000,100000000,100000000,100000000})
values(lr.arange(2048,2053,1,'float16'),{2048,2048,2048,2048,2048})
values(lr.arange(math.mininteger,math.maxinteger,math.maxinteger),{math.mininteger,-1})
local large=lr.arange(math.maxinteger,2.0^64+2^60,math.maxinteger,'uint64')
check(large.size==2)
check(lr.astype(large,'U40')[2]=='18446744073709551614')
values(lr.arange(0,3,math.huge),{0})
values(lr.arange(0,3,-math.huge),{})
values(lr.arange(0,5e-324,1e308),{0})
local z=lr.arange(0,lr.complex(3,3),1)
check(z.dtype=='complex128' and z.size==3 and z[3].real==2 and z[3].imag==0)
check(lr.arange(0,lr.complex(3,3),lr.complex(1,1)).size==0)
check(lr.arange(0,lr.complex(3,3),lr.complex(math.huge,math.huge)).size==0)
local a=lr.arange(4);a[1]=9;check(lr.arange(4)[1]==0)
for _,call in ipairs({
 function()lr.arange()end,
 function()lr.arange(1,2,3,4,5)end,
 function()lr.arange(1,2,3,4)end,
 function()lr.arange({1,2})end,
 function()lr.arange(lr.array(3))end,
 function()lr.arange(0,3,0)end,
 function()lr.arange(0,0,-0.0)end,
 function()lr.arange(0,3,0/0)end,
 function()lr.arange(0,3,5e-324)end,
 function()lr.arange(0,math.huge)end,
 function()lr.arange(0,2,{unknown=true})end,
 function()lr.arange(0,2,'int32\0extra')end,
 function()lr.arange(0,3,1,'S0')end,
 function()lr.arange(0,3,1,'U3')end,
 function()lr.arange(0,3,1,'datetime64[D]')end,
 function()lr.arange(0,lr.complex(3,3),1,'float64')end,
 function()lr.arange(256,258,1,'uint8')end,
 function()lr.arange(255,258,1,'uint8')end,
 function()lr.arange(math.maxinteger,2.0^64+2^60,math.maxinteger,'int64')end,
})do reject(call)end
print('arange regression: '..checks..' checks passed')
