local np=require('luaray_core')
assert(np._version=='0.127.0-dev')
local r=np.random.default_rng(42)
local g=r:gumbel(-2.5,0.25,{2,3})
local l=r:logistic(0,1,{0,2})
local y=r:rayleigh(2,{3,2})
local w=r:weibull(1.5,{3,2})
assert(g.dtype=='float64' and g.shape[1]==2 and g.shape[2]==3)
assert(l.dtype=='float64' and l.shape[1]==0 and l.shape[2]==2)
assert(y.dtype=='float64' and y.shape[1]==3 and y.shape[2]==2)
assert(w.dtype=='float64' and w.shape[1]==3 and w.shape[2]==2)
for i=1,3 do for j=1,2 do assert(y:get(i,j)>=0 and w:get(i,j)>=0) end end
local r2=np.random.default_rng(42)
local n1=r2:raw_hex()
r2:reseed(42)
assert(r2:weibull(0)==0)
assert(r2:raw_hex()==n1)
for _,case in ipairs({function()r2:gumbel(0,-1)end,
    function()r2:logistic(0,-1)end,function()r2:rayleigh(-1)end,
    function()r2:weibull(-1)end}) do
    local t=np.random.default_rng(42)
    -- Invalid cases must throw rather than return an incorrect distribution.
    assert(not pcall(case))
end
print('distributions56 Lua regression passed')
