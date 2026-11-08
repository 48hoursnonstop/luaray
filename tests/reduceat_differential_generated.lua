local np=require("luaray_core")
local function close(a,b)
  if type(a)~=type(b) then return false end
  if type(a)~="table" then
    if type(a)=="number" then
      if a~=a and b~=b then return true end
      if a==b then return true end
      return math.abs(a-b)<=math.max(3e-5,math.abs(b)*1e-5)
    end
    return a==b
  end
  if #a~=#b then return false end
  for i=1,#a do if not close(a[i],b[i]) then return false end end
  return true
end
-- Generated against development NumPy 2.3.5.
do -- reduceat 0: add uint16 [1, 3] axis=0 indices=[0, 0, 0, 0]
  local a=np.array({{0,3,6}},np.uint16)
  local r=np.add_reduceat(a,{-1,1,1,-1},{axis=1})
  assert(r.dtype=="uint64","reduceat 0 dtype "..r.dtype)
  assert(close(r.shape,{4,3}),"reduceat 0 shape")
  assert(close(r.strides,{24,8}),"reduceat 0 strides")
  assert(close(r:tolist(),{{0,3,6},{0,3,6},{0,3,6},{0,3,6}}),"reduceat 0 values")
end
do -- reduceat 1: add bool [3, 4, 1] axis=2 indices=[0, 0]
  local a=np.array({{{true},{false},{true},{true}},{{false},{true},{true},{false}},{{true},{true},{false},{true}}},np.bool)
  local r=np.add_reduceat(a,{1,-1},{axis=3})
  assert(r.dtype=="int64","reduceat 1 dtype "..r.dtype)
  assert(close(r.shape,{3,4,2}),"reduceat 1 shape")
  assert(close(r.strides,{64,16,8}),"reduceat 1 strides")
  assert(close(r:tolist(),{{{1,1},{0,0},{1,1},{1,1}},{{0,0},{1,1},{1,1},{0,0}},{{1,1},{1,1},{0,0},{1,1}}}),"reduceat 1 values")
end
do -- reduceat 2: multiply int64 [0, 1, 1] axis=2 indices=[0, 0, 0]
  local a=np.zeros({0,1,1},np.int64)
  local r=np.multiply_reduceat(a,{1,1,1},{axis=3})
  assert(r.dtype=="int64","reduceat 2 dtype "..r.dtype)
  assert(close(r.shape,{0,1,3}),"reduceat 2 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 2 strides")
  assert(close(r:tolist(),{}),"reduceat 2 values")
end
do -- reduceat 3: add float64 [2] axis=0 indices=[]
  local a=np.array({-0.375,0.75},np.float64)
  local r=np.add_reduceat(a,{},{axis=1,dtype=np.uint8})
  assert(r.dtype=="uint8","reduceat 3 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 3 shape")
  assert(close(r.strides,{0}),"reduceat 3 strides")
  assert(close(r:tolist(),{}),"reduceat 3 values")
end
do -- reduceat 4: multiply int8 [3, 4, 0, 1] axis=2 indices=[]
  local a=np.zeros({3,4,0,1},np.int8)
  local o=np.zeros({3,4,0,1},np.uint32)
  local r=np.multiply_reduceat(a,{},{axis=3,dtype=np.uint32,out=o})
  assert(r==o,"reduceat 4 out identity")
  assert(r.dtype=="uint32","reduceat 4 dtype "..r.dtype)
  assert(close(r.shape,{3,4,0,1}),"reduceat 4 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 4 strides")
  assert(close(r:tolist(),{{{},{},{},{}},{{},{},{},{}},{{},{},{},{}}}),"reduceat 4 values")
end
do -- reduceat 5: multiply uint32 [4, 2, 1, 0] axis=2 indices=[0, 0, 0]
  local a=np.zeros({4,2,1,0},np.uint32)
  local r=np.multiply_reduceat(a,{1,1,1},{axis=3})
  assert(r.dtype=="uint64","reduceat 5 dtype "..r.dtype)
  assert(close(r.shape,{4,2,3,0}),"reduceat 5 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 5 strides")
  assert(close(r:tolist(),{{{{},{},{}},{{},{},{}}},{{{},{},{}},{{},{},{}}},{{{},{},{}},{{},{},{}}},{{{},{},{}},{{},{},{}}}}),"reduceat 5 values")
end
do -- reduceat 6: multiply float16 [4, 3, 0, 1] axis=2 indices=[]
  local a=np.zeros({4,3,0,1},np.float16)
  local o=np.zeros({4,3,0,1},np.uint32)
  local r=np.multiply_reduceat(a,{},{axis=3,out=o})
  assert(r==o,"reduceat 6 out identity")
  assert(r.dtype=="uint32","reduceat 6 dtype "..r.dtype)
  assert(close(r.shape,{4,3,0,1}),"reduceat 6 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 6 strides")
  assert(close(r:tolist(),{{{},{},{}},{{},{},{}},{{},{},{}},{{},{},{}}}),"reduceat 6 values")
end
do -- reduceat 7: multiply int64 [0] axis=0 indices=[]
  local a=np.zeros({0},np.int64)
  local o=np.zeros({0},np.int64)
  local r=np.multiply_reduceat(a,{},{axis=1,out=o})
  assert(r==o,"reduceat 7 out identity")
  assert(r.dtype=="int64","reduceat 7 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 7 shape")
  assert(close(r.strides,{0}),"reduceat 7 strides")
  assert(close(r:tolist(),{}),"reduceat 7 values")
end
do -- reduceat 8: multiply uint16 [2, 4] axis=1 indices=[3, 3, 0]
  local a=np.array({{1,2,3,4},{1,2,3,4}},np.uint16)
  local r=np.multiply_reduceat(a,{-1,4,-4},{axis=2})
  assert(r.dtype=="uint64","reduceat 8 dtype "..r.dtype)
  assert(close(r.shape,{2,3}),"reduceat 8 shape")
  assert(close(r.strides,{24,8}),"reduceat 8 strides")
  assert(close(r:tolist(),{{4,4,24},{4,4,24}}),"reduceat 8 values")
end
do -- reduceat 9: add int32 [0, 4] axis=1 indices=[2]
  local a=np.zeros({0,4},np.int32)
  local r=np.add_reduceat(a,{3},{axis=2})
  assert(r.dtype=="int64","reduceat 9 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"reduceat 9 shape")
  assert(close(r.strides,{0,0}),"reduceat 9 strides")
  assert(close(r:tolist(),{}),"reduceat 9 values")
end
do -- reduceat 10: multiply int8 [0, 4] axis=1 indices=[2, 2, 0, 3]
  local a=np.zeros({0,4},np.int8)
  local r=np.multiply_reduceat(a,{3,3,1,4},{axis=2})
  assert(r.dtype=="int64","reduceat 10 dtype "..r.dtype)
  assert(close(r.shape,{0,4}),"reduceat 10 shape")
  assert(close(r.strides,{0,0}),"reduceat 10 strides")
  assert(close(r:tolist(),{}),"reduceat 10 values")
end
do -- reduceat 11: add uint16 [4] axis=0 indices=[1, 0, 0]
  local a=np.array({3,6,1,4},np.uint16)
  local o=np.zeros({3},np.int32)
  local r=np.add_reduceat(a,{2,1,1},{axis=1,dtype=np.int16,out=o})
  assert(r==o,"reduceat 11 out identity")
  assert(r.dtype=="int32","reduceat 11 dtype "..r.dtype)
  assert(close(r.shape,{3}),"reduceat 11 shape")
  assert(close(r.strides,{4}),"reduceat 11 strides")
  assert(close(r:tolist(),{6,3,14}),"reduceat 11 values")
end
do -- reduceat 12: add float32 [3] axis=0 indices=[0, 2, 0, 2, 2]
  local a=np.array({-0.375,0.75,-1.5},np.float32)
  local r=np.add_reduceat(a,{1,3,-3,3,-1},{axis=1})
  assert(r.dtype=="float32","reduceat 12 dtype "..r.dtype)
  assert(close(r.shape,{5}),"reduceat 12 shape")
  assert(close(r.strides,{4}),"reduceat 12 strides")
  assert(close(r:tolist(),{0.375,-1.5,0.375,-1.5,-1.5}),"reduceat 12 values")
end
do -- reduceat 13: add int32 [4, 0, 0, 2] axis=1 indices=[]
  local a=np.zeros({4,0,0,2},np.int32)
  local o=np.zeros({4,0,0,2},np.int8)
  local r=np.add_reduceat(a,{},{axis=2,dtype=np.int8,out=o})
  assert(r==o,"reduceat 13 out identity")
  assert(r.dtype=="int8","reduceat 13 dtype "..r.dtype)
  assert(close(r.shape,{4,0,0,2}),"reduceat 13 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 13 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"reduceat 13 values")
end
do -- reduceat 14: multiply float64 [2] axis=0 indices=[0, 0]
  local a=np.array({1.4,0.6},np.float64)
  local o=np.zeros({2},np.uint8)
  local r=np.multiply_reduceat(a,{1,1},{axis=1,out=o})
  assert(r==o,"reduceat 14 out identity")
  assert(r.dtype=="uint8","reduceat 14 dtype "..r.dtype)
  assert(close(r.shape,{2}),"reduceat 14 shape")
  assert(close(r.strides,{1}),"reduceat 14 strides")
  assert(close(r:tolist(),{1,0}),"reduceat 14 values")
end
do -- reduceat 15: multiply int32 [0, 3, 0] axis=2 indices=[]
  local a=np.zeros({0,3,0},np.int32)
  local o=np.zeros({0,3,0},np.uint32)
  local r=np.multiply_reduceat(a,{},{axis=3,dtype=np.uint16,out=o})
  assert(r==o,"reduceat 15 out identity")
  assert(r.dtype=="uint32","reduceat 15 dtype "..r.dtype)
  assert(close(r.shape,{0,3,0}),"reduceat 15 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 15 strides")
  assert(close(r:tolist(),{}),"reduceat 15 values")
end
do -- reduceat 16: add float32 [4, 0, 1, 0] axis=3 indices=[]
  local a=np.zeros({4,0,1,0},np.float32)
  local o=np.zeros({4,0,1,0},np.int64)
  local r=np.add_reduceat(a,{},{axis=4,out=o})
  assert(r==o,"reduceat 16 out identity")
  assert(r.dtype=="int64","reduceat 16 dtype "..r.dtype)
  assert(close(r.shape,{4,0,1,0}),"reduceat 16 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 16 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"reduceat 16 values")
end
do -- reduceat 17: add int32 [4, 2] axis=0 indices=[3, 2]
  local a=np.array({{1,4},{-4,-1},{2,5},{-3,0}},np.int32)
  local r=np.add_reduceat(a,{4,3},{axis=1})
  assert(r.dtype=="int64","reduceat 17 dtype "..r.dtype)
  assert(close(r.shape,{2,2}),"reduceat 17 shape")
  assert(close(r.strides,{16,8}),"reduceat 17 strides")
  assert(close(r:tolist(),{{-3,0},{-1,5}}),"reduceat 17 values")
end
do -- reduceat 18: add float32 [1, 1, 0] axis=0 indices=[0, 0, 0]
  local a=np.zeros({1,1,0},np.float32)
  local r=np.add_reduceat(a,{-1,1,1},{axis=1})
  assert(r.dtype=="float32","reduceat 18 dtype "..r.dtype)
  assert(close(r.shape,{3,1,0}),"reduceat 18 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 18 strides")
  assert(close(r:tolist(),{{{}},{{}},{{}}}),"reduceat 18 values")
end
do -- reduceat 19: multiply float32 [4, 4, 2, 0] axis=0 indices=[]
  local a=np.zeros({4,4,2,0},np.float32)
  local o=np.zeros({0,4,2,0},np.int8)
  local r=np.multiply_reduceat(a,{},{axis=1,out=o})
  assert(r==o,"reduceat 19 out identity")
  assert(r.dtype=="int8","reduceat 19 dtype "..r.dtype)
  assert(close(r.shape,{0,4,2,0}),"reduceat 19 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 19 strides")
  assert(close(r:tolist(),{}),"reduceat 19 values")
end
do -- reduceat 20: multiply int64 [2] axis=0 indices=[0, 0, 0, 1, 1]
  local a=np.array({-2,-1},np.int64)
  local r=np.multiply_reduceat(a,{-2,-2,-2,2,2},{axis=1})
  assert(r.dtype=="int64","reduceat 20 dtype "..r.dtype)
  assert(close(r.shape,{5}),"reduceat 20 shape")
  assert(close(r.strides,{8}),"reduceat 20 strides")
  assert(close(r:tolist(),{-2,-2,-2,-1,-1}),"reduceat 20 values")
end
do -- reduceat 21: add uint32 [1, 0, 0] axis=0 indices=[]
  local a=np.zeros({1,0,0},np.uint32)
  local o=np.zeros({0,0,0},np.int8)
  local r=np.add_reduceat(a,{},{axis=1,dtype=np.bool,out=o})
  assert(r==o,"reduceat 21 out identity")
  assert(r.dtype=="int8","reduceat 21 dtype "..r.dtype)
  assert(close(r.shape,{0,0,0}),"reduceat 21 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 21 strides")
  assert(close(r:tolist(),{}),"reduceat 21 values")
end
do -- reduceat 22: multiply uint32 [4, 4, 1, 2] axis=3 indices=[0, 0, 1, 0, 1]
  local a=(np.array({{{{3,4,1,2},{3,4,1,2},{3,4,1,2},{3,4,1,2}}},{{{3,4,1,2},{3,4,1,2},{3,4,1,2},{3,4,1,2}}}},np.uint32)).T
  local r=np.multiply_reduceat(a,{1,-2,2,-2,2},{axis=4})
  assert(r.dtype=="uint64","reduceat 22 dtype "..r.dtype)
  assert(close(r.shape,{4,4,1,5}),"reduceat 22 shape")
  assert(close(r.strides,{40,160,40,8}),"reduceat 22 strides")
  assert(close(r:tolist(),{{{{3,3,3,3,3}},{{3,3,3,3,3}},{{3,3,3,3,3}},{{3,3,3,3,3}}},{{{4,4,4,4,4}},{{4,4,4,4,4}},{{4,4,4,4,4}},{{4,4,4,4,4}}},{{{1,1,1,1,1}},{{1,1,1,1,1}},{{1,1,1,1,1}},{{1,1,1,1,1}}},{{{2,2,2,2,2}},{{2,2,2,2,2}},{{2,2,2,2,2}},{{2,2,2,2,2}}}}),"reduceat 22 values")
end
do -- reduceat 23: add uint32 [1, 4, 4] axis=0 indices=[]
  local a=np.array({{{7,2,5,0},{3,6,1,4},{7,2,5,0},{3,6,1,4}}},np.uint32)
  local r=np.add_reduceat(a,{},{axis=1,dtype=np.uint32})
  assert(r.dtype=="uint32","reduceat 23 dtype "..r.dtype)
  assert(close(r.shape,{0,4,4}),"reduceat 23 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 23 strides")
  assert(close(r:tolist(),{}),"reduceat 23 values")
end
do -- reduceat 24: add int16 [2, 4, 4] axis=2 indices=[2, 3, 0, 0, 2]
  local a=(np.array({{{-3,0},{3,-5},{-2,1},{4,-4}},{{-1,2},{5,-3},{0,3},{-5,-2}},{{1,4},{-4,-1},{2,5},{-3,0}},{{3,-5},{-2,1},{4,-4},{-1,2}}},np.int16)).T
  local r=np.add_reduceat(a,{-2,-1,-4,1,-2},{axis=3,dtype=np.float64})
  assert(r.dtype=="float64","reduceat 24 dtype "..r.dtype)
  assert(close(r.shape,{2,4,5}),"reduceat 24 shape")
  assert(close(r.strides,{40,80,8}),"reduceat 24 strides")
  assert(close(r:tolist(),{{{1.0,3.0,-3.0,-4.0,4.0},{-4.0,-2.0,3.0,8.0,-6.0},{2.0,4.0,-2.0,-2.0,6.0},{-3.0,-1.0,4.0,-1.0,-4.0}},{{4.0,-5.0,0.0,2.0,-1.0},{-1.0,1.0,-5.0,-8.0,0.0},{5.0,-4.0,1.0,4.0,1.0},{0.0,2.0,-4.0,-6.0,2.0}}}),"reduceat 24 values")
end
do -- reduceat 25: add uint8 [0] axis=0 indices=[]
  local a=np.zeros({0},np.uint8)
  local o=np.zeros({0},np.float32)
  local r=np.add_reduceat(a,{},{axis=1,dtype=np.float16,out=o})
  assert(r==o,"reduceat 25 out identity")
  assert(r.dtype=="float32","reduceat 25 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 25 shape")
  assert(close(r.strides,{0}),"reduceat 25 strides")
  assert(close(r:tolist(),{}),"reduceat 25 values")
end
do -- reduceat 26: multiply float16 [4, 1, 2] axis=2 indices=[0, 1, 0, 1, 1]
  local a=(np.array({{{0.8,1.0,1.2,1.4}},{{0.6,0.8,1.0,1.2}}},np.float16)).T
  local o=np.zeros({4,1,5},np.uint16)
  local r=np.multiply_reduceat(a,{1,-1,-2,2,2},{axis=3,out=o})
  assert(r==o,"reduceat 26 out identity")
  assert(r.dtype=="uint16","reduceat 26 dtype "..r.dtype)
  assert(close(r.shape,{4,1,5}),"reduceat 26 shape")
  assert(close(r.strides,{10,10,2}),"reduceat 26 strides")
  assert(close(r:tolist(),{{{0,0,0,0,0}},{{1,0,1,0,0}},{{1,1,1,1,1}},{{1,1,1,1,1}}}),"reduceat 26 values")
end
do -- reduceat 27: multiply bool [0, 3] axis=1 indices=[2, 0, 1, 0, 1, 2]
  local a=np.zeros({0,3},np.bool)
  local r=np.multiply_reduceat(a,{-1,1,2,1,2,3},{axis=2})
  assert(r.dtype=="int64","reduceat 27 dtype "..r.dtype)
  assert(close(r.shape,{0,6}),"reduceat 27 shape")
  assert(close(r.strides,{0,0}),"reduceat 27 strides")
  assert(close(r:tolist(),{}),"reduceat 27 values")
end
do -- reduceat 28: multiply int16 [4] axis=0 indices=[0, 3, 0, 2, 2, 2]
  local a=np.array({1,2,-2,-1},np.int16)
  local r=np.multiply_reduceat(a,{1,-1,1,3,-2,3},{axis=1})
  assert(r.dtype=="int64","reduceat 28 dtype "..r.dtype)
  assert(close(r.shape,{6}),"reduceat 28 shape")
  assert(close(r.strides,{8}),"reduceat 28 strides")
  assert(close(r:tolist(),{-4,-1,2,-2,-2,2}),"reduceat 28 values")
end
do -- reduceat 29: multiply int16 [2, 2, 4, 4] axis=3 indices=[3, 0, 0]
  local a=(np.array({{{{2,-2},{-1,0}},{{1,2},{-2,-1}},{{0,1},{2,-2}},{{-1,0},{1,2}}},{{{-2,-1},{0,1}},{{2,-2},{-1,0}},{{1,2},{-2,-1}},{{0,1},{2,-2}}},{{{-1,0},{1,2}},{{-2,-1},{0,1}},{{2,-2},{-1,0}},{{1,2},{-2,-1}}},{{{0,1},{2,-2}},{{-1,0},{1,2}},{{-2,-1},{0,1}},{{2,-2},{-1,0}}}},np.int16)).T
  local r=np.multiply_reduceat(a,{-1,-4,-4},{axis=4})
  assert(r.dtype=="int64","reduceat 29 dtype "..r.dtype)
  assert(close(r.shape,{2,2,4,3}),"reduceat 29 shape")
  assert(close(r.strides,{24,48,96,8}),"reduceat 29 strides")
  assert(close(r:tolist(),{{{{0,2,0},{-1,1,4},{-2,0,0},{2,-1,0}},{{2,-1,0},{1,-2,0},{0,2,0},{-1,1,4}}},{{{1,-2,0},{0,2,0},{-1,1,4},{-2,0,0}},{{-2,0,0},{2,-1,0},{1,-2,0},{0,2,0}}}}),"reduceat 29 values")
end
do -- reduceat 30: multiply float64 [3] axis=0 indices=[]
  local a=np.array({0.6,0.8,1.0},np.float64)
  local r=np.multiply_reduceat(a,{},{axis=1})
  assert(r.dtype=="float64","reduceat 30 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 30 shape")
  assert(close(r.strides,{0}),"reduceat 30 strides")
  assert(close(r:tolist(),{}),"reduceat 30 values")
end
do -- reduceat 31: add int8 [4] axis=0 indices=[1, 2, 2]
  local a=np.array({4,-4,-1,2},np.int8)
  local r=np.add_reduceat(a,{2,-2,3},{axis=1})
  assert(r.dtype=="int64","reduceat 31 dtype "..r.dtype)
  assert(close(r.shape,{3}),"reduceat 31 shape")
  assert(close(r.strides,{8}),"reduceat 31 strides")
  assert(close(r:tolist(),{-4,-1,1}),"reduceat 31 values")
end
do -- reduceat 32: add uint32 [4, 2, 0] axis=0 indices=[]
  local a=np.zeros({4,2,0},np.uint32)
  local r=np.add_reduceat(a,{},{axis=1,dtype=np.uint16})
  assert(r.dtype=="uint16","reduceat 32 dtype "..r.dtype)
  assert(close(r.shape,{0,2,0}),"reduceat 32 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 32 strides")
  assert(close(r:tolist(),{}),"reduceat 32 values")
end
do -- reduceat 33: add int64 [0, 2, 1] axis=2 indices=[0, 0]
  local a=np.zeros({0,2,1},np.int64)
  local r=np.add_reduceat(a,{1,1},{axis=3})
  assert(r.dtype=="int64","reduceat 33 dtype "..r.dtype)
  assert(close(r.shape,{0,2,2}),"reduceat 33 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 33 strides")
  assert(close(r:tolist(),{}),"reduceat 33 values")
end
do -- reduceat 34: multiply int32 [4] axis=0 indices=[2, 2, 0, 0]
  local a=np.array({2,-2,-1,0},np.int32)
  local r=np.multiply_reduceat(a,{3,3,1,1},{axis=1})
  assert(r.dtype=="int64","reduceat 34 dtype "..r.dtype)
  assert(close(r.shape,{4}),"reduceat 34 shape")
  assert(close(r.strides,{8}),"reduceat 34 strides")
  assert(close(r:tolist(),{-1,-1,2,0}),"reduceat 34 values")
end
do -- reduceat 35: add uint16 [4, 2, 1, 1] axis=3 indices=[0]
  local a=np.array({{{{3}},{{6}}},{{{1}},{{4}}},{{{7}},{{2}}},{{{5}},{{0}}}},np.uint16)
  local r=np.add_reduceat(a,{1},{axis=4})
  assert(r.dtype=="uint64","reduceat 35 dtype "..r.dtype)
  assert(close(r.shape,{4,2,1,1}),"reduceat 35 shape")
  assert(close(r.strides,{16,8,8,8}),"reduceat 35 strides")
  assert(close(r:tolist(),{{{{3}},{{6}}},{{{1}},{{4}}},{{{7}},{{2}}},{{{5}},{{0}}}}),"reduceat 35 values")
end
do -- reduceat 36: multiply bool [2, 0] axis=0 indices=[]
  local a=np.zeros({2,0},np.bool)
  local r=np.multiply_reduceat(a,{},{axis=1})
  assert(r.dtype=="int64","reduceat 36 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"reduceat 36 shape")
  assert(close(r.strides,{0,0}),"reduceat 36 strides")
  assert(close(r:tolist(),{}),"reduceat 36 values")
end
do -- reduceat 37: multiply uint32 [4, 0, 3, 3] axis=1 indices=[]
  local a=np.zeros({4,0,3,3},np.uint32)
  local r=np.multiply_reduceat(a,{},{axis=2,dtype=np.int64})
  assert(r.dtype=="int64","reduceat 37 dtype "..r.dtype)
  assert(close(r.shape,{4,0,3,3}),"reduceat 37 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 37 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"reduceat 37 values")
end
do -- reduceat 38: multiply bool [1, 2] axis=1 indices=[0, 0]
  local a=np.array({{true,true}},np.bool)
  local r=np.multiply_reduceat(a,{-2,-2},{axis=2,dtype=np.int64})
  assert(r.dtype=="int64","reduceat 38 dtype "..r.dtype)
  assert(close(r.shape,{1,2}),"reduceat 38 shape")
  assert(close(r.strides,{16,8}),"reduceat 38 strides")
  assert(close(r:tolist(),{{1,1}}),"reduceat 38 values")
end
do -- reduceat 39: add int8 [0, 3] axis=0 indices=[]
  local a=np.zeros({0,3},np.int8)
  local r=np.add_reduceat(a,{},{axis=1,dtype=np.uint64})
  assert(r.dtype=="uint64","reduceat 39 dtype "..r.dtype)
  assert(close(r.shape,{0,3}),"reduceat 39 shape")
  assert(close(r.strides,{0,0}),"reduceat 39 strides")
  assert(close(r:tolist(),{}),"reduceat 39 values")
end
do -- reduceat 40: multiply float64 [1, 0] axis=0 indices=[0, 0, 0]
  local a=np.zeros({1,0},np.float64)
  local r=np.multiply_reduceat(a,{1,1,-1},{axis=1})
  assert(r.dtype=="float64","reduceat 40 dtype "..r.dtype)
  assert(close(r.shape,{3,0}),"reduceat 40 shape")
  assert(close(r.strides,{0,0}),"reduceat 40 strides")
  assert(close(r:tolist(),{{},{},{}}),"reduceat 40 values")
end
do -- reduceat 41: multiply float64 [3, 1, 1, 4] axis=1 indices=[0, 0, 0]
  local a=np.array({{{{0.8,1.0,1.2,1.4}}},{{{0.6,0.8,1.0,1.2}}},{{{1.4,0.6,0.8,1.0}}}},np.float64)
  local r=np.multiply_reduceat(a,{1,1,-1},{axis=2})
  assert(r.dtype=="float64","reduceat 41 dtype "..r.dtype)
  assert(close(r.shape,{3,3,1,4}),"reduceat 41 shape")
  assert(close(r.strides,{96,32,32,8}),"reduceat 41 strides")
  assert(close(r:tolist(),{{{{0.8,1.0,1.2,1.4}},{{0.8,1.0,1.2,1.4}},{{0.8,1.0,1.2,1.4}}},{{{0.6,0.8,1.0,1.2}},{{0.6,0.8,1.0,1.2}},{{0.6,0.8,1.0,1.2}}},{{{1.4,0.6,0.8,1.0}},{{1.4,0.6,0.8,1.0}},{{1.4,0.6,0.8,1.0}}}}),"reduceat 41 values")
end
do -- reduceat 42: add bool [3, 3] axis=0 indices=[2, 0, 2, 1]
  local a=np.array({{false,true,true},{false,true,true},{false,true,true}},np.bool)
  local r=np.add_reduceat(a,{-1,1,3,2},{axis=1})
  assert(r.dtype=="int64","reduceat 42 dtype "..r.dtype)
  assert(close(r.shape,{4,3}),"reduceat 42 shape")
  assert(close(r.strides,{24,8}),"reduceat 42 strides")
  assert(close(r:tolist(),{{0,1,1},{0,2,2},{0,1,1},{0,2,2}}),"reduceat 42 values")
end
do -- reduceat 43: multiply float32 [0, 1, 0, 4] axis=2 indices=[]
  local a=np.zeros({0,1,0,4},np.float32)
  local o=np.zeros({0,1,0,4},np.int64)
  local r=np.multiply_reduceat(a,{},{axis=3,dtype=np.int32,out=o})
  assert(r==o,"reduceat 43 out identity")
  assert(r.dtype=="int64","reduceat 43 dtype "..r.dtype)
  assert(close(r.shape,{0,1,0,4}),"reduceat 43 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 43 strides")
  assert(close(r:tolist(),{}),"reduceat 43 values")
end
do -- reduceat 44: add int8 [0, 4] axis=1 indices=[0, 3, 0, 3, 2, 1]
  local a=np.zeros({0,4},np.int8)
  local r=np.add_reduceat(a,{-4,4,-4,4,-2,2},{axis=2})
  assert(r.dtype=="int64","reduceat 44 dtype "..r.dtype)
  assert(close(r.shape,{0,6}),"reduceat 44 shape")
  assert(close(r.strides,{0,0}),"reduceat 44 strides")
  assert(close(r:tolist(),{}),"reduceat 44 values")
end
do -- reduceat 45: add uint16 [1, 1, 3, 4] axis=2 indices=[2, 2, 2, 0]
  local a=np.array({{{{5,0,3,6},{1,4,7,2},{5,0,3,6}}}},np.uint16)
  local o=np.zeros({1,1,4,4},np.float32)
  local r=np.add_reduceat(a,{3,3,3,1},{axis=3,dtype=np.int32,out=o})
  assert(r==o,"reduceat 45 out identity")
  assert(r.dtype=="float32","reduceat 45 dtype "..r.dtype)
  assert(close(r.shape,{1,1,4,4}),"reduceat 45 shape")
  assert(close(r.strides,{64,64,16,4}),"reduceat 45 strides")
  assert(close(r:tolist(),{{{{5.0,0.0,3.0,6.0},{5.0,0.0,3.0,6.0},{5.0,0.0,3.0,6.0},{11.0,4.0,13.0,14.0}}}}),"reduceat 45 values")
end
do -- reduceat 46: multiply float32 [4, 3] axis=1 indices=[0, 0]
  local a=(np.array({{0.8,1.0,1.2,1.4},{0.6,0.8,1.0,1.2},{1.4,0.6,0.8,1.0}},np.float32)).T
  local r=np.multiply_reduceat(a,{-3,1},{axis=2})
  assert(r.dtype=="float32","reduceat 46 dtype "..r.dtype)
  assert(close(r.shape,{4,2}),"reduceat 46 shape")
  assert(close(r.strides,{8,4}),"reduceat 46 strides")
  assert(close(r:tolist(),{{0.800000011920929,0.671999990940094},{1.0,0.48000001907348633},{1.2000000476837158,0.9600000381469727},{1.399999976158142,1.6800000667572021}}),"reduceat 46 values")
end
do -- reduceat 47: multiply int32 [4, 4] axis=0 indices=[1, 0, 1]
  local a=np.array({{0,1,2,-2},{-1,0,1,2},{-2,-1,0,1},{2,-2,-1,0}},np.int32)
  local r=np.multiply_reduceat(a,{2,1,2},{axis=1})
  assert(r.dtype=="int64","reduceat 47 dtype "..r.dtype)
  assert(close(r.shape,{3,4}),"reduceat 47 shape")
  assert(close(r.strides,{32,8}),"reduceat 47 strides")
  assert(close(r:tolist(),{{-1,0,1,2},{0,1,2,-2},{4,0,0,0}}),"reduceat 47 values")
end
do -- reduceat 48: add bool [2, 2] axis=0 indices=[0]
  local a=(np.array({{false,true},{true,false}},np.bool)).T
  local r=np.add_reduceat(a,{1},{axis=1})
  assert(r.dtype=="int64","reduceat 48 dtype "..r.dtype)
  assert(close(r.shape,{1,2}),"reduceat 48 shape")
  assert(close(r.strides,{16,8}),"reduceat 48 strides")
  assert(close(r:tolist(),{{1,1}}),"reduceat 48 values")
end
do -- reduceat 49: multiply bool [4, 3, 3] axis=2 indices=[0, 0, 0, 0, 1, 1]
  local a=np.array({{{true,false,true},{true,false,true},{true,false,true}},{{true,false,true},{true,false,true},{true,false,true}},{{true,false,true},{true,false,true},{true,false,true}},{{true,false,true},{true,false,true},{true,false,true}}},np.bool)
  local r=np.multiply_reduceat(a,{1,1,-3,1,2,2},{axis=3,dtype=np.bool})
  assert(r.dtype=="bool","reduceat 49 dtype "..r.dtype)
  assert(close(r.shape,{4,3,6}),"reduceat 49 shape")
  assert(close(r.strides,{18,6,1}),"reduceat 49 strides")
  assert(close(r:tolist(),{{{true,true,true,true,false,false},{true,true,true,true,false,false},{true,true,true,true,false,false}},{{true,true,true,true,false,false},{true,true,true,true,false,false},{true,true,true,true,false,false}},{{true,true,true,true,false,false},{true,true,true,true,false,false},{true,true,true,true,false,false}},{{true,true,true,true,false,false},{true,true,true,true,false,false},{true,true,true,true,false,false}}}),"reduceat 49 values")
end
do -- reduceat 50: multiply float64 [4, 3] axis=1 indices=[1, 1, 2, 1]
  local a=np.array({{0.6,0.8,1.0},{1.2,1.4,0.6},{0.8,1.0,1.2},{1.4,0.6,0.8}},np.float64)
  local r=np.multiply_reduceat(a,{2,-2,3,2},{axis=2})
  assert(r.dtype=="float64","reduceat 50 dtype "..r.dtype)
  assert(close(r.shape,{4,4}),"reduceat 50 shape")
  assert(close(r.strides,{32,8}),"reduceat 50 strides")
  assert(close(r:tolist(),{{0.8,0.8,1.0,0.8},{1.4,1.4,0.6,0.84},{1.0,1.0,1.2,1.2},{0.6,0.6,0.8,0.48}}),"reduceat 50 values")
end
do -- reduceat 51: add uint8 [2, 3] axis=0 indices=[0, 0, 1]
  local a=np.array({{3,6,1},{4,7,2}},np.uint8)
  local r=np.add_reduceat(a,{1,1,-1},{axis=1})
  assert(r.dtype=="uint64","reduceat 51 dtype "..r.dtype)
  assert(close(r.shape,{3,3}),"reduceat 51 shape")
  assert(close(r.strides,{24,8}),"reduceat 51 strides")
  assert(close(r:tolist(),{{3,6,1},{3,6,1},{4,7,2}}),"reduceat 51 values")
end
do -- reduceat 52: add int16 [2, 2, 0] axis=0 indices=[0, 1, 0]
  local a=np.zeros({2,2,0},np.int16)
  local r=np.add_reduceat(a,{1,2,1},{axis=1})
  assert(r.dtype=="int64","reduceat 52 dtype "..r.dtype)
  assert(close(r.shape,{3,2,0}),"reduceat 52 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 52 strides")
  assert(close(r:tolist(),{{{},{}},{{},{}},{{},{}}}),"reduceat 52 values")
end
do -- reduceat 53: add uint64 [4, 0] axis=0 indices=[3, 3, 3, 2]
  local a=np.zeros({4,0},np.uint64)
  local r=np.add_reduceat(a,{4,4,4,3},{axis=1})
  assert(r.dtype=="uint64","reduceat 53 dtype "..r.dtype)
  assert(close(r.shape,{4,0}),"reduceat 53 shape")
  assert(close(r.strides,{0,0}),"reduceat 53 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"reduceat 53 values")
end
do -- reduceat 54: add float32 [0, 1, 1] axis=0 indices=[]
  local a=np.zeros({0,1,1},np.float32)
  local r=np.add_reduceat(a,{},{axis=1})
  assert(r.dtype=="float32","reduceat 54 dtype "..r.dtype)
  assert(close(r.shape,{0,1,1}),"reduceat 54 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 54 strides")
  assert(close(r:tolist(),{}),"reduceat 54 values")
end
do -- reduceat 55: add int8 [4] axis=0 indices=[]
  local a=np.array({-5,-2,1,4},np.int8)
  local r=np.add_reduceat(a,{},{axis=1})
  assert(r.dtype=="int64","reduceat 55 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 55 shape")
  assert(close(r.strides,{0}),"reduceat 55 strides")
  assert(close(r:tolist(),{}),"reduceat 55 values")
end
do -- reduceat 56: multiply uint32 [1, 4, 1] axis=0 indices=[0]
  local a=np.array({{{1},{2},{3},{4}}},np.uint32)
  local r=np.multiply_reduceat(a,{-1},{axis=1})
  assert(r.dtype=="uint64","reduceat 56 dtype "..r.dtype)
  assert(close(r.shape,{1,4,1}),"reduceat 56 shape")
  assert(close(r.strides,{32,8,8}),"reduceat 56 strides")
  assert(close(r:tolist(),{{{1},{2},{3},{4}}}),"reduceat 56 values")
end
do -- reduceat 57: multiply uint16 [4, 3, 2] axis=0 indices=[2, 1, 1, 1]
  local a=np.array({{{2,3},{4,1},{2,3}},{{4,1},{2,3},{4,1}},{{2,3},{4,1},{2,3}},{{4,1},{2,3},{4,1}}},np.uint16)
  local r=np.multiply_reduceat(a,{3,2,2,2},{axis=1})
  assert(r.dtype=="uint64","reduceat 57 dtype "..r.dtype)
  assert(close(r.shape,{4,3,2}),"reduceat 57 shape")
  assert(close(r.strides,{48,16,8}),"reduceat 57 strides")
  assert(close(r:tolist(),{{{2,3},{4,1},{2,3}},{{4,1},{2,3},{4,1}},{{4,1},{2,3},{4,1}},{{32,3},{16,9},{32,3}}}),"reduceat 57 values")
end
do -- reduceat 58: add float32 [2] axis=0 indices=[1, 0, 0, 0, 1]
  local a=np.array({0.0,1.125},np.float32)
  local r=np.add_reduceat(a,{-1,-2,1,1,2},{axis=1})
  assert(r.dtype=="float32","reduceat 58 dtype "..r.dtype)
  assert(close(r.shape,{5}),"reduceat 58 shape")
  assert(close(r.strides,{4}),"reduceat 58 strides")
  assert(close(r:tolist(),{1.125,0.0,0.0,0.0,1.125}),"reduceat 58 values")
end
do -- reduceat 59: add int64 [0, 1, 2] axis=2 indices=[0, 0, 1]
  local a=np.zeros({0,1,2},np.int64)
  local r=np.add_reduceat(a,{1,1,2},{axis=3})
  assert(r.dtype=="int64","reduceat 59 dtype "..r.dtype)
  assert(close(r.shape,{0,1,3}),"reduceat 59 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 59 strides")
  assert(close(r:tolist(),{}),"reduceat 59 values")
end
do -- reduceat 60: multiply float16 [3] axis=0 indices=[2, 2]
  local a=np.array({0.6,0.8,1.0},np.float16)
  local r=np.multiply_reduceat(a,{-1,-1},{axis=1})
  assert(r.dtype=="float16","reduceat 60 dtype "..r.dtype)
  assert(close(r.shape,{2}),"reduceat 60 shape")
  assert(close(r.strides,{2}),"reduceat 60 strides")
  assert(close(r:tolist(),{1.0,1.0}),"reduceat 60 values")
end
do -- reduceat 61: multiply uint8 [1, 2, 3, 2] axis=3 indices=[1, 0, 1, 1]
  local a=(np.array({{{{2},{3}},{{4},{1}},{{2},{3}}},{{{4},{1}},{{2},{3}},{{4},{1}}}},np.uint8)).T
  local r=np.multiply_reduceat(a,{2,1,2,2},{axis=4})
  assert(r.dtype=="uint64","reduceat 61 dtype "..r.dtype)
  assert(close(r.shape,{1,2,3,4}),"reduceat 61 shape")
  assert(close(r.strides,{192,32,64,8}),"reduceat 61 strides")
  assert(close(r:tolist(),{{{{4,2,4,4},{2,4,2,2},{4,2,4,4}},{{1,3,1,1},{3,1,3,3},{1,3,1,1}}}}),"reduceat 61 values")
end
do -- reduceat 62: add int32 [3, 1] axis=0 indices=[1, 0, 1, 0]
  local a=np.array({{2},{5},{-3}},np.int32)
  local r=np.add_reduceat(a,{2,1,-2,1},{axis=1})
  assert(r.dtype=="int64","reduceat 62 dtype "..r.dtype)
  assert(close(r.shape,{4,1}),"reduceat 62 shape")
  assert(close(r.strides,{8,8}),"reduceat 62 strides")
  assert(close(r:tolist(),{{5},{2},{5},{4}}),"reduceat 62 values")
end
do -- reduceat 63: add float32 [1, 3] axis=1 indices=[1, 1]
  local a=(np.array({{-1.5},{-0.375},{0.75}},np.float32)).T
  local r=np.add_reduceat(a,{-2,2},{axis=2,dtype=np.bool})
  assert(r.dtype=="bool","reduceat 63 dtype "..r.dtype)
  assert(close(r.shape,{1,2}),"reduceat 63 shape")
  assert(close(r.strides,{2,1}),"reduceat 63 strides")
  assert(close(r:tolist(),{{true,true}}),"reduceat 63 values")
end
do -- reduceat 64: add uint64 [4, 2] axis=1 indices=[1, 1, 0]
  local a=(np.array({{0,3,6,1},{4,7,2,5}},np.uint64)).T
  local r=np.add_reduceat(a,{2,2,1},{axis=2})
  assert(r.dtype=="uint64","reduceat 64 dtype "..r.dtype)
  assert(close(r.shape,{4,3}),"reduceat 64 shape")
  assert(close(r.strides,{24,8}),"reduceat 64 strides")
  assert(close(r:tolist(),{{4,4,4},{7,7,10},{2,2,8},{5,5,6}}),"reduceat 64 values")
end
do -- reduceat 65: add float64 [2] axis=0 indices=[1, 1]
  local a=np.array({-0.75,0.375},np.float64)
  local o=np.zeros({2},np.int8)
  local r=np.add_reduceat(a,{2,2},{axis=1,out=o})
  assert(r==o,"reduceat 65 out identity")
  assert(r.dtype=="int8","reduceat 65 dtype "..r.dtype)
  assert(close(r.shape,{2}),"reduceat 65 shape")
  assert(close(r.strides,{1}),"reduceat 65 strides")
  assert(close(r:tolist(),{0,0}),"reduceat 65 values")
end
do -- reduceat 66: add int64 [4, 1, 4] axis=0 indices=[3, 1, 3, 2, 1]
  local a=(np.array({{{-5,-2,1,4}},{{-4,-1,2,5}},{{-3,0,3,-5}},{{-2,1,4,-4}}},np.int64)).T
  local r=np.add_reduceat(a,{4,-3,4,3,-3},{axis=1})
  assert(r.dtype=="int64","reduceat 66 dtype "..r.dtype)
  assert(close(r.shape,{5,1,4}),"reduceat 66 shape")
  assert(close(r.strides,{32,32,8}),"reduceat 66 strides")
  assert(close(r:tolist(),{{{4,5,-5,-4}},{{-1,1,3,5}},{{4,5,-5,-4}},{{1,2,3,4}},{{3,6,-2,1}}}),"reduceat 66 values")
end
do -- reduceat 67: add int8 [1] axis=0 indices=[0, 0, 0]
  local a=np.array({-4},np.int8)
  local o=np.zeros({3},np.float16)
  local r=np.add_reduceat(a,{1,1,1},{axis=1,out=o})
  assert(r==o,"reduceat 67 out identity")
  assert(r.dtype=="float16","reduceat 67 dtype "..r.dtype)
  assert(close(r.shape,{3}),"reduceat 67 shape")
  assert(close(r.strides,{2}),"reduceat 67 strides")
  assert(close(r:tolist(),{-4.0,-4.0,-4.0}),"reduceat 67 values")
end
do -- reduceat 68: add int16 [4, 2, 1, 1] axis=3 indices=[0, 0, 0, 0]
  local a=(np.array({{{{-3,0,3,-5},{-2,1,4,-4}}}},np.int16)).T
  local o=np.zeros({4,2,1,4},np.uint16)
  local r=np.add_reduceat(a,{-1,1,-1,-1},{axis=4,out=o})
  assert(r==o,"reduceat 68 out identity")
  assert(r.dtype=="uint16","reduceat 68 dtype "..r.dtype)
  assert(close(r.shape,{4,2,1,4}),"reduceat 68 shape")
  assert(close(r.strides,{16,8,8,2}),"reduceat 68 strides")
  assert(close(r:tolist(),{{{{65533,65533,65533,65533}},{{65534,65534,65534,65534}}},{{{0,0,0,0}},{{1,1,1,1}}},{{{3,3,3,3}},{{4,4,4,4}}},{{{65531,65531,65531,65531}},{{65532,65532,65532,65532}}}}),"reduceat 68 values")
end
do -- reduceat 69: add uint8 [2, 0, 4, 1] axis=2 indices=[0, 3, 0, 0]
  local a=np.zeros({2,0,4,1},np.uint8)
  local r=np.add_reduceat(a,{1,-1,-4,-4},{axis=3,dtype=np.uint8})
  assert(r.dtype=="uint8","reduceat 69 dtype "..r.dtype)
  assert(close(r.shape,{2,0,4,1}),"reduceat 69 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 69 strides")
  assert(close(r:tolist(),{{},{}}),"reduceat 69 values")
end
do -- reduceat 70: multiply uint64 [1, 1, 1, 4] axis=3 indices=[0, 0, 3, 2, 0, 1]
  local a=(np.array({{{{3}}},{{{4}}},{{{1}}},{{{2}}}},np.uint64)).T
  local o=np.zeros({1,1,1,6},np.uint32)
  local r=np.multiply_reduceat(a,{-4,-4,4,-2,1,-3},{axis=4,out=o})
  assert(r==o,"reduceat 70 out identity")
  assert(r.dtype=="uint32","reduceat 70 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,6}),"reduceat 70 shape")
  assert(close(r.strides,{24,24,24,4}),"reduceat 70 strides")
  assert(close(r:tolist(),{{{{3,12,2,1,3,8}}}}),"reduceat 70 values")
end
do -- reduceat 71: multiply uint64 [1] axis=0 indices=[0, 0]
  local a=np.array({4},np.uint64)
  local r=np.multiply_reduceat(a,{1,1},{axis=1})
  assert(r.dtype=="uint64","reduceat 71 dtype "..r.dtype)
  assert(close(r.shape,{2}),"reduceat 71 shape")
  assert(close(r.strides,{8}),"reduceat 71 strides")
  assert(close(r:tolist(),{4,4}),"reduceat 71 values")
end
do -- reduceat 72: multiply float16 [0, 4, 3] axis=2 indices=[0, 2, 0, 1, 1]
  local a=np.zeros({0,4,3},np.float16)
  local r=np.multiply_reduceat(a,{1,3,-3,2,-2},{axis=3})
  assert(r.dtype=="float16","reduceat 72 dtype "..r.dtype)
  assert(close(r.shape,{0,4,5}),"reduceat 72 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 72 strides")
  assert(close(r:tolist(),{}),"reduceat 72 values")
end
do -- reduceat 73: add float32 [3, 0, 2] axis=1 indices=[]
  local a=np.zeros({3,0,2},np.float32)
  local r=np.add_reduceat(a,{},{axis=2,dtype=np.float64})
  assert(r.dtype=="float64","reduceat 73 dtype "..r.dtype)
  assert(close(r.shape,{3,0,2}),"reduceat 73 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 73 strides")
  assert(close(r:tolist(),{{},{},{}}),"reduceat 73 values")
end
do -- reduceat 74: add uint32 [3] axis=0 indices=[2, 2, 1]
  local a=np.array({2,5,0},np.uint32)
  local o=np.zeros({3},np.bool)
  local r=np.add_reduceat(a,{-1,3,2},{axis=1,dtype=np.int16,out=o})
  assert(r==o,"reduceat 74 out identity")
  assert(r.dtype=="bool","reduceat 74 dtype "..r.dtype)
  assert(close(r.shape,{3}),"reduceat 74 shape")
  assert(close(r.strides,{1}),"reduceat 74 strides")
  assert(close(r:tolist(),{false,false,true}),"reduceat 74 values")
end
do -- reduceat 75: add uint16 [4, 0, 1] axis=2 indices=[0, 0]
  local a=np.zeros({4,0,1},np.uint16)
  local o=np.zeros({4,0,2},np.uint8)
  local r=np.add_reduceat(a,{1,1},{axis=3,out=o})
  assert(r==o,"reduceat 75 out identity")
  assert(r.dtype=="uint8","reduceat 75 dtype "..r.dtype)
  assert(close(r.shape,{4,0,2}),"reduceat 75 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 75 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"reduceat 75 values")
end
do -- reduceat 76: add uint64 [2, 1, 2, 4] axis=1 indices=[]
  local a=np.array({{{{4,7,2,5},{0,3,6,1}}},{{{4,7,2,5},{0,3,6,1}}}},np.uint64)
  local r=np.add_reduceat(a,{},{axis=2})
  assert(r.dtype=="uint64","reduceat 76 dtype "..r.dtype)
  assert(close(r.shape,{2,0,2,4}),"reduceat 76 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 76 strides")
  assert(close(r:tolist(),{{},{}}),"reduceat 76 values")
end
do -- reduceat 77: add int32 [4, 4] axis=0 indices=[1, 0, 1]
  local a=(np.array({{-5,-2,1,4},{-4,-1,2,5},{-3,0,3,-5},{-2,1,4,-4}},np.int32)).T
  local r=np.add_reduceat(a,{2,1,2},{axis=1})
  assert(r.dtype=="int64","reduceat 77 dtype "..r.dtype)
  assert(close(r.shape,{3,4}),"reduceat 77 shape")
  assert(close(r.strides,{32,8}),"reduceat 77 strides")
  assert(close(r:tolist(),{{-2,-1,0,1},{-5,-4,-3,-2},{3,6,-2,1}}),"reduceat 77 values")
end
do -- reduceat 78: multiply float32 [4, 0, 2] axis=1 indices=[]
  local a=np.zeros({4,0,2},np.float32)
  local r=np.multiply_reduceat(a,{},{axis=2})
  assert(r.dtype=="float32","reduceat 78 dtype "..r.dtype)
  assert(close(r.shape,{4,0,2}),"reduceat 78 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 78 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"reduceat 78 values")
end
do -- reduceat 79: multiply uint32 [2, 1, 4] axis=1 indices=[0, 0, 0, 0]
  local a=(np.array({{{4,1}},{{2,3}},{{4,1}},{{2,3}}},np.uint32)).T
  local r=np.multiply_reduceat(a,{1,1,1,1},{axis=2})
  assert(r.dtype=="uint64","reduceat 79 dtype "..r.dtype)
  assert(close(r.shape,{2,4,4}),"reduceat 79 shape")
  assert(close(r.strides,{8,64,16}),"reduceat 79 strides")
  assert(close(r:tolist(),{{{4,2,4,2},{4,2,4,2},{4,2,4,2},{4,2,4,2}},{{1,3,1,3},{1,3,1,3},{1,3,1,3},{1,3,1,3}}}),"reduceat 79 values")
end
do -- reduceat 80: add bool [2, 2] axis=1 indices=[1, 1, 0, 0]
  local a=np.array({{true,true},{false,true}},np.bool)
  local o=np.zeros({2,4},np.int16)
  local r=np.add_reduceat(a,{2,2,1,1},{axis=2,out=o})
  assert(r==o,"reduceat 80 out identity")
  assert(r.dtype=="int16","reduceat 80 dtype "..r.dtype)
  assert(close(r.shape,{2,4}),"reduceat 80 shape")
  assert(close(r.strides,{8,2}),"reduceat 80 strides")
  assert(close(r:tolist(),{{1,1,1,2},{1,1,0,1}}),"reduceat 80 values")
end
do -- reduceat 81: add uint32 [3] axis=0 indices=[0, 1, 2, 1, 2, 2]
  local a=np.array({1,4,7},np.uint32)
  local r=np.add_reduceat(a,{1,2,3,-2,-1,-1},{axis=1})
  assert(r.dtype=="uint64","reduceat 81 dtype "..r.dtype)
  assert(close(r.shape,{6}),"reduceat 81 shape")
  assert(close(r.strides,{8}),"reduceat 81 strides")
  assert(close(r:tolist(),{1,4,7,4,7,7}),"reduceat 81 values")
end
do -- reduceat 82: multiply float32 [3] axis=0 indices=[]
  local a=np.array({1.0,1.2,1.4},np.float32)
  local r=np.multiply_reduceat(a,{},{axis=1})
  assert(r.dtype=="float32","reduceat 82 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 82 shape")
  assert(close(r.strides,{0}),"reduceat 82 strides")
  assert(close(r:tolist(),{}),"reduceat 82 values")
end
do -- reduceat 83: add float16 [3] axis=0 indices=[2, 1, 2]
  local a=np.array({-0.75,0.375,1.5},np.float16)
  local o=np.zeros({3},np.uint8)
  local r=np.add_reduceat(a,{3,2,-1},{axis=1,out=o})
  assert(r==o,"reduceat 83 out identity")
  assert(r.dtype=="uint8","reduceat 83 dtype "..r.dtype)
  assert(close(r.shape,{3}),"reduceat 83 shape")
  assert(close(r.strides,{1}),"reduceat 83 strides")
  assert(close(r:tolist(),{1,0,1}),"reduceat 83 values")
end
do -- reduceat 84: add float32 [0, 1, 3, 1] axis=0 indices=[]
  local a=np.zeros({0,1,3,1},np.float32)
  local r=np.add_reduceat(a,{},{axis=1,dtype=np.uint8})
  assert(r.dtype=="uint8","reduceat 84 dtype "..r.dtype)
  assert(close(r.shape,{0,1,3,1}),"reduceat 84 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 84 strides")
  assert(close(r:tolist(),{}),"reduceat 84 values")
end
do -- reduceat 85: add float64 [0, 3] axis=1 indices=[2, 2, 0, 0, 0, 0]
  local a=np.zeros({0,3},np.float64)
  local r=np.add_reduceat(a,{-1,3,-3,1,1,1},{axis=2,dtype=np.int64})
  assert(r.dtype=="int64","reduceat 85 dtype "..r.dtype)
  assert(close(r.shape,{0,6}),"reduceat 85 shape")
  assert(close(r.strides,{0,0}),"reduceat 85 strides")
  assert(close(r:tolist(),{}),"reduceat 85 values")
end
do -- reduceat 86: add float32 [0, 0] axis=0 indices=[]
  local a=np.zeros({0,0},np.float32)
  local r=np.add_reduceat(a,{},{axis=1})
  assert(r.dtype=="float32","reduceat 86 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"reduceat 86 shape")
  assert(close(r.strides,{0,0}),"reduceat 86 strides")
  assert(close(r:tolist(),{}),"reduceat 86 values")
end
do -- reduceat 87: multiply int16 [4] axis=0 indices=[]
  local a=np.array({0,1,2,-2},np.int16)
  local r=np.multiply_reduceat(a,{},{axis=1,dtype=np.uint32})
  assert(r.dtype=="uint32","reduceat 87 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 87 shape")
  assert(close(r.strides,{0}),"reduceat 87 strides")
  assert(close(r:tolist(),{}),"reduceat 87 values")
end
do -- reduceat 88: multiply int32 [1] axis=0 indices=[0, 0, 0, 0]
  local a=np.array({1},np.int32)
  local r=np.multiply_reduceat(a,{1,1,-1,-1},{axis=1})
  assert(r.dtype=="int64","reduceat 88 dtype "..r.dtype)
  assert(close(r.shape,{4}),"reduceat 88 shape")
  assert(close(r.strides,{8}),"reduceat 88 strides")
  assert(close(r:tolist(),{1,1,1,1}),"reduceat 88 values")
end
do -- reduceat 89: multiply int16 [3] axis=0 indices=[0, 0]
  local a=np.array({2,-2,-1},np.int16)
  local r=np.multiply_reduceat(a,{-3,-3},{axis=1})
  assert(r.dtype=="int64","reduceat 89 dtype "..r.dtype)
  assert(close(r.shape,{2}),"reduceat 89 shape")
  assert(close(r.strides,{8}),"reduceat 89 strides")
  assert(close(r:tolist(),{2,4}),"reduceat 89 values")
end
do -- reduceat 90: add int32 [0, 2, 3] axis=2 indices=[2, 2]
  local a=np.zeros({0,2,3},np.int32)
  local r=np.add_reduceat(a,{3,3},{axis=3})
  assert(r.dtype=="int64","reduceat 90 dtype "..r.dtype)
  assert(close(r.shape,{0,2,2}),"reduceat 90 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 90 strides")
  assert(close(r:tolist(),{}),"reduceat 90 values")
end
do -- reduceat 91: multiply float64 [4, 0] axis=0 indices=[]
  local a=np.zeros({4,0},np.float64)
  local r=np.multiply_reduceat(a,{},{axis=1})
  assert(r.dtype=="float64","reduceat 91 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"reduceat 91 shape")
  assert(close(r.strides,{0,0}),"reduceat 91 strides")
  assert(close(r:tolist(),{}),"reduceat 91 values")
end
do -- reduceat 92: add uint64 [0, 3] axis=1 indices=[0, 2, 0, 0, 1]
  local a=np.zeros({0,3},np.uint64)
  local o=np.zeros({0,5},np.float64)
  local r=np.add_reduceat(a,{1,3,1,1,2},{axis=2,dtype=np.bool,out=o})
  assert(r==o,"reduceat 92 out identity")
  assert(r.dtype=="float64","reduceat 92 dtype "..r.dtype)
  assert(close(r.shape,{0,5}),"reduceat 92 shape")
  assert(close(r.strides,{0,0}),"reduceat 92 strides")
  assert(close(r:tolist(),{}),"reduceat 92 values")
end
do -- reduceat 93: multiply float32 [2, 1, 4, 4] axis=0 indices=[1, 0, 1, 0, 0]
  local a=np.array({{{{1.2,1.4,0.6,0.8},{1.0,1.2,1.4,0.6},{0.8,1.0,1.2,1.4},{0.6,0.8,1.0,1.2}}},{{{1.4,0.6,0.8,1.0},{1.2,1.4,0.6,0.8},{1.0,1.2,1.4,0.6},{0.8,1.0,1.2,1.4}}}},np.float32)
  local r=np.multiply_reduceat(a,{2,1,2,-2,1},{axis=1})
  assert(r.dtype=="float32","reduceat 93 dtype "..r.dtype)
  assert(close(r.shape,{5,1,4,4}),"reduceat 93 shape")
  assert(close(r.strides,{64,64,16,4}),"reduceat 93 strides")
  assert(close(r:tolist(),{{{{1.399999976158142,0.6000000238418579,0.800000011920929,1.0},{1.2000000476837158,1.399999976158142,0.6000000238418579,0.800000011920929},{1.0,1.2000000476837158,1.399999976158142,0.6000000238418579},{0.800000011920929,1.0,1.2000000476837158,1.399999976158142}}},{{{1.2000000476837158,1.399999976158142,0.6000000238418579,0.800000011920929},{1.0,1.2000000476837158,1.399999976158142,0.6000000238418579},{0.800000011920929,1.0,1.2000000476837158,1.399999976158142},{0.6000000238418579,0.800000011920929,1.0,1.2000000476837158}}},{{{1.399999976158142,0.6000000238418579,0.800000011920929,1.0},{1.2000000476837158,1.399999976158142,0.6000000238418579,0.800000011920929},{1.0,1.2000000476837158,1.399999976158142,0.6000000238418579},{0.800000011920929,1.0,1.2000000476837158,1.399999976158142}}},{{{1.2000000476837158,1.399999976158142,0.6000000238418579,0.800000011920929},{1.0,1.2000000476837158,1.399999976158142,0.6000000238418579},{0.800000011920929,1.0,1.2000000476837158,1.399999976158142},{0.6000000238418579,0.800000011920929,1.0,1.2000000476837158}}},{{{1.6800000667572021,0.8400000333786011,0.48000001907348633,0.800000011920929},{1.2000000476837158,1.6800000667572021,0.8400000333786011,0.48000001907348633},{0.800000011920929,1.2000000476837158,1.6800000667572021,0.8400000333786011},{0.48000001907348633,0.800000011920929,1.2000000476837158,1.6800000667572021}}}}),"reduceat 93 values")
end
do -- reduceat 94: add int8 [3, 1] axis=1 indices=[0]
  local a=np.array({{1},{4},{-4}},np.int8)
  local r=np.add_reduceat(a,{1},{axis=2})
  assert(r.dtype=="int64","reduceat 94 dtype "..r.dtype)
  assert(close(r.shape,{3,1}),"reduceat 94 shape")
  assert(close(r.strides,{8,8}),"reduceat 94 strides")
  assert(close(r:tolist(),{{1},{4},{-4}}),"reduceat 94 values")
end
do -- reduceat 95: multiply uint32 [4] axis=0 indices=[1, 1, 2, 1, 0, 1]
  local a=np.array({4,1,2,3},np.uint32)
  local r=np.multiply_reduceat(a,{2,2,3,2,1,2},{axis=1,dtype=np.uint32})
  assert(r.dtype=="uint32","reduceat 95 dtype "..r.dtype)
  assert(close(r.shape,{6}),"reduceat 95 shape")
  assert(close(r.strides,{4}),"reduceat 95 strides")
  assert(close(r:tolist(),{1,1,2,1,4,6}),"reduceat 95 values")
end
do -- reduceat 96: add uint64 [2, 0, 0] axis=0 indices=[1, 1, 0]
  local a=np.zeros({2,0,0},np.uint64)
  local o=np.zeros({3,0,0},np.int64)
  local r=np.add_reduceat(a,{2,2,1},{axis=1,out=o})
  assert(r==o,"reduceat 96 out identity")
  assert(r.dtype=="int64","reduceat 96 dtype "..r.dtype)
  assert(close(r.shape,{3,0,0}),"reduceat 96 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 96 strides")
  assert(close(r:tolist(),{{},{},{}}),"reduceat 96 values")
end
do -- reduceat 97: add int32 [2, 0, 1, 3] axis=0 indices=[]
  local a=np.zeros({2,0,1,3},np.int32)
  local o=np.zeros({0,0,1,3},np.float32)
  local r=np.add_reduceat(a,{},{axis=1,dtype=np.uint64,out=o})
  assert(r==o,"reduceat 97 out identity")
  assert(r.dtype=="float32","reduceat 97 dtype "..r.dtype)
  assert(close(r.shape,{0,0,1,3}),"reduceat 97 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 97 strides")
  assert(close(r:tolist(),{}),"reduceat 97 values")
end
do -- reduceat 98: multiply uint64 [0] axis=0 indices=[]
  local a=np.zeros({0},np.uint64)
  local o=np.zeros({0},np.int64)
  local r=np.multiply_reduceat(a,{},{axis=1,out=o})
  assert(r==o,"reduceat 98 out identity")
  assert(r.dtype=="int64","reduceat 98 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 98 shape")
  assert(close(r.strides,{0}),"reduceat 98 strides")
  assert(close(r:tolist(),{}),"reduceat 98 values")
end
do -- reduceat 99: multiply float32 [4, 0] axis=0 indices=[]
  local a=np.zeros({4,0},np.float32)
  local o=np.zeros({0,0},np.uint32)
  local r=np.multiply_reduceat(a,{},{axis=1,out=o})
  assert(r==o,"reduceat 99 out identity")
  assert(r.dtype=="uint32","reduceat 99 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"reduceat 99 shape")
  assert(close(r.strides,{0,0}),"reduceat 99 strides")
  assert(close(r:tolist(),{}),"reduceat 99 values")
end
do -- reduceat 100: add float16 [1, 2, 3] axis=2 indices=[2, 2, 0, 0]
  local a=np.array({{{-1.125,0.0,1.125},{-1.125,0.0,1.125}}},np.float16)
  local o=np.zeros({1,2,4},np.uint16)
  local r=np.add_reduceat(a,{-1,-1,1,1},{axis=3,out=o})
  assert(r==o,"reduceat 100 out identity")
  assert(r.dtype=="uint16","reduceat 100 dtype "..r.dtype)
  assert(close(r.shape,{1,2,4}),"reduceat 100 shape")
  assert(close(r.strides,{16,8,2}),"reduceat 100 strides")
  assert(close(r:tolist(),{{{1,1,65535,0},{1,1,65535,0}}}),"reduceat 100 values")
end
do -- reduceat 101: add bool [2, 3, 0] axis=2 indices=[]
  local a=np.zeros({2,3,0},np.bool)
  local r=np.add_reduceat(a,{},{axis=3})
  assert(r.dtype=="int64","reduceat 101 dtype "..r.dtype)
  assert(close(r.shape,{2,3,0}),"reduceat 101 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 101 strides")
  assert(close(r:tolist(),{{{},{},{}},{{},{},{}}}),"reduceat 101 values")
end
do -- reduceat 102: add bool [2, 3, 1, 1] axis=3 indices=[0, 0, 0, 0]
  local a=(np.array({{{{false,true},{true,false},{true,true}}}},np.bool)).T
  local o=np.zeros({2,3,1,4},np.uint8)
  local r=np.add_reduceat(a,{1,-1,-1,1},{axis=4,dtype=np.uint16,out=o})
  assert(r==o,"reduceat 102 out identity")
  assert(r.dtype=="uint8","reduceat 102 dtype "..r.dtype)
  assert(close(r.shape,{2,3,1,4}),"reduceat 102 shape")
  assert(close(r.strides,{12,4,4,1}),"reduceat 102 strides")
  assert(close(r:tolist(),{{{{0,0,0,0}},{{1,1,1,1}},{{1,1,1,1}}},{{{1,1,1,1}},{{0,0,0,0}},{{1,1,1,1}}}}),"reduceat 102 values")
end
do -- reduceat 103: multiply bool [1, 1, 1, 2] axis=1 indices=[]
  local a=np.array({{{{true,false}}}},np.bool)
  local r=np.multiply_reduceat(a,{},{axis=2})
  assert(r.dtype=="int64","reduceat 103 dtype "..r.dtype)
  assert(close(r.shape,{1,0,1,2}),"reduceat 103 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 103 strides")
  assert(close(r:tolist(),{{}}),"reduceat 103 values")
end
do -- reduceat 104: add int16 [2, 3, 1, 4] axis=0 indices=[1]
  local a=np.array({{{{0,3,-5,-2}},{{1,4,-4,-1}},{{2,5,-3,0}}},{{{3,-5,-2,1}},{{4,-4,-1,2}},{{5,-3,0,3}}}},np.int16)
  local r=np.add_reduceat(a,{2},{axis=1})
  assert(r.dtype=="int64","reduceat 104 dtype "..r.dtype)
  assert(close(r.shape,{1,3,1,4}),"reduceat 104 shape")
  assert(close(r.strides,{96,32,32,8}),"reduceat 104 strides")
  assert(close(r:tolist(),{{{{3,-5,-2,1}},{{4,-4,-1,2}},{{5,-3,0,3}}}}),"reduceat 104 values")
end
do -- reduceat 105: multiply bool [0, 4] axis=1 indices=[1]
  local a=np.zeros({0,4},np.bool)
  local o=np.zeros({0,1},np.int32)
  local r=np.multiply_reduceat(a,{2},{axis=2,out=o})
  assert(r==o,"reduceat 105 out identity")
  assert(r.dtype=="int32","reduceat 105 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"reduceat 105 shape")
  assert(close(r.strides,{0,0}),"reduceat 105 strides")
  assert(close(r:tolist(),{}),"reduceat 105 values")
end
do -- reduceat 106: multiply int64 [4, 0, 2] axis=2 indices=[1, 1]
  local a=np.zeros({4,0,2},np.int64)
  local r=np.multiply_reduceat(a,{2,2},{axis=3})
  assert(r.dtype=="int64","reduceat 106 dtype "..r.dtype)
  assert(close(r.shape,{4,0,2}),"reduceat 106 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 106 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"reduceat 106 values")
end
do -- reduceat 107: add int8 [4, 2, 1] axis=1 indices=[0, 0, 1, 1]
  local a=np.array({{{3},{-5}},{{-2},{1}},{{4},{-4}},{{-1},{2}}},np.int8)
  local r=np.add_reduceat(a,{1,1,2,-1},{axis=2})
  assert(r.dtype=="int64","reduceat 107 dtype "..r.dtype)
  assert(close(r.shape,{4,4,1}),"reduceat 107 shape")
  assert(close(r.strides,{32,8,8}),"reduceat 107 strides")
  assert(close(r:tolist(),{{{3},{3},{-5},{-5}},{{-2},{-2},{1},{1}},{{4},{4},{-4},{-4}},{{-1},{-1},{2},{2}}}),"reduceat 107 values")
end
do -- reduceat 108: add int16 [0, 1, 3] axis=1 indices=[0, 0, 0]
  local a=np.zeros({0,1,3},np.int16)
  local r=np.add_reduceat(a,{1,1,1},{axis=2})
  assert(r.dtype=="int64","reduceat 108 dtype "..r.dtype)
  assert(close(r.shape,{0,3,3}),"reduceat 108 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 108 strides")
  assert(close(r:tolist(),{}),"reduceat 108 values")
end
do -- reduceat 109: add float64 [1, 4] axis=1 indices=[1, 2, 0, 3, 2, 1]
  local a=np.array({{-1.125,0.0,1.125,-1.125}},np.float64)
  local o=np.zeros({1,6},np.int16)
  local r=np.add_reduceat(a,{-3,3,1,4,-2,2},{axis=2,dtype=np.int32,out=o})
  assert(r==o,"reduceat 109 out identity")
  assert(r.dtype=="int16","reduceat 109 dtype "..r.dtype)
  assert(close(r.shape,{1,6}),"reduceat 109 shape")
  assert(close(r.strides,{12,2}),"reduceat 109 strides")
  assert(close(r:tolist(),{{0,1,0,-1,1,0}}),"reduceat 109 values")
end
do -- reduceat 110: add int8 [0] axis=0 indices=[]
  local a=np.zeros({0},np.int8)
  local o=np.zeros({0},np.uint8)
  local r=np.add_reduceat(a,{},{axis=1,out=o})
  assert(r==o,"reduceat 110 out identity")
  assert(r.dtype=="uint8","reduceat 110 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 110 shape")
  assert(close(r.strides,{0}),"reduceat 110 strides")
  assert(close(r:tolist(),{}),"reduceat 110 values")
end
do -- reduceat 111: add int8 [3, 1] axis=1 indices=[0]
  local a=np.array({{-4},{-1},{2}},np.int8)
  local r=np.add_reduceat(a,{1},{axis=2,dtype=np.uint32})
  assert(r.dtype=="uint32","reduceat 111 dtype "..r.dtype)
  assert(close(r.shape,{3,1}),"reduceat 111 shape")
  assert(close(r.strides,{4,4}),"reduceat 111 strides")
  assert(close(r:tolist(),{{4294967292},{4294967295},{2}}),"reduceat 111 values")
end
do -- reduceat 112: add uint32 [2, 1, 3] axis=0 indices=[0]
  local a=np.array({{{0,3,6}},{{1,4,7}}},np.uint32)
  local o=np.zeros({1,1,3},np.float32)
  local r=np.add_reduceat(a,{1},{axis=1,out=o})
  assert(r==o,"reduceat 112 out identity")
  assert(r.dtype=="float32","reduceat 112 dtype "..r.dtype)
  assert(close(r.shape,{1,1,3}),"reduceat 112 shape")
  assert(close(r.strides,{12,12,4}),"reduceat 112 strides")
  assert(close(r:tolist(),{{{1.0,7.0,13.0}}}),"reduceat 112 values")
end
do -- reduceat 113: multiply uint32 [3, 4, 3] axis=2 indices=[0, 0, 0, 1, 2]
  local a=np.array({{{2,3,4},{1,2,3},{4,1,2},{3,4,1}},{{2,3,4},{1,2,3},{4,1,2},{3,4,1}},{{2,3,4},{1,2,3},{4,1,2},{3,4,1}}},np.uint32)
  local r=np.multiply_reduceat(a,{1,1,-3,2,-1},{axis=3})
  assert(r.dtype=="uint64","reduceat 113 dtype "..r.dtype)
  assert(close(r.shape,{3,4,5}),"reduceat 113 shape")
  assert(close(r.strides,{160,40,8}),"reduceat 113 strides")
  assert(close(r:tolist(),{{{2,2,2,3,4},{1,1,1,2,3},{4,4,4,1,2},{3,3,3,4,1}},{{2,2,2,3,4},{1,1,1,2,3},{4,4,4,1,2},{3,3,3,4,1}},{{2,2,2,3,4},{1,1,1,2,3},{4,4,4,1,2},{3,3,3,4,1}}}),"reduceat 113 values")
end
do -- reduceat 114: multiply float32 [4] axis=0 indices=[3, 0, 2, 0]
  local a=np.array({1.4,0.6,0.8,1.0},np.float32)
  local o=np.zeros({4},np.uint32)
  local r=np.multiply_reduceat(a,{-1,-4,-2,1},{axis=1,dtype=np.uint8,out=o})
  assert(r==o,"reduceat 114 out identity")
  assert(r.dtype=="uint32","reduceat 114 dtype "..r.dtype)
  assert(close(r.shape,{4}),"reduceat 114 shape")
  assert(close(r.strides,{4}),"reduceat 114 strides")
  assert(close(r:tolist(),{1,0,0,0}),"reduceat 114 values")
end
do -- reduceat 115: multiply uint32 [0, 0] axis=1 indices=[]
  local a=np.zeros({0,0},np.uint32)
  local o=np.zeros({0,0},np.uint8)
  local r=np.multiply_reduceat(a,{},{axis=2,out=o})
  assert(r==o,"reduceat 115 out identity")
  assert(r.dtype=="uint8","reduceat 115 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"reduceat 115 shape")
  assert(close(r.strides,{0,0}),"reduceat 115 strides")
  assert(close(r:tolist(),{}),"reduceat 115 values")
end
do -- reduceat 116: multiply uint8 [4, 2] axis=1 indices=[1, 1]
  local a=np.array({{1,2},{3,4},{1,2},{3,4}},np.uint8)
  local r=np.multiply_reduceat(a,{2,-1},{axis=2,dtype=np.bool})
  assert(r.dtype=="bool","reduceat 116 dtype "..r.dtype)
  assert(close(r.shape,{4,2}),"reduceat 116 shape")
  assert(close(r.strides,{2,1}),"reduceat 116 strides")
  assert(close(r:tolist(),{{true,true},{true,true},{true,true},{true,true}}),"reduceat 116 values")
end
do -- reduceat 117: add float32 [1, 2] axis=0 indices=[0, 0, 0]
  local a=np.array({{-1.5,-0.375}},np.float32)
  local o=np.zeros({3,2},np.int16)
  local r=np.add_reduceat(a,{-1,1,1},{axis=1,dtype=np.uint64,out=o})
  assert(r==o,"reduceat 117 out identity")
  assert(r.dtype=="int16","reduceat 117 dtype "..r.dtype)
  assert(close(r.shape,{3,2}),"reduceat 117 shape")
  assert(close(r.strides,{4,2}),"reduceat 117 strides")
  assert(close(r:tolist(),{{-1,0},{-1,0},{-1,0}}),"reduceat 117 values")
end
do -- reduceat 118: add int8 [1, 4, 2, 2] axis=3 indices=[0, 0]
  local a=np.array({{{{3,-5},{-2,1}},{{4,-4},{-1,2}},{{5,-3},{0,3}},{{-5,-2},{1,4}}}},np.int8)
  local r=np.add_reduceat(a,{1,1},{axis=4})
  assert(r.dtype=="int64","reduceat 118 dtype "..r.dtype)
  assert(close(r.shape,{1,4,2,2}),"reduceat 118 shape")
  assert(close(r.strides,{128,32,16,8}),"reduceat 118 strides")
  assert(close(r:tolist(),{{{{3,-2},{-2,-1}},{{4,0},{-1,1}},{{5,2},{0,3}},{{-5,-7},{1,5}}}}),"reduceat 118 values")
end
do -- reduceat 119: add uint8 [1] axis=0 indices=[0, 0]
  local a=np.array({7},np.uint8)
  local r=np.add_reduceat(a,{1,1},{axis=1})
  assert(r.dtype=="uint64","reduceat 119 dtype "..r.dtype)
  assert(close(r.shape,{2}),"reduceat 119 shape")
  assert(close(r.strides,{8}),"reduceat 119 strides")
  assert(close(r:tolist(),{7,7}),"reduceat 119 values")
end
do -- reduceat 120: add float32 [4, 3] axis=0 indices=[0, 0, 0, 1, 0]
  local a=(np.array({{-0.375,0.75,-1.5,-0.375},{0.75,-1.5,-0.375,0.75},{-1.5,-0.375,0.75,-1.5}},np.float32)).T
  local r=np.add_reduceat(a,{1,1,-4,2,-4},{axis=1})
  assert(r.dtype=="float32","reduceat 120 dtype "..r.dtype)
  assert(close(r.shape,{5,3}),"reduceat 120 shape")
  assert(close(r.strides,{12,4}),"reduceat 120 strides")
  assert(close(r:tolist(),{{-0.375,0.75,-1.5},{-0.375,0.75,-1.5},{-0.375,0.75,-1.5},{0.75,-1.5,-0.375},{-1.5,-0.375,-2.625}}),"reduceat 120 values")
end
do -- reduceat 121: multiply bool [2] axis=0 indices=[1, 0, 1]
  local a=np.array({true,false},np.bool)
  local r=np.multiply_reduceat(a,{2,1,2},{axis=1})
  assert(r.dtype=="int64","reduceat 121 dtype "..r.dtype)
  assert(close(r.shape,{3}),"reduceat 121 shape")
  assert(close(r.strides,{8}),"reduceat 121 strides")
  assert(close(r:tolist(),{0,1,0}),"reduceat 121 values")
end
do -- reduceat 122: multiply float16 [0, 1, 1] axis=0 indices=[]
  local a=np.zeros({0,1,1},np.float16)
  local o=np.zeros({0,1,1},np.bool)
  local r=np.multiply_reduceat(a,{},{axis=1,out=o})
  assert(r==o,"reduceat 122 out identity")
  assert(r.dtype=="bool","reduceat 122 dtype "..r.dtype)
  assert(close(r.shape,{0,1,1}),"reduceat 122 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 122 strides")
  assert(close(r:tolist(),{}),"reduceat 122 values")
end
do -- reduceat 123: multiply uint16 [2] axis=0 indices=[]
  local a=np.array({4,1},np.uint16)
  local r=np.multiply_reduceat(a,{},{axis=1,dtype=np.float16})
  assert(r.dtype=="float16","reduceat 123 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 123 shape")
  assert(close(r.strides,{0}),"reduceat 123 strides")
  assert(close(r:tolist(),{}),"reduceat 123 values")
end
do -- reduceat 124: multiply float32 [1, 3, 2] axis=0 indices=[0]
  local a=np.array({{{1.4,0.6},{0.8,1.0},{1.2,1.4}}},np.float32)
  local r=np.multiply_reduceat(a,{-1},{axis=1})
  assert(r.dtype=="float32","reduceat 124 dtype "..r.dtype)
  assert(close(r.shape,{1,3,2}),"reduceat 124 shape")
  assert(close(r.strides,{24,8,4}),"reduceat 124 strides")
  assert(close(r:tolist(),{{{1.399999976158142,0.6000000238418579},{0.800000011920929,1.0},{1.2000000476837158,1.399999976158142}}}),"reduceat 124 values")
end
do -- reduceat 125: add int16 [3] axis=0 indices=[0, 0, 2, 1, 1, 2]
  local a=np.array({-1,2,5},np.int16)
  local o=np.zeros({6},np.int64)
  local r=np.add_reduceat(a,{1,1,3,-2,-2,3},{axis=1,out=o})
  assert(r==o,"reduceat 125 out identity")
  assert(r.dtype=="int64","reduceat 125 dtype "..r.dtype)
  assert(close(r.shape,{6}),"reduceat 125 shape")
  assert(close(r.strides,{8}),"reduceat 125 strides")
  assert(close(r:tolist(),{-1,1,5,2,2,5}),"reduceat 125 values")
end
do -- reduceat 126: multiply int64 [2, 3, 2] axis=1 indices=[2, 0, 0]
  local a=np.array({{{-1,0},{1,2},{-2,-1}},{{0,1},{2,-2},{-1,0}}},np.int64)
  local r=np.multiply_reduceat(a,{3,1,-3},{axis=2,dtype=np.float64})
  assert(r.dtype=="float64","reduceat 126 dtype "..r.dtype)
  assert(close(r.shape,{2,3,2}),"reduceat 126 shape")
  assert(close(r.strides,{48,16,8}),"reduceat 126 strides")
  assert(close(r:tolist(),{{{-2.0,-1.0},{-1.0,0.0},{2.0,-0.0}},{{-1.0,0.0},{0.0,1.0},{-0.0,-0.0}}}),"reduceat 126 values")
end
do -- reduceat 127: multiply uint32 [3, 1, 1, 2] axis=1 indices=[]
  local a=np.array({{{{4,1}}},{{{2,3}}},{{{4,1}}}},np.uint32)
  local r=np.multiply_reduceat(a,{},{axis=2})
  assert(r.dtype=="uint64","reduceat 127 dtype "..r.dtype)
  assert(close(r.shape,{3,0,1,2}),"reduceat 127 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 127 strides")
  assert(close(r:tolist(),{{},{},{}}),"reduceat 127 values")
end
do -- reduceat 128: multiply float32 [2] axis=0 indices=[1, 1]
  local a=np.array({1.2,1.4},np.float32)
  local o=np.zeros({2},np.int64)
  local r=np.multiply_reduceat(a,{2,2},{axis=1,dtype=np.bool,out=o})
  assert(r==o,"reduceat 128 out identity")
  assert(r.dtype=="int64","reduceat 128 dtype "..r.dtype)
  assert(close(r.shape,{2}),"reduceat 128 shape")
  assert(close(r.strides,{8}),"reduceat 128 strides")
  assert(close(r:tolist(),{1,1}),"reduceat 128 values")
end
do -- reduceat 129: add uint8 [3] axis=0 indices=[2, 0, 2]
  local a=np.array({1,4,7},np.uint8)
  local r=np.add_reduceat(a,{-1,1,-1},{axis=1,dtype=np.uint64})
  assert(r.dtype=="uint64","reduceat 129 dtype "..r.dtype)
  assert(close(r.shape,{3}),"reduceat 129 shape")
  assert(close(r.strides,{8}),"reduceat 129 strides")
  assert(close(r:tolist(),{7,5,7}),"reduceat 129 values")
end
do -- reduceat 130: multiply uint16 [0] axis=0 indices=[]
  local a=np.zeros({0},np.uint16)
  local r=np.multiply_reduceat(a,{},{axis=1,dtype=np.float64})
  assert(r.dtype=="float64","reduceat 130 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 130 shape")
  assert(close(r.strides,{0}),"reduceat 130 strides")
  assert(close(r:tolist(),{}),"reduceat 130 values")
end
do -- reduceat 131: add uint8 [0, 2] axis=1 indices=[1]
  local a=np.zeros({0,2},np.uint8)
  local r=np.add_reduceat(a,{2},{axis=2,dtype=np.uint64})
  assert(r.dtype=="uint64","reduceat 131 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"reduceat 131 shape")
  assert(close(r.strides,{0,0}),"reduceat 131 strides")
  assert(close(r:tolist(),{}),"reduceat 131 values")
end
do -- reduceat 132: multiply uint32 [1] axis=0 indices=[0, 0]
  local a=np.array({1},np.uint32)
  local o=np.zeros({2},np.int8)
  local r=np.multiply_reduceat(a,{-1,1},{axis=1,out=o})
  assert(r==o,"reduceat 132 out identity")
  assert(r.dtype=="int8","reduceat 132 dtype "..r.dtype)
  assert(close(r.shape,{2}),"reduceat 132 shape")
  assert(close(r.strides,{1}),"reduceat 132 strides")
  assert(close(r:tolist(),{1,1}),"reduceat 132 values")
end
do -- reduceat 133: add int8 [2, 2, 1, 3] axis=1 indices=[]
  local a=np.array({{{{-4,-1,2}},{{5,-3,0}}},{{{3,-5,-2}},{{1,4,-4}}}},np.int8)
  local r=np.add_reduceat(a,{},{axis=2,dtype=np.uint8})
  assert(r.dtype=="uint8","reduceat 133 dtype "..r.dtype)
  assert(close(r.shape,{2,0,1,3}),"reduceat 133 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 133 strides")
  assert(close(r:tolist(),{{},{}}),"reduceat 133 values")
end
do -- reduceat 134: add uint16 [1] axis=0 indices=[0, 0, 0, 0]
  local a=np.array({6},np.uint16)
  local r=np.add_reduceat(a,{1,1,1,-1},{axis=1})
  assert(r.dtype=="uint64","reduceat 134 dtype "..r.dtype)
  assert(close(r.shape,{4}),"reduceat 134 shape")
  assert(close(r.strides,{8}),"reduceat 134 strides")
  assert(close(r:tolist(),{6,6,6,6}),"reduceat 134 values")
end
do -- reduceat 135: add int32 [0, 2, 0] axis=2 indices=[]
  local a=np.zeros({0,2,0},np.int32)
  local r=np.add_reduceat(a,{},{axis=3})
  assert(r.dtype=="int64","reduceat 135 dtype "..r.dtype)
  assert(close(r.shape,{0,2,0}),"reduceat 135 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 135 strides")
  assert(close(r:tolist(),{}),"reduceat 135 values")
end
do -- reduceat 136: multiply bool [2] axis=0 indices=[1, 1, 0]
  local a=np.array({true,false},np.bool)
  local o=np.zeros({3},np.bool)
  local r=np.multiply_reduceat(a,{2,2,1},{axis=1,dtype=np.int64,out=o})
  assert(r==o,"reduceat 136 out identity")
  assert(r.dtype=="bool","reduceat 136 dtype "..r.dtype)
  assert(close(r.shape,{3}),"reduceat 136 shape")
  assert(close(r.strides,{1}),"reduceat 136 strides")
  assert(close(r:tolist(),{false,false,false}),"reduceat 136 values")
end
do -- reduceat 137: multiply uint16 [0, 3, 3, 2] axis=3 indices=[1]
  local a=np.zeros({0,3,3,2},np.uint16)
  local r=np.multiply_reduceat(a,{-1},{axis=4})
  assert(r.dtype=="uint64","reduceat 137 dtype "..r.dtype)
  assert(close(r.shape,{0,3,3,1}),"reduceat 137 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 137 strides")
  assert(close(r:tolist(),{}),"reduceat 137 values")
end
do -- reduceat 138: multiply uint16 [1, 4] axis=0 indices=[0, 0, 0]
  local a=np.array({{3,4,1,2}},np.uint16)
  local r=np.multiply_reduceat(a,{-1,1,1},{axis=1})
  assert(r.dtype=="uint64","reduceat 138 dtype "..r.dtype)
  assert(close(r.shape,{3,4}),"reduceat 138 shape")
  assert(close(r.strides,{32,8}),"reduceat 138 strides")
  assert(close(r:tolist(),{{3,4,1,2},{3,4,1,2},{3,4,1,2}}),"reduceat 138 values")
end
do -- reduceat 139: multiply uint16 [3, 1, 0] axis=1 indices=[]
  local a=np.zeros({3,1,0},np.uint16)
  local r=np.multiply_reduceat(a,{},{axis=2,dtype=np.int64})
  assert(r.dtype=="int64","reduceat 139 dtype "..r.dtype)
  assert(close(r.shape,{3,0,0}),"reduceat 139 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 139 strides")
  assert(close(r:tolist(),{{},{},{}}),"reduceat 139 values")
end
do -- reduceat 140: add int32 [0, 2, 3] axis=2 indices=[0]
  local a=np.zeros({0,2,3},np.int32)
  local r=np.add_reduceat(a,{1},{axis=3,dtype=np.float32})
  assert(r.dtype=="float32","reduceat 140 dtype "..r.dtype)
  assert(close(r.shape,{0,2,1}),"reduceat 140 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 140 strides")
  assert(close(r:tolist(),{}),"reduceat 140 values")
end
do -- reduceat 141: multiply uint64 [3, 1, 3, 1] axis=0 indices=[1, 1, 0, 0, 1]
  local a=np.array({{{{2},{3},{4}}},{{{1},{2},{3}}},{{{4},{1},{2}}}},np.uint64)
  local r=np.multiply_reduceat(a,{2,2,-3,1,2},{axis=1})
  assert(r.dtype=="uint64","reduceat 141 dtype "..r.dtype)
  assert(close(r.shape,{5,1,3,1}),"reduceat 141 shape")
  assert(close(r.strides,{24,24,8,8}),"reduceat 141 strides")
  assert(close(r:tolist(),{{{{1},{2},{3}}},{{{1},{2},{3}}},{{{2},{3},{4}}},{{{2},{3},{4}}},{{{4},{2},{6}}}}),"reduceat 141 values")
end
do -- reduceat 142: add int32 [0, 4] axis=0 indices=[]
  local a=np.zeros({0,4},np.int32)
  local r=np.add_reduceat(a,{},{axis=1})
  assert(r.dtype=="int64","reduceat 142 dtype "..r.dtype)
  assert(close(r.shape,{0,4}),"reduceat 142 shape")
  assert(close(r.strides,{0,0}),"reduceat 142 strides")
  assert(close(r:tolist(),{}),"reduceat 142 values")
end
do -- reduceat 143: add int32 [0, 1, 4, 4] axis=0 indices=[]
  local a=np.zeros({0,1,4,4},np.int32)
  local o=np.zeros({0,1,4,4},np.float16)
  local r=np.add_reduceat(a,{},{axis=1,out=o})
  assert(r==o,"reduceat 143 out identity")
  assert(r.dtype=="float16","reduceat 143 dtype "..r.dtype)
  assert(close(r.shape,{0,1,4,4}),"reduceat 143 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 143 strides")
  assert(close(r:tolist(),{}),"reduceat 143 values")
end
do -- reduceat 144: add uint8 [1, 1, 2, 1] axis=0 indices=[]
  local a=np.array({{{{0},{3}}}},np.uint8)
  local r=np.add_reduceat(a,{},{axis=1})
  assert(r.dtype=="uint64","reduceat 144 dtype "..r.dtype)
  assert(close(r.shape,{0,1,2,1}),"reduceat 144 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 144 strides")
  assert(close(r:tolist(),{}),"reduceat 144 values")
end
do -- reduceat 145: multiply int16 [0, 3] axis=1 indices=[0, 0, 1, 2]
  local a=np.zeros({0,3},np.int16)
  local o=np.zeros({0,4},np.int64)
  local r=np.multiply_reduceat(a,{1,1,2,3},{axis=2,out=o})
  assert(r==o,"reduceat 145 out identity")
  assert(r.dtype=="int64","reduceat 145 dtype "..r.dtype)
  assert(close(r.shape,{0,4}),"reduceat 145 shape")
  assert(close(r.strides,{0,0}),"reduceat 145 strides")
  assert(close(r:tolist(),{}),"reduceat 145 values")
end
do -- reduceat 146: add uint32 [0] axis=0 indices=[]
  local a=np.zeros({0},np.uint32)
  local r=np.add_reduceat(a,{},{axis=1})
  assert(r.dtype=="uint64","reduceat 146 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 146 shape")
  assert(close(r.strides,{0}),"reduceat 146 strides")
  assert(close(r:tolist(),{}),"reduceat 146 values")
end
do -- reduceat 147: add int32 [0, 3, 2, 4] axis=3 indices=[2, 0, 1]
  local a=np.zeros({0,3,2,4},np.int32)
  local r=np.add_reduceat(a,{-2,-4,-3},{axis=4})
  assert(r.dtype=="int64","reduceat 147 dtype "..r.dtype)
  assert(close(r.shape,{0,3,2,3}),"reduceat 147 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 147 strides")
  assert(close(r:tolist(),{}),"reduceat 147 values")
end
do -- reduceat 148: add uint64 [1, 4, 2, 3] axis=0 indices=[0]
  local a=(np.array({{{{4},{7},{2},{5}},{{0},{3},{6},{1}}},{{{4},{7},{2},{5}},{{0},{3},{6},{1}}},{{{4},{7},{2},{5}},{{0},{3},{6},{1}}}},np.uint64)).T
  local r=np.add_reduceat(a,{-1},{axis=1})
  assert(r.dtype=="uint64","reduceat 148 dtype "..r.dtype)
  assert(close(r.shape,{1,4,2,3}),"reduceat 148 shape")
  assert(close(r.strides,{192,8,32,64}),"reduceat 148 strides")
  assert(close(r:tolist(),{{{{4,4,4},{0,0,0}},{{7,7,7},{3,3,3}},{{2,2,2},{6,6,6}},{{5,5,5},{1,1,1}}}}),"reduceat 148 values")
end
do -- reduceat 149: multiply bool [4, 3, 0, 0] axis=1 indices=[0]
  local a=np.zeros({4,3,0,0},np.bool)
  local r=np.multiply_reduceat(a,{-3},{axis=2,dtype=np.float32})
  assert(r.dtype=="float32","reduceat 149 dtype "..r.dtype)
  assert(close(r.shape,{4,1,0,0}),"reduceat 149 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 149 strides")
  assert(close(r:tolist(),{{{}},{{}},{{}},{{}}}),"reduceat 149 values")
end
do -- reduceat 150: add float64 [4, 0, 4, 2] axis=0 indices=[2]
  local a=np.zeros({4,0,4,2},np.float64)
  local r=np.add_reduceat(a,{-2},{axis=1,dtype=np.uint32})
  assert(r.dtype=="uint32","reduceat 150 dtype "..r.dtype)
  assert(close(r.shape,{1,0,4,2}),"reduceat 150 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 150 strides")
  assert(close(r:tolist(),{{}}),"reduceat 150 values")
end
do -- reduceat 151: multiply uint64 [4, 0, 3] axis=2 indices=[1, 1, 2]
  local a=np.zeros({4,0,3},np.uint64)
  local r=np.multiply_reduceat(a,{2,2,3},{axis=3})
  assert(r.dtype=="uint64","reduceat 151 dtype "..r.dtype)
  assert(close(r.shape,{4,0,3}),"reduceat 151 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 151 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"reduceat 151 values")
end
do -- reduceat 152: multiply uint16 [4, 1, 2] axis=2 indices=[]
  local a=np.array({{{1,2}},{{3,4}},{{1,2}},{{3,4}}},np.uint16)
  local r=np.multiply_reduceat(a,{},{axis=3})
  assert(r.dtype=="uint64","reduceat 152 dtype "..r.dtype)
  assert(close(r.shape,{4,1,0}),"reduceat 152 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 152 strides")
  assert(close(r:tolist(),{{{}},{{}},{{}},{{}}}),"reduceat 152 values")
end
do -- reduceat 153: multiply float16 [1, 2, 4] axis=1 indices=[1, 0, 1, 0]
  local a=(np.array({{{1.2},{1.4}},{{0.6},{0.8}},{{1.0},{1.2}},{{1.4},{0.6}}},np.float16)).T
  local r=np.multiply_reduceat(a,{2,1,-1,1},{axis=2,dtype=np.int8})
  assert(r.dtype=="int8","reduceat 153 dtype "..r.dtype)
  assert(close(r.shape,{1,4,4}),"reduceat 153 shape")
  assert(close(r.strides,{16,4,1}),"reduceat 153 strides")
  assert(close(r:tolist(),{{{1,0,1,0},{1,0,1,1},{1,0,1,0},{1,0,1,0}}}),"reduceat 153 values")
end
do -- reduceat 154: multiply int16 [2, 1, 4, 0] axis=3 indices=[]
  local a=np.zeros({2,1,4,0},np.int16)
  local r=np.multiply_reduceat(a,{},{axis=4})
  assert(r.dtype=="int64","reduceat 154 dtype "..r.dtype)
  assert(close(r.shape,{2,1,4,0}),"reduceat 154 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 154 strides")
  assert(close(r:tolist(),{{{{},{},{},{}}},{{{},{},{},{}}}}),"reduceat 154 values")
end
do -- reduceat 155: add bool [2] axis=0 indices=[1, 1, 0]
  local a=np.array({true,true},np.bool)
  local o=np.zeros({3},np.int16)
  local r=np.add_reduceat(a,{2,2,1},{axis=1,out=o})
  assert(r==o,"reduceat 155 out identity")
  assert(r.dtype=="int16","reduceat 155 dtype "..r.dtype)
  assert(close(r.shape,{3}),"reduceat 155 shape")
  assert(close(r.strides,{2}),"reduceat 155 strides")
  assert(close(r:tolist(),{1,1,2}),"reduceat 155 values")
end
do -- reduceat 156: add int8 [2] axis=0 indices=[0, 1, 0, 0, 1]
  local a=np.array({-3,0},np.int8)
  local r=np.add_reduceat(a,{1,-1,-2,1,2},{axis=1})
  assert(r.dtype=="int64","reduceat 156 dtype "..r.dtype)
  assert(close(r.shape,{5}),"reduceat 156 shape")
  assert(close(r.strides,{8}),"reduceat 156 strides")
  assert(close(r:tolist(),{-3,0,-3,-3,0}),"reduceat 156 values")
end
do -- reduceat 157: add int16 [4, 2] axis=0 indices=[]
  local a=np.array({{-2,1},{4,-4},{-1,2},{5,-3}},np.int16)
  local r=np.add_reduceat(a,{},{axis=1})
  assert(r.dtype=="int64","reduceat 157 dtype "..r.dtype)
  assert(close(r.shape,{0,2}),"reduceat 157 shape")
  assert(close(r.strides,{0,0}),"reduceat 157 strides")
  assert(close(r:tolist(),{}),"reduceat 157 values")
end
do -- reduceat 158: multiply float16 [0, 0] axis=0 indices=[]
  local a=np.zeros({0,0},np.float16)
  local r=np.multiply_reduceat(a,{},{axis=1,dtype=np.bool})
  assert(r.dtype=="bool","reduceat 158 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"reduceat 158 shape")
  assert(close(r.strides,{0,0}),"reduceat 158 strides")
  assert(close(r:tolist(),{}),"reduceat 158 values")
end
do -- reduceat 159: add int64 [0, 3, 0] axis=0 indices=[]
  local a=np.zeros({0,3,0},np.int64)
  local o=np.zeros({0,3,0},np.float16)
  local r=np.add_reduceat(a,{},{axis=1,out=o})
  assert(r==o,"reduceat 159 out identity")
  assert(r.dtype=="float16","reduceat 159 dtype "..r.dtype)
  assert(close(r.shape,{0,3,0}),"reduceat 159 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 159 strides")
  assert(close(r:tolist(),{}),"reduceat 159 values")
end
do -- reduceat 160: multiply uint32 [1, 4, 2] axis=0 indices=[0, 0]
  local a=np.array({{{1,2},{3,4},{1,2},{3,4}}},np.uint32)
  local r=np.multiply_reduceat(a,{-1,1},{axis=1})
  assert(r.dtype=="uint64","reduceat 160 dtype "..r.dtype)
  assert(close(r.shape,{2,4,2}),"reduceat 160 shape")
  assert(close(r.strides,{64,16,8}),"reduceat 160 strides")
  assert(close(r:tolist(),{{{1,2},{3,4},{1,2},{3,4}},{{1,2},{3,4},{1,2},{3,4}}}),"reduceat 160 values")
end
do -- reduceat 161: multiply uint8 [1, 0, 1] axis=1 indices=[]
  local a=np.zeros({1,0,1},np.uint8)
  local o=np.zeros({1,0,1},np.float32)
  local r=np.multiply_reduceat(a,{},{axis=2,dtype=np.int8,out=o})
  assert(r==o,"reduceat 161 out identity")
  assert(r.dtype=="float32","reduceat 161 dtype "..r.dtype)
  assert(close(r.shape,{1,0,1}),"reduceat 161 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 161 strides")
  assert(close(r:tolist(),{{}}),"reduceat 161 values")
end
do -- reduceat 162: multiply uint8 [2, 2, 3, 3] axis=1 indices=[]
  local a=np.array({{{{3,4,1},{2,3,4},{1,2,3}},{{4,1,2},{3,4,1},{2,3,4}}},{{{1,2,3},{4,1,2},{3,4,1}},{{2,3,4},{1,2,3},{4,1,2}}}},np.uint8)
  local r=np.multiply_reduceat(a,{},{axis=2,dtype=np.uint16})
  assert(r.dtype=="uint16","reduceat 162 dtype "..r.dtype)
  assert(close(r.shape,{2,0,3,3}),"reduceat 162 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 162 strides")
  assert(close(r:tolist(),{{},{}}),"reduceat 162 values")
end
do -- reduceat 163: add int16 [4] axis=0 indices=[0, 3]
  local a=np.array({4,-4,-1,2},np.int16)
  local r=np.add_reduceat(a,{1,4},{axis=1})
  assert(r.dtype=="int64","reduceat 163 dtype "..r.dtype)
  assert(close(r.shape,{2}),"reduceat 163 shape")
  assert(close(r.strides,{8}),"reduceat 163 strides")
  assert(close(r:tolist(),{-1,2}),"reduceat 163 values")
end
do -- reduceat 164: multiply float32 [4, 0, 1, 1] axis=1 indices=[]
  local a=np.zeros({4,0,1,1},np.float32)
  local o=np.zeros({4,0,1,1},np.int8)
  local r=np.multiply_reduceat(a,{},{axis=2,out=o})
  assert(r==o,"reduceat 164 out identity")
  assert(r.dtype=="int8","reduceat 164 dtype "..r.dtype)
  assert(close(r.shape,{4,0,1,1}),"reduceat 164 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 164 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"reduceat 164 values")
end
do -- reduceat 165: multiply int8 [1] axis=0 indices=[0, 0, 0, 0]
  local a=np.array({-2},np.int8)
  local r=np.multiply_reduceat(a,{1,1,-1,-1},{axis=1})
  assert(r.dtype=="int64","reduceat 165 dtype "..r.dtype)
  assert(close(r.shape,{4}),"reduceat 165 shape")
  assert(close(r.strides,{8}),"reduceat 165 strides")
  assert(close(r:tolist(),{-2,-2,-2,-2}),"reduceat 165 values")
end
do -- reduceat 166: add uint16 [1, 4] axis=1 indices=[3, 2]
  local a=np.array({{6,1,4,7}},np.uint16)
  local r=np.add_reduceat(a,{-1,3},{axis=2})
  assert(r.dtype=="uint64","reduceat 166 dtype "..r.dtype)
  assert(close(r.shape,{1,2}),"reduceat 166 shape")
  assert(close(r.strides,{16,8}),"reduceat 166 strides")
  assert(close(r:tolist(),{{7,11}}),"reduceat 166 values")
end
do -- reduceat 167: multiply int8 [4, 4, 3, 3] axis=0 indices=[1, 0, 2, 2, 1]
  local a=np.array({{{{0,1,2},{-2,-1,0},{1,2,-2}},{{-1,0,1},{2,-2,-1},{0,1,2}},{{-2,-1,0},{1,2,-2},{-1,0,1}},{{2,-2,-1},{0,1,2},{-2,-1,0}}},{{{1,2,-2},{-1,0,1},{2,-2,-1}},{{0,1,2},{-2,-1,0},{1,2,-2}},{{-1,0,1},{2,-2,-1},{0,1,2}},{{-2,-1,0},{1,2,-2},{-1,0,1}}},{{{2,-2,-1},{0,1,2},{-2,-1,0}},{{1,2,-2},{-1,0,1},{2,-2,-1}},{{0,1,2},{-2,-1,0},{1,2,-2}},{{-1,0,1},{2,-2,-1},{0,1,2}}},{{{-2,-1,0},{1,2,-2},{-1,0,1}},{{2,-2,-1},{0,1,2},{-2,-1,0}},{{1,2,-2},{-1,0,1},{2,-2,-1}},{{0,1,2},{-2,-1,0},{1,2,-2}}}},np.int8)
  local r=np.multiply_reduceat(a,{2,1,3,-2,2},{axis=1,dtype=np.uint32})
  assert(r.dtype=="uint32","reduceat 167 dtype "..r.dtype)
  assert(close(r.shape,{5,4,3,3}),"reduceat 167 shape")
  assert(close(r.strides,{144,36,12,4}),"reduceat 167 strides")
  assert(close(r:tolist(),{{{{1,2,4294967294},{4294967295,0,1},{2,4294967294,4294967295}},{{0,1,2},{4294967294,4294967295,0},{1,2,4294967294}},{{4294967295,0,1},{2,4294967294,4294967295},{0,1,2}},{{4294967294,4294967295,0},{1,2,4294967294},{4294967295,0,1}}},{{{0,2,4294967292},{2,0,0},{2,4294967292,2}},{{0,0,2},{4294967292,2,0},{0,2,4294967292}},{{2,0,0},{2,4294967292,2},{0,0,2}},{{4294967292,2,0},{0,2,4294967292},{2,0,0}}},{{{2,4294967294,4294967295},{0,1,2},{4294967294,4294967295,0}},{{1,2,4294967294},{4294967295,0,1},{2,4294967294,4294967295}},{{0,1,2},{4294967294,4294967295,0},{1,2,4294967294}},{{4294967295,0,1},{2,4294967294,4294967295},{0,1,2}}},{{{2,4294967294,4294967295},{0,1,2},{4294967294,4294967295,0}},{{1,2,4294967294},{4294967295,0,1},{2,4294967294,4294967295}},{{0,1,2},{4294967294,4294967295,0},{1,2,4294967294}},{{4294967295,0,1},{2,4294967294,4294967295},{0,1,2}}},{{{4294967292,4,0},{0,0,4294967292},{4,0,0}},{{0,4294967292,4},{0,0,0},{4294967292,4,0}},{{0,0,4294967292},{4,0,0},{0,4294967292,4}},{{0,0,0},{4294967292,4,0},{0,0,4294967292}}}}),"reduceat 167 values")
end
do -- reduceat 168: multiply bool [4] axis=0 indices=[0, 3, 0, 2]
  local a=np.array({false,true,true,false},np.bool)
  local r=np.multiply_reduceat(a,{1,4,1,-2},{axis=1})
  assert(r.dtype=="int64","reduceat 168 dtype "..r.dtype)
  assert(close(r.shape,{4}),"reduceat 168 shape")
  assert(close(r.strides,{8}),"reduceat 168 strides")
  assert(close(r:tolist(),{0,0,0,0}),"reduceat 168 values")
end
do -- reduceat 169: multiply int32 [4] axis=0 indices=[]
  local a=np.array({2,-2,-1,0},np.int32)
  local r=np.multiply_reduceat(a,{},{axis=1})
  assert(r.dtype=="int64","reduceat 169 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 169 shape")
  assert(close(r.strides,{0}),"reduceat 169 strides")
  assert(close(r:tolist(),{}),"reduceat 169 values")
end
do -- reduceat 170: add float16 [0] axis=0 indices=[]
  local a=np.zeros({0},np.float16)
  local r=np.add_reduceat(a,{},{axis=1})
  assert(r.dtype=="float16","reduceat 170 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 170 shape")
  assert(close(r.strides,{0}),"reduceat 170 strides")
  assert(close(r:tolist(),{}),"reduceat 170 values")
end
do -- reduceat 171: multiply int8 [1, 2, 1, 0] axis=2 indices=[0, 0, 0, 0]
  local a=np.zeros({1,2,1,0},np.int8)
  local r=np.multiply_reduceat(a,{1,1,1,1},{axis=3})
  assert(r.dtype=="int64","reduceat 171 dtype "..r.dtype)
  assert(close(r.shape,{1,2,4,0}),"reduceat 171 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 171 strides")
  assert(close(r:tolist(),{{{{},{},{},{}},{{},{},{},{}}}}),"reduceat 171 values")
end
do -- reduceat 172: multiply uint32 [3, 3, 3, 0] axis=0 indices=[1, 2]
  local a=np.zeros({3,3,3,0},np.uint32)
  local r=np.multiply_reduceat(a,{2,3},{axis=1,dtype=np.bool})
  assert(r.dtype=="bool","reduceat 172 dtype "..r.dtype)
  assert(close(r.shape,{2,3,3,0}),"reduceat 172 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 172 strides")
  assert(close(r:tolist(),{{{{},{},{}},{{},{},{}},{{},{},{}}},{{{},{},{}},{{},{},{}},{{},{},{}}}}),"reduceat 172 values")
end
do -- reduceat 173: multiply bool [4, 2] axis=0 indices=[1, 2, 2]
  local a=np.array({{true,true},{false,true},{true,false},{true,true}},np.bool)
  local r=np.multiply_reduceat(a,{2,-2,3},{axis=1,dtype=np.float32})
  assert(r.dtype=="float32","reduceat 173 dtype "..r.dtype)
  assert(close(r.shape,{3,2}),"reduceat 173 shape")
  assert(close(r.strides,{8,4}),"reduceat 173 strides")
  assert(close(r:tolist(),{{0.0,1.0},{1.0,0.0},{1.0,0.0}}),"reduceat 173 values")
end
do -- reduceat 174: add uint64 [4, 0, 2] axis=2 indices=[1]
  local a=np.zeros({4,0,2},np.uint64)
  local r=np.add_reduceat(a,{2},{axis=3})
  assert(r.dtype=="uint64","reduceat 174 dtype "..r.dtype)
  assert(close(r.shape,{4,0,1}),"reduceat 174 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 174 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"reduceat 174 values")
end
do -- reduceat 175: add int64 [1] axis=0 indices=[]
  local a=np.array({5},np.int64)
  local r=np.add_reduceat(a,{},{axis=1})
  assert(r.dtype=="int64","reduceat 175 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 175 shape")
  assert(close(r.strides,{0}),"reduceat 175 strides")
  assert(close(r:tolist(),{}),"reduceat 175 values")
end
do -- reduceat 176: add float32 [4] axis=0 indices=[]
  local a=np.array({0.375,1.5,-0.75,0.375},np.float32)
  local r=np.add_reduceat(a,{},{axis=1})
  assert(r.dtype=="float32","reduceat 176 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 176 shape")
  assert(close(r.strides,{0}),"reduceat 176 strides")
  assert(close(r:tolist(),{}),"reduceat 176 values")
end
do -- reduceat 177: multiply bool [4, 4] axis=0 indices=[2, 1, 2, 1, 1, 2]
  local a=np.array({{false,true,true,false},{true,true,false,true},{true,false,true,true},{false,true,true,false}},np.bool)
  local r=np.multiply_reduceat(a,{3,2,3,2,2,-2},{axis=1,dtype=np.float64})
  assert(r.dtype=="float64","reduceat 177 dtype "..r.dtype)
  assert(close(r.shape,{6,4}),"reduceat 177 shape")
  assert(close(r.strides,{32,8}),"reduceat 177 strides")
  assert(close(r:tolist(),{{1.0,0.0,1.0,1.0},{1.0,1.0,0.0,1.0},{1.0,0.0,1.0,1.0},{1.0,1.0,0.0,1.0},{1.0,1.0,0.0,1.0},{0.0,0.0,1.0,0.0}}),"reduceat 177 values")
end
do -- reduceat 178: multiply int64 [1, 0, 3, 3] axis=1 indices=[]
  local a=np.zeros({1,0,3,3},np.int64)
  local r=np.multiply_reduceat(a,{},{axis=2})
  assert(r.dtype=="int64","reduceat 178 dtype "..r.dtype)
  assert(close(r.shape,{1,0,3,3}),"reduceat 178 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 178 strides")
  assert(close(r:tolist(),{{}}),"reduceat 178 values")
end
do -- reduceat 179: add float64 [2, 0] axis=0 indices=[0]
  local a=np.zeros({2,0},np.float64)
  local r=np.add_reduceat(a,{1},{axis=1})
  assert(r.dtype=="float64","reduceat 179 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"reduceat 179 shape")
  assert(close(r.strides,{0,0}),"reduceat 179 strides")
  assert(close(r:tolist(),{{}}),"reduceat 179 values")
end
do -- reduceat 180: multiply float64 [1] axis=0 indices=[0, 0, 0, 0]
  local a=np.array({0.6},np.float64)
  local r=np.multiply_reduceat(a,{1,1,-1,-1},{axis=1,dtype=np.int32})
  assert(r.dtype=="int32","reduceat 180 dtype "..r.dtype)
  assert(close(r.shape,{4}),"reduceat 180 shape")
  assert(close(r.strides,{4}),"reduceat 180 strides")
  assert(close(r:tolist(),{0,0,0,0}),"reduceat 180 values")
end
do -- reduceat 181: add float32 [4, 4, 4] axis=1 indices=[1, 2]
  local a=np.array({{{-1.125,0.0,1.125,-1.125},{0.0,1.125,-1.125,0.0},{1.125,-1.125,0.0,1.125},{-1.125,0.0,1.125,-1.125}},{{0.0,1.125,-1.125,0.0},{1.125,-1.125,0.0,1.125},{-1.125,0.0,1.125,-1.125},{0.0,1.125,-1.125,0.0}},{{1.125,-1.125,0.0,1.125},{-1.125,0.0,1.125,-1.125},{0.0,1.125,-1.125,0.0},{1.125,-1.125,0.0,1.125}},{{-1.125,0.0,1.125,-1.125},{0.0,1.125,-1.125,0.0},{1.125,-1.125,0.0,1.125},{-1.125,0.0,1.125,-1.125}}},np.float32)
  local o=np.zeros({4,2,4},np.bool)
  local r=np.add_reduceat(a,{2,-2},{axis=2,out=o})
  assert(r==o,"reduceat 181 out identity")
  assert(r.dtype=="bool","reduceat 181 dtype "..r.dtype)
  assert(close(r.shape,{4,2,4}),"reduceat 181 shape")
  assert(close(r.strides,{8,4,1}),"reduceat 181 strides")
  assert(close(r:tolist(),{{{false,true,true,false},{false,true,true,false}},{{true,true,false,true},{true,true,false,true}},{{true,false,true,true},{true,false,true,true}},{{false,true,true,false},{false,true,true,false}}}),"reduceat 181 values")
end
do -- reduceat 182: add int16 [2, 1, 4, 4] axis=0 indices=[1]
  local a=np.array({{{{1,4,-4,-1},{2,5,-3,0},{3,-5,-2,1},{4,-4,-1,2}}},{{{5,-3,0,3},{-5,-2,1,4},{-4,-1,2,5},{-3,0,3,-5}}}},np.int16)
  local o=np.zeros({1,1,4,4},np.int64)
  local r=np.add_reduceat(a,{2},{axis=1,out=o})
  assert(r==o,"reduceat 182 out identity")
  assert(r.dtype=="int64","reduceat 182 dtype "..r.dtype)
  assert(close(r.shape,{1,1,4,4}),"reduceat 182 shape")
  assert(close(r.strides,{128,128,32,8}),"reduceat 182 strides")
  assert(close(r:tolist(),{{{{5,-3,0,3},{-5,-2,1,4},{-4,-1,2,5},{-3,0,3,-5}}}}),"reduceat 182 values")
end
do -- reduceat 183: add uint32 [3, 3] axis=1 indices=[1, 1, 2, 2, 1]
  local a=np.array({{7,2,5},{0,3,6},{1,4,7}},np.uint32)
  local r=np.add_reduceat(a,{2,2,3,3,2},{axis=2,dtype=np.uint64})
  assert(r.dtype=="uint64","reduceat 183 dtype "..r.dtype)
  assert(close(r.shape,{3,5}),"reduceat 183 shape")
  assert(close(r.strides,{40,8}),"reduceat 183 strides")
  assert(close(r:tolist(),{{2,2,5,5,7},{3,3,6,6,9},{4,4,7,7,11}}),"reduceat 183 values")
end
do -- reduceat 184: multiply float64 [3, 0] axis=0 indices=[2, 0]
  local a=np.zeros({3,0},np.float64)
  local o=np.zeros({2,0},np.uint8)
  local r=np.multiply_reduceat(a,{-1,1},{axis=1,out=o})
  assert(r==o,"reduceat 184 out identity")
  assert(r.dtype=="uint8","reduceat 184 dtype "..r.dtype)
  assert(close(r.shape,{2,0}),"reduceat 184 shape")
  assert(close(r.strides,{0,0}),"reduceat 184 strides")
  assert(close(r:tolist(),{{},{}}),"reduceat 184 values")
end
do -- reduceat 185: add int64 [4, 2, 4, 2] axis=2 indices=[3, 3]
  local a=np.array({{{{4,-4},{-1,2},{5,-3},{0,3}},{{-5,-2},{1,4},{-4,-1},{2,5}}},{{{-3,0},{3,-5},{-2,1},{4,-4}},{{-1,2},{5,-3},{0,3},{-5,-2}}},{{{1,4},{-4,-1},{2,5},{-3,0}},{{3,-5},{-2,1},{4,-4},{-1,2}}},{{{5,-3},{0,3},{-5,-2},{1,4}},{{-4,-1},{2,5},{-3,0},{3,-5}}}},np.int64)
  local r=np.add_reduceat(a,{4,4},{axis=3})
  assert(r.dtype=="int64","reduceat 185 dtype "..r.dtype)
  assert(close(r.shape,{4,2,2,2}),"reduceat 185 shape")
  assert(close(r.strides,{64,32,16,8}),"reduceat 185 strides")
  assert(close(r:tolist(),{{{{0,3},{0,3}},{{2,5},{2,5}}},{{{4,-4},{4,-4}},{{-5,-2},{-5,-2}}},{{{-3,0},{-3,0}},{{-1,2},{-1,2}}},{{{1,4},{1,4}},{{3,-5},{3,-5}}}}),"reduceat 185 values")
end
do -- reduceat 186: multiply uint64 [2, 0, 2, 0] axis=1 indices=[]
  local a=np.zeros({2,0,2,0},np.uint64)
  local o=np.zeros({2,0,2,0},np.int16)
  local r=np.multiply_reduceat(a,{},{axis=2,dtype=np.uint16,out=o})
  assert(r==o,"reduceat 186 out identity")
  assert(r.dtype=="int16","reduceat 186 dtype "..r.dtype)
  assert(close(r.shape,{2,0,2,0}),"reduceat 186 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 186 strides")
  assert(close(r:tolist(),{{},{}}),"reduceat 186 values")
end
do -- reduceat 187: multiply int16 [4, 0, 3] axis=2 indices=[]
  local a=np.zeros({4,0,3},np.int16)
  local r=np.multiply_reduceat(a,{},{axis=3})
  assert(r.dtype=="int64","reduceat 187 dtype "..r.dtype)
  assert(close(r.shape,{4,0,0}),"reduceat 187 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 187 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"reduceat 187 values")
end
do -- reduceat 188: add bool [2, 3, 0] axis=0 indices=[1]
  local a=np.zeros({2,3,0},np.bool)
  local o=np.zeros({1,3,0},np.int8)
  local r=np.add_reduceat(a,{2},{axis=1,out=o})
  assert(r==o,"reduceat 188 out identity")
  assert(r.dtype=="int8","reduceat 188 dtype "..r.dtype)
  assert(close(r.shape,{1,3,0}),"reduceat 188 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 188 strides")
  assert(close(r:tolist(),{{{},{},{}}}),"reduceat 188 values")
end
do -- reduceat 189: add bool [4, 4, 2, 1] axis=1 indices=[0]
  local a=np.array({{{{false},{true}},{{true},{false}},{{true},{true}},{{false},{true}}},{{{true},{false}},{{true},{true}},{{false},{true}},{{true},{false}}},{{{true},{true}},{{false},{true}},{{true},{false}},{{true},{true}}},{{{false},{true}},{{true},{false}},{{true},{true}},{{false},{true}}}},np.bool)
  local o=np.zeros({4,1,2,1},np.int32)
  local r=np.add_reduceat(a,{-4},{axis=2,out=o})
  assert(r==o,"reduceat 189 out identity")
  assert(r.dtype=="int32","reduceat 189 dtype "..r.dtype)
  assert(close(r.shape,{4,1,2,1}),"reduceat 189 shape")
  assert(close(r.strides,{8,8,4,4}),"reduceat 189 strides")
  assert(close(r:tolist(),{{{{2},{3}}},{{{3},{2}}},{{{3},{3}}},{{{2},{3}}}}),"reduceat 189 values")
end
do -- reduceat 190: add float32 [2] axis=0 indices=[]
  local a=np.array({-1.125,0.0},np.float32)
  local r=np.add_reduceat(a,{},{axis=1})
  assert(r.dtype=="float32","reduceat 190 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 190 shape")
  assert(close(r.strides,{0}),"reduceat 190 strides")
  assert(close(r:tolist(),{}),"reduceat 190 values")
end
do -- reduceat 191: add uint16 [1, 4, 3, 0] axis=2 indices=[0, 0, 1, 2, 2, 0]
  local a=np.zeros({1,4,3,0},np.uint16)
  local r=np.add_reduceat(a,{1,1,2,3,3,-3},{axis=3})
  assert(r.dtype=="uint64","reduceat 191 dtype "..r.dtype)
  assert(close(r.shape,{1,4,6,0}),"reduceat 191 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 191 strides")
  assert(close(r:tolist(),{{{{},{},{},{},{},{}},{{},{},{},{},{},{}},{{},{},{},{},{},{}},{{},{},{},{},{},{}}}}),"reduceat 191 values")
end
do -- reduceat 192: add uint8 [4, 4] axis=0 indices=[]
  local a=np.array({{0,3,6,1},{4,7,2,5},{0,3,6,1},{4,7,2,5}},np.uint8)
  local r=np.add_reduceat(a,{},{axis=1,dtype=np.uint16})
  assert(r.dtype=="uint16","reduceat 192 dtype "..r.dtype)
  assert(close(r.shape,{0,4}),"reduceat 192 shape")
  assert(close(r.strides,{0,0}),"reduceat 192 strides")
  assert(close(r:tolist(),{}),"reduceat 192 values")
end
do -- reduceat 193: add float16 [4] axis=0 indices=[0, 3, 0, 3]
  local a=np.array({0.0,1.125,-1.125,0.0},np.float16)
  local r=np.add_reduceat(a,{1,4,1,-1},{axis=1})
  assert(r.dtype=="float16","reduceat 193 dtype "..r.dtype)
  assert(close(r.shape,{4}),"reduceat 193 shape")
  assert(close(r.strides,{2}),"reduceat 193 strides")
  assert(close(r:tolist(),{0.0,0.0,0.0,0.0}),"reduceat 193 values")
end
do -- reduceat 194: multiply int64 [0, 1] axis=0 indices=[]
  local a=np.zeros({0,1},np.int64)
  local r=np.multiply_reduceat(a,{},{axis=1})
  assert(r.dtype=="int64","reduceat 194 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"reduceat 194 shape")
  assert(close(r.strides,{0,0}),"reduceat 194 strides")
  assert(close(r:tolist(),{}),"reduceat 194 values")
end
do -- reduceat 195: add int64 [1, 3] axis=0 indices=[0, 0, 0, 0]
  local a=np.array({{3,-5,-2}},np.int64)
  local r=np.add_reduceat(a,{-1,1,1,1},{axis=1,dtype=np.int8})
  assert(r.dtype=="int8","reduceat 195 dtype "..r.dtype)
  assert(close(r.shape,{4,3}),"reduceat 195 shape")
  assert(close(r.strides,{3,1}),"reduceat 195 strides")
  assert(close(r:tolist(),{{3,-5,-2},{3,-5,-2},{3,-5,-2},{3,-5,-2}}),"reduceat 195 values")
end
do -- reduceat 196: multiply float16 [3, 2] axis=0 indices=[0, 2, 0, 0]
  local a=(np.array({{0.8,1.0,1.2},{1.4,0.6,0.8}},np.float16)).T
  local r=np.multiply_reduceat(a,{1,-1,1,1},{axis=1})
  assert(r.dtype=="float16","reduceat 196 dtype "..r.dtype)
  assert(close(r.shape,{4,2}),"reduceat 196 shape")
  assert(close(r.strides,{4,2}),"reduceat 196 strides")
  assert(close(r:tolist(),{{0.7998046875,0.84033203125},{1.2001953125,0.7998046875},{0.7998046875,1.400390625},{0.9599609375,0.67236328125}}),"reduceat 196 values")
end
do -- reduceat 197: add int16 [0, 3, 1, 4] axis=1 indices=[2, 2, 0, 2, 1, 1]
  local a=np.zeros({0,3,1,4},np.int16)
  local r=np.add_reduceat(a,{3,-1,1,3,-2,-2},{axis=2,dtype=np.int8})
  assert(r.dtype=="int8","reduceat 197 dtype "..r.dtype)
  assert(close(r.shape,{0,6,1,4}),"reduceat 197 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 197 strides")
  assert(close(r:tolist(),{}),"reduceat 197 values")
end
do -- reduceat 198: multiply uint16 [3, 0] axis=0 indices=[1]
  local a=np.zeros({3,0},np.uint16)
  local o=np.zeros({1,0},np.uint32)
  local r=np.multiply_reduceat(a,{-2},{axis=1,out=o})
  assert(r==o,"reduceat 198 out identity")
  assert(r.dtype=="uint32","reduceat 198 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"reduceat 198 shape")
  assert(close(r.strides,{0,0}),"reduceat 198 strides")
  assert(close(r:tolist(),{{}}),"reduceat 198 values")
end
do -- reduceat 199: add uint32 [4] axis=0 indices=[3, 0, 0]
  local a=np.array({7,2,5,0},np.uint32)
  local r=np.add_reduceat(a,{4,1,1},{axis=1})
  assert(r.dtype=="uint64","reduceat 199 dtype "..r.dtype)
  assert(close(r.shape,{3}),"reduceat 199 shape")
  assert(close(r.strides,{8}),"reduceat 199 strides")
  assert(close(r:tolist(),{0,7,14}),"reduceat 199 values")
end
do -- reduceat 200: add float16 [3, 4, 3, 1] axis=3 indices=[0, 0]
  local a=(np.array({{{{-0.75,0.375,1.5},{-0.75,0.375,1.5},{-0.75,0.375,1.5},{-0.75,0.375,1.5}},{{-0.75,0.375,1.5},{-0.75,0.375,1.5},{-0.75,0.375,1.5},{-0.75,0.375,1.5}},{{-0.75,0.375,1.5},{-0.75,0.375,1.5},{-0.75,0.375,1.5},{-0.75,0.375,1.5}}}},np.float16)).T
  local r=np.add_reduceat(a,{1,1},{axis=4,dtype=np.int32})
  assert(r.dtype=="int32","reduceat 200 dtype "..r.dtype)
  assert(close(r.shape,{3,4,3,2}),"reduceat 200 shape")
  assert(close(r.strides,{8,24,96,4}),"reduceat 200 strides")
  assert(close(r:tolist(),{{{{0,0},{0,0},{0,0}},{{0,0},{0,0},{0,0}},{{0,0},{0,0},{0,0}},{{0,0},{0,0},{0,0}}},{{{0,0},{0,0},{0,0}},{{0,0},{0,0},{0,0}},{{0,0},{0,0},{0,0}},{{0,0},{0,0},{0,0}}},{{{1,1},{1,1},{1,1}},{{1,1},{1,1},{1,1}},{{1,1},{1,1},{1,1}},{{1,1},{1,1},{1,1}}}}),"reduceat 200 values")
end
do -- reduceat 201: add float16 [1, 4] axis=0 indices=[0, 0, 0]
  local a=np.array({{-0.375,0.75,-1.5,-0.375}},np.float16)
  local o=np.zeros({3,4},np.int32)
  local r=np.add_reduceat(a,{-1,1,1},{axis=1,out=o})
  assert(r==o,"reduceat 201 out identity")
  assert(r.dtype=="int32","reduceat 201 dtype "..r.dtype)
  assert(close(r.shape,{3,4}),"reduceat 201 shape")
  assert(close(r.strides,{16,4}),"reduceat 201 strides")
  assert(close(r:tolist(),{{0,0,-1,0},{0,0,-1,0},{0,0,-1,0}}),"reduceat 201 values")
end
do -- reduceat 202: multiply float32 [1, 4, 3] axis=2 indices=[]
  local a=np.array({{{1.0,1.2,1.4},{0.6,0.8,1.0},{1.2,1.4,0.6},{0.8,1.0,1.2}}},np.float32)
  local o=np.zeros({1,4,0},np.int8)
  local r=np.multiply_reduceat(a,{},{axis=3,out=o})
  assert(r==o,"reduceat 202 out identity")
  assert(r.dtype=="int8","reduceat 202 dtype "..r.dtype)
  assert(close(r.shape,{1,4,0}),"reduceat 202 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 202 strides")
  assert(close(r:tolist(),{{{},{},{},{}}}),"reduceat 202 values")
end
do -- reduceat 203: multiply uint16 [0, 0, 3, 4] axis=0 indices=[]
  local a=np.zeros({0,0,3,4},np.uint16)
  local r=np.multiply_reduceat(a,{},{axis=1})
  assert(r.dtype=="uint64","reduceat 203 dtype "..r.dtype)
  assert(close(r.shape,{0,0,3,4}),"reduceat 203 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 203 strides")
  assert(close(r:tolist(),{}),"reduceat 203 values")
end
do -- reduceat 204: add uint16 [3, 4, 3, 4] axis=0 indices=[1, 2, 0, 2, 2]
  local a=np.array({{{{4,7,2,5},{0,3,6,1},{4,7,2,5}},{{0,3,6,1},{4,7,2,5},{0,3,6,1}},{{4,7,2,5},{0,3,6,1},{4,7,2,5}},{{0,3,6,1},{4,7,2,5},{0,3,6,1}}},{{{4,7,2,5},{0,3,6,1},{4,7,2,5}},{{0,3,6,1},{4,7,2,5},{0,3,6,1}},{{4,7,2,5},{0,3,6,1},{4,7,2,5}},{{0,3,6,1},{4,7,2,5},{0,3,6,1}}},{{{4,7,2,5},{0,3,6,1},{4,7,2,5}},{{0,3,6,1},{4,7,2,5},{0,3,6,1}},{{4,7,2,5},{0,3,6,1},{4,7,2,5}},{{0,3,6,1},{4,7,2,5},{0,3,6,1}}}},np.uint16)
  local r=np.add_reduceat(a,{-2,3,1,3,-1},{axis=1})
  assert(r.dtype=="uint64","reduceat 204 dtype "..r.dtype)
  assert(close(r.shape,{5,4,3,4}),"reduceat 204 shape")
  assert(close(r.strides,{384,96,32,8}),"reduceat 204 strides")
  assert(close(r:tolist(),{{{{4,7,2,5},{0,3,6,1},{4,7,2,5}},{{0,3,6,1},{4,7,2,5},{0,3,6,1}},{{4,7,2,5},{0,3,6,1},{4,7,2,5}},{{0,3,6,1},{4,7,2,5},{0,3,6,1}}},{{{4,7,2,5},{0,3,6,1},{4,7,2,5}},{{0,3,6,1},{4,7,2,5},{0,3,6,1}},{{4,7,2,5},{0,3,6,1},{4,7,2,5}},{{0,3,6,1},{4,7,2,5},{0,3,6,1}}},{{{8,14,4,10},{0,6,12,2},{8,14,4,10}},{{0,6,12,2},{8,14,4,10},{0,6,12,2}},{{8,14,4,10},{0,6,12,2},{8,14,4,10}},{{0,6,12,2},{8,14,4,10},{0,6,12,2}}},{{{4,7,2,5},{0,3,6,1},{4,7,2,5}},{{0,3,6,1},{4,7,2,5},{0,3,6,1}},{{4,7,2,5},{0,3,6,1},{4,7,2,5}},{{0,3,6,1},{4,7,2,5},{0,3,6,1}}},{{{4,7,2,5},{0,3,6,1},{4,7,2,5}},{{0,3,6,1},{4,7,2,5},{0,3,6,1}},{{4,7,2,5},{0,3,6,1},{4,7,2,5}},{{0,3,6,1},{4,7,2,5},{0,3,6,1}}}}),"reduceat 204 values")
end
do -- reduceat 205: multiply uint64 [0, 0, 0, 4] axis=3 indices=[1]
  local a=np.zeros({0,0,0,4},np.uint64)
  local r=np.multiply_reduceat(a,{2},{axis=4})
  assert(r.dtype=="uint64","reduceat 205 dtype "..r.dtype)
  assert(close(r.shape,{0,0,0,1}),"reduceat 205 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 205 strides")
  assert(close(r:tolist(),{}),"reduceat 205 values")
end
do -- reduceat 206: multiply uint8 [1, 3, 2] axis=0 indices=[0]
  local a=np.array({{{3,4},{1,2},{3,4}}},np.uint8)
  local r=np.multiply_reduceat(a,{-1},{axis=1})
  assert(r.dtype=="uint64","reduceat 206 dtype "..r.dtype)
  assert(close(r.shape,{1,3,2}),"reduceat 206 shape")
  assert(close(r.strides,{48,16,8}),"reduceat 206 strides")
  assert(close(r:tolist(),{{{3,4},{1,2},{3,4}}}),"reduceat 206 values")
end
do -- reduceat 207: add uint32 [2, 0, 1, 4] axis=2 indices=[]
  local a=np.zeros({2,0,1,4},np.uint32)
  local r=np.add_reduceat(a,{},{axis=3})
  assert(r.dtype=="uint64","reduceat 207 dtype "..r.dtype)
  assert(close(r.shape,{2,0,0,4}),"reduceat 207 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 207 strides")
  assert(close(r:tolist(),{{},{}}),"reduceat 207 values")
end
do -- reduceat 208: multiply int8 [4, 4, 2, 3] axis=1 indices=[2, 3, 0, 3, 2]
  local a=np.array({{{{1,2,-2},{-1,0,1}},{{2,-2,-1},{0,1,2}},{{-2,-1,0},{1,2,-2}},{{-1,0,1},{2,-2,-1}}},{{{0,1,2},{-2,-1,0}},{{1,2,-2},{-1,0,1}},{{2,-2,-1},{0,1,2}},{{-2,-1,0},{1,2,-2}}},{{{-1,0,1},{2,-2,-1}},{{0,1,2},{-2,-1,0}},{{1,2,-2},{-1,0,1}},{{2,-2,-1},{0,1,2}}},{{{-2,-1,0},{1,2,-2}},{{-1,0,1},{2,-2,-1}},{{0,1,2},{-2,-1,0}},{{1,2,-2},{-1,0,1}}}},np.int8)
  local r=np.multiply_reduceat(a,{3,4,1,4,3},{axis=2,dtype=np.int64})
  assert(r.dtype=="int64","reduceat 208 dtype "..r.dtype)
  assert(close(r.shape,{4,5,2,3}),"reduceat 208 shape")
  assert(close(r.strides,{240,48,24,8}),"reduceat 208 strides")
  assert(close(r:tolist(),{{{{-2,-1,0},{1,2,-2}},{{-1,0,1},{2,-2,-1}},{{-4,4,0},{0,0,-4}},{{-1,0,1},{2,-2,-1}},{{2,0,0},{2,-4,2}}},{{{2,-2,-1},{0,1,2}},{{-2,-1,0},{1,2,-2}},{{0,-4,4},{0,0,0}},{{-2,-1,0},{1,2,-2}},{{-4,2,0},{0,2,-4}}},{{{1,2,-2},{-1,0,1}},{{2,-2,-1},{0,1,2}},{{0,0,-4},{4,0,0}},{{2,-2,-1},{0,1,2}},{{2,-4,2},{0,0,2}}},{{{0,1,2},{-2,-1,0}},{{1,2,-2},{-1,0,1}},{{0,0,0},{-4,4,0}},{{1,2,-2},{-1,0,1}},{{0,2,-4},{2,0,0}}}}),"reduceat 208 values")
end
do -- reduceat 209: add uint16 [4] axis=0 indices=[3]
  local a=np.array({1,4,7,2},np.uint16)
  local r=np.add_reduceat(a,{4},{axis=1})
  assert(r.dtype=="uint64","reduceat 209 dtype "..r.dtype)
  assert(close(r.shape,{1}),"reduceat 209 shape")
  assert(close(r.strides,{8}),"reduceat 209 strides")
  assert(close(r:tolist(),{2}),"reduceat 209 values")
end
do -- reduceat 210: add uint32 [1] axis=0 indices=[0, 0, 0]
  local a=np.array({2},np.uint32)
  local r=np.add_reduceat(a,{-1,1,1},{axis=1})
  assert(r.dtype=="uint64","reduceat 210 dtype "..r.dtype)
  assert(close(r.shape,{3}),"reduceat 210 shape")
  assert(close(r.strides,{8}),"reduceat 210 strides")
  assert(close(r:tolist(),{2,2,2}),"reduceat 210 values")
end
do -- reduceat 211: multiply int16 [4] axis=0 indices=[0, 0]
  local a=np.array({-1,0,1,2},np.int16)
  local r=np.multiply_reduceat(a,{1,-4},{axis=1})
  assert(r.dtype=="int64","reduceat 211 dtype "..r.dtype)
  assert(close(r.shape,{2}),"reduceat 211 shape")
  assert(close(r.strides,{8}),"reduceat 211 strides")
  assert(close(r:tolist(),{-1,0}),"reduceat 211 values")
end
do -- reduceat 212: multiply float16 [4] axis=0 indices=[2, 3, 0, 0, 3]
  local a=np.array({1.0,1.2,1.4,0.6},np.float16)
  local r=np.multiply_reduceat(a,{3,4,1,1,4},{axis=1,dtype=np.int16})
  assert(r.dtype=="int16","reduceat 212 dtype "..r.dtype)
  assert(close(r.shape,{5}),"reduceat 212 shape")
  assert(close(r.strides,{2}),"reduceat 212 strides")
  assert(close(r:tolist(),{1,0,1,1,0}),"reduceat 212 values")
end
do -- reduceat 213: multiply int16 [0] axis=0 indices=[]
  local a=np.zeros({0},np.int16)
  local r=np.multiply_reduceat(a,{},{axis=1})
  assert(r.dtype=="int64","reduceat 213 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 213 shape")
  assert(close(r.strides,{0}),"reduceat 213 strides")
  assert(close(r:tolist(),{}),"reduceat 213 values")
end
do -- reduceat 214: multiply int32 [2] axis=0 indices=[0]
  local a=np.array({2,-2},np.int32)
  local o=np.zeros({1},np.bool)
  local r=np.multiply_reduceat(a,{1},{axis=1,out=o})
  assert(r==o,"reduceat 214 out identity")
  assert(r.dtype=="bool","reduceat 214 dtype "..r.dtype)
  assert(close(r.shape,{1}),"reduceat 214 shape")
  assert(close(r.strides,{1}),"reduceat 214 strides")
  assert(close(r:tolist(),{true}),"reduceat 214 values")
end
do -- reduceat 215: multiply int16 [0] axis=0 indices=[]
  local a=np.zeros({0},np.int16)
  local r=np.multiply_reduceat(a,{},{axis=1,dtype=np.int8})
  assert(r.dtype=="int8","reduceat 215 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 215 shape")
  assert(close(r.strides,{0}),"reduceat 215 strides")
  assert(close(r:tolist(),{}),"reduceat 215 values")
end
do -- reduceat 216: add uint8 [2, 2] axis=1 indices=[0, 1, 0]
  local a=np.array({{0,3},{6,1}},np.uint8)
  local r=np.add_reduceat(a,{1,2,1},{axis=2,dtype=np.float16})
  assert(r.dtype=="float16","reduceat 216 dtype "..r.dtype)
  assert(close(r.shape,{2,3}),"reduceat 216 shape")
  assert(close(r.strides,{6,2}),"reduceat 216 strides")
  assert(close(r:tolist(),{{0.0,3.0,3.0},{6.0,1.0,7.0}}),"reduceat 216 values")
end
do -- reduceat 217: multiply uint8 [2, 0, 3, 0] axis=1 indices=[]
  local a=np.zeros({2,0,3,0},np.uint8)
  local r=np.multiply_reduceat(a,{},{axis=2})
  assert(r.dtype=="uint64","reduceat 217 dtype "..r.dtype)
  assert(close(r.shape,{2,0,3,0}),"reduceat 217 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 217 strides")
  assert(close(r:tolist(),{{},{}}),"reduceat 217 values")
end
do -- reduceat 218: multiply float16 [4, 1] axis=1 indices=[]
  local a=np.array({{1.2},{1.4},{0.6},{0.8}},np.float16)
  local r=np.multiply_reduceat(a,{},{axis=2})
  assert(r.dtype=="float16","reduceat 218 dtype "..r.dtype)
  assert(close(r.shape,{4,0}),"reduceat 218 shape")
  assert(close(r.strides,{0,0}),"reduceat 218 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"reduceat 218 values")
end
do -- reduceat 219: multiply uint8 [4, 2, 2] axis=0 indices=[2]
  local a=np.array({{{4,1},{2,3}},{{4,1},{2,3}},{{4,1},{2,3}},{{4,1},{2,3}}},np.uint8)
  local r=np.multiply_reduceat(a,{-2},{axis=1})
  assert(r.dtype=="uint64","reduceat 219 dtype "..r.dtype)
  assert(close(r.shape,{1,2,2}),"reduceat 219 shape")
  assert(close(r.strides,{32,16,8}),"reduceat 219 strides")
  assert(close(r:tolist(),{{{16,1},{4,9}}}),"reduceat 219 values")
end
do -- reduceat 220: multiply uint32 [0, 0, 0] axis=0 indices=[]
  local a=np.zeros({0,0,0},np.uint32)
  local r=np.multiply_reduceat(a,{},{axis=1})
  assert(r.dtype=="uint64","reduceat 220 dtype "..r.dtype)
  assert(close(r.shape,{0,0,0}),"reduceat 220 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 220 strides")
  assert(close(r:tolist(),{}),"reduceat 220 values")
end
do -- reduceat 221: add bool [4, 3] axis=1 indices=[]
  local a=np.array({{true,true,false},{true,true,false},{true,true,false},{true,true,false}},np.bool)
  local o=np.zeros({4,0},np.float64)
  local r=np.add_reduceat(a,{},{axis=2,dtype=np.uint16,out=o})
  assert(r==o,"reduceat 221 out identity")
  assert(r.dtype=="float64","reduceat 221 dtype "..r.dtype)
  assert(close(r.shape,{4,0}),"reduceat 221 shape")
  assert(close(r.strides,{0,0}),"reduceat 221 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"reduceat 221 values")
end
do -- reduceat 222: multiply int64 [2] axis=0 indices=[0, 1, 0, 0, 1]
  local a=np.array({0,1},np.int64)
  local r=np.multiply_reduceat(a,{1,-1,1,-2,2},{axis=1,dtype=np.uint16})
  assert(r.dtype=="uint16","reduceat 222 dtype "..r.dtype)
  assert(close(r.shape,{5}),"reduceat 222 shape")
  assert(close(r.strides,{2}),"reduceat 222 strides")
  assert(close(r:tolist(),{0,1,0,0,1}),"reduceat 222 values")
end
do -- reduceat 223: multiply int8 [0] axis=0 indices=[]
  local a=np.zeros({0},np.int8)
  local o=np.zeros({0},np.uint8)
  local r=np.multiply_reduceat(a,{},{axis=1,out=o})
  assert(r==o,"reduceat 223 out identity")
  assert(r.dtype=="uint8","reduceat 223 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 223 shape")
  assert(close(r.strides,{0}),"reduceat 223 strides")
  assert(close(r:tolist(),{}),"reduceat 223 values")
end
do -- reduceat 224: multiply uint32 [1, 4, 4] axis=1 indices=[1, 3, 0]
  local a=np.array({{{1,2,3,4},{1,2,3,4},{1,2,3,4},{1,2,3,4}}},np.uint32)
  local r=np.multiply_reduceat(a,{-3,4,1},{axis=2})
  assert(r.dtype=="uint64","reduceat 224 dtype "..r.dtype)
  assert(close(r.shape,{1,3,4}),"reduceat 224 shape")
  assert(close(r.strides,{96,32,8}),"reduceat 224 strides")
  assert(close(r:tolist(),{{{1,4,9,16},{1,2,3,4},{1,16,81,256}}}),"reduceat 224 values")
end
do -- reduceat 225: add float32 [3, 3, 2] axis=2 indices=[1, 1, 0, 1, 0]
  local a=np.array({{{-1.5,-0.375},{0.75,-1.5},{-0.375,0.75}},{{-1.5,-0.375},{0.75,-1.5},{-0.375,0.75}},{{-1.5,-0.375},{0.75,-1.5},{-0.375,0.75}}},np.float32)
  local r=np.add_reduceat(a,{2,2,1,-1,1},{axis=3})
  assert(r.dtype=="float32","reduceat 225 dtype "..r.dtype)
  assert(close(r.shape,{3,3,5}),"reduceat 225 shape")
  assert(close(r.strides,{60,20,4}),"reduceat 225 strides")
  assert(close(r:tolist(),{{{-0.375,-0.375,-1.5,-0.375,-1.875},{-1.5,-1.5,0.75,-1.5,-0.75},{0.75,0.75,-0.375,0.75,0.375}},{{-0.375,-0.375,-1.5,-0.375,-1.875},{-1.5,-1.5,0.75,-1.5,-0.75},{0.75,0.75,-0.375,0.75,0.375}},{{-0.375,-0.375,-1.5,-0.375,-1.875},{-1.5,-1.5,0.75,-1.5,-0.75},{0.75,0.75,-0.375,0.75,0.375}}}),"reduceat 225 values")
end
do -- reduceat 226: add int8 [1, 0, 0, 4] axis=1 indices=[]
  local a=np.zeros({1,0,0,4},np.int8)
  local r=np.add_reduceat(a,{},{axis=2})
  assert(r.dtype=="int64","reduceat 226 dtype "..r.dtype)
  assert(close(r.shape,{1,0,0,4}),"reduceat 226 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 226 strides")
  assert(close(r:tolist(),{{}}),"reduceat 226 values")
end
do -- reduceat 227: add float64 [0, 0, 4, 2] axis=0 indices=[]
  local a=np.zeros({0,0,4,2},np.float64)
  local r=np.add_reduceat(a,{},{axis=1})
  assert(r.dtype=="float64","reduceat 227 dtype "..r.dtype)
  assert(close(r.shape,{0,0,4,2}),"reduceat 227 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 227 strides")
  assert(close(r:tolist(),{}),"reduceat 227 values")
end
do -- reduceat 228: multiply int32 [1, 0] axis=0 indices=[0]
  local a=np.zeros({1,0},np.int32)
  local r=np.multiply_reduceat(a,{1},{axis=1,dtype=np.uint64})
  assert(r.dtype=="uint64","reduceat 228 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"reduceat 228 shape")
  assert(close(r.strides,{0,0}),"reduceat 228 strides")
  assert(close(r:tolist(),{{}}),"reduceat 228 values")
end
do -- reduceat 229: add int8 [3, 0, 0, 3] axis=2 indices=[]
  local a=np.zeros({3,0,0,3},np.int8)
  local r=np.add_reduceat(a,{},{axis=3})
  assert(r.dtype=="int64","reduceat 229 dtype "..r.dtype)
  assert(close(r.shape,{3,0,0,3}),"reduceat 229 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 229 strides")
  assert(close(r:tolist(),{{},{},{}}),"reduceat 229 values")
end
do -- reduceat 230: multiply int32 [1, 3] axis=0 indices=[0, 0]
  local a=np.array({{-2,-1,0}},np.int32)
  local r=np.multiply_reduceat(a,{-1,1},{axis=1,dtype=np.uint64})
  assert(r.dtype=="uint64","reduceat 230 dtype "..r.dtype)
  assert(close(r.shape,{2,3}),"reduceat 230 shape")
  assert(close(r.strides,{24,8}),"reduceat 230 strides")
  assert(close(r:tolist(),{{18446744073709551614,18446744073709551615,0},{18446744073709551614,18446744073709551615,0}}),"reduceat 230 values")
end
do -- reduceat 231: add int64 [1] axis=0 indices=[]
  local a=np.array({-5},np.int64)
  local r=np.add_reduceat(a,{},{axis=1,dtype=np.int16})
  assert(r.dtype=="int16","reduceat 231 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 231 shape")
  assert(close(r.strides,{0}),"reduceat 231 strides")
  assert(close(r:tolist(),{}),"reduceat 231 values")
end
do -- reduceat 232: add int32 [4, 2, 0, 2] axis=2 indices=[]
  local a=np.zeros({4,2,0,2},np.int32)
  local o=np.zeros({4,2,0,2},np.int16)
  local r=np.add_reduceat(a,{},{axis=3,dtype=np.int32,out=o})
  assert(r==o,"reduceat 232 out identity")
  assert(r.dtype=="int16","reduceat 232 dtype "..r.dtype)
  assert(close(r.shape,{4,2,0,2}),"reduceat 232 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 232 strides")
  assert(close(r:tolist(),{{{},{}},{{},{}},{{},{}},{{},{}}}),"reduceat 232 values")
end
do -- reduceat 233: multiply int16 [4, 2, 0] axis=0 indices=[]
  local a=np.zeros({4,2,0},np.int16)
  local r=np.multiply_reduceat(a,{},{axis=1})
  assert(r.dtype=="int64","reduceat 233 dtype "..r.dtype)
  assert(close(r.shape,{0,2,0}),"reduceat 233 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 233 strides")
  assert(close(r:tolist(),{}),"reduceat 233 values")
end
do -- reduceat 234: multiply int8 [3] axis=0 indices=[0, 0, 1]
  local a=np.array({2,-2,-1},np.int8)
  local o=np.zeros({3},np.bool)
  local r=np.multiply_reduceat(a,{1,1,2},{axis=1,out=o})
  assert(r==o,"reduceat 234 out identity")
  assert(r.dtype=="bool","reduceat 234 dtype "..r.dtype)
  assert(close(r.shape,{3}),"reduceat 234 shape")
  assert(close(r.strides,{1}),"reduceat 234 strides")
  assert(close(r:tolist(),{true,true,true}),"reduceat 234 values")
end
do -- reduceat 235: multiply int8 [1, 2, 2] axis=2 indices=[0, 0, 1, 1, 0]
  local a=np.array({{{-2,-1},{0,1}}},np.int8)
  local o=np.zeros({1,2,5},np.int32)
  local r=np.multiply_reduceat(a,{-2,1,2,2,1},{axis=3,dtype=np.float64,out=o})
  assert(r==o,"reduceat 235 out identity")
  assert(r.dtype=="int32","reduceat 235 dtype "..r.dtype)
  assert(close(r.shape,{1,2,5}),"reduceat 235 shape")
  assert(close(r.strides,{40,20,4}),"reduceat 235 strides")
  assert(close(r:tolist(),{{{-2,-2,-1,-1,2},{0,0,1,1,0}}}),"reduceat 235 values")
end
do -- reduceat 236: add uint64 [2, 0] axis=0 indices=[0, 1, 0, 1]
  local a=np.zeros({2,0},np.uint64)
  local r=np.add_reduceat(a,{1,2,-2,-1},{axis=1})
  assert(r.dtype=="uint64","reduceat 236 dtype "..r.dtype)
  assert(close(r.shape,{4,0}),"reduceat 236 shape")
  assert(close(r.strides,{0,0}),"reduceat 236 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"reduceat 236 values")
end
do -- reduceat 237: add int32 [1] axis=0 indices=[0, 0]
  local a=np.array({1},np.int32)
  local r=np.add_reduceat(a,{1,1},{axis=1})
  assert(r.dtype=="int64","reduceat 237 dtype "..r.dtype)
  assert(close(r.shape,{2}),"reduceat 237 shape")
  assert(close(r.strides,{8}),"reduceat 237 strides")
  assert(close(r:tolist(),{1,1}),"reduceat 237 values")
end
do -- reduceat 238: add int8 [4, 1, 0] axis=0 indices=[2]
  local a=np.zeros({4,1,0},np.int8)
  local r=np.add_reduceat(a,{3},{axis=1})
  assert(r.dtype=="int64","reduceat 238 dtype "..r.dtype)
  assert(close(r.shape,{1,1,0}),"reduceat 238 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 238 strides")
  assert(close(r:tolist(),{{{}}}),"reduceat 238 values")
end
do -- reduceat 239: multiply uint64 [3, 2, 2] axis=1 indices=[1]
  local a=np.array({{{4,1},{2,3}},{{4,1},{2,3}},{{4,1},{2,3}}},np.uint64)
  local r=np.multiply_reduceat(a,{2},{axis=2,dtype=np.uint8})
  assert(r.dtype=="uint8","reduceat 239 dtype "..r.dtype)
  assert(close(r.shape,{3,1,2}),"reduceat 239 shape")
  assert(close(r.strides,{2,2,1}),"reduceat 239 strides")
  assert(close(r:tolist(),{{{2,3}},{{2,3}},{{2,3}}}),"reduceat 239 values")
end
do -- reduceat 240: add int32 [1, 0] axis=1 indices=[]
  local a=np.zeros({1,0},np.int32)
  local r=np.add_reduceat(a,{},{axis=2,dtype=np.uint64})
  assert(r.dtype=="uint64","reduceat 240 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"reduceat 240 shape")
  assert(close(r.strides,{0,0}),"reduceat 240 strides")
  assert(close(r:tolist(),{{}}),"reduceat 240 values")
end
do -- reduceat 241: add uint8 [1, 2, 2, 2] axis=2 indices=[0, 1]
  local a=np.array({{{{1,4},{7,2}},{{5,0},{3,6}}}},np.uint8)
  local r=np.add_reduceat(a,{1,2},{axis=3})
  assert(r.dtype=="uint64","reduceat 241 dtype "..r.dtype)
  assert(close(r.shape,{1,2,2,2}),"reduceat 241 shape")
  assert(close(r.strides,{64,32,16,8}),"reduceat 241 strides")
  assert(close(r:tolist(),{{{{1,4},{7,2}},{{5,0},{3,6}}}}),"reduceat 241 values")
end
do -- reduceat 242: multiply int64 [0, 1, 2, 4] axis=1 indices=[]
  local a=np.zeros({0,1,2,4},np.int64)
  local r=np.multiply_reduceat(a,{},{axis=2})
  assert(r.dtype=="int64","reduceat 242 dtype "..r.dtype)
  assert(close(r.shape,{0,0,2,4}),"reduceat 242 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 242 strides")
  assert(close(r:tolist(),{}),"reduceat 242 values")
end
do -- reduceat 243: add uint32 [1, 4] axis=0 indices=[0, 0, 0, 0]
  local a=(np.array({{3},{6},{1},{4}},np.uint32)).T
  local o=np.zeros({4,4},np.float64)
  local r=np.add_reduceat(a,{1,1,-1,1},{axis=1,out=o})
  assert(r==o,"reduceat 243 out identity")
  assert(r.dtype=="float64","reduceat 243 dtype "..r.dtype)
  assert(close(r.shape,{4,4}),"reduceat 243 shape")
  assert(close(r.strides,{32,8}),"reduceat 243 strides")
  assert(close(r:tolist(),{{3.0,6.0,1.0,4.0},{3.0,6.0,1.0,4.0},{3.0,6.0,1.0,4.0},{3.0,6.0,1.0,4.0}}),"reduceat 243 values")
end
do -- reduceat 244: multiply float64 [4] axis=0 indices=[1, 3, 0, 2, 3]
  local a=np.array({1.4,0.6,0.8,1.0},np.float64)
  local r=np.multiply_reduceat(a,{2,4,-4,-2,-1},{axis=1,dtype=np.int64})
  assert(r.dtype=="int64","reduceat 244 dtype "..r.dtype)
  assert(close(r.shape,{5}),"reduceat 244 shape")
  assert(close(r.strides,{8}),"reduceat 244 strides")
  assert(close(r:tolist(),{0,1,0,0,1}),"reduceat 244 values")
end
do -- reduceat 245: add int32 [1, 0, 1] axis=2 indices=[0, 0]
  local a=np.zeros({1,0,1},np.int32)
  local r=np.add_reduceat(a,{1,-1},{axis=3})
  assert(r.dtype=="int64","reduceat 245 dtype "..r.dtype)
  assert(close(r.shape,{1,0,2}),"reduceat 245 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 245 strides")
  assert(close(r:tolist(),{{}}),"reduceat 245 values")
end
do -- reduceat 246: multiply uint32 [4, 0, 3, 4] axis=2 indices=[2, 2, 1]
  local a=np.zeros({4,0,3,4},np.uint32)
  local r=np.multiply_reduceat(a,{3,-1,2},{axis=3,dtype=np.uint32})
  assert(r.dtype=="uint32","reduceat 246 dtype "..r.dtype)
  assert(close(r.shape,{4,0,3,4}),"reduceat 246 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 246 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"reduceat 246 values")
end
do -- reduceat 247: multiply uint8 [0] axis=0 indices=[]
  local a=np.zeros({0},np.uint8)
  local r=np.multiply_reduceat(a,{},{axis=1})
  assert(r.dtype=="uint64","reduceat 247 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 247 shape")
  assert(close(r.strides,{0}),"reduceat 247 strides")
  assert(close(r:tolist(),{}),"reduceat 247 values")
end
do -- reduceat 248: add uint16 [3, 3] axis=0 indices=[2, 0]
  local a=np.array({{0,3,6},{1,4,7},{2,5,0}},np.uint16)
  local o=np.zeros({2,3},np.uint32)
  local r=np.add_reduceat(a,{-1,-3},{axis=1,out=o})
  assert(r==o,"reduceat 248 out identity")
  assert(r.dtype=="uint32","reduceat 248 dtype "..r.dtype)
  assert(close(r.shape,{2,3}),"reduceat 248 shape")
  assert(close(r.strides,{12,4}),"reduceat 248 strides")
  assert(close(r:tolist(),{{2,5,0},{3,12,13}}),"reduceat 248 values")
end
do -- reduceat 249: add uint16 [3, 2] axis=0 indices=[2, 2, 1, 2, 2]
  local a=np.array({{1,4},{7,2},{5,0}},np.uint16)
  local o=np.zeros({5,2},np.float16)
  local r=np.add_reduceat(a,{3,3,-2,-1,3},{axis=1,out=o})
  assert(r==o,"reduceat 249 out identity")
  assert(r.dtype=="float16","reduceat 249 dtype "..r.dtype)
  assert(close(r.shape,{5,2}),"reduceat 249 shape")
  assert(close(r.strides,{4,2}),"reduceat 249 strides")
  assert(close(r:tolist(),{{5.0,0.0},{5.0,0.0},{7.0,2.0},{5.0,0.0},{5.0,0.0}}),"reduceat 249 values")
end
do -- reduceat 250: multiply int8 [4, 3, 2] axis=2 indices=[]
  local a=np.array({{{-2,-1},{0,1},{2,-2}},{{-1,0},{1,2},{-2,-1}},{{0,1},{2,-2},{-1,0}},{{1,2},{-2,-1},{0,1}}},np.int8)
  local o=np.zeros({4,3,0},np.float16)
  local r=np.multiply_reduceat(a,{},{axis=3,out=o})
  assert(r==o,"reduceat 250 out identity")
  assert(r.dtype=="float16","reduceat 250 dtype "..r.dtype)
  assert(close(r.shape,{4,3,0}),"reduceat 250 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 250 strides")
  assert(close(r:tolist(),{{{},{},{}},{{},{},{}},{{},{},{}},{{},{},{}}}),"reduceat 250 values")
end
do -- reduceat 251: add bool [0] axis=0 indices=[]
  local a=np.zeros({0},np.bool)
  local r=np.add_reduceat(a,{},{axis=1})
  assert(r.dtype=="int64","reduceat 251 dtype "..r.dtype)
  assert(close(r.shape,{0}),"reduceat 251 shape")
  assert(close(r.strides,{0}),"reduceat 251 strides")
  assert(close(r:tolist(),{}),"reduceat 251 values")
end
do -- reduceat 252: add float16 [2, 1, 1] axis=1 indices=[0, 0, 0, 0]
  local a=np.array({{{-1.5}},{{-0.375}}},np.float16)
  local r=np.add_reduceat(a,{1,1,1,1},{axis=2,dtype=np.uint16})
  assert(r.dtype=="uint16","reduceat 252 dtype "..r.dtype)
  assert(close(r.shape,{2,4,1}),"reduceat 252 shape")
  assert(close(r.strides,{8,2,2}),"reduceat 252 strides")
  assert(close(r:tolist(),{{{65535},{65535},{65535},{65535}},{{0},{0},{0},{0}}}),"reduceat 252 values")
end
do -- reduceat 253: multiply uint32 [4, 0] axis=0 indices=[0, 2, 2]
  local a=np.zeros({4,0},np.uint32)
  local r=np.multiply_reduceat(a,{1,3,3},{axis=1})
  assert(r.dtype=="uint64","reduceat 253 dtype "..r.dtype)
  assert(close(r.shape,{3,0}),"reduceat 253 shape")
  assert(close(r.strides,{0,0}),"reduceat 253 strides")
  assert(close(r:tolist(),{{},{},{}}),"reduceat 253 values")
end
do -- reduceat 254: multiply int8 [2, 0, 3] axis=2 indices=[0, 0, 1]
  local a=np.zeros({2,0,3},np.int8)
  local r=np.multiply_reduceat(a,{1,1,2},{axis=3,dtype=np.int64})
  assert(r.dtype=="int64","reduceat 254 dtype "..r.dtype)
  assert(close(r.shape,{2,0,3}),"reduceat 254 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 254 strides")
  assert(close(r:tolist(),{{},{}}),"reduceat 254 values")
end
do -- reduceat 255: multiply uint16 [2, 0, 0, 3] axis=1 indices=[]
  local a=np.zeros({2,0,0,3},np.uint16)
  local r=np.multiply_reduceat(a,{},{axis=2})
  assert(r.dtype=="uint64","reduceat 255 dtype "..r.dtype)
  assert(close(r.shape,{2,0,0,3}),"reduceat 255 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 255 strides")
  assert(close(r:tolist(),{{},{}}),"reduceat 255 values")
end
do -- reduceat 256: multiply int32 [0, 0, 4] axis=1 indices=[]
  local a=np.zeros({0,0,4},np.int32)
  local o=np.zeros({0,0,4},np.bool)
  local r=np.multiply_reduceat(a,{},{axis=2,out=o})
  assert(r==o,"reduceat 256 out identity")
  assert(r.dtype=="bool","reduceat 256 dtype "..r.dtype)
  assert(close(r.shape,{0,0,4}),"reduceat 256 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 256 strides")
  assert(close(r:tolist(),{}),"reduceat 256 values")
end
do -- reduceat 257: add int64 [3, 0] axis=0 indices=[]
  local a=np.zeros({3,0},np.int64)
  local r=np.add_reduceat(a,{},{axis=1})
  assert(r.dtype=="int64","reduceat 257 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"reduceat 257 shape")
  assert(close(r.strides,{0,0}),"reduceat 257 strides")
  assert(close(r:tolist(),{}),"reduceat 257 values")
end
do -- reduceat 258: multiply float64 [3, 3, 4] axis=1 indices=[0, 2, 1, 2]
  local a=np.array({{{1.2,1.4,0.6,0.8},{1.0,1.2,1.4,0.6},{0.8,1.0,1.2,1.4}},{{0.6,0.8,1.0,1.2},{1.4,0.6,0.8,1.0},{1.2,1.4,0.6,0.8}},{{1.0,1.2,1.4,0.6},{0.8,1.0,1.2,1.4},{0.6,0.8,1.0,1.2}}},np.float64)
  local o=np.zeros({3,4,4},np.uint32)
  local r=np.multiply_reduceat(a,{1,-1,-2,-1},{axis=2,out=o})
  assert(r==o,"reduceat 258 out identity")
  assert(r.dtype=="uint32","reduceat 258 dtype "..r.dtype)
  assert(close(r.shape,{3,4,4}),"reduceat 258 shape")
  assert(close(r.strides,{64,16,4}),"reduceat 258 strides")
  assert(close(r:tolist(),{{{1,1,0,0},{0,1,1,1},{1,1,1,0},{0,1,1,1}},{{0,0,0,1},{1,1,0,0},{1,0,0,1},{1,1,0,0}},{{0,1,1,0},{0,0,1,1},{0,1,1,1},{0,0,1,1}}}),"reduceat 258 values")
end
do -- reduceat 259: multiply float64 [3, 4, 0] axis=2 indices=[]
  local a=np.zeros({3,4,0},np.float64)
  local r=np.multiply_reduceat(a,{},{axis=3,dtype=np.int32})
  assert(r.dtype=="int32","reduceat 259 dtype "..r.dtype)
  assert(close(r.shape,{3,4,0}),"reduceat 259 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 259 strides")
  assert(close(r:tolist(),{{{},{},{},{}},{{},{},{},{}},{{},{},{},{}}}),"reduceat 259 values")
end
do -- reduceat 260: add float64 [2, 3] axis=1 indices=[1]
  local a=np.array({{1.5,-0.75,0.375},{1.5,-0.75,0.375}},np.float64)
  local r=np.add_reduceat(a,{2},{axis=2})
  assert(r.dtype=="float64","reduceat 260 dtype "..r.dtype)
  assert(close(r.shape,{2,1}),"reduceat 260 shape")
  assert(close(r.strides,{8,8}),"reduceat 260 strides")
  assert(close(r:tolist(),{{-0.375},{-0.375}}),"reduceat 260 values")
end
do -- reduceat 261: add int16 [1, 1, 1, 4] axis=0 indices=[0, 0, 0, 0]
  local a=np.array({{{{3,-5,-2,1}}}},np.int16)
  local r=np.add_reduceat(a,{1,-1,1,1},{axis=1})
  assert(r.dtype=="int64","reduceat 261 dtype "..r.dtype)
  assert(close(r.shape,{4,1,1,4}),"reduceat 261 shape")
  assert(close(r.strides,{32,32,32,8}),"reduceat 261 strides")
  assert(close(r:tolist(),{{{{3,-5,-2,1}}},{{{3,-5,-2,1}}},{{{3,-5,-2,1}}},{{{3,-5,-2,1}}}}),"reduceat 261 values")
end
do -- reduceat 262: multiply uint16 [3, 0] axis=0 indices=[2, 2, 2, 2]
  local a=np.zeros({3,0},np.uint16)
  local o=np.zeros({4,0},np.bool)
  local r=np.multiply_reduceat(a,{3,3,3,3},{axis=1,out=o})
  assert(r==o,"reduceat 262 out identity")
  assert(r.dtype=="bool","reduceat 262 dtype "..r.dtype)
  assert(close(r.shape,{4,0}),"reduceat 262 shape")
  assert(close(r.strides,{0,0}),"reduceat 262 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"reduceat 262 values")
end
do -- reduceat 263: add int8 [2, 3, 1] axis=2 indices=[0]
  local a=np.array({{{5},{-3},{0}},{{3},{-5},{-2}}},np.int8)
  local r=np.add_reduceat(a,{1},{axis=3})
  assert(r.dtype=="int64","reduceat 263 dtype "..r.dtype)
  assert(close(r.shape,{2,3,1}),"reduceat 263 shape")
  assert(close(r.strides,{24,8,8}),"reduceat 263 strides")
  assert(close(r:tolist(),{{{5},{-3},{0}},{{3},{-5},{-2}}}),"reduceat 263 values")
end
do -- reduceat 264: add float16 [3, 4, 3] axis=1 indices=[0, 2]
  local a=np.array({{{-0.375,0.75,-1.5},{-0.375,0.75,-1.5},{-0.375,0.75,-1.5},{-0.375,0.75,-1.5}},{{-0.375,0.75,-1.5},{-0.375,0.75,-1.5},{-0.375,0.75,-1.5},{-0.375,0.75,-1.5}},{{-0.375,0.75,-1.5},{-0.375,0.75,-1.5},{-0.375,0.75,-1.5},{-0.375,0.75,-1.5}}},np.float16)
  local o=np.zeros({3,2,3},np.bool)
  local r=np.add_reduceat(a,{1,3},{axis=2,out=o})
  assert(r==o,"reduceat 264 out identity")
  assert(r.dtype=="bool","reduceat 264 dtype "..r.dtype)
  assert(close(r.shape,{3,2,3}),"reduceat 264 shape")
  assert(close(r.strides,{6,3,1}),"reduceat 264 strides")
  assert(close(r:tolist(),{{{true,true,true},{true,true,true}},{{true,true,true},{true,true,true}},{{true,true,true},{true,true,true}}}),"reduceat 264 values")
end
do -- reduceat 265: multiply int64 [2] axis=0 indices=[0, 0, 1]
  local a=np.array({-2,-1},np.int64)
  local r=np.multiply_reduceat(a,{1,-2,-1},{axis=1})
  assert(r.dtype=="int64","reduceat 265 dtype "..r.dtype)
  assert(close(r.shape,{3}),"reduceat 265 shape")
  assert(close(r.strides,{8}),"reduceat 265 strides")
  assert(close(r:tolist(),{-2,-2,-1}),"reduceat 265 values")
end
do -- reduceat 266: multiply int8 [0, 2, 4, 1] axis=3 indices=[0, 0]
  local a=np.zeros({0,2,4,1},np.int8)
  local r=np.multiply_reduceat(a,{1,1},{axis=4})
  assert(r.dtype=="int64","reduceat 266 dtype "..r.dtype)
  assert(close(r.shape,{0,2,4,2}),"reduceat 266 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 266 strides")
  assert(close(r:tolist(),{}),"reduceat 266 values")
end
do -- reduceat 267: add int16 [0, 2] axis=0 indices=[]
  local a=np.zeros({0,2},np.int16)
  local r=np.add_reduceat(a,{},{axis=1})
  assert(r.dtype=="int64","reduceat 267 dtype "..r.dtype)
  assert(close(r.shape,{0,2}),"reduceat 267 shape")
  assert(close(r.strides,{0,0}),"reduceat 267 strides")
  assert(close(r:tolist(),{}),"reduceat 267 values")
end
do -- reduceat 268: multiply int8 [4, 3] axis=0 indices=[3, 3, 0, 2, 1, 2]
  local a=np.array({{1,2,-2},{-1,0,1},{2,-2,-1},{0,1,2}},np.int8)
  local o=np.zeros({6,3},np.float16)
  local r=np.multiply_reduceat(a,{4,4,-4,3,-3,3},{axis=1,out=o})
  assert(r==o,"reduceat 268 out identity")
  assert(r.dtype=="float16","reduceat 268 dtype "..r.dtype)
  assert(close(r.shape,{6,3}),"reduceat 268 shape")
  assert(close(r.strides,{6,2}),"reduceat 268 strides")
  assert(close(r:tolist(),{{0.0,1.0,2.0},{0.0,1.0,2.0},{-1.0,0.0,-2.0},{2.0,-2.0,-1.0},{-1.0,0.0,1.0},{0.0,-2.0,-2.0}}),"reduceat 268 values")
end
do -- reduceat 269: multiply uint32 [4, 2, 4, 3] axis=1 indices=[1]
  local a=np.array({{{{2,3,4},{1,2,3},{4,1,2},{3,4,1}},{{2,3,4},{1,2,3},{4,1,2},{3,4,1}}},{{{2,3,4},{1,2,3},{4,1,2},{3,4,1}},{{2,3,4},{1,2,3},{4,1,2},{3,4,1}}},{{{2,3,4},{1,2,3},{4,1,2},{3,4,1}},{{2,3,4},{1,2,3},{4,1,2},{3,4,1}}},{{{2,3,4},{1,2,3},{4,1,2},{3,4,1}},{{2,3,4},{1,2,3},{4,1,2},{3,4,1}}}},np.uint32)
  local r=np.multiply_reduceat(a,{2},{axis=2,dtype=np.float16})
  assert(r.dtype=="float16","reduceat 269 dtype "..r.dtype)
  assert(close(r.shape,{4,1,4,3}),"reduceat 269 shape")
  assert(close(r.strides,{24,24,6,2}),"reduceat 269 strides")
  assert(close(r:tolist(),{{{{2.0,3.0,4.0},{1.0,2.0,3.0},{4.0,1.0,2.0},{3.0,4.0,1.0}}},{{{2.0,3.0,4.0},{1.0,2.0,3.0},{4.0,1.0,2.0},{3.0,4.0,1.0}}},{{{2.0,3.0,4.0},{1.0,2.0,3.0},{4.0,1.0,2.0},{3.0,4.0,1.0}}},{{{2.0,3.0,4.0},{1.0,2.0,3.0},{4.0,1.0,2.0},{3.0,4.0,1.0}}}}),"reduceat 269 values")
end
do -- reduceat 270: add int16 [1, 3, 0] axis=1 indices=[0]
  local a=np.zeros({1,3,0},np.int16)
  local r=np.add_reduceat(a,{1},{axis=2})
  assert(r.dtype=="int64","reduceat 270 dtype "..r.dtype)
  assert(close(r.shape,{1,1,0}),"reduceat 270 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 270 strides")
  assert(close(r:tolist(),{{{}}}),"reduceat 270 values")
end
do -- reduceat 271: add uint16 [2, 1] axis=1 indices=[]
  local a=np.array({{7},{2}},np.uint16)
  local r=np.add_reduceat(a,{},{axis=2})
  assert(r.dtype=="uint64","reduceat 271 dtype "..r.dtype)
  assert(close(r.shape,{2,0}),"reduceat 271 shape")
  assert(close(r.strides,{0,0}),"reduceat 271 strides")
  assert(close(r:tolist(),{{},{}}),"reduceat 271 values")
end
do -- reduceat 272: multiply bool [0, 3, 0, 4] axis=2 indices=[]
  local a=np.zeros({0,3,0,4},np.bool)
  local r=np.multiply_reduceat(a,{},{axis=3})
  assert(r.dtype=="int64","reduceat 272 dtype "..r.dtype)
  assert(close(r.shape,{0,3,0,4}),"reduceat 272 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 272 strides")
  assert(close(r:tolist(),{}),"reduceat 272 values")
end
do -- reduceat 273: multiply int8 [3, 0, 3] axis=1 indices=[]
  local a=np.zeros({3,0,3},np.int8)
  local r=np.multiply_reduceat(a,{},{axis=2})
  assert(r.dtype=="int64","reduceat 273 dtype "..r.dtype)
  assert(close(r.shape,{3,0,3}),"reduceat 273 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 273 strides")
  assert(close(r:tolist(),{{},{},{}}),"reduceat 273 values")
end
do -- reduceat 274: multiply int8 [0, 1, 4, 1] axis=0 indices=[]
  local a=np.zeros({0,1,4,1},np.int8)
  local r=np.multiply_reduceat(a,{},{axis=1})
  assert(r.dtype=="int64","reduceat 274 dtype "..r.dtype)
  assert(close(r.shape,{0,1,4,1}),"reduceat 274 shape")
  assert(close(r.strides,{0,0,0,0}),"reduceat 274 strides")
  assert(close(r:tolist(),{}),"reduceat 274 values")
end
do -- reduceat 275: multiply uint8 [4, 4] axis=1 indices=[]
  local a=np.array({{4,1,2,3},{4,1,2,3},{4,1,2,3},{4,1,2,3}},np.uint8)
  local r=np.multiply_reduceat(a,{},{axis=2})
  assert(r.dtype=="uint64","reduceat 275 dtype "..r.dtype)
  assert(close(r.shape,{4,0}),"reduceat 275 shape")
  assert(close(r.strides,{0,0}),"reduceat 275 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"reduceat 275 values")
end
do -- reduceat 276: add uint8 [4] axis=0 indices=[1]
  local a=np.array({4,7,2,5},np.uint8)
  local r=np.add_reduceat(a,{2},{axis=1,dtype=np.uint16})
  assert(r.dtype=="uint16","reduceat 276 dtype "..r.dtype)
  assert(close(r.shape,{1}),"reduceat 276 shape")
  assert(close(r.strides,{2}),"reduceat 276 strides")
  assert(close(r:tolist(),{14}),"reduceat 276 values")
end
do -- reduceat 277: multiply uint32 [0, 0, 1] axis=1 indices=[]
  local a=np.zeros({0,0,1},np.uint32)
  local r=np.multiply_reduceat(a,{},{axis=2})
  assert(r.dtype=="uint64","reduceat 277 dtype "..r.dtype)
  assert(close(r.shape,{0,0,1}),"reduceat 277 shape")
  assert(close(r.strides,{0,0,0}),"reduceat 277 strides")
  assert(close(r:tolist(),{}),"reduceat 277 values")
end
do -- reduceat 278: multiply int32 [4, 3, 4] axis=1 indices=[0, 0, 0, 2, 1]
  local a=np.array({{{1,2,-2,-1},{0,1,2,-2},{-1,0,1,2}},{{-2,-1,0,1},{2,-2,-1,0},{1,2,-2,-1}},{{0,1,2,-2},{-1,0,1,2},{-2,-1,0,1}},{{2,-2,-1,0},{1,2,-2,-1},{0,1,2,-2}}},np.int32)
  local r=np.multiply_reduceat(a,{1,1,-3,3,2},{axis=2,dtype=np.uint16})
  assert(r.dtype=="uint16","reduceat 278 dtype "..r.dtype)
  assert(close(r.shape,{4,5,4}),"reduceat 278 shape")
  assert(close(r.strides,{40,8,2}),"reduceat 278 strides")
  assert(close(r:tolist(),{{{1,2,65534,65535},{1,2,65534,65535},{0,2,65532,2},{65535,0,1,2},{0,0,2,65532}},{{65534,65535,0,1},{65534,65535,0,1},{65532,2,0,0},{1,2,65534,65535},{2,65532,2,0}},{{0,1,2,65534},{0,1,2,65534},{0,0,2,65532},{65534,65535,0,1},{2,0,0,2}},{{2,65534,65535,0},{2,65534,65535,0},{2,65532,2,0},{0,1,2,65534},{0,2,65532,2}}}),"reduceat 278 values")
end
do -- reduceat 279: add uint32 [3] axis=0 indices=[2, 1, 0, 2]
  local a=np.array({7,2,5},np.uint32)
  local r=np.add_reduceat(a,{-1,2,1,3},{axis=1})
  assert(r.dtype=="uint64","reduceat 279 dtype "..r.dtype)
  assert(close(r.shape,{4}),"reduceat 279 shape")
  assert(close(r.strides,{8}),"reduceat 279 strides")
  assert(close(r:tolist(),{5,2,9,5}),"reduceat 279 values")
end
do local a=np.arange(5); local r=np.add_reduceat(a,{1,4,2}); assert(close(r:tolist(),{3,3,10}),"reduceat descending first-element rule") end
do local a=np.array({100,100,100},np.int8); local r=np.add_reduceat(a,{1}); assert(r.dtype=="int64" and close(r:tolist(),{300}),"reduceat small-int widening") end
do local a=np.array({1.6,1.6,1.6},np.float32); local o=np.zeros({1},np.int8); np.add_reduceat(a,{1},{out=o}); assert(close(o:tolist(),{4}),"reduceat output cast after full accumulator") end
do local a=np.arange(5); local r=np.add_reduceat(a,{-5,-2,-4}); assert(close(r:tolist(),{3,3,10}),"reduceat Lua negative indices") end
do local a=np.arange(5); local idx=np.array({1,4,2},np.int16); local r=np.add_reduceat(a,idx); assert(close(r:tolist(),{3,3,10}),"reduceat ndarray indices") end
do local a=np.reshape(np.arange(6),{2,3}); local r=np.add_reduceat(a,{},2); assert(close(r.shape,{2,0}),"reduceat empty indices") end
print('reduceat differential: 286 cases ok')
