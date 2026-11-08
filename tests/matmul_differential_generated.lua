local np=require("luaray_core")
local function close(a,b)
  if type(a)~=type(b) then return false end
  if type(a)~="table" then
    if type(a)=="number" then
      if a~=a and b~=b then return true end
      if a==b then return true end
      return math.abs(a-b)<=math.max(5e-5,math.abs(b)*2e-5)
    end
    return a==b
  end
  if #a~=#b then return false end
  for i=1,#a do if not close(a[i],b[i]) then return false end end
  return true
end
-- Generated against development NumPy 2.3.5.
do -- matmul 0: uint16[4] @ int16[4, 3]
  local a=np.array({1,4,2,0},np.uint16)
  local b=np.array({{-2,3,-1},{4,0,-4},{1,-3,2},{-2,3,-1}},np.int16)
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 0 dtype "..r.dtype)
  assert(close(r.shape,{3}),"matmul 0 shape")
  assert(close(r.strides,{4}),"matmul 0 strides")
  assert(close(r:tolist(),{16,-3,-13}),"matmul 0 values")
end
do -- matmul 1: float16[1, 3] @ int64[3, 0]
  local a=(np.array({{-0.25},{0.5},{-1.0}},np.float16)).T
  local b=np.zeros({3,0},np.int64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 1 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"matmul 1 shape")
  assert(close(r.strides,{0,0}),"matmul 1 strides")
  assert(close(r:tolist(),{{}}),"matmul 1 values")
end
do -- matmul 2: float32[4, 2] @ uint64[1, 2, 1]
  local a=np.array({{0.25,1.0},{-0.5,0.25},{1.0,-0.5},{0.25,1.0}},np.float32)
  local b=np.array({{{1},{4}}},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 2 dtype "..r.dtype)
  assert(close(r.shape,{1,4,1}),"matmul 2 shape")
  assert(close(r.strides,{32,8,8}),"matmul 2 strides")
  assert(close(r:tolist(),{{{4.25},{0.5},{-1.0},{4.25}}}),"matmul 2 values")
end
do -- matmul 3: uint16[4, 2] @ int8[2, 2]
  local a=np.array({{2,0},{3,1},{4,2},{0,3}},np.uint16)
  local b=np.array({{4,0},{-4,1}},np.int8)
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 3 dtype "..r.dtype)
  assert(close(r.shape,{4,2}),"matmul 3 shape")
  assert(close(r.strides,{8,4}),"matmul 3 strides")
  assert(close(r:tolist(),{{8,0},{8,1},{8,2},{-12,3}}),"matmul 3 values")
end
do -- matmul 4: float16[1, 0, 3] @ uint64[3, 3]
  local a=np.zeros({1,0,3},np.float16)
  local b=np.array({{0,3,1},{4,2,0},{3,1,4}},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 4 dtype "..r.dtype)
  assert(close(r.shape,{1,0,3}),"matmul 4 shape")
  assert(close(r.strides,{0,0,0}),"matmul 4 strides")
  assert(close(r:tolist(),{{}}),"matmul 4 values")
end
do -- matmul 5: uint64[2, 2] @ int32[1, 2, 3]
  local a=(np.array({{1,4},{2,0}},np.uint64)).T
  local b=np.array({{{-1,4,0},{-4,1,-3}}},np.int32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 5 dtype "..r.dtype)
  assert(close(r.shape,{1,2,3}),"matmul 5 shape")
  assert(close(r.strides,{48,24,8}),"matmul 5 strides")
  assert(close(r:tolist(),{{{-9.0,6.0,-6.0},{-4.0,16.0,0.0}}}),"matmul 5 values")
end
do -- matmul 6: uint64[3] @ int32[3, 1]
  local a=np.array({3,1,4},np.uint64)
  local b=(np.array({{1,-3,2}},np.int32)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 6 dtype "..r.dtype)
  assert(close(r.shape,{1}),"matmul 6 shape")
  assert(close(r.strides,{8}),"matmul 6 strides")
  assert(close(r:tolist(),{8.0}),"matmul 6 values")
end
do -- matmul 7: int64[1, 2] @ int64[2]
  local a=np.array({{2,-2}},np.int64)
  local b=np.array({3,-1},np.int64)
  local r=np.matmul(a,b)
  assert(r.dtype=="int64","matmul 7 dtype "..r.dtype)
  assert(close(r.shape,{1}),"matmul 7 shape")
  assert(close(r.strides,{8}),"matmul 7 strides")
  assert(close(r:tolist(),{8}),"matmul 7 values")
end
do -- matmul 8: uint16[0, 3, 4] @ int64[4]
  local a=np.zeros({0,3,4},np.uint16)
  local b=np.array({-4,1,-3,2},np.int64)
  local o=np.zeros({0,3},np.int64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 8 out identity")
  assert(r.dtype=="int64","matmul 8 dtype "..r.dtype)
  assert(close(r.shape,{0,3}),"matmul 8 shape")
  assert(close(r.strides,{0,0}),"matmul 8 out strides")
  assert(close(r:tolist(),{}),"matmul 8 values")
end
do -- matmul 9: float64[1] @ uint32[3, 1, 4]
  local a=np.array({-0.75},np.float64)
  local b=np.array({{{0,3,1,4}},{{2,0,3,1}},{{4,2,0,3}}},np.uint32)
  local o=np.zeros({3,4},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 9 out identity")
  assert(r.dtype=="float64","matmul 9 dtype "..r.dtype)
  assert(close(r.shape,{3,4}),"matmul 9 shape")
  assert(close(r.strides,{32,8}),"matmul 9 out strides")
  assert(close(r:tolist(),{{0.0,-2.25,-0.75,-3.0},{-1.5,0.0,-2.25,-0.75},{-3.0,-1.5,0.0,-2.25}}),"matmul 9 values")
end
do -- matmul 10: uint64[3, 2] @ bool[2, 0]
  local a=np.array({{1,4},{2,0},{3,1}},np.uint64)
  local b=np.zeros({2,0},np.bool)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint64","matmul 10 dtype "..r.dtype)
  assert(close(r.shape,{3,0}),"matmul 10 shape")
  assert(close(r.strides,{0,0}),"matmul 10 strides")
  assert(close(r:tolist(),{{},{},{}}),"matmul 10 values")
end
do -- matmul 11: float32[1, 1, 0, 3] @ int32[3]
  local a=(np.zeros({3,0,1,1},np.float32)).T
  local b=np.array({2,-2,3},np.int32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 11 dtype "..r.dtype)
  assert(close(r.shape,{1,1,0}),"matmul 11 shape")
  assert(close(r.strides,{0,0,0}),"matmul 11 strides")
  assert(close(r:tolist(),{{{}}}),"matmul 11 values")
end
do -- matmul 12: uint32[2, 1, 0, 3] @ uint8[3, 4]
  local a=np.zeros({2,1,0,3},np.uint32)
  local b=np.array({{1,4,2,0},{3,1,4,2},{0,3,1,4}},np.uint8)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint32","matmul 12 dtype "..r.dtype)
  assert(close(r.shape,{2,1,0,4}),"matmul 12 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 12 strides")
  assert(close(r:tolist(),{{{}},{{}}}),"matmul 12 values")
end
do -- matmul 13: int64[1, 1, 3, 3] @ bool[3, 2, 3, 3]
  local a=np.array({{{{-4,1,-3},{2,-2,3},{-1,4,0}}}},np.int64)
  local b=np.array({{{{true,true,false},{true,true,false},{true,true,false}},{{true,true,false},{true,true,false},{true,true,false}}},{{{true,true,false},{true,true,false},{true,true,false}},{{true,true,false},{true,true,false},{true,true,false}}},{{{true,true,false},{true,true,false},{true,true,false}},{{true,true,false},{true,true,false},{true,true,false}}}},np.bool)
  local o=np.zeros({3,2,3,3},np.int64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 13 out identity")
  assert(r.dtype=="int64","matmul 13 dtype "..r.dtype)
  assert(close(r.shape,{3,2,3,3}),"matmul 13 shape")
  assert(close(r.strides,{144,72,24,8}),"matmul 13 out strides")
  assert(close(r:tolist(),{{{{-6,-6,0},{3,3,0},{3,3,0}},{{-6,-6,0},{3,3,0},{3,3,0}}},{{{-6,-6,0},{3,3,0},{3,3,0}},{{-6,-6,0},{3,3,0},{3,3,0}}},{{{-6,-6,0},{3,3,0},{3,3,0}},{{-6,-6,0},{3,3,0},{3,3,0}}}}),"matmul 13 values")
end
do -- matmul 14: uint8[2, 1, 4] @ float16[4]
  local a=(np.array({{{4,2}},{{0,3}},{{1,4}},{{2,0}}},np.uint8)).T
  local b=np.array({-0.25,0.5,-1.0,-0.25},np.float16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float16","matmul 14 dtype "..r.dtype)
  assert(close(r.shape,{2,1}),"matmul 14 shape")
  assert(close(r.strides,{2,2}),"matmul 14 strides")
  assert(close(r:tolist(),{{-2.5},{-3.0}}),"matmul 14 values")
end
do -- matmul 15: int32[0] @ float16[0]
  local a=np.zeros({0},np.int32)
  local b=np.zeros({0},np.float16)
  local r=np.matmul(a,b)
  assert(close(r,0.0),"matmul 15 scalar value")
end
do -- matmul 16: float16[2, 3, 1] @ uint16[0, 2, 1, 4]
  local a=np.array({{{0.5},{-1.0},{-0.25}},{{0.5},{-1.0},{-0.25}}},np.float16)
  local b=np.zeros({0,2,1,4},np.uint16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 16 dtype "..r.dtype)
  assert(close(r.shape,{0,2,3,4}),"matmul 16 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 16 strides")
  assert(close(r:tolist(),{}),"matmul 16 values")
end
do -- matmul 17: uint64[1, 1, 0, 3] @ uint16[3]
  local a=np.zeros({1,1,0,3},np.uint64)
  local b=np.array({1,4,2},np.uint16)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint64","matmul 17 dtype "..r.dtype)
  assert(close(r.shape,{1,1,0}),"matmul 17 shape")
  assert(close(r.strides,{0,0,0}),"matmul 17 strides")
  assert(close(r:tolist(),{{{}}}),"matmul 17 values")
end
do -- matmul 18: float64[0, 2] @ int64[2, 4]
  local a=np.zeros({0,2},np.float64)
  local b=np.array({{-2,3,-1,4},{0,-4,1,-3}},np.int64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 18 dtype "..r.dtype)
  assert(close(r.shape,{0,4}),"matmul 18 shape")
  assert(close(r.strides,{0,0}),"matmul 18 strides")
  assert(close(r:tolist(),{}),"matmul 18 values")
end
do -- matmul 19: int8[0, 2, 3] @ uint64[3, 4]
  local a=np.zeros({0,2,3},np.int8)
  local b=np.array({{0,3,1,4},{2,0,3,1},{4,2,0,3}},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 19 dtype "..r.dtype)
  assert(close(r.shape,{0,2,4}),"matmul 19 shape")
  assert(close(r.strides,{0,0,0}),"matmul 19 strides")
  assert(close(r:tolist(),{}),"matmul 19 values")
end
do -- matmul 20: uint64[3, 1] @ int16[1, 1]
  local a=np.array({{1},{4},{2}},np.uint64)
  local b=(np.array({{2}},np.int16)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 20 dtype "..r.dtype)
  assert(close(r.shape,{3,1}),"matmul 20 shape")
  assert(close(r.strides,{8,8}),"matmul 20 strides")
  assert(close(r:tolist(),{{2.0},{8.0},{4.0}}),"matmul 20 values")
end
do -- matmul 21: uint64[1, 2, 2] @ int8[2]
  local a=np.array({{{3,1},{4,2}}},np.uint64)
  local b=np.array({4,0},np.int8)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 21 dtype "..r.dtype)
  assert(close(r.shape,{1,2}),"matmul 21 shape")
  assert(close(r.strides,{16,8}),"matmul 21 strides")
  assert(close(r:tolist(),{{12.0,16.0}}),"matmul 21 values")
end
do -- matmul 22: float16[2, 4] @ uint16[2, 4, 2]
  local a=np.array({{-1.0,-0.25,0.5,-1.0},{-0.25,0.5,-1.0,-0.25}},np.float16)
  local b=np.array({{{1,4},{2,0},{3,1},{4,2}},{{0,3},{1,4},{2,0},{3,1}}},np.uint16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 22 dtype "..r.dtype)
  assert(close(r.shape,{2,2,2}),"matmul 22 shape")
  assert(close(r.strides,{16,8,4}),"matmul 22 strides")
  assert(close(r:tolist(),{{{-4.0,-5.5},{-3.25,-2.5}},{{-2.25,-5.0},{-2.25,1.0}}}),"matmul 22 values")
end
do -- matmul 23: uint64[4] @ uint8[3, 4, 2]
  local a=np.array({2,0,3,1},np.uint64)
  local b=np.array({{{3,1},{4,2},{0,3},{1,4}},{{2,0},{3,1},{4,2},{0,3}},{{1,4},{2,0},{3,1},{4,2}}},np.uint8)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint64","matmul 23 dtype "..r.dtype)
  assert(close(r.shape,{3,2}),"matmul 23 shape")
  assert(close(r.strides,{16,8}),"matmul 23 strides")
  assert(close(r:tolist(),{{7,15},{16,9},{15,13}}),"matmul 23 values")
end
do -- matmul 24: uint32[0, 0, 1, 2] @ int64[0, 2, 0]
  local a=np.zeros({0,0,1,2},np.uint32)
  local b=np.zeros({0,2,0},np.int64)
  local r=np.matmul(a,b)
  assert(r.dtype=="int64","matmul 24 dtype "..r.dtype)
  assert(close(r.shape,{0,0,1,0}),"matmul 24 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 24 strides")
  assert(close(r:tolist(),{}),"matmul 24 values")
end
do -- matmul 25: uint32[2, 0] @ uint16[0]
  local a=np.zeros({2,0},np.uint32)
  local b=np.zeros({0},np.uint16)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint32","matmul 25 dtype "..r.dtype)
  assert(close(r.shape,{2}),"matmul 25 shape")
  assert(close(r.strides,{4}),"matmul 25 strides")
  assert(close(r:tolist(),{0,0}),"matmul 25 values")
end
do -- matmul 26: int8[2, 1] @ uint16[1]
  local a=np.array({{4},{0}},np.int8)
  local b=np.array({4},np.uint16)
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 26 dtype "..r.dtype)
  assert(close(r.shape,{2}),"matmul 26 shape")
  assert(close(r.strides,{4}),"matmul 26 strides")
  assert(close(r:tolist(),{16,0}),"matmul 26 values")
end
do -- matmul 27: uint8[4, 0] @ uint32[0, 0]
  local a=np.zeros({4,0},np.uint8)
  local b=(np.zeros({0,0},np.uint32)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="uint32","matmul 27 dtype "..r.dtype)
  assert(close(r.shape,{4,0}),"matmul 27 shape")
  assert(close(r.strides,{0,0}),"matmul 27 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"matmul 27 values")
end
do -- matmul 28: float32[1, 2, 3, 1, 3] @ float64[0, 2, 3, 3, 0]
  local a=np.array({{{{{-0.25,0.5,-1.0}},{{-0.25,0.5,-1.0}},{{-0.25,0.5,-1.0}}},{{{-0.25,0.5,-1.0}},{{-0.25,0.5,-1.0}},{{-0.25,0.5,-1.0}}}}},np.float32)
  local b=np.zeros({0,2,3,3,0},np.float64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 28 dtype "..r.dtype)
  assert(close(r.shape,{0,2,3,1,0}),"matmul 28 shape")
  assert(close(r.strides,{0,0,0,0,0}),"matmul 28 strides")
  assert(close(r:tolist(),{}),"matmul 28 values")
end
do -- matmul 29: float32[3, 1] @ bool[1, 2]
  local a=np.array({{0.25},{1.0},{-0.5}},np.float32)
  local b=(np.array({{false},{true}},np.bool)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 29 dtype "..r.dtype)
  assert(close(r.shape,{3,2}),"matmul 29 shape")
  assert(close(r.strides,{8,4}),"matmul 29 strides")
  assert(close(r:tolist(),{{0.0,0.25},{0.0,1.0},{0.0,-0.5}}),"matmul 29 values")
end
do -- matmul 30: int64[3] @ float64[3, 4]
  local a=np.array({3,-1,4},np.int64)
  local b=(np.array({{1.0,-0.5,0.25},{1.0,-0.5,0.25},{1.0,-0.5,0.25},{1.0,-0.5,0.25}},np.float64)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 30 dtype "..r.dtype)
  assert(close(r.shape,{4}),"matmul 30 shape")
  assert(close(r.strides,{8}),"matmul 30 strides")
  assert(close(r:tolist(),{4.5,4.5,4.5,4.5}),"matmul 30 values")
end
do -- matmul 31: int8[2, 3, 4] @ float64[1, 2, 2, 4, 1]
  local a=np.array({{{-4,1,-3,2},{-2,3,-1,4},{0,-4,1,-3}},{{2,-2,3,-1},{4,0,-4,1},{-3,2,-2,3}}},np.int8)
  local b=np.array({{{{{-0.75},{0.0},{0.75},{-0.75}},{{0.0},{0.75},{-0.75},{0.0}}},{{{0.75},{-0.75},{0.0},{0.75}},{{-0.75},{0.0},{0.75},{-0.75}}}}},np.float64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 31 dtype "..r.dtype)
  assert(close(r.shape,{1,2,2,3,1}),"matmul 31 shape")
  assert(close(r.strides,{96,48,24,8,8}),"matmul 31 strides")
  assert(close(r:tolist(),{{{{{-0.75},{-2.25},{3.0}},{{-3.75},{3.0},{3.0}}},{{{-2.25},{-0.75},{0.75}},{{1.5},{-6.75},{-1.5}}}}}),"matmul 31 values")
end
do -- matmul 32: uint16[3, 3] @ uint8[1, 3, 1]
  local a=np.array({{0,3,1},{4,2,0},{3,1,4}},np.uint16)
  local b=np.array({{{1},{4},{2}}},np.uint8)
  local ob=np.zeros({1,3,1},np.uint16)
  local o=ob.T
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 32 out identity")
  assert(r.dtype=="uint16","matmul 32 dtype "..r.dtype)
  assert(close(r.shape,{1,3,1}),"matmul 32 shape")
  assert(close(r.strides,{2,2,6}),"matmul 32 out strides")
  assert(close(r:tolist(),{{{14},{12},{15}}}),"matmul 32 values")
end
do -- matmul 33: float64[1] @ bool[1, 0]
  local a=np.array({0.0},np.float64)
  local b=np.zeros({1,0},np.bool)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 33 dtype "..r.dtype)
  assert(close(r.shape,{0}),"matmul 33 shape")
  assert(close(r.strides,{0}),"matmul 33 strides")
  assert(close(r:tolist(),{}),"matmul 33 values")
end
do -- matmul 34: uint8[3, 4, 1] @ int64[1, 0]
  local a=np.array({{{4},{2},{0},{3}},{{1},{4},{2},{0}},{{3},{1},{4},{2}}},np.uint8)
  local b=np.zeros({1,0},np.int64)
  local r=np.matmul(a,b)
  assert(r.dtype=="int64","matmul 34 dtype "..r.dtype)
  assert(close(r.shape,{3,4,0}),"matmul 34 shape")
  assert(close(r.strides,{0,0,0}),"matmul 34 strides")
  assert(close(r:tolist(),{{{},{},{},{}},{{},{},{},{}},{{},{},{},{}}}),"matmul 34 values")
end
do -- matmul 35: uint8[1, 4, 2] @ uint64[2]
  local a=np.array({{{1,4},{2,0},{3,1},{4,2}}},np.uint8)
  local b=np.array({2,0},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint64","matmul 35 dtype "..r.dtype)
  assert(close(r.shape,{1,4}),"matmul 35 shape")
  assert(close(r.strides,{32,8}),"matmul 35 strides")
  assert(close(r:tolist(),{{2,4,6,8}}),"matmul 35 values")
end
do -- matmul 36: int32[3, 2, 1] @ int16[1]
  local a=np.array({{{-3},{2}},{{-2},{3}},{{-1},{4}}},np.int32)
  local b=np.array({-2},np.int16)
  local ob=np.zeros({2,3},np.int32)
  local o=ob.T
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 36 out identity")
  assert(r.dtype=="int32","matmul 36 dtype "..r.dtype)
  assert(close(r.shape,{3,2}),"matmul 36 shape")
  assert(close(r.strides,{4,12}),"matmul 36 out strides")
  assert(close(r:tolist(),{{6,-4},{4,-6},{2,-8}}),"matmul 36 values")
end
do -- matmul 37: uint8[1, 3] @ uint16[3, 3, 1]
  local a=np.array({{0,3,1}},np.uint8)
  local b=np.array({{{1},{4},{2}},{{0},{3},{1}},{{4},{2},{0}}},np.uint16)
  local o=np.zeros({3,1,1},np.uint16)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 37 out identity")
  assert(r.dtype=="uint16","matmul 37 dtype "..r.dtype)
  assert(close(r.shape,{3,1,1}),"matmul 37 shape")
  assert(close(r.strides,{2,2,2}),"matmul 37 out strides")
  assert(close(r:tolist(),{{{14}},{{10}},{{6}}}),"matmul 37 values")
end
do -- matmul 38: uint8[3, 2] @ int16[3, 2, 2, 3]
  local a=np.array({{2,0},{3,1},{4,2}},np.uint8)
  local b=(np.array({{{{2,-2,3},{-1,4,0}},{{-4,1,-3},{2,-2,3}}},{{{-1,4,0},{-4,1,-3}},{{2,-2,3},{-1,4,0}}},{{{-4,1,-3},{2,-2,3}},{{-1,4,0},{-4,1,-3}}}},np.int16)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="int16","matmul 38 dtype "..r.dtype)
  assert(close(r.shape,{3,2,3,3}),"matmul 38 shape")
  assert(close(r.strides,{18,54,6,2}),"matmul 38 strides")
  assert(close(r:tolist(),{{{{4,-2,-8},{2,-1,-13},{0,0,-18}},{{-2,-8,4},{-1,-13,2},{0,-18,0}}},{{{-4,8,2},{-5,10,7},{-6,12,12}},{{8,2,-4},{10,7,-5},{12,12,-6}}},{{{6,0,-6},{6,3,-9},{6,6,-12}},{{0,-6,6},{3,-9,6},{6,-12,6}}}}),"matmul 38 values")
end
do -- matmul 39: float32[2, 3] @ uint32[3, 4]
  local a=np.array({{0.75,-0.75,0.0},{0.75,-0.75,0.0}},np.float32)
  local b=np.array({{0,3,1,4},{2,0,3,1},{4,2,0,3}},np.uint32)
  local o=np.zeros({2,4},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 39 out identity")
  assert(r.dtype=="float64","matmul 39 dtype "..r.dtype)
  assert(close(r.shape,{2,4}),"matmul 39 shape")
  assert(close(r.strides,{32,8}),"matmul 39 out strides")
  assert(close(r:tolist(),{{-1.5,2.25,-1.5,2.25},{-1.5,2.25,-1.5,2.25}}),"matmul 39 values")
end
do -- matmul 40: float64[2, 2, 2, 1, 0] @ uint16[2, 0, 4]
  local a=np.zeros({2,2,2,1,0},np.float64)
  local b=np.zeros({2,0,4},np.uint16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 40 dtype "..r.dtype)
  assert(close(r.shape,{2,2,2,1,4}),"matmul 40 shape")
  assert(close(r.strides,{128,64,32,32,8}),"matmul 40 strides")
  assert(close(r:tolist(),{{{{{0.0,0.0,0.0,0.0}},{{0.0,0.0,0.0,0.0}}},{{{0.0,0.0,0.0,0.0}},{{0.0,0.0,0.0,0.0}}}},{{{{0.0,0.0,0.0,0.0}},{{0.0,0.0,0.0,0.0}}},{{{0.0,0.0,0.0,0.0}},{{0.0,0.0,0.0,0.0}}}}}),"matmul 40 values")
end
do -- matmul 41: uint64[1, 3, 3] @ uint64[2, 3, 0]
  local a=np.array({{{3,1,4},{2,0,3},{1,4,2}}},np.uint64)
  local b=np.zeros({2,3,0},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint64","matmul 41 dtype "..r.dtype)
  assert(close(r.shape,{2,3,0}),"matmul 41 shape")
  assert(close(r.strides,{0,0,0}),"matmul 41 strides")
  assert(close(r:tolist(),{{{},{},{}},{{},{},{}}}),"matmul 41 values")
end
do -- matmul 42: uint32[1, 1, 0] @ float16[0, 4]
  local a=np.zeros({1,1,0},np.uint32)
  local b=np.zeros({0,4},np.float16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 42 dtype "..r.dtype)
  assert(close(r.shape,{1,1,4}),"matmul 42 shape")
  assert(close(r.strides,{32,32,8}),"matmul 42 strides")
  assert(close(r:tolist(),{{{0.0,0.0,0.0,0.0}}}),"matmul 42 values")
end
do -- matmul 43: int16[1, 1] @ uint8[1, 0]
  local a=(np.array({{2}},np.int16)).T
  local b=np.zeros({1,0},np.uint8)
  local o=np.zeros({1,0},np.int16)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 43 out identity")
  assert(r.dtype=="int16","matmul 43 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"matmul 43 shape")
  assert(close(r.strides,{0,0}),"matmul 43 out strides")
  assert(close(r:tolist(),{{}}),"matmul 43 values")
end
do -- matmul 44: uint8[4] @ int64[2, 4, 0]
  local a=np.array({4,2,0,3},np.uint8)
  local b=np.zeros({2,4,0},np.int64)
  local o=np.zeros({2,0},np.int64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 44 out identity")
  assert(r.dtype=="int64","matmul 44 dtype "..r.dtype)
  assert(close(r.shape,{2,0}),"matmul 44 shape")
  assert(close(r.strides,{0,0}),"matmul 44 out strides")
  assert(close(r:tolist(),{{},{}}),"matmul 44 values")
end
do -- matmul 45: uint64[2] @ float32[1, 1, 1, 2, 0]
  local a=np.array({1,4},np.uint64)
  local b=np.zeros({1,1,1,2,0},np.float32)
  local ob=np.zeros({0,1,1,1},np.float64)
  local o=ob.T
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 45 out identity")
  assert(r.dtype=="float64","matmul 45 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,0}),"matmul 45 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 45 out strides")
  assert(close(r:tolist(),{{{{}}}}),"matmul 45 values")
end
do -- matmul 46: int64[3, 4] @ int64[4, 1]
  local a=np.array({{-1,4,0,-4},{1,-3,2,-2},{3,-1,4,0}},np.int64)
  local b=np.array({{0},{-4},{1},{-3}},np.int64)
  local r=np.matmul(a,b)
  assert(r.dtype=="int64","matmul 46 dtype "..r.dtype)
  assert(close(r.shape,{3,1}),"matmul 46 shape")
  assert(close(r.strides,{8,8}),"matmul 46 strides")
  assert(close(r:tolist(),{{-4},{20},{8}}),"matmul 46 values")
end
do -- matmul 47: bool[0, 3] @ uint64[3]
  local a=np.zeros({0,3},np.bool)
  local b=np.array({1,4,2},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint64","matmul 47 dtype "..r.dtype)
  assert(close(r.shape,{0}),"matmul 47 shape")
  assert(close(r.strides,{0}),"matmul 47 strides")
  assert(close(r:tolist(),{}),"matmul 47 values")
end
do -- matmul 48: bool[1, 1, 2, 3, 2] @ uint64[2, 2]
  local a=np.array({{{{{true,true},{false,true},{true,false}},{{true,true},{false,true},{true,false}}}}},np.bool)
  local b=np.array({{3,1},{4,2}},np.uint64)
  local o=np.zeros({1,1,2,3,2},np.uint64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 48 out identity")
  assert(r.dtype=="uint64","matmul 48 dtype "..r.dtype)
  assert(close(r.shape,{1,1,2,3,2}),"matmul 48 shape")
  assert(close(r.strides,{96,96,48,16,8}),"matmul 48 out strides")
  assert(close(r:tolist(),{{{{{7,3},{4,2},{3,1}},{{7,3},{4,2},{3,1}}}}}),"matmul 48 values")
end
do -- matmul 49: bool[2, 2] @ uint8[2, 1]
  local a=np.array({{false,true},{true,false}},np.bool)
  local b=np.array({{0},{3}},np.uint8)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint8","matmul 49 dtype "..r.dtype)
  assert(close(r.shape,{2,1}),"matmul 49 shape")
  assert(close(r.strides,{1,1}),"matmul 49 strides")
  assert(close(r:tolist(),{{3},{0}}),"matmul 49 values")
end
do -- matmul 50: int8[0] @ uint64[1, 0, 0]
  local a=np.zeros({0},np.int8)
  local b=(np.zeros({0,0,1},np.uint64)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 50 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"matmul 50 shape")
  assert(close(r.strides,{0,0}),"matmul 50 strides")
  assert(close(r:tolist(),{{}}),"matmul 50 values")
end
do -- matmul 51: float16[1, 3, 4] @ int8[3, 4, 0]
  local a=np.array({{{0.0,0.75,-0.75,0.0},{0.75,-0.75,0.0,0.75},{-0.75,0.0,0.75,-0.75}}},np.float16)
  local b=np.zeros({3,4,0},np.int8)
  local r=np.matmul(a,b)
  assert(r.dtype=="float16","matmul 51 dtype "..r.dtype)
  assert(close(r.shape,{3,3,0}),"matmul 51 shape")
  assert(close(r.strides,{0,0,0}),"matmul 51 strides")
  assert(close(r:tolist(),{{{},{},{}},{{},{},{}},{{},{},{}}}),"matmul 51 values")
end
do -- matmul 52: int8[1, 1, 2, 4] @ bool[4]
  local a=np.array({{{{2,-2,3,-1},{4,0,-4,1}}}},np.int8)
  local b=np.array({true,true,false,true},np.bool)
  local r=np.matmul(a,b)
  assert(r.dtype=="int8","matmul 52 dtype "..r.dtype)
  assert(close(r.shape,{1,1,2}),"matmul 52 shape")
  assert(close(r.strides,{2,2,1}),"matmul 52 strides")
  assert(close(r:tolist(),{{{-1,5}}}),"matmul 52 values")
end
do -- matmul 53: int16[1] @ float32[1, 4]
  local a=np.array({4},np.int16)
  local b=np.array({{-1.0,-0.25,0.5,-1.0}},np.float32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 53 dtype "..r.dtype)
  assert(close(r.shape,{4}),"matmul 53 shape")
  assert(close(r.strides,{4}),"matmul 53 strides")
  assert(close(r:tolist(),{-4.0,-1.0,2.0,-4.0}),"matmul 53 values")
end
do -- matmul 54: float64[0, 1] @ int32[1]
  local a=np.zeros({0,1},np.float64)
  local b=np.array({-2},np.int32)
  local o=np.zeros({0},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 54 out identity")
  assert(r.dtype=="float64","matmul 54 dtype "..r.dtype)
  assert(close(r.shape,{0}),"matmul 54 shape")
  assert(close(r.strides,{0}),"matmul 54 out strides")
  assert(close(r:tolist(),{}),"matmul 54 values")
end
do -- matmul 55: float64[4, 4] @ int64[3, 4, 2]
  local a=np.array({{-0.25,0.5,-1.0,-0.25},{0.5,-1.0,-0.25,0.5},{-1.0,-0.25,0.5,-1.0},{-0.25,0.5,-1.0,-0.25}},np.float64)
  local b=np.array({{{0,-4},{1,-3},{2,-2},{3,-1}},{{4,0},{-4,1},{-3,2},{-2,3}},{{-1,4},{0,-4},{1,-3},{2,-2}}},np.int64)
  local o=np.zeros({3,4,2},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 55 out identity")
  assert(r.dtype=="float64","matmul 55 dtype "..r.dtype)
  assert(close(r.shape,{3,4,2}),"matmul 55 shape")
  assert(close(r.strides,{64,16,8}),"matmul 55 out strides")
  assert(close(r:tolist(),{{{-2.25,1.75},{0.0,1.0},{-2.25,4.75},{-2.25,1.75}},{{0.5,-2.25},{5.75,0.0},{-2.5,-2.25},{0.5,-2.25}},{{-1.25,0.5},{0.25,5.75},{-0.5,-2.5},{-1.25,0.5}}}),"matmul 55 values")
end
do -- matmul 56: uint32[2, 1, 3] @ bool[3]
  local a=np.array({{{3,1,4}},{{2,0,3}}},np.uint32)
  local b=np.array({false,true,true},np.bool)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint32","matmul 56 dtype "..r.dtype)
  assert(close(r.shape,{2,1}),"matmul 56 shape")
  assert(close(r.strides,{4,4}),"matmul 56 strides")
  assert(close(r:tolist(),{{5},{3}}),"matmul 56 values")
end
do -- matmul 57: float16[1, 1, 4, 4] @ int8[4, 2]
  local a=np.array({{{{0.75,-0.75,0.0,0.75},{-0.75,0.0,0.75,-0.75},{0.0,0.75,-0.75,0.0},{0.75,-0.75,0.0,0.75}}}},np.float16)
  local b=np.array({{4,0},{-4,1},{-3,2},{-2,3}},np.int8)
  local o=np.zeros({1,1,4,2},np.float16)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 57 out identity")
  assert(r.dtype=="float16","matmul 57 dtype "..r.dtype)
  assert(close(r.shape,{1,1,4,2}),"matmul 57 shape")
  assert(close(r.strides,{16,16,4,2}),"matmul 57 out strides")
  assert(close(r:tolist(),{{{{4.5,1.5},{-3.75,-0.75},{-0.75,-0.75},{4.5,1.5}}}}),"matmul 57 values")
end
do -- matmul 58: uint64[4, 1] @ uint8[1, 4]
  local a=np.array({{2},{0},{3},{1}},np.uint64)
  local b=np.array({{3,1,4,2}},np.uint8)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint64","matmul 58 dtype "..r.dtype)
  assert(close(r.shape,{4,4}),"matmul 58 shape")
  assert(close(r.strides,{32,8}),"matmul 58 strides")
  assert(close(r:tolist(),{{6,2,8,4},{0,0,0,0},{9,3,12,6},{3,1,4,2}}),"matmul 58 values")
end
do -- matmul 59: uint64[1, 1, 2, 2, 2] @ float32[2, 2, 2, 3]
  local a=np.array({{{{{4,2},{0,3}},{{1,4},{2,0}}}}},np.uint64)
  local b=np.array({{{{-0.25,0.5,-1.0},{-0.25,0.5,-1.0}},{{-0.25,0.5,-1.0},{-0.25,0.5,-1.0}}},{{{-0.25,0.5,-1.0},{-0.25,0.5,-1.0}},{{-0.25,0.5,-1.0},{-0.25,0.5,-1.0}}}},np.float32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 59 dtype "..r.dtype)
  assert(close(r.shape,{1,2,2,2,3}),"matmul 59 shape")
  assert(close(r.strides,{192,96,48,24,8}),"matmul 59 strides")
  assert(close(r:tolist(),{{{{{-1.5,3.0,-6.0},{-0.75,1.5,-3.0}},{{-1.25,2.5,-5.0},{-0.5,1.0,-2.0}}},{{{-1.5,3.0,-6.0},{-0.75,1.5,-3.0}},{{-1.25,2.5,-5.0},{-0.5,1.0,-2.0}}}}}),"matmul 59 values")
end
do -- matmul 60: float16[2, 2, 0, 2] @ uint8[2, 2]
  local a=np.zeros({2,2,0,2},np.float16)
  local b=np.array({{2,0},{3,1}},np.uint8)
  local r=np.matmul(a,b)
  assert(r.dtype=="float16","matmul 60 dtype "..r.dtype)
  assert(close(r.shape,{2,2,0,2}),"matmul 60 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 60 strides")
  assert(close(r:tolist(),{{{},{}},{{},{}}}),"matmul 60 values")
end
do -- matmul 61: int64[3] @ int64[3, 0, 1, 3, 1]
  local a=np.array({2,-2,3},np.int64)
  local b=(np.zeros({1,3,1,0,3},np.int64)).T
  local o=np.zeros({3,0,1,1},np.int64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 61 out identity")
  assert(r.dtype=="int64","matmul 61 dtype "..r.dtype)
  assert(close(r.shape,{3,0,1,1}),"matmul 61 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 61 out strides")
  assert(close(r:tolist(),{{},{},{}}),"matmul 61 values")
end
do -- matmul 62: int64[1, 1, 3, 2, 2] @ int32[1, 3, 2, 0]
  local a=(np.array({{{{{4}},{{0}},{{-4}}},{{{1}},{{-3}},{{2}}}},{{{{-2}},{{3}},{{-1}}},{{{4}},{{0}},{{-4}}}}},np.int64)).T
  local b=np.zeros({1,3,2,0},np.int32)
  local r=np.matmul(a,b)
  assert(r.dtype=="int64","matmul 62 dtype "..r.dtype)
  assert(close(r.shape,{1,1,3,2,0}),"matmul 62 shape")
  assert(close(r.strides,{0,0,0,0,0}),"matmul 62 strides")
  assert(close(r:tolist(),{{{{{},{}},{{},{}},{{},{}}}}}),"matmul 62 values")
end
do -- matmul 63: float16[3, 2] @ uint64[2]
  local a=np.array({{-0.75,0.0},{0.75,-0.75},{0.0,0.75}},np.float16)
  local b=np.array({3,1},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 63 dtype "..r.dtype)
  assert(close(r.shape,{3}),"matmul 63 shape")
  assert(close(r.strides,{8}),"matmul 63 strides")
  assert(close(r:tolist(),{-2.25,1.5,0.75}),"matmul 63 values")
end
do -- matmul 64: uint16[3, 0] @ float32[0, 3, 0, 4]
  local a=np.zeros({3,0},np.uint16)
  local b=np.zeros({0,3,0,4},np.float32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 64 dtype "..r.dtype)
  assert(close(r.shape,{0,3,3,4}),"matmul 64 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 64 strides")
  assert(close(r:tolist(),{}),"matmul 64 values")
end
do -- matmul 65: bool[4] @ float64[4]
  local a=np.array({true,false,true,true},np.bool)
  local b=np.array({0.5,-1.0,-0.25,0.5},np.float64)
  local r=np.matmul(a,b)
  assert(close(r,0.75),"matmul 65 scalar value")
end
do -- matmul 66: bool[1, 3, 0, 0] @ uint64[3, 0, 4]
  local a=np.zeros({1,3,0,0},np.bool)
  local b=np.zeros({3,0,4},np.uint64)
  local o=np.zeros({1,3,0,4},np.uint64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 66 out identity")
  assert(r.dtype=="uint64","matmul 66 dtype "..r.dtype)
  assert(close(r.shape,{1,3,0,4}),"matmul 66 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 66 out strides")
  assert(close(r:tolist(),{{{},{},{}}}),"matmul 66 values")
end
do -- matmul 67: bool[1] @ int8[1]
  local a=np.array({false},np.bool)
  local b=np.array({-3},np.int8)
  local r=np.matmul(a,b)
  assert(close(r,0),"matmul 67 scalar value")
end
do -- matmul 68: float64[1, 2, 4] @ int64[4, 4]
  local a=np.array({{{-0.5,0.25,1.0,-0.5},{0.25,1.0,-0.5,0.25}}},np.float64)
  local b=np.array({{-1,4,0,-4},{1,-3,2,-2},{3,-1,4,0},{-4,1,-3,2}},np.int64)
  local o=np.zeros({1,2,4},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 68 out identity")
  assert(r.dtype=="float64","matmul 68 dtype "..r.dtype)
  assert(close(r.shape,{1,2,4}),"matmul 68 shape")
  assert(close(r.strides,{64,32,8}),"matmul 68 out strides")
  assert(close(r:tolist(),{{{5.75,-4.25,6.0,0.5},{-1.75,-1.25,-0.75,-2.5}}}),"matmul 68 values")
end
do -- matmul 69: uint32[1] @ float32[1, 1, 3]
  local a=np.array({4},np.uint32)
  local b=np.array({{{0.25,1.0,-0.5}}},np.float32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 69 dtype "..r.dtype)
  assert(close(r.shape,{1,3}),"matmul 69 shape")
  assert(close(r.strides,{24,8}),"matmul 69 strides")
  assert(close(r:tolist(),{{1.0,4.0,-2.0}}),"matmul 69 values")
end
do -- matmul 70: int32[0, 2] @ float64[2, 0]
  local a=np.zeros({0,2},np.int32)
  local b=np.zeros({2,0},np.float64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 70 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"matmul 70 shape")
  assert(close(r.strides,{0,0}),"matmul 70 strides")
  assert(close(r:tolist(),{}),"matmul 70 values")
end
do -- matmul 71: float32[3, 1, 0, 4] @ uint16[1, 1, 4, 4]
  local a=np.zeros({3,1,0,4},np.float32)
  local b=(np.array({{{{4}},{{2}},{{0}},{{3}}},{{{1}},{{4}},{{2}},{{0}}},{{{3}},{{1}},{{4}},{{2}}},{{{0}},{{3}},{{1}},{{4}}}},np.uint16)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 71 dtype "..r.dtype)
  assert(close(r.shape,{3,1,0,4}),"matmul 71 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 71 strides")
  assert(close(r:tolist(),{{{}},{{}},{{}}}),"matmul 71 values")
end
do -- matmul 72: bool[0, 3, 1] @ float16[1, 1]
  local a=np.zeros({0,3,1},np.bool)
  local b=np.array({{-0.5}},np.float16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float16","matmul 72 dtype "..r.dtype)
  assert(close(r.shape,{0,3,1}),"matmul 72 shape")
  assert(close(r.strides,{0,0,0}),"matmul 72 strides")
  assert(close(r:tolist(),{}),"matmul 72 values")
end
do -- matmul 73: int32[4, 3] @ uint64[3, 2]
  local a=np.array({{-1,4,0},{-4,1,-3},{2,-2,3},{-1,4,0}},np.int32)
  local b=np.array({{3,1},{4,2},{0,3}},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 73 dtype "..r.dtype)
  assert(close(r.shape,{4,2}),"matmul 73 shape")
  assert(close(r.strides,{16,8}),"matmul 73 strides")
  assert(close(r:tolist(),{{13.0,7.0},{-8.0,-11.0},{-2.0,7.0},{13.0,7.0}}),"matmul 73 values")
end
do -- matmul 74: uint64[2, 0] @ uint64[0]
  local a=np.zeros({2,0},np.uint64)
  local b=np.zeros({0},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint64","matmul 74 dtype "..r.dtype)
  assert(close(r.shape,{2}),"matmul 74 shape")
  assert(close(r.strides,{8}),"matmul 74 strides")
  assert(close(r:tolist(),{0,0}),"matmul 74 values")
end
do -- matmul 75: int16[2, 1, 1, 3] @ uint8[0, 3, 2]
  local a=(np.array({{{{3,-1}}},{{{4,0}}},{{{-4,1}}}},np.int16)).T
  local b=np.zeros({0,3,2},np.uint8)
  local r=np.matmul(a,b)
  assert(r.dtype=="int16","matmul 75 dtype "..r.dtype)
  assert(close(r.shape,{2,0,1,2}),"matmul 75 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 75 strides")
  assert(close(r:tolist(),{{},{}}),"matmul 75 values")
end
do -- matmul 76: uint8[0] @ bool[0]
  local a=np.zeros({0},np.uint8)
  local b=np.zeros({0},np.bool)
  local o=np.zeros({},np.uint16)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 76 out identity")
  assert(r.dtype=="uint16","matmul 76 dtype "..r.dtype)
  assert(close(r.shape,{}),"matmul 76 shape")
  assert(close(r.strides,{}),"matmul 76 out strides")
  assert(close(r:tolist(),0),"matmul 76 values")
end
do -- matmul 77: int32[2, 3] @ uint16[3, 3]
  local a=np.array({{-2,3,-1},{4,0,-4}},np.int32)
  local b=(np.array({{1,4,2},{0,3,1},{4,2,0}},np.uint16)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 77 dtype "..r.dtype)
  assert(close(r.shape,{2,3}),"matmul 77 shape")
  assert(close(r.strides,{12,4}),"matmul 77 strides")
  assert(close(r:tolist(),{{8,8,-2},{-4,-4,16}}),"matmul 77 values")
end
do -- matmul 78: uint32[4, 3] @ uint32[3, 1]
  local a=np.array({{2,0,3},{1,4,2},{0,3,1},{4,2,0}},np.uint32)
  local b=np.array({{3},{1},{4}},np.uint32)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint32","matmul 78 dtype "..r.dtype)
  assert(close(r.shape,{4,1}),"matmul 78 shape")
  assert(close(r.strides,{4,4}),"matmul 78 strides")
  assert(close(r:tolist(),{{18},{15},{7},{14}}),"matmul 78 values")
end
do -- matmul 79: int64[0, 3] @ uint64[3]
  local a=np.zeros({0,3},np.int64)
  local b=np.array({0,3,1},np.uint64)
  local o=np.zeros({0},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 79 out identity")
  assert(r.dtype=="float64","matmul 79 dtype "..r.dtype)
  assert(close(r.shape,{0}),"matmul 79 shape")
  assert(close(r.strides,{0}),"matmul 79 out strides")
  assert(close(r:tolist(),{}),"matmul 79 values")
end
do -- matmul 80: uint64[3, 1, 2, 2, 2] @ uint8[2, 2, 1]
  local a=np.array({{{{{1,4},{2,0}},{{3,1},{4,2}}}},{{{{0,3},{1,4}},{{2,0},{3,1}}}},{{{{4,2},{0,3}},{{1,4},{2,0}}}}},np.uint64)
  local b=np.array({{{2},{0}},{{3},{1}}},np.uint8)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint64","matmul 80 dtype "..r.dtype)
  assert(close(r.shape,{3,1,2,2,1}),"matmul 80 shape")
  assert(close(r.strides,{32,32,16,8,8}),"matmul 80 strides")
  assert(close(r:tolist(),{{{{{2},{4}},{{10},{14}}}},{{{{0},{2}},{{6},{10}}}},{{{{8},{0}},{{7},{6}}}}}),"matmul 80 values")
end
do -- matmul 81: int8[1] @ int16[1, 4]
  local a=np.array({-3},np.int8)
  local b=np.array({{-2,3,-1,4}},np.int16)
  local r=np.matmul(a,b)
  assert(r.dtype=="int16","matmul 81 dtype "..r.dtype)
  assert(close(r.shape,{4}),"matmul 81 shape")
  assert(close(r.strides,{2}),"matmul 81 strides")
  assert(close(r:tolist(),{6,-9,3,-12}),"matmul 81 values")
end
do -- matmul 82: float16[3, 0] @ uint16[0, 0]
  local a=(np.zeros({0,3},np.float16)).T
  local b=np.zeros({0,0},np.uint16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 82 dtype "..r.dtype)
  assert(close(r.shape,{3,0}),"matmul 82 shape")
  assert(close(r.strides,{0,0}),"matmul 82 strides")
  assert(close(r:tolist(),{{},{},{}}),"matmul 82 values")
end
do -- matmul 83: uint32[2, 4, 3] @ bool[3, 4]
  local a=(np.array({{{2,0},{3,1},{4,2},{0,3}},{{1,4},{2,0},{3,1},{4,2}},{{0,3},{1,4},{2,0},{3,1}}},np.uint32)).T
  local b=(np.array({{false,true,true},{false,true,true},{false,true,true},{false,true,true}},np.bool)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="uint32","matmul 83 dtype "..r.dtype)
  assert(close(r.shape,{2,4,4}),"matmul 83 shape")
  assert(close(r.strides,{64,16,4}),"matmul 83 strides")
  assert(close(r:tolist(),{{{1,1,1,1},{3,3,3,3},{5,5,5,5},{7,7,7,7}},{{7,7,7,7},{4,4,4,4},{1,1,1,1},{3,3,3,3}}}),"matmul 83 values")
end
do -- matmul 84: float16[3] @ uint32[3]
  local a=np.array({0.75,-0.75,0.0},np.float16)
  local b=np.array({0,3,1},np.uint32)
  local r=np.matmul(a,b)
  assert(close(r,-2.25),"matmul 84 scalar value")
end
do -- matmul 85: uint8[0] @ int8[0, 4]
  local a=np.zeros({0},np.uint8)
  local b=np.zeros({0,4},np.int8)
  local r=np.matmul(a,b)
  assert(r.dtype=="int16","matmul 85 dtype "..r.dtype)
  assert(close(r.shape,{4}),"matmul 85 shape")
  assert(close(r.strides,{2}),"matmul 85 strides")
  assert(close(r:tolist(),{0,0,0,0}),"matmul 85 values")
end
do -- matmul 86: float16[4] @ uint16[4, 1]
  local a=np.array({-0.5,0.25,1.0,-0.5},np.float16)
  local b=np.array({{4},{2},{0},{3}},np.uint16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 86 dtype "..r.dtype)
  assert(close(r.shape,{1}),"matmul 86 shape")
  assert(close(r.strides,{4}),"matmul 86 strides")
  assert(close(r:tolist(),{-3.0}),"matmul 86 values")
end
do -- matmul 87: int64[4, 4] @ float64[4, 3]
  local a=np.array({{0,-4,1,-3},{2,-2,3,-1},{4,0,-4,1},{-3,2,-2,3}},np.int64)
  local b=np.array({{0.25,1.0,-0.5},{0.25,1.0,-0.5},{0.25,1.0,-0.5},{0.25,1.0,-0.5}},np.float64)
  local o=np.zeros({4,3},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 87 out identity")
  assert(r.dtype=="float64","matmul 87 dtype "..r.dtype)
  assert(close(r.shape,{4,3}),"matmul 87 shape")
  assert(close(r.strides,{24,8}),"matmul 87 out strides")
  assert(close(r:tolist(),{{-1.5,-6.0,3.0},{0.5,2.0,-1.0},{0.25,1.0,-0.5},{0.0,0.0,0.0}}),"matmul 87 values")
end
do -- matmul 88: int16[1, 1, 3, 4] @ uint32[4]
  local a=np.array({{{{2,-2,3,-1},{4,0,-4,1},{-3,2,-2,3}}}},np.int16)
  local b=np.array({3,1,4,2},np.uint32)
  local r=np.matmul(a,b)
  assert(r.dtype=="int64","matmul 88 dtype "..r.dtype)
  assert(close(r.shape,{1,1,3}),"matmul 88 shape")
  assert(close(r.strides,{24,24,8}),"matmul 88 strides")
  assert(close(r:tolist(),{{{14,-2,-9}}}),"matmul 88 values")
end
do -- matmul 89: uint64[0, 0] @ int8[2, 2, 0, 4]
  local a=np.zeros({0,0},np.uint64)
  local b=np.zeros({2,2,0,4},np.int8)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 89 dtype "..r.dtype)
  assert(close(r.shape,{2,2,0,4}),"matmul 89 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 89 strides")
  assert(close(r:tolist(),{{{},{}},{{},{}}}),"matmul 89 values")
end
do -- matmul 90: uint64[4] @ uint64[4, 0]
  local a=np.array({1,4,2,0},np.uint64)
  local b=np.zeros({4,0},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint64","matmul 90 dtype "..r.dtype)
  assert(close(r.shape,{0}),"matmul 90 shape")
  assert(close(r.strides,{0}),"matmul 90 strides")
  assert(close(r:tolist(),{}),"matmul 90 values")
end
do -- matmul 91: uint32[0, 2] @ int32[2]
  local a=np.zeros({0,2},np.uint32)
  local b=np.array({0,-4},np.int32)
  local r=np.matmul(a,b)
  assert(r.dtype=="int64","matmul 91 dtype "..r.dtype)
  assert(close(r.shape,{0}),"matmul 91 shape")
  assert(close(r.strides,{0}),"matmul 91 strides")
  assert(close(r:tolist(),{}),"matmul 91 values")
end
do -- matmul 92: float64[0, 4] @ int8[4, 0]
  local a=np.zeros({0,4},np.float64)
  local b=np.zeros({4,0},np.int8)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 92 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"matmul 92 shape")
  assert(close(r.strides,{0,0}),"matmul 92 strides")
  assert(close(r:tolist(),{}),"matmul 92 values")
end
do -- matmul 93: float32[2, 1] @ int8[1, 4]
  local a=(np.array({{0.75,-0.75}},np.float32)).T
  local b=np.array({{4,0,-4,1}},np.int8)
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 93 dtype "..r.dtype)
  assert(close(r.shape,{2,4}),"matmul 93 shape")
  assert(close(r.strides,{16,4}),"matmul 93 strides")
  assert(close(r:tolist(),{{3.0,0.0,-3.0,0.75},{-3.0,0.0,3.0,-0.75}}),"matmul 93 values")
end
do -- matmul 94: int8[0, 2, 3] @ float32[0, 3, 4]
  local a=np.zeros({0,2,3},np.int8)
  local b=np.zeros({0,3,4},np.float32)
  local o=np.zeros({0,2,4},np.float32)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 94 out identity")
  assert(r.dtype=="float32","matmul 94 dtype "..r.dtype)
  assert(close(r.shape,{0,2,4}),"matmul 94 shape")
  assert(close(r.strides,{0,0,0}),"matmul 94 out strides")
  assert(close(r:tolist(),{}),"matmul 94 values")
end
do -- matmul 95: uint8[1, 1, 1, 4, 2] @ float32[0, 1, 0, 2, 0]
  local a=np.array({{{{{1,4},{2,0},{3,1},{4,2}}}}},np.uint8)
  local b=np.zeros({0,1,0,2,0},np.float32)
  local o=np.zeros({0,1,0,4,0},np.float32)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 95 out identity")
  assert(r.dtype=="float32","matmul 95 dtype "..r.dtype)
  assert(close(r.shape,{0,1,0,4,0}),"matmul 95 shape")
  assert(close(r.strides,{0,0,0,0,0}),"matmul 95 out strides")
  assert(close(r:tolist(),{}),"matmul 95 values")
end
do -- matmul 96: int32[4, 4] @ int16[4]
  local a=np.array({{0,-4,1,-3},{2,-2,3,-1},{4,0,-4,1},{-3,2,-2,3}},np.int32)
  local b=np.array({1,-3,2,-2},np.int16)
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 96 dtype "..r.dtype)
  assert(close(r.shape,{4}),"matmul 96 shape")
  assert(close(r.strides,{4}),"matmul 96 strides")
  assert(close(r:tolist(),{20,16,-6,-19}),"matmul 96 values")
end
do -- matmul 97: int8[4, 4] @ bool[1, 1, 4, 1]
  local a=(np.array({{2,-2,3,-1},{4,0,-4,1},{-3,2,-2,3},{-1,4,0,-4}},np.int8)).T
  local b=(np.array({{{{true}},{{true}},{{false}},{{true}}}},np.bool)).T
  local o=np.zeros({1,1,4,1},np.int8)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 97 out identity")
  assert(r.dtype=="int8","matmul 97 dtype "..r.dtype)
  assert(close(r.shape,{1,1,4,1}),"matmul 97 shape")
  assert(close(r.strides,{4,4,1,1}),"matmul 97 out strides")
  assert(close(r:tolist(),{{{{5},{2},{-1},{-4}}}}),"matmul 97 values")
end
do -- matmul 98: uint32[3, 4] @ uint64[4, 0]
  local a=np.array({{2,0,3,1},{4,2,0,3},{1,4,2,0}},np.uint32)
  local b=np.zeros({4,0},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint64","matmul 98 dtype "..r.dtype)
  assert(close(r.shape,{3,0}),"matmul 98 shape")
  assert(close(r.strides,{0,0}),"matmul 98 strides")
  assert(close(r:tolist(),{{},{},{}}),"matmul 98 values")
end
do -- matmul 99: int16[1, 3] @ int64[0, 2, 3, 2]
  local a=np.array({{-3,2,-2}},np.int16)
  local b=np.zeros({0,2,3,2},np.int64)
  local r=np.matmul(a,b)
  assert(r.dtype=="int64","matmul 99 dtype "..r.dtype)
  assert(close(r.shape,{0,2,1,2}),"matmul 99 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 99 strides")
  assert(close(r:tolist(),{}),"matmul 99 values")
end
do -- matmul 100: int64[2] @ int32[2, 3]
  local a=np.array({-1,4},np.int64)
  local b=np.array({{0,-4,1},{-3,2,-2}},np.int32)
  local r=np.matmul(a,b)
  assert(r.dtype=="int64","matmul 100 dtype "..r.dtype)
  assert(close(r.shape,{3}),"matmul 100 shape")
  assert(close(r.strides,{8}),"matmul 100 strides")
  assert(close(r:tolist(),{-12,12,-9}),"matmul 100 values")
end
do -- matmul 101: int16[1, 4, 1] @ uint64[1, 1, 4]
  local a=np.array({{{1},{-3},{2},{-2}}},np.int16)
  local b=(np.array({{{4}},{{2}},{{0}},{{3}}},np.uint64)).T
  local o=np.zeros({1,4,4},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 101 out identity")
  assert(r.dtype=="float64","matmul 101 dtype "..r.dtype)
  assert(close(r.shape,{1,4,4}),"matmul 101 shape")
  assert(close(r.strides,{128,32,8}),"matmul 101 out strides")
  assert(close(r:tolist(),{{{4.0,2.0,0.0,3.0},{-12.0,-6.0,0.0,-9.0},{8.0,4.0,0.0,6.0},{-8.0,-4.0,0.0,-6.0}}}),"matmul 101 values")
end
do -- matmul 102: uint32[0, 1, 3] @ float32[3, 4]
  local a=np.zeros({0,1,3},np.uint32)
  local b=np.array({{1.0,-0.5,0.25,1.0},{-0.5,0.25,1.0,-0.5},{0.25,1.0,-0.5,0.25}},np.float32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 102 dtype "..r.dtype)
  assert(close(r.shape,{0,1,4}),"matmul 102 shape")
  assert(close(r.strides,{0,0,0}),"matmul 102 strides")
  assert(close(r:tolist(),{}),"matmul 102 values")
end
do -- matmul 103: uint16[2, 0, 4] @ uint64[0, 2, 4, 4]
  local a=np.zeros({2,0,4},np.uint16)
  local b=np.zeros({0,2,4,4},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint64","matmul 103 dtype "..r.dtype)
  assert(close(r.shape,{0,2,0,4}),"matmul 103 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 103 strides")
  assert(close(r:tolist(),{}),"matmul 103 values")
end
do -- matmul 104: uint8[1] @ float32[0, 1, 1, 2]
  local a=np.array({4},np.uint8)
  local b=(np.zeros({2,1,1,0},np.float32)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 104 dtype "..r.dtype)
  assert(close(r.shape,{0,1,2}),"matmul 104 shape")
  assert(close(r.strides,{0,0,0}),"matmul 104 strides")
  assert(close(r:tolist(),{}),"matmul 104 values")
end
do -- matmul 105: uint32[2, 1, 4, 3] @ float16[2, 1, 3, 1]
  local a=np.array({{{{1,4,2},{0,3,1},{4,2,0},{3,1,4}}},{{{2,0,3},{1,4,2},{0,3,1},{4,2,0}}}},np.uint32)
  local b=np.array({{{{0.25},{1.0},{-0.5}}},{{{0.25},{1.0},{-0.5}}}},np.float16)
  local o=np.zeros({2,1,4,1},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 105 out identity")
  assert(r.dtype=="float64","matmul 105 dtype "..r.dtype)
  assert(close(r.shape,{2,1,4,1}),"matmul 105 shape")
  assert(close(r.strides,{32,32,8,8}),"matmul 105 out strides")
  assert(close(r:tolist(),{{{{3.25},{2.5},{3.0},{-0.25}}},{{{-1.0},{3.25},{2.5},{3.0}}}}),"matmul 105 values")
end
do -- matmul 106: uint64[3, 1, 4, 0] @ int8[0, 2]
  local a=np.zeros({3,1,4,0},np.uint64)
  local b=(np.zeros({2,0},np.int8)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 106 dtype "..r.dtype)
  assert(close(r.shape,{3,1,4,2}),"matmul 106 shape")
  assert(close(r.strides,{64,64,16,8}),"matmul 106 strides")
  assert(close(r:tolist(),{{{{0.0,0.0},{0.0,0.0},{0.0,0.0},{0.0,0.0}}},{{{0.0,0.0},{0.0,0.0},{0.0,0.0},{0.0,0.0}}},{{{0.0,0.0},{0.0,0.0},{0.0,0.0},{0.0,0.0}}}}),"matmul 106 values")
end
do -- matmul 107: float16[1, 0] @ uint64[0, 0]
  local a=np.zeros({1,0},np.float16)
  local b=np.zeros({0,0},np.uint64)
  local o=np.zeros({1,0},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 107 out identity")
  assert(r.dtype=="float64","matmul 107 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"matmul 107 shape")
  assert(close(r.strides,{0,0}),"matmul 107 out strides")
  assert(close(r:tolist(),{{}}),"matmul 107 values")
end
do -- matmul 108: float64[0, 1] @ int16[1]
  local a=np.zeros({0,1},np.float64)
  local b=np.array({-2},np.int16)
  local o=np.zeros({0},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 108 out identity")
  assert(r.dtype=="float64","matmul 108 dtype "..r.dtype)
  assert(close(r.shape,{0}),"matmul 108 shape")
  assert(close(r.strides,{0}),"matmul 108 out strides")
  assert(close(r:tolist(),{}),"matmul 108 values")
end
do -- matmul 109: uint16[0, 3] @ uint64[3]
  local a=np.zeros({0,3},np.uint16)
  local b=np.array({0,3,1},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint64","matmul 109 dtype "..r.dtype)
  assert(close(r.shape,{0}),"matmul 109 shape")
  assert(close(r.strides,{0}),"matmul 109 strides")
  assert(close(r:tolist(),{}),"matmul 109 values")
end
do -- matmul 110: int8[2, 0] @ uint64[0]
  local a=(np.zeros({0,2},np.int8)).T
  local b=np.zeros({0},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 110 dtype "..r.dtype)
  assert(close(r.shape,{2}),"matmul 110 shape")
  assert(close(r.strides,{8}),"matmul 110 strides")
  assert(close(r:tolist(),{0.0,0.0}),"matmul 110 values")
end
do -- matmul 111: bool[1] @ uint8[0, 1, 1]
  local a=np.array({true},np.bool)
  local b=np.zeros({0,1,1},np.uint8)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint8","matmul 111 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"matmul 111 shape")
  assert(close(r.strides,{0,0}),"matmul 111 strides")
  assert(close(r:tolist(),{}),"matmul 111 values")
end
do -- matmul 112: float32[4, 0] @ float16[0, 3]
  local a=np.zeros({4,0},np.float32)
  local b=np.zeros({0,3},np.float16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 112 dtype "..r.dtype)
  assert(close(r.shape,{4,3}),"matmul 112 shape")
  assert(close(r.strides,{12,4}),"matmul 112 strides")
  assert(close(r:tolist(),{{0.0,0.0,0.0},{0.0,0.0,0.0},{0.0,0.0,0.0},{0.0,0.0,0.0}}),"matmul 112 values")
end
do -- matmul 113: bool[3] @ uint64[3, 3]
  local a=np.array({true,false,true},np.bool)
  local b=np.array({{3,1,4},{2,0,3},{1,4,2}},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint64","matmul 113 dtype "..r.dtype)
  assert(close(r.shape,{3}),"matmul 113 shape")
  assert(close(r.strides,{8}),"matmul 113 strides")
  assert(close(r:tolist(),{4,5,6}),"matmul 113 values")
end
do -- matmul 114: uint8[4, 3] @ uint16[3, 4]
  local a=np.array({{4,2,0},{3,1,4},{2,0,3},{1,4,2}},np.uint8)
  local b=np.array({{0,3,1,4},{2,0,3,1},{4,2,0,3}},np.uint16)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint16","matmul 114 dtype "..r.dtype)
  assert(close(r.shape,{4,4}),"matmul 114 shape")
  assert(close(r.strides,{8,2}),"matmul 114 strides")
  assert(close(r:tolist(),{{4,12,10,18},{18,17,6,25},{12,12,2,17},{16,7,13,14}}),"matmul 114 values")
end
do -- matmul 115: uint8[1, 1, 2, 0] @ int8[0, 3]
  local a=(np.zeros({0,2,1,1},np.uint8)).T
  local b=np.zeros({0,3},np.int8)
  local r=np.matmul(a,b)
  assert(r.dtype=="int16","matmul 115 dtype "..r.dtype)
  assert(close(r.shape,{1,1,2,3}),"matmul 115 shape")
  assert(close(r.strides,{12,12,6,2}),"matmul 115 strides")
  assert(close(r:tolist(),{{{{0,0,0},{0,0,0}}}}),"matmul 115 values")
end
do -- matmul 116: bool[4, 3] @ float16[3, 4]
  local a=np.array({{true,false,true},{true,false,true},{true,false,true},{true,false,true}},np.bool)
  local b=np.array({{-1.0,-0.25,0.5,-1.0},{-0.25,0.5,-1.0,-0.25},{0.5,-1.0,-0.25,0.5}},np.float16)
  local o=np.zeros({4,4},np.float16)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 116 out identity")
  assert(r.dtype=="float16","matmul 116 dtype "..r.dtype)
  assert(close(r.shape,{4,4}),"matmul 116 shape")
  assert(close(r.strides,{8,2}),"matmul 116 out strides")
  assert(close(r:tolist(),{{-0.5,-1.25,0.25,-0.5},{-0.5,-1.25,0.25,-0.5},{-0.5,-1.25,0.25,-0.5},{-0.5,-1.25,0.25,-0.5}}),"matmul 116 values")
end
do -- matmul 117: uint64[3, 4, 2] @ float16[2]
  local a=np.array({{{0,3},{1,4},{2,0},{3,1}},{{4,2},{0,3},{1,4},{2,0}},{{3,1},{4,2},{0,3},{1,4}}},np.uint64)
  local b=np.array({-0.5,0.25},np.float16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 117 dtype "..r.dtype)
  assert(close(r.shape,{3,4}),"matmul 117 shape")
  assert(close(r.strides,{32,8}),"matmul 117 strides")
  assert(close(r:tolist(),{{0.75,0.5,-1.0,-1.25},{-1.5,0.75,0.5,-1.0},{-1.25,-1.5,0.75,0.5}}),"matmul 117 values")
end
do -- matmul 118: int32[3, 2] @ int8[1, 2, 1]
  local a=(np.array({{-1,4,0},{-4,1,-3}},np.int32)).T
  local b=np.array({{{0},{-4}}},np.int8)
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 118 dtype "..r.dtype)
  assert(close(r.shape,{1,3,1}),"matmul 118 shape")
  assert(close(r.strides,{12,4,4}),"matmul 118 strides")
  assert(close(r:tolist(),{{{16},{-4},{12}}}),"matmul 118 values")
end
do -- matmul 119: float16[2] @ float64[2, 1]
  local a=np.array({0.25,1.0},np.float16)
  local b=np.array({{0.5},{-1.0}},np.float64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 119 dtype "..r.dtype)
  assert(close(r.shape,{1}),"matmul 119 shape")
  assert(close(r.strides,{8}),"matmul 119 strides")
  assert(close(r:tolist(),{-0.875}),"matmul 119 values")
end
do -- matmul 120: uint8[0, 1] @ uint16[1, 3]
  local a=np.zeros({0,1},np.uint8)
  local b=np.array({{2,0,3}},np.uint16)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint16","matmul 120 dtype "..r.dtype)
  assert(close(r.shape,{0,3}),"matmul 120 shape")
  assert(close(r.strides,{0,0}),"matmul 120 strides")
  assert(close(r:tolist(),{}),"matmul 120 values")
end
do -- matmul 121: uint64[1, 2, 1, 1] @ int8[1]
  local a=(np.array({{{{3},{1}}}},np.uint64)).T
  local b=np.array({-3},np.int8)
  local o=np.zeros({1,2,1},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 121 out identity")
  assert(r.dtype=="float64","matmul 121 dtype "..r.dtype)
  assert(close(r.shape,{1,2,1}),"matmul 121 shape")
  assert(close(r.strides,{16,8,8}),"matmul 121 out strides")
  assert(close(r:tolist(),{{{-9.0},{-3.0}}}),"matmul 121 values")
end
do -- matmul 122: uint32[2, 2, 4, 0] @ float16[0, 1]
  local a=np.zeros({2,2,4,0},np.uint32)
  local b=np.zeros({0,1},np.float16)
  local ob=np.zeros({1,4,2,2},np.float64)
  local o=ob.T
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 122 out identity")
  assert(r.dtype=="float64","matmul 122 dtype "..r.dtype)
  assert(close(r.shape,{2,2,4,1}),"matmul 122 shape")
  assert(close(r.strides,{8,16,32,128}),"matmul 122 out strides")
  assert(close(r:tolist(),{{{{0.0},{0.0},{0.0},{0.0}},{{0.0},{0.0},{0.0},{0.0}}},{{{0.0},{0.0},{0.0},{0.0}},{{0.0},{0.0},{0.0},{0.0}}}}),"matmul 122 values")
end
do -- matmul 123: uint8[1, 3, 1] @ float64[1, 1]
  local a=np.array({{{2},{0},{3}}},np.uint8)
  local b=np.array({{0.25}},np.float64)
  local o=np.zeros({1,3,1},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 123 out identity")
  assert(r.dtype=="float64","matmul 123 dtype "..r.dtype)
  assert(close(r.shape,{1,3,1}),"matmul 123 shape")
  assert(close(r.strides,{24,8,8}),"matmul 123 out strides")
  assert(close(r:tolist(),{{{0.5},{0.0},{0.75}}}),"matmul 123 values")
end
do -- matmul 124: int32[1, 0] @ int8[0]
  local a=(np.zeros({0,1},np.int32)).T
  local b=np.zeros({0},np.int8)
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 124 dtype "..r.dtype)
  assert(close(r.shape,{1}),"matmul 124 shape")
  assert(close(r.strides,{4}),"matmul 124 strides")
  assert(close(r:tolist(),{0}),"matmul 124 values")
end
do -- matmul 125: uint64[4, 0] @ uint16[1, 0, 3]
  local a=np.zeros({4,0},np.uint64)
  local b=np.zeros({1,0,3},np.uint16)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint64","matmul 125 dtype "..r.dtype)
  assert(close(r.shape,{1,4,3}),"matmul 125 shape")
  assert(close(r.strides,{96,24,8}),"matmul 125 strides")
  assert(close(r:tolist(),{{{0,0,0},{0,0,0},{0,0,0},{0,0,0}}}),"matmul 125 values")
end
do -- matmul 126: int64[1, 0, 2] @ int32[2, 3]
  local a=np.zeros({1,0,2},np.int64)
  local b=np.array({{-2,3,-1},{4,0,-4}},np.int32)
  local r=np.matmul(a,b)
  assert(r.dtype=="int64","matmul 126 dtype "..r.dtype)
  assert(close(r.shape,{1,0,3}),"matmul 126 shape")
  assert(close(r.strides,{0,0,0}),"matmul 126 strides")
  assert(close(r:tolist(),{{}}),"matmul 126 values")
end
do -- matmul 127: bool[1, 2, 0] @ int32[0]
  local a=np.zeros({1,2,0},np.bool)
  local b=np.zeros({0},np.int32)
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 127 dtype "..r.dtype)
  assert(close(r.shape,{1,2}),"matmul 127 shape")
  assert(close(r.strides,{8,4}),"matmul 127 strides")
  assert(close(r:tolist(),{{0,0}}),"matmul 127 values")
end
do -- matmul 128: uint32[1, 0, 3, 2] @ float16[2]
  local a=np.zeros({1,0,3,2},np.uint32)
  local b=np.array({0.5,-1.0},np.float16)
  local o=np.zeros({1,0,3},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 128 out identity")
  assert(r.dtype=="float64","matmul 128 dtype "..r.dtype)
  assert(close(r.shape,{1,0,3}),"matmul 128 shape")
  assert(close(r.strides,{0,0,0}),"matmul 128 out strides")
  assert(close(r:tolist(),{{}}),"matmul 128 values")
end
do -- matmul 129: float64[1, 1, 4] @ bool[4, 4]
  local a=np.array({{{0.75,-0.75,0.0,0.75}}},np.float64)
  local b=np.array({{true,false,true,true},{false,true,true,false},{true,true,false,true},{true,false,true,true}},np.bool)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 129 dtype "..r.dtype)
  assert(close(r.shape,{1,1,4}),"matmul 129 shape")
  assert(close(r.strides,{32,32,8}),"matmul 129 strides")
  assert(close(r:tolist(),{{{1.5,-0.75,0.75,1.5}}}),"matmul 129 values")
end
do -- matmul 130: uint16[3] @ float16[3]
  local a=np.array({1,4,2},np.uint16)
  local b=np.array({-0.75,0.0,0.75},np.float16)
  local r=np.matmul(a,b)
  assert(close(r,0.75),"matmul 130 scalar value")
end
do -- matmul 131: int32[2] @ bool[2]
  local a=np.array({-2,3},np.int32)
  local b=np.array({false,true},np.bool)
  local o=np.zeros({},np.int32)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 131 out identity")
  assert(r.dtype=="int32","matmul 131 dtype "..r.dtype)
  assert(close(r.shape,{}),"matmul 131 shape")
  assert(close(r.strides,{}),"matmul 131 out strides")
  assert(close(r:tolist(),3),"matmul 131 values")
end
do -- matmul 132: float64[1, 0, 2] @ uint32[2, 2]
  local a=(np.zeros({2,0,1},np.float64)).T
  local b=np.array({{1,4},{2,0}},np.uint32)
  local o=np.zeros({1,0,2},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 132 out identity")
  assert(r.dtype=="float64","matmul 132 dtype "..r.dtype)
  assert(close(r.shape,{1,0,2}),"matmul 132 shape")
  assert(close(r.strides,{0,0,0}),"matmul 132 out strides")
  assert(close(r:tolist(),{{}}),"matmul 132 values")
end
do -- matmul 133: uint32[0, 2, 3] @ float64[3, 3]
  local a=(np.zeros({3,2,0},np.uint32)).T
  local b=np.array({{0.75,-0.75,0.0},{0.75,-0.75,0.0},{0.75,-0.75,0.0}},np.float64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 133 dtype "..r.dtype)
  assert(close(r.shape,{0,2,3}),"matmul 133 shape")
  assert(close(r.strides,{0,0,0}),"matmul 133 strides")
  assert(close(r:tolist(),{}),"matmul 133 values")
end
do -- matmul 134: int8[0] @ float16[0, 0, 1]
  local a=np.zeros({0},np.int8)
  local b=np.zeros({0,0,1},np.float16)
  local o=np.zeros({0,1},np.float16)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 134 out identity")
  assert(r.dtype=="float16","matmul 134 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"matmul 134 shape")
  assert(close(r.strides,{0,0}),"matmul 134 out strides")
  assert(close(r:tolist(),{}),"matmul 134 values")
end
do -- matmul 135: bool[1, 3, 2] @ int64[2, 2]
  local a=np.array({{{true,true},{false,true},{true,false}}},np.bool)
  local b=np.array({{-2,3},{-1,4}},np.int64)
  local r=np.matmul(a,b)
  assert(r.dtype=="int64","matmul 135 dtype "..r.dtype)
  assert(close(r.shape,{1,3,2}),"matmul 135 shape")
  assert(close(r.strides,{48,16,8}),"matmul 135 strides")
  assert(close(r:tolist(),{{{-3,7},{-1,4},{-2,3}}}),"matmul 135 values")
end
do -- matmul 136: bool[1, 2] @ bool[1, 1, 2, 1]
  local a=np.array({{false,true}},np.bool)
  local b=np.array({{{{true},{true}}}},np.bool)
  local r=np.matmul(a,b)
  assert(r.dtype=="bool","matmul 136 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,1}),"matmul 136 shape")
  assert(close(r.strides,{1,1,1,1}),"matmul 136 strides")
  assert(close(r:tolist(),{{{{true}}}}),"matmul 136 values")
end
do -- matmul 137: uint16[2, 4] @ float64[0, 2, 1, 4, 4]
  local a=np.array({{0,3,1,4},{2,0,3,1}},np.uint16)
  local b=np.zeros({0,2,1,4,4},np.float64)
  local ob=np.zeros({4,2,1,2,0},np.float64)
  local o=ob.T
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 137 out identity")
  assert(r.dtype=="float64","matmul 137 dtype "..r.dtype)
  assert(close(r.shape,{0,2,1,2,4}),"matmul 137 shape")
  assert(close(r.strides,{0,0,0,0,0}),"matmul 137 out strides")
  assert(close(r:tolist(),{}),"matmul 137 values")
end
do -- matmul 138: uint16[1, 0] @ uint32[0, 4]
  local a=(np.zeros({0,1},np.uint16)).T
  local b=np.zeros({0,4},np.uint32)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint32","matmul 138 dtype "..r.dtype)
  assert(close(r.shape,{1,4}),"matmul 138 shape")
  assert(close(r.strides,{16,4}),"matmul 138 strides")
  assert(close(r:tolist(),{{0,0,0,0}}),"matmul 138 values")
end
do -- matmul 139: uint32[1, 2, 1, 3, 2] @ uint32[2, 2]
  local a=np.array({{{{{4,2},{0,3},{1,4}}},{{{2,0},{3,1},{4,2}}}}},np.uint32)
  local b=np.array({{0,3},{1,4}},np.uint32)
  local o=np.zeros({1,2,1,3,2},np.uint32)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 139 out identity")
  assert(r.dtype=="uint32","matmul 139 dtype "..r.dtype)
  assert(close(r.shape,{1,2,1,3,2}),"matmul 139 shape")
  assert(close(r.strides,{48,24,24,8,4}),"matmul 139 out strides")
  assert(close(r:tolist(),{{{{{2,20},{3,12},{4,19}}},{{{0,6},{1,13},{2,20}}}}}),"matmul 139 values")
end
do -- matmul 140: uint32[2, 1, 3, 3, 1] @ uint8[1, 2]
  local a=np.array({{{{{1},{4},{2}},{{0},{3},{1}},{{4},{2},{0}}}},{{{{3},{1},{4}},{{2},{0},{3}},{{1},{4},{2}}}}},np.uint32)
  local b=np.array({{2,0}},np.uint8)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint32","matmul 140 dtype "..r.dtype)
  assert(close(r.shape,{2,1,3,3,2}),"matmul 140 shape")
  assert(close(r.strides,{72,72,24,8,4}),"matmul 140 strides")
  assert(close(r:tolist(),{{{{{2,0},{8,0},{4,0}},{{0,0},{6,0},{2,0}},{{8,0},{4,0},{0,0}}}},{{{{6,0},{2,0},{8,0}},{{4,0},{0,0},{6,0}},{{2,0},{8,0},{4,0}}}}}),"matmul 140 values")
end
do -- matmul 141: uint16[0] @ int32[3, 0, 1]
  local a=np.zeros({0},np.uint16)
  local b=(np.zeros({1,0,3},np.int32)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 141 dtype "..r.dtype)
  assert(close(r.shape,{3,1}),"matmul 141 shape")
  assert(close(r.strides,{4,4}),"matmul 141 strides")
  assert(close(r:tolist(),{{0},{0},{0}}),"matmul 141 values")
end
do -- matmul 142: uint32[2] @ uint16[2, 4]
  local a=np.array({0,3},np.uint32)
  local b=np.array({{1,4,2,0},{3,1,4,2}},np.uint16)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint32","matmul 142 dtype "..r.dtype)
  assert(close(r.shape,{4}),"matmul 142 shape")
  assert(close(r.strides,{4}),"matmul 142 strides")
  assert(close(r:tolist(),{9,3,12,6}),"matmul 142 values")
end
do -- matmul 143: int8[0, 0] @ uint32[0, 4]
  local a=np.zeros({0,0},np.int8)
  local b=np.zeros({0,4},np.uint32)
  local o=np.zeros({0,4},np.int64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 143 out identity")
  assert(r.dtype=="int64","matmul 143 dtype "..r.dtype)
  assert(close(r.shape,{0,4}),"matmul 143 shape")
  assert(close(r.strides,{0,0}),"matmul 143 out strides")
  assert(close(r:tolist(),{}),"matmul 143 values")
end
do -- matmul 144: uint32[1, 1, 0] @ uint64[3, 1, 0, 1]
  local a=np.zeros({1,1,0},np.uint32)
  local b=(np.zeros({1,0,1,3},np.uint64)).T
  local o=np.zeros({3,1,1,1},np.uint64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 144 out identity")
  assert(r.dtype=="uint64","matmul 144 dtype "..r.dtype)
  assert(close(r.shape,{3,1,1,1}),"matmul 144 shape")
  assert(close(r.strides,{8,8,8,8}),"matmul 144 out strides")
  assert(close(r:tolist(),{{{{0}}},{{{0}}},{{{0}}}}),"matmul 144 values")
end
do -- matmul 145: uint64[3, 0] @ float32[0, 3]
  local a=(np.zeros({0,3},np.uint64)).T
  local b=np.zeros({0,3},np.float32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 145 dtype "..r.dtype)
  assert(close(r.shape,{3,3}),"matmul 145 shape")
  assert(close(r.strides,{24,8}),"matmul 145 strides")
  assert(close(r:tolist(),{{0.0,0.0,0.0},{0.0,0.0,0.0},{0.0,0.0,0.0}}),"matmul 145 values")
end
do -- matmul 146: uint16[2, 0] @ float32[0, 3]
  local a=np.zeros({2,0},np.uint16)
  local b=(np.zeros({3,0},np.float32)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 146 dtype "..r.dtype)
  assert(close(r.shape,{2,3}),"matmul 146 shape")
  assert(close(r.strides,{12,4}),"matmul 146 strides")
  assert(close(r:tolist(),{{0.0,0.0,0.0},{0.0,0.0,0.0}}),"matmul 146 values")
end
do -- matmul 147: float16[3, 4] @ float16[1, 4, 0]
  local a=np.array({{0.75,-0.75,0.0,0.75},{-0.75,0.0,0.75,-0.75},{0.0,0.75,-0.75,0.0}},np.float16)
  local b=np.zeros({1,4,0},np.float16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float16","matmul 147 dtype "..r.dtype)
  assert(close(r.shape,{1,3,0}),"matmul 147 shape")
  assert(close(r.strides,{0,0,0}),"matmul 147 strides")
  assert(close(r:tolist(),{{{},{},{}}}),"matmul 147 values")
end
do -- matmul 148: float16[1, 3, 2] @ float16[1, 3, 2, 0]
  local a=np.array({{{-1.0,-0.25},{0.5,-1.0},{-0.25,0.5}}},np.float16)
  local b=(np.zeros({0,2,3,1},np.float16)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="float16","matmul 148 dtype "..r.dtype)
  assert(close(r.shape,{1,3,3,0}),"matmul 148 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 148 strides")
  assert(close(r:tolist(),{{{{},{},{}},{{},{},{}},{{},{},{}}}}),"matmul 148 values")
end
do -- matmul 149: int32[1, 1, 2, 1] @ uint8[1, 1, 4]
  local a=np.array({{{{-2},{3}}}},np.int32)
  local b=np.array({{{0,3,1,4}}},np.uint8)
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 149 dtype "..r.dtype)
  assert(close(r.shape,{1,1,2,4}),"matmul 149 shape")
  assert(close(r.strides,{32,32,16,4}),"matmul 149 strides")
  assert(close(r:tolist(),{{{{0,-6,-2,-8},{0,9,3,12}}}}),"matmul 149 values")
end
do -- matmul 150: int8[3, 1] @ uint64[1, 2]
  local a=np.array({{0},{-4},{1}},np.int8)
  local b=np.array({{2,0}},np.uint64)
  local ob=np.zeros({2,3},np.float64)
  local o=ob.T
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 150 out identity")
  assert(r.dtype=="float64","matmul 150 dtype "..r.dtype)
  assert(close(r.shape,{3,2}),"matmul 150 shape")
  assert(close(r.strides,{8,24}),"matmul 150 out strides")
  assert(close(r:tolist(),{{0.0,0.0},{-8.0,0.0},{2.0,0.0}}),"matmul 150 values")
end
do -- matmul 151: int32[3, 3] @ uint32[1, 1, 0, 3, 2]
  local a=np.array({{2,-2,3},{-1,4,0},{-4,1,-3}},np.int32)
  local b=np.zeros({1,1,0,3,2},np.uint32)
  local o=np.zeros({1,1,0,3,2},np.int64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 151 out identity")
  assert(r.dtype=="int64","matmul 151 dtype "..r.dtype)
  assert(close(r.shape,{1,1,0,3,2}),"matmul 151 shape")
  assert(close(r.strides,{0,0,0,0,0}),"matmul 151 out strides")
  assert(close(r:tolist(),{{{}}}),"matmul 151 values")
end
do -- matmul 152: int16[3] @ uint16[3, 2]
  local a=np.array({4,0,-4},np.int16)
  local b=np.array({{1,4},{2,0},{3,1}},np.uint16)
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 152 dtype "..r.dtype)
  assert(close(r.shape,{2}),"matmul 152 shape")
  assert(close(r.strides,{4}),"matmul 152 strides")
  assert(close(r:tolist(),{-8,12}),"matmul 152 values")
end
do -- matmul 153: float16[3, 3, 0, 3] @ float32[3, 0]
  local a=np.zeros({3,3,0,3},np.float16)
  local b=np.zeros({3,0},np.float32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 153 dtype "..r.dtype)
  assert(close(r.shape,{3,3,0,0}),"matmul 153 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 153 strides")
  assert(close(r:tolist(),{{{},{},{}},{{},{},{}},{{},{},{}}}),"matmul 153 values")
end
do -- matmul 154: float64[3] @ int16[3, 1]
  local a=np.array({-0.25,0.5,-1.0},np.float64)
  local b=np.array({{0},{-4},{1}},np.int16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 154 dtype "..r.dtype)
  assert(close(r.shape,{1}),"matmul 154 shape")
  assert(close(r.strides,{8}),"matmul 154 strides")
  assert(close(r:tolist(),{-3.0}),"matmul 154 values")
end
do -- matmul 155: uint8[1, 0, 3] @ float16[3, 0]
  local a=(np.zeros({3,0,1},np.uint8)).T
  local b=np.zeros({3,0},np.float16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float16","matmul 155 dtype "..r.dtype)
  assert(close(r.shape,{1,0,0}),"matmul 155 shape")
  assert(close(r.strides,{0,0,0}),"matmul 155 strides")
  assert(close(r:tolist(),{{}}),"matmul 155 values")
end
do -- matmul 156: int32[4, 3] @ uint64[3, 3]
  local a=np.array({{3,-1,4},{0,-4,1},{-3,2,-2},{3,-1,4}},np.int32)
  local b=np.array({{4,2,0},{3,1,4},{2,0,3}},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 156 dtype "..r.dtype)
  assert(close(r.shape,{4,3}),"matmul 156 shape")
  assert(close(r.strides,{24,8}),"matmul 156 strides")
  assert(close(r:tolist(),{{17.0,5.0,8.0},{-10.0,-4.0,-13.0},{-10.0,-4.0,2.0},{17.0,5.0,8.0}}),"matmul 156 values")
end
do -- matmul 157: uint8[3, 4, 4] @ int16[4, 2]
  local a=np.array({{{0,3,1,4},{2,0,3,1},{4,2,0,3},{1,4,2,0}},{{3,1,4,2},{0,3,1,4},{2,0,3,1},{4,2,0,3}},{{1,4,2,0},{3,1,4,2},{0,3,1,4},{2,0,3,1}}},np.uint8)
  local b=np.array({{-3,2},{-2,3},{-1,4},{0,-4}},np.int16)
  local o=np.zeros({3,4,2},np.int16)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 157 out identity")
  assert(r.dtype=="int16","matmul 157 dtype "..r.dtype)
  assert(close(r.shape,{3,4,2}),"matmul 157 shape")
  assert(close(r.strides,{16,4,2}),"matmul 157 out strides")
  assert(close(r:tolist(),{{{-7,-3},{-9,12},{-16,2},{-13,22}},{{-15,17},{-7,-3},{-9,12},{-16,2}},{{-13,22},{-15,17},{-7,-3},{-9,12}}}),"matmul 157 values")
end
do -- matmul 158: uint32[3, 2] @ uint64[2, 3]
  local a=(np.array({{2,0,3},{1,4,2}},np.uint32)).T
  local b=np.array({{3,1,4},{2,0,3}},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint64","matmul 158 dtype "..r.dtype)
  assert(close(r.shape,{3,3}),"matmul 158 shape")
  assert(close(r.strides,{24,8}),"matmul 158 strides")
  assert(close(r:tolist(),{{8,2,11},{8,0,12},{13,3,18}}),"matmul 158 values")
end
do -- matmul 159: int8[1, 3, 2] @ uint16[2, 4]
  local a=np.array({{{0,-4},{1,-3},{2,-2}}},np.int8)
  local b=np.array({{0,3,1,4},{2,0,3,1}},np.uint16)
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 159 dtype "..r.dtype)
  assert(close(r.shape,{1,3,4}),"matmul 159 shape")
  assert(close(r.strides,{48,16,4}),"matmul 159 strides")
  assert(close(r:tolist(),{{{-8,0,-12,-4},{-6,3,-8,1},{-4,6,-4,6}}}),"matmul 159 values")
end
do -- matmul 160: int64[4, 2] @ int64[2]
  local a=np.array({{2,-2},{3,-1},{4,0},{-4,1}},np.int64)
  local b=np.array({3,-1},np.int64)
  local o=np.zeros({4},np.int64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 160 out identity")
  assert(r.dtype=="int64","matmul 160 dtype "..r.dtype)
  assert(close(r.shape,{4}),"matmul 160 shape")
  assert(close(r.strides,{8}),"matmul 160 out strides")
  assert(close(r:tolist(),{8,10,12,-13}),"matmul 160 values")
end
do -- matmul 161: int16[3, 1, 3, 3] @ int16[3, 1]
  local a=np.array({{{{4,0,-4},{1,-3,2},{-2,3,-1}}},{{{4,0,-4},{1,-3,2},{-2,3,-1}}},{{{4,0,-4},{1,-3,2},{-2,3,-1}}}},np.int16)
  local b=np.array({{-4},{1},{-3}},np.int16)
  local r=np.matmul(a,b)
  assert(r.dtype=="int16","matmul 161 dtype "..r.dtype)
  assert(close(r.shape,{3,1,3,1}),"matmul 161 shape")
  assert(close(r.strides,{6,6,2,2}),"matmul 161 strides")
  assert(close(r:tolist(),{{{{-4},{-13},{14}}},{{{-4},{-13},{14}}},{{{-4},{-13},{14}}}}),"matmul 161 values")
end
do -- matmul 162: float64[1, 1, 1, 0, 0] @ int8[1, 2, 1, 0, 4]
  local a=np.zeros({1,1,1,0,0},np.float64)
  local b=np.zeros({1,2,1,0,4},np.int8)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 162 dtype "..r.dtype)
  assert(close(r.shape,{1,2,1,0,4}),"matmul 162 shape")
  assert(close(r.strides,{0,0,0,0,0}),"matmul 162 strides")
  assert(close(r:tolist(),{{{{}},{{}}}}),"matmul 162 values")
end
do -- matmul 163: uint16[0] @ float32[0]
  local a=np.zeros({0},np.uint16)
  local b=np.zeros({0},np.float32)
  local o=np.zeros({},np.float32)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 163 out identity")
  assert(r.dtype=="float32","matmul 163 dtype "..r.dtype)
  assert(close(r.shape,{}),"matmul 163 shape")
  assert(close(r.strides,{}),"matmul 163 out strides")
  assert(close(r:tolist(),0.0),"matmul 163 values")
end
do -- matmul 164: int16[3, 2] @ float64[0, 2, 2]
  local a=np.array({{1,-3},{2,-2},{3,-1}},np.int16)
  local b=np.zeros({0,2,2},np.float64)
  local o=np.zeros({0,3,2},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 164 out identity")
  assert(r.dtype=="float64","matmul 164 dtype "..r.dtype)
  assert(close(r.shape,{0,3,2}),"matmul 164 shape")
  assert(close(r.strides,{0,0,0}),"matmul 164 out strides")
  assert(close(r:tolist(),{}),"matmul 164 values")
end
do -- matmul 165: uint8[3, 1] @ int64[1]
  local a=np.array({{1},{4},{2}},np.uint8)
  local b=np.array({4},np.int64)
  local r=np.matmul(a,b)
  assert(r.dtype=="int64","matmul 165 dtype "..r.dtype)
  assert(close(r.shape,{3}),"matmul 165 shape")
  assert(close(r.strides,{8}),"matmul 165 strides")
  assert(close(r:tolist(),{4,16,8}),"matmul 165 values")
end
do -- matmul 166: float16[1, 1, 0, 3] @ int8[3, 1]
  local a=np.zeros({1,1,0,3},np.float16)
  local b=np.array({{-3},{2},{-2}},np.int8)
  local r=np.matmul(a,b)
  assert(r.dtype=="float16","matmul 166 dtype "..r.dtype)
  assert(close(r.shape,{1,1,0,1}),"matmul 166 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 166 strides")
  assert(close(r:tolist(),{{{}}}),"matmul 166 values")
end
do -- matmul 167: float16[3, 1, 0] @ int16[0]
  local a=np.zeros({3,1,0},np.float16)
  local b=np.zeros({0},np.int16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 167 dtype "..r.dtype)
  assert(close(r.shape,{3,1}),"matmul 167 shape")
  assert(close(r.strides,{4,4}),"matmul 167 strides")
  assert(close(r:tolist(),{{0.0},{0.0},{0.0}}),"matmul 167 values")
end
do -- matmul 168: int32[0] @ uint64[1, 0, 0, 0]
  local a=np.zeros({0},np.int32)
  local b=np.zeros({1,0,0,0},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 168 dtype "..r.dtype)
  assert(close(r.shape,{1,0,0}),"matmul 168 shape")
  assert(close(r.strides,{0,0,0}),"matmul 168 strides")
  assert(close(r:tolist(),{{}}),"matmul 168 values")
end
do -- matmul 169: uint32[1, 0, 1, 3] @ uint16[1, 3, 1]
  local a=np.zeros({1,0,1,3},np.uint32)
  local b=np.array({{{0},{3},{1}}},np.uint16)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint32","matmul 169 dtype "..r.dtype)
  assert(close(r.shape,{1,0,1,1}),"matmul 169 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 169 strides")
  assert(close(r:tolist(),{{}}),"matmul 169 values")
end
do -- matmul 170: int32[0, 0, 4] @ uint16[0, 4, 3]
  local a=np.zeros({0,0,4},np.int32)
  local b=np.zeros({0,4,3},np.uint16)
  local o=np.zeros({0,0,3},np.int32)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 170 out identity")
  assert(r.dtype=="int32","matmul 170 dtype "..r.dtype)
  assert(close(r.shape,{0,0,3}),"matmul 170 shape")
  assert(close(r.strides,{0,0,0}),"matmul 170 out strides")
  assert(close(r:tolist(),{}),"matmul 170 values")
end
do -- matmul 171: float16[0, 1, 2, 2] @ int8[0, 0, 2, 4]
  local a=np.zeros({0,1,2,2},np.float16)
  local b=np.zeros({0,0,2,4},np.int8)
  local r=np.matmul(a,b)
  assert(r.dtype=="float16","matmul 171 dtype "..r.dtype)
  assert(close(r.shape,{0,0,2,4}),"matmul 171 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 171 strides")
  assert(close(r:tolist(),{}),"matmul 171 values")
end
do -- matmul 172: float32[2, 1, 3] @ bool[3]
  local a=np.array({{{-0.25,0.5,-1.0}},{{-0.25,0.5,-1.0}}},np.float32)
  local b=np.array({true,true,false},np.bool)
  local o=np.zeros({2,1},np.float32)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 172 out identity")
  assert(r.dtype=="float32","matmul 172 dtype "..r.dtype)
  assert(close(r.shape,{2,1}),"matmul 172 shape")
  assert(close(r.strides,{4,4}),"matmul 172 out strides")
  assert(close(r:tolist(),{{0.25},{0.25}}),"matmul 172 values")
end
do -- matmul 173: bool[3, 1, 1] @ uint8[1, 0]
  local a=np.array({{{true}},{{false}},{{true}}},np.bool)
  local b=np.zeros({1,0},np.uint8)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint8","matmul 173 dtype "..r.dtype)
  assert(close(r.shape,{3,1,0}),"matmul 173 shape")
  assert(close(r.strides,{0,0,0}),"matmul 173 strides")
  assert(close(r:tolist(),{{{}},{{}},{{}}}),"matmul 173 values")
end
do -- matmul 174: float16[1, 1] @ uint8[3, 1, 3]
  local a=np.array({{0.75}},np.float16)
  local b=np.array({{{0,3,1}},{{4,2,0}},{{3,1,4}}},np.uint8)
  local r=np.matmul(a,b)
  assert(r.dtype=="float16","matmul 174 dtype "..r.dtype)
  assert(close(r.shape,{3,1,3}),"matmul 174 shape")
  assert(close(r.strides,{6,6,2}),"matmul 174 strides")
  assert(close(r:tolist(),{{{0.0,2.25,0.75}},{{3.0,1.5,0.0}},{{2.25,0.75,3.0}}}),"matmul 174 values")
end
do -- matmul 175: uint32[4, 1] @ uint64[1, 2]
  local a=np.array({{1},{4},{2},{0}},np.uint32)
  local b=np.array({{2,0}},np.uint64)
  local o=np.zeros({4,2},np.uint64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 175 out identity")
  assert(r.dtype=="uint64","matmul 175 dtype "..r.dtype)
  assert(close(r.shape,{4,2}),"matmul 175 shape")
  assert(close(r.strides,{16,8}),"matmul 175 out strides")
  assert(close(r:tolist(),{{2,0},{8,0},{4,0},{0,0}}),"matmul 175 values")
end
do -- matmul 176: bool[2, 4] @ uint32[1, 4, 4]
  local a=np.array({{true,false,true,true},{false,true,true,false}},np.bool)
  local b=np.array({{{4,2,0,3},{1,4,2,0},{3,1,4,2},{0,3,1,4}}},np.uint32)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint32","matmul 176 dtype "..r.dtype)
  assert(close(r.shape,{1,2,4}),"matmul 176 shape")
  assert(close(r.strides,{32,16,4}),"matmul 176 strides")
  assert(close(r:tolist(),{{{7,6,5,9},{4,5,6,2}}}),"matmul 176 values")
end
do -- matmul 177: float32[2, 3, 1, 2, 4] @ uint32[4]
  local a=np.array({{{{{0.0,0.75,-0.75,0.0},{0.75,-0.75,0.0,0.75}}},{{{-0.75,0.0,0.75,-0.75},{0.0,0.75,-0.75,0.0}}},{{{0.75,-0.75,0.0,0.75},{-0.75,0.0,0.75,-0.75}}}},{{{{0.0,0.75,-0.75,0.0},{0.75,-0.75,0.0,0.75}}},{{{-0.75,0.0,0.75,-0.75},{0.0,0.75,-0.75,0.0}}},{{{0.75,-0.75,0.0,0.75},{-0.75,0.0,0.75,-0.75}}}}},np.float32)
  local b=np.array({1,4,2,0},np.uint32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 177 dtype "..r.dtype)
  assert(close(r.shape,{2,3,1,2}),"matmul 177 shape")
  assert(close(r.strides,{48,16,16,8}),"matmul 177 strides")
  assert(close(r:tolist(),{{{{1.5,-2.25}},{{0.75,1.5}},{{-2.25,0.75}}},{{{1.5,-2.25}},{{0.75,1.5}},{{-2.25,0.75}}}}),"matmul 177 values")
end
do -- matmul 178: bool[1, 3, 2, 0] @ float16[0]
  local a=np.zeros({1,3,2,0},np.bool)
  local b=np.zeros({0},np.float16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float16","matmul 178 dtype "..r.dtype)
  assert(close(r.shape,{1,3,2}),"matmul 178 shape")
  assert(close(r.strides,{12,4,2}),"matmul 178 strides")
  assert(close(r:tolist(),{{{0.0,0.0},{0.0,0.0},{0.0,0.0}}}),"matmul 178 values")
end
do -- matmul 179: int64[3] @ uint8[3, 1]
  local a=np.array({4,0,-4},np.int64)
  local b=np.array({{0},{3},{1}},np.uint8)
  local r=np.matmul(a,b)
  assert(r.dtype=="int64","matmul 179 dtype "..r.dtype)
  assert(close(r.shape,{1}),"matmul 179 shape")
  assert(close(r.strides,{8}),"matmul 179 strides")
  assert(close(r:tolist(),{-4}),"matmul 179 values")
end
do -- matmul 180: float16[4, 1] @ uint64[2, 1, 2]
  local a=np.array({{-0.75},{0.0},{0.75},{-0.75}},np.float16)
  local b=np.array({{{2,0}},{{3,1}}},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 180 dtype "..r.dtype)
  assert(close(r.shape,{2,4,2}),"matmul 180 shape")
  assert(close(r.strides,{64,16,8}),"matmul 180 strides")
  assert(close(r:tolist(),{{{-1.5,0.0},{0.0,0.0},{1.5,0.0},{-1.5,0.0}},{{-2.25,-0.75},{0.0,0.0},{2.25,0.75},{-2.25,-0.75}}}),"matmul 180 values")
end
do -- matmul 181: float32[4, 4] @ float16[4, 3]
  local a=np.array({{-0.25,0.5,-1.0,-0.25},{0.5,-1.0,-0.25,0.5},{-1.0,-0.25,0.5,-1.0},{-0.25,0.5,-1.0,-0.25}},np.float32)
  local b=np.array({{0.0,0.75,-0.75},{0.0,0.75,-0.75},{0.0,0.75,-0.75},{0.0,0.75,-0.75}},np.float16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 181 dtype "..r.dtype)
  assert(close(r.shape,{4,3}),"matmul 181 shape")
  assert(close(r.strides,{12,4}),"matmul 181 strides")
  assert(close(r:tolist(),{{0.0,-0.75,0.75},{0.0,-0.1875,0.1875},{0.0,-1.3125,1.3125},{0.0,-0.75,0.75}}),"matmul 181 values")
end
do -- matmul 182: float64[1, 3, 1] @ uint32[0, 1, 1, 4]
  local a=np.array({{{0.25},{1.0},{-0.5}}},np.float64)
  local b=np.zeros({0,1,1,4},np.uint32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 182 dtype "..r.dtype)
  assert(close(r.shape,{0,1,3,4}),"matmul 182 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 182 strides")
  assert(close(r:tolist(),{}),"matmul 182 values")
end
do -- matmul 183: uint8[2] @ uint64[2, 4]
  local a=np.array({2,0},np.uint8)
  local b=np.array({{3,1,4,2},{0,3,1,4}},np.uint64)
  local o=np.zeros({4},np.uint64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 183 out identity")
  assert(r.dtype=="uint64","matmul 183 dtype "..r.dtype)
  assert(close(r.shape,{4}),"matmul 183 shape")
  assert(close(r.strides,{8}),"matmul 183 out strides")
  assert(close(r:tolist(),{6,2,8,4}),"matmul 183 values")
end
do -- matmul 184: int32[3, 3, 3] @ uint8[3, 1]
  local a=(np.array({{{-4,1,-3},{2,-2,3},{-1,4,0}},{{-4,1,-3},{2,-2,3},{-1,4,0}},{{-4,1,-3},{2,-2,3},{-1,4,0}}},np.int32)).T
  local b=np.array({{0},{3},{1}},np.uint8)
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 184 dtype "..r.dtype)
  assert(close(r.shape,{3,3,1}),"matmul 184 shape")
  assert(close(r.strides,{12,4,4}),"matmul 184 strides")
  assert(close(r:tolist(),{{{-16},{8},{-4}},{{4},{-8},{16}},{{-12},{12},{0}}}),"matmul 184 values")
end
do -- matmul 185: bool[1, 2, 3, 3] @ int32[3, 4]
  local a=np.array({{{{true,false,true},{true,false,true},{true,false,true}},{{true,false,true},{true,false,true},{true,false,true}}}},np.bool)
  local b=np.array({{-1,4,0,-4},{1,-3,2,-2},{3,-1,4,0}},np.int32)
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 185 dtype "..r.dtype)
  assert(close(r.shape,{1,2,3,4}),"matmul 185 shape")
  assert(close(r.strides,{96,48,16,4}),"matmul 185 strides")
  assert(close(r:tolist(),{{{{2,3,4,-4},{2,3,4,-4},{2,3,4,-4}},{{2,3,4,-4},{2,3,4,-4},{2,3,4,-4}}}}),"matmul 185 values")
end
do -- matmul 186: int8[2, 1, 0, 1] @ uint64[1]
  local a=np.zeros({2,1,0,1},np.int8)
  local b=np.array({4},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 186 dtype "..r.dtype)
  assert(close(r.shape,{2,1,0}),"matmul 186 shape")
  assert(close(r.strides,{0,0,0}),"matmul 186 strides")
  assert(close(r:tolist(),{{{}},{{}}}),"matmul 186 values")
end
do -- matmul 187: int64[1, 4] @ uint32[1, 1, 4, 2]
  local a=(np.array({{2},{-2},{3},{-1}},np.int64)).T
  local b=(np.array({{{{1}},{{4}},{{2}},{{0}}},{{{3}},{{1}},{{4}},{{2}}}},np.uint32)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="int64","matmul 187 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,2}),"matmul 187 shape")
  assert(close(r.strides,{16,16,16,8}),"matmul 187 strides")
  assert(close(r:tolist(),{{{{0,14}}}}),"matmul 187 values")
end
do -- matmul 188: uint8[0, 0] @ int8[1, 0, 2]
  local a=np.zeros({0,0},np.uint8)
  local b=np.zeros({1,0,2},np.int8)
  local o=np.zeros({1,0,2},np.int16)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 188 out identity")
  assert(r.dtype=="int16","matmul 188 dtype "..r.dtype)
  assert(close(r.shape,{1,0,2}),"matmul 188 shape")
  assert(close(r.strides,{0,0,0}),"matmul 188 out strides")
  assert(close(r:tolist(),{{}}),"matmul 188 values")
end
do -- matmul 189: uint16[0, 2, 0, 2] @ float16[0, 0, 2, 2, 3]
  local a=np.zeros({0,2,0,2},np.uint16)
  local b=np.zeros({0,0,2,2,3},np.float16)
  local o=np.zeros({0,0,2,0,3},np.float32)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 189 out identity")
  assert(r.dtype=="float32","matmul 189 dtype "..r.dtype)
  assert(close(r.shape,{0,0,2,0,3}),"matmul 189 shape")
  assert(close(r.strides,{0,0,0,0,0}),"matmul 189 out strides")
  assert(close(r:tolist(),{}),"matmul 189 values")
end
do -- matmul 190: uint8[2, 2] @ float64[2, 3]
  local a=np.array({{1,4},{2,0}},np.uint8)
  local b=np.array({{0.0,0.75,-0.75},{0.0,0.75,-0.75}},np.float64)
  local ob=np.zeros({3,2},np.float64)
  local o=ob.T
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 190 out identity")
  assert(r.dtype=="float64","matmul 190 dtype "..r.dtype)
  assert(close(r.shape,{2,3}),"matmul 190 shape")
  assert(close(r.strides,{8,16}),"matmul 190 out strides")
  assert(close(r:tolist(),{{0.0,3.75,-3.75},{0.0,1.5,-1.5}}),"matmul 190 values")
end
do -- matmul 191: uint8[1] @ int16[1, 2]
  local a=np.array({3},np.uint8)
  local b=np.array({{2,-2}},np.int16)
  local r=np.matmul(a,b)
  assert(r.dtype=="int16","matmul 191 dtype "..r.dtype)
  assert(close(r.shape,{2}),"matmul 191 shape")
  assert(close(r.strides,{2}),"matmul 191 strides")
  assert(close(r:tolist(),{6,-6}),"matmul 191 values")
end
do -- matmul 192: int16[2] @ float16[2, 4]
  local a=np.array({3,-1},np.int16)
  local b=np.array({{1.0,-0.5,0.25,1.0},{-0.5,0.25,1.0,-0.5}},np.float16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 192 dtype "..r.dtype)
  assert(close(r.shape,{4}),"matmul 192 shape")
  assert(close(r.strides,{4}),"matmul 192 strides")
  assert(close(r:tolist(),{3.5,-1.75,-0.25,3.5}),"matmul 192 values")
end
do -- matmul 193: int16[0, 4] @ float64[1, 4, 1]
  local a=(np.zeros({4,0},np.int16)).T
  local b=np.array({{{-0.75},{0.0},{0.75},{-0.75}}},np.float64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 193 dtype "..r.dtype)
  assert(close(r.shape,{1,0,1}),"matmul 193 shape")
  assert(close(r.strides,{0,0,0}),"matmul 193 strides")
  assert(close(r:tolist(),{{}}),"matmul 193 values")
end
do -- matmul 194: uint16[1, 4, 1] @ bool[0, 1, 1, 1]
  local a=np.array({{{4},{2},{0},{3}}},np.uint16)
  local b=np.zeros({0,1,1,1},np.bool)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint16","matmul 194 dtype "..r.dtype)
  assert(close(r.shape,{0,1,4,1}),"matmul 194 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 194 strides")
  assert(close(r:tolist(),{}),"matmul 194 values")
end
do -- matmul 195: int16[1, 2] @ int16[1, 2, 4]
  local a=np.array({{0,-4}},np.int16)
  local b=np.array({{{1,-3,2,-2},{3,-1,4,0}}},np.int16)
  local r=np.matmul(a,b)
  assert(r.dtype=="int16","matmul 195 dtype "..r.dtype)
  assert(close(r.shape,{1,1,4}),"matmul 195 shape")
  assert(close(r.strides,{8,8,2}),"matmul 195 strides")
  assert(close(r:tolist(),{{{-12,4,-16,0}}}),"matmul 195 values")
end
do -- matmul 196: uint16[1, 1] @ uint64[1, 0]
  local a=np.array({{3}},np.uint16)
  local b=np.zeros({1,0},np.uint64)
  local o=np.zeros({1,0},np.uint64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 196 out identity")
  assert(r.dtype=="uint64","matmul 196 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"matmul 196 shape")
  assert(close(r.strides,{0,0}),"matmul 196 out strides")
  assert(close(r:tolist(),{{}}),"matmul 196 values")
end
do -- matmul 197: uint8[1, 1, 3, 1] @ bool[1, 1, 1, 4]
  local a=np.array({{{{0},{3},{1}}}},np.uint8)
  local b=np.array({{{{false,true,true,false}}}},np.bool)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint8","matmul 197 dtype "..r.dtype)
  assert(close(r.shape,{1,1,3,4}),"matmul 197 shape")
  assert(close(r.strides,{12,12,4,1}),"matmul 197 strides")
  assert(close(r:tolist(),{{{{0,0,0,0},{0,3,3,0},{0,1,1,0}}}}),"matmul 197 values")
end
do -- matmul 198: int64[2, 4] @ bool[4, 4]
  local a=np.array({{-3,2,-2,3},{-1,4,0,-4}},np.int64)
  local b=np.array({{true,false,true,true},{false,true,true,false},{true,true,false,true},{true,false,true,true}},np.bool)
  local o=np.zeros({2,4},np.int64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 198 out identity")
  assert(r.dtype=="int64","matmul 198 dtype "..r.dtype)
  assert(close(r.shape,{2,4}),"matmul 198 shape")
  assert(close(r.strides,{32,8}),"matmul 198 out strides")
  assert(close(r:tolist(),{{-2,0,2,-2},{-5,4,-1,-5}}),"matmul 198 values")
end
do -- matmul 199: int32[3] @ float64[3]
  local a=np.array({-1,4,0},np.int32)
  local b=np.array({0.0,0.75,-0.75},np.float64)
  local o=np.zeros({},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 199 out identity")
  assert(r.dtype=="float64","matmul 199 dtype "..r.dtype)
  assert(close(r.shape,{}),"matmul 199 shape")
  assert(close(r.strides,{}),"matmul 199 out strides")
  assert(close(r:tolist(),3.0),"matmul 199 values")
end
do -- matmul 200: bool[2, 4] @ uint8[4, 2]
  local a=(np.array({{true,false},{true,true},{false,true},{true,false}},np.bool)).T
  local b=np.array({{2,0},{3,1},{4,2},{0,3}},np.uint8)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint8","matmul 200 dtype "..r.dtype)
  assert(close(r.shape,{2,2}),"matmul 200 shape")
  assert(close(r.strides,{2,1}),"matmul 200 strides")
  assert(close(r:tolist(),{{5,4},{7,3}}),"matmul 200 values")
end
do -- matmul 201: int32[4] @ int8[4, 4]
  local a=np.array({3,-1,4,0},np.int32)
  local b=np.array({{4,0,-4,1},{-3,2,-2,3},{-1,4,0,-4},{1,-3,2,-2}},np.int8)
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 201 dtype "..r.dtype)
  assert(close(r.shape,{4}),"matmul 201 shape")
  assert(close(r.strides,{4}),"matmul 201 strides")
  assert(close(r:tolist(),{11,14,-10,-16}),"matmul 201 values")
end
do -- matmul 202: float16[3] @ float16[3, 0]
  local a=np.array({-1.0,-0.25,0.5},np.float16)
  local b=(np.zeros({0,3},np.float16)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="float16","matmul 202 dtype "..r.dtype)
  assert(close(r.shape,{0}),"matmul 202 shape")
  assert(close(r.strides,{0}),"matmul 202 strides")
  assert(close(r:tolist(),{}),"matmul 202 values")
end
do -- matmul 203: bool[1, 2, 1, 0] @ int8[0, 1]
  local a=np.zeros({1,2,1,0},np.bool)
  local b=np.zeros({0,1},np.int8)
  local o=np.zeros({1,2,1,1},np.int8)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 203 out identity")
  assert(r.dtype=="int8","matmul 203 dtype "..r.dtype)
  assert(close(r.shape,{1,2,1,1}),"matmul 203 shape")
  assert(close(r.strides,{2,1,1,1}),"matmul 203 out strides")
  assert(close(r:tolist(),{{{{0}},{{0}}}}),"matmul 203 values")
end
do -- matmul 204: float64[2, 1] @ int16[1, 0]
  local a=np.array({{0.0},{0.75}},np.float64)
  local b=np.zeros({1,0},np.int16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 204 dtype "..r.dtype)
  assert(close(r.shape,{2,0}),"matmul 204 shape")
  assert(close(r.strides,{0,0}),"matmul 204 strides")
  assert(close(r:tolist(),{{},{}}),"matmul 204 values")
end
do -- matmul 205: float64[1, 2] @ float64[2]
  local a=np.array({{0.5,-1.0}},np.float64)
  local b=np.array({0.75,-0.75},np.float64)
  local o=np.zeros({1},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 205 out identity")
  assert(r.dtype=="float64","matmul 205 dtype "..r.dtype)
  assert(close(r.shape,{1}),"matmul 205 shape")
  assert(close(r.strides,{8}),"matmul 205 out strides")
  assert(close(r:tolist(),{1.125}),"matmul 205 values")
end
do -- matmul 206: int16[0] @ uint16[0, 4]
  local a=np.zeros({0},np.int16)
  local b=np.zeros({0,4},np.uint16)
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 206 dtype "..r.dtype)
  assert(close(r.shape,{4}),"matmul 206 shape")
  assert(close(r.strides,{4}),"matmul 206 strides")
  assert(close(r:tolist(),{0,0,0,0}),"matmul 206 values")
end
do -- matmul 207: float64[0, 3, 3, 1, 1] @ int8[1]
  local a=np.zeros({0,3,3,1,1},np.float64)
  local b=np.array({-2},np.int8)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 207 dtype "..r.dtype)
  assert(close(r.shape,{0,3,3,1}),"matmul 207 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 207 strides")
  assert(close(r:tolist(),{}),"matmul 207 values")
end
do -- matmul 208: int8[0] @ int8[0, 2]
  local a=np.zeros({0},np.int8)
  local b=np.zeros({0,2},np.int8)
  local r=np.matmul(a,b)
  assert(r.dtype=="int8","matmul 208 dtype "..r.dtype)
  assert(close(r.shape,{2}),"matmul 208 shape")
  assert(close(r.strides,{1}),"matmul 208 strides")
  assert(close(r:tolist(),{0,0}),"matmul 208 values")
end
do -- matmul 209: uint32[2, 1] @ float64[1, 0]
  local a=np.array({{4},{2}},np.uint32)
  local b=(np.zeros({0,1},np.float64)).T
  local o=np.zeros({2,0},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 209 out identity")
  assert(r.dtype=="float64","matmul 209 dtype "..r.dtype)
  assert(close(r.shape,{2,0}),"matmul 209 shape")
  assert(close(r.strides,{0,0}),"matmul 209 out strides")
  assert(close(r:tolist(),{{},{}}),"matmul 209 values")
end
do -- matmul 210: int8[1, 3] @ int8[3, 1]
  local a=np.array({{3,-1,4}},np.int8)
  local b=np.array({{4},{0},{-4}},np.int8)
  local r=np.matmul(a,b)
  assert(r.dtype=="int8","matmul 210 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"matmul 210 shape")
  assert(close(r.strides,{1,1}),"matmul 210 strides")
  assert(close(r:tolist(),{{-4}}),"matmul 210 values")
end
do -- matmul 211: float64[1, 3] @ uint32[1, 3, 2]
  local a=np.array({{-1.0,-0.25,0.5}},np.float64)
  local b=np.array({{{4,2},{0,3},{1,4}}},np.uint32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 211 dtype "..r.dtype)
  assert(close(r.shape,{1,1,2}),"matmul 211 shape")
  assert(close(r.strides,{16,16,8}),"matmul 211 strides")
  assert(close(r:tolist(),{{{-3.5,-0.75}}}),"matmul 211 values")
end
do -- matmul 212: int32[2, 4] @ float64[1, 4, 2]
  local a=np.array({{-2,3,-1,4},{0,-4,1,-3}},np.int32)
  local b=np.array({{{-0.25,0.5},{-1.0,-0.25},{0.5,-1.0},{-0.25,0.5}}},np.float64)
  local ob=np.zeros({2,2,1},np.float64)
  local o=ob.T
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 212 out identity")
  assert(r.dtype=="float64","matmul 212 dtype "..r.dtype)
  assert(close(r.shape,{1,2,2}),"matmul 212 shape")
  assert(close(r.strides,{8,8,16}),"matmul 212 out strides")
  assert(close(r:tolist(),{{{-4.0,1.25},{5.25,-1.5}}}),"matmul 212 values")
end
do -- matmul 213: uint32[2, 4] @ uint32[4, 4]
  local a=(np.array({{2,0},{3,1},{4,2},{0,3}},np.uint32)).T
  local b=np.array({{3,1,4,2},{0,3,1,4},{2,0,3,1},{4,2,0,3}},np.uint32)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint32","matmul 213 dtype "..r.dtype)
  assert(close(r.shape,{2,4}),"matmul 213 shape")
  assert(close(r.strides,{16,4}),"matmul 213 strides")
  assert(close(r:tolist(),{{14,11,23,20},{16,9,7,15}}),"matmul 213 values")
end
do -- matmul 214: uint64[2, 3, 0] @ int32[0, 2]
  local a=np.zeros({2,3,0},np.uint64)
  local b=np.zeros({0,2},np.int32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 214 dtype "..r.dtype)
  assert(close(r.shape,{2,3,2}),"matmul 214 shape")
  assert(close(r.strides,{48,16,8}),"matmul 214 strides")
  assert(close(r:tolist(),{{{0.0,0.0},{0.0,0.0},{0.0,0.0}},{{0.0,0.0},{0.0,0.0},{0.0,0.0}}}),"matmul 214 values")
end
do -- matmul 215: int16[1] @ uint16[1, 4]
  local a=np.array({4},np.int16)
  local b=np.array({{2,0,3,1}},np.uint16)
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 215 dtype "..r.dtype)
  assert(close(r.shape,{4}),"matmul 215 shape")
  assert(close(r.strides,{4}),"matmul 215 strides")
  assert(close(r:tolist(),{8,0,12,4}),"matmul 215 values")
end
do -- matmul 216: int32[2, 1, 4, 1] @ uint16[1, 1, 1]
  local a=(np.array({{{{-3,2}},{{-2,3}},{{-1,4}},{{0,-4}}}},np.int32)).T
  local b=np.array({{{4}}},np.uint16)
  local ob=np.zeros({1,4,1,2},np.int32)
  local o=ob.T
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 216 out identity")
  assert(r.dtype=="int32","matmul 216 dtype "..r.dtype)
  assert(close(r.shape,{2,1,4,1}),"matmul 216 shape")
  assert(close(r.strides,{4,8,8,32}),"matmul 216 out strides")
  assert(close(r:tolist(),{{{{-12},{-8},{-4},{0}}},{{{8},{12},{16},{-16}}}}),"matmul 216 values")
end
do -- matmul 217: int8[0, 1, 0] @ uint16[2, 1, 0, 2]
  local a=np.zeros({0,1,0},np.int8)
  local b=(np.zeros({2,0,1,2},np.uint16)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 217 dtype "..r.dtype)
  assert(close(r.shape,{2,0,1,2}),"matmul 217 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 217 strides")
  assert(close(r:tolist(),{{},{}}),"matmul 217 values")
end
do -- matmul 218: int32[3, 3] @ float32[3, 4]
  local a=(np.array({{1,-3,2},{-2,3,-1},{4,0,-4}},np.int32)).T
  local b=np.array({{0.5,-1.0,-0.25,0.5},{-1.0,-0.25,0.5,-1.0},{-0.25,0.5,-1.0,-0.25}},np.float32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 218 dtype "..r.dtype)
  assert(close(r.shape,{3,4}),"matmul 218 shape")
  assert(close(r.strides,{32,8}),"matmul 218 strides")
  assert(close(r:tolist(),{{1.5,1.5,-5.25,1.5},{-4.5,2.25,2.25,-4.5},{3.0,-3.75,3.0,3.0}}),"matmul 218 values")
end
do -- matmul 219: uint32[1, 0, 3] @ float32[3]
  local a=np.zeros({1,0,3},np.uint32)
  local b=np.array({1.0,-0.5,0.25},np.float32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 219 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"matmul 219 shape")
  assert(close(r.strides,{0,0}),"matmul 219 strides")
  assert(close(r:tolist(),{{}}),"matmul 219 values")
end
do -- matmul 220: float64[1, 1, 1, 0, 4] @ uint64[4, 4]
  local a=np.zeros({1,1,1,0,4},np.float64)
  local b=(np.array({{2,0,3,1},{4,2,0,3},{1,4,2,0},{3,1,4,2}},np.uint64)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 220 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,0,4}),"matmul 220 shape")
  assert(close(r.strides,{0,0,0,0,0}),"matmul 220 strides")
  assert(close(r:tolist(),{{{{}}}}),"matmul 220 values")
end
do -- matmul 221: uint64[3, 2, 2] @ float16[3, 2, 0]
  local a=np.array({{{3,1},{4,2}},{{0,3},{1,4}},{{2,0},{3,1}}},np.uint64)
  local b=np.zeros({3,2,0},np.float16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 221 dtype "..r.dtype)
  assert(close(r.shape,{3,2,0}),"matmul 221 shape")
  assert(close(r.strides,{0,0,0}),"matmul 221 strides")
  assert(close(r:tolist(),{{{},{}},{{},{}},{{},{}}}),"matmul 221 values")
end
do -- matmul 222: int16[2, 4] @ float32[4, 0]
  local a=np.array({{0,-4,1,-3},{2,-2,3,-1}},np.int16)
  local b=np.zeros({4,0},np.float32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 222 dtype "..r.dtype)
  assert(close(r.shape,{2,0}),"matmul 222 shape")
  assert(close(r.strides,{0,0}),"matmul 222 strides")
  assert(close(r:tolist(),{{},{}}),"matmul 222 values")
end
do -- matmul 223: bool[3, 2] @ float16[2, 2]
  local a=np.array({{false,true},{true,false},{true,true}},np.bool)
  local b=np.array({{0.75,-0.75},{0.0,0.75}},np.float16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float16","matmul 223 dtype "..r.dtype)
  assert(close(r.shape,{3,2}),"matmul 223 shape")
  assert(close(r.strides,{4,2}),"matmul 223 strides")
  assert(close(r:tolist(),{{0.0,0.75},{0.75,-0.75},{0.75,0.0}}),"matmul 223 values")
end
do -- matmul 224: int8[3, 0] @ int32[1, 0, 0]
  local a=(np.zeros({0,3},np.int8)).T
  local b=(np.zeros({0,0,1},np.int32)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 224 dtype "..r.dtype)
  assert(close(r.shape,{1,3,0}),"matmul 224 shape")
  assert(close(r.strides,{0,0,0}),"matmul 224 strides")
  assert(close(r:tolist(),{{{},{},{}}}),"matmul 224 values")
end
do -- matmul 225: uint32[1, 1, 3] @ float16[1, 1, 3, 3]
  local a=(np.array({{{1}},{{4}},{{2}}},np.uint32)).T
  local b=np.array({{{{-0.5,0.25,1.0},{-0.5,0.25,1.0},{-0.5,0.25,1.0}}}},np.float16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 225 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,3}),"matmul 225 shape")
  assert(close(r.strides,{24,24,24,8}),"matmul 225 strides")
  assert(close(r:tolist(),{{{{-3.5,1.75,7.0}}}}),"matmul 225 values")
end
do -- matmul 226: float64[3] @ bool[1, 3, 2]
  local a=np.array({-0.25,0.5,-1.0},np.float64)
  local b=np.array({{{true,true},{false,true},{true,false}}},np.bool)
  local o=np.zeros({1,2},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 226 out identity")
  assert(r.dtype=="float64","matmul 226 dtype "..r.dtype)
  assert(close(r.shape,{1,2}),"matmul 226 shape")
  assert(close(r.strides,{16,8}),"matmul 226 out strides")
  assert(close(r:tolist(),{{-1.25,0.25}}),"matmul 226 values")
end
do -- matmul 227: bool[1, 3, 2, 4] @ float32[3, 4, 4]
  local a=np.array({{{{true,false,true,true},{false,true,true,false}},{{true,true,false,true},{true,false,true,true}},{{false,true,true,false},{true,true,false,true}}}},np.bool)
  local b=np.array({{{0.5,-1.0,-0.25,0.5},{-1.0,-0.25,0.5,-1.0},{-0.25,0.5,-1.0,-0.25},{0.5,-1.0,-0.25,0.5}},{{-1.0,-0.25,0.5,-1.0},{-0.25,0.5,-1.0,-0.25},{0.5,-1.0,-0.25,0.5},{-1.0,-0.25,0.5,-1.0}},{{-0.25,0.5,-1.0,-0.25},{0.5,-1.0,-0.25,0.5},{-1.0,-0.25,0.5,-1.0},{-0.25,0.5,-1.0,-0.25}}},np.float32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 227 dtype "..r.dtype)
  assert(close(r.shape,{1,3,2,4}),"matmul 227 shape")
  assert(close(r.strides,{96,32,16,4}),"matmul 227 strides")
  assert(close(r:tolist(),{{{{0.75,-1.5,-1.5,0.75},{-1.25,0.25,-0.5,-1.25}},{{-2.25,0.0,0.0,-2.25},{-1.5,-1.5,0.75,-1.5}},{{-0.5,-1.25,0.25,-0.5},{0.0,0.0,-2.25,0.0}}}}),"matmul 227 values")
end
do -- matmul 228: int16[1, 2, 0, 0] @ uint32[3, 1, 1, 0, 2]
  local a=np.zeros({1,2,0,0},np.int16)
  local b=np.zeros({3,1,1,0,2},np.uint32)
  local r=np.matmul(a,b)
  assert(r.dtype=="int64","matmul 228 dtype "..r.dtype)
  assert(close(r.shape,{3,1,2,0,2}),"matmul 228 shape")
  assert(close(r.strides,{0,0,0,0,0}),"matmul 228 strides")
  assert(close(r:tolist(),{{{{},{}}},{{{},{}}},{{{},{}}}}),"matmul 228 values")
end
do -- matmul 229: float16[1, 2] @ float32[2, 0]
  local a=np.array({{-1.0,-0.25}},np.float16)
  local b=np.zeros({2,0},np.float32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 229 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"matmul 229 shape")
  assert(close(r.strides,{0,0}),"matmul 229 strides")
  assert(close(r:tolist(),{{}}),"matmul 229 values")
end
do -- matmul 230: float16[4] @ float64[4, 3]
  local a=np.array({-0.5,0.25,1.0,-0.5},np.float16)
  local b=np.array({{-0.25,0.5,-1.0},{-0.25,0.5,-1.0},{-0.25,0.5,-1.0},{-0.25,0.5,-1.0}},np.float64)
  local o=np.zeros({3},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 230 out identity")
  assert(r.dtype=="float64","matmul 230 dtype "..r.dtype)
  assert(close(r.shape,{3}),"matmul 230 shape")
  assert(close(r.strides,{8}),"matmul 230 out strides")
  assert(close(r:tolist(),{-0.0625,0.125,-0.25}),"matmul 230 values")
end
do -- matmul 231: uint8[0, 1] @ uint8[2, 1, 0]
  local a=(np.zeros({1,0},np.uint8)).T
  local b=np.zeros({2,1,0},np.uint8)
  local o=np.zeros({2,0,0},np.uint8)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 231 out identity")
  assert(r.dtype=="uint8","matmul 231 dtype "..r.dtype)
  assert(close(r.shape,{2,0,0}),"matmul 231 shape")
  assert(close(r.strides,{0,0,0}),"matmul 231 out strides")
  assert(close(r:tolist(),{{},{}}),"matmul 231 values")
end
do -- matmul 232: uint32[4, 3] @ int64[3]
  local a=np.array({{0,3,1},{4,2,0},{3,1,4},{2,0,3}},np.uint32)
  local b=np.array({3,-1,4},np.int64)
  local r=np.matmul(a,b)
  assert(r.dtype=="int64","matmul 232 dtype "..r.dtype)
  assert(close(r.shape,{4}),"matmul 232 shape")
  assert(close(r.strides,{8}),"matmul 232 strides")
  assert(close(r:tolist(),{1,10,24,18}),"matmul 232 values")
end
do -- matmul 233: int8[1, 1, 3] @ float32[1, 3, 4]
  local a=np.array({{{4,0,-4}}},np.int8)
  local b=np.array({{{-1.0,-0.25,0.5,-1.0},{-0.25,0.5,-1.0,-0.25},{0.5,-1.0,-0.25,0.5}}},np.float32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 233 dtype "..r.dtype)
  assert(close(r.shape,{1,1,4}),"matmul 233 shape")
  assert(close(r.strides,{16,16,4}),"matmul 233 strides")
  assert(close(r:tolist(),{{{-6.0,3.0,3.0,-6.0}}}),"matmul 233 values")
end
do -- matmul 234: int64[3, 1] @ int32[1, 2]
  local a=(np.array({{-3,2,-2}},np.int64)).T
  local b=np.array({{-2,3}},np.int32)
  local r=np.matmul(a,b)
  assert(r.dtype=="int64","matmul 234 dtype "..r.dtype)
  assert(close(r.shape,{3,2}),"matmul 234 shape")
  assert(close(r.strides,{16,8}),"matmul 234 strides")
  assert(close(r:tolist(),{{6,-9},{-4,6},{4,-6}}),"matmul 234 values")
end
do -- matmul 235: int32[1, 0, 4] @ uint8[4, 0]
  local a=np.zeros({1,0,4},np.int32)
  local b=np.zeros({4,0},np.uint8)
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 235 dtype "..r.dtype)
  assert(close(r.shape,{1,0,0}),"matmul 235 shape")
  assert(close(r.strides,{0,0,0}),"matmul 235 strides")
  assert(close(r:tolist(),{{}}),"matmul 235 values")
end
do -- matmul 236: uint16[1, 3] @ int32[3, 0]
  local a=np.array({{3,1,4}},np.uint16)
  local b=(np.zeros({0,3},np.int32)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 236 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"matmul 236 shape")
  assert(close(r.strides,{0,0}),"matmul 236 strides")
  assert(close(r:tolist(),{{}}),"matmul 236 values")
end
do -- matmul 237: int16[3, 3] @ uint64[3]
  local a=np.array({{3,-1,4},{0,-4,1},{-3,2,-2}},np.int16)
  local b=np.array({1,4,2},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 237 dtype "..r.dtype)
  assert(close(r.shape,{3}),"matmul 237 shape")
  assert(close(r.strides,{8}),"matmul 237 strides")
  assert(close(r:tolist(),{7.0,-14.0,1.0}),"matmul 237 values")
end
do -- matmul 238: uint64[1, 0, 2] @ float64[2, 4]
  local a=np.zeros({1,0,2},np.uint64)
  local b=np.array({{-0.75,0.0,0.75,-0.75},{0.0,0.75,-0.75,0.0}},np.float64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 238 dtype "..r.dtype)
  assert(close(r.shape,{1,0,4}),"matmul 238 shape")
  assert(close(r.strides,{0,0,0}),"matmul 238 strides")
  assert(close(r:tolist(),{{}}),"matmul 238 values")
end
do -- matmul 239: uint8[2] @ uint32[1, 2, 1]
  local a=np.array({4,2},np.uint8)
  local b=np.array({{{0},{3}}},np.uint32)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint32","matmul 239 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"matmul 239 shape")
  assert(close(r.strides,{4,4}),"matmul 239 strides")
  assert(close(r:tolist(),{{6}}),"matmul 239 values")
end
do -- matmul 240: uint16[2] @ int64[2, 4]
  local a=np.array({1,4},np.uint16)
  local b=np.array({{1,-3,2,-2},{3,-1,4,0}},np.int64)
  local r=np.matmul(a,b)
  assert(r.dtype=="int64","matmul 240 dtype "..r.dtype)
  assert(close(r.shape,{4}),"matmul 240 shape")
  assert(close(r.strides,{8}),"matmul 240 strides")
  assert(close(r:tolist(),{13,-7,18,-2}),"matmul 240 values")
end
do -- matmul 241: int64[3] @ float32[3]
  local a=np.array({2,-2,3},np.int64)
  local b=np.array({0.75,-0.75,0.0},np.float32)
  local o=np.zeros({},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 241 out identity")
  assert(r.dtype=="float64","matmul 241 dtype "..r.dtype)
  assert(close(r.shape,{}),"matmul 241 shape")
  assert(close(r.strides,{}),"matmul 241 out strides")
  assert(close(r:tolist(),3.0),"matmul 241 values")
end
do -- matmul 242: uint32[2, 4] @ float32[1, 4, 3]
  local a=np.array({{0,3,1,4},{2,0,3,1}},np.uint32)
  local b=np.array({{{-1.0,-0.25,0.5},{-1.0,-0.25,0.5},{-1.0,-0.25,0.5},{-1.0,-0.25,0.5}}},np.float32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 242 dtype "..r.dtype)
  assert(close(r.shape,{1,2,3}),"matmul 242 shape")
  assert(close(r.strides,{48,24,8}),"matmul 242 strides")
  assert(close(r:tolist(),{{{-8.0,-2.0,4.0},{-6.0,-1.5,3.0}}}),"matmul 242 values")
end
do -- matmul 243: uint16[2, 1, 4] @ uint64[4, 1]
  local a=np.array({{{2,0,3,1}},{{4,2,0,3}}},np.uint16)
  local b=np.array({{3},{1},{4},{2}},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint64","matmul 243 dtype "..r.dtype)
  assert(close(r.shape,{2,1,1}),"matmul 243 shape")
  assert(close(r.strides,{8,8,8}),"matmul 243 strides")
  assert(close(r:tolist(),{{{20}},{{20}}}),"matmul 243 values")
end
do -- matmul 244: int16[0, 2, 4] @ int16[4, 2]
  local a=(np.zeros({4,2,0},np.int16)).T
  local b=np.array({{0,-4},{1,-3},{2,-2},{3,-1}},np.int16)
  local r=np.matmul(a,b)
  assert(r.dtype=="int16","matmul 244 dtype "..r.dtype)
  assert(close(r.shape,{0,2,2}),"matmul 244 shape")
  assert(close(r.strides,{0,0,0}),"matmul 244 strides")
  assert(close(r:tolist(),{}),"matmul 244 values")
end
do -- matmul 245: int32[1, 1, 2, 4] @ uint16[4, 2]
  local a=np.array({{{{1,-3,2,-2},{3,-1,4,0}}}},np.int32)
  local b=np.array({{2,0},{3,1},{4,2},{0,3}},np.uint16)
  local o=np.zeros({1,1,2,2},np.int32)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 245 out identity")
  assert(r.dtype=="int32","matmul 245 dtype "..r.dtype)
  assert(close(r.shape,{1,1,2,2}),"matmul 245 shape")
  assert(close(r.strides,{16,16,8,4}),"matmul 245 out strides")
  assert(close(r:tolist(),{{{{1,-5},{19,7}}}}),"matmul 245 values")
end
do -- matmul 246: uint8[2] @ int16[2, 3]
  local a=np.array({3,1},np.uint8)
  local b=(np.array({{4,0},{-4,1},{-3,2}},np.int16)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="int16","matmul 246 dtype "..r.dtype)
  assert(close(r.shape,{3}),"matmul 246 shape")
  assert(close(r.strides,{2}),"matmul 246 strides")
  assert(close(r:tolist(),{12,-11,-7}),"matmul 246 values")
end
do -- matmul 247: float16[0] @ float64[1, 0, 4]
  local a=np.zeros({0},np.float16)
  local b=np.zeros({1,0,4},np.float64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 247 dtype "..r.dtype)
  assert(close(r.shape,{1,4}),"matmul 247 shape")
  assert(close(r.strides,{32,8}),"matmul 247 strides")
  assert(close(r:tolist(),{{0.0,0.0,0.0,0.0}}),"matmul 247 values")
end
do -- matmul 248: float64[3, 4, 0] @ float16[2, 1, 0, 4]
  local a=np.zeros({3,4,0},np.float64)
  local b=(np.zeros({4,0,1,2},np.float16)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 248 dtype "..r.dtype)
  assert(close(r.shape,{2,3,4,4}),"matmul 248 shape")
  assert(close(r.strides,{384,128,32,8}),"matmul 248 strides")
  assert(close(r:tolist(),{{{{0.0,0.0,0.0,0.0},{0.0,0.0,0.0,0.0},{0.0,0.0,0.0,0.0},{0.0,0.0,0.0,0.0}},{{0.0,0.0,0.0,0.0},{0.0,0.0,0.0,0.0},{0.0,0.0,0.0,0.0},{0.0,0.0,0.0,0.0}},{{0.0,0.0,0.0,0.0},{0.0,0.0,0.0,0.0},{0.0,0.0,0.0,0.0},{0.0,0.0,0.0,0.0}}},{{{0.0,0.0,0.0,0.0},{0.0,0.0,0.0,0.0},{0.0,0.0,0.0,0.0},{0.0,0.0,0.0,0.0}},{{0.0,0.0,0.0,0.0},{0.0,0.0,0.0,0.0},{0.0,0.0,0.0,0.0},{0.0,0.0,0.0,0.0}},{{0.0,0.0,0.0,0.0},{0.0,0.0,0.0,0.0},{0.0,0.0,0.0,0.0},{0.0,0.0,0.0,0.0}}}}),"matmul 248 values")
end
do -- matmul 249: uint8[4] @ bool[4, 3]
  local a=np.array({4,2,0,3},np.uint8)
  local b=np.array({{true,false,true},{true,false,true},{true,false,true},{true,false,true}},np.bool)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint8","matmul 249 dtype "..r.dtype)
  assert(close(r.shape,{3}),"matmul 249 shape")
  assert(close(r.strides,{1}),"matmul 249 strides")
  assert(close(r:tolist(),{9,0,9}),"matmul 249 values")
end
do -- matmul 250: int16[3, 0, 3, 2] @ int8[3, 1, 2, 4]
  local a=np.zeros({3,0,3,2},np.int16)
  local b=np.array({{{{3,-1,4,0},{-4,1,-3,2}}},{{{-2,3,-1,4},{0,-4,1,-3}}},{{{2,-2,3,-1},{4,0,-4,1}}}},np.int8)
  local r=np.matmul(a,b)
  assert(r.dtype=="int16","matmul 250 dtype "..r.dtype)
  assert(close(r.shape,{3,0,3,4}),"matmul 250 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 250 strides")
  assert(close(r:tolist(),{{},{},{}}),"matmul 250 values")
end
do -- matmul 251: uint64[3, 1] @ bool[1]
  local a=np.array({{3},{1},{4}},np.uint64)
  local b=np.array({false},np.bool)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint64","matmul 251 dtype "..r.dtype)
  assert(close(r.shape,{3}),"matmul 251 shape")
  assert(close(r.strides,{8}),"matmul 251 strides")
  assert(close(r:tolist(),{0,0,0}),"matmul 251 values")
end
do -- matmul 252: float32[3, 0] @ int64[0, 0, 2]
  local a=np.zeros({3,0},np.float32)
  local b=np.zeros({0,0,2},np.int64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 252 dtype "..r.dtype)
  assert(close(r.shape,{0,3,2}),"matmul 252 shape")
  assert(close(r.strides,{0,0,0}),"matmul 252 strides")
  assert(close(r:tolist(),{}),"matmul 252 values")
end
do -- matmul 253: int8[1, 4, 2] @ int16[2]
  local a=np.array({{{-1,4},{0,-4},{1,-3},{2,-2}}},np.int8)
  local b=np.array({0,-4},np.int16)
  local r=np.matmul(a,b)
  assert(r.dtype=="int16","matmul 253 dtype "..r.dtype)
  assert(close(r.shape,{1,4}),"matmul 253 shape")
  assert(close(r.strides,{8,2}),"matmul 253 strides")
  assert(close(r:tolist(),{{-16,16,12,8}}),"matmul 253 values")
end
do -- matmul 254: float32[4, 1] @ bool[1, 1]
  local a=np.array({{0.25},{1.0},{-0.5},{0.25}},np.float32)
  local b=np.array({{false}},np.bool)
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 254 dtype "..r.dtype)
  assert(close(r.shape,{4,1}),"matmul 254 shape")
  assert(close(r.strides,{4,4}),"matmul 254 strides")
  assert(close(r:tolist(),{{0.0},{0.0},{0.0},{0.0}}),"matmul 254 values")
end
do -- matmul 255: uint32[0, 1, 4, 3] @ bool[0, 2, 3, 0]
  local a=np.zeros({0,1,4,3},np.uint32)
  local b=np.zeros({0,2,3,0},np.bool)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint32","matmul 255 dtype "..r.dtype)
  assert(close(r.shape,{0,2,4,0}),"matmul 255 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 255 strides")
  assert(close(r:tolist(),{}),"matmul 255 values")
end
do -- matmul 256: float32[3, 3, 3] @ int16[3, 3]
  local a=np.array({{{-1.0,-0.25,0.5},{-1.0,-0.25,0.5},{-1.0,-0.25,0.5}},{{-1.0,-0.25,0.5},{-1.0,-0.25,0.5},{-1.0,-0.25,0.5}},{{-1.0,-0.25,0.5},{-1.0,-0.25,0.5},{-1.0,-0.25,0.5}}},np.float32)
  local b=np.array({{-3,2,-2},{3,-1,4},{0,-4,1}},np.int16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 256 dtype "..r.dtype)
  assert(close(r.shape,{3,3,3}),"matmul 256 shape")
  assert(close(r.strides,{36,12,4}),"matmul 256 strides")
  assert(close(r:tolist(),{{{2.25,-3.75,1.5},{2.25,-3.75,1.5},{2.25,-3.75,1.5}},{{2.25,-3.75,1.5},{2.25,-3.75,1.5},{2.25,-3.75,1.5}},{{2.25,-3.75,1.5},{2.25,-3.75,1.5},{2.25,-3.75,1.5}}}),"matmul 256 values")
end
do -- matmul 257: bool[1, 3, 2] @ uint8[2]
  local a=np.array({{{true,false},{true,true},{false,true}}},np.bool)
  local b=np.array({1,4},np.uint8)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint8","matmul 257 dtype "..r.dtype)
  assert(close(r.shape,{1,3}),"matmul 257 shape")
  assert(close(r.strides,{3,1}),"matmul 257 strides")
  assert(close(r:tolist(),{{1,5,4}}),"matmul 257 values")
end
do -- matmul 258: int64[0, 3] @ uint64[3, 2]
  local a=np.zeros({0,3},np.int64)
  local b=(np.array({{3,1,4},{2,0,3}},np.uint64)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 258 dtype "..r.dtype)
  assert(close(r.shape,{0,2}),"matmul 258 shape")
  assert(close(r.strides,{0,0}),"matmul 258 strides")
  assert(close(r:tolist(),{}),"matmul 258 values")
end
do -- matmul 259: uint16[0, 1] @ int8[1, 1, 1]
  local a=np.zeros({0,1},np.uint16)
  local b=np.array({{{3}}},np.int8)
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 259 dtype "..r.dtype)
  assert(close(r.shape,{1,0,1}),"matmul 259 shape")
  assert(close(r.strides,{0,0,0}),"matmul 259 strides")
  assert(close(r:tolist(),{{}}),"matmul 259 values")
end
do -- matmul 260: uint64[4] @ float32[4, 1]
  local a=np.array({1,4,2,0},np.uint64)
  local b=np.array({{-1.0},{-0.25},{0.5},{-1.0}},np.float32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 260 dtype "..r.dtype)
  assert(close(r.shape,{1}),"matmul 260 shape")
  assert(close(r.strides,{8}),"matmul 260 strides")
  assert(close(r:tolist(),{-1.0}),"matmul 260 values")
end
do -- matmul 261: uint8[0] @ int32[0, 2]
  local a=np.zeros({0},np.uint8)
  local b=(np.zeros({2,0},np.int32)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 261 dtype "..r.dtype)
  assert(close(r.shape,{2}),"matmul 261 shape")
  assert(close(r.strides,{4}),"matmul 261 strides")
  assert(close(r:tolist(),{0,0}),"matmul 261 values")
end
do -- matmul 262: uint64[1, 3] @ float32[3, 2]
  local a=np.array({{0,3,1}},np.uint64)
  local b=np.array({{0.0,0.75},{-0.75,0.0},{0.75,-0.75}},np.float32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 262 dtype "..r.dtype)
  assert(close(r.shape,{1,2}),"matmul 262 shape")
  assert(close(r.strides,{16,8}),"matmul 262 strides")
  assert(close(r:tolist(),{{-1.5,-0.75}}),"matmul 262 values")
end
do -- matmul 263: float64[4, 2] @ int32[1, 2, 0]
  local a=np.array({{0.25,1.0},{-0.5,0.25},{1.0,-0.5},{0.25,1.0}},np.float64)
  local b=np.zeros({1,2,0},np.int32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 263 dtype "..r.dtype)
  assert(close(r.shape,{1,4,0}),"matmul 263 shape")
  assert(close(r.strides,{0,0,0}),"matmul 263 strides")
  assert(close(r:tolist(),{{{},{},{},{}}}),"matmul 263 values")
end
do -- matmul 264: float16[0] @ uint64[0, 3]
  local a=np.zeros({0},np.float16)
  local b=np.zeros({0,3},np.uint64)
  local o=np.zeros({3},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 264 out identity")
  assert(r.dtype=="float64","matmul 264 dtype "..r.dtype)
  assert(close(r.shape,{3}),"matmul 264 shape")
  assert(close(r.strides,{8}),"matmul 264 out strides")
  assert(close(r:tolist(),{0.0,0.0,0.0}),"matmul 264 values")
end
do -- matmul 265: float32[1, 1] @ int8[1, 0]
  local a=np.array({{-1.0}},np.float32)
  local b=(np.zeros({0,1},np.int8)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 265 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"matmul 265 shape")
  assert(close(r.strides,{0,0}),"matmul 265 strides")
  assert(close(r:tolist(),{{}}),"matmul 265 values")
end
do -- matmul 266: uint16[3, 0] @ bool[0]
  local a=np.zeros({3,0},np.uint16)
  local b=np.zeros({0},np.bool)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint16","matmul 266 dtype "..r.dtype)
  assert(close(r.shape,{3}),"matmul 266 shape")
  assert(close(r.strides,{2}),"matmul 266 strides")
  assert(close(r:tolist(),{0,0,0}),"matmul 266 values")
end
do -- matmul 267: int8[0] @ float64[0]
  local a=np.zeros({0},np.int8)
  local b=np.zeros({0},np.float64)
  local r=np.matmul(a,b)
  assert(close(r,0.0),"matmul 267 scalar value")
end
do -- matmul 268: uint16[4] @ float16[1, 4, 3]
  local a=np.array({2,0,3,1},np.uint16)
  local b=np.array({{{0.75,-0.75,0.0},{0.75,-0.75,0.0},{0.75,-0.75,0.0},{0.75,-0.75,0.0}}},np.float16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 268 dtype "..r.dtype)
  assert(close(r.shape,{1,3}),"matmul 268 shape")
  assert(close(r.strides,{12,4}),"matmul 268 strides")
  assert(close(r:tolist(),{{4.5,-4.5,0.0}}),"matmul 268 values")
end
do -- matmul 269: uint16[4] @ uint8[4, 3]
  local a=np.array({4,2,0,3},np.uint16)
  local b=np.array({{0,3,1},{4,2,0},{3,1,4},{2,0,3}},np.uint8)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint16","matmul 269 dtype "..r.dtype)
  assert(close(r.shape,{3}),"matmul 269 shape")
  assert(close(r.strides,{2}),"matmul 269 strides")
  assert(close(r:tolist(),{14,16,13}),"matmul 269 values")
end
do -- matmul 270: int32[2, 3] @ float16[3]
  local a=np.array({{-3,2,-2},{3,-1,4}},np.int32)
  local b=np.array({-0.5,0.25,1.0},np.float16)
  local o=np.zeros({2},np.float64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 270 out identity")
  assert(r.dtype=="float64","matmul 270 dtype "..r.dtype)
  assert(close(r.shape,{2}),"matmul 270 shape")
  assert(close(r.strides,{8}),"matmul 270 out strides")
  assert(close(r:tolist(),{0.0,2.25}),"matmul 270 values")
end
do -- matmul 271: uint64[3, 4, 4] @ float16[4, 2]
  local a=np.array({{{3,1,4,2},{0,3,1,4},{2,0,3,1},{4,2,0,3}},{{1,4,2,0},{3,1,4,2},{0,3,1,4},{2,0,3,1}},{{4,2,0,3},{1,4,2,0},{3,1,4,2},{0,3,1,4}}},np.uint64)
  local b=(np.array({{0.0,0.75,-0.75,0.0},{0.75,-0.75,0.0,0.75}},np.float16)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 271 dtype "..r.dtype)
  assert(close(r.shape,{3,4,2}),"matmul 271 shape")
  assert(close(r.strides,{64,16,8}),"matmul 271 strides")
  assert(close(r:tolist(),{{{-2.25,3.0},{1.5,0.75},{-2.25,2.25},{1.5,3.75}},{{1.5,-2.25},{-2.25,3.0},{1.5,0.75},{-2.25,2.25}},{{1.5,3.75},{1.5,-2.25},{-2.25,3.0},{1.5,0.75}}}),"matmul 271 values")
end
do -- matmul 272: int64[1, 3] @ uint16[3, 1]
  local a=np.array({{1,-3,2}},np.int64)
  local b=np.array({{1},{4},{2}},np.uint16)
  local r=np.matmul(a,b)
  assert(r.dtype=="int64","matmul 272 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"matmul 272 shape")
  assert(close(r.strides,{8,8}),"matmul 272 strides")
  assert(close(r:tolist(),{{-7}}),"matmul 272 values")
end
do -- matmul 273: float32[3] @ float16[3, 3]
  local a=np.array({0.75,-0.75,0.0},np.float32)
  local b=np.array({{1.0,-0.5,0.25},{1.0,-0.5,0.25},{1.0,-0.5,0.25}},np.float16)
  local o=np.zeros({3},np.float32)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 273 out identity")
  assert(r.dtype=="float32","matmul 273 dtype "..r.dtype)
  assert(close(r.shape,{3}),"matmul 273 shape")
  assert(close(r.strides,{4}),"matmul 273 out strides")
  assert(close(r:tolist(),{0.0,0.0,0.0}),"matmul 273 values")
end
do -- matmul 274: bool[3, 0] @ uint8[1, 0, 0]
  local a=np.zeros({3,0},np.bool)
  local b=np.zeros({1,0,0},np.uint8)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint8","matmul 274 dtype "..r.dtype)
  assert(close(r.shape,{1,3,0}),"matmul 274 shape")
  assert(close(r.strides,{0,0,0}),"matmul 274 strides")
  assert(close(r:tolist(),{{{},{},{}}}),"matmul 274 values")
end
do -- matmul 275: uint16[1] @ uint64[0, 1, 1]
  local a=np.array({1},np.uint16)
  local b=np.zeros({0,1,1},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint64","matmul 275 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"matmul 275 shape")
  assert(close(r.strides,{0,0}),"matmul 275 strides")
  assert(close(r:tolist(),{}),"matmul 275 values")
end
do -- matmul 276: int32[1, 0, 4] @ float64[4, 4]
  local a=np.zeros({1,0,4},np.int32)
  local b=np.array({{0.25,1.0,-0.5,0.25},{1.0,-0.5,0.25,1.0},{-0.5,0.25,1.0,-0.5},{0.25,1.0,-0.5,0.25}},np.float64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 276 dtype "..r.dtype)
  assert(close(r.shape,{1,0,4}),"matmul 276 shape")
  assert(close(r.strides,{0,0,0}),"matmul 276 strides")
  assert(close(r:tolist(),{{}}),"matmul 276 values")
end
do -- matmul 277: uint32[3, 1, 1, 0, 4] @ int64[4]
  local a=np.zeros({3,1,1,0,4},np.uint32)
  local b=np.array({3,-1,4,0},np.int64)
  local ob=np.zeros({0,1,1,3},np.int64)
  local o=ob.T
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 277 out identity")
  assert(r.dtype=="int64","matmul 277 dtype "..r.dtype)
  assert(close(r.shape,{3,1,1,0}),"matmul 277 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 277 out strides")
  assert(close(r:tolist(),{{{{}}},{{{}}},{{{}}}}),"matmul 277 values")
end
do -- matmul 278: bool[1, 3] @ int64[1, 3, 0]
  local a=np.array({{true,false,true}},np.bool)
  local b=np.zeros({1,3,0},np.int64)
  local r=np.matmul(a,b)
  assert(r.dtype=="int64","matmul 278 dtype "..r.dtype)
  assert(close(r.shape,{1,1,0}),"matmul 278 shape")
  assert(close(r.strides,{0,0,0}),"matmul 278 strides")
  assert(close(r:tolist(),{{{}}}),"matmul 278 values")
end
do -- matmul 279: uint32[4] @ uint32[4, 4]
  local a=np.array({4,2,0,3},np.uint32)
  local b=(np.array({{0,3,1,4},{2,0,3,1},{4,2,0,3},{1,4,2,0}},np.uint32)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="uint32","matmul 279 dtype "..r.dtype)
  assert(close(r.shape,{4}),"matmul 279 shape")
  assert(close(r.strides,{4}),"matmul 279 strides")
  assert(close(r:tolist(),{18,11,29,12}),"matmul 279 values")
end
do -- matmul 280: int8[0, 0, 4] @ uint16[4, 3]
  local a=np.zeros({0,0,4},np.int8)
  local b=np.array({{2,0,3},{1,4,2},{0,3,1},{4,2,0}},np.uint16)
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 280 dtype "..r.dtype)
  assert(close(r.shape,{0,0,3}),"matmul 280 shape")
  assert(close(r.strides,{0,0,0}),"matmul 280 strides")
  assert(close(r:tolist(),{}),"matmul 280 values")
end
do -- matmul 281: int8[3] @ int16[3, 2]
  local a=np.array({1,-3,2},np.int8)
  local b=np.array({{2,-2},{3,-1},{4,0}},np.int16)
  local r=np.matmul(a,b)
  assert(r.dtype=="int16","matmul 281 dtype "..r.dtype)
  assert(close(r.shape,{2}),"matmul 281 shape")
  assert(close(r.strides,{2}),"matmul 281 strides")
  assert(close(r:tolist(),{1,1}),"matmul 281 values")
end
do -- matmul 282: float16[0, 1, 1, 4] @ uint8[1, 0, 2, 4, 2]
  local a=np.zeros({0,1,1,4},np.float16)
  local b=np.zeros({1,0,2,4,2},np.uint8)
  local r=np.matmul(a,b)
  assert(r.dtype=="float16","matmul 282 dtype "..r.dtype)
  assert(close(r.shape,{1,0,2,1,2}),"matmul 282 shape")
  assert(close(r.strides,{0,0,0,0,0}),"matmul 282 strides")
  assert(close(r:tolist(),{{}}),"matmul 282 values")
end
do -- matmul 283: uint16[2, 3, 4] @ int32[4, 0]
  local a=np.array({{{2,0,3,1},{4,2,0,3},{1,4,2,0}},{{3,1,4,2},{0,3,1,4},{2,0,3,1}}},np.uint16)
  local b=np.zeros({4,0},np.int32)
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 283 dtype "..r.dtype)
  assert(close(r.shape,{2,3,0}),"matmul 283 shape")
  assert(close(r.strides,{0,0,0}),"matmul 283 strides")
  assert(close(r:tolist(),{{{},{},{}},{{},{},{}}}),"matmul 283 values")
end
do -- matmul 284: bool[2] @ uint8[0, 2, 1]
  local a=np.array({true,false},np.bool)
  local b=(np.zeros({1,2,0},np.uint8)).T
  local r=np.matmul(a,b)
  assert(r.dtype=="uint8","matmul 284 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"matmul 284 shape")
  assert(close(r.strides,{0,0}),"matmul 284 strides")
  assert(close(r:tolist(),{}),"matmul 284 values")
end
do -- matmul 285: bool[0, 3, 0] @ uint32[0, 3]
  local a=np.zeros({0,3,0},np.bool)
  local b=np.zeros({0,3},np.uint32)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint32","matmul 285 dtype "..r.dtype)
  assert(close(r.shape,{0,3,3}),"matmul 285 shape")
  assert(close(r.strides,{0,0,0}),"matmul 285 strides")
  assert(close(r:tolist(),{}),"matmul 285 values")
end
do -- matmul 286: float32[2, 1] @ int16[1, 4]
  local a=(np.array({{0.5,-1.0}},np.float32)).T
  local b=np.array({{3,-1,4,0}},np.int16)
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 286 dtype "..r.dtype)
  assert(close(r.shape,{2,4}),"matmul 286 shape")
  assert(close(r.strides,{16,4}),"matmul 286 strides")
  assert(close(r:tolist(),{{1.5,-0.5,2.0,0.0},{-3.0,1.0,-4.0,0.0}}),"matmul 286 values")
end
do -- matmul 287: uint32[4, 2] @ int32[2, 1]
  local a=np.array({{0,3},{1,4},{2,0},{3,1}},np.uint32)
  local b=np.array({{-4},{1}},np.int32)
  local r=np.matmul(a,b)
  assert(r.dtype=="int64","matmul 287 dtype "..r.dtype)
  assert(close(r.shape,{4,1}),"matmul 287 shape")
  assert(close(r.strides,{8,8}),"matmul 287 strides")
  assert(close(r:tolist(),{{3},{0},{-8},{-11}}),"matmul 287 values")
end
do -- matmul 288: float64[3, 0] @ int64[0, 4]
  local a=np.zeros({3,0},np.float64)
  local b=np.zeros({0,4},np.int64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 288 dtype "..r.dtype)
  assert(close(r.shape,{3,4}),"matmul 288 shape")
  assert(close(r.strides,{32,8}),"matmul 288 strides")
  assert(close(r:tolist(),{{0.0,0.0,0.0,0.0},{0.0,0.0,0.0,0.0},{0.0,0.0,0.0,0.0}}),"matmul 288 values")
end
do -- matmul 289: bool[4] @ uint8[4, 0]
  local a=np.array({false,true,true,false},np.bool)
  local b=np.zeros({4,0},np.uint8)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint8","matmul 289 dtype "..r.dtype)
  assert(close(r.shape,{0}),"matmul 289 shape")
  assert(close(r.strides,{0}),"matmul 289 strides")
  assert(close(r:tolist(),{}),"matmul 289 values")
end
do -- matmul 290: int64[1, 2, 2, 3] @ uint64[3]
  local a=np.array({{{{1,-3,2},{-2,3,-1}},{{4,0,-4},{1,-3,2}}}},np.int64)
  local b=np.array({2,0,3},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 290 dtype "..r.dtype)
  assert(close(r.shape,{1,2,2}),"matmul 290 shape")
  assert(close(r.strides,{32,16,8}),"matmul 290 strides")
  assert(close(r:tolist(),{{{8.0,-7.0},{-4.0,8.0}}}),"matmul 290 values")
end
do -- matmul 291: int32[2, 1, 4, 3] @ float64[3, 4]
  local a=np.array({{{{3,-1,4},{0,-4,1},{-3,2,-2},{3,-1,4}}},{{{0,-4,1},{-3,2,-2},{3,-1,4},{0,-4,1}}}},np.int32)
  local b=np.array({{1.0,-0.5,0.25,1.0},{-0.5,0.25,1.0,-0.5},{0.25,1.0,-0.5,0.25}},np.float64)
  local r=np.matmul(a,b)
  assert(r.dtype=="float64","matmul 291 dtype "..r.dtype)
  assert(close(r.shape,{2,1,4,4}),"matmul 291 shape")
  assert(close(r.strides,{128,128,32,8}),"matmul 291 strides")
  assert(close(r:tolist(),{{{{4.5,2.25,-2.25,4.5},{2.25,0.0,-4.5,2.25},{-4.5,0.0,2.25,-4.5},{4.5,2.25,-2.25,4.5}}},{{{2.25,0.0,-4.5,2.25},{-4.5,0.0,2.25,-4.5},{4.5,2.25,-2.25,4.5},{2.25,0.0,-4.5,2.25}}}}),"matmul 291 values")
end
do -- matmul 292: uint16[1, 1] @ int8[1, 2]
  local a=(np.array({{0}},np.uint16)).T
  local b=(np.array({{-3},{2}},np.int8)).T
  local ob=np.zeros({2,1},np.int32)
  local o=ob.T
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 292 out identity")
  assert(r.dtype=="int32","matmul 292 dtype "..r.dtype)
  assert(close(r.shape,{1,2}),"matmul 292 shape")
  assert(close(r.strides,{4,4}),"matmul 292 out strides")
  assert(close(r:tolist(),{{0,0}}),"matmul 292 values")
end
do -- matmul 293: uint64[4, 2] @ uint64[2, 1]
  local a=(np.array({{2,0,3,1},{4,2,0,3}},np.uint64)).T
  local b=np.array({{3},{1}},np.uint64)
  local r=np.matmul(a,b)
  assert(r.dtype=="uint64","matmul 293 dtype "..r.dtype)
  assert(close(r.shape,{4,1}),"matmul 293 shape")
  assert(close(r.strides,{8,8}),"matmul 293 strides")
  assert(close(r:tolist(),{{10},{2},{9},{6}}),"matmul 293 values")
end
do -- matmul 294: uint8[2, 3] @ uint64[3, 1]
  local a=np.array({{4,2,0},{3,1,4}},np.uint8)
  local b=np.array({{0},{3},{1}},np.uint64)
  local o=np.zeros({2,1},np.uint64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 294 out identity")
  assert(r.dtype=="uint64","matmul 294 dtype "..r.dtype)
  assert(close(r.shape,{2,1}),"matmul 294 shape")
  assert(close(r.strides,{8,8}),"matmul 294 out strides")
  assert(close(r:tolist(),{{6},{7}}),"matmul 294 values")
end
do -- matmul 295: uint8[1, 1, 3] @ float32[3, 0]
  local a=np.array({{{1,4,2}}},np.uint8)
  local b=np.zeros({3,0},np.float32)
  local r=np.matmul(a,b)
  assert(r.dtype=="float32","matmul 295 dtype "..r.dtype)
  assert(close(r.shape,{1,1,0}),"matmul 295 shape")
  assert(close(r.strides,{0,0,0}),"matmul 295 strides")
  assert(close(r:tolist(),{{{}}}),"matmul 295 values")
end
do -- matmul 296: uint16[3, 1, 1, 3] @ int16[3, 3, 2]
  local a=np.array({{{{3,1,4}}},{{{2,0,3}}},{{{1,4,2}}}},np.uint16)
  local b=np.array({{{-4,1},{-3,2},{-2,3}},{{-1,4},{0,-4},{1,-3}},{{2,-2},{3,-1},{4,0}}},np.int16)
  local r=np.matmul(a,b)
  assert(r.dtype=="int32","matmul 296 dtype "..r.dtype)
  assert(close(r.shape,{3,3,1,2}),"matmul 296 shape")
  assert(close(r.strides,{24,8,8,4}),"matmul 296 strides")
  assert(close(r:tolist(),{{{{-23,17}},{{1,-4}},{{25,-7}}},{{{-14,11}},{{1,-1}},{{16,-4}}},{{{-20,15}},{{1,-18}},{{22,-6}}}}),"matmul 296 values")
end
do -- matmul 297: int32[3, 4] @ uint16[3, 4, 2]
  local a=np.array({{-3,2,-2,3},{-1,4,0,-4},{1,-3,2,-2}},np.int32)
  local b=np.array({{{1,4},{2,0},{3,1},{4,2}},{{0,3},{1,4},{2,0},{3,1}},{{4,2},{0,3},{1,4},{2,0}}},np.uint16)
  local o=np.zeros({3,3,2},np.int32)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 297 out identity")
  assert(r.dtype=="int32","matmul 297 dtype "..r.dtype)
  assert(close(r.shape,{3,3,2}),"matmul 297 shape")
  assert(close(r.strides,{24,8,4}),"matmul 297 out strides")
  assert(close(r:tolist(),{{{7,-8},{-9,-12},{-7,2}},{{7,2},{-8,9},{-5,-11}},{{-8,-8},{-12,10},{2,1}}}),"matmul 297 values")
end
do -- matmul 298: int64[1, 3, 0, 3] @ int32[3, 4]
  local a=np.zeros({1,3,0,3},np.int64)
  local b=np.array({{0,-4,1,-3},{2,-2,3,-1},{4,0,-4,1}},np.int32)
  local o=np.zeros({1,3,0,4},np.int64)
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 298 out identity")
  assert(r.dtype=="int64","matmul 298 dtype "..r.dtype)
  assert(close(r.shape,{1,3,0,4}),"matmul 298 shape")
  assert(close(r.strides,{0,0,0,0}),"matmul 298 out strides")
  assert(close(r:tolist(),{{{},{},{}}}),"matmul 298 values")
end
do -- matmul 299: float32[3, 3] @ int8[3, 3]
  local a=np.array({{0.25,1.0,-0.5},{0.25,1.0,-0.5},{0.25,1.0,-0.5}},np.float32)
  local b=np.array({{2,-2,3},{-1,4,0},{-4,1,-3}},np.int8)
  local ob=np.zeros({3,3},np.float64)
  local o=ob.T
  local r=np.matmul(a,b,{out=o})
  assert(r==o,"matmul 299 out identity")
  assert(r.dtype=="float64","matmul 299 dtype "..r.dtype)
  assert(close(r.shape,{3,3}),"matmul 299 shape")
  assert(close(r.strides,{8,24}),"matmul 299 out strides")
  assert(close(r:tolist(),{{1.5,3.0,2.25},{1.5,3.0,2.25},{1.5,3.0,2.25}}),"matmul 299 values")
end
do local a=np.array({{1,2},{3,4}},np.int64); local r=np.matmul(a,a); assert(close(r:tolist(),{{7,10},{15,22}}),"matmul matrix values") end
do local v=np.array({1,2},np.int64); assert(np.matmul(v,v)==5,"matmul vector scalar") end
do local v=np.array({true,false},np.bool); local m=np.array({{true,false},{false,true}},np.bool); local r=np.matmul(v,m); assert(close(r:tolist(),{true,false}),"matmul bool") end
do local a=np.array({{1,2},{3,4}},np.int64); np.matmul(a,a,{out=a}); assert(close(a:tolist(),{{7,10},{15,22}}),"matmul overlap out") end
do local ok,err=pcall(function() return np.matmul(np.ones({2,3}),np.ones({4,2})) end); assert(not ok and tostring(err):find("core dimension mismatch",1,true),"matmul mismatch error") end
do local o=np.zeros({2,2},np.int32); local ok,err=pcall(function() return np.matmul(np.ones({2,2},np.float64),np.ones({2,2},np.float64),{out=o}) end); assert(not ok and tostring(err):find("same_kind",1,true),"matmul out cast error") end
print('matmul differential: 306 cases ok')
