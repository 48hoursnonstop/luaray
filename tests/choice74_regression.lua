local np=require('luaray_core')
assert(np._version=='0.101.0-dev')
local function eq(a,b)
 if type(a)~=type(b) then return false end
 if type(a)~='table' then return a==b end
 if #a~=#b then return false end
 for i=1,#a do if not eq(a[i],b[i]) then return false end end
 return true
end
local function bad(f)
 local ok,ret=pcall(f)
 assert(not ok,'expected error, got '..tostring(ret))
end
local r=np.random.default_rng(42)
local out=r:choice(100,20,false)
assert(out.dtype=='int64' and out.size==20)
local vals=out:tolist()
local seen={}
for _,v in ipairs(vals) do assert(v>=0 and v<100 and not seen[v]); seen[v]=true end
local x=np.arange(24,'int64'):reshape({2,3,4})
local before=x:tolist()
local y=r:choice(x,{2,1},false,nil,2)
assert(eq(x:tolist(),before))
assert(eq(y.shape,{2,2,1,4}))
assert(y.dtype=='int64')
local a=np.array({'fox','cat','owl','ant'})
local q=r:choice(a,8)
assert(q.size==8 and q.dtype==a.dtype)
local vocabulary={fox=true,cat=true,owl=true,ant=true}
for _,v in ipairs(q:tolist()) do assert(vocabulary[v]) end
local b=np.array({true,false,true,false})
local c=r:choice(b,{2,3},true,{0,0.1,0.3,0.6})
assert(c.dtype=='bool' and eq(c.shape,{2,3}))
local zeros=r:choice(0,0)
assert(eq(zeros.shape,{0}))
local z=r:choice(0,{3,0})
assert(eq(z.shape,{3,0}))
local old=r:choice({12,14,16},nil)
assert(old==12 or old==14 or old==16)
local scalar_arr=r:choice(np.array({10,20,30}),{})
assert(eq(scalar_arr.shape,{}) and (scalar_arr:tolist()==10 or scalar_arr:tolist()==20 or scalar_arr:tolist()==30))
local zero_dim=r:choice(np.arange(12,'int64'):reshape({3,4}),nil,true,nil,1)
assert(eq(zero_dim.shape,{4}))
local frac=np.array({0.1,0.2,0.7},'float32')
local val=r:choice(3,5,true,frac)
assert(val.size==5)
local x2=np.flip(np.arange(20,'int64'):reshape({4,5}),1)
local w=r:choice(x2,2,false,nil,2)
assert(eq(w.shape,{4,2}))
-- Input validation must happen before draws (PCG64 state is unaffected).
local cases={
 function() r:choice(0) end,
 function() r:choice(-1,2) end,
 function() r:choice(2,3,false) end,
 function() r:choice({1,2},3,false) end,
 function() r:choice({1,2},2,true,{0.3,0.8}) end,
 function() r:choice(2,3,true,{0.5,-0.5}) end,
 function() r:choice(2,3,true,{0/0,1.0}) end,
 function() r:choice(2,3,true,{math.huge,0}) end,
 function() r:choice(4,3,false,{1,0,0,0}) end,
 function() r:choice(2,2,true,{1,0,0}) end,
 function() r:choice(2,2,true,np.array({{1,0}})) end,
 function() r:choice(4,2,true,nil,0) end, -- scalar population ignores axis in NumPy (actually should succeed)
 function() r:choice(np.arange(8,'int64'):reshape({2,4}),2,true,nil,3) end,
 function() r:choice(np.array(5.0)) end,
 function() r:choice(3,-1) end,
 function() r:choice(3,1,'yes') end,
 function() r:choice(3,1,true,nil,1,'no') end,
 function() r:choice(3,1,true,nil,1,true,123) end,
}
-- 0-D integer ndarrays are accepted as integer populations, as in NumPy.
assert(r:choice(np.array(5),3).size==3)
-- The axis parameter is ignored for an integer population.
assert(r:choice(4,2,true,nil,0).size==2)
table.remove(cases,12)
for _,f in ipairs(cases) do bad(f) end
print('choice74 Lua regression passed')
