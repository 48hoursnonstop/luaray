local np=require("luaray_core")
assert(np._version=="0.132.0-dev")
local function near(x,y,tol) return math.abs(x-y)<=tol end
for _,alpha in ipairs({{1,2,3},{0.01,0.02,0.03},{0.1,0.0999},{0,0.03,0.01},{0.01,0,0},{0,0,0},{1},{0},{}}) do
  for _,sz in ipairs({{}, {2,3}, {0}, {1,0,3}}) do
    local rng=np.random.default_rng(42)
    local a=rng:dirichlet(alpha,sz)
    assert(a.dtype=="float64" and #a.shape==#sz+1 and a.shape[#sz+1]==#alpha)
    for d=1,#sz do assert(a.shape[d]==sz[d]) end
    if #alpha>0 and sz[1]~=0 and sz[2]~=0 then
      if #sz==0 then
        local total=0
        for j=1,#alpha do total=total+a:get(j) end
        if alpha[1]~=0 or #alpha>1 and (alpha[2]~=0 or alpha[3] and alpha[3]~=0) then
          assert(near(total,1,1e-12) or total~=total)
        else assert(total==0 or total~=total) end
      end
    end
  end
end
local r=np.random.default_rng(15)
local b=r:dirichlet(np.array({1.0,2.0,3.0},"float64"),{2,3})
assert(b.shape[1]==2 and b.shape[2]==3 and b.shape[3]==3)
for i=1,2 do for j=1,3 do
  local sum=0
  for k=1,3 do sum=sum+b:get(i,j,k) end
  assert(near(sum,1,1e-13))
end end
local q=np.random.default_rng(1)
local before=q:raw_hex()
assert(q:dirichlet({0,0},{4}):get(1,1)==0)
assert(q:dirichlet({},{3}).shape[2]==0)
assert(q:dirichlet({1,2},{0}).shape[1]==0)
assert(q:raw_hex()~=before) -- raw_hex consumes state
for _,alpha in ipairs({{-1,2},{0/0,1},{math.huge,1},{"x",2},{1,-0.5}}) do
  local rr=np.random.default_rng(42)
  local ok=pcall(function()rr:dirichlet(alpha)end)
  assert(not ok)
end
assert(not pcall(function()np.random.default_rng(1):dirichlet({1,2},{-1})end))
assert(not pcall(function()np.random.default_rng(1):dirichlet({1,2},{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32})end))
print("distributions69 regression passed")
