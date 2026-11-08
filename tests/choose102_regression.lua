local np=require('luaray_core')
local checks=0
local function eq(a,b)
 checks=checks+1
 if type(b)=='table' then assert(type(a)=='table' and #a==#b);for i=1,#b do eq(a[i],b[i]) end
 else assert(a==b,tostring(a)..' != '..tostring(b)) end
end
local function fails(fn,fragment)
 checks=checks+1;local ok,err=pcall(fn);assert(not ok,'expected choose rejection')
 if fragment then assert(tostring(err):find(fragment,1,true),tostring(err)) end
end
local indices=np.array({1,2,1},'int64')
eq(np.choose(indices,{{10,11,12},{20,21,22}}):tolist(),{10,21,12})
eq(indices:choose({10,20}):tolist(),{10,20,10})
eq(np.choose(1,{10,20}),10)
eq(np.choose(-1,{10,20},'wrap'),20)
eq(np.choose(-1,{10,20},'clip'),10)
fails(function()np.choose(-1,{10,20})end,'invalid entry')
for _,mode in ipairs({'raise','wrap','clip'}) do
 fails(function()np.choose(0,{10,20},mode)end,'index 0')
end
local out=np.array(0,'int64')
eq(np.choose(1,{10,20},{out=out}),out);eq(out:get(),10)
local f=np.array({1},'float32')
eq(np.choose(np.array({1,2},'int64'),{f,2}).dtype,'float32')
fails(function()np.choose({1.9},{10,20})end)
fails(function()np.choose(np.array({1},'uint64'),{10,20})end)
fails(function()np.choose(1,{})end)
fails(function()np.choose(1,np.array(3))end)
fails(function()np.choose(1,{10,20},'bad')end)
fails(function()np.choose(1,{10,20},{out={}})end)
fails(function()np.choose(1,{10,20},nil,4)end)
fails(function()np.choose(1)end)
local too_many={};for i=1,64 do too_many[i]=i end
fails(function()np.choose(1,too_many)end)
local readonly=np.broadcast_to(np.array({0},'int64'),{3})
fails(function()np.choose(indices,{10,20},{out=readonly})end,'read-only')
local unchanged=np.array({8,9,10},'int64')
fails(function()np.choose(np.array({1,3,2},'int64'),{10,20},{out=unchanged})end)
eq(unchanged:tolist(),{8,9,10})
local old=np.array({'bad','bad','bad'},'U4')
np.choose(indices,{np.array(10),np.array(20)},{out=old})
eq(old:tolist(),{'10','20','10'}) -- unlike take, choose does not preconvert old out
local parent=np.array({-9,-9,-9,-9,-9,-9,-9,-9},'int64')
local strided=parent:get(np.s(2,8,2))
np.choose(indices,{10,20},{mode='wrap',out=strided})
eq(parent:tolist(),{-9,10,20,10,-9,-9,-9,-9}) -- actual direct linear write
local records=dofile('tests/choose102_reference_differences.lua')
for _,record in ipairs(records) do
 for _,mode in ipairs({'wrap','clip'}) do
  local owner,target=record.setup(np);local before=owner:tolist()
  fails(function()np.choose(indices,{10,20},{out=target,mode=mode})end,'owning buffer')
  eq(owner:tolist(),before)
 end
end
-- An identical strided target is safe via the ordinary staged raise path.
local owner,target=records[1].setup(np)
np.choose(indices,{10,20},{out=target})
eq(owner:tolist(),{10,20,10})
-- Source-derived modular calculation: upstream's repeated-subtraction loop
-- was not executed for these extreme values.
eq(np.choose(np.array({math.mininteger,math.maxinteger},'int64'),{10,20,30},'wrap'):tolist(),{20,10})
collectgarbage('collect')
print(('choose102 regression: %d checks passed; %d unsafe-span variants outside parity'):format(checks,#records))
