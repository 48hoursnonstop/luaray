local np=require('luaray_core')
local checks=0
local function eq(a,b)
 checks=checks+1
 if type(b)=='table' then assert(type(a)=='table' and #a==#b);for i=1,#b do eq(a[i],b[i]) end
 else assert(a==b,tostring(a)..' != '..tostring(b)) end
end
local function fails(fn,fragment)
 checks=checks+1;local ok,err=pcall(fn);assert(not ok,'expected where/select rejection')
 if fragment then assert(tostring(err):find(fragment,1,true),tostring(err)) end
end
local a=np.array({{1,2,3},{4,5,6}},'int32')
local mask=np.greater(a,3)
local out=np.where(mask,a,0)
eq(out:tolist(),{{0,0,0},{4,5,6}});eq(out.dtype,'int32')
eq(np.shares_memory(out,a),false)
out:set(99,2,1);eq(a:get(2,1),4)
eq(np.where(true,1,2).ndim,0);eq(np.where(false,1,2):get(),2)
eq(np.where(mask)[1]:tolist(),{2,2,2})
eq(np.where(np.array({0/0,0,1},'float64'),1,2):tolist(),{1,2,1})
fails(function()np.where(true)end,'zero-dimensional')
fails(function()np.where(mask,a)end)
fails(function()np.where(mask,a,0,1)end)
eq(np.select({np.less(a,3),np.greater(a,4)},{-1,9},0):tolist(),{{-1,-1,0},{0,9,9}})
eq(np.select({true,true},{10,20},0):get(),10)
eq(np.select({false},{10}):get(),0)
eq(np.select(np.array({true,false},'bool'),np.array({5,6},'int8')).dtype,'int8')
eq(np.select(np.array({true,false},'bool'),np.array({5,6},'int8')):get(),5)
-- Scalar iteration over ndarray choices must remain strong, including choose.
eq(np.choose(np.array({1,2},'int64'),np.array({10,20},'int8')).dtype,'int8')
eq(np.choose(np.array({1,2},'int64'),np.array({10,20},'int8')):tolist(),{10,20})
fails(function()np.select({}, {})end,'nonempty')
fails(function()np.select({true},{1,2})end)
fails(function()np.select({1},{10})end,'boolean')
fails(function()np.select({true},{1},0,1)end)
fails(function()np.select({true})end)
fails(function()np.select({true},{'x'})end) -- implicit numeric default cannot promote
local byte=np.array(1,'uint8')
fails(function()np.where(false,byte,300)end,'bounds')
eq(np.where(false,byte,np.array(300,'int64')):get(),300)
eq(np.select({false},{byte},300):get(),44)
fails(function()np.select({true,false},{300,byte},0)end,'casting')
local u=np.array(1,'uint64');local t=np.array(1,'timedelta64[h]')
fails(function()np.result_type(u,t)end)
fails(function()np.promote_types('uint64','timedelta64[h]')end)
fails(function()np.where(true,u,t)end)
fails(function()np.select({true},{u},t)end)
-- NpyIter converts both sides for power-of-two output widths, but casts only
-- the selected value for other fixed widths.
local invalid=np.array(string.char(255),'S1')
eq(np.where(false,invalid,np.array('x','U3')):get(),'x')
fails(function()np.where(false,invalid,np.array('x','U4'))end,'ascii')
-- Separate choice broadcasting prevents accidental eager scalar conversion.
fails(function()np.select({np.array({false,false,false},'bool')},{invalid},np.array('x','U3'))end,'ascii')
eq(np.select({false,false},{invalid,np.array({'x','x','x'},'U3')},np.array('x','U3')):tolist(),{'x','x','x'})
local conditions,choices={},{}
for i=1,128 do conditions[i]=false;choices[i]=i end
conditions[128]=true
eq(np.select(conditions,choices,-1):get(),128)
conditions[1]=true;eq(np.select(conditions,choices,-1):get(),1)
collectgarbage('collect')
print('select104 regression: '..checks..' checks passed')
