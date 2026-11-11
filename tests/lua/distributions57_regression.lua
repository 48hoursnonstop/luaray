local np = require('luaray_core')
assert(np._version == '0.127.0-dev')
local rng=np.random.default_rng(42)
local a=rng:pareto(2, {2,3})
local b=rng:power(2, {2,3})
local c=rng:triangular(-1,0,2, {2,3})
assert(a.dtype=='float64' and a.shape[1]==2 and a.shape[2]==3)
assert(b.dtype=='float64' and b.shape[1]==2 and b.shape[2]==3)
assert(c.dtype=='float64' and c.shape[1]==2 and c.shape[2]==3)
for i=1,2 do for j=1,3 do
    assert(a:get(i,j)>=0)
    assert(b:get(i,j)>=0 and b:get(i,j)<=1)
    assert(c:get(i,j)>=-1 and c:get(i,j)<=2)
end end
local r1=np.random.default_rng(42)
local expected=r1:raw_hex()
for _,case in ipairs({
    function(r)r:pareto(0)end,
    function(r)r:pareto(-1)end,
    function(r)r:power(0)end,
    function(r)r:power(-1)end,
    function(r)r:triangular(2,1,3)end,
    function(r)r:triangular(1,3,2)end,
    function(r)r:triangular(1,1,1)end,
    function(r)r:power(2,-1)end,
    function(r)r:pareto(2,{-1})end,
}) do
    local r=np.random.default_rng(42)
    assert(not pcall(case,r))
    assert(r:raw_hex()==expected)
end
print('distributions57 Lua regression passed')
