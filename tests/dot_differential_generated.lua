local np=require("luaray_core")
local function close(a,b)
  if type(a)~=type(b) then return false end
  if type(a)~="table" then
    if type(a)=="number" then if a~=a and b~=b then return true end; if a==b then return true end; return math.abs(a-b)<=math.max(1e-4,math.abs(b)*4e-5) end
    return a==b
  end
  if #a~=#b then return false end; for i=1,#a do if not close(a[i],b[i]) then return false end end; return true
end
-- Generated against development NumPy 2.3.5.
do -- dot 0
  local a=np.zeros({0,1,0,2},np.int64)
  local b=np.array({-0.75,0.125},np.float32)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 0 dtype "..r.dtype)
  assert(close(r.shape,{0,1,0}),"dot 0 shape")
  assert(close(r.strides,{0,0,0}),"dot 0 strides")
  assert(close(r:tolist(),{}),"dot 0 values")
end
do -- dot 1
  local a=np.zeros({2,3,0},np.int16)
  local b=np.zeros({0,4},np.int64)
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 1 dtype "..r.dtype)
  assert(close(r.shape,{2,3,4}),"dot 1 shape")
  assert(close(r.strides,{96,32,8}),"dot 1 strides")
  assert(close(r:tolist(),{{{0,0,0,0},{0,0,0,0},{0,0,0,0}},{{0,0,0,0},{0,0,0,0},{0,0,0,0}}}),"dot 1 values")
end
do -- dot 2
  local a=np.array({true,false,true},np.bool)
  local b=np.array({false,true,true},np.bool)
  local r=np.dot(a,b)
  assert(close(r,true),"dot 2 scalar")
end
do -- dot 3
  local a=np.reshape(np.array({0},np.uint32),{})
  local b=np.array({1,6,4,2,0},np.uint8)
  local r=np.dot(a,b)
  assert(r.dtype=="uint32","dot 3 dtype "..r.dtype)
  assert(close(r.shape,{5}),"dot 3 shape")
  assert(close(r.strides,{4}),"dot 3 strides")
  assert(close(r:tolist(),{0,0,0,0,0}),"dot 3 values")
end
do -- dot 4
  local a=np.array({false,true},np.bool)
  local b=np.array({{{{4,-4,1,6},{-2,3,-5,0}},{{5,-3,2,-6},{-1,4,-4,1}},{{6,-2,3,-5},{0,5,-3,2}}},{{{-6,-1,4,-4},{1,6,-2,3}},{{-5,0,5,-3},{2,-6,-1,4}},{{-4,1,6,-2},{3,-5,0,5}}},{{{-3,2,-6,-1},{4,-4,1,6}},{{-2,3,-5,0},{5,-3,2,-6}},{{-1,4,-4,1},{6,-2,3,-5}}}},np.int32)
  local o=np.zeros({3,3,4},np.int32)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 4 out identity")
  assert(close(r:tolist(),{{{-2,3,-5,0},{-1,4,-4,1},{0,5,-3,2}},{{1,6,-2,3},{2,-6,-1,4},{3,-5,0,5}},{{4,-4,1,6},{5,-3,2,-6},{6,-2,3,-5}}}),"dot 4 out values")
end
do -- dot 5
  local a=np.array({{{4,2,0},{5,3,1}},{{6,4,2},{0,5,3}},{{1,6,4},{2,0,5}}},np.uint8)
  local b=np.array({{{5,3,1},{6,4,2},{0,5,3}},{{1,6,4},{2,0,5},{3,1,6}},{{4,2,0},{5,3,1},{6,4,2}}},np.uint64)
  local r=np.dot(a,b)
  assert(r.dtype=="uint64","dot 5 dtype "..r.dtype)
  assert(close(r.shape,{3,2,3,3}),"dot 5 shape")
  assert(close(r.strides,{144,72,24,8}),"dot 5 strides")
  assert(close(r:tolist(),{{{{32,20,8},{8,24,26},{26,14,2}},{{43,32,14},{14,31,41},{41,23,5}}},{{{54,44,20},{20,38,56},{56,32,8}},{{30,35,19},{19,3,43},{43,27,11}}},{{{41,47,25},{25,10,58},{58,36,14}},{{10,31,17},{17,17,38},{38,24,10}}}}),"dot 5 values")
end
do -- dot 6
  local a=np.zeros({0,3,1,0},np.int8)
  local b=np.zeros({0,0,1},np.float64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 6 dtype "..r.dtype)
  assert(close(r.shape,{0,3,1,0,1}),"dot 6 shape")
  assert(close(r.strides,{0,0,0,0,0}),"dot 6 strides")
  assert(close(r:tolist(),{}),"dot 6 values")
end
do -- dot 7
  local a=np.array({{{1,6,4,2},{0,5,3,1}},{{6,4,2,0},{5,3,1,6}},{{4,2,0,5},{3,1,6,4}}},np.uint16)
  local b=np.array({1.0,-0.25,0.625,-0.625},np.float16)
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 7 dtype "..r.dtype)
  assert(close(r.shape,{3,2}),"dot 7 shape")
  assert(close(r.strides,{8,4}),"dot 7 strides")
  assert(close(r:tolist(),{{0.75,0.0},{6.25,1.125},{0.375,4.0}}),"dot 7 values")
end
do -- dot 8
  local a=(np.zeros({0,3},np.uint16)).T
  local b=np.zeros({0,1},np.uint64)
  local r=np.dot(a,b)
  assert(r.dtype=="uint64","dot 8 dtype "..r.dtype)
  assert(close(r.shape,{3,1}),"dot 8 shape")
  assert(close(r.strides,{8,8}),"dot 8 strides")
  assert(close(r:tolist(),{{0},{0},{0}}),"dot 8 values")
end
do -- dot 9
  local a=np.reshape(np.array({5},np.uint32),{})
  local b=np.array({-0.625},np.float16)
  local o=np.zeros({1},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 9 out identity")
  assert(r.dtype=="float64","dot 9 out dtype")
  assert(close(r.strides,{8}),"dot 9 out strides")
  assert(close(r:tolist(),{-3.125}),"dot 9 out values")
end
do -- dot 10
  local a=np.array({-0.5,0.375,-0.875},np.float64)
  local b=np.reshape(np.array({1},np.uint8),{})
  local o=np.zeros({3},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 10 out identity")
  assert(r.dtype=="float64","dot 10 out dtype")
  assert(close(r.strides,{8}),"dot 10 out strides")
  assert(close(r:tolist(),{-0.5,0.375,-0.875}),"dot 10 out values")
end
do -- dot 11
  local a=np.array({2,0},np.uint16)
  local b=np.reshape(np.array({-0.125},np.float32),{})
  local o=np.zeros({2},np.float32)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 11 out identity")
  assert(r.dtype=="float32","dot 11 out dtype")
  assert(close(r.strides,{4}),"dot 11 out strides")
  assert(close(r:tolist(),{-0.25,0.0}),"dot 11 out values")
end
do -- dot 12
  local a=(np.zeros({0,0},np.int16)).T
  local b=np.zeros({0,0,0,2},np.float64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 12 dtype "..r.dtype)
  assert(close(r.shape,{0,0,0,2}),"dot 12 shape")
  assert(close(r.strides,{0,0,0,0}),"dot 12 strides")
  assert(close(r:tolist(),{}),"dot 12 values")
end
do -- dot 13
  local a=np.array({0.25},np.float16)
  local b=(np.array({{-4},{1},{6}},np.int8)).T
  local o=np.zeros({3},np.float16)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 13 out identity")
  assert(close(r:tolist(),{-1.0,0.25,1.5}),"dot 13 out values")
end
do -- dot 14
  local a=np.zeros({2,2,0,0},np.uint64)
  local b=np.zeros({0},np.uint16)
  local r=np.dot(a,b)
  assert(r.dtype=="uint64","dot 14 dtype "..r.dtype)
  assert(close(r.shape,{2,2,0}),"dot 14 shape")
  assert(close(r.strides,{0,0,0}),"dot 14 strides")
  assert(close(r:tolist(),{{{},{}},{{},{}}}),"dot 14 values")
end
do -- dot 15
  local a=np.array({{3,1,6,4}},np.uint32)
  local b=(np.zeros({0,4},np.int8)).T
  local o=np.zeros({1,0},np.int64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 15 out identity")
  assert(close(r:tolist(),{{}}),"dot 15 out values")
end
do -- dot 16
  local a=np.array({1.0,-0.25,0.625,-0.625,0.25},np.float32)
  local b=np.reshape(np.array({-1.0},np.float16),{})
  local o=np.zeros({5},np.float32)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 16 out identity")
  assert(r.dtype=="float32","dot 16 out dtype")
  assert(close(r.strides,{4}),"dot 16 out strides")
  assert(close(r:tolist(),{-1.0,0.25,-0.625,0.625,-0.25}),"dot 16 out values")
end
do -- dot 17
  local a=np.array({{-0.875,0.0,0.875,-0.375}},np.float32)
  local b=np.zeros({0,4,0},np.float32)
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 17 dtype "..r.dtype)
  assert(close(r.shape,{1,0,0}),"dot 17 shape")
  assert(close(r.strides,{0,0,0}),"dot 17 strides")
  assert(close(r:tolist(),{{}}),"dot 17 values")
end
do -- dot 18
  local a=np.array({{5,-3,2,-6},{-1,4,-4,1},{6,-2,3,-5}},np.int32)
  local b=np.array({{{-0.5,0.375},{-0.875,0.0},{0.875,-0.375},{0.5,-0.75}},{{0.125,1.0},{-0.25,0.625},{-0.625,0.25},{-1.0,-0.125}},{{0.75,-0.5},{0.375,-0.875},{0.0,0.875},{-0.375,0.5}}},np.float16)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 18 dtype "..r.dtype)
  assert(close(r.shape,{3,3,2}),"dot 18 shape")
  assert(close(r.strides,{48,16,8}),"dot 18 strides")
  assert(close(r:tolist(),{{{-1.125,5.625},{6.125,4.375},{4.875,-1.125}},{{-6.0,0.375},{0.375,0.375},{0.375,-6.0}},{{-1.125,4.875},{4.375,6.125},{5.625,-1.125}}}),"dot 18 values")
end
do -- dot 19
  local a=np.array({-6,-1,4,-4},np.int64)
  local b=np.reshape(np.array({5},np.uint8),{})
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 19 dtype "..r.dtype)
  assert(close(r.shape,{4}),"dot 19 shape")
  assert(close(r.strides,{8}),"dot 19 strides")
  assert(close(r:tolist(),{-30,-5,20,-20}),"dot 19 values")
end
do -- dot 20
  local a=np.array({-0.125,0.75,-0.5,0.375,-0.875},np.float64)
  local b=np.reshape(np.array({0.0},np.float32),{})
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 20 dtype "..r.dtype)
  assert(close(r.shape,{5}),"dot 20 shape")
  assert(close(r.strides,{8}),"dot 20 strides")
  assert(close(r:tolist(),{0.0,0.0,0.0,0.0,0.0}),"dot 20 values")
end
do -- dot 21
  local a=np.zeros({0},np.bool)
  local b=np.zeros({0},np.uint16)
  local r=np.dot(a,b)
  assert(close(r,0),"dot 21 scalar")
end
do -- dot 22
  local a=np.array({3,1},np.uint64)
  local b=np.array({{{{1,6,-2,3},{-5,0,5,-3}},{{2,-6,-1,4},{-4,1,6,-2}}}},np.int8)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 22 dtype "..r.dtype)
  assert(close(r.shape,{1,2,4}),"dot 22 shape")
  assert(close(r.strides,{64,32,8}),"dot 22 strides")
  assert(close(r:tolist(),{{{-2.0,18.0,-1.0,6.0},{2.0,-17.0,3.0,10.0}}}),"dot 22 values")
end
do -- dot 23
  local a=np.zeros({1,0},np.uint8)
  local b=np.zeros({2,0,4},np.int32)
  local r=np.dot(a,b)
  assert(r.dtype=="int32","dot 23 dtype "..r.dtype)
  assert(close(r.shape,{1,2,4}),"dot 23 shape")
  assert(close(r.strides,{32,16,4}),"dot 23 strides")
  assert(close(r:tolist(),{{{0,0,0,0},{0,0,0,0}}}),"dot 23 values")
end
do -- dot 24
  local a=np.zeros({0},np.uint64)
  local b=np.reshape(np.array({1.0},np.float64),{})
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 24 dtype "..r.dtype)
  assert(close(r.shape,{0}),"dot 24 shape")
  assert(close(r.strides,{0}),"dot 24 strides")
  assert(close(r:tolist(),{}),"dot 24 values")
end
do -- dot 25
  local a=np.zeros({0,1,1},np.int32)
  local b=np.array({{{-6,-1,4,-4}},{{1,6,-2,3}}},np.int8)
  local r=np.dot(a,b)
  assert(r.dtype=="int32","dot 25 dtype "..r.dtype)
  assert(close(r.shape,{0,1,2,4}),"dot 25 shape")
  assert(close(r.strides,{0,0,0,0}),"dot 25 strides")
  assert(close(r:tolist(),{}),"dot 25 values")
end
do -- dot 26
  local a=np.zeros({3,0},np.uint8)
  local b=np.zeros({1,0,3},np.uint64)
  local r=np.dot(a,b)
  assert(r.dtype=="uint64","dot 26 dtype "..r.dtype)
  assert(close(r.shape,{3,1,3}),"dot 26 shape")
  assert(close(r.strides,{24,24,8}),"dot 26 strides")
  assert(close(r:tolist(),{{{0,0,0}},{{0,0,0}},{{0,0,0}}}),"dot 26 values")
end
do -- dot 27
  local a=np.reshape(np.array({-3},np.int32),{})
  local b=np.array({-2,3,-5},np.int64)
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 27 dtype "..r.dtype)
  assert(close(r.shape,{3}),"dot 27 shape")
  assert(close(r.strides,{8}),"dot 27 strides")
  assert(close(r:tolist(),{6,-9,15}),"dot 27 values")
end
do -- dot 28
  local a=np.array({{{1,6,4}},{{2,0,5}}},np.uint32)
  local b=np.array({2,0,5},np.uint32)
  local o=np.zeros({2,1},np.uint32)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 28 out identity")
  assert(close(r:tolist(),{{22},{29}}),"dot 28 out values")
end
do -- dot 29
  local a=np.reshape(np.array({1},np.int8),{})
  local b=np.array({2,-6,-1,4,-4},np.int8)
  local r=np.dot(a,b)
  assert(r.dtype=="int8","dot 29 dtype "..r.dtype)
  assert(close(r.shape,{5}),"dot 29 shape")
  assert(close(r.strides,{1}),"dot 29 strides")
  assert(close(r:tolist(),{2,-6,-1,4,-4}),"dot 29 values")
end
do -- dot 30
  local a=np.array({{{{0.25}},{{-1.0}}}},np.float16)
  local b=np.array({6},np.uint16)
  local o=np.zeros({1,2,1},np.float32)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 30 out identity")
  assert(close(r:tolist(),{{{1.5},{-6.0}}}),"dot 30 out values")
end
do -- dot 31
  local a=(np.array({{0,5}},np.uint32)).T
  local b=(np.array({{6},{-2},{3},{-5}},np.int64)).T
  local o=np.zeros({2,4},np.int64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 31 out identity")
  assert(close(r:tolist(),{{0,0,0,0},{30,-10,15,-25}}),"dot 31 out values")
end
do -- dot 32
  local a=np.array({-6,-1,4,-4},np.int32)
  local b=np.array({0.875,-0.375,0.5,-0.75},np.float64)
  local r=np.dot(a,b)
  assert(close(r,0.125),"dot 32 scalar")
end
do -- dot 33
  local a=np.array({4},np.uint32)
  local b=np.array({-3},np.int32)
  local r=np.dot(a,b)
  assert(close(r,-12),"dot 33 scalar")
end
do -- dot 34
  local a=np.zeros({1,2,0,1},np.float64)
  local b=np.zeros({0,2,1,0},np.float64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 34 dtype "..r.dtype)
  assert(close(r.shape,{1,2,0,0,2,0}),"dot 34 shape")
  assert(close(r.strides,{0,0,0,0,0,0}),"dot 34 strides")
  assert(close(r:tolist(),{{{},{}}}),"dot 34 values")
end
do -- dot 35
  local a=np.array({{{1},{6},{4}}},np.uint16)
  local b=np.array({false},np.bool)
  local r=np.dot(a,b)
  assert(r.dtype=="uint16","dot 35 dtype "..r.dtype)
  assert(close(r.shape,{1,3}),"dot 35 shape")
  assert(close(r.strides,{6,2}),"dot 35 strides")
  assert(close(r:tolist(),{{0,0,0}}),"dot 35 values")
end
do -- dot 36
  local a=np.zeros({3,2,0,1},np.float64)
  local b=np.array({{{3,-5}},{{0,5}},{{-3,2}}},np.int16)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 36 dtype "..r.dtype)
  assert(close(r.shape,{3,2,0,3,2}),"dot 36 shape")
  assert(close(r.strides,{0,0,0,0,0}),"dot 36 strides")
  assert(close(r:tolist(),{{{},{}},{{},{}},{{},{}}}),"dot 36 values")
end
do -- dot 37
  local a=np.reshape(np.array({-0.125},np.float16),{})
  local b=np.array({5,-3},np.int16)
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 37 dtype "..r.dtype)
  assert(close(r.shape,{2}),"dot 37 shape")
  assert(close(r.strides,{4}),"dot 37 strides")
  assert(close(r:tolist(),{-0.625,0.375}),"dot 37 values")
end
do -- dot 38
  local a=np.zeros({0,3,3,3},np.float32)
  local b=np.zeros({0,0,3,4},np.int64)
  local o=np.zeros({0,3,3,0,0,4},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 38 out identity")
  assert(close(r:tolist(),{}),"dot 38 out values")
end
do -- dot 39
  local a=np.array({{{-5,0,5,-3}},{{2,-6,-1,4}}},np.int64)
  local b=np.zeros({0,4,3},np.int8)
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 39 dtype "..r.dtype)
  assert(close(r.shape,{2,1,0,3}),"dot 39 shape")
  assert(close(r.strides,{0,0,0,0}),"dot 39 strides")
  assert(close(r:tolist(),{{{}},{{}}}),"dot 39 values")
end
do -- dot 40
  local a=np.array({4},np.uint16)
  local b=np.reshape(np.array({0.75},np.float32),{})
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 40 dtype "..r.dtype)
  assert(close(r.shape,{1}),"dot 40 shape")
  assert(close(r.strides,{4}),"dot 40 strides")
  assert(close(r:tolist(),{3.0}),"dot 40 values")
end
do -- dot 41
  local a=np.array({{{{0.875,-0.375,0.5,-0.75},{0.125,1.0,-0.25,0.625}},{{-0.625,0.25,-1.0,-0.125},{0.75,-0.5,0.375,-0.875}},{{0.0,0.875,-0.375,0.5},{-0.75,0.125,1.0,-0.25}}},{{{0.625,-0.625,0.25,-1.0},{-0.125,0.75,-0.5,0.375}},{{-0.875,0.0,0.875,-0.375},{0.5,-0.75,0.125,1.0}},{{-0.25,0.625,-0.625,0.25},{-1.0,-0.125,0.75,-0.5}}},{{{0.375,-0.875,0.0,0.875},{-0.375,0.5,-0.75,0.125}},{{1.0,-0.25,0.625,-0.625},{0.25,-1.0,-0.125,0.75}},{{-0.5,0.375,-0.875,0.0},{0.875,-0.375,0.5,-0.75}}}},np.float32)
  local b=np.zeros({4,0},np.uint32)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 41 dtype "..r.dtype)
  assert(close(r.shape,{3,3,2,0}),"dot 41 shape")
  assert(close(r.strides,{0,0,0,0}),"dot 41 strides")
  assert(close(r:tolist(),{{{{},{}},{{},{}},{{},{}}},{{{},{}},{{},{}},{{},{}}},{{{},{}},{{},{}},{{},{}}}}),"dot 41 values")
end
do -- dot 42
  local a=np.zeros({1,0},np.bool)
  local b=np.zeros({0,0,0,3},np.float64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 42 dtype "..r.dtype)
  assert(close(r.shape,{1,0,0,3}),"dot 42 shape")
  assert(close(r.strides,{0,0,0,0}),"dot 42 strides")
  assert(close(r:tolist(),{{}}),"dot 42 values")
end
do -- dot 43
  local a=np.array({{{-0.75},{0.125},{1.0}},{{-0.25},{0.625},{-0.625}}},np.float16)
  local b=np.zeros({0,1,2},np.float16)
  local r=np.dot(a,b)
  assert(r.dtype=="float16","dot 43 dtype "..r.dtype)
  assert(close(r.shape,{2,3,0,2}),"dot 43 shape")
  assert(close(r.strides,{0,0,0,0}),"dot 43 strides")
  assert(close(r:tolist(),{{{},{},{}},{{},{},{}}}),"dot 43 values")
end
do -- dot 44
  local a=np.array({5,3,1,6},np.uint64)
  local b=np.reshape(np.array({6},np.int8),{})
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 44 dtype "..r.dtype)
  assert(close(r.shape,{4}),"dot 44 shape")
  assert(close(r.strides,{8}),"dot 44 strides")
  assert(close(r:tolist(),{30.0,18.0,6.0,36.0}),"dot 44 values")
end
do -- dot 45
  local a=np.zeros({0,2},np.float16)
  local b=np.array({{true,false,true},{true,false,true}},np.bool)
  local o=np.zeros({0,3},np.float16)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 45 out identity")
  assert(close(r:tolist(),{}),"dot 45 out values")
end
do -- dot 46
  local a=np.zeros({0,3,4},np.int64)
  local b=np.array({3,1,6,4},np.uint32)
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 46 dtype "..r.dtype)
  assert(close(r.shape,{0,3}),"dot 46 shape")
  assert(close(r.strides,{0,0}),"dot 46 strides")
  assert(close(r:tolist(),{}),"dot 46 values")
end
do -- dot 47
  local a=np.zeros({0,4},np.float64)
  local b=np.array({5,3,1,6},np.uint64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 47 dtype "..r.dtype)
  assert(close(r.shape,{0}),"dot 47 shape")
  assert(close(r.strides,{0}),"dot 47 strides")
  assert(close(r:tolist(),{}),"dot 47 values")
end
do -- dot 48
  local a=np.array({{{0},{5}}},np.int32)
  local b=np.array({{1,6,-2,3}},np.int32)
  local o=np.zeros({1,2,4},np.int32)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 48 out identity")
  assert(close(r:tolist(),{{{0,0,0,0},{5,30,-10,15}}}),"dot 48 out values")
end
do -- dot 49
  local a=np.array({1},np.uint8)
  local b=np.reshape(np.array({3},np.int32),{})
  local r=np.dot(a,b)
  assert(r.dtype=="int32","dot 49 dtype "..r.dtype)
  assert(close(r.shape,{1}),"dot 49 shape")
  assert(close(r.strides,{4}),"dot 49 strides")
  assert(close(r:tolist(),{3}),"dot 49 values")
end
do -- dot 50
  local a=np.array({3,1,6,4},np.uint8)
  local b=np.zeros({0,0,4,2},np.uint32)
  local r=np.dot(a,b)
  assert(r.dtype=="uint32","dot 50 dtype "..r.dtype)
  assert(close(r.shape,{0,0,2}),"dot 50 shape")
  assert(close(r.strides,{0,0,0}),"dot 50 strides")
  assert(close(r:tolist(),{}),"dot 50 values")
end
do -- dot 51
  local a=np.array({-0.875,0.0,0.875,-0.375,0.5},np.float16)
  local b=np.reshape(np.array({-0.75},np.float32),{})
  local o=np.zeros({5},np.float32)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 51 out identity")
  assert(r.dtype=="float32","dot 51 out dtype")
  assert(close(r.strides,{4}),"dot 51 out strides")
  assert(close(r:tolist(),{0.65625,0.0,-0.65625,0.28125,-0.375}),"dot 51 out values")
end
do -- dot 52
  local a=np.reshape(np.array({-0.625},np.float32),{})
  local b=np.array({{-4,1,6},{-2,3,-5},{0,5,-3}},np.int16)
  local o=np.zeros({3,3},np.float32)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 52 out identity")
  assert(r.dtype=="float32","dot 52 out dtype")
  assert(close(r.strides,{12,4}),"dot 52 out strides")
  assert(close(r:tolist(),{{2.5,-0.625,-3.75},{1.25,-1.875,3.125},{0.0,-3.125,1.875}}),"dot 52 out values")
end
do -- dot 53
  local a=(np.array({{-0.375,0.5,-0.75}},np.float32)).T
  local b=np.array({-0.25},np.float32)
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 53 dtype "..r.dtype)
  assert(close(r.shape,{3}),"dot 53 shape")
  assert(close(r.strides,{4}),"dot 53 strides")
  assert(close(r:tolist(),{0.09375,-0.125,0.1875}),"dot 53 values")
end
do -- dot 54
  local a=np.array({4,2},np.uint8)
  local b=np.array({{{0,5,-3,2},{-6,-1,4,-4}},{{1,6,-2,3},{-5,0,5,-3}}},np.int64)
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 54 dtype "..r.dtype)
  assert(close(r.shape,{2,4}),"dot 54 shape")
  assert(close(r.strides,{32,8}),"dot 54 strides")
  assert(close(r:tolist(),{{-12,18,-4,0},{-6,24,2,6}}),"dot 54 values")
end
do -- dot 55
  local a=np.array({6,4,2,0,5},np.uint16)
  local b=np.reshape(np.array({2},np.int8),{})
  local r=np.dot(a,b)
  assert(r.dtype=="int32","dot 55 dtype "..r.dtype)
  assert(close(r.shape,{5}),"dot 55 shape")
  assert(close(r.strides,{4}),"dot 55 strides")
  assert(close(r:tolist(),{12,8,4,0,10}),"dot 55 values")
end
do -- dot 56
  local a=np.array({3,-5,0},np.int8)
  local b=np.array({{2,0,5,3},{1,6,4,2},{0,5,3,1}},np.uint8)
  local r=np.dot(a,b)
  assert(r.dtype=="int16","dot 56 dtype "..r.dtype)
  assert(close(r.shape,{4}),"dot 56 shape")
  assert(close(r.strides,{2}),"dot 56 strides")
  assert(close(r:tolist(),{1,-30,-5,-1}),"dot 56 values")
end
do -- dot 57
  local a=np.zeros({0,4},np.uint8)
  local b=np.array({{4},{2},{0},{5}},np.uint8)
  local r=np.dot(a,b)
  assert(r.dtype=="uint8","dot 57 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"dot 57 shape")
  assert(close(r.strides,{0,0}),"dot 57 strides")
  assert(close(r:tolist(),{}),"dot 57 values")
end
do -- dot 58
  local a=np.reshape(np.array({-6},np.int16),{})
  local b=np.zeros({3,0},np.float32)
  local o=np.zeros({3,0},np.float32)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 58 out identity")
  assert(r.dtype=="float32","dot 58 out dtype")
  assert(close(r.strides,{0,0}),"dot 58 out strides")
  assert(close(r:tolist(),{{},{},{}}),"dot 58 out values")
end
do -- dot 59
  local a=np.zeros({0},np.int16)
  local b=np.reshape(np.array({-3},np.int16),{})
  local r=np.dot(a,b)
  assert(r.dtype=="int16","dot 59 dtype "..r.dtype)
  assert(close(r.shape,{0}),"dot 59 shape")
  assert(close(r.strides,{0}),"dot 59 strides")
  assert(close(r:tolist(),{}),"dot 59 values")
end
do -- dot 60
  local a=np.array({2,0},np.uint64)
  local b=np.reshape(np.array({-1},np.int16),{})
  local o=np.zeros({2},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 60 out identity")
  assert(r.dtype=="float64","dot 60 out dtype")
  assert(close(r.strides,{8}),"dot 60 out strides")
  assert(close(r:tolist(),{-2.0,0.0}),"dot 60 out values")
end
do -- dot 61
  local a=np.array({false,true},np.bool)
  local b=np.reshape(np.array({true},np.bool),{})
  local o=np.zeros({2},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 61 out identity")
  assert(r.dtype=="float64","dot 61 out dtype")
  assert(close(r.strides,{8}),"dot 61 out strides")
  assert(close(r:tolist(),{0.0,1.0}),"dot 61 out values")
end
do -- dot 62
  local a=np.array({{6}},np.uint64)
  local b=np.zeros({0,0,1,1},np.uint32)
  local r=np.dot(a,b)
  assert(r.dtype=="uint64","dot 62 dtype "..r.dtype)
  assert(close(r.shape,{1,0,0,1}),"dot 62 shape")
  assert(close(r.strides,{0,0,0,0}),"dot 62 strides")
  assert(close(r:tolist(),{{}}),"dot 62 values")
end
do -- dot 63
  local a=np.array({1},np.uint8)
  local b=np.reshape(np.array({0.125},np.float32),{})
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 63 dtype "..r.dtype)
  assert(close(r.shape,{1}),"dot 63 shape")
  assert(close(r.strides,{4}),"dot 63 strides")
  assert(close(r:tolist(),{0.125}),"dot 63 values")
end
do -- dot 64
  local a=np.zeros({0},np.uint16)
  local b=np.zeros({3,0,2},np.uint16)
  local o=np.zeros({3,2},np.uint16)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 64 out identity")
  assert(close(r:tolist(),{{0,0},{0,0},{0,0}}),"dot 64 out values")
end
do -- dot 65
  local a=np.array({-5,0},np.int64)
  local b=np.array({{{{6,4},{2,0}},{{5,3},{1,6}}},{{{4,2},{0,5}},{{3,1},{6,4}}},{{{2,0},{5,3}},{{1,6},{4,2}}}},np.uint8)
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 65 dtype "..r.dtype)
  assert(close(r.shape,{3,2,2}),"dot 65 shape")
  assert(close(r.strides,{32,16,8}),"dot 65 strides")
  assert(close(r:tolist(),{{{-30,-20},{-25,-15}},{{-20,-10},{-15,-5}},{{-10,0},{-5,-30}}}),"dot 65 values")
end
do -- dot 66
  local a=np.array({0.75,-0.5,0.375},np.float16)
  local b=np.reshape(np.array({1},np.uint32),{})
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 66 dtype "..r.dtype)
  assert(close(r.shape,{3}),"dot 66 shape")
  assert(close(r.strides,{8}),"dot 66 strides")
  assert(close(r:tolist(),{0.75,-0.5,0.375}),"dot 66 values")
end
do -- dot 67
  local a=np.zeros({1,0},np.float64)
  local b=np.zeros({0,0,1},np.float16)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 67 dtype "..r.dtype)
  assert(close(r.shape,{1,0,1}),"dot 67 shape")
  assert(close(r.strides,{0,0,0}),"dot 67 strides")
  assert(close(r:tolist(),{{}}),"dot 67 values")
end
do -- dot 68
  local a=np.array({{1,6,-2,3}},np.int32)
  local b=np.array({{{{5,3,1,6},{4,2,0,5},{3,1,6,4},{2,0,5,3}},{{1,6,4,2},{0,5,3,1},{6,4,2,0},{5,3,1,6}}},{{{4,2,0,5},{3,1,6,4},{2,0,5,3},{1,6,4,2}},{{0,5,3,1},{6,4,2,0},{5,3,1,6},{4,2,0,5}}}},np.uint32)
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 68 dtype "..r.dtype)
  assert(close(r.shape,{1,2,2,4}),"dot 68 shape")
  assert(close(r.strides,{128,64,32,8}),"dot 68 strides")
  assert(close(r:tolist(),{{{{29,13,4,37},{4,37,21,26}},{{21,26,38,29},{38,29,13,4}}}}),"dot 68 values")
end
do -- dot 69
  local a=np.zeros({0,3,1,0},np.int16)
  local b=(np.zeros({0,0},np.uint64)).T
  local o=np.zeros({0,3,1,0},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 69 out identity")
  assert(close(r:tolist(),{}),"dot 69 out values")
end
do -- dot 70
  local a=np.zeros({0,3,2},np.float16)
  local b=np.array({-0.25,0.625},np.float64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 70 dtype "..r.dtype)
  assert(close(r.shape,{0,3}),"dot 70 shape")
  assert(close(r.strides,{0,0}),"dot 70 strides")
  assert(close(r:tolist(),{}),"dot 70 values")
end
do -- dot 71
  local a=np.array({-6,-1,4,-4},np.int32)
  local b=np.reshape(np.array({-5},np.int64),{})
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 71 dtype "..r.dtype)
  assert(close(r.shape,{4}),"dot 71 shape")
  assert(close(r.strides,{8}),"dot 71 strides")
  assert(close(r:tolist(),{30,5,-20,20}),"dot 71 values")
end
do -- dot 72
  local a=np.reshape(np.array({5},np.uint32),{})
  local b=(np.array({{-3,2,-6,-1},{4,-4,1,6},{-2,3,-5,0}},np.int16)).T
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 72 dtype "..r.dtype)
  assert(close(r.shape,{4,3}),"dot 72 shape")
  assert(close(r.strides,{8,32}),"dot 72 strides")
  assert(close(r:tolist(),{{-15,20,-10},{10,-20,15},{-30,5,-25},{-5,30,0}}),"dot 72 values")
end
do -- dot 73
  local a=np.array({0,5,3},np.uint8)
  local b=np.array({{{{1},{6},{4}},{{2},{0},{5}},{{3},{1},{6}}}},np.uint64)
  local r=np.dot(a,b)
  assert(r.dtype=="uint64","dot 73 dtype "..r.dtype)
  assert(close(r.shape,{1,3,1}),"dot 73 shape")
  assert(close(r.strides,{24,8,8}),"dot 73 strides")
  assert(close(r:tolist(),{{{42},{15},{23}}}),"dot 73 values")
end
do -- dot 74
  local a=np.zeros({0,2,4},np.int64)
  local b=np.array({{{1,6,-2,3},{-5,0,5,-3},{2,-6,-1,4},{-4,1,6,-2}},{{3,-5,0,5},{-3,2,-6,-1},{4,-4,1,6},{-2,3,-5,0}},{{5,-3,2,-6},{-1,4,-4,1},{6,-2,3,-5},{0,5,-3,2}}},np.int16)
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 74 dtype "..r.dtype)
  assert(close(r.shape,{0,2,3,4}),"dot 74 shape")
  assert(close(r.strides,{0,0,0,0}),"dot 74 strides")
  assert(close(r:tolist(),{}),"dot 74 values")
end
do -- dot 75
  local a=np.array({true},np.bool)
  local b=np.reshape(np.array({5},np.uint64),{})
  local r=np.dot(a,b)
  assert(r.dtype=="uint64","dot 75 dtype "..r.dtype)
  assert(close(r.shape,{1}),"dot 75 shape")
  assert(close(r.strides,{8}),"dot 75 strides")
  assert(close(r:tolist(),{5}),"dot 75 values")
end
do -- dot 76
  local a=np.array({-1.0,-0.125},np.float16)
  local b=np.array({{-0.875,0.0},{0.875,-0.375}},np.float64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 76 dtype "..r.dtype)
  assert(close(r.shape,{2}),"dot 76 shape")
  assert(close(r.strides,{8}),"dot 76 strides")
  assert(close(r:tolist(),{0.765625,0.046875}),"dot 76 values")
end
do -- dot 77
  local a=np.array({{{{-0.75,0.125}},{{1.0,-0.25}},{{0.625,-0.625}}},{{{0.25,-1.0}},{{-0.125,0.75}},{{-0.5,0.375}}}},np.float16)
  local b=np.array({{2,0},{5,3}},np.uint64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 77 dtype "..r.dtype)
  assert(close(r.shape,{2,3,1,2}),"dot 77 shape")
  assert(close(r.strides,{48,16,16,8}),"dot 77 strides")
  assert(close(r:tolist(),{{{{-0.875,0.375}},{{0.75,-0.75}},{{-1.875,-1.875}}},{{{-4.5,-3.0}},{{3.5,2.25}},{{0.875,1.125}}}}),"dot 77 values")
end
do -- dot 78
  local a=np.array({-0.5},np.float64)
  local b=np.array({4},np.uint8)
  local r=np.dot(a,b)
  assert(close(r,-2.0),"dot 78 scalar")
end
do -- dot 79
  local a=np.zeros({0,0,0,0},np.int64)
  local b=np.zeros({0,0},np.int16)
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 79 dtype "..r.dtype)
  assert(close(r.shape,{0,0,0,0}),"dot 79 shape")
  assert(close(r.strides,{0,0,0,0}),"dot 79 strides")
  assert(close(r:tolist(),{}),"dot 79 values")
end
do -- dot 80
  local a=np.array({{{{0.0,0.875,-0.375},{0.5,-0.75,0.125},{1.0,-0.25,0.625}}}},np.float16)
  local b=np.array({1,6,4},np.uint8)
  local r=np.dot(a,b)
  assert(r.dtype=="float16","dot 80 dtype "..r.dtype)
  assert(close(r.shape,{1,1,3}),"dot 80 shape")
  assert(close(r.strides,{6,6,2}),"dot 80 strides")
  assert(close(r:tolist(),{{{3.75,-3.5,2.0}}}),"dot 80 values")
end
do -- dot 81
  local a=np.zeros({1,0,1},np.bool)
  local b=(np.array({{2},{-6}},np.int8)).T
  local r=np.dot(a,b)
  assert(r.dtype=="int8","dot 81 dtype "..r.dtype)
  assert(close(r.shape,{1,0,2}),"dot 81 shape")
  assert(close(r.strides,{0,0,0}),"dot 81 strides")
  assert(close(r:tolist(),{{}}),"dot 81 values")
end
do -- dot 82
  local a=np.zeros({1,0,0,0},np.int16)
  local b=np.zeros({1,1,0,1},np.int32)
  local o=np.zeros({1,0,0,1,1,1},np.int32)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 82 out identity")
  assert(close(r:tolist(),{{}}),"dot 82 out values")
end
do -- dot 83
  local a=(np.zeros({0,3},np.uint16)).T
  local b=np.zeros({2,0,2},np.uint8)
  local r=np.dot(a,b)
  assert(r.dtype=="uint16","dot 83 dtype "..r.dtype)
  assert(close(r.shape,{3,2,2}),"dot 83 shape")
  assert(close(r.strides,{8,4,2}),"dot 83 strides")
  assert(close(r:tolist(),{{{0,0},{0,0}},{{0,0},{0,0}},{{0,0},{0,0}}}),"dot 83 values")
end
do -- dot 84
  local a=np.zeros({0},np.uint32)
  local b=np.reshape(np.array({2},np.uint8),{})
  local r=np.dot(a,b)
  assert(r.dtype=="uint32","dot 84 dtype "..r.dtype)
  assert(close(r.shape,{0}),"dot 84 shape")
  assert(close(r.strides,{0}),"dot 84 strides")
  assert(close(r:tolist(),{}),"dot 84 values")
end
do -- dot 85
  local a=np.reshape(np.array({-4},np.int16),{})
  local b=np.zeros({0,4},np.bool)
  local r=np.dot(a,b)
  assert(r.dtype=="int16","dot 85 dtype "..r.dtype)
  assert(close(r.shape,{0,4}),"dot 85 shape")
  assert(close(r.strides,{0,0}),"dot 85 strides")
  assert(close(r:tolist(),{}),"dot 85 values")
end
do -- dot 86
  local a=np.array({-0.625,0.25,-1.0,-0.125},np.float32)
  local b=np.reshape(np.array({-1},np.int64),{})
  local o=np.zeros({4},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 86 out identity")
  assert(r.dtype=="float64","dot 86 out dtype")
  assert(close(r.strides,{8}),"dot 86 out strides")
  assert(close(r:tolist(),{0.625,-0.25,1.0,0.125}),"dot 86 out values")
end
do -- dot 87
  local a=np.array({-0.375,0.5,-0.75},np.float32)
  local b=np.array({{{1,6,-2},{3,-5,0},{5,-3,2}}},np.int64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 87 dtype "..r.dtype)
  assert(close(r.shape,{1,3}),"dot 87 shape")
  assert(close(r.strides,{24,8}),"dot 87 strides")
  assert(close(r:tolist(),{{-2.625,-2.5,-0.75}}),"dot 87 values")
end
do -- dot 88
  local a=np.array({2,0,5,3},np.uint16)
  local b=np.reshape(np.array({3},np.int64),{})
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 88 dtype "..r.dtype)
  assert(close(r.shape,{4}),"dot 88 shape")
  assert(close(r.strides,{8}),"dot 88 strides")
  assert(close(r:tolist(),{6,0,15,9}),"dot 88 values")
end
do -- dot 89
  local a=np.array({{4,2,0},{5,3,1}},np.uint16)
  local b=np.array({5,-3,2},np.int8)
  local r=np.dot(a,b)
  assert(r.dtype=="int32","dot 89 dtype "..r.dtype)
  assert(close(r.shape,{2}),"dot 89 shape")
  assert(close(r.strides,{4}),"dot 89 strides")
  assert(close(r:tolist(),{14,18}),"dot 89 values")
end
do -- dot 90
  local a=np.array({0.375,-0.875,0.0,0.875},np.float64)
  local b=np.zeros({4,0},np.bool)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 90 dtype "..r.dtype)
  assert(close(r.shape,{0}),"dot 90 shape")
  assert(close(r.strides,{0}),"dot 90 strides")
  assert(close(r:tolist(),{}),"dot 90 values")
end
do -- dot 91
  local a=np.zeros({0,3},np.uint64)
  local b=np.zeros({0,2,3,2},np.int64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 91 dtype "..r.dtype)
  assert(close(r.shape,{0,0,2,2}),"dot 91 shape")
  assert(close(r.strides,{0,0,0,0}),"dot 91 strides")
  assert(close(r:tolist(),{}),"dot 91 values")
end
do -- dot 92
  local a=np.reshape(np.array({-3},np.int8),{})
  local b=np.array({-2,3,-5,0,5},np.int16)
  local r=np.dot(a,b)
  assert(r.dtype=="int16","dot 92 dtype "..r.dtype)
  assert(close(r.shape,{5}),"dot 92 shape")
  assert(close(r.strides,{2}),"dot 92 strides")
  assert(close(r:tolist(),{6,-9,15,0,-15}),"dot 92 values")
end
do -- dot 93
  local a=np.array({-1},np.int8)
  local b=np.reshape(np.array({6},np.uint8),{})
  local r=np.dot(a,b)
  assert(r.dtype=="int16","dot 93 dtype "..r.dtype)
  assert(close(r.shape,{1}),"dot 93 shape")
  assert(close(r.strides,{2}),"dot 93 strides")
  assert(close(r:tolist(),{-6}),"dot 93 values")
end
do -- dot 94
  local a=np.array({-0.75,0.125},np.float64)
  local b=np.reshape(np.array({1},np.uint16),{})
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 94 dtype "..r.dtype)
  assert(close(r.shape,{2}),"dot 94 shape")
  assert(close(r.strides,{8}),"dot 94 strides")
  assert(close(r:tolist(),{-0.75,0.125}),"dot 94 values")
end
do -- dot 95
  local a=np.array({{{3,-5,0,5}}},np.int64)
  local b=np.zeros({0,1,4,3},np.float64)
  local o=np.zeros({1,1,0,1,3},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 95 out identity")
  assert(close(r:tolist(),{{{}}}),"dot 95 out values")
end
do -- dot 96
  local a=np.array({4,2,0},np.uint8)
  local b=np.reshape(np.array({-0.125},np.float64),{})
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 96 dtype "..r.dtype)
  assert(close(r.shape,{3}),"dot 96 shape")
  assert(close(r.strides,{8}),"dot 96 strides")
  assert(close(r:tolist(),{-0.5,-0.25,0.0}),"dot 96 values")
end
do -- dot 97
  local a=np.array({-6,-1,4,-4,1},np.int8)
  local b=np.reshape(np.array({-5},np.int16),{})
  local r=np.dot(a,b)
  assert(r.dtype=="int16","dot 97 dtype "..r.dtype)
  assert(close(r.shape,{5}),"dot 97 shape")
  assert(close(r.strides,{2}),"dot 97 strides")
  assert(close(r:tolist(),{30,5,-20,20,-5}),"dot 97 values")
end
do -- dot 98
  local a=np.reshape(np.array({0.25},np.float16),{})
  local b=np.array({0.375,-0.875,0.0},np.float32)
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 98 dtype "..r.dtype)
  assert(close(r.shape,{3}),"dot 98 shape")
  assert(close(r.strides,{4}),"dot 98 strides")
  assert(close(r:tolist(),{0.09375,-0.21875,0.0}),"dot 98 values")
end
do -- dot 99
  local a=np.reshape(np.array({3},np.uint8),{})
  local b=np.array({-1,4,-4,1},np.int16)
  local o=np.zeros({4},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 99 out identity")
  assert(r.dtype=="float64","dot 99 out dtype")
  assert(close(r.strides,{8}),"dot 99 out strides")
  assert(close(r:tolist(),{-3.0,12.0,-12.0,3.0}),"dot 99 out values")
end
do -- dot 100
  local a=np.zeros({2,0,0,1},np.uint64)
  local b=np.zeros({0,1,1},np.uint32)
  local r=np.dot(a,b)
  assert(r.dtype=="uint64","dot 100 dtype "..r.dtype)
  assert(close(r.shape,{2,0,0,0,1}),"dot 100 shape")
  assert(close(r.strides,{0,0,0,0,0}),"dot 100 strides")
  assert(close(r:tolist(),{{},{}}),"dot 100 values")
end
do -- dot 101
  local a=np.array({true,false},np.bool)
  local b=np.array({3,-5},np.int8)
  local r=np.dot(a,b)
  assert(close(r,3),"dot 101 scalar")
end
do -- dot 102
  local a=np.zeros({0,3,3,4},np.uint16)
  local b=np.zeros({0,4,1},np.uint32)
  local r=np.dot(a,b)
  assert(r.dtype=="uint32","dot 102 dtype "..r.dtype)
  assert(close(r.shape,{0,3,3,0,1}),"dot 102 shape")
  assert(close(r.strides,{0,0,0,0,0}),"dot 102 strides")
  assert(close(r:tolist(),{}),"dot 102 values")
end
do -- dot 103
  local a=np.zeros({2,0,0},np.uint64)
  local b=np.zeros({2,0,3},np.int16)
  local o=np.zeros({2,0,2,3},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 103 out identity")
  assert(close(r:tolist(),{{},{}}),"dot 103 out values")
end
do -- dot 104
  local a=np.array({-0.375,0.5,-0.75,0.125,1.0},np.float32)
  local b=np.reshape(np.array({0},np.uint8),{})
  local o=np.zeros({5},np.float32)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 104 out identity")
  assert(r.dtype=="float32","dot 104 out dtype")
  assert(close(r.strides,{4}),"dot 104 out strides")
  assert(close(r:tolist(),{0.0,0.0,0.0,0.0,0.0}),"dot 104 out values")
end
do -- dot 105
  local a=np.reshape(np.array({true},np.bool),{})
  local b=np.array({2,0,5,3},np.uint16)
  local r=np.dot(a,b)
  assert(r.dtype=="uint16","dot 105 dtype "..r.dtype)
  assert(close(r.shape,{4}),"dot 105 shape")
  assert(close(r.strides,{2}),"dot 105 strides")
  assert(close(r:tolist(),{2,0,5,3}),"dot 105 values")
end
do -- dot 106
  local a=np.zeros({2,2,0,2},np.float64)
  local b=np.array({{0,5,-3},{2,-6,-1}},np.int64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 106 dtype "..r.dtype)
  assert(close(r.shape,{2,2,0,3}),"dot 106 shape")
  assert(close(r.strides,{0,0,0,0}),"dot 106 strides")
  assert(close(r:tolist(),{{{},{}},{{},{}}}),"dot 106 values")
end
do -- dot 107
  local a=np.zeros({2,0,2,1},np.int64)
  local b=np.array({6},np.uint8)
  local o=np.zeros({2,0,2},np.int64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 107 out identity")
  assert(close(r:tolist(),{{},{}}),"dot 107 out values")
end
do -- dot 108
  local a=np.zeros({0},np.uint32)
  local b=np.zeros({0,0,0},np.float16)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 108 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"dot 108 shape")
  assert(close(r.strides,{0,0}),"dot 108 strides")
  assert(close(r:tolist(),{}),"dot 108 values")
end
do -- dot 109
  local a=np.reshape(np.array({0.875},np.float32),{})
  local b=np.zeros({0,2},np.uint8)
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 109 dtype "..r.dtype)
  assert(close(r.shape,{0,2}),"dot 109 shape")
  assert(close(r.strides,{0,0}),"dot 109 strides")
  assert(close(r:tolist(),{}),"dot 109 values")
end
do -- dot 110
  local a=np.reshape(np.array({true},np.bool),{})
  local b=np.array({{-5,0,5,-3},{2,-6,-1,4},{-4,1,6,-2},{3,-5,0,5}},np.int8)
  local r=np.dot(a,b)
  assert(r.dtype=="int8","dot 110 dtype "..r.dtype)
  assert(close(r.shape,{4,4}),"dot 110 shape")
  assert(close(r.strides,{4,1}),"dot 110 strides")
  assert(close(r:tolist(),{{-5,0,5,-3},{2,-6,-1,4},{-4,1,6,-2},{3,-5,0,5}}),"dot 110 values")
end
do -- dot 111
  local a=np.zeros({2,0,3},np.int8)
  local b=np.array({{true},{false},{true}},np.bool)
  local r=np.dot(a,b)
  assert(r.dtype=="int8","dot 111 dtype "..r.dtype)
  assert(close(r.shape,{2,0,1}),"dot 111 shape")
  assert(close(r.strides,{0,0,0}),"dot 111 strides")
  assert(close(r:tolist(),{{},{}}),"dot 111 values")
end
do -- dot 112
  local a=np.reshape(np.array({1},np.uint32),{})
  local b=np.zeros({0,4},np.uint64)
  local ob=np.zeros({4,0},np.uint64)
  local o=ob.T
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 112 out identity")
  assert(r.dtype=="uint64","dot 112 out dtype")
  assert(close(r.strides,{0,0}),"dot 112 out strides")
  assert(close(r:tolist(),{}),"dot 112 out values")
end
do -- dot 113
  local a=np.array({{3}},np.uint64)
  local b=np.array({{false,true}},np.bool)
  local r=np.dot(a,b)
  assert(r.dtype=="uint64","dot 113 dtype "..r.dtype)
  assert(close(r.shape,{1,2}),"dot 113 shape")
  assert(close(r.strides,{16,8}),"dot 113 strides")
  assert(close(r:tolist(),{{0,3}}),"dot 113 values")
end
do -- dot 114
  local a=np.zeros({0},np.int64)
  local b=np.zeros({2,0,0},np.int64)
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 114 dtype "..r.dtype)
  assert(close(r.shape,{2,0}),"dot 114 shape")
  assert(close(r.strides,{0,0}),"dot 114 strides")
  assert(close(r:tolist(),{{},{}}),"dot 114 values")
end
do -- dot 115
  local a=np.reshape(np.array({0},np.uint32),{})
  local b=np.array({{5,-3,2,-6},{-1,4,-4,1}},np.int64)
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 115 dtype "..r.dtype)
  assert(close(r.shape,{2,4}),"dot 115 shape")
  assert(close(r.strides,{32,8}),"dot 115 strides")
  assert(close(r:tolist(),{{0,0,0,0},{0,0,0,0}}),"dot 115 values")
end
do -- dot 116
  local a=np.zeros({3,1,0,1},np.int16)
  local b=np.array({{3,1,6}},np.uint64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 116 dtype "..r.dtype)
  assert(close(r.shape,{3,1,0,3}),"dot 116 shape")
  assert(close(r.strides,{0,0,0,0}),"dot 116 strides")
  assert(close(r:tolist(),{{{}},{{}},{{}}}),"dot 116 values")
end
do -- dot 117
  local a=np.array({{{-5,0,5,-3}}},np.int16)
  local b=np.array({-4,1,6,-2},np.int64)
  local o=np.zeros({1,1},np.int64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 117 out identity")
  assert(close(r:tolist(),{{56}}),"dot 117 out values")
end
do -- dot 118
  local a=np.zeros({1,0,3,0},np.int32)
  local b=np.zeros({0},np.float64)
  local o=np.zeros({1,0,3},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 118 out identity")
  assert(close(r:tolist(),{{}}),"dot 118 out values")
end
do -- dot 119
  local a=np.array({{{-1,4,-4},{1,6,-2},{3,-5,0}}},np.int8)
  local b=np.array({{{2,0,5},{3,1,6},{4,2,0}},{{5,3,1},{6,4,2},{0,5,3}},{{1,6,4},{2,0,5},{3,1,6}}},np.uint32)
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 119 dtype "..r.dtype)
  assert(close(r.shape,{1,3,3,3}),"dot 119 shape")
  assert(close(r.strides,{216,72,24,8}),"dot 119 strides")
  assert(close(r:tolist(),{{{{-6,-4,19},{19,-7,-5},{-5,-10,-8}},{{12,2,41},{41,17,7},{7,4,22}},{{-9,-5,-15},{-15,-11,-7},{-7,18,-13}}}}),"dot 119 values")
end
do -- dot 120
  local a=np.zeros({0,1,0},np.int16)
  local b=np.zeros({0},np.uint8)
  local r=np.dot(a,b)
  assert(r.dtype=="int16","dot 120 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"dot 120 shape")
  assert(close(r.strides,{0,0}),"dot 120 strides")
  assert(close(r:tolist(),{}),"dot 120 values")
end
do -- dot 121
  local a=np.array({false,true,true,false},np.bool)
  local b=np.array({{{{-0.25},{0.625},{-0.625},{0.25}},{{-1.0},{-0.125},{0.75},{-0.5}},{{0.375},{-0.875},{0.0},{0.875}}}},np.float16)
  local r=np.dot(a,b)
  assert(r.dtype=="float16","dot 121 dtype "..r.dtype)
  assert(close(r.shape,{1,3,1}),"dot 121 shape")
  assert(close(r.strides,{6,2,2}),"dot 121 strides")
  assert(close(r:tolist(),{{{0.0},{0.625},{-0.875}}}),"dot 121 values")
end
do -- dot 122
  local a=np.array({{5,-3,2,-6},{-1,4,-4,1}},np.int8)
  local b=np.array({{{{6},{-2},{3},{-5}}},{{{0},{5},{-3},{2}}}},np.int64)
  local o=np.zeros({2,2,1,1},np.int64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 122 out identity")
  assert(close(r:tolist(),{{{{72}},{{-33}}},{{{-31}},{{34}}}}),"dot 122 out values")
end
do -- dot 123
  local a=np.array({{{0.125,1.0,-0.25,0.625},{-0.625,0.25,-1.0,-0.125}},{{0.75,-0.5,0.375,-0.875},{0.0,0.875,-0.375,0.5}}},np.float64)
  local b=np.array({{{{-5,0,5},{-3,2,-6},{-1,4,-4},{1,6,-2}}}},np.int8)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 123 dtype "..r.dtype)
  assert(close(r.shape,{2,2,1,1,3}),"dot 123 shape")
  assert(close(r.strides,{48,24,24,24,8}),"dot 123 strides")
  assert(close(r:tolist(),{{{{{-2.75,4.75,-5.625}}},{{{3.25,-4.25,-0.375}}}},{{{{-3.5,-4.75,7.0}}},{{{-1.75,3.25,-4.75}}}}}),"dot 123 values")
end
do -- dot 124
  local a=np.reshape(np.array({4},np.uint16),{})
  local b=np.array({{true,true,false,true},{true,false,true,true},{false,true,true,false},{true,true,false,true}},np.bool)
  local r=np.dot(a,b)
  assert(r.dtype=="uint16","dot 124 dtype "..r.dtype)
  assert(close(r.shape,{4,4}),"dot 124 shape")
  assert(close(r.strides,{8,2}),"dot 124 strides")
  assert(close(r:tolist(),{{4,4,0,4},{4,0,4,4},{0,4,4,0},{4,4,0,4}}),"dot 124 values")
end
do -- dot 125
  local a=(np.array({{6,4,2},{0,5,3},{1,6,4}},np.uint16)).T
  local b=np.array({false,true,true},np.bool)
  local r=np.dot(a,b)
  assert(r.dtype=="uint16","dot 125 dtype "..r.dtype)
  assert(close(r.shape,{3}),"dot 125 shape")
  assert(close(r.strides,{2}),"dot 125 strides")
  assert(close(r:tolist(),{1,11,7}),"dot 125 values")
end
do -- dot 126
  local a=np.array({0,5},np.int64)
  local b=np.array({{1},{6}},np.int64)
  local o=np.zeros({1},np.int64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 126 out identity")
  assert(close(r:tolist(),{30}),"dot 126 out values")
end
do -- dot 127
  local a=np.array({{-1.0,-0.125},{0.75,-0.5}},np.float64)
  local b=np.zeros({1,2,0},np.uint8)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 127 dtype "..r.dtype)
  assert(close(r.shape,{2,1,0}),"dot 127 shape")
  assert(close(r.strides,{0,0,0}),"dot 127 strides")
  assert(close(r:tolist(),{{{}},{{}}}),"dot 127 values")
end
do -- dot 128
  local a=np.array({{{{5,3,1,6}},{{4,2,0,5}}},{{{3,1,6,4}},{{2,0,5,3}}},{{{1,6,4,2}},{{0,5,3,1}}}},np.uint8)
  local b=np.zeros({1,4,0},np.uint8)
  local r=np.dot(a,b)
  assert(r.dtype=="uint8","dot 128 dtype "..r.dtype)
  assert(close(r.shape,{3,2,1,1,0}),"dot 128 shape")
  assert(close(r.strides,{0,0,0,0,0}),"dot 128 strides")
  assert(close(r:tolist(),{{{{{}}},{{{}}}},{{{{}}},{{{}}}},{{{{}}},{{{}}}}}),"dot 128 values")
end
do -- dot 129
  local a=np.array({{{0,5,3,1}},{{6,4,2,0}},{{5,3,1,6}}},np.uint32)
  local b=np.zeros({3,4,0},np.float32)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 129 dtype "..r.dtype)
  assert(close(r.shape,{3,1,3,0}),"dot 129 shape")
  assert(close(r.strides,{0,0,0,0}),"dot 129 strides")
  assert(close(r:tolist(),{{{{},{},{}}},{{{},{},{}}},{{{},{},{}}}}),"dot 129 values")
end
do -- dot 130
  local a=np.array({{{{-5}},{{0}}}},np.int16)
  local b=np.array({3},np.uint32)
  local o=np.zeros({1,2,1},np.int64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 130 out identity")
  assert(close(r:tolist(),{{{-15},{0}}}),"dot 130 out values")
end
do -- dot 131
  local a=np.array({{{-3,2,-6}},{{-1,4,-4}}},np.int16)
  local b=np.array({{{-2,3,-5},{0,5,-3},{2,-6,-1}}},np.int32)
  local r=np.dot(a,b)
  assert(r.dtype=="int32","dot 131 dtype "..r.dtype)
  assert(close(r.shape,{2,1,1,3}),"dot 131 shape")
  assert(close(r.strides,{12,12,12,4}),"dot 131 strides")
  assert(close(r:tolist(),{{{{-6,37,15}}},{{{-6,41,-3}}}}),"dot 131 values")
end
do -- dot 132
  local a=np.reshape(np.array({0.25},np.float64),{})
  local b=np.array({{0,5},{-3,2},{-6,-1}},np.int64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 132 dtype "..r.dtype)
  assert(close(r.shape,{3,2}),"dot 132 shape")
  assert(close(r.strides,{16,8}),"dot 132 strides")
  assert(close(r:tolist(),{{0.0,1.25},{-0.75,0.5},{-1.5,-0.25}}),"dot 132 values")
end
do -- dot 133
  local a=np.array({{0.5,-0.75,0.125,1.0},{-0.25,0.625,-0.625,0.25},{-1.0,-0.125,0.75,-0.5}},np.float32)
  local b=np.zeros({1,0,4,4},np.float16)
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 133 dtype "..r.dtype)
  assert(close(r.shape,{3,1,0,4}),"dot 133 shape")
  assert(close(r.strides,{0,0,0,0}),"dot 133 strides")
  assert(close(r:tolist(),{{{}},{{}},{{}}}),"dot 133 values")
end
do -- dot 134
  local a=np.zeros({0},np.int64)
  local b=np.reshape(np.array({4},np.int64),{})
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 134 dtype "..r.dtype)
  assert(close(r.shape,{0}),"dot 134 shape")
  assert(close(r.strides,{0}),"dot 134 strides")
  assert(close(r:tolist(),{}),"dot 134 values")
end
do -- dot 135
  local a=np.array({{1.0,-0.25,0.625,-0.625},{0.25,-1.0,-0.125,0.75}},np.float64)
  local b=np.array({6,-2,3,-5},np.int64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 135 dtype "..r.dtype)
  assert(close(r.shape,{2}),"dot 135 shape")
  assert(close(r.strides,{8}),"dot 135 strides")
  assert(close(r:tolist(),{11.5,-0.625}),"dot 135 values")
end
do -- dot 136
  local a=np.zeros({0,0,3},np.int16)
  local b=np.zeros({2,1,3,0},np.int8)
  local r=np.dot(a,b)
  assert(r.dtype=="int16","dot 136 dtype "..r.dtype)
  assert(close(r.shape,{0,0,2,1,0}),"dot 136 shape")
  assert(close(r.strides,{0,0,0,0,0}),"dot 136 strides")
  assert(close(r:tolist(),{}),"dot 136 values")
end
do -- dot 137
  local a=np.array({-0.625,0.25,-1.0},np.float16)
  local b=np.zeros({0,3,3,3},np.uint32)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 137 dtype "..r.dtype)
  assert(close(r.shape,{0,3,3}),"dot 137 shape")
  assert(close(r.strides,{0,0,0}),"dot 137 strides")
  assert(close(r:tolist(),{}),"dot 137 values")
end
do -- dot 138
  local a=np.zeros({1,0,4},np.float32)
  local b=np.array({{{-0.25,0.625,-0.625,0.25},{-1.0,-0.125,0.75,-0.5},{0.375,-0.875,0.0,0.875},{-0.375,0.5,-0.75,0.125}},{{1.0,-0.25,0.625,-0.625},{0.25,-1.0,-0.125,0.75},{-0.5,0.375,-0.875,0.0},{0.875,-0.375,0.5,-0.75}},{{0.125,1.0,-0.25,0.625},{-0.625,0.25,-1.0,-0.125},{0.75,-0.5,0.375,-0.875},{0.0,0.875,-0.375,0.5}}},np.float32)
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 138 dtype "..r.dtype)
  assert(close(r.shape,{1,0,3,4}),"dot 138 shape")
  assert(close(r.strides,{0,0,0,0}),"dot 138 strides")
  assert(close(r:tolist(),{{}}),"dot 138 values")
end
do -- dot 139
  local a=np.array({-0.125,0.75,-0.5,0.375},np.float64)
  local b=np.array({1,6,-2,3},np.int8)
  local r=np.dot(a,b)
  assert(close(r,6.5),"dot 139 scalar")
end
do -- dot 140
  local a=np.zeros({0,0,0},np.uint8)
  local b=np.zeros({0},np.int32)
  local o=np.zeros({0,0},np.int32)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 140 out identity")
  assert(close(r:tolist(),{}),"dot 140 out values")
end
do -- dot 141
  local a=np.zeros({0},np.uint8)
  local b=np.zeros({0,2},np.bool)
  local r=np.dot(a,b)
  assert(r.dtype=="uint8","dot 141 dtype "..r.dtype)
  assert(close(r.shape,{2}),"dot 141 shape")
  assert(close(r.strides,{1}),"dot 141 strides")
  assert(close(r:tolist(),{0,0}),"dot 141 values")
end
do -- dot 142
  local a=np.array({{5,3,1},{6,4,2},{0,5,3}},np.uint16)
  local b=(np.zeros({0,3},np.uint8)).T
  local r=np.dot(a,b)
  assert(r.dtype=="uint16","dot 142 dtype "..r.dtype)
  assert(close(r.shape,{3,0}),"dot 142 shape")
  assert(close(r.strides,{0,0}),"dot 142 strides")
  assert(close(r:tolist(),{{},{},{}}),"dot 142 values")
end
do -- dot 143
  local a=np.zeros({0,3,0},np.int32)
  local b=np.zeros({1,1,0,1},np.float64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 143 dtype "..r.dtype)
  assert(close(r.shape,{0,3,1,1,1}),"dot 143 shape")
  assert(close(r.strides,{0,0,0,0,0}),"dot 143 strides")
  assert(close(r:tolist(),{}),"dot 143 values")
end
do -- dot 144
  local a=np.zeros({3,0},np.int8)
  local b=np.zeros({1,3,0,1},np.int32)
  local o=np.zeros({3,1,3,1},np.int32)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 144 out identity")
  assert(close(r:tolist(),{{{{0},{0},{0}}},{{{0},{0},{0}}},{{{0},{0},{0}}}}),"dot 144 out values")
end
do -- dot 145
  local a=np.reshape(np.array({-1},np.int16),{})
  local b=np.zeros({1,0},np.int32)
  local ob=np.zeros({0,1},np.float64)
  local o=ob.T
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 145 out identity")
  assert(r.dtype=="float64","dot 145 out dtype")
  assert(close(r.strides,{0,0}),"dot 145 out strides")
  assert(close(r:tolist(),{{}}),"dot 145 out values")
end
do -- dot 146
  local a=np.array({-0.5,0.375,-0.875,0.0,0.875},np.float64)
  local b=np.reshape(np.array({0},np.uint32),{})
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 146 dtype "..r.dtype)
  assert(close(r.shape,{5}),"dot 146 shape")
  assert(close(r.strides,{8}),"dot 146 strides")
  assert(close(r:tolist(),{0.0,0.0,0.0,0.0,0.0}),"dot 146 values")
end
do -- dot 147
  local a=np.zeros({0},np.uint32)
  local b=np.reshape(np.array({true},np.bool),{})
  local r=np.dot(a,b)
  assert(r.dtype=="uint32","dot 147 dtype "..r.dtype)
  assert(close(r.shape,{0}),"dot 147 shape")
  assert(close(r.strides,{0}),"dot 147 strides")
  assert(close(r:tolist(),{}),"dot 147 values")
end
do -- dot 148
  local a=np.array({{5,-3,2,-6},{-1,4,-4,1},{6,-2,3,-5}},np.int64)
  local b=np.array({4,2,0,5},np.uint8)
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 148 dtype "..r.dtype)
  assert(close(r.shape,{3}),"dot 148 shape")
  assert(close(r.strides,{8}),"dot 148 strides")
  assert(close(r:tolist(),{-16,9,-5}),"dot 148 values")
end
do -- dot 149
  local a=np.array({0.25},np.float32)
  local b=np.reshape(np.array({-5},np.int64),{})
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 149 dtype "..r.dtype)
  assert(close(r.shape,{1}),"dot 149 shape")
  assert(close(r.strides,{8}),"dot 149 strides")
  assert(close(r:tolist(),{-1.25}),"dot 149 values")
end
do -- dot 150
  local a=np.array({0.5,-0.75,0.125,1.0},np.float16)
  local b=np.reshape(np.array({-3},np.int64),{})
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 150 dtype "..r.dtype)
  assert(close(r.shape,{4}),"dot 150 shape")
  assert(close(r.strides,{8}),"dot 150 strides")
  assert(close(r:tolist(),{-1.5,2.25,-0.375,-3.0}),"dot 150 values")
end
do -- dot 151
  local a=np.reshape(np.array({-2},np.int16),{})
  local b=np.array({-1,4,-4},np.int16)
  local r=np.dot(a,b)
  assert(r.dtype=="int16","dot 151 dtype "..r.dtype)
  assert(close(r.shape,{3}),"dot 151 shape")
  assert(close(r.strides,{2}),"dot 151 strides")
  assert(close(r:tolist(),{2,-8,8}),"dot 151 values")
end
do -- dot 152
  local a=np.reshape(np.array({4},np.uint64),{})
  local b=np.array({-1.0,-0.125,0.75,-0.5},np.float64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 152 dtype "..r.dtype)
  assert(close(r.shape,{4}),"dot 152 shape")
  assert(close(r.strides,{8}),"dot 152 strides")
  assert(close(r:tolist(),{-4.0,-0.5,3.0,-2.0}),"dot 152 values")
end
do -- dot 153
  local a=np.array({6,4,2,0},np.uint8)
  local b=np.reshape(np.array({-0.75},np.float32),{})
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 153 dtype "..r.dtype)
  assert(close(r.shape,{4}),"dot 153 shape")
  assert(close(r.strides,{4}),"dot 153 strides")
  assert(close(r:tolist(),{-4.5,-3.0,-1.5,0.0}),"dot 153 values")
end
do -- dot 154
  local a=np.array({4,-4},np.int16)
  local b=(np.array({{2,0},{5,3}},np.uint8)).T
  local r=np.dot(a,b)
  assert(r.dtype=="int16","dot 154 dtype "..r.dtype)
  assert(close(r.shape,{2}),"dot 154 shape")
  assert(close(r.strides,{2}),"dot 154 strides")
  assert(close(r:tolist(),{8,8}),"dot 154 values")
end
do -- dot 155
  local a=np.reshape(np.array({6},np.int8),{})
  local b=np.array({-0.25,0.625,-0.625},np.float64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 155 dtype "..r.dtype)
  assert(close(r.shape,{3}),"dot 155 shape")
  assert(close(r.strides,{8}),"dot 155 strides")
  assert(close(r:tolist(),{-1.5,3.75,-3.75}),"dot 155 values")
end
do -- dot 156
  local a=np.zeros({0},np.float16)
  local b=np.reshape(np.array({0.0},np.float32),{})
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 156 dtype "..r.dtype)
  assert(close(r.shape,{0}),"dot 156 shape")
  assert(close(r.strides,{0}),"dot 156 strides")
  assert(close(r:tolist(),{}),"dot 156 values")
end
do -- dot 157
  local a=np.array({-3},np.int16)
  local b=np.reshape(np.array({true},np.bool),{})
  local o=np.zeros({1},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 157 out identity")
  assert(r.dtype=="float64","dot 157 out dtype")
  assert(close(r.strides,{8}),"dot 157 out strides")
  assert(close(r:tolist(),{-3.0}),"dot 157 out values")
end
do -- dot 158
  local a=np.zeros({0},np.int8)
  local b=np.zeros({0,0},np.float64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 158 dtype "..r.dtype)
  assert(close(r.shape,{0}),"dot 158 shape")
  assert(close(r.strides,{0}),"dot 158 strides")
  assert(close(r:tolist(),{}),"dot 158 values")
end
do -- dot 159
  local a=np.zeros({0},np.int64)
  local b=np.reshape(np.array({5},np.uint32),{})
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 159 dtype "..r.dtype)
  assert(close(r.shape,{0}),"dot 159 shape")
  assert(close(r.strides,{0}),"dot 159 strides")
  assert(close(r:tolist(),{}),"dot 159 values")
end
do -- dot 160
  local a=np.array({3,-5,0},np.int64)
  local b=np.zeros({0,3,0},np.uint64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 160 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"dot 160 shape")
  assert(close(r.strides,{0,0}),"dot 160 strides")
  assert(close(r:tolist(),{}),"dot 160 values")
end
do -- dot 161
  local a=np.array({1},np.uint64)
  local b=np.reshape(np.array({2},np.uint32),{})
  local o=np.zeros({1},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 161 out identity")
  assert(r.dtype=="float64","dot 161 out dtype")
  assert(close(r.strides,{8}),"dot 161 out strides")
  assert(close(r:tolist(),{2.0}),"dot 161 out values")
end
do -- dot 162
  local a=np.reshape(np.array({3},np.uint8),{})
  local b=np.array({4,2,0,5,3},np.uint32)
  local r=np.dot(a,b)
  assert(r.dtype=="uint32","dot 162 dtype "..r.dtype)
  assert(close(r.shape,{5}),"dot 162 shape")
  assert(close(r.strides,{4}),"dot 162 strides")
  assert(close(r:tolist(),{12,6,0,15,9}),"dot 162 values")
end
do -- dot 163
  local a=np.zeros({1,2,0,4},np.int16)
  local b=np.array({true,true,false,true},np.bool)
  local r=np.dot(a,b)
  assert(r.dtype=="int16","dot 163 dtype "..r.dtype)
  assert(close(r.shape,{1,2,0}),"dot 163 shape")
  assert(close(r.strides,{0,0,0}),"dot 163 strides")
  assert(close(r:tolist(),{{{},{}}}),"dot 163 values")
end
do -- dot 164
  local a=np.reshape(np.array({-0.25},np.float16),{})
  local b=(np.array({{1,6},{4,2},{0,5}},np.uint16)).T
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 164 dtype "..r.dtype)
  assert(close(r.shape,{2,3}),"dot 164 shape")
  assert(close(r.strides,{12,4}),"dot 164 strides")
  assert(close(r:tolist(),{{-0.25,-1.0,0.0},{-1.5,-0.5,-1.25}}),"dot 164 values")
end
do -- dot 165
  local a=np.reshape(np.array({2},np.uint16),{})
  local b=np.array({{3},{1},{6}},np.uint8)
  local r=np.dot(a,b)
  assert(r.dtype=="uint16","dot 165 dtype "..r.dtype)
  assert(close(r.shape,{3,1}),"dot 165 shape")
  assert(close(r.strides,{2,2}),"dot 165 strides")
  assert(close(r:tolist(),{{6},{2},{12}}),"dot 165 values")
end
do -- dot 166
  local a=np.array({2,-6},np.int64)
  local b=np.reshape(np.array({5},np.uint32),{})
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 166 dtype "..r.dtype)
  assert(close(r.shape,{2}),"dot 166 shape")
  assert(close(r.strides,{8}),"dot 166 strides")
  assert(close(r:tolist(),{10,-30}),"dot 166 values")
end
do -- dot 167
  local a=np.array({4},np.int8)
  local b=np.array({{{5}},{{-3}}},np.int32)
  local r=np.dot(a,b)
  assert(r.dtype=="int32","dot 167 dtype "..r.dtype)
  assert(close(r.shape,{2,1}),"dot 167 shape")
  assert(close(r.strides,{4,4}),"dot 167 strides")
  assert(close(r:tolist(),{{20},{-12}}),"dot 167 values")
end
do -- dot 168
  local a=np.reshape(np.array({1},np.uint8),{})
  local b=np.zeros({4,0},np.int32)
  local r=np.dot(a,b)
  assert(r.dtype=="int32","dot 168 dtype "..r.dtype)
  assert(close(r.shape,{4,0}),"dot 168 shape")
  assert(close(r.strides,{0,0}),"dot 168 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"dot 168 values")
end
do -- dot 169
  local a=np.zeros({1,0,1,2},np.uint64)
  local b=np.zeros({2,0},np.float64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 169 dtype "..r.dtype)
  assert(close(r.shape,{1,0,1,0}),"dot 169 shape")
  assert(close(r.strides,{0,0,0,0}),"dot 169 strides")
  assert(close(r:tolist(),{{}}),"dot 169 values")
end
do -- dot 170
  local a=np.zeros({0},np.float16)
  local b=np.zeros({3,0,1},np.int64)
  local o=np.zeros({3,1},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 170 out identity")
  assert(close(r:tolist(),{{0.0},{0.0},{0.0}}),"dot 170 out values")
end
do -- dot 171
  local a=np.zeros({3,2,0,1},np.uint8)
  local b=np.zeros({0,1,4},np.int32)
  local r=np.dot(a,b)
  assert(r.dtype=="int32","dot 171 dtype "..r.dtype)
  assert(close(r.shape,{3,2,0,0,4}),"dot 171 shape")
  assert(close(r.strides,{0,0,0,0,0}),"dot 171 strides")
  assert(close(r:tolist(),{{{},{}},{{},{}},{{},{}}}),"dot 171 values")
end
do -- dot 172
  local a=(np.zeros({4,0},np.float32)).T
  local b=np.array({-0.25,0.625,-0.625,0.25},np.float32)
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 172 dtype "..r.dtype)
  assert(close(r.shape,{0}),"dot 172 shape")
  assert(close(r.strides,{0}),"dot 172 strides")
  assert(close(r:tolist(),{}),"dot 172 values")
end
do -- dot 173
  local a=np.zeros({1,3,0},np.float64)
  local b=np.zeros({0,0,0},np.float64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 173 dtype "..r.dtype)
  assert(close(r.shape,{1,3,0,0}),"dot 173 shape")
  assert(close(r.strides,{0,0,0,0}),"dot 173 strides")
  assert(close(r:tolist(),{{{},{},{}}}),"dot 173 values")
end
do -- dot 174
  local a=np.array({0.125,1.0,-0.25,0.625,-0.625},np.float32)
  local b=np.reshape(np.array({6},np.int64),{})
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 174 dtype "..r.dtype)
  assert(close(r.shape,{5}),"dot 174 shape")
  assert(close(r.strides,{8}),"dot 174 strides")
  assert(close(r:tolist(),{0.75,6.0,-1.5,3.75,-3.75}),"dot 174 values")
end
do -- dot 175
  local a=np.array({-6,-1,4,-4,1},np.int64)
  local b=np.reshape(np.array({-5},np.int8),{})
  local o=np.zeros({5},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 175 out identity")
  assert(r.dtype=="float64","dot 175 out dtype")
  assert(close(r.strides,{8}),"dot 175 out strides")
  assert(close(r:tolist(),{30.0,5.0,-20.0,20.0,-5.0}),"dot 175 out values")
end
do -- dot 176
  local a=np.reshape(np.array({true},np.bool),{})
  local b=np.array({0.75,-0.5,0.375},np.float16)
  local r=np.dot(a,b)
  assert(r.dtype=="float16","dot 176 dtype "..r.dtype)
  assert(close(r.shape,{3}),"dot 176 shape")
  assert(close(r.strides,{2}),"dot 176 strides")
  assert(close(r:tolist(),{0.75,-0.5,0.375}),"dot 176 values")
end
do -- dot 177
  local a=np.array({{-2,3,-5},{0,5,-3},{2,-6,-1}},np.int32)
  local b=np.array({{{6,4},{2,0},{5,3}},{{1,6},{4,2},{0,5}}},np.uint16)
  local r=np.dot(a,b)
  assert(r.dtype=="int32","dot 177 dtype "..r.dtype)
  assert(close(r.shape,{3,2,2}),"dot 177 shape")
  assert(close(r.strides,{16,8,4}),"dot 177 strides")
  assert(close(r:tolist(),{{{-31,-23},{10,-31}},{{-5,-9},{20,-5}},{{-5,5},{-22,-5}}}),"dot 177 values")
end
do -- dot 178
  local a=np.zeros({0,3},np.float16)
  local b=np.array({1,6,4},np.uint32)
  local o=np.zeros({0},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 178 out identity")
  assert(close(r:tolist(),{}),"dot 178 out values")
end
do -- dot 179
  local a=np.reshape(np.array({2},np.int8),{})
  local b=np.array({{3},{1},{6}},np.uint32)
  local o=np.zeros({3,1},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 179 out identity")
  assert(r.dtype=="float64","dot 179 out dtype")
  assert(close(r.strides,{8,8}),"dot 179 out strides")
  assert(close(r:tolist(),{{6.0},{2.0},{12.0}}),"dot 179 out values")
end
do -- dot 180
  local a=np.reshape(np.array({4},np.int32),{})
  local b=(np.zeros({2,0},np.int16)).T
  local r=np.dot(a,b)
  assert(r.dtype=="int32","dot 180 dtype "..r.dtype)
  assert(close(r.shape,{0,2}),"dot 180 shape")
  assert(close(r.strides,{0,0}),"dot 180 strides")
  assert(close(r:tolist(),{}),"dot 180 values")
end
do -- dot 181
  local a=(np.zeros({0,3},np.int16)).T
  local b=np.zeros({0},np.int64)
  local o=np.zeros({3},np.int64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 181 out identity")
  assert(close(r:tolist(),{0,0,0}),"dot 181 out values")
end
do -- dot 182
  local a=np.array({-5},np.int8)
  local b=np.reshape(np.array({2},np.uint32),{})
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 182 dtype "..r.dtype)
  assert(close(r.shape,{1}),"dot 182 shape")
  assert(close(r.strides,{8}),"dot 182 strides")
  assert(close(r:tolist(),{-10}),"dot 182 values")
end
do -- dot 183
  local a=np.reshape(np.array({3},np.uint64),{})
  local b=(np.array({{-2}},np.int8)).T
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 183 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"dot 183 shape")
  assert(close(r.strides,{8,8}),"dot 183 strides")
  assert(close(r:tolist(),{{-6.0}}),"dot 183 values")
end
do -- dot 184
  local a=np.zeros({0},np.float16)
  local b=np.zeros({0},np.int8)
  local r=np.dot(a,b)
  assert(close(r,0.0),"dot 184 scalar")
end
do -- dot 185
  local a=np.reshape(np.array({0},np.uint32),{})
  local b=np.zeros({2,0},np.uint64)
  local ob=np.zeros({0,2},np.uint64)
  local o=ob.T
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 185 out identity")
  assert(r.dtype=="uint64","dot 185 out dtype")
  assert(close(r.strides,{0,0}),"dot 185 out strides")
  assert(close(r:tolist(),{{},{}}),"dot 185 out values")
end
do -- dot 186
  local a=np.array({3,-5},np.int32)
  local b=np.reshape(np.array({-1.0},np.float64),{})
  local o=np.zeros({2},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 186 out identity")
  assert(r.dtype=="float64","dot 186 out dtype")
  assert(close(r.strides,{8}),"dot 186 out strides")
  assert(close(r:tolist(),{-3.0,5.0}),"dot 186 out values")
end
do -- dot 187
  local a=np.array({{{-0.875,0.0},{0.875,-0.375},{0.5,-0.75}},{{0.125,1.0},{-0.25,0.625},{-0.625,0.25}}},np.float32)
  local b=np.zeros({3,1,2,0},np.int8)
  local o=np.zeros({2,3,3,1,0},np.float32)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 187 out identity")
  assert(close(r:tolist(),{{{{{}},{{}},{{}}},{{{}},{{}},{{}}},{{{}},{{}},{{}}}},{{{{}},{{}},{{}}},{{{}},{{}},{{}}},{{{}},{{}},{{}}}}}),"dot 187 out values")
end
do -- dot 188
  local a=np.array({{{6,4},{2,0}},{{5,3},{1,6}}},np.uint64)
  local b=np.array({{{-0.5,0.375},{-0.875,0.0}},{{0.875,-0.375},{0.5,-0.75}}},np.float16)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 188 dtype "..r.dtype)
  assert(close(r.shape,{2,2,2,2}),"dot 188 shape")
  assert(close(r.strides,{64,32,16,8}),"dot 188 strides")
  assert(close(r:tolist(),{{{{-6.5,2.25},{7.25,-5.25}},{{-1.0,0.75},{1.75,-0.75}}},{{{-5.125,1.875},{5.875,-4.125}},{{-5.75,0.375},{3.875,-4.875}}}}),"dot 188 values")
end
do -- dot 189
  local a=np.zeros({0,0,2,1},np.uint16)
  local b=np.zeros({0,3,1,3},np.bool)
  local o=np.zeros({0,0,2,0,3,3},np.uint16)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 189 out identity")
  assert(close(r:tolist(),{}),"dot 189 out values")
end
do -- dot 190
  local a=np.reshape(np.array({-0.125},np.float32),{})
  local b=np.zeros({0,4},np.int8)
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 190 dtype "..r.dtype)
  assert(close(r.shape,{0,4}),"dot 190 shape")
  assert(close(r.strides,{0,0}),"dot 190 strides")
  assert(close(r:tolist(),{}),"dot 190 values")
end
do -- dot 191
  local a=np.reshape(np.array({0},np.int8),{})
  local b=np.array({6},np.uint32)
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 191 dtype "..r.dtype)
  assert(close(r.shape,{1}),"dot 191 shape")
  assert(close(r.strides,{8}),"dot 191 strides")
  assert(close(r:tolist(),{0}),"dot 191 values")
end
do -- dot 192
  local a=(np.zeros({3,0},np.float16)).T
  local b=np.array({{0.5,-0.75,0.125},{1.0,-0.25,0.625},{-0.625,0.25,-1.0}},np.float16)
  local o=np.zeros({0,3},np.float16)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 192 out identity")
  assert(close(r:tolist(),{}),"dot 192 out values")
end
do -- dot 193
  local a=np.array({2,0,5},np.uint8)
  local b=np.zeros({1,3,0},np.uint64)
  local r=np.dot(a,b)
  assert(r.dtype=="uint64","dot 193 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"dot 193 shape")
  assert(close(r.strides,{0,0}),"dot 193 strides")
  assert(close(r:tolist(),{{}}),"dot 193 values")
end
do -- dot 194
  local a=np.array({0.875},np.float32)
  local b=np.array({-6},np.int16)
  local r=np.dot(a,b)
  assert(close(r,-5.25),"dot 194 scalar")
end
do -- dot 195
  local a=np.array({6,4,2},np.uint16)
  local b=np.reshape(np.array({0},np.uint32),{})
  local r=np.dot(a,b)
  assert(r.dtype=="uint32","dot 195 dtype "..r.dtype)
  assert(close(r.shape,{3}),"dot 195 shape")
  assert(close(r.strides,{4}),"dot 195 strides")
  assert(close(r:tolist(),{0,0,0}),"dot 195 values")
end
do -- dot 196
  local a=np.zeros({2,0,2,3},np.int16)
  local b=np.zeros({3,0,3,3},np.int16)
  local o=np.zeros({2,0,2,3,0,3},np.int16)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 196 out identity")
  assert(close(r:tolist(),{{},{}}),"dot 196 out values")
end
do -- dot 197
  local a=np.array({-1,4},np.int32)
  local b=np.reshape(np.array({0},np.int16),{})
  local r=np.dot(a,b)
  assert(r.dtype=="int32","dot 197 dtype "..r.dtype)
  assert(close(r.shape,{2}),"dot 197 shape")
  assert(close(r.strides,{4}),"dot 197 strides")
  assert(close(r:tolist(),{0,0}),"dot 197 values")
end
do -- dot 198
  local a=np.array({-0.25,0.625,-0.625,0.25},np.float16)
  local b=np.reshape(np.array({6},np.uint16),{})
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 198 dtype "..r.dtype)
  assert(close(r.shape,{4}),"dot 198 shape")
  assert(close(r.strides,{4}),"dot 198 strides")
  assert(close(r:tolist(),{-1.5,3.75,-3.75,1.5}),"dot 198 values")
end
do -- dot 199
  local a=np.reshape(np.array({3},np.int32),{})
  local b=np.array({1,6,4,2},np.uint32)
  local o=np.zeros({4},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 199 out identity")
  assert(r.dtype=="float64","dot 199 out dtype")
  assert(close(r.strides,{8}),"dot 199 out strides")
  assert(close(r:tolist(),{3.0,18.0,12.0,6.0}),"dot 199 out values")
end
do -- dot 200
  local a=np.array({{{5,-3,2,-6}},{{-1,4,-4,1}},{{6,-2,3,-5}}},np.int8)
  local b=np.array({6,-2,3,-5},np.int64)
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 200 dtype "..r.dtype)
  assert(close(r.shape,{3,1}),"dot 200 shape")
  assert(close(r.strides,{8,8}),"dot 200 strides")
  assert(close(r:tolist(),{{72},{-31},{74}}),"dot 200 values")
end
do -- dot 201
  local a=np.array({4,2},np.uint16)
  local b=(np.array({{-5,0},{5,-3}},np.int32)).T
  local r=np.dot(a,b)
  assert(r.dtype=="int32","dot 201 dtype "..r.dtype)
  assert(close(r.shape,{2}),"dot 201 shape")
  assert(close(r.strides,{4}),"dot 201 strides")
  assert(close(r:tolist(),{-20,14}),"dot 201 values")
end
do -- dot 202
  local a=np.zeros({1,0},np.bool)
  local b=np.zeros({2,2,0,3},np.float32)
  local o=np.zeros({1,2,2,3},np.float32)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 202 out identity")
  assert(close(r:tolist(),{{{{0.0,0.0,0.0},{0.0,0.0,0.0}},{{0.0,0.0,0.0},{0.0,0.0,0.0}}}}),"dot 202 out values")
end
do -- dot 203
  local a=np.array({{1.0,-0.25,0.625}},np.float64)
  local b=np.array({-1.0,-0.125,0.75},np.float16)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 203 dtype "..r.dtype)
  assert(close(r.shape,{1}),"dot 203 shape")
  assert(close(r.strides,{8}),"dot 203 strides")
  assert(close(r:tolist(),{-0.5}),"dot 203 values")
end
do -- dot 204
  local a=np.array({-0.875,0.0,0.875},np.float64)
  local b=np.reshape(np.array({4},np.uint64),{})
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 204 dtype "..r.dtype)
  assert(close(r.shape,{3}),"dot 204 shape")
  assert(close(r.strides,{8}),"dot 204 strides")
  assert(close(r:tolist(),{-3.5,0.0,3.5}),"dot 204 values")
end
do -- dot 205
  local a=np.zeros({0},np.float64)
  local b=np.reshape(np.array({true},np.bool),{})
  local o=np.zeros({0},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 205 out identity")
  assert(r.dtype=="float64","dot 205 out dtype")
  assert(close(r.strides,{0}),"dot 205 out strides")
  assert(close(r:tolist(),{}),"dot 205 out values")
end
do -- dot 206
  local a=np.array({4,-4},np.int16)
  local b=np.array({{{-0.25,0.625,-0.625},{0.25,-1.0,-0.125}},{{0.75,-0.5,0.375},{-0.875,0.0,0.875}},{{-0.375,0.5,-0.75},{0.125,1.0,-0.25}}},np.float16)
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 206 dtype "..r.dtype)
  assert(close(r.shape,{3,3}),"dot 206 shape")
  assert(close(r.strides,{12,4}),"dot 206 strides")
  assert(close(r:tolist(),{{-2.0,6.5,-2.0},{6.5,-2.0,-2.0},{-2.0,-2.0,-2.0}}),"dot 206 values")
end
do -- dot 207
  local a=np.array({-0.125},np.float32)
  local b=np.reshape(np.array({0.0},np.float32),{})
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 207 dtype "..r.dtype)
  assert(close(r.shape,{1}),"dot 207 shape")
  assert(close(r.strides,{4}),"dot 207 strides")
  assert(close(r:tolist(),{-0.0}),"dot 207 values")
end
do -- dot 208
  local a=np.array({-5,0,5,-3},np.int16)
  local b=np.reshape(np.array({-4},np.int8),{})
  local r=np.dot(a,b)
  assert(r.dtype=="int16","dot 208 dtype "..r.dtype)
  assert(close(r.shape,{4}),"dot 208 shape")
  assert(close(r.strides,{2}),"dot 208 strides")
  assert(close(r:tolist(),{20,0,-20,12}),"dot 208 values")
end
do -- dot 209
  local a=np.array({true,false},np.bool)
  local b=np.reshape(np.array({-2},np.int8),{})
  local o=np.zeros({2},np.int8)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 209 out identity")
  assert(r.dtype=="int8","dot 209 out dtype")
  assert(close(r.strides,{1}),"dot 209 out strides")
  assert(close(r:tolist(),{-2,0}),"dot 209 out values")
end
do -- dot 210
  local a=np.zeros({2,2,1,0},np.bool)
  local b=np.zeros({0},np.int16)
  local r=np.dot(a,b)
  assert(r.dtype=="int16","dot 210 dtype "..r.dtype)
  assert(close(r.shape,{2,2,1}),"dot 210 shape")
  assert(close(r.strides,{4,2,2}),"dot 210 strides")
  assert(close(r:tolist(),{{{0},{0}},{{0},{0}}}),"dot 210 values")
end
do -- dot 211
  local a=np.reshape(np.array({3},np.uint8),{})
  local b=np.zeros({0,0},np.int16)
  local r=np.dot(a,b)
  assert(r.dtype=="int16","dot 211 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"dot 211 shape")
  assert(close(r.strides,{0,0}),"dot 211 strides")
  assert(close(r:tolist(),{}),"dot 211 values")
end
do -- dot 212
  local a=np.reshape(np.array({5},np.uint8),{})
  local b=np.array({{6},{4},{2}},np.uint32)
  local o=np.zeros({3,1},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 212 out identity")
  assert(r.dtype=="float64","dot 212 out dtype")
  assert(close(r.strides,{8,8}),"dot 212 out strides")
  assert(close(r:tolist(),{{30.0},{20.0},{10.0}}),"dot 212 out values")
end
do -- dot 213
  local a=np.array({{5,-3,2,-6},{-1,4,-4,1},{6,-2,3,-5}},np.int16)
  local b=np.array({{{{true,false},{true,true},{false,true},{true,false}},{{true,true},{false,true},{true,false},{true,true}},{{false,true},{true,false},{true,true},{false,true}}},{{{true,false},{true,true},{false,true},{true,false}},{{true,true},{false,true},{true,false},{true,true}},{{false,true},{true,false},{true,true},{false,true}}}},np.bool)
  local r=np.dot(a,b)
  assert(r.dtype=="int16","dot 213 dtype "..r.dtype)
  assert(close(r.shape,{3,2,3,2}),"dot 213 shape")
  assert(close(r.strides,{24,12,4,2}),"dot 213 strides")
  assert(close(r:tolist(),{{{{-4,-1},{1,-4},{-1,1}},{{-4,-1},{1,-4},{-1,1}}},{{{4,0},{-4,4},{0,-4}},{{4,0},{-4,4},{0,-4}}},{{{-1,1},{4,-1},{1,4}},{{-1,1},{4,-1},{1,4}}}}),"dot 213 values")
end
do -- dot 214
  local a=np.reshape(np.array({-0.5},np.float64),{})
  local b=np.array({{3,1},{6,4}},np.uint8)
  local o=np.zeros({2,2},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 214 out identity")
  assert(r.dtype=="float64","dot 214 out dtype")
  assert(close(r.strides,{16,8}),"dot 214 out strides")
  assert(close(r:tolist(),{{-1.5,-0.5},{-3.0,-2.0}}),"dot 214 out values")
end
do -- dot 215
  local a=np.array({{{true,false},{true,true}},{{false,true},{true,false}},{{true,true},{false,true}}},np.bool)
  local b=np.array({{5},{3}},np.uint8)
  local r=np.dot(a,b)
  assert(r.dtype=="uint8","dot 215 dtype "..r.dtype)
  assert(close(r.shape,{3,2,1}),"dot 215 shape")
  assert(close(r.strides,{2,1,1}),"dot 215 strides")
  assert(close(r:tolist(),{{{5},{8}},{{3},{5}},{{8},{3}}}),"dot 215 values")
end
do -- dot 216
  local a=np.array({{{0.0,0.875},{-0.375,0.5}}},np.float16)
  local b=np.zeros({1,2,0},np.float32)
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 216 dtype "..r.dtype)
  assert(close(r.shape,{1,2,1,0}),"dot 216 shape")
  assert(close(r.strides,{0,0,0,0}),"dot 216 strides")
  assert(close(r:tolist(),{{{{}},{{}}}}),"dot 216 values")
end
do -- dot 217
  local a=np.reshape(np.array({0},np.int8),{})
  local b=np.array({2,0,5},np.uint8)
  local r=np.dot(a,b)
  assert(r.dtype=="int16","dot 217 dtype "..r.dtype)
  assert(close(r.shape,{3}),"dot 217 shape")
  assert(close(r.strides,{2}),"dot 217 strides")
  assert(close(r:tolist(),{0,0,0}),"dot 217 values")
end
do -- dot 218
  local a=np.array({true},np.bool)
  local b=np.reshape(np.array({3},np.int8),{})
  local r=np.dot(a,b)
  assert(r.dtype=="int8","dot 218 dtype "..r.dtype)
  assert(close(r.shape,{1}),"dot 218 shape")
  assert(close(r.strides,{1}),"dot 218 strides")
  assert(close(r:tolist(),{3}),"dot 218 values")
end
do -- dot 219
  local a=np.reshape(np.array({0.75},np.float16),{})
  local b=np.zeros({0},np.float32)
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 219 dtype "..r.dtype)
  assert(close(r.shape,{0}),"dot 219 shape")
  assert(close(r.strides,{0}),"dot 219 strides")
  assert(close(r:tolist(),{}),"dot 219 values")
end
do -- dot 220
  local a=np.zeros({0,2,4},np.float32)
  local b=np.array({{{-1.0},{-0.125},{0.75},{-0.5}}},np.float32)
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 220 dtype "..r.dtype)
  assert(close(r.shape,{0,2,1,1}),"dot 220 shape")
  assert(close(r.strides,{0,0,0,0}),"dot 220 strides")
  assert(close(r:tolist(),{}),"dot 220 values")
end
do -- dot 221
  local a=np.zeros({0,3,0},np.float16)
  local b=np.zeros({0},np.uint16)
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 221 dtype "..r.dtype)
  assert(close(r.shape,{0,3}),"dot 221 shape")
  assert(close(r.strides,{0,0}),"dot 221 strides")
  assert(close(r:tolist(),{}),"dot 221 values")
end
do -- dot 222
  local a=np.zeros({2,2,0},np.uint8)
  local b=np.zeros({0,0},np.uint8)
  local r=np.dot(a,b)
  assert(r.dtype=="uint8","dot 222 dtype "..r.dtype)
  assert(close(r.shape,{2,2,0}),"dot 222 shape")
  assert(close(r.strides,{0,0,0}),"dot 222 strides")
  assert(close(r:tolist(),{{{},{}},{{},{}}}),"dot 222 values")
end
do -- dot 223
  local a=np.array({{{6,4,2},{0,5,3},{1,6,4}}},np.uint32)
  local b=np.zeros({2,0,3,0},np.int64)
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 223 dtype "..r.dtype)
  assert(close(r.shape,{1,3,2,0,0}),"dot 223 shape")
  assert(close(r.strides,{0,0,0,0,0}),"dot 223 strides")
  assert(close(r:tolist(),{{{{},{}},{{},{}},{{},{}}}}),"dot 223 values")
end
do -- dot 224
  local a=np.array({true,false,true,true,false},np.bool)
  local b=np.reshape(np.array({2},np.uint64),{})
  local r=np.dot(a,b)
  assert(r.dtype=="uint64","dot 224 dtype "..r.dtype)
  assert(close(r.shape,{5}),"dot 224 shape")
  assert(close(r.strides,{8}),"dot 224 strides")
  assert(close(r:tolist(),{2,0,2,2,0}),"dot 224 values")
end
do -- dot 225
  local a=np.zeros({2,3,0},np.float16)
  local b=np.zeros({1,1,0,2},np.float64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 225 dtype "..r.dtype)
  assert(close(r.shape,{2,3,1,1,2}),"dot 225 shape")
  assert(close(r.strides,{48,16,16,16,8}),"dot 225 strides")
  assert(close(r:tolist(),{{{{{0.0,0.0}}},{{{0.0,0.0}}},{{{0.0,0.0}}}},{{{{0.0,0.0}}},{{{0.0,0.0}}},{{{0.0,0.0}}}}}),"dot 225 values")
end
do -- dot 226
  local a=np.array({5,-3,2,-6},np.int64)
  local b=np.reshape(np.array({6},np.uint8),{})
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 226 dtype "..r.dtype)
  assert(close(r.shape,{4}),"dot 226 shape")
  assert(close(r.strides,{8}),"dot 226 strides")
  assert(close(r:tolist(),{30,-18,12,-36}),"dot 226 values")
end
do -- dot 227
  local a=np.reshape(np.array({-6},np.int64),{})
  local b=np.array({0.75,-0.5,0.375},np.float32)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 227 dtype "..r.dtype)
  assert(close(r.shape,{3}),"dot 227 shape")
  assert(close(r.strides,{8}),"dot 227 strides")
  assert(close(r:tolist(),{-4.5,3.0,-2.25}),"dot 227 values")
end
do -- dot 228
  local a=np.zeros({0,4},np.float16)
  local b=np.array({{{{3,1,6,4},{2,0,5,3},{1,6,4,2},{0,5,3,1}}},{{{6,4,2,0},{5,3,1,6},{4,2,0,5},{3,1,6,4}}},{{{2,0,5,3},{1,6,4,2},{0,5,3,1},{6,4,2,0}}}},np.uint8)
  local r=np.dot(a,b)
  assert(r.dtype=="float16","dot 228 dtype "..r.dtype)
  assert(close(r.shape,{0,3,1,4}),"dot 228 shape")
  assert(close(r.strides,{0,0,0,0}),"dot 228 strides")
  assert(close(r:tolist(),{}),"dot 228 values")
end
do -- dot 229
  local a=np.array({{{-1.0,-0.125,0.75},{-0.5,0.375,-0.875}},{{0.0,0.875,-0.375},{0.5,-0.75,0.125}}},np.float32)
  local b=np.array({{-1,4},{-4,1},{6,-2}},np.int8)
  local o=np.zeros({2,2,2},np.float32)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 229 out identity")
  assert(close(r:tolist(),{{{6.0,-5.625},{-6.25,0.125}},{{-5.75,1.625},{3.25,1.0}}}),"dot 229 out values")
end
do -- dot 230
  local a=np.array({0,5},np.int64)
  local b=np.reshape(np.array({1},np.int16),{})
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 230 dtype "..r.dtype)
  assert(close(r.shape,{2}),"dot 230 shape")
  assert(close(r.strides,{8}),"dot 230 strides")
  assert(close(r:tolist(),{0,5}),"dot 230 values")
end
do -- dot 231
  local a=np.array({2,-6},np.int8)
  local b=np.reshape(np.array({2},np.uint16),{})
  local r=np.dot(a,b)
  assert(r.dtype=="int32","dot 231 dtype "..r.dtype)
  assert(close(r.shape,{2}),"dot 231 shape")
  assert(close(r.strides,{4}),"dot 231 strides")
  assert(close(r:tolist(),{4,-12}),"dot 231 values")
end
do -- dot 232
  local a=(np.zeros({0,3},np.int16)).T
  local b=np.zeros({0},np.bool)
  local r=np.dot(a,b)
  assert(r.dtype=="int16","dot 232 dtype "..r.dtype)
  assert(close(r.shape,{3}),"dot 232 shape")
  assert(close(r.strides,{2}),"dot 232 strides")
  assert(close(r:tolist(),{0,0,0}),"dot 232 values")
end
do -- dot 233
  local a=np.array({{6,-2},{3,-5}},np.int8)
  local b=np.array({{0.125},{1.0}},np.float64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 233 dtype "..r.dtype)
  assert(close(r.shape,{2,1}),"dot 233 shape")
  assert(close(r.strides,{8,8}),"dot 233 strides")
  assert(close(r:tolist(),{{-1.25},{-4.625}}),"dot 233 values")
end
do -- dot 234
  local a=np.zeros({0},np.float64)
  local b=np.zeros({3,3,0,3},np.float16)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 234 dtype "..r.dtype)
  assert(close(r.shape,{3,3,3}),"dot 234 shape")
  assert(close(r.strides,{72,24,8}),"dot 234 strides")
  assert(close(r:tolist(),{{{0.0,0.0,0.0},{0.0,0.0,0.0},{0.0,0.0,0.0}},{{0.0,0.0,0.0},{0.0,0.0,0.0},{0.0,0.0,0.0}},{{0.0,0.0,0.0},{0.0,0.0,0.0},{0.0,0.0,0.0}}}),"dot 234 values")
end
do -- dot 235
  local a=np.array({{{-3},{2}},{{-6},{-1}}},np.int64)
  local b=np.array({{-2,3}},np.int64)
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 235 dtype "..r.dtype)
  assert(close(r.shape,{2,2,2}),"dot 235 shape")
  assert(close(r.strides,{32,16,8}),"dot 235 strides")
  assert(close(r:tolist(),{{{6,-9},{-4,6}},{{12,-18},{2,-3}}}),"dot 235 values")
end
do -- dot 236
  local a=np.zeros({2,1,0},np.int32)
  local b=(np.zeros({3,0},np.int16)).T
  local r=np.dot(a,b)
  assert(r.dtype=="int32","dot 236 dtype "..r.dtype)
  assert(close(r.shape,{2,1,3}),"dot 236 shape")
  assert(close(r.strides,{12,12,4}),"dot 236 strides")
  assert(close(r:tolist(),{{{0,0,0}},{{0,0,0}}}),"dot 236 values")
end
do -- dot 237
  local a=np.zeros({0,3,0,1},np.uint32)
  local b=(np.array({{-1.0}},np.float32)).T
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 237 dtype "..r.dtype)
  assert(close(r.shape,{0,3,0,1}),"dot 237 shape")
  assert(close(r.strides,{0,0,0,0}),"dot 237 strides")
  assert(close(r:tolist(),{}),"dot 237 values")
end
do -- dot 238
  local a=np.zeros({0},np.float16)
  local b=np.reshape(np.array({2},np.uint64),{})
  local o=np.zeros({0},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 238 out identity")
  assert(r.dtype=="float64","dot 238 out dtype")
  assert(close(r.strides,{0}),"dot 238 out strides")
  assert(close(r:tolist(),{}),"dot 238 out values")
end
do -- dot 239
  local a=np.array({true},np.bool)
  local b=np.array({{{-0.5,0.375}},{{-0.875,0.0}},{{0.875,-0.375}}},np.float32)
  local r=np.dot(a,b)
  assert(r.dtype=="float32","dot 239 dtype "..r.dtype)
  assert(close(r.shape,{3,2}),"dot 239 shape")
  assert(close(r.strides,{8,4}),"dot 239 strides")
  assert(close(r:tolist(),{{-0.5,0.375},{-0.875,0.0},{0.875,-0.375}}),"dot 239 values")
end
do -- dot 240
  local a=np.zeros({0,1,2,0},np.int64)
  local b=np.zeros({0},np.bool)
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 240 dtype "..r.dtype)
  assert(close(r.shape,{0,1,2}),"dot 240 shape")
  assert(close(r.strides,{0,0,0}),"dot 240 strides")
  assert(close(r:tolist(),{}),"dot 240 values")
end
do -- dot 241
  local a=np.reshape(np.array({-0.125},np.float16),{})
  local b=np.zeros({4,0},np.int32)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 241 dtype "..r.dtype)
  assert(close(r.shape,{4,0}),"dot 241 shape")
  assert(close(r.strides,{0,0}),"dot 241 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"dot 241 values")
end
do -- dot 242
  local a=np.array({2},np.uint64)
  local b=np.reshape(np.array({3},np.uint16),{})
  local o=np.zeros({1},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 242 out identity")
  assert(r.dtype=="float64","dot 242 out dtype")
  assert(close(r.strides,{8}),"dot 242 out strides")
  assert(close(r:tolist(),{6.0}),"dot 242 out values")
end
do -- dot 243
  local a=np.array({{{{4,2},{0,5},{3,1}}},{{{6,4},{2,0},{5,3}}},{{{1,6},{4,2},{0,5}}}},np.uint16)
  local b=np.array({{{5,3,1,6},{4,2,0,5}},{{3,1,6,4},{2,0,5,3}},{{1,6,4,2},{0,5,3,1}}},np.uint8)
  local r=np.dot(a,b)
  assert(r.dtype=="uint16","dot 243 dtype "..r.dtype)
  assert(close(r.shape,{3,1,3,3,4}),"dot 243 shape")
  assert(close(r.strides,{72,72,24,8,2}),"dot 243 strides")
  assert(close(r:tolist(),{{{{{28,16,4,34},{16,4,34,22},{4,34,22,10}},{{20,10,0,25},{10,0,25,15},{0,25,15,5}},{{19,11,3,23},{11,3,23,15},{3,23,15,7}}}},{{{{46,26,6,56},{26,6,56,36},{6,56,36,16}},{{10,6,2,12},{6,2,12,8},{2,12,8,4}},{{37,21,5,45},{21,5,45,29},{5,45,29,13}}}},{{{{29,15,1,36},{15,1,36,22},{1,36,22,8}},{{28,16,4,34},{16,4,34,22},{4,34,22,10}},{{20,10,0,25},{10,0,25,15},{0,25,15,5}}}}}),"dot 243 values")
end
do -- dot 244
  local a=np.zeros({0},np.int64)
  local b=np.zeros({2,0,4},np.float32)
  local o=np.zeros({2,4},np.float64)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 244 out identity")
  assert(close(r:tolist(),{{0.0,0.0,0.0,0.0},{0.0,0.0,0.0,0.0}}),"dot 244 out values")
end
do -- dot 245
  local a=np.reshape(np.array({1},np.uint64),{})
  local b=np.array({5,-3,2,-6},np.int16)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 245 dtype "..r.dtype)
  assert(close(r.shape,{4}),"dot 245 shape")
  assert(close(r.strides,{8}),"dot 245 strides")
  assert(close(r:tolist(),{5.0,-3.0,2.0,-6.0}),"dot 245 values")
end
do -- dot 246
  local a=np.zeros({0,0,0,4},np.uint32)
  local b=(np.array({{4,2,0,5},{3,1,6,4},{2,0,5,3}},np.uint16)).T
  local o=np.zeros({0,0,0,3},np.uint32)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 246 out identity")
  assert(close(r:tolist(),{}),"dot 246 out values")
end
do -- dot 247
  local a=np.zeros({0,2,3},np.int64)
  local b=np.array({{-0.625,0.25},{-1.0,-0.125},{0.75,-0.5}},np.float16)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 247 dtype "..r.dtype)
  assert(close(r.shape,{0,2,2}),"dot 247 shape")
  assert(close(r.strides,{0,0,0}),"dot 247 strides")
  assert(close(r:tolist(),{}),"dot 247 values")
end
do -- dot 248
  local a=np.zeros({3,2,0},np.uint64)
  local b=np.zeros({0},np.uint32)
  local r=np.dot(a,b)
  assert(r.dtype=="uint64","dot 248 dtype "..r.dtype)
  assert(close(r.shape,{3,2}),"dot 248 shape")
  assert(close(r.strides,{16,8}),"dot 248 strides")
  assert(close(r:tolist(),{{0,0},{0,0},{0,0}}),"dot 248 values")
end
do -- dot 249
  local a=np.reshape(np.array({-1},np.int32),{})
  local b=np.array({3,1,6,4,2},np.uint64)
  local r=np.dot(a,b)
  assert(r.dtype=="float64","dot 249 dtype "..r.dtype)
  assert(close(r.shape,{5}),"dot 249 shape")
  assert(close(r.strides,{8}),"dot 249 strides")
  assert(close(r:tolist(),{-3.0,-1.0,-6.0,-4.0,-2.0}),"dot 249 values")
end
do -- dot 250
  local a=np.reshape(np.array({1},np.int32),{})
  local b=np.array({5,3},np.uint16)
  local r=np.dot(a,b)
  assert(r.dtype=="int32","dot 250 dtype "..r.dtype)
  assert(close(r.shape,{2}),"dot 250 shape")
  assert(close(r.strides,{4}),"dot 250 strides")
  assert(close(r:tolist(),{5,3}),"dot 250 values")
end
do -- dot 251
  local a=np.zeros({0},np.uint16)
  local b=np.reshape(np.array({0},np.uint32),{})
  local r=np.dot(a,b)
  assert(r.dtype=="uint32","dot 251 dtype "..r.dtype)
  assert(close(r.shape,{0}),"dot 251 shape")
  assert(close(r.strides,{0}),"dot 251 strides")
  assert(close(r:tolist(),{}),"dot 251 values")
end
do -- dot 252
  local a=np.array({1,6,4,2},np.uint8)
  local b=np.reshape(np.array({2},np.uint32),{})
  local r=np.dot(a,b)
  assert(r.dtype=="uint32","dot 252 dtype "..r.dtype)
  assert(close(r.shape,{4}),"dot 252 shape")
  assert(close(r.strides,{4}),"dot 252 strides")
  assert(close(r:tolist(),{2,12,8,4}),"dot 252 values")
end
do -- dot 253
  local a=np.zeros({1,0,1},np.uint32)
  local b=np.array({{{{true}},{{true}},{{false}}},{{{true}},{{true}},{{false}}},{{{true}},{{true}},{{false}}}},np.bool)
  local r=np.dot(a,b)
  assert(r.dtype=="uint32","dot 253 dtype "..r.dtype)
  assert(close(r.shape,{1,0,3,3,1}),"dot 253 shape")
  assert(close(r.strides,{0,0,0,0,0}),"dot 253 strides")
  assert(close(r:tolist(),{{}}),"dot 253 values")
end
do -- dot 254
  local a=np.array({5,3,1,6,4},np.uint32)
  local b=np.reshape(np.array({-3},np.int8),{})
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 254 dtype "..r.dtype)
  assert(close(r.shape,{5}),"dot 254 shape")
  assert(close(r.strides,{8}),"dot 254 strides")
  assert(close(r:tolist(),{-15,-9,-3,-18,-12}),"dot 254 values")
end
do -- dot 255
  local a=np.zeros({1,0,3},np.uint16)
  local b=(np.array({{-1,4,-4}},np.int8)).T
  local o=np.zeros({1,0,1},np.int32)
  local r=np.dot(a,b,{out=o})
  assert(r==o,"dot 255 out identity")
  assert(close(r:tolist(),{{}}),"dot 255 out values")
end
do -- dot 256
  local a=np.zeros({0},np.int64)
  local b=np.reshape(np.array({3},np.uint8),{})
  local r=np.dot(a,b)
  assert(r.dtype=="int64","dot 256 dtype "..r.dtype)
  assert(close(r.shape,{0}),"dot 256 shape")
  assert(close(r.strides,{0}),"dot 256 strides")
  assert(close(r:tolist(),{}),"dot 256 values")
end
do -- dot 257
  local a=np.array({4,2,0,5},np.uint16)
  local b=np.array({3,-5,0,5},np.int16)
  local r=np.dot(a,b)
  assert(close(r,27),"dot 257 scalar")
end
do -- dot 258
  local a=np.reshape(np.array({4},np.int8),{})
  local b=np.zeros({0,4},np.int32)
  local r=np.dot(a,b)
  assert(r.dtype=="int32","dot 258 dtype "..r.dtype)
  assert(close(r.shape,{0,4}),"dot 258 shape")
  assert(close(r.strides,{0,0}),"dot 258 strides")
  assert(close(r:tolist(),{}),"dot 258 values")
end
do -- dot 259
  local a=np.zeros({2,0,0,1},np.uint8)
  local b=np.array({{-6}},np.int8)
  local r=np.dot(a,b)
  assert(r.dtype=="int16","dot 259 dtype "..r.dtype)
  assert(close(r.shape,{2,0,0,1}),"dot 259 shape")
  assert(close(r.strides,{0,0,0,0}),"dot 259 strides")
  assert(close(r:tolist(),{{},{}}),"dot 259 values")
end
do -- inner 0
  local a=np.array({2,-6,-1},np.int16)
  local b=np.array({3,-5,0},np.int8)
  local r=np.inner(a,b)
  assert(close(r,36),"inner 0 scalar")
end
do -- inner 1
  local a=np.zeros({2,0,3,2},np.bool)
  local b=np.array({{{5,-3},{2,-6}}},np.int16)
  local r=np.inner(a,b)
  assert(r.dtype=="int16","inner 1 dtype "..r.dtype)
  assert(close(r.shape,{2,0,3,1,2}),"inner 1 shape")
  assert(close(r.strides,{0,0,0,0,0}),"inner 1 strides")
  assert(close(r:tolist(),{{},{}}),"inner 1 values")
end
do -- inner 2
  local a=np.zeros({3,0,0},np.int32)
  local b=np.zeros({0},np.float32)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 2 dtype "..r.dtype)
  assert(close(r.shape,{3,0}),"inner 2 shape")
  assert(close(r.strides,{0,0}),"inner 2 strides")
  assert(close(r:tolist(),{{},{},{}}),"inner 2 values")
end
do -- inner 3
  local a=np.zeros({0,3,3},np.uint8)
  local b=np.zeros({1,0,1,3},np.int64)
  local r=np.inner(a,b)
  assert(r.dtype=="int64","inner 3 dtype "..r.dtype)
  assert(close(r.shape,{0,3,1,0,1}),"inner 3 shape")
  assert(close(r.strides,{0,0,0,0,0}),"inner 3 strides")
  assert(close(r:tolist(),{}),"inner 3 values")
end
do -- inner 4
  local a=(np.array({{0.25,-1.0},{-0.125,0.75},{-0.5,0.375}},np.float64)).T
  local b=np.zeros({0,3,3},np.float16)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 4 dtype "..r.dtype)
  assert(close(r.shape,{2,0,3}),"inner 4 shape")
  assert(close(r.strides,{0,0,0}),"inner 4 strides")
  assert(close(r:tolist(),{{},{}}),"inner 4 values")
end
do -- inner 5
  local a=np.reshape(np.array({5},np.uint32),{})
  local b=np.zeros({1,0},np.int8)
  local r=np.inner(a,b)
  assert(r.dtype=="int64","inner 5 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"inner 5 shape")
  assert(close(r.strides,{0,0}),"inner 5 strides")
  assert(close(r:tolist(),{{}}),"inner 5 values")
end
do -- inner 6
  local a=np.array({{1}},np.int8)
  local b=np.zeros({2,0,1},np.float32)
  local r=np.inner(a,b)
  assert(r.dtype=="float32","inner 6 dtype "..r.dtype)
  assert(close(r.shape,{1,2,0}),"inner 6 shape")
  assert(close(r.strides,{0,0,0}),"inner 6 strides")
  assert(close(r:tolist(),{{{},{}}}),"inner 6 values")
end
do -- inner 7
  local a=np.zeros({0},np.float16)
  local b=np.zeros({0},np.int16)
  local r=np.inner(a,b)
  assert(close(r,0.0),"inner 7 scalar")
end
do -- inner 8
  local a=np.array({{{{-0.875,0.0,0.875},{-0.375,0.5,-0.75}},{{0.125,1.0,-0.25},{0.625,-0.625,0.25}},{{-1.0,-0.125,0.75},{-0.5,0.375,-0.875}}}},np.float32)
  local b=np.zeros({1,3,0,3},np.uint32)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 8 dtype "..r.dtype)
  assert(close(r.shape,{1,3,2,1,3,0}),"inner 8 shape")
  assert(close(r.strides,{0,0,0,0,0,0}),"inner 8 strides")
  assert(close(r:tolist(),{{{{{{},{},{}}},{{{},{},{}}}},{{{{},{},{}}},{{{},{},{}}}},{{{{},{},{}}},{{{},{},{}}}}}}),"inner 8 values")
end
do -- inner 9
  local a=np.zeros({0,0,0},np.int32)
  local b=np.zeros({0},np.uint32)
  local r=np.inner(a,b)
  assert(r.dtype=="int64","inner 9 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"inner 9 shape")
  assert(close(r.strides,{0,0}),"inner 9 strides")
  assert(close(r:tolist(),{}),"inner 9 values")
end
do -- inner 10
  local a=np.zeros({2,0,4},np.float64)
  local b=np.zeros({0,4},np.uint8)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 10 dtype "..r.dtype)
  assert(close(r.shape,{2,0,0}),"inner 10 shape")
  assert(close(r.strides,{0,0,0}),"inner 10 strides")
  assert(close(r:tolist(),{{},{}}),"inner 10 values")
end
do -- inner 11
  local a=np.reshape(np.array({3},np.uint16),{})
  local b=np.zeros({2,0},np.bool)
  local r=np.inner(a,b)
  assert(r.dtype=="uint16","inner 11 dtype "..r.dtype)
  assert(close(r.shape,{2,0}),"inner 11 shape")
  assert(close(r.strides,{0,0}),"inner 11 strides")
  assert(close(r:tolist(),{{},{}}),"inner 11 values")
end
do -- inner 12
  local a=np.zeros({0,0,1,0},np.int64)
  local b=np.zeros({0},np.bool)
  local r=np.inner(a,b)
  assert(r.dtype=="int64","inner 12 dtype "..r.dtype)
  assert(close(r.shape,{0,0,1}),"inner 12 shape")
  assert(close(r.strides,{0,0,0}),"inner 12 strides")
  assert(close(r:tolist(),{}),"inner 12 values")
end
do -- inner 13
  local a=np.zeros({0},np.uint32)
  local b=np.zeros({1,2,0},np.uint16)
  local r=np.inner(a,b)
  assert(r.dtype=="uint32","inner 13 dtype "..r.dtype)
  assert(close(r.shape,{1,2}),"inner 13 shape")
  assert(close(r.strides,{8,4}),"inner 13 strides")
  assert(close(r:tolist(),{{0,0}}),"inner 13 values")
end
do -- inner 14
  local a=np.array({{4,-4,1,6},{-2,3,-5,0}},np.int8)
  local b=np.array({5,-3,2,-6},np.int64)
  local r=np.inner(a,b)
  assert(r.dtype=="int64","inner 14 dtype "..r.dtype)
  assert(close(r.shape,{2}),"inner 14 shape")
  assert(close(r.strides,{8}),"inner 14 strides")
  assert(close(r:tolist(),{-2,-29}),"inner 14 values")
end
do -- inner 15
  local a=np.zeros({3,0,3,3},np.int8)
  local b=np.array({{5,3,1}},np.uint32)
  local r=np.inner(a,b)
  assert(r.dtype=="int64","inner 15 dtype "..r.dtype)
  assert(close(r.shape,{3,0,3,1}),"inner 15 shape")
  assert(close(r.strides,{0,0,0,0}),"inner 15 strides")
  assert(close(r:tolist(),{{},{},{}}),"inner 15 values")
end
do -- inner 16
  local a=np.zeros({1,3,1,0},np.float64)
  local b=np.zeros({0,0},np.uint64)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 16 dtype "..r.dtype)
  assert(close(r.shape,{1,3,1,0}),"inner 16 shape")
  assert(close(r.strides,{0,0,0,0}),"inner 16 strides")
  assert(close(r:tolist(),{{{{}},{{}},{{}}}}),"inner 16 values")
end
do -- inner 17
  local a=np.zeros({0,1,0,3},np.int8)
  local b=np.array({-2,3,-5},np.int64)
  local r=np.inner(a,b)
  assert(r.dtype=="int64","inner 17 dtype "..r.dtype)
  assert(close(r.shape,{0,1,0}),"inner 17 shape")
  assert(close(r.strides,{0,0,0}),"inner 17 strides")
  assert(close(r:tolist(),{}),"inner 17 values")
end
do -- inner 18
  local a=np.zeros({0},np.uint16)
  local b=np.zeros({0,0,0},np.float32)
  local r=np.inner(a,b)
  assert(r.dtype=="float32","inner 18 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"inner 18 shape")
  assert(close(r.strides,{0,0}),"inner 18 strides")
  assert(close(r:tolist(),{}),"inner 18 values")
end
do -- inner 19
  local a=np.zeros({0},np.float64)
  local b=np.zeros({0},np.float16)
  local r=np.inner(a,b)
  assert(close(r,0.0),"inner 19 scalar")
end
do -- inner 20
  local a=np.reshape(np.array({0.0},np.float64),{})
  local b=np.reshape(np.array({1},np.uint32),{})
  local r=np.inner(a,b)
  assert(close(r,0.0),"inner 20 scalar")
end
do -- inner 21
  local a=np.zeros({2,0},np.uint32)
  local b=np.zeros({1,0},np.int16)
  local r=np.inner(a,b)
  assert(r.dtype=="int64","inner 21 dtype "..r.dtype)
  assert(close(r.shape,{2,1}),"inner 21 shape")
  assert(close(r.strides,{8,8}),"inner 21 strides")
  assert(close(r:tolist(),{{0},{0}}),"inner 21 values")
end
do -- inner 22
  local a=np.array({-6},np.int8)
  local b=np.array({{5},{3}},np.uint8)
  local r=np.inner(a,b)
  assert(r.dtype=="int16","inner 22 dtype "..r.dtype)
  assert(close(r.shape,{2}),"inner 22 shape")
  assert(close(r.strides,{2}),"inner 22 strides")
  assert(close(r:tolist(),{-30,-18}),"inner 22 values")
end
do -- inner 23
  local a=np.array({6},np.uint8)
  local b=np.zeros({0,1,1},np.int8)
  local r=np.inner(a,b)
  assert(r.dtype=="int16","inner 23 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"inner 23 shape")
  assert(close(r.strides,{0,0}),"inner 23 strides")
  assert(close(r:tolist(),{}),"inner 23 values")
end
do -- inner 24
  local a=np.zeros({0,0,1,3},np.uint32)
  local b=np.zeros({0,0,0,3},np.float64)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 24 dtype "..r.dtype)
  assert(close(r.shape,{0,0,1,0,0,0}),"inner 24 shape")
  assert(close(r.strides,{0,0,0,0,0,0}),"inner 24 strides")
  assert(close(r:tolist(),{}),"inner 24 values")
end
do -- inner 25
  local a=np.array({-0.875,0.0},np.float32)
  local b=np.array({-0.75,0.125},np.float32)
  local r=np.inner(a,b)
  assert(close(r,0.65625),"inner 25 scalar")
end
do -- inner 26
  local a=np.array({{false},{true}},np.bool)
  local b=np.array({3},np.int32)
  local r=np.inner(a,b)
  assert(r.dtype=="int32","inner 26 dtype "..r.dtype)
  assert(close(r.shape,{2}),"inner 26 shape")
  assert(close(r.strides,{4}),"inner 26 strides")
  assert(close(r:tolist(),{0,3}),"inner 26 values")
end
do -- inner 27
  local a=np.zeros({1,3,0},np.int8)
  local b=np.zeros({0},np.uint8)
  local r=np.inner(a,b)
  assert(r.dtype=="int16","inner 27 dtype "..r.dtype)
  assert(close(r.shape,{1,3}),"inner 27 shape")
  assert(close(r.strides,{6,2}),"inner 27 strides")
  assert(close(r:tolist(),{{0,0,0}}),"inner 27 values")
end
do -- inner 28
  local a=np.array({6},np.int16)
  local b=np.array({{{3}}},np.uint32)
  local r=np.inner(a,b)
  assert(r.dtype=="int64","inner 28 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"inner 28 shape")
  assert(close(r.strides,{8,8}),"inner 28 strides")
  assert(close(r:tolist(),{{18}}),"inner 28 values")
end
do -- inner 29
  local a=np.array({0.125,1.0,-0.25},np.float64)
  local b=np.zeros({2,0,3},np.int64)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 29 dtype "..r.dtype)
  assert(close(r.shape,{2,0}),"inner 29 shape")
  assert(close(r.strides,{0,0}),"inner 29 strides")
  assert(close(r:tolist(),{{},{}}),"inner 29 values")
end
do -- inner 30
  local a=np.array({{6,4,2},{0,5,3},{1,6,4}},np.uint32)
  local b=np.zeros({0,3,3},np.int8)
  local r=np.inner(a,b)
  assert(r.dtype=="int64","inner 30 dtype "..r.dtype)
  assert(close(r.shape,{3,0,3}),"inner 30 shape")
  assert(close(r.strides,{0,0,0}),"inner 30 strides")
  assert(close(r:tolist(),{{},{},{}}),"inner 30 values")
end
do -- inner 31
  local a=np.array({{-1,4,-4,1}},np.int64)
  local b=np.array({{{{0,5,-3,2},{-6,-1,4,-4},{1,6,-2,3}},{{-5,0,5,-3},{2,-6,-1,4},{-4,1,6,-2}},{{3,-5,0,5},{-3,2,-6,-1},{4,-4,1,6}}}},np.int16)
  local r=np.inner(a,b)
  assert(r.dtype=="int64","inner 31 dtype "..r.dtype)
  assert(close(r.shape,{1,1,3,3}),"inner 31 shape")
  assert(close(r.strides,{72,72,24,8}),"inner 31 strides")
  assert(close(r:tolist(),{{{{34,-18,34},{-18,-18,-18},{-18,34,-18}}}}),"inner 31 values")
end
do -- inner 32
  local a=np.zeros({0},np.int16)
  local b=np.zeros({0},np.int64)
  local r=np.inner(a,b)
  assert(close(r,0),"inner 32 scalar")
end
do -- inner 33
  local a=np.reshape(np.array({3},np.int64),{})
  local b=np.zeros({1,0},np.int64)
  local r=np.inner(a,b)
  assert(r.dtype=="int64","inner 33 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"inner 33 shape")
  assert(close(r.strides,{0,0}),"inner 33 strides")
  assert(close(r:tolist(),{{}}),"inner 33 values")
end
do -- inner 34
  local a=np.array({0},np.uint32)
  local b=(np.array({{6}},np.int16)).T
  local r=np.inner(a,b)
  assert(r.dtype=="int64","inner 34 dtype "..r.dtype)
  assert(close(r.shape,{1}),"inner 34 shape")
  assert(close(r.strides,{8}),"inner 34 strides")
  assert(close(r:tolist(),{0}),"inner 34 values")
end
do -- inner 35
  local a=np.array({{{-6,-1,4,-4}},{{1,6,-2,3}}},np.int8)
  local b=np.array({{3,1,6,4},{2,0,5,3},{1,6,4,2}},np.uint64)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 35 dtype "..r.dtype)
  assert(close(r.shape,{2,1,3}),"inner 35 shape")
  assert(close(r.strides,{24,24,8}),"inner 35 strides")
  assert(close(r:tolist(),{{{-11.0,-4.0,-4.0}},{{9.0,1.0,35.0}}}),"inner 35 values")
end
do -- inner 36
  local a=np.zeros({2,0,0},np.uint64)
  local b=np.zeros({1,3,3,0},np.int8)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 36 dtype "..r.dtype)
  assert(close(r.shape,{2,0,1,3,3}),"inner 36 shape")
  assert(close(r.strides,{0,0,0,0,0}),"inner 36 strides")
  assert(close(r:tolist(),{{},{}}),"inner 36 values")
end
do -- inner 37
  local a=np.array({{{{6,4,2,0},{5,3,1,6},{4,2,0,5}},{{3,1,6,4},{2,0,5,3},{1,6,4,2}},{{0,5,3,1},{6,4,2,0},{5,3,1,6}}},{{{4,2,0,5},{3,1,6,4},{2,0,5,3}},{{1,6,4,2},{0,5,3,1},{6,4,2,0}},{{5,3,1,6},{4,2,0,5},{3,1,6,4}}},{{{2,0,5,3},{1,6,4,2},{0,5,3,1}},{{6,4,2,0},{5,3,1,6},{4,2,0,5}},{{3,1,6,4},{2,0,5,3},{1,6,4,2}}}},np.uint16)
  local b=np.array({{0,5,3,1}},np.uint32)
  local r=np.inner(a,b)
  assert(r.dtype=="uint32","inner 37 dtype "..r.dtype)
  assert(close(r.shape,{3,3,3,1}),"inner 37 shape")
  assert(close(r.strides,{36,12,4,4}),"inner 37 strides")
  assert(close(r:tolist(),{{{{26},{24},{15}},{{27},{18},{44}},{{35},{26},{24}}},{{{15},{27},{18}},{{44},{35},{26}},{{24},{15},{27}}},{{{18},{44},{35}},{{26},{24},{15}},{{27},{18},{44}}}}),"inner 37 values")
end
do -- inner 38
  local a=np.array({{{1,6,4}}},np.uint32)
  local b=np.array({{{2,0,5}}},np.uint32)
  local r=np.inner(a,b)
  assert(r.dtype=="uint32","inner 38 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,1}),"inner 38 shape")
  assert(close(r.strides,{4,4,4,4}),"inner 38 strides")
  assert(close(r:tolist(),{{{{22}}}}),"inner 38 values")
end
do -- inner 39
  local a=np.zeros({2,0},np.int32)
  local b=np.zeros({0},np.uint32)
  local r=np.inner(a,b)
  assert(r.dtype=="int64","inner 39 dtype "..r.dtype)
  assert(close(r.shape,{2}),"inner 39 shape")
  assert(close(r.strides,{8}),"inner 39 strides")
  assert(close(r:tolist(),{0,0}),"inner 39 values")
end
do -- inner 40
  local a=np.reshape(np.array({0.75},np.float64),{})
  local b=(np.zeros({1,0},np.int64)).T
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 40 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"inner 40 shape")
  assert(close(r.strides,{0,0}),"inner 40 strides")
  assert(close(r:tolist(),{}),"inner 40 values")
end
do -- inner 41
  local a=(np.array({{6,-2,3}},np.int8)).T
  local b=np.array({{-1.0},{-0.125}},np.float16)
  local r=np.inner(a,b)
  assert(r.dtype=="float16","inner 41 dtype "..r.dtype)
  assert(close(r.shape,{3,2}),"inner 41 shape")
  assert(close(r.strides,{4,2}),"inner 41 strides")
  assert(close(r:tolist(),{{-6.0,-0.75},{2.0,0.25},{-3.0,-0.375}}),"inner 41 values")
end
do -- inner 42
  local a=np.reshape(np.array({-5},np.int64),{})
  local b=np.reshape(np.array({3},np.uint32),{})
  local r=np.inner(a,b)
  assert(close(r,-15),"inner 42 scalar")
end
do -- inner 43
  local a=np.array({{{{-3,2,-6}},{{-1,4,-4}}},{{{1,6,-2}},{{3,-5,0}}},{{{5,-3,2}},{{-6,-1,4}}}},np.int64)
  local b=np.array({-0.5,0.375,-0.875},np.float64)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 43 dtype "..r.dtype)
  assert(close(r.shape,{3,2,1}),"inner 43 shape")
  assert(close(r.strides,{16,8,8}),"inner 43 strides")
  assert(close(r:tolist(),{{{7.5},{5.5}},{{3.5},{-3.375}},{{-5.375},{-0.875}}}),"inner 43 values")
end
do -- inner 44
  local a=np.zeros({0,1},np.uint32)
  local b=np.array({{0},{5}},np.int32)
  local r=np.inner(a,b)
  assert(r.dtype=="int64","inner 44 dtype "..r.dtype)
  assert(close(r.shape,{0,2}),"inner 44 shape")
  assert(close(r.strides,{0,0}),"inner 44 strides")
  assert(close(r:tolist(),{}),"inner 44 values")
end
do -- inner 45
  local a=np.reshape(np.array({1},np.int64),{})
  local b=np.array({2},np.int64)
  local r=np.inner(a,b)
  assert(r.dtype=="int64","inner 45 dtype "..r.dtype)
  assert(close(r.shape,{1}),"inner 45 shape")
  assert(close(r.strides,{8}),"inner 45 strides")
  assert(close(r:tolist(),{2}),"inner 45 values")
end
do -- inner 46
  local a=np.reshape(np.array({3},np.int8),{})
  local b=np.zeros({0,3,2},np.float32)
  local r=np.inner(a,b)
  assert(r.dtype=="float32","inner 46 dtype "..r.dtype)
  assert(close(r.shape,{0,3,2}),"inner 46 shape")
  assert(close(r.strides,{0,0,0}),"inner 46 strides")
  assert(close(r:tolist(),{}),"inner 46 values")
end
do -- inner 47
  local a=np.zeros({2,0,4},np.int32)
  local b=np.zeros({2,0,4},np.int32)
  local r=np.inner(a,b)
  assert(r.dtype=="int32","inner 47 dtype "..r.dtype)
  assert(close(r.shape,{2,0,2,0}),"inner 47 shape")
  assert(close(r.strides,{0,0,0,0}),"inner 47 strides")
  assert(close(r:tolist(),{{},{}}),"inner 47 values")
end
do -- inner 48
  local a=np.array({{{true,false}},{{true,true}}},np.bool)
  local b=np.array({{{{-5,0},{5,-3},{2,-6}},{{-1,4},{-4,1},{6,-2}},{{3,-5},{0,5},{-3,2}}},{{{-6,-1},{4,-4},{1,6}},{{-2,3},{-5,0},{5,-3}},{{2,-6},{-1,4},{-4,1}}},{{{6,-2},{3,-5},{0,5}},{{-3,2},{-6,-1},{4,-4}},{{1,6},{-2,3},{-5,0}}}},np.int32)
  local r=np.inner(a,b)
  assert(r.dtype=="int32","inner 48 dtype "..r.dtype)
  assert(close(r.shape,{2,1,3,3,3}),"inner 48 shape")
  assert(close(r.strides,{108,108,36,12,4}),"inner 48 strides")
  assert(close(r:tolist(),{{{{{-5,5,2},{-1,-4,6},{3,0,-3}},{{-6,4,1},{-2,-5,5},{2,-1,-4}},{{6,3,0},{-3,-6,4},{1,-2,-5}}}},{{{{-5,2,-4},{3,-3,4},{-2,5,-1}},{{-7,0,7},{1,-5,2},{-4,3,-3}},{{4,-2,5},{-1,-7,0},{7,1,-5}}}}}),"inner 48 values")
end
do -- inner 49
  local a=np.array({-4},np.int8)
  local b=np.array({{true}},np.bool)
  local r=np.inner(a,b)
  assert(r.dtype=="int8","inner 49 dtype "..r.dtype)
  assert(close(r.shape,{1}),"inner 49 shape")
  assert(close(r.strides,{1}),"inner 49 strides")
  assert(close(r:tolist(),{-4}),"inner 49 values")
end
do -- inner 50
  local a=np.reshape(np.array({-2},np.int8),{})
  local b=np.array({{{5}},{{3}}},np.uint64)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 50 dtype "..r.dtype)
  assert(close(r.shape,{2,1,1}),"inner 50 shape")
  assert(close(r.strides,{8,8,8}),"inner 50 strides")
  assert(close(r:tolist(),{{{-10.0}},{{-6.0}}}),"inner 50 values")
end
do -- inner 51
  local a=np.array({{{{6}}},{{{4}}}},np.uint64)
  local b=np.array({{{{0}},{{5}}}},np.uint32)
  local r=np.inner(a,b)
  assert(r.dtype=="uint64","inner 51 dtype "..r.dtype)
  assert(close(r.shape,{2,1,1,1,2,1}),"inner 51 shape")
  assert(close(r.strides,{16,16,16,16,8,8}),"inner 51 strides")
  assert(close(r:tolist(),{{{{{{0},{30}}}}},{{{{{0},{20}}}}}}),"inner 51 values")
end
do -- inner 52
  local a=np.reshape(np.array({true},np.bool),{})
  local b=np.array({{3,-5},{0,5}},np.int16)
  local r=np.inner(a,b)
  assert(r.dtype=="int16","inner 52 dtype "..r.dtype)
  assert(close(r.shape,{2,2}),"inner 52 shape")
  assert(close(r.strides,{4,2}),"inner 52 strides")
  assert(close(r:tolist(),{{3,-5},{0,5}}),"inner 52 values")
end
do -- inner 53
  local a=np.array({{{4,-4,1,6},{-2,3,-5,0}},{{5,-3,2,-6},{-1,4,-4,1}},{{6,-2,3,-5},{0,5,-3,2}}},np.int8)
  local b=np.array({{{5,-3,2,-6},{-1,4,-4,1},{6,-2,3,-5}},{{0,5,-3,2},{-6,-1,4,-4},{1,6,-2,3}}},np.int16)
  local r=np.inner(a,b)
  assert(r.dtype=="int16","inner 53 dtype "..r.dtype)
  assert(close(r.shape,{3,2,2,3}),"inner 53 shape")
  assert(close(r.strides,{24,12,6,2}),"inner 53 strides")
  assert(close(r:tolist(),{{{{-2,-18,5},{-11,-40,-4}},{{-29,34,-33},{30,-11,26}}},{{{74,-31,72},{-33,5,-35}},{{-31,34,-31},{34,-18,34}}},{{{72,-31,74},{-29,-2,-27}},{{-33,34,-29},{38,-25,42}}}}),"inner 53 values")
end
do -- inner 54
  local a=np.array({{6}},np.int16)
  local b=np.zeros({2,0,1,1},np.int64)
  local r=np.inner(a,b)
  assert(r.dtype=="int64","inner 54 dtype "..r.dtype)
  assert(close(r.shape,{1,2,0,1}),"inner 54 shape")
  assert(close(r.strides,{0,0,0,0}),"inner 54 strides")
  assert(close(r:tolist(),{{{},{}}}),"inner 54 values")
end
do -- inner 55
  local a=np.zeros({1,3,0},np.float64)
  local b=np.zeros({0},np.float16)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 55 dtype "..r.dtype)
  assert(close(r.shape,{1,3}),"inner 55 shape")
  assert(close(r.strides,{24,8}),"inner 55 strides")
  assert(close(r:tolist(),{{0.0,0.0,0.0}}),"inner 55 values")
end
do -- inner 56
  local a=np.zeros({3,2,0,0},np.float16)
  local b=np.zeros({0,0,0},np.float64)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 56 dtype "..r.dtype)
  assert(close(r.shape,{3,2,0,0,0}),"inner 56 shape")
  assert(close(r.strides,{0,0,0,0,0}),"inner 56 strides")
  assert(close(r:tolist(),{{{},{}},{{},{}},{{},{}}}),"inner 56 values")
end
do -- inner 57
  local a=np.zeros({3,2,2,0},np.uint32)
  local b=np.zeros({0},np.float64)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 57 dtype "..r.dtype)
  assert(close(r.shape,{3,2,2}),"inner 57 shape")
  assert(close(r.strides,{32,16,8}),"inner 57 strides")
  assert(close(r:tolist(),{{{0.0,0.0},{0.0,0.0}},{{0.0,0.0},{0.0,0.0}},{{0.0,0.0},{0.0,0.0}}}),"inner 57 values")
end
do -- inner 58
  local a=np.reshape(np.array({6},np.uint16),{})
  local b=np.array({2},np.int64)
  local r=np.inner(a,b)
  assert(r.dtype=="int64","inner 58 dtype "..r.dtype)
  assert(close(r.shape,{1}),"inner 58 shape")
  assert(close(r.strides,{8}),"inner 58 strides")
  assert(close(r:tolist(),{12}),"inner 58 values")
end
do -- inner 59
  local a=np.array({{false,true,true,false}},np.bool)
  local b=np.array({{{{true,true,false,true}},{{true,false,true,true}}},{{{false,true,true,false}},{{true,true,false,true}}},{{{true,false,true,true}},{{false,true,true,false}}}},np.bool)
  local r=np.inner(a,b)
  assert(r.dtype=="bool","inner 59 dtype "..r.dtype)
  assert(close(r.shape,{1,3,2,1}),"inner 59 shape")
  assert(close(r.strides,{6,2,1,1}),"inner 59 strides")
  assert(close(r:tolist(),{{{{true},{true}},{{true},{true}},{{true},{true}}}}),"inner 59 values")
end
do -- inner 60
  local a=np.reshape(np.array({3},np.uint32),{})
  local b=np.array({{{6,-2,3}}},np.int8)
  local r=np.inner(a,b)
  assert(r.dtype=="int64","inner 60 dtype "..r.dtype)
  assert(close(r.shape,{1,1,3}),"inner 60 shape")
  assert(close(r.strides,{24,24,8}),"inner 60 strides")
  assert(close(r:tolist(),{{{18,-6,9}}}),"inner 60 values")
end
do -- inner 61
  local a=np.array({{{{-0.375,0.5,-0.75},{0.125,1.0,-0.25},{0.625,-0.625,0.25}}},{{{-1.0,-0.125,0.75},{-0.5,0.375,-0.875},{0.0,0.875,-0.375}}}},np.float32)
  local b=np.zeros({3,0,1,3},np.uint64)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 61 dtype "..r.dtype)
  assert(close(r.shape,{2,1,3,3,0,1}),"inner 61 shape")
  assert(close(r.strides,{0,0,0,0,0,0}),"inner 61 strides")
  assert(close(r:tolist(),{{{{{},{},{}},{{},{},{}},{{},{},{}}}},{{{{},{},{}},{{},{},{}},{{},{},{}}}}}),"inner 61 values")
end
do -- inner 62
  local a=np.reshape(np.array({-4},np.int64),{})
  local b=np.reshape(np.array({0.0},np.float16),{})
  local r=np.inner(a,b)
  assert(close(r,-0.0),"inner 62 scalar")
end
do -- inner 63
  local a=np.array({{{{-2},{3}}},{{{-5},{0}}}},np.int64)
  local b=np.zeros({3,3,0,1},np.int32)
  local r=np.inner(a,b)
  assert(r.dtype=="int64","inner 63 dtype "..r.dtype)
  assert(close(r.shape,{2,1,2,3,3,0}),"inner 63 shape")
  assert(close(r.strides,{0,0,0,0,0,0}),"inner 63 strides")
  assert(close(r:tolist(),{{{{{{},{},{}},{{},{},{}},{{},{},{}}},{{{},{},{}},{{},{},{}},{{},{},{}}}}},{{{{{},{},{}},{{},{},{}},{{},{},{}}},{{{},{},{}},{{},{},{}},{{},{},{}}}}}}),"inner 63 values")
end
do -- inner 64
  local a=np.zeros({1,2,0},np.bool)
  local b=np.zeros({3,0,3,0},np.int32)
  local r=np.inner(a,b)
  assert(r.dtype=="int32","inner 64 dtype "..r.dtype)
  assert(close(r.shape,{1,2,3,0,3}),"inner 64 shape")
  assert(close(r.strides,{0,0,0,0,0}),"inner 64 strides")
  assert(close(r:tolist(),{{{{},{},{}},{{},{},{}}}}),"inner 64 values")
end
do -- inner 65
  local a=np.array({{6,4,2},{0,5,3},{1,6,4}},np.uint32)
  local b=np.zeros({0,1,0,3},np.float16)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 65 dtype "..r.dtype)
  assert(close(r.shape,{3,0,1,0}),"inner 65 shape")
  assert(close(r.strides,{0,0,0,0}),"inner 65 strides")
  assert(close(r:tolist(),{{},{},{}}),"inner 65 values")
end
do -- inner 66
  local a=np.zeros({1,2,0,0},np.int8)
  local b=np.zeros({0},np.float32)
  local r=np.inner(a,b)
  assert(r.dtype=="float32","inner 66 dtype "..r.dtype)
  assert(close(r.shape,{1,2,0}),"inner 66 shape")
  assert(close(r.strides,{0,0,0}),"inner 66 strides")
  assert(close(r:tolist(),{{{},{}}}),"inner 66 values")
end
do -- inner 67
  local a=np.array({3},np.uint16)
  local b=np.array({{{-6},{-1},{4}},{{-4},{1},{6}}},np.int32)
  local r=np.inner(a,b)
  assert(r.dtype=="int32","inner 67 dtype "..r.dtype)
  assert(close(r.shape,{2,3}),"inner 67 shape")
  assert(close(r.strides,{12,4}),"inner 67 strides")
  assert(close(r:tolist(),{{-18,-3,12},{-12,3,18}}),"inner 67 values")
end
do -- inner 68
  local a=np.array({{{5},{3},{1}}},np.uint16)
  local b=np.array({{{{-0.625},{0.25},{-1.0}}},{{{-0.125},{0.75},{-0.5}}}},np.float16)
  local r=np.inner(a,b)
  assert(r.dtype=="float32","inner 68 dtype "..r.dtype)
  assert(close(r.shape,{1,3,2,1,3}),"inner 68 shape")
  assert(close(r.strides,{72,24,12,12,4}),"inner 68 strides")
  assert(close(r:tolist(),{{{{{-3.125,1.25,-5.0}},{{-0.625,3.75,-2.5}}},{{{-1.875,0.75,-3.0}},{{-0.375,2.25,-1.5}}},{{{-0.625,0.25,-1.0}},{{-0.125,0.75,-0.5}}}}}),"inner 68 values")
end
do -- inner 69
  local a=np.reshape(np.array({0},np.uint8),{})
  local b=np.zeros({0,2,0},np.uint64)
  local r=np.inner(a,b)
  assert(r.dtype=="uint64","inner 69 dtype "..r.dtype)
  assert(close(r.shape,{0,2,0}),"inner 69 shape")
  assert(close(r.strides,{0,0,0}),"inner 69 strides")
  assert(close(r:tolist(),{}),"inner 69 values")
end
do -- inner 70
  local a=np.reshape(np.array({2},np.uint16),{})
  local b=np.array({{-0.125,0.75,-0.5},{0.375,-0.875,0.0}},np.float64)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 70 dtype "..r.dtype)
  assert(close(r.shape,{2,3}),"inner 70 shape")
  assert(close(r.strides,{24,8}),"inner 70 strides")
  assert(close(r:tolist(),{{-0.25,1.5,-1.0},{0.75,-1.75,0.0}}),"inner 70 values")
end
do -- inner 71
  local a=np.zeros({0,3,2,2},np.uint8)
  local b=np.zeros({2,0,2},np.int32)
  local r=np.inner(a,b)
  assert(r.dtype=="int32","inner 71 dtype "..r.dtype)
  assert(close(r.shape,{0,3,2,2,0}),"inner 71 shape")
  assert(close(r.strides,{0,0,0,0,0}),"inner 71 strides")
  assert(close(r:tolist(),{}),"inner 71 values")
end
do -- inner 72
  local a=np.array({{{{0.25},{-1.0},{-0.125}},{{0.75},{-0.5},{0.375}}},{{{-0.875},{0.0},{0.875}},{{-0.375},{0.5},{-0.75}}},{{{0.125},{1.0},{-0.25}},{{0.625},{-0.625},{0.25}}}},np.float16)
  local b=(np.array({{false}},np.bool)).T
  local r=np.inner(a,b)
  assert(r.dtype=="float16","inner 72 dtype "..r.dtype)
  assert(close(r.shape,{3,2,3,1}),"inner 72 shape")
  assert(close(r.strides,{12,6,2,2}),"inner 72 strides")
  assert(close(r:tolist(),{{{{0.0},{0.0},{0.0}},{{0.0},{0.0},{0.0}}},{{{0.0},{0.0},{0.0}},{{0.0},{0.0},{0.0}}},{{{0.0},{0.0},{0.0}},{{0.0},{0.0},{0.0}}}}),"inner 72 values")
end
do -- inner 73
  local a=np.zeros({0,1,1,4},np.uint16)
  local b=np.array({2,0,5,3},np.uint32)
  local r=np.inner(a,b)
  assert(r.dtype=="uint32","inner 73 dtype "..r.dtype)
  assert(close(r.shape,{0,1,1}),"inner 73 shape")
  assert(close(r.strides,{0,0,0}),"inner 73 strides")
  assert(close(r:tolist(),{}),"inner 73 values")
end
do -- inner 74
  local a=np.zeros({1,0,0,3},np.float16)
  local b=np.zeros({2,0,0,3},np.uint16)
  local r=np.inner(a,b)
  assert(r.dtype=="float32","inner 74 dtype "..r.dtype)
  assert(close(r.shape,{1,0,0,2,0,0}),"inner 74 shape")
  assert(close(r.strides,{0,0,0,0,0,0}),"inner 74 strides")
  assert(close(r:tolist(),{{}}),"inner 74 values")
end
do -- inner 75
  local a=np.reshape(np.array({5},np.uint32),{})
  local b=np.array({{6,4}},np.uint8)
  local r=np.inner(a,b)
  assert(r.dtype=="uint32","inner 75 dtype "..r.dtype)
  assert(close(r.shape,{1,2}),"inner 75 shape")
  assert(close(r.strides,{8,4}),"inner 75 strides")
  assert(close(r:tolist(),{{30,20}}),"inner 75 values")
end
do -- inner 76
  local a=np.reshape(np.array({0},np.uint64),{})
  local b=np.array({{{-0.75},{0.125}},{{1.0},{-0.25}},{{0.625},{-0.625}}},np.float16)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 76 dtype "..r.dtype)
  assert(close(r.shape,{3,2,1}),"inner 76 shape")
  assert(close(r.strides,{16,8,8}),"inner 76 strides")
  assert(close(r:tolist(),{{{-0.0},{0.0}},{{0.0},{-0.0}},{{0.0},{-0.0}}}),"inner 76 values")
end
do -- inner 77
  local a=np.zeros({0},np.float64)
  local b=np.zeros({3,0},np.float64)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 77 dtype "..r.dtype)
  assert(close(r.shape,{3}),"inner 77 shape")
  assert(close(r.strides,{8}),"inner 77 strides")
  assert(close(r:tolist(),{0.0,0.0,0.0}),"inner 77 values")
end
do -- inner 78
  local a=np.array({2,-6,-1,4},np.int32)
  local b=np.array({{3,-5,0,5}},np.int16)
  local r=np.inner(a,b)
  assert(r.dtype=="int32","inner 78 dtype "..r.dtype)
  assert(close(r.shape,{1}),"inner 78 shape")
  assert(close(r.strides,{4}),"inner 78 strides")
  assert(close(r:tolist(),{56}),"inner 78 values")
end
do -- inner 79
  local a=np.reshape(np.array({true},np.bool),{})
  local b=(np.array({{5},{-3},{2}},np.int16)).T
  local r=np.inner(a,b)
  assert(r.dtype=="int16","inner 79 dtype "..r.dtype)
  assert(close(r.shape,{1,3}),"inner 79 shape")
  assert(close(r.strides,{6,2}),"inner 79 strides")
  assert(close(r:tolist(),{{5,-3,2}}),"inner 79 values")
end
do -- inner 80
  local a=np.zeros({1,2,0},np.float64)
  local b=np.zeros({1,0,0},np.uint32)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 80 dtype "..r.dtype)
  assert(close(r.shape,{1,2,1,0}),"inner 80 shape")
  assert(close(r.strides,{0,0,0,0}),"inner 80 strides")
  assert(close(r:tolist(),{{{{}},{{}}}}),"inner 80 values")
end
do -- inner 81
  local a=np.array({3},np.uint32)
  local b=np.zeros({2,0,2,1},np.uint64)
  local r=np.inner(a,b)
  assert(r.dtype=="uint64","inner 81 dtype "..r.dtype)
  assert(close(r.shape,{2,0,2}),"inner 81 shape")
  assert(close(r.strides,{0,0,0}),"inner 81 strides")
  assert(close(r:tolist(),{{},{}}),"inner 81 values")
end
do -- inner 82
  local a=np.array({0.625,-0.625,0.25,-1.0},np.float16)
  local b=np.array({{-2,3,-5,0},{5,-3,2,-6}},np.int64)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 82 dtype "..r.dtype)
  assert(close(r.shape,{2}),"inner 82 shape")
  assert(close(r.strides,{8}),"inner 82 strides")
  assert(close(r:tolist(),{-4.375,11.5}),"inner 82 values")
end
do -- inner 83
  local a=np.reshape(np.array({0},np.uint8),{})
  local b=np.zeros({0},np.bool)
  local r=np.inner(a,b)
  assert(r.dtype=="uint8","inner 83 dtype "..r.dtype)
  assert(close(r.shape,{0}),"inner 83 shape")
  assert(close(r.strides,{0}),"inner 83 strides")
  assert(close(r:tolist(),{}),"inner 83 values")
end
do -- inner 84
  local a=np.array({1,6,-2,3},np.int32)
  local b=np.array({{2,-6,-1,4}},np.int16)
  local r=np.inner(a,b)
  assert(r.dtype=="int32","inner 84 dtype "..r.dtype)
  assert(close(r.shape,{1}),"inner 84 shape")
  assert(close(r.strides,{4}),"inner 84 strides")
  assert(close(r:tolist(),{-20}),"inner 84 values")
end
do -- inner 85
  local a=np.zeros({0,2,1,0},np.int16)
  local b=np.zeros({2,0},np.int16)
  local r=np.inner(a,b)
  assert(r.dtype=="int16","inner 85 dtype "..r.dtype)
  assert(close(r.shape,{0,2,1,2}),"inner 85 shape")
  assert(close(r.strides,{0,0,0,0}),"inner 85 strides")
  assert(close(r:tolist(),{}),"inner 85 values")
end
do -- inner 86
  local a=np.array({5,-3},np.int8)
  local b=np.array({{{-0.375,0.5}}},np.float64)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 86 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"inner 86 shape")
  assert(close(r.strides,{8,8}),"inner 86 strides")
  assert(close(r:tolist(),{{-3.375}}),"inner 86 values")
end
do -- inner 87
  local a=np.zeros({2,0},np.uint64)
  local b=np.zeros({0},np.bool)
  local r=np.inner(a,b)
  assert(r.dtype=="uint64","inner 87 dtype "..r.dtype)
  assert(close(r.shape,{2}),"inner 87 shape")
  assert(close(r.strides,{8}),"inner 87 strides")
  assert(close(r:tolist(),{0,0}),"inner 87 values")
end
do -- inner 88
  local a=np.array({{{3,1,6,4}},{{2,0,5,3}}},np.uint32)
  local b=np.array({0.125,1.0,-0.25,0.625},np.float64)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 88 dtype "..r.dtype)
  assert(close(r.shape,{2,1}),"inner 88 shape")
  assert(close(r.strides,{8,8}),"inner 88 strides")
  assert(close(r:tolist(),{{2.375},{0.875}}),"inner 88 values")
end
do -- inner 89
  local a=np.zeros({3,2,0},np.float16)
  local b=np.zeros({0},np.uint32)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 89 dtype "..r.dtype)
  assert(close(r.shape,{3,2}),"inner 89 shape")
  assert(close(r.strides,{16,8}),"inner 89 strides")
  assert(close(r:tolist(),{{0.0,0.0},{0.0,0.0},{0.0,0.0}}),"inner 89 values")
end
do -- inner 90
  local a=np.array({true,false,true,true},np.bool)
  local b=np.zeros({1,3,0,4},np.uint16)
  local r=np.inner(a,b)
  assert(r.dtype=="uint16","inner 90 dtype "..r.dtype)
  assert(close(r.shape,{1,3,0}),"inner 90 shape")
  assert(close(r.strides,{0,0,0}),"inner 90 strides")
  assert(close(r:tolist(),{{{},{},{}}}),"inner 90 values")
end
do -- inner 91
  local a=np.array({{{0.75,-0.5,0.375,-0.875},{0.0,0.875,-0.375,0.5},{-0.75,0.125,1.0,-0.25}}},np.float32)
  local b=np.array({3,1,6,4},np.uint64)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 91 dtype "..r.dtype)
  assert(close(r.shape,{1,3}),"inner 91 shape")
  assert(close(r.strides,{24,8}),"inner 91 strides")
  assert(close(r:tolist(),{{0.5,0.625,2.875}}),"inner 91 values")
end
do -- inner 92
  local a=np.zeros({2,1,0},np.uint32)
  local b=np.zeros({3,0},np.uint32)
  local r=np.inner(a,b)
  assert(r.dtype=="uint32","inner 92 dtype "..r.dtype)
  assert(close(r.shape,{2,1,3}),"inner 92 shape")
  assert(close(r.strides,{12,12,4}),"inner 92 strides")
  assert(close(r:tolist(),{{{0,0,0}},{{0,0,0}}}),"inner 92 values")
end
do -- inner 93
  local a=np.zeros({3,0,1},np.bool)
  local b=np.array({false},np.bool)
  local r=np.inner(a,b)
  assert(r.dtype=="bool","inner 93 dtype "..r.dtype)
  assert(close(r.shape,{3,0}),"inner 93 shape")
  assert(close(r.strides,{0,0}),"inner 93 strides")
  assert(close(r:tolist(),{{},{},{}}),"inner 93 values")
end
do -- inner 94
  local a=(np.array({{true},{true}},np.bool)).T
  local b=np.array({true,false},np.bool)
  local r=np.inner(a,b)
  assert(r.dtype=="bool","inner 94 dtype "..r.dtype)
  assert(close(r.shape,{1}),"inner 94 shape")
  assert(close(r.strides,{1}),"inner 94 strides")
  assert(close(r:tolist(),{true}),"inner 94 values")
end
do -- inner 95
  local a=np.zeros({3,3,0},np.int16)
  local b=np.zeros({0,3,1,0},np.float64)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 95 dtype "..r.dtype)
  assert(close(r.shape,{3,3,0,3,1}),"inner 95 shape")
  assert(close(r.strides,{0,0,0,0,0}),"inner 95 strides")
  assert(close(r:tolist(),{{{},{},{}},{{},{},{}},{{},{},{}}}),"inner 95 values")
end
do -- inner 96
  local a=np.array({5,3,1,6},np.uint64)
  local b=np.array({{6,4,2,0},{5,3,1,6}},np.uint8)
  local r=np.inner(a,b)
  assert(r.dtype=="uint64","inner 96 dtype "..r.dtype)
  assert(close(r.shape,{2}),"inner 96 shape")
  assert(close(r.strides,{8}),"inner 96 strides")
  assert(close(r:tolist(),{44,71}),"inner 96 values")
end
do -- inner 97
  local a=np.array({{{0},{5}}},np.uint8)
  local b=(np.array({{1,6}},np.uint64)).T
  local r=np.inner(a,b)
  assert(r.dtype=="uint64","inner 97 dtype "..r.dtype)
  assert(close(r.shape,{1,2,2}),"inner 97 shape")
  assert(close(r.strides,{32,16,8}),"inner 97 strides")
  assert(close(r:tolist(),{{{0,0},{5,30}}}),"inner 97 values")
end
do -- inner 98
  local a=np.array({3},np.int16)
  local b=np.array({3},np.uint64)
  local r=np.inner(a,b)
  assert(close(r,9.0),"inner 98 scalar")
end
do -- inner 99
  local a=np.array({{{true,false},{true,true}},{{false,true},{true,false}},{{true,true},{false,true}}},np.bool)
  local b=np.zeros({3,0,1,2},np.uint8)
  local r=np.inner(a,b)
  assert(r.dtype=="uint8","inner 99 dtype "..r.dtype)
  assert(close(r.shape,{3,2,3,0,1}),"inner 99 shape")
  assert(close(r.strides,{0,0,0,0,0}),"inner 99 strides")
  assert(close(r:tolist(),{{{{},{},{}},{{},{},{}}},{{{},{},{}},{{},{},{}}},{{{},{},{}},{{},{},{}}}}),"inner 99 values")
end
do -- inner 100
  local a=np.zeros({3,2,0,3},np.float16)
  local b=np.array({{{-5,0,5}},{{-3,2,-6}}},np.int32)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 100 dtype "..r.dtype)
  assert(close(r.shape,{3,2,0,2,1}),"inner 100 shape")
  assert(close(r.strides,{0,0,0,0,0}),"inner 100 strides")
  assert(close(r:tolist(),{{{},{}},{{},{}},{{},{}}}),"inner 100 values")
end
do -- inner 101
  local a=np.reshape(np.array({1},np.uint8),{})
  local b=np.array({-3,2},np.int16)
  local r=np.inner(a,b)
  assert(r.dtype=="int16","inner 101 dtype "..r.dtype)
  assert(close(r.shape,{2}),"inner 101 shape")
  assert(close(r.strides,{2}),"inner 101 strides")
  assert(close(r:tolist(),{-3,2}),"inner 101 values")
end
do -- inner 102
  local a=np.array({{{{true,false,true}},{{true,false,true}},{{true,false,true}}},{{{true,false,true}},{{true,false,true}},{{true,false,true}}},{{{true,false,true}},{{true,false,true}},{{true,false,true}}}},np.bool)
  local b=np.array({{false,true,true}},np.bool)
  local r=np.inner(a,b)
  assert(r.dtype=="bool","inner 102 dtype "..r.dtype)
  assert(close(r.shape,{3,3,1,1}),"inner 102 shape")
  assert(close(r.strides,{3,1,1,1}),"inner 102 strides")
  assert(close(r:tolist(),{{{{true}},{{true}},{{true}}},{{{true}},{{true}},{{true}}},{{{true}},{{true}},{{true}}}}),"inner 102 values")
end
do -- inner 103
  local a=np.zeros({0},np.int32)
  local b=np.zeros({3,3,3,0},np.uint32)
  local r=np.inner(a,b)
  assert(r.dtype=="int64","inner 103 dtype "..r.dtype)
  assert(close(r.shape,{3,3,3}),"inner 103 shape")
  assert(close(r.strides,{72,24,8}),"inner 103 strides")
  assert(close(r:tolist(),{{{0,0,0},{0,0,0},{0,0,0}},{{0,0,0},{0,0,0},{0,0,0}},{{0,0,0},{0,0,0},{0,0,0}}}),"inner 103 values")
end
do -- inner 104
  local a=np.array({{{0,5},{3,1}}},np.uint32)
  local b=np.array({1,6},np.uint64)
  local r=np.inner(a,b)
  assert(r.dtype=="uint64","inner 104 dtype "..r.dtype)
  assert(close(r.shape,{1,2}),"inner 104 shape")
  assert(close(r.strides,{16,8}),"inner 104 strides")
  assert(close(r:tolist(),{{30,9}}),"inner 104 values")
end
do -- inner 105
  local a=(np.array({{4,-4,1},{6,-2,3},{-5,0,5},{-3,2,-6}},np.int8)).T
  local b=np.zeros({2,0,2,4},np.int32)
  local r=np.inner(a,b)
  assert(r.dtype=="int32","inner 105 dtype "..r.dtype)
  assert(close(r.shape,{3,2,0,2}),"inner 105 shape")
  assert(close(r.strides,{0,0,0,0}),"inner 105 strides")
  assert(close(r:tolist(),{{{},{}},{{},{}},{{},{}}}),"inner 105 values")
end
do -- inner 106
  local a=np.reshape(np.array({6},np.int32),{})
  local b=np.array({-6,-1},np.int32)
  local r=np.inner(a,b)
  assert(r.dtype=="int32","inner 106 dtype "..r.dtype)
  assert(close(r.shape,{2}),"inner 106 shape")
  assert(close(r.strides,{4}),"inner 106 strides")
  assert(close(r:tolist(),{-36,-6}),"inner 106 values")
end
do -- inner 107
  local a=np.zeros({3,2,0,0},np.float16)
  local b=np.zeros({2,0,0,0},np.uint8)
  local r=np.inner(a,b)
  assert(r.dtype=="float16","inner 107 dtype "..r.dtype)
  assert(close(r.shape,{3,2,0,2,0,0}),"inner 107 shape")
  assert(close(r.strides,{0,0,0,0,0,0}),"inner 107 strides")
  assert(close(r:tolist(),{{{},{}},{{},{}},{{},{}}}),"inner 107 values")
end
do -- inner 108
  local a=np.array({0.75,-0.5,0.375,-0.875},np.float32)
  local b=np.zeros({2,0,4},np.int32)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 108 dtype "..r.dtype)
  assert(close(r.shape,{2,0}),"inner 108 shape")
  assert(close(r.strides,{0,0}),"inner 108 strides")
  assert(close(r:tolist(),{{},{}}),"inner 108 values")
end
do -- inner 109
  local a=np.reshape(np.array({-1},np.int32),{})
  local b=np.array({-1.0,-0.125},np.float16)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 109 dtype "..r.dtype)
  assert(close(r.shape,{2}),"inner 109 shape")
  assert(close(r.strides,{8}),"inner 109 strides")
  assert(close(r:tolist(),{1.0,0.125}),"inner 109 values")
end
do -- inner 110
  local a=np.array({{5,3,1}},np.uint8)
  local b=np.array({{{{-0.75,0.125,1.0},{-0.25,0.625,-0.625}}},{{{0.25,-1.0,-0.125},{0.75,-0.5,0.375}}}},np.float16)
  local r=np.inner(a,b)
  assert(r.dtype=="float16","inner 110 dtype "..r.dtype)
  assert(close(r.shape,{1,2,1,2}),"inner 110 shape")
  assert(close(r.strides,{8,4,4,2}),"inner 110 strides")
  assert(close(r:tolist(),{{{{-2.375,0.0}},{{-1.875,2.625}}}}),"inner 110 values")
end
do -- inner 111
  local a=np.zeros({2,2,0},np.int32)
  local b=np.zeros({3,2,1,0},np.int8)
  local r=np.inner(a,b)
  assert(r.dtype=="int32","inner 111 dtype "..r.dtype)
  assert(close(r.shape,{2,2,3,2,1}),"inner 111 shape")
  assert(close(r.strides,{48,24,8,4,4}),"inner 111 strides")
  assert(close(r:tolist(),{{{{{0},{0}},{{0},{0}},{{0},{0}}},{{{0},{0}},{{0},{0}},{{0},{0}}}},{{{{0},{0}},{{0},{0}},{{0},{0}}},{{{0},{0}},{{0},{0}},{{0},{0}}}}}),"inner 111 values")
end
do -- inner 112
  local a=np.array({{{5,-3}},{{2,-6}},{{-1,4}}},np.int32)
  local b=np.array({6,-2},np.int8)
  local r=np.inner(a,b)
  assert(r.dtype=="int32","inner 112 dtype "..r.dtype)
  assert(close(r.shape,{3,1}),"inner 112 shape")
  assert(close(r.strides,{4,4}),"inner 112 strides")
  assert(close(r:tolist(),{{36},{24},{-14}}),"inner 112 values")
end
do -- inner 113
  local a=np.zeros({2,0,4},np.float32)
  local b=np.zeros({2,0,4},np.float32)
  local r=np.inner(a,b)
  assert(r.dtype=="float32","inner 113 dtype "..r.dtype)
  assert(close(r.shape,{2,0,2,0}),"inner 113 shape")
  assert(close(r.strides,{0,0,0,0}),"inner 113 strides")
  assert(close(r:tolist(),{{},{}}),"inner 113 values")
end
do -- inner 114
  local a=np.reshape(np.array({6},np.uint32),{})
  local b=np.reshape(np.array({-3},np.int32),{})
  local r=np.inner(a,b)
  assert(close(r,-18),"inner 114 scalar")
end
do -- inner 115
  local a=np.zeros({0},np.bool)
  local b=np.zeros({1,0},np.uint8)
  local r=np.inner(a,b)
  assert(r.dtype=="uint8","inner 115 dtype "..r.dtype)
  assert(close(r.shape,{1}),"inner 115 shape")
  assert(close(r.strides,{1}),"inner 115 strides")
  assert(close(r:tolist(),{0}),"inner 115 values")
end
do -- inner 116
  local a=np.array({0,5},np.int8)
  local b=np.zeros({0,0,2},np.uint64)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 116 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"inner 116 shape")
  assert(close(r.strides,{0,0}),"inner 116 strides")
  assert(close(r:tolist(),{}),"inner 116 values")
end
do -- inner 117
  local a=np.zeros({2,0,0,1},np.bool)
  local b=np.zeros({3,0,2,1},np.int16)
  local r=np.inner(a,b)
  assert(r.dtype=="int16","inner 117 dtype "..r.dtype)
  assert(close(r.shape,{2,0,0,3,0,2}),"inner 117 shape")
  assert(close(r.strides,{0,0,0,0,0,0}),"inner 117 strides")
  assert(close(r:tolist(),{{},{}}),"inner 117 values")
end
do -- inner 118
  local a=np.array({4,-4,1,6},np.int8)
  local b=np.array({1,6,4,2},np.uint32)
  local r=np.inner(a,b)
  assert(close(r,-4),"inner 118 scalar")
end
do -- inner 119
  local a=np.reshape(np.array({-0.75},np.float64),{})
  local b=np.reshape(np.array({-6},np.int16),{})
  local r=np.inner(a,b)
  assert(close(r,4.5),"inner 119 scalar")
end
do -- inner 120
  local a=np.array({{{-0.5},{0.375}},{{-0.875},{0.0}},{{0.875},{-0.375}}},np.float32)
  local b=np.zeros({1,0,1},np.uint16)
  local r=np.inner(a,b)
  assert(r.dtype=="float32","inner 120 dtype "..r.dtype)
  assert(close(r.shape,{3,2,1,0}),"inner 120 shape")
  assert(close(r.strides,{0,0,0,0}),"inner 120 strides")
  assert(close(r:tolist(),{{{{}},{{}}},{{{}},{{}}},{{{}},{{}}}}),"inner 120 values")
end
do -- inner 121
  local a=np.zeros({3,0,1},np.int32)
  local b=np.array({true},np.bool)
  local r=np.inner(a,b)
  assert(r.dtype=="int32","inner 121 dtype "..r.dtype)
  assert(close(r.shape,{3,0}),"inner 121 shape")
  assert(close(r.strides,{0,0}),"inner 121 strides")
  assert(close(r:tolist(),{{},{},{}}),"inner 121 values")
end
do -- inner 122
  local a=np.array({{1}},np.uint16)
  local b=np.zeros({0,3,1},np.uint8)
  local r=np.inner(a,b)
  assert(r.dtype=="uint16","inner 122 dtype "..r.dtype)
  assert(close(r.shape,{1,0,3}),"inner 122 shape")
  assert(close(r.strides,{0,0,0}),"inner 122 strides")
  assert(close(r:tolist(),{{}}),"inner 122 values")
end
do -- inner 123
  local a=np.zeros({2,0,1,4},np.float32)
  local b=np.array({0.375,-0.875,0.0,0.875},np.float32)
  local r=np.inner(a,b)
  assert(r.dtype=="float32","inner 123 dtype "..r.dtype)
  assert(close(r.shape,{2,0,1}),"inner 123 shape")
  assert(close(r.strides,{0,0,0}),"inner 123 strides")
  assert(close(r:tolist(),{{},{}}),"inner 123 values")
end
do -- inner 124
  local a=np.reshape(np.array({3},np.int64),{})
  local b=np.reshape(np.array({4},np.int32),{})
  local r=np.inner(a,b)
  assert(close(r,12),"inner 124 scalar")
end
do -- inner 125
  local a=np.reshape(np.array({0.75},np.float32),{})
  local b=np.zeros({1,0},np.float16)
  local r=np.inner(a,b)
  assert(r.dtype=="float32","inner 125 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"inner 125 shape")
  assert(close(r.strides,{0,0}),"inner 125 strides")
  assert(close(r:tolist(),{{}}),"inner 125 values")
end
do -- inner 126
  local a=np.array({{{1.0,-0.25}}},np.float32)
  local b=np.array({3,1},np.uint32)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 126 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"inner 126 shape")
  assert(close(r.strides,{8,8}),"inner 126 strides")
  assert(close(r:tolist(),{{2.75}}),"inner 126 values")
end
do -- inner 127
  local a=np.array({{{{-0.875}},{{0.0}},{{0.875}}},{{{-0.375}},{{0.5}},{{-0.75}}}},np.float16)
  local b=np.zeros({2,0,2,1},np.bool)
  local r=np.inner(a,b)
  assert(r.dtype=="float16","inner 127 dtype "..r.dtype)
  assert(close(r.shape,{2,3,1,2,0,2}),"inner 127 shape")
  assert(close(r.strides,{0,0,0,0,0,0}),"inner 127 strides")
  assert(close(r:tolist(),{{{{{},{}}},{{{},{}}},{{{},{}}}},{{{{},{}}},{{{},{}}},{{{},{}}}}}),"inner 127 values")
end
do -- inner 128
  local a=np.zeros({3,2,0},np.int32)
  local b=np.zeros({0},np.float16)
  local r=np.inner(a,b)
  assert(r.dtype=="float64","inner 128 dtype "..r.dtype)
  assert(close(r.shape,{3,2}),"inner 128 shape")
  assert(close(r.strides,{16,8}),"inner 128 strides")
  assert(close(r:tolist(),{{0.0,0.0},{0.0,0.0},{0.0,0.0}}),"inner 128 values")
end
do -- inner 129
  local a=np.zeros({1,0,0},np.bool)
  local b=np.zeros({2,3,0},np.bool)
  local r=np.inner(a,b)
  assert(r.dtype=="bool","inner 129 dtype "..r.dtype)
  assert(close(r.shape,{1,0,2,3}),"inner 129 shape")
  assert(close(r.strides,{0,0,0,0}),"inner 129 strides")
  assert(close(r:tolist(),{{}}),"inner 129 values")
end
do -- outer 0
  local a=np.zeros({0},np.float64)
  local b=np.zeros({3,0},np.int64)
  local r=np.outer(a,b)
  assert(r.dtype=="float64","outer 0 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"outer 0 shape")
  assert(close(r.strides,{0,0}),"outer 0 strides")
  assert(close(r:tolist(),{}),"outer 0 values")
end
do -- outer 1
  local a=(np.array({{0,5}},np.int32)).T
  local b=np.reshape(np.array({1},np.uint64),{})
  local r=np.outer(a,b)
  assert(r.dtype=="float64","outer 1 dtype "..r.dtype)
  assert(close(r.shape,{2,1}),"outer 1 shape")
  assert(close(r.strides,{8,8}),"outer 1 strides")
  assert(close(r:tolist(),{{0.0},{5.0}}),"outer 1 values")
end
do -- outer 2
  local a=np.array({{2},{0},{5}},np.uint32)
  local b=np.array({{0.5,-0.75},{0.125,1.0},{-0.25,0.625}},np.float32)
  local r=np.outer(a,b)
  assert(r.dtype=="float64","outer 2 dtype "..r.dtype)
  assert(close(r.shape,{3,6}),"outer 2 shape")
  assert(close(r.strides,{48,8}),"outer 2 strides")
  assert(close(r:tolist(),{{1.0,-1.5,0.25,2.0,-0.5,1.25},{0.0,-0.0,0.0,0.0,-0.0,0.0},{2.5,-3.75,0.625,5.0,-1.25,3.125}}),"outer 2 values")
end
do -- outer 3
  local a=np.array({4},np.int64)
  local b=np.reshape(np.array({0.75},np.float16),{})
  local r=np.outer(a,b)
  assert(r.dtype=="float64","outer 3 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"outer 3 shape")
  assert(close(r.strides,{8,8}),"outer 3 strides")
  assert(close(r:tolist(),{{3.0}}),"outer 3 values")
end
do -- outer 4
  local a=np.array({{0.875,-0.375}},np.float64)
  local b=np.zeros({0},np.int16)
  local ob=np.zeros({0,2},np.float64)
  local o=ob.T
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 4 out identity")
  assert(close(r.strides,{0,0}),"outer 4 out strides")
  assert(close(r:tolist(),{{},{}}),"outer 4 out values")
end
do -- outer 5
  local a=np.zeros({0,0,3},np.int32)
  local b=np.zeros({0,2,0},np.int8)
  local o=np.zeros({0,0},np.int32)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 5 out identity")
  assert(close(r.strides,{0,0}),"outer 5 out strides")
  assert(close(r:tolist(),{}),"outer 5 out values")
end
do -- outer 6
  local a=np.reshape(np.array({-3},np.int64),{})
  local b=np.reshape(np.array({-2},np.int64),{})
  local o=np.zeros({1,1},np.int64)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 6 out identity")
  assert(close(r.strides,{8,8}),"outer 6 out strides")
  assert(close(r:tolist(),{{6}}),"outer 6 out values")
end
do -- outer 7
  local a=np.array({{5,3,1},{6,4,2}},np.uint8)
  local b=np.array({{{false,true,true},{false,true,true},{false,true,true}},{{false,true,true},{false,true,true},{false,true,true}},{{false,true,true},{false,true,true},{false,true,true}}},np.bool)
  local r=np.outer(a,b)
  assert(r.dtype=="uint8","outer 7 dtype "..r.dtype)
  assert(close(r.shape,{6,27}),"outer 7 shape")
  assert(close(r.strides,{27,1}),"outer 7 strides")
  assert(close(r:tolist(),{{0,5,5,0,5,5,0,5,5,0,5,5,0,5,5,0,5,5,0,5,5,0,5,5,0,5,5},{0,3,3,0,3,3,0,3,3,0,3,3,0,3,3,0,3,3,0,3,3,0,3,3,0,3,3},{0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1},{0,6,6,0,6,6,0,6,6,0,6,6,0,6,6,0,6,6,0,6,6,0,6,6,0,6,6},{0,4,4,0,4,4,0,4,4,0,4,4,0,4,4,0,4,4,0,4,4,0,4,4,0,4,4},{0,2,2,0,2,2,0,2,2,0,2,2,0,2,2,0,2,2,0,2,2,0,2,2,0,2,2}}),"outer 7 values")
end
do -- outer 8
  local a=np.zeros({0,3},np.uint16)
  local b=np.array({2,-6,-1},np.int16)
  local r=np.outer(a,b)
  assert(r.dtype=="int32","outer 8 dtype "..r.dtype)
  assert(close(r.shape,{0,3}),"outer 8 shape")
  assert(close(r.strides,{0,0}),"outer 8 strides")
  assert(close(r:tolist(),{}),"outer 8 values")
end
do -- outer 9
  local a=np.zeros({0},np.int16)
  local b=np.zeros({1,0,1},np.uint8)
  local o=np.zeros({0,0},np.int16)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 9 out identity")
  assert(close(r.strides,{0,0}),"outer 9 out strides")
  assert(close(r:tolist(),{}),"outer 9 out values")
end
do -- outer 10
  local a=np.reshape(np.array({5},np.int8),{})
  local b=np.zeros({2,0},np.int16)
  local r=np.outer(a,b)
  assert(r.dtype=="int16","outer 10 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"outer 10 shape")
  assert(close(r.strides,{0,0}),"outer 10 strides")
  assert(close(r:tolist(),{{}}),"outer 10 values")
end
do -- outer 11
  local a=np.zeros({2,0,1},np.uint32)
  local b=np.array({{0,5,3}},np.uint64)
  local r=np.outer(a,b)
  assert(r.dtype=="uint64","outer 11 dtype "..r.dtype)
  assert(close(r.shape,{0,3}),"outer 11 shape")
  assert(close(r.strides,{0,0}),"outer 11 strides")
  assert(close(r:tolist(),{}),"outer 11 values")
end
do -- outer 12
  local a=np.zeros({0,3},np.int16)
  local b=np.zeros({0,3,0},np.uint32)
  local r=np.outer(a,b)
  assert(r.dtype=="int64","outer 12 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"outer 12 shape")
  assert(close(r.strides,{0,0}),"outer 12 strides")
  assert(close(r:tolist(),{}),"outer 12 values")
end
do -- outer 13
  local a=np.array({{{-2}},{{3}}},np.int64)
  local b=np.array({-1,4,-4},np.int32)
  local o=np.zeros({2,3},np.int64)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 13 out identity")
  assert(close(r.strides,{24,8}),"outer 13 out strides")
  assert(close(r:tolist(),{{2,-8,8},{-3,12,-12}}),"outer 13 out values")
end
do -- outer 14
  local a=np.array({0,5},np.int32)
  local b=np.array({{{-0.75,0.125},{1.0,-0.25},{0.625,-0.625}},{{0.25,-1.0},{-0.125,0.75},{-0.5,0.375}},{{-0.875,0.0},{0.875,-0.375},{0.5,-0.75}}},np.float32)
  local ob=np.zeros({18,2},np.float64)
  local o=ob.T
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 14 out identity")
  assert(close(r.strides,{8,16}),"outer 14 out strides")
  assert(close(r:tolist(),{{-0.0,0.0,0.0,-0.0,0.0,-0.0,0.0,-0.0,-0.0,0.0,-0.0,0.0,-0.0,0.0,0.0,-0.0,0.0,-0.0},{-3.75,0.625,5.0,-1.25,3.125,-3.125,1.25,-5.0,-0.625,3.75,-2.5,1.875,-4.375,0.0,4.375,-1.875,2.5,-3.75}}),"outer 14 out values")
end
do -- outer 15
  local a=(np.zeros({0,2},np.bool)).T
  local b=np.reshape(np.array({1},np.uint32),{})
  local r=np.outer(a,b)
  assert(r.dtype=="uint32","outer 15 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"outer 15 shape")
  assert(close(r.strides,{0,0}),"outer 15 strides")
  assert(close(r:tolist(),{}),"outer 15 values")
end
do -- outer 16
  local a=np.array({2},np.uint16)
  local b=np.array({{{3,1,6},{4,2,0},{5,3,1}},{{6,4,2},{0,5,3},{1,6,4}}},np.uint16)
  local r=np.outer(a,b)
  assert(r.dtype=="uint16","outer 16 dtype "..r.dtype)
  assert(close(r.shape,{1,18}),"outer 16 shape")
  assert(close(r.strides,{36,2}),"outer 16 strides")
  assert(close(r:tolist(),{{6,2,12,8,4,0,10,6,2,12,8,4,0,10,6,2,12,8}}),"outer 16 values")
end
do -- outer 17
  local a=np.reshape(np.array({4},np.uint64),{})
  local b=np.zeros({0,2,1},np.uint32)
  local r=np.outer(a,b)
  assert(r.dtype=="uint64","outer 17 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"outer 17 shape")
  assert(close(r.strides,{0,0}),"outer 17 strides")
  assert(close(r:tolist(),{{}}),"outer 17 values")
end
do -- outer 18
  local a=(np.zeros({1,0},np.uint16)).T
  local b=np.zeros({1,1,0},np.int32)
  local r=np.outer(a,b)
  assert(r.dtype=="int32","outer 18 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"outer 18 shape")
  assert(close(r.strides,{0,0}),"outer 18 strides")
  assert(close(r:tolist(),{}),"outer 18 values")
end
do -- outer 19
  local a=np.array({1},np.uint32)
  local b=np.zeros({0,3,2},np.uint32)
  local r=np.outer(a,b)
  assert(r.dtype=="uint32","outer 19 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"outer 19 shape")
  assert(close(r.strides,{0,0}),"outer 19 strides")
  assert(close(r:tolist(),{{}}),"outer 19 values")
end
do -- outer 20
  local a=np.array({3,1,6},np.uint32)
  local b=np.zeros({2,0},np.float64)
  local r=np.outer(a,b)
  assert(r.dtype=="float64","outer 20 dtype "..r.dtype)
  assert(close(r.shape,{3,0}),"outer 20 shape")
  assert(close(r.strides,{0,0}),"outer 20 strides")
  assert(close(r:tolist(),{{},{},{}}),"outer 20 values")
end
do -- outer 21
  local a=np.zeros({0,1,0},np.uint16)
  local b=(np.array({{6,4},{2,0},{5,3}},np.uint8)).T
  local r=np.outer(a,b)
  assert(r.dtype=="uint16","outer 21 dtype "..r.dtype)
  assert(close(r.shape,{0,6}),"outer 21 shape")
  assert(close(r.strides,{0,0}),"outer 21 strides")
  assert(close(r:tolist(),{}),"outer 21 values")
end
do -- outer 22
  local a=np.zeros({0,2,3},np.uint8)
  local b=np.array({4},np.int8)
  local r=np.outer(a,b)
  assert(r.dtype=="int16","outer 22 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"outer 22 shape")
  assert(close(r.strides,{0,0}),"outer 22 strides")
  assert(close(r:tolist(),{}),"outer 22 values")
end
do -- outer 23
  local a=np.zeros({1,0},np.int16)
  local b=(np.zeros({2,0},np.float16)).T
  local r=np.outer(a,b)
  assert(r.dtype=="float32","outer 23 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"outer 23 shape")
  assert(close(r.strides,{0,0}),"outer 23 strides")
  assert(close(r:tolist(),{}),"outer 23 values")
end
do -- outer 24
  local a=np.array({4,2},np.uint16)
  local b=np.zeros({2,3,0},np.uint64)
  local r=np.outer(a,b)
  assert(r.dtype=="uint64","outer 24 dtype "..r.dtype)
  assert(close(r.shape,{2,0}),"outer 24 shape")
  assert(close(r.strides,{0,0}),"outer 24 strides")
  assert(close(r:tolist(),{{},{}}),"outer 24 values")
end
do -- outer 25
  local a=np.reshape(np.array({-4},np.int16),{})
  local b=np.array({{-0.125},{0.75}},np.float32)
  local r=np.outer(a,b)
  assert(r.dtype=="float32","outer 25 dtype "..r.dtype)
  assert(close(r.shape,{1,2}),"outer 25 shape")
  assert(close(r.strides,{8,4}),"outer 25 strides")
  assert(close(r:tolist(),{{0.5,-3.0}}),"outer 25 values")
end
do -- outer 26
  local a=np.reshape(np.array({-2},np.int64),{})
  local b=np.array({{-1}},np.int64)
  local r=np.outer(a,b)
  assert(r.dtype=="int64","outer 26 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"outer 26 shape")
  assert(close(r.strides,{8,8}),"outer 26 strides")
  assert(close(r:tolist(),{{2}}),"outer 26 values")
end
do -- outer 27
  local a=np.array({{{3,1}},{{6,4}}},np.uint64)
  local b=np.zeros({1,0,1},np.uint16)
  local r=np.outer(a,b)
  assert(r.dtype=="uint64","outer 27 dtype "..r.dtype)
  assert(close(r.shape,{4,0}),"outer 27 shape")
  assert(close(r.strides,{0,0}),"outer 27 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"outer 27 values")
end
do -- outer 28
  local a=np.array({5,3},np.uint16)
  local b=np.array({{{3,-5}},{{0,5}}},np.int32)
  local o=np.zeros({2,4},np.int32)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 28 out identity")
  assert(close(r.strides,{16,4}),"outer 28 out strides")
  assert(close(r:tolist(),{{15,-25,0,25},{9,-15,0,15}}),"outer 28 out values")
end
do -- outer 29
  local a=np.reshape(np.array({0},np.uint16),{})
  local b=np.array({0.875,-0.375,0.5},np.float64)
  local r=np.outer(a,b)
  assert(r.dtype=="float64","outer 29 dtype "..r.dtype)
  assert(close(r.shape,{1,3}),"outer 29 shape")
  assert(close(r.strides,{24,8}),"outer 29 strides")
  assert(close(r:tolist(),{{0.0,-0.0,0.0}}),"outer 29 values")
end
do -- outer 30
  local a=np.array({6,-2},np.int16)
  local b=np.reshape(np.array({-6},np.int16),{})
  local r=np.outer(a,b)
  assert(r.dtype=="int16","outer 30 dtype "..r.dtype)
  assert(close(r.shape,{2,1}),"outer 30 shape")
  assert(close(r.strides,{2,2}),"outer 30 strides")
  assert(close(r:tolist(),{{-36},{12}}),"outer 30 values")
end
do -- outer 31
  local a=np.reshape(np.array({4},np.uint8),{})
  local b=np.array({-4,1},np.int64)
  local r=np.outer(a,b)
  assert(r.dtype=="int64","outer 31 dtype "..r.dtype)
  assert(close(r.shape,{1,2}),"outer 31 shape")
  assert(close(r.strides,{16,8}),"outer 31 strides")
  assert(close(r:tolist(),{{-16,4}}),"outer 31 values")
end
do -- outer 32
  local a=np.reshape(np.array({-0.625},np.float16),{})
  local b=np.zeros({1,2,0},np.bool)
  local r=np.outer(a,b)
  assert(r.dtype=="float16","outer 32 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"outer 32 shape")
  assert(close(r.strides,{0,0}),"outer 32 strides")
  assert(close(r:tolist(),{{}}),"outer 32 values")
end
do -- outer 33
  local a=np.array({{{-1},{4}}},np.int16)
  local b=np.reshape(np.array({true},np.bool),{})
  local o=np.zeros({2,1},np.int16)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 33 out identity")
  assert(close(r.strides,{2,2}),"outer 33 out strides")
  assert(close(r:tolist(),{{-1},{4}}),"outer 33 out values")
end
do -- outer 34
  local a=np.zeros({0,2,1},np.uint8)
  local b=np.zeros({1,3,0},np.int64)
  local r=np.outer(a,b)
  assert(r.dtype=="int64","outer 34 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"outer 34 shape")
  assert(close(r.strides,{0,0}),"outer 34 strides")
  assert(close(r:tolist(),{}),"outer 34 values")
end
do -- outer 35
  local a=np.zeros({0,3},np.uint32)
  local b=np.zeros({1,0},np.uint16)
  local o=np.zeros({0,0},np.uint32)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 35 out identity")
  assert(close(r.strides,{0,0}),"outer 35 out strides")
  assert(close(r:tolist(),{}),"outer 35 out values")
end
do -- outer 36
  local a=np.zeros({0,2,1},np.uint8)
  local b=np.reshape(np.array({1},np.uint64),{})
  local r=np.outer(a,b)
  assert(r.dtype=="uint64","outer 36 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"outer 36 shape")
  assert(close(r.strides,{0,0}),"outer 36 strides")
  assert(close(r:tolist(),{}),"outer 36 values")
end
do -- outer 37
  local a=np.zeros({3,0},np.uint16)
  local b=np.array({-5,0,5},np.int8)
  local r=np.outer(a,b)
  assert(r.dtype=="int32","outer 37 dtype "..r.dtype)
  assert(close(r.shape,{0,3}),"outer 37 shape")
  assert(close(r.strides,{0,0}),"outer 37 strides")
  assert(close(r:tolist(),{}),"outer 37 values")
end
do -- outer 38
  local a=(np.zeros({0,3},np.uint64)).T
  local b=np.reshape(np.array({5},np.uint8),{})
  local o=np.zeros({0,1},np.uint64)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 38 out identity")
  assert(close(r.strides,{0,0}),"outer 38 out strides")
  assert(close(r:tolist(),{}),"outer 38 out values")
end
do -- outer 39
  local a=np.array({{-2,3},{-5,0}},np.int8)
  local b=np.array({-1},np.int64)
  local r=np.outer(a,b)
  assert(r.dtype=="int64","outer 39 dtype "..r.dtype)
  assert(close(r.shape,{4,1}),"outer 39 shape")
  assert(close(r.strides,{8,8}),"outer 39 strides")
  assert(close(r:tolist(),{{2},{-3},{5},{0}}),"outer 39 values")
end
do -- outer 40
  local a=np.zeros({0,1},np.int16)
  local b=np.reshape(np.array({1},np.int32),{})
  local o=np.zeros({0,1},np.int32)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 40 out identity")
  assert(close(r.strides,{0,0}),"outer 40 out strides")
  assert(close(r:tolist(),{}),"outer 40 out values")
end
do -- outer 41
  local a=np.reshape(np.array({2},np.int16),{})
  local b=np.zeros({2,0,1},np.bool)
  local r=np.outer(a,b)
  assert(r.dtype=="int16","outer 41 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"outer 41 shape")
  assert(close(r.strides,{0,0}),"outer 41 strides")
  assert(close(r:tolist(),{{}}),"outer 41 values")
end
do -- outer 42
  local a=np.reshape(np.array({4},np.int16),{})
  local b=np.zeros({0},np.uint32)
  local r=np.outer(a,b)
  assert(r.dtype=="int64","outer 42 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"outer 42 shape")
  assert(close(r.strides,{0,0}),"outer 42 strides")
  assert(close(r:tolist(),{{}}),"outer 42 values")
end
do -- outer 43
  local a=np.reshape(np.array({0},np.uint16),{})
  local b=np.zeros({0,0},np.float32)
  local ob=np.zeros({0,1},np.float64)
  local o=ob.T
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 43 out identity")
  assert(close(r.strides,{0,0}),"outer 43 out strides")
  assert(close(r:tolist(),{{}}),"outer 43 out values")
end
do -- outer 44
  local a=np.array({{{2},{0}},{{5},{3}}},np.uint8)
  local b=(np.zeros({0,1},np.bool)).T
  local o=np.zeros({4,0},np.uint8)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 44 out identity")
  assert(close(r.strides,{0,0}),"outer 44 out strides")
  assert(close(r:tolist(),{{},{},{},{}}),"outer 44 out values")
end
do -- outer 45
  local a=np.array({{{-3,2},{-6,-1},{4,-4}},{{1,6},{-2,3},{-5,0}}},np.int16)
  local b=np.reshape(np.array({0.625},np.float32),{})
  local r=np.outer(a,b)
  assert(r.dtype=="float32","outer 45 dtype "..r.dtype)
  assert(close(r.shape,{12,1}),"outer 45 shape")
  assert(close(r.strides,{4,4}),"outer 45 strides")
  assert(close(r:tolist(),{{-1.875},{1.25},{-3.75},{-0.625},{2.5},{-2.5},{0.625},{3.75},{-1.25},{1.875},{-3.125},{0.0}}),"outer 45 values")
end
do -- outer 46
  local a=np.reshape(np.array({0.75},np.float64),{})
  local b=np.array({false,true,true},np.bool)
  local ob=np.zeros({3,1},np.float64)
  local o=ob.T
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 46 out identity")
  assert(close(r.strides,{8,8}),"outer 46 out strides")
  assert(close(r:tolist(),{{0.0,0.75,0.75}}),"outer 46 out values")
end
do -- outer 47
  local a=np.array({{{1,6,-2}}},np.int64)
  local b=np.zeros({0},np.uint16)
  local o=np.zeros({3,0},np.int64)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 47 out identity")
  assert(close(r.strides,{0,0}),"outer 47 out strides")
  assert(close(r:tolist(),{{},{},{}}),"outer 47 out values")
end
do -- outer 48
  local a=np.zeros({3,1,0},np.int64)
  local b=np.reshape(np.array({4},np.uint64),{})
  local r=np.outer(a,b)
  assert(r.dtype=="float64","outer 48 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"outer 48 shape")
  assert(close(r.strides,{0,0}),"outer 48 strides")
  assert(close(r:tolist(),{}),"outer 48 values")
end
do -- outer 49
  local a=np.zeros({2,3,0},np.float32)
  local b=np.zeros({0,3},np.uint32)
  local r=np.outer(a,b)
  assert(r.dtype=="float64","outer 49 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"outer 49 shape")
  assert(close(r.strides,{0,0}),"outer 49 strides")
  assert(close(r:tolist(),{}),"outer 49 values")
end
do -- outer 50
  local a=(np.zeros({0,0},np.int8)).T
  local b=np.array({{-5,0},{5,-3}},np.int32)
  local r=np.outer(a,b)
  assert(r.dtype=="int32","outer 50 dtype "..r.dtype)
  assert(close(r.shape,{0,4}),"outer 50 shape")
  assert(close(r.strides,{0,0}),"outer 50 strides")
  assert(close(r:tolist(),{}),"outer 50 values")
end
do -- outer 51
  local a=np.zeros({2,0,0},np.float32)
  local b=np.array({{{3,1},{6,4}}},np.uint16)
  local o=np.zeros({0,4},np.float64)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 51 out identity")
  assert(close(r.strides,{0,0}),"outer 51 out strides")
  assert(close(r:tolist(),{}),"outer 51 out values")
end
do -- outer 52
  local a=np.zeros({1,0},np.int8)
  local b=np.zeros({0,0,2},np.int64)
  local r=np.outer(a,b)
  assert(r.dtype=="int64","outer 52 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"outer 52 shape")
  assert(close(r.strides,{0,0}),"outer 52 strides")
  assert(close(r:tolist(),{}),"outer 52 values")
end
do -- outer 53
  local a=np.array({{0.375},{-0.875}},np.float64)
  local b=np.zeros({3,3,0},np.int64)
  local o=np.zeros({2,0},np.float64)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 53 out identity")
  assert(close(r.strides,{0,0}),"outer 53 out strides")
  assert(close(r:tolist(),{{},{}}),"outer 53 out values")
end
do -- outer 54
  local a=np.array({{1,6},{4,2}},np.uint64)
  local b=np.array({0.75,-0.5,0.375},np.float32)
  local r=np.outer(a,b)
  assert(r.dtype=="float64","outer 54 dtype "..r.dtype)
  assert(close(r.shape,{4,3}),"outer 54 shape")
  assert(close(r.strides,{24,8}),"outer 54 strides")
  assert(close(r:tolist(),{{0.75,-0.5,0.375},{4.5,-3.0,2.25},{3.0,-2.0,1.5},{1.5,-1.0,0.75}}),"outer 54 values")
end
do -- outer 55
  local a=np.zeros({1,0},np.uint16)
  local b=np.array({{1.0,-0.25,0.625},{-0.625,0.25,-1.0}},np.float16)
  local r=np.outer(a,b)
  assert(r.dtype=="float32","outer 55 dtype "..r.dtype)
  assert(close(r.shape,{0,6}),"outer 55 shape")
  assert(close(r.strides,{0,0}),"outer 55 strides")
  assert(close(r:tolist(),{}),"outer 55 values")
end
do -- outer 56
  local a=np.reshape(np.array({6},np.int16),{})
  local b=np.reshape(np.array({-6},np.int32),{})
  local r=np.outer(a,b)
  assert(r.dtype=="int32","outer 56 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"outer 56 shape")
  assert(close(r.strides,{4,4}),"outer 56 strides")
  assert(close(r:tolist(),{{-36}}),"outer 56 values")
end
do -- outer 57
  local a=np.zeros({1,0},np.int32)
  local b=np.zeros({1,0,3},np.int8)
  local r=np.outer(a,b)
  assert(r.dtype=="int32","outer 57 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"outer 57 shape")
  assert(close(r.strides,{0,0}),"outer 57 strides")
  assert(close(r:tolist(),{}),"outer 57 values")
end
do -- outer 58
  local a=np.array({-0.5,0.375,-0.875},np.float64)
  local b=np.array({-0.375,0.5,-0.75},np.float16)
  local r=np.outer(a,b)
  assert(r.dtype=="float64","outer 58 dtype "..r.dtype)
  assert(close(r.shape,{3,3}),"outer 58 shape")
  assert(close(r.strides,{24,8}),"outer 58 strides")
  assert(close(r:tolist(),{{0.1875,-0.25,0.375},{-0.140625,0.1875,-0.28125},{0.328125,-0.4375,0.65625}}),"outer 58 values")
end
do -- outer 59
  local a=np.array({{-1,4,-4},{1,6,-2}},np.int16)
  local b=np.reshape(np.array({5},np.uint8),{})
  local o=np.zeros({6,1},np.int16)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 59 out identity")
  assert(close(r.strides,{2,2}),"outer 59 out strides")
  assert(close(r:tolist(),{{-5},{20},{-20},{5},{30},{-10}}),"outer 59 out values")
end
do -- outer 60
  local a=np.reshape(np.array({6},np.uint64),{})
  local b=np.array({{{0,5},{3,1},{6,4}},{{2,0},{5,3},{1,6}},{{4,2},{0,5},{3,1}}},np.uint8)
  local r=np.outer(a,b)
  assert(r.dtype=="uint64","outer 60 dtype "..r.dtype)
  assert(close(r.shape,{1,18}),"outer 60 shape")
  assert(close(r.strides,{144,8}),"outer 60 strides")
  assert(close(r:tolist(),{{0,30,18,6,36,24,12,0,30,18,6,36,24,12,0,30,18,6}}),"outer 60 values")
end
do -- outer 61
  local a=(np.array({{3}},np.int32)).T
  local b=np.array({{{false,true},{true,false},{true,true}}},np.bool)
  local ob=np.zeros({6,1},np.int32)
  local o=ob.T
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 61 out identity")
  assert(close(r.strides,{4,4}),"outer 61 out strides")
  assert(close(r:tolist(),{{0,3,3,0,3,3}}),"outer 61 out values")
end
do -- outer 62
  local a=(np.array({{5,-3,2},{-6,-1,4},{-4,1,6}},np.int64)).T
  local b=np.array({{4},{2},{0}},np.uint16)
  local o=np.zeros({9,3},np.int64)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 62 out identity")
  assert(close(r.strides,{24,8}),"outer 62 out strides")
  assert(close(r:tolist(),{{20,10,0},{-24,-12,0},{-16,-8,0},{-12,-6,0},{-4,-2,0},{4,2,0},{8,4,0},{16,8,0},{24,12,0}}),"outer 62 out values")
end
do -- outer 63
  local a=np.array({5,3,1},np.uint16)
  local b=np.array({6,4},np.uint8)
  local r=np.outer(a,b)
  assert(r.dtype=="uint16","outer 63 dtype "..r.dtype)
  assert(close(r.shape,{3,2}),"outer 63 shape")
  assert(close(r.strides,{4,2}),"outer 63 strides")
  assert(close(r:tolist(),{{30,20},{18,12},{6,4}}),"outer 63 values")
end
do -- outer 64
  local a=np.zeros({0,0},np.float16)
  local b=np.zeros({0,2,0},np.int8)
  local r=np.outer(a,b)
  assert(r.dtype=="float16","outer 64 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"outer 64 shape")
  assert(close(r.strides,{0,0}),"outer 64 strides")
  assert(close(r:tolist(),{}),"outer 64 values")
end
do -- outer 65
  local a=np.zeros({1,0},np.int8)
  local b=(np.zeros({1,0},np.int8)).T
  local o=np.zeros({0,0},np.int8)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 65 out identity")
  assert(close(r.strides,{0,0}),"outer 65 out strides")
  assert(close(r:tolist(),{}),"outer 65 out values")
end
do -- outer 66
  local a=np.zeros({3,2,0},np.float32)
  local b=np.array({5,3},np.uint16)
  local o=np.zeros({0,2},np.float32)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 66 out identity")
  assert(close(r.strides,{0,0}),"outer 66 out strides")
  assert(close(r:tolist(),{}),"outer 66 out values")
end
do -- outer 67
  local a=np.reshape(np.array({-0.375},np.float64),{})
  local b=(np.array({{3,-5},{0,5},{-3,2}},np.int32)).T
  local o=np.zeros({1,6},np.float64)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 67 out identity")
  assert(close(r.strides,{48,8}),"outer 67 out strides")
  assert(close(r:tolist(),{{-1.125,-0.0,1.125,1.875,-1.875,-0.75}}),"outer 67 out values")
end
do -- outer 68
  local a=np.zeros({3,0},np.uint16)
  local b=np.array({5,-3,2},np.int8)
  local r=np.outer(a,b)
  assert(r.dtype=="int32","outer 68 dtype "..r.dtype)
  assert(close(r.shape,{0,3}),"outer 68 shape")
  assert(close(r.strides,{0,0}),"outer 68 strides")
  assert(close(r:tolist(),{}),"outer 68 values")
end
do -- outer 69
  local a=(np.zeros({0,0},np.uint8)).T
  local b=np.reshape(np.array({4},np.uint64),{})
  local r=np.outer(a,b)
  assert(r.dtype=="uint64","outer 69 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"outer 69 shape")
  assert(close(r.strides,{0,0}),"outer 69 strides")
  assert(close(r:tolist(),{}),"outer 69 values")
end
do -- outer 70
  local a=np.reshape(np.array({-5},np.int64),{})
  local b=(np.zeros({0,2},np.int8)).T
  local r=np.outer(a,b)
  assert(r.dtype=="int64","outer 70 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"outer 70 shape")
  assert(close(r.strides,{0,0}),"outer 70 strides")
  assert(close(r:tolist(),{{}}),"outer 70 values")
end
do -- outer 71
  local a=np.array({{{true,true,false}}},np.bool)
  local b=np.array({0.75,-0.5},np.float64)
  local r=np.outer(a,b)
  assert(r.dtype=="float64","outer 71 dtype "..r.dtype)
  assert(close(r.shape,{3,2}),"outer 71 shape")
  assert(close(r.strides,{16,8}),"outer 71 strides")
  assert(close(r:tolist(),{{0.75,-0.5},{0.75,-0.5},{0.0,-0.0}}),"outer 71 values")
end
do -- outer 72
  local a=np.array({2},np.uint8)
  local b=np.reshape(np.array({3},np.uint32),{})
  local o=np.zeros({1,1},np.uint32)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 72 out identity")
  assert(close(r.strides,{4,4}),"outer 72 out strides")
  assert(close(r:tolist(),{{6}}),"outer 72 out values")
end
do -- outer 73
  local a=np.reshape(np.array({1},np.int32),{})
  local b=np.reshape(np.array({-0.875},np.float32),{})
  local o=np.zeros({1,1},np.float64)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 73 out identity")
  assert(close(r.strides,{8,8}),"outer 73 out strides")
  assert(close(r:tolist(),{{-0.875}}),"outer 73 out values")
end
do -- outer 74
  local a=np.zeros({3,0,3},np.uint8)
  local b=np.reshape(np.array({-0.625},np.float64),{})
  local r=np.outer(a,b)
  assert(r.dtype=="float64","outer 74 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"outer 74 shape")
  assert(close(r.strides,{0,0}),"outer 74 strides")
  assert(close(r:tolist(),{}),"outer 74 values")
end
do -- outer 75
  local a=np.reshape(np.array({1},np.uint32),{})
  local b=np.zeros({3,1,0},np.bool)
  local r=np.outer(a,b)
  assert(r.dtype=="uint32","outer 75 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"outer 75 shape")
  assert(close(r.strides,{0,0}),"outer 75 strides")
  assert(close(r:tolist(),{{}}),"outer 75 values")
end
do -- outer 76
  local a=np.array({-6,-1},np.int16)
  local b=np.reshape(np.array({-5},np.int32),{})
  local r=np.outer(a,b)
  assert(r.dtype=="int32","outer 76 dtype "..r.dtype)
  assert(close(r.shape,{2,1}),"outer 76 shape")
  assert(close(r.strides,{4,4}),"outer 76 strides")
  assert(close(r:tolist(),{{30},{5}}),"outer 76 values")
end
do -- outer 77
  local a=np.reshape(np.array({0.0},np.float32),{})
  local b=np.array({6},np.uint32)
  local r=np.outer(a,b)
  assert(r.dtype=="float64","outer 77 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"outer 77 shape")
  assert(close(r.strides,{8,8}),"outer 77 strides")
  assert(close(r:tolist(),{{0.0}}),"outer 77 values")
end
do -- outer 78
  local a=np.array({0,5},np.uint16)
  local b=(np.array({{-1,4},{-4,1}},np.int64)).T
  local o=np.zeros({2,4},np.int64)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 78 out identity")
  assert(close(r.strides,{32,8}),"outer 78 out strides")
  assert(close(r:tolist(),{{0,0,0,0},{-5,-20,20,5}}),"outer 78 out values")
end
do -- outer 79
  local a=np.zeros({0,2},np.int32)
  local b=np.zeros({0,0},np.float16)
  local r=np.outer(a,b)
  assert(r.dtype=="float64","outer 79 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"outer 79 shape")
  assert(close(r.strides,{0,0}),"outer 79 strides")
  assert(close(r:tolist(),{}),"outer 79 values")
end
do -- outer 80
  local a=np.zeros({0,1},np.float16)
  local b=np.zeros({0,0},np.uint64)
  local r=np.outer(a,b)
  assert(r.dtype=="float64","outer 80 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"outer 80 shape")
  assert(close(r.strides,{0,0}),"outer 80 strides")
  assert(close(r:tolist(),{}),"outer 80 values")
end
do -- outer 81
  local a=np.zeros({0,2,0},np.uint64)
  local b=np.reshape(np.array({5},np.int32),{})
  local r=np.outer(a,b)
  assert(r.dtype=="float64","outer 81 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"outer 81 shape")
  assert(close(r.strides,{0,0}),"outer 81 strides")
  assert(close(r:tolist(),{}),"outer 81 values")
end
do -- outer 82
  local a=np.array({6,-2,3},np.int64)
  local b=np.reshape(np.array({2},np.uint64),{})
  local r=np.outer(a,b)
  assert(r.dtype=="float64","outer 82 dtype "..r.dtype)
  assert(close(r.shape,{3,1}),"outer 82 shape")
  assert(close(r.strides,{8,8}),"outer 82 strides")
  assert(close(r:tolist(),{{12.0},{-4.0},{6.0}}),"outer 82 values")
end
do -- outer 83
  local a=np.zeros({2,0,2},np.int16)
  local b=np.zeros({0},np.uint8)
  local o=np.zeros({0,0},np.int16)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 83 out identity")
  assert(close(r.strides,{0,0}),"outer 83 out strides")
  assert(close(r:tolist(),{}),"outer 83 out values")
end
do -- outer 84
  local a=np.reshape(np.array({-0.375},np.float64),{})
  local b=np.array({-2,3,-5},np.int16)
  local r=np.outer(a,b)
  assert(r.dtype=="float64","outer 84 dtype "..r.dtype)
  assert(close(r.shape,{1,3}),"outer 84 shape")
  assert(close(r.strides,{24,8}),"outer 84 strides")
  assert(close(r:tolist(),{{0.75,-1.125,1.875}}),"outer 84 values")
end
do -- outer 85
  local a=np.array({{-1},{4}},np.int32)
  local b=np.array({{0,5},{-3,2}},np.int32)
  local r=np.outer(a,b)
  assert(r.dtype=="int32","outer 85 dtype "..r.dtype)
  assert(close(r.shape,{2,4}),"outer 85 shape")
  assert(close(r.strides,{16,4}),"outer 85 strides")
  assert(close(r:tolist(),{{0,-5,3,-2},{0,20,-12,8}}),"outer 85 values")
end
do -- outer 86
  local a=np.zeros({0,0},np.uint8)
  local b=np.zeros({3,1,0},np.int8)
  local r=np.outer(a,b)
  assert(r.dtype=="int16","outer 86 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"outer 86 shape")
  assert(close(r.strides,{0,0}),"outer 86 strides")
  assert(close(r:tolist(),{}),"outer 86 values")
end
do -- outer 87
  local a=np.array({false,true,true},np.bool)
  local b=np.array({{5,3}},np.uint8)
  local o=np.zeros({3,2},np.uint8)
  local r=np.outer(a,b,{out=o})
  assert(r==o,"outer 87 out identity")
  assert(close(r.strides,{2,1}),"outer 87 out strides")
  assert(close(r:tolist(),{{0,0},{5,3},{5,3}}),"outer 87 out values")
end
do -- outer 88
  local a=np.array({6},np.uint64)
  local b=np.zeros({0,2,2},np.int16)
  local r=np.outer(a,b)
  assert(r.dtype=="float64","outer 88 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"outer 88 shape")
  assert(close(r.strides,{0,0}),"outer 88 strides")
  assert(close(r:tolist(),{{}}),"outer 88 values")
end
do -- outer 89
  local a=np.zeros({1,1,0},np.uint64)
  local b=np.reshape(np.array({-5},np.int64),{})
  local r=np.outer(a,b)
  assert(r.dtype=="float64","outer 89 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"outer 89 shape")
  assert(close(r.strides,{0,0}),"outer 89 strides")
  assert(close(r:tolist(),{}),"outer 89 values")
end
do local a=np.reshape(np.arange(24,np.float64),{2,3,4}); local b=np.reshape(np.arange(40,np.float64),{2,4,5}); local r=np.dot(a,b); assert(close(r.shape,{2,3,2,5}),"dot >2d shape") end
do local a=np.array({1,2,3},np.int64); assert(a:dot(a)==14,"ndarray dot method") end
do local a=np.array({1,2},np.int64); local b=np.array({3,4},np.int64); local r=np.outer(a,b); assert(close(r:tolist(),{{3,4},{6,8}}),"outer basic") end
do local a=np.ones({2,3},np.float64);local b=np.ones({3,2},np.float64);local o=np.zeros({2,2},np.float32);local ok,e=pcall(function() np.dot(a,b,{out=o}) end);assert(not ok and tostring(e):find("output array is not acceptable",1,true),"dot strict out dtype") end
do local a=np.ones({2,3},np.float64);local b=np.ones({3,2},np.float64);local ob=np.zeros({2,2},np.float64);local o=ob.T;local ok,e=pcall(function() np.dot(a,b,{out=o}) end);assert(not ok and tostring(e):find("output array is not acceptable",1,true),"dot strict out contiguous") end
do local s=np.reshape(np.array({2},np.int8),{});local a=np.reshape(np.arange(6,np.int8),{2,3});local ob=np.zeros({3,2},np.float64);local o=ob.T;local r=np.dot(s,a,{out=o});assert(r==o and close(r:tolist(),{{0,2,4},{6,8,10}}),"dot scalar ufunc out") end
print('dot/inner/outer differential: 486 cases ok')
