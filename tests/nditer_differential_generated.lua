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
  local scale=math.max(1,math.abs(a),math.abs(b))
  return math.abs(a-b)<=3e-6*scale
end

do -- auto-layout 0
  local a=(np.array({{true,false,false,true},{false,true,true,false},{false,true,true,true}},np.bool)).T
  local b=(np.array({{0,2,4,4},{4,-9,-9,1},{-4,4,-4,1}},np.int64)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','auto 0 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3}),'auto 0 shape')
  assert(seqeq(r.strides,{8,32}),'auto 0 strides')
  assert(veq(r:tolist(),{{1,-4,4},{-2,10,-3},{-4,10,5},{-3,-1,0}}),'auto 0 values')
end
do -- auto-layout 1
  local a=np.array({{false,true,false,false},{true,false,false,true},{false,true,false,false}},np.bool)
  local b=np.array({{-4,0,0,1},{-4,1,-9,-1},{-1,4,0,0}},np.int8)
  local r=np.add(a,b)
  assert(r.dtype=='int8','auto 1 dtype '..r.dtype)
  assert(seqeq(r.shape,{3,4}),'auto 1 shape')
  assert(seqeq(r.strides,{4,1}),'auto 1 strides')
  assert(veq(r:tolist(),{{-4,1,0,1},{-3,1,-9,0},{-1,5,0,0}}),'auto 1 values')
end
do -- auto-layout 2
  local a=(np.array({{false,false,false},{true,false,true}},np.bool)).T
  local b=(np.array({{-2,0,-1},{-2,2,2}},np.int64)).T
  local r=np.add(a,b)
  assert(r.dtype=='int64','auto 2 dtype '..r.dtype)
  assert(seqeq(r.shape,{3,2}),'auto 2 shape')
  assert(seqeq(r.strides,{8,24}),'auto 2 strides')
  assert(veq(r:tolist(),{{-2,-1},{0,2},{-1,3}}),'auto 2 values')
end
do -- auto-layout 3
  local a=(np.array({{-5.5,-0.5,3.75,-0.5},{-2.25,-5.5,-5.5,1.5},{0.25,-5.5,-2.25,1.5}},np.float32)).T
  local b=(np.array({{1.5,3.75,-2.25,3.75},{-0.5,0.25,0.25,-5.5},{-2.25,-2.25,-2.25,-2.25}},np.float32)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='float32','auto 3 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3}),'auto 3 shape')
  assert(seqeq(r.strides,{4,16}),'auto 3 strides')
  assert(veq(r:tolist(),{{-7.0,-1.75,2.5},{-4.25,-5.75,-3.25},{6.0,-5.75,0.0},{-4.25,7.0,3.75}}),'auto 3 values')
end
do -- auto-layout 4
  local a=(np.array({{20,19,7,4},{5,12,10,9},{4,2,9,14}},np.uint16)).T
  local b=(np.array({{-5.5,-2.25,-0.5,-2.25},{1.5,-5.5,1.5,-2.25},{3.75,0.25,0.25,-0.5}},np.float32)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='float32','auto 4 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3}),'auto 4 shape')
  assert(seqeq(r.strides,{4,16}),'auto 4 strides')
  assert(veq(r:tolist(),{{25.5,3.5,0.25},{21.25,17.5,1.75},{7.5,8.5,8.75},{6.25,11.25,14.5}}),'auto 4 values')
end
do -- auto-layout 5
  local a=np.array({{{-0.5,0.25,3.75,1.5},{3.75,1.5,0.25,0.25},{-5.5,-0.5,0.25,0.25}},{{-0.5,0.25,1.5,-5.5},{1.5,-5.5,-2.25,3.75},{-0.5,-0.5,-0.5,-0.5}}},np.float32)
  local b=(np.array({{{3.75,-2.25},{1.5,0.25},{0.25,-0.5}},{{-2.25,-2.25},{-5.5,1.5},{-2.25,-5.5}},{{3.75,-2.25},{-2.25,0.25},{-5.5,-5.5}},{{1.5,-5.5},{-2.25,3.75},{0.25,-5.5}}},np.float64)).T
  local r=np.multiply(a,b)
  assert(r.dtype=='float64','auto 5 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'auto 5 shape')
  assert(seqeq(r.strides,{96,32,8}),'auto 5 strides')
  assert(veq(r:tolist(),{{{-1.875,-0.5625,14.0625,2.25},{5.625,-8.25,-0.5625,-0.5625},{-1.375,1.125,-1.375,0.0625}},{{1.125,-0.5625,-3.375,30.25},{0.375,-8.25,-0.5625,14.0625},{0.25,2.75,2.75,2.75}}}),'auto 5 values')
end
do -- auto-layout 6
  local a=np.array({{1.5,-2.25,-2.25,-5.5},{-5.5,3.75,-2.25,-0.5},{3.75,0.25,1.5,-5.5}},np.float32)
  local b=(np.array({{false,false,false},{false,true,true},{false,true,false},{true,true,true}},np.bool)).T
  local r=np.multiply(a,b)
  assert(r.dtype=='float32','auto 6 dtype '..r.dtype)
  assert(seqeq(r.shape,{3,4}),'auto 6 shape')
  assert(seqeq(r.strides,{16,4}),'auto 6 strides')
  assert(veq(r:tolist(),{{0.0,-0.0,-0.0,-5.5},{-0.0,3.75,-2.25,-0.5},{0.0,0.25,0.0,-5.5}}),'auto 6 values')
end
do -- auto-layout 7
  local a=(np.array({{-4,4,-4},{-2,-1,1}},np.int64)).T
  local b=(np.array({{5,14,2},{10,18,12}},np.uint32)).T
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','auto 7 dtype '..r.dtype)
  assert(seqeq(r.shape,{3,2}),'auto 7 shape')
  assert(seqeq(r.strides,{8,24}),'auto 7 strides')
  assert(veq(r:tolist(),{{-0.8,-0.2},{0.2857142857142857,-0.05555555555555555},{-2.0,0.08333333333333333}}),'auto 7 values')
end
do -- auto-layout 8
  local a=(np.array({{4,-2,0},{-4,2,1}},np.int16)).T
  local b=(np.array({{16,3,16},{2,0,15}},np.uint64)).T
  local r=np.multiply(a,b)
  assert(r.dtype=='float64','auto 8 dtype '..r.dtype)
  assert(seqeq(r.shape,{3,2}),'auto 8 shape')
  assert(seqeq(r.strides,{8,24}),'auto 8 strides')
  assert(veq(r:tolist(),{{64.0,-8.0},{-6.0,0.0},{0.0,15.0}}),'auto 8 values')
end
do -- auto-layout 9
  local a=np.array({{15,4,6},{6,6,13}},np.uint8)
  local b=(np.array({{-4,-1},{9,-1},{-2,4}},np.int16)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='int16','auto 9 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'auto 9 shape')
  assert(seqeq(r.strides,{6,2}),'auto 9 strides')
  assert(veq(r:tolist(),{{19,-5,8},{7,7,9}}),'auto 9 values')
end
do -- auto-layout 10
  local a=(np.array({{2,0,2},{-4,-4,-2}},np.int8)).T
  local b=(np.array({{-1,-9,1},{-2,9,1}},np.int32)).T
  local r=np.multiply(a,b)
  assert(r.dtype=='int32','auto 10 dtype '..r.dtype)
  assert(seqeq(r.shape,{3,2}),'auto 10 shape')
  assert(seqeq(r.strides,{4,12}),'auto 10 strides')
  assert(veq(r:tolist(),{{-2,8},{0,-36},{2,-2}}),'auto 10 values')
end
do -- auto-layout 11
  local a=(np.array({{16,2,4,11},{7,1,8,17},{14,0,4,19}},np.uint8)).T
  local b=(np.array({{-9,0,-4,9},{-1,4,9,0},{-9,-4,9,-9}},np.int16)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='int16','auto 11 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3}),'auto 11 shape')
  assert(seqeq(r.strides,{2,8}),'auto 11 strides')
  assert(veq(r:tolist(),{{25,8,23},{2,-3,4},{8,-1,-5},{2,17,28}}),'auto 11 values')
end
do -- auto-layout 12
  local a=(np.array({{-5.5,0.25,-5.5},{0.25,0.25,-0.5}},np.float16)).T
  local b=(np.array({{-2.25,-5.5,0.25},{0.25,1.5,1.5}},np.float32)).T
  local r=np.add(a,b)
  assert(r.dtype=='float32','auto 12 dtype '..r.dtype)
  assert(seqeq(r.shape,{3,2}),'auto 12 shape')
  assert(seqeq(r.strides,{4,12}),'auto 12 strides')
  assert(veq(r:tolist(),{{-7.75,0.5},{-5.25,1.75},{-5.25,1.0}}),'auto 12 values')
end
do -- auto-layout 13
  local a=(np.array({{true,true,false,true},{false,true,false,false},{true,false,false,false}},np.bool)).T
  local b=(np.array({{19,17,17,1},{3,18,2,15},{15,13,1,13}},np.uint8)).T
  local r=np.add(a,b)
  assert(r.dtype=='uint8','auto 13 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3}),'auto 13 shape')
  assert(seqeq(r.strides,{1,4}),'auto 13 strides')
  assert(veq(r:tolist(),{{20,3,16},{18,19,13},{17,2,1},{2,15,13}}),'auto 13 values')
end
do -- auto-layout 14
  local a=(np.array({{6,7,14,10},{8,7,11,2},{3,19,10,1}},np.uint64)).T
  local b=(np.array({{-0.5,-2.25,-2.25,-0.5},{1.5,0.25,-2.25,-2.25},{1.5,0.25,0.25,0.25}},np.float16)).T
  local r=np.multiply(a,b)
  assert(r.dtype=='float64','auto 14 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3}),'auto 14 shape')
  assert(seqeq(r.strides,{8,32}),'auto 14 strides')
  assert(veq(r:tolist(),{{-3.0,12.0,4.5},{-15.75,1.75,4.75},{-31.5,-24.75,2.5},{-5.0,-4.5,0.25}}),'auto 14 values')
end
do -- auto-layout 15
  local a=(np.array({{false,true,false,true},{true,false,false,false},{true,false,false,false}},np.bool)).T
  local b=(np.array({{16,19,7,8},{3,18,15,19},{8,15,18,4}},np.uint8)).T
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','auto 15 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3}),'auto 15 shape')
  assert(seqeq(r.strides,{8,32}),'auto 15 strides')
  assert(veq(r:tolist(),{{0.0,0.3333333333333333,0.125},{0.05263157894736842,0.0,0.0},{0.0,0.0,0.0},{0.125,0.0,0.0}}),'auto 15 values')
end
do -- auto-layout 16
  local a=(np.array({{{18,19,4,17},{5,5,17,20},{16,11,16,8}},{{11,12,4,17},{13,17,0,15},{13,14,8,5}}},np.uint16)).T
  local b=(np.array({{{0.25,-2.25,-2.25,-0.5},{-2.25,1.5,-0.5,-5.5},{1.5,0.25,1.5,-5.5}},{{3.75,0.25,1.5,0.25},{0.25,0.25,-0.5,1.5},{0.25,-5.5,0.25,-2.25}}},np.float16)).T
  local r=np.add(a,b)
  assert(r.dtype=='float32','auto 16 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3,2}),'auto 16 shape')
  assert(seqeq(r.strides,{4,16,48}),'auto 16 strides')
  assert(veq(r:tolist(),{{{18.25,14.75},{2.75,13.25},{17.5,13.25}},{{16.75,12.25},{6.5,17.25},{11.25,8.5}},{{1.75,5.5},{16.5,-0.5},{17.5,8.25}},{{16.5,17.25},{14.5,16.5},{2.5,2.75}}}),'auto 16 values')
end
do -- auto-layout 17
  local a=np.array({{4,2,2},{0,-1,-9}},np.int64)
  local b=(np.array({{true,true},{true,true},{true,true}},np.bool)).T
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','auto 17 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'auto 17 shape')
  assert(seqeq(r.strides,{24,8}),'auto 17 strides')
  assert(veq(r:tolist(),{{4.0,2.0,2.0},{0.0,-1.0,-9.0}}),'auto 17 values')
end
do -- auto-layout 18
  local a=np.array({{{true,false,false,false},{false,false,true,false},{false,true,false,true}},{{false,false,false,false},{false,true,false,false},{true,false,true,true}}},np.bool)
  local b=np.array({{{12,4,8,16},{8,19,11,6},{16,11,5,9}},{{7,2,11,10},{20,12,7,10},{16,1,20,3}}},np.uint64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','auto 18 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'auto 18 shape')
  assert(seqeq(r.strides,{96,32,8}),'auto 18 strides')
  assert(veq(r:tolist(),{{{0.08333333333333333,0.0,0.0,0.0},{0.0,0.0,0.09090909090909091,0.0},{0.0,0.09090909090909091,0.0,0.1111111111111111}},{{0.0,0.0,0.0,0.0},{0.0,0.08333333333333333,0.0,0.0},{0.0625,0.0,0.05,0.3333333333333333}}}),'auto 18 values')
end
do -- auto-layout 19
  local a=(np.array({{{-2.25,1.5,-5.5,-5.5},{3.75,3.75,-2.25,-5.5},{1.5,0.25,0.25,-5.5}},{{1.5,0.25,-2.25,0.25},{-2.25,-0.5,-2.25,0.25},{3.75,0.25,0.25,0.25}}},np.float32)).T
  local b=(np.array({{{-4,-1,-1,9},{-2,1,-9,2},{-9,-2,-2,-9}},{{1,-4,9,-2},{-2,-1,-1,2},{-4,-4,4,-4}}},np.int8)).T
  local r=np.true_divide(a,b)
  assert(r.dtype=='float32','auto 19 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3,2}),'auto 19 shape')
  assert(seqeq(r.strides,{4,16,48}),'auto 19 strides')
  assert(veq(r:tolist(),{{{0.5625,1.5},{-1.875,1.125},{-0.1666666716337204,-0.9375}},{{-1.5,-0.0625},{3.75,0.5},{-0.125,-0.0625}},{{5.5,-0.25},{0.25,2.25},{-0.125,0.0625}},{{-0.6111111044883728,-0.125},{-2.75,0.125},{0.6111111044883728,-0.0625}}}),'auto 19 values')
end
do -- auto-layout 20
  local a=(np.array({{{1,7,3,6},{8,3,6,7},{14,15,12,6}},{{3,15,16,16},{17,13,7,14},{20,4,1,14}}},np.uint32)).T
  local b=(np.array({{{9,0,18,12},{16,18,3,13},{1,20,20,19}},{{15,19,8,17},{10,9,3,14},{11,17,19,16}}},np.uint16)).T
  local r=np.add(a,b)
  assert(r.dtype=='uint32','auto 20 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3,2}),'auto 20 shape')
  assert(seqeq(r.strides,{4,16,48}),'auto 20 strides')
  assert(veq(r:tolist(),{{{10,18},{24,27},{15,31}},{{7,34},{21,22},{35,21}},{{21,24},{9,10},{32,20}},{{18,33},{20,28},{25,30}}}),'auto 20 values')
end
do -- auto-layout 21
  local a=np.array({{-0.5,-5.5,-0.5},{3.75,-0.5,1.5}},np.float64)
  local b=(np.array({{-0.5,0.25},{3.75,-5.5},{-0.5,-2.25}},np.float32)).T
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','auto 21 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'auto 21 shape')
  assert(seqeq(r.strides,{24,8}),'auto 21 strides')
  assert(veq(r:tolist(),{{1.0,-1.4666666666666666,1.0},{15.0,0.09090909090909091,-0.6666666666666666}}),'auto 21 values')
end
do -- auto-layout 22
  local a=(np.array({{8,2,17},{11,12,2}},np.uint32)).T
  local b=(np.array({{7,10,2},{15,1,5}},np.uint64)).T
  local r=np.add(a,b)
  assert(r.dtype=='uint64','auto 22 dtype '..r.dtype)
  assert(seqeq(r.shape,{3,2}),'auto 22 shape')
  assert(seqeq(r.strides,{8,24}),'auto 22 strides')
  assert(veq(r:tolist(),{{15,26},{12,13},{19,7}}),'auto 22 values')
end
do -- auto-layout 23
  local a=np.array({{12,5,9,19},{14,2,11,16},{20,11,11,10}},np.uint8)
  local b=(np.array({{1.5,-2.25,-2.25},{-2.25,-2.25,-5.5},{3.75,-5.5,-0.5},{3.75,1.5,-0.5}},np.float16)).T
  local r=np.multiply(a,b)
  assert(r.dtype=='float16','auto 23 dtype '..r.dtype)
  assert(seqeq(r.shape,{3,4}),'auto 23 shape')
  assert(seqeq(r.strides,{8,2}),'auto 23 strides')
  assert(veq(r:tolist(),{{18.0,-11.25,33.75,71.25},{-31.5,-4.5,-60.5,24.0},{-45.0,-60.5,-5.5,-5.0}}),'auto 23 values')
end
do -- auto-layout 24
  local a=np.array({{{-0.5,1.5,-5.5,-0.5},{1.5,-5.5,3.75,1.5},{-0.5,0.25,-5.5,3.75}},{{-0.5,3.75,3.75,-2.25},{-5.5,3.75,-2.25,-2.25},{-2.25,-5.5,-0.5,1.5}}},np.float64)
  local b=(np.array({{{true,false},{true,true},{true,false}},{{true,true},{true,true},{true,false}},{{false,true},{false,false},{false,true}},{{true,false},{true,true},{false,true}}},np.bool)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','auto 24 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'auto 24 shape')
  assert(seqeq(r.strides,{96,32,8}),'auto 24 strides')
  assert(veq(r:tolist(),{{{-1.5,0.5,-5.5,-1.5},{0.5,-6.5,3.75,0.5},{-1.5,-0.75,-5.5,3.75}},{{-0.5,2.75,2.75,-2.25},{-6.5,2.75,-2.25,-3.25},{-2.25,-5.5,-1.5,0.5}}}),'auto 24 values')
end
do -- auto-layout 25
  local a=(np.array({{-9,-9,9,4},{2,-2,0,9},{0,-2,0,-1}},np.int8)).T
  local b=(np.array({{6,10,20,18},{15,3,2,6},{9,18,10,19}},np.uint32)).T
  local r=np.add(a,b)
  assert(r.dtype=='int64','auto 25 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3}),'auto 25 shape')
  assert(seqeq(r.strides,{8,32}),'auto 25 strides')
  assert(veq(r:tolist(),{{-3,17,9},{1,1,16},{29,2,10},{22,15,18}}),'auto 25 values')
end
do -- auto-layout 26
  local a=np.array({{0,-1,-4,-9},{2,-2,-4,2},{-2,-4,0,-9}},np.int16)
  local b=np.array({{16,17,3,12},{15,12,9,17},{9,12,17,13}},np.uint16)
  local r=np.multiply(a,b)
  assert(r.dtype=='int32','auto 26 dtype '..r.dtype)
  assert(seqeq(r.shape,{3,4}),'auto 26 shape')
  assert(seqeq(r.strides,{16,4}),'auto 26 strides')
  assert(veq(r:tolist(),{{0,-17,-12,-108},{30,-24,-36,34},{-18,-48,0,-117}}),'auto 26 values')
end
do -- auto-layout 27
  local a=np.array({{{-9,2,2,4},{4,-4,-1,4},{2,-4,-1,1}},{{-1,2,-1,2},{4,1,-2,9},{-1,1,-4,9}}},np.int64)
  local b=(np.array({{{true,false},{true,false},{false,true}},{{false,false},{false,true},{false,false}},{{false,true},{true,true},{true,true}},{{false,false},{true,true},{false,false}}},np.bool)).T
  local r=np.add(a,b)
  assert(r.dtype=='int64','auto 27 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'auto 27 shape')
  assert(seqeq(r.strides,{96,32,8}),'auto 27 strides')
  assert(veq(r:tolist(),{{{-8,2,2,4},{5,-4,0,5},{2,-4,0,1}},{{-1,2,0,2},{4,2,-1,10},{0,1,-3,9}}}),'auto 27 values')
end
do -- auto-layout 28
  local a=np.array({{-5.5,-0.5,0.25},{-2.25,0.25,-5.5}},np.float64)
  local b=np.array({{-1,-9,-4},{4,4,0}},np.int64)
  local r=np.add(a,b)
  assert(r.dtype=='float64','auto 28 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'auto 28 shape')
  assert(seqeq(r.strides,{24,8}),'auto 28 strides')
  assert(veq(r:tolist(),{{-6.5,-9.5,-3.75},{1.75,4.25,-5.5}}),'auto 28 values')
end
do -- auto-layout 29
  local a=(np.array({{1,1,-2,-1},{0,9,4,-2},{-2,0,-1,4}},np.int32)).T
  local b=(np.array({{true,true,true,false},{false,false,true,false},{false,false,true,true}},np.bool)).T
  local r=np.add(a,b)
  assert(r.dtype=='int32','auto 29 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3}),'auto 29 shape')
  assert(seqeq(r.strides,{4,16}),'auto 29 strides')
  assert(veq(r:tolist(),{{2,0,-2},{2,9,0},{-1,5,0},{-1,-2,5}}),'auto 29 values')
end
do -- auto-layout 30
  local a=(np.array({{2,-1,4},{2,0,-1}},np.int32)).T
  local b=(np.array({{0.25,-0.5,3.75},{3.75,0.25,0.25}},np.float64)).T
  local r=np.add(a,b)
  assert(r.dtype=='float64','auto 30 dtype '..r.dtype)
  assert(seqeq(r.shape,{3,2}),'auto 30 shape')
  assert(seqeq(r.strides,{8,24}),'auto 30 strides')
  assert(veq(r:tolist(),{{2.25,5.75},{-1.5,0.25},{7.75,-0.75}}),'auto 30 values')
end
do -- auto-layout 31
  local a=np.array({{1,-2,4},{0,-9,0}},np.int16)
  local b=np.array({{0.25,0.25,0.25},{-2.25,-2.25,1.5}},np.float64)
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','auto 31 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'auto 31 shape')
  assert(seqeq(r.strides,{24,8}),'auto 31 strides')
  assert(veq(r:tolist(),{{4.0,-8.0,16.0},{-0.0,4.0,0.0}}),'auto 31 values')
end
do -- auto-layout 32
  local a=np.array({{{true,false,false,true},{true,false,true,false},{true,true,true,false}},{{false,false,true,true},{true,false,false,true},{false,true,true,true}}},np.bool)
  local b=np.array({{{0,0,0,0},{-9,9,-2,-4},{9,0,2,0}},{{-2,0,4,0},{0,0,-2,4},{-9,-2,-4,-4}}},np.int8)
  local r=np.add(a,b)
  assert(r.dtype=='int8','auto 32 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'auto 32 shape')
  assert(seqeq(r.strides,{12,4,1}),'auto 32 strides')
  assert(veq(r:tolist(),{{{1,0,0,1},{-8,9,-1,-4},{10,1,3,0}},{{-2,0,5,1},{1,0,-2,5},{-9,-1,-3,-3}}}),'auto 32 values')
end
do -- auto-layout 33
  local a=(np.array({{true,true,true,true},{true,false,false,true},{false,true,true,true}},np.bool)).T
  local b=(np.array({{9,4,1,-4},{-1,1,-9,-9},{4,-9,0,9}},np.int64)).T
  local r=np.add(a,b)
  assert(r.dtype=='int64','auto 33 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3}),'auto 33 shape')
  assert(seqeq(r.strides,{8,32}),'auto 33 strides')
  assert(veq(r:tolist(),{{10,0,4},{5,1,-8},{2,-9,1},{-3,-8,10}}),'auto 33 values')
end
do -- auto-layout 34
  local a=(np.array({{0,-9,2,4},{4,-1,4,-9},{-9,4,-9,1}},np.int8)).T
  local b=(np.array({{9,2,1,-4},{2,1,2,2},{2,2,-1,-2}},np.int32)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='int32','auto 34 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3}),'auto 34 shape')
  assert(seqeq(r.strides,{4,16}),'auto 34 strides')
  assert(veq(r:tolist(),{{-9,2,-11},{-11,-2,2},{1,2,-8},{8,-11,3}}),'auto 34 values')
end
do -- auto-layout 35
  local a=(np.array({{{20,1,14,1},{18,18,12,3},{7,3,9,18}},{{1,15,20,3},{13,15,4,12},{6,19,6,20}}},np.uint8)).T
  local b=(np.array({{{true,false,false,true},{false,true,true,false},{true,true,true,true}},{{true,true,true,true},{false,true,true,true},{false,false,false,true}}},np.bool)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='uint8','auto 35 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3,2}),'auto 35 shape')
  assert(seqeq(r.strides,{1,4,12}),'auto 35 strides')
  assert(veq(r:tolist(),{{{19,0},{18,13},{6,6}},{{1,14},{17,14},{2,19}},{{14,19},{11,3},{8,6}},{{0,2},{3,11},{17,19}}}),'auto 35 values')
end
do -- auto-layout 36
  local a=np.array({{{-4,4,0,9},{2,-4,-9,4},{-9,0,-1,9}},{{-9,1,4,4},{1,-4,-1,-1},{1,-1,-9,-2}}},np.int32)
  local b=np.array({{{8,12,10,20},{18,18,15,16},{13,14,18,4}},{{19,2,18,7},{11,9,11,7},{17,16,16,20}}},np.uint64)
  local r=np.multiply(a,b)
  assert(r.dtype=='float64','auto 36 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'auto 36 shape')
  assert(seqeq(r.strides,{96,32,8}),'auto 36 strides')
  assert(veq(r:tolist(),{{{-32.0,48.0,0.0,180.0},{36.0,-72.0,-135.0,64.0},{-117.0,0.0,-18.0,36.0}},{{-171.0,2.0,72.0,28.0},{11.0,-36.0,-11.0,-7.0},{17.0,-16.0,-144.0,-40.0}}}),'auto 36 values')
end
do -- auto-layout 37
  local a=(np.array({{-4,-2,0},{2,9,-1}},np.int16)).T
  local b=(np.array({{-2.25,3.75,-2.25},{-2.25,-2.25,-0.5}},np.float64)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','auto 37 dtype '..r.dtype)
  assert(seqeq(r.shape,{3,2}),'auto 37 shape')
  assert(seqeq(r.strides,{8,24}),'auto 37 strides')
  assert(veq(r:tolist(),{{-1.75,4.25},{-5.75,11.25},{2.25,-0.5}}),'auto 37 values')
end
do -- auto-layout 38
  local a=(np.array({{4,7,19},{9,6,16}},np.uint32)).T
  local b=(np.array({{9,-9,9},{-2,9,1}},np.int16)).T
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','auto 38 dtype '..r.dtype)
  assert(seqeq(r.shape,{3,2}),'auto 38 shape')
  assert(seqeq(r.strides,{8,24}),'auto 38 strides')
  assert(veq(r:tolist(),{{0.4444444444444444,-4.5},{-0.7777777777777778,0.6666666666666666},{2.111111111111111,16.0}}),'auto 38 values')
end
do -- auto-layout 39
  local a=np.array({{{18,5,11,8},{1,11,20,5},{14,17,19,9}},{{5,0,15,2},{15,7,11,20},{0,14,14,3}}},np.uint64)
  local b=np.array({{{true,false,false,true},{false,false,true,true},{false,false,false,true}},{{false,true,true,true},{false,true,false,false},{true,false,true,true}}},np.bool)
  local r=np.subtract(a,b)
  assert(r.dtype=='uint64','auto 39 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'auto 39 shape')
  assert(seqeq(r.strides,{96,32,8}),'auto 39 strides')
  assert(veq(r:tolist(),{{{17,5,11,7},{1,11,19,4},{14,17,19,8}},{{5,18446744073709551615,14,1},{15,6,11,20},{18446744073709551615,14,13,2}}}),'auto 39 values')
end
do -- auto-layout 40
  local a=(np.array({{10,20,20,3},{6,0,3,2},{9,14,7,17}},np.uint16)).T
  local b=(np.array({{10,13,5,13},{8,8,1,6},{9,14,2,4}},np.uint32)).T
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','auto 40 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3}),'auto 40 shape')
  assert(seqeq(r.strides,{8,32}),'auto 40 strides')
  assert(veq(r:tolist(),{{1.0,0.75,1.0},{1.5384615384615385,0.0,1.0},{4.0,3.0,3.5},{0.23076923076923078,0.3333333333333333,4.25}}),'auto 40 values')
end
do -- auto-layout 41
  local a=np.array({{{-2.25,-5.5,0.25,0.25},{3.75,1.5,3.75,-5.5},{3.75,3.75,1.5,0.25}},{{-5.5,-5.5,-0.5,1.5},{-0.5,0.25,-2.25,-5.5},{1.5,-0.5,1.5,-5.5}}},np.float64)
  local b=np.array({{{10,12,19,6},{14,19,13,1},{18,12,16,7}},{{8,11,6,13},{4,16,0,17},{20,1,10,12}}},np.uint32)
  local r=np.multiply(a,b)
  assert(r.dtype=='float64','auto 41 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'auto 41 shape')
  assert(seqeq(r.strides,{96,32,8}),'auto 41 strides')
  assert(veq(r:tolist(),{{{-22.5,-66.0,4.75,1.5},{52.5,28.5,48.75,-5.5},{67.5,45.0,24.0,1.75}},{{-44.0,-60.5,-3.0,19.5},{-2.0,4.0,-0.0,-93.5},{30.0,-0.5,15.0,-66.0}}}),'auto 41 values')
end
do -- auto-layout 42
  local a=(np.array({{3.75,0.25,0.25},{-0.5,0.25,0.25}},np.float16)).T
  local b=(np.array({{3.75,3.75,-5.5},{3.75,3.75,-0.5}},np.float32)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='float32','auto 42 dtype '..r.dtype)
  assert(seqeq(r.shape,{3,2}),'auto 42 shape')
  assert(seqeq(r.strides,{4,12}),'auto 42 strides')
  assert(veq(r:tolist(),{{0.0,-4.25},{-3.5,-3.5},{5.75,0.75}}),'auto 42 values')
end
do -- auto-layout 43
  local a=(np.array({{-2.25,0.25,-0.5},{-0.5,3.75,1.5}},np.float64)).T
  local b=(np.array({{-0.5,0.25,1.5},{-2.25,-0.5,-2.25}},np.float64)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','auto 43 dtype '..r.dtype)
  assert(seqeq(r.shape,{3,2}),'auto 43 shape')
  assert(seqeq(r.strides,{8,24}),'auto 43 strides')
  assert(veq(r:tolist(),{{-1.75,1.75},{0.0,4.25},{-2.0,3.75}}),'auto 43 values')
end
do -- auto-layout 44
  local a=(np.array({{{-5.5,-2.25,-5.5,3.75},{1.5,-5.5,0.25,-2.25},{-5.5,-0.5,-0.5,-0.5}},{{-0.5,1.5,-5.5,3.75},{0.25,-0.5,-0.5,3.75},{3.75,1.5,-5.5,-2.25}}},np.float16)).T
  local b=(np.array({{{3.75,-5.5,-0.5,0.25},{3.75,1.5,1.5,1.5},{-2.25,1.5,0.25,1.5}},{{1.5,-2.25,3.75,3.75},{0.25,3.75,3.75,-2.25},{-0.5,-0.5,1.5,1.5}}},np.float64)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','auto 44 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3,2}),'auto 44 shape')
  assert(seqeq(r.strides,{8,32,96}),'auto 44 strides')
  assert(veq(r:tolist(),{{{-9.25,-2.0},{-2.25,0.0},{-3.25,4.25}},{{3.25,3.75},{-7.0,-4.25},{-2.0,2.0}},{{-5.0,-9.25},{-1.25,-4.25},{-0.75,-7.0}},{{3.5,0.0},{-3.75,6.0},{-2.0,-3.75}}}),'auto 44 values')
end
do -- auto-layout 45
  local a=np.array({{4,-1,-4},{-1,-9,-1}},np.int16)
  local b=(np.array({{-5.5,3.75},{0.25,-0.5},{-0.5,-2.25}},np.float32)).T
  local r=np.add(a,b)
  assert(r.dtype=='float32','auto 45 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'auto 45 shape')
  assert(seqeq(r.strides,{12,4}),'auto 45 strides')
  assert(veq(r:tolist(),{{-1.5,-0.75,-4.5},{2.75,-9.5,-3.25}}),'auto 45 values')
end
do -- auto-layout 46
  local a=(np.array({{0.25,0.25,-2.25},{-2.25,-2.25,0.25}},np.float64)).T
  local b=(np.array({{-2.25,-0.5,-2.25},{-2.25,-2.25,3.75}},np.float16)).T
  local r=np.multiply(a,b)
  assert(r.dtype=='float64','auto 46 dtype '..r.dtype)
  assert(seqeq(r.shape,{3,2}),'auto 46 shape')
  assert(seqeq(r.strides,{8,24}),'auto 46 strides')
  assert(veq(r:tolist(),{{-0.5625,5.0625},{-0.125,5.0625},{5.0625,0.9375}}),'auto 46 values')
end
do -- auto-layout 47
  local a=(np.array({{-2,-4,-1},{-2,2,-2}},np.int8)).T
  local b=(np.array({{true,true,false},{true,false,false}},np.bool)).T
  local r=np.add(a,b)
  assert(r.dtype=='int8','auto 47 dtype '..r.dtype)
  assert(seqeq(r.shape,{3,2}),'auto 47 shape')
  assert(seqeq(r.strides,{1,3}),'auto 47 strides')
  assert(veq(r:tolist(),{{-1,-1},{-3,2},{-1,-2}}),'auto 47 values')
end
do -- auto-layout 48
  local a=(np.array({{0,-4,-9},{-9,4,-1}},np.int32)).T
  local b=(np.array({{19,14,18},{5,16,13}},np.uint8)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='int32','auto 48 dtype '..r.dtype)
  assert(seqeq(r.shape,{3,2}),'auto 48 shape')
  assert(seqeq(r.strides,{4,12}),'auto 48 strides')
  assert(veq(r:tolist(),{{-19,-14},{-18,-12},{-27,-14}}),'auto 48 values')
end
do -- auto-layout 49
  local a=np.array({{{1,-4,-4,0},{0,0,-4,-9},{-2,1,-1,-2}},{{4,2,1,9},{9,-4,-4,4},{0,9,-9,-4}}},np.int32)
  local b=np.array({{{4,9,-1,4},{2,4,-9,-1},{9,4,4,9}},{{2,9,4,0},{-9,9,-4,4},{-1,-4,-9,-4}}},np.int32)
  local r=np.add(a,b)
  assert(r.dtype=='int32','auto 49 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'auto 49 shape')
  assert(seqeq(r.strides,{48,16,4}),'auto 49 strides')
  assert(veq(r:tolist(),{{{5,5,-5,4},{2,4,-13,-10},{7,5,3,7}},{{6,11,5,9},{0,5,-8,8},{-1,5,-18,-8}}}),'auto 49 values')
end
do -- auto-layout 50
  local a=(np.array({{{-9,4,9,-1},{1,-2,2,4},{-1,-9,-4,-2}},{{-1,2,2,4},{-2,-1,4,9},{0,2,2,-4}}},np.int8)).T
  local b=(np.array({{{1.5,1.5,-0.5,-5.5},{3.75,-0.5,0.25,3.75},{1.5,1.5,-5.5,1.5}},{{-5.5,-0.5,1.5,1.5},{-5.5,-2.25,0.25,-2.25},{-2.25,3.75,3.75,-5.5}}},np.float64)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','auto 50 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3,2}),'auto 50 shape')
  assert(seqeq(r.strides,{8,32,96}),'auto 50 strides')
  assert(veq(r:tolist(),{{{-10.5,4.5},{-2.75,3.5},{-2.5,2.25}},{{2.5,2.5},{-1.5,1.25},{-10.5,-1.75}},{{9.5,0.5},{1.75,3.75},{1.5,-1.75}},{{4.5,2.5},{0.25,11.25},{-3.5,1.5}}}),'auto 50 values')
end
do -- auto-layout 51
  local a=np.array({{{false,true,false,false},{true,false,true,true},{true,false,false,true}},{{false,false,false,false},{true,true,false,false},{true,false,false,true}}},np.bool)
  local b=np.array({{{16,8,15,17},{19,17,11,8},{8,16,18,2}},{{19,5,20,11},{8,11,12,18},{9,8,11,20}}},np.uint32)
  local r=np.multiply(a,b)
  assert(r.dtype=='uint32','auto 51 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'auto 51 shape')
  assert(seqeq(r.strides,{48,16,4}),'auto 51 strides')
  assert(veq(r:tolist(),{{{0,8,0,0},{19,0,11,8},{8,0,0,2}},{{0,0,0,0},{8,11,0,0},{9,0,0,20}}}),'auto 51 values')
end
do -- auto-layout 52
  local a=(np.array({{-2.25,3.75,-0.5},{1.5,0.25,-0.5}},np.float16)).T
  local b=(np.array({{-0.5,-0.5,-5.5},{-2.25,0.25,0.25}},np.float32)).T
  local r=np.multiply(a,b)
  assert(r.dtype=='float32','auto 52 dtype '..r.dtype)
  assert(seqeq(r.shape,{3,2}),'auto 52 shape')
  assert(seqeq(r.strides,{4,12}),'auto 52 strides')
  assert(veq(r:tolist(),{{1.125,-3.375},{-1.875,0.0625},{2.75,-0.125}}),'auto 52 values')
end
do -- auto-layout 53
  local a=np.array({{-0.5,0.25,-5.5},{1.5,1.5,0.25}},np.float32)
  local b=(np.array({{17,1},{16,17},{3,4}},np.uint16)).T
  local r=np.true_divide(a,b)
  assert(r.dtype=='float32','auto 53 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'auto 53 shape')
  assert(seqeq(r.strides,{12,4}),'auto 53 strides')
  assert(veq(r:tolist(),{{-0.029411764815449715,0.015625,-1.8333333730697632},{1.5,0.0882352963089943,0.0625}}),'auto 53 values')
end
do -- auto-layout 54
  local a=np.array({{2,4,9},{-1,0,-4}},np.int64)
  local b=(np.array({{0.25,-5.5},{3.75,-0.5},{1.5,-5.5}},np.float64)).T
  local r=np.add(a,b)
  assert(r.dtype=='float64','auto 54 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'auto 54 shape')
  assert(seqeq(r.strides,{24,8}),'auto 54 strides')
  assert(veq(r:tolist(),{{2.25,7.75,10.5},{-6.5,-0.5,-9.5}}),'auto 54 values')
end
do -- auto-layout 55
  local a=(np.array({{10,0,15,3},{0,17,4,16},{8,20,13,17}},np.uint64)).T
  local b=(np.array({{1.5,1.5,3.75,1.5},{-2.25,3.75,3.75,-0.5},{-2.25,3.75,3.75,1.5}},np.float32)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','auto 55 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3}),'auto 55 shape')
  assert(seqeq(r.strides,{8,32}),'auto 55 strides')
  assert(veq(r:tolist(),{{8.5,2.25,10.25},{-1.5,13.25,16.25},{11.25,0.25,9.25},{1.5,16.5,15.5}}),'auto 55 values')
end
do -- auto-layout 56
  local a=(np.array({{{3.75,1.5,-2.25,1.5},{-5.5,-5.5,0.25,0.25},{-0.5,3.75,1.5,1.5}},{{-0.5,3.75,1.5,-5.5},{3.75,-5.5,-5.5,1.5},{1.5,0.25,-2.25,-2.25}}},np.float16)).T
  local b=(np.array({{{true,true,true,true},{true,true,true,true},{true,true,true,true}},{{true,true,true,true},{true,true,true,true},{true,true,true,true}}},np.bool)).T
  local r=np.true_divide(a,b)
  assert(r.dtype=='float16','auto 56 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3,2}),'auto 56 shape')
  assert(seqeq(r.strides,{2,8,24}),'auto 56 strides')
  assert(veq(r:tolist(),{{{3.75,-0.5},{-5.5,3.75},{-0.5,1.5}},{{1.5,3.75},{-5.5,-5.5},{3.75,0.25}},{{-2.25,1.5},{0.25,-5.5},{1.5,-2.25}},{{1.5,-5.5},{0.25,1.5},{1.5,-2.25}}}),'auto 56 values')
end
do -- auto-layout 57
  local a=(np.array({{4,-4,9},{0,1,1}},np.int32)).T
  local b=(np.array({{9,0,9},{-1,4,-2}},np.int32)).T
  local r=np.multiply(a,b)
  assert(r.dtype=='int32','auto 57 dtype '..r.dtype)
  assert(seqeq(r.shape,{3,2}),'auto 57 shape')
  assert(seqeq(r.strides,{4,12}),'auto 57 strides')
  assert(veq(r:tolist(),{{36,0},{0,4},{81,-2}}),'auto 57 values')
end
do -- auto-layout 58
  local a=np.array({{{7,16,3,9},{14,3,16,4},{10,5,15,17}},{{11,14,16,4},{17,20,19,5},{11,17,8,13}}},np.uint16)
  local b=np.array({{{-5.5,-5.5,-2.25,3.75},{1.5,-5.5,-0.5,-2.25},{3.75,1.5,3.75,3.75}},{{3.75,0.25,-0.5,-5.5},{-5.5,-2.25,1.5,-2.25},{3.75,-5.5,-2.25,0.25}}},np.float16)
  local r=np.add(a,b)
  assert(r.dtype=='float32','auto 58 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'auto 58 shape')
  assert(seqeq(r.strides,{48,16,4}),'auto 58 strides')
  assert(veq(r:tolist(),{{{1.5,10.5,0.75,12.75},{15.5,-2.5,15.5,1.75},{13.75,6.5,18.75,20.75}},{{14.75,14.25,15.5,-1.5},{11.5,17.75,20.5,2.75},{14.75,11.5,5.75,13.25}}}),'auto 58 values')
end
do -- auto-layout 59
  local a=(np.array({{{9,4,1,-2},{-2,4,-1,-1},{4,9,-4,-9}},{{4,9,4,4},{4,2,9,0},{-4,-1,9,4}}},np.int8)).T
  local b=(np.array({{{-9,4,1,-1},{4,4,4,0},{2,1,-4,-9}},{{0,9,-4,0},{0,9,-1,-2},{-4,9,9,-1}}},np.int8)).T
  local r=np.add(a,b)
  assert(r.dtype=='int8','auto 59 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3,2}),'auto 59 shape')
  assert(seqeq(r.strides,{1,4,12}),'auto 59 strides')
  assert(veq(r:tolist(),{{{0,4},{2,4},{6,-8}},{{8,18},{8,11},{10,8}},{{2,0},{3,8},{-8,18}},{{-3,4},{-1,-2},{-18,3}}}),'auto 59 values')
end
do -- auto-layout 60
  local a=(np.array({{{3,12,15,2},{16,9,12,0},{2,2,0,8}},{{2,0,13,11},{16,17,11,3},{10,12,13,1}}},np.uint64)).T
  local b=(np.array({{{-0.5,-0.5,0.25,0.25},{3.75,-5.5,-2.25,-5.5},{-2.25,-0.5,-2.25,1.5}},{{3.75,-5.5,-5.5,1.5},{3.75,-0.5,-2.25,-2.25},{3.75,-0.5,1.5,1.5}}},np.float32)).T
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','auto 60 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3,2}),'auto 60 shape')
  assert(seqeq(r.strides,{8,32,96}),'auto 60 strides')
  assert(veq(r:tolist(),{{{-6.0,0.5333333333333333},{4.266666666666667,4.266666666666667},{-0.8888888888888888,2.6666666666666665}},{{-24.0,-0.0},{-1.6363636363636365,-34.0},{-4.0,-24.0}},{{60.0,-2.3636363636363638},{-5.333333333333333,-4.888888888888889},{-0.0,8.666666666666666}},{{8.0,7.333333333333333},{-0.0,-1.3333333333333333},{5.333333333333333,0.6666666666666666}}}),'auto 60 values')
end
do -- auto-layout 61
  local a=(np.array({{3.75,0.25,3.75,-2.25},{0.25,0.25,1.5,-2.25},{-2.25,-2.25,-2.25,0.25}},np.float64)).T
  local b=(np.array({{1,16,17,3},{16,5,9,19},{20,16,15,19}},np.uint16)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','auto 61 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3}),'auto 61 shape')
  assert(seqeq(r.strides,{8,32}),'auto 61 strides')
  assert(veq(r:tolist(),{{2.75,-15.75,-22.25},{-15.75,-4.75,-18.25},{-13.25,-7.5,-17.25},{-5.25,-21.25,-18.75}}),'auto 61 values')
end
do -- auto-layout 62
  local a=(np.array({{{-2,-9,-1,-1},{9,-9,-2,4},{-4,0,-2,-2}},{{0,-1,-2,-1},{2,-9,-9,-4},{4,1,4,1}}},np.int64)).T
  local b=(np.array({{{2,9,-9,-9},{-4,4,-1,-4},{-1,-2,-4,4}},{{1,-2,-2,-2},{-9,-4,9,-9},{4,1,2,4}}},np.int8)).T
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','auto 62 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3,2}),'auto 62 shape')
  assert(seqeq(r.strides,{8,32,96}),'auto 62 strides')
  assert(veq(r:tolist(),{{{-1.0,0.0},{-2.25,-0.2222222222222222},{4.0,1.0}},{{-1.0,0.5},{-2.25,2.25},{-0.0,1.0}},{{0.1111111111111111,1.0},{2.0,-1.0},{0.5,2.0}},{{0.1111111111111111,0.5},{-1.0,0.4444444444444444},{-0.5,0.25}}}),'auto 62 values')
end
do -- auto-layout 63
  local a=(np.array({{{1,1,-9,-1},{-2,9,9,-1},{-2,4,9,4}},{{9,2,9,-1},{-4,-9,-9,-1},{1,4,-1,-2}}},np.int32)).T
  local b=(np.array({{{4,-4,1,-4},{-2,-1,-4,-2},{1,9,0,9}},{{-4,2,-9,-1},{-1,-2,4,-1},{4,1,1,9}}},np.int16)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='int32','auto 63 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3,2}),'auto 63 shape')
  assert(seqeq(r.strides,{4,16,48}),'auto 63 strides')
  assert(veq(r:tolist(),{{{-3,13},{0,-3},{-3,-3}},{{5,0},{10,-7},{-5,3}},{{-10,18},{13,-13},{9,-2}},{{3,0},{1,0},{-5,-11}}}),'auto 63 values')
end
do -- auto-layout 64
  local a=(np.array({{{12,15,7,11},{18,0,15,11},{7,5,14,12}},{{2,18,13,1},{12,14,12,19},{9,9,16,7}}},np.uint8)).T
  local b=(np.array({{{3.75,0.25,-2.25,0.25},{1.5,-2.25,-2.25,-5.5},{1.5,-5.5,1.5,0.25}},{{-5.5,0.25,-5.5,1.5},{3.75,0.25,0.25,-0.5},{-0.5,-0.5,3.75,1.5}}},np.float32)).T
  local r=np.add(a,b)
  assert(r.dtype=='float32','auto 64 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3,2}),'auto 64 shape')
  assert(seqeq(r.strides,{4,16,48}),'auto 64 strides')
  assert(veq(r:tolist(),{{{15.75,-3.5},{19.5,15.75},{8.5,8.5}},{{15.25,18.25},{-2.25,14.25},{-0.5,8.5}},{{4.75,7.5},{12.75,12.25},{15.5,19.75}},{{11.25,2.5},{5.5,18.5},{12.25,8.5}}}),'auto 64 values')
end
do -- auto-layout 65
  local a=(np.array({{-2,9,0},{1,-2,4}},np.int32)).T
  local b=(np.array({{9,4,-1},{-9,-2,-9}},np.int16)).T
  local r=np.multiply(a,b)
  assert(r.dtype=='int32','auto 65 dtype '..r.dtype)
  assert(seqeq(r.shape,{3,2}),'auto 65 shape')
  assert(seqeq(r.strides,{4,12}),'auto 65 strides')
  assert(veq(r:tolist(),{{-18,-9},{36,4},{0,-36}}),'auto 65 values')
end
do -- auto-layout 66
  local a=np.array({{3.75,-0.5,-0.5},{1.5,1.5,-0.5}},np.float64)
  local b=(np.array({{2,2},{-1,4},{4,-1}},np.int32)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','auto 66 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'auto 66 shape')
  assert(seqeq(r.strides,{24,8}),'auto 66 strides')
  assert(veq(r:tolist(),{{1.75,0.5,-4.5},{-0.5,-2.5,0.5}}),'auto 66 values')
end
do -- auto-layout 67
  local a=(np.array({{-4,-1,-1,9},{-9,2,-2,9},{4,-2,9,9}},np.int64)).T
  local b=(np.array({{false,true,true,false},{false,false,false,false},{false,false,true,false}},np.bool)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','auto 67 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3}),'auto 67 shape')
  assert(seqeq(r.strides,{8,32}),'auto 67 strides')
  assert(veq(r:tolist(),{{-4,-9,4},{-2,2,-2},{-2,-2,8},{9,9,9}}),'auto 67 values')
end
do -- auto-layout 68
  local a=np.array({{{5,19,19,6},{7,19,11,15},{16,10,0,6}},{{12,8,19,0},{14,2,10,1},{17,1,10,20}}},np.uint32)
  local b=(np.array({{{4,9},{14,6},{4,17}},{{9,4},{15,7},{20,16}},{{1,4},{0,14},{3,1}},{{5,13},{4,17},{9,20}}},np.uint64)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='uint64','auto 68 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'auto 68 shape')
  assert(seqeq(r.strides,{96,32,8}),'auto 68 strides')
  assert(veq(r:tolist(),{{{1,10,18,1},{18446744073709551609,4,11,11},{12,18446744073709551606,18446744073709551613,18446744073709551613}},{{3,4,15,18446744073709551603},{8,18446744073709551611,18446744073709551612,18446744073709551600},{0,18446744073709551601,9,0}}}),'auto 68 values')
end
do -- auto-layout 69
  local a=np.array({{{true,false,false,false},{true,false,true,false},{true,true,false,true}},{{true,true,false,false},{false,true,false,true},{true,false,true,false}}},np.bool)
  local b=np.array({{{3.75,1.5,-2.25,-2.25},{1.5,-0.5,-0.5,-2.25},{-5.5,1.5,1.5,-0.5}},{{3.75,-0.5,-2.25,-0.5},{-0.5,-0.5,1.5,0.25},{3.75,0.25,3.75,-0.5}}},np.float16)
  local r=np.add(a,b)
  assert(r.dtype=='float16','auto 69 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'auto 69 shape')
  assert(seqeq(r.strides,{24,8,2}),'auto 69 strides')
  assert(veq(r:tolist(),{{{4.75,1.5,-2.25,-2.25},{2.5,-0.5,0.5,-2.25},{-4.5,2.5,1.5,0.5}},{{4.75,0.5,-2.25,-0.5},{-0.5,0.5,1.5,1.25},{4.75,0.25,4.75,-0.5}}}),'auto 69 values')
end
do -- auto-layout 70
  local a=np.array({{false,true,false},{false,false,true}},np.bool)
  local b=(np.array({{-2,-1},{1,1},{-2,2}},np.int32)).T
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','auto 70 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'auto 70 shape')
  assert(seqeq(r.strides,{24,8}),'auto 70 strides')
  assert(veq(r:tolist(),{{-0.0,1.0,-0.0},{-0.0,0.0,0.5}}),'auto 70 values')
end
do -- auto-layout 71
  local a=(np.array({{{11,8,9,20},{1,2,6,0},{1,8,17,4}},{{9,4,13,3},{3,16,8,6},{16,10,7,15}}},np.uint8)).T
  local b=(np.array({{{true,false,true,false},{true,true,true,false},{true,false,true,true}},{{false,false,false,true},{true,false,true,false},{true,false,false,false}}},np.bool)).T
  local r=np.multiply(a,b)
  assert(r.dtype=='uint8','auto 71 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3,2}),'auto 71 shape')
  assert(seqeq(r.strides,{1,4,12}),'auto 71 strides')
  assert(veq(r:tolist(),{{{11,0},{1,3},{1,16}},{{0,0},{2,0},{0,0}},{{9,0},{6,8},{17,0}},{{0,3},{0,0},{4,0}}}),'auto 71 values')
end
do -- auto-layout 72
  local a=(np.array({{13,14,5},{20,11,8}},np.uint32)).T
  local b=(np.array({{10,2,10},{3,17,6}},np.uint8)).T
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','auto 72 dtype '..r.dtype)
  assert(seqeq(r.shape,{3,2}),'auto 72 shape')
  assert(seqeq(r.strides,{8,24}),'auto 72 strides')
  assert(veq(r:tolist(),{{1.3,6.666666666666667},{7.0,0.6470588235294118},{0.5,1.3333333333333333}}),'auto 72 values')
end
do -- auto-layout 73
  local a=np.array({{{1.5,3.75,-5.5,-0.5},{-0.5,-2.25,3.75,-0.5},{-5.5,-0.5,3.75,-0.5}},{{-2.25,1.5,-5.5,3.75},{-5.5,-0.5,0.25,1.5},{0.25,-0.5,1.5,3.75}}},np.float16)
  local b=np.array({{{-5.5,1.5,-5.5,-5.5},{3.75,-0.5,3.75,1.5},{0.25,-2.25,-2.25,-0.5}},{{3.75,-0.5,-0.5,0.25},{-5.5,-0.5,-0.5,-0.5},{0.25,1.5,-5.5,-0.5}}},np.float16)
  local r=np.subtract(a,b)
  assert(r.dtype=='float16','auto 73 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'auto 73 shape')
  assert(seqeq(r.strides,{24,8,2}),'auto 73 strides')
  assert(veq(r:tolist(),{{{7.0,2.25,0.0,5.0},{-4.25,-1.75,0.0,-2.0},{-5.75,1.75,6.0,0.0}},{{-6.0,2.0,-5.0,3.5},{0.0,0.0,0.75,2.0},{0.0,-2.0,7.0,4.25}}}),'auto 73 values')
end
do -- auto-layout 74
  local a=np.array({{{10,2,3,7},{16,2,15,15},{20,20,0,16}},{{2,12,4,7},{8,7,13,11},{3,4,19,0}}},np.uint16)
  local b=np.array({{{-1,4,9,2},{4,2,2,0},{-4,9,-4,9}},{{4,0,9,-9},{-4,9,9,0},{2,1,-1,-9}}},np.int8)
  local r=np.multiply(a,b)
  assert(r.dtype=='int32','auto 74 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3,4}),'auto 74 shape')
  assert(seqeq(r.strides,{48,16,4}),'auto 74 strides')
  assert(veq(r:tolist(),{{{-10,8,27,14},{64,4,30,0},{-80,180,0,144}},{{8,0,36,-63},{-32,63,117,0},{6,4,-19,0}}}),'auto 74 values')
end
do -- auto-layout 75
  local a=np.array({{12,16,19},{3,16,16}},np.uint32)
  local b=(np.array({{0,1},{4,2},{0,4}},np.int64)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='int64','auto 75 dtype '..r.dtype)
  assert(seqeq(r.shape,{2,3}),'auto 75 shape')
  assert(seqeq(r.strides,{24,8}),'auto 75 strides')
  assert(veq(r:tolist(),{{12,12,19},{2,14,12}}),'auto 75 values')
end
do -- auto-layout 76
  local a=(np.array({{0.25,0.25,0.25,-5.5},{1.5,3.75,0.25,-5.5},{1.5,0.25,1.5,0.25}},np.float64)).T
  local b=(np.array({{6,18,7,7},{4,14,20,14},{14,5,1,12}},np.uint64)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','auto 76 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3}),'auto 76 shape')
  assert(seqeq(r.strides,{8,32}),'auto 76 strides')
  assert(veq(r:tolist(),{{-5.75,-2.5,-12.5},{-17.75,-10.25,-4.75},{-6.75,-19.75,0.5},{-12.5,-19.5,-11.75}}),'auto 76 values')
end
do -- auto-layout 77
  local a=(np.array({{{8,4,15,2},{19,8,3,15},{11,14,6,15}},{{17,19,0,14},{7,13,4,18},{19,18,14,10}}},np.uint16)).T
  local b=(np.array({{{-2.25,-0.5,3.75,0.25},{1.5,-0.5,3.75,-2.25},{-2.25,-5.5,-2.25,1.5}},{{-2.25,-0.5,1.5,0.25},{0.25,0.25,0.25,-5.5},{-0.5,3.75,-2.25,-5.5}}},np.float64)).T
  local r=np.subtract(a,b)
  assert(r.dtype=='float64','auto 77 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3,2}),'auto 77 shape')
  assert(seqeq(r.strides,{8,32,96}),'auto 77 strides')
  assert(veq(r:tolist(),{{{10.25,19.25},{17.5,6.75},{13.25,19.5}},{{4.5,19.5},{8.5,12.75},{19.5,14.25}},{{11.25,-1.5},{-0.75,3.75},{8.25,16.25}},{{1.75,13.75},{17.25,23.5},{13.5,15.5}}}),'auto 77 values')
end
do -- auto-layout 78
  local a=(np.array({{0,10,6,20},{4,7,18,18},{19,8,5,13}},np.uint32)).T
  local b=(np.array({{-9,1,1,-2},{9,2,9,-4},{1,0,-4,4}},np.int8)).T
  local r=np.add(a,b)
  assert(r.dtype=='int64','auto 78 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3}),'auto 78 shape')
  assert(seqeq(r.strides,{8,32}),'auto 78 strides')
  assert(veq(r:tolist(),{{-9,13,20},{11,9,8},{7,27,1},{18,14,17}}),'auto 78 values')
end
do -- auto-layout 79
  local a=(np.array({{18,6,10,17},{9,4,14,19},{20,6,20,13}},np.uint32)).T
  local b=(np.array({{0.25,3.75,3.75,3.75},{3.75,1.5,-0.5,-2.25},{1.5,-2.25,-0.5,-5.5}},np.float64)).T
  local r=np.true_divide(a,b)
  assert(r.dtype=='float64','auto 79 dtype '..r.dtype)
  assert(seqeq(r.shape,{4,3}),'auto 79 shape')
  assert(seqeq(r.strides,{8,32}),'auto 79 strides')
  assert(veq(r:tolist(),{{72.0,2.4,13.333333333333334},{1.6,2.6666666666666665,-2.6666666666666665},{2.6666666666666665,-28.0,-40.0},{4.533333333333333,-8.444444444444445,-2.3636363636363638}}),'auto 79 values')
end
do -- out-where 0
  local a=np.array({{17},{6}},np.uint32)
  local b=np.array({{17,11,20}},np.uint16)
  local m=np.array({true,true,true},np.bool)
  local o=np.array({{0,1,2},{3,4,5}},np.int64)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 0 identity')
  assert(o.dtype=='int64','out 0 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 0 shape')
  assert(seqeq(o.strides,{24,8}),'out 0 strides')
  assert(veq(o:tolist(),{{34,28,37},{23,17,26}}),'out 0 values')
end
do -- out-where 1
  local a=np.array({{9,1,4},{4,-9,9}},np.int16)
  local b=np.array({7,8,1},np.uint64)
  local m=np.array({{false}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 1 identity')
  assert(o.dtype=='float64','out 1 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 1 shape')
  assert(seqeq(o.strides,{24,8}),'out 1 strides')
  assert(veq(o:tolist(),{{0.0,1.0,2.0},{3.0,4.0,5.0}}),'out 1 values')
end
do -- out-where 2
  local a=np.array({{-0.5,3.75,1.5},{3.75,-5.5,-0.5}},np.float16)
  local b=np.array({{1,0,2}},np.int64)
  local m=np.array({{true}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 2 identity')
  assert(o.dtype=='float16','out 2 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 2 shape')
  assert(seqeq(o.strides,{6,2}),'out 2 strides')
  assert(veq(o:tolist(),{{-0.5,0.0,3.0},{3.75,-0.0,-1.0}}),'out 2 values')
end
do -- out-where 3
  local a=np.array({1.5,-5.5,3.75,1.5,3.75},np.float16)
  local b=np.array({17,1,18,1,6},np.uint64)
  local m=np.array({{false},{true}},np.bool)
  local o=np.array({{0.0,1.0,2.0,3.0,4.0},{5.0,6.0,7.0,8.0,9.0}},np.float16)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 3 identity')
  assert(o.dtype=='float16','out 3 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,5}),'out 3 shape')
  assert(seqeq(o.strides,{10,2}),'out 3 strides')
  assert(veq(o:tolist(),{{0.0,1.0,2.0,3.0,4.0},{25.5,-5.5,67.5,1.5,22.5}}),'out 3 values')
end
do -- out-where 4
  local a=np.array({{0,4,0},{4,4,-2}},np.int32)
  local b=np.array({3.75,-0.5,0.25},np.float64)
  local m=np.array({{false}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 4 identity')
  assert(o.dtype=='float16','out 4 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 4 shape')
  assert(seqeq(o.strides,{6,2}),'out 4 strides')
  assert(veq(o:tolist(),{{0.0,1.0,2.0},{3.0,4.0,5.0}}),'out 4 values')
end
do -- out-where 5
  local a=np.array({2,0,-9,-2,-1},np.int64)
  local b=np.array({14,15,8,17,15},np.uint8)
  local m=np.array({true},np.bool)
  local o=np.array({0,1,2,3,4},np.int16)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 5 identity')
  assert(o.dtype=='int16','out 5 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 5 shape')
  assert(seqeq(o.strides,{2}),'out 5 strides')
  assert(veq(o:tolist(),{16,15,-1,15,14}),'out 5 values')
end
do -- out-where 6
  local a=np.array({{-9},{-2}},np.int16)
  local b=np.array({{18,15,10}},np.uint16)
  local m=np.array({{{false}},{{true}}},np.bool)
  local o=np.array({{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{6.0,7.0,8.0},{9.0,10.0,11.0}}},np.float16)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 6 identity')
  assert(o.dtype=='float16','out 6 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 6 shape')
  assert(seqeq(o.strides,{12,6,2}),'out 6 strides')
  assert(veq(o:tolist(),{{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{-0.5,-0.60009765625,-0.89990234375},{-0.111083984375,-0.13330078125,-0.199951171875}}}),'out 6 values')
end
do -- out-where 7
  local a=np.array({{9},{6}},np.uint16)
  local b=np.array({{4,-9,-4}},np.int32)
  local m=np.array({false,true,true},np.bool)
  local o=np.array({{0,1,2},{3,4,5}},np.int64)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 7 identity')
  assert(o.dtype=='int64','out 7 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 7 shape')
  assert(seqeq(o.strides,{24,8}),'out 7 strides')
  assert(veq(o:tolist(),{{0,18,13},{3,15,10}}),'out 7 values')
end
do -- out-where 8
  local a=np.array({{true,true,true},{false,false,false}},np.bool)
  local b=np.array({{0.25,-2.25,0.25}},np.float16)
  local m=np.array({{false,true,true},{true,false,true}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float32)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 8 identity')
  assert(o.dtype=='float32','out 8 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 8 shape')
  assert(seqeq(o.strides,{12,4}),'out 8 strides')
  assert(veq(o:tolist(),{{0.0,3.25,0.75},{-0.25,4.0,-0.25}}),'out 8 values')
end
do -- out-where 9
  local a=np.array({{{0},{3},{13}},{{18},{12},{17}}},np.uint8)
  local b=np.array({{{5,9,18,5},{18,15,18,5},{10,2,1,16}}},np.uint16)
  local m=np.array({{{false}}},np.bool)
  local o=np.array({{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},np.float32)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 9 identity')
  assert(o.dtype=='float32','out 9 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3,4}),'out 9 shape')
  assert(seqeq(o.strides,{48,16,4}),'out 9 strides')
  assert(veq(o:tolist(),{{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}}),'out 9 values')
end
do -- out-where 10
  local a=np.array({{true},{true}},np.bool)
  local b=np.array({{14,5,12}},np.uint16)
  local m=np.array({{{false}},{{true}}},np.bool)
  local o=np.array({{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{6.0,7.0,8.0},{9.0,10.0,11.0}}},np.float16)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 10 identity')
  assert(o.dtype=='float16','out 10 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 10 shape')
  assert(seqeq(o.strides,{12,6,2}),'out 10 strides')
  assert(veq(o:tolist(),{{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{math.huge,math.huge,math.huge},{math.huge,math.huge,math.huge}}}),'out 10 values')
end
do -- out-where 11
  local a=np.array({{4,1,1},{9,9,1}},np.int8)
  local b=np.array({{1,-4,1}},np.int32)
  local m=np.array({false,true,true},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 11 identity')
  assert(o.dtype=='float64','out 11 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 11 shape')
  assert(seqeq(o.strides,{24,8}),'out 11 strides')
  assert(veq(o:tolist(),{{0.0,-0.25,1.0},{3.0,-2.25,1.0}}),'out 11 values')
end
do -- out-where 12
  local a=np.array({{true,false,true},{true,false,false}},np.bool)
  local b=np.array({-1,2,-1},np.int8)
  local m=np.array({false,true,true},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 12 identity')
  assert(o.dtype=='float64','out 12 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 12 shape')
  assert(seqeq(o.strides,{24,8}),'out 12 strides')
  assert(veq(o:tolist(),{{0.0,-2.0,2.0},{3.0,-2.0,1.0}}),'out 12 values')
end
do -- out-where 13
  local a=np.array({{0,-4,9},{0,-2,4}},np.int16)
  local b=np.array({{4,-2,2}},np.int64)
  local m=np.array({false,true,true},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 13 identity')
  assert(o.dtype=='float64','out 13 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 13 shape')
  assert(seqeq(o.strides,{24,8}),'out 13 strides')
  assert(veq(o:tolist(),{{0.0,2.0,4.5},{3.0,1.0,2.0}}),'out 13 values')
end
do -- out-where 14
  local a=np.array({{{-1},{1},{-9}},{{1},{-1},{4}}},np.int16)
  local b=np.array({{{1.5,-5.5,0.25,-2.25},{0.25,0.25,0.25,0.25},{3.75,-2.25,3.75,3.75}}},np.float32)
  local m=np.array({false,true,true,false},np.bool)
  local o=np.array({{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},np.float16)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 14 identity')
  assert(o.dtype=='float16','out 14 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3,4}),'out 14 shape')
  assert(seqeq(o.strides,{24,8,2}),'out 14 strides')
  assert(veq(o:tolist(),{{{0.0,0.1817626953125,-4.0,3.0},{4.0,4.0,4.0,7.0},{8.0,4.0,-2.400390625,11.0}},{{12.0,-0.1817626953125,4.0,15.0},{16.0,-4.0,-4.0,2.0},{3.0,-1.77734375,1.06640625,6.0}}}),'out 14 values')
end
do -- out-where 15
  local a=np.array({{-9,-2,-4},{-2,-4,2}},np.int32)
  local b=np.array({{16,13,17}},np.uint8)
  local m=np.array({{false,true,true},{true,false,true}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 15 identity')
  assert(o.dtype=='float64','out 15 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 15 shape')
  assert(seqeq(o.strides,{24,8}),'out 15 strides')
  assert(veq(o:tolist(),{{0.0,-0.15384615384615385,-0.23529411764705882},{-0.125,4.0,0.11764705882352941}}),'out 15 values')
end
do -- out-where 16
  local a=np.array({{6,15,13},{5,7,18}},np.uint32)
  local b=np.array({-0.5,1.5,-2.25},np.float32)
  local m=np.array({{true,true,true},{true,true,true}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 16 identity')
  assert(o.dtype=='float64','out 16 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 16 shape')
  assert(seqeq(o.strides,{24,8}),'out 16 strides')
  assert(veq(o:tolist(),{{6.5,13.5,15.25},{5.5,5.5,20.25}}),'out 16 values')
end
do -- out-where 17
  local a=np.array({1.5,-2.25,-2.25,-0.5,1.5},np.float32)
  local b=np.array({0.25,-0.5,-0.5,-2.25,-2.25},np.float32)
  local m=np.array({false},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float32)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 17 identity')
  assert(o.dtype=='float32','out 17 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 17 shape')
  assert(seqeq(o.strides,{4}),'out 17 strides')
  assert(veq(o:tolist(),{0.0,1.0,2.0,3.0,4.0}),'out 17 values')
end
do -- out-where 18
  local a=np.array({{{-0.5},{0.25},{3.75}},{{1.5},{-2.25},{-2.25}}},np.float16)
  local b=np.array({{{-5.5,-0.5,0.25,-2.25},{-0.5,-2.25,-0.5,-2.25},{-5.5,-0.5,-0.5,1.5}}},np.float32)
  local m=np.array({{{false}}},np.bool)
  local o=np.array({{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},np.float64)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 18 identity')
  assert(o.dtype=='float64','out 18 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3,4}),'out 18 shape')
  assert(seqeq(o.strides,{96,32,8}),'out 18 strides')
  assert(veq(o:tolist(),{{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}}),'out 18 values')
end
do -- out-where 19
  local a=np.array({{-0.5,-0.5,-2.25},{-0.5,3.75,-0.5}},np.float16)
  local b=np.array({{-9,4,4}},np.int64)
  local m=np.array({{false,true,false},{true,false,true}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},np.float16),{3,2}).T
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 19 identity')
  assert(o.dtype=='float16','out 19 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 19 shape')
  assert(seqeq(o.strides,{2,4}),'out 19 strides')
  assert(veq(o:tolist(),{{0.0,-0.125,4.0},{0.0555419921875,3.0,-0.125}}),'out 19 values')
end
do -- out-where 20
  local a=np.array({3.75,1.5,1.5,0.25,0.25},np.float16)
  local b=np.array({0,-9,0,9,1},np.int32)
  local m=np.array({{false},{true}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0},np.float32),{5,2}).T
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 20 identity')
  assert(o.dtype=='float32','out 20 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,5}),'out 20 shape')
  assert(seqeq(o.strides,{4,8}),'out 20 strides')
  assert(veq(o:tolist(),{{0.0,2.0,4.0,6.0,8.0},{0.0,-13.5,0.0,2.25,0.25}}),'out 20 values')
end
do -- out-where 21
  local a=np.array({-5.5,3.75,-5.5,0.25,-0.5},np.float64)
  local b=np.array({-2.25,3.75,3.75,-0.5,1.5},np.float64)
  local m=np.array({false,true,true,false,true},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float64)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 21 identity')
  assert(o.dtype=='float64','out 21 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 21 shape')
  assert(seqeq(o.strides,{8}),'out 21 strides')
  assert(veq(o:tolist(),{0.0,0.0,-9.25,3.0,-2.0}),'out 21 values')
end
do -- out-where 22
  local a=np.array({{false},{false}},np.bool)
  local b=np.array({{-1,-4,-4}},np.int64)
  local m=np.array({{{false}},{{true}}},np.bool)
  local o=np.array({{{0,1,2},{3,4,5}},{{6,7,8},{9,10,11}}},np.int16)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 22 identity')
  assert(o.dtype=='int16','out 22 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 22 shape')
  assert(seqeq(o.strides,{12,6,2}),'out 22 strides')
  assert(veq(o:tolist(),{{{0,1,2},{3,4,5}},{{-1,-4,-4},{-1,-4,-4}}}),'out 22 values')
end
do -- out-where 23
  local a=np.array({{17},{0}},np.uint8)
  local b=np.array({{true,false,false}},np.bool)
  local m=np.array({{{false}},{{true}}},np.bool)
  local o=np.array({{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{6.0,7.0,8.0},{9.0,10.0,11.0}}},np.float32)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 23 identity')
  assert(o.dtype=='float32','out 23 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 23 shape')
  assert(seqeq(o.strides,{24,12,4}),'out 23 strides')
  assert(veq(o:tolist(),{{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{16.0,17.0,17.0},{255.0,0.0,0.0}}}),'out 23 values')
end
do -- out-where 24
  local a=np.array({{false,false,true},{false,true,true}},np.bool)
  local b=np.array({{true,true,true}},np.bool)
  local m=np.array({{false}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},np.float32),{3,2}).T
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 24 identity')
  assert(o.dtype=='float32','out 24 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 24 shape')
  assert(seqeq(o.strides,{4,8}),'out 24 strides')
  assert(veq(o:tolist(),{{0.0,2.0,4.0},{1.0,3.0,5.0}}),'out 24 values')
end
do -- out-where 25
  local a=np.array({{false},{true}},np.bool)
  local b=np.array({{-1,-1,-1}},np.int8)
  local m=np.array({{false,true,true},{true,false,true}},np.bool)
  local o=np.reshape(np.array({0,1,2,3,4,5},np.int32),{3,2}).T
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 25 identity')
  assert(o.dtype=='int32','out 25 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 25 shape')
  assert(seqeq(o.strides,{4,8}),'out 25 strides')
  assert(veq(o:tolist(),{{0,0,0},{-1,3,-1}}),'out 25 values')
end
do -- out-where 26
  local a=np.array({{{1},{2},{2}},{{9},{-2},{-2}}},np.int32)
  local b=np.array({{{19,15,14,19},{8,19,0,5},{9,1,0,16}}},np.uint32)
  local m=np.array({{{false}}},np.bool)
  local o=np.array({{{0,1,2,3},{4,5,6,7},{8,9,10,11}},{{12,13,14,15},{16,0,1,2},{3,4,5,6}}},np.int64)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 26 identity')
  assert(o.dtype=='int64','out 26 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3,4}),'out 26 shape')
  assert(seqeq(o.strides,{96,32,8}),'out 26 strides')
  assert(veq(o:tolist(),{{{0,1,2,3},{4,5,6,7},{8,9,10,11}},{{12,13,14,15},{16,0,1,2},{3,4,5,6}}}),'out 26 values')
end
do -- out-where 27
  local a=np.array({{9,11,6},{0,9,12}},np.uint8)
  local b=np.array({{6,2,9}},np.uint8)
  local m=np.array({{false}},np.bool)
  local o=np.array({{0,1,2},{3,4,5}},np.int8)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 27 identity')
  assert(o.dtype=='int8','out 27 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 27 shape')
  assert(seqeq(o.strides,{3,1}),'out 27 strides')
  assert(veq(o:tolist(),{{0,1,2},{3,4,5}}),'out 27 values')
end
do -- out-where 28
  local a=np.array({{{-9},{-9},{2}},{{1},{-4},{1}}},np.int8)
  local b=np.array({{{18,3,14,13},{14,3,17,20},{0,9,17,17}}},np.uint32)
  local m=np.array({{{{false}}},{{{true}}}},np.bool)
  local o=np.reshape(np.array({0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,0,1,2,3,4,5,6,7,8,9,10,11,12,13},np.int8),{4,3,2,2}).T
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 28 identity')
  assert(o.dtype=='int8','out 28 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3,4}),'out 28 shape')
  assert(seqeq(o.strides,{1,2,4,12}),'out 28 strides')
  assert(veq(o:tolist(),{{{{0,12,7,2},{4,16,11,6},{8,3,15,10}},{{2,14,9,4},{6,1,13,8},{10,5,0,12}}},{{{9,-6,5,4},{5,-6,8,11},{2,11,19,19}},{{19,4,15,14},{10,-1,13,16},{1,10,18,18}}}}),'out 28 values')
end
do -- out-where 29
  local a=np.array({{{-2.25},{-0.5},{-2.25}},{{-5.5},{0.25},{3.75}}},np.float64)
  local b=np.array({{{-0.5,0.25,0.25,-2.25},{0.25,-2.25,-5.5,1.5},{-5.5,-5.5,-0.5,1.5}}},np.float64)
  local m=np.array({{{{false}}},{{{true}}}},np.bool)
  local o=np.array({{{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},{{{7.0,8.0,9.0,10.0},{11.0,12.0,13.0,14.0},{15.0,16.0,0.0,1.0}},{{2.0,3.0,4.0,5.0},{6.0,7.0,8.0,9.0},{10.0,11.0,12.0,13.0}}}},np.float64)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 29 identity')
  assert(o.dtype=='float64','out 29 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3,4}),'out 29 shape')
  assert(seqeq(o.strides,{192,96,32,8}),'out 29 strides')
  assert(veq(o:tolist(),{{{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},{{{1.125,-0.5625,-0.5625,5.0625},{-0.125,1.125,2.75,-0.75},{12.375,12.375,1.125,-3.375}},{{2.75,-1.375,-1.375,12.375},{0.0625,-0.5625,-1.375,0.375},{-20.625,-20.625,-1.875,5.625}}}}),'out 29 values')
end
do -- out-where 30
  local a=np.array({{3.75,0.25,1.5},{-0.5,3.75,0.25}},np.float16)
  local b=np.array({{3.75,0.25,-5.5}},np.float16)
  local m=np.array({{false}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 30 identity')
  assert(o.dtype=='float64','out 30 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 30 shape')
  assert(seqeq(o.strides,{24,8}),'out 30 strides')
  assert(veq(o:tolist(),{{0.0,1.0,2.0},{3.0,4.0,5.0}}),'out 30 values')
end
do -- out-where 31
  local a=np.array({{false,true,true},{true,false,true}},np.bool)
  local b=np.array({9,19,12},np.uint16)
  local m=np.array({{false}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},np.float32),{3,2}).T
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 31 identity')
  assert(o.dtype=='float32','out 31 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 31 shape')
  assert(seqeq(o.strides,{4,8}),'out 31 strides')
  assert(veq(o:tolist(),{{0.0,2.0,4.0},{1.0,3.0,5.0}}),'out 31 values')
end
do -- out-where 32
  local a=np.array({{3.75,-0.5,3.75},{-5.5,3.75,0.25}},np.float16)
  local b=np.array({9,0,2},np.int16)
  local m=np.array({{false}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 32 identity')
  assert(o.dtype=='float16','out 32 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 32 shape')
  assert(seqeq(o.strides,{6,2}),'out 32 strides')
  assert(veq(o:tolist(),{{0.0,1.0,2.0},{3.0,4.0,5.0}}),'out 32 values')
end
do -- out-where 33
  local a=np.array({{-4,2,4},{2,4,-2}},np.int64)
  local b=np.array({true,true,true},np.bool)
  local m=np.array({{false}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 33 identity')
  assert(o.dtype=='float16','out 33 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 33 shape')
  assert(seqeq(o.strides,{6,2}),'out 33 strides')
  assert(veq(o:tolist(),{{0.0,1.0,2.0},{3.0,4.0,5.0}}),'out 33 values')
end
do -- out-where 34
  local a=np.array({1,2,-9,-1,4},np.int64)
  local b=np.array({4,9,-2,9,2},np.int32)
  local m=np.array({{false},{true}},np.bool)
  local o=np.array({{0.0,1.0,2.0,3.0,4.0},{5.0,6.0,7.0,8.0,9.0}},np.float64)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 34 identity')
  assert(o.dtype=='float64','out 34 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,5}),'out 34 shape')
  assert(seqeq(o.strides,{40,8}),'out 34 strides')
  assert(veq(o:tolist(),{{0.0,1.0,2.0,3.0,4.0},{-3.0,-7.0,-7.0,-10.0,2.0}}),'out 34 values')
end
do -- out-where 35
  local a=np.array({{8,16,3},{17,5,20}},np.uint64)
  local b=np.array({{-5.5,-5.5,3.75}},np.float16)
  local m=np.array({{false}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},np.float16),{3,2}).T
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 35 identity')
  assert(o.dtype=='float16','out 35 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 35 shape')
  assert(seqeq(o.strides,{2,4}),'out 35 strides')
  assert(veq(o:tolist(),{{0.0,2.0,4.0},{1.0,3.0,5.0}}),'out 35 values')
end
do -- out-where 36
  local a=np.array({{{6},{1},{13}},{{8},{4},{12}}},np.uint8)
  local b=np.array({{{6,8,3,10},{11,19,14,8},{14,13,16,7}}},np.uint64)
  local m=np.array({false,true,false,true},np.bool)
  local o=np.array({{{0,1,2,3},{4,5,6,7},{8,9,10,11}},{{12,13,14,15},{16,0,1,2},{3,4,5,6}}},np.uint8)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 36 identity')
  assert(o.dtype=='uint8','out 36 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3,4}),'out 36 shape')
  assert(seqeq(o.strides,{12,4,1}),'out 36 strides')
  assert(veq(o:tolist(),{{{0,14,2,16},{4,20,6,9},{8,26,10,20}},{{12,16,14,18},{16,23,1,12},{3,25,5,19}}}),'out 36 values')
end
do -- out-where 37
  local a=np.array({{-0.5},{-0.5}},np.float32)
  local b=np.array({{3.75,3.75,-5.5}},np.float32)
  local m=np.array({false,true,false},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float32)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 37 identity')
  assert(o.dtype=='float32','out 37 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 37 shape')
  assert(seqeq(o.strides,{12,4}),'out 37 strides')
  assert(veq(o:tolist(),{{0.0,3.25,2.0},{3.0,3.25,5.0}}),'out 37 values')
end
do -- out-where 38
  local a=np.array({true,false,true,false,false},np.bool)
  local b=np.array({5,16,10,17,1},np.uint32)
  local m=np.array({false,true,true,false,true},np.bool)
  local o=np.array({0,1,2,3,4},np.int64)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 38 identity')
  assert(o.dtype=='int64','out 38 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 38 shape')
  assert(seqeq(o.strides,{8}),'out 38 strides')
  assert(veq(o:tolist(),{0,16,11,3,1}),'out 38 values')
end
do -- out-where 39
  local a=np.array({{-2,9,-4},{-2,1,1}},np.int16)
  local b=np.array({8,12,20},np.uint64)
  local m=np.array({{true,true,true},{true,true,true}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 39 identity')
  assert(o.dtype=='float64','out 39 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 39 shape')
  assert(seqeq(o.strides,{24,8}),'out 39 strides')
  assert(veq(o:tolist(),{{-10.0,-3.0,-24.0},{-10.0,-11.0,-19.0}}),'out 39 values')
end
do -- out-where 40
  local a=np.array({{-1,2,-2},{2,0,4}},np.int64)
  local b=np.array({true,true,true},np.bool)
  local m=np.array({false,true,true},np.bool)
  local o=np.array({{0,1,2},{3,4,5}},np.int16)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 40 identity')
  assert(o.dtype=='int16','out 40 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 40 shape')
  assert(seqeq(o.strides,{6,2}),'out 40 strides')
  assert(veq(o:tolist(),{{0,3,-1},{3,1,5}}),'out 40 values')
end
do -- out-where 41
  local a=np.array({{-2.25},{-0.5}},np.float16)
  local b=np.array({{8,6,20}},np.uint8)
  local m=np.array({{{false}},{{true}}},np.bool)
  local o=np.array({{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{6.0,7.0,8.0},{9.0,10.0,11.0}}},np.float32)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 41 identity')
  assert(o.dtype=='float32','out 41 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 41 shape')
  assert(seqeq(o.strides,{24,12,4}),'out 41 strides')
  assert(veq(o:tolist(),{{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{-10.25,-8.25,-22.25},{-8.5,-6.5,-20.5}}}),'out 41 values')
end
do -- out-where 42
  local a=np.array({{1,4,2},{-4,9,1}},np.int64)
  local b=np.array({{-0.5,0.25,1.5}},np.float64)
  local m=np.array({{false}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float32)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 42 identity')
  assert(o.dtype=='float32','out 42 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 42 shape')
  assert(seqeq(o.strides,{12,4}),'out 42 strides')
  assert(veq(o:tolist(),{{0.0,1.0,2.0},{3.0,4.0,5.0}}),'out 42 values')
end
do -- out-where 43
  local a=np.array({{19},{8}},np.uint16)
  local b=np.array({{10,18,9}},np.uint32)
  local m=np.array({{false}},np.bool)
  local o=np.array({{0,1,2},{3,4,5}},np.int64)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 43 identity')
  assert(o.dtype=='int64','out 43 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 43 shape')
  assert(seqeq(o.strides,{24,8}),'out 43 strides')
  assert(veq(o:tolist(),{{0,1,2},{3,4,5}}),'out 43 values')
end
do -- out-where 44
  local a=np.array({{12,2,17},{13,18,10}},np.uint32)
  local b=np.array({0.25,1.5,-5.5},np.float64)
  local m=np.array({{{true}},{{true}}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},np.float16),{3,2,2}).T
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 44 identity')
  assert(o.dtype=='float16','out 44 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 44 shape')
  assert(seqeq(o.strides,{2,4,8}),'out 44 strides')
  assert(veq(o:tolist(),{{{48.0,1.3330078125,-3.091796875},{52.0,12.0,-1.818359375}},{{48.0,1.3330078125,-3.091796875},{52.0,12.0,-1.818359375}}}),'out 44 values')
end
do -- out-where 45
  local a=np.array({{1,-9,-2},{-4,9,0}},np.int64)
  local b=np.array({7,15,10},np.uint32)
  local m=np.array({{false,true,true},{false,true,true}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},np.float16),{3,2}).T
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 45 identity')
  assert(o.dtype=='float16','out 45 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 45 shape')
  assert(seqeq(o.strides,{2,4}),'out 45 strides')
  assert(veq(o:tolist(),{{0.0,-24.0,-12.0},{1.0,-6.0,-10.0}}),'out 45 values')
end
do -- out-where 46
  local a=np.array({{2},{-2}},np.int16)
  local b=np.array({{-4,-1,-2}},np.int16)
  local m=np.array({false,true,false},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 46 identity')
  assert(o.dtype=='float16','out 46 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 46 shape')
  assert(seqeq(o.strides,{6,2}),'out 46 strides')
  assert(veq(o:tolist(),{{0.0,-2.0,2.0},{3.0,2.0,5.0}}),'out 46 values')
end
do -- out-where 47
  local a=np.array({{-1,4,2},{0,1,2}},np.int8)
  local b=np.array({9,-2,-4},np.int16)
  local m=np.array({{false,true,true},{false,true,true}},np.bool)
  local o=np.array({{0,1,2},{3,4,5}},np.int32)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 47 identity')
  assert(o.dtype=='int32','out 47 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 47 shape')
  assert(seqeq(o.strides,{12,4}),'out 47 strides')
  assert(veq(o:tolist(),{{0,-8,-8},{3,-2,-8}}),'out 47 values')
end
do -- out-where 48
  local a=np.array({{{16},{12},{3}},{{8},{20},{19}}},np.uint16)
  local b=np.array({{{13,20,6,18},{18,5,19,3},{3,6,20,2}}},np.uint32)
  local m=np.array({false,true,false,true},np.bool)
  local o=np.reshape(np.array({0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,0,1,2,3,4,5,6},np.uint8),{4,3,2}).T
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 48 identity')
  assert(o.dtype=='uint8','out 48 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3,4}),'out 48 shape')
  assert(seqeq(o.strides,{1,2,6}),'out 48 strides')
  assert(veq(o:tolist(),{{{0,64,12,32},{2,60,14,36},{4,18,16,6}},{{1,160,13,144},{3,100,15,60},{5,114,0,38}}}),'out 48 values')
end
do -- out-where 49
  local a=np.array({{false,false,true},{false,false,true}},np.bool)
  local b=np.array({6,6,19},np.uint64)
  local m=np.array({{{false}},{{true}}},np.bool)
  local o=np.array({{{0,1,2},{3,4,5}},{{6,7,8},{9,10,11}}},np.uint64)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 49 identity')
  assert(o.dtype=='uint64','out 49 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 49 shape')
  assert(seqeq(o.strides,{48,24,8}),'out 49 strides')
  assert(veq(o:tolist(),{{{0,1,2},{3,4,5}},{{18446744073709551610,18446744073709551610,18446744073709551598},{18446744073709551610,18446744073709551610,18446744073709551598}}}),'out 49 values')
end
do -- out-where 50
  local a=np.array({-2.25,1.5,-5.5,-0.5,-5.5},np.float16)
  local b=np.array({0.25,-2.25,0.25,1.5,-0.5},np.float32)
  local m=np.array({true,true,true,true,true},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float64)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 50 identity')
  assert(o.dtype=='float64','out 50 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 50 shape')
  assert(seqeq(o.strides,{8}),'out 50 strides')
  assert(veq(o:tolist(),{-9.0,-0.6666666865348816,-22.0,-0.3333333432674408,11.0}),'out 50 values')
end
do -- out-where 51
  local a=np.array({{-1},{-9}},np.int32)
  local b=np.array({{17,10,9}},np.uint16)
  local m=np.array({false,true,false},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float32)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 51 identity')
  assert(o.dtype=='float32','out 51 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 51 shape')
  assert(seqeq(o.strides,{12,4}),'out 51 strides')
  assert(veq(o:tolist(),{{0.0,-11.0,2.0},{3.0,-19.0,5.0}}),'out 51 values')
end
do -- out-where 52
  local a=np.array({{{4},{6},{6}},{{17},{10},{14}}},np.uint16)
  local b=np.array({{{false,false,false,false},{true,false,false,false},{false,true,true,false}}},np.bool)
  local m=np.array({false,true,true,false},np.bool)
  local o=np.array({{{0,1,2,3},{4,5,6,7},{8,9,10,11}},{{12,13,14,15},{16,0,1,2},{3,4,5,6}}},np.int8)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 52 identity')
  assert(o.dtype=='int8','out 52 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3,4}),'out 52 shape')
  assert(seqeq(o.strides,{12,4,1}),'out 52 strides')
  assert(veq(o:tolist(),{{{0,4,4,3},{4,6,6,7},{8,5,5,11}},{{12,17,17,15},{16,10,10,2},{3,13,13,6}}}),'out 52 values')
end
do -- out-where 53
  local a=np.array({{12,8,14},{7,0,0}},np.uint64)
  local b=np.array({{-5.5,0.25,3.75}},np.float64)
  local m=np.array({false,true,false},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 53 identity')
  assert(o.dtype=='float16','out 53 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 53 shape')
  assert(seqeq(o.strides,{6,2}),'out 53 strides')
  assert(veq(o:tolist(),{{0.0,2.0,2.0},{3.0,0.0,5.0}}),'out 53 values')
end
do -- out-where 54
  local a=np.array({{-5.5},{3.75}},np.float64)
  local b=np.array({{9,13,4}},np.uint64)
  local m=np.array({false,true,true},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},np.float64),{3,2}).T
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 54 identity')
  assert(o.dtype=='float64','out 54 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 54 shape')
  assert(seqeq(o.strides,{8,16}),'out 54 strides')
  assert(veq(o:tolist(),{{0.0,-0.4230769230769231,-1.375},{1.0,0.28846153846153844,0.9375}}),'out 54 values')
end
do -- out-where 55
  local a=np.array({{-1},{-1}},np.int8)
  local b=np.array({{false,true,false}},np.bool)
  local m=np.array({{false,true,true},{true,false,true}},np.bool)
  local o=np.array({{0,1,2},{3,4,5}},np.int8)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 55 identity')
  assert(o.dtype=='int8','out 55 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 55 shape')
  assert(seqeq(o.strides,{3,1}),'out 55 strides')
  assert(veq(o:tolist(),{{0,-2,-1},{-1,4,-1}}),'out 55 values')
end
do -- out-where 56
  local a=np.array({{{4},{-9},{0}},{{-2},{9},{-1}}},np.int8)
  local b=np.array({{{0.25,1.5,0.25,1.5},{-0.5,1.5,1.5,-5.5},{-2.25,-0.5,1.5,-2.25}}},np.float32)
  local m=np.array({{{{false}}},{{{true}}}},np.bool)
  local o=np.array({{{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},{{{7.0,8.0,9.0,10.0},{11.0,12.0,13.0,14.0},{15.0,16.0,0.0,1.0}},{{2.0,3.0,4.0,5.0},{6.0,7.0,8.0,9.0},{10.0,11.0,12.0,13.0}}}},np.float32)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 56 identity')
  assert(o.dtype=='float32','out 56 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3,4}),'out 56 shape')
  assert(seqeq(o.strides,{96,48,16,4}),'out 56 strides')
  assert(veq(o:tolist(),{{{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},{{{4.25,5.5,4.25,5.5},{-9.5,-7.5,-7.5,-14.5},{-2.25,-0.5,1.5,-2.25}},{{-1.75,-0.5,-1.75,-0.5},{8.5,10.5,10.5,3.5},{-3.25,-1.5,0.5,-3.25}}}}),'out 56 values')
end
do -- out-where 57
  local a=np.array({{4,18,18},{16,5,1}},np.uint64)
  local b=np.array({{true,true,true}},np.bool)
  local m=np.array({{{false}},{{true}}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},np.float16),{3,2,2}).T
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 57 identity')
  assert(o.dtype=='float16','out 57 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 57 shape')
  assert(seqeq(o.strides,{2,4,8}),'out 57 strides')
  assert(veq(o:tolist(),{{{0.0,4.0,8.0},{2.0,6.0,10.0}},{{4.0,18.0,18.0},{16.0,5.0,1.0}}}),'out 57 values')
end
do -- out-where 58
  local a=np.array({{-2.25},{0.25}},np.float16)
  local b=np.array({{12,0,20}},np.uint64)
  local m=np.array({{{false}},{{true}}},np.bool)
  local o=np.array({{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{6.0,7.0,8.0},{9.0,10.0,11.0}}},np.float64)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 58 identity')
  assert(o.dtype=='float64','out 58 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 58 shape')
  assert(seqeq(o.strides,{48,24,8}),'out 58 strides')
  assert(veq(o:tolist(),{{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{-27.0,-0.0,-45.0},{3.0,0.0,5.0}}}),'out 58 values')
end
do -- out-where 59
  local a=np.array({{0.25,-5.5,0.25},{-0.5,1.5,-5.5}},np.float32)
  local b=np.array({false,false,true},np.bool)
  local m=np.array({{false}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},np.float32),{3,2}).T
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 59 identity')
  assert(o.dtype=='float32','out 59 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 59 shape')
  assert(seqeq(o.strides,{4,8}),'out 59 strides')
  assert(veq(o:tolist(),{{0.0,2.0,4.0},{1.0,3.0,5.0}}),'out 59 values')
end
do -- out-where 60
  local a=np.array({{2,-4,2},{-4,0,2}},np.int64)
  local b=np.array({-4,9,-1},np.int8)
  local m=np.array({false,true,true},np.bool)
  local o=np.array({{0,1,2},{3,4,5}},np.int16)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 60 identity')
  assert(o.dtype=='int16','out 60 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 60 shape')
  assert(seqeq(o.strides,{6,2}),'out 60 strides')
  assert(veq(o:tolist(),{{0,-36,-2},{3,0,-2}}),'out 60 values')
end
do -- out-where 61
  local a=np.array({{-2},{-1}},np.int64)
  local b=np.array({{2,-2,-4}},np.int8)
  local m=np.array({{false,true,true},{false,true,true}},np.bool)
  local o=np.array({{0,1,2},{3,4,5}},np.int8)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 61 identity')
  assert(o.dtype=='int8','out 61 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 61 shape')
  assert(seqeq(o.strides,{3,1}),'out 61 strides')
  assert(veq(o:tolist(),{{0,4,8},{3,2,4}}),'out 61 values')
end
do -- out-where 62
  local a=np.array({{{-2.25},{3.75},{1.5}},{{-2.25},{0.25},{-0.5}}},np.float32)
  local b=np.array({{{1,9,1,1},{-4,-9,1,-2},{-4,4,2,2}}},np.int64)
  local m=np.array({{{false}}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,0.0,1.0,2.0,3.0,4.0,5.0,6.0},np.float16),{4,3,2}).T
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 62 identity')
  assert(o.dtype=='float16','out 62 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3,4}),'out 62 shape')
  assert(seqeq(o.strides,{2,4,12}),'out 62 strides')
  assert(veq(o:tolist(),{{{0.0,6.0,12.0,1.0},{2.0,8.0,14.0,3.0},{4.0,10.0,16.0,5.0}},{{1.0,7.0,13.0,2.0},{3.0,9.0,15.0,4.0},{5.0,11.0,0.0,6.0}}}),'out 62 values')
end
do -- out-where 63
  local a=np.array({{{true},{false},{true}},{{false},{false},{false}}},np.bool)
  local b=np.array({{{6,12,8,7},{0,3,0,13},{4,20,8,2}}},np.uint32)
  local m=np.array({{{{false}}},{{{true}}}},np.bool)
  local o=np.array({{{{0,1,2,3},{4,5,6,7},{8,9,10,11}},{{12,13,14,15},{16,0,1,2},{3,4,5,6}}},{{{7,8,9,10},{11,12,13,14},{15,16,0,1}},{{2,3,4,5},{6,7,8,9},{10,11,12,13}}}},np.uint16)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 63 identity')
  assert(o.dtype=='uint16','out 63 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3,4}),'out 63 shape')
  assert(seqeq(o.strides,{48,24,8,2}),'out 63 strides')
  assert(veq(o:tolist(),{{{{0,1,2,3},{4,5,6,7},{8,9,10,11}},{{12,13,14,15},{16,0,1,2},{3,4,5,6}}},{{{65531,65525,65529,65530},{0,65533,0,65523},{65533,65517,65529,65535}},{{65530,65524,65528,65529},{0,65533,0,65523},{65532,65516,65528,65534}}}}),'out 63 values')
end
do -- out-where 64
  local a=np.array({17,17,12,0,7},np.uint8)
  local b=np.array({14,10,0,14,2},np.uint8)
  local m=np.array({{false},{true}},np.bool)
  local o=np.array({{0,1,2,3,4},{5,6,7,8,9}},np.int16)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 64 identity')
  assert(o.dtype=='int16','out 64 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,5}),'out 64 shape')
  assert(seqeq(o.strides,{10,2}),'out 64 strides')
  assert(veq(o:tolist(),{{0,1,2,3,4},{31,27,12,14,9}}),'out 64 values')
end
do -- out-where 65
  local a=np.array({{-2,-4,4},{1,2,-2}},np.int32)
  local b=np.array({{8,19,20}},np.uint64)
  local m=np.array({false,true,true},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},np.float16),{3,2}).T
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 65 identity')
  assert(o.dtype=='float16','out 65 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 65 shape')
  assert(seqeq(o.strides,{2,4}),'out 65 strides')
  assert(veq(o:tolist(),{{0.0,15.0,24.0},{1.0,21.0,18.0}}),'out 65 values')
end
do -- out-where 66
  local a=np.array({{2,2,0},{-9,4,2}},np.int8)
  local b=np.array({-0.5,-5.5,1.5},np.float16)
  local m=np.array({{false}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},np.float64),{3,2}).T
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 66 identity')
  assert(o.dtype=='float64','out 66 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 66 shape')
  assert(seqeq(o.strides,{8,16}),'out 66 strides')
  assert(veq(o:tolist(),{{0.0,2.0,4.0},{1.0,3.0,5.0}}),'out 66 values')
end
do -- out-where 67
  local a=np.array({5,11,8,18,3},np.uint64)
  local b=np.array({false,false,false,false,false},np.bool)
  local m=np.array({{false},{true}},np.bool)
  local o=np.reshape(np.array({0,1,2,3,4,5,6,7,8,9},np.uint64),{5,2}).T
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 67 identity')
  assert(o.dtype=='uint64','out 67 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,5}),'out 67 shape')
  assert(seqeq(o.strides,{8,16}),'out 67 strides')
  assert(veq(o:tolist(),{{0,2,4,6,8},{0,0,0,0,0}}),'out 67 values')
end
do -- out-where 68
  local a=np.array({9,3,19,14,12},np.uint64)
  local b=np.array({7,17,15,9,13},np.uint16)
  local m=np.array({true,true,true,true,true},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float64)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 68 identity')
  assert(o.dtype=='float64','out 68 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 68 shape')
  assert(seqeq(o.strides,{8}),'out 68 strides')
  assert(veq(o:tolist(),{1.2857142857142858,0.17647058823529413,1.2666666666666666,1.5555555555555556,0.9230769230769231}),'out 68 values')
end
do -- out-where 69
  local a=np.array({{15,8,12},{0,12,10}},np.uint32)
  local b=np.array({{-1,2,-9}},np.int16)
  local m=np.array({false,true,true},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float32)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 69 identity')
  assert(o.dtype=='float32','out 69 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 69 shape')
  assert(seqeq(o.strides,{12,4}),'out 69 strides')
  assert(veq(o:tolist(),{{0.0,4.0,-1.3333333730697632},{3.0,6.0,-1.1111111640930176}}),'out 69 values')
end
do -- out-where 70
  local a=np.array({false,true,false,false,false},np.bool)
  local b=np.array({4,14,16,14,10},np.uint64)
  local m=np.array({true,true,true,true,true},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float64)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 70 identity')
  assert(o.dtype=='float64','out 70 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 70 shape')
  assert(seqeq(o.strides,{8}),'out 70 strides')
  assert(veq(o:tolist(),{1.8446744073709552e+19,1.8446744073709552e+19,1.8446744073709552e+19,1.8446744073709552e+19,1.8446744073709552e+19}),'out 70 values')
end
do -- out-where 71
  local a=np.array({{16},{16}},np.uint64)
  local b=np.array({{-4,-4,1}},np.int8)
  local m=np.array({{{false}},{{true}}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},np.float64),{3,2,2}).T
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 71 identity')
  assert(o.dtype=='float64','out 71 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 71 shape')
  assert(seqeq(o.strides,{8,16,32}),'out 71 strides')
  assert(veq(o:tolist(),{{{0.0,4.0,8.0},{2.0,6.0,10.0}},{{-4.0,-4.0,16.0},{-4.0,-4.0,16.0}}}),'out 71 values')
end
do -- out-where 72
  local a=np.array({{{0},{9},{-1}},{{-4},{4},{1}}},np.int32)
  local b=np.array({{{-2,-2,-4,-2},{-1,2,2,4},{-1,-2,-2,9}}},np.int8)
  local m=np.array({{{false}}},np.bool)
  local o=np.array({{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},np.float16)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 72 identity')
  assert(o.dtype=='float16','out 72 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3,4}),'out 72 shape')
  assert(seqeq(o.strides,{24,8,2}),'out 72 strides')
  assert(veq(o:tolist(),{{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}}),'out 72 values')
end
do -- out-where 73
  local a=np.array({{3.75,0.25,1.5},{-2.25,1.5,0.25}},np.float64)
  local b=np.array({4,-2,9},np.int8)
  local m=np.array({{false,true,false},{true,false,true}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 73 identity')
  assert(o.dtype=='float16','out 73 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 73 shape')
  assert(seqeq(o.strides,{6,2}),'out 73 strides')
  assert(veq(o:tolist(),{{0.0,-0.5,2.0},{-9.0,4.0,2.25}}),'out 73 values')
end
do -- out-where 74
  local a=np.array({2,18,0,10,5},np.uint64)
  local b=np.array({1,13,6,8,13},np.uint64)
  local m=np.array({true},np.bool)
  local o=np.array({0,1,2,3,4},np.uint8)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 74 identity')
  assert(o.dtype=='uint8','out 74 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 74 shape')
  assert(seqeq(o.strides,{1}),'out 74 strides')
  assert(veq(o:tolist(),{2,234,0,80,65}),'out 74 values')
end
do -- out-where 75
  local a=np.array({-9,0,1,4,-9},np.int16)
  local b=np.array({0,-9,0,0,-2},np.int16)
  local m=np.array({{false},{true}},np.bool)
  local o=np.array({{0.0,1.0,2.0,3.0,4.0},{5.0,6.0,7.0,8.0,9.0}},np.float64)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 75 identity')
  assert(o.dtype=='float64','out 75 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,5}),'out 75 shape')
  assert(seqeq(o.strides,{40,8}),'out 75 strides')
  assert(veq(o:tolist(),{{0.0,1.0,2.0,3.0,4.0},{-9.0,9.0,1.0,4.0,-7.0}}),'out 75 values')
end
do -- out-where 76
  local a=np.array({{1.5,1.5,-0.5},{-0.5,0.25,3.75}},np.float16)
  local b=np.array({{2,1,1}},np.int64)
  local m=np.array({{false,true,true},{false,true,true}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 76 identity')
  assert(o.dtype=='float16','out 76 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 76 shape')
  assert(seqeq(o.strides,{6,2}),'out 76 strides')
  assert(veq(o:tolist(),{{0.0,1.5,-0.5},{3.0,0.25,3.75}}),'out 76 values')
end
do -- out-where 77
  local a=np.array({{11,5,5},{1,6,16}},np.uint8)
  local b=np.array({3.75,3.75,3.75},np.float16)
  local m=np.array({{false}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 77 identity')
  assert(o.dtype=='float64','out 77 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 77 shape')
  assert(seqeq(o.strides,{24,8}),'out 77 strides')
  assert(veq(o:tolist(),{{0.0,1.0,2.0},{3.0,4.0,5.0}}),'out 77 values')
end
do -- out-where 78
  local a=np.array({{{4},{2},{-1}},{{9},{-4},{4}}},np.int8)
  local b=np.array({{{3.75,-2.25,-5.5,3.75},{1.5,-5.5,-2.25,3.75},{-0.5,3.75,0.25,0.25}}},np.float64)
  local m=np.array({{{false}}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,0.0,1.0,2.0,3.0,4.0,5.0,6.0},np.float16),{4,3,2}).T
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 78 identity')
  assert(o.dtype=='float16','out 78 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3,4}),'out 78 shape')
  assert(seqeq(o.strides,{2,4,12}),'out 78 strides')
  assert(veq(o:tolist(),{{{0.0,6.0,12.0,1.0},{2.0,8.0,14.0,3.0},{4.0,10.0,16.0,5.0}},{{1.0,7.0,13.0,2.0},{3.0,9.0,15.0,4.0},{5.0,11.0,0.0,6.0}}}),'out 78 values')
end
do -- out-where 79
  local a=np.array({4,-4,-4,1,2},np.int16)
  local b=np.array({14,5,13,6,18},np.uint32)
  local m=np.array({true,true,true,true,true},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float64)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 79 identity')
  assert(o.dtype=='float64','out 79 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 79 shape')
  assert(seqeq(o.strides,{8}),'out 79 strides')
  assert(veq(o:tolist(),{0.2857142857142857,-0.8,-0.3076923076923077,0.16666666666666666,0.1111111111111111}),'out 79 values')
end
do -- out-where 80
  local a=np.array({4,18,12,0,1},np.uint64)
  local b=np.array({-4,1,-1,1,-9},np.int16)
  local m=np.array({{false},{true}},np.bool)
  local o=np.array({{0.0,1.0,2.0,3.0,4.0},{5.0,6.0,7.0,8.0,9.0}},np.float16)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 80 identity')
  assert(o.dtype=='float16','out 80 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,5}),'out 80 shape')
  assert(seqeq(o.strides,{10,2}),'out 80 strides')
  assert(veq(o:tolist(),{{0.0,1.0,2.0,3.0,4.0},{0.0,19.0,11.0,1.0,-8.0}}),'out 80 values')
end
do -- out-where 81
  local a=np.array({9,2,-2,2,-1},np.int16)
  local b=np.array({2,4,-9,9,1},np.int32)
  local m=np.array({false,true,true,false,true},np.bool)
  local o=np.array({0,1,2,3,4},np.int32)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 81 identity')
  assert(o.dtype=='int32','out 81 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 81 shape')
  assert(seqeq(o.strides,{4}),'out 81 strides')
  assert(veq(o:tolist(),{0,-2,7,3,-2}),'out 81 values')
end
do -- out-where 82
  local a=np.array({{3.75,1.5,3.75},{-5.5,-5.5,3.75}},np.float64)
  local b=np.array({18,2,3},np.uint32)
  local m=np.array({{false}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 82 identity')
  assert(o.dtype=='float64','out 82 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 82 shape')
  assert(seqeq(o.strides,{24,8}),'out 82 strides')
  assert(veq(o:tolist(),{{0.0,1.0,2.0},{3.0,4.0,5.0}}),'out 82 values')
end
do -- out-where 83
  local a=np.array({{9,-2,-1},{-4,0,4}},np.int64)
  local b=np.array({true,true,true},np.bool)
  local m=np.array({{false,true,false},{true,false,true}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 83 identity')
  assert(o.dtype=='float16','out 83 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 83 shape')
  assert(seqeq(o.strides,{6,2}),'out 83 strides')
  assert(veq(o:tolist(),{{0.0,-2.0,2.0},{-4.0,4.0,4.0}}),'out 83 values')
end
do -- out-where 84
  local a=np.array({{-4,-4,4},{-2,-9,4}},np.int32)
  local b=np.array({0.25,-2.25,0.25},np.float16)
  local m=np.array({true,true,true},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 84 identity')
  assert(o.dtype=='float64','out 84 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 84 shape')
  assert(seqeq(o.strides,{24,8}),'out 84 strides')
  assert(veq(o:tolist(),{{-1.0,9.0,1.0},{-0.5,20.25,1.0}}),'out 84 values')
end
do -- out-where 85
  local a=np.array({{-0.5,-5.5,0.25},{-5.5,-2.25,0.25}},np.float64)
  local b=np.array({{3.75,-5.5,-0.5}},np.float16)
  local m=np.array({{false,true,true},{false,true,true}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},np.float64),{3,2}).T
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 85 identity')
  assert(o.dtype=='float64','out 85 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 85 shape')
  assert(seqeq(o.strides,{8,16}),'out 85 strides')
  assert(veq(o:tolist(),{{0.0,30.25,-0.125},{1.0,12.375,-0.125}}),'out 85 values')
end
do -- out-where 86
  local a=np.array({{18},{18}},np.uint32)
  local b=np.array({{4,-2,4}},np.int16)
  local m=np.array({false,true,true},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 86 identity')
  assert(o.dtype=='float16','out 86 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 86 shape')
  assert(seqeq(o.strides,{6,2}),'out 86 strides')
  assert(veq(o:tolist(),{{0.0,16.0,22.0},{3.0,16.0,22.0}}),'out 86 values')
end
do -- out-where 87
  local a=np.array({{9,14,19},{1,4,0}},np.uint32)
  local b=np.array({{0.25,-5.5,-0.5}},np.float16)
  local m=np.array({{false,true,false},{true,false,true}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},np.float16),{3,2}).T
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 87 identity')
  assert(o.dtype=='float16','out 87 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 87 shape')
  assert(seqeq(o.strides,{2,4}),'out 87 strides')
  assert(veq(o:tolist(),{{0.0,-77.0,4.0},{0.25,3.0,-0.0}}),'out 87 values')
end
do -- out-where 88
  local a=np.array({{-2.25},{-2.25}},np.float16)
  local b=np.array({{-5.5,-2.25,0.25}},np.float64)
  local m=np.array({{false,true,true},{true,false,true}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 88 identity')
  assert(o.dtype=='float16','out 88 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 88 shape')
  assert(seqeq(o.strides,{6,2}),'out 88 strides')
  assert(veq(o:tolist(),{{0.0,1.0,-9.0},{0.4091796875,4.0,-9.0}}),'out 88 values')
end
do -- out-where 89
  local a=np.array({2,-2,-2,-2,1},np.int16)
  local b=np.array({7,3,7,0,18},np.uint8)
  local m=np.array({false,true,true,false,true},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float32)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 89 identity')
  assert(o.dtype=='float32','out 89 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 89 shape')
  assert(seqeq(o.strides,{4}),'out 89 strides')
  assert(veq(o:tolist(),{0.0,-6.0,-14.0,3.0,18.0}),'out 89 values')
end
do -- out-where 90
  local a=np.array({{-2.25,-5.5,0.25},{0.25,-2.25,1.5}},np.float16)
  local b=np.array({{false,false,true}},np.bool)
  local m=np.array({{{true}},{{true}}},np.bool)
  local o=np.array({{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{6.0,7.0,8.0},{9.0,10.0,11.0}}},np.float32)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 90 identity')
  assert(o.dtype=='float32','out 90 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 90 shape')
  assert(seqeq(o.strides,{24,12,4}),'out 90 strides')
  assert(veq(o:tolist(),{{{-2.25,-5.5,-0.75},{0.25,-2.25,0.5}},{{-2.25,-5.5,-0.75},{0.25,-2.25,0.5}}}),'out 90 values')
end
do -- out-where 91
  local a=np.array({{{9},{1},{-9}},{{9},{-4},{-1}}},np.int64)
  local b=np.array({{{9,-9,2,4},{4,4,-2,9},{-2,-1,-4,9}}},np.int64)
  local m=np.array({false,true,true,false},np.bool)
  local o=np.array({{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},np.float64)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 91 identity')
  assert(o.dtype=='float64','out 91 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3,4}),'out 91 shape')
  assert(seqeq(o.strides,{96,32,8}),'out 91 strides')
  assert(veq(o:tolist(),{{{0.0,-1.0,4.5,3.0},{4.0,0.25,-0.5,7.0},{8.0,9.0,2.25,11.0}},{{12.0,-1.0,4.5,15.0},{16.0,-1.0,2.0,2.0},{3.0,1.0,0.25,6.0}}}),'out 91 values')
end
do -- out-where 92
  local a=np.array({{2,-2,-2},{9,-2,9}},np.int64)
  local b=np.array({1,-9,-9},np.int16)
  local m=np.array({{{false}},{{true}}},np.bool)
  local o=np.reshape(np.array({0,1,2,3,4,5,6,7,8,9,10,11},np.int32),{3,2,2}).T
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 92 identity')
  assert(o.dtype=='int32','out 92 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 92 shape')
  assert(seqeq(o.strides,{4,8,16}),'out 92 strides')
  assert(veq(o:tolist(),{{{0,4,8},{2,6,10}},{{1,7,7},{8,7,18}}}),'out 92 values')
end
do -- out-where 93
  local a=np.array({{-1,-9,9},{-1,-1,-1}},np.int8)
  local b=np.array({2,7,2},np.uint64)
  local m=np.array({{{false}},{{true}}},np.bool)
  local o=np.array({{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{6.0,7.0,8.0},{9.0,10.0,11.0}}},np.float16)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 93 identity')
  assert(o.dtype=='float16','out 93 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 93 shape')
  assert(seqeq(o.strides,{12,6,2}),'out 93 strides')
  assert(veq(o:tolist(),{{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{-0.5,-1.2861328125,4.5},{-0.5,-0.142822265625,-0.5}}}),'out 93 values')
end
do -- out-where 94
  local a=np.array({{4,2,-2},{0,0,-1}},np.int16)
  local b=np.array({2,-4,9},np.int32)
  local m=np.array({false,true,false},np.bool)
  local o=np.reshape(np.array({0,1,2,3,4,5},np.int32),{3,2}).T
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 94 identity')
  assert(o.dtype=='int32','out 94 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 94 shape')
  assert(seqeq(o.strides,{4,8}),'out 94 strides')
  assert(veq(o:tolist(),{{0,6,4},{1,4,5}}),'out 94 values')
end
do -- out-where 95
  local a=np.array({{-2,0,0},{2,9,-9}},np.int64)
  local b=np.array({{-9,9,-9}},np.int64)
  local m=np.array({{false,true,true},{true,false,true}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 95 identity')
  assert(o.dtype=='float64','out 95 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 95 shape')
  assert(seqeq(o.strides,{24,8}),'out 95 strides')
  assert(veq(o:tolist(),{{0.0,0.0,0.0},{-18.0,4.0,81.0}}),'out 95 values')
end
do -- out-where 96
  local a=np.array({{9},{-9}},np.int16)
  local b=np.array({{-9,0,9}},np.int8)
  local m=np.array({{{false}},{{true}}},np.bool)
  local o=np.array({{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{6.0,7.0,8.0},{9.0,10.0,11.0}}},np.float64)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 96 identity')
  assert(o.dtype=='float64','out 96 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 96 shape')
  assert(seqeq(o.strides,{48,24,8}),'out 96 strides')
  assert(veq(o:tolist(),{{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{0.0,9.0,18.0},{-18.0,-9.0,0.0}}}),'out 96 values')
end
do -- out-where 97
  local a=np.array({{9,2,19},{20,0,20}},np.uint32)
  local b=np.array({3.75,0.25,-5.5},np.float32)
  local m=np.array({{true,true,true},{true,true,true}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 97 identity')
  assert(o.dtype=='float16','out 97 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 97 shape')
  assert(seqeq(o.strides,{6,2}),'out 97 strides')
  assert(veq(o:tolist(),{{33.75,0.5,-104.5},{75.0,0.0,-110.0}}),'out 97 values')
end
do -- out-where 98
  local a=np.array({false,false,true,true,false},np.bool)
  local b=np.array({-0.5,-0.5,1.5,-2.25,0.25},np.float16)
  local m=np.array({false,true,false,true,false},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float32)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 98 identity')
  assert(o.dtype=='float32','out 98 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 98 shape')
  assert(seqeq(o.strides,{4}),'out 98 strides')
  assert(veq(o:tolist(),{0.0,0.5,2.0,3.25,4.0}),'out 98 values')
end
do -- out-where 99
  local a=np.array({{0.25},{-2.25}},np.float32)
  local b=np.array({{true,true,true}},np.bool)
  local m=np.array({false,true,true},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 99 identity')
  assert(o.dtype=='float16','out 99 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 99 shape')
  assert(seqeq(o.strides,{6,2}),'out 99 strides')
  assert(veq(o:tolist(),{{0.0,0.25,0.25},{3.0,-2.25,-2.25}}),'out 99 values')
end
do -- out-where 100
  local a=np.array({{{2},{1},{-9}},{{-4},{-2},{-1}}},np.int16)
  local b=np.array({{{11,18,16,10},{2,15,2,12},{1,3,2,7}}},np.uint8)
  local m=np.array({{{false}}},np.bool)
  local o=np.array({{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},np.float16)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 100 identity')
  assert(o.dtype=='float16','out 100 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3,4}),'out 100 shape')
  assert(seqeq(o.strides,{24,8,2}),'out 100 strides')
  assert(veq(o:tolist(),{{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}}),'out 100 values')
end
do -- out-where 101
  local a=np.array({{9},{4}},np.uint8)
  local b=np.array({{-5.5,3.75,-0.5}},np.float32)
  local m=np.array({{{false}},{{true}}},np.bool)
  local o=np.array({{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{6.0,7.0,8.0},{9.0,10.0,11.0}}},np.float64)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 101 identity')
  assert(o.dtype=='float64','out 101 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 101 shape')
  assert(seqeq(o.strides,{48,24,8}),'out 101 strides')
  assert(veq(o:tolist(),{{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{-49.5,33.75,-4.5},{-22.0,15.0,-2.0}}}),'out 101 values')
end
do -- out-where 102
  local a=np.array({{-5.5,-5.5,0.25},{-2.25,3.75,-5.5}},np.float64)
  local b=np.array({{4,19,2}},np.uint64)
  local m=np.array({true,true,true},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 102 identity')
  assert(o.dtype=='float64','out 102 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 102 shape')
  assert(seqeq(o.strides,{24,8}),'out 102 strides')
  assert(veq(o:tolist(),{{-1.375,-0.2894736842105263,0.125},{-0.5625,0.19736842105263158,-2.75}}),'out 102 values')
end
do -- out-where 103
  local a=np.array({{-4,-4,-2},{-2,-9,4}},np.int64)
  local b=np.array({-0.5,0.25,0.25},np.float16)
  local m=np.array({{{false}},{{true}}},np.bool)
  local o=np.array({{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{6.0,7.0,8.0},{9.0,10.0,11.0}}},np.float16)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 103 identity')
  assert(o.dtype=='float16','out 103 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 103 shape')
  assert(seqeq(o.strides,{12,6,2}),'out 103 strides')
  assert(veq(o:tolist(),{{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{-4.5,-3.75,-1.75},{-2.5,-8.75,4.25}}}),'out 103 values')
end
do -- out-where 104
  local a=np.array({{{11},{8},{20}},{{4},{9},{16}}},np.uint8)
  local b=np.array({{{-0.5,-0.5,3.75,1.5},{-2.25,0.25,-0.5,-0.5},{0.25,0.25,1.5,0.25}}},np.float32)
  local m=np.array({{{{false}}},{{{true}}}},np.bool)
  local o=np.array({{{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},{{{7.0,8.0,9.0,10.0},{11.0,12.0,13.0,14.0},{15.0,16.0,0.0,1.0}},{{2.0,3.0,4.0,5.0},{6.0,7.0,8.0,9.0},{10.0,11.0,12.0,13.0}}}},np.float16)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 104 identity')
  assert(o.dtype=='float16','out 104 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3,4}),'out 104 shape')
  assert(seqeq(o.strides,{48,24,8,2}),'out 104 strides')
  assert(veq(o:tolist(),{{{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},{{{-5.5,-5.5,41.25,16.5},{-18.0,2.0,-4.0,-4.0},{5.0,5.0,30.0,5.0}},{{-2.0,-2.0,15.0,6.0},{-20.25,2.25,-4.5,-4.5},{4.0,4.0,24.0,4.0}}}}),'out 104 values')
end
do -- out-where 105
  local a=np.array({{16,17,6},{8,20,6}},np.uint8)
  local b=np.array({20,8,4},np.uint64)
  local m=np.array({{{true}},{{true}}},np.bool)
  local o=np.array({{{0,1,2},{3,4,5}},{{6,7,8},{9,10,11}}},np.uint16)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 105 identity')
  assert(o.dtype=='uint16','out 105 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 105 shape')
  assert(seqeq(o.strides,{12,6,2}),'out 105 strides')
  assert(veq(o:tolist(),{{{65532,9,2},{65524,12,2}},{{65532,9,2},{65524,12,2}}}),'out 105 values')
end
do -- out-where 106
  local a=np.array({{-2.25,-2.25,0.25},{-2.25,1.5,-0.5}},np.float32)
  local b=np.array({{-9,9,-4}},np.int8)
  local m=np.array({false,true,false},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},np.float32),{3,2}).T
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 106 identity')
  assert(o.dtype=='float32','out 106 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 106 shape')
  assert(seqeq(o.strides,{4,8}),'out 106 strides')
  assert(veq(o:tolist(),{{0.0,-11.25,4.0},{1.0,-7.5,5.0}}),'out 106 values')
end
do -- out-where 107
  local a=np.array({{-1},{1}},np.int8)
  local b=np.array({{1,0,-4}},np.int64)
  local m=np.array({false,true,true},np.bool)
  local o=np.array({{0,1,2},{3,4,5}},np.int64)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 107 identity')
  assert(o.dtype=='int64','out 107 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 107 shape')
  assert(seqeq(o.strides,{24,8}),'out 107 strides')
  assert(veq(o:tolist(),{{0,-1,3},{3,1,5}}),'out 107 values')
end
do -- out-where 108
  local a=np.array({0,1,16,5,16},np.uint32)
  local b=np.array({-5.5,3.75,-0.5,0.25,-0.5},np.float32)
  local m=np.array({false,true,false,true,false},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float32)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 108 identity')
  assert(o.dtype=='float32','out 108 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 108 shape')
  assert(seqeq(o.strides,{4}),'out 108 strides')
  assert(veq(o:tolist(),{0.0,-2.75,2.0,4.75,4.0}),'out 108 values')
end
do -- out-where 109
  local a=np.array({{-2.25},{-5.5}},np.float64)
  local b=np.array({{20,6,11}},np.uint32)
  local m=np.array({{{true}},{{true}}},np.bool)
  local o=np.array({{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{6.0,7.0,8.0},{9.0,10.0,11.0}}},np.float64)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 109 identity')
  assert(o.dtype=='float64','out 109 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 109 shape')
  assert(seqeq(o.strides,{48,24,8}),'out 109 strides')
  assert(veq(o:tolist(),{{{-0.1125,-0.375,-0.20454545454545456},{-0.275,-0.9166666666666666,-0.5}},{{-0.1125,-0.375,-0.20454545454545456},{-0.275,-0.9166666666666666,-0.5}}}),'out 109 values')
end
do -- out-where 110
  local a=np.array({{13,9,12},{1,8,6}},np.uint64)
  local b=np.array({{11,9,14}},np.uint16)
  local m=np.array({{false,true,true},{false,true,true}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},np.float32),{3,2}).T
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 110 identity')
  assert(o.dtype=='float32','out 110 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 110 shape')
  assert(seqeq(o.strides,{4,8}),'out 110 strides')
  assert(veq(o:tolist(),{{0.0,0.0,1.8446744073709552e+19},{1.0,1.8446744073709552e+19,1.8446744073709552e+19}}),'out 110 values')
end
do -- out-where 111
  local a=np.array({false,true,false,false,true},np.bool)
  local b=np.array({-4,0,4,-4,4},np.int32)
  local m=np.array({false},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float64)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 111 identity')
  assert(o.dtype=='float64','out 111 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 111 shape')
  assert(seqeq(o.strides,{8}),'out 111 strides')
  assert(veq(o:tolist(),{0.0,1.0,2.0,3.0,4.0}),'out 111 values')
end
do -- out-where 112
  local a=np.array({{-1,-1,-4},{9,0,-9}},np.int16)
  local b=np.array({{17,19,4}},np.uint32)
  local m=np.array({{false}},np.bool)
  local o=np.array({{0,1,2},{3,4,5}},np.int32)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 112 identity')
  assert(o.dtype=='int32','out 112 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 112 shape')
  assert(seqeq(o.strides,{12,4}),'out 112 strides')
  assert(veq(o:tolist(),{{0,1,2},{3,4,5}}),'out 112 values')
end
do -- out-where 113
  local a=np.array({{14,16,8},{0,18,0}},np.uint64)
  local b=np.array({{1.5,-0.5,-5.5}},np.float64)
  local m=np.array({{false,true,true},{true,false,true}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 113 identity')
  assert(o.dtype=='float64','out 113 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 113 shape')
  assert(seqeq(o.strides,{24,8}),'out 113 strides')
  assert(veq(o:tolist(),{{0.0,-8.0,-44.0},{0.0,4.0,-0.0}}),'out 113 values')
end
do -- out-where 114
  local a=np.array({{19,0,4},{3,3,6}},np.uint16)
  local b=np.array({-5.5,3.75,-0.5},np.float16)
  local m=np.array({false,true,false},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float32)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 114 identity')
  assert(o.dtype=='float32','out 114 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 114 shape')
  assert(seqeq(o.strides,{12,4}),'out 114 strides')
  assert(veq(o:tolist(),{{0.0,0.0,2.0},{3.0,0.800000011920929,5.0}}),'out 114 values')
end
do -- out-where 115
  local a=np.array({{-5.5,-2.25,0.25},{3.75,-0.5,1.5}},np.float32)
  local b=np.array({-2.25,0.25,-2.25},np.float32)
  local m=np.array({false,true,true},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float32)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 115 identity')
  assert(o.dtype=='float32','out 115 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 115 shape')
  assert(seqeq(o.strides,{12,4}),'out 115 strides')
  assert(veq(o:tolist(),{{0.0,-2.0,-2.0},{3.0,-0.25,-0.75}}),'out 115 values')
end
do -- out-where 116
  local a=np.array({8,20,14,1,7},np.uint32)
  local b=np.array({14,4,8,15,5},np.uint8)
  local m=np.array({false},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float16)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 116 identity')
  assert(o.dtype=='float16','out 116 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 116 shape')
  assert(seqeq(o.strides,{2}),'out 116 strides')
  assert(veq(o:tolist(),{0.0,1.0,2.0,3.0,4.0}),'out 116 values')
end
do -- out-where 117
  local a=np.array({-0.5,-5.5,-5.5,3.75,-5.5},np.float64)
  local b=np.array({3.75,-0.5,3.75,-0.5,-5.5},np.float64)
  local m=np.array({true},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float64)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 117 identity')
  assert(o.dtype=='float64','out 117 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 117 shape')
  assert(seqeq(o.strides,{8}),'out 117 strides')
  assert(veq(o:tolist(),{-1.875,2.75,-20.625,-1.875,30.25}),'out 117 values')
end
do -- out-where 118
  local a=np.array({{15,20,16},{9,14,3}},np.uint8)
  local b=np.array({{3.75,1.5,-2.25}},np.float32)
  local m=np.array({{false}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},np.float16),{3,2}).T
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 118 identity')
  assert(o.dtype=='float16','out 118 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 118 shape')
  assert(seqeq(o.strides,{2,4}),'out 118 strides')
  assert(veq(o:tolist(),{{0.0,2.0,4.0},{1.0,3.0,5.0}}),'out 118 values')
end
do -- out-where 119
  local a=np.array({false,true,true,true,true},np.bool)
  local b=np.array({9,4,4,4,1},np.int8)
  local m=np.array({false,true,true,true,false},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float64)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 119 identity')
  assert(o.dtype=='float64','out 119 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 119 shape')
  assert(seqeq(o.strides,{8}),'out 119 strides')
  assert(veq(o:tolist(),{0.0,5.0,5.0,5.0,4.0}),'out 119 values')
end
do -- out-where 120
  local a=np.array({6,1,5,19,12},np.uint8)
  local b=np.array({-2.25,-0.5,1.5,-0.5,-2.25},np.float64)
  local m=np.array({false},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float32)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 120 identity')
  assert(o.dtype=='float32','out 120 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 120 shape')
  assert(seqeq(o.strides,{4}),'out 120 strides')
  assert(veq(o:tolist(),{0.0,1.0,2.0,3.0,4.0}),'out 120 values')
end
do -- out-where 121
  local a=np.array({{1,8,9},{10,3,20}},np.uint16)
  local b=np.array({{true,true,true}},np.bool)
  local m=np.array({{{true}},{{true}}},np.bool)
  local o=np.array({{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{6.0,7.0,8.0},{9.0,10.0,11.0}}},np.float32)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 121 identity')
  assert(o.dtype=='float32','out 121 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 121 shape')
  assert(seqeq(o.strides,{24,12,4}),'out 121 strides')
  assert(veq(o:tolist(),{{{1.0,8.0,9.0},{10.0,3.0,20.0}},{{1.0,8.0,9.0},{10.0,3.0,20.0}}}),'out 121 values')
end
do -- out-where 122
  local a=np.array({2,9,0,4,1},np.int64)
  local b=np.array({3.75,-0.5,-5.5,3.75,0.25},np.float16)
  local m=np.array({{true},{true}},np.bool)
  local o=np.array({{0.0,1.0,2.0,3.0,4.0},{5.0,6.0,7.0,8.0,9.0}},np.float16)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 122 identity')
  assert(o.dtype=='float16','out 122 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,5}),'out 122 shape')
  assert(seqeq(o.strides,{10,2}),'out 122 strides')
  assert(veq(o:tolist(),{{0.533203125,-18.0,-0.0,1.06640625,4.0},{0.533203125,-18.0,-0.0,1.06640625,4.0}}),'out 122 values')
end
do -- out-where 123
  local a=np.array({{4,1,-1},{-2,2,0}},np.int8)
  local b=np.array({1.5,1.5,1.5},np.float32)
  local m=np.array({false,true,true},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},np.float32),{3,2}).T
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 123 identity')
  assert(o.dtype=='float32','out 123 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 123 shape')
  assert(seqeq(o.strides,{4,8}),'out 123 strides')
  assert(veq(o:tolist(),{{0.0,2.5,0.5},{1.0,3.5,1.5}}),'out 123 values')
end
do -- out-where 124
  local a=np.array({{{19},{18},{15}},{{8},{0},{3}}},np.uint16)
  local b=np.array({{{-2,9,4,9},{1,9,-9,2},{-2,-4,2,2}}},np.int8)
  local m=np.array({{{true,true,true,true},{true,true,true,true},{true,true,true,true}},{{true,true,true,true},{true,true,true,true},{true,true,true,true}}},np.bool)
  local o=np.array({{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},np.float32)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 124 identity')
  assert(o.dtype=='float32','out 124 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3,4}),'out 124 shape')
  assert(seqeq(o.strides,{48,16,4}),'out 124 strides')
  assert(veq(o:tolist(),{{{-9.5,2.1111111640930176,4.75,2.1111111640930176},{18.0,2.0,-2.0,9.0},{-7.5,-3.75,7.5,7.5}},{{-4.0,0.8888888955116272,2.0,0.8888888955116272},{0.0,0.0,-0.0,0.0},{-1.5,-0.75,1.5,1.5}}}),'out 124 values')
end
do -- out-where 125
  local a=np.array({-2.25,1.5,-5.5,0.25,1.5},np.float64)
  local b=np.array({-1,-2,-2,1,-9},np.int64)
  local m=np.array({false,true,true,true,false},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float16)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 125 identity')
  assert(o.dtype=='float16','out 125 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 125 shape')
  assert(seqeq(o.strides,{2}),'out 125 strides')
  assert(veq(o:tolist(),{0.0,-0.75,2.75,0.25,4.0}),'out 125 values')
end
do -- out-where 126
  local a=np.array({{2,4,9},{-2,-9,-2}},np.int32)
  local b=np.array({{11,0,11}},np.uint8)
  local m=np.array({{false,true,false},{true,false,true}},np.bool)
  local o=np.array({{0,1,2},{3,4,5}},np.int32)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 126 identity')
  assert(o.dtype=='int32','out 126 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 126 shape')
  assert(seqeq(o.strides,{12,4}),'out 126 strides')
  assert(veq(o:tolist(),{{0,4,2},{9,4,9}}),'out 126 values')
end
do -- out-where 127
  local a=np.array({{10},{1}},np.uint16)
  local b=np.array({{-1,2,-2}},np.int8)
  local m=np.array({{false,true,false},{true,false,true}},np.bool)
  local o=np.reshape(np.array({0,1,2,3,4,5},np.int8),{3,2}).T
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 127 identity')
  assert(o.dtype=='int8','out 127 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 127 shape')
  assert(seqeq(o.strides,{1,2}),'out 127 strides')
  assert(veq(o:tolist(),{{0,12,4},{0,3,-1}}),'out 127 values')
end
do -- out-where 128
  local a=np.array({{{1},{9},{-2}},{{1},{2},{0}}},np.int16)
  local b=np.array({{{1.5,-5.5,-5.5,-0.5},{3.75,3.75,-5.5,-2.25},{-2.25,1.5,-5.5,-5.5}}},np.float16)
  local m=np.array({{{false,true,true,true},{false,true,true,true},{false,true,true,true}},{{false,true,true,true},{false,true,true,true},{false,true,true,true}}},np.bool)
  local o=np.array({{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},np.float32)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 128 identity')
  assert(o.dtype=='float32','out 128 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3,4}),'out 128 shape')
  assert(seqeq(o.strides,{48,16,4}),'out 128 strides')
  assert(veq(o:tolist(),{{{0.0,6.5,6.5,1.5},{4.0,5.25,14.5,11.25},{8.0,-3.5,3.5,3.5}},{{12.0,6.5,6.5,1.5},{16.0,-1.75,7.5,4.25},{3.0,-1.5,5.5,5.5}}}),'out 128 values')
end
do -- out-where 129
  local a=np.array({{7,16,20},{15,16,4}},np.uint8)
  local b=np.array({{3,7,10}},np.uint32)
  local m=np.array({{false,true,true},{false,true,true}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},np.float32),{3,2}).T
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 129 identity')
  assert(o.dtype=='float32','out 129 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 129 shape')
  assert(seqeq(o.strides,{4,8}),'out 129 strides')
  assert(veq(o:tolist(),{{0.0,23.0,30.0},{1.0,23.0,14.0}}),'out 129 values')
end
do -- out-where 130
  local a=np.array({{-1,1,4},{2,2,1}},np.int64)
  local b=np.array({15,15,0},np.uint16)
  local m=np.array({{false}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},np.float32),{3,2}).T
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 130 identity')
  assert(o.dtype=='float32','out 130 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 130 shape')
  assert(seqeq(o.strides,{4,8}),'out 130 strides')
  assert(veq(o:tolist(),{{0.0,2.0,4.0},{1.0,3.0,5.0}}),'out 130 values')
end
do -- out-where 131
  local a=np.array({{16,9,11},{1,5,0}},np.uint16)
  local b=np.array({-0.5,3.75,-2.25},np.float32)
  local m=np.array({{false}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 131 identity')
  assert(o.dtype=='float16','out 131 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 131 shape')
  assert(seqeq(o.strides,{6,2}),'out 131 strides')
  assert(veq(o:tolist(),{{0.0,1.0,2.0},{3.0,4.0,5.0}}),'out 131 values')
end
do -- out-where 132
  local a=np.array({{9},{9}},np.int32)
  local b=np.array({{false,false,false}},np.bool)
  local m=np.array({{false,true,false},{true,false,true}},np.bool)
  local o=np.array({{0,1,2},{3,4,5}},np.int16)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 132 identity')
  assert(o.dtype=='int16','out 132 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 132 shape')
  assert(seqeq(o.strides,{6,2}),'out 132 strides')
  assert(veq(o:tolist(),{{0,9,2},{9,4,9}}),'out 132 values')
end
do -- out-where 133
  local a=np.array({4,13,19,6,20},np.uint32)
  local b=np.array({19,20,7,11,10},np.uint64)
  local m=np.array({true},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float64)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 133 identity')
  assert(o.dtype=='float64','out 133 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 133 shape')
  assert(seqeq(o.strides,{8}),'out 133 strides')
  assert(veq(o:tolist(),{0.21052631578947367,0.65,2.7142857142857144,0.5454545454545454,2.0}),'out 133 values')
end
do -- out-where 134
  local a=np.array({{4},{13}},np.uint8)
  local b=np.array({{-2.25,-0.5,-0.5}},np.float16)
  local m=np.array({{false,true,false},{true,false,true}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},np.float16),{3,2}).T
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 134 identity')
  assert(o.dtype=='float16','out 134 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 134 shape')
  assert(seqeq(o.strides,{2,4}),'out 134 strides')
  assert(veq(o:tolist(),{{0.0,3.5,4.0},{10.75,3.0,12.5}}),'out 134 values')
end
do -- out-where 135
  local a=np.array({{{-2.25},{-5.5},{1.5}},{{1.5},{-5.5},{-5.5}}},np.float16)
  local b=np.array({{{-5.5,3.75,-2.25,-0.5},{0.25,1.5,1.5,3.75},{-2.25,-0.5,1.5,1.5}}},np.float16)
  local m=np.array({false,true,true,false},np.bool)
  local o=np.array({{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},np.float16)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 135 identity')
  assert(o.dtype=='float16','out 135 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3,4}),'out 135 shape')
  assert(seqeq(o.strides,{24,8,2}),'out 135 strides')
  assert(veq(o:tolist(),{{{0.0,-8.4375,5.0625,3.0},{4.0,-8.25,-8.25,7.0},{8.0,-0.75,2.25,11.0}},{{12.0,5.625,-3.375,15.0},{16.0,-8.25,-8.25,2.0},{3.0,2.75,-8.25,6.0}}}),'out 135 values')
end
do -- out-where 136
  local a=np.array({5,8,14,8,12},np.uint8)
  local b=np.array({19,3,3,11,2},np.uint64)
  local m=np.array({{false},{true}},np.bool)
  local o=np.array({{0.0,1.0,2.0,3.0,4.0},{5.0,6.0,7.0,8.0,9.0}},np.float32)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 136 identity')
  assert(o.dtype=='float32','out 136 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,5}),'out 136 shape')
  assert(seqeq(o.strides,{20,4}),'out 136 strides')
  assert(veq(o:tolist(),{{0.0,1.0,2.0,3.0,4.0},{0.2631579041481018,2.6666667461395264,4.666666507720947,0.7272727489471436,6.0}}),'out 136 values')
end
do -- out-where 137
  local a=np.array({14,10,10,8,10},np.uint64)
  local b=np.array({-5.5,3.75,0.25,0.25,0.25},np.float32)
  local m=np.array({true,true,true,true,true},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float32)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 137 identity')
  assert(o.dtype=='float32','out 137 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 137 shape')
  assert(seqeq(o.strides,{4}),'out 137 strides')
  assert(veq(o:tolist(),{19.5,6.25,9.75,7.75,9.75}),'out 137 values')
end
do -- out-where 138
  local a=np.array({{true,true,true},{true,false,false}},np.bool)
  local b=np.array({1,9,9},np.int16)
  local m=np.array({{true,true,true},{true,true,true}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float32)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 138 identity')
  assert(o.dtype=='float32','out 138 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 138 shape')
  assert(seqeq(o.strides,{12,4}),'out 138 strides')
  assert(veq(o:tolist(),{{2.0,10.0,10.0},{2.0,9.0,9.0}}),'out 138 values')
end
do -- out-where 139
  local a=np.array({6,18,4,12,15},np.uint32)
  local b=np.array({8,12,15,4,0},np.uint8)
  local m=np.array({true,true,true,true,true},np.bool)
  local o=np.array({0,1,2,3,4},np.uint16)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 139 identity')
  assert(o.dtype=='uint16','out 139 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 139 shape')
  assert(seqeq(o.strides,{2}),'out 139 strides')
  assert(veq(o:tolist(),{48,216,60,48,0}),'out 139 values')
end
do -- out-where 140
  local a=np.array({1.5,0.25,1.5,-0.5,-5.5},np.float32)
  local b=np.array({5,2,10,7,13},np.uint16)
  local m=np.array({false},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float64)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 140 identity')
  assert(o.dtype=='float64','out 140 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 140 shape')
  assert(seqeq(o.strides,{8}),'out 140 strides')
  assert(veq(o:tolist(),{0.0,1.0,2.0,3.0,4.0}),'out 140 values')
end
do -- out-where 141
  local a=np.array({{13,15,8},{10,6,15}},np.uint8)
  local b=np.array({{-2.25,-0.5,1.5}},np.float32)
  local m=np.array({{false}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float32)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 141 identity')
  assert(o.dtype=='float32','out 141 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 141 shape')
  assert(seqeq(o.strides,{12,4}),'out 141 strides')
  assert(veq(o:tolist(),{{0.0,1.0,2.0},{3.0,4.0,5.0}}),'out 141 values')
end
do -- out-where 142
  local a=np.array({{{-5.5},{1.5},{1.5}},{{1.5},{-2.25},{0.25}}},np.float64)
  local b=np.array({{{-2,1,-2,-9},{1,9,9,-9},{1,0,1,0}}},np.int8)
  local m=np.array({{{{false}}},{{{true}}}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0},np.float64),{4,3,2,2}).T
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 142 identity')
  assert(o.dtype=='float64','out 142 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3,4}),'out 142 shape')
  assert(seqeq(o.strides,{8,16,32,96}),'out 142 strides')
  assert(veq(o:tolist(),{{{{0.0,12.0,7.0,2.0},{4.0,16.0,11.0,6.0},{8.0,3.0,15.0,10.0}},{{2.0,14.0,9.0,4.0},{6.0,1.0,13.0,8.0},{10.0,5.0,0.0,12.0}}},{{{-7.5,-4.5,-7.5,-14.5},{2.5,10.5,10.5,-7.5},{2.5,1.5,2.5,1.5}},{{-0.5,2.5,-0.5,-7.5},{-1.25,6.75,6.75,-11.25},{1.25,0.25,1.25,0.25}}}}),'out 142 values')
end
do -- out-where 143
  local a=np.array({8,19,7,5,3},np.uint32)
  local b=np.array({11,8,4,4,9},np.uint8)
  local m=np.array({false,true,true,false,true},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float32)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 143 identity')
  assert(o.dtype=='float32','out 143 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 143 shape')
  assert(seqeq(o.strides,{4}),'out 143 strides')
  assert(veq(o:tolist(),{0.0,27.0,11.0,3.0,12.0}),'out 143 values')
end
do -- out-where 144
  local a=np.array({{4},{-1}},np.int64)
  local b=np.array({{9,4,1}},np.int32)
  local m=np.array({{{false}},{{true}}},np.bool)
  local o=np.array({{{0,1,2},{3,4,5}},{{6,7,8},{9,10,11}}},np.int16)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 144 identity')
  assert(o.dtype=='int16','out 144 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 144 shape')
  assert(seqeq(o.strides,{12,6,2}),'out 144 strides')
  assert(veq(o:tolist(),{{{0,1,2},{3,4,5}},{{36,16,4},{-9,-4,-1}}}),'out 144 values')
end
do -- out-where 145
  local a=np.array({{{-9},{0},{9}},{{4},{-1},{-9}}},np.int64)
  local b=np.array({{{0,4,1,2},{4,-9,9,-2},{-2,1,4,0}}},np.int16)
  local m=np.array({{{false}}},np.bool)
  local o=np.array({{{0,1,2,3},{4,5,6,7},{8,9,10,11}},{{12,13,14,15},{16,0,1,2},{3,4,5,6}}},np.int64)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 145 identity')
  assert(o.dtype=='int64','out 145 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3,4}),'out 145 shape')
  assert(seqeq(o.strides,{96,32,8}),'out 145 strides')
  assert(veq(o:tolist(),{{{0,1,2,3},{4,5,6,7},{8,9,10,11}},{{12,13,14,15},{16,0,1,2},{3,4,5,6}}}),'out 145 values')
end
do -- out-where 146
  local a=np.array({{3.75,-5.5,0.25},{1.5,0.25,-5.5}},np.float16)
  local b=np.array({-4,4,-9},np.int16)
  local m=np.array({false,true,true},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float32)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 146 identity')
  assert(o.dtype=='float32','out 146 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 146 shape')
  assert(seqeq(o.strides,{12,4}),'out 146 strides')
  assert(veq(o:tolist(),{{0.0,-1.375,-0.02777777798473835},{3.0,0.0625,0.6111111044883728}}),'out 146 values')
end
do -- out-where 147
  local a=np.array({{-2,-2,0},{-9,9,-4}},np.int8)
  local b=np.array({14,13,2},np.uint32)
  local m=np.array({false,true,true},np.bool)
  local o=np.reshape(np.array({0,1,2,3,4,5},np.int8),{3,2}).T
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 147 identity')
  assert(o.dtype=='int8','out 147 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 147 shape')
  assert(seqeq(o.strides,{1,2}),'out 147 strides')
  assert(veq(o:tolist(),{{0,11,2},{1,22,-2}}),'out 147 values')
end
do -- out-where 148
  local a=np.array({3.75,1.5,-2.25,-2.25,1.5},np.float64)
  local b=np.array({3.75,-5.5,0.25,1.5,-0.5},np.float32)
  local m=np.array({{false},{true}},np.bool)
  local o=np.array({{0.0,1.0,2.0,3.0,4.0},{5.0,6.0,7.0,8.0,9.0}},np.float16)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 148 identity')
  assert(o.dtype=='float16','out 148 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,5}),'out 148 shape')
  assert(seqeq(o.strides,{10,2}),'out 148 strides')
  assert(veq(o:tolist(),{{0.0,1.0,2.0,3.0,4.0},{1.0,-0.272705078125,-9.0,-1.5,-3.0}}),'out 148 values')
end
do -- out-where 149
  local a=np.array({-0.5,-0.5,3.75,-0.5,1.5},np.float32)
  local b=np.array({1,-1,4,9,9},np.int64)
  local m=np.array({false},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float16)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 149 identity')
  assert(o.dtype=='float16','out 149 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 149 shape')
  assert(seqeq(o.strides,{2}),'out 149 strides')
  assert(veq(o:tolist(),{0.0,1.0,2.0,3.0,4.0}),'out 149 values')
end
do -- out-where 150
  local a=np.array({{14},{6}},np.uint8)
  local b=np.array({{-2.25,3.75,3.75}},np.float64)
  local m=np.array({false,true,true},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 150 identity')
  assert(o.dtype=='float64','out 150 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 150 shape')
  assert(seqeq(o.strides,{24,8}),'out 150 strides')
  assert(veq(o:tolist(),{{0.0,52.5,52.5},{3.0,22.5,22.5}}),'out 150 values')
end
do -- out-where 151
  local a=np.array({{1,4,4},{-1,9,-9}},np.int8)
  local b=np.array({{3,8,11}},np.uint64)
  local m=np.array({{false}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},np.float64),{3,2}).T
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 151 identity')
  assert(o.dtype=='float64','out 151 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 151 shape')
  assert(seqeq(o.strides,{8,16}),'out 151 strides')
  assert(veq(o:tolist(),{{0.0,2.0,4.0},{1.0,3.0,5.0}}),'out 151 values')
end
do -- out-where 152
  local a=np.array({5,15,17,7,5},np.uint32)
  local b=np.array({-9,4,4,2,-9},np.int32)
  local m=np.array({false,true,true,false,true},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float64)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 152 identity')
  assert(o.dtype=='float64','out 152 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 152 shape')
  assert(seqeq(o.strides,{8}),'out 152 strides')
  assert(veq(o:tolist(),{0.0,3.75,4.25,3.0,-0.5555555555555556}),'out 152 values')
end
do -- out-where 153
  local a=np.array({{{-4},{1},{4}},{{-4},{0},{1}}},np.int8)
  local b=np.array({{{1,16,15,13},{6,13,10,11},{14,14,16,10}}},np.uint16)
  local m=np.array({{{{false}}},{{{true}}}},np.bool)
  local o=np.array({{{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},{{{7.0,8.0,9.0,10.0},{11.0,12.0,13.0,14.0},{15.0,16.0,0.0,1.0}},{{2.0,3.0,4.0,5.0},{6.0,7.0,8.0,9.0},{10.0,11.0,12.0,13.0}}}},np.float32)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 153 identity')
  assert(o.dtype=='float32','out 153 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3,4}),'out 153 shape')
  assert(seqeq(o.strides,{96,48,16,4}),'out 153 strides')
  assert(veq(o:tolist(),{{{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},{{{-4.0,-64.0,-60.0,-52.0},{6.0,13.0,10.0,11.0},{56.0,56.0,64.0,40.0}},{{-4.0,-64.0,-60.0,-52.0},{0.0,0.0,0.0,0.0},{14.0,14.0,16.0,10.0}}}}),'out 153 values')
end
do -- out-where 154
  local a=np.array({{9,9,14},{13,14,2}},np.uint16)
  local b=np.array({{12,9,18}},np.uint32)
  local m=np.array({{{true}},{{true}}},np.bool)
  local o=np.array({{{0,1,2},{3,4,5}},{{6,7,8},{9,10,11}}},np.uint8)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 154 identity')
  assert(o.dtype=='uint8','out 154 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 154 shape')
  assert(seqeq(o.strides,{6,3,1}),'out 154 strides')
  assert(veq(o:tolist(),{{{108,81,252},{156,126,36}},{{108,81,252},{156,126,36}}}),'out 154 values')
end
do -- out-where 155
  local a=np.array({{20,3,14},{0,12,1}},np.uint32)
  local b=np.array({false,true,true},np.bool)
  local m=np.array({false,true,true},np.bool)
  local o=np.reshape(np.array({0,1,2,3,4,5},np.uint8),{3,2}).T
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 155 identity')
  assert(o.dtype=='uint8','out 155 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 155 shape')
  assert(seqeq(o.strides,{1,2}),'out 155 strides')
  assert(veq(o:tolist(),{{0,2,13},{1,11,0}}),'out 155 values')
end
do -- out-where 156
  local a=np.array({-2,9,0,9,-9},np.int8)
  local b=np.array({19,16,11,10,4},np.uint8)
  local m=np.array({true},np.bool)
  local o=np.array({0,1,2,3,4},np.int8)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 156 identity')
  assert(o.dtype=='int8','out 156 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 156 shape')
  assert(seqeq(o.strides,{1}),'out 156 strides')
  assert(veq(o:tolist(),{-38,-112,0,90,-36}),'out 156 values')
end
do -- out-where 157
  local a=np.array({{false,false,true},{true,true,true}},np.bool)
  local b=np.array({{0,14,16}},np.uint16)
  local m=np.array({false,true,true},np.bool)
  local o=np.array({{0,1,2},{3,4,5}},np.int16)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 157 identity')
  assert(o.dtype=='int16','out 157 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 157 shape')
  assert(seqeq(o.strides,{6,2}),'out 157 strides')
  assert(veq(o:tolist(),{{0,-14,-15},{3,-13,-15}}),'out 157 values')
end
do -- out-where 158
  local a=np.array({{0.25},{0.25}},np.float32)
  local b=np.array({{0,9,-2}},np.int16)
  local m=np.array({{false}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 158 identity')
  assert(o.dtype=='float16','out 158 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 158 shape')
  assert(seqeq(o.strides,{6,2}),'out 158 strides')
  assert(veq(o:tolist(),{{0.0,1.0,2.0},{3.0,4.0,5.0}}),'out 158 values')
end
do -- out-where 159
  local a=np.array({{-2.25,1.5,-0.5},{-0.5,-0.5,-0.5}},np.float64)
  local b=np.array({20,2,12},np.uint8)
  local m=np.array({{{false}},{{true}}},np.bool)
  local o=np.array({{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{6.0,7.0,8.0},{9.0,10.0,11.0}}},np.float16)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 159 identity')
  assert(o.dtype=='float16','out 159 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 159 shape')
  assert(seqeq(o.strides,{12,6,2}),'out 159 strides')
  assert(veq(o:tolist(),{{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{-22.25,-0.5,-12.5},{-20.5,-2.5,-12.5}}}),'out 159 values')
end
do -- out-where 160
  local a=np.array({2,2,-9,-2,-2},np.int16)
  local b=np.array({19,15,0,14,13},np.uint16)
  local m=np.array({true,true,true,true,true},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float32)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 160 identity')
  assert(o.dtype=='float32','out 160 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 160 shape')
  assert(seqeq(o.strides,{4}),'out 160 strides')
  assert(veq(o:tolist(),{38.0,30.0,0.0,-28.0,-26.0}),'out 160 values')
end
do -- out-where 161
  local a=np.array({{-1,-4,-1},{2,4,-1}},np.int16)
  local b=np.array({15,7,2},np.uint32)
  local m=np.array({{false}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},np.float32),{3,2}).T
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 161 identity')
  assert(o.dtype=='float32','out 161 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 161 shape')
  assert(seqeq(o.strides,{4,8}),'out 161 strides')
  assert(veq(o:tolist(),{{0.0,2.0,4.0},{1.0,3.0,5.0}}),'out 161 values')
end
do -- out-where 162
  local a=np.array({{1.5,-2.25,-5.5},{-0.5,0.25,3.75}},np.float64)
  local b=np.array({{13,18,18}},np.uint8)
  local m=np.array({false,true,true},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0},np.float64),{3,2}).T
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 162 identity')
  assert(o.dtype=='float64','out 162 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 162 shape')
  assert(seqeq(o.strides,{8,16}),'out 162 strides')
  assert(veq(o:tolist(),{{0.0,15.75,12.5},{1.0,18.25,21.75}}),'out 162 values')
end
do -- out-where 163
  local a=np.array({{2,-9,0},{0,-4,0}},np.int16)
  local b=np.array({{15,1,15}},np.uint32)
  local m=np.array({{{false}},{{true}}},np.bool)
  local o=np.array({{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{6.0,7.0,8.0},{9.0,10.0,11.0}}},np.float64)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 163 identity')
  assert(o.dtype=='float64','out 163 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 163 shape')
  assert(seqeq(o.strides,{48,24,8}),'out 163 strides')
  assert(veq(o:tolist(),{{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{17.0,-8.0,15.0},{15.0,-3.0,15.0}}}),'out 163 values')
end
do -- out-where 164
  local a=np.array({-4,-9,9,-4,0},np.int32)
  local b=np.array({-9,-9,-9,-2,2},np.int8)
  local m=np.array({false,true,true,false,true},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float16)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 164 identity')
  assert(o.dtype=='float16','out 164 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 164 shape')
  assert(seqeq(o.strides,{2}),'out 164 strides')
  assert(veq(o:tolist(),{0.0,1.0,-1.0,3.0,0.0}),'out 164 values')
end
do -- out-where 165
  local a=np.array({{{9},{2},{-4}},{{-1},{1},{-4}}},np.int64)
  local b=np.array({{{4,9,2,4},{-1,4,-9,2},{0,9,-4,0}}},np.int16)
  local m=np.array({{{{true}}},{{{true}}}},np.bool)
  local o=np.array({{{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},{{{7.0,8.0,9.0,10.0},{11.0,12.0,13.0,14.0},{15.0,16.0,0.0,1.0}},{{2.0,3.0,4.0,5.0},{6.0,7.0,8.0,9.0},{10.0,11.0,12.0,13.0}}}},np.float16)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 165 identity')
  assert(o.dtype=='float16','out 165 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3,4}),'out 165 shape')
  assert(seqeq(o.strides,{48,24,8,2}),'out 165 strides')
  assert(veq(o:tolist(),{{{{5.0,0.0,7.0,5.0},{3.0,-2.0,11.0,0.0},{-4.0,-13.0,0.0,-4.0}},{{-5.0,-10.0,-3.0,-5.0},{2.0,-3.0,10.0,-1.0},{-4.0,-13.0,0.0,-4.0}}},{{{5.0,0.0,7.0,5.0},{3.0,-2.0,11.0,0.0},{-4.0,-13.0,0.0,-4.0}},{{-5.0,-10.0,-3.0,-5.0},{2.0,-3.0,10.0,-1.0},{-4.0,-13.0,0.0,-4.0}}}}),'out 165 values')
end
do -- out-where 166
  local a=np.array({0.25,0.25,3.75,3.75,1.5},np.float64)
  local b=np.array({15,12,13,18,13},np.uint64)
  local m=np.array({{false},{true}},np.bool)
  local o=np.array({{0.0,1.0,2.0,3.0,4.0},{5.0,6.0,7.0,8.0,9.0}},np.float16)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 166 identity')
  assert(o.dtype=='float16','out 166 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,5}),'out 166 shape')
  assert(seqeq(o.strides,{10,2}),'out 166 strides')
  assert(veq(o:tolist(),{{0.0,1.0,2.0,3.0,4.0},{0.01666259765625,0.0208282470703125,0.28857421875,0.2083740234375,0.1153564453125}}),'out 166 values')
end
do -- out-where 167
  local a=np.array({{{-1},{0},{-4}},{{0},{-1},{2}}},np.int8)
  local b=np.array({{{13,17,13,15},{13,14,11,15},{8,11,18,16}}},np.uint16)
  local m=np.array({false,true,false,true},np.bool)
  local o=np.array({{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},np.float16)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 167 identity')
  assert(o.dtype=='float16','out 167 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3,4}),'out 167 shape')
  assert(seqeq(o.strides,{24,8,2}),'out 167 strides')
  assert(veq(o:tolist(),{{{0.0,-17.0,2.0,-15.0},{4.0,0.0,6.0,0.0},{8.0,-44.0,10.0,-64.0}},{{12.0,0.0,14.0,0.0},{16.0,-14.0,1.0,-15.0},{3.0,22.0,5.0,32.0}}}),'out 167 values')
end
do -- out-where 168
  local a=np.array({-9,2,-4,-1,-2},np.int16)
  local b=np.array({-4,4,2,-1,2},np.int32)
  local m=np.array({false,true,true,false,true},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float16)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 168 identity')
  assert(o.dtype=='float16','out 168 dtype '..o.dtype)
  assert(seqeq(o.shape,{5}),'out 168 shape')
  assert(seqeq(o.strides,{2}),'out 168 strides')
  assert(veq(o:tolist(),{0.0,8.0,-8.0,3.0,-4.0}),'out 168 values')
end
do -- out-where 169
  local a=np.array({{14,3,1},{0,12,3}},np.uint32)
  local b=np.array({6,17,12},np.uint16)
  local m=np.array({{false}},np.bool)
  local o=np.array({{0,1,2},{3,4,5}},np.int16)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 169 identity')
  assert(o.dtype=='int16','out 169 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 169 shape')
  assert(seqeq(o.strides,{6,2}),'out 169 strides')
  assert(veq(o:tolist(),{{0,1,2},{3,4,5}}),'out 169 values')
end
do -- out-where 170
  local a=np.array({{{-5.5},{-0.5},{-5.5}},{{3.75},{-5.5},{3.75}}},np.float16)
  local b=np.array({{{18,14,17,17},{11,20,1,4},{16,20,9,4}}},np.uint8)
  local m=np.array({{{{false}}},{{{true}}}},np.bool)
  local o=np.array({{{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},{{{7.0,8.0,9.0,10.0},{11.0,12.0,13.0,14.0},{15.0,16.0,0.0,1.0}},{{2.0,3.0,4.0,5.0},{6.0,7.0,8.0,9.0},{10.0,11.0,12.0,13.0}}}},np.float32)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 170 identity')
  assert(o.dtype=='float32','out 170 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3,4}),'out 170 shape')
  assert(seqeq(o.strides,{96,48,16,4}),'out 170 strides')
  assert(veq(o:tolist(),{{{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},{{{12.5,8.5,11.5,11.5},{10.5,19.5,0.5,3.5},{10.5,14.5,3.5,-1.5}},{{21.75,17.75,20.75,20.75},{5.5,14.5,-4.5,-1.5},{19.75,23.75,12.75,7.75}}}}),'out 170 values')
end
do -- out-where 171
  local a=np.array({{20},{5}},np.uint8)
  local b=np.array({{-1,4,-2}},np.int64)
  local m=np.array({{false}},np.bool)
  local o=np.reshape(np.array({0,1,2,3,4,5},np.int16),{3,2}).T
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 171 identity')
  assert(o.dtype=='int16','out 171 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 171 shape')
  assert(seqeq(o.strides,{2,4}),'out 171 strides')
  assert(veq(o:tolist(),{{0,2,4},{1,3,5}}),'out 171 values')
end
do -- out-where 172
  local a=np.array({{-5.5,-0.5,1.5},{1.5,1.5,3.75}},np.float64)
  local b=np.array({{-4,-2,-2}},np.int32)
  local m=np.array({{false}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float32)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 172 identity')
  assert(o.dtype=='float32','out 172 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 172 shape')
  assert(seqeq(o.strides,{12,4}),'out 172 strides')
  assert(veq(o:tolist(),{{0.0,1.0,2.0},{3.0,4.0,5.0}}),'out 172 values')
end
do -- out-where 173
  local a=np.array({{{-2},{-1},{-9}},{{1},{-2},{-9}}},np.int64)
  local b=np.array({{{7,18,14,19},{3,1,15,7},{20,20,15,3}}},np.uint64)
  local m=np.array({{{false}}},np.bool)
  local o=np.array({{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},np.float32)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 173 identity')
  assert(o.dtype=='float32','out 173 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3,4}),'out 173 shape')
  assert(seqeq(o.strides,{48,16,4}),'out 173 strides')
  assert(veq(o:tolist(),{{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}}),'out 173 values')
end
do -- out-where 174
  local a=np.array({{{4},{14},{7}},{{7},{14},{16}}},np.uint64)
  local b=np.array({{{-5.5,-2.25,-5.5,1.5},{-0.5,-5.5,3.75,0.25},{-2.25,1.5,1.5,-5.5}}},np.float64)
  local m=np.array({false,true,true,true},np.bool)
  local o=np.array({{{0.0,1.0,2.0,3.0},{4.0,5.0,6.0,7.0},{8.0,9.0,10.0,11.0}},{{12.0,13.0,14.0,15.0},{16.0,0.0,1.0,2.0},{3.0,4.0,5.0,6.0}}},np.float16)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 174 identity')
  assert(o.dtype=='float16','out 174 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3,4}),'out 174 shape')
  assert(seqeq(o.strides,{24,8,2}),'out 174 strides')
  assert(veq(o:tolist(),{{{0.0,6.25,9.5,2.5},{4.0,19.5,10.25,13.75},{8.0,5.5,5.5,12.5}},{{12.0,9.25,12.5,5.5},{16.0,19.5,10.25,13.75},{3.0,14.5,14.5,21.5}}}),'out 174 values')
end
do -- out-where 175
  local a=np.array({{-5.5},{0.25}},np.float16)
  local b=np.array({{true,false,false}},np.bool)
  local m=np.array({false,true,true},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local r=np.multiply(a,b,{out=o,where=m})
  assert(r==o,'out 175 identity')
  assert(o.dtype=='float64','out 175 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 175 shape')
  assert(seqeq(o.strides,{24,8}),'out 175 strides')
  assert(veq(o:tolist(),{{0.0,-0.0,-0.0},{3.0,0.0,0.0}}),'out 175 values')
end
do -- out-where 176
  local a=np.array({{false,true,true},{true,true,true}},np.bool)
  local b=np.array({12,2,5},np.uint16)
  local m=np.array({{{false}},{{true}}},np.bool)
  local o=np.reshape(np.array({0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},np.float16),{3,2,2}).T
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 176 identity')
  assert(o.dtype=='float16','out 176 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 176 shape')
  assert(seqeq(o.strides,{2,4,8}),'out 176 strides')
  assert(veq(o:tolist(),{{{0.0,4.0,8.0},{2.0,6.0,10.0}},{{0.0,0.5,0.199951171875},{0.08331298828125,0.5,0.199951171875}}}),'out 176 values')
end
do -- out-where 177
  local a=np.array({{1.5,-5.5,1.5},{-2.25,3.75,1.5}},np.float32)
  local b=np.array({{3.75,-2.25,0.25}},np.float32)
  local m=np.array({{true}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float32)
  local r=np.true_divide(a,b,{out=o,where=m})
  assert(r==o,'out 177 identity')
  assert(o.dtype=='float32','out 177 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 177 shape')
  assert(seqeq(o.strides,{12,4}),'out 177 strides')
  assert(veq(o:tolist(),{{0.4000000059604645,2.444444417953491,6.0},{-0.6000000238418579,-1.6666666269302368,6.0}}),'out 177 values')
end
do -- out-where 178
  local a=np.array({{0,20,11},{17,1,6}},np.uint8)
  local b=np.array({{1.5,0.25,-0.5}},np.float32)
  local m=np.array({false,true,false},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float32)
  local r=np.subtract(a,b,{out=o,where=m})
  assert(r==o,'out 178 identity')
  assert(o.dtype=='float32','out 178 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,3}),'out 178 shape')
  assert(seqeq(o.strides,{12,4}),'out 178 strides')
  assert(veq(o:tolist(),{{0.0,19.75,2.0},{3.0,0.75,5.0}}),'out 178 values')
end
do -- out-where 179
  local a=np.array({{false},{false}},np.bool)
  local b=np.array({{9,11,12}},np.uint8)
  local m=np.array({{{false}},{{true}}},np.bool)
  local o=np.array({{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{6.0,7.0,8.0},{9.0,10.0,11.0}}},np.float64)
  local r=np.add(a,b,{out=o,where=m})
  assert(r==o,'out 179 identity')
  assert(o.dtype=='float64','out 179 dtype '..o.dtype)
  assert(seqeq(o.shape,{2,2,3}),'out 179 shape')
  assert(seqeq(o.strides,{48,24,8}),'out 179 strides')
  assert(veq(o:tolist(),{{{0.0,1.0,2.0},{3.0,4.0,5.0}},{{9.0,11.0,12.0},{9.0,11.0,12.0}}}),'out 179 values')
end
do -- scalar-out 0
  local a=np.array({{1.5,0.25,0.25},{1.5,0.25,1.5}},np.float64)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float32)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.multiply(a,1,{out=o,where=m})
  assert(r==o,'scalar out 0 identity')
  assert(veq(o:tolist(),{{1.5,1.0,0.25},{1.5,4.0,1.5}}),'scalar out 0 values')
end
do -- scalar-out 1
  local a=np.array({-2,2,4,4,-1},np.int8)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float64)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.true_divide(a,2,{out=o,where=m})
  assert(r==o,'scalar out 1 identity')
  assert(veq(o:tolist(),{-1.0,1.0,2.0,2.0,4.0}),'scalar out 1 values')
end
do -- scalar-out 2
  local a=np.array({{0.25,-2.25,1.5},{-0.5,1.5,3.75}},np.float64)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.true_divide(a,-0.5,{out=o,where=m})
  assert(r==o,'scalar out 2 identity')
  assert(veq(o:tolist(),{{-0.5,1.0,-3.0},{1.0,4.0,-7.5}}),'scalar out 2 values')
end
do -- scalar-out 3
  local a=np.array({{9,-9,4},{4,4,0}},np.int64)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float32)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.multiply(a,-0.5,{out=o,where=m})
  assert(r==o,'scalar out 3 identity')
  assert(veq(o:tolist(),{{-4.5,1.0,-2.0},{-2.0,4.0,-0.0}}),'scalar out 3 values')
end
do -- scalar-out 4
  local a=np.array({18,7,12,5,6},np.uint32)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float64)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.true_divide(a,true,{out=o,where=m})
  assert(r==o,'scalar out 4 identity')
  assert(veq(o:tolist(),{18.0,1.0,12.0,5.0,4.0}),'scalar out 4 values')
end
do -- scalar-out 5
  local a=np.array({{4,14,10},{20,17,18}},np.uint16)
  local o=np.array({{0,1,2},{3,4,5}},np.int8)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.multiply(a,4,{out=o,where=m})
  assert(r==o,'scalar out 5 identity')
  assert(veq(o:tolist(),{{16,1,40},{80,4,72}}),'scalar out 5 values')
end
do -- scalar-out 6
  local a=np.array({{-9,4,-1},{9,-9,-1}},np.int16)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float32)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.true_divide(a,-2.5,{out=o,where=m})
  assert(r==o,'scalar out 6 identity')
  assert(veq(o:tolist(),{{3.5999999046325684,1.0,0.4000000059604645},{-3.5999999046325684,4.0,0.4000000059604645}}),'scalar out 6 values')
end
do -- scalar-out 7
  local a=np.array({-2.25,0.25,-5.5,-0.5,0.25},np.float32)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float16)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.true_divide(a,2.5,{out=o,where=m})
  assert(r==o,'scalar out 7 identity')
  assert(veq(o:tolist(),{-0.89990234375,1.0,-2.19921875,-0.199951171875,4.0}),'scalar out 7 values')
end
do -- scalar-out 8
  local a=np.array({-0.5,3.75,-2.25,0.25,3.75},np.float32)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float32)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.true_divide(2.5,a,{out=o,where=m})
  assert(r==o,'scalar out 8 identity')
  assert(veq(o:tolist(),{-5.0,1.0,-1.1111111640930176,10.0,4.0}),'scalar out 8 values')
end
do -- scalar-out 9
  local a=np.array({3.75,3.75,1.5,-5.5,-5.5},np.float16)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float32)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.true_divide(a,4,{out=o,where=m})
  assert(r==o,'scalar out 9 identity')
  assert(veq(o:tolist(),{0.9375,1.0,0.375,-1.375,4.0}),'scalar out 9 values')
end
do -- scalar-out 10
  local a=np.array({{false,true,false},{true,true,false}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.add(-2.5,a,{out=o,where=m})
  assert(r==o,'scalar out 10 identity')
  assert(veq(o:tolist(),{{-2.5,1.0,-2.5},{-1.5,4.0,-2.5}}),'scalar out 10 values')
end
do -- scalar-out 11
  local a=np.array({{16,18,6},{10,19,10}},np.uint16)
  local o=np.array({{0,1,2},{3,4,5}},np.uint64)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.subtract(true,a,{out=o,where=m})
  assert(r==o,'scalar out 11 identity')
  assert(veq(o:tolist(),{{65521,1,65531},{65527,4,65527}}),'scalar out 11 values')
end
do -- scalar-out 12
  local a=np.array({{0,1,0},{2,0,4}},np.int16)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float32)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.add(a,-2.5,{out=o,where=m})
  assert(r==o,'scalar out 12 identity')
  assert(veq(o:tolist(),{{-2.5,1.0,-2.5},{-0.5,4.0,1.5}}),'scalar out 12 values')
end
do -- scalar-out 13
  local a=np.array({9,-2,-2,0,0},np.int64)
  local o=np.array({0,1,2,3,4},np.int64)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.add(a,false,{out=o,where=m})
  assert(r==o,'scalar out 13 identity')
  assert(veq(o:tolist(),{9,1,-2,0,4}),'scalar out 13 values')
end
do -- scalar-out 14
  local a=np.array({9,12,1,19,20},np.uint64)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float64)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.add(0.5,a,{out=o,where=m})
  assert(r==o,'scalar out 14 identity')
  assert(veq(o:tolist(),{9.5,1.0,1.5,19.5,4.0}),'scalar out 14 values')
end
do -- scalar-out 15
  local a=np.array({3.75,-0.5,0.25,-5.5,1.5},np.float32)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float64)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.true_divide(a,true,{out=o,where=m})
  assert(r==o,'scalar out 15 identity')
  assert(veq(o:tolist(),{3.75,1.0,0.25,-5.5,4.0}),'scalar out 15 values')
end
do -- scalar-out 16
  local a=np.array({-5.5,0.25,3.75,-2.25,0.25},np.float32)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float32)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.add(-0.5,a,{out=o,where=m})
  assert(r==o,'scalar out 16 identity')
  assert(veq(o:tolist(),{-6.0,1.0,3.25,-2.75,4.0}),'scalar out 16 values')
end
do -- scalar-out 17
  local a=np.array({{1.5,0.25,0.25},{1.5,-5.5,-5.5}},np.float32)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.subtract(2.5,a,{out=o,where=m})
  assert(r==o,'scalar out 17 identity')
  assert(veq(o:tolist(),{{1.0,1.0,2.25},{1.0,4.0,8.0}}),'scalar out 17 values')
end
do -- scalar-out 18
  local a=np.array({{0.25,-2.25,1.5},{-2.25,-0.5,0.25}},np.float32)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.subtract(0.5,a,{out=o,where=m})
  assert(r==o,'scalar out 18 identity')
  assert(veq(o:tolist(),{{0.25,1.0,-1.0},{2.75,4.0,0.25}}),'scalar out 18 values')
end
do -- scalar-out 19
  local a=np.array({{14,0,9},{6,19,1}},np.uint64)
  local o=np.array({{0,1,2},{3,4,5}},np.uint64)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.subtract(a,1,{out=o,where=m})
  assert(r==o,'scalar out 19 identity')
  assert(veq(o:tolist(),{{13,1,8},{5,4,0}}),'scalar out 19 values')
end
do -- scalar-out 20
  local a=np.array({-9,-9,-2,-1,-9},np.int8)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float32)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.true_divide(-2.5,a,{out=o,where=m})
  assert(r==o,'scalar out 20 identity')
  assert(veq(o:tolist(),{0.2777777910232544,1.0,1.25,2.5,4.0}),'scalar out 20 values')
end
do -- scalar-out 21
  local a=np.array({1.5,-5.5,-0.5,3.75,3.75},np.float64)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float64)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.subtract(1,a,{out=o,where=m})
  assert(r==o,'scalar out 21 identity')
  assert(veq(o:tolist(),{-0.5,1.0,1.5,-2.75,4.0}),'scalar out 21 values')
end
do -- scalar-out 22
  local a=np.array({-5.5,-0.5,-0.5,-2.25,-5.5},np.float64)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float16)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.multiply(a,1,{out=o,where=m})
  assert(r==o,'scalar out 22 identity')
  assert(veq(o:tolist(),{-5.5,1.0,-0.5,-2.25,4.0}),'scalar out 22 values')
end
do -- scalar-out 23
  local a=np.array({14,16,8,6,12},np.uint8)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float32)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.add(a,1,{out=o,where=m})
  assert(r==o,'scalar out 23 identity')
  assert(veq(o:tolist(),{15.0,1.0,9.0,7.0,4.0}),'scalar out 23 values')
end
do -- scalar-out 24
  local a=np.array({{1.5,-5.5,-0.5},{0.25,-5.5,1.5}},np.float16)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float32)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.add(2,a,{out=o,where=m})
  assert(r==o,'scalar out 24 identity')
  assert(veq(o:tolist(),{{3.5,1.0,1.5},{2.25,4.0,3.5}}),'scalar out 24 values')
end
do -- scalar-out 25
  local a=np.array({{2,2,12},{10,8,20}},np.uint8)
  local o=np.array({{0,1,2},{3,4,5}},np.int8)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.multiply(false,a,{out=o,where=m})
  assert(r==o,'scalar out 25 identity')
  assert(veq(o:tolist(),{{0,1,0},{0,4,0}}),'scalar out 25 values')
end
do -- scalar-out 26
  local a=np.array({13,20,3,16,1},np.uint16)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float16)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.add(4,a,{out=o,where=m})
  assert(r==o,'scalar out 26 identity')
  assert(veq(o:tolist(),{17.0,1.0,7.0,20.0,4.0}),'scalar out 26 values')
end
do -- scalar-out 27
  local a=np.array({true,true,false,true,false},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float64)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.subtract(2,a,{out=o,where=m})
  assert(r==o,'scalar out 27 identity')
  assert(veq(o:tolist(),{1.0,1.0,2.0,1.0,4.0}),'scalar out 27 values')
end
do -- scalar-out 28
  local a=np.array({{false,true,true},{false,false,true}},np.bool)
  local o=np.array({{0,1,2},{3,4,5}},np.uint8)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.multiply(false,a,{out=o,where=m})
  assert(r==o,'scalar out 28 identity')
  assert(veq(o:tolist(),{{0,1,0},{0,4,0}}),'scalar out 28 values')
end
do -- scalar-out 29
  local a=np.array({{-4,-2,-2},{0,-1,-9}},np.int64)
  local o=np.array({{0,1,2},{3,4,5}},np.int32)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.add(4,a,{out=o,where=m})
  assert(r==o,'scalar out 29 identity')
  assert(veq(o:tolist(),{{0,1,2},{4,4,-5}}),'scalar out 29 values')
end
do -- scalar-out 30
  local a=np.array({{12,14,14},{9,19,17}},np.uint8)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.true_divide(a,-4,{out=o,where=m})
  assert(r==o,'scalar out 30 identity')
  assert(veq(o:tolist(),{{-3.0,1.0,-3.5},{-2.25,4.0,-4.25}}),'scalar out 30 values')
end
do -- scalar-out 31
  local a=np.array({{true,true,false},{true,true,true}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.add(-0.5,a,{out=o,where=m})
  assert(r==o,'scalar out 31 identity')
  assert(veq(o:tolist(),{{0.5,1.0,-0.5},{0.5,4.0,0.5}}),'scalar out 31 values')
end
do -- scalar-out 32
  local a=np.array({6,13,10,12,7},np.uint16)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float64)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.true_divide(0.5,a,{out=o,where=m})
  assert(r==o,'scalar out 32 identity')
  assert(veq(o:tolist(),{0.08333333333333333,1.0,0.05,0.041666666666666664,4.0}),'scalar out 32 values')
end
do -- scalar-out 33
  local a=np.array({{-2.25,1.5,1.5},{-5.5,-0.5,1.5}},np.float32)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float32)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.true_divide(-1,a,{out=o,where=m})
  assert(r==o,'scalar out 33 identity')
  assert(veq(o:tolist(),{{0.4444444477558136,1.0,-0.6666666865348816},{0.1818181872367859,4.0,-0.6666666865348816}}),'scalar out 33 values')
end
do -- scalar-out 34
  local a=np.array({{-1,2,1},{-4,4,9}},np.int8)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.true_divide(1,a,{out=o,where=m})
  assert(r==o,'scalar out 34 identity')
  assert(veq(o:tolist(),{{-1.0,1.0,1.0},{-0.25,4.0,0.1111111111111111}}),'scalar out 34 values')
end
do -- scalar-out 35
  local a=np.array({true,true,true,true,true},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float64)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.true_divide(-0.5,a,{out=o,where=m})
  assert(r==o,'scalar out 35 identity')
  assert(veq(o:tolist(),{-0.5,1.0,-0.5,-0.5,4.0}),'scalar out 35 values')
end
do -- scalar-out 36
  local a=np.array({{9,-9,-1},{-9,4,2}},np.int16)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.multiply(a,-4,{out=o,where=m})
  assert(r==o,'scalar out 36 identity')
  assert(veq(o:tolist(),{{-36.0,1.0,4.0},{36.0,4.0,-8.0}}),'scalar out 36 values')
end
do -- scalar-out 37
  local a=np.array({{17,1,1},{14,13,6}},np.uint8)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.subtract(0.5,a,{out=o,where=m})
  assert(r==o,'scalar out 37 identity')
  assert(veq(o:tolist(),{{-16.5,1.0,-0.5},{-13.5,4.0,-5.5}}),'scalar out 37 values')
end
do -- scalar-out 38
  local a=np.array({{11,20,18},{1,0,1}},np.uint64)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.subtract(a,-2.5,{out=o,where=m})
  assert(r==o,'scalar out 38 identity')
  assert(veq(o:tolist(),{{13.5,1.0,20.5},{3.5,4.0,3.5}}),'scalar out 38 values')
end
do -- scalar-out 39
  local a=np.array({16,20,11,3,16},np.uint32)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float64)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.add(false,a,{out=o,where=m})
  assert(r==o,'scalar out 39 identity')
  assert(veq(o:tolist(),{16.0,1.0,11.0,3.0,4.0}),'scalar out 39 values')
end
do -- scalar-out 40
  local a=np.array({{false,true,false},{false,true,true}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float32)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.multiply(a,2.5,{out=o,where=m})
  assert(r==o,'scalar out 40 identity')
  assert(veq(o:tolist(),{{0.0,1.0,0.0},{0.0,4.0,2.5}}),'scalar out 40 values')
end
do -- scalar-out 41
  local a=np.array({{4,-4,-4},{9,-2,-1}},np.int16)
  local o=np.array({{0,1,2},{3,4,5}},np.int16)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.add(a,-1,{out=o,where=m})
  assert(r==o,'scalar out 41 identity')
  assert(veq(o:tolist(),{{3,1,-5},{8,4,-2}}),'scalar out 41 values')
end
do -- scalar-out 42
  local a=np.array({13,3,15,10,11},np.uint64)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float32)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.add(a,1,{out=o,where=m})
  assert(r==o,'scalar out 42 identity')
  assert(veq(o:tolist(),{14.0,1.0,16.0,11.0,4.0}),'scalar out 42 values')
end
do -- scalar-out 43
  local a=np.array({{3,11,20},{4,8,18}},np.uint32)
  local o=np.array({{0,1,2},{3,4,5}},np.uint8)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.subtract(a,4,{out=o,where=m})
  assert(r==o,'scalar out 43 identity')
  assert(veq(o:tolist(),{{255,1,16},{0,4,14}}),'scalar out 43 values')
end
do -- scalar-out 44
  local a=np.array({{true,true,true},{true,true,true}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.true_divide(1,a,{out=o,where=m})
  assert(r==o,'scalar out 44 identity')
  assert(veq(o:tolist(),{{1.0,1.0,1.0},{1.0,4.0,1.0}}),'scalar out 44 values')
end
do -- scalar-out 45
  local a=np.array({{3,11,7},{20,10,6}},np.uint8)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.true_divide(-1,a,{out=o,where=m})
  assert(r==o,'scalar out 45 identity')
  assert(veq(o:tolist(),{{-0.333251953125,1.0,-0.142822265625},{-0.04998779296875,4.0,-0.1666259765625}}),'scalar out 45 values')
end
do -- scalar-out 46
  local a=np.array({{-2,-1,9},{4,-1,4}},np.int16)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.multiply(a,2.5,{out=o,where=m})
  assert(r==o,'scalar out 46 identity')
  assert(veq(o:tolist(),{{-5.0,1.0,22.5},{10.0,4.0,10.0}}),'scalar out 46 values')
end
do -- scalar-out 47
  local a=np.array({false,true,true,true,true},np.bool)
  local o=np.array({0,1,2,3,4},np.int64)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.multiply(1,a,{out=o,where=m})
  assert(r==o,'scalar out 47 identity')
  assert(veq(o:tolist(),{0,1,1,1,4}),'scalar out 47 values')
end
do -- scalar-out 48
  local a=np.array({9,2,4,1,1},np.int16)
  local o=np.array({0,1,2,3,4},np.int32)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.multiply(-4,a,{out=o,where=m})
  assert(r==o,'scalar out 48 identity')
  assert(veq(o:tolist(),{-36,1,-16,-4,4}),'scalar out 48 values')
end
do -- scalar-out 49
  local a=np.array({-9,4,0,0,1},np.int64)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float16)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.multiply(1,a,{out=o,where=m})
  assert(r==o,'scalar out 49 identity')
  assert(veq(o:tolist(),{-9.0,1.0,0.0,0.0,4.0}),'scalar out 49 values')
end
do -- scalar-out 50
  local a=np.array({{0,4,9},{0,-9,-9}},np.int64)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.multiply(a,true,{out=o,where=m})
  assert(r==o,'scalar out 50 identity')
  assert(veq(o:tolist(),{{0.0,1.0,9.0},{0.0,4.0,-9.0}}),'scalar out 50 values')
end
do -- scalar-out 51
  local a=np.array({-2.25,-2.25,3.75,3.75,1.5},np.float64)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float32)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.true_divide(-2,a,{out=o,where=m})
  assert(r==o,'scalar out 51 identity')
  assert(veq(o:tolist(),{0.8888888955116272,1.0,-0.5333333611488342,-0.5333333611488342,4.0}),'scalar out 51 values')
end
do -- scalar-out 52
  local a=np.array({0.25,-5.5,-2.25,0.25,-0.5},np.float16)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float64)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.multiply(a,false,{out=o,where=m})
  assert(r==o,'scalar out 52 identity')
  assert(veq(o:tolist(),{0.0,1.0,-0.0,0.0,4.0}),'scalar out 52 values')
end
do -- scalar-out 53
  local a=np.array({{-4,2,0},{9,-2,0}},np.int32)
  local o=np.array({{0,1,2},{3,4,5}},np.int64)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.multiply(a,true,{out=o,where=m})
  assert(r==o,'scalar out 53 identity')
  assert(veq(o:tolist(),{{-4,1,0},{9,4,0}}),'scalar out 53 values')
end
do -- scalar-out 54
  local a=np.array({{0.25,1.5,-5.5},{-2.25,-0.5,-5.5}},np.float32)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.subtract(1,a,{out=o,where=m})
  assert(r==o,'scalar out 54 identity')
  assert(veq(o:tolist(),{{0.75,1.0,6.5},{3.25,4.0,6.5}}),'scalar out 54 values')
end
do -- scalar-out 55
  local a=np.array({{3.75,0.25,0.25},{1.5,3.75,-5.5}},np.float32)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.add(-2.5,a,{out=o,where=m})
  assert(r==o,'scalar out 55 identity')
  assert(veq(o:tolist(),{{1.25,1.0,-2.25},{-1.0,4.0,-8.0}}),'scalar out 55 values')
end
do -- scalar-out 56
  local a=np.array({{13,7,10},{5,0,19}},np.uint8)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.multiply(a,2.5,{out=o,where=m})
  assert(r==o,'scalar out 56 identity')
  assert(veq(o:tolist(),{{32.5,1.0,25.0},{12.5,4.0,47.5}}),'scalar out 56 values')
end
do -- scalar-out 57
  local a=np.array({{19,14,4},{0,0,15}},np.uint16)
  local o=np.array({{0,1,2},{3,4,5}},np.int32)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.add(2,a,{out=o,where=m})
  assert(r==o,'scalar out 57 identity')
  assert(veq(o:tolist(),{{21,1,6},{2,4,17}}),'scalar out 57 values')
end
do -- scalar-out 58
  local a=np.array({{10,20,17},{4,8,13}},np.uint64)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.true_divide(a,2,{out=o,where=m})
  assert(r==o,'scalar out 58 identity')
  assert(veq(o:tolist(),{{5.0,1.0,8.5},{2.0,4.0,6.5}}),'scalar out 58 values')
end
do -- scalar-out 59
  local a=np.array({-5.5,-0.5,-0.5,3.75,-0.5},np.float16)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float64)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.true_divide(-4,a,{out=o,where=m})
  assert(r==o,'scalar out 59 identity')
  assert(veq(o:tolist(),{0.72705078125,1.0,8.0,-1.06640625,4.0}),'scalar out 59 values')
end
do -- scalar-out 60
  local a=np.array({{3.75,0.25,3.75},{-5.5,-2.25,1.5}},np.float32)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float32)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.add(-2.5,a,{out=o,where=m})
  assert(r==o,'scalar out 60 identity')
  assert(veq(o:tolist(),{{1.25,1.0,1.25},{-8.0,4.0,-1.0}}),'scalar out 60 values')
end
do -- scalar-out 61
  local a=np.array({{4,-2,-2},{4,-2,0}},np.int64)
  local o=np.array({{0,1,2},{3,4,5}},np.int64)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.subtract(a,-1,{out=o,where=m})
  assert(r==o,'scalar out 61 identity')
  assert(veq(o:tolist(),{{5,1,-1},{5,4,1}}),'scalar out 61 values')
end
do -- scalar-out 62
  local a=np.array({{0.25,0.25,-5.5},{3.75,-5.5,1.5}},np.float64)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.subtract(1,a,{out=o,where=m})
  assert(r==o,'scalar out 62 identity')
  assert(veq(o:tolist(),{{0.75,1.0,6.5},{-2.75,4.0,-0.5}}),'scalar out 62 values')
end
do -- scalar-out 63
  local a=np.array({-5.5,3.75,1.5,3.75,-5.5},np.float64)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float16)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.add(a,2,{out=o,where=m})
  assert(r==o,'scalar out 63 identity')
  assert(veq(o:tolist(),{-3.5,1.0,3.5,5.75,4.0}),'scalar out 63 values')
end
do -- scalar-out 64
  local a=np.array({0.25,-5.5,3.75,-5.5,-2.25},np.float32)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float32)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.multiply(0.5,a,{out=o,where=m})
  assert(r==o,'scalar out 64 identity')
  assert(veq(o:tolist(),{0.125,1.0,1.875,-2.75,4.0}),'scalar out 64 values')
end
do -- scalar-out 65
  local a=np.array({{4,0,2},{-1,-4,0}},np.int8)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float32)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.add(-2.5,a,{out=o,where=m})
  assert(r==o,'scalar out 65 identity')
  assert(veq(o:tolist(),{{1.5,1.0,-0.5},{-3.5,4.0,-2.5}}),'scalar out 65 values')
end
do -- scalar-out 66
  local a=np.array({9,-4,2,1,-2},np.int8)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float32)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.true_divide(a,2,{out=o,where=m})
  assert(r==o,'scalar out 66 identity')
  assert(veq(o:tolist(),{4.5,1.0,1.0,0.5,4.0}),'scalar out 66 values')
end
do -- scalar-out 67
  local a=np.array({19,17,1,5,19},np.uint32)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float32)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.multiply(-0.5,a,{out=o,where=m})
  assert(r==o,'scalar out 67 identity')
  assert(veq(o:tolist(),{-9.5,1.0,-0.5,-2.5,4.0}),'scalar out 67 values')
end
do -- scalar-out 68
  local a=np.array({{-5.5,-5.5,3.75},{3.75,0.25,-0.5}},np.float16)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.multiply(-2.5,a,{out=o,where=m})
  assert(r==o,'scalar out 68 identity')
  assert(veq(o:tolist(),{{13.75,1.0,-9.375},{-9.375,4.0,1.25}}),'scalar out 68 values')
end
do -- scalar-out 69
  local a=np.array({{19,14,13},{11,6,1}},np.uint32)
  local o=np.array({{0,1,2},{3,4,5}},np.int8)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.multiply(a,true,{out=o,where=m})
  assert(r==o,'scalar out 69 identity')
  assert(veq(o:tolist(),{{19,1,13},{11,4,1}}),'scalar out 69 values')
end
do -- scalar-out 70
  local a=np.array({{true,false,false},{false,false,false}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.true_divide(a,-1,{out=o,where=m})
  assert(r==o,'scalar out 70 identity')
  assert(veq(o:tolist(),{{-1.0,1.0,-0.0},{-0.0,4.0,-0.0}}),'scalar out 70 values')
end
do -- scalar-out 71
  local a=np.array({{-4,-9,-1},{2,-9,-9}},np.int64)
  local o=np.array({{0,1,2},{3,4,5}},np.int64)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.multiply(-2,a,{out=o,where=m})
  assert(r==o,'scalar out 71 identity')
  assert(veq(o:tolist(),{{8,1,2},{-4,4,18}}),'scalar out 71 values')
end
do -- scalar-out 72
  local a=np.array({-5.5,1.5,1.5,-0.5,3.75},np.float16)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float32)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.add(2,a,{out=o,where=m})
  assert(r==o,'scalar out 72 identity')
  assert(veq(o:tolist(),{-3.5,1.0,3.5,1.5,4.0}),'scalar out 72 values')
end
do -- scalar-out 73
  local a=np.array({true,true,true,true,true},np.bool)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float32)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.true_divide(a,-0.5,{out=o,where=m})
  assert(r==o,'scalar out 73 identity')
  assert(veq(o:tolist(),{-2.0,1.0,-2.0,-2.0,4.0}),'scalar out 73 values')
end
do -- scalar-out 74
  local a=np.array({1,12,3,19,17},np.uint32)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float16)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.true_divide(a,0.5,{out=o,where=m})
  assert(r==o,'scalar out 74 identity')
  assert(veq(o:tolist(),{2.0,1.0,6.0,38.0,4.0}),'scalar out 74 values')
end
do -- scalar-out 75
  local a=np.array({{true,false,true},{true,true,false}},np.bool)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float16)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.multiply(-4,a,{out=o,where=m})
  assert(r==o,'scalar out 75 identity')
  assert(veq(o:tolist(),{{-4.0,1.0,-4.0},{-4.0,4.0,0.0}}),'scalar out 75 values')
end
do -- scalar-out 76
  local a=np.array({{1.5,3.75,-2.25},{-2.25,-0.5,-2.25}},np.float32)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.true_divide(a,2,{out=o,where=m})
  assert(r==o,'scalar out 76 identity')
  assert(veq(o:tolist(),{{0.75,1.0,-1.125},{-1.125,4.0,-1.125}}),'scalar out 76 values')
end
do -- scalar-out 77
  local a=np.array({1.5,0.25,1.5,-0.5,1.5},np.float64)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float32)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.subtract(-2,a,{out=o,where=m})
  assert(r==o,'scalar out 77 identity')
  assert(veq(o:tolist(),{-3.5,1.0,-3.5,-1.5,4.0}),'scalar out 77 values')
end
do -- scalar-out 78
  local a=np.array({{13,8,1},{0,6,4}},np.uint64)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.multiply(a,2.5,{out=o,where=m})
  assert(r==o,'scalar out 78 identity')
  assert(veq(o:tolist(),{{32.5,1.0,2.5},{0.0,4.0,10.0}}),'scalar out 78 values')
end
do -- scalar-out 79
  local a=np.array({9,-9,0,1,0},np.int32)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float16)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.multiply(a,2.5,{out=o,where=m})
  assert(r==o,'scalar out 79 identity')
  assert(veq(o:tolist(),{22.5,1.0,0.0,2.5,4.0}),'scalar out 79 values')
end
do -- scalar-out 80
  local a=np.array({{6,3,17},{6,3,18}},np.uint16)
  local o=np.array({{0,1,2},{3,4,5}},np.uint32)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.subtract(true,a,{out=o,where=m})
  assert(r==o,'scalar out 80 identity')
  assert(veq(o:tolist(),{{65531,1,65520},{65531,4,65519}}),'scalar out 80 values')
end
do -- scalar-out 81
  local a=np.array({-1,-4,2,-9,9},np.int16)
  local o=np.array({0.0,1.0,2.0,3.0,4.0},np.float16)
  local m=np.array({true,false,true,true,false},np.bool)
  local r=np.subtract(2.5,a,{out=o,where=m})
  assert(r==o,'scalar out 81 identity')
  assert(veq(o:tolist(),{3.5,1.0,0.5,11.5,4.0}),'scalar out 81 values')
end
do -- scalar-out 82
  local a=np.array({{18,16,8},{18,5,20}},np.uint16)
  local o=np.array({{0.0,1.0,2.0},{3.0,4.0,5.0}},np.float64)
  local m=np.array({{true,false,true},{true,false,true}},np.bool)
  local r=np.multiply(a,1,{out=o,where=m})
  assert(r==o,'scalar out 82 identity')
  assert(veq(o:tolist(),{{18.0,1.0,8.0},{18.0,4.0,20.0}}),'scalar out 82 values')
end
do -- where-expand 0
  local a=np.array({0,1,2},np.int16)
  local b=np.array({1.0,1.0,1.0},np.float32)
  local m=np.array({{true},{true}},np.bool)
  local r=np.add(a,b,{where=m})
  assert(seqeq(r.shape,{2,3}),'expand 0 shape')
  assert(seqeq(r.strides,{12,4}),'expand 0 strides')
  assert(veq(r:tolist(),{{1.0,2.0,3.0},{1.0,2.0,3.0}}),'expand 0 values')
end
do -- where-expand 1
  local a=np.array({0,1,2},np.int16)
  local b=np.array({1.0,1.0,1.0},np.float32)
  local m=np.array({{true},{true},{true}},np.bool)
  local r=np.add(a,b,{where=m})
  assert(seqeq(r.shape,{3,3}),'expand 1 shape')
  assert(seqeq(r.strides,{12,4}),'expand 1 strides')
  assert(veq(r:tolist(),{{1.0,2.0,3.0},{1.0,2.0,3.0},{1.0,2.0,3.0}}),'expand 1 values')
end
do -- where-expand 2
  local a=np.array({{0,1,2},{3,4,5}},np.int16)
  local b=np.array({{1.0,1.0,1.0},{1.0,1.0,1.0}},np.float32)
  local m=np.array({{{true}},{{true}}},np.bool)
  local r=np.add(a,b,{where=m})
  assert(seqeq(r.shape,{2,2,3}),'expand 2 shape')
  assert(seqeq(r.strides,{24,12,4}),'expand 2 strides')
  assert(veq(r:tolist(),{{{1.0,2.0,3.0},{4.0,5.0,6.0}},{{1.0,2.0,3.0},{4.0,5.0,6.0}}}),'expand 2 values')
end
do -- where-expand 3
  local a=np.array({{0,1,2},{3,4,5}},np.int16)
  local b=np.array({{1.0,1.0,1.0},{1.0,1.0,1.0}},np.float32)
  local m=np.array({{{true}},{{true}},{{true}}},np.bool)
  local r=np.add(a,b,{where=m})
  assert(seqeq(r.shape,{3,2,3}),'expand 3 shape')
  assert(seqeq(r.strides,{24,12,4}),'expand 3 strides')
  assert(veq(r:tolist(),{{{1.0,2.0,3.0},{4.0,5.0,6.0}},{{1.0,2.0,3.0},{4.0,5.0,6.0}},{{1.0,2.0,3.0},{4.0,5.0,6.0}}}),'expand 3 values')
end
do -- where-expand 4
  local a=np.array({{0,1,2,3}},np.int16)
  local b=np.array({{1.0,1.0,1.0,1.0}},np.float32)
  local m=np.array({{{true}},{{true}}},np.bool)
  local r=np.add(a,b,{where=m})
  assert(seqeq(r.shape,{2,1,4}),'expand 4 shape')
  assert(seqeq(r.strides,{16,16,4}),'expand 4 strides')
  assert(veq(r:tolist(),{{{1.0,2.0,3.0,4.0}},{{1.0,2.0,3.0,4.0}}}),'expand 4 values')
end
do -- where-expand 5
  local a=np.array({{0,1,2,3}},np.int16)
  local b=np.array({{1.0,1.0,1.0,1.0}},np.float32)
  local m=np.array({{{true}},{{true}},{{true}}},np.bool)
  local r=np.add(a,b,{where=m})
  assert(seqeq(r.shape,{3,1,4}),'expand 5 shape')
  assert(seqeq(r.strides,{16,16,4}),'expand 5 strides')
  assert(veq(r:tolist(),{{{1.0,2.0,3.0,4.0}},{{1.0,2.0,3.0,4.0}},{{1.0,2.0,3.0,4.0}}}),'expand 5 values')
end
do -- overlap forward
  local x=np.arange(8)
  local src=x:get(np.slice(1,8))
  local dst=x:get(np.slice(2,9))
  np.add(src,10,{out=dst})
  assert(veq(x:tolist(),{0,10,11,12,13,14,15,16}),'overlap forward')
end
do -- overlap backward
  local x=np.arange(8)
  local src=x:get(np.slice(2,9))
  local dst=x:get(np.slice(1,8))
  np.add(src,10,{out=dst})
  assert(veq(x:tolist(),{11,12,13,14,15,16,17,7}),'overlap backward')
end
do -- overlap reverse
  local x=np.arange(8)
  local src=x:get(np.slice(nil,nil,-1))
  local dst=x
  np.add(src,3,{out=dst})
  assert(veq(x:tolist(),{10,9,8,7,6,5,4,3}),'overlap reverse')
end
do -- masked overlap
  local x=np.arange(8)
  local src=x:get(np.slice(1,8))
  local dst=x:get(np.slice(2,9))
  local m=np.array({true,false,true,false,true,false,true},np.bool)
  np.add(src,10,{out=dst,where=m})
  assert(veq(x:tolist(),{0,10,2,12,4,14,6,16}),'masked overlap')
end

do
  local a=np.array({1.5,2.5},np.float64)
  local o=np.array({10,20},np.int64)
  local ok,err=pcall(function() np.add(a,a,{out=o}) end)
  assert(not ok and tostring(err):find("same_kind",1,true),'same_kind output rejection')
end

do
  local a=np.array({1,2,3},np.int8)
  local o=np.array({9,8,7},np.int16)
  np.add(a,2,{out=o,where=false})
  assert(veq(o:tolist(),{9,8,7}),'scalar where false preserves out')
end

print('nditer/out/where differential: 355 cases ok (80 layout, 180 out/where, 83 scalar, 6 mask-expand)')
