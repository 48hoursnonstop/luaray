local np=require('luaray_core')
local checks=0
local function eq(a,b)
 checks=checks+1
 if type(b)=='table' then assert(type(a)=='table' and #a==#b);for i=1,#b do eq(a[i],b[i]) end
 else assert(a==b,tostring(a)..' != '..tostring(b)) end
end
local function fails(fn,fragment)
 checks=checks+1;local ok,err=pcall(fn);assert(not ok,'expected take rejection')
 if fragment then assert(tostring(err):find(fragment,1,true),tostring(err)) end
end
local a=np.array({{1,2,3},{4,5,6}},'int32')
eq(np.take(a,-1),6)
eq(np.take({1,2,3},{-1,1}):tolist(),{3,1})
eq(a:take({1,-1},{axis=2}):tolist(),{{1,3},{4,6}})
eq(np.take(a,{{1,-1},{2,1}},{axis=-1}).shape,{2,2,2})
eq(np.take(np.array(3),1),3)
eq(np.take(3,{{1,1}}):tolist(),{{3,3}})
local out=np.array(0,'float64')
eq(np.take(a,1,{out=out}),out);eq(out:get(),1)
local result=np.take(a,{1,-1});eq(np.shares_memory(result,a),false)
result:set(90,1);eq(a:get(1,1),1)
for _,mode in ipairs({'raise','wrap','clip'}) do
 fails(function()np.take(a,0,{mode=mode})end,'index 0')
end
fails(function()np.take(a,1,0)end)
fails(function()np.take(a,1,3)end)
fails(function()np.take(a,1,true)end)
fails(function()np.take(a,1,{mode='other'})end)
fails(function()np.take(a,1,{out={}})end)
fails(function()np.take(a,nil)end)
fails(function()np.take(a,np.array({1.5},'float64'))end)
local target=np.array({8,9},'int32')
fails(function()np.take(a,{1,99},{out=target})end,'bounds')
eq(target:tolist(),{8,9})
local textout=np.array({'bad','bad'},'U3')
fails(function()np.take(a,{1,2},{out=textout})end)
eq(textout:tolist(),{'bad','bad'})
local letters=np.array({'a','β'},'U4')
local ascii=np.array({'xxxx','xxxx'},'S4')
fails(function()np.take(letters,{1,2},{out=ascii})end)
eq(ascii:tolist(),{'a','xxxx'}) -- the failing scalar keeps its previous bytes
local extreme=np.array({math.mininteger,math.maxinteger},'int64')
eq(np.take(np.array({10,20,30},'int32'),extreme,{mode='wrap'}):tolist(),{20,10})
local same=np.array({1,2,3},'int32')
eq(np.take(same,{-1,-2,-3},{out=same,mode='wrap'}),same)
eq(same:tolist(),{3,2,1})
local source=np.array({{-1,-2},{-3,-1},{-2,-3}},'int64')
local owner=np.array({-1,-2,-1,-2},'int64')
local output=owner:reshape({2,2});local indices=owner:get(np.s(1,3))
np.take(source,indices,{axis=1,out=output,mode='wrap'})
eq(owner:tolist(),{-2,-3,-1,-2}) -- a complete chunk changes the next live index
local readonly=np.broadcast_to(np.array({0},'int32'),{2})
fails(function()np.take(a,{1,2},{out=readonly})end,'read-only')
local records=dofile('tests/lua/take100_reference_differences.lua')
for _,record in ipairs(records) do
 fails(function()np.take(np.zeros(record.shape,'int32'),record.indices,{axis=record.axis,mode=record.mode})end,'empty axis')
end
collectgarbage('collect')
print(('take100 regression: %d checks passed; %d deliberate hang-class rejections outside parity'):format(checks,#records))
