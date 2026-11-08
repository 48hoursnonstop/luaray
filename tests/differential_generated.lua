local np = require("luaray_core")
local function same(a,b)
  if type(a) ~= type(b) then return false end
  if type(a) ~= "table" then
    if type(a)=="number" and a~=a and b~=b then return true end
    return a==b
  end
  if #a ~= #b then return false end
  for i=1,#a do if not same(a[i],b[i]) then return false end end
  return true
end
-- Generated against NumPy 2.3.5; upstream source remains primary.
do -- case 1: int64(2, 1, 3) add int8(1, 4, 1)
  local a=np.array({{{-1,3,-2}},{{3,-2,3}}}, "int64")
  local b=np.array({{{5},{3},{3},{-5}}}, "int8")
  local r=a + b
  assert(r.dtype=="int64", "case 1 dtype "..r.dtype)
  assert(same(r:tolist(), {{{4,8,3},{2,6,1},{2,6,1},{-6,-2,-7}},{{8,3,8},{6,1,6},{6,1,6},{-2,-7,-2}}}), "case 1 values")
end
do -- case 2: bool(3,) add int16(3,)
  local a=np.array({false,true,true}, "bool")
  local b=np.array({4,1,0}, "int16")
  local r=a + b
  assert(r.dtype=="int16", "case 2 dtype "..r.dtype)
  assert(same(r:tolist(), {4,2,1}), "case 2 values")
end
do -- case 3: bool(2, 3) add int8(3,)
  local a=np.array({{true,false,false},{false,false,true}}, "bool")
  local b=np.array({-5,-5,5}, "int8")
  local r=a + b
  assert(r.dtype=="int8", "case 3 dtype "..r.dtype)
  assert(same(r:tolist(), {{-4,-5,5},{-5,-5,6}}), "case 3 values")
end
do -- case 4: float64(3,) add uint32(3,)
  local a=np.array({-1.25,-0.5,-1.75}, "float64")
  local b=np.array({3,3,1}, "uint32")
  local r=a + b
  assert(r.dtype=="float64", "case 4 dtype "..r.dtype)
  assert(same(r:tolist(), {1.75,2.5,-0.75}), "case 4 values")
end
do -- case 5: int32(3,) add int16(3,)
  local a=np.array({3,2,-5}, "int32")
  local b=np.array({5,5,-2}, "int16")
  local r=a + b
  assert(r.dtype=="int32", "case 5 dtype "..r.dtype)
  assert(same(r:tolist(), {8,7,-7}), "case 5 values")
end
do -- case 6: int8(3,) multiply int8(3,)
  local a=np.array({1,2,-3}, "int8")
  local b=np.array({-5,1,4}, "int8")
  local r=a * b
  assert(r.dtype=="int8", "case 6 dtype "..r.dtype)
  assert(same(r:tolist(), {-5,2,-12}), "case 6 values")
end
do -- case 7: float32(2, 1, 2) multiply int8(1, 2, 2)
  local a=np.array({{{0.0,2.0}},{{-2.25,-0.25}}}, "float32")
  local b=np.array({{{-1,2},{-3,4}}}, "int8")
  local r=a * b
  assert(r.dtype=="float32", "case 7 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-0.0,4.0},{-0.0,8.0}},{{2.25,-0.5},{6.75,-1.0}}}), "case 7 values")
end
do -- case 8: uint8(3,) multiply uint64(3,)
  local a=np.array({1,0,3}, "uint8")
  local b=np.array({0,4,0}, "uint64")
  local r=a * b
  assert(r.dtype=="uint64", "case 8 dtype "..r.dtype)
  assert(same(r:tolist(), {0,0,0}), "case 8 values")
end
do -- case 9: float32(1, 3) add int16(2, 1)
  local a=np.array({{-0.25,-1.5,1.75}}, "float32")
  local b=np.array({{-4},{-4}}, "int16")
  local r=a + b
  assert(r.dtype=="float32", "case 9 dtype "..r.dtype)
  assert(same(r:tolist(), {{-4.25,-5.5,-2.25},{-4.25,-5.5,-2.25}}), "case 9 values")
end
do -- case 10: float64(2, 1, 2) add int64(1, 2, 2)
  local a=np.array({{{2.0,-1.75}},{{1.0,-1.25}}}, "float64")
  local b=np.array({{{-2,4},{-1,-4}}}, "int64")
  local r=a + b
  assert(r.dtype=="float64", "case 10 dtype "..r.dtype)
  assert(same(r:tolist(), {{{0.0,2.25},{1.0,-5.75}},{{-1.0,2.75},{0.0,-5.25}}}), "case 10 values")
end
do -- case 11: uint32(2, 3) add float64(3,)
  local a=np.array({{0,3,0},{3,0,2}}, "uint32")
  local b=np.array({-1.75,1.25,2.25}, "float64")
  local r=a + b
  assert(r.dtype=="float64", "case 11 dtype "..r.dtype)
  assert(same(r:tolist(), {{-1.75,4.25,2.25},{1.25,1.25,4.25}}), "case 11 values")
end
do -- case 12: float64(2, 3) multiply uint32(3,)
  local a=np.array({{0.0,1.25,-0.75},{1.75,-2.0,0.75}}, "float64")
  local b=np.array({3,4,4}, "uint32")
  local r=a * b
  assert(r.dtype=="float64", "case 12 dtype "..r.dtype)
  assert(same(r:tolist(), {{0.0,5.0,-3.0},{5.25,-8.0,3.0}}), "case 12 values")
end
do -- case 13: float32(2, 1, 3) add float32(1, 4, 1)
  local a=np.array({{{-2.25,-0.25,0.75}},{{-2.0,-1.0,1.0}}}, "float32")
  local b=np.array({{{-2.0},{2.0},{1.75},{1.5}}}, "float32")
  local r=a + b
  assert(r.dtype=="float32", "case 13 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-4.25,-2.25,-1.25},{-0.25,1.75,2.75},{-0.5,1.5,2.5},{-0.75,1.25,2.25}},{{-4.0,-3.0,-1.0},{0.0,1.0,3.0},{-0.25,0.75,2.75},{-0.5,0.5,2.5}}}), "case 13 values")
end
do -- case 14: float32(2, 1, 3) multiply uint32(1, 4, 1)
  local a=np.array({{{2.25,1.25,0.75}},{{-1.75,1.0,-1.5}}}, "float32")
  local b=np.array({{{3},{0},{3},{0}}}, "uint32")
  local r=a * b
  assert(r.dtype=="float64", "case 14 dtype "..r.dtype)
  assert(same(r:tolist(), {{{6.75,3.75,2.25},{0.0,0.0,0.0},{6.75,3.75,2.25},{0.0,0.0,0.0}},{{-5.25,3.0,-4.5},{-0.0,0.0,-0.0},{-5.25,3.0,-4.5},{-0.0,0.0,-0.0}}}), "case 14 values")
end
do -- case 15: uint8(1, 3) add uint64(2, 1)
  local a=np.array({{3,2,5}}, "uint8")
  local b=np.array({{5},{0}}, "uint64")
  local r=a + b
  assert(r.dtype=="uint64", "case 15 dtype "..r.dtype)
  assert(same(r:tolist(), {{8,7,10},{3,2,5}}), "case 15 values")
end
do -- case 16: uint16(1, 3) multiply bool(2, 1)
  local a=np.array({{0,4,3}}, "uint16")
  local b=np.array({{false},{true}}, "bool")
  local r=a * b
  assert(r.dtype=="uint16", "case 16 dtype "..r.dtype)
  assert(same(r:tolist(), {{0,0,0},{0,4,3}}), "case 16 values")
end
do -- case 17: uint64(2, 1, 2) add float64(1, 2, 2)
  local a=np.array({{{3,4}},{{4,1}}}, "uint64")
  local b=np.array({{{2.5,2.0},{-1.75,1.5}}}, "float64")
  local r=a + b
  assert(r.dtype=="float64", "case 17 dtype "..r.dtype)
  assert(same(r:tolist(), {{{5.5,6.0},{1.25,5.5}},{{6.5,3.0},{2.25,2.5}}}), "case 17 values")
end
do -- case 18: uint32(3,) multiply float32(3,)
  local a=np.array({1,5,3}, "uint32")
  local b=np.array({0.25,-2.5,2.25}, "float32")
  local r=a * b
  assert(r.dtype=="float64", "case 18 dtype "..r.dtype)
  assert(same(r:tolist(), {0.25,-12.5,6.75}), "case 18 values")
end
do -- case 19: int64(1, 3) multiply int16(2, 1)
  local a=np.array({{5,5,5}}, "int64")
  local b=np.array({{-4},{3}}, "int16")
  local r=a * b
  assert(r.dtype=="int64", "case 19 dtype "..r.dtype)
  assert(same(r:tolist(), {{-20,-20,-20},{15,15,15}}), "case 19 values")
end
do -- case 20: uint8(2, 3) multiply uint32(3,)
  local a=np.array({{5,4,3},{4,5,3}}, "uint8")
  local b=np.array({1,1,2}, "uint32")
  local r=a * b
  assert(r.dtype=="uint32", "case 20 dtype "..r.dtype)
  assert(same(r:tolist(), {{5,4,6},{4,5,6}}), "case 20 values")
end
do -- case 21: int8(2, 1, 2) add uint16(1, 2, 2)
  local a=np.array({{{1,-1}},{{-4,1}}}, "int8")
  local b=np.array({{{2,3},{0,4}}}, "uint16")
  local r=a + b
  assert(r.dtype=="int32", "case 21 dtype "..r.dtype)
  assert(same(r:tolist(), {{{3,2},{1,3}},{{-2,4},{-4,5}}}), "case 21 values")
end
do -- case 22: uint16(2, 3) add uint64(3,)
  local a=np.array({{4,1,1},{4,1,3}}, "uint16")
  local b=np.array({2,1,3}, "uint64")
  local r=a + b
  assert(r.dtype=="uint64", "case 22 dtype "..r.dtype)
  assert(same(r:tolist(), {{6,2,4},{6,2,6}}), "case 22 values")
end
do -- case 23: float16(1, 3) multiply int16(2, 1)
  local a=np.array({{0.5,-1.75,-2.5}}, "float16")
  local b=np.array({{2},{-4}}, "int16")
  local r=a * b
  assert(r.dtype=="float32", "case 23 dtype "..r.dtype)
  assert(same(r:tolist(), {{1.0,-3.5,-5.0},{-2.0,7.0,10.0}}), "case 23 values")
end
do -- case 24: uint8(3,) add float64(3,)
  local a=np.array({2,5,3}, "uint8")
  local b=np.array({1.75,-2.5,-2.25}, "float64")
  local r=a + b
  assert(r.dtype=="float64", "case 24 dtype "..r.dtype)
  assert(same(r:tolist(), {3.75,2.5,0.75}), "case 24 values")
end
do -- case 25: float64(2, 1, 2) add int16(1, 2, 2)
  local a=np.array({{{-2.0,-1.0}},{{1.5,-1.5}}}, "float64")
  local b=np.array({{{5,0},{2,-3}}}, "int16")
  local r=a + b
  assert(r.dtype=="float64", "case 25 dtype "..r.dtype)
  assert(same(r:tolist(), {{{3.0,-1.0},{0.0,-4.0}},{{6.5,-1.5},{3.5,-4.5}}}), "case 25 values")
end
do -- case 26: uint32(3,) add bool(3,)
  local a=np.array({4,1,1}, "uint32")
  local b=np.array({false,false,true}, "bool")
  local r=a + b
  assert(r.dtype=="uint32", "case 26 dtype "..r.dtype)
  assert(same(r:tolist(), {4,1,2}), "case 26 values")
end
do -- case 27: float16(2, 3) multiply uint32(3,)
  local a=np.array({{-0.75,1.5,-1.75},{1.0,-1.5,-0.25}}, "float16")
  local b=np.array({4,5,4}, "uint32")
  local r=a * b
  assert(r.dtype=="float64", "case 27 dtype "..r.dtype)
  assert(same(r:tolist(), {{-3.0,7.5,-7.0},{4.0,-7.5,-1.0}}), "case 27 values")
end
do -- case 28: int32(2, 1, 3) multiply float32(1, 4, 1)
  local a=np.array({{{-2,1,-3}},{{3,-2,0}}}, "int32")
  local b=np.array({{{0.75},{-0.75},{-1.0},{-2.5}}}, "float32")
  local r=a * b
  assert(r.dtype=="float64", "case 28 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-1.5,0.75,-2.25},{1.5,-0.75,2.25},{2.0,-1.0,3.0},{5.0,-2.5,7.5}},{{2.25,-1.5,0.0},{-2.25,1.5,-0.0},{-3.0,2.0,-0.0},{-7.5,5.0,-0.0}}}), "case 28 values")
end
do -- case 29: bool(2, 1, 2) add int16(1, 2, 2)
  local a=np.array({{{false,false}},{{false,true}}}, "bool")
  local b=np.array({{{-2,-1},{-2,-4}}}, "int16")
  local r=a + b
  assert(r.dtype=="int16", "case 29 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-2,-1},{-2,-4}},{{-2,0},{-2,-3}}}), "case 29 values")
end
do -- case 30: uint8(2, 1, 3) multiply bool(1, 4, 1)
  local a=np.array({{{4,0,5}},{{3,5,3}}}, "uint8")
  local b=np.array({{{true},{false},{true},{false}}}, "bool")
  local r=a * b
  assert(r.dtype=="uint8", "case 30 dtype "..r.dtype)
  assert(same(r:tolist(), {{{4,0,5},{0,0,0},{4,0,5},{0,0,0}},{{3,5,3},{0,0,0},{3,5,3},{0,0,0}}}), "case 30 values")
end
do -- case 31: uint16(2, 3) add float32(3,)
  local a=np.array({{4,2,0},{2,4,0}}, "uint16")
  local b=np.array({-1.5,-2.5,1.0}, "float32")
  local r=a + b
  assert(r.dtype=="float32", "case 31 dtype "..r.dtype)
  assert(same(r:tolist(), {{2.5,-0.5,1.0},{0.5,1.5,1.0}}), "case 31 values")
end
do -- case 32: int8(2, 1, 2) add uint32(1, 2, 2)
  local a=np.array({{{-4,-1}},{{4,-3}}}, "int8")
  local b=np.array({{{4,0},{3,5}}}, "uint32")
  local r=a + b
  assert(r.dtype=="int64", "case 32 dtype "..r.dtype)
  assert(same(r:tolist(), {{{0,-1},{-1,4}},{{8,-3},{7,2}}}), "case 32 values")
end
do -- case 33: uint16(2, 3) multiply float32(3,)
  local a=np.array({{3,5,5},{0,2,4}}, "uint16")
  local b=np.array({2.5,-2.5,-1.25}, "float32")
  local r=a * b
  assert(r.dtype=="float32", "case 33 dtype "..r.dtype)
  assert(same(r:tolist(), {{7.5,-12.5,-6.25},{0.0,-5.0,-5.0}}), "case 33 values")
end
do -- case 34: int64(2, 1, 3) add float32(1, 4, 1)
  local a=np.array({{{0,-1,-3}},{{-4,-1,3}}}, "int64")
  local b=np.array({{{2.25},{-1.75},{2.25},{0.0}}}, "float32")
  local r=a + b
  assert(r.dtype=="float64", "case 34 dtype "..r.dtype)
  assert(same(r:tolist(), {{{2.25,1.25,-0.75},{-1.75,-2.75,-4.75},{2.25,1.25,-0.75},{0.0,-1.0,-3.0}},{{-1.75,1.25,5.25},{-5.75,-2.75,1.25},{-1.75,1.25,5.25},{-4.0,-1.0,3.0}}}), "case 34 values")
end
do -- case 35: int16(2, 1, 2) add int8(1, 2, 2)
  local a=np.array({{{-2,-4}},{{5,-3}}}, "int16")
  local b=np.array({{{2,-5},{0,0}}}, "int8")
  local r=a + b
  assert(r.dtype=="int16", "case 35 dtype "..r.dtype)
  assert(same(r:tolist(), {{{0,-9},{-2,-4}},{{7,-8},{5,-3}}}), "case 35 values")
end
do -- case 36: int16(2, 1, 3) add uint32(1, 4, 1)
  local a=np.array({{{0,5,-2}},{{0,5,1}}}, "int16")
  local b=np.array({{{4},{5},{2},{1}}}, "uint32")
  local r=a + b
  assert(r.dtype=="int64", "case 36 dtype "..r.dtype)
  assert(same(r:tolist(), {{{4,9,2},{5,10,3},{2,7,0},{1,6,-1}},{{4,9,5},{5,10,6},{2,7,3},{1,6,2}}}), "case 36 values")
end
do -- case 37: uint64(2, 1, 2) multiply int32(1, 2, 2)
  local a=np.array({{{4,5}},{{3,1}}}, "uint64")
  local b=np.array({{{4,-4},{-5,2}}}, "int32")
  local r=a * b
  assert(r.dtype=="float64", "case 37 dtype "..r.dtype)
  assert(same(r:tolist(), {{{16.0,-20.0},{-20.0,10.0}},{{12.0,-4.0},{-15.0,2.0}}}), "case 37 values")
end
do -- case 38: int64(2, 1, 2) multiply uint8(1, 2, 2)
  local a=np.array({{{2,4}},{{-3,-4}}}, "int64")
  local b=np.array({{{2,3},{2,1}}}, "uint8")
  local r=a * b
  assert(r.dtype=="int64", "case 38 dtype "..r.dtype)
  assert(same(r:tolist(), {{{4,12},{4,4}},{{-6,-12},{-6,-4}}}), "case 38 values")
end
do -- case 39: uint64(2, 1, 3) multiply float64(1, 4, 1)
  local a=np.array({{{5,5,0}},{{0,1,4}}}, "uint64")
  local b=np.array({{{-1.0},{-0.5},{1.5},{-2.25}}}, "float64")
  local r=a * b
  assert(r.dtype=="float64", "case 39 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-5.0,-5.0,-0.0},{-2.5,-2.5,-0.0},{7.5,7.5,0.0},{-11.25,-11.25,-0.0}},{{-0.0,-1.0,-4.0},{-0.0,-0.5,-2.0},{0.0,1.5,6.0},{-0.0,-2.25,-9.0}}}), "case 39 values")
end
do -- case 40: bool(1, 3) add uint16(2, 1)
  local a=np.array({{false,true,false}}, "bool")
  local b=np.array({{0},{4}}, "uint16")
  local r=a + b
  assert(r.dtype=="uint16", "case 40 dtype "..r.dtype)
  assert(same(r:tolist(), {{0,1,0},{4,5,4}}), "case 40 values")
end
do -- case 41: uint64(2, 3) add bool(3,)
  local a=np.array({{0,1,4},{4,1,2}}, "uint64")
  local b=np.array({false,false,false}, "bool")
  local r=a + b
  assert(r.dtype=="uint64", "case 41 dtype "..r.dtype)
  assert(same(r:tolist(), {{0,1,4},{4,1,2}}), "case 41 values")
end
do -- case 42: uint32(2, 3) multiply uint8(3,)
  local a=np.array({{0,2,1},{0,2,1}}, "uint32")
  local b=np.array({5,0,3}, "uint8")
  local r=a * b
  assert(r.dtype=="uint32", "case 42 dtype "..r.dtype)
  assert(same(r:tolist(), {{0,0,3},{0,0,3}}), "case 42 values")
end
do -- case 43: int16(2, 3) add float16(3,)
  local a=np.array({{4,-2,-5},{1,-5,5}}, "int16")
  local b=np.array({-1.75,2.25,2.5}, "float16")
  local r=a + b
  assert(r.dtype=="float32", "case 43 dtype "..r.dtype)
  assert(same(r:tolist(), {{2.25,0.25,-2.5},{-0.75,-2.75,7.5}}), "case 43 values")
end
do -- case 44: int8(2, 1, 3) multiply uint16(1, 4, 1)
  local a=np.array({{{0,0,-1}},{{5,5,1}}}, "int8")
  local b=np.array({{{3},{0},{1},{1}}}, "uint16")
  local r=a * b
  assert(r.dtype=="int32", "case 44 dtype "..r.dtype)
  assert(same(r:tolist(), {{{0,0,-3},{0,0,0},{0,0,-1},{0,0,-1}},{{15,15,3},{0,0,0},{5,5,1},{5,5,1}}}), "case 44 values")
end
do -- case 45: float32(2, 1, 3) multiply uint8(1, 4, 1)
  local a=np.array({{{-0.5,-0.75,-1.75}},{{-2.0,-0.25,0.5}}}, "float32")
  local b=np.array({{{3},{4},{4},{2}}}, "uint8")
  local r=a * b
  assert(r.dtype=="float32", "case 45 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-1.5,-2.25,-5.25},{-2.0,-3.0,-7.0},{-2.0,-3.0,-7.0},{-1.0,-1.5,-3.5}},{{-6.0,-0.75,1.5},{-8.0,-1.0,2.0},{-8.0,-1.0,2.0},{-4.0,-0.5,1.0}}}), "case 45 values")
end
do -- case 46: bool(2, 3) add int32(3,)
  local a=np.array({{true,false,true},{false,true,false}}, "bool")
  local b=np.array({2,3,-5}, "int32")
  local r=a + b
  assert(r.dtype=="int32", "case 46 dtype "..r.dtype)
  assert(same(r:tolist(), {{3,3,-4},{2,4,-5}}), "case 46 values")
end
do -- case 47: uint8(3,) add float16(3,)
  local a=np.array({4,4,5}, "uint8")
  local b=np.array({1.75,-1.25,2.5}, "float16")
  local r=a + b
  assert(r.dtype=="float16", "case 47 dtype "..r.dtype)
  assert(same(r:tolist(), {5.75,2.75,7.5}), "case 47 values")
end
do -- case 48: uint64(1, 3) multiply bool(2, 1)
  local a=np.array({{4,1,3}}, "uint64")
  local b=np.array({{true},{false}}, "bool")
  local r=a * b
  assert(r.dtype=="uint64", "case 48 dtype "..r.dtype)
  assert(same(r:tolist(), {{4,1,3},{0,0,0}}), "case 48 values")
end
do -- case 49: uint32(1, 3) add float16(2, 1)
  local a=np.array({{0,2,3}}, "uint32")
  local b=np.array({{0.0},{0.75}}, "float16")
  local r=a + b
  assert(r.dtype=="float64", "case 49 dtype "..r.dtype)
  assert(same(r:tolist(), {{0.0,2.0,3.0},{0.75,2.75,3.75}}), "case 49 values")
end
do -- case 50: int32(2, 1, 2) add uint8(1, 2, 2)
  local a=np.array({{{1,5}},{{4,-1}}}, "int32")
  local b=np.array({{{3,4},{3,3}}}, "uint8")
  local r=a + b
  assert(r.dtype=="int32", "case 50 dtype "..r.dtype)
  assert(same(r:tolist(), {{{4,9},{4,8}},{{7,3},{7,2}}}), "case 50 values")
end
do -- case 51: uint8(2, 1, 2) add uint32(1, 2, 2)
  local a=np.array({{{3,1}},{{1,0}}}, "uint8")
  local b=np.array({{{0,0},{1,2}}}, "uint32")
  local r=a + b
  assert(r.dtype=="uint32", "case 51 dtype "..r.dtype)
  assert(same(r:tolist(), {{{3,1},{4,3}},{{1,0},{2,2}}}), "case 51 values")
end
do -- case 52: int32(2, 3) add float32(3,)
  local a=np.array({{1,0,-3},{2,1,1}}, "int32")
  local b=np.array({1.0,1.5,2.5}, "float32")
  local r=a + b
  assert(r.dtype=="float64", "case 52 dtype "..r.dtype)
  assert(same(r:tolist(), {{2.0,1.5,-0.5},{3.0,2.5,3.5}}), "case 52 values")
end
do -- case 53: uint8(1, 3) add int8(2, 1)
  local a=np.array({{1,2,4}}, "uint8")
  local b=np.array({{2},{1}}, "int8")
  local r=a + b
  assert(r.dtype=="int16", "case 53 dtype "..r.dtype)
  assert(same(r:tolist(), {{3,4,6},{2,3,5}}), "case 53 values")
end
do -- case 54: uint64(2, 1, 2) add float32(1, 2, 2)
  local a=np.array({{{2,0}},{{1,0}}}, "uint64")
  local b=np.array({{{-2.5,2.25},{-0.25,-2.5}}}, "float32")
  local r=a + b
  assert(r.dtype=="float64", "case 54 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-0.5,2.25},{1.75,-2.5}},{{-1.5,2.25},{0.75,-2.5}}}), "case 54 values")
end
do -- case 55: bool(2, 1, 3) add float32(1, 4, 1)
  local a=np.array({{{false,false,false}},{{false,true,true}}}, "bool")
  local b=np.array({{{1.5},{-1.75},{-1.25},{-1.25}}}, "float32")
  local r=a + b
  assert(r.dtype=="float32", "case 55 dtype "..r.dtype)
  assert(same(r:tolist(), {{{1.5,1.5,1.5},{-1.75,-1.75,-1.75},{-1.25,-1.25,-1.25},{-1.25,-1.25,-1.25}},{{1.5,2.5,2.5},{-1.75,-0.75,-0.75},{-1.25,-0.25,-0.25},{-1.25,-0.25,-0.25}}}), "case 55 values")
end
do -- case 56: uint32(3,) add uint32(3,)
  local a=np.array({3,1,3}, "uint32")
  local b=np.array({1,3,3}, "uint32")
  local r=a + b
  assert(r.dtype=="uint32", "case 56 dtype "..r.dtype)
  assert(same(r:tolist(), {4,4,6}), "case 56 values")
end
do -- case 57: uint32(1, 3) add int64(2, 1)
  local a=np.array({{1,1,3}}, "uint32")
  local b=np.array({{1},{4}}, "int64")
  local r=a + b
  assert(r.dtype=="int64", "case 57 dtype "..r.dtype)
  assert(same(r:tolist(), {{2,2,4},{5,5,7}}), "case 57 values")
end
do -- case 58: int64(2, 1, 2) multiply float16(1, 2, 2)
  local a=np.array({{{-4,4}},{{-2,-2}}}, "int64")
  local b=np.array({{{-1.0,-1.0},{-1.25,0.25}}}, "float16")
  local r=a * b
  assert(r.dtype=="float64", "case 58 dtype "..r.dtype)
  assert(same(r:tolist(), {{{4.0,-4.0},{5.0,1.0}},{{2.0,2.0},{2.5,-0.5}}}), "case 58 values")
end
do -- case 59: uint32(1, 3) multiply bool(2, 1)
  local a=np.array({{0,4,5}}, "uint32")
  local b=np.array({{true},{false}}, "bool")
  local r=a * b
  assert(r.dtype=="uint32", "case 59 dtype "..r.dtype)
  assert(same(r:tolist(), {{0,4,5},{0,0,0}}), "case 59 values")
end
do -- case 60: int8(2, 1, 2) add bool(1, 2, 2)
  local a=np.array({{{4,1}},{{-3,-5}}}, "int8")
  local b=np.array({{{false,true},{false,true}}}, "bool")
  local r=a + b
  assert(r.dtype=="int8", "case 60 dtype "..r.dtype)
  assert(same(r:tolist(), {{{4,2},{4,2}},{{-3,-4},{-3,-4}}}), "case 60 values")
end
do -- case 61: uint8(3,) multiply float16(3,)
  local a=np.array({3,4,0}, "uint8")
  local b=np.array({2.5,1.75,2.25}, "float16")
  local r=a * b
  assert(r.dtype=="float16", "case 61 dtype "..r.dtype)
  assert(same(r:tolist(), {7.5,7.0,0.0}), "case 61 values")
end
do -- case 62: uint8(2, 1, 2) add int32(1, 2, 2)
  local a=np.array({{{4,3}},{{4,0}}}, "uint8")
  local b=np.array({{{3,1},{1,-4}}}, "int32")
  local r=a + b
  assert(r.dtype=="int32", "case 62 dtype "..r.dtype)
  assert(same(r:tolist(), {{{7,4},{5,-1}},{{7,1},{5,-4}}}), "case 62 values")
end
do -- case 63: int8(2, 3) add bool(3,)
  local a=np.array({{3,-3,-2},{4,5,0}}, "int8")
  local b=np.array({false,true,false}, "bool")
  local r=a + b
  assert(r.dtype=="int8", "case 63 dtype "..r.dtype)
  assert(same(r:tolist(), {{3,-2,-2},{4,6,0}}), "case 63 values")
end
do -- case 64: float64(2, 1, 2) add int64(1, 2, 2)
  local a=np.array({{{2.0,-2.0}},{{-2.25,1.25}}}, "float64")
  local b=np.array({{{3,2},{-2,0}}}, "int64")
  local r=a + b
  assert(r.dtype=="float64", "case 64 dtype "..r.dtype)
  assert(same(r:tolist(), {{{5.0,0.0},{0.0,-2.0}},{{0.75,3.25},{-4.25,1.25}}}), "case 64 values")
end
do -- case 65: float16(2, 1, 3) multiply float16(1, 4, 1)
  local a=np.array({{{-1.75,1.75,-0.75}},{{-1.0,-2.0,1.75}}}, "float16")
  local b=np.array({{{-2.25},{-2.0},{2.0},{-2.25}}}, "float16")
  local r=a * b
  assert(r.dtype=="float16", "case 65 dtype "..r.dtype)
  assert(same(r:tolist(), {{{3.9375,-3.9375,1.6875},{3.5,-3.5,1.5},{-3.5,3.5,-1.5},{3.9375,-3.9375,1.6875}},{{2.25,4.5,-3.9375},{2.0,4.0,-3.5},{-2.0,-4.0,3.5},{2.25,4.5,-3.9375}}}), "case 65 values")
end
do -- case 66: uint8(3,) add int32(3,)
  local a=np.array({2,2,2}, "uint8")
  local b=np.array({0,4,3}, "int32")
  local r=a + b
  assert(r.dtype=="int32", "case 66 dtype "..r.dtype)
  assert(same(r:tolist(), {2,6,5}), "case 66 values")
end
do -- case 67: int64(2, 1, 3) add uint64(1, 4, 1)
  local a=np.array({{{-2,3,2}},{{3,4,3}}}, "int64")
  local b=np.array({{{3},{4},{5},{4}}}, "uint64")
  local r=a + b
  assert(r.dtype=="float64", "case 67 dtype "..r.dtype)
  assert(same(r:tolist(), {{{1.0,6.0,5.0},{2.0,7.0,6.0},{3.0,8.0,7.0},{2.0,7.0,6.0}},{{6.0,7.0,6.0},{7.0,8.0,7.0},{8.0,9.0,8.0},{7.0,8.0,7.0}}}), "case 67 values")
end
do -- case 68: uint8(3,) add float16(3,)
  local a=np.array({4,5,5}, "uint8")
  local b=np.array({-2.25,0.0,2.5}, "float16")
  local r=a + b
  assert(r.dtype=="float16", "case 68 dtype "..r.dtype)
  assert(same(r:tolist(), {1.75,5.0,7.5}), "case 68 values")
end
do -- case 69: float16(2, 1, 2) multiply float16(1, 2, 2)
  local a=np.array({{{0.25,2.0}},{{0.0,2.0}}}, "float16")
  local b=np.array({{{-1.5,-1.5},{-1.0,-1.5}}}, "float16")
  local r=a * b
  assert(r.dtype=="float16", "case 69 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-0.375,-3.0},{-0.25,-3.0}},{{-0.0,-3.0},{-0.0,-3.0}}}), "case 69 values")
end
do -- case 70: float16(3,) multiply float32(3,)
  local a=np.array({-1.0,1.5,2.5}, "float16")
  local b=np.array({1.75,0.0,2.25}, "float32")
  local r=a * b
  assert(r.dtype=="float32", "case 70 dtype "..r.dtype)
  assert(same(r:tolist(), {-1.75,0.0,5.625}), "case 70 values")
end
do -- case 71: float16(2, 3) add int32(3,)
  local a=np.array({{-0.75,-1.0,-1.25},{-2.0,0.5,-2.0}}, "float16")
  local b=np.array({2,2,3}, "int32")
  local r=a + b
  assert(r.dtype=="float64", "case 71 dtype "..r.dtype)
  assert(same(r:tolist(), {{1.25,1.0,1.75},{0.0,2.5,1.0}}), "case 71 values")
end
do -- case 72: int32(2, 1, 2) multiply float64(1, 2, 2)
  local a=np.array({{{1,5}},{{0,-3}}}, "int32")
  local b=np.array({{{-1.25,0.75},{-2.25,-2.5}}}, "float64")
  local r=a * b
  assert(r.dtype=="float64", "case 72 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-1.25,3.75},{-2.25,-12.5}},{{-0.0,-2.25},{-0.0,7.5}}}), "case 72 values")
end
do -- case 73: int16(1, 3) add bool(2, 1)
  local a=np.array({{-4,-5,4}}, "int16")
  local b=np.array({{false},{false}}, "bool")
  local r=a + b
  assert(r.dtype=="int16", "case 73 dtype "..r.dtype)
  assert(same(r:tolist(), {{-4,-5,4},{-4,-5,4}}), "case 73 values")
end
do -- case 74: uint8(2, 1, 3) add uint64(1, 4, 1)
  local a=np.array({{{2,2,0}},{{4,1,1}}}, "uint8")
  local b=np.array({{{3},{2},{2},{3}}}, "uint64")
  local r=a + b
  assert(r.dtype=="uint64", "case 74 dtype "..r.dtype)
  assert(same(r:tolist(), {{{5,5,3},{4,4,2},{4,4,2},{5,5,3}},{{7,4,4},{6,3,3},{6,3,3},{7,4,4}}}), "case 74 values")
end
do -- case 75: uint32(1, 3) multiply float64(2, 1)
  local a=np.array({{3,2,1}}, "uint32")
  local b=np.array({{0.25},{-1.25}}, "float64")
  local r=a * b
  assert(r.dtype=="float64", "case 75 dtype "..r.dtype)
  assert(same(r:tolist(), {{0.75,0.5,0.25},{-3.75,-2.5,-1.25}}), "case 75 values")
end
do -- case 76: int64(1, 3) add float32(2, 1)
  local a=np.array({{1,-1,5}}, "int64")
  local b=np.array({{1.5},{-0.25}}, "float32")
  local r=a + b
  assert(r.dtype=="float64", "case 76 dtype "..r.dtype)
  assert(same(r:tolist(), {{2.5,0.5,6.5},{0.75,-1.25,4.75}}), "case 76 values")
end
do -- case 77: int8(2, 1, 2) multiply int64(1, 2, 2)
  local a=np.array({{{0,-5}},{{1,3}}}, "int8")
  local b=np.array({{{-3,1},{0,-2}}}, "int64")
  local r=a * b
  assert(r.dtype=="int64", "case 77 dtype "..r.dtype)
  assert(same(r:tolist(), {{{0,-5},{0,10}},{{-3,3},{0,-6}}}), "case 77 values")
end
do -- case 78: uint64(2, 1, 3) add int16(1, 4, 1)
  local a=np.array({{{2,1,5}},{{5,3,3}}}, "uint64")
  local b=np.array({{{4},{-5},{1},{4}}}, "int16")
  local r=a + b
  assert(r.dtype=="float64", "case 78 dtype "..r.dtype)
  assert(same(r:tolist(), {{{6.0,5.0,9.0},{-3.0,-4.0,0.0},{3.0,2.0,6.0},{6.0,5.0,9.0}},{{9.0,7.0,7.0},{0.0,-2.0,-2.0},{6.0,4.0,4.0},{9.0,7.0,7.0}}}), "case 78 values")
end
do -- case 79: int64(1, 3) multiply uint8(2, 1)
  local a=np.array({{4,-5,0}}, "int64")
  local b=np.array({{0},{1}}, "uint8")
  local r=a * b
  assert(r.dtype=="int64", "case 79 dtype "..r.dtype)
  assert(same(r:tolist(), {{0,0,0},{4,-5,0}}), "case 79 values")
end
do -- case 80: float64(3,) multiply int32(3,)
  local a=np.array({-0.75,-2.5,0.5}, "float64")
  local b=np.array({1,2,-1}, "int32")
  local r=a * b
  assert(r.dtype=="float64", "case 80 dtype "..r.dtype)
  assert(same(r:tolist(), {-0.75,-5.0,-0.5}), "case 80 values")
end
do -- case 81: bool(2, 1, 2) add float16(1, 2, 2)
  local a=np.array({{{false,true}},{{true,true}}}, "bool")
  local b=np.array({{{2.0,-1.0},{0.5,2.25}}}, "float16")
  local r=a + b
  assert(r.dtype=="float16", "case 81 dtype "..r.dtype)
  assert(same(r:tolist(), {{{2.0,0.0},{0.5,3.25}},{{3.0,0.0},{1.5,3.25}}}), "case 81 values")
end
do -- case 82: float64(2, 1, 2) add int64(1, 2, 2)
  local a=np.array({{{-1.75,1.5}},{{0.25,1.0}}}, "float64")
  local b=np.array({{{1,-5},{3,-3}}}, "int64")
  local r=a + b
  assert(r.dtype=="float64", "case 82 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-0.75,-3.5},{1.25,-1.5}},{{1.25,-4.0},{3.25,-2.0}}}), "case 82 values")
end
do -- case 83: uint16(2, 1, 2) add uint8(1, 2, 2)
  local a=np.array({{{5,0}},{{4,4}}}, "uint16")
  local b=np.array({{{5,0},{4,1}}}, "uint8")
  local r=a + b
  assert(r.dtype=="uint16", "case 83 dtype "..r.dtype)
  assert(same(r:tolist(), {{{10,0},{9,1}},{{9,4},{8,5}}}), "case 83 values")
end
do -- case 84: float16(2, 1, 2) multiply uint16(1, 2, 2)
  local a=np.array({{{0.5,1.75}},{{-1.75,-1.75}}}, "float16")
  local b=np.array({{{3,0},{0,1}}}, "uint16")
  local r=a * b
  assert(r.dtype=="float32", "case 84 dtype "..r.dtype)
  assert(same(r:tolist(), {{{1.5,0.0},{0.0,1.75}},{{-5.25,-0.0},{-0.0,-1.75}}}), "case 84 values")
end
do -- case 85: int16(2, 1, 2) multiply float16(1, 2, 2)
  local a=np.array({{{-2,-2}},{{5,-4}}}, "int16")
  local b=np.array({{{-1.5,-1.5},{2.5,0.75}}}, "float16")
  local r=a * b
  assert(r.dtype=="float32", "case 85 dtype "..r.dtype)
  assert(same(r:tolist(), {{{3.0,3.0},{-5.0,-1.5}},{{-7.5,6.0},{12.5,-3.0}}}), "case 85 values")
end
do -- case 86: float32(3,) multiply int8(3,)
  local a=np.array({-2.0,-1.75,1.5}, "float32")
  local b=np.array({5,-1,-1}, "int8")
  local r=a * b
  assert(r.dtype=="float32", "case 86 dtype "..r.dtype)
  assert(same(r:tolist(), {-10.0,1.75,-1.5}), "case 86 values")
end
do -- case 87: uint8(1, 3) multiply uint16(2, 1)
  local a=np.array({{4,4,4}}, "uint8")
  local b=np.array({{5},{1}}, "uint16")
  local r=a * b
  assert(r.dtype=="uint16", "case 87 dtype "..r.dtype)
  assert(same(r:tolist(), {{20,20,20},{4,4,4}}), "case 87 values")
end
do -- case 88: int32(2, 1, 3) add int16(1, 4, 1)
  local a=np.array({{{-5,3,5}},{{1,1,0}}}, "int32")
  local b=np.array({{{1},{-5},{4},{3}}}, "int16")
  local r=a + b
  assert(r.dtype=="int32", "case 88 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-4,4,6},{-10,-2,0},{-1,7,9},{-2,6,8}},{{2,2,1},{-4,-4,-5},{5,5,4},{4,4,3}}}), "case 88 values")
end
do -- case 89: float64(2, 1, 2) multiply float16(1, 2, 2)
  local a=np.array({{{-0.25,-1.5}},{{-2.25,-0.75}}}, "float64")
  local b=np.array({{{-2.0,0.0},{-1.5,0.75}}}, "float16")
  local r=a * b
  assert(r.dtype=="float64", "case 89 dtype "..r.dtype)
  assert(same(r:tolist(), {{{0.5,-0.0},{0.375,-1.125}},{{4.5,-0.0},{3.375,-0.5625}}}), "case 89 values")
end
do -- case 90: uint32(1, 3) add float32(2, 1)
  local a=np.array({{4,5,4}}, "uint32")
  local b=np.array({{1.0},{0.0}}, "float32")
  local r=a + b
  assert(r.dtype=="float64", "case 90 dtype "..r.dtype)
  assert(same(r:tolist(), {{5.0,6.0,5.0},{4.0,5.0,4.0}}), "case 90 values")
end
do -- case 91: uint16(3,) add int8(3,)
  local a=np.array({2,1,5}, "uint16")
  local b=np.array({2,-1,3}, "int8")
  local r=a + b
  assert(r.dtype=="int32", "case 91 dtype "..r.dtype)
  assert(same(r:tolist(), {4,0,8}), "case 91 values")
end
do -- case 92: bool(2, 1, 2) add int16(1, 2, 2)
  local a=np.array({{{false,true}},{{true,true}}}, "bool")
  local b=np.array({{{2,-5},{-3,0}}}, "int16")
  local r=a + b
  assert(r.dtype=="int16", "case 92 dtype "..r.dtype)
  assert(same(r:tolist(), {{{2,-4},{-3,1}},{{3,-4},{-2,1}}}), "case 92 values")
end
do -- case 93: int16(3,) add float64(3,)
  local a=np.array({-4,4,4}, "int16")
  local b=np.array({-2.0,2.25,-1.5}, "float64")
  local r=a + b
  assert(r.dtype=="float64", "case 93 dtype "..r.dtype)
  assert(same(r:tolist(), {-6.0,6.25,2.5}), "case 93 values")
end
do -- case 94: float16(2, 3) multiply uint32(3,)
  local a=np.array({{-0.75,0.0,1.25},{-0.5,1.5,0.25}}, "float16")
  local b=np.array({0,5,4}, "uint32")
  local r=a * b
  assert(r.dtype=="float64", "case 94 dtype "..r.dtype)
  assert(same(r:tolist(), {{-0.0,0.0,5.0},{-0.0,7.5,1.0}}), "case 94 values")
end
do -- case 95: int16(3,) add uint16(3,)
  local a=np.array({-3,-3,-3}, "int16")
  local b=np.array({1,1,1}, "uint16")
  local r=a + b
  assert(r.dtype=="int32", "case 95 dtype "..r.dtype)
  assert(same(r:tolist(), {-2,-2,-2}), "case 95 values")
end
do -- case 96: int16(3,) multiply float16(3,)
  local a=np.array({3,1,2}, "int16")
  local b=np.array({1.0,-2.25,1.5}, "float16")
  local r=a * b
  assert(r.dtype=="float32", "case 96 dtype "..r.dtype)
  assert(same(r:tolist(), {3.0,-2.25,3.0}), "case 96 values")
end
do -- case 97: bool(2, 3) multiply uint16(3,)
  local a=np.array({{true,false,true},{true,true,true}}, "bool")
  local b=np.array({2,1,0}, "uint16")
  local r=a * b
  assert(r.dtype=="uint16", "case 97 dtype "..r.dtype)
  assert(same(r:tolist(), {{2,0,0},{2,1,0}}), "case 97 values")
end
do -- case 98: int32(2, 1, 2) multiply int64(1, 2, 2)
  local a=np.array({{{2,-2}},{{-2,-2}}}, "int32")
  local b=np.array({{{4,2},{5,-2}}}, "int64")
  local r=a * b
  assert(r.dtype=="int64", "case 98 dtype "..r.dtype)
  assert(same(r:tolist(), {{{8,-4},{10,4}},{{-8,-4},{-10,4}}}), "case 98 values")
end
do -- case 99: int32(1, 3) multiply uint16(2, 1)
  local a=np.array({{1,2,0}}, "int32")
  local b=np.array({{0},{4}}, "uint16")
  local r=a * b
  assert(r.dtype=="int32", "case 99 dtype "..r.dtype)
  assert(same(r:tolist(), {{0,0,0},{4,8,0}}), "case 99 values")
end
do -- case 100: uint16(3,) multiply uint32(3,)
  local a=np.array({0,0,3}, "uint16")
  local b=np.array({0,0,5}, "uint32")
  local r=a * b
  assert(r.dtype=="uint32", "case 100 dtype "..r.dtype)
  assert(same(r:tolist(), {0,0,15}), "case 100 values")
end
do -- case 101: uint32(1, 3) add int32(2, 1)
  local a=np.array({{2,2,2}}, "uint32")
  local b=np.array({{-1},{-3}}, "int32")
  local r=a + b
  assert(r.dtype=="int64", "case 101 dtype "..r.dtype)
  assert(same(r:tolist(), {{1,1,1},{-1,-1,-1}}), "case 101 values")
end
do -- case 102: uint16(1, 3) add uint64(2, 1)
  local a=np.array({{5,3,0}}, "uint16")
  local b=np.array({{1},{3}}, "uint64")
  local r=a + b
  assert(r.dtype=="uint64", "case 102 dtype "..r.dtype)
  assert(same(r:tolist(), {{6,4,1},{8,6,3}}), "case 102 values")
end
do -- case 103: uint16(2, 1, 3) add float64(1, 4, 1)
  local a=np.array({{{5,5,4}},{{0,3,1}}}, "uint16")
  local b=np.array({{{0.25},{-2.25},{1.25},{-0.25}}}, "float64")
  local r=a + b
  assert(r.dtype=="float64", "case 103 dtype "..r.dtype)
  assert(same(r:tolist(), {{{5.25,5.25,4.25},{2.75,2.75,1.75},{6.25,6.25,5.25},{4.75,4.75,3.75}},{{0.25,3.25,1.25},{-2.25,0.75,-1.25},{1.25,4.25,2.25},{-0.25,2.75,0.75}}}), "case 103 values")
end
do -- case 104: float32(2, 3) add bool(3,)
  local a=np.array({{2.0,2.0,-2.5},{0.5,-0.5,-0.25}}, "float32")
  local b=np.array({false,true,false}, "bool")
  local r=a + b
  assert(r.dtype=="float32", "case 104 dtype "..r.dtype)
  assert(same(r:tolist(), {{2.0,3.0,-2.5},{0.5,0.5,-0.25}}), "case 104 values")
end
do -- case 105: bool(2, 3) multiply float32(3,)
  local a=np.array({{false,false,false},{false,false,true}}, "bool")
  local b=np.array({0.25,0.75,0.75}, "float32")
  local r=a * b
  assert(r.dtype=="float32", "case 105 dtype "..r.dtype)
  assert(same(r:tolist(), {{0.0,0.0,0.0},{0.0,0.0,0.75}}), "case 105 values")
end
do -- case 106: uint64(2, 1, 3) multiply bool(1, 4, 1)
  local a=np.array({{{4,1,4}},{{2,2,2}}}, "uint64")
  local b=np.array({{{false},{false},{false},{true}}}, "bool")
  local r=a * b
  assert(r.dtype=="uint64", "case 106 dtype "..r.dtype)
  assert(same(r:tolist(), {{{0,0,0},{0,0,0},{0,0,0},{4,1,4}},{{0,0,0},{0,0,0},{0,0,0},{2,2,2}}}), "case 106 values")
end
do -- case 107: int32(2, 1, 3) multiply float16(1, 4, 1)
  local a=np.array({{{-3,-3,1}},{{4,-3,3}}}, "int32")
  local b=np.array({{{-1.75},{-1.0},{-2.0},{-1.75}}}, "float16")
  local r=a * b
  assert(r.dtype=="float64", "case 107 dtype "..r.dtype)
  assert(same(r:tolist(), {{{5.25,5.25,-1.75},{3.0,3.0,-1.0},{6.0,6.0,-2.0},{5.25,5.25,-1.75}},{{-7.0,5.25,-5.25},{-4.0,3.0,-3.0},{-8.0,6.0,-6.0},{-7.0,5.25,-5.25}}}), "case 107 values")
end
do -- case 108: int16(2, 1, 2) multiply bool(1, 2, 2)
  local a=np.array({{{5,5}},{{1,1}}}, "int16")
  local b=np.array({{{false,false},{false,false}}}, "bool")
  local r=a * b
  assert(r.dtype=="int16", "case 108 dtype "..r.dtype)
  assert(same(r:tolist(), {{{0,0},{0,0}},{{0,0},{0,0}}}), "case 108 values")
end
do -- case 109: float32(2, 3) multiply uint32(3,)
  local a=np.array({{1.5,2.25,-0.5},{2.0,2.0,1.5}}, "float32")
  local b=np.array({1,2,3}, "uint32")
  local r=a * b
  assert(r.dtype=="float64", "case 109 dtype "..r.dtype)
  assert(same(r:tolist(), {{1.5,4.5,-1.5},{2.0,4.0,4.5}}), "case 109 values")
end
do -- case 110: float16(2, 1, 3) add float64(1, 4, 1)
  local a=np.array({{{1.75,0.25,-1.75}},{{1.0,-1.75,0.5}}}, "float16")
  local b=np.array({{{-2.25},{-1.0},{-2.0},{1.75}}}, "float64")
  local r=a + b
  assert(r.dtype=="float64", "case 110 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-0.5,-2.0,-4.0},{0.75,-0.75,-2.75},{-0.25,-1.75,-3.75},{3.5,2.0,0.0}},{{-1.25,-4.0,-1.75},{0.0,-2.75,-0.5},{-1.0,-3.75,-1.5},{2.75,0.0,2.25}}}), "case 110 values")
end
do -- case 111: float16(2, 3) add uint8(3,)
  local a=np.array({{1.5,-2.5,-0.5},{0.0,-2.0,-1.75}}, "float16")
  local b=np.array({3,1,5}, "uint8")
  local r=a + b
  assert(r.dtype=="float16", "case 111 dtype "..r.dtype)
  assert(same(r:tolist(), {{4.5,-1.5,4.5},{3.0,-1.0,3.25}}), "case 111 values")
end
do -- case 112: int32(2, 1, 2) multiply uint16(1, 2, 2)
  local a=np.array({{{-3,-5}},{{-1,-5}}}, "int32")
  local b=np.array({{{5,1},{1,3}}}, "uint16")
  local r=a * b
  assert(r.dtype=="int32", "case 112 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-15,-5},{-3,-15}},{{-5,-5},{-1,-15}}}), "case 112 values")
end
do -- case 113: uint8(2, 1, 2) multiply int16(1, 2, 2)
  local a=np.array({{{2,2}},{{3,4}}}, "uint8")
  local b=np.array({{{2,5},{3,-4}}}, "int16")
  local r=a * b
  assert(r.dtype=="int16", "case 113 dtype "..r.dtype)
  assert(same(r:tolist(), {{{4,10},{6,-8}},{{6,20},{9,-16}}}), "case 113 values")
end
do -- case 114: float32(2, 3) multiply float32(3,)
  local a=np.array({{-0.75,1.75,2.25},{2.5,-1.0,-1.0}}, "float32")
  local b=np.array({-0.5,-1.25,0.25}, "float32")
  local r=a * b
  assert(r.dtype=="float32", "case 114 dtype "..r.dtype)
  assert(same(r:tolist(), {{0.375,-2.1875,0.5625},{-1.25,1.25,-0.25}}), "case 114 values")
end
do -- case 115: int32(1, 3) multiply bool(2, 1)
  local a=np.array({{5,4,2}}, "int32")
  local b=np.array({{true},{false}}, "bool")
  local r=a * b
  assert(r.dtype=="int32", "case 115 dtype "..r.dtype)
  assert(same(r:tolist(), {{5,4,2},{0,0,0}}), "case 115 values")
end
do -- case 116: bool(2, 1, 2) multiply uint64(1, 2, 2)
  local a=np.array({{{true,true}},{{true,true}}}, "bool")
  local b=np.array({{{5,5},{4,1}}}, "uint64")
  local r=a * b
  assert(r.dtype=="uint64", "case 116 dtype "..r.dtype)
  assert(same(r:tolist(), {{{5,5},{4,1}},{{5,5},{4,1}}}), "case 116 values")
end
do -- case 117: uint8(1, 3) multiply float32(2, 1)
  local a=np.array({{0,0,2}}, "uint8")
  local b=np.array({{-2.25},{-0.75}}, "float32")
  local r=a * b
  assert(r.dtype=="float32", "case 117 dtype "..r.dtype)
  assert(same(r:tolist(), {{-0.0,-0.0,-4.5},{-0.0,-0.0,-1.5}}), "case 117 values")
end
do -- case 118: int16(2, 1, 2) multiply bool(1, 2, 2)
  local a=np.array({{{4,0}},{{0,3}}}, "int16")
  local b=np.array({{{true,true},{true,true}}}, "bool")
  local r=a * b
  assert(r.dtype=="int16", "case 118 dtype "..r.dtype)
  assert(same(r:tolist(), {{{4,0},{4,0}},{{0,3},{0,3}}}), "case 118 values")
end
do -- case 119: float64(2, 1, 3) multiply uint8(1, 4, 1)
  local a=np.array({{{1.25,1.25,1.75}},{{2.25,-2.0,-2.0}}}, "float64")
  local b=np.array({{{4},{1},{5},{5}}}, "uint8")
  local r=a * b
  assert(r.dtype=="float64", "case 119 dtype "..r.dtype)
  assert(same(r:tolist(), {{{5.0,5.0,7.0},{1.25,1.25,1.75},{6.25,6.25,8.75},{6.25,6.25,8.75}},{{9.0,-8.0,-8.0},{2.25,-2.0,-2.0},{11.25,-10.0,-10.0},{11.25,-10.0,-10.0}}}), "case 119 values")
end
do -- case 120: uint8(2, 3) multiply uint8(3,)
  local a=np.array({{2,5,1},{2,3,1}}, "uint8")
  local b=np.array({2,0,4}, "uint8")
  local r=a * b
  assert(r.dtype=="uint8", "case 120 dtype "..r.dtype)
  assert(same(r:tolist(), {{4,0,4},{4,0,4}}), "case 120 values")
end
do -- case 121: int16(2, 1, 2) multiply uint32(1, 2, 2)
  local a=np.array({{{5,2}},{{-3,-4}}}, "int16")
  local b=np.array({{{2,1},{0,3}}}, "uint32")
  local r=a * b
  assert(r.dtype=="int64", "case 121 dtype "..r.dtype)
  assert(same(r:tolist(), {{{10,2},{0,6}},{{-6,-4},{0,-12}}}), "case 121 values")
end
do -- case 122: bool(2, 3) multiply uint64(3,)
  local a=np.array({{true,false,true},{true,true,false}}, "bool")
  local b=np.array({0,3,1}, "uint64")
  local r=a * b
  assert(r.dtype=="uint64", "case 122 dtype "..r.dtype)
  assert(same(r:tolist(), {{0,0,1},{0,3,0}}), "case 122 values")
end
do -- case 123: float32(2, 1, 3) add int8(1, 4, 1)
  local a=np.array({{{-1.5,-2.25,0.75}},{{1.5,1.5,-1.25}}}, "float32")
  local b=np.array({{{1},{-1},{-1},{2}}}, "int8")
  local r=a + b
  assert(r.dtype=="float32", "case 123 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-0.5,-1.25,1.75},{-2.5,-3.25,-0.25},{-2.5,-3.25,-0.25},{0.5,-0.25,2.75}},{{2.5,2.5,-0.25},{0.5,0.5,-2.25},{0.5,0.5,-2.25},{3.5,3.5,0.75}}}), "case 123 values")
end
do -- case 124: float32(2, 1, 2) multiply int32(1, 2, 2)
  local a=np.array({{{-0.75,2.0}},{{0.5,-2.5}}}, "float32")
  local b=np.array({{{-1,1},{5,1}}}, "int32")
  local r=a * b
  assert(r.dtype=="float64", "case 124 dtype "..r.dtype)
  assert(same(r:tolist(), {{{0.75,2.0},{-3.75,2.0}},{{-0.5,-2.5},{2.5,-2.5}}}), "case 124 values")
end
do -- case 125: int32(1, 3) add bool(2, 1)
  local a=np.array({{3,4,-1}}, "int32")
  local b=np.array({{true},{false}}, "bool")
  local r=a + b
  assert(r.dtype=="int32", "case 125 dtype "..r.dtype)
  assert(same(r:tolist(), {{4,5,0},{3,4,-1}}), "case 125 values")
end
do -- case 126: uint64(2, 1, 3) multiply uint8(1, 4, 1)
  local a=np.array({{{2,1,2}},{{3,0,5}}}, "uint64")
  local b=np.array({{{5},{3},{1},{3}}}, "uint8")
  local r=a * b
  assert(r.dtype=="uint64", "case 126 dtype "..r.dtype)
  assert(same(r:tolist(), {{{10,5,10},{6,3,6},{2,1,2},{6,3,6}},{{15,0,25},{9,0,15},{3,0,5},{9,0,15}}}), "case 126 values")
end
do -- case 127: uint16(3,) add int16(3,)
  local a=np.array({4,1,5}, "uint16")
  local b=np.array({3,-2,3}, "int16")
  local r=a + b
  assert(r.dtype=="int32", "case 127 dtype "..r.dtype)
  assert(same(r:tolist(), {7,-1,8}), "case 127 values")
end
do -- case 128: int64(3,) add uint16(3,)
  local a=np.array({1,-3,5}, "int64")
  local b=np.array({1,1,2}, "uint16")
  local r=a + b
  assert(r.dtype=="int64", "case 128 dtype "..r.dtype)
  assert(same(r:tolist(), {2,-2,7}), "case 128 values")
end
do -- case 129: float32(1, 3) multiply float16(2, 1)
  local a=np.array({{1.5,1.5,2.0}}, "float32")
  local b=np.array({{0.0},{2.25}}, "float16")
  local r=a * b
  assert(r.dtype=="float32", "case 129 dtype "..r.dtype)
  assert(same(r:tolist(), {{0.0,0.0,0.0},{3.375,3.375,4.5}}), "case 129 values")
end
do -- case 130: float16(2, 3) add uint32(3,)
  local a=np.array({{-1.0,-1.75,-2.0},{1.5,-2.0,-2.5}}, "float16")
  local b=np.array({3,3,3}, "uint32")
  local r=a + b
  assert(r.dtype=="float64", "case 130 dtype "..r.dtype)
  assert(same(r:tolist(), {{2.0,1.25,1.0},{4.5,1.0,0.5}}), "case 130 values")
end
do -- case 131: int32(2, 3) add int32(3,)
  local a=np.array({{-5,2,-1},{0,-4,4}}, "int32")
  local b=np.array({-1,-5,2}, "int32")
  local r=a + b
  assert(r.dtype=="int32", "case 131 dtype "..r.dtype)
  assert(same(r:tolist(), {{-6,-3,1},{-1,-9,6}}), "case 131 values")
end
do -- case 132: uint32(2, 3) add int64(3,)
  local a=np.array({{0,0,2},{5,1,4}}, "uint32")
  local b=np.array({0,-3,4}, "int64")
  local r=a + b
  assert(r.dtype=="int64", "case 132 dtype "..r.dtype)
  assert(same(r:tolist(), {{0,-3,6},{5,-2,8}}), "case 132 values")
end
do -- case 133: float32(2, 3) add int8(3,)
  local a=np.array({{2.5,-0.5,2.0},{2.5,-0.75,1.25}}, "float32")
  local b=np.array({-5,-2,3}, "int8")
  local r=a + b
  assert(r.dtype=="float32", "case 133 dtype "..r.dtype)
  assert(same(r:tolist(), {{-2.5,-2.5,5.0},{-2.5,-2.75,4.25}}), "case 133 values")
end
do -- case 134: float32(3,) multiply int16(3,)
  local a=np.array({-0.75,-2.5,2.0}, "float32")
  local b=np.array({-1,5,-5}, "int16")
  local r=a * b
  assert(r.dtype=="float32", "case 134 dtype "..r.dtype)
  assert(same(r:tolist(), {0.75,-12.5,-10.0}), "case 134 values")
end
do -- case 135: float32(1, 3) multiply uint32(2, 1)
  local a=np.array({{-0.25,-0.5,-1.5}}, "float32")
  local b=np.array({{1},{4}}, "uint32")
  local r=a * b
  assert(r.dtype=="float64", "case 135 dtype "..r.dtype)
  assert(same(r:tolist(), {{-0.25,-0.5,-1.5},{-1.0,-2.0,-6.0}}), "case 135 values")
end
do -- case 136: int8(2, 1, 3) add int8(1, 4, 1)
  local a=np.array({{{-4,1,0}},{{-5,1,-2}}}, "int8")
  local b=np.array({{{1},{-4},{-3},{3}}}, "int8")
  local r=a + b
  assert(r.dtype=="int8", "case 136 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-3,2,1},{-8,-3,-4},{-7,-2,-3},{-1,4,3}},{{-4,2,-1},{-9,-3,-6},{-8,-2,-5},{-2,4,1}}}), "case 136 values")
end
do -- case 137: bool(2, 3) add int32(3,)
  local a=np.array({{false,false,false},{false,false,false}}, "bool")
  local b=np.array({-3,4,-1}, "int32")
  local r=a + b
  assert(r.dtype=="int32", "case 137 dtype "..r.dtype)
  assert(same(r:tolist(), {{-3,4,-1},{-3,4,-1}}), "case 137 values")
end
do -- case 138: float32(2, 1, 2) add uint16(1, 2, 2)
  local a=np.array({{{-1.5,1.75}},{{2.5,2.25}}}, "float32")
  local b=np.array({{{3,4},{3,3}}}, "uint16")
  local r=a + b
  assert(r.dtype=="float32", "case 138 dtype "..r.dtype)
  assert(same(r:tolist(), {{{1.5,5.75},{1.5,4.75}},{{5.5,6.25},{5.5,5.25}}}), "case 138 values")
end
do -- case 139: float64(3,) add int8(3,)
  local a=np.array({0.5,1.25,-0.5}, "float64")
  local b=np.array({-2,5,5}, "int8")
  local r=a + b
  assert(r.dtype=="float64", "case 139 dtype "..r.dtype)
  assert(same(r:tolist(), {-1.5,6.25,4.5}), "case 139 values")
end
do -- case 140: uint16(3,) add float32(3,)
  local a=np.array({5,3,4}, "uint16")
  local b=np.array({-1.75,-0.5,1.75}, "float32")
  local r=a + b
  assert(r.dtype=="float32", "case 140 dtype "..r.dtype)
  assert(same(r:tolist(), {3.25,2.5,5.75}), "case 140 values")
end
do -- case 141: uint16(2, 1, 2) multiply uint32(1, 2, 2)
  local a=np.array({{{2,0}},{{4,0}}}, "uint16")
  local b=np.array({{{2,5},{0,4}}}, "uint32")
  local r=a * b
  assert(r.dtype=="uint32", "case 141 dtype "..r.dtype)
  assert(same(r:tolist(), {{{4,0},{0,0}},{{8,0},{0,0}}}), "case 141 values")
end
do -- case 142: bool(2, 3) add uint64(3,)
  local a=np.array({{false,true,true},{false,true,true}}, "bool")
  local b=np.array({0,4,3}, "uint64")
  local r=a + b
  assert(r.dtype=="uint64", "case 142 dtype "..r.dtype)
  assert(same(r:tolist(), {{0,5,4},{0,5,4}}), "case 142 values")
end
do -- case 143: float64(2, 1, 2) add int8(1, 2, 2)
  local a=np.array({{{1.5,1.0}},{{1.0,-0.75}}}, "float64")
  local b=np.array({{{-1,-1},{3,0}}}, "int8")
  local r=a + b
  assert(r.dtype=="float64", "case 143 dtype "..r.dtype)
  assert(same(r:tolist(), {{{0.5,0.0},{4.5,1.0}},{{0.0,-1.75},{4.0,-0.75}}}), "case 143 values")
end
do -- case 144: float16(1, 3) add int8(2, 1)
  local a=np.array({{0.5,-0.25,0.25}}, "float16")
  local b=np.array({{-5},{0}}, "int8")
  local r=a + b
  assert(r.dtype=="float16", "case 144 dtype "..r.dtype)
  assert(same(r:tolist(), {{-4.5,-5.25,-4.75},{0.5,-0.25,0.25}}), "case 144 values")
end
do -- case 145: float32(2, 1, 3) multiply int16(1, 4, 1)
  local a=np.array({{{-1.0,-2.25,0.0}},{{2.25,-2.25,-0.75}}}, "float32")
  local b=np.array({{{5},{-3},{-1},{2}}}, "int16")
  local r=a * b
  assert(r.dtype=="float32", "case 145 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-5.0,-11.25,0.0},{3.0,6.75,-0.0},{1.0,2.25,-0.0},{-2.0,-4.5,0.0}},{{11.25,-11.25,-3.75},{-6.75,6.75,2.25},{-2.25,2.25,0.75},{4.5,-4.5,-1.5}}}), "case 145 values")
end
do -- case 146: int8(1, 3) multiply uint8(2, 1)
  local a=np.array({{-4,1,0}}, "int8")
  local b=np.array({{2},{3}}, "uint8")
  local r=a * b
  assert(r.dtype=="int16", "case 146 dtype "..r.dtype)
  assert(same(r:tolist(), {{-8,2,0},{-12,3,0}}), "case 146 values")
end
do -- case 147: float32(2, 1, 3) add uint8(1, 4, 1)
  local a=np.array({{{2.25,-0.5,2.0}},{{-1.0,0.75,-1.5}}}, "float32")
  local b=np.array({{{2},{4},{2},{2}}}, "uint8")
  local r=a + b
  assert(r.dtype=="float32", "case 147 dtype "..r.dtype)
  assert(same(r:tolist(), {{{4.25,1.5,4.0},{6.25,3.5,6.0},{4.25,1.5,4.0},{4.25,1.5,4.0}},{{1.0,2.75,0.5},{3.0,4.75,2.5},{1.0,2.75,0.5},{1.0,2.75,0.5}}}), "case 147 values")
end
do -- case 148: int8(2, 1, 3) multiply int16(1, 4, 1)
  local a=np.array({{{-4,-3,-4}},{{5,-4,4}}}, "int8")
  local b=np.array({{{-1},{5},{-1},{-4}}}, "int16")
  local r=a * b
  assert(r.dtype=="int16", "case 148 dtype "..r.dtype)
  assert(same(r:tolist(), {{{4,3,4},{-20,-15,-20},{4,3,4},{16,12,16}},{{-5,4,-4},{25,-20,20},{-5,4,-4},{-20,16,-16}}}), "case 148 values")
end
do -- case 149: float32(1, 3) add int16(2, 1)
  local a=np.array({{0.0,1.5,0.75}}, "float32")
  local b=np.array({{3},{-3}}, "int16")
  local r=a + b
  assert(r.dtype=="float32", "case 149 dtype "..r.dtype)
  assert(same(r:tolist(), {{3.0,4.5,3.75},{-3.0,-1.5,-2.25}}), "case 149 values")
end
do -- case 150: float32(3,) add uint8(3,)
  local a=np.array({-1.25,1.0,-0.75}, "float32")
  local b=np.array({1,2,2}, "uint8")
  local r=a + b
  assert(r.dtype=="float32", "case 150 dtype "..r.dtype)
  assert(same(r:tolist(), {-0.25,3.0,1.25}), "case 150 values")
end
do -- case 151: uint64(2, 1, 2) add float16(1, 2, 2)
  local a=np.array({{{4,4}},{{5,2}}}, "uint64")
  local b=np.array({{{2.25,1.25},{-1.25,-1.75}}}, "float16")
  local r=a + b
  assert(r.dtype=="float64", "case 151 dtype "..r.dtype)
  assert(same(r:tolist(), {{{6.25,5.25},{2.75,2.25}},{{7.25,3.25},{3.75,0.25}}}), "case 151 values")
end
do -- case 152: int16(2, 1, 2) add uint8(1, 2, 2)
  local a=np.array({{{0,2}},{{5,1}}}, "int16")
  local b=np.array({{{5,3},{4,3}}}, "uint8")
  local r=a + b
  assert(r.dtype=="int16", "case 152 dtype "..r.dtype)
  assert(same(r:tolist(), {{{5,5},{4,5}},{{10,4},{9,4}}}), "case 152 values")
end
do -- case 153: float16(2, 1, 3) multiply int32(1, 4, 1)
  local a=np.array({{{0.5,1.25,-1.25}},{{-0.25,-2.0,-2.25}}}, "float16")
  local b=np.array({{{-5},{2},{0},{4}}}, "int32")
  local r=a * b
  assert(r.dtype=="float64", "case 153 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-2.5,-6.25,6.25},{1.0,2.5,-2.5},{0.0,0.0,-0.0},{2.0,5.0,-5.0}},{{1.25,10.0,11.25},{-0.5,-4.0,-4.5},{-0.0,-0.0,-0.0},{-1.0,-8.0,-9.0}}}), "case 153 values")
end
do -- case 154: int8(3,) multiply float16(3,)
  local a=np.array({-3,-4,-4}, "int8")
  local b=np.array({1.25,2.0,-0.5}, "float16")
  local r=a * b
  assert(r.dtype=="float16", "case 154 dtype "..r.dtype)
  assert(same(r:tolist(), {-3.75,-8.0,2.0}), "case 154 values")
end
do -- case 155: uint8(2, 3) multiply bool(3,)
  local a=np.array({{4,0,1},{1,3,2}}, "uint8")
  local b=np.array({true,false,true}, "bool")
  local r=a * b
  assert(r.dtype=="uint8", "case 155 dtype "..r.dtype)
  assert(same(r:tolist(), {{4,0,1},{1,0,2}}), "case 155 values")
end
do -- case 156: float16(2, 1, 2) add uint16(1, 2, 2)
  local a=np.array({{{1.75,1.25}},{{0.75,-0.25}}}, "float16")
  local b=np.array({{{3,2},{3,1}}}, "uint16")
  local r=a + b
  assert(r.dtype=="float32", "case 156 dtype "..r.dtype)
  assert(same(r:tolist(), {{{4.75,3.25},{4.75,2.25}},{{3.75,1.75},{3.75,0.75}}}), "case 156 values")
end
do -- case 157: int64(3,) add uint64(3,)
  local a=np.array({-5,-1,2}, "int64")
  local b=np.array({0,1,1}, "uint64")
  local r=a + b
  assert(r.dtype=="float64", "case 157 dtype "..r.dtype)
  assert(same(r:tolist(), {-5.0,0.0,3.0}), "case 157 values")
end
do -- case 158: uint64(2, 1, 3) add int32(1, 4, 1)
  local a=np.array({{{5,5,0}},{{0,0,4}}}, "uint64")
  local b=np.array({{{-4},{0},{5},{1}}}, "int32")
  local r=a + b
  assert(r.dtype=="float64", "case 158 dtype "..r.dtype)
  assert(same(r:tolist(), {{{1.0,1.0,-4.0},{5.0,5.0,0.0},{10.0,10.0,5.0},{6.0,6.0,1.0}},{{-4.0,-4.0,0.0},{0.0,0.0,4.0},{5.0,5.0,9.0},{1.0,1.0,5.0}}}), "case 158 values")
end
do -- case 159: uint32(2, 1, 3) add float64(1, 4, 1)
  local a=np.array({{{0,5,1}},{{3,4,3}}}, "uint32")
  local b=np.array({{{-0.75},{2.5},{-2.5},{-2.0}}}, "float64")
  local r=a + b
  assert(r.dtype=="float64", "case 159 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-0.75,4.25,0.25},{2.5,7.5,3.5},{-2.5,2.5,-1.5},{-2.0,3.0,-1.0}},{{2.25,3.25,2.25},{5.5,6.5,5.5},{0.5,1.5,0.5},{1.0,2.0,1.0}}}), "case 159 values")
end
do -- case 160: int8(3,) multiply float64(3,)
  local a=np.array({4,5,-3}, "int8")
  local b=np.array({1.75,0.25,-0.5}, "float64")
  local r=a * b
  assert(r.dtype=="float64", "case 160 dtype "..r.dtype)
  assert(same(r:tolist(), {7.0,1.25,1.5}), "case 160 values")
end
do -- case 161: int32(3,) add int64(3,)
  local a=np.array({3,0,-4}, "int32")
  local b=np.array({-1,0,4}, "int64")
  local r=a + b
  assert(r.dtype=="int64", "case 161 dtype "..r.dtype)
  assert(same(r:tolist(), {2,0,0}), "case 161 values")
end
do -- case 162: float16(2, 1, 2) add bool(1, 2, 2)
  local a=np.array({{{1.25,0.25}},{{2.0,2.0}}}, "float16")
  local b=np.array({{{true,true},{true,false}}}, "bool")
  local r=a + b
  assert(r.dtype=="float16", "case 162 dtype "..r.dtype)
  assert(same(r:tolist(), {{{2.25,1.25},{2.25,0.25}},{{3.0,3.0},{3.0,2.0}}}), "case 162 values")
end
do -- case 163: float16(2, 1, 3) add bool(1, 4, 1)
  local a=np.array({{{1.25,2.25,0.75}},{{0.25,-1.25,0.5}}}, "float16")
  local b=np.array({{{true},{true},{true},{true}}}, "bool")
  local r=a + b
  assert(r.dtype=="float16", "case 163 dtype "..r.dtype)
  assert(same(r:tolist(), {{{2.25,3.25,1.75},{2.25,3.25,1.75},{2.25,3.25,1.75},{2.25,3.25,1.75}},{{1.25,-0.25,1.5},{1.25,-0.25,1.5},{1.25,-0.25,1.5},{1.25,-0.25,1.5}}}), "case 163 values")
end
do -- case 164: uint16(1, 3) add int16(2, 1)
  local a=np.array({{3,3,0}}, "uint16")
  local b=np.array({{2},{-2}}, "int16")
  local r=a + b
  assert(r.dtype=="int32", "case 164 dtype "..r.dtype)
  assert(same(r:tolist(), {{5,5,2},{1,1,-2}}), "case 164 values")
end
do -- case 165: int64(2, 3) add uint16(3,)
  local a=np.array({{-1,0,4},{-1,-3,0}}, "int64")
  local b=np.array({2,5,5}, "uint16")
  local r=a + b
  assert(r.dtype=="int64", "case 165 dtype "..r.dtype)
  assert(same(r:tolist(), {{1,5,9},{1,2,5}}), "case 165 values")
end
do -- case 166: bool(1, 3) multiply float16(2, 1)
  local a=np.array({{false,true,true}}, "bool")
  local b=np.array({{-2.5},{-2.0}}, "float16")
  local r=a * b
  assert(r.dtype=="float16", "case 166 dtype "..r.dtype)
  assert(same(r:tolist(), {{-0.0,-2.5,-2.5},{-0.0,-2.0,-2.0}}), "case 166 values")
end
do -- case 167: uint16(3,) multiply uint64(3,)
  local a=np.array({5,2,4}, "uint16")
  local b=np.array({3,0,2}, "uint64")
  local r=a * b
  assert(r.dtype=="uint64", "case 167 dtype "..r.dtype)
  assert(same(r:tolist(), {15,0,8}), "case 167 values")
end
do -- case 168: float32(1, 3) add float16(2, 1)
  local a=np.array({{0.25,-1.25,0.25}}, "float32")
  local b=np.array({{0.0},{1.0}}, "float16")
  local r=a + b
  assert(r.dtype=="float32", "case 168 dtype "..r.dtype)
  assert(same(r:tolist(), {{0.25,-1.25,0.25},{1.25,-0.25,1.25}}), "case 168 values")
end
do -- case 169: int32(3,) add bool(3,)
  local a=np.array({0,-1,2}, "int32")
  local b=np.array({false,true,false}, "bool")
  local r=a + b
  assert(r.dtype=="int32", "case 169 dtype "..r.dtype)
  assert(same(r:tolist(), {0,0,2}), "case 169 values")
end
do -- case 170: float32(1, 3) add uint8(2, 1)
  local a=np.array({{-1.5,1.0,0.25}}, "float32")
  local b=np.array({{5},{4}}, "uint8")
  local r=a + b
  assert(r.dtype=="float32", "case 170 dtype "..r.dtype)
  assert(same(r:tolist(), {{3.5,6.0,5.25},{2.5,5.0,4.25}}), "case 170 values")
end
do -- case 171: int8(3,) multiply float16(3,)
  local a=np.array({1,0,4}, "int8")
  local b=np.array({-1.75,-1.75,0.0}, "float16")
  local r=a * b
  assert(r.dtype=="float16", "case 171 dtype "..r.dtype)
  assert(same(r:tolist(), {-1.75,-0.0,0.0}), "case 171 values")
end
do -- case 172: int32(3,) add float16(3,)
  local a=np.array({-1,1,-1}, "int32")
  local b=np.array({-1.0,0.0,0.5}, "float16")
  local r=a + b
  assert(r.dtype=="float64", "case 172 dtype "..r.dtype)
  assert(same(r:tolist(), {-2.0,1.0,-0.5}), "case 172 values")
end
do -- case 173: bool(2, 1, 2) multiply int16(1, 2, 2)
  local a=np.array({{{false,true}},{{false,false}}}, "bool")
  local b=np.array({{{-4,-2},{3,5}}}, "int16")
  local r=a * b
  assert(r.dtype=="int16", "case 173 dtype "..r.dtype)
  assert(same(r:tolist(), {{{0,-2},{0,5}},{{0,0},{0,0}}}), "case 173 values")
end
do -- case 174: int32(2, 3) multiply int8(3,)
  local a=np.array({{4,1,4},{-2,4,1}}, "int32")
  local b=np.array({5,5,-2}, "int8")
  local r=a * b
  assert(r.dtype=="int32", "case 174 dtype "..r.dtype)
  assert(same(r:tolist(), {{20,5,-8},{-10,20,-2}}), "case 174 values")
end
do -- case 175: uint64(2, 1, 2) multiply uint32(1, 2, 2)
  local a=np.array({{{0,3}},{{5,0}}}, "uint64")
  local b=np.array({{{2,5},{1,2}}}, "uint32")
  local r=a * b
  assert(r.dtype=="uint64", "case 175 dtype "..r.dtype)
  assert(same(r:tolist(), {{{0,15},{0,6}},{{10,0},{5,0}}}), "case 175 values")
end
do -- case 176: int32(2, 3) multiply float16(3,)
  local a=np.array({{-2,3,-4},{2,0,1}}, "int32")
  local b=np.array({-0.75,0.5,1.75}, "float16")
  local r=a * b
  assert(r.dtype=="float64", "case 176 dtype "..r.dtype)
  assert(same(r:tolist(), {{1.5,1.5,-7.0},{-1.5,0.0,1.75}}), "case 176 values")
end
do -- case 177: float64(1, 3) add int64(2, 1)
  local a=np.array({{-2.5,-1.25,-2.5}}, "float64")
  local b=np.array({{-2},{2}}, "int64")
  local r=a + b
  assert(r.dtype=="float64", "case 177 dtype "..r.dtype)
  assert(same(r:tolist(), {{-4.5,-3.25,-4.5},{-0.5,0.75,-0.5}}), "case 177 values")
end
do -- case 178: int8(2, 1, 3) add uint64(1, 4, 1)
  local a=np.array({{{2,-1,4}},{{4,5,-5}}}, "int8")
  local b=np.array({{{4},{0},{3},{5}}}, "uint64")
  local r=a + b
  assert(r.dtype=="float64", "case 178 dtype "..r.dtype)
  assert(same(r:tolist(), {{{6.0,3.0,8.0},{2.0,-1.0,4.0},{5.0,2.0,7.0},{7.0,4.0,9.0}},{{8.0,9.0,-1.0},{4.0,5.0,-5.0},{7.0,8.0,-2.0},{9.0,10.0,0.0}}}), "case 178 values")
end
do -- case 179: uint32(2, 3) add int8(3,)
  local a=np.array({{0,4,0},{5,4,2}}, "uint32")
  local b=np.array({-4,5,-4}, "int8")
  local r=a + b
  assert(r.dtype=="int64", "case 179 dtype "..r.dtype)
  assert(same(r:tolist(), {{-4,9,-4},{1,9,-2}}), "case 179 values")
end
do -- case 180: uint32(3,) multiply float16(3,)
  local a=np.array({0,5,5}, "uint32")
  local b=np.array({-1.25,1.75,-2.5}, "float16")
  local r=a * b
  assert(r.dtype=="float64", "case 180 dtype "..r.dtype)
  assert(same(r:tolist(), {-0.0,8.75,-12.5}), "case 180 values")
end
do -- case 181: int8(2, 1, 3) multiply int64(1, 4, 1)
  local a=np.array({{{3,-3,5}},{{-1,5,-5}}}, "int8")
  local b=np.array({{{5},{-2},{-1},{5}}}, "int64")
  local r=a * b
  assert(r.dtype=="int64", "case 181 dtype "..r.dtype)
  assert(same(r:tolist(), {{{15,-15,25},{-6,6,-10},{-3,3,-5},{15,-15,25}},{{-5,25,-25},{2,-10,10},{1,-5,5},{-5,25,-25}}}), "case 181 values")
end
do -- case 182: uint32(2, 1, 2) add int64(1, 2, 2)
  local a=np.array({{{3,2}},{{2,0}}}, "uint32")
  local b=np.array({{{-1,1},{1,-3}}}, "int64")
  local r=a + b
  assert(r.dtype=="int64", "case 182 dtype "..r.dtype)
  assert(same(r:tolist(), {{{2,3},{4,-1}},{{1,1},{3,-3}}}), "case 182 values")
end
do -- case 183: bool(2, 3) multiply int32(3,)
  local a=np.array({{true,true,true},{false,false,true}}, "bool")
  local b=np.array({2,5,3}, "int32")
  local r=a * b
  assert(r.dtype=="int32", "case 183 dtype "..r.dtype)
  assert(same(r:tolist(), {{2,5,3},{0,0,3}}), "case 183 values")
end
do -- case 184: float32(3,) multiply int64(3,)
  local a=np.array({-1.25,1.5,-0.75}, "float32")
  local b=np.array({2,4,-2}, "int64")
  local r=a * b
  assert(r.dtype=="float64", "case 184 dtype "..r.dtype)
  assert(same(r:tolist(), {-2.5,6.0,1.5}), "case 184 values")
end
do -- case 185: float32(2, 1, 2) multiply float64(1, 2, 2)
  local a=np.array({{{-0.25,-2.5}},{{2.0,1.25}}}, "float32")
  local b=np.array({{{1.75,-1.75},{-2.5,1.75}}}, "float64")
  local r=a * b
  assert(r.dtype=="float64", "case 185 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-0.4375,4.375},{0.625,-4.375}},{{3.5,-2.1875},{-5.0,2.1875}}}), "case 185 values")
end
do -- case 186: uint32(2, 1, 2) multiply float64(1, 2, 2)
  local a=np.array({{{1,1}},{{4,0}}}, "uint32")
  local b=np.array({{{0.5,0.25},{-0.25,1.0}}}, "float64")
  local r=a * b
  assert(r.dtype=="float64", "case 186 dtype "..r.dtype)
  assert(same(r:tolist(), {{{0.5,0.25},{-0.25,1.0}},{{2.0,0.0},{-1.0,0.0}}}), "case 186 values")
end
do -- case 187: uint32(3,) multiply bool(3,)
  local a=np.array({2,2,3}, "uint32")
  local b=np.array({false,false,true}, "bool")
  local r=a * b
  assert(r.dtype=="uint32", "case 187 dtype "..r.dtype)
  assert(same(r:tolist(), {0,0,3}), "case 187 values")
end
do -- case 188: uint16(2, 1, 3) add uint64(1, 4, 1)
  local a=np.array({{{2,3,4}},{{1,5,5}}}, "uint16")
  local b=np.array({{{1},{0},{1},{2}}}, "uint64")
  local r=a + b
  assert(r.dtype=="uint64", "case 188 dtype "..r.dtype)
  assert(same(r:tolist(), {{{3,4,5},{2,3,4},{3,4,5},{4,5,6}},{{2,6,6},{1,5,5},{2,6,6},{3,7,7}}}), "case 188 values")
end
do -- case 189: uint64(2, 3) add int8(3,)
  local a=np.array({{2,2,0},{0,2,4}}, "uint64")
  local b=np.array({0,3,2}, "int8")
  local r=a + b
  assert(r.dtype=="float64", "case 189 dtype "..r.dtype)
  assert(same(r:tolist(), {{2.0,5.0,2.0},{0.0,5.0,6.0}}), "case 189 values")
end
do -- case 190: bool(2, 1, 3) multiply int8(1, 4, 1)
  local a=np.array({{{false,true,true}},{{false,false,true}}}, "bool")
  local b=np.array({{{-1},{5},{-5},{-1}}}, "int8")
  local r=a * b
  assert(r.dtype=="int8", "case 190 dtype "..r.dtype)
  assert(same(r:tolist(), {{{0,-1,-1},{0,5,5},{0,-5,-5},{0,-1,-1}},{{0,0,-1},{0,0,5},{0,0,-5},{0,0,-1}}}), "case 190 values")
end
do -- case 191: bool(2, 3) add uint32(3,)
  local a=np.array({{true,false,false},{true,true,true}}, "bool")
  local b=np.array({1,0,0}, "uint32")
  local r=a + b
  assert(r.dtype=="uint32", "case 191 dtype "..r.dtype)
  assert(same(r:tolist(), {{2,0,0},{2,1,1}}), "case 191 values")
end
do -- case 192: bool(1, 3) multiply int64(2, 1)
  local a=np.array({{true,true,true}}, "bool")
  local b=np.array({{5},{1}}, "int64")
  local r=a * b
  assert(r.dtype=="int64", "case 192 dtype "..r.dtype)
  assert(same(r:tolist(), {{5,5,5},{1,1,1}}), "case 192 values")
end
do -- case 193: int16(2, 1, 3) multiply float16(1, 4, 1)
  local a=np.array({{{1,0,-5}},{{5,-1,3}}}, "int16")
  local b=np.array({{{0.75},{-1.5},{0.75},{-2.0}}}, "float16")
  local r=a * b
  assert(r.dtype=="float32", "case 193 dtype "..r.dtype)
  assert(same(r:tolist(), {{{0.75,0.0,-3.75},{-1.5,-0.0,7.5},{0.75,0.0,-3.75},{-2.0,-0.0,10.0}},{{3.75,-0.75,2.25},{-7.5,1.5,-4.5},{3.75,-0.75,2.25},{-10.0,2.0,-6.0}}}), "case 193 values")
end
do -- case 194: int8(2, 1, 2) multiply float16(1, 2, 2)
  local a=np.array({{{-3,-3}},{{5,3}}}, "int8")
  local b=np.array({{{-2.25,0.75},{2.5,-1.0}}}, "float16")
  local r=a * b
  assert(r.dtype=="float16", "case 194 dtype "..r.dtype)
  assert(same(r:tolist(), {{{6.75,-2.25},{-7.5,3.0}},{{-11.25,2.25},{12.5,-3.0}}}), "case 194 values")
end
do -- case 195: uint64(3,) multiply float16(3,)
  local a=np.array({0,5,5}, "uint64")
  local b=np.array({-2.25,-0.75,2.0}, "float16")
  local r=a * b
  assert(r.dtype=="float64", "case 195 dtype "..r.dtype)
  assert(same(r:tolist(), {-0.0,-3.75,10.0}), "case 195 values")
end
do -- case 196: uint16(2, 1, 3) multiply int8(1, 4, 1)
  local a=np.array({{{1,2,0}},{{2,1,0}}}, "uint16")
  local b=np.array({{{2},{0},{-2},{4}}}, "int8")
  local r=a * b
  assert(r.dtype=="int32", "case 196 dtype "..r.dtype)
  assert(same(r:tolist(), {{{2,4,0},{0,0,0},{-2,-4,0},{4,8,0}},{{4,2,0},{0,0,0},{-4,-2,0},{8,4,0}}}), "case 196 values")
end
do -- case 197: uint64(3,) add uint16(3,)
  local a=np.array({2,4,2}, "uint64")
  local b=np.array({1,2,2}, "uint16")
  local r=a + b
  assert(r.dtype=="uint64", "case 197 dtype "..r.dtype)
  assert(same(r:tolist(), {3,6,4}), "case 197 values")
end
do -- case 198: bool(2, 3) add int8(3,)
  local a=np.array({{true,true,false},{false,true,false}}, "bool")
  local b=np.array({-3,3,3}, "int8")
  local r=a + b
  assert(r.dtype=="int8", "case 198 dtype "..r.dtype)
  assert(same(r:tolist(), {{-2,4,3},{-3,4,3}}), "case 198 values")
end
do -- case 199: float64(2, 1, 2) add float32(1, 2, 2)
  local a=np.array({{{-0.25,-1.25}},{{2.25,0.0}}}, "float64")
  local b=np.array({{{-0.25,2.0},{-0.25,1.0}}}, "float32")
  local r=a + b
  assert(r.dtype=="float64", "case 199 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-0.5,0.75},{-0.5,-0.25}},{{2.0,2.0},{2.0,1.0}}}), "case 199 values")
end
do -- case 200: float32(1, 3) multiply float64(2, 1)
  local a=np.array({{-0.5,-1.0,0.25}}, "float32")
  local b=np.array({{-2.25},{-0.5}}, "float64")
  local r=a * b
  assert(r.dtype=="float64", "case 200 dtype "..r.dtype)
  assert(same(r:tolist(), {{1.125,2.25,-0.5625},{0.25,0.5,-0.125}}), "case 200 values")
end
do -- case 201: float64(2, 1, 3) multiply int32(1, 4, 1)
  local a=np.array({{{-1.25,-1.0,1.0}},{{-1.25,-1.75,-0.25}}}, "float64")
  local b=np.array({{{5},{5},{0},{5}}}, "int32")
  local r=a * b
  assert(r.dtype=="float64", "case 201 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-6.25,-5.0,5.0},{-6.25,-5.0,5.0},{-0.0,-0.0,0.0},{-6.25,-5.0,5.0}},{{-6.25,-8.75,-1.25},{-6.25,-8.75,-1.25},{-0.0,-0.0,-0.0},{-6.25,-8.75,-1.25}}}), "case 201 values")
end
do -- case 202: uint16(2, 1, 2) multiply int16(1, 2, 2)
  local a=np.array({{{0,1}},{{3,1}}}, "uint16")
  local b=np.array({{{-1,-5},{2,5}}}, "int16")
  local r=a * b
  assert(r.dtype=="int32", "case 202 dtype "..r.dtype)
  assert(same(r:tolist(), {{{0,-5},{0,5}},{{-3,-5},{6,5}}}), "case 202 values")
end
do -- case 203: uint32(2, 1, 3) add int64(1, 4, 1)
  local a=np.array({{{2,4,1}},{{1,5,5}}}, "uint32")
  local b=np.array({{{5},{-1},{-1},{-2}}}, "int64")
  local r=a + b
  assert(r.dtype=="int64", "case 203 dtype "..r.dtype)
  assert(same(r:tolist(), {{{7,9,6},{1,3,0},{1,3,0},{0,2,-1}},{{6,10,10},{0,4,4},{0,4,4},{-1,3,3}}}), "case 203 values")
end
do -- case 204: bool(2, 1, 2) multiply float32(1, 2, 2)
  local a=np.array({{{true,false}},{{true,false}}}, "bool")
  local b=np.array({{{0.25,-1.0},{-1.25,-1.0}}}, "float32")
  local r=a * b
  assert(r.dtype=="float32", "case 204 dtype "..r.dtype)
  assert(same(r:tolist(), {{{0.25,-0.0},{-1.25,-0.0}},{{0.25,-0.0},{-1.25,-0.0}}}), "case 204 values")
end
do -- case 205: int32(2, 3) multiply float64(3,)
  local a=np.array({{-1,0,5},{0,1,-1}}, "int32")
  local b=np.array({-1.0,0.5,-1.5}, "float64")
  local r=a * b
  assert(r.dtype=="float64", "case 205 dtype "..r.dtype)
  assert(same(r:tolist(), {{1.0,0.0,-7.5},{-0.0,0.5,1.5}}), "case 205 values")
end
do -- case 206: float64(2, 1, 3) multiply uint8(1, 4, 1)
  local a=np.array({{{-2.0,0.75,-0.25}},{{1.25,-1.5,-2.0}}}, "float64")
  local b=np.array({{{4},{5},{5},{5}}}, "uint8")
  local r=a * b
  assert(r.dtype=="float64", "case 206 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-8.0,3.0,-1.0},{-10.0,3.75,-1.25},{-10.0,3.75,-1.25},{-10.0,3.75,-1.25}},{{5.0,-6.0,-8.0},{6.25,-7.5,-10.0},{6.25,-7.5,-10.0},{6.25,-7.5,-10.0}}}), "case 206 values")
end
do -- case 207: bool(2, 3) multiply uint16(3,)
  local a=np.array({{false,true,false},{false,true,false}}, "bool")
  local b=np.array({5,2,5}, "uint16")
  local r=a * b
  assert(r.dtype=="uint16", "case 207 dtype "..r.dtype)
  assert(same(r:tolist(), {{0,2,0},{0,2,0}}), "case 207 values")
end
do -- case 208: uint64(3,) add uint8(3,)
  local a=np.array({5,5,3}, "uint64")
  local b=np.array({3,0,3}, "uint8")
  local r=a + b
  assert(r.dtype=="uint64", "case 208 dtype "..r.dtype)
  assert(same(r:tolist(), {8,5,6}), "case 208 values")
end
do -- case 209: float32(3,) multiply float64(3,)
  local a=np.array({-2.5,2.25,1.5}, "float32")
  local b=np.array({-2.25,2.25,-1.25}, "float64")
  local r=a * b
  assert(r.dtype=="float64", "case 209 dtype "..r.dtype)
  assert(same(r:tolist(), {5.625,5.0625,-1.875}), "case 209 values")
end
do -- case 210: int64(1, 3) multiply uint64(2, 1)
  local a=np.array({{-2,0,2}}, "int64")
  local b=np.array({{5},{0}}, "uint64")
  local r=a * b
  assert(r.dtype=="float64", "case 210 dtype "..r.dtype)
  assert(same(r:tolist(), {{-10.0,0.0,10.0},{-0.0,0.0,0.0}}), "case 210 values")
end
do -- case 211: uint16(3,) add int64(3,)
  local a=np.array({2,4,1}, "uint16")
  local b=np.array({5,-1,-3}, "int64")
  local r=a + b
  assert(r.dtype=="int64", "case 211 dtype "..r.dtype)
  assert(same(r:tolist(), {7,3,-2}), "case 211 values")
end
do -- case 212: int64(2, 1, 3) add uint64(1, 4, 1)
  local a=np.array({{{-4,1,-5}},{{0,-5,2}}}, "int64")
  local b=np.array({{{0},{5},{2},{5}}}, "uint64")
  local r=a + b
  assert(r.dtype=="float64", "case 212 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-4.0,1.0,-5.0},{1.0,6.0,0.0},{-2.0,3.0,-3.0},{1.0,6.0,0.0}},{{0.0,-5.0,2.0},{5.0,0.0,7.0},{2.0,-3.0,4.0},{5.0,0.0,7.0}}}), "case 212 values")
end
do -- case 213: float16(2, 3) add uint64(3,)
  local a=np.array({{0.0,0.0,2.0},{1.5,1.5,0.0}}, "float16")
  local b=np.array({3,3,3}, "uint64")
  local r=a + b
  assert(r.dtype=="float64", "case 213 dtype "..r.dtype)
  assert(same(r:tolist(), {{3.0,3.0,5.0},{4.5,4.5,3.0}}), "case 213 values")
end
do -- case 214: int8(1, 3) multiply int8(2, 1)
  local a=np.array({{-1,5,-4}}, "int8")
  local b=np.array({{-1},{3}}, "int8")
  local r=a * b
  assert(r.dtype=="int8", "case 214 dtype "..r.dtype)
  assert(same(r:tolist(), {{1,-5,4},{-3,15,-12}}), "case 214 values")
end
do -- case 215: uint16(2, 1, 2) multiply uint16(1, 2, 2)
  local a=np.array({{{4,1}},{{1,3}}}, "uint16")
  local b=np.array({{{4,2},{4,5}}}, "uint16")
  local r=a * b
  assert(r.dtype=="uint16", "case 215 dtype "..r.dtype)
  assert(same(r:tolist(), {{{16,2},{16,5}},{{4,6},{4,15}}}), "case 215 values")
end
do -- case 216: int8(2, 1, 2) multiply uint64(1, 2, 2)
  local a=np.array({{{-5,1}},{{-2,0}}}, "int8")
  local b=np.array({{{5,4},{4,5}}}, "uint64")
  local r=a * b
  assert(r.dtype=="float64", "case 216 dtype "..r.dtype)
  assert(same(r:tolist(), {{{-25.0,4.0},{-20.0,5.0}},{{-10.0,0.0},{-8.0,0.0}}}), "case 216 values")
end
do -- case 217: int32(3,) add int32(3,)
  local a=np.array({4,1,1}, "int32")
  local b=np.array({3,-3,4}, "int32")
  local r=a + b
  assert(r.dtype=="int32", "case 217 dtype "..r.dtype)
  assert(same(r:tolist(), {7,-2,5}), "case 217 values")
end
do -- case 218: int64(2, 1, 2) multiply uint32(1, 2, 2)
  local a=np.array({{{0,-1}},{{-3,0}}}, "int64")
  local b=np.array({{{2,0},{5,3}}}, "uint32")
  local r=a * b
  assert(r.dtype=="int64", "case 218 dtype "..r.dtype)
  assert(same(r:tolist(), {{{0,0},{0,-3}},{{-6,0},{-15,0}}}), "case 218 values")
end
do -- case 219: uint32(2, 3) multiply int8(3,)
  local a=np.array({{4,5,5},{2,4,2}}, "uint32")
  local b=np.array({-2,2,1}, "int8")
  local r=a * b
  assert(r.dtype=="int64", "case 219 dtype "..r.dtype)
  assert(same(r:tolist(), {{-8,10,5},{-4,8,2}}), "case 219 values")
end
do -- case 220: uint64(2, 1, 3) multiply int32(1, 4, 1)
  local a=np.array({{{2,3,5}},{{1,0,5}}}, "uint64")
  local b=np.array({{{3},{2},{-2},{5}}}, "int32")
  local r=a * b
  assert(r.dtype=="float64", "case 220 dtype "..r.dtype)
  assert(same(r:tolist(), {{{6.0,9.0,15.0},{4.0,6.0,10.0},{-4.0,-6.0,-10.0},{10.0,15.0,25.0}},{{3.0,0.0,15.0},{2.0,0.0,10.0},{-2.0,-0.0,-10.0},{5.0,0.0,25.0}}}), "case 220 values")
end
do local a=np.array({1,2},"int8"); local r=a+2; assert(r.dtype=="int8" and same(r:tolist(),{3,4})) end
do local ok=pcall(function() return np.array({1},"int8")+200 end); assert(not ok) end
do local ok=pcall(function() return np.array({1},"uint8")+(-1) end); assert(not ok) end
do local r=np.array({1,2},"float32")+2.0; assert(r.dtype=="float32") end
do local r=np.array({1,2},"int32")+2.0; assert(r.dtype=="float64") end
print("differential tests: ok (220 array-array cases)")
