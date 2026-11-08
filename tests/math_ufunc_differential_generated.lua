local np=require('luaray_core')

local function seqeq(a,b)
  if #a~=#b then return false end
  for i=1,#a do if a[i]~=b[i] then return false end end
  return true
end
local function veq(a,b,tol)
  tol=tol or 8e-6
  if type(a)=='table' then
    if type(b)~='table' or #a~=#b then return false end
    for i=1,#a do if not veq(a[i],b[i],tol) then return false end end
    return true
  end
  if type(a)~='number' or type(b)~='number' then return a==b end
  if a~=a and b~=b then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return a==b end
  if a==b then return true end
  local scale=math.max(1,math.abs(a),math.abs(b))
  return math.abs(a-b)<=tol*scale
end

do -- sqrt supported 0
 local a=(np.array({{2,3,0},{0,-16,3}},np.int32)).T
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 0 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'sqrt shape 0')
 assert(seqeq(r.strides,{8,24}),'sqrt strides 0')
 assert(veq(r:tolist(),{{1.4142135623730951,0.0},{1.7320508075688772,(0/0)},{0.0,1.7320508075688772}},8e-12),'sqrt values 0')
end
do -- sqrt supported 1
 local a=np.array({{16,3,1},{3,16,4}},np.uint16)
 local r=np.sqrt(a)
 assert(r.dtype=='float32','sqrt dtype 1 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sqrt shape 1')
 assert(seqeq(r.strides,{12,4}),'sqrt strides 1')
 assert(veq(r:tolist(),{{4.0,1.7320507764816284,1.0},{1.7320507764816284,4.0,2.0}},2e-5),'sqrt values 1')
end
do -- sqrt supported 2
 local a=np.array({{{1},{1},{7}},{{31},{31},{16}}},np.uint16)
 local r=np.sqrt(a)
 assert(r.dtype=='float32','sqrt dtype 2 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 2')
 assert(seqeq(r.strides,{12,4,4}),'sqrt strides 2')
 assert(veq(r:tolist(),{{{1.0},{1.0},{2.6457512378692627}},{{5.5677642822265625},{5.5677642822265625},{4.0}}},2e-5),'sqrt values 2')
end
do -- sqrt supported 3
 local a=np.array({{0.0,math.huge,0.125},{0.125,-1.0,-0.0}},np.float16)
 local r=np.sqrt(a)
 assert(r.dtype=='float16','sqrt dtype 3 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sqrt shape 3')
 assert(seqeq(r.strides,{6,2}),'sqrt strides 3')
 assert(veq(r:tolist(),{{0.0,math.huge,0.353515625},{0.353515625,(0/0),-0.0}},2e-3),'sqrt values 3')
end
do -- sqrt supported 4
 local a=np.array({{{16},{1},{31}},{{7},{7},{4}}},np.uint64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 4 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 4')
 assert(seqeq(r.strides,{24,8,8}),'sqrt strides 4')
 assert(veq(r:tolist(),{{{4.0},{1.0},{5.5677643628300215}},{{2.6457513110645907},{2.6457513110645907},{2.0}}},8e-12),'sqrt values 4')
end
do -- sqrt supported 5
 local a=np.array({1.0,-0.0,-1.0,-0.0,math.huge,2.0,4.0},np.float16)
 local r=np.sqrt(a)
 assert(r.dtype=='float16','sqrt dtype 5 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 5')
 assert(seqeq(r.strides,{2}),'sqrt strides 5')
 assert(veq(r:tolist(),{1.0,-0.0,(0/0),-0.0,math.huge,1.4140625,2.0},2e-3),'sqrt values 5')
end
do -- sqrt supported 6
 local a=(np.array({{4,2,7},{1,2,1}},np.uint32)).T
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 6 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'sqrt shape 6')
 assert(seqeq(r.strides,{8,24}),'sqrt strides 6')
 assert(veq(r:tolist(),{{2.0,1.0},{1.4142135623730951,1.4142135623730951},{2.6457513110645907,1.0}},8e-12),'sqrt values 6')
end
do -- sqrt supported 7
 local a=np.array({{{-16},{3},{1}},{{-7},{-1},{3}}},np.int32)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 7 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 7')
 assert(seqeq(r.strides,{24,8,8}),'sqrt strides 7')
 assert(veq(r:tolist(),{{{(0/0)},{1.7320508075688772},{1.0}},{{(0/0)},{(0/0)},{1.7320508075688772}}},8e-12),'sqrt values 7')
end
do -- sqrt supported 8
 local a=np.array({{{3},{1},{3}},{{-1},{3},{16}}},np.int16)
 local r=np.sqrt(a)
 assert(r.dtype=='float32','sqrt dtype 8 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 8')
 assert(seqeq(r.strides,{12,4,4}),'sqrt strides 8')
 assert(veq(r:tolist(),{{{1.7320507764816284},{1.0},{1.7320507764816284}},{{(0/0)},{1.7320507764816284},{4.0}}},2e-5),'sqrt values 8')
end
do -- sqrt supported 9
 local a=np.array({{{-16},{2},{9}},{{0},{-16},{4}}},np.int16)
 local r=np.sqrt(a)
 assert(r.dtype=='float32','sqrt dtype 9 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 9')
 assert(seqeq(r.strides,{12,4,4}),'sqrt strides 9')
 assert(veq(r:tolist(),{{{(0/0)},{1.4142135381698608},{3.0}},{{0.0},{(0/0)},{2.0}}},2e-5),'sqrt values 9')
end
do -- sqrt supported 10
 local a=np.array({{{64},{31},{2}},{{31},{7},{2}}},np.uint64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 10 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 10')
 assert(seqeq(r.strides,{24,8,8}),'sqrt strides 10')
 assert(veq(r:tolist(),{{{8.0},{5.5677643628300215},{1.4142135623730951}},{{5.5677643628300215},{2.6457513110645907},{1.4142135623730951}}},8e-12),'sqrt values 10')
end
do -- sqrt supported 11
 local a=np.array({-0.0,0.0,0.125,1.0,-4.0,0.5,16.0},np.float16)
 local r=np.sqrt(a)
 assert(r.dtype=='float16','sqrt dtype 11 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 11')
 assert(seqeq(r.strides,{2}),'sqrt strides 11')
 assert(veq(r:tolist(),{-0.0,0.0,0.353515625,1.0,(0/0),0.70703125,4.0},2e-3),'sqrt values 11')
end
do -- sqrt supported 12
 local a=(np.array({{1,2,0},{3,3,4}},np.uint16)).T
 local r=np.sqrt(a)
 assert(r.dtype=='float32','sqrt dtype 12 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'sqrt shape 12')
 assert(seqeq(r.strides,{4,12}),'sqrt strides 12')
 assert(veq(r:tolist(),{{1.0,1.7320507764816284},{1.4142135381698608,1.7320507764816284},{0.0,2.0}},2e-5),'sqrt values 12')
end
do -- sqrt supported 13
 local a=np.array({{{1},{0},{7}},{{7},{3},{64}}},np.uint16)
 local r=np.sqrt(a)
 assert(r.dtype=='float32','sqrt dtype 13 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 13')
 assert(seqeq(r.strides,{12,4,4}),'sqrt strides 13')
 assert(veq(r:tolist(),{{{1.0},{0.0},{2.6457512378692627}},{{2.6457512378692627},{1.7320507764816284},{8.0}}},2e-5),'sqrt values 13')
end
do -- sqrt supported 14
 local a=np.array({{{-0.0},{0.0},{2.0}},{{math.huge},{-0.0},{0.0}}},np.float32)
 local r=np.sqrt(a)
 assert(r.dtype=='float32','sqrt dtype 14 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 14')
 assert(seqeq(r.strides,{12,4,4}),'sqrt strides 14')
 assert(veq(r:tolist(),{{{-0.0},{0.0},{1.4142135381698608}},{{math.huge},{-0.0},{0.0}}},2e-5),'sqrt values 14')
end
do -- sqrt supported 15
 local a=np.array({{{2},{4},{4}},{{4},{-7},{9}}},np.int16)
 local r=np.sqrt(a)
 assert(r.dtype=='float32','sqrt dtype 15 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 15')
 assert(seqeq(r.strides,{12,4,4}),'sqrt strides 15')
 assert(veq(r:tolist(),{{{1.4142135381698608},{2.0},{2.0}},{{2.0},{(0/0)},{3.0}}},2e-5),'sqrt values 15')
end
do -- sqrt supported 16
 local a=np.array({{-1.0,-1.0,-0.0},{0.0,0.5,math.huge}},np.float16)
 local r=np.sqrt(a)
 assert(r.dtype=='float16','sqrt dtype 16 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sqrt shape 16')
 assert(seqeq(r.strides,{6,2}),'sqrt strides 16')
 assert(veq(r:tolist(),{{(0/0),(0/0),-0.0},{0.0,0.70703125,math.huge}},2e-3),'sqrt values 16')
end
do -- sqrt supported 17
 local a=np.array({1,7,0,1,7,31,31},np.uint16)
 local r=np.sqrt(a)
 assert(r.dtype=='float32','sqrt dtype 17 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 17')
 assert(seqeq(r.strides,{4}),'sqrt strides 17')
 assert(veq(r:tolist(),{1.0,2.6457512378692627,0.0,1.0,2.6457512378692627,5.5677642822265625,5.5677642822265625},2e-5),'sqrt values 17')
end
do -- sqrt supported 18
 local a=(np.array({{true,true,true},{true,true,true}},np.bool)).T
 local r=np.sqrt(a)
 assert(r.dtype=='float16','sqrt dtype 18 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'sqrt shape 18')
 assert(seqeq(r.strides,{2,6}),'sqrt strides 18')
 assert(veq(r:tolist(),{{1.0,1.0},{1.0,1.0},{1.0,1.0}},2e-3),'sqrt values 18')
end
do -- sqrt supported 19
 local a=np.array({{{false},{true},{true}},{{true},{true},{true}}},np.bool)
 local r=np.sqrt(a)
 assert(r.dtype=='float16','sqrt dtype 19 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 19')
 assert(seqeq(r.strides,{6,2,2}),'sqrt strides 19')
 assert(veq(r:tolist(),{{{0.0},{1.0},{1.0}},{{1.0},{1.0},{1.0}}},2e-3),'sqrt values 19')
end
do -- sqrt supported 20
 local a=np.array({{{0.0},{-1.0},{-0.0}},{{-0.0},{math.huge},{0.5}}},np.float64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 20 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 20')
 assert(seqeq(r.strides,{24,8,8}),'sqrt strides 20')
 assert(veq(r:tolist(),{{{0.0},{(0/0)},{-0.0}},{{-0.0},{math.huge},{0.7071067811865476}}},8e-12),'sqrt values 20')
end
do -- sqrt supported 21
 local a=(np.array({{64,1,0},{0,2,2}},np.uint8)).T
 local r=np.sqrt(a)
 assert(r.dtype=='float16','sqrt dtype 21 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'sqrt shape 21')
 assert(seqeq(r.strides,{2,6}),'sqrt strides 21')
 assert(veq(r:tolist(),{{8.0,0.0},{1.0,1.4140625},{0.0,1.4140625}},2e-3),'sqrt values 21')
end
do -- sqrt supported 22
 local a=np.array({{{64},{16},{16}},{{1},{31},{64}}},np.uint64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 22 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 22')
 assert(seqeq(r.strides,{24,8,8}),'sqrt strides 22')
 assert(veq(r:tolist(),{{{8.0},{4.0},{4.0}},{{1.0},{5.5677643628300215},{8.0}}},8e-12),'sqrt values 22')
end
do -- sqrt supported 23
 local a=np.array({{-3,4,9},{0,-1,-16}},np.int64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 23 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sqrt shape 23')
 assert(seqeq(r.strides,{24,8}),'sqrt strides 23')
 assert(veq(r:tolist(),{{(0/0),2.0,3.0},{0.0,(0/0),(0/0)}},8e-12),'sqrt values 23')
end
do -- sqrt supported 24
 local a=np.array({{{7},{64},{0}},{{16},{16},{64}}},np.uint8)
 local r=np.sqrt(a)
 assert(r.dtype=='float16','sqrt dtype 24 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 24')
 assert(seqeq(r.strides,{6,2,2}),'sqrt strides 24')
 assert(veq(r:tolist(),{{{2.646484375},{8.0},{0.0}},{{4.0},{4.0},{8.0}}},2e-3),'sqrt values 24')
end
do -- sqrt supported 25
 local a=np.array({-7,-1,-7,9,9,-1,2},np.int64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 25 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 25')
 assert(seqeq(r.strides,{8}),'sqrt strides 25')
 assert(veq(r:tolist(),{(0/0),(0/0),(0/0),3.0,3.0,(0/0),1.4142135623730951},8e-12),'sqrt values 25')
end
do -- sqrt supported 26
 local a=np.array({4,1,-1,-3,-16,-1,2},np.int32)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 26 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 26')
 assert(seqeq(r.strides,{8}),'sqrt strides 26')
 assert(veq(r:tolist(),{2.0,1.0,(0/0),(0/0),(0/0),(0/0),1.4142135623730951},8e-12),'sqrt values 26')
end
do -- sqrt supported 27
 local a=np.array({9,-1,16,4,-7,16,-16},np.int32)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 27 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 27')
 assert(seqeq(r.strides,{8}),'sqrt strides 27')
 assert(veq(r:tolist(),{3.0,(0/0),4.0,2.0,(0/0),4.0,(0/0)},8e-12),'sqrt values 27')
end
do -- sqrt supported 28
 local a=np.array({{{4},{-7},{3}},{{-16},{1},{-3}}},np.int32)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 28 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 28')
 assert(seqeq(r.strides,{24,8,8}),'sqrt strides 28')
 assert(veq(r:tolist(),{{{2.0},{(0/0)},{1.7320508075688772}},{{(0/0)},{1.0},{(0/0)}}},8e-12),'sqrt values 28')
end
do -- sqrt supported 29
 local a=np.array({{1.0,0.0,-4.0},{16.0,-0.0,4.0}},np.float16)
 local r=np.sqrt(a)
 assert(r.dtype=='float16','sqrt dtype 29 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sqrt shape 29')
 assert(seqeq(r.strides,{6,2}),'sqrt strides 29')
 assert(veq(r:tolist(),{{1.0,0.0,(0/0)},{4.0,-0.0,2.0}},2e-3),'sqrt values 29')
end
do -- sqrt supported 30
 local a=np.array({0,7,64,31,4,3,31},np.uint64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 30 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 30')
 assert(seqeq(r.strides,{8}),'sqrt strides 30')
 assert(veq(r:tolist(),{0.0,2.6457513110645907,8.0,5.5677643628300215,2.0,1.7320508075688772,5.5677643628300215},8e-12),'sqrt values 30')
end
do -- sqrt supported 31
 local a=np.array({{{0},{0},{-1}},{{3},{2},{2}}},np.int8)
 local r=np.sqrt(a)
 assert(r.dtype=='float16','sqrt dtype 31 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 31')
 assert(seqeq(r.strides,{6,2,2}),'sqrt strides 31')
 assert(veq(r:tolist(),{{{0.0},{0.0},{(0/0)}},{{1.732421875},{1.4140625},{1.4140625}}},2e-3),'sqrt values 31')
end
do -- sqrt supported 32
 local a=np.array({{{16},{16},{4}},{{16},{64},{16}}},np.uint64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 32 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 32')
 assert(seqeq(r.strides,{24,8,8}),'sqrt strides 32')
 assert(veq(r:tolist(),{{{4.0},{4.0},{2.0}},{{4.0},{8.0},{4.0}}},8e-12),'sqrt values 32')
end
do -- sqrt supported 33
 local a=np.array({-0.0,-0.0,-16.0,0.125,0.0,4.0,0.0},np.float32)
 local r=np.sqrt(a)
 assert(r.dtype=='float32','sqrt dtype 33 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 33')
 assert(seqeq(r.strides,{4}),'sqrt strides 33')
 assert(veq(r:tolist(),{-0.0,-0.0,(0/0),0.3535533845424652,0.0,2.0,0.0},2e-5),'sqrt values 33')
end
do -- sqrt supported 34
 local a=np.array({true,false,true,true,false,true,true},np.bool)
 local r=np.sqrt(a)
 assert(r.dtype=='float16','sqrt dtype 34 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 34')
 assert(seqeq(r.strides,{2}),'sqrt strides 34')
 assert(veq(r:tolist(),{1.0,0.0,1.0,1.0,0.0,1.0,1.0},2e-3),'sqrt values 34')
end
do -- sqrt supported 35
 local a=np.array({{16,4,1},{16,-1,4}},np.int32)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 35 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sqrt shape 35')
 assert(seqeq(r.strides,{24,8}),'sqrt strides 35')
 assert(veq(r:tolist(),{{4.0,2.0,1.0},{4.0,(0/0),2.0}},8e-12),'sqrt values 35')
end
do -- sqrt supported 36
 local a=np.array({0.5,1.0,4.0,-4.0,16.0,-16.0,-4.0},np.float32)
 local r=np.sqrt(a)
 assert(r.dtype=='float32','sqrt dtype 36 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 36')
 assert(seqeq(r.strides,{4}),'sqrt strides 36')
 assert(veq(r:tolist(),{0.7071067690849304,1.0,2.0,(0/0),4.0,(0/0),(0/0)},2e-5),'sqrt values 36')
end
do -- sqrt supported 37
 local a=np.array({{{1},{3},{-1}},{{4},{4},{-1}}},np.int64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 37 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 37')
 assert(seqeq(r.strides,{24,8,8}),'sqrt strides 37')
 assert(veq(r:tolist(),{{{1.0},{1.7320508075688772},{(0/0)}},{{2.0},{2.0},{(0/0)}}},8e-12),'sqrt values 37')
end
do -- sqrt supported 38
 local a=(np.array({{-1,-16,-7},{-7,-7,3}},np.int8)).T
 local r=np.sqrt(a)
 assert(r.dtype=='float16','sqrt dtype 38 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'sqrt shape 38')
 assert(seqeq(r.strides,{2,6}),'sqrt strides 38')
 assert(veq(r:tolist(),{{(0/0),(0/0)},{(0/0),(0/0)},{(0/0),1.732421875}},2e-3),'sqrt values 38')
end
do -- sqrt supported 39
 local a=np.array({{{16},{4},{64}},{{64},{4},{1}}},np.uint32)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 39 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 39')
 assert(seqeq(r.strides,{24,8,8}),'sqrt strides 39')
 assert(veq(r:tolist(),{{{4.0},{2.0},{8.0}},{{8.0},{2.0},{1.0}}},8e-12),'sqrt values 39')
end
do -- sqrt supported 40
 local a=np.array({{{4},{-1},{9}},{{3},{-1},{-7}}},np.int32)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 40 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 40')
 assert(seqeq(r.strides,{24,8,8}),'sqrt strides 40')
 assert(veq(r:tolist(),{{{2.0},{(0/0)},{3.0}},{{1.7320508075688772},{(0/0)},{(0/0)}}},8e-12),'sqrt values 40')
end
do -- sqrt supported 41
 local a=np.array({{{0},{-16},{-7}},{{-1},{1},{-3}}},np.int64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 41 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 41')
 assert(seqeq(r.strides,{24,8,8}),'sqrt strides 41')
 assert(veq(r:tolist(),{{{0.0},{(0/0)},{(0/0)}},{{(0/0)},{1.0},{(0/0)}}},8e-12),'sqrt values 41')
end
do -- sqrt supported 42
 local a=np.array({1,16,1,-3,0,-7,4},np.int64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 42 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 42')
 assert(seqeq(r.strides,{8}),'sqrt strides 42')
 assert(veq(r:tolist(),{1.0,4.0,1.0,(0/0),0.0,(0/0),2.0},8e-12),'sqrt values 42')
end
do -- sqrt supported 43
 local a=np.array({{true,true,true},{true,false,true}},np.bool)
 local r=np.sqrt(a)
 assert(r.dtype=='float16','sqrt dtype 43 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sqrt shape 43')
 assert(seqeq(r.strides,{6,2}),'sqrt strides 43')
 assert(veq(r:tolist(),{{1.0,1.0,1.0},{1.0,0.0,1.0}},2e-3),'sqrt values 43')
end
do -- sqrt supported 44
 local a=np.array({{{7},{3},{64}},{{1},{1},{31}}},np.uint64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 44 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 44')
 assert(seqeq(r.strides,{24,8,8}),'sqrt strides 44')
 assert(veq(r:tolist(),{{{2.6457513110645907},{1.7320508075688772},{8.0}},{{1.0},{1.0},{5.5677643628300215}}},8e-12),'sqrt values 44')
end
do -- sqrt supported 45
 local a=np.array({-1.0,-4.0,4.0,1.0,1.0,4.0,1.0},np.float64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 45 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 45')
 assert(seqeq(r.strides,{8}),'sqrt strides 45')
 assert(veq(r:tolist(),{(0/0),(0/0),2.0,1.0,1.0,2.0,1.0},8e-12),'sqrt values 45')
end
do -- sqrt supported 46
 local a=np.array({{{-16},{3},{9}},{{-7},{-3},{-16}}},np.int16)
 local r=np.sqrt(a)
 assert(r.dtype=='float32','sqrt dtype 46 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 46')
 assert(seqeq(r.strides,{12,4,4}),'sqrt strides 46')
 assert(veq(r:tolist(),{{{(0/0)},{1.7320507764816284},{3.0}},{{(0/0)},{(0/0)},{(0/0)}}},2e-5),'sqrt values 46')
end
do -- sqrt supported 47
 local a=np.array({{{-7},{9},{4}},{{-7},{4},{-1}}},np.int64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 47 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 47')
 assert(seqeq(r.strides,{24,8,8}),'sqrt strides 47')
 assert(veq(r:tolist(),{{{(0/0)},{3.0},{2.0}},{{(0/0)},{2.0},{(0/0)}}},8e-12),'sqrt values 47')
end
do -- sqrt supported 48
 local a=np.array({{{4},{1},{4}},{{-7},{-7},{0}}},np.int8)
 local r=np.sqrt(a)
 assert(r.dtype=='float16','sqrt dtype 48 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 48')
 assert(seqeq(r.strides,{6,2,2}),'sqrt strides 48')
 assert(veq(r:tolist(),{{{2.0},{1.0},{2.0}},{{(0/0)},{(0/0)},{0.0}}},2e-3),'sqrt values 48')
end
do -- sqrt supported 49
 local a=np.array({{16,64,3},{3,0,1}},np.uint32)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 49 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sqrt shape 49')
 assert(seqeq(r.strides,{24,8}),'sqrt strides 49')
 assert(veq(r:tolist(),{{4.0,8.0,1.7320508075688772},{1.7320508075688772,0.0,1.0}},8e-12),'sqrt values 49')
end
do -- sqrt supported 50
 local a=np.array({{{16.0},{math.huge},{-1.0}},{{1.0},{-0.0},{16.0}}},np.float32)
 local r=np.sqrt(a)
 assert(r.dtype=='float32','sqrt dtype 50 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 50')
 assert(seqeq(r.strides,{12,4,4}),'sqrt strides 50')
 assert(veq(r:tolist(),{{{4.0},{math.huge},{(0/0)}},{{1.0},{-0.0},{4.0}}},2e-5),'sqrt values 50')
end
do -- sqrt supported 51
 local a=np.array({31,4,64,7,4,3,16},np.uint32)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 51 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 51')
 assert(seqeq(r.strides,{8}),'sqrt strides 51')
 assert(veq(r:tolist(),{5.5677643628300215,2.0,8.0,2.6457513110645907,2.0,1.7320508075688772,4.0},8e-12),'sqrt values 51')
end
do -- sqrt supported 52
 local a=np.array({1,3,4,2,7,0,7},np.uint16)
 local r=np.sqrt(a)
 assert(r.dtype=='float32','sqrt dtype 52 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 52')
 assert(seqeq(r.strides,{4}),'sqrt strides 52')
 assert(veq(r:tolist(),{1.0,1.7320507764816284,2.0,1.4142135381698608,2.6457512378692627,0.0,2.6457512378692627},2e-5),'sqrt values 52')
end
do -- sqrt supported 53
 local a=(np.array({{math.huge,-4.0,2.0},{0.0,0.5,1.0}},np.float16)).T
 local r=np.sqrt(a)
 assert(r.dtype=='float16','sqrt dtype 53 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'sqrt shape 53')
 assert(seqeq(r.strides,{2,6}),'sqrt strides 53')
 assert(veq(r:tolist(),{{math.huge,0.0},{(0/0),0.70703125},{1.4140625,1.0}},2e-3),'sqrt values 53')
end
do -- sqrt supported 54
 local a=np.array({-0.0,2.0,math.huge,-1.0,0.5,16.0,2.0},np.float16)
 local r=np.sqrt(a)
 assert(r.dtype=='float16','sqrt dtype 54 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 54')
 assert(seqeq(r.strides,{2}),'sqrt strides 54')
 assert(veq(r:tolist(),{-0.0,1.4140625,math.huge,(0/0),0.70703125,4.0,1.4140625},2e-3),'sqrt values 54')
end
do -- sqrt supported 55
 local a=np.array({{math.huge,2.0,0.5},{0.5,-16.0,4.0}},np.float16)
 local r=np.sqrt(a)
 assert(r.dtype=='float16','sqrt dtype 55 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sqrt shape 55')
 assert(seqeq(r.strides,{6,2}),'sqrt strides 55')
 assert(veq(r:tolist(),{{math.huge,1.4140625,0.70703125},{0.70703125,(0/0),2.0}},2e-3),'sqrt values 55')
end
do -- sqrt supported 56
 local a=np.array({{{-1},{0},{9}},{{16},{4},{-3}}},np.int32)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 56 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 56')
 assert(seqeq(r.strides,{24,8,8}),'sqrt strides 56')
 assert(veq(r:tolist(),{{{(0/0)},{0.0},{3.0}},{{4.0},{2.0},{(0/0)}}},8e-12),'sqrt values 56')
end
do -- sqrt supported 57
 local a=np.array({-3,-1,2,-3,9,3,4},np.int32)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 57 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 57')
 assert(seqeq(r.strides,{8}),'sqrt strides 57')
 assert(veq(r:tolist(),{(0/0),(0/0),1.4142135623730951,(0/0),3.0,1.7320508075688772,2.0},8e-12),'sqrt values 57')
end
do -- sqrt supported 58
 local a=np.array({0,64,1,4,64,1,16},np.uint32)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 58 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 58')
 assert(seqeq(r.strides,{8}),'sqrt strides 58')
 assert(veq(r:tolist(),{0.0,8.0,1.0,2.0,8.0,1.0,4.0},8e-12),'sqrt values 58')
end
do -- sqrt supported 59
 local a=np.array({{-16,2,-7},{2,2,-1}},np.int64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 59 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sqrt shape 59')
 assert(seqeq(r.strides,{24,8}),'sqrt strides 59')
 assert(veq(r:tolist(),{{(0/0),1.4142135623730951,(0/0)},{1.4142135623730951,1.4142135623730951,(0/0)}},8e-12),'sqrt values 59')
end
do -- sqrt supported 60
 local a=np.array({4,-7,-1,16,3,-7,4},np.int16)
 local r=np.sqrt(a)
 assert(r.dtype=='float32','sqrt dtype 60 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 60')
 assert(seqeq(r.strides,{4}),'sqrt strides 60')
 assert(veq(r:tolist(),{2.0,(0/0),(0/0),4.0,1.7320507764816284,(0/0),2.0},2e-5),'sqrt values 60')
end
do -- sqrt supported 61
 local a=np.array({-7,4,-16,2,9,2,-7},np.int32)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 61 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 61')
 assert(seqeq(r.strides,{8}),'sqrt strides 61')
 assert(veq(r:tolist(),{(0/0),2.0,(0/0),1.4142135623730951,3.0,1.4142135623730951,(0/0)},8e-12),'sqrt values 61')
end
do -- sqrt supported 62
 local a=np.array({{-1.0,-4.0,16.0},{-1.0,4.0,math.huge}},np.float32)
 local r=np.sqrt(a)
 assert(r.dtype=='float32','sqrt dtype 62 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sqrt shape 62')
 assert(seqeq(r.strides,{12,4}),'sqrt strides 62')
 assert(veq(r:tolist(),{{(0/0),(0/0),4.0},{(0/0),2.0,math.huge}},2e-5),'sqrt values 62')
end
do -- sqrt supported 63
 local a=(np.array({{true,true,true},{true,true,true}},np.bool)).T
 local r=np.sqrt(a)
 assert(r.dtype=='float16','sqrt dtype 63 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'sqrt shape 63')
 assert(seqeq(r.strides,{2,6}),'sqrt strides 63')
 assert(veq(r:tolist(),{{1.0,1.0},{1.0,1.0},{1.0,1.0}},2e-3),'sqrt values 63')
end
do -- sqrt supported 64
 local a=np.array({{{true},{true},{false}},{{true},{true},{true}}},np.bool)
 local r=np.sqrt(a)
 assert(r.dtype=='float16','sqrt dtype 64 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 64')
 assert(seqeq(r.strides,{6,2,2}),'sqrt strides 64')
 assert(veq(r:tolist(),{{{1.0},{1.0},{0.0}},{{1.0},{1.0},{1.0}}},2e-3),'sqrt values 64')
end
do -- sqrt supported 65
 local a=np.array({-16.0,1.0,-4.0,2.0,-16.0,0.125,-0.0},np.float64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 65 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 65')
 assert(seqeq(r.strides,{8}),'sqrt strides 65')
 assert(veq(r:tolist(),{(0/0),1.0,(0/0),1.4142135623730951,(0/0),0.3535533905932738,-0.0},8e-12),'sqrt values 65')
end
do -- sqrt supported 66
 local a=np.array({{7,16,7},{7,2,64}},np.uint64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 66 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sqrt shape 66')
 assert(seqeq(r.strides,{24,8}),'sqrt strides 66')
 assert(veq(r:tolist(),{{2.6457513110645907,4.0,2.6457513110645907},{2.6457513110645907,1.4142135623730951,8.0}},8e-12),'sqrt values 66')
end
do -- sqrt supported 67
 local a=np.array({0.5,4.0,2.0,2.0,16.0,-0.0,16.0},np.float64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 67 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 67')
 assert(seqeq(r.strides,{8}),'sqrt strides 67')
 assert(veq(r:tolist(),{0.7071067811865476,2.0,1.4142135623730951,1.4142135623730951,4.0,-0.0,4.0},8e-12),'sqrt values 67')
end
do -- sqrt supported 68
 local a=np.array({{{31},{7},{3}},{{3},{1},{0}}},np.uint32)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 68 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 68')
 assert(seqeq(r.strides,{24,8,8}),'sqrt strides 68')
 assert(veq(r:tolist(),{{{5.5677643628300215},{2.6457513110645907},{1.7320508075688772}},{{1.7320508075688772},{1.0},{0.0}}},8e-12),'sqrt values 68')
end
do -- sqrt supported 69
 local a=(np.array({{-7,-3,3},{9,-3,1}},np.int32)).T
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 69 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'sqrt shape 69')
 assert(seqeq(r.strides,{8,24}),'sqrt strides 69')
 assert(veq(r:tolist(),{{(0/0),3.0},{(0/0),(0/0)},{1.7320508075688772,1.0}},8e-12),'sqrt values 69')
end
do -- sqrt supported 70
 local a=np.array({{{16},{3},{4}},{{9},{16},{3}}},np.int32)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 70 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 70')
 assert(seqeq(r.strides,{24,8,8}),'sqrt strides 70')
 assert(veq(r:tolist(),{{{4.0},{1.7320508075688772},{2.0}},{{3.0},{4.0},{1.7320508075688772}}},8e-12),'sqrt values 70')
end
do -- sqrt supported 71
 local a=np.array({3,4,31,1,1,31,31},np.uint32)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 71 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 71')
 assert(seqeq(r.strides,{8}),'sqrt strides 71')
 assert(veq(r:tolist(),{1.7320508075688772,2.0,5.5677643628300215,1.0,1.0,5.5677643628300215,5.5677643628300215},8e-12),'sqrt values 71')
end
do -- sqrt supported 72
 local a=np.array({{{7},{64},{4}},{{7},{16},{0}}},np.uint64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 72 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sqrt shape 72')
 assert(seqeq(r.strides,{24,8,8}),'sqrt strides 72')
 assert(veq(r:tolist(),{{{2.6457513110645907},{8.0},{2.0}},{{2.6457513110645907},{4.0},{0.0}}},8e-12),'sqrt values 72')
end
do -- sqrt supported 73
 local a=np.array({{false,true,true},{true,true,true}},np.bool)
 local r=np.sqrt(a)
 assert(r.dtype=='float16','sqrt dtype 73 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sqrt shape 73')
 assert(seqeq(r.strides,{6,2}),'sqrt strides 73')
 assert(veq(r:tolist(),{{0.0,1.0,1.0},{1.0,1.0,1.0}},2e-3),'sqrt values 73')
end
do -- sqrt supported 74
 local a=np.array({16,31,7,0,16,4,64},np.uint16)
 local r=np.sqrt(a)
 assert(r.dtype=='float32','sqrt dtype 74 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 74')
 assert(seqeq(r.strides,{4}),'sqrt strides 74')
 assert(veq(r:tolist(),{4.0,5.5677642822265625,2.6457512378692627,0.0,4.0,2.0,8.0},2e-5),'sqrt values 74')
end
do -- sqrt supported 75
 local a=np.array({true,true,true,true,true,true,true},np.bool)
 local r=np.sqrt(a)
 assert(r.dtype=='float16','sqrt dtype 75 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 75')
 assert(seqeq(r.strides,{2}),'sqrt strides 75')
 assert(veq(r:tolist(),{1.0,1.0,1.0,1.0,1.0,1.0,1.0},2e-3),'sqrt values 75')
end
do -- sqrt supported 76
 local a=np.array({{16,64,0},{1,1,4}},np.uint32)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 76 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sqrt shape 76')
 assert(seqeq(r.strides,{24,8}),'sqrt strides 76')
 assert(veq(r:tolist(),{{4.0,8.0,0.0},{1.0,1.0,2.0}},8e-12),'sqrt values 76')
end
do -- sqrt supported 77
 local a=np.array({{0.0,-0.0,16.0},{1.0,4.0,4.0}},np.float16)
 local r=np.sqrt(a)
 assert(r.dtype=='float16','sqrt dtype 77 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sqrt shape 77')
 assert(seqeq(r.strides,{6,2}),'sqrt strides 77')
 assert(veq(r:tolist(),{{0.0,-0.0,4.0},{1.0,2.0,2.0}},2e-3),'sqrt values 77')
end
do -- sqrt supported 78
 local a=(np.array({{16,31,64},{4,64,1}},np.uint16)).T
 local r=np.sqrt(a)
 assert(r.dtype=='float32','sqrt dtype 78 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'sqrt shape 78')
 assert(seqeq(r.strides,{4,12}),'sqrt strides 78')
 assert(veq(r:tolist(),{{4.0,2.0},{5.5677642822265625,8.0},{8.0,1.0}},2e-5),'sqrt values 78')
end
do -- sqrt supported 79
 local a=np.array({-4.0,16.0,-0.0,-16.0,-0.0,-4.0,2.0},np.float32)
 local r=np.sqrt(a)
 assert(r.dtype=='float32','sqrt dtype 79 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 79')
 assert(seqeq(r.strides,{4}),'sqrt strides 79')
 assert(veq(r:tolist(),{(0/0),4.0,-0.0,(0/0),-0.0,(0/0),1.4142135381698608},2e-5),'sqrt values 79')
end
do -- sqrt supported 80
 local a=np.array({-1,-7,4,3,-7,-1,2},np.int16)
 local r=np.sqrt(a)
 assert(r.dtype=='float32','sqrt dtype 80 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 80')
 assert(seqeq(r.strides,{4}),'sqrt strides 80')
 assert(veq(r:tolist(),{(0/0),(0/0),2.0,1.7320507764816284,(0/0),(0/0),1.4142135381698608},2e-5),'sqrt values 80')
end
do -- sqrt supported 81
 local a=np.array({3,4,3,7,4,1,16},np.uint64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','sqrt dtype 81 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sqrt shape 81')
 assert(seqeq(r.strides,{8}),'sqrt strides 81')
 assert(veq(r:tolist(),{1.7320508075688772,2.0,1.7320508075688772,2.6457513110645907,2.0,1.0,4.0},8e-12),'sqrt values 81')
end
do -- exp supported 82
 local a=np.array({31,3,7,3,3,64,2},np.uint8)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 82 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 82')
 assert(seqeq(r.strides,{2}),'exp strides 82')
 assert(veq(r:tolist(),{math.huge,20.078125,1097.0,20.078125,20.078125,math.huge,7.390625},2e-3),'exp values 82')
end
do -- exp supported 83
 local a=np.array({{{1},{16},{31}},{{7},{3},{0}}},np.uint32)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 83 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 83')
 assert(seqeq(r.strides,{24,8,8}),'exp strides 83')
 assert(veq(r:tolist(),{{{2.718281828459045},{8886110.520507872},{29048849665247.426}},{{1096.6331584284585},{20.085536923187668},{1.0}}},8e-12),'exp values 83')
end
do -- exp supported 84
 local a=np.array({16,1,7,2,64,31,2},np.uint64)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 84 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 84')
 assert(seqeq(r.strides,{8}),'exp strides 84')
 assert(veq(r:tolist(),{8886110.520507872,2.718281828459045,1096.6331584284585,7.38905609893065,6.235149080811617e+27,29048849665247.426,7.38905609893065},8e-12),'exp values 84')
end
do -- exp supported 85
 local a=np.array({{{2.0},{1.0},{0.0}},{{-0.0},{2.0},{1.0}}},np.float16)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 85 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 85')
 assert(seqeq(r.strides,{6,2,2}),'exp strides 85')
 assert(veq(r:tolist(),{{{7.390625},{2.71875},{1.0}},{{1.0},{7.390625},{2.71875}}},2e-3),'exp values 85')
end
do -- exp supported 86
 local a=(np.array({{-10.0,0.5,0.5},{0.0,-3.0,-1.0}},np.float64)).T
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 86 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'exp shape 86')
 assert(seqeq(r.strides,{8,24}),'exp strides 86')
 assert(veq(r:tolist(),{{4.5399929762484854e-05,1.0},{1.6487212707001282,0.049787068367863944},{1.6487212707001282,0.36787944117144233}},8e-12),'exp values 86')
end
do -- exp supported 87
 local a=np.array({64,64,2,16,16,64,1},np.uint8)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 87 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 87')
 assert(seqeq(r.strides,{2}),'exp strides 87')
 assert(veq(r:tolist(),{math.huge,math.huge,7.390625,math.huge,math.huge,math.huge,2.71875},2e-3),'exp values 87')
end
do -- exp supported 88
 local a=np.array({{{31},{0},{7}},{{0},{31},{0}}},np.uint8)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 88 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 88')
 assert(seqeq(r.strides,{6,2,2}),'exp strides 88')
 assert(veq(r:tolist(),{{{math.huge},{1.0},{1097.0}},{{1.0},{math.huge},{1.0}}},2e-3),'exp values 88')
end
do -- exp supported 89
 local a=(np.array({{true,false,false},{true,true,false}},np.bool)).T
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 89 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'exp shape 89')
 assert(seqeq(r.strides,{2,6}),'exp strides 89')
 assert(veq(r:tolist(),{{2.71875,2.71875},{1.0,2.71875},{1.0,1.0}},2e-3),'exp values 89')
end
do -- exp supported 90
 local a=np.array({{9,-3,0},{16,16,9}},np.int64)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 90 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'exp shape 90')
 assert(seqeq(r.strides,{24,8}),'exp strides 90')
 assert(veq(r:tolist(),{{8103.083927575384,0.049787068367863944,1.0},{8886110.520507872,8886110.520507872,8103.083927575384}},8e-12),'exp values 90')
end
do -- exp supported 91
 local a=np.array({{{64},{3},{2}},{{3},{31},{16}}},np.uint64)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 91 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 91')
 assert(seqeq(r.strides,{24,8,8}),'exp strides 91')
 assert(veq(r:tolist(),{{{6.235149080811617e+27},{20.085536923187668},{7.38905609893065}},{{20.085536923187668},{29048849665247.426},{8886110.520507872}}},8e-12),'exp values 91')
end
do -- exp supported 92
 local a=np.array({{{-10.0},{0.0},{-0.0}},{{1.0},{-3.0},{-1.0}}},np.float16)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 92 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 92')
 assert(seqeq(r.strides,{6,2,2}),'exp strides 92')
 assert(veq(r:tolist(),{{{4.5418739318847656e-05},{1.0},{1.0}},{{2.71875},{0.049774169921875},{0.367919921875}}},2e-3),'exp values 92')
end
do -- exp supported 93
 local a=np.array({{4,3,1},{64,7,64}},np.uint8)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 93 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'exp shape 93')
 assert(seqeq(r.strides,{6,2}),'exp strides 93')
 assert(veq(r:tolist(),{{54.59375,20.078125,2.71875},{math.huge,1097.0,math.huge}},2e-3),'exp values 93')
end
do -- exp supported 94
 local a=(np.array({{0,1,4},{31,0,2}},np.uint32)).T
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 94 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'exp shape 94')
 assert(seqeq(r.strides,{8,24}),'exp strides 94')
 assert(veq(r:tolist(),{{1.0,29048849665247.426},{2.718281828459045,1.0},{54.598150033144236,7.38905609893065}},8e-12),'exp values 94')
end
do -- exp supported 95
 local a=np.array({-16,0,-16,9,-16,16,3},np.int16)
 local r=np.exp(a)
 assert(r.dtype=='float32','exp dtype 95 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 95')
 assert(seqeq(r.strides,{4}),'exp strides 95')
 assert(veq(r:tolist(),{1.1253516873921399e-07,1.0,1.1253516873921399e-07,8103.083984375,1.1253516873921399e-07,8886111.0,20.08553695678711},2e-5),'exp values 95')
end
do -- exp supported 96
 local a=np.array({{{4},{0},{2}},{{-1},{2},{0}}},np.int32)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 96 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 96')
 assert(seqeq(r.strides,{24,8,8}),'exp strides 96')
 assert(veq(r:tolist(),{{{54.598150033144236},{1.0},{7.38905609893065}},{{0.36787944117144233},{7.38905609893065},{1.0}}},8e-12),'exp values 96')
end
do -- exp supported 97
 local a=(np.array({{1.0,2.0,0.5},{-0.0,1.0,-10.0}},np.float64)).T
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 97 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'exp shape 97')
 assert(seqeq(r.strides,{8,24}),'exp strides 97')
 assert(veq(r:tolist(),{{2.718281828459045,1.0},{7.38905609893065,2.718281828459045},{1.6487212707001282,4.5399929762484854e-05}},8e-12),'exp values 97')
end
do -- exp supported 98
 local a=np.array({2.0,-0.0,0.0,1.0,-10.0,-0.0,0.0},np.float16)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 98 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 98')
 assert(seqeq(r.strides,{2}),'exp strides 98')
 assert(veq(r:tolist(),{7.390625,1.0,1.0,2.71875,4.5418739318847656e-05,1.0,1.0},2e-3),'exp values 98')
end
do -- exp supported 99
 local a=np.array({3,2,3,0,31,3,0},np.uint64)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 99 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 99')
 assert(seqeq(r.strides,{8}),'exp strides 99')
 assert(veq(r:tolist(),{20.085536923187668,7.38905609893065,20.085536923187668,1.0,29048849665247.426,20.085536923187668,1.0},8e-12),'exp values 99')
end
do -- exp supported 100
 local a=np.array({-1,9,-7,0,4,-7,-16},np.int64)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 100 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 100')
 assert(seqeq(r.strides,{8}),'exp strides 100')
 assert(veq(r:tolist(),{0.36787944117144233,8103.083927575384,0.0009118819655545162,1.0,54.598150033144236,0.0009118819655545162,1.1253517471925912e-07},8e-12),'exp values 100')
end
do -- exp supported 101
 local a=np.array({{31,1,4},{16,31,1}},np.uint32)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 101 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'exp shape 101')
 assert(seqeq(r.strides,{24,8}),'exp strides 101')
 assert(veq(r:tolist(),{{29048849665247.426,2.718281828459045,54.598150033144236},{8886110.520507872,29048849665247.426,2.718281828459045}},8e-12),'exp values 101')
end
do -- exp supported 102
 local a=np.array({{{3},{16},{16}},{{3},{31},{2}}},np.uint16)
 local r=np.exp(a)
 assert(r.dtype=='float32','exp dtype 102 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 102')
 assert(seqeq(r.strides,{12,4,4}),'exp strides 102')
 assert(veq(r:tolist(),{{{20.08553695678711},{8886111.0},{8886111.0}},{{20.08553695678711},{29048849825792.0},{7.3890557289123535}}},2e-5),'exp values 102')
end
do -- exp supported 103
 local a=np.array({{{2},{9},{16}},{{-3},{9},{-16}}},np.int64)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 103 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 103')
 assert(seqeq(r.strides,{24,8,8}),'exp strides 103')
 assert(veq(r:tolist(),{{{7.38905609893065},{8103.083927575384},{8886110.520507872}},{{0.049787068367863944},{8103.083927575384},{1.1253517471925912e-07}}},8e-12),'exp values 103')
end
do -- exp supported 104
 local a=np.array({{{2},{64},{16}},{{31},{16},{16}}},np.uint64)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 104 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 104')
 assert(seqeq(r.strides,{24,8,8}),'exp strides 104')
 assert(veq(r:tolist(),{{{7.38905609893065},{6.235149080811617e+27},{8886110.520507872}},{{29048849665247.426},{8886110.520507872},{8886110.520507872}}},8e-12),'exp values 104')
end
do -- exp supported 105
 local a=np.array({9,16,1,-16,0,16,16},np.int8)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 105 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 105')
 assert(seqeq(r.strides,{2}),'exp strides 105')
 assert(veq(r:tolist(),{8104.0,math.huge,2.71875,1.1920928955078125e-07,1.0,math.huge,math.huge},2e-3),'exp values 105')
end
do -- exp supported 106
 local a=(np.array({{64,3,31},{3,0,0}},np.uint8)).T
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 106 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'exp shape 106')
 assert(seqeq(r.strides,{2,6}),'exp strides 106')
 assert(veq(r:tolist(),{{math.huge,20.078125},{20.078125,1.0},{math.huge,1.0}},2e-3),'exp values 106')
end
do -- exp supported 107
 local a=np.array({{{-10.0},{1.0},{1.0}},{{0.0},{-0.0},{-3.0}}},np.float32)
 local r=np.exp(a)
 assert(r.dtype=='float32','exp dtype 107 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 107')
 assert(seqeq(r.strides,{12,4,4}),'exp strides 107')
 assert(veq(r:tolist(),{{{4.539992369245738e-05},{2.7182819843292236},{2.7182819843292236}},{{1.0},{1.0},{0.049787066876888275}}},2e-5),'exp values 107')
end
do -- exp supported 108
 local a=np.array({5.0,0.5,1.0,-10.0,2.0,-10.0,2.0},np.float16)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 108 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 108')
 assert(seqeq(r.strides,{2}),'exp strides 108')
 assert(veq(r:tolist(),{148.375,1.6484375,2.71875,4.5418739318847656e-05,7.390625,4.5418739318847656e-05,7.390625},2e-3),'exp values 108')
end
do -- exp supported 109
 local a=np.array({{{16},{-3},{1}},{{-16},{1},{1}}},np.int32)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 109 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 109')
 assert(seqeq(r.strides,{24,8,8}),'exp strides 109')
 assert(veq(r:tolist(),{{{8886110.520507872},{0.049787068367863944},{2.718281828459045}},{{1.1253517471925912e-07},{2.718281828459045},{2.718281828459045}}},8e-12),'exp values 109')
end
do -- exp supported 110
 local a=np.array({3,2,0,4,3,7,0},np.uint8)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 110 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 110')
 assert(seqeq(r.strides,{2}),'exp strides 110')
 assert(veq(r:tolist(),{20.078125,7.390625,1.0,54.59375,20.078125,1097.0,1.0},2e-3),'exp values 110')
end
do -- exp supported 111
 local a=np.array({{0,16,2},{4,4,7}},np.uint32)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 111 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'exp shape 111')
 assert(seqeq(r.strides,{24,8}),'exp strides 111')
 assert(veq(r:tolist(),{{1.0,8886110.520507872,7.38905609893065},{54.598150033144236,54.598150033144236,1096.6331584284585}},8e-12),'exp values 111')
end
do -- exp supported 112
 local a=np.array({{{3},{4},{16}},{{16},{0},{16}}},np.uint16)
 local r=np.exp(a)
 assert(r.dtype=='float32','exp dtype 112 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 112')
 assert(seqeq(r.strides,{12,4,4}),'exp strides 112')
 assert(veq(r:tolist(),{{{20.08553695678711},{54.598148345947266},{8886111.0}},{{8886111.0},{1.0},{8886111.0}}},2e-5),'exp values 112')
end
do -- exp supported 113
 local a=(np.array({{-7,2,4},{4,3,4}},np.int64)).T
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 113 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'exp shape 113')
 assert(seqeq(r.strides,{8,24}),'exp strides 113')
 assert(veq(r:tolist(),{{0.0009118819655545162,54.598150033144236},{7.38905609893065,20.085536923187668},{54.598150033144236,54.598150033144236}},8e-12),'exp values 113')
end
do -- exp supported 114
 local a=np.array({true,true,true,true,true,false,true},np.bool)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 114 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 114')
 assert(seqeq(r.strides,{2}),'exp strides 114')
 assert(veq(r:tolist(),{2.71875,2.71875,2.71875,2.71875,2.71875,1.0,2.71875},2e-3),'exp values 114')
end
do -- exp supported 115
 local a=np.array({{{-7},{16},{1}},{{9},{-1},{16}}},np.int32)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 115 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 115')
 assert(seqeq(r.strides,{24,8,8}),'exp strides 115')
 assert(veq(r:tolist(),{{{0.0009118819655545162},{8886110.520507872},{2.718281828459045}},{{8103.083927575384},{0.36787944117144233},{8886110.520507872}}},8e-12),'exp values 115')
end
do -- exp supported 116
 local a=np.array({{16,9,-7},{-3,0,-16}},np.int64)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 116 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'exp shape 116')
 assert(seqeq(r.strides,{24,8}),'exp strides 116')
 assert(veq(r:tolist(),{{8886110.520507872,8103.083927575384,0.0009118819655545162},{0.049787068367863944,1.0,1.1253517471925912e-07}},8e-12),'exp values 116')
end
do -- exp supported 117
 local a=np.array({64,1,1,31,0,4,16},np.uint16)
 local r=np.exp(a)
 assert(r.dtype=='float32','exp dtype 117 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 117')
 assert(seqeq(r.strides,{4}),'exp strides 117')
 assert(veq(r:tolist(),{6.23514943204966e+27,2.7182819843292236,2.7182819843292236,29048849825792.0,1.0,54.598148345947266,8886111.0},2e-5),'exp values 117')
end
do -- exp supported 118
 local a=np.array({{{16},{1},{4}},{{16},{7},{1}}},np.uint32)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 118 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 118')
 assert(seqeq(r.strides,{24,8,8}),'exp strides 118')
 assert(veq(r:tolist(),{{{8886110.520507872},{2.718281828459045},{54.598150033144236}},{{8886110.520507872},{1096.6331584284585},{2.718281828459045}}},8e-12),'exp values 118')
end
do -- exp supported 119
 local a=np.array({{{3},{2},{1}},{{16},{0},{1}}},np.uint8)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 119 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 119')
 assert(seqeq(r.strides,{6,2,2}),'exp strides 119')
 assert(veq(r:tolist(),{{{20.078125},{7.390625},{2.71875}},{{math.huge},{1.0},{2.71875}}},2e-3),'exp values 119')
end
do -- exp supported 120
 local a=np.array({16,9,1,-16,16,0,-7},np.int64)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 120 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 120')
 assert(seqeq(r.strides,{8}),'exp strides 120')
 assert(veq(r:tolist(),{8886110.520507872,8103.083927575384,2.718281828459045,1.1253517471925912e-07,8886110.520507872,1.0,0.0009118819655545162},8e-12),'exp values 120')
end
do -- exp supported 121
 local a=np.array({{3,1,16},{-16,1,16}},np.int8)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 121 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'exp shape 121')
 assert(seqeq(r.strides,{6,2}),'exp strides 121')
 assert(veq(r:tolist(),{{20.078125,2.71875,math.huge},{1.1920928955078125e-07,2.71875,math.huge}},2e-3),'exp values 121')
end
do -- exp supported 122
 local a=np.array({{{4},{1},{64}},{{7},{64},{1}}},np.uint16)
 local r=np.exp(a)
 assert(r.dtype=='float32','exp dtype 122 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 122')
 assert(seqeq(r.strides,{12,4,4}),'exp strides 122')
 assert(veq(r:tolist(),{{{54.598148345947266},{2.7182819843292236},{6.23514943204966e+27}},{{1096.6331787109375},{6.23514943204966e+27},{2.7182819843292236}}},2e-5),'exp values 122')
end
do -- exp supported 123
 local a=np.array({{{7},{0},{2}},{{7},{1},{4}}},np.uint8)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 123 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 123')
 assert(seqeq(r.strides,{6,2,2}),'exp strides 123')
 assert(veq(r:tolist(),{{{1097.0},{1.0},{7.390625}},{{1097.0},{2.71875},{54.59375}}},2e-3),'exp values 123')
end
do -- exp supported 124
 local a=np.array({{0,3,-16},{16,2,-7}},np.int16)
 local r=np.exp(a)
 assert(r.dtype=='float32','exp dtype 124 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'exp shape 124')
 assert(seqeq(r.strides,{12,4}),'exp strides 124')
 assert(veq(r:tolist(),{{1.0,20.08553695678711,1.1253516873921399e-07},{8886111.0,7.3890557289123535,0.0009118819143623114}},2e-5),'exp values 124')
end
do -- exp supported 125
 local a=np.array({{{-16},{-16},{9}},{{16},{0},{-7}}},np.int64)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 125 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 125')
 assert(seqeq(r.strides,{24,8,8}),'exp strides 125')
 assert(veq(r:tolist(),{{{1.1253517471925912e-07},{1.1253517471925912e-07},{8103.083927575384}},{{8886110.520507872},{1.0},{0.0009118819655545162}}},8e-12),'exp values 125')
end
do -- exp supported 126
 local a=np.array({{{5.0},{0.0},{1.0}},{{2.0},{-10.0},{-3.0}}},np.float32)
 local r=np.exp(a)
 assert(r.dtype=='float32','exp dtype 126 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 126')
 assert(seqeq(r.strides,{12,4,4}),'exp strides 126')
 assert(veq(r:tolist(),{{{148.4131622314453},{1.0},{2.7182819843292236}},{{7.3890557289123535},{4.539992369245738e-05},{0.049787066876888275}}},2e-5),'exp values 126')
end
do -- exp supported 127
 local a=np.array({5.0,-0.0,-0.0,1.0,2.0,-1.0,-10.0},np.float32)
 local r=np.exp(a)
 assert(r.dtype=='float32','exp dtype 127 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 127')
 assert(seqeq(r.strides,{4}),'exp strides 127')
 assert(veq(r:tolist(),{148.4131622314453,1.0,1.0,2.7182819843292236,7.3890557289123535,0.3678794205188751,4.539992369245738e-05},2e-5),'exp values 127')
end
do -- exp supported 128
 local a=np.array({true,true,false,true,true,true,false},np.bool)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 128 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 128')
 assert(seqeq(r.strides,{2}),'exp strides 128')
 assert(veq(r:tolist(),{2.71875,2.71875,1.0,2.71875,2.71875,2.71875,1.0},2e-3),'exp values 128')
end
do -- exp supported 129
 local a=np.array({-10.0,5.0,0.5,0.0,-3.0,-1.0,-10.0},np.float64)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 129 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 129')
 assert(seqeq(r.strides,{8}),'exp strides 129')
 assert(veq(r:tolist(),{4.5399929762484854e-05,148.4131591025766,1.6487212707001282,1.0,0.049787068367863944,0.36787944117144233,4.5399929762484854e-05},8e-12),'exp values 129')
end
do -- exp supported 130
 local a=np.array({{{true},{true},{true}},{{true},{true},{true}}},np.bool)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 130 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 130')
 assert(seqeq(r.strides,{6,2,2}),'exp strides 130')
 assert(veq(r:tolist(),{{{2.71875},{2.71875},{2.71875}},{{2.71875},{2.71875},{2.71875}}},2e-3),'exp values 130')
end
do -- exp supported 131
 local a=np.array({-16,-1,3,9,4,1,4},np.int16)
 local r=np.exp(a)
 assert(r.dtype=='float32','exp dtype 131 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 131')
 assert(seqeq(r.strides,{4}),'exp strides 131')
 assert(veq(r:tolist(),{1.1253516873921399e-07,0.3678794205188751,20.08553695678711,8103.083984375,54.598148345947266,2.7182819843292236,54.598148345947266},2e-5),'exp values 131')
end
do -- exp supported 132
 local a=np.array({{{-1.0},{0.0},{-1.0}},{{1.0},{-1.0},{-1.0}}},np.float64)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 132 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 132')
 assert(seqeq(r.strides,{24,8,8}),'exp strides 132')
 assert(veq(r:tolist(),{{{0.36787944117144233},{1.0},{0.36787944117144233}},{{2.718281828459045},{0.36787944117144233},{0.36787944117144233}}},8e-12),'exp values 132')
end
do -- exp supported 133
 local a=np.array({{true,true,true},{false,true,true}},np.bool)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 133 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'exp shape 133')
 assert(seqeq(r.strides,{6,2}),'exp strides 133')
 assert(veq(r:tolist(),{{2.71875,2.71875,2.71875},{1.0,2.71875,2.71875}},2e-3),'exp values 133')
end
do -- exp supported 134
 local a=np.array({{true,true,true},{true,true,true}},np.bool)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 134 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'exp shape 134')
 assert(seqeq(r.strides,{6,2}),'exp strides 134')
 assert(veq(r:tolist(),{{2.71875,2.71875,2.71875},{2.71875,2.71875,2.71875}},2e-3),'exp values 134')
end
do -- exp supported 135
 local a=np.array({{{false},{false},{true}},{{true},{false},{true}}},np.bool)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 135 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 135')
 assert(seqeq(r.strides,{6,2,2}),'exp strides 135')
 assert(veq(r:tolist(),{{{1.0},{1.0},{2.71875}},{{2.71875},{1.0},{2.71875}}},2e-3),'exp values 135')
end
do -- exp supported 136
 local a=np.array({{-1,-7,9},{0,9,-3}},np.int64)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 136 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'exp shape 136')
 assert(seqeq(r.strides,{24,8}),'exp strides 136')
 assert(veq(r:tolist(),{{0.36787944117144233,0.0009118819655545162,8103.083927575384},{1.0,8103.083927575384,0.049787068367863944}},8e-12),'exp values 136')
end
do -- exp supported 137
 local a=np.array({{1,64,7},{64,4,16}},np.uint64)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 137 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'exp shape 137')
 assert(seqeq(r.strides,{24,8}),'exp strides 137')
 assert(veq(r:tolist(),{{2.718281828459045,6.235149080811617e+27,1096.6331584284585},{6.235149080811617e+27,54.598150033144236,8886110.520507872}},8e-12),'exp values 137')
end
do -- exp supported 138
 local a=(np.array({{-1.0,-1.0,-1.0},{0.0,0.0,5.0}},np.float32)).T
 local r=np.exp(a)
 assert(r.dtype=='float32','exp dtype 138 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'exp shape 138')
 assert(seqeq(r.strides,{4,12}),'exp strides 138')
 assert(veq(r:tolist(),{{0.3678794205188751,1.0},{0.3678794205188751,1.0},{0.3678794205188751,148.4131622314453}},2e-5),'exp values 138')
end
do -- exp supported 139
 local a=np.array({{{16},{3},{2}},{{0},{2},{2}}},np.int64)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 139 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 139')
 assert(seqeq(r.strides,{24,8,8}),'exp strides 139')
 assert(veq(r:tolist(),{{{8886110.520507872},{20.085536923187668},{7.38905609893065}},{{1.0},{7.38905609893065},{7.38905609893065}}},8e-12),'exp values 139')
end
do -- exp supported 140
 local a=np.array({{{1},{16},{16}},{{16},{64},{2}}},np.uint8)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 140 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 140')
 assert(seqeq(r.strides,{6,2,2}),'exp strides 140')
 assert(veq(r:tolist(),{{{2.71875},{math.huge},{math.huge}},{{math.huge},{math.huge},{7.390625}}},2e-3),'exp values 140')
end
do -- exp supported 141
 local a=np.array({16,2,0,-1,4,1,2},np.int8)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 141 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 141')
 assert(seqeq(r.strides,{2}),'exp strides 141')
 assert(veq(r:tolist(),{math.huge,7.390625,1.0,0.367919921875,54.59375,2.71875,7.390625},2e-3),'exp values 141')
end
do -- exp supported 142
 local a=np.array({-7,0,-16,4,1,3,9},np.int64)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 142 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 142')
 assert(seqeq(r.strides,{8}),'exp strides 142')
 assert(veq(r:tolist(),{0.0009118819655545162,1.0,1.1253517471925912e-07,54.598150033144236,2.718281828459045,20.085536923187668,8103.083927575384},8e-12),'exp values 142')
end
do -- exp supported 143
 local a=np.array({{{64},{3},{7}},{{0},{0},{1}}},np.uint64)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 143 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 143')
 assert(seqeq(r.strides,{24,8,8}),'exp strides 143')
 assert(veq(r:tolist(),{{{6.235149080811617e+27},{20.085536923187668},{1096.6331584284585}},{{1.0},{1.0},{2.718281828459045}}},8e-12),'exp values 143')
end
do -- exp supported 144
 local a=np.array({-16,0,16,0,-16,3,2},np.int8)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 144 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 144')
 assert(seqeq(r.strides,{2}),'exp strides 144')
 assert(veq(r:tolist(),{1.1920928955078125e-07,1.0,math.huge,1.0,1.1920928955078125e-07,20.078125,7.390625},2e-3),'exp values 144')
end
do -- exp supported 145
 local a=np.array({{16,-1,4},{16,16,-1}},np.int32)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 145 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'exp shape 145')
 assert(seqeq(r.strides,{24,8}),'exp strides 145')
 assert(veq(r:tolist(),{{8886110.520507872,0.36787944117144233,54.598150033144236},{8886110.520507872,8886110.520507872,0.36787944117144233}},8e-12),'exp values 145')
end
do -- exp supported 146
 local a=np.array({{{1},{64},{31}},{{3},{31},{0}}},np.uint64)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 146 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 146')
 assert(seqeq(r.strides,{24,8,8}),'exp strides 146')
 assert(veq(r:tolist(),{{{2.718281828459045},{6.235149080811617e+27},{29048849665247.426}},{{20.085536923187668},{29048849665247.426},{1.0}}},8e-12),'exp values 146')
end
do -- exp supported 147
 local a=(np.array({{0.5,0.5,-10.0},{-1.0,0.0,2.0}},np.float32)).T
 local r=np.exp(a)
 assert(r.dtype=='float32','exp dtype 147 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'exp shape 147')
 assert(seqeq(r.strides,{4,12}),'exp strides 147')
 assert(veq(r:tolist(),{{1.6487212181091309,0.3678794205188751},{1.6487212181091309,1.0},{4.539992369245738e-05,7.3890557289123535}},2e-5),'exp values 147')
end
do -- exp supported 148
 local a=np.array({3,3,16,16,2,16,31},np.uint16)
 local r=np.exp(a)
 assert(r.dtype=='float32','exp dtype 148 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 148')
 assert(seqeq(r.strides,{4}),'exp strides 148')
 assert(veq(r:tolist(),{20.08553695678711,20.08553695678711,8886111.0,8886111.0,7.3890557289123535,8886111.0,29048849825792.0},2e-5),'exp values 148')
end
do -- exp supported 149
 local a=np.array({5.0,-1.0,-1.0,-3.0,5.0,2.0,-0.0},np.float32)
 local r=np.exp(a)
 assert(r.dtype=='float32','exp dtype 149 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 149')
 assert(seqeq(r.strides,{4}),'exp strides 149')
 assert(veq(r:tolist(),{148.4131622314453,0.3678794205188751,0.3678794205188751,0.049787066876888275,148.4131622314453,7.3890557289123535,1.0},2e-5),'exp values 149')
end
do -- exp supported 150
 local a=np.array({{{-7},{-1},{4}},{{9},{-1},{4}}},np.int64)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 150 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 150')
 assert(seqeq(r.strides,{24,8,8}),'exp strides 150')
 assert(veq(r:tolist(),{{{0.0009118819655545162},{0.36787944117144233},{54.598150033144236}},{{8103.083927575384},{0.36787944117144233},{54.598150033144236}}},8e-12),'exp values 150')
end
do -- exp supported 151
 local a=np.array({{{3},{-7},{-7}},{{-1},{-1},{2}}},np.int16)
 local r=np.exp(a)
 assert(r.dtype=='float32','exp dtype 151 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 151')
 assert(seqeq(r.strides,{12,4,4}),'exp strides 151')
 assert(veq(r:tolist(),{{{20.08553695678711},{0.0009118819143623114},{0.0009118819143623114}},{{0.3678794205188751},{0.3678794205188751},{7.3890557289123535}}},2e-5),'exp values 151')
end
do -- exp supported 152
 local a=np.array({{{-3},{1},{-16}},{{9},{3},{-7}}},np.int16)
 local r=np.exp(a)
 assert(r.dtype=='float32','exp dtype 152 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 152')
 assert(seqeq(r.strides,{12,4,4}),'exp strides 152')
 assert(veq(r:tolist(),{{{0.049787066876888275},{2.7182819843292236},{1.1253516873921399e-07}},{{8103.083984375},{20.08553695678711},{0.0009118819143623114}}},2e-5),'exp values 152')
end
do -- exp supported 153
 local a=np.array({{3,4,-1},{-7,-1,-16}},np.int8)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 153 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'exp shape 153')
 assert(seqeq(r.strides,{6,2}),'exp strides 153')
 assert(veq(r:tolist(),{{20.078125,54.59375,0.367919921875},{0.000911712646484375,0.367919921875,1.1920928955078125e-07}},2e-3),'exp values 153')
end
do -- exp supported 154
 local a=np.array({{{16},{0},{0}},{{1},{2},{64}}},np.uint16)
 local r=np.exp(a)
 assert(r.dtype=='float32','exp dtype 154 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 154')
 assert(seqeq(r.strides,{12,4,4}),'exp strides 154')
 assert(veq(r:tolist(),{{{8886111.0},{1.0},{1.0}},{{2.7182819843292236},{7.3890557289123535},{6.23514943204966e+27}}},2e-5),'exp values 154')
end
do -- exp supported 155
 local a=np.array({true,true,true,true,true,true,true},np.bool)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 155 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 155')
 assert(seqeq(r.strides,{2}),'exp strides 155')
 assert(veq(r:tolist(),{2.71875,2.71875,2.71875,2.71875,2.71875,2.71875,2.71875},2e-3),'exp values 155')
end
do -- exp supported 156
 local a=(np.array({{16,4,4},{1,0,3}},np.int16)).T
 local r=np.exp(a)
 assert(r.dtype=='float32','exp dtype 156 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'exp shape 156')
 assert(seqeq(r.strides,{4,12}),'exp strides 156')
 assert(veq(r:tolist(),{{8886111.0,2.7182819843292236},{54.598148345947266,1.0},{54.598148345947266,20.08553695678711}},2e-5),'exp values 156')
end
do -- exp supported 157
 local a=np.array({{-7,16,16},{-16,-16,3}},np.int8)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 157 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'exp shape 157')
 assert(seqeq(r.strides,{6,2}),'exp strides 157')
 assert(veq(r:tolist(),{{0.000911712646484375,math.huge,math.huge},{1.1920928955078125e-07,1.1920928955078125e-07,20.078125}},2e-3),'exp values 157')
end
do -- exp supported 158
 local a=np.array({{true,true,true},{true,true,true}},np.bool)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 158 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'exp shape 158')
 assert(seqeq(r.strides,{6,2}),'exp strides 158')
 assert(veq(r:tolist(),{{2.71875,2.71875,2.71875},{2.71875,2.71875,2.71875}},2e-3),'exp values 158')
end
do -- exp supported 159
 local a=np.array({-10.0,-3.0,1.0,-3.0,-3.0,-10.0,1.0},np.float16)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 159 '..r.dtype)
 assert(seqeq(r.shape,{7}),'exp shape 159')
 assert(seqeq(r.strides,{2}),'exp strides 159')
 assert(veq(r:tolist(),{4.5418739318847656e-05,0.049774169921875,2.71875,0.049774169921875,0.049774169921875,4.5418739318847656e-05,2.71875},2e-3),'exp values 159')
end
do -- exp supported 160
 local a=(np.array({{-3.0,0.5,0.0},{-10.0,1.0,0.0}},np.float64)).T
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 160 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'exp shape 160')
 assert(seqeq(r.strides,{8,24}),'exp strides 160')
 assert(veq(r:tolist(),{{0.049787068367863944,4.5399929762484854e-05},{1.6487212707001282,2.718281828459045},{1.0,1.0}},8e-12),'exp values 160')
end
do -- exp supported 161
 local a=np.array({{{-1},{0},{4}},{{4},{3},{0}}},np.int8)
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 161 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 161')
 assert(seqeq(r.strides,{6,2,2}),'exp strides 161')
 assert(veq(r:tolist(),{{{0.367919921875},{1.0},{54.59375}},{{54.59375},{20.078125},{1.0}}},2e-3),'exp values 161')
end
do -- exp supported 162
 local a=np.array({{{-7},{1},{4}},{{4},{-1},{-3}}},np.int32)
 local r=np.exp(a)
 assert(r.dtype=='float64','exp dtype 162 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'exp shape 162')
 assert(seqeq(r.strides,{24,8,8}),'exp strides 162')
 assert(veq(r:tolist(),{{{0.0009118819655545162},{2.718281828459045},{54.598150033144236}},{{54.598150033144236},{0.36787944117144233},{0.049787068367863944}}},8e-12),'exp values 162')
end
do -- exp supported 163
 local a=(np.array({{1,0,7},{7,16,0}},np.uint8)).T
 local r=np.exp(a)
 assert(r.dtype=='float16','exp dtype 163 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'exp shape 163')
 assert(seqeq(r.strides,{2,6}),'exp strides 163')
 assert(veq(r:tolist(),{{2.71875,1097.0},{1.0,math.huge},{1097.0,1.0}},2e-3),'exp values 163')
end
do -- log supported 164
 local a=np.array({{{9},{2},{1}},{{3},{1},{-7}}},np.int64)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 164 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 164')
 assert(seqeq(r.strides,{24,8,8}),'log strides 164')
 assert(veq(r:tolist(),{{{2.1972245773362196},{0.6931471805599453},{0.0}},{{1.0986122886681098},{0.0},{(0/0)}}},8e-12),'log values 164')
end
do -- log supported 165
 local a=(np.array({{1,-16,0},{-7,0,-1}},np.int32)).T
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 165 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'log shape 165')
 assert(seqeq(r.strides,{8,24}),'log strides 165')
 assert(veq(r:tolist(),{{0.0,(0/0)},{(0/0),-math.huge},{-math.huge,(0/0)}},8e-12),'log values 165')
end
do -- log supported 166
 local a=np.array({{{0},{31},{7}},{{1},{1},{1}}},np.uint32)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 166 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 166')
 assert(seqeq(r.strides,{24,8,8}),'log strides 166')
 assert(veq(r:tolist(),{{{-math.huge},{3.4339872044851463},{1.9459101490553132}},{{0.0},{0.0},{0.0}}},8e-12),'log values 166')
end
do -- log supported 167
 local a=np.array({-16.0,-0.0,1.0,-1.0,-4.0,2.0,1.0},np.float32)
 local r=np.log(a)
 assert(r.dtype=='float32','log dtype 167 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 167')
 assert(seqeq(r.strides,{4}),'log strides 167')
 assert(veq(r:tolist(),{(0/0),-math.huge,0.0,(0/0),(0/0),0.6931471824645996,0.0},2e-5),'log values 167')
end
do -- log supported 168
 local a=np.array({1,-16,1,2,3,4,-16},np.int32)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 168 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 168')
 assert(seqeq(r.strides,{8}),'log strides 168')
 assert(veq(r:tolist(),{0.0,(0/0),0.0,0.6931471805599453,1.0986122886681098,1.3862943611198906,(0/0)},8e-12),'log values 168')
end
do -- log supported 169
 local a=np.array({{{2.0},{16.0},{4.0}},{{math.huge},{1.0},{16.0}}},np.float64)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 169 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 169')
 assert(seqeq(r.strides,{24,8,8}),'log strides 169')
 assert(veq(r:tolist(),{{{0.6931471805599453},{2.772588722239781},{1.3862943611198906}},{{math.huge},{0.0},{2.772588722239781}}},8e-12),'log values 169')
end
do -- log supported 170
 local a=np.array({{{-1},{9},{2}},{{1},{-1},{2}}},np.int16)
 local r=np.log(a)
 assert(r.dtype=='float32','log dtype 170 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 170')
 assert(seqeq(r.strides,{12,4,4}),'log strides 170')
 assert(veq(r:tolist(),{{{(0/0)},{2.1972246170043945},{0.6931471824645996}},{{0.0},{(0/0)},{0.6931471824645996}}},2e-5),'log values 170')
end
do -- log supported 171
 local a=np.array({{{16},{7},{64}},{{3},{4},{31}}},np.uint64)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 171 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 171')
 assert(seqeq(r.strides,{24,8,8}),'log strides 171')
 assert(veq(r:tolist(),{{{2.772588722239781},{1.9459101490553132},{4.1588830833596715}},{{1.0986122886681098},{1.3862943611198906},{3.4339872044851463}}},8e-12),'log values 171')
end
do -- log supported 172
 local a=np.array({{{3},{9},{-7}},{{16},{9},{9}}},np.int32)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 172 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 172')
 assert(seqeq(r.strides,{24,8,8}),'log strides 172')
 assert(veq(r:tolist(),{{{1.0986122886681098},{2.1972245773362196},{(0/0)}},{{2.772588722239781},{2.1972245773362196},{2.1972245773362196}}},8e-12),'log values 172')
end
do -- log supported 173
 local a=np.array({{{false},{true},{true}},{{true},{true},{false}}},np.bool)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 173 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 173')
 assert(seqeq(r.strides,{6,2,2}),'log strides 173')
 assert(veq(r:tolist(),{{{-math.huge},{0.0},{0.0}},{{0.0},{0.0},{-math.huge}}},2e-3),'log values 173')
end
do -- log supported 174
 local a=np.array({-1.0,0.125,0.125,0.125,math.huge,0.125,0.5},np.float16)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 174 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 174')
 assert(seqeq(r.strides,{2}),'log strides 174')
 assert(veq(r:tolist(),{(0/0),-2.080078125,-2.080078125,-2.080078125,math.huge,-2.080078125,-0.693359375},2e-3),'log values 174')
end
do -- log supported 175
 local a=np.array({64,4,0,0,7,16,4},np.uint8)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 175 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 175')
 assert(seqeq(r.strides,{2}),'log strides 175')
 assert(veq(r:tolist(),{4.16015625,1.38671875,-math.huge,-math.huge,1.9462890625,2.7734375,1.38671875},2e-3),'log values 175')
end
do -- log supported 176
 local a=(np.array({{0.5,-1.0,0.125},{2.0,4.0,1.0}},np.float64)).T
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 176 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'log shape 176')
 assert(seqeq(r.strides,{8,24}),'log strides 176')
 assert(veq(r:tolist(),{{-0.6931471805599453,0.6931471805599453},{(0/0),1.3862943611198906},{-2.0794415416798357,0.0}},8e-12),'log values 176')
end
do -- log supported 177
 local a=np.array({{3,16,3},{4,7,3}},np.uint64)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 177 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'log shape 177')
 assert(seqeq(r.strides,{24,8}),'log strides 177')
 assert(veq(r:tolist(),{{1.0986122886681098,2.772588722239781,1.0986122886681098},{1.3862943611198906,1.9459101490553132,1.0986122886681098}},8e-12),'log values 177')
end
do -- log supported 178
 local a=np.array({{4.0,4.0,16.0},{16.0,2.0,math.huge}},np.float16)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 178 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'log shape 178')
 assert(seqeq(r.strides,{6,2}),'log strides 178')
 assert(veq(r:tolist(),{{1.38671875,1.38671875,2.7734375},{2.7734375,0.693359375,math.huge}},2e-3),'log values 178')
end
do -- log supported 179
 local a=np.array({3,16,2,-1,4,2,-1},np.int16)
 local r=np.log(a)
 assert(r.dtype=='float32','log dtype 179 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 179')
 assert(seqeq(r.strides,{4}),'log strides 179')
 assert(veq(r:tolist(),{1.0986123085021973,2.7725887298583984,0.6931471824645996,(0/0),1.3862943649291992,0.6931471824645996,(0/0)},2e-5),'log values 179')
end
do -- log supported 180
 local a=(np.array({{16,31,7},{2,3,31}},np.uint32)).T
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 180 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'log shape 180')
 assert(seqeq(r.strides,{8,24}),'log strides 180')
 assert(veq(r:tolist(),{{2.772588722239781,0.6931471805599453},{3.4339872044851463,1.0986122886681098},{1.9459101490553132,3.4339872044851463}},8e-12),'log values 180')
end
do -- log supported 181
 local a=np.array({31,7,16,1,7,7,3},np.uint64)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 181 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 181')
 assert(seqeq(r.strides,{8}),'log strides 181')
 assert(veq(r:tolist(),{3.4339872044851463,1.9459101490553132,2.772588722239781,0.0,1.9459101490553132,1.9459101490553132,1.0986122886681098},8e-12),'log values 181')
end
do -- log supported 182
 local a=np.array({9,2,16,3,16,1,3},np.int64)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 182 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 182')
 assert(seqeq(r.strides,{8}),'log strides 182')
 assert(veq(r:tolist(),{2.1972245773362196,0.6931471805599453,2.772588722239781,1.0986122886681098,2.772588722239781,0.0,1.0986122886681098},8e-12),'log values 182')
end
do -- log supported 183
 local a=np.array({{-7,-7,-16},{-1,3,-1}},np.int32)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 183 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'log shape 183')
 assert(seqeq(r.strides,{24,8}),'log strides 183')
 assert(veq(r:tolist(),{{(0/0),(0/0),(0/0)},{(0/0),1.0986122886681098,(0/0)}},8e-12),'log values 183')
end
do -- log supported 184
 local a=np.array({3,-7,4,-3,-7,-1,1},np.int8)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 184 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 184')
 assert(seqeq(r.strides,{2}),'log strides 184')
 assert(veq(r:tolist(),{1.0986328125,(0/0),1.38671875,(0/0),(0/0),(0/0),0.0},2e-3),'log values 184')
end
do -- log supported 185
 local a=np.array({7,16,16,1,64,7,4},np.uint8)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 185 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 185')
 assert(seqeq(r.strides,{2}),'log strides 185')
 assert(veq(r:tolist(),{1.9462890625,2.7734375,2.7734375,0.0,4.16015625,1.9462890625,1.38671875},2e-3),'log values 185')
end
do -- log supported 186
 local a=np.array({{{0.0},{-4.0},{0.125}},{{0.125},{2.0},{0.5}}},np.float64)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 186 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 186')
 assert(seqeq(r.strides,{24,8,8}),'log strides 186')
 assert(veq(r:tolist(),{{{-math.huge},{(0/0)},{-2.0794415416798357}},{{-2.0794415416798357},{0.6931471805599453},{-0.6931471805599453}}},8e-12),'log values 186')
end
do -- log supported 187
 local a=np.array({-1,16,-7,4,-16,2,4},np.int8)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 187 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 187')
 assert(seqeq(r.strides,{2}),'log strides 187')
 assert(veq(r:tolist(),{(0/0),2.7734375,(0/0),1.38671875,(0/0),0.693359375,1.38671875},2e-3),'log values 187')
end
do -- log supported 188
 local a=np.array({{16,16,0},{9,3,4}},np.int64)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 188 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'log shape 188')
 assert(seqeq(r.strides,{24,8}),'log strides 188')
 assert(veq(r:tolist(),{{2.772588722239781,2.772588722239781,-math.huge},{2.1972245773362196,1.0986122886681098,1.3862943611198906}},8e-12),'log values 188')
end
do -- log supported 189
 local a=np.array({{{-1},{-7},{-3}},{{16},{0},{1}}},np.int8)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 189 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 189')
 assert(seqeq(r.strides,{6,2,2}),'log strides 189')
 assert(veq(r:tolist(),{{{(0/0)},{(0/0)},{(0/0)}},{{2.7734375},{-math.huge},{0.0}}},2e-3),'log values 189')
end
do -- log supported 190
 local a=np.array({{{4},{7},{31}},{{16},{7},{64}}},np.uint8)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 190 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 190')
 assert(seqeq(r.strides,{6,2,2}),'log strides 190')
 assert(veq(r:tolist(),{{{1.38671875},{1.9462890625},{3.43359375}},{{2.7734375},{1.9462890625},{4.16015625}}},2e-3),'log values 190')
end
do -- log supported 191
 local a=np.array({2,16,3,-16,-3,2,-16},np.int8)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 191 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 191')
 assert(seqeq(r.strides,{2}),'log strides 191')
 assert(veq(r:tolist(),{0.693359375,2.7734375,1.0986328125,(0/0),(0/0),0.693359375,(0/0)},2e-3),'log values 191')
end
do -- log supported 192
 local a=(np.array({{math.huge,0.0,16.0},{0.125,16.0,-16.0}},np.float32)).T
 local r=np.log(a)
 assert(r.dtype=='float32','log dtype 192 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'log shape 192')
 assert(seqeq(r.strides,{4,12}),'log strides 192')
 assert(veq(r:tolist(),{{math.huge,-2.079441547393799},{-math.huge,2.7725887298583984},{2.7725887298583984,(0/0)}},2e-5),'log values 192')
end
do -- log supported 193
 local a=np.array({{{16.0},{math.huge},{4.0}},{{1.0},{0.0},{4.0}}},np.float64)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 193 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 193')
 assert(seqeq(r.strides,{24,8,8}),'log strides 193')
 assert(veq(r:tolist(),{{{2.772588722239781},{math.huge},{1.3862943611198906}},{{0.0},{-math.huge},{1.3862943611198906}}},8e-12),'log values 193')
end
do -- log supported 194
 local a=np.array({{{math.huge},{-16.0},{1.0}},{{-16.0},{16.0},{0.5}}},np.float32)
 local r=np.log(a)
 assert(r.dtype=='float32','log dtype 194 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 194')
 assert(seqeq(r.strides,{12,4,4}),'log strides 194')
 assert(veq(r:tolist(),{{{math.huge},{(0/0)},{0.0}},{{(0/0)},{2.7725887298583984},{-0.6931471824645996}}},2e-5),'log values 194')
end
do -- log supported 195
 local a=np.array({2.0,0.125,0.0,-0.0,0.125,-4.0,0.0},np.float64)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 195 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 195')
 assert(seqeq(r.strides,{8}),'log strides 195')
 assert(veq(r:tolist(),{0.6931471805599453,-2.0794415416798357,-math.huge,-math.huge,-2.0794415416798357,(0/0),-math.huge},8e-12),'log values 195')
end
do -- log supported 196
 local a=np.array({{{64},{64},{16}},{{2},{31},{0}}},np.uint8)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 196 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 196')
 assert(seqeq(r.strides,{6,2,2}),'log strides 196')
 assert(veq(r:tolist(),{{{4.16015625},{4.16015625},{2.7734375}},{{0.693359375},{3.43359375},{-math.huge}}},2e-3),'log values 196')
end
do -- log supported 197
 local a=np.array({{{2},{4},{0}},{{0},{1},{3}}},np.uint32)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 197 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 197')
 assert(seqeq(r.strides,{24,8,8}),'log strides 197')
 assert(veq(r:tolist(),{{{0.6931471805599453},{1.3862943611198906},{-math.huge}},{{-math.huge},{0.0},{1.0986122886681098}}},8e-12),'log values 197')
end
do -- log supported 198
 local a=np.array({{{1},{64},{16}},{{16},{16},{0}}},np.uint32)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 198 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 198')
 assert(seqeq(r.strides,{24,8,8}),'log strides 198')
 assert(veq(r:tolist(),{{{0.0},{4.1588830833596715},{2.772588722239781}},{{2.772588722239781},{2.772588722239781},{-math.huge}}},8e-12),'log values 198')
end
do -- log supported 199
 local a=(np.array({{3,4,3},{2,64,16}},np.uint64)).T
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 199 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'log shape 199')
 assert(seqeq(r.strides,{8,24}),'log strides 199')
 assert(veq(r:tolist(),{{1.0986122886681098,0.6931471805599453},{1.3862943611198906,4.1588830833596715},{1.0986122886681098,2.772588722239781}},8e-12),'log values 199')
end
do -- log supported 200
 local a=np.array({{7,4,31},{4,4,64}},np.uint8)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 200 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'log shape 200')
 assert(seqeq(r.strides,{6,2}),'log strides 200')
 assert(veq(r:tolist(),{{1.9462890625,1.38671875,3.43359375},{1.38671875,1.38671875,4.16015625}},2e-3),'log values 200')
end
do -- log supported 201
 local a=np.array({{{2},{1},{4}},{{7},{1},{7}}},np.uint16)
 local r=np.log(a)
 assert(r.dtype=='float32','log dtype 201 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 201')
 assert(seqeq(r.strides,{12,4,4}),'log strides 201')
 assert(veq(r:tolist(),{{{0.6931471824645996},{0.0},{1.3862943649291992}},{{1.9459102153778076},{0.0},{1.9459102153778076}}},2e-5),'log values 201')
end
do -- log supported 202
 local a=np.array({{31,16,64},{7,31,2}},np.uint8)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 202 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'log shape 202')
 assert(seqeq(r.strides,{6,2}),'log strides 202')
 assert(veq(r:tolist(),{{3.43359375,2.7734375,4.16015625},{1.9462890625,3.43359375,0.693359375}},2e-3),'log values 202')
end
do -- log supported 203
 local a=(np.array({{true,true,true},{false,false,true}},np.bool)).T
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 203 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'log shape 203')
 assert(seqeq(r.strides,{2,6}),'log strides 203')
 assert(veq(r:tolist(),{{0.0,-math.huge},{0.0,-math.huge},{0.0,0.0}},2e-3),'log values 203')
end
do -- log supported 204
 local a=np.array({3,16,3,16,3,0,2},np.int16)
 local r=np.log(a)
 assert(r.dtype=='float32','log dtype 204 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 204')
 assert(seqeq(r.strides,{4}),'log strides 204')
 assert(veq(r:tolist(),{1.0986123085021973,2.7725887298583984,1.0986123085021973,2.7725887298583984,1.0986123085021973,-math.huge,0.6931471824645996},2e-5),'log values 204')
end
do -- log supported 205
 local a=np.array({{3,-1,9},{3,9,-3}},np.int32)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 205 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'log shape 205')
 assert(seqeq(r.strides,{24,8}),'log strides 205')
 assert(veq(r:tolist(),{{1.0986122886681098,(0/0),2.1972245773362196},{1.0986122886681098,2.1972245773362196,(0/0)}},8e-12),'log values 205')
end
do -- log supported 206
 local a=np.array({31,2,3,31,64,3,31},np.uint64)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 206 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 206')
 assert(seqeq(r.strides,{8}),'log strides 206')
 assert(veq(r:tolist(),{3.4339872044851463,0.6931471805599453,1.0986122886681098,3.4339872044851463,4.1588830833596715,1.0986122886681098,3.4339872044851463},8e-12),'log values 206')
end
do -- log supported 207
 local a=np.array({16,2,1,9,3,3,-3},np.int32)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 207 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 207')
 assert(seqeq(r.strides,{8}),'log strides 207')
 assert(veq(r:tolist(),{2.772588722239781,0.6931471805599453,0.0,2.1972245773362196,1.0986122886681098,1.0986122886681098,(0/0)},8e-12),'log values 207')
end
do -- log supported 208
 local a=np.array({{{true},{false},{true}},{{true},{true},{true}}},np.bool)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 208 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 208')
 assert(seqeq(r.strides,{6,2,2}),'log strides 208')
 assert(veq(r:tolist(),{{{0.0},{-math.huge},{0.0}},{{0.0},{0.0},{0.0}}},2e-3),'log values 208')
end
do -- log supported 209
 local a=np.array({{{0},{4},{16}},{{2},{1},{31}}},np.uint64)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 209 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 209')
 assert(seqeq(r.strides,{24,8,8}),'log strides 209')
 assert(veq(r:tolist(),{{{-math.huge},{1.3862943611198906},{2.772588722239781}},{{0.6931471805599453},{0.0},{3.4339872044851463}}},8e-12),'log values 209')
end
do -- log supported 210
 local a=np.array({9,9,1,-3,-3,-16,4},np.int64)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 210 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 210')
 assert(seqeq(r.strides,{8}),'log strides 210')
 assert(veq(r:tolist(),{2.1972245773362196,2.1972245773362196,0.0,(0/0),(0/0),(0/0),1.3862943611198906},8e-12),'log values 210')
end
do -- log supported 211
 local a=np.array({{{true},{true},{true}},{{true},{true},{false}}},np.bool)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 211 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 211')
 assert(seqeq(r.strides,{6,2,2}),'log strides 211')
 assert(veq(r:tolist(),{{{0.0},{0.0},{0.0}},{{0.0},{0.0},{-math.huge}}},2e-3),'log values 211')
end
do -- log supported 212
 local a=np.array({4,16,0,16,2,3,-16},np.int8)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 212 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 212')
 assert(seqeq(r.strides,{2}),'log strides 212')
 assert(veq(r:tolist(),{1.38671875,2.7734375,-math.huge,2.7734375,0.693359375,1.0986328125,(0/0)},2e-3),'log values 212')
end
do -- log supported 213
 local a=np.array({16,16,1,-3,16,16,-1},np.int8)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 213 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 213')
 assert(seqeq(r.strides,{2}),'log strides 213')
 assert(veq(r:tolist(),{2.7734375,2.7734375,0.0,(0/0),2.7734375,2.7734375,(0/0)},2e-3),'log values 213')
end
do -- log supported 214
 local a=np.array({{true,false,true},{true,true,true}},np.bool)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 214 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'log shape 214')
 assert(seqeq(r.strides,{6,2}),'log strides 214')
 assert(veq(r:tolist(),{{0.0,-math.huge,0.0},{0.0,0.0,0.0}},2e-3),'log values 214')
end
do -- log supported 215
 local a=np.array({{{2},{3},{16}},{{0},{2},{2}}},np.uint32)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 215 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 215')
 assert(seqeq(r.strides,{24,8,8}),'log strides 215')
 assert(veq(r:tolist(),{{{0.6931471805599453},{1.0986122886681098},{2.772588722239781}},{{-math.huge},{0.6931471805599453},{0.6931471805599453}}},8e-12),'log values 215')
end
do -- log supported 216
 local a=np.array({{{-3},{16},{9}},{{0},{0},{-7}}},np.int8)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 216 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 216')
 assert(seqeq(r.strides,{6,2,2}),'log strides 216')
 assert(veq(r:tolist(),{{{(0/0)},{2.7734375},{2.197265625}},{{-math.huge},{-math.huge},{(0/0)}}},2e-3),'log values 216')
end
do -- log supported 217
 local a=np.array({{{true},{true},{true}},{{true},{true},{true}}},np.bool)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 217 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 217')
 assert(seqeq(r.strides,{6,2,2}),'log strides 217')
 assert(veq(r:tolist(),{{{0.0},{0.0},{0.0}},{{0.0},{0.0},{0.0}}},2e-3),'log values 217')
end
do -- log supported 218
 local a=np.array({{{1},{2},{0}},{{16},{3},{0}}},np.uint16)
 local r=np.log(a)
 assert(r.dtype=='float32','log dtype 218 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 218')
 assert(seqeq(r.strides,{12,4,4}),'log strides 218')
 assert(veq(r:tolist(),{{{0.0},{0.6931471824645996},{-math.huge}},{{2.7725887298583984},{1.0986123085021973},{-math.huge}}},2e-5),'log values 218')
end
do -- log supported 219
 local a=np.array({0.5,0.125,1.0,0.5,-16.0,0.125,0.125},np.float32)
 local r=np.log(a)
 assert(r.dtype=='float32','log dtype 219 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 219')
 assert(seqeq(r.strides,{4}),'log strides 219')
 assert(veq(r:tolist(),{-0.6931471824645996,-2.079441547393799,0.0,-0.6931471824645996,(0/0),-2.079441547393799,-2.079441547393799},2e-5),'log values 219')
end
do -- log supported 220
 local a=np.array({{-3,1,3},{4,16,0}},np.int32)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 220 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'log shape 220')
 assert(seqeq(r.strides,{24,8}),'log strides 220')
 assert(veq(r:tolist(),{{(0/0),0.0,1.0986122886681098},{1.3862943611198906,2.772588722239781,-math.huge}},8e-12),'log values 220')
end
do -- log supported 221
 local a=np.array({0.5,0.0,0.125,-4.0,4.0,-16.0,1.0},np.float16)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 221 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 221')
 assert(seqeq(r.strides,{2}),'log strides 221')
 assert(veq(r:tolist(),{-0.693359375,-math.huge,-2.080078125,(0/0),1.38671875,(0/0),0.0},2e-3),'log values 221')
end
do -- log supported 222
 local a=np.array({4.0,1.0,4.0,4.0,2.0,0.0,0.125},np.float32)
 local r=np.log(a)
 assert(r.dtype=='float32','log dtype 222 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 222')
 assert(seqeq(r.strides,{4}),'log strides 222')
 assert(veq(r:tolist(),{1.3862943649291992,0.0,1.3862943649291992,1.3862943649291992,0.6931471824645996,-math.huge,-2.079441547393799},2e-5),'log values 222')
end
do -- log supported 223
 local a=np.array({-16.0,-1.0,math.huge,-16.0,-4.0,-4.0,-0.0},np.float32)
 local r=np.log(a)
 assert(r.dtype=='float32','log dtype 223 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 223')
 assert(seqeq(r.strides,{4}),'log strides 223')
 assert(veq(r:tolist(),{(0/0),(0/0),math.huge,(0/0),(0/0),(0/0),-math.huge},2e-5),'log values 223')
end
do -- log supported 224
 local a=np.array({{{4.0},{-0.0},{math.huge}},{{-0.0},{1.0},{-16.0}}},np.float32)
 local r=np.log(a)
 assert(r.dtype=='float32','log dtype 224 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 224')
 assert(seqeq(r.strides,{12,4,4}),'log strides 224')
 assert(veq(r:tolist(),{{{1.3862943649291992},{-math.huge},{math.huge}},{{-math.huge},{0.0},{(0/0)}}},2e-5),'log values 224')
end
do -- log supported 225
 local a=np.array({-0.0,2.0,math.huge,2.0,-16.0,-1.0,-1.0},np.float16)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 225 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 225')
 assert(seqeq(r.strides,{2}),'log strides 225')
 assert(veq(r:tolist(),{-math.huge,0.693359375,math.huge,0.693359375,(0/0),(0/0),(0/0)},2e-3),'log values 225')
end
do -- log supported 226
 local a=np.array({-3,1,4,4,16,1,-7},np.int64)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 226 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 226')
 assert(seqeq(r.strides,{8}),'log strides 226')
 assert(veq(r:tolist(),{(0/0),0.0,1.3862943611198906,1.3862943611198906,2.772588722239781,0.0,(0/0)},8e-12),'log values 226')
end
do -- log supported 227
 local a=np.array({{31,1,31},{0,4,3}},np.uint64)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 227 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'log shape 227')
 assert(seqeq(r.strides,{24,8}),'log strides 227')
 assert(veq(r:tolist(),{{3.4339872044851463,0.0,3.4339872044851463},{-math.huge,1.3862943611198906,1.0986122886681098}},8e-12),'log values 227')
end
do -- log supported 228
 local a=np.array({{false,false,true},{true,true,true}},np.bool)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 228 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'log shape 228')
 assert(seqeq(r.strides,{6,2}),'log strides 228')
 assert(veq(r:tolist(),{{-math.huge,-math.huge,0.0},{0.0,0.0,0.0}},2e-3),'log values 228')
end
do -- log supported 229
 local a=np.array({-16,9,-1,-7,4,-7,-1},np.int64)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 229 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 229')
 assert(seqeq(r.strides,{8}),'log strides 229')
 assert(veq(r:tolist(),{(0/0),2.1972245773362196,(0/0),(0/0),1.3862943611198906,(0/0),(0/0)},8e-12),'log values 229')
end
do -- log supported 230
 local a=np.array({31,1,1,16,2,16,16},np.uint16)
 local r=np.log(a)
 assert(r.dtype=='float32','log dtype 230 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 230')
 assert(seqeq(r.strides,{4}),'log strides 230')
 assert(veq(r:tolist(),{3.4339871406555176,0.0,0.0,2.7725887298583984,0.6931471824645996,2.7725887298583984,2.7725887298583984},2e-5),'log values 230')
end
do -- log supported 231
 local a=np.array({{64,7,0},{31,1,2}},np.uint64)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 231 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'log shape 231')
 assert(seqeq(r.strides,{24,8}),'log strides 231')
 assert(veq(r:tolist(),{{4.1588830833596715,1.9459101490553132,-math.huge},{3.4339872044851463,0.0,0.6931471805599453}},8e-12),'log values 231')
end
do -- log supported 232
 local a=np.array({{{4.0},{16.0},{-16.0}},{{-0.0},{16.0},{-1.0}}},np.float64)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 232 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 232')
 assert(seqeq(r.strides,{24,8,8}),'log strides 232')
 assert(veq(r:tolist(),{{{1.3862943611198906},{2.772588722239781},{(0/0)}},{{-math.huge},{2.772588722239781},{(0/0)}}},8e-12),'log values 232')
end
do -- log supported 233
 local a=np.array({{{-1.0},{0.125},{-16.0}},{{4.0},{-4.0},{0.125}}},np.float64)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 233 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 233')
 assert(seqeq(r.strides,{24,8,8}),'log strides 233')
 assert(veq(r:tolist(),{{{(0/0)},{-2.0794415416798357},{(0/0)}},{{1.3862943611198906},{(0/0)},{-2.0794415416798357}}},8e-12),'log values 233')
end
do -- log supported 234
 local a=np.array({{-16.0,2.0,16.0},{-1.0,-4.0,math.huge}},np.float16)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 234 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'log shape 234')
 assert(seqeq(r.strides,{6,2}),'log strides 234')
 assert(veq(r:tolist(),{{(0/0),0.693359375,2.7734375},{(0/0),(0/0),math.huge}},2e-3),'log values 234')
end
do -- log supported 235
 local a=np.array({-0.0,0.5,0.0,16.0,-0.0,-1.0,-4.0},np.float16)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 235 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 235')
 assert(seqeq(r.strides,{2}),'log strides 235')
 assert(veq(r:tolist(),{-math.huge,-0.693359375,-math.huge,2.7734375,-math.huge,(0/0),(0/0)},2e-3),'log values 235')
end
do -- log supported 236
 local a=np.array({{{2},{0},{16}},{{7},{7},{4}}},np.uint64)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 236 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 236')
 assert(seqeq(r.strides,{24,8,8}),'log strides 236')
 assert(veq(r:tolist(),{{{0.6931471805599453},{-math.huge},{2.772588722239781}},{{1.9459101490553132},{1.9459101490553132},{1.3862943611198906}}},8e-12),'log values 236')
end
do -- log supported 237
 local a=(np.array({{16,2,1},{0,2,7}},np.uint32)).T
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 237 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'log shape 237')
 assert(seqeq(r.strides,{8,24}),'log strides 237')
 assert(veq(r:tolist(),{{2.772588722239781,-math.huge},{0.6931471805599453,0.6931471805599453},{0.0,1.9459101490553132}},8e-12),'log values 237')
end
do -- log supported 238
 local a=np.array({{{3},{3},{9}},{{4},{-16},{1}}},np.int8)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 238 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 238')
 assert(seqeq(r.strides,{6,2,2}),'log strides 238')
 assert(veq(r:tolist(),{{{1.0986328125},{1.0986328125},{2.197265625}},{{1.38671875},{(0/0)},{0.0}}},2e-3),'log values 238')
end
do -- log supported 239
 local a=np.array({9,2,2,0,9,0,0},np.int32)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 239 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 239')
 assert(seqeq(r.strides,{8}),'log strides 239')
 assert(veq(r:tolist(),{2.1972245773362196,0.6931471805599453,0.6931471805599453,-math.huge,2.1972245773362196,-math.huge,-math.huge},8e-12),'log values 239')
end
do -- log supported 240
 local a=(np.array({{31,7,16},{1,1,4}},np.uint32)).T
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 240 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'log shape 240')
 assert(seqeq(r.strides,{8,24}),'log strides 240')
 assert(veq(r:tolist(),{{3.4339872044851463,0.0},{1.9459101490553132,0.0},{2.772588722239781,1.3862943611198906}},8e-12),'log values 240')
end
do -- log supported 241
 local a=np.array({9,4,9,1,3,2,1},np.int8)
 local r=np.log(a)
 assert(r.dtype=='float16','log dtype 241 '..r.dtype)
 assert(seqeq(r.shape,{7}),'log shape 241')
 assert(seqeq(r.strides,{2}),'log strides 241')
 assert(veq(r:tolist(),{2.197265625,1.38671875,2.197265625,0.0,1.0986328125,0.693359375,0.0},2e-3),'log values 241')
end
do -- log supported 242
 local a=np.array({{{0},{31},{2}},{{4},{31},{7}}},np.uint64)
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 242 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'log shape 242')
 assert(seqeq(r.strides,{24,8,8}),'log strides 242')
 assert(veq(r:tolist(),{{{-math.huge},{3.4339872044851463},{0.6931471805599453}},{{1.3862943611198906},{3.4339872044851463},{1.9459101490553132}}},8e-12),'log values 242')
end
do -- log supported 243
 local a=(np.array({{16,4,16},{1,3,1}},np.uint32)).T
 local r=np.log(a)
 assert(r.dtype=='float64','log dtype 243 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'log shape 243')
 assert(seqeq(r.strides,{8,24}),'log strides 243')
 assert(veq(r:tolist(),{{2.772588722239781,0.0},{1.3862943611198906,1.0986122886681098},{2.772588722239781,0.0}},8e-12),'log values 243')
end
do -- log supported 244
 local a=np.array({{4.0,0.125,0.0},{-1.0,0.0,-1.0}},np.float32)
 local r=np.log(a)
 assert(r.dtype=='float32','log dtype 244 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'log shape 244')
 assert(seqeq(r.strides,{12,4}),'log strides 244')
 assert(veq(r:tolist(),{{1.3862943649291992,-2.079441547393799,-math.huge},{(0/0),-math.huge,(0/0)}},2e-5),'log values 244')
end
do -- log supported 245
 local a=np.array({{1,64,4},{64,2,64}},np.uint16)
 local r=np.log(a)
 assert(r.dtype=='float32','log dtype 245 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'log shape 245')
 assert(seqeq(r.strides,{12,4}),'log strides 245')
 assert(veq(r:tolist(),{{0.0,4.158883094787598,1.3862943649291992},{4.158883094787598,0.6931471824645996,4.158883094787598}},2e-5),'log values 245')
end
do -- sin supported 246
 local a=np.array({{-6.0,-1.5,3.1415926},{0.5,-0.0,-3.1415926}},np.float64)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 246 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sin shape 246')
 assert(seqeq(r.strides,{24,8}),'sin strides 246')
 assert(veq(r:tolist(),{{0.27941549819892586,-0.9974949866040544,5.3589793170057245e-08},{0.479425538604203,-0.0,-5.3589793170057245e-08}},8e-12),'sin values 246')
end
do -- sin supported 247
 local a=np.array({{{3},{-16},{1}},{{-1},{16},{-7}}},np.int8)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 247 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 247')
 assert(seqeq(r.strides,{6,2,2}),'sin strides 247')
 assert(veq(r:tolist(),{{{0.14111328125},{0.287841796875},{0.84130859375}},{{-0.84130859375},{-0.287841796875},{-0.6572265625}}},2e-3),'sin values 247')
end
do -- sin supported 248
 local a=np.array({-7,1,-7,4,1,16,-3},np.int64)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 248 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 248')
 assert(seqeq(r.strides,{8}),'sin strides 248')
 assert(veq(r:tolist(),{-0.6569865987187891,0.8414709848078965,-0.6569865987187891,-0.7568024953079282,0.8414709848078965,-0.2879033166650653,-0.1411200080598672},8e-12),'sin values 248')
end
do -- sin supported 249
 local a=np.array({2,16,0,-3,3,0,3},np.int32)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 249 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 249')
 assert(seqeq(r.strides,{8}),'sin strides 249')
 assert(veq(r:tolist(),{0.9092974268256817,-0.2879033166650653,0.0,-0.1411200080598672,0.1411200080598672,0.0,0.1411200080598672},8e-12),'sin values 249')
end
do -- sin supported 250
 local a=(np.array({{31,64,31},{7,64,4}},np.uint16)).T
 local r=np.sin(a)
 assert(r.dtype=='float32','sin dtype 250 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'sin shape 250')
 assert(seqeq(r.strides,{4,12}),'sin strides 250')
 assert(veq(r:tolist(),{{-0.4040376543998718,0.6569865942001343},{0.9200260639190674,0.9200260639190674},{-0.4040376543998718,-0.756802499294281}},2e-5),'sin values 250')
end
do -- sin supported 251
 local a=np.array({{{3},{64},{16}},{{1},{1},{4}}},np.uint16)
 local r=np.sin(a)
 assert(r.dtype=='float32','sin dtype 251 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 251')
 assert(seqeq(r.strides,{12,4,4}),'sin strides 251')
 assert(veq(r:tolist(),{{{0.14112000167369843},{0.9200260639190674},{-0.2879033386707306}},{{0.8414710164070129},{0.8414710164070129},{-0.756802499294281}}},2e-5),'sin values 251')
end
do -- sin supported 252
 local a=np.array({{9,3,16},{16,-3,9}},np.int32)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 252 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sin shape 252')
 assert(seqeq(r.strides,{24,8}),'sin strides 252')
 assert(veq(r:tolist(),{{0.4121184852417566,0.1411200080598672,-0.2879033166650653},{-0.2879033166650653,-0.1411200080598672,0.4121184852417566}},8e-12),'sin values 252')
end
do -- sin supported 253
 local a=np.array({{{1},{0},{0}},{{3},{1},{31}}},np.uint32)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 253 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 253')
 assert(seqeq(r.strides,{24,8,8}),'sin strides 253')
 assert(veq(r:tolist(),{{{0.8414709848078965},{0.0},{0.0}},{{0.1411200080598672},{0.8414709848078965},{-0.404037645323065}}},8e-12),'sin values 253')
end
do -- sin supported 254
 local a=np.array({9,-7,0,-1,16,-3,0},np.int16)
 local r=np.sin(a)
 assert(r.dtype=='float32','sin dtype 254 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 254')
 assert(seqeq(r.strides,{4}),'sin strides 254')
 assert(veq(r:tolist(),{0.41211846470832825,-0.6569865942001343,0.0,-0.8414710164070129,-0.2879033386707306,-0.14112000167369843,0.0},2e-5),'sin values 254')
end
do -- sin supported 255
 local a=np.array({1,4,0,-1,1,0,1},np.int32)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 255 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 255')
 assert(seqeq(r.strides,{8}),'sin strides 255')
 assert(veq(r:tolist(),{0.8414709848078965,-0.7568024953079282,0.0,-0.8414709848078965,0.8414709848078965,0.0,0.8414709848078965},8e-12),'sin values 255')
end
do -- sin supported 256
 local a=np.array({{{0.0},{-3.1415926},{-0.0}},{{-1.5},{-3.1415926},{-0.0}}},np.float64)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 256 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 256')
 assert(seqeq(r.strides,{24,8,8}),'sin strides 256')
 assert(veq(r:tolist(),{{{0.0},{-5.3589793170057245e-08},{-0.0}},{{-0.9974949866040544},{-5.3589793170057245e-08},{-0.0}}},8e-12),'sin values 256')
end
do -- sin supported 257
 local a=(np.array({{2,0,3},{16,64,64}},np.uint64)).T
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 257 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'sin shape 257')
 assert(seqeq(r.strides,{8,24}),'sin strides 257')
 assert(veq(r:tolist(),{{0.9092974268256817,-0.2879033166650653},{0.0,0.9200260381967906},{0.1411200080598672,0.9200260381967906}},8e-12),'sin values 257')
end
do -- sin supported 258
 local a=np.array({64,16,2,2,0,4,0},np.uint16)
 local r=np.sin(a)
 assert(r.dtype=='float32','sin dtype 258 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 258')
 assert(seqeq(r.strides,{4}),'sin strides 258')
 assert(veq(r:tolist(),{0.9200260639190674,-0.2879033386707306,0.9092974066734314,0.9092974066734314,0.0,-0.756802499294281,0.0},2e-5),'sin values 258')
end
do -- sin supported 259
 local a=np.array({{{-3},{3},{2}},{{4},{4},{3}}},np.int8)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 259 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 259')
 assert(seqeq(r.strides,{6,2,2}),'sin strides 259')
 assert(veq(r:tolist(),{{{-0.14111328125},{0.14111328125},{0.9091796875}},{{-0.7568359375},{-0.7568359375},{0.14111328125}}},2e-3),'sin values 259')
end
do -- sin supported 260
 local a=np.array({{{1.0},{1.5707963},{-0.0}},{{6.0},{-6.0},{-1.0}}},np.float64)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 260 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 260')
 assert(seqeq(r.strides,{24,8,8}),'sin strides 260')
 assert(veq(r:tolist(),{{{0.8414709848078965},{0.9999999999999997},{-0.0}},{{-0.27941549819892586},{0.27941549819892586},{-0.8414709848078965}}},8e-12),'sin values 260')
end
do -- sin supported 261
 local a=np.array({{{1},{0},{2}},{{0},{2},{31}}},np.uint8)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 261 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 261')
 assert(seqeq(r.strides,{6,2,2}),'sin strides 261')
 assert(veq(r:tolist(),{{{0.84130859375},{0.0},{0.9091796875}},{{0.0},{0.9091796875},{-0.404052734375}}},2e-3),'sin values 261')
end
do -- sin supported 262
 local a=np.array({{{true},{true},{true}},{{true},{true},{true}}},np.bool)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 262 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 262')
 assert(seqeq(r.strides,{6,2,2}),'sin strides 262')
 assert(veq(r:tolist(),{{{0.84130859375},{0.84130859375},{0.84130859375}},{{0.84130859375},{0.84130859375},{0.84130859375}}},2e-3),'sin values 262')
end
do -- sin supported 263
 local a=(np.array({{2,2,3},{16,31,7}},np.uint8)).T
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 263 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'sin shape 263')
 assert(seqeq(r.strides,{2,6}),'sin strides 263')
 assert(veq(r:tolist(),{{0.9091796875,-0.287841796875},{0.9091796875,-0.404052734375},{0.14111328125,0.6572265625}},2e-3),'sin values 263')
end
do -- sin supported 264
 local a=np.array({{{0.5},{0.0},{3.141592502593994}},{{0.0},{6.0},{-0.0}}},np.float32)
 local r=np.sin(a)
 assert(r.dtype=='float32','sin dtype 264 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 264')
 assert(seqeq(r.strides,{12,4,4}),'sin strides 264')
 assert(veq(r:tolist(),{{{0.4794255495071411},{0.0},{1.5099580252808664e-07}},{{0.0},{-0.279415488243103},{-0.0}}},2e-5),'sin values 264')
end
do -- sin supported 265
 local a=np.array({{true,false,true},{true,false,true}},np.bool)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 265 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sin shape 265')
 assert(seqeq(r.strides,{6,2}),'sin strides 265')
 assert(veq(r:tolist(),{{0.84130859375,0.0,0.84130859375},{0.84130859375,0.0,0.84130859375}},2e-3),'sin values 265')
end
do -- sin supported 266
 local a=np.array({{{31},{0},{3}},{{0},{31},{3}}},np.uint8)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 266 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 266')
 assert(seqeq(r.strides,{6,2,2}),'sin strides 266')
 assert(veq(r:tolist(),{{{-0.404052734375},{0.0},{0.14111328125}},{{0.0},{-0.404052734375},{0.14111328125}}},2e-3),'sin values 266')
end
do -- sin supported 267
 local a=np.array({-0.0,-3.141592502593994,-3.141592502593994,0.5,-1.0,3.141592502593994,-1.5},np.float32)
 local r=np.sin(a)
 assert(r.dtype=='float32','sin dtype 267 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 267')
 assert(seqeq(r.strides,{4}),'sin strides 267')
 assert(veq(r:tolist(),{-0.0,-1.5099580252808664e-07,-1.5099580252808664e-07,0.4794255495071411,-0.8414710164070129,1.5099580252808664e-07,-0.9974949955940247},2e-5),'sin values 267')
end
do -- sin supported 268
 local a=np.array({{{0.5},{-1.5},{6.0}},{{-6.0},{1.0},{-1.0}}},np.float16)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 268 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 268')
 assert(seqeq(r.strides,{6,2,2}),'sin strides 268')
 assert(veq(r:tolist(),{{{0.4794921875},{-0.99755859375},{-0.279296875}},{{0.279296875},{0.84130859375},{-0.84130859375}}},2e-3),'sin values 268')
end
do -- sin supported 269
 local a=np.array({{{1},{16},{64}},{{3},{3},{64}}},np.uint32)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 269 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 269')
 assert(seqeq(r.strides,{24,8,8}),'sin strides 269')
 assert(veq(r:tolist(),{{{0.8414709848078965},{-0.2879033166650653},{0.9200260381967906}},{{0.1411200080598672},{0.1411200080598672},{0.9200260381967906}}},8e-12),'sin values 269')
end
do -- sin supported 270
 local a=(np.array({{-0.0,1.5707963,1.5707963},{-1.5,3.1415926,6.0}},np.float64)).T
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 270 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'sin shape 270')
 assert(seqeq(r.strides,{8,24}),'sin strides 270')
 assert(veq(r:tolist(),{{-0.0,-0.9974949866040544},{0.9999999999999997,5.3589793170057245e-08},{0.9999999999999997,-0.27941549819892586}},8e-12),'sin values 270')
end
do -- sin supported 271
 local a=np.array({1.5703125,6.0,-6.0,-3.140625,0.0,0.0,-6.0},np.float16)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 271 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 271')
 assert(seqeq(r.strides,{2}),'sin strides 271')
 assert(veq(r:tolist(),{1.0,-0.279296875,0.279296875,-0.0009675025939941406,0.0,0.0,0.279296875},2e-3),'sin values 271')
end
do -- sin supported 272
 local a=np.array({4,1,3,1,4,3,64},np.uint32)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 272 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 272')
 assert(seqeq(r.strides,{8}),'sin strides 272')
 assert(veq(r:tolist(),{-0.7568024953079282,0.8414709848078965,0.1411200080598672,0.8414709848078965,-0.7568024953079282,0.1411200080598672,0.9200260381967906},8e-12),'sin values 272')
end
do -- sin supported 273
 local a=np.array({{{3},{7},{4}},{{31},{3},{3}}},np.uint16)
 local r=np.sin(a)
 assert(r.dtype=='float32','sin dtype 273 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 273')
 assert(seqeq(r.strides,{12,4,4}),'sin strides 273')
 assert(veq(r:tolist(),{{{0.14112000167369843},{0.6569865942001343},{-0.756802499294281}},{{-0.4040376543998718},{0.14112000167369843},{0.14112000167369843}}},2e-5),'sin values 273')
end
do -- sin supported 274
 local a=np.array({{{3},{0},{7}},{{4},{16},{2}}},np.uint64)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 274 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 274')
 assert(seqeq(r.strides,{24,8,8}),'sin strides 274')
 assert(veq(r:tolist(),{{{0.1411200080598672},{0.0},{0.6569865987187891}},{{-0.7568024953079282},{-0.2879033166650653},{0.9092974268256817}}},8e-12),'sin values 274')
end
do -- sin supported 275
 local a=np.array({16,16,-1,3,16,4,2},np.int8)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 275 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 275')
 assert(seqeq(r.strides,{2}),'sin strides 275')
 assert(veq(r:tolist(),{-0.287841796875,-0.287841796875,-0.84130859375,0.14111328125,-0.287841796875,-0.7568359375,0.9091796875},2e-3),'sin values 275')
end
do -- sin supported 276
 local a=np.array({true,true,true,true,true,true,true},np.bool)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 276 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 276')
 assert(seqeq(r.strides,{2}),'sin strides 276')
 assert(veq(r:tolist(),{0.84130859375,0.84130859375,0.84130859375,0.84130859375,0.84130859375,0.84130859375,0.84130859375},2e-3),'sin values 276')
end
do -- sin supported 277
 local a=np.array({true,true,true,true,true,true,true},np.bool)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 277 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 277')
 assert(seqeq(r.strides,{2}),'sin strides 277')
 assert(veq(r:tolist(),{0.84130859375,0.84130859375,0.84130859375,0.84130859375,0.84130859375,0.84130859375,0.84130859375},2e-3),'sin values 277')
end
do -- sin supported 278
 local a=np.array({{0.5,1.0,-3.141592502593994},{1.0,1.0,0.5}},np.float32)
 local r=np.sin(a)
 assert(r.dtype=='float32','sin dtype 278 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sin shape 278')
 assert(seqeq(r.strides,{12,4}),'sin strides 278')
 assert(veq(r:tolist(),{{0.4794255495071411,0.8414710164070129,-1.5099580252808664e-07},{0.8414710164070129,0.8414710164070129,0.4794255495071411}},2e-5),'sin values 278')
end
do -- sin supported 279
 local a=np.array({true,false,true,true,true,true,true},np.bool)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 279 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 279')
 assert(seqeq(r.strides,{2}),'sin strides 279')
 assert(veq(r:tolist(),{0.84130859375,0.0,0.84130859375,0.84130859375,0.84130859375,0.84130859375,0.84130859375},2e-3),'sin values 279')
end
do -- sin supported 280
 local a=(np.array({{2,-1,4},{9,-16,9}},np.int16)).T
 local r=np.sin(a)
 assert(r.dtype=='float32','sin dtype 280 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'sin shape 280')
 assert(seqeq(r.strides,{4,12}),'sin strides 280')
 assert(veq(r:tolist(),{{0.9092974066734314,0.41211846470832825},{-0.8414710164070129,0.2879033386707306},{-0.756802499294281,0.41211846470832825}},2e-5),'sin values 280')
end
do -- sin supported 281
 local a=np.array({16,9,2,9,-16,-7,-3},np.int32)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 281 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 281')
 assert(seqeq(r.strides,{8}),'sin strides 281')
 assert(veq(r:tolist(),{-0.2879033166650653,0.4121184852417566,0.9092974268256817,0.4121184852417566,0.2879033166650653,-0.6569865987187891,-0.1411200080598672},8e-12),'sin values 281')
end
do -- sin supported 282
 local a=np.array({{2,2,0},{-3,-1,-3}},np.int64)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 282 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sin shape 282')
 assert(seqeq(r.strides,{24,8}),'sin strides 282')
 assert(veq(r:tolist(),{{0.9092974268256817,0.9092974268256817,0.0},{-0.1411200080598672,-0.8414709848078965,-0.1411200080598672}},8e-12),'sin values 282')
end
do -- sin supported 283
 local a=np.array({{{1},{-1},{3}},{{1},{1},{0}}},np.int16)
 local r=np.sin(a)
 assert(r.dtype=='float32','sin dtype 283 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 283')
 assert(seqeq(r.strides,{12,4,4}),'sin strides 283')
 assert(veq(r:tolist(),{{{0.8414710164070129},{-0.8414710164070129},{0.14112000167369843}},{{0.8414710164070129},{0.8414710164070129},{0.0}}},2e-5),'sin values 283')
end
do -- sin supported 284
 local a=np.array({{{true},{true},{true}},{{true},{true},{true}}},np.bool)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 284 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 284')
 assert(seqeq(r.strides,{6,2,2}),'sin strides 284')
 assert(veq(r:tolist(),{{{0.84130859375},{0.84130859375},{0.84130859375}},{{0.84130859375},{0.84130859375},{0.84130859375}}},2e-3),'sin values 284')
end
do -- sin supported 285
 local a=(np.array({{3.1415926,0.0,1.0},{-3.1415926,1.5707963,-3.1415926}},np.float64)).T
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 285 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'sin shape 285')
 assert(seqeq(r.strides,{8,24}),'sin strides 285')
 assert(veq(r:tolist(),{{5.3589793170057245e-08,-5.3589793170057245e-08},{0.0,0.9999999999999997},{0.8414709848078965,-5.3589793170057245e-08}},8e-12),'sin values 285')
end
do -- sin supported 286
 local a=np.array({{64,4,2},{16,1,31}},np.uint16)
 local r=np.sin(a)
 assert(r.dtype=='float32','sin dtype 286 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sin shape 286')
 assert(seqeq(r.strides,{12,4}),'sin strides 286')
 assert(veq(r:tolist(),{{0.9200260639190674,-0.756802499294281,0.9092974066734314},{-0.2879033386707306,0.8414710164070129,-0.4040376543998718}},2e-5),'sin values 286')
end
do -- sin supported 287
 local a=np.array({{{-0.0},{-3.140625},{1.5703125}},{{-1.0},{6.0},{3.140625}}},np.float16)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 287 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 287')
 assert(seqeq(r.strides,{6,2,2}),'sin strides 287')
 assert(veq(r:tolist(),{{{-0.0},{-0.0009675025939941406},{1.0}},{{-0.84130859375},{-0.279296875},{0.0009675025939941406}}},2e-3),'sin values 287')
end
do -- sin supported 288
 local a=np.array({{2,16,16},{2,-3,0}},np.int64)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 288 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sin shape 288')
 assert(seqeq(r.strides,{24,8}),'sin strides 288')
 assert(veq(r:tolist(),{{0.9092974268256817,-0.2879033166650653,-0.2879033166650653},{0.9092974268256817,-0.1411200080598672,0.0}},8e-12),'sin values 288')
end
do -- sin supported 289
 local a=np.array({true,true,true,true,false,true,true},np.bool)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 289 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 289')
 assert(seqeq(r.strides,{2}),'sin strides 289')
 assert(veq(r:tolist(),{0.84130859375,0.84130859375,0.84130859375,0.84130859375,0.0,0.84130859375,0.84130859375},2e-3),'sin values 289')
end
do -- sin supported 290
 local a=np.array({4,0,64,3,1,64,1},np.uint16)
 local r=np.sin(a)
 assert(r.dtype=='float32','sin dtype 290 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 290')
 assert(seqeq(r.strides,{4}),'sin strides 290')
 assert(veq(r:tolist(),{-0.756802499294281,0.0,0.9200260639190674,0.14112000167369843,0.8414710164070129,0.9200260639190674,0.8414710164070129},2e-5),'sin values 290')
end
do -- sin supported 291
 local a=np.array({{{7},{31},{3}},{{2},{64},{31}}},np.uint32)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 291 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 291')
 assert(seqeq(r.strides,{24,8,8}),'sin strides 291')
 assert(veq(r:tolist(),{{{0.6569865987187891},{-0.404037645323065},{0.1411200080598672}},{{0.9092974268256817},{0.9200260381967906},{-0.404037645323065}}},8e-12),'sin values 291')
end
do -- sin supported 292
 local a=np.array({{{3},{0},{16}},{{1},{64},{4}}},np.uint8)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 292 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 292')
 assert(seqeq(r.strides,{6,2,2}),'sin strides 292')
 assert(veq(r:tolist(),{{{0.14111328125},{0.0},{-0.287841796875}},{{0.84130859375},{0.919921875},{-0.7568359375}}},2e-3),'sin values 292')
end
do -- sin supported 293
 local a=np.array({{{-16},{16},{2}},{{16},{-16},{0}}},np.int8)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 293 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 293')
 assert(seqeq(r.strides,{6,2,2}),'sin strides 293')
 assert(veq(r:tolist(),{{{0.287841796875},{-0.287841796875},{0.9091796875}},{{-0.287841796875},{0.287841796875},{0.0}}},2e-3),'sin values 293')
end
do -- sin supported 294
 local a=np.array({{2,16,2},{7,4,31}},np.uint64)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 294 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sin shape 294')
 assert(seqeq(r.strides,{24,8}),'sin strides 294')
 assert(veq(r:tolist(),{{0.9092974268256817,-0.2879033166650653,0.9092974268256817},{0.6569865987187891,-0.7568024953079282,-0.404037645323065}},8e-12),'sin values 294')
end
do -- sin supported 295
 local a=np.array({{7,7,4},{1,1,64}},np.uint16)
 local r=np.sin(a)
 assert(r.dtype=='float32','sin dtype 295 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sin shape 295')
 assert(seqeq(r.strides,{12,4}),'sin strides 295')
 assert(veq(r:tolist(),{{0.6569865942001343,0.6569865942001343,-0.756802499294281},{0.8414710164070129,0.8414710164070129,0.9200260639190674}},2e-5),'sin values 295')
end
do -- sin supported 296
 local a=np.array({{{64},{2},{3}},{{0},{64},{0}}},np.uint16)
 local r=np.sin(a)
 assert(r.dtype=='float32','sin dtype 296 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 296')
 assert(seqeq(r.strides,{12,4,4}),'sin strides 296')
 assert(veq(r:tolist(),{{{0.9200260639190674},{0.9092974066734314},{0.14112000167369843}},{{0.0},{0.9200260639190674},{0.0}}},2e-5),'sin values 296')
end
do -- sin supported 297
 local a=np.array({{{-16},{-7},{1}},{{16},{4},{2}}},np.int32)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 297 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 297')
 assert(seqeq(r.strides,{24,8,8}),'sin strides 297')
 assert(veq(r:tolist(),{{{0.2879033166650653},{-0.6569865987187891},{0.8414709848078965}},{{-0.2879033166650653},{-0.7568024953079282},{0.9092974268256817}}},8e-12),'sin values 297')
end
do -- sin supported 298
 local a=np.array({-3,3,9,-1,3,2,-16},np.int32)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 298 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 298')
 assert(seqeq(r.strides,{8}),'sin strides 298')
 assert(veq(r:tolist(),{-0.1411200080598672,0.1411200080598672,0.4121184852417566,-0.8414709848078965,0.1411200080598672,0.9092974268256817,0.2879033166650653},8e-12),'sin values 298')
end
do -- sin supported 299
 local a=np.array({{{3},{3},{2}},{{0},{1},{7}}},np.uint64)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 299 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 299')
 assert(seqeq(r.strides,{24,8,8}),'sin strides 299')
 assert(veq(r:tolist(),{{{0.1411200080598672},{0.1411200080598672},{0.9092974268256817}},{{0.0},{0.8414709848078965},{0.6569865987187891}}},8e-12),'sin values 299')
end
do -- sin supported 300
 local a=np.array({{{0},{31},{2}},{{64},{0},{31}}},np.uint32)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 300 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 300')
 assert(seqeq(r.strides,{24,8,8}),'sin strides 300')
 assert(veq(r:tolist(),{{{0.0},{-0.404037645323065},{0.9092974268256817}},{{0.9200260381967906},{0.0},{-0.404037645323065}}},8e-12),'sin values 300')
end
do -- sin supported 301
 local a=np.array({{{3},{31},{16}},{{16},{7},{4}}},np.uint16)
 local r=np.sin(a)
 assert(r.dtype=='float32','sin dtype 301 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 301')
 assert(seqeq(r.strides,{12,4,4}),'sin strides 301')
 assert(veq(r:tolist(),{{{0.14112000167369843},{-0.4040376543998718},{-0.2879033386707306}},{{-0.2879033386707306},{0.6569865942001343},{-0.756802499294281}}},2e-5),'sin values 301')
end
do -- sin supported 302
 local a=np.array({{{16},{7},{7}},{{64},{7},{1}}},np.uint32)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 302 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 302')
 assert(seqeq(r.strides,{24,8,8}),'sin strides 302')
 assert(veq(r:tolist(),{{{-0.2879033166650653},{0.6569865987187891},{0.6569865987187891}},{{0.9200260381967906},{0.6569865987187891},{0.8414709848078965}}},8e-12),'sin values 302')
end
do -- sin supported 303
 local a=np.array({6.0,-0.0,-1.5,0.0,0.0,-1.5,1.5707963},np.float64)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 303 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 303')
 assert(seqeq(r.strides,{8}),'sin strides 303')
 assert(veq(r:tolist(),{-0.27941549819892586,-0.0,-0.9974949866040544,0.0,0.0,-0.9974949866040544,0.9999999999999997},8e-12),'sin values 303')
end
do -- sin supported 304
 local a=np.array({{64,4,7},{16,1,7}},np.uint8)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 304 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sin shape 304')
 assert(seqeq(r.strides,{6,2}),'sin strides 304')
 assert(veq(r:tolist(),{{0.919921875,-0.7568359375,0.6572265625},{-0.287841796875,0.84130859375,0.6572265625}},2e-3),'sin values 304')
end
do -- sin supported 305
 local a=np.array({{2,31,16},{31,0,1}},np.uint32)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 305 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sin shape 305')
 assert(seqeq(r.strides,{24,8}),'sin strides 305')
 assert(veq(r:tolist(),{{0.9092974268256817,-0.404037645323065,-0.2879033166650653},{-0.404037645323065,0.0,0.8414709848078965}},8e-12),'sin values 305')
end
do -- sin supported 306
 local a=np.array({{{3},{1},{64}},{{3},{16},{2}}},np.uint16)
 local r=np.sin(a)
 assert(r.dtype=='float32','sin dtype 306 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 306')
 assert(seqeq(r.strides,{12,4,4}),'sin strides 306')
 assert(veq(r:tolist(),{{{0.14112000167369843},{0.8414710164070129},{0.9200260639190674}},{{0.14112000167369843},{-0.2879033386707306},{0.9092974066734314}}},2e-5),'sin values 306')
end
do -- sin supported 307
 local a=np.array({{{true},{true},{true}},{{true},{true},{true}}},np.bool)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 307 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 307')
 assert(seqeq(r.strides,{6,2,2}),'sin strides 307')
 assert(veq(r:tolist(),{{{0.84130859375},{0.84130859375},{0.84130859375}},{{0.84130859375},{0.84130859375},{0.84130859375}}},2e-3),'sin values 307')
end
do -- sin supported 308
 local a=np.array({{{16},{-1},{1}},{{-1},{-7},{-7}}},np.int64)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 308 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 308')
 assert(seqeq(r.strides,{24,8,8}),'sin strides 308')
 assert(veq(r:tolist(),{{{-0.2879033166650653},{-0.8414709848078965},{0.8414709848078965}},{{-0.8414709848078965},{-0.6569865987187891},{-0.6569865987187891}}},8e-12),'sin values 308')
end
do -- sin supported 309
 local a=np.array({{{3},{9},{9}},{{0},{-16},{3}}},np.int8)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 309 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 309')
 assert(seqeq(r.strides,{6,2,2}),'sin strides 309')
 assert(veq(r:tolist(),{{{0.14111328125},{0.412109375},{0.412109375}},{{0.0},{0.287841796875},{0.14111328125}}},2e-3),'sin values 309')
end
do -- sin supported 310
 local a=np.array({64,7,3,2,16,16,4},np.uint8)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 310 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 310')
 assert(seqeq(r.strides,{2}),'sin strides 310')
 assert(veq(r:tolist(),{0.919921875,0.6572265625,0.14111328125,0.9091796875,-0.287841796875,-0.287841796875,-0.7568359375},2e-3),'sin values 310')
end
do -- sin supported 311
 local a=np.array({0.5,3.140625,-1.5,-6.0,-3.140625,1.5703125,0.5},np.float16)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 311 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 311')
 assert(seqeq(r.strides,{2}),'sin strides 311')
 assert(veq(r:tolist(),{0.4794921875,0.0009675025939941406,-0.99755859375,0.279296875,-0.0009675025939941406,1.0,0.4794921875},2e-3),'sin values 311')
end
do -- sin supported 312
 local a=np.array({9,-3,-1,-7,1,4,4},np.int16)
 local r=np.sin(a)
 assert(r.dtype=='float32','sin dtype 312 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 312')
 assert(seqeq(r.strides,{4}),'sin strides 312')
 assert(veq(r:tolist(),{0.41211846470832825,-0.14112000167369843,-0.8414710164070129,-0.6569865942001343,0.8414710164070129,-0.756802499294281,-0.756802499294281},2e-5),'sin values 312')
end
do -- sin supported 313
 local a=np.array({{-1,0,2},{0,9,-3}},np.int8)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 313 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sin shape 313')
 assert(seqeq(r.strides,{6,2}),'sin strides 313')
 assert(veq(r:tolist(),{{-0.84130859375,0.0,0.9091796875},{0.0,0.412109375,-0.14111328125}},2e-3),'sin values 313')
end
do -- sin supported 314
 local a=np.array({{{2},{-7},{9}},{{0},{3},{4}}},np.int32)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 314 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 314')
 assert(seqeq(r.strides,{24,8,8}),'sin strides 314')
 assert(veq(r:tolist(),{{{0.9092974268256817},{-0.6569865987187891},{0.4121184852417566}},{{0.0},{0.1411200080598672},{-0.7568024953079282}}},8e-12),'sin values 314')
end
do -- sin supported 315
 local a=np.array({4,-1,4,-7,4,0,4},np.int16)
 local r=np.sin(a)
 assert(r.dtype=='float32','sin dtype 315 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 315')
 assert(seqeq(r.strides,{4}),'sin strides 315')
 assert(veq(r:tolist(),{-0.756802499294281,-0.8414710164070129,-0.756802499294281,-0.6569865942001343,-0.756802499294281,0.0,-0.756802499294281},2e-5),'sin values 315')
end
do -- sin supported 316
 local a=np.array({{1,-3,4},{9,9,2}},np.int64)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 316 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sin shape 316')
 assert(seqeq(r.strides,{24,8}),'sin strides 316')
 assert(veq(r:tolist(),{{0.8414709848078965,-0.1411200080598672,-0.7568024953079282},{0.4121184852417566,0.4121184852417566,0.9092974268256817}},8e-12),'sin values 316')
end
do -- sin supported 317
 local a=(np.array({{-3.140625,-6.0,-6.0},{3.140625,1.0,-3.140625}},np.float16)).T
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 317 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'sin shape 317')
 assert(seqeq(r.strides,{2,6}),'sin strides 317')
 assert(veq(r:tolist(),{{-0.0009675025939941406,0.0009675025939941406},{0.279296875,0.84130859375},{0.279296875,-0.0009675025939941406}},2e-3),'sin values 317')
end
do -- sin supported 318
 local a=np.array({{{0.5},{3.1415926},{-1.0}},{{6.0},{1.0},{-3.1415926}}},np.float64)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 318 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 318')
 assert(seqeq(r.strides,{24,8,8}),'sin strides 318')
 assert(veq(r:tolist(),{{{0.479425538604203},{5.3589793170057245e-08},{-0.8414709848078965}},{{-0.27941549819892586},{0.8414709848078965},{-5.3589793170057245e-08}}},8e-12),'sin values 318')
end
do -- sin supported 319
 local a=(np.array({{16,16,3},{4,16,2}},np.uint32)).T
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 319 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'sin shape 319')
 assert(seqeq(r.strides,{8,24}),'sin strides 319')
 assert(veq(r:tolist(),{{-0.2879033166650653,-0.7568024953079282},{-0.2879033166650653,-0.2879033166650653},{0.1411200080598672,0.9092974268256817}},8e-12),'sin values 319')
end
do -- sin supported 320
 local a=(np.array({{2,1,9},{2,0,9}},np.int32)).T
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 320 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'sin shape 320')
 assert(seqeq(r.strides,{8,24}),'sin strides 320')
 assert(veq(r:tolist(),{{0.9092974268256817,0.9092974268256817},{0.8414709848078965,0.0},{0.4121184852417566,0.4121184852417566}},8e-12),'sin values 320')
end
do -- sin supported 321
 local a=np.array({{9,2,-16},{1,2,2}},np.int32)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 321 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sin shape 321')
 assert(seqeq(r.strides,{24,8}),'sin strides 321')
 assert(veq(r:tolist(),{{0.4121184852417566,0.9092974268256817,0.2879033166650653},{0.8414709848078965,0.9092974268256817,0.9092974268256817}},8e-12),'sin values 321')
end
do -- sin supported 322
 local a=np.array({3,1,16,64,3,64,64},np.uint16)
 local r=np.sin(a)
 assert(r.dtype=='float32','sin dtype 322 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 322')
 assert(seqeq(r.strides,{4}),'sin strides 322')
 assert(veq(r:tolist(),{0.14112000167369843,0.8414710164070129,-0.2879033386707306,0.9200260639190674,0.14112000167369843,0.9200260639190674,0.9200260639190674},2e-5),'sin values 322')
end
do -- sin supported 323
 local a=np.array({{64,64,3},{4,64,3}},np.uint64)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 323 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sin shape 323')
 assert(seqeq(r.strides,{24,8}),'sin strides 323')
 assert(veq(r:tolist(),{{0.9200260381967906,0.9200260381967906,0.1411200080598672},{-0.7568024953079282,0.9200260381967906,0.1411200080598672}},8e-12),'sin values 323')
end
do -- sin supported 324
 local a=np.array({{{3},{1},{64}},{{3},{16},{3}}},np.uint8)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 324 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'sin shape 324')
 assert(seqeq(r.strides,{6,2,2}),'sin strides 324')
 assert(veq(r:tolist(),{{{0.14111328125},{0.84130859375},{0.919921875}},{{0.14111328125},{-0.287841796875},{0.14111328125}}},2e-3),'sin values 324')
end
do -- sin supported 325
 local a=np.array({{-16,3,-7},{0,-16,-1}},np.int32)
 local r=np.sin(a)
 assert(r.dtype=='float64','sin dtype 325 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sin shape 325')
 assert(seqeq(r.strides,{24,8}),'sin strides 325')
 assert(veq(r:tolist(),{{0.2879033166650653,0.1411200080598672,-0.6569865987187891},{0.0,0.2879033166650653,-0.8414709848078965}},8e-12),'sin values 325')
end
do -- sin supported 326
 local a=np.array({-16,0,4,3,-16,9,0},np.int8)
 local r=np.sin(a)
 assert(r.dtype=='float16','sin dtype 326 '..r.dtype)
 assert(seqeq(r.shape,{7}),'sin shape 326')
 assert(seqeq(r.strides,{2}),'sin strides 326')
 assert(veq(r:tolist(),{0.287841796875,0.0,-0.7568359375,0.14111328125,0.287841796875,0.412109375,0.0},2e-3),'sin values 326')
end
do -- sin supported 327
 local a=np.array({{2,-16,0},{16,-16,2}},np.int16)
 local r=np.sin(a)
 assert(r.dtype=='float32','sin dtype 327 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'sin shape 327')
 assert(seqeq(r.strides,{12,4}),'sin strides 327')
 assert(veq(r:tolist(),{{0.9092974066734314,0.2879033386707306,0.0},{-0.2879033386707306,0.2879033386707306,0.9092974066734314}},2e-5),'sin values 327')
end
do -- cos supported 328
 local a=np.array({-3,-16,2,1,3,1,0},np.int32)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 328 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 328')
 assert(seqeq(r.strides,{8}),'cos strides 328')
 assert(veq(r:tolist(),{-0.9899924966004454,-0.9576594803233847,-0.4161468365471424,0.5403023058681398,-0.9899924966004454,0.5403023058681398,1.0},8e-12),'cos values 328')
end
do -- cos supported 329
 local a=np.array({16,1,2,64,16,0,7},np.uint8)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 329 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 329')
 assert(seqeq(r.strides,{2}),'cos strides 329')
 assert(veq(r:tolist(),{-0.95751953125,0.54052734375,-0.416259765625,0.391845703125,-0.95751953125,1.0,0.75390625},2e-3),'cos values 329')
end
do -- cos supported 330
 local a=np.array({-16,-16,9,9,4,-16,3},np.int16)
 local r=np.cos(a)
 assert(r.dtype=='float32','cos dtype 330 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 330')
 assert(seqeq(r.strides,{4}),'cos strides 330')
 assert(veq(r:tolist(),{-0.9576594829559326,-0.9576594829559326,-0.9111302495002747,-0.9111302495002747,-0.6536436080932617,-0.9576594829559326,-0.9899924993515015},2e-5),'cos values 330')
end
do -- cos supported 331
 local a=np.array({3,0,0,31,31,1,4},np.uint16)
 local r=np.cos(a)
 assert(r.dtype=='float32','cos dtype 331 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 331')
 assert(seqeq(r.strides,{4}),'cos strides 331')
 assert(veq(r:tolist(),{-0.9899924993515015,1.0,1.0,0.9147423505783081,0.9147423505783081,0.5403022766113281,-0.6536436080932617},2e-5),'cos values 331')
end
do -- cos supported 332
 local a=np.array({9,4,2,-3,0,1,0},np.int64)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 332 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 332')
 assert(seqeq(r.strides,{8}),'cos strides 332')
 assert(veq(r:tolist(),{-0.9111302618846769,-0.6536436208636119,-0.4161468365471424,-0.9899924966004454,1.0,0.5403023058681398,1.0},8e-12),'cos values 332')
end
do -- cos supported 333
 local a=np.array({{{-7},{4},{1}},{{-1},{3},{16}}},np.int32)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 333 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'cos shape 333')
 assert(seqeq(r.strides,{24,8,8}),'cos strides 333')
 assert(veq(r:tolist(),{{{0.7539022543433046},{-0.6536436208636119},{0.5403023058681398}},{{0.5403023058681398},{-0.9899924966004454},{-0.9576594803233847}}},8e-12),'cos values 333')
end
do -- cos supported 334
 local a=(np.array({{9,1,-7},{-7,1,3}},np.int16)).T
 local r=np.cos(a)
 assert(r.dtype=='float32','cos dtype 334 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'cos shape 334')
 assert(seqeq(r.strides,{4,12}),'cos strides 334')
 assert(veq(r:tolist(),{{-0.9111302495002747,0.7539022564888},{0.5403022766113281,0.5403022766113281},{0.7539022564888,-0.9899924993515015}},2e-5),'cos values 334')
end
do -- cos supported 335
 local a=np.array({{{3.1415926},{1.5707963},{-6.0}},{{3.1415926},{-1.0},{1.0}}},np.float64)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 335 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'cos shape 335')
 assert(seqeq(r.strides,{24,8,8}),'cos strides 335')
 assert(veq(r:tolist(),{{{-0.9999999999999986},{2.6794896585028633e-08},{0.960170286650366}},{{-0.9999999999999986},{0.5403023058681398},{0.5403023058681398}}},8e-12),'cos values 335')
end
do -- cos supported 336
 local a=(np.array({{false,true,true},{true,true,true}},np.bool)).T
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 336 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'cos shape 336')
 assert(seqeq(r.strides,{2,6}),'cos strides 336')
 assert(veq(r:tolist(),{{1.0,0.54052734375},{0.54052734375,0.54052734375},{0.54052734375,0.54052734375}},2e-3),'cos values 336')
end
do -- cos supported 337
 local a=np.array({{31,2,0},{4,1,1}},np.uint64)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 337 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'cos shape 337')
 assert(seqeq(r.strides,{24,8}),'cos strides 337')
 assert(veq(r:tolist(),{{0.9147423578045313,-0.4161468365471424,1.0},{-0.6536436208636119,0.5403023058681398,0.5403023058681398}},8e-12),'cos values 337')
end
do -- cos supported 338
 local a=np.array({{0,4,16},{16,0,16}},np.uint8)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 338 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'cos shape 338')
 assert(seqeq(r.strides,{6,2}),'cos strides 338')
 assert(veq(r:tolist(),{{1.0,-0.65380859375,-0.95751953125},{-0.95751953125,1.0,-0.95751953125}},2e-3),'cos values 338')
end
do -- cos supported 339
 local a=(np.array({{0,31,7},{0,64,7}},np.uint16)).T
 local r=np.cos(a)
 assert(r.dtype=='float32','cos dtype 339 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'cos shape 339')
 assert(seqeq(r.strides,{4,12}),'cos strides 339')
 assert(veq(r:tolist(),{{1.0,1.0},{0.9147423505783081,0.39185723662376404},{0.7539022564888,0.7539022564888}},2e-5),'cos values 339')
end
do -- cos supported 340
 local a=np.array({{{1},{4},{3}},{{31},{1},{31}}},np.uint16)
 local r=np.cos(a)
 assert(r.dtype=='float32','cos dtype 340 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'cos shape 340')
 assert(seqeq(r.strides,{12,4,4}),'cos strides 340')
 assert(veq(r:tolist(),{{{0.5403022766113281},{-0.6536436080932617},{-0.9899924993515015}},{{0.9147423505783081},{0.5403022766113281},{0.9147423505783081}}},2e-5),'cos values 340')
end
do -- cos supported 341
 local a=np.array({{3.141592502593994,6.0,-6.0},{-3.141592502593994,3.141592502593994,-6.0}},np.float32)
 local r=np.cos(a)
 assert(r.dtype=='float32','cos dtype 341 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'cos shape 341')
 assert(seqeq(r.strides,{12,4}),'cos strides 341')
 assert(veq(r:tolist(),{{-1.0,0.9601702690124512,0.9601702690124512},{-1.0,-1.0,0.9601702690124512}},2e-5),'cos values 341')
end
do -- cos supported 342
 local a=np.array({9,0,-16,-16,-1,3,16},np.int8)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 342 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 342')
 assert(seqeq(r.strides,{2}),'cos strides 342')
 assert(veq(r:tolist(),{-0.9111328125,1.0,-0.95751953125,-0.95751953125,0.54052734375,-0.990234375,-0.95751953125},2e-3),'cos values 342')
end
do -- cos supported 343
 local a=(np.array({{true,true,true},{true,true,true}},np.bool)).T
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 343 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'cos shape 343')
 assert(seqeq(r.strides,{2,6}),'cos strides 343')
 assert(veq(r:tolist(),{{0.54052734375,0.54052734375},{0.54052734375,0.54052734375},{0.54052734375,0.54052734375}},2e-3),'cos values 343')
end
do -- cos supported 344
 local a=np.array({{{true},{true},{true}},{{true},{true},{false}}},np.bool)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 344 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'cos shape 344')
 assert(seqeq(r.strides,{6,2,2}),'cos strides 344')
 assert(veq(r:tolist(),{{{0.54052734375},{0.54052734375},{0.54052734375}},{{0.54052734375},{0.54052734375},{1.0}}},2e-3),'cos values 344')
end
do -- cos supported 345
 local a=np.array({4,4,4,64,7,4,31},np.uint32)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 345 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 345')
 assert(seqeq(r.strides,{8}),'cos strides 345')
 assert(veq(r:tolist(),{-0.6536436208636119,-0.6536436208636119,-0.6536436208636119,0.39185723042955,0.7539022543433046,-0.6536436208636119,0.9147423578045313},8e-12),'cos values 345')
end
do -- cos supported 346
 local a=np.array({{-1.5,0.0,0.5},{1.0,1.0,6.0}},np.float16)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 346 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'cos shape 346')
 assert(seqeq(r.strides,{6,2}),'cos strides 346')
 assert(veq(r:tolist(),{{0.07073974609375,1.0,0.87744140625},{0.54052734375,0.54052734375,0.9599609375}},2e-3),'cos values 346')
end
do -- cos supported 347
 local a=np.array({{{1.570796251296997},{1.570796251296997},{6.0}},{{-0.0},{-1.5},{3.141592502593994}}},np.float32)
 local r=np.cos(a)
 assert(r.dtype=='float32','cos dtype 347 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'cos shape 347')
 assert(seqeq(r.strides,{12,4,4}),'cos strides 347')
 assert(veq(r:tolist(),{{{7.549790126404332e-08},{7.549790126404332e-08},{0.9601702690124512}},{{1.0},{0.07073719799518585},{-1.0}}},2e-5),'cos values 347')
end
do -- cos supported 348
 local a=np.array({{true,true,true},{true,true,true}},np.bool)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 348 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'cos shape 348')
 assert(seqeq(r.strides,{6,2}),'cos strides 348')
 assert(veq(r:tolist(),{{0.54052734375,0.54052734375,0.54052734375},{0.54052734375,0.54052734375,0.54052734375}},2e-3),'cos values 348')
end
do -- cos supported 349
 local a=np.array({0,31,0,7,3,3,64},np.uint8)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 349 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 349')
 assert(seqeq(r.strides,{2}),'cos strides 349')
 assert(veq(r:tolist(),{1.0,0.91455078125,1.0,0.75390625,-0.990234375,-0.990234375,0.391845703125},2e-3),'cos values 349')
end
do -- cos supported 350
 local a=np.array({31,3,64,0,7,4,7},np.uint32)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 350 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 350')
 assert(seqeq(r.strides,{8}),'cos strides 350')
 assert(veq(r:tolist(),{0.9147423578045313,-0.9899924966004454,0.39185723042955,1.0,0.7539022543433046,-0.6536436208636119,0.7539022543433046},8e-12),'cos values 350')
end
do -- cos supported 351
 local a=np.array({4,0,1,4,-1,1,2},np.int8)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 351 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 351')
 assert(seqeq(r.strides,{2}),'cos strides 351')
 assert(veq(r:tolist(),{-0.65380859375,1.0,0.54052734375,-0.65380859375,0.54052734375,0.54052734375,-0.416259765625},2e-3),'cos values 351')
end
do -- cos supported 352
 local a=np.array({3,4,-3,2,3,1,16},np.int64)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 352 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 352')
 assert(seqeq(r.strides,{8}),'cos strides 352')
 assert(veq(r:tolist(),{-0.9899924966004454,-0.6536436208636119,-0.9899924966004454,-0.4161468365471424,-0.9899924966004454,0.5403023058681398,-0.9576594803233847},8e-12),'cos values 352')
end
do -- cos supported 353
 local a=np.array({true,true,false,false,true,true,true},np.bool)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 353 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 353')
 assert(seqeq(r.strides,{2}),'cos strides 353')
 assert(veq(r:tolist(),{0.54052734375,0.54052734375,1.0,1.0,0.54052734375,0.54052734375,0.54052734375},2e-3),'cos values 353')
end
do -- cos supported 354
 local a=np.array({31,7,1,7,1,31,31},np.uint16)
 local r=np.cos(a)
 assert(r.dtype=='float32','cos dtype 354 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 354')
 assert(seqeq(r.strides,{4}),'cos strides 354')
 assert(veq(r:tolist(),{0.9147423505783081,0.7539022564888,0.5403022766113281,0.7539022564888,0.5403022766113281,0.9147423505783081,0.9147423505783081},2e-5),'cos values 354')
end
do -- cos supported 355
 local a=np.array({{3,3,31},{4,3,1}},np.uint32)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 355 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'cos shape 355')
 assert(seqeq(r.strides,{24,8}),'cos strides 355')
 assert(veq(r:tolist(),{{-0.9899924966004454,-0.9899924966004454,0.9147423578045313},{-0.6536436208636119,-0.9899924966004454,0.5403023058681398}},8e-12),'cos values 355')
end
do -- cos supported 356
 local a=np.array({{1,3,-16},{3,9,16}},np.int16)
 local r=np.cos(a)
 assert(r.dtype=='float32','cos dtype 356 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'cos shape 356')
 assert(seqeq(r.strides,{12,4}),'cos strides 356')
 assert(veq(r:tolist(),{{0.5403022766113281,-0.9899924993515015,-0.9576594829559326},{-0.9899924993515015,-0.9111302495002747,-0.9576594829559326}},2e-5),'cos values 356')
end
do -- cos supported 357
 local a=np.array({true,true,true,true,true,false,true},np.bool)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 357 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 357')
 assert(seqeq(r.strides,{2}),'cos strides 357')
 assert(veq(r:tolist(),{0.54052734375,0.54052734375,0.54052734375,0.54052734375,0.54052734375,1.0,0.54052734375},2e-3),'cos values 357')
end
do -- cos supported 358
 local a=(np.array({{3.141592502593994,1.0,-1.0},{1.0,1.570796251296997,-1.5}},np.float32)).T
 local r=np.cos(a)
 assert(r.dtype=='float32','cos dtype 358 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'cos shape 358')
 assert(seqeq(r.strides,{4,12}),'cos strides 358')
 assert(veq(r:tolist(),{{-1.0,0.5403022766113281},{0.5403022766113281,7.549790126404332e-08},{0.5403022766113281,0.07073719799518585}},2e-5),'cos values 358')
end
do -- cos supported 359
 local a=np.array({{{6.0},{-1.5},{6.0}},{{1.0},{-1.0},{-0.0}}},np.float16)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 359 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'cos shape 359')
 assert(seqeq(r.strides,{6,2,2}),'cos strides 359')
 assert(veq(r:tolist(),{{{0.9599609375},{0.07073974609375},{0.9599609375}},{{0.54052734375},{0.54052734375},{1.0}}},2e-3),'cos values 359')
end
do -- cos supported 360
 local a=np.array({0,31,1,16,1,7,3},np.uint16)
 local r=np.cos(a)
 assert(r.dtype=='float32','cos dtype 360 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 360')
 assert(seqeq(r.strides,{4}),'cos strides 360')
 assert(veq(r:tolist(),{1.0,0.9147423505783081,0.5403022766113281,-0.9576594829559326,0.5403022766113281,0.7539022564888,-0.9899924993515015},2e-5),'cos values 360')
end
do -- cos supported 361
 local a=np.array({{{3},{2},{4}},{{3},{4},{4}}},np.uint8)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 361 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'cos shape 361')
 assert(seqeq(r.strides,{6,2,2}),'cos strides 361')
 assert(veq(r:tolist(),{{{-0.990234375},{-0.416259765625},{-0.65380859375}},{{-0.990234375},{-0.65380859375},{-0.65380859375}}},2e-3),'cos values 361')
end
do -- cos supported 362
 local a=(np.array({{6.0,-1.5,0.5},{1.0,-0.0,-3.1415926}},np.float64)).T
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 362 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'cos shape 362')
 assert(seqeq(r.strides,{8,24}),'cos strides 362')
 assert(veq(r:tolist(),{{0.960170286650366,0.5403023058681398},{0.0707372016677029,1.0},{0.8775825618903728,-0.9999999999999986}},8e-12),'cos values 362')
end
do -- cos supported 363
 local a=np.array({{{3},{31},{7}},{{31},{16},{3}}},np.uint8)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 363 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'cos shape 363')
 assert(seqeq(r.strides,{6,2,2}),'cos strides 363')
 assert(veq(r:tolist(),{{{-0.990234375},{0.91455078125},{0.75390625}},{{0.91455078125},{-0.95751953125},{-0.990234375}}},2e-3),'cos values 363')
end
do -- cos supported 364
 local a=np.array({true,true,true,true,true,true,true},np.bool)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 364 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 364')
 assert(seqeq(r.strides,{2}),'cos strides 364')
 assert(veq(r:tolist(),{0.54052734375,0.54052734375,0.54052734375,0.54052734375,0.54052734375,0.54052734375,0.54052734375},2e-3),'cos values 364')
end
do -- cos supported 365
 local a=np.array({0.0,-6.0,0.0,-0.0,-1.5,0.0,0.5},np.float16)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 365 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 365')
 assert(seqeq(r.strides,{2}),'cos strides 365')
 assert(veq(r:tolist(),{1.0,0.9599609375,1.0,1.0,0.07073974609375,1.0,0.87744140625},2e-3),'cos values 365')
end
do -- cos supported 366
 local a=np.array({{{4},{0},{4}},{{1},{16},{2}}},np.uint64)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 366 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'cos shape 366')
 assert(seqeq(r.strides,{24,8,8}),'cos strides 366')
 assert(veq(r:tolist(),{{{-0.6536436208636119},{1.0},{-0.6536436208636119}},{{0.5403023058681398},{-0.9576594803233847},{-0.4161468365471424}}},8e-12),'cos values 366')
end
do -- cos supported 367
 local a=(np.array({{64,2,31},{16,3,0}},np.uint8)).T
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 367 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'cos shape 367')
 assert(seqeq(r.strides,{2,6}),'cos strides 367')
 assert(veq(r:tolist(),{{0.391845703125,-0.95751953125},{-0.416259765625,-0.990234375},{0.91455078125,1.0}},2e-3),'cos values 367')
end
do -- cos supported 368
 local a=(np.array({{-1.5,6.0,-3.141592502593994},{6.0,1.570796251296997,3.141592502593994}},np.float32)).T
 local r=np.cos(a)
 assert(r.dtype=='float32','cos dtype 368 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'cos shape 368')
 assert(seqeq(r.strides,{4,12}),'cos strides 368')
 assert(veq(r:tolist(),{{0.07073719799518585,0.9601702690124512},{0.9601702690124512,7.549790126404332e-08},{-1.0,-1.0}},2e-5),'cos values 368')
end
do -- cos supported 369
 local a=np.array({{1,-16,1},{-16,-1,9}},np.int16)
 local r=np.cos(a)
 assert(r.dtype=='float32','cos dtype 369 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'cos shape 369')
 assert(seqeq(r.strides,{12,4}),'cos strides 369')
 assert(veq(r:tolist(),{{0.5403022766113281,-0.9576594829559326,0.5403022766113281},{-0.9576594829559326,0.5403022766113281,-0.9111302495002747}},2e-5),'cos values 369')
end
do -- cos supported 370
 local a=np.array({1,0,4,2,4,2,0},np.uint64)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 370 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 370')
 assert(seqeq(r.strides,{8}),'cos strides 370')
 assert(veq(r:tolist(),{0.5403023058681398,1.0,-0.6536436208636119,-0.4161468365471424,-0.6536436208636119,-0.4161468365471424,1.0},8e-12),'cos values 370')
end
do -- cos supported 371
 local a=np.array({{{7},{64},{3}},{{0},{3},{0}}},np.uint64)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 371 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'cos shape 371')
 assert(seqeq(r.strides,{24,8,8}),'cos strides 371')
 assert(veq(r:tolist(),{{{0.7539022543433046},{0.39185723042955},{-0.9899924966004454}},{{1.0},{-0.9899924966004454},{1.0}}},8e-12),'cos values 371')
end
do -- cos supported 372
 local a=np.array({{{1.5707963},{0.5},{3.1415926}},{{-0.0},{1.5707963},{-1.5}}},np.float64)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 372 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'cos shape 372')
 assert(seqeq(r.strides,{24,8,8}),'cos strides 372')
 assert(veq(r:tolist(),{{{2.6794896585028633e-08},{0.8775825618903728},{-0.9999999999999986}},{{1.0},{2.6794896585028633e-08},{0.0707372016677029}}},8e-12),'cos values 372')
end
do -- cos supported 373
 local a=np.array({{{0.5},{6.0},{6.0}},{{-6.0},{-1.0},{-0.0}}},np.float32)
 local r=np.cos(a)
 assert(r.dtype=='float32','cos dtype 373 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'cos shape 373')
 assert(seqeq(r.strides,{12,4,4}),'cos strides 373')
 assert(veq(r:tolist(),{{{0.8775825500488281},{0.9601702690124512},{0.9601702690124512}},{{0.9601702690124512},{0.5403022766113281},{1.0}}},2e-5),'cos values 373')
end
do -- cos supported 374
 local a=(np.array({{3,0,16},{7,3,7}},np.uint32)).T
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 374 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'cos shape 374')
 assert(seqeq(r.strides,{8,24}),'cos strides 374')
 assert(veq(r:tolist(),{{-0.9899924966004454,0.7539022543433046},{1.0,-0.9899924966004454},{-0.9576594803233847,0.7539022543433046}},8e-12),'cos values 374')
end
do -- cos supported 375
 local a=np.array({64,4,0,0,7,3,31},np.uint16)
 local r=np.cos(a)
 assert(r.dtype=='float32','cos dtype 375 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 375')
 assert(seqeq(r.strides,{4}),'cos strides 375')
 assert(veq(r:tolist(),{0.39185723662376404,-0.6536436080932617,1.0,1.0,0.7539022564888,-0.9899924993515015,0.9147423505783081},2e-5),'cos values 375')
end
do -- cos supported 376
 local a=np.array({false,true,true,true,false,true,true},np.bool)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 376 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 376')
 assert(seqeq(r.strides,{2}),'cos strides 376')
 assert(veq(r:tolist(),{1.0,0.54052734375,0.54052734375,0.54052734375,1.0,0.54052734375,0.54052734375},2e-3),'cos values 376')
end
do -- cos supported 377
 local a=np.array({{{-1.0},{6.0},{-6.0}},{{-1.5},{-1.0},{0.5}}},np.float32)
 local r=np.cos(a)
 assert(r.dtype=='float32','cos dtype 377 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'cos shape 377')
 assert(seqeq(r.strides,{12,4,4}),'cos strides 377')
 assert(veq(r:tolist(),{{{0.5403022766113281},{0.9601702690124512},{0.9601702690124512}},{{0.07073719799518585},{0.5403022766113281},{0.8775825500488281}}},2e-5),'cos values 377')
end
do -- cos supported 378
 local a=np.array({{{0},{-7},{9}},{{-1},{9},{1}}},np.int16)
 local r=np.cos(a)
 assert(r.dtype=='float32','cos dtype 378 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'cos shape 378')
 assert(seqeq(r.strides,{12,4,4}),'cos strides 378')
 assert(veq(r:tolist(),{{{1.0},{0.7539022564888},{-0.9111302495002747}},{{0.5403022766113281},{-0.9111302495002747},{0.5403022766113281}}},2e-5),'cos values 378')
end
do -- cos supported 379
 local a=np.array({{true,true,true},{false,false,true}},np.bool)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 379 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'cos shape 379')
 assert(seqeq(r.strides,{6,2}),'cos strides 379')
 assert(veq(r:tolist(),{{0.54052734375,0.54052734375,0.54052734375},{1.0,1.0,0.54052734375}},2e-3),'cos values 379')
end
do -- cos supported 380
 local a=(np.array({{4,1,16},{2,9,0}},np.int64)).T
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 380 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'cos shape 380')
 assert(seqeq(r.strides,{8,24}),'cos strides 380')
 assert(veq(r:tolist(),{{-0.6536436208636119,-0.4161468365471424},{0.5403023058681398,-0.9111302618846769},{-0.9576594803233847,1.0}},8e-12),'cos values 380')
end
do -- cos supported 381
 local a=np.array({0.5,-1.5,0.5,1.570796251296997,-1.0,-1.5,6.0},np.float32)
 local r=np.cos(a)
 assert(r.dtype=='float32','cos dtype 381 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 381')
 assert(seqeq(r.strides,{4}),'cos strides 381')
 assert(veq(r:tolist(),{0.8775825500488281,0.07073719799518585,0.8775825500488281,7.549790126404332e-08,0.5403022766113281,0.07073719799518585,0.9601702690124512},2e-5),'cos values 381')
end
do -- cos supported 382
 local a=np.array({{{-6.0},{-3.141592502593994},{-6.0}},{{1.0},{6.0},{6.0}}},np.float32)
 local r=np.cos(a)
 assert(r.dtype=='float32','cos dtype 382 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'cos shape 382')
 assert(seqeq(r.strides,{12,4,4}),'cos strides 382')
 assert(veq(r:tolist(),{{{0.9601702690124512},{-1.0},{0.9601702690124512}},{{0.5403022766113281},{0.9601702690124512},{0.9601702690124512}}},2e-5),'cos values 382')
end
do -- cos supported 383
 local a=np.array({{{0},{16},{64}},{{0},{4},{31}}},np.uint64)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 383 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'cos shape 383')
 assert(seqeq(r.strides,{24,8,8}),'cos strides 383')
 assert(veq(r:tolist(),{{{1.0},{-0.9576594803233847},{0.39185723042955}},{{1.0},{-0.6536436208636119},{0.9147423578045313}}},8e-12),'cos values 383')
end
do -- cos supported 384
 local a=np.array({-1.5,-1.5,0.5,1.5707963,0.5,3.1415926,-1.5},np.float64)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 384 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 384')
 assert(seqeq(r.strides,{8}),'cos strides 384')
 assert(veq(r:tolist(),{0.0707372016677029,0.0707372016677029,0.8775825618903728,2.6794896585028633e-08,0.8775825618903728,-0.9999999999999986,0.0707372016677029},8e-12),'cos values 384')
end
do -- cos supported 385
 local a=(np.array({{31,0,3},{2,7,4}},np.uint32)).T
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 385 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'cos shape 385')
 assert(seqeq(r.strides,{8,24}),'cos strides 385')
 assert(veq(r:tolist(),{{0.9147423578045313,-0.4161468365471424},{1.0,0.7539022543433046},{-0.9899924966004454,-0.6536436208636119}},8e-12),'cos values 385')
end
do -- cos supported 386
 local a=np.array({16,16,-1,-1,-1,1,16},np.int8)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 386 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 386')
 assert(seqeq(r.strides,{2}),'cos strides 386')
 assert(veq(r:tolist(),{-0.95751953125,-0.95751953125,0.54052734375,0.54052734375,0.54052734375,0.54052734375,-0.95751953125},2e-3),'cos values 386')
end
do -- cos supported 387
 local a=np.array({0,64,4,0,16,64,3},np.uint64)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 387 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 387')
 assert(seqeq(r.strides,{8}),'cos strides 387')
 assert(veq(r:tolist(),{1.0,0.39185723042955,-0.6536436208636119,1.0,-0.9576594803233847,0.39185723042955,-0.9899924966004454},8e-12),'cos values 387')
end
do -- cos supported 388
 local a=np.array({64,31,16,7,3,64,3},np.uint8)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 388 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 388')
 assert(seqeq(r.strides,{2}),'cos strides 388')
 assert(veq(r:tolist(),{0.391845703125,0.91455078125,-0.95751953125,0.75390625,-0.990234375,0.391845703125,-0.990234375},2e-3),'cos values 388')
end
do -- cos supported 389
 local a=np.array({{-3.141592502593994,0.0,-6.0},{-6.0,-1.5,1.0}},np.float32)
 local r=np.cos(a)
 assert(r.dtype=='float32','cos dtype 389 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'cos shape 389')
 assert(seqeq(r.strides,{12,4}),'cos strides 389')
 assert(veq(r:tolist(),{{-1.0,1.0,0.9601702690124512},{0.9601702690124512,0.07073719799518585,0.5403022766113281}},2e-5),'cos values 389')
end
do -- cos supported 390
 local a=(np.array({{-6.0,-6.0,6.0},{0.0,3.140625,-3.140625}},np.float16)).T
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 390 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'cos shape 390')
 assert(seqeq(r.strides,{2,6}),'cos strides 390')
 assert(veq(r:tolist(),{{0.9599609375,1.0},{0.9599609375,-1.0},{0.9599609375,-1.0}},2e-3),'cos values 390')
end
do -- cos supported 391
 local a=np.array({{{1},{-1},{-7}},{{-16},{0},{-3}}},np.int16)
 local r=np.cos(a)
 assert(r.dtype=='float32','cos dtype 391 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'cos shape 391')
 assert(seqeq(r.strides,{12,4,4}),'cos strides 391')
 assert(veq(r:tolist(),{{{0.5403022766113281},{0.5403022766113281},{0.7539022564888}},{{-0.9576594829559326},{1.0},{-0.9899924993515015}}},2e-5),'cos values 391')
end
do -- cos supported 392
 local a=np.array({{{2},{1},{16}},{{7},{4},{2}}},np.uint64)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 392 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'cos shape 392')
 assert(seqeq(r.strides,{24,8,8}),'cos strides 392')
 assert(veq(r:tolist(),{{{-0.4161468365471424},{0.5403023058681398},{-0.9576594803233847}},{{0.7539022543433046},{-0.6536436208636119},{-0.4161468365471424}}},8e-12),'cos values 392')
end
do -- cos supported 393
 local a=np.array({7,31,2,2,3,4,31},np.uint64)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 393 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 393')
 assert(seqeq(r.strides,{8}),'cos strides 393')
 assert(veq(r:tolist(),{0.7539022543433046,0.9147423578045313,-0.4161468365471424,-0.4161468365471424,-0.9899924966004454,-0.6536436208636119,0.9147423578045313},8e-12),'cos values 393')
end
do -- cos supported 394
 local a=np.array({-16,-7,-3,0,9,1,4},np.int32)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 394 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 394')
 assert(seqeq(r.strides,{8}),'cos strides 394')
 assert(veq(r:tolist(),{-0.9576594803233847,0.7539022543433046,-0.9899924966004454,1.0,-0.9111302618846769,0.5403023058681398,-0.6536436208636119},8e-12),'cos values 394')
end
do -- cos supported 395
 local a=np.array({64,64,7,31,16,1,1},np.uint32)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 395 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 395')
 assert(seqeq(r.strides,{8}),'cos strides 395')
 assert(veq(r:tolist(),{0.39185723042955,0.39185723042955,0.7539022543433046,0.9147423578045313,-0.9576594803233847,0.5403023058681398,0.5403023058681398},8e-12),'cos values 395')
end
do -- cos supported 396
 local a=np.array({-1.5,3.140625,1.0,-6.0,0.5,-0.0,0.5},np.float16)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 396 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 396')
 assert(seqeq(r.strides,{2}),'cos strides 396')
 assert(veq(r:tolist(),{0.07073974609375,-1.0,0.54052734375,0.9599609375,0.87744140625,1.0,0.87744140625},2e-3),'cos values 396')
end
do -- cos supported 397
 local a=np.array({-16,-7,1,0,-1,16,1},np.int8)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 397 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 397')
 assert(seqeq(r.strides,{2}),'cos strides 397')
 assert(veq(r:tolist(),{-0.95751953125,0.75390625,0.54052734375,1.0,0.54052734375,-0.95751953125,0.54052734375},2e-3),'cos values 397')
end
do -- cos supported 398
 local a=(np.array({{1,64,4},{2,2,1}},np.uint8)).T
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 398 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'cos shape 398')
 assert(seqeq(r.strides,{2,6}),'cos strides 398')
 assert(veq(r:tolist(),{{0.54052734375,-0.416259765625},{0.391845703125,-0.416259765625},{-0.65380859375,0.54052734375}},2e-3),'cos values 398')
end
do -- cos supported 399
 local a=np.array({-3,0,9,4,1,2,0},np.int8)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 399 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 399')
 assert(seqeq(r.strides,{2}),'cos strides 399')
 assert(veq(r:tolist(),{-0.990234375,1.0,-0.9111328125,-0.65380859375,0.54052734375,-0.416259765625,1.0},2e-3),'cos values 399')
end
do -- cos supported 400
 local a=np.array({{-7,-1,-1},{16,0,-1}},np.int32)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 400 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'cos shape 400')
 assert(seqeq(r.strides,{24,8}),'cos strides 400')
 assert(veq(r:tolist(),{{0.7539022543433046,0.5403023058681398,0.5403023058681398},{-0.9576594803233847,1.0,0.5403023058681398}},8e-12),'cos values 400')
end
do -- cos supported 401
 local a=np.array({7,7,16,64,0,4,0},np.uint32)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 401 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 401')
 assert(seqeq(r.strides,{8}),'cos strides 401')
 assert(veq(r:tolist(),{0.7539022543433046,0.7539022543433046,-0.9576594803233847,0.39185723042955,1.0,-0.6536436208636119,1.0},8e-12),'cos values 401')
end
do -- cos supported 402
 local a=np.array({{{9},{2},{-7}},{{2},{-7},{9}}},np.int8)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 402 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'cos shape 402')
 assert(seqeq(r.strides,{6,2,2}),'cos strides 402')
 assert(veq(r:tolist(),{{{-0.9111328125},{-0.416259765625},{0.75390625}},{{-0.416259765625},{0.75390625},{-0.9111328125}}},2e-3),'cos values 402')
end
do -- cos supported 403
 local a=np.array({{-16,4,-7},{-3,-1,0}},np.int64)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 403 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'cos shape 403')
 assert(seqeq(r.strides,{24,8}),'cos strides 403')
 assert(veq(r:tolist(),{{-0.9576594803233847,-0.6536436208636119,0.7539022543433046},{-0.9899924966004454,0.5403023058681398,1.0}},8e-12),'cos values 403')
end
do -- cos supported 404
 local a=np.array({1,4,31,1,2,31,31},np.uint32)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 404 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 404')
 assert(seqeq(r.strides,{8}),'cos strides 404')
 assert(veq(r:tolist(),{0.5403023058681398,-0.6536436208636119,0.9147423578045313,0.5403023058681398,-0.4161468365471424,0.9147423578045313,0.9147423578045313},8e-12),'cos values 404')
end
do -- cos supported 405
 local a=np.array({{{4},{64},{3}},{{31},{64},{3}}},np.uint64)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 405 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'cos shape 405')
 assert(seqeq(r.strides,{24,8,8}),'cos strides 405')
 assert(veq(r:tolist(),{{{-0.6536436208636119},{0.39185723042955},{-0.9899924966004454}},{{0.9147423578045313},{0.39185723042955},{-0.9899924966004454}}},8e-12),'cos values 405')
end
do -- cos supported 406
 local a=np.array({1.5703125,-1.5,-6.0,1.5703125,0.5,1.5703125,1.5703125},np.float16)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 406 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 406')
 assert(seqeq(r.strides,{2}),'cos strides 406')
 assert(veq(r:tolist(),{0.0004837512969970703,0.07073974609375,0.9599609375,0.0004837512969970703,0.87744140625,0.0004837512969970703,0.0004837512969970703},2e-3),'cos values 406')
end
do -- cos supported 407
 local a=np.array({{{-7},{-7},{4}},{{0},{3},{0}}},np.int64)
 local r=np.cos(a)
 assert(r.dtype=='float64','cos dtype 407 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'cos shape 407')
 assert(seqeq(r.strides,{24,8,8}),'cos strides 407')
 assert(veq(r:tolist(),{{{0.7539022543433046},{0.7539022543433046},{-0.6536436208636119}},{{1.0},{-0.9899924966004454},{1.0}}},8e-12),'cos values 407')
end
do -- cos supported 408
 local a=np.array({{31,3,4},{7,31,64}},np.uint8)
 local r=np.cos(a)
 assert(r.dtype=='float16','cos dtype 408 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'cos shape 408')
 assert(seqeq(r.strides,{6,2}),'cos strides 408')
 assert(veq(r:tolist(),{{0.91455078125,-0.990234375,-0.65380859375},{0.75390625,0.91455078125,0.391845703125}},2e-3),'cos values 408')
end
do -- cos supported 409
 local a=np.array({3,3,-3,16,16,-1,2},np.int16)
 local r=np.cos(a)
 assert(r.dtype=='float32','cos dtype 409 '..r.dtype)
 assert(seqeq(r.shape,{7}),'cos shape 409')
 assert(seqeq(r.strides,{4}),'cos strides 409')
 assert(veq(r:tolist(),{-0.9899924993515015,-0.9899924993515015,-0.9899924993515015,-0.9576594829559326,-0.9576594829559326,0.5403022766113281,-0.41614681482315063},2e-5),'cos values 409')
end
do -- tan supported 410
 local a=np.array({{{3},{16},{-3}},{{-1},{-16},{1}}},np.int32)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 410 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 410')
 assert(seqeq(r.strides,{24,8,8}),'tan strides 410')
 assert(veq(r:tolist(),{{{-0.1425465430742778},{0.3006322420239034},{0.1425465430742778}},{{-1.5574077246549023},{-0.3006322420239034},{1.5574077246549023}}},8e-12),'tan values 410')
end
do -- tan supported 411
 local a=np.array({{4,7,4},{31,4,2}},np.uint32)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 411 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'tan shape 411')
 assert(seqeq(r.strides,{24,8}),'tan strides 411')
 assert(veq(r:tolist(),{{1.1578212823495775,0.8714479827243188,1.1578212823495775},{-0.441695568020698,1.1578212823495775,-2.185039863261519}},8e-12),'tan values 411')
end
do -- tan supported 412
 local a=np.array({-16,-3,9,16,-1,-1,0},np.int16)
 local r=np.tan(a)
 assert(r.dtype=='float32','tan dtype 412 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 412')
 assert(seqeq(r.strides,{4}),'tan strides 412')
 assert(veq(r:tolist(),{-0.3006322383880615,0.14254653453826904,-0.45231565833091736,0.3006322383880615,-1.5574077367782593,-1.5574077367782593,0.0},2e-5),'tan values 412')
end
do -- tan supported 413
 local a=np.array({{{4},{3},{0}},{{-3},{3},{1}}},np.int32)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 413 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 413')
 assert(seqeq(r.strides,{24,8,8}),'tan strides 413')
 assert(veq(r:tolist(),{{{1.1578212823495775},{-0.1425465430742778},{0.0}},{{0.1425465430742778},{-0.1425465430742778},{1.5574077246549023}}},8e-12),'tan values 413')
end
do -- tan supported 414
 local a=np.array({16,64,31,1,16,0,3},np.uint32)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 414 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 414')
 assert(seqeq(r.strides,{8}),'tan strides 414')
 assert(veq(r:tolist(),{0.3006322420239034,2.3478603091954366,-0.441695568020698,1.5574077246549023,0.3006322420239034,0.0,-0.1425465430742778},8e-12),'tan values 414')
end
do -- tan supported 415
 local a=np.array({{{2},{3},{-7}},{{-16},{3},{-7}}},np.int32)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 415 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 415')
 assert(seqeq(r.strides,{24,8,8}),'tan strides 415')
 assert(veq(r:tolist(),{{{-2.185039863261519},{-0.1425465430742778},{-0.8714479827243188}},{{-0.3006322420239034},{-0.1425465430742778},{-0.8714479827243188}}},8e-12),'tan values 415')
end
do -- tan supported 416
 local a=(np.array({{64,0,31},{0,7,0}},np.uint64)).T
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 416 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'tan shape 416')
 assert(seqeq(r.strides,{8,24}),'tan strides 416')
 assert(veq(r:tolist(),{{2.3478603091954366,0.0},{0.0,0.8714479827243188},{-0.441695568020698,0.0}},8e-12),'tan values 416')
end
do -- tan supported 417
 local a=np.array({0,16,0,0,3,31,31},np.uint32)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 417 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 417')
 assert(seqeq(r.strides,{8}),'tan strides 417')
 assert(veq(r:tolist(),{0.0,0.3006322420239034,0.0,0.0,-0.1425465430742778,-0.441695568020698,-0.441695568020698},8e-12),'tan values 417')
end
do -- tan supported 418
 local a=np.array({{{2},{16},{2}},{{64},{2},{1}}},np.uint32)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 418 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 418')
 assert(seqeq(r.strides,{24,8,8}),'tan strides 418')
 assert(veq(r:tolist(),{{{-2.185039863261519},{0.3006322420239034},{-2.185039863261519}},{{2.3478603091954366},{-2.185039863261519},{1.5574077246549023}}},8e-12),'tan values 418')
end
do -- tan supported 419
 local a=(np.array({{9,-1,-3},{2,3,2}},np.int32)).T
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 419 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'tan shape 419')
 assert(seqeq(r.strides,{8,24}),'tan strides 419')
 assert(veq(r:tolist(),{{-0.45231565944180985,-2.185039863261519},{-1.5574077246549023,-0.1425465430742778},{0.1425465430742778,-2.185039863261519}},8e-12),'tan values 419')
end
do -- tan supported 420
 local a=np.array({{{3},{0},{3}},{{31},{16},{64}}},np.uint8)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 420 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 420')
 assert(seqeq(r.strides,{6,2,2}),'tan strides 420')
 assert(veq(r:tolist(),{{{-0.142578125},{0.0},{-0.142578125}},{{-0.441650390625},{0.300537109375},{2.34765625}}},2e-3),'tan values 420')
end
do -- tan supported 421
 local a=np.array({{{4},{16},{31}},{{7},{7},{16}}},np.uint8)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 421 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 421')
 assert(seqeq(r.strides,{6,2,2}),'tan strides 421')
 assert(veq(r:tolist(),{{{1.158203125},{0.300537109375},{-0.441650390625}},{{0.87158203125},{0.87158203125},{0.300537109375}}},2e-3),'tan values 421')
end
do -- tan supported 422
 local a=(np.array({{-7,16,-3},{-3,1,0}},np.int8)).T
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 422 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'tan shape 422')
 assert(seqeq(r.strides,{2,6}),'tan strides 422')
 assert(veq(r:tolist(),{{-0.87158203125,0.142578125},{0.300537109375,1.5576171875},{0.142578125,0.0}},2e-3),'tan values 422')
end
do -- tan supported 423
 local a=np.array({{4,3,2},{3,3,0}},np.uint64)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 423 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'tan shape 423')
 assert(seqeq(r.strides,{24,8}),'tan strides 423')
 assert(veq(r:tolist(),{{1.1578212823495775,-0.1425465430742778,-2.185039863261519},{-0.1425465430742778,-0.1425465430742778,0.0}},8e-12),'tan values 423')
end
do -- tan supported 424
 local a=np.array({4,-7,1,2,0,1,9},np.int32)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 424 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 424')
 assert(seqeq(r.strides,{8}),'tan strides 424')
 assert(veq(r:tolist(),{1.1578212823495775,-0.8714479827243188,1.5574077246549023,-2.185039863261519,0.0,1.5574077246549023,-0.45231565944180985},8e-12),'tan values 424')
end
do -- tan supported 425
 local a=np.array({16,-16,-3,3,16,1,-1},np.int16)
 local r=np.tan(a)
 assert(r.dtype=='float32','tan dtype 425 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 425')
 assert(seqeq(r.strides,{4}),'tan strides 425')
 assert(veq(r:tolist(),{0.3006322383880615,-0.3006322383880615,0.14254653453826904,-0.14254653453826904,0.3006322383880615,1.5574077367782593,-1.5574077367782593},2e-5),'tan values 425')
end
do -- tan supported 426
 local a=np.array({{{-0.0},{3.1415926},{-6.0}},{{1.0},{1.5707963},{0.5}}},np.float64)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 426 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 426')
 assert(seqeq(r.strides,{24,8,8}),'tan strides 426')
 assert(veq(r:tolist(),{{{-0.0},{-5.3589793170057325e-08},{0.29100619138474915}},{{1.5574077246549023},{37320539.634354815},{0.5463024898437905}}},8e-12),'tan values 426')
end
do -- tan supported 427
 local a=np.array({false,true,false,true,false,true,true},np.bool)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 427 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 427')
 assert(seqeq(r.strides,{2}),'tan strides 427')
 assert(veq(r:tolist(),{0.0,1.5576171875,0.0,1.5576171875,0.0,1.5576171875,1.5576171875},2e-3),'tan values 427')
end
do -- tan supported 428
 local a=np.array({-3,-16,-1,-1,9,2,-16},np.int8)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 428 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 428')
 assert(seqeq(r.strides,{2}),'tan strides 428')
 assert(veq(r:tolist(),{0.142578125,-0.300537109375,-1.5576171875,-1.5576171875,-0.452392578125,-2.185546875,-0.300537109375},2e-3),'tan values 428')
end
do -- tan supported 429
 local a=np.array({{16,1,2},{7,0,2}},np.uint64)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 429 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'tan shape 429')
 assert(seqeq(r.strides,{24,8}),'tan strides 429')
 assert(veq(r:tolist(),{{0.3006322420239034,1.5574077246549023,-2.185039863261519},{0.8714479827243188,0.0,-2.185039863261519}},8e-12),'tan values 429')
end
do -- tan supported 430
 local a=np.array({{{3},{64},{1}},{{31},{0},{7}}},np.uint8)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 430 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 430')
 assert(seqeq(r.strides,{6,2,2}),'tan strides 430')
 assert(veq(r:tolist(),{{{-0.142578125},{2.34765625},{1.5576171875}},{{-0.441650390625},{0.0},{0.87158203125}}},2e-3),'tan values 430')
end
do -- tan supported 431
 local a=np.array({{0,9,16},{3,-16,2}},np.int16)
 local r=np.tan(a)
 assert(r.dtype=='float32','tan dtype 431 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'tan shape 431')
 assert(seqeq(r.strides,{12,4}),'tan strides 431')
 assert(veq(r:tolist(),{{0.0,-0.45231565833091736,0.3006322383880615},{-0.14254653453826904,-0.3006322383880615,-2.18503999710083}},2e-5),'tan values 431')
end
do -- tan supported 432
 local a=np.array({6.0,-1.5,0.0,3.140625,-3.140625,3.140625,0.5},np.float16)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 432 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 432')
 assert(seqeq(r.strides,{2}),'tan strides 432')
 assert(veq(r:tolist(),{-0.291015625,-14.1015625,0.0,-0.0009675025939941406,0.0009675025939941406,-0.0009675025939941406,0.54638671875},2e-3),'tan values 432')
end
do -- tan supported 433
 local a=np.array({{{2},{16},{1}},{{4},{64},{2}}},np.uint16)
 local r=np.tan(a)
 assert(r.dtype=='float32','tan dtype 433 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 433')
 assert(seqeq(r.strides,{12,4,4}),'tan strides 433')
 assert(veq(r:tolist(),{{{-2.18503999710083},{0.3006322383880615},{1.5574077367782593}},{{1.1578211784362793},{2.347860336303711},{-2.18503999710083}}},2e-5),'tan values 433')
end
do -- tan supported 434
 local a=np.array({{{4},{1},{3}},{{7},{4},{7}}},np.uint8)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 434 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 434')
 assert(seqeq(r.strides,{6,2,2}),'tan strides 434')
 assert(veq(r:tolist(),{{{1.158203125},{1.5576171875},{-0.142578125}},{{0.87158203125},{1.158203125},{0.87158203125}}},2e-3),'tan values 434')
end
do -- tan supported 435
 local a=(np.array({{3,1,2},{16,64,7}},np.uint32)).T
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 435 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'tan shape 435')
 assert(seqeq(r.strides,{8,24}),'tan strides 435')
 assert(veq(r:tolist(),{{-0.1425465430742778,0.3006322420239034},{1.5574077246549023,2.3478603091954366},{-2.185039863261519,0.8714479827243188}},8e-12),'tan values 435')
end
do -- tan supported 436
 local a=np.array({{-16,16,-16},{16,0,-16}},np.int8)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 436 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'tan shape 436')
 assert(seqeq(r.strides,{6,2}),'tan strides 436')
 assert(veq(r:tolist(),{{-0.300537109375,0.300537109375,-0.300537109375},{0.300537109375,0.0,-0.300537109375}},2e-3),'tan values 436')
end
do -- tan supported 437
 local a=np.array({{{0},{-1},{-7}},{{-3},{-3},{-16}}},np.int8)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 437 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 437')
 assert(seqeq(r.strides,{6,2,2}),'tan strides 437')
 assert(veq(r:tolist(),{{{0.0},{-1.5576171875},{-0.87158203125}},{{0.142578125},{0.142578125},{-0.300537109375}}},2e-3),'tan values 437')
end
do -- tan supported 438
 local a=np.array({0,2,-7,0,16,9,16},np.int32)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 438 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 438')
 assert(seqeq(r.strides,{8}),'tan strides 438')
 assert(veq(r:tolist(),{0.0,-2.185039863261519,-0.8714479827243188,0.0,0.3006322420239034,-0.45231565944180985,0.3006322420239034},8e-12),'tan values 438')
end
do -- tan supported 439
 local a=np.array({64,31,3,0,2,3,0},np.uint8)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 439 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 439')
 assert(seqeq(r.strides,{2}),'tan strides 439')
 assert(veq(r:tolist(),{2.34765625,-0.441650390625,-0.142578125,0.0,-2.185546875,-0.142578125,0.0},2e-3),'tan values 439')
end
do -- tan supported 440
 local a=np.array({-3.141592502593994,0.0,-6.0,-3.141592502593994,-1.0,1.0,-3.141592502593994},np.float32)
 local r=np.tan(a)
 assert(r.dtype=='float32','tan dtype 440 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 440')
 assert(seqeq(r.strides,{4}),'tan strides 440')
 assert(veq(r:tolist(),{1.5099580252808664e-07,0.0,0.2910062074661255,1.5099580252808664e-07,-1.5574077367782593,1.5574077367782593,1.5099580252808664e-07},2e-5),'tan values 440')
end
do -- tan supported 441
 local a=np.array({{{16},{2},{31}},{{2},{4},{64}}},np.uint32)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 441 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 441')
 assert(seqeq(r.strides,{24,8,8}),'tan strides 441')
 assert(veq(r:tolist(),{{{0.3006322420239034},{-2.185039863261519},{-0.441695568020698}},{{-2.185039863261519},{1.1578212823495775},{2.3478603091954366}}},8e-12),'tan values 441')
end
do -- tan supported 442
 local a=np.array({{-1,-16,1},{-1,-7,4}},np.int8)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 442 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'tan shape 442')
 assert(seqeq(r.strides,{6,2}),'tan strides 442')
 assert(veq(r:tolist(),{{-1.5576171875,-0.300537109375,1.5576171875},{-1.5576171875,-0.87158203125,1.158203125}},2e-3),'tan values 442')
end
do -- tan supported 443
 local a=np.array({{{2},{-3},{-1}},{{-1},{1},{-7}}},np.int32)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 443 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 443')
 assert(seqeq(r.strides,{24,8,8}),'tan strides 443')
 assert(veq(r:tolist(),{{{-2.185039863261519},{0.1425465430742778},{-1.5574077246549023}},{{-1.5574077246549023},{1.5574077246549023},{-0.8714479827243188}}},8e-12),'tan values 443')
end
do -- tan supported 444
 local a=np.array({0.5,-3.1415926,-3.1415926,3.1415926,3.1415926,0.0,3.1415926},np.float64)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 444 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 444')
 assert(seqeq(r.strides,{8}),'tan strides 444')
 assert(veq(r:tolist(),{0.5463024898437905,5.3589793170057325e-08,5.3589793170057325e-08,-5.3589793170057325e-08,-5.3589793170057325e-08,0.0,-5.3589793170057325e-08},8e-12),'tan values 444')
end
do -- tan supported 445
 local a=np.array({{0,-3,9},{4,0,0}},np.int32)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 445 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'tan shape 445')
 assert(seqeq(r.strides,{24,8}),'tan strides 445')
 assert(veq(r:tolist(),{{0.0,0.1425465430742778,-0.45231565944180985},{1.1578212823495775,0.0,0.0}},8e-12),'tan values 445')
end
do -- tan supported 446
 local a=np.array({{{16},{0},{16}},{{4},{3},{7}}},np.uint8)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 446 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 446')
 assert(seqeq(r.strides,{6,2,2}),'tan strides 446')
 assert(veq(r:tolist(),{{{0.300537109375},{0.0},{0.300537109375}},{{1.158203125},{-0.142578125},{0.87158203125}}},2e-3),'tan values 446')
end
do -- tan supported 447
 local a=np.array({true,true,true,false,true,true,true},np.bool)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 447 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 447')
 assert(seqeq(r.strides,{2}),'tan strides 447')
 assert(veq(r:tolist(),{1.5576171875,1.5576171875,1.5576171875,0.0,1.5576171875,1.5576171875,1.5576171875},2e-3),'tan values 447')
end
do -- tan supported 448
 local a=np.array({{{1.0},{0.0},{-6.0}},{{-1.0},{0.0},{-0.0}}},np.float32)
 local r=np.tan(a)
 assert(r.dtype=='float32','tan dtype 448 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 448')
 assert(seqeq(r.strides,{12,4,4}),'tan strides 448')
 assert(veq(r:tolist(),{{{1.5574077367782593},{0.0},{0.2910062074661255}},{{-1.5574077367782593},{0.0},{-0.0}}},2e-5),'tan values 448')
end
do -- tan supported 449
 local a=np.array({-0.0,-3.1415926,-1.5,-0.0,0.5,0.5,-0.0},np.float64)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 449 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 449')
 assert(seqeq(r.strides,{8}),'tan strides 449')
 assert(veq(r:tolist(),{-0.0,5.3589793170057325e-08,-14.101419947171719,-0.0,0.5463024898437905,0.5463024898437905,-0.0},8e-12),'tan values 449')
end
do -- tan supported 450
 local a=np.array({-16,0,0,-3,16,9,-3},np.int64)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 450 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 450')
 assert(seqeq(r.strides,{8}),'tan strides 450')
 assert(veq(r:tolist(),{-0.3006322420239034,0.0,0.0,0.1425465430742778,0.3006322420239034,-0.45231565944180985,0.1425465430742778},8e-12),'tan values 450')
end
do -- tan supported 451
 local a=np.array({6.0,-1.0,-1.5,3.140625,0.5,0.5,6.0},np.float16)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 451 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 451')
 assert(seqeq(r.strides,{2}),'tan strides 451')
 assert(veq(r:tolist(),{-0.291015625,-1.5576171875,-14.1015625,-0.0009675025939941406,0.54638671875,0.54638671875,-0.291015625},2e-3),'tan values 451')
end
do -- tan supported 452
 local a=np.array({{1.5703125,1.0,-1.0},{-1.0,6.0,-1.5}},np.float16)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 452 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'tan shape 452')
 assert(seqeq(r.strides,{6,2}),'tan strides 452')
 assert(veq(r:tolist(),{{2066.0,1.5576171875,-1.5576171875},{-1.5576171875,-0.291015625,-14.1015625}},2e-3),'tan values 452')
end
do -- tan supported 453
 local a=np.array({{-1,16,0},{-1,-7,-3}},np.int64)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 453 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'tan shape 453')
 assert(seqeq(r.strides,{24,8}),'tan strides 453')
 assert(veq(r:tolist(),{{-1.5574077246549023,0.3006322420239034,0.0},{-1.5574077246549023,-0.8714479827243188,0.1425465430742778}},8e-12),'tan values 453')
end
do -- tan supported 454
 local a=np.array({0,-3,9,-3,-16,2,4},np.int16)
 local r=np.tan(a)
 assert(r.dtype=='float32','tan dtype 454 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 454')
 assert(seqeq(r.strides,{4}),'tan strides 454')
 assert(veq(r:tolist(),{0.0,0.14254653453826904,-0.45231565833091736,0.14254653453826904,-0.3006322383880615,-2.18503999710083,1.1578211784362793},2e-5),'tan values 454')
end
do -- tan supported 455
 local a=(np.array({{2,31,31},{4,31,7}},np.uint16)).T
 local r=np.tan(a)
 assert(r.dtype=='float32','tan dtype 455 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'tan shape 455')
 assert(seqeq(r.strides,{4,12}),'tan strides 455')
 assert(veq(r:tolist(),{{-2.18503999710083,1.1578211784362793},{-0.44169557094573975,-0.44169557094573975},{-0.44169557094573975,0.8714479804039001}},2e-5),'tan values 455')
end
do -- tan supported 456
 local a=np.array({-16,-7,0,1,4,4,3},np.int16)
 local r=np.tan(a)
 assert(r.dtype=='float32','tan dtype 456 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 456')
 assert(seqeq(r.strides,{4}),'tan strides 456')
 assert(veq(r:tolist(),{-0.3006322383880615,-0.8714479804039001,0.0,1.5574077367782593,1.1578211784362793,1.1578211784362793,-0.14254653453826904},2e-5),'tan values 456')
end
do -- tan supported 457
 local a=np.array({{{-1.0},{3.141592502593994},{0.5}},{{-3.141592502593994},{1.570796251296997},{3.141592502593994}}},np.float32)
 local r=np.tan(a)
 assert(r.dtype=='float32','tan dtype 457 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 457')
 assert(seqeq(r.strides,{12,4,4}),'tan strides 457')
 assert(veq(r:tolist(),{{{-1.5574077367782593},{-1.5099580252808664e-07},{0.5463024973869324}},{{1.5099580252808664e-07},{13245402.0},{-1.5099580252808664e-07}}},2e-5),'tan values 457')
end
do -- tan supported 458
 local a=np.array({{0.5,-0.0,1.5707963},{-1.0,1.5707963,-1.5}},np.float64)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 458 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'tan shape 458')
 assert(seqeq(r.strides,{24,8}),'tan strides 458')
 assert(veq(r:tolist(),{{0.5463024898437905,-0.0,37320539.634354815},{-1.5574077246549023,37320539.634354815,-14.101419947171719}},8e-12),'tan values 458')
end
do -- tan supported 459
 local a=np.array({{3.141592502593994,0.5,1.0},{-1.0,3.141592502593994,6.0}},np.float32)
 local r=np.tan(a)
 assert(r.dtype=='float32','tan dtype 459 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'tan shape 459')
 assert(seqeq(r.strides,{12,4}),'tan strides 459')
 assert(veq(r:tolist(),{{-1.5099580252808664e-07,0.5463024973869324,1.5574077367782593},{-1.5574077367782593,-1.5099580252808664e-07,-0.2910062074661255}},2e-5),'tan values 459')
end
do -- tan supported 460
 local a=np.array({16,0,7,7,1,4,7},np.uint32)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 460 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 460')
 assert(seqeq(r.strides,{8}),'tan strides 460')
 assert(veq(r:tolist(),{0.3006322420239034,0.0,0.8714479827243188,0.8714479827243188,1.5574077246549023,1.1578212823495775,0.8714479827243188},8e-12),'tan values 460')
end
do -- tan supported 461
 local a=np.array({{{-1.5},{3.1415926},{-3.1415926}},{{3.1415926},{1.5707963},{6.0}}},np.float64)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 461 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 461')
 assert(seqeq(r.strides,{24,8,8}),'tan strides 461')
 assert(veq(r:tolist(),{{{-14.101419947171719},{-5.3589793170057325e-08},{5.3589793170057325e-08}},{{-5.3589793170057325e-08},{37320539.634354815},{-0.29100619138474915}}},8e-12),'tan values 461')
end
do -- tan supported 462
 local a=np.array({9,-3,3,-7,-1,16,4},np.int64)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 462 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 462')
 assert(seqeq(r.strides,{8}),'tan strides 462')
 assert(veq(r:tolist(),{-0.45231565944180985,0.1425465430742778,-0.1425465430742778,-0.8714479827243188,-1.5574077246549023,0.3006322420239034,1.1578212823495775},8e-12),'tan values 462')
end
do -- tan supported 463
 local a=(np.array({{7,2,2},{64,1,3}},np.uint16)).T
 local r=np.tan(a)
 assert(r.dtype=='float32','tan dtype 463 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'tan shape 463')
 assert(seqeq(r.strides,{4,12}),'tan strides 463')
 assert(veq(r:tolist(),{{0.8714479804039001,2.347860336303711},{-2.18503999710083,1.5574077367782593},{-2.18503999710083,-0.14254653453826904}},2e-5),'tan values 463')
end
do -- tan supported 464
 local a=np.array({{0,3,3},{1,0,3}},np.uint64)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 464 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'tan shape 464')
 assert(seqeq(r.strides,{24,8}),'tan strides 464')
 assert(veq(r:tolist(),{{0.0,-0.1425465430742778,-0.1425465430742778},{1.5574077246549023,0.0,-0.1425465430742778}},8e-12),'tan values 464')
end
do -- tan supported 465
 local a=np.array({{{1.5703125},{0.5},{-6.0}},{{1.5703125},{0.5},{1.0}}},np.float16)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 465 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 465')
 assert(seqeq(r.strides,{6,2,2}),'tan strides 465')
 assert(veq(r:tolist(),{{{2066.0},{0.54638671875},{0.291015625}},{{2066.0},{0.54638671875},{1.5576171875}}},2e-3),'tan values 465')
end
do -- tan supported 466
 local a=np.array({{2,16,16},{7,1,0}},np.uint64)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 466 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'tan shape 466')
 assert(seqeq(r.strides,{24,8}),'tan strides 466')
 assert(veq(r:tolist(),{{-2.185039863261519,0.3006322420239034,0.3006322420239034},{0.8714479827243188,1.5574077246549023,0.0}},8e-12),'tan values 466')
end
do -- tan supported 467
 local a=np.array({{{4},{1},{0}},{{0},{3},{2}}},np.uint32)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 467 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 467')
 assert(seqeq(r.strides,{24,8,8}),'tan strides 467')
 assert(veq(r:tolist(),{{{1.1578212823495775},{1.5574077246549023},{0.0}},{{0.0},{-0.1425465430742778},{-2.185039863261519}}},8e-12),'tan values 467')
end
do -- tan supported 468
 local a=np.array({6.0,1.5707963,-6.0,0.5,1.5707963,-1.0,-6.0},np.float64)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 468 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 468')
 assert(seqeq(r.strides,{8}),'tan strides 468')
 assert(veq(r:tolist(),{-0.29100619138474915,37320539.634354815,0.29100619138474915,0.5463024898437905,37320539.634354815,-1.5574077246549023,0.29100619138474915},8e-12),'tan values 468')
end
do -- tan supported 469
 local a=np.array({1,-16,-1,-7,-1,-3,0},np.int8)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 469 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 469')
 assert(seqeq(r.strides,{2}),'tan strides 469')
 assert(veq(r:tolist(),{1.5576171875,-0.300537109375,-1.5576171875,-0.87158203125,-1.5576171875,0.142578125,0.0},2e-3),'tan values 469')
end
do -- tan supported 470
 local a=np.array({{{16},{16},{2}},{{1},{4},{2}}},np.uint32)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 470 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 470')
 assert(seqeq(r.strides,{24,8,8}),'tan strides 470')
 assert(veq(r:tolist(),{{{0.3006322420239034},{0.3006322420239034},{-2.185039863261519}},{{1.5574077246549023},{1.1578212823495775},{-2.185039863261519}}},8e-12),'tan values 470')
end
do -- tan supported 471
 local a=np.array({-7,16,2,-1,4,-7,-16},np.int8)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 471 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 471')
 assert(seqeq(r.strides,{2}),'tan strides 471')
 assert(veq(r:tolist(),{-0.87158203125,0.300537109375,-2.185546875,-1.5576171875,1.158203125,-0.87158203125,-0.300537109375},2e-3),'tan values 471')
end
do -- tan supported 472
 local a=np.array({9,-1,4,-3,3,1,-3},np.int32)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 472 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 472')
 assert(seqeq(r.strides,{8}),'tan strides 472')
 assert(veq(r:tolist(),{-0.45231565944180985,-1.5574077246549023,1.1578212823495775,0.1425465430742778,-0.1425465430742778,1.5574077246549023,0.1425465430742778},8e-12),'tan values 472')
end
do -- tan supported 473
 local a=np.array({{{7},{31},{16}},{{7},{1},{16}}},np.uint64)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 473 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 473')
 assert(seqeq(r.strides,{24,8,8}),'tan strides 473')
 assert(veq(r:tolist(),{{{0.8714479827243188},{-0.441695568020698},{0.3006322420239034}},{{0.8714479827243188},{1.5574077246549023},{0.3006322420239034}}},8e-12),'tan values 473')
end
do -- tan supported 474
 local a=np.array({{7,2,64},{0,2,2}},np.uint64)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 474 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'tan shape 474')
 assert(seqeq(r.strides,{24,8}),'tan strides 474')
 assert(veq(r:tolist(),{{0.8714479827243188,-2.185039863261519,2.3478603091954366},{0.0,-2.185039863261519,-2.185039863261519}},8e-12),'tan values 474')
end
do -- tan supported 475
 local a=np.array({{{0.0},{1.5703125},{-3.140625}},{{6.0},{-6.0},{-3.140625}}},np.float16)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 475 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 475')
 assert(seqeq(r.strides,{6,2,2}),'tan strides 475')
 assert(veq(r:tolist(),{{{0.0},{2066.0},{0.0009675025939941406}},{{-0.291015625},{0.291015625},{0.0009675025939941406}}},2e-3),'tan values 475')
end
do -- tan supported 476
 local a=np.array({{{7},{1},{7}},{{31},{1},{4}}},np.uint8)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 476 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 476')
 assert(seqeq(r.strides,{6,2,2}),'tan strides 476')
 assert(veq(r:tolist(),{{{0.87158203125},{1.5576171875},{0.87158203125}},{{-0.441650390625},{1.5576171875},{1.158203125}}},2e-3),'tan values 476')
end
do -- tan supported 477
 local a=np.array({1.5707963,-0.0,-1.0,-6.0,-6.0,3.1415926,0.5},np.float64)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 477 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 477')
 assert(seqeq(r.strides,{8}),'tan strides 477')
 assert(veq(r:tolist(),{37320539.634354815,-0.0,-1.5574077246549023,0.29100619138474915,0.29100619138474915,-5.3589793170057325e-08,0.5463024898437905},8e-12),'tan values 477')
end
do -- tan supported 478
 local a=(np.array({{true,true,true},{true,true,true}},np.bool)).T
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 478 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'tan shape 478')
 assert(seqeq(r.strides,{2,6}),'tan strides 478')
 assert(veq(r:tolist(),{{1.5576171875,1.5576171875},{1.5576171875,1.5576171875},{1.5576171875,1.5576171875}},2e-3),'tan values 478')
end
do -- tan supported 479
 local a=np.array({-0.0,-1.0,-3.140625,3.140625,1.0,6.0,3.140625},np.float16)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 479 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 479')
 assert(seqeq(r.strides,{2}),'tan strides 479')
 assert(veq(r:tolist(),{-0.0,-1.5576171875,0.0009675025939941406,-0.0009675025939941406,1.5576171875,-0.291015625,-0.0009675025939941406},2e-3),'tan values 479')
end
do -- tan supported 480
 local a=np.array({{{4},{4},{64}},{{64},{2},{31}}},np.uint16)
 local r=np.tan(a)
 assert(r.dtype=='float32','tan dtype 480 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 480')
 assert(seqeq(r.strides,{12,4,4}),'tan strides 480')
 assert(veq(r:tolist(),{{{1.1578211784362793},{1.1578211784362793},{2.347860336303711}},{{2.347860336303711},{-2.18503999710083},{-0.44169557094573975}}},2e-5),'tan values 480')
end
do -- tan supported 481
 local a=np.array({3,1,-7,4,-1,-3,-1},np.int8)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 481 '..r.dtype)
 assert(seqeq(r.shape,{7}),'tan shape 481')
 assert(seqeq(r.strides,{2}),'tan strides 481')
 assert(veq(r:tolist(),{-0.142578125,1.5576171875,-0.87158203125,1.158203125,-1.5576171875,0.142578125,-1.5576171875},2e-3),'tan values 481')
end
do -- tan supported 482
 local a=np.array({{{64},{0},{64}},{{0},{16},{4}}},np.uint32)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 482 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 482')
 assert(seqeq(r.strides,{24,8,8}),'tan strides 482')
 assert(veq(r:tolist(),{{{2.3478603091954366},{0.0},{2.3478603091954366}},{{0.0},{0.3006322420239034},{1.1578212823495775}}},8e-12),'tan values 482')
end
do -- tan supported 483
 local a=np.array({{-1,16,4},{3,-16,-7}},np.int16)
 local r=np.tan(a)
 assert(r.dtype=='float32','tan dtype 483 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'tan shape 483')
 assert(seqeq(r.strides,{12,4}),'tan strides 483')
 assert(veq(r:tolist(),{{-1.5574077367782593,0.3006322383880615,1.1578211784362793},{-0.14254653453826904,-0.3006322383880615,-0.8714479804039001}},2e-5),'tan values 483')
end
do -- tan supported 484
 local a=np.array({{3.1415926,0.0,3.1415926},{0.0,-1.5,-0.0}},np.float64)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 484 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'tan shape 484')
 assert(seqeq(r.strides,{24,8}),'tan strides 484')
 assert(veq(r:tolist(),{{-5.3589793170057325e-08,0.0,-5.3589793170057325e-08},{0.0,-14.101419947171719,-0.0}},8e-12),'tan values 484')
end
do -- tan supported 485
 local a=np.array({{{16},{0},{3}},{{16},{3},{3}}},np.uint32)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 485 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 485')
 assert(seqeq(r.strides,{24,8,8}),'tan strides 485')
 assert(veq(r:tolist(),{{{0.3006322420239034},{0.0},{-0.1425465430742778}},{{0.3006322420239034},{-0.1425465430742778},{-0.1425465430742778}}},8e-12),'tan values 485')
end
do -- tan supported 486
 local a=(np.array({{7,3,16},{64,31,1}},np.uint8)).T
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 486 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'tan shape 486')
 assert(seqeq(r.strides,{2,6}),'tan strides 486')
 assert(veq(r:tolist(),{{0.87158203125,2.34765625},{-0.142578125,-0.441650390625},{0.300537109375,1.5576171875}},2e-3),'tan values 486')
end
do -- tan supported 487
 local a=np.array({{{31},{3},{2}},{{1},{64},{2}}},np.uint32)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 487 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 487')
 assert(seqeq(r.strides,{24,8,8}),'tan strides 487')
 assert(veq(r:tolist(),{{{-0.441695568020698},{-0.1425465430742778},{-2.185039863261519}},{{1.5574077246549023},{2.3478603091954366},{-2.185039863261519}}},8e-12),'tan values 487')
end
do -- tan supported 488
 local a=np.array({{-3.140625,0.5,-0.0},{-6.0,1.5703125,0.0}},np.float16)
 local r=np.tan(a)
 assert(r.dtype=='float16','tan dtype 488 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'tan shape 488')
 assert(seqeq(r.strides,{6,2}),'tan strides 488')
 assert(veq(r:tolist(),{{0.0009675025939941406,0.54638671875,-0.0},{0.291015625,2066.0,0.0}},2e-3),'tan values 488')
end
do -- tan supported 489
 local a=(np.array({{0,1,4},{0,2,16}},np.uint32)).T
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 489 '..r.dtype)
 assert(seqeq(r.shape,{3,2}),'tan shape 489')
 assert(seqeq(r.strides,{8,24}),'tan strides 489')
 assert(veq(r:tolist(),{{0.0,0.0},{1.5574077246549023,-2.185039863261519},{1.1578212823495775,0.3006322420239034}},8e-12),'tan values 489')
end
do -- tan supported 490
 local a=np.array({{4,1,4},{-1,0,2}},np.int32)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 490 '..r.dtype)
 assert(seqeq(r.shape,{2,3}),'tan shape 490')
 assert(seqeq(r.strides,{24,8}),'tan strides 490')
 assert(veq(r:tolist(),{{1.1578212823495775,1.5574077246549023,1.1578212823495775},{-1.5574077246549023,0.0,-2.185039863261519}},8e-12),'tan values 490')
end
do -- tan supported 491
 local a=np.array({{{9},{4},{-7}},{{9},{-3},{1}}},np.int64)
 local r=np.tan(a)
 assert(r.dtype=='float64','tan dtype 491 '..r.dtype)
 assert(seqeq(r.shape,{2,3,1}),'tan shape 491')
 assert(seqeq(r.strides,{24,8,8}),'tan strides 491')
 assert(veq(r:tolist(),{{{-0.45231565944180985},{1.1578212823495775},{-0.8714479827243188}},{{-0.45231565944180985},{0.1425465430742778},{1.5574077246549023}}},8e-12),'tan values 491')
end
do -- sqrt outwhere 492
 local a=np.array({{0,64,3},{16,3,1}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 492')
 assert(o.dtype=='float32','sqrt out dtype 492')
 assert(veq(o:tolist(),{{0.0,3.0,1.7320507764816284},{3.0,1.7320507764816284,3.0}},8e-12),'sqrt out values 492')
end
do -- sqrt outwhere 493
 local a=np.array({{-4.0,0.0,-4.0},{1.0,-4.0,0.5}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 493')
 assert(o.dtype=='float32','sqrt out dtype 493')
 assert(veq(o:tolist(),{{(0/0),3.0,(0/0)},{3.0,(0/0),3.0}},2e-5),'sqrt out values 493')
end
do -- sqrt outwhere 494
 local a=np.array({{true,true,true},{true,true,true}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 494')
 assert(o.dtype=='float16','sqrt out dtype 494')
 assert(veq(o:tolist(),{{1.0,3.0,1.0},{3.0,1.0,3.0}},2e-3),'sqrt out values 494')
end
do -- sqrt outwhere 495
 local a=np.array({{0,7,0},{64,3,0}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 495')
 assert(o.dtype=='float64','sqrt out dtype 495')
 assert(veq(o:tolist(),{{0.0,3.0,0.0},{3.0,1.732421875,3.0}},2e-3),'sqrt out values 495')
end
do -- sqrt outwhere 496
 local a=np.array({{0,16,2},{3,16,7}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 496')
 assert(o.dtype=='float32','sqrt out dtype 496')
 assert(veq(o:tolist(),{{0.0,3.0,1.4142135381698608},{3.0,4.0,3.0}},2e-5),'sqrt out values 496')
end
do -- sqrt outwhere 497
 local a=np.array({{math.huge,0.125,0.125},{-0.0,0.0,2.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 497')
 assert(o.dtype=='float32','sqrt out dtype 497')
 assert(veq(o:tolist(),{{math.huge,3.0,0.3535533845424652},{3.0,0.0,3.0}},2e-5),'sqrt out values 497')
end
do -- sqrt outwhere 498
 local a=np.array({{9,4,2},{-16,4,-16}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 498')
 assert(o.dtype=='float64','sqrt out dtype 498')
 assert(veq(o:tolist(),{{3.0,3.0,1.4140625},{3.0,2.0,3.0}},2e-3),'sqrt out values 498')
end
do -- sqrt outwhere 499
 local a=np.array({{-16.0,1.0,4.0},{16.0,-16.0,-16.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 499')
 assert(o.dtype=='float32','sqrt out dtype 499')
 assert(veq(o:tolist(),{{(0/0),3.0,2.0},{3.0,(0/0),3.0}},2e-5),'sqrt out values 499')
end
do -- sqrt outwhere 500
 local a=np.array({{-16.0,-1.0,16.0},{-4.0,0.0,0.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 500')
 assert(o.dtype=='float64','sqrt out dtype 500')
 assert(veq(o:tolist(),{{(0/0),3.0,4.0},{3.0,0.0,3.0}},2e-5),'sqrt out values 500')
end
do -- sqrt outwhere 501
 local a=np.array({{1,16,0},{16,2,7}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 501')
 assert(o.dtype=='float64','sqrt out dtype 501')
 assert(veq(o:tolist(),{{1.0,3.0,0.0},{3.0,1.4142135381698608,3.0}},2e-5),'sqrt out values 501')
end
do -- sqrt outwhere 502
 local a=np.array({{true,false,true},{true,true,false}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 502')
 assert(o.dtype=='float16','sqrt out dtype 502')
 assert(veq(o:tolist(),{{1.0,3.0,1.0},{3.0,1.0,3.0}},2e-3),'sqrt out values 502')
end
do -- sqrt outwhere 503
 local a=np.array({{2,0,16},{-16,16,16}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 503')
 assert(o.dtype=='float16','sqrt out dtype 503')
 assert(veq(o:tolist(),{{1.4140625,3.0,4.0},{3.0,4.0,3.0}},2e-3),'sqrt out values 503')
end
do -- sqrt outwhere 504
 local a=np.array({{1,64,4},{16,31,4}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 504')
 assert(o.dtype=='float32','sqrt out dtype 504')
 assert(veq(o:tolist(),{{1.0,3.0,2.0},{3.0,5.56640625,3.0}},2e-3),'sqrt out values 504')
end
do -- sqrt outwhere 505
 local a=np.array({{4,64,0},{7,2,64}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 505')
 assert(o.dtype=='float32','sqrt out dtype 505')
 assert(veq(o:tolist(),{{2.0,3.0,0.0},{3.0,1.4142135381698608,3.0}},8e-12),'sqrt out values 505')
end
do -- sqrt outwhere 506
 local a=np.array({{4,1,4},{2,16,-3}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 506')
 assert(o.dtype=='float32','sqrt out dtype 506')
 assert(veq(o:tolist(),{{2.0,3.0,2.0},{3.0,4.0,3.0}},2e-5),'sqrt out values 506')
end
do -- sqrt outwhere 507
 local a=np.array({{0.125,0.0,math.huge},{math.huge,-0.0,1.0}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 507')
 assert(o.dtype=='float64','sqrt out dtype 507')
 assert(veq(o:tolist(),{{0.3535533905932738,3.0,math.huge},{3.0,-0.0,3.0}},8e-12),'sqrt out values 507')
end
do -- sqrt outwhere 508
 local a=np.array({{0,-16,-1},{1,-16,16}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 508')
 assert(o.dtype=='float64','sqrt out dtype 508')
 assert(veq(o:tolist(),{{0.0,3.0,(0/0)},{3.0,(0/0),3.0}},2e-5),'sqrt out values 508')
end
do -- sqrt outwhere 509
 local a=np.array({{1,16,16},{0,1,3}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 509')
 assert(o.dtype=='float32','sqrt out dtype 509')
 assert(veq(o:tolist(),{{1.0,3.0,4.0},{3.0,1.0,3.0}},2e-3),'sqrt out values 509')
end
do -- sqrt outwhere 510
 local a=np.array({{-3,2,-7},{1,2,1}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 510')
 assert(o.dtype=='float64','sqrt out dtype 510')
 assert(veq(o:tolist(),{{(0/0),3.0,(0/0)},{3.0,1.4142135381698608,3.0}},2e-5),'sqrt out values 510')
end
do -- sqrt outwhere 511
 local a=np.array({{0,3,3},{3,1,-7}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 511')
 assert(o.dtype=='float64','sqrt out dtype 511')
 assert(veq(o:tolist(),{{0.0,3.0,1.7320508075688772},{3.0,1.0,3.0}},8e-12),'sqrt out values 511')
end
do -- sqrt outwhere 512
 local a=np.array({{0.125,16.0,math.huge},{1.0,2.0,0.125}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 512')
 assert(o.dtype=='float64','sqrt out dtype 512')
 assert(veq(o:tolist(),{{0.3535533905932738,3.0,math.huge},{3.0,1.4142135623730951,3.0}},8e-12),'sqrt out values 512')
end
do -- sqrt outwhere 513
 local a=np.array({{9,16,2},{-3,3,-1}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 513')
 assert(o.dtype=='float64','sqrt out dtype 513')
 assert(veq(o:tolist(),{{3.0,3.0,1.4142135623730951},{3.0,1.7320508075688772,3.0}},8e-12),'sqrt out values 513')
end
do -- sqrt outwhere 514
 local a=np.array({{64,1,64},{16,64,31}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 514')
 assert(o.dtype=='float64','sqrt out dtype 514')
 assert(veq(o:tolist(),{{8.0,3.0,8.0},{3.0,8.0,3.0}},8e-12),'sqrt out values 514')
end
do -- sqrt outwhere 515
 local a=np.array({{-1.0,0.125,0.125},{0.0,1.0,16.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 515')
 assert(o.dtype=='float16','sqrt out dtype 515')
 assert(veq(o:tolist(),{{(0/0),3.0,0.353515625},{3.0,1.0,3.0}},2e-5),'sqrt out values 515')
end
do -- sqrt outwhere 516
 local a=np.array({{true,true,true},{true,true,true}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 516')
 assert(o.dtype=='float16','sqrt out dtype 516')
 assert(veq(o:tolist(),{{1.0,3.0,1.0},{3.0,1.0,3.0}},2e-3),'sqrt out values 516')
end
do -- sqrt outwhere 517
 local a=np.array({{16.0,0.0,1.0},{-16.0,16.0,0.5}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 517')
 assert(o.dtype=='float64','sqrt out dtype 517')
 assert(veq(o:tolist(),{{4.0,3.0,1.0},{3.0,4.0,3.0}},2e-5),'sqrt out values 517')
end
do -- sqrt outwhere 518
 local a=np.array({{1.0,1.0,1.0},{0.125,-1.0,1.0}},np.float16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 518')
 assert(o.dtype=='float32','sqrt out dtype 518')
 assert(veq(o:tolist(),{{1.0,3.0,1.0},{3.0,(0/0),3.0}},2e-3),'sqrt out values 518')
end
do -- sqrt outwhere 519
 local a=np.array({{16,-3,-16},{-16,4,-1}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'sqrt out identity 519')
 assert(o.dtype=='float16','sqrt out dtype 519')
 assert(veq(o:tolist(),{{4.0,3.0,(0/0)},{3.0,2.0,3.0}},8e-12),'sqrt out values 519')
end
do -- exp outwhere 520
 local a=np.array({{true,true,true},{false,true,false}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 520')
 assert(o.dtype=='float32','exp out dtype 520')
 assert(veq(o:tolist(),{{2.71875,3.0,2.71875},{3.0,2.71875,3.0}},2e-3),'exp out values 520')
end
do -- exp outwhere 521
 local a=np.array({{2,3,-7},{-3,-1,-7}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 521')
 assert(o.dtype=='float32','exp out dtype 521')
 assert(veq(o:tolist(),{{7.3890557289123535,3.0,0.0009118819143623114},{3.0,0.3678794205188751,3.0}},2e-5),'exp out values 521')
end
do -- exp outwhere 522
 local a=np.array({{16,3,16},{16,2,7}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 522')
 assert(o.dtype=='float32','exp out dtype 522')
 assert(veq(o:tolist(),{{8886111.0,3.0,8886111.0},{3.0,7.3890557289123535,3.0}},2e-5),'exp out values 522')
end
do -- exp outwhere 523
 local a=np.array({{9,4,16},{16,-16,3}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 523')
 assert(o.dtype=='float64','exp out dtype 523')
 assert(veq(o:tolist(),{{8103.083984375,3.0,8886111.0},{3.0,1.1253516873921399e-07,3.0}},2e-5),'exp out values 523')
end
do -- exp outwhere 524
 local a=np.array({{true,true,true},{false,true,true}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 524')
 assert(o.dtype=='float16','exp out dtype 524')
 assert(veq(o:tolist(),{{2.71875,3.0,2.71875},{3.0,2.71875,3.0}},2e-3),'exp out values 524')
end
do -- exp outwhere 525
 local a=np.array({{16,0,31},{4,16,3}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 525')
 assert(o.dtype=='float64','exp out dtype 525')
 assert(veq(o:tolist(),{{8886110.520507872,3.0,29048849665247.426},{3.0,8886110.520507872,3.0}},8e-12),'exp out values 525')
end
do -- exp outwhere 526
 local a=np.array({{4,16,16},{64,3,16}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 526')
 assert(o.dtype=='float32','exp out dtype 526')
 assert(veq(o:tolist(),{{54.598148345947266,3.0,8886111.0},{3.0,20.08553695678711,3.0}},8e-12),'exp out values 526')
end
do -- exp outwhere 527
 local a=np.array({{1,1,0},{3,3,0}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 527')
 assert(o.dtype=='float32','exp out dtype 527')
 assert(veq(o:tolist(),{{2.71875,3.0,1.0},{3.0,20.078125,3.0}},2e-3),'exp out values 527')
end
do -- exp outwhere 528
 local a=np.array({{5.0,2.0,0.0},{-0.0,-1.0,0.5}},np.float16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 528')
 assert(o.dtype=='float32','exp out dtype 528')
 assert(veq(o:tolist(),{{148.375,3.0,1.0},{3.0,0.367919921875,3.0}},2e-3),'exp out values 528')
end
do -- exp outwhere 529
 local a=np.array({{-1.0,5.0,-0.0},{-1.0,-3.0,1.0}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 529')
 assert(o.dtype=='float64','exp out dtype 529')
 assert(veq(o:tolist(),{{0.36787944117144233,3.0,1.0},{3.0,0.049787068367863944,3.0}},8e-12),'exp out values 529')
end
do -- exp outwhere 530
 local a=np.array({{16,3,3},{2,1,1}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 530')
 assert(o.dtype=='float16','exp out dtype 530')
 assert(veq(o:tolist(),{{math.huge,3.0,20.078125},{3.0,2.71875,3.0}},2e-5),'exp out values 530')
end
do -- exp outwhere 531
 local a=np.array({{3,9,-3},{-7,-16,2}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 531')
 assert(o.dtype=='float64','exp out dtype 531')
 assert(veq(o:tolist(),{{20.078125,3.0,0.049774169921875},{3.0,1.1920928955078125e-07,3.0}},2e-3),'exp out values 531')
end
do -- exp outwhere 532
 local a=np.array({{64,64,64},{64,16,3}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 532')
 assert(o.dtype=='float16','exp out dtype 532')
 assert(veq(o:tolist(),{{math.huge,3.0,math.huge},{3.0,math.huge,3.0}},2e-3),'exp out values 532')
end
do -- exp outwhere 533
 local a=np.array({{64,64,3},{2,2,4}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 533')
 assert(o.dtype=='float64','exp out dtype 533')
 assert(veq(o:tolist(),{{6.235149080811617e+27,3.0,20.085536923187668},{3.0,7.38905609893065,3.0}},8e-12),'exp out values 533')
end
do -- exp outwhere 534
 local a=np.array({{4,9,-3},{0,4,3}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 534')
 assert(o.dtype=='float16','exp out dtype 534')
 assert(veq(o:tolist(),{{54.59375,3.0,0.049774169921875},{3.0,54.59375,3.0}},2e-3),'exp out values 534')
end
do -- exp outwhere 535
 local a=np.array({{0.5,1.0,0.0},{-1.0,0.5,0.5}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 535')
 assert(o.dtype=='float32','exp out dtype 535')
 assert(veq(o:tolist(),{{1.6487212181091309,3.0,1.0},{3.0,1.6487212181091309,3.0}},2e-5),'exp out values 535')
end
do -- exp outwhere 536
 local a=np.array({{16,7,4},{16,31,7}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 536')
 assert(o.dtype=='float32','exp out dtype 536')
 assert(veq(o:tolist(),{{math.huge,3.0,54.59375},{3.0,math.huge,3.0}},2e-3),'exp out values 536')
end
do -- exp outwhere 537
 local a=np.array({{-7,9,0},{-3,4,16}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 537')
 assert(o.dtype=='float64','exp out dtype 537')
 assert(veq(o:tolist(),{{0.0009118819143623114,3.0,1.0},{3.0,54.598148345947266,3.0}},2e-5),'exp out values 537')
end
do -- exp outwhere 538
 local a=np.array({{1,1,4},{16,7,1}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 538')
 assert(o.dtype=='float16','exp out dtype 538')
 assert(veq(o:tolist(),{{2.71875,3.0,54.59375},{3.0,1097.0,3.0}},2e-3),'exp out values 538')
end
do -- exp outwhere 539
 local a=np.array({{16,4,-1},{2,-1,16}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 539')
 assert(o.dtype=='float16','exp out dtype 539')
 assert(veq(o:tolist(),{{math.huge,3.0,0.367919921875},{3.0,0.367919921875,3.0}},2e-3),'exp out values 539')
end
do -- exp outwhere 540
 local a=np.array({{0.0,5.0,-1.0},{-3.0,-0.0,1.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 540')
 assert(o.dtype=='float64','exp out dtype 540')
 assert(veq(o:tolist(),{{1.0,3.0,0.3678794205188751},{3.0,1.0,3.0}},2e-5),'exp out values 540')
end
do -- exp outwhere 541
 local a=np.array({{1,1,31},{4,7,3}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 541')
 assert(o.dtype=='float16','exp out dtype 541')
 assert(veq(o:tolist(),{{2.71875,3.0,math.huge},{3.0,1097.0,3.0}},8e-12),'exp out values 541')
end
do -- exp outwhere 542
 local a=np.array({{4,9,9},{9,-16,-16}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 542')
 assert(o.dtype=='float16','exp out dtype 542')
 assert(veq(o:tolist(),{{54.59375,3.0,8104.0},{3.0,1.1920928955078125e-07,3.0}},2e-5),'exp out values 542')
end
do -- exp outwhere 543
 local a=np.array({{1,-3,3},{-3,-3,-3}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 543')
 assert(o.dtype=='float16','exp out dtype 543')
 assert(veq(o:tolist(),{{2.71875,3.0,20.078125},{3.0,0.049774169921875,3.0}},8e-12),'exp out values 543')
end
do -- exp outwhere 544
 local a=np.array({{0.0,-3.0,1.0},{-1.0,0.0,-0.0}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 544')
 assert(o.dtype=='float64','exp out dtype 544')
 assert(veq(o:tolist(),{{1.0,3.0,2.718281828459045},{3.0,1.0,3.0}},8e-12),'exp out values 544')
end
do -- exp outwhere 545
 local a=np.array({{3,2,16},{4,16,7}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 545')
 assert(o.dtype=='float32','exp out dtype 545')
 assert(veq(o:tolist(),{{20.078125,3.0,math.huge},{3.0,math.huge,3.0}},2e-3),'exp out values 545')
end
do -- exp outwhere 546
 local a=np.array({{9,-1,4},{16,0,-3}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 546')
 assert(o.dtype=='float16','exp out dtype 546')
 assert(veq(o:tolist(),{{8104.0,3.0,54.59375},{3.0,1.0,3.0}},8e-12),'exp out values 546')
end
do -- exp outwhere 547
 local a=np.array({{false,false,true},{true,false,true}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'exp out identity 547')
 assert(o.dtype=='float32','exp out dtype 547')
 assert(veq(o:tolist(),{{1.0,3.0,2.71875},{3.0,1.0,3.0}},2e-3),'exp out values 547')
end
do -- log outwhere 548
 local a=np.array({{16,-7,-7},{-3,-1,16}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 548')
 assert(o.dtype=='float32','log out dtype 548')
 assert(veq(o:tolist(),{{2.7725887298583984,3.0,(0/0)},{3.0,(0/0),3.0}},8e-12),'log out values 548')
end
do -- log outwhere 549
 local a=np.array({{1.0,0.0,0.0},{2.0,1.0,4.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 549')
 assert(o.dtype=='float16','log out dtype 549')
 assert(veq(o:tolist(),{{0.0,3.0,-math.huge},{3.0,0.0,3.0}},2e-5),'log out values 549')
end
do -- log outwhere 550
 local a=np.array({{0.0,-4.0,4.0},{2.0,1.0,0.5}},np.float16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 550')
 assert(o.dtype=='float16','log out dtype 550')
 assert(veq(o:tolist(),{{-math.huge,3.0,1.38671875},{3.0,0.0,3.0}},2e-3),'log out values 550')
end
do -- log outwhere 551
 local a=np.array({{-7,-7,2},{4,-3,1}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 551')
 assert(o.dtype=='float64','log out dtype 551')
 assert(veq(o:tolist(),{{(0/0),3.0,0.6931471805599453},{3.0,(0/0),3.0}},8e-12),'log out values 551')
end
do -- log outwhere 552
 local a=np.array({{9,2,3},{-1,9,-3}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 552')
 assert(o.dtype=='float32','log out dtype 552')
 assert(veq(o:tolist(),{{2.1972246170043945,3.0,1.0986123085021973},{3.0,2.1972246170043945,3.0}},8e-12),'log out values 552')
end
do -- log outwhere 553
 local a=np.array({{3,3,7},{1,0,64}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 553')
 assert(o.dtype=='float16','log out dtype 553')
 assert(veq(o:tolist(),{{1.0986328125,3.0,1.9462890625},{3.0,-math.huge,3.0}},8e-12),'log out values 553')
end
do -- log outwhere 554
 local a=np.array({{1,3,3},{31,64,0}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 554')
 assert(o.dtype=='float16','log out dtype 554')
 assert(veq(o:tolist(),{{0.0,3.0,1.0986328125},{3.0,4.16015625,3.0}},2e-3),'log out values 554')
end
do -- log outwhere 555
 local a=np.array({{1.0,0.125,2.0},{1.0,-0.0,-16.0}},np.float16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 555')
 assert(o.dtype=='float16','log out dtype 555')
 assert(veq(o:tolist(),{{0.0,3.0,0.693359375},{3.0,-math.huge,3.0}},2e-3),'log out values 555')
end
do -- log outwhere 556
 local a=np.array({{1.0,2.0,math.huge},{-1.0,16.0,16.0}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 556')
 assert(o.dtype=='float64','log out dtype 556')
 assert(veq(o:tolist(),{{0.0,3.0,math.huge},{3.0,2.772588722239781,3.0}},8e-12),'log out values 556')
end
do -- log outwhere 557
 local a=np.array({{31,3,1},{3,2,16}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 557')
 assert(o.dtype=='float64','log out dtype 557')
 assert(veq(o:tolist(),{{3.4339872044851463,3.0,0.0},{3.0,0.6931471805599453,3.0}},8e-12),'log out values 557')
end
do -- log outwhere 558
 local a=np.array({{2.0,2.0,0.5},{4.0,-0.0,0.5}},np.float16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 558')
 assert(o.dtype=='float64','log out dtype 558')
 assert(veq(o:tolist(),{{0.693359375,3.0,-0.693359375},{3.0,-math.huge,3.0}},2e-3),'log out values 558')
end
do -- log outwhere 559
 local a=np.array({{math.huge,1.0,math.huge},{0.5,0.125,math.huge}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 559')
 assert(o.dtype=='float64','log out dtype 559')
 assert(veq(o:tolist(),{{math.huge,3.0,math.huge},{3.0,-2.0794415416798357,3.0}},8e-12),'log out values 559')
end
do -- log outwhere 560
 local a=np.array({{2,31,1},{0,7,1}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 560')
 assert(o.dtype=='float32','log out dtype 560')
 assert(veq(o:tolist(),{{0.6931471824645996,3.0,0.0},{3.0,1.945910096168518,3.0}},8e-12),'log out values 560')
end
do -- log outwhere 561
 local a=np.array({{false,false,false},{true,true,true}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 561')
 assert(o.dtype=='float32','log out dtype 561')
 assert(veq(o:tolist(),{{-math.huge,3.0,-math.huge},{3.0,0.0,3.0}},2e-3),'log out values 561')
end
do -- log outwhere 562
 local a=np.array({{1.0,2.0,1.0},{-1.0,-0.0,-0.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 562')
 assert(o.dtype=='float64','log out dtype 562')
 assert(veq(o:tolist(),{{0.0,3.0,0.0},{3.0,-math.huge,3.0}},2e-5),'log out values 562')
end
do -- log outwhere 563
 local a=np.array({{16.0,-16.0,-1.0},{0.5,-4.0,0.0}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 563')
 assert(o.dtype=='float32','log out dtype 563')
 assert(veq(o:tolist(),{{2.7725887298583984,3.0,(0/0)},{3.0,(0/0),3.0}},8e-12),'log out values 563')
end
do -- log outwhere 564
 local a=np.array({{math.huge,16.0,4.0},{-1.0,4.0,0.125}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 564')
 assert(o.dtype=='float64','log out dtype 564')
 assert(veq(o:tolist(),{{math.huge,3.0,1.3862943611198906},{3.0,1.3862943611198906,3.0}},8e-12),'log out values 564')
end
do -- log outwhere 565
 local a=np.array({{2,16,7},{16,16,0}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 565')
 assert(o.dtype=='float64','log out dtype 565')
 assert(veq(o:tolist(),{{0.6931471805599453,3.0,1.9459101490553132},{3.0,2.772588722239781,3.0}},8e-12),'log out values 565')
end
do -- log outwhere 566
 local a=np.array({{64,2,3},{3,4,7}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 566')
 assert(o.dtype=='float64','log out dtype 566')
 assert(veq(o:tolist(),{{4.1588830833596715,3.0,1.0986122886681098},{3.0,1.3862943611198906,3.0}},8e-12),'log out values 566')
end
do -- log outwhere 567
 local a=np.array({{0.5,-4.0,16.0},{-4.0,-1.0,1.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 567')
 assert(o.dtype=='float32','log out dtype 567')
 assert(veq(o:tolist(),{{-0.6931471824645996,3.0,2.7725887298583984},{3.0,(0/0),3.0}},2e-5),'log out values 567')
end
do -- log outwhere 568
 local a=np.array({{9,2,0},{-7,-1,9}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 568')
 assert(o.dtype=='float32','log out dtype 568')
 assert(veq(o:tolist(),{{2.1972246170043945,3.0,-math.huge},{3.0,(0/0),3.0}},8e-12),'log out values 568')
end
do -- log outwhere 569
 local a=np.array({{true,true,true},{true,true,true}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 569')
 assert(o.dtype=='float64','log out dtype 569')
 assert(veq(o:tolist(),{{0.0,3.0,0.0},{3.0,0.0,3.0}},2e-3),'log out values 569')
end
do -- log outwhere 570
 local a=np.array({{0.5,1.0,math.huge},{1.0,0.125,0.5}},np.float16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 570')
 assert(o.dtype=='float32','log out dtype 570')
 assert(veq(o:tolist(),{{-0.693359375,3.0,math.huge},{3.0,-2.080078125,3.0}},2e-3),'log out values 570')
end
do -- log outwhere 571
 local a=np.array({{2,4,-7},{-3,16,-16}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 571')
 assert(o.dtype=='float64','log out dtype 571')
 assert(veq(o:tolist(),{{0.693359375,3.0,(0/0)},{3.0,2.7734375,3.0}},2e-3),'log out values 571')
end
do -- log outwhere 572
 local a=np.array({{4.0,16.0,1.0},{16.0,-1.0,-0.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 572')
 assert(o.dtype=='float32','log out dtype 572')
 assert(veq(o:tolist(),{{1.3862943649291992,3.0,0.0},{3.0,(0/0),3.0}},2e-5),'log out values 572')
end
do -- log outwhere 573
 local a=np.array({{16,3,2},{0,2,31}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 573')
 assert(o.dtype=='float64','log out dtype 573')
 assert(veq(o:tolist(),{{2.772588722239781,3.0,0.6931471805599453},{3.0,0.6931471805599453,3.0}},8e-12),'log out values 573')
end
do -- log outwhere 574
 local a=np.array({{1,1,1},{4,3,-7}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 574')
 assert(o.dtype=='float32','log out dtype 574')
 assert(veq(o:tolist(),{{0.0,3.0,0.0},{3.0,1.0986123085021973,3.0}},2e-5),'log out values 574')
end
do -- log outwhere 575
 local a=np.array({{7,7,2},{64,7,1}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'log out identity 575')
 assert(o.dtype=='float64','log out dtype 575')
 assert(veq(o:tolist(),{{1.9462890625,3.0,0.693359375},{3.0,1.9462890625,3.0}},2e-3),'log out values 575')
end
do -- sin outwhere 576
 local a=np.array({{false,true,false},{true,false,true}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 576')
 assert(o.dtype=='float64','sin out dtype 576')
 assert(veq(o:tolist(),{{0.0,3.0,0.0},{3.0,0.0,3.0}},2e-3),'sin out values 576')
end
do -- sin outwhere 577
 local a=np.array({{7,2,64},{0,0,0}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 577')
 assert(o.dtype=='float16','sin out dtype 577')
 assert(veq(o:tolist(),{{0.6572265625,3.0,0.919921875},{3.0,0.0,3.0}},2e-5),'sin out values 577')
end
do -- sin outwhere 578
 local a=np.array({{-16,0,-3},{-7,-16,1}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 578')
 assert(o.dtype=='float16','sin out dtype 578')
 assert(veq(o:tolist(),{{0.287841796875,3.0,-0.14111328125},{3.0,0.287841796875,3.0}},2e-3),'sin out values 578')
end
do -- sin outwhere 579
 local a=np.array({{1,3,-3},{-16,-16,-16}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 579')
 assert(o.dtype=='float16','sin out dtype 579')
 assert(veq(o:tolist(),{{0.84130859375,3.0,-0.14111328125},{3.0,0.287841796875,3.0}},8e-12),'sin out values 579')
end
do -- sin outwhere 580
 local a=np.array({{1,4,16},{-7,16,-1}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 580')
 assert(o.dtype=='float16','sin out dtype 580')
 assert(veq(o:tolist(),{{0.84130859375,3.0,-0.287841796875},{3.0,-0.287841796875,3.0}},2e-3),'sin out values 580')
end
do -- sin outwhere 581
 local a=np.array({{-6.0,-6.0,-3.141592502593994},{-1.0,-6.0,-6.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 581')
 assert(o.dtype=='float32','sin out dtype 581')
 assert(veq(o:tolist(),{{0.279415488243103,3.0,-1.5099580252808664e-07},{3.0,0.279415488243103,3.0}},2e-5),'sin out values 581')
end
do -- sin outwhere 582
 local a=np.array({{-3.1415926,-3.1415926,-1.0},{-1.5,-6.0,-6.0}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 582')
 assert(o.dtype=='float32','sin out dtype 582')
 assert(veq(o:tolist(),{{-5.358979393577101e-08,3.0,-0.8414709568023682},{3.0,0.279415488243103,3.0}},8e-12),'sin out values 582')
end
do -- sin outwhere 583
 local a=np.array({{-1.0,-0.0,1.570796251296997},{-0.0,1.570796251296997,1.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 583')
 assert(o.dtype=='float64','sin out dtype 583')
 assert(veq(o:tolist(),{{-0.8414710164070129,3.0,1.0},{3.0,1.0,3.0}},2e-5),'sin out values 583')
end
do -- sin outwhere 584
 local a=np.array({{-7,0,16},{1,16,-16}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 584')
 assert(o.dtype=='float32','sin out dtype 584')
 assert(veq(o:tolist(),{{-0.6569865942001343,3.0,-0.2879033088684082},{3.0,-0.2879033088684082,3.0}},8e-12),'sin out values 584')
end
do -- sin outwhere 585
 local a=np.array({{6.0,-3.141592502593994,6.0},{-0.0,-3.141592502593994,-3.141592502593994}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 585')
 assert(o.dtype=='float64','sin out dtype 585')
 assert(veq(o:tolist(),{{-0.279415488243103,3.0,-0.279415488243103},{3.0,-1.5099580252808664e-07,3.0}},2e-5),'sin out values 585')
end
do -- sin outwhere 586
 local a=np.array({{3,16,64},{16,31,2}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 586')
 assert(o.dtype=='float64','sin out dtype 586')
 assert(veq(o:tolist(),{{0.1411200080598672,3.0,0.9200260381967906},{3.0,-0.404037645323065,3.0}},8e-12),'sin out values 586')
end
do -- sin outwhere 587
 local a=np.array({{-3,-3,9},{9,-16,9}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 587')
 assert(o.dtype=='float32','sin out dtype 587')
 assert(veq(o:tolist(),{{-0.14111328125,3.0,0.412109375},{3.0,0.287841796875,3.0}},2e-3),'sin out values 587')
end
do -- sin outwhere 588
 local a=np.array({{16,2,-3},{1,-1,1}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 588')
 assert(o.dtype=='float64','sin out dtype 588')
 assert(veq(o:tolist(),{{-0.2879033166650653,3.0,-0.1411200080598672},{3.0,-0.8414709848078965,3.0}},8e-12),'sin out values 588')
end
do -- sin outwhere 589
 local a=np.array({{0,-1,9},{-7,-7,2}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 589')
 assert(o.dtype=='float64','sin out dtype 589')
 assert(veq(o:tolist(),{{0.0,3.0,0.4121184852417566},{3.0,-0.6569865987187891,3.0}},8e-12),'sin out values 589')
end
do -- sin outwhere 590
 local a=np.array({{-16,-3,4},{0,4,16}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 590')
 assert(o.dtype=='float32','sin out dtype 590')
 assert(veq(o:tolist(),{{0.2879033386707306,3.0,-0.756802499294281},{3.0,-0.756802499294281,3.0}},2e-5),'sin out values 590')
end
do -- sin outwhere 591
 local a=np.array({{-3,2,2},{3,1,-7}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 591')
 assert(o.dtype=='float16','sin out dtype 591')
 assert(veq(o:tolist(),{{-0.14111328125,3.0,0.9091796875},{3.0,0.84130859375,3.0}},8e-12),'sin out values 591')
end
do -- sin outwhere 592
 local a=np.array({{16,16,-16},{-1,3,3}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 592')
 assert(o.dtype=='float32','sin out dtype 592')
 assert(veq(o:tolist(),{{-0.287841796875,3.0,0.287841796875},{3.0,0.14111328125,3.0}},2e-3),'sin out values 592')
end
do -- sin outwhere 593
 local a=np.array({{true,true,true},{true,true,true}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 593')
 assert(o.dtype=='float16','sin out dtype 593')
 assert(veq(o:tolist(),{{0.84130859375,3.0,0.84130859375},{3.0,0.84130859375,3.0}},2e-3),'sin out values 593')
end
do -- sin outwhere 594
 local a=np.array({{64,0,0},{0,7,64}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 594')
 assert(o.dtype=='float16','sin out dtype 594')
 assert(veq(o:tolist(),{{0.919921875,3.0,0.0},{3.0,0.6572265625,3.0}},2e-3),'sin out values 594')
end
do -- sin outwhere 595
 local a=np.array({{16,64,1},{7,64,2}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 595')
 assert(o.dtype=='float32','sin out dtype 595')
 assert(veq(o:tolist(),{{-0.2879033088684082,3.0,0.8414709568023682},{3.0,0.9200260639190674,3.0}},8e-12),'sin out values 595')
end
do -- sin outwhere 596
 local a=np.array({{-3.1415926,-1.0,6.0},{-6.0,6.0,3.1415926}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 596')
 assert(o.dtype=='float32','sin out dtype 596')
 assert(veq(o:tolist(),{{-5.358979393577101e-08,3.0,-0.279415488243103},{3.0,-0.279415488243103,3.0}},8e-12),'sin out values 596')
end
do -- sin outwhere 597
 local a=np.array({{true,true,false},{true,true,false}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 597')
 assert(o.dtype=='float32','sin out dtype 597')
 assert(veq(o:tolist(),{{0.84130859375,3.0,0.0},{3.0,0.84130859375,3.0}},2e-3),'sin out values 597')
end
do -- sin outwhere 598
 local a=np.array({{1.0,3.141592502593994,-0.0},{-6.0,1.0,6.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 598')
 assert(o.dtype=='float16','sin out dtype 598')
 assert(veq(o:tolist(),{{0.84130859375,3.0,-0.0},{3.0,0.84130859375,3.0}},2e-5),'sin out values 598')
end
do -- sin outwhere 599
 local a=np.array({{4,-3,-3},{4,3,-7}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 599')
 assert(o.dtype=='float32','sin out dtype 599')
 assert(veq(o:tolist(),{{-0.7568359375,3.0,-0.14111328125},{3.0,0.14111328125,3.0}},2e-3),'sin out values 599')
end
do -- sin outwhere 600
 local a=np.array({{2,-3,3},{-3,3,0}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 600')
 assert(o.dtype=='float32','sin out dtype 600')
 assert(veq(o:tolist(),{{0.9092974066734314,3.0,0.14112000167369843},{3.0,0.14112000167369843,3.0}},2e-5),'sin out values 600')
end
do -- sin outwhere 601
 local a=np.array({{2,1,-16},{16,9,3}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 601')
 assert(o.dtype=='float32','sin out dtype 601')
 assert(veq(o:tolist(),{{0.9091796875,3.0,0.287841796875},{3.0,0.412109375,3.0}},2e-3),'sin out values 601')
end
do -- sin outwhere 602
 local a=np.array({{16,2,64},{2,7,31}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 602')
 assert(o.dtype=='float32','sin out dtype 602')
 assert(veq(o:tolist(),{{-0.2879033088684082,3.0,0.9200260639190674},{3.0,0.6569865942001343,3.0}},8e-12),'sin out values 602')
end
do -- sin outwhere 603
 local a=np.array({{-16,-1,-16},{16,0,-1}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'sin out identity 603')
 assert(o.dtype=='float32','sin out dtype 603')
 assert(veq(o:tolist(),{{0.287841796875,3.0,0.287841796875},{3.0,0.0,3.0}},2e-3),'sin out values 603')
end
do -- cos outwhere 604
 local a=np.array({{true,false,true},{true,true,true}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 604')
 assert(o.dtype=='float16','cos out dtype 604')
 assert(veq(o:tolist(),{{0.54052734375,3.0,0.54052734375},{3.0,0.54052734375,3.0}},2e-3),'cos out values 604')
end
do -- cos outwhere 605
 local a=np.array({{3,1,0},{-3,16,-16}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 605')
 assert(o.dtype=='float16','cos out dtype 605')
 assert(veq(o:tolist(),{{-0.990234375,3.0,1.0},{3.0,-0.95751953125,3.0}},8e-12),'cos out values 605')
end
do -- cos outwhere 606
 local a=np.array({{-16,0,16},{2,-16,2}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 606')
 assert(o.dtype=='float32','cos out dtype 606')
 assert(veq(o:tolist(),{{-0.9576594829559326,3.0,-0.9576594829559326},{3.0,-0.9576594829559326,3.0}},8e-12),'cos out values 606')
end
do -- cos outwhere 607
 local a=np.array({{4,4,16},{1,-1,3}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 607')
 assert(o.dtype=='float16','cos out dtype 607')
 assert(veq(o:tolist(),{{-0.65380859375,3.0,-0.95751953125},{3.0,0.54052734375,3.0}},2e-5),'cos out values 607')
end
do -- cos outwhere 608
 local a=np.array({{true,true,true},{true,true,false}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 608')
 assert(o.dtype=='float64','cos out dtype 608')
 assert(veq(o:tolist(),{{0.54052734375,3.0,0.54052734375},{3.0,0.54052734375,3.0}},2e-3),'cos out values 608')
end
do -- cos outwhere 609
 local a=np.array({{4,9,0},{4,-7,-1}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 609')
 assert(o.dtype=='float32','cos out dtype 609')
 assert(veq(o:tolist(),{{-0.65380859375,3.0,1.0},{3.0,0.75390625,3.0}},2e-3),'cos out values 609')
end
do -- cos outwhere 610
 local a=np.array({{16,16,-7},{-7,-3,-3}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 610')
 assert(o.dtype=='float32','cos out dtype 610')
 assert(veq(o:tolist(),{{-0.9576594829559326,3.0,0.7539022564888},{3.0,-0.9899924993515015,3.0}},8e-12),'cos out values 610')
end
do -- cos outwhere 611
 local a=np.array({{4,0,64},{2,31,3}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 611')
 assert(o.dtype=='float16','cos out dtype 611')
 assert(veq(o:tolist(),{{-0.65380859375,3.0,0.391845703125},{3.0,0.91455078125,3.0}},8e-12),'cos out values 611')
end
do -- cos outwhere 612
 local a=np.array({{true,false,false},{true,false,true}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 612')
 assert(o.dtype=='float64','cos out dtype 612')
 assert(veq(o:tolist(),{{0.54052734375,3.0,1.0},{3.0,1.0,3.0}},2e-3),'cos out values 612')
end
do -- cos outwhere 613
 local a=np.array({{2,0,16},{16,64,2}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 613')
 assert(o.dtype=='float16','cos out dtype 613')
 assert(veq(o:tolist(),{{-0.416259765625,3.0,-0.95751953125},{3.0,0.391845703125,3.0}},2e-5),'cos out values 613')
end
do -- cos outwhere 614
 local a=np.array({{-0.0,1.5707963,6.0},{0.5,1.0,0.5}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 614')
 assert(o.dtype=='float64','cos out dtype 614')
 assert(veq(o:tolist(),{{1.0,3.0,0.960170286650366},{3.0,0.5403023058681398,3.0}},8e-12),'cos out values 614')
end
do -- cos outwhere 615
 local a=np.array({{6.0,6.0,0.5},{1.570796251296997,0.5,-0.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 615')
 assert(o.dtype=='float32','cos out dtype 615')
 assert(veq(o:tolist(),{{0.9601702690124512,3.0,0.8775825500488281},{3.0,0.8775825500488281,3.0}},2e-5),'cos out values 615')
end
do -- cos outwhere 616
 local a=np.array({{7,2,4},{16,2,16}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 616')
 assert(o.dtype=='float32','cos out dtype 616')
 assert(veq(o:tolist(),{{0.7539022564888,3.0,-0.6536436080932617},{3.0,-0.416146844625473,3.0}},8e-12),'cos out values 616')
end
do -- cos outwhere 617
 local a=np.array({{3.1415926,0.5,1.5707963},{1.5707963,1.5707963,-6.0}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 617')
 assert(o.dtype=='float64','cos out dtype 617')
 assert(veq(o:tolist(),{{-0.9999999999999986,3.0,2.6794896585028633e-08},{3.0,2.6794896585028633e-08,3.0}},8e-12),'cos out values 617')
end
do -- cos outwhere 618
 local a=np.array({{3.1415926,1.5707963,1.0},{6.0,6.0,-6.0}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 618')
 assert(o.dtype=='float32','cos out dtype 618')
 assert(veq(o:tolist(),{{-1.0,3.0,0.5403022766113281},{3.0,0.9601702690124512,3.0}},8e-12),'cos out values 618')
end
do -- cos outwhere 619
 local a=np.array({{4,-16,1},{-16,16,-1}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 619')
 assert(o.dtype=='float16','cos out dtype 619')
 assert(veq(o:tolist(),{{-0.65380859375,3.0,0.54052734375},{3.0,-0.95751953125,3.0}},8e-12),'cos out values 619')
end
do -- cos outwhere 620
 local a=np.array({{-0.0,1.5707963,0.5},{-1.0,-1.0,6.0}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 620')
 assert(o.dtype=='float32','cos out dtype 620')
 assert(veq(o:tolist(),{{1.0,3.0,0.8775825500488281},{3.0,0.5403022766113281,3.0}},8e-12),'cos out values 620')
end
do -- cos outwhere 621
 local a=np.array({{0.0,0.5,-1.0},{-3.1415926,1.5707963,-1.0}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 621')
 assert(o.dtype=='float16','cos out dtype 621')
 assert(veq(o:tolist(),{{1.0,3.0,0.54052734375},{3.0,0.0,3.0}},8e-12),'cos out values 621')
end
do -- cos outwhere 622
 local a=np.array({{-16,-7,-1},{-16,4,1}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 622')
 assert(o.dtype=='float64','cos out dtype 622')
 assert(veq(o:tolist(),{{-0.95751953125,3.0,0.54052734375},{3.0,-0.65380859375,3.0}},2e-3),'cos out values 622')
end
do -- cos outwhere 623
 local a=np.array({{16,16,2},{9,3,4}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 623')
 assert(o.dtype=='float64','cos out dtype 623')
 assert(veq(o:tolist(),{{-0.9576594829559326,3.0,-0.41614681482315063},{3.0,-0.9899924993515015,3.0}},2e-5),'cos out values 623')
end
do -- cos outwhere 624
 local a=np.array({{2,64,0},{7,31,16}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 624')
 assert(o.dtype=='float32','cos out dtype 624')
 assert(veq(o:tolist(),{{-0.41614681482315063,3.0,1.0},{3.0,0.9147423505783081,3.0}},2e-5),'cos out values 624')
end
do -- cos outwhere 625
 local a=np.array({{4,0,0},{31,1,3}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 625')
 assert(o.dtype=='float32','cos out dtype 625')
 assert(veq(o:tolist(),{{-0.6536436080932617,3.0,1.0},{3.0,0.5403022766113281,3.0}},8e-12),'cos out values 625')
end
do -- cos outwhere 626
 local a=np.array({{1.5707963,6.0,-6.0},{1.0,6.0,6.0}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 626')
 assert(o.dtype=='float16','cos out dtype 626')
 assert(veq(o:tolist(),{{0.0,3.0,0.9599609375},{3.0,0.9599609375,3.0}},8e-12),'cos out values 626')
end
do -- cos outwhere 627
 local a=np.array({{4,3,-16},{1,-1,1}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 627')
 assert(o.dtype=='float32','cos out dtype 627')
 assert(veq(o:tolist(),{{-0.6536436080932617,3.0,-0.9576594829559326},{3.0,0.5403022766113281,3.0}},8e-12),'cos out values 627')
end
do -- cos outwhere 628
 local a=np.array({{-1,-7,1},{4,-3,2}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 628')
 assert(o.dtype=='float32','cos out dtype 628')
 assert(veq(o:tolist(),{{0.5403022766113281,3.0,0.5403022766113281},{3.0,-0.9899924993515015,3.0}},8e-12),'cos out values 628')
end
do -- cos outwhere 629
 local a=np.array({{1,1,2},{64,3,4}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 629')
 assert(o.dtype=='float64','cos out dtype 629')
 assert(veq(o:tolist(),{{0.5403023058681398,3.0,-0.4161468365471424},{3.0,-0.9899924966004454,3.0}},8e-12),'cos out values 629')
end
do -- cos outwhere 630
 local a=np.array({{3,2,-16},{3,1,-1}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 630')
 assert(o.dtype=='float16','cos out dtype 630')
 assert(veq(o:tolist(),{{-0.990234375,3.0,-0.95751953125},{3.0,0.54052734375,3.0}},2e-3),'cos out values 630')
end
do -- cos outwhere 631
 local a=np.array({{0.5,6.0,-6.0},{-6.0,6.0,6.0}},np.float16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'cos out identity 631')
 assert(o.dtype=='float32','cos out dtype 631')
 assert(veq(o:tolist(),{{0.87744140625,3.0,0.9599609375},{3.0,0.9599609375,3.0}},2e-3),'cos out values 631')
end
do -- tan outwhere 632
 local a=np.array({{16,4,31},{31,4,4}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 632')
 assert(o.dtype=='float64','tan out dtype 632')
 assert(veq(o:tolist(),{{0.3006322383880615,3.0,-0.44169557094573975},{3.0,1.1578211784362793,3.0}},2e-5),'tan out values 632')
end
do -- tan outwhere 633
 local a=np.array({{-3,-3,2},{16,1,-7}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 633')
 assert(o.dtype=='float32','tan out dtype 633')
 assert(veq(o:tolist(),{{0.14254654943943024,3.0,-2.185039758682251},{3.0,1.5574077367782593,3.0}},8e-12),'tan out values 633')
end
do -- tan outwhere 634
 local a=np.array({{-7,1,3},{-16,-1,2}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 634')
 assert(o.dtype=='float32','tan out dtype 634')
 assert(veq(o:tolist(),{{-0.8714479804039001,3.0,-0.14254654943943024},{3.0,-1.5574077367782593,3.0}},8e-12),'tan out values 634')
end
do -- tan outwhere 635
 local a=np.array({{0.5,-0.0,-1.5},{-6.0,-6.0,1.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 635')
 assert(o.dtype=='float16','tan out dtype 635')
 assert(veq(o:tolist(),{{0.54638671875,3.0,-14.1015625},{3.0,0.291015625,3.0}},2e-5),'tan out values 635')
end
do -- tan outwhere 636
 local a=np.array({{-7,1,1},{4,2,1}},np.int16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 636')
 assert(o.dtype=='float64','tan out dtype 636')
 assert(veq(o:tolist(),{{-0.8714479804039001,3.0,1.5574077367782593},{3.0,-2.18503999710083,3.0}},2e-5),'tan out values 636')
end
do -- tan outwhere 637
 local a=np.array({{31,4,4},{7,4,3}},np.uint16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 637')
 assert(o.dtype=='float32','tan out dtype 637')
 assert(veq(o:tolist(),{{-0.44169557094573975,3.0,1.1578211784362793},{3.0,1.1578211784362793,3.0}},2e-5),'tan out values 637')
end
do -- tan outwhere 638
 local a=np.array({{0,64,2},{7,7,31}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 638')
 assert(o.dtype=='float16','tan out dtype 638')
 assert(veq(o:tolist(),{{0.0,3.0,-2.185546875},{3.0,0.87158203125,3.0}},8e-12),'tan out values 638')
end
do -- tan outwhere 639
 local a=np.array({{7,7,0},{0,64,0}},np.uint64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 639')
 assert(o.dtype=='float16','tan out dtype 639')
 assert(veq(o:tolist(),{{0.87158203125,3.0,0.0},{3.0,2.34765625,3.0}},8e-12),'tan out values 639')
end
do -- tan outwhere 640
 local a=np.array({{3,64,3},{4,3,7}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 640')
 assert(o.dtype=='float64','tan out dtype 640')
 assert(veq(o:tolist(),{{-0.1425465430742778,3.0,-0.1425465430742778},{3.0,-0.1425465430742778,3.0}},8e-12),'tan out values 640')
end
do -- tan outwhere 641
 local a=np.array({{9,16,2},{1,16,-16}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 641')
 assert(o.dtype=='float64','tan out dtype 641')
 assert(veq(o:tolist(),{{-0.45231565944180985,3.0,-2.185039863261519},{3.0,0.3006322420239034,3.0}},8e-12),'tan out values 641')
end
do -- tan outwhere 642
 local a=np.array({{-6.0,-6.0,-6.0},{1.570796251296997,-3.141592502593994,-1.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 642')
 assert(o.dtype=='float64','tan out dtype 642')
 assert(veq(o:tolist(),{{0.2910062074661255,3.0,0.2910062074661255},{3.0,1.5099580252808664e-07,3.0}},2e-5),'tan out values 642')
end
do -- tan outwhere 643
 local a=np.array({{6.0,0.0,3.140625},{-1.5,1.0,-1.0}},np.float16)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 643')
 assert(o.dtype=='float64','tan out dtype 643')
 assert(veq(o:tolist(),{{-0.291015625,3.0,-0.0009675025939941406},{3.0,1.5576171875,3.0}},2e-3),'tan out values 643')
end
do -- tan outwhere 644
 local a=np.array({{31,3,64},{0,7,3}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 644')
 assert(o.dtype=='float64','tan out dtype 644')
 assert(veq(o:tolist(),{{-0.441695568020698,3.0,2.3478603091954366},{3.0,0.8714479827243188,3.0}},8e-12),'tan out values 644')
end
do -- tan outwhere 645
 local a=np.array({{1,4,2},{4,0,4}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 645')
 assert(o.dtype=='float32','tan out dtype 645')
 assert(veq(o:tolist(),{{1.5574077367782593,3.0,-2.185039758682251},{3.0,0.0,3.0}},8e-12),'tan out values 645')
end
do -- tan outwhere 646
 local a=np.array({{-0.0,0.0,-3.141592502593994},{-1.0,1.570796251296997,-0.0}},np.float32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 646')
 assert(o.dtype=='float16','tan out dtype 646')
 assert(veq(o:tolist(),{{-0.0,3.0,1.7881393432617188e-07},{3.0,math.huge,3.0}},2e-5),'tan out values 646')
end
do -- tan outwhere 647
 local a=np.array({{-1,-3,4},{-3,4,-16}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 647')
 assert(o.dtype=='float32','tan out dtype 647')
 assert(veq(o:tolist(),{{-1.5576171875,3.0,1.158203125},{3.0,1.158203125,3.0}},2e-3),'tan out values 647')
end
do -- tan outwhere 648
 local a=np.array({{2,7,2},{0,31,1}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 648')
 assert(o.dtype=='float32','tan out dtype 648')
 assert(veq(o:tolist(),{{-2.185546875,3.0,-2.185546875},{3.0,-0.441650390625,3.0}},2e-3),'tan out values 648')
end
do -- tan outwhere 649
 local a=np.array({{2,3,2},{-3,-3,-7}},np.int8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 649')
 assert(o.dtype=='float64','tan out dtype 649')
 assert(veq(o:tolist(),{{-2.185546875,3.0,-2.185546875},{3.0,0.142578125,3.0}},2e-3),'tan out values 649')
end
do -- tan outwhere 650
 local a=np.array({{16,2,0},{2,16,0}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float32)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 650')
 assert(o.dtype=='float32','tan out dtype 650')
 assert(veq(o:tolist(),{{0.300537109375,3.0,0.0},{3.0,0.300537109375,3.0}},2e-3),'tan out values 650')
end
do -- tan outwhere 651
 local a=np.array({{-1.0,6.0,1.0},{1.5707963,-0.0,0.0}},np.float64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 651')
 assert(o.dtype=='float64','tan out dtype 651')
 assert(veq(o:tolist(),{{-1.5574077246549023,3.0,1.5574077246549023},{3.0,-0.0,3.0}},8e-12),'tan out values 651')
end
do -- tan outwhere 652
 local a=np.array({{true,true,true},{true,false,true}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 652')
 assert(o.dtype=='float64','tan out dtype 652')
 assert(veq(o:tolist(),{{1.5576171875,3.0,1.5576171875},{3.0,0.0,3.0}},2e-3),'tan out values 652')
end
do -- tan outwhere 653
 local a=np.array({{4,16,-16},{4,-3,16}},np.int64)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 653')
 assert(o.dtype=='float16','tan out dtype 653')
 assert(veq(o:tolist(),{{1.158203125,3.0,-0.300537109375},{3.0,0.142578125,3.0}},8e-12),'tan out values 653')
end
do -- tan outwhere 654
 local a=np.array({{2,31,1},{2,3,31}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 654')
 assert(o.dtype=='float16','tan out dtype 654')
 assert(veq(o:tolist(),{{-2.185546875,3.0,1.5576171875},{3.0,-0.142578125,3.0}},2e-3),'tan out values 654')
end
do -- tan outwhere 655
 local a=np.array({{-3,9,4},{-7,16,4}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 655')
 assert(o.dtype=='float64','tan out dtype 655')
 assert(veq(o:tolist(),{{0.1425465430742778,3.0,1.1578212823495775},{3.0,0.3006322420239034,3.0}},8e-12),'tan out values 655')
end
do -- tan outwhere 656
 local a=np.array({{2,-1,1},{-16,2,4}},np.int32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float64)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 656')
 assert(o.dtype=='float64','tan out dtype 656')
 assert(veq(o:tolist(),{{-2.185039863261519,3.0,1.5574077246549023},{3.0,-2.185039863261519,3.0}},8e-12),'tan out values 656')
end
do -- tan outwhere 657
 local a=np.array({{true,true,false},{true,false,true}},np.bool)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 657')
 assert(o.dtype=='float16','tan out dtype 657')
 assert(veq(o:tolist(),{{1.5576171875,3.0,0.0},{3.0,0.0,3.0}},2e-3),'tan out values 657')
end
do -- tan outwhere 658
 local a=np.array({{0,1,64},{2,3,0}},np.uint32)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 658')
 assert(o.dtype=='float16','tan out dtype 658')
 assert(veq(o:tolist(),{{0.0,3.0,2.34765625},{3.0,-0.142578125,3.0}},8e-12),'tan out values 658')
end
do -- tan outwhere 659
 local a=np.array({{31,2,7},{64,31,3}},np.uint8)
 local m=np.array({{true,false,true},{false,true,false}},np.bool)
 local o=np.ones({2,3},np.float16)*3
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'tan out identity 659')
 assert(o.dtype=='float16','tan out dtype 659')
 assert(veq(o:tolist(),{{-0.441650390625,3.0,0.87158203125},{3.0,-0.441650390625,3.0}},2e-3),'tan out values 659')
end

do
  local x=np.array({-1.0,-0.0,0.0,4.0,math.huge},np.float64)
  local r=np.sqrt(x)
  assert(r[1]~=r[1] and r[2]==0 and r[3]==0 and r[4]==2 and r[5]==math.huge,'sqrt specials')
end

do
  local x=np.array({-1.0,-0.0,0.0,1.0,math.huge},np.float64)
  local r=np.log(x)
  assert(r[1]~=r[1] and r[2]==-math.huge and r[3]==-math.huge and r[4]==0 and r[5]==math.huge,'log specials')
end

do
  local x=np.array({-0.0,0.0},np.float64)
  local s=np.sin(x)
  assert(s[1]==0 and 1/s[1]==-math.huge and s[2]==0 and 1/s[2]==math.huge,'sin signed zero')
  local t=np.tan(x)
  assert(t[1]==0 and 1/t[1]==-math.huge and t[2]==0 and 1/t[2]==math.huge,'tan signed zero')
end

print('math ufunc differential: 663 cases ok')
