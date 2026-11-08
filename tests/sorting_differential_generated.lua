local np=require("luaray_core")
local function eq(a,b)
  if type(a)~=type(b) then return false end
  if type(a)~="table" then if type(a)=="number" and a~=a and b~=b then return true end; return a==b end
  if #a~=#b then return false end; for i=1,#a do if not eq(a[i],b[i]) then return false end end; return true
end
local function close(a,b)
  if type(a)~=type(b) then return false end
  if type(a)~="table" then if type(a)=="number" then if a~=a and b~=b then return true end; if a==b then return true end; return math.abs(a-b)<=math.max(1e-6,math.abs(b)*2e-6) end; return a==b end
  if #a~=#b then return false end; for i=1,#a do if not close(a[i],b[i]) then return false end end; return true
end
-- Generated against development NumPy 2.3.5.
do -- sort 0
  local a=np.array({{-114},{-77},{-40}},np.int16)
  local r=np.sort(a,2)
  assert(r.dtype=="int16","sort 0 dtype "..r.dtype)
  assert(eq(r.shape,{3,1}),"sort 0 shape")
  assert(eq(r.strides,{2,2}),"sort 0 strides")
  assert(close(r:tolist(),{{-114},{-77},{-40}}),"sort 0 values")
  assert(close(a:tolist(),{{-114},{-77},{-40}}),"sort 0 input mutation")
end
do -- sort 1
  local a=np.array({{{-103,-66,-29},{8,45,82},{119,-95,-58}},{{-21,16,53},{90,-124,-87},{-50,-13,24}},{{61,98,-116},{-79,-42,-5},{32,69,106}},{{-108,-71,-34},{3,40,77},{114,-100,-63}},{{-26,11,48},{85,122,-92},{-55,-18,19}}},np.int64)
  local r=np.sort(a,1)
  assert(r.dtype=="int64","sort 1 dtype "..r.dtype)
  assert(eq(r.shape,{5,3,3}),"sort 1 shape")
  assert(eq(r.strides,{72,24,8}),"sort 1 strides")
  assert(close(r:tolist(),{{{-108,-71,-116},{-79,-124,-92},{-55,-100,-63}},{{-103,-66,-34},{3,-42,-87},{-50,-95,-58}},{{-26,11,-29},{8,40,-5},{32,-18,19}},{{-21,16,48},{85,45,77},{114,-13,24}},{{61,98,53},{90,122,82},{119,69,106}}}),"sort 1 values")
  assert(close(a:tolist(),{{{-103,-66,-29},{8,45,82},{119,-95,-58}},{{-21,16,53},{90,-124,-87},{-50,-13,24}},{{61,98,-116},{-79,-42,-5},{32,69,106}},{{-108,-71,-34},{3,40,77},{114,-100,-63}},{{-26,11,48},{85,122,-92},{-55,-18,19}}}),"sort 1 input mutation")
end
do -- sort 2
  local a=np.array({33,70},np.uint8)
  local r=np.sort(a,1)
  assert(r.dtype=="uint8","sort 2 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"sort 2 shape")
  assert(eq(r.strides,{1}),"sort 2 strides")
  assert(close(r:tolist(),{33,70}),"sort 2 values")
  assert(close(a:tolist(),{33,70}),"sort 2 input mutation")
end
do -- sort 3
  local a=np.array({{44,81,118,155,192},{229,15,52,89,126},{163,200,237,23,60}},np.uint8)
  local r=np.sort(a,1)
  assert(r.dtype=="uint8","sort 3 dtype "..r.dtype)
  assert(eq(r.shape,{3,5}),"sort 3 shape")
  assert(eq(r.strides,{5,1}),"sort 3 strides")
  assert(close(r:tolist(),{{44,15,52,23,60},{163,81,118,89,126},{229,200,237,155,192}}),"sort 3 values")
  assert(close(a:tolist(),{{44,81,118,155,192},{229,15,52,89,126},{163,200,237,23,60}}),"sort 3 input mutation")
end
do -- sort 4
  local a=np.array({-70,-33},np.int16)
  local r=np.sort(a,1)
  assert(r.dtype=="int16","sort 4 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"sort 4 shape")
  assert(eq(r.strides,{2}),"sort 4 strides")
  assert(close(r:tolist(),{-70,-33}),"sort 4 values")
  assert(close(a:tolist(),{-70,-33}),"sort 4 input mutation")
end
do -- sort 5
  local a=np.array({66,103},np.uint32)
  local r=np.sort(a,1)
  assert(r.dtype=="uint32","sort 5 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"sort 5 shape")
  assert(eq(r.strides,{4}),"sort 5 strides")
  assert(close(r:tolist(),{66,103}),"sort 5 values")
  assert(close(a:tolist(),{66,103}),"sort 5 input mutation")
end
do -- sort 6
  local a=np.array({-48,-11,26,63},np.int8)
  local r=np.sort(a,1)
  assert(r.dtype=="int8","sort 6 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"sort 6 shape")
  assert(eq(r.strides,{1}),"sort 6 strides")
  assert(close(r:tolist(),{-48,-11,26,63}),"sort 6 values")
  assert(close(a:tolist(),{-48,-11,26,63}),"sort 6 input mutation")
end
do -- sort 7
  local a=np.array({88},np.uint16)
  local r=np.sort(a,1)
  assert(r.dtype=="uint16","sort 7 dtype "..r.dtype)
  assert(eq(r.shape,{1}),"sort 7 shape")
  assert(eq(r.strides,{2}),"sort 7 strides")
  assert(close(r:tolist(),{88}),"sort 7 values")
  assert(close(a:tolist(),{88}),"sort 7 input mutation")
end
do -- sort 8
  local a=np.array({{{99}},{{136}},{{173}},{{210}},{{247}}},np.uint32)
  local r=np.sort(a,2)
  assert(r.dtype=="uint32","sort 8 dtype "..r.dtype)
  assert(eq(r.shape,{5,1,1}),"sort 8 shape")
  assert(eq(r.strides,{4,4,4}),"sort 8 strides")
  assert(close(r:tolist(),{{{99}},{{136}},{{173}},{{210}},{{247}}}),"sort 8 values")
  assert(close(a:tolist(),{{{99}},{{136}},{{173}},{{210}},{{247}}}),"sort 8 input mutation")
end
do -- sort 9
  local a=np.array({{{-4.5,0/0,4.002,0/0}}},np.float64)
  local r=np.sort(a,3)
  assert(r.dtype=="float64","sort 9 dtype "..r.dtype)
  assert(eq(r.shape,{1,1,4}),"sort 9 shape")
  assert(eq(r.strides,{32,32,8}),"sort 9 strides")
  assert(close(r:tolist(),{{{-4.5,4.002,0/0,0/0}}}),"sort 9 values")
  assert(close(a:tolist(),{{{-4.5,0/0,4.002,0/0}}}),"sort 9 input mutation")
end
do -- sort 10
  local a=np.array({{-3.75,0.501},{4.752,9.003}},np.float64)
  local r=np.sort(a,1)
  assert(r.dtype=="float64","sort 10 dtype "..r.dtype)
  assert(eq(r.shape,{2,2}),"sort 10 shape")
  assert(eq(r.strides,{16,8}),"sort 10 strides")
  assert(close(r:tolist(),{{-3.75,0.501},{4.752,9.003}}),"sort 10 values")
  assert(close(a:tolist(),{{-3.75,0.501},{4.752,9.003}}),"sort 10 input mutation")
end
do -- sort 11
  local a=np.array({{{-3.0,1.251},{5.502,9.753}},{{-10.246,-5.995},{-1.744,2.507}}},np.float64)
  local r=np.sort(a,1)
  assert(r.dtype=="float64","sort 11 dtype "..r.dtype)
  assert(eq(r.shape,{2,2,2}),"sort 11 shape")
  assert(eq(r.strides,{32,16,8}),"sort 11 strides")
  assert(close(r:tolist(),{{{-10.246,-5.995},{-1.744,2.507}},{{-3.0,1.251},{5.502,9.753}}}),"sort 11 values")
  assert(close(a:tolist(),{{{-3.0,1.251},{5.502,9.753}},{{-10.246,-5.995},{-1.744,2.507}}}),"sort 11 input mutation")
end
do -- sort 12
  local a=np.array({{{18},{55},{92},{-122},{-85}},{{-48},{-11},{26},{63},{100}},{{-114},{-77},{-40},{-3},{34}},{{71},{108},{-106},{-69},{-32}}},np.int8)
  local r=np.sort(a,1)
  assert(r.dtype=="int8","sort 12 dtype "..r.dtype)
  assert(eq(r.shape,{4,5,1}),"sort 12 shape")
  assert(eq(r.strides,{5,1,1}),"sort 12 strides")
  assert(close(r:tolist(),{{{-114},{-77},{-106},{-122},{-85}},{{-48},{-11},{-40},{-69},{-32}},{{18},{55},{26},{-3},{34}},{{71},{108},{92},{63},{100}}}),"sort 12 values")
  assert(close(a:tolist(),{{{18},{55},{92},{-122},{-85}},{{-48},{-11},{26},{63},{100}},{{-114},{-77},{-40},{-3},{34}},{{71},{108},{-106},{-69},{-32}}}),"sort 12 input mutation")
end
do -- sort 13
  local a=np.array({false,true,false},np.bool)
  local r=np.sort(a,1)
  assert(r.dtype=="bool","sort 13 dtype "..r.dtype)
  assert(eq(r.shape,{3}),"sort 13 shape")
  assert(eq(r.strides,{1}),"sort 13 strides")
  assert(close(r:tolist(),{false,false,true}),"sort 13 values")
  assert(close(a:tolist(),{false,true,false}),"sort 13 input mutation")
end
do -- sort 14
  local a=np.array({{{true,false,false,true}},{{false,true,false,false}},{{true,false,true,false}}},np.bool)
  local r=np.sort(a,1)
  assert(r.dtype=="bool","sort 14 dtype "..r.dtype)
  assert(eq(r.shape,{3,1,4}),"sort 14 shape")
  assert(eq(r.strides,{4,4,1}),"sort 14 strides")
  assert(close(r:tolist(),{{{false,false,false,false}},{{true,false,false,false}},{{true,true,true,true}}}),"sort 14 values")
  assert(close(a:tolist(),{{{true,false,false,true}},{{false,true,false,false}},{{true,false,true,false}}}),"sort 14 input mutation")
end
do -- sort 15
  local a=np.array({{51,88,125,-89,-52},{-15,22,59,96,-118}},np.int32)
  local r=np.sort(a,1)
  assert(r.dtype=="int32","sort 15 dtype "..r.dtype)
  assert(eq(r.shape,{2,5}),"sort 15 shape")
  assert(eq(r.strides,{20,4}),"sort 15 strides")
  assert(close(r:tolist(),{{-15,22,59,-89,-118},{51,88,125,96,-52}}),"sort 15 values")
  assert(close(a:tolist(),{{51,88,125,-89,-52},{-15,22,59,96,-118}}),"sort 15 input mutation")
end
do -- sort 16
  local a=np.array({{187},{224},{10},{47}},np.uint16)
  local r=np.sort(a,1)
  assert(r.dtype=="uint16","sort 16 dtype "..r.dtype)
  assert(eq(r.shape,{4,1}),"sort 16 shape")
  assert(eq(r.strides,{2,2}),"sort 16 strides")
  assert(close(r:tolist(),{{10},{47},{187},{224}}),"sort 16 values")
  assert(close(a:tolist(),{{187},{224},{10},{47}}),"sort 16 input mutation")
end
do -- sort 17
  local a=np.array({{{1.5,0/0}},{{10.002,-9.997}},{{-5.746,-1.495}},{{2.756,7.007}},{{11.258,0/0}}},np.float32)
  local r=np.sort(a,2)
  assert(r.dtype=="float32","sort 17 dtype "..r.dtype)
  assert(eq(r.shape,{5,1,2}),"sort 17 shape")
  assert(eq(r.strides,{8,8,4}),"sort 17 strides")
  assert(close(r:tolist(),{{{1.5,0/0}},{{10.001999855041504,-9.996999740600586}},{{-5.745999813079834,-1.4950000047683716}},{{2.75600004196167,7.006999969482422}},{{11.258000373840332,0/0}}}),"sort 17 values")
  assert(close(a:tolist(),{{{1.5,0/0}},{{10.001999855041504,-9.996999740600586}},{{-5.745999813079834,-1.4950000047683716}},{{2.75600004196167,7.006999969482422}},{{11.258000373840332,0/0}}}),"sort 17 input mutation")
end
do -- sort 18
  local a=np.array({{{209,246,32},{69,106,143},{180,217,3}}},np.uint8)
  local r=np.sort(a,1)
  assert(r.dtype=="uint8","sort 18 dtype "..r.dtype)
  assert(eq(r.shape,{1,3,3}),"sort 18 shape")
  assert(eq(r.strides,{9,3,1}),"sort 18 strides")
  assert(close(r:tolist(),{{{209,246,32},{69,106,143},{180,217,3}}}),"sort 18 values")
  assert(close(a:tolist(),{{{209,246,32},{69,106,143},{180,217,3}}}),"sort 18 input mutation")
end
do -- sort 19
  local a=np.array({{220,6},{43,80}},np.uint8)
  local r=np.sort(a,1)
  assert(r.dtype=="uint8","sort 19 dtype "..r.dtype)
  assert(eq(r.shape,{2,2}),"sort 19 shape")
  assert(eq(r.strides,{2,1}),"sort 19 strides")
  assert(close(r:tolist(),{{43,6},{220,80}}),"sort 19 values")
  assert(close(a:tolist(),{{220,6},{43,80}}),"sort 19 input mutation")
end
do -- sort 20
  local a=np.array({{true,false,true,false,false},{true,false,true,false,false},{true,false,true,false,false},{true,false,true,false,false},{true,false,true,false,false}},np.bool)
  local r=np.sort(a,1)
  assert(r.dtype=="bool","sort 20 dtype "..r.dtype)
  assert(eq(r.shape,{5,5}),"sort 20 shape")
  assert(eq(r.strides,{5,1}),"sort 20 strides")
  assert(close(r:tolist(),{{true,false,true,false,false},{true,false,true,false,false},{true,false,true,false,false},{true,false,true,false,false},{true,false,true,false,false}}),"sort 20 values")
  assert(close(a:tolist(),{{true,false,true,false,false},{true,false,true,false,false},{true,false,true,false,false},{true,false,true,false,false},{true,false,true,false,false}}),"sort 20 input mutation")
end
do -- sort 21
  local a=np.array({117,-97,-60},np.int64)
  local r=np.sort(a,1)
  assert(r.dtype=="int64","sort 21 dtype "..r.dtype)
  assert(eq(r.shape,{3}),"sort 21 shape")
  assert(eq(r.strides,{8}),"sort 21 strides")
  assert(close(r:tolist(),{-97,-60,117}),"sort 21 values")
  assert(close(a:tolist(),{117,-97,-60}),"sort 21 input mutation")
end
do -- sort 22
  local a=np.array({-123,-86},np.int16)
  local r=np.sort(a,1)
  assert(r.dtype=="int16","sort 22 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"sort 22 shape")
  assert(eq(r.strides,{2}),"sort 22 strides")
  assert(close(r:tolist(),{-123,-86}),"sort 22 values")
  assert(close(a:tolist(),{-123,-86}),"sort 22 input mutation")
end
do -- sort 23
  local a=np.array({false,true,false,true},np.bool)
  local r=np.sort(a,1)
  assert(r.dtype=="bool","sort 23 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"sort 23 shape")
  assert(eq(r.strides,{1}),"sort 23 strides")
  assert(close(r:tolist(),{false,false,true,true}),"sort 23 values")
  assert(close(a:tolist(),{false,true,false,true}),"sort 23 input mutation")
end
do -- sort 24
  local a=(np.array({{-101,-64},{-27,10},{47,84}},np.int8)).T
  local r=np.sort(a,1)
  assert(r.dtype=="int8","sort 24 dtype "..r.dtype)
  assert(eq(r.shape,{2,3}),"sort 24 shape")
  assert(eq(r.strides,{1,2}),"sort 24 strides")
  assert(close(r:tolist(),{{-101,-27,47},{-64,10,84}}),"sort 24 values")
  assert(close(a:tolist(),{{-101,-27,47},{-64,10,84}}),"sort 24 input mutation")
end
do -- sort 25
  local a=np.array({{{-90,-53,-16,21},{58,95,-119,-82},{-45,-8,29,66}},{{103,-111,-74,-37},{0,37,74,111},{-103,-66,-29,8}},{{45,82,119,-95},{-58,-21,16,53},{90,-124,-87,-50}},{{-13,24,61,98},{-116,-79,-42,-5},{32,69,106,-108}}},np.int64)
  local r=np.sort(a,1)
  assert(r.dtype=="int64","sort 25 dtype "..r.dtype)
  assert(eq(r.shape,{4,3,4}),"sort 25 shape")
  assert(eq(r.strides,{96,32,8}),"sort 25 strides")
  assert(close(r:tolist(),{{{-90,-111,-74,-95},{-116,-79,-119,-82},{-103,-124,-87,-108}},{{-13,-53,-16,-37},{-58,-21,-42,-5},{-45,-66,-29,-50}},{{45,24,61,21},{0,37,16,53},{32,-8,29,8}},{{103,82,119,98},{58,95,74,111},{90,69,106,66}}}),"sort 25 values")
  assert(close(a:tolist(),{{{-90,-53,-16,21},{58,95,-119,-82},{-45,-8,29,66}},{{103,-111,-74,-37},{0,37,74,111},{-103,-66,-29,8}},{{45,82,119,-95},{-58,-21,16,53},{90,-124,-87,-50}},{{-13,24,61,98},{-116,-79,-42,-5},{32,69,106,-108}}}),"sort 25 input mutation")
end
do -- sort 26
  local a=np.array({{8.25,-11.749,-7.498,-3.247,1.004},{5.255,9.506,-10.493,-6.242,-1.991}},np.float64)
  local r=np.sort(a,1)
  assert(r.dtype=="float64","sort 26 dtype "..r.dtype)
  assert(eq(r.shape,{2,5}),"sort 26 shape")
  assert(eq(r.strides,{40,8}),"sort 26 strides")
  assert(close(r:tolist(),{{5.255,-11.749,-10.493,-6.242,-1.991},{8.25,9.506,-7.498,-3.247,1.004}}),"sort 26 values")
  assert(close(a:tolist(),{{8.25,-11.749,-7.498,-3.247,1.004},{5.255,9.506,-10.493,-6.242,-1.991}}),"sort 26 input mutation")
end
do -- sort 27
  local a=np.array({9.0,-10.999},np.float32)
  local r=np.sort(a,1)
  assert(r.dtype=="float32","sort 27 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"sort 27 shape")
  assert(eq(r.strides,{4}),"sort 27 strides")
  assert(close(r:tolist(),{-10.99899959564209,9.0}),"sort 27 values")
  assert(close(a:tolist(),{9.0,-10.99899959564209}),"sort 27 input mutation")
end
do -- sort 28
  local a=np.array({{68,105,142,179,216},{2,39,76,113,150},{187,224,10,47,84}},np.uint8)
  local r=np.sort(a,2)
  assert(r.dtype=="uint8","sort 28 dtype "..r.dtype)
  assert(eq(r.shape,{3,5}),"sort 28 shape")
  assert(eq(r.strides,{5,1}),"sort 28 strides")
  assert(close(r:tolist(),{{68,105,142,179,216},{2,39,76,113,150},{10,47,84,187,224}}),"sort 28 values")
  assert(close(a:tolist(),{{68,105,142,179,216},{2,39,76,113,150},{187,224,10,47,84}}),"sort 28 input mutation")
end
do -- sort 29
  local a=np.array({{-46,-9,28},{65,102,-112},{-75,-38,-1},{36,73,110},{-104,-67,-30}},np.int8)
  local r=np.sort(a,2)
  assert(r.dtype=="int8","sort 29 dtype "..r.dtype)
  assert(eq(r.shape,{5,3}),"sort 29 shape")
  assert(eq(r.strides,{3,1}),"sort 29 strides")
  assert(close(r:tolist(),{{-46,-9,28},{-112,65,102},{-75,-38,-1},{36,73,110},{-104,-67,-30}}),"sort 29 values")
  assert(close(a:tolist(),{{-46,-9,28},{65,102,-112},{-75,-38,-1},{36,73,110},{-104,-67,-30}}),"sort 29 input mutation")
end
do -- sort 30
  local a=(np.array({{-35,2},{39,76},{113,-101}},np.int64)).T
  local r=np.sort(a,1)
  assert(r.dtype=="int64","sort 30 dtype "..r.dtype)
  assert(eq(r.shape,{2,3}),"sort 30 shape")
  assert(eq(r.strides,{8,16}),"sort 30 strides")
  assert(close(r:tolist(),{{-35,39,-101},{2,76,113}}),"sort 30 values")
  assert(close(a:tolist(),{{-35,39,113},{2,76,-101}}),"sort 30 input mutation")
end
do -- sort 31
  local a=(np.array({{-24,13},{50,87},{124,-90},{-53,-16},{21,58}},np.int64)).T
  local r=np.sort(a,2)
  assert(r.dtype=="int64","sort 31 dtype "..r.dtype)
  assert(eq(r.shape,{2,5}),"sort 31 shape")
  assert(eq(r.strides,{8,16}),"sort 31 strides")
  assert(close(r:tolist(),{{-53,-24,21,50,124},{-90,-16,13,58,87}}),"sort 31 values")
  assert(close(a:tolist(),{{-24,50,124,-53,21},{13,87,-90,-16,58}}),"sort 31 input mutation")
end
do -- sort 32
  local a=np.array({{{112,149,186,223,9},{46,83,120,157,194},{231,17,54,91,128},{165,202,239,25,62},{99,136,173,210,247}}},np.uint32)
  local r=np.sort(a,2)
  assert(r.dtype=="uint32","sort 32 dtype "..r.dtype)
  assert(eq(r.shape,{1,5,5}),"sort 32 shape")
  assert(eq(r.strides,{100,20,4}),"sort 32 strides")
  assert(close(r:tolist(),{{{46,17,54,25,9},{99,83,120,91,62},{112,136,173,157,128},{165,149,186,210,194},{231,202,239,223,247}}}),"sort 32 values")
  assert(close(a:tolist(),{{{112,149,186,223,9},{46,83,120,157,194},{231,17,54,91,128},{165,202,239,25,62},{99,136,173,210,247}}}),"sort 32 input mutation")
end
do -- sort 33
  local a=(np.array({{-2,35},{72,109}},np.int64)).T
  local r=np.sort(a,2)
  assert(r.dtype=="int64","sort 33 dtype "..r.dtype)
  assert(eq(r.shape,{2,2}),"sort 33 shape")
  assert(eq(r.strides,{8,16}),"sort 33 strides")
  assert(close(r:tolist(),{{-2,72},{35,109}}),"sort 33 values")
  assert(close(a:tolist(),{{-2,72},{35,109}}),"sort 33 input mutation")
end
do -- sort 34
  local a=np.array({{134,171,208,245},{31,68,105,142}},np.uint16)
  local r=np.sort(a,1)
  assert(r.dtype=="uint16","sort 34 dtype "..r.dtype)
  assert(eq(r.shape,{2,4}),"sort 34 shape")
  assert(eq(r.strides,{8,2}),"sort 34 strides")
  assert(close(r:tolist(),{{31,68,105,142},{134,171,208,245}}),"sort 34 values")
  assert(close(a:tolist(),{{134,171,208,245},{31,68,105,142}}),"sort 34 input mutation")
end
do -- sort 35
  local a=np.array({{{145},{182},{219}},{{5},{42},{79}}},np.uint32)
  local r=np.sort(a,2)
  assert(r.dtype=="uint32","sort 35 dtype "..r.dtype)
  assert(eq(r.shape,{2,3,1}),"sort 35 shape")
  assert(eq(r.strides,{12,4,4}),"sort 35 strides")
  assert(close(r:tolist(),{{{145},{182},{219}},{{5},{42},{79}}}),"sort 35 values")
  assert(close(a:tolist(),{{{145},{182},{219}},{{5},{42},{79}}}),"sort 35 input mutation")
end
do -- sort 36
  local a=np.array({{{31,68,105}}},np.int64)
  local r=np.sort(a,2)
  assert(r.dtype=="int64","sort 36 dtype "..r.dtype)
  assert(eq(r.shape,{1,1,3}),"sort 36 shape")
  assert(eq(r.strides,{24,24,8}),"sort 36 strides")
  assert(close(r:tolist(),{{{31,68,105}}}),"sort 36 values")
  assert(close(a:tolist(),{{{31,68,105}}}),"sort 36 input mutation")
end
do -- sort 37
  local a=np.array({{-7.75,-3.499,0.752},{5.003,9.254,-10.745},{-6.494,-2.243,2.008},{6.259,10.51,-9.489},{-5.238,-0.987,3.264}},np.float64)
  local r=np.sort(a,2)
  assert(r.dtype=="float64","sort 37 dtype "..r.dtype)
  assert(eq(r.shape,{5,3}),"sort 37 shape")
  assert(eq(r.strides,{24,8}),"sort 37 strides")
  assert(close(r:tolist(),{{-7.75,-3.499,0.752},{-10.745,5.003,9.254},{-6.494,-2.243,2.008},{-9.489,6.259,10.51},{-5.238,-0.987,3.264}}),"sort 37 values")
  assert(close(a:tolist(),{{-7.75,-3.499,0.752},{5.003,9.254,-10.745},{-6.494,-2.243,2.008},{6.259,10.51,-9.489},{-5.238,-0.987,3.264}}),"sort 37 input mutation")
end
do -- sort 38
  local a=np.array({{53,90,-124,-87},{-50,-13,24,61},{98,-116,-79,-42},{-5,32,69,106}},np.int64)
  local r=np.sort(a,2)
  assert(r.dtype=="int64","sort 38 dtype "..r.dtype)
  assert(eq(r.shape,{4,4}),"sort 38 shape")
  assert(eq(r.strides,{32,8}),"sort 38 strides")
  assert(close(r:tolist(),{{-124,-87,53,90},{-50,-13,24,61},{-116,-79,-42,98},{-5,32,69,106}}),"sort 38 values")
  assert(close(a:tolist(),{{53,90,-124,-87},{-50,-13,24,61},{98,-116,-79,-42},{-5,32,69,106}}),"sort 38 input mutation")
end
do -- sort 39
  local a=np.array({{-6.25,-1.999,2.252,6.503,10.754},{-9.245,-4.994,-0.743,3.508,7.759},{12.01,-7.989,-3.738,0.513,4.764},{9.015,-10.984,-6.733,-2.482,1.769},{6.02,10.271,-9.728,-5.477,-1.226}},np.float64)
  local r=np.sort(a,1)
  assert(r.dtype=="float64","sort 39 dtype "..r.dtype)
  assert(eq(r.shape,{5,5}),"sort 39 shape")
  assert(eq(r.strides,{40,8}),"sort 39 strides")
  assert(close(r:tolist(),{{-9.245,-10.984,-9.728,-5.477,-1.226},{-6.25,-7.989,-6.733,-2.482,1.769},{6.02,-4.994,-3.738,0.513,4.764},{9.015,-1.999,-0.743,3.508,7.759},{12.01,10.271,2.252,6.503,10.754}}),"sort 39 values")
  assert(close(a:tolist(),{{-6.25,-1.999,2.252,6.503,10.754},{-9.245,-4.994,-0.743,3.508,7.759},{12.01,-7.989,-3.738,0.513,4.764},{9.015,-10.984,-6.733,-2.482,1.769},{6.02,10.271,-9.728,-5.477,-1.226}}),"sort 39 input mutation")
end
do -- sort 40
  local a=np.array({{75,112,-102}},np.int8)
  local r=np.sort(a,1)
  assert(r.dtype=="int8","sort 40 dtype "..r.dtype)
  assert(eq(r.shape,{1,3}),"sort 40 shape")
  assert(eq(r.strides,{3,1}),"sort 40 strides")
  assert(close(r:tolist(),{{75,112,-102}}),"sort 40 values")
  assert(close(a:tolist(),{{75,112,-102}}),"sort 40 input mutation")
end
do -- sort 41
  local a=(np.array({{211,248},{34,71}},np.uint32)).T
  local r=np.sort(a,1)
  assert(r.dtype=="uint32","sort 41 dtype "..r.dtype)
  assert(eq(r.shape,{2,2}),"sort 41 shape")
  assert(eq(r.strides,{4,8}),"sort 41 strides")
  assert(close(r:tolist(),{{211,34},{248,71}}),"sort 41 values")
  assert(close(a:tolist(),{{211,34},{248,71}}),"sort 41 input mutation")
end
do -- sort 42
  local a=np.array({{{222,8,45,82,119},{156,193,230,16,53}},{{90,127,164,201,238},{24,61,98,135,172}},{{209,246,32,69,106},{143,180,217,3,40}}},np.uint8)
  local r=np.sort(a,1)
  assert(r.dtype=="uint8","sort 42 dtype "..r.dtype)
  assert(eq(r.shape,{3,2,5}),"sort 42 shape")
  assert(eq(r.strides,{10,5,1}),"sort 42 strides")
  assert(close(r:tolist(),{{{90,8,32,69,106},{24,61,98,3,40}},{{209,127,45,82,119},{143,180,217,16,53}},{{222,246,164,201,238},{156,193,230,135,172}}}),"sort 42 values")
  assert(close(a:tolist(),{{{222,8,45,82,119},{156,193,230,16,53}},{{90,127,164,201,238},{24,61,98,135,172}},{{209,246,32,69,106},{143,180,217,3,40}}}),"sort 42 input mutation")
end
do -- sort 43
  local a=np.array({{233,19,56,93,130},{167,204,241,27,64},{101,138,175,212,249}},np.uint8)
  local r=np.sort(a,2)
  assert(r.dtype=="uint8","sort 43 dtype "..r.dtype)
  assert(eq(r.shape,{3,5}),"sort 43 shape")
  assert(eq(r.strides,{5,1}),"sort 43 strides")
  assert(close(r:tolist(),{{19,56,93,130,233},{27,64,167,204,241},{101,138,175,212,249}}),"sort 43 values")
  assert(close(a:tolist(),{{233,19,56,93,130},{167,204,241,27,64},{101,138,175,212,249}}),"sort 43 input mutation")
end
do -- sort 44
  local a=(np.array({{-2.5,1.751,6.002,10.253},{-9.746,-5.495,-1.244,3.007}},np.float32)).T
  local r=np.sort(a,1)
  assert(r.dtype=="float32","sort 44 dtype "..r.dtype)
  assert(eq(r.shape,{4,2}),"sort 44 shape")
  assert(eq(r.strides,{4,16}),"sort 44 strides")
  assert(close(r:tolist(),{{-2.5,-9.746000289916992},{1.7510000467300415,-5.494999885559082},{6.001999855041504,-1.24399995803833},{10.253000259399414,3.006999969482422}}),"sort 44 values")
  assert(close(a:tolist(),{{-2.5,-9.746000289916992},{1.7510000467300415,-5.494999885559082},{6.001999855041504,-1.24399995803833},{10.253000259399414,3.006999969482422}}),"sort 44 input mutation")
end
do -- sort 45
  local a=np.array({{{-121}},{{-84}},{{-47}},{{-10}}},np.int8)
  local r=np.sort(a,3)
  assert(r.dtype=="int8","sort 45 dtype "..r.dtype)
  assert(eq(r.shape,{4,1,1}),"sort 45 shape")
  assert(eq(r.strides,{1,1,1}),"sort 45 strides")
  assert(close(r:tolist(),{{{-121}},{{-84}},{{-47}},{{-10}}}),"sort 45 values")
  assert(close(a:tolist(),{{{-121}},{{-84}},{{-47}},{{-10}}}),"sort 45 input mutation")
end
do -- sort 46
  local a=np.array({{{-1.0,3.251,7.502}},{{11.753,-8.246,-3.995}},{{0.256,4.507,8.758}},{{-11.241,-6.99,-2.739}}},np.float32)
  local r=np.sort(a,3)
  assert(r.dtype=="float32","sort 46 dtype "..r.dtype)
  assert(eq(r.shape,{4,1,3}),"sort 46 shape")
  assert(eq(r.strides,{12,12,4}),"sort 46 strides")
  assert(close(r:tolist(),{{{-1.0,3.250999927520752,7.501999855041504}},{{-8.246000289916992,-3.994999885559082,11.753000259399414}},{{0.25600001215934753,4.506999969482422,8.758000373840332}},{{-11.241000175476074,-6.989999771118164,-2.739000082015991}}}),"sort 46 values")
  assert(close(a:tolist(),{{{-1.0,3.250999927520752,7.501999855041504}},{{11.753000259399414,-8.246000289916992,-3.994999885559082}},{{0.25600001215934753,4.506999969482422,8.758000373840332}},{{-11.241000175476074,-6.989999771118164,-2.739000082015991}}}),"sort 46 input mutation")
end
do -- sort 47
  local a=np.array({{{-0.25,0/0,8.252,-11.747,-7.496},{-3.245,1.006,5.257,9.508,-10.491},{-6.24,-1.989,2.262,6.513,10.764},{-9.235,-4.984,-0.733,3.518,7.769}},{{12.02,-7.979,-3.728,0.523,4.774},{9.025,-10.974,-6.723,-2.472,1.779},{6.03,10.281,-9.718,-5.467,-1.216},{3.035,7.286,11.537,-8.462,-4.211}},{{0.04,4.291,8.542,-11.457,-7.206},{-2.955,1.296,5.547,9.798,-10.201},{-5.95,-1.699,2.552,6.803,11.054},{-8.945,-4.694,-0.443,3.808,0/0}}},np.float64)
  local r=np.sort(a,2)
  assert(r.dtype=="float64","sort 47 dtype "..r.dtype)
  assert(eq(r.shape,{3,4,5}),"sort 47 shape")
  assert(eq(r.strides,{160,40,8}),"sort 47 strides")
  assert(close(r:tolist(),{{{-9.235,-4.984,-0.733,-11.747,-10.491},{-6.24,-1.989,2.262,3.518,-7.496},{-3.245,1.006,5.257,6.513,7.769},{-0.25,0/0,8.252,9.508,10.764}},{{3.035,-10.974,-9.718,-8.462,-4.211},{6.03,-7.979,-6.723,-5.467,-1.216},{9.025,7.286,-3.728,-2.472,1.779},{12.02,10.281,11.537,0.523,4.774}},{{-8.945,-4.694,-0.443,-11.457,-10.201},{-5.95,-1.699,2.552,3.808,-7.206},{-2.955,1.296,5.547,6.803,11.054},{0.04,4.291,8.542,9.798,0/0}}}),"sort 47 values")
  assert(close(a:tolist(),{{{-0.25,0/0,8.252,-11.747,-7.496},{-3.245,1.006,5.257,9.508,-10.491},{-6.24,-1.989,2.262,6.513,10.764},{-9.235,-4.984,-0.733,3.518,7.769}},{{12.02,-7.979,-3.728,0.523,4.774},{9.025,-10.974,-6.723,-2.472,1.779},{6.03,10.281,-9.718,-5.467,-1.216},{3.035,7.286,11.537,-8.462,-4.211}},{{0.04,4.291,8.542,-11.457,-7.206},{-2.955,1.296,5.547,9.798,-10.201},{-5.95,-1.699,2.552,6.803,11.054},{-8.945,-4.694,-0.443,3.808,0/0}}}),"sort 47 input mutation")
end
do -- sort 48
  local a=np.array({{{-88,-51,-14,23,60},{97,-117,-80,-43,-6},{31,68,105,-109,-72},{-35,2,39,76,113}}},np.int32)
  local r=np.sort(a,2)
  assert(r.dtype=="int32","sort 48 dtype "..r.dtype)
  assert(eq(r.shape,{1,4,5}),"sort 48 shape")
  assert(eq(r.strides,{80,20,4}),"sort 48 strides")
  assert(close(r:tolist(),{{{-88,-117,-80,-109,-72},{-35,-51,-14,-43,-6},{31,2,39,23,60},{97,68,105,76,113}}}),"sort 48 values")
  assert(close(a:tolist(),{{{-88,-51,-14,23,60},{97,-117,-80,-43,-6},{31,68,105,-109,-72},{-35,2,39,76,113}}}),"sort 48 input mutation")
end
do -- sort 49
  local a=np.array({-77,-40,-3},np.int16)
  local r=np.sort(a,1)
  assert(r.dtype=="int16","sort 49 dtype "..r.dtype)
  assert(eq(r.shape,{3}),"sort 49 shape")
  assert(eq(r.strides,{2}),"sort 49 strides")
  assert(close(r:tolist(),{-77,-40,-3}),"sort 49 values")
  assert(close(a:tolist(),{-77,-40,-3}),"sort 49 input mutation")
end
do -- sort 50
  local a=(np.array({{-66,-29,8,45}},np.int16)).T
  local r=np.sort(a,1)
  assert(r.dtype=="int16","sort 50 dtype "..r.dtype)
  assert(eq(r.shape,{4,1}),"sort 50 shape")
  assert(eq(r.strides,{2,2}),"sort 50 strides")
  assert(close(r:tolist(),{{-66},{-29},{8},{45}}),"sort 50 values")
  assert(close(a:tolist(),{{-66},{-29},{8},{45}}),"sort 50 input mutation")
end
do -- sort 51
  local a=np.array({-55,-18,19,56,93},np.int8)
  local r=np.sort(a,1)
  assert(r.dtype=="int8","sort 51 dtype "..r.dtype)
  assert(eq(r.shape,{5}),"sort 51 shape")
  assert(eq(r.strides,{1}),"sort 51 strides")
  assert(close(r:tolist(),{-55,-18,19,56,93}),"sort 51 values")
  assert(close(a:tolist(),{-55,-18,19,56,93}),"sort 51 input mutation")
end
do -- sort 52
  local a=np.array({{{-44,-7},{30,67},{104,-110},{-73,-36},{1,38}}},np.int64)
  local r=np.sort(a,1)
  assert(r.dtype=="int64","sort 52 dtype "..r.dtype)
  assert(eq(r.shape,{1,5,2}),"sort 52 shape")
  assert(eq(r.strides,{80,16,8}),"sort 52 strides")
  assert(close(r:tolist(),{{{-44,-7},{30,67},{104,-110},{-73,-36},{1,38}}}),"sort 52 values")
  assert(close(a:tolist(),{{{-44,-7},{30,67},{104,-110},{-73,-36},{1,38}}}),"sort 52 input mutation")
end
do -- sort 53
  local a=np.array({4.25,8.501,-11.498,-7.247,-2.996},np.float64)
  local r=np.sort(a,1)
  assert(r.dtype=="float64","sort 53 dtype "..r.dtype)
  assert(eq(r.shape,{5}),"sort 53 shape")
  assert(eq(r.strides,{8}),"sort 53 strides")
  assert(close(r:tolist(),{-11.498,-7.247,-2.996,4.25,8.501}),"sort 53 values")
  assert(close(a:tolist(),{4.25,8.501,-11.498,-7.247,-2.996}),"sort 53 input mutation")
end
do -- sort 54
  local a=np.array({{-22},{15}},np.int32)
  local r=np.sort(a,2)
  assert(r.dtype=="int32","sort 54 dtype "..r.dtype)
  assert(eq(r.shape,{2,1}),"sort 54 shape")
  assert(eq(r.strides,{4,4}),"sort 54 strides")
  assert(close(r:tolist(),{{-22},{15}}),"sort 54 values")
  assert(close(a:tolist(),{{-22},{15}}),"sort 54 input mutation")
end
do -- sort 55
  local a=np.array({{true,false},{true,false}},np.bool)
  local r=np.sort(a,2)
  assert(r.dtype=="bool","sort 55 dtype "..r.dtype)
  assert(eq(r.shape,{2,2}),"sort 55 shape")
  assert(eq(r.strides,{2,1}),"sort 55 strides")
  assert(close(r:tolist(),{{false,true},{false,true}}),"sort 55 values")
  assert(close(a:tolist(),{{true,false},{true,false}}),"sort 55 input mutation")
end
do -- sort 56
  local a=np.array({{{6.5,10.751,-9.248,-4.997,-0.746},{3.505,7.756,12.007,-7.992,-3.741},{0.51,4.761,9.012,-10.987,-6.736},{-2.485,1.766,6.017,10.268,-9.731}},{{-5.48,-1.229,3.022,7.273,11.524},{-8.475,-4.224,0.027,4.278,8.529},{-11.47,-7.219,-2.968,1.283,5.534},{9.785,-10.214,-5.963,-1.712,2.539}},{{6.79,11.041,-8.958,-4.707,-0.456},{3.795,8.046,-11.953,-7.702,-3.451},{0.8,5.051,9.302,-10.697,-6.446},{-2.195,2.056,6.307,10.558,-9.441}},{{-5.19,-0.9390000000000001,3.312,7.563,11.814},{-8.185,-3.934,0.317,4.568,8.819},{-11.18,-6.929,-2.678,1.573,5.824},{10.075,-9.924,-5.673,-1.422,2.829}},{{7.08,11.331,-8.668,-4.417,-0.16599999999999998},{4.085,8.336,-11.663,-7.412,-3.161},{1.09,5.341,9.592,-10.407,-6.156},{-1.905,2.346,6.597,10.848,-9.151}}},np.float32)
  local r=np.sort(a,1)
  assert(r.dtype=="float32","sort 56 dtype "..r.dtype)
  assert(eq(r.shape,{5,4,5}),"sort 56 shape")
  assert(eq(r.strides,{80,20,4}),"sort 56 strides")
  assert(close(r:tolist(),{{{-5.480000019073486,-1.2289999723434448,-9.248000144958496,-4.997000217437744,-0.7459999918937683},{-8.475000381469727,-4.223999977111816,-11.95300006866455,-7.992000102996826,-3.740999937057495},{-11.470000267028809,-7.218999862670898,-2.9679999351501465,-10.987000465393066,-6.736000061035156},{-2.484999895095825,-10.21399974822998,-5.9629998207092285,-1.7120000123977661,-9.730999946594238}},{{-5.190000057220459,-0.9390000104904175,-8.958000183105469,-4.706999778747559,-0.4560000002384186},{-8.1850004196167,-3.934000015258789,-11.663000106811523,-7.702000141143799,-3.4509999752044678},{-11.180000305175781,-6.928999900817871,-2.677999973297119,-10.696999549865723,-6.446000099182129},{-2.194999933242798,-9.923999786376953,-5.672999858856201,-1.4220000505447388,-9.440999984741211}},{{6.5,10.75100040435791,-8.668000221252441,-4.416999816894531,-0.16599999368190765},{3.505000114440918,7.75600004196167,0.027000000700354576,-7.4120001792907715,-3.1610000133514404},{0.5099999904632568,4.761000156402588,9.01200008392334,-10.406999588012695,-6.156000137329102},{-1.9049999713897705,1.7660000324249268,6.017000198364258,10.267999649047852,-9.151000022888184}},{{6.789999961853027,11.041000366210938,3.0220000743865967,7.2729997634887695,11.52400016784668},{3.7950000762939453,8.045999526977539,0.31700000166893005,4.2779998779296875,8.529000282287598},{0.800000011920929,5.051000118255615,9.302000045776367,1.2829999923706055,5.533999919891357},{9.78499984741211,2.055999994277954,6.307000160217285,10.557999610900879,2.5390000343322754}},{{7.079999923706055,11.331000328063965,3.312000036239624,7.563000202178955,11.814000129699707},{4.085000038146973,8.336000442504883,12.006999969482422,4.567999839782715,8.819000244140625},{1.090000033378601,5.341000080108643,9.592000007629395,1.5729999542236328,5.823999881744385},{10.074999809265137,2.3459999561309814,6.5970001220703125,10.847999572753906,2.8289999961853027}}}),"sort 56 values")
  assert(close(a:tolist(),{{{6.5,10.75100040435791,-9.248000144958496,-4.997000217437744,-0.7459999918937683},{3.505000114440918,7.75600004196167,12.006999969482422,-7.992000102996826,-3.740999937057495},{0.5099999904632568,4.761000156402588,9.01200008392334,-10.987000465393066,-6.736000061035156},{-2.484999895095825,1.7660000324249268,6.017000198364258,10.267999649047852,-9.730999946594238}},{{-5.480000019073486,-1.2289999723434448,3.0220000743865967,7.2729997634887695,11.52400016784668},{-8.475000381469727,-4.223999977111816,0.027000000700354576,4.2779998779296875,8.529000282287598},{-11.470000267028809,-7.218999862670898,-2.9679999351501465,1.2829999923706055,5.533999919891357},{9.78499984741211,-10.21399974822998,-5.9629998207092285,-1.7120000123977661,2.5390000343322754}},{{6.789999961853027,11.041000366210938,-8.958000183105469,-4.706999778747559,-0.4560000002384186},{3.7950000762939453,8.045999526977539,-11.95300006866455,-7.702000141143799,-3.4509999752044678},{0.800000011920929,5.051000118255615,9.302000045776367,-10.696999549865723,-6.446000099182129},{-2.194999933242798,2.055999994277954,6.307000160217285,10.557999610900879,-9.440999984741211}},{{-5.190000057220459,-0.9390000104904175,3.312000036239624,7.563000202178955,11.814000129699707},{-8.1850004196167,-3.934000015258789,0.31700000166893005,4.567999839782715,8.819000244140625},{-11.180000305175781,-6.928999900817871,-2.677999973297119,1.5729999542236328,5.823999881744385},{10.074999809265137,-9.923999786376953,-5.672999858856201,-1.4220000505447388,2.8289999961853027}},{{7.079999923706055,11.331000328063965,-8.668000221252441,-4.416999816894531,-0.16599999368190765},{4.085000038146973,8.336000442504883,-11.663000106811523,-7.4120001792907715,-3.1610000133514404},{1.090000033378601,5.341000080108643,9.592000007629395,-10.406999588012695,-6.156000137329102},{-1.9049999713897705,2.3459999561309814,6.5970001220703125,10.847999572753906,-9.151000022888184}}}),"sort 56 input mutation")
end
do -- sort 57
  local a=np.array({136,173,210,247},np.uint16)
  local r=np.sort(a,1)
  assert(r.dtype=="uint16","sort 57 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"sort 57 shape")
  assert(eq(r.strides,{2}),"sort 57 strides")
  assert(close(r:tolist(),{136,173,210,247}),"sort 57 values")
  assert(close(a:tolist(),{136,173,210,247}),"sort 57 input mutation")
end
do -- sort 58
  local a=np.array({false,true,false},np.bool)
  local r=np.sort(a,1)
  assert(r.dtype=="bool","sort 58 dtype "..r.dtype)
  assert(eq(r.shape,{3}),"sort 58 shape")
  assert(eq(r.strides,{1}),"sort 58 strides")
  assert(close(r:tolist(),{false,false,true}),"sort 58 values")
  assert(close(a:tolist(),{false,true,false}),"sort 58 input mutation")
end
do -- sort 59
  local a=np.array({{{33,70,107,-107},{-70,-33,4,41},{78,115,-99,-62},{-25,12,49,86}},{{123,-91,-54,-17},{20,57,94,-120},{-83,-46,-9,28},{65,102,-112,-75}},{{-38,-1,36,73},{110,-104,-67,-30},{7,44,81,118},{-96,-59,-22,15}},{{52,89,-125,-88},{-51,-14,23,60},{97,-117,-80,-43},{-6,31,68,105}}},np.int8)
  local r=np.sort(a,2)
  assert(r.dtype=="int8","sort 59 dtype "..r.dtype)
  assert(eq(r.shape,{4,4,4}),"sort 59 shape")
  assert(eq(r.strides,{16,4,1}),"sort 59 strides")
  assert(close(r:tolist(),{{{-70,-33,-99,-107},{-25,12,4,-62},{33,70,49,41},{78,115,107,86}},{{-83,-91,-112,-120},{20,-46,-54,-75},{65,57,-9,-17},{123,102,94,28}},{{-96,-104,-67,-30},{-38,-59,-22,15},{7,-1,36,73},{110,44,81,118}},{{-51,-117,-125,-88},{-6,-14,-80,-43},{52,31,23,60},{97,89,68,105}}}),"sort 59 values")
  assert(close(a:tolist(),{{{33,70,107,-107},{-70,-33,4,41},{78,115,-99,-62},{-25,12,49,86}},{{123,-91,-54,-17},{20,57,94,-120},{-83,-46,-9,28},{65,102,-112,-75}},{{-38,-1,36,73},{110,-104,-67,-30},{7,44,81,118},{-96,-59,-22,15}},{{52,89,-125,-88},{-51,-14,23,60},{97,-117,-80,-43},{-6,31,68,105}}}),"sort 59 input mutation")
end
do -- sort 60
  local a=np.array({{{9.5,-10.499,-6.248}},{{-1.997,2.254,6.505}},{{10.756,-9.243,-4.992}},{{-0.741,3.51,7.761}},{{12.012,-7.987,-3.736}}},np.float64)
  local r=np.sort(a,2)
  assert(r.dtype=="float64","sort 60 dtype "..r.dtype)
  assert(eq(r.shape,{5,1,3}),"sort 60 shape")
  assert(eq(r.strides,{24,24,8}),"sort 60 strides")
  assert(close(r:tolist(),{{{9.5,-10.499,-6.248}},{{-1.997,2.254,6.505}},{{10.756,-9.243,-4.992}},{{-0.741,3.51,7.761}},{{12.012,-7.987,-3.736}}}),"sort 60 values")
  assert(close(a:tolist(),{{{9.5,-10.499,-6.248}},{{-1.997,2.254,6.505}},{{10.756,-9.243,-4.992}},{{-0.741,3.51,7.761}},{{12.012,-7.987,-3.736}}}),"sort 60 input mutation")
end
do -- sort 61
  local a=np.array({180,217,3},np.uint32)
  local r=np.sort(a,1)
  assert(r.dtype=="uint32","sort 61 dtype "..r.dtype)
  assert(eq(r.shape,{3}),"sort 61 shape")
  assert(eq(r.strides,{4}),"sort 61 strides")
  assert(close(r:tolist(),{3,180,217}),"sort 61 values")
  assert(close(a:tolist(),{180,217,3}),"sort 61 input mutation")
end
do -- sort 62
  local a=np.array({{66,103,-111}},np.int32)
  local r=np.sort(a,1)
  assert(r.dtype=="int32","sort 62 dtype "..r.dtype)
  assert(eq(r.shape,{1,3}),"sort 62 shape")
  assert(eq(r.strides,{12,4}),"sort 62 strides")
  assert(close(r:tolist(),{{66,103,-111}}),"sort 62 values")
  assert(close(a:tolist(),{{66,103,-111}}),"sort 62 input mutation")
end
do -- sort 63
  local a=np.array({{77,114,-100,-63},{-26,11,48,85},{122,-92,-55,-18}},np.int64)
  local r=np.sort(a,2)
  assert(r.dtype=="int64","sort 63 dtype "..r.dtype)
  assert(eq(r.shape,{3,4}),"sort 63 shape")
  assert(eq(r.strides,{32,8}),"sort 63 strides")
  assert(close(r:tolist(),{{-100,-63,77,114},{-26,11,48,85},{-92,-55,-18,122}}),"sort 63 values")
  assert(close(a:tolist(),{{77,114,-100,-63},{-26,11,48,85},{122,-92,-55,-18}}),"sort 63 input mutation")
end
do -- sort 64
  local a=(np.array({{true},{false},{false},{true},{false}},np.bool)).T
  local r=np.sort(a,1)
  assert(r.dtype=="bool","sort 64 dtype "..r.dtype)
  assert(eq(r.shape,{1,5}),"sort 64 shape")
  assert(eq(r.strides,{5,1}),"sort 64 strides")
  assert(close(r:tolist(),{{true,false,false,true,false}}),"sort 64 values")
  assert(close(a:tolist(),{{true,false,false,true,false}}),"sort 64 input mutation")
end
do -- sort 65
  local a=np.array({{{-11.0},{-6.749},{-2.498}},{{1.753},{6.004},{10.255}}},np.float32)
  local r=np.sort(a,3)
  assert(r.dtype=="float32","sort 65 dtype "..r.dtype)
  assert(eq(r.shape,{2,3,1}),"sort 65 shape")
  assert(eq(r.strides,{12,4,4}),"sort 65 strides")
  assert(close(r:tolist(),{{{-11.0},{-6.749000072479248},{-2.497999906539917}},{{1.753000020980835},{6.004000186920166},{10.255000114440918}}}),"sort 65 values")
  assert(close(a:tolist(),{{{-11.0},{-6.749000072479248},{-2.497999906539917}},{{1.753000020980835},{6.004000186920166},{10.255000114440918}}}),"sort 65 input mutation")
end
do -- sort 66
  local a=np.array({110,-104,-67,-30},np.int32)
  local r=np.sort(a,1)
  assert(r.dtype=="int32","sort 66 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"sort 66 shape")
  assert(eq(r.strides,{4}),"sort 66 strides")
  assert(close(r:tolist(),{-104,-67,-30,110}),"sort 66 values")
  assert(close(a:tolist(),{110,-104,-67,-30}),"sort 66 input mutation")
end
do -- sort 67
  local a=np.array({{121},{-93},{-56}},np.int8)
  local r=np.sort(a,2)
  assert(r.dtype=="int8","sort 67 dtype "..r.dtype)
  assert(eq(r.shape,{3,1}),"sort 67 shape")
  assert(eq(r.strides,{1,1}),"sort 67 strides")
  assert(close(r:tolist(),{{121},{-93},{-56}}),"sort 67 values")
  assert(close(a:tolist(),{{121},{-93},{-56}}),"sort 67 input mutation")
end
do -- sort 68
  local a=np.array({{{-119,-82,-45},{-8,29,66}},{{103,-111,-74},{-37,0,37}},{{74,111,-103},{-66,-29,8}}},np.int8)
  local r=np.sort(a,2)
  assert(r.dtype=="int8","sort 68 dtype "..r.dtype)
  assert(eq(r.shape,{3,2,3}),"sort 68 shape")
  assert(eq(r.strides,{6,3,1}),"sort 68 strides")
  assert(close(r:tolist(),{{{-119,-82,-45},{-8,29,66}},{{-37,-111,-74},{103,0,37}},{{-66,-29,-103},{74,111,8}}}),"sort 68 values")
  assert(close(a:tolist(),{{{-119,-82,-45},{-8,29,66}},{{103,-111,-74},{-37,0,37}},{{74,111,-103},{-66,-29,8}}}),"sort 68 input mutation")
end
do -- sort 69
  local a=np.array({{true,false},{false,true},{false,true},{false,false},{true,false}},np.bool)
  local r=np.sort(a,1)
  assert(r.dtype=="bool","sort 69 dtype "..r.dtype)
  assert(eq(r.shape,{5,2}),"sort 69 shape")
  assert(eq(r.strides,{2,1}),"sort 69 strides")
  assert(close(r:tolist(),{{false,false},{false,false},{false,false},{true,true},{true,true}}),"sort 69 values")
  assert(close(a:tolist(),{{true,false},{false,true},{false,true},{false,false},{true,false}}),"sort 69 input mutation")
end
do -- sort 70
  local a=np.array({-97,-60,-23,14},np.int32)
  local r=np.sort(a,1)
  assert(r.dtype=="int32","sort 70 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"sort 70 shape")
  assert(eq(r.strides,{4}),"sort 70 strides")
  assert(close(r:tolist(),{-97,-60,-23,14}),"sort 70 values")
  assert(close(a:tolist(),{-97,-60,-23,14}),"sort 70 input mutation")
end
do -- sort 71
  local a=np.array({39},np.uint8)
  local r=np.sort(a,1)
  assert(r.dtype=="uint8","sort 71 dtype "..r.dtype)
  assert(eq(r.shape,{1}),"sort 71 shape")
  assert(eq(r.strides,{1}),"sort 71 strides")
  assert(close(r:tolist(),{39}),"sort 71 values")
  assert(close(a:tolist(),{39}),"sort 71 input mutation")
end
do -- sort 72
  local a=np.array({{50,87,124,161},{198,235,21,58}},np.uint32)
  local r=np.sort(a,1)
  assert(r.dtype=="uint32","sort 72 dtype "..r.dtype)
  assert(eq(r.shape,{2,4}),"sort 72 shape")
  assert(eq(r.strides,{16,4}),"sort 72 strides")
  assert(close(r:tolist(),{{50,87,21,58},{198,235,124,161}}),"sort 72 values")
  assert(close(a:tolist(),{{50,87,124,161},{198,235,21,58}}),"sort 72 input mutation")
end
do -- sort 73
  local a=np.array({-64,-27},np.int64)
  local r=np.sort(a,1)
  assert(r.dtype=="int64","sort 73 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"sort 73 shape")
  assert(eq(r.strides,{8}),"sort 73 strides")
  assert(close(r:tolist(),{-64,-27}),"sort 73 values")
  assert(close(a:tolist(),{-64,-27}),"sort 73 input mutation")
end
do -- sort 74
  local a=np.array({{72,109,146},{183,220,6},{43,80,117},{154,191,228},{14,51,88}},np.uint16)
  local r=np.sort(a,2)
  assert(r.dtype=="uint16","sort 74 dtype "..r.dtype)
  assert(eq(r.shape,{5,3}),"sort 74 shape")
  assert(eq(r.strides,{6,2}),"sort 74 strides")
  assert(close(r:tolist(),{{72,109,146},{6,183,220},{43,80,117},{154,191,228},{14,51,88}}),"sort 74 values")
  assert(close(a:tolist(),{{72,109,146},{183,220,6},{43,80,117},{154,191,228},{14,51,88}}),"sort 74 input mutation")
end
do -- sort 75
  local a=np.array({{-3.5}},np.float32)
  local r=np.sort(a,2)
  assert(r.dtype=="float32","sort 75 dtype "..r.dtype)
  assert(eq(r.shape,{1,1}),"sort 75 shape")
  assert(eq(r.strides,{4,4}),"sort 75 strides")
  assert(close(r:tolist(),{{-3.5}}),"sort 75 values")
  assert(close(a:tolist(),{{-3.5}}),"sort 75 input mutation")
end
do -- sort 76
  local a=np.array({{{94,131,168,205,242},{28,65,102,139,176},{213,250,36,73,110}},{{147,184,221,7,44},{81,118,155,192,229},{15,52,89,126,163}},{{200,237,23,60,97},{134,171,208,245,31},{68,105,142,179,216}},{{2,39,76,113,150},{187,224,10,47,84},{121,158,195,232,18}},{{55,92,129,166,203},{240,26,63,100,137},{174,211,248,34,71}}},np.uint32)
  local r=np.sort(a,3)
  assert(r.dtype=="uint32","sort 76 dtype "..r.dtype)
  assert(eq(r.shape,{5,3,5}),"sort 76 shape")
  assert(eq(r.strides,{60,20,4}),"sort 76 strides")
  assert(close(r:tolist(),{{{94,131,168,205,242},{28,65,102,139,176},{36,73,110,213,250}},{{7,44,147,184,221},{81,118,155,192,229},{15,52,89,126,163}},{{23,60,97,200,237},{31,134,171,208,245},{68,105,142,179,216}},{{2,39,76,113,150},{10,47,84,187,224},{18,121,158,195,232}},{{55,92,129,166,203},{26,63,100,137,240},{34,71,174,211,248}}}),"sort 76 values")
  assert(close(a:tolist(),{{{94,131,168,205,242},{28,65,102,139,176},{213,250,36,73,110}},{{147,184,221,7,44},{81,118,155,192,229},{15,52,89,126,163}},{{200,237,23,60,97},{134,171,208,245,31},{68,105,142,179,216}},{{2,39,76,113,150},{187,224,10,47,84},{121,158,195,232,18}},{{55,92,129,166,203},{240,26,63,100,137},{174,211,248,34,71}}}),"sort 76 input mutation")
end
do -- sort 77
  local a=np.array({{{false,true,false},{false,true,false},{true,false,false}},{{true,false,true},{false,false,true},{false,true,false}},{{false,true,false},{true,false,false},{true,false,true}},{{false,false,true},{false,true,false},{false,true,false}},{{true,false,false},{true,false,true},{false,false,true}}},np.bool)
  local r=np.sort(a,1)
  assert(r.dtype=="bool","sort 77 dtype "..r.dtype)
  assert(eq(r.shape,{5,3,3}),"sort 77 shape")
  assert(eq(r.strides,{9,3,1}),"sort 77 strides")
  assert(close(r:tolist(),{{{false,false,false},{false,false,false},{false,false,false}},{{false,false,false},{false,false,false},{false,false,false}},{{false,false,false},{false,false,false},{false,false,false}},{{true,true,true},{true,true,true},{true,true,true}},{{true,true,true},{true,true,true},{true,true,true}}}),"sort 77 values")
  assert(close(a:tolist(),{{{false,true,false},{false,true,false},{true,false,false}},{{true,false,true},{false,false,true},{false,true,false}},{{false,true,false},{true,false,false},{true,false,true}},{{false,false,true},{false,true,false},{false,true,false}},{{true,false,false},{true,false,true},{false,false,true}}}),"sort 77 input mutation")
end
do -- sort 78
  local a=np.array({-9,28,65},np.int8)
  local r=np.sort(a,1)
  assert(r.dtype=="int8","sort 78 dtype "..r.dtype)
  assert(eq(r.shape,{3}),"sort 78 shape")
  assert(eq(r.strides,{1}),"sort 78 strides")
  assert(close(r:tolist(),{-9,28,65}),"sort 78 values")
  assert(close(a:tolist(),{-9,28,65}),"sort 78 input mutation")
end
do -- sort 79
  local a=np.array({{{2,39},{76,113},{-101,-64}}},np.int64)
  local r=np.sort(a,1)
  assert(r.dtype=="int64","sort 79 dtype "..r.dtype)
  assert(eq(r.shape,{1,3,2}),"sort 79 shape")
  assert(eq(r.strides,{48,16,8}),"sort 79 strides")
  assert(close(r:tolist(),{{{2,39},{76,113},{-101,-64}}}),"sort 79 values")
  assert(close(a:tolist(),{{{2,39},{76,113},{-101,-64}}}),"sort 79 input mutation")
end
do -- sort 80
  local a=np.array({{{13},{50},{87}},{{124},{-90},{-53}},{{-16},{21},{58}}},np.int64)
  local r=np.sort(a,2)
  assert(r.dtype=="int64","sort 80 dtype "..r.dtype)
  assert(eq(r.shape,{3,3,1}),"sort 80 shape")
  assert(eq(r.strides,{24,8,8}),"sort 80 strides")
  assert(close(r:tolist(),{{{13},{50},{87}},{{-90},{-53},{124}},{{-16},{21},{58}}}),"sort 80 values")
  assert(close(a:tolist(),{{{13},{50},{87}},{{124},{-90},{-53}},{{-16},{21},{58}}}),"sort 80 input mutation")
end
do -- sort 81
  local a=np.array({149,186,223,9},np.uint32)
  local r=np.sort(a,1)
  assert(r.dtype=="uint32","sort 81 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"sort 81 shape")
  assert(eq(r.strides,{4}),"sort 81 strides")
  assert(close(r:tolist(),{9,149,186,223}),"sort 81 values")
  assert(close(a:tolist(),{149,186,223,9}),"sort 81 input mutation")
end
do -- sort 82
  local a=np.array({35,72,109,-105},np.int64)
  local r=np.sort(a,1)
  assert(r.dtype=="int64","sort 82 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"sort 82 shape")
  assert(eq(r.strides,{8}),"sort 82 strides")
  assert(close(r:tolist(),{-105,35,72,109}),"sort 82 values")
  assert(close(a:tolist(),{35,72,109,-105}),"sort 82 input mutation")
end
do -- sort 83
  local a=np.array({46,83},np.int32)
  local r=np.sort(a,1)
  assert(r.dtype=="int32","sort 83 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"sort 83 shape")
  assert(eq(r.strides,{4}),"sort 83 strides")
  assert(close(r:tolist(),{46,83}),"sort 83 values")
  assert(close(a:tolist(),{46,83}),"sort 83 input mutation")
end
do -- sort 84
  local a=np.array({{true,false,false,true,false},{true,false,false,true,false},{true,false,false,true,false},{true,false,false,true,false},{true,false,false,true,false}},np.bool)
  local r=np.sort(a,1)
  assert(r.dtype=="bool","sort 84 dtype "..r.dtype)
  assert(eq(r.shape,{5,5}),"sort 84 shape")
  assert(eq(r.strides,{5,1}),"sort 84 strides")
  assert(close(r:tolist(),{{true,false,false,true,false},{true,false,false,true,false},{true,false,false,true,false},{true,false,false,true,false},{true,false,false,true,false}}),"sort 84 values")
  assert(close(a:tolist(),{{true,false,false,true,false},{true,false,false,true,false},{true,false,false,true,false},{true,false,false,true,false},{true,false,false,true,false}}),"sort 84 input mutation")
end
do -- sort 85
  local a=np.array({{193,230,16},{53,90,127},{164,201,238}},np.uint16)
  local r=np.sort(a,1)
  assert(r.dtype=="uint16","sort 85 dtype "..r.dtype)
  assert(eq(r.shape,{3,3}),"sort 85 shape")
  assert(eq(r.strides,{6,2}),"sort 85 strides")
  assert(close(r:tolist(),{{53,90,16},{164,201,127},{193,230,238}}),"sort 85 values")
  assert(close(a:tolist(),{{193,230,16},{53,90,127},{164,201,238}}),"sort 85 input mutation")
end
do -- sort 86
  local a=np.array({{{204,241,27,64,101},{138,175,212,249,35},{72,109,146,183,220},{6,43,80,117,154}},{{191,228,14,51,88},{125,162,199,236,22},{59,96,133,170,207},{244,30,67,104,141}},{{178,215,1,38,75},{112,149,186,223,9},{46,83,120,157,194},{231,17,54,91,128}},{{165,202,239,25,62},{99,136,173,210,247},{33,70,107,144,181},{218,4,41,78,115}},{{152,189,226,12,49},{86,123,160,197,234},{20,57,94,131,168},{205,242,28,65,102}}},np.uint32)
  local r=np.sort(a,1)
  assert(r.dtype=="uint32","sort 86 dtype "..r.dtype)
  assert(eq(r.shape,{5,4,5}),"sort 86 shape")
  assert(eq(r.strides,{80,20,4}),"sort 86 strides")
  assert(close(r:tolist(),{{{152,189,1,12,49},{86,123,160,197,9},{20,57,94,131,168},{6,4,28,65,102}},{{165,202,14,25,62},{99,136,173,210,22},{33,70,107,144,181},{205,17,41,78,115}},{{178,215,27,38,75},{112,149,186,223,35},{46,83,120,157,194},{218,30,54,91,128}},{{191,228,226,51,88},{125,162,199,236,234},{59,96,133,170,207},{231,43,67,104,141}},{{204,241,239,64,101},{138,175,212,249,247},{72,109,146,183,220},{244,242,80,117,154}}}),"sort 86 values")
  assert(close(a:tolist(),{{{204,241,27,64,101},{138,175,212,249,35},{72,109,146,183,220},{6,43,80,117,154}},{{191,228,14,51,88},{125,162,199,236,22},{59,96,133,170,207},{244,30,67,104,141}},{{178,215,1,38,75},{112,149,186,223,9},{46,83,120,157,194},{231,17,54,91,128}},{{165,202,239,25,62},{99,136,173,210,247},{33,70,107,144,181},{218,4,41,78,115}},{{152,189,226,12,49},{86,123,160,197,234},{20,57,94,131,168},{205,242,28,65,102}}}),"sort 86 input mutation")
end
do -- sort 87
  local a=np.array({{215,1},{38,75}},np.uint8)
  local r=np.sort(a,2)
  assert(r.dtype=="uint8","sort 87 dtype "..r.dtype)
  assert(eq(r.shape,{2,2}),"sort 87 shape")
  assert(eq(r.strides,{2,1}),"sort 87 strides")
  assert(close(r:tolist(),{{1,215},{38,75}}),"sort 87 values")
  assert(close(a:tolist(),{{215,1},{38,75}}),"sort 87 input mutation")
end
do -- sort 88
  local a=np.array({101,-113,-76,-39,-2},np.int64)
  local r=np.sort(a,1)
  assert(r.dtype=="int64","sort 88 dtype "..r.dtype)
  assert(eq(r.shape,{5}),"sort 88 shape")
  assert(eq(r.strides,{8}),"sort 88 strides")
  assert(close(r:tolist(),{-113,-76,-39,-2,101}),"sort 88 values")
  assert(close(a:tolist(),{101,-113,-76,-39,-2}),"sort 88 input mutation")
end
do -- sort 89
  local a=np.array({237,23,60,97},np.uint8)
  local r=np.sort(a,1)
  assert(r.dtype=="uint8","sort 89 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"sort 89 shape")
  assert(eq(r.strides,{1}),"sort 89 strides")
  assert(close(r:tolist(),{23,60,97,237}),"sort 89 values")
  assert(close(a:tolist(),{237,23,60,97}),"sort 89 input mutation")
end
do -- sort 90
  local a=np.array({123,-91},np.int16)
  local r=np.sort(a,1)
  assert(r.dtype=="int16","sort 90 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"sort 90 shape")
  assert(eq(r.strides,{2}),"sort 90 strides")
  assert(close(r:tolist(),{-91,123}),"sort 90 values")
  assert(close(a:tolist(),{123,-91}),"sort 90 input mutation")
end
do -- sort 91
  local a=np.array({{false,false,true}},np.bool)
  local r=np.sort(a,2)
  assert(r.dtype=="bool","sort 91 dtype "..r.dtype)
  assert(eq(r.shape,{1,3}),"sort 91 shape")
  assert(eq(r.strides,{3,1}),"sort 91 strides")
  assert(close(r:tolist(),{{false,false,true}}),"sort 91 values")
  assert(close(a:tolist(),{{false,false,true}}),"sort 91 input mutation")
end
do -- sort 92
  local a=np.array({{-106,-69,-32},{5,42,79},{116,-98,-61},{-24,13,50},{87,124,-90}},np.int32)
  local r=np.sort(a,2)
  assert(r.dtype=="int32","sort 92 dtype "..r.dtype)
  assert(eq(r.shape,{5,3}),"sort 92 shape")
  assert(eq(r.strides,{12,4}),"sort 92 strides")
  assert(close(r:tolist(),{{-106,-69,-32},{5,42,79},{-98,-61,116},{-24,13,50},{-90,87,124}}),"sort 92 values")
  assert(close(a:tolist(),{{-106,-69,-32},{5,42,79},{116,-98,-61},{-24,13,50},{87,124,-90}}),"sort 92 input mutation")
end
do -- sort 93
  local a=np.array({{-95,-58},{-21,16},{53,90}},np.int32)
  local r=np.sort(a,2)
  assert(r.dtype=="int32","sort 93 dtype "..r.dtype)
  assert(eq(r.shape,{3,2}),"sort 93 shape")
  assert(eq(r.strides,{8,4}),"sort 93 strides")
  assert(close(r:tolist(),{{-95,-58},{-21,16},{53,90}}),"sort 93 values")
  assert(close(a:tolist(),{{-95,-58},{-21,16},{53,90}}),"sort 93 input mutation")
end
do -- sort 94
  local a=np.array({{{-84,-47,-10,27,64},{101,-113,-76,-39,-2}}},np.int16)
  local r=np.sort(a,1)
  assert(r.dtype=="int16","sort 94 dtype "..r.dtype)
  assert(eq(r.shape,{1,2,5}),"sort 94 shape")
  assert(eq(r.strides,{20,10,2}),"sort 94 strides")
  assert(close(r:tolist(),{{{-84,-47,-10,27,64},{101,-113,-76,-39,-2}}}),"sort 94 values")
  assert(close(a:tolist(),{{{-84,-47,-10,27,64},{101,-113,-76,-39,-2}}}),"sort 94 input mutation")
end
do -- sort 95
  local a=np.array({{{-73,-36,1,38,75},{112,-102,-65,-28,9},{46,83,120,-94,-57},{-20,17,54,91,-123},{-86,-49,-12,25,62}},{{99,-115,-78,-41,-4},{33,70,107,-107,-70},{-33,4,41,78,115},{-99,-62,-25,12,49},{86,123,-91,-54,-17}},{{20,57,94,-120,-83},{-46,-9,28,65,102},{-112,-75,-38,-1,36},{73,110,-104,-67,-30},{7,44,81,118,-96}},{{-59,-22,15,52,89},{-125,-88,-51,-14,23},{60,97,-117,-80,-43},{-6,31,68,105,-109},{-72,-35,2,39,76}},{{113,-101,-64,-27,10},{47,84,121,-93,-56},{-19,18,55,92,-122},{-85,-48,-11,26,63},{100,-114,-77,-40,-3}}},np.int16)
  local r=np.sort(a,3)
  assert(r.dtype=="int16","sort 95 dtype "..r.dtype)
  assert(eq(r.shape,{5,5,5}),"sort 95 shape")
  assert(eq(r.strides,{50,10,2}),"sort 95 strides")
  assert(close(r:tolist(),{{{-73,-36,1,38,75},{-102,-65,-28,9,112},{-94,-57,46,83,120},{-123,-20,17,54,91},{-86,-49,-12,25,62}},{{-115,-78,-41,-4,99},{-107,-70,33,70,107},{-33,4,41,78,115},{-99,-62,-25,12,49},{-91,-54,-17,86,123}},{{-120,-83,20,57,94},{-46,-9,28,65,102},{-112,-75,-38,-1,36},{-104,-67,-30,73,110},{-96,7,44,81,118}},{{-59,-22,15,52,89},{-125,-88,-51,-14,23},{-117,-80,-43,60,97},{-109,-6,31,68,105},{-72,-35,2,39,76}},{{-101,-64,-27,10,113},{-93,-56,47,84,121},{-122,-19,18,55,92},{-85,-48,-11,26,63},{-114,-77,-40,-3,100}}}),"sort 95 values")
  assert(close(a:tolist(),{{{-73,-36,1,38,75},{112,-102,-65,-28,9},{46,83,120,-94,-57},{-20,17,54,91,-123},{-86,-49,-12,25,62}},{{99,-115,-78,-41,-4},{33,70,107,-107,-70},{-33,4,41,78,115},{-99,-62,-25,12,49},{86,123,-91,-54,-17}},{{20,57,94,-120,-83},{-46,-9,28,65,102},{-112,-75,-38,-1,36},{73,110,-104,-67,-30},{7,44,81,118,-96}},{{-59,-22,15,52,89},{-125,-88,-51,-14,23},{60,97,-117,-80,-43},{-6,31,68,105,-109},{-72,-35,2,39,76}},{{113,-101,-64,-27,10},{47,84,121,-93,-56},{-19,18,55,92,-122},{-85,-48,-11,26,63},{100,-114,-77,-40,-3}}}),"sort 95 input mutation")
end
do -- sort 96
  local a=(np.array({{-62},{-25},{12},{49}},np.int8)).T
  local r=np.sort(a,2)
  assert(r.dtype=="int8","sort 96 dtype "..r.dtype)
  assert(eq(r.shape,{1,4}),"sort 96 shape")
  assert(eq(r.strides,{4,1}),"sort 96 strides")
  assert(close(r:tolist(),{{-62,-25,12,49}}),"sort 96 values")
  assert(close(a:tolist(),{{-62,-25,12,49}}),"sort 96 input mutation")
end
do -- sort 97
  local a=np.array({{{false},{true},{false},{false}},{{true},{false},{true},{false}},{{false},{true},{false},{true}},{{false},{false},{true},{false}}},np.bool)
  local r=np.sort(a,1)
  assert(r.dtype=="bool","sort 97 dtype "..r.dtype)
  assert(eq(r.shape,{4,4,1}),"sort 97 shape")
  assert(eq(r.strides,{4,1,1}),"sort 97 strides")
  assert(close(r:tolist(),{{{false},{false},{false},{false}},{{false},{false},{false},{false}},{{false},{true},{true},{false}},{{true},{true},{true},{true}}}),"sort 97 values")
  assert(close(a:tolist(),{{{false},{true},{false},{false}},{{true},{false},{true},{false}},{{false},{true},{false},{true}},{{false},{false},{true},{false}}}),"sort 97 input mutation")
end
do -- sort 98
  local a=np.array({-40,-3},np.int8)
  local r=np.sort(a,1)
  assert(r.dtype=="int8","sort 98 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"sort 98 shape")
  assert(eq(r.strides,{1}),"sort 98 strides")
  assert(close(r:tolist(),{-40,-3}),"sort 98 values")
  assert(close(a:tolist(),{-40,-3}),"sort 98 input mutation")
end
do -- sort 99
  local a=np.array({{{-29,8}}},np.int32)
  local r=np.sort(a,3)
  assert(r.dtype=="int32","sort 99 dtype "..r.dtype)
  assert(eq(r.shape,{1,1,2}),"sort 99 shape")
  assert(eq(r.strides,{8,8,4}),"sort 99 strides")
  assert(close(r:tolist(),{{{-29,8}}}),"sort 99 values")
  assert(close(a:tolist(),{{{-29,8}}}),"sort 99 input mutation")
end
do -- sort 100
  local a=np.array({{{107,144}},{{181,218}},{{4,41}},{{78,115}},{{152,189}}},np.uint32)
  local r=np.sort(a,2)
  assert(r.dtype=="uint32","sort 100 dtype "..r.dtype)
  assert(eq(r.shape,{5,1,2}),"sort 100 shape")
  assert(eq(r.strides,{8,8,4}),"sort 100 strides")
  assert(close(r:tolist(),{{{107,144}},{{181,218}},{{4,41}},{{78,115}},{{152,189}}}),"sort 100 values")
  assert(close(a:tolist(),{{{107,144}},{{181,218}},{{4,41}},{{78,115}},{{152,189}}}),"sort 100 input mutation")
end
do -- sort 101
  local a=(np.array({{-7,30,67,104},{-110,-73,-36,1},{38,75,112,-102},{-65,-28,9,46},{83,120,-94,-57}},np.int32)).T
  local r=np.sort(a,1)
  assert(r.dtype=="int32","sort 101 dtype "..r.dtype)
  assert(eq(r.shape,{4,5}),"sort 101 shape")
  assert(eq(r.strides,{4,16}),"sort 101 strides")
  assert(close(r:tolist(),{{-7,-110,-102,-65,-94},{30,-73,38,-28,-57},{67,-36,75,9,83},{104,1,112,46,120}}),"sort 101 values")
  assert(close(a:tolist(),{{-7,-110,38,-65,83},{30,-73,75,-28,120},{67,-36,112,9,-94},{104,1,-102,46,-57}}),"sort 101 input mutation")
end
do -- sort 102
  local a=np.array({{{4,41,78},{115,-99,-62},{-25,12,49}},{{86,123,-91},{-54,-17,20},{57,94,-120}}},np.int32)
  local r=np.sort(a,3)
  assert(r.dtype=="int32","sort 102 dtype "..r.dtype)
  assert(eq(r.shape,{2,3,3}),"sort 102 shape")
  assert(eq(r.strides,{36,12,4}),"sort 102 strides")
  assert(close(r:tolist(),{{{4,41,78},{-99,-62,115},{-25,12,49}},{{-91,86,123},{-54,-17,20},{-120,57,94}}}),"sort 102 values")
  assert(close(a:tolist(),{{{4,41,78},{115,-99,-62},{-25,12,49}},{{86,123,-91},{-54,-17,20},{57,94,-120}}}),"sort 102 input mutation")
end
do -- sort 103
  local a=np.array({{{140,177,214,0},{37,74,111,148}},{{185,222,8,45},{82,119,156,193}},{{230,16,53,90},{127,164,201,238}},{{24,61,98,135},{172,209,246,32}}},np.uint32)
  local r=np.sort(a,2)
  assert(r.dtype=="uint32","sort 103 dtype "..r.dtype)
  assert(eq(r.shape,{4,2,4}),"sort 103 shape")
  assert(eq(r.strides,{32,16,4}),"sort 103 strides")
  assert(close(r:tolist(),{{{37,74,111,0},{140,177,214,148}},{{82,119,8,45},{185,222,156,193}},{{127,16,53,90},{230,164,201,238}},{{24,61,98,32},{172,209,246,135}}}),"sort 103 values")
  assert(close(a:tolist(),{{{140,177,214,0},{37,74,111,148}},{{185,222,8,45},{82,119,156,193}},{{230,16,53,90},{127,164,201,238}},{{24,61,98,135},{172,209,246,32}}}),"sort 103 input mutation")
end
do -- sort 104
  local a=np.array({26,63,100},np.int32)
  local r=np.sort(a,1)
  assert(r.dtype=="int32","sort 104 dtype "..r.dtype)
  assert(eq(r.shape,{3}),"sort 104 shape")
  assert(eq(r.strides,{4}),"sort 104 strides")
  assert(close(r:tolist(),{26,63,100}),"sort 104 values")
  assert(close(a:tolist(),{26,63,100}),"sort 104 input mutation")
end
do -- sort 105
  local a=np.array({37,74},np.int8)
  local r=np.sort(a,1)
  assert(r.dtype=="int8","sort 105 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"sort 105 shape")
  assert(eq(r.strides,{1}),"sort 105 strides")
  assert(close(r:tolist(),{37,74}),"sort 105 values")
  assert(close(a:tolist(),{37,74}),"sort 105 input mutation")
end
do -- sort 106
  local a=np.array({48,85,122},np.int16)
  local r=np.sort(a,1)
  assert(r.dtype=="int16","sort 106 dtype "..r.dtype)
  assert(eq(r.shape,{3}),"sort 106 shape")
  assert(eq(r.strides,{2}),"sort 106 strides")
  assert(close(r:tolist(),{48,85,122}),"sort 106 values")
  assert(close(a:tolist(),{48,85,122}),"sort 106 input mutation")
end
do -- sort 107
  local a=np.array({{{-3.75,0.501,4.752},{9.003,-10.996,-6.745},{-2.494,1.757,6.008},{10.259,-9.74,-5.489}}},np.float64)
  local r=np.sort(a,2)
  assert(r.dtype=="float64","sort 107 dtype "..r.dtype)
  assert(eq(r.shape,{1,4,3}),"sort 107 shape")
  assert(eq(r.strides,{96,24,8}),"sort 107 strides")
  assert(close(r:tolist(),{{{-3.75,-10.996,-6.745},{-2.494,-9.74,-5.489},{9.003,0.501,4.752},{10.259,1.757,6.008}}}),"sort 107 values")
  assert(close(a:tolist(),{{{-3.75,0.501,4.752},{9.003,-10.996,-6.745},{-2.494,1.757,6.008},{10.259,-9.74,-5.489}}}),"sort 107 input mutation")
end
do -- sort 108
  local a=np.array({{{195,232},{18,55},{92,129}},{{166,203},{240,26},{63,100}}},np.uint32)
  local r=np.sort(a,2)
  assert(r.dtype=="uint32","sort 108 dtype "..r.dtype)
  assert(eq(r.shape,{2,3,2}),"sort 108 shape")
  assert(eq(r.strides,{24,8,4}),"sort 108 strides")
  assert(close(r:tolist(),{{{18,55},{92,129},{195,232}},{{63,26},{166,100},{240,203}}}),"sort 108 values")
  assert(close(a:tolist(),{{{195,232},{18,55},{92,129}},{{166,203},{240,26},{63,100}}}),"sort 108 input mutation")
end
do -- sort 109
  local a=(np.array({{206,243,29},{66,103,140}},np.uint16)).T
  local r=np.sort(a,1)
  assert(r.dtype=="uint16","sort 109 dtype "..r.dtype)
  assert(eq(r.shape,{3,2}),"sort 109 shape")
  assert(eq(r.strides,{2,6}),"sort 109 strides")
  assert(close(r:tolist(),{{29,66},{206,103},{243,140}}),"sort 109 values")
  assert(close(a:tolist(),{{206,66},{243,103},{29,140}}),"sort 109 input mutation")
end
do -- sort 110
  local a=np.array({{92,-122,-85,-48,-11}},np.int8)
  local r=np.sort(a,2)
  assert(r.dtype=="int8","sort 110 dtype "..r.dtype)
  assert(eq(r.shape,{1,5}),"sort 110 shape")
  assert(eq(r.strides,{5,1}),"sort 110 strides")
  assert(close(r:tolist(),{{-122,-85,-48,-11,92}}),"sort 110 values")
  assert(close(a:tolist(),{{92,-122,-85,-48,-11}}),"sort 110 input mutation")
end
do -- sort 111
  local a=np.array({228,14,51,88,125},np.uint8)
  local r=np.sort(a,1)
  assert(r.dtype=="uint8","sort 111 dtype "..r.dtype)
  assert(eq(r.shape,{5}),"sort 111 shape")
  assert(eq(r.strides,{1}),"sort 111 strides")
  assert(close(r:tolist(),{14,51,88,125,228}),"sort 111 values")
  assert(close(a:tolist(),{228,14,51,88,125}),"sort 111 input mutation")
end
do -- sort 112
  local a=np.array({{{114},{-100},{-63},{-26},{11}},{{48},{85},{122},{-92},{-55}},{{-18},{19},{56},{93},{-121}},{{-84},{-47},{-10},{27},{64}},{{101},{-113},{-76},{-39},{-2}}},np.int16)
  local r=np.sort(a,2)
  assert(r.dtype=="int16","sort 112 dtype "..r.dtype)
  assert(eq(r.shape,{5,5,1}),"sort 112 shape")
  assert(eq(r.strides,{10,2,2}),"sort 112 strides")
  assert(close(r:tolist(),{{{-100},{-63},{-26},{11},{114}},{{-92},{-55},{48},{85},{122}},{{-121},{-18},{19},{56},{93}},{{-84},{-47},{-10},{27},{64}},{{-113},{-76},{-39},{-2},{101}}}),"sort 112 values")
  assert(close(a:tolist(),{{{114},{-100},{-63},{-26},{11}},{{48},{85},{122},{-92},{-55}},{{-18},{19},{56},{93},{-121}},{{-84},{-47},{-10},{27},{64}},{{101},{-113},{-76},{-39},{-2}}}),"sort 112 input mutation")
end
do -- sort 113
  local a=np.array({{125,-89,-52,-15,22},{59,96,-118,-81,-44},{-7,30,67,104,-110},{-73,-36,1,38,75},{112,-102,-65,-28,9}},np.int16)
  local r=np.sort(a,1)
  assert(r.dtype=="int16","sort 113 dtype "..r.dtype)
  assert(eq(r.shape,{5,5}),"sort 113 shape")
  assert(eq(r.strides,{10,2}),"sort 113 strides")
  assert(close(r:tolist(),{{-73,-102,-118,-81,-110},{-7,-89,-65,-28,-44},{59,-36,-52,-15,9},{112,30,1,38,22},{125,96,67,104,75}}),"sort 113 values")
  assert(close(a:tolist(),{{125,-89,-52,-15,22},{59,96,-118,-81,-44},{-7,30,67,104,-110},{-73,-36,1,38,75},{112,-102,-65,-28,9}}),"sort 113 input mutation")
end
do -- sort 114
  local a=np.array({{-115,-78,-41},{-4,33,70}},np.int64)
  local r=np.sort(a,2)
  assert(r.dtype=="int64","sort 114 dtype "..r.dtype)
  assert(eq(r.shape,{2,3}),"sort 114 shape")
  assert(eq(r.strides,{24,8}),"sort 114 strides")
  assert(close(r:tolist(),{{-115,-78,-41},{-4,33,70}}),"sort 114 values")
  assert(close(a:tolist(),{{-115,-78,-41},{-4,33,70}}),"sort 114 input mutation")
end
do -- sort 115
  local a=np.array({{{21},{58}}},np.uint32)
  local r=np.sort(a,1)
  assert(r.dtype=="uint32","sort 115 dtype "..r.dtype)
  assert(eq(r.shape,{1,2,1}),"sort 115 shape")
  assert(eq(r.strides,{8,4,4}),"sort 115 strides")
  assert(close(r:tolist(),{{{21},{58}}}),"sort 115 values")
  assert(close(a:tolist(),{{{21},{58}}}),"sort 115 input mutation")
end
do -- sort 116
  local a=(np.array({{-93,-56,-19,18},{55,92,-122,-85}},np.int8)).T
  local r=np.sort(a,2)
  assert(r.dtype=="int8","sort 116 dtype "..r.dtype)
  assert(eq(r.shape,{4,2}),"sort 116 shape")
  assert(eq(r.strides,{1,4}),"sort 116 strides")
  assert(close(r:tolist(),{{-93,55},{-56,92},{-122,-19},{-85,18}}),"sort 116 values")
  assert(close(a:tolist(),{{-93,55},{-56,92},{-19,-122},{18,-85}}),"sort 116 input mutation")
end
do -- sort 117
  local a=np.array({{{3.75}},{{8.001}},{{-11.998}},{{-7.747}},{{-3.496}}},np.float32)
  local r=np.sort(a,3)
  assert(r.dtype=="float32","sort 117 dtype "..r.dtype)
  assert(eq(r.shape,{5,1,1}),"sort 117 shape")
  assert(eq(r.strides,{4,4,4}),"sort 117 strides")
  assert(close(r:tolist(),{{{3.75}},{{8.00100040435791}},{{-11.998000144958496}},{{-7.747000217437744}},{{-3.496000051498413}}}),"sort 117 values")
  assert(close(a:tolist(),{{{3.75}},{{8.00100040435791}},{{-11.998000144958496}},{{-7.747000217437744}},{{-3.496000051498413}}}),"sort 117 input mutation")
end
do -- sort 118
  local a=np.array({54,91},np.uint8)
  local r=np.sort(a,1)
  assert(r.dtype=="uint8","sort 118 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"sort 118 shape")
  assert(eq(r.strides,{1}),"sort 118 strides")
  assert(close(r:tolist(),{54,91}),"sort 118 values")
  assert(close(a:tolist(),{54,91}),"sort 118 input mutation")
end
do -- sort 119
  local a=np.array({{{-60,-23},{14,51}},{{88,125},{-89,-52}},{{-15,22},{59,96}},{{-118,-81},{-44,-7}}},np.int32)
  local r=np.sort(a,2)
  assert(r.dtype=="int32","sort 119 dtype "..r.dtype)
  assert(eq(r.shape,{4,2,2}),"sort 119 shape")
  assert(eq(r.strides,{16,8,4}),"sort 119 strides")
  assert(close(r:tolist(),{{{-60,-23},{14,51}},{{-89,-52},{88,125}},{{-15,22},{59,96}},{{-118,-81},{-44,-7}}}),"sort 119 values")
  assert(close(a:tolist(),{{{-60,-23},{14,51}},{{88,125},{-89,-52}},{{-15,22},{59,96}},{{-118,-81},{-44,-7}}}),"sort 119 input mutation")
end
do -- sort 120
  local a=np.array({{-49,-12,25},{62,99,-115},{-78,-41,-4},{33,70,107}},np.int8)
  local r=np.sort(a,1)
  assert(r.dtype=="int8","sort 120 dtype "..r.dtype)
  assert(eq(r.shape,{4,3}),"sort 120 shape")
  assert(eq(r.strides,{3,1}),"sort 120 strides")
  assert(close(r:tolist(),{{-78,-41,-115},{-49,-12,-4},{33,70,25},{62,99,107}}),"sort 120 values")
  assert(close(a:tolist(),{{-49,-12,25},{62,99,-115},{-78,-41,-4},{33,70,107}}),"sort 120 input mutation")
end
do -- sort 121
  local a=np.array({{{6.75,11.001},{-8.998,-4.747}},{{-0.496,3.755},{8.006,-11.993}}},np.float32)
  local r=np.sort(a,1)
  assert(r.dtype=="float32","sort 121 dtype "..r.dtype)
  assert(eq(r.shape,{2,2,2}),"sort 121 shape")
  assert(eq(r.strides,{16,8,4}),"sort 121 strides")
  assert(close(r:tolist(),{{{-0.4959999918937683,3.755000114440918},{-8.998000144958496,-11.993000030517578}},{{6.75,11.00100040435791},{8.005999565124512,-4.747000217437744}}}),"sort 121 values")
  assert(close(a:tolist(),{{{6.75,11.00100040435791},{-8.998000144958496,-4.747000217437744}},{{-0.4959999918937683,3.755000114440918},{8.005999565124512,-11.993000030517578}}}),"sort 121 input mutation")
end
do -- sort 122
  local a=np.array({7.5},np.float32)
  local r=np.sort(a,1)
  assert(r.dtype=="float32","sort 122 dtype "..r.dtype)
  assert(eq(r.shape,{1}),"sort 122 shape")
  assert(eq(r.strides,{4}),"sort 122 strides")
  assert(close(r:tolist(),{7.5}),"sort 122 values")
  assert(close(a:tolist(),{7.5}),"sort 122 input mutation")
end
do -- sort 123
  local a=np.array({false,true,false},np.bool)
  local r=np.sort(a,1)
  assert(r.dtype=="bool","sort 123 dtype "..r.dtype)
  assert(eq(r.shape,{3}),"sort 123 shape")
  assert(eq(r.strides,{1}),"sort 123 strides")
  assert(close(r:tolist(),{false,false,true}),"sort 123 values")
  assert(close(a:tolist(),{false,true,false}),"sort 123 input mutation")
end
do -- sort 124
  local a=np.array({{{-5,32}},{{69,106}}},np.int16)
  local r=np.sort(a,3)
  assert(r.dtype=="int16","sort 124 dtype "..r.dtype)
  assert(eq(r.shape,{2,1,2}),"sort 124 shape")
  assert(eq(r.strides,{4,4,2}),"sort 124 strides")
  assert(close(r:tolist(),{{{-5,32}},{{69,106}}}),"sort 124 values")
  assert(close(a:tolist(),{{{-5,32}},{{69,106}}}),"sort 124 input mutation")
end
do -- sort 125
  local a=np.array({131,168,205,242},np.uint8)
  local r=np.sort(a,1)
  assert(r.dtype=="uint8","sort 125 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"sort 125 shape")
  assert(eq(r.strides,{1}),"sort 125 strides")
  assert(close(r:tolist(),{131,168,205,242}),"sort 125 values")
  assert(close(a:tolist(),{131,168,205,242}),"sort 125 input mutation")
end
do -- sort 126
  local a=np.array({{{17,54,91},{-123,-86,-49},{-12,25,62},{99,-115,-78}},{{-41,-4,33},{70,107,-107},{-70,-33,4},{41,78,115}},{{-99,-62,-25},{12,49,86},{123,-91,-54},{-17,20,57}},{{94,-120,-83},{-46,-9,28},{65,102,-112},{-75,-38,-1}}},np.int64)
  local r=np.sort(a,1)
  assert(r.dtype=="int64","sort 126 dtype "..r.dtype)
  assert(eq(r.shape,{4,4,3}),"sort 126 shape")
  assert(eq(r.strides,{96,24,8}),"sort 126 strides")
  assert(close(r:tolist(),{{{-99,-120,-83},{-123,-86,-107},{-70,-91,-112},{-75,-115,-78}},{{-41,-62,-25},{-46,-9,-49},{-12,-33,-54},{-17,-38,-1}},{{17,-4,33},{12,49,28},{65,25,4},{41,20,57}},{{94,54,91},{70,107,86},{123,102,62},{99,78,115}}}),"sort 126 values")
  assert(close(a:tolist(),{{{17,54,91},{-123,-86,-49},{-12,25,62},{99,-115,-78}},{{-41,-4,33},{70,107,-107},{-70,-33,4},{41,78,115}},{{-99,-62,-25},{12,49,86},{123,-91,-54},{-17,20,57}},{{94,-120,-83},{-46,-9,28},{65,102,-112},{-75,-38,-1}}}),"sort 126 input mutation")
end
do -- sort 127
  local a=(np.array({{153,190,227},{13,50,87}},np.uint32)).T
  local r=np.sort(a,1)
  assert(r.dtype=="uint32","sort 127 dtype "..r.dtype)
  assert(eq(r.shape,{3,2}),"sort 127 shape")
  assert(eq(r.strides,{4,12}),"sort 127 strides")
  assert(close(r:tolist(),{{153,13},{190,50},{227,87}}),"sort 127 values")
  assert(close(a:tolist(),{{153,13},{190,50},{227,87}}),"sort 127 input mutation")
end
do -- sort 128
  local a=np.array({164,201,238,24,61},np.uint32)
  local r=np.sort(a,1)
  assert(r.dtype=="uint32","sort 128 dtype "..r.dtype)
  assert(eq(r.shape,{5}),"sort 128 shape")
  assert(eq(r.strides,{4}),"sort 128 strides")
  assert(close(r:tolist(),{24,61,164,201,238}),"sort 128 values")
  assert(close(a:tolist(),{164,201,238,24,61}),"sort 128 input mutation")
end
do -- sort 129
  local a=np.array({{{50,87,124},{-90,-53,-16},{21,58,95},{-119,-82,-45},{-8,29,66}},{{103,-111,-74},{-37,0,37},{74,111,-103},{-66,-29,8},{45,82,119}},{{-95,-58,-21},{16,53,90},{-124,-87,-50},{-13,24,61},{98,-116,-79}},{{-42,-5,32},{69,106,-108},{-71,-34,3},{40,77,114},{-100,-63,-26}}},np.int64)
  local r=np.sort(a,3)
  assert(r.dtype=="int64","sort 129 dtype "..r.dtype)
  assert(eq(r.shape,{4,5,3}),"sort 129 shape")
  assert(eq(r.strides,{120,24,8}),"sort 129 strides")
  assert(close(r:tolist(),{{{50,87,124},{-90,-53,-16},{21,58,95},{-119,-82,-45},{-8,29,66}},{{-111,-74,103},{-37,0,37},{-103,74,111},{-66,-29,8},{45,82,119}},{{-95,-58,-21},{16,53,90},{-124,-87,-50},{-13,24,61},{-116,-79,98}},{{-42,-5,32},{-108,69,106},{-71,-34,3},{40,77,114},{-100,-63,-26}}}),"sort 129 values")
  assert(close(a:tolist(),{{{50,87,124},{-90,-53,-16},{21,58,95},{-119,-82,-45},{-8,29,66}},{{103,-111,-74},{-37,0,37},{74,111,-103},{-66,-29,8},{45,82,119}},{{-95,-58,-21},{16,53,90},{-124,-87,-50},{-13,24,61},{98,-116,-79}},{{-42,-5,32},{69,106,-108},{-71,-34,3},{40,77,114},{-100,-63,-26}}}),"sort 129 input mutation")
end
do -- sort 130
  local a=np.array({{61,98,-116,-79,-42},{-5,32,69,106,-108},{-71,-34,3,40,77}},np.int32)
  local r=np.sort(a,1)
  assert(r.dtype=="int32","sort 130 dtype "..r.dtype)
  assert(eq(r.shape,{3,5}),"sort 130 shape")
  assert(eq(r.strides,{20,4}),"sort 130 strides")
  assert(close(r:tolist(),{{-71,-34,-116,-79,-108},{-5,32,3,40,-42},{61,98,69,106,77}}),"sort 130 values")
  assert(close(a:tolist(),{{61,98,-116,-79,-42},{-5,32,69,106,-108},{-71,-34,3,40,77}}),"sort 130 input mutation")
end
do -- sort 131
  local a=np.array({{{72},{109},{-105},{-68},{-31}},{{6},{43},{80},{117},{-97}},{{-60},{-23},{14},{51},{88}},{{125},{-89},{-52},{-15},{22}},{{59},{96},{-118},{-81},{-44}}},np.int64)
  local r=np.sort(a,3)
  assert(r.dtype=="int64","sort 131 dtype "..r.dtype)
  assert(eq(r.shape,{5,5,1}),"sort 131 shape")
  assert(eq(r.strides,{40,8,8}),"sort 131 strides")
  assert(close(r:tolist(),{{{72},{109},{-105},{-68},{-31}},{{6},{43},{80},{117},{-97}},{{-60},{-23},{14},{51},{88}},{{125},{-89},{-52},{-15},{22}},{{59},{96},{-118},{-81},{-44}}}),"sort 131 values")
  assert(close(a:tolist(),{{{72},{109},{-105},{-68},{-31}},{{6},{43},{80},{117},{-97}},{{-60},{-23},{14},{51},{88}},{{125},{-89},{-52},{-15},{22}},{{59},{96},{-118},{-81},{-44}}}),"sort 131 input mutation")
end
do -- sort 132
  local a=np.array({{208,245,31},{68,105,142}},np.uint32)
  local r=np.sort(a,2)
  assert(r.dtype=="uint32","sort 132 dtype "..r.dtype)
  assert(eq(r.shape,{2,3}),"sort 132 shape")
  assert(eq(r.strides,{12,4}),"sort 132 strides")
  assert(close(r:tolist(),{{31,208,245},{68,105,142}}),"sort 132 values")
  assert(close(a:tolist(),{{208,245,31},{68,105,142}}),"sort 132 input mutation")
end
do -- sort 133
  local a=np.array({94,-120},np.int32)
  local r=np.sort(a,1)
  assert(r.dtype=="int32","sort 133 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"sort 133 shape")
  assert(eq(r.strides,{4}),"sort 133 strides")
  assert(close(r:tolist(),{-120,94}),"sort 133 values")
  assert(close(a:tolist(),{94,-120}),"sort 133 input mutation")
end
do -- sort 134
  local a=np.array({230},np.uint16)
  local r=np.sort(a,1)
  assert(r.dtype=="uint16","sort 134 dtype "..r.dtype)
  assert(eq(r.shape,{1}),"sort 134 shape")
  assert(eq(r.strides,{2}),"sort 134 strides")
  assert(close(r:tolist(),{230}),"sort 134 values")
  assert(close(a:tolist(),{230}),"sort 134 input mutation")
end
do -- sort 135
  local a=(np.array({{241},{27},{64},{101},{138}},np.uint8)).T
  local r=np.sort(a,2)
  assert(r.dtype=="uint8","sort 135 dtype "..r.dtype)
  assert(eq(r.shape,{1,5}),"sort 135 shape")
  assert(eq(r.strides,{5,1}),"sort 135 strides")
  assert(close(r:tolist(),{{27,64,101,138,241}}),"sort 135 values")
  assert(close(a:tolist(),{{241,27,64,101,138}}),"sort 135 input mutation")
end
do -- sort 136
  local a=np.array({{{1,38,75,112,149},{186,223,9,46,83},{120,157,194,231,17},{54,91,128,165,202},{239,25,62,99,136}},{{173,210,247,33,70},{107,144,181,218,4},{41,78,115,152,189},{226,12,49,86,123},{160,197,234,20,57}},{{94,131,168,205,242},{28,65,102,139,176},{213,250,36,73,110},{147,184,221,7,44},{81,118,155,192,229}},{{15,52,89,126,163},{200,237,23,60,97},{134,171,208,245,31},{68,105,142,179,216},{2,39,76,113,150}}},np.uint32)
  local r=np.sort(a,2)
  assert(r.dtype=="uint32","sort 136 dtype "..r.dtype)
  assert(eq(r.shape,{4,5,5}),"sort 136 shape")
  assert(eq(r.strides,{100,20,4}),"sort 136 strides")
  assert(close(r:tolist(),{{{1,25,9,46,17},{54,38,62,99,83},{120,91,75,112,136},{186,157,128,165,149},{239,223,194,231,202}},{{41,12,49,20,4},{107,78,115,33,57},{160,144,181,86,70},{173,197,234,152,123},{226,210,247,218,189}},{{28,65,36,7,44},{81,118,102,73,110},{94,131,155,139,176},{147,184,168,192,229},{213,250,221,205,242}},{{2,39,23,60,31},{15,52,76,113,97},{68,105,89,126,150},{134,171,142,179,163},{200,237,208,245,216}}}),"sort 136 values")
  assert(close(a:tolist(),{{{1,38,75,112,149},{186,223,9,46,83},{120,157,194,231,17},{54,91,128,165,202},{239,25,62,99,136}},{{173,210,247,33,70},{107,144,181,218,4},{41,78,115,152,189},{226,12,49,86,123},{160,197,234,20,57}},{{94,131,168,205,242},{28,65,102,139,176},{213,250,36,73,110},{147,184,221,7,44},{81,118,155,192,229}},{{15,52,89,126,163},{200,237,23,60,97},{134,171,208,245,31},{68,105,142,179,216},{2,39,76,113,150}}}),"sort 136 input mutation")
end
do -- sort 137
  local a=np.array({{-113},{-76},{-39},{-2}},np.int16)
  local r=np.sort(a,2)
  assert(r.dtype=="int16","sort 137 dtype "..r.dtype)
  assert(eq(r.shape,{4,1}),"sort 137 shape")
  assert(eq(r.strides,{2,2}),"sort 137 strides")
  assert(close(r:tolist(),{{-113},{-76},{-39},{-2}}),"sort 137 values")
  assert(close(a:tolist(),{{-113},{-76},{-39},{-2}}),"sort 137 input mutation")
end
do -- sort 138
  local a=np.array({-102,-65,-28},np.int8)
  local r=np.sort(a,1)
  assert(r.dtype=="int8","sort 138 dtype "..r.dtype)
  assert(eq(r.shape,{3}),"sort 138 shape")
  assert(eq(r.strides,{1}),"sort 138 strides")
  assert(close(r:tolist(),{-102,-65,-28}),"sort 138 values")
  assert(close(a:tolist(),{-102,-65,-28}),"sort 138 input mutation")
end
do -- sort 139
  local a=np.array({{-4.0,0/0,4.502},{8.753,-11.246,-6.995},{-2.744,1.507,5.758},{10.009,-9.99,-5.739},{-1.488,2.763,0/0}},np.float64)
  local r=np.sort(a,1)
  assert(r.dtype=="float64","sort 139 dtype "..r.dtype)
  assert(eq(r.shape,{5,3}),"sort 139 shape")
  assert(eq(r.strides,{24,8}),"sort 139 strides")
  assert(close(r:tolist(),{{-4.0,-11.246,-6.995},{-2.744,-9.99,-5.739},{-1.488,1.507,4.502},{8.753,2.763,5.758},{10.009,0/0,0/0}}),"sort 139 values")
  assert(close(a:tolist(),{{-4.0,0/0,4.502},{8.753,-11.246,-6.995},{-2.744,1.507,5.758},{10.009,-9.99,-5.739},{-1.488,2.763,0/0}}),"sort 139 input mutation")
end
do -- sort 140
  local a=(np.array({{true,false,true,false},{false,true,false,true},{false,false,true,false}},np.bool)).T
  local r=np.sort(a,2)
  assert(r.dtype=="bool","sort 140 dtype "..r.dtype)
  assert(eq(r.shape,{4,3}),"sort 140 shape")
  assert(eq(r.strides,{1,4}),"sort 140 strides")
  assert(close(r:tolist(),{{false,false,true},{false,false,true},{false,true,true},{false,false,true}}),"sort 140 values")
  assert(close(a:tolist(),{{true,false,false},{false,true,false},{true,false,true},{false,true,false}}),"sort 140 input mutation")
end
do -- sort 141
  local a=np.array({{{56,93,130,167},{204,241,27,64},{101,138,175,212},{249,35,72,109}},{{146,183,220,6},{43,80,117,154},{191,228,14,51},{88,125,162,199}},{{236,22,59,96},{133,170,207,244},{30,67,104,141},{178,215,1,38}},{{75,112,149,186},{223,9,46,83},{120,157,194,231},{17,54,91,128}},{{165,202,239,25},{62,99,136,173},{210,247,33,70},{107,144,181,218}}},np.uint8)
  local r=np.sort(a,3)
  assert(r.dtype=="uint8","sort 141 dtype "..r.dtype)
  assert(eq(r.shape,{5,4,4}),"sort 141 shape")
  assert(eq(r.strides,{16,4,1}),"sort 141 strides")
  assert(close(r:tolist(),{{{56,93,130,167},{27,64,204,241},{101,138,175,212},{35,72,109,249}},{{6,146,183,220},{43,80,117,154},{14,51,191,228},{88,125,162,199}},{{22,59,96,236},{133,170,207,244},{30,67,104,141},{1,38,178,215}},{{75,112,149,186},{9,46,83,223},{120,157,194,231},{17,54,91,128}},{{25,165,202,239},{62,99,136,173},{33,70,210,247},{107,144,181,218}}}),"sort 141 values")
  assert(close(a:tolist(),{{{56,93,130,167},{204,241,27,64},{101,138,175,212},{249,35,72,109}},{{146,183,220,6},{43,80,117,154},{191,228,14,51},{88,125,162,199}},{{236,22,59,96},{133,170,207,244},{30,67,104,141},{178,215,1,38}},{{75,112,149,186},{223,9,46,83},{120,157,194,231},{17,54,91,128}},{{165,202,239,25},{62,99,136,173},{210,247,33,70},{107,144,181,218}}}),"sort 141 input mutation")
end
do -- sort 142
  local a=np.array({{{-1.75,0/0},{6.752,11.003},{-8.996,-4.745},{-0.494,3.757},{8.008,-11.991}},{{-7.74,-3.489},{0.762,5.013},{9.264,-10.735},{-6.484,-2.233},{2.018,6.269}},{{10.52,-9.479},{-5.228,-0.977},{3.274,7.525},{11.776,-8.223},{-3.972,0/0}}},np.float64)
  local r=np.sort(a,2)
  assert(r.dtype=="float64","sort 142 dtype "..r.dtype)
  assert(eq(r.shape,{3,5,2}),"sort 142 shape")
  assert(eq(r.strides,{80,16,8}),"sort 142 strides")
  assert(close(r:tolist(),{{{-8.996,-11.991},{-1.75,-4.745},{-0.494,3.757},{6.752,11.003},{8.008,0/0}},{{-7.74,-10.735},{-6.484,-3.489},{0.762,-2.233},{2.018,5.013},{9.264,6.269}},{{-5.228,-9.479},{-3.972,-8.223},{3.274,-0.977},{10.52,7.525},{11.776,0/0}}}),"sort 142 values")
  assert(close(a:tolist(),{{{-1.75,0/0},{6.752,11.003},{-8.996,-4.745},{-0.494,3.757},{8.008,-11.991}},{{-7.74,-3.489},{0.762,5.013},{9.264,-10.735},{-6.484,-2.233},{2.018,6.269}},{{10.52,-9.479},{-5.228,-0.977},{3.274,7.525},{11.776,-8.223},{-3.972,0/0}}}),"sort 142 input mutation")
end
do -- sort 143
  local a=np.array({{-1.0,3.251,7.502,11.753,-8.246},{-3.995,0.256,4.507,8.758,-11.241},{-6.99,-2.739,1.512,5.763,10.014},{-9.985,-5.734,-1.483,2.768,7.019}},np.float32)
  local r=np.sort(a,2)
  assert(r.dtype=="float32","sort 143 dtype "..r.dtype)
  assert(eq(r.shape,{4,5}),"sort 143 shape")
  assert(eq(r.strides,{20,4}),"sort 143 strides")
  assert(close(r:tolist(),{{-8.246000289916992,-1.0,3.250999927520752,7.501999855041504,11.753000259399414},{-11.241000175476074,-3.994999885559082,0.25600001215934753,4.506999969482422,8.758000373840332},{-6.989999771118164,-2.739000082015991,1.5119999647140503,5.763000011444092,10.013999938964844},{-9.984999656677246,-5.734000205993652,-1.4830000400543213,2.7679998874664307,7.019000053405762}}),"sort 143 values")
  assert(close(a:tolist(),{{-1.0,3.250999927520752,7.501999855041504,11.753000259399414,-8.246000289916992},{-3.994999885559082,0.25600001215934753,4.506999969482422,8.758000373840332,-11.241000175476074},{-6.989999771118164,-2.739000082015991,1.5119999647140503,5.763000011444092,10.013999938964844},{-9.984999656677246,-5.734000205993652,-1.4830000400543213,2.7679998874664307,7.019000053405762}}),"sort 143 input mutation")
end
do -- sort 144
  local a=np.array({{{-0.25},{4.001},{8.252},{-11.747},{-7.496}},{{-3.245},{1.006},{5.257},{9.508},{-10.491}},{{-6.24},{-1.989},{2.262},{6.513},{10.764}},{{-9.235},{-4.984},{-0.733},{3.518},{7.769}},{{12.02},{-7.979},{-3.728},{0.523},{4.774}}},np.float32)
  local r=np.sort(a,2)
  assert(r.dtype=="float32","sort 144 dtype "..r.dtype)
  assert(eq(r.shape,{5,5,1}),"sort 144 shape")
  assert(eq(r.strides,{20,4,4}),"sort 144 strides")
  assert(close(r:tolist(),{{{-11.746999740600586},{-7.495999813079834},{-0.25},{4.000999927520752},{8.251999855041504}},{{-10.491000175476074},{-3.244999885559082},{1.00600004196167},{5.256999969482422},{9.508000373840332}},{{-6.239999771118164},{-1.9889999628067017},{2.26200008392334},{6.513000011444092},{10.763999938964844}},{{-9.234999656677246},{-4.984000205993652},{-0.7329999804496765},{3.5179998874664307},{7.769000053405762}},{{-7.979000091552734},{-3.7279999256134033},{0.5230000019073486},{4.77400016784668},{12.020000457763672}}}),"sort 144 values")
  assert(close(a:tolist(),{{{-0.25},{4.000999927520752},{8.251999855041504},{-11.746999740600586},{-7.495999813079834}},{{-3.244999885559082},{1.00600004196167},{5.256999969482422},{9.508000373840332},{-10.491000175476074}},{{-6.239999771118164},{-1.9889999628067017},{2.26200008392334},{6.513000011444092},{10.763999938964844}},{{-9.234999656677246},{-4.984000205993652},{-0.7329999804496765},{3.5179998874664307},{7.769000053405762}},{{12.020000457763672},{-7.979000091552734},{-3.7279999256134033},{0.5230000019073486},{4.77400016784668}}}),"sort 144 input mutation")
end
do -- sort 145
  local a=np.array({{{-25,12,49,86,123},{-91,-54,-17,20,57},{94,-120,-83,-46,-9},{28,65,102,-112,-75},{-38,-1,36,73,110}},{{-104,-67,-30,7,44},{81,118,-96,-59,-22},{15,52,89,-125,-88},{-51,-14,23,60,97},{-117,-80,-43,-6,31}},{{68,105,-109,-72,-35},{2,39,76,113,-101},{-64,-27,10,47,84},{121,-93,-56,-19,18},{55,92,-122,-85,-48}},{{-11,26,63,100,-114},{-77,-40,-3,34,71},{108,-106,-69,-32,5},{42,79,116,-98,-61},{-24,13,50,87,124}}},np.int64)
  local r=np.sort(a,1)
  assert(r.dtype=="int64","sort 145 dtype "..r.dtype)
  assert(eq(r.shape,{4,5,5}),"sort 145 shape")
  assert(eq(r.strides,{200,40,8}),"sort 145 strides")
  assert(close(r:tolist(),{{{-104,-67,-109,-72,-114},{-91,-54,-96,-59,-101},{-64,-120,-83,-125,-88},{-51,-93,-56,-112,-75},{-117,-80,-122,-85,-48}},{{-25,12,-30,7,-35},{-77,-40,-17,20,-22},{15,-106,-69,-46,-9},{28,-14,23,-98,-61},{-38,-1,-43,-6,31}},{{-11,26,49,86,44},{2,39,-3,34,57},{94,-27,10,-32,5},{42,65,102,-19,18},{-24,13,36,73,110}},{{68,105,63,100,123},{81,118,76,113,71},{108,52,89,47,84},{121,79,116,60,97},{55,92,50,87,124}}}),"sort 145 values")
  assert(close(a:tolist(),{{{-25,12,49,86,123},{-91,-54,-17,20,57},{94,-120,-83,-46,-9},{28,65,102,-112,-75},{-38,-1,36,73,110}},{{-104,-67,-30,7,44},{81,118,-96,-59,-22},{15,52,89,-125,-88},{-51,-14,23,60,97},{-117,-80,-43,-6,31}},{{68,105,-109,-72,-35},{2,39,76,113,-101},{-64,-27,10,47,84},{121,-93,-56,-19,18},{55,92,-122,-85,-48}},{{-11,26,63,100,-114},{-77,-40,-3,34,71},{108,-106,-69,-32,5},{42,79,116,-98,-61},{-24,13,50,87,124}}}),"sort 145 input mutation")
end
do -- sort 146
  local a=np.array({{{111,148,185,222,8},{45,82,119,156,193},{230,16,53,90,127}},{{164,201,238,24,61},{98,135,172,209,246},{32,69,106,143,180}},{{217,3,40,77,114},{151,188,225,11,48},{85,122,159,196,233}},{{19,56,93,130,167},{204,241,27,64,101},{138,175,212,249,35}},{{72,109,146,183,220},{6,43,80,117,154},{191,228,14,51,88}}},np.uint16)
  local r=np.sort(a,1)
  assert(r.dtype=="uint16","sort 146 dtype "..r.dtype)
  assert(eq(r.shape,{5,3,5}),"sort 146 shape")
  assert(eq(r.strides,{30,10,2}),"sort 146 strides")
  assert(close(r:tolist(),{{{19,3,40,24,8},{6,43,27,11,48},{32,16,14,51,35}},{{72,56,93,77,61},{45,82,80,64,101},{85,69,53,90,88}},{{111,109,146,130,114},{98,135,119,117,154},{138,122,106,143,127}},{{164,148,185,183,167},{151,188,172,156,193},{191,175,159,196,180}},{{217,201,238,222,220},{204,241,225,209,246},{230,228,212,249,233}}}),"sort 146 values")
  assert(close(a:tolist(),{{{111,148,185,222,8},{45,82,119,156,193},{230,16,53,90,127}},{{164,201,238,24,61},{98,135,172,209,246},{32,69,106,143,180}},{{217,3,40,77,114},{151,188,225,11,48},{85,122,159,196,233}},{{19,56,93,130,167},{204,241,27,64,101},{138,175,212,249,35}},{{72,109,146,183,220},{6,43,80,117,154},{191,228,14,51,88}}}),"sort 146 input mutation")
end
do -- sort 147
  local a=np.array({false,true,false,false},np.bool)
  local r=np.sort(a,1)
  assert(r.dtype=="bool","sort 147 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"sort 147 shape")
  assert(eq(r.strides,{1}),"sort 147 strides")
  assert(close(r:tolist(),{false,false,false,true}),"sort 147 values")
  assert(close(a:tolist(),{false,true,false,false}),"sort 147 input mutation")
end
do -- sort 148
  local a=np.array({2.75,7.001,11.252,-8.747,-4.496},np.float64)
  local r=np.sort(a,1)
  assert(r.dtype=="float64","sort 148 dtype "..r.dtype)
  assert(eq(r.shape,{5}),"sort 148 shape")
  assert(eq(r.strides,{8}),"sort 148 strides")
  assert(close(r:tolist(),{-8.747,-4.496,2.75,7.001,11.252}),"sort 148 values")
  assert(close(a:tolist(),{2.75,7.001,11.252,-8.747,-4.496}),"sort 148 input mutation")
end
do -- sort 149
  local a=np.array({{{19,56,93}},{{-121,-84,-47}},{{-10,27,64}},{{101,-113,-76}},{{-39,-2,35}}},np.int16)
  local r=np.sort(a,3)
  assert(r.dtype=="int16","sort 149 dtype "..r.dtype)
  assert(eq(r.shape,{5,1,3}),"sort 149 shape")
  assert(eq(r.strides,{6,6,2}),"sort 149 strides")
  assert(close(r:tolist(),{{{19,56,93}},{{-121,-84,-47}},{{-10,27,64}},{{-113,-76,101}},{{-39,-2,35}}}),"sort 149 values")
  assert(close(a:tolist(),{{{19,56,93}},{{-121,-84,-47}},{{-10,27,64}},{{101,-113,-76}},{{-39,-2,35}}}),"sort 149 input mutation")
end
do -- sort 150
  local a=np.array({{{155}},{{192}},{{229}},{{15}},{{52}}},np.uint16)
  local r=np.sort(a,1)
  assert(r.dtype=="uint16","sort 150 dtype "..r.dtype)
  assert(eq(r.shape,{5,1,1}),"sort 150 shape")
  assert(eq(r.strides,{2,2,2}),"sort 150 strides")
  assert(close(r:tolist(),{{{15}},{{52}},{{155}},{{192}},{{229}}}),"sort 150 values")
  assert(close(a:tolist(),{{{155}},{{192}},{{229}},{{15}},{{52}}}),"sort 150 input mutation")
end
do -- sort 151
  local a=np.array({{{166,203}}},np.uint16)
  local r=np.sort(a,2)
  assert(r.dtype=="uint16","sort 151 dtype "..r.dtype)
  assert(eq(r.shape,{1,1,2}),"sort 151 shape")
  assert(eq(r.strides,{4,4,2}),"sort 151 strides")
  assert(close(r:tolist(),{{{166,203}}}),"sort 151 values")
  assert(close(a:tolist(),{{{166,203}}}),"sort 151 input mutation")
end
do -- sort 152
  local a=np.array({52,89,-125,-88},np.int16)
  local r=np.sort(a,1)
  assert(r.dtype=="int16","sort 152 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"sort 152 shape")
  assert(eq(r.strides,{2}),"sort 152 strides")
  assert(close(r:tolist(),{-125,-88,52,89}),"sort 152 values")
  assert(close(a:tolist(),{52,89,-125,-88}),"sort 152 input mutation")
end
do -- sort 153
  local a=np.array({{{63}},{{100}},{{-114}},{{-77}},{{-40}}},np.int16)
  local r=np.sort(a,1)
  assert(r.dtype=="int16","sort 153 dtype "..r.dtype)
  assert(eq(r.shape,{5,1,1}),"sort 153 shape")
  assert(eq(r.strides,{2,2,2}),"sort 153 strides")
  assert(close(r:tolist(),{{{-114}},{{-77}},{{-40}},{{63}},{{100}}}),"sort 153 values")
  assert(close(a:tolist(),{{{63}},{{100}},{{-114}},{{-77}},{{-40}}}),"sort 153 input mutation")
end
do -- sort 154
  local a=np.array({{{74,111},{-103,-66},{-29,8},{45,82},{119,-95}}},np.int8)
  local r=np.sort(a,3)
  assert(r.dtype=="int8","sort 154 dtype "..r.dtype)
  assert(eq(r.shape,{1,5,2}),"sort 154 shape")
  assert(eq(r.strides,{10,2,1}),"sort 154 strides")
  assert(close(r:tolist(),{{{74,111},{-103,-66},{-29,8},{45,82},{-95,119}}}),"sort 154 values")
  assert(close(a:tolist(),{{{74,111},{-103,-66},{-29,8},{45,82},{119,-95}}}),"sort 154 input mutation")
end
do -- sort 155
  local a=(np.array({{85,122},{-92,-55},{-18,19},{56,93}},np.int32)).T
  local r=np.sort(a,1)
  assert(r.dtype=="int32","sort 155 dtype "..r.dtype)
  assert(eq(r.shape,{2,4}),"sort 155 shape")
  assert(eq(r.strides,{4,8}),"sort 155 strides")
  assert(close(r:tolist(),{{85,-92,-18,56},{122,-55,19,93}}),"sort 155 values")
  assert(close(a:tolist(),{{85,-92,-18,56},{122,-55,19,93}}),"sort 155 input mutation")
end
do -- sort 156
  local a=np.array({{{false},{false}},{{true},{false}},{{true},{false}}},np.bool)
  local r=np.sort(a,2)
  assert(r.dtype=="bool","sort 156 dtype "..r.dtype)
  assert(eq(r.shape,{3,2,1}),"sort 156 shape")
  assert(eq(r.strides,{2,1,1}),"sort 156 strides")
  assert(close(r:tolist(),{{{false},{false}},{{false},{true}},{{false},{true}}}),"sort 156 values")
  assert(close(a:tolist(),{{{false},{false}},{{true},{false}},{{true},{false}}}),"sort 156 input mutation")
end
do -- sort 157
  local a=np.array({{{9.5,-10.499,-6.248,-1.997,2.254},{6.505,10.756,-9.243,-4.992,-0.741},{3.51,7.761,12.012,-7.987,-3.736}}},np.float32)
  local r=np.sort(a,3)
  assert(r.dtype=="float32","sort 157 dtype "..r.dtype)
  assert(eq(r.shape,{1,3,5}),"sort 157 shape")
  assert(eq(r.strides,{60,20,4}),"sort 157 strides")
  assert(close(r:tolist(),{{{-10.49899959564209,-6.248000144958496,-1.996999979019165,2.253999948501587,9.5},{-9.243000030517578,-4.992000102996826,-0.7409999966621399,6.505000114440918,10.755999565124512},{-7.986999988555908,-3.7360000610351562,3.509999990463257,7.761000156402588,12.01200008392334}}}),"sort 157 values")
  assert(close(a:tolist(),{{{9.5,-10.49899959564209,-6.248000144958496,-1.996999979019165,2.253999948501587},{6.505000114440918,10.755999565124512,-9.243000030517578,-4.992000102996826,-0.7409999966621399},{3.509999990463257,7.761000156402588,12.01200008392334,-7.986999988555908,-3.7360000610351562}}}),"sort 157 input mutation")
end
do -- sort 158
  local a=np.array({{{118},{-96},{-59},{-22}},{{15},{52},{89},{-125}},{{-88},{-51},{-14},{23}},{{60},{97},{-117},{-80}},{{-43},{-6},{31},{68}}},np.int8)
  local r=np.sort(a,2)
  assert(r.dtype=="int8","sort 158 dtype "..r.dtype)
  assert(eq(r.shape,{5,4,1}),"sort 158 shape")
  assert(eq(r.strides,{4,1,1}),"sort 158 strides")
  assert(close(r:tolist(),{{{-96},{-59},{-22},{118}},{{-125},{15},{52},{89}},{{-88},{-51},{-14},{23}},{{-117},{-80},{60},{97}},{{-43},{-6},{31},{68}}}),"sort 158 values")
  assert(close(a:tolist(),{{{118},{-96},{-59},{-22}},{{15},{52},{89},{-125}},{{-88},{-51},{-14},{23}},{{60},{97},{-117},{-80}},{{-43},{-6},{31},{68}}}),"sort 158 input mutation")
end
do -- sort 159
  local a=np.array({{{-122,-85,-48,-11,26},{63,100,-114,-77,-40},{-3,34,71,108,-106}},{{-69,-32,5,42,79},{116,-98,-61,-24,13},{50,87,124,-90,-53}},{{-16,21,58,95,-119},{-82,-45,-8,29,66},{103,-111,-74,-37,0}}},np.int32)
  local r=np.sort(a,3)
  assert(r.dtype=="int32","sort 159 dtype "..r.dtype)
  assert(eq(r.shape,{3,3,5}),"sort 159 shape")
  assert(eq(r.strides,{60,20,4}),"sort 159 strides")
  assert(close(r:tolist(),{{{-122,-85,-48,-11,26},{-114,-77,-40,63,100},{-106,-3,34,71,108}},{{-69,-32,5,42,79},{-98,-61,-24,13,116},{-90,-53,50,87,124}},{{-119,-16,21,58,95},{-82,-45,-8,29,66},{-111,-74,-37,0,103}}}),"sort 159 values")
  assert(close(a:tolist(),{{{-122,-85,-48,-11,26},{63,100,-114,-77,-40},{-3,34,71,108,-106}},{{-69,-32,5,42,79},{116,-98,-61,-24,13},{50,87,124,-90,-53}},{{-16,21,58,95,-119},{-82,-45,-8,29,66},{103,-111,-74,-37,0}}}),"sort 159 input mutation")
end
do -- sort 160
  local a=(np.array({{11.75},{-8.249},{-3.998},{0.253}},np.float32)).T
  local r=np.sort(a,1)
  assert(r.dtype=="float32","sort 160 dtype "..r.dtype)
  assert(eq(r.shape,{1,4}),"sort 160 shape")
  assert(eq(r.strides,{16,4}),"sort 160 strides")
  assert(close(r:tolist(),{{11.75,-8.24899959564209,-3.997999906539917,0.2529999911785126}}),"sort 160 values")
  assert(close(a:tolist(),{{11.75,-8.24899959564209,-3.997999906539917,0.2529999911785126}}),"sort 160 input mutation")
end
do -- sort 161
  local a=np.array({{{-100,-63},{-26,11},{48,85}}},np.int16)
  local r=np.sort(a,1)
  assert(r.dtype=="int16","sort 161 dtype "..r.dtype)
  assert(eq(r.shape,{1,3,2}),"sort 161 shape")
  assert(eq(r.strides,{12,4,2}),"sort 161 strides")
  assert(close(r:tolist(),{{{-100,-63},{-26,11},{48,85}}}),"sort 161 values")
  assert(close(a:tolist(),{{{-100,-63},{-26,11},{48,85}}}),"sort 161 input mutation")
end
do -- sort 162
  local a=np.array({{{-89,-52,-15,22,59},{96,-118,-81,-44,-7},{30,67,104,-110,-73}},{{-36,1,38,75,112},{-102,-65,-28,9,46},{83,120,-94,-57,-20}}},np.int16)
  local r=np.sort(a,3)
  assert(r.dtype=="int16","sort 162 dtype "..r.dtype)
  assert(eq(r.shape,{2,3,5}),"sort 162 shape")
  assert(eq(r.strides,{30,10,2}),"sort 162 strides")
  assert(close(r:tolist(),{{{-89,-52,-15,22,59},{-118,-81,-44,-7,96},{-110,-73,30,67,104}},{{-36,1,38,75,112},{-102,-65,-28,9,46},{-94,-57,-20,83,120}}}),"sort 162 values")
  assert(close(a:tolist(),{{{-89,-52,-15,22,59},{96,-118,-81,-44,-7},{30,67,104,-110,-73}},{{-36,1,38,75,112},{-102,-65,-28,9,46},{83,120,-94,-57,-20}}}),"sort 162 input mutation")
end
do -- sort 163
  local a=np.array({-10.25,-5.999,-1.748,2.503},np.float64)
  local r=np.sort(a,1)
  assert(r.dtype=="float64","sort 163 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"sort 163 shape")
  assert(eq(r.strides,{8}),"sort 163 strides")
  assert(close(r:tolist(),{-10.25,-5.999,-1.748,2.503}),"sort 163 values")
  assert(close(a:tolist(),{-10.25,-5.999,-1.748,2.503}),"sort 163 input mutation")
end
do -- sort 164
  local a=np.array({{{-9.5,-5.249,-0.998},{3.253,7.504,11.755},{-8.244,-3.993,0.258},{4.509,8.76,-11.239}},{{-6.988,-2.737,1.514},{5.765,10.016,-9.983},{-5.732,-1.481,2.77},{7.021,11.272,-8.727}},{{-4.476,-0.225,4.026},{8.277,-11.722,-7.471},{-3.22,1.031,5.282},{9.533,-10.466,-6.215}}},np.float64)
  local r=np.sort(a,2)
  assert(r.dtype=="float64","sort 164 dtype "..r.dtype)
  assert(eq(r.shape,{3,4,3}),"sort 164 shape")
  assert(eq(r.strides,{96,24,8}),"sort 164 strides")
  assert(close(r:tolist(),{{{-9.5,-5.249,-11.239},{-8.244,-3.993,-0.998},{3.253,7.504,0.258},{4.509,8.76,11.755}},{{-6.988,-2.737,-9.983},{-5.732,-1.481,-8.727},{5.765,10.016,1.514},{7.021,11.272,2.77}},{{-4.476,-11.722,-7.471},{-3.22,-10.466,-6.215},{8.277,-0.225,4.026},{9.533,1.031,5.282}}}),"sort 164 values")
  assert(close(a:tolist(),{{{-9.5,-5.249,-0.998},{3.253,7.504,11.755},{-8.244,-3.993,0.258},{4.509,8.76,-11.239}},{{-6.988,-2.737,1.514},{5.765,10.016,-9.983},{-5.732,-1.481,2.77},{7.021,11.272,-8.727}},{{-4.476,-0.225,4.026},{8.277,-11.722,-7.471},{-3.22,1.031,5.282},{9.533,-10.466,-6.215}}}),"sort 164 input mutation")
end
do -- sort 165
  local a=np.array({{-56,-19,18,55,92},{-122,-85,-48,-11,26},{63,100,-114,-77,-40},{-3,34,71,108,-106}},np.int64)
  local r=np.sort(a,2)
  assert(r.dtype=="int64","sort 165 dtype "..r.dtype)
  assert(eq(r.shape,{4,5}),"sort 165 shape")
  assert(eq(r.strides,{40,8}),"sort 165 strides")
  assert(close(r:tolist(),{{-56,-19,18,55,92},{-122,-85,-48,-11,26},{-114,-77,-40,63,100},{-106,-3,34,71,108}}),"sort 165 values")
  assert(close(a:tolist(),{{-56,-19,18,55,92},{-122,-85,-48,-11,26},{63,100,-114,-77,-40},{-3,34,71,108,-106}}),"sort 165 input mutation")
end
do -- sort 166
  local a=np.array({-45,-8},np.int16)
  local r=np.sort(a,1)
  assert(r.dtype=="int16","sort 166 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"sort 166 shape")
  assert(eq(r.strides,{2}),"sort 166 strides")
  assert(close(r:tolist(),{-45,-8}),"sort 166 values")
  assert(close(a:tolist(),{-45,-8}),"sort 166 input mutation")
end
do -- sort 167
  local a=np.array({-7.25},np.float64)
  local r=np.sort(a,1)
  assert(r.dtype=="float64","sort 167 dtype "..r.dtype)
  assert(eq(r.shape,{1}),"sort 167 shape")
  assert(eq(r.strides,{8}),"sort 167 strides")
  assert(close(r:tolist(),{-7.25}),"sort 167 values")
  assert(close(a:tolist(),{-7.25}),"sort 167 input mutation")
end
do -- sort 168
  local a=np.array({{{-6.5,-2.249,2.002},{6.253,10.504,-9.495}},{{-5.244,-0.993,3.258},{7.509,11.76,-8.239}},{{-3.988,0.263,4.514},{8.765,-11.234,-6.983}},{{-2.732,1.519,5.77},{10.021,-9.978,-5.727}}},np.float64)
  local r=np.sort(a,3)
  assert(r.dtype=="float64","sort 168 dtype "..r.dtype)
  assert(eq(r.shape,{4,2,3}),"sort 168 shape")
  assert(eq(r.strides,{48,24,8}),"sort 168 strides")
  assert(close(r:tolist(),{{{-6.5,-2.249,2.002},{-9.495,6.253,10.504}},{{-5.244,-0.993,3.258},{-8.239,7.509,11.76}},{{-3.988,0.263,4.514},{-11.234,-6.983,8.765}},{{-2.732,1.519,5.77},{-9.978,-5.727,10.021}}}),"sort 168 values")
  assert(close(a:tolist(),{{{-6.5,-2.249,2.002},{6.253,10.504,-9.495}},{{-5.244,-0.993,3.258},{7.509,11.76,-8.239}},{{-3.988,0.263,4.514},{8.765,-11.234,-6.983}},{{-2.732,1.519,5.77},{10.021,-9.978,-5.727}}}),"sort 168 input mutation")
end
do -- sort 169
  local a=np.array({{{113},{150}},{{187},{224}},{{10},{47}},{{84},{121}}},np.uint8)
  local r=np.sort(a,1)
  assert(r.dtype=="uint8","sort 169 dtype "..r.dtype)
  assert(eq(r.shape,{4,2,1}),"sort 169 shape")
  assert(eq(r.strides,{2,1,1}),"sort 169 strides")
  assert(close(r:tolist(),{{{10},{47}},{{84},{121}},{{113},{150}},{{187},{224}}}),"sort 169 values")
  assert(close(a:tolist(),{{{113},{150}},{{187},{224}},{{10},{47}},{{84},{121}}}),"sort 169 input mutation")
end
do -- sort 170
  local a=np.array({-5.0,-0.749,3.502,7.753,12.004},np.float32)
  local r=np.sort(a,1)
  assert(r.dtype=="float32","sort 170 dtype "..r.dtype)
  assert(eq(r.shape,{5}),"sort 170 shape")
  assert(eq(r.strides,{4}),"sort 170 strides")
  assert(close(r:tolist(),{-5.0,-0.7490000128746033,3.502000093460083,7.752999782562256,12.003999710083008}),"sort 170 values")
  assert(close(a:tolist(),{-5.0,-0.7490000128746033,3.502000093460083,7.752999782562256,12.003999710083008}),"sort 170 input mutation")
end
do -- sort 171
  local a=np.array({135,172,209},np.uint8)
  local r=np.sort(a,1)
  assert(r.dtype=="uint8","sort 171 dtype "..r.dtype)
  assert(eq(r.shape,{3}),"sort 171 shape")
  assert(eq(r.strides,{1}),"sort 171 strides")
  assert(close(r:tolist(),{135,172,209}),"sort 171 values")
  assert(close(a:tolist(),{135,172,209}),"sort 171 input mutation")
end
do -- sort 172
  local a=np.array({146,183,220,6},np.uint8)
  local r=np.sort(a,1)
  assert(r.dtype=="uint8","sort 172 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"sort 172 shape")
  assert(eq(r.strides,{1}),"sort 172 strides")
  assert(close(r:tolist(),{6,146,183,220}),"sort 172 values")
  assert(close(a:tolist(),{146,183,220,6}),"sort 172 input mutation")
end
do -- sort 173
  local a=np.array({{32,69,106,-108,-71}},np.int8)
  local r=np.sort(a,2)
  assert(r.dtype=="int8","sort 173 dtype "..r.dtype)
  assert(eq(r.shape,{1,5}),"sort 173 shape")
  assert(eq(r.strides,{5,1}),"sort 173 strides")
  assert(close(r:tolist(),{{-108,-71,32,69,106}}),"sort 173 values")
  assert(close(a:tolist(),{{32,69,106,-108,-71}}),"sort 173 input mutation")
end
do -- sort 174
  local a=(np.array({{43,80,117}},np.int64)).T
  local r=np.sort(a,2)
  assert(r.dtype=="int64","sort 174 dtype "..r.dtype)
  assert(eq(r.shape,{3,1}),"sort 174 shape")
  assert(eq(r.strides,{8,8}),"sort 174 strides")
  assert(close(r:tolist(),{{43},{80},{117}}),"sort 174 values")
  assert(close(a:tolist(),{{43},{80},{117}}),"sort 174 input mutation")
end
do -- sort 175
  local a=np.array({{{-1.25,3.001,7.252,11.503,-8.496},{-4.245,0.006,4.257,8.508,-11.491},{-7.24,-2.989,1.262,5.513,9.764},{-10.235,-5.984,-1.733,2.518,6.769}},{{11.02,-8.979,-4.728,-0.477,3.774},{8.025,-11.974,-7.723,-3.472,0.779},{5.03,9.281,-10.718,-6.467,-2.216},{2.035,6.286,10.537,-9.462,-5.211}},{{-0.96,3.291,7.542,11.793,-8.206},{-3.955,0.296,4.547,8.798,-11.201},{-6.95,-2.699,1.552,5.803,10.054},{-9.945,-5.694,-1.443,2.808,7.059}},{{11.31,-8.689,-4.438,-0.187,4.064},{8.315,-11.684,-7.433,-3.182,1.069},{5.32,9.571,-10.428,-6.177,-1.926},{2.325,6.576,10.827,-9.172,-4.921}}},np.float64)
  local r=np.sort(a,3)
  assert(r.dtype=="float64","sort 175 dtype "..r.dtype)
  assert(eq(r.shape,{4,4,5}),"sort 175 shape")
  assert(eq(r.strides,{160,40,8}),"sort 175 strides")
  assert(close(r:tolist(),{{{-8.496,-1.25,3.001,7.252,11.503},{-11.491,-4.245,0.006,4.257,8.508},{-7.24,-2.989,1.262,5.513,9.764},{-10.235,-5.984,-1.733,2.518,6.769}},{{-8.979,-4.728,-0.477,3.774,11.02},{-11.974,-7.723,-3.472,0.779,8.025},{-10.718,-6.467,-2.216,5.03,9.281},{-9.462,-5.211,2.035,6.286,10.537}},{{-8.206,-0.96,3.291,7.542,11.793},{-11.201,-3.955,0.296,4.547,8.798},{-6.95,-2.699,1.552,5.803,10.054},{-9.945,-5.694,-1.443,2.808,7.059}},{{-8.689,-4.438,-0.187,4.064,11.31},{-11.684,-7.433,-3.182,1.069,8.315},{-10.428,-6.177,-1.926,5.32,9.571},{-9.172,-4.921,2.325,6.576,10.827}}}),"sort 175 values")
  assert(close(a:tolist(),{{{-1.25,3.001,7.252,11.503,-8.496},{-4.245,0.006,4.257,8.508,-11.491},{-7.24,-2.989,1.262,5.513,9.764},{-10.235,-5.984,-1.733,2.518,6.769}},{{11.02,-8.979,-4.728,-0.477,3.774},{8.025,-11.974,-7.723,-3.472,0.779},{5.03,9.281,-10.718,-6.467,-2.216},{2.035,6.286,10.537,-9.462,-5.211}},{{-0.96,3.291,7.542,11.793,-8.206},{-3.955,0.296,4.547,8.798,-11.201},{-6.95,-2.699,1.552,5.803,10.054},{-9.945,-5.694,-1.443,2.808,7.059}},{{11.31,-8.689,-4.438,-0.187,4.064},{8.315,-11.684,-7.433,-3.182,1.069},{5.32,9.571,-10.428,-6.177,-1.926},{2.325,6.576,10.827,-9.172,-4.921}}}),"sort 175 input mutation")
end
do -- sort 176
  local a=np.array({false},np.bool)
  local r=np.sort(a,1)
  assert(r.dtype=="bool","sort 176 dtype "..r.dtype)
  assert(eq(r.shape,{1}),"sort 176 shape")
  assert(eq(r.strides,{1}),"sort 176 strides")
  assert(close(r:tolist(),{false}),"sort 176 values")
  assert(close(a:tolist(),{false}),"sort 176 input mutation")
end
do -- sort 177
  local a=(np.array({{76,113,-101,-64},{-27,10,47,84},{121,-93,-56,-19}},np.int8)).T
  local r=np.sort(a,2)
  assert(r.dtype=="int8","sort 177 dtype "..r.dtype)
  assert(eq(r.shape,{4,3}),"sort 177 shape")
  assert(eq(r.strides,{1,4}),"sort 177 strides")
  assert(close(r:tolist(),{{-27,76,121},{-93,10,113},{-101,-56,47},{-64,-19,84}}),"sort 177 values")
  assert(close(a:tolist(),{{76,-27,121},{113,10,-93},{-101,47,-56},{-64,84,-19}}),"sort 177 input mutation")
end
do -- sort 178
  local a=np.array({{false,true,false,true,false},{false,true,false,true,false},{false,true,false,true,false},{false,true,false,true,false}},np.bool)
  local r=np.sort(a,1)
  assert(r.dtype=="bool","sort 178 dtype "..r.dtype)
  assert(eq(r.shape,{4,5}),"sort 178 shape")
  assert(eq(r.strides,{5,1}),"sort 178 strides")
  assert(close(r:tolist(),{{false,true,false,true,false},{false,true,false,true,false},{false,true,false,true,false},{false,true,false,true,false}}),"sort 178 values")
  assert(close(a:tolist(),{{false,true,false,true,false},{false,true,false,true,false},{false,true,false,true,false},{false,true,false,true,false}}),"sort 178 input mutation")
end
do -- sort 179
  local a=np.array({1.75,6.001,10.252,-9.747,-5.496},np.float64)
  local r=np.sort(a,1)
  assert(r.dtype=="float64","sort 179 dtype "..r.dtype)
  assert(eq(r.shape,{5}),"sort 179 shape")
  assert(eq(r.strides,{8}),"sort 179 strides")
  assert(close(r:tolist(),{-9.747,-5.496,1.75,6.001,10.252}),"sort 179 values")
  assert(close(a:tolist(),{1.75,6.001,10.252,-9.747,-5.496}),"sort 179 input mutation")
end
do -- argsort 0
  local a=np.array({8.75},np.float64)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 0 dtype "..r.dtype)
  assert(eq(r.shape,{1}),"argsort 0 shape")
  assert(eq(r.strides,{8}),"argsort 0 strides")
  assert(eq(r:tolist(),{1}),"argsort 0 indices")
end
do -- argsort 1
  local a=np.array({{49},{86},{123}},np.int64)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 1 dtype "..r.dtype)
  assert(eq(r.shape,{3,1}),"argsort 1 shape")
  assert(eq(r.strides,{8,8}),"argsort 1 strides")
  assert(eq(r:tolist(),{{1},{2},{3}}),"argsort 1 indices")
end
do -- argsort 2
  local a=np.array({60,97,-117,-80,-43},np.int8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 2 dtype "..r.dtype)
  assert(eq(r.shape,{5}),"argsort 2 shape")
  assert(eq(r.strides,{8}),"argsort 2 strides")
  assert(eq(r:tolist(),{3,4,5,1,2}),"argsort 2 indices")
end
do -- argsort 3
  local a=(np.array({{11.0,-8.999,-4.748,-0.497,3.754}},np.float32)).T
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 3 dtype "..r.dtype)
  assert(eq(r.shape,{5,1}),"argsort 3 shape")
  assert(eq(r.strides,{8,8}),"argsort 3 strides")
  assert(eq(r:tolist(),{{2},{3},{4},{5},{1}}),"argsort 3 indices")
end
do -- argsort 4
  local a=np.array({{11.75}},np.float32)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 4 dtype "..r.dtype)
  assert(eq(r.shape,{1,1}),"argsort 4 shape")
  assert(eq(r.strides,{8,8}),"argsort 4 strides")
  assert(eq(r:tolist(),{{1}}),"argsort 4 indices")
end
do -- argsort 5
  local a=np.array({{{218},{4}}},np.uint32)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 5 dtype "..r.dtype)
  assert(eq(r.shape,{1,2,1}),"argsort 5 shape")
  assert(eq(r.strides,{16,8,8}),"argsort 5 strides")
  assert(eq(r:tolist(),{{{2},{1}}}),"argsort 5 indices")
end
do -- argsort 6
  local a=np.array({{{-11.0,-6.749,-2.498,1.753,6.004},{10.255,-9.744,-5.493,-1.242,3.009},{7.26,11.511,-8.488,-4.237,0.014}}},np.float64)
  local r=np.argsort(a,3)
  assert(r.dtype=="int64","argsort 6 dtype "..r.dtype)
  assert(eq(r.shape,{1,3,5}),"argsort 6 shape")
  assert(eq(r.strides,{120,40,8}),"argsort 6 strides")
  assert(eq(r:tolist(),{{{1,2,3,4,5},{2,3,4,5,1},{3,4,5,1,2}}}),"argsort 6 indices")
end
do -- argsort 7
  local a=np.array({{{115}}},np.int32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 7 dtype "..r.dtype)
  assert(eq(r.shape,{1,1,1}),"argsort 7 shape")
  assert(eq(r.strides,{8,8,8}),"argsort 7 strides")
  assert(eq(r:tolist(),{{{1}}}),"argsort 7 indices")
end
do -- argsort 8
  local a=np.array({{-125,-88,-51,-14},{23,60,97,-117},{-80,-43,-6,31}},np.int16)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 8 dtype "..r.dtype)
  assert(eq(r.shape,{3,4}),"argsort 8 shape")
  assert(eq(r.strides,{32,8}),"argsort 8 strides")
  assert(eq(r:tolist(),{{1,2,3,4},{4,1,2,3},{1,2,3,4}}),"argsort 8 indices")
end
do -- argsort 9
  local a=np.array({{-114,-77},{-40,-3},{34,71},{108,-106}},np.int8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 9 dtype "..r.dtype)
  assert(eq(r.shape,{4,2}),"argsort 9 shape")
  assert(eq(r.strides,{16,8}),"argsort 9 strides")
  assert(eq(r:tolist(),{{1,4},{2,1},{3,2},{4,3}}),"argsort 9 indices")
end
do -- argsort 10
  local a=np.array({22},np.uint32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 10 dtype "..r.dtype)
  assert(eq(r.shape,{1}),"argsort 10 shape")
  assert(eq(r.strides,{8}),"argsort 10 strides")
  assert(eq(r:tolist(),{1}),"argsort 10 indices")
end
do -- argsort 11
  local a=np.array({{{-92,-55,-18},{19,56,93},{-121,-84,-47},{-10,27,64},{101,-113,-76}},{{-39,-2,35},{72,109,-105},{-68,-31,6},{43,80,117},{-97,-60,-23}},{{14,51,88},{125,-89,-52},{-15,22,59},{96,-118,-81},{-44,-7,30}}},np.int16)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 11 dtype "..r.dtype)
  assert(eq(r.shape,{3,5,3}),"argsort 11 shape")
  assert(eq(r.strides,{120,24,8}),"argsort 11 strides")
  assert(eq(r:tolist(),{{{3,5,5},{1,3,3},{4,1,1},{2,4,4},{5,2,2}},{{5,5,2},{3,3,5},{1,1,3},{4,4,1},{2,2,4}},{{5,4,4},{3,2,2},{1,5,5},{4,3,3},{2,1,1}}}),"argsort 11 indices")
end
do -- argsort 12
  local a=(np.array({{-81},{-44},{-7}},np.int64)).T
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 12 dtype "..r.dtype)
  assert(eq(r.shape,{1,3}),"argsort 12 shape")
  assert(eq(r.strides,{24,8}),"argsort 12 strides")
  assert(eq(r:tolist(),{{1,2,3}}),"argsort 12 indices")
end
do -- argsort 13
  local a=np.array({{{55,92,129,166}},{{203,240,26,63}},{{100,137,174,211}},{{248,34,71,108}},{{145,182,219,5}}},np.uint32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 13 dtype "..r.dtype)
  assert(eq(r.shape,{5,1,4}),"argsort 13 shape")
  assert(eq(r.strides,{32,32,8}),"argsort 13 strides")
  assert(eq(r:tolist(),{{{1,4,2,5}},{{3,1,4,2}},{{5,3,1,4}},{{2,5,3,1}},{{4,2,5,3}}}),"argsort 13 indices")
end
do -- argsort 14
  local a=np.array({-59,-22,15},np.int8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 14 dtype "..r.dtype)
  assert(eq(r.shape,{3}),"argsort 14 shape")
  assert(eq(r.strides,{8}),"argsort 14 strides")
  assert(eq(r:tolist(),{1,2,3}),"argsort 14 indices")
end
do -- argsort 15
  local a=np.array({-4.25},np.float32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 15 dtype "..r.dtype)
  assert(eq(r.shape,{1}),"argsort 15 shape")
  assert(eq(r.strides,{8}),"argsort 15 strides")
  assert(eq(r:tolist(),{1}),"argsort 15 indices")
end
do -- argsort 16
  local a=np.array({true,false,true,false,false},np.bool)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 16 dtype "..r.dtype)
  assert(eq(r.shape,{5}),"argsort 16 shape")
  assert(eq(r.strides,{8}),"argsort 16 strides")
end
do -- argsort 17
  local a=np.array({{{-2.75,1.501,5.752,10.003},{-9.996,-5.745,-1.494,2.757},{7.008,11.259,-8.74,-4.489},{-0.238,4.013,8.264,-11.735},{-7.484,-3.233,1.018,5.269}},{{9.52,-10.479,-6.228,-1.977},{2.274,6.525,10.776,-9.223},{-4.972,-0.721,3.53,7.781},{12.032,-7.967,-3.716,0.535},{4.786,9.037,-10.962,-6.711}},{{-2.46,1.791,6.042,10.293},{-9.706,-5.455,-1.204,3.047},{7.298,11.549,-8.45,-4.199},{0.052000000000000005,4.303,8.554,-11.445},{-7.194,-2.943,1.308,5.559}},{{9.81,-10.189,-5.938,-1.687},{2.564,6.815,11.066,-8.933},{-4.682,-0.431,3.82,8.071},{-11.928,-7.677,-3.426,0.825},{5.076,9.327,-10.672,-6.421}},{{-2.17,2.081,6.332,10.583},{-9.416,-5.165,-0.914,3.337},{7.588,11.839,-8.16,-3.909},{0.34199999999999997,4.593,8.844,-11.155},{-6.904,-2.653,1.598,5.849}}},np.float32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 17 dtype "..r.dtype)
  assert(eq(r.shape,{5,5,4}),"argsort 17 shape")
  assert(eq(r.strides,{160,32,8}),"argsort 17 strides")
  assert(eq(r:tolist(),{{{1,2,2,2},{1,1,1,2},{2,2,1,1},{4,2,2,1},{1,1,2,2}},{{3,4,4,4},{3,3,3,4},{4,4,3,3},{1,4,4,3},{3,3,4,4}},{{5,1,1,1},{5,5,5,1},{1,1,5,5},{3,1,1,5},{5,5,1,1}},{{2,3,3,3},{2,2,2,3},{3,3,2,2},{5,3,3,2},{2,2,3,3}},{{4,5,5,5},{4,4,4,5},{5,5,4,4},{2,5,5,4},{4,4,5,5}}}),"argsort 17 indices")
end
do -- argsort 18
  local a=np.array({{{-15,22,59},{96,-118,-81},{-44,-7,30}},{{67,104,-110},{-73,-36,1},{38,75,112}},{{-102,-65,-28},{9,46,83},{120,-94,-57}}},np.int16)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 18 dtype "..r.dtype)
  assert(eq(r.shape,{3,3,3}),"argsort 18 shape")
  assert(eq(r.strides,{72,24,8}),"argsort 18 strides")
  assert(eq(r:tolist(),{{{3,2,2},{1,3,3},{2,1,1}},{{2,2,1},{3,3,2},{1,1,3}},{{1,3,3},{2,1,1},{3,2,2}}}),"argsort 18 indices")
end
do -- argsort 19
  local a=(np.array({{121,158,195}},np.uint8)).T
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 19 dtype "..r.dtype)
  assert(eq(r.shape,{3,1}),"argsort 19 shape")
  assert(eq(r.strides,{8,8}),"argsort 19 strides")
  assert(eq(r:tolist(),{{1},{2},{3}}),"argsort 19 indices")
end
do -- argsort 20
  local a=np.array({{-0.5,3.751}},np.float64)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 20 dtype "..r.dtype)
  assert(eq(r.shape,{1,2}),"argsort 20 shape")
  assert(eq(r.strides,{16,8}),"argsort 20 strides")
  assert(eq(r:tolist(),{{1,2}}),"argsort 20 indices")
end
do -- argsort 21
  local a=np.array({{0.25,4.501,8.752,-11.247,-6.996},{-2.745,1.506,5.757,10.008,-9.991},{-5.74,-1.489,2.762,7.013,11.264},{-8.735,-4.484,-0.23299999999999998,4.018,8.269}},np.float32)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 21 dtype "..r.dtype)
  assert(eq(r.shape,{4,5}),"argsort 21 shape")
  assert(eq(r.strides,{40,8}),"argsort 21 strides")
  assert(eq(r:tolist(),{{4,5,1,2,3},{5,1,2,3,4},{1,2,3,4,5},{1,2,3,4,5}}),"argsort 21 indices")
end
do -- argsort 22
  local a=np.array({{{1.0,5.251,9.502}},{{-10.497,-6.246,-1.995}}},np.float64)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 22 dtype "..r.dtype)
  assert(eq(r.shape,{2,1,3}),"argsort 22 shape")
  assert(eq(r.strides,{24,24,8}),"argsort 22 strides")
  assert(eq(r:tolist(),{{{1,1,1}},{{1,1,1}}}),"argsort 22 indices")
end
do -- argsort 23
  local a=np.array({{{165,202,239},{25,62,99}},{{136,173,210},{247,33,70}},{{107,144,181},{218,4,41}},{{78,115,152},{189,226,12}},{{49,86,123},{160,197,234}}},np.uint8)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 23 dtype "..r.dtype)
  assert(eq(r.shape,{5,2,3}),"argsort 23 shape")
  assert(eq(r.strides,{48,24,8}),"argsort 23 strides")
  assert(eq(r:tolist(),{{{2,2,2},{1,1,1}},{{1,2,2},{2,1,1}},{{1,2,2},{2,1,1}},{{1,1,2},{2,2,1}},{{1,1,1},{2,2,2}}}),"argsort 23 indices")
end
do -- argsort 24
  local a=np.array({2.5},np.float64)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 24 dtype "..r.dtype)
  assert(eq(r.shape,{1}),"argsort 24 shape")
  assert(eq(r.strides,{8}),"argsort 24 strides")
  assert(eq(r:tolist(),{1}),"argsort 24 indices")
end
do -- argsort 25
  local a=np.array({{62,99},{-115,-78},{-41,-4}},np.int8)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 25 dtype "..r.dtype)
  assert(eq(r.shape,{3,2}),"argsort 25 shape")
  assert(eq(r.strides,{16,8}),"argsort 25 strides")
  assert(eq(r:tolist(),{{1,2},{1,2},{1,2}}),"argsort 25 indices")
end
do -- argsort 26
  local a=np.array({{{true,false,true,false,false}},{{true,false,true,false,false}}},np.bool)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 26 dtype "..r.dtype)
  assert(eq(r.shape,{2,1,5}),"argsort 26 shape")
  assert(eq(r.strides,{40,40,8}),"argsort 26 strides")
end
do -- argsort 27
  local a=np.array({209,246},np.uint32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 27 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"argsort 27 shape")
  assert(eq(r.strides,{8}),"argsort 27 strides")
  assert(eq(r:tolist(),{1,2}),"argsort 27 indices")
end
do -- argsort 28
  local a=np.array({{false},{true},{false}},np.bool)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 28 dtype "..r.dtype)
  assert(eq(r.shape,{3,1}),"argsort 28 shape")
  assert(eq(r.strides,{8,8}),"argsort 28 strides")
end
do -- argsort 29
  local a=np.array({{{106,-108},{-71,-34},{3,40},{77,114}},{{-100,-63},{-26,11},{48,85},{122,-92}},{{-55,-18},{19,56},{93,-121},{-84,-47}}},np.int32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 29 dtype "..r.dtype)
  assert(eq(r.shape,{3,4,2}),"argsort 29 shape")
  assert(eq(r.strides,{64,16,8}),"argsort 29 strides")
  assert(eq(r:tolist(),{{{2,1},{1,1},{1,3},{3,2}},{{3,2},{2,2},{2,1},{1,3}},{{1,3},{3,3},{3,2},{2,1}}}),"argsort 29 indices")
end
do -- argsort 30
  local a=np.array({{{117,-97,-60,-23,14},{51,88,125,-89,-52},{-15,22,59,96,-118}},{{-81,-44,-7,30,67},{104,-110,-73,-36,1},{38,75,112,-102,-65}}},np.int64)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 30 dtype "..r.dtype)
  assert(eq(r.shape,{2,3,5}),"argsort 30 shape")
  assert(eq(r.strides,{120,40,8}),"argsort 30 strides")
  assert(eq(r:tolist(),{{{3,1,1,2,3},{2,3,3,1,2},{1,2,2,3,1}},{{1,2,2,3,3},{3,1,1,2,2},{2,3,3,1,1}}}),"argsort 30 indices")
end
do -- argsort 31
  local a=np.array({true},np.bool)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 31 dtype "..r.dtype)
  assert(eq(r.shape,{1}),"argsort 31 shape")
  assert(eq(r.strides,{8}),"argsort 31 strides")
end
do -- argsort 32
  local a=np.array({{{13,50,87,124,161}},{{198,235,21,58,95}}},np.uint16)
  local r=np.argsort(a,3)
  assert(r.dtype=="int64","argsort 32 dtype "..r.dtype)
  assert(eq(r.shape,{2,1,5}),"argsort 32 shape")
  assert(eq(r.strides,{40,40,8}),"argsort 32 strides")
  assert(eq(r:tolist(),{{{1,2,3,4,5}},{{3,4,5,1,2}}}),"argsort 32 indices")
end
do -- argsort 33
  local a=np.array({-101,-64,-27,10,47},np.int64)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 33 dtype "..r.dtype)
  assert(eq(r.shape,{5}),"argsort 33 shape")
  assert(eq(r.strides,{8}),"argsort 33 strides")
  assert(eq(r:tolist(),{1,2,3,4,5}),"argsort 33 indices")
end
do -- argsort 34
  local a=np.array({{{-90,-53,-16,21},{58,95,-119,-82},{-45,-8,29,66}},{{103,-111,-74,-37},{0,37,74,111},{-103,-66,-29,8}},{{45,82,119,-95},{-58,-21,16,53},{90,-124,-87,-50}}},np.int64)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 34 dtype "..r.dtype)
  assert(eq(r.shape,{3,3,4}),"argsort 34 shape")
  assert(eq(r.strides,{96,32,8}),"argsort 34 strides")
  assert(eq(r:tolist(),{{{1,1,2,2},{3,3,1,1},{2,2,3,3}},{{3,1,1,1},{2,3,3,3},{1,2,2,2}},{{2,3,3,1},{1,2,2,3},{3,1,1,2}}}),"argsort 34 indices")
end
do -- argsort 35
  local a=np.array({{true,false,false,true,false}},np.bool)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 35 dtype "..r.dtype)
  assert(eq(r.shape,{1,5}),"argsort 35 shape")
  assert(eq(r.strides,{40,8}),"argsort 35 strides")
end
do -- argsort 36
  local a=np.array({57,94},np.uint32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 36 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"argsort 36 shape")
  assert(eq(r.strides,{8}),"argsort 36 strides")
  assert(eq(r:tolist(),{1,2}),"argsort 36 indices")
end
do -- argsort 37
  local a=np.array({-12.0,-7.749},np.float64)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 37 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"argsort 37 shape")
  assert(eq(r.strides,{8}),"argsort 37 strides")
  assert(eq(r:tolist(),{1,2}),"argsort 37 indices")
end
do -- argsort 38
  local a=np.array({-46,-9,28,65,102},np.int32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 38 dtype "..r.dtype)
  assert(eq(r.shape,{5}),"argsort 38 shape")
  assert(eq(r.strides,{8}),"argsort 38 strides")
  assert(eq(r:tolist(),{1,2,3,4,5}),"argsort 38 indices")
end
do -- argsort 39
  local a=np.array({-35,2,39,76},np.int8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 39 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"argsort 39 shape")
  assert(eq(r.strides,{8}),"argsort 39 strides")
  assert(eq(r:tolist(),{1,2,3,4}),"argsort 39 indices")
end
do -- argsort 40
  local a=np.array({{{101,138,175,212},{249,35,72,109},{146,183,220,6}},{{43,80,117,154},{191,228,14,51},{88,125,162,199}}},np.uint32)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 40 dtype "..r.dtype)
  assert(eq(r.shape,{2,3,4}),"argsort 40 shape")
  assert(eq(r.strides,{96,32,8}),"argsort 40 strides")
  assert(eq(r:tolist(),{{{1,2,2,3},{3,1,1,2},{2,3,3,1}},{{1,1,2,2},{3,3,1,1},{2,2,3,3}}}),"argsort 40 indices")
end
do -- argsort 41
  local a=np.array({112},np.uint8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 41 dtype "..r.dtype)
  assert(eq(r.shape,{1}),"argsort 41 shape")
  assert(eq(r.strides,{8}),"argsort 41 strides")
  assert(eq(r:tolist(),{1}),"argsort 41 indices")
end
do -- argsort 42
  local a=np.array({123,160,197,234,20},np.uint16)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 42 dtype "..r.dtype)
  assert(eq(r.shape,{5}),"argsort 42 shape")
  assert(eq(r.strides,{8}),"argsort 42 strides")
  assert(eq(r:tolist(),{5,1,2,3,4}),"argsort 42 indices")
end
do -- argsort 43
  local a=np.array({{9,46,83,120}},np.int32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 43 dtype "..r.dtype)
  assert(eq(r.shape,{1,4}),"argsort 43 shape")
  assert(eq(r.strides,{32,8}),"argsort 43 strides")
  assert(eq(r:tolist(),{{1,1,1,1}}),"argsort 43 indices")
end
do -- argsort 44
  local a=np.array({{{-6.75},{-2.499}},{{1.752},{6.003}},{{10.254},{-9.745}},{{-5.494},{-1.243}},{{3.008},{7.259}}},np.float64)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 44 dtype "..r.dtype)
  assert(eq(r.shape,{5,2,1}),"argsort 44 shape")
  assert(eq(r.strides,{16,8,8}),"argsort 44 strides")
  assert(eq(r:tolist(),{{{1},{3}},{{4},{1}},{{2},{4}},{{5},{2}},{{3},{5}}}),"argsort 44 indices")
end
do -- argsort 45
  local a=np.array({{{31,68,105},{-109,-72,-35},{2,39,76}},{{113,-101,-64},{-27,10,47},{84,121,-93}},{{-56,-19,18},{55,92,-122},{-85,-48,-11}},{{26,63,100},{-114,-77,-40},{-3,34,71}}},np.int32)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 45 dtype "..r.dtype)
  assert(eq(r.shape,{4,3,3}),"argsort 45 shape")
  assert(eq(r.strides,{72,24,8}),"argsort 45 strides")
  assert(eq(r:tolist(),{{{2,2,2},{3,3,3},{1,1,1}},{{2,1,3},{3,2,1},{1,3,2}},{{3,3,2},{1,1,3},{2,2,1}},{{2,2,2},{3,3,3},{1,1,1}}}),"argsort 45 indices")
end
do -- argsort 46
  local a=np.array({{{42},{79},{116},{-98}},{{-61},{-24},{13},{50}},{{87},{124},{-90},{-53}},{{-16},{21},{58},{95}},{{-119},{-82},{-45},{-8}}},np.int8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 46 dtype "..r.dtype)
  assert(eq(r.shape,{5,4,1}),"argsort 46 shape")
  assert(eq(r.strides,{32,8,8}),"argsort 46 strides")
  assert(eq(r:tolist(),{{{5},{5},{3},{1}},{{2},{2},{5},{3}},{{4},{4},{2},{5}},{{1},{1},{4},{2}},{{3},{3},{1},{4}}}),"argsort 46 indices")
end
do -- argsort 47
  local a=np.array({178,215},np.uint8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 47 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"argsort 47 shape")
  assert(eq(r.strides,{8}),"argsort 47 strides")
  assert(eq(r:tolist(),{1,2}),"argsort 47 indices")
end
do -- argsort 48
  local a=np.array({{{-3.75,0.501}},{{4.752,9.003}},{{-10.996,-6.745}},{{-2.494,1.757}},{{6.008,10.259}}},np.float32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 48 dtype "..r.dtype)
  assert(eq(r.shape,{5,1,2}),"argsort 48 shape")
  assert(eq(r.strides,{16,16,8}),"argsort 48 strides")
  assert(eq(r:tolist(),{{{3,3}},{{1,1}},{{4,4}},{{2,2}},{{5,5}}}),"argsort 48 indices")
end
do -- argsort 49
  local a=np.array({-3.0,1.251,5.502,9.753},np.float64)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 49 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"argsort 49 shape")
  assert(eq(r.strides,{8}),"argsort 49 strides")
  assert(eq(r:tolist(),{1,2,3,4}),"argsort 49 indices")
end
do -- argsort 50
  local a=np.array({{{true},{false},{false},{true},{false}}},np.bool)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 50 dtype "..r.dtype)
  assert(eq(r.shape,{1,5,1}),"argsort 50 shape")
  assert(eq(r.strides,{40,8,8}),"argsort 50 strides")
end
do -- argsort 51
  local a=np.array({{97,-117,-80,-43,-6},{31,68,105,-109,-72}},np.int8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 51 dtype "..r.dtype)
  assert(eq(r.shape,{2,5}),"argsort 51 shape")
  assert(eq(r.strides,{40,8}),"argsort 51 strides")
  assert(eq(r:tolist(),{{2,1,1,2,2},{1,2,2,1,1}}),"argsort 51 indices")
end
do -- argsort 52
  local a=np.array({{233,19}},np.uint16)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 52 dtype "..r.dtype)
  assert(eq(r.shape,{1,2}),"argsort 52 shape")
  assert(eq(r.strides,{16,8}),"argsort 52 strides")
  assert(eq(r:tolist(),{{1,1}}),"argsort 52 indices")
end
do -- argsort 53
  local a=np.array({{{0.0,4.251,8.502,-11.497,-7.246}},{{-2.995,1.256,5.507,9.758,-10.241}},{{-5.99,-1.739,2.512,6.763,11.014}}},np.float64)
  local r=np.argsort(a,3)
  assert(r.dtype=="int64","argsort 53 dtype "..r.dtype)
  assert(eq(r.shape,{3,1,5}),"argsort 53 shape")
  assert(eq(r.strides,{40,40,8}),"argsort 53 strides")
  assert(eq(r:tolist(),{{{4,5,1,2,3}},{{5,1,2,3,4}},{{1,2,3,4,5}}}),"argsort 53 indices")
end
do -- argsort 54
  local a=np.array({{{-121,-84,-47,-10,27},{64,101,-113,-76,-39},{-2,35,72,109,-105}}},np.int64)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 54 dtype "..r.dtype)
  assert(eq(r.shape,{1,3,5}),"argsort 54 shape")
  assert(eq(r.strides,{120,40,8}),"argsort 54 strides")
  assert(eq(r:tolist(),{{{1,1,1,1,1},{1,1,1,1,1},{1,1,1,1,1}}}),"argsort 54 indices")
end
do -- argsort 55
  local a=(np.array({{15,52}},np.uint16)).T
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 55 dtype "..r.dtype)
  assert(eq(r.shape,{2,1}),"argsort 55 shape")
  assert(eq(r.strides,{8,8}),"argsort 55 strides")
  assert(eq(r:tolist(),{{1},{2}}),"argsort 55 indices")
end
do -- argsort 56
  local a=np.array({{{-99,-62},{-25,12},{49,86},{123,-91}}},np.int64)
  local r=np.argsort(a,3)
  assert(r.dtype=="int64","argsort 56 dtype "..r.dtype)
  assert(eq(r.shape,{1,4,2}),"argsort 56 shape")
  assert(eq(r.strides,{64,16,8}),"argsort 56 strides")
  assert(eq(r:tolist(),{{{1,2},{1,2},{1,2},{2,1}}}),"argsort 56 indices")
end
do -- argsort 57
  local a=np.array({3.0,7.251,11.502},np.float32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 57 dtype "..r.dtype)
  assert(eq(r.shape,{3}),"argsort 57 shape")
  assert(eq(r.strides,{8}),"argsort 57 strides")
  assert(eq(r:tolist(),{1,2,3}),"argsort 57 indices")
end
do -- argsort 58
  local a=np.array({{-77},{-40}},np.int32)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 58 dtype "..r.dtype)
  assert(eq(r.shape,{2,1}),"argsort 58 shape")
  assert(eq(r.strides,{8,8}),"argsort 58 strides")
  assert(eq(r:tolist(),{{1},{1}}),"argsort 58 indices")
end
do -- argsort 59
  local a=np.array({4.5,8.751,-11.248,-6.997},np.float64)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 59 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"argsort 59 shape")
  assert(eq(r.strides,{8}),"argsort 59 strides")
  assert(eq(r:tolist(),{3,4,1,2}),"argsort 59 indices")
end
do -- argsort 60
  local a=np.array({{5.25,9.501,-10.498,-6.247,-1.996},{2.255,6.506,10.757,-9.242,-4.991},{-0.74,3.511,7.762,12.013,-7.986},{-3.735,0.516,4.767,9.018,-10.981},{-6.73,-2.479,1.772,6.023,10.274}},np.float64)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 60 dtype "..r.dtype)
  assert(eq(r.shape,{5,5}),"argsort 60 shape")
  assert(eq(r.strides,{40,8}),"argsort 60 strides")
  assert(eq(r:tolist(),{{5,5,1,2,4},{4,4,5,1,3},{3,3,4,5,2},{2,2,3,4,1},{1,1,2,3,5}}),"argsort 60 indices")
end
do -- argsort 61
  local a=np.array({{{81},{118},{155}},{{192},{229},{15}},{{52},{89},{126}}},np.uint8)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 61 dtype "..r.dtype)
  assert(eq(r.shape,{3,3,1}),"argsort 61 shape")
  assert(eq(r.strides,{24,8,8}),"argsort 61 strides")
  assert(eq(r:tolist(),{{{1},{2},{3}},{{3},{1},{2}},{{1},{2},{3}}}),"argsort 61 indices")
end
do -- argsort 62
  local a=np.array({{{-33}},{{4}}},np.int64)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 62 dtype "..r.dtype)
  assert(eq(r.shape,{2,1,1}),"argsort 62 shape")
  assert(eq(r.strides,{8,8,8}),"argsort 62 strides")
  assert(eq(r:tolist(),{{{1}},{{2}}}),"argsort 62 indices")
end
do -- argsort 63
  local a=np.array({{{7.5,11.751,-8.248,-3.997,0.254}}},np.float64)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 63 dtype "..r.dtype)
  assert(eq(r.shape,{1,1,5}),"argsort 63 shape")
  assert(eq(r.strides,{40,40,8}),"argsort 63 strides")
  assert(eq(r:tolist(),{{{1,1,1,1,1}}}),"argsort 63 indices")
end
do -- argsort 64
  local a=np.array({-11},np.int32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 64 dtype "..r.dtype)
  assert(eq(r.shape,{1}),"argsort 64 shape")
  assert(eq(r.strides,{8}),"argsort 64 strides")
  assert(eq(r:tolist(),{1}),"argsort 64 indices")
end
do -- argsort 65
  local a=(np.array({{9.0}},np.float32)).T
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 65 dtype "..r.dtype)
  assert(eq(r.shape,{1,1}),"argsort 65 shape")
  assert(eq(r.strides,{8,8}),"argsort 65 strides")
  assert(eq(r:tolist(),{{1}}),"argsort 65 indices")
end
do -- argsort 66
  local a=np.array({{{136},{173},{210},{247}},{{33},{70},{107},{144}},{{181},{218},{4},{41}}},np.uint32)
  local r=np.argsort(a,3)
  assert(r.dtype=="int64","argsort 66 dtype "..r.dtype)
  assert(eq(r.shape,{3,4,1}),"argsort 66 shape")
  assert(eq(r.strides,{32,8,8}),"argsort 66 strides")
  assert(eq(r:tolist(),{{{1},{1},{1},{1}},{{1},{1},{1},{1}},{{1},{1},{1},{1}}}),"argsort 66 indices")
end
do -- argsort 67
  local a=np.array({{{10.5}},{{-9.499}}},np.float32)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 67 dtype "..r.dtype)
  assert(eq(r.shape,{2,1,1}),"argsort 67 shape")
  assert(eq(r.strides,{8,8,8}),"argsort 67 strides")
  assert(eq(r:tolist(),{{{1}},{{1}}}),"argsort 67 indices")
end
do -- argsort 68
  local a=(np.array({{false,true,false,false},{true,false,true,false},{false,true,false,true}},np.bool)).T
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 68 dtype "..r.dtype)
  assert(eq(r.shape,{4,3}),"argsort 68 shape")
  assert(eq(r.strides,{24,8}),"argsort 68 strides")
end
do -- argsort 69
  local a=np.array({169,206,243,29},np.uint8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 69 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"argsort 69 shape")
  assert(eq(r.strides,{8}),"argsort 69 strides")
  assert(eq(r:tolist(),{4,1,2,3}),"argsort 69 indices")
end
do -- argsort 70
  local a=np.array({180,217,3,40},np.uint8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 70 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"argsort 70 shape")
  assert(eq(r.strides,{8}),"argsort 70 strides")
  assert(eq(r:tolist(),{3,4,1,2}),"argsort 70 indices")
end
do -- argsort 71
  local a=(np.array({{-10.75,-6.499},{-2.248,2.003},{6.254,10.505},{-9.494,-5.243},{-0.992,3.259}},np.float32)).T
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 71 dtype "..r.dtype)
  assert(eq(r.shape,{2,5}),"argsort 71 shape")
  assert(eq(r.strides,{40,8}),"argsort 71 strides")
  assert(eq(r:tolist(),{{1,1,1,1,1},{2,2,2,2,2}}),"argsort 71 indices")
end
do -- argsort 72
  local a=np.array({202,239,25,62,99},np.uint8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 72 dtype "..r.dtype)
  assert(eq(r.shape,{5}),"argsort 72 shape")
  assert(eq(r.strides,{8}),"argsort 72 strides")
  assert(eq(r:tolist(),{3,4,5,1,2}),"argsort 72 indices")
end
do -- argsort 73
  local a=(np.array({{88}},np.int8)).T
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 73 dtype "..r.dtype)
  assert(eq(r.shape,{1,1}),"argsort 73 shape")
  assert(eq(r.strides,{8,8}),"argsort 73 strides")
  assert(eq(r:tolist(),{{1}}),"argsort 73 indices")
end
do -- argsort 74
  local a=np.array({-8.5},np.float32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 74 dtype "..r.dtype)
  assert(eq(r.shape,{1}),"argsort 74 shape")
  assert(eq(r.strides,{8}),"argsort 74 strides")
  assert(eq(r:tolist(),{1}),"argsort 74 indices")
end
do -- argsort 75
  local a=np.array({{{110,-104,-67},{-30,7,44}}},np.int8)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 75 dtype "..r.dtype)
  assert(eq(r.shape,{1,2,3}),"argsort 75 shape")
  assert(eq(r.strides,{48,24,8}),"argsort 75 strides")
  assert(eq(r:tolist(),{{{2,1,1},{1,2,2}}}),"argsort 75 indices")
end
do -- argsort 76
  local a=np.array({{{true}}},np.bool)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 76 dtype "..r.dtype)
  assert(eq(r.shape,{1,1,1}),"argsort 76 shape")
  assert(eq(r.strides,{8,8,8}),"argsort 76 strides")
end
do -- argsort 77
  local a=np.array({6,43,80,117},np.uint8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 77 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"argsort 77 shape")
  assert(eq(r.strides,{8}),"argsort 77 strides")
  assert(eq(r:tolist(),{1,2,3,4}),"argsort 77 indices")
end
do -- argsort 78
  local a=np.array({{-108,-71,-34,3,40},{77,114,-100,-63,-26}},np.int16)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 78 dtype "..r.dtype)
  assert(eq(r.shape,{2,5}),"argsort 78 shape")
  assert(eq(r.strides,{40,8}),"argsort 78 strides")
  assert(eq(r:tolist(),{{1,1,2,2,2},{2,2,1,1,1}}),"argsort 78 indices")
end
do -- argsort 79
  local a=np.array({{-4.75},{-0.499},{3.752}},np.float32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 79 dtype "..r.dtype)
  assert(eq(r.shape,{3,1}),"argsort 79 shape")
  assert(eq(r.strides,{8,8}),"argsort 79 strides")
  assert(eq(r:tolist(),{{1},{2},{3}}),"argsort 79 indices")
end
do -- argsort 80
  local a=np.array({{{-86,-49,-12,25}},{{62,99,-115,-78}}},np.int16)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 80 dtype "..r.dtype)
  assert(eq(r.shape,{2,1,4}),"argsort 80 shape")
  assert(eq(r.strides,{32,32,8}),"argsort 80 strides")
  assert(eq(r:tolist(),{{{1,1,1,1}},{{1,1,1,1}}}),"argsort 80 indices")
end
do -- argsort 81
  local a=np.array({{{50,87}},{{124,161}}},np.uint8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 81 dtype "..r.dtype)
  assert(eq(r.shape,{2,1,2}),"argsort 81 shape")
  assert(eq(r.strides,{16,16,8}),"argsort 81 strides")
  assert(eq(r:tolist(),{{{1,1}},{{2,2}}}),"argsort 81 indices")
end
do -- argsort 82
  local a=np.array({{-64,-27,10},{47,84,121},{-93,-56,-19}},np.int8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 82 dtype "..r.dtype)
  assert(eq(r.shape,{3,3}),"argsort 82 shape")
  assert(eq(r.strides,{24,8}),"argsort 82 strides")
  assert(eq(r:tolist(),{{3,3,3},{1,1,1},{2,2,2}}),"argsort 82 indices")
end
do -- argsort 83
  local a=np.array({{{-53,-16,21,58,95},{-119,-82,-45,-8,29}}},np.int8)
  local r=np.argsort(a,3)
  assert(r.dtype=="int64","argsort 83 dtype "..r.dtype)
  assert(eq(r.shape,{1,2,5}),"argsort 83 shape")
  assert(eq(r.strides,{80,40,8}),"argsort 83 strides")
  assert(eq(r:tolist(),{{{1,2,3,4,5},{1,2,3,4,5}}}),"argsort 83 indices")
end
do -- argsort 84
  local a=(np.array({{83,120,157},{194,231,17}},np.uint32)).T
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 84 dtype "..r.dtype)
  assert(eq(r.shape,{3,2}),"argsort 84 shape")
  assert(eq(r.strides,{16,8}),"argsort 84 strides")
  assert(eq(r:tolist(),{{1,3},{2,1},{3,2}}),"argsort 84 indices")
end
do -- argsort 85
  local a=(np.array({{true,false,false},{true,false,true},{false,false,true},{false,true,false},{false,true,false}},np.bool)).T
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 85 dtype "..r.dtype)
  assert(eq(r.shape,{3,5}),"argsort 85 shape")
  assert(eq(r.strides,{40,8}),"argsort 85 strides")
end
do -- argsort 86
  local a=np.array({{105,142},{179,216},{2,39},{76,113}},np.uint8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 86 dtype "..r.dtype)
  assert(eq(r.shape,{4,2}),"argsort 86 shape")
  assert(eq(r.strides,{16,8}),"argsort 86 strides")
  assert(eq(r:tolist(),{{3,3},{4,4},{1,1},{2,2}}),"argsort 86 indices")
end
do -- argsort 87
  local a=np.array({{116,153,190},{227,13,50},{87,124,161},{198,235,21},{58,95,132}},np.uint8)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 87 dtype "..r.dtype)
  assert(eq(r.shape,{5,3}),"argsort 87 shape")
  assert(eq(r.strides,{24,8}),"argsort 87 strides")
  assert(eq(r:tolist(),{{1,2,3},{2,3,1},{1,2,3},{3,1,2},{1,2,3}}),"argsort 87 indices")
end
do -- argsort 88
  local a=np.array({2.0,6.251},np.float32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 88 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"argsort 88 shape")
  assert(eq(r.strides,{8}),"argsort 88 strides")
  assert(eq(r:tolist(),{1,2}),"argsort 88 indices")
end
do -- argsort 89
  local a=np.array({138,175,212,249},np.uint16)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 89 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"argsort 89 shape")
  assert(eq(r.strides,{8}),"argsort 89 strides")
  assert(eq(r:tolist(),{1,2,3,4}),"argsort 89 indices")
end
do -- argsort 90
  local a=np.array({24,61},np.int8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 90 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"argsort 90 shape")
  assert(eq(r.strides,{8}),"argsort 90 strides")
  assert(eq(r:tolist(),{1,2}),"argsort 90 indices")
end
do -- argsort 91
  local a=np.array({160,197,234},np.uint16)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 91 dtype "..r.dtype)
  assert(eq(r.shape,{3}),"argsort 91 shape")
  assert(eq(r.strides,{8}),"argsort 91 strides")
  assert(eq(r:tolist(),{1,2,3}),"argsort 91 indices")
end
do -- argsort 92
  local a=np.array({false,false,true,false},np.bool)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 92 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"argsort 92 shape")
  assert(eq(r.strides,{8}),"argsort 92 strides")
end
do -- argsort 93
  local a=np.array({{{182,219,5,42,79},{116,153,190,227,13}}},np.uint8)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 93 dtype "..r.dtype)
  assert(eq(r.shape,{1,2,5}),"argsort 93 shape")
  assert(eq(r.strides,{80,40,8}),"argsort 93 strides")
  assert(eq(r:tolist(),{{{2,2,1,1,2},{1,1,2,2,1}}}),"argsort 93 indices")
end
do -- argsort 94
  local a=np.array({68},np.int8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 94 dtype "..r.dtype)
  assert(eq(r.shape,{1}),"argsort 94 shape")
  assert(eq(r.strides,{8}),"argsort 94 strides")
  assert(eq(r:tolist(),{1}),"argsort 94 indices")
end
do -- argsort 95
  local a=np.array({79,116,-98,-61},np.int64)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 95 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"argsort 95 shape")
  assert(eq(r.strides,{8}),"argsort 95 strides")
  assert(eq(r:tolist(),{3,4,1,2}),"argsort 95 indices")
end
do -- argsort 96
  local a=np.array({8.0,-11.999},np.float32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 96 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"argsort 96 shape")
  assert(eq(r.strides,{8}),"argsort 96 strides")
  assert(eq(r:tolist(),{2,1}),"argsort 96 indices")
end
do -- argsort 97
  local a=np.array({8.75,-11.249},np.float32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 97 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"argsort 97 shape")
  assert(eq(r.strides,{8}),"argsort 97 strides")
  assert(eq(r:tolist(),{2,1}),"argsort 97 indices")
end
do -- argsort 98
  local a=np.array({{237}},np.uint8)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 98 dtype "..r.dtype)
  assert(eq(r.shape,{1,1}),"argsort 98 shape")
  assert(eq(r.strides,{8,8}),"argsort 98 strides")
  assert(eq(r:tolist(),{{1}}),"argsort 98 indices")
end
do -- argsort 99
  local a=np.array({{{248,34},{71,108},{145,182},{219,5}},{{42,79},{116,153},{190,227},{13,50}},{{87,124},{161,198},{235,21},{58,95}}},np.uint32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 99 dtype "..r.dtype)
  assert(eq(r.shape,{3,4,2}),"argsort 99 shape")
  assert(eq(r.strides,{64,16,8}),"argsort 99 strides")
  assert(eq(r:tolist(),{{{2,1},{1,1},{1,3},{2,1}},{{3,2},{2,2},{2,1},{3,2}},{{1,3},{3,3},{3,2},{1,3}}}),"argsort 99 indices")
end
do -- argsort 100
  local a=np.array({{{8,45,82,119},{156,193,230,16},{53,90,127,164},{201,238,24,61}},{{98,135,172,209},{246,32,69,106},{143,180,217,3},{40,77,114,151}}},np.uint8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 100 dtype "..r.dtype)
  assert(eq(r.shape,{2,4,4}),"argsort 100 shape")
  assert(eq(r.strides,{128,32,8}),"argsort 100 strides")
  assert(eq(r:tolist(),{{{1,1,1,1},{1,2,2,1},{1,1,1,2},{2,2,1,1}},{{2,2,2,2},{2,1,1,2},{2,2,2,1},{1,1,2,2}}}),"argsort 100 indices")
end
do -- argsort 101
  local a=np.array({19,56,93,130},np.uint8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 101 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"argsort 101 shape")
  assert(eq(r.strides,{8}),"argsort 101 strides")
  assert(eq(r:tolist(),{1,2,3,4}),"argsort 101 indices")
end
do -- argsort 102
  local a=np.array({{{false,false,true},{false,true,false},{false,true,false},{true,false,false}},{{true,false,true},{false,false,true},{false,true,false},{false,true,false}},{{true,false,false},{true,false,true},{false,false,true},{false,true,false}},{{false,true,false},{true,false,false},{true,false,true},{false,false,true}}},np.bool)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 102 dtype "..r.dtype)
  assert(eq(r.shape,{4,4,3}),"argsort 102 shape")
  assert(eq(r.strides,{96,24,8}),"argsort 102 strides")
end
do -- argsort 103
  local a=np.array({{{41,78},{115,152}},{{189,226},{12,49}}},np.uint8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 103 dtype "..r.dtype)
  assert(eq(r.shape,{2,2,2}),"argsort 103 shape")
  assert(eq(r.strides,{32,16,8}),"argsort 103 strides")
  assert(eq(r:tolist(),{{{1,1},{2,2}},{{2,2},{1,1}}}),"argsort 103 indices")
end
do -- argsort 104
  local a=np.array({{{-73,-36},{1,38}}},np.int8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 104 dtype "..r.dtype)
  assert(eq(r.shape,{1,2,2}),"argsort 104 shape")
  assert(eq(r.strides,{32,16,8}),"argsort 104 strides")
  assert(eq(r:tolist(),{{{1,1},{1,1}}}),"argsort 104 indices")
end
do -- argsort 105
  local a=np.array({63,100,137,174,211},np.uint8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 105 dtype "..r.dtype)
  assert(eq(r.shape,{5}),"argsort 105 shape")
  assert(eq(r.strides,{8}),"argsort 105 strides")
  assert(eq(r:tolist(),{1,2,3,4,5}),"argsort 105 indices")
end
do -- argsort 106
  local a=np.array({true,false,true,false},np.bool)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 106 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"argsort 106 shape")
  assert(eq(r.strides,{8}),"argsort 106 strides")
end
do -- argsort 107
  local a=np.array({-40,-3,34,71},np.int16)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 107 dtype "..r.dtype)
  assert(eq(r.shape,{4}),"argsort 107 shape")
  assert(eq(r.strides,{8}),"argsort 107 strides")
  assert(eq(r:tolist(),{1,2,3,4}),"argsort 107 indices")
end
do -- argsort 108
  local a=np.array({{-29,8},{45,82},{119,-95},{-58,-21}},np.int32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 108 dtype "..r.dtype)
  assert(eq(r.shape,{4,2}),"argsort 108 shape")
  assert(eq(r.strides,{16,8}),"argsort 108 strides")
  assert(eq(r:tolist(),{{4,3},{1,4},{2,1},{3,2}}),"argsort 108 indices")
end
do -- argsort 109
  local a=(np.array({{107},{144},{181},{218}},np.uint16)).T
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 109 dtype "..r.dtype)
  assert(eq(r.shape,{1,4}),"argsort 109 shape")
  assert(eq(r.strides,{32,8}),"argsort 109 strides")
  assert(eq(r:tolist(),{{1,1,1,1}}),"argsort 109 indices")
end
do -- argsort 110
  local a=np.array({{{-5.75},{-1.499}},{{2.752},{7.003}}},np.float64)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 110 dtype "..r.dtype)
  assert(eq(r.shape,{2,2,1}),"argsort 110 shape")
  assert(eq(r.strides,{16,8,8}),"argsort 110 strides")
  assert(eq(r:tolist(),{{{1},{1}},{{2},{2}}}),"argsort 110 indices")
end
do -- argsort 111
  local a=np.array({{{129,166,203},{240,26,63}},{{100,137,174},{211,248,34}},{{71,108,145},{182,219,5}}},np.uint32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 111 dtype "..r.dtype)
  assert(eq(r.shape,{3,2,3}),"argsort 111 shape")
  assert(eq(r.strides,{48,24,8}),"argsort 111 strides")
  assert(eq(r:tolist(),{{{3,3,3},{3,1,3}},{{2,2,2},{2,3,2}},{{1,1,1},{1,2,1}}}),"argsort 111 indices")
end
do -- argsort 112
  local a=(np.array({{140,177,214},{0,37,74}},np.uint8)).T
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 112 dtype "..r.dtype)
  assert(eq(r.shape,{3,2}),"argsort 112 shape")
  assert(eq(r.strides,{16,8}),"argsort 112 strides")
  assert(eq(r:tolist(),{{1,1},{2,2},{3,3}}),"argsort 112 indices")
end
do -- argsort 113
  local a=np.array({{-3.5,0.751,5.002,9.253},{-10.746,-6.495,-2.244,2.007},{6.258,10.509,-9.49,-5.239},{-0.988,3.263,7.514,11.765},{-8.234,-3.983,0.268,4.519}},np.float64)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 113 dtype "..r.dtype)
  assert(eq(r.shape,{5,4}),"argsort 113 shape")
  assert(eq(r.strides,{32,8}),"argsort 113 strides")
  assert(eq(r:tolist(),{{1,2,3,4},{1,2,3,4},{3,4,1,2},{1,2,3,4},{1,2,3,4}}),"argsort 113 indices")
end
do -- argsort 114
  local a=(np.array({{37,74,111},{-103,-66,-29},{8,45,82},{119,-95,-58}},np.int64)).T
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 114 dtype "..r.dtype)
  assert(eq(r.shape,{3,4}),"argsort 114 shape")
  assert(eq(r.strides,{32,8}),"argsort 114 strides")
  assert(eq(r:tolist(),{{1,1,1,2},{2,2,2,3},{3,3,3,1}}),"argsort 114 indices")
end
do -- argsort 115
  local a=np.array({{{48,85,122,-92},{-55,-18,19,56},{93,-121,-84,-47},{-10,27,64,101},{-113,-76,-39,-2}},{{35,72,109,-105},{-68,-31,6,43},{80,117,-97,-60},{-23,14,51,88},{125,-89,-52,-15}},{{22,59,96,-118},{-81,-44,-7,30},{67,104,-110,-73},{-36,1,38,75},{112,-102,-65,-28}},{{9,46,83,120},{-94,-57,-20,17},{54,91,-123,-86},{-49,-12,25,62},{99,-115,-78,-41}},{{-4,33,70,107},{-107,-70,-33,4},{41,78,115,-99},{-62,-25,12,49},{86,123,-91,-54}}},np.int64)
  local r=np.argsort(a,3)
  assert(r.dtype=="int64","argsort 115 dtype "..r.dtype)
  assert(eq(r.shape,{5,5,4}),"argsort 115 shape")
  assert(eq(r.strides,{160,32,8}),"argsort 115 strides")
  assert(eq(r:tolist(),{{{4,1,2,3},{1,2,3,4},{2,3,4,1},{1,2,3,4},{1,2,3,4}},{{4,1,2,3},{1,2,3,4},{3,4,1,2},{1,2,3,4},{2,3,4,1}},{{4,1,2,3},{1,2,3,4},{3,4,1,2},{1,2,3,4},{2,3,4,1}},{{1,2,3,4},{1,2,3,4},{3,4,1,2},{1,2,3,4},{2,3,4,1}},{{1,2,3,4},{1,2,3,4},{4,1,2,3},{1,2,3,4},{3,4,1,2}}}),"argsort 115 indices")
end
do -- argsort 116
  local a=(np.array({{184,221,7,44,81},{118,155,192,229,15},{52,89,126,163,200}},np.uint32)).T
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 116 dtype "..r.dtype)
  assert(eq(r.shape,{5,3}),"argsort 116 shape")
  assert(eq(r.strides,{24,8}),"argsort 116 strides")
  assert(eq(r:tolist(),{{3,5,1},{4,1,2},{5,2,3},{1,3,4},{2,4,5}}),"argsort 116 indices")
end
do -- argsort 117
  local a=np.array({70,107},np.int16)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 117 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"argsort 117 shape")
  assert(eq(r.strides,{8}),"argsort 117 strides")
  assert(eq(r:tolist(),{1,2}),"argsort 117 indices")
end
do -- argsort 118
  local a=np.array({{81,118},{-96,-59},{-22,15},{52,89}},np.int8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 118 dtype "..r.dtype)
  assert(eq(r.shape,{4,2}),"argsort 118 shape")
  assert(eq(r.strides,{16,8}),"argsort 118 strides")
  assert(eq(r:tolist(),{{2,2},{3,3},{4,4},{1,1}}),"argsort 118 indices")
end
do -- argsort 119
  local a=np.array({{false},{true},{false},{true},{false}},np.bool)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 119 dtype "..r.dtype)
  assert(eq(r.shape,{5,1}),"argsort 119 shape")
  assert(eq(r.strides,{8,8}),"argsort 119 strides")
end
do -- argsort 120
  local a=np.array({{{1.75,6.001,10.252,-9.747,-5.496}},{{-1.245,3.006,7.257,11.508,-8.491}},{{-4.24,0.011,4.262,8.513,-11.486}},{{-7.235,-2.984,1.267,5.518,9.769}}},np.float64)
  local r=np.argsort(a,3)
  assert(r.dtype=="int64","argsort 120 dtype "..r.dtype)
  assert(eq(r.shape,{4,1,5}),"argsort 120 shape")
  assert(eq(r.strides,{40,40,8}),"argsort 120 strides")
  assert(eq(r:tolist(),{{{4,5,1,2,3}},{{5,1,2,3,4}},{{5,1,2,3,4}},{{1,2,3,4,5}}}),"argsort 120 indices")
end
do -- argsort 121
  local a=np.array({{{239,25,62,99,136},{173,210,247,33,70},{107,144,181,218,4},{41,78,115,152,189}}},np.uint32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 121 dtype "..r.dtype)
  assert(eq(r.shape,{1,4,5}),"argsort 121 shape")
  assert(eq(r.strides,{160,40,8}),"argsort 121 strides")
  assert(eq(r:tolist(),{{{1,1,1,1,1},{1,1,1,1,1},{1,1,1,1,1},{1,1,1,1,1}}}),"argsort 121 indices")
end
do -- argsort 122
  local a=np.array({{3.25,7.501,11.752,-8.247},{-3.996,0.255,4.506,8.757}},np.float64)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 122 dtype "..r.dtype)
  assert(eq(r.shape,{2,4}),"argsort 122 shape")
  assert(eq(r.strides,{32,8}),"argsort 122 strides")
  assert(eq(r:tolist(),{{4,1,2,3},{1,2,3,4}}),"argsort 122 indices")
end
do -- argsort 123
  local a=np.array({-115,-78,-41},np.int64)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 123 dtype "..r.dtype)
  assert(eq(r.shape,{3}),"argsort 123 shape")
  assert(eq(r.strides,{8}),"argsort 123 strides")
  assert(eq(r:tolist(),{1,2,3}),"argsort 123 indices")
end
do -- argsort 124
  local a=np.array({-104},np.int8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 124 dtype "..r.dtype)
  assert(eq(r.shape,{1}),"argsort 124 shape")
  assert(eq(r.strides,{8}),"argsort 124 strides")
  assert(eq(r:tolist(),{1}),"argsort 124 indices")
end
do -- argsort 125
  local a=np.array({5.5,9.751,-10.248,-5.997,-1.746},np.float32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 125 dtype "..r.dtype)
  assert(eq(r.shape,{5}),"argsort 125 shape")
  assert(eq(r.strides,{8}),"argsort 125 strides")
  assert(eq(r:tolist(),{3,4,5,1,2}),"argsort 125 indices")
end
do -- argsort 126
  local a=np.array({{{-82},{-45},{-8},{29},{66}},{{103},{-111},{-74},{-37},{0}},{{37},{74},{111},{-103},{-66}},{{-29},{8},{45},{82},{119}}},np.int16)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 126 dtype "..r.dtype)
  assert(eq(r.shape,{4,5,1}),"argsort 126 shape")
  assert(eq(r.strides,{40,8,8}),"argsort 126 strides")
  assert(eq(r:tolist(),{{{1},{2},{2},{3},{3}},{{4},{1},{1},{2},{2}},{{3},{4},{4},{1},{1}},{{2},{3},{3},{4},{4}}}),"argsort 126 indices")
end
do -- argsort 127
  local a=np.array({-71,-34},np.int8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 127 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"argsort 127 shape")
  assert(eq(r.strides,{8}),"argsort 127 strides")
  assert(eq(r:tolist(),{1,2}),"argsort 127 indices")
end
do -- argsort 128
  local a=(np.array({{false,true}},np.bool)).T
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 128 dtype "..r.dtype)
  assert(eq(r.shape,{2,1}),"argsort 128 shape")
  assert(eq(r.strides,{8,8}),"argsort 128 strides")
end
do -- argsort 129
  local a=np.array({-49,-12,25,62,99},np.int16)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 129 dtype "..r.dtype)
  assert(eq(r.shape,{5}),"argsort 129 shape")
  assert(eq(r.strides,{8}),"argsort 129 strides")
  assert(eq(r:tolist(),{1,2,3,4,5}),"argsort 129 indices")
end
do -- argsort 130
  local a=np.array({9.25,-10.749,-6.498,-2.247,2.004},np.float64)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 130 dtype "..r.dtype)
  assert(eq(r.shape,{5}),"argsort 130 shape")
  assert(eq(r.strides,{8}),"argsort 130 strides")
  assert(eq(r:tolist(),{2,3,4,5,1}),"argsort 130 indices")
end
do -- argsort 131
  local a=np.array({-27,10,47},np.int32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 131 dtype "..r.dtype)
  assert(eq(r.shape,{3}),"argsort 131 shape")
  assert(eq(r.strides,{8}),"argsort 131 strides")
  assert(eq(r:tolist(),{1,2,3}),"argsort 131 indices")
end
do -- argsort 132
  local a=np.array({{-16,21,58,95,-119},{-82,-45,-8,29,66}},np.int32)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 132 dtype "..r.dtype)
  assert(eq(r.shape,{2,5}),"argsort 132 shape")
  assert(eq(r.strides,{40,8}),"argsort 132 strides")
  assert(eq(r:tolist(),{{5,1,2,3,4},{1,2,3,4,5}}),"argsort 132 indices")
end
do -- argsort 133
  local a=np.array({-5,32,69},np.int8)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 133 dtype "..r.dtype)
  assert(eq(r.shape,{3}),"argsort 133 shape")
  assert(eq(r.strides,{8}),"argsort 133 strides")
  assert(eq(r:tolist(),{1,2,3}),"argsort 133 indices")
end
do -- argsort 134
  local a=np.array({131,168,205,242,28},np.uint16)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 134 dtype "..r.dtype)
  assert(eq(r.shape,{5}),"argsort 134 shape")
  assert(eq(r.strides,{8}),"argsort 134 strides")
  assert(eq(r:tolist(),{5,1,2,3,4}),"argsort 134 indices")
end
do -- argsort 135
  local a=np.array({{{17,54,91,-123},{-86,-49,-12,25},{62,99,-115,-78},{-41,-4,33,70}},{{107,-107,-70,-33},{4,41,78,115},{-99,-62,-25,12},{49,86,123,-91}},{{-54,-17,20,57},{94,-120,-83,-46},{-9,28,65,102},{-112,-75,-38,-1}},{{36,73,110,-104},{-67,-30,7,44},{81,118,-96,-59},{-22,15,52,89}},{{-125,-88,-51,-14},{23,60,97,-117},{-80,-43,-6,31},{68,105,-109,-72}}},np.int64)
  local r=np.argsort(a,3)
  assert(r.dtype=="int64","argsort 135 dtype "..r.dtype)
  assert(eq(r.shape,{5,4,4}),"argsort 135 shape")
  assert(eq(r.strides,{128,32,8}),"argsort 135 strides")
  assert(eq(r:tolist(),{{{4,1,2,3},{1,2,3,4},{3,4,1,2},{1,2,3,4}},{{2,3,4,1},{1,2,3,4},{1,2,3,4},{4,1,2,3}},{{1,2,3,4},{2,3,4,1},{1,2,3,4},{1,2,3,4}},{{4,1,2,3},{1,2,3,4},{3,4,1,2},{1,2,3,4}},{{1,2,3,4},{4,1,2,3},{1,2,3,4},{3,4,1,2}}}),"argsort 135 indices")
end
do -- argsort 136
  local a=np.array({{{true,false},{true,false}},{{false,true},{false,true}},{{false,false},{true,false}},{{true,false},{false,true}}},np.bool)
  local r=np.argsort(a,3)
  assert(r.dtype=="int64","argsort 136 dtype "..r.dtype)
  assert(eq(r.shape,{4,2,2}),"argsort 136 shape")
  assert(eq(r.strides,{32,16,8}),"argsort 136 strides")
end
do -- argsort 137
  local a=np.array({39,76,113,-101,-64},np.int32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 137 dtype "..r.dtype)
  assert(eq(r.shape,{5}),"argsort 137 shape")
  assert(eq(r.strides,{8}),"argsort 137 strides")
  assert(eq(r:tolist(),{4,5,1,2,3}),"argsort 137 indices")
end
do -- argsort 138
  local a=np.array({{50,87,124},{-90,-53,-16},{21,58,95}},np.int64)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 138 dtype "..r.dtype)
  assert(eq(r.shape,{3,3}),"argsort 138 shape")
  assert(eq(r.strides,{24,8}),"argsort 138 strides")
  assert(eq(r:tolist(),{{1,2,3},{1,2,3},{1,2,3}}),"argsort 138 indices")
end
do -- argsort 139
  local a=(np.array({{false,true,false},{true,false,false}},np.bool)).T
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 139 dtype "..r.dtype)
  assert(eq(r.shape,{3,2}),"argsort 139 shape")
  assert(eq(r.strides,{16,8}),"argsort 139 strides")
end
do -- argsort 140
  local a=np.array({{{197,234}},{{20,57}},{{94,131}},{{168,205}}},np.uint8)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 140 dtype "..r.dtype)
  assert(eq(r.shape,{4,1,2}),"argsort 140 shape")
  assert(eq(r.strides,{16,16,8}),"argsort 140 strides")
  assert(eq(r:tolist(),{{{1,1}},{{1,1}},{{1,1}},{{1,1}}}),"argsort 140 indices")
end
do -- argsort 141
  local a=np.array({{208,245},{31,68}},np.uint16)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 141 dtype "..r.dtype)
  assert(eq(r.shape,{2,2}),"argsort 141 shape")
  assert(eq(r.strides,{16,8}),"argsort 141 strides")
  assert(eq(r:tolist(),{{1,2},{1,2}}),"argsort 141 indices")
end
do -- argsort 142
  local a=np.array({false,false},np.bool)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 142 dtype "..r.dtype)
  assert(eq(r.shape,{2}),"argsort 142 shape")
  assert(eq(r.strides,{8}),"argsort 142 strides")
end
do -- argsort 143
  local a=np.array({105,-109,-72,-35,2},np.int64)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 143 dtype "..r.dtype)
  assert(eq(r.shape,{5}),"argsort 143 shape")
  assert(eq(r.strides,{8}),"argsort 143 strides")
  assert(eq(r:tolist(),{2,3,4,5,1}),"argsort 143 indices")
end
do -- argsort 144
  local a=np.array({{-4.5,-0.249,4.002},{8.253,-11.746,-7.495},{-3.244,1.007,5.258},{9.509,-10.49,-6.239},{-1.988,2.263,6.514}},np.float32)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 144 dtype "..r.dtype)
  assert(eq(r.shape,{5,3}),"argsort 144 shape")
  assert(eq(r.strides,{24,8}),"argsort 144 strides")
  assert(eq(r:tolist(),{{1,2,3},{2,3,1},{1,2,3},{2,3,1},{1,2,3}}),"argsort 144 indices")
end
do -- argsort 145
  local a=np.array({{{-3.75,0.501},{4.752,9.003}},{{-10.996,-6.745},{-2.494,1.757}},{{6.008,10.259},{-9.74,-5.489}},{{-1.238,3.013},{7.264,11.515}}},np.float64)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 145 dtype "..r.dtype)
  assert(eq(r.shape,{4,2,2}),"argsort 145 shape")
  assert(eq(r.strides,{32,16,8}),"argsort 145 strides")
  assert(eq(r:tolist(),{{{2,2},{3,3}},{{1,1},{2,2}},{{4,4},{1,1}},{{3,3},{4,4}}}),"argsort 145 indices")
end
do -- argsort 146
  local a=np.array({{{-113},{-76},{-39},{-2}},{{35},{72},{109},{-105}}},np.int32)
  local r=np.argsort(a,3)
  assert(r.dtype=="int64","argsort 146 dtype "..r.dtype)
  assert(eq(r.shape,{2,4,1}),"argsort 146 shape")
  assert(eq(r.strides,{32,8,8}),"argsort 146 strides")
  assert(eq(r:tolist(),{{{1},{1},{1},{1}},{{1},{1},{1},{1}}}),"argsort 146 indices")
end
do -- argsort 147
  local a=np.array({{{-2.25},{2.001},{6.252}},{{10.503},{-9.496},{-5.245}}},np.float64)
  local r=np.argsort(a,3)
  assert(r.dtype=="int64","argsort 147 dtype "..r.dtype)
  assert(eq(r.shape,{2,3,1}),"argsort 147 shape")
  assert(eq(r.strides,{24,8,8}),"argsort 147 strides")
  assert(eq(r:tolist(),{{{1},{1},{1}},{{1},{1},{1}}}),"argsort 147 indices")
end
do -- argsort 148
  local a=np.array({{-91}},np.int32)
  local r=np.argsort(a,1)
  assert(r.dtype=="int64","argsort 148 dtype "..r.dtype)
  assert(eq(r.shape,{1,1}),"argsort 148 shape")
  assert(eq(r.strides,{8,8}),"argsort 148 strides")
  assert(eq(r:tolist(),{{1}}),"argsort 148 indices")
end
do -- argsort 149
  local a=np.array({{false,true,false,true},{false,false,true,false},{true,false,false,true},{false,true,false,false}},np.bool)
  local r=np.argsort(a,2)
  assert(r.dtype=="int64","argsort 149 dtype "..r.dtype)
  assert(eq(r.shape,{4,4}),"argsort 149 shape")
  assert(eq(r.strides,{32,8}),"argsort 149 strides")
end
do -- partition 0
  local a=(np.array({{3.5,7.751,12.002},{-7.997,-3.746,0.505},{4.756,9.007,-10.992},{-6.741,-2.49,1.761}},np.float32)).T
  local r=np.partition(a,{1,2,4},2)
  assert(r.dtype=="float32","partition 0 dtype")
  assert(eq(r.shape,{3,4}),"partition 0 shape")
  assert(eq(r.strides,{4,12}),"partition 0 strides")
  assert(close(np.sort(r,2):tolist(),{{-7.997000217437744,-6.741000175476074,3.5,4.75600004196167},{-3.746000051498413,-2.490000009536743,7.750999927520752,9.006999969482422},{-10.991999626159668,0.5049999952316284,1.7610000371932983,12.001999855041504}}),"partition 0 multiset")
end
do -- partition 1
  local a=np.array({{-83,-46,-9,28},{65,102,-112,-75}},np.int64)
  local r=np.partition(a,2,1)
  assert(r.dtype=="int64","partition 1 dtype")
  assert(eq(r.shape,{2,4}),"partition 1 shape")
  assert(eq(r.strides,{32,8}),"partition 1 strides")
  assert(close(np.sort(r,1):tolist(),{{-83,-46,-112,-75},{65,102,-9,28}}),"partition 1 multiset")
end
do -- partition 2
  local a=np.array({{{-72,-35,2,39,76,113},{-101,-64,-27,10,47,84}},{{121,-93,-56,-19,18,55},{92,-122,-85,-48,-11,26}}},np.int8)
  local r=np.partition(a,1,1)
  assert(r.dtype=="int8","partition 2 dtype")
  assert(eq(r.shape,{2,2,6}),"partition 2 shape")
  assert(eq(r.strides,{12,6,1}),"partition 2 strides")
  assert(close(np.sort(r,1):tolist(),{{{-72,-93,-56,-19,18,55},{-101,-122,-85,-48,-11,26}},{{121,-35,2,39,76,113},{92,-64,-27,10,47,84}}}),"partition 2 multiset")
end
do -- partition 3
  local a=(np.array({{5.75,10.001,-9.998,-5.747},{-1.496,2.755,7.006,11.257},{-8.742,-4.491,-0.24,4.011}},np.float32)).T
  local r=np.partition(a,{1,2,3},2)
  assert(r.dtype=="float32","partition 3 dtype")
  assert(eq(r.shape,{4,3}),"partition 3 shape")
  assert(eq(r.strides,{4,16}),"partition 3 strides")
  assert(close(np.sort(r,2):tolist(),{{-8.741999626159668,-1.496000051498413,5.75},{-4.491000175476074,2.755000114440918,10.00100040435791},{-9.998000144958496,-0.23999999463558197,7.00600004196167},{-5.747000217437744,4.011000156402588,11.256999969482422}}),"partition 3 multiset")
end
do -- partition 4
  local a=np.array({{{-50,-13,24,61,98,-116},{-79,-42,-5,32,69,106},{-108,-71,-34,3,40,77},{114,-100,-63,-26,11,48},{85,122,-92,-55,-18,19}},{{56,93,-121,-84,-47,-10},{27,64,101,-113,-76,-39},{-2,35,72,109,-105,-68},{-31,6,43,80,117,-97},{-60,-23,14,51,88,125}}},np.int8)
  local r=np.partition(a,4,2)
  assert(r.dtype=="int8","partition 4 dtype")
  assert(eq(r.shape,{2,5,6}),"partition 4 shape")
  assert(eq(r.strides,{30,6,1}),"partition 4 strides")
  assert(close(np.sort(r,2):tolist(),{{{-108,-100,-92,-55,-18,-116},{-79,-71,-63,-26,11,19},{-50,-42,-34,3,40,48},{85,-13,-5,32,69,77},{114,122,24,61,98,106}},{{-60,-23,-121,-113,-105,-97},{-31,6,14,-84,-76,-68},{-2,35,43,51,-47,-39},{27,64,72,80,88,-10},{56,93,101,109,117,125}}}),"partition 4 multiset")
end
do -- partition 5
  local a=np.array({{{7.25,11.501,-8.498},{-4.247,0.004,4.255},{8.506,-11.493,-7.242},{-2.991,1.26,5.511}},{{9.762,-10.237,-5.986},{-1.735,2.516,6.767},{11.018,-8.981,-4.73},{-0.479,3.772,8.023}},{{-11.976,-7.725,-3.474},{0.777,5.028,9.279},{-10.72,-6.469,-2.218},{2.033,6.284,10.535}}},np.float32)
  local r=np.partition(a,1,3)
  assert(r.dtype=="float32","partition 5 dtype")
  assert(eq(r.shape,{3,4,3}),"partition 5 shape")
  assert(eq(r.strides,{48,12,4}),"partition 5 strides")
  assert(close(np.sort(r,3):tolist(),{{{-8.498000144958496,7.25,11.50100040435791},{-4.247000217437744,0.004000000189989805,4.255000114440918},{-11.493000030517578,-7.242000102996826,8.505999565124512},{-2.990999937057495,1.2599999904632568,5.511000156402588}},{{-10.237000465393066,-5.986000061035156,9.76200008392334},{-1.7350000143051147,2.5160000324249268,6.767000198364258},{-8.980999946594238,-4.730000019073486,11.017999649047852},{-0.4790000021457672,3.7720000743865967,8.02299976348877}},{{-11.97599983215332,-7.724999904632568,-3.4739999771118164},{0.7770000100135803,5.0279998779296875,9.279000282287598},{-10.720000267028809,-6.468999862670898,-2.2179999351501465},{2.0329999923706055,6.283999919891357,10.53499984741211}}}),"partition 5 multiset")
end
do -- partition 6
  local a=np.array({{{8.0,-11.999},{-7.748,-3.497},{0.754,5.005},{9.256,-10.743}},{{-6.492,-2.241},{2.01,6.261},{10.512,-9.487},{-5.236,-0.985}},{{3.266,7.517},{11.768,-8.231},{-3.98,0.271},{4.522,8.773}},{{-11.226,-6.975},{-2.724,1.527},{5.778,10.029},{-9.97,-5.719}},{{-1.468,2.783},{7.034,11.285},{-8.714,-4.463},{-0.212,4.039}}},np.float64)
  local r=np.partition(a,4,2)
  assert(r.dtype=="float64","partition 6 dtype")
  assert(eq(r.shape,{5,4,2}),"partition 6 shape")
  assert(eq(r.strides,{64,16,8}),"partition 6 strides")
  assert(close(np.sort(r,2):tolist(),{{{-7.748,-11.999},{0.754,-10.743},{8.0,-3.497},{9.256,5.005}},{{-6.492,-9.487},{-5.236,-2.241},{2.01,-0.985},{10.512,6.261}},{{-3.98,-8.231},{3.266,0.271},{4.522,7.517},{11.768,8.773}},{{-11.226,-6.975},{-9.97,-5.719},{-2.724,1.527},{5.778,10.029}},{{-8.714,-4.463},{-1.468,2.783},{-0.212,4.039},{7.034,11.285}}}),"partition 6 multiset")
end
do -- partition 7
  local a=np.array({{-17,20,57,94},{-120,-83,-46,-9},{28,65,102,-112},{-75,-38,-1,36},{73,110,-104,-67},{-30,7,44,81}},np.int16)
  local r=np.partition(a,2,2)
  assert(r.dtype=="int16","partition 7 dtype")
  assert(eq(r.shape,{6,4}),"partition 7 shape")
  assert(eq(r.strides,{8,2}),"partition 7 strides")
  assert(close(np.sort(r,2):tolist(),{{-17,20,57,94},{-120,-83,-46,-9},{-112,28,65,102},{-75,-38,-1,36},{-104,-67,73,110},{-30,7,44,81}}),"partition 7 multiset")
end
do -- partition 8
  local a=np.array({{{119,156},{193,230},{16,53},{90,127}},{{164,201},{238,24},{61,98},{135,172}}},np.uint32)
  local r=np.partition(a,1,2)
  assert(r.dtype=="uint32","partition 8 dtype")
  assert(eq(r.shape,{2,4,2}),"partition 8 shape")
  assert(eq(r.strides,{32,8,4}),"partition 8 strides")
  assert(close(np.sort(r,2):tolist(),{{{16,53},{90,127},{119,156},{193,230}},{{61,24},{135,98},{164,172},{238,201}}}),"partition 8 multiset")
end
do -- partition 9
  local a=np.array({{{5,42,79},{116,-98,-61},{-24,13,50},{87,124,-90},{-53,-16,21},{58,95,-119}},{{-82,-45,-8},{29,66,103},{-111,-74,-37},{0,37,74},{111,-103,-66},{-29,8,45}},{{82,119,-95},{-58,-21,16},{53,90,-124},{-87,-50,-13},{24,61,98},{-116,-79,-42}},{{-5,32,69},{106,-108,-71},{-34,3,40},{77,114,-100},{-63,-26,11},{48,85,122}},{{-92,-55,-18},{19,56,93},{-121,-84,-47},{-10,27,64},{101,-113,-76},{-39,-2,35}},{{72,109,-105},{-68,-31,6},{43,80,117},{-97,-60,-23},{14,51,88},{125,-89,-52}}},np.int8)
  local r=np.partition(a,2,1)
  assert(r.dtype=="int8","partition 9 dtype")
  assert(eq(r.shape,{6,6,3}),"partition 9 shape")
  assert(eq(r.strides,{18,3,1}),"partition 9 strides")
  assert(close(np.sort(r,1):tolist(),{{{-92,-55,-105},{-68,-108,-71},{-121,-84,-124},{-97,-60,-100},{-63,-113,-76},{-116,-89,-119}},{{-82,-45,-95},{-58,-98,-61},{-111,-74,-47},{-87,-50,-90},{-53,-103,-66},{-39,-79,-52}},{{-5,32,-18},{19,-31,6},{-34,3,-37},{-10,27,-23},{14,-26,11},{-29,-2,-42}},{{5,42,-8},{29,-21,16},{-24,13,40},{0,37,-13},{24,-16,21},{48,8,35}},{{72,109,69},{106,56,93},{43,80,50},{77,114,64},{101,51,88},{58,85,45}},{{82,119,79},{116,66,103},{53,90,117},{87,124,74},{111,61,98},{125,95,122}}}),"partition 9 multiset")
end
do -- partition 10
  local a=(np.array({{16,53,90,-124,-87},{-50,-13,24,61,98},{-116,-79,-42,-5,32},{69,106,-108,-71,-34},{3,40,77,114,-100},{-63,-26,11,48,85}},np.int32)).T
  local r=np.partition(a,2,1)
  assert(r.dtype=="int32","partition 10 dtype")
  assert(eq(r.shape,{5,6}),"partition 10 shape")
  assert(eq(r.strides,{4,20}),"partition 10 strides")
  assert(close(np.sort(r,1):tolist(),{{-124,-50,-116,-108,-100,-63},{-87,-13,-79,-71,3,-26},{16,24,-42,-34,40,11},{53,61,-5,69,77,48},{90,98,32,106,114,85}}),"partition 10 multiset")
end
do -- partition 11
  local a=np.array({{152,189},{226,12},{49,86},{123,160},{197,234}},np.uint8)
  local r=np.partition(a,1,2)
  assert(r.dtype=="uint8","partition 11 dtype")
  assert(eq(r.shape,{5,2}),"partition 11 shape")
  assert(eq(r.strides,{2,1}),"partition 11 strides")
  assert(close(np.sort(r,2):tolist(),{{152,189},{12,226},{49,86},{123,160},{197,234}}),"partition 11 multiset")
end
do -- partition 12
  local a=np.array({-11.75,-7.499,-3.248,1.003},np.float32)
  local r=np.partition(a,4,1)
  assert(r.dtype=="float32","partition 12 dtype")
  assert(eq(r.shape,{4}),"partition 12 shape")
  assert(eq(r.strides,{4}),"partition 12 strides")
  assert(close(np.sort(r,1):tolist(),{-11.75,-7.499000072479248,-3.247999906539917,1.003000020980835}),"partition 12 multiset")
end
do -- partition 13
  local a=np.array({174,211,248,34},np.uint16)
  local r=np.partition(a,1,1)
  assert(r.dtype=="uint16","partition 13 dtype")
  assert(eq(r.shape,{4}),"partition 13 shape")
  assert(eq(r.strides,{2}),"partition 13 strides")
  assert(close(np.sort(r,1):tolist(),{34,174,211,248}),"partition 13 multiset")
end
do -- partition 14
  local a=np.array({185,222},np.uint16)
  local r=np.partition(a,2,1)
  assert(r.dtype=="uint16","partition 14 dtype")
  assert(eq(r.shape,{2}),"partition 14 shape")
  assert(eq(r.strides,{2}),"partition 14 strides")
  assert(close(np.sort(r,1):tolist(),{185,222}),"partition 14 multiset")
end
do -- partition 15
  local a=np.array({{196,233,19,56},{93,130,167,204},{241,27,64,101},{138,175,212,249},{35,72,109,146}},np.uint16)
  local r=np.partition(a,4,2)
  assert(r.dtype=="uint16","partition 15 dtype")
  assert(eq(r.shape,{5,4}),"partition 15 shape")
  assert(eq(r.strides,{8,2}),"partition 15 strides")
  assert(close(np.sort(r,2):tolist(),{{19,56,196,233},{93,130,167,204},{27,64,101,241},{138,175,212,249},{35,72,109,146}}),"partition 15 multiset")
end
do -- partition 16
  local a=np.array({{82,119,-95},{-58,-21,16},{53,90,-124},{-87,-50,-13}},np.int64)
  local r=np.partition(a,3,2)
  assert(r.dtype=="int64","partition 16 dtype")
  assert(eq(r.shape,{4,3}),"partition 16 shape")
  assert(eq(r.strides,{24,8}),"partition 16 strides")
  assert(close(np.sort(r,2):tolist(),{{-95,82,119},{-58,-21,16},{-124,53,90},{-87,-50,-13}}),"partition 16 multiset")
end
do -- partition 17
  local a=np.array({{93,-121,-84,-47,-10},{27,64,101,-113,-76},{-39,-2,35,72,109},{-105,-68,-31,6,43},{80,117,-97,-60,-23},{14,51,88,125,-89}},np.int16)
  local r=np.partition(a,1,2)
  assert(r.dtype=="int16","partition 17 dtype")
  assert(eq(r.shape,{6,5}),"partition 17 shape")
  assert(eq(r.strides,{10,2}),"partition 17 strides")
  assert(close(np.sort(r,2):tolist(),{{-121,-84,-47,-10,93},{-113,-76,27,64,101},{-39,-2,35,72,109},{-105,-68,-31,6,43},{-97,-60,-23,80,117},{-89,14,51,88,125}}),"partition 17 multiset")
end
do -- partition 18
  local a=np.array({{{-7.25,-2.999,1.252,5.503,9.754,-10.245},{-5.994,-1.743,2.508,6.759,11.01,-8.989},{-4.738,-0.487,3.764,8.015,-11.984,-7.733},{-3.482,0.769,5.02,9.271,-10.728,-6.477},{-2.226,2.025,6.276,10.527,-9.472,-5.221},{-0.97,3.281,7.532,11.783,-8.216,-3.965}},{{0.28600000000000003,4.537,8.788,-11.211,-6.96,-2.709},{1.542,5.793,10.044,-9.955,-5.704,-1.453},{2.798,7.049,11.3,-8.699,-4.448,-0.197},{4.054,8.305,-11.694,-7.443,-3.192,1.059},{5.31,9.561,-10.438,-6.187,-1.936,2.315},{6.566,10.817,-9.182,-4.931,-0.6799999999999999,3.571}},{{7.822,12.073,-7.926,-3.675,0.576,4.827},{9.078,-10.921,-6.67,-2.419,1.832,6.083},{10.334,-9.665,-5.414,-1.163,3.088,7.339},{11.59,-8.409,-4.158,0.093,4.344,8.595},{-11.404,-7.153,-2.902,1.349,5.6,9.851},{-10.148,-5.897,-1.646,2.605,6.856,11.107}}},np.float32)
  local r=np.partition(a,2,1)
  assert(r.dtype=="float32","partition 18 dtype")
  assert(eq(r.shape,{3,6,6}),"partition 18 shape")
  assert(eq(r.strides,{144,24,4}),"partition 18 strides")
  assert(close(np.sort(r,1):tolist(),{{{-7.25,-2.999000072479248,-7.926000118255615,-11.211000442504883,-6.960000038146973,-10.244999885559082},{-5.99399995803833,-10.920999526977539,-6.670000076293945,-9.954999923706055,-5.703999996185303,-8.98900032043457},{-4.73799991607666,-9.664999961853027,-5.414000034332275,-8.699000358581543,-11.984000205993652,-7.732999801635742},{-3.4820001125335693,-8.409000396728516,-11.694000244140625,-7.442999839782715,-10.727999687194824,-6.4770002365112305},{-11.404000282287598,-7.1529998779296875,-10.437999725341797,-6.186999797821045,-9.472000122070312,-5.2210001945495605},{-10.14799976348877,-5.896999835968018,-9.182000160217285,-4.931000232696533,-8.215999603271484,-3.9649999141693115}},{{0.28600001335144043,4.5370001792907715,1.2519999742507935,-3.674999952316284,0.5759999752044678,-2.7090001106262207},{1.5420000553131104,-1.7430000305175781,2.507999897003174,-2.4189999103546143,1.8320000171661377,-1.4529999494552612},{2.7980000972747803,-0.4869999885559082,3.7639999389648438,-1.1629999876022339,-4.447999954223633,-0.19699999690055847},{4.053999900817871,0.7689999938011169,-4.1579999923706055,0.09300000220537186,-3.191999912261963,1.059000015258789},{-2.2260000705718994,2.0250000953674316,-2.9019999504089355,1.3489999771118164,-1.9359999895095825,2.315000057220459},{-0.9700000286102295,3.2809998989105225,-1.6460000276565552,2.6050000190734863,-0.6800000071525574,3.571000099182129}},{{7.822000026702881,12.072999954223633,8.788000106811523,5.502999782562256,9.753999710083008,4.827000141143799},{9.07800006866455,5.793000221252441,10.043999671936035,6.758999824523926,11.010000228881836,6.083000183105469},{10.333999633789062,7.048999786376953,11.300000190734863,8.015000343322754,3.0880000591278076,7.339000225067139},{11.59000015258789,8.305000305175781,5.019999980926514,9.270999908447266,4.343999862670898,8.595000267028809},{5.309999942779541,9.560999870300293,6.276000022888184,10.527000427246094,5.599999904632568,9.85099983215332},{6.565999984741211,10.817000389099121,7.5320000648498535,11.782999992370605,6.855999946594238,11.107000350952148}}}),"partition 18 multiset")
end
do -- partition 19
  local a=(np.array({{240,26,63},{100,137,174}},np.uint32)).T
  local r=np.partition(a,{1,2,3},1)
  assert(r.dtype=="uint32","partition 19 dtype")
  assert(eq(r.shape,{3,2}),"partition 19 shape")
  assert(eq(r.strides,{4,12}),"partition 19 strides")
  assert(close(np.sort(r,1):tolist(),{{26,100},{63,137},{240,174}}),"partition 19 multiset")
end
do -- partition 20
  local a=np.array({{{0,37,74,111},{148,185,222,8},{45,82,119,156},{193,230,16,53},{90,127,164,201},{238,24,61,98}},{{135,172,209,246},{32,69,106,143},{180,217,3,40},{77,114,151,188},{225,11,48,85},{122,159,196,233}},{{19,56,93,130},{167,204,241,27},{64,101,138,175},{212,249,35,72},{109,146,183,220},{6,43,80,117}},{{154,191,228,14},{51,88,125,162},{199,236,22,59},{96,133,170,207},{244,30,67,104},{141,178,215,1}},{{38,75,112,149},{186,223,9,46},{83,120,157,194},{231,17,54,91},{128,165,202,239},{25,62,99,136}},{{173,210,247,33},{70,107,144,181},{218,4,41,78},{115,152,189,226},{12,49,86,123},{160,197,234,20}}},np.uint16)
  local r=np.partition(a,1,2)
  assert(r.dtype=="uint16","partition 20 dtype")
  assert(eq(r.shape,{6,6,4}),"partition 20 shape")
  assert(eq(r.strides,{48,8,2}),"partition 20 strides")
  assert(close(np.sort(r,2):tolist(),{{{0,24,16,8},{45,37,61,53},{90,82,74,98},{148,127,119,111},{193,185,164,156},{238,230,222,201}},{{32,11,3,40},{77,69,48,85},{122,114,106,143},{135,159,151,188},{180,172,196,233},{225,217,209,246}},{{6,43,35,27},{19,56,80,72},{64,101,93,117},{109,146,138,130},{167,204,183,175},{212,249,241,220}},{{51,30,22,1},{96,88,67,14},{141,133,125,59},{154,178,170,104},{199,191,215,162},{244,236,228,207}},{{25,17,9,46},{38,62,54,91},{83,75,99,136},{128,120,112,149},{186,165,157,194},{231,223,202,239}},{{12,4,41,20},{70,49,86,33},{115,107,144,78},{160,152,189,123},{173,197,234,181},{218,210,247,226}}}),"partition 20 multiset")
end
do -- partition 21
  local a=np.array({{true,false,true,false,false},{true,false,true,false,false},{true,false,true,false,false}},np.bool)
  local r=np.partition(a,4,2)
  assert(r.dtype=="bool","partition 21 dtype")
  assert(eq(r.shape,{3,5}),"partition 21 shape")
  assert(eq(r.strides,{5,1}),"partition 21 strides")
  assert(close(np.sort(r,2):tolist(),{{false,false,false,true,true},{false,false,false,true,true},{false,false,false,true,true}}),"partition 21 multiset")
end
do -- partition 22
  local a=np.array({{{-103,-66},{-29,8},{45,82},{119,-95}},{{-58,-21},{16,53},{90,-124},{-87,-50}},{{-13,24},{61,98},{-116,-79},{-42,-5}},{{32,69},{106,-108},{-71,-34},{3,40}},{{77,114},{-100,-63},{-26,11},{48,85}}},np.int64)
  local r=np.partition(a,{3,4,5},1)
  assert(r.dtype=="int64","partition 22 dtype")
  assert(eq(r.shape,{5,4,2}),"partition 22 shape")
  assert(eq(r.strides,{64,16,8}),"partition 22 strides")
  assert(close(np.sort(r,1):tolist(),{{{-103,-66},{-100,-108},{-116,-124},{-87,-95}},{{-58,-21},{-29,-63},{-71,-79},{-42,-50}},{{-13,24},{16,8},{-26,-34},{3,-5}},{{32,69},{61,53},{45,11},{48,40}},{{77,114},{106,98},{90,82},{119,85}}}),"partition 22 multiset")
end
do -- partition 23
  local a=np.array({{{-92,-55,-18,19,56},{93,-121,-84,-47,-10},{27,64,101,-113,-76},{-39,-2,35,72,109},{-105,-68,-31,6,43},{80,117,-97,-60,-23}},{{14,51,88,125,-89},{-52,-15,22,59,96},{-118,-81,-44,-7,30},{67,104,-110,-73,-36},{1,38,75,112,-102},{-65,-28,9,46,83}},{{120,-94,-57,-20,17},{54,91,-123,-86,-49},{-12,25,62,99,-115},{-78,-41,-4,33,70},{107,-107,-70,-33,4},{41,78,115,-99,-62}},{{-25,12,49,86,123},{-91,-54,-17,20,57},{94,-120,-83,-46,-9},{28,65,102,-112,-75},{-38,-1,36,73,110},{-104,-67,-30,7,44}},{{81,118,-96,-59,-22},{15,52,89,-125,-88},{-51,-14,23,60,97},{-117,-80,-43,-6,31},{68,105,-109,-72,-35},{2,39,76,113,-101}}},np.int32)
  local r=np.partition(a,1,2)
  assert(r.dtype=="int32","partition 23 dtype")
  assert(eq(r.shape,{5,6,5}),"partition 23 shape")
  assert(eq(r.strides,{120,20,4}),"partition 23 strides")
  assert(close(np.sort(r,2):tolist(),{{{-105,-121,-97,-113,-76},{-92,-68,-84,-60,-23},{-39,-55,-31,-47,-10},{27,-2,-18,6,43},{80,64,35,19,56},{93,117,101,72,109}},{{-118,-81,-110,-73,-102},{-65,-28,-44,-7,-89},{-52,-15,9,46,-36},{1,38,22,59,30},{14,51,75,112,83},{67,104,88,125,96}},{{-78,-107,-123,-99,-115},{-12,-94,-70,-86,-62},{41,-41,-57,-33,-49},{54,25,-4,-20,4},{107,78,62,33,17},{120,91,115,99,70}},{{-104,-120,-83,-112,-75},{-91,-67,-30,-46,-9},{-38,-54,-17,7,44},{-25,-1,36,20,57},{28,12,49,73,110},{94,65,102,86,123}},{{-117,-80,-109,-125,-101},{-51,-14,-96,-72,-88},{2,39,-43,-59,-35},{15,52,23,-6,-22},{68,105,76,60,31},{81,118,89,113,97}}}),"partition 23 multiset")
end
do -- partition 24
  local a=np.array({{44,81,118,155,192},{229,15,52,89,126},{163,200,237,23,60},{97,134,171,208,245},{31,68,105,142,179}},np.uint16)
  local r=np.partition(a,1,1)
  assert(r.dtype=="uint16","partition 24 dtype")
  assert(eq(r.shape,{5,5}),"partition 24 shape")
  assert(eq(r.strides,{10,2}),"partition 24 strides")
  assert(close(np.sort(r,1):tolist(),{{31,15,52,23,60},{44,68,105,89,126},{97,81,118,142,179},{163,134,171,155,192},{229,200,237,208,245}}),"partition 24 multiset")
end
do -- partition 25
  local a=np.array({-70,-33,4},np.int16)
  local r=np.partition(a,1,1)
  assert(r.dtype=="int16","partition 25 dtype")
  assert(eq(r.shape,{3}),"partition 25 shape")
  assert(eq(r.strides,{2}),"partition 25 strides")
  assert(close(np.sort(r,1):tolist(),{-70,-33,4}),"partition 25 multiset")
end
do -- partition 26
  local a=np.array({{-59,-22,15,52,89,-125},{-88,-51,-14,23,60,97},{-117,-80,-43,-6,31,68},{105,-109,-72,-35,2,39}},np.int8)
  local r=np.partition(a,1,2)
  assert(r.dtype=="int8","partition 26 dtype")
  assert(eq(r.shape,{4,6}),"partition 26 shape")
  assert(eq(r.strides,{6,1}),"partition 26 strides")
  assert(close(np.sort(r,2):tolist(),{{-125,-59,-22,15,52,89},{-88,-51,-14,23,60,97},{-117,-80,-43,-6,31,68},{-109,-72,-35,2,39,105}}),"partition 26 multiset")
end
do -- partition 27
  local a=np.array({{-0.5,3.751},{8.002,-11.997},{-7.746,-3.495},{0.756,5.007},{9.258,-10.741}},np.float32)
  local r=np.partition(a,5,1)
  assert(r.dtype=="float32","partition 27 dtype")
  assert(eq(r.shape,{5,2}),"partition 27 shape")
  assert(eq(r.strides,{8,4}),"partition 27 strides")
  assert(close(np.sort(r,1):tolist(),{{-7.745999813079834,-11.996999740600586},{-0.5,-10.741000175476074},{0.7559999823570251,-3.494999885559082},{8.001999855041504,3.750999927520752},{9.258000373840332,5.006999969482422}}),"partition 27 multiset")
end
do -- partition 28
  local a=np.array({{88,125,162,199,236,22},{59,96,133,170,207,244},{30,67,104,141,178,215},{1,38,75,112,149,186},{223,9,46,83,120,157}},np.uint32)
  local r=np.partition(a,1,2)
  assert(r.dtype=="uint32","partition 28 dtype")
  assert(eq(r.shape,{5,6}),"partition 28 shape")
  assert(eq(r.strides,{24,4}),"partition 28 strides")
  assert(close(np.sort(r,2):tolist(),{{22,88,125,162,199,236},{59,96,133,170,207,244},{30,67,104,141,178,215},{1,38,75,112,149,186},{9,46,83,120,157,223}}),"partition 28 multiset")
end
do -- partition 29
  local a=np.array({{{false,true},{false,true},{false,false}},{{true,false},{true,false},{false,true}},{{false,true},{false,false},{true,false}},{{true,false},{false,true},{false,true}},{{false,false},{true,false},{true,false}},{{false,true},{false,true},{false,false}}},np.bool)
  local r=np.partition(a,3,2)
  assert(r.dtype=="bool","partition 29 dtype")
  assert(eq(r.shape,{6,3,2}),"partition 29 shape")
  assert(eq(r.strides,{6,2,1}),"partition 29 strides")
  assert(close(np.sort(r,2):tolist(),{{{false,false},{false,true},{false,true}},{{false,false},{true,false},{true,true}},{{false,false},{false,false},{true,true}},{{false,false},{false,true},{true,true}},{{false,false},{true,false},{true,false}},{{false,false},{false,true},{false,true}}}),"partition 29 multiset")
end
do -- partition 30
  local a=np.array({{-15,22,59},{96,-118,-81},{-44,-7,30},{67,104,-110},{-73,-36,1},{38,75,112}},np.int32)
  local r=np.partition(a,1,1)
  assert(r.dtype=="int32","partition 30 dtype")
  assert(eq(r.shape,{6,3}),"partition 30 shape")
  assert(eq(r.strides,{12,4}),"partition 30 strides")
  assert(close(np.sort(r,1):tolist(),{{-73,-118,-110},{-44,-36,-81},{-15,-7,1},{38,22,30},{67,75,59},{96,104,112}}),"partition 30 multiset")
end
do -- partition 31
  local a=np.array({{-4,33,70,107,-107,-70},{-33,4,41,78,115,-99},{-62,-25,12,49,86,123},{-91,-54,-17,20,57,94},{-120,-83,-46,-9,28,65}},np.int32)
  local r=np.partition(a,{2,3,6},2)
  assert(r.dtype=="int32","partition 31 dtype")
  assert(eq(r.shape,{5,6}),"partition 31 shape")
  assert(eq(r.strides,{24,4}),"partition 31 strides")
  assert(close(np.sort(r,2):tolist(),{{-107,-70,-4,33,70,107},{-99,-33,4,41,78,115},{-62,-25,12,49,86,123},{-91,-54,-17,20,57,94},{-120,-83,-46,-9,28,65}}),"partition 31 multiset")
end
do -- partition 32
  local a=(np.array({{3.25,7.501,11.752,-8.247,-3.996,0.255},{4.506,8.757,-11.242,-6.991,-2.74,1.511},{5.762,10.013,-9.986,-5.735,-1.484,2.767},{7.018,11.269,-8.73,-4.479,-0.228,4.023},{8.274,-11.725,-7.474,-3.223,1.028,5.279}},np.float32)).T
  local r=np.partition(a,{2,3,5},2)
  assert(r.dtype=="float32","partition 32 dtype")
  assert(eq(r.shape,{6,5}),"partition 32 shape")
  assert(eq(r.strides,{4,24}),"partition 32 strides")
  assert(close(np.sort(r,2):tolist(),{{3.25,4.50600004196167,5.76200008392334,7.01800012588501,8.27400016784668},{-11.725000381469727,7.500999927520752,8.756999969482422,10.012999534606934,11.269000053405762},{-11.241999626159668,-9.986000061035156,-8.729999542236328,-7.473999977111816,11.751999855041504},{-8.246999740600586,-6.991000175476074,-5.735000133514404,-4.479000091552734,-3.2230000495910645},{-3.996000051498413,-2.740000009536743,-1.4839999675750732,-0.2280000001192093,1.027999997138977},{0.2549999952316284,1.5110000371932983,2.7669999599456787,4.0229997634887695,5.2789998054504395}}),"partition 32 multiset")
end
do -- partition 33
  local a=np.array({false,true,false,false,true},np.bool)
  local r=np.partition(a,2,1)
  assert(r.dtype=="bool","partition 33 dtype")
  assert(eq(r.shape,{5}),"partition 33 shape")
  assert(eq(r.strides,{1}),"partition 33 strides")
  assert(close(np.sort(r,1):tolist(),{false,false,false,true,true}),"partition 33 multiset")
end
do -- partition 34
  local a=np.array({29,66,103},np.int16)
  local r=np.partition(a,2,1)
  assert(r.dtype=="int16","partition 34 dtype")
  assert(eq(r.shape,{3}),"partition 34 shape")
  assert(eq(r.strides,{2}),"partition 34 strides")
  assert(close(np.sort(r,1):tolist(),{29,66,103}),"partition 34 multiset")
end
do -- partition 35
  local a=np.array({{165,202,239,25,62,99},{136,173,210,247,33,70},{107,144,181,218,4,41},{78,115,152,189,226,12},{49,86,123,160,197,234}},np.uint16)
  local r=np.partition(a,{2,3,5},1)
  assert(r.dtype=="uint16","partition 35 dtype")
  assert(eq(r.shape,{5,6}),"partition 35 shape")
  assert(eq(r.strides,{12,2}),"partition 35 strides")
  assert(close(np.sort(r,1):tolist(),{{49,86,123,25,4,12},{78,115,152,160,33,41},{107,144,181,189,62,70},{136,173,210,218,197,99},{165,202,239,247,226,234}}),"partition 35 multiset")
end
do -- partition 36
  local a=np.array({51,88},np.int8)
  local r=np.partition(a,1,1)
  assert(r.dtype=="int8","partition 36 dtype")
  assert(eq(r.shape,{2}),"partition 36 shape")
  assert(eq(r.strides,{1}),"partition 36 strides")
  assert(close(np.sort(r,1):tolist(),{51,88}),"partition 36 multiset")
end
do -- partition 37
  local a=(np.array({{187,224,10,47,84},{121,158,195,232,18}},np.uint32)).T
  local r=np.partition(a,{1,2},2)
  assert(r.dtype=="uint32","partition 37 dtype")
  assert(eq(r.shape,{5,2}),"partition 37 shape")
  assert(eq(r.strides,{4,20}),"partition 37 strides")
  assert(close(np.sort(r,2):tolist(),{{121,187},{158,224},{10,195},{47,232},{18,84}}),"partition 37 multiset")
end
do -- partition 38
  local a=np.array({{{198,235},{21,58},{95,132},{169,206},{243,29}},{{66,103},{140,177},{214,0},{37,74},{111,148}},{{185,222},{8,45},{82,119},{156,193},{230,16}},{{53,90},{127,164},{201,238},{24,61},{98,135}},{{172,209},{246,32},{69,106},{143,180},{217,3}},{{40,77},{114,151},{188,225},{11,48},{85,122}}},np.uint8)
  local r=np.partition(a,4,1)
  assert(r.dtype=="uint8","partition 38 dtype")
  assert(eq(r.shape,{6,5,2}),"partition 38 shape")
  assert(eq(r.strides,{10,2,1}),"partition 38 strides")
  assert(close(np.sort(r,1):tolist(),{{{40,77},{8,32},{69,0},{11,48},{85,3}},{{53,90},{21,45},{82,106},{24,61},{98,16}},{{66,103},{114,58},{95,119},{37,74},{111,29}},{{172,209},{127,151},{188,132},{143,180},{217,122}},{{185,222},{140,164},{201,225},{156,193},{230,135}},{{198,235},{246,177},{214,238},{169,206},{243,148}}}),"partition 38 multiset")
end
do -- partition 39
  local a=np.array({{8.5,-11.499,-7.248,-2.997},{1.254,5.505,9.756,-10.243},{-5.992,-1.741,2.51,6.761}},np.float64)
  local r=np.partition(a,3,2)
  assert(r.dtype=="float64","partition 39 dtype")
  assert(eq(r.shape,{3,4}),"partition 39 shape")
  assert(eq(r.strides,{32,8}),"partition 39 strides")
  assert(close(np.sort(r,2):tolist(),{{-11.499,-7.248,-2.997,8.5},{-10.243,1.254,5.505,9.756},{-5.992,-1.741,2.51,6.761}}),"partition 39 multiset")
end
do -- partition 40
  local a=np.array({{{220,6},{43,80},{117,154},{191,228},{14,51}},{{88,125},{162,199},{236,22},{59,96},{133,170}},{{207,244},{30,67},{104,141},{178,215},{1,38}},{{75,112},{149,186},{223,9},{46,83},{120,157}},{{194,231},{17,54},{91,128},{165,202},{239,25}}},np.uint8)
  local r=np.partition(a,{2,3,4},1)
  assert(r.dtype=="uint8","partition 40 dtype")
  assert(eq(r.shape,{5,5,2}),"partition 40 shape")
  assert(eq(r.strides,{10,2,1}),"partition 40 strides")
  assert(close(np.sort(r,1):tolist(),{{{75,6},{17,54},{91,9},{46,83},{1,25}},{{88,112},{30,67},{104,22},{59,96},{14,38}},{{194,125},{43,80},{117,128},{165,202},{120,51}},{{207,231},{149,186},{223,141},{178,215},{133,157}},{{220,244},{162,199},{236,154},{191,228},{239,170}}}),"partition 40 multiset")
end
do -- partition 41
  local a=np.array({10.0,-9.999,-5.748},np.float64)
  local r=np.partition(a,{1,2,3},1)
  assert(r.dtype=="float64","partition 41 dtype")
  assert(eq(r.shape,{3}),"partition 41 shape")
  assert(eq(r.strides,{8}),"partition 41 strides")
  assert(close(np.sort(r,1):tolist(),{-9.999,-5.748,10.0}),"partition 41 multiset")
end
do -- partition 42
  local a=np.array({false,false,true,false},np.bool)
  local r=np.partition(a,{1,3,4},1)
  assert(r.dtype=="bool","partition 42 dtype")
  assert(eq(r.shape,{4}),"partition 42 shape")
  assert(eq(r.strides,{1}),"partition 42 strides")
  assert(close(np.sort(r,1):tolist(),{false,false,false,true}),"partition 42 multiset")
end
do -- partition 43
  local a=np.array({{{2,39,76,113},{150,187,224,10}},{{47,84,121,158},{195,232,18,55}}},np.uint16)
  local r=np.partition(a,2,1)
  assert(r.dtype=="uint16","partition 43 dtype")
  assert(eq(r.shape,{2,2,4}),"partition 43 shape")
  assert(eq(r.strides,{16,8,2}),"partition 43 strides")
  assert(close(np.sort(r,1):tolist(),{{{2,39,76,113},{150,187,18,10}},{{47,84,121,158},{195,232,224,55}}}),"partition 43 multiset")
end
do -- partition 44
  local a=(np.array({{-112,-75,-38},{-1,36,73},{110,-104,-67},{-30,7,44},{81,118,-96}},np.int32)).T
  local r=np.partition(a,1,1)
  assert(r.dtype=="int32","partition 44 dtype")
  assert(eq(r.shape,{3,5}),"partition 44 shape")
  assert(eq(r.strides,{4,12}),"partition 44 strides")
  assert(close(np.sort(r,1):tolist(),{{-112,-1,-104,-30,-96},{-75,36,-67,7,81},{-38,73,110,44,118}}),"partition 44 multiset")
end
do -- partition 45
  local a=np.array({{{-101,-64},{-27,10}},{{47,84},{121,-93}},{{-56,-19},{18,55}},{{92,-122},{-85,-48}},{{-11,26},{63,100}},{{-114,-77},{-40,-3}}},np.int16)
  local r=np.partition(a,1,3)
  assert(r.dtype=="int16","partition 45 dtype")
  assert(eq(r.shape,{6,2,2}),"partition 45 shape")
  assert(eq(r.strides,{8,4,2}),"partition 45 strides")
  assert(close(np.sort(r,3):tolist(),{{{-101,-64},{-27,10}},{{47,84},{-93,121}},{{-56,-19},{18,55}},{{-122,92},{-85,-48}},{{-11,26},{63,100}},{{-114,-77},{-40,-3}}}),"partition 45 multiset")
end
do -- partition 46
  local a=np.array({{-90,-53,-16,21},{58,95,-119,-82},{-45,-8,29,66},{103,-111,-74,-37},{0,37,74,111},{-103,-66,-29,8}},np.int32)
  local r=np.partition(a,3,1)
  assert(r.dtype=="int32","partition 46 dtype")
  assert(eq(r.shape,{6,4}),"partition 46 shape")
  assert(eq(r.strides,{16,4}),"partition 46 strides")
  assert(close(np.sort(r,1):tolist(),{{-103,-111,-119,-82},{-90,-66,-74,-37},{-45,-53,-29,8},{0,-8,-16,21},{58,37,29,66},{103,95,74,111}}),"partition 46 multiset")
end
do -- partition 47
  local a=np.array({{{-79,-42,-5},{32,69,106},{-108,-71,-34},{3,40,77}},{{114,-100,-63},{-26,11,48},{85,122,-92},{-55,-18,19}}},np.int32)
  local r=np.partition(a,{1,2},1)
  assert(r.dtype=="int32","partition 47 dtype")
  assert(eq(r.shape,{2,4,3}),"partition 47 shape")
  assert(eq(r.strides,{48,12,4}),"partition 47 strides")
  assert(close(np.sort(r,1):tolist(),{{{-79,-100,-63},{-26,11,48},{-108,-71,-92},{-55,-18,19}},{{114,-42,-5},{32,69,106},{85,122,-34},{3,40,77}}}),"partition 47 multiset")
end
do -- partition 48
  local a=np.array({{{false,true,false,false,true,false},{true,false,false,true,false,true},{false,false,true,false,true,false}},{{false,true,false,true,false,false},{true,false,true,false,false,true},{false,true,false,false,true,false}}},np.bool)
  local r=np.partition(a,6,3)
  assert(r.dtype=="bool","partition 48 dtype")
  assert(eq(r.shape,{2,3,6}),"partition 48 shape")
  assert(eq(r.strides,{18,6,1}),"partition 48 strides")
  assert(close(np.sort(r,3):tolist(),{{{false,false,false,false,true,true},{false,false,false,true,true,true},{false,false,false,false,true,true}},{{false,false,false,false,true,true},{false,false,false,true,true,true},{false,false,false,false,true,true}}}),"partition 48 multiset")
end
do -- partition 49
  local a=np.array({68,105,142,179,216},np.uint8)
  local r=np.partition(a,4,1)
  assert(r.dtype=="uint8","partition 49 dtype")
  assert(eq(r.shape,{5}),"partition 49 shape")
  assert(eq(r.strides,{1}),"partition 49 strides")
  assert(close(np.sort(r,1):tolist(),{68,105,142,179,216}),"partition 49 multiset")
end
do -- partition 50
  local a=np.array({true,false},np.bool)
  local r=np.partition(a,{1,2},1)
  assert(r.dtype=="bool","partition 50 dtype")
  assert(eq(r.shape,{2}),"partition 50 shape")
  assert(eq(r.strides,{1}),"partition 50 strides")
  assert(close(np.sort(r,1):tolist(),{false,true}),"partition 50 multiset")
end
do -- partition 51
  local a=np.array({{{-6.75,-2.499,1.752,6.003,10.254},{-9.745,-5.494,-1.243,3.008,7.259},{11.51,-8.489,-4.238,0.013000000000000001,4.264},{8.515,-11.484,-7.233,-2.982,1.269}},{{5.52,9.771,-10.228,-5.977,-1.726},{2.525,6.776,11.027,-8.972,-4.721},{-0.47,3.781,8.032,-11.967,-7.716},{-3.465,0.786,5.037,9.288,-10.711}},{{-6.46,-2.209,2.042,6.293,10.544},{-9.455,-5.204,-0.953,3.298,7.549},{11.8,-8.199,-3.948,0.303,4.554},{8.805,-11.194,-6.943,-2.692,1.559}},{{5.81,10.061,-9.938,-5.687,-1.436},{2.815,7.066,11.317,-8.682,-4.431},{-0.18,4.071,8.322,-11.677,-7.426},{-3.175,1.076,5.327,9.578,-10.421}},{{-6.17,-1.919,2.332,6.583,10.834},{-9.165,-4.914,-0.663,3.588,7.839},{12.09,-7.909,-3.658,0.593,4.844},{9.095,-10.904,-6.653,-2.402,1.849}},{{6.1,10.351,-9.648,-5.397,-1.146},{3.105,7.356,11.607,-8.392,-4.141},{0.11,4.361,8.612,-11.387,-7.136},{-2.885,1.366,5.617,9.868,-10.131}}},np.float32)
  local r=np.partition(a,1,1)
  assert(r.dtype=="float32","partition 51 dtype")
  assert(eq(r.shape,{6,4,5}),"partition 51 shape")
  assert(eq(r.strides,{80,20,4}),"partition 51 strides")
  assert(close(np.sort(r,1):tolist(),{{{-6.75,-2.499000072479248,-10.227999687194824,-5.9770002365112305,-1.7259999513626099},{-9.744999885559082,-5.49399995803833,-1.2430000305175781,-8.972000122070312,-4.7210001945495605},{-0.4699999988079071,-8.48900032043457,-4.23799991607666,-11.967000007629395,-7.716000080108643},{-3.4649999141693115,-11.484000205993652,-7.232999801635742,-2.9820001125335693,-10.711000442504883}},{{-6.460000038146973,-2.2090001106262207,-9.937999725341797,-5.686999797821045,-1.4359999895095825},{-9.454999923706055,-5.203999996185303,-0.953000009059906,-8.682000160217285,-4.431000232696533},{-0.18000000715255737,-8.199000358581543,-3.947999954223633,-11.677000045776367,-7.426000118255615},{-3.174999952316284,-11.194000244140625,-6.942999839782715,-2.691999912261963,-10.420999526977539}},{{-6.170000076293945,-1.9190000295639038,-9.64799976348877,-5.396999835968018,-1.1460000276565552},{-9.164999961853027,-4.914000034332275,-0.6629999876022339,-8.392000198364258,-4.140999794006348},{0.10999999940395355,-7.908999919891357,-3.6579999923706055,-11.38700008392334,-7.136000156402588},{-2.884999990463257,-10.904000282287598,-6.6529998779296875,-2.4019999504089355,-10.130999565124512}},{{5.519999980926514,9.770999908447266,1.7519999742507935,6.002999782562256,10.253999710083008},{2.5250000953674316,6.776000022888184,11.027000427246094,3.007999897003174,7.258999824523926},{11.510000228881836,3.7809998989105225,8.031999588012695,0.013000000268220901,4.263999938964844},{8.515000343322754,0.7860000133514404,5.0370001792907715,9.288000106811523,1.2690000534057617}},{{5.809999942779541,10.060999870300293,2.0420000553131104,6.293000221252441,10.543999671936035},{2.815000057220459,7.065999984741211,11.317000389099121,3.2980000972747803,7.548999786376953},{11.800000190734863,4.071000099182129,8.321999549865723,0.30300000309944153,4.553999900817871},{8.805000305175781,1.0759999752044678,5.327000141143799,9.57800006866455,1.559000015258789}},{{6.099999904632568,10.35099983215332,2.3320000171661377,6.583000183105469,10.833999633789062},{3.1050000190734863,7.355999946594238,11.607000350952148,3.5880000591278076,7.839000225067139},{12.09000015258789,4.361000061035156,8.612000465393066,0.5929999947547913,4.843999862670898},{9.095000267028809,1.3660000562667847,5.617000102996826,9.868000030517578,1.8489999771118164}}}),"partition 51 multiset")
end
do -- partition 52
  local a=np.array({{-24,13,50},{87,124,-90},{-53,-16,21},{58,95,-119},{-82,-45,-8},{29,66,103}},np.int16)
  local r=np.partition(a,{1,5,6},1)
  assert(r.dtype=="int16","partition 52 dtype")
  assert(eq(r.shape,{6,3}),"partition 52 shape")
  assert(eq(r.strides,{6,2}),"partition 52 strides")
  assert(close(np.sort(r,1):tolist(),{{-82,-45,-119},{-53,-16,-90},{-24,13,-8},{29,66,21},{58,95,50},{87,124,103}}),"partition 52 multiset")
end
do -- partition 53
  local a=np.array({{-5.25,-0.999,3.252,7.503,11.754,-8.245},{-3.994,0.257,4.508,8.759,-11.24,-6.989},{-2.738,1.513,5.764,10.015,-9.984,-5.733}},np.float64)
  local r=np.partition(a,2,1)
  assert(r.dtype=="float64","partition 53 dtype")
  assert(eq(r.shape,{3,6}),"partition 53 shape")
  assert(eq(r.strides,{48,8}),"partition 53 strides")
  assert(close(np.sort(r,1):tolist(),{{-5.25,-0.999,3.252,7.503,-11.24,-8.245},{-3.994,0.257,4.508,8.759,-9.984,-6.989},{-2.738,1.513,5.764,10.015,11.754,-5.733}}),"partition 53 multiset")
end
do -- partition 54
  local a=np.array({-2,35,72,109},np.int64)
  local r=np.partition(a,1,1)
  assert(r.dtype=="int64","partition 54 dtype")
  assert(eq(r.shape,{4}),"partition 54 shape")
  assert(eq(r.strides,{8}),"partition 54 strides")
  assert(close(np.sort(r,1):tolist(),{-2,35,72,109}),"partition 54 multiset")
end
do -- partition 55
  local a=(np.array({{true,false,false,true},{false,true,false,false},{true,false,true,false},{false,true,false,true},{false,false,true,false}},np.bool)).T
  local r=np.partition(a,{1,4,5},2)
  assert(r.dtype=="bool","partition 55 dtype")
  assert(eq(r.shape,{4,5}),"partition 55 shape")
  assert(eq(r.strides,{1,4}),"partition 55 strides")
  assert(close(np.sort(r,2):tolist(),{{false,false,false,true,true},{false,false,false,true,true},{false,false,false,true,true},{false,false,false,true,true}}),"partition 55 multiset")
end
do -- partition 56
  local a=np.array({{{145,182},{219,5},{42,79},{116,153},{190,227},{13,50}},{{87,124},{161,198},{235,21},{58,95},{132,169},{206,243}},{{29,66},{103,140},{177,214},{0,37},{74,111},{148,185}}},np.uint8)
  local r=np.partition(a,5,2)
  assert(r.dtype=="uint8","partition 56 dtype")
  assert(eq(r.shape,{3,6,2}),"partition 56 shape")
  assert(eq(r.strides,{12,2,1}),"partition 56 strides")
  assert(close(np.sort(r,2):tolist(),{{{13,5},{42,50},{116,79},{145,153},{190,182},{219,227}},{{58,21},{87,95},{132,124},{161,169},{206,198},{235,243}},{{0,37},{29,66},{74,111},{103,140},{148,185},{177,214}}}),"partition 56 multiset")
end
do -- partition 57
  local a=(np.array({{-2.25,2.001,6.252,10.503,-9.496},{-5.245,-0.994,3.257,7.508,11.759},{-8.24,-3.989,0.262,4.513,8.764},{-11.235,-6.984,-2.733,1.518,5.769}},np.float32)).T
  local r=np.partition(a,{1,2,4},2)
  assert(r.dtype=="float32","partition 57 dtype")
  assert(eq(r.shape,{5,4}),"partition 57 shape")
  assert(eq(r.strides,{4,20}),"partition 57 strides")
  assert(close(np.sort(r,2):tolist(),{{-11.234999656677246,-8.239999771118164,-5.244999885559082,-2.25},{-6.984000205993652,-3.989000082015991,-0.9940000176429749,2.000999927520752},{-2.7330000400543213,0.2619999945163727,3.256999969482422,6.251999855041504},{1.5180000066757202,4.513000011444092,7.507999897003174,10.503000259399414},{-9.496000289916992,5.769000053405762,8.763999938964844,11.758999824523926}}),"partition 57 multiset")
end
do -- partition 58
  local a=np.array({167,204,241,27},np.uint8)
  local r=np.partition(a,{2,3,4},1)
  assert(r.dtype=="uint8","partition 58 dtype")
  assert(eq(r.shape,{4}),"partition 58 shape")
  assert(eq(r.strides,{1}),"partition 58 strides")
  assert(close(np.sort(r,1):tolist(),{27,167,204,241}),"partition 58 multiset")
end
do -- partition 59
  local a=np.array({178,215,1,38,75,112},np.uint8)
  local r=np.partition(a,3,1)
  assert(r.dtype=="uint8","partition 59 dtype")
  assert(eq(r.shape,{6}),"partition 59 shape")
  assert(eq(r.strides,{1}),"partition 59 strides")
  assert(close(np.sort(r,1):tolist(),{1,38,75,112,178,215}),"partition 59 multiset")
end
do -- partition 60
  local a=np.array({{64,101,-113},{-76,-39,-2},{35,72,109},{-105,-68,-31}},np.int64)
  local r=np.partition(a,{1,3,4},1)
  assert(r.dtype=="int64","partition 60 dtype")
  assert(eq(r.shape,{4,3}),"partition 60 shape")
  assert(eq(r.strides,{24,8}),"partition 60 strides")
  assert(close(np.sort(r,1):tolist(),{{-105,-68,-113},{-76,-39,-31},{35,72,-2},{64,101,109}}),"partition 60 multiset")
end
do -- partition 61
  local a=np.array({{{200,237,23,60,97,134},{171,208,245,31,68,105},{142,179,216,2,39,76},{113,150,187,224,10,47},{84,121,158,195,232,18},{55,92,129,166,203,240}},{{26,63,100,137,174,211},{248,34,71,108,145,182},{219,5,42,79,116,153},{190,227,13,50,87,124},{161,198,235,21,58,95},{132,169,206,243,29,66}},{{103,140,177,214,0,37},{74,111,148,185,222,8},{45,82,119,156,193,230},{16,53,90,127,164,201},{238,24,61,98,135,172},{209,246,32,69,106,143}},{{180,217,3,40,77,114},{151,188,225,11,48,85},{122,159,196,233,19,56},{93,130,167,204,241,27},{64,101,138,175,212,249},{35,72,109,146,183,220}},{{6,43,80,117,154,191},{228,14,51,88,125,162},{199,236,22,59,96,133},{170,207,244,30,67,104},{141,178,215,1,38,75},{112,149,186,223,9,46}}},np.uint16)
  local r=np.partition(a,4,2)
  assert(r.dtype=="uint16","partition 61 dtype")
  assert(eq(r.shape,{5,6,6}),"partition 61 shape")
  assert(eq(r.strides,{72,12,2}),"partition 61 strides")
  assert(close(np.sort(r,2):tolist(),{{{55,92,23,2,10,18},{84,121,129,31,39,47},{113,150,158,60,68,76},{142,179,187,166,97,105},{171,208,216,195,203,134},{200,237,245,224,232,240}},{{26,5,13,21,29,66},{132,34,42,50,58,95},{161,63,71,79,87,124},{190,169,100,108,116,153},{219,198,206,137,145,182},{248,227,235,243,174,211}},{{16,24,32,69,0,8},{45,53,61,98,106,37},{74,82,90,127,135,143},{103,111,119,156,164,172},{209,140,148,185,193,201},{238,246,177,214,222,230}},{{35,72,3,11,19,27},{64,101,109,40,48,56},{93,130,138,146,77,85},{122,159,167,175,183,114},{151,188,196,204,212,220},{180,217,225,233,241,249}},{{6,14,22,1,9,46},{112,43,51,30,38,75},{141,149,80,59,67,104},{170,178,186,88,96,133},{199,207,215,117,125,162},{228,236,244,223,154,191}}}),"partition 61 multiset")
end
do -- partition 62
  local a=np.array({{{211,248,34,71,108,145},{182,219,5,42,79,116},{153,190,227,13,50,87}},{{124,161,198,235,21,58},{95,132,169,206,243,29},{66,103,140,177,214,0}},{{37,74,111,148,185,222},{8,45,82,119,156,193},{230,16,53,90,127,164}},{{201,238,24,61,98,135},{172,209,246,32,69,106},{143,180,217,3,40,77}},{{114,151,188,225,11,48},{85,122,159,196,233,19},{56,93,130,167,204,241}},{{27,64,101,138,175,212},{249,35,72,109,146,183},{220,6,43,80,117,154}}},np.uint16)
  local r=np.partition(a,2,1)
  assert(r.dtype=="uint16","partition 62 dtype")
  assert(eq(r.shape,{6,3,6}),"partition 62 shape")
  assert(eq(r.strides,{36,12,2}),"partition 62 strides")
  assert(close(np.sort(r,1):tolist(),{{{27,64,24,61,11,48},{8,35,5,32,69,19},{56,6,43,3,40,0}},{{37,74,34,71,21,58},{85,45,72,42,79,29},{66,16,53,13,50,77}},{{114,151,101,138,98,135},{95,122,82,109,146,106},{143,93,130,80,117,87}},{{124,161,111,148,108,145},{172,132,159,119,156,116},{153,103,140,90,127,154}},{{201,238,188,225,175,212},{182,209,169,196,233,183},{220,180,217,167,204,164}},{{211,248,198,235,185,222},{249,219,246,206,243,193},{230,190,227,177,214,241}}}),"partition 62 multiset")
end
do -- partition 63
  local a=np.array({222,8},np.uint8)
  local r=np.partition(a,1,1)
  assert(r.dtype=="uint8","partition 63 dtype")
  assert(eq(r.shape,{2}),"partition 63 shape")
  assert(eq(r.strides,{1}),"partition 63 strides")
  assert(close(np.sort(r,1):tolist(),{8,222}),"partition 63 multiset")
end
do -- partition 64
  local a=np.array({{233,19,56,93},{130,167,204,241},{27,64,101,138},{175,212,249,35},{72,109,146,183}},np.uint16)
  local r=np.partition(a,{1,2,5},1)
  assert(r.dtype=="uint16","partition 64 dtype")
  assert(eq(r.shape,{5,4}),"partition 64 shape")
  assert(eq(r.strides,{8,2}),"partition 64 strides")
  assert(close(np.sort(r,1):tolist(),{{27,19,56,35},{72,64,101,93},{130,109,146,138},{175,167,204,183},{233,212,249,241}}),"partition 64 multiset")
end
do -- partition 65
  local a=np.array({{{119,-95,-58},{-21,16,53},{90,-124,-87},{-50,-13,24},{61,98,-116}},{{-79,-42,-5},{32,69,106},{-108,-71,-34},{3,40,77},{114,-100,-63}},{{-26,11,48},{85,122,-92},{-55,-18,19},{56,93,-121},{-84,-47,-10}},{{27,64,101},{-113,-76,-39},{-2,35,72},{109,-105,-68},{-31,6,43}},{{80,117,-97},{-60,-23,14},{51,88,125},{-89,-52,-15},{22,59,96}}},np.int16)
  local r=np.partition(a,2,3)
  assert(r.dtype=="int16","partition 65 dtype")
  assert(eq(r.shape,{5,5,3}),"partition 65 shape")
  assert(eq(r.strides,{30,6,2}),"partition 65 strides")
  assert(close(np.sort(r,3):tolist(),{{{-95,-58,119},{-21,16,53},{-124,-87,90},{-50,-13,24},{-116,61,98}},{{-79,-42,-5},{32,69,106},{-108,-71,-34},{3,40,77},{-100,-63,114}},{{-26,11,48},{-92,85,122},{-55,-18,19},{-121,56,93},{-84,-47,-10}},{{27,64,101},{-113,-76,-39},{-2,35,72},{-105,-68,109},{-31,6,43}},{{-97,80,117},{-60,-23,14},{51,88,125},{-89,-52,-15},{22,59,96}}}),"partition 65 multiset")
end
do -- partition 66
  local a=np.array({{-121,-84,-47,-10,27},{64,101,-113,-76,-39},{-2,35,72,109,-105},{-68,-31,6,43,80},{117,-97,-60,-23,14},{51,88,125,-89,-52}},np.int32)
  local r=np.partition(a,{3,5,6},1)
  assert(r.dtype=="int32","partition 66 dtype")
  assert(eq(r.shape,{6,5}),"partition 66 shape")
  assert(eq(r.strides,{20,4}),"partition 66 strides")
  assert(close(np.sort(r,1):tolist(),{{-121,-97,-113,-89,-105},{-68,-84,-60,-76,-52},{-2,-31,-47,-23,-39},{51,35,6,-10,14},{64,88,72,43,27},{117,101,125,109,80}}),"partition 66 multiset")
end
do -- partition 67
  local a=np.array({15,52,89},np.uint32)
  local r=np.partition(a,3,1)
  assert(r.dtype=="uint32","partition 67 dtype")
  assert(eq(r.shape,{3}),"partition 67 shape")
  assert(eq(r.strides,{4}),"partition 67 strides")
  assert(close(np.sort(r,1):tolist(),{15,52,89}),"partition 67 multiset")
end
do -- partition 68
  local a=np.array({26,63,100,137,174},np.uint32)
  local r=np.partition(a,{2,3,4},1)
  assert(r.dtype=="uint32","partition 68 dtype")
  assert(eq(r.shape,{5}),"partition 68 shape")
  assert(eq(r.strides,{4}),"partition 68 strides")
  assert(close(np.sort(r,1):tolist(),{26,63,100,137,174}),"partition 68 multiset")
end
do -- partition 69
  local a=np.array({-88,-51,-14},np.int32)
  local r=np.partition(a,2,1)
  assert(r.dtype=="int32","partition 69 dtype")
  assert(eq(r.shape,{3}),"partition 69 shape")
  assert(eq(r.strides,{4}),"partition 69 strides")
  assert(close(np.sort(r,1):tolist(),{-88,-51,-14}),"partition 69 multiset")
end
do -- partition 70
  local a=np.array({{7.5,11.751,-8.248,-3.997,0.254},{4.505,8.756,-11.243,-6.992,-2.741},{1.51,5.761,10.012,-9.987,-5.736},{-1.485,2.766,7.017,11.268,-8.731},{-4.48,-0.229,4.022,8.273,-11.726},{-7.475,-3.224,1.027,5.278,9.529}},np.float64)
  local r=np.partition(a,1,1)
  assert(r.dtype=="float64","partition 70 dtype")
  assert(eq(r.shape,{6,5}),"partition 70 shape")
  assert(eq(r.strides,{40,8}),"partition 70 strides")
  assert(close(np.sort(r,1):tolist(),{{-7.475,-3.224,-11.243,-9.987,-11.726},{-4.48,-0.229,-8.248,-6.992,-8.731},{-1.485,2.766,1.027,-3.997,-5.736},{1.51,5.761,4.022,5.278,-2.741},{4.505,8.756,7.017,8.273,0.254},{7.5,11.751,10.012,11.268,9.529}}),"partition 70 multiset")
end
do -- partition 71
  local a=np.array({-66,-29},np.int16)
  local r=np.partition(a,{1,2},1)
  assert(r.dtype=="int16","partition 71 dtype")
  assert(eq(r.shape,{2}),"partition 71 shape")
  assert(eq(r.strides,{2}),"partition 71 strides")
  assert(close(np.sort(r,1):tolist(),{-66,-29}),"partition 71 multiset")
end
do -- partition 72
  local a=np.array({70,107,144,181},np.uint8)
  local r=np.partition(a,2,1)
  assert(r.dtype=="uint8","partition 72 dtype")
  assert(eq(r.shape,{4}),"partition 72 shape")
  assert(eq(r.strides,{1}),"partition 72 strides")
  assert(close(np.sort(r,1):tolist(),{70,107,144,181}),"partition 72 multiset")
end
do -- partition 73
  local a=np.array({-44,-7,30},np.int64)
  local r=np.partition(a,{1,2,3},1)
  assert(r.dtype=="int64","partition 73 dtype")
  assert(eq(r.shape,{3}),"partition 73 shape")
  assert(eq(r.strides,{8}),"partition 73 strides")
  assert(close(np.sort(r,1):tolist(),{-44,-7,30}),"partition 73 multiset")
end
do -- partition 74
  local a=np.array({92,129,166,203,240},np.uint16)
  local r=np.partition(a,2,1)
  assert(r.dtype=="uint16","partition 74 dtype")
  assert(eq(r.shape,{5}),"partition 74 shape")
  assert(eq(r.strides,{2}),"partition 74 strides")
  assert(close(np.sort(r,1):tolist(),{92,129,166,203,240}),"partition 74 multiset")
end
do -- partition 75
  local a=np.array({{-22,15},{52,89},{-125,-88},{-51,-14},{23,60},{97,-117}},np.int16)
  local r=np.partition(a,1,1)
  assert(r.dtype=="int16","partition 75 dtype")
  assert(eq(r.shape,{6,2}),"partition 75 shape")
  assert(eq(r.strides,{4,2}),"partition 75 strides")
  assert(close(np.sort(r,1):tolist(),{{-125,-117},{-51,-88},{-22,-14},{23,15},{52,60},{97,89}}),"partition 75 multiset")
end
do -- partition 76
  local a=np.array({-11,26,63,100,-114,-77},np.int8)
  local r=np.partition(a,4,1)
  assert(r.dtype=="int8","partition 76 dtype")
  assert(eq(r.shape,{6}),"partition 76 shape")
  assert(eq(r.strides,{1}),"partition 76 strides")
  assert(close(np.sort(r,1):tolist(),{-114,-77,-11,26,63,100}),"partition 76 multiset")
end
do -- partition 77
  local a=np.array({{false,false,true},{false,true,false},{false,true,false},{true,false,false},{true,false,true},{false,false,true}},np.bool)
  local r=np.partition(a,5,1)
  assert(r.dtype=="bool","partition 77 dtype")
  assert(eq(r.shape,{6,3}),"partition 77 shape")
  assert(eq(r.strides,{3,1}),"partition 77 strides")
  assert(close(np.sort(r,1):tolist(),{{false,false,false},{false,false,false},{false,false,false},{false,false,true},{true,true,true},{true,true,true}}),"partition 77 multiset")
end
do -- partition 78
  local a=np.array({{{11,48,85,122},{-92,-55,-18,19},{56,93,-121,-84},{-47,-10,27,64}},{{101,-113,-76,-39},{-2,35,72,109},{-105,-68,-31,6},{43,80,117,-97}},{{-60,-23,14,51},{88,125,-89,-52},{-15,22,59,96},{-118,-81,-44,-7}},{{30,67,104,-110},{-73,-36,1,38},{75,112,-102,-65},{-28,9,46,83}},{{120,-94,-57,-20},{17,54,91,-123},{-86,-49,-12,25},{62,99,-115,-78}}},np.int64)
  local r=np.partition(a,{1,2,5},1)
  assert(r.dtype=="int64","partition 78 dtype")
  assert(eq(r.shape,{5,4,4}),"partition 78 shape")
  assert(eq(r.strides,{128,32,8}),"partition 78 strides")
  assert(close(np.sort(r,1):tolist(),{{{-60,-113,-76,-110},{-92,-55,-89,-123},{-105,-68,-121,-84},{-118,-81,-115,-97}},{{11,-94,-57,-39},{-73,-36,-18,-52},{-86,-49,-102,-65},{-47,-10,-44,-78}},{{30,-23,14,-20},{-2,35,1,19},{-15,22,-31,6},{-28,9,27,-7}},{{101,48,85,51},{17,54,72,38},{56,93,-12,25},{43,80,46,64}},{{120,67,104,122},{88,125,91,109},{75,112,59,96},{62,99,117,83}}}),"partition 78 multiset")
end
do -- partition 79
  local a=np.array({{-10.0,-5.749,-1.498,2.753,7.004,11.255},{-8.744,-4.493,-0.242,4.009,8.26,-11.739},{-7.488,-3.237,1.014,5.265,9.516,-10.483},{-6.232,-1.981,2.27,6.521,10.772,-9.227},{-4.976,-0.725,3.526,7.777,12.028,-7.971}},np.float32)
  local r=np.partition(a,{2,3,5},2)
  assert(r.dtype=="float32","partition 79 dtype")
  assert(eq(r.shape,{5,6}),"partition 79 shape")
  assert(eq(r.strides,{24,4}),"partition 79 strides")
  assert(close(np.sort(r,2):tolist(),{{-10.0,-5.749000072479248,-1.4980000257492065,2.753000020980835,7.004000186920166,11.255000114440918},{-11.73900032043457,-8.744000434875488,-4.493000030517578,-0.24199999868869781,4.008999824523926,8.260000228881836},{-10.482999801635742,-7.48799991607666,-3.236999988555908,1.0140000581741333,5.264999866485596,9.515999794006348},{-9.22700023651123,-6.23199987411499,-1.9809999465942383,2.2699999809265137,6.520999908447266,10.772000312805176},{-7.9710001945495605,-4.97599983215332,-0.7250000238418579,3.5260000228881836,7.7769999504089355,12.027999877929688}}),"partition 79 multiset")
end
do -- partition 80
  local a=np.array({158,195,232,18,55,92},np.uint32)
  local r=np.partition(a,{1,3,6},1)
  assert(r.dtype=="uint32","partition 80 dtype")
  assert(eq(r.shape,{6}),"partition 80 shape")
  assert(eq(r.strides,{4}),"partition 80 strides")
  assert(close(np.sort(r,1):tolist(),{18,55,92,158,195,232}),"partition 80 multiset")
end
do -- partition 81
  local a=np.array({{{true,false,true},{false,false,true},{false,true,false},{false,true,false}},{{true,false,false},{true,false,true},{false,false,true},{false,true,false}},{{false,true,false},{true,false,false},{true,false,true},{false,false,true}},{{false,true,false},{false,true,false},{true,false,false},{true,false,true}}},np.bool)
  local r=np.partition(a,4,1)
  assert(r.dtype=="bool","partition 81 dtype")
  assert(eq(r.shape,{4,4,3}),"partition 81 shape")
  assert(eq(r.strides,{12,3,1}),"partition 81 strides")
  assert(close(np.sort(r,1):tolist(),{{{false,false,false},{false,false,false},{false,false,false},{false,false,false}},{{false,false,false},{false,false,false},{false,false,false},{false,false,false}},{{true,true,false},{true,false,true},{true,false,true},{false,true,true}},{{true,true,true},{true,true,true},{true,true,true},{true,true,true}}}),"partition 81 multiset")
end
do -- partition 82
  local a=np.array({{55,92,-122,-85},{-48,-11,26,63},{100,-114,-77,-40},{-3,34,71,108},{-106,-69,-32,5}},np.int8)
  local r=np.partition(a,3,1)
  assert(r.dtype=="int8","partition 82 dtype")
  assert(eq(r.shape,{5,4}),"partition 82 shape")
  assert(eq(r.strides,{4,1}),"partition 82 strides")
  assert(close(np.sort(r,1):tolist(),{{-106,-114,-122,-85},{-48,-69,-77,-40},{-3,-11,-32,5},{55,34,26,63},{100,92,71,108}}),"partition 82 multiset")
end
do -- partition 83
  local a=(np.array({{191,228,14},{51,88,125}},np.uint32)).T
  local r=np.partition(a,{1,2,3},1)
  assert(r.dtype=="uint32","partition 83 dtype")
  assert(eq(r.shape,{3,2}),"partition 83 shape")
  assert(eq(r.strides,{4,12}),"partition 83 strides")
  assert(close(np.sort(r,1):tolist(),{{14,51},{191,88},{228,125}}),"partition 83 multiset")
end
do -- partition 84
  local a=np.array({{{-6.25,-1.999,2.252},{6.503,10.754,-9.245},{-4.994,-0.743,3.508},{7.759,12.01,-7.989},{-3.738,0.513,4.764},{9.015,-10.984,-6.733}},{{-2.482,1.769,6.02},{10.271,-9.728,-5.477},{-1.226,3.025,7.276},{11.527,-8.472,-4.221},{0.03,4.281,8.532},{-11.467,-7.216,-2.965}}},np.float64)
  local r=np.partition(a,1,3)
  assert(r.dtype=="float64","partition 84 dtype")
  assert(eq(r.shape,{2,6,3}),"partition 84 shape")
  assert(eq(r.strides,{144,24,8}),"partition 84 strides")
  assert(close(np.sort(r,3):tolist(),{{{-6.25,-1.999,2.252},{-9.245,6.503,10.754},{-4.994,-0.743,3.508},{-7.989,7.759,12.01},{-3.738,0.513,4.764},{-10.984,-6.733,9.015}},{{-2.482,1.769,6.02},{-9.728,-5.477,10.271},{-1.226,3.025,7.276},{-8.472,-4.221,11.527},{0.03,4.281,8.532},{-11.467,-7.216,-2.965}}}),"partition 84 multiset")
end
do -- partition 85
  local a=np.array({{{213,250,36,73},{110,147,184,221},{7,44,81,118},{155,192,229,15},{52,89,126,163},{200,237,23,60}},{{97,134,171,208},{245,31,68,105},{142,179,216,2},{39,76,113,150},{187,224,10,47},{84,121,158,195}},{{232,18,55,92},{129,166,203,240},{26,63,100,137},{174,211,248,34},{71,108,145,182},{219,5,42,79}}},np.uint8)
  local r=np.partition(a,4,3)
  assert(r.dtype=="uint8","partition 85 dtype")
  assert(eq(r.shape,{3,6,4}),"partition 85 shape")
  assert(eq(r.strides,{24,4,1}),"partition 85 strides")
  assert(close(np.sort(r,3):tolist(),{{{36,73,213,250},{110,147,184,221},{7,44,81,118},{15,155,192,229},{52,89,126,163},{23,60,200,237}},{{97,134,171,208},{31,68,105,245},{2,142,179,216},{39,76,113,150},{10,47,187,224},{84,121,158,195}},{{18,55,92,232},{129,166,203,240},{26,63,100,137},{34,174,211,248},{71,108,145,182},{5,42,79,219}}}),"partition 85 multiset")
end
do -- partition 86
  local a=np.array({-4.75,-0.499},np.float32)
  local r=np.partition(a,1,1)
  assert(r.dtype=="float32","partition 86 dtype")
  assert(eq(r.shape,{2}),"partition 86 shape")
  assert(eq(r.strides,{4}),"partition 86 strides")
  assert(close(np.sort(r,1):tolist(),{-4.75,-0.49900001287460327}),"partition 86 multiset")
end
do -- partition 87
  local a=np.array({110,-104,-67,-30,7,44},np.int32)
  local r=np.partition(a,5,1)
  assert(r.dtype=="int32","partition 87 dtype")
  assert(eq(r.shape,{6}),"partition 87 shape")
  assert(eq(r.strides,{4}),"partition 87 strides")
  assert(close(np.sort(r,1):tolist(),{-104,-67,-30,7,44,110}),"partition 87 multiset")
end
do -- partition 88
  local a=np.array({{{false,true,false,false},{true,false,true,false},{false,true,false,true},{false,false,true,false},{true,false,false,true},{false,true,false,false}},{{true,false,true,false},{false,true,false,true},{false,false,true,false},{true,false,false,true},{false,true,false,false},{true,false,true,false}},{{false,true,false,true},{false,false,true,false},{true,false,false,true},{false,true,false,false},{true,false,true,false},{false,true,false,true}},{{false,false,true,false},{true,false,false,true},{false,true,false,false},{true,false,true,false},{false,true,false,true},{false,false,true,false}}},np.bool)
  local r=np.partition(a,1,3)
  assert(r.dtype=="bool","partition 88 dtype")
  assert(eq(r.shape,{4,6,4}),"partition 88 shape")
  assert(eq(r.strides,{24,4,1}),"partition 88 strides")
  assert(close(np.sort(r,3):tolist(),{{{false,false,false,true},{false,false,true,true},{false,false,true,true},{false,false,false,true},{false,false,true,true},{false,false,false,true}},{{false,false,true,true},{false,false,true,true},{false,false,false,true},{false,false,true,true},{false,false,false,true},{false,false,true,true}},{{false,false,true,true},{false,false,false,true},{false,false,true,true},{false,false,false,true},{false,false,true,true},{false,false,true,true}},{{false,false,false,true},{false,false,true,true},{false,false,false,true},{false,false,true,true},{false,false,true,true},{false,false,false,true}}}),"partition 88 multiset")
end
do -- partition 89
  local a=(np.array({{-2.5,1.751,6.002,10.253},{-9.746,-5.495,-1.244,3.007},{7.258,11.509,-8.49,-4.239},{0.012,4.263,8.514,-11.485}},np.float64)).T
  local r=np.partition(a,3,1)
  assert(r.dtype=="float64","partition 89 dtype")
  assert(eq(r.shape,{4,4}),"partition 89 shape")
  assert(eq(r.strides,{8,32}),"partition 89 strides")
  assert(close(np.sort(r,1):tolist(),{{-2.5,-9.746,-8.49,-11.485},{1.751,-5.495,-4.239,0.012},{6.002,-1.244,7.258,4.263},{10.253,3.007,11.509,8.514}}),"partition 89 multiset")
end
do -- partition 90
  local a=np.array({{{true,false},{false,true},{false,true}},{{false,false},{true,false},{true,false}},{{false,true},{false,true},{false,false}}},np.bool)
  local r=np.partition(a,2,3)
  assert(r.dtype=="bool","partition 90 dtype")
  assert(eq(r.shape,{3,3,2}),"partition 90 shape")
  assert(eq(r.strides,{6,2,1}),"partition 90 strides")
  assert(close(np.sort(r,3):tolist(),{{{false,true},{false,true},{false,true}},{{false,false},{false,true},{false,true}},{{false,true},{false,true},{false,false}}}),"partition 90 multiset")
end
do -- partition 91
  local a=np.array({-97,-60,-23},np.int32)
  local r=np.partition(a,2,1)
  assert(r.dtype=="int32","partition 91 dtype")
  assert(eq(r.shape,{3}),"partition 91 shape")
  assert(eq(r.strides,{4}),"partition 91 strides")
  assert(close(np.sort(r,1):tolist(),{-97,-60,-23}),"partition 91 multiset")
end
do -- partition 92
  local a=np.array({-86,-49,-12,25,62},np.int8)
  local r=np.partition(a,4,1)
  assert(r.dtype=="int8","partition 92 dtype")
  assert(eq(r.shape,{5}),"partition 92 shape")
  assert(eq(r.strides,{1}),"partition 92 strides")
  assert(close(np.sort(r,1):tolist(),{-86,-49,-12,25,62}),"partition 92 multiset")
end
do -- partition 93
  local a=np.array({-75,-38},np.int8)
  local r=np.partition(a,{1,2},1)
  assert(r.dtype=="int8","partition 93 dtype")
  assert(eq(r.shape,{2}),"partition 93 shape")
  assert(eq(r.strides,{1}),"partition 93 strides")
  assert(close(np.sort(r,1):tolist(),{-75,-38}),"partition 93 multiset")
end
do -- partition 94
  local a=np.array({{{1.25,5.501},{9.752,-10.247},{-5.996,-1.745},{2.506,6.757},{11.008,-8.991}},{{-4.74,-0.489},{3.762,8.013},{-11.986,-7.735},{-3.484,0.767},{5.018,9.269}}},np.float64)
  local r=np.partition(a,1,3)
  assert(r.dtype=="float64","partition 94 dtype")
  assert(eq(r.shape,{2,5,2}),"partition 94 shape")
  assert(eq(r.strides,{80,16,8}),"partition 94 strides")
  assert(close(np.sort(r,3):tolist(),{{{1.25,5.501},{-10.247,9.752},{-5.996,-1.745},{2.506,6.757},{-8.991,11.008}},{{-4.74,-0.489},{3.762,8.013},{-11.986,-7.735},{-3.484,0.767},{5.018,9.269}}}),"partition 94 multiset")
end
do -- partition 95
  local a=np.array({{{-53,-16,21,58,95,-119},{-82,-45,-8,29,66,103},{-111,-74,-37,0,37,74},{111,-103,-66,-29,8,45},{82,119,-95,-58,-21,16},{53,90,-124,-87,-50,-13}},{{24,61,98,-116,-79,-42},{-5,32,69,106,-108,-71},{-34,3,40,77,114,-100},{-63,-26,11,48,85,122},{-92,-55,-18,19,56,93},{-121,-84,-47,-10,27,64}},{{101,-113,-76,-39,-2,35},{72,109,-105,-68,-31,6},{43,80,117,-97,-60,-23},{14,51,88,125,-89,-52},{-15,22,59,96,-118,-81},{-44,-7,30,67,104,-110}},{{-73,-36,1,38,75,112},{-102,-65,-28,9,46,83},{120,-94,-57,-20,17,54},{91,-123,-86,-49,-12,25},{62,99,-115,-78,-41,-4},{33,70,107,-107,-70,-33}},{{4,41,78,115,-99,-62},{-25,12,49,86,123,-91},{-54,-17,20,57,94,-120},{-83,-46,-9,28,65,102},{-112,-75,-38,-1,36,73},{110,-104,-67,-30,7,44}},{{81,118,-96,-59,-22,15},{52,89,-125,-88,-51,-14},{23,60,97,-117,-80,-43},{-6,31,68,105,-109,-72},{-35,2,39,76,113,-101},{-64,-27,10,47,84,121}}},np.int8)
  local r=np.partition(a,{2,3,4},3)
  assert(r.dtype=="int8","partition 95 dtype")
  assert(eq(r.shape,{6,6,6}),"partition 95 shape")
  assert(eq(r.strides,{36,6,1}),"partition 95 strides")
  assert(close(np.sort(r,3):tolist(),{{{-119,-53,-16,21,58,95},{-82,-45,-8,29,66,103},{-111,-74,-37,0,37,74},{-103,-66,-29,8,45,111},{-95,-58,-21,16,82,119},{-124,-87,-50,-13,53,90}},{{-116,-79,-42,24,61,98},{-108,-71,-5,32,69,106},{-100,-34,3,40,77,114},{-63,-26,11,48,85,122},{-92,-55,-18,19,56,93},{-121,-84,-47,-10,27,64}},{{-113,-76,-39,-2,35,101},{-105,-68,-31,6,72,109},{-97,-60,-23,43,80,117},{-89,-52,14,51,88,125},{-118,-81,-15,22,59,96},{-110,-44,-7,30,67,104}},{{-73,-36,1,38,75,112},{-102,-65,-28,9,46,83},{-94,-57,-20,17,54,120},{-123,-86,-49,-12,25,91},{-115,-78,-41,-4,62,99},{-107,-70,-33,33,70,107}},{{-99,-62,4,41,78,115},{-91,-25,12,49,86,123},{-120,-54,-17,20,57,94},{-83,-46,-9,28,65,102},{-112,-75,-38,-1,36,73},{-104,-67,-30,7,44,110}},{{-96,-59,-22,15,81,118},{-125,-88,-51,-14,52,89},{-117,-80,-43,23,60,97},{-109,-72,-6,31,68,105},{-101,-35,2,39,76,113},{-64,-27,10,47,84,121}}}),"partition 95 multiset")
end
do -- partition 96
  local a=np.array({83,120,157,194},np.uint8)
  local r=np.partition(a,{2,3,4},1)
  assert(r.dtype=="uint8","partition 96 dtype")
  assert(eq(r.shape,{4}),"partition 96 shape")
  assert(eq(r.strides,{1}),"partition 96 strides")
  assert(close(np.sort(r,1):tolist(),{83,120,157,194}),"partition 96 multiset")
end
do -- partition 97
  local a=(np.array({{-31,6,43,80,117},{-97,-60,-23,14,51},{88,125,-89,-52,-15}},np.int32)).T
  local r=np.partition(a,1,2)
  assert(r.dtype=="int32","partition 97 dtype")
  assert(eq(r.shape,{5,3}),"partition 97 shape")
  assert(eq(r.strides,{4,20}),"partition 97 strides")
  assert(close(np.sort(r,2):tolist(),{{-97,-31,88},{-60,6,125},{-89,-23,43},{-52,14,80},{-15,51,117}}),"partition 97 multiset")
end
do -- partition 98
  local a=np.array({4.25,8.501},np.float64)
  local r=np.partition(a,{1,2},1)
  assert(r.dtype=="float64","partition 98 dtype")
  assert(eq(r.shape,{2}),"partition 98 shape")
  assert(eq(r.strides,{8}),"partition 98 strides")
  assert(close(np.sort(r,1):tolist(),{4.25,8.501}),"partition 98 multiset")
end
do -- partition 99
  local a=np.array({-9,28,65,102,-112},np.int16)
  local r=np.partition(a,{3,4,5},1)
  assert(r.dtype=="int16","partition 99 dtype")
  assert(eq(r.shape,{5}),"partition 99 shape")
  assert(eq(r.strides,{2}),"partition 99 strides")
  assert(close(np.sort(r,1):tolist(),{-112,-9,28,65,102}),"partition 99 multiset")
end
do -- partition 100
  local a=np.array({{127,164,201,238,24,61},{98,135,172,209,246,32}},np.uint32)
  local r=np.partition(a,{2,3,4},2)
  assert(r.dtype=="uint32","partition 100 dtype")
  assert(eq(r.shape,{2,6}),"partition 100 shape")
  assert(eq(r.strides,{24,4}),"partition 100 strides")
  assert(close(np.sort(r,2):tolist(),{{24,61,127,164,201,238},{32,98,135,172,209,246}}),"partition 100 multiset")
end
do -- partition 101
  local a=np.array({{{138,175},{212,249},{35,72}},{{109,146},{183,220},{6,43}},{{80,117},{154,191},{228,14}},{{51,88},{125,162},{199,236}},{{22,59},{96,133},{170,207}}},np.uint32)
  local r=np.partition(a,{2,3,5},1)
  assert(r.dtype=="uint32","partition 101 dtype")
  assert(eq(r.shape,{5,3,2}),"partition 101 shape")
  assert(eq(r.strides,{24,8,4}),"partition 101 strides")
  assert(close(np.sort(r,1):tolist(),{{{22,59},{96,133},{6,14}},{{51,88},{125,162},{35,43}},{{80,117},{154,191},{170,72}},{{109,146},{183,220},{199,207}},{{138,175},{212,249},{228,236}}}),"partition 101 multiset")
end
do -- partition 102
  local a=(np.array({{149,186},{223,9},{46,83},{120,157},{194,231}},np.uint8)).T
  local r=np.partition(a,{1,2},1)
  assert(r.dtype=="uint8","partition 102 dtype")
  assert(eq(r.shape,{2,5}),"partition 102 shape")
  assert(eq(r.strides,{1,2}),"partition 102 strides")
  assert(close(np.sort(r,1):tolist(),{{149,9,46,120,194},{186,223,83,157,231}}),"partition 102 multiset")
end
do -- partition 103
  local a=np.array({160,197,234,20},np.uint32)
  local r=np.partition(a,1,1)
  assert(r.dtype=="uint32","partition 103 dtype")
  assert(eq(r.shape,{4}),"partition 103 shape")
  assert(eq(r.strides,{4}),"partition 103 strides")
  assert(close(np.sort(r,1):tolist(),{20,160,197,234}),"partition 103 multiset")
end
do -- partition 104
  local a=np.array({{{171,208,245,31,68,105},{142,179,216,2,39,76},{113,150,187,224,10,47},{84,121,158,195,232,18}},{{55,92,129,166,203,240},{26,63,100,137,174,211},{248,34,71,108,145,182},{219,5,42,79,116,153}},{{190,227,13,50,87,124},{161,198,235,21,58,95},{132,169,206,243,29,66},{103,140,177,214,0,37}},{{74,111,148,185,222,8},{45,82,119,156,193,230},{16,53,90,127,164,201},{238,24,61,98,135,172}},{{209,246,32,69,106,143},{180,217,3,40,77,114},{151,188,225,11,48,85},{122,159,196,233,19,56}},{{93,130,167,204,241,27},{64,101,138,175,212,249},{35,72,109,146,183,220},{6,43,80,117,154,191}}},np.uint32)
  local r=np.partition(a,6,1)
  assert(r.dtype=="uint32","partition 104 dtype")
  assert(eq(r.shape,{6,4,6}),"partition 104 shape")
  assert(eq(r.strides,{96,24,4}),"partition 104 strides")
  assert(close(np.sort(r,1):tolist(),{{{55,92,13,31,68,8},{26,63,3,2,39,76},{16,34,71,11,10,47},{6,5,42,79,0,18}},{{74,111,32,50,87,27},{45,82,100,21,58,95},{35,53,90,108,29,66},{84,24,61,98,19,37}},{{93,130,129,69,106,105},{64,101,119,40,77,114},{113,72,109,127,48,85},{103,43,80,117,116,56}},{{171,208,148,166,203,124},{142,179,138,137,174,211},{132,150,187,146,145,182},{122,121,158,195,135,153}},{{190,227,167,185,222,143},{161,198,216,156,193,230},{151,169,206,224,164,201},{219,140,177,214,154,172}},{{209,246,245,204,241,240},{180,217,235,175,212,249},{248,188,225,243,183,220},{238,159,196,233,232,191}}}),"partition 104 multiset")
end
do -- partition 105
  local a=np.array({{{57,94,-120},{-83,-46,-9},{28,65,102},{-112,-75,-38}},{{-1,36,73},{110,-104,-67},{-30,7,44},{81,118,-96}},{{-59,-22,15},{52,89,-125},{-88,-51,-14},{23,60,97}},{{-117,-80,-43},{-6,31,68},{105,-109,-72},{-35,2,39}},{{76,113,-101},{-64,-27,10},{47,84,121},{-93,-56,-19}}},np.int64)
  local r=np.partition(a,{1,2,4},2)
  assert(r.dtype=="int64","partition 105 dtype")
  assert(eq(r.shape,{5,4,3}),"partition 105 shape")
  assert(eq(r.strides,{96,24,8}),"partition 105 strides")
  assert(close(np.sort(r,2):tolist(),{{{-112,-75,-120},{-83,-46,-38},{28,65,-9},{57,94,102}},{{-30,-104,-96},{-1,7,-67},{81,36,44},{110,118,73}},{{-88,-51,-125},{-59,-22,-14},{23,60,15},{52,89,97}},{{-117,-109,-72},{-35,-80,-43},{-6,2,39},{105,31,68}},{{-93,-56,-101},{-64,-27,-19},{47,84,10},{76,113,121}}}),"partition 105 multiset")
end
do -- partition 106
  local a=np.array({{10.25,-9.749},{-5.498,-1.247},{3.004,7.255},{11.506,-8.493}},np.float64)
  local r=np.partition(a,2,2)
  assert(r.dtype=="float64","partition 106 dtype")
  assert(eq(r.shape,{4,2}),"partition 106 shape")
  assert(eq(r.strides,{16,8}),"partition 106 strides")
  assert(close(np.sort(r,2):tolist(),{{-9.749,10.25},{-5.498,-1.247},{3.004,7.255},{-8.493,11.506}}),"partition 106 multiset")
end
do -- partition 107
  local a=np.array({{{204,241,27,64},{101,138,175,212},{249,35,72,109},{146,183,220,6},{43,80,117,154},{191,228,14,51}},{{88,125,162,199},{236,22,59,96},{133,170,207,244},{30,67,104,141},{178,215,1,38},{75,112,149,186}},{{223,9,46,83},{120,157,194,231},{17,54,91,128},{165,202,239,25},{62,99,136,173},{210,247,33,70}},{{107,144,181,218},{4,41,78,115},{152,189,226,12},{49,86,123,160},{197,234,20,57},{94,131,168,205}},{{242,28,65,102},{139,176,213,250},{36,73,110,147},{184,221,7,44},{81,118,155,192},{229,15,52,89}}},np.uint32)
  local r=np.partition(a,5,2)
  assert(r.dtype=="uint32","partition 107 dtype")
  assert(eq(r.shape,{5,6,4}),"partition 107 shape")
  assert(eq(r.strides,{96,16,4}),"partition 107 strides")
  assert(close(np.sort(r,2):tolist(),{{{43,35,14,6},{101,80,27,51},{146,138,72,64},{191,183,117,109},{204,228,175,154},{249,241,220,212}},{{30,22,1,38},{75,67,59,96},{88,112,104,141},{133,125,149,186},{178,170,162,199},{236,215,207,244}},{{17,9,33,25},{62,54,46,70},{120,99,91,83},{165,157,136,128},{210,202,194,173},{223,247,239,231}},{{4,41,20,12},{49,86,78,57},{94,131,123,115},{107,144,168,160},{152,189,181,205},{197,234,226,218}},{{36,15,7,44},{81,28,52,89},{139,73,65,102},{184,118,110,147},{229,176,155,192},{242,221,213,250}}}),"partition 107 multiset")
end
do -- partition 108
  local a=np.array({215,1,38},np.uint16)
  local r=np.partition(a,1,1)
  assert(r.dtype=="uint16","partition 108 dtype")
  assert(eq(r.shape,{3}),"partition 108 shape")
  assert(eq(r.strides,{2}),"partition 108 strides")
  assert(close(np.sort(r,1):tolist(),{1,38,215}),"partition 108 multiset")
end
do -- partition 109
  local a=np.array({{{false,true},{false,true},{false,false}},{{true,false},{true,false},{false,true}},{{false,true},{false,false},{true,false}},{{true,false},{false,true},{false,true}},{{false,false},{true,false},{true,false}}},np.bool)
  local r=np.partition(a,{1,2},3)
  assert(r.dtype=="bool","partition 109 dtype")
  assert(eq(r.shape,{5,3,2}),"partition 109 shape")
  assert(eq(r.strides,{6,2,1}),"partition 109 strides")
  assert(close(np.sort(r,3):tolist(),{{{false,true},{false,true},{false,false}},{{false,true},{false,true},{false,true}},{{false,true},{false,false},{false,true}},{{false,true},{false,true},{false,true}},{{false,false},{false,true},{false,true}}}),"partition 109 multiset")
end
do -- partition 110
  local a=(np.array({{-11.0,-6.749,-2.498,1.753,6.004},{10.255,-9.744,-5.493,-1.242,3.009},{7.26,11.511,-8.488,-4.237,0.014},{4.265,8.516,-11.483,-7.232,-2.981},{1.27,5.521,9.772,-10.227,-5.976},{-1.725,2.526,6.777,11.028,-8.971}},np.float64)).T
  local r=np.partition(a,3,2)
  assert(r.dtype=="float64","partition 110 dtype")
  assert(eq(r.shape,{5,6}),"partition 110 shape")
  assert(eq(r.strides,{8,40}),"partition 110 strides")
  assert(close(np.sort(r,2):tolist(),{{-11.0,-1.725,1.27,4.265,7.26,10.255},{-9.744,-6.749,2.526,5.521,8.516,11.511},{-11.483,-8.488,-5.493,-2.498,6.777,9.772},{-10.227,-7.232,-4.237,-1.242,1.753,11.028},{-8.971,-5.976,-2.981,0.014,3.009,6.004}}),"partition 110 multiset")
end
do -- partition 111
  local a=np.array({{{123,-91},{-54,-17}},{{20,57},{94,-120}},{{-83,-46},{-9,28}}},np.int64)
  local r=np.partition(a,{1,2},2)
  assert(r.dtype=="int64","partition 111 dtype")
  assert(eq(r.shape,{3,2,2}),"partition 111 shape")
  assert(eq(r.strides,{32,16,8}),"partition 111 strides")
  assert(close(np.sort(r,2):tolist(),{{{-54,-91},{123,-17}},{{20,-120},{94,57}},{{-83,-46},{-9,28}}}),"partition 111 multiset")
end
do -- partition 112
  local a=(np.array({{8,45,82,119,156,193},{230,16,53,90,127,164}},np.uint32)).T
  local r=np.partition(a,{1,2},2)
  assert(r.dtype=="uint32","partition 112 dtype")
  assert(eq(r.shape,{6,2}),"partition 112 shape")
  assert(eq(r.strides,{4,24}),"partition 112 strides")
  assert(close(np.sort(r,2):tolist(),{{8,230},{16,45},{53,82},{90,119},{127,156},{164,193}}),"partition 112 multiset")
end
do -- partition 113
  local a=(np.array({{false,true},{false,false},{true,false},{true,false},{false,true}},np.bool)).T
  local r=np.partition(a,1,2)
  assert(r.dtype=="bool","partition 113 dtype")
  assert(eq(r.shape,{2,5}),"partition 113 shape")
  assert(eq(r.strides,{1,2}),"partition 113 strides")
  assert(close(np.sort(r,2):tolist(),{{false,false,false,true,true},{false,false,false,true,true}}),"partition 113 multiset")
end
do -- partition 114
  local a=np.array({30,67,104,141,178,215},np.uint8)
  local r=np.partition(a,4,1)
  assert(r.dtype=="uint8","partition 114 dtype")
  assert(eq(r.shape,{6}),"partition 114 shape")
  assert(eq(r.strides,{1}),"partition 114 strides")
  assert(close(np.sort(r,1):tolist(),{30,67,104,141,178,215}),"partition 114 multiset")
end
do -- partition 115
  local a=np.array({-7.25,-2.999,1.252},np.float32)
  local r=np.partition(a,3,1)
  assert(r.dtype=="float32","partition 115 dtype")
  assert(eq(r.shape,{3}),"partition 115 shape")
  assert(eq(r.strides,{4}),"partition 115 strides")
  assert(close(np.sort(r,1):tolist(),{-7.25,-2.999000072479248,1.2519999742507935}),"partition 115 multiset")
end
do -- partition 116
  local a=np.array({-73,-36},np.int64)
  local r=np.partition(a,{1,2},1)
  assert(r.dtype=="int64","partition 116 dtype")
  assert(eq(r.shape,{2}),"partition 116 shape")
  assert(eq(r.strides,{8}),"partition 116 strides")
  assert(close(np.sort(r,1):tolist(),{-73,-36}),"partition 116 multiset")
end
do -- partition 117
  local a=(np.array({{63,100,137},{174,211,248},{34,71,108}},np.uint32)).T
  local r=np.partition(a,2,2)
  assert(r.dtype=="uint32","partition 117 dtype")
  assert(eq(r.shape,{3,3}),"partition 117 shape")
  assert(eq(r.strides,{4,12}),"partition 117 strides")
  assert(close(np.sort(r,2):tolist(),{{34,63,174},{71,100,211},{108,137,248}}),"partition 117 multiset")
end
do -- partition 118
  local a=np.array({{-51,-14,23,60,97},{-117,-80,-43,-6,31},{68,105,-109,-72,-35},{2,39,76,113,-101}},np.int32)
  local r=np.partition(a,5,2)
  assert(r.dtype=="int32","partition 118 dtype")
  assert(eq(r.shape,{4,5}),"partition 118 shape")
  assert(eq(r.strides,{20,4}),"partition 118 strides")
  assert(close(np.sort(r,2):tolist(),{{-51,-14,23,60,97},{-117,-80,-43,-6,31},{-109,-72,-35,68,105},{-101,2,39,76,113}}),"partition 118 multiset")
end
do -- partition 119
  local a=np.array({{{85,122,159,196,233,19},{56,93,130,167,204,241}},{{27,64,101,138,175,212},{249,35,72,109,146,183}},{{220,6,43,80,117,154},{191,228,14,51,88,125}},{{162,199,236,22,59,96},{133,170,207,244,30,67}}},np.uint8)
  local r=np.partition(a,4,1)
  assert(r.dtype=="uint8","partition 119 dtype")
  assert(eq(r.shape,{4,2,6}),"partition 119 shape")
  assert(eq(r.strides,{12,6,1}),"partition 119 strides")
  assert(close(np.sort(r,1):tolist(),{{{27,6,43,22,59,19},{56,35,14,51,30,67}},{{85,64,101,80,117,96},{133,93,72,109,88,125}},{{162,122,159,138,175,154},{191,170,130,167,146,183}},{{220,199,236,196,233,212},{249,228,207,244,204,241}}}),"partition 119 multiset")
end
do -- partition 120
  local a=np.array({-3.5,0.751,5.002,9.253,-10.746,-6.495},np.float32)
  local r=np.partition(a,3,1)
  assert(r.dtype=="float32","partition 120 dtype")
  assert(eq(r.shape,{6}),"partition 120 shape")
  assert(eq(r.strides,{4}),"partition 120 strides")
  assert(close(np.sort(r,1):tolist(),{-10.746000289916992,-6.494999885559082,-3.5,0.7509999871253967,5.001999855041504,9.253000259399414}),"partition 120 multiset")
end
do -- partition 121
  local a=np.array({{{107,144},{181,218},{4,41},{78,115},{152,189}},{{226,12},{49,86},{123,160},{197,234},{20,57}}},np.uint32)
  local r=np.partition(a,{1,2,5},2)
  assert(r.dtype=="uint32","partition 121 dtype")
  assert(eq(r.shape,{2,5,2}),"partition 121 shape")
  assert(eq(r.strides,{40,8,4}),"partition 121 strides")
  assert(close(np.sort(r,2):tolist(),{{{4,41},{78,115},{107,144},{152,189},{181,218}},{{20,12},{49,57},{123,86},{197,160},{226,234}}}),"partition 121 multiset")
end
do -- partition 122
  local a=(np.array({{118,155},{192,229},{15,52}},np.uint32)).T
  local r=np.partition(a,{1,2},1)
  assert(r.dtype=="uint32","partition 122 dtype")
  assert(eq(r.shape,{2,3}),"partition 122 shape")
  assert(eq(r.strides,{4,8}),"partition 122 strides")
  assert(close(np.sort(r,1):tolist(),{{118,192,15},{155,229,52}}),"partition 122 multiset")
end
do -- partition 123
  local a=np.array({4,41,78},np.int8)
  local r=np.partition(a,{1,2,3},1)
  assert(r.dtype=="int8","partition 123 dtype")
  assert(eq(r.shape,{3}),"partition 123 shape")
  assert(eq(r.strides,{1}),"partition 123 strides")
  assert(close(np.sort(r,1):tolist(),{4,41,78}),"partition 123 multiset")
end
do -- partition 124
  local a=np.array({{{15,52,89,-125,-88,-51},{-14,23,60,97,-117,-80},{-43,-6,31,68,105,-109},{-72,-35,2,39,76,113},{-101,-64,-27,10,47,84}},{{121,-93,-56,-19,18,55},{92,-122,-85,-48,-11,26},{63,100,-114,-77,-40,-3},{34,71,108,-106,-69,-32},{5,42,79,116,-98,-61}},{{-24,13,50,87,124,-90},{-53,-16,21,58,95,-119},{-82,-45,-8,29,66,103},{-111,-74,-37,0,37,74},{111,-103,-66,-29,8,45}},{{82,119,-95,-58,-21,16},{53,90,-124,-87,-50,-13},{24,61,98,-116,-79,-42},{-5,32,69,106,-108,-71},{-34,3,40,77,114,-100}},{{-63,-26,11,48,85,122},{-92,-55,-18,19,56,93},{-121,-84,-47,-10,27,64},{101,-113,-76,-39,-2,35},{72,109,-105,-68,-31,6}},{{43,80,117,-97,-60,-23},{14,51,88,125,-89,-52},{-15,22,59,96,-118,-81},{-44,-7,30,67,104,-110},{-73,-36,1,38,75,112}}},np.int64)
  local r=np.partition(a,3,2)
  assert(r.dtype=="int64","partition 124 dtype")
  assert(eq(r.shape,{6,5,6}),"partition 124 shape")
  assert(eq(r.strides,{240,48,8}),"partition 124 strides")
  assert(close(np.sort(r,2):tolist(),{{{-101,-64,-27,-125,-117,-109},{-72,-35,2,10,-88,-80},{-43,-6,31,39,47,-51},{-14,23,60,68,76,84},{15,52,89,97,105,113}},{{5,-122,-114,-106,-98,-61},{34,-93,-85,-77,-69,-32},{63,42,-56,-48,-40,-3},{92,71,79,-19,-11,26},{121,100,108,116,18,55}},{{-111,-103,-66,-29,8,-119},{-82,-74,-37,0,37,-90},{-53,-45,-8,29,66,45},{-24,-16,21,58,95,74},{111,13,50,87,124,103}},{{-34,3,-124,-116,-108,-100},{-5,32,-95,-87,-79,-71},{24,61,40,-58,-50,-42},{53,90,69,77,-21,-13},{82,119,98,106,114,16}},{{-121,-113,-105,-68,-31,6},{-92,-84,-76,-39,-2,35},{-63,-55,-47,-10,27,64},{72,-26,-18,19,56,93},{101,109,11,48,85,122}},{{-73,-36,1,-97,-118,-110},{-44,-7,30,38,-89,-81},{-15,22,59,67,-60,-52},{14,51,88,96,75,-23},{43,80,117,125,104,112}}}),"partition 124 multiset")
end
do -- partition 125
  local a=np.array({151,188,225,11,48},np.uint16)
  local r=np.partition(a,3,1)
  assert(r.dtype=="uint16","partition 125 dtype")
  assert(eq(r.shape,{5}),"partition 125 shape")
  assert(eq(r.strides,{2}),"partition 125 strides")
  assert(close(np.sort(r,1):tolist(),{11,48,151,188,225}),"partition 125 multiset")
end
do -- partition 126
  local a=np.array({{162,199,236,22},{59,96,133,170},{207,244,30,67},{104,141,178,215},{1,38,75,112}},np.uint8)
  local r=np.partition(a,{2,3,4},2)
  assert(r.dtype=="uint8","partition 126 dtype")
  assert(eq(r.shape,{5,4}),"partition 126 shape")
  assert(eq(r.strides,{4,1}),"partition 126 strides")
  assert(close(np.sort(r,2):tolist(),{{22,162,199,236},{59,96,133,170},{30,67,207,244},{104,141,178,215},{1,38,75,112}}),"partition 126 multiset")
end
do -- partition 127
  local a=np.array({173,210,247},np.uint16)
  local r=np.partition(a,2,1)
  assert(r.dtype=="uint16","partition 127 dtype")
  assert(eq(r.shape,{3}),"partition 127 shape")
  assert(eq(r.strides,{2}),"partition 127 strides")
  assert(close(np.sort(r,1):tolist(),{173,210,247}),"partition 127 multiset")
end
do -- partition 128
  local a=np.array({2.5,6.751,11.002,-8.997,-4.746,-0.495},np.float64)
  local r=np.partition(a,6,1)
  assert(r.dtype=="float64","partition 128 dtype")
  assert(eq(r.shape,{6}),"partition 128 shape")
  assert(eq(r.strides,{8}),"partition 128 strides")
  assert(close(np.sort(r,1):tolist(),{-8.997,-4.746,-0.495,2.5,6.751,11.002}),"partition 128 multiset")
end
do -- partition 129
  local a=np.array({70,107,-107},np.int64)
  local r=np.partition(a,2,1)
  assert(r.dtype=="int64","partition 129 dtype")
  assert(eq(r.shape,{3}),"partition 129 shape")
  assert(eq(r.strides,{8}),"partition 129 strides")
  assert(close(np.sort(r,1):tolist(),{-107,70,107}),"partition 129 multiset")
end
do -- argpartition 0
  local a=np.array({150,187,224,10},np.uint32)
  local r=np.argpartition(a,4,1)
  assert(r.dtype=="int64","argpartition 0 dtype")
  assert(eq(r.shape,{4}),"argpartition 0 shape")
  assert(eq(r.strides,{8}),"argpartition 0 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{10,150,187,224}),"argpartition 0 permutation")
  assert(close(g[4],224),"argpartition 0 kth 3")
end
do -- argpartition 1
  local a=(np.array({{161,198},{235,21},{58,95},{132,169},{206,243}},np.uint8)).T
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 1 dtype")
  assert(eq(r.shape,{2,5}),"argpartition 1 shape")
  assert(eq(r.strides,{40,8}),"argpartition 1 strides")
end
do -- argpartition 2
  local a=(np.array({{47,84},{121,-93}},np.int64)).T
  local r=np.argpartition(a,2,2)
  assert(r.dtype=="int64","argpartition 2 dtype")
  assert(eq(r.shape,{2,2}),"argpartition 2 shape")
  assert(eq(r.strides,{16,8}),"argpartition 2 strides")
end
do -- argpartition 3
  local a=np.array({0.5,4.751,9.002,-10.997},np.float64)
  local r=np.argpartition(a,2,1)
  assert(r.dtype=="int64","argpartition 3 dtype")
  assert(eq(r.shape,{4}),"argpartition 3 shape")
  assert(eq(r.strides,{8}),"argpartition 3 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-10.997,0.5,4.751,9.002}),"argpartition 3 permutation")
  assert(close(g[2],0.5),"argpartition 3 kth 1")
end
do -- argpartition 4
  local a=np.array({194,231},np.uint32)
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 4 dtype")
  assert(eq(r.shape,{2}),"argpartition 4 shape")
  assert(eq(r.strides,{8}),"argpartition 4 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{194,231}),"argpartition 4 permutation")
  assert(close(g[1],194),"argpartition 4 kth 0")
end
do -- argpartition 5
  local a=np.array({80,117,-97,-60},np.int16)
  local r=np.argpartition(a,4,1)
  assert(r.dtype=="int64","argpartition 5 dtype")
  assert(eq(r.shape,{4}),"argpartition 5 shape")
  assert(eq(r.strides,{8}),"argpartition 5 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-97,-60,80,117}),"argpartition 5 permutation")
  assert(close(g[4],117),"argpartition 5 kth 3")
end
do -- argpartition 6
  local a=np.array({216,2,39,76},np.uint8)
  local r=np.argpartition(a,4,1)
  assert(r.dtype=="int64","argpartition 6 dtype")
  assert(eq(r.shape,{4}),"argpartition 6 shape")
  assert(eq(r.strides,{8}),"argpartition 6 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{2,39,76,216}),"argpartition 6 permutation")
  assert(close(g[4],216),"argpartition 6 kth 3")
end
do -- argpartition 7
  local a=np.array({227,13,50,87,124,161,198},np.uint8)
  local r=np.argpartition(a,7,1)
  assert(r.dtype=="int64","argpartition 7 dtype")
  assert(eq(r.shape,{7}),"argpartition 7 shape")
  assert(eq(r.strides,{8}),"argpartition 7 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{13,50,87,124,161,198,227}),"argpartition 7 permutation")
  assert(close(g[7],227),"argpartition 7 kth 6")
end
do -- argpartition 8
  local a=np.array({{4.25,8.501},{-11.498,-7.247},{-2.996,1.255},{5.506,9.757}},np.float32)
  local r=np.argpartition(a,1,2)
  assert(r.dtype=="int64","argpartition 8 dtype")
  assert(eq(r.shape,{4,2}),"argpartition 8 shape")
  assert(eq(r.strides,{16,8}),"argpartition 8 strides")
end
do -- argpartition 9
  local a=np.array({5.0,9.251,-10.748,-6.497,-2.246},np.float32)
  local r=np.argpartition(a,{4,5},1)
  assert(r.dtype=="int64","argpartition 9 dtype")
  assert(eq(r.shape,{5}),"argpartition 9 shape")
  assert(eq(r.strides,{8}),"argpartition 9 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-10.748000144958496,-6.497000217437744,-2.246000051498413,5.0,9.25100040435791}),"argpartition 9 permutation")
  assert(close(g[4],5.0),"argpartition 9 kth 3")
  assert(close(g[5],9.25100040435791),"argpartition 9 kth 4")
end
do -- argpartition 10
  local a=np.array({-116,-79,-42},np.int32)
  local r=np.argpartition(a,3,1)
  assert(r.dtype=="int64","argpartition 10 dtype")
  assert(eq(r.shape,{3}),"argpartition 10 shape")
  assert(eq(r.strides,{8}),"argpartition 10 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-116,-79,-42}),"argpartition 10 permutation")
  assert(close(g[3],-42),"argpartition 10 kth 2")
end
do -- argpartition 11
  local a=np.array({{-105,-68,-31,6},{43,80,117,-97},{-60,-23,14,51},{88,125,-89,-52},{-15,22,59,96}},np.int64)
  local r=np.argpartition(a,2,2)
  assert(r.dtype=="int64","argpartition 11 dtype")
  assert(eq(r.shape,{5,4}),"argpartition 11 shape")
  assert(eq(r.strides,{32,8}),"argpartition 11 strides")
end
do -- argpartition 12
  local a=np.array({31,68,105,142,179,216},np.uint32)
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 12 dtype")
  assert(eq(r.shape,{6}),"argpartition 12 shape")
  assert(eq(r.strides,{8}),"argpartition 12 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{31,68,105,142,179,216}),"argpartition 12 permutation")
  assert(close(g[1],31),"argpartition 12 kth 0")
end
do -- argpartition 13
  local a=np.array({{-83,-46,-9},{28,65,102},{-112,-75,-38},{-1,36,73},{110,-104,-67}},np.int16)
  local r=np.argpartition(a,3,2)
  assert(r.dtype=="int64","argpartition 13 dtype")
  assert(eq(r.shape,{5,3}),"argpartition 13 shape")
  assert(eq(r.strides,{24,8}),"argpartition 13 strides")
end
do -- argpartition 14
  local a=np.array({-72,-35,2,39,76},np.int64)
  local r=np.argpartition(a,{2,4},1)
  assert(r.dtype=="int64","argpartition 14 dtype")
  assert(eq(r.shape,{5}),"argpartition 14 shape")
  assert(eq(r.strides,{8}),"argpartition 14 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-72,-35,2,39,76}),"argpartition 14 permutation")
  assert(close(g[2],-35),"argpartition 14 kth 1")
  assert(close(g[4],39),"argpartition 14 kth 3")
end
do -- argpartition 15
  local a=np.array({{9.5,-10.499,-6.248,-1.997,2.254},{6.505,10.756,-9.243,-4.992,-0.741},{3.51,7.761,12.012,-7.987,-3.736},{0.515,4.766,9.017,-10.982,-6.731}},np.float64)
  local r=np.argpartition(a,4,1)
  assert(r.dtype=="int64","argpartition 15 dtype")
  assert(eq(r.shape,{4,5}),"argpartition 15 shape")
  assert(eq(r.strides,{40,8}),"argpartition 15 strides")
end
do -- argpartition 16
  local a=(np.array({{-50,-13,24,61},{98,-116,-79,-42},{-5,32,69,106},{-108,-71,-34,3}},np.int64)).T
  local r=np.argpartition(a,{2,4},2)
  assert(r.dtype=="int64","argpartition 16 dtype")
  assert(eq(r.shape,{4,4}),"argpartition 16 shape")
  assert(eq(r.strides,{32,8}),"argpartition 16 strides")
end
do -- argpartition 17
  local a=np.array({{-39,-2,35,72,109},{-105,-68,-31,6,43},{80,117,-97,-60,-23}},np.int32)
  local r=np.argpartition(a,3,1)
  assert(r.dtype=="int64","argpartition 17 dtype")
  assert(eq(r.shape,{3,5}),"argpartition 17 shape")
  assert(eq(r.strides,{40,8}),"argpartition 17 strides")
end
do -- argpartition 18
  local a=(np.array({{-28,9,46,83},{120,-94,-57,-20},{17,54,91,-123},{-86,-49,-12,25}},np.int8)).T
  local r=np.argpartition(a,1,2)
  assert(r.dtype=="int64","argpartition 18 dtype")
  assert(eq(r.shape,{4,4}),"argpartition 18 shape")
  assert(eq(r.strides,{32,8}),"argpartition 18 strides")
end
do -- argpartition 19
  local a=np.array({108,145,182,219,5,42},np.uint8)
  local r=np.argpartition(a,5,1)
  assert(r.dtype=="int64","argpartition 19 dtype")
  assert(eq(r.shape,{6}),"argpartition 19 shape")
  assert(eq(r.strides,{8}),"argpartition 19 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{5,42,108,145,182,219}),"argpartition 19 permutation")
  assert(close(g[5],182),"argpartition 19 kth 4")
end
do -- argpartition 20
  local a=np.array({{-6,31},{68,105}},np.int16)
  local r=np.argpartition(a,{1,2},1)
  assert(r.dtype=="int64","argpartition 20 dtype")
  assert(eq(r.shape,{2,2}),"argpartition 20 shape")
  assert(eq(r.strides,{16,8}),"argpartition 20 strides")
end
do -- argpartition 21
  local a=np.array({130,167,204,241,27},np.uint16)
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 21 dtype")
  assert(eq(r.shape,{5}),"argpartition 21 shape")
  assert(eq(r.strides,{8}),"argpartition 21 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{27,130,167,204,241}),"argpartition 21 permutation")
  assert(close(g[1],27),"argpartition 21 kth 0")
end
do -- argpartition 22
  local a=np.array({-9.5,-5.249,-0.998,3.253,7.504},np.float64)
  local r=np.argpartition(a,4,1)
  assert(r.dtype=="int64","argpartition 22 dtype")
  assert(eq(r.shape,{5}),"argpartition 22 shape")
  assert(eq(r.strides,{8}),"argpartition 22 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-9.5,-5.249,-0.998,3.253,7.504}),"argpartition 22 permutation")
  assert(close(g[4],3.253),"argpartition 22 kth 3")
end
do -- argpartition 23
  local a=np.array({{27,64,101,-113,-76},{-39,-2,35,72,109},{-105,-68,-31,6,43},{80,117,-97,-60,-23}},np.int64)
  local r=np.argpartition(a,{3,4},1)
  assert(r.dtype=="int64","argpartition 23 dtype")
  assert(eq(r.shape,{4,5}),"argpartition 23 shape")
  assert(eq(r.strides,{40,8}),"argpartition 23 strides")
end
do -- argpartition 24
  local a=np.array({38,75,112},np.int64)
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 24 dtype")
  assert(eq(r.shape,{3}),"argpartition 24 shape")
  assert(eq(r.strides,{8}),"argpartition 24 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{38,75,112}),"argpartition 24 permutation")
  assert(close(g[1],38),"argpartition 24 kth 0")
end
do -- argpartition 25
  local a=np.array({{174,211,248},{34,71,108},{145,182,219},{5,42,79}},np.uint16)
  local r=np.argpartition(a,{1,3},1)
  assert(r.dtype=="int64","argpartition 25 dtype")
  assert(eq(r.shape,{4,3}),"argpartition 25 shape")
  assert(eq(r.strides,{24,8}),"argpartition 25 strides")
end
do -- argpartition 26
  local a=np.array({{-6.5,-2.249,2.002},{6.253,10.504,-9.495},{-5.244,-0.993,3.258}},np.float64)
  local r=np.argpartition(a,3,1)
  assert(r.dtype=="int64","argpartition 26 dtype")
  assert(eq(r.shape,{3,3}),"argpartition 26 shape")
  assert(eq(r.strides,{24,8}),"argpartition 26 strides")
end
do -- argpartition 27
  local a=np.array({71,108,-106,-69},np.int16)
  local r=np.argpartition(a,{1,4},1)
  assert(r.dtype=="int64","argpartition 27 dtype")
  assert(eq(r.shape,{4}),"argpartition 27 shape")
  assert(eq(r.strides,{8}),"argpartition 27 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-106,-69,71,108}),"argpartition 27 permutation")
  assert(close(g[1],-106),"argpartition 27 kth 0")
  assert(close(g[4],108),"argpartition 27 kth 3")
end
do -- argpartition 28
  local a=np.array({{82,119,-95,-58},{-21,16,53,90}},np.int64)
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 28 dtype")
  assert(eq(r.shape,{2,4}),"argpartition 28 shape")
  assert(eq(r.strides,{32,8}),"argpartition 28 strides")
end
do -- argpartition 29
  local a=np.array({{93,-121},{-84,-47},{-10,27}},np.int8)
  local r=np.argpartition(a,1,2)
  assert(r.dtype=="int64","argpartition 29 dtype")
  assert(eq(r.shape,{3,2}),"argpartition 29 shape")
  assert(eq(r.strides,{16,8}),"argpartition 29 strides")
end
do -- argpartition 30
  local a=np.array({{229,15,52,89,126},{163,200,237,23,60},{97,134,171,208,245}},np.uint32)
  local r=np.argpartition(a,{1,5},2)
  assert(r.dtype=="int64","argpartition 30 dtype")
  assert(eq(r.shape,{3,5}),"argpartition 30 shape")
  assert(eq(r.strides,{40,8}),"argpartition 30 strides")
end
do -- argpartition 31
  local a=np.array({{240,26,63},{100,137,174},{211,248,34}},np.uint16)
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 31 dtype")
  assert(eq(r.shape,{3,3}),"argpartition 31 shape")
  assert(eq(r.strides,{24,8}),"argpartition 31 strides")
end
do -- argpartition 32
  local a=np.array({0,37,74,111},np.uint16)
  local r=np.argpartition(a,{1,3},1)
  assert(r.dtype=="int64","argpartition 32 dtype")
  assert(eq(r.shape,{4}),"argpartition 32 shape")
  assert(eq(r.strides,{8}),"argpartition 32 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{0,37,74,111}),"argpartition 32 permutation")
  assert(close(g[1],0),"argpartition 32 kth 0")
  assert(close(g[3],74),"argpartition 32 kth 2")
end
do -- argpartition 33
  local a=np.array({-114,-77,-40,-3,34},np.int32)
  local r=np.argpartition(a,2,1)
  assert(r.dtype=="int64","argpartition 33 dtype")
  assert(eq(r.shape,{5}),"argpartition 33 shape")
  assert(eq(r.strides,{8}),"argpartition 33 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-114,-77,-40,-3,34}),"argpartition 33 permutation")
  assert(close(g[2],-77),"argpartition 33 kth 1")
end
do -- argpartition 34
  local a=np.array({22,59,96,133,170,207},np.uint8)
  local r=np.argpartition(a,5,1)
  assert(r.dtype=="int64","argpartition 34 dtype")
  assert(eq(r.shape,{6}),"argpartition 34 shape")
  assert(eq(r.strides,{8}),"argpartition 34 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{22,59,96,133,170,207}),"argpartition 34 permutation")
  assert(close(g[5],170),"argpartition 34 kth 4")
end
do -- argpartition 35
  local a=np.array({33,70,107,144,181,218,4},np.uint32)
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 35 dtype")
  assert(eq(r.shape,{7}),"argpartition 35 shape")
  assert(eq(r.strides,{8}),"argpartition 35 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{4,33,70,107,144,181,218}),"argpartition 35 permutation")
  assert(close(g[1],4),"argpartition 35 kth 0")
end
do -- argpartition 36
  local a=np.array({44,81,118,155,192,229},np.uint16)
  local r=np.argpartition(a,3,1)
  assert(r.dtype=="int64","argpartition 36 dtype")
  assert(eq(r.shape,{6}),"argpartition 36 shape")
  assert(eq(r.strides,{8}),"argpartition 36 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{44,81,118,155,192,229}),"argpartition 36 permutation")
  assert(close(g[3],118),"argpartition 36 kth 2")
end
do -- argpartition 37
  local a=(np.array({{-70,-33,4,41,78},{115,-99,-62,-25,12},{49,86,123,-91,-54},{-17,20,57,94,-120}},np.int8)).T
  local r=np.argpartition(a,1,2)
  assert(r.dtype=="int64","argpartition 37 dtype")
  assert(eq(r.shape,{5,4}),"argpartition 37 shape")
  assert(eq(r.strides,{32,8}),"argpartition 37 strides")
end
do -- argpartition 38
  local a=np.array({2.5,6.751,11.002},np.float32)
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 38 dtype")
  assert(eq(r.shape,{3}),"argpartition 38 shape")
  assert(eq(r.strides,{8}),"argpartition 38 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{2.5,6.750999927520752,11.001999855041504}),"argpartition 38 permutation")
  assert(close(g[1],2.5),"argpartition 38 kth 0")
end
do -- argpartition 39
  local a=np.array({3.25,7.501},np.float64)
  local r=np.argpartition(a,2,1)
  assert(r.dtype=="int64","argpartition 39 dtype")
  assert(eq(r.shape,{2}),"argpartition 39 shape")
  assert(eq(r.strides,{8}),"argpartition 39 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{3.25,7.501}),"argpartition 39 permutation")
  assert(close(g[2],7.501),"argpartition 39 kth 1")
end
do -- argpartition 40
  local a=np.array({4.0,8.251,-11.748},np.float32)
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 40 dtype")
  assert(eq(r.shape,{3}),"argpartition 40 shape")
  assert(eq(r.strides,{8}),"argpartition 40 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-11.748000144958496,4.0,8.25100040435791}),"argpartition 40 permutation")
  assert(close(g[1],-11.748000144958496),"argpartition 40 kth 0")
end
do -- argpartition 41
  local a=np.array({-26,11,48,85,122,-92},np.int32)
  local r=np.argpartition(a,6,1)
  assert(r.dtype=="int64","argpartition 41 dtype")
  assert(eq(r.shape,{6}),"argpartition 41 shape")
  assert(eq(r.strides,{8}),"argpartition 41 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-92,-26,11,48,85,122}),"argpartition 41 permutation")
  assert(close(g[6],122),"argpartition 41 kth 5")
end
do -- argpartition 42
  local a=np.array({110,147,184},np.uint16)
  local r=np.argpartition(a,3,1)
  assert(r.dtype=="int64","argpartition 42 dtype")
  assert(eq(r.shape,{3}),"argpartition 42 shape")
  assert(eq(r.strides,{8}),"argpartition 42 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{110,147,184}),"argpartition 42 permutation")
  assert(close(g[3],184),"argpartition 42 kth 2")
end
do -- argpartition 43
  local a=np.array({6.25,10.501},np.float64)
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 43 dtype")
  assert(eq(r.shape,{2}),"argpartition 43 shape")
  assert(eq(r.strides,{8}),"argpartition 43 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{6.25,10.501}),"argpartition 43 permutation")
  assert(close(g[1],6.25),"argpartition 43 kth 0")
end
do -- argpartition 44
  local a=np.array({{7,44},{81,118},{-96,-59},{-22,15},{52,89}},np.int8)
  local r=np.argpartition(a,2,2)
  assert(r.dtype=="int64","argpartition 44 dtype")
  assert(eq(r.shape,{5,2}),"argpartition 44 shape")
  assert(eq(r.strides,{16,8}),"argpartition 44 strides")
end
do -- argpartition 45
  local a=np.array({{143,180,217,3,40},{77,114,151,188,225},{11,48,85,122,159},{196,233,19,56,93}},np.uint8)
  local r=np.argpartition(a,{1,2},1)
  assert(r.dtype=="int64","argpartition 45 dtype")
  assert(eq(r.shape,{4,5}),"argpartition 45 shape")
  assert(eq(r.strides,{40,8}),"argpartition 45 strides")
end
do -- argpartition 46
  local a=np.array({29,66,103,-111,-74,-37,0},np.int16)
  local r=np.argpartition(a,7,1)
  assert(r.dtype=="int64","argpartition 46 dtype")
  assert(eq(r.shape,{7}),"argpartition 46 shape")
  assert(eq(r.strides,{8}),"argpartition 46 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-111,-74,-37,0,29,66,103}),"argpartition 46 permutation")
  assert(close(g[7],103),"argpartition 46 kth 6")
end
do -- argpartition 47
  local a=np.array({{40,77,114,-100},{-63,-26,11,48},{85,122,-92,-55},{-18,19,56,93},{-121,-84,-47,-10}},np.int16)
  local r=np.argpartition(a,1,2)
  assert(r.dtype=="int64","argpartition 47 dtype")
  assert(eq(r.shape,{5,4}),"argpartition 47 shape")
  assert(eq(r.strides,{32,8}),"argpartition 47 strides")
end
do -- argpartition 48
  local a=np.array({{51,88},{125,-89}},np.int8)
  local r=np.argpartition(a,{1,2},1)
  assert(r.dtype=="int64","argpartition 48 dtype")
  assert(eq(r.shape,{2,2}),"argpartition 48 shape")
  assert(eq(r.strides,{16,8}),"argpartition 48 strides")
end
do -- argpartition 49
  local a=np.array({10.75,-9.249},np.float64)
  local r=np.argpartition(a,{1,2},1)
  assert(r.dtype=="int64","argpartition 49 dtype")
  assert(eq(r.shape,{2}),"argpartition 49 shape")
  assert(eq(r.strides,{8}),"argpartition 49 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-9.249,10.75}),"argpartition 49 permutation")
  assert(close(g[1],-9.249),"argpartition 49 kth 0")
  assert(close(g[2],10.75),"argpartition 49 kth 1")
end
do -- argpartition 50
  local a=np.array({73,110,-104,-67,-30,7},np.int32)
  local r=np.argpartition(a,{2,3},1)
  assert(r.dtype=="int64","argpartition 50 dtype")
  assert(eq(r.shape,{6}),"argpartition 50 shape")
  assert(eq(r.strides,{8}),"argpartition 50 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-104,-67,-30,7,73,110}),"argpartition 50 permutation")
  assert(close(g[2],-67),"argpartition 50 kth 1")
  assert(close(g[3],-30),"argpartition 50 kth 2")
end
do -- argpartition 51
  local a=np.array({{84,121,-93},{-56,-19,18}},np.int16)
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 51 dtype")
  assert(eq(r.shape,{2,3}),"argpartition 51 shape")
  assert(eq(r.strides,{24,8}),"argpartition 51 strides")
end
do -- argpartition 52
  local a=(np.array({{95,-119,-82,-45},{-8,29,66,103}},np.int8)).T
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 52 dtype")
  assert(eq(r.shape,{4,2}),"argpartition 52 shape")
  assert(eq(r.strides,{16,8}),"argpartition 52 strides")
end
do -- argpartition 53
  local a=np.array({106,-108,-71,-34},np.int64)
  local r=np.argpartition(a,2,1)
  assert(r.dtype=="int64","argpartition 53 dtype")
  assert(eq(r.shape,{4}),"argpartition 53 shape")
  assert(eq(r.strides,{8}),"argpartition 53 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-108,-71,-34,106}),"argpartition 53 permutation")
  assert(close(g[2],-71),"argpartition 53 kth 1")
end
do -- argpartition 54
  local a=np.array({117,-97,-60,-23,14,51,88},np.int64)
  local r=np.argpartition(a,{4,7},1)
  assert(r.dtype=="int64","argpartition 54 dtype")
  assert(eq(r.shape,{7}),"argpartition 54 shape")
  assert(eq(r.strides,{8}),"argpartition 54 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-97,-60,-23,14,51,88,117}),"argpartition 54 permutation")
  assert(close(g[4],14),"argpartition 54 kth 3")
  assert(close(g[7],117),"argpartition 54 kth 6")
end
do -- argpartition 55
  local a=np.array({-123,-86,-49},np.int8)
  local r=np.argpartition(a,2,1)
  assert(r.dtype=="int64","argpartition 55 dtype")
  assert(eq(r.shape,{3}),"argpartition 55 shape")
  assert(eq(r.strides,{8}),"argpartition 55 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-123,-86,-49}),"argpartition 55 permutation")
  assert(close(g[2],-86),"argpartition 55 kth 1")
end
do -- argpartition 56
  local a=np.array({{-112,-75,-38,-1},{36,73,110,-104}},np.int16)
  local r=np.argpartition(a,2,1)
  assert(r.dtype=="int64","argpartition 56 dtype")
  assert(eq(r.shape,{2,4}),"argpartition 56 shape")
  assert(eq(r.strides,{32,8}),"argpartition 56 strides")
end
do -- argpartition 57
  local a=np.array({24,61,98},np.uint8)
  local r=np.argpartition(a,{1,3},1)
  assert(r.dtype=="int64","argpartition 57 dtype")
  assert(eq(r.shape,{3}),"argpartition 57 shape")
  assert(eq(r.strides,{8}),"argpartition 57 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{24,61,98}),"argpartition 57 permutation")
  assert(close(g[1],24),"argpartition 57 kth 0")
  assert(close(g[3],98),"argpartition 57 kth 2")
end
do -- argpartition 58
  local a=np.array({{35,72,109,146},{183,220,6,43},{80,117,154,191},{228,14,51,88}},np.uint8)
  local r=np.argpartition(a,{1,2},1)
  assert(r.dtype=="int64","argpartition 58 dtype")
  assert(eq(r.shape,{4,4}),"argpartition 58 shape")
  assert(eq(r.strides,{32,8}),"argpartition 58 strides")
end
do -- argpartition 59
  local a=np.array({46,83,120,157},np.uint8)
  local r=np.argpartition(a,3,1)
  assert(r.dtype=="int64","argpartition 59 dtype")
  assert(eq(r.shape,{4}),"argpartition 59 shape")
  assert(eq(r.strides,{8}),"argpartition 59 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{46,83,120,157}),"argpartition 59 permutation")
  assert(close(g[3],120),"argpartition 59 kth 2")
end
do -- argpartition 60
  local a=np.array({{-68,-31},{6,43},{80,117}},np.int64)
  local r=np.argpartition(a,{2,3},1)
  assert(r.dtype=="int64","argpartition 60 dtype")
  assert(eq(r.shape,{3,2}),"argpartition 60 shape")
  assert(eq(r.strides,{16,8}),"argpartition 60 strides")
end
do -- argpartition 61
  local a=np.array({{68,105,142},{179,216,2}},np.uint32)
  local r=np.argpartition(a,2,2)
  assert(r.dtype=="int64","argpartition 61 dtype")
  assert(eq(r.shape,{2,3}),"argpartition 61 shape")
  assert(eq(r.strides,{24,8}),"argpartition 61 strides")
end
do -- argpartition 62
  local a=np.array({{-46,-9,28,65,102},{-112,-75,-38,-1,36},{73,110,-104,-67,-30}},np.int64)
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 62 dtype")
  assert(eq(r.shape,{3,5}),"argpartition 62 shape")
  assert(eq(r.strides,{40,8}),"argpartition 62 strides")
end
do -- argpartition 63
  local a=np.array({{-3.0,1.251,5.502,9.753,-10.246},{-5.995,-1.744,2.507,6.758,11.009},{-8.99,-4.739,-0.488,3.763,8.014},{-11.985,-7.734,-3.483,0.768,5.019}},np.float32)
  local r=np.argpartition(a,5,2)
  assert(r.dtype=="int64","argpartition 63 dtype")
  assert(eq(r.shape,{4,5}),"argpartition 63 shape")
  assert(eq(r.strides,{40,8}),"argpartition 63 strides")
end
do -- argpartition 64
  local a=(np.array({{-24,13,50,87},{124,-90,-53,-16},{21,58,95,-119},{-82,-45,-8,29}},np.int64)).T
  local r=np.argpartition(a,2,2)
  assert(r.dtype=="int64","argpartition 64 dtype")
  assert(eq(r.shape,{4,4}),"argpartition 64 shape")
  assert(eq(r.strides,{32,8}),"argpartition 64 strides")
end
do -- argpartition 65
  local a=np.array({{-13,24,61,98},{-116,-79,-42,-5},{32,69,106,-108},{-71,-34,3,40}},np.int64)
  local r=np.argpartition(a,2,1)
  assert(r.dtype=="int64","argpartition 65 dtype")
  assert(eq(r.shape,{4,4}),"argpartition 65 shape")
  assert(eq(r.strides,{32,8}),"argpartition 65 strides")
end
do -- argpartition 66
  local a=(np.array({{123,160,197,234,20},{57,94,131,168,205}},np.uint8)).T
  local r=np.argpartition(a,2,2)
  assert(r.dtype=="int64","argpartition 66 dtype")
  assert(eq(r.shape,{5,2}),"argpartition 66 shape")
  assert(eq(r.strides,{16,8}),"argpartition 66 strides")
end
do -- argpartition 67
  local a=np.array({9,46,83},np.int32)
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 67 dtype")
  assert(eq(r.shape,{3}),"argpartition 67 shape")
  assert(eq(r.strides,{8}),"argpartition 67 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{9,46,83}),"argpartition 67 permutation")
  assert(close(g[1],9),"argpartition 67 kth 0")
end
do -- argpartition 68
  local a=np.array({20,57,94,-120,-83},np.int32)
  local r=np.argpartition(a,{1,3},1)
  assert(r.dtype=="int64","argpartition 68 dtype")
  assert(eq(r.shape,{5}),"argpartition 68 shape")
  assert(eq(r.strides,{8}),"argpartition 68 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-120,-83,20,57,94}),"argpartition 68 permutation")
  assert(close(g[1],-120),"argpartition 68 kth 0")
  assert(close(g[3],20),"argpartition 68 kth 2")
end
do -- argpartition 69
  local a=np.array({1.5,5.751,10.002,-9.997,-5.746,-1.495},np.float64)
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 69 dtype")
  assert(eq(r.shape,{6}),"argpartition 69 shape")
  assert(eq(r.strides,{8}),"argpartition 69 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-9.997,-5.746,-1.495,1.5,5.751,10.002}),"argpartition 69 permutation")
  assert(close(g[1],-9.997),"argpartition 69 kth 0")
end
do -- argpartition 70
  local a=np.array({{167,204},{241,27},{64,101},{138,175},{212,249}},np.uint8)
  local r=np.argpartition(a,2,2)
  assert(r.dtype=="int64","argpartition 70 dtype")
  assert(eq(r.shape,{5,2}),"argpartition 70 shape")
  assert(eq(r.strides,{16,8}),"argpartition 70 strides")
end
do -- argpartition 71
  local a=np.array({3.0,7.251,11.502,-8.497,-4.246},np.float64)
  local r=np.argpartition(a,2,1)
  assert(r.dtype=="int64","argpartition 71 dtype")
  assert(eq(r.shape,{5}),"argpartition 71 shape")
  assert(eq(r.strides,{8}),"argpartition 71 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-8.497,-4.246,3.0,7.251,11.502}),"argpartition 71 permutation")
  assert(close(g[2],-4.246),"argpartition 71 kth 1")
end
do -- argpartition 72
  local a=np.array({{64,101},{-113,-76},{-39,-2},{35,72}},np.int32)
  local r=np.argpartition(a,4,1)
  assert(r.dtype=="int64","argpartition 72 dtype")
  assert(eq(r.shape,{4,2}),"argpartition 72 shape")
  assert(eq(r.strides,{16,8}),"argpartition 72 strides")
end
do -- argpartition 73
  local a=np.array({{75,112,-102,-65},{-28,9,46,83},{120,-94,-57,-20}},np.int8)
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 73 dtype")
  assert(eq(r.shape,{3,4}),"argpartition 73 shape")
  assert(eq(r.strides,{32,8}),"argpartition 73 strides")
end
do -- argpartition 74
  local a=np.array({{211,248,34},{71,108,145},{182,219,5},{42,79,116}},np.uint16)
  local r=np.argpartition(a,3,1)
  assert(r.dtype=="int64","argpartition 74 dtype")
  assert(eq(r.shape,{4,3}),"argpartition 74 shape")
  assert(eq(r.strides,{24,8}),"argpartition 74 strides")
end
do -- argpartition 75
  local a=np.array({97,-117,-80,-43},np.int16)
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 75 dtype")
  assert(eq(r.shape,{4}),"argpartition 75 shape")
  assert(eq(r.strides,{8}),"argpartition 75 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-117,-80,-43,97}),"argpartition 75 permutation")
  assert(close(g[1],-117),"argpartition 75 kth 0")
end
do -- argpartition 76
  local a=np.array({233,19},np.uint8)
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 76 dtype")
  assert(eq(r.shape,{2}),"argpartition 76 shape")
  assert(eq(r.strides,{8}),"argpartition 76 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{19,233}),"argpartition 76 permutation")
  assert(close(g[1],19),"argpartition 76 kth 0")
end
do -- argpartition 77
  local a=np.array({{119,-95},{-58,-21},{16,53},{90,-124}},np.int64)
  local r=np.argpartition(a,1,2)
  assert(r.dtype=="int64","argpartition 77 dtype")
  assert(eq(r.shape,{4,2}),"argpartition 77 shape")
  assert(eq(r.strides,{16,8}),"argpartition 77 strides")
end
do -- argpartition 78
  local a=np.array({{4,41,78,115},{152,189,226,12}},np.uint16)
  local r=np.argpartition(a,4,2)
  assert(r.dtype=="int64","argpartition 78 dtype")
  assert(eq(r.shape,{2,4}),"argpartition 78 shape")
  assert(eq(r.strides,{32,8}),"argpartition 78 strides")
end
do -- argpartition 79
  local a=np.array({9.0,-10.999,-6.748,-2.497},np.float64)
  local r=np.argpartition(a,{2,3},1)
  assert(r.dtype=="int64","argpartition 79 dtype")
  assert(eq(r.shape,{4}),"argpartition 79 shape")
  assert(eq(r.strides,{8}),"argpartition 79 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-10.999,-6.748,-2.497,9.0}),"argpartition 79 permutation")
  assert(close(g[2],-6.748),"argpartition 79 kth 1")
  assert(close(g[3],-2.497),"argpartition 79 kth 2")
end
do -- argpartition 80
  local a=np.array({26,63,100,137},np.uint32)
  local r=np.argpartition(a,2,1)
  assert(r.dtype=="int64","argpartition 80 dtype")
  assert(eq(r.shape,{4}),"argpartition 80 shape")
  assert(eq(r.strides,{8}),"argpartition 80 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{26,63,100,137}),"argpartition 80 permutation")
  assert(close(g[2],63),"argpartition 80 kth 1")
end
do -- argpartition 81
  local a=np.array({-88,-51,-14,23},np.int8)
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 81 dtype")
  assert(eq(r.shape,{4}),"argpartition 81 shape")
  assert(eq(r.strides,{8}),"argpartition 81 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-88,-51,-14,23}),"argpartition 81 permutation")
  assert(close(g[1],-88),"argpartition 81 kth 0")
end
do -- argpartition 82
  local a=np.array({48,85,122,159,196,233},np.uint16)
  local r=np.argpartition(a,4,1)
  assert(r.dtype=="int64","argpartition 82 dtype")
  assert(eq(r.shape,{6}),"argpartition 82 shape")
  assert(eq(r.strides,{8}),"argpartition 82 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{48,85,122,159,196,233}),"argpartition 82 permutation")
  assert(close(g[4],159),"argpartition 82 kth 3")
end
do -- argpartition 83
  local a=np.array({{12.0,-7.999},{-3.748,0.503},{4.754,9.005},{-10.994,-6.743},{-2.492,1.759}},np.float64)
  local r=np.argpartition(a,3,1)
  assert(r.dtype=="int64","argpartition 83 dtype")
  assert(eq(r.shape,{5,2}),"argpartition 83 shape")
  assert(eq(r.strides,{16,8}),"argpartition 83 strides")
end
do -- argpartition 84
  local a=np.array({-55,-18,19,56},np.int32)
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 84 dtype")
  assert(eq(r.shape,{4}),"argpartition 84 shape")
  assert(eq(r.strides,{8}),"argpartition 84 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-55,-18,19,56}),"argpartition 84 permutation")
  assert(close(g[1],-55),"argpartition 84 kth 0")
end
do -- argpartition 85
  local a=np.array({-44,-7,30,67,104,-110},np.int8)
  local r=np.argpartition(a,2,1)
  assert(r.dtype=="int64","argpartition 85 dtype")
  assert(eq(r.shape,{6}),"argpartition 85 shape")
  assert(eq(r.strides,{8}),"argpartition 85 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-110,-44,-7,30,67,104}),"argpartition 85 permutation")
  assert(close(g[2],-44),"argpartition 85 kth 1")
end
do -- argpartition 86
  local a=np.array({{92,129,166,203,240},{26,63,100,137,174},{211,248,34,71,108}},np.uint8)
  local r=np.argpartition(a,{2,3},1)
  assert(r.dtype=="int64","argpartition 86 dtype")
  assert(eq(r.shape,{3,5}),"argpartition 86 shape")
  assert(eq(r.strides,{40,8}),"argpartition 86 strides")
end
do -- argpartition 87
  local a=np.array({103,140,177,214,0},np.uint32)
  local r=np.argpartition(a,2,1)
  assert(r.dtype=="int64","argpartition 87 dtype")
  assert(eq(r.shape,{5}),"argpartition 87 shape")
  assert(eq(r.strides,{8}),"argpartition 87 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{0,103,140,177,214}),"argpartition 87 permutation")
  assert(close(g[2],103),"argpartition 87 kth 1")
end
do -- argpartition 88
  local a=np.array({-8.5,-4.249},np.float32)
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 88 dtype")
  assert(eq(r.shape,{2}),"argpartition 88 shape")
  assert(eq(r.strides,{8}),"argpartition 88 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{-8.5,-4.249000072479248}),"argpartition 88 permutation")
  assert(close(g[1],-8.5),"argpartition 88 kth 0")
end
do -- argpartition 89
  local a=np.array({0,37},np.int16)
  local r=np.argpartition(a,{1,2},1)
  assert(r.dtype=="int64","argpartition 89 dtype")
  assert(eq(r.shape,{2}),"argpartition 89 shape")
  assert(eq(r.strides,{8}),"argpartition 89 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{0,37}),"argpartition 89 permutation")
  assert(close(g[1],0),"argpartition 89 kth 0")
  assert(close(g[2],37),"argpartition 89 kth 1")
end
do -- argpartition 90
  local a=np.array({136,173,210,247},np.uint8)
  local r=np.argpartition(a,1,1)
  assert(r.dtype=="int64","argpartition 90 dtype")
  assert(eq(r.shape,{4}),"argpartition 90 shape")
  assert(eq(r.strides,{8}),"argpartition 90 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{136,173,210,247}),"argpartition 90 permutation")
  assert(close(g[1],136),"argpartition 90 kth 0")
end
do -- argpartition 91
  local a=(np.array({{147,184,221,7},{44,81,118,155},{192,229,15,52},{89,126,163,200}},np.uint16)).T
  local r=np.argpartition(a,{1,4},2)
  assert(r.dtype=="int64","argpartition 91 dtype")
  assert(eq(r.shape,{4,4}),"argpartition 91 shape")
  assert(eq(r.strides,{32,8}),"argpartition 91 strides")
end
do -- argpartition 92
  local a=np.array({158,195,232,18,55,92},np.uint16)
  local r=np.argpartition(a,{1,5},1)
  assert(r.dtype=="int64","argpartition 92 dtype")
  assert(eq(r.shape,{6}),"argpartition 92 shape")
  assert(eq(r.strides,{8}),"argpartition 92 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{18,55,92,158,195,232}),"argpartition 92 permutation")
  assert(close(g[1],18),"argpartition 92 kth 0")
  assert(close(g[5],195),"argpartition 92 kth 4")
end
do -- argpartition 93
  local a=np.array({{44,81,118,-96},{-59,-22,15,52},{89,-125,-88,-51},{-14,23,60,97}},np.int16)
  local r=np.argpartition(a,3,2)
  assert(r.dtype=="int64","argpartition 93 dtype")
  assert(eq(r.shape,{4,4}),"argpartition 93 shape")
  assert(eq(r.strides,{32,8}),"argpartition 93 strides")
end
do -- argpartition 94
  local a=(np.array({{55,92,-122,-85,-48},{-11,26,63,100,-114},{-77,-40,-3,34,71},{108,-106,-69,-32,5}},np.int16)).T
  local r=np.argpartition(a,3,2)
  assert(r.dtype=="int64","argpartition 94 dtype")
  assert(eq(r.shape,{5,4}),"argpartition 94 shape")
  assert(eq(r.strides,{32,8}),"argpartition 94 strides")
end
do -- argpartition 95
  local a=np.array({{66,103,-111},{-74,-37,0},{37,74,111},{-103,-66,-29}},np.int32)
  local r=np.argpartition(a,{1,3},1)
  assert(r.dtype=="int64","argpartition 95 dtype")
  assert(eq(r.shape,{4,3}),"argpartition 95 shape")
  assert(eq(r.strides,{24,8}),"argpartition 95 strides")
end
do -- argpartition 96
  local a=np.array({202,239},np.uint8)
  local r=np.argpartition(a,{1,2},1)
  assert(r.dtype=="int64","argpartition 96 dtype")
  assert(eq(r.shape,{2}),"argpartition 96 shape")
  assert(eq(r.strides,{8}),"argpartition 96 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{202,239}),"argpartition 96 permutation")
  assert(close(g[1],202),"argpartition 96 kth 0")
  assert(close(g[2],239),"argpartition 96 kth 1")
end
do -- argpartition 97
  local a=np.array({213,250,36,73},np.uint16)
  local r=np.argpartition(a,{2,4},1)
  assert(r.dtype=="int64","argpartition 97 dtype")
  assert(eq(r.shape,{4}),"argpartition 97 shape")
  assert(eq(r.strides,{8}),"argpartition 97 strides")
  local g=a:get(r); assert(close(np.sort(g):tolist(),{36,73,213,250}),"argpartition 97 permutation")
  assert(close(g[2],73),"argpartition 97 kth 1")
  assert(close(g[4],250),"argpartition 97 kth 3")
end
do -- argpartition 98
  local a=np.array({{99,-115,-78,-41},{-4,33,70,107},{-107,-70,-33,4}},np.int8)
  local r=np.argpartition(a,3,2)
  assert(r.dtype=="int64","argpartition 98 dtype")
  assert(eq(r.shape,{3,4}),"argpartition 98 shape")
  assert(eq(r.strides,{32,8}),"argpartition 98 strides")
end
do -- argpartition 99
  local a=np.array({{110,-104,-67},{-30,7,44},{81,118,-96}},np.int64)
  local r=np.argpartition(a,3,2)
  assert(r.dtype=="int64","argpartition 99 dtype")
  assert(eq(r.shape,{3,3}),"argpartition 99 shape")
  assert(eq(r.strides,{24,8}),"argpartition 99 strides")
end
do local a=np.array({0/0,2,-1,0/0,1},np.float64); local r=np.sort(a,{descending=true}); local t=r:tolist(); assert(t[1]==2 and t[2]==1 and t[3]==-1 and t[4]~=t[4] and t[5]~=t[5],'descending keeps NaN at end') end
do local a=np.array({3,1,2},np.int64); local ret=a:sort(); assert(ret==nil and eq(a:tolist(),{1,2,3}),'ndarray.sort inplace') end
do local a=np.array({3,1,2},np.int64); a:partition(2); local t=a:tolist(); assert(t[2]==2,'ndarray.partition inplace') end
do local a=np.array({3,1,2},np.int64); local ok,e=pcall(function() np.sort(a,{stable=true}) end); assert(not ok and tostring(e):find('stable sorting is not ported yet',1,true),'stable explicit rejection') end
do local a=np.reshape(np.array({4},np.int64),{}); local r=np.argsort(a); assert(eq(r.shape,{1}) and r[1]==1,'0d argsort promotion') end
print('sorting/selection differential: 565 cases ok')
