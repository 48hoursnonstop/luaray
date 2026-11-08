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
  return math.abs(a-b)<=3e-6*scale
end

do -- equal array 0
  local a=np.array({{63,127,2},{63,17,2}},np.uint32)
  local b=np.array({1,-7,-7},np.int16)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 0 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 0 shape')
  assert(seqeq(r.strides,{3,1}),'equal 0 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'equal 0 values')
end
do -- equal array 1
  local a=np.array({{2,9,0},{0,-127,-127}},np.int8)
  local b=np.array({{63,2,17}},np.uint8)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 1 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 1 shape')
  assert(seqeq(r.strides,{3,1}),'equal 1 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'equal 1 values')
end
do -- equal array 2
  local a=np.array({{-127,63,2},{9,-127,-31}},np.int32)
  local b=np.array({1,17,1},np.uint64)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 2 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 2 shape')
  assert(seqeq(r.strides,{3,1}),'equal 2 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'equal 2 values')
end
do -- equal array 3
  local a=np.array({-31,63,-31,2,-31},np.int16)
  local b=np.array({63,2,5,127,1},np.uint32)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 3 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'equal 3 shape')
  assert(seqeq(r.strides,{1}),'equal 3 strides')
  assert(veq(r:tolist(),{false,false,false,false,false}),'equal 3 values')
end
do -- equal array 4
  local a=np.array({251,127,17,63,1},np.uint64)
  local b=np.array({-31,0,-1,126,1},np.int32)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 4 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'equal 4 shape')
  assert(seqeq(r.strides,{1}),'equal 4 strides')
  assert(veq(r:tolist(),{false,false,false,false,true}),'equal 4 values')
end
do -- equal array 5
  local a=np.array({{{-31},{63},{2}},{{126},{2},{126}}},np.int8)
  local b=np.array({{{1,63,1,63},{17,127,1,17},{2,0,0,5}}},np.uint16)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 5 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'equal 5 shape')
  assert(seqeq(r.strides,{12,4,1}),'equal 5 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,false,false},{true,false,false,false}},{{false,false,false,false},{false,false,false,false},{false,false,false,false}}}),'equal 5 values')
end
do -- equal array 6
  local a=np.array({{-7,0,9},{9,126,1}},np.int32)
  local b=np.array({{2,-7,-1}},np.int64)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 6 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 6 shape')
  assert(seqeq(r.strides,{3,1}),'equal 6 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'equal 6 values')
end
do -- equal array 7
  local a=np.array({{{63},{-31},{1}},{{63},{1},{-31}}},np.int64)
  local b=np.array({{{-2.25,0.0,-0.0,0.5},{-math.huge,0.5,math.huge,1.0},{-math.huge,3.75,-math.huge,-2.25}}},np.float64)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 7 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'equal 7 shape')
  assert(seqeq(r.strides,{12,4,1}),'equal 7 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,false,false},{false,false,false,false}},{{false,false,false,false},{false,false,false,true},{false,false,false,false}}}),'equal 7 values')
end
do -- equal array 8
  local a=np.array({{{9},{-7},{-7}},{{-127},{2},{126}}},np.int32)
  local b=np.array({{{-127,1,-31,9},{63,63,-31,-31},{-31,1,-31,1}}},np.int16)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 8 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'equal 8 shape')
  assert(seqeq(r.strides,{12,4,1}),'equal 8 strides')
  assert(veq(r:tolist(),{{{false,false,false,true},{false,false,false,false},{false,false,false,false}},{{true,false,false,false},{false,false,false,false},{false,false,false,false}}}),'equal 8 values')
end
do -- equal array 9
  local a=np.array({{1,0,17},{63,63,0}},np.uint32)
  local b=np.array({-7,1,1},np.int16)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 9 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 9 shape')
  assert(seqeq(r.strides,{3,1}),'equal 9 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'equal 9 values')
end
do -- equal array 10
  local a=np.array({{true,false,false},{true,false,false}},np.bool)
  local b=np.array({-math.huge,0.5,-math.huge},np.float32)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 10 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 10 shape')
  assert(seqeq(r.strides,{3,1}),'equal 10 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'equal 10 values')
end
do -- equal array 11
  local a=np.array({{{math.huge},{3.75},{1.0}},{{(0/0)},{-2.25},{1.0}}},np.float16)
  local b=np.array({{{0.5,-math.huge,-0.0,-math.huge},{0.0,0.5,0.0,(0/0)},{math.huge,-0.0,0.0,3.75}}},np.float64)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 11 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'equal 11 shape')
  assert(seqeq(r.strides,{12,4,1}),'equal 11 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,false,false},{false,false,false,false}},{{false,false,false,false},{false,false,false,false},{false,false,false,false}}}),'equal 11 values')
end
do -- equal array 12
  local a=np.array({{{2},{17},{17}},{{127},{251},{63}}},np.uint16)
  local b=np.array({{{251,251,63,5},{5,2,0,2},{63,251,1,2}}},np.uint8)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 12 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'equal 12 shape')
  assert(seqeq(r.strides,{12,4,1}),'equal 12 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,false,false},{false,false,false,false}},{{false,false,false,false},{false,false,false,false},{true,false,false,false}}}),'equal 12 values')
end
do -- equal array 13
  local a=np.array({{5},{1}},np.uint16)
  local b=np.array({{0.0,0.5,math.huge}},np.float64)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 13 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 13 shape')
  assert(seqeq(r.strides,{3,1}),'equal 13 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'equal 13 values')
end
do -- equal array 14
  local a=np.array({{-31,0,-31},{63,0,-7}},np.int64)
  local b=np.array({{5,17,127}},np.uint16)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 14 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 14 shape')
  assert(seqeq(r.strides,{3,1}),'equal 14 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'equal 14 values')
end
do -- equal array 15
  local a=np.array({{{126},{-31},{-127}},{{-31},{9},{-31}}},np.int32)
  local b=np.array({{{5,5,63,17},{127,0,1,251},{5,0,63,17}}},np.uint8)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 15 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'equal 15 shape')
  assert(seqeq(r.strides,{12,4,1}),'equal 15 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,false,false},{false,false,false,false}},{{false,false,false,false},{false,false,false,false},{false,false,false,false}}}),'equal 15 values')
end
do -- equal array 16
  local a=np.array({{1},{-7}},np.int16)
  local b=np.array({{126,2,-1}},np.int64)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 16 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 16 shape')
  assert(seqeq(r.strides,{3,1}),'equal 16 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'equal 16 values')
end
do -- equal array 17
  local a=np.array({{{17},{1},{1}},{{17},{127},{1}}},np.uint32)
  local b=np.array({{{2,1,0,0},{0,63,5,2},{5,63,17,63}}},np.uint32)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 17 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'equal 17 shape')
  assert(seqeq(r.strides,{12,4,1}),'equal 17 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,false,false},{false,false,false,false}},{{false,false,false,false},{false,false,false,false},{false,false,false,false}}}),'equal 17 values')
end
do -- equal array 18
  local a=np.array({{11.0},{(0/0)}},np.float32)
  local b=np.array({{-31,126,0}},np.int16)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 18 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 18 shape')
  assert(seqeq(r.strides,{3,1}),'equal 18 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'equal 18 values')
end
do -- equal array 19
  local a=np.array({{{11.0},{-2.25},{-math.huge}},{{-9.5},{1.0},{-9.5}}},np.float32)
  local b=np.array({{{-31,-7,2,-127},{-1,1,-127,-7},{-31,2,-1,9}}},np.int16)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 19 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'equal 19 shape')
  assert(seqeq(r.strides,{12,4,1}),'equal 19 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,false,false},{false,false,false,false}},{{false,false,false,false},{false,true,false,false},{false,false,false,false}}}),'equal 19 values')
end
do -- equal array 20
  local a=np.array({11.0,(0/0),-math.huge,1.0,3.75},np.float64)
  local b=np.array({63,127,2,5,251},np.uint32)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 20 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'equal 20 shape')
  assert(seqeq(r.strides,{1}),'equal 20 strides')
  assert(veq(r:tolist(),{false,false,false,false,false}),'equal 20 values')
end
do -- equal array 21
  local a=np.array({{0,-7,-7},{0,-127,-127}},np.int16)
  local b=np.array({63,0,1},np.uint64)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 21 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 21 shape')
  assert(seqeq(r.strides,{3,1}),'equal 21 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'equal 21 values')
end
do -- equal array 22
  local a=np.array({{-1.0,3.75,3.75},{-2.25,-math.huge,math.huge}},np.float32)
  local b=np.array({{-31,9,63}},np.int16)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 22 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 22 shape')
  assert(seqeq(r.strides,{3,1}),'equal 22 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'equal 22 values')
end
do -- equal array 23
  local a=np.array({{math.huge},{11.0}},np.float64)
  local b=np.array({{127,127,5}},np.uint8)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 23 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 23 shape')
  assert(seqeq(r.strides,{3,1}),'equal 23 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'equal 23 values')
end
do -- equal array 24
  local a=np.array({{1,1,2},{17,63,0}},np.uint32)
  local b=np.array({{-127,126,63}},np.int32)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 24 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 24 shape')
  assert(seqeq(r.strides,{3,1}),'equal 24 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'equal 24 values')
end
do -- equal array 25
  local a=np.array({{{5},{127},{63}},{{5},{0},{0}}},np.uint64)
  local b=np.array({{{true,true,true,true},{true,true,false,false},{false,true,false,false}}},np.bool)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 25 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'equal 25 shape')
  assert(seqeq(r.strides,{12,4,1}),'equal 25 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,false,false},{false,false,false,false}},{{false,false,false,false},{false,false,true,true},{true,false,true,true}}}),'equal 25 values')
end
do -- equal array 26
  local a=np.array({{-7,126,-31},{0,9,63}},np.int32)
  local b=np.array({{2,2,127}},np.uint16)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 26 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 26 shape')
  assert(seqeq(r.strides,{3,1}),'equal 26 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'equal 26 values')
end
do -- equal array 27
  local a=np.array({{-math.huge,11.0,-1.0},{0.5,11.0,math.huge}},np.float32)
  local b=np.array({{127,1,63}},np.uint64)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 27 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 27 shape')
  assert(seqeq(r.strides,{3,1}),'equal 27 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'equal 27 values')
end
do -- equal array 28
  local a=np.array({{5,5,63},{17,127,251}},np.uint16)
  local b=np.array({true,false,false},np.bool)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 28 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 28 shape')
  assert(seqeq(r.strides,{3,1}),'equal 28 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'equal 28 values')
end
do -- equal array 29
  local a=np.array({{{false},{true},{true}},{{true},{true},{false}}},np.bool)
  local b=np.array({{{5,1,2,5},{5,2,1,127},{17,63,0,1}}},np.uint32)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 29 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'equal 29 shape')
  assert(seqeq(r.strides,{12,4,1}),'equal 29 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,true,false},{false,false,false,true}},{{false,true,false,false},{false,false,true,false},{false,false,true,false}}}),'equal 29 values')
end
do -- equal array 30
  local a=np.array({true,false,false,false,true},np.bool)
  local b=np.array({-0.0,11.0,-0.0,math.huge,1.0},np.float64)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 30 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'equal 30 shape')
  assert(seqeq(r.strides,{1}),'equal 30 strides')
  assert(veq(r:tolist(),{false,false,true,false,true}),'equal 30 values')
end
do -- equal array 31
  local a=np.array({{-7},{-1}},np.int16)
  local b=np.array({{false,false,false}},np.bool)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 31 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 31 shape')
  assert(seqeq(r.strides,{3,1}),'equal 31 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'equal 31 values')
end
do -- equal array 32
  local a=np.array({{-1.0,-9.5,-0.0},{(0/0),-9.5,-1.0}},np.float32)
  local b=np.array({11.0,math.huge,math.huge},np.float32)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 32 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 32 shape')
  assert(seqeq(r.strides,{3,1}),'equal 32 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'equal 32 values')
end
do -- equal array 33
  local a=np.array({{{127},{251},{1}},{{17},{127},{17}}},np.uint64)
  local b=np.array({{{251,1,63,17},{63,0,251,1},{17,127,17,251}}},np.uint8)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 33 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'equal 33 shape')
  assert(seqeq(r.strides,{12,4,1}),'equal 33 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,true,false},{false,false,false,false}},{{false,false,false,true},{false,false,false,false},{true,false,true,false}}}),'equal 33 values')
end
do -- equal array 34
  local a=np.array({-127,1,0,-1,1},np.int16)
  local b=np.array({-31,9,-127,126,9},np.int16)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 34 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'equal 34 shape')
  assert(seqeq(r.strides,{1}),'equal 34 strides')
  assert(veq(r:tolist(),{false,false,false,false,false}),'equal 34 values')
end
do -- equal array 35
  local a=np.array({{{-1.0},{-math.huge},{3.75}},{{-math.huge},{0.5},{11.0}}},np.float32)
  local b=np.array({{{127,1,1,127},{1,251,17,0},{251,2,127,2}}},np.uint64)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 35 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'equal 35 shape')
  assert(seqeq(r.strides,{12,4,1}),'equal 35 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,false,false},{false,false,false,false}},{{false,false,false,false},{false,false,false,false},{false,false,false,false}}}),'equal 35 values')
end
do -- equal array 36
  local a=np.array({251,17,2,17,2},np.uint32)
  local b=np.array({3.75,11.0,0.5,0.5,-math.huge},np.float64)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 36 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'equal 36 shape')
  assert(seqeq(r.strides,{1}),'equal 36 strides')
  assert(veq(r:tolist(),{false,false,false,false,false}),'equal 36 values')
end
do -- equal array 37
  local a=np.array({{1,0,0},{17,63,17}},np.uint16)
  local b=np.array({127,17,5},np.uint32)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 37 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 37 shape')
  assert(seqeq(r.strides,{3,1}),'equal 37 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'equal 37 values')
end
do -- equal array 38
  local a=np.array({{true,false,true},{true,true,true}},np.bool)
  local b=np.array({{-127,126,-31}},np.int32)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 38 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 38 shape')
  assert(seqeq(r.strides,{3,1}),'equal 38 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'equal 38 values')
end
do -- equal array 39
  local a=np.array({false,false,false,false,true},np.bool)
  local b=np.array({-7,63,-1,126,-1},np.int16)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 39 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'equal 39 shape')
  assert(seqeq(r.strides,{1}),'equal 39 strides')
  assert(veq(r:tolist(),{false,false,false,false,false}),'equal 39 values')
end
do -- equal array 40
  local a=np.array({{1,127,17},{251,17,127}},np.uint32)
  local b=np.array({{1,0,17}},np.uint16)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 40 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 40 shape')
  assert(seqeq(r.strides,{3,1}),'equal 40 strides')
  assert(veq(r:tolist(),{{true,false,true},{false,false,false}}),'equal 40 values')
end
do -- equal array 41
  local a=np.array({false,false,false,false,false},np.bool)
  local b=np.array({0,0,5,127,17},np.uint64)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 41 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'equal 41 shape')
  assert(seqeq(r.strides,{1}),'equal 41 strides')
  assert(veq(r:tolist(),{true,true,false,false,false}),'equal 41 values')
end
do -- equal array 42
  local a=np.array({{{2},{17},{2}},{{1},{251},{1}}},np.uint32)
  local b=np.array({{{0.5,-9.5,(0/0),-0.0},{0.0,0.5,-math.huge,0.0},{math.huge,0.0,3.75,math.huge}}},np.float32)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 42 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'equal 42 shape')
  assert(seqeq(r.strides,{12,4,1}),'equal 42 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,false,false},{false,false,false,false}},{{false,false,false,false},{false,false,false,false},{false,false,false,false}}}),'equal 42 values')
end
do -- equal array 43
  local a=np.array({{{1.0},{-2.25},{-1.0}},{{0.0},{1.0},{0.5}}},np.float16)
  local b=np.array({{{math.huge,-math.huge,11.0,-2.25},{3.75,-math.huge,-9.5,11.0},{(0/0),-math.huge,3.75,math.huge}}},np.float32)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 43 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'equal 43 shape')
  assert(seqeq(r.strides,{12,4,1}),'equal 43 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,false,false},{false,false,false,false}},{{false,false,false,false},{false,false,false,false},{false,false,false,false}}}),'equal 43 values')
end
do -- equal array 44
  local a=np.array({{9,126,-7},{0,126,63}},np.int16)
  local b=np.array({{(0/0),11.0,-math.huge}},np.float64)
  local r=np.equal(a,b)
  assert(r.dtype=='bool','equal 44 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'equal 44 shape')
  assert(seqeq(r.strides,{3,1}),'equal 44 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'equal 44 values')
end
do -- not_equal array 45
  local a=np.array({{-7},{-31}},np.int64)
  local b=np.array({{251,0,5}},np.uint16)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 45 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 45 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 45 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'not_equal 45 values')
end
do -- not_equal array 46
  local a=np.array({{-math.huge},{3.75}},np.float32)
  local b=np.array({{127,63,2}},np.uint8)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 46 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 46 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 46 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'not_equal 46 values')
end
do -- not_equal array 47
  local a=np.array({{{126},{2},{63}},{{126},{-1},{-7}}},np.int16)
  local b=np.array({{{-7,9,63,1},{9,-127,0,126},{9,1,2,126}}},np.int64)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 47 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'not_equal 47 shape')
  assert(seqeq(r.strides,{12,4,1}),'not_equal 47 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,true,true,true},{true,true,true,true}},{{true,true,true,true},{true,true,true,true},{true,true,true,true}}}),'not_equal 47 values')
end
do -- not_equal array 48
  local a=np.array({{{63},{0},{0}},{{2},{251},{2}}},np.uint8)
  local b=np.array({{{63,2,2,251},{63,251,17,5},{63,5,251,127}}},np.uint8)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 48 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'not_equal 48 shape')
  assert(seqeq(r.strides,{12,4,1}),'not_equal 48 strides')
  assert(veq(r:tolist(),{{{false,true,true,true},{true,true,true,true},{true,true,true,true}},{{true,false,false,true},{true,false,true,true},{true,true,true,true}}}),'not_equal 48 values')
end
do -- not_equal array 49
  local a=np.array({{17},{2}},np.uint8)
  local b=np.array({{0,-1,-1}},np.int16)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 49 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 49 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 49 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'not_equal 49 values')
end
do -- not_equal array 50
  local a=np.array({{251,63,2},{251,63,251}},np.uint8)
  local b=np.array({{-0.0,-9.5,3.75}},np.float32)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 50 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 50 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 50 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'not_equal 50 values')
end
do -- not_equal array 51
  local a=np.array({{-7,2,-1},{2,9,1}},np.int64)
  local b=np.array({{3.75,-2.25,0.0}},np.float32)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 51 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 51 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 51 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'not_equal 51 values')
end
do -- not_equal array 52
  local a=np.array({2,2,-31,-1,-127},np.int64)
  local b=np.array({-127,2,-31,0,1},np.int16)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 52 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'not_equal 52 shape')
  assert(seqeq(r.strides,{1}),'not_equal 52 strides')
  assert(veq(r:tolist(),{true,false,false,true,true}),'not_equal 52 values')
end
do -- not_equal array 53
  local a=np.array({{5},{251}},np.uint8)
  local b=np.array({{1,251,5}},np.uint8)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 53 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 53 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 53 strides')
  assert(veq(r:tolist(),{{true,true,false},{true,false,true}}),'not_equal 53 values')
end
do -- not_equal array 54
  local a=np.array({{2,-127,1},{-7,-1,9}},np.int16)
  local b=np.array({-31,9,126},np.int8)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 54 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 54 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 54 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'not_equal 54 values')
end
do -- not_equal array 55
  local a=np.array({1,1,5,127,127},np.uint32)
  local b=np.array({63,2,5,0,0},np.uint64)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 55 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'not_equal 55 shape')
  assert(seqeq(r.strides,{1}),'not_equal 55 strides')
  assert(veq(r:tolist(),{true,true,false,true,true}),'not_equal 55 values')
end
do -- not_equal array 56
  local a=np.array({{5},{1}},np.uint16)
  local b=np.array({{2,127,63}},np.uint16)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 56 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 56 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 56 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'not_equal 56 values')
end
do -- not_equal array 57
  local a=np.array({{false,false,false},{true,false,false}},np.bool)
  local b=np.array({false,false,false},np.bool)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 57 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 57 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 57 strides')
  assert(veq(r:tolist(),{{false,false,false},{true,false,false}}),'not_equal 57 values')
end
do -- not_equal array 58
  local a=np.array({{5},{5}},np.uint64)
  local b=np.array({{17,5,63}},np.uint64)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 58 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 58 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 58 strides')
  assert(veq(r:tolist(),{{true,false,true},{true,false,true}}),'not_equal 58 values')
end
do -- not_equal array 59
  local a=np.array({{true},{false}},np.bool)
  local b=np.array({{false,true,false}},np.bool)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 59 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 59 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 59 strides')
  assert(veq(r:tolist(),{{true,false,true},{false,true,false}}),'not_equal 59 values')
end
do -- not_equal array 60
  local a=np.array({-math.huge,-9.5,0.5,(0/0),-0.0},np.float64)
  local b=np.array({1.0,-1.0,0.5,(0/0),-0.0},np.float64)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 60 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'not_equal 60 shape')
  assert(seqeq(r.strides,{1}),'not_equal 60 strides')
  assert(veq(r:tolist(),{true,true,false,true,false}),'not_equal 60 values')
end
do -- not_equal array 61
  local a=np.array({{1.0,-2.25,0.0},{-0.0,-2.25,-0.0}},np.float16)
  local b=np.array({{63,-127,63}},np.int32)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 61 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 61 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 61 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'not_equal 61 values')
end
do -- not_equal array 62
  local a=np.array({{2,2,17},{127,17,0}},np.uint8)
  local b=np.array({5,63,63},np.uint32)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 62 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 62 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 62 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'not_equal 62 values')
end
do -- not_equal array 63
  local a=np.array({1,2,127,63,5},np.uint64)
  local b=np.array({0,251,251,251,17},np.uint64)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 63 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'not_equal 63 shape')
  assert(seqeq(r.strides,{1}),'not_equal 63 strides')
  assert(veq(r:tolist(),{true,true,true,true,true}),'not_equal 63 values')
end
do -- not_equal array 64
  local a=np.array({{{63},{17},{0}},{{0},{17},{1}}},np.uint8)
  local b=np.array({{{-1.0,-9.5,-0.0,3.75},{-1.0,0.0,math.huge,-2.25},{-0.0,math.huge,-0.0,-1.0}}},np.float64)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 64 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'not_equal 64 shape')
  assert(seqeq(r.strides,{12,4,1}),'not_equal 64 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,true,true,true},{false,true,false,true}},{{true,true,false,true},{true,true,true,true},{true,true,true,true}}}),'not_equal 64 values')
end
do -- not_equal array 65
  local a=np.array({{9,-127,-7},{9,2,-31}},np.int64)
  local b=np.array({0.5,0.5,(0/0)},np.float16)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 65 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 65 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 65 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'not_equal 65 values')
end
do -- not_equal array 66
  local a=np.array({{2,1,17},{0,251,127}},np.uint32)
  local b=np.array({3.75,1.0,0.5},np.float16)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 66 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 66 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 66 strides')
  assert(veq(r:tolist(),{{true,false,true},{true,true,true}}),'not_equal 66 values')
end
do -- not_equal array 67
  local a=np.array({{{5},{2},{1}},{{5},{251},{1}}},np.uint64)
  local b=np.array({{{-127,-31,2,2},{-127,63,-1,2},{1,0,63,2}}},np.int8)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 67 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'not_equal 67 shape')
  assert(seqeq(r.strides,{12,4,1}),'not_equal 67 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,true,true,false},{false,true,true,true}},{{true,true,true,true},{true,true,true,true},{false,true,true,true}}}),'not_equal 67 values')
end
do -- not_equal array 68
  local a=np.array({-31,0,2,2,-7},np.int16)
  local b=np.array({true,false,true,true,false},np.bool)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 68 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'not_equal 68 shape')
  assert(seqeq(r.strides,{1}),'not_equal 68 strides')
  assert(veq(r:tolist(),{true,false,true,true,true}),'not_equal 68 values')
end
do -- not_equal array 69
  local a=np.array({126,2,1,63,1},np.int32)
  local b=np.array({251,127,2,1,1},np.uint8)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 69 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'not_equal 69 shape')
  assert(seqeq(r.strides,{1}),'not_equal 69 strides')
  assert(veq(r:tolist(),{true,true,true,true,false}),'not_equal 69 values')
end
do -- not_equal array 70
  local a=np.array({{5},{1}},np.uint64)
  local b=np.array({{true,false,true}},np.bool)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 70 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 70 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 70 strides')
  assert(veq(r:tolist(),{{true,true,true},{false,true,false}}),'not_equal 70 values')
end
do -- not_equal array 71
  local a=np.array({{-7},{126}},np.int64)
  local b=np.array({{1,1,63}},np.int8)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 71 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 71 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 71 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'not_equal 71 values')
end
do -- not_equal array 72
  local a=np.array({5,5,251,251,17},np.uint32)
  local b=np.array({false,false,false,true,true},np.bool)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 72 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'not_equal 72 shape')
  assert(seqeq(r.strides,{1}),'not_equal 72 strides')
  assert(veq(r:tolist(),{true,true,true,true,true}),'not_equal 72 values')
end
do -- not_equal array 73
  local a=np.array({{127,17,1},{2,1,251}},np.uint32)
  local b=np.array({{2,0,251}},np.uint16)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 73 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 73 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 73 strides')
  assert(veq(r:tolist(),{{true,true,true},{false,true,false}}),'not_equal 73 values')
end
do -- not_equal array 74
  local a=np.array({{1},{5}},np.uint16)
  local b=np.array({{63,1,17}},np.uint8)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 74 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 74 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 74 strides')
  assert(veq(r:tolist(),{{true,false,true},{true,true,true}}),'not_equal 74 values')
end
do -- not_equal array 75
  local a=np.array({1,0,9,-127,-127},np.int8)
  local b=np.array({-1,-127,63,126,-7},np.int32)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 75 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'not_equal 75 shape')
  assert(seqeq(r.strides,{1}),'not_equal 75 strides')
  assert(veq(r:tolist(),{true,true,true,true,true}),'not_equal 75 values')
end
do -- not_equal array 76
  local a=np.array({{{127},{17},{2}},{{0},{17},{5}}},np.uint8)
  local b=np.array({{{-31,63,-7,-31},{-127,-1,0,1},{63,-1,-7,-31}}},np.int64)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 76 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'not_equal 76 shape')
  assert(seqeq(r.strides,{12,4,1}),'not_equal 76 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,true,true,true},{true,true,true,true}},{{true,true,true,true},{true,true,true,true},{true,true,true,true}}}),'not_equal 76 values')
end
do -- not_equal array 77
  local a=np.array({{9,126,-31},{126,-7,9}},np.int16)
  local b=np.array({-1,-1,-31},np.int16)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 77 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 77 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 77 strides')
  assert(veq(r:tolist(),{{true,true,false},{true,true,true}}),'not_equal 77 values')
end
do -- not_equal array 78
  local a=np.array({9,0,1,-7,2},np.int8)
  local b=np.array({0.5,3.75,(0/0),3.75,0.5},np.float64)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 78 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'not_equal 78 shape')
  assert(seqeq(r.strides,{1}),'not_equal 78 strides')
  assert(veq(r:tolist(),{true,true,true,true,true}),'not_equal 78 values')
end
do -- not_equal array 79
  local a=np.array({{-9.5,-0.0,0.0},{-9.5,11.0,1.0}},np.float32)
  local b=np.array({{1,2,2}},np.uint16)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 79 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 79 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 79 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'not_equal 79 values')
end
do -- not_equal array 80
  local a=np.array({{{-7},{-31},{-7}},{{-1},{63},{-7}}},np.int64)
  local b=np.array({{{false,false,false,false},{true,false,true,true},{true,false,true,false}}},np.bool)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 80 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'not_equal 80 shape')
  assert(seqeq(r.strides,{12,4,1}),'not_equal 80 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,true,true,true},{true,true,true,true}},{{true,true,true,true},{true,true,true,true},{true,true,true,true}}}),'not_equal 80 values')
end
do -- not_equal array 81
  local a=np.array({{-31,-1,126},{1,126,-7}},np.int8)
  local b=np.array({{11.0,(0/0),math.huge}},np.float64)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 81 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 81 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 81 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'not_equal 81 values')
end
do -- not_equal array 82
  local a=np.array({{0,0,63},{251,1,127}},np.uint8)
  local b=np.array({9,1,9},np.int8)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 82 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 82 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 82 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,false,true}}),'not_equal 82 values')
end
do -- not_equal array 83
  local a=np.array({{-127},{-31}},np.int16)
  local b=np.array({{-2.25,1.0,-0.0}},np.float32)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 83 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 83 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 83 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'not_equal 83 values')
end
do -- not_equal array 84
  local a=np.array({{17,127,17},{5,0,1}},np.uint64)
  local b=np.array({{9,-31,126}},np.int64)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 84 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 84 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 84 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'not_equal 84 values')
end
do -- not_equal array 85
  local a=np.array({{2},{1}},np.uint16)
  local b=np.array({{false,true,true}},np.bool)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 85 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 85 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 85 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,false,false}}),'not_equal 85 values')
end
do -- not_equal array 86
  local a=np.array({{{1},{-7},{0}},{{9},{-127},{126}}},np.int64)
  local b=np.array({{{11.0,11.0,-0.0,-1.0},{-2.25,0.5,-0.0,-math.huge},{-1.0,1.0,(0/0),-0.0}}},np.float64)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 86 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'not_equal 86 shape')
  assert(seqeq(r.strides,{12,4,1}),'not_equal 86 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,true,true,true},{true,true,true,false}},{{true,true,true,true},{true,true,true,true},{true,true,true,true}}}),'not_equal 86 values')
end
do -- not_equal array 87
  local a=np.array({{-127,0,1},{-127,1,-31}},np.int8)
  local b=np.array({{-1,0,-127}},np.int16)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 87 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 87 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 87 strides')
  assert(veq(r:tolist(),{{true,false,true},{true,true,true}}),'not_equal 87 values')
end
do -- not_equal array 88
  local a=np.array({{1,127,0},{127,63,63}},np.uint8)
  local b=np.array({{1,63,63}},np.int8)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 88 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'not_equal 88 shape')
  assert(seqeq(r.strides,{3,1}),'not_equal 88 strides')
  assert(veq(r:tolist(),{{false,true,true},{true,false,false}}),'not_equal 88 values')
end
do -- not_equal array 89
  local a=np.array({{{-127},{2},{0}},{{1},{1},{9}}},np.int32)
  local b=np.array({{{0.5,-math.huge,-math.huge,-2.25},{0.5,-2.25,0.5,math.huge},{-2.25,-1.0,1.0,-0.0}}},np.float16)
  local r=np.not_equal(a,b)
  assert(r.dtype=='bool','not_equal 89 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'not_equal 89 shape')
  assert(seqeq(r.strides,{12,4,1}),'not_equal 89 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,true,true,true},{true,true,true,false}},{{true,true,true,true},{true,true,true,true},{true,true,true,true}}}),'not_equal 89 values')
end
do -- less array 90
  local a=np.array({-7,2,-31,-31,63},np.int16)
  local b=np.array({9,0,-31,9,1},np.int32)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 90 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'less 90 shape')
  assert(seqeq(r.strides,{1}),'less 90 strides')
  assert(veq(r:tolist(),{true,false,false,true,false}),'less 90 values')
end
do -- less array 91
  local a=np.array({{-31,9,126},{9,63,2}},np.int8)
  local b=np.array({-0.0,0.5,0.5},np.float32)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 91 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 91 shape')
  assert(seqeq(r.strides,{3,1}),'less 91 strides')
  assert(veq(r:tolist(),{{true,false,false},{false,false,false}}),'less 91 values')
end
do -- less array 92
  local a=np.array({{{127},{63},{63}},{{63},{17},{17}}},np.uint16)
  local b=np.array({{{126,126,-127,0},{-31,-7,-1,2},{126,1,9,-127}}},np.int32)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 92 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'less 92 shape')
  assert(seqeq(r.strides,{12,4,1}),'less 92 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,false,false},{true,false,false,false}},{{true,true,false,false},{false,false,false,false},{true,false,false,false}}}),'less 92 values')
end
do -- less array 93
  local a=np.array({{-127,-1,-31},{2,9,63}},np.int64)
  local b=np.array({1,2,0},np.uint64)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 93 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 93 shape')
  assert(seqeq(r.strides,{3,1}),'less 93 strides')
  assert(veq(r:tolist(),{{true,true,true},{false,false,false}}),'less 93 values')
end
do -- less array 94
  local a=np.array({63,0,-127,9,9},np.int32)
  local b=np.array({-127,126,-127,-31,-7},np.int32)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 94 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'less 94 shape')
  assert(seqeq(r.strides,{1}),'less 94 strides')
  assert(veq(r:tolist(),{false,true,false,false,false}),'less 94 values')
end
do -- less array 95
  local a=np.array({{1,127,127},{17,17,1}},np.uint8)
  local b=np.array({127,5,2},np.uint64)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 95 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 95 shape')
  assert(seqeq(r.strides,{3,1}),'less 95 strides')
  assert(veq(r:tolist(),{{true,false,false},{true,false,true}}),'less 95 values')
end
do -- less array 96
  local a=np.array({{63,0,63},{1,251,17}},np.uint16)
  local b=np.array({2,251,5},np.uint32)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 96 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 96 shape')
  assert(seqeq(r.strides,{3,1}),'less 96 strides')
  assert(veq(r:tolist(),{{false,true,false},{true,false,false}}),'less 96 values')
end
do -- less array 97
  local a=np.array({{-1},{-7}},np.int64)
  local b=np.array({{126,-127,0}},np.int64)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 97 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 97 shape')
  assert(seqeq(r.strides,{3,1}),'less 97 strides')
  assert(veq(r:tolist(),{{true,false,true},{true,false,true}}),'less 97 values')
end
do -- less array 98
  local a=np.array({{true},{true}},np.bool)
  local b=np.array({{0,-1,1}},np.int16)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 98 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 98 shape')
  assert(seqeq(r.strides,{3,1}),'less 98 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'less 98 values')
end
do -- less array 99
  local a=np.array({-127,9,63,-127,-127},np.int16)
  local b=np.array({-31,126,-7,0,126},np.int8)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 99 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'less 99 shape')
  assert(seqeq(r.strides,{1}),'less 99 strides')
  assert(veq(r:tolist(),{true,true,false,true,true}),'less 99 values')
end
do -- less array 100
  local a=np.array({{9,-1,-31},{-1,-7,-7}},np.int8)
  local b=np.array({{(0/0),-1.0,0.5}},np.float16)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 100 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 100 shape')
  assert(seqeq(r.strides,{3,1}),'less 100 strides')
  assert(veq(r:tolist(),{{false,false,true},{false,true,true}}),'less 100 values')
end
do -- less array 101
  local a=np.array({{0},{63}},np.int8)
  local b=np.array({{126,-127,63}},np.int16)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 101 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 101 shape')
  assert(seqeq(r.strides,{3,1}),'less 101 strides')
  assert(veq(r:tolist(),{{true,false,true},{true,false,false}}),'less 101 values')
end
do -- less array 102
  local a=np.array({{2,2,63},{63,1,2}},np.uint32)
  local b=np.array({{2,63,0}},np.int32)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 102 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 102 shape')
  assert(seqeq(r.strides,{3,1}),'less 102 strides')
  assert(veq(r:tolist(),{{false,true,false},{false,true,false}}),'less 102 values')
end
do -- less array 103
  local a=np.array({true,false,true,true,false},np.bool)
  local b=np.array({5,127,2,0,251},np.uint16)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 103 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'less 103 shape')
  assert(seqeq(r.strides,{1}),'less 103 strides')
  assert(veq(r:tolist(),{true,true,true,false,true}),'less 103 values')
end
do -- less array 104
  local a=np.array({{-0.0,1.0,(0/0)},{1.0,-2.25,-0.0}},np.float32)
  local b=np.array({2,63,63},np.int32)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 104 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 104 shape')
  assert(seqeq(r.strides,{3,1}),'less 104 strides')
  assert(veq(r:tolist(),{{true,true,false},{true,true,true}}),'less 104 values')
end
do -- less array 105
  local a=np.array({{{2},{17},{0}},{{17},{5},{63}}},np.uint16)
  local b=np.array({{{0,1,0,1},{-127,-31,-1,63},{2,0,0,63}}},np.int16)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 105 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'less 105 shape')
  assert(seqeq(r.strides,{12,4,1}),'less 105 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,false,true},{true,false,false,true}},{{false,false,false,false},{false,false,false,true},{false,false,false,false}}}),'less 105 values')
end
do -- less array 106
  local a=np.array({{-9.5,-2.25,-2.25},{-9.5,-9.5,11.0}},np.float32)
  local b=np.array({{-7,-7,-1}},np.int32)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 106 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 106 shape')
  assert(seqeq(r.strides,{3,1}),'less 106 strides')
  assert(veq(r:tolist(),{{true,false,true},{true,true,false}}),'less 106 values')
end
do -- less array 107
  local a=np.array({{0},{63}},np.uint16)
  local b=np.array({{false,true,false}},np.bool)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 107 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 107 shape')
  assert(seqeq(r.strides,{3,1}),'less 107 strides')
  assert(veq(r:tolist(),{{false,true,false},{false,false,false}}),'less 107 values')
end
do -- less array 108
  local a=np.array({false,true,true,false,true},np.bool)
  local b=np.array({-1.0,1.0,-2.25,0.5,-9.5},np.float64)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 108 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'less 108 shape')
  assert(seqeq(r.strides,{1}),'less 108 strides')
  assert(veq(r:tolist(),{false,false,false,true,false}),'less 108 values')
end
do -- less array 109
  local a=np.array({{{-math.huge},{3.75},{-9.5}},{{math.huge},{1.0},{-0.0}}},np.float64)
  local b=np.array({{{5,63,63,251},{63,63,1,251},{1,127,63,2}}},np.uint8)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 109 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'less 109 shape')
  assert(seqeq(r.strides,{12,4,1}),'less 109 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,true,false,true},{true,true,true,true}},{{false,false,false,false},{true,true,false,true},{true,true,true,true}}}),'less 109 values')
end
do -- less array 110
  local a=np.array({127,5,2,2,127},np.uint8)
  local b=np.array({5,1,63,2,2},np.uint32)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 110 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'less 110 shape')
  assert(seqeq(r.strides,{1}),'less 110 strides')
  assert(veq(r:tolist(),{false,false,true,false,false}),'less 110 values')
end
do -- less array 111
  local a=np.array({{false,true,true},{true,false,false}},np.bool)
  local b=np.array({{false,false,true}},np.bool)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 111 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 111 shape')
  assert(seqeq(r.strides,{3,1}),'less 111 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,true}}),'less 111 values')
end
do -- less array 112
  local a=np.array({0,1,2,0,251},np.uint64)
  local b=np.array({9,126,126,9,0},np.int64)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 112 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'less 112 shape')
  assert(seqeq(r.strides,{1}),'less 112 strides')
  assert(veq(r:tolist(),{true,true,true,true,false}),'less 112 values')
end
do -- less array 113
  local a=np.array({-math.huge,0.0,0.5,0.5,0.5},np.float64)
  local b=np.array({-9.5,-math.huge,-2.25,-2.25,-0.0},np.float64)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 113 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'less 113 shape')
  assert(seqeq(r.strides,{1}),'less 113 strides')
  assert(veq(r:tolist(),{true,false,false,false,false}),'less 113 values')
end
do -- less array 114
  local a=np.array({126,126,-31,9,-127},np.int8)
  local b=np.array({-0.0,-1.0,11.0,-1.0,-9.5},np.float64)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 114 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'less 114 shape')
  assert(seqeq(r.strides,{1}),'less 114 strides')
  assert(veq(r:tolist(),{false,false,true,false,true}),'less 114 values')
end
do -- less array 115
  local a=np.array({{-127},{-127}},np.int64)
  local b=np.array({{0,-7,9}},np.int64)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 115 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 115 shape')
  assert(seqeq(r.strides,{3,1}),'less 115 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'less 115 values')
end
do -- less array 116
  local a=np.array({{{127},{0},{2}},{{127},{63},{251}}},np.uint8)
  local b=np.array({{{false,true,false,true},{false,false,true,true},{true,false,false,true}}},np.bool)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 116 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'less 116 shape')
  assert(seqeq(r.strides,{12,4,1}),'less 116 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,true,true},{false,false,false,false}},{{false,false,false,false},{false,false,false,false},{false,false,false,false}}}),'less 116 values')
end
do -- less array 117
  local a=np.array({{0},{2}},np.int8)
  local b=np.array({{126,-127,9}},np.int8)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 117 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 117 shape')
  assert(seqeq(r.strides,{3,1}),'less 117 strides')
  assert(veq(r:tolist(),{{true,false,true},{true,false,true}}),'less 117 values')
end
do -- less array 118
  local a=np.array({{9,-1,1},{2,9,-1}},np.int16)
  local b=np.array({true,true,false},np.bool)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 118 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 118 shape')
  assert(seqeq(r.strides,{3,1}),'less 118 strides')
  assert(veq(r:tolist(),{{false,true,false},{false,false,true}}),'less 118 values')
end
do -- less array 119
  local a=np.array({{{math.huge},{0.5},{11.0}},{{-0.0},{-1.0},{(0/0)}}},np.float16)
  local b=np.array({{{127,63,5,5},{1,17,17,2},{1,5,63,2}}},np.uint8)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 119 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'less 119 shape')
  assert(seqeq(r.strides,{12,4,1}),'less 119 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{true,true,true,true},{false,false,true,false}},{{true,true,true,true},{true,true,true,true},{false,false,false,false}}}),'less 119 values')
end
do -- less array 120
  local a=np.array({{5,17,5},{0,251,251}},np.uint16)
  local b=np.array({9,-31,1},np.int8)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 120 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 120 shape')
  assert(seqeq(r.strides,{3,1}),'less 120 strides')
  assert(veq(r:tolist(),{{true,false,false},{true,false,false}}),'less 120 values')
end
do -- less array 121
  local a=np.array({{2},{-1}},np.int16)
  local b=np.array({{-9.5,0.5,11.0}},np.float32)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 121 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 121 shape')
  assert(seqeq(r.strides,{3,1}),'less 121 strides')
  assert(veq(r:tolist(),{{false,false,true},{false,true,true}}),'less 121 values')
end
do -- less array 122
  local a=np.array({{-math.huge,3.75,3.75},{(0/0),3.75,-math.huge}},np.float64)
  local b=np.array({126,0,-1},np.int8)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 122 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 122 shape')
  assert(seqeq(r.strides,{3,1}),'less 122 strides')
  assert(veq(r:tolist(),{{true,false,false},{false,false,true}}),'less 122 values')
end
do -- less array 123
  local a=np.array({{63,127,1},{1,2,251}},np.uint32)
  local b=np.array({{2,1,0}},np.int32)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 123 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 123 shape')
  assert(seqeq(r.strides,{3,1}),'less 123 strides')
  assert(veq(r:tolist(),{{false,false,false},{true,false,false}}),'less 123 values')
end
do -- less array 124
  local a=np.array({{{0},{-31},{2}},{{-127},{0},{-1}}},np.int8)
  local b=np.array({{{-7,-7,1,-31},{63,-7,9,-7},{9,-1,9,1}}},np.int16)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 124 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'less 124 shape')
  assert(seqeq(r.strides,{12,4,1}),'less 124 strides')
  assert(veq(r:tolist(),{{{false,false,true,false},{true,true,true,true},{true,false,true,false}},{{true,true,true,true},{true,false,true,false},{true,false,true,true}}}),'less 124 values')
end
do -- less array 125
  local a=np.array({{0.5,-9.5,0.0},{-2.25,-9.5,-9.5}},np.float32)
  local b=np.array({-127,-7,63},np.int8)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 125 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 125 shape')
  assert(seqeq(r.strides,{3,1}),'less 125 strides')
  assert(veq(r:tolist(),{{false,true,true},{false,true,true}}),'less 125 values')
end
do -- less array 126
  local a=np.array({2,2,-127,-127,-31},np.int8)
  local b=np.array({-2.25,-2.25,(0/0),(0/0),math.huge},np.float16)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 126 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'less 126 shape')
  assert(seqeq(r.strides,{1}),'less 126 strides')
  assert(veq(r:tolist(),{false,false,false,false,true}),'less 126 values')
end
do -- less array 127
  local a=np.array({{-9.5},{3.75}},np.float64)
  local b=np.array({{5,63,17}},np.uint64)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 127 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 127 shape')
  assert(seqeq(r.strides,{3,1}),'less 127 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'less 127 values')
end
do -- less array 128
  local a=np.array({{{-1},{9},{-31}},{{9},{1},{1}}},np.int16)
  local b=np.array({{{0.0,-9.5,math.huge,11.0},{1.0,(0/0),0.5,0.0},{0.0,0.5,0.0,-math.huge}}},np.float32)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 128 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'less 128 shape')
  assert(seqeq(r.strides,{12,4,1}),'less 128 strides')
  assert(veq(r:tolist(),{{{true,false,true,true},{false,false,false,false},{true,true,true,false}},{{false,false,true,true},{false,false,false,false},{false,false,false,false}}}),'less 128 values')
end
do -- less array 129
  local a=np.array({{63,2,-127},{2,126,63}},np.int32)
  local b=np.array({{1,251,17}},np.uint16)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 129 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 129 shape')
  assert(seqeq(r.strides,{3,1}),'less 129 strides')
  assert(veq(r:tolist(),{{false,true,true},{false,true,false}}),'less 129 values')
end
do -- less array 130
  local a=np.array({{5,63,1},{2,127,5}},np.uint64)
  local b=np.array({{251,17,1}},np.uint64)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 130 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 130 shape')
  assert(seqeq(r.strides,{3,1}),'less 130 strides')
  assert(veq(r:tolist(),{{true,false,false},{true,false,false}}),'less 130 values')
end
do -- less array 131
  local a=np.array({{-1,63,-31},{-7,1,126}},np.int64)
  local b=np.array({{true,true,false}},np.bool)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 131 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 131 shape')
  assert(seqeq(r.strides,{3,1}),'less 131 strides')
  assert(veq(r:tolist(),{{true,false,true},{true,false,false}}),'less 131 values')
end
do -- less array 132
  local a=np.array({{9,-31,-1},{63,-31,9}},np.int16)
  local b=np.array({{-127,-31,-127}},np.int8)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 132 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 132 shape')
  assert(seqeq(r.strides,{3,1}),'less 132 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'less 132 values')
end
do -- less array 133
  local a=np.array({{true,false,true},{false,false,false}},np.bool)
  local b=np.array({{63,-7,-7}},np.int8)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 133 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 133 shape')
  assert(seqeq(r.strides,{3,1}),'less 133 strides')
  assert(veq(r:tolist(),{{true,false,false},{true,false,false}}),'less 133 values')
end
do -- less array 134
  local a=np.array({{1.0,1.0,-1.0},{-math.huge,0.5,-1.0}},np.float32)
  local b=np.array({{0.5,-math.huge,0.5}},np.float16)
  local r=np.less(a,b)
  assert(r.dtype=='bool','less 134 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less 134 shape')
  assert(seqeq(r.strides,{3,1}),'less 134 strides')
  assert(veq(r:tolist(),{{false,false,true},{true,false,true}}),'less 134 values')
end
do -- less_equal array 135
  local a=np.array({{{63},{5},{63}},{{2},{17},{127}}},np.uint32)
  local b=np.array({{{63,1,9,0},{0,2,126,9},{-127,126,1,-7}}},np.int64)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 135 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'less_equal 135 shape')
  assert(seqeq(r.strides,{12,4,1}),'less_equal 135 strides')
  assert(veq(r:tolist(),{{{true,false,false,false},{false,false,true,true},{false,true,false,false}},{{true,false,true,false},{false,false,true,false},{false,false,false,false}}}),'less_equal 135 values')
end
do -- less_equal array 136
  local a=np.array({{2,2,-1},{63,126,0}},np.int16)
  local b=np.array({{0,0,0}},np.int8)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 136 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 136 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 136 strides')
  assert(veq(r:tolist(),{{false,false,true},{false,false,true}}),'less_equal 136 values')
end
do -- less_equal array 137
  local a=np.array({251,0,251,1,127},np.uint64)
  local b=np.array({63,2,-7,-7,1},np.int8)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 137 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'less_equal 137 shape')
  assert(seqeq(r.strides,{1}),'less_equal 137 strides')
  assert(veq(r:tolist(),{false,true,false,false,false}),'less_equal 137 values')
end
do -- less_equal array 138
  local a=np.array({{0.5,3.75,math.huge},{-0.0,-2.25,-1.0}},np.float64)
  local b=np.array({0,63,0},np.uint64)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 138 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 138 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 138 strides')
  assert(veq(r:tolist(),{{false,true,false},{true,true,true}}),'less_equal 138 values')
end
do -- less_equal array 139
  local a=np.array({{127},{1}},np.uint16)
  local b=np.array({{11.0,0.5,1.0}},np.float64)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 139 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 139 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 139 strides')
  assert(veq(r:tolist(),{{false,false,false},{true,false,true}}),'less_equal 139 values')
end
do -- less_equal array 140
  local a=np.array({{false,true,true},{false,false,false}},np.bool)
  local b=np.array({{-127,-31,-7}},np.int64)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 140 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 140 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 140 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'less_equal 140 values')
end
do -- less_equal array 141
  local a=np.array({{math.huge,-1.0,-2.25},{math.huge,0.5,-0.0}},np.float64)
  local b=np.array({17,63,1},np.uint64)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 141 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 141 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 141 strides')
  assert(veq(r:tolist(),{{false,true,true},{false,true,true}}),'less_equal 141 values')
end
do -- less_equal array 142
  local a=np.array({{-1},{1}},np.int8)
  local b=np.array({{17,5,63}},np.uint64)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 142 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 142 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 142 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'less_equal 142 values')
end
do -- less_equal array 143
  local a=np.array({{0,17,2},{2,1,251}},np.uint16)
  local b=np.array({{-127,126,-7}},np.int32)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 143 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 143 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 143 strides')
  assert(veq(r:tolist(),{{false,true,false},{false,true,false}}),'less_equal 143 values')
end
do -- less_equal array 144
  local a=np.array({{{true},{false},{true}},{{true},{true},{true}}},np.bool)
  local b=np.array({{{-0.0,(0/0),math.huge,-1.0},{-9.5,(0/0),3.75,(0/0)},{11.0,math.huge,-2.25,-math.huge}}},np.float16)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 144 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'less_equal 144 shape')
  assert(seqeq(r.strides,{12,4,1}),'less_equal 144 strides')
  assert(veq(r:tolist(),{{{false,false,true,false},{false,false,true,false},{true,true,false,false}},{{false,false,true,false},{false,false,true,false},{true,true,false,false}}}),'less_equal 144 values')
end
do -- less_equal array 145
  local a=np.array({2,2,127,1,251},np.uint8)
  local b=np.array({63,2,9,126,126},np.int64)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 145 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'less_equal 145 shape')
  assert(seqeq(r.strides,{1}),'less_equal 145 strides')
  assert(veq(r:tolist(),{true,true,false,true,false}),'less_equal 145 values')
end
do -- less_equal array 146
  local a=np.array({{0.5},{math.huge}},np.float16)
  local b=np.array({{true,true,false}},np.bool)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 146 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 146 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 146 strides')
  assert(veq(r:tolist(),{{true,true,false},{false,false,false}}),'less_equal 146 values')
end
do -- less_equal array 147
  local a=np.array({{{-127},{9},{63}},{{2},{0},{63}}},np.int32)
  local b=np.array({{{1,2,251,17},{0,2,2,63},{0,63,127,0}}},np.uint64)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 147 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'less_equal 147 shape')
  assert(seqeq(r.strides,{12,4,1}),'less_equal 147 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{false,false,false,true},{false,true,true,false}},{{false,true,true,true},{true,true,true,true},{false,true,true,false}}}),'less_equal 147 values')
end
do -- less_equal array 148
  local a=np.array({{math.huge,0.0,math.huge},{-9.5,11.0,math.huge}},np.float32)
  local b=np.array({-31,126,9},np.int32)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 148 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 148 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 148 strides')
  assert(veq(r:tolist(),{{false,true,false},{false,true,false}}),'less_equal 148 values')
end
do -- less_equal array 149
  local a=np.array({{false,true,false},{true,false,true}},np.bool)
  local b=np.array({-9.5,0.0,0.5},np.float64)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 149 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 149 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 149 strides')
  assert(veq(r:tolist(),{{false,false,true},{false,true,false}}),'less_equal 149 values')
end
do -- less_equal array 150
  local a=np.array({1,127,1,5,17},np.uint64)
  local b=np.array({2,1,-127,126,2},np.int8)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 150 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'less_equal 150 shape')
  assert(seqeq(r.strides,{1}),'less_equal 150 strides')
  assert(veq(r:tolist(),{true,false,false,true,false}),'less_equal 150 values')
end
do -- less_equal array 151
  local a=np.array({2,-1,-127,9,-127},np.int32)
  local b=np.array({-0.0,3.75,math.huge,0.5,3.75},np.float32)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 151 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'less_equal 151 shape')
  assert(seqeq(r.strides,{1}),'less_equal 151 strides')
  assert(veq(r:tolist(),{false,true,true,false,true}),'less_equal 151 values')
end
do -- less_equal array 152
  local a=np.array({{1,126,-31},{1,-7,-1}},np.int32)
  local b=np.array({17,5,1},np.uint64)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 152 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 152 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 152 strides')
  assert(veq(r:tolist(),{{true,false,true},{true,true,true}}),'less_equal 152 values')
end
do -- less_equal array 153
  local a=np.array({false,false,true,true,true},np.bool)
  local b=np.array({-1.0,0.5,-2.25,-math.huge,(0/0)},np.float64)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 153 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'less_equal 153 shape')
  assert(seqeq(r.strides,{1}),'less_equal 153 strides')
  assert(veq(r:tolist(),{false,true,false,false,false}),'less_equal 153 values')
end
do -- less_equal array 154
  local a=np.array({{-7,126,126},{63,0,0}},np.int16)
  local b=np.array({{-0.0,0.5,-1.0}},np.float32)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 154 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 154 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 154 strides')
  assert(veq(r:tolist(),{{true,false,false},{false,true,false}}),'less_equal 154 values')
end
do -- less_equal array 155
  local a=np.array({{-2.25,-9.5,math.huge},{-2.25,11.0,11.0}},np.float16)
  local b=np.array({math.huge,math.huge,0.5},np.float32)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 155 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 155 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 155 strides')
  assert(veq(r:tolist(),{{true,true,false},{true,true,false}}),'less_equal 155 values')
end
do -- less_equal array 156
  local a=np.array({{1,251,1},{251,0,1}},np.uint64)
  local b=np.array({1,251,1},np.uint16)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 156 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 156 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 156 strides')
  assert(veq(r:tolist(),{{true,true,true},{false,true,true}}),'less_equal 156 values')
end
do -- less_equal array 157
  local a=np.array({{0.5,-2.25,0.0},{-2.25,-1.0,-math.huge}},np.float16)
  local b=np.array({{63,63,1}},np.int32)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 157 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 157 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 157 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'less_equal 157 values')
end
do -- less_equal array 158
  local a=np.array({{false,false,true},{false,true,true}},np.bool)
  local b=np.array({-127,2,-127},np.int32)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 158 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 158 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 158 strides')
  assert(veq(r:tolist(),{{false,true,false},{false,true,false}}),'less_equal 158 values')
end
do -- less_equal array 159
  local a=np.array({0.5,0.5,0.0,-1.0,-0.0},np.float16)
  local b=np.array({1.0,0.5,3.75,-2.25,11.0},np.float16)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 159 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'less_equal 159 shape')
  assert(seqeq(r.strides,{1}),'less_equal 159 strides')
  assert(veq(r:tolist(),{true,true,true,false,true}),'less_equal 159 values')
end
do -- less_equal array 160
  local a=np.array({{127,17,1},{17,5,5}},np.uint16)
  local b=np.array({{3.75,-9.5,(0/0)}},np.float64)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 160 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 160 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 160 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'less_equal 160 values')
end
do -- less_equal array 161
  local a=np.array({{0,1,2},{0,0,127}},np.uint16)
  local b=np.array({{-math.huge,-9.5,-1.0}},np.float64)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 161 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 161 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 161 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'less_equal 161 values')
end
do -- less_equal array 162
  local a=np.array({{{2},{17},{251}},{{17},{1},{5}}},np.uint32)
  local b=np.array({{{11.0,-math.huge,-9.5,0.0},{(0/0),0.5,-2.25,0.0},{0.0,-math.huge,11.0,(0/0)}}},np.float16)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 162 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'less_equal 162 shape')
  assert(seqeq(r.strides,{12,4,1}),'less_equal 162 strides')
  assert(veq(r:tolist(),{{{true,false,false,false},{false,false,false,false},{false,false,false,false}},{{false,false,false,false},{false,false,false,false},{false,false,true,false}}}),'less_equal 162 values')
end
do -- less_equal array 163
  local a=np.array({{0},{0}},np.uint32)
  local b=np.array({{251,2,2}},np.uint32)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 163 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 163 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 163 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'less_equal 163 values')
end
do -- less_equal array 164
  local a=np.array({{-31,-1,126},{9,-127,2}},np.int16)
  local b=np.array({{17,2,0}},np.uint32)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 164 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 164 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 164 strides')
  assert(veq(r:tolist(),{{true,true,false},{true,true,false}}),'less_equal 164 values')
end
do -- less_equal array 165
  local a=np.array({{{math.huge},{1.0},{-0.0}},{{-9.5},{0.0},{-9.5}}},np.float64)
  local b=np.array({{{1,-1,-31,-31},{63,9,0,126},{1,1,-127,9}}},np.int32)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 165 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'less_equal 165 shape')
  assert(seqeq(r.strides,{12,4,1}),'less_equal 165 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{true,true,false,true},{true,true,false,true}},{{true,true,false,false},{true,true,true,true},{true,true,false,true}}}),'less_equal 165 values')
end
do -- less_equal array 166
  local a=np.array({{{-127},{-7},{2}},{{2},{-7},{1}}},np.int8)
  local b=np.array({{{0.5,0.0,11.0,11.0},{3.75,(0/0),0.0,(0/0)},{-0.0,11.0,11.0,-2.25}}},np.float64)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 166 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'less_equal 166 shape')
  assert(seqeq(r.strides,{12,4,1}),'less_equal 166 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,false,true,false},{false,true,true,false}},{{false,false,true,true},{true,false,true,false},{false,true,true,false}}}),'less_equal 166 values')
end
do -- less_equal array 167
  local a=np.array({{0,2,63},{-7,-7,-127}},np.int8)
  local b=np.array({1.0,-0.0,(0/0)},np.float16)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 167 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 167 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 167 strides')
  assert(veq(r:tolist(),{{true,false,false},{true,true,false}}),'less_equal 167 values')
end
do -- less_equal array 168
  local a=np.array({{{-0.0},{3.75},{(0/0)}},{{3.75},{1.0},{0.0}}},np.float32)
  local b=np.array({{{2,127,5,0},{17,2,0,0},{5,63,251,127}}},np.uint16)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 168 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'less_equal 168 shape')
  assert(seqeq(r.strides,{12,4,1}),'less_equal 168 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,false,false,false},{false,false,false,false}},{{false,true,true,false},{true,true,false,false},{true,true,true,true}}}),'less_equal 168 values')
end
do -- less_equal array 169
  local a=np.array({-1,63,-127,-1,2},np.int8)
  local b=np.array({126,126,-127,2,-31},np.int32)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 169 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'less_equal 169 shape')
  assert(seqeq(r.strides,{1}),'less_equal 169 strides')
  assert(veq(r:tolist(),{true,true,true,true,false}),'less_equal 169 values')
end
do -- less_equal array 170
  local a=np.array({{{0},{2},{5}},{{127},{17},{63}}},np.uint32)
  local b=np.array({{{0,2,2,63},{251,5,63,251},{127,63,1,17}}},np.uint64)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 170 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'less_equal 170 shape')
  assert(seqeq(r.strides,{12,4,1}),'less_equal 170 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,true,true,true},{true,true,false,true}},{{false,false,false,false},{true,false,true,true},{true,true,false,false}}}),'less_equal 170 values')
end
do -- less_equal array 171
  local a=np.array({{251},{63}},np.uint32)
  local b=np.array({{-127,126,-7}},np.int32)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 171 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 171 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 171 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,true,false}}),'less_equal 171 values')
end
do -- less_equal array 172
  local a=np.array({1,1,126,9,2},np.int8)
  local b=np.array({math.huge,(0/0),1.0,3.75,3.75},np.float64)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 172 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'less_equal 172 shape')
  assert(seqeq(r.strides,{1}),'less_equal 172 strides')
  assert(veq(r:tolist(),{true,false,false,false,true}),'less_equal 172 values')
end
do -- less_equal array 173
  local a=np.array({{63,17,63},{127,2,251}},np.uint8)
  local b=np.array({math.huge,(0/0),(0/0)},np.float16)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 173 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 173 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 173 strides')
  assert(veq(r:tolist(),{{true,false,false},{true,false,false}}),'less_equal 173 values')
end
do -- less_equal array 174
  local a=np.array({{1},{126}},np.int8)
  local b=np.array({{251,2,0}},np.uint8)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 174 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 174 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 174 strides')
  assert(veq(r:tolist(),{{true,true,false},{true,false,false}}),'less_equal 174 values')
end
do -- less_equal array 175
  local a=np.array({{(0/0)},{(0/0)}},np.float16)
  local b=np.array({{0,0,1}},np.uint16)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 175 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 175 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 175 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'less_equal 175 values')
end
do -- less_equal array 176
  local a=np.array({{(0/0),-math.huge,11.0},{-2.25,0.0,(0/0)}},np.float32)
  local b=np.array({{1,1,1}},np.int16)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 176 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 176 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 176 strides')
  assert(veq(r:tolist(),{{false,true,false},{true,true,false}}),'less_equal 176 values')
end
do -- less_equal array 177
  local a=np.array({{3.75},{0.5}},np.float16)
  local b=np.array({{17,5,5}},np.uint16)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 177 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 177 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 177 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'less_equal 177 values')
end
do -- less_equal array 178
  local a=np.array({{1,-31,-7},{-127,-127,-31}},np.int32)
  local b=np.array({2,9,-1},np.int64)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 178 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 178 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 178 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'less_equal 178 values')
end
do -- less_equal array 179
  local a=np.array({{17,251,5},{17,17,5}},np.uint16)
  local b=np.array({2,5,1},np.uint16)
  local r=np.less_equal(a,b)
  assert(r.dtype=='bool','less_equal 179 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'less_equal 179 shape')
  assert(seqeq(r.strides,{3,1}),'less_equal 179 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'less_equal 179 values')
end
do -- greater array 180
  local a=np.array({{-31,126,2},{-127,2,9}},np.int32)
  local b=np.array({{5,63,63}},np.uint32)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 180 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater 180 shape')
  assert(seqeq(r.strides,{3,1}),'greater 180 strides')
  assert(veq(r:tolist(),{{false,true,false},{false,false,false}}),'greater 180 values')
end
do -- greater array 181
  local a=np.array({{1,127,63},{63,5,17}},np.uint16)
  local b=np.array({{63,-127,9}},np.int16)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 181 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater 181 shape')
  assert(seqeq(r.strides,{3,1}),'greater 181 strides')
  assert(veq(r:tolist(),{{false,true,true},{false,true,true}}),'greater 181 values')
end
do -- greater array 182
  local a=np.array({{false},{true}},np.bool)
  local b=np.array({{0.0,-9.5,0.5}},np.float16)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 182 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater 182 shape')
  assert(seqeq(r.strides,{3,1}),'greater 182 strides')
  assert(veq(r:tolist(),{{false,true,false},{true,true,true}}),'greater 182 values')
end
do -- greater array 183
  local a=np.array({5,1,127,127,2},np.uint32)
  local b=np.array({-1,1,9,-31,0},np.int16)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 183 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater 183 shape')
  assert(seqeq(r.strides,{1}),'greater 183 strides')
  assert(veq(r:tolist(),{true,false,true,true,true}),'greater 183 values')
end
do -- greater array 184
  local a=np.array({{1,-7,126},{1,9,63}},np.int32)
  local b=np.array({1,2,2},np.uint32)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 184 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater 184 shape')
  assert(seqeq(r.strides,{3,1}),'greater 184 strides')
  assert(veq(r:tolist(),{{false,false,true},{false,true,true}}),'greater 184 values')
end
do -- greater array 185
  local a=np.array({5,63,63,17,127},np.uint8)
  local b=np.array({63,-127,-7,2,-31},np.int64)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 185 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater 185 shape')
  assert(seqeq(r.strides,{1}),'greater 185 strides')
  assert(veq(r:tolist(),{false,true,true,true,true}),'greater 185 values')
end
do -- greater array 186
  local a=np.array({{1},{2}},np.int64)
  local b=np.array({{1,0,63}},np.uint64)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 186 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater 186 shape')
  assert(seqeq(r.strides,{3,1}),'greater 186 strides')
  assert(veq(r:tolist(),{{false,true,false},{true,true,false}}),'greater 186 values')
end
do -- greater array 187
  local a=np.array({{{-1.0},{-0.0},{math.huge}},{{0.0},{-2.25},{-0.0}}},np.float64)
  local b=np.array({{{9,-127,2,-31},{1,-127,63,-31},{63,126,1,9}}},np.int32)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 187 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'greater 187 shape')
  assert(seqeq(r.strides,{12,4,1}),'greater 187 strides')
  assert(veq(r:tolist(),{{{false,true,false,true},{false,true,false,true},{true,true,true,true}},{{false,true,false,true},{false,true,false,true},{false,false,false,false}}}),'greater 187 values')
end
do -- greater array 188
  local a=np.array({{11.0},{(0/0)}},np.float16)
  local b=np.array({{-1,-1,2}},np.int8)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 188 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater 188 shape')
  assert(seqeq(r.strides,{3,1}),'greater 188 strides')
  assert(veq(r:tolist(),{{true,true,true},{false,false,false}}),'greater 188 values')
end
do -- greater array 189
  local a=np.array({{{2},{17},{63}},{{2},{63},{5}}},np.uint32)
  local b=np.array({{{2,-7,-7,9},{-7,-31,-127,126},{0,-31,-31,-31}}},np.int32)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 189 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'greater 189 shape')
  assert(seqeq(r.strides,{12,4,1}),'greater 189 strides')
  assert(veq(r:tolist(),{{{false,true,true,false},{true,true,true,false},{true,true,true,true}},{{false,true,true,false},{true,true,true,false},{true,true,true,true}}}),'greater 189 values')
end
do -- greater array 190
  local a=np.array({{0,2,5},{5,251,5}},np.uint16)
  local b=np.array({(0/0),11.0,math.huge},np.float32)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 190 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater 190 shape')
  assert(seqeq(r.strides,{3,1}),'greater 190 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,true,false}}),'greater 190 values')
end
do -- greater array 191
  local a=np.array({{{63},{2},{251}},{{0},{17},{5}}},np.uint16)
  local b=np.array({{{11.0,1.0,-0.0,1.0},{-9.5,-2.25,3.75,0.0},{-math.huge,11.0,3.75,-2.25}}},np.float16)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 191 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'greater 191 shape')
  assert(seqeq(r.strides,{12,4,1}),'greater 191 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,true,false,true},{true,true,true,true}},{{false,false,false,false},{true,true,true,true},{true,false,true,true}}}),'greater 191 values')
end
do -- greater array 192
  local a=np.array({{5,127,2},{2,63,63}},np.uint16)
  local b=np.array({{2,9,0}},np.int8)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 192 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater 192 shape')
  assert(seqeq(r.strides,{3,1}),'greater 192 strides')
  assert(veq(r:tolist(),{{true,true,true},{false,true,true}}),'greater 192 values')
end
do -- greater array 193
  local a=np.array({{{0},{251},{0}},{{0},{1},{251}}},np.uint8)
  local b=np.array({{{1,1,-7,-7},{63,0,2,-31},{-31,-31,-31,1}}},np.int64)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 193 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'greater 193 shape')
  assert(seqeq(r.strides,{12,4,1}),'greater 193 strides')
  assert(veq(r:tolist(),{{{false,false,true,true},{true,true,true,true},{true,true,true,false}},{{false,false,true,true},{false,true,false,true},{true,true,true,true}}}),'greater 193 values')
end
do -- greater array 194
  local a=np.array({{{63},{127},{2}},{{1},{63},{2}}},np.uint16)
  local b=np.array({{{2,251,5,5},{127,1,0,63},{63,63,0,17}}},np.uint32)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 194 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'greater 194 shape')
  assert(seqeq(r.strides,{12,4,1}),'greater 194 strides')
  assert(veq(r:tolist(),{{{true,false,true,true},{false,true,true,true},{false,false,true,false}},{{false,false,false,false},{false,true,true,false},{false,false,true,false}}}),'greater 194 values')
end
do -- greater array 195
  local a=np.array({false,false,false,false,true},np.bool)
  local b=np.array({true,false,true,true,false},np.bool)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 195 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater 195 shape')
  assert(seqeq(r.strides,{1}),'greater 195 strides')
  assert(veq(r:tolist(),{false,false,false,false,true}),'greater 195 values')
end
do -- greater array 196
  local a=np.array({1,5,17,127,63},np.uint8)
  local b=np.array({0.0,math.huge,0.0,-1.0,3.75},np.float32)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 196 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater 196 shape')
  assert(seqeq(r.strides,{1}),'greater 196 strides')
  assert(veq(r:tolist(),{true,false,true,true,true}),'greater 196 values')
end
do -- greater array 197
  local a=np.array({{{11.0},{-0.0},{-9.5}},{{1.0},{math.huge},{-0.0}}},np.float32)
  local b=np.array({{{true,false,false,true},{true,false,false,false},{false,false,true,true}}},np.bool)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 197 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'greater 197 shape')
  assert(seqeq(r.strides,{12,4,1}),'greater 197 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{false,false,false,false},{false,false,false,false}},{{false,true,true,false},{true,true,true,true},{false,false,false,false}}}),'greater 197 values')
end
do -- greater array 198
  local a=np.array({{{0},{63},{5}},{{251},{0},{1}}},np.uint64)
  local b=np.array({{{63,9,1,126},{126,-31,-127,63},{63,1,-1,-127}}},np.int64)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 198 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'greater 198 shape')
  assert(seqeq(r.strides,{12,4,1}),'greater 198 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,true,true,false},{false,true,true,true}},{{true,true,true,true},{false,true,true,false},{false,false,true,true}}}),'greater 198 values')
end
do -- greater array 199
  local a=np.array({{-127,-7,-127},{-1,63,0}},np.int16)
  local b=np.array({{2,63,63}},np.int16)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 199 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater 199 shape')
  assert(seqeq(r.strides,{3,1}),'greater 199 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'greater 199 values')
end
do -- greater array 200
  local a=np.array({{{251},{0},{5}},{{127},{17},{2}}},np.uint64)
  local b=np.array({{{-7,2,9,-7},{-7,9,-31,2},{-127,126,-127,1}}},np.int8)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 200 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'greater 200 shape')
  assert(seqeq(r.strides,{12,4,1}),'greater 200 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,false,true,false},{true,false,true,true}},{{true,true,true,true},{true,true,true,true},{true,false,true,true}}}),'greater 200 values')
end
do -- greater array 201
  local a=np.array({-31,1,1,1,2},np.int16)
  local b=np.array({-math.huge,-1.0,math.huge,0.5,1.0},np.float64)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 201 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater 201 shape')
  assert(seqeq(r.strides,{1}),'greater 201 strides')
  assert(veq(r:tolist(),{true,true,false,true,true}),'greater 201 values')
end
do -- greater array 202
  local a=np.array({{-1},{1}},np.int16)
  local b=np.array({{math.huge,1.0,-0.0}},np.float16)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 202 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater 202 shape')
  assert(seqeq(r.strides,{3,1}),'greater 202 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,true}}),'greater 202 values')
end
do -- greater array 203
  local a=np.array({{true},{true}},np.bool)
  local b=np.array({{0,17,1}},np.uint64)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 203 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater 203 shape')
  assert(seqeq(r.strides,{3,1}),'greater 203 strides')
  assert(veq(r:tolist(),{{true,false,false},{true,false,false}}),'greater 203 values')
end
do -- greater array 204
  local a=np.array({{2,63,0},{-1,9,0}},np.int32)
  local b=np.array({-0.0,0.0,(0/0)},np.float32)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 204 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater 204 shape')
  assert(seqeq(r.strides,{3,1}),'greater 204 strides')
  assert(veq(r:tolist(),{{true,true,false},{false,true,false}}),'greater 204 values')
end
do -- greater array 205
  local a=np.array({3.75,math.huge,math.huge,-math.huge,-math.huge},np.float16)
  local b=np.array({-0.0,-1.0,-math.huge,0.0,0.0},np.float64)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 205 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater 205 shape')
  assert(seqeq(r.strides,{1}),'greater 205 strides')
  assert(veq(r:tolist(),{true,true,true,false,false}),'greater 205 values')
end
do -- greater array 206
  local a=np.array({63,0,2,63,126},np.int16)
  local b=np.array({251,63,127,1,63},np.uint8)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 206 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater 206 shape')
  assert(seqeq(r.strides,{1}),'greater 206 strides')
  assert(veq(r:tolist(),{false,false,false,true,true}),'greater 206 values')
end
do -- greater array 207
  local a=np.array({{{-7},{9},{63}},{{-1},{9},{63}}},np.int32)
  local b=np.array({{{0.0,(0/0),-1.0,0.5},{11.0,-math.huge,-math.huge,-2.25},{0.5,11.0,math.huge,3.75}}},np.float32)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 207 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'greater 207 shape')
  assert(seqeq(r.strides,{12,4,1}),'greater 207 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,true,true,true},{true,true,false,true}},{{false,false,false,false},{false,true,true,true},{true,true,false,true}}}),'greater 207 values')
end
do -- greater array 208
  local a=np.array({{9,-7,-31},{-1,9,126}},np.int16)
  local b=np.array({0,5,0},np.uint32)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 208 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater 208 shape')
  assert(seqeq(r.strides,{3,1}),'greater 208 strides')
  assert(veq(r:tolist(),{{true,false,false},{false,true,true}}),'greater 208 values')
end
do -- greater array 209
  local a=np.array({false,true,true,false,true},np.bool)
  local b=np.array({-31,-1,-127,-7,1},np.int32)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 209 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater 209 shape')
  assert(seqeq(r.strides,{1}),'greater 209 strides')
  assert(veq(r:tolist(),{true,true,true,true,false}),'greater 209 values')
end
do -- greater array 210
  local a=np.array({{1.0},{3.75}},np.float16)
  local b=np.array({{-1.0,-0.0,0.0}},np.float32)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 210 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater 210 shape')
  assert(seqeq(r.strides,{3,1}),'greater 210 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'greater 210 values')
end
do -- greater array 211
  local a=np.array({{0,1,63},{2,17,127}},np.uint64)
  local b=np.array({{false,false,true}},np.bool)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 211 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater 211 shape')
  assert(seqeq(r.strides,{3,1}),'greater 211 strides')
  assert(veq(r:tolist(),{{false,true,true},{true,true,true}}),'greater 211 values')
end
do -- greater array 212
  local a=np.array({{{math.huge},{-0.0},{1.0}},{{3.75},{(0/0)},{-0.0}}},np.float64)
  local b=np.array({{{false,true,false,false},{false,true,true,true},{true,false,false,false}}},np.bool)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 212 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'greater 212 shape')
  assert(seqeq(r.strides,{12,4,1}),'greater 212 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{false,false,false,false},{false,true,true,true}},{{true,true,true,true},{false,false,false,false},{false,false,false,false}}}),'greater 212 values')
end
do -- greater array 213
  local a=np.array({{17,17,2},{5,17,127}},np.uint32)
  local b=np.array({{9,-7,9}},np.int8)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 213 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater 213 shape')
  assert(seqeq(r.strides,{3,1}),'greater 213 strides')
  assert(veq(r:tolist(),{{true,true,false},{false,true,true}}),'greater 213 values')
end
do -- greater array 214
  local a=np.array({{-9.5,math.huge,math.huge},{1.0,(0/0),-9.5}},np.float32)
  local b=np.array({true,true,false},np.bool)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 214 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater 214 shape')
  assert(seqeq(r.strides,{3,1}),'greater 214 strides')
  assert(veq(r:tolist(),{{false,true,true},{false,false,false}}),'greater 214 values')
end
do -- greater array 215
  local a=np.array({5,1,251,17,1},np.uint64)
  local b=np.array({true,true,true,false,false},np.bool)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 215 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater 215 shape')
  assert(seqeq(r.strides,{1}),'greater 215 strides')
  assert(veq(r:tolist(),{true,false,true,true,true}),'greater 215 values')
end
do -- greater array 216
  local a=np.array({-127,9,2,-127,63},np.int32)
  local b=np.array({0.0,-9.5,-1.0,11.0,math.huge},np.float32)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 216 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater 216 shape')
  assert(seqeq(r.strides,{1}),'greater 216 strides')
  assert(veq(r:tolist(),{false,true,true,false,false}),'greater 216 values')
end
do -- greater array 217
  local a=np.array({{{251},{127},{127}},{{17},{5},{17}}},np.uint8)
  local b=np.array({{{3.75,math.huge,-2.25,3.75},{-1.0,3.75,-math.huge,-math.huge},{math.huge,-9.5,-9.5,11.0}}},np.float64)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 217 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'greater 217 shape')
  assert(seqeq(r.strides,{12,4,1}),'greater 217 strides')
  assert(veq(r:tolist(),{{{true,false,true,true},{true,true,true,true},{false,true,true,true}},{{true,false,true,true},{true,true,true,true},{false,true,true,true}}}),'greater 217 values')
end
do -- greater array 218
  local a=np.array({{{-7},{0},{0}},{{1},{-31},{9}}},np.int64)
  local b=np.array({{{-1.0,-9.5,3.75,-9.5},{-2.25,-0.0,(0/0),-1.0},{3.75,-math.huge,math.huge,-0.0}}},np.float16)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 218 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'greater 218 shape')
  assert(seqeq(r.strides,{12,4,1}),'greater 218 strides')
  assert(veq(r:tolist(),{{{false,true,false,true},{true,false,false,true},{false,true,false,false}},{{true,true,false,true},{false,false,false,false},{true,true,false,true}}}),'greater 218 values')
end
do -- greater array 219
  local a=np.array({{-127,0,126},{-127,-7,9}},np.int8)
  local b=np.array({1,0,251},np.uint8)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 219 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater 219 shape')
  assert(seqeq(r.strides,{3,1}),'greater 219 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'greater 219 values')
end
do -- greater array 220
  local a=np.array({251,63,5,1,127},np.uint32)
  local b=np.array({1,1,0,17,5},np.uint32)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 220 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater 220 shape')
  assert(seqeq(r.strides,{1}),'greater 220 strides')
  assert(veq(r:tolist(),{true,true,true,false,true}),'greater 220 values')
end
do -- greater array 221
  local a=np.array({{-2.25},{-0.0}},np.float64)
  local b=np.array({{-9.5,11.0,-2.25}},np.float32)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 221 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater 221 shape')
  assert(seqeq(r.strides,{3,1}),'greater 221 strides')
  assert(veq(r:tolist(),{{true,false,false},{true,false,true}}),'greater 221 values')
end
do -- greater array 222
  local a=np.array({true,true,true,false,false},np.bool)
  local b=np.array({-1,63,-31,63,1},np.int8)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 222 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater 222 shape')
  assert(seqeq(r.strides,{1}),'greater 222 strides')
  assert(veq(r:tolist(),{true,false,true,false,false}),'greater 222 values')
end
do -- greater array 223
  local a=np.array({{17,17,17},{5,5,127}},np.uint16)
  local b=np.array({true,true,false},np.bool)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 223 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater 223 shape')
  assert(seqeq(r.strides,{3,1}),'greater 223 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'greater 223 values')
end
do -- greater array 224
  local a=np.array({9,-31,-7,-7,0},np.int16)
  local b=np.array({17,1,63,1,0},np.uint64)
  local r=np.greater(a,b)
  assert(r.dtype=='bool','greater 224 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater 224 shape')
  assert(seqeq(r.strides,{1}),'greater 224 strides')
  assert(veq(r:tolist(),{false,false,false,false,false}),'greater 224 values')
end
do -- greater_equal array 225
  local a=np.array({{5,2,251},{127,5,63}},np.uint16)
  local b=np.array({{0,251,1}},np.uint8)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 225 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 225 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 225 strides')
  assert(veq(r:tolist(),{{true,false,true},{true,false,true}}),'greater_equal 225 values')
end
do -- greater_equal array 226
  local a=np.array({{{-7},{-7},{-7}},{{0},{-31},{-1}}},np.int32)
  local b=np.array({{{3.75,math.huge,0.0,1.0},{-9.5,-2.25,1.0,0.5},{-math.huge,11.0,1.0,11.0}}},np.float16)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 226 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'greater_equal 226 shape')
  assert(seqeq(r.strides,{12,4,1}),'greater_equal 226 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{true,false,false,false},{true,false,false,false}},{{false,false,true,false},{false,false,false,false},{true,false,false,false}}}),'greater_equal 226 values')
end
do -- greater_equal array 227
  local a=np.array({{0.5,1.0,11.0},{math.huge,11.0,math.huge}},np.float32)
  local b=np.array({5,1,1},np.uint32)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 227 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 227 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 227 strides')
  assert(veq(r:tolist(),{{false,true,true},{true,true,true}}),'greater_equal 227 values')
end
do -- greater_equal array 228
  local a=np.array({{11.0},{-math.huge}},np.float32)
  local b=np.array({{127,1,5}},np.uint64)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 228 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 228 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 228 strides')
  assert(veq(r:tolist(),{{false,true,true},{false,false,false}}),'greater_equal 228 values')
end
do -- greater_equal array 229
  local a=np.array({{11.0,(0/0),-math.huge},{-1.0,-1.0,math.huge}},np.float32)
  local b=np.array({-1.0,3.75,math.huge},np.float32)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 229 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 229 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 229 strides')
  assert(veq(r:tolist(),{{true,false,false},{true,false,true}}),'greater_equal 229 values')
end
do -- greater_equal array 230
  local a=np.array({{-127},{126}},np.int16)
  local b=np.array({{-9.5,math.huge,11.0}},np.float16)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 230 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 230 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 230 strides')
  assert(veq(r:tolist(),{{false,false,false},{true,false,true}}),'greater_equal 230 values')
end
do -- greater_equal array 231
  local a=np.array({{-0.0},{-9.5}},np.float16)
  local b=np.array({{11.0,11.0,(0/0)}},np.float64)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 231 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 231 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 231 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'greater_equal 231 values')
end
do -- greater_equal array 232
  local a=np.array({{63,63,1},{2,5,5}},np.uint32)
  local b=np.array({-7,9,9},np.int16)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 232 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 232 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 232 strides')
  assert(veq(r:tolist(),{{true,true,false},{true,false,false}}),'greater_equal 232 values')
end
do -- greater_equal array 233
  local a=np.array({{251},{5}},np.uint8)
  local b=np.array({{-1,-7,126}},np.int8)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 233 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 233 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 233 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,false}}),'greater_equal 233 values')
end
do -- greater_equal array 234
  local a=np.array({{-math.huge},{math.huge}},np.float32)
  local b=np.array({{-31,-127,63}},np.int64)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 234 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 234 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 234 strides')
  assert(veq(r:tolist(),{{false,false,false},{true,true,true}}),'greater_equal 234 values')
end
do -- greater_equal array 235
  local a=np.array({{{127},{5},{5}},{{63},{5},{127}}},np.uint64)
  local b=np.array({{{251,5,1,127},{0,127,127,127},{17,2,127,63}}},np.uint16)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 235 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'greater_equal 235 shape')
  assert(seqeq(r.strides,{12,4,1}),'greater_equal 235 strides')
  assert(veq(r:tolist(),{{{false,true,true,true},{true,false,false,false},{false,true,false,false}},{{false,true,true,false},{true,false,false,false},{true,true,true,true}}}),'greater_equal 235 values')
end
do -- greater_equal array 236
  local a=np.array({{126,63,-127},{63,9,126}},np.int64)
  local b=np.array({-7,-7,-7},np.int64)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 236 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 236 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 236 strides')
  assert(veq(r:tolist(),{{true,true,false},{true,true,true}}),'greater_equal 236 values')
end
do -- greater_equal array 237
  local a=np.array({{2},{127}},np.uint8)
  local b=np.array({{17,1,1}},np.uint64)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 237 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 237 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 237 strides')
  assert(veq(r:tolist(),{{false,true,true},{true,true,true}}),'greater_equal 237 values')
end
do -- greater_equal array 238
  local a=np.array({{false},{true}},np.bool)
  local b=np.array({{17,251,63}},np.uint64)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 238 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 238 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 238 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'greater_equal 238 values')
end
do -- greater_equal array 239
  local a=np.array({{false},{true}},np.bool)
  local b=np.array({{1,0,-1}},np.int32)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 239 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 239 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 239 strides')
  assert(veq(r:tolist(),{{false,true,true},{true,true,true}}),'greater_equal 239 values')
end
do -- greater_equal array 240
  local a=np.array({{-9.5,-1.0,3.75},{1.0,-9.5,-9.5}},np.float16)
  local b=np.array({17,63,2},np.uint64)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 240 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 240 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 240 strides')
  assert(veq(r:tolist(),{{false,false,true},{false,false,false}}),'greater_equal 240 values')
end
do -- greater_equal array 241
  local a=np.array({{126,63,9},{-7,-31,-127}},np.int8)
  local b=np.array({{5,127,0}},np.uint32)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 241 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 241 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 241 strides')
  assert(veq(r:tolist(),{{true,false,true},{false,false,false}}),'greater_equal 241 values')
end
do -- greater_equal array 242
  local a=np.array({{{17},{1},{127}},{{63},{1},{2}}},np.uint64)
  local b=np.array({{{-127,-1,0,63},{-1,-31,-31,1},{9,126,9,-7}}},np.int16)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 242 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'greater_equal 242 shape')
  assert(seqeq(r.strides,{12,4,1}),'greater_equal 242 strides')
  assert(veq(r:tolist(),{{{true,true,true,false},{true,true,true,true},{true,true,true,true}},{{true,true,true,true},{true,true,true,true},{false,false,false,true}}}),'greater_equal 242 values')
end
do -- greater_equal array 243
  local a=np.array({{-2.25,-1.0,(0/0)},{0.5,-0.0,-1.0}},np.float16)
  local b=np.array({-31,2,-31},np.int8)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 243 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 243 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 243 strides')
  assert(veq(r:tolist(),{{true,false,false},{true,false,true}}),'greater_equal 243 values')
end
do -- greater_equal array 244
  local a=np.array({-9.5,-0.0,0.5,-0.0,0.5},np.float16)
  local b=np.array({63,251,63,251,63},np.uint32)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 244 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater_equal 244 shape')
  assert(seqeq(r.strides,{1}),'greater_equal 244 strides')
  assert(veq(r:tolist(),{false,false,false,false,false}),'greater_equal 244 values')
end
do -- greater_equal array 245
  local a=np.array({{{9},{-31},{-31}},{{-31},{-7},{-7}}},np.int16)
  local b=np.array({{{251,251,0,0},{0,127,0,1},{17,251,0,127}}},np.uint8)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 245 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'greater_equal 245 shape')
  assert(seqeq(r.strides,{12,4,1}),'greater_equal 245 strides')
  assert(veq(r:tolist(),{{{false,false,true,true},{false,false,false,false},{false,false,false,false}},{{false,false,false,false},{false,false,false,false},{false,false,false,false}}}),'greater_equal 245 values')
end
do -- greater_equal array 246
  local a=np.array({-31,0,-1,2,-1},np.int32)
  local b=np.array({1,63,5,17,127},np.uint32)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 246 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater_equal 246 shape')
  assert(seqeq(r.strides,{1}),'greater_equal 246 strides')
  assert(veq(r:tolist(),{false,false,false,false,false}),'greater_equal 246 values')
end
do -- greater_equal array 247
  local a=np.array({1,0,5,63,0},np.uint16)
  local b=np.array({math.huge,11.0,1.0,0.0,0.5},np.float16)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 247 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater_equal 247 shape')
  assert(seqeq(r.strides,{1}),'greater_equal 247 strides')
  assert(veq(r:tolist(),{false,false,true,true,false}),'greater_equal 247 values')
end
do -- greater_equal array 248
  local a=np.array({{math.huge},{-9.5}},np.float64)
  local b=np.array({{5,5,17}},np.uint64)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 248 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 248 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 248 strides')
  assert(veq(r:tolist(),{{true,true,true},{false,false,false}}),'greater_equal 248 values')
end
do -- greater_equal array 249
  local a=np.array({-31,-1,2,0,9},np.int64)
  local b=np.array({5,63,5,17,251},np.uint16)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 249 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater_equal 249 shape')
  assert(seqeq(r.strides,{1}),'greater_equal 249 strides')
  assert(veq(r:tolist(),{false,false,false,false,false}),'greater_equal 249 values')
end
do -- greater_equal array 250
  local a=np.array({{0,1,63},{63,1,126}},np.int32)
  local b=np.array({{0,2,9}},np.int64)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 250 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 250 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 250 strides')
  assert(veq(r:tolist(),{{true,false,true},{true,false,true}}),'greater_equal 250 values')
end
do -- greater_equal array 251
  local a=np.array({{63,2,-31},{-7,63,63}},np.int64)
  local b=np.array({{true,false,false}},np.bool)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 251 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 251 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 251 strides')
  assert(veq(r:tolist(),{{true,true,false},{false,true,true}}),'greater_equal 251 values')
end
do -- greater_equal array 252
  local a=np.array({-7,-7,63,2,2},np.int64)
  local b=np.array({false,true,true,false,false},np.bool)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 252 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater_equal 252 shape')
  assert(seqeq(r.strides,{1}),'greater_equal 252 strides')
  assert(veq(r:tolist(),{false,false,true,true,true}),'greater_equal 252 values')
end
do -- greater_equal array 253
  local a=np.array({{{11.0},{-9.5},{-0.0}},{{0.5},{1.0},{-2.25}}},np.float32)
  local b=np.array({{{-7,-31,-7,2},{9,-1,63,0},{-127,-127,2,2}}},np.int16)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 253 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'greater_equal 253 shape')
  assert(seqeq(r.strides,{12,4,1}),'greater_equal 253 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{false,false,false,false},{true,true,false,false}},{{true,true,true,false},{false,true,false,true},{true,true,false,false}}}),'greater_equal 253 values')
end
do -- greater_equal array 254
  local a=np.array({5,0,17,17,17},np.uint64)
  local b=np.array({-0.0,-1.0,math.huge,-9.5,1.0},np.float64)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 254 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater_equal 254 shape')
  assert(seqeq(r.strides,{1}),'greater_equal 254 strides')
  assert(veq(r:tolist(),{true,true,false,true,true}),'greater_equal 254 values')
end
do -- greater_equal array 255
  local a=np.array({-7,-7,-127,-1,-7},np.int16)
  local b=np.array({63,63,2,126,9},np.int32)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 255 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater_equal 255 shape')
  assert(seqeq(r.strides,{1}),'greater_equal 255 strides')
  assert(veq(r:tolist(),{false,false,false,false,false}),'greater_equal 255 values')
end
do -- greater_equal array 256
  local a=np.array({2,-7,-127,0,-1},np.int64)
  local b=np.array({-7,-31,-127,1,-7},np.int64)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 256 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater_equal 256 shape')
  assert(seqeq(r.strides,{1}),'greater_equal 256 strides')
  assert(veq(r:tolist(),{true,true,true,false,true}),'greater_equal 256 values')
end
do -- greater_equal array 257
  local a=np.array({{17},{2}},np.uint32)
  local b=np.array({{127,0,63}},np.uint64)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 257 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 257 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 257 strides')
  assert(veq(r:tolist(),{{false,true,false},{false,true,false}}),'greater_equal 257 values')
end
do -- greater_equal array 258
  local a=np.array({{11.0},{(0/0)}},np.float32)
  local b=np.array({{2,-31,-1}},np.int16)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 258 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 258 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 258 strides')
  assert(veq(r:tolist(),{{true,true,true},{false,false,false}}),'greater_equal 258 values')
end
do -- greater_equal array 259
  local a=np.array({{63,5,0},{17,2,0}},np.uint64)
  local b=np.array({{0,63,63}},np.uint64)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 259 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 259 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 259 strides')
  assert(veq(r:tolist(),{{true,false,false},{true,false,false}}),'greater_equal 259 values')
end
do -- greater_equal array 260
  local a=np.array({{(0/0)},{-9.5}},np.float64)
  local b=np.array({{0,-127,0}},np.int16)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 260 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 260 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 260 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,true,false}}),'greater_equal 260 values')
end
do -- greater_equal array 261
  local a=np.array({{127,251,1},{0,17,63}},np.uint16)
  local b=np.array({-127,0,1},np.int16)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 261 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 261 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 261 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'greater_equal 261 values')
end
do -- greater_equal array 262
  local a=np.array({{{false},{true},{true}},{{true},{true},{false}}},np.bool)
  local b=np.array({{{1,-31,126,-31},{-1,126,126,2},{126,-127,1,-127}}},np.int16)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 262 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'greater_equal 262 shape')
  assert(seqeq(r.strides,{12,4,1}),'greater_equal 262 strides')
  assert(veq(r:tolist(),{{{false,true,false,true},{true,false,false,false},{false,true,true,true}},{{true,true,false,true},{true,false,false,false},{false,true,false,true}}}),'greater_equal 262 values')
end
do -- greater_equal array 263
  local a=np.array({{-1.0},{(0/0)}},np.float32)
  local b=np.array({{math.huge,-2.25,11.0}},np.float32)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 263 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 263 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 263 strides')
  assert(veq(r:tolist(),{{false,true,false},{false,false,false}}),'greater_equal 263 values')
end
do -- greater_equal array 264
  local a=np.array({9,126,-1,9,-127},np.int8)
  local b=np.array({1,5,2,17,63},np.uint8)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 264 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater_equal 264 shape')
  assert(seqeq(r.strides,{1}),'greater_equal 264 strides')
  assert(veq(r:tolist(),{true,true,false,false,false}),'greater_equal 264 values')
end
do -- greater_equal array 265
  local a=np.array({251,2,1,17,0},np.uint64)
  local b=np.array({126,-7,-31,-127,63},np.int64)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 265 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater_equal 265 shape')
  assert(seqeq(r.strides,{1}),'greater_equal 265 strides')
  assert(veq(r:tolist(),{true,true,true,true,false}),'greater_equal 265 values')
end
do -- greater_equal array 266
  local a=np.array({{63},{127}},np.uint8)
  local b=np.array({{1,17,17}},np.uint16)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 266 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 266 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 266 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'greater_equal 266 values')
end
do -- greater_equal array 267
  local a=np.array({{0,63,2},{127,63,2}},np.uint16)
  local b=np.array({2,0,5},np.uint64)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 267 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 267 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 267 strides')
  assert(veq(r:tolist(),{{false,true,false},{true,true,false}}),'greater_equal 267 values')
end
do -- greater_equal array 268
  local a=np.array({{true,false,false},{true,true,false}},np.bool)
  local b=np.array({{11.0,0.0,3.75}},np.float64)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 268 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'greater_equal 268 shape')
  assert(seqeq(r.strides,{3,1}),'greater_equal 268 strides')
  assert(veq(r:tolist(),{{false,true,false},{false,true,false}}),'greater_equal 268 values')
end
do -- greater_equal array 269
  local a=np.array({0,17,63,2,5},np.uint8)
  local b=np.array({0,126,126,0,-1},np.int16)
  local r=np.greater_equal(a,b)
  assert(r.dtype=='bool','greater_equal 269 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'greater_equal 269 shape')
  assert(seqeq(r.strides,{1}),'greater_equal 269 strides')
  assert(veq(r:tolist(),{true,false,false,true,true}),'greater_equal 269 values')
end
do -- logical_and array 270
  local a=np.array({{-math.huge},{11.0}},np.float32)
  local b=np.array({{17,127,17}},np.uint16)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 270 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 270 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 270 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_and 270 values')
end
do -- logical_and array 271
  local a=np.array({{-1.0},{-2.25}},np.float32)
  local b=np.array({{0,-7,9}},np.int32)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 271 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 271 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 271 strides')
  assert(veq(r:tolist(),{{false,true,true},{false,true,true}}),'logical_and 271 values')
end
do -- logical_and array 272
  local a=np.array({{{251},{5},{0}},{{17},{1},{0}}},np.uint32)
  local b=np.array({{{1,-1,9,-31},{-127,126,-7,-1},{0,-1,126,1}}},np.int8)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 272 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_and 272 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_and 272 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,true,true,true},{false,false,false,false}},{{true,true,true,true},{true,true,true,true},{false,false,false,false}}}),'logical_and 272 values')
end
do -- logical_and array 273
  local a=np.array({127,63,1,0,0},np.uint8)
  local b=np.array({-1,-7,-7,-1,2},np.int32)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 273 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'logical_and 273 shape')
  assert(seqeq(r.strides,{1}),'logical_and 273 strides')
  assert(veq(r:tolist(),{true,true,true,false,false}),'logical_and 273 values')
end
do -- logical_and array 274
  local a=np.array({{{5},{17},{17}},{{251},{127},{0}}},np.uint8)
  local b=np.array({{{5,5,251,127},{127,251,5,127},{1,2,2,63}}},np.uint8)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 274 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_and 274 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_and 274 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,true,true,true},{true,true,true,true}},{{true,true,true,true},{true,true,true,true},{false,false,false,false}}}),'logical_and 274 values')
end
do -- logical_and array 275
  local a=np.array({{-7,126,1},{-1,-7,63}},np.int8)
  local b=np.array({{-2.25,math.huge,-2.25}},np.float16)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 275 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 275 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 275 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_and 275 values')
end
do -- logical_and array 276
  local a=np.array({{{false},{false},{true}},{{false},{true},{false}}},np.bool)
  local b=np.array({{{-math.huge,math.huge,-9.5,11.0},{-2.25,11.0,(0/0),-0.0},{-0.0,-0.0,-9.5,0.0}}},np.float32)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 276 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_and 276 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_and 276 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,false,false},{false,false,true,false}},{{false,false,false,false},{true,true,true,false},{false,false,false,false}}}),'logical_and 276 values')
end
do -- logical_and array 277
  local a=np.array({{(0/0)},{1.0}},np.float32)
  local b=np.array({{-1.0,-9.5,-9.5}},np.float16)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 277 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 277 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 277 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_and 277 values')
end
do -- logical_and array 278
  local a=np.array({{0.5,(0/0),-0.0},{0.5,-1.0,1.0}},np.float16)
  local b=np.array({false,false,false},np.bool)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 278 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 278 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 278 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'logical_and 278 values')
end
do -- logical_and array 279
  local a=np.array({{{2},{17},{2}},{{1},{63},{5}}},np.uint16)
  local b=np.array({{{false,false,false,true},{true,false,false,false},{false,true,false,false}}},np.bool)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 279 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_and 279 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_and 279 strides')
  assert(veq(r:tolist(),{{{false,false,false,true},{true,false,false,false},{false,true,false,false}},{{false,false,false,true},{true,false,false,false},{false,true,false,false}}}),'logical_and 279 values')
end
do -- logical_and array 280
  local a=np.array({{-7,126,-31},{2,63,9}},np.int32)
  local b=np.array({{9,-1,-1}},np.int64)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 280 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 280 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 280 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_and 280 values')
end
do -- logical_and array 281
  local a=np.array({{11.0,-2.25,(0/0)},{1.0,3.75,0.0}},np.float32)
  local b=np.array({{-math.huge,-9.5,math.huge}},np.float16)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 281 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 281 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 281 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,false}}),'logical_and 281 values')
end
do -- logical_and array 282
  local a=np.array({{{5},{5},{63}},{{127},{17},{17}}},np.uint16)
  local b=np.array({{{-7,-1,-31,0},{0,-127,1,2},{-7,63,2,-7}}},np.int32)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 282 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_and 282 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_and 282 strides')
  assert(veq(r:tolist(),{{{true,true,true,false},{false,true,true,true},{true,true,true,true}},{{true,true,true,false},{false,true,true,true},{true,true,true,true}}}),'logical_and 282 values')
end
do -- logical_and array 283
  local a=np.array({{127},{5}},np.uint64)
  local b=np.array({{-math.huge,-2.25,-math.huge}},np.float64)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 283 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 283 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 283 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_and 283 values')
end
do -- logical_and array 284
  local a=np.array({{math.huge,3.75,3.75},{-2.25,0.0,-1.0}},np.float64)
  local b=np.array({3.75,-math.huge,-math.huge},np.float16)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 284 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 284 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 284 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,false,true}}),'logical_and 284 values')
end
do -- logical_and array 285
  local a=np.array({{251,17,127},{17,251,251}},np.uint16)
  local b=np.array({63,1,17},np.uint8)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 285 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 285 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 285 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_and 285 values')
end
do -- logical_and array 286
  local a=np.array({-1,-1,63,126,2},np.int32)
  local b=np.array({true,false,true,false,false},np.bool)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 286 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'logical_and 286 shape')
  assert(seqeq(r.strides,{1}),'logical_and 286 strides')
  assert(veq(r:tolist(),{true,false,true,false,false}),'logical_and 286 values')
end
do -- logical_and array 287
  local a=np.array({{2,63,1},{17,5,0}},np.uint16)
  local b=np.array({{2,-31,1}},np.int32)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 287 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 287 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 287 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,false}}),'logical_and 287 values')
end
do -- logical_and array 288
  local a=np.array({{2},{9}},np.int32)
  local b=np.array({{1,2,2}},np.uint32)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 288 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 288 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 288 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_and 288 values')
end
do -- logical_and array 289
  local a=np.array({{-1,0,-1},{-31,-7,-7}},np.int8)
  local b=np.array({63,63,2},np.uint64)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 289 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 289 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 289 strides')
  assert(veq(r:tolist(),{{true,false,true},{true,true,true}}),'logical_and 289 values')
end
do -- logical_and array 290
  local a=np.array({{-0.0,math.huge,-1.0},{(0/0),11.0,(0/0)}},np.float16)
  local b=np.array({{63,63,0}},np.uint64)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 290 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 290 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 290 strides')
  assert(veq(r:tolist(),{{false,true,false},{true,true,false}}),'logical_and 290 values')
end
do -- logical_and array 291
  local a=np.array({{3.75,0.5,3.75},{3.75,-9.5,-9.5}},np.float16)
  local b=np.array({-1,-7,0},np.int16)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 291 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 291 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 291 strides')
  assert(veq(r:tolist(),{{true,true,false},{true,true,false}}),'logical_and 291 values')
end
do -- logical_and array 292
  local a=np.array({{-31},{2}},np.int8)
  local b=np.array({{false,false,true}},np.bool)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 292 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 292 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 292 strides')
  assert(veq(r:tolist(),{{false,false,true},{false,false,true}}),'logical_and 292 values')
end
do -- logical_and array 293
  local a=np.array({{-31,-127,63},{-31,9,-127}},np.int64)
  local b=np.array({false,false,true},np.bool)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 293 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 293 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 293 strides')
  assert(veq(r:tolist(),{{false,false,true},{false,false,true}}),'logical_and 293 values')
end
do -- logical_and array 294
  local a=np.array({{0.0,-9.5,3.75},{11.0,-1.0,3.75}},np.float64)
  local b=np.array({-math.huge,3.75,-1.0},np.float16)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 294 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 294 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 294 strides')
  assert(veq(r:tolist(),{{false,true,true},{true,true,true}}),'logical_and 294 values')
end
do -- logical_and array 295
  local a=np.array({{true},{true}},np.bool)
  local b=np.array({{127,0,251}},np.uint32)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 295 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 295 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 295 strides')
  assert(veq(r:tolist(),{{true,false,true},{true,false,true}}),'logical_and 295 values')
end
do -- logical_and array 296
  local a=np.array({{63,127,127},{251,63,63}},np.uint16)
  local b=np.array({1.0,-9.5,1.0},np.float64)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 296 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 296 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 296 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_and 296 values')
end
do -- logical_and array 297
  local a=np.array({{{1},{0},{126}},{{9},{0},{-1}}},np.int16)
  local b=np.array({{{0,-1,63,-1},{9,1,9,63},{9,9,-7,-127}}},np.int64)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 297 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_and 297 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_and 297 strides')
  assert(veq(r:tolist(),{{{false,true,true,true},{false,false,false,false},{true,true,true,true}},{{false,true,true,true},{false,false,false,false},{true,true,true,true}}}),'logical_and 297 values')
end
do -- logical_and array 298
  local a=np.array({{{1},{1},{2}},{{126},{9},{-31}}},np.int64)
  local b=np.array({{{9,1,2,-7},{-1,0,63,-31},{-127,-1,0,2}}},np.int8)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 298 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_and 298 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_and 298 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,false,true,true},{true,true,false,true}},{{true,true,true,true},{true,false,true,true},{true,true,false,true}}}),'logical_and 298 values')
end
do -- logical_and array 299
  local a=np.array({{{5},{2},{0}},{{0},{2},{251}}},np.uint32)
  local b=np.array({{{251,5,63,63},{63,63,1,127},{17,5,17,127}}},np.uint16)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 299 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_and 299 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_and 299 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,true,true,true},{false,false,false,false}},{{false,false,false,false},{true,true,true,true},{true,true,true,true}}}),'logical_and 299 values')
end
do -- logical_and array 300
  local a=np.array({{127,17,63},{1,127,0}},np.uint8)
  local b=np.array({-1,-31,-31},np.int32)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 300 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 300 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 300 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,false}}),'logical_and 300 values')
end
do -- logical_and array 301
  local a=np.array({{{-9.5},{-1.0},{-0.0}},{{math.huge},{math.huge},{-0.0}}},np.float16)
  local b=np.array({{{0,5,251,1},{63,63,17,1},{1,251,1,127}}},np.uint8)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 301 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_and 301 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_and 301 strides')
  assert(veq(r:tolist(),{{{false,true,true,true},{true,true,true,true},{false,false,false,false}},{{false,true,true,true},{true,true,true,true},{false,false,false,false}}}),'logical_and 301 values')
end
do -- logical_and array 302
  local a=np.array({{-7,-127,63},{-1,-1,-1}},np.int16)
  local b=np.array({1,127,5},np.uint64)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 302 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 302 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 302 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_and 302 values')
end
do -- logical_and array 303
  local a=np.array({{2,-31,126},{1,-1,2}},np.int64)
  local b=np.array({{-7,126,-127}},np.int8)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 303 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 303 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 303 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_and 303 values')
end
do -- logical_and array 304
  local a=np.array({{-0.0},{-2.25}},np.float64)
  local b=np.array({{math.huge,3.75,0.0}},np.float16)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 304 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 304 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 304 strides')
  assert(veq(r:tolist(),{{false,false,false},{true,true,false}}),'logical_and 304 values')
end
do -- logical_and array 305
  local a=np.array({2,251,63,63,17},np.uint64)
  local b=np.array({251,1,63,1,127},np.uint16)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 305 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'logical_and 305 shape')
  assert(seqeq(r.strides,{1}),'logical_and 305 strides')
  assert(veq(r:tolist(),{true,true,true,true,true}),'logical_and 305 values')
end
do -- logical_and array 306
  local a=np.array({{-1.0,0.0,-2.25},{0.0,-1.0,0.5}},np.float64)
  local b=np.array({63,-127,9},np.int32)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 306 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 306 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 306 strides')
  assert(veq(r:tolist(),{{true,false,true},{false,true,true}}),'logical_and 306 values')
end
do -- logical_and array 307
  local a=np.array({{{127},{63},{0}},{{17},{5},{5}}},np.uint16)
  local b=np.array({{{-127,-1,2,-127},{126,-7,-31,9},{9,-1,-1,0}}},np.int64)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 307 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_and 307 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_and 307 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,true,true,true},{false,false,false,false}},{{true,true,true,true},{true,true,true,true},{true,true,true,false}}}),'logical_and 307 values')
end
do -- logical_and array 308
  local a=np.array({true,true,false,false,false},np.bool)
  local b=np.array({5,1,5,251,5},np.uint16)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 308 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'logical_and 308 shape')
  assert(seqeq(r.strides,{1}),'logical_and 308 strides')
  assert(veq(r:tolist(),{true,true,false,false,false}),'logical_and 308 values')
end
do -- logical_and array 309
  local a=np.array({true,true,true,true,true},np.bool)
  local b=np.array({-7,63,-127,63,-1},np.int64)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 309 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'logical_and 309 shape')
  assert(seqeq(r.strides,{1}),'logical_and 309 strides')
  assert(veq(r:tolist(),{true,true,true,true,true}),'logical_and 309 values')
end
do -- logical_and array 310
  local a=np.array({{1,-127,-127},{1,1,1}},np.int16)
  local b=np.array({{9,-7,63}},np.int64)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 310 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 310 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 310 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_and 310 values')
end
do -- logical_and array 311
  local a=np.array({{true,false,true},{true,false,true}},np.bool)
  local b=np.array({0,5,1},np.uint8)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 311 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 311 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 311 strides')
  assert(veq(r:tolist(),{{false,false,true},{false,false,true}}),'logical_and 311 values')
end
do -- logical_and array 312
  local a=np.array({{0.5},{3.75}},np.float32)
  local b=np.array({{-127,-31,1}},np.int32)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 312 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_and 312 shape')
  assert(seqeq(r.strides,{3,1}),'logical_and 312 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_and 312 values')
end
do -- logical_and array 313
  local a=np.array({9,-1,-7,0,-127},np.int32)
  local b=np.array({-7,-1,-31,0,-1},np.int32)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 313 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'logical_and 313 shape')
  assert(seqeq(r.strides,{1}),'logical_and 313 strides')
  assert(veq(r:tolist(),{true,true,true,false,true}),'logical_and 313 values')
end
do -- logical_and array 314
  local a=np.array({{{126},{-127},{9}},{{2},{2},{126}}},np.int8)
  local b=np.array({{{-math.huge,0.5,0.0,-math.huge},{11.0,0.5,(0/0),3.75},{0.5,(0/0),3.75,0.5}}},np.float32)
  local r=np.logical_and(a,b)
  assert(r.dtype=='bool','logical_and 314 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_and 314 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_and 314 strides')
  assert(veq(r:tolist(),{{{true,true,false,true},{true,true,true,true},{true,true,true,true}},{{true,true,false,true},{true,true,true,true},{true,true,true,true}}}),'logical_and 314 values')
end
do -- logical_or array 315
  local a=np.array({{2,1,63},{2,0,0}},np.uint64)
  local b=np.array({true,true,false},np.bool)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 315 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 315 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 315 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,false}}),'logical_or 315 values')
end
do -- logical_or array 316
  local a=np.array({1,-31,2,-127,2},np.int64)
  local b=np.array({2,1,-127,0,1},np.int64)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 316 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'logical_or 316 shape')
  assert(seqeq(r.strides,{1}),'logical_or 316 strides')
  assert(veq(r:tolist(),{true,true,true,true,true}),'logical_or 316 values')
end
do -- logical_or array 317
  local a=np.array({{-2.25},{11.0}},np.float16)
  local b=np.array({{-1,-7,2}},np.int16)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 317 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 317 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 317 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 317 values')
end
do -- logical_or array 318
  local a=np.array({{5,251,251},{63,127,1}},np.uint8)
  local b=np.array({{127,63,2}},np.uint8)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 318 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 318 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 318 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 318 values')
end
do -- logical_or array 319
  local a=np.array({{{2},{2},{-7}},{{0},{-31},{-1}}},np.int64)
  local b=np.array({{{0,251,0,63},{251,63,17,63},{5,0,2,2}}},np.uint64)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 319 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_or 319 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_or 319 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,true,true,true},{true,true,true,true}},{{false,true,false,true},{true,true,true,true},{true,true,true,true}}}),'logical_or 319 values')
end
do -- logical_or array 320
  local a=np.array({{-1,-31,-127},{63,63,-1}},np.int16)
  local b=np.array({{1,5,1}},np.uint16)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 320 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 320 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 320 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 320 values')
end
do -- logical_or array 321
  local a=np.array({{1},{-127}},np.int8)
  local b=np.array({{2,2,2}},np.uint16)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 321 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 321 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 321 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 321 values')
end
do -- logical_or array 322
  local a=np.array({{11.0,0.0,-2.25},{-1.0,(0/0),1.0}},np.float32)
  local b=np.array({(0/0),-0.0,-0.0},np.float64)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 322 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 322 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 322 strides')
  assert(veq(r:tolist(),{{true,false,true},{true,true,true}}),'logical_or 322 values')
end
do -- logical_or array 323
  local a=np.array({{9,1,-1},{1,-1,0}},np.int64)
  local b=np.array({{251,1,5}},np.uint32)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 323 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 323 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 323 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 323 values')
end
do -- logical_or array 324
  local a=np.array({{11.0,-1.0,1.0},{-2.25,-2.25,1.0}},np.float16)
  local b=np.array({-31,9,-127},np.int64)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 324 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 324 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 324 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 324 values')
end
do -- logical_or array 325
  local a=np.array({{17,2,63},{1,17,251}},np.uint64)
  local b=np.array({251,251,0},np.uint8)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 325 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 325 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 325 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 325 values')
end
do -- logical_or array 326
  local a=np.array({{63},{2}},np.uint16)
  local b=np.array({{63,5,17}},np.uint16)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 326 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 326 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 326 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 326 values')
end
do -- logical_or array 327
  local a=np.array({{{0.0},{(0/0)},{-9.5}},{{0.5},{(0/0)},{-math.huge}}},np.float16)
  local b=np.array({{{-1,2,126,-1},{0,0,-127,1},{126,2,9,0}}},np.int16)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 327 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_or 327 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_or 327 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,true,true,true},{true,true,true,true}},{{true,true,true,true},{true,true,true,true},{true,true,true,true}}}),'logical_or 327 values')
end
do -- logical_or array 328
  local a=np.array({{{0},{0},{-7}},{{-7},{-1},{63}}},np.int32)
  local b=np.array({{{251,0,1,2},{0,251,1,17},{0,251,0,5}}},np.uint32)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 328 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_or 328 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_or 328 strides')
  assert(veq(r:tolist(),{{{true,false,true,true},{false,true,true,true},{true,true,true,true}},{{true,true,true,true},{true,true,true,true},{true,true,true,true}}}),'logical_or 328 values')
end
do -- logical_or array 329
  local a=np.array({{0},{63}},np.int64)
  local b=np.array({{true,true,true}},np.bool)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 329 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 329 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 329 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 329 values')
end
do -- logical_or array 330
  local a=np.array({{-127,0,63},{9,2,-127}},np.int32)
  local b=np.array({0.0,3.75,-math.huge},np.float64)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 330 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 330 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 330 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 330 values')
end
do -- logical_or array 331
  local a=np.array({{1},{-7}},np.int16)
  local b=np.array({{0,0,-127}},np.int8)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 331 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 331 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 331 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 331 values')
end
do -- logical_or array 332
  local a=np.array({-31,63,1,63,1},np.int32)
  local b=np.array({1,126,63,-31,126},np.int32)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 332 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'logical_or 332 shape')
  assert(seqeq(r.strides,{1}),'logical_or 332 strides')
  assert(veq(r:tolist(),{true,true,true,true,true}),'logical_or 332 values')
end
do -- logical_or array 333
  local a=np.array({{63,1,2},{127,63,5}},np.uint8)
  local b=np.array({127,63,251},np.uint32)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 333 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 333 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 333 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 333 values')
end
do -- logical_or array 334
  local a=np.array({251,5,2,127,5},np.uint64)
  local b=np.array({17,0,127,0,251},np.uint8)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 334 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'logical_or 334 shape')
  assert(seqeq(r.strides,{1}),'logical_or 334 strides')
  assert(veq(r:tolist(),{true,true,true,true,true}),'logical_or 334 values')
end
do -- logical_or array 335
  local a=np.array({{9,63,-7},{-7,-31,9}},np.int32)
  local b=np.array({{-7,-127,9}},np.int32)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 335 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 335 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 335 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 335 values')
end
do -- logical_or array 336
  local a=np.array({1.0,3.75,-math.huge,0.5,(0/0)},np.float64)
  local b=np.array({0,17,251,251,1},np.uint32)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 336 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'logical_or 336 shape')
  assert(seqeq(r.strides,{1}),'logical_or 336 strides')
  assert(veq(r:tolist(),{true,true,true,true,true}),'logical_or 336 values')
end
do -- logical_or array 337
  local a=np.array({{11.0,1.0,-math.huge},{-1.0,0.0,-0.0}},np.float16)
  local b=np.array({63,63,251},np.uint8)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 337 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 337 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 337 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 337 values')
end
do -- logical_or array 338
  local a=np.array({{(0/0)},{1.0}},np.float32)
  local b=np.array({{0,63,-127}},np.int16)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 338 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 338 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 338 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 338 values')
end
do -- logical_or array 339
  local a=np.array({false,false,true,true,false},np.bool)
  local b=np.array({2,-7,2,-1,-31},np.int32)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 339 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'logical_or 339 shape')
  assert(seqeq(r.strides,{1}),'logical_or 339 strides')
  assert(veq(r:tolist(),{true,true,true,true,true}),'logical_or 339 values')
end
do -- logical_or array 340
  local a=np.array({{{127},{127},{127}},{{0},{17},{1}}},np.uint64)
  local b=np.array({{{0,63,63,63},{1,63,127,63},{17,0,2,17}}},np.uint16)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 340 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_or 340 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_or 340 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,true,true,true},{true,true,true,true}},{{false,true,true,true},{true,true,true,true},{true,true,true,true}}}),'logical_or 340 values')
end
do -- logical_or array 341
  local a=np.array({{-1,126,0},{126,-31,63}},np.int32)
  local b=np.array({{-7,-1,126}},np.int16)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 341 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 341 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 341 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 341 values')
end
do -- logical_or array 342
  local a=np.array({{2},{5}},np.uint64)
  local b=np.array({{17,1,2}},np.uint64)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 342 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 342 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 342 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 342 values')
end
do -- logical_or array 343
  local a=np.array({{{126},{126},{-7}},{{-7},{0},{0}}},np.int8)
  local b=np.array({{{true,false,true,false},{false,false,true,false},{false,true,false,false}}},np.bool)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 343 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_or 343 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_or 343 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,true,true,true},{true,true,true,true}},{{true,true,true,true},{false,false,true,false},{false,true,false,false}}}),'logical_or 343 values')
end
do -- logical_or array 344
  local a=np.array({{63,2,251},{2,0,127}},np.uint16)
  local b=np.array({math.huge,0.0,3.75},np.float32)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 344 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 344 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 344 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,false,true}}),'logical_or 344 values')
end
do -- logical_or array 345
  local a=np.array({{-math.huge},{-math.huge}},np.float32)
  local b=np.array({{5,127,0}},np.uint32)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 345 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 345 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 345 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 345 values')
end
do -- logical_or array 346
  local a=np.array({{0.0},{0.5}},np.float16)
  local b=np.array({{17,127,5}},np.uint64)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 346 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 346 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 346 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 346 values')
end
do -- logical_or array 347
  local a=np.array({{126},{1}},np.int32)
  local b=np.array({{0,9,-7}},np.int8)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 347 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 347 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 347 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 347 values')
end
do -- logical_or array 348
  local a=np.array({1,9,-127,126,-1},np.int16)
  local b=np.array({2,127,1,127,1},np.uint32)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 348 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'logical_or 348 shape')
  assert(seqeq(r.strides,{1}),'logical_or 348 strides')
  assert(veq(r:tolist(),{true,true,true,true,true}),'logical_or 348 values')
end
do -- logical_or array 349
  local a=np.array({{1},{0}},np.uint16)
  local b=np.array({{0,127,0}},np.uint8)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 349 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 349 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 349 strides')
  assert(veq(r:tolist(),{{true,true,true},{false,true,false}}),'logical_or 349 values')
end
do -- logical_or array 350
  local a=np.array({{126},{2}},np.int64)
  local b=np.array({{0.5,-math.huge,-0.0}},np.float16)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 350 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 350 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 350 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 350 values')
end
do -- logical_or array 351
  local a=np.array({{-31,1,2},{9,63,126}},np.int8)
  local b=np.array({{-7,-7,-31}},np.int8)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 351 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 351 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 351 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 351 values')
end
do -- logical_or array 352
  local a=np.array({{math.huge,0.5,1.0},{1.0,-1.0,0.5}},np.float16)
  local b=np.array({0.0,3.75,math.huge},np.float32)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 352 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 352 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 352 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 352 values')
end
do -- logical_or array 353
  local a=np.array({{126,1,2},{63,-31,1}},np.int64)
  local b=np.array({(0/0),3.75,3.75},np.float64)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 353 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 353 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 353 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 353 values')
end
do -- logical_or array 354
  local a=np.array({{-127},{-1}},np.int32)
  local b=np.array({{11.0,-1.0,1.0}},np.float16)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 354 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 354 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 354 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 354 values')
end
do -- logical_or array 355
  local a=np.array({{5},{0}},np.uint64)
  local b=np.array({{251,63,1}},np.uint64)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 355 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_or 355 shape')
  assert(seqeq(r.strides,{3,1}),'logical_or 355 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'logical_or 355 values')
end
do -- logical_or array 356
  local a=np.array({0.0,-math.huge,-9.5,(0/0),(0/0)},np.float16)
  local b=np.array({9,-7,-31,63,126},np.int16)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 356 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'logical_or 356 shape')
  assert(seqeq(r.strides,{1}),'logical_or 356 strides')
  assert(veq(r:tolist(),{true,true,true,true,true}),'logical_or 356 values')
end
do -- logical_or array 357
  local a=np.array({11.0,-1.0,(0/0),11.0,0.0},np.float64)
  local b=np.array({17,5,127,251,5},np.uint16)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 357 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'logical_or 357 shape')
  assert(seqeq(r.strides,{1}),'logical_or 357 strides')
  assert(veq(r:tolist(),{true,true,true,true,true}),'logical_or 357 values')
end
do -- logical_or array 358
  local a=np.array({{{0},{5},{0}},{{127},{127},{1}}},np.uint8)
  local b=np.array({{{127,17,127,17},{63,5,17,127},{63,2,2,5}}},np.uint32)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 358 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_or 358 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_or 358 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{true,true,true,true},{true,true,true,true}},{{true,true,true,true},{true,true,true,true},{true,true,true,true}}}),'logical_or 358 values')
end
do -- logical_or array 359
  local a=np.array({-math.huge,-math.huge,-1.0,-9.5,math.huge},np.float32)
  local b=np.array({0,1,127,251,17},np.uint8)
  local r=np.logical_or(a,b)
  assert(r.dtype=='bool','logical_or 359 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'logical_or 359 shape')
  assert(seqeq(r.strides,{1}),'logical_or 359 strides')
  assert(veq(r:tolist(),{true,true,true,true,true}),'logical_or 359 values')
end
do -- logical_xor array 360
  local a=np.array({{-9.5},{0.5}},np.float32)
  local b=np.array({{251,0,2}},np.uint64)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 360 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_xor 360 shape')
  assert(seqeq(r.strides,{3,1}),'logical_xor 360 strides')
  assert(veq(r:tolist(),{{false,true,false},{false,true,false}}),'logical_xor 360 values')
end
do -- logical_xor array 361
  local a=np.array({{-9.5,-2.25,-9.5},{3.75,1.0,math.huge}},np.float16)
  local b=np.array({{127,251,17}},np.uint32)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 361 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_xor 361 shape')
  assert(seqeq(r.strides,{3,1}),'logical_xor 361 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'logical_xor 361 values')
end
do -- logical_xor array 362
  local a=np.array({{63,9,-7},{1,1,-1}},np.int8)
  local b=np.array({{(0/0),-2.25,math.huge}},np.float16)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 362 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_xor 362 shape')
  assert(seqeq(r.strides,{3,1}),'logical_xor 362 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'logical_xor 362 values')
end
do -- logical_xor array 363
  local a=np.array({{9,9,-31},{126,63,126}},np.int16)
  local b=np.array({{126,-1,-31}},np.int32)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 363 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_xor 363 shape')
  assert(seqeq(r.strides,{3,1}),'logical_xor 363 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'logical_xor 363 values')
end
do -- logical_xor array 364
  local a=np.array({{true,false,false},{false,true,true}},np.bool)
  local b=np.array({63,127,251},np.uint16)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 364 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_xor 364 shape')
  assert(seqeq(r.strides,{3,1}),'logical_xor 364 strides')
  assert(veq(r:tolist(),{{false,true,true},{true,false,false}}),'logical_xor 364 values')
end
do -- logical_xor array 365
  local a=np.array({{9,-7,-7},{9,-127,-31}},np.int32)
  local b=np.array({{2,2,17}},np.uint16)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 365 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_xor 365 shape')
  assert(seqeq(r.strides,{3,1}),'logical_xor 365 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'logical_xor 365 values')
end
do -- logical_xor array 366
  local a=np.array({{1,5,0},{63,17,2}},np.uint64)
  local b=np.array({-31,9,-31},np.int64)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 366 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_xor 366 shape')
  assert(seqeq(r.strides,{3,1}),'logical_xor 366 strides')
  assert(veq(r:tolist(),{{false,false,true},{false,false,false}}),'logical_xor 366 values')
end
do -- logical_xor array 367
  local a=np.array({{{9},{126},{63}},{{63},{9},{126}}},np.int32)
  local b=np.array({{{63,2,-31,126},{-127,1,-1,63},{63,-127,-127,0}}},np.int32)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 367 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_xor 367 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_xor 367 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,false,false},{false,false,false,true}},{{false,false,false,false},{false,false,false,false},{false,false,false,true}}}),'logical_xor 367 values')
end
do -- logical_xor array 368
  local a=np.array({{{5},{17},{251}},{{63},{17},{1}}},np.uint16)
  local b=np.array({{{9,9,-127,-7},{1,2,0,2},{-127,126,-127,126}}},np.int32)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 368 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_xor 368 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_xor 368 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,true,false},{false,false,false,false}},{{false,false,false,false},{false,false,true,false},{false,false,false,false}}}),'logical_xor 368 values')
end
do -- logical_xor array 369
  local a=np.array({{{-2.25},{-1.0},{-1.0}},{{-1.0},{-math.huge},{(0/0)}}},np.float16)
  local b=np.array({{{-9.5,-1.0,-0.0,-9.5},{0.5,(0/0),-2.25,(0/0)},{0.0,11.0,0.0,0.0}}},np.float64)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 369 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_xor 369 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_xor 369 strides')
  assert(veq(r:tolist(),{{{false,false,true,false},{false,false,false,false},{true,false,true,true}},{{false,false,true,false},{false,false,false,false},{true,false,true,true}}}),'logical_xor 369 values')
end
do -- logical_xor array 370
  local a=np.array({{1,2,17},{5,251,1}},np.uint64)
  local b=np.array({{251,1,251}},np.uint16)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 370 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_xor 370 shape')
  assert(seqeq(r.strides,{3,1}),'logical_xor 370 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'logical_xor 370 values')
end
do -- logical_xor array 371
  local a=np.array({63,0,2,127,127},np.uint8)
  local b=np.array({9,126,-127,126,-1},np.int8)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 371 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'logical_xor 371 shape')
  assert(seqeq(r.strides,{1}),'logical_xor 371 strides')
  assert(veq(r:tolist(),{false,true,false,false,false}),'logical_xor 371 values')
end
do -- logical_xor array 372
  local a=np.array({127,127,127,17,2},np.uint16)
  local b=np.array({1,2,0,-7,0},np.int8)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 372 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'logical_xor 372 shape')
  assert(seqeq(r.strides,{1}),'logical_xor 372 strides')
  assert(veq(r:tolist(),{false,false,true,false,true}),'logical_xor 372 values')
end
do -- logical_xor array 373
  local a=np.array({{{-2.25},{-math.huge},{-1.0}},{{0.5},{0.5},{-1.0}}},np.float16)
  local b=np.array({{{-1.0,-0.0,11.0,3.75},{(0/0),-math.huge,-math.huge,11.0},{-1.0,-2.25,3.75,-1.0}}},np.float64)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 373 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_xor 373 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_xor 373 strides')
  assert(veq(r:tolist(),{{{false,true,false,false},{false,false,false,false},{false,false,false,false}},{{false,true,false,false},{false,false,false,false},{false,false,false,false}}}),'logical_xor 373 values')
end
do -- logical_xor array 374
  local a=np.array({{{5},{17},{17}},{{127},{0},{127}}},np.uint32)
  local b=np.array({{{1.0,(0/0),-9.5,-2.25},{-1.0,-1.0,0.5,1.0},{-1.0,(0/0),math.huge,11.0}}},np.float64)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 374 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_xor 374 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_xor 374 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,false,false},{false,false,false,false}},{{false,false,false,false},{true,true,true,true},{false,false,false,false}}}),'logical_xor 374 values')
end
do -- logical_xor array 375
  local a=np.array({{{-2.25},{-math.huge},{-9.5}},{{-math.huge},{11.0},{math.huge}}},np.float64)
  local b=np.array({{{math.huge,1.0,-2.25,math.huge},{3.75,0.0,0.0,-0.0},{-0.0,-9.5,-1.0,0.5}}},np.float32)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 375 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_xor 375 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_xor 375 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,true,true,true},{true,false,false,false}},{{false,false,false,false},{false,true,true,true},{true,false,false,false}}}),'logical_xor 375 values')
end
do -- logical_xor array 376
  local a=np.array({{251},{0}},np.uint64)
  local b=np.array({{math.huge,0.0,3.75}},np.float16)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 376 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_xor 376 shape')
  assert(seqeq(r.strides,{3,1}),'logical_xor 376 strides')
  assert(veq(r:tolist(),{{false,true,false},{true,false,true}}),'logical_xor 376 values')
end
do -- logical_xor array 377
  local a=np.array({{1},{-1}},np.int32)
  local b=np.array({{2,63,126}},np.int8)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 377 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_xor 377 shape')
  assert(seqeq(r.strides,{3,1}),'logical_xor 377 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'logical_xor 377 values')
end
do -- logical_xor array 378
  local a=np.array({{{2},{-1},{126}},{{0},{-1},{9}}},np.int64)
  local b=np.array({{{-2.25,(0/0),1.0,math.huge},{11.0,-0.0,-2.25,1.0},{11.0,1.0,-1.0,11.0}}},np.float16)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 378 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_xor 378 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_xor 378 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,true,false,false},{false,false,false,false}},{{true,true,true,true},{false,true,false,false},{false,false,false,false}}}),'logical_xor 378 values')
end
do -- logical_xor array 379
  local a=np.array({{-0.0,0.5,math.huge},{-1.0,-2.25,11.0}},np.float16)
  local b=np.array({{11.0,-math.huge,-math.huge}},np.float32)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 379 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_xor 379 shape')
  assert(seqeq(r.strides,{3,1}),'logical_xor 379 strides')
  assert(veq(r:tolist(),{{true,false,false},{false,false,false}}),'logical_xor 379 values')
end
do -- logical_xor array 380
  local a=np.array({{2},{-7}},np.int64)
  local b=np.array({{9,-127,1}},np.int8)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 380 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_xor 380 shape')
  assert(seqeq(r.strides,{3,1}),'logical_xor 380 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'logical_xor 380 values')
end
do -- logical_xor array 381
  local a=np.array({{{-127},{0},{0}},{{2},{2},{-31}}},np.int16)
  local b=np.array({{{17,5,2,1},{17,17,5,127},{5,2,127,17}}},np.uint32)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 381 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_xor 381 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_xor 381 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{true,true,true,true},{true,true,true,true}},{{false,false,false,false},{false,false,false,false},{false,false,false,false}}}),'logical_xor 381 values')
end
do -- logical_xor array 382
  local a=np.array({127,17,17,2,127},np.uint32)
  local b=np.array({-math.huge,0.5,-0.0,-9.5,-math.huge},np.float64)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 382 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'logical_xor 382 shape')
  assert(seqeq(r.strides,{1}),'logical_xor 382 strides')
  assert(veq(r:tolist(),{false,false,true,false,false}),'logical_xor 382 values')
end
do -- logical_xor array 383
  local a=np.array({{0.5,0.5,11.0},{3.75,11.0,-math.huge}},np.float64)
  local b=np.array({2,127,251},np.uint32)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 383 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_xor 383 shape')
  assert(seqeq(r.strides,{3,1}),'logical_xor 383 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'logical_xor 383 values')
end
do -- logical_xor array 384
  local a=np.array({{-2.25,-9.5,11.0},{-math.huge,-9.5,-math.huge}},np.float64)
  local b=np.array({{0,1,63}},np.uint8)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 384 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_xor 384 shape')
  assert(seqeq(r.strides,{3,1}),'logical_xor 384 strides')
  assert(veq(r:tolist(),{{true,false,false},{true,false,false}}),'logical_xor 384 values')
end
do -- logical_xor array 385
  local a=np.array({{{17},{0},{17}},{{127},{2},{127}}},np.uint8)
  local b=np.array({{{63,1,9,1},{-1,-31,9,9},{-127,-127,-7,2}}},np.int32)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 385 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_xor 385 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_xor 385 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{true,true,true,true},{false,false,false,false}},{{false,false,false,false},{false,false,false,false},{false,false,false,false}}}),'logical_xor 385 values')
end
do -- logical_xor array 386
  local a=np.array({5,17,0,1,63},np.uint8)
  local b=np.array({17,0,5,2,1},np.uint64)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 386 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'logical_xor 386 shape')
  assert(seqeq(r.strides,{1}),'logical_xor 386 strides')
  assert(veq(r:tolist(),{false,true,true,false,false}),'logical_xor 386 values')
end
do -- logical_xor array 387
  local a=np.array({{-7,63,0},{2,-31,-127}},np.int16)
  local b=np.array({{0,1,0}},np.int8)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 387 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_xor 387 shape')
  assert(seqeq(r.strides,{3,1}),'logical_xor 387 strides')
  assert(veq(r:tolist(),{{true,false,false},{true,false,true}}),'logical_xor 387 values')
end
do -- logical_xor array 388
  local a=np.array({{-127},{1}},np.int16)
  local b=np.array({{251,63,0}},np.uint64)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 388 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_xor 388 shape')
  assert(seqeq(r.strides,{3,1}),'logical_xor 388 strides')
  assert(veq(r:tolist(),{{false,false,true},{false,false,true}}),'logical_xor 388 values')
end
do -- logical_xor array 389
  local a=np.array({{{2},{127},{63}},{{17},{63},{5}}},np.uint16)
  local b=np.array({{{-1.0,-2.25,0.5,-2.25},{1.0,-2.25,1.0,11.0},{-2.25,0.0,-9.5,(0/0)}}},np.float16)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 389 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_xor 389 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_xor 389 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,false,false},{false,true,false,false}},{{false,false,false,false},{false,false,false,false},{false,true,false,false}}}),'logical_xor 389 values')
end
do -- logical_xor array 390
  local a=np.array({{0,2,-7},{2,0,0}},np.int64)
  local b=np.array({{0,127,2}},np.uint16)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 390 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_xor 390 shape')
  assert(seqeq(r.strides,{3,1}),'logical_xor 390 strides')
  assert(veq(r:tolist(),{{false,false,false},{true,true,true}}),'logical_xor 390 values')
end
do -- logical_xor array 391
  local a=np.array({{{63},{5},{127}},{{127},{5},{251}}},np.uint64)
  local b=np.array({{{-2.25,math.huge,-1.0,0.5},{-2.25,-9.5,(0/0),3.75},{3.75,-1.0,math.huge,-0.0}}},np.float16)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 391 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_xor 391 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_xor 391 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,false,false},{false,false,false,true}},{{false,false,false,false},{false,false,false,false},{false,false,false,true}}}),'logical_xor 391 values')
end
do -- logical_xor array 392
  local a=np.array({17,251,2,2,1},np.uint16)
  local b=np.array({1,1,251,2,0},np.uint16)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 392 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'logical_xor 392 shape')
  assert(seqeq(r.strides,{1}),'logical_xor 392 strides')
  assert(veq(r:tolist(),{false,false,false,false,true}),'logical_xor 392 values')
end
do -- logical_xor array 393
  local a=np.array({{true},{true}},np.bool)
  local b=np.array({{-127,63,63}},np.int16)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 393 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_xor 393 shape')
  assert(seqeq(r.strides,{3,1}),'logical_xor 393 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'logical_xor 393 values')
end
do -- logical_xor array 394
  local a=np.array({-1.0,math.huge,math.huge,-9.5,-math.huge},np.float32)
  local b=np.array({126,9,-7,2,126},np.int16)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 394 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'logical_xor 394 shape')
  assert(seqeq(r.strides,{1}),'logical_xor 394 strides')
  assert(veq(r:tolist(),{false,false,false,false,false}),'logical_xor 394 values')
end
do -- logical_xor array 395
  local a=np.array({{1},{0}},np.uint8)
  local b=np.array({{63,63,63}},np.uint16)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 395 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_xor 395 shape')
  assert(seqeq(r.strides,{3,1}),'logical_xor 395 strides')
  assert(veq(r:tolist(),{{false,false,false},{true,true,true}}),'logical_xor 395 values')
end
do -- logical_xor array 396
  local a=np.array({{{0},{251},{251}},{{0},{63},{5}}},np.uint8)
  local b=np.array({{{-127,2,126,-1},{-31,9,9,-1},{-7,126,1,1}}},np.int64)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 396 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_xor 396 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_xor 396 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{false,false,false,false},{false,false,false,false}},{{true,true,true,true},{false,false,false,false},{false,false,false,false}}}),'logical_xor 396 values')
end
do -- logical_xor array 397
  local a=np.array({-31,9,126,126,2},np.int16)
  local b=np.array({5,2,0,127,17},np.uint16)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 397 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'logical_xor 397 shape')
  assert(seqeq(r.strides,{1}),'logical_xor 397 strides')
  assert(veq(r:tolist(),{false,false,true,false,false}),'logical_xor 397 values')
end
do -- logical_xor array 398
  local a=np.array({{5},{127}},np.uint32)
  local b=np.array({{127,1,251}},np.uint32)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 398 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_xor 398 shape')
  assert(seqeq(r.strides,{3,1}),'logical_xor 398 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'logical_xor 398 values')
end
do -- logical_xor array 399
  local a=np.array({{3.75,1.0,-9.5},{11.0,(0/0),-1.0}},np.float32)
  local b=np.array({-7,-1,-127},np.int32)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 399 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_xor 399 shape')
  assert(seqeq(r.strides,{3,1}),'logical_xor 399 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'logical_xor 399 values')
end
do -- logical_xor array 400
  local a=np.array({{{63},{17},{1}},{{251},{251},{0}}},np.uint8)
  local b=np.array({{{-127,2,63,9},{126,63,1,126},{9,0,-127,9}}},np.int32)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 400 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_xor 400 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_xor 400 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,false,false,false},{false,true,false,false}},{{false,false,false,false},{false,false,false,false},{true,false,true,true}}}),'logical_xor 400 values')
end
do -- logical_xor array 401
  local a=np.array({{{0.0},{3.75},{0.5}},{{3.75},{-0.0},{-2.25}}},np.float64)
  local b=np.array({{{251,2,17,251},{17,63,127,5},{5,1,251,1}}},np.uint64)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 401 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_xor 401 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_xor 401 strides')
  assert(veq(r:tolist(),{{{true,true,true,true},{false,false,false,false},{false,false,false,false}},{{false,false,false,false},{true,true,true,true},{false,false,false,false}}}),'logical_xor 401 values')
end
do -- logical_xor array 402
  local a=np.array({{{-1},{-1},{126}},{{-127},{-1},{-7}}},np.int64)
  local b=np.array({{{3.75,-math.huge,-9.5,3.75},{1.0,-0.0,-0.0,3.75},{-9.5,-2.25,-0.0,0.5}}},np.float32)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 402 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_xor 402 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_xor 402 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{false,true,true,false},{false,false,true,false}},{{false,false,false,false},{false,true,true,false},{false,false,true,false}}}),'logical_xor 402 values')
end
do -- logical_xor array 403
  local a=np.array({{{126},{2},{9}},{{2},{-127},{9}}},np.int8)
  local b=np.array({{{5,63,17,127},{0,63,2,1},{2,17,63,1}}},np.uint8)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 403 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'logical_xor 403 shape')
  assert(seqeq(r.strides,{12,4,1}),'logical_xor 403 strides')
  assert(veq(r:tolist(),{{{false,false,false,false},{true,false,false,false},{false,false,false,false}},{{false,false,false,false},{true,false,false,false},{false,false,false,false}}}),'logical_xor 403 values')
end
do -- logical_xor array 404
  local a=np.array({{251},{1}},np.uint64)
  local b=np.array({{-7,63,1}},np.int16)
  local r=np.logical_xor(a,b)
  assert(r.dtype=='bool','logical_xor 404 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'logical_xor 404 shape')
  assert(seqeq(r.strides,{3,1}),'logical_xor 404 strides')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'logical_xor 404 values')
end
do -- maximum array 405
  local a=np.array({{false},{true}},np.bool)
  local b=np.array({{63,-127,126}},np.int8)
  local r=np.maximum(a,b)
  assert(r.dtype=='int8','maximum 405 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 405 shape')
  assert(seqeq(r.strides,{3,1}),'maximum 405 strides')
  assert(veq(r:tolist(),{{63,0,126},{63,1,126}}),'maximum 405 values')
end
do -- maximum array 406
  local a=np.array({{-1},{9}},np.int8)
  local b=np.array({{2,1,0}},np.uint32)
  local r=np.maximum(a,b)
  assert(r.dtype=='int64','maximum 406 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 406 shape')
  assert(seqeq(r.strides,{24,8}),'maximum 406 strides')
  assert(veq(r:tolist(),{{2,1,0},{9,9,9}}),'maximum 406 values')
end
do -- maximum array 407
  local a=np.array({{-31},{126}},np.int16)
  local b=np.array({{17,5,17}},np.uint8)
  local r=np.maximum(a,b)
  assert(r.dtype=='int16','maximum 407 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 407 shape')
  assert(seqeq(r.strides,{6,2}),'maximum 407 strides')
  assert(veq(r:tolist(),{{17,5,17},{126,126,126}}),'maximum 407 values')
end
do -- maximum array 408
  local a=np.array({3.75,1.0,1.0,-9.5,-0.0},np.float64)
  local b=np.array({-31,-7,9,-1,2},np.int16)
  local r=np.maximum(a,b)
  assert(r.dtype=='float64','maximum 408 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'maximum 408 shape')
  assert(seqeq(r.strides,{8}),'maximum 408 strides')
  assert(veq(r:tolist(),{3.75,1.0,9.0,-1.0,2.0}),'maximum 408 values')
end
do -- maximum array 409
  local a=np.array({{{63},{17},{251}},{{17},{63},{127}}},np.uint8)
  local b=np.array({{{11.0,-0.0,-9.5,-1.0},{math.huge,-2.25,-2.25,-1.0},{0.0,11.0,0.5,(0/0)}}},np.float16)
  local r=np.maximum(a,b)
  assert(r.dtype=='float16','maximum 409 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'maximum 409 shape')
  assert(seqeq(r.strides,{24,8,2}),'maximum 409 strides')
  assert(veq(r:tolist(),{{{63.0,63.0,63.0,63.0},{math.huge,17.0,17.0,17.0},{251.0,251.0,251.0,(0/0)}},{{17.0,17.0,17.0,17.0},{math.huge,63.0,63.0,63.0},{127.0,127.0,127.0,(0/0)}}}),'maximum 409 values')
end
do -- maximum array 410
  local a=np.array({9,9,-7,126,-31},np.int64)
  local b=np.array({11.0,-0.0,-1.0,-2.25,0.0},np.float32)
  local r=np.maximum(a,b)
  assert(r.dtype=='float64','maximum 410 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'maximum 410 shape')
  assert(seqeq(r.strides,{8}),'maximum 410 strides')
  assert(veq(r:tolist(),{11.0,9.0,-1.0,126.0,0.0}),'maximum 410 values')
end
do -- maximum array 411
  local a=np.array({{false},{false}},np.bool)
  local b=np.array({{9,0,-7}},np.int64)
  local r=np.maximum(a,b)
  assert(r.dtype=='int64','maximum 411 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 411 shape')
  assert(seqeq(r.strides,{24,8}),'maximum 411 strides')
  assert(veq(r:tolist(),{{9,0,0},{9,0,0}}),'maximum 411 values')
end
do -- maximum array 412
  local a=np.array({-math.huge,-2.25,0.5,-9.5,math.huge},np.float32)
  local b=np.array({126,0,63,-1,9},np.int64)
  local r=np.maximum(a,b)
  assert(r.dtype=='float64','maximum 412 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'maximum 412 shape')
  assert(seqeq(r.strides,{8}),'maximum 412 strides')
  assert(veq(r:tolist(),{126.0,0.0,63.0,-1.0,math.huge}),'maximum 412 values')
end
do -- maximum array 413
  local a=np.array({{0.5},{(0/0)}},np.float32)
  local b=np.array({{2,2,5}},np.uint64)
  local r=np.maximum(a,b)
  assert(r.dtype=='float64','maximum 413 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 413 shape')
  assert(seqeq(r.strides,{24,8}),'maximum 413 strides')
  assert(veq(r:tolist(),{{2.0,2.0,5.0},{(0/0),(0/0),(0/0)}}),'maximum 413 values')
end
do -- maximum array 414
  local a=np.array({-2.25,-1.0,(0/0),-0.0,-0.0},np.float32)
  local b=np.array({2,63,127,127,0},np.uint32)
  local r=np.maximum(a,b)
  assert(r.dtype=='float64','maximum 414 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'maximum 414 shape')
  assert(seqeq(r.strides,{8}),'maximum 414 strides')
  assert(veq(r:tolist(),{2.0,63.0,(0/0),127.0,0.0}),'maximum 414 values')
end
do -- maximum array 415
  local a=np.array({{(0/0),0.0,0.5},{1.0,3.75,math.huge}},np.float64)
  local b=np.array({{false,false,true}},np.bool)
  local r=np.maximum(a,b)
  assert(r.dtype=='float64','maximum 415 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 415 shape')
  assert(seqeq(r.strides,{24,8}),'maximum 415 strides')
  assert(veq(r:tolist(),{{(0/0),0.0,1.0},{1.0,3.75,math.huge}}),'maximum 415 values')
end
do -- maximum array 416
  local a=np.array({{9,-127,63},{0,63,63}},np.int32)
  local b=np.array({17,1,127},np.uint8)
  local r=np.maximum(a,b)
  assert(r.dtype=='int32','maximum 416 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 416 shape')
  assert(seqeq(r.strides,{12,4}),'maximum 416 strides')
  assert(veq(r:tolist(),{{17,1,127},{17,63,127}}),'maximum 416 values')
end
do -- maximum array 417
  local a=np.array({2,17,127,63,1},np.uint16)
  local b=np.array({126,2,9,-31,63},np.int64)
  local r=np.maximum(a,b)
  assert(r.dtype=='int64','maximum 417 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'maximum 417 shape')
  assert(seqeq(r.strides,{8}),'maximum 417 strides')
  assert(veq(r:tolist(),{126,17,127,63,63}),'maximum 417 values')
end
do -- maximum array 418
  local a=np.array({9,-7,-1,-31,0},np.int16)
  local b=np.array({63,17,17,5,2},np.uint64)
  local r=np.maximum(a,b)
  assert(r.dtype=='float64','maximum 418 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'maximum 418 shape')
  assert(seqeq(r.strides,{8}),'maximum 418 strides')
  assert(veq(r:tolist(),{63.0,17.0,17.0,5.0,2.0}),'maximum 418 values')
end
do -- maximum array 419
  local a=np.array({{63,1,127},{1,63,17}},np.uint8)
  local b=np.array({{2,-1,63}},np.int64)
  local r=np.maximum(a,b)
  assert(r.dtype=='int64','maximum 419 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 419 shape')
  assert(seqeq(r.strides,{24,8}),'maximum 419 strides')
  assert(veq(r:tolist(),{{63,1,127},{2,63,63}}),'maximum 419 values')
end
do -- maximum array 420
  local a=np.array({(0/0),-1.0,-2.25,-1.0,-9.5},np.float32)
  local b=np.array({5,2,1,1,63},np.uint16)
  local r=np.maximum(a,b)
  assert(r.dtype=='float32','maximum 420 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'maximum 420 shape')
  assert(seqeq(r.strides,{4}),'maximum 420 strides')
  assert(veq(r:tolist(),{(0/0),2.0,1.0,1.0,63.0}),'maximum 420 values')
end
do -- maximum array 421
  local a=np.array({{2},{63}},np.uint32)
  local b=np.array({{63,251,5}},np.uint8)
  local r=np.maximum(a,b)
  assert(r.dtype=='uint32','maximum 421 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 421 shape')
  assert(seqeq(r.strides,{12,4}),'maximum 421 strides')
  assert(veq(r:tolist(),{{63,251,5},{63,251,63}}),'maximum 421 values')
end
do -- maximum array 422
  local a=np.array({{true,false,true},{true,true,true}},np.bool)
  local b=np.array({{0,0,127}},np.uint32)
  local r=np.maximum(a,b)
  assert(r.dtype=='uint32','maximum 422 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 422 shape')
  assert(seqeq(r.strides,{12,4}),'maximum 422 strides')
  assert(veq(r:tolist(),{{1,0,127},{1,1,127}}),'maximum 422 values')
end
do -- maximum array 423
  local a=np.array({{false,true,true},{false,false,true}},np.bool)
  local b=np.array({{5,5,17}},np.uint64)
  local r=np.maximum(a,b)
  assert(r.dtype=='uint64','maximum 423 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 423 shape')
  assert(seqeq(r.strides,{24,8}),'maximum 423 strides')
  assert(veq(r:tolist(),{{5,5,17},{5,5,17}}),'maximum 423 values')
end
do -- maximum array 424
  local a=np.array({{{0},{1},{1}},{{0},{0},{1}}},np.uint8)
  local b=np.array({{{3.75,0.0,(0/0),-9.5},{-0.0,0.0,-2.25,-0.0},{-9.5,0.5,math.huge,-1.0}}},np.float16)
  local r=np.maximum(a,b)
  assert(r.dtype=='float16','maximum 424 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'maximum 424 shape')
  assert(seqeq(r.strides,{24,8,2}),'maximum 424 strides')
  assert(veq(r:tolist(),{{{3.75,0.0,(0/0),0.0},{1.0,1.0,1.0,1.0},{1.0,1.0,math.huge,1.0}},{{3.75,0.0,(0/0),0.0},{0.0,0.0,0.0,0.0},{1.0,1.0,math.huge,1.0}}}),'maximum 424 values')
end
do -- maximum array 425
  local a=np.array({1.0,11.0,(0/0),1.0,-1.0},np.float32)
  local b=np.array({0.5,-math.huge,-1.0,-1.0,0.0},np.float32)
  local r=np.maximum(a,b)
  assert(r.dtype=='float32','maximum 425 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'maximum 425 shape')
  assert(seqeq(r.strides,{4}),'maximum 425 strides')
  assert(veq(r:tolist(),{1.0,11.0,(0/0),1.0,0.0}),'maximum 425 values')
end
do -- maximum array 426
  local a=np.array({0.5,(0/0),3.75,11.0,-2.25},np.float64)
  local b=np.array({-31,-127,2,0,9},np.int16)
  local r=np.maximum(a,b)
  assert(r.dtype=='float64','maximum 426 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'maximum 426 shape')
  assert(seqeq(r.strides,{8}),'maximum 426 strides')
  assert(veq(r:tolist(),{0.5,(0/0),3.75,11.0,9.0}),'maximum 426 values')
end
do -- maximum array 427
  local a=np.array({-1,2,-31,-7,1},np.int32)
  local b=np.array({1,2,126,-127,126},np.int16)
  local r=np.maximum(a,b)
  assert(r.dtype=='int32','maximum 427 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'maximum 427 shape')
  assert(seqeq(r.strides,{4}),'maximum 427 strides')
  assert(veq(r:tolist(),{1,2,126,-7,126}),'maximum 427 values')
end
do -- maximum array 428
  local a=np.array({3.75,math.huge,0.0,11.0,-9.5},np.float64)
  local b=np.array({-1.0,-9.5,0.0,math.huge,3.75},np.float16)
  local r=np.maximum(a,b)
  assert(r.dtype=='float64','maximum 428 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'maximum 428 shape')
  assert(seqeq(r.strides,{8}),'maximum 428 strides')
  assert(veq(r:tolist(),{3.75,math.huge,0.0,math.huge,3.75}),'maximum 428 values')
end
do -- maximum array 429
  local a=np.array({{-31,-31,-1},{126,-7,-31}},np.int32)
  local b=np.array({{(0/0),0.0,3.75}},np.float16)
  local r=np.maximum(a,b)
  assert(r.dtype=='float64','maximum 429 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 429 shape')
  assert(seqeq(r.strides,{24,8}),'maximum 429 strides')
  assert(veq(r:tolist(),{{(0/0),0.0,3.75},{(0/0),0.0,3.75}}),'maximum 429 values')
end
do -- maximum array 430
  local a=np.array({{-9.5},{(0/0)}},np.float16)
  local b=np.array({{63,-127,126}},np.int8)
  local r=np.maximum(a,b)
  assert(r.dtype=='float16','maximum 430 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 430 shape')
  assert(seqeq(r.strides,{6,2}),'maximum 430 strides')
  assert(veq(r:tolist(),{{63.0,-9.5,126.0},{(0/0),(0/0),(0/0)}}),'maximum 430 values')
end
do -- maximum array 431
  local a=np.array({17,17,251,1,1},np.uint64)
  local b=np.array({5,17,0,251,1},np.uint64)
  local r=np.maximum(a,b)
  assert(r.dtype=='uint64','maximum 431 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'maximum 431 shape')
  assert(seqeq(r.strides,{8}),'maximum 431 strides')
  assert(veq(r:tolist(),{17,17,251,251,1}),'maximum 431 values')
end
do -- maximum array 432
  local a=np.array({{0,2,127},{63,2,63}},np.uint16)
  local b=np.array({-7,0,-7},np.int64)
  local r=np.maximum(a,b)
  assert(r.dtype=='int64','maximum 432 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 432 shape')
  assert(seqeq(r.strides,{24,8}),'maximum 432 strides')
  assert(veq(r:tolist(),{{0,2,127},{63,2,63}}),'maximum 432 values')
end
do -- maximum array 433
  local a=np.array({{true,false,true},{true,true,false}},np.bool)
  local b=np.array({11.0,0.0,(0/0)},np.float32)
  local r=np.maximum(a,b)
  assert(r.dtype=='float32','maximum 433 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 433 shape')
  assert(seqeq(r.strides,{12,4}),'maximum 433 strides')
  assert(veq(r:tolist(),{{11.0,0.0,(0/0)},{11.0,1.0,(0/0)}}),'maximum 433 values')
end
do -- maximum array 434
  local a=np.array({{2,-127,-127},{-7,2,9}},np.int32)
  local b=np.array({{-1,-7,2}},np.int64)
  local r=np.maximum(a,b)
  assert(r.dtype=='int64','maximum 434 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 434 shape')
  assert(seqeq(r.strides,{24,8}),'maximum 434 strides')
  assert(veq(r:tolist(),{{2,-7,2},{-1,2,9}}),'maximum 434 values')
end
do -- maximum array 435
  local a=np.array({false,true,false,true,true},np.bool)
  local b=np.array({0,126,-1,-7,0},np.int16)
  local r=np.maximum(a,b)
  assert(r.dtype=='int16','maximum 435 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'maximum 435 shape')
  assert(seqeq(r.strides,{2}),'maximum 435 strides')
  assert(veq(r:tolist(),{0,126,0,1,1}),'maximum 435 values')
end
do -- maximum array 436
  local a=np.array({{{9},{-127},{-31}},{{-7},{63},{-1}}},np.int16)
  local b=np.array({{{-7,126,-127,1},{-127,126,2,0},{0,-31,-31,126}}},np.int32)
  local r=np.maximum(a,b)
  assert(r.dtype=='int32','maximum 436 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'maximum 436 shape')
  assert(seqeq(r.strides,{48,16,4}),'maximum 436 strides')
  assert(veq(r:tolist(),{{{9,126,9,9},{-127,126,2,0},{0,-31,-31,126}},{{-7,126,-7,1},{63,126,63,63},{0,-1,-1,126}}}),'maximum 436 values')
end
do -- maximum array 437
  local a=np.array({{math.huge,math.huge,1.0},{-0.0,0.0,(0/0)}},np.float32)
  local b=np.array({251,251,0},np.uint32)
  local r=np.maximum(a,b)
  assert(r.dtype=='float64','maximum 437 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 437 shape')
  assert(seqeq(r.strides,{24,8}),'maximum 437 strides')
  assert(veq(r:tolist(),{{math.huge,math.huge,1.0},{251.0,251.0,(0/0)}}),'maximum 437 values')
end
do -- maximum array 438
  local a=np.array({{false,true,true},{false,false,true}},np.bool)
  local b=np.array({true,true,false},np.bool)
  local r=np.maximum(a,b)
  assert(r.dtype=='bool','maximum 438 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 438 shape')
  assert(seqeq(r.strides,{3,1}),'maximum 438 strides')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'maximum 438 values')
end
do -- maximum array 439
  local a=np.array({{5,17,251},{127,1,0}},np.uint32)
  local b=np.array({{0,63,-127}},np.int8)
  local r=np.maximum(a,b)
  assert(r.dtype=='int64','maximum 439 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 439 shape')
  assert(seqeq(r.strides,{24,8}),'maximum 439 strides')
  assert(veq(r:tolist(),{{5,63,251},{127,63,0}}),'maximum 439 values')
end
do -- maximum array 440
  local a=np.array({{2},{-7}},np.int32)
  local b=np.array({{0.0,1.0,0.5}},np.float64)
  local r=np.maximum(a,b)
  assert(r.dtype=='float64','maximum 440 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 440 shape')
  assert(seqeq(r.strides,{24,8}),'maximum 440 strides')
  assert(veq(r:tolist(),{{2.0,2.0,2.0},{0.0,1.0,0.5}}),'maximum 440 values')
end
do -- maximum array 441
  local a=np.array({{9},{-7}},np.int32)
  local b=np.array({{63,2,2}},np.int64)
  local r=np.maximum(a,b)
  assert(r.dtype=='int64','maximum 441 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 441 shape')
  assert(seqeq(r.strides,{24,8}),'maximum 441 strides')
  assert(veq(r:tolist(),{{63,9,9},{63,2,2}}),'maximum 441 values')
end
do -- maximum array 442
  local a=np.array({{5},{251}},np.uint32)
  local b=np.array({{126,-127,-7}},np.int64)
  local r=np.maximum(a,b)
  assert(r.dtype=='int64','maximum 442 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 442 shape')
  assert(seqeq(r.strides,{24,8}),'maximum 442 strides')
  assert(veq(r:tolist(),{{126,5,5},{251,251,251}}),'maximum 442 values')
end
do -- maximum array 443
  local a=np.array({{-7},{1}},np.int16)
  local b=np.array({{-1,-31,126}},np.int32)
  local r=np.maximum(a,b)
  assert(r.dtype=='int32','maximum 443 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 443 shape')
  assert(seqeq(r.strides,{12,4}),'maximum 443 strides')
  assert(veq(r:tolist(),{{-1,-7,126},{1,1,126}}),'maximum 443 values')
end
do -- maximum array 444
  local a=np.array({{true,false,true},{true,false,false}},np.bool)
  local b=np.array({-127,1,63},np.int16)
  local r=np.maximum(a,b)
  assert(r.dtype=='int16','maximum 444 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 444 shape')
  assert(seqeq(r.strides,{6,2}),'maximum 444 strides')
  assert(veq(r:tolist(),{{1,1,63},{1,1,63}}),'maximum 444 values')
end
do -- maximum array 445
  local a=np.array({{1,9,-1},{-31,0,9}},np.int32)
  local b=np.array({251,63,1},np.uint16)
  local r=np.maximum(a,b)
  assert(r.dtype=='int32','maximum 445 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 445 shape')
  assert(seqeq(r.strides,{12,4}),'maximum 445 strides')
  assert(veq(r:tolist(),{{251,63,1},{251,63,9}}),'maximum 445 values')
end
do -- maximum array 446
  local a=np.array({9,-127,-127,9,9},np.int64)
  local b=np.array({63,251,0,0,0},np.uint32)
  local r=np.maximum(a,b)
  assert(r.dtype=='int64','maximum 446 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'maximum 446 shape')
  assert(seqeq(r.strides,{8}),'maximum 446 strides')
  assert(veq(r:tolist(),{63,251,0,9,9}),'maximum 446 values')
end
do -- maximum array 447
  local a=np.array({{17,1,5},{5,17,251}},np.uint32)
  local b=np.array({{math.huge,3.75,-1.0}},np.float32)
  local r=np.maximum(a,b)
  assert(r.dtype=='float64','maximum 447 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 447 shape')
  assert(seqeq(r.strides,{24,8}),'maximum 447 strides')
  assert(veq(r:tolist(),{{math.huge,3.75,5.0},{math.huge,17.0,251.0}}),'maximum 447 values')
end
do -- maximum array 448
  local a=np.array({127,251,251,2,5},np.uint16)
  local b=np.array({1.0,-9.5,math.huge,(0/0),-math.huge},np.float64)
  local r=np.maximum(a,b)
  assert(r.dtype=='float64','maximum 448 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'maximum 448 shape')
  assert(seqeq(r.strides,{8}),'maximum 448 strides')
  assert(veq(r:tolist(),{127.0,251.0,math.huge,(0/0),5.0}),'maximum 448 values')
end
do -- maximum array 449
  local a=np.array({{2,1,0},{9,-127,-31}},np.int32)
  local b=np.array({3.75,11.0,-2.25},np.float32)
  local r=np.maximum(a,b)
  assert(r.dtype=='float64','maximum 449 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 449 shape')
  assert(seqeq(r.strides,{24,8}),'maximum 449 strides')
  assert(veq(r:tolist(),{{3.75,11.0,0.0},{9.0,11.0,-2.25}}),'maximum 449 values')
end
do -- maximum array 450
  local a=np.array({{{-127},{126},{63}},{{126},{0},{9}}},np.int16)
  local b=np.array({{{63,1,1,1},{63,63,2,2},{-31,-127,-7,126}}},np.int8)
  local r=np.maximum(a,b)
  assert(r.dtype=='int16','maximum 450 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'maximum 450 shape')
  assert(seqeq(r.strides,{24,8,2}),'maximum 450 strides')
  assert(veq(r:tolist(),{{{63,1,1,1},{126,126,126,126},{63,63,63,126}},{{126,126,126,126},{63,63,2,2},{9,9,9,126}}}),'maximum 450 values')
end
do -- maximum array 451
  local a=np.array({{0,2,5},{63,63,63}},np.uint32)
  local b=np.array({17,5,1},np.uint32)
  local r=np.maximum(a,b)
  assert(r.dtype=='uint32','maximum 451 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 451 shape')
  assert(seqeq(r.strides,{12,4}),'maximum 451 strides')
  assert(veq(r:tolist(),{{17,5,5},{63,63,63}}),'maximum 451 values')
end
do -- maximum array 452
  local a=np.array({{0},{1}},np.uint16)
  local b=np.array({{0,63,63}},np.int32)
  local r=np.maximum(a,b)
  assert(r.dtype=='int32','maximum 452 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 452 shape')
  assert(seqeq(r.strides,{12,4}),'maximum 452 strides')
  assert(veq(r:tolist(),{{0,63,63},{1,63,63}}),'maximum 452 values')
end
do -- maximum array 453
  local a=np.array({{63,-1,-7},{2,-7,-31}},np.int64)
  local b=np.array({1,0,17},np.uint8)
  local r=np.maximum(a,b)
  assert(r.dtype=='int64','maximum 453 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 453 shape')
  assert(seqeq(r.strides,{24,8}),'maximum 453 strides')
  assert(veq(r:tolist(),{{63,0,17},{2,0,17}}),'maximum 453 values')
end
do -- maximum array 454
  local a=np.array({{{17},{1},{17}},{{5},{251},{63}}},np.uint32)
  local b=np.array({{{-2.25,0.5,-0.0,11.0},{math.huge,math.huge,(0/0),(0/0)},{-math.huge,1.0,1.0,math.huge}}},np.float64)
  local r=np.maximum(a,b)
  assert(r.dtype=='float64','maximum 454 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'maximum 454 shape')
  assert(seqeq(r.strides,{96,32,8}),'maximum 454 strides')
  assert(veq(r:tolist(),{{{17.0,17.0,17.0,17.0},{math.huge,math.huge,(0/0),(0/0)},{17.0,17.0,17.0,math.huge}},{{5.0,5.0,5.0,11.0},{math.huge,math.huge,(0/0),(0/0)},{63.0,63.0,63.0,math.huge}}}),'maximum 454 values')
end
do -- maximum array 455
  local a=np.array({{17},{63}},np.uint32)
  local b=np.array({{-127,1,63}},np.int64)
  local r=np.maximum(a,b)
  assert(r.dtype=='int64','maximum 455 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 455 shape')
  assert(seqeq(r.strides,{24,8}),'maximum 455 strides')
  assert(veq(r:tolist(),{{17,17,63},{63,63,63}}),'maximum 455 values')
end
do -- maximum array 456
  local a=np.array({{-0.0},{-0.0}},np.float32)
  local b=np.array({{0,63,2}},np.uint32)
  local r=np.maximum(a,b)
  assert(r.dtype=='float64','maximum 456 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 456 shape')
  assert(seqeq(r.strides,{24,8}),'maximum 456 strides')
  assert(veq(r:tolist(),{{0.0,63.0,2.0},{0.0,63.0,2.0}}),'maximum 456 values')
end
do -- maximum array 457
  local a=np.array({{1.0},{1.0}},np.float16)
  local b=np.array({{(0/0),-9.5,-2.25}},np.float32)
  local r=np.maximum(a,b)
  assert(r.dtype=='float32','maximum 457 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 457 shape')
  assert(seqeq(r.strides,{12,4}),'maximum 457 strides')
  assert(veq(r:tolist(),{{(0/0),1.0,1.0},{(0/0),1.0,1.0}}),'maximum 457 values')
end
do -- maximum array 458
  local a=np.array({{false},{true}},np.bool)
  local b=np.array({{true,false,true}},np.bool)
  local r=np.maximum(a,b)
  assert(r.dtype=='bool','maximum 458 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 458 shape')
  assert(seqeq(r.strides,{3,1}),'maximum 458 strides')
  assert(veq(r:tolist(),{{true,false,true},{true,true,true}}),'maximum 458 values')
end
do -- maximum array 459
  local a=np.array({{0.0,1.0,-9.5},{-2.25,3.75,0.5}},np.float64)
  local b=np.array({-9.5,11.0,0.0},np.float16)
  local r=np.maximum(a,b)
  assert(r.dtype=='float64','maximum 459 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'maximum 459 shape')
  assert(seqeq(r.strides,{24,8}),'maximum 459 strides')
  assert(veq(r:tolist(),{{0.0,11.0,0.0},{-2.25,11.0,0.5}}),'maximum 459 values')
end
do -- minimum array 460
  local a=np.array({{2,1,2},{2,1,5}},np.uint64)
  local b=np.array({{11.0,3.75,-0.0}},np.float32)
  local r=np.minimum(a,b)
  assert(r.dtype=='float64','minimum 460 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 460 shape')
  assert(seqeq(r.strides,{24,8}),'minimum 460 strides')
  assert(veq(r:tolist(),{{2.0,1.0,-0.0},{2.0,1.0,-0.0}}),'minimum 460 values')
end
do -- minimum array 461
  local a=np.array({1,126,63,63,-1},np.int16)
  local b=np.array({1,127,0,5,2},np.uint64)
  local r=np.minimum(a,b)
  assert(r.dtype=='float64','minimum 461 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'minimum 461 shape')
  assert(seqeq(r.strides,{8}),'minimum 461 strides')
  assert(veq(r:tolist(),{1.0,126.0,0.0,5.0,-1.0}),'minimum 461 values')
end
do -- minimum array 462
  local a=np.array({{126},{63}},np.int16)
  local b=np.array({{127,17,63}},np.uint64)
  local r=np.minimum(a,b)
  assert(r.dtype=='float64','minimum 462 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 462 shape')
  assert(seqeq(r.strides,{24,8}),'minimum 462 strides')
  assert(veq(r:tolist(),{{126.0,17.0,63.0},{63.0,17.0,63.0}}),'minimum 462 values')
end
do -- minimum array 463
  local a=np.array({{{1},{0},{2}},{{127},{63},{17}}},np.uint16)
  local b=np.array({{{0.0,1.0,11.0,0.0},{0.0,0.0,math.huge,0.0},{(0/0),3.75,-1.0,11.0}}},np.float16)
  local r=np.minimum(a,b)
  assert(r.dtype=='float32','minimum 463 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'minimum 463 shape')
  assert(seqeq(r.strides,{48,16,4}),'minimum 463 strides')
  assert(veq(r:tolist(),{{{0.0,1.0,1.0,0.0},{0.0,0.0,0.0,0.0},{(0/0),2.0,-1.0,2.0}},{{0.0,1.0,11.0,0.0},{0.0,0.0,63.0,0.0},{(0/0),3.75,-1.0,11.0}}}),'minimum 463 values')
end
do -- minimum array 464
  local a=np.array({{63,-7,0},{-7,126,126}},np.int16)
  local b=np.array({17,1,1},np.uint32)
  local r=np.minimum(a,b)
  assert(r.dtype=='int64','minimum 464 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 464 shape')
  assert(seqeq(r.strides,{24,8}),'minimum 464 strides')
  assert(veq(r:tolist(),{{17,-7,0},{-7,1,1}}),'minimum 464 values')
end
do -- minimum array 465
  local a=np.array({{-0.0},{-9.5}},np.float32)
  local b=np.array({{5,251,1}},np.uint8)
  local r=np.minimum(a,b)
  assert(r.dtype=='float32','minimum 465 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 465 shape')
  assert(seqeq(r.strides,{12,4}),'minimum 465 strides')
  assert(veq(r:tolist(),{{-0.0,-0.0,-0.0},{-9.5,-9.5,-9.5}}),'minimum 465 values')
end
do -- minimum array 466
  local a=np.array({0,63,17,1,5},np.uint64)
  local b=np.array({2,2,63,1,1},np.uint32)
  local r=np.minimum(a,b)
  assert(r.dtype=='uint64','minimum 466 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'minimum 466 shape')
  assert(seqeq(r.strides,{8}),'minimum 466 strides')
  assert(veq(r:tolist(),{0,2,17,1,1}),'minimum 466 values')
end
do -- minimum array 467
  local a=np.array({{251,17,5},{127,5,17}},np.uint32)
  local b=np.array({9,2,63},np.int16)
  local r=np.minimum(a,b)
  assert(r.dtype=='int64','minimum 467 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 467 shape')
  assert(seqeq(r.strides,{24,8}),'minimum 467 strides')
  assert(veq(r:tolist(),{{9,2,5},{9,2,17}}),'minimum 467 values')
end
do -- minimum array 468
  local a=np.array({{{2},{9},{-7}},{{-31},{-31},{126}}},np.int32)
  local b=np.array({{{-2.25,-1.0,0.0,math.huge},{-0.0,3.75,0.0,-9.5},{-2.25,-9.5,0.5,(0/0)}}},np.float16)
  local r=np.minimum(a,b)
  assert(r.dtype=='float64','minimum 468 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'minimum 468 shape')
  assert(seqeq(r.strides,{96,32,8}),'minimum 468 strides')
  assert(veq(r:tolist(),{{{-2.25,-1.0,0.0,2.0},{-0.0,3.75,0.0,-9.5},{-7.0,-9.5,-7.0,(0/0)}},{{-31.0,-31.0,-31.0,-31.0},{-31.0,-31.0,-31.0,-31.0},{-2.25,-9.5,0.5,(0/0)}}}),'minimum 468 values')
end
do -- minimum array 469
  local a=np.array({-7,0,-1,63,1},np.int16)
  local b=np.array({0,9,-31,-127,126},np.int32)
  local r=np.minimum(a,b)
  assert(r.dtype=='int32','minimum 469 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'minimum 469 shape')
  assert(seqeq(r.strides,{4}),'minimum 469 strides')
  assert(veq(r:tolist(),{-7,0,-31,-127,1}),'minimum 469 values')
end
do -- minimum array 470
  local a=np.array({{17,0,251},{0,0,17}},np.uint8)
  local b=np.array({251,1,5},np.uint32)
  local r=np.minimum(a,b)
  assert(r.dtype=='uint32','minimum 470 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 470 shape')
  assert(seqeq(r.strides,{12,4}),'minimum 470 strides')
  assert(veq(r:tolist(),{{17,0,5},{0,0,5}}),'minimum 470 values')
end
do -- minimum array 471
  local a=np.array({{0.0,-2.25,0.0},{-2.25,-math.huge,-9.5}},np.float32)
  local b=np.array({-2.25,1.0,1.0},np.float32)
  local r=np.minimum(a,b)
  assert(r.dtype=='float32','minimum 471 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 471 shape')
  assert(seqeq(r.strides,{12,4}),'minimum 471 strides')
  assert(veq(r:tolist(),{{-2.25,-2.25,0.0},{-2.25,-math.huge,-9.5}}),'minimum 471 values')
end
do -- minimum array 472
  local a=np.array({{0},{1}},np.int32)
  local b=np.array({{-1,-127,-31}},np.int32)
  local r=np.minimum(a,b)
  assert(r.dtype=='int32','minimum 472 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 472 shape')
  assert(seqeq(r.strides,{12,4}),'minimum 472 strides')
  assert(veq(r:tolist(),{{-1,-127,-31},{-1,-127,-31}}),'minimum 472 values')
end
do -- minimum array 473
  local a=np.array({0,251,251,17,127},np.uint8)
  local b=np.array({(0/0),0.5,0.5,3.75,-math.huge},np.float64)
  local r=np.minimum(a,b)
  assert(r.dtype=='float64','minimum 473 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'minimum 473 shape')
  assert(seqeq(r.strides,{8}),'minimum 473 strides')
  assert(veq(r:tolist(),{(0/0),0.5,0.5,3.75,-math.huge}),'minimum 473 values')
end
do -- minimum array 474
  local a=np.array({{-1.0,-1.0,0.0},{3.75,1.0,1.0}},np.float32)
  local b=np.array({{-1,-31,0}},np.int8)
  local r=np.minimum(a,b)
  assert(r.dtype=='float32','minimum 474 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 474 shape')
  assert(seqeq(r.strides,{12,4}),'minimum 474 strides')
  assert(veq(r:tolist(),{{-1.0,-31.0,0.0},{-1.0,-31.0,0.0}}),'minimum 474 values')
end
do -- minimum array 475
  local a=np.array({{127,127,2},{2,2,5}},np.uint16)
  local b=np.array({{-127,-127,-1}},np.int8)
  local r=np.minimum(a,b)
  assert(r.dtype=='int32','minimum 475 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 475 shape')
  assert(seqeq(r.strides,{12,4}),'minimum 475 strides')
  assert(veq(r:tolist(),{{-127,-127,-1},{-127,-127,-1}}),'minimum 475 values')
end
do -- minimum array 476
  local a=np.array({{126,1,-127},{63,-127,9}},np.int16)
  local b=np.array({{2,0,2}},np.uint8)
  local r=np.minimum(a,b)
  assert(r.dtype=='int16','minimum 476 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 476 shape')
  assert(seqeq(r.strides,{6,2}),'minimum 476 strides')
  assert(veq(r:tolist(),{{2,0,-127},{2,-127,2}}),'minimum 476 values')
end
do -- minimum array 477
  local a=np.array({3.75,0.0,math.huge,11.0,(0/0)},np.float64)
  local b=np.array({1,-7,63,-127,126},np.int8)
  local r=np.minimum(a,b)
  assert(r.dtype=='float64','minimum 477 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'minimum 477 shape')
  assert(seqeq(r.strides,{8}),'minimum 477 strides')
  assert(veq(r:tolist(),{1.0,-7.0,63.0,-127.0,(0/0)}),'minimum 477 values')
end
do -- minimum array 478
  local a=np.array({{{true},{true},{true}},{{true},{true},{false}}},np.bool)
  local b=np.array({{{5,5,1,17},{5,17,2,0},{127,63,63,251}}},np.uint32)
  local r=np.minimum(a,b)
  assert(r.dtype=='uint32','minimum 478 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'minimum 478 shape')
  assert(seqeq(r.strides,{48,16,4}),'minimum 478 strides')
  assert(veq(r:tolist(),{{{1,1,1,1},{1,1,1,0},{1,1,1,1}},{{1,1,1,1},{1,1,1,0},{0,0,0,0}}}),'minimum 478 values')
end
do -- minimum array 479
  local a=np.array({{-31,9,126},{0,0,63}},np.int32)
  local b=np.array({{false,true,false}},np.bool)
  local r=np.minimum(a,b)
  assert(r.dtype=='int32','minimum 479 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 479 shape')
  assert(seqeq(r.strides,{12,4}),'minimum 479 strides')
  assert(veq(r:tolist(),{{-31,1,0},{0,0,0}}),'minimum 479 values')
end
do -- minimum array 480
  local a=np.array({{0,0,63},{2,127,17}},np.uint8)
  local b=np.array({0.5,1.0,-math.huge},np.float16)
  local r=np.minimum(a,b)
  assert(r.dtype=='float16','minimum 480 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 480 shape')
  assert(seqeq(r.strides,{6,2}),'minimum 480 strides')
  assert(veq(r:tolist(),{{0.0,0.0,-math.huge},{0.5,1.0,-math.huge}}),'minimum 480 values')
end
do -- minimum array 481
  local a=np.array({{2},{0}},np.uint8)
  local b=np.array({{-31,-7,-31}},np.int16)
  local r=np.minimum(a,b)
  assert(r.dtype=='int16','minimum 481 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 481 shape')
  assert(seqeq(r.strides,{6,2}),'minimum 481 strides')
  assert(veq(r:tolist(),{{-31,-7,-31},{-31,-7,-31}}),'minimum 481 values')
end
do -- minimum array 482
  local a=np.array({251,17,251,0,63},np.uint16)
  local b=np.array({63,-127,126,1,126},np.int32)
  local r=np.minimum(a,b)
  assert(r.dtype=='int32','minimum 482 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'minimum 482 shape')
  assert(seqeq(r.strides,{4}),'minimum 482 strides')
  assert(veq(r:tolist(),{63,-127,126,0,63}),'minimum 482 values')
end
do -- minimum array 483
  local a=np.array({{251,5,17},{5,0,63}},np.uint8)
  local b=np.array({(0/0),-9.5,1.0},np.float32)
  local r=np.minimum(a,b)
  assert(r.dtype=='float32','minimum 483 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 483 shape')
  assert(seqeq(r.strides,{12,4}),'minimum 483 strides')
  assert(veq(r:tolist(),{{(0/0),-9.5,1.0},{(0/0),-9.5,1.0}}),'minimum 483 values')
end
do -- minimum array 484
  local a=np.array({{126},{-7}},np.int8)
  local b=np.array({{9,-31,-1}},np.int32)
  local r=np.minimum(a,b)
  assert(r.dtype=='int32','minimum 484 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 484 shape')
  assert(seqeq(r.strides,{12,4}),'minimum 484 strides')
  assert(veq(r:tolist(),{{9,-31,-1},{-7,-31,-7}}),'minimum 484 values')
end
do -- minimum array 485
  local a=np.array({{-127,63,9},{-1,63,-31}},np.int64)
  local b=np.array({63,-1,9},np.int16)
  local r=np.minimum(a,b)
  assert(r.dtype=='int64','minimum 485 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 485 shape')
  assert(seqeq(r.strides,{24,8}),'minimum 485 strides')
  assert(veq(r:tolist(),{{-127,-1,9},{-1,-1,-31}}),'minimum 485 values')
end
do -- minimum array 486
  local a=np.array({{{1},{1},{17}},{{0},{2},{63}}},np.uint8)
  local b=np.array({{{-127,2,-7,9},{9,-7,126,-31},{-31,-7,63,126}}},np.int16)
  local r=np.minimum(a,b)
  assert(r.dtype=='int16','minimum 486 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'minimum 486 shape')
  assert(seqeq(r.strides,{24,8,2}),'minimum 486 strides')
  assert(veq(r:tolist(),{{{-127,1,-7,1},{1,-7,1,-31},{-31,-7,17,17}},{{-127,0,-7,0},{2,-7,2,-31},{-31,-7,63,63}}}),'minimum 486 values')
end
do -- minimum array 487
  local a=np.array({{true,true,false},{true,true,true}},np.bool)
  local b=np.array({{-31,9,2}},np.int8)
  local r=np.minimum(a,b)
  assert(r.dtype=='int8','minimum 487 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 487 shape')
  assert(seqeq(r.strides,{3,1}),'minimum 487 strides')
  assert(veq(r:tolist(),{{-31,1,0},{-31,1,1}}),'minimum 487 values')
end
do -- minimum array 488
  local a=np.array({{-1,126,63},{126,-31,-127}},np.int32)
  local b=np.array({2,126,1},np.int16)
  local r=np.minimum(a,b)
  assert(r.dtype=='int32','minimum 488 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 488 shape')
  assert(seqeq(r.strides,{12,4}),'minimum 488 strides')
  assert(veq(r:tolist(),{{-1,126,1},{2,-31,-127}}),'minimum 488 values')
end
do -- minimum array 489
  local a=np.array({{-0.0,1.0,-1.0},{-math.huge,-0.0,-1.0}},np.float16)
  local b=np.array({0.5,-1.0,-2.25},np.float64)
  local r=np.minimum(a,b)
  assert(r.dtype=='float64','minimum 489 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 489 shape')
  assert(seqeq(r.strides,{24,8}),'minimum 489 strides')
  assert(veq(r:tolist(),{{-0.0,-1.0,-2.25},{-math.huge,-1.0,-2.25}}),'minimum 489 values')
end
do -- minimum array 490
  local a=np.array({{-1.0},{-0.0}},np.float16)
  local b=np.array({{0,63,1}},np.uint32)
  local r=np.minimum(a,b)
  assert(r.dtype=='float64','minimum 490 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 490 shape')
  assert(seqeq(r.strides,{24,8}),'minimum 490 strides')
  assert(veq(r:tolist(),{{-1.0,-1.0,-1.0},{0.0,-0.0,-0.0}}),'minimum 490 values')
end
do -- minimum array 491
  local a=np.array({{{1},{2},{-7}},{{-31},{-7},{126}}},np.int16)
  local b=np.array({{{math.huge,-math.huge,0.5,1.0},{-math.huge,-9.5,-2.25,-2.25},{-2.25,3.75,11.0,-2.25}}},np.float16)
  local r=np.minimum(a,b)
  assert(r.dtype=='float32','minimum 491 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'minimum 491 shape')
  assert(seqeq(r.strides,{48,16,4}),'minimum 491 strides')
  assert(veq(r:tolist(),{{{1.0,-math.huge,0.5,1.0},{-math.huge,-9.5,-2.25,-2.25},{-7.0,-7.0,-7.0,-7.0}},{{-31.0,-math.huge,-31.0,-31.0},{-math.huge,-9.5,-7.0,-7.0},{-2.25,3.75,11.0,-2.25}}}),'minimum 491 values')
end
do -- minimum array 492
  local a=np.array({{17},{2}},np.uint32)
  local b=np.array({{-31,1,63}},np.int16)
  local r=np.minimum(a,b)
  assert(r.dtype=='int64','minimum 492 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 492 shape')
  assert(seqeq(r.strides,{24,8}),'minimum 492 strides')
  assert(veq(r:tolist(),{{-31,1,17},{-31,1,2}}),'minimum 492 values')
end
do -- minimum array 493
  local a=np.array({{{0},{251},{251}},{{1},{17},{2}}},np.uint32)
  local b=np.array({{{17,5,1,1},{0,5,251,17},{251,5,5,251}}},np.uint8)
  local r=np.minimum(a,b)
  assert(r.dtype=='uint32','minimum 493 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'minimum 493 shape')
  assert(seqeq(r.strides,{48,16,4}),'minimum 493 strides')
  assert(veq(r:tolist(),{{{0,0,0,0},{0,5,251,17},{251,5,5,251}},{{1,1,1,1},{0,5,17,17},{2,2,2,2}}}),'minimum 493 values')
end
do -- minimum array 494
  local a=np.array({{false,false,true},{false,true,true}},np.bool)
  local b=np.array({{1,0,251}},np.uint32)
  local r=np.minimum(a,b)
  assert(r.dtype=='uint32','minimum 494 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 494 shape')
  assert(seqeq(r.strides,{12,4}),'minimum 494 strides')
  assert(veq(r:tolist(),{{0,0,1},{0,0,1}}),'minimum 494 values')
end
do -- minimum array 495
  local a=np.array({{0,127,63},{63,251,0}},np.uint64)
  local b=np.array({{9,-31,2}},np.int64)
  local r=np.minimum(a,b)
  assert(r.dtype=='float64','minimum 495 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 495 shape')
  assert(seqeq(r.strides,{24,8}),'minimum 495 strides')
  assert(veq(r:tolist(),{{0.0,-31.0,2.0},{9.0,-31.0,0.0}}),'minimum 495 values')
end
do -- minimum array 496
  local a=np.array({1,-1,-31,-1,63},np.int8)
  local b=np.array({0,63,63,251,2},np.uint16)
  local r=np.minimum(a,b)
  assert(r.dtype=='int32','minimum 496 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'minimum 496 shape')
  assert(seqeq(r.strides,{4}),'minimum 496 strides')
  assert(veq(r:tolist(),{0,-1,-31,-1,2}),'minimum 496 values')
end
do -- minimum array 497
  local a=np.array({251,5,127,1,0},np.uint16)
  local b=np.array({63,1,0,251,63},np.uint16)
  local r=np.minimum(a,b)
  assert(r.dtype=='uint16','minimum 497 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'minimum 497 shape')
  assert(seqeq(r.strides,{2}),'minimum 497 strides')
  assert(veq(r:tolist(),{63,1,0,1,0}),'minimum 497 values')
end
do -- minimum array 498
  local a=np.array({3.75,-0.0,0.0,math.huge,11.0},np.float16)
  local b=np.array({-0.0,-0.0,3.75,-1.0,-2.25},np.float16)
  local r=np.minimum(a,b)
  assert(r.dtype=='float16','minimum 498 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'minimum 498 shape')
  assert(seqeq(r.strides,{2}),'minimum 498 strides')
  assert(veq(r:tolist(),{-0.0,-0.0,0.0,-1.0,-2.25}),'minimum 498 values')
end
do -- minimum array 499
  local a=np.array({{0.5,-math.huge,-0.0},{11.0,-1.0,-2.25}},np.float32)
  local b=np.array({{126,-7,-1}},np.int64)
  local r=np.minimum(a,b)
  assert(r.dtype=='float64','minimum 499 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 499 shape')
  assert(seqeq(r.strides,{24,8}),'minimum 499 strides')
  assert(veq(r:tolist(),{{0.5,-math.huge,-1.0},{11.0,-7.0,-2.25}}),'minimum 499 values')
end
do -- minimum array 500
  local a=np.array({-7,1,2,2,-127},np.int16)
  local b=np.array({0,17,5,17,0},np.uint32)
  local r=np.minimum(a,b)
  assert(r.dtype=='int64','minimum 500 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'minimum 500 shape')
  assert(seqeq(r.strides,{8}),'minimum 500 strides')
  assert(veq(r:tolist(),{-7,1,2,2,-127}),'minimum 500 values')
end
do -- minimum array 501
  local a=np.array({{2,127,251},{63,5,2}},np.uint64)
  local b=np.array({251,1,1},np.uint32)
  local r=np.minimum(a,b)
  assert(r.dtype=='uint64','minimum 501 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 501 shape')
  assert(seqeq(r.strides,{24,8}),'minimum 501 strides')
  assert(veq(r:tolist(),{{2,1,1},{63,1,1}}),'minimum 501 values')
end
do -- minimum array 502
  local a=np.array({{{3.75},{math.huge},{0.5}},{{0.0},{-2.25},{0.5}}},np.float16)
  local b=np.array({{{-127,63,2,63},{-7,1,2,1},{-1,0,63,126}}},np.int32)
  local r=np.minimum(a,b)
  assert(r.dtype=='float64','minimum 502 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'minimum 502 shape')
  assert(seqeq(r.strides,{96,32,8}),'minimum 502 strides')
  assert(veq(r:tolist(),{{{-127.0,3.75,2.0,3.75},{-7.0,1.0,2.0,1.0},{-1.0,0.0,0.5,0.5}},{{-127.0,0.0,0.0,0.0},{-7.0,-2.25,-2.25,-2.25},{-1.0,0.0,0.5,0.5}}}),'minimum 502 values')
end
do -- minimum array 503
  local a=np.array({2,126,1,0,-127},np.int64)
  local b=np.array({63,126,-127,9,9},np.int16)
  local r=np.minimum(a,b)
  assert(r.dtype=='int64','minimum 503 dtype '..r.dtype)
  assert(seqeq(r.shape,{5}),'minimum 503 shape')
  assert(seqeq(r.strides,{8}),'minimum 503 strides')
  assert(veq(r:tolist(),{2,126,-127,0,-127}),'minimum 503 values')
end
do -- minimum array 504
  local a=np.array({{{63},{1},{-1}},{{9},{126},{-127}}},np.int8)
  local b=np.array({{{-127,-31,-127,2},{-7,1,9,-127},{-127,9,-1,-1}}},np.int32)
  local r=np.minimum(a,b)
  assert(r.dtype=='int32','minimum 504 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'minimum 504 shape')
  assert(seqeq(r.strides,{48,16,4}),'minimum 504 strides')
  assert(veq(r:tolist(),{{{-127,-31,-127,2},{-7,1,1,-127},{-127,-1,-1,-1}},{{-127,-31,-127,2},{-7,1,9,-127},{-127,-127,-127,-127}}}),'minimum 504 values')
end
do -- minimum array 505
  local a=np.array({{1.0},{0.0}},np.float32)
  local b=np.array({{17,127,251}},np.uint64)
  local r=np.minimum(a,b)
  assert(r.dtype=='float64','minimum 505 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 505 shape')
  assert(seqeq(r.strides,{24,8}),'minimum 505 strides')
  assert(veq(r:tolist(),{{1.0,1.0,1.0},{0.0,0.0,0.0}}),'minimum 505 values')
end
do -- minimum array 506
  local a=np.array({{{0},{2},{17}},{{127},{63},{1}}},np.uint64)
  local b=np.array({{{-7,-31,1,2},{-127,-127,126,126},{-31,0,-7,126}}},np.int32)
  local r=np.minimum(a,b)
  assert(r.dtype=='float64','minimum 506 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'minimum 506 shape')
  assert(seqeq(r.strides,{96,32,8}),'minimum 506 strides')
  assert(veq(r:tolist(),{{{-7.0,-31.0,0.0,0.0},{-127.0,-127.0,2.0,2.0},{-31.0,0.0,-7.0,17.0}},{{-7.0,-31.0,1.0,2.0},{-127.0,-127.0,63.0,63.0},{-31.0,0.0,-7.0,1.0}}}),'minimum 506 values')
end
do -- minimum array 507
  local a=np.array({{127,1,17},{2,63,5}},np.uint16)
  local b=np.array({{-1.0,-1.0,-0.0}},np.float16)
  local r=np.minimum(a,b)
  assert(r.dtype=='float32','minimum 507 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 507 shape')
  assert(seqeq(r.strides,{12,4}),'minimum 507 strides')
  assert(veq(r:tolist(),{{-1.0,-1.0,-0.0},{-1.0,-1.0,-0.0}}),'minimum 507 values')
end
do -- minimum array 508
  local a=np.array({{63,2,2},{251,17,17}},np.uint16)
  local b=np.array({0,126,2},np.int16)
  local r=np.minimum(a,b)
  assert(r.dtype=='int32','minimum 508 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 508 shape')
  assert(seqeq(r.strides,{12,4}),'minimum 508 strides')
  assert(veq(r:tolist(),{{0,2,2},{0,17,2}}),'minimum 508 values')
end
do -- minimum array 509
  local a=np.array({{0.0,-1.0,-2.25},{0.0,math.huge,1.0}},np.float32)
  local b=np.array({{63,127,2}},np.uint16)
  local r=np.minimum(a,b)
  assert(r.dtype=='float32','minimum 509 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 509 shape')
  assert(seqeq(r.strides,{12,4}),'minimum 509 strides')
  assert(veq(r:tolist(),{{0.0,-1.0,-2.25},{0.0,127.0,1.0}}),'minimum 509 values')
end
do -- minimum array 510
  local a=np.array({{-1.0},{(0/0)}},np.float64)
  local b=np.array({{251,251,0}},np.uint32)
  local r=np.minimum(a,b)
  assert(r.dtype=='float64','minimum 510 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 510 shape')
  assert(seqeq(r.strides,{24,8}),'minimum 510 strides')
  assert(veq(r:tolist(),{{-1.0,-1.0,-1.0},{(0/0),(0/0),(0/0)}}),'minimum 510 values')
end
do -- minimum array 511
  local a=np.array({{{127},{17},{1}},{{1},{5},{1}}},np.uint16)
  local b=np.array({{{1,127,127,2},{63,5,251,2},{127,251,5,0}}},np.uint16)
  local r=np.minimum(a,b)
  assert(r.dtype=='uint16','minimum 511 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'minimum 511 shape')
  assert(seqeq(r.strides,{24,8,2}),'minimum 511 strides')
  assert(veq(r:tolist(),{{{1,127,127,2},{17,5,17,2},{1,1,1,0}},{{1,1,1,1},{5,5,5,2},{1,1,1,0}}}),'minimum 511 values')
end
do -- minimum array 512
  local a=np.array({{-1.0,-9.5,-9.5},{math.huge,math.huge,-2.25}},np.float32)
  local b=np.array({-1.0,-2.25,0.5},np.float64)
  local r=np.minimum(a,b)
  assert(r.dtype=='float64','minimum 512 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 512 shape')
  assert(seqeq(r.strides,{24,8}),'minimum 512 strides')
  assert(veq(r:tolist(),{{-1.0,-9.5,-9.5},{-1.0,-2.25,-2.25}}),'minimum 512 values')
end
do -- minimum array 513
  local a=np.array({{2},{126}},np.int64)
  local b=np.array({{3.75,1.0,(0/0)}},np.float64)
  local r=np.minimum(a,b)
  assert(r.dtype=='float64','minimum 513 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 513 shape')
  assert(seqeq(r.strides,{24,8}),'minimum 513 strides')
  assert(veq(r:tolist(),{{2.0,1.0,(0/0)},{3.75,1.0,(0/0)}}),'minimum 513 values')
end
do -- minimum array 514
  local a=np.array({{17},{63}},np.uint64)
  local b=np.array({{-0.0,11.0,3.75}},np.float16)
  local r=np.minimum(a,b)
  assert(r.dtype=='float64','minimum 514 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'minimum 514 shape')
  assert(seqeq(r.strides,{24,8}),'minimum 514 strides')
  assert(veq(r:tolist(),{{-0.0,11.0,3.75},{-0.0,11.0,3.75}}),'minimum 514 values')
end
do -- equal scalar 0
  local a=np.array({0,9,2,126,1},np.int16)
  local r=np.equal(a,2.25)
  assert(r.dtype=='bool','scalar 0 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 0 values')
end
do -- equal scalar 1
  local a=np.array({63,1,17,17,0},np.uint32)
  local r=np.equal(127,a)
  assert(r.dtype=='bool','scalar 1 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 1 values')
end
do -- equal scalar 2
  local a=np.array({-127,1,-1,-1,1},np.int16)
  local r=np.equal(a,0.5)
  assert(r.dtype=='bool','scalar 2 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 2 values')
end
do -- equal scalar 3
  local a=np.array({9,0,2,1,1},np.int8)
  local r=np.equal(a,1)
  assert(r.dtype=='bool','scalar 3 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,true,true}),'scalar 3 values')
end
do -- equal scalar 4
  local a=np.array({11.0,11.0,-0.0,-1.0,-2.25},np.float32)
  local r=np.equal(a,10000000000.0)
  assert(r.dtype=='bool','scalar 4 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 4 values')
end
do -- equal scalar 5
  local a=np.array({251,0,1,1,63},np.uint16)
  local r=np.equal(a,0.5)
  assert(r.dtype=='bool','scalar 5 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 5 values')
end
do -- equal scalar 6
  local a=np.array({2,0,0,63,127},np.uint32)
  local r=np.equal(a,127)
  assert(r.dtype=='bool','scalar 6 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,true}),'scalar 6 values')
end
do -- equal scalar 7
  local a=np.array({1.0,-math.huge,11.0,-9.5,-2.25},np.float64)
  local r=np.equal(2.25,a)
  assert(r.dtype=='bool','scalar 7 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 7 values')
end
do -- equal scalar 8
  local a=np.array({5,5,5,5,63},np.uint16)
  local r=np.equal(a,0)
  assert(r.dtype=='bool','scalar 8 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 8 values')
end
do -- equal scalar 9
  local a=np.array({17,1,63,17,5},np.uint16)
  local r=np.equal(a,0.5)
  assert(r.dtype=='bool','scalar 9 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 9 values')
end
do -- equal scalar 10
  local a=np.array({false,true,true,false,false},np.bool)
  local r=np.equal(-300,a)
  assert(r.dtype=='bool','scalar 10 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 10 values')
end
do -- equal scalar 11
  local a=np.array({true,false,true,false,true},np.bool)
  local r=np.equal(a,-3.5)
  assert(r.dtype=='bool','scalar 11 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 11 values')
end
do -- equal scalar 12
  local a=np.array({-31,-31,0,9,0},np.int8)
  local r=np.equal(a,127)
  assert(r.dtype=='bool','scalar 12 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 12 values')
end
do -- equal scalar 13
  local a=np.array({0,1,-1,63,-7},np.int32)
  local r=np.equal(1,a)
  assert(r.dtype=='bool','scalar 13 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,false,false,false}),'scalar 13 values')
end
do -- equal scalar 14
  local a=np.array({63,1,-127,2,9},np.int16)
  local r=np.equal(a,200)
  assert(r.dtype=='bool','scalar 14 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 14 values')
end
do -- equal scalar 15
  local a=np.array({63,63,-127,0,-31},np.int8)
  local r=np.equal(10000000000.0,a)
  assert(r.dtype=='bool','scalar 15 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 15 values')
end
do -- equal scalar 16
  local a=np.array({127,17,2,0,2},np.uint64)
  local r=np.equal(128,a)
  assert(r.dtype=='bool','scalar 16 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 16 values')
end
do -- equal scalar 17
  local a=np.array({63,9,2,-127,2},np.int64)
  local r=np.equal(a,127)
  assert(r.dtype=='bool','scalar 17 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 17 values')
end
do -- equal scalar 18
  local a=np.array({251,63,17,17,17},np.uint8)
  local r=np.equal(-300,a)
  assert(r.dtype=='bool','scalar 18 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 18 values')
end
do -- equal scalar 19
  local a=np.array({true,true,false,false,true},np.bool)
  local r=np.equal(a,2.25)
  assert(r.dtype=='bool','scalar 19 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 19 values')
end
do -- equal scalar 20
  local a=np.array({126,-127,-7,-31,1},np.int32)
  local r=np.equal(-1,a)
  assert(r.dtype=='bool','scalar 20 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 20 values')
end
do -- equal scalar 21
  local a=np.array({0,-1,63,2,-31},np.int64)
  local r=np.equal(a,-300)
  assert(r.dtype=='bool','scalar 21 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 21 values')
end
do -- equal scalar 22
  local a=np.array({1,2,0,-127,-127},np.int16)
  local r=np.equal(a,0)
  assert(r.dtype=='bool','scalar 22 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,true,false,false}),'scalar 22 values')
end
do -- equal scalar 23
  local a=np.array({1.0,math.huge,-9.5,-2.25,-math.huge},np.float32)
  local r=np.equal(a,128)
  assert(r.dtype=='bool','scalar 23 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 23 values')
end
do -- equal scalar 24
  local a=np.array({-127,0,-127,0,63},np.int16)
  local r=np.equal(2.25,a)
  assert(r.dtype=='bool','scalar 24 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 24 values')
end
do -- equal scalar 25
  local a=np.array({63,0,63,1,251},np.uint64)
  local r=np.equal(-1,a)
  assert(r.dtype=='bool','scalar 25 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 25 values')
end
do -- not_equal scalar 26
  local a=np.array({0.5,-9.5,-0.0,-1.0,-2.25},np.float64)
  local r=np.not_equal(a,-129)
  assert(r.dtype=='bool','scalar 26 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 26 values')
end
do -- not_equal scalar 27
  local a=np.array({2,0,17,1,63},np.uint64)
  local r=np.not_equal(-300,a)
  assert(r.dtype=='bool','scalar 27 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 27 values')
end
do -- not_equal scalar 28
  local a=np.array({-31,-1,-7,0,0},np.int8)
  local r=np.not_equal(a,200)
  assert(r.dtype=='bool','scalar 28 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 28 values')
end
do -- not_equal scalar 29
  local a=np.array({127,2,0,127,17},np.uint64)
  local r=np.not_equal(0,a)
  assert(r.dtype=='bool','scalar 29 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,false,true,true}),'scalar 29 values')
end
do -- not_equal scalar 30
  local a=np.array({1,251,1,5,63},np.uint16)
  local r=np.not_equal(a,200)
  assert(r.dtype=='bool','scalar 30 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 30 values')
end
do -- not_equal scalar 31
  local a=np.array({1,17,251,0,251},np.uint64)
  local r=np.not_equal(a,10000000000.0)
  assert(r.dtype=='bool','scalar 31 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 31 values')
end
do -- not_equal scalar 32
  local a=np.array({false,true,true,false,true},np.bool)
  local r=np.not_equal(10000000000.0,a)
  assert(r.dtype=='bool','scalar 32 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 32 values')
end
do -- not_equal scalar 33
  local a=np.array({0,2,1,1,0},np.uint32)
  local r=np.not_equal(a,2.25)
  assert(r.dtype=='bool','scalar 33 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 33 values')
end
do -- not_equal scalar 34
  local a=np.array({9,-1,1,2,0},np.int32)
  local r=np.not_equal(a,-300)
  assert(r.dtype=='bool','scalar 34 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 34 values')
end
do -- not_equal scalar 35
  local a=np.array({-127,63,-7,1,1},np.int32)
  local r=np.not_equal(127,a)
  assert(r.dtype=='bool','scalar 35 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 35 values')
end
do -- not_equal scalar 36
  local a=np.array({0,251,5,2,2},np.uint16)
  local r=np.not_equal(-1,a)
  assert(r.dtype=='bool','scalar 36 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 36 values')
end
do -- not_equal scalar 37
  local a=np.array({1,126,-127,1,1},np.int8)
  local r=np.not_equal(2.25,a)
  assert(r.dtype=='bool','scalar 37 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 37 values')
end
do -- not_equal scalar 38
  local a=np.array({false,true,false,true,false},np.bool)
  local r=np.not_equal(a,200)
  assert(r.dtype=='bool','scalar 38 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 38 values')
end
do -- not_equal scalar 39
  local a=np.array({5,5,2,2,0},np.uint16)
  local r=np.not_equal(-300,a)
  assert(r.dtype=='bool','scalar 39 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 39 values')
end
do -- not_equal scalar 40
  local a=np.array({2,5,0,127,251},np.uint64)
  local r=np.not_equal(-129,a)
  assert(r.dtype=='bool','scalar 40 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 40 values')
end
do -- not_equal scalar 41
  local a=np.array({0.0,-9.5,-0.0,1.0,-2.25},np.float32)
  local r=np.not_equal(a,0)
  assert(r.dtype=='bool','scalar 41 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,false,true,true}),'scalar 41 values')
end
do -- not_equal scalar 42
  local a=np.array({1,-1,-31,0,0},np.int16)
  local r=np.not_equal(128,a)
  assert(r.dtype=='bool','scalar 42 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 42 values')
end
do -- not_equal scalar 43
  local a=np.array({-31,-31,1,-1,-7},np.int16)
  local r=np.not_equal(a,-300)
  assert(r.dtype=='bool','scalar 43 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 43 values')
end
do -- not_equal scalar 44
  local a=np.array({127,127,5,2,17},np.uint16)
  local r=np.not_equal(a,2.25)
  assert(r.dtype=='bool','scalar 44 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 44 values')
end
do -- not_equal scalar 45
  local a=np.array({false,true,true,false,true},np.bool)
  local r=np.not_equal(10000000000.0,a)
  assert(r.dtype=='bool','scalar 45 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 45 values')
end
do -- not_equal scalar 46
  local a=np.array({0.5,11.0,1.0,11.0,-9.5},np.float32)
  local r=np.not_equal(a,300)
  assert(r.dtype=='bool','scalar 46 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 46 values')
end
do -- not_equal scalar 47
  local a=np.array({2,0,0,1,1},np.uint16)
  local r=np.not_equal(a,1)
  assert(r.dtype=='bool','scalar 47 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,false,false}),'scalar 47 values')
end
do -- not_equal scalar 48
  local a=np.array({1,1,2,5,127},np.uint8)
  local r=np.not_equal(1,a)
  assert(r.dtype=='bool','scalar 48 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,true,true,true}),'scalar 48 values')
end
do -- not_equal scalar 49
  local a=np.array({251,127,5,0,0},np.uint64)
  local r=np.not_equal(a,1)
  assert(r.dtype=='bool','scalar 49 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 49 values')
end
do -- not_equal scalar 50
  local a=np.array({126,63,-127,-7,1},np.int8)
  local r=np.not_equal(300,a)
  assert(r.dtype=='bool','scalar 50 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 50 values')
end
do -- not_equal scalar 51
  local a=np.array({-7,-31,-7,-7,-7},np.int32)
  local r=np.not_equal(a,200)
  assert(r.dtype=='bool','scalar 51 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 51 values')
end
do -- less scalar 52
  local a=np.array({1,2,-31,-1,-31},np.int16)
  local r=np.less(a,2.25)
  assert(r.dtype=='bool','scalar 52 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 52 values')
end
do -- less scalar 53
  local a=np.array({-31,126,9,2,-31},np.int64)
  local r=np.less(a,127)
  assert(r.dtype=='bool','scalar 53 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 53 values')
end
do -- less scalar 54
  local a=np.array({0.5,0.5,0.0,math.huge,-1.0},np.float16)
  local r=np.less(a,200)
  assert(r.dtype=='bool','scalar 54 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,false,true}),'scalar 54 values')
end
do -- less scalar 55
  local a=np.array({126,0,1,2,126},np.int16)
  local r=np.less(a,2.25)
  assert(r.dtype=='bool','scalar 55 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,true,true,false}),'scalar 55 values')
end
do -- less scalar 56
  local a=np.array({17,251,0,63,1},np.uint16)
  local r=np.less(0,a)
  assert(r.dtype=='bool','scalar 56 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,false,true,true}),'scalar 56 values')
end
do -- less scalar 57
  local a=np.array({-127,63,-1,-1,2},np.int32)
  local r=np.less(2.25,a)
  assert(r.dtype=='bool','scalar 57 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,false,false,false}),'scalar 57 values')
end
do -- less scalar 58
  local a=np.array({63,9,-7,-7,-127},np.int64)
  local r=np.less(-300,a)
  assert(r.dtype=='bool','scalar 58 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 58 values')
end
do -- less scalar 59
  local a=np.array({2,0,63,2,1},np.uint64)
  local r=np.less(10000000000.0,a)
  assert(r.dtype=='bool','scalar 59 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 59 values')
end
do -- less scalar 60
  local a=np.array({0.0,1.0,-math.huge,-9.5,math.huge},np.float32)
  local r=np.less(2.25,a)
  assert(r.dtype=='bool','scalar 60 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,true}),'scalar 60 values')
end
do -- less scalar 61
  local a=np.array({-1,-31,126,63,63},np.int8)
  local r=np.less(0,a)
  assert(r.dtype=='bool','scalar 61 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,true,true,true}),'scalar 61 values')
end
do -- less scalar 62
  local a=np.array({63,-127,1,-127,0},np.int8)
  local r=np.less(a,-3.5)
  assert(r.dtype=='bool','scalar 62 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,false,true,false}),'scalar 62 values')
end
do -- less scalar 63
  local a=np.array({127,17,251,1,17},np.uint32)
  local r=np.less(2.25,a)
  assert(r.dtype=='bool','scalar 63 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,false,true}),'scalar 63 values')
end
do -- less scalar 64
  local a=np.array({127,127,17,127,127},np.uint32)
  local r=np.less(a,300)
  assert(r.dtype=='bool','scalar 64 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 64 values')
end
do -- less scalar 65
  local a=np.array({false,false,false,true,true},np.bool)
  local r=np.less(2.25,a)
  assert(r.dtype=='bool','scalar 65 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 65 values')
end
do -- less scalar 66
  local a=np.array({3.75,(0/0),11.0,0.5,3.75},np.float64)
  local r=np.less(-3.5,a)
  assert(r.dtype=='bool','scalar 66 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,false,true,true,true}),'scalar 66 values')
end
do -- less scalar 67
  local a=np.array({9,9,-31,-127,-1},np.int16)
  local r=np.less(a,0.5)
  assert(r.dtype=='bool','scalar 67 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,true,true,true}),'scalar 67 values')
end
do -- less scalar 68
  local a=np.array({251,0,127,127,251},np.uint16)
  local r=np.less(-0.0,a)
  assert(r.dtype=='bool','scalar 68 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,false,true,true,true}),'scalar 68 values')
end
do -- less scalar 69
  local a=np.array({9,9,1,2,9},np.int16)
  local r=np.less(128,a)
  assert(r.dtype=='bool','scalar 69 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 69 values')
end
do -- less scalar 70
  local a=np.array({-0.0,-2.25,0.5,0.5,math.huge},np.float32)
  local r=np.less(200,a)
  assert(r.dtype=='bool','scalar 70 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,true}),'scalar 70 values')
end
do -- less scalar 71
  local a=np.array({63,63,9,-127,9},np.int8)
  local r=np.less(1,a)
  assert(r.dtype=='bool','scalar 71 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,false,true}),'scalar 71 values')
end
do -- less scalar 72
  local a=np.array({3.75,3.75,0.0,math.huge,(0/0)},np.float32)
  local r=np.less(2.25,a)
  assert(r.dtype=='bool','scalar 72 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,false,true,false}),'scalar 72 values')
end
do -- less scalar 73
  local a=np.array({0,63,2,63,-31},np.int64)
  local r=np.less(a,-129)
  assert(r.dtype=='bool','scalar 73 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 73 values')
end
do -- less scalar 74
  local a=np.array({63,251,0,1,251},np.uint32)
  local r=np.less(a,-3.5)
  assert(r.dtype=='bool','scalar 74 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 74 values')
end
do -- less scalar 75
  local a=np.array({0,251,2,2,2},np.uint16)
  local r=np.less(a,2.25)
  assert(r.dtype=='bool','scalar 75 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,false,true,true,true}),'scalar 75 values')
end
do -- less scalar 76
  local a=np.array({true,true,false,true,false},np.bool)
  local r=np.less(1,a)
  assert(r.dtype=='bool','scalar 76 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 76 values')
end
do -- less scalar 77
  local a=np.array({2,1,17,2,0},np.uint64)
  local r=np.less(a,1)
  assert(r.dtype=='bool','scalar 77 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,true}),'scalar 77 values')
end
do -- less_equal scalar 78
  local a=np.array({0.5,-math.huge,math.huge,-0.0,-9.5},np.float32)
  local r=np.less_equal(a,-0.0)
  assert(r.dtype=='bool','scalar 78 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,false,true,true}),'scalar 78 values')
end
do -- less_equal scalar 79
  local a=np.array({126,-1,-1,9,1},np.int32)
  local r=np.less_equal(a,1)
  assert(r.dtype=='bool','scalar 79 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,true,false,true}),'scalar 79 values')
end
do -- less_equal scalar 80
  local a=np.array({126,-127,-127,-1,1},np.int64)
  local r=np.less_equal(a,10000000000.0)
  assert(r.dtype=='bool','scalar 80 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 80 values')
end
do -- less_equal scalar 81
  local a=np.array({1,63,2,-127,9},np.int32)
  local r=np.less_equal(a,300)
  assert(r.dtype=='bool','scalar 81 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 81 values')
end
do -- less_equal scalar 82
  local a=np.array({63,251,5,63,63},np.uint32)
  local r=np.less_equal(10000000000.0,a)
  assert(r.dtype=='bool','scalar 82 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 82 values')
end
do -- less_equal scalar 83
  local a=np.array({-math.huge,0.0,0.0,-2.25,3.75},np.float32)
  local r=np.less_equal(-300,a)
  assert(r.dtype=='bool','scalar 83 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,true,true,true}),'scalar 83 values')
end
do -- less_equal scalar 84
  local a=np.array({11.0,0.5,-math.huge,3.75,math.huge},np.float32)
  local r=np.less_equal(10000000000.0,a)
  assert(r.dtype=='bool','scalar 84 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,true}),'scalar 84 values')
end
do -- less_equal scalar 85
  local a=np.array({2,127,127,0,63},np.uint8)
  local r=np.less_equal(a,-3.5)
  assert(r.dtype=='bool','scalar 85 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 85 values')
end
do -- less_equal scalar 86
  local a=np.array({true,true,true,true,true},np.bool)
  local r=np.less_equal(1,a)
  assert(r.dtype=='bool','scalar 86 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 86 values')
end
do -- less_equal scalar 87
  local a=np.array({9,126,-7,0,9},np.int16)
  local r=np.less_equal(2.25,a)
  assert(r.dtype=='bool','scalar 87 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,false,false,true}),'scalar 87 values')
end
do -- less_equal scalar 88
  local a=np.array({-2.25,3.75,-0.0,11.0,-math.huge},np.float16)
  local r=np.less_equal(a,2.25)
  assert(r.dtype=='bool','scalar 88 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,false,true,false,true}),'scalar 88 values')
end
do -- less_equal scalar 89
  local a=np.array({9,9,-7,-127,-31},np.int16)
  local r=np.less_equal(-300,a)
  assert(r.dtype=='bool','scalar 89 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 89 values')
end
do -- less_equal scalar 90
  local a=np.array({0.0,-math.huge,-1.0,0.0,-9.5},np.float64)
  local r=np.less_equal(a,300)
  assert(r.dtype=='bool','scalar 90 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 90 values')
end
do -- less_equal scalar 91
  local a=np.array({63,251,2,127,1},np.uint32)
  local r=np.less_equal(a,200)
  assert(r.dtype=='bool','scalar 91 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,false,true,true,true}),'scalar 91 values')
end
do -- less_equal scalar 92
  local a=np.array({math.huge,0.0,1.0,3.75,11.0},np.float16)
  local r=np.less_equal(a,128)
  assert(r.dtype=='bool','scalar 92 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,true,true,true}),'scalar 92 values')
end
do -- less_equal scalar 93
  local a=np.array({63,1,-31,126,126},np.int16)
  local r=np.less_equal(a,-129)
  assert(r.dtype=='bool','scalar 93 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 93 values')
end
do -- less_equal scalar 94
  local a=np.array({-31,63,-7,9,-127},np.int64)
  local r=np.less_equal(a,1)
  assert(r.dtype=='bool','scalar 94 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,false,true,false,true}),'scalar 94 values')
end
do -- less_equal scalar 95
  local a=np.array({math.huge,-0.0,1.0,3.75,11.0},np.float32)
  local r=np.less_equal(-3.5,a)
  assert(r.dtype=='bool','scalar 95 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 95 values')
end
do -- less_equal scalar 96
  local a=np.array({(0/0),-2.25,3.75,0.0,-2.25},np.float64)
  local r=np.less_equal(2.25,a)
  assert(r.dtype=='bool','scalar 96 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,true,false,false}),'scalar 96 values')
end
do -- less_equal scalar 97
  local a=np.array({0,17,127,63,63},np.uint8)
  local r=np.less_equal(200,a)
  assert(r.dtype=='bool','scalar 97 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 97 values')
end
do -- less_equal scalar 98
  local a=np.array({false,true,true,false,true},np.bool)
  local r=np.less_equal(a,300)
  assert(r.dtype=='bool','scalar 98 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 98 values')
end
do -- less_equal scalar 99
  local a=np.array({-127,-7,63,63,0},np.int16)
  local r=np.less_equal(-0.0,a)
  assert(r.dtype=='bool','scalar 99 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,true,true,true}),'scalar 99 values')
end
do -- less_equal scalar 100
  local a=np.array({true,true,true,false,false},np.bool)
  local r=np.less_equal(a,-0.0)
  assert(r.dtype=='bool','scalar 100 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,true,true}),'scalar 100 values')
end
do -- less_equal scalar 101
  local a=np.array({-2.25,(0/0),0.0,1.0,1.0},np.float64)
  local r=np.less_equal(a,2.25)
  assert(r.dtype=='bool','scalar 101 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,false,true,true,true}),'scalar 101 values')
end
do -- less_equal scalar 102
  local a=np.array({251,127,5,2,1},np.uint8)
  local r=np.less_equal(2.25,a)
  assert(r.dtype=='bool','scalar 102 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,false,false}),'scalar 102 values')
end
do -- less_equal scalar 103
  local a=np.array({-1,9,126,1,9},np.int16)
  local r=np.less_equal(a,-300)
  assert(r.dtype=='bool','scalar 103 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 103 values')
end
do -- greater scalar 104
  local a=np.array({1,5,63,5,251},np.uint16)
  local r=np.greater(0,a)
  assert(r.dtype=='bool','scalar 104 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 104 values')
end
do -- greater scalar 105
  local a=np.array({127,0,63,1,63},np.uint64)
  local r=np.greater(-0.0,a)
  assert(r.dtype=='bool','scalar 105 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 105 values')
end
do -- greater scalar 106
  local a=np.array({9,-31,126,0,-7},np.int8)
  local r=np.greater(-1,a)
  assert(r.dtype=='bool','scalar 106 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,false,false,true}),'scalar 106 values')
end
do -- greater scalar 107
  local a=np.array({0,0,2,63,251},np.uint16)
  local r=np.greater(a,127)
  assert(r.dtype=='bool','scalar 107 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,true}),'scalar 107 values')
end
do -- greater scalar 108
  local a=np.array({5,0,5,17,127},np.uint64)
  local r=np.greater(200,a)
  assert(r.dtype=='bool','scalar 108 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 108 values')
end
do -- greater scalar 109
  local a=np.array({math.huge,11.0,math.huge,0.5,1.0},np.float64)
  local r=np.greater(a,-129)
  assert(r.dtype=='bool','scalar 109 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 109 values')
end
do -- greater scalar 110
  local a=np.array({9,1,63,126,-1},np.int64)
  local r=np.greater(a,-3.5)
  assert(r.dtype=='bool','scalar 110 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 110 values')
end
do -- greater scalar 111
  local a=np.array({5,2,127,251,5},np.uint64)
  local r=np.greater(a,1)
  assert(r.dtype=='bool','scalar 111 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 111 values')
end
do -- greater scalar 112
  local a=np.array({(0/0),0.0,0.5,3.75,0.5},np.float16)
  local r=np.greater(a,300)
  assert(r.dtype=='bool','scalar 112 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 112 values')
end
do -- greater scalar 113
  local a=np.array({251,127,1,5,5},np.uint32)
  local r=np.greater(-3.5,a)
  assert(r.dtype=='bool','scalar 113 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 113 values')
end
do -- greater scalar 114
  local a=np.array({0,5,251,2,0},np.uint32)
  local r=np.greater(-0.0,a)
  assert(r.dtype=='bool','scalar 114 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 114 values')
end
do -- greater scalar 115
  local a=np.array({math.huge,11.0,-math.huge,-9.5,-0.0},np.float64)
  local r=np.greater(a,-1)
  assert(r.dtype=='bool','scalar 115 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,false,false,true}),'scalar 115 values')
end
do -- greater scalar 116
  local a=np.array({127,127,5,127,251},np.uint64)
  local r=np.greater(128,a)
  assert(r.dtype=='bool','scalar 116 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,false}),'scalar 116 values')
end
do -- greater scalar 117
  local a=np.array({1,127,0,0,2},np.uint16)
  local r=np.greater(-0.0,a)
  assert(r.dtype=='bool','scalar 117 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 117 values')
end
do -- greater scalar 118
  local a=np.array({(0/0),-math.huge,-math.huge,0.5,-1.0},np.float32)
  local r=np.greater(0,a)
  assert(r.dtype=='bool','scalar 118 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,true,false,true}),'scalar 118 values')
end
do -- greater scalar 119
  local a=np.array({true,true,true,true,false},np.bool)
  local r=np.greater(128,a)
  assert(r.dtype=='bool','scalar 119 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 119 values')
end
do -- greater scalar 120
  local a=np.array({63,-7,-1,-127,-7},np.int64)
  local r=np.greater(127,a)
  assert(r.dtype=='bool','scalar 120 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 120 values')
end
do -- greater scalar 121
  local a=np.array({2,17,251,127,17},np.uint8)
  local r=np.greater(a,200)
  assert(r.dtype=='bool','scalar 121 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,true,false,false}),'scalar 121 values')
end
do -- greater scalar 122
  local a=np.array({2,-127,0,1,-1},np.int64)
  local r=np.greater(a,128)
  assert(r.dtype=='bool','scalar 122 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 122 values')
end
do -- greater scalar 123
  local a=np.array({63,63,0,17,63},np.uint64)
  local r=np.greater(a,2.25)
  assert(r.dtype=='bool','scalar 123 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,false,true,true}),'scalar 123 values')
end
do -- greater scalar 124
  local a=np.array({63,17,0,2,5},np.uint16)
  local r=np.greater(1,a)
  assert(r.dtype=='bool','scalar 124 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,true,false,false}),'scalar 124 values')
end
do -- greater scalar 125
  local a=np.array({5,127,1,63,63},np.uint64)
  local r=np.greater(a,0)
  assert(r.dtype=='bool','scalar 125 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 125 values')
end
do -- greater scalar 126
  local a=np.array({1,-31,0,2,-1},np.int64)
  local r=np.greater(a,10000000000.0)
  assert(r.dtype=='bool','scalar 126 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 126 values')
end
do -- greater scalar 127
  local a=np.array({1,251,127,5,5},np.uint64)
  local r=np.greater(-3.5,a)
  assert(r.dtype=='bool','scalar 127 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 127 values')
end
do -- greater scalar 128
  local a=np.array({-math.huge,-2.25,3.75,3.75,(0/0)},np.float32)
  local r=np.greater(a,-1)
  assert(r.dtype=='bool','scalar 128 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,true,true,false}),'scalar 128 values')
end
do -- greater scalar 129
  local a=np.array({0,63,1,2,63},np.int32)
  local r=np.greater(a,0)
  assert(r.dtype=='bool','scalar 129 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,true,true,true}),'scalar 129 values')
end
do -- greater_equal scalar 130
  local a=np.array({0,5,251,2,5},np.uint16)
  local r=np.greater_equal(a,300)
  assert(r.dtype=='bool','scalar 130 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 130 values')
end
do -- greater_equal scalar 131
  local a=np.array({0,251,0,2,127},np.uint32)
  local r=np.greater_equal(-0.0,a)
  assert(r.dtype=='bool','scalar 131 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,false,true,false,false}),'scalar 131 values')
end
do -- greater_equal scalar 132
  local a=np.array({0,1,5,63,5},np.uint16)
  local r=np.greater_equal(a,128)
  assert(r.dtype=='bool','scalar 132 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 132 values')
end
do -- greater_equal scalar 133
  local a=np.array({-127,1,63,2,2},np.int8)
  local r=np.greater_equal(128,a)
  assert(r.dtype=='bool','scalar 133 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 133 values')
end
do -- greater_equal scalar 134
  local a=np.array({251,127,251,2,127},np.uint8)
  local r=np.greater_equal(a,0.5)
  assert(r.dtype=='bool','scalar 134 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 134 values')
end
do -- greater_equal scalar 135
  local a=np.array({true,true,true,true,false},np.bool)
  local r=np.greater_equal(2.25,a)
  assert(r.dtype=='bool','scalar 135 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 135 values')
end
do -- greater_equal scalar 136
  local a=np.array({127,0,1,127,0},np.uint32)
  local r=np.greater_equal(a,0)
  assert(r.dtype=='bool','scalar 136 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 136 values')
end
do -- greater_equal scalar 137
  local a=np.array({63,-1,-127,-7,9},np.int32)
  local r=np.greater_equal(-0.0,a)
  assert(r.dtype=='bool','scalar 137 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,true,true,false}),'scalar 137 values')
end
do -- greater_equal scalar 138
  local a=np.array({17,2,127,63,2},np.uint32)
  local r=np.greater_equal(a,200)
  assert(r.dtype=='bool','scalar 138 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 138 values')
end
do -- greater_equal scalar 139
  local a=np.array({126,2,1,-127,-31},np.int64)
  local r=np.greater_equal(-0.0,a)
  assert(r.dtype=='bool','scalar 139 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,true,true}),'scalar 139 values')
end
do -- greater_equal scalar 140
  local a=np.array({126,-127,-7,-127,2},np.int16)
  local r=np.greater_equal(2.25,a)
  assert(r.dtype=='bool','scalar 140 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,true,true,true}),'scalar 140 values')
end
do -- greater_equal scalar 141
  local a=np.array({-9.5,0.0,(0/0),-1.0,1.0},np.float32)
  local r=np.greater_equal(-129,a)
  assert(r.dtype=='bool','scalar 141 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 141 values')
end
do -- greater_equal scalar 142
  local a=np.array({127,17,17,0,127},np.uint64)
  local r=np.greater_equal(1,a)
  assert(r.dtype=='bool','scalar 142 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,true,false}),'scalar 142 values')
end
do -- greater_equal scalar 143
  local a=np.array({1.0,-2.25,math.huge,-1.0,-2.25},np.float16)
  local r=np.greater_equal(a,-300)
  assert(r.dtype=='bool','scalar 143 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 143 values')
end
do -- greater_equal scalar 144
  local a=np.array({17,5,0,251,127},np.uint8)
  local r=np.greater_equal(a,0)
  assert(r.dtype=='bool','scalar 144 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 144 values')
end
do -- greater_equal scalar 145
  local a=np.array({-31,-127,1,-127,0},np.int8)
  local r=np.greater_equal(-1,a)
  assert(r.dtype=='bool','scalar 145 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,false,true,false}),'scalar 145 values')
end
do -- greater_equal scalar 146
  local a=np.array({17,63,2,1,127},np.uint8)
  local r=np.greater_equal(10000000000.0,a)
  assert(r.dtype=='bool','scalar 146 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 146 values')
end
do -- greater_equal scalar 147
  local a=np.array({-0.0,0.0,11.0,-math.huge,3.75},np.float64)
  local r=np.greater_equal(0,a)
  assert(r.dtype=='bool','scalar 147 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,false,true,false}),'scalar 147 values')
end
do -- greater_equal scalar 148
  local a=np.array({251,251,2,1,17},np.uint32)
  local r=np.greater_equal(a,2.25)
  assert(r.dtype=='bool','scalar 148 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,false,false,true}),'scalar 148 values')
end
do -- greater_equal scalar 149
  local a=np.array({-9.5,0.0,math.huge,-math.huge,-1.0},np.float64)
  local r=np.greater_equal(a,-0.0)
  assert(r.dtype=='bool','scalar 149 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,true,false,false}),'scalar 149 values')
end
do -- greater_equal scalar 150
  local a=np.array({1,127,63,1,251},np.uint64)
  local r=np.greater_equal(a,-3.5)
  assert(r.dtype=='bool','scalar 150 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 150 values')
end
do -- greater_equal scalar 151
  local a=np.array({0,-127,0,63,1},np.int8)
  local r=np.greater_equal(a,1)
  assert(r.dtype=='bool','scalar 151 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,true,true}),'scalar 151 values')
end
do -- greater_equal scalar 152
  local a=np.array({0.0,(0/0),11.0,1.0,-1.0},np.float32)
  local r=np.greater_equal(a,2.25)
  assert(r.dtype=='bool','scalar 152 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,true,false,false}),'scalar 152 values')
end
do -- greater_equal scalar 153
  local a=np.array({1,1,1,0,9},np.int64)
  local r=np.greater_equal(a,127)
  assert(r.dtype=='bool','scalar 153 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 153 values')
end
do -- greater_equal scalar 154
  local a=np.array({math.huge,0.0,3.75,-0.0,(0/0)},np.float32)
  local r=np.greater_equal(a,200)
  assert(r.dtype=='bool','scalar 154 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,false,false,false,false}),'scalar 154 values')
end
do -- greater_equal scalar 155
  local a=np.array({-math.huge,-math.huge,3.75,11.0,3.75},np.float16)
  local r=np.greater_equal(2.25,a)
  assert(r.dtype=='bool','scalar 155 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,false,false,false}),'scalar 155 values')
end
do -- logical_and scalar 156
  local a=np.array({251,5,2,127,5},np.uint8)
  local r=np.logical_and(a,-129)
  assert(r.dtype=='bool','scalar 156 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 156 values')
end
do -- logical_and scalar 157
  local a=np.array({-7,2,-31,-7,0},np.int32)
  local r=np.logical_and(-3.5,a)
  assert(r.dtype=='bool','scalar 157 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,false}),'scalar 157 values')
end
do -- logical_and scalar 158
  local a=np.array({0,127,63,5,2},np.uint8)
  local r=np.logical_and(10000000000.0,a)
  assert(r.dtype=='bool','scalar 158 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,true,true,true}),'scalar 158 values')
end
do -- logical_and scalar 159
  local a=np.array({math.huge,0.0,1.0,11.0,-9.5},np.float16)
  local r=np.logical_and(a,-300)
  assert(r.dtype=='bool','scalar 159 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,false,true,true,true}),'scalar 159 values')
end
do -- logical_and scalar 160
  local a=np.array({63,63,17,2,17},np.uint8)
  local r=np.logical_and(a,10000000000.0)
  assert(r.dtype=='bool','scalar 160 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 160 values')
end
do -- logical_and scalar 161
  local a=np.array({-127,126,-1,-1,2},np.int32)
  local r=np.logical_and(-3.5,a)
  assert(r.dtype=='bool','scalar 161 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 161 values')
end
do -- logical_and scalar 162
  local a=np.array({0.5,(0/0),0.5,-9.5,-math.huge},np.float16)
  local r=np.logical_and(a,-0.0)
  assert(r.dtype=='bool','scalar 162 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 162 values')
end
do -- logical_and scalar 163
  local a=np.array({-7,1,-1,126,-31},np.int16)
  local r=np.logical_and(2.25,a)
  assert(r.dtype=='bool','scalar 163 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 163 values')
end
do -- logical_and scalar 164
  local a=np.array({2,127,2,0,17},np.uint8)
  local r=np.logical_and(-300,a)
  assert(r.dtype=='bool','scalar 164 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,false,true}),'scalar 164 values')
end
do -- logical_and scalar 165
  local a=np.array({math.huge,(0/0),0.5,11.0,-0.0},np.float16)
  local r=np.logical_and(-300,a)
  assert(r.dtype=='bool','scalar 165 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,false}),'scalar 165 values')
end
do -- logical_and scalar 166
  local a=np.array({true,false,true,true,false},np.bool)
  local r=np.logical_and(a,300)
  assert(r.dtype=='bool','scalar 166 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,false,true,true,false}),'scalar 166 values')
end
do -- logical_and scalar 167
  local a=np.array({0.0,3.75,-0.0,11.0,0.0},np.float16)
  local r=np.logical_and(a,-1)
  assert(r.dtype=='bool','scalar 167 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,false,true,false}),'scalar 167 values')
end
do -- logical_and scalar 168
  local a=np.array({true,true,true,true,false},np.bool)
  local r=np.logical_and(a,2.25)
  assert(r.dtype=='bool','scalar 168 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,false}),'scalar 168 values')
end
do -- logical_and scalar 169
  local a=np.array({math.huge,1.0,-2.25,0.0,math.huge},np.float16)
  local r=np.logical_and(1,a)
  assert(r.dtype=='bool','scalar 169 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,false,true}),'scalar 169 values')
end
do -- logical_and scalar 170
  local a=np.array({(0/0),math.huge,0.5,-0.0,-1.0},np.float32)
  local r=np.logical_and(a,0)
  assert(r.dtype=='bool','scalar 170 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 170 values')
end
do -- logical_and scalar 171
  local a=np.array({63,63,126,-127,1},np.int8)
  local r=np.logical_and(10000000000.0,a)
  assert(r.dtype=='bool','scalar 171 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 171 values')
end
do -- logical_and scalar 172
  local a=np.array({-1,126,9,-31,9},np.int16)
  local r=np.logical_and(-300,a)
  assert(r.dtype=='bool','scalar 172 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 172 values')
end
do -- logical_and scalar 173
  local a=np.array({63,63,17,0,63},np.uint64)
  local r=np.logical_and(2.25,a)
  assert(r.dtype=='bool','scalar 173 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,false,true}),'scalar 173 values')
end
do -- logical_and scalar 174
  local a=np.array({9,1,63,1,2},np.int64)
  local r=np.logical_and(a,300)
  assert(r.dtype=='bool','scalar 174 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 174 values')
end
do -- logical_and scalar 175
  local a=np.array({1,0,-1,63,2},np.int16)
  local r=np.logical_and(a,10000000000.0)
  assert(r.dtype=='bool','scalar 175 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,false,true,true,true}),'scalar 175 values')
end
do -- logical_and scalar 176
  local a=np.array({1,63,127,2,127},np.uint8)
  local r=np.logical_and(a,0.5)
  assert(r.dtype=='bool','scalar 176 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 176 values')
end
do -- logical_and scalar 177
  local a=np.array({0,-127,0,-1,9},np.int64)
  local r=np.logical_and(127,a)
  assert(r.dtype=='bool','scalar 177 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,false,true,true}),'scalar 177 values')
end
do -- logical_and scalar 178
  local a=np.array({-1,9,63,-7,2},np.int32)
  local r=np.logical_and(0.5,a)
  assert(r.dtype=='bool','scalar 178 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 178 values')
end
do -- logical_and scalar 179
  local a=np.array({-9.5,0.5,-0.0,math.huge,(0/0)},np.float16)
  local r=np.logical_and(0.5,a)
  assert(r.dtype=='bool','scalar 179 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,false,true,true}),'scalar 179 values')
end
do -- logical_and scalar 180
  local a=np.array({63,63,-1,-1,-7},np.int32)
  local r=np.logical_and(a,-0.0)
  assert(r.dtype=='bool','scalar 180 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 180 values')
end
do -- logical_and scalar 181
  local a=np.array({false,true,true,true,false},np.bool)
  local r=np.logical_and(-300,a)
  assert(r.dtype=='bool','scalar 181 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,true,true,false}),'scalar 181 values')
end
do -- logical_or scalar 182
  local a=np.array({0,126,63,0,0},np.int64)
  local r=np.logical_or(a,2.25)
  assert(r.dtype=='bool','scalar 182 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 182 values')
end
do -- logical_or scalar 183
  local a=np.array({0,127,0,2,17},np.uint64)
  local r=np.logical_or(0,a)
  assert(r.dtype=='bool','scalar 183 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,false,true,true}),'scalar 183 values')
end
do -- logical_or scalar 184
  local a=np.array({2,-7,1,-31,63},np.int16)
  local r=np.logical_or(a,-1)
  assert(r.dtype=='bool','scalar 184 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 184 values')
end
do -- logical_or scalar 185
  local a=np.array({-31,63,0,2,9},np.int16)
  local r=np.logical_or(2.25,a)
  assert(r.dtype=='bool','scalar 185 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 185 values')
end
do -- logical_or scalar 186
  local a=np.array({-1.0,11.0,-1.0,-2.25,-9.5},np.float16)
  local r=np.logical_or(0.5,a)
  assert(r.dtype=='bool','scalar 186 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 186 values')
end
do -- logical_or scalar 187
  local a=np.array({-127,-31,-31,0,-127},np.int32)
  local r=np.logical_or(a,0.5)
  assert(r.dtype=='bool','scalar 187 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 187 values')
end
do -- logical_or scalar 188
  local a=np.array({2,2,63,17,2},np.uint8)
  local r=np.logical_or(200,a)
  assert(r.dtype=='bool','scalar 188 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 188 values')
end
do -- logical_or scalar 189
  local a=np.array({-31,-31,-1,-7,-7},np.int32)
  local r=np.logical_or(2.25,a)
  assert(r.dtype=='bool','scalar 189 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 189 values')
end
do -- logical_or scalar 190
  local a=np.array({-0.0,11.0,3.75,11.0,-2.25},np.float64)
  local r=np.logical_or(a,-0.0)
  assert(r.dtype=='bool','scalar 190 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,true,true,true}),'scalar 190 values')
end
do -- logical_or scalar 191
  local a=np.array({251,0,251,0,1},np.uint64)
  local r=np.logical_or(a,-1)
  assert(r.dtype=='bool','scalar 191 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 191 values')
end
do -- logical_or scalar 192
  local a=np.array({math.huge,math.huge,-0.0,0.0,3.75},np.float64)
  local r=np.logical_or(-3.5,a)
  assert(r.dtype=='bool','scalar 192 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 192 values')
end
do -- logical_or scalar 193
  local a=np.array({17,1,0,127,0},np.uint8)
  local r=np.logical_or(a,10000000000.0)
  assert(r.dtype=='bool','scalar 193 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 193 values')
end
do -- logical_or scalar 194
  local a=np.array({251,63,127,0,2},np.uint32)
  local r=np.logical_or(2.25,a)
  assert(r.dtype=='bool','scalar 194 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 194 values')
end
do -- logical_or scalar 195
  local a=np.array({-127,63,-1,-1,-31},np.int8)
  local r=np.logical_or(a,127)
  assert(r.dtype=='bool','scalar 195 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 195 values')
end
do -- logical_or scalar 196
  local a=np.array({127,251,17,17,251},np.uint8)
  local r=np.logical_or(-0.0,a)
  assert(r.dtype=='bool','scalar 196 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 196 values')
end
do -- logical_or scalar 197
  local a=np.array({-0.0,-9.5,1.0,(0/0),(0/0)},np.float32)
  local r=np.logical_or(1,a)
  assert(r.dtype=='bool','scalar 197 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 197 values')
end
do -- logical_or scalar 198
  local a=np.array({-math.huge,-math.huge,-math.huge,-1.0,3.75},np.float32)
  local r=np.logical_or(a,-1)
  assert(r.dtype=='bool','scalar 198 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 198 values')
end
do -- logical_or scalar 199
  local a=np.array({1,17,17,127,1},np.uint64)
  local r=np.logical_or(a,-3.5)
  assert(r.dtype=='bool','scalar 199 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 199 values')
end
do -- logical_or scalar 200
  local a=np.array({9,63,2,126,-7},np.int64)
  local r=np.logical_or(10000000000.0,a)
  assert(r.dtype=='bool','scalar 200 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 200 values')
end
do -- logical_or scalar 201
  local a=np.array({2,2,0,63,-7},np.int16)
  local r=np.logical_or(a,200)
  assert(r.dtype=='bool','scalar 201 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 201 values')
end
do -- logical_or scalar 202
  local a=np.array({math.huge,11.0,1.0,(0/0),-9.5},np.float64)
  local r=np.logical_or(a,2.25)
  assert(r.dtype=='bool','scalar 202 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 202 values')
end
do -- logical_or scalar 203
  local a=np.array({1,2,63,-31,-1},np.int16)
  local r=np.logical_or(200,a)
  assert(r.dtype=='bool','scalar 203 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 203 values')
end
do -- logical_or scalar 204
  local a=np.array({-2.25,-0.0,(0/0),1.0,11.0},np.float64)
  local r=np.logical_or(a,10000000000.0)
  assert(r.dtype=='bool','scalar 204 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 204 values')
end
do -- logical_or scalar 205
  local a=np.array({127,251,127,17,5},np.uint64)
  local r=np.logical_or(a,300)
  assert(r.dtype=='bool','scalar 205 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 205 values')
end
do -- logical_or scalar 206
  local a=np.array({-1,1,9,2,0},np.int64)
  local r=np.logical_or(127,a)
  assert(r.dtype=='bool','scalar 206 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 206 values')
end
do -- logical_or scalar 207
  local a=np.array({251,63,0,127,0},np.uint64)
  local r=np.logical_or(a,-0.0)
  assert(r.dtype=='bool','scalar 207 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,false,true,false}),'scalar 207 values')
end
do -- logical_xor scalar 208
  local a=np.array({2,-31,1,2,-127},np.int8)
  local r=np.logical_xor(a,-3.5)
  assert(r.dtype=='bool','scalar 208 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 208 values')
end
do -- logical_xor scalar 209
  local a=np.array({2,-127,-31,126,1},np.int8)
  local r=np.logical_xor(a,-3.5)
  assert(r.dtype=='bool','scalar 209 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 209 values')
end
do -- logical_xor scalar 210
  local a=np.array({126,0,-7,2,0},np.int64)
  local r=np.logical_xor(a,127)
  assert(r.dtype=='bool','scalar 210 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,false,false,true}),'scalar 210 values')
end
do -- logical_xor scalar 211
  local a=np.array({2,63,63,251,63},np.uint16)
  local r=np.logical_xor(0,a)
  assert(r.dtype=='bool','scalar 211 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 211 values')
end
do -- logical_xor scalar 212
  local a=np.array({math.huge,-9.5,-0.0,0.5,0.5},np.float64)
  local r=np.logical_xor(-3.5,a)
  assert(r.dtype=='bool','scalar 212 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,true,false,false}),'scalar 212 values')
end
do -- logical_xor scalar 213
  local a=np.array({251,5,1,2,251},np.uint32)
  local r=np.logical_xor(-3.5,a)
  assert(r.dtype=='bool','scalar 213 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 213 values')
end
do -- logical_xor scalar 214
  local a=np.array({63,-127,-1,2,126},np.int16)
  local r=np.logical_xor(0.5,a)
  assert(r.dtype=='bool','scalar 214 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 214 values')
end
do -- logical_xor scalar 215
  local a=np.array({63,251,251,2,17},np.uint8)
  local r=np.logical_xor(a,-3.5)
  assert(r.dtype=='bool','scalar 215 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 215 values')
end
do -- logical_xor scalar 216
  local a=np.array({9,-127,9,2,63},np.int64)
  local r=np.logical_xor(-0.0,a)
  assert(r.dtype=='bool','scalar 216 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true,true}),'scalar 216 values')
end
do -- logical_xor scalar 217
  local a=np.array({true,false,false,true,false},np.bool)
  local r=np.logical_xor(a,10000000000.0)
  assert(r.dtype=='bool','scalar 217 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,true,false,true}),'scalar 217 values')
end
do -- logical_xor scalar 218
  local a=np.array({math.huge,-2.25,0.0,-math.huge,-math.huge},np.float16)
  local r=np.logical_xor(a,128)
  assert(r.dtype=='bool','scalar 218 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,true,false,false}),'scalar 218 values')
end
do -- logical_xor scalar 219
  local a=np.array({126,-31,-7,63,9},np.int64)
  local r=np.logical_xor(200,a)
  assert(r.dtype=='bool','scalar 219 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 219 values')
end
do -- logical_xor scalar 220
  local a=np.array({5,63,5,251,63},np.uint8)
  local r=np.logical_xor(a,10000000000.0)
  assert(r.dtype=='bool','scalar 220 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 220 values')
end
do -- logical_xor scalar 221
  local a=np.array({false,false,true,false,false},np.bool)
  local r=np.logical_xor(-1,a)
  assert(r.dtype=='bool','scalar 221 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,false,true,true}),'scalar 221 values')
end
do -- logical_xor scalar 222
  local a=np.array({0.0,11.0,-9.5,-9.5,-9.5},np.float16)
  local r=np.logical_xor(-129,a)
  assert(r.dtype=='bool','scalar 222 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,false,false,false,false}),'scalar 222 values')
end
do -- logical_xor scalar 223
  local a=np.array({-31,-127,-1,63,63},np.int16)
  local r=np.logical_xor(127,a)
  assert(r.dtype=='bool','scalar 223 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 223 values')
end
do -- logical_xor scalar 224
  local a=np.array({-7,-31,126,-7,-31},np.int64)
  local r=np.logical_xor(-3.5,a)
  assert(r.dtype=='bool','scalar 224 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 224 values')
end
do -- logical_xor scalar 225
  local a=np.array({251,127,63,1,0},np.uint64)
  local r=np.logical_xor(a,-3.5)
  assert(r.dtype=='bool','scalar 225 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,true}),'scalar 225 values')
end
do -- logical_xor scalar 226
  local a=np.array({-1,-7,-127,0,63},np.int16)
  local r=np.logical_xor(a,-0.0)
  assert(r.dtype=='bool','scalar 226 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,false,true}),'scalar 226 values')
end
do -- logical_xor scalar 227
  local a=np.array({63,251,127,1,63},np.uint8)
  local r=np.logical_xor(a,-3.5)
  assert(r.dtype=='bool','scalar 227 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 227 values')
end
do -- logical_xor scalar 228
  local a=np.array({-31,-127,-31,2,2},np.int8)
  local r=np.logical_xor(a,-1)
  assert(r.dtype=='bool','scalar 228 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 228 values')
end
do -- logical_xor scalar 229
  local a=np.array({math.huge,-1.0,-2.25,-2.25,-math.huge},np.float32)
  local r=np.logical_xor(300,a)
  assert(r.dtype=='bool','scalar 229 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 229 values')
end
do -- logical_xor scalar 230
  local a=np.array({0.0,-math.huge,3.75,3.75,0.5},np.float64)
  local r=np.logical_xor(a,200)
  assert(r.dtype=='bool','scalar 230 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,false,false,false,false}),'scalar 230 values')
end
do -- logical_xor scalar 231
  local a=np.array({0.5,11.0,0.0,11.0,-2.25},np.float64)
  local r=np.logical_xor(2.25,a)
  assert(r.dtype=='bool','scalar 231 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,true,false,false}),'scalar 231 values')
end
do -- logical_xor scalar 232
  local a=np.array({11.0,0.5,(0/0),3.75,11.0},np.float32)
  local r=np.logical_xor(a,200)
  assert(r.dtype=='bool','scalar 232 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false,false}),'scalar 232 values')
end
do -- logical_xor scalar 233
  local a=np.array({-127,1,0,9,-1},np.int64)
  local r=np.logical_xor(300,a)
  assert(r.dtype=='bool','scalar 233 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,true,false,false}),'scalar 233 values')
end
do -- maximum scalar 234
  local a=np.array({true,true,true,true,true},np.bool)
  local r=np.maximum(a,-1)
  assert(r.dtype=='int64','scalar 234 dtype '..r.dtype)
  assert(veq(r:tolist(),{1,1,1,1,1}),'scalar 234 values')
end
do -- maximum scalar 235
  local a=np.array({17,251,1,0,2},np.uint16)
  local r=np.maximum(a,-3.5)
  assert(r.dtype=='float64','scalar 235 dtype '..r.dtype)
  assert(veq(r:tolist(),{17.0,251.0,1.0,0.0,2.0}),'scalar 235 values')
end
do -- maximum scalar 236
  local a=np.array({1.0,11.0,-9.5,-1.0,(0/0)},np.float32)
  local r=np.maximum(10000000000.0,a)
  assert(r.dtype=='float32','scalar 236 dtype '..r.dtype)
  assert(veq(r:tolist(),{10000000000.0,10000000000.0,10000000000.0,10000000000.0,(0/0)}),'scalar 236 values')
end
do -- maximum scalar 237
  local a=np.array({-127,-7,2,-127,1},np.int8)
  local r=np.maximum(a,-3.5)
  assert(r.dtype=='float64','scalar 237 dtype '..r.dtype)
  assert(veq(r:tolist(),{-3.5,-3.5,2.0,-3.5,1.0}),'scalar 237 values')
end
do -- maximum scalar 238
  local a=np.array({63,126,-7,1,63},np.int8)
  local r=np.maximum(a,-0.0)
  assert(r.dtype=='float64','scalar 238 dtype '..r.dtype)
  assert(veq(r:tolist(),{63.0,126.0,-0.0,1.0,63.0}),'scalar 238 values')
end
do -- maximum scalar 239
  local a=np.array({2,0,63,126,-127},np.int8)
  local r=np.maximum(a,-0.0)
  assert(r.dtype=='float64','scalar 239 dtype '..r.dtype)
  assert(veq(r:tolist(),{2.0,-0.0,63.0,126.0,-0.0}),'scalar 239 values')
end
do -- maximum scalar 240
  local a=np.array({-9.5,1.0,-2.25,0.5,3.75},np.float32)
  local r=np.maximum(0.5,a)
  assert(r.dtype=='float32','scalar 240 dtype '..r.dtype)
  assert(veq(r:tolist(),{0.5,1.0,0.5,0.5,3.75}),'scalar 240 values')
end
do -- maximum scalar error 241
  local a=np.array({9,1,63,-127,-31},np.int8)
  local ok=pcall(function() return np.maximum(-300,a) end)
  assert(not ok,'maximum scalar error 241')
end
do -- maximum scalar 242
  local a=np.array({63,127,1,17,1},np.uint32)
  local r=np.maximum(a,300)
  assert(r.dtype=='uint32','scalar 242 dtype '..r.dtype)
  assert(veq(r:tolist(),{300,300,300,300,300}),'scalar 242 values')
end
do -- maximum scalar 243
  local a=np.array({9,63,-7,-1,0},np.int32)
  local r=np.maximum(0.5,a)
  assert(r.dtype=='float64','scalar 243 dtype '..r.dtype)
  assert(veq(r:tolist(),{9.0,63.0,0.5,0.5,0.5}),'scalar 243 values')
end
do -- maximum scalar 244
  local a=np.array({63,1,-31,1,63},np.int32)
  local r=np.maximum(300,a)
  assert(r.dtype=='int32','scalar 244 dtype '..r.dtype)
  assert(veq(r:tolist(),{300,300,300,300,300}),'scalar 244 values')
end
do -- maximum scalar 245
  local a=np.array({1,0,0,127,0},np.uint32)
  local r=np.maximum(a,10000000000.0)
  assert(r.dtype=='float64','scalar 245 dtype '..r.dtype)
  assert(veq(r:tolist(),{10000000000.0,10000000000.0,10000000000.0,10000000000.0,10000000000.0}),'scalar 245 values')
end
do -- maximum scalar 246
  local a=np.array({3.75,11.0,math.huge,math.huge,0.5},np.float64)
  local r=np.maximum(1,a)
  assert(r.dtype=='float64','scalar 246 dtype '..r.dtype)
  assert(veq(r:tolist(),{3.75,11.0,math.huge,math.huge,1.0}),'scalar 246 values')
end
do -- maximum scalar 247
  local a=np.array({126,-1,0,-31,-1},np.int64)
  local r=np.maximum(a,2.25)
  assert(r.dtype=='float64','scalar 247 dtype '..r.dtype)
  assert(veq(r:tolist(),{126.0,2.25,2.25,2.25,2.25}),'scalar 247 values')
end
do -- maximum scalar 248
  local a=np.array({9,-7,0,-31,0},np.int32)
  local r=np.maximum(-3.5,a)
  assert(r.dtype=='float64','scalar 248 dtype '..r.dtype)
  assert(veq(r:tolist(),{9.0,-3.5,0.0,-3.5,0.0}),'scalar 248 values')
end
do -- maximum scalar 249
  local a=np.array({63,-31,-7,126,0},np.int64)
  local r=np.maximum(0,a)
  assert(r.dtype=='int64','scalar 249 dtype '..r.dtype)
  assert(veq(r:tolist(),{63,0,0,126,0}),'scalar 249 values')
end
do -- maximum scalar 250
  local a=np.array({5,0,1,251,127},np.uint8)
  local r=np.maximum(a,128)
  assert(r.dtype=='uint8','scalar 250 dtype '..r.dtype)
  assert(veq(r:tolist(),{128,128,128,251,128}),'scalar 250 values')
end
do -- maximum scalar error 251
  local a=np.array({5,63,63,1,2},np.uint16)
  local ok=pcall(function() return np.maximum(a,-1) end)
  assert(not ok,'maximum scalar error 251')
end
do -- maximum scalar 252
  local a=np.array({1,17,251,251,0},np.uint64)
  local r=np.maximum(200,a)
  assert(r.dtype=='uint64','scalar 252 dtype '..r.dtype)
  assert(veq(r:tolist(),{200,200,251,251,200}),'scalar 252 values')
end
do -- maximum scalar 253
  local a=np.array({-2.25,math.huge,0.0,0.5,-1.0},np.float32)
  local r=np.maximum(a,10000000000.0)
  assert(r.dtype=='float32','scalar 253 dtype '..r.dtype)
  assert(veq(r:tolist(),{10000000000.0,math.huge,10000000000.0,10000000000.0,10000000000.0}),'scalar 253 values')
end
do -- maximum scalar 254
  local a=np.array({0,63,5,127,63},np.uint16)
  local r=np.maximum(-0.0,a)
  assert(r.dtype=='float64','scalar 254 dtype '..r.dtype)
  assert(veq(r:tolist(),{0.0,63.0,5.0,127.0,63.0}),'scalar 254 values')
end
do -- maximum scalar 255
  local a=np.array({2,2,63,0,5},np.uint64)
  local r=np.maximum(a,-3.5)
  assert(r.dtype=='float64','scalar 255 dtype '..r.dtype)
  assert(veq(r:tolist(),{2.0,2.0,63.0,0.0,5.0}),'scalar 255 values')
end
do -- maximum scalar 256
  local a=np.array({3.75,(0/0),math.huge,0.0,-math.huge},np.float16)
  local r=np.maximum(-1,a)
  assert(r.dtype=='float16','scalar 256 dtype '..r.dtype)
  assert(veq(r:tolist(),{3.75,(0/0),math.huge,0.0,-1.0}),'scalar 256 values')
end
do -- maximum scalar 257
  local a=np.array({126,63,2,-127,1},np.int64)
  local r=np.maximum(-300,a)
  assert(r.dtype=='int64','scalar 257 dtype '..r.dtype)
  assert(veq(r:tolist(),{126,63,2,-127,1}),'scalar 257 values')
end
do -- maximum scalar 258
  local a=np.array({251,63,127,17,1},np.uint64)
  local r=np.maximum(a,-3.5)
  assert(r.dtype=='float64','scalar 258 dtype '..r.dtype)
  assert(veq(r:tolist(),{251.0,63.0,127.0,17.0,1.0}),'scalar 258 values')
end
do -- maximum scalar 259
  local a=np.array({-9.5,-1.0,-math.huge,math.huge,1.0},np.float16)
  local r=np.maximum(-3.5,a)
  assert(r.dtype=='float16','scalar 259 dtype '..r.dtype)
  assert(veq(r:tolist(),{-3.5,-1.0,-3.5,math.huge,1.0}),'scalar 259 values')
end
do -- minimum scalar 260
  local a=np.array({63,17,251,1,17},np.uint64)
  local r=np.minimum(2.25,a)
  assert(r.dtype=='float64','scalar 260 dtype '..r.dtype)
  assert(veq(r:tolist(),{2.25,2.25,2.25,1.0,2.25}),'scalar 260 values')
end
do -- minimum scalar 261
  local a=np.array({5,127,63,63,0},np.uint32)
  local r=np.minimum(2.25,a)
  assert(r.dtype=='float64','scalar 261 dtype '..r.dtype)
  assert(veq(r:tolist(),{2.25,2.25,2.25,2.25,0.0}),'scalar 261 values')
end
do -- minimum scalar 262
  local a=np.array({2,-1,126,0,1},np.int8)
  local r=np.minimum(-3.5,a)
  assert(r.dtype=='float64','scalar 262 dtype '..r.dtype)
  assert(veq(r:tolist(),{-3.5,-3.5,-3.5,-3.5,-3.5}),'scalar 262 values')
end
do -- minimum scalar 263
  local a=np.array({17,0,127,127,5},np.uint16)
  local r=np.minimum(a,200)
  assert(r.dtype=='uint16','scalar 263 dtype '..r.dtype)
  assert(veq(r:tolist(),{17,0,127,127,5}),'scalar 263 values')
end
do -- minimum scalar 264
  local a=np.array({1,0,63,2,127},np.uint16)
  local r=np.minimum(a,-0.0)
  assert(r.dtype=='float64','scalar 264 dtype '..r.dtype)
  assert(veq(r:tolist(),{-0.0,-0.0,-0.0,-0.0,-0.0}),'scalar 264 values')
end
do -- minimum scalar 265
  local a=np.array({0.5,3.75,-0.0,1.0,(0/0)},np.float16)
  local r=np.minimum(a,-3.5)
  assert(r.dtype=='float16','scalar 265 dtype '..r.dtype)
  assert(veq(r:tolist(),{-3.5,-3.5,-3.5,-3.5,(0/0)}),'scalar 265 values')
end
do -- minimum scalar 266
  local a=np.array({-1,-127,-31,126,-127},np.int64)
  local r=np.minimum(a,-129)
  assert(r.dtype=='int64','scalar 266 dtype '..r.dtype)
  assert(veq(r:tolist(),{-129,-129,-129,-129,-129}),'scalar 266 values')
end
do -- minimum scalar 267
  local a=np.array({1,251,63,251,127},np.uint32)
  local r=np.minimum(a,0)
  assert(r.dtype=='uint32','scalar 267 dtype '..r.dtype)
  assert(veq(r:tolist(),{0,0,0,0,0}),'scalar 267 values')
end
do -- minimum scalar 268
  local a=np.array({63,-1,63,-31,-7},np.int8)
  local r=np.minimum(a,-3.5)
  assert(r.dtype=='float64','scalar 268 dtype '..r.dtype)
  assert(veq(r:tolist(),{-3.5,-3.5,-3.5,-31.0,-7.0}),'scalar 268 values')
end
do -- minimum scalar 269
  local a=np.array({false,true,true,true,true},np.bool)
  local r=np.minimum(a,0.5)
  assert(r.dtype=='float64','scalar 269 dtype '..r.dtype)
  assert(veq(r:tolist(),{0.0,0.5,0.5,0.5,0.5}),'scalar 269 values')
end
do -- minimum scalar 270
  local a=np.array({1,-31,126,2,9},np.int32)
  local r=np.minimum(10000000000.0,a)
  assert(r.dtype=='float64','scalar 270 dtype '..r.dtype)
  assert(veq(r:tolist(),{1.0,-31.0,126.0,2.0,9.0}),'scalar 270 values')
end
do -- minimum scalar error 271
  local a=np.array({2,63,251,127,63},np.uint32)
  local ok=pcall(function() return np.minimum(a,-129) end)
  assert(not ok,'minimum scalar error 271')
end
do -- minimum scalar 272
  local a=np.array({63,-7,9,126,-127},np.int8)
  local r=np.minimum(0,a)
  assert(r.dtype=='int8','scalar 272 dtype '..r.dtype)
  assert(veq(r:tolist(),{0,-7,0,0,-127}),'scalar 272 values')
end
do -- minimum scalar 273
  local a=np.array({126,1,-127,-127,63},np.int8)
  local r=np.minimum(a,-1)
  assert(r.dtype=='int8','scalar 273 dtype '..r.dtype)
  assert(veq(r:tolist(),{-1,-1,-127,-127,-1}),'scalar 273 values')
end
do -- minimum scalar 274
  local a=np.array({63,-1,-7,63,0},np.int64)
  local r=np.minimum(127,a)
  assert(r.dtype=='int64','scalar 274 dtype '..r.dtype)
  assert(veq(r:tolist(),{63,-1,-7,63,0}),'scalar 274 values')
end
do -- minimum scalar 275
  local a=np.array({1,63,1,63,0},np.uint8)
  local r=np.minimum(200,a)
  assert(r.dtype=='uint8','scalar 275 dtype '..r.dtype)
  assert(veq(r:tolist(),{1,63,1,63,0}),'scalar 275 values')
end
do -- minimum scalar 276
  local a=np.array({-7,-7,-127,2,-31},np.int8)
  local r=np.minimum(0.5,a)
  assert(r.dtype=='float64','scalar 276 dtype '..r.dtype)
  assert(veq(r:tolist(),{-7.0,-7.0,-127.0,0.5,-31.0}),'scalar 276 values')
end
do -- minimum scalar 277
  local a=np.array({-1,1,0,-1,-1},np.int16)
  local r=np.minimum(a,0.5)
  assert(r.dtype=='float64','scalar 277 dtype '..r.dtype)
  assert(veq(r:tolist(),{-1.0,0.5,0.0,-1.0,-1.0}),'scalar 277 values')
end
do -- minimum scalar 278
  local a=np.array({251,2,127,2,1},np.uint32)
  local r=np.minimum(a,-3.5)
  assert(r.dtype=='float64','scalar 278 dtype '..r.dtype)
  assert(veq(r:tolist(),{-3.5,-3.5,-3.5,-3.5,-3.5}),'scalar 278 values')
end
do -- minimum scalar 279
  local a=np.array({-31,63,2,-127,1},np.int32)
  local r=np.minimum(a,-129)
  assert(r.dtype=='int32','scalar 279 dtype '..r.dtype)
  assert(veq(r:tolist(),{-129,-129,-129,-129,-129}),'scalar 279 values')
end
do -- minimum scalar 280
  local a=np.array({251,251,2,1,1},np.uint32)
  local r=np.minimum(-3.5,a)
  assert(r.dtype=='float64','scalar 280 dtype '..r.dtype)
  assert(veq(r:tolist(),{-3.5,-3.5,-3.5,-3.5,-3.5}),'scalar 280 values')
end
do -- minimum scalar 281
  local a=np.array({0,63,63,5,2},np.uint64)
  local r=np.minimum(0,a)
  assert(r.dtype=='uint64','scalar 281 dtype '..r.dtype)
  assert(veq(r:tolist(),{0,0,0,0,0}),'scalar 281 values')
end
do -- minimum scalar 282
  local a=np.array({1.0,-0.0,1.0,-2.25,(0/0)},np.float16)
  local r=np.minimum(-129,a)
  assert(r.dtype=='float16','scalar 282 dtype '..r.dtype)
  assert(veq(r:tolist(),{-129.0,-129.0,-129.0,-129.0,(0/0)}),'scalar 282 values')
end
do -- minimum scalar 283
  local a=np.array({1,9,-127,1,-31},np.int8)
  local r=np.minimum(a,10000000000.0)
  assert(r.dtype=='float64','scalar 283 dtype '..r.dtype)
  assert(veq(r:tolist(),{1.0,9.0,-127.0,1.0,-31.0}),'scalar 283 values')
end
do -- minimum scalar 284
  local a=np.array({false,true,true,true,false},np.bool)
  local r=np.minimum(a,0.5)
  assert(r.dtype=='float64','scalar 284 dtype '..r.dtype)
  assert(veq(r:tolist(),{0.0,0.5,0.5,0.5,0.0}),'scalar 284 values')
end
do -- minimum scalar 285
  local a=np.array({0,2,251,127,251},np.uint8)
  local r=np.minimum(0.5,a)
  assert(r.dtype=='float64','scalar 285 dtype '..r.dtype)
  assert(veq(r:tolist(),{0.0,0.5,0.5,0.5,0.5}),'scalar 285 values')
end
do -- equal bool scalar 0
  local a=np.array({1,2,-31,0},np.int8)
  local r=np.equal(a,false)
  assert(r.dtype=='bool','bool scalar 0 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,true}),'bool scalar 0 values')
end
do -- equal bool scalar 1
  local a=np.array({63,127,2,17},np.uint8)
  local r=np.equal(false,a)
  assert(r.dtype=='bool','bool scalar 1 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false}),'bool scalar 1 values')
end
do -- equal bool scalar 2
  local a=np.array({0.5,-1.0,3.75,11.0},np.float64)
  local r=np.equal(a,true)
  assert(r.dtype=='bool','bool scalar 2 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false}),'bool scalar 2 values')
end
do -- equal bool scalar 3
  local a=np.array({3.75,0.5,-0.0,11.0},np.float32)
  local r=np.equal(true,a)
  assert(r.dtype=='bool','bool scalar 3 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false}),'bool scalar 3 values')
end
do -- not_equal bool scalar 4
  local a=np.array({251,251,5,63},np.uint16)
  local r=np.not_equal(a,false)
  assert(r.dtype=='bool','bool scalar 4 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true}),'bool scalar 4 values')
end
do -- not_equal bool scalar 5
  local a=np.array({-31,-7,-7,0},np.int64)
  local r=np.not_equal(false,a)
  assert(r.dtype=='bool','bool scalar 5 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,false}),'bool scalar 5 values')
end
do -- not_equal bool scalar 6
  local a=np.array({-1,-31,1,-31},np.int64)
  local r=np.not_equal(a,true)
  assert(r.dtype=='bool','bool scalar 6 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,false,true}),'bool scalar 6 values')
end
do -- not_equal bool scalar 7
  local a=np.array({63,5,1,127},np.uint64)
  local r=np.not_equal(true,a)
  assert(r.dtype=='bool','bool scalar 7 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,false,true}),'bool scalar 7 values')
end
do -- less bool scalar 8
  local a=np.array({127,127,5,1},np.uint32)
  local r=np.less(a,false)
  assert(r.dtype=='bool','bool scalar 8 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false}),'bool scalar 8 values')
end
do -- less bool scalar 9
  local a=np.array({0,5,251,251},np.uint64)
  local r=np.less(false,a)
  assert(r.dtype=='bool','bool scalar 9 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,true,true}),'bool scalar 9 values')
end
do -- less bool scalar 10
  local a=np.array({-1,0,0,2},np.int8)
  local r=np.less(a,true)
  assert(r.dtype=='bool','bool scalar 10 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,false}),'bool scalar 10 values')
end
do -- less bool scalar 11
  local a=np.array({1,0,-31,63},np.int16)
  local r=np.less(true,a)
  assert(r.dtype=='bool','bool scalar 11 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,true}),'bool scalar 11 values')
end
do -- less_equal bool scalar 12
  local a=np.array({127,251,127,17},np.uint16)
  local r=np.less_equal(a,false)
  assert(r.dtype=='bool','bool scalar 12 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false}),'bool scalar 12 values')
end
do -- less_equal bool scalar 13
  local a=np.array({1,-7,1,2},np.int32)
  local r=np.less_equal(false,a)
  assert(r.dtype=='bool','bool scalar 13 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,false,true,true}),'bool scalar 13 values')
end
do -- less_equal bool scalar 14
  local a=np.array({9,63,126,9},np.int32)
  local r=np.less_equal(a,true)
  assert(r.dtype=='bool','bool scalar 14 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false}),'bool scalar 14 values')
end
do -- less_equal bool scalar 15
  local a=np.array({-31,-1,9,9},np.int64)
  local r=np.less_equal(true,a)
  assert(r.dtype=='bool','bool scalar 15 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,true,true}),'bool scalar 15 values')
end
do -- greater bool scalar 16
  local a=np.array({-1.0,-0.0,-1.0,1.0},np.float32)
  local r=np.greater(a,false)
  assert(r.dtype=='bool','bool scalar 16 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,true}),'bool scalar 16 values')
end
do -- greater bool scalar 17
  local a=np.array({17,17,5,5},np.uint32)
  local r=np.greater(false,a)
  assert(r.dtype=='bool','bool scalar 17 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false}),'bool scalar 17 values')
end
do -- greater bool scalar 18
  local a=np.array({0.5,-2.25,(0/0),3.75},np.float64)
  local r=np.greater(a,true)
  assert(r.dtype=='bool','bool scalar 18 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,true}),'bool scalar 18 values')
end
do -- greater bool scalar 19
  local a=np.array({-math.huge,-0.0,0.0,-math.huge},np.float64)
  local r=np.greater(true,a)
  assert(r.dtype=='bool','bool scalar 19 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true}),'bool scalar 19 values')
end
do -- greater_equal bool scalar 20
  local a=np.array({1,63,1,2},np.uint64)
  local r=np.greater_equal(a,false)
  assert(r.dtype=='bool','bool scalar 20 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true}),'bool scalar 20 values')
end
do -- greater_equal bool scalar 21
  local a=np.array({5,1,17,127},np.uint64)
  local r=np.greater_equal(false,a)
  assert(r.dtype=='bool','bool scalar 21 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false}),'bool scalar 21 values')
end
do -- greater_equal bool scalar 22
  local a=np.array({126,126,2,-7},np.int32)
  local r=np.greater_equal(a,true)
  assert(r.dtype=='bool','bool scalar 22 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,false}),'bool scalar 22 values')
end
do -- greater_equal bool scalar 23
  local a=np.array({126,1,0,-1},np.int64)
  local r=np.greater_equal(true,a)
  assert(r.dtype=='bool','bool scalar 23 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,true,true}),'bool scalar 23 values')
end
do -- logical_and bool scalar 24
  local a=np.array({17,127,5,2},np.uint16)
  local r=np.logical_and(a,false)
  assert(r.dtype=='bool','bool scalar 24 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false}),'bool scalar 24 values')
end
do -- logical_and bool scalar 25
  local a=np.array({-9.5,1.0,0.5,1.0},np.float16)
  local r=np.logical_and(false,a)
  assert(r.dtype=='bool','bool scalar 25 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false}),'bool scalar 25 values')
end
do -- logical_and bool scalar 26
  local a=np.array({-0.0,-2.25,3.75,-0.0},np.float64)
  local r=np.logical_and(a,true)
  assert(r.dtype=='bool','bool scalar 26 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,true,false}),'bool scalar 26 values')
end
do -- logical_and bool scalar 27
  local a=np.array({-1,126,-31,-127},np.int64)
  local r=np.logical_and(true,a)
  assert(r.dtype=='bool','bool scalar 27 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true}),'bool scalar 27 values')
end
do -- logical_or bool scalar 28
  local a=np.array({-7,2,63,63},np.int64)
  local r=np.logical_or(a,false)
  assert(r.dtype=='bool','bool scalar 28 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true}),'bool scalar 28 values')
end
do -- logical_or bool scalar 29
  local a=np.array({-0.0,11.0,3.75,-2.25},np.float16)
  local r=np.logical_or(false,a)
  assert(r.dtype=='bool','bool scalar 29 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,true,true,true}),'bool scalar 29 values')
end
do -- logical_or bool scalar 30
  local a=np.array({(0/0),-math.huge,0.0,-math.huge},np.float16)
  local r=np.logical_or(a,true)
  assert(r.dtype=='bool','bool scalar 30 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true}),'bool scalar 30 values')
end
do -- logical_or bool scalar 31
  local a=np.array({-math.huge,1.0,-1.0,3.75},np.float64)
  local r=np.logical_or(true,a)
  assert(r.dtype=='bool','bool scalar 31 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true}),'bool scalar 31 values')
end
do -- logical_xor bool scalar 32
  local a=np.array({1,1,127,0},np.uint32)
  local r=np.logical_xor(a,false)
  assert(r.dtype=='bool','bool scalar 32 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,false}),'bool scalar 32 values')
end
do -- logical_xor bool scalar 33
  local a=np.array({2,-31,-1,-127},np.int16)
  local r=np.logical_xor(false,a)
  assert(r.dtype=='bool','bool scalar 33 dtype '..r.dtype)
  assert(veq(r:tolist(),{true,true,true,true}),'bool scalar 33 values')
end
do -- logical_xor bool scalar 34
  local a=np.array({-127,9,-1,0},np.int8)
  local r=np.logical_xor(a,true)
  assert(r.dtype=='bool','bool scalar 34 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,true}),'bool scalar 34 values')
end
do -- logical_xor bool scalar 35
  local a=np.array({-31,1,-1,63},np.int64)
  local r=np.logical_xor(true,a)
  assert(r.dtype=='bool','bool scalar 35 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,false}),'bool scalar 35 values')
end
do -- maximum bool scalar 36
  local a=np.array({2,63,1,127},np.uint32)
  local r=np.maximum(a,false)
  assert(r.dtype=='uint32','bool scalar 36 dtype '..r.dtype)
  assert(veq(r:tolist(),{2,63,1,127}),'bool scalar 36 values')
end
do -- maximum bool scalar 37
  local a=np.array({0,126,-1,-127},np.int16)
  local r=np.maximum(false,a)
  assert(r.dtype=='int16','bool scalar 37 dtype '..r.dtype)
  assert(veq(r:tolist(),{0,126,0,0}),'bool scalar 37 values')
end
do -- maximum bool scalar 38
  local a=np.array({126,9,126,126},np.int16)
  local r=np.maximum(a,true)
  assert(r.dtype=='int16','bool scalar 38 dtype '..r.dtype)
  assert(veq(r:tolist(),{126,9,126,126}),'bool scalar 38 values')
end
do -- maximum bool scalar 39
  local a=np.array({11.0,11.0,-1.0,-9.5},np.float64)
  local r=np.maximum(true,a)
  assert(r.dtype=='float64','bool scalar 39 dtype '..r.dtype)
  assert(veq(r:tolist(),{11.0,11.0,1.0,1.0}),'bool scalar 39 values')
end
do -- minimum bool scalar 40
  local a=np.array({0,1,127,127},np.uint64)
  local r=np.minimum(a,false)
  assert(r.dtype=='uint64','bool scalar 40 dtype '..r.dtype)
  assert(veq(r:tolist(),{0,0,0,0}),'bool scalar 40 values')
end
do -- minimum bool scalar 41
  local a=np.array({63,1,127,5},np.uint32)
  local r=np.minimum(false,a)
  assert(r.dtype=='uint32','bool scalar 41 dtype '..r.dtype)
  assert(veq(r:tolist(),{0,0,0,0}),'bool scalar 41 values')
end
do -- minimum bool scalar 42
  local a=np.array({9,1,0,-7},np.int8)
  local r=np.minimum(a,true)
  assert(r.dtype=='int8','bool scalar 42 dtype '..r.dtype)
  assert(veq(r:tolist(),{1,1,0,-7}),'bool scalar 42 values')
end
do -- minimum bool scalar 43
  local a=np.array({false,false,false,true},np.bool)
  local r=np.minimum(true,a)
  assert(r.dtype=='bool','bool scalar 43 dtype '..r.dtype)
  assert(veq(r:tolist(),{false,false,false,true}),'bool scalar 43 values')
end
do -- equal out/where 0
  local a=np.array({{1,251,17},{0,63,127}},np.uint16)
  local b=np.array({{251,127,17}},np.uint32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 0')
  assert(o.dtype=='bool','equal out dtype 0')
  assert(veq(o:tolist(),{{false,true,true},{true,false,true}}),'equal out values 0')
end
do -- equal out/where 1
  local a=np.array({{63,1,5},{5,5,2}},np.uint32)
  local b=np.array({{2,17,1}},np.uint64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 1')
  assert(o.dtype=='bool','equal out dtype 1')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'equal out values 1')
end
do -- equal out/where 2
  local a=np.array({{251,251,17},{2,251,5}},np.uint64)
  local b=np.array({{(0/0),0.0,11.0}},np.float64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 2')
  assert(o.dtype=='bool','equal out dtype 2')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'equal out values 2')
end
do -- equal out/where 3
  local a=np.array({{63,251,127},{2,251,0}},np.uint8)
  local b=np.array({{1.0,3.75,-0.0}},np.float32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 3')
  assert(o.dtype=='int8','equal out dtype 3')
  assert(veq(o:tolist(),{{0,7,0},{7,0,7}}),'equal out values 3')
end
do -- equal out/where 4
  local a=np.array({{false,true,false},{false,true,false}},np.bool)
  local b=np.array({{1,126,-127}},np.int16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 4')
  assert(o.dtype=='bool','equal out dtype 4')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'equal out values 4')
end
do -- equal out/where 5
  local a=np.array({{-9.5,-1.0,math.huge},{-2.25,-1.0,0.0}},np.float32)
  local b=np.array({{63,1,9}},np.int32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 5')
  assert(o.dtype=='bool','equal out dtype 5')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'equal out values 5')
end
do -- equal out/where 6
  local a=np.array({{0.0,0.5,11.0},{(0/0),-math.huge,0.0}},np.float64)
  local b=np.array({{-31,2,0}},np.int64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 6')
  assert(o.dtype=='int8','equal out dtype 6')
  assert(veq(o:tolist(),{{0,7,0},{7,0,7}}),'equal out values 6')
end
do -- equal out/where 7
  local a=np.array({{2,127,0},{5,63,127}},np.uint64)
  local b=np.array({{0,1,9}},np.int8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 7')
  assert(o.dtype=='bool','equal out dtype 7')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'equal out values 7')
end
do -- equal out/where 8
  local a=np.array({{0,17,1},{5,2,63}},np.uint32)
  local b=np.array({{2,1,127}},np.uint8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 8')
  assert(o.dtype=='int8','equal out dtype 8')
  assert(veq(o:tolist(),{{0,7,0},{7,0,7}}),'equal out values 8')
end
do -- equal out/where 9
  local a=np.array({{1,63,63},{251,251,5}},np.uint8)
  local b=np.array({{1.0,11.0,-2.25}},np.float64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 9')
  assert(o.dtype=='bool','equal out dtype 9')
  assert(veq(o:tolist(),{{true,true,false},{true,false,true}}),'equal out values 9')
end
do -- equal out/where 10
  local a=np.array({{true,true,false},{true,false,true}},np.bool)
  local b=np.array({{9,2,2}},np.int16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 10')
  assert(o.dtype=='bool','equal out dtype 10')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'equal out values 10')
end
do -- equal out/where 11
  local a=np.array({{63,-7,2},{126,63,1}},np.int64)
  local b=np.array({{(0/0),11.0,-9.5}},np.float32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 11')
  assert(o.dtype=='int8','equal out dtype 11')
  assert(veq(o:tolist(),{{0,7,0},{7,0,7}}),'equal out values 11')
end
do -- equal out/where 12
  local a=np.array({{0.5,-2.25,-2.25},{-0.0,(0/0),1.0}},np.float64)
  local b=np.array({{11.0,11.0,0.5}},np.float64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 12')
  assert(o.dtype=='int8','equal out dtype 12')
  assert(veq(o:tolist(),{{0,7,0},{7,0,7}}),'equal out values 12')
end
do -- equal out/where 13
  local a=np.array({{126,-127,9},{63,-31,9}},np.int64)
  local b=np.array({{17,2,0}},np.uint8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 13')
  assert(o.dtype=='bool','equal out dtype 13')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'equal out values 13')
end
do -- equal out/where 14
  local a=np.array({{1,-7,126},{-127,2,0}},np.int64)
  local b=np.array({{1,5,17}},np.uint32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 14')
  assert(o.dtype=='bool','equal out dtype 14')
  assert(veq(o:tolist(),{{true,true,false},{true,false,true}}),'equal out values 14')
end
do -- equal out/where 15
  local a=np.array({{0,5,0},{5,1,63}},np.uint32)
  local b=np.array({{-127,-1,126}},np.int16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 15')
  assert(o.dtype=='int8','equal out dtype 15')
  assert(veq(o:tolist(),{{0,7,0},{7,0,7}}),'equal out values 15')
end
do -- equal out/where 16
  local a=np.array({{63,-31,1},{-7,126,-31}},np.int8)
  local b=np.array({{false,true,false}},np.bool)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 16')
  assert(o.dtype=='bool','equal out dtype 16')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'equal out values 16')
end
do -- equal out/where 17
  local a=np.array({{0,0,0},{127,2,2}},np.uint32)
  local b=np.array({{2,0,5}},np.uint8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 17')
  assert(o.dtype=='bool','equal out dtype 17')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'equal out values 17')
end
do -- equal out/where 18
  local a=np.array({{9,2,126},{-1,9,9}},np.int16)
  local b=np.array({{17,5,2}},np.uint16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 18')
  assert(o.dtype=='bool','equal out dtype 18')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'equal out values 18')
end
do -- equal out/where 19
  local a=np.array({{false,true,true},{false,false,true}},np.bool)
  local b=np.array({{63,-31,-127}},np.int8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 19')
  assert(o.dtype=='int8','equal out dtype 19')
  assert(veq(o:tolist(),{{0,7,0},{7,0,7}}),'equal out values 19')
end
do -- equal out/where 20
  local a=np.array({{9,1,0},{-1,-1,2}},np.int16)
  local b=np.array({{126,-31,0}},np.int16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 20')
  assert(o.dtype=='bool','equal out dtype 20')
  assert(veq(o:tolist(),{{false,true,true},{true,false,true}}),'equal out values 20')
end
do -- equal out/where 21
  local a=np.array({{127,63,251},{63,63,1}},np.uint8)
  local b=np.array({{0,251,1}},np.uint32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 21')
  assert(o.dtype=='int8','equal out dtype 21')
  assert(veq(o:tolist(),{{0,7,0},{7,0,7}}),'equal out values 21')
end
do -- equal out/where 22
  local a=np.array({{1.0,1.0,-0.0},{11.0,-1.0,-0.0}},np.float64)
  local b=np.array({{63,9,0}},np.int64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 22')
  assert(o.dtype=='int8','equal out dtype 22')
  assert(veq(o:tolist(),{{0,7,1},{7,0,7}}),'equal out values 22')
end
do -- equal out/where 23
  local a=np.array({{63,63,0},{63,63,1}},np.uint32)
  local b=np.array({{-127,126,63}},np.int32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 23')
  assert(o.dtype=='bool','equal out dtype 23')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'equal out values 23')
end
do -- equal out/where 24
  local a=np.array({{17,63,1},{1,2,2}},np.uint8)
  local b=np.array({{11.0,-math.huge,-math.huge}},np.float64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 24')
  assert(o.dtype=='bool','equal out dtype 24')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'equal out values 24')
end
do -- equal out/where 25
  local a=np.array({{1,63,-1},{126,-127,-127}},np.int32)
  local b=np.array({{63,2,0}},np.uint16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 25')
  assert(o.dtype=='bool','equal out dtype 25')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'equal out values 25')
end
do -- equal out/where 26
  local a=np.array({{5,63,5},{1,1,251}},np.uint16)
  local b=np.array({{251,2,2}},np.uint8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 26')
  assert(o.dtype=='bool','equal out dtype 26')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'equal out values 26')
end
do -- equal out/where 27
  local a=np.array({{251,63,17},{5,127,17}},np.uint8)
  local b=np.array({{9,9,-7}},np.int64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 27')
  assert(o.dtype=='int8','equal out dtype 27')
  assert(veq(o:tolist(),{{0,7,0},{7,0,7}}),'equal out values 27')
end
do -- equal out/where 28
  local a=np.array({{-7,63,-31},{-127,9,63}},np.int32)
  local b=np.array({{1,127,17}},np.uint16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 28')
  assert(o.dtype=='int8','equal out dtype 28')
  assert(veq(o:tolist(),{{0,7,0},{7,0,7}}),'equal out values 28')
end
do -- equal out/where 29
  local a=np.array({{2,9,2},{126,1,-127}},np.int64)
  local b=np.array({{true,false,false}},np.bool)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 29')
  assert(o.dtype=='int8','equal out dtype 29')
  assert(veq(o:tolist(),{{0,7,0},{7,0,7}}),'equal out values 29')
end
do -- equal out/where 30
  local a=np.array({{9,126,2},{2,-127,1}},np.int16)
  local b=np.array({{0.5,0.0,-math.huge}},np.float16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 30')
  assert(o.dtype=='int8','equal out dtype 30')
  assert(veq(o:tolist(),{{0,7,0},{7,0,7}}),'equal out values 30')
end
do -- equal out/where 31
  local a=np.array({{1.0,-math.huge,-math.huge},{-1.0,0.0,1.0}},np.float32)
  local b=np.array({{false,false,false}},np.bool)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 31')
  assert(o.dtype=='int8','equal out dtype 31')
  assert(veq(o:tolist(),{{0,7,0},{7,1,7}}),'equal out values 31')
end
do -- equal out/where 32
  local a=np.array({{9,-31,0},{-1,-31,63}},np.int64)
  local b=np.array({{251,0,17}},np.uint64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 32')
  assert(o.dtype=='int8','equal out dtype 32')
  assert(veq(o:tolist(),{{0,7,0},{7,0,7}}),'equal out values 32')
end
do -- equal out/where 33
  local a=np.array({{63,9,-7},{126,9,2}},np.int8)
  local b=np.array({{17,127,1}},np.uint64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 33')
  assert(o.dtype=='bool','equal out dtype 33')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'equal out values 33')
end
do -- equal out/where 34
  local a=np.array({{251,5,127},{17,0,17}},np.uint32)
  local b=np.array({{3.75,0.0,math.huge}},np.float64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.equal(a,b,{out=o,where=m})
  assert(r==o,'equal out identity 34')
  assert(o.dtype=='int8','equal out dtype 34')
  assert(veq(o:tolist(),{{0,7,0},{7,1,7}}),'equal out values 34')
end
do -- logical_or out/where 35
  local a=np.array({{-math.huge,-1.0,-9.5},{math.huge,0.5,3.75}},np.float16)
  local b=np.array({{0,2,2}},np.int8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 35')
  assert(o.dtype=='int8','logical_or out dtype 35')
  assert(veq(o:tolist(),{{1,7,1},{7,1,7}}),'logical_or out values 35')
end
do -- logical_or out/where 36
  local a=np.array({{0,2,127},{2,127,2}},np.uint32)
  local b=np.array({{0.5,-math.huge,0.0}},np.float16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 36')
  assert(o.dtype=='bool','logical_or out dtype 36')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'logical_or out values 36')
end
do -- logical_or out/where 37
  local a=np.array({{127,2,63},{17,127,5}},np.uint64)
  local b=np.array({{-9.5,11.0,math.huge}},np.float16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 37')
  assert(o.dtype=='int8','logical_or out dtype 37')
  assert(veq(o:tolist(),{{1,7,1},{7,1,7}}),'logical_or out values 37')
end
do -- logical_or out/where 38
  local a=np.array({{251,5,251},{63,5,127}},np.uint32)
  local b=np.array({{251,1,0}},np.uint8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 38')
  assert(o.dtype=='int8','logical_or out dtype 38')
  assert(veq(o:tolist(),{{1,7,1},{7,1,7}}),'logical_or out values 38')
end
do -- logical_or out/where 39
  local a=np.array({{-0.0,(0/0),-math.huge},{-2.25,-0.0,11.0}},np.float32)
  local b=np.array({{-7,-7,-1}},np.int8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 39')
  assert(o.dtype=='bool','logical_or out dtype 39')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'logical_or out values 39')
end
do -- logical_or out/where 40
  local a=np.array({{0,5,1},{1,63,1}},np.uint64)
  local b=np.array({{true,true,true}},np.bool)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 40')
  assert(o.dtype=='int8','logical_or out dtype 40')
  assert(veq(o:tolist(),{{1,7,1},{7,1,7}}),'logical_or out values 40')
end
do -- logical_or out/where 41
  local a=np.array({{11.0,1.0,-2.25},{-1.0,-math.huge,-math.huge}},np.float16)
  local b=np.array({{1.0,0.5,1.0}},np.float64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 41')
  assert(o.dtype=='int8','logical_or out dtype 41')
  assert(veq(o:tolist(),{{1,7,1},{7,1,7}}),'logical_or out values 41')
end
do -- logical_or out/where 42
  local a=np.array({{63,251,17},{251,127,251}},np.uint16)
  local b=np.array({{63,-7,126}},np.int64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 42')
  assert(o.dtype=='int8','logical_or out dtype 42')
  assert(veq(o:tolist(),{{1,7,1},{7,1,7}}),'logical_or out values 42')
end
do -- logical_or out/where 43
  local a=np.array({{(0/0),0.5,-math.huge},{0.5,math.huge,0.0}},np.float64)
  local b=np.array({{-127,126,0}},np.int16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 43')
  assert(o.dtype=='bool','logical_or out dtype 43')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'logical_or out values 43')
end
do -- logical_or out/where 44
  local a=np.array({{5,63,2},{127,5,0}},np.uint8)
  local b=np.array({{true,false,true}},np.bool)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 44')
  assert(o.dtype=='bool','logical_or out dtype 44')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'logical_or out values 44')
end
do -- logical_or out/where 45
  local a=np.array({{5,127,127},{63,2,1}},np.uint16)
  local b=np.array({{-7,2,-31}},np.int8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 45')
  assert(o.dtype=='int8','logical_or out dtype 45')
  assert(veq(o:tolist(),{{1,7,1},{7,1,7}}),'logical_or out values 45')
end
do -- logical_or out/where 46
  local a=np.array({{0,-1,-31},{-7,1,63}},np.int32)
  local b=np.array({{1,63,-31}},np.int16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 46')
  assert(o.dtype=='int8','logical_or out dtype 46')
  assert(veq(o:tolist(),{{1,7,1},{7,1,7}}),'logical_or out values 46')
end
do -- logical_or out/where 47
  local a=np.array({{2,251,251},{0,1,5}},np.uint8)
  local b=np.array({{-7,-127,-31}},np.int32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 47')
  assert(o.dtype=='int8','logical_or out dtype 47')
  assert(veq(o:tolist(),{{1,7,1},{7,1,7}}),'logical_or out values 47')
end
do -- logical_or out/where 48
  local a=np.array({{math.huge,(0/0),-2.25},{0.5,0.5,11.0}},np.float64)
  local b=np.array({{251,1,63}},np.uint8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 48')
  assert(o.dtype=='int8','logical_or out dtype 48')
  assert(veq(o:tolist(),{{1,7,1},{7,1,7}}),'logical_or out values 48')
end
do -- logical_or out/where 49
  local a=np.array({{true,false,false},{true,true,false}},np.bool)
  local b=np.array({{0.5,1.0,0.5}},np.float64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 49')
  assert(o.dtype=='int8','logical_or out dtype 49')
  assert(veq(o:tolist(),{{1,7,1},{7,1,7}}),'logical_or out values 49')
end
do -- logical_or out/where 50
  local a=np.array({{0.5,-1.0,1.0},{0.5,-2.25,0.0}},np.float32)
  local b=np.array({{-1.0,-1.0,-9.5}},np.float32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 50')
  assert(o.dtype=='bool','logical_or out dtype 50')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'logical_or out values 50')
end
do -- logical_or out/where 51
  local a=np.array({{1.0,-0.0,0.5},{0.5,11.0,math.huge}},np.float64)
  local b=np.array({{63,63,2}},np.int8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 51')
  assert(o.dtype=='int8','logical_or out dtype 51')
  assert(veq(o:tolist(),{{1,7,1},{7,1,7}}),'logical_or out values 51')
end
do -- logical_or out/where 52
  local a=np.array({{63,-1,-1},{1,-31,-127}},np.int64)
  local b=np.array({{2,1,63}},np.uint64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 52')
  assert(o.dtype=='bool','logical_or out dtype 52')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'logical_or out values 52')
end
do -- logical_or out/where 53
  local a=np.array({{-127,126,0},{-1,126,9}},np.int8)
  local b=np.array({{0.5,(0/0),-2.25}},np.float16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 53')
  assert(o.dtype=='bool','logical_or out dtype 53')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'logical_or out values 53')
end
do -- logical_or out/where 54
  local a=np.array({{-2.25,3.75,math.huge},{-2.25,-0.0,3.75}},np.float16)
  local b=np.array({{-31,1,-31}},np.int8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 54')
  assert(o.dtype=='bool','logical_or out dtype 54')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'logical_or out values 54')
end
do -- logical_or out/where 55
  local a=np.array({{2,0,2},{251,1,17}},np.uint64)
  local b=np.array({{251,63,0}},np.uint8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 55')
  assert(o.dtype=='bool','logical_or out dtype 55')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'logical_or out values 55')
end
do -- logical_or out/where 56
  local a=np.array({{0.5,1.0,-9.5},{(0/0),0.5,1.0}},np.float16)
  local b=np.array({{false,true,true}},np.bool)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 56')
  assert(o.dtype=='bool','logical_or out dtype 56')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'logical_or out values 56')
end
do -- logical_or out/where 57
  local a=np.array({{2,0,-7},{-127,0,1}},np.int32)
  local b=np.array({{0.5,math.huge,math.huge}},np.float16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 57')
  assert(o.dtype=='int8','logical_or out dtype 57')
  assert(veq(o:tolist(),{{1,7,1},{7,1,7}}),'logical_or out values 57')
end
do -- logical_or out/where 58
  local a=np.array({{17,127,127},{5,5,0}},np.uint8)
  local b=np.array({{2,5,127}},np.uint32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 58')
  assert(o.dtype=='int8','logical_or out dtype 58')
  assert(veq(o:tolist(),{{1,7,1},{7,1,7}}),'logical_or out values 58')
end
do -- logical_or out/where 59
  local a=np.array({{2,127,0},{1,2,63}},np.uint8)
  local b=np.array({{0,1,2}},np.uint8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 59')
  assert(o.dtype=='int8','logical_or out dtype 59')
  assert(veq(o:tolist(),{{1,7,1},{7,1,7}}),'logical_or out values 59')
end
do -- logical_or out/where 60
  local a=np.array({{2,0,0},{5,0,0}},np.uint8)
  local b=np.array({{-127,126,126}},np.int32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 60')
  assert(o.dtype=='int8','logical_or out dtype 60')
  assert(veq(o:tolist(),{{1,7,1},{7,1,7}}),'logical_or out values 60')
end
do -- logical_or out/where 61
  local a=np.array({{3.75,math.huge,math.huge},{-9.5,1.0,-math.huge}},np.float16)
  local b=np.array({{9,1,63}},np.int32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 61')
  assert(o.dtype=='int8','logical_or out dtype 61')
  assert(veq(o:tolist(),{{1,7,1},{7,1,7}}),'logical_or out values 61')
end
do -- logical_or out/where 62
  local a=np.array({{9,-31,0},{1,2,63}},np.int64)
  local b=np.array({{0.0,0.0,(0/0)}},np.float32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 62')
  assert(o.dtype=='bool','logical_or out dtype 62')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'logical_or out values 62')
end
do -- logical_or out/where 63
  local a=np.array({{126,126,-127},{126,-1,2}},np.int32)
  local b=np.array({{-1.0,-0.0,(0/0)}},np.float16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 63')
  assert(o.dtype=='bool','logical_or out dtype 63')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'logical_or out values 63')
end
do -- logical_or out/where 64
  local a=np.array({{1,2,251},{127,127,127}},np.uint16)
  local b=np.array({{0,2,0}},np.uint32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 64')
  assert(o.dtype=='bool','logical_or out dtype 64')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'logical_or out values 64')
end
do -- logical_or out/where 65
  local a=np.array({{0.0,-math.huge,0.0},{-9.5,11.0,1.0}},np.float16)
  local b=np.array({{0,5,63}},np.uint32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 65')
  assert(o.dtype=='bool','logical_or out dtype 65')
  assert(veq(o:tolist(),{{false,true,true},{true,true,true}}),'logical_or out values 65')
end
do -- logical_or out/where 66
  local a=np.array({{0,0,1},{127,0,1}},np.uint8)
  local b=np.array({{false,false,false}},np.bool)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 66')
  assert(o.dtype=='bool','logical_or out dtype 66')
  assert(veq(o:tolist(),{{false,true,true},{true,false,true}}),'logical_or out values 66')
end
do -- logical_or out/where 67
  local a=np.array({{2,63,9},{0,126,9}},np.int32)
  local b=np.array({{1.0,0.5,0.5}},np.float32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 67')
  assert(o.dtype=='bool','logical_or out dtype 67')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'logical_or out values 67')
end
do -- logical_or out/where 68
  local a=np.array({{-math.huge,-1.0,0.0},{-0.0,-9.5,-9.5}},np.float64)
  local b=np.array({{-127,-127,9}},np.int64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*7
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 68')
  assert(o.dtype=='int8','logical_or out dtype 68')
  assert(veq(o:tolist(),{{1,7,1},{7,1,7}}),'logical_or out values 68')
end
do -- logical_or out/where 69
  local a=np.array({{63,251,17},{0,251,17}},np.uint64)
  local b=np.array({{-127,0,0}},np.int16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_or(a,b,{out=o,where=m})
  assert(r==o,'logical_or out identity 69')
  assert(o.dtype=='bool','logical_or out dtype 69')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'logical_or out values 69')
end
do -- maximum out/where 70
  local a=np.array({{126,-31,-7},{9,1,-31}},np.int8)
  local b=np.array({{5,1,0}},np.uint64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 70')
  assert(o.dtype=='float64','maximum out dtype 70')
  assert(veq(o:tolist(),{{126.0,7.0,0.0},{7.0,1.0,7.0}}),'maximum out values 70')
end
do -- maximum out/where 71
  local a=np.array({{0,127,2},{63,17,2}},np.uint64)
  local b=np.array({{2,2,251}},np.uint32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint64)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 71')
  assert(o.dtype=='uint64','maximum out dtype 71')
  assert(veq(o:tolist(),{{2,7,251},{7,17,7}}),'maximum out values 71')
end
do -- maximum out/where 72
  local a=np.array({{5,0,2},{1,5,2}},np.uint32)
  local b=np.array({{-7,-127,1}},np.int8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int64)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 72')
  assert(o.dtype=='int64','maximum out dtype 72')
  assert(veq(o:tolist(),{{5,7,2},{7,5,7}}),'maximum out values 72')
end
do -- maximum out/where 73
  local a=np.array({{math.huge,11.0,math.huge},{-1.0,-0.0,math.huge}},np.float16)
  local b=np.array({{17,251,251}},np.uint16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float32)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 73')
  assert(o.dtype=='float32','maximum out dtype 73')
  assert(veq(o:tolist(),{{math.huge,7.0,math.huge},{7.0,251.0,7.0}}),'maximum out values 73')
end
do -- maximum out/where 74
  local a=np.array({{1,-1,9},{1,1,9}},np.int16)
  local b=np.array({{-1,1,-7}},np.int8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int16)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 74')
  assert(o.dtype=='int16','maximum out dtype 74')
  assert(veq(o:tolist(),{{1,7,9},{7,1,7}}),'maximum out values 74')
end
do -- maximum out/where 75
  local a=np.array({{-127,2,-31},{-31,1,1}},np.int8)
  local b=np.array({{63,126,-127}},np.int16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int16)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 75')
  assert(o.dtype=='int16','maximum out dtype 75')
  assert(veq(o:tolist(),{{63,7,-31},{7,126,7}}),'maximum out values 75')
end
do -- maximum out/where 76
  local a=np.array({{false,false,true},{false,true,true}},np.bool)
  local b=np.array({{17,0,5}},np.uint64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint64)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 76')
  assert(o.dtype=='uint64','maximum out dtype 76')
  assert(veq(o:tolist(),{{17,7,5},{7,1,7}}),'maximum out values 76')
end
do -- maximum out/where 77
  local a=np.array({{9,0,-127},{-31,0,-127}},np.int8)
  local b=np.array({{17,63,1}},np.uint16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int32)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 77')
  assert(o.dtype=='int32','maximum out dtype 77')
  assert(veq(o:tolist(),{{17,7,1},{7,63,7}}),'maximum out values 77')
end
do -- maximum out/where 78
  local a=np.array({{true,false,true},{true,false,true}},np.bool)
  local b=np.array({{-1.0,-math.huge,1.0}},np.float32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float32)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 78')
  assert(o.dtype=='float32','maximum out dtype 78')
  assert(veq(o:tolist(),{{1.0,7.0,1.0},{7.0,0.0,7.0}}),'maximum out values 78')
end
do -- maximum out/where 79
  local a=np.array({{251,2,251},{251,0,5}},np.uint8)
  local b=np.array({{-127,-31,-1}},np.int8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int16)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 79')
  assert(o.dtype=='int16','maximum out dtype 79')
  assert(veq(o:tolist(),{{251,7,251},{7,0,7}}),'maximum out values 79')
end
do -- maximum out/where 80
  local a=np.array({{2,0,251},{2,17,63}},np.uint8)
  local b=np.array({{63,1,-127}},np.int32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int32)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 80')
  assert(o.dtype=='int32','maximum out dtype 80')
  assert(veq(o:tolist(),{{63,7,251},{7,17,7}}),'maximum out values 80')
end
do -- maximum out/where 81
  local a=np.array({{0.5,(0/0),1.0},{-math.huge,-9.5,-2.25}},np.float32)
  local b=np.array({{5,1,251}},np.uint16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float32)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 81')
  assert(o.dtype=='float32','maximum out dtype 81')
  assert(veq(o:tolist(),{{5.0,7.0,251.0},{7.0,1.0,7.0}}),'maximum out values 81')
end
do -- maximum out/where 82
  local a=np.array({{0,251,17},{2,251,127}},np.uint32)
  local b=np.array({{false,false,false}},np.bool)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint32)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 82')
  assert(o.dtype=='uint32','maximum out dtype 82')
  assert(veq(o:tolist(),{{0,7,17},{7,251,7}}),'maximum out values 82')
end
do -- maximum out/where 83
  local a=np.array({{(0/0),3.75,-1.0},{math.huge,-9.5,0.5}},np.float16)
  local b=np.array({{1,-127,-31}},np.int16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float32)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 83')
  assert(o.dtype=='float32','maximum out dtype 83')
  assert(veq(o:tolist(),{{(0/0),7.0,-1.0},{7.0,-9.5,7.0}}),'maximum out values 83')
end
do -- maximum out/where 84
  local a=np.array({{0,-7,9},{-7,-1,126}},np.int16)
  local b=np.array({{false,true,false}},np.bool)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int16)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 84')
  assert(o.dtype=='int16','maximum out dtype 84')
  assert(veq(o:tolist(),{{0,7,9},{7,1,7}}),'maximum out values 84')
end
do -- maximum out/where 85
  local a=np.array({{63,1,127},{63,63,251}},np.uint16)
  local b=np.array({{17,2,1}},np.uint8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint16)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 85')
  assert(o.dtype=='uint16','maximum out dtype 85')
  assert(veq(o:tolist(),{{63,7,127},{7,63,7}}),'maximum out values 85')
end
do -- maximum out/where 86
  local a=np.array({{0,63,0},{17,2,127}},np.uint32)
  local b=np.array({{-2.25,-1.0,(0/0)}},np.float32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 86')
  assert(o.dtype=='float64','maximum out dtype 86')
  assert(veq(o:tolist(),{{0.0,7.0,(0/0)},{7.0,2.0,7.0}}),'maximum out values 86')
end
do -- maximum out/where 87
  local a=np.array({{63,-127,2},{-1,-127,126}},np.int16)
  local b=np.array({{5,1,17}},np.uint16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int32)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 87')
  assert(o.dtype=='int32','maximum out dtype 87')
  assert(veq(o:tolist(),{{63,7,17},{7,1,7}}),'maximum out values 87')
end
do -- maximum out/where 88
  local a=np.array({{9,0,-127},{-1,-31,-31}},np.int32)
  local b=np.array({{0,1,9}},np.int32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int32)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 88')
  assert(o.dtype=='int32','maximum out dtype 88')
  assert(veq(o:tolist(),{{9,7,9},{7,1,7}}),'maximum out values 88')
end
do -- maximum out/where 89
  local a=np.array({{1,251,2},{1,2,2}},np.uint64)
  local b=np.array({{0,-7,1}},np.int16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 89')
  assert(o.dtype=='float64','maximum out dtype 89')
  assert(veq(o:tolist(),{{1.0,7.0,2.0},{7.0,2.0,7.0}}),'maximum out values 89')
end
do -- maximum out/where 90
  local a=np.array({{-31,9,9},{9,-7,-7}},np.int8)
  local b=np.array({{0,126,-31}},np.int64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int64)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 90')
  assert(o.dtype=='int64','maximum out dtype 90')
  assert(veq(o:tolist(),{{0,7,9},{7,126,7}}),'maximum out values 90')
end
do -- maximum out/where 91
  local a=np.array({{126,-7,-7},{9,0,1}},np.int16)
  local b=np.array({{9,9,2}},np.int32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int32)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 91')
  assert(o.dtype=='int32','maximum out dtype 91')
  assert(veq(o:tolist(),{{126,7,2},{7,9,7}}),'maximum out values 91')
end
do -- maximum out/where 92
  local a=np.array({{63,2,17},{251,251,251}},np.uint32)
  local b=np.array({{127,2,5}},np.uint64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint64)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 92')
  assert(o.dtype=='uint64','maximum out dtype 92')
  assert(veq(o:tolist(),{{127,7,17},{7,251,7}}),'maximum out values 92')
end
do -- maximum out/where 93
  local a=np.array({{-math.huge,-9.5,-math.huge},{11.0,3.75,-0.0}},np.float64)
  local b=np.array({{1,127,127}},np.uint32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 93')
  assert(o.dtype=='float64','maximum out dtype 93')
  assert(veq(o:tolist(),{{1.0,7.0,127.0},{7.0,127.0,7.0}}),'maximum out values 93')
end
do -- maximum out/where 94
  local a=np.array({{0.0,-0.0,-9.5},{-1.0,3.75,11.0}},np.float16)
  local b=np.array({{1.0,1.0,-0.0}},np.float64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 94')
  assert(o.dtype=='float64','maximum out dtype 94')
  assert(veq(o:tolist(),{{1.0,7.0,-0.0},{7.0,3.75,7.0}}),'maximum out values 94')
end
do -- maximum out/where 95
  local a=np.array({{2,-1,-1},{-7,0,-31}},np.int64)
  local b=np.array({{0,2,251}},np.uint8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int64)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 95')
  assert(o.dtype=='int64','maximum out dtype 95')
  assert(veq(o:tolist(),{{2,7,251},{7,2,7}}),'maximum out values 95')
end
do -- maximum out/where 96
  local a=np.array({{126,-127,9},{126,-1,126}},np.int64)
  local b=np.array({{true,true,false}},np.bool)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int64)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 96')
  assert(o.dtype=='int64','maximum out dtype 96')
  assert(veq(o:tolist(),{{126,7,9},{7,1,7}}),'maximum out values 96')
end
do -- maximum out/where 97
  local a=np.array({{0.5,(0/0),0.5},{11.0,-2.25,0.0}},np.float16)
  local b=np.array({{-127,63,126}},np.int32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 97')
  assert(o.dtype=='float64','maximum out dtype 97')
  assert(veq(o:tolist(),{{0.5,7.0,126.0},{7.0,63.0,7.0}}),'maximum out values 97')
end
do -- maximum out/where 98
  local a=np.array({{true,false,false},{true,true,false}},np.bool)
  local b=np.array({{2,1,5}},np.uint64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint64)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 98')
  assert(o.dtype=='uint64','maximum out dtype 98')
  assert(veq(o:tolist(),{{2,7,5},{7,1,7}}),'maximum out values 98')
end
do -- maximum out/where 99
  local a=np.array({{-31,-1,1},{1,63,63}},np.int8)
  local b=np.array({{-math.huge,-9.5,math.huge}},np.float32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float32)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 99')
  assert(o.dtype=='float32','maximum out dtype 99')
  assert(veq(o:tolist(),{{-31.0,7.0,math.huge},{7.0,63.0,7.0}}),'maximum out values 99')
end
do -- maximum out/where 100
  local a=np.array({{-31,126,9},{-31,-7,126}},np.int64)
  local b=np.array({{0.0,-1.0,0.0}},np.float16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 100')
  assert(o.dtype=='float64','maximum out dtype 100')
  assert(veq(o:tolist(),{{0.0,7.0,9.0},{7.0,-1.0,7.0}}),'maximum out values 100')
end
do -- maximum out/where 101
  local a=np.array({{1.0,-math.huge,-1.0},{0.0,-9.5,-1.0}},np.float16)
  local b=np.array({{127,17,17}},np.uint64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 101')
  assert(o.dtype=='float64','maximum out dtype 101')
  assert(veq(o:tolist(),{{127.0,7.0,17.0},{7.0,17.0,7.0}}),'maximum out values 101')
end
do -- maximum out/where 102
  local a=np.array({{63,-1,63},{63,126,9}},np.int16)
  local b=np.array({{63,5,5}},np.uint64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 102')
  assert(o.dtype=='float64','maximum out dtype 102')
  assert(veq(o:tolist(),{{63.0,7.0,63.0},{7.0,126.0,7.0}}),'maximum out values 102')
end
do -- maximum out/where 103
  local a=np.array({{17,5,5},{17,1,127}},np.uint64)
  local b=np.array({{127,17,127}},np.uint8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint64)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 103')
  assert(o.dtype=='uint64','maximum out dtype 103')
  assert(veq(o:tolist(),{{127,7,127},{7,17,7}}),'maximum out values 103')
end
do -- maximum out/where 104
  local a=np.array({{1,63,63},{127,0,2}},np.uint8)
  local b=np.array({{127,17,5}},np.uint16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint16)*7
  local r=np.maximum(a,b,{out=o,where=m})
  assert(r==o,'maximum out identity 104')
  assert(o.dtype=='uint16','maximum out dtype 104')
  assert(veq(o:tolist(),{{127,7,63},{7,17,7}}),'maximum out values 104')
end
do -- minimum out/where 105
  local a=np.array({{(0/0),-9.5,0.5},{-9.5,11.0,math.huge}},np.float16)
  local b=np.array({{127,0,17}},np.uint64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 105')
  assert(o.dtype=='float64','minimum out dtype 105')
  assert(veq(o:tolist(),{{(0/0),7.0,0.5},{7.0,0.0,7.0}}),'minimum out values 105')
end
do -- minimum out/where 106
  local a=np.array({{5,17,1},{17,127,5}},np.uint64)
  local b=np.array({{5,63,251}},np.uint64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint64)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 106')
  assert(o.dtype=='uint64','minimum out dtype 106')
  assert(veq(o:tolist(),{{5,7,1},{7,63,7}}),'minimum out values 106')
end
do -- minimum out/where 107
  local a=np.array({{2,2,-31},{0,-1,0}},np.int32)
  local b=np.array({{-31,1,2}},np.int16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int32)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 107')
  assert(o.dtype=='int32','minimum out dtype 107')
  assert(veq(o:tolist(),{{-31,7,-31},{7,-1,7}}),'minimum out values 107')
end
do -- minimum out/where 108
  local a=np.array({{-127,126,-127},{63,126,-1}},np.int8)
  local b=np.array({{11.0,0.0,-0.0}},np.float64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 108')
  assert(o.dtype=='float64','minimum out dtype 108')
  assert(veq(o:tolist(),{{-127.0,7.0,-127.0},{7.0,0.0,7.0}}),'minimum out values 108')
end
do -- minimum out/where 109
  local a=np.array({{63,63,-127},{2,-127,2}},np.int16)
  local b=np.array({{63,251,5}},np.uint16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int32)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 109')
  assert(o.dtype=='int32','minimum out dtype 109')
  assert(veq(o:tolist(),{{63,7,-127},{7,-127,7}}),'minimum out values 109')
end
do -- minimum out/where 110
  local a=np.array({{127,5,5},{251,0,5}},np.uint32)
  local b=np.array({{126,9,63}},np.int8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int64)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 110')
  assert(o.dtype=='int64','minimum out dtype 110')
  assert(veq(o:tolist(),{{126,7,5},{7,0,7}}),'minimum out values 110')
end
do -- minimum out/where 111
  local a=np.array({{63,63,2},{2,-31,63}},np.int16)
  local b=np.array({{5,2,1}},np.uint16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int32)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 111')
  assert(o.dtype=='int32','minimum out dtype 111')
  assert(veq(o:tolist(),{{5,7,1},{7,-31,7}}),'minimum out values 111')
end
do -- minimum out/where 112
  local a=np.array({{11.0,-9.5,11.0},{11.0,1.0,-1.0}},np.float64)
  local b=np.array({{-31,-31,63}},np.int64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 112')
  assert(o.dtype=='float64','minimum out dtype 112')
  assert(veq(o:tolist(),{{-31.0,7.0,11.0},{7.0,-31.0,7.0}}),'minimum out values 112')
end
do -- minimum out/where 113
  local a=np.array({{false,false,true},{true,true,true}},np.bool)
  local b=np.array({{-127,9,2}},np.int32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int32)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 113')
  assert(o.dtype=='int32','minimum out dtype 113')
  assert(veq(o:tolist(),{{-127,7,1},{7,1,7}}),'minimum out values 113')
end
do -- minimum out/where 114
  local a=np.array({{-127,126,-1},{1,63,-31}},np.int8)
  local b=np.array({{0,-1,9}},np.int64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int64)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 114')
  assert(o.dtype=='int64','minimum out dtype 114')
  assert(veq(o:tolist(),{{-127,7,-1},{7,-1,7}}),'minimum out values 114')
end
do -- minimum out/where 115
  local a=np.array({{17,0,1},{5,0,17}},np.uint64)
  local b=np.array({{-0.0,0.0,-0.0}},np.float32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 115')
  assert(o.dtype=='float64','minimum out dtype 115')
  assert(veq(o:tolist(),{{-0.0,7.0,-0.0},{7.0,0.0,7.0}}),'minimum out values 115')
end
do -- minimum out/where 116
  local a=np.array({{-127,-31,1},{2,126,63}},np.int64)
  local b=np.array({{5,17,63}},np.uint32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int64)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 116')
  assert(o.dtype=='int64','minimum out dtype 116')
  assert(veq(o:tolist(),{{-127,7,1},{7,17,7}}),'minimum out values 116')
end
do -- minimum out/where 117
  local a=np.array({{2,63,0},{0,251,1}},np.uint8)
  local b=np.array({{127,5,127}},np.uint32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint32)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 117')
  assert(o.dtype=='uint32','minimum out dtype 117')
  assert(veq(o:tolist(),{{2,7,0},{7,5,7}}),'minimum out values 117')
end
do -- minimum out/where 118
  local a=np.array({{127,127,2},{251,5,5}},np.uint8)
  local b=np.array({{-7,63,63}},np.int8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int16)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 118')
  assert(o.dtype=='int16','minimum out dtype 118')
  assert(veq(o:tolist(),{{-7,7,2},{7,5,7}}),'minimum out values 118')
end
do -- minimum out/where 119
  local a=np.array({{126,63,1},{1,-31,2}},np.int8)
  local b=np.array({{3.75,0.0,(0/0)}},np.float64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 119')
  assert(o.dtype=='float64','minimum out dtype 119')
  assert(veq(o:tolist(),{{3.75,7.0,(0/0)},{7.0,-31.0,7.0}}),'minimum out values 119')
end
do -- minimum out/where 120
  local a=np.array({{3.75,-2.25,0.5},{-9.5,-0.0,1.0}},np.float64)
  local b=np.array({{127,17,5}},np.uint32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 120')
  assert(o.dtype=='float64','minimum out dtype 120')
  assert(veq(o:tolist(),{{3.75,7.0,0.5},{7.0,-0.0,7.0}}),'minimum out values 120')
end
do -- minimum out/where 121
  local a=np.array({{0,1,17},{5,2,1}},np.uint32)
  local b=np.array({{-127,-7,63}},np.int32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int64)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 121')
  assert(o.dtype=='int64','minimum out dtype 121')
  assert(veq(o:tolist(),{{-127,7,17},{7,-7,7}}),'minimum out values 121')
end
do -- minimum out/where 122
  local a=np.array({{0.0,11.0,0.5},{0.5,math.huge,11.0}},np.float64)
  local b=np.array({{127,127,17}},np.uint16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 122')
  assert(o.dtype=='float64','minimum out dtype 122')
  assert(veq(o:tolist(),{{0.0,7.0,0.5},{7.0,127.0,7.0}}),'minimum out values 122')
end
do -- minimum out/where 123
  local a=np.array({{false,false,false},{false,true,false}},np.bool)
  local b=np.array({{0,-7,63}},np.int64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int64)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 123')
  assert(o.dtype=='int64','minimum out dtype 123')
  assert(veq(o:tolist(),{{0,7,0},{7,-7,7}}),'minimum out values 123')
end
do -- minimum out/where 124
  local a=np.array({{-31,0,0},{9,-127,-1}},np.int16)
  local b=np.array({{126,2,126}},np.int64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int64)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 124')
  assert(o.dtype=='int64','minimum out dtype 124')
  assert(veq(o:tolist(),{{-31,7,0},{7,-127,7}}),'minimum out values 124')
end
do -- minimum out/where 125
  local a=np.array({{63,1,251},{2,0,63}},np.uint64)
  local b=np.array({{-127,126,-7}},np.int32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 125')
  assert(o.dtype=='float64','minimum out dtype 125')
  assert(veq(o:tolist(),{{-127.0,7.0,-7.0},{7.0,0.0,7.0}}),'minimum out values 125')
end
do -- minimum out/where 126
  local a=np.array({{(0/0),(0/0),0.0},{0.5,0.5,-1.0}},np.float16)
  local b=np.array({{2,5,251}},np.uint32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 126')
  assert(o.dtype=='float64','minimum out dtype 126')
  assert(veq(o:tolist(),{{(0/0),7.0,0.0},{7.0,0.5,7.0}}),'minimum out values 126')
end
do -- minimum out/where 127
  local a=np.array({{false,false,true},{false,true,false}},np.bool)
  local b=np.array({{63,2,17}},np.uint32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint32)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 127')
  assert(o.dtype=='uint32','minimum out dtype 127')
  assert(veq(o:tolist(),{{0,7,1},{7,1,7}}),'minimum out values 127')
end
do -- minimum out/where 128
  local a=np.array({{251,17,251},{127,63,63}},np.uint64)
  local b=np.array({{5,17,5}},np.uint8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint64)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 128')
  assert(o.dtype=='uint64','minimum out dtype 128')
  assert(veq(o:tolist(),{{5,7,5},{7,17,7}}),'minimum out values 128')
end
do -- minimum out/where 129
  local a=np.array({{126,63,63},{63,-7,0}},np.int16)
  local b=np.array({{false,false,false}},np.bool)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int16)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 129')
  assert(o.dtype=='int16','minimum out dtype 129')
  assert(veq(o:tolist(),{{0,7,0},{7,-7,7}}),'minimum out values 129')
end
do -- minimum out/where 130
  local a=np.array({{63,251,1},{2,17,1}},np.uint32)
  local b=np.array({{(0/0),0.5,-math.huge}},np.float16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 130')
  assert(o.dtype=='float64','minimum out dtype 130')
  assert(veq(o:tolist(),{{(0/0),7.0,-math.huge},{7.0,0.5,7.0}}),'minimum out values 130')
end
do -- minimum out/where 131
  local a=np.array({{-7,-31,2},{0,63,-1}},np.int16)
  local b=np.array({{126,9,9}},np.int32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int32)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 131')
  assert(o.dtype=='int32','minimum out dtype 131')
  assert(veq(o:tolist(),{{-7,7,2},{7,9,7}}),'minimum out values 131')
end
do -- minimum out/where 132
  local a=np.array({{-127,63,1},{-31,63,63}},np.int8)
  local b=np.array({{11.0,(0/0),-1.0}},np.float32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float32)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 132')
  assert(o.dtype=='float32','minimum out dtype 132')
  assert(veq(o:tolist(),{{-127.0,7.0,-1.0},{7.0,(0/0),7.0}}),'minimum out values 132')
end
do -- minimum out/where 133
  local a=np.array({{false,false,true},{false,true,false}},np.bool)
  local b=np.array({{17,5,1}},np.uint16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint16)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 133')
  assert(o.dtype=='uint16','minimum out dtype 133')
  assert(veq(o:tolist(),{{0,7,1},{7,1,7}}),'minimum out values 133')
end
do -- minimum out/where 134
  local a=np.array({{(0/0),-2.25,3.75},{-1.0,0.0,0.5}},np.float16)
  local b=np.array({{2,17,0}},np.uint8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float16)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 134')
  assert(o.dtype=='float16','minimum out dtype 134')
  assert(veq(o:tolist(),{{(0/0),7.0,0.0},{7.0,0.0,7.0}}),'minimum out values 134')
end
do -- minimum out/where 135
  local a=np.array({{63,1,63},{126,1,126}},np.int8)
  local b=np.array({{0,1,17}},np.uint32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int64)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 135')
  assert(o.dtype=='int64','minimum out dtype 135')
  assert(veq(o:tolist(),{{0,7,17},{7,1,7}}),'minimum out values 135')
end
do -- minimum out/where 136
  local a=np.array({{-math.huge,-0.0,-math.huge},{-2.25,math.huge,0.5}},np.float16)
  local b=np.array({{1,-7,9}},np.int64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 136')
  assert(o.dtype=='float64','minimum out dtype 136')
  assert(veq(o:tolist(),{{-math.huge,7.0,-math.huge},{7.0,-7.0,7.0}}),'minimum out values 136')
end
do -- minimum out/where 137
  local a=np.array({{-1,0,63},{1,-127,126}},np.int16)
  local b=np.array({{63,-7,-31}},np.int32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int32)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 137')
  assert(o.dtype=='int32','minimum out dtype 137')
  assert(veq(o:tolist(),{{-1,7,-31},{7,-127,7}}),'minimum out values 137')
end
do -- minimum out/where 138
  local a=np.array({{0.5,-2.25,-math.huge},{0.0,-math.huge,-9.5}},np.float64)
  local b=np.array({{1,126,1}},np.int8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 138')
  assert(o.dtype=='float64','minimum out dtype 138')
  assert(veq(o:tolist(),{{0.5,7.0,-math.huge},{7.0,-math.huge,7.0}}),'minimum out values 138')
end
do -- minimum out/where 139
  local a=np.array({{251,5,0},{127,17,2}},np.uint32)
  local b=np.array({{true,true,false}},np.bool)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint32)*7
  local r=np.minimum(a,b,{out=o,where=m})
  assert(r==o,'minimum out identity 139')
  assert(o.dtype=='uint32','minimum out dtype 139')
  assert(veq(o:tolist(),{{1,7,0},{7,1,7}}),'minimum out values 139')
end
do -- negative unary 0
  local a=(np.array({{1,63,2},{0,127,251}},np.uint16)).T
  local r=np.negative(a)
  assert(r.dtype=='uint16','negative unary dtype 0')
  assert(seqeq(r.shape,{3,2}),'negative unary shape 0')
  assert(seqeq(r.strides,{2,6}),'negative unary strides 0')
  assert(veq(r:tolist(),{{65535,0},{65473,65409},{65534,65285}}),'negative unary values 0')
end
do -- negative unary 1
  local a=(np.array({{-1.0,-9.5,0.5},{0.5,(0/0),0.0}},np.float64)).T
  local r=np.negative(a)
  assert(r.dtype=='float64','negative unary dtype 1')
  assert(seqeq(r.shape,{3,2}),'negative unary shape 1')
  assert(seqeq(r.strides,{8,24}),'negative unary strides 1')
  assert(veq(r:tolist(),{{1.0,-0.5},{9.5,(0/0)},{-0.5,-0.0}}),'negative unary values 1')
end
do -- negative unary 2
  local a=np.array({5,5,0,251,5},np.uint16)
  local r=np.negative(a)
  assert(r.dtype=='uint16','negative unary dtype 2')
  assert(seqeq(r.shape,{5}),'negative unary shape 2')
  assert(seqeq(r.strides,{2}),'negative unary strides 2')
  assert(veq(r:tolist(),{65531,65531,0,65285,65531}),'negative unary values 2')
end
do -- negative unary 3
  local a=np.array({{1,2,63},{1,2,17}},np.uint64)
  local r=np.negative(a)
  assert(r.dtype=='uint64','negative unary dtype 3')
  assert(seqeq(r.shape,{2,3}),'negative unary shape 3')
  assert(seqeq(r.strides,{24,8}),'negative unary strides 3')
  assert(veq(r:tolist(),{{18446744073709551615,18446744073709551614,18446744073709551553},{18446744073709551615,18446744073709551614,18446744073709551599}}),'negative unary values 3')
end
do -- negative unary 4
  local a=np.array({127,127,127,0,63},np.uint64)
  local r=np.negative(a)
  assert(r.dtype=='uint64','negative unary dtype 4')
  assert(seqeq(r.shape,{5}),'negative unary shape 4')
  assert(seqeq(r.strides,{8}),'negative unary strides 4')
  assert(veq(r:tolist(),{18446744073709551489,18446744073709551489,18446744073709551489,0,18446744073709551553}),'negative unary values 4')
end
do -- negative unary 5
  local a=np.array({-31,-7,-1,1,126},np.int16)
  local r=np.negative(a)
  assert(r.dtype=='int16','negative unary dtype 5')
  assert(seqeq(r.shape,{5}),'negative unary shape 5')
  assert(seqeq(r.strides,{2}),'negative unary strides 5')
  assert(veq(r:tolist(),{31,7,1,-1,-126}),'negative unary values 5')
end
do -- negative unary 6
  local a=np.array({3.75,1.0,0.0,0.0,1.0},np.float64)
  local r=np.negative(a)
  assert(r.dtype=='float64','negative unary dtype 6')
  assert(seqeq(r.shape,{5}),'negative unary shape 6')
  assert(seqeq(r.strides,{8}),'negative unary strides 6')
  assert(veq(r:tolist(),{-3.75,-1.0,-0.0,-0.0,-1.0}),'negative unary values 6')
end
do -- negative bool/error 7
  local a=np.array({false,false,false,true,true},np.bool)
  local ok=pcall(function() return np.negative(a) end)
  assert(not ok,'negative expected error 7')
end
do -- negative unary 8
  local a=np.array({{(0/0),(0/0),3.75},{-math.huge,-2.25,1.0}},np.float32)
  local r=np.negative(a)
  assert(r.dtype=='float32','negative unary dtype 8')
  assert(seqeq(r.shape,{2,3}),'negative unary shape 8')
  assert(seqeq(r.strides,{12,4}),'negative unary strides 8')
  assert(veq(r:tolist(),{{(0/0),(0/0),-3.75},{math.huge,2.25,-1.0}}),'negative unary values 8')
end
do -- negative unary 9
  local a=np.array({{2,5,251},{2,63,127}},np.uint32)
  local r=np.negative(a)
  assert(r.dtype=='uint32','negative unary dtype 9')
  assert(seqeq(r.shape,{2,3}),'negative unary shape 9')
  assert(seqeq(r.strides,{12,4}),'negative unary strides 9')
  assert(veq(r:tolist(),{{4294967294,4294967291,4294967045},{4294967294,4294967233,4294967169}}),'negative unary values 9')
end
do -- negative unary 10
  local a=np.array({1,17,251,0,127},np.uint8)
  local r=np.negative(a)
  assert(r.dtype=='uint8','negative unary dtype 10')
  assert(seqeq(r.shape,{5}),'negative unary shape 10')
  assert(seqeq(r.strides,{1}),'negative unary strides 10')
  assert(veq(r:tolist(),{255,239,5,0,129}),'negative unary values 10')
end
do -- negative unary 11
  local a=np.array({1,1,2,-127,-1},np.int8)
  local r=np.negative(a)
  assert(r.dtype=='int8','negative unary dtype 11')
  assert(seqeq(r.shape,{5}),'negative unary shape 11')
  assert(seqeq(r.strides,{1}),'negative unary strides 11')
  assert(veq(r:tolist(),{-1,-1,-2,127,1}),'negative unary values 11')
end
do -- negative unary 12
  local a=np.array({2,1,0,251,251},np.uint64)
  local r=np.negative(a)
  assert(r.dtype=='uint64','negative unary dtype 12')
  assert(seqeq(r.shape,{5}),'negative unary shape 12')
  assert(seqeq(r.strides,{8}),'negative unary strides 12')
  assert(veq(r:tolist(),{18446744073709551614,18446744073709551615,0,18446744073709551365,18446744073709551365}),'negative unary values 12')
end
do -- negative unary 13
  local a=np.array({{126,2,1},{-127,126,9}},np.int32)
  local r=np.negative(a)
  assert(r.dtype=='int32','negative unary dtype 13')
  assert(seqeq(r.shape,{2,3}),'negative unary shape 13')
  assert(seqeq(r.strides,{12,4}),'negative unary strides 13')
  assert(veq(r:tolist(),{{-126,-2,-1},{127,-126,-9}}),'negative unary values 13')
end
do -- negative unary 14
  local a=np.array({-31,63,-7,126,-7},np.int32)
  local r=np.negative(a)
  assert(r.dtype=='int32','negative unary dtype 14')
  assert(seqeq(r.shape,{5}),'negative unary shape 14')
  assert(seqeq(r.strides,{4}),'negative unary strides 14')
  assert(veq(r:tolist(),{31,-63,7,-126,7}),'negative unary values 14')
end
do -- negative unary 15
  local a=(np.array({{63,-127,-127},{63,2,-1}},np.int32)).T
  local r=np.negative(a)
  assert(r.dtype=='int32','negative unary dtype 15')
  assert(seqeq(r.shape,{3,2}),'negative unary shape 15')
  assert(seqeq(r.strides,{4,12}),'negative unary strides 15')
  assert(veq(r:tolist(),{{-63,-63},{127,-2},{127,1}}),'negative unary values 15')
end
do -- negative unary 16
  local a=np.array({{-2.25,math.huge,-9.5},{-0.0,-9.5,-1.0}},np.float64)
  local r=np.negative(a)
  assert(r.dtype=='float64','negative unary dtype 16')
  assert(seqeq(r.shape,{2,3}),'negative unary shape 16')
  assert(seqeq(r.strides,{24,8}),'negative unary strides 16')
  assert(veq(r:tolist(),{{2.25,-math.huge,9.5},{0.0,9.5,1.0}}),'negative unary values 16')
end
do -- negative unary 17
  local a=np.array({63,-127,-127,1,2},np.int64)
  local r=np.negative(a)
  assert(r.dtype=='int64','negative unary dtype 17')
  assert(seqeq(r.shape,{5}),'negative unary shape 17')
  assert(seqeq(r.strides,{8}),'negative unary strides 17')
  assert(veq(r:tolist(),{-63,127,127,-1,-2}),'negative unary values 17')
end
do -- negative unary 18
  local a=(np.array({{-31,0,-1},{2,0,126}},np.int64)).T
  local r=np.negative(a)
  assert(r.dtype=='int64','negative unary dtype 18')
  assert(seqeq(r.shape,{3,2}),'negative unary shape 18')
  assert(seqeq(r.strides,{8,24}),'negative unary strides 18')
  assert(veq(r:tolist(),{{31,-2},{0,0},{1,-126}}),'negative unary values 18')
end
do -- negative unary 19
  local a=np.array({2,1,5,0,17},np.uint64)
  local r=np.negative(a)
  assert(r.dtype=='uint64','negative unary dtype 19')
  assert(seqeq(r.shape,{5}),'negative unary shape 19')
  assert(seqeq(r.strides,{8}),'negative unary strides 19')
  assert(veq(r:tolist(),{18446744073709551614,18446744073709551615,18446744073709551611,0,18446744073709551599}),'negative unary values 19')
end
do -- negative unary 20
  local a=np.array({(0/0),0.5,math.huge,0.0,-9.5},np.float64)
  local r=np.negative(a)
  assert(r.dtype=='float64','negative unary dtype 20')
  assert(seqeq(r.shape,{5}),'negative unary shape 20')
  assert(seqeq(r.strides,{8}),'negative unary strides 20')
  assert(veq(r:tolist(),{(0/0),-0.5,-math.huge,-0.0,9.5}),'negative unary values 20')
end
do -- negative unary 21
  local a=(np.array({{-1,9,-7},{2,-1,-127}},np.int8)).T
  local r=np.negative(a)
  assert(r.dtype=='int8','negative unary dtype 21')
  assert(seqeq(r.shape,{3,2}),'negative unary shape 21')
  assert(seqeq(r.strides,{1,3}),'negative unary strides 21')
  assert(veq(r:tolist(),{{1,-2},{-9,1},{7,127}}),'negative unary values 21')
end
do -- negative unary 22
  local a=(np.array({{-1.0,-0.0,math.huge},{3.75,-1.0,-2.25}},np.float16)).T
  local r=np.negative(a)
  assert(r.dtype=='float16','negative unary dtype 22')
  assert(seqeq(r.shape,{3,2}),'negative unary shape 22')
  assert(seqeq(r.strides,{2,6}),'negative unary strides 22')
  assert(veq(r:tolist(),{{1.0,-3.75},{0.0,1.0},{-math.huge,2.25}}),'negative unary values 22')
end
do -- negative unary 23
  local a=np.array({{2,5,5},{5,63,63}},np.uint32)
  local r=np.negative(a)
  assert(r.dtype=='uint32','negative unary dtype 23')
  assert(seqeq(r.shape,{2,3}),'negative unary shape 23')
  assert(seqeq(r.strides,{12,4}),'negative unary strides 23')
  assert(veq(r:tolist(),{{4294967294,4294967291,4294967291},{4294967291,4294967233,4294967233}}),'negative unary values 23')
end
do -- negative unary 24
  local a=np.array({2,9,-31,63,-1},np.int32)
  local r=np.negative(a)
  assert(r.dtype=='int32','negative unary dtype 24')
  assert(seqeq(r.shape,{5}),'negative unary shape 24')
  assert(seqeq(r.strides,{4}),'negative unary strides 24')
  assert(veq(r:tolist(),{-2,-9,31,-63,1}),'negative unary values 24')
end
do -- negative unary 25
  local a=np.array({{0,-31,0},{-127,2,1}},np.int16)
  local r=np.negative(a)
  assert(r.dtype=='int16','negative unary dtype 25')
  assert(seqeq(r.shape,{2,3}),'negative unary shape 25')
  assert(seqeq(r.strides,{6,2}),'negative unary strides 25')
  assert(veq(r:tolist(),{{0,31,0},{127,-2,-1}}),'negative unary values 25')
end
do -- negative unary 26
  local a=np.array({{63,0,0},{251,2,17}},np.uint8)
  local r=np.negative(a)
  assert(r.dtype=='uint8','negative unary dtype 26')
  assert(seqeq(r.shape,{2,3}),'negative unary shape 26')
  assert(seqeq(r.strides,{3,1}),'negative unary strides 26')
  assert(veq(r:tolist(),{{193,0,0},{5,254,239}}),'negative unary values 26')
end
do -- negative unary 27
  local a=np.array({{1.0,(0/0),-9.5},{1.0,-0.0,11.0}},np.float32)
  local r=np.negative(a)
  assert(r.dtype=='float32','negative unary dtype 27')
  assert(seqeq(r.shape,{2,3}),'negative unary shape 27')
  assert(seqeq(r.strides,{12,4}),'negative unary strides 27')
  assert(veq(r:tolist(),{{-1.0,(0/0),9.5},{-1.0,0.0,-11.0}}),'negative unary values 27')
end
do -- negative unary 28
  local a=np.array({{1,251,2},{63,5,17}},np.uint64)
  local r=np.negative(a)
  assert(r.dtype=='uint64','negative unary dtype 28')
  assert(seqeq(r.shape,{2,3}),'negative unary shape 28')
  assert(seqeq(r.strides,{24,8}),'negative unary strides 28')
  assert(veq(r:tolist(),{{18446744073709551615,18446744073709551365,18446744073709551614},{18446744073709551553,18446744073709551611,18446744073709551599}}),'negative unary values 28')
end
do -- negative unary 29
  local a=np.array({{2,251,127},{5,5,1}},np.uint8)
  local r=np.negative(a)
  assert(r.dtype=='uint8','negative unary dtype 29')
  assert(seqeq(r.shape,{2,3}),'negative unary shape 29')
  assert(seqeq(r.strides,{3,1}),'negative unary strides 29')
  assert(veq(r:tolist(),{{254,5,129},{251,251,255}}),'negative unary values 29')
end
do -- negative unary 30
  local a=np.array({9,1,63,-1,9},np.int32)
  local r=np.negative(a)
  assert(r.dtype=='int32','negative unary dtype 30')
  assert(seqeq(r.shape,{5}),'negative unary shape 30')
  assert(seqeq(r.strides,{4}),'negative unary strides 30')
  assert(veq(r:tolist(),{-9,-1,-63,1,-9}),'negative unary values 30')
end
do -- negative unary 31
  local a=np.array({2,5,5,127,0},np.uint64)
  local r=np.negative(a)
  assert(r.dtype=='uint64','negative unary dtype 31')
  assert(seqeq(r.shape,{5}),'negative unary shape 31')
  assert(seqeq(r.strides,{8}),'negative unary strides 31')
  assert(veq(r:tolist(),{18446744073709551614,18446744073709551611,18446744073709551611,18446744073709551489,0}),'negative unary values 31')
end
do -- negative unary 32
  local a=np.array({127,1,5,127,63},np.uint16)
  local r=np.negative(a)
  assert(r.dtype=='uint16','negative unary dtype 32')
  assert(seqeq(r.shape,{5}),'negative unary shape 32')
  assert(seqeq(r.strides,{2}),'negative unary strides 32')
  assert(veq(r:tolist(),{65409,65535,65531,65409,65473}),'negative unary values 32')
end
do -- negative unary 33
  local a=np.array({-127,9,-31,2,-31},np.int16)
  local r=np.negative(a)
  assert(r.dtype=='int16','negative unary dtype 33')
  assert(seqeq(r.shape,{5}),'negative unary shape 33')
  assert(seqeq(r.strides,{2}),'negative unary strides 33')
  assert(veq(r:tolist(),{127,-9,31,-2,31}),'negative unary values 33')
end
do -- negative unary 34
  local a=np.array({11.0,(0/0),-1.0,-9.5,-1.0},np.float16)
  local r=np.negative(a)
  assert(r.dtype=='float16','negative unary dtype 34')
  assert(seqeq(r.shape,{5}),'negative unary shape 34')
  assert(seqeq(r.strides,{2}),'negative unary strides 34')
  assert(veq(r:tolist(),{-11.0,(0/0),1.0,9.5,1.0}),'negative unary values 34')
end
do -- absolute unary 35
  local a=np.array({2,-127,-1,1,-7},np.int16)
  local r=np.absolute(a)
  assert(r.dtype=='int16','absolute unary dtype 35')
  assert(seqeq(r.shape,{5}),'absolute unary shape 35')
  assert(seqeq(r.strides,{2}),'absolute unary strides 35')
  assert(veq(r:tolist(),{2,127,1,1,7}),'absolute unary values 35')
end
do -- absolute unary 36
  local a=np.array({{126,0,1},{-1,-31,-31}},np.int64)
  local r=np.absolute(a)
  assert(r.dtype=='int64','absolute unary dtype 36')
  assert(seqeq(r.shape,{2,3}),'absolute unary shape 36')
  assert(seqeq(r.strides,{24,8}),'absolute unary strides 36')
  assert(veq(r:tolist(),{{126,0,1},{1,31,31}}),'absolute unary values 36')
end
do -- absolute unary 37
  local a=np.array({{true,false,false},{true,true,false}},np.bool)
  local r=np.absolute(a)
  assert(r.dtype=='bool','absolute unary dtype 37')
  assert(seqeq(r.shape,{2,3}),'absolute unary shape 37')
  assert(seqeq(r.strides,{3,1}),'absolute unary strides 37')
  assert(veq(r:tolist(),{{true,false,false},{true,true,false}}),'absolute unary values 37')
end
do -- absolute unary 38
  local a=np.array({251,251,127,0,2},np.uint64)
  local r=np.absolute(a)
  assert(r.dtype=='uint64','absolute unary dtype 38')
  assert(seqeq(r.shape,{5}),'absolute unary shape 38')
  assert(seqeq(r.strides,{8}),'absolute unary strides 38')
  assert(veq(r:tolist(),{251,251,127,0,2}),'absolute unary values 38')
end
do -- absolute unary 39
  local a=np.array({{63,-127,0},{1,1,-31}},np.int8)
  local r=np.absolute(a)
  assert(r.dtype=='int8','absolute unary dtype 39')
  assert(seqeq(r.shape,{2,3}),'absolute unary shape 39')
  assert(seqeq(r.strides,{3,1}),'absolute unary strides 39')
  assert(veq(r:tolist(),{{63,127,0},{1,1,31}}),'absolute unary values 39')
end
do -- absolute unary 40
  local a=np.array({{true,true,false},{false,false,true}},np.bool)
  local r=np.absolute(a)
  assert(r.dtype=='bool','absolute unary dtype 40')
  assert(seqeq(r.shape,{2,3}),'absolute unary shape 40')
  assert(seqeq(r.strides,{3,1}),'absolute unary strides 40')
  assert(veq(r:tolist(),{{true,true,false},{false,false,true}}),'absolute unary values 40')
end
do -- absolute unary 41
  local a=np.array({-math.huge,(0/0),math.huge,-9.5,-math.huge},np.float16)
  local r=np.absolute(a)
  assert(r.dtype=='float16','absolute unary dtype 41')
  assert(seqeq(r.shape,{5}),'absolute unary shape 41')
  assert(seqeq(r.strides,{2}),'absolute unary strides 41')
  assert(veq(r:tolist(),{math.huge,(0/0),math.huge,9.5,math.huge}),'absolute unary values 41')
end
do -- absolute unary 42
  local a=(np.array({{-1,-127,63},{0,-1,1}},np.int16)).T
  local r=np.absolute(a)
  assert(r.dtype=='int16','absolute unary dtype 42')
  assert(seqeq(r.shape,{3,2}),'absolute unary shape 42')
  assert(seqeq(r.strides,{2,6}),'absolute unary strides 42')
  assert(veq(r:tolist(),{{1,0},{127,1},{63,1}}),'absolute unary values 42')
end
do -- absolute unary 43
  local a=np.array({-math.huge,0.0,3.75,0.5,-2.25},np.float16)
  local r=np.absolute(a)
  assert(r.dtype=='float16','absolute unary dtype 43')
  assert(seqeq(r.shape,{5}),'absolute unary shape 43')
  assert(seqeq(r.strides,{2}),'absolute unary strides 43')
  assert(veq(r:tolist(),{math.huge,0.0,3.75,0.5,2.25}),'absolute unary values 43')
end
do -- absolute unary 44
  local a=np.array({251,63,63,0,127},np.uint16)
  local r=np.absolute(a)
  assert(r.dtype=='uint16','absolute unary dtype 44')
  assert(seqeq(r.shape,{5}),'absolute unary shape 44')
  assert(seqeq(r.strides,{2}),'absolute unary strides 44')
  assert(veq(r:tolist(),{251,63,63,0,127}),'absolute unary values 44')
end
do -- absolute unary 45
  local a=np.array({-127,9,0,2,9},np.int16)
  local r=np.absolute(a)
  assert(r.dtype=='int16','absolute unary dtype 45')
  assert(seqeq(r.shape,{5}),'absolute unary shape 45')
  assert(seqeq(r.strides,{2}),'absolute unary strides 45')
  assert(veq(r:tolist(),{127,9,0,2,9}),'absolute unary values 45')
end
do -- absolute unary 46
  local a=np.array({{0,17,251},{2,1,5}},np.uint64)
  local r=np.absolute(a)
  assert(r.dtype=='uint64','absolute unary dtype 46')
  assert(seqeq(r.shape,{2,3}),'absolute unary shape 46')
  assert(seqeq(r.strides,{24,8}),'absolute unary strides 46')
  assert(veq(r:tolist(),{{0,17,251},{2,1,5}}),'absolute unary values 46')
end
do -- absolute unary 47
  local a=np.array({1.0,0.5,0.0,-math.huge,(0/0)},np.float64)
  local r=np.absolute(a)
  assert(r.dtype=='float64','absolute unary dtype 47')
  assert(seqeq(r.shape,{5}),'absolute unary shape 47')
  assert(seqeq(r.strides,{8}),'absolute unary strides 47')
  assert(veq(r:tolist(),{1.0,0.5,0.0,math.huge,(0/0)}),'absolute unary values 47')
end
do -- absolute unary 48
  local a=np.array({0,1,17,5,251},np.uint16)
  local r=np.absolute(a)
  assert(r.dtype=='uint16','absolute unary dtype 48')
  assert(seqeq(r.shape,{5}),'absolute unary shape 48')
  assert(seqeq(r.strides,{2}),'absolute unary strides 48')
  assert(veq(r:tolist(),{0,1,17,5,251}),'absolute unary values 48')
end
do -- absolute unary 49
  local a=np.array({{251,5,1},{127,1,0}},np.uint16)
  local r=np.absolute(a)
  assert(r.dtype=='uint16','absolute unary dtype 49')
  assert(seqeq(r.shape,{2,3}),'absolute unary shape 49')
  assert(seqeq(r.strides,{6,2}),'absolute unary strides 49')
  assert(veq(r:tolist(),{{251,5,1},{127,1,0}}),'absolute unary values 49')
end
do -- absolute unary 50
  local a=(np.array({{63,63,1},{0,17,251}},np.uint64)).T
  local r=np.absolute(a)
  assert(r.dtype=='uint64','absolute unary dtype 50')
  assert(seqeq(r.shape,{3,2}),'absolute unary shape 50')
  assert(seqeq(r.strides,{8,24}),'absolute unary strides 50')
  assert(veq(r:tolist(),{{63,0},{63,17},{1,251}}),'absolute unary values 50')
end
do -- absolute unary 51
  local a=np.array({-127,63,-7,126,2},np.int8)
  local r=np.absolute(a)
  assert(r.dtype=='int8','absolute unary dtype 51')
  assert(seqeq(r.shape,{5}),'absolute unary shape 51')
  assert(seqeq(r.strides,{1}),'absolute unary strides 51')
  assert(veq(r:tolist(),{127,63,7,126,2}),'absolute unary values 51')
end
do -- absolute unary 52
  local a=(np.array({{-31,-31,126},{-7,0,0}},np.int8)).T
  local r=np.absolute(a)
  assert(r.dtype=='int8','absolute unary dtype 52')
  assert(seqeq(r.shape,{3,2}),'absolute unary shape 52')
  assert(seqeq(r.strides,{1,3}),'absolute unary strides 52')
  assert(veq(r:tolist(),{{31,7},{31,0},{126,0}}),'absolute unary values 52')
end
do -- absolute unary 53
  local a=np.array({{0,251,127},{2,1,17}},np.uint8)
  local r=np.absolute(a)
  assert(r.dtype=='uint8','absolute unary dtype 53')
  assert(seqeq(r.shape,{2,3}),'absolute unary shape 53')
  assert(seqeq(r.strides,{3,1}),'absolute unary strides 53')
  assert(veq(r:tolist(),{{0,251,127},{2,1,17}}),'absolute unary values 53')
end
do -- absolute unary 54
  local a=(np.array({{9,-1,-127},{126,9,126}},np.int16)).T
  local r=np.absolute(a)
  assert(r.dtype=='int16','absolute unary dtype 54')
  assert(seqeq(r.shape,{3,2}),'absolute unary shape 54')
  assert(seqeq(r.strides,{2,6}),'absolute unary strides 54')
  assert(veq(r:tolist(),{{9,126},{1,9},{127,126}}),'absolute unary values 54')
end
do -- absolute unary 55
  local a=np.array({{126,63,-31},{0,-1,-127}},np.int32)
  local r=np.absolute(a)
  assert(r.dtype=='int32','absolute unary dtype 55')
  assert(seqeq(r.shape,{2,3}),'absolute unary shape 55')
  assert(seqeq(r.strides,{12,4}),'absolute unary strides 55')
  assert(veq(r:tolist(),{{126,63,31},{0,1,127}}),'absolute unary values 55')
end
do -- absolute unary 56
  local a=np.array({-1,-1,0,0,0},np.int16)
  local r=np.absolute(a)
  assert(r.dtype=='int16','absolute unary dtype 56')
  assert(seqeq(r.shape,{5}),'absolute unary shape 56')
  assert(seqeq(r.strides,{2}),'absolute unary strides 56')
  assert(veq(r:tolist(),{1,1,0,0,0}),'absolute unary values 56')
end
do -- absolute unary 57
  local a=np.array({3.75,-2.25,0.5,(0/0),math.huge},np.float64)
  local r=np.absolute(a)
  assert(r.dtype=='float64','absolute unary dtype 57')
  assert(seqeq(r.shape,{5}),'absolute unary shape 57')
  assert(seqeq(r.strides,{8}),'absolute unary strides 57')
  assert(veq(r:tolist(),{3.75,2.25,0.5,(0/0),math.huge}),'absolute unary values 57')
end
do -- absolute unary 58
  local a=np.array({126,126,63,-31,0},np.int8)
  local r=np.absolute(a)
  assert(r.dtype=='int8','absolute unary dtype 58')
  assert(seqeq(r.shape,{5}),'absolute unary shape 58')
  assert(seqeq(r.strides,{1}),'absolute unary strides 58')
  assert(veq(r:tolist(),{126,126,63,31,0}),'absolute unary values 58')
end
do -- absolute unary 59
  local a=np.array({{11.0,math.huge,11.0},{1.0,-0.0,3.75}},np.float64)
  local r=np.absolute(a)
  assert(r.dtype=='float64','absolute unary dtype 59')
  assert(seqeq(r.shape,{2,3}),'absolute unary shape 59')
  assert(seqeq(r.strides,{24,8}),'absolute unary strides 59')
  assert(veq(r:tolist(),{{11.0,math.huge,11.0},{1.0,0.0,3.75}}),'absolute unary values 59')
end
do -- absolute unary 60
  local a=np.array({{1,0,2},{63,1,251}},np.uint16)
  local r=np.absolute(a)
  assert(r.dtype=='uint16','absolute unary dtype 60')
  assert(seqeq(r.shape,{2,3}),'absolute unary shape 60')
  assert(seqeq(r.strides,{6,2}),'absolute unary strides 60')
  assert(veq(r:tolist(),{{1,0,2},{63,1,251}}),'absolute unary values 60')
end
do -- absolute unary 61
  local a=np.array({0,9,1,-7,9},np.int32)
  local r=np.absolute(a)
  assert(r.dtype=='int32','absolute unary dtype 61')
  assert(seqeq(r.shape,{5}),'absolute unary shape 61')
  assert(seqeq(r.strides,{4}),'absolute unary strides 61')
  assert(veq(r:tolist(),{0,9,1,7,9}),'absolute unary values 61')
end
do -- absolute unary 62
  local a=np.array({{9,1,-7},{-127,-127,9}},np.int16)
  local r=np.absolute(a)
  assert(r.dtype=='int16','absolute unary dtype 62')
  assert(seqeq(r.shape,{2,3}),'absolute unary shape 62')
  assert(seqeq(r.strides,{6,2}),'absolute unary strides 62')
  assert(veq(r:tolist(),{{9,1,7},{127,127,9}}),'absolute unary values 62')
end
do -- absolute unary 63
  local a=np.array({0,1,0,17,0},np.uint64)
  local r=np.absolute(a)
  assert(r.dtype=='uint64','absolute unary dtype 63')
  assert(seqeq(r.shape,{5}),'absolute unary shape 63')
  assert(seqeq(r.strides,{8}),'absolute unary strides 63')
  assert(veq(r:tolist(),{0,1,0,17,0}),'absolute unary values 63')
end
do -- absolute unary 64
  local a=(np.array({{5,251,1},{251,63,251}},np.uint32)).T
  local r=np.absolute(a)
  assert(r.dtype=='uint32','absolute unary dtype 64')
  assert(seqeq(r.shape,{3,2}),'absolute unary shape 64')
  assert(seqeq(r.strides,{4,12}),'absolute unary strides 64')
  assert(veq(r:tolist(),{{5,251},{251,63},{1,251}}),'absolute unary values 64')
end
do -- absolute unary 65
  local a=np.array({-7,63,2,2,1},np.int32)
  local r=np.absolute(a)
  assert(r.dtype=='int32','absolute unary dtype 65')
  assert(seqeq(r.shape,{5}),'absolute unary shape 65')
  assert(seqeq(r.strides,{4}),'absolute unary strides 65')
  assert(veq(r:tolist(),{7,63,2,2,1}),'absolute unary values 65')
end
do -- absolute unary 66
  local a=np.array({127,127,5,63,2},np.uint32)
  local r=np.absolute(a)
  assert(r.dtype=='uint32','absolute unary dtype 66')
  assert(seqeq(r.shape,{5}),'absolute unary shape 66')
  assert(seqeq(r.strides,{4}),'absolute unary strides 66')
  assert(veq(r:tolist(),{127,127,5,63,2}),'absolute unary values 66')
end
do -- absolute unary 67
  local a=(np.array({{0.0,0.0,(0/0)},{-9.5,0.5,0.5}},np.float16)).T
  local r=np.absolute(a)
  assert(r.dtype=='float16','absolute unary dtype 67')
  assert(seqeq(r.shape,{3,2}),'absolute unary shape 67')
  assert(seqeq(r.strides,{2,6}),'absolute unary strides 67')
  assert(veq(r:tolist(),{{0.0,9.5},{0.0,0.5},{(0/0),0.5}}),'absolute unary values 67')
end
do -- absolute unary 68
  local a=(np.array({{1.0,-0.0,1.0},{(0/0),0.0,0.5}},np.float64)).T
  local r=np.absolute(a)
  assert(r.dtype=='float64','absolute unary dtype 68')
  assert(seqeq(r.shape,{3,2}),'absolute unary shape 68')
  assert(seqeq(r.strides,{8,24}),'absolute unary strides 68')
  assert(veq(r:tolist(),{{1.0,(0/0)},{0.0,0.0},{1.0,0.5}}),'absolute unary values 68')
end
do -- absolute unary 69
  local a=np.array({{63,0,127},{63,2,0}},np.uint8)
  local r=np.absolute(a)
  assert(r.dtype=='uint8','absolute unary dtype 69')
  assert(seqeq(r.shape,{2,3}),'absolute unary shape 69')
  assert(seqeq(r.strides,{3,1}),'absolute unary strides 69')
  assert(veq(r:tolist(),{{63,0,127},{63,2,0}}),'absolute unary values 69')
end
do -- positive unary 70
  local a=np.array({251,1,0,127,17},np.uint16)
  local r=np.positive(a)
  assert(r.dtype=='uint16','positive unary dtype 70')
  assert(seqeq(r.shape,{5}),'positive unary shape 70')
  assert(seqeq(r.strides,{2}),'positive unary strides 70')
  assert(veq(r:tolist(),{251,1,0,127,17}),'positive unary values 70')
end
do -- positive unary 71
  local a=np.array({{11.0,-0.0,0.0},{math.huge,math.huge,-math.huge}},np.float32)
  local r=np.positive(a)
  assert(r.dtype=='float32','positive unary dtype 71')
  assert(seqeq(r.shape,{2,3}),'positive unary shape 71')
  assert(seqeq(r.strides,{12,4}),'positive unary strides 71')
  assert(veq(r:tolist(),{{11.0,-0.0,0.0},{math.huge,math.huge,-math.huge}}),'positive unary values 71')
end
do -- positive unary 72
  local a=np.array({5,1,5,63,1},np.uint16)
  local r=np.positive(a)
  assert(r.dtype=='uint16','positive unary dtype 72')
  assert(seqeq(r.shape,{5}),'positive unary shape 72')
  assert(seqeq(r.strides,{2}),'positive unary strides 72')
  assert(veq(r:tolist(),{5,1,5,63,1}),'positive unary values 72')
end
do -- positive unary 73
  local a=(np.array({{127,63,0},{63,1,2}},np.uint64)).T
  local r=np.positive(a)
  assert(r.dtype=='uint64','positive unary dtype 73')
  assert(seqeq(r.shape,{3,2}),'positive unary shape 73')
  assert(seqeq(r.strides,{8,24}),'positive unary strides 73')
  assert(veq(r:tolist(),{{127,63},{63,1},{0,2}}),'positive unary values 73')
end
do -- positive unary 74
  local a=np.array({1,17,1,5,0},np.uint8)
  local r=np.positive(a)
  assert(r.dtype=='uint8','positive unary dtype 74')
  assert(seqeq(r.shape,{5}),'positive unary shape 74')
  assert(seqeq(r.strides,{1}),'positive unary strides 74')
  assert(veq(r:tolist(),{1,17,1,5,0}),'positive unary values 74')
end
do -- positive unary 75
  local a=np.array({251,17,251,2,251},np.uint8)
  local r=np.positive(a)
  assert(r.dtype=='uint8','positive unary dtype 75')
  assert(seqeq(r.shape,{5}),'positive unary shape 75')
  assert(seqeq(r.strides,{1}),'positive unary strides 75')
  assert(veq(r:tolist(),{251,17,251,2,251}),'positive unary values 75')
end
do -- positive unary 76
  local a=(np.array({{-7,0,0},{126,63,126}},np.int64)).T
  local r=np.positive(a)
  assert(r.dtype=='int64','positive unary dtype 76')
  assert(seqeq(r.shape,{3,2}),'positive unary shape 76')
  assert(seqeq(r.strides,{8,24}),'positive unary strides 76')
  assert(veq(r:tolist(),{{-7,126},{0,63},{0,126}}),'positive unary values 76')
end
do -- positive unary 77
  local a=np.array({1,2,17,2,5},np.uint8)
  local r=np.positive(a)
  assert(r.dtype=='uint8','positive unary dtype 77')
  assert(seqeq(r.shape,{5}),'positive unary shape 77')
  assert(seqeq(r.strides,{1}),'positive unary strides 77')
  assert(veq(r:tolist(),{1,2,17,2,5}),'positive unary values 77')
end
do -- positive unary 78
  local a=np.array({{-2.25,1.0,-2.25},{0.0,-0.0,-1.0}},np.float16)
  local r=np.positive(a)
  assert(r.dtype=='float16','positive unary dtype 78')
  assert(seqeq(r.shape,{2,3}),'positive unary shape 78')
  assert(seqeq(r.strides,{6,2}),'positive unary strides 78')
  assert(veq(r:tolist(),{{-2.25,1.0,-2.25},{0.0,-0.0,-1.0}}),'positive unary values 78')
end
do -- positive bool/error 79
  local a=np.array({false,false,false,false,true},np.bool)
  local ok=pcall(function() return np.positive(a) end)
  assert(not ok,'positive expected error 79')
end
do -- positive unary 80
  local a=(np.array({{17,5,5},{0,2,1}},np.uint64)).T
  local r=np.positive(a)
  assert(r.dtype=='uint64','positive unary dtype 80')
  assert(seqeq(r.shape,{3,2}),'positive unary shape 80')
  assert(seqeq(r.strides,{8,24}),'positive unary strides 80')
  assert(veq(r:tolist(),{{17,0},{5,2},{5,1}}),'positive unary values 80')
end
do -- positive unary 81
  local a=np.array({63,127,127,17,127},np.uint64)
  local r=np.positive(a)
  assert(r.dtype=='uint64','positive unary dtype 81')
  assert(seqeq(r.shape,{5}),'positive unary shape 81')
  assert(seqeq(r.strides,{8}),'positive unary strides 81')
  assert(veq(r:tolist(),{63,127,127,17,127}),'positive unary values 81')
end
do -- positive unary 82
  local a=np.array({{251,2,127},{0,5,63}},np.uint8)
  local r=np.positive(a)
  assert(r.dtype=='uint8','positive unary dtype 82')
  assert(seqeq(r.shape,{2,3}),'positive unary shape 82')
  assert(seqeq(r.strides,{3,1}),'positive unary strides 82')
  assert(veq(r:tolist(),{{251,2,127},{0,5,63}}),'positive unary values 82')
end
do -- positive unary 83
  local a=np.array({{0,63,63},{2,2,0}},np.uint32)
  local r=np.positive(a)
  assert(r.dtype=='uint32','positive unary dtype 83')
  assert(seqeq(r.shape,{2,3}),'positive unary shape 83')
  assert(seqeq(r.strides,{12,4}),'positive unary strides 83')
  assert(veq(r:tolist(),{{0,63,63},{2,2,0}}),'positive unary values 83')
end
do -- positive unary 84
  local a=np.array({-9.5,3.75,11.0,(0/0),-0.0},np.float16)
  local r=np.positive(a)
  assert(r.dtype=='float16','positive unary dtype 84')
  assert(seqeq(r.shape,{5}),'positive unary shape 84')
  assert(seqeq(r.strides,{2}),'positive unary strides 84')
  assert(veq(r:tolist(),{-9.5,3.75,11.0,(0/0),-0.0}),'positive unary values 84')
end
do -- positive unary 85
  local a=np.array({{251,63,17},{17,0,1}},np.uint64)
  local r=np.positive(a)
  assert(r.dtype=='uint64','positive unary dtype 85')
  assert(seqeq(r.shape,{2,3}),'positive unary shape 85')
  assert(seqeq(r.strides,{24,8}),'positive unary strides 85')
  assert(veq(r:tolist(),{{251,63,17},{17,0,1}}),'positive unary values 85')
end
do -- positive unary 86
  local a=np.array({0,-127,9,126,126},np.int32)
  local r=np.positive(a)
  assert(r.dtype=='int32','positive unary dtype 86')
  assert(seqeq(r.shape,{5}),'positive unary shape 86')
  assert(seqeq(r.strides,{4}),'positive unary strides 86')
  assert(veq(r:tolist(),{0,-127,9,126,126}),'positive unary values 86')
end
do -- positive unary 87
  local a=(np.array({{11.0,math.huge,11.0},{3.75,1.0,11.0}},np.float32)).T
  local r=np.positive(a)
  assert(r.dtype=='float32','positive unary dtype 87')
  assert(seqeq(r.shape,{3,2}),'positive unary shape 87')
  assert(seqeq(r.strides,{4,12}),'positive unary strides 87')
  assert(veq(r:tolist(),{{11.0,3.75},{math.huge,1.0},{11.0,11.0}}),'positive unary values 87')
end
do -- positive unary 88
  local a=np.array({0,127,2,63,5},np.uint32)
  local r=np.positive(a)
  assert(r.dtype=='uint32','positive unary dtype 88')
  assert(seqeq(r.shape,{5}),'positive unary shape 88')
  assert(seqeq(r.strides,{4}),'positive unary strides 88')
  assert(veq(r:tolist(),{0,127,2,63,5}),'positive unary values 88')
end
do -- positive unary 89
  local a=np.array({-2.25,3.75,0.5,-0.0,0.5},np.float32)
  local r=np.positive(a)
  assert(r.dtype=='float32','positive unary dtype 89')
  assert(seqeq(r.shape,{5}),'positive unary shape 89')
  assert(seqeq(r.strides,{4}),'positive unary strides 89')
  assert(veq(r:tolist(),{-2.25,3.75,0.5,-0.0,0.5}),'positive unary values 89')
end
do -- positive unary 90
  local a=np.array({{-1,0,1},{-127,-1,63}},np.int16)
  local r=np.positive(a)
  assert(r.dtype=='int16','positive unary dtype 90')
  assert(seqeq(r.shape,{2,3}),'positive unary shape 90')
  assert(seqeq(r.strides,{6,2}),'positive unary strides 90')
  assert(veq(r:tolist(),{{-1,0,1},{-127,-1,63}}),'positive unary values 90')
end
do -- positive unary 91
  local a=np.array({-31,0,63,-31,-127},np.int8)
  local r=np.positive(a)
  assert(r.dtype=='int8','positive unary dtype 91')
  assert(seqeq(r.shape,{5}),'positive unary shape 91')
  assert(seqeq(r.strides,{1}),'positive unary strides 91')
  assert(veq(r:tolist(),{-31,0,63,-31,-127}),'positive unary values 91')
end
do -- positive unary 92
  local a=np.array({127,0,2,251,2},np.uint8)
  local r=np.positive(a)
  assert(r.dtype=='uint8','positive unary dtype 92')
  assert(seqeq(r.shape,{5}),'positive unary shape 92')
  assert(seqeq(r.strides,{1}),'positive unary strides 92')
  assert(veq(r:tolist(),{127,0,2,251,2}),'positive unary values 92')
end
do -- positive unary 93
  local a=np.array({{(0/0),-math.huge,11.0},{-2.25,0.0,0.0}},np.float16)
  local r=np.positive(a)
  assert(r.dtype=='float16','positive unary dtype 93')
  assert(seqeq(r.shape,{2,3}),'positive unary shape 93')
  assert(seqeq(r.strides,{6,2}),'positive unary strides 93')
  assert(veq(r:tolist(),{{(0/0),-math.huge,11.0},{-2.25,0.0,0.0}}),'positive unary values 93')
end
do -- positive unary 94
  local a=np.array({{-7,0,9},{126,9,-127}},np.int8)
  local r=np.positive(a)
  assert(r.dtype=='int8','positive unary dtype 94')
  assert(seqeq(r.shape,{2,3}),'positive unary shape 94')
  assert(seqeq(r.strides,{3,1}),'positive unary strides 94')
  assert(veq(r:tolist(),{{-7,0,9},{126,9,-127}}),'positive unary values 94')
end
do -- positive unary 95
  local a=np.array({63,-127,9,126,0},np.int32)
  local r=np.positive(a)
  assert(r.dtype=='int32','positive unary dtype 95')
  assert(seqeq(r.shape,{5}),'positive unary shape 95')
  assert(seqeq(r.strides,{4}),'positive unary strides 95')
  assert(veq(r:tolist(),{63,-127,9,126,0}),'positive unary values 95')
end
do -- positive unary 96
  local a=np.array({-7,-31,9,0,126},np.int16)
  local r=np.positive(a)
  assert(r.dtype=='int16','positive unary dtype 96')
  assert(seqeq(r.shape,{5}),'positive unary shape 96')
  assert(seqeq(r.strides,{2}),'positive unary strides 96')
  assert(veq(r:tolist(),{-7,-31,9,0,126}),'positive unary values 96')
end
do -- positive unary 97
  local a=np.array({{0.0,-9.5,3.75},{-2.25,1.0,math.huge}},np.float64)
  local r=np.positive(a)
  assert(r.dtype=='float64','positive unary dtype 97')
  assert(seqeq(r.shape,{2,3}),'positive unary shape 97')
  assert(seqeq(r.strides,{24,8}),'positive unary strides 97')
  assert(veq(r:tolist(),{{0.0,-9.5,3.75},{-2.25,1.0,math.huge}}),'positive unary values 97')
end
do -- positive unary 98
  local a=np.array({{(0/0),0.0,-math.huge},{math.huge,0.5,(0/0)}},np.float64)
  local r=np.positive(a)
  assert(r.dtype=='float64','positive unary dtype 98')
  assert(seqeq(r.shape,{2,3}),'positive unary shape 98')
  assert(seqeq(r.strides,{24,8}),'positive unary strides 98')
  assert(veq(r:tolist(),{{(0/0),0.0,-math.huge},{math.huge,0.5,(0/0)}}),'positive unary values 98')
end
do -- positive unary 99
  local a=np.array({17,2,17,63,0},np.uint32)
  local r=np.positive(a)
  assert(r.dtype=='uint32','positive unary dtype 99')
  assert(seqeq(r.shape,{5}),'positive unary shape 99')
  assert(seqeq(r.strides,{4}),'positive unary strides 99')
  assert(veq(r:tolist(),{17,2,17,63,0}),'positive unary values 99')
end
do -- positive unary 100
  local a=np.array({-1,-1,-31,9,126},np.int8)
  local r=np.positive(a)
  assert(r.dtype=='int8','positive unary dtype 100')
  assert(seqeq(r.shape,{5}),'positive unary shape 100')
  assert(seqeq(r.strides,{1}),'positive unary strides 100')
  assert(veq(r:tolist(),{-1,-1,-31,9,126}),'positive unary values 100')
end
do -- positive unary 101
  local a=np.array({251,251,2,0,127},np.uint8)
  local r=np.positive(a)
  assert(r.dtype=='uint8','positive unary dtype 101')
  assert(seqeq(r.shape,{5}),'positive unary shape 101')
  assert(seqeq(r.strides,{1}),'positive unary strides 101')
  assert(veq(r:tolist(),{251,251,2,0,127}),'positive unary values 101')
end
do -- positive unary 102
  local a=np.array({{-math.huge,-0.0,3.75},{-0.0,math.huge,(0/0)}},np.float32)
  local r=np.positive(a)
  assert(r.dtype=='float32','positive unary dtype 102')
  assert(seqeq(r.shape,{2,3}),'positive unary shape 102')
  assert(seqeq(r.strides,{12,4}),'positive unary strides 102')
  assert(veq(r:tolist(),{{-math.huge,-0.0,3.75},{-0.0,math.huge,(0/0)}}),'positive unary values 102')
end
do -- positive unary 103
  local a=np.array({{0,17,1},{0,0,5}},np.uint64)
  local r=np.positive(a)
  assert(r.dtype=='uint64','positive unary dtype 103')
  assert(seqeq(r.shape,{2,3}),'positive unary shape 103')
  assert(seqeq(r.strides,{24,8}),'positive unary strides 103')
  assert(veq(r:tolist(),{{0,17,1},{0,0,5}}),'positive unary values 103')
end
do -- positive unary 104
  local a=np.array({127,17,0,2,17},np.uint64)
  local r=np.positive(a)
  assert(r.dtype=='uint64','positive unary dtype 104')
  assert(seqeq(r.shape,{5}),'positive unary shape 104')
  assert(seqeq(r.strides,{8}),'positive unary strides 104')
  assert(veq(r:tolist(),{127,17,0,2,17}),'positive unary values 104')
end
do -- sign unary 105
  local a=np.array({-1,63,-1,-127,126},np.int32)
  local r=np.sign(a)
  assert(r.dtype=='int32','sign unary dtype 105')
  assert(seqeq(r.shape,{5}),'sign unary shape 105')
  assert(seqeq(r.strides,{4}),'sign unary strides 105')
  assert(veq(r:tolist(),{-1,1,-1,-1,1}),'sign unary values 105')
end
do -- sign unary 106
  local a=np.array({{2,-31,-31},{-7,-127,2}},np.int16)
  local r=np.sign(a)
  assert(r.dtype=='int16','sign unary dtype 106')
  assert(seqeq(r.shape,{2,3}),'sign unary shape 106')
  assert(seqeq(r.strides,{6,2}),'sign unary strides 106')
  assert(veq(r:tolist(),{{1,-1,-1},{-1,-1,1}}),'sign unary values 106')
end
do -- sign unary 107
  local a=np.array({-1,126,-31,63,9},np.int16)
  local r=np.sign(a)
  assert(r.dtype=='int16','sign unary dtype 107')
  assert(seqeq(r.shape,{5}),'sign unary shape 107')
  assert(seqeq(r.strides,{2}),'sign unary strides 107')
  assert(veq(r:tolist(),{-1,1,-1,1,1}),'sign unary values 107')
end
do -- sign unary 108
  local a=np.array({{63,-7,9},{9,-7,0}},np.int8)
  local r=np.sign(a)
  assert(r.dtype=='int8','sign unary dtype 108')
  assert(seqeq(r.shape,{2,3}),'sign unary shape 108')
  assert(seqeq(r.strides,{3,1}),'sign unary strides 108')
  assert(veq(r:tolist(),{{1,-1,1},{1,-1,0}}),'sign unary values 108')
end
do -- sign unary 109
  local a=np.array({{-127,63,1},{63,0,-127}},np.int64)
  local r=np.sign(a)
  assert(r.dtype=='int64','sign unary dtype 109')
  assert(seqeq(r.shape,{2,3}),'sign unary shape 109')
  assert(seqeq(r.strides,{24,8}),'sign unary strides 109')
  assert(veq(r:tolist(),{{-1,1,1},{1,0,-1}}),'sign unary values 109')
end
do -- sign unary 110
  local a=np.array({2,-7,1,-127,63},np.int32)
  local r=np.sign(a)
  assert(r.dtype=='int32','sign unary dtype 110')
  assert(seqeq(r.shape,{5}),'sign unary shape 110')
  assert(seqeq(r.strides,{4}),'sign unary strides 110')
  assert(veq(r:tolist(),{1,-1,1,-1,1}),'sign unary values 110')
end
do -- sign unary 111
  local a=(np.array({{1,2,-31},{2,1,126}},np.int64)).T
  local r=np.sign(a)
  assert(r.dtype=='int64','sign unary dtype 111')
  assert(seqeq(r.shape,{3,2}),'sign unary shape 111')
  assert(seqeq(r.strides,{8,24}),'sign unary strides 111')
  assert(veq(r:tolist(),{{1,1},{1,1},{-1,1}}),'sign unary values 111')
end
do -- sign unary 112
  local a=(np.array({{2,-127,2},{-7,0,0}},np.int32)).T
  local r=np.sign(a)
  assert(r.dtype=='int32','sign unary dtype 112')
  assert(seqeq(r.shape,{3,2}),'sign unary shape 112')
  assert(seqeq(r.strides,{4,12}),'sign unary strides 112')
  assert(veq(r:tolist(),{{1,-1},{-1,0},{1,0}}),'sign unary values 112')
end
do -- sign unary 113
  local a=np.array({0,-1,2,9,9},np.int8)
  local r=np.sign(a)
  assert(r.dtype=='int8','sign unary dtype 113')
  assert(seqeq(r.shape,{5}),'sign unary shape 113')
  assert(seqeq(r.strides,{1}),'sign unary strides 113')
  assert(veq(r:tolist(),{0,-1,1,1,1}),'sign unary values 113')
end
do -- sign unary 114
  local a=np.array({{17,17,2},{1,63,127}},np.uint16)
  local r=np.sign(a)
  assert(r.dtype=='uint16','sign unary dtype 114')
  assert(seqeq(r.shape,{2,3}),'sign unary shape 114')
  assert(seqeq(r.strides,{6,2}),'sign unary strides 114')
  assert(veq(r:tolist(),{{1,1,1},{1,1,1}}),'sign unary values 114')
end
do -- sign unary 115
  local a=np.array({1,17,17,127,5},np.uint32)
  local r=np.sign(a)
  assert(r.dtype=='uint32','sign unary dtype 115')
  assert(seqeq(r.shape,{5}),'sign unary shape 115')
  assert(seqeq(r.strides,{4}),'sign unary strides 115')
  assert(veq(r:tolist(),{1,1,1,1,1}),'sign unary values 115')
end
do -- sign unary 116
  local a=(np.array({{0,5,127},{63,5,17}},np.uint64)).T
  local r=np.sign(a)
  assert(r.dtype=='uint64','sign unary dtype 116')
  assert(seqeq(r.shape,{3,2}),'sign unary shape 116')
  assert(seqeq(r.strides,{8,24}),'sign unary strides 116')
  assert(veq(r:tolist(),{{0,1},{1,1},{1,1}}),'sign unary values 116')
end
do -- sign unary 117
  local a=np.array({127,127,127,63,251},np.uint8)
  local r=np.sign(a)
  assert(r.dtype=='uint8','sign unary dtype 117')
  assert(seqeq(r.shape,{5}),'sign unary shape 117')
  assert(seqeq(r.strides,{1}),'sign unary strides 117')
  assert(veq(r:tolist(),{1,1,1,1,1}),'sign unary values 117')
end
do -- sign unary 118
  local a=np.array({0,5,17,127,17},np.uint8)
  local r=np.sign(a)
  assert(r.dtype=='uint8','sign unary dtype 118')
  assert(seqeq(r.shape,{5}),'sign unary shape 118')
  assert(seqeq(r.strides,{1}),'sign unary strides 118')
  assert(veq(r:tolist(),{0,1,1,1,1}),'sign unary values 118')
end
do -- sign unary 119
  local a=np.array({5,0,1,5,0},np.uint32)
  local r=np.sign(a)
  assert(r.dtype=='uint32','sign unary dtype 119')
  assert(seqeq(r.shape,{5}),'sign unary shape 119')
  assert(seqeq(r.strides,{4}),'sign unary strides 119')
  assert(veq(r:tolist(),{1,0,1,1,0}),'sign unary values 119')
end
do -- sign unary 120
  local a=np.array({5,17,5,0,1},np.uint16)
  local r=np.sign(a)
  assert(r.dtype=='uint16','sign unary dtype 120')
  assert(seqeq(r.shape,{5}),'sign unary shape 120')
  assert(seqeq(r.strides,{2}),'sign unary strides 120')
  assert(veq(r:tolist(),{1,1,1,0,1}),'sign unary values 120')
end
do -- sign unary 121
  local a=np.array({{1,0,17},{1,63,127}},np.uint32)
  local r=np.sign(a)
  assert(r.dtype=='uint32','sign unary dtype 121')
  assert(seqeq(r.shape,{2,3}),'sign unary shape 121')
  assert(seqeq(r.strides,{12,4}),'sign unary strides 121')
  assert(veq(r:tolist(),{{1,0,1},{1,1,1}}),'sign unary values 121')
end
do -- sign unary 122
  local a=np.array({{-9.5,-9.5,0.0},{0.5,-9.5,0.5}},np.float32)
  local r=np.sign(a)
  assert(r.dtype=='float32','sign unary dtype 122')
  assert(seqeq(r.shape,{2,3}),'sign unary shape 122')
  assert(seqeq(r.strides,{12,4}),'sign unary strides 122')
  assert(veq(r:tolist(),{{-1.0,-1.0,0.0},{1.0,-1.0,1.0}}),'sign unary values 122')
end
do -- sign unary 123
  local a=np.array({0.0,3.75,-2.25,3.75,-9.5},np.float32)
  local r=np.sign(a)
  assert(r.dtype=='float32','sign unary dtype 123')
  assert(seqeq(r.shape,{5}),'sign unary shape 123')
  assert(seqeq(r.strides,{4}),'sign unary strides 123')
  assert(veq(r:tolist(),{0.0,1.0,-1.0,1.0,-1.0}),'sign unary values 123')
end
do -- sign unary 124
  local a=(np.array({{9,2,-127},{63,2,-7}},np.int64)).T
  local r=np.sign(a)
  assert(r.dtype=='int64','sign unary dtype 124')
  assert(seqeq(r.shape,{3,2}),'sign unary shape 124')
  assert(seqeq(r.strides,{8,24}),'sign unary strides 124')
  assert(veq(r:tolist(),{{1,1},{1,1},{-1,-1}}),'sign unary values 124')
end
do -- sign unary 125
  local a=np.array({11.0,3.75,0.0,-0.0,math.huge},np.float32)
  local r=np.sign(a)
  assert(r.dtype=='float32','sign unary dtype 125')
  assert(seqeq(r.shape,{5}),'sign unary shape 125')
  assert(seqeq(r.strides,{4}),'sign unary strides 125')
  assert(veq(r:tolist(),{1.0,1.0,0.0,0.0,1.0}),'sign unary values 125')
end
do -- sign unary 126
  local a=np.array({{-127,-1,1},{1,63,0}},np.int8)
  local r=np.sign(a)
  assert(r.dtype=='int8','sign unary dtype 126')
  assert(seqeq(r.shape,{2,3}),'sign unary shape 126')
  assert(seqeq(r.strides,{3,1}),'sign unary strides 126')
  assert(veq(r:tolist(),{{-1,-1,1},{1,1,0}}),'sign unary values 126')
end
do -- sign unary 127
  local a=np.array({5,5,0,251,1},np.uint16)
  local r=np.sign(a)
  assert(r.dtype=='uint16','sign unary dtype 127')
  assert(seqeq(r.shape,{5}),'sign unary shape 127')
  assert(seqeq(r.strides,{2}),'sign unary strides 127')
  assert(veq(r:tolist(),{1,1,0,1,1}),'sign unary values 127')
end
do -- sign unary 128
  local a=(np.array({{5,0,251},{17,2,5}},np.uint32)).T
  local r=np.sign(a)
  assert(r.dtype=='uint32','sign unary dtype 128')
  assert(seqeq(r.shape,{3,2}),'sign unary shape 128')
  assert(seqeq(r.strides,{4,12}),'sign unary strides 128')
  assert(veq(r:tolist(),{{1,1},{0,1},{1,1}}),'sign unary values 128')
end
do -- sign unary 129
  local a=(np.array({{0,127,1},{127,63,127}},np.uint32)).T
  local r=np.sign(a)
  assert(r.dtype=='uint32','sign unary dtype 129')
  assert(seqeq(r.shape,{3,2}),'sign unary shape 129')
  assert(seqeq(r.strides,{4,12}),'sign unary strides 129')
  assert(veq(r:tolist(),{{0,1},{1,1},{1,1}}),'sign unary values 129')
end
do -- sign unary 130
  local a=np.array({-31,9,2,126,126},np.int8)
  local r=np.sign(a)
  assert(r.dtype=='int8','sign unary dtype 130')
  assert(seqeq(r.shape,{5}),'sign unary shape 130')
  assert(seqeq(r.strides,{1}),'sign unary strides 130')
  assert(veq(r:tolist(),{-1,1,1,1,1}),'sign unary values 130')
end
do -- sign unary 131
  local a=(np.array({{-7,0,1},{63,-127,-31}},np.int8)).T
  local r=np.sign(a)
  assert(r.dtype=='int8','sign unary dtype 131')
  assert(seqeq(r.shape,{3,2}),'sign unary shape 131')
  assert(seqeq(r.strides,{1,3}),'sign unary strides 131')
  assert(veq(r:tolist(),{{-1,1},{0,-1},{1,-1}}),'sign unary values 131')
end
do -- sign unary 132
  local a=np.array({{2,0,127},{1,127,17}},np.uint32)
  local r=np.sign(a)
  assert(r.dtype=='uint32','sign unary dtype 132')
  assert(seqeq(r.shape,{2,3}),'sign unary shape 132')
  assert(seqeq(r.strides,{12,4}),'sign unary strides 132')
  assert(veq(r:tolist(),{{1,0,1},{1,1,1}}),'sign unary values 132')
end
do -- sign unary 133
  local a=(np.array({{251,63,1},{127,0,63}},np.uint64)).T
  local r=np.sign(a)
  assert(r.dtype=='uint64','sign unary dtype 133')
  assert(seqeq(r.shape,{3,2}),'sign unary shape 133')
  assert(seqeq(r.strides,{8,24}),'sign unary strides 133')
  assert(veq(r:tolist(),{{1,1},{1,0},{1,1}}),'sign unary values 133')
end
do -- sign unary 134
  local a=np.array({{0.0,math.huge,0.5},{0.0,-9.5,math.huge}},np.float64)
  local r=np.sign(a)
  assert(r.dtype=='float64','sign unary dtype 134')
  assert(seqeq(r.shape,{2,3}),'sign unary shape 134')
  assert(seqeq(r.strides,{24,8}),'sign unary strides 134')
  assert(veq(r:tolist(),{{0.0,1.0,1.0},{0.0,-1.0,1.0}}),'sign unary values 134')
end
do -- sign unary 135
  local a=np.array({{1.0,(0/0),-0.0},{(0/0),1.0,(0/0)}},np.float64)
  local r=np.sign(a)
  assert(r.dtype=='float64','sign unary dtype 135')
  assert(seqeq(r.shape,{2,3}),'sign unary shape 135')
  assert(seqeq(r.strides,{24,8}),'sign unary strides 135')
  assert(veq(r:tolist(),{{1.0,(0/0),0.0},{(0/0),1.0,(0/0)}}),'sign unary values 135')
end
do -- sign bool/error 136
  local a=np.array({false,true,false,false,false},np.bool)
  local ok=pcall(function() return np.sign(a) end)
  assert(not ok,'sign expected error 136')
end
do -- sign unary 137
  local a=np.array({{-1,126,126},{1,126,0}},np.int64)
  local r=np.sign(a)
  assert(r.dtype=='int64','sign unary dtype 137')
  assert(seqeq(r.shape,{2,3}),'sign unary shape 137')
  assert(seqeq(r.strides,{24,8}),'sign unary strides 137')
  assert(veq(r:tolist(),{{-1,1,1},{1,1,0}}),'sign unary values 137')
end
do -- sign unary 138
  local a=np.array({0.0,-1.0,-math.huge,0.5,3.75},np.float64)
  local r=np.sign(a)
  assert(r.dtype=='float64','sign unary dtype 138')
  assert(seqeq(r.shape,{5}),'sign unary shape 138')
  assert(seqeq(r.strides,{8}),'sign unary strides 138')
  assert(veq(r:tolist(),{0.0,-1.0,-1.0,1.0,1.0}),'sign unary values 138')
end
do -- sign unary 139
  local a=(np.array({{-31,-127,1},{-31,0,63}},np.int32)).T
  local r=np.sign(a)
  assert(r.dtype=='int32','sign unary dtype 139')
  assert(seqeq(r.shape,{3,2}),'sign unary shape 139')
  assert(seqeq(r.strides,{4,12}),'sign unary strides 139')
  assert(veq(r:tolist(),{{-1,-1},{-1,0},{1,1}}),'sign unary values 139')
end
do -- logical_not unary 140
  local a=np.array({127,127,251,5,17},np.uint16)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 140')
  assert(seqeq(r.shape,{5}),'logical_not unary shape 140')
  assert(seqeq(r.strides,{1}),'logical_not unary strides 140')
  assert(veq(r:tolist(),{false,false,false,false,false}),'logical_not unary values 140')
end
do -- logical_not unary 141
  local a=(np.array({{false,false,false},{true,false,false}},np.bool)).T
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 141')
  assert(seqeq(r.shape,{3,2}),'logical_not unary shape 141')
  assert(seqeq(r.strides,{1,3}),'logical_not unary strides 141')
  assert(veq(r:tolist(),{{true,false},{true,true},{true,true}}),'logical_not unary values 141')
end
do -- logical_not unary 142
  local a=np.array({{2,2,5},{1,127,17}},np.uint8)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 142')
  assert(seqeq(r.shape,{2,3}),'logical_not unary shape 142')
  assert(seqeq(r.strides,{3,1}),'logical_not unary strides 142')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'logical_not unary values 142')
end
do -- logical_not unary 143
  local a=np.array({-127,-31,-1,-7,1},np.int64)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 143')
  assert(seqeq(r.shape,{5}),'logical_not unary shape 143')
  assert(seqeq(r.strides,{1}),'logical_not unary strides 143')
  assert(veq(r:tolist(),{false,false,false,false,false}),'logical_not unary values 143')
end
do -- logical_not unary 144
  local a=np.array({{251,17,63},{0,251,127}},np.uint32)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 144')
  assert(seqeq(r.shape,{2,3}),'logical_not unary shape 144')
  assert(seqeq(r.strides,{3,1}),'logical_not unary strides 144')
  assert(veq(r:tolist(),{{false,false,false},{true,false,false}}),'logical_not unary values 144')
end
do -- logical_not unary 145
  local a=np.array({0.5,-2.25,-2.25,-0.0,math.huge},np.float32)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 145')
  assert(seqeq(r.shape,{5}),'logical_not unary shape 145')
  assert(seqeq(r.strides,{1}),'logical_not unary strides 145')
  assert(veq(r:tolist(),{false,false,false,true,false}),'logical_not unary values 145')
end
do -- logical_not unary 146
  local a=np.array({{2,63,-31},{126,126,2}},np.int32)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 146')
  assert(seqeq(r.shape,{2,3}),'logical_not unary shape 146')
  assert(seqeq(r.strides,{3,1}),'logical_not unary strides 146')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'logical_not unary values 146')
end
do -- logical_not unary 147
  local a=np.array({3.75,0.0,-9.5,(0/0),0.0},np.float64)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 147')
  assert(seqeq(r.shape,{5}),'logical_not unary shape 147')
  assert(seqeq(r.strides,{1}),'logical_not unary strides 147')
  assert(veq(r:tolist(),{false,true,false,false,true}),'logical_not unary values 147')
end
do -- logical_not unary 148
  local a=np.array({126,0,0,1,-127},np.int8)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 148')
  assert(seqeq(r.shape,{5}),'logical_not unary shape 148')
  assert(seqeq(r.strides,{1}),'logical_not unary strides 148')
  assert(veq(r:tolist(),{false,true,true,false,false}),'logical_not unary values 148')
end
do -- logical_not unary 149
  local a=np.array({{(0/0),11.0,0.0},{-0.0,-2.25,-1.0}},np.float32)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 149')
  assert(seqeq(r.shape,{2,3}),'logical_not unary shape 149')
  assert(seqeq(r.strides,{3,1}),'logical_not unary strides 149')
  assert(veq(r:tolist(),{{false,false,true},{true,false,false}}),'logical_not unary values 149')
end
do -- logical_not unary 150
  local a=np.array({0.0,0.0,11.0,-2.25,0.0},np.float64)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 150')
  assert(seqeq(r.shape,{5}),'logical_not unary shape 150')
  assert(seqeq(r.strides,{1}),'logical_not unary strides 150')
  assert(veq(r:tolist(),{true,true,false,false,true}),'logical_not unary values 150')
end
do -- logical_not unary 151
  local a=np.array({11.0,0.0,11.0,11.0,(0/0)},np.float32)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 151')
  assert(seqeq(r.shape,{5}),'logical_not unary shape 151')
  assert(seqeq(r.strides,{1}),'logical_not unary strides 151')
  assert(veq(r:tolist(),{false,true,false,false,false}),'logical_not unary values 151')
end
do -- logical_not unary 152
  local a=np.array({0,251,2,2,2},np.uint64)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 152')
  assert(seqeq(r.shape,{5}),'logical_not unary shape 152')
  assert(seqeq(r.strides,{1}),'logical_not unary strides 152')
  assert(veq(r:tolist(),{true,false,false,false,false}),'logical_not unary values 152')
end
do -- logical_not unary 153
  local a=np.array({63,63,2,17,63},np.uint32)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 153')
  assert(seqeq(r.shape,{5}),'logical_not unary shape 153')
  assert(seqeq(r.strides,{1}),'logical_not unary strides 153')
  assert(veq(r:tolist(),{false,false,false,false,false}),'logical_not unary values 153')
end
do -- logical_not unary 154
  local a=np.array({0,63,1,63,-127},np.int16)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 154')
  assert(seqeq(r.shape,{5}),'logical_not unary shape 154')
  assert(seqeq(r.strides,{1}),'logical_not unary strides 154')
  assert(veq(r:tolist(),{true,false,false,false,false}),'logical_not unary values 154')
end
do -- logical_not unary 155
  local a=(np.array({{2,126,9},{1,-7,-127}},np.int16)).T
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 155')
  assert(seqeq(r.shape,{3,2}),'logical_not unary shape 155')
  assert(seqeq(r.strides,{1,3}),'logical_not unary strides 155')
  assert(veq(r:tolist(),{{false,false},{false,false},{false,false}}),'logical_not unary values 155')
end
do -- logical_not unary 156
  local a=np.array({1,9,-1,-1,-127},np.int16)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 156')
  assert(seqeq(r.shape,{5}),'logical_not unary shape 156')
  assert(seqeq(r.strides,{1}),'logical_not unary strides 156')
  assert(veq(r:tolist(),{false,false,false,false,false}),'logical_not unary values 156')
end
do -- logical_not unary 157
  local a=np.array({{1.0,0.0,11.0},{-1.0,-2.25,-math.huge}},np.float64)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 157')
  assert(seqeq(r.shape,{2,3}),'logical_not unary shape 157')
  assert(seqeq(r.strides,{3,1}),'logical_not unary strides 157')
  assert(veq(r:tolist(),{{false,true,false},{false,false,false}}),'logical_not unary values 157')
end
do -- logical_not unary 158
  local a=np.array({{9,-127,-7},{1,1,-7}},np.int64)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 158')
  assert(seqeq(r.shape,{2,3}),'logical_not unary shape 158')
  assert(seqeq(r.strides,{3,1}),'logical_not unary strides 158')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'logical_not unary values 158')
end
do -- logical_not unary 159
  local a=np.array({{-1.0,-math.huge,math.huge},{11.0,0.0,math.huge}},np.float32)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 159')
  assert(seqeq(r.shape,{2,3}),'logical_not unary shape 159')
  assert(seqeq(r.strides,{3,1}),'logical_not unary strides 159')
  assert(veq(r:tolist(),{{false,false,false},{false,true,false}}),'logical_not unary values 159')
end
do -- logical_not unary 160
  local a=np.array({{-127,-127,-31},{1,126,2}},np.int64)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 160')
  assert(seqeq(r.shape,{2,3}),'logical_not unary shape 160')
  assert(seqeq(r.strides,{3,1}),'logical_not unary strides 160')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'logical_not unary values 160')
end
do -- logical_not unary 161
  local a=np.array({{0.5,-0.0,-9.5},{11.0,-0.0,-9.5}},np.float64)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 161')
  assert(seqeq(r.shape,{2,3}),'logical_not unary shape 161')
  assert(seqeq(r.strides,{3,1}),'logical_not unary strides 161')
  assert(veq(r:tolist(),{{false,true,false},{false,true,false}}),'logical_not unary values 161')
end
do -- logical_not unary 162
  local a=np.array({false,false,true,true,false},np.bool)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 162')
  assert(seqeq(r.shape,{5}),'logical_not unary shape 162')
  assert(seqeq(r.strides,{1}),'logical_not unary strides 162')
  assert(veq(r:tolist(),{true,true,false,false,true}),'logical_not unary values 162')
end
do -- logical_not unary 163
  local a=np.array({0.0,-2.25,-0.0,math.huge,3.75},np.float16)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 163')
  assert(seqeq(r.shape,{5}),'logical_not unary shape 163')
  assert(seqeq(r.strides,{1}),'logical_not unary strides 163')
  assert(veq(r:tolist(),{true,false,true,false,false}),'logical_not unary values 163')
end
do -- logical_not unary 164
  local a=np.array({{-9.5,-2.25,11.0},{-0.0,0.0,math.huge}},np.float32)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 164')
  assert(seqeq(r.shape,{2,3}),'logical_not unary shape 164')
  assert(seqeq(r.strides,{3,1}),'logical_not unary strides 164')
  assert(veq(r:tolist(),{{false,false,false},{true,true,false}}),'logical_not unary values 164')
end
do -- logical_not unary 165
  local a=np.array({true,false,true,false,false},np.bool)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 165')
  assert(seqeq(r.shape,{5}),'logical_not unary shape 165')
  assert(seqeq(r.strides,{1}),'logical_not unary strides 165')
  assert(veq(r:tolist(),{false,true,false,true,true}),'logical_not unary values 165')
end
do -- logical_not unary 166
  local a=np.array({{1,5,251},{0,63,5}},np.uint16)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 166')
  assert(seqeq(r.shape,{2,3}),'logical_not unary shape 166')
  assert(seqeq(r.strides,{3,1}),'logical_not unary strides 166')
  assert(veq(r:tolist(),{{false,false,false},{true,false,false}}),'logical_not unary values 166')
end
do -- logical_not unary 167
  local a=np.array({true,true,false,false,false},np.bool)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 167')
  assert(seqeq(r.shape,{5}),'logical_not unary shape 167')
  assert(seqeq(r.strides,{1}),'logical_not unary strides 167')
  assert(veq(r:tolist(),{false,false,true,true,true}),'logical_not unary values 167')
end
do -- logical_not unary 168
  local a=np.array({-31,-1,1,9,2},np.int64)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 168')
  assert(seqeq(r.shape,{5}),'logical_not unary shape 168')
  assert(seqeq(r.strides,{1}),'logical_not unary strides 168')
  assert(veq(r:tolist(),{false,false,false,false,false}),'logical_not unary values 168')
end
do -- logical_not unary 169
  local a=(np.array({{-31,-7,-7},{1,9,-7}},np.int64)).T
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 169')
  assert(seqeq(r.shape,{3,2}),'logical_not unary shape 169')
  assert(seqeq(r.strides,{1,3}),'logical_not unary strides 169')
  assert(veq(r:tolist(),{{false,false},{false,false},{false,false}}),'logical_not unary values 169')
end
do -- logical_not unary 170
  local a=np.array({0.0,math.huge,(0/0),11.0,-0.0},np.float64)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 170')
  assert(seqeq(r.shape,{5}),'logical_not unary shape 170')
  assert(seqeq(r.strides,{1}),'logical_not unary strides 170')
  assert(veq(r:tolist(),{true,false,false,false,true}),'logical_not unary values 170')
end
do -- logical_not unary 171
  local a=np.array({{-2.25,math.huge,-9.5},{0.0,-0.0,-9.5}},np.float64)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 171')
  assert(seqeq(r.shape,{2,3}),'logical_not unary shape 171')
  assert(seqeq(r.strides,{3,1}),'logical_not unary strides 171')
  assert(veq(r:tolist(),{{false,false,false},{true,true,false}}),'logical_not unary values 171')
end
do -- logical_not unary 172
  local a=(np.array({{63,2,17},{17,127,0}},np.uint16)).T
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 172')
  assert(seqeq(r.shape,{3,2}),'logical_not unary shape 172')
  assert(seqeq(r.strides,{1,3}),'logical_not unary strides 172')
  assert(veq(r:tolist(),{{false,false},{false,false},{false,true}}),'logical_not unary values 172')
end
do -- logical_not unary 173
  local a=np.array({{63,1,251},{0,2,1}},np.uint16)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 173')
  assert(seqeq(r.shape,{2,3}),'logical_not unary shape 173')
  assert(seqeq(r.strides,{3,1}),'logical_not unary strides 173')
  assert(veq(r:tolist(),{{false,false,false},{true,false,false}}),'logical_not unary values 173')
end
do -- logical_not unary 174
  local a=np.array({2,126,9,-31,-7},np.int16)
  local r=np.logical_not(a)
  assert(r.dtype=='bool','logical_not unary dtype 174')
  assert(seqeq(r.shape,{5}),'logical_not unary shape 174')
  assert(seqeq(r.strides,{1}),'logical_not unary strides 174')
  assert(veq(r:tolist(),{false,false,false,false,false}),'logical_not unary values 174')
end
do -- isnan unary 175
  local a=np.array({-1,2,63,2,63},np.int32)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 175')
  assert(seqeq(r.shape,{5}),'isnan unary shape 175')
  assert(seqeq(r.strides,{1}),'isnan unary strides 175')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isnan unary values 175')
end
do -- isnan unary 176
  local a=np.array({2,63,63,127,0},np.uint8)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 176')
  assert(seqeq(r.shape,{5}),'isnan unary shape 176')
  assert(seqeq(r.strides,{1}),'isnan unary strides 176')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isnan unary values 176')
end
do -- isnan unary 177
  local a=np.array({-31,-31,-127,9,63},np.int64)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 177')
  assert(seqeq(r.shape,{5}),'isnan unary shape 177')
  assert(seqeq(r.strides,{1}),'isnan unary strides 177')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isnan unary values 177')
end
do -- isnan unary 178
  local a=np.array({{17,17,63},{17,63,5}},np.uint64)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 178')
  assert(seqeq(r.shape,{2,3}),'isnan unary shape 178')
  assert(seqeq(r.strides,{3,1}),'isnan unary strides 178')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'isnan unary values 178')
end
do -- isnan unary 179
  local a=np.array({2,126,-127,126,63},np.int64)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 179')
  assert(seqeq(r.shape,{5}),'isnan unary shape 179')
  assert(seqeq(r.strides,{1}),'isnan unary strides 179')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isnan unary values 179')
end
do -- isnan unary 180
  local a=np.array({2,63,5,127,0},np.uint32)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 180')
  assert(seqeq(r.shape,{5}),'isnan unary shape 180')
  assert(seqeq(r.strides,{1}),'isnan unary strides 180')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isnan unary values 180')
end
do -- isnan unary 181
  local a=np.array({{2,5,1},{0,1,127}},np.uint16)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 181')
  assert(seqeq(r.shape,{2,3}),'isnan unary shape 181')
  assert(seqeq(r.strides,{3,1}),'isnan unary strides 181')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'isnan unary values 181')
end
do -- isnan unary 182
  local a=np.array({{2,251,1},{0,251,0}},np.uint64)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 182')
  assert(seqeq(r.shape,{2,3}),'isnan unary shape 182')
  assert(seqeq(r.strides,{3,1}),'isnan unary strides 182')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'isnan unary values 182')
end
do -- isnan unary 183
  local a=np.array({{true,true,true},{false,true,false}},np.bool)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 183')
  assert(seqeq(r.shape,{2,3}),'isnan unary shape 183')
  assert(seqeq(r.strides,{3,1}),'isnan unary strides 183')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'isnan unary values 183')
end
do -- isnan unary 184
  local a=(np.array({{2,2,63},{17,2,127}},np.uint16)).T
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 184')
  assert(seqeq(r.shape,{3,2}),'isnan unary shape 184')
  assert(seqeq(r.strides,{1,3}),'isnan unary strides 184')
  assert(veq(r:tolist(),{{false,false},{false,false},{false,false}}),'isnan unary values 184')
end
do -- isnan unary 185
  local a=np.array({{127,251,5},{2,251,5}},np.uint32)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 185')
  assert(seqeq(r.shape,{2,3}),'isnan unary shape 185')
  assert(seqeq(r.strides,{3,1}),'isnan unary strides 185')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'isnan unary values 185')
end
do -- isnan unary 186
  local a=np.array({127,17,17,2,63},np.uint32)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 186')
  assert(seqeq(r.shape,{5}),'isnan unary shape 186')
  assert(seqeq(r.strides,{1}),'isnan unary strides 186')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isnan unary values 186')
end
do -- isnan unary 187
  local a=np.array({{(0/0),0.0,-2.25},{-9.5,11.0,-1.0}},np.float16)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 187')
  assert(seqeq(r.shape,{2,3}),'isnan unary shape 187')
  assert(seqeq(r.strides,{3,1}),'isnan unary strides 187')
  assert(veq(r:tolist(),{{true,false,false},{false,false,false}}),'isnan unary values 187')
end
do -- isnan unary 188
  local a=np.array({{2,63,-1},{2,126,-31}},np.int64)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 188')
  assert(seqeq(r.shape,{2,3}),'isnan unary shape 188')
  assert(seqeq(r.strides,{3,1}),'isnan unary strides 188')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'isnan unary values 188')
end
do -- isnan unary 189
  local a=np.array({{2,0,17},{2,0,63}},np.uint8)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 189')
  assert(seqeq(r.shape,{2,3}),'isnan unary shape 189')
  assert(seqeq(r.strides,{3,1}),'isnan unary strides 189')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'isnan unary values 189')
end
do -- isnan unary 190
  local a=(np.array({{-2.25,0.5,-math.huge},{-math.huge,(0/0),(0/0)}},np.float16)).T
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 190')
  assert(seqeq(r.shape,{3,2}),'isnan unary shape 190')
  assert(seqeq(r.strides,{1,3}),'isnan unary strides 190')
  assert(veq(r:tolist(),{{false,false},{false,true},{false,true}}),'isnan unary values 190')
end
do -- isnan unary 191
  local a=(np.array({{63,17,127},{63,2,127}},np.uint32)).T
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 191')
  assert(seqeq(r.shape,{3,2}),'isnan unary shape 191')
  assert(seqeq(r.strides,{1,3}),'isnan unary strides 191')
  assert(veq(r:tolist(),{{false,false},{false,false},{false,false}}),'isnan unary values 191')
end
do -- isnan unary 192
  local a=np.array({(0/0),-9.5,math.huge,-0.0,-math.huge},np.float32)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 192')
  assert(seqeq(r.shape,{5}),'isnan unary shape 192')
  assert(seqeq(r.strides,{1}),'isnan unary strides 192')
  assert(veq(r:tolist(),{true,false,false,false,false}),'isnan unary values 192')
end
do -- isnan unary 193
  local a=np.array({63,-31,1,-31,-127},np.int64)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 193')
  assert(seqeq(r.shape,{5}),'isnan unary shape 193')
  assert(seqeq(r.strides,{1}),'isnan unary strides 193')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isnan unary values 193')
end
do -- isnan unary 194
  local a=np.array({{-math.huge,0.0,-1.0},{-1.0,-math.huge,3.75}},np.float16)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 194')
  assert(seqeq(r.shape,{2,3}),'isnan unary shape 194')
  assert(seqeq(r.strides,{3,1}),'isnan unary strides 194')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'isnan unary values 194')
end
do -- isnan unary 195
  local a=np.array({{9,-1,-7},{2,63,-1}},np.int64)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 195')
  assert(seqeq(r.shape,{2,3}),'isnan unary shape 195')
  assert(seqeq(r.strides,{3,1}),'isnan unary strides 195')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'isnan unary values 195')
end
do -- isnan unary 196
  local a=np.array({9,2,2,-7,-127},np.int8)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 196')
  assert(seqeq(r.shape,{5}),'isnan unary shape 196')
  assert(seqeq(r.strides,{1}),'isnan unary strides 196')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isnan unary values 196')
end
do -- isnan unary 197
  local a=np.array({{127,127,1},{2,5,63}},np.uint16)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 197')
  assert(seqeq(r.shape,{2,3}),'isnan unary shape 197')
  assert(seqeq(r.strides,{3,1}),'isnan unary strides 197')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'isnan unary values 197')
end
do -- isnan unary 198
  local a=np.array({127,5,2,63,1},np.uint32)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 198')
  assert(seqeq(r.shape,{5}),'isnan unary shape 198')
  assert(seqeq(r.strides,{1}),'isnan unary strides 198')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isnan unary values 198')
end
do -- isnan unary 199
  local a=np.array({{0,1,-7},{126,0,2}},np.int8)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 199')
  assert(seqeq(r.shape,{2,3}),'isnan unary shape 199')
  assert(seqeq(r.strides,{3,1}),'isnan unary strides 199')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'isnan unary values 199')
end
do -- isnan unary 200
  local a=np.array({2,2,1,63,0},np.uint32)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 200')
  assert(seqeq(r.shape,{5}),'isnan unary shape 200')
  assert(seqeq(r.strides,{1}),'isnan unary strides 200')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isnan unary values 200')
end
do -- isnan unary 201
  local a=np.array({{2,0,126},{126,-31,2}},np.int64)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 201')
  assert(seqeq(r.shape,{2,3}),'isnan unary shape 201')
  assert(seqeq(r.strides,{3,1}),'isnan unary strides 201')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'isnan unary values 201')
end
do -- isnan unary 202
  local a=np.array({{2,1,9},{-127,0,2}},np.int64)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 202')
  assert(seqeq(r.shape,{2,3}),'isnan unary shape 202')
  assert(seqeq(r.strides,{3,1}),'isnan unary strides 202')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'isnan unary values 202')
end
do -- isnan unary 203
  local a=np.array({127,1,1,17,1},np.uint8)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 203')
  assert(seqeq(r.shape,{5}),'isnan unary shape 203')
  assert(seqeq(r.strides,{1}),'isnan unary strides 203')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isnan unary values 203')
end
do -- isnan unary 204
  local a=np.array({1.0,1.0,0.5,-0.0,-2.25},np.float64)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 204')
  assert(seqeq(r.shape,{5}),'isnan unary shape 204')
  assert(seqeq(r.strides,{1}),'isnan unary strides 204')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isnan unary values 204')
end
do -- isnan unary 205
  local a=np.array({{2,2,2},{251,0,63}},np.uint64)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 205')
  assert(seqeq(r.shape,{2,3}),'isnan unary shape 205')
  assert(seqeq(r.strides,{3,1}),'isnan unary strides 205')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'isnan unary values 205')
end
do -- isnan unary 206
  local a=np.array({-31,-31,-127,126,-31},np.int16)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 206')
  assert(seqeq(r.shape,{5}),'isnan unary shape 206')
  assert(seqeq(r.strides,{1}),'isnan unary strides 206')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isnan unary values 206')
end
do -- isnan unary 207
  local a=np.array({{0,17,5},{0,63,0}},np.uint8)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 207')
  assert(seqeq(r.shape,{2,3}),'isnan unary shape 207')
  assert(seqeq(r.strides,{3,1}),'isnan unary strides 207')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'isnan unary values 207')
end
do -- isnan unary 208
  local a=np.array({251,251,251,127,251},np.uint16)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 208')
  assert(seqeq(r.shape,{5}),'isnan unary shape 208')
  assert(seqeq(r.strides,{1}),'isnan unary strides 208')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isnan unary values 208')
end
do -- isnan unary 209
  local a=np.array({2,126,9,-1,126},np.int16)
  local r=np.isnan(a)
  assert(r.dtype=='bool','isnan unary dtype 209')
  assert(seqeq(r.shape,{5}),'isnan unary shape 209')
  assert(seqeq(r.strides,{1}),'isnan unary strides 209')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isnan unary values 209')
end
do -- isinf unary 210
  local a=np.array({2,1,127,17,127},np.uint8)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 210')
  assert(seqeq(r.shape,{5}),'isinf unary shape 210')
  assert(seqeq(r.strides,{1}),'isinf unary strides 210')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isinf unary values 210')
end
do -- isinf unary 211
  local a=np.array({17,5,251,2,127},np.uint16)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 211')
  assert(seqeq(r.shape,{5}),'isinf unary shape 211')
  assert(seqeq(r.strides,{1}),'isinf unary strides 211')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isinf unary values 211')
end
do -- isinf unary 212
  local a=np.array({{127,251,251},{63,127,0}},np.uint64)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 212')
  assert(seqeq(r.shape,{2,3}),'isinf unary shape 212')
  assert(seqeq(r.strides,{3,1}),'isinf unary strides 212')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'isinf unary values 212')
end
do -- isinf unary 213
  local a=np.array({0.5,math.huge,-2.25,-math.huge,-math.huge},np.float16)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 213')
  assert(seqeq(r.shape,{5}),'isinf unary shape 213')
  assert(seqeq(r.strides,{1}),'isinf unary strides 213')
  assert(veq(r:tolist(),{false,true,false,true,true}),'isinf unary values 213')
end
do -- isinf unary 214
  local a=np.array({{0.0,11.0,(0/0)},{math.huge,-math.huge,3.75}},np.float32)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 214')
  assert(seqeq(r.shape,{2,3}),'isinf unary shape 214')
  assert(seqeq(r.strides,{3,1}),'isinf unary strides 214')
  assert(veq(r:tolist(),{{false,false,false},{true,true,false}}),'isinf unary values 214')
end
do -- isinf unary 215
  local a=(np.array({{17,1,63},{2,63,127}},np.uint32)).T
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 215')
  assert(seqeq(r.shape,{3,2}),'isinf unary shape 215')
  assert(seqeq(r.strides,{1,3}),'isinf unary strides 215')
  assert(veq(r:tolist(),{{false,false},{false,false},{false,false}}),'isinf unary values 215')
end
do -- isinf unary 216
  local a=np.array({-1.0,11.0,11.0,11.0,(0/0)},np.float16)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 216')
  assert(seqeq(r.shape,{5}),'isinf unary shape 216')
  assert(seqeq(r.strides,{1}),'isinf unary strides 216')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isinf unary values 216')
end
do -- isinf unary 217
  local a=(np.array({{0,0,2},{2,5,0}},np.uint64)).T
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 217')
  assert(seqeq(r.shape,{3,2}),'isinf unary shape 217')
  assert(seqeq(r.strides,{1,3}),'isinf unary strides 217')
  assert(veq(r:tolist(),{{false,false},{false,false},{false,false}}),'isinf unary values 217')
end
do -- isinf unary 218
  local a=np.array({{-7,1,126},{63,-127,-1}},np.int8)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 218')
  assert(seqeq(r.shape,{2,3}),'isinf unary shape 218')
  assert(seqeq(r.strides,{3,1}),'isinf unary strides 218')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'isinf unary values 218')
end
do -- isinf unary 219
  local a=np.array({{false,true,false},{true,true,true}},np.bool)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 219')
  assert(seqeq(r.shape,{2,3}),'isinf unary shape 219')
  assert(seqeq(r.strides,{3,1}),'isinf unary strides 219')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'isinf unary values 219')
end
do -- isinf unary 220
  local a=np.array({2,127,0,63,5},np.uint64)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 220')
  assert(seqeq(r.shape,{5}),'isinf unary shape 220')
  assert(seqeq(r.strides,{1}),'isinf unary strides 220')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isinf unary values 220')
end
do -- isinf unary 221
  local a=np.array({false,false,true,true,false},np.bool)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 221')
  assert(seqeq(r.shape,{5}),'isinf unary shape 221')
  assert(seqeq(r.strides,{1}),'isinf unary strides 221')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isinf unary values 221')
end
do -- isinf unary 222
  local a=np.array({{-7,126,63},{-127,-127,2}},np.int64)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 222')
  assert(seqeq(r.shape,{2,3}),'isinf unary shape 222')
  assert(seqeq(r.strides,{3,1}),'isinf unary strides 222')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'isinf unary values 222')
end
do -- isinf unary 223
  local a=(np.array({{3.75,-9.5,-1.0},{1.0,3.75,(0/0)}},np.float64)).T
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 223')
  assert(seqeq(r.shape,{3,2}),'isinf unary shape 223')
  assert(seqeq(r.strides,{1,3}),'isinf unary strides 223')
  assert(veq(r:tolist(),{{false,false},{false,false},{false,false}}),'isinf unary values 223')
end
do -- isinf unary 224
  local a=np.array({0,0,-127,-1,126},np.int16)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 224')
  assert(seqeq(r.shape,{5}),'isinf unary shape 224')
  assert(seqeq(r.strides,{1}),'isinf unary strides 224')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isinf unary values 224')
end
do -- isinf unary 225
  local a=(np.array({{(0/0),0.5,1.0},{0.5,(0/0),-0.0}},np.float32)).T
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 225')
  assert(seqeq(r.shape,{3,2}),'isinf unary shape 225')
  assert(seqeq(r.strides,{1,3}),'isinf unary strides 225')
  assert(veq(r:tolist(),{{false,false},{false,false},{false,false}}),'isinf unary values 225')
end
do -- isinf unary 226
  local a=np.array({-1.0,-math.huge,3.75,-math.huge,-math.huge},np.float32)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 226')
  assert(seqeq(r.shape,{5}),'isinf unary shape 226')
  assert(seqeq(r.strides,{1}),'isinf unary strides 226')
  assert(veq(r:tolist(),{false,true,false,true,true}),'isinf unary values 226')
end
do -- isinf unary 227
  local a=np.array({63,127,251,63,127},np.uint16)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 227')
  assert(seqeq(r.shape,{5}),'isinf unary shape 227')
  assert(seqeq(r.strides,{1}),'isinf unary strides 227')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isinf unary values 227')
end
do -- isinf unary 228
  local a=np.array({{126,126,0},{1,-31,1}},np.int16)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 228')
  assert(seqeq(r.shape,{2,3}),'isinf unary shape 228')
  assert(seqeq(r.strides,{3,1}),'isinf unary strides 228')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'isinf unary values 228')
end
do -- isinf unary 229
  local a=np.array({0.5,3.75,0.5,-9.5,-9.5},np.float64)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 229')
  assert(seqeq(r.shape,{5}),'isinf unary shape 229')
  assert(seqeq(r.strides,{1}),'isinf unary strides 229')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isinf unary values 229')
end
do -- isinf unary 230
  local a=np.array({5,17,5,5,1},np.uint8)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 230')
  assert(seqeq(r.shape,{5}),'isinf unary shape 230')
  assert(seqeq(r.strides,{1}),'isinf unary strides 230')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isinf unary values 230')
end
do -- isinf unary 231
  local a=(np.array({{2,126,-1},{63,1,2}},np.int8)).T
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 231')
  assert(seqeq(r.shape,{3,2}),'isinf unary shape 231')
  assert(seqeq(r.strides,{1,3}),'isinf unary strides 231')
  assert(veq(r:tolist(),{{false,false},{false,false},{false,false}}),'isinf unary values 231')
end
do -- isinf unary 232
  local a=(np.array({{-7,-1,-31},{9,-1,0}},np.int8)).T
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 232')
  assert(seqeq(r.shape,{3,2}),'isinf unary shape 232')
  assert(seqeq(r.strides,{1,3}),'isinf unary strides 232')
  assert(veq(r:tolist(),{{false,false},{false,false},{false,false}}),'isinf unary values 232')
end
do -- isinf unary 233
  local a=np.array({-127,2,-31,-1,-7},np.int32)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 233')
  assert(seqeq(r.shape,{5}),'isinf unary shape 233')
  assert(seqeq(r.strides,{1}),'isinf unary strides 233')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isinf unary values 233')
end
do -- isinf unary 234
  local a=np.array({false,false,false,true,false},np.bool)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 234')
  assert(seqeq(r.shape,{5}),'isinf unary shape 234')
  assert(seqeq(r.strides,{1}),'isinf unary strides 234')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isinf unary values 234')
end
do -- isinf unary 235
  local a=np.array({{1,2,63},{126,1,2}},np.int64)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 235')
  assert(seqeq(r.shape,{2,3}),'isinf unary shape 235')
  assert(seqeq(r.strides,{3,1}),'isinf unary strides 235')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'isinf unary values 235')
end
do -- isinf unary 236
  local a=np.array({{-1.0,1.0,-1.0},{-1.0,(0/0),-9.5}},np.float32)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 236')
  assert(seqeq(r.shape,{2,3}),'isinf unary shape 236')
  assert(seqeq(r.strides,{3,1}),'isinf unary strides 236')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'isinf unary values 236')
end
do -- isinf unary 237
  local a=np.array({math.huge,math.huge,0.0,1.0,3.75},np.float64)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 237')
  assert(seqeq(r.shape,{5}),'isinf unary shape 237')
  assert(seqeq(r.strides,{1}),'isinf unary strides 237')
  assert(veq(r:tolist(),{true,true,false,false,false}),'isinf unary values 237')
end
do -- isinf unary 238
  local a=np.array({1,0,-7,2,63},np.int64)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 238')
  assert(seqeq(r.shape,{5}),'isinf unary shape 238')
  assert(seqeq(r.strides,{1}),'isinf unary strides 238')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isinf unary values 238')
end
do -- isinf unary 239
  local a=(np.array({{1.0,-2.25,-9.5},{math.huge,0.0,0.5}},np.float32)).T
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 239')
  assert(seqeq(r.shape,{3,2}),'isinf unary shape 239')
  assert(seqeq(r.strides,{1,3}),'isinf unary strides 239')
  assert(veq(r:tolist(),{{false,true},{false,false},{false,false}}),'isinf unary values 239')
end
do -- isinf unary 240
  local a=np.array({2,-1,-1,63,1},np.int64)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 240')
  assert(seqeq(r.shape,{5}),'isinf unary shape 240')
  assert(seqeq(r.strides,{1}),'isinf unary strides 240')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isinf unary values 240')
end
do -- isinf unary 241
  local a=np.array({0,-31,63,-1,-127},np.int8)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 241')
  assert(seqeq(r.shape,{5}),'isinf unary shape 241')
  assert(seqeq(r.strides,{1}),'isinf unary strides 241')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isinf unary values 241')
end
do -- isinf unary 242
  local a=np.array({false,false,true,false,true},np.bool)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 242')
  assert(seqeq(r.shape,{5}),'isinf unary shape 242')
  assert(seqeq(r.strides,{1}),'isinf unary strides 242')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isinf unary values 242')
end
do -- isinf unary 243
  local a=np.array({63,2,0,63,63},np.int8)
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 243')
  assert(seqeq(r.shape,{5}),'isinf unary shape 243')
  assert(seqeq(r.strides,{1}),'isinf unary strides 243')
  assert(veq(r:tolist(),{false,false,false,false,false}),'isinf unary values 243')
end
do -- isinf unary 244
  local a=(np.array({{true,true,false},{true,false,false}},np.bool)).T
  local r=np.isinf(a)
  assert(r.dtype=='bool','isinf unary dtype 244')
  assert(seqeq(r.shape,{3,2}),'isinf unary shape 244')
  assert(seqeq(r.strides,{1,3}),'isinf unary strides 244')
  assert(veq(r:tolist(),{{false,false},{false,false},{false,false}}),'isinf unary values 244')
end
do -- isfinite unary 245
  local a=np.array({17,2,251,0,2},np.uint16)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 245')
  assert(seqeq(r.shape,{5}),'isfinite unary shape 245')
  assert(seqeq(r.strides,{1}),'isfinite unary strides 245')
  assert(veq(r:tolist(),{true,true,true,true,true}),'isfinite unary values 245')
end
do -- isfinite unary 246
  local a=np.array({1,1,17,1,1},np.uint64)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 246')
  assert(seqeq(r.shape,{5}),'isfinite unary shape 246')
  assert(seqeq(r.strides,{1}),'isfinite unary strides 246')
  assert(veq(r:tolist(),{true,true,true,true,true}),'isfinite unary values 246')
end
do -- isfinite unary 247
  local a=np.array({-2.25,(0/0),0.5,0.5,math.huge},np.float16)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 247')
  assert(seqeq(r.shape,{5}),'isfinite unary shape 247')
  assert(seqeq(r.strides,{1}),'isfinite unary strides 247')
  assert(veq(r:tolist(),{true,false,true,true,false}),'isfinite unary values 247')
end
do -- isfinite unary 248
  local a=np.array({{251,127,251},{17,2,0}},np.uint16)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 248')
  assert(seqeq(r.shape,{2,3}),'isfinite unary shape 248')
  assert(seqeq(r.strides,{3,1}),'isfinite unary strides 248')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary values 248')
end
do -- isfinite unary 249
  local a=np.array({2,-7,0,2,1},np.int32)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 249')
  assert(seqeq(r.shape,{5}),'isfinite unary shape 249')
  assert(seqeq(r.strides,{1}),'isfinite unary strides 249')
  assert(veq(r:tolist(),{true,true,true,true,true}),'isfinite unary values 249')
end
do -- isfinite unary 250
  local a=(np.array({{true,false,false},{true,true,false}},np.bool)).T
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 250')
  assert(seqeq(r.shape,{3,2}),'isfinite unary shape 250')
  assert(seqeq(r.strides,{1,3}),'isfinite unary strides 250')
  assert(veq(r:tolist(),{{true,true},{true,true},{true,true}}),'isfinite unary values 250')
end
do -- isfinite unary 251
  local a=np.array({251,127,63,17,127},np.uint64)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 251')
  assert(seqeq(r.shape,{5}),'isfinite unary shape 251')
  assert(seqeq(r.strides,{1}),'isfinite unary strides 251')
  assert(veq(r:tolist(),{true,true,true,true,true}),'isfinite unary values 251')
end
do -- isfinite unary 252
  local a=np.array({2,127,127,1,17},np.uint8)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 252')
  assert(seqeq(r.shape,{5}),'isfinite unary shape 252')
  assert(seqeq(r.strides,{1}),'isfinite unary strides 252')
  assert(veq(r:tolist(),{true,true,true,true,true}),'isfinite unary values 252')
end
do -- isfinite unary 253
  local a=np.array({-7,63,2,-1,1},np.int64)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 253')
  assert(seqeq(r.shape,{5}),'isfinite unary shape 253')
  assert(seqeq(r.strides,{1}),'isfinite unary strides 253')
  assert(veq(r:tolist(),{true,true,true,true,true}),'isfinite unary values 253')
end
do -- isfinite unary 254
  local a=np.array({{false,false,false},{true,true,true}},np.bool)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 254')
  assert(seqeq(r.shape,{2,3}),'isfinite unary shape 254')
  assert(seqeq(r.strides,{3,1}),'isfinite unary strides 254')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary values 254')
end
do -- isfinite unary 255
  local a=(np.array({{126,63,-1},{-127,-1,2}},np.int64)).T
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 255')
  assert(seqeq(r.shape,{3,2}),'isfinite unary shape 255')
  assert(seqeq(r.strides,{1,3}),'isfinite unary strides 255')
  assert(veq(r:tolist(),{{true,true},{true,true},{true,true}}),'isfinite unary values 255')
end
do -- isfinite unary 256
  local a=np.array({{true,false,false},{false,true,true}},np.bool)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 256')
  assert(seqeq(r.shape,{2,3}),'isfinite unary shape 256')
  assert(seqeq(r.strides,{3,1}),'isfinite unary strides 256')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary values 256')
end
do -- isfinite unary 257
  local a=np.array({63,126,-7,-1,-31},np.int8)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 257')
  assert(seqeq(r.shape,{5}),'isfinite unary shape 257')
  assert(seqeq(r.strides,{1}),'isfinite unary strides 257')
  assert(veq(r:tolist(),{true,true,true,true,true}),'isfinite unary values 257')
end
do -- isfinite unary 258
  local a=np.array({1.0,0.0,1.0,11.0,-2.25},np.float16)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 258')
  assert(seqeq(r.shape,{5}),'isfinite unary shape 258')
  assert(seqeq(r.strides,{1}),'isfinite unary strides 258')
  assert(veq(r:tolist(),{true,true,true,true,true}),'isfinite unary values 258')
end
do -- isfinite unary 259
  local a=np.array({{-31,126,2},{9,0,0}},np.int8)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 259')
  assert(seqeq(r.shape,{2,3}),'isfinite unary shape 259')
  assert(seqeq(r.strides,{3,1}),'isfinite unary strides 259')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary values 259')
end
do -- isfinite unary 260
  local a=np.array({{63,-127,-7},{1,2,1}},np.int16)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 260')
  assert(seqeq(r.shape,{2,3}),'isfinite unary shape 260')
  assert(seqeq(r.strides,{3,1}),'isfinite unary strides 260')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary values 260')
end
do -- isfinite unary 261
  local a=(np.array({{-7,9,-1},{-7,-31,-31}},np.int16)).T
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 261')
  assert(seqeq(r.shape,{3,2}),'isfinite unary shape 261')
  assert(seqeq(r.strides,{1,3}),'isfinite unary strides 261')
  assert(veq(r:tolist(),{{true,true},{true,true},{true,true}}),'isfinite unary values 261')
end
do -- isfinite unary 262
  local a=np.array({(0/0),math.huge,0.0,math.huge,11.0},np.float64)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 262')
  assert(seqeq(r.shape,{5}),'isfinite unary shape 262')
  assert(seqeq(r.strides,{1}),'isfinite unary strides 262')
  assert(veq(r:tolist(),{false,false,true,false,true}),'isfinite unary values 262')
end
do -- isfinite unary 263
  local a=np.array({math.huge,-9.5,(0/0),11.0,1.0},np.float64)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 263')
  assert(seqeq(r.shape,{5}),'isfinite unary shape 263')
  assert(seqeq(r.strides,{1}),'isfinite unary strides 263')
  assert(veq(r:tolist(),{false,true,false,true,true}),'isfinite unary values 263')
end
do -- isfinite unary 264
  local a=np.array({0.5,-1.0,-2.25,(0/0),0.0},np.float32)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 264')
  assert(seqeq(r.shape,{5}),'isfinite unary shape 264')
  assert(seqeq(r.strides,{1}),'isfinite unary strides 264')
  assert(veq(r:tolist(),{true,true,true,false,true}),'isfinite unary values 264')
end
do -- isfinite unary 265
  local a=(np.array({{-1.0,0.5,-9.5},{-9.5,11.0,(0/0)}},np.float32)).T
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 265')
  assert(seqeq(r.shape,{3,2}),'isfinite unary shape 265')
  assert(seqeq(r.strides,{1,3}),'isfinite unary strides 265')
  assert(veq(r:tolist(),{{true,true},{true,true},{true,false}}),'isfinite unary values 265')
end
do -- isfinite unary 266
  local a=np.array({-math.huge,11.0,0.5,0.5,0.5},np.float16)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 266')
  assert(seqeq(r.shape,{5}),'isfinite unary shape 266')
  assert(seqeq(r.strides,{1}),'isfinite unary strides 266')
  assert(veq(r:tolist(),{false,true,true,true,true}),'isfinite unary values 266')
end
do -- isfinite unary 267
  local a=np.array({{true,false,true},{false,true,true}},np.bool)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 267')
  assert(seqeq(r.shape,{2,3}),'isfinite unary shape 267')
  assert(seqeq(r.strides,{3,1}),'isfinite unary strides 267')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary values 267')
end
do -- isfinite unary 268
  local a=np.array({1.0,-1.0,-9.5,11.0,-math.huge},np.float64)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 268')
  assert(seqeq(r.shape,{5}),'isfinite unary shape 268')
  assert(seqeq(r.strides,{1}),'isfinite unary strides 268')
  assert(veq(r:tolist(),{true,true,true,true,false}),'isfinite unary values 268')
end
do -- isfinite unary 269
  local a=(np.array({{63,5,17},{127,17,1}},np.uint8)).T
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 269')
  assert(seqeq(r.shape,{3,2}),'isfinite unary shape 269')
  assert(seqeq(r.strides,{1,3}),'isfinite unary strides 269')
  assert(veq(r:tolist(),{{true,true},{true,true},{true,true}}),'isfinite unary values 269')
end
do -- isfinite unary 270
  local a=np.array({1.0,3.75,3.75,11.0,11.0},np.float16)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 270')
  assert(seqeq(r.shape,{5}),'isfinite unary shape 270')
  assert(seqeq(r.strides,{1}),'isfinite unary strides 270')
  assert(veq(r:tolist(),{true,true,true,true,true}),'isfinite unary values 270')
end
do -- isfinite unary 271
  local a=np.array({1,-7,63,-127,126},np.int16)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 271')
  assert(seqeq(r.shape,{5}),'isfinite unary shape 271')
  assert(seqeq(r.strides,{1}),'isfinite unary strides 271')
  assert(veq(r:tolist(),{true,true,true,true,true}),'isfinite unary values 271')
end
do -- isfinite unary 272
  local a=np.array({251,63,2,1,1},np.uint16)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 272')
  assert(seqeq(r.shape,{5}),'isfinite unary shape 272')
  assert(seqeq(r.strides,{1}),'isfinite unary strides 272')
  assert(veq(r:tolist(),{true,true,true,true,true}),'isfinite unary values 272')
end
do -- isfinite unary 273
  local a=np.array({{127,5,127},{127,5,1}},np.uint16)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 273')
  assert(seqeq(r.shape,{2,3}),'isfinite unary shape 273')
  assert(seqeq(r.strides,{3,1}),'isfinite unary strides 273')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary values 273')
end
do -- isfinite unary 274
  local a=np.array({{(0/0),3.75,-2.25},{-0.0,-2.25,(0/0)}},np.float16)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 274')
  assert(seqeq(r.shape,{2,3}),'isfinite unary shape 274')
  assert(seqeq(r.strides,{3,1}),'isfinite unary strides 274')
  assert(veq(r:tolist(),{{false,true,true},{true,true,false}}),'isfinite unary values 274')
end
do -- isfinite unary 275
  local a=np.array({-1,-1,63,-31,0},np.int8)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 275')
  assert(seqeq(r.shape,{5}),'isfinite unary shape 275')
  assert(seqeq(r.strides,{1}),'isfinite unary strides 275')
  assert(veq(r:tolist(),{true,true,true,true,true}),'isfinite unary values 275')
end
do -- isfinite unary 276
  local a=np.array({{126,63,63},{-31,2,-7}},np.int16)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 276')
  assert(seqeq(r.shape,{2,3}),'isfinite unary shape 276')
  assert(seqeq(r.strides,{3,1}),'isfinite unary strides 276')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary values 276')
end
do -- isfinite unary 277
  local a=np.array({1,-127,-1,-7,0},np.int32)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 277')
  assert(seqeq(r.shape,{5}),'isfinite unary shape 277')
  assert(seqeq(r.strides,{1}),'isfinite unary strides 277')
  assert(veq(r:tolist(),{true,true,true,true,true}),'isfinite unary values 277')
end
do -- isfinite unary 278
  local a=np.array({{-0.0,-math.huge,-math.huge},{math.huge,0.5,0.0}},np.float16)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 278')
  assert(seqeq(r.shape,{2,3}),'isfinite unary shape 278')
  assert(seqeq(r.strides,{3,1}),'isfinite unary strides 278')
  assert(veq(r:tolist(),{{true,false,false},{false,true,true}}),'isfinite unary values 278')
end
do -- isfinite unary 279
  local a=np.array({{-31,9,0},{2,-7,9}},np.int8)
  local r=np.isfinite(a)
  assert(r.dtype=='bool','isfinite unary dtype 279')
  assert(seqeq(r.shape,{2,3}),'isfinite unary shape 279')
  assert(seqeq(r.strides,{3,1}),'isfinite unary strides 279')
  assert(veq(r:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary values 279')
end
do -- signbit unary 280
  local a=np.array({-9.5,11.0,math.huge,math.huge,0.0},np.float64)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 280')
  assert(seqeq(r.shape,{5}),'signbit unary shape 280')
  assert(seqeq(r.strides,{1}),'signbit unary strides 280')
  assert(veq(r:tolist(),{true,false,false,false,false}),'signbit unary values 280')
end
do -- signbit unary 281
  local a=np.array({-7,-127,-1,-1,9},np.int8)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 281')
  assert(seqeq(r.shape,{5}),'signbit unary shape 281')
  assert(seqeq(r.strides,{1}),'signbit unary strides 281')
  assert(veq(r:tolist(),{true,true,true,true,false}),'signbit unary values 281')
end
do -- signbit unary 282
  local a=np.array({-7,0,-31,0,-7},np.int16)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 282')
  assert(seqeq(r.shape,{5}),'signbit unary shape 282')
  assert(seqeq(r.strides,{1}),'signbit unary strides 282')
  assert(veq(r:tolist(),{true,false,true,false,true}),'signbit unary values 282')
end
do -- signbit unary 283
  local a=np.array({5,17,1,5,127},np.uint32)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 283')
  assert(seqeq(r.shape,{5}),'signbit unary shape 283')
  assert(seqeq(r.strides,{1}),'signbit unary strides 283')
  assert(veq(r:tolist(),{false,false,false,false,false}),'signbit unary values 283')
end
do -- signbit unary 284
  local a=np.array({{-127,1,-1},{-7,2,126}},np.int64)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 284')
  assert(seqeq(r.shape,{2,3}),'signbit unary shape 284')
  assert(seqeq(r.strides,{3,1}),'signbit unary strides 284')
  assert(veq(r:tolist(),{{true,false,true},{true,false,false}}),'signbit unary values 284')
end
do -- signbit unary 285
  local a=np.array({3.75,-1.0,-0.0,11.0,0.0},np.float64)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 285')
  assert(seqeq(r.shape,{5}),'signbit unary shape 285')
  assert(seqeq(r.strides,{1}),'signbit unary strides 285')
  assert(veq(r:tolist(),{false,true,true,false,false}),'signbit unary values 285')
end
do -- signbit unary 286
  local a=np.array({-1.0,math.huge,0.0,-2.25,-9.5},np.float32)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 286')
  assert(seqeq(r.shape,{5}),'signbit unary shape 286')
  assert(seqeq(r.strides,{1}),'signbit unary strides 286')
  assert(veq(r:tolist(),{true,false,false,true,true}),'signbit unary values 286')
end
do -- signbit unary 287
  local a=np.array({63,1,-1,63,63},np.int8)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 287')
  assert(seqeq(r.shape,{5}),'signbit unary shape 287')
  assert(seqeq(r.strides,{1}),'signbit unary strides 287')
  assert(veq(r:tolist(),{false,false,true,false,false}),'signbit unary values 287')
end
do -- signbit unary 288
  local a=np.array({-31,126,9,63,-31},np.int8)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 288')
  assert(seqeq(r.shape,{5}),'signbit unary shape 288')
  assert(seqeq(r.strides,{1}),'signbit unary strides 288')
  assert(veq(r:tolist(),{true,false,false,false,true}),'signbit unary values 288')
end
do -- signbit unary 289
  local a=np.array({{0,17,63},{251,127,251}},np.uint64)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 289')
  assert(seqeq(r.shape,{2,3}),'signbit unary shape 289')
  assert(seqeq(r.strides,{3,1}),'signbit unary strides 289')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'signbit unary values 289')
end
do -- signbit unary 290
  local a=(np.array({{0,0,-127},{-127,9,2}},np.int16)).T
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 290')
  assert(seqeq(r.shape,{3,2}),'signbit unary shape 290')
  assert(seqeq(r.strides,{1,3}),'signbit unary strides 290')
  assert(veq(r:tolist(),{{false,true},{false,false},{true,false}}),'signbit unary values 290')
end
do -- signbit unary 291
  local a=np.array({126,63,-31,-7,126},np.int8)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 291')
  assert(seqeq(r.shape,{5}),'signbit unary shape 291')
  assert(seqeq(r.strides,{1}),'signbit unary strides 291')
  assert(veq(r:tolist(),{false,false,true,true,false}),'signbit unary values 291')
end
do -- signbit unary 292
  local a=np.array({-2.25,-math.huge,-9.5,1.0,-1.0},np.float32)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 292')
  assert(seqeq(r.shape,{5}),'signbit unary shape 292')
  assert(seqeq(r.strides,{1}),'signbit unary strides 292')
  assert(veq(r:tolist(),{true,true,true,false,true}),'signbit unary values 292')
end
do -- signbit unary 293
  local a=np.array({{2,63,-127},{-1,9,0}},np.int8)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 293')
  assert(seqeq(r.shape,{2,3}),'signbit unary shape 293')
  assert(seqeq(r.strides,{3,1}),'signbit unary strides 293')
  assert(veq(r:tolist(),{{false,false,true},{true,false,false}}),'signbit unary values 293')
end
do -- signbit unary 294
  local a=(np.array({{63,-1,1},{2,-7,1}},np.int64)).T
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 294')
  assert(seqeq(r.shape,{3,2}),'signbit unary shape 294')
  assert(seqeq(r.strides,{1,3}),'signbit unary strides 294')
  assert(veq(r:tolist(),{{false,false},{true,true},{false,false}}),'signbit unary values 294')
end
do -- signbit unary 295
  local a=(np.array({{9,-127,1},{-127,-7,2}},np.int8)).T
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 295')
  assert(seqeq(r.shape,{3,2}),'signbit unary shape 295')
  assert(seqeq(r.strides,{1,3}),'signbit unary strides 295')
  assert(veq(r:tolist(),{{false,true},{true,true},{false,false}}),'signbit unary values 295')
end
do -- signbit unary 296
  local a=(np.array({{true,true,true},{false,false,false}},np.bool)).T
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 296')
  assert(seqeq(r.shape,{3,2}),'signbit unary shape 296')
  assert(seqeq(r.strides,{1,3}),'signbit unary strides 296')
  assert(veq(r:tolist(),{{false,false},{false,false},{false,false}}),'signbit unary values 296')
end
do -- signbit unary 297
  local a=np.array({{-1,-127,-7},{-31,63,2}},np.int64)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 297')
  assert(seqeq(r.shape,{2,3}),'signbit unary shape 297')
  assert(seqeq(r.strides,{3,1}),'signbit unary strides 297')
  assert(veq(r:tolist(),{{true,true,true},{true,false,false}}),'signbit unary values 297')
end
do -- signbit unary 298
  local a=(np.array({{63,251,2},{127,5,1}},np.uint64)).T
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 298')
  assert(seqeq(r.shape,{3,2}),'signbit unary shape 298')
  assert(seqeq(r.strides,{1,3}),'signbit unary strides 298')
  assert(veq(r:tolist(),{{false,false},{false,false},{false,false}}),'signbit unary values 298')
end
do -- signbit unary 299
  local a=np.array({-2.25,1.0,-math.huge,-0.0,-0.0},np.float64)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 299')
  assert(seqeq(r.shape,{5}),'signbit unary shape 299')
  assert(seqeq(r.strides,{1}),'signbit unary strides 299')
  assert(veq(r:tolist(),{true,false,true,true,true}),'signbit unary values 299')
end
do -- signbit unary 300
  local a=np.array({2,2,63,251,0},np.uint8)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 300')
  assert(seqeq(r.shape,{5}),'signbit unary shape 300')
  assert(seqeq(r.strides,{1}),'signbit unary strides 300')
  assert(veq(r:tolist(),{false,false,false,false,false}),'signbit unary values 300')
end
do -- signbit unary 301
  local a=np.array({126,0,0,9,9},np.int16)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 301')
  assert(seqeq(r.shape,{5}),'signbit unary shape 301')
  assert(seqeq(r.strides,{1}),'signbit unary strides 301')
  assert(veq(r:tolist(),{false,false,false,false,false}),'signbit unary values 301')
end
do -- signbit unary 302
  local a=np.array({9,-127,-1,-31,126},np.int16)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 302')
  assert(seqeq(r.shape,{5}),'signbit unary shape 302')
  assert(seqeq(r.strides,{1}),'signbit unary strides 302')
  assert(veq(r:tolist(),{false,true,true,true,false}),'signbit unary values 302')
end
do -- signbit unary 303
  local a=np.array({-9.5,11.0,1.0,-2.25,-1.0},np.float64)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 303')
  assert(seqeq(r.shape,{5}),'signbit unary shape 303')
  assert(seqeq(r.strides,{1}),'signbit unary strides 303')
  assert(veq(r:tolist(),{true,false,false,true,true}),'signbit unary values 303')
end
do -- signbit unary 304
  local a=np.array({11.0,-2.25,0.5,1.0,0.0},np.float64)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 304')
  assert(seqeq(r.shape,{5}),'signbit unary shape 304')
  assert(seqeq(r.strides,{1}),'signbit unary strides 304')
  assert(veq(r:tolist(),{false,true,false,false,false}),'signbit unary values 304')
end
do -- signbit unary 305
  local a=np.array({true,false,false,false,false},np.bool)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 305')
  assert(seqeq(r.shape,{5}),'signbit unary shape 305')
  assert(seqeq(r.strides,{1}),'signbit unary strides 305')
  assert(veq(r:tolist(),{false,false,false,false,false}),'signbit unary values 305')
end
do -- signbit unary 306
  local a=np.array({-1,63,-127,0,9},np.int32)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 306')
  assert(seqeq(r.shape,{5}),'signbit unary shape 306')
  assert(seqeq(r.strides,{1}),'signbit unary strides 306')
  assert(veq(r:tolist(),{true,false,true,false,false}),'signbit unary values 306')
end
do -- signbit unary 307
  local a=np.array({{0,127,63},{63,0,63}},np.uint8)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 307')
  assert(seqeq(r.shape,{2,3}),'signbit unary shape 307')
  assert(seqeq(r.strides,{3,1}),'signbit unary strides 307')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'signbit unary values 307')
end
do -- signbit unary 308
  local a=np.array({-2.25,-9.5,3.75,-math.huge,math.huge},np.float16)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 308')
  assert(seqeq(r.shape,{5}),'signbit unary shape 308')
  assert(seqeq(r.strides,{1}),'signbit unary strides 308')
  assert(veq(r:tolist(),{true,true,false,true,false}),'signbit unary values 308')
end
do -- signbit unary 309
  local a=np.array({-2.25,-1.0,-9.5,-math.huge,-9.5},np.float16)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 309')
  assert(seqeq(r.shape,{5}),'signbit unary shape 309')
  assert(seqeq(r.strides,{1}),'signbit unary strides 309')
  assert(veq(r:tolist(),{true,true,true,true,true}),'signbit unary values 309')
end
do -- signbit unary 310
  local a=np.array({{17,0,17},{17,1,1}},np.uint32)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 310')
  assert(seqeq(r.shape,{2,3}),'signbit unary shape 310')
  assert(seqeq(r.strides,{3,1}),'signbit unary strides 310')
  assert(veq(r:tolist(),{{false,false,false},{false,false,false}}),'signbit unary values 310')
end
do -- signbit unary 311
  local a=np.array({9,-127,-7,-1,-127},np.int64)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 311')
  assert(seqeq(r.shape,{5}),'signbit unary shape 311')
  assert(seqeq(r.strides,{1}),'signbit unary strides 311')
  assert(veq(r:tolist(),{false,true,true,true,true}),'signbit unary values 311')
end
do -- signbit unary 312
  local a=np.array({0,5,1,127,17},np.uint64)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 312')
  assert(seqeq(r.shape,{5}),'signbit unary shape 312')
  assert(seqeq(r.strides,{1}),'signbit unary strides 312')
  assert(veq(r:tolist(),{false,false,false,false,false}),'signbit unary values 312')
end
do -- signbit unary 313
  local a=np.array({{-127,63,9},{-7,9,-7}},np.int16)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 313')
  assert(seqeq(r.shape,{2,3}),'signbit unary shape 313')
  assert(seqeq(r.strides,{3,1}),'signbit unary strides 313')
  assert(veq(r:tolist(),{{true,false,false},{true,false,true}}),'signbit unary values 313')
end
do -- signbit unary 314
  local a=np.array({{126,2,-31},{-31,-31,9}},np.int64)
  local r=np.signbit(a)
  assert(r.dtype=='bool','signbit unary dtype 314')
  assert(seqeq(r.shape,{2,3}),'signbit unary shape 314')
  assert(seqeq(r.strides,{3,1}),'signbit unary strides 314')
  assert(veq(r:tolist(),{{false,false,true},{true,true,false}}),'signbit unary values 314')
end
do -- absolute unary out 0
  local a=np.array({{251,0,251},{17,2,251}},np.uint32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint32)*3
  local r=np.absolute(a,{out=o,where=m})
  assert(r==o,'absolute unary out identity 0')
  assert(veq(o:tolist(),{{251,3,251},{3,2,3}}),'absolute unary out values 0')
end
do -- absolute unary out 1
  local a=np.array({{math.huge,-9.5,-math.huge},{math.huge,-2.25,3.75}},np.float16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float16)*3
  local r=np.absolute(a,{out=o,where=m})
  assert(r==o,'absolute unary out identity 1')
  assert(veq(o:tolist(),{{math.huge,3.0,math.huge},{3.0,2.25,3.0}}),'absolute unary out values 1')
end
do -- absolute unary out 2
  local a=np.array({{1,0,251},{5,251,17}},np.uint8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint8)*3
  local r=np.absolute(a,{out=o,where=m})
  assert(r==o,'absolute unary out identity 2')
  assert(veq(o:tolist(),{{1,3,251},{3,251,3}}),'absolute unary out values 2')
end
do -- absolute unary out 3
  local a=np.array({{0.5,-9.5,-math.huge},{(0/0),3.75,-2.25}},np.float64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*3
  local r=np.absolute(a,{out=o,where=m})
  assert(r==o,'absolute unary out identity 3')
  assert(veq(o:tolist(),{{0.5,3.0,math.huge},{3.0,3.75,3.0}}),'absolute unary out values 3')
end
do -- absolute unary out 4
  local a=np.array({{(0/0),3.75,3.75},{0.5,-math.huge,1.0}},np.float64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*3
  local r=np.absolute(a,{out=o,where=m})
  assert(r==o,'absolute unary out identity 4')
  assert(veq(o:tolist(),{{(0/0),3.0,3.75},{3.0,math.huge,3.0}}),'absolute unary out values 4')
end
do -- absolute unary out 5
  local a=np.array({{math.huge,(0/0),11.0},{-1.0,(0/0),-0.0}},np.float16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float16)*3
  local r=np.absolute(a,{out=o,where=m})
  assert(r==o,'absolute unary out identity 5')
  assert(veq(o:tolist(),{{math.huge,3.0,11.0},{3.0,(0/0),3.0}}),'absolute unary out values 5')
end
do -- absolute unary out 6
  local a=np.array({{126,-1,-31},{-1,126,2}},np.int64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int64)*3
  local r=np.absolute(a,{out=o,where=m})
  assert(r==o,'absolute unary out identity 6')
  assert(veq(o:tolist(),{{126,3,31},{3,126,3}}),'absolute unary out values 6')
end
do -- absolute unary out 7
  local a=np.array({{63,-1,-7},{0,63,-31}},np.int8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*3
  local r=np.absolute(a,{out=o,where=m})
  assert(r==o,'absolute unary out identity 7')
  assert(veq(o:tolist(),{{63,3,7},{3,63,3}}),'absolute unary out values 7')
end
do -- absolute unary out 8
  local a=np.array({{1,17,63},{2,2,2}},np.uint64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint64)*3
  local r=np.absolute(a,{out=o,where=m})
  assert(r==o,'absolute unary out identity 8')
  assert(veq(o:tolist(),{{1,3,63},{3,2,3}}),'absolute unary out values 8')
end
do -- absolute unary out 9
  local a=np.array({{126,-7,9},{-7,-127,2}},np.int64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int64)*3
  local r=np.absolute(a,{out=o,where=m})
  assert(r==o,'absolute unary out identity 9')
  assert(veq(o:tolist(),{{126,3,9},{3,127,3}}),'absolute unary out values 9')
end
do -- absolute unary out 10
  local a=np.array({{127,63,2},{0,1,5}},np.uint64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint64)*3
  local r=np.absolute(a,{out=o,where=m})
  assert(r==o,'absolute unary out identity 10')
  assert(veq(o:tolist(),{{127,3,2},{3,1,3}}),'absolute unary out values 10')
end
do -- absolute unary out 11
  local a=np.array({{0.0,-9.5,0.5},{-math.huge,1.0,-9.5}},np.float64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*3
  local r=np.absolute(a,{out=o,where=m})
  assert(r==o,'absolute unary out identity 11')
  assert(veq(o:tolist(),{{0.0,3.0,0.5},{3.0,1.0,3.0}}),'absolute unary out values 11')
end
do -- absolute unary out 12
  local a=np.array({{0,0,0},{-7,1,63}},np.int64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int64)*3
  local r=np.absolute(a,{out=o,where=m})
  assert(r==o,'absolute unary out identity 12')
  assert(veq(o:tolist(),{{0,3,0},{3,1,3}}),'absolute unary out values 12')
end
do -- absolute unary out 13
  local a=np.array({{false,false,false},{false,false,false}},np.bool)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.absolute(a,{out=o,where=m})
  assert(r==o,'absolute unary out identity 13')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'absolute unary out values 13')
end
do -- absolute unary out 14
  local a=np.array({{0.0,-1.0,11.0},{3.75,-0.0,-9.5}},np.float32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float32)*3
  local r=np.absolute(a,{out=o,where=m})
  assert(r==o,'absolute unary out identity 14')
  assert(veq(o:tolist(),{{0.0,3.0,11.0},{3.0,0.0,3.0}}),'absolute unary out values 14')
end
do -- absolute unary out 15
  local a=np.array({{1.0,-9.5,-9.5},{-math.huge,(0/0),-9.5}},np.float64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*3
  local r=np.absolute(a,{out=o,where=m})
  assert(r==o,'absolute unary out identity 15')
  assert(veq(o:tolist(),{{1.0,3.0,9.5},{3.0,(0/0),3.0}}),'absolute unary out values 15')
end
do -- absolute unary out 16
  local a=np.array({{2,5,17},{127,251,17}},np.uint8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint8)*3
  local r=np.absolute(a,{out=o,where=m})
  assert(r==o,'absolute unary out identity 16')
  assert(veq(o:tolist(),{{2,3,17},{3,251,3}}),'absolute unary out values 16')
end
do -- absolute unary out 17
  local a=np.array({{-2.25,0.0,-math.huge},{0.0,-1.0,0.5}},np.float32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float32)*3
  local r=np.absolute(a,{out=o,where=m})
  assert(r==o,'absolute unary out identity 17')
  assert(veq(o:tolist(),{{2.25,3.0,math.huge},{3.0,1.0,3.0}}),'absolute unary out values 17')
end
do -- absolute unary out 18
  local a=np.array({{0,0,63},{1,63,-31}},np.int64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int64)*3
  local r=np.absolute(a,{out=o,where=m})
  assert(r==o,'absolute unary out identity 18')
  assert(veq(o:tolist(),{{0,3,63},{3,63,3}}),'absolute unary out values 18')
end
do -- absolute unary out 19
  local a=np.array({{-1,63,63},{-7,126,0}},np.int64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int64)*3
  local r=np.absolute(a,{out=o,where=m})
  assert(r==o,'absolute unary out identity 19')
  assert(veq(o:tolist(),{{1,3,63},{3,126,3}}),'absolute unary out values 19')
end
do -- logical_not unary out 20
  local a=np.array({{-127,0,1},{2,0,2}},np.int64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_not(a,{out=o,where=m})
  assert(r==o,'logical_not unary out identity 20')
  assert(veq(o:tolist(),{{false,true,false},{true,true,true}}),'logical_not unary out values 20')
end
do -- logical_not unary out 21
  local a=np.array({{0.5,11.0,math.huge},{-0.0,-2.25,-0.0}},np.float64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_not(a,{out=o,where=m})
  assert(r==o,'logical_not unary out identity 21')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'logical_not unary out values 21')
end
do -- logical_not unary out 22
  local a=np.array({{127,5,17},{17,17,5}},np.uint32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_not(a,{out=o,where=m})
  assert(r==o,'logical_not unary out identity 22')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'logical_not unary out values 22')
end
do -- logical_not unary out 23
  local a=np.array({{0.0,(0/0),-math.huge},{0.5,0.5,-0.0}},np.float32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_not(a,{out=o,where=m})
  assert(r==o,'logical_not unary out identity 23')
  assert(veq(o:tolist(),{{true,true,false},{true,false,true}}),'logical_not unary out values 23')
end
do -- logical_not unary out 24
  local a=np.array({{126,2,126},{-31,63,-1}},np.int8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_not(a,{out=o,where=m})
  assert(r==o,'logical_not unary out identity 24')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'logical_not unary out values 24')
end
do -- logical_not unary out 25
  local a=np.array({{-9.5,math.huge,-math.huge},{0.5,1.0,0.5}},np.float16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_not(a,{out=o,where=m})
  assert(r==o,'logical_not unary out identity 25')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'logical_not unary out values 25')
end
do -- logical_not unary out 26
  local a=np.array({{1.0,-1.0,math.huge},{3.75,-0.0,-math.huge}},np.float64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_not(a,{out=o,where=m})
  assert(r==o,'logical_not unary out identity 26')
  assert(veq(o:tolist(),{{false,true,false},{true,true,true}}),'logical_not unary out values 26')
end
do -- logical_not unary out 27
  local a=np.array({{127,63,63},{2,1,251}},np.uint32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_not(a,{out=o,where=m})
  assert(r==o,'logical_not unary out identity 27')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'logical_not unary out values 27')
end
do -- logical_not unary out 28
  local a=np.array({{9,-7,2},{1,126,0}},np.int8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_not(a,{out=o,where=m})
  assert(r==o,'logical_not unary out identity 28')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'logical_not unary out values 28')
end
do -- logical_not unary out 29
  local a=np.array({{-math.huge,0.0,-math.huge},{11.0,(0/0),-9.5}},np.float32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_not(a,{out=o,where=m})
  assert(r==o,'logical_not unary out identity 29')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'logical_not unary out values 29')
end
do -- logical_not unary out 30
  local a=np.array({{true,true,false},{false,false,true}},np.bool)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_not(a,{out=o,where=m})
  assert(r==o,'logical_not unary out identity 30')
  assert(veq(o:tolist(),{{false,true,true},{true,true,true}}),'logical_not unary out values 30')
end
do -- logical_not unary out 31
  local a=np.array({{-math.huge,-2.25,1.0},{-0.0,1.0,(0/0)}},np.float32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_not(a,{out=o,where=m})
  assert(r==o,'logical_not unary out identity 31')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'logical_not unary out values 31')
end
do -- logical_not unary out 32
  local a=np.array({{63,-1,-1},{126,9,-31}},np.int16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_not(a,{out=o,where=m})
  assert(r==o,'logical_not unary out identity 32')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'logical_not unary out values 32')
end
do -- logical_not unary out 33
  local a=np.array({{63,-7,63},{-31,126,0}},np.int64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_not(a,{out=o,where=m})
  assert(r==o,'logical_not unary out identity 33')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'logical_not unary out values 33')
end
do -- logical_not unary out 34
  local a=np.array({{17,17,2},{251,63,2}},np.uint8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_not(a,{out=o,where=m})
  assert(r==o,'logical_not unary out identity 34')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'logical_not unary out values 34')
end
do -- logical_not unary out 35
  local a=np.array({{0,1,251},{2,5,251}},np.uint16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_not(a,{out=o,where=m})
  assert(r==o,'logical_not unary out identity 35')
  assert(veq(o:tolist(),{{true,true,false},{true,false,true}}),'logical_not unary out values 35')
end
do -- logical_not unary out 36
  local a=np.array({{127,127,2},{63,1,127}},np.uint16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_not(a,{out=o,where=m})
  assert(r==o,'logical_not unary out identity 36')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'logical_not unary out values 36')
end
do -- logical_not unary out 37
  local a=np.array({{1,127,63},{63,2,17}},np.uint32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_not(a,{out=o,where=m})
  assert(r==o,'logical_not unary out identity 37')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'logical_not unary out values 37')
end
do -- logical_not unary out 38
  local a=np.array({{true,true,false},{false,false,false}},np.bool)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_not(a,{out=o,where=m})
  assert(r==o,'logical_not unary out identity 38')
  assert(veq(o:tolist(),{{false,true,true},{true,true,true}}),'logical_not unary out values 38')
end
do -- logical_not unary out 39
  local a=np.array({{9,-31,1},{2,63,9}},np.int64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.logical_not(a,{out=o,where=m})
  assert(r==o,'logical_not unary out identity 39')
  assert(veq(o:tolist(),{{false,true,false},{true,false,true}}),'logical_not unary out values 39')
end
do -- isfinite unary out 40
  local a=np.array({{5,2,63},{5,5,2}},np.uint8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.isfinite(a,{out=o,where=m})
  assert(r==o,'isfinite unary out identity 40')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary out values 40')
end
do -- isfinite unary out 41
  local a=np.array({{1.0,0.0,-0.0},{0.5,-9.5,-0.0}},np.float16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.isfinite(a,{out=o,where=m})
  assert(r==o,'isfinite unary out identity 41')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary out values 41')
end
do -- isfinite unary out 42
  local a=np.array({{9,1,2},{2,126,-1}},np.int32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.isfinite(a,{out=o,where=m})
  assert(r==o,'isfinite unary out identity 42')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary out values 42')
end
do -- isfinite unary out 43
  local a=np.array({{1,251,2},{127,5,1}},np.uint32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.isfinite(a,{out=o,where=m})
  assert(r==o,'isfinite unary out identity 43')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary out values 43')
end
do -- isfinite unary out 44
  local a=np.array({{63,2,5},{2,1,63}},np.uint32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.isfinite(a,{out=o,where=m})
  assert(r==o,'isfinite unary out identity 44')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary out values 44')
end
do -- isfinite unary out 45
  local a=np.array({{1.0,3.75,-0.0},{-0.0,-0.0,-math.huge}},np.float64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.isfinite(a,{out=o,where=m})
  assert(r==o,'isfinite unary out identity 45')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary out values 45')
end
do -- isfinite unary out 46
  local a=np.array({{-9.5,-math.huge,1.0},{11.0,math.huge,-1.0}},np.float16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.isfinite(a,{out=o,where=m})
  assert(r==o,'isfinite unary out identity 46')
  assert(veq(o:tolist(),{{true,true,true},{true,false,true}}),'isfinite unary out values 46')
end
do -- isfinite unary out 47
  local a=np.array({{63,1,63},{5,0,17}},np.uint16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.isfinite(a,{out=o,where=m})
  assert(r==o,'isfinite unary out identity 47')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary out values 47')
end
do -- isfinite unary out 48
  local a=np.array({{0,251,1},{1,0,127}},np.uint32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.isfinite(a,{out=o,where=m})
  assert(r==o,'isfinite unary out identity 48')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary out values 48')
end
do -- isfinite unary out 49
  local a=np.array({{false,false,true},{true,true,true}},np.bool)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.isfinite(a,{out=o,where=m})
  assert(r==o,'isfinite unary out identity 49')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary out values 49')
end
do -- isfinite unary out 50
  local a=np.array({{(0/0),(0/0),1.0},{(0/0),3.75,1.0}},np.float64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.isfinite(a,{out=o,where=m})
  assert(r==o,'isfinite unary out identity 50')
  assert(veq(o:tolist(),{{false,true,true},{true,true,true}}),'isfinite unary out values 50')
end
do -- isfinite unary out 51
  local a=np.array({{11.0,0.5,-9.5},{0.0,(0/0),-0.0}},np.float64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.isfinite(a,{out=o,where=m})
  assert(r==o,'isfinite unary out identity 51')
  assert(veq(o:tolist(),{{true,true,true},{true,false,true}}),'isfinite unary out values 51')
end
do -- isfinite unary out 52
  local a=np.array({{2,251,63},{5,2,1}},np.uint32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.isfinite(a,{out=o,where=m})
  assert(r==o,'isfinite unary out identity 52')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary out values 52')
end
do -- isfinite unary out 53
  local a=np.array({{2,63,127},{251,63,127}},np.uint16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.isfinite(a,{out=o,where=m})
  assert(r==o,'isfinite unary out identity 53')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary out values 53')
end
do -- isfinite unary out 54
  local a=np.array({{63,5,63},{1,63,2}},np.uint64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.isfinite(a,{out=o,where=m})
  assert(r==o,'isfinite unary out identity 54')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary out values 54')
end
do -- isfinite unary out 55
  local a=np.array({{2,0,-7},{9,-127,9}},np.int8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.isfinite(a,{out=o,where=m})
  assert(r==o,'isfinite unary out identity 55')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary out values 55')
end
do -- isfinite unary out 56
  local a=np.array({{-31,-1,0},{63,126,63}},np.int8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.isfinite(a,{out=o,where=m})
  assert(r==o,'isfinite unary out identity 56')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary out values 56')
end
do -- isfinite unary out 57
  local a=np.array({{5,2,2},{17,251,0}},np.uint64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.isfinite(a,{out=o,where=m})
  assert(r==o,'isfinite unary out identity 57')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary out values 57')
end
do -- isfinite unary out 58
  local a=np.array({{126,126,-1},{63,126,-7}},np.int32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.isfinite(a,{out=o,where=m})
  assert(r==o,'isfinite unary out identity 58')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary out values 58')
end
do -- isfinite unary out 59
  local a=np.array({{-1,-31,1},{-1,-127,126}},np.int16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.bool)
  local r=np.isfinite(a,{out=o,where=m})
  assert(r==o,'isfinite unary out identity 59')
  assert(veq(o:tolist(),{{true,true,true},{true,true,true}}),'isfinite unary out values 59')
end
do -- negative unary out 60
  local a=np.array({{0,251,0},{63,5,2}},np.uint16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint16)*3
  local r=np.negative(a,{out=o,where=m})
  assert(r==o,'negative unary out identity 60')
  assert(veq(o:tolist(),{{0,3,0},{3,65531,3}}),'negative unary out values 60')
end
do -- negative unary out 61
  local a=np.array({{5,5,5},{251,5,0}},np.uint64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint64)*3
  local r=np.negative(a,{out=o,where=m})
  assert(r==o,'negative unary out identity 61')
  assert(veq(o:tolist(),{{18446744073709551611,3,18446744073709551611},{3,18446744073709551611,3}}),'negative unary out values 61')
end
do -- negative unary out 62
  local a=np.array({{17,17,17},{2,251,17}},np.uint16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint16)*3
  local r=np.negative(a,{out=o,where=m})
  assert(r==o,'negative unary out identity 62')
  assert(veq(o:tolist(),{{65519,3,65519},{3,65285,3}}),'negative unary out values 62')
end
do -- negative unary out 63
  local a=np.array({{63,-1,9},{-127,-7,9}},np.int32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int32)*3
  local r=np.negative(a,{out=o,where=m})
  assert(r==o,'negative unary out identity 63')
  assert(veq(o:tolist(),{{-63,3,-9},{3,7,3}}),'negative unary out values 63')
end
do -- negative unary out 64
  local a=np.array({{-7,126,0},{0,2,0}},np.int64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int64)*3
  local r=np.negative(a,{out=o,where=m})
  assert(r==o,'negative unary out identity 64')
  assert(veq(o:tolist(),{{7,3,0},{3,-2,3}}),'negative unary out values 64')
end
do -- negative unary out 65
  local a=np.array({{-0.0,0.5,-2.25},{1.0,math.huge,(0/0)}},np.float64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*3
  local r=np.negative(a,{out=o,where=m})
  assert(r==o,'negative unary out identity 65')
  assert(veq(o:tolist(),{{0.0,3.0,2.25},{3.0,-math.huge,3.0}}),'negative unary out values 65')
end
do -- negative unary out 66
  local a=np.array({{9,63,-127},{-7,-7,-127}},np.int8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*3
  local r=np.negative(a,{out=o,where=m})
  assert(r==o,'negative unary out identity 66')
  assert(veq(o:tolist(),{{-9,3,127},{3,7,3}}),'negative unary out values 66')
end
do -- negative unary out 67
  local a=np.array({{126,9,0},{-127,-127,-127}},np.int32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int32)*3
  local r=np.negative(a,{out=o,where=m})
  assert(r==o,'negative unary out identity 67')
  assert(veq(o:tolist(),{{-126,3,0},{3,127,3}}),'negative unary out values 67')
end
do -- negative unary out 68
  local a=np.array({{126,2,0},{0,2,-7}},np.int8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*3
  local r=np.negative(a,{out=o,where=m})
  assert(r==o,'negative unary out identity 68')
  assert(veq(o:tolist(),{{-126,3,0},{3,-2,3}}),'negative unary out values 68')
end
do -- negative unary out 69
  local a=np.array({{5,0,5},{63,5,5}},np.uint8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint8)*3
  local r=np.negative(a,{out=o,where=m})
  assert(r==o,'negative unary out identity 69')
  assert(veq(o:tolist(),{{251,3,251},{3,251,3}}),'negative unary out values 69')
end
do -- negative unary out 70
  local a=np.array({{2,-1,63},{126,0,-31}},np.int8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int8)*3
  local r=np.negative(a,{out=o,where=m})
  assert(r==o,'negative unary out identity 70')
  assert(veq(o:tolist(),{{-2,3,-63},{3,0,3}}),'negative unary out values 70')
end
do -- negative unary out 71
  local a=np.array({{127,1,2},{0,127,251}},np.uint16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint16)*3
  local r=np.negative(a,{out=o,where=m})
  assert(r==o,'negative unary out identity 71')
  assert(veq(o:tolist(),{{65409,3,65534},{3,65409,3}}),'negative unary out values 71')
end
do -- negative unary out 72
  local a=np.array({{1,63,1},{-7,-127,-7}},np.int64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int64)*3
  local r=np.negative(a,{out=o,where=m})
  assert(r==o,'negative unary out identity 72')
  assert(veq(o:tolist(),{{-1,3,-1},{3,127,3}}),'negative unary out values 72')
end
do -- negative unary out 73
  local a=np.array({{-7,1,63},{126,-1,63}},np.int64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int64)*3
  local r=np.negative(a,{out=o,where=m})
  assert(r==o,'negative unary out identity 73')
  assert(veq(o:tolist(),{{7,3,-63},{3,1,3}}),'negative unary out values 73')
end
do -- negative unary out 74
  local a=np.array({{1,0,-31},{-127,9,-7}},np.int32)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.int32)*3
  local r=np.negative(a,{out=o,where=m})
  assert(r==o,'negative unary out identity 74')
  assert(veq(o:tolist(),{{-1,3,31},{3,-9,3}}),'negative unary out values 74')
end
do -- negative unary out 75
  local a=np.array({{1,127,63},{127,251,17}},np.uint16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint16)*3
  local r=np.negative(a,{out=o,where=m})
  assert(r==o,'negative unary out identity 75')
  assert(veq(o:tolist(),{{65535,3,65473},{3,65285,3}}),'negative unary out values 75')
end
do -- negative unary out 76
  local a=np.array({{17,63,0},{1,2,251}},np.uint8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint8)*3
  local r=np.negative(a,{out=o,where=m})
  assert(r==o,'negative unary out identity 76')
  assert(veq(o:tolist(),{{239,3,0},{3,254,3}}),'negative unary out values 76')
end
do -- negative unary out 77
  local a=np.array({{0.5,-1.0,0.0},{0.0,-2.25,-2.25}},np.float16)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float16)*3
  local r=np.negative(a,{out=o,where=m})
  assert(r==o,'negative unary out identity 77')
  assert(veq(o:tolist(),{{-0.5,3.0,-0.0},{3.0,2.25,3.0}}),'negative unary out values 77')
end
do -- negative unary out 78
  local a=np.array({{2,1,5},{251,63,63}},np.uint8)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.uint8)*3
  local r=np.negative(a,{out=o,where=m})
  assert(r==o,'negative unary out identity 78')
  assert(veq(o:tolist(),{{254,3,251},{3,193,3}}),'negative unary out values 78')
end
do -- negative unary out 79
  local a=np.array({{-9.5,-2.25,11.0},{-9.5,-math.huge,11.0}},np.float64)
  local m=np.array({{true,false,true},{false,true,false}},np.bool)
  local o=np.ones({2,3},np.float64)*3
  local r=np.negative(a,{out=o,where=m})
  assert(r==o,'negative unary out identity 79')
  assert(veq(o:tolist(),{{9.5,3.0,-11.0},{3.0,math.huge,3.0}}),'negative unary out values 79')
end

do
  local a=np.array({9007199254740993},np.int64)
  local b=np.array({9007199254740992},np.uint64)
  assert(np.equal(a,b)[1]==false,'int64/uint64 comparison must not lose precision')
  assert(np.greater(a,b)[1]==true,'int64/uint64 exact ordering')
end

do
  local b=np.array({false,true},np.bool)
  local ok,e=pcall(function() return np.negative(b) end)
  assert(not ok and tostring(e):find('boolean negative',1,true),'bool negative error')
  assert(veq(np.absolute(b):tolist(),{false,true}),'bool absolute identity')
  assert(veq(np.logical_not(b):tolist(),{true,false}),'bool logical_not')
end

print('catalog ufunc differential: 1382 cases ok')
