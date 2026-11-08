local np=require("luaray_core")
assert(np._version=="0.97.0-dev")
for _,seed in ipairs({0,1,42,9876}) do
  local rng=np.random.default_rng(seed)
  local t=rng:standard_t(4.5,{2,3})
  assert(t.dtype=="float64" and #t.shape==2 and t.shape[1]==2 and t.shape[2]==3)
  for i=1,2 do for j=1,3 do assert(type(t:get(i,j))=="number") end end
  local v=rng:vonmises(1.2,2.0,{2,3})
  assert(v.dtype=="float64" and #v.shape==2 and v.shape[1]==2 and v.shape[2]==3)
  for i=1,2 do for j=1,3 do assert(v:get(i,j)>=-math.pi and v:get(i,j)<=math.pi) end end
  assert(type(rng:standard_t(2))=="number")
  assert(type(rng:vonmises(1,3))=="number")
  assert(#rng:standard_t(2,{}).shape==0)
  assert(#rng:vonmises(1,3,{}).shape==0)
  assert(rng:standard_t(2,{0,4}).shape[1]==0)
  assert(rng:vonmises(1,3,{0,4}).shape[1]==0)
  assert(rng:standard_t(2,{2,0,4}).shape[2]==0)
  assert(rng:vonmises(1,3,{2,0,4}).shape[2]==0)
  assert(rng:vonmises(0,0)>=-math.pi)
  assert(rng:vonmises(0,0)<=math.pi)
  assert(rng:vonmises(1,math.huge)==1)
  assert(rng:vonmises(0,0/0)~=rng:vonmises(0,0/0))
  for _,f in ipairs({
    function()rng:standard_t(0)end,
    function()rng:standard_t(-1)end,
    function()rng:vonmises(0,-1)end,
    function()rng:standard_t(2,{-1})end,
    function()rng:vonmises(0,2,{-1})end,
    function()rng:standard_t(1,nil,1)end,
    function()rng:vonmises(0,2,nil,1)end,
  }) do assert(not pcall(f)) end
end
print("distributions71 Lua regression passed")
