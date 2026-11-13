local np=require("luaray_core")
assert(np._version=="0.137.0-dev")
for _,seed in ipairs({0,1,42,9876}) do
  local r=np.random.default_rng(seed)
  local w=r:wald(2,5,{2,3})
  assert(w.dtype=="float64" and #w.shape==2 and w.shape[1]==2 and w.shape[2]==3)
  for i=1,2 do for j=1,3 do assert(w:get(i,j)>0) end end
  local s=r:logseries(0.9,{2,3})
  assert(s.dtype=="int64" and #s.shape==2)
  for i=1,2 do for j=1,3 do assert(s:get(i,j)>=1 and math.type(s:get(i,j))=="integer") end end
  assert(math.type(r:logseries(0))=="integer")
  assert(type(r:wald(1,1))=="number")
  assert(r:wald(1,1,{}).shape[1]==nil)
  assert(r:logseries(0.5,{}).shape[1]==nil)
  assert(r:wald(1,1,{0,3}).shape[1]==0)
  assert(r:logseries(0.5,{0,3}).shape[1]==0)
  for _,cmd in ipairs({
    function()r:wald(0,1)end,function()r:wald(1,-1)end,
    function()r:logseries(-0.01)end,function()r:logseries(1)end,
    function()r:wald(1,1,{-1})end,function()r:logseries(.5,{-1})end,
    function()r:wald(1,1,{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32})end,
  }) do assert(not pcall(cmd)) end
end
print("distributions70 regression passed")
