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
  if type(a)=='boolean' or type(b)=='boolean' then return a==b end
  if type(a)~='number' or type(b)~='number' then return a==b end
  if a~=a and b~=b then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return a==b end
  if a==b then return true end
  local scale=math.max(1,math.abs(a),math.abs(b))
  return math.abs(a-b)<=4e-6*scale
end

do -- floor_divide 0
 local a=np.array({{false,true,true},{false,false,false}},np.bool)
 local b=np.array({-1.5,-9.5,-0.0},np.float16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float16','floor_divide dtype 0 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 0')
 assert(veq(r:tolist(),{{-0.0,-1.0,-math.huge},{-0.0,-0.0,(0/0)}}),'floor_divide values 0')
end
do -- floor_divide 1
 local a=np.array({{-9.5},{-0.0}},np.float32)
 local b=np.array({{0,3,-9}},np.int8)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','floor_divide dtype 1 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 1')
 assert(veq(r:tolist(),{{-math.huge,-4.0,1.0},{(0/0),-0.0,0.0}}),'floor_divide values 1')
end
do -- floor_divide 2
 local a=np.array({{1.0},{2.0}},np.float16)
 local b=np.array({{false,true,false}},np.bool)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float16','floor_divide dtype 2 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 2')
 assert(veq(r:tolist(),{{math.huge,1.0,math.huge},{math.huge,2.0,math.huge}}),'floor_divide values 2')
end
do -- floor_divide 3
 local a=np.array({{false},{true}},np.bool)
 local b=np.array({{31,127,127}},np.uint16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='uint16','floor_divide dtype 3 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 3')
 assert(veq(r:tolist(),{{0,0,0},{0,0,0}}),'floor_divide values 3')
end
do -- floor_divide 4
 local a=np.array({{0,7,31},{63,127,3}},np.uint32)
 local b=np.array({15,1,0},np.int64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int64','floor_divide dtype 4 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 4')
 assert(veq(r:tolist(),{{0,7,0},{4,127,0}}),'floor_divide values 4')
end
do -- floor_divide 5
 local a=np.array({{-31,15,1},{2,2,7}},np.int32)
 local b=np.array({{true,true,true}},np.bool)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int32','floor_divide dtype 5 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 5')
 assert(veq(r:tolist(),{{-31,15,1},{2,2,7}}),'floor_divide values 5')
end
do -- floor_divide 6
 local a=np.array({-1,-3,-9,0,-31},np.int8)
 local b=np.array({127,31,31,2,5},np.uint16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int32','floor_divide dtype 6 '..r.dtype)
 assert(seqeq(r.shape,{5}),'floor_divide shape 6')
 assert(veq(r:tolist(),{-1,-1,-1,0,-7}),'floor_divide values 6')
end
do -- floor_divide 7
 local a=np.array({{5},{7}},np.uint16)
 local b=np.array({{1,3,1}},np.uint16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='uint16','floor_divide dtype 7 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 7')
 assert(veq(r:tolist(),{{5,1,5},{7,2,7}}),'floor_divide values 7')
end
do -- floor_divide 8
 local a=np.array({{-31,-1,30},{0,-3,3}},np.int8)
 local b=np.array({{7,2,7}},np.int64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int64','floor_divide dtype 8 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 8')
 assert(veq(r:tolist(),{{-5,-1,4},{0,-2,0}}),'floor_divide values 8')
end
do -- floor_divide 9
 local a=np.array({{0},{0}},np.int64)
 local b=np.array({{63,31,3}},np.uint8)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int64','floor_divide dtype 9 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 9')
 assert(veq(r:tolist(),{{0,0,0},{0,0,0}}),'floor_divide values 9')
end
do -- floor_divide 10
 local a=np.array({{9.0,-1.0,0.5},{-1.5,1.0,3.5}},np.float32)
 local b=np.array({31,3,7},np.uint16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','floor_divide dtype 10 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 10')
 assert(veq(r:tolist(),{{0.0,-1.0,0.0},{-1.0,0.0,0.0}}),'floor_divide values 10')
end
do -- floor_divide 11
 local a=np.array({{true,true,true},{true,false,true}},np.bool)
 local b=np.array({-9.5,1.0,-3.0},np.float32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','floor_divide dtype 11 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 11')
 assert(veq(r:tolist(),{{-1.0,1.0,-1.0},{-1.0,0.0,-1.0}}),'floor_divide values 11')
end
do -- floor_divide 12
 local a=np.array({{-9,30,3},{15,2,-3}},np.int16)
 local b=np.array({0,3,1},np.int16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int16','floor_divide dtype 12 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 12')
 assert(veq(r:tolist(),{{0,10,3},{0,0,-3}}),'floor_divide values 12')
end
do -- floor_divide 13
 local a=np.array({127,0,0,7,5},np.uint16)
 local b=np.array({15,2,3,7,-31},np.int64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int64','floor_divide dtype 13 '..r.dtype)
 assert(seqeq(r.shape,{5}),'floor_divide shape 13')
 assert(veq(r:tolist(),{8,0,0,1,-1}),'floor_divide values 13')
end
do -- floor_divide 14
 local a=np.array({{1.0,-9.5,1.0},{-9.5,0.5,3.5}},np.float32)
 local b=np.array({false,true,true},np.bool)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','floor_divide dtype 14 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 14')
 assert(veq(r:tolist(),{{math.huge,-10.0,1.0},{-math.huge,0.0,3.0}}),'floor_divide values 14')
end
do -- floor_divide 15
 local a=np.array({{2.0},{-3.0}},np.float32)
 local b=np.array({{30,15,3}},np.int64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 15 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 15')
 assert(veq(r:tolist(),{{0.0,0.0,0.0},{-1.0,-1.0,-1.0}}),'floor_divide values 15')
end
do -- floor_divide 16
 local a=np.array({{15},{15}},np.uint16)
 local b=np.array({{9.0,1.0,9.0}},np.float64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 16 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 16')
 assert(veq(r:tolist(),{{1.0,15.0,1.0},{1.0,15.0,1.0}}),'floor_divide values 16')
end
do -- floor_divide 17
 local a=np.array({-9.5,0.5,-3.0,-3.0,-9.5},np.float64)
 local b=np.array({-1.5,2.0,-9.5,0.0,2.0},np.float16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 17 '..r.dtype)
 assert(seqeq(r.shape,{5}),'floor_divide shape 17')
 assert(veq(r:tolist(),{6.0,0.0,0.0,-math.huge,-5.0}),'floor_divide values 17')
end
do -- floor_divide 18
 local a=np.array({9.0,-0.0,9.0,-0.0,-1.5},np.float32)
 local b=np.array({1.0,1.0,-9.5,9.0,3.5},np.float32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','floor_divide dtype 18 '..r.dtype)
 assert(seqeq(r.shape,{5}),'floor_divide shape 18')
 assert(veq(r:tolist(),{9.0,-0.0,-1.0,-0.0,-1.0}),'floor_divide values 18')
end
do -- floor_divide 19
 local a=np.array({31,7,3,31,15},np.uint64)
 local b=np.array({-1,-1,7,30,30},np.int16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 19 '..r.dtype)
 assert(seqeq(r.shape,{5}),'floor_divide shape 19')
 assert(veq(r:tolist(),{-31.0,-7.0,0.0,1.0,0.0}),'floor_divide values 19')
end
do -- floor_divide 20
 local a=np.array({{7,2,0},{3,30,7}},np.int32)
 local b=np.array({{-9,-31,-1}},np.int64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int64','floor_divide dtype 20 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 20')
 assert(veq(r:tolist(),{{-1,-1,0},{-1,-1,-7}}),'floor_divide values 20')
end
do -- floor_divide 21
 local a=np.array({{-9.5,-9.5,2.0},{-1.5,3.5,1.0}},np.float32)
 local b=np.array({-3.0,0.5,-1.0},np.float32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','floor_divide dtype 21 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 21')
 assert(veq(r:tolist(),{{3.0,-19.0,-2.0},{0.0,7.0,-1.0}}),'floor_divide values 21')
end
do -- floor_divide 22
 local a=np.array({{0},{3}},np.int16)
 local b=np.array({{2,3,0}},np.uint32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int64','floor_divide dtype 22 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 22')
 assert(veq(r:tolist(),{{0,0,0},{1,1,0}}),'floor_divide values 22')
end
do -- floor_divide 23
 local a=np.array({{2,3,0},{2,63,3}},np.uint16)
 local b=np.array({-1.5,-3.0,-9.5},np.float16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','floor_divide dtype 23 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 23')
 assert(veq(r:tolist(),{{-2.0,-1.0,-0.0},{-2.0,-21.0,-1.0}}),'floor_divide values 23')
end
do -- floor_divide 24
 local a=np.array({{5,63,7},{5,15,15}},np.uint64)
 local b=np.array({3,15,1},np.uint8)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='uint64','floor_divide dtype 24 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 24')
 assert(veq(r:tolist(),{{1,4,7},{1,1,15}}),'floor_divide values 24')
end
do -- floor_divide 25
 local a=np.array({1,1,31,127,127},np.uint16)
 local b=np.array({1.0,0.5,9.0,0.5,-0.0},np.float32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','floor_divide dtype 25 '..r.dtype)
 assert(seqeq(r.shape,{5}),'floor_divide shape 25')
 assert(veq(r:tolist(),{1.0,2.0,3.0,254.0,-math.huge}),'floor_divide values 25')
end
do -- floor_divide 26
 local a=np.array({{127,31,5},{0,63,63}},np.uint32)
 local b=np.array({-3.0,-1.5,0.5},np.float64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 26 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 26')
 assert(veq(r:tolist(),{{-43.0,-21.0,10.0},{-0.0,-42.0,126.0}}),'floor_divide values 26')
end
do -- floor_divide 27
 local a=np.array({{15},{7}},np.uint32)
 local b=np.array({{-9,0,-9}},np.int8)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int64','floor_divide dtype 27 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 27')
 assert(veq(r:tolist(),{{-2,0,-2},{-1,0,-1}}),'floor_divide values 27')
end
do -- floor_divide 28
 local a=np.array({{15,5,3},{0,15,1}},np.uint16)
 local b=np.array({3,3,1},np.uint8)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='uint16','floor_divide dtype 28 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 28')
 assert(veq(r:tolist(),{{5,1,3},{0,5,1}}),'floor_divide values 28')
end
do -- floor_divide 29
 local a=np.array({{1.0,-1.0,3.5},{-0.0,-0.0,3.5}},np.float64)
 local b=np.array({-1.0,1.0,0.0},np.float16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 29 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 29')
 assert(veq(r:tolist(),{{-1.0,-1.0,math.huge},{0.0,-0.0,math.huge}}),'floor_divide values 29')
end
do -- floor_divide 30
 local a=np.array({{true,false,false},{false,true,true}},np.bool)
 local b=np.array({{3.5,2.0,3.5}},np.float16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float16','floor_divide dtype 30 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 30')
 assert(veq(r:tolist(),{{0.0,0.0,0.0},{0.0,0.0,0.0}}),'floor_divide values 30')
end
do -- floor_divide 31
 local a=np.array({{true,true,false},{true,true,false}},np.bool)
 local b=np.array({-3.0,-3.0,-1.5},np.float32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','floor_divide dtype 31 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 31')
 assert(veq(r:tolist(),{{-1.0,-1.0,-0.0},{-1.0,-1.0,-0.0}}),'floor_divide values 31')
end
do -- floor_divide 32
 local a=np.array({{2.0},{-1.0}},np.float32)
 local b=np.array({{0.5,3.5,2.0}},np.float32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','floor_divide dtype 32 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 32')
 assert(veq(r:tolist(),{{4.0,0.0,1.0},{-2.0,-1.0,-1.0}}),'floor_divide values 32')
end
do -- floor_divide 33
 local a=np.array({{-1,3,30},{30,0,3}},np.int32)
 local b=np.array({{-1.5,-1.5,-1.5}},np.float64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 33 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 33')
 assert(veq(r:tolist(),{{0.0,-2.0,-20.0},{-20.0,-0.0,-2.0}}),'floor_divide values 33')
end
do -- floor_divide 34
 local a=np.array({{2,3,5},{127,1,127}},np.uint32)
 local b=np.array({{9.0,3.5,-3.0}},np.float64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 34 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 34')
 assert(veq(r:tolist(),{{0.0,0.0,-2.0},{14.0,0.0,-43.0}}),'floor_divide values 34')
end
do -- floor_divide 35
 local a=np.array({true,false,false,true,true},np.bool)
 local b=np.array({3,2,30,-31,3},np.int64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int64','floor_divide dtype 35 '..r.dtype)
 assert(seqeq(r.shape,{5}),'floor_divide shape 35')
 assert(veq(r:tolist(),{0,0,0,-1,0}),'floor_divide values 35')
end
do -- floor_divide 36
 local a=np.array({{2,2,7},{-31,15,-9}},np.int64)
 local b=np.array({{3,2,63}},np.uint64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 36 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 36')
 assert(veq(r:tolist(),{{0.0,1.0,0.0},{-11.0,7.0,-1.0}}),'floor_divide values 36')
end
do -- floor_divide 37
 local a=np.array({{2,3,15},{7,2,7}},np.int32)
 local b=np.array({{30,15,3}},np.int16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int32','floor_divide dtype 37 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 37')
 assert(veq(r:tolist(),{{0,0,5},{0,0,2}}),'floor_divide values 37')
end
do -- floor_divide 38
 local a=np.array({{31},{63}},np.uint64)
 local b=np.array({{7,3,31}},np.uint16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='uint64','floor_divide dtype 38 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 38')
 assert(veq(r:tolist(),{{4,10,1},{9,21,2}}),'floor_divide values 38')
end
do -- floor_divide 39
 local a=np.array({{3,15,1},{3,0,3}},np.int8)
 local b=np.array({{5,2,31}},np.uint64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 39 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 39')
 assert(veq(r:tolist(),{{0.0,7.0,0.0},{0.0,0.0,0.0}}),'floor_divide values 39')
end
do -- floor_divide 40
 local a=np.array({{1.0},{3.5}},np.float32)
 local b=np.array({{1.0,-1.5,-1.5}},np.float64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 40 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 40')
 assert(veq(r:tolist(),{{1.0,-1.0,-1.0},{3.0,-3.0,-3.0}}),'floor_divide values 40')
end
do -- floor_divide 41
 local a=np.array({{63,31,1},{5,7,15}},np.uint8)
 local b=np.array({{15,63,63}},np.uint8)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='uint8','floor_divide dtype 41 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 41')
 assert(veq(r:tolist(),{{4,0,0},{0,0,0}}),'floor_divide values 41')
end
do -- floor_divide 42
 local a=np.array({1,-1,30,-1,7},np.int16)
 local b=np.array({127,0,5,2,63},np.uint8)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int16','floor_divide dtype 42 '..r.dtype)
 assert(seqeq(r.shape,{5}),'floor_divide shape 42')
 assert(veq(r:tolist(),{0,0,6,-1,0}),'floor_divide values 42')
end
do -- floor_divide 43
 local a=np.array({{false,true,true},{false,false,false}},np.bool)
 local b=np.array({{-0.0,0.0,-9.5}},np.float16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float16','floor_divide dtype 43 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 43')
 assert(veq(r:tolist(),{{(0/0),math.huge,-1.0},{(0/0),(0/0),-0.0}}),'floor_divide values 43')
end
do -- floor_divide 44
 local a=np.array({{-31,1,15},{1,-3,-3}},np.int16)
 local b=np.array({{2,0,-1}},np.int16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int16','floor_divide dtype 44 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 44')
 assert(veq(r:tolist(),{{-16,0,-15},{0,0,3}}),'floor_divide values 44')
end
do -- floor_divide 45
 local a=np.array({{1.0,2.0,-3.0},{-1.5,-1.0,-3.0}},np.float16)
 local b=np.array({-9,-3,3},np.int32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 45 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 45')
 assert(veq(r:tolist(),{{-1.0,-1.0,-1.0},{0.0,0.0,-1.0}}),'floor_divide values 45')
end
do -- floor_divide 46
 local a=np.array({{3.5,-1.0,3.5},{2.0,0.5,9.0}},np.float64)
 local b=np.array({{2,-31,3}},np.int8)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 46 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 46')
 assert(veq(r:tolist(),{{1.0,0.0,1.0},{1.0,-1.0,3.0}}),'floor_divide values 46')
end
do -- floor_divide 47
 local a=np.array({{5,1,15},{1,1,127}},np.uint8)
 local b=np.array({{9.0,0.0,-1.5}},np.float64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 47 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 47')
 assert(veq(r:tolist(),{{0.0,math.huge,-10.0},{0.0,math.huge,-85.0}}),'floor_divide values 47')
end
do -- floor_divide 48
 local a=np.array({{true,true,true},{false,false,true}},np.bool)
 local b=np.array({-3,-31,7},np.int64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int64','floor_divide dtype 48 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 48')
 assert(veq(r:tolist(),{{-1,-1,0},{0,0,0}}),'floor_divide values 48')
end
do -- floor_divide 49
 local a=np.array({{-3.0,-1.0,1.0},{3.5,-0.0,0.5}},np.float64)
 local b=np.array({1,30,1},np.int8)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 49 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 49')
 assert(veq(r:tolist(),{{-3.0,-1.0,1.0},{3.0,-0.0,0.0}}),'floor_divide values 49')
end
do -- floor_divide 50
 local a=np.array({{-1.5},{9.0}},np.float64)
 local b=np.array({{0.5,-9.5,2.0}},np.float32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 50 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 50')
 assert(veq(r:tolist(),{{-3.0,0.0,-1.0},{18.0,-1.0,4.0}}),'floor_divide values 50')
end
do -- floor_divide 51
 local a=np.array({{true},{false}},np.bool)
 local b=np.array({{2,7,15}},np.uint16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='uint16','floor_divide dtype 51 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 51')
 assert(veq(r:tolist(),{{0,0,0},{0,0,0}}),'floor_divide values 51')
end
do -- floor_divide 52
 local a=np.array({{0,1,5},{63,63,63}},np.uint16)
 local b=np.array({31,3,5},np.uint8)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='uint16','floor_divide dtype 52 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 52')
 assert(veq(r:tolist(),{{0,0,1},{2,21,12}}),'floor_divide values 52')
end
do -- floor_divide 53
 local a=np.array({{1},{0}},np.uint32)
 local b=np.array({{15,63,5}},np.uint8)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='uint32','floor_divide dtype 53 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 53')
 assert(veq(r:tolist(),{{0,0,0},{0,0,0}}),'floor_divide values 53')
end
do -- floor_divide 54
 local a=np.array({{63,63,0},{1,127,3}},np.uint32)
 local b=np.array({-1,30,3},np.int64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int64','floor_divide dtype 54 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 54')
 assert(veq(r:tolist(),{{-63,2,0},{-1,4,1}}),'floor_divide values 54')
end
do -- floor_divide 55
 local a=np.array({{true,false,false},{true,true,false}},np.bool)
 local b=np.array({0.5,-1.0,-1.0},np.float32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','floor_divide dtype 55 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 55')
 assert(veq(r:tolist(),{{2.0,-0.0,-0.0},{2.0,-1.0,-0.0}}),'floor_divide values 55')
end
do -- floor_divide 56
 local a=np.array({{5},{15}},np.uint64)
 local b=np.array({{127,63,15}},np.uint32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='uint64','floor_divide dtype 56 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 56')
 assert(veq(r:tolist(),{{0,0,0},{0,0,1}}),'floor_divide values 56')
end
do -- floor_divide 57
 local a=np.array({0,2,3,5,31},np.uint16)
 local b=np.array({63,15,1,0,1},np.uint32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='uint32','floor_divide dtype 57 '..r.dtype)
 assert(seqeq(r.shape,{5}),'floor_divide shape 57')
 assert(veq(r:tolist(),{0,0,3,0,31}),'floor_divide values 57')
end
do -- floor_divide 58
 local a=np.array({2,5,31,31,15},np.uint32)
 local b=np.array({15,5,15,3,15},np.uint8)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='uint32','floor_divide dtype 58 '..r.dtype)
 assert(seqeq(r.shape,{5}),'floor_divide shape 58')
 assert(veq(r:tolist(),{0,1,2,10,1}),'floor_divide values 58')
end
do -- floor_divide 59
 local a=np.array({{-1.0,3.5,-1.5},{0.5,2.0,-9.5}},np.float16)
 local b=np.array({{2,-1,-1}},np.int64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 59 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 59')
 assert(veq(r:tolist(),{{-1.0,-4.0,1.0},{0.0,-2.0,9.0}}),'floor_divide values 59')
end
do -- floor_divide 60
 local a=np.array({{5},{7}},np.uint64)
 local b=np.array({{31,3,1}},np.uint16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='uint64','floor_divide dtype 60 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 60')
 assert(veq(r:tolist(),{{0,1,5},{0,2,7}}),'floor_divide values 60')
end
do -- floor_divide 61
 local a=np.array({{31,15,0},{2,31,31}},np.uint16)
 local b=np.array({{30,-9,-31}},np.int32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int32','floor_divide dtype 61 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 61')
 assert(veq(r:tolist(),{{1,-2,0},{0,-4,-1}}),'floor_divide values 61')
end
do -- floor_divide 62
 local a=np.array({{-3.0,3.5,3.5},{-0.0,3.5,-3.0}},np.float16)
 local b=np.array({{1.0,-0.0,-0.0}},np.float16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float16','floor_divide dtype 62 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 62')
 assert(veq(r:tolist(),{{-3.0,-math.huge,-math.huge},{-0.0,-math.huge,math.huge}}),'floor_divide values 62')
end
do -- floor_divide 63
 local a=np.array({{2,31,127},{127,5,31}},np.uint64)
 local b=np.array({-1,-9,7},np.int32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 63 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 63')
 assert(veq(r:tolist(),{{-2.0,-4.0,18.0},{-127.0,-1.0,4.0}}),'floor_divide values 63')
end
do -- floor_divide 64
 local a=np.array({{30,30,1},{-1,7,-1}},np.int32)
 local b=np.array({0,5,31},np.uint32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int64','floor_divide dtype 64 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 64')
 assert(veq(r:tolist(),{{0,6,0},{0,1,-1}}),'floor_divide values 64')
end
do -- floor_divide 65
 local a=np.array({15,-9,-9,-3,-1},np.int8)
 local b=np.array({15,-1,7,-31,7},np.int32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int32','floor_divide dtype 65 '..r.dtype)
 assert(seqeq(r.shape,{5}),'floor_divide shape 65')
 assert(veq(r:tolist(),{1,9,-2,0,-1}),'floor_divide values 65')
end
do -- floor_divide 66
 local a=np.array({{9.0,3.5,1.0},{-0.0,-1.5,0.5}},np.float16)
 local b=np.array({63,0,15},np.uint16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','floor_divide dtype 66 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 66')
 assert(veq(r:tolist(),{{0.0,math.huge,0.0},{-0.0,-math.huge,0.0}}),'floor_divide values 66')
end
do -- floor_divide 67
 local a=np.array({{false,false,true},{true,true,true}},np.bool)
 local b=np.array({3,127,3},np.uint32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='uint32','floor_divide dtype 67 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 67')
 assert(veq(r:tolist(),{{0,0,0},{0,0,0}}),'floor_divide values 67')
end
do -- floor_divide 68
 local a=np.array({0.5,3.5,0.0,9.0,-3.0},np.float64)
 local b=np.array({63,5,0,127,7},np.uint16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 68 '..r.dtype)
 assert(seqeq(r.shape,{5}),'floor_divide shape 68')
 assert(veq(r:tolist(),{0.0,0.0,(0/0),0.0,-1.0}),'floor_divide values 68')
end
do -- floor_divide 69
 local a=np.array({{3.5,9.0,3.5},{-1.0,-1.5,9.0}},np.float16)
 local b=np.array({31,31,2},np.uint64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 69 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 69')
 assert(veq(r:tolist(),{{0.0,0.0,1.0},{-1.0,-1.0,4.0}}),'floor_divide values 69')
end
do -- floor_divide 70
 local a=np.array({1,2,-9,3,1},np.int8)
 local b=np.array({-3,-1,-31,-9,15},np.int64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int64','floor_divide dtype 70 '..r.dtype)
 assert(seqeq(r.shape,{5}),'floor_divide shape 70')
 assert(veq(r:tolist(),{-1,-2,0,-1,0}),'floor_divide values 70')
end
do -- floor_divide 71
 local a=np.array({{-1.5},{-0.0}},np.float16)
 local b=np.array({{3,1,5}},np.uint64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 71 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 71')
 assert(veq(r:tolist(),{{-1.0,-2.0,-1.0},{-0.0,-0.0,-0.0}}),'floor_divide values 71')
end
do -- floor_divide 72
 local a=np.array({{63,15,3},{31,7,2}},np.uint8)
 local b=np.array({63,0,63},np.uint32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='uint32','floor_divide dtype 72 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 72')
 assert(veq(r:tolist(),{{1,0,0},{0,0,0}}),'floor_divide values 72')
end
do -- floor_divide 73
 local a=np.array({{false,false,false},{false,false,true}},np.bool)
 local b=np.array({1.0,0.0,3.5},np.float32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','floor_divide dtype 73 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 73')
 assert(veq(r:tolist(),{{0.0,(0/0),0.0},{0.0,(0/0),0.0}}),'floor_divide values 73')
end
do -- floor_divide 74
 local a=np.array({{-31},{-9}},np.int64)
 local b=np.array({{-0.0,9.0,2.0}},np.float64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 74 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 74')
 assert(veq(r:tolist(),{{math.huge,-4.0,-16.0},{math.huge,-1.0,-5.0}}),'floor_divide values 74')
end
do -- floor_divide 75
 local a=np.array({{3,3,127},{1,5,31}},np.uint32)
 local b=np.array({15,127,15},np.uint8)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='uint32','floor_divide dtype 75 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 75')
 assert(veq(r:tolist(),{{0,0,8},{0,0,2}}),'floor_divide values 75')
end
do -- floor_divide 76
 local a=np.array({3.5,-1.5,-3.0,2.0,-3.0},np.float16)
 local b=np.array({-9,-9,7,15,-1},np.int32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 76 '..r.dtype)
 assert(seqeq(r.shape,{5}),'floor_divide shape 76')
 assert(veq(r:tolist(),{-1.0,0.0,-1.0,0.0,3.0}),'floor_divide values 76')
end
do -- floor_divide 77
 local a=np.array({{9.0},{2.0}},np.float32)
 local b=np.array({{0.5,1.0,-3.0}},np.float64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 77 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 77')
 assert(veq(r:tolist(),{{18.0,9.0,-3.0},{4.0,2.0,-1.0}}),'floor_divide values 77')
end
do -- floor_divide 78
 local a=np.array({{127},{7}},np.uint64)
 local b=np.array({{7,127,1}},np.uint32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='uint64','floor_divide dtype 78 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 78')
 assert(veq(r:tolist(),{{18,1,127},{1,0,7}}),'floor_divide values 78')
end
do -- floor_divide 79
 local a=np.array({{15,-3,0},{15,-31,-3}},np.int32)
 local b=np.array({63,63,1},np.uint64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 79 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 79')
 assert(veq(r:tolist(),{{0.0,-1.0,0.0},{0.0,-1.0,-3.0}}),'floor_divide values 79')
end
do -- floor_divide 80
 local a=np.array({{30,-3,-9},{-3,-3,15}},np.int64)
 local b=np.array({{63,5,2}},np.uint8)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int64','floor_divide dtype 80 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 80')
 assert(veq(r:tolist(),{{0,-1,-5},{-1,-1,7}}),'floor_divide values 80')
end
do -- floor_divide 81
 local a=np.array({{0.5,1.0,3.5},{2.0,-9.5,1.0}},np.float16)
 local b=np.array({-3,7,7},np.int16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','floor_divide dtype 81 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 81')
 assert(veq(r:tolist(),{{-1.0,0.0,0.0},{-1.0,-2.0,0.0}}),'floor_divide values 81')
end
do -- floor_divide 82
 local a=np.array({{-31,0,1},{-1,30,-1}},np.int16)
 local b=np.array({{30,7,30}},np.int8)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int16','floor_divide dtype 82 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 82')
 assert(veq(r:tolist(),{{-2,0,0},{-1,4,-1}}),'floor_divide values 82')
end
do -- floor_divide 83
 local a=np.array({{true,true,false},{false,true,false}},np.bool)
 local b=np.array({0,7,-31},np.int8)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int8','floor_divide dtype 83 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 83')
 assert(veq(r:tolist(),{{0,0,0},{0,0,0}}),'floor_divide values 83')
end
do -- floor_divide 84
 local a=np.array({{true,true,false},{true,true,false}},np.bool)
 local b=np.array({true,true,false},np.bool)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int8','floor_divide dtype 84 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 84')
 assert(veq(r:tolist(),{{1,1,0},{1,1,0}}),'floor_divide values 84')
end
do -- floor_divide 85
 local a=np.array({{0.0,0.5,-3.0},{9.0,9.0,0.5}},np.float16)
 local b=np.array({{3,7,-9}},np.int32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 85 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 85')
 assert(veq(r:tolist(),{{0.0,0.0,0.0},{3.0,1.0,-1.0}}),'floor_divide values 85')
end
do -- floor_divide 86
 local a=np.array({0,3,15,63,5},np.uint16)
 local b=np.array({-1.5,0.5,3.5,0.5,1.0},np.float64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','floor_divide dtype 86 '..r.dtype)
 assert(seqeq(r.shape,{5}),'floor_divide shape 86')
 assert(veq(r:tolist(),{-0.0,6.0,4.0,126.0,5.0}),'floor_divide values 86')
end
do -- floor_divide 87
 local a=np.array({true,false,false,true,true},np.bool)
 local b=np.array({127,3,5,2,0},np.uint16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='uint16','floor_divide dtype 87 '..r.dtype)
 assert(seqeq(r.shape,{5}),'floor_divide shape 87')
 assert(veq(r:tolist(),{0,0,0,0,0}),'floor_divide values 87')
end
do -- floor_divide 88
 local a=np.array({{true,true,true},{false,false,true}},np.bool)
 local b=np.array({{3,2,15}},np.int32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int32','floor_divide dtype 88 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 88')
 assert(veq(r:tolist(),{{0,0,0},{0,0,0}}),'floor_divide values 88')
end
do -- floor_divide 89
 local a=np.array({{-1.5},{0.0}},np.float32)
 local b=np.array({{2,0,5}},np.uint16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','floor_divide dtype 89 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 89')
 assert(veq(r:tolist(),{{-1.0,-math.huge,-1.0},{0.0,(0/0),0.0}}),'floor_divide values 89')
end
do -- floor_divide 90
 local a=np.array({{127,1,7},{31,127,63}},np.uint32)
 local b=np.array({-1,3,7},np.int16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int64','floor_divide dtype 90 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 90')
 assert(veq(r:tolist(),{{-127,0,1},{-31,42,9}}),'floor_divide values 90')
end
do -- floor_divide 91
 local a=np.array({{7},{3}},np.uint32)
 local b=np.array({{15,7,-3}},np.int16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='int64','floor_divide dtype 91 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 91')
 assert(veq(r:tolist(),{{0,1,-3},{0,0,-1}}),'floor_divide values 91')
end
do -- floor_divide 92
 local a=np.array({{-1.0},{2.0}},np.float16)
 local b=np.array({{15,-31,15}},np.int8)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float16','floor_divide dtype 92 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 92')
 assert(veq(r:tolist(),{{-1.0,0.0,-1.0},{0.0,-1.0,0.0}}),'floor_divide values 92')
end
do -- floor_divide 93
 local a=np.array({{false,true,true},{false,true,true}},np.bool)
 local b=np.array({3,1,127},np.uint16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='uint16','floor_divide dtype 93 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 93')
 assert(veq(r:tolist(),{{0,1,0},{0,1,0}}),'floor_divide values 93')
end
do -- floor_divide 94
 local a=np.array({{31,5,31},{63,1,63}},np.uint16)
 local b=np.array({{1,1,15}},np.uint8)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='uint16','floor_divide dtype 94 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'floor_divide shape 94')
 assert(veq(r:tolist(),{{31,5,2},{63,1,4}}),'floor_divide values 94')
end
do -- remainder 95
 local a=np.array({{31,15,3},{7,31,2}},np.uint16)
 local b=np.array({true,false,true},np.bool)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint16','remainder dtype 95 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 95')
 assert(veq(r:tolist(),{{0,0,0},{0,0,0}}),'remainder values 95')
end
do -- remainder 96
 local a=np.array({{1},{127}},np.uint8)
 local b=np.array({{2.0,2.0,-3.0}},np.float16)
 local r=np.remainder(a,b)
 assert(r.dtype=='float16','remainder dtype 96 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 96')
 assert(veq(r:tolist(),{{1.0,1.0,-2.0},{1.0,1.0,-2.0}}),'remainder values 96')
end
do -- remainder 97
 local a=np.array({{0},{1}},np.uint8)
 local b=np.array({{-9,15,-31}},np.int32)
 local r=np.remainder(a,b)
 assert(r.dtype=='int32','remainder dtype 97 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 97')
 assert(veq(r:tolist(),{{0,0,0},{-8,1,-30}}),'remainder values 97')
end
do -- remainder 98
 local a=np.array({{-1.5},{-1.5}},np.float16)
 local b=np.array({{15,63,7}},np.uint8)
 local r=np.remainder(a,b)
 assert(r.dtype=='float16','remainder dtype 98 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 98')
 assert(veq(r:tolist(),{{13.5,61.5,5.5},{13.5,61.5,5.5}}),'remainder values 98')
end
do -- remainder 99
 local a=np.array({{5,15,5},{63,2,127}},np.uint8)
 local b=np.array({false,false,true},np.bool)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint8','remainder dtype 99 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 99')
 assert(veq(r:tolist(),{{0,0,0},{0,0,0}}),'remainder values 99')
end
do -- remainder 100
 local a=np.array({9.0,1.0,-0.0,-3.0,0.5},np.float32)
 local b=np.array({-1.0,-1.0,3.5,-1.0,0.0},np.float32)
 local r=np.remainder(a,b)
 assert(r.dtype=='float32','remainder dtype 100 '..r.dtype)
 assert(seqeq(r.shape,{5}),'remainder shape 100')
 assert(veq(r:tolist(),{-0.0,-0.0,0.0,-0.0,(0/0)}),'remainder values 100')
end
do -- remainder 101
 local a=np.array({0,0,31,63,2},np.uint32)
 local b=np.array({-1,15,0,3,-3},np.int8)
 local r=np.remainder(a,b)
 assert(r.dtype=='int64','remainder dtype 101 '..r.dtype)
 assert(seqeq(r.shape,{5}),'remainder shape 101')
 assert(veq(r:tolist(),{0,0,0,0,-1}),'remainder values 101')
end
do -- remainder 102
 local a=np.array({{-3},{2}},np.int8)
 local b=np.array({{-9,2,-31}},np.int16)
 local r=np.remainder(a,b)
 assert(r.dtype=='int16','remainder dtype 102 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 102')
 assert(veq(r:tolist(),{{-3,1,-3},{-7,0,-29}}),'remainder values 102')
end
do -- remainder 103
 local a=np.array({{-31,0,-9},{30,2,30}},np.int64)
 local b=np.array({{0,2,1}},np.int64)
 local r=np.remainder(a,b)
 assert(r.dtype=='int64','remainder dtype 103 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 103')
 assert(veq(r:tolist(),{{0,0,0},{0,0,0}}),'remainder values 103')
end
do -- remainder 104
 local a=np.array({{0,-1,7},{-31,30,-9}},np.int32)
 local b=np.array({{2,-1,1}},np.int64)
 local r=np.remainder(a,b)
 assert(r.dtype=='int64','remainder dtype 104 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 104')
 assert(veq(r:tolist(),{{0,0,0},{1,0,0}}),'remainder values 104')
end
do -- remainder 105
 local a=np.array({{7,3,7},{5,2,127}},np.uint32)
 local b=np.array({{2,0,127}},np.uint16)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint32','remainder dtype 105 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 105')
 assert(veq(r:tolist(),{{1,0,7},{1,0,0}}),'remainder values 105')
end
do -- remainder 106
 local a=np.array({{15},{-3}},np.int16)
 local b=np.array({{1,2,0}},np.int8)
 local r=np.remainder(a,b)
 assert(r.dtype=='int16','remainder dtype 106 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 106')
 assert(veq(r:tolist(),{{0,1,0},{0,1,0}}),'remainder values 106')
end
do -- remainder 107
 local a=np.array({{-1.5,2.0,-9.5},{-1.5,-1.0,0.0}},np.float16)
 local b=np.array({31,2,0},np.uint8)
 local r=np.remainder(a,b)
 assert(r.dtype=='float16','remainder dtype 107 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 107')
 assert(veq(r:tolist(),{{29.5,0.0,(0/0)},{29.5,1.0,(0/0)}}),'remainder values 107')
end
do -- remainder 108
 local a=np.array({{30,-3,3},{-3,2,1}},np.int8)
 local b=np.array({{-3,0,7}},np.int16)
 local r=np.remainder(a,b)
 assert(r.dtype=='int16','remainder dtype 108 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 108')
 assert(veq(r:tolist(),{{0,0,3},{0,0,1}}),'remainder values 108')
end
do -- remainder 109
 local a=np.array({{0},{0}},np.uint8)
 local b=np.array({{127,1,1}},np.uint32)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint32','remainder dtype 109 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 109')
 assert(veq(r:tolist(),{{0,0,0},{0,0,0}}),'remainder values 109')
end
do -- remainder 110
 local a=np.array({{5,31,3},{127,5,2}},np.uint8)
 local b=np.array({0,-31,-3},np.int8)
 local r=np.remainder(a,b)
 assert(r.dtype=='int16','remainder dtype 110 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 110')
 assert(veq(r:tolist(),{{0,0,0},{0,-26,-1}}),'remainder values 110')
end
do -- remainder 111
 local a=np.array({{1.0,0.0,0.5},{3.5,-0.0,1.0}},np.float64)
 local b=np.array({1,15,31},np.uint8)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 111 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 111')
 assert(veq(r:tolist(),{{0.0,0.0,0.5},{0.5,0.0,1.0}}),'remainder values 111')
end
do -- remainder 112
 local a=np.array({{3.5,2.0,-1.5},{-0.0,-3.0,9.0}},np.float64)
 local b=np.array({0,7,-31},np.int16)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 112 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 112')
 assert(veq(r:tolist(),{{(0/0),2.0,-1.5},{(0/0),4.0,-22.0}}),'remainder values 112')
end
do -- remainder 113
 local a=np.array({31,1,127,0,3},np.uint8)
 local b=np.array({2,0,-9,1,-31},np.int8)
 local r=np.remainder(a,b)
 assert(r.dtype=='int16','remainder dtype 113 '..r.dtype)
 assert(seqeq(r.shape,{5}),'remainder shape 113')
 assert(veq(r:tolist(),{1,0,-8,0,-28}),'remainder values 113')
end
do -- remainder 114
 local a=np.array({{15,15,5},{7,63,127}},np.uint32)
 local b=np.array({{15,2,7}},np.uint32)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint32','remainder dtype 114 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 114')
 assert(veq(r:tolist(),{{0,1,5},{7,1,1}}),'remainder values 114')
end
do -- remainder 115
 local a=np.array({{7,1,-31},{15,-31,3}},np.int64)
 local b=np.array({{7,3,0}},np.uint16)
 local r=np.remainder(a,b)
 assert(r.dtype=='int64','remainder dtype 115 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 115')
 assert(veq(r:tolist(),{{0,1,0},{1,2,0}}),'remainder values 115')
end
do -- remainder 116
 local a=np.array({{1,1,-3},{-9,30,2}},np.int8)
 local b=np.array({{5,7,127}},np.uint8)
 local r=np.remainder(a,b)
 assert(r.dtype=='int16','remainder dtype 116 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 116')
 assert(veq(r:tolist(),{{1,1,124},{1,2,2}}),'remainder values 116')
end
do -- remainder 117
 local a=np.array({{7,30,-9},{15,2,-1}},np.int32)
 local b=np.array({15,0,3},np.int32)
 local r=np.remainder(a,b)
 assert(r.dtype=='int32','remainder dtype 117 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 117')
 assert(veq(r:tolist(),{{7,0,0},{0,0,2}}),'remainder values 117')
end
do -- remainder 118
 local a=np.array({0,31,0,127,0},np.uint16)
 local b=np.array({2.0,9.0,2.0,2.0,-9.5},np.float64)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 118 '..r.dtype)
 assert(seqeq(r.shape,{5}),'remainder shape 118')
 assert(veq(r:tolist(),{0.0,4.0,0.0,1.0,-0.0}),'remainder values 118')
end
do -- remainder 119
 local a=np.array({{63},{5}},np.uint16)
 local b=np.array({{1,15,127}},np.uint8)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint16','remainder dtype 119 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 119')
 assert(veq(r:tolist(),{{0,3,63},{0,5,5}}),'remainder values 119')
end
do -- remainder 120
 local a=np.array({{0},{-9}},np.int64)
 local b=np.array({{5,3,15}},np.uint64)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 120 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 120')
 assert(veq(r:tolist(),{{0.0,0.0,0.0},{1.0,0.0,6.0}}),'remainder values 120')
end
do -- remainder 121
 local a=np.array({{false,true,true},{true,false,false}},np.bool)
 local b=np.array({5,15,63},np.uint16)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint16','remainder dtype 121 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 121')
 assert(veq(r:tolist(),{{0,1,1},{1,0,0}}),'remainder values 121')
end
do -- remainder 122
 local a=np.array({{0,0,15},{1,5,15}},np.uint8)
 local b=np.array({1,63,3},np.uint64)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint64','remainder dtype 122 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 122')
 assert(veq(r:tolist(),{{0,0,0},{0,5,0}}),'remainder values 122')
end
do -- remainder 123
 local a=np.array({{false,true,true},{false,true,false}},np.bool)
 local b=np.array({{127,5,31}},np.uint16)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint16','remainder dtype 123 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 123')
 assert(veq(r:tolist(),{{0,1,1},{0,1,0}}),'remainder values 123')
end
do -- remainder 124
 local a=np.array({5,63,3,127,1},np.uint16)
 local b=np.array({2.0,-1.0,-1.0,0.0,0.0},np.float16)
 local r=np.remainder(a,b)
 assert(r.dtype=='float32','remainder dtype 124 '..r.dtype)
 assert(seqeq(r.shape,{5}),'remainder shape 124')
 assert(veq(r:tolist(),{1.0,-0.0,-0.0,(0/0),(0/0)}),'remainder values 124')
end
do -- remainder 125
 local a=np.array({{1,63,127},{63,0,7}},np.uint8)
 local b=np.array({{-0.0,0.5,-1.5}},np.float16)
 local r=np.remainder(a,b)
 assert(r.dtype=='float16','remainder dtype 125 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 125')
 assert(veq(r:tolist(),{{(0/0),0.0,-0.5},{(0/0),0.0,-0.5}}),'remainder values 125')
end
do -- remainder 126
 local a=np.array({{9.0},{-9.5}},np.float32)
 local b=np.array({{63,3,0}},np.uint32)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 126 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 126')
 assert(veq(r:tolist(),{{9.0,0.0,(0/0)},{53.5,2.5,(0/0)}}),'remainder values 126')
end
do -- remainder 127
 local a=np.array({{-3.0},{2.0}},np.float64)
 local b=np.array({{2,30,-9}},np.int64)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 127 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 127')
 assert(veq(r:tolist(),{{1.0,27.0,-3.0},{0.0,2.0,-7.0}}),'remainder values 127')
end
do -- remainder 128
 local a=np.array({1.0,-3.0,-9.5,-1.0,2.0},np.float32)
 local b=np.array({true,false,false,true,true},np.bool)
 local r=np.remainder(a,b)
 assert(r.dtype=='float32','remainder dtype 128 '..r.dtype)
 assert(seqeq(r.shape,{5}),'remainder shape 128')
 assert(veq(r:tolist(),{0.0,(0/0),(0/0),0.0,0.0}),'remainder values 128')
end
do -- remainder 129
 local a=np.array({{false},{true}},np.bool)
 local b=np.array({{-9.5,9.0,3.5}},np.float64)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 129 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 129')
 assert(veq(r:tolist(),{{-0.0,0.0,0.0},{-8.5,1.0,1.0}}),'remainder values 129')
end
do -- remainder 130
 local a=np.array({{1},{-31}},np.int64)
 local b=np.array({{-9,15,7}},np.int8)
 local r=np.remainder(a,b)
 assert(r.dtype=='int64','remainder dtype 130 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 130')
 assert(veq(r:tolist(),{{-8,1,1},{-4,14,4}}),'remainder values 130')
end
do -- remainder 131
 local a=np.array({{5,3,5},{0,2,15}},np.uint32)
 local b=np.array({{-3,-1,0}},np.int8)
 local r=np.remainder(a,b)
 assert(r.dtype=='int64','remainder dtype 131 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 131')
 assert(veq(r:tolist(),{{-1,0,0},{0,0,0}}),'remainder values 131')
end
do -- remainder 132
 local a=np.array({{63},{5}},np.uint32)
 local b=np.array({{2,0,15}},np.uint64)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint64','remainder dtype 132 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 132')
 assert(veq(r:tolist(),{{1,0,3},{1,0,5}}),'remainder values 132')
end
do -- remainder 133
 local a=np.array({{7,15,30},{0,7,-31}},np.int64)
 local b=np.array({{7,1,-31}},np.int8)
 local r=np.remainder(a,b)
 assert(r.dtype=='int64','remainder dtype 133 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 133')
 assert(veq(r:tolist(),{{0,0,-1},{0,0,0}}),'remainder values 133')
end
do -- remainder 134
 local a=np.array({1.0,-3.0,1.0,-9.5,0.0},np.float32)
 local b=np.array({0.5,-1.5,-1.0,0.5,1.0},np.float16)
 local r=np.remainder(a,b)
 assert(r.dtype=='float32','remainder dtype 134 '..r.dtype)
 assert(seqeq(r.shape,{5}),'remainder shape 134')
 assert(veq(r:tolist(),{0.0,-0.0,-0.0,0.0,0.0}),'remainder values 134')
end
do -- remainder 135
 local a=np.array({{false,false,true},{false,false,true}},np.bool)
 local b=np.array({15,127,7},np.uint16)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint16','remainder dtype 135 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 135')
 assert(veq(r:tolist(),{{0,0,1},{0,0,1}}),'remainder values 135')
end
do -- remainder 136
 local a=np.array({{0.0,0.5,3.5},{3.5,-9.5,0.0}},np.float32)
 local b=np.array({{7,2,31}},np.uint64)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 136 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 136')
 assert(veq(r:tolist(),{{0.0,0.5,3.5},{3.5,0.5,0.0}}),'remainder values 136')
end
do -- remainder 137
 local a=np.array({{15,-31,7},{30,15,-31}},np.int32)
 local b=np.array({{0.0,1.0,-9.5}},np.float32)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 137 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 137')
 assert(veq(r:tolist(),{{(0/0),0.0,-2.5},{(0/0),0.0,-2.5}}),'remainder values 137')
end
do -- remainder 138
 local a=np.array({{7},{5}},np.uint64)
 local b=np.array({{0,63,0}},np.uint64)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint64','remainder dtype 138 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 138')
 assert(veq(r:tolist(),{{0,7,0},{0,5,0}}),'remainder values 138')
end
do -- remainder 139
 local a=np.array({{3,-3,2},{15,30,7}},np.int64)
 local b=np.array({{true,false,false}},np.bool)
 local r=np.remainder(a,b)
 assert(r.dtype=='int64','remainder dtype 139 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 139')
 assert(veq(r:tolist(),{{0,0,0},{0,0,0}}),'remainder values 139')
end
do -- remainder 140
 local a=np.array({9.0,9.0,-0.0,9.0,2.0},np.float32)
 local b=np.array({false,false,false,false,true},np.bool)
 local r=np.remainder(a,b)
 assert(r.dtype=='float32','remainder dtype 140 '..r.dtype)
 assert(seqeq(r.shape,{5}),'remainder shape 140')
 assert(veq(r:tolist(),{(0/0),(0/0),(0/0),(0/0),0.0}),'remainder values 140')
end
do -- remainder 141
 local a=np.array({{false,true,false},{false,true,false}},np.bool)
 local b=np.array({{127,31,63}},np.uint32)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint32','remainder dtype 141 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 141')
 assert(veq(r:tolist(),{{0,1,0},{0,1,0}}),'remainder values 141')
end
do -- remainder 142
 local a=np.array({{1.0,-0.0,-1.5},{3.5,-9.5,3.5}},np.float64)
 local b=np.array({false,false,true},np.bool)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 142 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 142')
 assert(veq(r:tolist(),{{(0/0),(0/0),0.5},{(0/0),(0/0),0.5}}),'remainder values 142')
end
do -- remainder 143
 local a=np.array({{127,63,5},{3,63,0}},np.uint64)
 local b=np.array({{5,3,5}},np.uint32)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint64','remainder dtype 143 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 143')
 assert(veq(r:tolist(),{{2,0,0},{3,0,0}}),'remainder values 143')
end
do -- remainder 144
 local a=np.array({{7,1,63},{15,5,63}},np.uint8)
 local b=np.array({63,7,15},np.uint64)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint64','remainder dtype 144 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 144')
 assert(veq(r:tolist(),{{7,1,3},{15,5,3}}),'remainder values 144')
end
do -- remainder 145
 local a=np.array({{-1.0,-1.5,9.0},{-3.0,9.0,0.0}},np.float64)
 local b=np.array({{127,31,0}},np.uint32)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 145 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 145')
 assert(veq(r:tolist(),{{126.0,29.5,(0/0)},{124.0,9.0,(0/0)}}),'remainder values 145')
end
do -- remainder 146
 local a=np.array({{0.5},{-1.5}},np.float64)
 local b=np.array({{0,0,30}},np.int64)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 146 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 146')
 assert(veq(r:tolist(),{{(0/0),(0/0),0.5},{(0/0),(0/0),28.5}}),'remainder values 146')
end
do -- remainder 147
 local a=np.array({{1,15,-9},{-31,1,1}},np.int64)
 local b=np.array({3.5,-1.5,3.5},np.float16)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 147 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 147')
 assert(veq(r:tolist(),{{1.0,-0.0,1.5},{0.5,-0.5,1.0}}),'remainder values 147')
end
do -- remainder 148
 local a=np.array({{2.0,0.0,-1.0},{-9.5,2.0,1.0}},np.float32)
 local b=np.array({{3,0,-1}},np.int64)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 148 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 148')
 assert(veq(r:tolist(),{{2.0,(0/0),-0.0},{2.5,(0/0),-0.0}}),'remainder values 148')
end
do -- remainder 149
 local a=np.array({{7,-9,7},{2,7,-31}},np.int8)
 local b=np.array({{3,127,3}},np.uint32)
 local r=np.remainder(a,b)
 assert(r.dtype=='int64','remainder dtype 149 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 149')
 assert(veq(r:tolist(),{{1,118,1},{2,7,2}}),'remainder values 149')
end
do -- remainder 150
 local a=np.array({{true,true,false},{true,true,true}},np.bool)
 local b=np.array({-31,2,3},np.int8)
 local r=np.remainder(a,b)
 assert(r.dtype=='int8','remainder dtype 150 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 150')
 assert(veq(r:tolist(),{{-30,1,0},{-30,1,1}}),'remainder values 150')
end
do -- remainder 151
 local a=np.array({15,3,2,-9,2},np.int32)
 local b=np.array({15,1,-31,-1,0},np.int32)
 local r=np.remainder(a,b)
 assert(r.dtype=='int32','remainder dtype 151 '..r.dtype)
 assert(seqeq(r.shape,{5}),'remainder shape 151')
 assert(veq(r:tolist(),{0,0,-29,0,0}),'remainder values 151')
end
do -- remainder 152
 local a=np.array({30,3,3,2,7},np.int16)
 local b=np.array({3,7,-31,-31,2},np.int8)
 local r=np.remainder(a,b)
 assert(r.dtype=='int16','remainder dtype 152 '..r.dtype)
 assert(seqeq(r.shape,{5}),'remainder shape 152')
 assert(veq(r:tolist(),{0,3,-28,-29,1}),'remainder values 152')
end
do -- remainder 153
 local a=np.array({{5,1,15},{31,15,31}},np.uint64)
 local b=np.array({{2.0,3.5,1.0}},np.float32)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 153 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 153')
 assert(veq(r:tolist(),{{1.0,1.0,0.0},{1.0,1.0,0.0}}),'remainder values 153')
end
do -- remainder 154
 local a=np.array({{1,2,7},{30,30,-31}},np.int16)
 local b=np.array({{9.0,-0.0,3.5}},np.float64)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 154 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 154')
 assert(veq(r:tolist(),{{1.0,(0/0),0.0},{3.0,(0/0),0.5}}),'remainder values 154')
end
do -- remainder 155
 local a=np.array({{-3.0,-0.0,0.0},{9.0,-3.0,2.0}},np.float64)
 local b=np.array({-9,-9,-1},np.int8)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 155 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 155')
 assert(veq(r:tolist(),{{-3.0,-0.0,-0.0},{-0.0,-3.0,-0.0}}),'remainder values 155')
end
do -- remainder 156
 local a=np.array({{-31,1,2},{-9,-9,-31}},np.int64)
 local b=np.array({{3,0,63}},np.uint16)
 local r=np.remainder(a,b)
 assert(r.dtype=='int64','remainder dtype 156 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 156')
 assert(veq(r:tolist(),{{2,0,2},{0,0,32}}),'remainder values 156')
end
do -- remainder 157
 local a=np.array({{15,-1,7},{-1,2,15}},np.int32)
 local b=np.array({{0,2,3}},np.uint16)
 local r=np.remainder(a,b)
 assert(r.dtype=='int32','remainder dtype 157 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 157')
 assert(veq(r:tolist(),{{0,1,1},{0,0,0}}),'remainder values 157')
end
do -- remainder 158
 local a=np.array({{true},{true}},np.bool)
 local b=np.array({{3,15,2}},np.int8)
 local r=np.remainder(a,b)
 assert(r.dtype=='int8','remainder dtype 158 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 158')
 assert(veq(r:tolist(),{{1,1,1},{1,1,1}}),'remainder values 158')
end
do -- remainder 159
 local a=np.array({2.0,-1.0,-1.0,-0.0,-0.0},np.float64)
 local b=np.array({3,15,-1,1,-3},np.int64)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 159 '..r.dtype)
 assert(seqeq(r.shape,{5}),'remainder shape 159')
 assert(veq(r:tolist(),{2.0,14.0,-0.0,0.0,-0.0}),'remainder values 159')
end
do -- remainder 160
 local a=np.array({{9.0,1.0,2.0},{3.5,-0.0,-1.0}},np.float16)
 local b=np.array({false,false,false},np.bool)
 local r=np.remainder(a,b)
 assert(r.dtype=='float16','remainder dtype 160 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 160')
 assert(veq(r:tolist(),{{(0/0),(0/0),(0/0)},{(0/0),(0/0),(0/0)}}),'remainder values 160')
end
do -- remainder 161
 local a=np.array({5,2,5,7,127},np.uint8)
 local b=np.array({false,true,true,true,false},np.bool)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint8','remainder dtype 161 '..r.dtype)
 assert(seqeq(r.shape,{5}),'remainder shape 161')
 assert(veq(r:tolist(),{0,0,0,0,0}),'remainder values 161')
end
do -- remainder 162
 local a=np.array({{-1.5},{-1.0}},np.float32)
 local b=np.array({{15,0,2}},np.uint64)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 162 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 162')
 assert(veq(r:tolist(),{{13.5,(0/0),0.5},{14.0,(0/0),1.0}}),'remainder values 162')
end
do -- remainder 163
 local a=np.array({{3.5},{0.5}},np.float32)
 local b=np.array({{-1,15,0}},np.int64)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 163 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 163')
 assert(veq(r:tolist(),{{-0.5,3.5,(0/0)},{-0.5,0.5,(0/0)}}),'remainder values 163')
end
do -- remainder 164
 local a=np.array({{15,15,15},{0,15,0}},np.int32)
 local b=np.array({{-1.0,-1.5,3.5}},np.float64)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 164 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 164')
 assert(veq(r:tolist(),{{-0.0,-0.0,1.0},{-0.0,-0.0,0.0}}),'remainder values 164')
end
do -- remainder 165
 local a=np.array({1.0,0.0,-1.5,-1.0,0.0},np.float16)
 local b=np.array({1,3,1,31,0},np.uint64)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 165 '..r.dtype)
 assert(seqeq(r.shape,{5}),'remainder shape 165')
 assert(veq(r:tolist(),{0.0,0.0,0.5,30.0,(0/0)}),'remainder values 165')
end
do -- remainder 166
 local a=np.array({{9.0},{2.0}},np.float32)
 local b=np.array({{-31,7,15}},np.int64)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 166 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 166')
 assert(veq(r:tolist(),{{-22.0,2.0,9.0},{-29.0,2.0,2.0}}),'remainder values 166')
end
do -- remainder 167
 local a=np.array({{1,127,15},{31,127,127}},np.uint16)
 local b=np.array({{9.0,0.5,-0.0}},np.float32)
 local r=np.remainder(a,b)
 assert(r.dtype=='float32','remainder dtype 167 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 167')
 assert(veq(r:tolist(),{{1.0,0.0,(0/0)},{4.0,0.0,(0/0)}}),'remainder values 167')
end
do -- remainder 168
 local a=np.array({{-3,15,15},{-3,15,-31}},np.int16)
 local b=np.array({false,false,false},np.bool)
 local r=np.remainder(a,b)
 assert(r.dtype=='int16','remainder dtype 168 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 168')
 assert(veq(r:tolist(),{{0,0,0},{0,0,0}}),'remainder values 168')
end
do -- remainder 169
 local a=np.array({{7},{5}},np.uint32)
 local b=np.array({{1,127,7}},np.uint8)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint32','remainder dtype 169 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 169')
 assert(veq(r:tolist(),{{0,7,0},{0,5,5}}),'remainder values 169')
end
do -- remainder 170
 local a=np.array({7,3,3,63,1},np.uint8)
 local b=np.array({31,1,0,7,31},np.uint32)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint32','remainder dtype 170 '..r.dtype)
 assert(seqeq(r.shape,{5}),'remainder shape 170')
 assert(veq(r:tolist(),{7,0,0,0,1}),'remainder values 170')
end
do -- remainder 171
 local a=np.array({{3,1,0},{3,127,5}},np.uint64)
 local b=np.array({{0,1,15}},np.uint32)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint64','remainder dtype 171 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 171')
 assert(veq(r:tolist(),{{0,0,0},{0,0,5}}),'remainder values 171')
end
do -- remainder 172
 local a=np.array({{-0.0,-1.0,0.5},{-3.0,3.5,-9.5}},np.float16)
 local b=np.array({{127,63,3}},np.uint16)
 local r=np.remainder(a,b)
 assert(r.dtype=='float32','remainder dtype 172 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 172')
 assert(veq(r:tolist(),{{0.0,62.0,0.5},{124.0,3.5,2.5}}),'remainder values 172')
end
do -- remainder 173
 local a=np.array({{15,3,7},{127,63,1}},np.uint32)
 local b=np.array({0,2,3},np.uint64)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint64','remainder dtype 173 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 173')
 assert(veq(r:tolist(),{{0,1,1},{0,1,1}}),'remainder values 173')
end
do -- remainder 174
 local a=np.array({{7},{30}},np.int64)
 local b=np.array({{-3,-1,-3}},np.int64)
 local r=np.remainder(a,b)
 assert(r.dtype=='int64','remainder dtype 174 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 174')
 assert(veq(r:tolist(),{{-2,0,-2},{0,0,0}}),'remainder values 174')
end
do -- remainder 175
 local a=np.array({{1,3,2},{5,5,15}},np.uint32)
 local b=np.array({false,false,false},np.bool)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint32','remainder dtype 175 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 175')
 assert(veq(r:tolist(),{{0,0,0},{0,0,0}}),'remainder values 175')
end
do -- remainder 176
 local a=np.array({{30},{7}},np.int64)
 local b=np.array({{127,63,31}},np.uint32)
 local r=np.remainder(a,b)
 assert(r.dtype=='int64','remainder dtype 176 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 176')
 assert(veq(r:tolist(),{{30,30,30},{7,7,7}}),'remainder values 176')
end
do -- remainder 177
 local a=np.array({{31,63,5},{1,1,7}},np.uint32)
 local b=np.array({{0.0,9.0,0.0}},np.float64)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 177 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 177')
 assert(veq(r:tolist(),{{(0/0),0.0,(0/0)},{(0/0),1.0,(0/0)}}),'remainder values 177')
end
do -- remainder 178
 local a=np.array({{-1.5,9.0,0.5},{-9.5,-3.0,2.0}},np.float64)
 local b=np.array({-9,7,30},np.int32)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 178 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 178')
 assert(veq(r:tolist(),{{-1.5,2.0,0.5},{-0.5,4.0,2.0}}),'remainder values 178')
end
do -- remainder 179
 local a=np.array({{true,true,true},{false,false,false}},np.bool)
 local b=np.array({{3,0,7}},np.uint8)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint8','remainder dtype 179 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 179')
 assert(veq(r:tolist(),{{1,0,1},{0,0,0}}),'remainder values 179')
end
do -- remainder 180
 local a=np.array({{127},{1}},np.uint32)
 local b=np.array({{-3.0,3.5,-9.5}},np.float16)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 180 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 180')
 assert(veq(r:tolist(),{{-2.0,1.0,-6.0},{-2.0,1.0,-8.5}}),'remainder values 180')
end
do -- remainder 181
 local a=np.array({{true},{false}},np.bool)
 local b=np.array({{2,5,5}},np.uint64)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint64','remainder dtype 181 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 181')
 assert(veq(r:tolist(),{{1,1,1},{0,0,0}}),'remainder values 181')
end
do -- remainder 182
 local a=np.array({0,63,127,31,15},np.uint16)
 local b=np.array({true,true,false,false,false},np.bool)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint16','remainder dtype 182 '..r.dtype)
 assert(seqeq(r.shape,{5}),'remainder shape 182')
 assert(veq(r:tolist(),{0,0,0,0,0}),'remainder values 182')
end
do -- remainder 183
 local a=np.array({{-3},{15}},np.int8)
 local b=np.array({{3,15,5}},np.uint16)
 local r=np.remainder(a,b)
 assert(r.dtype=='int32','remainder dtype 183 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 183')
 assert(veq(r:tolist(),{{0,12,2},{0,0,0}}),'remainder values 183')
end
do -- remainder 184
 local a=np.array({{2,2,2},{0,5,1}},np.uint16)
 local b=np.array({63,7,127},np.uint16)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint16','remainder dtype 184 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 184')
 assert(veq(r:tolist(),{{2,2,2},{0,5,1}}),'remainder values 184')
end
do -- remainder 185
 local a=np.array({{-31},{-31}},np.int8)
 local b=np.array({{-9,2,0}},np.int8)
 local r=np.remainder(a,b)
 assert(r.dtype=='int8','remainder dtype 185 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 185')
 assert(veq(r:tolist(),{{-4,1,0},{-4,1,0}}),'remainder values 185')
end
do -- remainder 186
 local a=np.array({2.0,-3.0,0.5,3.5,0.5},np.float64)
 local b=np.array({0,0,31,5,2},np.uint16)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 186 '..r.dtype)
 assert(seqeq(r.shape,{5}),'remainder shape 186')
 assert(veq(r:tolist(),{(0/0),(0/0),0.5,3.5,0.5}),'remainder values 186')
end
do -- remainder 187
 local a=np.array({{true,false,true},{false,false,false}},np.bool)
 local b=np.array({{-1.5,3.5,0.0}},np.float32)
 local r=np.remainder(a,b)
 assert(r.dtype=='float32','remainder dtype 187 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 187')
 assert(veq(r:tolist(),{{-0.5,0.0,(0/0)},{-0.0,0.0,(0/0)}}),'remainder values 187')
end
do -- remainder 188
 local a=np.array({31,31,63,3,2},np.uint8)
 local b=np.array({true,false,true,false,false},np.bool)
 local r=np.remainder(a,b)
 assert(r.dtype=='uint8','remainder dtype 188 '..r.dtype)
 assert(seqeq(r.shape,{5}),'remainder shape 188')
 assert(veq(r:tolist(),{0,0,0,0,0}),'remainder values 188')
end
do -- remainder 189
 local a=np.array({{63},{63}},np.uint64)
 local b=np.array({{-1.5,2.0,-0.0}},np.float64)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','remainder dtype 189 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'remainder shape 189')
 assert(veq(r:tolist(),{{-0.0,1.0,(0/0)},{-0.0,1.0,(0/0)}}),'remainder values 189')
end
do -- power 190
 local a=np.array({true,false,true,true,false},np.bool)
 local b=np.array({3.5,-0.0,1.0,1.0,2.0},np.float16)
 local r=np.power(a,b)
 assert(r.dtype=='float16','power dtype 190 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 190')
 assert(veq(r:tolist(),{1.0,1.0,1.0,1.0,0.0}),'power values 190')
end
do -- power 191
 local a=np.array({{0,-1,2},{-1,-1,-1}},np.int64)
 local b=np.array({{4,2,1}},np.int64)
 local r=np.power(a,b)
 assert(r.dtype=='int64','power dtype 191 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 191')
 assert(veq(r:tolist(),{{0,1,2},{1,1,-1}}),'power values 191')
end
do -- power 192
 local a=np.array({{15,1,1},{1,5,1}},np.uint32)
 local b=np.array({{1,7,127}},np.uint16)
 local r=np.power(a,b)
 assert(r.dtype=='uint32','power dtype 192 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 192')
 assert(veq(r:tolist(),{{15,1,1},{1,78125,1}}),'power values 192')
end
do -- power 193
 local a=np.array({0.5,0.5,-3.0,-0.0,-3.0},np.float16)
 local b=np.array({15,1,0,0,63},np.uint16)
 local r=np.power(a,b)
 assert(r.dtype=='float32','power dtype 193 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 193')
 assert(veq(r:tolist(),{3.0517578125e-05,0.5,1.0,1.0,-1.1445612489367993e+30}),'power values 193')
end
do -- power 194
 local a=np.array({{0.0,3.5,2.0},{2.0,9.0,0.0}},np.float32)
 local b=np.array({{1,7,1}},np.uint8)
 local r=np.power(a,b)
 assert(r.dtype=='float32','power dtype 194 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 194')
 assert(veq(r:tolist(),{{0.0,6433.9296875,2.0},{2.0,4782969.0,0.0}}),'power values 194')
end
do -- power 195
 local a=np.array({30,-1,-31,30,7},np.int32)
 local b=np.array({1,0,127,0,63},np.uint8)
 local r=np.power(a,b)
 assert(r.dtype=='int32','power dtype 195 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 195')
 assert(veq(r:tolist(),{30,1,292385825,1,1075496887}),'power values 195')
end
do -- power 196
 local a=np.array({{2,1,3},{7,3,-31}},np.int64)
 local b=np.array({-1.5,0.5,-9.5},np.float32)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 196 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 196')
 assert(veq(r:tolist(),{{0.3535533905932738,1.0,2.9332432514841524e-05},{0.05399492471560389,1.7320508075688772,(0/0)}}),'power values 196')
end
do -- power 197
 local a=np.array({{1,3,7},{7,3,63}},np.uint32)
 local b=np.array({0,2,1},np.int16)
 local r=np.power(a,b)
 assert(r.dtype=='int64','power dtype 197 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 197')
 assert(veq(r:tolist(),{{1,9,7},{1,9,63}}),'power values 197')
end
do -- power 198
 local a=np.array({{0,1,15},{0,15,7}},np.int8)
 local b=np.array({{1,7,5}},np.uint32)
 local r=np.power(a,b)
 assert(r.dtype=='int64','power dtype 198 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 198')
 assert(veq(r:tolist(),{{0,1,759375},{0,170859375,16807}}),'power values 198')
end
do -- power 199
 local a=np.array({0,7,15,-9,7},np.int64)
 local b=np.array({0.0,-0.0,0.0,1.0,1.0},np.float64)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 199 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 199')
 assert(veq(r:tolist(),{1.0,1.0,1.0,-9.0,7.0}),'power values 199')
end
do -- power 200
 local a=np.array({{63,63,3},{15,63,63}},np.uint64)
 local b=np.array({{3,5,127}},np.uint64)
 local r=np.power(a,b)
 assert(r.dtype=='uint64','power dtype 200 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 200')
 assert(veq(r:tolist(),{{250047,992436543,3080657310641694891},{3375,992436543,15680735152236400575}}),'power values 200')
end
do -- power 201
 local a=np.array({0,63,127,0,63},np.uint32)
 local b=np.array({5,5,3,4,4},np.int8)
 local r=np.power(a,b)
 assert(r.dtype=='int64','power dtype 201 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 201')
 assert(veq(r:tolist(),{0,992436543,2048383,0,15752961}),'power values 201')
end
do -- power 202
 local a=np.array({{-9},{-9}},np.int8)
 local b=np.array({{-1.0,0.0,0.5}},np.float32)
 local r=np.power(a,b)
 assert(r.dtype=='float32','power dtype 202 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 202')
 assert(veq(r:tolist(),{{-0.1111111119389534,1.0,(0/0)},{-0.1111111119389534,1.0,(0/0)}}),'power values 202')
end
do -- power 203
 local a=np.array({{3.5},{0.0}},np.float64)
 local b=np.array({{true,false,true}},np.bool)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 203 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 203')
 assert(veq(r:tolist(),{{3.5,1.0,3.5},{0.0,1.0,0.0}}),'power values 203')
end
do -- power 204
 local a=np.array({{0,15,1},{15,127,63}},np.uint64)
 local b=np.array({{31,7,31}},np.uint64)
 local r=np.power(a,b)
 assert(r.dtype=='uint64','power dtype 204 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 204')
 assert(veq(r:tolist(),{{0,170859375,1},{10238941742952751343,532875860165503,9455025818622162879}}),'power values 204')
end
do -- power 205
 local a=np.array({{-31,2,-31},{1,15,7}},np.int64)
 local b=np.array({{false,true,false}},np.bool)
 local r=np.power(a,b)
 assert(r.dtype=='int64','power dtype 205 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 205')
 assert(veq(r:tolist(),{{1,2,1},{1,15,1}}),'power values 205')
end
do -- power 206
 local a=np.array({{7,15,5},{2,0,63}},np.uint8)
 local b=np.array({3,15,0},np.uint32)
 local r=np.power(a,b)
 assert(r.dtype=='uint32','power dtype 206 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 206')
 assert(veq(r:tolist(),{{343,1500973039,1},{8,0,1}}),'power values 206')
end
do -- power 207
 local a=np.array({{-9},{3}},np.int16)
 local b=np.array({{5,0,0}},np.int8)
 local r=np.power(a,b)
 assert(r.dtype=='int16','power dtype 207 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 207')
 assert(veq(r:tolist(),{{6487,1,1},{243,1,1}}),'power values 207')
end
do -- power 208
 local a=np.array({{31},{63}},np.uint64)
 local b=np.array({{7,15,15}},np.uint64)
 local r=np.power(a,b)
 assert(r.dtype=='uint64','power dtype 208 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 208')
 assert(veq(r:tolist(),{{27512614111,1003530086136274399,1003530086136274399},{3938980639167,1909620909293269951,1909620909293269951}}),'power values 208')
end
do -- power 209
 local a=np.array({{9.0},{3.5}},np.float16)
 local b=np.array({{-9.5,0.5,3.5}},np.float64)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 209 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 209')
 assert(veq(r:tolist(),{{8.603915972377324e-10,3.0,2187.0},{6.781934306847033e-06,1.8708286933869707,80.21178022896636}}),'power values 209')
end
do -- power 210
 local a=np.array({{7,15,15},{5,2,3}},np.uint64)
 local b=np.array({true,true,false},np.bool)
 local r=np.power(a,b)
 assert(r.dtype=='uint64','power dtype 210 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 210')
 assert(veq(r:tolist(),{{7,15,1},{5,2,1}}),'power values 210')
end
do -- power 211
 local a=np.array({{9.0},{-9.5}},np.float64)
 local b=np.array({{0.0,3.5,2.0}},np.float32)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 211 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 211')
 assert(veq(r:tolist(),{{1.0,2187.0,81.0},{1.0,(0/0),90.25}}),'power values 211')
end
do -- power 212
 local a=np.array({{31},{7}},np.uint16)
 local b=np.array({{31,31,3}},np.uint32)
 local r=np.power(a,b)
 assert(r.dtype=='uint32','power dtype 212 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 212')
 assert(veq(r:tolist(),{{2284863455,2284863455,29791},{265001655,265001655,343}}),'power values 212')
end
do -- power 213
 local a=np.array({{1},{-31}},np.int8)
 local b=np.array({{3,2,0}},np.int16)
 local r=np.power(a,b)
 assert(r.dtype=='int16','power dtype 213 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 213')
 assert(veq(r:tolist(),{{1,1,1},{-29791,961,1}}),'power values 213')
end
do -- power 214
 local a=np.array({{127},{2}},np.uint32)
 local b=np.array({{2,3,5}},np.int32)
 local r=np.power(a,b)
 assert(r.dtype=='int64','power dtype 214 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 214')
 assert(veq(r:tolist(),{{16129,2048383,33038369407},{4,8,32}}),'power values 214')
end
do -- power 215
 local a=np.array({{-0.0,-9.5,-9.5},{2.0,-9.5,-0.0}},np.float64)
 local b=np.array({0.0,-3.0,0.5},np.float32)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 215 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 215')
 assert(veq(r:tolist(),{{1.0,-0.001166350779997084,(0/0)},{1.0,-0.001166350779997084,0.0}}),'power values 215')
end
do -- power 216
 local a=np.array({{1},{127}},np.uint32)
 local b=np.array({{3.5,2.0,0.5}},np.float32)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 216 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 216')
 assert(veq(r:tolist(),{{1.0,1.0,1.0},{23084104.058106802,16129.0,11.269427669584644}}),'power values 216')
end
do -- power 217
 local a=np.array({{3,0,-1},{2,0,1}},np.int16)
 local b=np.array({{-9.5,1.0,9.0}},np.float16)
 local r=np.power(a,b)
 assert(r.dtype=='float32','power dtype 217 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 217')
 assert(veq(r:tolist(),{{2.933243195002433e-05,0.0,-1.0},{0.0013810679083690047,0.0,1.0}}),'power values 217')
end
do -- power 218
 local a=np.array({{63,5,3},{1,63,127}},np.uint64)
 local b=np.array({7,1,2},np.uint64)
 local r=np.power(a,b)
 assert(r.dtype=='uint64','power dtype 218 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 218')
 assert(veq(r:tolist(),{{3938980639167,5,9},{1,63,16129}}),'power values 218')
end
do -- power 219
 local a=np.array({{1},{-31}},np.int8)
 local b=np.array({{1,4,4}},np.int32)
 local r=np.power(a,b)
 assert(r.dtype=='int32','power dtype 219 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 219')
 assert(veq(r:tolist(),{{1,1,1},{-31,923521,923521}}),'power values 219')
end
do -- power 220
 local a=np.array({0,2,5,0,0},np.uint16)
 local b=np.array({0,5,3,3,1},np.int8)
 local r=np.power(a,b)
 assert(r.dtype=='int32','power dtype 220 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 220')
 assert(veq(r:tolist(),{1,32,125,0,0}),'power values 220')
end
do -- power 221
 local a=np.array({-9,-1,-3,15,-3},np.int16)
 local b=np.array({2,15,7,7,127},np.uint32)
 local r=np.power(a,b)
 assert(r.dtype=='int64','power dtype 221 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 221')
 assert(veq(r:tolist(),{81,-1,-2187,170859375,-3080657310641694891}),'power values 221')
end
do -- power 222
 local a=np.array({1.0,-1.0,0.5,-0.0,2.0},np.float16)
 local b=np.array({63,1,15,15,1},np.uint16)
 local r=np.power(a,b)
 assert(r.dtype=='float32','power dtype 222 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 222')
 assert(veq(r:tolist(),{1.0,-1.0,3.0517578125e-05,-0.0,2.0}),'power values 222')
end
do -- power 223
 local a=np.array({{-1.5,1.0,-1.0},{2.0,2.0,2.0}},np.float64)
 local b=np.array({{false,true,false}},np.bool)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 223 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 223')
 assert(veq(r:tolist(),{{1.0,1.0,1.0},{1.0,2.0,1.0}}),'power values 223')
end
do -- power 224
 local a=np.array({{false},{false}},np.bool)
 local b=np.array({{2,7,3}},np.uint8)
 local r=np.power(a,b)
 assert(r.dtype=='uint8','power dtype 224 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 224')
 assert(veq(r:tolist(),{{0,0,0},{0,0,0}}),'power values 224')
end
do -- power 225
 local a=np.array({{true,true,true},{true,true,false}},np.bool)
 local b=np.array({{3,7,1}},np.uint64)
 local r=np.power(a,b)
 assert(r.dtype=='uint64','power dtype 225 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 225')
 assert(veq(r:tolist(),{{1,1,1},{1,1,0}}),'power values 225')
end
do -- power 226
 local a=np.array({{5},{5}},np.uint64)
 local b=np.array({{63,127,63}},np.uint64)
 local r=np.power(a,b)
 assert(r.dtype=='uint64','power dtype 226 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 226')
 assert(veq(r:tolist(),{{12656518236192088013,14813217252294750925,12656518236192088013},{12656518236192088013,14813217252294750925,12656518236192088013}}),'power values 226')
end
do -- power 227
 local a=np.array({{1,0,63},{2,31,1}},np.uint16)
 local b=np.array({{5,31,3}},np.uint64)
 local r=np.power(a,b)
 assert(r.dtype=='uint64','power dtype 227 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 227')
 assert(veq(r:tolist(),{{1,0,250047},{32,13804728411566915551,1}}),'power values 227')
end
do -- power 228
 local a=np.array({{-9},{1}},np.int32)
 local b=np.array({{0.5,1.0,2.0}},np.float32)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 228 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 228')
 assert(veq(r:tolist(),{{(0/0),-9.0,81.0},{1.0,1.0,1.0}}),'power values 228')
end
do -- power 229
 local a=np.array({{true},{false}},np.bool)
 local b=np.array({{31,3,0}},np.uint8)
 local r=np.power(a,b)
 assert(r.dtype=='uint8','power dtype 229 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 229')
 assert(veq(r:tolist(),{{1,1,1},{0,0,1}}),'power values 229')
end
do -- power 230
 local a=np.array({{2,3,2},{1,7,7}},np.uint8)
 local b=np.array({{1,1,1}},np.int8)
 local r=np.power(a,b)
 assert(r.dtype=='int16','power dtype 230 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 230')
 assert(veq(r:tolist(),{{2,3,2},{1,7,7}}),'power values 230')
end
do -- power 231
 local a=np.array({127,5,63,63,5},np.uint32)
 local b=np.array({0.0,0.0,0.0,1.0,3.5},np.float16)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 231 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 231')
 assert(veq(r:tolist(),{1.0,1.0,1.0,63.0,279.5084971874737}),'power values 231')
end
do -- power 232
 local a=np.array({{0.0,0.5,0.0},{-1.0,-1.5,-3.0}},np.float64)
 local b=np.array({{3,0,4}},np.int8)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 232 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 232')
 assert(veq(r:tolist(),{{0.0,1.0,0.0},{-1.0,1.0,81.0}}),'power values 232')
end
do -- power 233
 local a=np.array({{2},{127}},np.uint8)
 local b=np.array({{5,7,2}},np.uint16)
 local r=np.power(a,b)
 assert(r.dtype=='uint16','power dtype 233 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 233')
 assert(veq(r:tolist(),{{32,128,4},{33407,50047,16129}}),'power values 233')
end
do -- power 234
 local a=np.array({{false},{false}},np.bool)
 local b=np.array({{false,true,true}},np.bool)
 local r=np.power(a,b)
 assert(r.dtype=='int8','power dtype 234 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 234')
 assert(veq(r:tolist(),{{1,0,0},{1,0,0}}),'power values 234')
end
do -- power 235
 local a=np.array({-9.5,2.0,0.0,0.0,2.0},np.float16)
 local b=np.array({0,5,3,4,0},np.int64)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 235 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 235')
 assert(veq(r:tolist(),{1.0,32.0,0.0,0.0,1.0}),'power values 235')
end
do -- power 236
 local a=np.array({2.0,1.0,9.0,3.5,3.5},np.float32)
 local b=np.array({-1.0,0.5,3.5,-0.0,-3.0},np.float64)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 236 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 236')
 assert(veq(r:tolist(),{0.5,1.0,2187.0,1.0,0.023323615160349854}),'power values 236')
end
do -- power 237
 local a=np.array({{true},{false}},np.bool)
 local b=np.array({{2,0,0}},np.int16)
 local r=np.power(a,b)
 assert(r.dtype=='int16','power dtype 237 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 237')
 assert(veq(r:tolist(),{{1,1,1},{0,1,1}}),'power values 237')
end
do -- power 238
 local a=np.array({{30,3,1},{7,1,0}},np.int8)
 local b=np.array({15,7,1},np.uint32)
 local r=np.power(a,b)
 assert(r.dtype=='int64','power dtype 238 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 238')
 assert(veq(r:tolist(),{{-2659889346031157248,2187,1},{4747561509943,1,0}}),'power values 238')
end
do -- power 239
 local a=np.array({{0,2,-9},{0,2,15}},np.int8)
 local b=np.array({{0,2,3}},np.int32)
 local r=np.power(a,b)
 assert(r.dtype=='int32','power dtype 239 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 239')
 assert(veq(r:tolist(),{{1,4,-729},{1,4,3375}}),'power values 239')
end
do -- power 240
 local a=np.array({0,-1,-9,-9,15},np.int64)
 local b=np.array({-1.5,0.5,0.5,-1.0,0.5},np.float32)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 240 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 240')
 assert(veq(r:tolist(),{math.huge,(0/0),(0/0),-0.1111111111111111,3.872983346207417}),'power values 240')
end
do -- power 241
 local a=np.array({{7,-1,7},{-1,2,30}},np.int8)
 local b=np.array({-3.0,0.5,3.5},np.float32)
 local r=np.power(a,b)
 assert(r.dtype=='float32','power dtype 241 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 241')
 assert(veq(r:tolist(),{{0.0029154520016163588,(0/0),907.49267578125},{-1.0,1.4142135381698608,147885.09375}}),'power values 241')
end
do -- power 242
 local a=np.array({{5,5,5},{2,127,63}},np.uint32)
 local b=np.array({15,1,7},np.uint32)
 local r=np.power(a,b)
 assert(r.dtype=='uint32','power dtype 242 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 242')
 assert(veq(r:tolist(),{{452807053,5,78125},{32768,127,495628735}}),'power values 242')
end
do -- power 243
 local a=np.array({{0,1,7},{15,7,-3}},np.int16)
 local b=np.array({{2,5,3}},np.int16)
 local r=np.power(a,b)
 assert(r.dtype=='int16','power dtype 243 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 243')
 assert(veq(r:tolist(),{{0,1,343},{225,16807,-27}}),'power values 243')
end
do -- power 244
 local a=np.array({{-3.0,0.0,1.0},{9.0,1.0,0.5}},np.float16)
 local b=np.array({15,15,2},np.uint8)
 local r=np.power(a,b)
 assert(r.dtype=='float16','power dtype 244 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 244')
 assert(veq(r:tolist(),{{-math.huge,0.0,1.0},{math.huge,1.0,0.25}}),'power values 244')
end
do -- power 245
 local a=np.array({{-3},{-31}},np.int8)
 local b=np.array({{15,2,0}},np.uint32)
 local r=np.power(a,b)
 assert(r.dtype=='int64','power dtype 245 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 245')
 assert(veq(r:tolist(),{{-14348907,9,1},{-1003530086136274399,961,1}}),'power values 245')
end
do -- power 246
 local a=np.array({{2},{2}},np.uint8)
 local b=np.array({{9.0,0.0,-1.0}},np.float16)
 local r=np.power(a,b)
 assert(r.dtype=='float16','power dtype 246 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 246')
 assert(veq(r:tolist(),{{512.0,1.0,0.5},{512.0,1.0,0.5}}),'power values 246')
end
do -- power 247
 local a=np.array({{-1.5,-1.0,9.0},{3.5,-3.0,0.0}},np.float64)
 local b=np.array({{0.0,1.0,-1.0}},np.float32)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 247 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 247')
 assert(veq(r:tolist(),{{1.0,-1.0,0.1111111111111111},{1.0,-3.0,math.huge}}),'power values 247')
end
do -- power 248
 local a=np.array({{1,7,-3},{-3,1,7}},np.int8)
 local b=np.array({{5,2,0}},np.uint16)
 local r=np.power(a,b)
 assert(r.dtype=='int32','power dtype 248 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 248')
 assert(veq(r:tolist(),{{1,49,1},{-243,1,1}}),'power values 248')
end
do -- power 249
 local a=np.array({{-0.0,1.0,-1.0},{-0.0,9.0,0.5}},np.float16)
 local b=np.array({{-9.5,2.0,3.5}},np.float32)
 local r=np.power(a,b)
 assert(r.dtype=='float32','power dtype 249 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 249')
 assert(veq(r:tolist(),{{math.huge,1.0,(0/0)},{math.huge,81.0,0.0883883461356163}}),'power values 249')
end
do -- power 250
 local a=np.array({0.0,-0.0,3.5,-0.0,-0.0},np.float32)
 local b=np.array({1,2,15,31,0},np.uint64)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 250 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 250')
 assert(veq(r:tolist(),{0.0,0.0,144884079.28292847,-0.0,1.0}),'power values 250')
end
do -- power 251
 local a=np.array({15,63,127,2,15},np.uint64)
 local b=np.array({1,3,1,5,3},np.int64)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 251 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 251')
 assert(veq(r:tolist(),{15.0,250047.0,127.0,32.0,3375.0}),'power values 251')
end
do -- power 252
 local a=np.array({{1,31,1},{7,0,63}},np.uint8)
 local b=np.array({{127,3,3}},np.uint16)
 local r=np.power(a,b)
 assert(r.dtype=='uint16','power dtype 252 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 252')
 assert(veq(r:tolist(),{{1,29791,1},{8631,0,53439}}),'power values 252')
end
do -- power 253
 local a=np.array({{15,15,1},{30,-31,0}},np.int32)
 local b=np.array({{7,63,1}},np.uint16)
 local r=np.power(a,b)
 assert(r.dtype=='int32','power dtype 253 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 253')
 assert(veq(r:tolist(),{{170859375,-1194765585,1},{395163520,-2120287199,0}}),'power values 253')
end
do -- power 254
 local a=np.array({{-9,-9,-3},{0,-3,0}},np.int32)
 local b=np.array({7,15,127},np.uint8)
 local r=np.power(a,b)
 assert(r.dtype=='int32','power dtype 254 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 254')
 assert(veq(r:tolist(),{{-4782969,1010140999,2088621909},{0,-14348907,0}}),'power values 254')
end
do -- power 255
 local a=np.array({5,127,7,31,3},np.uint32)
 local b=np.array({9.0,9.0,-0.0,-9.5,-1.0},np.float64)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 255 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 255')
 assert(veq(r:tolist(),{1953125.0,8.594754748609398e+18,1.0,6.793035881350007e-15,0.3333333333333333}),'power values 255')
end
do -- power 256
 local a=np.array({63,7,3,1,0},np.uint64)
 local b=np.array({3,63,0,3,127},np.uint64)
 local r=np.power(a,b)
 assert(r.dtype=='uint64','power dtype 256 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 256')
 assert(veq(r:tolist(),{250047,2898552624600762295,1,1,0}),'power values 256')
end
do -- power 257
 local a=np.array({{-1.0,-9.5,2.0},{0.0,0.5,9.0}},np.float32)
 local b=np.array({{15,127,1}},np.uint32)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 257 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 257')
 assert(veq(r:tolist(),{{-1.0,-1.48216949845813e+124,2.0},{0.0,5.877471754111438e-39,9.0}}),'power values 257')
end
do -- power 258
 local a=np.array({-3.0,-0.0,-0.0,-1.5,-3.0},np.float16)
 local b=np.array({4,5,3,3,3},np.int32)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 258 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 258')
 assert(veq(r:tolist(),{81.0,-0.0,-0.0,-3.375,-27.0}),'power values 258')
end
do -- power 259
 local a=np.array({{7,15,-31},{-1,15,-1}},np.int16)
 local b=np.array({{15,0,31}},np.uint8)
 local r=np.power(a,b)
 assert(r.dtype=='int16','power dtype 259 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 259')
 assert(veq(r:tolist(),{{-23497,1,-16351},{-1,1,-1}}),'power values 259')
end
do -- power 260
 local a=np.array({{true,true,false},{false,true,false}},np.bool)
 local b=np.array({-1.0,0.5,2.0},np.float32)
 local r=np.power(a,b)
 assert(r.dtype=='float32','power dtype 260 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 260')
 assert(veq(r:tolist(),{{1.0,1.0,0.0},{math.huge,1.0,0.0}}),'power values 260')
end
do -- power 261
 local a=np.array({{0},{7}},np.int32)
 local b=np.array({{7,7,15}},np.uint32)
 local r=np.power(a,b)
 assert(r.dtype=='int64','power dtype 261 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 261')
 assert(veq(r:tolist(),{{0,0,0},{823543,823543,4747561509943}}),'power values 261')
end
do -- power 262
 local a=np.array({{1},{-31}},np.int16)
 local b=np.array({{1,31,63}},np.uint8)
 local r=np.power(a,b)
 assert(r.dtype=='int16','power dtype 262 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 262')
 assert(veq(r:tolist(),{{1,1,1},{-31,-16351,-991}}),'power values 262')
end
do -- power 263
 local a=np.array({{false},{false}},np.bool)
 local b=np.array({{true,true,false}},np.bool)
 local r=np.power(a,b)
 assert(r.dtype=='int8','power dtype 263 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 263')
 assert(veq(r:tolist(),{{0,0,1},{0,0,1}}),'power values 263')
end
do -- power 264
 local a=np.array({31,0,5,2,63},np.uint64)
 local b=np.array({127,3,127,63,0},np.uint32)
 local r=np.power(a,b)
 assert(r.dtype=='uint64','power dtype 264 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 264')
 assert(veq(r:tolist(),{8862888976073264095,0,14813217252294750925,9223372036854775808,1}),'power values 264')
end
do -- power 265
 local a=np.array({{0.0,3.5,-1.0},{-0.0,9.0,1.0}},np.float16)
 local b=np.array({{0,7,63}},np.uint32)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 265 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 265')
 assert(veq(r:tolist(),{{1.0,6433.9296875,-1.0},{1.0,4782969.0,1.0}}),'power values 265')
end
do -- power 266
 local a=np.array({{15},{2}},np.uint16)
 local b=np.array({{3.5,9.0,-0.0}},np.float16)
 local r=np.power(a,b)
 assert(r.dtype=='float32','power dtype 266 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 266')
 assert(veq(r:tolist(),{{13071.318359375,38443360256.0,1.0},{11.313708305358887,512.0,1.0}}),'power values 266')
end
do -- power 267
 local a=np.array({{7,7,63},{127,3,15}},np.uint16)
 local b=np.array({2,3,2},np.uint8)
 local r=np.power(a,b)
 assert(r.dtype=='uint16','power dtype 267 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 267')
 assert(veq(r:tolist(),{{49,343,3969},{16129,27,225}}),'power values 267')
end
do -- power 268
 local a=np.array({{-3.0,2.0,1.0},{3.5,2.0,0.0}},np.float64)
 local b=np.array({{5,0,4}},np.int64)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 268 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 268')
 assert(veq(r:tolist(),{{-243.0,1.0,1.0},{525.21875,1.0,0.0}}),'power values 268')
end
do -- power 269
 local a=np.array({7,63,7,7,127},np.uint8)
 local b=np.array({5,127,3,127,7},np.uint64)
 local r=np.power(a,b)
 assert(r.dtype=='uint64','power dtype 269 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 269')
 assert(veq(r:tolist(),{16807,15680735152236400575,343,10627139554740937143,532875860165503}),'power values 269')
end
do -- power 270
 local a=np.array({-1.5,3.5,0.5,-1.5,-9.5},np.float16)
 local b=np.array({0,2,5,1,0},np.int8)
 local r=np.power(a,b)
 assert(r.dtype=='float16','power dtype 270 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 270')
 assert(veq(r:tolist(),{1.0,12.25,0.03125,-1.5,1.0}),'power values 270')
end
do -- power 271
 local a=np.array({{0,-31,3},{-3,1,2}},np.int32)
 local b=np.array({{5,3,5}},np.int8)
 local r=np.power(a,b)
 assert(r.dtype=='int32','power dtype 271 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 271')
 assert(veq(r:tolist(),{{0,-29791,243},{-243,1,32}}),'power values 271')
end
do -- power 272
 local a=np.array({{3.5},{3.5}},np.float16)
 local b=np.array({{0,127,2}},np.uint16)
 local r=np.power(a,b)
 assert(r.dtype=='float32','power dtype 272 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 272')
 assert(veq(r:tolist(),{{1.0,math.huge,12.25},{1.0,math.huge,12.25}}),'power values 272')
end
do -- power 273
 local a=np.array({{7,5,5},{1,31,15}},np.uint8)
 local b=np.array({5,0,0},np.int32)
 local r=np.power(a,b)
 assert(r.dtype=='int32','power dtype 273 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 273')
 assert(veq(r:tolist(),{{16807,1,1},{1,1,1}}),'power values 273')
end
do -- power 274
 local a=np.array({{1,3,-31},{0,30,3}},np.int32)
 local b=np.array({-1.0,-3.0,-9.5},np.float16)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 274 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 274')
 assert(veq(r:tolist(),{{1.0,0.037037037037037035,(0/0)},{math.huge,3.7037037037037037e-05,2.9332432514841524e-05}}),'power values 274')
end
do -- power 275
 local a=np.array({-1.0,3.5,9.0,-1.0,-9.5},np.float32)
 local b=np.array({1,5,3,2,3},np.int8)
 local r=np.power(a,b)
 assert(r.dtype=='float32','power dtype 275 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 275')
 assert(veq(r:tolist(),{-1.0,525.21875,729.0,1.0,-857.375}),'power values 275')
end
do -- power 276
 local a=np.array({{127,63,2},{5,31,15}},np.uint32)
 local b=np.array({-3.0,-3.0,1.0},np.float64)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 276 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 276')
 assert(veq(r:tolist(),{{4.881899527578583e-07,3.999248141349426e-06,2.0},{0.008,3.3567184720217515e-05,15.0}}),'power values 276')
end
do -- power 277
 local a=np.array({{2,0,1},{63,1,63}},np.uint64)
 local b=np.array({{0,2,1}},np.int16)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 277 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 277')
 assert(veq(r:tolist(),{{1.0,0.0,1.0},{1.0,1.0,63.0}}),'power values 277')
end
do -- power 278
 local a=np.array({{15,3,-1},{3,1,-1}},np.int32)
 local b=np.array({{3.5,-0.0,1.0}},np.float16)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 278 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 278')
 assert(veq(r:tolist(),{{13071.318793450031,1.0,-1.0},{46.76537180435969,1.0,-1.0}}),'power values 278')
end
do -- power 279
 local a=np.array({-1.5,3.5,2.0,-9.5,3.5},np.float32)
 local b=np.array({true,true,true,true,false},np.bool)
 local r=np.power(a,b)
 assert(r.dtype=='float32','power dtype 279 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 279')
 assert(veq(r:tolist(),{-1.5,3.5,2.0,-9.5,1.0}),'power values 279')
end
do -- power 280
 local a=np.array({false,false,true,true,true},np.bool)
 local b=np.array({0.5,1.0,3.5,3.5,-1.5},np.float32)
 local r=np.power(a,b)
 assert(r.dtype=='float32','power dtype 280 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 280')
 assert(veq(r:tolist(),{0.0,0.0,1.0,1.0,1.0}),'power values 280')
end
do -- power 281
 local a=np.array({{0.0,0.0,3.5},{2.0,1.0,-9.5}},np.float64)
 local b=np.array({{1,5,1}},np.int8)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 281 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 281')
 assert(veq(r:tolist(),{{0.0,0.0,3.5},{2.0,1.0,-9.5}}),'power values 281')
end
do -- power 282
 local a=np.array({{-9.5},{0.5}},np.float16)
 local b=np.array({{-1.0,-9.5,3.5}},np.float16)
 local r=np.power(a,b)
 assert(r.dtype=='float16','power dtype 282 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 282')
 assert(veq(r:tolist(),{{-0.10528564453125,(0/0),(0/0)},{2.0,724.0,0.08837890625}}),'power values 282')
end
do -- power 283
 local a=np.array({{0.0},{-0.0}},np.float64)
 local b=np.array({{1,15,3}},np.uint8)
 local r=np.power(a,b)
 assert(r.dtype=='float64','power dtype 283 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'power shape 283')
 assert(veq(r:tolist(),{{0.0,0.0,0.0},{-0.0,-0.0,-0.0}}),'power values 283')
end
do -- power 284
 local a=np.array({63,5,5,127,3},np.uint8)
 local b=np.array({4,5,2,0,2},np.int64)
 local r=np.power(a,b)
 assert(r.dtype=='int64','power dtype 284 '..r.dtype)
 assert(seqeq(r.shape,{5}),'power shape 284')
 assert(veq(r:tolist(),{15752961,3125,25,1,9}),'power values 284')
end
do -- fmax 285
 local a=np.array({{-3.0},{9.0}},np.float64)
 local b=np.array({{15,3,0}},np.uint64)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 285 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 285')
 assert(veq(r:tolist(),{{15.0,3.0,0.0},{15.0,9.0,9.0}}),'fmax values 285')
end
do -- fmax 286
 local a=np.array({{2,-31,30},{-3,3,30}},np.int16)
 local b=np.array({15,31,0},np.uint64)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 286 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 286')
 assert(veq(r:tolist(),{{15.0,31.0,30.0},{15.0,31.0,30.0}}),'fmax values 286')
end
do -- fmax 287
 local a=np.array({{-9.5,9.0,-3.0},{9.0,math.huge,-1.0}},np.float64)
 local b=np.array({{3,63,7}},np.uint8)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 287 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 287')
 assert(veq(r:tolist(),{{3.0,63.0,7.0},{9.0,math.huge,7.0}}),'fmax values 287')
end
do -- fmax 288
 local a=np.array({{15},{2}},np.uint32)
 local b=np.array({{2,3,-1}},np.int32)
 local r=np.fmax(a,b)
 assert(r.dtype=='int64','fmax dtype 288 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 288')
 assert(veq(r:tolist(),{{15,15,15},{2,3,2}}),'fmax values 288')
end
do -- fmax 289
 local a=np.array({{127,7,5},{127,0,0}},np.uint16)
 local b=np.array({31,127,1},np.uint16)
 local r=np.fmax(a,b)
 assert(r.dtype=='uint16','fmax dtype 289 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 289')
 assert(veq(r:tolist(),{{127,127,5},{127,127,1}}),'fmax values 289')
end
do -- fmax 290
 local a=np.array({{7,15,7},{-31,-9,-3}},np.int64)
 local b=np.array({2,7,5},np.uint16)
 local r=np.fmax(a,b)
 assert(r.dtype=='int64','fmax dtype 290 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 290')
 assert(veq(r:tolist(),{{7,15,7},{2,7,5}}),'fmax values 290')
end
do -- fmax 291
 local a=np.array({{15},{3}},np.uint32)
 local b=np.array({{-31,-9,-1}},np.int32)
 local r=np.fmax(a,b)
 assert(r.dtype=='int64','fmax dtype 291 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 291')
 assert(veq(r:tolist(),{{15,15,15},{3,3,3}}),'fmax values 291')
end
do -- fmax 292
 local a=np.array({{-1,-3,2},{-3,3,2}},np.int64)
 local b=np.array({{7,30,0}},np.int16)
 local r=np.fmax(a,b)
 assert(r.dtype=='int64','fmax dtype 292 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 292')
 assert(veq(r:tolist(),{{7,30,2},{7,30,2}}),'fmax values 292')
end
do -- fmax 293
 local a=np.array({{0,30,15},{0,15,-31}},np.int32)
 local b=np.array({{2.0,-1.5,-9.5}},np.float64)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 293 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 293')
 assert(veq(r:tolist(),{{2.0,30.0,15.0},{2.0,15.0,-9.5}}),'fmax values 293')
end
do -- fmax 294
 local a=np.array({{127,7,2},{5,0,63}},np.uint16)
 local b=np.array({{-1.0,-1.0,-3.0}},np.float32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float32','fmax dtype 294 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 294')
 assert(veq(r:tolist(),{{127.0,7.0,2.0},{5.0,0.0,63.0}}),'fmax values 294')
end
do -- fmax 295
 local a=np.array({-1,-31,15,-31,-3},np.int8)
 local b=np.array({1,0,15,7,3},np.uint16)
 local r=np.fmax(a,b)
 assert(r.dtype=='int32','fmax dtype 295 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 295')
 assert(veq(r:tolist(),{1,0,15,7,3}),'fmax values 295')
end
do -- fmax 296
 local a=np.array({{31,2,3},{0,127,7}},np.uint8)
 local b=np.array({-1,-3,0},np.int16)
 local r=np.fmax(a,b)
 assert(r.dtype=='int16','fmax dtype 296 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 296')
 assert(veq(r:tolist(),{{31,2,3},{0,127,7}}),'fmax values 296')
end
do -- fmax 297
 local a=np.array({{-3.0,0.0,9.0},{-1.0,math.huge,0.5}},np.float64)
 local b=np.array({{31,63,15}},np.uint32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 297 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 297')
 assert(veq(r:tolist(),{{31.0,63.0,15.0},{31.0,math.huge,15.0}}),'fmax values 297')
end
do -- fmax 298
 local a=np.array({{9.0},{2.0}},np.float32)
 local b=np.array({{5,1,0}},np.uint16)
 local r=np.fmax(a,b)
 assert(r.dtype=='float32','fmax dtype 298 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 298')
 assert(veq(r:tolist(),{{9.0,9.0,9.0},{5.0,2.0,2.0}}),'fmax values 298')
end
do -- fmax 299
 local a=np.array({{true,false,false},{true,false,false}},np.bool)
 local b=np.array({{7,30,-1}},np.int16)
 local r=np.fmax(a,b)
 assert(r.dtype=='int16','fmax dtype 299 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 299')
 assert(veq(r:tolist(),{{7,30,0},{7,30,0}}),'fmax values 299')
end
do -- fmax 300
 local a=np.array({{-9.5},{3.5}},np.float16)
 local b=np.array({{1,3,-3}},np.int16)
 local r=np.fmax(a,b)
 assert(r.dtype=='float32','fmax dtype 300 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 300')
 assert(veq(r:tolist(),{{1.0,3.0,-3.0},{3.5,3.5,3.5}}),'fmax values 300')
end
do -- fmax 301
 local a=np.array({-3.0,(0/0),-3.0,0.5,-0.0},np.float16)
 local b=np.array({-9.5,-0.0,0.0,0.5,-0.0},np.float64)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 301 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 301')
 assert(veq(r:tolist(),{-3.0,-0.0,0.0,0.5,-0.0}),'fmax values 301')
end
do -- fmax 302
 local a=np.array({{1,7,30},{-3,30,2}},np.int64)
 local b=np.array({{2,30,-1}},np.int64)
 local r=np.fmax(a,b)
 assert(r.dtype=='int64','fmax dtype 302 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 302')
 assert(veq(r:tolist(),{{2,30,30},{2,30,2}}),'fmax values 302')
end
do -- fmax 303
 local a=np.array({{3,63,1},{31,7,5}},np.uint32)
 local b=np.array({{3,2,-9}},np.int32)
 local r=np.fmax(a,b)
 assert(r.dtype=='int64','fmax dtype 303 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 303')
 assert(veq(r:tolist(),{{3,63,1},{31,7,5}}),'fmax values 303')
end
do -- fmax 304
 local a=np.array({{1,-31,7},{30,-3,-31}},np.int64)
 local b=np.array({0.0,0.5,9.0},np.float64)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 304 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 304')
 assert(veq(r:tolist(),{{1.0,0.5,9.0},{30.0,0.5,9.0}}),'fmax values 304')
end
do -- fmax 305
 local a=np.array({-3,3,15,7,-31},np.int16)
 local b=np.array({7,1,1,2,63},np.uint8)
 local r=np.fmax(a,b)
 assert(r.dtype=='int16','fmax dtype 305 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 305')
 assert(veq(r:tolist(),{7,3,15,7,63}),'fmax values 305')
end
do -- fmax 306
 local a=np.array({{0,7,3},{0,15,0}},np.uint64)
 local b=np.array({{true,false,false}},np.bool)
 local r=np.fmax(a,b)
 assert(r.dtype=='uint64','fmax dtype 306 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 306')
 assert(veq(r:tolist(),{{1,7,3},{1,15,0}}),'fmax values 306')
end
do -- fmax 307
 local a=np.array({{2.0,-3.0,0.5},{0.5,2.0,2.0}},np.float64)
 local b=np.array({-1,-3,-1},np.int32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 307 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 307')
 assert(veq(r:tolist(),{{2.0,-3.0,0.5},{0.5,2.0,2.0}}),'fmax values 307')
end
do -- fmax 308
 local a=np.array({-1.0,0.0,0.0,2.0,2.0},np.float64)
 local b=np.array({-3,-3,2,-1,-3},np.int8)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 308 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 308')
 assert(veq(r:tolist(),{-1.0,0.0,2.0,2.0,2.0}),'fmax values 308')
end
do -- fmax 309
 local a=np.array({{1,0,1},{-31,15,-31}},np.int16)
 local b=np.array({0,1,1},np.int8)
 local r=np.fmax(a,b)
 assert(r.dtype=='int16','fmax dtype 309 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 309')
 assert(veq(r:tolist(),{{1,1,1},{0,15,1}}),'fmax values 309')
end
do -- fmax 310
 local a=np.array({{true},{false}},np.bool)
 local b=np.array({{false,false,true}},np.bool)
 local r=np.fmax(a,b)
 assert(r.dtype=='bool','fmax dtype 310 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 310')
 assert(veq(r:tolist(),{{true,true,true},{false,false,true}}),'fmax values 310')
end
do -- fmax 311
 local a=np.array({{5,0,5},{15,31,3}},np.uint16)
 local b=np.array({2,1,-31},np.int64)
 local r=np.fmax(a,b)
 assert(r.dtype=='int64','fmax dtype 311 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 311')
 assert(veq(r:tolist(),{{5,1,5},{15,31,3}}),'fmax values 311')
end
do -- fmax 312
 local a=np.array({30,0,-31,0,7},np.int16)
 local b=np.array({-1.5,-1.0,0.5,-1.0,(0/0)},np.float64)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 312 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 312')
 assert(veq(r:tolist(),{30.0,0.0,0.5,0.0,7.0}),'fmax values 312')
end
do -- fmax 313
 local a=np.array({30,-3,1,1,3},np.int64)
 local b=np.array({15,7,-9,15,-3},np.int8)
 local r=np.fmax(a,b)
 assert(r.dtype=='int64','fmax dtype 313 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 313')
 assert(veq(r:tolist(),{30,7,1,15,3}),'fmax values 313')
end
do -- fmax 314
 local a=np.array({7,7,2,3,15},np.int8)
 local b=np.array({3,63,7,15,2},np.uint32)
 local r=np.fmax(a,b)
 assert(r.dtype=='int64','fmax dtype 314 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 314')
 assert(veq(r:tolist(),{7,63,7,15,15}),'fmax values 314')
end
do -- fmax 315
 local a=np.array({{30,15,3},{15,7,7}},np.int64)
 local b=np.array({false,false,false},np.bool)
 local r=np.fmax(a,b)
 assert(r.dtype=='int64','fmax dtype 315 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 315')
 assert(veq(r:tolist(),{{30,15,3},{15,7,7}}),'fmax values 315')
end
do -- fmax 316
 local a=np.array({{2,2,1},{0,2,2}},np.uint64)
 local b=np.array({false,true,false},np.bool)
 local r=np.fmax(a,b)
 assert(r.dtype=='uint64','fmax dtype 316 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 316')
 assert(veq(r:tolist(),{{2,2,1},{0,2,2}}),'fmax values 316')
end
do -- fmax 317
 local a=np.array({-1,7,-3,-9,30},np.int32)
 local b=np.array({true,false,true,false,false},np.bool)
 local r=np.fmax(a,b)
 assert(r.dtype=='int32','fmax dtype 317 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 317')
 assert(veq(r:tolist(),{1,7,1,0,30}),'fmax values 317')
end
do -- fmax 318
 local a=np.array({{63,2,63},{0,1,3}},np.uint32)
 local b=np.array({{-0.0,3.5,-1.0}},np.float32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 318 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 318')
 assert(veq(r:tolist(),{{63.0,3.5,63.0},{-0.0,3.5,3.0}}),'fmax values 318')
end
do -- fmax 319
 local a=np.array({0,63,15,31,63},np.uint64)
 local b=np.array({0.0,1.0,-3.0,-0.0,(0/0)},np.float16)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 319 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 319')
 assert(veq(r:tolist(),{0.0,63.0,15.0,31.0,63.0}),'fmax values 319')
end
do -- fmax 320
 local a=np.array({31,31,127,2,1},np.uint32)
 local b=np.array({9.0,-9.5,-math.huge,(0/0),0.5},np.float32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 320 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 320')
 assert(veq(r:tolist(),{31.0,31.0,127.0,2.0,1.0}),'fmax values 320')
end
do -- fmax 321
 local a=np.array({63,0,31,31,1},np.uint16)
 local b=np.array({30,2,-3,30,15},np.int8)
 local r=np.fmax(a,b)
 assert(r.dtype=='int32','fmax dtype 321 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 321')
 assert(veq(r:tolist(),{63,2,31,31,15}),'fmax values 321')
end
do -- fmax 322
 local a=np.array({31,7,2,2,2},np.uint64)
 local b=np.array({7,2,3,15,15},np.uint8)
 local r=np.fmax(a,b)
 assert(r.dtype=='uint64','fmax dtype 322 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 322')
 assert(veq(r:tolist(),{31,7,3,15,15}),'fmax values 322')
end
do -- fmax 323
 local a=np.array({{31,31,3},{31,0,127}},np.uint16)
 local b=np.array({0.0,1.0,(0/0)},np.float64)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 323 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 323')
 assert(veq(r:tolist(),{{31.0,31.0,3.0},{31.0,1.0,127.0}}),'fmax values 323')
end
do -- fmax 324
 local a=np.array({{-3,0,-31},{-3,-9,0}},np.int64)
 local b=np.array({1,31,127},np.uint64)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 324 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 324')
 assert(veq(r:tolist(),{{1.0,31.0,127.0},{1.0,31.0,127.0}}),'fmax values 324')
end
do -- fmax 325
 local a=np.array({127,5,127,127,0},np.uint32)
 local b=np.array({-0.0,2.0,-math.huge,9.0,0.5},np.float64)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 325 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 325')
 assert(veq(r:tolist(),{127.0,5.0,127.0,127.0,0.5}),'fmax values 325')
end
do -- fmax 326
 local a=np.array({15,1,-9,1,2},np.int16)
 local b=np.array({false,true,true,false,false},np.bool)
 local r=np.fmax(a,b)
 assert(r.dtype=='int16','fmax dtype 326 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 326')
 assert(veq(r:tolist(),{15,1,1,1,2}),'fmax values 326')
end
do -- fmax 327
 local a=np.array({{0},{3}},np.uint8)
 local b=np.array({{false,false,false}},np.bool)
 local r=np.fmax(a,b)
 assert(r.dtype=='uint8','fmax dtype 327 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 327')
 assert(veq(r:tolist(),{{0,0,0},{3,3,3}}),'fmax values 327')
end
do -- fmax 328
 local a=np.array({{true,false,true},{true,false,false}},np.bool)
 local b=np.array({15,0,5},np.uint64)
 local r=np.fmax(a,b)
 assert(r.dtype=='uint64','fmax dtype 328 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 328')
 assert(veq(r:tolist(),{{15,0,5},{15,0,5}}),'fmax values 328')
end
do -- fmax 329
 local a=np.array({{false,true,false},{false,false,false}},np.bool)
 local b=np.array({{-3,0,7}},np.int64)
 local r=np.fmax(a,b)
 assert(r.dtype=='int64','fmax dtype 329 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 329')
 assert(veq(r:tolist(),{{0,1,7},{0,0,7}}),'fmax values 329')
end
do -- fmax 330
 local a=np.array({{2},{-3}},np.int32)
 local b=np.array({{1.0,0.5,1.0}},np.float32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 330 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 330')
 assert(veq(r:tolist(),{{2.0,2.0,2.0},{1.0,0.5,1.0}}),'fmax values 330')
end
do -- fmax 331
 local a=np.array({{(0/0),-3.0,-3.0},{9.0,-3.0,-9.5}},np.float32)
 local b=np.array({{-math.huge,-9.5,2.0}},np.float32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float32','fmax dtype 331 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 331')
 assert(veq(r:tolist(),{{-math.huge,-3.0,2.0},{9.0,-3.0,2.0}}),'fmax values 331')
end
do -- fmax 332
 local a=np.array({{-1,1,-1},{1,15,7}},np.int64)
 local b=np.array({5,3,127},np.uint32)
 local r=np.fmax(a,b)
 assert(r.dtype=='int64','fmax dtype 332 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 332')
 assert(veq(r:tolist(),{{5,3,127},{5,15,127}}),'fmax values 332')
end
do -- fmax 333
 local a=np.array({{7},{1}},np.uint8)
 local b=np.array({{15,2,-31}},np.int8)
 local r=np.fmax(a,b)
 assert(r.dtype=='int16','fmax dtype 333 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 333')
 assert(veq(r:tolist(),{{15,7,7},{15,2,1}}),'fmax values 333')
end
do -- fmax 334
 local a=np.array({-1.0,9.0,3.5,math.huge,math.huge},np.float32)
 local b=np.array({5,0,63,5,2},np.uint32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 334 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 334')
 assert(veq(r:tolist(),{5.0,9.0,63.0,math.huge,math.huge}),'fmax values 334')
end
do -- fmax 335
 local a=np.array({{7,3,7},{7,2,-9}},np.int64)
 local b=np.array({{-math.huge,0.0,-0.0}},np.float64)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 335 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 335')
 assert(veq(r:tolist(),{{7.0,3.0,7.0},{7.0,2.0,-0.0}}),'fmax values 335')
end
do -- fmax 336
 local a=np.array({{5},{31}},np.uint32)
 local b=np.array({{true,true,true}},np.bool)
 local r=np.fmax(a,b)
 assert(r.dtype=='uint32','fmax dtype 336 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 336')
 assert(veq(r:tolist(),{{5,5,5},{31,31,31}}),'fmax values 336')
end
do -- fmax 337
 local a=np.array({-9,-9,-1,2,15},np.int8)
 local b=np.array({1.0,-1.0,3.5,-1.5,-math.huge},np.float32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float32','fmax dtype 337 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 337')
 assert(veq(r:tolist(),{1.0,-1.0,3.5,2.0,15.0}),'fmax values 337')
end
do -- fmax 338
 local a=np.array({{3},{3}},np.uint64)
 local b=np.array({{0.0,math.huge,-1.5}},np.float64)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 338 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 338')
 assert(veq(r:tolist(),{{3.0,math.huge,3.0},{3.0,math.huge,3.0}}),'fmax values 338')
end
do -- fmax 339
 local a=np.array({0,0,2,2,-3},np.int8)
 local b=np.array({0,2,15,3,5},np.uint8)
 local r=np.fmax(a,b)
 assert(r.dtype=='int16','fmax dtype 339 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 339')
 assert(veq(r:tolist(),{0,2,15,3,5}),'fmax values 339')
end
do -- fmax 340
 local a=np.array({{63},{0}},np.uint64)
 local b=np.array({{-3,-3,-1}},np.int16)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 340 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 340')
 assert(veq(r:tolist(),{{63.0,63.0,63.0},{0.0,0.0,0.0}}),'fmax values 340')
end
do -- fmax 341
 local a=np.array({{7,7,31},{31,63,0}},np.uint16)
 local b=np.array({{math.huge,-0.0,-math.huge}},np.float32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float32','fmax dtype 341 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 341')
 assert(veq(r:tolist(),{{math.huge,7.0,31.0},{math.huge,63.0,0.0}}),'fmax values 341')
end
do -- fmax 342
 local a=np.array({{15},{7}},np.uint64)
 local b=np.array({{30,-9,1}},np.int32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 342 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 342')
 assert(veq(r:tolist(),{{30.0,15.0,15.0},{30.0,7.0,7.0}}),'fmax values 342')
end
do -- fmax 343
 local a=np.array({{5,3,3},{7,0,63}},np.uint16)
 local b=np.array({31,127,5},np.uint16)
 local r=np.fmax(a,b)
 assert(r.dtype=='uint16','fmax dtype 343 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 343')
 assert(veq(r:tolist(),{{31,127,5},{31,127,63}}),'fmax values 343')
end
do -- fmax 344
 local a=np.array({{2},{7}},np.int32)
 local b=np.array({{-3,-3,-9}},np.int32)
 local r=np.fmax(a,b)
 assert(r.dtype=='int32','fmax dtype 344 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 344')
 assert(veq(r:tolist(),{{2,2,2},{7,7,7}}),'fmax values 344')
end
do -- fmax 345
 local a=np.array({{1,127,2},{31,7,5}},np.uint8)
 local b=np.array({2,15,3},np.uint64)
 local r=np.fmax(a,b)
 assert(r.dtype=='uint64','fmax dtype 345 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 345')
 assert(veq(r:tolist(),{{2,127,3},{31,15,5}}),'fmax values 345')
end
do -- fmax 346
 local a=np.array({{true},{false}},np.bool)
 local b=np.array({{5,1,5}},np.uint16)
 local r=np.fmax(a,b)
 assert(r.dtype=='uint16','fmax dtype 346 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 346')
 assert(veq(r:tolist(),{{5,1,5},{5,1,5}}),'fmax values 346')
end
do -- fmax 347
 local a=np.array({127,63,1,0,7},np.uint8)
 local b=np.array({-math.huge,(0/0),math.huge,-9.5,1.0},np.float64)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 347 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 347')
 assert(veq(r:tolist(),{127.0,63.0,math.huge,0.0,7.0}),'fmax values 347')
end
do -- fmax 348
 local a=np.array({{1,-1,-31},{30,15,-9}},np.int32)
 local b=np.array({{63,2,0}},np.uint32)
 local r=np.fmax(a,b)
 assert(r.dtype=='int64','fmax dtype 348 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 348')
 assert(veq(r:tolist(),{{63,2,0},{63,15,0}}),'fmax values 348')
end
do -- fmax 349
 local a=np.array({0,3,15,5,2},np.uint64)
 local b=np.array({false,false,true,true,false},np.bool)
 local r=np.fmax(a,b)
 assert(r.dtype=='uint64','fmax dtype 349 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 349')
 assert(veq(r:tolist(),{0,3,15,5,2}),'fmax values 349')
end
do -- fmax 350
 local a=np.array({{1,3,127},{3,7,15}},np.uint64)
 local b=np.array({{-3,-9,-9}},np.int32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 350 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 350')
 assert(veq(r:tolist(),{{1.0,3.0,127.0},{3.0,7.0,15.0}}),'fmax values 350')
end
do -- fmax 351
 local a=np.array({0.0,9.0,1.0,0.0,-1.5},np.float64)
 local b=np.array({1,-9,7,-3,7},np.int32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 351 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 351')
 assert(veq(r:tolist(),{1.0,9.0,7.0,0.0,7.0}),'fmax values 351')
end
do -- fmax 352
 local a=np.array({false,false,true,false,false},np.bool)
 local b=np.array({63,15,15,15,5},np.uint16)
 local r=np.fmax(a,b)
 assert(r.dtype=='uint16','fmax dtype 352 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 352')
 assert(veq(r:tolist(),{63,15,15,15,5}),'fmax values 352')
end
do -- fmax 353
 local a=np.array({{127,127,7},{5,15,0}},np.uint16)
 local b=np.array({(0/0),9.0,2.0},np.float16)
 local r=np.fmax(a,b)
 assert(r.dtype=='float32','fmax dtype 353 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 353')
 assert(veq(r:tolist(),{{127.0,127.0,7.0},{5.0,15.0,2.0}}),'fmax values 353')
end
do -- fmax 354
 local a=np.array({{7,30,30},{1,-3,-3}},np.int8)
 local b=np.array({1,15,30},np.int32)
 local r=np.fmax(a,b)
 assert(r.dtype=='int32','fmax dtype 354 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 354')
 assert(veq(r:tolist(),{{7,30,30},{1,15,30}}),'fmax values 354')
end
do -- fmax 355
 local a=np.array({{false,false,false},{true,false,false}},np.bool)
 local b=np.array({0.0,-1.0,-3.0},np.float32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float32','fmax dtype 355 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 355')
 assert(veq(r:tolist(),{{0.0,0.0,0.0},{1.0,0.0,0.0}}),'fmax values 355')
end
do -- fmax 356
 local a=np.array({{5},{1}},np.uint8)
 local b=np.array({{63,2,3}},np.uint8)
 local r=np.fmax(a,b)
 assert(r.dtype=='uint8','fmax dtype 356 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 356')
 assert(veq(r:tolist(),{{63,5,5},{63,2,3}}),'fmax values 356')
end
do -- fmax 357
 local a=np.array({{15,1,7},{30,2,-1}},np.int16)
 local b=np.array({{(0/0),-3.0,-0.0}},np.float32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float32','fmax dtype 357 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 357')
 assert(veq(r:tolist(),{{15.0,1.0,7.0},{30.0,2.0,-0.0}}),'fmax values 357')
end
do -- fmax 358
 local a=np.array({{1,5,31},{7,31,127}},np.uint32)
 local b=np.array({{3,1,-31}},np.int32)
 local r=np.fmax(a,b)
 assert(r.dtype=='int64','fmax dtype 358 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 358')
 assert(veq(r:tolist(),{{3,5,31},{7,31,127}}),'fmax values 358')
end
do -- fmax 359
 local a=np.array({{3,7,127},{0,1,63}},np.uint32)
 local b=np.array({{3,1,0}},np.int8)
 local r=np.fmax(a,b)
 assert(r.dtype=='int64','fmax dtype 359 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 359')
 assert(veq(r:tolist(),{{3,7,127},{3,1,63}}),'fmax values 359')
end
do -- fmax 360
 local a=np.array({{31},{2}},np.uint16)
 local b=np.array({{2,1,0}},np.int16)
 local r=np.fmax(a,b)
 assert(r.dtype=='int32','fmax dtype 360 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 360')
 assert(veq(r:tolist(),{{31,31,31},{2,2,2}}),'fmax values 360')
end
do -- fmax 361
 local a=np.array({{0,2,-9},{-1,0,2}},np.int8)
 local b=np.array({{-1,2,30}},np.int8)
 local r=np.fmax(a,b)
 assert(r.dtype=='int8','fmax dtype 361 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 361')
 assert(veq(r:tolist(),{{0,2,30},{-1,2,30}}),'fmax values 361')
end
do -- fmax 362
 local a=np.array({{15,127,31},{31,31,0}},np.uint64)
 local b=np.array({{false,false,false}},np.bool)
 local r=np.fmax(a,b)
 assert(r.dtype=='uint64','fmax dtype 362 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 362')
 assert(veq(r:tolist(),{{15,127,31},{31,31,0}}),'fmax values 362')
end
do -- fmax 363
 local a=np.array({{15,3,7},{3,127,7}},np.uint32)
 local b=np.array({{-1.5,-0.0,-9.5}},np.float32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 363 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 363')
 assert(veq(r:tolist(),{{15.0,3.0,7.0},{3.0,127.0,7.0}}),'fmax values 363')
end
do -- fmax 364
 local a=np.array({{-1.0,1.0,-3.0},{-9.5,-0.0,-3.0}},np.float16)
 local b=np.array({3,127,63},np.uint32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 364 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 364')
 assert(veq(r:tolist(),{{3.0,127.0,63.0},{3.0,127.0,63.0}}),'fmax values 364')
end
do -- fmax 365
 local a=np.array({{2,15,-9},{3,3,-31}},np.int8)
 local b=np.array({7,-9,30},np.int32)
 local r=np.fmax(a,b)
 assert(r.dtype=='int32','fmax dtype 365 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 365')
 assert(veq(r:tolist(),{{7,15,30},{7,3,30}}),'fmax values 365')
end
do -- fmax 366
 local a=np.array({{2},{3}},np.uint64)
 local b=np.array({{-9,2,-9}},np.int16)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 366 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 366')
 assert(veq(r:tolist(),{{2.0,2.0,2.0},{3.0,3.0,3.0}}),'fmax values 366')
end
do -- fmax 367
 local a=np.array({{1,63,31},{2,15,31}},np.uint64)
 local b=np.array({true,true,true},np.bool)
 local r=np.fmax(a,b)
 assert(r.dtype=='uint64','fmax dtype 367 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 367')
 assert(veq(r:tolist(),{{1,63,31},{2,15,31}}),'fmax values 367')
end
do -- fmax 368
 local a=np.array({3.5,0.5,9.0,-0.0,-9.5},np.float32)
 local b=np.array({15,-31,3,-3,-3},np.int32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 368 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 368')
 assert(veq(r:tolist(),{15.0,0.5,9.0,-0.0,-3.0}),'fmax values 368')
end
do -- fmax 369
 local a=np.array({{-1},{2}},np.int16)
 local b=np.array({{1,0,31}},np.uint32)
 local r=np.fmax(a,b)
 assert(r.dtype=='int64','fmax dtype 369 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 369')
 assert(veq(r:tolist(),{{1,0,31},{2,2,31}}),'fmax values 369')
end
do -- fmax 370
 local a=np.array({{-31,3,1},{7,7,7}},np.int16)
 local b=np.array({{127,127,5}},np.uint8)
 local r=np.fmax(a,b)
 assert(r.dtype=='int16','fmax dtype 370 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 370')
 assert(veq(r:tolist(),{{127,127,5},{127,127,7}}),'fmax values 370')
end
do -- fmax 371
 local a=np.array({{true},{true}},np.bool)
 local b=np.array({{math.huge,-1.5,2.0}},np.float16)
 local r=np.fmax(a,b)
 assert(r.dtype=='float16','fmax dtype 371 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 371')
 assert(veq(r:tolist(),{{math.huge,1.0,2.0},{math.huge,1.0,2.0}}),'fmax values 371')
end
do -- fmax 372
 local a=np.array({{0.5,3.5,0.5},{0.5,9.0,(0/0)}},np.float16)
 local b=np.array({127,5,15},np.uint8)
 local r=np.fmax(a,b)
 assert(r.dtype=='float16','fmax dtype 372 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 372')
 assert(veq(r:tolist(),{{127.0,5.0,15.0},{127.0,9.0,15.0}}),'fmax values 372')
end
do -- fmax 373
 local a=np.array({{0,2,3},{7,3,1}},np.int8)
 local b=np.array({-3.0,-math.huge,1.0},np.float16)
 local r=np.fmax(a,b)
 assert(r.dtype=='float16','fmax dtype 373 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 373')
 assert(veq(r:tolist(),{{0.0,2.0,3.0},{7.0,3.0,1.0}}),'fmax values 373')
end
do -- fmax 374
 local a=np.array({{1},{30}},np.int8)
 local b=np.array({{-3.0,3.5,-0.0}},np.float64)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 374 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 374')
 assert(veq(r:tolist(),{{1.0,3.5,1.0},{30.0,30.0,30.0}}),'fmax values 374')
end
do -- fmax 375
 local a=np.array({30,30,0,7,30},np.int8)
 local b=np.array({63,0,15,0,5},np.uint64)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 375 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmax shape 375')
 assert(veq(r:tolist(),{63.0,30.0,15.0,7.0,30.0}),'fmax values 375')
end
do -- fmax 376
 local a=np.array({{-3.0},{-3.0}},np.float16)
 local b=np.array({{-math.huge,9.0,2.0}},np.float64)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 376 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 376')
 assert(veq(r:tolist(),{{-3.0,9.0,2.0},{-3.0,9.0,2.0}}),'fmax values 376')
end
do -- fmax 377
 local a=np.array({{7,15,2},{15,7,3}},np.uint32)
 local b=np.array({-1.0,math.huge,-math.huge},np.float16)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 377 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 377')
 assert(veq(r:tolist(),{{7.0,math.huge,2.0},{15.0,math.huge,3.0}}),'fmax values 377')
end
do -- fmax 378
 local a=np.array({{(0/0),2.0,-9.5},{-9.5,-3.0,-1.5}},np.float64)
 local b=np.array({{-9.5,-1.0,-9.5}},np.float32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','fmax dtype 378 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 378')
 assert(veq(r:tolist(),{{-9.5,2.0,-9.5},{-9.5,-1.0,-1.5}}),'fmax values 378')
end
do -- fmax 379
 local a=np.array({{3},{31}},np.uint16)
 local b=np.array({{-9,-9,-9}},np.int8)
 local r=np.fmax(a,b)
 assert(r.dtype=='int32','fmax dtype 379 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmax shape 379')
 assert(veq(r:tolist(),{{3,3,3},{31,31,31}}),'fmax values 379')
end
do -- fmin 380
 local a=np.array({{-9},{0}},np.int8)
 local b=np.array({{-3,30,0}},np.int16)
 local r=np.fmin(a,b)
 assert(r.dtype=='int16','fmin dtype 380 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 380')
 assert(veq(r:tolist(),{{-9,-9,-9},{-3,0,0}}),'fmin values 380')
end
do -- fmin 381
 local a=np.array({{-3,-9,1},{3,0,30}},np.int8)
 local b=np.array({7,30,3},np.int16)
 local r=np.fmin(a,b)
 assert(r.dtype=='int16','fmin dtype 381 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 381')
 assert(veq(r:tolist(),{{-3,-9,1},{3,0,3}}),'fmin values 381')
end
do -- fmin 382
 local a=np.array({9.0,-3.0,0.5,9.0,math.huge},np.float64)
 local b=np.array({-31,3,7,-1,2},np.int8)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 382 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmin shape 382')
 assert(veq(r:tolist(),{-31.0,-3.0,0.5,-1.0,2.0}),'fmin values 382')
end
do -- fmin 383
 local a=np.array({{false,true,false},{true,true,false}},np.bool)
 local b=np.array({0,-9,2},np.int64)
 local r=np.fmin(a,b)
 assert(r.dtype=='int64','fmin dtype 383 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 383')
 assert(veq(r:tolist(),{{0,-9,0},{0,-9,0}}),'fmin values 383')
end
do -- fmin 384
 local a=np.array({{3,2,-31},{1,1,15}},np.int32)
 local b=np.array({false,true,false},np.bool)
 local r=np.fmin(a,b)
 assert(r.dtype=='int32','fmin dtype 384 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 384')
 assert(veq(r:tolist(),{{0,1,-31},{0,1,0}}),'fmin values 384')
end
do -- fmin 385
 local a=np.array({{7,-9,-31},{-1,-31,3}},np.int16)
 local b=np.array({true,true,false},np.bool)
 local r=np.fmin(a,b)
 assert(r.dtype=='int16','fmin dtype 385 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 385')
 assert(veq(r:tolist(),{{1,-9,-31},{-1,-31,0}}),'fmin values 385')
end
do -- fmin 386
 local a=np.array({{1,-9,-3},{0,-1,-1}},np.int8)
 local b=np.array({math.huge,-3.0,9.0},np.float16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float16','fmin dtype 386 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 386')
 assert(veq(r:tolist(),{{1.0,-9.0,-3.0},{0.0,-3.0,-1.0}}),'fmin values 386')
end
do -- fmin 387
 local a=np.array({{31},{2}},np.uint64)
 local b=np.array({{30,3,2}},np.int8)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 387 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 387')
 assert(veq(r:tolist(),{{30.0,3.0,2.0},{2.0,2.0,2.0}}),'fmin values 387')
end
do -- fmin 388
 local a=np.array({{(0/0),3.5,-3.0},{-3.0,-9.5,1.0}},np.float32)
 local b=np.array({{7,1,0}},np.int64)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 388 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 388')
 assert(veq(r:tolist(),{{7.0,1.0,-3.0},{-3.0,-9.5,0.0}}),'fmin values 388')
end
do -- fmin 389
 local a=np.array({{30},{-9}},np.int8)
 local b=np.array({{2,-3,2}},np.int8)
 local r=np.fmin(a,b)
 assert(r.dtype=='int8','fmin dtype 389 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 389')
 assert(veq(r:tolist(),{{2,-3,2},{-9,-9,-9}}),'fmin values 389')
end
do -- fmin 390
 local a=np.array({{2,2,1},{31,1,2}},np.uint16)
 local b=np.array({{2,3,127}},np.uint32)
 local r=np.fmin(a,b)
 assert(r.dtype=='uint32','fmin dtype 390 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 390')
 assert(veq(r:tolist(),{{2,2,1},{2,1,2}}),'fmin values 390')
end
do -- fmin 391
 local a=np.array({{-31,7,-3},{-9,0,-1}},np.int32)
 local b=np.array({127,7,2},np.uint16)
 local r=np.fmin(a,b)
 assert(r.dtype=='int32','fmin dtype 391 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 391')
 assert(veq(r:tolist(),{{-31,7,-3},{-9,0,-1}}),'fmin values 391')
end
do -- fmin 392
 local a=np.array({{-3.0},{0.0}},np.float16)
 local b=np.array({{-3.0,1.0,math.huge}},np.float64)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 392 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 392')
 assert(veq(r:tolist(),{{-3.0,-3.0,-3.0},{-3.0,0.0,0.0}}),'fmin values 392')
end
do -- fmin 393
 local a=np.array({{2,3,63},{1,7,7}},np.uint64)
 local b=np.array({1,31,31},np.uint32)
 local r=np.fmin(a,b)
 assert(r.dtype=='uint64','fmin dtype 393 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 393')
 assert(veq(r:tolist(),{{1,3,31},{1,7,7}}),'fmin values 393')
end
do -- fmin 394
 local a=np.array({{1.0,-9.5,-9.5},{-3.0,-1.5,-9.5}},np.float64)
 local b=np.array({{2,-1,-3}},np.int8)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 394 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 394')
 assert(veq(r:tolist(),{{1.0,-9.5,-9.5},{-3.0,-1.5,-9.5}}),'fmin values 394')
end
do -- fmin 395
 local a=np.array({{1,127,1},{15,2,7}},np.uint32)
 local b=np.array({-3.0,-1.5,-3.0},np.float64)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 395 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 395')
 assert(veq(r:tolist(),{{-3.0,-1.5,-3.0},{-3.0,-1.5,-3.0}}),'fmin values 395')
end
do -- fmin 396
 local a=np.array({{15,5,63},{0,127,5}},np.uint8)
 local b=np.array({5,63,2},np.uint64)
 local r=np.fmin(a,b)
 assert(r.dtype=='uint64','fmin dtype 396 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 396')
 assert(veq(r:tolist(),{{5,5,2},{0,63,2}}),'fmin values 396')
end
do -- fmin 397
 local a=np.array({{7,30,1},{7,7,2}},np.int16)
 local b=np.array({false,true,true},np.bool)
 local r=np.fmin(a,b)
 assert(r.dtype=='int16','fmin dtype 397 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 397')
 assert(veq(r:tolist(),{{0,1,1},{0,1,1}}),'fmin values 397')
end
do -- fmin 398
 local a=np.array({{true,false,false},{true,true,false}},np.bool)
 local b=np.array({{15,-3,0}},np.int64)
 local r=np.fmin(a,b)
 assert(r.dtype=='int64','fmin dtype 398 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 398')
 assert(veq(r:tolist(),{{1,-3,0},{1,-3,0}}),'fmin values 398')
end
do -- fmin 399
 local a=np.array({{127,0,0},{127,15,3}},np.uint8)
 local b=np.array({{-31,2,0}},np.int32)
 local r=np.fmin(a,b)
 assert(r.dtype=='int32','fmin dtype 399 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 399')
 assert(veq(r:tolist(),{{-31,0,0},{-31,2,0}}),'fmin values 399')
end
do -- fmin 400
 local a=np.array({{0},{31}},np.uint32)
 local b=np.array({{2,31,1}},np.uint16)
 local r=np.fmin(a,b)
 assert(r.dtype=='uint32','fmin dtype 400 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 400')
 assert(veq(r:tolist(),{{0,0,0},{2,31,1}}),'fmin values 400')
end
do -- fmin 401
 local a=np.array({{false,false,true},{false,false,true}},np.bool)
 local b=np.array({{30,1,1}},np.int32)
 local r=np.fmin(a,b)
 assert(r.dtype=='int32','fmin dtype 401 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 401')
 assert(veq(r:tolist(),{{0,0,1},{0,0,1}}),'fmin values 401')
end
do -- fmin 402
 local a=np.array({1,3,3,15,0},np.uint64)
 local b=np.array({(0/0),9.0,-1.5,(0/0),0.0},np.float16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 402 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmin shape 402')
 assert(veq(r:tolist(),{1.0,3.0,-1.5,15.0,0.0}),'fmin values 402')
end
do -- fmin 403
 local a=np.array({3,0,127,1,63},np.uint16)
 local b=np.array({-math.huge,-1.0,3.5,-0.0,-1.5},np.float64)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 403 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmin shape 403')
 assert(veq(r:tolist(),{-math.huge,-1.0,3.5,-0.0,-1.5}),'fmin values 403')
end
do -- fmin 404
 local a=np.array({{-math.huge,(0/0),-1.5},{-0.0,0.0,0.0}},np.float32)
 local b=np.array({{15,-3,0}},np.int32)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 404 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 404')
 assert(veq(r:tolist(),{{-math.huge,-3.0,-1.5},{-0.0,-3.0,0.0}}),'fmin values 404')
end
do -- fmin 405
 local a=np.array({true,true,true,false,true},np.bool)
 local b=np.array({math.huge,math.huge,-math.huge,-1.5,-3.0},np.float64)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 405 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmin shape 405')
 assert(veq(r:tolist(),{1.0,1.0,-math.huge,-1.5,-3.0}),'fmin values 405')
end
do -- fmin 406
 local a=np.array({{-1.5},{-0.0}},np.float64)
 local b=np.array({{-3.0,-math.huge,2.0}},np.float64)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 406 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 406')
 assert(veq(r:tolist(),{{-3.0,-math.huge,-1.5},{-3.0,-math.huge,-0.0}}),'fmin values 406')
end
do -- fmin 407
 local a=np.array({{127,127,3},{5,2,3}},np.uint32)
 local b=np.array({15,2,0},np.int8)
 local r=np.fmin(a,b)
 assert(r.dtype=='int64','fmin dtype 407 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 407')
 assert(veq(r:tolist(),{{15,2,0},{5,2,0}}),'fmin values 407')
end
do -- fmin 408
 local a=np.array({{3},{0}},np.int32)
 local b=np.array({{false,false,false}},np.bool)
 local r=np.fmin(a,b)
 assert(r.dtype=='int32','fmin dtype 408 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 408')
 assert(veq(r:tolist(),{{0,0,0},{0,0,0}}),'fmin values 408')
end
do -- fmin 409
 local a=np.array({127,7,127,5,5},np.uint8)
 local b=np.array({1,7,1,5,63},np.uint16)
 local r=np.fmin(a,b)
 assert(r.dtype=='uint16','fmin dtype 409 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmin shape 409')
 assert(veq(r:tolist(),{1,7,1,5,5}),'fmin values 409')
end
do -- fmin 410
 local a=np.array({31,1,0,7,2},np.uint64)
 local b=np.array({0,127,1,2,0},np.uint16)
 local r=np.fmin(a,b)
 assert(r.dtype=='uint64','fmin dtype 410 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmin shape 410')
 assert(veq(r:tolist(),{0,1,0,2,0}),'fmin values 410')
end
do -- fmin 411
 local a=np.array({{2,15,-1},{30,-3,15}},np.int8)
 local b=np.array({31,15,5},np.uint8)
 local r=np.fmin(a,b)
 assert(r.dtype=='int16','fmin dtype 411 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 411')
 assert(veq(r:tolist(),{{2,15,-1},{30,-3,5}}),'fmin values 411')
end
do -- fmin 412
 local a=np.array({{(0/0),-9.5,-1.0},{(0/0),2.0,-9.5}},np.float32)
 local b=np.array({{-9,-1,30}},np.int32)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 412 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 412')
 assert(veq(r:tolist(),{{-9.0,-9.5,-1.0},{-9.0,-1.0,-9.5}}),'fmin values 412')
end
do -- fmin 413
 local a=np.array({{31},{15}},np.uint16)
 local b=np.array({{(0/0),3.5,-1.5}},np.float16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float32','fmin dtype 413 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 413')
 assert(veq(r:tolist(),{{31.0,3.5,-1.5},{15.0,3.5,-1.5}}),'fmin values 413')
end
do -- fmin 414
 local a=np.array({{30,2,15},{15,2,15}},np.int64)
 local b=np.array({{31,127,15}},np.uint64)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 414 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 414')
 assert(veq(r:tolist(),{{30.0,2.0,15.0},{15.0,2.0,15.0}}),'fmin values 414')
end
do -- fmin 415
 local a=np.array({{-0.0,-math.huge,math.huge},{0.0,3.5,-3.0}},np.float64)
 local b=np.array({{15,63,0}},np.uint8)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 415 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 415')
 assert(veq(r:tolist(),{{-0.0,-math.huge,0.0},{0.0,3.5,-3.0}}),'fmin values 415')
end
do -- fmin 416
 local a=np.array({{true,true,false},{false,true,true}},np.bool)
 local b=np.array({1,31,127},np.uint64)
 local r=np.fmin(a,b)
 assert(r.dtype=='uint64','fmin dtype 416 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 416')
 assert(veq(r:tolist(),{{1,1,0},{0,1,1}}),'fmin values 416')
end
do -- fmin 417
 local a=np.array({{15},{15}},np.int32)
 local b=np.array({{-3,15,30}},np.int16)
 local r=np.fmin(a,b)
 assert(r.dtype=='int32','fmin dtype 417 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 417')
 assert(veq(r:tolist(),{{-3,15,15},{-3,15,15}}),'fmin values 417')
end
do -- fmin 418
 local a=np.array({{5,1,15},{31,0,127}},np.uint64)
 local b=np.array({{-3,30,30}},np.int32)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 418 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 418')
 assert(veq(r:tolist(),{{-3.0,1.0,15.0},{-3.0,0.0,30.0}}),'fmin values 418')
end
do -- fmin 419
 local a=np.array({3,3,-1,15,-3},np.int64)
 local b=np.array({2.0,9.0,1.0,math.huge,1.0},np.float32)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 419 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmin shape 419')
 assert(veq(r:tolist(),{2.0,3.0,-1.0,15.0,-3.0}),'fmin values 419')
end
do -- fmin 420
 local a=np.array({{0.5,1.0,1.0},{2.0,3.5,math.huge}},np.float64)
 local b=np.array({{15,2,-3}},np.int8)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 420 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 420')
 assert(veq(r:tolist(),{{0.5,1.0,-3.0},{2.0,2.0,-3.0}}),'fmin values 420')
end
do -- fmin 421
 local a=np.array({{9.0},{3.5}},np.float16)
 local b=np.array({{0.0,-9.5,math.huge}},np.float32)
 local r=np.fmin(a,b)
 assert(r.dtype=='float32','fmin dtype 421 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 421')
 assert(veq(r:tolist(),{{0.0,-9.5,9.0},{0.0,-9.5,3.5}}),'fmin values 421')
end
do -- fmin 422
 local a=np.array({{0.0},{-3.0}},np.float32)
 local b=np.array({{-0.0,-0.0,9.0}},np.float16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float32','fmin dtype 422 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 422')
 assert(veq(r:tolist(),{{0.0,-0.0,0.0},{-3.0,-3.0,-3.0}}),'fmin values 422')
end
do -- fmin 423
 local a=np.array({0,1,5,1,15},np.uint64)
 local b=np.array({0,15,0,15,-3},np.int8)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 423 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmin shape 423')
 assert(veq(r:tolist(),{0.0,1.0,0.0,1.0,-3.0}),'fmin values 423')
end
do -- fmin 424
 local a=np.array({true,false,false,true,false},np.bool)
 local b=np.array({2.0,1.0,(0/0),0.0,0.5},np.float16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float16','fmin dtype 424 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmin shape 424')
 assert(veq(r:tolist(),{1.0,0.0,0.0,0.0,0.0}),'fmin values 424')
end
do -- fmin 425
 local a=np.array({{2,1,-31},{-3,30,-31}},np.int8)
 local b=np.array({2.0,9.0,0.5},np.float64)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 425 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 425')
 assert(veq(r:tolist(),{{2.0,1.0,-31.0},{-3.0,9.0,-31.0}}),'fmin values 425')
end
do -- fmin 426
 local a=np.array({{30,2,7},{-1,-9,-1}},np.int32)
 local b=np.array({-3,-31,2},np.int64)
 local r=np.fmin(a,b)
 assert(r.dtype=='int64','fmin dtype 426 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 426')
 assert(veq(r:tolist(),{{-3,-31,2},{-3,-31,-1}}),'fmin values 426')
end
do -- fmin 427
 local a=np.array({{2},{15}},np.int32)
 local b=np.array({{0,-9,-1}},np.int64)
 local r=np.fmin(a,b)
 assert(r.dtype=='int64','fmin dtype 427 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 427')
 assert(veq(r:tolist(),{{0,-9,-1},{0,-9,-1}}),'fmin values 427')
end
do -- fmin 428
 local a=np.array({{5,1,0},{1,2,2}},np.uint16)
 local b=np.array({{31,63,127}},np.uint16)
 local r=np.fmin(a,b)
 assert(r.dtype=='uint16','fmin dtype 428 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 428')
 assert(veq(r:tolist(),{{5,1,0},{1,2,2}}),'fmin values 428')
end
do -- fmin 429
 local a=np.array({{true,true,true},{false,false,false}},np.bool)
 local b=np.array({{0,3,0}},np.int32)
 local r=np.fmin(a,b)
 assert(r.dtype=='int32','fmin dtype 429 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 429')
 assert(veq(r:tolist(),{{0,1,0},{0,0,0}}),'fmin values 429')
end
do -- fmin 430
 local a=np.array({{30,-9,-9},{30,-31,-31}},np.int32)
 local b=np.array({31,5,31},np.uint16)
 local r=np.fmin(a,b)
 assert(r.dtype=='int32','fmin dtype 430 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 430')
 assert(veq(r:tolist(),{{30,-9,-9},{30,-31,-31}}),'fmin values 430')
end
do -- fmin 431
 local a=np.array({{15,31,3},{2,0,2}},np.uint64)
 local b=np.array({{-3,0,7}},np.int8)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 431 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 431')
 assert(veq(r:tolist(),{{-3.0,0.0,3.0},{-3.0,0.0,2.0}}),'fmin values 431')
end
do -- fmin 432
 local a=np.array({{2.0,1.0,-1.5},{9.0,3.5,9.0}},np.float64)
 local b=np.array({1,63,31},np.uint32)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 432 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 432')
 assert(veq(r:tolist(),{{1.0,1.0,-1.5},{1.0,3.5,9.0}}),'fmin values 432')
end
do -- fmin 433
 local a=np.array({{3},{1}},np.int64)
 local b=np.array({{127,63,0}},np.uint16)
 local r=np.fmin(a,b)
 assert(r.dtype=='int64','fmin dtype 433 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 433')
 assert(veq(r:tolist(),{{3,3,0},{1,1,0}}),'fmin values 433')
end
do -- fmin 434
 local a=np.array({{7},{63}},np.uint16)
 local b=np.array({{7,31,63}},np.uint32)
 local r=np.fmin(a,b)
 assert(r.dtype=='uint32','fmin dtype 434 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 434')
 assert(veq(r:tolist(),{{7,7,7},{7,31,63}}),'fmin values 434')
end
do -- fmin 435
 local a=np.array({7,7,5,127,63},np.uint32)
 local b=np.array({-9,0,0,3,-9},np.int8)
 local r=np.fmin(a,b)
 assert(r.dtype=='int64','fmin dtype 435 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmin shape 435')
 assert(veq(r:tolist(),{-9,0,0,3,-9}),'fmin values 435')
end
do -- fmin 436
 local a=np.array({2,127,63,0,31},np.uint32)
 local b=np.array({0,5,127,7,127},np.uint64)
 local r=np.fmin(a,b)
 assert(r.dtype=='uint64','fmin dtype 436 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmin shape 436')
 assert(veq(r:tolist(),{0,5,63,0,31}),'fmin values 436')
end
do -- fmin 437
 local a=np.array({{3,0,1},{30,0,2}},np.int16)
 local b=np.array({7,30,0},np.int16)
 local r=np.fmin(a,b)
 assert(r.dtype=='int16','fmin dtype 437 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 437')
 assert(veq(r:tolist(),{{3,0,0},{7,0,0}}),'fmin values 437')
end
do -- fmin 438
 local a=np.array({{30,2,15},{-1,15,30}},np.int8)
 local b=np.array({(0/0),-1.0,2.0},np.float32)
 local r=np.fmin(a,b)
 assert(r.dtype=='float32','fmin dtype 438 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 438')
 assert(veq(r:tolist(),{{30.0,-1.0,2.0},{-1.0,-1.0,2.0}}),'fmin values 438')
end
do -- fmin 439
 local a=np.array({{-31},{7}},np.int32)
 local b=np.array({{15,1,3}},np.int64)
 local r=np.fmin(a,b)
 assert(r.dtype=='int64','fmin dtype 439 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 439')
 assert(veq(r:tolist(),{{-31,-31,-31},{7,1,3}}),'fmin values 439')
end
do -- fmin 440
 local a=np.array({{2,2,15},{1,63,2}},np.uint16)
 local b=np.array({{0.5,-1.5,-3.0}},np.float32)
 local r=np.fmin(a,b)
 assert(r.dtype=='float32','fmin dtype 440 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 440')
 assert(veq(r:tolist(),{{0.5,-1.5,-3.0},{0.5,-1.5,-3.0}}),'fmin values 440')
end
do -- fmin 441
 local a=np.array({{0},{1}},np.uint8)
 local b=np.array({{0.5,-1.0,-3.0}},np.float64)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 441 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 441')
 assert(veq(r:tolist(),{{0.0,-1.0,-3.0},{0.5,-1.0,-3.0}}),'fmin values 441')
end
do -- fmin 442
 local a=np.array({{-31},{7}},np.int32)
 local b=np.array({{15,7,127}},np.uint64)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 442 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 442')
 assert(veq(r:tolist(),{{-31.0,-31.0,-31.0},{7.0,7.0,7.0}}),'fmin values 442')
end
do -- fmin 443
 local a=np.array({{2},{63}},np.uint32)
 local b=np.array({{true,false,true}},np.bool)
 local r=np.fmin(a,b)
 assert(r.dtype=='uint32','fmin dtype 443 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 443')
 assert(veq(r:tolist(),{{1,0,1},{1,0,1}}),'fmin values 443')
end
do -- fmin 444
 local a=np.array({{15,1,127},{0,63,0}},np.uint16)
 local b=np.array({{-1.5,-0.0,-9.5}},np.float64)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 444 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 444')
 assert(veq(r:tolist(),{{-1.5,-0.0,-9.5},{-1.5,-0.0,-9.5}}),'fmin values 444')
end
do -- fmin 445
 local a=np.array({{63,127,3},{1,5,63}},np.uint64)
 local b=np.array({{7,63,5}},np.uint64)
 local r=np.fmin(a,b)
 assert(r.dtype=='uint64','fmin dtype 445 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 445')
 assert(veq(r:tolist(),{{7,63,3},{1,5,5}}),'fmin values 445')
end
do -- fmin 446
 local a=np.array({{1,3,0},{3,-31,0}},np.int8)
 local b=np.array({63,3,2},np.uint16)
 local r=np.fmin(a,b)
 assert(r.dtype=='int32','fmin dtype 446 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 446')
 assert(veq(r:tolist(),{{1,3,0},{3,-31,0}}),'fmin values 446')
end
do -- fmin 447
 local a=np.array({-3,-1,3,-3,1},np.int16)
 local b=np.array({3,7,0,63,15},np.uint64)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 447 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmin shape 447')
 assert(veq(r:tolist(),{-3.0,-1.0,0.0,-3.0,1.0}),'fmin values 447')
end
do -- fmin 448
 local a=np.array({true,true,true,true,true},np.bool)
 local b=np.array({0.5,3.5,-3.0,-3.0,2.0},np.float16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float16','fmin dtype 448 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmin shape 448')
 assert(veq(r:tolist(),{0.5,1.0,-3.0,-3.0,1.0}),'fmin values 448')
end
do -- fmin 449
 local a=np.array({{-1},{7}},np.int32)
 local b=np.array({{-9,1,15}},np.int16)
 local r=np.fmin(a,b)
 assert(r.dtype=='int32','fmin dtype 449 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 449')
 assert(veq(r:tolist(),{{-9,-1,-1},{-9,1,7}}),'fmin values 449')
end
do -- fmin 450
 local a=np.array({0.5,-9.5,2.0,2.0,0.0},np.float16)
 local b=np.array({0.5,(0/0),-math.huge,0.5,-9.5},np.float16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float16','fmin dtype 450 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmin shape 450')
 assert(veq(r:tolist(),{0.5,-9.5,-math.huge,0.5,-9.5}),'fmin values 450')
end
do -- fmin 451
 local a=np.array({{1.0,9.0,math.huge},{(0/0),-9.5,-3.0}},np.float16)
 local b=np.array({-math.huge,math.huge,-1.5},np.float64)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 451 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 451')
 assert(veq(r:tolist(),{{-math.huge,9.0,-1.5},{-math.huge,-9.5,-3.0}}),'fmin values 451')
end
do -- fmin 452
 local a=np.array({{false},{true}},np.bool)
 local b=np.array({{-math.huge,9.0,3.5}},np.float16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float16','fmin dtype 452 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 452')
 assert(veq(r:tolist(),{{-math.huge,0.0,0.0},{-math.huge,1.0,1.0}}),'fmin values 452')
end
do -- fmin 453
 local a=np.array({{-0.0},{math.huge}},np.float16)
 local b=np.array({{-1,7,15}},np.int32)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 453 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 453')
 assert(veq(r:tolist(),{{-1.0,-0.0,-0.0},{-1.0,7.0,15.0}}),'fmin values 453')
end
do -- fmin 454
 local a=np.array({7,0,1,15,3},np.uint32)
 local b=np.array({-9.5,-0.0,-9.5,-3.0,9.0},np.float16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 454 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmin shape 454')
 assert(veq(r:tolist(),{-9.5,0.0,-9.5,-3.0,3.0}),'fmin values 454')
end
do -- fmin 455
 local a=np.array({{3},{2}},np.int16)
 local b=np.array({{7,-9,15}},np.int16)
 local r=np.fmin(a,b)
 assert(r.dtype=='int16','fmin dtype 455 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 455')
 assert(veq(r:tolist(),{{3,-9,3},{2,-9,2}}),'fmin values 455')
end
do -- fmin 456
 local a=np.array({15,3,-9,2,-3},np.int16)
 local b=np.array({15,3,0,1,-1},np.int64)
 local r=np.fmin(a,b)
 assert(r.dtype=='int64','fmin dtype 456 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmin shape 456')
 assert(veq(r:tolist(),{15,3,-9,1,-3}),'fmin values 456')
end
do -- fmin 457
 local a=np.array({{31},{3}},np.uint32)
 local b=np.array({{9.0,math.huge,(0/0)}},np.float32)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 457 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 457')
 assert(veq(r:tolist(),{{9.0,31.0,31.0},{3.0,3.0,3.0}}),'fmin values 457')
end
do -- fmin 458
 local a=np.array({{30},{30}},np.int8)
 local b=np.array({{5,63,3}},np.uint8)
 local r=np.fmin(a,b)
 assert(r.dtype=='int16','fmin dtype 458 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 458')
 assert(veq(r:tolist(),{{5,30,3},{5,30,3}}),'fmin values 458')
end
do -- fmin 459
 local a=np.array({{0.0,(0/0),2.0},{9.0,-math.huge,-9.5}},np.float16)
 local b=np.array({-9,30,1},np.int16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float32','fmin dtype 459 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 459')
 assert(veq(r:tolist(),{{-9.0,30.0,1.0},{-9.0,-math.huge,-9.5}}),'fmin values 459')
end
do -- fmin 460
 local a=np.array({{63,7,15},{15,7,3}},np.uint32)
 local b=np.array({{3,63,1}},np.uint32)
 local r=np.fmin(a,b)
 assert(r.dtype=='uint32','fmin dtype 460 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 460')
 assert(veq(r:tolist(),{{3,7,1},{3,7,1}}),'fmin values 460')
end
do -- fmin 461
 local a=np.array({{3.5},{1.0}},np.float64)
 local b=np.array({{-1.5,0.0,-3.0}},np.float16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 461 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 461')
 assert(veq(r:tolist(),{{-1.5,0.0,-3.0},{-1.5,0.0,-3.0}}),'fmin values 461')
end
do -- fmin 462
 local a=np.array({false,true,true,true,true},np.bool)
 local b=np.array({15,1,31,5,127},np.uint16)
 local r=np.fmin(a,b)
 assert(r.dtype=='uint16','fmin dtype 462 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmin shape 462')
 assert(veq(r:tolist(),{0,1,1,1,1}),'fmin values 462')
end
do -- fmin 463
 local a=np.array({-math.huge,-0.0,2.0,0.5,9.0},np.float32)
 local b=np.array({30,-3,3,1,2},np.int32)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 463 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmin shape 463')
 assert(veq(r:tolist(),{-math.huge,-3.0,2.0,0.5,2.0}),'fmin values 463')
end
do -- fmin 464
 local a=np.array({-3,-1,-9,15,1},np.int8)
 local b=np.array({-math.huge,9.0,1.0,-1.5,0.5},np.float16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float16','fmin dtype 464 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmin shape 464')
 assert(veq(r:tolist(),{-math.huge,-1.0,-9.0,-1.5,0.5}),'fmin values 464')
end
do -- fmin 465
 local a=np.array({1.0,-1.5,-3.0,3.5,9.0},np.float32)
 local b=np.array({127,2,0,15,63},np.uint64)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 465 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmin shape 465')
 assert(veq(r:tolist(),{1.0,-1.5,-3.0,3.5,9.0}),'fmin values 465')
end
do -- fmin 466
 local a=np.array({{-3,15,15},{2,2,2}},np.int8)
 local b=np.array({3,0,1},np.int16)
 local r=np.fmin(a,b)
 assert(r.dtype=='int16','fmin dtype 466 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 466')
 assert(veq(r:tolist(),{{-3,0,1},{2,0,1}}),'fmin values 466')
end
do -- fmin 467
 local a=np.array({2,1,-9,30,3},np.int32)
 local b=np.array({30,-1,0,-9,1},np.int8)
 local r=np.fmin(a,b)
 assert(r.dtype=='int32','fmin dtype 467 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmin shape 467')
 assert(veq(r:tolist(),{2,-1,-9,-9,1}),'fmin values 467')
end
do -- fmin 468
 local a=np.array({{0.0,-0.0,0.0},{3.5,-math.huge,(0/0)}},np.float16)
 local b=np.array({{0,-31,-3}},np.int16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float32','fmin dtype 468 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 468')
 assert(veq(r:tolist(),{{0.0,-31.0,-3.0},{0.0,-math.huge,-3.0}}),'fmin values 468')
end
do -- fmin 469
 local a=np.array({{-0.0,-1.0,0.5},{-0.0,-1.5,9.0}},np.float64)
 local b=np.array({0,30,7},np.int32)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 469 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 469')
 assert(veq(r:tolist(),{{-0.0,-1.0,0.5},{0.0,-1.5,7.0}}),'fmin values 469')
end
do -- fmin 470
 local a=np.array({{3.5,-1.0,-3.0},{-1.0,(0/0),-1.0}},np.float64)
 local b=np.array({{true,true,false}},np.bool)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 470 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 470')
 assert(veq(r:tolist(),{{1.0,-1.0,-3.0},{-1.0,1.0,-1.0}}),'fmin values 470')
end
do -- fmin 471
 local a=np.array({{3},{3}},np.int64)
 local b=np.array({{0,7,1}},np.int8)
 local r=np.fmin(a,b)
 assert(r.dtype=='int64','fmin dtype 471 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 471')
 assert(veq(r:tolist(),{{0,3,1},{0,3,1}}),'fmin values 471')
end
do -- fmin 472
 local a=np.array({2,0,5,7,63},np.uint64)
 local b=np.array({true,true,false,true,false},np.bool)
 local r=np.fmin(a,b)
 assert(r.dtype=='uint64','fmin dtype 472 '..r.dtype)
 assert(seqeq(r.shape,{5}),'fmin shape 472')
 assert(veq(r:tolist(),{1,0,0,1,0}),'fmin values 472')
end
do -- fmin 473
 local a=np.array({{63,31,0},{63,5,5}},np.uint8)
 local b=np.array({0,7,-1},np.int8)
 local r=np.fmin(a,b)
 assert(r.dtype=='int16','fmin dtype 473 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 473')
 assert(veq(r:tolist(),{{0,7,-1},{0,5,-1}}),'fmin values 473')
end
do -- fmin 474
 local a=np.array({{-1.5,-0.0,-math.huge},{-1.5,(0/0),-1.5}},np.float16)
 local b=np.array({-3.0,-3.0,9.0},np.float64)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','fmin dtype 474 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'fmin shape 474')
 assert(veq(r:tolist(),{{-3.0,-3.0,-math.huge},{-3.0,-3.0,-1.5}}),'fmin values 474')
end
do -- bitwise_and 475
 local a=np.array({{127,3,1},{5,5,0}},np.uint32)
 local b=np.array({0,7,5},np.uint16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint32','bitwise_and dtype 475')
 assert(veq(r:tolist(),{{0,3,1},{0,5,0}}),'bitwise_and values 475')
end
do -- bitwise_and type error 476
 local a=np.array({{-31},{1}},np.int16)
 local b=np.array({{31,0,7}},np.uint64)
 local ok=pcall(function() return np.bitwise_and(a,b) end)
 assert(not ok,'bitwise_and error 476')
end
do -- bitwise_and 477
 local a=np.array({{127,63,1},{15,127,3}},np.uint16)
 local b=np.array({1,15,-9},np.int32)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int32','bitwise_and dtype 477')
 assert(veq(r:tolist(),{{1,15,1},{1,15,3}}),'bitwise_and values 477')
end
do -- bitwise_and 478
 local a=np.array({{true},{false}},np.bool)
 local b=np.array({{3,127,15}},np.uint8)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint8','bitwise_and dtype 478')
 assert(veq(r:tolist(),{{1,1,1},{0,0,0}}),'bitwise_and values 478')
end
do -- bitwise_and 479
 local a=np.array({{-1,1,3},{-31,3,15}},np.int8)
 local b=np.array({true,true,true},np.bool)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int8','bitwise_and dtype 479')
 assert(veq(r:tolist(),{{1,1,1},{1,1,1}}),'bitwise_and values 479')
end
do -- bitwise_and 480
 local a=np.array({{31,15,0},{0,2,15}},np.uint8)
 local b=np.array({5,127,2},np.uint32)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint32','bitwise_and dtype 480')
 assert(veq(r:tolist(),{{5,15,0},{0,2,2}}),'bitwise_and values 480')
end
do -- bitwise_and type error 481
 local a=np.array({{0,-3,-31},{15,15,7}},np.int64)
 local b=np.array({127,31,127},np.uint64)
 local ok=pcall(function() return np.bitwise_and(a,b) end)
 assert(not ok,'bitwise_and error 481')
end
do -- bitwise_and 482
 local a=np.array({{-9,-31,-31},{-9,30,15}},np.int16)
 local b=np.array({{-31,15,-1}},np.int32)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int32','bitwise_and dtype 482')
 assert(veq(r:tolist(),{{-31,1,-31},{-31,14,15}}),'bitwise_and values 482')
end
do -- bitwise_and 483
 local a=np.array({{-31,0,-3},{-3,-3,-1}},np.int8)
 local b=np.array({{0,0,2}},np.uint32)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int64','bitwise_and dtype 483')
 assert(veq(r:tolist(),{{0,0,0},{0,0,2}}),'bitwise_and values 483')
end
do -- bitwise_and 484
 local a=np.array({{15,0,-9},{3,3,-31}},np.int32)
 local b=np.array({2,31,3},np.uint8)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int32','bitwise_and dtype 484')
 assert(veq(r:tolist(),{{2,0,3},{2,3,1}}),'bitwise_and values 484')
end
do -- bitwise_and 485
 local a=np.array({{15,15,-1},{2,-31,1}},np.int32)
 local b=np.array({127,2,127},np.uint16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int32','bitwise_and dtype 485')
 assert(veq(r:tolist(),{{15,2,127},{2,0,1}}),'bitwise_and values 485')
end
do -- bitwise_and 486
 local a=np.array({{1},{1}},np.int16)
 local b=np.array({{30,30,15}},np.int64)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int64','bitwise_and dtype 486')
 assert(veq(r:tolist(),{{0,0,1},{0,0,1}}),'bitwise_and values 486')
end
do -- bitwise_and 487
 local a=np.array({{3},{30}},np.int16)
 local b=np.array({{false,false,true}},np.bool)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int16','bitwise_and dtype 487')
 assert(veq(r:tolist(),{{0,0,1},{0,0,0}}),'bitwise_and values 487')
end
do -- bitwise_and 488
 local a=np.array({{-3,7,-31},{3,-3,3}},np.int16)
 local b=np.array({{3,1,3}},np.int32)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int32','bitwise_and dtype 488')
 assert(veq(r:tolist(),{{1,1,1},{3,1,3}}),'bitwise_and values 488')
end
do -- bitwise_and 489
 local a=np.array({{2},{5}},np.uint16)
 local b=np.array({{15,30,3}},np.int8)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int32','bitwise_and dtype 489')
 assert(veq(r:tolist(),{{2,2,2},{5,4,1}}),'bitwise_and values 489')
end
do -- bitwise_and 490
 local a=np.array({{2,1,30},{2,-9,15}},np.int64)
 local b=np.array({0,0,1},np.uint16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int64','bitwise_and dtype 490')
 assert(veq(r:tolist(),{{0,0,0},{0,0,1}}),'bitwise_and values 490')
end
do -- bitwise_and 491
 local a=np.array({{-9},{15}},np.int64)
 local b=np.array({{127,127,15}},np.uint32)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int64','bitwise_and dtype 491')
 assert(veq(r:tolist(),{{119,119,7},{15,15,15}}),'bitwise_and values 491')
end
do -- bitwise_and 492
 local a=np.array({2,127,2,5,3},np.uint32)
 local b=np.array({7,3,-9,1,-3},np.int8)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int64','bitwise_and dtype 492')
 assert(veq(r:tolist(),{2,3,2,1,1}),'bitwise_and values 492')
end
do -- bitwise_and 493
 local a=np.array({{0,2,5},{2,1,1}},np.uint16)
 local b=np.array({7,0,63},np.uint64)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint64','bitwise_and dtype 493')
 assert(veq(r:tolist(),{{0,0,5},{2,0,1}}),'bitwise_and values 493')
end
do -- bitwise_and 494
 local a=np.array({{7,5,3},{31,7,0}},np.uint8)
 local b=np.array({7,3,3},np.int32)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int32','bitwise_and dtype 494')
 assert(veq(r:tolist(),{{7,1,3},{7,3,0}}),'bitwise_and values 494')
end
do -- bitwise_and 495
 local a=np.array({{31,3,63},{7,3,127}},np.uint16)
 local b=np.array({{3,127,7}},np.uint32)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint32','bitwise_and dtype 495')
 assert(veq(r:tolist(),{{3,3,7},{3,3,7}}),'bitwise_and values 495')
end
do -- bitwise_and 496
 local a=np.array({{5,0,5},{127,3,7}},np.uint32)
 local b=np.array({3,127,15},np.uint16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint32','bitwise_and dtype 496')
 assert(veq(r:tolist(),{{1,0,5},{3,3,7}}),'bitwise_and values 496')
end
do -- bitwise_and 497
 local a=np.array({0,7,1,5,3},np.uint32)
 local b=np.array({-31,-1,2,2,15},np.int16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int64','bitwise_and dtype 497')
 assert(veq(r:tolist(),{0,7,0,0,3}),'bitwise_and values 497')
end
do -- bitwise_and 498
 local a=np.array({{true,false,true},{false,false,false}},np.bool)
 local b=np.array({0,127,5},np.uint8)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint8','bitwise_and dtype 498')
 assert(veq(r:tolist(),{{0,0,1},{0,0,0}}),'bitwise_and values 498')
end
do -- bitwise_and 499
 local a=np.array({{-31,1,-1},{7,-31,-9}},np.int64)
 local b=np.array({false,false,true},np.bool)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int64','bitwise_and dtype 499')
 assert(veq(r:tolist(),{{0,0,1},{0,0,1}}),'bitwise_and values 499')
end
do -- bitwise_and 500
 local a=np.array({{2,30,0},{1,1,-31}},np.int8)
 local b=np.array({{0,63,3}},np.uint32)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int64','bitwise_and dtype 500')
 assert(veq(r:tolist(),{{0,30,0},{0,1,1}}),'bitwise_and values 500')
end
do -- bitwise_and 501
 local a=np.array({-3,1,1,7,15},np.int8)
 local b=np.array({30,-3,30,3,-1},np.int8)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int8','bitwise_and dtype 501')
 assert(veq(r:tolist(),{28,1,0,3,15}),'bitwise_and values 501')
end
do -- bitwise_and 502
 local a=np.array({{1},{127}},np.uint16)
 local b=np.array({{63,7,31}},np.uint32)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint32','bitwise_and dtype 502')
 assert(veq(r:tolist(),{{1,1,1},{63,7,31}}),'bitwise_and values 502')
end
do -- bitwise_and 503
 local a=np.array({0,7,7,15,3},np.int32)
 local b=np.array({7,30,1,-9,3},np.int16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int32','bitwise_and dtype 503')
 assert(veq(r:tolist(),{0,6,1,7,3}),'bitwise_and values 503')
end
do -- bitwise_and 504
 local a=np.array({{30,3,30},{7,-1,0}},np.int8)
 local b=np.array({{-3,15,1}},np.int64)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int64','bitwise_and dtype 504')
 assert(veq(r:tolist(),{{28,3,0},{5,15,0}}),'bitwise_and values 504')
end
do -- bitwise_and 505
 local a=np.array({{5},{5}},np.uint64)
 local b=np.array({{1,1,2}},np.uint64)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint64','bitwise_and dtype 505')
 assert(veq(r:tolist(),{{1,1,0},{1,1,0}}),'bitwise_and values 505')
end
do -- bitwise_and 506
 local a=np.array({{true,false,true},{false,true,false}},np.bool)
 local b=np.array({31,31,3},np.uint64)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint64','bitwise_and dtype 506')
 assert(veq(r:tolist(),{{1,0,1},{0,1,0}}),'bitwise_and values 506')
end
do -- bitwise_and 507
 local a=np.array({{false,true,false},{true,false,false}},np.bool)
 local b=np.array({15,-9,2},np.int8)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int8','bitwise_and dtype 507')
 assert(veq(r:tolist(),{{0,1,0},{1,0,0}}),'bitwise_and values 507')
end
do -- bitwise_and 508
 local a=np.array({1,-3,2,15,15},np.int32)
 local b=np.array({15,7,1,0,31},np.uint16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int32','bitwise_and dtype 508')
 assert(veq(r:tolist(),{1,5,0,0,15}),'bitwise_and values 508')
end
do -- bitwise_and 509
 local a=np.array({{1},{15}},np.int8)
 local b=np.array({{63,0,31}},np.uint8)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int16','bitwise_and dtype 509')
 assert(veq(r:tolist(),{{1,0,1},{15,0,15}}),'bitwise_and values 509')
end
do -- bitwise_and 510
 local a=np.array({-3,1,-9,30,30},np.int8)
 local b=np.array({7,2,7,7,127},np.uint16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int32','bitwise_and dtype 510')
 assert(veq(r:tolist(),{5,0,7,6,30}),'bitwise_and values 510')
end
do -- bitwise_and 511
 local a=np.array({{-31,30,-3},{15,30,-1}},np.int8)
 local b=np.array({{true,false,false}},np.bool)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int8','bitwise_and dtype 511')
 assert(veq(r:tolist(),{{1,0,0},{1,0,0}}),'bitwise_and values 511')
end
do -- bitwise_and 512
 local a=np.array({{false,true,true},{true,false,true}},np.bool)
 local b=np.array({{7,0,31}},np.uint8)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint8','bitwise_and dtype 512')
 assert(veq(r:tolist(),{{0,0,1},{1,0,1}}),'bitwise_and values 512')
end
do -- bitwise_and 513
 local a=np.array({true,false,false,true,true},np.bool)
 local b=np.array({7,7,-1,3,7},np.int16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int16','bitwise_and dtype 513')
 assert(veq(r:tolist(),{1,0,0,1,1}),'bitwise_and values 513')
end
do -- bitwise_and 514
 local a=np.array({{false,false,true},{false,false,false}},np.bool)
 local b=np.array({30,-9,30},np.int8)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int8','bitwise_and dtype 514')
 assert(veq(r:tolist(),{{0,0,0},{0,0,0}}),'bitwise_and values 514')
end
do -- bitwise_and 515
 local a=np.array({{5,31,2},{1,5,5}},np.uint8)
 local b=np.array({15,1,1},np.uint16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint16','bitwise_and dtype 515')
 assert(veq(r:tolist(),{{5,1,0},{1,1,1}}),'bitwise_and values 515')
end
do -- bitwise_and 516
 local a=np.array({{0,0,2},{2,2,3}},np.uint16)
 local b=np.array({{5,0,127}},np.uint16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint16','bitwise_and dtype 516')
 assert(veq(r:tolist(),{{0,0,2},{0,0,3}}),'bitwise_and values 516')
end
do -- bitwise_and 517
 local a=np.array({{15,30,1},{0,-1,-1}},np.int8)
 local b=np.array({{1,30,0}},np.int16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int16','bitwise_and dtype 517')
 assert(veq(r:tolist(),{{1,30,0},{0,30,0}}),'bitwise_and values 517')
end
do -- bitwise_and 518
 local a=np.array({{-31,2,-1},{3,30,30}},np.int8)
 local b=np.array({true,true,true},np.bool)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int8','bitwise_and dtype 518')
 assert(veq(r:tolist(),{{1,0,1},{1,0,0}}),'bitwise_and values 518')
end
do -- bitwise_and 519
 local a=np.array({{5,5,0},{127,127,63}},np.uint8)
 local b=np.array({{5,15,127}},np.uint16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint16','bitwise_and dtype 519')
 assert(veq(r:tolist(),{{5,5,0},{5,15,63}}),'bitwise_and values 519')
end
do -- bitwise_and 520
 local a=np.array({{-1,-31,-1},{0,-1,2}},np.int8)
 local b=np.array({{5,3,5}},np.uint16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int32','bitwise_and dtype 520')
 assert(veq(r:tolist(),{{5,1,5},{0,3,0}}),'bitwise_and values 520')
end
do -- bitwise_and 521
 local a=np.array({{15,0,0},{-3,-3,3}},np.int64)
 local b=np.array({{7,-1,-1}},np.int32)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int64','bitwise_and dtype 521')
 assert(veq(r:tolist(),{{7,0,0},{5,-3,3}}),'bitwise_and values 521')
end
do -- bitwise_and 522
 local a=np.array({63,5,0,31,31},np.uint16)
 local b=np.array({127,127,5,127,1},np.uint16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint16','bitwise_and dtype 522')
 assert(veq(r:tolist(),{63,5,0,31,1}),'bitwise_and values 522')
end
do -- bitwise_and 523
 local a=np.array({{7,1,7},{1,30,2}},np.int8)
 local b=np.array({{127,7,127}},np.uint8)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int16','bitwise_and dtype 523')
 assert(veq(r:tolist(),{{7,1,7},{1,6,2}}),'bitwise_and values 523')
end
do -- bitwise_and 524
 local a=np.array({{-3},{-9}},np.int64)
 local b=np.array({{15,2,15}},np.uint32)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int64','bitwise_and dtype 524')
 assert(veq(r:tolist(),{{13,0,13},{7,2,7}}),'bitwise_and values 524')
end
do -- bitwise_and 525
 local a=np.array({{15,-31,-3},{0,0,-3}},np.int16)
 local b=np.array({31,15,63},np.uint16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int32','bitwise_and dtype 525')
 assert(veq(r:tolist(),{{15,1,61},{0,0,61}}),'bitwise_and values 525')
end
do -- bitwise_and type error 526
 local a=np.array({-9,2,1,7,15},np.int8)
 local b=np.array({0,63,1,63,0},np.uint64)
 local ok=pcall(function() return np.bitwise_and(a,b) end)
 assert(not ok,'bitwise_and error 526')
end
do -- bitwise_and 527
 local a=np.array({{-9,0,-1},{2,1,7}},np.int32)
 local b=np.array({{-3,30,30}},np.int16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int32','bitwise_and dtype 527')
 assert(veq(r:tolist(),{{-11,0,30},{0,0,6}}),'bitwise_and values 527')
end
do -- bitwise_and 528
 local a=np.array({{true,true,true},{true,true,true}},np.bool)
 local b=np.array({false,false,true},np.bool)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='bool','bitwise_and dtype 528')
 assert(veq(r:tolist(),{{false,false,true},{false,false,true}}),'bitwise_and values 528')
end
do -- bitwise_and 529
 local a=np.array({{-31},{1}},np.int16)
 local b=np.array({{-9,0,-3}},np.int8)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int16','bitwise_and dtype 529')
 assert(veq(r:tolist(),{{-31,0,-31},{1,0,1}}),'bitwise_and values 529')
end
do -- bitwise_and 530
 local a=np.array({3,31,127,2,15},np.uint8)
 local b=np.array({true,false,true,false,false},np.bool)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint8','bitwise_and dtype 530')
 assert(veq(r:tolist(),{1,0,1,0,0}),'bitwise_and values 530')
end
do -- bitwise_and 531
 local a=np.array({{7,15,-31},{-1,15,30}},np.int64)
 local b=np.array({{63,0,31}},np.uint32)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int64','bitwise_and dtype 531')
 assert(veq(r:tolist(),{{7,0,1},{63,0,30}}),'bitwise_and values 531')
end
do -- bitwise_and 532
 local a=np.array({{3},{0}},np.uint32)
 local b=np.array({{7,0,15}},np.uint16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint32','bitwise_and dtype 532')
 assert(veq(r:tolist(),{{3,0,3},{0,0,0}}),'bitwise_and values 532')
end
do -- bitwise_and 533
 local a=np.array({{false,false,false},{true,true,true}},np.bool)
 local b=np.array({true,true,false},np.bool)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='bool','bitwise_and dtype 533')
 assert(veq(r:tolist(),{{false,false,false},{true,true,false}}),'bitwise_and values 533')
end
do -- bitwise_and 534
 local a=np.array({-3,2,30,-31,30},np.int8)
 local b=np.array({15,15,5,1,0},np.uint16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int32','bitwise_and dtype 534')
 assert(veq(r:tolist(),{13,2,4,1,0}),'bitwise_and values 534')
end
do -- bitwise_and type error 535
 local a=np.array({1,5,31,63,1},np.uint64)
 local b=np.array({2,0,1,15,-31},np.int8)
 local ok=pcall(function() return np.bitwise_and(a,b) end)
 assert(not ok,'bitwise_and error 535')
end
do -- bitwise_and 536
 local a=np.array({{false},{true}},np.bool)
 local b=np.array({{false,false,true}},np.bool)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='bool','bitwise_and dtype 536')
 assert(veq(r:tolist(),{{false,false,false},{false,false,true}}),'bitwise_and values 536')
end
do -- bitwise_and 537
 local a=np.array({-3,7,3,-9,-3},np.int64)
 local b=np.array({-31,3,-1,1,3},np.int16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int64','bitwise_and dtype 537')
 assert(veq(r:tolist(),{-31,3,3,1,1}),'bitwise_and values 537')
end
do -- bitwise_and 538
 local a=np.array({{true},{false}},np.bool)
 local b=np.array({{3,30,2}},np.int8)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int8','bitwise_and dtype 538')
 assert(veq(r:tolist(),{{1,0,0},{0,0,0}}),'bitwise_and values 538')
end
do -- bitwise_and 539
 local a=np.array({0,63,15,1,127},np.uint16)
 local b=np.array({1,-9,2,-9,15},np.int32)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int32','bitwise_and dtype 539')
 assert(veq(r:tolist(),{0,55,2,1,15}),'bitwise_and values 539')
end
do -- bitwise_and 540
 local a=np.array({{-3},{-3}},np.int8)
 local b=np.array({{3,30,30}},np.int8)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int8','bitwise_and dtype 540')
 assert(veq(r:tolist(),{{1,28,28},{1,28,28}}),'bitwise_and values 540')
end
do -- bitwise_and 541
 local a=np.array({15,31,5,15,1},np.uint8)
 local b=np.array({false,true,false,false,false},np.bool)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint8','bitwise_and dtype 541')
 assert(veq(r:tolist(),{0,1,0,0,0}),'bitwise_and values 541')
end
do -- bitwise_and type error 542
 local a=np.array({{7,3,1},{7,7,7}},np.uint64)
 local b=np.array({2,15,30},np.int32)
 local ok=pcall(function() return np.bitwise_and(a,b) end)
 assert(not ok,'bitwise_and error 542')
end
do -- bitwise_and 543
 local a=np.array({{63,31,2},{0,2,31}},np.uint8)
 local b=np.array({{1,-31,1}},np.int8)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int16','bitwise_and dtype 543')
 assert(veq(r:tolist(),{{1,1,0},{0,0,1}}),'bitwise_and values 543')
end
do -- bitwise_and 544
 local a=np.array({-3,-3,-9,7,15},np.int8)
 local b=np.array({-9,15,7,1,1},np.int16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int16','bitwise_and dtype 544')
 assert(veq(r:tolist(),{-11,13,7,1,1}),'bitwise_and values 544')
end
do -- bitwise_and 545
 local a=np.array({{127,31,15},{15,3,1}},np.uint8)
 local b=np.array({{7,30,7}},np.int32)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int32','bitwise_and dtype 545')
 assert(veq(r:tolist(),{{7,30,7},{7,2,1}}),'bitwise_and values 545')
end
do -- bitwise_and 546
 local a=np.array({15,15,-31,-31,-31},np.int16)
 local b=np.array({-31,0,0,3,3},np.int64)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int64','bitwise_and dtype 546')
 assert(veq(r:tolist(),{1,0,0,1,1}),'bitwise_and values 546')
end
do -- bitwise_and 547
 local a=np.array({7,30,15,30,30},np.int8)
 local b=np.array({-3,-3,1,-3,2},np.int64)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int64','bitwise_and dtype 547')
 assert(veq(r:tolist(),{5,28,1,28,2}),'bitwise_and values 547')
end
do -- bitwise_and 548
 local a=np.array({-3,7,1,3,-9},np.int32)
 local b=np.array({7,15,2,7,7},np.int64)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int64','bitwise_and dtype 548')
 assert(veq(r:tolist(),{5,7,0,3,7}),'bitwise_and values 548')
end
do -- bitwise_and type error 549
 local a=np.array({63,1,2,127,127},np.uint64)
 local b=np.array({0,-1,7,-1,2},np.int16)
 local ok=pcall(function() return np.bitwise_and(a,b) end)
 assert(not ok,'bitwise_and error 549')
end
do -- bitwise_and 550
 local a=np.array({3,7,-9,-31,1},np.int32)
 local b=np.array({127,7,1,2,7},np.uint32)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int64','bitwise_and dtype 550')
 assert(veq(r:tolist(),{3,7,1,0,1}),'bitwise_and values 550')
end
do -- bitwise_and 551
 local a=np.array({-1,-9,15,7,-1},np.int8)
 local b=np.array({true,true,true,true,true},np.bool)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int8','bitwise_and dtype 551')
 assert(veq(r:tolist(),{1,1,1,1,1}),'bitwise_and values 551')
end
do -- bitwise_and 552
 local a=np.array({{-31,-3,1},{3,-9,-3}},np.int16)
 local b=np.array({{2,3,30}},np.int64)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int64','bitwise_and dtype 552')
 assert(veq(r:tolist(),{{0,1,0},{2,3,28}}),'bitwise_and values 552')
end
do -- bitwise_and 553
 local a=np.array({{1,1,3},{-9,-1,-9}},np.int64)
 local b=np.array({{7,5,2}},np.uint8)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int64','bitwise_and dtype 553')
 assert(veq(r:tolist(),{{1,1,2},{7,5,2}}),'bitwise_and values 553')
end
do -- bitwise_and 554
 local a=np.array({3,1,7,127,0},np.uint8)
 local b=np.array({-3,-3,0,-3,3},np.int16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int16','bitwise_and dtype 554')
 assert(veq(r:tolist(),{1,1,0,125,0}),'bitwise_and values 554')
end
do -- bitwise_and 555
 local a=np.array({{30},{-31}},np.int32)
 local b=np.array({{true,true,true}},np.bool)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int32','bitwise_and dtype 555')
 assert(veq(r:tolist(),{{0,0,0},{1,1,1}}),'bitwise_and values 555')
end
do -- bitwise_and 556
 local a=np.array({1,2,3,0,31},np.uint32)
 local b=np.array({1,15,7,31,0},np.uint64)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint64','bitwise_and dtype 556')
 assert(veq(r:tolist(),{1,2,3,0,0}),'bitwise_and values 556')
end
do -- bitwise_and 557
 local a=np.array({{false,true,false},{true,false,true}},np.bool)
 local b=np.array({{-9,3,-3}},np.int32)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int32','bitwise_and dtype 557')
 assert(veq(r:tolist(),{{0,1,0},{1,0,1}}),'bitwise_and values 557')
end
do -- bitwise_and 558
 local a=np.array({1,31,1,15,7},np.uint32)
 local b=np.array({2,15,2,1,7},np.uint64)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint64','bitwise_and dtype 558')
 assert(veq(r:tolist(),{0,15,0,1,7}),'bitwise_and values 558')
end
do -- bitwise_and 559
 local a=np.array({{true},{false}},np.bool)
 local b=np.array({{0,3,127}},np.uint64)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint64','bitwise_and dtype 559')
 assert(veq(r:tolist(),{{0,1,1},{0,0,0}}),'bitwise_and values 559')
end
do -- bitwise_and 560
 local a=np.array({5,1,3,63,127},np.uint8)
 local b=np.array({-1,-3,7,15,7},np.int8)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='int16','bitwise_and dtype 560')
 assert(veq(r:tolist(),{5,1,3,15,7}),'bitwise_and values 560')
end
do -- bitwise_and 561
 local a=np.array({127,1,5,5,2},np.uint64)
 local b=np.array({15,3,63,63,3},np.uint32)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint64','bitwise_and dtype 561')
 assert(veq(r:tolist(),{15,1,5,5,2}),'bitwise_and values 561')
end
do -- bitwise_and type error 562
 local a=np.array({{-3,0,1},{-31,15,30}},np.int32)
 local b=np.array({{0,31,31}},np.uint64)
 local ok=pcall(function() return np.bitwise_and(a,b) end)
 assert(not ok,'bitwise_and error 562')
end
do -- bitwise_and type error 563
 local a=np.array({7,1,7,30,7},np.int8)
 local b=np.array({7,31,127,63,31},np.uint64)
 local ok=pcall(function() return np.bitwise_and(a,b) end)
 assert(not ok,'bitwise_and error 563')
end
do -- bitwise_and 564
 local a=np.array({{31,127,2},{127,3,3}},np.uint8)
 local b=np.array({{15,31,3}},np.uint16)
 local r=np.bitwise_and(a,b)
 assert(r.dtype=='uint16','bitwise_and dtype 564')
 assert(veq(r:tolist(),{{15,31,2},{15,3,3}}),'bitwise_and values 564')
end
do -- bitwise_or 565
 local a=np.array({{127,0,63},{15,7,2}},np.uint8)
 local b=np.array({{15,31,31}},np.uint16)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint16','bitwise_or dtype 565')
 assert(veq(r:tolist(),{{127,31,63},{15,31,31}}),'bitwise_or values 565')
end
do -- bitwise_or 566
 local a=np.array({{true,true,false},{false,true,false}},np.bool)
 local b=np.array({1,15,2},np.uint8)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint8','bitwise_or dtype 566')
 assert(veq(r:tolist(),{{1,15,2},{1,15,2}}),'bitwise_or values 566')
end
do -- bitwise_or 567
 local a=np.array({{2,2,30},{2,7,-31}},np.int16)
 local b=np.array({{-31,7,-3}},np.int32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int32','bitwise_or dtype 567')
 assert(veq(r:tolist(),{{-29,7,-1},{-29,7,-3}}),'bitwise_or values 567')
end
do -- bitwise_or 568
 local a=np.array({{15,3,15},{0,2,1}},np.uint8)
 local b=np.array({3,0,15},np.int8)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int16','bitwise_or dtype 568')
 assert(veq(r:tolist(),{{15,3,15},{3,2,15}}),'bitwise_or values 568')
end
do -- bitwise_or 569
 local a=np.array({-3,-31,15,2,0},np.int16)
 local b=np.array({7,7,2,7,7},np.uint8)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int16','bitwise_or dtype 569')
 assert(veq(r:tolist(),{-1,-25,15,7,7}),'bitwise_or values 569')
end
do -- bitwise_or 570
 local a=np.array({{2},{3}},np.uint64)
 local b=np.array({{127,127,31}},np.uint32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint64','bitwise_or dtype 570')
 assert(veq(r:tolist(),{{127,127,31},{127,127,31}}),'bitwise_or values 570')
end
do -- bitwise_or 571
 local a=np.array({{0},{2}},np.uint16)
 local b=np.array({{31,0,2}},np.uint16)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint16','bitwise_or dtype 571')
 assert(veq(r:tolist(),{{31,0,2},{31,2,2}}),'bitwise_or values 571')
end
do -- bitwise_or 572
 local a=np.array({{63,1,31},{127,127,3}},np.uint32)
 local b=np.array({3,7,-9},np.int64)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int64','bitwise_or dtype 572')
 assert(veq(r:tolist(),{{63,7,-1},{127,127,-9}}),'bitwise_or values 572')
end
do -- bitwise_or 573
 local a=np.array({{31},{2}},np.uint64)
 local b=np.array({{7,2,127}},np.uint8)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint64','bitwise_or dtype 573')
 assert(veq(r:tolist(),{{31,31,127},{7,2,127}}),'bitwise_or values 573')
end
do -- bitwise_or type error 574
 local a=np.array({{3},{31}},np.uint64)
 local b=np.array({{0,15,15}},np.int32)
 local ok=pcall(function() return np.bitwise_or(a,b) end)
 assert(not ok,'bitwise_or error 574')
end
do -- bitwise_or 575
 local a=np.array({{-9},{-3}},np.int16)
 local b=np.array({{5,0,127}},np.uint32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int64','bitwise_or dtype 575')
 assert(veq(r:tolist(),{{-9,-9,-1},{-3,-3,-1}}),'bitwise_or values 575')
end
do -- bitwise_or 576
 local a=np.array({0,127,127,7,3},np.uint8)
 local b=np.array({-31,-3,30,2,-1},np.int16)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int16','bitwise_or dtype 576')
 assert(veq(r:tolist(),{-31,-1,127,7,-1}),'bitwise_or values 576')
end
do -- bitwise_or 577
 local a=np.array({{-9},{-31}},np.int32)
 local b=np.array({{15,2,0}},np.int16)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int32','bitwise_or dtype 577')
 assert(veq(r:tolist(),{{-1,-9,-9},{-17,-29,-31}}),'bitwise_or values 577')
end
do -- bitwise_or 578
 local a=np.array({15,127,3,0,7},np.uint8)
 local b=np.array({-3,-1,15,15,7},np.int64)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int64','bitwise_or dtype 578')
 assert(veq(r:tolist(),{-1,-1,15,15,7}),'bitwise_or values 578')
end
do -- bitwise_or 579
 local a=np.array({{-31,-1,15},{30,7,1}},np.int16)
 local b=np.array({{2,-1,-9}},np.int16)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int16','bitwise_or dtype 579')
 assert(veq(r:tolist(),{{-29,-1,-1},{30,-1,-9}}),'bitwise_or values 579')
end
do -- bitwise_or 580
 local a=np.array({7,63,1,15,15},np.uint32)
 local b=np.array({true,false,false,false,true},np.bool)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint32','bitwise_or dtype 580')
 assert(veq(r:tolist(),{7,63,1,15,15}),'bitwise_or values 580')
end
do -- bitwise_or type error 581
 local a=np.array({{15,30,-3},{1,15,-3}},np.int8)
 local b=np.array({31,1,15},np.uint64)
 local ok=pcall(function() return np.bitwise_or(a,b) end)
 assert(not ok,'bitwise_or error 581')
end
do -- bitwise_or 582
 local a=np.array({{7,63,3},{3,1,127}},np.uint8)
 local b=np.array({-9,3,2},np.int8)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int16','bitwise_or dtype 582')
 assert(veq(r:tolist(),{{-9,63,3},{-9,3,127}}),'bitwise_or values 582')
end
do -- bitwise_or 583
 local a=np.array({{2},{-9}},np.int64)
 local b=np.array({{7,3,127}},np.uint16)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int64','bitwise_or dtype 583')
 assert(veq(r:tolist(),{{7,3,127},{-9,-9,-1}}),'bitwise_or values 583')
end
do -- bitwise_or 584
 local a=np.array({127,0,7,31,7},np.uint16)
 local b=np.array({3,31,15,2,0},np.uint64)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint64','bitwise_or dtype 584')
 assert(veq(r:tolist(),{127,31,15,31,7}),'bitwise_or values 584')
end
do -- bitwise_or 585
 local a=np.array({{15,1,7},{0,2,-9}},np.int64)
 local b=np.array({{127,5,2}},np.uint32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int64','bitwise_or dtype 585')
 assert(veq(r:tolist(),{{127,5,7},{127,7,-9}}),'bitwise_or values 585')
end
do -- bitwise_or 586
 local a=np.array({{127},{63}},np.uint8)
 local b=np.array({{-1,2,2}},np.int16)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int16','bitwise_or dtype 586')
 assert(veq(r:tolist(),{{-1,127,127},{-1,63,63}}),'bitwise_or values 586')
end
do -- bitwise_or type error 587
 local a=np.array({{-9},{7}},np.int32)
 local b=np.array({{2,15,63}},np.uint64)
 local ok=pcall(function() return np.bitwise_or(a,b) end)
 assert(not ok,'bitwise_or error 587')
end
do -- bitwise_or 588
 local a=np.array({{30},{30}},np.int64)
 local b=np.array({{-9,30,-3}},np.int8)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int64','bitwise_or dtype 588')
 assert(veq(r:tolist(),{{-1,30,-1},{-1,30,-1}}),'bitwise_or values 588')
end
do -- bitwise_or 589
 local a=np.array({{31,7,127},{2,127,2}},np.uint16)
 local b=np.array({3,0,127},np.uint32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint32','bitwise_or dtype 589')
 assert(veq(r:tolist(),{{31,7,127},{3,127,127}}),'bitwise_or values 589')
end
do -- bitwise_or 590
 local a=np.array({{-1,-1,-3},{1,2,-31}},np.int32)
 local b=np.array({{2,-31,0}},np.int8)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int32','bitwise_or dtype 590')
 assert(veq(r:tolist(),{{-1,-1,-3},{3,-29,-31}}),'bitwise_or values 590')
end
do -- bitwise_or 591
 local a=np.array({{63},{127}},np.uint16)
 local b=np.array({{-1,0,1}},np.int64)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int64','bitwise_or dtype 591')
 assert(veq(r:tolist(),{{-1,63,63},{-1,127,127}}),'bitwise_or values 591')
end
do -- bitwise_or 592
 local a=np.array({2,1,63,63,7},np.uint8)
 local b=np.array({15,15,7,31,1},np.uint32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint32','bitwise_or dtype 592')
 assert(veq(r:tolist(),{15,15,63,63,7}),'bitwise_or values 592')
end
do -- bitwise_or 593
 local a=np.array({{true,false,true},{false,false,true}},np.bool)
 local b=np.array({0,2,15},np.uint16)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint16','bitwise_or dtype 593')
 assert(veq(r:tolist(),{{1,2,15},{0,2,15}}),'bitwise_or values 593')
end
do -- bitwise_or 594
 local a=np.array({7,15,63,7,7},np.uint32)
 local b=np.array({63,31,31,31,1},np.uint8)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint32','bitwise_or dtype 594')
 assert(veq(r:tolist(),{63,31,63,31,7}),'bitwise_or values 594')
end
do -- bitwise_or 595
 local a=np.array({{false},{true}},np.bool)
 local b=np.array({{1,1,63}},np.uint8)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint8','bitwise_or dtype 595')
 assert(veq(r:tolist(),{{1,1,63},{1,1,63}}),'bitwise_or values 595')
end
do -- bitwise_or 596
 local a=np.array({7,3,0,-1,30},np.int32)
 local b=np.array({-31,15,1,2,15},np.int64)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int64','bitwise_or dtype 596')
 assert(veq(r:tolist(),{-25,15,1,-1,31}),'bitwise_or values 596')
end
do -- bitwise_or 597
 local a=np.array({3,1,1,63,3},np.uint16)
 local b=np.array({0,31,63,0,31},np.uint32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint32','bitwise_or dtype 597')
 assert(veq(r:tolist(),{3,31,63,63,31}),'bitwise_or values 597')
end
do -- bitwise_or 598
 local a=np.array({{2,63,5},{63,31,15}},np.uint8)
 local b=np.array({{5,127,31}},np.uint32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint32','bitwise_or dtype 598')
 assert(veq(r:tolist(),{{7,127,31},{63,127,31}}),'bitwise_or values 598')
end
do -- bitwise_or 599
 local a=np.array({{0},{3}},np.uint32)
 local b=np.array({{63,7,0}},np.uint8)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint32','bitwise_or dtype 599')
 assert(veq(r:tolist(),{{63,7,0},{63,7,3}}),'bitwise_or values 599')
end
do -- bitwise_or 600
 local a=np.array({{15,63,1},{127,127,2}},np.uint64)
 local b=np.array({{31,7,63}},np.uint32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint64','bitwise_or dtype 600')
 assert(veq(r:tolist(),{{31,63,63},{127,127,63}}),'bitwise_or values 600')
end
do -- bitwise_or 601
 local a=np.array({{-3},{0}},np.int32)
 local b=np.array({{false,false,false}},np.bool)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int32','bitwise_or dtype 601')
 assert(veq(r:tolist(),{{-3,-3,-3},{0,0,0}}),'bitwise_or values 601')
end
do -- bitwise_or 602
 local a=np.array({31,3,63,0,5},np.uint64)
 local b=np.array({2,2,63,0,7},np.uint32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint64','bitwise_or dtype 602')
 assert(veq(r:tolist(),{31,3,63,0,7}),'bitwise_or values 602')
end
do -- bitwise_or 603
 local a=np.array({{31},{63}},np.uint32)
 local b=np.array({{true,true,false}},np.bool)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint32','bitwise_or dtype 603')
 assert(veq(r:tolist(),{{31,31,31},{63,63,63}}),'bitwise_or values 603')
end
do -- bitwise_or 604
 local a=np.array({7,15,3,3,1},np.int16)
 local b=np.array({-31,3,30,2,1},np.int8)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int16','bitwise_or dtype 604')
 assert(veq(r:tolist(),{-25,15,31,3,1}),'bitwise_or values 604')
end
do -- bitwise_or 605
 local a=np.array({{127},{5}},np.uint8)
 local b=np.array({{true,true,true}},np.bool)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint8','bitwise_or dtype 605')
 assert(veq(r:tolist(),{{127,127,127},{5,5,5}}),'bitwise_or values 605')
end
do -- bitwise_or 606
 local a=np.array({{15,-9,30},{30,2,7}},np.int8)
 local b=np.array({{-9,3,30}},np.int32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int32','bitwise_or dtype 606')
 assert(veq(r:tolist(),{{-1,-9,30},{-1,3,31}}),'bitwise_or values 606')
end
do -- bitwise_or 607
 local a=np.array({31,3,0,5,15},np.uint32)
 local b=np.array({30,0,15,1,30},np.int32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int64','bitwise_or dtype 607')
 assert(veq(r:tolist(),{31,3,15,5,31}),'bitwise_or values 607')
end
do -- bitwise_or 608
 local a=np.array({{3},{-31}},np.int64)
 local b=np.array({{31,3,2}},np.uint8)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int64','bitwise_or dtype 608')
 assert(veq(r:tolist(),{{31,3,3},{-1,-29,-29}}),'bitwise_or values 608')
end
do -- bitwise_or type error 609
 local a=np.array({{1,7,3},{7,3,15}},np.uint64)
 local b=np.array({-1,7,-3},np.int16)
 local ok=pcall(function() return np.bitwise_or(a,b) end)
 assert(not ok,'bitwise_or error 609')
end
do -- bitwise_or 610
 local a=np.array({{7,7,30},{-1,0,-9}},np.int32)
 local b=np.array({{3,-3,2}},np.int8)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int32','bitwise_or dtype 610')
 assert(veq(r:tolist(),{{7,-1,30},{-1,-3,-9}}),'bitwise_or values 610')
end
do -- bitwise_or type error 611
 local a=np.array({{-31},{0}},np.int8)
 local b=np.array({{31,3,31}},np.uint64)
 local ok=pcall(function() return np.bitwise_or(a,b) end)
 assert(not ok,'bitwise_or error 611')
end
do -- bitwise_or 612
 local a=np.array({5,127,127,31,1},np.uint16)
 local b=np.array({3,0,31,3,5},np.uint16)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint16','bitwise_or dtype 612')
 assert(veq(r:tolist(),{7,127,127,31,5}),'bitwise_or values 612')
end
do -- bitwise_or 613
 local a=np.array({{1,31,31},{0,2,2}},np.uint8)
 local b=np.array({{15,1,31}},np.uint8)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint8','bitwise_or dtype 613')
 assert(veq(r:tolist(),{{15,31,31},{15,3,31}}),'bitwise_or values 613')
end
do -- bitwise_or 614
 local a=np.array({{5,15,5},{63,1,15}},np.uint32)
 local b=np.array({{63,1,31}},np.uint64)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint64','bitwise_or dtype 614')
 assert(veq(r:tolist(),{{63,15,31},{63,1,31}}),'bitwise_or values 614')
end
do -- bitwise_or 615
 local a=np.array({{3,-1,1},{7,-1,30}},np.int16)
 local b=np.array({{1,7,31}},np.uint16)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int32','bitwise_or dtype 615')
 assert(veq(r:tolist(),{{3,-1,31},{7,-1,31}}),'bitwise_or values 615')
end
do -- bitwise_or 616
 local a=np.array({{false},{false}},np.bool)
 local b=np.array({{0,7,0}},np.uint16)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint16','bitwise_or dtype 616')
 assert(veq(r:tolist(),{{0,7,0},{0,7,0}}),'bitwise_or values 616')
end
do -- bitwise_or 617
 local a=np.array({7,0,7,127,15},np.uint8)
 local b=np.array({15,0,31,0,5},np.uint16)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint16','bitwise_or dtype 617')
 assert(veq(r:tolist(),{15,0,31,127,15}),'bitwise_or values 617')
end
do -- bitwise_or 618
 local a=np.array({{1,127,2},{127,15,3}},np.uint16)
 local b=np.array({0,63,15},np.uint16)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint16','bitwise_or dtype 618')
 assert(veq(r:tolist(),{{1,127,15},{127,63,15}}),'bitwise_or values 618')
end
do -- bitwise_or 619
 local a=np.array({63,1,15,63,31},np.uint64)
 local b=np.array({0,3,2,127,0},np.uint16)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint64','bitwise_or dtype 619')
 assert(veq(r:tolist(),{63,3,15,127,31}),'bitwise_or values 619')
end
do -- bitwise_or 620
 local a=np.array({7,2,-1,30,-9},np.int8)
 local b=np.array({15,-9,1,7,0},np.int32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int32','bitwise_or dtype 620')
 assert(veq(r:tolist(),{15,-9,-1,31,-9}),'bitwise_or values 620')
end
do -- bitwise_or 621
 local a=np.array({{63,0,127},{31,7,1}},np.uint16)
 local b=np.array({-9,2,2},np.int32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int32','bitwise_or dtype 621')
 assert(veq(r:tolist(),{{-1,2,127},{-1,7,3}}),'bitwise_or values 621')
end
do -- bitwise_or 622
 local a=np.array({{true},{false}},np.bool)
 local b=np.array({{-9,3,-3}},np.int32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int32','bitwise_or dtype 622')
 assert(veq(r:tolist(),{{-9,3,-3},{-9,3,-3}}),'bitwise_or values 622')
end
do -- bitwise_or 623
 local a=np.array({{2},{3}},np.uint8)
 local b=np.array({{5,31,5}},np.uint8)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint8','bitwise_or dtype 623')
 assert(veq(r:tolist(),{{7,31,7},{7,31,7}}),'bitwise_or values 623')
end
do -- bitwise_or 624
 local a=np.array({{-3},{-3}},np.int16)
 local b=np.array({{3,-3,-3}},np.int16)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int16','bitwise_or dtype 624')
 assert(veq(r:tolist(),{{-1,-3,-3},{-1,-3,-3}}),'bitwise_or values 624')
end
do -- bitwise_or type error 625
 local a=np.array({{-1,30,-9},{2,-31,3}},np.int8)
 local b=np.array({{5,3,15}},np.uint64)
 local ok=pcall(function() return np.bitwise_or(a,b) end)
 assert(not ok,'bitwise_or error 625')
end
do -- bitwise_or 626
 local a=np.array({5,0,31,63,15},np.uint32)
 local b=np.array({1,63,2,1,7},np.uint16)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint32','bitwise_or dtype 626')
 assert(veq(r:tolist(),{5,63,31,63,15}),'bitwise_or values 626')
end
do -- bitwise_or 627
 local a=np.array({30,0,2,-31,-1},np.int32)
 local b=np.array({15,-9,7,1,1},np.int16)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int32','bitwise_or dtype 627')
 assert(veq(r:tolist(),{31,-9,7,-31,-1}),'bitwise_or values 627')
end
do -- bitwise_or 628
 local a=np.array({{30,-31,1},{-3,3,1}},np.int16)
 local b=np.array({{-31,2,1}},np.int16)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int16','bitwise_or dtype 628')
 assert(veq(r:tolist(),{{-1,-29,1},{-3,3,1}}),'bitwise_or values 628')
end
do -- bitwise_or type error 629
 local a=np.array({{127},{127}},np.uint64)
 local b=np.array({{30,15,3}},np.int32)
 local ok=pcall(function() return np.bitwise_or(a,b) end)
 assert(not ok,'bitwise_or error 629')
end
do -- bitwise_or 630
 local a=np.array({{15},{0}},np.uint16)
 local b=np.array({{0,3,3}},np.int8)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int32','bitwise_or dtype 630')
 assert(veq(r:tolist(),{{15,15,15},{0,3,3}}),'bitwise_or values 630')
end
do -- bitwise_or type error 631
 local a=np.array({15,30,-9,1,30},np.int16)
 local b=np.array({7,5,0,127,63},np.uint64)
 local ok=pcall(function() return np.bitwise_or(a,b) end)
 assert(not ok,'bitwise_or error 631')
end
do -- bitwise_or 632
 local a=np.array({false,false,false,true,false},np.bool)
 local b=np.array({0,15,63,63,2},np.uint32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint32','bitwise_or dtype 632')
 assert(veq(r:tolist(),{0,15,63,63,2}),'bitwise_or values 632')
end
do -- bitwise_or 633
 local a=np.array({5,0,1,7,31},np.uint8)
 local b=np.array({31,63,15,127,127},np.uint32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint32','bitwise_or dtype 633')
 assert(veq(r:tolist(),{31,63,15,127,127}),'bitwise_or values 633')
end
do -- bitwise_or 634
 local a=np.array({0,31,1,7,127},np.uint8)
 local b=np.array({15,127,127,5,7},np.uint8)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint8','bitwise_or dtype 634')
 assert(veq(r:tolist(),{15,127,127,7,127}),'bitwise_or values 634')
end
do -- bitwise_or 635
 local a=np.array({{1,127,31},{3,15,0}},np.uint8)
 local b=np.array({15,-3,-9},np.int32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int32','bitwise_or dtype 635')
 assert(veq(r:tolist(),{{15,-1,-1},{15,-1,-9}}),'bitwise_or values 635')
end
do -- bitwise_or 636
 local a=np.array({{1},{-9}},np.int64)
 local b=np.array({{true,true,true}},np.bool)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int64','bitwise_or dtype 636')
 assert(veq(r:tolist(),{{1,1,1},{-9,-9,-9}}),'bitwise_or values 636')
end
do -- bitwise_or 637
 local a=np.array({{false,true,true},{false,false,true}},np.bool)
 local b=np.array({{false,true,false}},np.bool)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='bool','bitwise_or dtype 637')
 assert(veq(r:tolist(),{{false,true,true},{false,true,true}}),'bitwise_or values 637')
end
do -- bitwise_or 638
 local a=np.array({{3,0,15},{127,7,3}},np.uint8)
 local b=np.array({0,-9,7},np.int64)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int64','bitwise_or dtype 638')
 assert(veq(r:tolist(),{{3,-9,15},{127,-9,7}}),'bitwise_or values 638')
end
do -- bitwise_or 639
 local a=np.array({0,5,3,15,15},np.uint32)
 local b=np.array({2,3,2,63,5},np.uint8)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint32','bitwise_or dtype 639')
 assert(veq(r:tolist(),{2,7,3,63,15}),'bitwise_or values 639')
end
do -- bitwise_or 640
 local a=np.array({31,15,5,0,31},np.uint64)
 local b=np.array({63,2,3,127,0},np.uint32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint64','bitwise_or dtype 640')
 assert(veq(r:tolist(),{63,15,7,127,31}),'bitwise_or values 640')
end
do -- bitwise_or 641
 local a=np.array({{-31},{0}},np.int64)
 local b=np.array({{1,2,15}},np.uint32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int64','bitwise_or dtype 641')
 assert(veq(r:tolist(),{{-31,-29,-17},{1,2,15}}),'bitwise_or values 641')
end
do -- bitwise_or type error 642
 local a=np.array({{5},{5}},np.uint64)
 local b=np.array({{3,1,-9}},np.int8)
 local ok=pcall(function() return np.bitwise_or(a,b) end)
 assert(not ok,'bitwise_or error 642')
end
do -- bitwise_or 643
 local a=np.array({{7,63,3},{1,0,0}},np.uint16)
 local b=np.array({7,0,1},np.int8)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int32','bitwise_or dtype 643')
 assert(veq(r:tolist(),{{7,63,3},{7,0,1}}),'bitwise_or values 643')
end
do -- bitwise_or 644
 local a=np.array({0,0,1,31,3},np.uint32)
 local b=np.array({63,5,2,31,15},np.uint64)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint64','bitwise_or dtype 644')
 assert(veq(r:tolist(),{63,5,3,31,15}),'bitwise_or values 644')
end
do -- bitwise_or 645
 local a=np.array({-9,0,-1,-9,30},np.int8)
 local b=np.array({7,30,15,3,-31},np.int16)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int16','bitwise_or dtype 645')
 assert(veq(r:tolist(),{-9,30,-1,-9,-1}),'bitwise_or values 645')
end
do -- bitwise_or type error 646
 local a=np.array({{63},{1}},np.uint64)
 local b=np.array({{3,2,-9}},np.int8)
 local ok=pcall(function() return np.bitwise_or(a,b) end)
 assert(not ok,'bitwise_or error 646')
end
do -- bitwise_or 647
 local a=np.array({3,1,127,63,7},np.uint16)
 local b=np.array({true,true,true,true,true},np.bool)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint16','bitwise_or dtype 647')
 assert(veq(r:tolist(),{3,1,127,63,7}),'bitwise_or values 647')
end
do -- bitwise_or 648
 local a=np.array({{7,63,15},{31,15,7}},np.uint8)
 local b=np.array({{31,5,5}},np.uint64)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint64','bitwise_or dtype 648')
 assert(veq(r:tolist(),{{31,63,15},{31,15,7}}),'bitwise_or values 648')
end
do -- bitwise_or 649
 local a=np.array({{false,false,true},{true,false,true}},np.bool)
 local b=np.array({{2,30,1}},np.int32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int32','bitwise_or dtype 649')
 assert(veq(r:tolist(),{{2,30,1},{3,30,1}}),'bitwise_or values 649')
end
do -- bitwise_or 650
 local a=np.array({3,63,15,1,1},np.uint64)
 local b=np.array({true,false,true,false,false},np.bool)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint64','bitwise_or dtype 650')
 assert(veq(r:tolist(),{3,63,15,1,1}),'bitwise_or values 650')
end
do -- bitwise_or 651
 local a=np.array({{0},{3}},np.int16)
 local b=np.array({{true,true,true}},np.bool)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int16','bitwise_or dtype 651')
 assert(veq(r:tolist(),{{1,1,1},{3,3,3}}),'bitwise_or values 651')
end
do -- bitwise_or 652
 local a=np.array({{15},{7}},np.int64)
 local b=np.array({{5,3,2}},np.uint32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='int64','bitwise_or dtype 652')
 assert(veq(r:tolist(),{{15,15,15},{7,7,7}}),'bitwise_or values 652')
end
do -- bitwise_or 653
 local a=np.array({{0,2,5},{7,15,3}},np.uint8)
 local b=np.array({{0,5,127}},np.uint32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint32','bitwise_or dtype 653')
 assert(veq(r:tolist(),{{0,7,127},{7,15,127}}),'bitwise_or values 653')
end
do -- bitwise_or 654
 local a=np.array({0,5,7,63,1},np.uint8)
 local b=np.array({127,63,63,7,7},np.uint32)
 local r=np.bitwise_or(a,b)
 assert(r.dtype=='uint32','bitwise_or dtype 654')
 assert(veq(r:tolist(),{127,63,63,63,7}),'bitwise_or values 654')
end
do -- bitwise_xor 655
 local a=np.array({1,15,30,30,0},np.int8)
 local b=np.array({-31,3,-1,-3,2},np.int8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int8','bitwise_xor dtype 655')
 assert(veq(r:tolist(),{-32,12,-31,-29,2}),'bitwise_xor values 655')
end
do -- bitwise_xor 656
 local a=np.array({{63},{1}},np.uint16)
 local b=np.array({{1,2,1}},np.uint32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint32','bitwise_xor dtype 656')
 assert(veq(r:tolist(),{{62,61,62},{0,3,0}}),'bitwise_xor values 656')
end
do -- bitwise_xor 657
 local a=np.array({-9,1,1,30,0},np.int64)
 local b=np.array({-1,1,-31,2,7},np.int8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int64','bitwise_xor dtype 657')
 assert(veq(r:tolist(),{8,0,-32,28,7}),'bitwise_xor values 657')
end
do -- bitwise_xor 658
 local a=np.array({3,30,7,2,2},np.int16)
 local b=np.array({3,2,0,1,3},np.uint8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int16','bitwise_xor dtype 658')
 assert(veq(r:tolist(),{0,28,7,3,1}),'bitwise_xor values 658')
end
do -- bitwise_xor 659
 local a=np.array({{1,-1,2},{15,-31,7}},np.int32)
 local b=np.array({{-3,-31,-31}},np.int32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int32','bitwise_xor dtype 659')
 assert(veq(r:tolist(),{{-4,30,-29},{-14,0,-26}}),'bitwise_xor values 659')
end
do -- bitwise_xor 660
 local a=np.array({{63,7,15},{15,63,1}},np.uint16)
 local b=np.array({true,true,false},np.bool)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint16','bitwise_xor dtype 660')
 assert(veq(r:tolist(),{{62,6,15},{14,62,1}}),'bitwise_xor values 660')
end
do -- bitwise_xor 661
 local a=np.array({{true},{true}},np.bool)
 local b=np.array({{-3,-1,-31}},np.int64)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int64','bitwise_xor dtype 661')
 assert(veq(r:tolist(),{{-4,-2,-32},{-4,-2,-32}}),'bitwise_xor values 661')
end
do -- bitwise_xor 662
 local a=np.array({2,30,30,-31,-9},np.int32)
 local b=np.array({0,2,7,1,63},np.uint16)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int32','bitwise_xor dtype 662')
 assert(veq(r:tolist(),{2,28,25,-32,-56}),'bitwise_xor values 662')
end
do -- bitwise_xor 663
 local a=np.array({31,7,7,63,0},np.uint32)
 local b=np.array({15,3,31,2,3},np.uint64)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint64','bitwise_xor dtype 663')
 assert(veq(r:tolist(),{16,4,24,61,3}),'bitwise_xor values 663')
end
do -- bitwise_xor 664
 local a=np.array({{5,15,7},{127,63,3}},np.uint64)
 local b=np.array({{7,15,7}},np.uint64)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint64','bitwise_xor dtype 664')
 assert(veq(r:tolist(),{{2,0,0},{120,48,4}}),'bitwise_xor values 664')
end
do -- bitwise_xor 665
 local a=np.array({{2},{-1}},np.int64)
 local b=np.array({{2,15,0}},np.uint16)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int64','bitwise_xor dtype 665')
 assert(veq(r:tolist(),{{0,13,2},{-3,-16,-1}}),'bitwise_xor values 665')
end
do -- bitwise_xor 666
 local a=np.array({{5,2,31},{15,1,7}},np.uint32)
 local b=np.array({-31,3,1},np.int8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int64','bitwise_xor dtype 666')
 assert(veq(r:tolist(),{{-28,1,30},{-18,2,6}}),'bitwise_xor values 666')
end
do -- bitwise_xor type error 667
 local a=np.array({{5,31,1},{15,63,5}},np.uint64)
 local b=np.array({1,-3,3},np.int16)
 local ok=pcall(function() return np.bitwise_xor(a,b) end)
 assert(not ok,'bitwise_xor error 667')
end
do -- bitwise_xor 668
 local a=np.array({{3,5,7},{5,7,15}},np.uint32)
 local b=np.array({{-31,-31,-9}},np.int32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int64','bitwise_xor dtype 668')
 assert(veq(r:tolist(),{{-30,-28,-16},{-28,-26,-8}}),'bitwise_xor values 668')
end
do -- bitwise_xor type error 669
 local a=np.array({{-3,30,0},{2,0,2}},np.int8)
 local b=np.array({{0,31,1}},np.uint64)
 local ok=pcall(function() return np.bitwise_xor(a,b) end)
 assert(not ok,'bitwise_xor error 669')
end
do -- bitwise_xor 670
 local a=np.array({{63,127,63},{31,2,63}},np.uint32)
 local b=np.array({{3,127,1}},np.uint32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint32','bitwise_xor dtype 670')
 assert(veq(r:tolist(),{{60,0,62},{28,125,62}}),'bitwise_xor values 670')
end
do -- bitwise_xor 671
 local a=np.array({{-9,2,-31},{7,7,-3}},np.int8)
 local b=np.array({7,3,15},np.int64)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int64','bitwise_xor dtype 671')
 assert(veq(r:tolist(),{{-16,1,-18},{0,4,-14}}),'bitwise_xor values 671')
end
do -- bitwise_xor 672
 local a=np.array({{3},{15}},np.int8)
 local b=np.array({{2,1,31}},np.uint8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int16','bitwise_xor dtype 672')
 assert(veq(r:tolist(),{{1,2,28},{13,14,16}}),'bitwise_xor values 672')
end
do -- bitwise_xor type error 673
 local a=np.array({{0,127,31},{5,127,127}},np.uint64)
 local b=np.array({{30,3,2}},np.int32)
 local ok=pcall(function() return np.bitwise_xor(a,b) end)
 assert(not ok,'bitwise_xor error 673')
end
do -- bitwise_xor 674
 local a=np.array({3,-1,-9,7,2},np.int64)
 local b=np.array({5,0,0,5,63},np.uint32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int64','bitwise_xor dtype 674')
 assert(veq(r:tolist(),{6,-1,-9,2,61}),'bitwise_xor values 674')
end
do -- bitwise_xor 675
 local a=np.array({15,2,30,2,0},np.int16)
 local b=np.array({1,-1,-3,-9,-1},np.int64)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int64','bitwise_xor dtype 675')
 assert(veq(r:tolist(),{14,-3,-29,-11,-1}),'bitwise_xor values 675')
end
do -- bitwise_xor 676
 local a=np.array({{30,7,3},{-9,3,-9}},np.int64)
 local b=np.array({{1,-9,2}},np.int64)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int64','bitwise_xor dtype 676')
 assert(veq(r:tolist(),{{31,-16,1},{-10,-12,-11}}),'bitwise_xor values 676')
end
do -- bitwise_xor 677
 local a=np.array({{false},{false}},np.bool)
 local b=np.array({{31,7,1}},np.uint16)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint16','bitwise_xor dtype 677')
 assert(veq(r:tolist(),{{31,7,1},{31,7,1}}),'bitwise_xor values 677')
end
do -- bitwise_xor 678
 local a=np.array({-1,2,0,7,-1},np.int16)
 local b=np.array({127,31,15,5,7},np.uint32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int64','bitwise_xor dtype 678')
 assert(veq(r:tolist(),{-128,29,15,2,-8}),'bitwise_xor values 678')
end
do -- bitwise_xor 679
 local a=np.array({{3},{7}},np.uint8)
 local b=np.array({{63,0,3}},np.uint32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint32','bitwise_xor dtype 679')
 assert(veq(r:tolist(),{{60,3,0},{56,7,4}}),'bitwise_xor values 679')
end
do -- bitwise_xor 680
 local a=np.array({{31,1,2},{0,15,2}},np.uint16)
 local b=np.array({1,7,1},np.uint16)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint16','bitwise_xor dtype 680')
 assert(veq(r:tolist(),{{30,6,3},{1,8,3}}),'bitwise_xor values 680')
end
do -- bitwise_xor 681
 local a=np.array({{0,3,3},{0,-31,-1}},np.int64)
 local b=np.array({30,7,-31},np.int64)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int64','bitwise_xor dtype 681')
 assert(veq(r:tolist(),{{30,4,-30},{30,-26,30}}),'bitwise_xor values 681')
end
do -- bitwise_xor type error 682
 local a=np.array({{-3,-31,-31},{0,7,2}},np.int16)
 local b=np.array({63,15,2},np.uint64)
 local ok=pcall(function() return np.bitwise_xor(a,b) end)
 assert(not ok,'bitwise_xor error 682')
end
do -- bitwise_xor 683
 local a=np.array({{-9,-31,-9},{-31,2,-31}},np.int16)
 local b=np.array({0,-3,2},np.int32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int32','bitwise_xor dtype 683')
 assert(veq(r:tolist(),{{-9,28,-11},{-31,-1,-29}}),'bitwise_xor values 683')
end
do -- bitwise_xor 684
 local a=np.array({15,2,0,0,1},np.uint8)
 local b=np.array({true,false,true,false,false},np.bool)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint8','bitwise_xor dtype 684')
 assert(veq(r:tolist(),{14,2,1,0,1}),'bitwise_xor values 684')
end
do -- bitwise_xor 685
 local a=np.array({{0,63,5},{5,31,3}},np.uint32)
 local b=np.array({{true,false,false}},np.bool)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint32','bitwise_xor dtype 685')
 assert(veq(r:tolist(),{{1,63,5},{4,31,3}}),'bitwise_xor values 685')
end
do -- bitwise_xor 686
 local a=np.array({{30},{30}},np.int32)
 local b=np.array({{15,7,3}},np.uint32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int64','bitwise_xor dtype 686')
 assert(veq(r:tolist(),{{17,25,29},{17,25,29}}),'bitwise_xor values 686')
end
do -- bitwise_xor 687
 local a=np.array({{2,-9,30},{-1,2,15}},np.int32)
 local b=np.array({127,2,1},np.uint16)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int32','bitwise_xor dtype 687')
 assert(veq(r:tolist(),{{125,-11,31},{-128,0,14}}),'bitwise_xor values 687')
end
do -- bitwise_xor 688
 local a=np.array({{-31,7,3},{2,-31,-3}},np.int32)
 local b=np.array({{15,63,3}},np.uint8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int32','bitwise_xor dtype 688')
 assert(veq(r:tolist(),{{-18,56,0},{13,-34,-2}}),'bitwise_xor values 688')
end
do -- bitwise_xor 689
 local a=np.array({true,false,true,true,true},np.bool)
 local b=np.array({1,30,1,2,30},np.int32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int32','bitwise_xor dtype 689')
 assert(veq(r:tolist(),{0,30,0,3,31}),'bitwise_xor values 689')
end
do -- bitwise_xor 690
 local a=np.array({{2},{2}},np.uint8)
 local b=np.array({{0,1,5}},np.uint8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint8','bitwise_xor dtype 690')
 assert(veq(r:tolist(),{{2,3,7},{2,3,7}}),'bitwise_xor values 690')
end
do -- bitwise_xor 691
 local a=np.array({true,false,false,false,true},np.bool)
 local b=np.array({3,5,2,127,15},np.uint8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint8','bitwise_xor dtype 691')
 assert(veq(r:tolist(),{2,5,2,127,14}),'bitwise_xor values 691')
end
do -- bitwise_xor 692
 local a=np.array({{3,63,15},{31,7,5}},np.uint16)
 local b=np.array({15,0,15},np.int64)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int64','bitwise_xor dtype 692')
 assert(veq(r:tolist(),{{12,63,0},{16,7,10}}),'bitwise_xor values 692')
end
do -- bitwise_xor 693
 local a=np.array({{-9,2,-31},{30,-1,-3}},np.int16)
 local b=np.array({-31,15,30},np.int32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int32','bitwise_xor dtype 693')
 assert(veq(r:tolist(),{{22,13,-1},{-1,-16,-29}}),'bitwise_xor values 693')
end
do -- bitwise_xor 694
 local a=np.array({true,true,true,false,false},np.bool)
 local b=np.array({127,31,3,0,63},np.uint8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint8','bitwise_xor dtype 694')
 assert(veq(r:tolist(),{126,30,2,0,63}),'bitwise_xor values 694')
end
do -- bitwise_xor 695
 local a=np.array({{127,127,0},{0,31,5}},np.uint16)
 local b=np.array({15,15,2},np.uint32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint32','bitwise_xor dtype 695')
 assert(veq(r:tolist(),{{112,112,2},{15,16,7}}),'bitwise_xor values 695')
end
do -- bitwise_xor 696
 local a=np.array({0,1,-3,-3,-1},np.int16)
 local b=np.array({-9,30,1,30,-3},np.int8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int16','bitwise_xor dtype 696')
 assert(veq(r:tolist(),{-9,31,-4,-29,2}),'bitwise_xor values 696')
end
do -- bitwise_xor type error 697
 local a=np.array({0,127,7,31,3},np.uint64)
 local b=np.array({-31,-31,2,7,30},np.int16)
 local ok=pcall(function() return np.bitwise_xor(a,b) end)
 assert(not ok,'bitwise_xor error 697')
end
do -- bitwise_xor 698
 local a=np.array({{31,15,0},{7,3,1}},np.uint32)
 local b=np.array({31,15,1},np.uint64)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint64','bitwise_xor dtype 698')
 assert(veq(r:tolist(),{{0,0,1},{24,12,0}}),'bitwise_xor values 698')
end
do -- bitwise_xor 699
 local a=np.array({{-9,-1,-3},{-1,-9,15}},np.int32)
 local b=np.array({{false,false,true}},np.bool)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int32','bitwise_xor dtype 699')
 assert(veq(r:tolist(),{{-9,-1,-4},{-1,-9,14}}),'bitwise_xor values 699')
end
do -- bitwise_xor type error 700
 local a=np.array({{0,31,127},{2,3,127}},np.uint64)
 local b=np.array({{15,-9,-3}},np.int8)
 local ok=pcall(function() return np.bitwise_xor(a,b) end)
 assert(not ok,'bitwise_xor error 700')
end
do -- bitwise_xor 701
 local a=np.array({{0},{7}},np.uint32)
 local b=np.array({{2,0,7}},np.uint64)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint64','bitwise_xor dtype 701')
 assert(veq(r:tolist(),{{2,0,7},{5,7,0}}),'bitwise_xor values 701')
end
do -- bitwise_xor type error 702
 local a=np.array({{-1,7,2},{-3,7,2}},np.int64)
 local b=np.array({{5,2,1}},np.uint64)
 local ok=pcall(function() return np.bitwise_xor(a,b) end)
 assert(not ok,'bitwise_xor error 702')
end
do -- bitwise_xor 703
 local a=np.array({-1,-31,0,30,15},np.int8)
 local b=np.array({-3,15,7,1,2},np.int8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int8','bitwise_xor dtype 703')
 assert(veq(r:tolist(),{2,-18,7,31,13}),'bitwise_xor values 703')
end
do -- bitwise_xor type error 704
 local a=np.array({{7,1,3},{2,31,127}},np.uint64)
 local b=np.array({3,0,1},np.int8)
 local ok=pcall(function() return np.bitwise_xor(a,b) end)
 assert(not ok,'bitwise_xor error 704')
end
do -- bitwise_xor 705
 local a=np.array({false,false,true,true,true},np.bool)
 local b=np.array({7,-9,15,15,15},np.int8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int8','bitwise_xor dtype 705')
 assert(veq(r:tolist(),{7,-9,14,14,14}),'bitwise_xor values 705')
end
do -- bitwise_xor type error 706
 local a=np.array({{-31,2,-31},{30,-1,-3}},np.int32)
 local b=np.array({{31,3,127}},np.uint64)
 local ok=pcall(function() return np.bitwise_xor(a,b) end)
 assert(not ok,'bitwise_xor error 706')
end
do -- bitwise_xor 707
 local a=np.array({{1,5,0},{5,7,31}},np.uint32)
 local b=np.array({2,-31,30},np.int32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int64','bitwise_xor dtype 707')
 assert(veq(r:tolist(),{{3,-28,30},{7,-26,1}}),'bitwise_xor values 707')
end
do -- bitwise_xor 708
 local a=np.array({{0,7,1},{63,7,63}},np.uint32)
 local b=np.array({2,127,5},np.uint16)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint32','bitwise_xor dtype 708')
 assert(veq(r:tolist(),{{2,120,4},{61,120,58}}),'bitwise_xor values 708')
end
do -- bitwise_xor 709
 local a=np.array({{-9},{0}},np.int32)
 local b=np.array({{2,31,15}},np.uint8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int32','bitwise_xor dtype 709')
 assert(veq(r:tolist(),{{-11,-24,-8},{2,31,15}}),'bitwise_xor values 709')
end
do -- bitwise_xor 710
 local a=np.array({{1,0,2},{2,7,-31}},np.int8)
 local b=np.array({{15,30,-1}},np.int16)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int16','bitwise_xor dtype 710')
 assert(veq(r:tolist(),{{14,30,-3},{13,25,30}}),'bitwise_xor values 710')
end
do -- bitwise_xor 711
 local a=np.array({{true},{false}},np.bool)
 local b=np.array({{7,3,7}},np.uint16)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint16','bitwise_xor dtype 711')
 assert(veq(r:tolist(),{{6,2,6},{7,3,7}}),'bitwise_xor values 711')
end
do -- bitwise_xor 712
 local a=np.array({7,-3,-31,1,3},np.int32)
 local b=np.array({30,7,15,2,1},np.int16)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int32','bitwise_xor dtype 712')
 assert(veq(r:tolist(),{25,-6,-18,3,2}),'bitwise_xor values 712')
end
do -- bitwise_xor 713
 local a=np.array({1,1,30,-3,-3},np.int16)
 local b=np.array({5,127,63,63,63},np.uint8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int16','bitwise_xor dtype 713')
 assert(veq(r:tolist(),{4,126,33,-62,-62}),'bitwise_xor values 713')
end
do -- bitwise_xor 714
 local a=np.array({{30},{-31}},np.int8)
 local b=np.array({{-31,7,15}},np.int32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int32','bitwise_xor dtype 714')
 assert(veq(r:tolist(),{{-1,25,17},{0,-26,-18}}),'bitwise_xor values 714')
end
do -- bitwise_xor 715
 local a=np.array({{15,-3,30},{3,1,30}},np.int32)
 local b=np.array({{2,3,3}},np.int32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int32','bitwise_xor dtype 715')
 assert(veq(r:tolist(),{{13,-2,29},{1,2,29}}),'bitwise_xor values 715')
end
do -- bitwise_xor 716
 local a=np.array({{0},{63}},np.uint16)
 local b=np.array({{30,15,-31}},np.int32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int32','bitwise_xor dtype 716')
 assert(veq(r:tolist(),{{30,15,-31},{33,48,-34}}),'bitwise_xor values 716')
end
do -- bitwise_xor type error 717
 local a=np.array({2,-31,-9,15,-9},np.int16)
 local b=np.array({1,7,3,63,1},np.uint64)
 local ok=pcall(function() return np.bitwise_xor(a,b) end)
 assert(not ok,'bitwise_xor error 717')
end
do -- bitwise_xor 718
 local a=np.array({{30},{1}},np.int16)
 local b=np.array({{-9,-9,-31}},np.int8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int16','bitwise_xor dtype 718')
 assert(veq(r:tolist(),{{-23,-23,-1},{-10,-10,-32}}),'bitwise_xor values 718')
end
do -- bitwise_xor 719
 local a=np.array({{false,false,true},{true,false,false}},np.bool)
 local b=np.array({{0,1,31}},np.uint32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint32','bitwise_xor dtype 719')
 assert(veq(r:tolist(),{{0,1,30},{1,1,31}}),'bitwise_xor values 719')
end
do -- bitwise_xor type error 720
 local a=np.array({{1,63,63},{0,31,2}},np.uint64)
 local b=np.array({{30,-31,1}},np.int16)
 local ok=pcall(function() return np.bitwise_xor(a,b) end)
 assert(not ok,'bitwise_xor error 720')
end
do -- bitwise_xor 721
 local a=np.array({7,-3,7,-9,15},np.int16)
 local b=np.array({127,0,0,5,1},np.uint32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int64','bitwise_xor dtype 721')
 assert(veq(r:tolist(),{120,-3,7,-14,14}),'bitwise_xor values 721')
end
do -- bitwise_xor 722
 local a=np.array({{2,5,1},{31,63,15}},np.uint16)
 local b=np.array({1,1,-1},np.int16)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int32','bitwise_xor dtype 722')
 assert(veq(r:tolist(),{{3,4,-2},{30,62,-16}}),'bitwise_xor values 722')
end
do -- bitwise_xor 723
 local a=np.array({-31,-1,-31,-9,-3},np.int8)
 local b=np.array({-3,0,30,-3,0},np.int16)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int16','bitwise_xor dtype 723')
 assert(veq(r:tolist(),{28,-1,-1,10,-3}),'bitwise_xor values 723')
end
do -- bitwise_xor 724
 local a=np.array({{15,1,0},{15,7,0}},np.uint64)
 local b=np.array({{127,31,0}},np.uint32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint64','bitwise_xor dtype 724')
 assert(veq(r:tolist(),{{112,30,0},{112,24,0}}),'bitwise_xor values 724')
end
do -- bitwise_xor 725
 local a=np.array({{2,30,3},{2,3,0}},np.int32)
 local b=np.array({2,2,-3},np.int8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int32','bitwise_xor dtype 725')
 assert(veq(r:tolist(),{{0,28,-2},{0,1,-3}}),'bitwise_xor values 725')
end
do -- bitwise_xor 726
 local a=np.array({{15,15,30},{15,-31,-9}},np.int64)
 local b=np.array({{30,-3,3}},np.int8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int64','bitwise_xor dtype 726')
 assert(veq(r:tolist(),{{17,-14,29},{17,28,-12}}),'bitwise_xor values 726')
end
do -- bitwise_xor type error 727
 local a=np.array({31,127,63,31,3},np.uint64)
 local b=np.array({2,15,-31,1,3},np.int8)
 local ok=pcall(function() return np.bitwise_xor(a,b) end)
 assert(not ok,'bitwise_xor error 727')
end
do -- bitwise_xor 728
 local a=np.array({{-3},{0}},np.int8)
 local b=np.array({{3,-31,-1}},np.int32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int32','bitwise_xor dtype 728')
 assert(veq(r:tolist(),{{-2,28,2},{3,-31,-1}}),'bitwise_xor values 728')
end
do -- bitwise_xor 729
 local a=np.array({{-9,1,-3},{1,-3,-3}},np.int64)
 local b=np.array({0,0,1},np.int16)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int64','bitwise_xor dtype 729')
 assert(veq(r:tolist(),{{-9,1,-4},{1,-3,-4}}),'bitwise_xor values 729')
end
do -- bitwise_xor 730
 local a=np.array({{5},{15}},np.uint32)
 local b=np.array({{5,63,0}},np.uint8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint32','bitwise_xor dtype 730')
 assert(veq(r:tolist(),{{0,58,5},{10,48,15}}),'bitwise_xor values 730')
end
do -- bitwise_xor 731
 local a=np.array({{0,5,31},{15,2,0}},np.uint8)
 local b=np.array({{1,3,3}},np.uint8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint8','bitwise_xor dtype 731')
 assert(veq(r:tolist(),{{1,6,28},{14,1,3}}),'bitwise_xor values 731')
end
do -- bitwise_xor 732
 local a=np.array({{0},{3}},np.int16)
 local b=np.array({{0,2,0}},np.int8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int16','bitwise_xor dtype 732')
 assert(veq(r:tolist(),{{0,2,0},{3,1,3}}),'bitwise_xor values 732')
end
do -- bitwise_xor 733
 local a=np.array({-3,30,-1,30,7},np.int64)
 local b=np.array({0,7,-31,1,15},np.int8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int64','bitwise_xor dtype 733')
 assert(veq(r:tolist(),{-3,25,30,31,8}),'bitwise_xor values 733')
end
do -- bitwise_xor 734
 local a=np.array({31,1,0,63,3},np.uint16)
 local b=np.array({127,31,1,3,2},np.uint8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint16','bitwise_xor dtype 734')
 assert(veq(r:tolist(),{96,30,1,60,1}),'bitwise_xor values 734')
end
do -- bitwise_xor 735
 local a=np.array({{5,1,15},{31,2,2}},np.uint8)
 local b=np.array({5,5,63},np.uint32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='uint32','bitwise_xor dtype 735')
 assert(veq(r:tolist(),{{0,4,48},{26,7,61}}),'bitwise_xor values 735')
end
do -- bitwise_xor 736
 local a=np.array({{false,true,false},{true,false,false}},np.bool)
 local b=np.array({{1,15,15}},np.int16)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int16','bitwise_xor dtype 736')
 assert(veq(r:tolist(),{{1,14,15},{0,15,15}}),'bitwise_xor values 736')
end
do -- bitwise_xor 737
 local a=np.array({{-1,1,15},{0,2,3}},np.int32)
 local b=np.array({{127,5,0}},np.uint32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int64','bitwise_xor dtype 737')
 assert(veq(r:tolist(),{{-128,4,15},{127,7,3}}),'bitwise_xor values 737')
end
do -- bitwise_xor 738
 local a=np.array({{-1,-31,-9},{2,1,2}},np.int32)
 local b=np.array({1,3,-1},np.int64)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int64','bitwise_xor dtype 738')
 assert(veq(r:tolist(),{{-2,-30,8},{3,2,-3}}),'bitwise_xor values 738')
end
do -- bitwise_xor 739
 local a=np.array({false,true,true,true,true},np.bool)
 local b=np.array({15,0,7,30,1},np.int16)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int16','bitwise_xor dtype 739')
 assert(veq(r:tolist(),{15,1,6,31,0}),'bitwise_xor values 739')
end
do -- bitwise_xor 740
 local a=np.array({{false,false,false},{false,false,true}},np.bool)
 local b=np.array({1,-3,-9},np.int16)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int16','bitwise_xor dtype 740')
 assert(veq(r:tolist(),{{1,-3,-9},{1,-3,-10}}),'bitwise_xor values 740')
end
do -- bitwise_xor 741
 local a=np.array({{-31},{2}},np.int32)
 local b=np.array({{2,15,7}},np.int8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int32','bitwise_xor dtype 741')
 assert(veq(r:tolist(),{{-29,-18,-26},{0,13,5}}),'bitwise_xor values 741')
end
do -- bitwise_xor 742
 local a=np.array({{false,false,false},{true,true,false}},np.bool)
 local b=np.array({{-31,0,3}},np.int8)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int8','bitwise_xor dtype 742')
 assert(veq(r:tolist(),{{-31,0,3},{-32,1,3}}),'bitwise_xor values 742')
end
do -- bitwise_xor 743
 local a=np.array({{3,-31,-3},{2,0,1}},np.int64)
 local b=np.array({{true,true,false}},np.bool)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int64','bitwise_xor dtype 743')
 assert(veq(r:tolist(),{{2,-32,-3},{3,1,1}}),'bitwise_xor values 743')
end
do -- bitwise_xor 744
 local a=np.array({{2,-9,-9},{1,7,-1}},np.int8)
 local b=np.array({{-31,-31,-9}},np.int32)
 local r=np.bitwise_xor(a,b)
 assert(r.dtype=='int32','bitwise_xor dtype 744')
 assert(veq(r:tolist(),{{-29,22,0},{-32,-26,8}}),'bitwise_xor values 744')
end
do -- copysign 745
 local a=np.array({{-math.huge,-math.huge,3.5},{-0.0,0.5,-1.0}},np.float32)
 local b=np.array({{-0.0,-3.0,2.0},{-1.5,2.0,1.0}},np.float32)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 745 '..r.dtype)
 assert(veq(r:tolist(),{{-math.huge,-math.huge,3.5},{-0.0,0.5,1.0}}),'copysign values 745')
end
do -- copysign 746
 local a=np.array({15,-1,-1,7,0},np.int32)
 local b=np.array({1,30,2,30,-3},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 746 '..r.dtype)
 assert(veq(r:tolist(),{15.0,1.0,1.0,7.0,-0.0}),'copysign values 746')
end
do -- copysign 747
 local a=np.array({{-1.5,1.0,-1.5},{0.0,-9.5,-3.0}},np.float32)
 local b=np.array({{-1.5,3.5,0.0},{-1.5,2.0,1.0}},np.float32)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 747 '..r.dtype)
 assert(veq(r:tolist(),{{-1.5,1.0,1.5},{-0.0,9.5,3.0}}),'copysign values 747')
end
do -- copysign 748
 local a=np.array({{1,127,3},{1,2,3}},np.uint8)
 local b=np.array({{15,2,-31},{-1,-31,3}},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 748 '..r.dtype)
 assert(veq(r:tolist(),{{1.0,127.0,-3.0},{-1.0,-2.0,3.0}}),'copysign values 748')
end
do -- copysign 749
 local a=np.array({-3.0,2.0,0.0,-9.5,1.0},np.float64)
 local b=np.array({1,0,-1,7,-9},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 749 '..r.dtype)
 assert(veq(r:tolist(),{3.0,2.0,-0.0,9.5,-1.0}),'copysign values 749')
end
do -- copysign 750
 local a=np.array({9.0,9.0,2.0,3.5,-1.5},np.float64)
 local b=np.array({9.0,-1.5,-1.5,-1.5,-1.0},np.float32)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 750 '..r.dtype)
 assert(veq(r:tolist(),{9.0,-9.0,-2.0,-3.5,-1.5}),'copysign values 750')
end
do -- copysign 751
 local a=np.array({0.0,2.0,-1.5,-1.5,-0.0},np.float32)
 local b=np.array({-0.0,-3.0,-1.0,-1.0,-1.5},np.float32)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 751 '..r.dtype)
 assert(veq(r:tolist(),{-0.0,-2.0,-1.5,-1.5,-0.0}),'copysign values 751')
end
do -- copysign 752
 local a=np.array({{-9,2,30},{7,3,2}},np.int8)
 local b=np.array({{-3,-9,-31},{1,1,-1}},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 752 '..r.dtype)
 assert(veq(r:tolist(),{{-9.0,-2.0,-30.0},{7.0,3.0,-2.0}}),'copysign values 752')
end
do -- copysign 753
 local a=np.array({{0,2,30},{30,-1,1}},np.int8)
 local b=np.array({{2,-1,15},{-31,15,1}},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 753 '..r.dtype)
 assert(veq(r:tolist(),{{0.0,-2.0,30.0},{-30.0,1.0,1.0}}),'copysign values 753')
end
do -- copysign 754
 local a=np.array({{-1,1,-3},{30,-9,-1}},np.int16)
 local b=np.array({{-1,30,7},{-9,0,7}},np.int16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 754 '..r.dtype)
 assert(veq(r:tolist(),{{-1.0,1.0,3.0},{-30.0,9.0,1.0}}),'copysign values 754')
end
do -- copysign 755
 local a=np.array({7,-1,-31,1,15},np.int32)
 local b=np.array({15,-9,2,15,7},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 755 '..r.dtype)
 assert(veq(r:tolist(),{7.0,-1.0,31.0,1.0,15.0}),'copysign values 755')
end
do -- copysign 756
 local a=np.array({1.0,9.0,9.0,-3.0,(0/0)},np.float64)
 local b=np.array({-1.5,-9.5,3.5,-9.5,-9.5},np.float32)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 756 '..r.dtype)
 assert(veq(r:tolist(),{-1.0,-9.0,9.0,-3.0,(0/0)}),'copysign values 756')
end
do -- copysign 757
 local a=np.array({{3.5,-1.5,-3.0},{1.0,-math.huge,-math.huge}},np.float16)
 local b=np.array({{-1.0,0.0,-1.0},{9.0,-3.0,0.0}},np.float16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 757 '..r.dtype)
 assert(veq(r:tolist(),{{-3.5,1.5,-3.0},{1.0,-math.huge,math.huge}}),'copysign values 757')
end
do -- copysign 758
 local a=np.array({30,-3,7,-31,-31},np.int32)
 local b=np.array({2,0,-31,30,2},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 758 '..r.dtype)
 assert(veq(r:tolist(),{30.0,3.0,-7.0,31.0,31.0}),'copysign values 758')
end
do -- copysign 759
 local a=np.array({{0.5,1.0,math.huge},{0.5,math.huge,2.0}},np.float64)
 local b=np.array({{1,-31,-3},{2,-31,2}},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 759 '..r.dtype)
 assert(veq(r:tolist(),{{0.5,-1.0,-math.huge},{0.5,-math.huge,2.0}}),'copysign values 759')
end
do -- copysign 760
 local a=np.array({{-3.0,-1.0,math.huge},{0.0,-math.huge,0.5}},np.float64)
 local b=np.array({{15,-31,-1},{7,-31,7}},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 760 '..r.dtype)
 assert(veq(r:tolist(),{{3.0,-1.0,-math.huge},{0.0,-math.huge,0.5}}),'copysign values 760')
end
do -- copysign 761
 local a=np.array({{3,-9,-3},{15,-9,30}},np.int8)
 local b=np.array({{15,30,-3},{30,7,-9}},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 761 '..r.dtype)
 assert(veq(r:tolist(),{{3.0,9.0,-3.0},{15.0,9.0,-30.0}}),'copysign values 761')
end
do -- copysign 762
 local a=np.array({(0/0),math.huge,(0/0),-9.5,-1.5},np.float32)
 local b=np.array({-1.0,-1.5,0.5,0.5,9.0},np.float32)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 762 '..r.dtype)
 assert(veq(r:tolist(),{(0/0),-math.huge,(0/0),9.5,1.5}),'copysign values 762')
end
do -- copysign 763
 local a=np.array({{0,-9,-31},{15,-1,-9}},np.int8)
 local b=np.array({{-31,-3,-3},{3,-3,15}},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 763 '..r.dtype)
 assert(veq(r:tolist(),{{-0.0,-9.0,-31.0},{15.0,-1.0,9.0}}),'copysign values 763')
end
do -- copysign 764
 local a=np.array({{2,1,63},{5,3,2}},np.uint16)
 local b=np.array({{2,1,3},{2,-1,2}},np.int16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 764 '..r.dtype)
 assert(veq(r:tolist(),{{2.0,1.0,63.0},{5.0,-3.0,2.0}}),'copysign values 764')
end
do -- copysign 765
 local a=np.array({1,0,-31,-1,-3},np.int64)
 local b=np.array({127,3,31,0,2},np.uint64)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 765 '..r.dtype)
 assert(veq(r:tolist(),{1.0,0.0,31.0,1.0,3.0}),'copysign values 765')
end
do -- copysign 766
 local a=np.array({{-9,-1,3},{-1,7,15}},np.int8)
 local b=np.array({{-1,7,-3},{-1,1,-3}},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 766 '..r.dtype)
 assert(veq(r:tolist(),{{-9.0,1.0,-3.0},{-1.0,7.0,-15.0}}),'copysign values 766')
end
do -- copysign 767
 local a=np.array({-1.5,-9.5,2.0,9.0,-1.0},np.float32)
 local b=np.array({0,1,-9,-1,30},np.int16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 767 '..r.dtype)
 assert(veq(r:tolist(),{1.5,9.5,-2.0,-9.0,1.0}),'copysign values 767')
end
do -- copysign 768
 local a=np.array({-1,-9,-1,30,-9},np.int16)
 local b=np.array({0,-3,-3,-31,15},np.int16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 768 '..r.dtype)
 assert(veq(r:tolist(),{1.0,-9.0,-1.0,-30.0,9.0}),'copysign values 768')
end
do -- copysign 769
 local a=np.array({2.0,0.0,(0/0),math.huge,0.5},np.float16)
 local b=np.array({0,2,0,7,-1},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 769 '..r.dtype)
 assert(veq(r:tolist(),{2.0,0.0,(0/0),math.huge,-0.5}),'copysign values 769')
end
do -- copysign 770
 local a=np.array({{-3,0,0},{-9,-9,0}},np.int32)
 local b=np.array({{15,-31,7},{2,30,30}},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 770 '..r.dtype)
 assert(veq(r:tolist(),{{3.0,-0.0,0.0},{9.0,9.0,0.0}}),'copysign values 770')
end
do -- copysign 771
 local a=np.array({1.0,-9.5,-1.0,-math.huge,-3.0},np.float16)
 local b=np.array({30,-31,7,30,7},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 771 '..r.dtype)
 assert(veq(r:tolist(),{1.0,-9.5,1.0,math.huge,3.0}),'copysign values 771')
end
do -- copysign 772
 local a=np.array({2.0,9.0,0.5,-math.huge,-9.5},np.float16)
 local b=np.array({2,15,3,-31,2},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 772 '..r.dtype)
 assert(veq(r:tolist(),{2.0,9.0,0.5,-math.huge,9.5}),'copysign values 772')
end
do -- copysign 773
 local a=np.array({1,7,2,63,1},np.uint16)
 local b=np.array({3,-3,7,3,-3},np.int16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 773 '..r.dtype)
 assert(veq(r:tolist(),{1.0,-7.0,2.0,63.0,-1.0}),'copysign values 773')
end
do -- copysign 774
 local a=np.array({{5,15,31},{7,1,1}},np.uint16)
 local b=np.array({{-1,-1,-31},{-1,1,1}},np.int16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 774 '..r.dtype)
 assert(veq(r:tolist(),{{-5.0,-15.0,-31.0},{-7.0,1.0,1.0}}),'copysign values 774')
end
do -- copysign 775
 local a=np.array({1.0,-3.0,math.huge,-1.5,3.5},np.float64)
 local b=np.array({-3.0,1.0,3.5,9.0,-1.5},np.float32)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 775 '..r.dtype)
 assert(veq(r:tolist(),{-1.0,3.0,math.huge,1.5,-3.5}),'copysign values 775')
end
do -- copysign 776
 local a=np.array({{3.5,9.0,-1.5},{math.huge,0.0,0.5}},np.float64)
 local b=np.array({{2,-31,7},{2,3,7}},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 776 '..r.dtype)
 assert(veq(r:tolist(),{{3.5,-9.0,1.5},{math.huge,0.0,0.5}}),'copysign values 776')
end
do -- copysign 777
 local a=np.array({{-1.5,1.0,1.0},{0.5,-3.0,9.0}},np.float64)
 local b=np.array({{-0.0,0.0,-3.0},{-1.5,-3.0,-3.0}},np.float32)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 777 '..r.dtype)
 assert(veq(r:tolist(),{{-1.5,1.0,-1.0},{-0.5,-3.0,-9.0}}),'copysign values 777')
end
do -- copysign 778
 local a=np.array({{-1,0,0},{-1,15,1}},np.int8)
 local b=np.array({{3,2,15},{15,7,15}},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 778 '..r.dtype)
 assert(veq(r:tolist(),{{1.0,0.0,0.0},{1.0,15.0,1.0}}),'copysign values 778')
end
do -- copysign 779
 local a=np.array({-1,7,-1,3,15},np.int8)
 local b=np.array({7,0,-3,-9,-3},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 779 '..r.dtype)
 assert(veq(r:tolist(),{1.0,7.0,-1.0,-3.0,-15.0}),'copysign values 779')
end
do -- copysign 780
 local a=np.array({1,7,7,30,2},np.int32)
 local b=np.array({7,0,7,3,3},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 780 '..r.dtype)
 assert(veq(r:tolist(),{1.0,7.0,7.0,30.0,2.0}),'copysign values 780')
end
do -- copysign 781
 local a=np.array({{1.0,math.huge,0.0},{-1.5,0.5,-3.0}},np.float16)
 local b=np.array({{2,-31,3},{0,-3,1}},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 781 '..r.dtype)
 assert(veq(r:tolist(),{{1.0,-math.huge,0.0},{1.5,-0.5,3.0}}),'copysign values 781')
end
do -- copysign 782
 local a=np.array({2.0,9.0,-1.0,1.0,-1.5},np.float16)
 local b=np.array({2.0,0.0,3.5,0.5,-1.5},np.float16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 782 '..r.dtype)
 assert(veq(r:tolist(),{2.0,9.0,1.0,1.0,-1.5}),'copysign values 782')
end
do -- copysign 783
 local a=np.array({1.0,9.0,-0.0,0.0,1.0},np.float16)
 local b=np.array({-0.0,0.5,0.0,3.5,-3.0},np.float16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 783 '..r.dtype)
 assert(veq(r:tolist(),{-1.0,9.0,0.0,0.0,-1.0}),'copysign values 783')
end
do -- copysign 784
 local a=np.array({3.5,9.0,-0.0,1.0,-9.5},np.float16)
 local b=np.array({0.0,-3.0,0.0,3.5,0.5},np.float16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 784 '..r.dtype)
 assert(veq(r:tolist(),{3.5,-9.0,0.0,1.0,9.5}),'copysign values 784')
end
do -- copysign 785
 local a=np.array({2,3,-31,15,7},np.int16)
 local b=np.array({30,-31,-31,3,3},np.int16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 785 '..r.dtype)
 assert(veq(r:tolist(),{2.0,-3.0,-31.0,15.0,7.0}),'copysign values 785')
end
do -- copysign 786
 local a=np.array({{-1,3,2},{3,2,-1}},np.int16)
 local b=np.array({{15,-31,-3},{0,15,0}},np.int16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 786 '..r.dtype)
 assert(veq(r:tolist(),{{1.0,-3.0,-2.0},{3.0,2.0,1.0}}),'copysign values 786')
end
do -- copysign 787
 local a=np.array({0.0,(0/0),(0/0),-3.0,3.5},np.float32)
 local b=np.array({9.0,0.0,2.0,3.5,-0.0},np.float32)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 787 '..r.dtype)
 assert(veq(r:tolist(),{0.0,(0/0),(0/0),3.0,-3.5}),'copysign values 787')
end
do -- copysign 788
 local a=np.array({15,-31,30,1,-31},np.int32)
 local b=np.array({1,0,-1,7,30},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 788 '..r.dtype)
 assert(veq(r:tolist(),{15.0,31.0,-30.0,1.0,31.0}),'copysign values 788')
end
do -- copysign 789
 local a=np.array({1,0,-3,0,7},np.int64)
 local b=np.array({15,1,5,3,2},np.uint64)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 789 '..r.dtype)
 assert(veq(r:tolist(),{1.0,0.0,3.0,0.0,7.0}),'copysign values 789')
end
do -- copysign 790
 local a=np.array({{-9.5,0.5,9.0},{-0.0,math.huge,0.0}},np.float32)
 local b=np.array({{2.0,-9.5,9.0},{-0.0,-1.0,-1.0}},np.float32)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 790 '..r.dtype)
 assert(veq(r:tolist(),{{9.5,-0.5,9.0},{-0.0,-math.huge,-0.0}}),'copysign values 790')
end
do -- copysign 791
 local a=np.array({{0.0,-3.0,-1.5},{0.5,math.huge,-1.5}},np.float64)
 local b=np.array({{30,1,-31},{2,1,7}},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 791 '..r.dtype)
 assert(veq(r:tolist(),{{0.0,3.0,-1.5},{0.5,math.huge,1.5}}),'copysign values 791')
end
do -- copysign 792
 local a=np.array({9.0,-1.5,0.5,1.0,9.0},np.float32)
 local b=np.array({2.0,1.0,9.0,-1.5,-1.0},np.float32)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 792 '..r.dtype)
 assert(veq(r:tolist(),{9.0,1.5,0.5,-1.0,-9.0}),'copysign values 792')
end
do -- copysign 793
 local a=np.array({{-9.5,2.0,2.0},{-math.huge,3.5,-1.0}},np.float16)
 local b=np.array({{-1.5,-9.5,-1.0},{-3.0,9.0,2.0}},np.float16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 793 '..r.dtype)
 assert(veq(r:tolist(),{{-9.5,-2.0,-2.0},{-math.huge,3.5,1.0}}),'copysign values 793')
end
do -- copysign 794
 local a=np.array({{math.huge,1.0,-1.5},{0.0,0.5,-math.huge}},np.float32)
 local b=np.array({{-1.0,-1.5,-9.5},{0.0,-1.0,0.5}},np.float32)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 794 '..r.dtype)
 assert(veq(r:tolist(),{{-math.huge,-1.0,-1.5},{0.0,-0.5,math.huge}}),'copysign values 794')
end
do -- copysign 795
 local a=np.array({{-1,2,7},{-9,15,15}},np.int64)
 local b=np.array({{2,2,127},{127,2,5}},np.uint64)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 795 '..r.dtype)
 assert(veq(r:tolist(),{{1.0,2.0,7.0},{9.0,15.0,15.0}}),'copysign values 795')
end
do -- copysign 796
 local a=np.array({{15,15,3},{-1,2,1}},np.int16)
 local b=np.array({{-9,2,2},{-9,-1,-9}},np.int16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 796 '..r.dtype)
 assert(veq(r:tolist(),{{-15.0,15.0,3.0},{-1.0,-2.0,-1.0}}),'copysign values 796')
end
do -- copysign 797
 local a=np.array({15,7,15,-9,7},np.int32)
 local b=np.array({0,1,-9,1,-9},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 797 '..r.dtype)
 assert(veq(r:tolist(),{15.0,7.0,-15.0,9.0,-7.0}),'copysign values 797')
end
do -- copysign 798
 local a=np.array({63,7,2,63,15},np.uint8)
 local b=np.array({2,3,7,-9,-3},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 798 '..r.dtype)
 assert(veq(r:tolist(),{63.0,7.0,2.0,-63.0,-15.0}),'copysign values 798')
end
do -- copysign 799
 local a=np.array({0,15,1,30,-1},np.int32)
 local b=np.array({3,2,-3,15,-9},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 799 '..r.dtype)
 assert(veq(r:tolist(),{0.0,15.0,-1.0,30.0,-1.0}),'copysign values 799')
end
do -- copysign 800
 local a=np.array({31,31,15,5,127},np.uint16)
 local b=np.array({0,7,30,-1,15},np.int16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 800 '..r.dtype)
 assert(veq(r:tolist(),{31.0,31.0,15.0,-5.0,127.0}),'copysign values 800')
end
do -- copysign 801
 local a=np.array({0.0,-1.5,3.5,0.0,-0.0},np.float16)
 local b=np.array({-3,-3,-1,30,1},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 801 '..r.dtype)
 assert(veq(r:tolist(),{-0.0,-1.5,-3.5,0.0,0.0}),'copysign values 801')
end
do -- copysign 802
 local a=np.array({-1.5,-1.5,-9.5,-3.0,-1.0},np.float64)
 local b=np.array({-3.0,1.0,-0.0,1.0,3.5},np.float32)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 802 '..r.dtype)
 assert(veq(r:tolist(),{-1.5,1.5,-9.5,3.0,1.0}),'copysign values 802')
end
do -- copysign 803
 local a=np.array({-math.huge,1.0,1.0,(0/0),-3.0},np.float64)
 local b=np.array({0,-3,3,2,-3},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 803 '..r.dtype)
 assert(veq(r:tolist(),{math.huge,-1.0,1.0,(0/0),-3.0}),'copysign values 803')
end
do -- copysign 804
 local a=np.array({9.0,0.5,-3.0,-1.0,-0.0},np.float32)
 local b=np.array({0,3,-9,-31,15},np.int16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 804 '..r.dtype)
 assert(veq(r:tolist(),{9.0,0.5,-3.0,-1.0,0.0}),'copysign values 804')
end
do -- copysign 805
 local a=np.array({{2.0,-math.huge,1.0},{1.0,(0/0),-9.5}},np.float32)
 local b=np.array({{-0.0,-9.5,0.5},{-9.5,-0.0,0.0}},np.float32)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 805 '..r.dtype)
 assert(veq(r:tolist(),{{-2.0,-math.huge,1.0},{-1.0,(0/0),9.5}}),'copysign values 805')
end
do -- copysign 806
 local a=np.array({-1,-31,15,15,0},np.int16)
 local b=np.array({-31,30,15,3,-1},np.int16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 806 '..r.dtype)
 assert(veq(r:tolist(),{-1.0,31.0,15.0,15.0,-0.0}),'copysign values 806')
end
do -- copysign 807
 local a=np.array({{63,63,0},{31,0,63}},np.uint16)
 local b=np.array({{-1,-31,0},{1,-9,3}},np.int16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 807 '..r.dtype)
 assert(veq(r:tolist(),{{-63.0,-63.0,0.0},{31.0,-0.0,63.0}}),'copysign values 807')
end
do -- copysign 808
 local a=np.array({{30,0,-31},{2,7,1}},np.int8)
 local b=np.array({{-9,3,7},{7,-3,-9}},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 808 '..r.dtype)
 assert(veq(r:tolist(),{{-30.0,0.0,31.0},{2.0,-7.0,-1.0}}),'copysign values 808')
end
do -- copysign 809
 local a=np.array({0.0,-1.5,-1.0,-0.0,9.0},np.float32)
 local b=np.array({2.0,9.0,-3.0,2.0,1.0},np.float32)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 809 '..r.dtype)
 assert(veq(r:tolist(),{0.0,1.5,-1.0,0.0,9.0}),'copysign values 809')
end
do -- copysign 810
 local a=np.array({1.0,-1.0,3.5,-1.0,9.0},np.float64)
 local b=np.array({30,1,0,-1,30},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 810 '..r.dtype)
 assert(veq(r:tolist(),{1.0,1.0,3.5,-1.0,9.0}),'copysign values 810')
end
do -- copysign 811
 local a=np.array({0.0,-9.5,(0/0),-0.0,-1.0},np.float64)
 local b=np.array({-3.0,-9.5,-1.0,-3.0,-3.0},np.float32)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 811 '..r.dtype)
 assert(veq(r:tolist(),{-0.0,-9.5,(0/0),-0.0,-1.0}),'copysign values 811')
end
do -- copysign 812
 local a=np.array({-0.0,math.huge,3.5,1.0,-1.0},np.float16)
 local b=np.array({0.5,1.0,3.5,-0.0,1.0},np.float16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 812 '..r.dtype)
 assert(veq(r:tolist(),{0.0,math.huge,3.5,-1.0,1.0}),'copysign values 812')
end
do -- copysign 813
 local a=np.array({1,7,7,63,2},np.uint16)
 local b=np.array({-9,7,-9,15,0},np.int16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 813 '..r.dtype)
 assert(veq(r:tolist(),{-1.0,7.0,-7.0,63.0,2.0}),'copysign values 813')
end
do -- copysign 814
 local a=np.array({15,15,127,2,5},np.uint8)
 local b=np.array({15,7,-3,-1,-9},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 814 '..r.dtype)
 assert(veq(r:tolist(),{15.0,15.0,-127.0,-2.0,-5.0}),'copysign values 814')
end
do -- copysign 815
 local a=np.array({{-1.5,9.0,-1.0},{0.5,-math.huge,1.0}},np.float16)
 local b=np.array({{-1,1,-31},{30,2,7}},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 815 '..r.dtype)
 assert(veq(r:tolist(),{{-1.5,9.0,-1.0},{0.5,math.huge,1.0}}),'copysign values 815')
end
do -- copysign 816
 local a=np.array({-1.0,2.0,-9.5,0.5,-0.0},np.float16)
 local b=np.array({15,-9,-3,1,0},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 816 '..r.dtype)
 assert(veq(r:tolist(),{1.0,-2.0,-9.5,0.5,0.0}),'copysign values 816')
end
do -- copysign 817
 local a=np.array({-3,-1,-9,-9,-1},np.int64)
 local b=np.array({15,3,127,31,3},np.uint64)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 817 '..r.dtype)
 assert(veq(r:tolist(),{3.0,1.0,9.0,9.0,1.0}),'copysign values 817')
end
do -- copysign 818
 local a=np.array({{(0/0),9.0,-1.5},{-9.5,-1.5,1.0}},np.float64)
 local b=np.array({{2,3,-3},{2,30,-3}},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 818 '..r.dtype)
 assert(veq(r:tolist(),{{(0/0),9.0,-1.5},{9.5,1.5,-1.0}}),'copysign values 818')
end
do -- copysign 819
 local a=np.array({2.0,9.0,0.0,3.5,-math.huge},np.float32)
 local b=np.array({-31,0,0,2,30},np.int16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 819 '..r.dtype)
 assert(veq(r:tolist(),{-2.0,9.0,0.0,3.5,math.huge}),'copysign values 819')
end
do -- copysign 820
 local a=np.array({{-9.5,-0.0,-1.5},{9.0,-math.huge,0.5}},np.float16)
 local b=np.array({{-3.0,0.0,-1.0},{0.0,2.0,2.0}},np.float16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 820 '..r.dtype)
 assert(veq(r:tolist(),{{-9.5,0.0,-1.5},{9.0,math.huge,0.5}}),'copysign values 820')
end
do -- copysign 821
 local a=np.array({math.huge,(0/0),-3.0,-0.0,-1.5},np.float64)
 local b=np.array({2,-31,-3,1,1},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 821 '..r.dtype)
 assert(veq(r:tolist(),{math.huge,(0/0),-3.0,0.0,1.5}),'copysign values 821')
end
do -- copysign 822
 local a=np.array({{-9.5,math.huge,-3.0},{2.0,-math.huge,0.0}},np.float16)
 local b=np.array({{9.0,-0.0,-1.0},{-1.5,-1.5,-0.0}},np.float16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 822 '..r.dtype)
 assert(veq(r:tolist(),{{9.5,-math.huge,-3.0},{-2.0,-math.huge,-0.0}}),'copysign values 822')
end
do -- copysign 823
 local a=np.array({{-9.5,-1.5,0.5},{-1.5,-3.0,0.5}},np.float16)
 local b=np.array({{-9.5,-0.0,2.0},{3.5,0.0,-9.5}},np.float16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 823 '..r.dtype)
 assert(veq(r:tolist(),{{-9.5,-1.5,0.5},{1.5,3.0,-0.5}}),'copysign values 823')
end
do -- copysign 824
 local a=np.array({{30,30,-1},{-3,2,1}},np.int16)
 local b=np.array({{1,2,-9},{1,-9,1}},np.int16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 824 '..r.dtype)
 assert(veq(r:tolist(),{{30.0,30.0,-1.0},{3.0,-2.0,1.0}}),'copysign values 824')
end
do -- copysign 825
 local a=np.array({{-3,30,-31},{15,-3,2}},np.int16)
 local b=np.array({{2,-9,7},{2,-1,2}},np.int16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 825 '..r.dtype)
 assert(veq(r:tolist(),{{3.0,-30.0,31.0},{15.0,-3.0,2.0}}),'copysign values 825')
end
do -- copysign 826
 local a=np.array({{7,0,30},{-9,0,30}},np.int32)
 local b=np.array({{2,2,-9},{15,2,30}},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 826 '..r.dtype)
 assert(veq(r:tolist(),{{7.0,0.0,-30.0},{9.0,0.0,30.0}}),'copysign values 826')
end
do -- copysign 827
 local a=np.array({{3,5,15},{127,5,7}},np.uint16)
 local b=np.array({{3,1,15},{-31,-1,2}},np.int16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 827 '..r.dtype)
 assert(veq(r:tolist(),{{3.0,5.0,15.0},{-127.0,-5.0,7.0}}),'copysign values 827')
end
do -- copysign 828
 local a=np.array({{3,1,0},{15,15,15}},np.int8)
 local b=np.array({{-3,-3,3},{-31,3,30}},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 828 '..r.dtype)
 assert(veq(r:tolist(),{{-3.0,-1.0,0.0},{-15.0,15.0,15.0}}),'copysign values 828')
end
do -- copysign 829
 local a=np.array({{63,3,31},{31,3,3}},np.uint8)
 local b=np.array({{-9,0,-3},{3,3,-3}},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 829 '..r.dtype)
 assert(veq(r:tolist(),{{-63.0,3.0,-31.0},{31.0,3.0,-3.0}}),'copysign values 829')
end
do -- copysign 830
 local a=np.array({2.0,(0/0),0.5,-9.5,(0/0)},np.float64)
 local b=np.array({-31,15,-3,15,0},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','copysign dtype 830 '..r.dtype)
 assert(veq(r:tolist(),{-2.0,(0/0),-0.5,9.5,(0/0)}),'copysign values 830')
end
do -- copysign 831
 local a=np.array({math.huge,0.0,9.0,-0.0,2.0},np.float32)
 local b=np.array({30,30,1,3,2},np.int16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 831 '..r.dtype)
 assert(veq(r:tolist(),{math.huge,0.0,9.0,0.0,2.0}),'copysign values 831')
end
do -- copysign 832
 local a=np.array({math.huge,-3.0,1.0,-1.5,-1.5},np.float16)
 local b=np.array({0,-1,30,30,-31},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 832 '..r.dtype)
 assert(veq(r:tolist(),{math.huge,-3.0,1.0,1.5,-1.5}),'copysign values 832')
end
do -- copysign 833
 local a=np.array({{2,3,15},{31,63,63}},np.uint16)
 local b=np.array({{0,15,-3},{-9,7,15}},np.int16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','copysign dtype 833 '..r.dtype)
 assert(veq(r:tolist(),{{2.0,3.0,-15.0},{-31.0,63.0,63.0}}),'copysign values 833')
end
do -- copysign 834
 local a=np.array({3,15,31,31,1},np.uint8)
 local b=np.array({-31,15,-1,7,30},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','copysign dtype 834 '..r.dtype)
 assert(veq(r:tolist(),{-3.0,15.0,-31.0,31.0,1.0}),'copysign values 834')
end
do -- scalar floor_divide 835
 local a=np.array({true,true,false,false},np.bool)
 local r=np.floor_divide(1,a)
 assert(r.dtype=='int64','floor_divide scalar dtype 835 '..r.dtype)
 assert(veq(r:tolist(),{1,1,0,0}),'floor_divide scalar values 835')
end
do -- scalar floor_divide 836
 local a=np.array({3,127,7,127},np.uint16)
 local r=np.floor_divide(200,a)
 assert(r.dtype=='uint16','floor_divide scalar dtype 836 '..r.dtype)
 assert(veq(r:tolist(),{66,1,28,1}),'floor_divide scalar values 836')
end
do -- scalar floor_divide 837
 local a=np.array({7,0,-31,2},np.int16)
 local r=np.floor_divide(a,2)
 assert(r.dtype=='int16','floor_divide scalar dtype 837 '..r.dtype)
 assert(veq(r:tolist(),{3,0,-16,1}),'floor_divide scalar values 837')
end
do -- scalar floor_divide 838
 local a=np.array({15,3,0,-3},np.int8)
 local r=np.floor_divide(true,a)
 assert(r.dtype=='int8','floor_divide scalar dtype 838 '..r.dtype)
 assert(veq(r:tolist(),{0,0,0,-1}),'floor_divide scalar values 838')
end
do -- scalar floor_divide 839
 local a=np.array({0,3,-3,2},np.int8)
 local r=np.floor_divide(5,a)
 assert(r.dtype=='int8','floor_divide scalar dtype 839 '..r.dtype)
 assert(veq(r:tolist(),{0,1,-2,2}),'floor_divide scalar values 839')
end
do -- scalar floor_divide 840
 local a=np.array({15,-31,30,-31},np.int16)
 local r=np.floor_divide(a,10.0)
 assert(r.dtype=='float64','floor_divide scalar dtype 840 '..r.dtype)
 assert(veq(r:tolist(),{1.0,-4.0,3.0,-4.0}),'floor_divide scalar values 840')
end
do -- scalar floor_divide 841
 local a=np.array({0.0,3.5,2.0,-3.0},np.float32)
 local r=np.floor_divide(5,a)
 assert(r.dtype=='float32','floor_divide scalar dtype 841 '..r.dtype)
 assert(veq(r:tolist(),{math.huge,1.0,2.0,-2.0}),'floor_divide scalar values 841')
end
do -- scalar floor_divide 842
 local a=np.array({0.5,-0.0,9.0,1.0},np.float32)
 local r=np.floor_divide(a,0.5)
 assert(r.dtype=='float32','floor_divide scalar dtype 842 '..r.dtype)
 assert(veq(r:tolist(),{1.0,-0.0,18.0,2.0}),'floor_divide scalar values 842')
end
do -- scalar floor_divide 843
 local a=np.array({1,5,0,63},np.uint16)
 local r=np.floor_divide(200,a)
 assert(r.dtype=='uint16','floor_divide scalar dtype 843 '..r.dtype)
 assert(veq(r:tolist(),{200,40,0,3}),'floor_divide scalar values 843')
end
do -- scalar floor_divide 844
 local a=np.array({63,15,7,7},np.uint8)
 local r=np.floor_divide(200,a)
 assert(r.dtype=='uint8','floor_divide scalar dtype 844 '..r.dtype)
 assert(veq(r:tolist(),{3,13,28,28}),'floor_divide scalar values 844')
end
do -- scalar floor_divide 845
 local a=np.array({15,-3,3,-31},np.int64)
 local r=np.floor_divide(a,127)
 assert(r.dtype=='int64','floor_divide scalar dtype 845 '..r.dtype)
 assert(veq(r:tolist(),{0,-1,0,-1}),'floor_divide scalar values 845')
end
do -- scalar floor_divide 846
 local a=np.array({1,5,31,31},np.uint32)
 local r=np.floor_divide(0,a)
 assert(r.dtype=='uint32','floor_divide scalar dtype 846 '..r.dtype)
 assert(veq(r:tolist(),{0,0,0,0}),'floor_divide scalar values 846')
end
do -- scalar floor_divide 847
 local a=np.array({-31,-31,-9,7},np.int64)
 local r=np.floor_divide(a,-2.5)
 assert(r.dtype=='float64','floor_divide scalar dtype 847 '..r.dtype)
 assert(veq(r:tolist(),{12.0,12.0,3.0,-3.0}),'floor_divide scalar values 847')
end
do -- scalar floor_divide 848
 local a=np.array({-9,-3,15,-3},np.int8)
 local r=np.floor_divide(false,a)
 assert(r.dtype=='int8','floor_divide scalar dtype 848 '..r.dtype)
 assert(veq(r:tolist(),{0,0,0,0}),'floor_divide scalar values 848')
end
do -- scalar floor_divide 849
 local a=np.array({30,0,7,7},np.int64)
 local r=np.floor_divide(a,-1)
 assert(r.dtype=='int64','floor_divide scalar dtype 849 '..r.dtype)
 assert(veq(r:tolist(),{-30,0,-7,-7}),'floor_divide scalar values 849')
end
do -- scalar floor_divide 850
 local a=np.array({31,7,31,31},np.uint64)
 local r=np.floor_divide(a,false)
 assert(r.dtype=='uint64','floor_divide scalar dtype 850 '..r.dtype)
 assert(veq(r:tolist(),{0,0,0,0}),'floor_divide scalar values 850')
end
do -- scalar error floor_divide 851
 local a=np.array({63,5,63,5},np.uint32)
 local ok=pcall(function() return np.floor_divide(-1,a) end)
 assert(not ok,'floor_divide scalar error 851')
end
do -- scalar floor_divide 852
 local a=np.array({63,7,15,2},np.uint16)
 local r=np.floor_divide(a,2)
 assert(r.dtype=='uint16','floor_divide scalar dtype 852 '..r.dtype)
 assert(veq(r:tolist(),{31,3,7,1}),'floor_divide scalar values 852')
end
do -- scalar floor_divide 853
 local a=np.array({0.0,-9.5,-0.0,-3.0},np.float64)
 local r=np.floor_divide(-1,a)
 assert(r.dtype=='float64','floor_divide scalar dtype 853 '..r.dtype)
 assert(veq(r:tolist(),{-math.huge,0.0,math.huge,0.0}),'floor_divide scalar values 853')
end
do -- scalar floor_divide 854
 local a=np.array({-31,3,0,15},np.int32)
 local r=np.floor_divide(a,200)
 assert(r.dtype=='int32','floor_divide scalar dtype 854 '..r.dtype)
 assert(veq(r:tolist(),{-1,0,0,0}),'floor_divide scalar values 854')
end
do -- scalar floor_divide 855
 local a=np.array({9.0,9.0,-1.5,-3.0},np.float16)
 local r=np.floor_divide(-3,a)
 assert(r.dtype=='float16','floor_divide scalar dtype 855 '..r.dtype)
 assert(veq(r:tolist(),{-1.0,-1.0,2.0,1.0}),'floor_divide scalar values 855')
end
do -- scalar floor_divide 856
 local a=np.array({-3,7,30,1},np.int32)
 local r=np.floor_divide(a,1)
 assert(r.dtype=='int32','floor_divide scalar dtype 856 '..r.dtype)
 assert(veq(r:tolist(),{-3,7,30,1}),'floor_divide scalar values 856')
end
do -- scalar floor_divide 857
 local a=np.array({63,15,63,3},np.uint32)
 local r=np.floor_divide(a,2.0)
 assert(r.dtype=='float64','floor_divide scalar dtype 857 '..r.dtype)
 assert(veq(r:tolist(),{31.0,7.0,31.0,1.0}),'floor_divide scalar values 857')
end
do -- scalar floor_divide 858
 local a=np.array({1,15,0,0},np.int64)
 local r=np.floor_divide(a,-200)
 assert(r.dtype=='int64','floor_divide scalar dtype 858 '..r.dtype)
 assert(veq(r:tolist(),{-1,-1,0,0}),'floor_divide scalar values 858')
end
do -- scalar floor_divide 859
 local a=np.array({1,0,31,31},np.uint16)
 local r=np.floor_divide(a,0)
 assert(r.dtype=='uint16','floor_divide scalar dtype 859 '..r.dtype)
 assert(veq(r:tolist(),{0,0,0,0}),'floor_divide scalar values 859')
end
do -- scalar floor_divide 860
 local a=np.array({3.5,9.0,1.0,-3.0},np.float32)
 local r=np.floor_divide(-200,a)
 assert(r.dtype=='float32','floor_divide scalar dtype 860 '..r.dtype)
 assert(veq(r:tolist(),{-58.0,-23.0,-200.0,66.0}),'floor_divide scalar values 860')
end
do -- scalar floor_divide 861
 local a=np.array({7,1,15,-1},np.int16)
 local r=np.floor_divide(true,a)
 assert(r.dtype=='int16','floor_divide scalar dtype 861 '..r.dtype)
 assert(veq(r:tolist(),{0,1,0,-1}),'floor_divide scalar values 861')
end
do -- scalar floor_divide 862
 local a=np.array({1,63,1,15},np.uint32)
 local r=np.floor_divide(10.0,a)
 assert(r.dtype=='float64','floor_divide scalar dtype 862 '..r.dtype)
 assert(veq(r:tolist(),{10.0,0.0,10.0,0.0}),'floor_divide scalar values 862')
end
do -- scalar floor_divide 863
 local a=np.array({-1.0,2.0,0.0,-0.0},np.float64)
 local r=np.floor_divide(200,a)
 assert(r.dtype=='float64','floor_divide scalar dtype 863 '..r.dtype)
 assert(veq(r:tolist(),{-200.0,100.0,math.huge,-math.huge}),'floor_divide scalar values 863')
end
do -- scalar error floor_divide 864
 local a=np.array({3,7,3,15},np.uint32)
 local ok=pcall(function() return np.floor_divide(a,-200) end)
 assert(not ok,'floor_divide scalar error 864')
end
do -- scalar floor_divide 865
 local a=np.array({15,31,127,7},np.uint32)
 local r=np.floor_divide(a,5)
 assert(r.dtype=='uint32','floor_divide scalar dtype 865 '..r.dtype)
 assert(veq(r:tolist(),{3,6,25,1}),'floor_divide scalar values 865')
end
do -- scalar floor_divide 866
 local a=np.array({false,true,false,true},np.bool)
 local r=np.floor_divide(a,10.0)
 assert(r.dtype=='float64','floor_divide scalar dtype 866 '..r.dtype)
 assert(veq(r:tolist(),{0.0,0.0,0.0,0.0}),'floor_divide scalar values 866')
end
do -- scalar floor_divide 867
 local a=np.array({-1.5,9.0,-9.5,3.5},np.float16)
 local r=np.floor_divide(false,a)
 assert(r.dtype=='float16','floor_divide scalar dtype 867 '..r.dtype)
 assert(veq(r:tolist(),{-0.0,0.0,-0.0,0.0}),'floor_divide scalar values 867')
end
do -- scalar floor_divide 868
 local a=np.array({0.5,-0.0,1.0,2.0},np.float32)
 local r=np.floor_divide(a,2)
 assert(r.dtype=='float32','floor_divide scalar dtype 868 '..r.dtype)
 assert(veq(r:tolist(),{0.0,-0.0,0.0,1.0}),'floor_divide scalar values 868')
end
do -- scalar floor_divide 869
 local a=np.array({7,-1,2,-9},np.int32)
 local r=np.floor_divide(-1,a)
 assert(r.dtype=='int32','floor_divide scalar dtype 869 '..r.dtype)
 assert(veq(r:tolist(),{-1,1,-1,0}),'floor_divide scalar values 869')
end
do -- scalar floor_divide 870
 local a=np.array({2.0,-1.0,-3.0,-1.0},np.float32)
 local r=np.floor_divide(a,-0.0)
 assert(r.dtype=='float32','floor_divide scalar dtype 870 '..r.dtype)
 assert(veq(r:tolist(),{-math.huge,math.huge,math.huge,math.huge}),'floor_divide scalar values 870')
end
do -- scalar floor_divide 871
 local a=np.array({-1,30,1,-1},np.int32)
 local r=np.floor_divide(true,a)
 assert(r.dtype=='int32','floor_divide scalar dtype 871 '..r.dtype)
 assert(veq(r:tolist(),{-1,0,1,-1}),'floor_divide scalar values 871')
end
do -- scalar floor_divide 872
 local a=np.array({63,5,127,7},np.uint32)
 local r=np.floor_divide(false,a)
 assert(r.dtype=='uint32','floor_divide scalar dtype 872 '..r.dtype)
 assert(veq(r:tolist(),{0,0,0,0}),'floor_divide scalar values 872')
end
do -- scalar remainder 873
 local a=np.array({-1,2,-31,1},np.int8)
 local r=np.remainder(a,-1)
 assert(r.dtype=='int8','remainder scalar dtype 873 '..r.dtype)
 assert(veq(r:tolist(),{0,0,0,0}),'remainder scalar values 873')
end
do -- scalar error remainder 874
 local a=np.array({15,63,5,3},np.uint32)
 local ok=pcall(function() return np.remainder(a,-3) end)
 assert(not ok,'remainder scalar error 874')
end
do -- scalar remainder 875
 local a=np.array({0.0,-1.5,3.5,-3.0},np.float32)
 local r=np.remainder(a,127)
 assert(r.dtype=='float32','remainder scalar dtype 875 '..r.dtype)
 assert(veq(r:tolist(),{0.0,125.5,3.5,124.0}),'remainder scalar values 875')
end
do -- scalar error remainder 876
 local a=np.array({31,0,3,5},np.uint64)
 local ok=pcall(function() return np.remainder(-1,a) end)
 assert(not ok,'remainder scalar error 876')
end
do -- scalar remainder 877
 local a=np.array({0.5,0.5,2.0,9.0},np.float64)
 local r=np.remainder(a,true)
 assert(r.dtype=='float64','remainder scalar dtype 877 '..r.dtype)
 assert(veq(r:tolist(),{0.5,0.5,0.0,0.0}),'remainder scalar values 877')
end
do -- scalar remainder 878
 local a=np.array({3.5,9.0,0.5,-1.5},np.float16)
 local r=np.remainder(2,a)
 assert(r.dtype=='float16','remainder scalar dtype 878 '..r.dtype)
 assert(veq(r:tolist(),{2.0,2.0,0.0,-1.0}),'remainder scalar values 878')
end
do -- scalar remainder 879
 local a=np.array({15,30,0,1},np.int16)
 local r=np.remainder(2,a)
 assert(r.dtype=='int16','remainder scalar dtype 879 '..r.dtype)
 assert(veq(r:tolist(),{2,2,0,0}),'remainder scalar values 879')
end
do -- scalar remainder 880
 local a=np.array({3.5,1.0,2.0,2.0},np.float16)
 local r=np.remainder(2,a)
 assert(r.dtype=='float16','remainder scalar dtype 880 '..r.dtype)
 assert(veq(r:tolist(),{2.0,0.0,0.0,0.0}),'remainder scalar values 880')
end
do -- scalar remainder 881
 local a=np.array({1,0,15,127},np.uint64)
 local r=np.remainder(2.0,a)
 assert(r.dtype=='float64','remainder scalar dtype 881 '..r.dtype)
 assert(veq(r:tolist(),{0.0,(0/0),2.0,2.0}),'remainder scalar values 881')
end
do -- scalar remainder 882
 local a=np.array({9.0,2.0,0.0,-0.0},np.float32)
 local r=np.remainder(10.0,a)
 assert(r.dtype=='float32','remainder scalar dtype 882 '..r.dtype)
 assert(veq(r:tolist(),{1.0,0.0,(0/0),(0/0)}),'remainder scalar values 882')
end
do -- scalar remainder 883
 local a=np.array({-3,3,15,2},np.int64)
 local r=np.remainder(-1,a)
 assert(r.dtype=='int64','remainder scalar dtype 883 '..r.dtype)
 assert(veq(r:tolist(),{-1,2,14,1}),'remainder scalar values 883')
end
do -- scalar error remainder 884
 local a=np.array({-3,1,3,15},np.int8)
 local ok=pcall(function() return np.remainder(a,200) end)
 assert(not ok,'remainder scalar error 884')
end
do -- scalar remainder 885
 local a=np.array({-1.5,0.0,-0.0,9.0},np.float64)
 local r=np.remainder(a,0.5)
 assert(r.dtype=='float64','remainder scalar dtype 885 '..r.dtype)
 assert(veq(r:tolist(),{0.0,0.0,0.0,0.0}),'remainder scalar values 885')
end
do -- scalar remainder 886
 local a=np.array({-9,-9,2,2},np.int64)
 local r=np.remainder(-0.0,a)
 assert(r.dtype=='float64','remainder scalar dtype 886 '..r.dtype)
 assert(veq(r:tolist(),{-0.0,-0.0,0.0,0.0}),'remainder scalar values 886')
end
do -- scalar remainder 887
 local a=np.array({31,0,1,15},np.uint16)
 local r=np.remainder(2,a)
 assert(r.dtype=='uint16','remainder scalar dtype 887 '..r.dtype)
 assert(veq(r:tolist(),{2,0,0,2}),'remainder scalar values 887')
end
do -- scalar error remainder 888
 local a=np.array({7,1,2,127},np.uint32)
 local ok=pcall(function() return np.remainder(-1,a) end)
 assert(not ok,'remainder scalar error 888')
end
do -- scalar remainder 889
 local a=np.array({-3,0,0,-31},np.int8)
 local r=np.remainder(-0.0,a)
 assert(r.dtype=='float64','remainder scalar dtype 889 '..r.dtype)
 assert(veq(r:tolist(),{-0.0,(0/0),(0/0),-0.0}),'remainder scalar values 889')
end
do -- scalar remainder 890
 local a=np.array({3,-1,-3,30},np.int64)
 local r=np.remainder(true,a)
 assert(r.dtype=='int64','remainder scalar dtype 890 '..r.dtype)
 assert(veq(r:tolist(),{1,0,-2,1}),'remainder scalar values 890')
end
do -- scalar remainder 891
 local a=np.array({0.5,9.0,-0.0,0.0},np.float16)
 local r=np.remainder(10.0,a)
 assert(r.dtype=='float16','remainder scalar dtype 891 '..r.dtype)
 assert(veq(r:tolist(),{0.0,1.0,(0/0),(0/0)}),'remainder scalar values 891')
end
do -- scalar remainder 892
 local a=np.array({2,3,5,0},np.uint16)
 local r=np.remainder(0.5,a)
 assert(r.dtype=='float64','remainder scalar dtype 892 '..r.dtype)
 assert(veq(r:tolist(),{0.5,0.5,0.5,(0/0)}),'remainder scalar values 892')
end
do -- scalar remainder 893
 local a=np.array({-3,-31,1,-31},np.int8)
 local r=np.remainder(-2.5,a)
 assert(r.dtype=='float64','remainder scalar dtype 893 '..r.dtype)
 assert(veq(r:tolist(),{-2.5,-2.5,0.5,-2.5}),'remainder scalar values 893')
end
do -- scalar remainder 894
 local a=np.array({0.0,0.5,-3.0,-3.0},np.float64)
 local r=np.remainder(a,2)
 assert(r.dtype=='float64','remainder scalar dtype 894 '..r.dtype)
 assert(veq(r:tolist(),{0.0,0.5,1.0,1.0}),'remainder scalar values 894')
end
do -- scalar remainder 895
 local a=np.array({2,3,127,5},np.uint8)
 local r=np.remainder(true,a)
 assert(r.dtype=='uint8','remainder scalar dtype 895 '..r.dtype)
 assert(veq(r:tolist(),{1,1,1,1}),'remainder scalar values 895')
end
do -- scalar remainder 896
 local a=np.array({2,-9,3,30},np.int8)
 local r=np.remainder(true,a)
 assert(r.dtype=='int8','remainder scalar dtype 896 '..r.dtype)
 assert(veq(r:tolist(),{1,-8,1,1}),'remainder scalar values 896')
end
do -- scalar remainder 897
 local a=np.array({63,15,5,2},np.uint64)
 local r=np.remainder(a,5)
 assert(r.dtype=='uint64','remainder scalar dtype 897 '..r.dtype)
 assert(veq(r:tolist(),{3,0,0,2}),'remainder scalar values 897')
end
do -- scalar remainder 898
 local a=np.array({-0.0,-3.0,-1.5,2.0},np.float16)
 local r=np.remainder(false,a)
 assert(r.dtype=='float16','remainder scalar dtype 898 '..r.dtype)
 assert(veq(r:tolist(),{(0/0),-0.0,-0.0,0.0}),'remainder scalar values 898')
end
do -- scalar remainder 899
 local a=np.array({true,true,true,true},np.bool)
 local r=np.remainder(a,false)
 assert(r.dtype=='int8','remainder scalar dtype 899 '..r.dtype)
 assert(veq(r:tolist(),{0,0,0,0}),'remainder scalar values 899')
end
do -- scalar remainder 900
 local a=np.array({7,127,2,127},np.uint8)
 local r=np.remainder(true,a)
 assert(r.dtype=='uint8','remainder scalar dtype 900 '..r.dtype)
 assert(veq(r:tolist(),{1,1,1,1}),'remainder scalar values 900')
end
do -- scalar remainder 901
 local a=np.array({31,0,127,127},np.uint16)
 local r=np.remainder(1,a)
 assert(r.dtype=='uint16','remainder scalar dtype 901 '..r.dtype)
 assert(veq(r:tolist(),{1,0,1,1}),'remainder scalar values 901')
end
do -- scalar remainder 902
 local a=np.array({-3.0,-9.5,0.5,-1.0},np.float16)
 local r=np.remainder(-2.5,a)
 assert(r.dtype=='float16','remainder scalar dtype 902 '..r.dtype)
 assert(veq(r:tolist(),{-2.5,-2.5,0.0,-0.5}),'remainder scalar values 902')
end
do -- scalar remainder 903
 local a=np.array({0.0,-1.0,-1.0,-1.0},np.float32)
 local r=np.remainder(a,1)
 assert(r.dtype=='float32','remainder scalar dtype 903 '..r.dtype)
 assert(veq(r:tolist(),{0.0,0.0,0.0,0.0}),'remainder scalar values 903')
end
do -- scalar remainder 904
 local a=np.array({3.5,2.0,-0.0,2.0},np.float16)
 local r=np.remainder(-2.5,a)
 assert(r.dtype=='float16','remainder scalar dtype 904 '..r.dtype)
 assert(veq(r:tolist(),{1.0,1.5,(0/0),1.5}),'remainder scalar values 904')
end
do -- scalar remainder 905
 local a=np.array({3,-1,3,2},np.int32)
 local r=np.remainder(-0.0,a)
 assert(r.dtype=='float64','remainder scalar dtype 905 '..r.dtype)
 assert(veq(r:tolist(),{0.0,-0.0,0.0,0.0}),'remainder scalar values 905')
end
do -- scalar remainder 906
 local a=np.array({5,15,3,127},np.uint64)
 local r=np.remainder(a,-2.5)
 assert(r.dtype=='float64','remainder scalar dtype 906 '..r.dtype)
 assert(veq(r:tolist(),{-0.0,-0.0,-2.0,-0.5}),'remainder scalar values 906')
end
do -- scalar remainder 907
 local a=np.array({2,-31,1,-1},np.int32)
 local r=np.remainder(a,2)
 assert(r.dtype=='int32','remainder scalar dtype 907 '..r.dtype)
 assert(veq(r:tolist(),{0,1,1,1}),'remainder scalar values 907')
end
do -- scalar remainder 908
 local a=np.array({15,5,2,1},np.uint32)
 local r=np.remainder(2,a)
 assert(r.dtype=='uint32','remainder scalar dtype 908 '..r.dtype)
 assert(veq(r:tolist(),{2,2,0,0}),'remainder scalar values 908')
end
do -- scalar remainder 909
 local a=np.array({3,15,7,3},np.uint16)
 local r=np.remainder(10.0,a)
 assert(r.dtype=='float64','remainder scalar dtype 909 '..r.dtype)
 assert(veq(r:tolist(),{1.0,10.0,3.0,1.0}),'remainder scalar values 909')
end
do -- scalar remainder 910
 local a=np.array({true,false,false,false},np.bool)
 local r=np.remainder(a,true)
 assert(r.dtype=='int8','remainder scalar dtype 910 '..r.dtype)
 assert(veq(r:tolist(),{0,0,0,0}),'remainder scalar values 910')
end
do -- scalar power 911
 local a=np.array({1,3,31,2},np.uint64)
 local r=np.power(a,127)
 assert(r.dtype=='uint64','power scalar dtype 911 '..r.dtype)
 assert(veq(r:tolist(),{1,3080657310641694891,8862888976073264095,0}),'power scalar values 911')
end
do -- scalar error power 912
 local a=np.array({127,5,127,31},np.uint16)
 local ok=pcall(function() return np.power(a,-3) end)
 assert(not ok,'power scalar error 912')
end
do -- scalar power 913
 local a=np.array({1.0,-9.5,9.0,3.5},np.float64)
 local r=np.power(a,0.5)
 assert(r.dtype=='float64','power scalar dtype 913 '..r.dtype)
 assert(veq(r:tolist(),{1.0,(0/0),3.0,1.8708286933869707}),'power scalar values 913')
end
do -- scalar power 914
 local a=np.array({0.5,2.0,2.0,1.0},np.float64)
 local r=np.power(true,a)
 assert(r.dtype=='float64','power scalar dtype 914 '..r.dtype)
 assert(veq(r:tolist(),{1.0,1.0,1.0,1.0}),'power scalar values 914')
end
do -- scalar error power 915
 local a=np.array({2,2,30,-31},np.int32)
 local ok=pcall(function() return np.power(a,-1) end)
 assert(not ok,'power scalar error 915')
end
do -- scalar power 916
 local a=np.array({-1.0,-1.0,-3.0,2.0},np.float16)
 local r=np.power(a,-0.0)
 assert(r.dtype=='float16','power scalar dtype 916 '..r.dtype)
 assert(veq(r:tolist(),{1.0,1.0,1.0,1.0}),'power scalar values 916')
end
do -- scalar power 917
 local a=np.array({0.0,0.0,0.5,0.0},np.float32)
 local r=np.power(5,a)
 assert(r.dtype=='float32','power scalar dtype 917 '..r.dtype)
 assert(veq(r:tolist(),{1.0,1.0,2.2360680103302,1.0}),'power scalar values 917')
end
do -- scalar power 918
 local a=np.array({false,true,true,true},np.bool)
 local r=np.power(a,true)
 assert(r.dtype=='int8','power scalar dtype 918 '..r.dtype)
 assert(veq(r:tolist(),{0,1,1,1}),'power scalar values 918')
end
do -- scalar power 919
 local a=np.array({63,63,3,63},np.uint32)
 local r=np.power(a,10.0)
 assert(r.dtype=='float64','power scalar dtype 919 '..r.dtype)
 assert(veq(r:tolist(),{9.849302918817908e+17,9.849302918817908e+17,59049.0,9.849302918817908e+17}),'power scalar values 919')
end
do -- scalar error power 920
 local a=np.array({63,63,63,63},np.uint16)
 local ok=pcall(function() return np.power(a,-1) end)
 assert(not ok,'power scalar error 920')
end
do -- scalar power 921
 local a=np.array({2.0,-3.0,0.5,-0.0},np.float64)
 local r=np.power(1,a)
 assert(r.dtype=='float64','power scalar dtype 921 '..r.dtype)
 assert(veq(r:tolist(),{1.0,1.0,1.0,1.0}),'power scalar values 921')
end
do -- scalar power 922
 local a=np.array({-31,15,0,-9},np.int64)
 local r=np.power(a,2)
 assert(r.dtype=='int64','power scalar dtype 922 '..r.dtype)
 assert(veq(r:tolist(),{961,225,0,81}),'power scalar values 922')
end
do -- scalar power 923
 local a=np.array({3,-1,1,-31},np.int16)
 local r=np.power(a,5)
 assert(r.dtype=='int16','power scalar dtype 923 '..r.dtype)
 assert(veq(r:tolist(),{243,-1,1,10081}),'power scalar values 923')
end
do -- scalar error power 924
 local a=np.array({2,1,-9,0},np.int16)
 local ok=pcall(function() return np.power(a,-3) end)
 assert(not ok,'power scalar error 924')
end
do -- scalar power 925
 local a=np.array({30,3,-1,7},np.int16)
 local r=np.power(0.5,a)
 assert(r.dtype=='float64','power scalar dtype 925 '..r.dtype)
 assert(veq(r:tolist(),{9.313225746154785e-10,0.125,2.0,0.0078125}),'power scalar values 925')
end
do -- scalar power 926
 local a=np.array({-1.5,0.5,-9.5,1.0},np.float32)
 local r=np.power(-1,a)
 assert(r.dtype=='float32','power scalar dtype 926 '..r.dtype)
 assert(veq(r:tolist(),{(0/0),(0/0),(0/0),-1.0}),'power scalar values 926')
end
do -- scalar power 927
 local a=np.array({1.0,-1.0,9.0,2.0},np.float32)
 local r=np.power(a,true)
 assert(r.dtype=='float32','power scalar dtype 927 '..r.dtype)
 assert(veq(r:tolist(),{1.0,-1.0,9.0,2.0}),'power scalar values 927')
end
do -- scalar power 928
 local a=np.array({31,1,0,31},np.uint32)
 local r=np.power(1,a)
 assert(r.dtype=='uint32','power scalar dtype 928 '..r.dtype)
 assert(veq(r:tolist(),{1,1,1,1}),'power scalar values 928')
end
do -- scalar power 929
 local a=np.array({2.0,-0.0,0.0,3.5},np.float32)
 local r=np.power(a,true)
 assert(r.dtype=='float32','power scalar dtype 929 '..r.dtype)
 assert(veq(r:tolist(),{2.0,-0.0,0.0,3.5}),'power scalar values 929')
end
do -- scalar power 930
 local a=np.array({1.0,3.5,-1.5,-9.5},np.float64)
 local r=np.power(a,10.0)
 assert(r.dtype=='float64','power scalar dtype 930 '..r.dtype)
 assert(veq(r:tolist(),{1.0,275854.7353515625,57.6650390625,5987369392.383789}),'power scalar values 930')
end
do -- scalar power 931
 local a=np.array({1,2,0,15},np.uint32)
 local r=np.power(a,10.0)
 assert(r.dtype=='float64','power scalar dtype 931 '..r.dtype)
 assert(veq(r:tolist(),{1.0,1024.0,0.0,576650390625.0}),'power scalar values 931')
end
do -- scalar power 932
 local a=np.array({63,3,5,2},np.uint64)
 local r=np.power(true,a)
 assert(r.dtype=='uint64','power scalar dtype 932 '..r.dtype)
 assert(veq(r:tolist(),{1,1,1,1}),'power scalar values 932')
end
do -- scalar power 933
 local a=np.array({7,-31,30,2},np.int64)
 local r=np.power(a,0.5)
 assert(r.dtype=='float64','power scalar dtype 933 '..r.dtype)
 assert(veq(r:tolist(),{2.6457513110645907,(0/0),5.477225575051661,1.4142135623730951}),'power scalar values 933')
end
do -- scalar error power 934
 local a=np.array({3,1,30,7},np.int16)
 local ok=pcall(function() return np.power(a,-3) end)
 assert(not ok,'power scalar error 934')
end
do -- scalar power 935
 local a=np.array({31,1,127,31},np.uint32)
 local r=np.power(a,127)
 assert(r.dtype=='uint32','power scalar dtype 935 '..r.dtype)
 assert(veq(r:tolist(),{4002581471,1,2953838463,4002581471}),'power scalar values 935')
end
do -- scalar power 936
 local a=np.array({-9,3,2,-9},np.int32)
 local r=np.power(a,127)
 assert(r.dtype=='int32','power scalar dtype 936 '..r.dtype)
 assert(veq(r:tolist(),{-1445061177,-2088621909,0,-1445061177}),'power scalar values 936')
end
do -- scalar power 937
 local a=np.array({9.0,-9.5,0.0,1.0},np.float64)
 local r=np.power(-200,a)
 assert(r.dtype=='float64','power scalar dtype 937 '..r.dtype)
 assert(veq(r:tolist(),{-5.12e+20,(0/0),1.0,-200.0}),'power scalar values 937')
end
do -- scalar power 938
 local a=np.array({2.0,0.5,-9.5,-9.5},np.float64)
 local r=np.power(0,a)
 assert(r.dtype=='float64','power scalar dtype 938 '..r.dtype)
 assert(veq(r:tolist(),{0.0,0.0,math.huge,math.huge}),'power scalar values 938')
end
do -- scalar power 939
 local a=np.array({2.0,0.0,-1.0,-1.0},np.float64)
 local r=np.power(-1,a)
 assert(r.dtype=='float64','power scalar dtype 939 '..r.dtype)
 assert(veq(r:tolist(),{1.0,1.0,-1.0,-1.0}),'power scalar values 939')
end
do -- scalar power 940
 local a=np.array({5,5,15,31},np.uint64)
 local r=np.power(a,10.0)
 assert(r.dtype=='float64','power scalar dtype 940 '..r.dtype)
 assert(veq(r:tolist(),{9765625.0,9765625.0,576650390625.0,819628286980801.0}),'power scalar values 940')
end
do -- scalar error power 941
 local a=np.array({2,3,-9,15},np.int16)
 local ok=pcall(function() return np.power(a,-200) end)
 assert(not ok,'power scalar error 941')
end
do -- scalar power 942
 local a=np.array({1,63,63,5},np.uint16)
 local r=np.power(a,2)
 assert(r.dtype=='uint16','power scalar dtype 942 '..r.dtype)
 assert(veq(r:tolist(),{1,3969,3969,25}),'power scalar values 942')
end
do -- scalar error power 943
 local a=np.array({15,2,-1,-9},np.int16)
 local ok=pcall(function() return np.power(true,a) end)
 assert(not ok,'power scalar error 943')
end
do -- scalar error power 944
 local a=np.array({1,15,1,0},np.uint8)
 local ok=pcall(function() return np.power(-3,a) end)
 assert(not ok,'power scalar error 944')
end
do -- scalar power 945
 local a=np.array({-1.5,-1.5,9.0,3.5},np.float64)
 local r=np.power(0,a)
 assert(r.dtype=='float64','power scalar dtype 945 '..r.dtype)
 assert(veq(r:tolist(),{math.huge,math.huge,0.0,0.0}),'power scalar values 945')
end
do -- scalar power 946
 local a=np.array({2.0,-9.5,1.0,-1.0},np.float32)
 local r=np.power(false,a)
 assert(r.dtype=='float32','power scalar dtype 946 '..r.dtype)
 assert(veq(r:tolist(),{0.0,math.huge,0.0,math.huge}),'power scalar values 946')
end
do -- scalar power 947
 local a=np.array({-1.0,9.0,-9.5,-1.5},np.float64)
 local r=np.power(true,a)
 assert(r.dtype=='float64','power scalar dtype 947 '..r.dtype)
 assert(veq(r:tolist(),{1.0,1.0,1.0,1.0}),'power scalar values 947')
end
do -- scalar error power 948
 local a=np.array({31,15,15,15},np.uint16)
 local ok=pcall(function() return np.power(a,-1) end)
 assert(not ok,'power scalar error 948')
end
do -- scalar fmax 949
 local a=np.array({(0/0),9.0,3.5,-9.5},np.float32)
 local r=np.fmax(true,a)
 assert(r.dtype=='float32','fmax scalar dtype 949 '..r.dtype)
 assert(veq(r:tolist(),{1.0,9.0,3.5,1.0}),'fmax scalar values 949')
end
do -- scalar fmax 950
 local a=np.array({15,-31,-9,7},np.int16)
 local r=np.fmax(0,a)
 assert(r.dtype=='int16','fmax scalar dtype 950 '..r.dtype)
 assert(veq(r:tolist(),{15,0,0,7}),'fmax scalar values 950')
end
do -- scalar fmax 951
 local a=np.array({0.5,0.0,9.0,math.huge},np.float16)
 local r=np.fmax(a,-3)
 assert(r.dtype=='float16','fmax scalar dtype 951 '..r.dtype)
 assert(veq(r:tolist(),{0.5,0.0,9.0,math.huge}),'fmax scalar values 951')
end
do -- scalar error fmax 952
 local a=np.array({15,1,15,1},np.int8)
 local ok=pcall(function() return np.fmax(200,a) end)
 assert(not ok,'fmax scalar error 952')
end
do -- scalar fmax 953
 local a=np.array({3,15,15,7},np.int8)
 local r=np.fmax(a,1)
 assert(r.dtype=='int8','fmax scalar dtype 953 '..r.dtype)
 assert(veq(r:tolist(),{3,15,15,7}),'fmax scalar values 953')
end
do -- scalar fmax 954
 local a=np.array({-1,1,15,15},np.int16)
 local r=np.fmax(a,-2.5)
 assert(r.dtype=='float64','fmax scalar dtype 954 '..r.dtype)
 assert(veq(r:tolist(),{-1.0,1.0,15.0,15.0}),'fmax scalar values 954')
end
do -- scalar fmax 955
 local a=np.array({1,-1,-3,3},np.int32)
 local r=np.fmax(a,-1)
 assert(r.dtype=='int32','fmax scalar dtype 955 '..r.dtype)
 assert(veq(r:tolist(),{1,-1,-1,3}),'fmax scalar values 955')
end
do -- scalar fmax 956
 local a=np.array({9.0,math.huge,9.0,(0/0)},np.float32)
 local r=np.fmax(a,10.0)
 assert(r.dtype=='float32','fmax scalar dtype 956 '..r.dtype)
 assert(veq(r:tolist(),{10.0,math.huge,10.0,10.0}),'fmax scalar values 956')
end
do -- scalar error fmax 957
 local a=np.array({15,0,1,127},np.uint8)
 local ok=pcall(function() return np.fmax(-3,a) end)
 assert(not ok,'fmax scalar error 957')
end
do -- scalar fmax 958
 local a=np.array({-31,15,-31,-9},np.int16)
 local r=np.fmax(a,5)
 assert(r.dtype=='int16','fmax scalar dtype 958 '..r.dtype)
 assert(veq(r:tolist(),{5,15,5,5}),'fmax scalar values 958')
end
do -- scalar fmax 959
 local a=np.array({2,3,5,1},np.uint8)
 local r=np.fmax(true,a)
 assert(r.dtype=='uint8','fmax scalar dtype 959 '..r.dtype)
 assert(veq(r:tolist(),{2,3,5,1}),'fmax scalar values 959')
end
do -- scalar fmax 960
 local a=np.array({9.0,-1.5,-0.0,3.5},np.float64)
 local r=np.fmax(a,0)
 assert(r.dtype=='float64','fmax scalar dtype 960 '..r.dtype)
 assert(veq(r:tolist(),{9.0,0.0,0.0,3.5}),'fmax scalar values 960')
end
do -- scalar fmax 961
 local a=np.array({15,30,30,2},np.int16)
 local r=np.fmax(a,10.0)
 assert(r.dtype=='float64','fmax scalar dtype 961 '..r.dtype)
 assert(veq(r:tolist(),{15.0,30.0,30.0,10.0}),'fmax scalar values 961')
end
do -- scalar fmax 962
 local a=np.array({127,0,0,7},np.uint16)
 local r=np.fmax(a,0.5)
 assert(r.dtype=='float64','fmax scalar dtype 962 '..r.dtype)
 assert(veq(r:tolist(),{127.0,0.5,0.5,7.0}),'fmax scalar values 962')
end
do -- scalar fmax 963
 local a=np.array({5,2,0,63},np.uint16)
 local r=np.fmax(1,a)
 assert(r.dtype=='uint16','fmax scalar dtype 963 '..r.dtype)
 assert(veq(r:tolist(),{5,2,1,63}),'fmax scalar values 963')
end
do -- scalar fmax 964
 local a=np.array({-1.0,0.0,-3.0,-9.5},np.float32)
 local r=np.fmax(a,0.5)
 assert(r.dtype=='float32','fmax scalar dtype 964 '..r.dtype)
 assert(veq(r:tolist(),{0.5,0.5,0.5,0.5}),'fmax scalar values 964')
end
do -- scalar fmax 965
 local a=np.array({true,false,true,false},np.bool)
 local r=np.fmax(a,true)
 assert(r.dtype=='bool','fmax scalar dtype 965 '..r.dtype)
 assert(veq(r:tolist(),{true,true,true,true}),'fmax scalar values 965')
end
do -- scalar fmax 966
 local a=np.array({7,2,30,-31},np.int32)
 local r=np.fmax(a,127)
 assert(r.dtype=='int32','fmax scalar dtype 966 '..r.dtype)
 assert(veq(r:tolist(),{127,127,127,127}),'fmax scalar values 966')
end
do -- scalar error fmax 967
 local a=np.array({127,0,0,2},np.uint16)
 local ok=pcall(function() return np.fmax(a,-1) end)
 assert(not ok,'fmax scalar error 967')
end
do -- scalar fmax 968
 local a=np.array({true,true,true,false},np.bool)
 local r=np.fmax(-1,a)
 assert(r.dtype=='int64','fmax scalar dtype 968 '..r.dtype)
 assert(veq(r:tolist(),{1,1,1,0}),'fmax scalar values 968')
end
do -- scalar fmax 969
 local a=np.array({true,false,true,false},np.bool)
 local r=np.fmax(a,-1)
 assert(r.dtype=='int64','fmax scalar dtype 969 '..r.dtype)
 assert(veq(r:tolist(),{1,0,1,0}),'fmax scalar values 969')
end
do -- scalar fmax 970
 local a=np.array({-9,-3,30,15},np.int16)
 local r=np.fmax(a,true)
 assert(r.dtype=='int16','fmax scalar dtype 970 '..r.dtype)
 assert(veq(r:tolist(),{1,1,30,15}),'fmax scalar values 970')
end
do -- scalar fmax 971
 local a=np.array({2,-1,7,-1},np.int16)
 local r=np.fmax(a,false)
 assert(r.dtype=='int16','fmax scalar dtype 971 '..r.dtype)
 assert(veq(r:tolist(),{2,0,7,0}),'fmax scalar values 971')
end
do -- scalar fmax 972
 local a=np.array({5,0,0,0},np.uint32)
 local r=np.fmax(2,a)
 assert(r.dtype=='uint32','fmax scalar dtype 972 '..r.dtype)
 assert(veq(r:tolist(),{5,2,2,2}),'fmax scalar values 972')
end
do -- scalar fmax 973
 local a=np.array({0.5,-math.huge,(0/0),0.0},np.float32)
 local r=np.fmax(a,200)
 assert(r.dtype=='float32','fmax scalar dtype 973 '..r.dtype)
 assert(veq(r:tolist(),{200.0,200.0,200.0,200.0}),'fmax scalar values 973')
end
do -- scalar fmax 974
 local a=np.array({30,-31,7,1},np.int8)
 local r=np.fmax(a,true)
 assert(r.dtype=='int8','fmax scalar dtype 974 '..r.dtype)
 assert(veq(r:tolist(),{30,1,7,1}),'fmax scalar values 974')
end
do -- scalar fmax 975
 local a=np.array({-0.0,-3.0,-0.0,(0/0)},np.float64)
 local r=np.fmax(1,a)
 assert(r.dtype=='float64','fmax scalar dtype 975 '..r.dtype)
 assert(veq(r:tolist(),{1.0,1.0,1.0,1.0}),'fmax scalar values 975')
end
do -- scalar fmax 976
 local a=np.array({2,-9,30,2},np.int32)
 local r=np.fmax(5,a)
 assert(r.dtype=='int32','fmax scalar dtype 976 '..r.dtype)
 assert(veq(r:tolist(),{5,5,30,5}),'fmax scalar values 976')
end
do -- scalar error fmax 977
 local a=np.array({0,31,3,7},np.uint16)
 local ok=pcall(function() return np.fmax(a,-1) end)
 assert(not ok,'fmax scalar error 977')
end
do -- scalar fmax 978
 local a=np.array({true,true,false,false},np.bool)
 local r=np.fmax(-1,a)
 assert(r.dtype=='int64','fmax scalar dtype 978 '..r.dtype)
 assert(veq(r:tolist(),{1,1,0,0}),'fmax scalar values 978')
end
do -- scalar fmax 979
 local a=np.array({-9.5,math.huge,math.huge,-1.5},np.float16)
 local r=np.fmax(-1,a)
 assert(r.dtype=='float16','fmax scalar dtype 979 '..r.dtype)
 assert(veq(r:tolist(),{-1.0,math.huge,math.huge,-1.0}),'fmax scalar values 979')
end
do -- scalar fmax 980
 local a=np.array({63,5,3,15},np.uint32)
 local r=np.fmax(-2.5,a)
 assert(r.dtype=='float64','fmax scalar dtype 980 '..r.dtype)
 assert(veq(r:tolist(),{63.0,5.0,3.0,15.0}),'fmax scalar values 980')
end
do -- scalar fmax 981
 local a=np.array({0.5,0.5,9.0,1.0},np.float16)
 local r=np.fmax(a,false)
 assert(r.dtype=='float16','fmax scalar dtype 981 '..r.dtype)
 assert(veq(r:tolist(),{0.5,0.5,9.0,1.0}),'fmax scalar values 981')
end
do -- scalar fmax 982
 local a=np.array({2,127,0,0},np.uint16)
 local r=np.fmax(200,a)
 assert(r.dtype=='uint16','fmax scalar dtype 982 '..r.dtype)
 assert(veq(r:tolist(),{200,200,200,200}),'fmax scalar values 982')
end
do -- scalar error fmax 983
 local a=np.array({7,2,2,31},np.uint8)
 local ok=pcall(function() return np.fmax(-1,a) end)
 assert(not ok,'fmax scalar error 983')
end
do -- scalar fmax 984
 local a=np.array({0,2,3,-3},np.int64)
 local r=np.fmax(200,a)
 assert(r.dtype=='int64','fmax scalar dtype 984 '..r.dtype)
 assert(veq(r:tolist(),{200,200,200,200}),'fmax scalar values 984')
end
do -- scalar fmax 985
 local a=np.array({15,0,31,1},np.uint32)
 local r=np.fmax(a,2.0)
 assert(r.dtype=='float64','fmax scalar dtype 985 '..r.dtype)
 assert(veq(r:tolist(),{15.0,2.0,31.0,2.0}),'fmax scalar values 985')
end
do -- scalar fmax 986
 local a=np.array({2,0,1,5},np.uint16)
 local r=np.fmax(false,a)
 assert(r.dtype=='uint16','fmax scalar dtype 986 '..r.dtype)
 assert(veq(r:tolist(),{2,0,1,5}),'fmax scalar values 986')
end
do -- scalar fmin 987
 local a=np.array({true,false,false,true},np.bool)
 local r=np.fmin(a,127)
 assert(r.dtype=='int64','fmin scalar dtype 987 '..r.dtype)
 assert(veq(r:tolist(),{1,0,0,1}),'fmin scalar values 987')
end
do -- scalar fmin 988
 local a=np.array({2,7,-1,-3},np.int8)
 local r=np.fmin(a,0)
 assert(r.dtype=='int8','fmin scalar dtype 988 '..r.dtype)
 assert(veq(r:tolist(),{0,0,-1,-3}),'fmin scalar values 988')
end
do -- scalar fmin 989
 local a=np.array({2.0,-1.0,math.huge,-1.0},np.float16)
 local r=np.fmin(true,a)
 assert(r.dtype=='float16','fmin scalar dtype 989 '..r.dtype)
 assert(veq(r:tolist(),{1.0,-1.0,1.0,-1.0}),'fmin scalar values 989')
end
do -- scalar fmin 990
 local a=np.array({-3,0,-3,2},np.int64)
 local r=np.fmin(0,a)
 assert(r.dtype=='int64','fmin scalar dtype 990 '..r.dtype)
 assert(veq(r:tolist(),{-3,0,-3,0}),'fmin scalar values 990')
end
do -- scalar fmin 991
 local a=np.array({-9,3,7,-1},np.int32)
 local r=np.fmin(a,10.0)
 assert(r.dtype=='float64','fmin scalar dtype 991 '..r.dtype)
 assert(veq(r:tolist(),{-9.0,3.0,7.0,-1.0}),'fmin scalar values 991')
end
do -- scalar fmin 992
 local a=np.array({-9.5,9.0,-3.0,-1.0},np.float16)
 local r=np.fmin(false,a)
 assert(r.dtype=='float16','fmin scalar dtype 992 '..r.dtype)
 assert(veq(r:tolist(),{-9.5,0.0,-3.0,-1.0}),'fmin scalar values 992')
end
do -- scalar fmin 993
 local a=np.array({(0/0),-3.0,-1.5,-1.0},np.float16)
 local r=np.fmin(-3,a)
 assert(r.dtype=='float16','fmin scalar dtype 993 '..r.dtype)
 assert(veq(r:tolist(),{-3.0,-3.0,-3.0,-3.0}),'fmin scalar values 993')
end
do -- scalar fmin 994
 local a=np.array({0,-3,-9,-1},np.int16)
 local r=np.fmin(-1,a)
 assert(r.dtype=='int16','fmin scalar dtype 994 '..r.dtype)
 assert(veq(r:tolist(),{-1,-3,-9,-1}),'fmin scalar values 994')
end
do -- scalar fmin 995
 local a=np.array({-1.0,(0/0),-1.5,-3.0},np.float16)
 local r=np.fmin(0.5,a)
 assert(r.dtype=='float16','fmin scalar dtype 995 '..r.dtype)
 assert(veq(r:tolist(),{-1.0,0.5,-1.5,-3.0}),'fmin scalar values 995')
end
do -- scalar fmin 996
 local a=np.array({31,7,1,7},np.uint64)
 local r=np.fmin(2,a)
 assert(r.dtype=='uint64','fmin scalar dtype 996 '..r.dtype)
 assert(veq(r:tolist(),{2,2,1,2}),'fmin scalar values 996')
end
do -- scalar fmin 997
 local a=np.array({-1.5,0.0,-1.5,1.0},np.float64)
 local r=np.fmin(-0.0,a)
 assert(r.dtype=='float64','fmin scalar dtype 997 '..r.dtype)
 assert(veq(r:tolist(),{-1.5,0.0,-1.5,-0.0}),'fmin scalar values 997')
end
do -- scalar fmin 998
 local a=np.array({0,15,3,3},np.uint64)
 local r=np.fmin(10.0,a)
 assert(r.dtype=='float64','fmin scalar dtype 998 '..r.dtype)
 assert(veq(r:tolist(),{0.0,10.0,3.0,3.0}),'fmin scalar values 998')
end
do -- scalar fmin 999
 local a=np.array({30,15,0,-31},np.int8)
 local r=np.fmin(a,-1)
 assert(r.dtype=='int8','fmin scalar dtype 999 '..r.dtype)
 assert(veq(r:tolist(),{-1,-1,-1,-31}),'fmin scalar values 999')
end
do -- scalar fmin 1000
 local a=np.array({127,31,2,15},np.uint8)
 local r=np.fmin(a,1)
 assert(r.dtype=='uint8','fmin scalar dtype 1000 '..r.dtype)
 assert(veq(r:tolist(),{1,1,1,1}),'fmin scalar values 1000')
end
do -- scalar fmin 1001
 local a=np.array({0,2,-1,-1},np.int64)
 local r=np.fmin(a,200)
 assert(r.dtype=='int64','fmin scalar dtype 1001 '..r.dtype)
 assert(veq(r:tolist(),{0,2,-1,-1}),'fmin scalar values 1001')
end
do -- scalar fmin 1002
 local a=np.array({63,5,3,2},np.uint32)
 local r=np.fmin(5,a)
 assert(r.dtype=='uint32','fmin scalar dtype 1002 '..r.dtype)
 assert(veq(r:tolist(),{5,5,3,2}),'fmin scalar values 1002')
end
do -- scalar fmin 1003
 local a=np.array({9.0,-3.0,0.5,math.huge},np.float32)
 local r=np.fmin(-0.0,a)
 assert(r.dtype=='float32','fmin scalar dtype 1003 '..r.dtype)
 assert(veq(r:tolist(),{-0.0,-3.0,-0.0,-0.0}),'fmin scalar values 1003')
end
do -- scalar fmin 1004
 local a=np.array({15,0,7,63},np.uint64)
 local r=np.fmin(2,a)
 assert(r.dtype=='uint64','fmin scalar dtype 1004 '..r.dtype)
 assert(veq(r:tolist(),{2,0,2,2}),'fmin scalar values 1004')
end
do -- scalar fmin 1005
 local a=np.array({-3.0,3.5,-1.5,-1.5},np.float64)
 local r=np.fmin(true,a)
 assert(r.dtype=='float64','fmin scalar dtype 1005 '..r.dtype)
 assert(veq(r:tolist(),{-3.0,1.0,-1.5,-1.5}),'fmin scalar values 1005')
end
do -- scalar fmin 1006
 local a=np.array({7,1,5,2},np.uint64)
 local r=np.fmin(-0.0,a)
 assert(r.dtype=='float64','fmin scalar dtype 1006 '..r.dtype)
 assert(veq(r:tolist(),{-0.0,-0.0,-0.0,-0.0}),'fmin scalar values 1006')
end
do -- scalar fmin 1007
 local a=np.array({1,7,31,63},np.uint64)
 local r=np.fmin(a,200)
 assert(r.dtype=='uint64','fmin scalar dtype 1007 '..r.dtype)
 assert(veq(r:tolist(),{1,7,31,63}),'fmin scalar values 1007')
end
do -- scalar fmin 1008
 local a=np.array({1,2,7,-1},np.int16)
 local r=np.fmin(a,200)
 assert(r.dtype=='int16','fmin scalar dtype 1008 '..r.dtype)
 assert(veq(r:tolist(),{1,2,7,-1}),'fmin scalar values 1008')
end
do -- scalar fmin 1009
 local a=np.array({127,127,0,0},np.uint16)
 local r=np.fmin(0,a)
 assert(r.dtype=='uint16','fmin scalar dtype 1009 '..r.dtype)
 assert(veq(r:tolist(),{0,0,0,0}),'fmin scalar values 1009')
end
do -- scalar fmin 1010
 local a=np.array({1,0,30,3},np.int8)
 local r=np.fmin(-3,a)
 assert(r.dtype=='int8','fmin scalar dtype 1010 '..r.dtype)
 assert(veq(r:tolist(),{-3,-3,-3,-3}),'fmin scalar values 1010')
end
do -- scalar fmin 1011
 local a=np.array({3,-31,-1,1},np.int8)
 local r=np.fmin(a,true)
 assert(r.dtype=='int8','fmin scalar dtype 1011 '..r.dtype)
 assert(veq(r:tolist(),{1,-31,-1,1}),'fmin scalar values 1011')
end
do -- scalar fmin 1012
 local a=np.array({3,63,2,0},np.uint64)
 local r=np.fmin(10.0,a)
 assert(r.dtype=='float64','fmin scalar dtype 1012 '..r.dtype)
 assert(veq(r:tolist(),{3.0,10.0,2.0,0.0}),'fmin scalar values 1012')
end
do -- scalar fmin 1013
 local a=np.array({3.5,0.5,3.5,-9.5},np.float64)
 local r=np.fmin(a,false)
 assert(r.dtype=='float64','fmin scalar dtype 1013 '..r.dtype)
 assert(veq(r:tolist(),{0.0,0.0,0.0,-9.5}),'fmin scalar values 1013')
end
do -- scalar fmin 1014
 local a=np.array({true,true,false,false},np.bool)
 local r=np.fmin(a,1)
 assert(r.dtype=='int64','fmin scalar dtype 1014 '..r.dtype)
 assert(veq(r:tolist(),{1,1,0,0}),'fmin scalar values 1014')
end
do -- scalar fmin 1015
 local a=np.array({15,-9,7,2},np.int32)
 local r=np.fmin(a,false)
 assert(r.dtype=='int32','fmin scalar dtype 1015 '..r.dtype)
 assert(veq(r:tolist(),{0,-9,0,0}),'fmin scalar values 1015')
end
do -- scalar fmin 1016
 local a=np.array({15,1,-3,30},np.int8)
 local r=np.fmin(-3,a)
 assert(r.dtype=='int8','fmin scalar dtype 1016 '..r.dtype)
 assert(veq(r:tolist(),{-3,-3,-3,-3}),'fmin scalar values 1016')
end
do -- scalar fmin 1017
 local a=np.array({5,15,127,15},np.uint64)
 local r=np.fmin(a,2)
 assert(r.dtype=='uint64','fmin scalar dtype 1017 '..r.dtype)
 assert(veq(r:tolist(),{2,2,2,2}),'fmin scalar values 1017')
end
do -- scalar fmin 1018
 local a=np.array({127,63,127,3},np.uint8)
 local r=np.fmin(a,0)
 assert(r.dtype=='uint8','fmin scalar dtype 1018 '..r.dtype)
 assert(veq(r:tolist(),{0,0,0,0}),'fmin scalar values 1018')
end
do -- scalar fmin 1019
 local a=np.array({0,127,63,2},np.uint16)
 local r=np.fmin(-0.0,a)
 assert(r.dtype=='float64','fmin scalar dtype 1019 '..r.dtype)
 assert(veq(r:tolist(),{-0.0,-0.0,-0.0,-0.0}),'fmin scalar values 1019')
end
do -- scalar fmin 1020
 local a=np.array({false,true,true,true},np.bool)
 local r=np.fmin(true,a)
 assert(r.dtype=='bool','fmin scalar dtype 1020 '..r.dtype)
 assert(veq(r:tolist(),{false,true,true,true}),'fmin scalar values 1020')
end
do -- scalar fmin 1021
 local a=np.array({31,15,5,5},np.uint8)
 local r=np.fmin(0,a)
 assert(r.dtype=='uint8','fmin scalar dtype 1021 '..r.dtype)
 assert(veq(r:tolist(),{0,0,0,0}),'fmin scalar values 1021')
end
do -- scalar fmin 1022
 local a=np.array({15,-9,2,1},np.int64)
 local r=np.fmin(a,2.0)
 assert(r.dtype=='float64','fmin scalar dtype 1022 '..r.dtype)
 assert(veq(r:tolist(),{2.0,-9.0,2.0,1.0}),'fmin scalar values 1022')
end
do -- scalar fmin 1023
 local a=np.array({7,7,3,3},np.uint8)
 local r=np.fmin(false,a)
 assert(r.dtype=='uint8','fmin scalar dtype 1023 '..r.dtype)
 assert(veq(r:tolist(),{0,0,0,0}),'fmin scalar values 1023')
end
do -- scalar fmin 1024
 local a=np.array({127,7,0,1},np.uint16)
 local r=np.fmin(a,false)
 assert(r.dtype=='uint16','fmin scalar dtype 1024 '..r.dtype)
 assert(veq(r:tolist(),{0,0,0,0}),'fmin scalar values 1024')
end
do -- scalar error bitwise_and 1025
 local a=np.array({7,7,1,30},np.int32)
 local ok=pcall(function() return np.bitwise_and(a,2.0) end)
 assert(not ok,'bitwise_and scalar error 1025')
end
do -- scalar bitwise_and 1026
 local a=np.array({31,3,5,15},np.uint16)
 local r=np.bitwise_and(a,2)
 assert(r.dtype=='uint16','bitwise_and scalar dtype 1026 '..r.dtype)
 assert(veq(r:tolist(),{2,2,0,2}),'bitwise_and scalar values 1026')
end
do -- scalar error bitwise_and 1027
 local a=np.array({127,31,2,0},np.uint64)
 local ok=pcall(function() return np.bitwise_and(a,-3) end)
 assert(not ok,'bitwise_and scalar error 1027')
end
do -- scalar bitwise_and 1028
 local a=np.array({30,-9,2,-3},np.int8)
 local r=np.bitwise_and(a,false)
 assert(r.dtype=='int8','bitwise_and scalar dtype 1028 '..r.dtype)
 assert(veq(r:tolist(),{0,0,0,0}),'bitwise_and scalar values 1028')
end
do -- scalar error bitwise_and 1029
 local a=np.array({9.0,1.0,1.0,1.0},np.float32)
 local ok=pcall(function() return np.bitwise_and(a,-3) end)
 assert(not ok,'bitwise_and scalar error 1029')
end
do -- scalar error bitwise_and 1030
 local a=np.array({2,0,0,-31},np.int8)
 local ok=pcall(function() return np.bitwise_and(a,200) end)
 assert(not ok,'bitwise_and scalar error 1030')
end
do -- scalar bitwise_and 1031
 local a=np.array({127,31,5,2},np.uint64)
 local r=np.bitwise_and(a,127)
 assert(r.dtype=='uint64','bitwise_and scalar dtype 1031 '..r.dtype)
 assert(veq(r:tolist(),{127,31,5,2}),'bitwise_and scalar values 1031')
end
do -- scalar error bitwise_and 1032
 local a=np.array({2,-3,-9,0},np.int32)
 local ok=pcall(function() return np.bitwise_and(-2.5,a) end)
 assert(not ok,'bitwise_and scalar error 1032')
end
do -- scalar bitwise_and 1033
 local a=np.array({15,127,127,63},np.uint64)
 local r=np.bitwise_and(a,0)
 assert(r.dtype=='uint64','bitwise_and scalar dtype 1033 '..r.dtype)
 assert(veq(r:tolist(),{0,0,0,0}),'bitwise_and scalar values 1033')
end
do -- scalar error bitwise_and 1034
 local a=np.array({1,127,127,0},np.uint16)
 local ok=pcall(function() return np.bitwise_and(-0.0,a) end)
 assert(not ok,'bitwise_and scalar error 1034')
end
do -- scalar bitwise_and 1035
 local a=np.array({2,0,15,2},np.uint8)
 local r=np.bitwise_and(a,127)
 assert(r.dtype=='uint8','bitwise_and scalar dtype 1035 '..r.dtype)
 assert(veq(r:tolist(),{2,0,15,2}),'bitwise_and scalar values 1035')
end
do -- scalar error bitwise_and 1036
 local a=np.array({15,-9,0,15},np.int64)
 local ok=pcall(function() return np.bitwise_and(a,0.5) end)
 assert(not ok,'bitwise_and scalar error 1036')
end
do -- scalar bitwise_and 1037
 local a=np.array({7,7,15,15},np.int8)
 local r=np.bitwise_and(a,2)
 assert(r.dtype=='int8','bitwise_and scalar dtype 1037 '..r.dtype)
 assert(veq(r:tolist(),{2,2,2,2}),'bitwise_and scalar values 1037')
end
do -- scalar error bitwise_and 1038
 local a=np.array({-9,1,30,-31},np.int64)
 local ok=pcall(function() return np.bitwise_and(10.0,a) end)
 assert(not ok,'bitwise_and scalar error 1038')
end
do -- scalar error bitwise_and 1039
 local a=np.array({false,false,true,false},np.bool)
 local ok=pcall(function() return np.bitwise_and(10.0,a) end)
 assert(not ok,'bitwise_and scalar error 1039')
end
do -- scalar bitwise_and 1040
 local a=np.array({-31,1,30,-3},np.int32)
 local r=np.bitwise_and(a,false)
 assert(r.dtype=='int32','bitwise_and scalar dtype 1040 '..r.dtype)
 assert(veq(r:tolist(),{0,0,0,0}),'bitwise_and scalar values 1040')
end
do -- scalar error bitwise_and 1041
 local a=np.array({-1.5,-1.0,2.0,0.5},np.float16)
 local ok=pcall(function() return np.bitwise_and(5,a) end)
 assert(not ok,'bitwise_and scalar error 1041')
end
do -- scalar error bitwise_and 1042
 local a=np.array({3.5,9.0,-0.0,3.5},np.float16)
 local ok=pcall(function() return np.bitwise_and(0.5,a) end)
 assert(not ok,'bitwise_and scalar error 1042')
end
do -- scalar bitwise_and 1043
 local a=np.array({7,2,127,7},np.uint32)
 local r=np.bitwise_and(127,a)
 assert(r.dtype=='uint32','bitwise_and scalar dtype 1043 '..r.dtype)
 assert(veq(r:tolist(),{7,2,127,7}),'bitwise_and scalar values 1043')
end
do -- scalar error bitwise_and 1044
 local a=np.array({3,2,-9,15},np.int64)
 local ok=pcall(function() return np.bitwise_and(a,2.0) end)
 assert(not ok,'bitwise_and scalar error 1044')
end
do -- scalar error bitwise_and 1045
 local a=np.array({30,2,-1,2},np.int64)
 local ok=pcall(function() return np.bitwise_and(a,10.0) end)
 assert(not ok,'bitwise_and scalar error 1045')
end
do -- scalar error bitwise_and 1046
 local a=np.array({0.0,-3.0,-1.5,3.5},np.float64)
 local ok=pcall(function() return np.bitwise_and(10.0,a) end)
 assert(not ok,'bitwise_and scalar error 1046')
end
do -- scalar bitwise_and 1047
 local a=np.array({7,-3,0,1},np.int32)
 local r=np.bitwise_and(a,5)
 assert(r.dtype=='int32','bitwise_and scalar dtype 1047 '..r.dtype)
 assert(veq(r:tolist(),{5,5,0,1}),'bitwise_and scalar values 1047')
end
do -- scalar error bitwise_and 1048
 local a=np.array({0,-1,-9,0},np.int8)
 local ok=pcall(function() return np.bitwise_and(a,-0.0) end)
 assert(not ok,'bitwise_and scalar error 1048')
end
do -- scalar error bitwise_and 1049
 local a=np.array({-3,-3,-3,-9},np.int8)
 local ok=pcall(function() return np.bitwise_and(a,-200) end)
 assert(not ok,'bitwise_and scalar error 1049')
end
do -- scalar error bitwise_and 1050
 local a=np.array({9.0,2.0,-0.0,1.0},np.float32)
 local ok=pcall(function() return np.bitwise_and(a,true) end)
 assert(not ok,'bitwise_and scalar error 1050')
end
do -- scalar bitwise_and 1051
 local a=np.array({7,30,7,7},np.int16)
 local r=np.bitwise_and(0,a)
 assert(r.dtype=='int16','bitwise_and scalar dtype 1051 '..r.dtype)
 assert(veq(r:tolist(),{0,0,0,0}),'bitwise_and scalar values 1051')
end
do -- scalar bitwise_and 1052
 local a=np.array({0,0,5,0},np.uint16)
 local r=np.bitwise_and(false,a)
 assert(r.dtype=='uint16','bitwise_and scalar dtype 1052 '..r.dtype)
 assert(veq(r:tolist(),{0,0,0,0}),'bitwise_and scalar values 1052')
end
do -- scalar error bitwise_and 1053
 local a=np.array({-1.5,3.5,0.0,0.5},np.float64)
 local ok=pcall(function() return np.bitwise_and(a,-2.5) end)
 assert(not ok,'bitwise_and scalar error 1053')
end
do -- scalar error bitwise_and 1054
 local a=np.array({false,false,false,false},np.bool)
 local ok=pcall(function() return np.bitwise_and(-0.0,a) end)
 assert(not ok,'bitwise_and scalar error 1054')
end
do -- scalar bitwise_and 1055
 local a=np.array({false,true,false,true},np.bool)
 local r=np.bitwise_and(a,1)
 assert(r.dtype=='int64','bitwise_and scalar dtype 1055 '..r.dtype)
 assert(veq(r:tolist(),{0,1,0,1}),'bitwise_and scalar values 1055')
end
do -- scalar bitwise_and 1056
 local a=np.array({7,7,-3,1},np.int8)
 local r=np.bitwise_and(127,a)
 assert(r.dtype=='int8','bitwise_and scalar dtype 1056 '..r.dtype)
 assert(veq(r:tolist(),{7,7,125,1}),'bitwise_and scalar values 1056')
end
do -- scalar error bitwise_and 1057
 local a=np.array({-1.5,2.0,1.0,1.0},np.float32)
 local ok=pcall(function() return np.bitwise_and(0,a) end)
 assert(not ok,'bitwise_and scalar error 1057')
end
do -- scalar bitwise_and 1058
 local a=np.array({0,5,0,7},np.uint16)
 local r=np.bitwise_and(a,false)
 assert(r.dtype=='uint16','bitwise_and scalar dtype 1058 '..r.dtype)
 assert(veq(r:tolist(),{0,0,0,0}),'bitwise_and scalar values 1058')
end
do -- scalar bitwise_and 1059
 local a=np.array({2,-3,1,7},np.int16)
 local r=np.bitwise_and(0,a)
 assert(r.dtype=='int16','bitwise_and scalar dtype 1059 '..r.dtype)
 assert(veq(r:tolist(),{0,0,0,0}),'bitwise_and scalar values 1059')
end
do -- scalar error bitwise_and 1060
 local a=np.array({-3,3,30,-3},np.int64)
 local ok=pcall(function() return np.bitwise_and(0.5,a) end)
 assert(not ok,'bitwise_and scalar error 1060')
end
do -- scalar error bitwise_and 1061
 local a=np.array({9.0,-3.0,-0.0,1.0},np.float16)
 local ok=pcall(function() return np.bitwise_and(a,0) end)
 assert(not ok,'bitwise_and scalar error 1061')
end
do -- scalar error bitwise_and 1062
 local a=np.array({1.0,-0.0,2.0,-1.0},np.float32)
 local ok=pcall(function() return np.bitwise_and(false,a) end)
 assert(not ok,'bitwise_and scalar error 1062')
end
do -- scalar bitwise_or 1063
 local a=np.array({0,7,15,127},np.uint8)
 local r=np.bitwise_or(a,1)
 assert(r.dtype=='uint8','bitwise_or scalar dtype 1063 '..r.dtype)
 assert(veq(r:tolist(),{1,7,15,127}),'bitwise_or scalar values 1063')
end
do -- scalar error bitwise_or 1064
 local a=np.array({31,0,5,3},np.uint32)
 local ok=pcall(function() return np.bitwise_or(-1,a) end)
 assert(not ok,'bitwise_or scalar error 1064')
end
do -- scalar bitwise_or 1065
 local a=np.array({-9,7,-9,2},np.int16)
 local r=np.bitwise_or(false,a)
 assert(r.dtype=='int16','bitwise_or scalar dtype 1065 '..r.dtype)
 assert(veq(r:tolist(),{-9,7,-9,2}),'bitwise_or scalar values 1065')
end
do -- scalar error bitwise_or 1066
 local a=np.array({0.5,-0.0,2.0,-0.0},np.float16)
 local ok=pcall(function() return np.bitwise_or(10.0,a) end)
 assert(not ok,'bitwise_or scalar error 1066')
end
do -- scalar bitwise_or 1067
 local a=np.array({7,1,30,-9},np.int32)
 local r=np.bitwise_or(a,-3)
 assert(r.dtype=='int32','bitwise_or scalar dtype 1067 '..r.dtype)
 assert(veq(r:tolist(),{-1,-3,-1,-1}),'bitwise_or scalar values 1067')
end
do -- scalar error bitwise_or 1068
 local a=np.array({31,1,127,3},np.uint32)
 local ok=pcall(function() return np.bitwise_or(a,-3) end)
 assert(not ok,'bitwise_or scalar error 1068')
end
do -- scalar bitwise_or 1069
 local a=np.array({7,3,5,31},np.uint16)
 local r=np.bitwise_or(true,a)
 assert(r.dtype=='uint16','bitwise_or scalar dtype 1069 '..r.dtype)
 assert(veq(r:tolist(),{7,3,5,31}),'bitwise_or scalar values 1069')
end
do -- scalar bitwise_or 1070
 local a=np.array({2,0,2,7},np.uint16)
 local r=np.bitwise_or(0,a)
 assert(r.dtype=='uint16','bitwise_or scalar dtype 1070 '..r.dtype)
 assert(veq(r:tolist(),{2,0,2,7}),'bitwise_or scalar values 1070')
end
do -- scalar bitwise_or 1071
 local a=np.array({15,1,0,-3},np.int8)
 local r=np.bitwise_or(false,a)
 assert(r.dtype=='int8','bitwise_or scalar dtype 1071 '..r.dtype)
 assert(veq(r:tolist(),{15,1,0,-3}),'bitwise_or scalar values 1071')
end
do -- scalar bitwise_or 1072
 local a=np.array({30,30,-9,7},np.int16)
 local r=np.bitwise_or(a,-200)
 assert(r.dtype=='int16','bitwise_or scalar dtype 1072 '..r.dtype)
 assert(veq(r:tolist(),{-194,-194,-1,-193}),'bitwise_or scalar values 1072')
end
do -- scalar bitwise_or 1073
 local a=np.array({0,30,1,2},np.int64)
 local r=np.bitwise_or(a,true)
 assert(r.dtype=='int64','bitwise_or scalar dtype 1073 '..r.dtype)
 assert(veq(r:tolist(),{1,31,1,3}),'bitwise_or scalar values 1073')
end
do -- scalar error bitwise_or 1074
 local a=np.array({-3,7,-9,15},np.int8)
 local ok=pcall(function() return np.bitwise_or(-200,a) end)
 assert(not ok,'bitwise_or scalar error 1074')
end
do -- scalar bitwise_or 1075
 local a=np.array({31,15,5,15},np.uint8)
 local r=np.bitwise_or(a,false)
 assert(r.dtype=='uint8','bitwise_or scalar dtype 1075 '..r.dtype)
 assert(veq(r:tolist(),{31,15,5,15}),'bitwise_or scalar values 1075')
end
do -- scalar bitwise_or 1076
 local a=np.array({127,63,31,0},np.uint64)
 local r=np.bitwise_or(true,a)
 assert(r.dtype=='uint64','bitwise_or scalar dtype 1076 '..r.dtype)
 assert(veq(r:tolist(),{127,63,31,1}),'bitwise_or scalar values 1076')
end
do -- scalar error bitwise_or 1077
 local a=np.array({-1.0,2.0,1.0,3.5},np.float64)
 local ok=pcall(function() return np.bitwise_or(2,a) end)
 assert(not ok,'bitwise_or scalar error 1077')
end
do -- scalar error bitwise_or 1078
 local a=np.array({-31,-1,0,-31},np.int8)
 local ok=pcall(function() return np.bitwise_or(200,a) end)
 assert(not ok,'bitwise_or scalar error 1078')
end
do -- scalar bitwise_or 1079
 local a=np.array({-3,-1,-9,3},np.int64)
 local r=np.bitwise_or(a,true)
 assert(r.dtype=='int64','bitwise_or scalar dtype 1079 '..r.dtype)
 assert(veq(r:tolist(),{-3,-1,-9,3}),'bitwise_or scalar values 1079')
end
do -- scalar error bitwise_or 1080
 local a=np.array({1.0,9.0,1.0,9.0},np.float64)
 local ok=pcall(function() return np.bitwise_or(-200,a) end)
 assert(not ok,'bitwise_or scalar error 1080')
end
do -- scalar bitwise_or 1081
 local a=np.array({15,-1,-9,1},np.int64)
 local r=np.bitwise_or(a,0)
 assert(r.dtype=='int64','bitwise_or scalar dtype 1081 '..r.dtype)
 assert(veq(r:tolist(),{15,-1,-9,1}),'bitwise_or scalar values 1081')
end
do -- scalar bitwise_or 1082
 local a=np.array({3,0,0,15},np.int8)
 local r=np.bitwise_or(true,a)
 assert(r.dtype=='int8','bitwise_or scalar dtype 1082 '..r.dtype)
 assert(veq(r:tolist(),{3,1,1,15}),'bitwise_or scalar values 1082')
end
do -- scalar error bitwise_or 1083
 local a=np.array({3,-9,-9,-1},np.int64)
 local ok=pcall(function() return np.bitwise_or(0.5,a) end)
 assert(not ok,'bitwise_or scalar error 1083')
end
do -- scalar error bitwise_or 1084
 local a=np.array({9.0,-3.0,-0.0,1.0},np.float64)
 local ok=pcall(function() return np.bitwise_or(a,2) end)
 assert(not ok,'bitwise_or scalar error 1084')
end
do -- scalar bitwise_or 1085
 local a=np.array({-9,0,7,-31},np.int8)
 local r=np.bitwise_or(127,a)
 assert(r.dtype=='int8','bitwise_or scalar dtype 1085 '..r.dtype)
 assert(veq(r:tolist(),{-1,127,127,-1}),'bitwise_or scalar values 1085')
end
do -- scalar error bitwise_or 1086
 local a=np.array({-3.0,-9.5,-9.5,-0.0},np.float32)
 local ok=pcall(function() return np.bitwise_or(a,-2.5) end)
 assert(not ok,'bitwise_or scalar error 1086')
end
do -- scalar error bitwise_or 1087
 local a=np.array({1.0,-1.5,9.0,-3.0},np.float16)
 local ok=pcall(function() return np.bitwise_or(-2.5,a) end)
 assert(not ok,'bitwise_or scalar error 1087')
end
do -- scalar error bitwise_or 1088
 local a=np.array({-1,-31,-9,1},np.int64)
 local ok=pcall(function() return np.bitwise_or(a,-0.0) end)
 assert(not ok,'bitwise_or scalar error 1088')
end
do -- scalar bitwise_or 1089
 local a=np.array({63,127,127,7},np.uint32)
 local r=np.bitwise_or(true,a)
 assert(r.dtype=='uint32','bitwise_or scalar dtype 1089 '..r.dtype)
 assert(veq(r:tolist(),{63,127,127,7}),'bitwise_or scalar values 1089')
end
do -- scalar error bitwise_or 1090
 local a=np.array({-3.0,-3.0,0.0,-1.5},np.float32)
 local ok=pcall(function() return np.bitwise_or(false,a) end)
 assert(not ok,'bitwise_or scalar error 1090')
end
do -- scalar bitwise_or 1091
 local a=np.array({0,1,63,63},np.uint16)
 local r=np.bitwise_or(a,true)
 assert(r.dtype=='uint16','bitwise_or scalar dtype 1091 '..r.dtype)
 assert(veq(r:tolist(),{1,1,63,63}),'bitwise_or scalar values 1091')
end
do -- scalar error bitwise_or 1092
 local a=np.array({-9.5,2.0,2.0,9.0},np.float16)
 local ok=pcall(function() return np.bitwise_or(false,a) end)
 assert(not ok,'bitwise_or scalar error 1092')
end
do -- scalar bitwise_or 1093
 local a=np.array({127,127,1,3},np.uint64)
 local r=np.bitwise_or(false,a)
 assert(r.dtype=='uint64','bitwise_or scalar dtype 1093 '..r.dtype)
 assert(veq(r:tolist(),{127,127,1,3}),'bitwise_or scalar values 1093')
end
do -- scalar error bitwise_or 1094
 local a=np.array({0,15,0,31},np.uint64)
 local ok=pcall(function() return np.bitwise_or(a,-1) end)
 assert(not ok,'bitwise_or scalar error 1094')
end
do -- scalar error bitwise_or 1095
 local a=np.array({-1.0,9.0,-9.5,2.0},np.float16)
 local ok=pcall(function() return np.bitwise_or(a,2) end)
 assert(not ok,'bitwise_or scalar error 1095')
end
do -- scalar error bitwise_or 1096
 local a=np.array({0.0,-0.0,1.0,-1.5},np.float64)
 local ok=pcall(function() return np.bitwise_or(a,-2.5) end)
 assert(not ok,'bitwise_or scalar error 1096')
end
do -- scalar error bitwise_or 1097
 local a=np.array({3,3,30,1},np.int64)
 local ok=pcall(function() return np.bitwise_or(-0.0,a) end)
 assert(not ok,'bitwise_or scalar error 1097')
end
do -- scalar bitwise_or 1098
 local a=np.array({0,31,127,7},np.uint8)
 local r=np.bitwise_or(2,a)
 assert(r.dtype=='uint8','bitwise_or scalar dtype 1098 '..r.dtype)
 assert(veq(r:tolist(),{2,31,127,7}),'bitwise_or scalar values 1098')
end
do -- scalar error bitwise_or 1099
 local a=np.array({-1,7,1,30},np.int32)
 local ok=pcall(function() return np.bitwise_or(0.5,a) end)
 assert(not ok,'bitwise_or scalar error 1099')
end
do -- scalar error bitwise_or 1100
 local a=np.array({0.0,0.5,-0.0,-9.5},np.float16)
 local ok=pcall(function() return np.bitwise_or(-1,a) end)
 assert(not ok,'bitwise_or scalar error 1100')
end
do -- scalar error bitwise_xor 1101
 local a=np.array({1.0,1.0,-0.0,-1.0},np.float32)
 local ok=pcall(function() return np.bitwise_xor(a,10.0) end)
 assert(not ok,'bitwise_xor scalar error 1101')
end
do -- scalar bitwise_xor 1102
 local a=np.array({2,31,5,0},np.uint8)
 local r=np.bitwise_xor(2,a)
 assert(r.dtype=='uint8','bitwise_xor scalar dtype 1102 '..r.dtype)
 assert(veq(r:tolist(),{0,29,7,2}),'bitwise_xor scalar values 1102')
end
do -- scalar bitwise_xor 1103
 local a=np.array({0,0,0,7},np.uint16)
 local r=np.bitwise_xor(false,a)
 assert(r.dtype=='uint16','bitwise_xor scalar dtype 1103 '..r.dtype)
 assert(veq(r:tolist(),{0,0,0,7}),'bitwise_xor scalar values 1103')
end
do -- scalar error bitwise_xor 1104
 local a=np.array({15,5,63,2},np.uint64)
 local ok=pcall(function() return np.bitwise_xor(10.0,a) end)
 assert(not ok,'bitwise_xor scalar error 1104')
end
do -- scalar bitwise_xor 1105
 local a=np.array({7,5,2,3},np.uint8)
 local r=np.bitwise_xor(a,false)
 assert(r.dtype=='uint8','bitwise_xor scalar dtype 1105 '..r.dtype)
 assert(veq(r:tolist(),{7,5,2,3}),'bitwise_xor scalar values 1105')
end
do -- scalar error bitwise_xor 1106
 local a=np.array({7,15,63,3},np.uint8)
 local ok=pcall(function() return np.bitwise_xor(a,-200) end)
 assert(not ok,'bitwise_xor scalar error 1106')
end
do -- scalar error bitwise_xor 1107
 local a=np.array({2.0,-1.5,-9.5,-1.0},np.float64)
 local ok=pcall(function() return np.bitwise_xor(a,0.5) end)
 assert(not ok,'bitwise_xor scalar error 1107')
end
do -- scalar bitwise_xor 1108
 local a=np.array({31,0,5,3},np.uint64)
 local r=np.bitwise_xor(a,1)
 assert(r.dtype=='uint64','bitwise_xor scalar dtype 1108 '..r.dtype)
 assert(veq(r:tolist(),{30,1,4,2}),'bitwise_xor scalar values 1108')
end
do -- scalar bitwise_xor 1109
 local a=np.array({3,63,3,3},np.uint16)
 local r=np.bitwise_xor(a,2)
 assert(r.dtype=='uint16','bitwise_xor scalar dtype 1109 '..r.dtype)
 assert(veq(r:tolist(),{1,61,1,1}),'bitwise_xor scalar values 1109')
end
do -- scalar bitwise_xor 1110
 local a=np.array({5,127,15,1},np.uint8)
 local r=np.bitwise_xor(a,5)
 assert(r.dtype=='uint8','bitwise_xor scalar dtype 1110 '..r.dtype)
 assert(veq(r:tolist(),{0,122,10,4}),'bitwise_xor scalar values 1110')
end
do -- scalar bitwise_xor 1111
 local a=np.array({-1,30,3,-31},np.int16)
 local r=np.bitwise_xor(-200,a)
 assert(r.dtype=='int16','bitwise_xor scalar dtype 1111 '..r.dtype)
 assert(veq(r:tolist(),{199,-218,-197,217}),'bitwise_xor scalar values 1111')
end
do -- scalar error bitwise_xor 1112
 local a=np.array({1.0,-3.0,3.5,0.0},np.float64)
 local ok=pcall(function() return np.bitwise_xor(a,5) end)
 assert(not ok,'bitwise_xor scalar error 1112')
end
do -- scalar error bitwise_xor 1113
 local a=np.array({0,30,15,-3},np.int32)
 local ok=pcall(function() return np.bitwise_xor(a,2.0) end)
 assert(not ok,'bitwise_xor scalar error 1113')
end
do -- scalar error bitwise_xor 1114
 local a=np.array({2.0,-9.5,-3.0,-9.5},np.float32)
 local ok=pcall(function() return np.bitwise_xor(a,127) end)
 assert(not ok,'bitwise_xor scalar error 1114')
end
do -- scalar error bitwise_xor 1115
 local a=np.array({2,3,-9,-1},np.int16)
 local ok=pcall(function() return np.bitwise_xor(a,10.0) end)
 assert(not ok,'bitwise_xor scalar error 1115')
end
do -- scalar error bitwise_xor 1116
 local a=np.array({3,7,31,2},np.uint32)
 local ok=pcall(function() return np.bitwise_xor(a,-1) end)
 assert(not ok,'bitwise_xor scalar error 1116')
end
do -- scalar bitwise_xor 1117
 local a=np.array({1,-1,-1,-31},np.int32)
 local r=np.bitwise_xor(5,a)
 assert(r.dtype=='int32','bitwise_xor scalar dtype 1117 '..r.dtype)
 assert(veq(r:tolist(),{4,-6,-6,-28}),'bitwise_xor scalar values 1117')
end
do -- scalar error bitwise_xor 1118
 local a=np.array({0,1,0,2},np.uint8)
 local ok=pcall(function() return np.bitwise_xor(a,-2.5) end)
 assert(not ok,'bitwise_xor scalar error 1118')
end
do -- scalar error bitwise_xor 1119
 local a=np.array({0,5,15,1},np.uint16)
 local ok=pcall(function() return np.bitwise_xor(a,-3) end)
 assert(not ok,'bitwise_xor scalar error 1119')
end
do -- scalar error bitwise_xor 1120
 local a=np.array({3,30,-9,30},np.int32)
 local ok=pcall(function() return np.bitwise_xor(-0.0,a) end)
 assert(not ok,'bitwise_xor scalar error 1120')
end
do -- scalar error bitwise_xor 1121
 local a=np.array({2,15,0,3},np.int8)
 local ok=pcall(function() return np.bitwise_xor(2.0,a) end)
 assert(not ok,'bitwise_xor scalar error 1121')
end
do -- scalar error bitwise_xor 1122
 local a=np.array({31,31,127,2},np.uint64)
 local ok=pcall(function() return np.bitwise_xor(a,-0.0) end)
 assert(not ok,'bitwise_xor scalar error 1122')
end
do -- scalar bitwise_xor 1123
 local a=np.array({true,true,false,true},np.bool)
 local r=np.bitwise_xor(a,2)
 assert(r.dtype=='int64','bitwise_xor scalar dtype 1123 '..r.dtype)
 assert(veq(r:tolist(),{3,3,2,3}),'bitwise_xor scalar values 1123')
end
do -- scalar error bitwise_xor 1124
 local a=np.array({0.5,-1.5,2.0,-0.0},np.float16)
 local ok=pcall(function() return np.bitwise_xor(a,0) end)
 assert(not ok,'bitwise_xor scalar error 1124')
end
do -- scalar error bitwise_xor 1125
 local a=np.array({0.5,0.0,1.0,9.0},np.float64)
 local ok=pcall(function() return np.bitwise_xor(true,a) end)
 assert(not ok,'bitwise_xor scalar error 1125')
end
do -- scalar error bitwise_xor 1126
 local a=np.array({2.0,0.0,0.0,-1.0},np.float32)
 local ok=pcall(function() return np.bitwise_xor(2.0,a) end)
 assert(not ok,'bitwise_xor scalar error 1126')
end
do -- scalar error bitwise_xor 1127
 local a=np.array({7,-3,0,3},np.int8)
 local ok=pcall(function() return np.bitwise_xor(-200,a) end)
 assert(not ok,'bitwise_xor scalar error 1127')
end
do -- scalar error bitwise_xor 1128
 local a=np.array({0.0,3.5,0.0,9.0},np.float32)
 local ok=pcall(function() return np.bitwise_xor(a,false) end)
 assert(not ok,'bitwise_xor scalar error 1128')
end
do -- scalar bitwise_xor 1129
 local a=np.array({3,2,7,63},np.uint16)
 local r=np.bitwise_xor(a,200)
 assert(r.dtype=='uint16','bitwise_xor scalar dtype 1129 '..r.dtype)
 assert(veq(r:tolist(),{203,202,207,247}),'bitwise_xor scalar values 1129')
end
do -- scalar error bitwise_xor 1130
 local a=np.array({3,1,7,0},np.uint32)
 local ok=pcall(function() return np.bitwise_xor(a,2.0) end)
 assert(not ok,'bitwise_xor scalar error 1130')
end
do -- scalar bitwise_xor 1131
 local a=np.array({-31,3,7,-31},np.int64)
 local r=np.bitwise_xor(-1,a)
 assert(r.dtype=='int64','bitwise_xor scalar dtype 1131 '..r.dtype)
 assert(veq(r:tolist(),{30,-4,-8,30}),'bitwise_xor scalar values 1131')
end
do -- scalar error bitwise_xor 1132
 local a=np.array({-9.5,1.0,-0.0,-1.5},np.float64)
 local ok=pcall(function() return np.bitwise_xor(0,a) end)
 assert(not ok,'bitwise_xor scalar error 1132')
end
do -- scalar error bitwise_xor 1133
 local a=np.array({-1.5,-1.0,9.0,0.5},np.float64)
 local ok=pcall(function() return np.bitwise_xor(0,a) end)
 assert(not ok,'bitwise_xor scalar error 1133')
end
do -- scalar bitwise_xor 1134
 local a=np.array({15,2,-31,3},np.int32)
 local r=np.bitwise_xor(a,false)
 assert(r.dtype=='int32','bitwise_xor scalar dtype 1134 '..r.dtype)
 assert(veq(r:tolist(),{15,2,-31,3}),'bitwise_xor scalar values 1134')
end
do -- scalar error bitwise_xor 1135
 local a=np.array({9.0,2.0,-1.0,0.5},np.float16)
 local ok=pcall(function() return np.bitwise_xor(a,1) end)
 assert(not ok,'bitwise_xor scalar error 1135')
end
do -- scalar error bitwise_xor 1136
 local a=np.array({3.5,3.5,-9.5,-1.0},np.float16)
 local ok=pcall(function() return np.bitwise_xor(10.0,a) end)
 assert(not ok,'bitwise_xor scalar error 1136')
end
do -- scalar error bitwise_xor 1137
 local a=np.array({-31,-1,-31,7},np.int8)
 local ok=pcall(function() return np.bitwise_xor(a,0.5) end)
 assert(not ok,'bitwise_xor scalar error 1137')
end
do -- scalar error bitwise_xor 1138
 local a=np.array({3.5,-1.5,-1.5,-9.5},np.float32)
 local ok=pcall(function() return np.bitwise_xor(a,0.5) end)
 assert(not ok,'bitwise_xor scalar error 1138')
end
do -- scalar copysign 1139
 local a=np.array({0.0,-1.0,0.0,1.0},np.float64)
 local r=np.copysign(127,a)
 assert(r.dtype=='float64','copysign scalar dtype 1139 '..r.dtype)
 assert(veq(r:tolist(),{127.0,-127.0,127.0,127.0}),'copysign scalar values 1139')
end
do -- scalar copysign 1140
 local a=np.array({-1.5,2.0,-1.0,-1.0},np.float64)
 local r=np.copysign(a,-3)
 assert(r.dtype=='float64','copysign scalar dtype 1140 '..r.dtype)
 assert(veq(r:tolist(),{-1.5,-2.0,-1.0,-1.0}),'copysign scalar values 1140')
end
do -- scalar copysign 1141
 local a=np.array({127,5,31,7},np.uint16)
 local r=np.copysign(10.0,a)
 assert(r.dtype=='float64','copysign scalar dtype 1141 '..r.dtype)
 assert(veq(r:tolist(),{10.0,10.0,10.0,10.0}),'copysign scalar values 1141')
end
do -- scalar copysign 1142
 local a=np.array({true,true,true,false},np.bool)
 local r=np.copysign(2,a)
 assert(r.dtype=='float64','copysign scalar dtype 1142 '..r.dtype)
 assert(veq(r:tolist(),{2.0,2.0,2.0,2.0}),'copysign scalar values 1142')
end
do -- scalar copysign 1143
 local a=np.array({63,1,7,63},np.uint8)
 local r=np.copysign(a,0.5)
 assert(r.dtype=='float64','copysign scalar dtype 1143 '..r.dtype)
 assert(veq(r:tolist(),{63.0,1.0,7.0,63.0}),'copysign scalar values 1143')
end
do -- scalar copysign 1144
 local a=np.array({30,15,3,30},np.int32)
 local r=np.copysign(0,a)
 assert(r.dtype=='float64','copysign scalar dtype 1144 '..r.dtype)
 assert(veq(r:tolist(),{0.0,0.0,0.0,0.0}),'copysign scalar values 1144')
end
do -- scalar copysign 1145
 local a=np.array({2,31,2,63},np.uint8)
 local r=np.copysign(0,a)
 assert(r.dtype=='float16','copysign scalar dtype 1145 '..r.dtype)
 assert(veq(r:tolist(),{0.0,0.0,0.0,0.0}),'copysign scalar values 1145')
end
do -- scalar copysign 1146
 local a=np.array({false,false,true,true},np.bool)
 local r=np.copysign(2.0,a)
 assert(r.dtype=='float64','copysign scalar dtype 1146 '..r.dtype)
 assert(veq(r:tolist(),{2.0,2.0,2.0,2.0}),'copysign scalar values 1146')
end
do -- scalar copysign 1147
 local a=np.array({0,-3,0,15},np.int8)
 local r=np.copysign(a,2.0)
 assert(r.dtype=='float64','copysign scalar dtype 1147 '..r.dtype)
 assert(veq(r:tolist(),{0.0,3.0,0.0,15.0}),'copysign scalar values 1147')
end
do -- scalar copysign 1148
 local a=np.array({-9.5,-0.0,1.0,9.0},np.float64)
 local r=np.copysign(a,false)
 assert(r.dtype=='float64','copysign scalar dtype 1148 '..r.dtype)
 assert(veq(r:tolist(),{9.5,0.0,1.0,9.0}),'copysign scalar values 1148')
end
do -- scalar copysign 1149
 local a=np.array({7,2,1,63},np.uint8)
 local r=np.copysign(-1,a)
 assert(r.dtype=='float16','copysign scalar dtype 1149 '..r.dtype)
 assert(veq(r:tolist(),{1.0,1.0,1.0,1.0}),'copysign scalar values 1149')
end
do -- scalar copysign 1150
 local a=np.array({-0.0,0.0,9.0,1.0},np.float32)
 local r=np.copysign(a,-0.0)
 assert(r.dtype=='float32','copysign scalar dtype 1150 '..r.dtype)
 assert(veq(r:tolist(),{-0.0,-0.0,-9.0,-1.0}),'copysign scalar values 1150')
end
do -- scalar copysign 1151
 local a=np.array({30,-1,-3,-31},np.int16)
 local r=np.copysign(2.0,a)
 assert(r.dtype=='float64','copysign scalar dtype 1151 '..r.dtype)
 assert(veq(r:tolist(),{2.0,-2.0,-2.0,-2.0}),'copysign scalar values 1151')
end
do -- scalar copysign 1152
 local a=np.array({1,2,-1,-31},np.int8)
 local r=np.copysign(0,a)
 assert(r.dtype=='float16','copysign scalar dtype 1152 '..r.dtype)
 assert(veq(r:tolist(),{0.0,0.0,-0.0,-0.0}),'copysign scalar values 1152')
end
do -- scalar copysign 1153
 local a=np.array({1,1,0,127},np.uint32)
 local r=np.copysign(a,2)
 assert(r.dtype=='float64','copysign scalar dtype 1153 '..r.dtype)
 assert(veq(r:tolist(),{1.0,1.0,0.0,127.0}),'copysign scalar values 1153')
end
do -- scalar copysign 1154
 local a=np.array({3,15,63,5},np.uint64)
 local r=np.copysign(5,a)
 assert(r.dtype=='float64','copysign scalar dtype 1154 '..r.dtype)
 assert(veq(r:tolist(),{5.0,5.0,5.0,5.0}),'copysign scalar values 1154')
end
do -- scalar copysign 1155
 local a=np.array({30,-9,-3,0},np.int32)
 local r=np.copysign(-2.5,a)
 assert(r.dtype=='float64','copysign scalar dtype 1155 '..r.dtype)
 assert(veq(r:tolist(),{2.5,-2.5,-2.5,2.5}),'copysign scalar values 1155')
end
do -- scalar copysign 1156
 local a=np.array({false,false,false,true},np.bool)
 local r=np.copysign(a,10.0)
 assert(r.dtype=='float64','copysign scalar dtype 1156 '..r.dtype)
 assert(veq(r:tolist(),{0.0,0.0,0.0,1.0}),'copysign scalar values 1156')
end
do -- scalar copysign 1157
 local a=np.array({31,7,127,127},np.uint64)
 local r=np.copysign(a,-200)
 assert(r.dtype=='float64','copysign scalar dtype 1157 '..r.dtype)
 assert(veq(r:tolist(),{-31.0,-7.0,-127.0,-127.0}),'copysign scalar values 1157')
end
do -- scalar copysign 1158
 local a=np.array({9.0,9.0,2.0,0.5},np.float32)
 local r=np.copysign(a,false)
 assert(r.dtype=='float32','copysign scalar dtype 1158 '..r.dtype)
 assert(veq(r:tolist(),{9.0,9.0,2.0,0.5}),'copysign scalar values 1158')
end
do -- scalar copysign 1159
 local a=np.array({15,15,15,3},np.int32)
 local r=np.copysign(a,200)
 assert(r.dtype=='float64','copysign scalar dtype 1159 '..r.dtype)
 assert(veq(r:tolist(),{15.0,15.0,15.0,3.0}),'copysign scalar values 1159')
end
do -- scalar copysign 1160
 local a=np.array({15,3,2,127},np.uint16)
 local r=np.copysign(a,2)
 assert(r.dtype=='float32','copysign scalar dtype 1160 '..r.dtype)
 assert(veq(r:tolist(),{15.0,3.0,2.0,127.0}),'copysign scalar values 1160')
end
do -- scalar copysign 1161
 local a=np.array({7,15,-31,0},np.int64)
 local r=np.copysign(5,a)
 assert(r.dtype=='float64','copysign scalar dtype 1161 '..r.dtype)
 assert(veq(r:tolist(),{5.0,5.0,-5.0,5.0}),'copysign scalar values 1161')
end
do -- scalar copysign 1162
 local a=np.array({7,3,30,3},np.int8)
 local r=np.copysign(a,10.0)
 assert(r.dtype=='float64','copysign scalar dtype 1162 '..r.dtype)
 assert(veq(r:tolist(),{7.0,3.0,30.0,3.0}),'copysign scalar values 1162')
end
do -- scalar copysign 1163
 local a=np.array({5,7,15,63},np.uint8)
 local r=np.copysign(true,a)
 assert(r.dtype=='float16','copysign scalar dtype 1163 '..r.dtype)
 assert(veq(r:tolist(),{1.0,1.0,1.0,1.0}),'copysign scalar values 1163')
end
do -- scalar copysign 1164
 local a=np.array({0,2,7,15},np.int32)
 local r=np.copysign(a,-3)
 assert(r.dtype=='float64','copysign scalar dtype 1164 '..r.dtype)
 assert(veq(r:tolist(),{-0.0,-2.0,-7.0,-15.0}),'copysign scalar values 1164')
end
do -- scalar copysign 1165
 local a=np.array({127,1,1,1},np.uint32)
 local r=np.copysign(1,a)
 assert(r.dtype=='float64','copysign scalar dtype 1165 '..r.dtype)
 assert(veq(r:tolist(),{1.0,1.0,1.0,1.0}),'copysign scalar values 1165')
end
do -- scalar copysign 1166
 local a=np.array({7,31,3,3},np.uint32)
 local r=np.copysign(1,a)
 assert(r.dtype=='float64','copysign scalar dtype 1166 '..r.dtype)
 assert(veq(r:tolist(),{1.0,1.0,1.0,1.0}),'copysign scalar values 1166')
end
do -- scalar copysign 1167
 local a=np.array({-9,2,0,3},np.int32)
 local r=np.copysign(0.5,a)
 assert(r.dtype=='float64','copysign scalar dtype 1167 '..r.dtype)
 assert(veq(r:tolist(),{-0.5,0.5,0.5,0.5}),'copysign scalar values 1167')
end
do -- scalar copysign 1168
 local a=np.array({false,true,true,false},np.bool)
 local r=np.copysign(a,false)
 assert(r.dtype=='float16','copysign scalar dtype 1168 '..r.dtype)
 assert(veq(r:tolist(),{0.0,1.0,1.0,0.0}),'copysign scalar values 1168')
end
do -- scalar copysign 1169
 local a=np.array({1,7,15,63},np.uint8)
 local r=np.copysign(true,a)
 assert(r.dtype=='float16','copysign scalar dtype 1169 '..r.dtype)
 assert(veq(r:tolist(),{1.0,1.0,1.0,1.0}),'copysign scalar values 1169')
end
do -- scalar copysign 1170
 local a=np.array({2,-31,-1,2},np.int8)
 local r=np.copysign(a,true)
 assert(r.dtype=='float16','copysign scalar dtype 1170 '..r.dtype)
 assert(veq(r:tolist(),{2.0,31.0,1.0,2.0}),'copysign scalar values 1170')
end
do -- scalar copysign 1171
 local a=np.array({3,31,31,5},np.uint8)
 local r=np.copysign(2,a)
 assert(r.dtype=='float16','copysign scalar dtype 1171 '..r.dtype)
 assert(veq(r:tolist(),{2.0,2.0,2.0,2.0}),'copysign scalar values 1171')
end
do -- scalar copysign 1172
 local a=np.array({0,-9,2,2},np.int64)
 local r=np.copysign(a,200)
 assert(r.dtype=='float64','copysign scalar dtype 1172 '..r.dtype)
 assert(veq(r:tolist(),{0.0,9.0,2.0,2.0}),'copysign scalar values 1172')
end
do -- scalar copysign 1173
 local a=np.array({3,0,2,2},np.int32)
 local r=np.copysign(a,-0.0)
 assert(r.dtype=='float64','copysign scalar dtype 1173 '..r.dtype)
 assert(veq(r:tolist(),{-3.0,-0.0,-2.0,-2.0}),'copysign scalar values 1173')
end
do -- scalar copysign 1174
 local a=np.array({-9.5,9.0,3.5,-9.5},np.float16)
 local r=np.copysign(a,10.0)
 assert(r.dtype=='float16','copysign scalar dtype 1174 '..r.dtype)
 assert(veq(r:tolist(),{9.5,9.0,3.5,9.5}),'copysign scalar values 1174')
end
do -- scalar copysign 1175
 local a=np.array({2,7,-3,-31},np.int64)
 local r=np.copysign(a,5)
 assert(r.dtype=='float64','copysign scalar dtype 1175 '..r.dtype)
 assert(veq(r:tolist(),{2.0,7.0,3.0,31.0}),'copysign scalar values 1175')
end
do -- scalar copysign 1176
 local a=np.array({1,31,31,3},np.uint32)
 local r=np.copysign(0.5,a)
 assert(r.dtype=='float64','copysign scalar dtype 1176 '..r.dtype)
 assert(veq(r:tolist(),{0.5,0.5,0.5,0.5}),'copysign scalar values 1176')
end
do -- outwhere floor_divide 1177
 local a=np.array({{true,false,true},{false,false,true}},np.bool)
 local b=np.array({{-1,-9,3}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int16)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1177')
 assert(veq(o:tolist(),{{-1,3,0},{3,0,3}}),'floor_divide out values 1177')
end
do -- outwhere floor_divide 1178
 local a=np.array({{-9,30,-9},{7,-9,1}},np.int16)
 local b=np.array({{-1.0,2.0,0.5}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1178')
 assert(veq(o:tolist(),{{9.0,3.0,-18.0},{3.0,-5.0,3.0}}),'floor_divide out values 1178')
end
do -- outwhere floor_divide 1179
 local a=np.array({{30,7,3},{-31,-1,3}},np.int8)
 local b=np.array({{127,127,2}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1179')
 assert(veq(o:tolist(),{{0,3,1},{3,-1,3}}),'floor_divide out values 1179')
end
do -- outwhere floor_divide 1180
 local a=np.array({{15,-3,2},{7,0,-9}},np.int64)
 local b=np.array({{3,1,0}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1180')
 assert(veq(o:tolist(),{{5,3,0},{3,0,3}}),'floor_divide out values 1180')
end
do -- outwhere floor_divide 1181
 local a=np.array({{7,-1,7},{7,-1,0}},np.int64)
 local b=np.array({{30,3,15}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1181')
 assert(veq(o:tolist(),{{0,3,0},{3,-1,3}}),'floor_divide out values 1181')
end
do -- outwhere floor_divide 1182
 local a=np.array({{31,63,2},{127,15,2}},np.uint32)
 local b=np.array({{15,3,0}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1182')
 assert(veq(o:tolist(),{{2,3,0},{3,5,3}}),'floor_divide out values 1182')
end
do -- outwhere floor_divide 1183
 local a=np.array({{2,-31,2},{-31,-1,0}},np.int32)
 local b=np.array({{9.0,-1.0,-0.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1183')
 assert(veq(o:tolist(),{{0.0,3.0,-math.huge},{3.0,1.0,3.0}}),'floor_divide out values 1183')
end
do -- outwhere floor_divide 1184
 local a=np.array({{-9,2,-1},{1,2,0}},np.int16)
 local b=np.array({{9.0,9.0,-0.0}},np.float16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1184')
 assert(veq(o:tolist(),{{-1.0,3.0,math.huge},{3.0,0.0,3.0}}),'floor_divide out values 1184')
end
do -- outwhere floor_divide 1185
 local a=np.array({{5,15,5},{31,7,63}},np.uint8)
 local b=np.array({{7,3,1}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int16)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1185')
 assert(veq(o:tolist(),{{0,3,5},{3,2,3}}),'floor_divide out values 1185')
end
do -- outwhere floor_divide 1186
 local a=np.array({{-1.0,2.0,9.0},{9.0,0.5,9.0}},np.float16)
 local b=np.array({{30,7,2}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1186')
 assert(veq(o:tolist(),{{-1.0,3.0,4.0},{3.0,0.0,3.0}}),'floor_divide out values 1186')
end
do -- outwhere floor_divide 1187
 local a=np.array({{-9.5,2.0,-1.0},{0.5,0.0,3.5}},np.float64)
 local b=np.array({{15,7,30}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1187')
 assert(veq(o:tolist(),{{-1.0,3.0,-1.0},{3.0,0.0,3.0}}),'floor_divide out values 1187')
end
do -- outwhere floor_divide 1188
 local a=np.array({{true,true,false},{false,true,false}},np.bool)
 local b=np.array({{63,1,15}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint32)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1188')
 assert(veq(o:tolist(),{{0,3,0},{3,1,3}}),'floor_divide out values 1188')
end
do -- outwhere floor_divide 1189
 local a=np.array({{2.0,2.0,-1.0},{2.0,-0.0,-3.0}},np.float16)
 local b=np.array({{15,2,7}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1189')
 assert(veq(o:tolist(),{{0.0,3.0,-1.0},{3.0,-0.0,3.0}}),'floor_divide out values 1189')
end
do -- outwhere floor_divide 1190
 local a=np.array({{0.5,-0.0,-3.0},{-0.0,1.0,3.5}},np.float32)
 local b=np.array({{5,63,127}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1190')
 assert(veq(o:tolist(),{{0.0,3.0,-1.0},{3.0,0.0,3.0}}),'floor_divide out values 1190')
end
do -- outwhere floor_divide 1191
 local a=np.array({{-0.0,3.5,9.0},{3.5,3.5,-9.5}},np.float16)
 local b=np.array({{-0.0,9.0,2.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1191')
 assert(veq(o:tolist(),{{(0/0),3.0,4.0},{3.0,0.0,3.0}}),'floor_divide out values 1191')
end
do -- outwhere floor_divide 1192
 local a=np.array({{2.0,0.5,-0.0},{0.0,2.0,9.0}},np.float16)
 local b=np.array({{true,true,false}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1192')
 assert(veq(o:tolist(),{{2.0,3.0,(0/0)},{3.0,2.0,3.0}}),'floor_divide out values 1192')
end
do -- outwhere floor_divide 1193
 local a=np.array({{false,true,false},{false,true,false}},np.bool)
 local b=np.array({{3,15,31}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint64)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1193')
 assert(veq(o:tolist(),{{0,3,0},{3,0,3}}),'floor_divide out values 1193')
end
do -- outwhere floor_divide 1194
 local a=np.array({{127,63,1},{1,1,31}},np.uint64)
 local b=np.array({{-1,-31,-31}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1194')
 assert(veq(o:tolist(),{{-127.0,3.0,-1.0},{3.0,-1.0,3.0}}),'floor_divide out values 1194')
end
do -- outwhere floor_divide 1195
 local a=np.array({{3,2,-9},{-3,-1,-3}},np.int16)
 local b=np.array({{1,-1,30}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1195')
 assert(veq(o:tolist(),{{3,3,-1},{3,1,3}}),'floor_divide out values 1195')
end
do -- outwhere floor_divide 1196
 local a=np.array({{3,30,-9},{2,-1,2}},np.int16)
 local b=np.array({{0,0,-9}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1196')
 assert(veq(o:tolist(),{{0,3,1},{3,0,3}}),'floor_divide out values 1196')
end
do -- outwhere floor_divide 1197
 local a=np.array({{5,0,31},{63,127,7}},np.uint16)
 local b=np.array({{3,1,1}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint32)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1197')
 assert(veq(o:tolist(),{{1,3,31},{3,127,3}}),'floor_divide out values 1197')
end
do -- outwhere floor_divide 1198
 local a=np.array({{-1,15,-9},{15,30,1}},np.int16)
 local b=np.array({{7,-9,-9}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1198')
 assert(veq(o:tolist(),{{-1,3,1},{3,-4,3}}),'floor_divide out values 1198')
end
do -- outwhere floor_divide 1199
 local a=np.array({{1,0,30},{0,-1,15}},np.int64)
 local b=np.array({{7,1,1}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1199')
 assert(veq(o:tolist(),{{0.0,3.0,30.0},{3.0,-1.0,3.0}}),'floor_divide out values 1199')
end
do -- outwhere floor_divide 1200
 local a=np.array({{2.0,1.0,0.5},{2.0,-1.5,9.0}},np.float64)
 local b=np.array({{1,1,5}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1200')
 assert(veq(o:tolist(),{{2.0,3.0,0.0},{3.0,-2.0,3.0}}),'floor_divide out values 1200')
end
do -- outwhere floor_divide 1201
 local a=np.array({{true,false,false},{false,true,true}},np.bool)
 local b=np.array({{false,false,false}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int8)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1201')
 assert(veq(o:tolist(),{{0,3,0},{3,0,3}}),'floor_divide out values 1201')
end
do -- outwhere floor_divide 1202
 local a=np.array({{-3,3,3},{-1,0,-9}},np.int64)
 local b=np.array({{2,30,-9}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1202')
 assert(veq(o:tolist(),{{-2,3,-1},{3,0,3}}),'floor_divide out values 1202')
end
do -- outwhere floor_divide 1203
 local a=np.array({{-9,-3,-31},{0,0,3}},np.int64)
 local b=np.array({{-9.5,-9.5,-3.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1203')
 assert(veq(o:tolist(),{{0.0,3.0,10.0},{3.0,-0.0,3.0}}),'floor_divide out values 1203')
end
do -- outwhere floor_divide 1204
 local a=np.array({{15,2,0},{63,7,1}},np.uint16)
 local b=np.array({{false,true,false}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint16)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1204')
 assert(veq(o:tolist(),{{0,3,0},{3,7,3}}),'floor_divide out values 1204')
end
do -- outwhere floor_divide 1205
 local a=np.array({{0.5,0.5,-9.5},{-9.5,0.5,-1.0}},np.float64)
 local b=np.array({{5,2,15}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1205')
 assert(veq(o:tolist(),{{0.0,3.0,-1.0},{3.0,0.0,3.0}}),'floor_divide out values 1205')
end
do -- outwhere floor_divide 1206
 local a=np.array({{7,31,7},{15,127,127}},np.uint16)
 local b=np.array({{31,127,15}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint64)*3
 local r=np.floor_divide(a,b,{out=o,where=m})
 assert(r==o,'floor_divide out identity 1206')
 assert(veq(o:tolist(),{{0,3,0},{3,1,3}}),'floor_divide out values 1206')
end
do -- outwhere remainder 1207
 local a=np.array({{-3,-1,-31},{7,-31,-31}},np.int32)
 local b=np.array({{1,0,0}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int32)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1207')
 assert(veq(o:tolist(),{{0,3,0},{3,0,3}}),'remainder out values 1207')
end
do -- outwhere remainder 1208
 local a=np.array({{false,false,false},{true,true,false}},np.bool)
 local b=np.array({{15,63,1}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint8)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1208')
 assert(veq(o:tolist(),{{0,3,0},{3,1,3}}),'remainder out values 1208')
end
do -- outwhere remainder 1209
 local a=np.array({{-31,-3,2},{-3,30,2}},np.int8)
 local b=np.array({{true,false,true}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int8)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1209')
 assert(veq(o:tolist(),{{0,3,0},{3,0,3}}),'remainder out values 1209')
end
do -- outwhere remainder 1210
 local a=np.array({{-1,7,15},{15,30,-9}},np.int8)
 local b=np.array({{2,15,30}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int8)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1210')
 assert(veq(o:tolist(),{{1,3,15},{3,0,3}}),'remainder out values 1210')
end
do -- outwhere remainder 1211
 local a=np.array({{2,15,63},{31,1,3}},np.uint64)
 local b=np.array({{0,31,127}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint64)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1211')
 assert(veq(o:tolist(),{{0,3,63},{3,1,3}}),'remainder out values 1211')
end
do -- outwhere remainder 1212
 local a=np.array({{3,63,127},{3,0,63}},np.uint8)
 local b=np.array({{15,-9,0}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int16)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1212')
 assert(veq(o:tolist(),{{3,3,0},{3,0,3}}),'remainder out values 1212')
end
do -- outwhere remainder 1213
 local a=np.array({{1,3,3},{31,3,2}},np.uint8)
 local b=np.array({{31,0,2}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint8)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1213')
 assert(veq(o:tolist(),{{1,3,1},{3,0,3}}),'remainder out values 1213')
end
do -- outwhere remainder 1214
 local a=np.array({{0.5,-3.0,9.0},{2.0,0.0,0.0}},np.float64)
 local b=np.array({{true,false,false}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1214')
 assert(veq(o:tolist(),{{0.5,3.0,(0/0)},{3.0,(0/0),3.0}}),'remainder out values 1214')
end
do -- outwhere remainder 1215
 local a=np.array({{5,15,0},{3,63,7}},np.uint64)
 local b=np.array({{true,false,false}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint64)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1215')
 assert(veq(o:tolist(),{{0,3,0},{3,0,3}}),'remainder out values 1215')
end
do -- outwhere remainder 1216
 local a=np.array({{false,true,true},{true,true,false}},np.bool)
 local b=np.array({{1,15,1}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint32)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1216')
 assert(veq(o:tolist(),{{0,3,0},{3,1,3}}),'remainder out values 1216')
end
do -- outwhere remainder 1217
 local a=np.array({{3.5,-3.0,-0.0},{0.5,-3.0,-0.0}},np.float32)
 local b=np.array({{1,15,-1}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1217')
 assert(veq(o:tolist(),{{0.5,3.0,-0.0},{3.0,12.0,3.0}}),'remainder out values 1217')
end
do -- outwhere remainder 1218
 local a=np.array({{-0.0,-1.5,1.0},{1.0,3.5,3.5}},np.float16)
 local b=np.array({{30,2,7}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1218')
 assert(veq(o:tolist(),{{0.0,3.0,1.0},{3.0,1.5,3.0}}),'remainder out values 1218')
end
do -- outwhere remainder 1219
 local a=np.array({{0,0,2},{3,15,30}},np.int8)
 local b=np.array({{7,7,5}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1219')
 assert(veq(o:tolist(),{{0,3,2},{3,1,3}}),'remainder out values 1219')
end
do -- outwhere remainder 1220
 local a=np.array({{63,0,15},{3,63,3}},np.uint8)
 local b=np.array({{30,7,7}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int16)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1220')
 assert(veq(o:tolist(),{{3,3,1},{3,0,3}}),'remainder out values 1220')
end
do -- outwhere remainder 1221
 local a=np.array({{false,false,true},{false,false,false}},np.bool)
 local b=np.array({{15,30,-9}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int32)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1221')
 assert(veq(o:tolist(),{{0,3,-8},{3,0,3}}),'remainder out values 1221')
end
do -- outwhere remainder 1222
 local a=np.array({{3,2,63},{31,0,127}},np.uint16)
 local b=np.array({{3,3,2}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint16)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1222')
 assert(veq(o:tolist(),{{0,3,1},{3,0,3}}),'remainder out values 1222')
end
do -- outwhere remainder 1223
 local a=np.array({{5,2,63},{2,31,15}},np.uint32)
 local b=np.array({{-9,2,-9}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1223')
 assert(veq(o:tolist(),{{-4,3,0},{3,1,3}}),'remainder out values 1223')
end
do -- outwhere remainder 1224
 local a=np.array({{3,3,-1},{15,-9,-9}},np.int64)
 local b=np.array({{-1,-3,15}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1224')
 assert(veq(o:tolist(),{{0,3,14},{3,0,3}}),'remainder out values 1224')
end
do -- outwhere remainder 1225
 local a=np.array({{15,31,63},{127,7,1}},np.uint64)
 local b=np.array({{false,true,true}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint64)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1225')
 assert(veq(o:tolist(),{{0,3,0},{3,0,3}}),'remainder out values 1225')
end
do -- outwhere remainder 1226
 local a=np.array({{false,true,false},{false,false,true}},np.bool)
 local b=np.array({{127,63,7}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint64)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1226')
 assert(veq(o:tolist(),{{0,3,0},{3,0,3}}),'remainder out values 1226')
end
do -- outwhere remainder 1227
 local a=np.array({{9.0,-0.0,0.5},{0.5,0.0,3.5}},np.float16)
 local b=np.array({{15,7,7}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1227')
 assert(veq(o:tolist(),{{9.0,3.0,0.5},{3.0,0.0,3.0}}),'remainder out values 1227')
end
do -- outwhere remainder 1228
 local a=np.array({{7,15,31},{5,7,0}},np.uint16)
 local b=np.array({{-0.0,0.5,-1.5}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1228')
 assert(veq(o:tolist(),{{(0/0),3.0,-0.5},{3.0,0.0,3.0}}),'remainder out values 1228')
end
do -- outwhere remainder 1229
 local a=np.array({{2,2,0},{2,5,63}},np.uint64)
 local b=np.array({{-9.5,-1.0,0.0}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1229')
 assert(veq(o:tolist(),{{-7.5,3.0,(0/0)},{3.0,-0.0,3.0}}),'remainder out values 1229')
end
do -- outwhere remainder 1230
 local a=np.array({{-31,3,-3},{7,-31,-9}},np.int8)
 local b=np.array({{1,3,7}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1230')
 assert(veq(o:tolist(),{{0,3,4},{3,2,3}}),'remainder out values 1230')
end
do -- outwhere remainder 1231
 local a=np.array({{2.0,1.0,2.0},{1.0,-9.5,3.5}},np.float64)
 local b=np.array({{0.5,2.0,-9.5}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1231')
 assert(veq(o:tolist(),{{0.0,3.0,-7.5},{3.0,0.5,3.0}}),'remainder out values 1231')
end
do -- outwhere remainder 1232
 local a=np.array({{0,2,63},{31,63,127}},np.uint32)
 local b=np.array({{3,2,3}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1232')
 assert(veq(o:tolist(),{{0,3,0},{3,1,3}}),'remainder out values 1232')
end
do -- outwhere remainder 1233
 local a=np.array({{15,30,-31},{-31,7,-3}},np.int8)
 local b=np.array({{3,3,-1}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int16)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1233')
 assert(veq(o:tolist(),{{0,3,0},{3,1,3}}),'remainder out values 1233')
end
do -- outwhere remainder 1234
 local a=np.array({{2,2,0},{2,0,3}},np.uint32)
 local b=np.array({{2.0,1.0,-1.5}},np.float16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1234')
 assert(veq(o:tolist(),{{0.0,3.0,-0.0},{3.0,0.0,3.0}}),'remainder out values 1234')
end
do -- outwhere remainder 1235
 local a=np.array({{9.0,3.5,9.0},{-3.0,-1.0,0.0}},np.float32)
 local b=np.array({{5,7,5}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1235')
 assert(veq(o:tolist(),{{4.0,3.0,4.0},{3.0,6.0,3.0}}),'remainder out values 1235')
end
do -- outwhere remainder 1236
 local a=np.array({{2,7,0},{15,7,3}},np.uint16)
 local b=np.array({{true,false,true}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint16)*3
 local r=np.remainder(a,b,{out=o,where=m})
 assert(r==o,'remainder out identity 1236')
 assert(veq(o:tolist(),{{0,3,0},{3,0,3}}),'remainder out values 1236')
end
do -- outwhere power 1237
 local a=np.array({{7,5,1},{127,3,0}},np.uint64)
 local b=np.array({{31,63,7}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint64)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1237')
 assert(veq(o:tolist(),{{11037526537452362423,3,1},{3,15208858086377056683,3}}),'power out values 1237')
end
do -- outwhere power 1238
 local a=np.array({{1.0,2.0,1.0},{0.5,0.5,-0.0}},np.float16)
 local b=np.array({{9.0,0.5,2.0}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1238')
 assert(veq(o:tolist(),{{1.0,3.0,1.0},{3.0,0.7071067811865476,3.0}}),'power out values 1238')
end
do -- outwhere power 1239
 local a=np.array({{-1,7,2},{2,-9,30}},np.int32)
 local b=np.array({{1,0,2}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int32)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1239')
 assert(veq(o:tolist(),{{-1,3,4},{3,1,3}}),'power out values 1239')
end
do -- outwhere power 1240
 local a=np.array({{7,7,-9},{-9,3,15}},np.int8)
 local b=np.array({{5,3,5}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int16)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1240')
 assert(veq(o:tolist(),{{16807,3,6487},{3,27,3}}),'power out values 1240')
end
do -- outwhere power 1241
 local a=np.array({{7,-9,-1},{-1,30,0}},np.int8)
 local b=np.array({{3,3,1}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int32)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1241')
 assert(veq(o:tolist(),{{343,3,-1},{3,27000,3}}),'power out values 1241')
end
do -- outwhere power 1242
 local a=np.array({{true,false,false},{true,true,false}},np.bool)
 local b=np.array({{2,4,3}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int32)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1242')
 assert(veq(o:tolist(),{{1,3,0},{3,1,3}}),'power out values 1242')
end
do -- outwhere power 1243
 local a=np.array({{0.0,-1.5,-3.0},{-1.5,2.0,-9.5}},np.float32)
 local b=np.array({{5,5,5}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1243')
 assert(veq(o:tolist(),{{0.0,3.0,-243.0},{3.0,32.0,3.0}}),'power out values 1243')
end
do -- outwhere power 1244
 local a=np.array({{true,false,true},{true,false,false}},np.bool)
 local b=np.array({{127,63,7}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint32)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1244')
 assert(veq(o:tolist(),{{1,3,1},{3,0,3}}),'power out values 1244')
end
do -- outwhere power 1245
 local a=np.array({{31,7,2},{0,2,31}},np.uint8)
 local b=np.array({{2,2,4}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int32)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1245')
 assert(veq(o:tolist(),{{961,3,16},{3,4,3}}),'power out values 1245')
end
do -- outwhere power 1246
 local a=np.array({{-9,1,30},{-31,1,-1}},np.int32)
 local b=np.array({{3,2,1}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1246')
 assert(veq(o:tolist(),{{-729,3,30},{3,1,3}}),'power out values 1246')
end
do -- outwhere power 1247
 local a=np.array({{5,127,63},{0,5,15}},np.uint32)
 local b=np.array({{false,true,true}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint32)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1247')
 assert(veq(o:tolist(),{{1,3,63},{3,5,3}}),'power out values 1247')
end
do -- outwhere power 1248
 local a=np.array({{127,3,3},{127,63,127}},np.uint32)
 local b=np.array({{-9.5,-1.0,-9.5}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1248')
 assert(veq(o:tolist(),{{1.0324395929502061e-20,3.0,2.9332432514841524e-05},{3.0,0.015873015873015872,3.0}}),'power out values 1248')
end
do -- outwhere power 1249
 local a=np.array({{1.0,1.0,9.0},{-9.5,1.0,-3.0}},np.float16)
 local b=np.array({{-3.0,-0.0,9.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1249')
 assert(veq(o:tolist(),{{1.0,3.0,387420480.0},{3.0,1.0,3.0}}),'power out values 1249')
end
do -- outwhere power 1250
 local a=np.array({{false,true,false},{true,false,false}},np.bool)
 local b=np.array({{5,2,5}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint32)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1250')
 assert(veq(o:tolist(),{{0,3,0},{3,0,3}}),'power out values 1250')
end
do -- outwhere power 1251
 local a=np.array({{2.0,-1.5,9.0},{-9.5,0.5,-3.0}},np.float32)
 local b=np.array({{7,7,31}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1251')
 assert(veq(o:tolist(),{{128.0,3.0,3.815204037192891e+29},{3.0,0.0078125,3.0}}),'power out values 1251')
end
do -- outwhere power 1252
 local a=np.array({{1,3,0},{63,15,63}},np.uint64)
 local b=np.array({{31,1,15}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint64)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1252')
 assert(veq(o:tolist(),{{1,3,0},{3,15,3}}),'power out values 1252')
end
do -- outwhere power 1253
 local a=np.array({{0.5,9.0,-3.0},{-1.5,1.0,-1.0}},np.float64)
 local b=np.array({{15,127,0}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1253')
 assert(veq(o:tolist(),{{3.0517578125e-05,3.0,1.0},{3.0,1.0,3.0}}),'power out values 1253')
end
do -- outwhere power 1254
 local a=np.array({{7,2,-31},{7,3,30}},np.int8)
 local b=np.array({{3,3,31}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int32)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1254')
 assert(veq(o:tolist(),{{343,3,2010103841},{3,27,3}}),'power out values 1254')
end
do -- outwhere power 1255
 local a=np.array({{1,-1,30},{1,-3,7}},np.int32)
 local b=np.array({{1,4,5}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int32)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1255')
 assert(veq(o:tolist(),{{1,3,24300000},{3,81,3}}),'power out values 1255')
end
do -- outwhere power 1256
 local a=np.array({{3,31,31},{3,1,15}},np.uint16)
 local b=np.array({{true,true,false}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint16)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1256')
 assert(veq(o:tolist(),{{3,3,1},{3,1,3}}),'power out values 1256')
end
do -- outwhere power 1257
 local a=np.array({{-1,2,0},{30,0,-1}},np.int32)
 local b=np.array({{0.0,-3.0,-9.5}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1257')
 assert(veq(o:tolist(),{{1.0,3.0,math.huge},{3.0,math.huge,3.0}}),'power out values 1257')
end
do -- outwhere power 1258
 local a=np.array({{0,1,-3},{-1,2,-31}},np.int64)
 local b=np.array({{1.0,9.0,9.0}},np.float16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1258')
 assert(veq(o:tolist(),{{0.0,3.0,-19683.0},{3.0,512.0,3.0}}),'power out values 1258')
end
do -- outwhere power 1259
 local a=np.array({{-1.5,3.5,0.0},{-1.5,0.0,-9.5}},np.float64)
 local b=np.array({{3,15,7}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1259')
 assert(veq(o:tolist(),{{-3.375,3.0,0.0},{3.0,0.0,3.0}}),'power out values 1259')
end
do -- outwhere power 1260
 local a=np.array({{3,1,3},{7,-3,0}},np.int16)
 local b=np.array({{0.0,-0.0,-3.0}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1260')
 assert(veq(o:tolist(),{{1.0,3.0,0.037037037037037035},{3.0,1.0,3.0}}),'power out values 1260')
end
do -- outwhere power 1261
 local a=np.array({{-1.5,-1.5,0.5},{2.0,0.0,-1.5}},np.float32)
 local b=np.array({{0,2,7}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1261')
 assert(veq(o:tolist(),{{1.0,3.0,0.0078125},{3.0,0.0,3.0}}),'power out values 1261')
end
do -- outwhere power 1262
 local a=np.array({{15,1,15},{15,-3,-31}},np.int32)
 local b=np.array({{-0.0,-9.5,2.0}},np.float16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1262')
 assert(veq(o:tolist(),{{1.0,3.0,225.0},{3.0,(0/0),3.0}}),'power out values 1262')
end
do -- outwhere power 1263
 local a=np.array({{31,5,7},{63,3,5}},np.uint32)
 local b=np.array({{false,true,false}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint32)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1263')
 assert(veq(o:tolist(),{{1,3,1},{3,3,3}}),'power out values 1263')
end
do -- outwhere power 1264
 local a=np.array({{3,30,15},{2,2,-1}},np.int16)
 local b=np.array({{-3.0,0.0,-9.5}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1264')
 assert(veq(o:tolist(),{{0.03703703358769417,3.0,6.716345795493295e-12},{3.0,1.0,3.0}}),'power out values 1264')
end
do -- outwhere power 1265
 local a=np.array({{7,-31,3},{-31,0,-1}},np.int16)
 local b=np.array({{15,127,15}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1265')
 assert(veq(o:tolist(),{{4747561509943,3,14348907},{3,0,3}}),'power out values 1265')
end
do -- outwhere power 1266
 local a=np.array({{-9.5,0.5,-1.0},{-3.0,-0.0,1.0}},np.float64)
 local b=np.array({{15,0,15}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.power(a,b,{out=o,where=m})
 assert(r==o,'power out identity 1266')
 assert(veq(o:tolist(),{{-463291230159753.4,3.0,-1.0},{3.0,1.0,3.0}}),'power out values 1266')
end
do -- outwhere bitwise_xor 1267
 local a=np.array({{false,false,true},{true,true,false}},np.bool)
 local b=np.array({{true,false,false}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.bool)
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1267')
 assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'bitwise_xor out values 1267')
end
do -- outwhere bitwise_xor 1268
 local a=np.array({{2,3,0},{1,31,127}},np.uint32)
 local b=np.array({{15,1,0}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint32)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1268')
 assert(veq(o:tolist(),{{13,3,0},{3,30,3}}),'bitwise_xor out values 1268')
end
do -- outwhere bitwise_xor 1269
 local a=np.array({{true,false,false},{false,false,true}},np.bool)
 local b=np.array({{-1,-9,-9}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int16)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1269')
 assert(veq(o:tolist(),{{-2,3,-9},{3,-9,3}}),'bitwise_xor out values 1269')
end
do -- outwhere bitwise_xor 1270
 local a=np.array({{0,0,15},{15,31,0}},np.uint32)
 local b=np.array({{0,7,-9}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1270')
 assert(veq(o:tolist(),{{0,3,-8},{3,24,3}}),'bitwise_xor out values 1270')
end
do -- outwhere bitwise_xor 1271
 local a=np.array({{63,3,15},{5,1,7}},np.uint32)
 local b=np.array({{15,-3,7}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1271')
 assert(veq(o:tolist(),{{48,3,8},{3,-4,3}}),'bitwise_xor out values 1271')
end
do -- outwhere bitwise_xor 1272
 local a=np.array({{63,2,127},{3,31,31}},np.uint16)
 local b=np.array({{-1,1,2}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int32)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1272')
 assert(veq(o:tolist(),{{-64,3,125},{3,30,3}}),'bitwise_xor out values 1272')
end
do -- outwhere bitwise_xor 1273
 local a=np.array({{15,30,-1},{0,2,1}},np.int8)
 local b=np.array({{31,7,0}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1273')
 assert(veq(o:tolist(),{{16,3,-1},{3,5,3}}),'bitwise_xor out values 1273')
end
do -- outwhere bitwise_xor 1274
 local a=np.array({{true,false,true},{true,false,true}},np.bool)
 local b=np.array({{0,1,-31}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int8)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1274')
 assert(veq(o:tolist(),{{1,3,-32},{3,1,3}}),'bitwise_xor out values 1274')
end
do -- outwhere bitwise_xor 1275
 local a=np.array({{-31,7,-31},{30,3,1}},np.int8)
 local b=np.array({{30,0,3}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1275')
 assert(veq(o:tolist(),{{-1,3,-30},{3,3,3}}),'bitwise_xor out values 1275')
end
do -- outwhere bitwise_xor 1276
 local a=np.array({{5,0,5},{63,2,7}},np.uint8)
 local b=np.array({{31,0,31}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint16)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1276')
 assert(veq(o:tolist(),{{26,3,26},{3,2,3}}),'bitwise_xor out values 1276')
end
do -- outwhere bitwise_xor 1277
 local a=np.array({{2,3,1},{-1,-1,7}},np.int16)
 local b=np.array({{63,15,1}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int32)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1277')
 assert(veq(o:tolist(),{{61,3,0},{3,-16,3}}),'bitwise_xor out values 1277')
end
do -- outwhere bitwise_xor 1278
 local a=np.array({{2,5,3},{3,2,2}},np.uint16)
 local b=np.array({{127,1,5}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint32)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1278')
 assert(veq(o:tolist(),{{125,3,6},{3,3,3}}),'bitwise_xor out values 1278')
end
do -- outwhere bitwise_xor 1279
 local a=np.array({{1,7,15},{1,7,31}},np.uint8)
 local b=np.array({{5,31,15}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint16)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1279')
 assert(veq(o:tolist(),{{4,3,0},{3,24,3}}),'bitwise_xor out values 1279')
end
do -- outwhere bitwise_xor 1280
 local a=np.array({{true,false,true},{true,false,false}},np.bool)
 local b=np.array({{127,127,15}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint16)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1280')
 assert(veq(o:tolist(),{{126,3,14},{3,127,3}}),'bitwise_xor out values 1280')
end
do -- outwhere bitwise_xor 1281
 local a=np.array({{1,30,0},{15,-9,0}},np.int16)
 local b=np.array({{5,7,3}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1281')
 assert(veq(o:tolist(),{{4,3,3},{3,-16,3}}),'bitwise_xor out values 1281')
end
do -- outwhere bitwise_xor 1282
 local a=np.array({{3,-1,1},{1,-31,2}},np.int32)
 local b=np.array({{-3,30,1}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int32)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1282')
 assert(veq(o:tolist(),{{-2,3,0},{3,-1,3}}),'bitwise_xor out values 1282')
end
do -- outwhere bitwise_xor 1283
 local a=np.array({{-9,-9,1},{15,0,-1}},np.int32)
 local b=np.array({{1,1,7}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1283')
 assert(veq(o:tolist(),{{-10,3,6},{3,1,3}}),'bitwise_xor out values 1283')
end
do -- outwhere bitwise_xor 1284
 local a=np.array({{-1,-3,0},{-9,15,7}},np.int8)
 local b=np.array({{3,-1,3}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int16)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1284')
 assert(veq(o:tolist(),{{-4,3,3},{3,-16,3}}),'bitwise_xor out values 1284')
end
do -- outwhere bitwise_xor 1285
 local a=np.array({{7,0,15},{63,31,1}},np.uint32)
 local b=np.array({{1,127,31}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint32)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1285')
 assert(veq(o:tolist(),{{6,3,16},{3,96,3}}),'bitwise_xor out values 1285')
end
do -- outwhere bitwise_xor 1286
 local a=np.array({{1,15,-31},{1,2,-9}},np.int8)
 local b=np.array({{7,3,-3}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int16)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1286')
 assert(veq(o:tolist(),{{6,3,28},{3,1,3}}),'bitwise_xor out values 1286')
end
do -- outwhere bitwise_xor 1287
 local a=np.array({{0,3,7},{7,15,0}},np.int8)
 local b=np.array({{-31,0,-3}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int8)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1287')
 assert(veq(o:tolist(),{{-31,3,-6},{3,15,3}}),'bitwise_xor out values 1287')
end
do -- outwhere bitwise_xor 1288
 local a=np.array({{2,2,-3},{7,7,2}},np.int32)
 local b=np.array({{true,false,false}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int32)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1288')
 assert(veq(o:tolist(),{{3,3,-3},{3,7,3}}),'bitwise_xor out values 1288')
end
do -- outwhere bitwise_xor 1289
 local a=np.array({{5,1,3},{127,5,1}},np.uint8)
 local b=np.array({{false,true,true}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint8)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1289')
 assert(veq(o:tolist(),{{5,3,2},{3,4,3}}),'bitwise_xor out values 1289')
end
do -- outwhere bitwise_xor 1290
 local a=np.array({{2,0,1},{-3,15,7}},np.int8)
 local b=np.array({{false,true,true}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int8)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1290')
 assert(veq(o:tolist(),{{2,3,0},{3,14,3}}),'bitwise_xor out values 1290')
end
do -- outwhere bitwise_xor 1291
 local a=np.array({{63,5,3},{7,5,15}},np.uint8)
 local b=np.array({{false,false,true}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint8)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1291')
 assert(veq(o:tolist(),{{63,3,2},{3,5,3}}),'bitwise_xor out values 1291')
end
do -- outwhere bitwise_xor 1292
 local a=np.array({{0,15,-31},{3,15,-9}},np.int64)
 local b=np.array({{3,15,-9}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1292')
 assert(veq(o:tolist(),{{3,3,22},{3,0,3}}),'bitwise_xor out values 1292')
end
do -- outwhere bitwise_xor 1293
 local a=np.array({{3,15,2},{7,31,2}},np.uint64)
 local b=np.array({{0,2,1}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint64)*3
 local r=np.bitwise_xor(a,b,{out=o,where=m})
 assert(r==o,'bitwise_xor out identity 1293')
 assert(veq(o:tolist(),{{3,3,3},{3,29,3}}),'bitwise_xor out values 1293')
end
do -- outwhere fmax 1294
 local a=np.array({{3,30,1},{7,7,0}},np.int8)
 local b=np.array({{31,2,3}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1294')
 assert(veq(o:tolist(),{{31,3,3},{3,7,3}}),'fmax out values 1294')
end
do -- outwhere fmax 1295
 local a=np.array({{0,0,-9},{-1,15,3}},np.int8)
 local b=np.array({{2,127,31}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int16)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1295')
 assert(veq(o:tolist(),{{2,3,31},{3,127,3}}),'fmax out values 1295')
end
do -- outwhere fmax 1296
 local a=np.array({{63,127,15},{15,5,5}},np.uint16)
 local b=np.array({{false,true,true}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint16)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1296')
 assert(veq(o:tolist(),{{63,3,15},{3,5,3}}),'fmax out values 1296')
end
do -- outwhere fmax 1297
 local a=np.array({{(0/0),1.0,-3.0},{3.5,-1.5,2.0}},np.float16)
 local b=np.array({{math.huge,0.5,math.huge}},np.float16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1297')
 assert(veq(o:tolist(),{{math.huge,3.0,math.huge},{3.0,0.5,3.0}}),'fmax out values 1297')
end
do -- outwhere fmax 1298
 local a=np.array({{9.0,2.0,2.0},{1.0,math.huge,2.0}},np.float32)
 local b=np.array({{2,63,7}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1298')
 assert(veq(o:tolist(),{{9.0,3.0,7.0},{3.0,math.huge,3.0}}),'fmax out values 1298')
end
do -- outwhere fmax 1299
 local a=np.array({{-9,-31,-31},{15,-1,-31}},np.int32)
 local b=np.array({{-3,7,-9}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int32)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1299')
 assert(veq(o:tolist(),{{-3,3,-9},{3,7,3}}),'fmax out values 1299')
end
do -- outwhere fmax 1300
 local a=np.array({{0.0,0.0,math.huge},{9.0,0.0,9.0}},np.float64)
 local b=np.array({{127,63,0}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1300')
 assert(veq(o:tolist(),{{127.0,3.0,math.huge},{3.0,63.0,3.0}}),'fmax out values 1300')
end
do -- outwhere fmax 1301
 local a=np.array({{15,1,3},{63,5,127}},np.uint16)
 local b=np.array({{-31,7,3}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int32)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1301')
 assert(veq(o:tolist(),{{15,3,3},{3,7,3}}),'fmax out values 1301')
end
do -- outwhere fmax 1302
 local a=np.array({{0,1,15},{-3,-9,-1}},np.int8)
 local b=np.array({{2,7,63}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1302')
 assert(veq(o:tolist(),{{2,3,63},{3,7,3}}),'fmax out values 1302')
end
do -- outwhere fmax 1303
 local a=np.array({{0,7,15},{15,2,3}},np.uint64)
 local b=np.array({{7,-3,2}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1303')
 assert(veq(o:tolist(),{{7.0,3.0,15.0},{3.0,2.0,3.0}}),'fmax out values 1303')
end
do -- outwhere fmax 1304
 local a=np.array({{30,15,3},{30,3,0}},np.int8)
 local b=np.array({{0,30,-31}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int8)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1304')
 assert(veq(o:tolist(),{{30,3,3},{3,30,3}}),'fmax out values 1304')
end
do -- outwhere fmax 1305
 local a=np.array({{3,2,7},{5,7,7}},np.uint8)
 local b=np.array({{-1.5,1.0,-1.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1305')
 assert(veq(o:tolist(),{{3.0,3.0,7.0},{3.0,7.0,3.0}}),'fmax out values 1305')
end
do -- outwhere fmax 1306
 local a=np.array({{false,true,true},{true,true,false}},np.bool)
 local b=np.array({{0,15,5}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint16)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1306')
 assert(veq(o:tolist(),{{0,3,5},{3,15,3}}),'fmax out values 1306')
end
do -- outwhere fmax 1307
 local a=np.array({{0.5,-9.5,0.0},{-3.0,9.0,1.0}},np.float16)
 local b=np.array({{15,-31,30}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1307')
 assert(veq(o:tolist(),{{15.0,3.0,30.0},{3.0,9.0,3.0}}),'fmax out values 1307')
end
do -- outwhere fmax 1308
 local a=np.array({{0.5,-9.5,math.huge},{3.5,1.0,-1.5}},np.float64)
 local b=np.array({{30,15,-1}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1308')
 assert(veq(o:tolist(),{{30.0,3.0,math.huge},{3.0,15.0,3.0}}),'fmax out values 1308')
end
do -- outwhere fmax 1309
 local a=np.array({{127,31,1},{63,63,15}},np.uint64)
 local b=np.array({{-1,1,2}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1309')
 assert(veq(o:tolist(),{{127.0,3.0,2.0},{3.0,63.0,3.0}}),'fmax out values 1309')
end
do -- outwhere fmax 1310
 local a=np.array({{-3.0,-1.0,1.0},{1.0,0.5,1.0}},np.float16)
 local b=np.array({{0,3,31}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1310')
 assert(veq(o:tolist(),{{0.0,3.0,31.0},{3.0,3.0,3.0}}),'fmax out values 1310')
end
do -- outwhere fmax 1311
 local a=np.array({{5,0,1},{63,63,127}},np.uint64)
 local b=np.array({{(0/0),math.huge,1.0}},np.float16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1311')
 assert(veq(o:tolist(),{{5.0,3.0,1.0},{3.0,math.huge,3.0}}),'fmax out values 1311')
end
do -- outwhere fmax 1312
 local a=np.array({{-31,2,-1},{30,7,1}},np.int8)
 local b=np.array({{7,63,3}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1312')
 assert(veq(o:tolist(),{{7,3,3},{3,63,3}}),'fmax out values 1312')
end
do -- outwhere fmax 1313
 local a=np.array({{-3,15,-9},{3,-3,15}},np.int16)
 local b=np.array({{7,-9,15}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int16)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1313')
 assert(veq(o:tolist(),{{7,3,15},{3,-3,3}}),'fmax out values 1313')
end
do -- outwhere fmax 1314
 local a=np.array({{true,true,false},{true,true,false}},np.bool)
 local b=np.array({{math.huge,(0/0),9.0}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1314')
 assert(veq(o:tolist(),{{math.huge,3.0,9.0},{3.0,1.0,3.0}}),'fmax out values 1314')
end
do -- outwhere fmax 1315
 local a=np.array({{0,15,7},{0,7,2}},np.uint64)
 local b=np.array({{-0.0,2.0,(0/0)}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1315')
 assert(veq(o:tolist(),{{0.0,3.0,7.0},{3.0,7.0,3.0}}),'fmax out values 1315')
end
do -- outwhere fmax 1316
 local a=np.array({{true,true,false},{true,true,false}},np.bool)
 local b=np.array({{63,63,63}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.uint16)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1316')
 assert(veq(o:tolist(),{{63,3,63},{3,63,3}}),'fmax out values 1316')
end
do -- outwhere fmax 1317
 local a=np.array({{15,7,7},{7,7,0}},np.int16)
 local b=np.array({{-31,-9,-1}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int32)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1317')
 assert(veq(o:tolist(),{{15,3,7},{3,7,3}}),'fmax out values 1317')
end
do -- outwhere fmax 1318
 local a=np.array({{1,127,15},{2,5,5}},np.uint64)
 local b=np.array({{-31,30,7}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1318')
 assert(veq(o:tolist(),{{1.0,3.0,15.0},{3.0,30.0,3.0}}),'fmax out values 1318')
end
do -- outwhere fmax 1319
 local a=np.array({{63,31,3},{5,63,1}},np.uint8)
 local b=np.array({{15,30,-3}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int64)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1319')
 assert(veq(o:tolist(),{{63,3,3},{3,63,3}}),'fmax out values 1319')
end
do -- outwhere fmax 1320
 local a=np.array({{-31,-31,3},{0,-9,-31}},np.int16)
 local b=np.array({{127,2,15}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int16)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1320')
 assert(veq(o:tolist(),{{127,3,15},{3,2,3}}),'fmax out values 1320')
end
do -- outwhere fmax 1321
 local a=np.array({{0.5,9.0,(0/0)},{math.huge,math.huge,-3.0}},np.float32)
 local b=np.array({{1,5,5}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1321')
 assert(veq(o:tolist(),{{1.0,3.0,5.0},{3.0,math.huge,3.0}}),'fmax out values 1321')
end
do -- outwhere fmax 1322
 local a=np.array({{false,false,false},{false,true,true}},np.bool)
 local b=np.array({{2,30,7}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.int8)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1322')
 assert(veq(o:tolist(),{{2,3,7},{3,30,3}}),'fmax out values 1322')
end
do -- outwhere fmax 1323
 local a=np.array({{7,5,15},{7,63,1}},np.uint16)
 local b=np.array({{0.5,(0/0),-9.5}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.fmax(a,b,{out=o,where=m})
 assert(r==o,'fmax out identity 1323')
 assert(veq(o:tolist(),{{7.0,3.0,15.0},{3.0,63.0,3.0}}),'fmax out values 1323')
end
do -- outwhere copysign 1324
 local a=np.array({{-9.5,3.5,-9.5},{-9.5,-1.0,-1.0}},np.float64)
 local b=np.array({{9.0,-9.5,-9.5}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1324')
 assert(veq(o:tolist(),{{9.5,3.0,-9.5},{3.0,-1.0,3.0}}),'copysign out values 1324')
end
do -- outwhere copysign 1325
 local a=np.array({{0,31,63},{3,7,0}},np.uint8)
 local b=np.array({{30,30,15}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1325')
 assert(veq(o:tolist(),{{0.0,3.0,63.0},{3.0,7.0,3.0}}),'copysign out values 1325')
end
do -- outwhere copysign 1326
 local a=np.array({{2.0,-3.0,0.5},{2.0,-3.0,-1.5}},np.float32)
 local b=np.array({{0.0,2.0,-9.5}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1326')
 assert(veq(o:tolist(),{{2.0,3.0,-0.5},{3.0,3.0,3.0}}),'copysign out values 1326')
end
do -- outwhere copysign 1327
 local a=np.array({{-1,-3,-31},{-31,-31,7}},np.int8)
 local b=np.array({{15,30,7}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1327')
 assert(veq(o:tolist(),{{1.0,3.0,31.0},{3.0,31.0,3.0}}),'copysign out values 1327')
end
do -- outwhere copysign 1328
 local a=np.array({{7,15,30},{3,-9,3}},np.int32)
 local b=np.array({{30,0,-3}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1328')
 assert(veq(o:tolist(),{{7.0,3.0,-30.0},{3.0,9.0,3.0}}),'copysign out values 1328')
end
do -- outwhere copysign 1329
 local a=np.array({{-1.0,9.0,0.0},{3.5,-9.5,2.0}},np.float16)
 local b=np.array({{0.0,9.0,1.0}},np.float16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1329')
 assert(veq(o:tolist(),{{1.0,3.0,0.0},{3.0,9.5,3.0}}),'copysign out values 1329')
end
do -- outwhere copysign 1330
 local a=np.array({{1.0,0.5,-1.0},{0.5,9.0,0.5}},np.float32)
 local b=np.array({{-0.0,0.5,9.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1330')
 assert(veq(o:tolist(),{{-1.0,3.0,1.0},{3.0,9.0,3.0}}),'copysign out values 1330')
end
do -- outwhere copysign 1331
 local a=np.array({{1.0,-3.0,0.0},{-3.0,-3.0,2.0}},np.float32)
 local b=np.array({{3.5,-3.0,-9.5}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1331')
 assert(veq(o:tolist(),{{1.0,3.0,-0.0},{3.0,-3.0,3.0}}),'copysign out values 1331')
end
do -- outwhere copysign 1332
 local a=np.array({{3,0,7},{-9,-9,-3}},np.int64)
 local b=np.array({{31,2,3}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1332')
 assert(veq(o:tolist(),{{3.0,3.0,7.0},{3.0,9.0,3.0}}),'copysign out values 1332')
end
do -- outwhere copysign 1333
 local a=np.array({{-0.0,-9.5,1.0},{-1.0,-1.0,-9.5}},np.float16)
 local b=np.array({{2,0,15}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1333')
 assert(veq(o:tolist(),{{0.0,3.0,1.0},{3.0,1.0,3.0}}),'copysign out values 1333')
end
do -- outwhere copysign 1334
 local a=np.array({{-9,-9,7},{-31,2,-9}},np.int64)
 local b=np.array({{2,1,7}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1334')
 assert(veq(o:tolist(),{{9.0,3.0,7.0},{3.0,2.0,3.0}}),'copysign out values 1334')
end
do -- outwhere copysign 1335
 local a=np.array({{3,3,2},{-31,2,30}},np.int64)
 local b=np.array({{15,15,3}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1335')
 assert(veq(o:tolist(),{{3.0,3.0,2.0},{3.0,2.0,3.0}}),'copysign out values 1335')
end
do -- outwhere copysign 1336
 local a=np.array({{-0.0,-3.0,0.5},{-0.0,-1.5,0.5}},np.float16)
 local b=np.array({{2.0,-1.5,3.5}},np.float16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1336')
 assert(veq(o:tolist(),{{0.0,3.0,0.5},{3.0,-1.5,3.0}}),'copysign out values 1336')
end
do -- outwhere copysign 1337
 local a=np.array({{127,1,5},{7,63,63}},np.uint8)
 local b=np.array({{1,-3,0}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1337')
 assert(veq(o:tolist(),{{127.0,3.0,5.0},{3.0,-63.0,3.0}}),'copysign out values 1337')
end
do -- outwhere copysign 1338
 local a=np.array({{-0.0,3.5,-1.5},{-9.5,2.0,0.5}},np.float16)
 local b=np.array({{-1.0,0.0,-3.0}},np.float16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1338')
 assert(veq(o:tolist(),{{-0.0,3.0,-1.5},{3.0,2.0,3.0}}),'copysign out values 1338')
end
do -- outwhere copysign 1339
 local a=np.array({{2.0,3.5,-0.0},{-3.0,9.0,-1.5}},np.float16)
 local b=np.array({{1,-1,30}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1339')
 assert(veq(o:tolist(),{{2.0,3.0,0.0},{3.0,-9.0,3.0}}),'copysign out values 1339')
end
do -- outwhere copysign 1340
 local a=np.array({{2,1,7},{127,31,127}},np.uint16)
 local b=np.array({{1,1,-31}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1340')
 assert(veq(o:tolist(),{{2.0,3.0,-7.0},{3.0,31.0,3.0}}),'copysign out values 1340')
end
do -- outwhere copysign 1341
 local a=np.array({{1,15,1},{15,7,0}},np.int64)
 local b=np.array({{127,3,127}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1341')
 assert(veq(o:tolist(),{{1.0,3.0,1.0},{3.0,7.0,3.0}}),'copysign out values 1341')
end
do -- outwhere copysign 1342
 local a=np.array({{2.0,-9.5,-9.5},{0.5,0.0,3.5}},np.float32)
 local b=np.array({{2,-31,30}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1342')
 assert(veq(o:tolist(),{{2.0,3.0,9.5},{3.0,-0.0,3.0}}),'copysign out values 1342')
end
do -- outwhere copysign 1343
 local a=np.array({{-9,7,-1},{2,3,1}},np.int64)
 local b=np.array({{127,15,5}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1343')
 assert(veq(o:tolist(),{{9.0,3.0,1.0},{3.0,3.0,3.0}}),'copysign out values 1343')
end
do -- outwhere copysign 1344
 local a=np.array({{-0.0,0.5,0.0},{2.0,-1.5,3.5}},np.float64)
 local b=np.array({{-1.5,-9.5,-0.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1344')
 assert(veq(o:tolist(),{{-0.0,3.0,-0.0},{3.0,-1.5,3.0}}),'copysign out values 1344')
end
do -- outwhere copysign 1345
 local a=np.array({{0.0,2.0,9.0},{0.5,-9.5,0.5}},np.float16)
 local b=np.array({{30,-31,15}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1345')
 assert(veq(o:tolist(),{{0.0,3.0,9.0},{3.0,-9.5,3.0}}),'copysign out values 1345')
end
do -- outwhere copysign 1346
 local a=np.array({{7,2,2},{-1,-1,3}},np.int8)
 local b=np.array({{0,7,15}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1346')
 assert(veq(o:tolist(),{{7.0,3.0,2.0},{3.0,1.0,3.0}}),'copysign out values 1346')
end
do -- outwhere copysign 1347
 local a=np.array({{5,1,15},{0,7,1}},np.uint8)
 local b=np.array({{-9,7,-9}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1347')
 assert(veq(o:tolist(),{{-5.0,3.0,-15.0},{3.0,7.0,3.0}}),'copysign out values 1347')
end
do -- outwhere copysign 1348
 local a=np.array({{-0.0,-0.0,-9.5},{-9.5,2.0,2.0}},np.float64)
 local b=np.array({{2,-1,0}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1348')
 assert(veq(o:tolist(),{{0.0,3.0,9.5},{3.0,-2.0,3.0}}),'copysign out values 1348')
end
do -- outwhere copysign 1349
 local a=np.array({{-1.5,-1.5,0.5},{1.0,2.0,9.0}},np.float64)
 local b=np.array({{0.0,-9.5,0.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1349')
 assert(veq(o:tolist(),{{1.5,3.0,0.5},{3.0,-2.0,3.0}}),'copysign out values 1349')
end
do -- outwhere copysign 1350
 local a=np.array({{0,-9,0},{0,0,-31}},np.int8)
 local b=np.array({{2,-9,0}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1350')
 assert(veq(o:tolist(),{{0.0,3.0,0.0},{3.0,-0.0,3.0}}),'copysign out values 1350')
end
do -- outwhere copysign 1351
 local a=np.array({{3,1,1},{3,127,15}},np.uint16)
 local b=np.array({{30,-31,2}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1351')
 assert(veq(o:tolist(),{{3.0,3.0,1.0},{3.0,-127.0,3.0}}),'copysign out values 1351')
end
do -- outwhere copysign 1352
 local a=np.array({{0.5,1.0,3.5},{2.0,0.5,-3.0}},np.float64)
 local b=np.array({{-9.5,2.0,-1.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1352')
 assert(veq(o:tolist(),{{-0.5,3.0,-3.5},{3.0,0.5,3.0}}),'copysign out values 1352')
end
do -- outwhere copysign 1353
 local a=np.array({{9.0,2.0,-1.5},{-9.5,-1.0,-3.0}},np.float16)
 local b=np.array({{-1.5,0.0,1.0}},np.float16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.copysign(a,b,{out=o,where=m})
 assert(r==o,'copysign out identity 1353')
 assert(veq(o:tolist(),{{-9.0,3.0,1.5},{3.0,1.0,3.0}}),'copysign out values 1353')
end

do
  local a=np.array({-7,-7,7,7},np.int8)
  local b=np.array({3,-3,3,-3},np.int8)
  assert(veq(np.floor_divide(a,b):tolist(),{-3,2,2,-3}),'signed floor divide')
  assert(veq(np.remainder(a,b):tolist(),{2,-1,1,-2}),'signed remainder')
end

do
  local a=np.array({-128},np.int8)
  local b=np.array({-1},np.int8)
  assert(np.floor_divide(a,b)[1]==-128,'signed floor overflow wrap')
  assert(np.remainder(a,b)[1]==0,'signed remainder overflow zero')
end

do
  local a=np.array({2,2},np.int8)
  local e=np.array({-1,2},np.int8)
  local o=np.zeros({2},np.int8)
  local m=np.array({false,true},np.bool)
  np.power(a,e,{out=o,where=m})
  assert(veq(o:tolist(),{0,4}),'masked negative integer power')
  local ok=pcall(function() return np.power(a,e) end)
  assert(not ok,'active negative integer power must fail')
end

do
  local b=np.array({true,false},np.bool)
  assert(np.floor_divide(b,true).dtype=='int8','bool floor bool dtype')
  assert(np.power(b,true).dtype=='int8','bool power bool dtype')
  assert(np.bitwise_or(b,true).dtype=='bool','bool bitwise dtype')
end

do
  local a=np.array({1.0,0/0,-0.0},np.float64)
  local b=np.array({0/0,2.0,0.0},np.float64)
  assert(veq(np.fmax(a,b):tolist(),{1.0,2.0,0.0}),'fmax nan ignore')
  assert(veq(np.fmin(a,b):tolist(),{1.0,2.0,0.0}),'fmin nan ignore')
end

do
  local a=np.array({7,8},np.int8)
  assert((a//3):tolist()[1]==2,'__idiv')
  assert((a%3):tolist()[2]==2,'__mod')
  assert((np.array({2,3},np.int8)^2):tolist()[2]==9,'__pow')
  assert((np.array({6},np.int8)&3)[1]==2,'__band')
  assert((np.array({4},np.int8)|3)[1]==7,'__bor')
  assert((np.array({7},np.int8)~3)[1]==4,'__bxor')
end

print('numeric ops differential: 1360 cases ok')
