local lr=require('luaray')
local checks=0
local function check(value)checks=checks+1;assert(value)end
local function reject(call)check(not pcall(call))end
local a=lr.array({1,4,9},'int64')
check(lr.diff(a)[2]==5 and lr.diff(a,2)[1]==2)
local original={1,2};check(rawequal(lr.diff(original,{n=0,axis='ignored'}),original))
check(lr.diff(nil,0)==nil and rawequal(lr.diff(a,0),a))
check(lr.diff(a,math.maxinteger).size==0)
local padded=lr.diff(a,{prepend=0,append=16})
check(padded.size==4 and padded[1]==1 and padded[4]==7)
local boolean=lr.diff({true,true,false},2);check(boolean.dtype=='bool' and boolean[1])
local unsigned=lr.diff(lr.array({1,0},'uint8'));check(unsigned.dtype=='uint8' and unsigned[1]==255)
local f=lr.asfortranarray(lr.arange(12):reshape({2,3,2}))
local fd=lr.diff(f);check(fd.shape[3]==1 and fd.strides[1]==8 and fd.strides[2]==16 and fd.strides[3]==48)
local direct=lr.not_equal(lr.asfortranarray(lr.zeros({2,3,1},'bool')),lr.asfortranarray(lr.ones({2,3,1},'bool')))
check(direct.strides[1]==1 and direct.strides[2]==2 and direct.strides[3]==6)
local fp=lr.diff(lr.asfortranarray(lr.arange(6):reshape({2,3})),{prepend=0})
check(fp.strides[1]==8 and fp.strides[2]==16 and fp:get(2,1)==3)
local time=lr.array({1,3,8},'datetime64[ms]');local dt=lr.diff(time)
check(dt.dtype=='timedelta64[ms]' and lr.astype(dt,'int64')[2]==5)
local ed=lr.ediff1d({{1,4},{9,16}},{to_begin=0,to_end={8,7}})
check(ed.size==6 and ed[1]==0 and ed[2]==3 and ed[6]==7)
local small=lr.ediff1d(lr.array({1,4},'int8'),{to_begin=lr.array({256},'int64')})
check(small.dtype=='int8' and small[1]==0 and small[2]==3)
check(lr.ediff1d(lr.array(7,'int16')).size==0)
check(lr.ediff1d(lr.array({},'float64'),{to_begin=1.5})[1]==1.5)
check(lr.ediff1d(lr.array({1,4},'float32'),{to_end=2}).dtype=='float32')
local copy=lr.diff(a);copy[1]=99;check(a[1]==1)
for _,call in ipairs({
 function()lr.diff(a,-1)end,
 function()lr.diff(a,1.0)end,
 function()lr.diff(a,true)end,
 function()lr.diff(a,1,0)end,
 function()lr.diff(a,{axis=2})end,
 function()lr.diff(a,{axis=true})end,
 function()lr.diff(a,{unknown=1})end,
 function()lr.diff(a,{['n\0']=1})end,
 function()lr.diff(a,{},1)end,
 function()lr.diff(a,1,1,1)end,
 function()lr.diff(2)end,
 function()lr.diff(lr.ones({2,3}),{prepend={1,2,3}})end,
 function()lr.ediff1d({true,false})end,
 function()lr.ediff1d(a,{to_begin=1.5})end,
 function()lr.ediff1d(a,false)end,
 function()lr.ediff1d(a,{unknown=1})end,
 function()lr.ediff1d(a,{},1)end,
 function()lr.ediff1d(time,{to_begin=lr.array({0},'datetime64[ms]')})end,
})do reject(call)end
print('differences regression: '..checks..' checks passed')
