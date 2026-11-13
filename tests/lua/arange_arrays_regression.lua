local lr=require('luaray')
local checks=0
local function check(value)checks=checks+1;assert(value)end
local function reject(call)check(not pcall(call))end
local stop=lr.array(3,'float32');stop:setflags(false)
local a=lr.arange(stop)
check(a.dtype=='float64' and a.size==3 and a[3]==2)
check(a.flags.owndata and a.flags.writeable and not lr.shares_memory(a,stop))
check(not stop.flags.writeable and stop:tolist()==3)
a[1]=9;check(stop:tolist()==3)
check(lr.arange(lr.array(3,'uint64')).dtype=='float64')
check(lr.arange(lr.array(3,'longdouble')).dtype=='longdouble')
check(lr.arange(lr.array(3,'int8')).dtype=='int64')
local start=lr.array(256,'int64')
a=lr.arange(start,257,1,{dtype='uint8'});check(a.size==1 and a[1]==0)
reject(function()lr.arange(start,258,1,{dtype='uint8'})end)
check(start:tolist()==256)
reject(function()lr.arange(256,257,1,{dtype='uint8'})end)
local wide=lr.array(9007199254740993,'int64')
a=lr.arange(wide,9007199254740996,1,{dtype='longdouble'})
local integers=lr.astype(a,'int64')
check(integers[1]==9007199254740992 and integers[2]==9007199254740994 and integers[3]==9007199254740996)
local binary=string.pack('i8',3)
local unaligned=lr.ndarray({},{dtype='int64',buffer='x'..binary,offset=1})
check(not unaligned.flags.aligned and not unaligned.flags.writeable)
a=lr.arange(unaligned);check(a.size==3 and a[3]==2)
for _,dt in ipairs({'complex64','complex128','clongdouble'})do
 local bound=lr.array(lr.complex(3,-3),dt)
 local result=lr.arange(0,bound,1)
 check(result.size==(dt=='complex128' and 0 or 3))
 result=lr.arange(0,bound,1,{dtype='float64'})
 check(result.size==3 and result[3]==2)
 check(bound:tolist().imag==-3)
end
local z=lr.array(lr.complex(1,2),'complex64')
a=lr.arange(z,lr.array(lr.complex(4,5),'complex64'),1,{dtype='longdouble'})
check(a.size==3 and a[1]==1 and a[3]==3)
reject(function()lr.arange(z,lr.array(lr.complex(4,5),'complex64'),1,{dtype='float64'})end)
for _,call in ipairs({
 function()lr.arange(lr.array({3}))end,
 function()lr.arange(0,lr.array({3}),1)end,
 function()lr.arange(0,3,lr.array({1}))end,
 function()lr.arange(lr.array('3','U1'))end,
 function()lr.arange(lr.array(0,'datetime64[D]'))end,
 function()lr.arange(0,3,lr.array(0,'float32'))end,
 function()lr.arange(0,3,lr.array(0/0,'float32'))end,
 function()lr.arange(lr.array(3),{dtype='S3'})end,
})do reject(call)end
local co=coroutine.create(function()
 local bound=lr.ndarray({},{dtype='int64',buffer=string.pack('i8',4)})
 return lr.arange(bound)
end)
local ok,result=coroutine.resume(co);check(ok);co=nil;collectgarbage('collect')
check(result.size==4 and result[4]==3 and result.flags.owndata)
print('arange arrays regression: '..checks..' checks passed')
