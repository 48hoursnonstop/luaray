local lr=require('luaray')
local checks=0
local function check(value)checks=checks+1;assert(value)end
local function reject(call)check(not pcall(call))end
local a=lr.arange(6):reshape({2,3})
check(lr.ndim(a)==2 and lr.size(a)==6)
check(lr.size(a,1)==2 and lr.size(a,2)==3 and lr.size(a,-1)==3 and lr.size(a,-2)==2)
local shape=lr.shape(a);check(shape[1]==2 and shape[2]==3 and #shape==2)
shape[1]=99;check(lr.shape(a)[1]==2 and a.shape[1]==2)
check(lr.ndim(7)==0 and lr.size(7)==1 and #lr.shape(7)==0)
check(lr.ndim(true)==0 and lr.size('α')==1)
check(lr.size({1,2,3})==3 and lr.size({{1,2},{3,4}},-1)==2)
check(lr.ndim({{}, {}})==2 and lr.size({{}, {}})==0)
check(lr.shape({{}, {}})[1]==2 and lr.shape({{}, {}})[2]==0)
check(lr.ndim(lr.complex(1,2))==0)
check(lr.size(lr.datetime64(1,'D'))==1)
local readonly=lr.frombuffer(string.pack('i4i4',1,2),'int32')
check(lr.size(readonly)==2 and not readonly.flags.writeable)
local big=lr.broadcast_to(lr.array(1,'int8'),{2^30,2^20})
check(lr.size(big)==2^50 and lr.size(big,1)==2^30)
check(lr.ndim(big)==2 and not big.flags.writeable)
local rank64={};for i=1,64 do rank64[i]=1 end
check(lr.ndim(lr.zeros(rank64,'int8'))==64)
local nested=7;for i=1,64 do nested={nested}end
check(lr.ndim(nested)==64 and lr.size(nested)==1)
check(lr.size({1,2,3},nil)==3)
for _,call in ipairs({
 function()lr.shape()end,
 function()lr.shape(a,a)end,
 function()lr.ndim()end,
 function()lr.ndim(a,a)end,
 function()lr.size()end,
 function()lr.size(a,1,2)end,
 function()lr.size(a,0)end,
 function()lr.size(a,3)end,
 function()lr.size(a,-3)end,
 function()lr.size(a,1.0)end,
 function()lr.size(a,true)end,
 function()lr.size(a,'1')end,
 function()lr.size(a,{1})end,
 function()lr.size(1,1)end,
 function()lr.shape({{1,2},{3}})end,
 function()lr.ndim({1,{2}})end,
 function()lr.size({{1},2})end,
 function()lr.ndim({nested})end,
})do reject(call)end
print('metadata regression: '..checks..' checks passed')
