local np=require("luaray_core")
local function close(a,b)
  if type(a)~=type(b) then return false end
  if type(a)~="table" then
    if type(a)=="number" then
      if a~=a and b~=b then return true end
      if a==b then return true end
      return math.abs(a-b)<=math.max(2e-5,math.abs(b)*8e-6)
    end
    return a==b
  end
  if #a~=#b then return false end
  for i=1,#a do if not close(a[i],b[i]) then return false end end
  return true
end
-- Generated against development NumPy 2.3.5.
do -- accumulate 0: multiply int64 [1, 4] axis=1
  local a=np.array({{-2,-1,0,1}},np.int64)
  local r=np.multiply_accumulate(a,{axis=2,dtype=np.uint8})
  assert(r.dtype=="uint8","acc 0 dtype "..r.dtype)
  assert(close(r.shape,{1,4}),"acc 0 shape")
  assert(close(r.strides,{4,1}),"acc 0 strides")
  assert(close(r:tolist(),{{254,2,0,0}}),"acc 0 values")
end
do -- accumulate 1: multiply float16 [2] axis=0
  local a=np.array({0.75,1.0},np.float16)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="float16","acc 1 dtype "..r.dtype)
  assert(close(r.shape,{2}),"acc 1 shape")
  assert(close(r.strides,{2}),"acc 1 strides")
  assert(close(r:tolist(),{0.75,0.75}),"acc 1 values")
end
do -- accumulate 2: multiply float64 [4, 1, 1] axis=0
  local a=(np.array({{{1.0,1.25,1.5,0.5}}},np.float64)).T
  local o=np.zeros({4,1,1},np.float64)
  local r=np.multiply_accumulate(a,{axis=1,dtype=np.uint64,out=o})
  assert(r==o,"acc 2 out identity")
  assert(r.dtype=="float64","acc 2 dtype "..r.dtype)
  assert(close(r.shape,{4,1,1}),"acc 2 shape")
  assert(close(r.strides,{8,8,8}),"acc 2 strides")
  assert(close(r:tolist(),{{{1.0}},{{1.0}},{{1.0}},{{0.0}}}),"acc 2 values")
end
do -- accumulate 3: multiply float64 [2, 0, 1, 2] axis=3
  local a=np.zeros({2,0,1,2},np.float64)
  local r=np.multiply_accumulate(a,{axis=4})
  assert(r.dtype=="float64","acc 3 dtype "..r.dtype)
  assert(close(r.shape,{2,0,1,2}),"acc 3 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 3 strides")
  assert(close(r:tolist(),{{},{}}),"acc 3 values")
end
do -- accumulate 4: add uint32 [0, 1, 2, 0] axis=3
  local a=np.zeros({0,1,2,0},np.uint32)
  local r=np.add_accumulate(a,{axis=4,dtype=np.uint32})
  assert(r.dtype=="uint32","acc 4 dtype "..r.dtype)
  assert(close(r.shape,{0,1,2,0}),"acc 4 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 4 strides")
  assert(close(r:tolist(),{}),"acc 4 values")
end
do -- accumulate 5: add int64 [4, 3, 0] axis=1
  local a=np.zeros({4,3,0},np.int64)
  local o=np.zeros({4,3,0},np.float32)
  local r=np.add_accumulate(a,{axis=2,dtype=np.int64,out=o})
  assert(r==o,"acc 5 out identity")
  assert(r.dtype=="float32","acc 5 dtype "..r.dtype)
  assert(close(r.shape,{4,3,0}),"acc 5 shape")
  assert(close(r.strides,{0,0,0}),"acc 5 strides")
  assert(close(r:tolist(),{{{},{},{}},{{},{},{}},{{},{},{}},{{},{},{}}}),"acc 5 values")
end
do -- accumulate 6: multiply float64 [1, 3] axis=1
  local a=np.array({{0.75,1.0,1.25}},np.float64)
  local r=np.multiply_accumulate(a,{axis=2})
  assert(r.dtype=="float64","acc 6 dtype "..r.dtype)
  assert(close(r.shape,{1,3}),"acc 6 shape")
  assert(close(r.strides,{24,8}),"acc 6 strides")
  assert(close(r:tolist(),{{0.75,0.75,0.9375}}),"acc 6 values")
end
do -- accumulate 7: multiply bool [2, 1, 1, 2] axis=2
  local a=np.array({{{{true,true}}},{{{false,true}}}},np.bool)
  local o=np.zeros({2,1,1,2},np.int32)
  local r=np.multiply_accumulate(a,{axis=3,out=o})
  assert(r==o,"acc 7 out identity")
  assert(r.dtype=="int32","acc 7 dtype "..r.dtype)
  assert(close(r.shape,{2,1,1,2}),"acc 7 shape")
  assert(close(r.strides,{8,8,8,4}),"acc 7 strides")
  assert(close(r:tolist(),{{{{1,1}}},{{{0,1}}}}),"acc 7 values")
end
do -- accumulate 8: multiply uint16 [1, 0, 4, 0] axis=1
  local a=np.zeros({1,0,4,0},np.uint16)
  local r=np.multiply_accumulate(a,{axis=2})
  assert(r.dtype=="uint64","acc 8 dtype "..r.dtype)
  assert(close(r.shape,{1,0,4,0}),"acc 8 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 8 strides")
  assert(close(r:tolist(),{{}}),"acc 8 values")
end
do -- accumulate 9: multiply int16 [3, 4, 0, 2] axis=3
  local a=np.zeros({3,4,0,2},np.int16)
  local r=np.multiply_accumulate(a,{axis=4,dtype=np.uint32})
  assert(r.dtype=="uint32","acc 9 dtype "..r.dtype)
  assert(close(r.shape,{3,4,0,2}),"acc 9 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 9 strides")
  assert(close(r:tolist(),{{{},{},{},{}},{{},{},{},{}},{{},{},{},{}}}),"acc 9 values")
end
do -- accumulate 10: multiply int16 [2, 3, 1] axis=2
  local a=np.array({{{-2},{-1},{0}},{{1},{2},{-2}}},np.int16)
  local r=np.multiply_accumulate(a,{axis=3})
  assert(r.dtype=="int64","acc 10 dtype "..r.dtype)
  assert(close(r.shape,{2,3,1}),"acc 10 shape")
  assert(close(r.strides,{24,8,8}),"acc 10 strides")
  assert(close(r:tolist(),{{{-2},{-1},{0}},{{1},{2},{-2}}}),"acc 10 values")
end
do -- accumulate 11: add float64 [1, 3] axis=0
  local a=np.array({{0.4,0.8,1.2000000000000002}},np.float64)
  local r=np.add_accumulate(a,{axis=1,dtype=np.float64})
  assert(r.dtype=="float64","acc 11 dtype "..r.dtype)
  assert(close(r.shape,{1,3}),"acc 11 shape")
  assert(close(r.strides,{24,8}),"acc 11 strides")
  assert(close(r:tolist(),{{0.4,0.8,1.2000000000000002}}),"acc 11 values")
end
do -- accumulate 12: add int8 [3, 4, 4] axis=2
  local a=np.array({{{-4,-1,2,5},{-3,0,3,-5},{-2,1,4,-4},{-1,2,5,-3}},{{0,3,-5,-2},{1,4,-4,-1},{2,5,-3,0},{3,-5,-2,1}},{{4,-4,-1,2},{5,-3,0,3},{-5,-2,1,4},{-4,-1,2,5}}},np.int8)
  local o=np.zeros({3,4,4},np.int32)
  local r=np.add_accumulate(a,{axis=3,out=o})
  assert(r==o,"acc 12 out identity")
  assert(r.dtype=="int32","acc 12 dtype "..r.dtype)
  assert(close(r.shape,{3,4,4}),"acc 12 shape")
  assert(close(r.strides,{64,16,4}),"acc 12 strides")
  assert(close(r:tolist(),{{{-4,-5,-3,2},{-3,-3,0,-5},{-2,-1,3,-1},{-1,1,6,3}},{{0,3,-2,-4},{1,5,1,0},{2,7,4,4},{3,-2,-4,-3}},{{4,0,-1,1},{5,2,2,5},{-5,-7,-6,-2},{-4,-5,-3,2}}}),"acc 12 values")
end
do -- accumulate 13: multiply float16 [4] axis=0
  local a=np.array({1.25,1.5,0.5,0.75},np.float16)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="float16","acc 13 dtype "..r.dtype)
  assert(close(r.shape,{4}),"acc 13 shape")
  assert(close(r.strides,{2}),"acc 13 strides")
  assert(close(r:tolist(),{1.25,1.875,0.9375,0.703125}),"acc 13 values")
end
do -- accumulate 14: multiply int32 [1] axis=0
  local a=np.array({2},np.int32)
  local o=np.zeros({1},np.bool)
  local r=np.multiply_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 14 out identity")
  assert(r.dtype=="bool","acc 14 dtype "..r.dtype)
  assert(close(r.shape,{1}),"acc 14 shape")
  assert(close(r.strides,{1}),"acc 14 strides")
  assert(close(r:tolist(),{true}),"acc 14 values")
end
do -- accumulate 15: add uint32 [0, 1, 2, 3] axis=2
  local a=np.zeros({0,1,2,3},np.uint32)
  local r=np.add_accumulate(a,{axis=3})
  assert(r.dtype=="uint64","acc 15 dtype "..r.dtype)
  assert(close(r.shape,{0,1,2,3}),"acc 15 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 15 strides")
  assert(close(r:tolist(),{}),"acc 15 values")
end
do -- accumulate 16: multiply bool [0] axis=0
  local a=np.zeros({0},np.bool)
  local r=np.multiply_accumulate(a,{axis=1,dtype=np.float64})
  assert(r.dtype=="float64","acc 16 dtype "..r.dtype)
  assert(close(r.shape,{0}),"acc 16 shape")
  assert(close(r.strides,{0}),"acc 16 strides")
  assert(close(r:tolist(),{}),"acc 16 values")
end
do -- accumulate 17: multiply bool [3, 0, 0] axis=2
  local a=np.zeros({3,0,0},np.bool)
  local r=np.multiply_accumulate(a,{axis=3})
  assert(r.dtype=="int64","acc 17 dtype "..r.dtype)
  assert(close(r.shape,{3,0,0}),"acc 17 shape")
  assert(close(r.strides,{0,0,0}),"acc 17 strides")
  assert(close(r:tolist(),{{},{},{}}),"acc 17 values")
end
do -- accumulate 18: multiply bool [0, 0, 3, 1] axis=0
  local a=np.zeros({0,0,3,1},np.bool)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="int64","acc 18 dtype "..r.dtype)
  assert(close(r.shape,{0,0,3,1}),"acc 18 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 18 strides")
  assert(close(r:tolist(),{}),"acc 18 values")
end
do -- accumulate 19: add float16 [3, 0] axis=0
  local a=np.zeros({3,0},np.float16)
  local o=np.zeros({3,0},np.uint16)
  local r=np.add_accumulate(a,{axis=1,dtype=np.int16,out=o})
  assert(r==o,"acc 19 out identity")
  assert(r.dtype=="uint16","acc 19 dtype "..r.dtype)
  assert(close(r.shape,{3,0}),"acc 19 shape")
  assert(close(r.strides,{0,0}),"acc 19 strides")
  assert(close(r:tolist(),{{},{},{}}),"acc 19 values")
end
do -- accumulate 20: add int32 [2, 0, 4] axis=2
  local a=np.zeros({2,0,4},np.int32)
  local r=np.add_accumulate(a,{axis=3,dtype=np.int64})
  assert(r.dtype=="int64","acc 20 dtype "..r.dtype)
  assert(close(r.shape,{2,0,4}),"acc 20 shape")
  assert(close(r.strides,{0,0,0}),"acc 20 strides")
  assert(close(r:tolist(),{{},{}}),"acc 20 values")
end
do -- accumulate 21: add uint8 [0, 0] axis=1
  local a=np.zeros({0,0},np.uint8)
  local r=np.add_accumulate(a,{axis=2,dtype=np.int16})
  assert(r.dtype=="int16","acc 21 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"acc 21 shape")
  assert(close(r.strides,{0,0}),"acc 21 strides")
  assert(close(r:tolist(),{}),"acc 21 values")
end
do -- accumulate 22: multiply float16 [0, 3] axis=1
  local a=np.zeros({0,3},np.float16)
  local r=np.multiply_accumulate(a,{axis=2})
  assert(r.dtype=="float16","acc 22 dtype "..r.dtype)
  assert(close(r.shape,{0,3}),"acc 22 shape")
  assert(close(r.strides,{0,0}),"acc 22 strides")
  assert(close(r:tolist(),{}),"acc 22 values")
end
do -- accumulate 23: multiply int32 [3, 3] axis=1
  local a=np.array({{1,2,-2},{-1,0,1},{2,-2,-1}},np.int32)
  local r=np.multiply_accumulate(a,{axis=2})
  assert(r.dtype=="int64","acc 23 dtype "..r.dtype)
  assert(close(r.shape,{3,3}),"acc 23 shape")
  assert(close(r.strides,{24,8}),"acc 23 strides")
  assert(close(r:tolist(),{{1,2,-4},{-1,0,0},{2,-4,4}}),"acc 23 values")
end
do -- accumulate 24: add uint32 [4, 4, 0] axis=2
  local a=np.zeros({4,4,0},np.uint32)
  local r=np.add_accumulate(a,{axis=3,dtype=np.uint32})
  assert(r.dtype=="uint32","acc 24 dtype "..r.dtype)
  assert(close(r.shape,{4,4,0}),"acc 24 shape")
  assert(close(r.strides,{0,0,0}),"acc 24 strides")
  assert(close(r:tolist(),{{{},{},{},{}},{{},{},{},{}},{{},{},{},{}},{{},{},{},{}}}),"acc 24 values")
end
do -- accumulate 25: multiply uint8 [4] axis=0
  local a=np.array({2,3,4,1},np.uint8)
  local o=np.zeros({4},np.int64)
  local r=np.multiply_accumulate(a,{axis=1,dtype=np.float64,out=o})
  assert(r==o,"acc 25 out identity")
  assert(r.dtype=="int64","acc 25 dtype "..r.dtype)
  assert(close(r.shape,{4}),"acc 25 shape")
  assert(close(r.strides,{8}),"acc 25 strides")
  assert(close(r:tolist(),{2,6,24,24}),"acc 25 values")
end
do -- accumulate 26: add int32 [0, 0] axis=0
  local a=np.zeros({0,0},np.int32)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="int64","acc 26 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"acc 26 shape")
  assert(close(r.strides,{0,0}),"acc 26 strides")
  assert(close(r:tolist(),{}),"acc 26 values")
end
do -- accumulate 27: add uint32 [1] axis=0
  local a=np.array({0},np.uint32)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 27 dtype "..r.dtype)
  assert(close(r.shape,{1}),"acc 27 shape")
  assert(close(r.strides,{8}),"acc 27 strides")
  assert(close(r:tolist(),{0}),"acc 27 values")
end
do -- accumulate 28: add bool [3, 3, 2] axis=2
  local a=np.array({{{true,true},{false,true},{true,false}},{{true,true},{false,true},{true,false}},{{true,true},{false,true},{true,false}}},np.bool)
  local r=np.add_accumulate(a,{axis=3,dtype=np.int32})
  assert(r.dtype=="int32","acc 28 dtype "..r.dtype)
  assert(close(r.shape,{3,3,2}),"acc 28 shape")
  assert(close(r.strides,{24,8,4}),"acc 28 strides")
  assert(close(r:tolist(),{{{1,2},{0,1},{1,1}},{{1,2},{0,1},{1,1}},{{1,2},{0,1},{1,1}}}),"acc 28 values")
end
do -- accumulate 29: add uint16 [0] axis=0
  local a=np.zeros({0},np.uint16)
  local r=np.add_accumulate(a,{axis=1,dtype=np.float16})
  assert(r.dtype=="float16","acc 29 dtype "..r.dtype)
  assert(close(r.shape,{0}),"acc 29 shape")
  assert(close(r.strides,{0}),"acc 29 strides")
  assert(close(r:tolist(),{}),"acc 29 values")
end
do -- accumulate 30: add int8 [3, 3, 0, 2] axis=2
  local a=np.zeros({3,3,0,2},np.int8)
  local o=np.zeros({3,3,0,2},np.float64)
  local r=np.add_accumulate(a,{axis=3,out=o})
  assert(r==o,"acc 30 out identity")
  assert(r.dtype=="float64","acc 30 dtype "..r.dtype)
  assert(close(r.shape,{3,3,0,2}),"acc 30 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 30 strides")
  assert(close(r:tolist(),{{{},{},{}},{{},{},{}},{{},{},{}}}),"acc 30 values")
end
do -- accumulate 31: multiply int64 [3, 2] axis=0
  local a=np.array({{-1,0},{1,2},{-2,-1}},np.int64)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="int64","acc 31 dtype "..r.dtype)
  assert(close(r.shape,{3,2}),"acc 31 shape")
  assert(close(r.strides,{16,8}),"acc 31 strides")
  assert(close(r:tolist(),{{-1,0},{-1,0},{2,0}}),"acc 31 values")
end
do -- accumulate 32: add float64 [3, 0, 3] axis=0
  local a=np.zeros({3,0,3},np.float64)
  local o=np.zeros({3,0,3},np.int64)
  local r=np.add_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 32 out identity")
  assert(r.dtype=="int64","acc 32 dtype "..r.dtype)
  assert(close(r.shape,{3,0,3}),"acc 32 shape")
  assert(close(r.strides,{0,0,0}),"acc 32 strides")
  assert(close(r:tolist(),{{},{},{}}),"acc 32 values")
end
do -- accumulate 33: add uint32 [4, 3] axis=1
  local a=np.array({{6,0,3},{6,0,3},{6,0,3},{6,0,3}},np.uint32)
  local o=np.zeros({4,3},np.float16)
  local r=np.add_accumulate(a,{axis=2,dtype=np.float64,out=o})
  assert(r==o,"acc 33 out identity")
  assert(r.dtype=="float16","acc 33 dtype "..r.dtype)
  assert(close(r.shape,{4,3}),"acc 33 shape")
  assert(close(r.strides,{6,2}),"acc 33 strides")
  assert(close(r:tolist(),{{6.0,6.0,9.0},{6.0,6.0,9.0},{6.0,6.0,9.0},{6.0,6.0,9.0}}),"acc 33 values")
end
do -- accumulate 34: add float64 [1, 3, 3] axis=2
  local a=(np.array({{{1.2000000000000002},{-1.2000000000000002},{-0.8}},{{-0.4},{0.0},{0.4}},{{0.8},{1.2000000000000002},{-1.2000000000000002}}},np.float64)).T
  local r=np.add_accumulate(a,{axis=3})
  assert(r.dtype=="float64","acc 34 dtype "..r.dtype)
  assert(close(r.shape,{1,3,3}),"acc 34 shape")
  assert(close(r.strides,{72,8,24}),"acc 34 strides")
  assert(close(r:tolist(),{{{1.2000000000000002,0.8000000000000002,1.6},{-1.2000000000000002,-1.2000000000000002,0.0},{-0.8,-0.4,-1.6}}}),"acc 34 values")
end
do -- accumulate 35: multiply float16 [4, 2, 0] axis=2
  local a=np.zeros({4,2,0},np.float16)
  local o=np.zeros({4,2,0},np.int8)
  local r=np.multiply_accumulate(a,{axis=3,out=o})
  assert(r==o,"acc 35 out identity")
  assert(r.dtype=="int8","acc 35 dtype "..r.dtype)
  assert(close(r.shape,{4,2,0}),"acc 35 shape")
  assert(close(r.strides,{0,0,0}),"acc 35 strides")
  assert(close(r:tolist(),{{{},{}},{{},{}},{{},{}},{{},{}}}),"acc 35 values")
end
do -- accumulate 36: multiply uint16 [3, 1, 4, 4] axis=0
  local a=np.array({{{{1,2,3,4},{1,2,3,4},{1,2,3,4},{1,2,3,4}}},{{{1,2,3,4},{1,2,3,4},{1,2,3,4},{1,2,3,4}}},{{{1,2,3,4},{1,2,3,4},{1,2,3,4},{1,2,3,4}}}},np.uint16)
  local o=np.zeros({3,1,4,4},np.uint16)
  local r=np.multiply_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 36 out identity")
  assert(r.dtype=="uint16","acc 36 dtype "..r.dtype)
  assert(close(r.shape,{3,1,4,4}),"acc 36 shape")
  assert(close(r.strides,{32,32,8,2}),"acc 36 strides")
  assert(close(r:tolist(),{{{{1,2,3,4},{1,2,3,4},{1,2,3,4},{1,2,3,4}}},{{{1,4,9,16},{1,4,9,16},{1,4,9,16},{1,4,9,16}}},{{{1,8,27,64},{1,8,27,64},{1,8,27,64},{1,8,27,64}}}}),"acc 36 values")
end
do -- accumulate 37: multiply uint32 [4, 3] axis=0
  local a=np.array({{2,3,4},{1,2,3},{4,1,2},{3,4,1}},np.uint32)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 37 dtype "..r.dtype)
  assert(close(r.shape,{4,3}),"acc 37 shape")
  assert(close(r.strides,{24,8}),"acc 37 strides")
  assert(close(r:tolist(),{{2,3,4},{2,6,12},{8,6,24},{24,24,24}}),"acc 37 values")
end
do -- accumulate 38: multiply float16 [3, 3] axis=0
  local a=(np.array({{1.25,1.5,0.5},{0.75,1.0,1.25},{1.5,0.5,0.75}},np.float16)).T
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="float16","acc 38 dtype "..r.dtype)
  assert(close(r.shape,{3,3}),"acc 38 shape")
  assert(close(r.strides,{2,6}),"acc 38 strides")
  assert(close(r:tolist(),{{1.25,0.75,1.5},{1.875,0.75,0.75},{0.9375,0.9375,0.5625}}),"acc 38 values")
end
do -- accumulate 39: multiply uint32 [4] axis=0
  local a=np.array({4,1,2,3},np.uint32)
  local o=np.zeros({4},np.float64)
  local r=np.multiply_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 39 out identity")
  assert(r.dtype=="float64","acc 39 dtype "..r.dtype)
  assert(close(r.shape,{4}),"acc 39 shape")
  assert(close(r.strides,{8}),"acc 39 strides")
  assert(close(r:tolist(),{4.0,4.0,8.0,24.0}),"acc 39 values")
end
do -- accumulate 40: multiply float64 [2, 0] axis=1
  local a=np.zeros({2,0},np.float64)
  local o=np.zeros({2,0},np.bool)
  local r=np.multiply_accumulate(a,{axis=2,out=o})
  assert(r==o,"acc 40 out identity")
  assert(r.dtype=="bool","acc 40 dtype "..r.dtype)
  assert(close(r.shape,{2,0}),"acc 40 shape")
  assert(close(r.strides,{0,0}),"acc 40 strides")
  assert(close(r:tolist(),{{},{}}),"acc 40 values")
end
do -- accumulate 41: multiply uint16 [2, 0, 2] axis=0
  local a=np.zeros({2,0,2},np.uint16)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 41 dtype "..r.dtype)
  assert(close(r.shape,{2,0,2}),"acc 41 shape")
  assert(close(r.strides,{0,0,0}),"acc 41 strides")
  assert(close(r:tolist(),{{},{}}),"acc 41 values")
end
do -- accumulate 42: multiply uint8 [2, 2] axis=0
  local a=np.array({{3,4},{1,2}},np.uint8)
  local o=np.zeros({2,2},np.uint32)
  local r=np.multiply_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 42 out identity")
  assert(r.dtype=="uint32","acc 42 dtype "..r.dtype)
  assert(close(r.shape,{2,2}),"acc 42 shape")
  assert(close(r.strides,{8,4}),"acc 42 strides")
  assert(close(r:tolist(),{{3,4},{3,8}}),"acc 42 values")
end
do -- accumulate 43: add int64 [1, 1, 4] axis=2
  local a=np.array({{{5,-3,0,3}}},np.int64)
  local r=np.add_accumulate(a,{axis=3})
  assert(r.dtype=="int64","acc 43 dtype "..r.dtype)
  assert(close(r.shape,{1,1,4}),"acc 43 shape")
  assert(close(r.strides,{32,32,8}),"acc 43 strides")
  assert(close(r:tolist(),{{{5,2,2,5}}}),"acc 43 values")
end
do -- accumulate 44: add int32 [4, 2] axis=1
  local a=np.array({{-5,-2},{1,4},{-4,-1},{2,5}},np.int32)
  local r=np.add_accumulate(a,{axis=2})
  assert(r.dtype=="int64","acc 44 dtype "..r.dtype)
  assert(close(r.shape,{4,2}),"acc 44 shape")
  assert(close(r.strides,{16,8}),"acc 44 strides")
  assert(close(r:tolist(),{{-5,-7},{1,5},{-4,-5},{2,7}}),"acc 44 values")
end
do -- accumulate 45: multiply int64 [4, 0] axis=1
  local a=np.zeros({4,0},np.int64)
  local o=np.zeros({4,0},np.uint32)
  local r=np.multiply_accumulate(a,{axis=2,out=o})
  assert(r==o,"acc 45 out identity")
  assert(r.dtype=="uint32","acc 45 dtype "..r.dtype)
  assert(close(r.shape,{4,0}),"acc 45 shape")
  assert(close(r.strides,{0,0}),"acc 45 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"acc 45 values")
end
do -- accumulate 46: add float32 [0, 0] axis=0
  local a=np.zeros({0,0},np.float32)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="float32","acc 46 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"acc 46 shape")
  assert(close(r.strides,{0,0}),"acc 46 strides")
  assert(close(r:tolist(),{}),"acc 46 values")
end
do -- accumulate 47: multiply int32 [2, 0] axis=1
  local a=np.zeros({2,0},np.int32)
  local o=np.zeros({2,0},np.float32)
  local r=np.multiply_accumulate(a,{axis=2,out=o})
  assert(r==o,"acc 47 out identity")
  assert(r.dtype=="float32","acc 47 dtype "..r.dtype)
  assert(close(r.shape,{2,0}),"acc 47 shape")
  assert(close(r.strides,{0,0}),"acc 47 strides")
  assert(close(r:tolist(),{{},{}}),"acc 47 values")
end
do -- accumulate 48: add int8 [4, 3, 1] axis=1
  local a=np.array({{{-1},{2},{5}},{{-3},{0},{3}},{{-5},{-2},{1}},{{4},{-4},{-1}}},np.int8)
  local r=np.add_accumulate(a,{axis=2})
  assert(r.dtype=="int64","acc 48 dtype "..r.dtype)
  assert(close(r.shape,{4,3,1}),"acc 48 shape")
  assert(close(r.strides,{24,8,8}),"acc 48 strides")
  assert(close(r:tolist(),{{{-1},{1},{6}},{{-3},{-3},{0}},{{-5},{-7},{-6}},{{4},{0},{-1}}}),"acc 48 values")
end
do -- accumulate 49: add float16 [3, 1] axis=1
  local a=(np.array({{-1.2000000000000002,-0.8,-0.4}},np.float16)).T
  local o=np.zeros({3,1},np.uint8)
  local r=np.add_accumulate(a,{axis=2,dtype=np.uint8,out=o})
  assert(r==o,"acc 49 out identity")
  assert(r.dtype=="uint8","acc 49 dtype "..r.dtype)
  assert(close(r.shape,{3,1}),"acc 49 shape")
  assert(close(r.strides,{1,1}),"acc 49 strides")
  assert(close(r:tolist(),{{255},{0},{0}}),"acc 49 values")
end
do -- accumulate 50: multiply uint32 [4, 4] axis=1
  local a=np.array({{3,4,1,2},{3,4,1,2},{3,4,1,2},{3,4,1,2}},np.uint32)
  local r=np.multiply_accumulate(a,{axis=2})
  assert(r.dtype=="uint64","acc 50 dtype "..r.dtype)
  assert(close(r.shape,{4,4}),"acc 50 shape")
  assert(close(r.strides,{32,8}),"acc 50 strides")
  assert(close(r:tolist(),{{3,12,12,24},{3,12,12,24},{3,12,12,24},{3,12,12,24}}),"acc 50 values")
end
do -- accumulate 51: add int32 [3, 1, 4, 1] axis=3
  local a=np.array({{{{2},{5},{-3},{0}}},{{{3},{-5},{-2},{1}}},{{{4},{-4},{-1},{2}}}},np.int32)
  local r=np.add_accumulate(a,{axis=4})
  assert(r.dtype=="int64","acc 51 dtype "..r.dtype)
  assert(close(r.shape,{3,1,4,1}),"acc 51 shape")
  assert(close(r.strides,{32,32,8,8}),"acc 51 strides")
  assert(close(r:tolist(),{{{{2},{5},{-3},{0}}},{{{3},{-5},{-2},{1}}},{{{4},{-4},{-1},{2}}}}),"acc 51 values")
end
do -- accumulate 52: multiply int8 [2] axis=0
  local a=np.array({0,1},np.int8)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="int64","acc 52 dtype "..r.dtype)
  assert(close(r.shape,{2}),"acc 52 shape")
  assert(close(r.strides,{8}),"acc 52 strides")
  assert(close(r:tolist(),{0,0}),"acc 52 values")
end
do -- accumulate 53: multiply int16 [0, 4, 2] axis=0
  local a=np.zeros({0,4,2},np.int16)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="int64","acc 53 dtype "..r.dtype)
  assert(close(r.shape,{0,4,2}),"acc 53 shape")
  assert(close(r.strides,{0,0,0}),"acc 53 strides")
  assert(close(r:tolist(),{}),"acc 53 values")
end
do -- accumulate 54: multiply float32 [3, 1, 3, 1] axis=1
  local a=np.array({{{{1.5},{0.5},{0.75}}},{{{1.0},{1.25},{1.5}}},{{{0.5},{0.75},{1.0}}}},np.float32)
  local r=np.multiply_accumulate(a,{axis=2,dtype=np.uint8})
  assert(r.dtype=="uint8","acc 54 dtype "..r.dtype)
  assert(close(r.shape,{3,1,3,1}),"acc 54 shape")
  assert(close(r.strides,{3,3,1,1}),"acc 54 strides")
  assert(close(r:tolist(),{{{{1},{0},{0}}},{{{1},{1},{1}}},{{{0},{0},{1}}}}),"acc 54 values")
end
do -- accumulate 55: multiply uint16 [2, 3, 1, 0] axis=2
  local a=np.zeros({2,3,1,0},np.uint16)
  local r=np.multiply_accumulate(a,{axis=3})
  assert(r.dtype=="uint64","acc 55 dtype "..r.dtype)
  assert(close(r.shape,{2,3,1,0}),"acc 55 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 55 strides")
  assert(close(r:tolist(),{{{{}},{{}},{{}}},{{{}},{{}},{{}}}}),"acc 55 values")
end
do -- accumulate 56: add uint32 [0, 0, 0] axis=0
  local a=np.zeros({0,0,0},np.uint32)
  local o=np.zeros({0,0,0},np.uint32)
  local r=np.add_accumulate(a,{axis=1,dtype=np.float64,out=o})
  assert(r==o,"acc 56 out identity")
  assert(r.dtype=="uint32","acc 56 dtype "..r.dtype)
  assert(close(r.shape,{0,0,0}),"acc 56 shape")
  assert(close(r.strides,{0,0,0}),"acc 56 strides")
  assert(close(r:tolist(),{}),"acc 56 values")
end
do -- accumulate 57: add int64 [4] axis=0
  local a=np.array({-3,0,3,-5},np.int64)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="int64","acc 57 dtype "..r.dtype)
  assert(close(r.shape,{4}),"acc 57 shape")
  assert(close(r.strides,{8}),"acc 57 strides")
  assert(close(r:tolist(),{-3,-3,0,-5}),"acc 57 values")
end
do -- accumulate 58: multiply uint32 [3] axis=0
  local a=np.array({3,4,1},np.uint32)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 58 dtype "..r.dtype)
  assert(close(r.shape,{3}),"acc 58 shape")
  assert(close(r.strides,{8}),"acc 58 strides")
  assert(close(r:tolist(),{3,12,12}),"acc 58 values")
end
do -- accumulate 59: add float16 [2] axis=0
  local a=np.array({0.0,0.4},np.float16)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="float16","acc 59 dtype "..r.dtype)
  assert(close(r.shape,{2}),"acc 59 shape")
  assert(close(r.strides,{2}),"acc 59 strides")
  assert(close(r:tolist(),{0.0,0.39990234375}),"acc 59 values")
end
do -- accumulate 60: multiply uint64 [0] axis=0
  local a=np.zeros({0},np.uint64)
  local o=np.zeros({0},np.float32)
  local r=np.multiply_accumulate(a,{axis=1,dtype=np.float32,out=o})
  assert(r==o,"acc 60 out identity")
  assert(r.dtype=="float32","acc 60 dtype "..r.dtype)
  assert(close(r.shape,{0}),"acc 60 shape")
  assert(close(r.strides,{0}),"acc 60 strides")
  assert(close(r:tolist(),{}),"acc 60 values")
end
do -- accumulate 61: multiply uint32 [2, 3] axis=1
  local a=np.array({{2,3,4},{1,2,3}},np.uint32)
  local r=np.multiply_accumulate(a,{axis=2})
  assert(r.dtype=="uint64","acc 61 dtype "..r.dtype)
  assert(close(r.shape,{2,3}),"acc 61 shape")
  assert(close(r.strides,{24,8}),"acc 61 strides")
  assert(close(r:tolist(),{{2,6,24},{1,2,6}}),"acc 61 values")
end
do -- accumulate 62: multiply int64 [1, 1, 2] axis=0
  local a=np.array({{{0,1}}},np.int64)
  local o=np.zeros({1,1,2},np.int8)
  local r=np.multiply_accumulate(a,{axis=1,dtype=np.int64,out=o})
  assert(r==o,"acc 62 out identity")
  assert(r.dtype=="int8","acc 62 dtype "..r.dtype)
  assert(close(r.shape,{1,1,2}),"acc 62 shape")
  assert(close(r.strides,{2,2,1}),"acc 62 strides")
  assert(close(r:tolist(),{{{0,1}}}),"acc 62 values")
end
do -- accumulate 63: multiply uint8 [3, 2, 0, 3] axis=0
  local a=np.zeros({3,2,0,3},np.uint8)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 63 dtype "..r.dtype)
  assert(close(r.shape,{3,2,0,3}),"acc 63 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 63 strides")
  assert(close(r:tolist(),{{{},{}},{{},{}},{{},{}}}),"acc 63 values")
end
do -- accumulate 64: multiply float16 [2] axis=0
  local a=np.array({1.5,0.5},np.float16)
  local o=np.zeros({2},np.int32)
  local r=np.multiply_accumulate(a,{axis=1,dtype=np.uint16,out=o})
  assert(r==o,"acc 64 out identity")
  assert(r.dtype=="int32","acc 64 dtype "..r.dtype)
  assert(close(r.shape,{2}),"acc 64 shape")
  assert(close(r.strides,{4}),"acc 64 strides")
  assert(close(r:tolist(),{1,0}),"acc 64 values")
end
do -- accumulate 65: multiply int8 [4, 1, 3, 4] axis=3
  local a=np.array({{{{-2,-1,0,1},{2,-2,-1,0},{1,2,-2,-1}}},{{{0,1,2,-2},{-1,0,1,2},{-2,-1,0,1}}},{{{2,-2,-1,0},{1,2,-2,-1},{0,1,2,-2}}},{{{-1,0,1,2},{-2,-1,0,1},{2,-2,-1,0}}}},np.int8)
  local r=np.multiply_accumulate(a,{axis=4})
  assert(r.dtype=="int64","acc 65 dtype "..r.dtype)
  assert(close(r.shape,{4,1,3,4}),"acc 65 shape")
  assert(close(r.strides,{96,96,32,8}),"acc 65 strides")
  assert(close(r:tolist(),{{{{-2,2,0,0},{2,-4,4,0},{1,2,-4,4}}},{{{0,0,0,0},{-1,0,0,0},{-2,2,0,0}}},{{{2,-4,4,0},{1,2,-4,4},{0,0,0,0}}},{{{-1,0,0,0},{-2,2,0,0},{2,-4,4,0}}}}),"acc 65 values")
end
do -- accumulate 66: add float32 [2, 2, 0] axis=0
  local a=np.zeros({2,2,0},np.float32)
  local o=np.zeros({2,2,0},np.bool)
  local r=np.add_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 66 out identity")
  assert(r.dtype=="bool","acc 66 dtype "..r.dtype)
  assert(close(r.shape,{2,2,0}),"acc 66 shape")
  assert(close(r.strides,{0,0,0}),"acc 66 strides")
  assert(close(r:tolist(),{{{},{}},{{},{}}}),"acc 66 values")
end
do -- accumulate 67: add int16 [0, 1, 2, 3] axis=0
  local a=np.zeros({0,1,2,3},np.int16)
  local o=np.zeros({0,1,2,3},np.int64)
  local r=np.add_accumulate(a,{axis=1,dtype=np.bool,out=o})
  assert(r==o,"acc 67 out identity")
  assert(r.dtype=="int64","acc 67 dtype "..r.dtype)
  assert(close(r.shape,{0,1,2,3}),"acc 67 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 67 strides")
  assert(close(r:tolist(),{}),"acc 67 values")
end
do -- accumulate 68: multiply uint8 [1, 4, 3] axis=2
  local a=(np.array({{{1},{2},{3},{4}},{{1},{2},{3},{4}},{{1},{2},{3},{4}}},np.uint8)).T
  local r=np.multiply_accumulate(a,{axis=3})
  assert(r.dtype=="uint64","acc 68 dtype "..r.dtype)
  assert(close(r.shape,{1,4,3}),"acc 68 shape")
  assert(close(r.strides,{96,8,32}),"acc 68 strides")
  assert(close(r:tolist(),{{{1,1,1},{2,4,8},{3,9,27},{4,16,64}}}),"acc 68 values")
end
do -- accumulate 69: multiply float16 [2, 4] axis=0
  local a=np.array({{1.5,0.5,0.75,1.0},{1.25,1.5,0.5,0.75}},np.float16)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="float16","acc 69 dtype "..r.dtype)
  assert(close(r.shape,{2,4}),"acc 69 shape")
  assert(close(r.strides,{8,2}),"acc 69 strides")
  assert(close(r:tolist(),{{1.5,0.5,0.75,1.0},{1.875,0.75,0.375,0.75}}),"acc 69 values")
end
do -- accumulate 70: add bool [1, 1, 1] axis=2
  local a=np.array({{{true}}},np.bool)
  local r=np.add_accumulate(a,{axis=3})
  assert(r.dtype=="int64","acc 70 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1}),"acc 70 shape")
  assert(close(r.strides,{8,8,8}),"acc 70 strides")
  assert(close(r:tolist(),{{{1}}}),"acc 70 values")
end
do -- accumulate 71: multiply int32 [3, 2] axis=0
  local a=np.array({{-1,0},{1,2},{-2,-1}},np.int32)
  local o=np.zeros({3,2},np.uint32)
  local r=np.multiply_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 71 out identity")
  assert(r.dtype=="uint32","acc 71 dtype "..r.dtype)
  assert(close(r.shape,{3,2}),"acc 71 shape")
  assert(close(r.strides,{8,4}),"acc 71 strides")
  assert(close(r:tolist(),{{4294967295,0},{4294967295,0},{2,0}}),"acc 71 values")
end
do -- accumulate 72: multiply bool [0] axis=0
  local a=np.zeros({0},np.bool)
  local o=np.zeros({0},np.int32)
  local r=np.multiply_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 72 out identity")
  assert(r.dtype=="int32","acc 72 dtype "..r.dtype)
  assert(close(r.shape,{0}),"acc 72 shape")
  assert(close(r.strides,{0}),"acc 72 strides")
  assert(close(r:tolist(),{}),"acc 72 values")
end
do -- accumulate 73: multiply bool [0, 4, 1] axis=1
  local a=np.zeros({0,4,1},np.bool)
  local o=np.zeros({0,4,1},np.int64)
  local r=np.multiply_accumulate(a,{axis=2,dtype=np.bool,out=o})
  assert(r==o,"acc 73 out identity")
  assert(r.dtype=="int64","acc 73 dtype "..r.dtype)
  assert(close(r.shape,{0,4,1}),"acc 73 shape")
  assert(close(r.strides,{0,0,0}),"acc 73 strides")
  assert(close(r:tolist(),{}),"acc 73 values")
end
do -- accumulate 74: add float64 [0, 4] axis=1
  local a=np.zeros({0,4},np.float64)
  local r=np.add_accumulate(a,{axis=2})
  assert(r.dtype=="float64","acc 74 dtype "..r.dtype)
  assert(close(r.shape,{0,4}),"acc 74 shape")
  assert(close(r.strides,{0,0}),"acc 74 strides")
  assert(close(r:tolist(),{}),"acc 74 values")
end
do -- accumulate 75: add uint16 [3, 4] axis=0
  local a=np.array({{3,6,0,3},{6,0,3,6},{0,3,6,0}},np.uint16)
  local o=np.zeros({3,4},np.int64)
  local r=np.add_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 75 out identity")
  assert(r.dtype=="int64","acc 75 dtype "..r.dtype)
  assert(close(r.shape,{3,4}),"acc 75 shape")
  assert(close(r.strides,{32,8}),"acc 75 strides")
  assert(close(r:tolist(),{{3,6,0,3},{9,6,3,9},{9,9,9,9}}),"acc 75 values")
end
do -- accumulate 76: add uint32 [4, 0, 4, 1] axis=3
  local a=np.zeros({4,0,4,1},np.uint32)
  local r=np.add_accumulate(a,{axis=4})
  assert(r.dtype=="uint64","acc 76 dtype "..r.dtype)
  assert(close(r.shape,{4,0,4,1}),"acc 76 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 76 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"acc 76 values")
end
do -- accumulate 77: add int64 [1, 0] axis=0
  local a=np.zeros({1,0},np.int64)
  local o=np.zeros({1,0},np.uint16)
  local r=np.add_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 77 out identity")
  assert(r.dtype=="uint16","acc 77 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"acc 77 shape")
  assert(close(r.strides,{0,0}),"acc 77 strides")
  assert(close(r:tolist(),{{}}),"acc 77 values")
end
do -- accumulate 78: add float32 [4, 4] axis=0
  local a=np.array({{-0.8,-0.4,0.0,0.4},{0.8,1.2000000000000002,-1.2000000000000002,-0.8},{-0.4,0.0,0.4,0.8},{1.2000000000000002,-1.2000000000000002,-0.8,-0.4}},np.float32)
  local o=np.zeros({4,4},np.uint16)
  local r=np.add_accumulate(a,{axis=1,dtype=np.uint32,out=o})
  assert(r==o,"acc 78 out identity")
  assert(r.dtype=="uint16","acc 78 dtype "..r.dtype)
  assert(close(r.shape,{4,4}),"acc 78 shape")
  assert(close(r.strides,{8,2}),"acc 78 strides")
  assert(close(r:tolist(),{{0,0,0,0},{0,1,65535,0},{0,1,65535,0},{1,0,65535,0}}),"acc 78 values")
end
do -- accumulate 79: multiply int8 [1] axis=0
  local a=np.array({2},np.int8)
  local r=np.multiply_accumulate(a,{axis=1,dtype=np.uint32})
  assert(r.dtype=="uint32","acc 79 dtype "..r.dtype)
  assert(close(r.shape,{1}),"acc 79 shape")
  assert(close(r.strides,{4}),"acc 79 strides")
  assert(close(r:tolist(),{2}),"acc 79 values")
end
do -- accumulate 80: add bool [4] axis=0
  local a=np.array({true,false,true,true},np.bool)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="int64","acc 80 dtype "..r.dtype)
  assert(close(r.shape,{4}),"acc 80 shape")
  assert(close(r.strides,{8}),"acc 80 strides")
  assert(close(r:tolist(),{1,1,2,3}),"acc 80 values")
end
do -- accumulate 81: add int16 [0] axis=0
  local a=np.zeros({0},np.int16)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="int64","acc 81 dtype "..r.dtype)
  assert(close(r.shape,{0}),"acc 81 shape")
  assert(close(r.strides,{0}),"acc 81 strides")
  assert(close(r:tolist(),{}),"acc 81 values")
end
do -- accumulate 82: multiply int32 [4, 0, 4] axis=1
  local a=np.zeros({4,0,4},np.int32)
  local r=np.multiply_accumulate(a,{axis=2,dtype=np.uint32})
  assert(r.dtype=="uint32","acc 82 dtype "..r.dtype)
  assert(close(r.shape,{4,0,4}),"acc 82 shape")
  assert(close(r.strides,{0,0,0}),"acc 82 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"acc 82 values")
end
do -- accumulate 83: multiply int8 [2, 4, 1] axis=0
  local a=np.array({{{1},{2},{-2},{-1}},{{0},{1},{2},{-2}}},np.int8)
  local r=np.multiply_accumulate(a,{axis=1,dtype=np.uint64})
  assert(r.dtype=="uint64","acc 83 dtype "..r.dtype)
  assert(close(r.shape,{2,4,1}),"acc 83 shape")
  assert(close(r.strides,{32,8,8}),"acc 83 strides")
  assert(close(r:tolist(),{{{1},{2},{18446744073709551614},{18446744073709551615}},{{0},{2},{18446744073709551612},{2}}}),"acc 83 values")
end
do -- accumulate 84: multiply bool [3, 2, 2, 1] axis=0
  local a=np.array({{{{false},{true}},{{true},{false}}},{{{true},{true}},{{false},{true}}},{{{true},{false}},{{true},{true}}}},np.bool)
  local r=np.multiply_accumulate(a,{axis=1,dtype=np.int16})
  assert(r.dtype=="int16","acc 84 dtype "..r.dtype)
  assert(close(r.shape,{3,2,2,1}),"acc 84 shape")
  assert(close(r.strides,{8,4,2,2}),"acc 84 strides")
  assert(close(r:tolist(),{{{{0},{1}},{{1},{0}}},{{{0},{1}},{{0},{0}}},{{{0},{0}},{{0},{0}}}}),"acc 84 values")
end
do -- accumulate 85: add uint8 [1] axis=0
  local a=np.array({4},np.uint8)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 85 dtype "..r.dtype)
  assert(close(r.shape,{1}),"acc 85 shape")
  assert(close(r.strides,{8}),"acc 85 strides")
  assert(close(r:tolist(),{4}),"acc 85 values")
end
do -- accumulate 86: add uint16 [4, 2, 0] axis=0
  local a=np.zeros({4,2,0},np.uint16)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 86 dtype "..r.dtype)
  assert(close(r.shape,{4,2,0}),"acc 86 shape")
  assert(close(r.strides,{0,0,0}),"acc 86 strides")
  assert(close(r:tolist(),{{{},{}},{{},{}},{{},{}},{{},{}}}),"acc 86 values")
end
do -- accumulate 87: multiply uint8 [3, 4] axis=1
  local a=np.array({{4,1,2,3},{4,1,2,3},{4,1,2,3}},np.uint8)
  local r=np.multiply_accumulate(a,{axis=2})
  assert(r.dtype=="uint64","acc 87 dtype "..r.dtype)
  assert(close(r.shape,{3,4}),"acc 87 shape")
  assert(close(r.strides,{32,8}),"acc 87 strides")
  assert(close(r:tolist(),{{4,4,8,24},{4,4,8,24},{4,4,8,24}}),"acc 87 values")
end
do -- accumulate 88: add float64 [0] axis=0
  local a=np.zeros({0},np.float64)
  local r=np.add_accumulate(a,{axis=1,dtype=np.float64})
  assert(r.dtype=="float64","acc 88 dtype "..r.dtype)
  assert(close(r.shape,{0}),"acc 88 shape")
  assert(close(r.strides,{0}),"acc 88 strides")
  assert(close(r:tolist(),{}),"acc 88 values")
end
do -- accumulate 89: add float32 [0, 2, 2, 4] axis=1
  local a=np.zeros({0,2,2,4},np.float32)
  local o=np.zeros({0,2,2,4},np.uint16)
  local r=np.add_accumulate(a,{axis=2,out=o})
  assert(r==o,"acc 89 out identity")
  assert(r.dtype=="uint16","acc 89 dtype "..r.dtype)
  assert(close(r.shape,{0,2,2,4}),"acc 89 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 89 strides")
  assert(close(r:tolist(),{}),"acc 89 values")
end
do -- accumulate 90: add uint32 [0, 1] axis=0
  local a=np.zeros({0,1},np.uint32)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 90 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"acc 90 shape")
  assert(close(r.strides,{0,0}),"acc 90 strides")
  assert(close(r:tolist(),{}),"acc 90 values")
end
do -- accumulate 91: multiply float32 [0, 2] axis=1
  local a=np.zeros({0,2},np.float32)
  local r=np.multiply_accumulate(a,{axis=2})
  assert(r.dtype=="float32","acc 91 dtype "..r.dtype)
  assert(close(r.shape,{0,2}),"acc 91 shape")
  assert(close(r.strides,{0,0}),"acc 91 strides")
  assert(close(r:tolist(),{}),"acc 91 values")
end
do -- accumulate 92: multiply int16 [1, 4, 3] axis=1
  local a=np.array({{{0,1,2},{-2,-1,0},{1,2,-2},{-1,0,1}}},np.int16)
  local o=np.zeros({1,4,3},np.float64)
  local r=np.multiply_accumulate(a,{axis=2,out=o})
  assert(r==o,"acc 92 out identity")
  assert(r.dtype=="float64","acc 92 dtype "..r.dtype)
  assert(close(r.shape,{1,4,3}),"acc 92 shape")
  assert(close(r.strides,{96,24,8}),"acc 92 strides")
  assert(close(r:tolist(),{{{0.0,1.0,2.0},{-0.0,-1.0,0.0},{-0.0,-2.0,-0.0},{0.0,-0.0,-0.0}}}),"acc 92 values")
end
do -- accumulate 93: multiply uint16 [3, 1, 0] axis=1
  local a=np.zeros({3,1,0},np.uint16)
  local r=np.multiply_accumulate(a,{axis=2})
  assert(r.dtype=="uint64","acc 93 dtype "..r.dtype)
  assert(close(r.shape,{3,1,0}),"acc 93 shape")
  assert(close(r.strides,{0,0,0}),"acc 93 strides")
  assert(close(r:tolist(),{{{}},{{}},{{}}}),"acc 93 values")
end
do -- accumulate 94: multiply uint8 [3, 3] axis=0
  local a=np.array({{3,4,1},{2,3,4},{1,2,3}},np.uint8)
  local o=np.zeros({3,3},np.int16)
  local r=np.multiply_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 94 out identity")
  assert(r.dtype=="int16","acc 94 dtype "..r.dtype)
  assert(close(r.shape,{3,3}),"acc 94 shape")
  assert(close(r.strides,{6,2}),"acc 94 strides")
  assert(close(r:tolist(),{{3,4,1},{6,12,4},{6,24,12}}),"acc 94 values")
end
do -- accumulate 95: add uint64 [0] axis=0
  local a=np.zeros({0},np.uint64)
  local r=np.add_accumulate(a,{axis=1,dtype=np.uint16})
  assert(r.dtype=="uint16","acc 95 dtype "..r.dtype)
  assert(close(r.shape,{0}),"acc 95 shape")
  assert(close(r.strides,{0}),"acc 95 strides")
  assert(close(r:tolist(),{}),"acc 95 values")
end
do -- accumulate 96: add int16 [0, 4, 1, 3] axis=2
  local a=np.zeros({0,4,1,3},np.int16)
  local r=np.add_accumulate(a,{axis=3})
  assert(r.dtype=="int64","acc 96 dtype "..r.dtype)
  assert(close(r.shape,{0,4,1,3}),"acc 96 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 96 strides")
  assert(close(r:tolist(),{}),"acc 96 values")
end
do -- accumulate 97: multiply bool [1, 0] axis=1
  local a=np.zeros({1,0},np.bool)
  local r=np.multiply_accumulate(a,{axis=2,dtype=np.float32})
  assert(r.dtype=="float32","acc 97 dtype "..r.dtype)
  assert(close(r.shape,{1,0}),"acc 97 shape")
  assert(close(r.strides,{0,0}),"acc 97 strides")
  assert(close(r:tolist(),{{}}),"acc 97 values")
end
do -- accumulate 98: multiply float16 [3, 4] axis=1
  local a=np.array({{1.25,1.5,0.5,0.75},{1.0,1.25,1.5,0.5},{0.75,1.0,1.25,1.5}},np.float16)
  local r=np.multiply_accumulate(a,{axis=2})
  assert(r.dtype=="float16","acc 98 dtype "..r.dtype)
  assert(close(r.shape,{3,4}),"acc 98 shape")
  assert(close(r.strides,{8,2}),"acc 98 strides")
  assert(close(r:tolist(),{{1.25,1.875,0.9375,0.703125},{1.0,1.25,1.875,0.9375},{0.75,0.75,0.9375,1.40625}}),"acc 98 values")
end
do -- accumulate 99: multiply uint16 [0, 3] axis=1
  local a=np.zeros({0,3},np.uint16)
  local o=np.zeros({0,3},np.uint16)
  local r=np.multiply_accumulate(a,{axis=2,out=o})
  assert(r==o,"acc 99 out identity")
  assert(r.dtype=="uint16","acc 99 dtype "..r.dtype)
  assert(close(r.shape,{0,3}),"acc 99 shape")
  assert(close(r.strides,{0,0}),"acc 99 strides")
  assert(close(r:tolist(),{}),"acc 99 values")
end
do -- accumulate 100: multiply float32 [0] axis=0
  local a=np.zeros({0},np.float32)
  local r=np.multiply_accumulate(a,{axis=1,dtype=np.uint8})
  assert(r.dtype=="uint8","acc 100 dtype "..r.dtype)
  assert(close(r.shape,{0}),"acc 100 shape")
  assert(close(r.strides,{0}),"acc 100 strides")
  assert(close(r:tolist(),{}),"acc 100 values")
end
do -- accumulate 101: multiply int16 [3, 4] axis=1
  local a=np.array({{-1,0,1,2},{-2,-1,0,1},{2,-2,-1,0}},np.int16)
  local r=np.multiply_accumulate(a,{axis=2,dtype=np.uint16})
  assert(r.dtype=="uint16","acc 101 dtype "..r.dtype)
  assert(close(r.shape,{3,4}),"acc 101 shape")
  assert(close(r.strides,{8,2}),"acc 101 strides")
  assert(close(r:tolist(),{{65535,0,0,0},{65534,2,0,0},{2,65532,4,0}}),"acc 101 values")
end
do -- accumulate 102: multiply float64 [1, 3, 2] axis=0
  local a=(np.array({{{1.0},{1.25},{1.5}},{{0.5},{0.75},{1.0}}},np.float64)).T
  local o=np.zeros({1,3,2},np.int32)
  local r=np.multiply_accumulate(a,{axis=1,dtype=np.int64,out=o})
  assert(r==o,"acc 102 out identity")
  assert(r.dtype=="int32","acc 102 dtype "..r.dtype)
  assert(close(r.shape,{1,3,2}),"acc 102 shape")
  assert(close(r.strides,{24,8,4}),"acc 102 strides")
  assert(close(r:tolist(),{{{1,0},{1,0},{1,1}}}),"acc 102 values")
end
do -- accumulate 103: add int8 [1] axis=0
  local a=np.array({-1},np.int8)
  local r=np.add_accumulate(a,{axis=1,dtype=np.uint64})
  assert(r.dtype=="uint64","acc 103 dtype "..r.dtype)
  assert(close(r.shape,{1}),"acc 103 shape")
  assert(close(r.strides,{8}),"acc 103 strides")
  assert(close(r:tolist(),{18446744073709551615}),"acc 103 values")
end
do -- accumulate 104: multiply float32 [2, 4] axis=1
  local a=(np.array({{1.5,0.5},{0.75,1.0},{1.25,1.5},{0.5,0.75}},np.float32)).T
  local r=np.multiply_accumulate(a,{axis=2,dtype=np.float64})
  assert(r.dtype=="float64","acc 104 dtype "..r.dtype)
  assert(close(r.shape,{2,4}),"acc 104 shape")
  assert(close(r.strides,{8,16}),"acc 104 strides")
  assert(close(r:tolist(),{{1.5,1.125,1.40625,0.703125},{0.5,0.5,0.75,0.5625}}),"acc 104 values")
end
do -- accumulate 105: add bool [0, 0, 2, 2] axis=2
  local a=np.zeros({0,0,2,2},np.bool)
  local o=np.zeros({0,0,2,2},np.bool)
  local r=np.add_accumulate(a,{axis=3,out=o})
  assert(r==o,"acc 105 out identity")
  assert(r.dtype=="bool","acc 105 dtype "..r.dtype)
  assert(close(r.shape,{0,0,2,2}),"acc 105 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 105 strides")
  assert(close(r:tolist(),{}),"acc 105 values")
end
do -- accumulate 106: add int8 [3, 0] axis=1
  local a=np.zeros({3,0},np.int8)
  local r=np.add_accumulate(a,{axis=2})
  assert(r.dtype=="int64","acc 106 dtype "..r.dtype)
  assert(close(r.shape,{3,0}),"acc 106 shape")
  assert(close(r.strides,{0,0}),"acc 106 strides")
  assert(close(r:tolist(),{{},{},{}}),"acc 106 values")
end
do -- accumulate 107: add uint8 [2] axis=0
  local a=np.array({8,2},np.uint8)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 107 dtype "..r.dtype)
  assert(close(r.shape,{2}),"acc 107 shape")
  assert(close(r.strides,{8}),"acc 107 strides")
  assert(close(r:tolist(),{8,10}),"acc 107 values")
end
do -- accumulate 108: add int16 [3, 3, 2, 0] axis=2
  local a=np.zeros({3,3,2,0},np.int16)
  local r=np.add_accumulate(a,{axis=3})
  assert(r.dtype=="int64","acc 108 dtype "..r.dtype)
  assert(close(r.shape,{3,3,2,0}),"acc 108 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 108 strides")
  assert(close(r:tolist(),{{{{},{}},{{},{}},{{},{}}},{{{},{}},{{},{}},{{},{}}},{{{},{}},{{},{}},{{},{}}}}),"acc 108 values")
end
do -- accumulate 109: multiply uint8 [0, 0] axis=0
  local a=np.zeros({0,0},np.uint8)
  local r=np.multiply_accumulate(a,{axis=1,dtype=np.float64})
  assert(r.dtype=="float64","acc 109 dtype "..r.dtype)
  assert(close(r.shape,{0,0}),"acc 109 shape")
  assert(close(r.strides,{0,0}),"acc 109 strides")
  assert(close(r:tolist(),{}),"acc 109 values")
end
do -- accumulate 110: multiply int32 [3, 1, 1, 3] axis=0
  local a=np.array({{{{-2,-1,0}}},{{{1,2,-2}}},{{{-1,0,1}}}},np.int32)
  local o=np.zeros({3,1,1,3},np.float16)
  local r=np.multiply_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 110 out identity")
  assert(r.dtype=="float16","acc 110 dtype "..r.dtype)
  assert(close(r.shape,{3,1,1,3}),"acc 110 shape")
  assert(close(r.strides,{6,6,6,2}),"acc 110 strides")
  assert(close(r:tolist(),{{{{-2.0,-1.0,0.0}}},{{{-2.0,-2.0,-0.0}}},{{{2.0,-0.0,-0.0}}}}),"acc 110 values")
end
do -- accumulate 111: multiply int64 [1] axis=0
  local a=np.array({-1},np.int64)
  local o=np.zeros({1},np.int16)
  local r=np.multiply_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 111 out identity")
  assert(r.dtype=="int16","acc 111 dtype "..r.dtype)
  assert(close(r.shape,{1}),"acc 111 shape")
  assert(close(r.strides,{2}),"acc 111 strides")
  assert(close(r:tolist(),{-1}),"acc 111 values")
end
do -- accumulate 112: add uint32 [0, 1, 0, 3] axis=3
  local a=np.zeros({0,1,0,3},np.uint32)
  local r=np.add_accumulate(a,{axis=4})
  assert(r.dtype=="uint64","acc 112 dtype "..r.dtype)
  assert(close(r.shape,{0,1,0,3}),"acc 112 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 112 strides")
  assert(close(r:tolist(),{}),"acc 112 values")
end
do -- accumulate 113: multiply uint8 [4] axis=0
  local a=np.array({2,3,4,1},np.uint8)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 113 dtype "..r.dtype)
  assert(close(r.shape,{4}),"acc 113 shape")
  assert(close(r.strides,{8}),"acc 113 strides")
  assert(close(r:tolist(),{2,6,24,24}),"acc 113 values")
end
do -- accumulate 114: multiply float16 [1, 1, 2, 2] axis=1
  local a=np.array({{{{1.5,0.5},{0.75,1.0}}}},np.float16)
  local o=np.zeros({1,1,2,2},np.int16)
  local r=np.multiply_accumulate(a,{axis=2,out=o})
  assert(r==o,"acc 114 out identity")
  assert(r.dtype=="int16","acc 114 dtype "..r.dtype)
  assert(close(r.shape,{1,1,2,2}),"acc 114 shape")
  assert(close(r.strides,{8,8,4,2}),"acc 114 strides")
  assert(close(r:tolist(),{{{{1,0},{0,1}}}}),"acc 114 values")
end
do -- accumulate 115: add int32 [4, 0] axis=0
  local a=np.zeros({4,0},np.int32)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="int64","acc 115 dtype "..r.dtype)
  assert(close(r.shape,{4,0}),"acc 115 shape")
  assert(close(r.strides,{0,0}),"acc 115 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"acc 115 values")
end
do -- accumulate 116: multiply float64 [3, 4, 3, 0] axis=1
  local a=np.zeros({3,4,3,0},np.float64)
  local r=np.multiply_accumulate(a,{axis=2})
  assert(r.dtype=="float64","acc 116 dtype "..r.dtype)
  assert(close(r.shape,{3,4,3,0}),"acc 116 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 116 strides")
  assert(close(r:tolist(),{{{{},{},{}},{{},{},{}},{{},{},{}},{{},{},{}}},{{{},{},{}},{{},{},{}},{{},{},{}},{{},{},{}}},{{{},{},{}},{{},{},{}},{{},{},{}},{{},{},{}}}}),"acc 116 values")
end
do -- accumulate 117: multiply int32 [4, 4, 3] axis=1
  local a=np.array({{{0,1,2},{-2,-1,0},{1,2,-2},{-1,0,1}},{{2,-2,-1},{0,1,2},{-2,-1,0},{1,2,-2}},{{-1,0,1},{2,-2,-1},{0,1,2},{-2,-1,0}},{{1,2,-2},{-1,0,1},{2,-2,-1},{0,1,2}}},np.int32)
  local o=np.zeros({4,4,3},np.float64)
  local r=np.multiply_accumulate(a,{axis=2,dtype=np.int16,out=o})
  assert(r==o,"acc 117 out identity")
  assert(r.dtype=="float64","acc 117 dtype "..r.dtype)
  assert(close(r.shape,{4,4,3}),"acc 117 shape")
  assert(close(r.strides,{96,24,8}),"acc 117 strides")
  assert(close(r:tolist(),{{{0.0,1.0,2.0},{0.0,-1.0,0.0},{0.0,-2.0,0.0},{0.0,0.0,0.0}},{{2.0,-2.0,-1.0},{0.0,-2.0,-2.0},{0.0,2.0,0.0},{0.0,4.0,0.0}},{{-1.0,0.0,1.0},{-2.0,0.0,-1.0},{0.0,0.0,-2.0},{0.0,0.0,0.0}},{{1.0,2.0,-2.0},{-1.0,0.0,-2.0},{-2.0,0.0,2.0},{0.0,0.0,4.0}}}),"acc 117 values")
end
do -- accumulate 118: add int8 [1] axis=0
  local a=np.array({3},np.int8)
  local o=np.zeros({1},np.uint16)
  local r=np.add_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 118 out identity")
  assert(r.dtype=="uint16","acc 118 dtype "..r.dtype)
  assert(close(r.shape,{1}),"acc 118 shape")
  assert(close(r.strides,{2}),"acc 118 strides")
  assert(close(r:tolist(),{3}),"acc 118 values")
end
do -- accumulate 119: add float64 [2, 3, 3, 3] axis=3
  local a=np.array({{{{-1.2000000000000002,-0.8,-0.4},{0.0,0.4,0.8},{1.2000000000000002,-1.2000000000000002,-0.8}},{{-0.4,0.0,0.4},{0.8,1.2000000000000002,-1.2000000000000002},{-0.8,-0.4,0.0}},{{0.4,0.8,1.2000000000000002},{-1.2000000000000002,-0.8,-0.4},{0.0,0.4,0.8}}},{{{1.2000000000000002,-1.2000000000000002,-0.8},{-0.4,0.0,0.4},{0.8,1.2000000000000002,-1.2000000000000002}},{{-0.8,-0.4,0.0},{0.4,0.8,1.2000000000000002},{-1.2000000000000002,-0.8,-0.4}},{{0.0,0.4,0.8},{1.2000000000000002,-1.2000000000000002,-0.8},{-0.4,0.0,0.4}}}},np.float64)
  local o=np.zeros({2,3,3,3},np.float64)
  local r=np.add_accumulate(a,{axis=4,out=o})
  assert(r==o,"acc 119 out identity")
  assert(r.dtype=="float64","acc 119 dtype "..r.dtype)
  assert(close(r.shape,{2,3,3,3}),"acc 119 shape")
  assert(close(r.strides,{216,72,24,8}),"acc 119 strides")
  assert(close(r:tolist(),{{{{-1.2000000000000002,-2.0,-2.4},{0.0,0.4,1.2000000000000002},{1.2000000000000002,0.0,-0.8}},{{-0.4,-0.4,0.0},{0.8,2.0,0.7999999999999998},{-0.8,-1.2000000000000002,-1.2000000000000002}},{{0.4,1.2000000000000002,2.4000000000000004},{-1.2000000000000002,-2.0,-2.4},{0.0,0.4,1.2000000000000002}}},{{{1.2000000000000002,0.0,-0.8},{-0.4,-0.4,0.0},{0.8,2.0,0.7999999999999998}},{{-0.8,-1.2000000000000002,-1.2000000000000002},{0.4,1.2000000000000002,2.4000000000000004},{-1.2000000000000002,-2.0,-2.4}},{{0.0,0.4,1.2000000000000002},{1.2000000000000002,0.0,-0.8},{-0.4,-0.4,0.0}}}}),"acc 119 values")
end
do -- accumulate 120: multiply uint64 [2, 4, 4, 2] axis=3
  local a=np.array({{{{1,2},{3,4},{1,2},{3,4}},{{1,2},{3,4},{1,2},{3,4}},{{1,2},{3,4},{1,2},{3,4}},{{1,2},{3,4},{1,2},{3,4}}},{{{1,2},{3,4},{1,2},{3,4}},{{1,2},{3,4},{1,2},{3,4}},{{1,2},{3,4},{1,2},{3,4}},{{1,2},{3,4},{1,2},{3,4}}}},np.uint64)
  local r=np.multiply_accumulate(a,{axis=4})
  assert(r.dtype=="uint64","acc 120 dtype "..r.dtype)
  assert(close(r.shape,{2,4,4,2}),"acc 120 shape")
  assert(close(r.strides,{256,64,16,8}),"acc 120 strides")
  assert(close(r:tolist(),{{{{1,2},{3,12},{1,2},{3,12}},{{1,2},{3,12},{1,2},{3,12}},{{1,2},{3,12},{1,2},{3,12}},{{1,2},{3,12},{1,2},{3,12}}},{{{1,2},{3,12},{1,2},{3,12}},{{1,2},{3,12},{1,2},{3,12}},{{1,2},{3,12},{1,2},{3,12}},{{1,2},{3,12},{1,2},{3,12}}}}),"acc 120 values")
end
do -- accumulate 121: multiply uint16 [0, 2] axis=0
  local a=np.zeros({0,2},np.uint16)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 121 dtype "..r.dtype)
  assert(close(r.shape,{0,2}),"acc 121 shape")
  assert(close(r.strides,{0,0}),"acc 121 strides")
  assert(close(r:tolist(),{}),"acc 121 values")
end
do -- accumulate 122: add int64 [3] axis=0
  local a=np.array({-4,-1,2},np.int64)
  local o=np.zeros({3},np.float64)
  local r=np.add_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 122 out identity")
  assert(r.dtype=="float64","acc 122 dtype "..r.dtype)
  assert(close(r.shape,{3}),"acc 122 shape")
  assert(close(r.strides,{8}),"acc 122 strides")
  assert(close(r:tolist(),{-4.0,-5.0,-3.0}),"acc 122 values")
end
do -- accumulate 123: add int8 [2] axis=0
  local a=np.array({-3,0},np.int8)
  local r=np.add_accumulate(a,{axis=1,dtype=np.float64})
  assert(r.dtype=="float64","acc 123 dtype "..r.dtype)
  assert(close(r.shape,{2}),"acc 123 shape")
  assert(close(r.strides,{8}),"acc 123 strides")
  assert(close(r:tolist(),{-3.0,-3.0}),"acc 123 values")
end
do -- accumulate 124: multiply float16 [0, 2] axis=0
  local a=np.zeros({0,2},np.float16)
  local o=np.zeros({0,2},np.int8)
  local r=np.multiply_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 124 out identity")
  assert(r.dtype=="int8","acc 124 dtype "..r.dtype)
  assert(close(r.shape,{0,2}),"acc 124 shape")
  assert(close(r.strides,{0,0}),"acc 124 strides")
  assert(close(r:tolist(),{}),"acc 124 values")
end
do -- accumulate 125: add uint16 [2, 1] axis=1
  local a=np.array({{8},{2}},np.uint16)
  local r=np.add_accumulate(a,{axis=2})
  assert(r.dtype=="uint64","acc 125 dtype "..r.dtype)
  assert(close(r.shape,{2,1}),"acc 125 shape")
  assert(close(r.strides,{8,8}),"acc 125 strides")
  assert(close(r:tolist(),{{8},{2}}),"acc 125 values")
end
do -- accumulate 126: add float64 [4, 3, 3, 4] axis=2
  local a=np.array({{{{-1.2000000000000002,-0.8,-0.4,0.0},{0.4,0.8,1.2000000000000002,-1.2000000000000002},{-0.8,-0.4,0.0,0.4}},{{0.8,1.2000000000000002,-1.2000000000000002,-0.8},{-0.4,0.0,0.4,0.8},{1.2000000000000002,-1.2000000000000002,-0.8,-0.4}},{{0.0,0.4,0.8,1.2000000000000002},{-1.2000000000000002,-0.8,-0.4,0.0},{0.4,0.8,1.2000000000000002,-1.2000000000000002}}},{{{-0.8,-0.4,0.0,0.4},{0.8,1.2000000000000002,-1.2000000000000002,-0.8},{-0.4,0.0,0.4,0.8}},{{1.2000000000000002,-1.2000000000000002,-0.8,-0.4},{0.0,0.4,0.8,1.2000000000000002},{-1.2000000000000002,-0.8,-0.4,0.0}},{{0.4,0.8,1.2000000000000002,-1.2000000000000002},{-0.8,-0.4,0.0,0.4},{0.8,1.2000000000000002,-1.2000000000000002,-0.8}}},{{{-0.4,0.0,0.4,0.8},{1.2000000000000002,-1.2000000000000002,-0.8,-0.4},{0.0,0.4,0.8,1.2000000000000002}},{{-1.2000000000000002,-0.8,-0.4,0.0},{0.4,0.8,1.2000000000000002,-1.2000000000000002},{-0.8,-0.4,0.0,0.4}},{{0.8,1.2000000000000002,-1.2000000000000002,-0.8},{-0.4,0.0,0.4,0.8},{1.2000000000000002,-1.2000000000000002,-0.8,-0.4}}},{{{0.0,0.4,0.8,1.2000000000000002},{-1.2000000000000002,-0.8,-0.4,0.0},{0.4,0.8,1.2000000000000002,-1.2000000000000002}},{{-0.8,-0.4,0.0,0.4},{0.8,1.2000000000000002,-1.2000000000000002,-0.8},{-0.4,0.0,0.4,0.8}},{{1.2000000000000002,-1.2000000000000002,-0.8,-0.4},{0.0,0.4,0.8,1.2000000000000002},{-1.2000000000000002,-0.8,-0.4,0.0}}}},np.float64)
  local r=np.add_accumulate(a,{axis=3,dtype=np.uint8})
  assert(r.dtype=="uint8","acc 126 dtype "..r.dtype)
  assert(close(r.shape,{4,3,3,4}),"acc 126 shape")
  assert(close(r.strides,{36,12,4,1}),"acc 126 strides")
  assert(close(r:tolist(),{{{{255,0,0,0},{255,0,1,255},{255,0,1,255}},{{0,1,255,0},{0,1,255,0},{1,0,255,0}},{{0,0,0,1},{255,0,0,1},{255,0,1,0}}},{{{0,0,0,0},{0,1,255,0},{0,1,255,0}},{{1,255,0,0},{1,255,0,1},{0,255,0,1}},{{0,0,1,255},{0,0,1,255},{0,1,0,255}}},{{{0,0,0,0},{1,255,0,0},{1,255,0,1}},{{255,0,0,0},{255,0,1,255},{255,0,1,255}},{{0,1,255,0},{0,1,255,0},{1,0,255,0}}},{{{0,0,0,1},{255,0,0,1},{255,0,1,0}},{{0,0,0,0},{0,1,255,0},{0,1,255,0}},{{1,255,0,0},{1,255,0,1},{0,255,0,1}}}}),"acc 126 values")
end
do -- accumulate 127: add float64 [3, 4] axis=0
  local a=np.array({{-0.8,-0.4,0.0,0.4},{0.8,1.2000000000000002,-1.2000000000000002,-0.8},{-0.4,0.0,0.4,0.8}},np.float64)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="float64","acc 127 dtype "..r.dtype)
  assert(close(r.shape,{3,4}),"acc 127 shape")
  assert(close(r.strides,{32,8}),"acc 127 strides")
  assert(close(r:tolist(),{{-0.8,-0.4,0.0,0.4},{0.0,0.8000000000000002,-1.2000000000000002,-0.4},{-0.4,0.8000000000000002,-0.8000000000000002,0.4}}),"acc 127 values")
end
do -- accumulate 128: add int16 [0, 4, 0] axis=2
  local a=np.zeros({0,4,0},np.int16)
  local r=np.add_accumulate(a,{axis=3})
  assert(r.dtype=="int64","acc 128 dtype "..r.dtype)
  assert(close(r.shape,{0,4,0}),"acc 128 shape")
  assert(close(r.strides,{0,0,0}),"acc 128 strides")
  assert(close(r:tolist(),{}),"acc 128 values")
end
do -- accumulate 129: add uint8 [4, 0] axis=0
  local a=np.zeros({4,0},np.uint8)
  local r=np.add_accumulate(a,{axis=1,dtype=np.int16})
  assert(r.dtype=="int16","acc 129 dtype "..r.dtype)
  assert(close(r.shape,{4,0}),"acc 129 shape")
  assert(close(r.strides,{0,0}),"acc 129 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"acc 129 values")
end
do -- accumulate 130: add int8 [2, 1] axis=1
  local a=np.array({{4},{-4}},np.int8)
  local r=np.add_accumulate(a,{axis=2,dtype=np.bool})
  assert(r.dtype=="bool","acc 130 dtype "..r.dtype)
  assert(close(r.shape,{2,1}),"acc 130 shape")
  assert(close(r.strides,{1,1}),"acc 130 strides")
  assert(close(r:tolist(),{{true},{true}}),"acc 130 values")
end
do -- accumulate 131: multiply uint8 [4] axis=0
  local a=np.array({4,1,2,3},np.uint8)
  local r=np.multiply_accumulate(a,{axis=1,dtype=np.uint64})
  assert(r.dtype=="uint64","acc 131 dtype "..r.dtype)
  assert(close(r.shape,{4}),"acc 131 shape")
  assert(close(r.strides,{8}),"acc 131 strides")
  assert(close(r:tolist(),{4,4,8,24}),"acc 131 values")
end
do -- accumulate 132: add uint8 [2, 3, 3, 3] axis=0
  local a=np.array({{{{6,0,3},{6,0,3},{6,0,3}},{{6,0,3},{6,0,3},{6,0,3}},{{6,0,3},{6,0,3},{6,0,3}}},{{{6,0,3},{6,0,3},{6,0,3}},{{6,0,3},{6,0,3},{6,0,3}},{{6,0,3},{6,0,3},{6,0,3}}}},np.uint8)
  local o=np.zeros({2,3,3,3},np.int64)
  local r=np.add_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 132 out identity")
  assert(r.dtype=="int64","acc 132 dtype "..r.dtype)
  assert(close(r.shape,{2,3,3,3}),"acc 132 shape")
  assert(close(r.strides,{216,72,24,8}),"acc 132 strides")
  assert(close(r:tolist(),{{{{6,0,3},{6,0,3},{6,0,3}},{{6,0,3},{6,0,3},{6,0,3}},{{6,0,3},{6,0,3},{6,0,3}}},{{{12,0,6},{12,0,6},{12,0,6}},{{12,0,6},{12,0,6},{12,0,6}},{{12,0,6},{12,0,6},{12,0,6}}}}),"acc 132 values")
end
do -- accumulate 133: add int32 [4, 3, 0, 1] axis=3
  local a=np.zeros({4,3,0,1},np.int32)
  local r=np.add_accumulate(a,{axis=4})
  assert(r.dtype=="int64","acc 133 dtype "..r.dtype)
  assert(close(r.shape,{4,3,0,1}),"acc 133 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 133 strides")
  assert(close(r:tolist(),{{{},{},{}},{{},{},{}},{{},{},{}},{{},{},{}}}),"acc 133 values")
end
do -- accumulate 134: add uint64 [1, 1, 2, 1] axis=1
  local a=np.array({{{{8},{2}}}},np.uint64)
  local r=np.add_accumulate(a,{axis=2})
  assert(r.dtype=="uint64","acc 134 dtype "..r.dtype)
  assert(close(r.shape,{1,1,2,1}),"acc 134 shape")
  assert(close(r.strides,{16,16,8,8}),"acc 134 strides")
  assert(close(r:tolist(),{{{{8},{2}}}}),"acc 134 values")
end
do -- accumulate 135: add uint16 [3] axis=0
  local a=np.array({0,3,6},np.uint16)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 135 dtype "..r.dtype)
  assert(close(r.shape,{3}),"acc 135 shape")
  assert(close(r.strides,{8}),"acc 135 strides")
  assert(close(r:tolist(),{0,3,9}),"acc 135 values")
end
do -- accumulate 136: add bool [2, 1, 1, 3] axis=1
  local a=np.array({{{{true,true,false}}},{{{true,true,false}}}},np.bool)
  local r=np.add_accumulate(a,{axis=2})
  assert(r.dtype=="int64","acc 136 dtype "..r.dtype)
  assert(close(r.shape,{2,1,1,3}),"acc 136 shape")
  assert(close(r.strides,{24,24,24,8}),"acc 136 strides")
  assert(close(r:tolist(),{{{{1,1,0}}},{{{1,1,0}}}}),"acc 136 values")
end
do -- accumulate 137: multiply uint32 [0, 3, 1] axis=1
  local a=np.zeros({0,3,1},np.uint32)
  local r=np.multiply_accumulate(a,{axis=2,dtype=np.int16})
  assert(r.dtype=="int16","acc 137 dtype "..r.dtype)
  assert(close(r.shape,{0,3,1}),"acc 137 shape")
  assert(close(r.strides,{0,0,0}),"acc 137 strides")
  assert(close(r:tolist(),{}),"acc 137 values")
end
do -- accumulate 138: multiply float32 [0, 2, 1] axis=2
  local a=np.zeros({0,2,1},np.float32)
  local r=np.multiply_accumulate(a,{axis=3})
  assert(r.dtype=="float32","acc 138 dtype "..r.dtype)
  assert(close(r.shape,{0,2,1}),"acc 138 shape")
  assert(close(r.strides,{0,0,0}),"acc 138 strides")
  assert(close(r:tolist(),{}),"acc 138 values")
end
do -- accumulate 139: add float16 [4, 3, 1] axis=0
  local a=np.array({{{1.2000000000000002},{-1.2000000000000002},{-0.8}},{{-0.4},{0.0},{0.4}},{{0.8},{1.2000000000000002},{-1.2000000000000002}},{{-0.8},{-0.4},{0.0}}},np.float16)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="float16","acc 139 dtype "..r.dtype)
  assert(close(r.shape,{4,3,1}),"acc 139 shape")
  assert(close(r.strides,{6,2,2}),"acc 139 strides")
  assert(close(r:tolist(),{{{1.2001953125},{-1.2001953125},{-0.7998046875}},{{0.80029296875},{-1.2001953125},{-0.39990234375}},{{1.599609375},{0.0},{-1.599609375}},{{0.7998046875},{-0.39990234375},{-1.599609375}}}),"acc 139 values")
end
do -- accumulate 140: multiply uint32 [2, 2, 0] axis=2
  local a=np.zeros({2,2,0},np.uint32)
  local r=np.multiply_accumulate(a,{axis=3,dtype=np.int32})
  assert(r.dtype=="int32","acc 140 dtype "..r.dtype)
  assert(close(r.shape,{2,2,0}),"acc 140 shape")
  assert(close(r.strides,{0,0,0}),"acc 140 strides")
  assert(close(r:tolist(),{{{},{}},{{},{}}}),"acc 140 values")
end
do -- accumulate 141: add uint8 [1] axis=0
  local a=np.array({6},np.uint8)
  local o=np.zeros({1},np.float16)
  local r=np.add_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 141 out identity")
  assert(r.dtype=="float16","acc 141 dtype "..r.dtype)
  assert(close(r.shape,{1}),"acc 141 shape")
  assert(close(r.strides,{2}),"acc 141 strides")
  assert(close(r:tolist(),{6.0}),"acc 141 values")
end
do -- accumulate 142: multiply uint16 [4] axis=0
  local a=np.array({3,4,1,2},np.uint16)
  local o=np.zeros({4},np.int64)
  local r=np.multiply_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 142 out identity")
  assert(r.dtype=="int64","acc 142 dtype "..r.dtype)
  assert(close(r.shape,{4}),"acc 142 shape")
  assert(close(r.strides,{8}),"acc 142 strides")
  assert(close(r:tolist(),{3,12,12,24}),"acc 142 values")
end
do -- accumulate 143: multiply float32 [2, 3, 2, 0] axis=0
  local a=np.zeros({2,3,2,0},np.float32)
  local o=np.zeros({2,3,2,0},np.int64)
  local r=np.multiply_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 143 out identity")
  assert(r.dtype=="int64","acc 143 dtype "..r.dtype)
  assert(close(r.shape,{2,3,2,0}),"acc 143 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 143 strides")
  assert(close(r:tolist(),{{{{},{}},{{},{}},{{},{}}},{{{},{}},{{},{}},{{},{}}}}),"acc 143 values")
end
do -- accumulate 144: add float32 [2, 3] axis=0
  local a=np.array({{0.4,0.8,1.2000000000000002},{-1.2000000000000002,-0.8,-0.4}},np.float32)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="float32","acc 144 dtype "..r.dtype)
  assert(close(r.shape,{2,3}),"acc 144 shape")
  assert(close(r.strides,{12,4}),"acc 144 strides")
  assert(close(r:tolist(),{{0.4000000059604645,0.800000011920929,1.2000000476837158},{-0.8000000715255737,0.0,0.8000000715255737}}),"acc 144 values")
end
do -- accumulate 145: add float32 [0, 4] axis=1
  local a=np.zeros({0,4},np.float32)
  local r=np.add_accumulate(a,{axis=2,dtype=np.int8})
  assert(r.dtype=="int8","acc 145 dtype "..r.dtype)
  assert(close(r.shape,{0,4}),"acc 145 shape")
  assert(close(r.strides,{0,0}),"acc 145 strides")
  assert(close(r:tolist(),{}),"acc 145 values")
end
do -- accumulate 146: add uint64 [3, 4, 3, 1] axis=2
  local a=np.array({{{{2},{5},{8}},{{2},{5},{8}},{{2},{5},{8}},{{2},{5},{8}}},{{{2},{5},{8}},{{2},{5},{8}},{{2},{5},{8}},{{2},{5},{8}}},{{{2},{5},{8}},{{2},{5},{8}},{{2},{5},{8}},{{2},{5},{8}}}},np.uint64)
  local r=np.add_accumulate(a,{axis=3})
  assert(r.dtype=="uint64","acc 146 dtype "..r.dtype)
  assert(close(r.shape,{3,4,3,1}),"acc 146 shape")
  assert(close(r.strides,{96,24,8,8}),"acc 146 strides")
  assert(close(r:tolist(),{{{{2},{7},{15}},{{2},{7},{15}},{{2},{7},{15}},{{2},{7},{15}}},{{{2},{7},{15}},{{2},{7},{15}},{{2},{7},{15}},{{2},{7},{15}}},{{{2},{7},{15}},{{2},{7},{15}},{{2},{7},{15}},{{2},{7},{15}}}}),"acc 146 values")
end
do -- accumulate 147: multiply uint32 [3, 3] axis=0
  local a=np.array({{4,1,2},{3,4,1},{2,3,4}},np.uint32)
  local r=np.multiply_accumulate(a,{axis=1,dtype=np.uint16})
  assert(r.dtype=="uint16","acc 147 dtype "..r.dtype)
  assert(close(r.shape,{3,3}),"acc 147 shape")
  assert(close(r.strides,{6,2}),"acc 147 strides")
  assert(close(r:tolist(),{{4,1,2},{12,4,2},{24,12,8}}),"acc 147 values")
end
do -- accumulate 148: multiply int32 [2, 3, 4, 1] axis=3
  local a=np.array({{{{1},{2},{-2},{-1}},{{0},{1},{2},{-2}},{{-1},{0},{1},{2}}},{{{-2},{-1},{0},{1}},{{2},{-2},{-1},{0}},{{1},{2},{-2},{-1}}}},np.int32)
  local r=np.multiply_accumulate(a,{axis=4})
  assert(r.dtype=="int64","acc 148 dtype "..r.dtype)
  assert(close(r.shape,{2,3,4,1}),"acc 148 shape")
  assert(close(r.strides,{96,32,8,8}),"acc 148 strides")
  assert(close(r:tolist(),{{{{1},{2},{-2},{-1}},{{0},{1},{2},{-2}},{{-1},{0},{1},{2}}},{{{-2},{-1},{0},{1}},{{2},{-2},{-1},{0}},{{1},{2},{-2},{-1}}}}),"acc 148 values")
end
do -- accumulate 149: add uint32 [3, 2, 2] axis=2
  local a=np.array({{{5,8},{2,5}},{{8,2},{5,8}},{{2,5},{8,2}}},np.uint32)
  local r=np.add_accumulate(a,{axis=3,dtype=np.uint32})
  assert(r.dtype=="uint32","acc 149 dtype "..r.dtype)
  assert(close(r.shape,{3,2,2}),"acc 149 shape")
  assert(close(r.strides,{16,8,4}),"acc 149 strides")
  assert(close(r:tolist(),{{{5,13},{2,7}},{{8,10},{5,13}},{{2,7},{8,10}}}),"acc 149 values")
end
do -- accumulate 150: add float64 [2, 4] axis=1
  local a=np.array({{0.0,0.4,0.8,1.2000000000000002},{-1.2000000000000002,-0.8,-0.4,0.0}},np.float64)
  local o=np.zeros({2,4},np.int8)
  local r=np.add_accumulate(a,{axis=2,dtype=np.int64,out=o})
  assert(r==o,"acc 150 out identity")
  assert(r.dtype=="int8","acc 150 dtype "..r.dtype)
  assert(close(r.shape,{2,4}),"acc 150 shape")
  assert(close(r.strides,{4,1}),"acc 150 strides")
  assert(close(r:tolist(),{{0,0,0,1},{-1,-1,-1,-1}}),"acc 150 values")
end
do -- accumulate 151: add uint32 [3, 3, 1, 0] axis=3
  local a=np.zeros({3,3,1,0},np.uint32)
  local r=np.add_accumulate(a,{axis=4})
  assert(r.dtype=="uint64","acc 151 dtype "..r.dtype)
  assert(close(r.shape,{3,3,1,0}),"acc 151 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 151 strides")
  assert(close(r:tolist(),{{{{}},{{}},{{}}},{{{}},{{}},{{}}},{{{}},{{}},{{}}}}),"acc 151 values")
end
do -- accumulate 152: multiply float64 [0, 0, 3, 3] axis=3
  local a=np.zeros({0,0,3,3},np.float64)
  local r=np.multiply_accumulate(a,{axis=4})
  assert(r.dtype=="float64","acc 152 dtype "..r.dtype)
  assert(close(r.shape,{0,0,3,3}),"acc 152 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 152 strides")
  assert(close(r:tolist(),{}),"acc 152 values")
end
do -- accumulate 153: add uint8 [2] axis=0
  local a=np.array({0,3},np.uint8)
  local o=np.zeros({2},np.float32)
  local r=np.add_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 153 out identity")
  assert(r.dtype=="float32","acc 153 dtype "..r.dtype)
  assert(close(r.shape,{2}),"acc 153 shape")
  assert(close(r.strides,{4}),"acc 153 strides")
  assert(close(r:tolist(),{0.0,3.0}),"acc 153 values")
end
do -- accumulate 154: add uint8 [2, 4, 0] axis=2
  local a=np.zeros({2,4,0},np.uint8)
  local r=np.add_accumulate(a,{axis=3,dtype=np.uint32})
  assert(r.dtype=="uint32","acc 154 dtype "..r.dtype)
  assert(close(r.shape,{2,4,0}),"acc 154 shape")
  assert(close(r.strides,{0,0,0}),"acc 154 strides")
  assert(close(r:tolist(),{{{},{},{},{}},{{},{},{},{}}}),"acc 154 values")
end
do -- accumulate 155: multiply float32 [0] axis=0
  local a=np.zeros({0},np.float32)
  local r=np.multiply_accumulate(a,{axis=1,dtype=np.int8})
  assert(r.dtype=="int8","acc 155 dtype "..r.dtype)
  assert(close(r.shape,{0}),"acc 155 shape")
  assert(close(r.strides,{0}),"acc 155 strides")
  assert(close(r:tolist(),{}),"acc 155 values")
end
do -- accumulate 156: multiply float16 [0, 3] axis=0
  local a=np.zeros({0,3},np.float16)
  local o=np.zeros({0,3},np.int16)
  local r=np.multiply_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 156 out identity")
  assert(r.dtype=="int16","acc 156 dtype "..r.dtype)
  assert(close(r.shape,{0,3}),"acc 156 shape")
  assert(close(r.strides,{0,0}),"acc 156 strides")
  assert(close(r:tolist(),{}),"acc 156 values")
end
do -- accumulate 157: multiply int64 [2, 1, 3, 3] axis=0
  local a=np.array({{{{0,1,2},{-2,-1,0},{1,2,-2}}},{{{-1,0,1},{2,-2,-1},{0,1,2}}}},np.int64)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="int64","acc 157 dtype "..r.dtype)
  assert(close(r.shape,{2,1,3,3}),"acc 157 shape")
  assert(close(r.strides,{72,72,24,8}),"acc 157 strides")
  assert(close(r:tolist(),{{{{0,1,2},{-2,-1,0},{1,2,-2}}},{{{0,0,2},{-4,2,0},{0,2,-4}}}}),"acc 157 values")
end
do -- accumulate 158: add int64 [1] axis=0
  local a=np.array({-1},np.int64)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="int64","acc 158 dtype "..r.dtype)
  assert(close(r.shape,{1}),"acc 158 shape")
  assert(close(r.strides,{8}),"acc 158 strides")
  assert(close(r:tolist(),{-1}),"acc 158 values")
end
do -- accumulate 159: multiply float64 [0] axis=0
  local a=np.zeros({0},np.float64)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="float64","acc 159 dtype "..r.dtype)
  assert(close(r.shape,{0}),"acc 159 shape")
  assert(close(r.strides,{0}),"acc 159 strides")
  assert(close(r:tolist(),{}),"acc 159 values")
end
do -- accumulate 160: multiply int8 [1] axis=0
  local a=np.array({-2},np.int8)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="int64","acc 160 dtype "..r.dtype)
  assert(close(r.shape,{1}),"acc 160 shape")
  assert(close(r.strides,{8}),"acc 160 strides")
  assert(close(r:tolist(),{-2}),"acc 160 values")
end
do -- accumulate 161: add float32 [3, 0, 0, 0] axis=2
  local a=np.zeros({3,0,0,0},np.float32)
  local r=np.add_accumulate(a,{axis=3,dtype=np.int64})
  assert(r.dtype=="int64","acc 161 dtype "..r.dtype)
  assert(close(r.shape,{3,0,0,0}),"acc 161 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 161 strides")
  assert(close(r:tolist(),{{},{},{}}),"acc 161 values")
end
do -- accumulate 162: add bool [1, 4, 4] axis=1
  local a=np.array({{{false,true,true,false},{true,true,false,true},{true,false,true,true},{false,true,true,false}}},np.bool)
  local r=np.add_accumulate(a,{axis=2})
  assert(r.dtype=="int64","acc 162 dtype "..r.dtype)
  assert(close(r.shape,{1,4,4}),"acc 162 shape")
  assert(close(r.strides,{128,32,8}),"acc 162 strides")
  assert(close(r:tolist(),{{{0,1,1,0},{1,2,1,1},{2,2,2,2},{2,3,3,2}}}),"acc 162 values")
end
do -- accumulate 163: multiply uint64 [0, 1] axis=0
  local a=np.zeros({0,1},np.uint64)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 163 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"acc 163 shape")
  assert(close(r.strides,{0,0}),"acc 163 strides")
  assert(close(r:tolist(),{}),"acc 163 values")
end
do -- accumulate 164: add int32 [0, 3, 4] axis=1
  local a=np.zeros({0,3,4},np.int32)
  local r=np.add_accumulate(a,{axis=2})
  assert(r.dtype=="int64","acc 164 dtype "..r.dtype)
  assert(close(r.shape,{0,3,4}),"acc 164 shape")
  assert(close(r.strides,{0,0,0}),"acc 164 strides")
  assert(close(r:tolist(),{}),"acc 164 values")
end
do -- accumulate 165: multiply int16 [2, 0, 1, 4] axis=2
  local a=np.zeros({2,0,1,4},np.int16)
  local r=np.multiply_accumulate(a,{axis=3,dtype=np.uint32})
  assert(r.dtype=="uint32","acc 165 dtype "..r.dtype)
  assert(close(r.shape,{2,0,1,4}),"acc 165 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 165 strides")
  assert(close(r:tolist(),{{},{}}),"acc 165 values")
end
do -- accumulate 166: multiply int64 [2, 3, 1, 1] axis=0
  local a=np.array({{{{-1}},{{0}},{{1}}},{{{2}},{{-2}},{{-1}}}},np.int64)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="int64","acc 166 dtype "..r.dtype)
  assert(close(r.shape,{2,3,1,1}),"acc 166 shape")
  assert(close(r.strides,{24,8,8,8}),"acc 166 strides")
  assert(close(r:tolist(),{{{{-1}},{{0}},{{1}}},{{{-2}},{{0}},{{-1}}}}),"acc 166 values")
end
do -- accumulate 167: multiply uint16 [3, 2] axis=1
  local a=np.array({{4,1},{2,3},{4,1}},np.uint16)
  local o=np.zeros({3,2},np.bool)
  local r=np.multiply_accumulate(a,{axis=2,out=o})
  assert(r==o,"acc 167 out identity")
  assert(r.dtype=="bool","acc 167 dtype "..r.dtype)
  assert(close(r.shape,{3,2}),"acc 167 shape")
  assert(close(r.strides,{2,1}),"acc 167 strides")
  assert(close(r:tolist(),{{true,true},{true,true},{true,true}}),"acc 167 values")
end
do -- accumulate 168: multiply uint32 [0, 2] axis=0
  local a=np.zeros({0,2},np.uint32)
  local o=np.zeros({0,2},np.uint8)
  local r=np.multiply_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 168 out identity")
  assert(r.dtype=="uint8","acc 168 dtype "..r.dtype)
  assert(close(r.shape,{0,2}),"acc 168 shape")
  assert(close(r.strides,{0,0}),"acc 168 strides")
  assert(close(r:tolist(),{}),"acc 168 values")
end
do -- accumulate 169: add uint32 [1, 4] axis=0
  local a=np.array({{7,1,4,7}},np.uint32)
  local r=np.add_accumulate(a,{axis=1,dtype=np.bool})
  assert(r.dtype=="bool","acc 169 dtype "..r.dtype)
  assert(close(r.shape,{1,4}),"acc 169 shape")
  assert(close(r.strides,{4,1}),"acc 169 strides")
  assert(close(r:tolist(),{{true,true,true,true}}),"acc 169 values")
end
do -- accumulate 170: multiply bool [2, 4, 1] axis=0
  local a=np.array({{{true},{false},{true},{true}},{{false},{true},{true},{false}}},np.bool)
  local r=np.multiply_accumulate(a,{axis=1,dtype=np.int16})
  assert(r.dtype=="int16","acc 170 dtype "..r.dtype)
  assert(close(r.shape,{2,4,1}),"acc 170 shape")
  assert(close(r.strides,{8,2,2}),"acc 170 strides")
  assert(close(r:tolist(),{{{1},{0},{1},{1}},{{0},{0},{1},{0}}}),"acc 170 values")
end
do -- accumulate 171: add uint64 [0, 1] axis=1
  local a=np.zeros({0,1},np.uint64)
  local o=np.zeros({0,1},np.bool)
  local r=np.add_accumulate(a,{axis=2,out=o})
  assert(r==o,"acc 171 out identity")
  assert(r.dtype=="bool","acc 171 dtype "..r.dtype)
  assert(close(r.shape,{0,1}),"acc 171 shape")
  assert(close(r.strides,{0,0}),"acc 171 strides")
  assert(close(r:tolist(),{}),"acc 171 values")
end
do -- accumulate 172: add uint16 [0, 1, 3] axis=2
  local a=np.zeros({0,1,3},np.uint16)
  local o=np.zeros({0,1,3},np.uint32)
  local r=np.add_accumulate(a,{axis=3,out=o})
  assert(r==o,"acc 172 out identity")
  assert(r.dtype=="uint32","acc 172 dtype "..r.dtype)
  assert(close(r.shape,{0,1,3}),"acc 172 shape")
  assert(close(r.strides,{0,0,0}),"acc 172 strides")
  assert(close(r:tolist(),{}),"acc 172 values")
end
do -- accumulate 173: multiply uint32 [4] axis=0
  local a=np.array({2,3,4,1},np.uint32)
  local o=np.zeros({4},np.int64)
  local r=np.multiply_accumulate(a,{axis=1,dtype=np.uint64,out=o})
  assert(r==o,"acc 173 out identity")
  assert(r.dtype=="int64","acc 173 dtype "..r.dtype)
  assert(close(r.shape,{4}),"acc 173 shape")
  assert(close(r.strides,{8}),"acc 173 strides")
  assert(close(r:tolist(),{2,6,24,24}),"acc 173 values")
end
do -- accumulate 174: add uint32 [3, 1, 3] axis=0
  local a=np.array({{{3,6,0}},{{3,6,0}},{{3,6,0}}},np.uint32)
  local o=np.zeros({3,1,3},np.int64)
  local r=np.add_accumulate(a,{axis=1,dtype=np.float64,out=o})
  assert(r==o,"acc 174 out identity")
  assert(r.dtype=="int64","acc 174 dtype "..r.dtype)
  assert(close(r.shape,{3,1,3}),"acc 174 shape")
  assert(close(r.strides,{24,24,8}),"acc 174 strides")
  assert(close(r:tolist(),{{{3,6,0}},{{6,12,0}},{{9,18,0}}}),"acc 174 values")
end
do -- accumulate 175: add int8 [0] axis=0
  local a=np.zeros({0},np.int8)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="int64","acc 175 dtype "..r.dtype)
  assert(close(r.shape,{0}),"acc 175 shape")
  assert(close(r.strides,{0}),"acc 175 strides")
  assert(close(r:tolist(),{}),"acc 175 values")
end
do -- accumulate 176: multiply float32 [4, 0, 3] axis=2
  local a=np.zeros({4,0,3},np.float32)
  local o=np.zeros({4,0,3},np.float16)
  local r=np.multiply_accumulate(a,{axis=3,out=o})
  assert(r==o,"acc 176 out identity")
  assert(r.dtype=="float16","acc 176 dtype "..r.dtype)
  assert(close(r.shape,{4,0,3}),"acc 176 shape")
  assert(close(r.strides,{0,0,0}),"acc 176 strides")
  assert(close(r:tolist(),{{},{},{},{}}),"acc 176 values")
end
do -- accumulate 177: add int16 [2, 1, 4] axis=2
  local a=np.array({{{-4,-1,2,5}},{{-3,0,3,-5}}},np.int16)
  local r=np.add_accumulate(a,{axis=3})
  assert(r.dtype=="int64","acc 177 dtype "..r.dtype)
  assert(close(r.shape,{2,1,4}),"acc 177 shape")
  assert(close(r.strides,{32,32,8}),"acc 177 strides")
  assert(close(r:tolist(),{{{-4,-5,-3,2}},{{-3,-3,0,-5}}}),"acc 177 values")
end
do -- accumulate 178: multiply int64 [2, 4, 1] axis=1
  local a=np.array({{{1},{2},{-2},{-1}},{{0},{1},{2},{-2}}},np.int64)
  local r=np.multiply_accumulate(a,{axis=2,dtype=np.float64})
  assert(r.dtype=="float64","acc 178 dtype "..r.dtype)
  assert(close(r.shape,{2,4,1}),"acc 178 shape")
  assert(close(r.strides,{32,8,8}),"acc 178 strides")
  assert(close(r:tolist(),{{{1.0},{2.0},{-4.0},{4.0}},{{0.0},{0.0},{0.0},{-0.0}}}),"acc 178 values")
end
do -- accumulate 179: add uint32 [2] axis=0
  local a=np.array({8,2},np.uint32)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 179 dtype "..r.dtype)
  assert(close(r.shape,{2}),"acc 179 shape")
  assert(close(r.strides,{8}),"acc 179 strides")
  assert(close(r:tolist(),{8,10}),"acc 179 values")
end
do -- accumulate 180: add uint32 [1, 1, 1, 3] axis=0
  local a=np.array({{{{0,3,6}}}},np.uint32)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 180 dtype "..r.dtype)
  assert(close(r.shape,{1,1,1,3}),"acc 180 shape")
  assert(close(r.strides,{24,24,24,8}),"acc 180 strides")
  assert(close(r:tolist(),{{{{0,3,6}}}}),"acc 180 values")
end
do -- accumulate 181: add float16 [2, 0, 3, 3] axis=3
  local a=np.zeros({2,0,3,3},np.float16)
  local r=np.add_accumulate(a,{axis=4})
  assert(r.dtype=="float16","acc 181 dtype "..r.dtype)
  assert(close(r.shape,{2,0,3,3}),"acc 181 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 181 strides")
  assert(close(r:tolist(),{{},{}}),"acc 181 values")
end
do -- accumulate 182: add uint32 [3, 4, 3] axis=2
  local a=np.array({{{2,5,8},{2,5,8},{2,5,8},{2,5,8}},{{2,5,8},{2,5,8},{2,5,8},{2,5,8}},{{2,5,8},{2,5,8},{2,5,8},{2,5,8}}},np.uint32)
  local r=np.add_accumulate(a,{axis=3})
  assert(r.dtype=="uint64","acc 182 dtype "..r.dtype)
  assert(close(r.shape,{3,4,3}),"acc 182 shape")
  assert(close(r.strides,{96,24,8}),"acc 182 strides")
  assert(close(r:tolist(),{{{2,7,15},{2,7,15},{2,7,15},{2,7,15}},{{2,7,15},{2,7,15},{2,7,15},{2,7,15}},{{2,7,15},{2,7,15},{2,7,15},{2,7,15}}}),"acc 182 values")
end
do -- accumulate 183: multiply uint16 [2, 2, 4, 4] axis=0
  local a=np.array({{{{4,1,2,3},{4,1,2,3},{4,1,2,3},{4,1,2,3}},{{4,1,2,3},{4,1,2,3},{4,1,2,3},{4,1,2,3}}},{{{4,1,2,3},{4,1,2,3},{4,1,2,3},{4,1,2,3}},{{4,1,2,3},{4,1,2,3},{4,1,2,3},{4,1,2,3}}}},np.uint16)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 183 dtype "..r.dtype)
  assert(close(r.shape,{2,2,4,4}),"acc 183 shape")
  assert(close(r.strides,{256,128,32,8}),"acc 183 strides")
  assert(close(r:tolist(),{{{{4,1,2,3},{4,1,2,3},{4,1,2,3},{4,1,2,3}},{{4,1,2,3},{4,1,2,3},{4,1,2,3},{4,1,2,3}}},{{{16,1,4,9},{16,1,4,9},{16,1,4,9},{16,1,4,9}},{{16,1,4,9},{16,1,4,9},{16,1,4,9},{16,1,4,9}}}}),"acc 183 values")
end
do -- accumulate 184: multiply uint16 [1] axis=0
  local a=np.array({1},np.uint16)
  local o=np.zeros({1},np.int8)
  local r=np.multiply_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 184 out identity")
  assert(r.dtype=="int8","acc 184 dtype "..r.dtype)
  assert(close(r.shape,{1}),"acc 184 shape")
  assert(close(r.strides,{1}),"acc 184 strides")
  assert(close(r:tolist(),{1}),"acc 184 values")
end
do -- accumulate 185: multiply uint64 [0, 2, 4] axis=2
  local a=np.zeros({0,2,4},np.uint64)
  local o=np.zeros({0,2,4},np.float64)
  local r=np.multiply_accumulate(a,{axis=3,dtype=np.int64,out=o})
  assert(r==o,"acc 185 out identity")
  assert(r.dtype=="float64","acc 185 dtype "..r.dtype)
  assert(close(r.shape,{0,2,4}),"acc 185 shape")
  assert(close(r.strides,{0,0,0}),"acc 185 strides")
  assert(close(r:tolist(),{}),"acc 185 values")
end
do -- accumulate 186: multiply uint16 [4] axis=0
  local a=np.array({3,4,1,2},np.uint16)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 186 dtype "..r.dtype)
  assert(close(r.shape,{4}),"acc 186 shape")
  assert(close(r.strides,{8}),"acc 186 strides")
  assert(close(r:tolist(),{3,12,12,24}),"acc 186 values")
end
do -- accumulate 187: add uint32 [3] axis=0
  local a=np.array({7,1,4},np.uint32)
  local o=np.zeros({3},np.int8)
  local r=np.add_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 187 out identity")
  assert(r.dtype=="int8","acc 187 dtype "..r.dtype)
  assert(close(r.shape,{3}),"acc 187 shape")
  assert(close(r.strides,{1}),"acc 187 strides")
  assert(close(r:tolist(),{7,8,12}),"acc 187 values")
end
do -- accumulate 188: multiply uint16 [4, 3, 3, 0] axis=1
  local a=np.zeros({4,3,3,0},np.uint16)
  local o=np.zeros({4,3,3,0},np.int64)
  local r=np.multiply_accumulate(a,{axis=2,out=o})
  assert(r==o,"acc 188 out identity")
  assert(r.dtype=="int64","acc 188 dtype "..r.dtype)
  assert(close(r.shape,{4,3,3,0}),"acc 188 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 188 strides")
  assert(close(r:tolist(),{{{{},{},{}},{{},{},{}},{{},{},{}}},{{{},{},{}},{{},{},{}},{{},{},{}}},{{{},{},{}},{{},{},{}},{{},{},{}}},{{{},{},{}},{{},{},{}},{{},{},{}}}}),"acc 188 values")
end
do -- accumulate 189: multiply bool [3, 2, 2] axis=2
  local a=np.array({{{false,true},{true,false}},{{true,true},{false,true}},{{true,false},{true,true}}},np.bool)
  local r=np.multiply_accumulate(a,{axis=3})
  assert(r.dtype=="int64","acc 189 dtype "..r.dtype)
  assert(close(r.shape,{3,2,2}),"acc 189 shape")
  assert(close(r.strides,{32,16,8}),"acc 189 strides")
  assert(close(r:tolist(),{{{0,0},{1,0}},{{1,1},{0,0}},{{1,0},{1,1}}}),"acc 189 values")
end
do -- accumulate 190: add uint32 [4] axis=0
  local a=np.array({1,4,7,1},np.uint32)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 190 dtype "..r.dtype)
  assert(close(r.shape,{4}),"acc 190 shape")
  assert(close(r.strides,{8}),"acc 190 strides")
  assert(close(r:tolist(),{1,5,12,13}),"acc 190 values")
end
do -- accumulate 191: multiply uint64 [2, 0, 4] axis=1
  local a=np.zeros({2,0,4},np.uint64)
  local r=np.multiply_accumulate(a,{axis=2})
  assert(r.dtype=="uint64","acc 191 dtype "..r.dtype)
  assert(close(r.shape,{2,0,4}),"acc 191 shape")
  assert(close(r.strides,{0,0,0}),"acc 191 strides")
  assert(close(r:tolist(),{{},{}}),"acc 191 values")
end
do -- accumulate 192: add int16 [3, 4] axis=1
  local a=np.array({{0,3,-5,-2},{1,4,-4,-1},{2,5,-3,0}},np.int16)
  local r=np.add_accumulate(a,{axis=2,dtype=np.int8})
  assert(r.dtype=="int8","acc 192 dtype "..r.dtype)
  assert(close(r.shape,{3,4}),"acc 192 shape")
  assert(close(r.strides,{4,1}),"acc 192 strides")
  assert(close(r:tolist(),{{0,3,-2,-4},{1,5,1,0},{2,7,4,4}}),"acc 192 values")
end
do -- accumulate 193: multiply uint8 [2] axis=0
  local a=np.array({2,3},np.uint8)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 193 dtype "..r.dtype)
  assert(close(r.shape,{2}),"acc 193 shape")
  assert(close(r.strides,{8}),"acc 193 strides")
  assert(close(r:tolist(),{2,6}),"acc 193 values")
end
do -- accumulate 194: multiply uint16 [4, 4, 1] axis=0
  local a=np.array({{{3},{4},{1},{2}},{{3},{4},{1},{2}},{{3},{4},{1},{2}},{{3},{4},{1},{2}}},np.uint16)
  local o=np.zeros({4,4,1},np.uint16)
  local r=np.multiply_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 194 out identity")
  assert(r.dtype=="uint16","acc 194 dtype "..r.dtype)
  assert(close(r.shape,{4,4,1}),"acc 194 shape")
  assert(close(r.strides,{8,2,2}),"acc 194 strides")
  assert(close(r:tolist(),{{{3},{4},{1},{2}},{{9},{16},{1},{4}},{{27},{64},{1},{8}},{{81},{256},{1},{16}}}),"acc 194 values")
end
do -- accumulate 195: add int8 [3] axis=0
  local a=np.array({3,-5,-2},np.int8)
  local o=np.zeros({3},np.int32)
  local r=np.add_accumulate(a,{axis=1,dtype=np.int8,out=o})
  assert(r==o,"acc 195 out identity")
  assert(r.dtype=="int32","acc 195 dtype "..r.dtype)
  assert(close(r.shape,{3}),"acc 195 shape")
  assert(close(r.strides,{4}),"acc 195 strides")
  assert(close(r:tolist(),{3,-2,-4}),"acc 195 values")
end
do -- accumulate 196: add bool [0] axis=0
  local a=np.zeros({0},np.bool)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="int64","acc 196 dtype "..r.dtype)
  assert(close(r.shape,{0}),"acc 196 shape")
  assert(close(r.strides,{0}),"acc 196 strides")
  assert(close(r:tolist(),{}),"acc 196 values")
end
do -- accumulate 197: add int8 [0, 2, 1, 3] axis=1
  local a=np.zeros({0,2,1,3},np.int8)
  local r=np.add_accumulate(a,{axis=2})
  assert(r.dtype=="int64","acc 197 dtype "..r.dtype)
  assert(close(r.shape,{0,2,1,3}),"acc 197 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 197 strides")
  assert(close(r:tolist(),{}),"acc 197 values")
end
do -- accumulate 198: multiply uint16 [1, 1] axis=0
  local a=np.array({{3}},np.uint16)
  local r=np.multiply_accumulate(a,{axis=1,dtype=np.uint16})
  assert(r.dtype=="uint16","acc 198 dtype "..r.dtype)
  assert(close(r.shape,{1,1}),"acc 198 shape")
  assert(close(r.strides,{2,2}),"acc 198 strides")
  assert(close(r:tolist(),{{3}}),"acc 198 values")
end
do -- accumulate 199: add int32 [0, 2, 2, 4] axis=1
  local a=np.zeros({0,2,2,4},np.int32)
  local r=np.add_accumulate(a,{axis=2})
  assert(r.dtype=="int64","acc 199 dtype "..r.dtype)
  assert(close(r.shape,{0,2,2,4}),"acc 199 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 199 strides")
  assert(close(r:tolist(),{}),"acc 199 values")
end
do -- accumulate 200: add float32 [1, 3, 0] axis=0
  local a=np.zeros({1,3,0},np.float32)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="float32","acc 200 dtype "..r.dtype)
  assert(close(r.shape,{1,3,0}),"acc 200 shape")
  assert(close(r.strides,{0,0,0}),"acc 200 strides")
  assert(close(r:tolist(),{{{},{},{}}}),"acc 200 values")
end
do -- accumulate 201: add float16 [3, 0] axis=0
  local a=np.zeros({3,0},np.float16)
  local o=np.zeros({3,0},np.int16)
  local r=np.add_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 201 out identity")
  assert(r.dtype=="int16","acc 201 dtype "..r.dtype)
  assert(close(r.shape,{3,0}),"acc 201 shape")
  assert(close(r.strides,{0,0}),"acc 201 strides")
  assert(close(r:tolist(),{{},{},{}}),"acc 201 values")
end
do -- accumulate 202: multiply uint16 [1, 3, 0] axis=2
  local a=np.zeros({1,3,0},np.uint16)
  local r=np.multiply_accumulate(a,{axis=3})
  assert(r.dtype=="uint64","acc 202 dtype "..r.dtype)
  assert(close(r.shape,{1,3,0}),"acc 202 shape")
  assert(close(r.strides,{0,0,0}),"acc 202 strides")
  assert(close(r:tolist(),{{{},{},{}}}),"acc 202 values")
end
do -- accumulate 203: add float16 [1, 2, 0] axis=0
  local a=np.zeros({1,2,0},np.float16)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="float16","acc 203 dtype "..r.dtype)
  assert(close(r.shape,{1,2,0}),"acc 203 shape")
  assert(close(r.strides,{0,0,0}),"acc 203 strides")
  assert(close(r:tolist(),{{{},{}}}),"acc 203 values")
end
do -- accumulate 204: add bool [4] axis=0
  local a=np.array({false,true,true,false},np.bool)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="int64","acc 204 dtype "..r.dtype)
  assert(close(r.shape,{4}),"acc 204 shape")
  assert(close(r.strides,{8}),"acc 204 strides")
  assert(close(r:tolist(),{0,1,2,2}),"acc 204 values")
end
do -- accumulate 205: add uint8 [2, 3] axis=1
  local a=np.array({{7,1,4},{7,1,4}},np.uint8)
  local r=np.add_accumulate(a,{axis=2})
  assert(r.dtype=="uint64","acc 205 dtype "..r.dtype)
  assert(close(r.shape,{2,3}),"acc 205 shape")
  assert(close(r.strides,{24,8}),"acc 205 strides")
  assert(close(r:tolist(),{{7,8,12},{7,8,12}}),"acc 205 values")
end
do -- accumulate 206: add uint8 [2, 1, 4] axis=0
  local a=np.array({{{8,2,5,8}},{{2,5,8,2}}},np.uint8)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 206 dtype "..r.dtype)
  assert(close(r.shape,{2,1,4}),"acc 206 shape")
  assert(close(r.strides,{32,32,8}),"acc 206 strides")
  assert(close(r:tolist(),{{{8,2,5,8}},{{10,7,13,10}}}),"acc 206 values")
end
do -- accumulate 207: add float64 [0, 1, 2] axis=0
  local a=np.zeros({0,1,2},np.float64)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="float64","acc 207 dtype "..r.dtype)
  assert(close(r.shape,{0,1,2}),"acc 207 shape")
  assert(close(r.strides,{0,0,0}),"acc 207 strides")
  assert(close(r:tolist(),{}),"acc 207 values")
end
do -- accumulate 208: multiply uint8 [2] axis=0
  local a=np.array({1,2},np.uint8)
  local o=np.zeros({2},np.uint8)
  local r=np.multiply_accumulate(a,{axis=1,dtype=np.uint32,out=o})
  assert(r==o,"acc 208 out identity")
  assert(r.dtype=="uint8","acc 208 dtype "..r.dtype)
  assert(close(r.shape,{2}),"acc 208 shape")
  assert(close(r.strides,{1}),"acc 208 strides")
  assert(close(r:tolist(),{1,2}),"acc 208 values")
end
do -- accumulate 209: multiply float32 [0, 2] axis=1
  local a=np.zeros({0,2},np.float32)
  local r=np.multiply_accumulate(a,{axis=2,dtype=np.uint8})
  assert(r.dtype=="uint8","acc 209 dtype "..r.dtype)
  assert(close(r.shape,{0,2}),"acc 209 shape")
  assert(close(r.strides,{0,0}),"acc 209 strides")
  assert(close(r:tolist(),{}),"acc 209 values")
end
do -- accumulate 210: add float32 [4, 4, 2, 2] axis=3
  local a=np.array({{{{-1.2000000000000002,-0.8},{-0.4,0.0}},{{0.4,0.8},{1.2000000000000002,-1.2000000000000002}},{{-0.8,-0.4},{0.0,0.4}},{{0.8,1.2000000000000002},{-1.2000000000000002,-0.8}}},{{{-0.4,0.0},{0.4,0.8}},{{1.2000000000000002,-1.2000000000000002},{-0.8,-0.4}},{{0.0,0.4},{0.8,1.2000000000000002}},{{-1.2000000000000002,-0.8},{-0.4,0.0}}},{{{0.4,0.8},{1.2000000000000002,-1.2000000000000002}},{{-0.8,-0.4},{0.0,0.4}},{{0.8,1.2000000000000002},{-1.2000000000000002,-0.8}},{{-0.4,0.0},{0.4,0.8}}},{{{1.2000000000000002,-1.2000000000000002},{-0.8,-0.4}},{{0.0,0.4},{0.8,1.2000000000000002}},{{-1.2000000000000002,-0.8},{-0.4,0.0}},{{0.4,0.8},{1.2000000000000002,-1.2000000000000002}}}},np.float32)
  local r=np.add_accumulate(a,{axis=4,dtype=np.float64})
  assert(r.dtype=="float64","acc 210 dtype "..r.dtype)
  assert(close(r.shape,{4,4,2,2}),"acc 210 shape")
  assert(close(r.strides,{128,32,16,8}),"acc 210 strides")
  assert(close(r:tolist(),{{{{-1.2000000476837158,-2.0000000596046448},{-0.4000000059604645,-0.4000000059604645}},{{0.4000000059604645,1.2000000178813934},{1.2000000476837158,0.0}},{{-0.800000011920929,-1.2000000178813934},{0.0,0.4000000059604645}},{{0.800000011920929,2.0000000596046448},{-1.2000000476837158,-2.0000000596046448}}},{{{-0.4000000059604645,-0.4000000059604645},{0.4000000059604645,1.2000000178813934}},{{1.2000000476837158,0.0},{-0.800000011920929,-1.2000000178813934}},{{0.0,0.4000000059604645},{0.800000011920929,2.0000000596046448}},{{-1.2000000476837158,-2.0000000596046448},{-0.4000000059604645,-0.4000000059604645}}},{{{0.4000000059604645,1.2000000178813934},{1.2000000476837158,0.0}},{{-0.800000011920929,-1.2000000178813934},{0.0,0.4000000059604645}},{{0.800000011920929,2.0000000596046448},{-1.2000000476837158,-2.0000000596046448}},{{-0.4000000059604645,-0.4000000059604645},{0.4000000059604645,1.2000000178813934}}},{{{1.2000000476837158,0.0},{-0.800000011920929,-1.2000000178813934}},{{0.0,0.4000000059604645},{0.800000011920929,2.0000000596046448}},{{-1.2000000476837158,-2.0000000596046448},{-0.4000000059604645,-0.4000000059604645}},{{0.4000000059604645,1.2000000178813934},{1.2000000476837158,0.0}}}}),"acc 210 values")
end
do -- accumulate 211: multiply int64 [2, 1, 1] axis=2
  local a=np.array({{{-1}},{{0}}},np.int64)
  local r=np.multiply_accumulate(a,{axis=3})
  assert(r.dtype=="int64","acc 211 dtype "..r.dtype)
  assert(close(r.shape,{2,1,1}),"acc 211 shape")
  assert(close(r.strides,{8,8,8}),"acc 211 strides")
  assert(close(r:tolist(),{{{-1}},{{0}}}),"acc 211 values")
end
do -- accumulate 212: multiply int64 [4, 2, 2] axis=1
  local a=(np.array({{{0,1,2,-2},{-1,0,1,2}},{{-2,-1,0,1},{2,-2,-1,0}}},np.int64)).T
  local r=np.multiply_accumulate(a,{axis=2})
  assert(r.dtype=="int64","acc 212 dtype "..r.dtype)
  assert(close(r.shape,{4,2,2}),"acc 212 shape")
  assert(close(r.strides,{8,32,64}),"acc 212 strides")
  assert(close(r:tolist(),{{{0,-2},{0,-4}},{{1,-1},{0,2}},{{2,0},{2,0}},{{-2,1},{-4,0}}}),"acc 212 values")
end
do -- accumulate 213: add int8 [3, 3] axis=0
  local a=np.array({{-1,2,5},{-3,0,3},{-5,-2,1}},np.int8)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="int64","acc 213 dtype "..r.dtype)
  assert(close(r.shape,{3,3}),"acc 213 shape")
  assert(close(r.strides,{24,8}),"acc 213 strides")
  assert(close(r:tolist(),{{-1,2,5},{-4,2,8},{-9,0,9}}),"acc 213 values")
end
do -- accumulate 214: multiply int32 [2, 4] axis=1
  local a=np.array({{2,-2,-1,0},{1,2,-2,-1}},np.int32)
  local r=np.multiply_accumulate(a,{axis=2})
  assert(r.dtype=="int64","acc 214 dtype "..r.dtype)
  assert(close(r.shape,{2,4}),"acc 214 shape")
  assert(close(r.strides,{32,8}),"acc 214 strides")
  assert(close(r:tolist(),{{2,-4,4,0},{1,2,-4,4}}),"acc 214 values")
end
do -- accumulate 215: multiply int16 [2] axis=0
  local a=np.array({-2,-1},np.int16)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="int64","acc 215 dtype "..r.dtype)
  assert(close(r.shape,{2}),"acc 215 shape")
  assert(close(r.strides,{8}),"acc 215 strides")
  assert(close(r:tolist(),{-2,2}),"acc 215 values")
end
do -- accumulate 216: add int16 [1, 4, 2, 1] axis=0
  local a=(np.array({{{{2},{5},{-3},{0}},{{3},{-5},{-2},{1}}}},np.int16)).T
  local o=np.zeros({1,4,2,1},np.float32)
  local r=np.add_accumulate(a,{axis=1,dtype=np.int16,out=o})
  assert(r==o,"acc 216 out identity")
  assert(r.dtype=="float32","acc 216 dtype "..r.dtype)
  assert(close(r.shape,{1,4,2,1}),"acc 216 shape")
  assert(close(r.strides,{32,8,4,4}),"acc 216 strides")
  assert(close(r:tolist(),{{{{2.0},{3.0}},{{5.0},{-5.0}},{{-3.0},{-2.0}},{{0.0},{1.0}}}}),"acc 216 values")
end
do -- accumulate 217: multiply int64 [2, 4] axis=0
  local a=np.array({{0,1,2,-2},{-1,0,1,2}},np.int64)
  local o=np.zeros({2,4},np.float16)
  local r=np.multiply_accumulate(a,{axis=1,dtype=np.int8,out=o})
  assert(r==o,"acc 217 out identity")
  assert(r.dtype=="float16","acc 217 dtype "..r.dtype)
  assert(close(r.shape,{2,4}),"acc 217 shape")
  assert(close(r.strides,{8,2}),"acc 217 strides")
  assert(close(r:tolist(),{{0.0,1.0,2.0,-2.0},{0.0,0.0,2.0,-4.0}}),"acc 217 values")
end
do -- accumulate 218: add uint16 [0, 1, 0] axis=0
  local a=np.zeros({0,1,0},np.uint16)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 218 dtype "..r.dtype)
  assert(close(r.shape,{0,1,0}),"acc 218 shape")
  assert(close(r.strides,{0,0,0}),"acc 218 strides")
  assert(close(r:tolist(),{}),"acc 218 values")
end
do -- accumulate 219: multiply uint16 [3, 1, 0] axis=2
  local a=np.zeros({3,1,0},np.uint16)
  local r=np.multiply_accumulate(a,{axis=3})
  assert(r.dtype=="uint64","acc 219 dtype "..r.dtype)
  assert(close(r.shape,{3,1,0}),"acc 219 shape")
  assert(close(r.strides,{0,0,0}),"acc 219 strides")
  assert(close(r:tolist(),{{{}},{{}},{{}}}),"acc 219 values")
end
do -- accumulate 220: multiply int16 [2, 2] axis=0
  local a=np.array({{-2,-1},{0,1}},np.int16)
  local o=np.zeros({2,2},np.uint8)
  local r=np.multiply_accumulate(a,{axis=1,dtype=np.float16,out=o})
  assert(r==o,"acc 220 out identity")
  assert(r.dtype=="uint8","acc 220 dtype "..r.dtype)
  assert(close(r.shape,{2,2}),"acc 220 shape")
  assert(close(r.strides,{2,1}),"acc 220 strides")
  assert(close(r:tolist(),{{254,255},{0,255}}),"acc 220 values")
end
do -- accumulate 221: add int32 [3, 0] axis=1
  local a=np.zeros({3,0},np.int32)
  local r=np.add_accumulate(a,{axis=2})
  assert(r.dtype=="int64","acc 221 dtype "..r.dtype)
  assert(close(r.shape,{3,0}),"acc 221 shape")
  assert(close(r.strides,{0,0}),"acc 221 strides")
  assert(close(r:tolist(),{{},{},{}}),"acc 221 values")
end
do -- accumulate 222: add float16 [3, 2, 0] axis=2
  local a=np.zeros({3,2,0},np.float16)
  local r=np.add_accumulate(a,{axis=3})
  assert(r.dtype=="float16","acc 222 dtype "..r.dtype)
  assert(close(r.shape,{3,2,0}),"acc 222 shape")
  assert(close(r.strides,{0,0,0}),"acc 222 strides")
  assert(close(r:tolist(),{{{},{}},{{},{}},{{},{}}}),"acc 222 values")
end
do -- accumulate 223: add float16 [4, 4, 0, 4] axis=0
  local a=np.zeros({4,4,0,4},np.float16)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="float16","acc 223 dtype "..r.dtype)
  assert(close(r.shape,{4,4,0,4}),"acc 223 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 223 strides")
  assert(close(r:tolist(),{{{},{},{},{}},{{},{},{},{}},{{},{},{},{}},{{},{},{},{}}}),"acc 223 values")
end
do -- accumulate 224: add float64 [0, 1, 2, 3] axis=0
  local a=np.zeros({0,1,2,3},np.float64)
  local r=np.add_accumulate(a,{axis=1,dtype=np.float64})
  assert(r.dtype=="float64","acc 224 dtype "..r.dtype)
  assert(close(r.shape,{0,1,2,3}),"acc 224 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 224 strides")
  assert(close(r:tolist(),{}),"acc 224 values")
end
do -- accumulate 225: multiply uint16 [1, 3, 3, 1] axis=2
  local a=np.array({{{{2},{3},{4}},{{1},{2},{3}},{{4},{1},{2}}}},np.uint16)
  local o=np.zeros({1,3,3,1},np.int32)
  local r=np.multiply_accumulate(a,{axis=3,out=o})
  assert(r==o,"acc 225 out identity")
  assert(r.dtype=="int32","acc 225 dtype "..r.dtype)
  assert(close(r.shape,{1,3,3,1}),"acc 225 shape")
  assert(close(r.strides,{36,12,4,4}),"acc 225 strides")
  assert(close(r:tolist(),{{{{2},{6},{24}},{{1},{2},{6}},{{4},{4},{8}}}}),"acc 225 values")
end
do -- accumulate 226: multiply uint32 [2, 3, 4, 4] axis=1
  local a=np.array({{{{3,4,1,2},{3,4,1,2},{3,4,1,2},{3,4,1,2}},{{3,4,1,2},{3,4,1,2},{3,4,1,2},{3,4,1,2}},{{3,4,1,2},{3,4,1,2},{3,4,1,2},{3,4,1,2}}},{{{3,4,1,2},{3,4,1,2},{3,4,1,2},{3,4,1,2}},{{3,4,1,2},{3,4,1,2},{3,4,1,2},{3,4,1,2}},{{3,4,1,2},{3,4,1,2},{3,4,1,2},{3,4,1,2}}}},np.uint32)
  local o=np.zeros({2,3,4,4},np.uint16)
  local r=np.multiply_accumulate(a,{axis=2,out=o})
  assert(r==o,"acc 226 out identity")
  assert(r.dtype=="uint16","acc 226 dtype "..r.dtype)
  assert(close(r.shape,{2,3,4,4}),"acc 226 shape")
  assert(close(r.strides,{96,32,8,2}),"acc 226 strides")
  assert(close(r:tolist(),{{{{3,4,1,2},{3,4,1,2},{3,4,1,2},{3,4,1,2}},{{9,16,1,4},{9,16,1,4},{9,16,1,4},{9,16,1,4}},{{27,64,1,8},{27,64,1,8},{27,64,1,8},{27,64,1,8}}},{{{3,4,1,2},{3,4,1,2},{3,4,1,2},{3,4,1,2}},{{9,16,1,4},{9,16,1,4},{9,16,1,4},{9,16,1,4}},{{27,64,1,8},{27,64,1,8},{27,64,1,8},{27,64,1,8}}}}),"acc 226 values")
end
do -- accumulate 227: multiply uint8 [4, 3] axis=0
  local a=np.array({{4,1,2},{3,4,1},{2,3,4},{1,2,3}},np.uint8)
  local o=np.zeros({4,3},np.uint8)
  local r=np.multiply_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 227 out identity")
  assert(r.dtype=="uint8","acc 227 dtype "..r.dtype)
  assert(close(r.shape,{4,3}),"acc 227 shape")
  assert(close(r.strides,{3,1}),"acc 227 strides")
  assert(close(r:tolist(),{{4,1,2},{12,4,2},{24,12,8},{24,24,24}}),"acc 227 values")
end
do -- accumulate 228: add uint16 [0, 4, 4, 2] axis=1
  local a=np.zeros({0,4,4,2},np.uint16)
  local r=np.add_accumulate(a,{axis=2})
  assert(r.dtype=="uint64","acc 228 dtype "..r.dtype)
  assert(close(r.shape,{0,4,4,2}),"acc 228 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 228 strides")
  assert(close(r:tolist(),{}),"acc 228 values")
end
do -- accumulate 229: multiply uint32 [2, 3] axis=0
  local a=(np.array({{2,3},{4,1},{2,3}},np.uint32)).T
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 229 dtype "..r.dtype)
  assert(close(r.shape,{2,3}),"acc 229 shape")
  assert(close(r.strides,{8,16}),"acc 229 strides")
  assert(close(r:tolist(),{{2,4,2},{6,4,6}}),"acc 229 values")
end
do -- accumulate 230: add float64 [3, 1, 2, 2] axis=3
  local a=(np.array({{{{1.2000000000000002,-1.2000000000000002,-0.8}},{{-0.4,0.0,0.4}}},{{{0.8,1.2000000000000002,-1.2000000000000002}},{{-0.8,-0.4,0.0}}}},np.float64)).T
  local r=np.add_accumulate(a,{axis=4,dtype=np.float16})
  assert(r.dtype=="float16","acc 230 dtype "..r.dtype)
  assert(close(r.shape,{3,1,2,2}),"acc 230 shape")
  assert(close(r.strides,{2,24,6,12}),"acc 230 strides")
  assert(close(r:tolist(),{{{{1.2001953125,2.0},{-0.39990234375,-1.19921875}}},{{{-1.2001953125,0.0},{0.0,-0.39990234375}}},{{{-0.7998046875,-2.0},{0.39990234375,0.39990234375}}}}),"acc 230 values")
end
do -- accumulate 231: add int32 [3] axis=0
  local a=np.array({-5,-2,1},np.int32)
  local o=np.zeros({3},np.float32)
  local r=np.add_accumulate(a,{axis=1,dtype=np.uint16,out=o})
  assert(r==o,"acc 231 out identity")
  assert(r.dtype=="float32","acc 231 dtype "..r.dtype)
  assert(close(r.shape,{3}),"acc 231 shape")
  assert(close(r.strides,{4}),"acc 231 strides")
  assert(close(r:tolist(),{65531.0,65529.0,65530.0}),"acc 231 values")
end
do -- accumulate 232: add uint64 [4, 4] axis=0
  local a=np.array({{7,1,4,7},{1,4,7,1},{4,7,1,4},{7,1,4,7}},np.uint64)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 232 dtype "..r.dtype)
  assert(close(r.shape,{4,4}),"acc 232 shape")
  assert(close(r.strides,{32,8}),"acc 232 strides")
  assert(close(r:tolist(),{{7,1,4,7},{8,5,11,8},{12,12,12,12},{19,13,16,19}}),"acc 232 values")
end
do -- accumulate 233: multiply int16 [0, 2, 1] axis=0
  local a=np.zeros({0,2,1},np.int16)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="int64","acc 233 dtype "..r.dtype)
  assert(close(r.shape,{0,2,1}),"acc 233 shape")
  assert(close(r.strides,{0,0,0}),"acc 233 strides")
  assert(close(r:tolist(),{}),"acc 233 values")
end
do -- accumulate 234: multiply uint32 [4] axis=0
  local a=np.array({3,4,1,2},np.uint32)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 234 dtype "..r.dtype)
  assert(close(r.shape,{4}),"acc 234 shape")
  assert(close(r.strides,{8}),"acc 234 strides")
  assert(close(r:tolist(),{3,12,12,24}),"acc 234 values")
end
do -- accumulate 235: add uint16 [2, 4, 4] axis=2
  local a=np.array({{{1,4,7,1},{4,7,1,4},{7,1,4,7},{1,4,7,1}},{{4,7,1,4},{7,1,4,7},{1,4,7,1},{4,7,1,4}}},np.uint16)
  local o=np.zeros({2,4,4},np.float32)
  local r=np.add_accumulate(a,{axis=3,dtype=np.int8,out=o})
  assert(r==o,"acc 235 out identity")
  assert(r.dtype=="float32","acc 235 dtype "..r.dtype)
  assert(close(r.shape,{2,4,4}),"acc 235 shape")
  assert(close(r.strides,{64,16,4}),"acc 235 strides")
  assert(close(r:tolist(),{{{1.0,5.0,12.0,13.0},{4.0,11.0,12.0,16.0},{7.0,8.0,12.0,19.0},{1.0,5.0,12.0,13.0}},{{4.0,11.0,12.0,16.0},{7.0,8.0,12.0,19.0},{1.0,5.0,12.0,13.0},{4.0,11.0,12.0,16.0}}}),"acc 235 values")
end
do -- accumulate 236: multiply uint32 [2] axis=0
  local a=np.array({1,2},np.uint32)
  local r=np.multiply_accumulate(a,{axis=1,dtype=np.int8})
  assert(r.dtype=="int8","acc 236 dtype "..r.dtype)
  assert(close(r.shape,{2}),"acc 236 shape")
  assert(close(r.strides,{1}),"acc 236 strides")
  assert(close(r:tolist(),{1,2}),"acc 236 values")
end
do -- accumulate 237: add float32 [3, 4, 0] axis=2
  local a=np.zeros({3,4,0},np.float32)
  local r=np.add_accumulate(a,{axis=3})
  assert(r.dtype=="float32","acc 237 dtype "..r.dtype)
  assert(close(r.shape,{3,4,0}),"acc 237 shape")
  assert(close(r.strides,{0,0,0}),"acc 237 strides")
  assert(close(r:tolist(),{{{},{},{},{}},{{},{},{},{}},{{},{},{},{}}}),"acc 237 values")
end
do -- accumulate 238: add int32 [4, 1, 4] axis=0
  local a=np.array({{{2,5,-3,0}},{{3,-5,-2,1}},{{4,-4,-1,2}},{{5,-3,0,3}}},np.int32)
  local o=np.zeros({4,1,4},np.int8)
  local r=np.add_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 238 out identity")
  assert(r.dtype=="int8","acc 238 dtype "..r.dtype)
  assert(close(r.shape,{4,1,4}),"acc 238 shape")
  assert(close(r.strides,{4,4,1}),"acc 238 strides")
  assert(close(r:tolist(),{{{2,5,-3,0}},{{5,0,-5,1}},{{9,-4,-6,3}},{{14,-7,-6,6}}}),"acc 238 values")
end
do -- accumulate 239: multiply float64 [4] axis=0
  local a=np.array({1.5,0.5,0.75,1.0},np.float64)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="float64","acc 239 dtype "..r.dtype)
  assert(close(r.shape,{4}),"acc 239 shape")
  assert(close(r.strides,{8}),"acc 239 strides")
  assert(close(r:tolist(),{1.5,0.75,0.5625,0.5625}),"acc 239 values")
end
do -- accumulate 240: multiply int16 [2, 4] axis=1
  local a=np.array({{-2,-1,0,1},{2,-2,-1,0}},np.int16)
  local r=np.multiply_accumulate(a,{axis=2,dtype=np.float32})
  assert(r.dtype=="float32","acc 240 dtype "..r.dtype)
  assert(close(r.shape,{2,4}),"acc 240 shape")
  assert(close(r.strides,{16,4}),"acc 240 strides")
  assert(close(r:tolist(),{{-2.0,2.0,0.0,0.0},{2.0,-4.0,4.0,0.0}}),"acc 240 values")
end
do -- accumulate 241: add uint16 [3] axis=0
  local a=np.array({7,1,4},np.uint16)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 241 dtype "..r.dtype)
  assert(close(r.shape,{3}),"acc 241 shape")
  assert(close(r.strides,{8}),"acc 241 strides")
  assert(close(r:tolist(),{7,8,12}),"acc 241 values")
end
do -- accumulate 242: multiply float32 [1, 2, 0, 2] axis=1
  local a=np.zeros({1,2,0,2},np.float32)
  local r=np.multiply_accumulate(a,{axis=2})
  assert(r.dtype=="float32","acc 242 dtype "..r.dtype)
  assert(close(r.shape,{1,2,0,2}),"acc 242 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 242 strides")
  assert(close(r:tolist(),{{{},{}}}),"acc 242 values")
end
do -- accumulate 243: add bool [0, 4, 3, 1] axis=1
  local a=np.zeros({0,4,3,1},np.bool)
  local r=np.add_accumulate(a,{axis=2})
  assert(r.dtype=="int64","acc 243 dtype "..r.dtype)
  assert(close(r.shape,{0,4,3,1}),"acc 243 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 243 strides")
  assert(close(r:tolist(),{}),"acc 243 values")
end
do -- accumulate 244: add uint64 [2, 2] axis=0
  local a=np.array({{1,4},{7,1}},np.uint64)
  local o=np.zeros({2,2},np.float64)
  local r=np.add_accumulate(a,{axis=1,dtype=np.bool,out=o})
  assert(r==o,"acc 244 out identity")
  assert(r.dtype=="float64","acc 244 dtype "..r.dtype)
  assert(close(r.shape,{2,2}),"acc 244 shape")
  assert(close(r.strides,{16,8}),"acc 244 strides")
  assert(close(r:tolist(),{{1.0,1.0},{1.0,1.0}}),"acc 244 values")
end
do -- accumulate 245: multiply int8 [2, 1, 3] axis=1
  local a=np.array({{{-2,-1,0}},{{1,2,-2}}},np.int8)
  local o=np.zeros({2,1,3},np.float16)
  local r=np.multiply_accumulate(a,{axis=2,out=o})
  assert(r==o,"acc 245 out identity")
  assert(r.dtype=="float16","acc 245 dtype "..r.dtype)
  assert(close(r.shape,{2,1,3}),"acc 245 shape")
  assert(close(r.strides,{6,6,2}),"acc 245 strides")
  assert(close(r:tolist(),{{{-2.0,-1.0,0.0}},{{1.0,2.0,-2.0}}}),"acc 245 values")
end
do -- accumulate 246: add uint32 [1, 0, 3, 0] axis=2
  local a=np.zeros({1,0,3,0},np.uint32)
  local o=np.zeros({1,0,3,0},np.int8)
  local r=np.add_accumulate(a,{axis=3,out=o})
  assert(r==o,"acc 246 out identity")
  assert(r.dtype=="int8","acc 246 dtype "..r.dtype)
  assert(close(r.shape,{1,0,3,0}),"acc 246 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 246 strides")
  assert(close(r:tolist(),{{}}),"acc 246 values")
end
do -- accumulate 247: add float16 [3, 0, 0, 4] axis=0
  local a=np.zeros({3,0,0,4},np.float16)
  local r=np.add_accumulate(a,{axis=1,dtype=np.uint8})
  assert(r.dtype=="uint8","acc 247 dtype "..r.dtype)
  assert(close(r.shape,{3,0,0,4}),"acc 247 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 247 strides")
  assert(close(r:tolist(),{{},{},{}}),"acc 247 values")
end
do -- accumulate 248: multiply uint64 [1] axis=0
  local a=np.array({1},np.uint64)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="uint64","acc 248 dtype "..r.dtype)
  assert(close(r.shape,{1}),"acc 248 shape")
  assert(close(r.strides,{8}),"acc 248 strides")
  assert(close(r:tolist(),{1}),"acc 248 values")
end
do -- accumulate 249: add int8 [2, 0, 4] axis=0
  local a=np.zeros({2,0,4},np.int8)
  local r=np.add_accumulate(a,{axis=1})
  assert(r.dtype=="int64","acc 249 dtype "..r.dtype)
  assert(close(r.shape,{2,0,4}),"acc 249 shape")
  assert(close(r.strides,{0,0,0}),"acc 249 strides")
  assert(close(r:tolist(),{{},{}}),"acc 249 values")
end
do -- accumulate 250: add int8 [2, 1, 2] axis=1
  local a=np.array({{{3,-5}},{{-2,1}}},np.int8)
  local r=np.add_accumulate(a,{axis=2,dtype=np.int32})
  assert(r.dtype=="int32","acc 250 dtype "..r.dtype)
  assert(close(r.shape,{2,1,2}),"acc 250 shape")
  assert(close(r.strides,{8,8,4}),"acc 250 strides")
  assert(close(r:tolist(),{{{3,-5}},{{-2,1}}}),"acc 250 values")
end
do -- accumulate 251: multiply bool [2] axis=0
  local a=np.array({true,false},np.bool)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="int64","acc 251 dtype "..r.dtype)
  assert(close(r.shape,{2}),"acc 251 shape")
  assert(close(r.strides,{8}),"acc 251 strides")
  assert(close(r:tolist(),{1,0}),"acc 251 values")
end
do -- accumulate 252: add float32 [2, 1, 3, 1] axis=3
  local a=np.array({{{{-1.2000000000000002},{-0.8},{-0.4}}},{{{0.0},{0.4},{0.8}}}},np.float32)
  local r=np.add_accumulate(a,{axis=4})
  assert(r.dtype=="float32","acc 252 dtype "..r.dtype)
  assert(close(r.shape,{2,1,3,1}),"acc 252 shape")
  assert(close(r.strides,{12,12,4,4}),"acc 252 strides")
  assert(close(r:tolist(),{{{{-1.2000000476837158},{-0.800000011920929},{-0.4000000059604645}}},{{{0.0},{0.4000000059604645},{0.800000011920929}}}}),"acc 252 values")
end
do -- accumulate 253: multiply bool [2, 2, 3] axis=1
  local a=(np.array({{{true,true},{false,true}},{{true,false},{true,true}},{{false,true},{true,false}}},np.bool)).T
  local r=np.multiply_accumulate(a,{axis=2})
  assert(r.dtype=="int64","acc 253 dtype "..r.dtype)
  assert(close(r.shape,{2,2,3}),"acc 253 shape")
  assert(close(r.strides,{8,16,32}),"acc 253 strides")
  assert(close(r:tolist(),{{{1,1,0},{0,1,0}},{{1,0,1},{1,0,0}}}),"acc 253 values")
end
do -- accumulate 254: multiply float64 [4, 4, 3, 4] axis=0
  local a=np.array({{{{1.5,0.5,0.75,1.0},{1.25,1.5,0.5,0.75},{1.0,1.25,1.5,0.5}},{{0.75,1.0,1.25,1.5},{0.5,0.75,1.0,1.25},{1.5,0.5,0.75,1.0}},{{1.25,1.5,0.5,0.75},{1.0,1.25,1.5,0.5},{0.75,1.0,1.25,1.5}},{{0.5,0.75,1.0,1.25},{1.5,0.5,0.75,1.0},{1.25,1.5,0.5,0.75}}},{{{1.0,1.25,1.5,0.5},{0.75,1.0,1.25,1.5},{0.5,0.75,1.0,1.25}},{{1.5,0.5,0.75,1.0},{1.25,1.5,0.5,0.75},{1.0,1.25,1.5,0.5}},{{0.75,1.0,1.25,1.5},{0.5,0.75,1.0,1.25},{1.5,0.5,0.75,1.0}},{{1.25,1.5,0.5,0.75},{1.0,1.25,1.5,0.5},{0.75,1.0,1.25,1.5}}},{{{0.5,0.75,1.0,1.25},{1.5,0.5,0.75,1.0},{1.25,1.5,0.5,0.75}},{{1.0,1.25,1.5,0.5},{0.75,1.0,1.25,1.5},{0.5,0.75,1.0,1.25}},{{1.5,0.5,0.75,1.0},{1.25,1.5,0.5,0.75},{1.0,1.25,1.5,0.5}},{{0.75,1.0,1.25,1.5},{0.5,0.75,1.0,1.25},{1.5,0.5,0.75,1.0}}},{{{1.25,1.5,0.5,0.75},{1.0,1.25,1.5,0.5},{0.75,1.0,1.25,1.5}},{{0.5,0.75,1.0,1.25},{1.5,0.5,0.75,1.0},{1.25,1.5,0.5,0.75}},{{1.0,1.25,1.5,0.5},{0.75,1.0,1.25,1.5},{0.5,0.75,1.0,1.25}},{{1.5,0.5,0.75,1.0},{1.25,1.5,0.5,0.75},{1.0,1.25,1.5,0.5}}}},np.float64)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="float64","acc 254 dtype "..r.dtype)
  assert(close(r.shape,{4,4,3,4}),"acc 254 shape")
  assert(close(r.strides,{384,96,32,8}),"acc 254 strides")
  assert(close(r:tolist(),{{{{1.5,0.5,0.75,1.0},{1.25,1.5,0.5,0.75},{1.0,1.25,1.5,0.5}},{{0.75,1.0,1.25,1.5},{0.5,0.75,1.0,1.25},{1.5,0.5,0.75,1.0}},{{1.25,1.5,0.5,0.75},{1.0,1.25,1.5,0.5},{0.75,1.0,1.25,1.5}},{{0.5,0.75,1.0,1.25},{1.5,0.5,0.75,1.0},{1.25,1.5,0.5,0.75}}},{{{1.5,0.625,1.125,0.5},{0.9375,1.5,0.625,1.125},{0.5,0.9375,1.5,0.625}},{{1.125,0.5,0.9375,1.5},{0.625,1.125,0.5,0.9375},{1.5,0.625,1.125,0.5}},{{0.9375,1.5,0.625,1.125},{0.5,0.9375,1.5,0.625},{1.125,0.5,0.9375,1.5}},{{0.625,1.125,0.5,0.9375},{1.5,0.625,1.125,0.5},{0.9375,1.5,0.625,1.125}}},{{{0.75,0.46875,1.125,0.625},{1.40625,0.75,0.46875,1.125},{0.625,1.40625,0.75,0.46875}},{{1.125,0.625,1.40625,0.75},{0.46875,1.125,0.625,1.40625},{0.75,0.46875,1.125,0.625}},{{1.40625,0.75,0.46875,1.125},{0.625,1.40625,0.75,0.46875},{1.125,0.625,1.40625,0.75}},{{0.46875,1.125,0.625,1.40625},{0.75,0.46875,1.125,0.625},{1.40625,0.75,0.46875,1.125}}},{{{0.9375,0.703125,0.5625,0.46875},{1.40625,0.9375,0.703125,0.5625},{0.46875,1.40625,0.9375,0.703125}},{{0.5625,0.46875,1.40625,0.9375},{0.703125,0.5625,0.46875,1.40625},{0.9375,0.703125,0.5625,0.46875}},{{1.40625,0.9375,0.703125,0.5625},{0.46875,1.40625,0.9375,0.703125},{0.5625,0.46875,1.40625,0.9375}},{{0.703125,0.5625,0.46875,1.40625},{0.9375,0.703125,0.5625,0.46875},{1.40625,0.9375,0.703125,0.5625}}}}),"acc 254 values")
end
do -- accumulate 255: add int16 [0, 0, 3] axis=2
  local a=np.zeros({0,0,3},np.int16)
  local r=np.add_accumulate(a,{axis=3})
  assert(r.dtype=="int64","acc 255 dtype "..r.dtype)
  assert(close(r.shape,{0,0,3}),"acc 255 shape")
  assert(close(r.strides,{0,0,0}),"acc 255 strides")
  assert(close(r:tolist(),{}),"acc 255 values")
end
do -- accumulate 256: multiply bool [2, 2, 3, 3] axis=1
  local a=np.array({{{{true,true,false},{true,true,false},{true,true,false}},{{true,true,false},{true,true,false},{true,true,false}}},{{{true,true,false},{true,true,false},{true,true,false}},{{true,true,false},{true,true,false},{true,true,false}}}},np.bool)
  local r=np.multiply_accumulate(a,{axis=2})
  assert(r.dtype=="int64","acc 256 dtype "..r.dtype)
  assert(close(r.shape,{2,2,3,3}),"acc 256 shape")
  assert(close(r.strides,{144,72,24,8}),"acc 256 strides")
  assert(close(r:tolist(),{{{{1,1,0},{1,1,0},{1,1,0}},{{1,1,0},{1,1,0},{1,1,0}}},{{{1,1,0},{1,1,0},{1,1,0}},{{1,1,0},{1,1,0},{1,1,0}}}}),"acc 256 values")
end
do -- accumulate 257: multiply float16 [1, 3, 0, 1] axis=0
  local a=np.zeros({1,3,0,1},np.float16)
  local r=np.multiply_accumulate(a,{axis=1})
  assert(r.dtype=="float16","acc 257 dtype "..r.dtype)
  assert(close(r.shape,{1,3,0,1}),"acc 257 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 257 strides")
  assert(close(r:tolist(),{{{},{},{}}}),"acc 257 values")
end
do -- accumulate 258: multiply uint64 [0, 1, 3, 3] axis=1
  local a=np.zeros({0,1,3,3},np.uint64)
  local r=np.multiply_accumulate(a,{axis=2})
  assert(r.dtype=="uint64","acc 258 dtype "..r.dtype)
  assert(close(r.shape,{0,1,3,3}),"acc 258 shape")
  assert(close(r.strides,{0,0,0,0}),"acc 258 strides")
  assert(close(r:tolist(),{}),"acc 258 values")
end
do -- accumulate 259: add uint8 [2] axis=0
  local a=np.array({7,1},np.uint8)
  local o=np.zeros({2},np.int16)
  local r=np.add_accumulate(a,{axis=1,out=o})
  assert(r==o,"acc 259 out identity")
  assert(r.dtype=="int16","acc 259 dtype "..r.dtype)
  assert(close(r.shape,{2}),"acc 259 shape")
  assert(close(r.strides,{2}),"acc 259 strides")
  assert(close(r:tolist(),{7,8}),"acc 259 values")
end
do local a=np.array({100,100,100},np.int8); local r=np.add_accumulate(a); assert(r.dtype=="int64" and close(r:tolist(),{100,200,300}),"acc int widening") end
do local a=np.array({100,100,100},np.int8); local o=np.zeros({3},np.int8); np.add_accumulate(a,{out=o}); assert(close(o:tolist(),{100,-56,44}),"acc out suppresses widening") end
do local a=np.array({1.6,1.6,1.6},np.float32); local o=np.zeros({3},np.int8); np.add_accumulate(a,{out=o}); assert(close(o:tolist(),{1,3,4}),"acc cast prefixes not accumulator") end
do local a=np.array({1.6,1.6,1.6},np.float32); local o=np.zeros({3},np.float32); np.add_accumulate(a,{dtype=np.int16,out=o}); assert(close(o:tolist(),{1,2,3}),"acc dtype override") end
print('accumulate differential: 264 cases ok')
