local np=require('luaray_core')

local function seqeq(a,b)
  if #a~=#b then return false end
  for i=1,#a do if a[i]~=b[i] then return false end end
  return true
end
local function veq(a,b)
  if type(a)=='table' then
    if type(b)~='table' or #a~=#b then return false end
    for i=1,#a do if not veq(a[i],b[i]) then return false end end
    return true
  end
  if type(b)~='number' and type(a)~='number' then return a==b end
  if type(a)~='number' or type(b)~='number' then return false end
  if a~=a and b~=b then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return a==b end
  local scale=math.max(1,math.abs(a),math.abs(b))
  return math.abs(a-b) <= 2e-6*scale
end

-- subtract array case 0
do
  local a=np.array({{-1,11,11},{11,-17,-1}},np.int32)
  local b=np.array({-7,5,5},np.int8)
  local r=np.subtract(a,b)
  assert(r.dtype=='int32','subtract 0 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 0 shape')
  assert(seqeq(r.strides,{12,4}),'subtract 0 strides')
  assert(veq(r:tolist(),{{6,6,6},{18,-22,-6}}),'subtract 0 values')
end
-- subtract array case 1
do
  local a=np.array({-23,23,-3,-17,5},np.int8)
  local b=np.array({-7,-7,-17,0,-3},np.int64)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 1 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 1 shape')
  assert(seqeq(r.strides,{8}),'subtract 1 strides')
  assert(veq(r:tolist(),{-16,30,14,-17,8}),'subtract 1 values')
end
-- subtract array case 2
do
  local a=np.array({{-0.5},{-7.5}},np.float16)
  local b=np.array({{11,0,-1}},np.int64)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 2 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 2 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 2 strides')
  assert(veq(r:tolist(),{{-11.5,-0.5,0.5},{-18.5,-7.5,-6.5}}),'subtract 2 values')
end
-- subtract array case 3
do
  local a=np.array({{{-0.5},{-7.5},{-7.5}},{{-3.25},{-7.5},{-7.5}}},np.float32)
  local b=np.array({{{true,false,true,true},{true,false,false,false},{true,true,false,false}}},np.bool)
  local r=np.subtract(a,b)
  assert(r.dtype=='float32','subtract 3 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 3 shape')
  assert(seqeq(r.strides,{48,16,4}),'subtract 3 strides')
  assert(veq(r:tolist(),{{{-1.5,-0.5,-1.5,-1.5},{-8.5,-7.5,-7.5,-7.5},{-8.5,-8.5,-7.5,-7.5}},{{-4.25,-3.25,-4.25,-4.25},{-8.5,-7.5,-7.5,-7.5},{-8.5,-8.5,-7.5,-7.5}}}),'subtract 3 values')
end
-- subtract array case 4
do
  local a=np.array({{-7.5},{7.75}},np.float32)
  local b=np.array({{false,true,true}},np.bool)
  local r=np.subtract(a,b)
  assert(r.dtype=='float32','subtract 4 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 4 shape')
  assert(seqeq(r.strides,{12,4}),'subtract 4 strides')
  assert(veq(r:tolist(),{{-7.5,-8.5,-8.5},{7.75,6.75,6.75}}),'subtract 4 values')
end
-- subtract array case 5
do
  local a=np.array({{12,4,7},{17,17,12}},np.uint64)
  local b=np.array({{-1.5,-3.25,1.25}},np.float64)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 5 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 5 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 5 strides')
  assert(veq(r:tolist(),{{13.5,7.25,5.75},{18.5,20.25,10.75}}),'subtract 5 values')
end
-- subtract array case 6
do
  local a=np.array({0,2,11,-23,1},np.int64)
  local b=np.array({11,11,23,7,14},np.uint16)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 6 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 6 shape')
  assert(seqeq(r.strides,{8}),'subtract 6 strides')
  assert(veq(r:tolist(),{-11,-9,-12,-30,-13}),'subtract 6 values')
end
-- subtract array case 7
do
  local a=np.array({{1,1,-17},{5,1,-23}},np.int16)
  local b=np.array({{0,20,4}},np.uint16)
  local r=np.subtract(a,b)
  assert(r.dtype=='int32','subtract 7 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 7 shape')
  assert(seqeq(r.strides,{12,4}),'subtract 7 strides')
  assert(veq(r:tolist(),{{1,-19,-21},{5,-19,-27}}),'subtract 7 values')
end
-- subtract array case 8
do
  local a=np.array({{15},{1}},np.uint64)
  local b=np.array({{11,-17,-3}},np.int8)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 8 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 8 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 8 strides')
  assert(veq(r:tolist(),{{4.0,32.0,18.0},{-10.0,18.0,4.0}}),'subtract 8 values')
end
-- subtract array case 9
do
  local a=np.array({{5},{-1}},np.int32)
  local b=np.array({{false,false,true}},np.bool)
  local r=np.subtract(a,b)
  assert(r.dtype=='int32','subtract 9 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 9 shape')
  assert(seqeq(r.strides,{12,4}),'subtract 9 strides')
  assert(veq(r:tolist(),{{5,5,4},{-1,-1,-2}}),'subtract 9 values')
end
-- subtract array case 10
do
  local a=np.array({{-7,23,-7},{23,5,0}},np.int8)
  local b=np.array({true,true,false},np.bool)
  local r=np.subtract(a,b)
  assert(r.dtype=='int8','subtract 10 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 10 shape')
  assert(seqeq(r.strides,{3,1}),'subtract 10 strides')
  assert(veq(r:tolist(),{{-8,22,-7},{22,4,0}}),'subtract 10 values')
end
-- subtract array case 11
do
  local a=np.array({{5,-23,-1},{-7,1,11}},np.int32)
  local b=np.array({{0,1,23}},np.uint64)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 11 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 11 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 11 strides')
  assert(veq(r:tolist(),{{5.0,-24.0,-24.0},{-7.0,0.0,-12.0}}),'subtract 11 values')
end
-- subtract array case 12
do
  local a=np.array({{7,2,3},{12,4,9}},np.uint64)
  local b=np.array({14,12,19},np.uint16)
  local r=np.subtract(a,b)
  assert(r.dtype=='uint64','subtract 12 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 12 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 12 strides')
  assert(veq(r:tolist(),{{18446744073709551609,18446744073709551606,18446744073709551600},{18446744073709551614,18446744073709551608,18446744073709551606}}),'subtract 12 values')
end
-- subtract array case 13
do
  local a=np.array({{{6},{19},{1}},{{1},{11},{3}}},np.uint8)
  local b=np.array({{{0.25,2.5,7.75,-1.5},{-1.5,0.25,2.5,-0.5},{0.25,-7.5,7.75,-3.25}}},np.float32)
  local r=np.subtract(a,b)
  assert(r.dtype=='float32','subtract 13 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 13 shape')
  assert(seqeq(r.strides,{48,16,4}),'subtract 13 strides')
  assert(veq(r:tolist(),{{{5.75,3.5,-1.75,7.5},{20.5,18.75,16.5,19.5},{0.75,8.5,-6.75,4.25}},{{0.75,-1.5,-6.75,2.5},{12.5,10.75,8.5,11.5},{2.75,10.5,-4.75,6.25}}}),'subtract 13 values')
end
-- subtract array case 14
do
  local a=np.array({-1,23,1,1,-1},np.int16)
  local b=np.array({0,23,2,1,0},np.int16)
  local r=np.subtract(a,b)
  assert(r.dtype=='int16','subtract 14 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 14 shape')
  assert(seqeq(r.strides,{2}),'subtract 14 strides')
  assert(veq(r:tolist(),{-1,0,-1,0,-1}),'subtract 14 values')
end
-- subtract array case 15
do
  local a=np.array({{21,16,22},{24,14,2}},np.uint16)
  local b=np.array({-1.5,1.25,-0.5},np.float16)
  local r=np.subtract(a,b)
  assert(r.dtype=='float32','subtract 15 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 15 shape')
  assert(seqeq(r.strides,{12,4}),'subtract 15 strides')
  assert(veq(r:tolist(),{{22.5,14.75,22.5},{25.5,12.75,2.5}}),'subtract 15 values')
end
-- subtract array case 16
do
  local a=np.array({{14,1,15},{2,17,4}},np.uint64)
  local b=np.array({-7.5,7.75,0.25},np.float16)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 16 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 16 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 16 strides')
  assert(veq(r:tolist(),{{21.5,-6.75,14.75},{9.5,9.25,3.75}}),'subtract 16 values')
end
-- subtract array case 17
do
  local a=np.array({{7},{15}},np.uint8)
  local b=np.array({{5,0,9}},np.uint64)
  local r=np.subtract(a,b)
  assert(r.dtype=='uint64','subtract 17 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 17 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 17 strides')
  assert(veq(r:tolist(),{{2,7,18446744073709551614},{10,15,6}}),'subtract 17 values')
end
-- subtract array case 18
do
  local a=np.array({-0.5,-7.5,2.5,0.25,-0.5},np.float32)
  local b=np.array({10,5,24,21,14},np.uint16)
  local r=np.subtract(a,b)
  assert(r.dtype=='float32','subtract 18 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 18 shape')
  assert(seqeq(r.strides,{4}),'subtract 18 strides')
  assert(veq(r:tolist(),{-10.5,-12.5,-21.5,-20.75,-14.5}),'subtract 18 values')
end
-- subtract array case 19
do
  local a=np.array({{17,6,3},{5,1,7}},np.uint16)
  local b=np.array({{2,-7,11}},np.int64)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 19 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 19 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 19 strides')
  assert(veq(r:tolist(),{{15,13,-8},{3,8,-4}}),'subtract 19 values')
end
-- subtract array case 20
do
  local a=np.array({{-0.5},{0.25}},np.float32)
  local b=np.array({{23,22,25}},np.uint64)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 20 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 20 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 20 strides')
  assert(veq(r:tolist(),{{-23.5,-22.5,-25.5},{-22.75,-21.75,-24.75}}),'subtract 20 values')
end
-- subtract array case 21
do
  local a=np.array({{{-3},{-1},{1}},{{-1},{-3},{-23}}},np.int8)
  local b=np.array({{{2,23,23,1},{-3,-1,-23,-17},{-23,2,-3,-1}}},np.int8)
  local r=np.subtract(a,b)
  assert(r.dtype=='int8','subtract 21 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 21 shape')
  assert(seqeq(r.strides,{12,4,1}),'subtract 21 strides')
  assert(veq(r:tolist(),{{{-5,-26,-26,-4},{2,0,22,16},{24,-1,4,2}},{{-3,-24,-24,-2},{0,-2,20,14},{0,-25,-20,-22}}}),'subtract 21 values')
end
-- subtract array case 22
do
  local a=np.array({22,13,6,12,15},np.uint16)
  local b=np.array({22,5,17,21,16},np.uint64)
  local r=np.subtract(a,b)
  assert(r.dtype=='uint64','subtract 22 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 22 shape')
  assert(seqeq(r.strides,{8}),'subtract 22 strides')
  assert(veq(r:tolist(),{0,8,18446744073709551605,18446744073709551607,18446744073709551615}),'subtract 22 values')
end
-- subtract array case 23
do
  local a=np.array({{1,5,2},{23,1,-3}},np.int8)
  local b=np.array({{0.25,7.75,7.75}},np.float16)
  local r=np.subtract(a,b)
  assert(r.dtype=='float16','subtract 23 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 23 shape')
  assert(seqeq(r.strides,{6,2}),'subtract 23 strides')
  assert(veq(r:tolist(),{{0.75,-2.75,-5.75},{22.75,-6.75,-10.75}}),'subtract 23 values')
end
-- subtract array case 24
do
  local a=np.array({{{24},{22},{16}},{{14},{22},{18}}},np.uint8)
  local b=np.array({{{2,2,-1,23},{2,5,23,-3},{-23,-7,1,1}}},np.int64)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 24 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 24 shape')
  assert(seqeq(r.strides,{96,32,8}),'subtract 24 strides')
  assert(veq(r:tolist(),{{{22,22,25,1},{20,17,-1,25},{39,23,15,15}},{{12,12,15,-9},{20,17,-1,25},{41,25,17,17}}}),'subtract 24 values')
end
-- subtract array case 25
do
  local a=np.array({{{24},{4},{1}},{{15},{13},{9}}},np.uint64)
  local b=np.array({{{12,2,3,16},{12,22,25,5},{25,8,21,7}}},np.uint32)
  local r=np.subtract(a,b)
  assert(r.dtype=='uint64','subtract 25 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 25 shape')
  assert(seqeq(r.strides,{96,32,8}),'subtract 25 strides')
  assert(veq(r:tolist(),{{{12,22,21,8},{18446744073709551608,18446744073709551598,18446744073709551595,18446744073709551615},{18446744073709551592,18446744073709551609,18446744073709551596,18446744073709551610}},{{3,13,12,18446744073709551615},{1,18446744073709551607,18446744073709551604,8},{18446744073709551600,1,18446744073709551604,2}}}),'subtract 25 values')
end
-- subtract array case 26
do
  local a=np.array({{{5},{-1},{-17}},{{-17},{0},{1}}},np.int8)
  local b=np.array({{{0.25,-7.5,7.75,-1.5},{-1.5,2.5,2.5,-7.5},{2.5,-3.25,2.5,2.5}}},np.float16)
  local r=np.subtract(a,b)
  assert(r.dtype=='float16','subtract 26 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 26 shape')
  assert(seqeq(r.strides,{24,8,2}),'subtract 26 strides')
  assert(veq(r:tolist(),{{{4.75,12.5,-2.75,6.5},{0.5,-3.5,-3.5,6.5},{-19.5,-13.75,-19.5,-19.5}},{{-17.25,-9.5,-24.75,-15.5},{1.5,-2.5,-2.5,7.5},{-1.5,4.25,-1.5,-1.5}}}),'subtract 26 values')
end
-- subtract array case 27
do
  local a=np.array({{-17,11,11},{-1,-1,-17}},np.int16)
  local b=np.array({1,0,-23},np.int32)
  local r=np.subtract(a,b)
  assert(r.dtype=='int32','subtract 27 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 27 shape')
  assert(seqeq(r.strides,{12,4}),'subtract 27 strides')
  assert(veq(r:tolist(),{{-18,11,34},{-2,-1,6}}),'subtract 27 values')
end
-- subtract array case 28
do
  local a=np.array({{false,true,false},{false,false,true}},np.bool)
  local b=np.array({{7,10,12}},np.uint16)
  local r=np.subtract(a,b)
  assert(r.dtype=='uint16','subtract 28 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 28 shape')
  assert(seqeq(r.strides,{6,2}),'subtract 28 strides')
  assert(veq(r:tolist(),{{65529,65527,65524},{65529,65526,65525}}),'subtract 28 values')
end
-- subtract array case 29
do
  local a=np.array({{22,19,20},{5,19,0}},np.uint64)
  local b=np.array({11,-23,2},np.int32)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 29 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 29 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 29 strides')
  assert(veq(r:tolist(),{{11.0,42.0,18.0},{-6.0,42.0,-2.0}}),'subtract 29 values')
end
-- subtract array case 30
do
  local a=np.array({2,-1,-7,1,-23},np.int32)
  local b=np.array({24,12,1,0,12},np.uint64)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 30 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 30 shape')
  assert(seqeq(r.strides,{8}),'subtract 30 strides')
  assert(veq(r:tolist(),{-22.0,-13.0,-8.0,1.0,-35.0}),'subtract 30 values')
end
-- subtract array case 31
do
  local a=np.array({-1.5,2.5,2.5,-1.5,-3.25},np.float64)
  local b=np.array({19,11,12,20,23},np.uint64)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 31 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 31 shape')
  assert(seqeq(r.strides,{8}),'subtract 31 strides')
  assert(veq(r:tolist(),{-20.5,-8.5,-9.5,-21.5,-26.25}),'subtract 31 values')
end
-- subtract array case 32
do
  local a=np.array({{23,23,25},{23,21,20}},np.uint16)
  local b=np.array({-3.25,-7.5,7.75},np.float16)
  local r=np.subtract(a,b)
  assert(r.dtype=='float32','subtract 32 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 32 shape')
  assert(seqeq(r.strides,{12,4}),'subtract 32 strides')
  assert(veq(r:tolist(),{{26.25,30.5,17.25},{26.25,28.5,12.25}}),'subtract 32 values')
end
-- subtract array case 33
do
  local a=np.array({{2.5},{-7.5}},np.float64)
  local b=np.array({{-7.5,-0.5,-7.5}},np.float32)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 33 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 33 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 33 strides')
  assert(veq(r:tolist(),{{10.0,3.0,10.0},{0.0,-7.0,0.0}}),'subtract 33 values')
end
-- subtract array case 34
do
  local a=np.array({{11,16,2},{12,22,22}},np.uint32)
  local b=np.array({{-7,5,-7}},np.int64)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 34 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 34 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 34 strides')
  assert(veq(r:tolist(),{{18,11,9},{19,17,29}}),'subtract 34 values')
end
-- subtract array case 35
do
  local a=np.array({{false,false,true},{true,false,false}},np.bool)
  local b=np.array({{0,-17,0}},np.int16)
  local r=np.subtract(a,b)
  assert(r.dtype=='int16','subtract 35 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 35 shape')
  assert(seqeq(r.strides,{6,2}),'subtract 35 strides')
  assert(veq(r:tolist(),{{0,17,1},{1,17,0}}),'subtract 35 values')
end
-- subtract array case 36
do
  local a=np.array({{-3,-17,-23},{1,11,2}},np.int16)
  local b=np.array({{1.25,-1.5,-3.25}},np.float16)
  local r=np.subtract(a,b)
  assert(r.dtype=='float32','subtract 36 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 36 shape')
  assert(seqeq(r.strides,{12,4}),'subtract 36 strides')
  assert(veq(r:tolist(),{{-4.25,-15.5,-19.75},{-0.25,12.5,5.25}}),'subtract 36 values')
end
-- subtract array case 37
do
  local a=np.array({{2,13,16},{16,8,8}},np.uint16)
  local b=np.array({true,true,false},np.bool)
  local r=np.subtract(a,b)
  assert(r.dtype=='uint16','subtract 37 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 37 shape')
  assert(seqeq(r.strides,{6,2}),'subtract 37 strides')
  assert(veq(r:tolist(),{{1,12,16},{15,7,8}}),'subtract 37 values')
end
-- subtract array case 38
do
  local a=np.array({{true},{false}},np.bool)
  local b=np.array({{7.75,7.75,-0.5}},np.float32)
  local r=np.subtract(a,b)
  assert(r.dtype=='float32','subtract 38 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 38 shape')
  assert(seqeq(r.strides,{12,4}),'subtract 38 strides')
  assert(veq(r:tolist(),{{-6.75,-6.75,1.5},{-7.75,-7.75,0.5}}),'subtract 38 values')
end
-- subtract array case 39
do
  local a=np.array({{-7.5,1.25,-0.5},{-1.5,2.5,-3.25}},np.float16)
  local b=np.array({false,false,false},np.bool)
  local r=np.subtract(a,b)
  assert(r.dtype=='float16','subtract 39 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 39 shape')
  assert(seqeq(r.strides,{6,2}),'subtract 39 strides')
  assert(veq(r:tolist(),{{-7.5,1.25,-0.5},{-1.5,2.5,-3.25}}),'subtract 39 values')
end
-- subtract array case 40
do
  local a=np.array({{2},{4}},np.uint64)
  local b=np.array({{6,2,25}},np.uint32)
  local r=np.subtract(a,b)
  assert(r.dtype=='uint64','subtract 40 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 40 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 40 strides')
  assert(veq(r:tolist(),{{18446744073709551612,0,18446744073709551593},{18446744073709551614,2,18446744073709551595}}),'subtract 40 values')
end
-- subtract array case 41
do
  local a=np.array({{{-23},{23},{1}},{{23},{1},{1}}},np.int32)
  local b=np.array({{{-7.5,0.25,-3.25,0.25},{-0.5,-0.5,-7.5,-0.5},{0.25,1.25,-7.5,-3.25}}},np.float16)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 41 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 41 shape')
  assert(seqeq(r.strides,{96,32,8}),'subtract 41 strides')
  assert(veq(r:tolist(),{{{-15.5,-23.25,-19.75,-23.25},{23.5,23.5,30.5,23.5},{0.75,-0.25,8.5,4.25}},{{30.5,22.75,26.25,22.75},{1.5,1.5,8.5,1.5},{0.75,-0.25,8.5,4.25}}}),'subtract 41 values')
end
-- subtract array case 42
do
  local a=np.array({true,false,true,false,false},np.bool)
  local b=np.array({-3,-3,5,-23,-7},np.int8)
  local r=np.subtract(a,b)
  assert(r.dtype=='int8','subtract 42 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 42 shape')
  assert(seqeq(r.strides,{1}),'subtract 42 strides')
  assert(veq(r:tolist(),{4,3,-4,23,7}),'subtract 42 values')
end
-- subtract array case 43
do
  local a=np.array({{21,21,7},{18,15,12}},np.uint16)
  local b=np.array({-17,5,5},np.int8)
  local r=np.subtract(a,b)
  assert(r.dtype=='int32','subtract 43 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 43 shape')
  assert(seqeq(r.strides,{12,4}),'subtract 43 strides')
  assert(veq(r:tolist(),{{38,16,2},{35,10,7}}),'subtract 43 values')
end
-- subtract array case 44
do
  local a=np.array({12,7,7,4,16},np.uint32)
  local b=np.array({7.75,-7.5,1.25,1.25,-0.5},np.float32)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 44 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 44 shape')
  assert(seqeq(r.strides,{8}),'subtract 44 strides')
  assert(veq(r:tolist(),{4.25,14.5,5.75,2.75,16.5}),'subtract 44 values')
end
-- subtract array case 45
do
  local a=np.array({-3,23,23,-17,-1},np.int32)
  local b=np.array({5,23,23,2,1},np.int64)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 45 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 45 shape')
  assert(seqeq(r.strides,{8}),'subtract 45 strides')
  assert(veq(r:tolist(),{-8,0,0,-19,-2}),'subtract 45 values')
end
-- subtract array case 46
do
  local a=np.array({{1,2,-1},{-3,0,11}},np.int32)
  local b=np.array({-1,0,-3},np.int32)
  local r=np.subtract(a,b)
  assert(r.dtype=='int32','subtract 46 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 46 shape')
  assert(seqeq(r.strides,{12,4}),'subtract 46 strides')
  assert(veq(r:tolist(),{{2,2,2},{-2,0,14}}),'subtract 46 values')
end
-- subtract array case 47
do
  local a=np.array({{{6},{17},{10}},{{17},{2},{15}}},np.uint16)
  local b=np.array({{{3,12,2,11},{18,1,16,20},{17,3,13,7}}},np.uint64)
  local r=np.subtract(a,b)
  assert(r.dtype=='uint64','subtract 47 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 47 shape')
  assert(seqeq(r.strides,{96,32,8}),'subtract 47 strides')
  assert(veq(r:tolist(),{{{3,18446744073709551610,4,18446744073709551611},{18446744073709551615,16,1,18446744073709551613},{18446744073709551609,7,18446744073709551613,3}},{{14,5,15,6},{18446744073709551600,1,18446744073709551602,18446744073709551598},{18446744073709551614,12,2,8}}}),'subtract 47 values')
end
-- subtract array case 48
do
  local a=np.array({{{6},{25},{15}},{{14},{24},{6}}},np.uint8)
  local b=np.array({{{-23,11,-3,11},{-23,1,5,2},{23,0,2,23}}},np.int8)
  local r=np.subtract(a,b)
  assert(r.dtype=='int16','subtract 48 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 48 shape')
  assert(seqeq(r.strides,{24,8,2}),'subtract 48 strides')
  assert(veq(r:tolist(),{{{29,-5,9,-5},{48,24,20,23},{-8,15,13,-8}},{{37,3,17,3},{47,23,19,22},{-17,6,4,-17}}}),'subtract 48 values')
end
-- subtract array case 49
do
  local a=np.array({{-7},{5}},np.int16)
  local b=np.array({{1.25,1.25,-0.5}},np.float64)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 49 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 49 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 49 strides')
  assert(veq(r:tolist(),{{-8.25,-8.25,-6.5},{3.75,3.75,5.5}}),'subtract 49 values')
end
-- subtract array case 50
do
  local a=np.array({{1.25},{0.25}},np.float64)
  local b=np.array({{2,-23,1}},np.int32)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 50 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 50 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 50 strides')
  assert(veq(r:tolist(),{{-0.75,24.25,0.25},{-1.75,23.25,-0.75}}),'subtract 50 values')
end
-- subtract array case 51
do
  local a=np.array({{true,false,true},{false,true,true}},np.bool)
  local b=np.array({2,13,12},np.uint16)
  local r=np.subtract(a,b)
  assert(r.dtype=='uint16','subtract 51 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 51 shape')
  assert(seqeq(r.strides,{6,2}),'subtract 51 strides')
  assert(veq(r:tolist(),{{65535,65523,65525},{65534,65524,65525}}),'subtract 51 values')
end
-- subtract array case 52
do
  local a=np.array({{1,-3,-7},{-1,5,-17}},np.int8)
  local b=np.array({{2.5,1.25,-1.5}},np.float16)
  local r=np.subtract(a,b)
  assert(r.dtype=='float16','subtract 52 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 52 shape')
  assert(seqeq(r.strides,{6,2}),'subtract 52 strides')
  assert(veq(r:tolist(),{{-1.5,-4.25,-5.5},{-3.5,3.75,-15.5}}),'subtract 52 values')
end
-- subtract array case 53
do
  local a=np.array({-7.5,7.75,-3.25,2.5,-3.25},np.float16)
  local b=np.array({22,2,8,7,6},np.uint8)
  local r=np.subtract(a,b)
  assert(r.dtype=='float16','subtract 53 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 53 shape')
  assert(seqeq(r.strides,{2}),'subtract 53 strides')
  assert(veq(r:tolist(),{-29.5,5.75,-11.25,-4.5,-9.25}),'subtract 53 values')
end
-- subtract array case 54
do
  local a=np.array({{{-3},{23},{2}},{{-3},{2},{1}}},np.int8)
  local b=np.array({{{-17,23,1,11},{23,11,1,11},{0,0,-1,-7}}},np.int32)
  local r=np.subtract(a,b)
  assert(r.dtype=='int32','subtract 54 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 54 shape')
  assert(seqeq(r.strides,{48,16,4}),'subtract 54 strides')
  assert(veq(r:tolist(),{{{14,-26,-4,-14},{0,12,22,12},{2,2,3,9}},{{14,-26,-4,-14},{-21,-9,1,-9},{1,1,2,8}}}),'subtract 54 values')
end
-- subtract array case 55
do
  local a=np.array({{21,25,25},{17,22,17}},np.uint32)
  local b=np.array({{-17,-7,-17}},np.int64)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 55 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 55 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 55 strides')
  assert(veq(r:tolist(),{{38,32,42},{34,29,34}}),'subtract 55 values')
end
-- subtract array case 56
do
  local a=np.array({{{5},{2},{23}},{{1},{-23},{1}}},np.int64)
  local b=np.array({{{23,-23,0,11},{0,11,5,2},{-17,-7,2,-3}}},np.int32)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 56 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 56 shape')
  assert(seqeq(r.strides,{96,32,8}),'subtract 56 strides')
  assert(veq(r:tolist(),{{{-18,28,5,-6},{2,-9,-3,0},{40,30,21,26}},{{-22,24,1,-10},{-23,-34,-28,-25},{18,8,-1,4}}}),'subtract 56 values')
end
-- subtract array case 57
do
  local a=np.array({5,5,14,6,19},np.uint32)
  local b=np.array({2,2,11,11,0},np.int64)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 57 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 57 shape')
  assert(seqeq(r.strides,{8}),'subtract 57 strides')
  assert(veq(r:tolist(),{3,3,3,-5,19}),'subtract 57 values')
end
-- subtract array case 58
do
  local a=np.array({{-7,11,-23},{5,-7,11}},np.int16)
  local b=np.array({17,20,16},np.uint64)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 58 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 58 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 58 strides')
  assert(veq(r:tolist(),{{-24.0,-9.0,-39.0},{-12.0,-27.0,-5.0}}),'subtract 58 values')
end
-- subtract array case 59
do
  local a=np.array({{true,true,true},{false,false,false}},np.bool)
  local b=np.array({1.25,-3.25,2.5},np.float64)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 59 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 59 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 59 strides')
  assert(veq(r:tolist(),{{-0.25,4.25,-1.5},{-1.25,3.25,-2.5}}),'subtract 59 values')
end
-- subtract array case 60
do
  local a=np.array({{-17},{-3}},np.int64)
  local b=np.array({{1,11,-1}},np.int16)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 60 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 60 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 60 strides')
  assert(veq(r:tolist(),{{-18,-28,-16},{-4,-14,-2}}),'subtract 60 values')
end
-- subtract array case 61
do
  local a=np.array({{11,1,0},{-17,5,5}},np.int8)
  local b=np.array({{22,2,3}},np.uint8)
  local r=np.subtract(a,b)
  assert(r.dtype=='int16','subtract 61 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 61 shape')
  assert(seqeq(r.strides,{6,2}),'subtract 61 strides')
  assert(veq(r:tolist(),{{-11,-1,-3},{-39,3,2}}),'subtract 61 values')
end
-- subtract array case 62
do
  local a=np.array({{-23,-3,2},{-7,-23,-3}},np.int64)
  local b=np.array({{23,23,23}},np.int32)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 62 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 62 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 62 strides')
  assert(veq(r:tolist(),{{-46,-26,-21},{-30,-46,-26}}),'subtract 62 values')
end
-- subtract array case 63
do
  local a=np.array({{12,0,12},{18,22,6}},np.uint32)
  local b=np.array({{11,15,18}},np.uint32)
  local r=np.subtract(a,b)
  assert(r.dtype=='uint32','subtract 63 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 63 shape')
  assert(seqeq(r.strides,{12,4}),'subtract 63 strides')
  assert(veq(r:tolist(),{{1,4294967281,4294967290},{7,7,4294967284}}),'subtract 63 values')
end
-- subtract array case 64
do
  local a=np.array({5,-7,-17,1,-7},np.int16)
  local b=np.array({true,true,true,true,true},np.bool)
  local r=np.subtract(a,b)
  assert(r.dtype=='int16','subtract 64 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 64 shape')
  assert(seqeq(r.strides,{2}),'subtract 64 strides')
  assert(veq(r:tolist(),{4,-8,-18,0,-8}),'subtract 64 values')
end
-- subtract array case 65
do
  local a=np.array({{{8},{4},{2}},{{3},{10},{19}}},np.uint16)
  local b=np.array({{{5,-17,23,11},{1,1,23,-7},{23,-7,2,5}}},np.int16)
  local r=np.subtract(a,b)
  assert(r.dtype=='int32','subtract 65 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 65 shape')
  assert(seqeq(r.strides,{48,16,4}),'subtract 65 strides')
  assert(veq(r:tolist(),{{{3,25,-15,-3},{3,3,-19,11},{-21,9,0,-3}},{{-2,20,-20,-8},{9,9,-13,17},{-4,26,17,14}}}),'subtract 65 values')
end
-- subtract array case 66
do
  local a=np.array({{{5},{23},{2}},{{-3},{-3},{23}}},np.int64)
  local b=np.array({{{2,-23,-17,23},{5,2,23,-3},{11,0,-7,-7}}},np.int8)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 66 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 66 shape')
  assert(seqeq(r.strides,{96,32,8}),'subtract 66 strides')
  assert(veq(r:tolist(),{{{3,28,22,-18},{18,21,0,26},{-9,2,9,9}},{{-5,20,14,-26},{-8,-5,-26,0},{12,23,30,30}}}),'subtract 66 values')
end
-- subtract array case 67
do
  local a=np.array({21,11,9,18,12},np.uint32)
  local b=np.array({5,5,3,17,15},np.uint64)
  local r=np.subtract(a,b)
  assert(r.dtype=='uint64','subtract 67 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 67 shape')
  assert(seqeq(r.strides,{8}),'subtract 67 strides')
  assert(veq(r:tolist(),{16,6,6,1,18446744073709551613}),'subtract 67 values')
end
-- subtract array case 68
do
  local a=np.array({{13},{8}},np.uint64)
  local b=np.array({{-1.5,-0.5,-0.5}},np.float32)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 68 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 68 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 68 strides')
  assert(veq(r:tolist(),{{14.5,13.5,13.5},{9.5,8.5,8.5}}),'subtract 68 values')
end
-- subtract array case 69
do
  local a=np.array({{-1.5},{-1.5}},np.float32)
  local b=np.array({{false,true,true}},np.bool)
  local r=np.subtract(a,b)
  assert(r.dtype=='float32','subtract 69 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 69 shape')
  assert(seqeq(r.strides,{12,4}),'subtract 69 strides')
  assert(veq(r:tolist(),{{-1.5,-2.5,-2.5},{-1.5,-2.5,-2.5}}),'subtract 69 values')
end
-- subtract array case 70
do
  local a=np.array({{22,23,1},{0,6,12}},np.uint32)
  local b=np.array({{-0.5,-7.5,0.25}},np.float64)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 70 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 70 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 70 strides')
  assert(veq(r:tolist(),{{22.5,30.5,0.75},{0.5,13.5,11.75}}),'subtract 70 values')
end
-- subtract array case 71
do
  local a=np.array({{{1.25},{1.25},{2.5}},{{7.75},{-7.5},{-3.25}}},np.float16)
  local b=np.array({{{-1,0,-17,2},{0,0,-17,2},{-1,-17,23,5}}},np.int32)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 71 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 71 shape')
  assert(seqeq(r.strides,{96,32,8}),'subtract 71 strides')
  assert(veq(r:tolist(),{{{2.25,1.25,18.25,-0.75},{1.25,1.25,18.25,-0.75},{3.5,19.5,-20.5,-2.5}},{{8.75,7.75,24.75,5.75},{-7.5,-7.5,9.5,-9.5},{-2.25,13.75,-26.25,-8.25}}}),'subtract 71 values')
end
-- subtract array case 72
do
  local a=np.array({{{15},{20},{22}},{{5},{7},{8}}},np.uint32)
  local b=np.array({{{8,18,3,11},{13,10,9,17},{25,21,11,2}}},np.uint32)
  local r=np.subtract(a,b)
  assert(r.dtype=='uint32','subtract 72 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 72 shape')
  assert(seqeq(r.strides,{48,16,4}),'subtract 72 strides')
  assert(veq(r:tolist(),{{{7,4294967293,12,4},{7,10,11,3},{4294967293,1,11,20}},{{4294967293,4294967283,2,4294967290},{4294967290,4294967293,4294967294,4294967286},{4294967279,4294967283,4294967293,6}}}),'subtract 72 values')
end
-- subtract array case 73
do
  local a=np.array({{-0.5,2.5,-3.25},{0.25,-7.5,7.75}},np.float32)
  local b=np.array({11,17,3},np.uint8)
  local r=np.subtract(a,b)
  assert(r.dtype=='float32','subtract 73 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 73 shape')
  assert(seqeq(r.strides,{12,4}),'subtract 73 strides')
  assert(veq(r:tolist(),{{-11.5,-14.5,-6.25},{-10.75,-24.5,4.75}}),'subtract 73 values')
end
-- subtract array case 74
do
  local a=np.array({2,2,11,-23,-3},np.int64)
  local b=np.array({2.5,7.75,-7.5,7.75,7.75},np.float64)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 74 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 74 shape')
  assert(seqeq(r.strides,{8}),'subtract 74 strides')
  assert(veq(r:tolist(),{-0.5,-5.75,18.5,-30.75,-10.75}),'subtract 74 values')
end
-- subtract array case 75
do
  local a=np.array({{-3,-3,11},{0,-1,5}},np.int32)
  local b=np.array({0,-3,-3},np.int64)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 75 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 75 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 75 strides')
  assert(veq(r:tolist(),{{-3,0,14},{0,2,8}}),'subtract 75 values')
end
-- subtract array case 76
do
  local a=np.array({-0.5,2.5,-0.5,-3.25,-7.5},np.float16)
  local b=np.array({false,false,false,false,true},np.bool)
  local r=np.subtract(a,b)
  assert(r.dtype=='float16','subtract 76 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 76 shape')
  assert(seqeq(r.strides,{2}),'subtract 76 strides')
  assert(veq(r:tolist(),{-0.5,2.5,-0.5,-3.25,-8.5}),'subtract 76 values')
end
-- subtract array case 77
do
  local a=np.array({{18},{12}},np.uint32)
  local b=np.array({{3,18,2}},np.uint16)
  local r=np.subtract(a,b)
  assert(r.dtype=='uint32','subtract 77 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 77 shape')
  assert(seqeq(r.strides,{12,4}),'subtract 77 strides')
  assert(veq(r:tolist(),{{15,0,16},{9,4294967290,10}}),'subtract 77 values')
end
-- subtract array case 78
do
  local a=np.array({{11},{16}},np.uint8)
  local b=np.array({{-7.5,-7.5,2.5}},np.float64)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 78 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 78 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 78 strides')
  assert(veq(r:tolist(),{{18.5,18.5,8.5},{23.5,23.5,13.5}}),'subtract 78 values')
end
-- subtract array case 79
do
  local a=np.array({{false,false,true},{false,true,false}},np.bool)
  local b=np.array({3,7,17},np.uint8)
  local r=np.subtract(a,b)
  assert(r.dtype=='uint8','subtract 79 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 79 shape')
  assert(seqeq(r.strides,{3,1}),'subtract 79 strides')
  assert(veq(r:tolist(),{{253,249,240},{253,250,239}}),'subtract 79 values')
end
-- subtract array case 80
do
  local a=np.array({2.5,7.75,0.25,1.25,-7.5},np.float64)
  local b=np.array({1,-1,-17,1,23},np.int64)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 80 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 80 shape')
  assert(seqeq(r.strides,{8}),'subtract 80 strides')
  assert(veq(r:tolist(),{1.5,8.75,17.25,0.25,-30.5}),'subtract 80 values')
end
-- subtract array case 81
do
  local a=np.array({{-1.5,-3.25,0.25},{-0.5,2.5,-3.25}},np.float32)
  local b=np.array({19,5,11},np.uint8)
  local r=np.subtract(a,b)
  assert(r.dtype=='float32','subtract 81 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 81 shape')
  assert(seqeq(r.strides,{12,4}),'subtract 81 strides')
  assert(veq(r:tolist(),{{-20.5,-8.25,-10.75},{-19.5,-2.5,-14.25}}),'subtract 81 values')
end
-- subtract array case 82
do
  local a=np.array({{-1},{5}},np.int64)
  local b=np.array({{7,1,21}},np.uint8)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 82 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 82 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 82 strides')
  assert(veq(r:tolist(),{{-8,-2,-22},{-2,4,-16}}),'subtract 82 values')
end
-- subtract array case 83
do
  local a=np.array({{0},{23}},np.int8)
  local b=np.array({{true,true,true}},np.bool)
  local r=np.subtract(a,b)
  assert(r.dtype=='int8','subtract 83 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 83 shape')
  assert(seqeq(r.strides,{3,1}),'subtract 83 strides')
  assert(veq(r:tolist(),{{-1,-1,-1},{22,22,22}}),'subtract 83 values')
end
-- subtract array case 84
do
  local a=np.array({{{-1.5},{7.75},{7.75}},{{1.25},{0.25},{-1.5}}},np.float64)
  local b=np.array({{{9,7,6,0},{7,9,20,16},{13,17,11,1}}},np.uint8)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 84 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 84 shape')
  assert(seqeq(r.strides,{96,32,8}),'subtract 84 strides')
  assert(veq(r:tolist(),{{{-10.5,-8.5,-7.5,-1.5},{0.75,-1.25,-12.25,-8.25},{-5.25,-9.25,-3.25,6.75}},{{-7.75,-5.75,-4.75,1.25},{-6.75,-8.75,-19.75,-15.75},{-14.5,-18.5,-12.5,-2.5}}}),'subtract 84 values')
end
-- subtract array case 85
do
  local a=np.array({{{-17},{-3},{-7}},{{-17},{-7},{-7}}},np.int64)
  local b=np.array({{{5,-1,1,-23},{-23,11,-7,5},{-17,-17,5,-1}}},np.int8)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 85 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 85 shape')
  assert(seqeq(r.strides,{96,32,8}),'subtract 85 strides')
  assert(veq(r:tolist(),{{{-22,-16,-18,6},{20,-14,4,-8},{10,10,-12,-6}},{{-22,-16,-18,6},{16,-18,0,-12},{10,10,-12,-6}}}),'subtract 85 values')
end
-- subtract array case 86
do
  local a=np.array({{17,0,12},{13,10,24}},np.uint32)
  local b=np.array({-17,-17,23},np.int64)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 86 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 86 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 86 strides')
  assert(veq(r:tolist(),{{34,17,-11},{30,27,1}}),'subtract 86 values')
end
-- subtract array case 87
do
  local a=np.array({0,-1,1,2,-3},np.int16)
  local b=np.array({-1.5,-7.5,-1.5,0.25,7.75},np.float16)
  local r=np.subtract(a,b)
  assert(r.dtype=='float32','subtract 87 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 87 shape')
  assert(seqeq(r.strides,{4}),'subtract 87 strides')
  assert(veq(r:tolist(),{1.5,6.5,2.5,1.75,-10.75}),'subtract 87 values')
end
-- subtract array case 88
do
  local a=np.array({23,5,11,11,5},np.int16)
  local b=np.array({-3.25,-0.5,7.75,-3.25,1.25},np.float64)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 88 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 88 shape')
  assert(seqeq(r.strides,{8}),'subtract 88 strides')
  assert(veq(r:tolist(),{26.25,5.5,3.25,14.25,3.75}),'subtract 88 values')
end
-- subtract array case 89
do
  local a=np.array({{18,22,2},{18,7,6}},np.uint32)
  local b=np.array({{-3,0,1}},np.int8)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 89 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 89 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 89 strides')
  assert(veq(r:tolist(),{{21,22,1},{21,7,5}}),'subtract 89 values')
end
-- subtract array case 90
do
  local a=np.array({{2.5},{2.5}},np.float64)
  local b=np.array({{7.75,2.5,-7.5}},np.float16)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 90 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 90 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 90 strides')
  assert(veq(r:tolist(),{{-5.25,0.0,10.0},{-5.25,0.0,10.0}}),'subtract 90 values')
end
-- subtract array case 91
do
  local a=np.array({{true,true,true},{false,false,false}},np.bool)
  local b=np.array({9,24,18},np.uint32)
  local r=np.subtract(a,b)
  assert(r.dtype=='uint32','subtract 91 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 91 shape')
  assert(seqeq(r.strides,{12,4}),'subtract 91 strides')
  assert(veq(r:tolist(),{{4294967288,4294967273,4294967279},{4294967287,4294967272,4294967278}}),'subtract 91 values')
end
-- subtract array case 92
do
  local a=np.array({{{true},{false},{false}},{{false},{false},{true}}},np.bool)
  local b=np.array({{{0,-17,-23,11},{2,-1,-17,1},{11,-1,23,5}}},np.int8)
  local r=np.subtract(a,b)
  assert(r.dtype=='int8','subtract 92 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 92 shape')
  assert(seqeq(r.strides,{12,4,1}),'subtract 92 strides')
  assert(veq(r:tolist(),{{{1,18,24,-10},{-2,1,17,-1},{-11,1,-23,-5}},{{0,17,23,-11},{-2,1,17,-1},{-10,2,-22,-4}}}),'subtract 92 values')
end
-- subtract array case 93
do
  local a=np.array({{0,-17,-1},{-23,5,23}},np.int8)
  local b=np.array({false,true,true},np.bool)
  local r=np.subtract(a,b)
  assert(r.dtype=='int8','subtract 93 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 93 shape')
  assert(seqeq(r.strides,{3,1}),'subtract 93 strides')
  assert(veq(r:tolist(),{{0,-18,-2},{-23,4,22}}),'subtract 93 values')
end
-- subtract array case 94
do
  local a=np.array({0,5,-1,1,23},np.int64)
  local b=np.array({-23,-3,1,-3,-17},np.int16)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 94 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 94 shape')
  assert(seqeq(r.strides,{8}),'subtract 94 strides')
  assert(veq(r:tolist(),{23,8,-2,4,40}),'subtract 94 values')
end
-- subtract array case 95
do
  local a=np.array({-3.25,0.25,-3.25,7.75,7.75},np.float32)
  local b=np.array({1.25,-0.5,2.5,-3.25,0.25},np.float64)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 95 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 95 shape')
  assert(seqeq(r.strides,{8}),'subtract 95 strides')
  assert(veq(r:tolist(),{-4.5,0.75,-5.75,11.0,7.5}),'subtract 95 values')
end
-- subtract array case 96
do
  local a=np.array({{23},{-17}},np.int32)
  local b=np.array({{-1.5,-3.25,2.5}},np.float16)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 96 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 96 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 96 strides')
  assert(veq(r:tolist(),{{24.5,26.25,20.5},{-15.5,-13.75,-19.5}}),'subtract 96 values')
end
-- subtract array case 97
do
  local a=np.array({{-0.5,2.5,-3.25},{-7.5,-0.5,0.25}},np.float32)
  local b=np.array({{-1,5,11}},np.int32)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 97 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 97 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 97 strides')
  assert(veq(r:tolist(),{{0.5,-2.5,-14.25},{-6.5,-5.5,-10.75}}),'subtract 97 values')
end
-- subtract array case 98
do
  local a=np.array({{{0.25},{-3.25},{7.75}},{{-1.5},{-3.25},{1.25}}},np.float32)
  local b=np.array({{{1,9,22,11},{19,12,10,18},{6,3,11,16}}},np.uint64)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 98 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 98 shape')
  assert(seqeq(r.strides,{96,32,8}),'subtract 98 strides')
  assert(veq(r:tolist(),{{{-0.75,-8.75,-21.75,-10.75},{-22.25,-15.25,-13.25,-21.25},{1.75,4.75,-3.25,-8.25}},{{-2.5,-10.5,-23.5,-12.5},{-22.25,-15.25,-13.25,-21.25},{-4.75,-1.75,-9.75,-14.75}}}),'subtract 98 values')
end
-- subtract array case 99
do
  local a=np.array({{{8},{25},{4}},{{13},{15},{1}}},np.uint32)
  local b=np.array({{{-23,0,23,-3},{2,23,5,5},{-1,11,2,5}}},np.int8)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 99 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 99 shape')
  assert(seqeq(r.strides,{96,32,8}),'subtract 99 strides')
  assert(veq(r:tolist(),{{{31,8,-15,11},{23,2,20,20},{5,-7,2,-1}},{{36,13,-10,16},{13,-8,10,10},{2,-10,-1,-4}}}),'subtract 99 values')
end
-- subtract array case 100
do
  local a=np.array({{{3},{25},{8}},{{19},{11},{16}}},np.uint64)
  local b=np.array({{{true,false,true,true},{false,true,false,true},{false,false,false,false}}},np.bool)
  local r=np.subtract(a,b)
  assert(r.dtype=='uint64','subtract 100 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 100 shape')
  assert(seqeq(r.strides,{96,32,8}),'subtract 100 strides')
  assert(veq(r:tolist(),{{{2,3,2,2},{25,24,25,24},{8,8,8,8}},{{18,19,18,18},{11,10,11,10},{16,16,16,16}}}),'subtract 100 values')
end
-- subtract array case 101
do
  local a=np.array({{{-7},{-3},{-1}},{{-1},{5},{-1}}},np.int64)
  local b=np.array({{{21,21,10,22},{2,11,4,19},{1,6,10,13}}},np.uint64)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 101 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 101 shape')
  assert(seqeq(r.strides,{96,32,8}),'subtract 101 strides')
  assert(veq(r:tolist(),{{{-28.0,-28.0,-17.0,-29.0},{-5.0,-14.0,-7.0,-22.0},{-2.0,-7.0,-11.0,-14.0}},{{-22.0,-22.0,-11.0,-23.0},{3.0,-6.0,1.0,-14.0},{-2.0,-7.0,-11.0,-14.0}}}),'subtract 101 values')
end
-- subtract array case 102
do
  local a=np.array({{0},{-1}},np.int64)
  local b=np.array({{false,false,false}},np.bool)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 102 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 102 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 102 strides')
  assert(veq(r:tolist(),{{0,0,0},{-1,-1,-1}}),'subtract 102 values')
end
-- subtract array case 103
do
  local a=np.array({{-17,1,-7},{-23,-23,2}},np.int16)
  local b=np.array({{-1.5,-3.25,0.25}},np.float32)
  local r=np.subtract(a,b)
  assert(r.dtype=='float32','subtract 103 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 103 shape')
  assert(seqeq(r.strides,{12,4}),'subtract 103 strides')
  assert(veq(r:tolist(),{{-15.5,4.25,-7.25},{-21.5,-19.75,1.75}}),'subtract 103 values')
end
-- subtract array case 104
do
  local a=np.array({21,18,24,2,14},np.uint64)
  local b=np.array({3,1,1,18,9},np.uint64)
  local r=np.subtract(a,b)
  assert(r.dtype=='uint64','subtract 104 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 104 shape')
  assert(seqeq(r.strides,{8}),'subtract 104 strides')
  assert(veq(r:tolist(),{18,17,23,18446744073709551600,5}),'subtract 104 values')
end
-- subtract array case 105
do
  local a=np.array({{{23},{2},{-23}},{{11},{1},{1}}},np.int8)
  local b=np.array({{{2,0,2,2},{23,-23,-1,0},{0,-1,-23,11}}},np.int64)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 105 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 105 shape')
  assert(seqeq(r.strides,{96,32,8}),'subtract 105 strides')
  assert(veq(r:tolist(),{{{21,23,21,21},{-21,25,3,2},{-23,-22,0,-34}},{{9,11,9,9},{-22,24,2,1},{1,2,24,-10}}}),'subtract 105 values')
end
-- subtract array case 106
do
  local a=np.array({{7.75,-0.5,0.25},{1.25,1.25,2.5}},np.float64)
  local b=np.array({true,true,false},np.bool)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 106 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 106 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 106 strides')
  assert(veq(r:tolist(),{{6.75,-1.5,0.25},{0.25,0.25,2.5}}),'subtract 106 values')
end
-- subtract array case 107
do
  local a=np.array({-17,-17,1,-17,-3},np.int16)
  local b=np.array({-23,0,-17,5,1},np.int64)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 107 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 107 shape')
  assert(seqeq(r.strides,{8}),'subtract 107 strides')
  assert(veq(r:tolist(),{6,-17,18,-22,-4}),'subtract 107 values')
end
-- subtract array case 108
do
  local a=np.array({23,-3,-3,23,5},np.int8)
  local b=np.array({15,2,24,18,22},np.uint64)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 108 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 108 shape')
  assert(seqeq(r.strides,{8}),'subtract 108 strides')
  assert(veq(r:tolist(),{8.0,-5.0,-27.0,5.0,-17.0}),'subtract 108 values')
end
-- subtract array case 109
do
  local a=np.array({{5},{0}},np.int64)
  local b=np.array({{23,13,18}},np.uint32)
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','subtract 109 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 109 shape')
  assert(seqeq(r.strides,{24,8}),'subtract 109 strides')
  assert(veq(r:tolist(),{{-18,-8,-13},{-23,-13,-18}}),'subtract 109 values')
end
-- subtract array case 110
do
  local a=np.array({{false,false,false},{false,false,true}},np.bool)
  local b=np.array({{2,23,5}},np.int16)
  local r=np.subtract(a,b)
  assert(r.dtype=='int16','subtract 110 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 110 shape')
  assert(seqeq(r.strides,{6,2}),'subtract 110 strides')
  assert(veq(r:tolist(),{{-2,-23,-5},{-2,-23,-4}}),'subtract 110 values')
end
-- subtract array case 111
do
  local a=np.array({{11,-3,1},{11,23,-3}},np.int16)
  local b=np.array({15,9,16},np.uint16)
  local r=np.subtract(a,b)
  assert(r.dtype=='int32','subtract 111 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 111 shape')
  assert(seqeq(r.strides,{12,4}),'subtract 111 strides')
  assert(veq(r:tolist(),{{-4,-12,-15},{-4,14,-19}}),'subtract 111 values')
end
-- subtract array case 112
do
  local a=np.array({{{23},{1},{5}},{{18},{1},{4}}},np.uint8)
  local b=np.array({{{2.5,-0.5,7.75,-0.5},{-0.5,2.5,1.25,-7.5},{0.25,-3.25,-0.5,7.75}}},np.float32)
  local r=np.subtract(a,b)
  assert(r.dtype=='float32','subtract 112 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 112 shape')
  assert(seqeq(r.strides,{48,16,4}),'subtract 112 strides')
  assert(veq(r:tolist(),{{{20.5,23.5,15.25,23.5},{1.5,-1.5,-0.25,8.5},{4.75,8.25,5.5,-2.75}},{{15.5,18.5,10.25,18.5},{1.5,-1.5,-0.25,8.5},{3.75,7.25,4.5,-3.75}}}),'subtract 112 values')
end
-- subtract array case 113
do
  local a=np.array({2.5,7.75,0.25,-1.5,7.75},np.float32)
  local b=np.array({2.5,-1.5,2.5,0.25,-3.25},np.float64)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 113 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 113 shape')
  assert(seqeq(r.strides,{8}),'subtract 113 strides')
  assert(veq(r:tolist(),{0.0,9.25,-2.25,-1.75,11.0}),'subtract 113 values')
end
-- subtract array case 114
do
  local a=np.array({{{18},{14},{20}},{{5},{13},{20}}},np.uint16)
  local b=np.array({{{11,-3,-3,-1},{1,23,0,1},{-17,-7,-23,-7}}},np.int8)
  local r=np.subtract(a,b)
  assert(r.dtype=='int32','subtract 114 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 114 shape')
  assert(seqeq(r.strides,{48,16,4}),'subtract 114 strides')
  assert(veq(r:tolist(),{{{7,21,21,19},{13,-9,14,13},{37,27,43,27}},{{-6,8,8,6},{12,-10,13,12},{37,27,43,27}}}),'subtract 114 values')
end
-- subtract array case 115
do
  local a=np.array({{{15},{3},{10}},{{0},{19},{4}}},np.uint64)
  local b=np.array({{{1,-3,0,-7},{-23,1,1,0},{11,-7,-1,5}}},np.int32)
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','subtract 115 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 115 shape')
  assert(seqeq(r.strides,{96,32,8}),'subtract 115 strides')
  assert(veq(r:tolist(),{{{14.0,18.0,15.0,22.0},{26.0,2.0,2.0,3.0},{-1.0,17.0,11.0,5.0}},{{-1.0,3.0,0.0,7.0},{42.0,18.0,18.0,19.0},{-7.0,11.0,5.0,-1.0}}}),'subtract 115 values')
end
-- subtract array case 116
do
  local a=np.array({{2},{1}},np.int32)
  local b=np.array({{4,8,2}},np.uint16)
  local r=np.subtract(a,b)
  assert(r.dtype=='int32','subtract 116 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'subtract 116 shape')
  assert(seqeq(r.strides,{12,4}),'subtract 116 strides')
  assert(veq(r:tolist(),{{-2,-6,0},{-3,-7,-1}}),'subtract 116 values')
end
-- subtract array case 117
do
  local a=np.array({false,true,false,false,true},np.bool)
  local b=np.array({6,8,0,0,16},np.uint32)
  local r=np.subtract(a,b)
  assert(r.dtype=='uint32','subtract 117 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 117 shape')
  assert(seqeq(r.strides,{4}),'subtract 117 strides')
  assert(veq(r:tolist(),{4294967290,4294967289,0,0,4294967281}),'subtract 117 values')
end
-- subtract array case 118
do
  local a=np.array({2,2,-1,2,23},np.int16)
  local b=np.array({-3.25,0.25,7.75,-1.5,2.5},np.float32)
  local r=np.subtract(a,b)
  assert(r.dtype=='float32','subtract 118 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'subtract 118 shape')
  assert(seqeq(r.strides,{4}),'subtract 118 strides')
  assert(veq(r:tolist(),{5.25,1.75,-8.75,3.5,20.5}),'subtract 118 values')
end
-- subtract array case 119
do
  local a=np.array({{{true},{false},{true}},{{false},{false},{true}}},np.bool)
  local b=np.array({{{16,1,18,8},{9,12,7,25},{15,15,11,9}}},np.uint64)
  local r=np.subtract(a,b)
  assert(r.dtype=='uint64','subtract 119 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'subtract 119 shape')
  assert(seqeq(r.strides,{96,32,8}),'subtract 119 strides')
  assert(veq(r:tolist(),{{{18446744073709551601,0,18446744073709551599,18446744073709551609},{18446744073709551607,18446744073709551604,18446744073709551609,18446744073709551591},{18446744073709551602,18446744073709551602,18446744073709551606,18446744073709551608}},{{18446744073709551600,18446744073709551615,18446744073709551598,18446744073709551608},{18446744073709551607,18446744073709551604,18446744073709551609,18446744073709551591},{18446744073709551602,18446744073709551602,18446744073709551606,18446744073709551608}}}),'subtract 119 values')
end
-- true_divide array case 120
do
  local a=np.array({{1},{-23}},np.int64)
  local b=np.array({{-7,1,23}},np.int8)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 120 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 120 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 120 strides')
  assert(veq(r:tolist(),{{-0.14285714285714285,1.0,0.043478260869565216},{3.2857142857142856,-23.0,-1.0}}),'true_divide 120 values')
end
-- true_divide array case 121
do
  local a=np.array({{7.75},{0.25}},np.float16)
  local b=np.array({{17,4,21}},np.uint8)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float16','true_divide 121 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 121 shape')
  assert(seqeq(r.strides,{6,2}),'true_divide 121 strides')
  assert(veq(r:tolist(),{{0.455810546875,1.9375,0.369140625},{0.01470947265625,0.0625,0.01190185546875}}),'true_divide 121 values')
end
-- true_divide array case 122
do
  local a=np.array({{19,25,3},{4,12,9}},np.uint64)
  local b=np.array({{11,11,-3}},np.int16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 122 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 122 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 122 strides')
  assert(veq(r:tolist(),{{1.7272727272727273,2.272727272727273,-1.0},{0.36363636363636365,1.0909090909090908,-3.0}}),'true_divide 122 values')
end
-- true_divide array case 123
do
  local a=np.array({{{7},{18},{24}},{{4},{17},{15}}},np.uint64)
  local b=np.array({{{-17,1,-3,2},{5,2,5,-1},{2,5,-17,11}}},np.int16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 123 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'true_divide 123 shape')
  assert(seqeq(r.strides,{96,32,8}),'true_divide 123 strides')
  assert(veq(r:tolist(),{{{-0.4117647058823529,7.0,-2.3333333333333335,3.5},{3.6,9.0,3.6,-18.0},{12.0,4.8,-1.411764705882353,2.1818181818181817}},{{-0.23529411764705882,4.0,-1.3333333333333333,2.0},{3.4,8.5,3.4,-17.0},{7.5,3.0,-0.8823529411764706,1.3636363636363635}}}),'true_divide 123 values')
end
-- true_divide array case 124
do
  local a=np.array({{7.75,-1.5,7.75},{-3.25,0.25,-0.5}},np.float64)
  local b=np.array({18,1,13},np.uint16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 124 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 124 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 124 strides')
  assert(veq(r:tolist(),{{0.4305555555555556,-1.5,0.5961538461538461},{-0.18055555555555555,0.25,-0.038461538461538464}}),'true_divide 124 values')
end
-- true_divide array case 125
do
  local a=np.array({{6},{8}},np.uint8)
  local b=np.array({{-1,5,-1}},np.int64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 125 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 125 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 125 strides')
  assert(veq(r:tolist(),{{-6.0,1.2,-6.0},{-8.0,1.6,-8.0}}),'true_divide 125 values')
end
-- true_divide array case 126
do
  local a=np.array({{{0},{5},{1}},{{0},{-17},{-7}}},np.int32)
  local b=np.array({{{true,true,true,true},{true,true,true,true},{true,true,true,true}}},np.bool)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 126 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'true_divide 126 shape')
  assert(seqeq(r.strides,{96,32,8}),'true_divide 126 strides')
  assert(veq(r:tolist(),{{{0.0,0.0,0.0,0.0},{5.0,5.0,5.0,5.0},{1.0,1.0,1.0,1.0}},{{0.0,0.0,0.0,0.0},{-17.0,-17.0,-17.0,-17.0},{-7.0,-7.0,-7.0,-7.0}}}),'true_divide 126 values')
end
-- true_divide array case 127
do
  local a=np.array({2.5,-1.5,-1.5,-7.5,2.5},np.float64)
  local b=np.array({7,22,8,15,11},np.uint8)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 127 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 127 shape')
  assert(seqeq(r.strides,{8}),'true_divide 127 strides')
  assert(veq(r:tolist(),{0.35714285714285715,-0.06818181818181818,-0.1875,-0.5,0.22727272727272727}),'true_divide 127 values')
end
-- true_divide array case 128
do
  local a=np.array({{0,0,20},{17,11,6}},np.uint32)
  local b=np.array({23,20,24},np.uint16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 128 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 128 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 128 strides')
  assert(veq(r:tolist(),{{0.0,0.0,0.8333333333333334},{0.7391304347826086,0.55,0.25}}),'true_divide 128 values')
end
-- true_divide array case 129
do
  local a=np.array({{{-0.5},{-7.5},{1.25}},{{-3.25},{-3.25},{-3.25}}},np.float32)
  local b=np.array({{{3,13,12,3},{20,12,2,18},{9,11,14,24}}},np.uint8)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float32','true_divide 129 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'true_divide 129 shape')
  assert(seqeq(r.strides,{48,16,4}),'true_divide 129 strides')
  assert(veq(r:tolist(),{{{-0.1666666716337204,-0.03846153989434242,-0.0416666679084301,-0.1666666716337204},{-0.375,-0.625,-3.75,-0.4166666567325592},{0.1388888955116272,0.11363636702299118,0.0892857164144516,0.0520833320915699}},{{-1.0833333730697632,-0.25,-0.2708333432674408,-1.0833333730697632},{-0.16249999403953552,-0.2708333432674408,-1.625,-0.1805555522441864},{-0.3611111044883728,-0.2954545319080353,-0.2321428507566452,-0.1354166716337204}}}),'true_divide 129 values')
end
-- true_divide array case 130
do
  local a=np.array({{-7},{11}},np.int64)
  local b=np.array({{-1,5,-3}},np.int16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 130 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 130 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 130 strides')
  assert(veq(r:tolist(),{{7.0,-1.4,2.3333333333333335},{-11.0,2.2,-3.6666666666666665}}),'true_divide 130 values')
end
-- true_divide array case 131
do
  local a=np.array({{{0},{15},{14}},{{16},{8},{24}}},np.uint16)
  local b=np.array({{{-3.25,0.25,2.5,7.75},{-0.5,2.5,2.5,-0.5},{1.25,-3.25,1.25,7.75}}},np.float16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float32','true_divide 131 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'true_divide 131 shape')
  assert(seqeq(r.strides,{48,16,4}),'true_divide 131 strides')
  assert(veq(r:tolist(),{{{-0.0,0.0,0.0,0.0},{-30.0,6.0,6.0,-30.0},{11.199999809265137,-4.307692527770996,11.199999809265137,1.8064515590667725}},{{-4.92307710647583,64.0,6.400000095367432,2.064516067504883},{-16.0,3.200000047683716,3.200000047683716,-16.0},{19.200000762939453,-7.384615421295166,19.200000762939453,3.096774101257324}}}),'true_divide 131 values')
end
-- true_divide array case 132
do
  local a=np.array({{-3},{5}},np.int8)
  local b=np.array({{true,true,true}},np.bool)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 132 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 132 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 132 strides')
  assert(veq(r:tolist(),{{-3.0,-3.0,-3.0},{5.0,5.0,5.0}}),'true_divide 132 values')
end
-- true_divide array case 133
do
  local a=np.array({2,-7,5,-17,23},np.int8)
  local b=np.array({2.5,-7.5,7.75,-0.5,2.5},np.float64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 133 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 133 shape')
  assert(seqeq(r.strides,{8}),'true_divide 133 strides')
  assert(veq(r:tolist(),{0.8,0.9333333333333333,0.6451612903225806,34.0,9.2}),'true_divide 133 values')
end
-- true_divide array case 134
do
  local a=np.array({7.75,-7.5,2.5,1.25,-3.25},np.float32)
  local b=np.array({-1.5,-1.5,-1.5,-0.5,-7.5},np.float32)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float32','true_divide 134 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 134 shape')
  assert(seqeq(r.strides,{4}),'true_divide 134 strides')
  assert(veq(r:tolist(),{-5.166666507720947,5.0,-1.6666666269302368,-2.5,0.4333333373069763}),'true_divide 134 values')
end
-- true_divide array case 135
do
  local a=np.array({{{false},{false},{true}},{{true},{true},{false}}},np.bool)
  local b=np.array({{{2.5,-1.5,-7.5,7.75},{-3.25,-0.5,-7.5,-7.5},{-1.5,-1.5,1.25,-7.5}}},np.float64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 135 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'true_divide 135 shape')
  assert(seqeq(r.strides,{96,32,8}),'true_divide 135 strides')
  assert(veq(r:tolist(),{{{0.0,-0.0,-0.0,0.0},{-0.0,-0.0,-0.0,-0.0},{-0.6666666666666666,-0.6666666666666666,0.8,-0.13333333333333333}},{{0.4,-0.6666666666666666,-0.13333333333333333,0.12903225806451613},{-0.3076923076923077,-2.0,-0.13333333333333333,-0.13333333333333333},{-0.0,-0.0,0.0,-0.0}}}),'true_divide 135 values')
end
-- true_divide array case 136
do
  local a=np.array({{7,11,2},{17,5,9}},np.uint64)
  local b=np.array({{0.25,0.25,-3.25}},np.float64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 136 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 136 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 136 strides')
  assert(veq(r:tolist(),{{28.0,44.0,-0.6153846153846154},{68.0,20.0,-2.769230769230769}}),'true_divide 136 values')
end
-- true_divide array case 137
do
  local a=np.array({{-1,1,1},{-1,-17,2}},np.int32)
  local b=np.array({{2.5,7.75,-7.5}},np.float64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 137 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 137 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 137 strides')
  assert(veq(r:tolist(),{{-0.4,0.12903225806451613,-0.13333333333333333},{-0.4,-2.193548387096774,-0.26666666666666666}}),'true_divide 137 values')
end
-- true_divide array case 138
do
  local a=np.array({-0.5,-0.5,-3.25,-7.5,1.25},np.float32)
  local b=np.array({8,25,2,17,4},np.uint16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float32','true_divide 138 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 138 shape')
  assert(seqeq(r.strides,{4}),'true_divide 138 strides')
  assert(veq(r:tolist(),{-0.0625,-0.019999999552965164,-1.625,-0.44117647409439087,0.3125}),'true_divide 138 values')
end
-- true_divide array case 139
do
  local a=np.array({{22},{12}},np.uint8)
  local b=np.array({{0.25,1.25,7.75}},np.float16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float16','true_divide 139 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 139 shape')
  assert(seqeq(r.strides,{6,2}),'true_divide 139 strides')
  assert(veq(r:tolist(),{{88.0,17.59375,2.837890625},{48.0,9.6015625,1.548828125}}),'true_divide 139 values')
end
-- true_divide array case 140
do
  local a=np.array({6,6,14,12,18},np.uint64)
  local b=np.array({5,11,1,2,23},np.int16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 140 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 140 shape')
  assert(seqeq(r.strides,{8}),'true_divide 140 strides')
  assert(veq(r:tolist(),{1.2,0.5454545454545454,14.0,6.0,0.782608695652174}),'true_divide 140 values')
end
-- true_divide array case 141
do
  local a=np.array({{-3},{23}},np.int32)
  local b=np.array({{23,-7,-1}},np.int16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 141 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 141 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 141 strides')
  assert(veq(r:tolist(),{{-0.13043478260869565,0.42857142857142855,3.0},{1.0,-3.2857142857142856,-23.0}}),'true_divide 141 values')
end
-- true_divide array case 142
do
  local a=np.array({{24,18,25},{4,22,23}},np.uint8)
  local b=np.array({8,10,9},np.uint32)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 142 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 142 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 142 strides')
  assert(veq(r:tolist(),{{3.0,1.8,2.7777777777777777},{0.5,2.2,2.5555555555555554}}),'true_divide 142 values')
end
-- true_divide array case 143
do
  local a=np.array({{false,false,false},{false,true,false}},np.bool)
  local b=np.array({{11,2,1}},np.int16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 143 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 143 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 143 strides')
  assert(veq(r:tolist(),{{0.0,0.0,0.0},{0.0,0.5,0.0}}),'true_divide 143 values')
end
-- true_divide array case 144
do
  local a=np.array({24,24,1,21,1},np.uint64)
  local b=np.array({true,true,true,true,true},np.bool)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 144 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 144 shape')
  assert(seqeq(r.strides,{8}),'true_divide 144 strides')
  assert(veq(r:tolist(),{24.0,24.0,1.0,21.0,1.0}),'true_divide 144 values')
end
-- true_divide array case 145
do
  local a=np.array({false,true,true,false,true},np.bool)
  local b=np.array({22,15,6,10,9},np.uint32)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 145 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 145 shape')
  assert(seqeq(r.strides,{8}),'true_divide 145 strides')
  assert(veq(r:tolist(),{0.0,0.06666666666666667,0.16666666666666666,0.0,0.1111111111111111}),'true_divide 145 values')
end
-- true_divide array case 146
do
  local a=np.array({{17},{23}},np.uint64)
  local b=np.array({{-7.5,-0.5,7.75}},np.float64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 146 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 146 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 146 strides')
  assert(veq(r:tolist(),{{-2.2666666666666666,-34.0,2.193548387096774},{-3.066666666666667,-46.0,2.967741935483871}}),'true_divide 146 values')
end
-- true_divide array case 147
do
  local a=np.array({{2.5,-3.25,-0.5},{-3.25,0.25,-3.25}},np.float16)
  local b=np.array({{1.25,-1.5,-7.5}},np.float64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 147 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 147 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 147 strides')
  assert(veq(r:tolist(),{{2.0,2.1666666666666665,0.06666666666666667},{-2.6,-0.16666666666666666,0.43333333333333335}}),'true_divide 147 values')
end
-- true_divide array case 148
do
  local a=np.array({{0},{18}},np.uint64)
  local b=np.array({{-1,2,-1}},np.int32)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 148 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 148 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 148 strides')
  assert(veq(r:tolist(),{{-0.0,0.0,-0.0},{-18.0,9.0,-18.0}}),'true_divide 148 values')
end
-- true_divide array case 149
do
  local a=np.array({{0},{23}},np.int32)
  local b=np.array({{-0.5,-3.25,0.25}},np.float32)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 149 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 149 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 149 strides')
  assert(veq(r:tolist(),{{-0.0,-0.0,0.0},{-46.0,-7.076923076923077,92.0}}),'true_divide 149 values')
end
-- true_divide array case 150
do
  local a=np.array({{-0.5,-0.5,-7.5},{-7.5,-3.25,-3.25}},np.float32)
  local b=np.array({{-17,-17,1}},np.int32)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 150 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 150 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 150 strides')
  assert(veq(r:tolist(),{{0.029411764705882353,0.029411764705882353,-7.5},{0.4411764705882353,0.19117647058823528,-3.25}}),'true_divide 150 values')
end
-- true_divide array case 151
do
  local a=np.array({{-23},{-23}},np.int8)
  local b=np.array({{-7.5,-7.5,-0.5}},np.float16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float16','true_divide 151 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 151 shape')
  assert(seqeq(r.strides,{6,2}),'true_divide 151 strides')
  assert(veq(r:tolist(),{{3.06640625,3.06640625,46.0},{3.06640625,3.06640625,46.0}}),'true_divide 151 values')
end
-- true_divide array case 152
do
  local a=np.array({{{-17},{11},{23}},{{-23},{-1},{2}}},np.int16)
  local b=np.array({{{12,20,16,12},{15,11,22,10},{5,21,25,21}}},np.uint16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 152 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'true_divide 152 shape')
  assert(seqeq(r.strides,{96,32,8}),'true_divide 152 strides')
  assert(veq(r:tolist(),{{{-1.4166666666666667,-0.85,-1.0625,-1.4166666666666667},{0.7333333333333333,1.0,0.5,1.1},{4.6,1.0952380952380953,0.92,1.0952380952380953}},{{-1.9166666666666667,-1.15,-1.4375,-1.9166666666666667},{-0.06666666666666667,-0.09090909090909091,-0.045454545454545456,-0.1},{0.4,0.09523809523809523,0.08,0.09523809523809523}}}),'true_divide 152 values')
end
-- true_divide array case 153
do
  local a=np.array({8,21,14,14,23},np.uint16)
  local b=np.array({true,true,true,true,true},np.bool)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 153 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 153 shape')
  assert(seqeq(r.strides,{8}),'true_divide 153 strides')
  assert(veq(r:tolist(),{8.0,21.0,14.0,14.0,23.0}),'true_divide 153 values')
end
-- true_divide array case 154
do
  local a=np.array({{9,17,7},{1,7,7}},np.uint8)
  local b=np.array({{5,5,-7}},np.int16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 154 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 154 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 154 strides')
  assert(veq(r:tolist(),{{1.8,3.4,-1.0},{0.2,1.4,-1.0}}),'true_divide 154 values')
end
-- true_divide array case 155
do
  local a=np.array({{false,false,false},{false,true,false}},np.bool)
  local b=np.array({{1,11,1}},np.int8)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 155 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 155 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 155 strides')
  assert(veq(r:tolist(),{{0.0,0.0,0.0},{0.0,0.09090909090909091,0.0}}),'true_divide 155 values')
end
-- true_divide array case 156
do
  local a=np.array({{-17,11,-7},{-1,-1,2}},np.int64)
  local b=np.array({-7,2,1},np.int64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 156 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 156 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 156 strides')
  assert(veq(r:tolist(),{{2.4285714285714284,5.5,-7.0},{0.14285714285714285,-0.5,2.0}}),'true_divide 156 values')
end
-- true_divide array case 157
do
  local a=np.array({{0,-1,5},{-7,5,0}},np.int16)
  local b=np.array({{18,21,2}},np.uint8)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 157 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 157 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 157 strides')
  assert(veq(r:tolist(),{{0.0,-0.047619047619047616,2.5},{-0.3888888888888889,0.23809523809523808,0.0}}),'true_divide 157 values')
end
-- true_divide array case 158
do
  local a=np.array({{false},{false}},np.bool)
  local b=np.array({{1.25,-0.5,-3.25}},np.float64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 158 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 158 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 158 strides')
  assert(veq(r:tolist(),{{0.0,-0.0,-0.0},{0.0,-0.0,-0.0}}),'true_divide 158 values')
end
-- true_divide array case 159
do
  local a=np.array({{11,5,-1},{11,23,-23}},np.int32)
  local b=np.array({-1,23,5},np.int16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 159 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 159 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 159 strides')
  assert(veq(r:tolist(),{{-11.0,0.21739130434782608,-0.2},{-11.0,1.0,-4.6}}),'true_divide 159 values')
end
-- true_divide array case 160
do
  local a=np.array({{7.75},{-3.25}},np.float64)
  local b=np.array({{-3.25,-1.5,7.75}},np.float16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 160 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 160 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 160 strides')
  assert(veq(r:tolist(),{{-2.3846153846153846,-5.166666666666667,1.0},{1.0,2.1666666666666665,-0.41935483870967744}}),'true_divide 160 values')
end
-- true_divide array case 161
do
  local a=np.array({2.5,-7.5,-1.5,1.25,-3.25},np.float64)
  local b=np.array({0.25,1.25,1.25,-1.5,-3.25},np.float64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 161 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 161 shape')
  assert(seqeq(r.strides,{8}),'true_divide 161 strides')
  assert(veq(r:tolist(),{10.0,-6.0,-1.2,-0.8333333333333334,1.0}),'true_divide 161 values')
end
-- true_divide array case 162
do
  local a=np.array({{-1.5,0.25,1.25},{7.75,1.25,1.25}},np.float64)
  local b=np.array({{5,23,-1}},np.int64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 162 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 162 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 162 strides')
  assert(veq(r:tolist(),{{-0.3,0.010869565217391304,-1.25},{1.55,0.05434782608695652,-1.25}}),'true_divide 162 values')
end
-- true_divide array case 163
do
  local a=np.array({{23,-1,11},{1,2,-3}},np.int8)
  local b=np.array({{5,2,11}},np.int64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 163 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 163 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 163 strides')
  assert(veq(r:tolist(),{{4.6,-0.5,1.0},{0.2,1.0,-0.2727272727272727}}),'true_divide 163 values')
end
-- true_divide array case 164
do
  local a=np.array({2,5,-1,-1,11},np.int8)
  local b=np.array({2.5,-1.5,-0.5,-3.25,-7.5},np.float32)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float32','true_divide 164 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 164 shape')
  assert(seqeq(r.strides,{4}),'true_divide 164 strides')
  assert(veq(r:tolist(),{0.800000011920929,-3.3333332538604736,2.0,0.3076923191547394,-1.4666666984558105}),'true_divide 164 values')
end
-- true_divide array case 165
do
  local a=np.array({{11,20,23},{15,9,19}},np.uint64)
  local b=np.array({7.75,1.25,1.25},np.float32)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 165 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 165 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 165 strides')
  assert(veq(r:tolist(),{{1.4193548387096775,16.0,18.4},{1.935483870967742,7.2,15.2}}),'true_divide 165 values')
end
-- true_divide array case 166
do
  local a=np.array({-1,5,-7,5,-1},np.int32)
  local b=np.array({6,1,19,22,22},np.uint64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 166 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 166 shape')
  assert(seqeq(r.strides,{8}),'true_divide 166 strides')
  assert(veq(r:tolist(),{-0.16666666666666666,5.0,-0.3684210526315789,0.22727272727272727,-0.045454545454545456}),'true_divide 166 values')
end
-- true_divide array case 167
do
  local a=np.array({{22,20,1},{0,1,4}},np.uint16)
  local b=np.array({{-3.25,-0.5,-1.5}},np.float32)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float32','true_divide 167 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 167 shape')
  assert(seqeq(r.strides,{12,4}),'true_divide 167 strides')
  assert(veq(r:tolist(),{{-6.769230842590332,-40.0,-0.6666666865348816},{-0.0,-2.0,-2.6666667461395264}}),'true_divide 167 values')
end
-- true_divide array case 168
do
  local a=np.array({{{25},{18},{14}},{{21},{13},{2}}},np.uint8)
  local b=np.array({{{13,5,17,17},{4,15,25,18},{22,10,3,20}}},np.uint8)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 168 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'true_divide 168 shape')
  assert(seqeq(r.strides,{96,32,8}),'true_divide 168 strides')
  assert(veq(r:tolist(),{{{1.9230769230769231,5.0,1.4705882352941178,1.4705882352941178},{4.5,1.2,0.72,1.0},{0.6363636363636364,1.4,4.666666666666667,0.7}},{{1.6153846153846154,4.2,1.2352941176470589,1.2352941176470589},{3.25,0.8666666666666667,0.52,0.7222222222222222},{0.09090909090909091,0.2,0.6666666666666666,0.1}}}),'true_divide 168 values')
end
-- true_divide array case 169
do
  local a=np.array({{1.25,1.25,-0.5},{-1.5,7.75,-3.25}},np.float16)
  local b=np.array({-1,-7,2},np.int16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float32','true_divide 169 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 169 shape')
  assert(seqeq(r.strides,{12,4}),'true_divide 169 strides')
  assert(veq(r:tolist(),{{-1.25,-0.1785714328289032,-0.25},{1.5,-1.1071428060531616,-1.625}}),'true_divide 169 values')
end
-- true_divide array case 170
do
  local a=np.array({{20,1,17},{12,11,17}},np.uint16)
  local b=np.array({{2,2,-7}},np.int64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 170 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 170 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 170 strides')
  assert(veq(r:tolist(),{{10.0,0.5,-2.4285714285714284},{6.0,5.5,-2.4285714285714284}}),'true_divide 170 values')
end
-- true_divide array case 171
do
  local a=np.array({23,0,0,1,0},np.int64)
  local b=np.array({1.25,7.75,2.5,1.25,7.75},np.float64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 171 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 171 shape')
  assert(seqeq(r.strides,{8}),'true_divide 171 strides')
  assert(veq(r:tolist(),{18.4,0.0,0.0,0.8,0.0}),'true_divide 171 values')
end
-- true_divide array case 172
do
  local a=np.array({{-0.5,0.25,7.75},{0.25,-3.25,7.75}},np.float16)
  local b=np.array({5,11,23},np.int16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float32','true_divide 172 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 172 shape')
  assert(seqeq(r.strides,{12,4}),'true_divide 172 strides')
  assert(veq(r:tolist(),{{-0.10000000149011612,0.022727273404598236,0.33695653080940247},{0.05000000074505806,-0.2954545319080353,0.33695653080940247}}),'true_divide 172 values')
end
-- true_divide array case 173
do
  local a=np.array({{3,9,6},{25,5,6}},np.uint16)
  local b=np.array({1.25,-1.5,-3.25},np.float16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float32','true_divide 173 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 173 shape')
  assert(seqeq(r.strides,{12,4}),'true_divide 173 strides')
  assert(veq(r:tolist(),{{2.4000000953674316,-6.0,-1.8461538553237915},{20.0,-3.3333332538604736,-1.8461538553237915}}),'true_divide 173 values')
end
-- true_divide array case 174
do
  local a=np.array({{-0.5,-1.5,0.25},{-7.5,7.75,-7.5}},np.float16)
  local b=np.array({{-3,5,1}},np.int32)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 174 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 174 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 174 strides')
  assert(veq(r:tolist(),{{0.16666666666666666,-0.3,0.25},{2.5,1.55,-7.5}}),'true_divide 174 values')
end
-- true_divide array case 175
do
  local a=np.array({{1,7,10},{10,7,15}},np.uint64)
  local b=np.array({{-17,-7,-17}},np.int16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 175 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 175 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 175 strides')
  assert(veq(r:tolist(),{{-0.058823529411764705,-1.0,-0.5882352941176471},{-0.5882352941176471,-1.0,-0.8823529411764706}}),'true_divide 175 values')
end
-- true_divide array case 176
do
  local a=np.array({{-17,5,2},{0,0,1}},np.int32)
  local b=np.array({{11,2,-7}},np.int32)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 176 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 176 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 176 strides')
  assert(veq(r:tolist(),{{-1.5454545454545454,2.5,-0.2857142857142857},{0.0,0.0,-0.14285714285714285}}),'true_divide 176 values')
end
-- true_divide array case 177
do
  local a=np.array({{{-3},{-17},{2}},{{-7},{1},{-7}}},np.int32)
  local b=np.array({{{2,5,23,5},{2,11,1,11},{5,-1,-17,-7}}},np.int8)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 177 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'true_divide 177 shape')
  assert(seqeq(r.strides,{96,32,8}),'true_divide 177 strides')
  assert(veq(r:tolist(),{{{-1.5,-0.6,-0.13043478260869565,-0.6},{-8.5,-1.5454545454545454,-17.0,-1.5454545454545454},{0.4,-2.0,-0.11764705882352941,-0.2857142857142857}},{{-3.5,-1.4,-0.30434782608695654,-1.4},{0.5,0.09090909090909091,1.0,0.09090909090909091},{-1.4,7.0,0.4117647058823529,1.0}}}),'true_divide 177 values')
end
-- true_divide array case 178
do
  local a=np.array({23,-7,1,-7,-1},np.int8)
  local b=np.array({-17,23,-3,5,-3},np.int32)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 178 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 178 shape')
  assert(seqeq(r.strides,{8}),'true_divide 178 strides')
  assert(veq(r:tolist(),{-1.3529411764705883,-0.30434782608695654,-0.3333333333333333,-1.4,0.3333333333333333}),'true_divide 178 values')
end
-- true_divide array case 179
do
  local a=np.array({-7,11,-23,2,2},np.int16)
  local b=np.array({7.75,7.75,0.25,-0.5,1.25},np.float64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 179 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 179 shape')
  assert(seqeq(r.strides,{8}),'true_divide 179 strides')
  assert(veq(r:tolist(),{-0.9032258064516129,1.4193548387096775,-92.0,-4.0,1.6}),'true_divide 179 values')
end
-- true_divide array case 180
do
  local a=np.array({2,2,11,19,11},np.uint64)
  local b=np.array({true,true,true,true,true},np.bool)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 180 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 180 shape')
  assert(seqeq(r.strides,{8}),'true_divide 180 strides')
  assert(veq(r:tolist(),{2.0,2.0,11.0,19.0,11.0}),'true_divide 180 values')
end
-- true_divide array case 181
do
  local a=np.array({false,true,false,true,false},np.bool)
  local b=np.array({13,19,4,15,17},np.uint32)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 181 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 181 shape')
  assert(seqeq(r.strides,{8}),'true_divide 181 strides')
  assert(veq(r:tolist(),{0.0,0.05263157894736842,0.0,0.06666666666666667,0.0}),'true_divide 181 values')
end
-- true_divide array case 182
do
  local a=np.array({{{7},{2},{25}},{{3},{21},{10}}},np.uint8)
  local b=np.array({{{-0.5,2.5,0.25,-0.5},{1.25,0.25,2.5,-0.5},{-0.5,-7.5,7.75,2.5}}},np.float16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float16','true_divide 182 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'true_divide 182 shape')
  assert(seqeq(r.strides,{24,8,2}),'true_divide 182 strides')
  assert(veq(r:tolist(),{{{-14.0,2.80078125,28.0,-14.0},{1.599609375,8.0,0.7998046875,-4.0},{-50.0,-3.333984375,3.2265625,10.0}},{{-6.0,1.2001953125,12.0,-6.0},{16.796875,84.0,8.3984375,-42.0},{-20.0,-1.3330078125,1.2900390625,4.0}}}),'true_divide 182 values')
end
-- true_divide array case 183
do
  local a=np.array({{23,12,0},{0,24,8}},np.uint64)
  local b=np.array({{-17,5,2}},np.int8)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 183 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 183 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 183 strides')
  assert(veq(r:tolist(),{{-1.3529411764705883,2.4,0.0},{-0.0,4.8,4.0}}),'true_divide 183 values')
end
-- true_divide array case 184
do
  local a=np.array({{20,13,9},{10,14,16}},np.uint8)
  local b=np.array({8,1,19},np.uint8)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 184 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 184 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 184 strides')
  assert(veq(r:tolist(),{{2.5,13.0,0.47368421052631576},{1.25,14.0,0.8421052631578947}}),'true_divide 184 values')
end
-- true_divide array case 185
do
  local a=np.array({{5,0,4},{7,22,24}},np.uint64)
  local b=np.array({-3,1,1},np.int16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 185 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 185 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 185 strides')
  assert(veq(r:tolist(),{{-1.6666666666666667,0.0,4.0},{-2.3333333333333335,22.0,24.0}}),'true_divide 185 values')
end
-- true_divide array case 186
do
  local a=np.array({{{0.25},{-7.5},{7.75}},{{7.75},{7.75},{2.5}}},np.float16)
  local b=np.array({{{-3,-1,-3,5},{-3,-17,11,2},{11,-7,2,1}}},np.int16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float32','true_divide 186 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'true_divide 186 shape')
  assert(seqeq(r.strides,{48,16,4}),'true_divide 186 strides')
  assert(veq(r:tolist(),{{{-0.0833333358168602,-0.25,-0.0833333358168602,0.05000000074505806},{2.5,0.44117647409439087,-0.6818181872367859,-3.75},{0.7045454382896423,-1.1071428060531616,3.875,7.75}},{{-2.5833332538604736,-7.75,-2.5833332538604736,1.5499999523162842},{-2.5833332538604736,-0.45588234066963196,0.7045454382896423,3.875},{0.22727273404598236,-0.3571428656578064,1.25,2.5}}}),'true_divide 186 values')
end
-- true_divide array case 187
do
  local a=np.array({23,-17,11,5,5},np.int64)
  local b=np.array({3,10,9,12,17},np.uint32)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 187 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 187 shape')
  assert(seqeq(r.strides,{8}),'true_divide 187 strides')
  assert(veq(r:tolist(),{7.666666666666667,-1.7,1.2222222222222223,0.4166666666666667,0.29411764705882354}),'true_divide 187 values')
end
-- true_divide array case 188
do
  local a=np.array({{1.25,-1.5,-1.5},{7.75,7.75,-7.5}},np.float32)
  local b=np.array({{-3,-1,1}},np.int64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 188 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 188 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 188 strides')
  assert(veq(r:tolist(),{{-0.4166666666666667,1.5,-1.5},{-2.5833333333333335,-7.75,-7.5}}),'true_divide 188 values')
end
-- true_divide array case 189
do
  local a=np.array({{19,18,6},{25,2,22}},np.uint64)
  local b=np.array({2,9,14},np.uint16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 189 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 189 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 189 strides')
  assert(veq(r:tolist(),{{9.5,2.0,0.42857142857142855},{12.5,0.2222222222222222,1.5714285714285714}}),'true_divide 189 values')
end
-- true_divide array case 190
do
  local a=np.array({{11,4,11},{14,18,2}},np.uint32)
  local b=np.array({{1,11,-17}},np.int8)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 190 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 190 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 190 strides')
  assert(veq(r:tolist(),{{11.0,0.36363636363636365,-0.6470588235294118},{14.0,1.6363636363636365,-0.11764705882352941}}),'true_divide 190 values')
end
-- true_divide array case 191
do
  local a=np.array({{3,2,22},{23,3,8}},np.uint16)
  local b=np.array({{1.25,-1.5,7.75}},np.float16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float32','true_divide 191 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 191 shape')
  assert(seqeq(r.strides,{12,4}),'true_divide 191 strides')
  assert(veq(r:tolist(),{{2.4000000953674316,-1.3333333730697632,2.838709592819214},{18.399999618530273,-2.0,1.0322580337524414}}),'true_divide 191 values')
end
-- true_divide array case 192
do
  local a=np.array({{23,22,18},{23,11,18}},np.uint8)
  local b=np.array({{-17,-17,-3}},np.int16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 192 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 192 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 192 strides')
  assert(veq(r:tolist(),{{-1.3529411764705883,-1.2941176470588236,-6.0},{-1.3529411764705883,-0.6470588235294118,-6.0}}),'true_divide 192 values')
end
-- true_divide array case 193
do
  local a=np.array({{0.25,-0.5,1.25},{2.5,-0.5,2.5}},np.float16)
  local b=np.array({{11,11,8}},np.uint8)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float16','true_divide 193 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 193 shape')
  assert(seqeq(r.strides,{6,2}),'true_divide 193 strides')
  assert(veq(r:tolist(),{{0.0227203369140625,-0.045440673828125,0.15625},{0.227294921875,-0.045440673828125,0.3125}}),'true_divide 193 values')
end
-- true_divide array case 194
do
  local a=np.array({{-3.25},{-1.5}},np.float32)
  local b=np.array({{-17,-17,-17}},np.int16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float32','true_divide 194 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 194 shape')
  assert(seqeq(r.strides,{12,4}),'true_divide 194 strides')
  assert(veq(r:tolist(),{{0.19117647409439087,0.19117647409439087,0.19117647409439087},{0.0882352963089943,0.0882352963089943,0.0882352963089943}}),'true_divide 194 values')
end
-- true_divide array case 195
do
  local a=np.array({{{-23},{0},{11}},{{23},{5},{-1}}},np.int64)
  local b=np.array({{{-0.5,0.25,1.25,-0.5},{0.25,-7.5,-7.5,0.25},{2.5,-3.25,-0.5,7.75}}},np.float64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 195 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'true_divide 195 shape')
  assert(seqeq(r.strides,{96,32,8}),'true_divide 195 strides')
  assert(veq(r:tolist(),{{{46.0,-92.0,-18.4,46.0},{0.0,-0.0,-0.0,0.0},{4.4,-3.3846153846153846,-22.0,1.4193548387096775}},{{-46.0,92.0,18.4,-46.0},{20.0,-0.6666666666666666,-0.6666666666666666,20.0},{-0.4,0.3076923076923077,2.0,-0.12903225806451613}}}),'true_divide 195 values')
end
-- true_divide array case 196
do
  local a=np.array({-3.25,2.5,2.5,0.25,-0.5},np.float16)
  local b=np.array({true,true,true,true,true},np.bool)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float16','true_divide 196 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 196 shape')
  assert(seqeq(r.strides,{2}),'true_divide 196 strides')
  assert(veq(r:tolist(),{-3.25,2.5,2.5,0.25,-0.5}),'true_divide 196 values')
end
-- true_divide array case 197
do
  local a=np.array({{23,15,14},{22,14,23}},np.uint64)
  local b=np.array({-0.5,7.75,1.25},np.float16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 197 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 197 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 197 strides')
  assert(veq(r:tolist(),{{-46.0,1.935483870967742,11.2},{-44.0,1.8064516129032258,18.4}}),'true_divide 197 values')
end
-- true_divide array case 198
do
  local a=np.array({{7,12,19},{1,13,23}},np.uint16)
  local b=np.array({{0.25,2.5,1.25}},np.float64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 198 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 198 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 198 strides')
  assert(veq(r:tolist(),{{28.0,4.8,15.2},{4.0,5.2,18.4}}),'true_divide 198 values')
end
-- true_divide array case 199
do
  local a=np.array({{{-3},{-1},{0}},{{-7},{-17},{-23}}},np.int64)
  local b=np.array({{{5,-17,-7,-1},{-7,2,-1,11},{-7,-7,2,2}}},np.int32)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 199 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'true_divide 199 shape')
  assert(seqeq(r.strides,{96,32,8}),'true_divide 199 strides')
  assert(veq(r:tolist(),{{{-0.6,0.17647058823529413,0.42857142857142855,3.0},{0.14285714285714285,-0.5,1.0,-0.09090909090909091},{-0.0,-0.0,0.0,0.0}},{{-1.4,0.4117647058823529,1.0,7.0},{2.4285714285714284,-8.5,17.0,-1.5454545454545454},{3.2857142857142856,3.2857142857142856,-11.5,-11.5}}}),'true_divide 199 values')
end
-- true_divide array case 200
do
  local a=np.array({{23},{3}},np.uint64)
  local b=np.array({{20,16,1}},np.uint64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 200 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 200 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 200 strides')
  assert(veq(r:tolist(),{{1.15,1.4375,23.0},{0.15,0.1875,3.0}}),'true_divide 200 values')
end
-- true_divide array case 201
do
  local a=np.array({{{2.5},{7.75},{-3.25}},{{-7.5},{7.75},{-0.5}}},np.float32)
  local b=np.array({{{22,17,8,6},{25,15,4,16},{20,3,19,23}}},np.uint64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 201 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'true_divide 201 shape')
  assert(seqeq(r.strides,{96,32,8}),'true_divide 201 strides')
  assert(veq(r:tolist(),{{{0.11363636363636363,0.14705882352941177,0.3125,0.4166666666666667},{0.31,0.5166666666666667,1.9375,0.484375},{-0.1625,-1.0833333333333333,-0.17105263157894737,-0.14130434782608695}},{{-0.3409090909090909,-0.4411764705882353,-0.9375,-1.25},{0.31,0.5166666666666667,1.9375,0.484375},{-0.025,-0.16666666666666666,-0.02631578947368421,-0.021739130434782608}}}),'true_divide 201 values')
end
-- true_divide array case 202
do
  local a=np.array({{2.5,2.5,-0.5},{-3.25,1.25,-3.25}},np.float32)
  local b=np.array({2.5,-7.5,7.75},np.float16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float32','true_divide 202 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 202 shape')
  assert(seqeq(r.strides,{12,4}),'true_divide 202 strides')
  assert(veq(r:tolist(),{{1.0,-0.3333333432674408,-0.06451612710952759},{-1.2999999523162842,-0.1666666716337204,-0.4193548262119293}}),'true_divide 202 values')
end
-- true_divide array case 203
do
  local a=np.array({2.5,0.25,-3.25,2.5,7.75},np.float64)
  local b=np.array({23,23,-3,-1,-7},np.int8)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 203 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 203 shape')
  assert(seqeq(r.strides,{8}),'true_divide 203 strides')
  assert(veq(r:tolist(),{0.10869565217391304,0.010869565217391304,1.0833333333333333,-2.5,-1.1071428571428572}),'true_divide 203 values')
end
-- true_divide array case 204
do
  local a=np.array({{-23,-17,-3},{23,23,-23}},np.int16)
  local b=np.array({{13,5,3}},np.uint64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 204 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 204 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 204 strides')
  assert(veq(r:tolist(),{{-1.7692307692307692,-3.4,-1.0},{1.7692307692307692,4.6,-7.666666666666667}}),'true_divide 204 values')
end
-- true_divide array case 205
do
  local a=np.array({{-3,-1,11},{-23,11,23}},np.int8)
  local b=np.array({true,true,true},np.bool)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 205 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 205 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 205 strides')
  assert(veq(r:tolist(),{{-3.0,-1.0,11.0},{-23.0,11.0,23.0}}),'true_divide 205 values')
end
-- true_divide array case 206
do
  local a=np.array({{-0.5,7.75,-7.5},{2.5,0.25,-7.5}},np.float64)
  local b=np.array({{9,12,11}},np.uint8)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 206 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 206 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 206 strides')
  assert(veq(r:tolist(),{{-0.05555555555555555,0.6458333333333334,-0.6818181818181818},{0.2777777777777778,0.020833333333333332,-0.6818181818181818}}),'true_divide 206 values')
end
-- true_divide array case 207
do
  local a=np.array({{11,1,-17},{-7,11,2}},np.int64)
  local b=np.array({{7.75,-7.5,7.75}},np.float64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 207 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 207 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 207 strides')
  assert(veq(r:tolist(),{{1.4193548387096775,-0.13333333333333333,-2.193548387096774},{-0.9032258064516129,-1.4666666666666666,0.25806451612903225}}),'true_divide 207 values')
end
-- true_divide array case 208
do
  local a=np.array({{15,15,8},{16,23,13}},np.uint32)
  local b=np.array({{7.75,-1.5,0.25}},np.float64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 208 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 208 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 208 strides')
  assert(veq(r:tolist(),{{1.935483870967742,-10.0,32.0},{2.064516129032258,-15.333333333333334,52.0}}),'true_divide 208 values')
end
-- true_divide array case 209
do
  local a=np.array({{7.75},{-7.5}},np.float64)
  local b=np.array({{2,-3,5}},np.int8)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 209 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 209 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 209 strides')
  assert(veq(r:tolist(),{{3.875,-2.5833333333333335,1.55},{-3.75,2.5,-1.5}}),'true_divide 209 values')
end
-- true_divide array case 210
do
  local a=np.array({{5,-3,-7},{0,0,0}},np.int64)
  local b=np.array({1,-3,5},np.int32)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 210 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 210 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 210 strides')
  assert(veq(r:tolist(),{{5.0,1.0,-1.4},{0.0,-0.0,0.0}}),'true_divide 210 values')
end
-- true_divide array case 211
do
  local a=np.array({0,13,22,11,8},np.uint32)
  local b=np.array({5,1,11,-17,-1},np.int8)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 211 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 211 shape')
  assert(seqeq(r.strides,{8}),'true_divide 211 strides')
  assert(veq(r:tolist(),{0.0,13.0,2.0,-0.6470588235294118,-8.0}),'true_divide 211 values')
end
-- true_divide array case 212
do
  local a=np.array({{0,2,0},{0,23,0}},np.int32)
  local b=np.array({-1,2,2},np.int8)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 212 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 212 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 212 strides')
  assert(veq(r:tolist(),{{-0.0,1.0,0.0},{-0.0,11.5,0.0}}),'true_divide 212 values')
end
-- true_divide array case 213
do
  local a=np.array({24,1,15,0,2},np.uint16)
  local b=np.array({13,13,25,18,4},np.uint64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 213 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 213 shape')
  assert(seqeq(r.strides,{8}),'true_divide 213 strides')
  assert(veq(r:tolist(),{1.8461538461538463,0.07692307692307693,0.6,0.0,0.5}),'true_divide 213 values')
end
-- true_divide array case 214
do
  local a=np.array({{{4},{11},{25}},{{20},{10},{15}}},np.uint16)
  local b=np.array({{{10,9,5,5},{8,2,23,15},{20,13,25,1}}},np.uint8)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 214 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'true_divide 214 shape')
  assert(seqeq(r.strides,{96,32,8}),'true_divide 214 strides')
  assert(veq(r:tolist(),{{{0.4,0.4444444444444444,0.8,0.8},{1.375,5.5,0.4782608695652174,0.7333333333333333},{1.25,1.9230769230769231,1.0,25.0}},{{2.0,2.2222222222222223,4.0,4.0},{1.25,5.0,0.43478260869565216,0.6666666666666666},{0.75,1.1538461538461537,0.6,15.0}}}),'true_divide 214 values')
end
-- true_divide array case 215
do
  local a=np.array({{1.25,-3.25,-1.5},{-7.5,-1.5,0.25}},np.float16)
  local b=np.array({{20,5,5}},np.uint8)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float16','true_divide 215 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 215 shape')
  assert(seqeq(r.strides,{6,2}),'true_divide 215 strides')
  assert(veq(r:tolist(),{{0.0625,-0.64990234375,-0.300048828125},{-0.375,-0.300048828125,0.04998779296875}}),'true_divide 215 values')
end
-- true_divide array case 216
do
  local a=np.array({{1.25,-0.5,-0.5},{-3.25,-0.5,2.5}},np.float32)
  local b=np.array({17,11,4},np.uint64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 216 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 216 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 216 strides')
  assert(veq(r:tolist(),{{0.07352941176470588,-0.045454545454545456,-0.125},{-0.19117647058823528,-0.045454545454545456,0.625}}),'true_divide 216 values')
end
-- true_divide array case 217
do
  local a=np.array({{-3,-3,5},{23,2,5}},np.int32)
  local b=np.array({{4,3,3}},np.uint16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 217 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 217 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 217 strides')
  assert(veq(r:tolist(),{{-0.75,-1.0,1.6666666666666667},{5.75,0.6666666666666666,1.6666666666666667}}),'true_divide 217 values')
end
-- true_divide array case 218
do
  local a=np.array({{8},{17}},np.uint16)
  local b=np.array({{7.75,-3.25,-7.5}},np.float64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 218 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 218 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 218 strides')
  assert(veq(r:tolist(),{{1.032258064516129,-2.4615384615384617,-1.0666666666666667},{2.193548387096774,-5.230769230769231,-2.2666666666666666}}),'true_divide 218 values')
end
-- true_divide array case 219
do
  local a=np.array({{17,10,15},{24,13,1}},np.uint16)
  local b=np.array({{5,21,23}},np.uint32)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 219 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 219 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 219 strides')
  assert(veq(r:tolist(),{{3.4,0.47619047619047616,0.6521739130434783},{4.8,0.6190476190476191,0.043478260869565216}}),'true_divide 219 values')
end
-- true_divide array case 220
do
  local a=np.array({{-7.5,-3.25,-1.5},{1.25,1.25,0.25}},np.float64)
  local b=np.array({{2.5,1.25,-3.25}},np.float32)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 220 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 220 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 220 strides')
  assert(veq(r:tolist(),{{-3.0,-2.6,0.46153846153846156},{0.5,1.0,-0.07692307692307693}}),'true_divide 220 values')
end
-- true_divide array case 221
do
  local a=np.array({{{-7.5},{-7.5},{-0.5}},{{-0.5},{-1.5},{-0.5}}},np.float16)
  local b=np.array({{{4,19,3,24},{22,23,11,7},{3,6,22,1}}},np.uint16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float32','true_divide 221 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'true_divide 221 shape')
  assert(seqeq(r.strides,{48,16,4}),'true_divide 221 strides')
  assert(veq(r:tolist(),{{{-1.875,-0.3947368562221527,-2.5,-0.3125},{-0.34090909361839294,-0.32608696818351746,-0.6818181872367859,-1.0714285373687744},{-0.1666666716337204,-0.0833333358168602,-0.022727273404598236,-0.5}},{{-0.125,-0.02631578966975212,-0.1666666716337204,-0.02083333395421505},{-0.06818182021379471,-0.06521739065647125,-0.13636364042758942,-0.2142857164144516},{-0.1666666716337204,-0.0833333358168602,-0.022727273404598236,-0.5}}}),'true_divide 221 values')
end
-- true_divide array case 222
do
  local a=np.array({{{-23},{23},{-7}},{{0},{5},{-1}}},np.int8)
  local b=np.array({{{-7.5,0.25,-7.5,-7.5},{1.25,0.25,-0.5,0.25},{-3.25,7.75,1.25,2.5}}},np.float64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 222 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'true_divide 222 shape')
  assert(seqeq(r.strides,{96,32,8}),'true_divide 222 strides')
  assert(veq(r:tolist(),{{{3.066666666666667,-92.0,3.066666666666667,3.066666666666667},{18.4,92.0,-46.0,92.0},{2.1538461538461537,-0.9032258064516129,-5.6,-2.8}},{{-0.0,0.0,-0.0,-0.0},{4.0,20.0,-10.0,20.0},{0.3076923076923077,-0.12903225806451613,-0.8,-0.4}}}),'true_divide 222 values')
end
-- true_divide array case 223
do
  local a=np.array({{8,20,17},{13,20,7}},np.uint32)
  local b=np.array({{7.75,-7.5,-3.25}},np.float32)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 223 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 223 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 223 strides')
  assert(veq(r:tolist(),{{1.032258064516129,-2.6666666666666665,-5.230769230769231},{1.6774193548387097,-2.6666666666666665,-2.1538461538461537}}),'true_divide 223 values')
end
-- true_divide array case 224
do
  local a=np.array({{25},{2}},np.uint64)
  local b=np.array({{1,12,25}},np.uint32)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 224 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 224 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 224 strides')
  assert(veq(r:tolist(),{{25.0,2.0833333333333335,1.0},{2.0,0.16666666666666666,0.08}}),'true_divide 224 values')
end
-- true_divide array case 225
do
  local a=np.array({1.25,1.25,1.25,-3.25,0.25},np.float32)
  local b=np.array({2,-3,-3,-17,1},np.int64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 225 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 225 shape')
  assert(seqeq(r.strides,{8}),'true_divide 225 strides')
  assert(veq(r:tolist(),{0.625,-0.4166666666666667,-0.4166666666666667,0.19117647058823528,0.25}),'true_divide 225 values')
end
-- true_divide array case 226
do
  local a=np.array({{1,11,-3},{23,-7,11}},np.int8)
  local b=np.array({1,-1,5},np.int16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 226 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 226 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 226 strides')
  assert(veq(r:tolist(),{{1.0,-11.0,-0.6},{23.0,7.0,2.2}}),'true_divide 226 values')
end
-- true_divide array case 227
do
  local a=np.array({{{-23},{-7},{0}},{{-17},{5},{-1}}},np.int8)
  local b=np.array({{{true,true,true,true},{true,true,true,true},{true,true,true,true}}},np.bool)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 227 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'true_divide 227 shape')
  assert(seqeq(r.strides,{96,32,8}),'true_divide 227 strides')
  assert(veq(r:tolist(),{{{-23.0,-23.0,-23.0,-23.0},{-7.0,-7.0,-7.0,-7.0},{0.0,0.0,0.0,0.0}},{{-17.0,-17.0,-17.0,-17.0},{5.0,5.0,5.0,5.0},{-1.0,-1.0,-1.0,-1.0}}}),'true_divide 227 values')
end
-- true_divide array case 228
do
  local a=np.array({{{10},{19},{11}},{{3},{9},{8}}},np.uint16)
  local b=np.array({{{11,2,1,-1},{-17,2,23,-1},{1,-7,23,5}}},np.int64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 228 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'true_divide 228 shape')
  assert(seqeq(r.strides,{96,32,8}),'true_divide 228 strides')
  assert(veq(r:tolist(),{{{0.9090909090909091,5.0,10.0,-10.0},{-1.1176470588235294,9.5,0.8260869565217391,-19.0},{11.0,-1.5714285714285714,0.4782608695652174,2.2}},{{0.2727272727272727,1.5,3.0,-3.0},{-0.5294117647058824,4.5,0.391304347826087,-9.0},{8.0,-1.1428571428571428,0.34782608695652173,1.6}}}),'true_divide 228 values')
end
-- true_divide array case 229
do
  local a=np.array({{false},{true}},np.bool)
  local b=np.array({{true,true,true}},np.bool)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 229 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 229 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 229 strides')
  assert(veq(r:tolist(),{{0.0,0.0,0.0},{1.0,1.0,1.0}}),'true_divide 229 values')
end
-- true_divide array case 230
do
  local a=np.array({{1},{-7}},np.int8)
  local b=np.array({{true,true,true}},np.bool)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 230 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 230 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 230 strides')
  assert(veq(r:tolist(),{{1.0,1.0,1.0},{-7.0,-7.0,-7.0}}),'true_divide 230 values')
end
-- true_divide array case 231
do
  local a=np.array({{{false},{true},{true}},{{true},{true},{false}}},np.bool)
  local b=np.array({{{-7.5,0.25,0.25,-3.25},{2.5,0.25,-0.5,0.25},{7.75,1.25,-3.25,-7.5}}},np.float16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float16','true_divide 231 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'true_divide 231 shape')
  assert(seqeq(r.strides,{24,8,2}),'true_divide 231 strides')
  assert(veq(r:tolist(),{{{-0.0,0.0,0.0,-0.0},{0.39990234375,4.0,-2.0,4.0},{0.1290283203125,0.7998046875,-0.3076171875,-0.13330078125}},{{-0.13330078125,4.0,4.0,-0.3076171875},{0.39990234375,4.0,-2.0,4.0},{0.0,0.0,-0.0,-0.0}}}),'true_divide 231 values')
end
-- true_divide array case 232
do
  local a=np.array({{0},{-17}},np.int8)
  local b=np.array({{2,-1,11}},np.int32)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 232 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 232 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 232 strides')
  assert(veq(r:tolist(),{{0.0,-0.0,0.0},{-8.5,17.0,-1.5454545454545454}}),'true_divide 232 values')
end
-- true_divide array case 233
do
  local a=np.array({1,10,11,23,1},np.uint8)
  local b=np.array({10,20,14,22,11},np.uint8)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 233 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'true_divide 233 shape')
  assert(seqeq(r.strides,{8}),'true_divide 233 strides')
  assert(veq(r:tolist(),{0.1,0.5,0.7857142857142857,1.0454545454545454,0.09090909090909091}),'true_divide 233 values')
end
-- true_divide array case 234
do
  local a=np.array({{11,-1,-23},{-7,0,-7}},np.int8)
  local b=np.array({{7.75,0.25,7.75}},np.float64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 234 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 234 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 234 strides')
  assert(veq(r:tolist(),{{1.4193548387096775,-4.0,-2.967741935483871},{-0.9032258064516129,0.0,-0.9032258064516129}}),'true_divide 234 values')
end
-- true_divide array case 235
do
  local a=np.array({{0,-3,23},{2,11,-17}},np.int8)
  local b=np.array({{true,true,true}},np.bool)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 235 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 235 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 235 strides')
  assert(veq(r:tolist(),{{0.0,-3.0,23.0},{2.0,11.0,-17.0}}),'true_divide 235 values')
end
-- true_divide array case 236
do
  local a=np.array({{1},{11}},np.int32)
  local b=np.array({{7.75,-0.5,7.75}},np.float64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 236 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 236 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 236 strides')
  assert(veq(r:tolist(),{{0.12903225806451613,-2.0,0.12903225806451613},{1.4193548387096775,-22.0,1.4193548387096775}}),'true_divide 236 values')
end
-- true_divide array case 237
do
  local a=np.array({{-17},{-3}},np.int32)
  local b=np.array({{7.75,1.25,-3.25}},np.float16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 237 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 237 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 237 strides')
  assert(veq(r:tolist(),{{-2.193548387096774,-13.6,5.230769230769231},{-0.3870967741935484,-2.4,0.9230769230769231}}),'true_divide 237 values')
end
-- true_divide array case 238
do
  local a=np.array({{{-1.5},{-3.25},{2.5}},{{1.25},{7.75},{-1.5}}},np.float32)
  local b=np.array({{{11,-3,5,-3},{23,1,-7,-1},{11,5,1,-3}}},np.int16)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float32','true_divide 238 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'true_divide 238 shape')
  assert(seqeq(r.strides,{48,16,4}),'true_divide 238 strides')
  assert(veq(r:tolist(),{{{-0.13636364042758942,0.5,-0.30000001192092896,0.5},{-0.14130434393882751,-3.25,0.4642857015132904,3.25},{0.22727273404598236,0.5,2.5,-0.8333333134651184}},{{0.11363636702299118,-0.4166666567325592,0.25,-0.4166666567325592},{0.33695653080940247,7.75,-1.1071428060531616,-7.75},{-0.13636364042758942,-0.30000001192092896,-1.5,0.5}}}),'true_divide 238 values')
end
-- true_divide array case 239
do
  local a=np.array({{1,-7,23},{-3,-3,11}},np.int8)
  local b=np.array({13,22,15},np.uint8)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','true_divide 239 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'true_divide 239 shape')
  assert(seqeq(r.strides,{24,8}),'true_divide 239 strides')
  assert(veq(r:tolist(),{{0.07692307692307693,-0.3181818181818182,1.5333333333333334},{-0.23076923076923078,-0.13636363636363635,0.7333333333333333}}),'true_divide 239 values')
end
-- subtract weak-scalar case 0
do
  local a=np.array({2,24,10,9,14},np.uint16)
  local r=np.subtract(a,5)
  assert(r.dtype=='uint16','scalar 0 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 0 shape')
  assert(veq(r:tolist(),{65533,19,5,4,9}),'scalar 0 values')
end
-- subtract weak-scalar case 1
do
  local a=np.array({{12},{11}},np.uint16)
  local r=np.subtract(7.0,a)
  assert(r.dtype=='float64','scalar 1 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 1 shape')
  assert(veq(r:tolist(),{{-5.0},{-4.0}}),'scalar 1 values')
end
-- subtract weak-scalar case 2
do
  local a=np.array({{-1,23,23}},np.int16)
  local r=np.subtract(a,-7)
  assert(r.dtype=='int16','scalar 2 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 2 shape')
  assert(veq(r:tolist(),{{6,30,30}}),'scalar 2 values')
end
-- subtract weak-scalar case 3
do
  local a=np.array({8,3,9,9,15},np.uint64)
  local r=np.subtract(a,-2.0)
  assert(r.dtype=='float64','scalar 3 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 3 shape')
  assert(veq(r:tolist(),{10.0,5.0,11.0,11.0,17.0}),'scalar 3 values')
end
-- subtract weak-scalar case 4
do
  local a=np.array({{25,3,4}},np.uint16)
  local r=np.subtract(a,-5.5)
  assert(r.dtype=='float64','scalar 4 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 4 shape')
  assert(veq(r:tolist(),{{30.5,8.5,9.5}}),'scalar 4 values')
end
-- subtract weak-scalar case 5
do
  local a=np.array({{0.25,-7.5,0.25},{-3.25,1.25,1.25}},np.float64)
  local r=np.subtract(-1,a)
  assert(r.dtype=='float64','scalar 5 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 5 shape')
  assert(veq(r:tolist(),{{-1.25,6.5,-1.25},{2.25,-2.25,-2.25}}),'scalar 5 values')
end
-- subtract weak-scalar case 6
do
  local a=np.array({19,19,4,14,24},np.uint8)
  local r=np.subtract(a,-2.0)
  assert(r.dtype=='float64','scalar 6 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 6 shape')
  assert(veq(r:tolist(),{21.0,21.0,6.0,16.0,26.0}),'scalar 6 values')
end
-- subtract weak-scalar case 7
do
  local a=np.array({false,true,true,false,false},np.bool)
  local r=np.subtract(a,-7)
  assert(r.dtype=='int64','scalar 7 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 7 shape')
  assert(veq(r:tolist(),{7,8,8,7,7}),'scalar 7 values')
end
-- subtract weak-scalar case 8
do
  local a=np.array({{true},{true}},np.bool)
  local r=np.subtract(a,2)
  assert(r.dtype=='int64','scalar 8 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 8 shape')
  assert(veq(r:tolist(),{{-1},{-1}}),'scalar 8 values')
end
-- subtract weak-scalar case 9
do
  local a=np.array({5,5,23,-17,-1},np.int64)
  local r=np.subtract(a,5)
  assert(r.dtype=='int64','scalar 9 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 9 shape')
  assert(veq(r:tolist(),{0,0,18,-22,-6}),'scalar 9 values')
end
-- subtract weak-scalar case 10
do
  local a=np.array({{0},{-3}},np.int16)
  local r=np.subtract(5,a)
  assert(r.dtype=='int16','scalar 10 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 10 shape')
  assert(veq(r:tolist(),{{5},{8}}),'scalar 10 values')
end
-- subtract weak-scalar case 11
do
  local a=np.array({15,9,18,2,1},np.uint16)
  local r=np.subtract(a,2.5)
  assert(r.dtype=='float64','scalar 11 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 11 shape')
  assert(veq(r:tolist(),{12.5,6.5,15.5,-0.5,-1.5}),'scalar 11 values')
end
-- subtract weak-scalar case 12
do
  local a=np.array({{-3.25,2.5,-3.25},{-0.5,1.25,-0.5}},np.float32)
  local r=np.subtract(a,-2.0)
  assert(r.dtype=='float32','scalar 12 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 12 shape')
  assert(veq(r:tolist(),{{-1.25,4.5,-1.25},{1.5,3.25,1.5}}),'scalar 12 values')
end
-- subtract weak-scalar case 13
do
  local a=np.array({{1,-23,2}},np.int8)
  local r=np.subtract(-1,a)
  assert(r.dtype=='int8','scalar 13 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 13 shape')
  assert(veq(r:tolist(),{{-2,22,-3}}),'scalar 13 values')
end
-- subtract weak-scalar case 14
do
  local a=np.array({{-23,1,1},{0,23,-7}},np.int64)
  local r=np.subtract(2,a)
  assert(r.dtype=='int64','scalar 14 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 14 shape')
  assert(veq(r:tolist(),{{25,1,1},{2,-21,9}}),'scalar 14 values')
end
-- subtract weak-scalar case 15
do
  local a=np.array({false,false,false,true,false},np.bool)
  local r=np.subtract(-7,a)
  assert(r.dtype=='int64','scalar 15 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 15 shape')
  assert(veq(r:tolist(),{-7,-7,-7,-8,-7}),'scalar 15 values')
end
-- subtract weak-scalar case 16
do
  local a=np.array({{7.75,0.25,-1.5},{0.25,-1.5,-1.5}},np.float64)
  local r=np.subtract(-7,a)
  assert(r.dtype=='float64','scalar 16 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 16 shape')
  assert(veq(r:tolist(),{{-14.75,-7.25,-5.5},{-7.25,-5.5,-5.5}}),'scalar 16 values')
end
-- subtract weak-scalar case 17
do
  local a=np.array({16,23,9,13,11},np.uint64)
  local r=np.subtract(a,1)
  assert(r.dtype=='uint64','scalar 17 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 17 shape')
  assert(veq(r:tolist(),{15,22,8,12,10}),'scalar 17 values')
end
-- subtract weak-scalar case 18
do
  local a=np.array({{-3,23,1},{11,-3,2}},np.int16)
  local r=np.subtract(a,11)
  assert(r.dtype=='int16','scalar 18 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 18 shape')
  assert(veq(r:tolist(),{{-14,12,-10},{0,-14,-9}}),'scalar 18 values')
end
-- subtract weak-scalar case 19
do
  local a=np.array({{7},{18}},np.uint8)
  local r=np.subtract(11,a)
  assert(r.dtype=='uint8','scalar 19 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 19 shape')
  assert(veq(r:tolist(),{{4},{249}}),'scalar 19 values')
end
-- subtract weak-scalar case 20
do
  local a=np.array({2.5,-1.5,1.25,-0.5,0.25},np.float16)
  local r=np.subtract(a,5)
  assert(r.dtype=='float16','scalar 20 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 20 shape')
  assert(veq(r:tolist(),{-2.5,-6.5,-3.75,-5.5,-4.75}),'scalar 20 values')
end
-- subtract weak-scalar case 21
do
  local a=np.array({-1,-23,-7,5,-23},np.int8)
  local r=np.subtract(a,-1)
  assert(r.dtype=='int8','scalar 21 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 21 shape')
  assert(veq(r:tolist(),{0,-22,-6,6,-22}),'scalar 21 values')
end
-- subtract weak-scalar case 22
do
  local a=np.array({{5},{1}},np.int32)
  local r=np.subtract(a,-1)
  assert(r.dtype=='int32','scalar 22 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 22 shape')
  assert(veq(r:tolist(),{{6},{2}}),'scalar 22 values')
end
-- subtract weak-scalar case 23
do
  local a=np.array({23,1,5,-17,1},np.int32)
  local r=np.subtract(1,a)
  assert(r.dtype=='int32','scalar 23 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 23 shape')
  assert(veq(r:tolist(),{-22,0,-4,18,0}),'scalar 23 values')
end
-- subtract weak-scalar case 24
do
  local a=np.array({{2,13,3}},np.uint16)
  local r=np.subtract(1,a)
  assert(r.dtype=='uint16','scalar 24 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 24 shape')
  assert(veq(r:tolist(),{{65535,65524,65534}}),'scalar 24 values')
end
-- subtract weak-scalar case 25
do
  local a=np.array({{11,-23,-17},{-17,-1,-7}},np.int32)
  local r=np.subtract(1,a)
  assert(r.dtype=='int32','scalar 25 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 25 shape')
  assert(veq(r:tolist(),{{-10,24,18},{18,2,8}}),'scalar 25 values')
end
-- subtract weak-scalar case 26
do
  local a=np.array({{0,-17,5}},np.int32)
  local r=np.subtract(a,7.0)
  assert(r.dtype=='float64','scalar 26 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 26 shape')
  assert(veq(r:tolist(),{{-7.0,-24.0,-2.0}}),'scalar 26 values')
end
-- subtract weak-scalar case 27
do
  local a=np.array({{-3.25,-1.5,-7.5},{0.25,-7.5,7.75}},np.float32)
  local r=np.subtract(7.0,a)
  assert(r.dtype=='float32','scalar 27 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 27 shape')
  assert(veq(r:tolist(),{{10.25,8.5,14.5},{6.75,14.5,-0.75}}),'scalar 27 values')
end
-- subtract weak-scalar case 28
do
  local a=np.array({{-3},{23}},np.int16)
  local r=np.subtract(a,-2)
  assert(r.dtype=='int16','scalar 28 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 28 shape')
  assert(veq(r:tolist(),{{-1},{25}}),'scalar 28 values')
end
-- subtract weak-scalar case 29
do
  local a=np.array({{1.25},{-3.25}},np.float16)
  local r=np.subtract(-7,a)
  assert(r.dtype=='float16','scalar 29 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 29 shape')
  assert(veq(r:tolist(),{{-8.25},{-3.75}}),'scalar 29 values')
end
-- subtract weak-scalar case 30
do
  local a=np.array({{-0.5},{2.5}},np.float64)
  local r=np.subtract(a,-2)
  assert(r.dtype=='float64','scalar 30 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 30 shape')
  assert(veq(r:tolist(),{{1.5},{4.5}}),'scalar 30 values')
end
-- subtract weak-scalar case 31
do
  local a=np.array({{18,25,15},{20,3,3}},np.uint32)
  local r=np.subtract(2,a)
  assert(r.dtype=='uint32','scalar 31 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 31 shape')
  assert(veq(r:tolist(),{{4294967280,4294967273,4294967283},{4294967278,4294967295,4294967295}}),'scalar 31 values')
end
-- subtract weak-scalar case 32
do
  local a=np.array({{-23,-7,-17}},np.int32)
  local r=np.subtract(2,a)
  assert(r.dtype=='int32','scalar 32 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 32 shape')
  assert(veq(r:tolist(),{{25,9,19}}),'scalar 32 values')
end
-- subtract weak-scalar case 33
do
  local a=np.array({{11},{0}},np.int8)
  local r=np.subtract(5,a)
  assert(r.dtype=='int8','scalar 33 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 33 shape')
  assert(veq(r:tolist(),{{-6},{5}}),'scalar 33 values')
end
-- subtract weak-scalar case 34
do
  local a=np.array({15,18,25,3,21},np.uint8)
  local r=np.subtract(a,0.5)
  assert(r.dtype=='float64','scalar 34 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 34 shape')
  assert(veq(r:tolist(),{14.5,17.5,24.5,2.5,20.5}),'scalar 34 values')
end
-- subtract weak-scalar case 35
do
  local a=np.array({{1,-7,0}},np.int16)
  local r=np.subtract(a,2)
  assert(r.dtype=='int16','scalar 35 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 35 shape')
  assert(veq(r:tolist(),{{-1,-9,-2}}),'scalar 35 values')
end
-- subtract weak-scalar case 36
do
  local a=np.array({{-3},{-17}},np.int8)
  local r=np.subtract(a,1)
  assert(r.dtype=='int8','scalar 36 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 36 shape')
  assert(veq(r:tolist(),{{-4},{-18}}),'scalar 36 values')
end
-- subtract weak-scalar case 37
do
  local a=np.array({-0.5,-1.5,2.5,-1.5,1.25},np.float64)
  local r=np.subtract(-2,a)
  assert(r.dtype=='float64','scalar 37 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 37 shape')
  assert(veq(r:tolist(),{-1.5,-0.5,-4.5,-0.5,-3.25}),'scalar 37 values')
end
-- subtract weak-scalar case 38
do
  local a=np.array({{-7.5},{2.5}},np.float64)
  local r=np.subtract(a,0.5)
  assert(r.dtype=='float64','scalar 38 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 38 shape')
  assert(veq(r:tolist(),{{-8.0},{2.0}}),'scalar 38 values')
end
-- subtract weak-scalar case 39
do
  local a=np.array({1,0,13,18,24},np.uint16)
  local r=np.subtract(0.5,a)
  assert(r.dtype=='float64','scalar 39 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 39 shape')
  assert(veq(r:tolist(),{-0.5,0.5,-12.5,-17.5,-23.5}),'scalar 39 values')
end
-- subtract weak-scalar case 40
do
  local a=np.array({-23,2,0,-1,11},np.int8)
  local r=np.subtract(-5.5,a)
  assert(r.dtype=='float64','scalar 40 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 40 shape')
  assert(veq(r:tolist(),{17.5,-7.5,-5.5,-4.5,-16.5}),'scalar 40 values')
end
-- subtract weak-scalar case 41
do
  local a=np.array({{0,2,-23},{23,0,2}},np.int16)
  local r=np.subtract(a,-7)
  assert(r.dtype=='int16','scalar 41 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 41 shape')
  assert(veq(r:tolist(),{{7,9,-16},{30,7,9}}),'scalar 41 values')
end
-- subtract weak-scalar case 42
do
  local a=np.array({0,1,-1,5,11},np.int32)
  local r=np.subtract(a,-5.5)
  assert(r.dtype=='float64','scalar 42 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 42 shape')
  assert(veq(r:tolist(),{5.5,6.5,4.5,10.5,16.5}),'scalar 42 values')
end
-- subtract weak-scalar case 43
do
  local a=np.array({{23},{1}},np.int16)
  local r=np.subtract(a,2)
  assert(r.dtype=='int16','scalar 43 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 43 shape')
  assert(veq(r:tolist(),{{21},{-1}}),'scalar 43 values')
end
-- subtract weak-scalar case 44
do
  local a=np.array({{13},{20}},np.uint32)
  local r=np.subtract(1,a)
  assert(r.dtype=='uint32','scalar 44 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 44 shape')
  assert(veq(r:tolist(),{{4294967284},{4294967277}}),'scalar 44 values')
end
-- subtract weak-scalar case 45
do
  local a=np.array({14,19,9,19,9},np.uint8)
  local r=np.subtract(a,-2.0)
  assert(r.dtype=='float64','scalar 45 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 45 shape')
  assert(veq(r:tolist(),{16.0,21.0,11.0,21.0,11.0}),'scalar 45 values')
end
-- subtract weak-scalar case 46
do
  local a=np.array({{-1,-1,0}},np.int64)
  local r=np.subtract(a,-1)
  assert(r.dtype=='int64','scalar 46 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 46 shape')
  assert(veq(r:tolist(),{{0,0,1}}),'scalar 46 values')
end
-- subtract weak-scalar case 47
do
  local a=np.array({{4},{24}},np.uint64)
  local r=np.subtract(a,-2.0)
  assert(r.dtype=='float64','scalar 47 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 47 shape')
  assert(veq(r:tolist(),{{6.0},{26.0}}),'scalar 47 values')
end
-- subtract weak-scalar case 48
do
  local a=np.array({{0,2,11}},np.int32)
  local r=np.subtract(-7,a)
  assert(r.dtype=='int32','scalar 48 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 48 shape')
  assert(veq(r:tolist(),{{-7,-9,-18}}),'scalar 48 values')
end
-- subtract weak-scalar case 49
do
  local a=np.array({{0,13,4}},np.uint8)
  local r=np.subtract(a,7.0)
  assert(r.dtype=='float64','scalar 49 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 49 shape')
  assert(veq(r:tolist(),{{-7.0,6.0,-3.0}}),'scalar 49 values')
end
-- subtract weak-scalar case 50
do
  local a=np.array({{11,11,13},{12,17,21}},np.uint32)
  local r=np.subtract(a,11)
  assert(r.dtype=='uint32','scalar 50 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 50 shape')
  assert(veq(r:tolist(),{{0,0,2},{1,6,10}}),'scalar 50 values')
end
-- subtract weak-scalar case 51
do
  local a=np.array({{-1},{2}},np.int16)
  local r=np.subtract(-2,a)
  assert(r.dtype=='int16','scalar 51 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 51 shape')
  assert(veq(r:tolist(),{{-1},{-4}}),'scalar 51 values')
end
-- subtract weak-scalar case 52
do
  local a=np.array({{7,4,22}},np.uint32)
  local r=np.subtract(5,a)
  assert(r.dtype=='uint32','scalar 52 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 52 shape')
  assert(veq(r:tolist(),{{4294967294,1,4294967279}}),'scalar 52 values')
end
-- subtract weak-scalar case 53
do
  local a=np.array({-1.5,1.25,-0.5,-0.5,-1.5},np.float32)
  local r=np.subtract(a,5)
  assert(r.dtype=='float32','scalar 53 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 53 shape')
  assert(veq(r:tolist(),{-6.5,-3.75,-5.5,-5.5,-6.5}),'scalar 53 values')
end
-- subtract weak-scalar case 54
do
  local a=np.array({11,0,23,-17,-23},np.int8)
  local r=np.subtract(a,-2)
  assert(r.dtype=='int8','scalar 54 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 54 shape')
  assert(veq(r:tolist(),{13,2,25,-15,-21}),'scalar 54 values')
end
-- subtract weak-scalar case 55
do
  local a=np.array({{true,true,false},{true,false,false}},np.bool)
  local r=np.subtract(a,-1)
  assert(r.dtype=='int64','scalar 55 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 55 shape')
  assert(veq(r:tolist(),{{2,2,1},{2,1,1}}),'scalar 55 values')
end
-- subtract weak-scalar case 56
do
  local a=np.array({25,1,19,17,20},np.uint32)
  local r=np.subtract(a,1)
  assert(r.dtype=='uint32','scalar 56 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 56 shape')
  assert(veq(r:tolist(),{24,0,18,16,19}),'scalar 56 values')
end
-- subtract weak-scalar case 57
do
  local a=np.array({1,-1,-23,-17,5},np.int16)
  local r=np.subtract(0.5,a)
  assert(r.dtype=='float64','scalar 57 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 57 shape')
  assert(veq(r:tolist(),{-0.5,1.5,23.5,17.5,-4.5}),'scalar 57 values')
end
-- subtract weak-scalar case 58
do
  local a=np.array({false,true,false,true,false},np.bool)
  local r=np.subtract(7.0,a)
  assert(r.dtype=='float64','scalar 58 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 58 shape')
  assert(veq(r:tolist(),{7.0,6.0,7.0,6.0,7.0}),'scalar 58 values')
end
-- subtract weak-scalar case 59
do
  local a=np.array({{23,0,2}},np.int64)
  local r=np.subtract(-7,a)
  assert(r.dtype=='int64','scalar 59 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 59 shape')
  assert(veq(r:tolist(),{{-30,-7,-9}}),'scalar 59 values')
end
-- subtract weak-scalar case 60
do
  local a=np.array({{0.25,-7.5,0.25},{-7.5,-1.5,1.25}},np.float16)
  local r=np.subtract(11,a)
  assert(r.dtype=='float16','scalar 60 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 60 shape')
  assert(veq(r:tolist(),{{10.75,18.5,10.75},{18.5,12.5,9.75}}),'scalar 60 values')
end
-- subtract weak-scalar case 61
do
  local a=np.array({0,-17,2,2,0},np.int8)
  local r=np.subtract(5,a)
  assert(r.dtype=='int8','scalar 61 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 61 shape')
  assert(veq(r:tolist(),{5,22,3,3,5}),'scalar 61 values')
end
-- subtract weak-scalar case 62
do
  local a=np.array({{2,23,5},{11,-7,-3}},np.int32)
  local r=np.subtract(a,5)
  assert(r.dtype=='int32','scalar 62 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 62 shape')
  assert(veq(r:tolist(),{{-3,18,0},{6,-12,-8}}),'scalar 62 values')
end
-- subtract weak-scalar case 63
do
  local a=np.array({{-3.25,-3.25,-1.5}},np.float16)
  local r=np.subtract(-2,a)
  assert(r.dtype=='float16','scalar 63 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 63 shape')
  assert(veq(r:tolist(),{{1.25,1.25,-0.5}}),'scalar 63 values')
end
-- subtract weak-scalar case 64
do
  local a=np.array({{-3.25,-0.5,-1.5},{7.75,-3.25,2.5}},np.float16)
  local r=np.subtract(a,-2.0)
  assert(r.dtype=='float16','scalar 64 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 64 shape')
  assert(veq(r:tolist(),{{-1.25,1.5,0.5},{9.75,-1.25,4.5}}),'scalar 64 values')
end
-- subtract weak-scalar case 65
do
  local a=np.array({{false},{true}},np.bool)
  local r=np.subtract(-7,a)
  assert(r.dtype=='int64','scalar 65 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 65 shape')
  assert(veq(r:tolist(),{{-7},{-8}}),'scalar 65 values')
end
-- subtract weak-scalar case 66
do
  local a=np.array({{25,15,9},{18,0,14}},np.uint8)
  local r=np.subtract(-2.0,a)
  assert(r.dtype=='float64','scalar 66 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 66 shape')
  assert(veq(r:tolist(),{{-27.0,-17.0,-11.0},{-20.0,-2.0,-16.0}}),'scalar 66 values')
end
-- subtract weak-scalar case 67
do
  local a=np.array({{-23,-17,-1},{1,-3,2}},np.int64)
  local r=np.subtract(a,1)
  assert(r.dtype=='int64','scalar 67 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 67 shape')
  assert(veq(r:tolist(),{{-24,-18,-2},{0,-4,1}}),'scalar 67 values')
end
-- subtract weak-scalar case 68
do
  local a=np.array({{2,1,8},{8,13,6}},np.uint64)
  local r=np.subtract(a,-5.5)
  assert(r.dtype=='float64','scalar 68 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 68 shape')
  assert(veq(r:tolist(),{{7.5,6.5,13.5},{13.5,18.5,11.5}}),'scalar 68 values')
end
-- subtract weak-scalar case 69
do
  local a=np.array({{-0.5,0.25,2.5},{-3.25,-7.5,2.5}},np.float32)
  local r=np.subtract(a,7.0)
  assert(r.dtype=='float32','scalar 69 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 69 shape')
  assert(veq(r:tolist(),{{-7.5,-6.75,-4.5},{-10.25,-14.5,-4.5}}),'scalar 69 values')
end
-- subtract weak-scalar case 70
do
  local a=np.array({{12},{4}},np.uint32)
  local r=np.subtract(0.5,a)
  assert(r.dtype=='float64','scalar 70 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 70 shape')
  assert(veq(r:tolist(),{{-11.5},{-3.5}}),'scalar 70 values')
end
-- subtract weak-scalar case 71
do
  local a=np.array({{-3.25},{7.75}},np.float16)
  local r=np.subtract(a,-1)
  assert(r.dtype=='float16','scalar 71 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 71 shape')
  assert(veq(r:tolist(),{{-2.25},{8.75}}),'scalar 71 values')
end
-- subtract weak-scalar case 72
do
  local a=np.array({{-1,23,-3}},np.int64)
  local r=np.subtract(a,2.5)
  assert(r.dtype=='float64','scalar 72 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 72 shape')
  assert(veq(r:tolist(),{{-3.5,20.5,-5.5}}),'scalar 72 values')
end
-- true_divide weak-scalar case 73
do
  local a=np.array({{-1,-3,2},{-7,11,11}},np.int64)
  local r=np.true_divide(a,-2)
  assert(r.dtype=='float64','scalar 73 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 73 shape')
  assert(veq(r:tolist(),{{0.5,1.5,-1.0},{3.5,-5.5,-5.5}}),'scalar 73 values')
end
-- true_divide weak-scalar case 74
do
  local a=np.array({{-1.5,2.5,2.5}},np.float64)
  local r=np.true_divide(0.5,a)
  assert(r.dtype=='float64','scalar 74 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 74 shape')
  assert(veq(r:tolist(),{{-0.3333333333333333,0.2,0.2}}),'scalar 74 values')
end
-- true_divide weak-scalar case 75
do
  local a=np.array({{2.5,-0.5,-3.25}},np.float32)
  local r=np.true_divide(a,2.5)
  assert(r.dtype=='float32','scalar 75 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 75 shape')
  assert(veq(r:tolist(),{{1.0,-0.20000000298023224,-1.2999999523162842}}),'scalar 75 values')
end
-- true_divide weak-scalar case 76
do
  local a=np.array({{-7.5},{0.25}},np.float16)
  local r=np.true_divide(a,5)
  assert(r.dtype=='float16','scalar 76 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 76 shape')
  assert(veq(r:tolist(),{{-1.5},{0.04998779296875}}),'scalar 76 values')
end
-- true_divide weak-scalar case 77
do
  local a=np.array({{18},{18}},np.uint32)
  local r=np.true_divide(a,2)
  assert(r.dtype=='float64','scalar 77 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 77 shape')
  assert(veq(r:tolist(),{{9.0},{9.0}}),'scalar 77 values')
end
-- true_divide weak-scalar case 78
do
  local a=np.array({{-1.5,2.5,0.25}},np.float64)
  local r=np.true_divide(a,-1)
  assert(r.dtype=='float64','scalar 78 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 78 shape')
  assert(veq(r:tolist(),{{1.5,-2.5,-0.25}}),'scalar 78 values')
end
-- true_divide weak-scalar case 79
do
  local a=np.array({{19},{15}},np.uint64)
  local r=np.true_divide(a,2.5)
  assert(r.dtype=='float64','scalar 79 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 79 shape')
  assert(veq(r:tolist(),{{7.6},{6.0}}),'scalar 79 values')
end
-- true_divide weak-scalar case 80
do
  local a=np.array({{false,true,false}},np.bool)
  local r=np.true_divide(a,-2.0)
  assert(r.dtype=='float64','scalar 80 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 80 shape')
  assert(veq(r:tolist(),{{-0.0,-0.5,-0.0}}),'scalar 80 values')
end
-- true_divide weak-scalar case 81
do
  local a=np.array({{22},{12}},np.uint64)
  local r=np.true_divide(1,a)
  assert(r.dtype=='float64','scalar 81 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 81 shape')
  assert(veq(r:tolist(),{{0.045454545454545456},{0.08333333333333333}}),'scalar 81 values')
end
-- true_divide weak-scalar case 82
do
  local a=np.array({{1.25,-3.25,2.5},{-0.5,-1.5,7.75}},np.float64)
  local r=np.true_divide(a,-7)
  assert(r.dtype=='float64','scalar 82 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 82 shape')
  assert(veq(r:tolist(),{{-0.17857142857142858,0.4642857142857143,-0.35714285714285715},{0.07142857142857142,0.21428571428571427,-1.1071428571428572}}),'scalar 82 values')
end
-- true_divide weak-scalar case 83
do
  local a=np.array({11,5,23,-3,-7},np.int16)
  local r=np.true_divide(a,-5.5)
  assert(r.dtype=='float64','scalar 83 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 83 shape')
  assert(veq(r:tolist(),{-2.0,-0.9090909090909091,-4.181818181818182,0.5454545454545454,1.2727272727272727}),'scalar 83 values')
end
-- true_divide weak-scalar case 84
do
  local a=np.array({18,25,5,16,13},np.uint8)
  local r=np.true_divide(a,5)
  assert(r.dtype=='float64','scalar 84 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 84 shape')
  assert(veq(r:tolist(),{3.6,5.0,1.0,3.2,2.6}),'scalar 84 values')
end
-- true_divide weak-scalar case 85
do
  local a=np.array({-0.5,-7.5,-3.25,2.5,-1.5},np.float16)
  local r=np.true_divide(1,a)
  assert(r.dtype=='float16','scalar 85 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 85 shape')
  assert(veq(r:tolist(),{-2.0,-0.13330078125,-0.3076171875,0.39990234375,-0.66650390625}),'scalar 85 values')
end
-- true_divide weak-scalar case 86
do
  local a=np.array({{1,-3,-7},{-17,-3,-7}},np.int64)
  local r=np.true_divide(2,a)
  assert(r.dtype=='float64','scalar 86 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 86 shape')
  assert(veq(r:tolist(),{{2.0,-0.6666666666666666,-0.2857142857142857},{-0.11764705882352941,-0.6666666666666666,-0.2857142857142857}}),'scalar 86 values')
end
-- true_divide weak-scalar case 87
do
  local a=np.array({7,12,20,4,25},np.uint64)
  local r=np.true_divide(a,-5.5)
  assert(r.dtype=='float64','scalar 87 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 87 shape')
  assert(veq(r:tolist(),{-1.2727272727272727,-2.1818181818181817,-3.6363636363636362,-0.7272727272727273,-4.545454545454546}),'scalar 87 values')
end
-- true_divide weak-scalar case 88
do
  local a=np.array({{-17,-17,11},{-1,5,-1}},np.int64)
  local r=np.true_divide(7.0,a)
  assert(r.dtype=='float64','scalar 88 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 88 shape')
  assert(veq(r:tolist(),{{-0.4117647058823529,-0.4117647058823529,0.6363636363636364},{-7.0,1.4,-7.0}}),'scalar 88 values')
end
-- true_divide weak-scalar case 89
do
  local a=np.array({{true,true,true}},np.bool)
  local r=np.true_divide(0.5,a)
  assert(r.dtype=='float64','scalar 89 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 89 shape')
  assert(veq(r:tolist(),{{0.5,0.5,0.5}}),'scalar 89 values')
end
-- true_divide weak-scalar case 90
do
  local a=np.array({{10,5,5}},np.uint32)
  local r=np.true_divide(a,7.0)
  assert(r.dtype=='float64','scalar 90 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 90 shape')
  assert(veq(r:tolist(),{{1.4285714285714286,0.7142857142857143,0.7142857142857143}}),'scalar 90 values')
end
-- true_divide weak-scalar case 91
do
  local a=np.array({{5},{11}},np.int32)
  local r=np.true_divide(a,5)
  assert(r.dtype=='float64','scalar 91 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 91 shape')
  assert(veq(r:tolist(),{{1.0},{2.2}}),'scalar 91 values')
end
-- true_divide weak-scalar case 92
do
  local a=np.array({{0.25,-7.5,-1.5},{2.5,0.25,2.5}},np.float32)
  local r=np.true_divide(-7,a)
  assert(r.dtype=='float32','scalar 92 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 92 shape')
  assert(veq(r:tolist(),{{-28.0,0.9333333373069763,4.666666507720947},{-2.799999952316284,-28.0,-2.799999952316284}}),'scalar 92 values')
end
-- true_divide weak-scalar case 93
do
  local a=np.array({{15,21,17},{16,5,6}},np.uint8)
  local r=np.true_divide(a,-7)
  assert(r.dtype=='float64','scalar 93 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 93 shape')
  assert(veq(r:tolist(),{{-2.142857142857143,-3.0,-2.4285714285714284},{-2.2857142857142856,-0.7142857142857143,-0.8571428571428571}}),'scalar 93 values')
end
-- true_divide weak-scalar case 94
do
  local a=np.array({{2},{-1}},np.int64)
  local r=np.true_divide(11,a)
  assert(r.dtype=='float64','scalar 94 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 94 shape')
  assert(veq(r:tolist(),{{5.5},{-11.0}}),'scalar 94 values')
end
-- true_divide weak-scalar case 95
do
  local a=np.array({{23,-17,23}},np.int8)
  local r=np.true_divide(11,a)
  assert(r.dtype=='float64','scalar 95 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 95 shape')
  assert(veq(r:tolist(),{{0.4782608695652174,-0.6470588235294118,0.4782608695652174}}),'scalar 95 values')
end
-- true_divide weak-scalar case 96
do
  local a=np.array({2,5,11,-1,-23},np.int64)
  local r=np.true_divide(a,-7)
  assert(r.dtype=='float64','scalar 96 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 96 shape')
  assert(veq(r:tolist(),{-0.2857142857142857,-0.7142857142857143,-1.5714285714285714,0.14285714285714285,3.2857142857142856}),'scalar 96 values')
end
-- true_divide weak-scalar case 97
do
  local a=np.array({{-17},{2}},np.int64)
  local r=np.true_divide(a,-7)
  assert(r.dtype=='float64','scalar 97 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 97 shape')
  assert(veq(r:tolist(),{{2.4285714285714284},{-0.2857142857142857}}),'scalar 97 values')
end
-- true_divide weak-scalar case 98
do
  local a=np.array({5,-1,5,1,-1},np.int16)
  local r=np.true_divide(a,2)
  assert(r.dtype=='float64','scalar 98 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 98 shape')
  assert(veq(r:tolist(),{2.5,-0.5,2.5,0.5,-0.5}),'scalar 98 values')
end
-- true_divide weak-scalar case 99
do
  local a=np.array({{-3.25,-3.25,-3.25},{-3.25,-0.5,-7.5}},np.float32)
  local r=np.true_divide(a,-2)
  assert(r.dtype=='float32','scalar 99 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 99 shape')
  assert(veq(r:tolist(),{{1.625,1.625,1.625},{1.625,0.25,3.75}}),'scalar 99 values')
end
-- true_divide weak-scalar case 100
do
  local a=np.array({{1.25,7.75,-7.5},{-3.25,1.25,-0.5}},np.float64)
  local r=np.true_divide(-2.0,a)
  assert(r.dtype=='float64','scalar 100 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 100 shape')
  assert(veq(r:tolist(),{{-1.6,-0.25806451612903225,0.26666666666666666},{0.6153846153846154,-1.6,4.0}}),'scalar 100 values')
end
-- true_divide weak-scalar case 101
do
  local a=np.array({{11},{25}},np.uint8)
  local r=np.true_divide(a,-7)
  assert(r.dtype=='float64','scalar 101 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 101 shape')
  assert(veq(r:tolist(),{{-1.5714285714285714},{-3.5714285714285716}}),'scalar 101 values')
end
-- true_divide weak-scalar case 102
do
  local a=np.array({{3},{3}},np.uint64)
  local r=np.true_divide(2.5,a)
  assert(r.dtype=='float64','scalar 102 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 102 shape')
  assert(veq(r:tolist(),{{0.8333333333333334},{0.8333333333333334}}),'scalar 102 values')
end
-- true_divide weak-scalar case 103
do
  local a=np.array({11,2,15,3,20},np.uint32)
  local r=np.true_divide(a,1)
  assert(r.dtype=='float64','scalar 103 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 103 shape')
  assert(veq(r:tolist(),{11.0,2.0,15.0,3.0,20.0}),'scalar 103 values')
end
-- true_divide weak-scalar case 104
do
  local a=np.array({{3},{15}},np.uint8)
  local r=np.true_divide(a,-1)
  assert(r.dtype=='float64','scalar 104 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 104 shape')
  assert(veq(r:tolist(),{{-3.0},{-15.0}}),'scalar 104 values')
end
-- true_divide weak-scalar case 105
do
  local a=np.array({11,18,20,23,7},np.uint16)
  local r=np.true_divide(a,1)
  assert(r.dtype=='float64','scalar 105 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 105 shape')
  assert(veq(r:tolist(),{11.0,18.0,20.0,23.0,7.0}),'scalar 105 values')
end
-- true_divide weak-scalar case 106
do
  local a=np.array({{-0.5,-1.5,0.25}},np.float16)
  local r=np.true_divide(a,-7)
  assert(r.dtype=='float16','scalar 106 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 106 shape')
  assert(veq(r:tolist(),{{0.0714111328125,0.2142333984375,-0.03570556640625}}),'scalar 106 values')
end
-- true_divide weak-scalar case 107
do
  local a=np.array({{-7.5,7.75,-0.5},{1.25,7.75,7.75}},np.float64)
  local r=np.true_divide(a,2.5)
  assert(r.dtype=='float64','scalar 107 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 107 shape')
  assert(veq(r:tolist(),{{-3.0,3.1,-0.2},{0.5,3.1,3.1}}),'scalar 107 values')
end
-- true_divide weak-scalar case 108
do
  local a=np.array({{7.75,-3.25,0.25},{2.5,-0.5,0.25}},np.float32)
  local r=np.true_divide(7.0,a)
  assert(r.dtype=='float32','scalar 108 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 108 shape')
  assert(veq(r:tolist(),{{0.9032257795333862,-2.153846263885498,28.0},{2.799999952316284,-14.0,28.0}}),'scalar 108 values')
end
-- true_divide weak-scalar case 109
do
  local a=np.array({{-3.25},{2.5}},np.float32)
  local r=np.true_divide(-7,a)
  assert(r.dtype=='float32','scalar 109 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 109 shape')
  assert(veq(r:tolist(),{{2.153846263885498},{-2.799999952316284}}),'scalar 109 values')
end
-- true_divide weak-scalar case 110
do
  local a=np.array({{11,1,-1}},np.int8)
  local r=np.true_divide(a,5)
  assert(r.dtype=='float64','scalar 110 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 110 shape')
  assert(veq(r:tolist(),{{2.2,0.2,-0.2}}),'scalar 110 values')
end
-- true_divide weak-scalar case 111
do
  local a=np.array({{8,9,8},{4,24,10}},np.uint8)
  local r=np.true_divide(7.0,a)
  assert(r.dtype=='float64','scalar 111 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 111 shape')
  assert(veq(r:tolist(),{{0.875,0.7777777777777778,0.875},{1.75,0.2916666666666667,0.7}}),'scalar 111 values')
end
-- true_divide weak-scalar case 112
do
  local a=np.array({{4},{13}},np.uint32)
  local r=np.true_divide(-2,a)
  assert(r.dtype=='float64','scalar 112 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 112 shape')
  assert(veq(r:tolist(),{{-0.5},{-0.15384615384615385}}),'scalar 112 values')
end
-- true_divide weak-scalar case 113
do
  local a=np.array({{2,-17,5},{-3,11,2}},np.int32)
  local r=np.true_divide(11,a)
  assert(r.dtype=='float64','scalar 113 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 113 shape')
  assert(veq(r:tolist(),{{5.5,-0.6470588235294118,2.2},{-3.6666666666666665,1.0,5.5}}),'scalar 113 values')
end
-- true_divide weak-scalar case 114
do
  local a=np.array({{2.5},{-0.5}},np.float64)
  local r=np.true_divide(1,a)
  assert(r.dtype=='float64','scalar 114 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 114 shape')
  assert(veq(r:tolist(),{{0.4},{-2.0}}),'scalar 114 values')
end
-- true_divide weak-scalar case 115
do
  local a=np.array({1.25,2.5,-0.5,7.75,7.75},np.float32)
  local r=np.true_divide(-2.0,a)
  assert(r.dtype=='float32','scalar 115 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 115 shape')
  assert(veq(r:tolist(),{-1.600000023841858,-0.800000011920929,4.0,-0.25806450843811035,-0.25806450843811035}),'scalar 115 values')
end
-- true_divide weak-scalar case 116
do
  local a=np.array({5,5,-7,-17,23},np.int64)
  local r=np.true_divide(a,5)
  assert(r.dtype=='float64','scalar 116 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 116 shape')
  assert(veq(r:tolist(),{1.0,1.0,-1.4,-3.4,4.6}),'scalar 116 values')
end
-- true_divide weak-scalar case 117
do
  local a=np.array({{-17},{0}},np.int64)
  local r=np.true_divide(a,-1)
  assert(r.dtype=='float64','scalar 117 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 117 shape')
  assert(veq(r:tolist(),{{17.0},{-0.0}}),'scalar 117 values')
end
-- true_divide weak-scalar case 118
do
  local a=np.array({{25,16,7}},np.uint32)
  local r=np.true_divide(a,1)
  assert(r.dtype=='float64','scalar 118 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 118 shape')
  assert(veq(r:tolist(),{{25.0,16.0,7.0}}),'scalar 118 values')
end
-- true_divide weak-scalar case 119
do
  local a=np.array({{2},{23}},np.uint8)
  local r=np.true_divide(-7,a)
  assert(r.dtype=='float64','scalar 119 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 119 shape')
  assert(veq(r:tolist(),{{-3.5},{-0.30434782608695654}}),'scalar 119 values')
end
-- true_divide weak-scalar case 120
do
  local a=np.array({{23},{-17}},np.int64)
  local r=np.true_divide(a,2)
  assert(r.dtype=='float64','scalar 120 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 120 shape')
  assert(veq(r:tolist(),{{11.5},{-8.5}}),'scalar 120 values')
end
-- true_divide weak-scalar case 121
do
  local a=np.array({{11,-17,11},{-1,23,-1}},np.int8)
  local r=np.true_divide(11,a)
  assert(r.dtype=='float64','scalar 121 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 121 shape')
  assert(veq(r:tolist(),{{1.0,-0.6470588235294118,1.0},{-11.0,0.4782608695652174,-11.0}}),'scalar 121 values')
end
-- true_divide weak-scalar case 122
do
  local a=np.array({{true,true,true},{true,true,true}},np.bool)
  local r=np.true_divide(-5.5,a)
  assert(r.dtype=='float64','scalar 122 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 122 shape')
  assert(veq(r:tolist(),{{-5.5,-5.5,-5.5},{-5.5,-5.5,-5.5}}),'scalar 122 values')
end
-- true_divide weak-scalar case 123
do
  local a=np.array({{19,12,9},{10,15,7}},np.uint32)
  local r=np.true_divide(a,-7)
  assert(r.dtype=='float64','scalar 123 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 123 shape')
  assert(veq(r:tolist(),{{-2.7142857142857144,-1.7142857142857142,-1.2857142857142858},{-1.4285714285714286,-2.142857142857143,-1.0}}),'scalar 123 values')
end
-- true_divide weak-scalar case 124
do
  local a=np.array({5,3,3,20,13},np.uint32)
  local r=np.true_divide(-7,a)
  assert(r.dtype=='float64','scalar 124 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 124 shape')
  assert(veq(r:tolist(),{-1.4,-2.3333333333333335,-2.3333333333333335,-0.35,-0.5384615384615384}),'scalar 124 values')
end
-- true_divide weak-scalar case 125
do
  local a=np.array({{9,2,24},{2,3,2}},np.uint32)
  local r=np.true_divide(-2,a)
  assert(r.dtype=='float64','scalar 125 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 125 shape')
  assert(veq(r:tolist(),{{-0.2222222222222222,-1.0,-0.08333333333333333},{-1.0,-0.6666666666666666,-1.0}}),'scalar 125 values')
end
-- true_divide weak-scalar case 126
do
  local a=np.array({{false},{false}},np.bool)
  local r=np.true_divide(a,5)
  assert(r.dtype=='float64','scalar 126 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 126 shape')
  assert(veq(r:tolist(),{{0.0},{0.0}}),'scalar 126 values')
end
-- true_divide weak-scalar case 127
do
  local a=np.array({{true},{true}},np.bool)
  local r=np.true_divide(a,1)
  assert(r.dtype=='float64','scalar 127 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 127 shape')
  assert(veq(r:tolist(),{{1.0},{1.0}}),'scalar 127 values')
end
-- true_divide weak-scalar case 128
do
  local a=np.array({{-3,23,2},{-1,-17,11}},np.int64)
  local r=np.true_divide(a,-1)
  assert(r.dtype=='float64','scalar 128 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 128 shape')
  assert(veq(r:tolist(),{{3.0,-23.0,-2.0},{1.0,17.0,-11.0}}),'scalar 128 values')
end
-- true_divide weak-scalar case 129
do
  local a=np.array({23,1,-3,11,11},np.int64)
  local r=np.true_divide(a,-1)
  assert(r.dtype=='float64','scalar 129 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 129 shape')
  assert(veq(r:tolist(),{-23.0,-1.0,3.0,-11.0,-11.0}),'scalar 129 values')
end
-- true_divide weak-scalar case 130
do
  local a=np.array({{-7,23,-1}},np.int16)
  local r=np.true_divide(a,1)
  assert(r.dtype=='float64','scalar 130 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 130 shape')
  assert(veq(r:tolist(),{{-7.0,23.0,-1.0}}),'scalar 130 values')
end
-- true_divide weak-scalar case 131
do
  local a=np.array({{2.5},{-0.5}},np.float64)
  local r=np.true_divide(1,a)
  assert(r.dtype=='float64','scalar 131 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 131 shape')
  assert(veq(r:tolist(),{{0.4},{-2.0}}),'scalar 131 values')
end
-- true_divide weak-scalar case 132
do
  local a=np.array({-3,-1,23,23,-17},np.int32)
  local r=np.true_divide(a,-7)
  assert(r.dtype=='float64','scalar 132 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 132 shape')
  assert(veq(r:tolist(),{0.42857142857142855,0.14285714285714285,-3.2857142857142856,-3.2857142857142856,2.4285714285714284}),'scalar 132 values')
end
-- true_divide weak-scalar case 133
do
  local a=np.array({true,true,true,true,true},np.bool)
  local r=np.true_divide(1,a)
  assert(r.dtype=='float64','scalar 133 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 133 shape')
  assert(veq(r:tolist(),{1.0,1.0,1.0,1.0,1.0}),'scalar 133 values')
end
-- true_divide weak-scalar case 134
do
  local a=np.array({23,-17,-1,1,1},np.int64)
  local r=np.true_divide(-2,a)
  assert(r.dtype=='float64','scalar 134 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 134 shape')
  assert(veq(r:tolist(),{-0.08695652173913043,0.11764705882352941,2.0,-2.0,-2.0}),'scalar 134 values')
end
-- true_divide weak-scalar case 135
do
  local a=np.array({{1.25},{-0.5}},np.float16)
  local r=np.true_divide(11,a)
  assert(r.dtype=='float16','scalar 135 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 135 shape')
  assert(veq(r:tolist(),{{8.796875},{-22.0}}),'scalar 135 values')
end
-- true_divide weak-scalar case 136
do
  local a=np.array({{2.5,-1.5,1.25}},np.float16)
  local r=np.true_divide(-5.5,a)
  assert(r.dtype=='float16','scalar 136 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 136 shape')
  assert(veq(r:tolist(),{{-2.19921875,3.666015625,-4.3984375}}),'scalar 136 values')
end
-- true_divide weak-scalar case 137
do
  local a=np.array({{7.75,-1.5,-0.5},{-7.5,-0.5,7.75}},np.float32)
  local r=np.true_divide(2.5,a)
  assert(r.dtype=='float32','scalar 137 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 137 shape')
  assert(veq(r:tolist(),{{0.32258063554763794,-1.6666666269302368,-5.0},{-0.3333333432674408,-5.0,0.32258063554763794}}),'scalar 137 values')
end
-- true_divide weak-scalar case 138
do
  local a=np.array({{11,-3,1},{-17,-17,-1}},np.int32)
  local r=np.true_divide(a,-1)
  assert(r.dtype=='float64','scalar 138 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 138 shape')
  assert(veq(r:tolist(),{{-11.0,3.0,-1.0},{17.0,17.0,1.0}}),'scalar 138 values')
end
-- true_divide weak-scalar case 139
do
  local a=np.array({{21,14,12},{25,13,24}},np.uint64)
  local r=np.true_divide(-7,a)
  assert(r.dtype=='float64','scalar 139 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 139 shape')
  assert(veq(r:tolist(),{{-0.3333333333333333,-0.5,-0.5833333333333334},{-0.28,-0.5384615384615384,-0.2916666666666667}}),'scalar 139 values')
end
-- true_divide weak-scalar case 140
do
  local a=np.array({{-3.25},{-0.5}},np.float64)
  local r=np.true_divide(-1,a)
  assert(r.dtype=='float64','scalar 140 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 140 shape')
  assert(veq(r:tolist(),{{0.3076923076923077},{2.0}}),'scalar 140 values')
end
-- true_divide weak-scalar case 141
do
  local a=np.array({{true,false,true}},np.bool)
  local r=np.true_divide(a,-7)
  assert(r.dtype=='float64','scalar 141 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 141 shape')
  assert(veq(r:tolist(),{{-0.14285714285714285,-0.0,-0.14285714285714285}}),'scalar 141 values')
end
-- true_divide weak-scalar case 142
do
  local a=np.array({{-1,-3,11},{2,5,1}},np.int64)
  local r=np.true_divide(-7,a)
  assert(r.dtype=='float64','scalar 142 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 142 shape')
  assert(veq(r:tolist(),{{7.0,2.3333333333333335,-0.6363636363636364},{-3.5,-1.4,-7.0}}),'scalar 142 values')
end
-- true_divide weak-scalar case 143
do
  local a=np.array({{-7.5,7.75,0.25},{2.5,2.5,-7.5}},np.float32)
  local r=np.true_divide(-2.0,a)
  assert(r.dtype=='float32','scalar 143 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 143 shape')
  assert(veq(r:tolist(),{{0.2666666805744171,-0.25806450843811035,-8.0},{-0.800000011920929,-0.800000011920929,0.2666666805744171}}),'scalar 143 values')
end
-- true_divide weak-scalar case 144
do
  local a=np.array({{5,17,2},{22,14,11}},np.uint64)
  local r=np.true_divide(a,11)
  assert(r.dtype=='float64','scalar 144 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 144 shape')
  assert(veq(r:tolist(),{{0.45454545454545453,1.5454545454545454,0.18181818181818182},{2.0,1.2727272727272727,1.0}}),'scalar 144 values')
end
-- true_divide weak-scalar case 145
do
  local a=np.array({{-3,1,-1}},np.int8)
  local r=np.true_divide(a,11)
  assert(r.dtype=='float64','scalar 145 dtype '..r.dtype)
  assert(seqeq(r.shape,{1,3}),'scalar 145 shape')
  assert(veq(r:tolist(),{{-0.2727272727272727,0.09090909090909091,-0.09090909090909091}}),'scalar 145 values')
end
-- true_divide weak-scalar case 146
do
  local a=np.array({2.5,-1.5,-0.5,7.75,-1.5},np.float64)
  local r=np.true_divide(a,1)
  assert(r.dtype=='float64','scalar 146 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 146 shape')
  assert(veq(r:tolist(),{2.5,-1.5,-0.5,7.75,-1.5}),'scalar 146 values')
end
-- true_divide weak-scalar case 147
do
  local a=np.array({1.25,-7.5,1.25,-0.5,-3.25},np.float16)
  local r=np.true_divide(-2.0,a)
  assert(r.dtype=='float16','scalar 147 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 147 shape')
  assert(veq(r:tolist(),{-1.599609375,0.2666015625,-1.599609375,4.0,0.615234375}),'scalar 147 values')
end
-- true_divide weak-scalar case 148
do
  local a=np.array({{7.75,-0.5,-3.25},{-3.25,-3.25,2.5}},np.float16)
  local r=np.true_divide(a,-2)
  assert(r.dtype=='float16','scalar 148 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 148 shape')
  assert(veq(r:tolist(),{{-3.875,0.25,1.625},{1.625,1.625,-1.25}}),'scalar 148 values')
end
-- true_divide weak-scalar case 149
do
  local a=np.array({{2.5},{-0.5}},np.float32)
  local r=np.true_divide(-2.0,a)
  assert(r.dtype=='float32','scalar 149 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,1}),'scalar 149 shape')
  assert(veq(r:tolist(),{{-0.800000011920929},{4.0}}),'scalar 149 values')
end
-- true_divide weak-scalar case 150
do
  local a=np.array({false,true,true,true,false},np.bool)
  local r=np.true_divide(a,-5.5)
  assert(r.dtype=='float64','scalar 150 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 150 shape')
  assert(veq(r:tolist(),{-0.0,-0.18181818181818182,-0.18181818181818182,-0.18181818181818182,-0.0}),'scalar 150 values')
end
-- true_divide weak-scalar case 151
do
  local a=np.array({-3.25,-3.25,7.75,2.5,-0.5},np.float64)
  local r=np.true_divide(a,-2.0)
  assert(r.dtype=='float64','scalar 151 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'scalar 151 shape')
  assert(veq(r:tolist(),{1.625,1.625,-3.875,-1.25,0.25}),'scalar 151 values')
end
-- true_divide weak-scalar case 152
do
  local a=np.array({{7.75,-3.25,-0.5},{-3.25,-1.5,-3.25}},np.float32)
  local r=np.true_divide(-2.0,a)
  assert(r.dtype=='float32','scalar 152 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'scalar 152 shape')
  assert(veq(r:tolist(),{{-0.25806450843811035,0.6153846383094788,4.0},{0.6153846383094788,1.3333333730697632,0.6153846383094788}}),'scalar 152 values')
end

do
  local a=np.array({true,false},np.bool)
  local b=np.array({true,true},np.bool)
  local ok,err=pcall(function() return np.subtract(a,b) end)
  assert(not ok and tostring(err):find('boolean subtract',1,true),'bool subtract error')
end

do
  local a=np.array({1.0,0.0},np.float64)
  local b=np.array({0.0,0.0},np.float64)
  local r=np.true_divide(a,b)
  assert(r[1]==math.huge,'divide by zero -> inf')
  assert(r[2]~=r[2],'zero by zero -> nan')
end

do
  local b=np.array({true,false},np.bool)
  local bor=b+true
  assert(bor.dtype=='bool' and bor[1] and bor[2],'weak bool add')
  local band=true*b
  assert(band.dtype=='bool' and band[1] and not band[2],'weak bool multiply')
  local bd=b/true
  assert(bd.dtype=='float64' and bd[1]==1 and bd[2]==0,'weak bool true_divide')
  local i=np.array({1,2},np.int8)
  assert((i+true).dtype=='int8' and (true-i)[2]==-1,'weak bool with int8')
  local f=np.array({1.0,2.0},np.float32)
  assert((true/f).dtype=='float32','weak bool with float32')
end

print('subtract/true_divide differential: 240 array cases + 153 scalar cases ok')
