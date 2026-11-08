local np=require('luaray_core')
local function close(a,b,tol)
  tol=tol or 2e-3
  if type(a)~=type(b) then return false end
  if type(a)=='table' then
    if #a~=#b then return false end
    for i=1,#a do if not close(a[i],b[i],tol) then return false end end
    return true
  end
  if type(a)~='number' then return a==b end
  if a~=a and b~=b then return true end
  if a==b then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return false end
  return math.abs(a-b)<=tol*math.max(1,math.abs(a),math.abs(b))
end
local function eq(a,b)
  if type(a)~=type(b) then return false end
  if type(a)=='table' then if #a~=#b then return false end; for i=1,#a do if not eq(a[i],b[i]) then return false end end; return true end
  if type(a)=='number' and a~=a and b~=b then return true end
  return a==b
end
-- Generated against development NumPy 2.3.5.
do -- half construction
 local a=np.array({-math.huge,-65504.0,-1024.25,-1.0009765625,-1.0,-6.103515625e-05,-5.960464477539063e-08,-0.0,0.0,5.960464477539063e-08,6.103515625e-05,1.0,1.0009765625,1024.25,65504.0,math.huge,(0/0)},np.float16)
 assert(a.dtype=='float16' and a.strides[1]==2,'half dtype/layout')
 assert(close(a:tolist(),{-math.huge,-65504.0,-1024.0,-1.0009765625,-1.0,-6.103515625e-05,-5.960464477539063e-08,-0.0,0.0,5.960464477539063e-08,6.103515625e-05,1.0,1.0009765625,1024.0,65504.0,math.huge,(0/0)},0),'half construction values')
end
do -- cast bool->half 1
 local a=np.array({false,true,true,false},np.bool)
 local h=np.array(a:tolist(),np.float16)
 assert(close(h:tolist(),{0.0,1.0,1.0,0.0},0),'cast half 1')
end
do -- cast int8->half 2
 local a=np.array({-17,-3,0,17},np.int8)
 local h=np.array(a:tolist(),np.float16)
 assert(close(h:tolist(),{-17.0,-3.0,0.0,17.0},0),'cast half 2')
end
do -- cast uint8->half 3
 local a=np.array({0,1,3,17},np.uint8)
 local h=np.array(a:tolist(),np.float16)
 assert(close(h:tolist(),{0.0,1.0,3.0,17.0},0),'cast half 3')
end
do -- cast int16->half 4
 local a=np.array({-17,-3,0,17},np.int16)
 local h=np.array(a:tolist(),np.float16)
 assert(close(h:tolist(),{-17.0,-3.0,0.0,17.0},0),'cast half 4')
end
do -- cast uint16->half 5
 local a=np.array({0,1,3,17},np.uint16)
 local h=np.array(a:tolist(),np.float16)
 assert(close(h:tolist(),{0.0,1.0,3.0,17.0},0),'cast half 5')
end
do -- cast int32->half 6
 local a=np.array({-17,-3,0,17},np.int32)
 local h=np.array(a:tolist(),np.float16)
 assert(close(h:tolist(),{-17.0,-3.0,0.0,17.0},0),'cast half 6')
end
do -- cast float32->half 7
 local a=np.array({-3.25,-0.0,0.125,1.0010000467300415,17.5},np.float32)
 local h=np.array(a:tolist(),np.float16)
 assert(close(h:tolist(),{-3.25,-0.0,0.125,1.0009765625,17.5},0),'cast half 7')
end
do -- cast float64->half 8
 local a=np.array({-3.25,-0.0,0.125,1.001,17.5},np.float64)
 local h=np.array(a:tolist(),np.float16)
 assert(close(h:tolist(),{-3.25,-0.0,0.125,1.0009765625,17.5},0),'cast half 8')
end
do -- half add 9
 local a=np.array({-3.0,0.0,0.5,0.0,2.0,-0.0},np.float16)
 local b=np.array({2,2,4,1,4,2},np.uint8)
 local r=np.add(a,b)
 assert(r.dtype=='float16','half add dtype 9 '..r.dtype)
 assert(close(r:tolist(),{-1.0,2.0,4.5,1.0,6.0,2.0},2e-3),'half add values 9')
end
do -- half add 10
 local a=np.array({0.0,2.0,0.0,2.0,0.0,4.0},np.float16)
 local b=np.array({1,-1,0,-3,0,0},np.int8)
 local r=np.add(a,b)
 assert(r.dtype=='float16','half add dtype 10 '..r.dtype)
 assert(close(r:tolist(),{1.0,1.0,0.0,-1.0,0.0,4.0},2e-3),'half add values 10')
end
do -- half add 11
 local a=np.array({-3.0,2.0,0.0,1.0,0.0,0.5},np.float16)
 local b=np.array({false,true,true,true,true,true},np.bool)
 local r=np.add(a,b)
 assert(r.dtype=='float16','half add dtype 11 '..r.dtype)
 assert(close(r:tolist(),{-3.0,3.0,1.0,2.0,1.0,1.5},2e-3),'half add values 11')
end
do -- half add 12
 local a=np.array({4.0,-3.0,-1.0,-0.0,-3.0,0.0},np.float16)
 local b=np.array({0,-3,0,-3,3,0},np.int8)
 local r=np.add(a,b)
 assert(r.dtype=='float16','half add dtype 12 '..r.dtype)
 assert(close(r:tolist(),{4.0,-6.0,-1.0,-3.0,0.0,0.0},2e-3),'half add values 12')
end
do -- half add 13
 local a=np.array({-3.0,-0.0,0.5,0.5,-0.0,4.0},np.float16)
 local b=np.array({1,1,-3,1,1,0},np.int8)
 local r=np.add(a,b)
 assert(r.dtype=='float16','half add dtype 13 '..r.dtype)
 assert(close(r:tolist(),{-2.0,1.0,-2.5,1.5,1.0,4.0},2e-3),'half add values 13')
end
do -- half add 14
 local a=np.array({0.0,4.0,-1.0,-3.0,-1.0,-0.0},np.float16)
 local b=np.array({0,1,2,1,1,0},np.uint8)
 local r=np.add(a,b)
 assert(r.dtype=='float16','half add dtype 14 '..r.dtype)
 assert(close(r:tolist(),{0.0,5.0,1.0,-2.0,0.0,0.0},2e-3),'half add values 14')
end
do -- half add 15
 local a=np.array({0.5,-3.0,-3.0,2.0,4.0,-3.0},np.float16)
 local b=np.array({0.0,3.0,-3.0,0.0,-1.0,-3.0},np.float64)
 local r=np.add(a,b)
 assert(r.dtype=='float64','half add dtype 15 '..r.dtype)
 assert(close(r:tolist(),{0.5,0.0,-6.0,2.0,3.0,-6.0},2e-3),'half add values 15')
end
do -- half add 16
 local a=np.array({0.0,-1.0,0.0,-3.0,4.0,1.0},np.float16)
 local b=np.array({3,0,-3,0,0,0},np.int16)
 local r=np.add(a,b)
 assert(r.dtype=='float32','half add dtype 16 '..r.dtype)
 assert(close(r:tolist(),{3.0,-1.0,-3.0,-3.0,4.0,1.0},2e-3),'half add values 16')
end
do -- half add 17
 local a=np.array({-1.0,-0.0,1.0,-1.0,-0.0,-3.0},np.float16)
 local b=np.array({false,false,true,false,true,false},np.bool)
 local r=np.add(a,b)
 assert(r.dtype=='float16','half add dtype 17 '..r.dtype)
 assert(close(r:tolist(),{-1.0,0.0,2.0,-1.0,1.0,-3.0},2e-3),'half add values 17')
end
do -- half add 18
 local a=np.array({4.0,2.0,4.0,-0.0,0.5,-0.0},np.float16)
 local b=np.array({1.0,2.0,-3.0,0.0,-1.0,-3.0},np.float16)
 local r=np.add(a,b)
 assert(r.dtype=='float16','half add dtype 18 '..r.dtype)
 assert(close(r:tolist(),{5.0,4.0,1.0,0.0,-0.5,-3.0},2e-3),'half add values 18')
end
do -- half add 19
 local a=np.array({-0.0,2.0,0.5,-0.0,0.0,-0.0},np.float16)
 local b=np.array({3,2,1,2,2,-3},np.int16)
 local r=np.add(a,b)
 assert(r.dtype=='float32','half add dtype 19 '..r.dtype)
 assert(close(r:tolist(),{3.0,4.0,1.5,2.0,2.0,-3.0},2e-3),'half add values 19')
end
do -- half add 20
 local a=np.array({2.0,2.0,0.0,-3.0,0.0,0.0},np.float16)
 local b=np.array({1,3,-1,0,0,2},np.int16)
 local r=np.add(a,b)
 assert(r.dtype=='float32','half add dtype 20 '..r.dtype)
 assert(close(r:tolist(),{3.0,5.0,-1.0,-3.0,0.0,2.0},2e-3),'half add values 20')
end
do -- half add 21
 local a=np.array({2.0,4.0,-3.0,0.0,-0.0,1.0},np.float16)
 local b=np.array({2,3,1,2,4,1},np.uint16)
 local r=np.add(a,b)
 assert(r.dtype=='float32','half add dtype 21 '..r.dtype)
 assert(close(r:tolist(),{4.0,7.0,-2.0,2.0,4.0,2.0},2e-3),'half add values 21')
end
do -- half add 22
 local a=np.array({-3.0,2.0,2.0,1.0,-3.0,1.0},np.float16)
 local b=np.array({0,2,1,0,2,4},np.uint8)
 local r=np.add(a,b)
 assert(r.dtype=='float16','half add dtype 22 '..r.dtype)
 assert(close(r:tolist(),{-3.0,4.0,3.0,1.0,-1.0,5.0},2e-3),'half add values 22')
end
do -- half add 23
 local a=np.array({-0.0,-3.0,1.0,-3.0,4.0,2.0},np.float16)
 local b=np.array({1,4,1,2,3,0},np.uint16)
 local r=np.add(a,b)
 assert(r.dtype=='float32','half add dtype 23 '..r.dtype)
 assert(close(r:tolist(),{1.0,1.0,2.0,-1.0,7.0,2.0},2e-3),'half add values 23')
end
do -- half add 24
 local a=np.array({0.0,-0.0,0.5,2.0,4.0,1.0},np.float16)
 local b=np.array({3,4,0,4,3,4},np.uint16)
 local r=np.add(a,b)
 assert(r.dtype=='float32','half add dtype 24 '..r.dtype)
 assert(close(r:tolist(),{3.0,4.0,0.5,6.0,7.0,5.0},2e-3),'half add values 24')
end
do -- half add 25
 local a=np.array({2.0,-3.0,1.0,4.0,1.0,-1.0},np.float16)
 local b=np.array({0,-1,2,-1,3,0},np.int8)
 local r=np.add(a,b)
 assert(r.dtype=='float16','half add dtype 25 '..r.dtype)
 assert(close(r:tolist(),{2.0,-4.0,3.0,3.0,4.0,-1.0},2e-3),'half add values 25')
end
do -- half add 26
 local a=np.array({-3.0,-1.0,1.0,-1.0,-3.0,-3.0},np.float16)
 local b=np.array({1,4,0,4,1,4},np.uint16)
 local r=np.add(a,b)
 assert(r.dtype=='float32','half add dtype 26 '..r.dtype)
 assert(close(r:tolist(),{-2.0,3.0,1.0,3.0,-2.0,1.0},2e-3),'half add values 26')
end
do -- half add 27
 local a=np.array({4.0,-0.0,0.0,0.5,-0.0,-0.0},np.float16)
 local b=np.array({2,4,1,0,2,1},np.uint8)
 local r=np.add(a,b)
 assert(r.dtype=='float16','half add dtype 27 '..r.dtype)
 assert(close(r:tolist(),{6.0,4.0,1.0,0.5,2.0,1.0},2e-3),'half add values 27')
end
do -- half add 28
 local a=np.array({0.0,2.0,-3.0,-3.0,-1.0,0.5},np.float16)
 local b=np.array({0.0,-3.0,2.0,0.5,3.0,-1.0},np.float32)
 local r=np.add(a,b)
 assert(r.dtype=='float32','half add dtype 28 '..r.dtype)
 assert(close(r:tolist(),{0.0,-1.0,-1.0,-2.5,2.0,-0.5},2e-3),'half add values 28')
end
do -- half add 29
 local a=np.array({-3.0,2.0,-0.0,0.5,0.0,-1.0},np.float16)
 local b=np.array({-3.0,0.0,3.0,-3.0,-1.0,-3.0},np.float32)
 local r=np.add(a,b)
 assert(r.dtype=='float32','half add dtype 29 '..r.dtype)
 assert(close(r:tolist(),{-6.0,2.0,3.0,-2.5,-1.0,-4.0},2e-3),'half add values 29')
end
do -- half add 30
 local a=np.array({-0.0,1.0,-1.0,-3.0,0.5,0.0},np.float16)
 local b=np.array({2,4,4,1,0,0},np.uint16)
 local r=np.add(a,b)
 assert(r.dtype=='float32','half add dtype 30 '..r.dtype)
 assert(close(r:tolist(),{2.0,5.0,3.0,-2.0,0.5,0.0},2e-3),'half add values 30')
end
do -- half add 31
 local a=np.array({0.5,-3.0,-0.0,4.0,0.5,2.0},np.float16)
 local b=np.array({true,false,true,true,false,true},np.bool)
 local r=np.add(a,b)
 assert(r.dtype=='float16','half add dtype 31 '..r.dtype)
 assert(close(r:tolist(),{1.5,-3.0,1.0,5.0,0.5,3.0},2e-3),'half add values 31')
end
do -- half add 32
 local a=np.array({0.5,4.0,1.0,-1.0,0.0,-0.0},np.float16)
 local b=np.array({3,2,1,4,1,2},np.uint8)
 local r=np.add(a,b)
 assert(r.dtype=='float16','half add dtype 32 '..r.dtype)
 assert(close(r:tolist(),{3.5,6.0,2.0,3.0,1.0,2.0},2e-3),'half add values 32')
end
do -- half add 33
 local a=np.array({2.0,-1.0,0.5,-1.0,-3.0,-0.0},np.float16)
 local b=np.array({true,false,true,false,false,true},np.bool)
 local r=np.add(a,b)
 assert(r.dtype=='float16','half add dtype 33 '..r.dtype)
 assert(close(r:tolist(),{3.0,-1.0,1.5,-1.0,-3.0,1.0},2e-3),'half add values 33')
end
do -- half subtract 34
 local a=np.array({0.5,4.0,-3.0,-3.0,2.0,0.0},np.float16)
 local b=np.array({0.5,0.5,-1.0,0.5,-1.0,0.5},np.float16)
 local r=np.subtract(a,b)
 assert(r.dtype=='float16','half subtract dtype 34 '..r.dtype)
 assert(close(r:tolist(),{0.0,3.5,-2.0,-3.5,3.0,-0.5},2e-3),'half subtract values 34')
end
do -- half subtract 35
 local a=np.array({0.0,1.0,4.0,-1.0,0.0,0.5},np.float16)
 local b=np.array({0.5,2.0,0.5,2.0,0.5,-1.0},np.float64)
 local r=np.subtract(a,b)
 assert(r.dtype=='float64','half subtract dtype 35 '..r.dtype)
 assert(close(r:tolist(),{-0.5,-1.0,3.5,-3.0,-0.5,1.5},2e-3),'half subtract values 35')
end
do -- half subtract 36
 local a=np.array({1.0,-3.0,0.0,0.0,0.5,-1.0},np.float16)
 local b=np.array({0.5,3.0,0.0,0.5,-1.0,2.0},np.float32)
 local r=np.subtract(a,b)
 assert(r.dtype=='float32','half subtract dtype 36 '..r.dtype)
 assert(close(r:tolist(),{0.5,-6.0,0.0,-0.5,1.5,-3.0},2e-3),'half subtract values 36')
end
do -- half subtract 37
 local a=np.array({2.0,0.5,-3.0,-1.0,4.0,1.0},np.float16)
 local b=np.array({false,false,false,false,true,true},np.bool)
 local r=np.subtract(a,b)
 assert(r.dtype=='float16','half subtract dtype 37 '..r.dtype)
 assert(close(r:tolist(),{2.0,0.5,-3.0,-1.0,3.0,0.0},2e-3),'half subtract values 37')
end
do -- half subtract 38
 local a=np.array({0.5,0.0,-1.0,-3.0,0.0,4.0},np.float16)
 local b=np.array({-3,-3,0,0,-3,-1},np.int16)
 local r=np.subtract(a,b)
 assert(r.dtype=='float32','half subtract dtype 38 '..r.dtype)
 assert(close(r:tolist(),{3.5,3.0,-1.0,-3.0,3.0,5.0},2e-3),'half subtract values 38')
end
do -- half subtract 39
 local a=np.array({-3.0,0.0,-3.0,-0.0,-1.0,0.0},np.float16)
 local b=np.array({-3.0,1.0,0.5,-1.0,3.0,1.0},np.float16)
 local r=np.subtract(a,b)
 assert(r.dtype=='float16','half subtract dtype 39 '..r.dtype)
 assert(close(r:tolist(),{0.0,-1.0,-3.5,1.0,-4.0,-1.0},2e-3),'half subtract values 39')
end
do -- half subtract 40
 local a=np.array({0.5,4.0,0.0,-3.0,4.0,0.0},np.float16)
 local b=np.array({-1,-3,3,1,2,-1},np.int16)
 local r=np.subtract(a,b)
 assert(r.dtype=='float32','half subtract dtype 40 '..r.dtype)
 assert(close(r:tolist(),{1.5,7.0,-3.0,-4.0,2.0,1.0},2e-3),'half subtract values 40')
end
do -- half subtract 41
 local a=np.array({4.0,0.0,4.0,2.0,0.0,4.0},np.float16)
 local b=np.array({3,2,1,0,2,3},np.uint8)
 local r=np.subtract(a,b)
 assert(r.dtype=='float16','half subtract dtype 41 '..r.dtype)
 assert(close(r:tolist(),{1.0,-2.0,3.0,2.0,-2.0,1.0},2e-3),'half subtract values 41')
end
do -- half subtract 42
 local a=np.array({2.0,0.0,-0.0,2.0,-0.0,0.0},np.float16)
 local b=np.array({1,-1,-1,2,0,-3},np.int8)
 local r=np.subtract(a,b)
 assert(r.dtype=='float16','half subtract dtype 42 '..r.dtype)
 assert(close(r:tolist(),{1.0,1.0,1.0,0.0,-0.0,3.0},2e-3),'half subtract values 42')
end
do -- half subtract 43
 local a=np.array({-0.0,2.0,2.0,0.0,-1.0,-1.0},np.float16)
 local b=np.array({1.0,3.0,-1.0,1.0,0.5,0.0},np.float16)
 local r=np.subtract(a,b)
 assert(r.dtype=='float16','half subtract dtype 43 '..r.dtype)
 assert(close(r:tolist(),{-1.0,-1.0,3.0,-1.0,-1.5,-1.0},2e-3),'half subtract values 43')
end
do -- half subtract 44
 local a=np.array({1.0,2.0,-3.0,4.0,-1.0,-1.0},np.float16)
 local b=np.array({2.0,-3.0,0.0,-3.0,1.0,2.0},np.float64)
 local r=np.subtract(a,b)
 assert(r.dtype=='float64','half subtract dtype 44 '..r.dtype)
 assert(close(r:tolist(),{-1.0,5.0,-3.0,7.0,-2.0,-3.0},2e-3),'half subtract values 44')
end
do -- half subtract 45
 local a=np.array({1.0,4.0,2.0,2.0,4.0,1.0},np.float16)
 local b=np.array({2.0,2.0,0.0,0.5,3.0,1.0},np.float16)
 local r=np.subtract(a,b)
 assert(r.dtype=='float16','half subtract dtype 45 '..r.dtype)
 assert(close(r:tolist(),{-1.0,2.0,2.0,1.5,1.0,0.0},2e-3),'half subtract values 45')
end
do -- half subtract 46
 local a=np.array({0.0,4.0,-1.0,-1.0,-0.0,-0.0},np.float16)
 local b=np.array({1,0,0,-3,0,2},np.int16)
 local r=np.subtract(a,b)
 assert(r.dtype=='float32','half subtract dtype 46 '..r.dtype)
 assert(close(r:tolist(),{-1.0,4.0,-1.0,2.0,-0.0,-2.0},2e-3),'half subtract values 46')
end
do -- half subtract 47
 local a=np.array({0.5,-3.0,-0.0,2.0,-1.0,1.0},np.float16)
 local b=np.array({0.5,3.0,0.5,3.0,3.0,1.0},np.float16)
 local r=np.subtract(a,b)
 assert(r.dtype=='float16','half subtract dtype 47 '..r.dtype)
 assert(close(r:tolist(),{0.0,-6.0,-0.5,-1.0,-4.0,0.0},2e-3),'half subtract values 47')
end
do -- half subtract 48
 local a=np.array({-1.0,-3.0,2.0,0.5,-1.0,-3.0},np.float16)
 local b=np.array({3.0,3.0,3.0,2.0,0.0,3.0},np.float32)
 local r=np.subtract(a,b)
 assert(r.dtype=='float32','half subtract dtype 48 '..r.dtype)
 assert(close(r:tolist(),{-4.0,-6.0,-1.0,-1.5,-1.0,-6.0},2e-3),'half subtract values 48')
end
do -- half subtract 49
 local a=np.array({0.5,-1.0,-1.0,4.0,4.0,-3.0},np.float16)
 local b=np.array({0.0,1.0,1.0,0.5,0.0,1.0},np.float64)
 local r=np.subtract(a,b)
 assert(r.dtype=='float64','half subtract dtype 49 '..r.dtype)
 assert(close(r:tolist(),{0.5,-2.0,-2.0,3.5,4.0,-4.0},2e-3),'half subtract values 49')
end
do -- half subtract 50
 local a=np.array({0.5,0.5,-3.0,1.0,2.0,-1.0},np.float16)
 local b=np.array({0,3,4,2,4,0},np.uint8)
 local r=np.subtract(a,b)
 assert(r.dtype=='float16','half subtract dtype 50 '..r.dtype)
 assert(close(r:tolist(),{0.5,-2.5,-7.0,-1.0,-2.0,-1.0},2e-3),'half subtract values 50')
end
do -- half subtract 51
 local a=np.array({0.0,0.0,2.0,2.0,0.0,2.0},np.float16)
 local b=np.array({-1,2,-1,2,-1,1},np.int8)
 local r=np.subtract(a,b)
 assert(r.dtype=='float16','half subtract dtype 51 '..r.dtype)
 assert(close(r:tolist(),{1.0,-2.0,3.0,0.0,1.0,1.0},2e-3),'half subtract values 51')
end
do -- half subtract 52
 local a=np.array({-0.0,0.5,0.0,0.5,-3.0,-0.0},np.float16)
 local b=np.array({4,4,1,1,4,3},np.uint8)
 local r=np.subtract(a,b)
 assert(r.dtype=='float16','half subtract dtype 52 '..r.dtype)
 assert(close(r:tolist(),{-4.0,-3.5,-1.0,-0.5,-7.0,-3.0},2e-3),'half subtract values 52')
end
do -- half subtract 53
 local a=np.array({-1.0,-1.0,-3.0,-1.0,-1.0,0.0},np.float16)
 local b=np.array({false,false,false,true,true,false},np.bool)
 local r=np.subtract(a,b)
 assert(r.dtype=='float16','half subtract dtype 53 '..r.dtype)
 assert(close(r:tolist(),{-1.0,-1.0,-3.0,-2.0,-2.0,0.0},2e-3),'half subtract values 53')
end
do -- half subtract 54
 local a=np.array({1.0,0.5,-1.0,1.0,1.0,4.0},np.float16)
 local b=np.array({true,false,true,true,false,false},np.bool)
 local r=np.subtract(a,b)
 assert(r.dtype=='float16','half subtract dtype 54 '..r.dtype)
 assert(close(r:tolist(),{0.0,0.5,-2.0,0.0,1.0,4.0},2e-3),'half subtract values 54')
end
do -- half subtract 55
 local a=np.array({-1.0,0.5,2.0,-0.0,0.5,0.5},np.float16)
 local b=np.array({2,4,4,2,1,4},np.uint16)
 local r=np.subtract(a,b)
 assert(r.dtype=='float32','half subtract dtype 55 '..r.dtype)
 assert(close(r:tolist(),{-3.0,-3.5,-2.0,-2.0,-0.5,-3.5},2e-3),'half subtract values 55')
end
do -- half subtract 56
 local a=np.array({2.0,0.0,2.0,-0.0,-0.0,-0.0},np.float16)
 local b=np.array({true,true,false,false,true,true},np.bool)
 local r=np.subtract(a,b)
 assert(r.dtype=='float16','half subtract dtype 56 '..r.dtype)
 assert(close(r:tolist(),{1.0,-1.0,2.0,-0.0,-1.0,-1.0},2e-3),'half subtract values 56')
end
do -- half subtract 57
 local a=np.array({-0.0,4.0,-1.0,0.0,0.5,1.0},np.float16)
 local b=np.array({0,4,4,4,4,1},np.uint8)
 local r=np.subtract(a,b)
 assert(r.dtype=='float16','half subtract dtype 57 '..r.dtype)
 assert(close(r:tolist(),{-0.0,0.0,-5.0,-4.0,-3.5,0.0},2e-3),'half subtract values 57')
end
do -- half subtract 58
 local a=np.array({0.5,-1.0,-1.0,2.0,-0.0,-1.0},np.float16)
 local b=np.array({-3.0,-1.0,0.0,-1.0,0.0,-1.0},np.float16)
 local r=np.subtract(a,b)
 assert(r.dtype=='float16','half subtract dtype 58 '..r.dtype)
 assert(close(r:tolist(),{3.5,0.0,-1.0,3.0,-0.0,0.0},2e-3),'half subtract values 58')
end
do -- half multiply 59
 local a=np.array({1.0,4.0,0.0,1.0,4.0,4.0},np.float16)
 local b=np.array({-1.0,-3.0,1.0,3.0,0.5,2.0},np.float64)
 local r=np.multiply(a,b)
 assert(r.dtype=='float64','half multiply dtype 59 '..r.dtype)
 assert(close(r:tolist(),{-1.0,-12.0,0.0,3.0,2.0,8.0},2e-3),'half multiply values 59')
end
do -- half multiply 60
 local a=np.array({0.0,1.0,4.0,1.0,0.0,-3.0},np.float16)
 local b=np.array({2,2,0,3,2,1},np.uint8)
 local r=np.multiply(a,b)
 assert(r.dtype=='float16','half multiply dtype 60 '..r.dtype)
 assert(close(r:tolist(),{0.0,2.0,0.0,3.0,0.0,-3.0},2e-3),'half multiply values 60')
end
do -- half multiply 61
 local a=np.array({0.0,4.0,-1.0,4.0,0.0,2.0},np.float16)
 local b=np.array({-3.0,2.0,-1.0,-1.0,-3.0,3.0},np.float32)
 local r=np.multiply(a,b)
 assert(r.dtype=='float32','half multiply dtype 61 '..r.dtype)
 assert(close(r:tolist(),{-0.0,8.0,1.0,-4.0,-0.0,6.0},2e-3),'half multiply values 61')
end
do -- half multiply 62
 local a=np.array({-0.0,4.0,2.0,0.0,-0.0,-0.0},np.float16)
 local b=np.array({0,2,1,2,1,3},np.uint8)
 local r=np.multiply(a,b)
 assert(r.dtype=='float16','half multiply dtype 62 '..r.dtype)
 assert(close(r:tolist(),{-0.0,8.0,2.0,0.0,-0.0,-0.0},2e-3),'half multiply values 62')
end
do -- half multiply 63
 local a=np.array({1.0,4.0,1.0,2.0,1.0,2.0},np.float16)
 local b=np.array({-1.0,3.0,0.5,-3.0,-1.0,2.0},np.float32)
 local r=np.multiply(a,b)
 assert(r.dtype=='float32','half multiply dtype 63 '..r.dtype)
 assert(close(r:tolist(),{-1.0,12.0,0.5,-6.0,-1.0,4.0},2e-3),'half multiply values 63')
end
do -- half multiply 64
 local a=np.array({4.0,-1.0,0.5,2.0,2.0,4.0},np.float16)
 local b=np.array({0.5,2.0,0.0,0.5,0.0,0.5},np.float16)
 local r=np.multiply(a,b)
 assert(r.dtype=='float16','half multiply dtype 64 '..r.dtype)
 assert(close(r:tolist(),{2.0,-2.0,0.0,1.0,0.0,2.0},2e-3),'half multiply values 64')
end
do -- half multiply 65
 local a=np.array({-1.0,0.0,0.0,4.0,4.0,-1.0},np.float16)
 local b=np.array({3,0,3,0,-3,3},np.int8)
 local r=np.multiply(a,b)
 assert(r.dtype=='float16','half multiply dtype 65 '..r.dtype)
 assert(close(r:tolist(),{-3.0,0.0,0.0,0.0,-12.0,-3.0},2e-3),'half multiply values 65')
end
do -- half multiply 66
 local a=np.array({2.0,-0.0,-0.0,0.0,4.0,0.5},np.float16)
 local b=np.array({-3.0,1.0,-1.0,0.0,2.0,1.0},np.float16)
 local r=np.multiply(a,b)
 assert(r.dtype=='float16','half multiply dtype 66 '..r.dtype)
 assert(close(r:tolist(),{-6.0,-0.0,0.0,0.0,8.0,0.5},2e-3),'half multiply values 66')
end
do -- half multiply 67
 local a=np.array({2.0,1.0,4.0,0.0,-0.0,1.0},np.float16)
 local b=np.array({-1.0,1.0,-3.0,1.0,-1.0,-1.0},np.float32)
 local r=np.multiply(a,b)
 assert(r.dtype=='float32','half multiply dtype 67 '..r.dtype)
 assert(close(r:tolist(),{-2.0,1.0,-12.0,0.0,0.0,-1.0},2e-3),'half multiply values 67')
end
do -- half multiply 68
 local a=np.array({-3.0,-1.0,-0.0,0.0,2.0,-3.0},np.float16)
 local b=np.array({1.0,-3.0,0.0,0.5,2.0,0.5},np.float16)
 local r=np.multiply(a,b)
 assert(r.dtype=='float16','half multiply dtype 68 '..r.dtype)
 assert(close(r:tolist(),{-3.0,3.0,-0.0,0.0,4.0,-1.5},2e-3),'half multiply values 68')
end
do -- half multiply 69
 local a=np.array({-0.0,-3.0,0.0,0.5,2.0,0.5},np.float16)
 local b=np.array({true,true,false,false,true,false},np.bool)
 local r=np.multiply(a,b)
 assert(r.dtype=='float16','half multiply dtype 69 '..r.dtype)
 assert(close(r:tolist(),{-0.0,-3.0,0.0,0.0,2.0,0.0},2e-3),'half multiply values 69')
end
do -- half multiply 70
 local a=np.array({0.0,-1.0,4.0,-0.0,0.0,-1.0},np.float16)
 local b=np.array({1.0,-1.0,-3.0,3.0,-3.0,0.0},np.float32)
 local r=np.multiply(a,b)
 assert(r.dtype=='float32','half multiply dtype 70 '..r.dtype)
 assert(close(r:tolist(),{0.0,1.0,-12.0,-0.0,-0.0,-0.0},2e-3),'half multiply values 70')
end
do -- half multiply 71
 local a=np.array({-1.0,2.0,0.0,2.0,-1.0,1.0},np.float16)
 local b=np.array({2,0,4,2,4,2},np.uint8)
 local r=np.multiply(a,b)
 assert(r.dtype=='float16','half multiply dtype 71 '..r.dtype)
 assert(close(r:tolist(),{-2.0,0.0,0.0,4.0,-4.0,2.0},2e-3),'half multiply values 71')
end
do -- half multiply 72
 local a=np.array({-3.0,2.0,4.0,-3.0,0.0,0.5},np.float16)
 local b=np.array({2.0,0.5,1.0,-3.0,-3.0,-3.0},np.float64)
 local r=np.multiply(a,b)
 assert(r.dtype=='float64','half multiply dtype 72 '..r.dtype)
 assert(close(r:tolist(),{-6.0,1.0,4.0,9.0,-0.0,-1.5},2e-3),'half multiply values 72')
end
do -- half multiply 73
 local a=np.array({1.0,4.0,-3.0,0.0,2.0,0.0},np.float16)
 local b=np.array({true,false,true,true,false,true},np.bool)
 local r=np.multiply(a,b)
 assert(r.dtype=='float16','half multiply dtype 73 '..r.dtype)
 assert(close(r:tolist(),{1.0,0.0,-3.0,0.0,0.0,0.0},2e-3),'half multiply values 73')
end
do -- half multiply 74
 local a=np.array({-3.0,0.5,4.0,0.5,4.0,4.0},np.float16)
 local b=np.array({1,4,4,1,2,1},np.uint8)
 local r=np.multiply(a,b)
 assert(r.dtype=='float16','half multiply dtype 74 '..r.dtype)
 assert(close(r:tolist(),{-3.0,2.0,16.0,0.5,8.0,4.0},2e-3),'half multiply values 74')
end
do -- half multiply 75
 local a=np.array({0.0,0.0,0.5,-3.0,0.5,-0.0},np.float16)
 local b=np.array({4,1,0,0,2,1},np.uint16)
 local r=np.multiply(a,b)
 assert(r.dtype=='float32','half multiply dtype 75 '..r.dtype)
 assert(close(r:tolist(),{0.0,0.0,0.0,-0.0,1.0,-0.0},2e-3),'half multiply values 75')
end
do -- half multiply 76
 local a=np.array({-1.0,0.0,-1.0,1.0,-1.0,0.0},np.float16)
 local b=np.array({0.5,0.0,0.5,-1.0,3.0,0.5},np.float32)
 local r=np.multiply(a,b)
 assert(r.dtype=='float32','half multiply dtype 76 '..r.dtype)
 assert(close(r:tolist(),{-0.5,0.0,-0.5,-1.0,-3.0,0.0},2e-3),'half multiply values 76')
end
do -- half multiply 77
 local a=np.array({2.0,1.0,2.0,-0.0,-3.0,0.0},np.float16)
 local b=np.array({1,0,1,4,4,1},np.uint8)
 local r=np.multiply(a,b)
 assert(r.dtype=='float16','half multiply dtype 77 '..r.dtype)
 assert(close(r:tolist(),{2.0,0.0,2.0,-0.0,-12.0,0.0},2e-3),'half multiply values 77')
end
do -- half multiply 78
 local a=np.array({0.5,-3.0,1.0,0.0,0.5,0.0},np.float16)
 local b=np.array({1,1,3,4,4,2},np.uint8)
 local r=np.multiply(a,b)
 assert(r.dtype=='float16','half multiply dtype 78 '..r.dtype)
 assert(close(r:tolist(),{0.5,-3.0,3.0,0.0,2.0,0.0},2e-3),'half multiply values 78')
end
do -- half multiply 79
 local a=np.array({-3.0,0.5,-0.0,4.0,2.0,-0.0},np.float16)
 local b=np.array({3,0,0,4,4,4},np.uint8)
 local r=np.multiply(a,b)
 assert(r.dtype=='float16','half multiply dtype 79 '..r.dtype)
 assert(close(r:tolist(),{-9.0,0.0,-0.0,16.0,8.0,-0.0},2e-3),'half multiply values 79')
end
do -- half multiply 80
 local a=np.array({1.0,-3.0,4.0,-1.0,4.0,0.5},np.float16)
 local b=np.array({4,2,4,2,2,0},np.uint16)
 local r=np.multiply(a,b)
 assert(r.dtype=='float32','half multiply dtype 80 '..r.dtype)
 assert(close(r:tolist(),{4.0,-6.0,16.0,-2.0,8.0,0.0},2e-3),'half multiply values 80')
end
do -- half multiply 81
 local a=np.array({-3.0,-0.0,-3.0,1.0,0.0,2.0},np.float16)
 local b=np.array({true,true,true,true,true,true},np.bool)
 local r=np.multiply(a,b)
 assert(r.dtype=='float16','half multiply dtype 81 '..r.dtype)
 assert(close(r:tolist(),{-3.0,-0.0,-3.0,1.0,0.0,2.0},2e-3),'half multiply values 81')
end
do -- half multiply 82
 local a=np.array({-1.0,0.0,2.0,-0.0,2.0,1.0},np.float16)
 local b=np.array({-1,3,2,1,3,1},np.int8)
 local r=np.multiply(a,b)
 assert(r.dtype=='float16','half multiply dtype 82 '..r.dtype)
 assert(close(r:tolist(),{1.0,0.0,4.0,-0.0,6.0,1.0},2e-3),'half multiply values 82')
end
do -- half multiply 83
 local a=np.array({-0.0,1.0,0.5,-1.0,-3.0,2.0},np.float16)
 local b=np.array({4,4,3,3,1,2},np.uint8)
 local r=np.multiply(a,b)
 assert(r.dtype=='float16','half multiply dtype 83 '..r.dtype)
 assert(close(r:tolist(),{-0.0,4.0,1.5,-3.0,-3.0,4.0},2e-3),'half multiply values 83')
end
do -- half true_divide 84
 local a=np.array({0.5,0.0,0.0,-1.0,2.0,2.0},np.float16)
 local b=np.array({2,3,-3,3,2,-1},np.int16)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float32','half true_divide dtype 84 '..r.dtype)
 assert(close(r:tolist(),{0.25,0.0,-0.0,-0.3333333432674408,1.0,-2.0},2e-3),'half true_divide values 84')
end
do -- half true_divide 85
 local a=np.array({0.5,4.0,1.0,2.0,0.0,2.0},np.float16)
 local b=np.array({0,1,1,0,1,-3},np.int8)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float16','half true_divide dtype 85 '..r.dtype)
 assert(close(r:tolist(),{math.huge,4.0,1.0,math.huge,0.0,-0.66650390625},2e-3),'half true_divide values 85')
end
do -- half true_divide 86
 local a=np.array({-3.0,0.5,1.0,-3.0,0.0,2.0},np.float16)
 local b=np.array({3,3,3,4,0,4},np.uint8)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float16','half true_divide dtype 86 '..r.dtype)
 assert(close(r:tolist(),{-1.0,0.1666259765625,0.333251953125,-0.75,(0/0),0.5},2e-3),'half true_divide values 86')
end
do -- half true_divide 87
 local a=np.array({-3.0,2.0,4.0,0.0,1.0,2.0},np.float16)
 local b=np.array({0.0,-1.0,2.0,-3.0,0.5,0.5},np.float32)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float32','half true_divide dtype 87 '..r.dtype)
 assert(close(r:tolist(),{-math.huge,-2.0,2.0,-0.0,2.0,4.0},2e-3),'half true_divide values 87')
end
do -- half true_divide 88
 local a=np.array({-3.0,-0.0,-0.0,0.5,-3.0,2.0},np.float16)
 local b=np.array({3.0,1.0,-3.0,1.0,0.5,2.0},np.float32)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float32','half true_divide dtype 88 '..r.dtype)
 assert(close(r:tolist(),{-1.0,-0.0,0.0,0.5,-6.0,1.0},2e-3),'half true_divide values 88')
end
do -- half true_divide 89
 local a=np.array({2.0,-3.0,-1.0,0.5,-0.0,4.0},np.float16)
 local b=np.array({0.0,0.5,-3.0,0.0,0.5,0.5},np.float32)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float32','half true_divide dtype 89 '..r.dtype)
 assert(close(r:tolist(),{math.huge,-6.0,0.3333333432674408,math.huge,-0.0,8.0},2e-3),'half true_divide values 89')
end
do -- half true_divide 90
 local a=np.array({-1.0,4.0,0.0,0.5,-0.0,-0.0},np.float16)
 local b=np.array({1,-3,0,-1,-3,-3},np.int16)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float32','half true_divide dtype 90 '..r.dtype)
 assert(close(r:tolist(),{-1.0,-1.3333333730697632,(0/0),-0.5,0.0,0.0},2e-3),'half true_divide values 90')
end
do -- half true_divide 91
 local a=np.array({0.5,-1.0,0.5,0.0,-0.0,1.0},np.float16)
 local b=np.array({2.0,0.0,0.0,0.5,1.0,0.0},np.float32)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float32','half true_divide dtype 91 '..r.dtype)
 assert(close(r:tolist(),{0.25,-math.huge,math.huge,0.0,-0.0,math.huge},2e-3),'half true_divide values 91')
end
do -- half true_divide 92
 local a=np.array({0.0,0.5,1.0,2.0,4.0,-1.0},np.float16)
 local b=np.array({1.0,0.0,-1.0,3.0,1.0,-1.0},np.float32)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float32','half true_divide dtype 92 '..r.dtype)
 assert(close(r:tolist(),{0.0,math.huge,-1.0,0.6666666865348816,4.0,1.0},2e-3),'half true_divide values 92')
end
do -- half true_divide 93
 local a=np.array({-1.0,1.0,1.0,0.5,-0.0,2.0},np.float16)
 local b=np.array({4,3,1,2,1,3},np.uint16)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float32','half true_divide dtype 93 '..r.dtype)
 assert(close(r:tolist(),{-0.25,0.3333333432674408,1.0,0.25,-0.0,0.6666666865348816},2e-3),'half true_divide values 93')
end
do -- half true_divide 94
 local a=np.array({0.5,-1.0,0.5,-0.0,1.0,2.0},np.float16)
 local b=np.array({3.0,-1.0,-1.0,0.0,-1.0,2.0},np.float16)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float16','half true_divide dtype 94 '..r.dtype)
 assert(close(r:tolist(),{0.1666259765625,1.0,-0.5,(0/0),-1.0,1.0},2e-3),'half true_divide values 94')
end
do -- half true_divide 95
 local a=np.array({0.5,0.0,4.0,0.5,2.0,1.0},np.float16)
 local b=np.array({-1.0,3.0,2.0,-1.0,-1.0,0.0},np.float32)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float32','half true_divide dtype 95 '..r.dtype)
 assert(close(r:tolist(),{-0.5,0.0,2.0,-0.5,-2.0,math.huge},2e-3),'half true_divide values 95')
end
do -- half true_divide 96
 local a=np.array({-1.0,0.5,-3.0,-1.0,2.0,0.0},np.float16)
 local b=np.array({4,1,1,4,0,4},np.uint8)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float16','half true_divide dtype 96 '..r.dtype)
 assert(close(r:tolist(),{-0.25,0.5,-3.0,-0.25,math.huge,0.0},2e-3),'half true_divide values 96')
end
do -- half true_divide 97
 local a=np.array({4.0,-1.0,-3.0,-1.0,0.0,-1.0},np.float16)
 local b=np.array({2,0,4,3,1,3},np.uint16)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float32','half true_divide dtype 97 '..r.dtype)
 assert(close(r:tolist(),{2.0,-math.huge,-0.75,-0.3333333432674408,0.0,-0.3333333432674408},2e-3),'half true_divide values 97')
end
do -- half true_divide 98
 local a=np.array({-1.0,2.0,1.0,-1.0,-0.0,2.0},np.float16)
 local b=np.array({2,0,2,4,2,2},np.uint16)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float32','half true_divide dtype 98 '..r.dtype)
 assert(close(r:tolist(),{-0.5,math.huge,0.5,-0.25,-0.0,1.0},2e-3),'half true_divide values 98')
end
do -- half true_divide 99
 local a=np.array({-1.0,1.0,1.0,-1.0,2.0,0.5},np.float16)
 local b=np.array({1,1,0,2,1,0},np.int8)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float16','half true_divide dtype 99 '..r.dtype)
 assert(close(r:tolist(),{-1.0,1.0,math.huge,-0.5,2.0,math.huge},2e-3),'half true_divide values 99')
end
do -- half true_divide 100
 local a=np.array({0.0,-1.0,4.0,-0.0,-3.0,0.5},np.float16)
 local b=np.array({1,2,0,-1,0,3},np.int8)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float16','half true_divide dtype 100 '..r.dtype)
 assert(close(r:tolist(),{0.0,-0.5,math.huge,0.0,-math.huge,0.1666259765625},2e-3),'half true_divide values 100')
end
do -- half true_divide 101
 local a=np.array({0.0,0.0,-3.0,0.0,-3.0,1.0},np.float16)
 local b=np.array({2,1,0,2,4,2},np.uint8)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float16','half true_divide dtype 101 '..r.dtype)
 assert(close(r:tolist(),{0.0,0.0,-math.huge,0.0,-0.75,0.5},2e-3),'half true_divide values 101')
end
do -- half true_divide 102
 local a=np.array({0.5,2.0,1.0,0.0,1.0,-3.0},np.float16)
 local b=np.array({-3.0,2.0,1.0,0.0,-1.0,1.0},np.float32)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float32','half true_divide dtype 102 '..r.dtype)
 assert(close(r:tolist(),{-0.1666666716337204,1.0,1.0,(0/0),-1.0,-3.0},2e-3),'half true_divide values 102')
end
do -- half true_divide 103
 local a=np.array({-3.0,-3.0,0.0,4.0,-0.0,-3.0},np.float16)
 local b=np.array({0,3,2,-1,3,0},np.int8)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float16','half true_divide dtype 103 '..r.dtype)
 assert(close(r:tolist(),{-math.huge,-1.0,0.0,-4.0,-0.0,-math.huge},2e-3),'half true_divide values 103')
end
do -- half true_divide 104
 local a=np.array({-1.0,-3.0,0.5,-3.0,1.0,4.0},np.float16)
 local b=np.array({1,0,0,2,4,2},np.uint8)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float16','half true_divide dtype 104 '..r.dtype)
 assert(close(r:tolist(),{-1.0,-math.huge,math.huge,-1.5,0.25,2.0},2e-3),'half true_divide values 104')
end
do -- half true_divide 105
 local a=np.array({0.0,-3.0,-3.0,0.5,0.0,-0.0},np.float16)
 local b=np.array({2,0,1,-1,0,-1},np.int16)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float32','half true_divide dtype 105 '..r.dtype)
 assert(close(r:tolist(),{0.0,-math.huge,-3.0,-0.5,(0/0),0.0},2e-3),'half true_divide values 105')
end
do -- half true_divide 106
 local a=np.array({4.0,0.0,4.0,1.0,0.5,1.0},np.float16)
 local b=np.array({0.0,1.0,3.0,0.5,2.0,1.0},np.float16)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float16','half true_divide dtype 106 '..r.dtype)
 assert(close(r:tolist(),{math.huge,0.0,1.3330078125,2.0,0.25,1.0},2e-3),'half true_divide values 106')
end
do -- half true_divide 107
 local a=np.array({-0.0,-0.0,4.0,1.0,1.0,0.5},np.float16)
 local b=np.array({2,3,3,1,0,1},np.uint16)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float32','half true_divide dtype 107 '..r.dtype)
 assert(close(r:tolist(),{-0.0,-0.0,1.3333333730697632,1.0,math.huge,0.5},2e-3),'half true_divide values 107')
end
do -- half true_divide 108
 local a=np.array({-1.0,4.0,4.0,0.0,4.0,2.0},np.float16)
 local b=np.array({4,4,2,2,0,1},np.uint16)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float32','half true_divide dtype 108 '..r.dtype)
 assert(close(r:tolist(),{-0.25,1.0,2.0,0.0,math.huge,2.0},2e-3),'half true_divide values 108')
end
do -- half floor_divide 109
 local a=np.array({0.5,-0.0,0.0,-1.0,0.0,0.0},np.float16)
 local b=np.array({0.0,2.0,1.0,0.5,-3.0,0.0},np.float64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','half floor_divide dtype 109 '..r.dtype)
 assert(close(r:tolist(),{math.huge,-0.0,0.0,-2.0,-0.0,(0/0)},2e-3),'half floor_divide values 109')
end
do -- half floor_divide 110
 local a=np.array({4.0,4.0,-1.0,-3.0,2.0,-3.0},np.float16)
 local b=np.array({true,true,true,false,true,false},np.bool)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float16','half floor_divide dtype 110 '..r.dtype)
 assert(close(r:tolist(),{4.0,4.0,-1.0,-math.huge,2.0,-math.huge},2e-3),'half floor_divide values 110')
end
do -- half floor_divide 111
 local a=np.array({4.0,-3.0,0.0,4.0,1.0,-3.0},np.float16)
 local b=np.array({2,3,1,3,3,3},np.uint16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','half floor_divide dtype 111 '..r.dtype)
 assert(close(r:tolist(),{2.0,-1.0,0.0,1.0,0.0,-1.0},2e-3),'half floor_divide values 111')
end
do -- half floor_divide 112
 local a=np.array({-1.0,-3.0,0.5,0.0,-0.0,-3.0},np.float16)
 local b=np.array({1,-1,1,-3,3,-1},np.int16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','half floor_divide dtype 112 '..r.dtype)
 assert(close(r:tolist(),{-1.0,3.0,0.0,-0.0,-0.0,3.0},2e-3),'half floor_divide values 112')
end
do -- half floor_divide 113
 local a=np.array({2.0,2.0,0.5,2.0,1.0,-1.0},np.float16)
 local b=np.array({0.0,3.0,2.0,-3.0,2.0,-3.0},np.float64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','half floor_divide dtype 113 '..r.dtype)
 assert(close(r:tolist(),{math.huge,0.0,0.0,-1.0,0.0,0.0},2e-3),'half floor_divide values 113')
end
do -- half floor_divide 114
 local a=np.array({-1.0,0.5,4.0,1.0,2.0,-1.0},np.float16)
 local b=np.array({-1,-1,0,0,1,-3},np.int16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','half floor_divide dtype 114 '..r.dtype)
 assert(close(r:tolist(),{1.0,-1.0,math.huge,math.huge,2.0,0.0},2e-3),'half floor_divide values 114')
end
do -- half floor_divide 115
 local a=np.array({-3.0,2.0,-3.0,-1.0,-3.0,0.0},np.float16)
 local b=np.array({2.0,0.0,0.0,3.0,-3.0,0.5},np.float16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float16','half floor_divide dtype 115 '..r.dtype)
 assert(close(r:tolist(),{-2.0,math.huge,-math.huge,-1.0,1.0,0.0},2e-3),'half floor_divide values 115')
end
do -- half floor_divide 116
 local a=np.array({1.0,-1.0,4.0,0.5,1.0,2.0},np.float16)
 local b=np.array({0,0,0,-1,0,3},np.int16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','half floor_divide dtype 116 '..r.dtype)
 assert(close(r:tolist(),{math.huge,-math.huge,math.huge,-1.0,math.huge,0.0},2e-3),'half floor_divide values 116')
end
do -- half floor_divide 117
 local a=np.array({4.0,-1.0,-3.0,4.0,1.0,-3.0},np.float16)
 local b=np.array({-3.0,0.0,-1.0,-1.0,-3.0,0.0},np.float16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float16','half floor_divide dtype 117 '..r.dtype)
 assert(close(r:tolist(),{-2.0,-math.huge,3.0,-4.0,-1.0,-math.huge},2e-3),'half floor_divide values 117')
end
do -- half floor_divide 118
 local a=np.array({1.0,1.0,1.0,1.0,4.0,0.0},np.float16)
 local b=np.array({0,0,0,0,-3,0},np.int16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','half floor_divide dtype 118 '..r.dtype)
 assert(close(r:tolist(),{math.huge,math.huge,math.huge,math.huge,-2.0,(0/0)},2e-3),'half floor_divide values 118')
end
do -- half floor_divide 119
 local a=np.array({-0.0,-1.0,1.0,2.0,4.0,4.0},np.float16)
 local b=np.array({-1.0,0.0,1.0,3.0,2.0,-3.0},np.float64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','half floor_divide dtype 119 '..r.dtype)
 assert(close(r:tolist(),{0.0,-math.huge,1.0,0.0,2.0,-2.0},2e-3),'half floor_divide values 119')
end
do -- half floor_divide 120
 local a=np.array({-1.0,1.0,1.0,-1.0,4.0,2.0},np.float16)
 local b=np.array({0.5,0.5,0.5,-1.0,0.0,3.0},np.float16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float16','half floor_divide dtype 120 '..r.dtype)
 assert(close(r:tolist(),{-2.0,2.0,2.0,1.0,math.huge,0.0},2e-3),'half floor_divide values 120')
end
do -- half floor_divide 121
 local a=np.array({0.0,4.0,0.0,4.0,0.0,1.0},np.float16)
 local b=np.array({3.0,-1.0,1.0,2.0,-3.0,1.0},np.float16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float16','half floor_divide dtype 121 '..r.dtype)
 assert(close(r:tolist(),{0.0,-4.0,0.0,2.0,-0.0,1.0},2e-3),'half floor_divide values 121')
end
do -- half floor_divide 122
 local a=np.array({-1.0,-0.0,-1.0,-0.0,1.0,2.0},np.float16)
 local b=np.array({3,0,1,3,3,1},np.uint16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','half floor_divide dtype 122 '..r.dtype)
 assert(close(r:tolist(),{-1.0,(0/0),-1.0,-0.0,0.0,2.0},2e-3),'half floor_divide values 122')
end
do -- half floor_divide 123
 local a=np.array({2.0,-1.0,-3.0,-3.0,0.0,0.0},np.float16)
 local b=np.array({0,0,2,-3,0,0},np.int16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','half floor_divide dtype 123 '..r.dtype)
 assert(close(r:tolist(),{math.huge,-math.huge,-2.0,1.0,(0/0),(0/0)},2e-3),'half floor_divide values 123')
end
do -- half floor_divide 124
 local a=np.array({4.0,4.0,1.0,-3.0,4.0,-0.0},np.float16)
 local b=np.array({4,4,0,0,0,4},np.uint16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','half floor_divide dtype 124 '..r.dtype)
 assert(close(r:tolist(),{1.0,1.0,math.huge,-math.huge,math.huge,-0.0},2e-3),'half floor_divide values 124')
end
do -- half floor_divide 125
 local a=np.array({-1.0,0.0,0.5,2.0,-1.0,4.0},np.float16)
 local b=np.array({2,1,3,4,1,0},np.uint8)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float16','half floor_divide dtype 125 '..r.dtype)
 assert(close(r:tolist(),{-1.0,0.0,0.0,0.0,-1.0,math.huge},2e-3),'half floor_divide values 125')
end
do -- half floor_divide 126
 local a=np.array({-0.0,1.0,-3.0,0.5,-1.0,4.0},np.float16)
 local b=np.array({1.0,1.0,-3.0,2.0,0.0,-3.0},np.float16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float16','half floor_divide dtype 126 '..r.dtype)
 assert(close(r:tolist(),{-0.0,1.0,1.0,0.0,-math.huge,-2.0},2e-3),'half floor_divide values 126')
end
do -- half floor_divide 127
 local a=np.array({0.5,-0.0,0.0,1.0,1.0,0.5},np.float16)
 local b=np.array({1.0,3.0,3.0,0.0,0.5,-3.0},np.float64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','half floor_divide dtype 127 '..r.dtype)
 assert(close(r:tolist(),{0.0,-0.0,0.0,math.huge,2.0,-1.0},2e-3),'half floor_divide values 127')
end
do -- half floor_divide 128
 local a=np.array({2.0,0.0,4.0,-1.0,1.0,0.5},np.float16)
 local b=np.array({true,true,true,true,false,true},np.bool)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float16','half floor_divide dtype 128 '..r.dtype)
 assert(close(r:tolist(),{2.0,0.0,4.0,-1.0,math.huge,0.0},2e-3),'half floor_divide values 128')
end
do -- half floor_divide 129
 local a=np.array({2.0,0.0,-1.0,1.0,-1.0,1.0},np.float16)
 local b=np.array({0.0,-1.0,2.0,-3.0,0.0,0.5},np.float16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float16','half floor_divide dtype 129 '..r.dtype)
 assert(close(r:tolist(),{math.huge,-0.0,-1.0,-1.0,-math.huge,2.0},2e-3),'half floor_divide values 129')
end
do -- half floor_divide 130
 local a=np.array({-3.0,0.5,0.0,-3.0,0.5,0.0},np.float16)
 local b=np.array({0.0,0.5,0.5,1.0,2.0,3.0},np.float32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','half floor_divide dtype 130 '..r.dtype)
 assert(close(r:tolist(),{-math.huge,1.0,0.0,-3.0,0.0,0.0},2e-3),'half floor_divide values 130')
end
do -- half floor_divide 131
 local a=np.array({-1.0,4.0,0.0,-1.0,1.0,-3.0},np.float16)
 local b=np.array({-1.0,0.5,-3.0,0.0,-1.0,3.0},np.float16)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float16','half floor_divide dtype 131 '..r.dtype)
 assert(close(r:tolist(),{1.0,8.0,-0.0,-math.huge,-1.0,-1.0},2e-3),'half floor_divide values 131')
end
do -- half floor_divide 132
 local a=np.array({-1.0,4.0,1.0,4.0,-1.0,1.0},np.float16)
 local b=np.array({1.0,2.0,-3.0,-1.0,1.0,-1.0},np.float32)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float32','half floor_divide dtype 132 '..r.dtype)
 assert(close(r:tolist(),{-1.0,2.0,-1.0,-4.0,-1.0,-1.0},2e-3),'half floor_divide values 132')
end
do -- half floor_divide 133
 local a=np.array({-1.0,-0.0,-3.0,0.0,-0.0,0.5},np.float16)
 local b=np.array({-3.0,1.0,2.0,-3.0,0.5,0.5},np.float64)
 local r=np.floor_divide(a,b)
 assert(r.dtype=='float64','half floor_divide dtype 133 '..r.dtype)
 assert(close(r:tolist(),{0.0,-0.0,-2.0,-0.0,-0.0,1.0},2e-3),'half floor_divide values 133')
end
do -- half remainder 134
 local a=np.array({-1.0,-3.0,-1.0,-1.0,2.0,1.0},np.float16)
 local b=np.array({0.0,2.0,1.0,1.0,2.0,3.0},np.float16)
 local r=np.remainder(a,b)
 assert(r.dtype=='float16','half remainder dtype 134 '..r.dtype)
 assert(close(r:tolist(),{(0/0),1.0,0.0,0.0,0.0,1.0},2e-3),'half remainder values 134')
end
do -- half remainder 135
 local a=np.array({0.0,-0.0,-0.0,-0.0,-3.0,0.5},np.float16)
 local b=np.array({0,-3,-3,1,0,0},np.int8)
 local r=np.remainder(a,b)
 assert(r.dtype=='float16','half remainder dtype 135 '..r.dtype)
 assert(close(r:tolist(),{(0/0),-0.0,-0.0,0.0,(0/0),(0/0)},2e-3),'half remainder values 135')
end
do -- half remainder 136
 local a=np.array({-3.0,-1.0,4.0,-3.0,0.5,-3.0},np.float16)
 local b=np.array({0.0,-3.0,0.5,1.0,0.0,-1.0},np.float64)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','half remainder dtype 136 '..r.dtype)
 assert(close(r:tolist(),{(0/0),-1.0,0.0,0.0,(0/0),-0.0},2e-3),'half remainder values 136')
end
do -- half remainder 137
 local a=np.array({-1.0,0.0,4.0,0.0,4.0,-1.0},np.float16)
 local b=np.array({0.0,3.0,-3.0,3.0,0.5,-1.0},np.float32)
 local r=np.remainder(a,b)
 assert(r.dtype=='float32','half remainder dtype 137 '..r.dtype)
 assert(close(r:tolist(),{(0/0),0.0,-2.0,0.0,0.0,-0.0},2e-3),'half remainder values 137')
end
do -- half remainder 138
 local a=np.array({-1.0,4.0,2.0,2.0,-3.0,0.5},np.float16)
 local b=np.array({0.5,0.0,3.0,-1.0,0.0,1.0},np.float64)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','half remainder dtype 138 '..r.dtype)
 assert(close(r:tolist(),{0.0,(0/0),2.0,-0.0,(0/0),0.5},2e-3),'half remainder values 138')
end
do -- half remainder 139
 local a=np.array({1.0,2.0,0.0,0.5,0.5,-0.0},np.float16)
 local b=np.array({true,false,false,false,false,false},np.bool)
 local r=np.remainder(a,b)
 assert(r.dtype=='float16','half remainder dtype 139 '..r.dtype)
 assert(close(r:tolist(),{0.0,(0/0),(0/0),(0/0),(0/0),(0/0)},2e-3),'half remainder values 139')
end
do -- half remainder 140
 local a=np.array({0.5,0.5,-1.0,2.0,-1.0,-3.0},np.float16)
 local b=np.array({0.5,1.0,-1.0,0.5,-1.0,-1.0},np.float64)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','half remainder dtype 140 '..r.dtype)
 assert(close(r:tolist(),{0.0,0.5,-0.0,0.0,-0.0,-0.0},2e-3),'half remainder values 140')
end
do -- half remainder 141
 local a=np.array({1.0,-1.0,0.0,1.0,-0.0,0.5},np.float16)
 local b=np.array({1,2,1,2,0,2},np.uint16)
 local r=np.remainder(a,b)
 assert(r.dtype=='float32','half remainder dtype 141 '..r.dtype)
 assert(close(r:tolist(),{0.0,1.0,0.0,1.0,(0/0),0.5},2e-3),'half remainder values 141')
end
do -- half remainder 142
 local a=np.array({0.0,0.0,0.0,1.0,-1.0,-0.0},np.float16)
 local b=np.array({true,true,false,true,false,true},np.bool)
 local r=np.remainder(a,b)
 assert(r.dtype=='float16','half remainder dtype 142 '..r.dtype)
 assert(close(r:tolist(),{0.0,0.0,(0/0),0.0,(0/0),0.0},2e-3),'half remainder values 142')
end
do -- half remainder 143
 local a=np.array({-1.0,4.0,-0.0,-0.0,4.0,-1.0},np.float16)
 local b=np.array({0.5,0.5,-3.0,3.0,0.0,-3.0},np.float64)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','half remainder dtype 143 '..r.dtype)
 assert(close(r:tolist(),{0.0,0.0,-0.0,0.0,(0/0),-1.0},2e-3),'half remainder values 143')
end
do -- half remainder 144
 local a=np.array({0.0,0.0,-1.0,1.0,1.0,2.0},np.float16)
 local b=np.array({0.0,0.0,0.5,1.0,2.0,-3.0},np.float64)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','half remainder dtype 144 '..r.dtype)
 assert(close(r:tolist(),{(0/0),(0/0),0.0,0.0,1.0,-1.0},2e-3),'half remainder values 144')
end
do -- half remainder 145
 local a=np.array({-0.0,-1.0,-3.0,0.0,0.0,1.0},np.float16)
 local b=np.array({false,true,true,false,true,true},np.bool)
 local r=np.remainder(a,b)
 assert(r.dtype=='float16','half remainder dtype 145 '..r.dtype)
 assert(close(r:tolist(),{(0/0),0.0,0.0,(0/0),0.0,0.0},2e-3),'half remainder values 145')
end
do -- half remainder 146
 local a=np.array({0.0,-1.0,2.0,-3.0,-0.0,4.0},np.float16)
 local b=np.array({2.0,1.0,3.0,2.0,3.0,-3.0},np.float64)
 local r=np.remainder(a,b)
 assert(r.dtype=='float64','half remainder dtype 146 '..r.dtype)
 assert(close(r:tolist(),{0.0,0.0,2.0,1.0,0.0,-2.0},2e-3),'half remainder values 146')
end
do -- half remainder 147
 local a=np.array({1.0,0.0,1.0,-3.0,1.0,0.0},np.float16)
 local b=np.array({0,2,-3,3,3,0},np.int16)
 local r=np.remainder(a,b)
 assert(r.dtype=='float32','half remainder dtype 147 '..r.dtype)
 assert(close(r:tolist(),{(0/0),0.0,-2.0,0.0,1.0,(0/0)},2e-3),'half remainder values 147')
end
do -- half remainder 148
 local a=np.array({0.0,1.0,-1.0,0.0,-3.0,0.0},np.float16)
 local b=np.array({-1,-1,-1,3,0,-3},np.int16)
 local r=np.remainder(a,b)
 assert(r.dtype=='float32','half remainder dtype 148 '..r.dtype)
 assert(close(r:tolist(),{-0.0,-0.0,-0.0,0.0,(0/0),-0.0},2e-3),'half remainder values 148')
end
do -- half remainder 149
 local a=np.array({4.0,2.0,-1.0,0.0,-1.0,-0.0},np.float16)
 local b=np.array({0,0,3,4,0,0},np.uint16)
 local r=np.remainder(a,b)
 assert(r.dtype=='float32','half remainder dtype 149 '..r.dtype)
 assert(close(r:tolist(),{(0/0),(0/0),2.0,0.0,(0/0),(0/0)},2e-3),'half remainder values 149')
end
do -- half remainder 150
 local a=np.array({2.0,-0.0,-1.0,0.0,-3.0,-1.0},np.float16)
 local b=np.array({0,4,0,1,4,1},np.uint8)
 local r=np.remainder(a,b)
 assert(r.dtype=='float16','half remainder dtype 150 '..r.dtype)
 assert(close(r:tolist(),{(0/0),0.0,(0/0),0.0,1.0,0.0},2e-3),'half remainder values 150')
end
do -- half remainder 151
 local a=np.array({-1.0,0.0,1.0,0.5,4.0,-0.0},np.float16)
 local b=np.array({0,2,1,-1,2,-1},np.int8)
 local r=np.remainder(a,b)
 assert(r.dtype=='float16','half remainder dtype 151 '..r.dtype)
 assert(close(r:tolist(),{(0/0),0.0,0.0,-0.5,0.0,-0.0},2e-3),'half remainder values 151')
end
do -- half remainder 152
 local a=np.array({1.0,0.5,0.0,-3.0,-3.0,4.0},np.float16)
 local b=np.array({4,3,2,2,2,0},np.uint16)
 local r=np.remainder(a,b)
 assert(r.dtype=='float32','half remainder dtype 152 '..r.dtype)
 assert(close(r:tolist(),{1.0,0.5,0.0,1.0,1.0,(0/0)},2e-3),'half remainder values 152')
end
do -- half remainder 153
 local a=np.array({-1.0,2.0,0.0,1.0,-0.0,-3.0},np.float16)
 local b=np.array({-1.0,0.5,0.0,0.0,-3.0,-3.0},np.float32)
 local r=np.remainder(a,b)
 assert(r.dtype=='float32','half remainder dtype 153 '..r.dtype)
 assert(close(r:tolist(),{-0.0,0.0,(0/0),(0/0),-0.0,-0.0},2e-3),'half remainder values 153')
end
do -- half remainder 154
 local a=np.array({0.0,2.0,4.0,2.0,-3.0,2.0},np.float16)
 local b=np.array({0,0,4,3,3,0},np.uint16)
 local r=np.remainder(a,b)
 assert(r.dtype=='float32','half remainder dtype 154 '..r.dtype)
 assert(close(r:tolist(),{(0/0),(0/0),0.0,2.0,0.0,(0/0)},2e-3),'half remainder values 154')
end
do -- half remainder 155
 local a=np.array({4.0,-1.0,1.0,-1.0,-0.0,0.5},np.float16)
 local b=np.array({-1,0,-3,0,0,0},np.int8)
 local r=np.remainder(a,b)
 assert(r.dtype=='float16','half remainder dtype 155 '..r.dtype)
 assert(close(r:tolist(),{-0.0,(0/0),-2.0,(0/0),(0/0),(0/0)},2e-3),'half remainder values 155')
end
do -- half remainder 156
 local a=np.array({0.5,2.0,4.0,0.5,-3.0,0.5},np.float16)
 local b=np.array({1.0,3.0,-1.0,0.5,0.5,1.0},np.float16)
 local r=np.remainder(a,b)
 assert(r.dtype=='float16','half remainder dtype 156 '..r.dtype)
 assert(close(r:tolist(),{0.5,2.0,-0.0,0.0,0.0,0.5},2e-3),'half remainder values 156')
end
do -- half remainder 157
 local a=np.array({0.5,2.0,-0.0,1.0,-1.0,4.0},np.float16)
 local b=np.array({-3.0,0.5,1.0,0.5,-1.0,3.0},np.float16)
 local r=np.remainder(a,b)
 assert(r.dtype=='float16','half remainder dtype 157 '..r.dtype)
 assert(close(r:tolist(),{-2.5,0.0,0.0,0.0,-0.0,1.0},2e-3),'half remainder values 157')
end
do -- half remainder 158
 local a=np.array({-0.0,0.0,0.0,0.0,-1.0,0.0},np.float16)
 local b=np.array({4,3,1,2,2,0},np.uint8)
 local r=np.remainder(a,b)
 assert(r.dtype=='float16','half remainder dtype 158 '..r.dtype)
 assert(close(r:tolist(),{0.0,0.0,0.0,0.0,1.0,(0/0)},2e-3),'half remainder values 158')
end
do -- half power 159
 local a=np.array({0.5,0.0,0.0,0.0,1.0,4.0},np.float16)
 local b=np.array({2,1,2,1,2,2},np.uint8)
 local r=np.power(a,b)
 assert(r.dtype=='float16','half power dtype 159 '..r.dtype)
 assert(close(r:tolist(),{0.25,0.0,0.0,0.0,1.0,16.0},2e-3),'half power values 159')
end
do -- half power 160
 local a=np.array({1.0,0.0,4.0,4.0,0.5,2.0},np.float16)
 local b=np.array({0,1,3,0,2,0},np.uint8)
 local r=np.power(a,b)
 assert(r.dtype=='float16','half power dtype 160 '..r.dtype)
 assert(close(r:tolist(),{1.0,0.0,64.0,1.0,0.25,1.0},2e-3),'half power values 160')
end
do -- half power 161
 local a=np.array({1.0,1.0,4.0,0.5,1.0,4.0},np.float16)
 local b=np.array({2.0,1.0,1.0,1.0,1.0,2.0},np.float32)
 local r=np.power(a,b)
 assert(r.dtype=='float32','half power dtype 161 '..r.dtype)
 assert(close(r:tolist(),{1.0,1.0,4.0,0.5,1.0,16.0},2e-3),'half power values 161')
end
do -- half power 162
 local a=np.array({0.5,0.5,1.0,4.0,0.0,2.0},np.float16)
 local b=np.array({0.0,0.0,0.0,2.0,3.0,0.0},np.float32)
 local r=np.power(a,b)
 assert(r.dtype=='float32','half power dtype 162 '..r.dtype)
 assert(close(r:tolist(),{1.0,1.0,1.0,16.0,0.0,1.0},2e-3),'half power values 162')
end
do -- half power 163
 local a=np.array({0.0,0.0,3.0,4.0,2.0,0.0},np.float16)
 local b=np.array({0.0,2.0,2.0,3.0,0.0,1.0},np.float32)
 local r=np.power(a,b)
 assert(r.dtype=='float32','half power dtype 163 '..r.dtype)
 assert(close(r:tolist(),{1.0,0.0,9.0,64.0,1.0,0.0},2e-3),'half power values 163')
end
do -- half power 164
 local a=np.array({2.0,2.0,0.5,4.0,0.0,0.0},np.float16)
 local b=np.array({0,2,2,1,0,2},np.int8)
 local r=np.power(a,b)
 assert(r.dtype=='float16','half power dtype 164 '..r.dtype)
 assert(close(r:tolist(),{1.0,4.0,0.25,4.0,1.0,0.0},2e-3),'half power values 164')
end
do -- half power 165
 local a=np.array({0.0,2.0,0.5,4.0,1.0,3.0},np.float16)
 local b=np.array({3.0,1.0,1.0,1.0,1.0,3.0},np.float32)
 local r=np.power(a,b)
 assert(r.dtype=='float32','half power dtype 165 '..r.dtype)
 assert(close(r:tolist(),{0.0,2.0,0.5,4.0,1.0,27.0},2e-3),'half power values 165')
end
do -- half power 166
 local a=np.array({0.0,2.0,0.0,0.0,0.5,0.5},np.float16)
 local b=np.array({3,3,3,2,3,2},np.int16)
 local r=np.power(a,b)
 assert(r.dtype=='float32','half power dtype 166 '..r.dtype)
 assert(close(r:tolist(),{0.0,8.0,0.0,0.0,0.125,0.25},2e-3),'half power values 166')
end
do -- half power 167
 local a=np.array({0.0,1.0,3.0,3.0,0.0,0.0},np.float16)
 local b=np.array({true,true,false,false,true,true},np.bool)
 local r=np.power(a,b)
 assert(r.dtype=='float16','half power dtype 167 '..r.dtype)
 assert(close(r:tolist(),{0.0,1.0,1.0,1.0,0.0,0.0},2e-3),'half power values 167')
end
do -- half power 168
 local a=np.array({1.0,0.5,2.0,0.0,0.0,2.0},np.float16)
 local b=np.array({1.0,2.0,2.0,3.0,3.0,1.0},np.float16)
 local r=np.power(a,b)
 assert(r.dtype=='float16','half power dtype 168 '..r.dtype)
 assert(close(r:tolist(),{1.0,0.25,4.0,0.0,0.0,2.0},2e-3),'half power values 168')
end
do -- half power 169
 local a=np.array({0.0,1.0,0.0,2.0,1.0,4.0},np.float16)
 local b=np.array({3,0,1,2,2,1},np.int8)
 local r=np.power(a,b)
 assert(r.dtype=='float16','half power dtype 169 '..r.dtype)
 assert(close(r:tolist(),{0.0,1.0,0.0,4.0,1.0,4.0},2e-3),'half power values 169')
end
do -- half power 170
 local a=np.array({0.5,2.0,0.0,2.0,2.0,1.0},np.float16)
 local b=np.array({1,3,2,2,3,0},np.uint8)
 local r=np.power(a,b)
 assert(r.dtype=='float16','half power dtype 170 '..r.dtype)
 assert(close(r:tolist(),{0.5,8.0,0.0,4.0,8.0,1.0},2e-3),'half power values 170')
end
do -- half power 171
 local a=np.array({2.0,1.0,1.0,0.5,1.0,3.0},np.float16)
 local b=np.array({3.0,3.0,3.0,1.0,2.0,2.0},np.float32)
 local r=np.power(a,b)
 assert(r.dtype=='float32','half power dtype 171 '..r.dtype)
 assert(close(r:tolist(),{8.0,1.0,1.0,0.5,1.0,9.0},2e-3),'half power values 171')
end
do -- half power 172
 local a=np.array({3.0,0.0,0.5,1.0,4.0,1.0},np.float16)
 local b=np.array({2,1,3,1,2,3},np.int8)
 local r=np.power(a,b)
 assert(r.dtype=='float16','half power dtype 172 '..r.dtype)
 assert(close(r:tolist(),{9.0,0.0,0.125,1.0,16.0,1.0},2e-3),'half power values 172')
end
do -- half power 173
 local a=np.array({0.0,3.0,0.5,1.0,0.5,2.0},np.float16)
 local b=np.array({true,true,true,true,false,true},np.bool)
 local r=np.power(a,b)
 assert(r.dtype=='float16','half power dtype 173 '..r.dtype)
 assert(close(r:tolist(),{0.0,3.0,0.5,1.0,1.0,2.0},2e-3),'half power values 173')
end
do -- half power 174
 local a=np.array({0.0,4.0,0.0,0.5,4.0,0.0},np.float16)
 local b=np.array({3,2,3,0,3,0},np.uint16)
 local r=np.power(a,b)
 assert(r.dtype=='float32','half power dtype 174 '..r.dtype)
 assert(close(r:tolist(),{0.0,16.0,0.0,1.0,64.0,1.0},2e-3),'half power values 174')
end
do -- half power 175
 local a=np.array({4.0,3.0,0.5,1.0,0.0,4.0},np.float16)
 local b=np.array({1.0,2.0,2.0,2.0,3.0,1.0},np.float64)
 local r=np.power(a,b)
 assert(r.dtype=='float64','half power dtype 175 '..r.dtype)
 assert(close(r:tolist(),{4.0,9.0,0.25,1.0,0.0,4.0},2e-3),'half power values 175')
end
do -- half power 176
 local a=np.array({0.0,1.0,1.0,1.0,1.0,0.0},np.float16)
 local b=np.array({3.0,2.0,2.0,2.0,0.0,2.0},np.float16)
 local r=np.power(a,b)
 assert(r.dtype=='float16','half power dtype 176 '..r.dtype)
 assert(close(r:tolist(),{0.0,1.0,1.0,1.0,1.0,0.0},2e-3),'half power values 176')
end
do -- half power 177
 local a=np.array({0.0,1.0,1.0,0.0,0.0,0.0},np.float16)
 local b=np.array({0,1,3,2,3,0},np.uint16)
 local r=np.power(a,b)
 assert(r.dtype=='float32','half power dtype 177 '..r.dtype)
 assert(close(r:tolist(),{1.0,1.0,1.0,0.0,0.0,1.0},2e-3),'half power values 177')
end
do -- half power 178
 local a=np.array({1.0,1.0,3.0,0.5,1.0,1.0},np.float16)
 local b=np.array({1,1,3,1,1,0},np.uint16)
 local r=np.power(a,b)
 assert(r.dtype=='float32','half power dtype 178 '..r.dtype)
 assert(close(r:tolist(),{1.0,1.0,27.0,0.5,1.0,1.0},2e-3),'half power values 178')
end
do -- half power 179
 local a=np.array({0.0,0.0,2.0,0.0,4.0,0.0},np.float16)
 local b=np.array({3,1,0,3,2,2},np.int16)
 local r=np.power(a,b)
 assert(r.dtype=='float32','half power dtype 179 '..r.dtype)
 assert(close(r:tolist(),{0.0,0.0,1.0,0.0,16.0,0.0},2e-3),'half power values 179')
end
do -- half power 180
 local a=np.array({0.0,0.5,1.0,1.0,0.0,4.0},np.float16)
 local b=np.array({3,2,1,0,2,0},np.int8)
 local r=np.power(a,b)
 assert(r.dtype=='float16','half power dtype 180 '..r.dtype)
 assert(close(r:tolist(),{0.0,0.25,1.0,1.0,0.0,1.0},2e-3),'half power values 180')
end
do -- half power 181
 local a=np.array({1.0,1.0,0.0,2.0,0.5,3.0},np.float16)
 local b=np.array({1,1,1,0,2,2},np.int16)
 local r=np.power(a,b)
 assert(r.dtype=='float32','half power dtype 181 '..r.dtype)
 assert(close(r:tolist(),{1.0,1.0,0.0,1.0,0.25,9.0},2e-3),'half power values 181')
end
do -- half power 182
 local a=np.array({0.5,2.0,1.0,0.0,0.0,0.5},np.float16)
 local b=np.array({2,3,0,2,0,1},np.uint16)
 local r=np.power(a,b)
 assert(r.dtype=='float32','half power dtype 182 '..r.dtype)
 assert(close(r:tolist(),{0.25,8.0,1.0,0.0,1.0,0.5},2e-3),'half power values 182')
end
do -- half power 183
 local a=np.array({1.0,2.0,2.0,2.0,2.0,2.0},np.float16)
 local b=np.array({1,0,1,1,2,3},np.uint16)
 local r=np.power(a,b)
 assert(r.dtype=='float32','half power dtype 183 '..r.dtype)
 assert(close(r:tolist(),{1.0,1.0,2.0,2.0,4.0,8.0},2e-3),'half power values 183')
end
do -- half maximum 184
 local a=np.array({1.0,1.0,-3.0,4.0,2.0,-3.0},np.float16)
 local b=np.array({3,-3,3,-1,-3,-1},np.int8)
 local r=np.maximum(a,b)
 assert(r.dtype=='float16','half maximum dtype 184 '..r.dtype)
 assert(close(r:tolist(),{3.0,1.0,3.0,4.0,2.0,-1.0},2e-3),'half maximum values 184')
end
do -- half maximum 185
 local a=np.array({2.0,2.0,0.5,0.5,-1.0,4.0},np.float16)
 local b=np.array({0,-3,0,2,2,0},np.int16)
 local r=np.maximum(a,b)
 assert(r.dtype=='float32','half maximum dtype 185 '..r.dtype)
 assert(close(r:tolist(),{2.0,2.0,0.5,2.0,2.0,4.0},2e-3),'half maximum values 185')
end
do -- half maximum 186
 local a=np.array({-3.0,-1.0,2.0,-3.0,2.0,-3.0},np.float16)
 local b=np.array({1.0,1.0,-3.0,1.0,2.0,0.0},np.float64)
 local r=np.maximum(a,b)
 assert(r.dtype=='float64','half maximum dtype 186 '..r.dtype)
 assert(close(r:tolist(),{1.0,1.0,2.0,1.0,2.0,0.0},2e-3),'half maximum values 186')
end
do -- half maximum 187
 local a=np.array({-1.0,0.0,-0.0,0.0,1.0,4.0},np.float16)
 local b=np.array({1,1,3,4,4,2},np.uint8)
 local r=np.maximum(a,b)
 assert(r.dtype=='float16','half maximum dtype 187 '..r.dtype)
 assert(close(r:tolist(),{1.0,1.0,3.0,4.0,4.0,4.0},2e-3),'half maximum values 187')
end
do -- half maximum 188
 local a=np.array({4.0,0.5,1.0,0.0,-3.0,4.0},np.float16)
 local b=np.array({2,0,2,2,1,1},np.uint16)
 local r=np.maximum(a,b)
 assert(r.dtype=='float32','half maximum dtype 188 '..r.dtype)
 assert(close(r:tolist(),{4.0,0.5,2.0,2.0,1.0,4.0},2e-3),'half maximum values 188')
end
do -- half maximum 189
 local a=np.array({2.0,1.0,0.0,-3.0,0.5,0.5},np.float16)
 local b=np.array({3,0,2,3,0,0},np.int16)
 local r=np.maximum(a,b)
 assert(r.dtype=='float32','half maximum dtype 189 '..r.dtype)
 assert(close(r:tolist(),{3.0,1.0,2.0,3.0,0.5,0.5},2e-3),'half maximum values 189')
end
do -- half maximum 190
 local a=np.array({-1.0,0.5,0.5,-3.0,2.0,-1.0},np.float16)
 local b=np.array({false,true,false,false,false,true},np.bool)
 local r=np.maximum(a,b)
 assert(r.dtype=='float16','half maximum dtype 190 '..r.dtype)
 assert(close(r:tolist(),{0.0,1.0,0.5,0.0,2.0,1.0},2e-3),'half maximum values 190')
end
do -- half maximum 191
 local a=np.array({2.0,-1.0,-1.0,-0.0,4.0,1.0},np.float16)
 local b=np.array({2,0,3,2,2,3},np.uint16)
 local r=np.maximum(a,b)
 assert(r.dtype=='float32','half maximum dtype 191 '..r.dtype)
 assert(close(r:tolist(),{2.0,0.0,3.0,2.0,4.0,3.0},2e-3),'half maximum values 191')
end
do -- half maximum 192
 local a=np.array({1.0,1.0,0.5,4.0,0.5,-0.0},np.float16)
 local b=np.array({true,true,true,true,false,true},np.bool)
 local r=np.maximum(a,b)
 assert(r.dtype=='float16','half maximum dtype 192 '..r.dtype)
 assert(close(r:tolist(),{1.0,1.0,1.0,4.0,0.5,1.0},2e-3),'half maximum values 192')
end
do -- half maximum 193
 local a=np.array({2.0,-1.0,-1.0,2.0,-3.0,-0.0},np.float16)
 local b=np.array({0,0,-1,1,3,3},np.int8)
 local r=np.maximum(a,b)
 assert(r.dtype=='float16','half maximum dtype 193 '..r.dtype)
 assert(close(r:tolist(),{2.0,0.0,-1.0,2.0,3.0,3.0},2e-3),'half maximum values 193')
end
do -- half maximum 194
 local a=np.array({-3.0,1.0,4.0,-0.0,4.0,2.0},np.float16)
 local b=np.array({2,0,0,4,0,2},np.uint16)
 local r=np.maximum(a,b)
 assert(r.dtype=='float32','half maximum dtype 194 '..r.dtype)
 assert(close(r:tolist(),{2.0,1.0,4.0,4.0,4.0,2.0},2e-3),'half maximum values 194')
end
do -- half maximum 195
 local a=np.array({1.0,-3.0,1.0,1.0,0.0,-1.0},np.float16)
 local b=np.array({3,0,3,3,2,0},np.int8)
 local r=np.maximum(a,b)
 assert(r.dtype=='float16','half maximum dtype 195 '..r.dtype)
 assert(close(r:tolist(),{3.0,0.0,3.0,3.0,2.0,0.0},2e-3),'half maximum values 195')
end
do -- half maximum 196
 local a=np.array({-3.0,-0.0,0.5,2.0,-3.0,0.0},np.float16)
 local b=np.array({3.0,-1.0,-1.0,3.0,0.5,0.0},np.float32)
 local r=np.maximum(a,b)
 assert(r.dtype=='float32','half maximum dtype 196 '..r.dtype)
 assert(close(r:tolist(),{3.0,-0.0,0.5,3.0,0.5,0.0},2e-3),'half maximum values 196')
end
do -- half maximum 197
 local a=np.array({2.0,1.0,1.0,-1.0,-3.0,-0.0},np.float16)
 local b=np.array({-1,0,1,-1,0,0},np.int16)
 local r=np.maximum(a,b)
 assert(r.dtype=='float32','half maximum dtype 197 '..r.dtype)
 assert(close(r:tolist(),{2.0,1.0,1.0,-1.0,0.0,0.0},2e-3),'half maximum values 197')
end
do -- half maximum 198
 local a=np.array({2.0,4.0,2.0,2.0,4.0,-0.0},np.float16)
 local b=np.array({-3,1,2,-3,1,-1},np.int8)
 local r=np.maximum(a,b)
 assert(r.dtype=='float16','half maximum dtype 198 '..r.dtype)
 assert(close(r:tolist(),{2.0,4.0,2.0,2.0,4.0,-0.0},2e-3),'half maximum values 198')
end
do -- half maximum 199
 local a=np.array({-0.0,-0.0,0.0,1.0,2.0,0.0},np.float16)
 local b=np.array({-3.0,3.0,3.0,0.5,0.5,0.0},np.float32)
 local r=np.maximum(a,b)
 assert(r.dtype=='float32','half maximum dtype 199 '..r.dtype)
 assert(close(r:tolist(),{-0.0,3.0,3.0,1.0,2.0,0.0},2e-3),'half maximum values 199')
end
do -- half maximum 200
 local a=np.array({0.0,4.0,4.0,0.0,2.0,1.0},np.float16)
 local b=np.array({-3.0,1.0,-1.0,-3.0,0.5,1.0},np.float16)
 local r=np.maximum(a,b)
 assert(r.dtype=='float16','half maximum dtype 200 '..r.dtype)
 assert(close(r:tolist(),{0.0,4.0,4.0,0.0,2.0,1.0},2e-3),'half maximum values 200')
end
do -- half maximum 201
 local a=np.array({-0.0,2.0,2.0,-3.0,-0.0,0.5},np.float16)
 local b=np.array({true,false,false,false,false,false},np.bool)
 local r=np.maximum(a,b)
 assert(r.dtype=='float16','half maximum dtype 201 '..r.dtype)
 assert(close(r:tolist(),{1.0,2.0,2.0,0.0,-0.0,0.5},2e-3),'half maximum values 201')
end
do -- half maximum 202
 local a=np.array({1.0,0.5,0.0,1.0,-1.0,0.0},np.float16)
 local b=np.array({false,false,false,false,true,false},np.bool)
 local r=np.maximum(a,b)
 assert(r.dtype=='float16','half maximum dtype 202 '..r.dtype)
 assert(close(r:tolist(),{1.0,0.5,0.0,1.0,1.0,0.0},2e-3),'half maximum values 202')
end
do -- half maximum 203
 local a=np.array({0.0,0.0,4.0,-0.0,0.0,1.0},np.float16)
 local b=np.array({1,3,0,-3,1,1},np.int16)
 local r=np.maximum(a,b)
 assert(r.dtype=='float32','half maximum dtype 203 '..r.dtype)
 assert(close(r:tolist(),{1.0,3.0,4.0,-0.0,1.0,1.0},2e-3),'half maximum values 203')
end
do -- half maximum 204
 local a=np.array({0.5,-1.0,4.0,-0.0,0.5,4.0},np.float16)
 local b=np.array({0.5,-3.0,1.0,0.0,1.0,-3.0},np.float16)
 local r=np.maximum(a,b)
 assert(r.dtype=='float16','half maximum dtype 204 '..r.dtype)
 assert(close(r:tolist(),{0.5,-1.0,4.0,-0.0,1.0,4.0},2e-3),'half maximum values 204')
end
do -- half maximum 205
 local a=np.array({1.0,-3.0,-1.0,-1.0,0.5,1.0},np.float16)
 local b=np.array({1.0,2.0,-1.0,3.0,1.0,1.0},np.float32)
 local r=np.maximum(a,b)
 assert(r.dtype=='float32','half maximum dtype 205 '..r.dtype)
 assert(close(r:tolist(),{1.0,2.0,-1.0,3.0,1.0,1.0},2e-3),'half maximum values 205')
end
do -- half maximum 206
 local a=np.array({4.0,-1.0,1.0,1.0,-3.0,1.0},np.float16)
 local b=np.array({3,4,1,4,2,3},np.uint16)
 local r=np.maximum(a,b)
 assert(r.dtype=='float32','half maximum dtype 206 '..r.dtype)
 assert(close(r:tolist(),{4.0,4.0,1.0,4.0,2.0,3.0},2e-3),'half maximum values 206')
end
do -- half maximum 207
 local a=np.array({0.0,2.0,0.5,0.0,4.0,4.0},np.float16)
 local b=np.array({1.0,-3.0,3.0,1.0,-1.0,1.0},np.float16)
 local r=np.maximum(a,b)
 assert(r.dtype=='float16','half maximum dtype 207 '..r.dtype)
 assert(close(r:tolist(),{1.0,2.0,3.0,1.0,4.0,4.0},2e-3),'half maximum values 207')
end
do -- half maximum 208
 local a=np.array({4.0,2.0,2.0,-0.0,2.0,4.0},np.float16)
 local b=np.array({3,1,0,4,0,3},np.uint16)
 local r=np.maximum(a,b)
 assert(r.dtype=='float32','half maximum dtype 208 '..r.dtype)
 assert(close(r:tolist(),{4.0,2.0,2.0,4.0,2.0,4.0},2e-3),'half maximum values 208')
end
do -- half minimum 209
 local a=np.array({0.0,4.0,-0.0,2.0,0.5,0.0},np.float16)
 local b=np.array({0,3,3,4,4,0},np.uint8)
 local r=np.minimum(a,b)
 assert(r.dtype=='float16','half minimum dtype 209 '..r.dtype)
 assert(close(r:tolist(),{0.0,3.0,-0.0,2.0,0.5,0.0},2e-3),'half minimum values 209')
end
do -- half minimum 210
 local a=np.array({4.0,-3.0,1.0,-3.0,-0.0,2.0},np.float16)
 local b=np.array({false,true,false,false,true,false},np.bool)
 local r=np.minimum(a,b)
 assert(r.dtype=='float16','half minimum dtype 210 '..r.dtype)
 assert(close(r:tolist(),{0.0,-3.0,0.0,-3.0,-0.0,0.0},2e-3),'half minimum values 210')
end
do -- half minimum 211
 local a=np.array({2.0,-3.0,0.0,0.5,2.0,0.5},np.float16)
 local b=np.array({0,2,0,1,3,1},np.int16)
 local r=np.minimum(a,b)
 assert(r.dtype=='float32','half minimum dtype 211 '..r.dtype)
 assert(close(r:tolist(),{0.0,-3.0,0.0,0.5,2.0,0.5},2e-3),'half minimum values 211')
end
do -- half minimum 212
 local a=np.array({-3.0,-1.0,-0.0,0.5,4.0,4.0},np.float16)
 local b=np.array({0.5,2.0,0.0,-3.0,-3.0,1.0},np.float64)
 local r=np.minimum(a,b)
 assert(r.dtype=='float64','half minimum dtype 212 '..r.dtype)
 assert(close(r:tolist(),{-3.0,-1.0,0.0,-3.0,-3.0,1.0},2e-3),'half minimum values 212')
end
do -- half minimum 213
 local a=np.array({4.0,-0.0,1.0,4.0,2.0,1.0},np.float16)
 local b=np.array({-3.0,3.0,0.0,2.0,0.5,3.0},np.float16)
 local r=np.minimum(a,b)
 assert(r.dtype=='float16','half minimum dtype 213 '..r.dtype)
 assert(close(r:tolist(),{-3.0,-0.0,0.0,2.0,0.5,1.0},2e-3),'half minimum values 213')
end
do -- half minimum 214
 local a=np.array({4.0,0.5,2.0,-1.0,1.0,0.5},np.float16)
 local b=np.array({0,3,0,0,3,1},np.int8)
 local r=np.minimum(a,b)
 assert(r.dtype=='float16','half minimum dtype 214 '..r.dtype)
 assert(close(r:tolist(),{0.0,0.5,0.0,-1.0,1.0,0.5},2e-3),'half minimum values 214')
end
do -- half minimum 215
 local a=np.array({1.0,-1.0,0.0,-1.0,2.0,-0.0},np.float16)
 local b=np.array({0,1,0,2,1,1},np.uint16)
 local r=np.minimum(a,b)
 assert(r.dtype=='float32','half minimum dtype 215 '..r.dtype)
 assert(close(r:tolist(),{0.0,-1.0,0.0,-1.0,1.0,-0.0},2e-3),'half minimum values 215')
end
do -- half minimum 216
 local a=np.array({0.0,4.0,0.0,0.5,-1.0,4.0},np.float16)
 local b=np.array({1,2,1,0,1,0},np.int8)
 local r=np.minimum(a,b)
 assert(r.dtype=='float16','half minimum dtype 216 '..r.dtype)
 assert(close(r:tolist(),{0.0,2.0,0.0,0.0,-1.0,0.0},2e-3),'half minimum values 216')
end
do -- half minimum 217
 local a=np.array({-3.0,-3.0,1.0,0.5,2.0,2.0},np.float16)
 local b=np.array({2,3,2,2,2,2},np.int16)
 local r=np.minimum(a,b)
 assert(r.dtype=='float32','half minimum dtype 217 '..r.dtype)
 assert(close(r:tolist(),{-3.0,-3.0,1.0,0.5,2.0,2.0},2e-3),'half minimum values 217')
end
do -- half minimum 218
 local a=np.array({-3.0,-0.0,4.0,4.0,0.5,-0.0},np.float16)
 local b=np.array({1,3,0,4,0,2},np.uint16)
 local r=np.minimum(a,b)
 assert(r.dtype=='float32','half minimum dtype 218 '..r.dtype)
 assert(close(r:tolist(),{-3.0,-0.0,0.0,4.0,0.0,-0.0},2e-3),'half minimum values 218')
end
do -- half minimum 219
 local a=np.array({-0.0,4.0,-0.0,-1.0,1.0,0.0},np.float16)
 local b=np.array({-1.0,0.5,0.0,-3.0,-1.0,-1.0},np.float64)
 local r=np.minimum(a,b)
 assert(r.dtype=='float64','half minimum dtype 219 '..r.dtype)
 assert(close(r:tolist(),{-1.0,0.5,0.0,-3.0,-1.0,-1.0},2e-3),'half minimum values 219')
end
do -- half minimum 220
 local a=np.array({-1.0,-3.0,0.0,-0.0,-1.0,1.0},np.float16)
 local b=np.array({2,0,3,1,4,2},np.uint8)
 local r=np.minimum(a,b)
 assert(r.dtype=='float16','half minimum dtype 220 '..r.dtype)
 assert(close(r:tolist(),{-1.0,-3.0,0.0,-0.0,-1.0,1.0},2e-3),'half minimum values 220')
end
do -- half minimum 221
 local a=np.array({0.5,0.0,2.0,2.0,0.0,1.0},np.float16)
 local b=np.array({-3.0,-1.0,0.5,0.0,3.0,2.0},np.float64)
 local r=np.minimum(a,b)
 assert(r.dtype=='float64','half minimum dtype 221 '..r.dtype)
 assert(close(r:tolist(),{-3.0,-1.0,0.5,0.0,0.0,1.0},2e-3),'half minimum values 221')
end
do -- half minimum 222
 local a=np.array({1.0,1.0,4.0,2.0,1.0,-0.0},np.float16)
 local b=np.array({1,2,2,2,2,0},np.uint8)
 local r=np.minimum(a,b)
 assert(r.dtype=='float16','half minimum dtype 222 '..r.dtype)
 assert(close(r:tolist(),{1.0,1.0,2.0,2.0,1.0,-0.0},2e-3),'half minimum values 222')
end
do -- half minimum 223
 local a=np.array({0.5,4.0,4.0,-0.0,4.0,-1.0},np.float16)
 local b=np.array({0.5,0.5,-3.0,0.0,1.0,-3.0},np.float64)
 local r=np.minimum(a,b)
 assert(r.dtype=='float64','half minimum dtype 223 '..r.dtype)
 assert(close(r:tolist(),{0.5,0.5,-3.0,0.0,1.0,-3.0},2e-3),'half minimum values 223')
end
do -- half minimum 224
 local a=np.array({4.0,0.0,0.0,1.0,-1.0,-1.0},np.float16)
 local b=np.array({0.5,-3.0,2.0,-1.0,-3.0,3.0},np.float64)
 local r=np.minimum(a,b)
 assert(r.dtype=='float64','half minimum dtype 224 '..r.dtype)
 assert(close(r:tolist(),{0.5,-3.0,0.0,-1.0,-3.0,-1.0},2e-3),'half minimum values 224')
end
do -- half minimum 225
 local a=np.array({-3.0,0.5,0.5,0.5,2.0,-3.0},np.float16)
 local b=np.array({3,0,0,-3,-1,2},np.int8)
 local r=np.minimum(a,b)
 assert(r.dtype=='float16','half minimum dtype 225 '..r.dtype)
 assert(close(r:tolist(),{-3.0,0.0,0.0,-3.0,-1.0,-3.0},2e-3),'half minimum values 225')
end
do -- half minimum 226
 local a=np.array({0.0,-3.0,0.0,0.0,1.0,2.0},np.float16)
 local b=np.array({0.0,2.0,0.0,-3.0,1.0,0.0},np.float16)
 local r=np.minimum(a,b)
 assert(r.dtype=='float16','half minimum dtype 226 '..r.dtype)
 assert(close(r:tolist(),{0.0,-3.0,0.0,-3.0,1.0,0.0},2e-3),'half minimum values 226')
end
do -- half minimum 227
 local a=np.array({4.0,2.0,-3.0,0.5,4.0,-3.0},np.float16)
 local b=np.array({3.0,1.0,-3.0,-3.0,3.0,2.0},np.float32)
 local r=np.minimum(a,b)
 assert(r.dtype=='float32','half minimum dtype 227 '..r.dtype)
 assert(close(r:tolist(),{3.0,1.0,-3.0,-3.0,3.0,-3.0},2e-3),'half minimum values 227')
end
do -- half minimum 228
 local a=np.array({4.0,0.0,-3.0,-3.0,2.0,-3.0},np.float16)
 local b=np.array({0.0,1.0,-1.0,0.5,0.5,-3.0},np.float16)
 local r=np.minimum(a,b)
 assert(r.dtype=='float16','half minimum dtype 228 '..r.dtype)
 assert(close(r:tolist(),{0.0,0.0,-3.0,-3.0,0.5,-3.0},2e-3),'half minimum values 228')
end
do -- half minimum 229
 local a=np.array({2.0,-1.0,-1.0,2.0,-3.0,-3.0},np.float16)
 local b=np.array({2.0,-1.0,-1.0,0.5,0.5,-3.0},np.float64)
 local r=np.minimum(a,b)
 assert(r.dtype=='float64','half minimum dtype 229 '..r.dtype)
 assert(close(r:tolist(),{2.0,-1.0,-1.0,0.5,-3.0,-3.0},2e-3),'half minimum values 229')
end
do -- half minimum 230
 local a=np.array({4.0,0.0,0.5,0.5,0.0,4.0},np.float16)
 local b=np.array({1,1,0,0,3,3},np.uint16)
 local r=np.minimum(a,b)
 assert(r.dtype=='float32','half minimum dtype 230 '..r.dtype)
 assert(close(r:tolist(),{1.0,0.0,0.0,0.0,0.0,3.0},2e-3),'half minimum values 230')
end
do -- half minimum 231
 local a=np.array({4.0,-3.0,-3.0,0.0,-1.0,-3.0},np.float16)
 local b=np.array({3,1,2,2,0,1},np.uint16)
 local r=np.minimum(a,b)
 assert(r.dtype=='float32','half minimum dtype 231 '..r.dtype)
 assert(close(r:tolist(),{3.0,-3.0,-3.0,0.0,-1.0,-3.0},2e-3),'half minimum values 231')
end
do -- half minimum 232
 local a=np.array({0.5,0.0,0.5,-0.0,-0.0,2.0},np.float16)
 local b=np.array({-1,2,2,2,3,-3},np.int8)
 local r=np.minimum(a,b)
 assert(r.dtype=='float16','half minimum dtype 232 '..r.dtype)
 assert(close(r:tolist(),{-1.0,0.0,0.5,-0.0,-0.0,-3.0},2e-3),'half minimum values 232')
end
do -- half minimum 233
 local a=np.array({1.0,0.0,-0.0,1.0,-0.0,-3.0},np.float16)
 local b=np.array({3,0,-3,2,2,0},np.int8)
 local r=np.minimum(a,b)
 assert(r.dtype=='float16','half minimum dtype 233 '..r.dtype)
 assert(close(r:tolist(),{1.0,0.0,-3.0,1.0,-0.0,-3.0},2e-3),'half minimum values 233')
end
do -- half fmax 234
 local a=np.array({1.0,-1.0,-0.0,-1.0,-3.0,-0.0},np.float16)
 local b=np.array({false,false,true,false,true,false},np.bool)
 local r=np.fmax(a,b)
 assert(r.dtype=='float16','half fmax dtype 234 '..r.dtype)
 assert(close(r:tolist(),{1.0,0.0,1.0,0.0,1.0,-0.0},2e-3),'half fmax values 234')
end
do -- half fmax 235
 local a=np.array({4.0,0.5,-1.0,-3.0,0.5,4.0},np.float16)
 local b=np.array({2,1,-3,0,0,1},np.int16)
 local r=np.fmax(a,b)
 assert(r.dtype=='float32','half fmax dtype 235 '..r.dtype)
 assert(close(r:tolist(),{4.0,1.0,-1.0,0.0,0.5,4.0},2e-3),'half fmax values 235')
end
do -- half fmax 236
 local a=np.array({-3.0,0.5,2.0,2.0,-3.0,-1.0},np.float16)
 local b=np.array({0.0,0.5,0.5,1.0,3.0,0.0},np.float32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float32','half fmax dtype 236 '..r.dtype)
 assert(close(r:tolist(),{0.0,0.5,2.0,2.0,3.0,0.0},2e-3),'half fmax values 236')
end
do -- half fmax 237
 local a=np.array({-1.0,-3.0,0.5,-3.0,1.0,-3.0},np.float16)
 local b=np.array({2.0,1.0,1.0,0.0,0.5,1.0},np.float64)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','half fmax dtype 237 '..r.dtype)
 assert(close(r:tolist(),{2.0,1.0,1.0,0.0,1.0,1.0},2e-3),'half fmax values 237')
end
do -- half fmax 238
 local a=np.array({4.0,0.0,2.0,0.0,-3.0,-1.0},np.float16)
 local b=np.array({false,true,false,true,true,false},np.bool)
 local r=np.fmax(a,b)
 assert(r.dtype=='float16','half fmax dtype 238 '..r.dtype)
 assert(close(r:tolist(),{4.0,1.0,2.0,1.0,1.0,0.0},2e-3),'half fmax values 238')
end
do -- half fmax 239
 local a=np.array({-1.0,-3.0,-0.0,-1.0,4.0,0.5},np.float16)
 local b=np.array({2,1,-1,3,-3,-3},np.int8)
 local r=np.fmax(a,b)
 assert(r.dtype=='float16','half fmax dtype 239 '..r.dtype)
 assert(close(r:tolist(),{2.0,1.0,-0.0,3.0,4.0,0.5},2e-3),'half fmax values 239')
end
do -- half fmax 240
 local a=np.array({0.0,1.0,2.0,-1.0,4.0,0.5},np.float16)
 local b=np.array({-3.0,0.5,-1.0,-1.0,-1.0,0.0},np.float64)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','half fmax dtype 240 '..r.dtype)
 assert(close(r:tolist(),{0.0,1.0,2.0,-1.0,4.0,0.5},2e-3),'half fmax values 240')
end
do -- half fmax 241
 local a=np.array({2.0,2.0,-3.0,-0.0,-0.0,-0.0},np.float16)
 local b=np.array({-3.0,0.5,-3.0,-1.0,2.0,1.0},np.float32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float32','half fmax dtype 241 '..r.dtype)
 assert(close(r:tolist(),{2.0,2.0,-3.0,-0.0,2.0,1.0},2e-3),'half fmax values 241')
end
do -- half fmax 242
 local a=np.array({-0.0,2.0,0.5,1.0,0.0,1.0},np.float16)
 local b=np.array({-3.0,-3.0,3.0,-3.0,-1.0,2.0},np.float32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float32','half fmax dtype 242 '..r.dtype)
 assert(close(r:tolist(),{-0.0,2.0,3.0,1.0,0.0,2.0},2e-3),'half fmax values 242')
end
do -- half fmax 243
 local a=np.array({4.0,-3.0,0.0,2.0,-3.0,4.0},np.float16)
 local b=np.array({-3,-1,1,1,-3,-1},np.int8)
 local r=np.fmax(a,b)
 assert(r.dtype=='float16','half fmax dtype 243 '..r.dtype)
 assert(close(r:tolist(),{4.0,-1.0,1.0,2.0,-3.0,4.0},2e-3),'half fmax values 243')
end
do -- half fmax 244
 local a=np.array({2.0,1.0,4.0,-3.0,-3.0,4.0},np.float16)
 local b=np.array({3,1,0,2,3,4},np.uint8)
 local r=np.fmax(a,b)
 assert(r.dtype=='float16','half fmax dtype 244 '..r.dtype)
 assert(close(r:tolist(),{3.0,1.0,4.0,2.0,3.0,4.0},2e-3),'half fmax values 244')
end
do -- half fmax 245
 local a=np.array({0.0,0.5,2.0,-0.0,0.5,-3.0},np.float16)
 local b=np.array({1.0,0.0,3.0,0.0,-3.0,3.0},np.float16)
 local r=np.fmax(a,b)
 assert(r.dtype=='float16','half fmax dtype 245 '..r.dtype)
 assert(close(r:tolist(),{1.0,0.5,3.0,-0.0,0.5,3.0},2e-3),'half fmax values 245')
end
do -- half fmax 246
 local a=np.array({1.0,2.0,0.0,0.5,2.0,0.5},np.float16)
 local b=np.array({2.0,-1.0,-1.0,-3.0,0.5,3.0},np.float32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float32','half fmax dtype 246 '..r.dtype)
 assert(close(r:tolist(),{2.0,2.0,0.0,0.5,2.0,3.0},2e-3),'half fmax values 246')
end
do -- half fmax 247
 local a=np.array({-3.0,-1.0,1.0,2.0,2.0,0.5},np.float16)
 local b=np.array({2.0,1.0,-3.0,1.0,0.0,3.0},np.float64)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','half fmax dtype 247 '..r.dtype)
 assert(close(r:tolist(),{2.0,1.0,1.0,2.0,2.0,3.0},2e-3),'half fmax values 247')
end
do -- half fmax 248
 local a=np.array({0.0,4.0,2.0,-3.0,2.0,-3.0},np.float16)
 local b=np.array({true,false,false,false,false,true},np.bool)
 local r=np.fmax(a,b)
 assert(r.dtype=='float16','half fmax dtype 248 '..r.dtype)
 assert(close(r:tolist(),{1.0,4.0,2.0,0.0,2.0,1.0},2e-3),'half fmax values 248')
end
do -- half fmax 249
 local a=np.array({-0.0,0.0,-0.0,-1.0,-0.0,2.0},np.float16)
 local b=np.array({2,0,1,1,0,0},np.int8)
 local r=np.fmax(a,b)
 assert(r.dtype=='float16','half fmax dtype 249 '..r.dtype)
 assert(close(r:tolist(),{2.0,0.0,1.0,1.0,-0.0,2.0},2e-3),'half fmax values 249')
end
do -- half fmax 250
 local a=np.array({-3.0,-0.0,2.0,0.0,1.0,2.0},np.float16)
 local b=np.array({false,false,true,false,false,true},np.bool)
 local r=np.fmax(a,b)
 assert(r.dtype=='float16','half fmax dtype 250 '..r.dtype)
 assert(close(r:tolist(),{0.0,-0.0,2.0,0.0,1.0,2.0},2e-3),'half fmax values 250')
end
do -- half fmax 251
 local a=np.array({-0.0,2.0,1.0,2.0,4.0,-3.0},np.float16)
 local b=np.array({-3,2,-1,1,2,-1},np.int8)
 local r=np.fmax(a,b)
 assert(r.dtype=='float16','half fmax dtype 251 '..r.dtype)
 assert(close(r:tolist(),{-0.0,2.0,1.0,2.0,4.0,-1.0},2e-3),'half fmax values 251')
end
do -- half fmax 252
 local a=np.array({4.0,-1.0,1.0,0.5,1.0,-3.0},np.float16)
 local b=np.array({0.5,3.0,-1.0,3.0,0.0,-1.0},np.float64)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','half fmax dtype 252 '..r.dtype)
 assert(close(r:tolist(),{4.0,3.0,1.0,3.0,1.0,-1.0},2e-3),'half fmax values 252')
end
do -- half fmax 253
 local a=np.array({0.5,4.0,0.5,-1.0,-3.0,-3.0},np.float16)
 local b=np.array({3.0,-3.0,3.0,-3.0,-1.0,0.5},np.float32)
 local r=np.fmax(a,b)
 assert(r.dtype=='float32','half fmax dtype 253 '..r.dtype)
 assert(close(r:tolist(),{3.0,4.0,3.0,-1.0,-1.0,0.5},2e-3),'half fmax values 253')
end
do -- half fmax 254
 local a=np.array({1.0,-0.0,-0.0,0.0,1.0,-1.0},np.float16)
 local b=np.array({false,false,true,false,false,true},np.bool)
 local r=np.fmax(a,b)
 assert(r.dtype=='float16','half fmax dtype 254 '..r.dtype)
 assert(close(r:tolist(),{1.0,-0.0,1.0,0.0,1.0,1.0},2e-3),'half fmax values 254')
end
do -- half fmax 255
 local a=np.array({-1.0,0.0,1.0,-1.0,-3.0,-0.0},np.float16)
 local b=np.array({3.0,-1.0,1.0,3.0,-3.0,-1.0},np.float64)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','half fmax dtype 255 '..r.dtype)
 assert(close(r:tolist(),{3.0,0.0,1.0,3.0,-3.0,-0.0},2e-3),'half fmax values 255')
end
do -- half fmax 256
 local a=np.array({-1.0,1.0,0.5,1.0,0.0,4.0},np.float16)
 local b=np.array({0,0,0,3,0,1},np.int8)
 local r=np.fmax(a,b)
 assert(r.dtype=='float16','half fmax dtype 256 '..r.dtype)
 assert(close(r:tolist(),{0.0,1.0,0.5,3.0,0.0,4.0},2e-3),'half fmax values 256')
end
do -- half fmax 257
 local a=np.array({1.0,1.0,-0.0,-0.0,-1.0,-0.0},np.float16)
 local b=np.array({0.5,2.0,0.0,3.0,-3.0,-3.0},np.float64)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','half fmax dtype 257 '..r.dtype)
 assert(close(r:tolist(),{1.0,2.0,-0.0,3.0,-1.0,-0.0},2e-3),'half fmax values 257')
end
do -- half fmax 258
 local a=np.array({1.0,-3.0,-0.0,0.0,4.0,-3.0},np.float16)
 local b=np.array({-1.0,1.0,-3.0,1.0,2.0,0.5},np.float64)
 local r=np.fmax(a,b)
 assert(r.dtype=='float64','half fmax dtype 258 '..r.dtype)
 assert(close(r:tolist(),{1.0,1.0,-0.0,1.0,4.0,0.5},2e-3),'half fmax values 258')
end
do -- half fmin 259
 local a=np.array({-3.0,1.0,-3.0,-3.0,0.0,-3.0},np.float16)
 local b=np.array({1.0,-3.0,-1.0,3.0,0.5,1.0},np.float16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float16','half fmin dtype 259 '..r.dtype)
 assert(close(r:tolist(),{-3.0,-3.0,-3.0,-3.0,0.0,-3.0},2e-3),'half fmin values 259')
end
do -- half fmin 260
 local a=np.array({0.5,-3.0,0.0,2.0,2.0,4.0},np.float16)
 local b=np.array({3,2,0,1,0,3},np.int8)
 local r=np.fmin(a,b)
 assert(r.dtype=='float16','half fmin dtype 260 '..r.dtype)
 assert(close(r:tolist(),{0.5,-3.0,0.0,1.0,0.0,3.0},2e-3),'half fmin values 260')
end
do -- half fmin 261
 local a=np.array({0.0,4.0,-0.0,1.0,1.0,1.0},np.float16)
 local b=np.array({1.0,-1.0,1.0,1.0,1.0,-3.0},np.float64)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','half fmin dtype 261 '..r.dtype)
 assert(close(r:tolist(),{0.0,-1.0,-0.0,1.0,1.0,-3.0},2e-3),'half fmin values 261')
end
do -- half fmin 262
 local a=np.array({0.0,1.0,0.5,4.0,2.0,2.0},np.float16)
 local b=np.array({1,2,2,3,1,0},np.uint8)
 local r=np.fmin(a,b)
 assert(r.dtype=='float16','half fmin dtype 262 '..r.dtype)
 assert(close(r:tolist(),{0.0,1.0,0.5,3.0,1.0,0.0},2e-3),'half fmin values 262')
end
do -- half fmin 263
 local a=np.array({2.0,-0.0,-0.0,4.0,2.0,4.0},np.float16)
 local b=np.array({false,true,false,false,false,false},np.bool)
 local r=np.fmin(a,b)
 assert(r.dtype=='float16','half fmin dtype 263 '..r.dtype)
 assert(close(r:tolist(),{0.0,-0.0,-0.0,0.0,0.0,0.0},2e-3),'half fmin values 263')
end
do -- half fmin 264
 local a=np.array({0.0,-0.0,0.5,-3.0,1.0,-1.0},np.float16)
 local b=np.array({0,1,-1,3,2,-3},np.int8)
 local r=np.fmin(a,b)
 assert(r.dtype=='float16','half fmin dtype 264 '..r.dtype)
 assert(close(r:tolist(),{0.0,-0.0,-1.0,-3.0,1.0,-3.0},2e-3),'half fmin values 264')
end
do -- half fmin 265
 local a=np.array({-0.0,1.0,2.0,-1.0,0.5,-0.0},np.float16)
 local b=np.array({3,2,2,1,3,1},np.uint16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float32','half fmin dtype 265 '..r.dtype)
 assert(close(r:tolist(),{-0.0,1.0,2.0,-1.0,0.5,-0.0},2e-3),'half fmin values 265')
end
do -- half fmin 266
 local a=np.array({1.0,0.0,-3.0,-1.0,4.0,0.5},np.float16)
 local b=np.array({2,4,0,2,0,0},np.uint16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float32','half fmin dtype 266 '..r.dtype)
 assert(close(r:tolist(),{1.0,0.0,-3.0,-1.0,0.0,0.0},2e-3),'half fmin values 266')
end
do -- half fmin 267
 local a=np.array({-1.0,4.0,-3.0,2.0,1.0,4.0},np.float16)
 local b=np.array({1,0,-3,0,3,2},np.int8)
 local r=np.fmin(a,b)
 assert(r.dtype=='float16','half fmin dtype 267 '..r.dtype)
 assert(close(r:tolist(),{-1.0,0.0,-3.0,0.0,1.0,2.0},2e-3),'half fmin values 267')
end
do -- half fmin 268
 local a=np.array({-3.0,0.0,0.5,0.0,-0.0,0.0},np.float16)
 local b=np.array({0,0,1,0,3,3},np.uint16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float32','half fmin dtype 268 '..r.dtype)
 assert(close(r:tolist(),{-3.0,0.0,0.5,0.0,-0.0,0.0},2e-3),'half fmin values 268')
end
do -- half fmin 269
 local a=np.array({-3.0,-0.0,0.0,4.0,-0.0,-1.0},np.float16)
 local b=np.array({1,4,2,3,4,2},np.uint16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float32','half fmin dtype 269 '..r.dtype)
 assert(close(r:tolist(),{-3.0,-0.0,0.0,3.0,-0.0,-1.0},2e-3),'half fmin values 269')
end
do -- half fmin 270
 local a=np.array({0.5,1.0,-0.0,-3.0,2.0,-3.0},np.float16)
 local b=np.array({-1.0,3.0,3.0,3.0,1.0,2.0},np.float64)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','half fmin dtype 270 '..r.dtype)
 assert(close(r:tolist(),{-1.0,1.0,-0.0,-3.0,1.0,-3.0},2e-3),'half fmin values 270')
end
do -- half fmin 271
 local a=np.array({1.0,1.0,2.0,-3.0,1.0,4.0},np.float16)
 local b=np.array({false,true,false,false,true,false},np.bool)
 local r=np.fmin(a,b)
 assert(r.dtype=='float16','half fmin dtype 271 '..r.dtype)
 assert(close(r:tolist(),{0.0,1.0,0.0,-3.0,1.0,0.0},2e-3),'half fmin values 271')
end
do -- half fmin 272
 local a=np.array({4.0,-1.0,4.0,2.0,0.5,0.5},np.float16)
 local b=np.array({2.0,0.5,0.5,0.5,0.0,1.0},np.float16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float16','half fmin dtype 272 '..r.dtype)
 assert(close(r:tolist(),{2.0,-1.0,0.5,0.5,0.0,0.5},2e-3),'half fmin values 272')
end
do -- half fmin 273
 local a=np.array({4.0,4.0,-3.0,4.0,4.0,0.5},np.float16)
 local b=np.array({1,0,1,0,-3,-1},np.int8)
 local r=np.fmin(a,b)
 assert(r.dtype=='float16','half fmin dtype 273 '..r.dtype)
 assert(close(r:tolist(),{1.0,0.0,-3.0,0.0,-3.0,-1.0},2e-3),'half fmin values 273')
end
do -- half fmin 274
 local a=np.array({-3.0,-0.0,-0.0,4.0,0.0,2.0},np.float16)
 local b=np.array({4,0,3,2,4,3},np.uint16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float32','half fmin dtype 274 '..r.dtype)
 assert(close(r:tolist(),{-3.0,0.0,-0.0,2.0,0.0,2.0},2e-3),'half fmin values 274')
end
do -- half fmin 275
 local a=np.array({0.0,4.0,-1.0,-1.0,0.0,1.0},np.float16)
 local b=np.array({0.0,1.0,-3.0,0.0,0.5,0.5},np.float16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float16','half fmin dtype 275 '..r.dtype)
 assert(close(r:tolist(),{0.0,1.0,-3.0,-1.0,0.0,0.5},2e-3),'half fmin values 275')
end
do -- half fmin 276
 local a=np.array({1.0,-0.0,0.0,4.0,-0.0,-3.0},np.float16)
 local b=np.array({0.0,-1.0,-3.0,-1.0,0.0,0.0},np.float32)
 local r=np.fmin(a,b)
 assert(r.dtype=='float32','half fmin dtype 276 '..r.dtype)
 assert(close(r:tolist(),{0.0,-1.0,-3.0,-1.0,0.0,-3.0},2e-3),'half fmin values 276')
end
do -- half fmin 277
 local a=np.array({-0.0,1.0,0.5,0.0,0.5,-0.0},np.float16)
 local b=np.array({0.5,0.5,2.0,0.5,-1.0,2.0},np.float64)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','half fmin dtype 277 '..r.dtype)
 assert(close(r:tolist(),{-0.0,0.5,0.5,0.0,-1.0,-0.0},2e-3),'half fmin values 277')
end
do -- half fmin 278
 local a=np.array({-0.0,0.0,-0.0,2.0,-0.0,1.0},np.float16)
 local b=np.array({3.0,3.0,0.5,1.0,0.0,-3.0},np.float32)
 local r=np.fmin(a,b)
 assert(r.dtype=='float32','half fmin dtype 278 '..r.dtype)
 assert(close(r:tolist(),{-0.0,0.0,-0.0,1.0,0.0,-3.0},2e-3),'half fmin values 278')
end
do -- half fmin 279
 local a=np.array({4.0,-0.0,0.0,1.0,4.0,-1.0},np.float16)
 local b=np.array({3,4,4,3,0,2},np.uint8)
 local r=np.fmin(a,b)
 assert(r.dtype=='float16','half fmin dtype 279 '..r.dtype)
 assert(close(r:tolist(),{3.0,-0.0,0.0,1.0,0.0,-1.0},2e-3),'half fmin values 279')
end
do -- half fmin 280
 local a=np.array({-0.0,1.0,-0.0,1.0,-1.0,4.0},np.float16)
 local b=np.array({-1.0,0.5,0.5,-3.0,1.0,-3.0},np.float16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float16','half fmin dtype 280 '..r.dtype)
 assert(close(r:tolist(),{-1.0,0.5,-0.0,-3.0,-1.0,-3.0},2e-3),'half fmin values 280')
end
do -- half fmin 281
 local a=np.array({4.0,4.0,-1.0,1.0,0.0,4.0},np.float16)
 local b=np.array({-3.0,-3.0,-3.0,3.0,-1.0,-3.0},np.float64)
 local r=np.fmin(a,b)
 assert(r.dtype=='float64','half fmin dtype 281 '..r.dtype)
 assert(close(r:tolist(),{-3.0,-3.0,-3.0,1.0,-1.0,-3.0},2e-3),'half fmin values 281')
end
do -- half fmin 282
 local a=np.array({-3.0,-1.0,4.0,0.0,0.5,1.0},np.float16)
 local b=np.array({2,3,4,1,2,2},np.uint16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float32','half fmin dtype 282 '..r.dtype)
 assert(close(r:tolist(),{-3.0,-1.0,4.0,0.0,0.5,1.0},2e-3),'half fmin values 282')
end
do -- half fmin 283
 local a=np.array({-3.0,0.0,0.0,1.0,2.0,2.0},np.float16)
 local b=np.array({-1.0,1.0,2.0,-3.0,0.5,0.0},np.float16)
 local r=np.fmin(a,b)
 assert(r.dtype=='float16','half fmin dtype 283 '..r.dtype)
 assert(close(r:tolist(),{-3.0,0.0,0.0,-3.0,0.5,0.0},2e-3),'half fmin values 283')
end
do -- half copysign 284
 local a=np.array({-0.0,-0.0,0.5,-1.0,0.0,-0.0},np.float16)
 local b=np.array({3,2,4,2,0,4},np.uint16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','half copysign dtype 284 '..r.dtype)
 assert(close(r:tolist(),{0.0,0.0,0.5,1.0,0.0,0.0},2e-3),'half copysign values 284')
end
do -- half copysign 285
 local a=np.array({1.0,1.0,1.0,2.0,4.0,4.0},np.float16)
 local b=np.array({4,0,0,1,4,3},np.uint16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','half copysign dtype 285 '..r.dtype)
 assert(close(r:tolist(),{1.0,1.0,1.0,2.0,4.0,4.0},2e-3),'half copysign values 285')
end
do -- half copysign 286
 local a=np.array({0.5,0.5,2.0,1.0,1.0,2.0},np.float16)
 local b=np.array({false,true,false,false,false,true},np.bool)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','half copysign dtype 286 '..r.dtype)
 assert(close(r:tolist(),{0.5,0.5,2.0,1.0,1.0,2.0},2e-3),'half copysign values 286')
end
do -- half copysign 287
 local a=np.array({0.5,-1.0,2.0,1.0,1.0,0.5},np.float16)
 local b=np.array({false,true,true,true,false,false},np.bool)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','half copysign dtype 287 '..r.dtype)
 assert(close(r:tolist(),{0.5,1.0,2.0,1.0,1.0,0.5},2e-3),'half copysign values 287')
end
do -- half copysign 288
 local a=np.array({-1.0,4.0,-0.0,4.0,0.0,-0.0},np.float16)
 local b=np.array({2,4,1,3,3,4},np.uint16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','half copysign dtype 288 '..r.dtype)
 assert(close(r:tolist(),{1.0,4.0,0.0,4.0,0.0,0.0},2e-3),'half copysign values 288')
end
do -- half copysign 289
 local a=np.array({0.0,0.5,2.0,-0.0,0.0,1.0},np.float16)
 local b=np.array({0.0,3.0,-3.0,-3.0,-3.0,1.0},np.float16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','half copysign dtype 289 '..r.dtype)
 assert(close(r:tolist(),{0.0,0.5,-2.0,-0.0,-0.0,1.0},2e-3),'half copysign values 289')
end
do -- half copysign 290
 local a=np.array({0.0,4.0,0.0,-3.0,-0.0,0.5},np.float16)
 local b=np.array({false,true,true,false,false,false},np.bool)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','half copysign dtype 290 '..r.dtype)
 assert(close(r:tolist(),{0.0,4.0,0.0,3.0,0.0,0.5},2e-3),'half copysign values 290')
end
do -- half copysign 291
 local a=np.array({-0.0,0.0,0.0,-1.0,-0.0,-0.0},np.float16)
 local b=np.array({-1.0,0.0,0.5,0.0,-1.0,-3.0},np.float16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','half copysign dtype 291 '..r.dtype)
 assert(close(r:tolist(),{-0.0,0.0,0.0,1.0,-0.0,-0.0},2e-3),'half copysign values 291')
end
do -- half copysign 292
 local a=np.array({0.0,1.0,4.0,-1.0,-3.0,1.0},np.float16)
 local b=np.array({2,2,0,0,3,0},np.uint8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','half copysign dtype 292 '..r.dtype)
 assert(close(r:tolist(),{0.0,1.0,4.0,1.0,3.0,1.0},2e-3),'half copysign values 292')
end
do -- half copysign 293
 local a=np.array({-0.0,-3.0,0.5,-3.0,-1.0,1.0},np.float16)
 local b=np.array({0.5,-1.0,2.0,2.0,-3.0,1.0},np.float32)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','half copysign dtype 293 '..r.dtype)
 assert(close(r:tolist(),{0.0,-3.0,0.5,3.0,-1.0,1.0},2e-3),'half copysign values 293')
end
do -- half copysign 294
 local a=np.array({0.5,1.0,2.0,0.5,-1.0,0.0},np.float16)
 local b=np.array({true,true,true,false,true,false},np.bool)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','half copysign dtype 294 '..r.dtype)
 assert(close(r:tolist(),{0.5,1.0,2.0,0.5,1.0,0.0},2e-3),'half copysign values 294')
end
do -- half copysign 295
 local a=np.array({-1.0,1.0,1.0,-3.0,-1.0,-1.0},np.float16)
 local b=np.array({true,false,true,true,true,true},np.bool)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','half copysign dtype 295 '..r.dtype)
 assert(close(r:tolist(),{1.0,1.0,1.0,3.0,1.0,1.0},2e-3),'half copysign values 295')
end
do -- half copysign 296
 local a=np.array({4.0,1.0,-3.0,0.0,-3.0,-0.0},np.float16)
 local b=np.array({-1.0,0.0,0.5,1.0,-1.0,0.5},np.float64)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','half copysign dtype 296 '..r.dtype)
 assert(close(r:tolist(),{-4.0,1.0,3.0,0.0,-3.0,0.0},2e-3),'half copysign values 296')
end
do -- half copysign 297
 local a=np.array({0.0,-1.0,-3.0,2.0,-1.0,-0.0},np.float16)
 local b=np.array({-1.0,2.0,-1.0,-1.0,2.0,0.5},np.float32)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','half copysign dtype 297 '..r.dtype)
 assert(close(r:tolist(),{-0.0,1.0,-3.0,-2.0,1.0,0.0},2e-3),'half copysign values 297')
end
do -- half copysign 298
 local a=np.array({2.0,-1.0,-3.0,0.5,1.0,1.0},np.float16)
 local b=np.array({-1,0,1,3,0,-3},np.int16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','half copysign dtype 298 '..r.dtype)
 assert(close(r:tolist(),{-2.0,1.0,3.0,0.5,1.0,-1.0},2e-3),'half copysign values 298')
end
do -- half copysign 299
 local a=np.array({-3.0,4.0,-1.0,1.0,1.0,0.5},np.float16)
 local b=np.array({1,2,4,0,1,3},np.uint8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','half copysign dtype 299 '..r.dtype)
 assert(close(r:tolist(),{3.0,4.0,1.0,1.0,1.0,0.5},2e-3),'half copysign values 299')
end
do -- half copysign 300
 local a=np.array({-3.0,0.0,-0.0,1.0,-0.0,2.0},np.float16)
 local b=np.array({3,3,2,1,2,3},np.uint16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','half copysign dtype 300 '..r.dtype)
 assert(close(r:tolist(),{3.0,0.0,0.0,1.0,0.0,2.0},2e-3),'half copysign values 300')
end
do -- half copysign 301
 local a=np.array({2.0,0.5,-0.0,-1.0,4.0,1.0},np.float16)
 local b=np.array({-1.0,0.0,0.0,-1.0,0.0,0.0},np.float32)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','half copysign dtype 301 '..r.dtype)
 assert(close(r:tolist(),{-2.0,0.5,0.0,-1.0,4.0,1.0},2e-3),'half copysign values 301')
end
do -- half copysign 302
 local a=np.array({-3.0,1.0,-3.0,-1.0,0.5,2.0},np.float16)
 local b=np.array({2,-3,-3,3,1,1},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','half copysign dtype 302 '..r.dtype)
 assert(close(r:tolist(),{3.0,-1.0,-3.0,1.0,0.5,2.0},2e-3),'half copysign values 302')
end
do -- half copysign 303
 local a=np.array({2.0,0.0,0.0,-1.0,-0.0,2.0},np.float16)
 local b=np.array({-3,0,-3,3,3,0},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','half copysign dtype 303 '..r.dtype)
 assert(close(r:tolist(),{-2.0,0.0,-0.0,1.0,0.0,2.0},2e-3),'half copysign values 303')
end
do -- half copysign 304
 local a=np.array({-1.0,-0.0,1.0,1.0,0.0,0.5},np.float16)
 local b=np.array({3,3,2,2,2,0},np.uint8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','half copysign dtype 304 '..r.dtype)
 assert(close(r:tolist(),{1.0,0.0,1.0,1.0,0.0,0.5},2e-3),'half copysign values 304')
end
do -- half copysign 305
 local a=np.array({-0.0,1.0,0.5,-1.0,-1.0,-3.0},np.float16)
 local b=np.array({3,-3,-3,1,2,2},np.int8)
 local r=np.copysign(a,b)
 assert(r.dtype=='float16','half copysign dtype 305 '..r.dtype)
 assert(close(r:tolist(),{0.0,-1.0,-0.5,1.0,1.0,3.0},2e-3),'half copysign values 305')
end
do -- half copysign 306
 local a=np.array({-0.0,0.0,-0.0,2.0,-1.0,0.0},np.float16)
 local b=np.array({0.5,3.0,-1.0,-1.0,0.5,-3.0},np.float32)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','half copysign dtype 306 '..r.dtype)
 assert(close(r:tolist(),{0.0,0.0,-0.0,-2.0,1.0,-0.0},2e-3),'half copysign values 306')
end
do -- half copysign 307
 local a=np.array({-1.0,-0.0,4.0,1.0,-3.0,1.0},np.float16)
 local b=np.array({2,3,2,2,-1,0},np.int16)
 local r=np.copysign(a,b)
 assert(r.dtype=='float32','half copysign dtype 307 '..r.dtype)
 assert(close(r:tolist(),{1.0,0.0,4.0,1.0,-3.0,1.0},2e-3),'half copysign values 307')
end
do -- half copysign 308
 local a=np.array({0.5,2.0,-3.0,0.5,-0.0,1.0},np.float16)
 local b=np.array({0.5,1.0,0.0,-1.0,-3.0,2.0},np.float64)
 local r=np.copysign(a,b)
 assert(r.dtype=='float64','half copysign dtype 308 '..r.dtype)
 assert(close(r:tolist(),{0.5,2.0,3.0,-0.5,-0.0,1.0},2e-3),'half copysign values 308')
end
do local a=np.array({-math.huge,-2.0,-0.0,0.0,1.0,math.huge,(0/0)},np.float16); local b=np.array({-math.huge,-1.0,0.0,-0.0,2.0,math.huge,(0/0)},np.float16); local r=np.equal(a,b); assert(eq(r:tolist(),{true,false,true,true,false,true,false}),'half equal') end
do local a=np.array({-math.huge,-2.0,-0.0,0.0,1.0,math.huge,(0/0)},np.float16); local b=np.array({-math.huge,-1.0,0.0,-0.0,2.0,math.huge,(0/0)},np.float16); local r=np.not_equal(a,b); assert(eq(r:tolist(),{false,true,false,false,true,false,true}),'half not_equal') end
do local a=np.array({-math.huge,-2.0,-0.0,0.0,1.0,math.huge,(0/0)},np.float16); local b=np.array({-math.huge,-1.0,0.0,-0.0,2.0,math.huge,(0/0)},np.float16); local r=np.less(a,b); assert(eq(r:tolist(),{false,true,false,false,true,false,false}),'half less') end
do local a=np.array({-math.huge,-2.0,-0.0,0.0,1.0,math.huge,(0/0)},np.float16); local b=np.array({-math.huge,-1.0,0.0,-0.0,2.0,math.huge,(0/0)},np.float16); local r=np.less_equal(a,b); assert(eq(r:tolist(),{true,true,true,true,true,true,false}),'half less_equal') end
do local a=np.array({-math.huge,-2.0,-0.0,0.0,1.0,math.huge,(0/0)},np.float16); local b=np.array({-math.huge,-1.0,0.0,-0.0,2.0,math.huge,(0/0)},np.float16); local r=np.greater(a,b); assert(eq(r:tolist(),{false,false,false,false,false,false,false}),'half greater') end
do local a=np.array({-math.huge,-2.0,-0.0,0.0,1.0,math.huge,(0/0)},np.float16); local b=np.array({-math.huge,-1.0,0.0,-0.0,2.0,math.huge,(0/0)},np.float16); local r=np.greater_equal(a,b); assert(eq(r:tolist(),{true,false,true,true,false,true,false}),'half greater_equal') end
do local a=np.array({-math.huge,-2.0,-0.0,0.0,1.0,math.huge,(0/0)},np.float16); local b=np.array({-math.huge,-1.0,0.0,-0.0,2.0,math.huge,(0/0)},np.float16); local r=np.logical_and(a,b); assert(eq(r:tolist(),{true,true,false,false,true,true,true}),'half logical_and') end
do local a=np.array({-math.huge,-2.0,-0.0,0.0,1.0,math.huge,(0/0)},np.float16); local b=np.array({-math.huge,-1.0,0.0,-0.0,2.0,math.huge,(0/0)},np.float16); local r=np.logical_or(a,b); assert(eq(r:tolist(),{true,true,false,false,true,true,true}),'half logical_or') end
do local a=np.array({-math.huge,-2.0,-0.0,0.0,1.0,math.huge,(0/0)},np.float16); local b=np.array({-math.huge,-1.0,0.0,-0.0,2.0,math.huge,(0/0)},np.float16); local r=np.logical_xor(a,b); assert(eq(r:tolist(),{false,false,false,false,false,false,false}),'half logical_xor') end
do local a=np.array({-math.huge,-4.0,-1.0,-0.0,0.0,0.25,1.0,4.0,math.huge,(0/0)},np.float16); local r=np.negative(a); assert(r.dtype=='float16','half negative dtype'); assert(close(r:tolist(),{math.huge,4.0,1.0,0.0,-0.0,-0.25,-1.0,-4.0,-math.huge,(0/0)},2e-3),'half negative') end
do local a=np.array({-math.huge,-4.0,-1.0,-0.0,0.0,0.25,1.0,4.0,math.huge,(0/0)},np.float16); local r=np.absolute(a); assert(r.dtype=='float16','half absolute dtype'); assert(close(r:tolist(),{math.huge,4.0,1.0,0.0,0.0,0.25,1.0,4.0,math.huge,(0/0)},2e-3),'half absolute') end
do local a=np.array({-math.huge,-4.0,-1.0,-0.0,0.0,0.25,1.0,4.0,math.huge,(0/0)},np.float16); local r=np.positive(a); assert(r.dtype=='float16','half positive dtype'); assert(close(r:tolist(),{-math.huge,-4.0,-1.0,-0.0,0.0,0.25,1.0,4.0,math.huge,(0/0)},2e-3),'half positive') end
do local a=np.array({-math.huge,-4.0,-1.0,-0.0,0.0,0.25,1.0,4.0,math.huge,(0/0)},np.float16); local r=np.sign(a); assert(r.dtype=='float16','half sign dtype'); assert(close(r:tolist(),{-1.0,-1.0,-1.0,0.0,0.0,1.0,1.0,1.0,1.0,(0/0)},2e-3),'half sign') end
do local a=np.array({-math.huge,-4.0,-1.0,-0.0,0.0,0.25,1.0,4.0,math.huge,(0/0)},np.float16); local r=np.logical_not(a); assert(r.dtype=='bool','half logical_not dtype'); assert(eq(r:tolist(),{false,false,false,true,true,false,false,false,false,false}),'half logical_not') end
do local a=np.array({-math.huge,-4.0,-1.0,-0.0,0.0,0.25,1.0,4.0,math.huge,(0/0)},np.float16); local r=np.isnan(a); assert(r.dtype=='bool','half isnan dtype'); assert(eq(r:tolist(),{false,false,false,false,false,false,false,false,false,true}),'half isnan') end
do local a=np.array({-math.huge,-4.0,-1.0,-0.0,0.0,0.25,1.0,4.0,math.huge,(0/0)},np.float16); local r=np.isinf(a); assert(r.dtype=='bool','half isinf dtype'); assert(eq(r:tolist(),{true,false,false,false,false,false,false,false,true,false}),'half isinf') end
do local a=np.array({-math.huge,-4.0,-1.0,-0.0,0.0,0.25,1.0,4.0,math.huge,(0/0)},np.float16); local r=np.isfinite(a); assert(r.dtype=='bool','half isfinite dtype'); assert(eq(r:tolist(),{false,true,true,true,true,true,true,true,false,false}),'half isfinite') end
do local a=np.array({-math.huge,-4.0,-1.0,-0.0,0.0,0.25,1.0,4.0,math.huge},np.float16); local r=np.signbit(a); assert(r.dtype=='bool','half signbit dtype'); assert(eq(r:tolist(),{true,true,true,true,false,false,false,false,false}),'half signbit') end
do local a=np.array({-math.huge,-4.0,-1.0,-0.0,0.0,0.25,1.0,4.0,math.huge,(0/0)},np.float16); local r=np.sqrt(a); assert(r.dtype=='float16','half sqrt dtype'); assert(close(r:tolist(),{(0/0),(0/0),(0/0),-0.0,0.0,0.5,1.0,2.0,math.huge,(0/0)},2e-3),'half sqrt') end
do local a=np.array({-math.huge,-4.0,-1.0,-0.0,0.0,0.25,1.0,4.0,math.huge,(0/0)},np.float16); local r=np.exp(a); assert(r.dtype=='float16','half exp dtype'); assert(close(r:tolist(),{0.0,0.018310546875,0.367919921875,1.0,1.0,1.2841796875,2.71875,54.59375,math.huge,(0/0)},2e-3),'half exp') end
do local a=np.array({-math.huge,-4.0,-1.0,-0.0,0.0,0.25,1.0,4.0,math.huge,(0/0)},np.float16); local r=np.log(a); assert(r.dtype=='float16','half log dtype'); assert(close(r:tolist(),{(0/0),(0/0),(0/0),-math.huge,-math.huge,-1.38671875,0.0,1.38671875,math.huge,(0/0)},2e-3),'half log') end
do local a=np.array({-math.huge,-4.0,-1.0,-0.0,0.0,0.25,1.0,4.0,math.huge,(0/0)},np.float16); local r=np.sin(a); assert(r.dtype=='float16','half sin dtype'); assert(close(r:tolist(),{(0/0),0.7568359375,-0.84130859375,-0.0,0.0,0.2474365234375,0.84130859375,-0.7568359375,(0/0),(0/0)},2e-3),'half sin') end
do local a=np.array({-math.huge,-4.0,-1.0,-0.0,0.0,0.25,1.0,4.0,math.huge,(0/0)},np.float16); local r=np.cos(a); assert(r.dtype=='float16','half cos dtype'); assert(close(r:tolist(),{(0/0),-0.65380859375,0.54052734375,1.0,1.0,0.96875,0.54052734375,-0.65380859375,(0/0),(0/0)},2e-3),'half cos') end
do local a=np.array({-math.huge,-4.0,-1.0,-0.0,0.0,0.25,1.0,4.0,math.huge,(0/0)},np.float16); local r=np.tan(a); assert(r.dtype=='float16','half tan dtype'); assert(close(r:tolist(),{(0/0),-1.158203125,-1.5576171875,-0.0,0.0,0.25537109375,1.5576171875,1.158203125,(0/0),(0/0)},2e-3),'half tan') end
do
 local a=np.array({0.25,1.0,4.0,9.0},np.float16)
 local b=np.array({2.0,3.0,4.0,5.0},np.float16)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.ones({4},np.float16)*7
 local r=np.add(a,b,{out=o,where=m})
 assert(r==o,'half out identity')
 assert(close(o:tolist(),{2.25,7.0,8.0,7.0},2e-3),'half outwhere add')
end
do
 local a=np.array({0.25,1.0,4.0,9.0},np.float16)
 local b=np.array({2.0,3.0,4.0,5.0},np.float16)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.ones({4},np.float16)*7
 local r=np.multiply(a,b,{out=o,where=m})
 assert(r==o,'half out identity')
 assert(close(o:tolist(),{0.5,7.0,16.0,7.0},2e-3),'half outwhere multiply')
end
do
 local a=np.array({0.25,1.0,4.0,9.0},np.float16)
 local b=np.array({2.0,3.0,4.0,5.0},np.float16)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.ones({4},np.float16)*7
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'half out identity')
 assert(close(o:tolist(),{1.2841796875,7.0,54.59375,7.0},2e-3),'half outwhere exp')
end
do
 local a=np.array({0.25,1.0,4.0,9.0},np.float16)
 local b=np.array({2.0,3.0,4.0,5.0},np.float16)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.ones({4},np.float16)*7
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'half out identity')
 assert(close(o:tolist(),{0.5,7.0,2.0,7.0},2e-3),'half outwhere sqrt')
end
do
 local a=np.array({0.25,1.0,4.0,9.0},np.float16)
 local b=np.array({2.0,3.0,4.0,5.0},np.float16)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.ones({4},np.float16)*7
 local r=np.maximum(a,b,{out=o,where=m})
 assert(r==o,'half out identity')
 assert(close(o:tolist(),{2.0,7.0,4.0,7.0},2e-3),'half outwhere maximum')
end
do local a=np.array({{1.0,-1.0,2.0,0.25,-1.0},{2.0,0.0,-0.5,-2.0,0.0}},np.float16); local r=np.sum(a,1); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{3.0,-1.0,1.5,-1.75,-1.0},2e-3),'half sum 338') end
do local a=np.array({{1.0,-1.0,2.0,0.25,-1.0},{2.0,0.0,-0.5,-2.0,0.0}},np.float16); local r=np.prod(a,1); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{2.0,-0.0,-1.0,-0.5,-0.0},2e-3),'half prod 339') end
do local a=np.array({{1.0,-1.0,2.0,0.25,-1.0},{2.0,0.0,-0.5,-2.0,0.0}},np.float16); local r=np.mean(a,1); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{1.5,-0.5,0.75,-0.875,-0.5},2e-3),'half mean 340') end
do local a=np.array({{{1.0,0.0,2.0,-1.0},{1.0,-0.5,-2.0,-1.0},{3.0,-1.0,3.0,3.0}},{{3.0,2.0,-0.5,-2.0},{2.0,0.25,0.0,-1.0},{-1.0,1.0,-1.0,3.0}}},np.float16); local r=np.sum(a,2); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{5.0,-1.5,3.0,1.0},{4.0,3.25,-1.5,0.0}},2e-3),'half sum 341') end
do local a=np.array({{{1.0,0.0,2.0,-1.0},{1.0,-0.5,-2.0,-1.0},{3.0,-1.0,3.0,3.0}},{{3.0,2.0,-0.5,-2.0},{2.0,0.25,0.0,-1.0},{-1.0,1.0,-1.0,3.0}}},np.float16); local r=np.prod(a,2); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{3.0,0.0,-12.0,3.0},{-6.0,0.5,0.0,6.0}},2e-3),'half prod 342') end
do local a=np.array({{{1.0,0.0,2.0,-1.0},{1.0,-0.5,-2.0,-1.0},{3.0,-1.0,3.0,3.0}},{{3.0,2.0,-0.5,-2.0},{2.0,0.25,0.0,-1.0},{-1.0,1.0,-1.0,3.0}}},np.float16); local r=np.mean(a,2); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{1.6669921875,-0.5,1.0,0.333251953125},{1.3330078125,1.0830078125,-0.5,0.0}},2e-3),'half mean 343') end
do local a=np.array({{{-1.0,2.0,0.0,1.0},{3.0,-2.0,0.25,-0.5},{-1.0,-2.0,0.25,1.0}},{{-0.5,2.0,1.0,-0.5},{2.0,2.0,-0.5,1.0},{2.0,0.0,-1.0,0.25}}},np.float16); local r=np.sum(a,2); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{1.0,-2.0,0.5,1.5},{3.5,4.0,-0.5,0.75}},2e-3),'half sum 344') end
do local a=np.array({{{-1.0,2.0,0.0,1.0},{3.0,-2.0,0.25,-0.5},{-1.0,-2.0,0.25,1.0}},{{-0.5,2.0,1.0,-0.5},{2.0,2.0,-0.5,1.0},{2.0,0.0,-1.0,0.25}}},np.float16); local r=np.prod(a,2); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{3.0,8.0,0.0,-0.5},{-2.0,0.0,0.5,-0.125}},2e-3),'half prod 345') end
do local a=np.array({{{-1.0,2.0,0.0,1.0},{3.0,-2.0,0.25,-0.5},{-1.0,-2.0,0.25,1.0}},{{-0.5,2.0,1.0,-0.5},{2.0,2.0,-0.5,1.0},{2.0,0.0,-1.0,0.25}}},np.float16); local r=np.mean(a,2); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{0.333251953125,-0.66650390625,0.1666259765625,0.5},{1.1669921875,1.3330078125,-0.1666259765625,0.25}},2e-3),'half mean 346') end
do local a=np.array({{0.25,2.0,0.0,0.0,3.0},{1.0,-2.0,1.0,3.0,0.25}},np.float16); local r=np.sum(a,1); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{1.25,0.0,1.0,3.0,3.25},2e-3),'half sum 347') end
do local a=np.array({{0.25,2.0,0.0,0.0,3.0},{1.0,-2.0,1.0,3.0,0.25}},np.float16); local r=np.prod(a,1); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{0.25,-4.0,0.0,0.0,0.75},2e-3),'half prod 348') end
do local a=np.array({{0.25,2.0,0.0,0.0,3.0},{1.0,-2.0,1.0,3.0,0.25}},np.float16); local r=np.mean(a,1); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{0.625,0.0,0.5,1.5,1.625},2e-3),'half mean 349') end
do local a=np.array({{{-0.5,2.0,-2.0,1.0},{2.0,3.0,2.0,2.0},{-0.5,1.0,-1.0,-1.0}},{{2.0,0.25,3.0,-0.5},{2.0,0.25,0.0,-1.0},{2.0,1.0,3.0,-2.0}}},np.float16); local r=np.sum(a,3); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{0.5,9.0,-1.5},{4.75,1.25,4.0}},2e-3),'half sum 350') end
do local a=np.array({{{-0.5,2.0,-2.0,1.0},{2.0,3.0,2.0,2.0},{-0.5,1.0,-1.0,-1.0}},{{2.0,0.25,3.0,-0.5},{2.0,0.25,0.0,-1.0},{2.0,1.0,3.0,-2.0}}},np.float16); local r=np.prod(a,3); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{2.0,24.0,-0.5},{-0.75,-0.0,-12.0}},2e-3),'half prod 351') end
do local a=np.array({{{-0.5,2.0,-2.0,1.0},{2.0,3.0,2.0,2.0},{-0.5,1.0,-1.0,-1.0}},{{2.0,0.25,3.0,-0.5},{2.0,0.25,0.0,-1.0},{2.0,1.0,3.0,-2.0}}},np.float16); local r=np.mean(a,3); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{0.125,2.25,-0.375},{1.1875,0.3125,1.0}},2e-3),'half mean 352') end
do local a=np.array({3.0,0.0,-1.0,0.25,2.0,2.0,-1.0},np.float16); local r=np.sum(a,1); assert(close(r,5.25,2e-3),'half sum scalar 353') end
do local a=np.array({3.0,0.0,-1.0,0.25,2.0,2.0,-1.0},np.float16); local r=np.prod(a,1); assert(close(r,0.0,2e-3),'half prod scalar 354') end
do local a=np.array({3.0,0.0,-1.0,0.25,2.0,2.0,-1.0},np.float16); local r=np.mean(a,1); assert(close(r,0.75,2e-3),'half mean scalar 355') end
do local a=np.array({{0.0,-0.5,-2.0,3.0,3.0},{2.0,2.0,0.0,3.0,0.25}},np.float16); local r=np.sum(a,2); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{3.5,7.25},2e-3),'half sum 356') end
do local a=np.array({{0.0,-0.5,-2.0,3.0,3.0},{2.0,2.0,0.0,3.0,0.25}},np.float16); local r=np.prod(a,2); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{0.0,0.0},2e-3),'half prod 357') end
do local a=np.array({{0.0,-0.5,-2.0,3.0,3.0},{2.0,2.0,0.0,3.0,0.25}},np.float16); local r=np.mean(a,2); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{0.7001953125,1.4501953125},2e-3),'half mean 358') end
do local a=np.array({{-2.0,2.0,-1.0,-1.0,0.25},{3.0,-1.0,1.0,-0.5,-0.5}},np.float16); local r=np.sum(a,1); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{1.0,1.0,0.0,-1.5,-0.25},2e-3),'half sum 359') end
do local a=np.array({{-2.0,2.0,-1.0,-1.0,0.25},{3.0,-1.0,1.0,-0.5,-0.5}},np.float16); local r=np.prod(a,1); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{-6.0,-2.0,-1.0,0.5,-0.125},2e-3),'half prod 360') end
do local a=np.array({{-2.0,2.0,-1.0,-1.0,0.25},{3.0,-1.0,1.0,-0.5,-0.5}},np.float16); local r=np.mean(a,1); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{0.5,0.5,0.0,-0.75,-0.125},2e-3),'half mean 361') end
do local a=np.array({-0.5,-2.0,-1.0,0.0,3.0,-0.5,0.0},np.float16); local r=np.sum(a,1); assert(close(r,-1.0,2e-3),'half sum scalar 362') end
do local a=np.array({-0.5,-2.0,-1.0,0.0,3.0,-0.5,0.0},np.float16); local r=np.prod(a,1); assert(close(r,0.0,2e-3),'half prod scalar 363') end
do local a=np.array({-0.5,-2.0,-1.0,0.0,3.0,-0.5,0.0},np.float16); local r=np.mean(a,1); assert(close(r,-0.142822265625,2e-3),'half mean scalar 364') end
do local a=np.array({{-1.0,-2.0,-2.0,-1.0,-0.5},{-1.0,0.0,3.0,0.25,-0.5}},np.float16); local r=np.sum(a,2); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{-6.5,1.75},2e-3),'half sum 365') end
do local a=np.array({{-1.0,-2.0,-2.0,-1.0,-0.5},{-1.0,0.0,3.0,0.25,-0.5}},np.float16); local r=np.prod(a,2); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{-2.0,0.0},2e-3),'half prod 366') end
do local a=np.array({{-1.0,-2.0,-2.0,-1.0,-0.5},{-1.0,0.0,3.0,0.25,-0.5}},np.float16); local r=np.mean(a,2); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{-1.2998046875,0.35009765625},2e-3),'half mean 367') end
do local a=np.array({{{2.0,1.0,2.0,0.25},{2.0,-1.0,-2.0,-2.0},{0.25,0.0,1.0,1.0}},{{1.0,-2.0,2.0,3.0},{1.0,2.0,-1.0,1.0},{2.0,0.25,2.0,0.25}}},np.float16); local r=np.sum(a,2); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{4.25,0.0,1.0,-0.75},{4.0,0.25,3.0,4.25}},2e-3),'half sum 368') end
do local a=np.array({{{2.0,1.0,2.0,0.25},{2.0,-1.0,-2.0,-2.0},{0.25,0.0,1.0,1.0}},{{1.0,-2.0,2.0,3.0},{1.0,2.0,-1.0,1.0},{2.0,0.25,2.0,0.25}}},np.float16); local r=np.prod(a,2); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{1.0,-0.0,-4.0,-0.5},{2.0,-1.0,-4.0,0.75}},2e-3),'half prod 369') end
do local a=np.array({{{2.0,1.0,2.0,0.25},{2.0,-1.0,-2.0,-2.0},{0.25,0.0,1.0,1.0}},{{1.0,-2.0,2.0,3.0},{1.0,2.0,-1.0,1.0},{2.0,0.25,2.0,0.25}}},np.float16); local r=np.mean(a,2); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{1.4169921875,0.0,0.333251953125,-0.25},{1.3330078125,0.08331298828125,1.0,1.4169921875}},2e-3),'half mean 370') end
do local a=np.array({{{-0.5,-2.0,1.0,0.25},{3.0,0.0,-2.0,-1.0},{-1.0,-2.0,-2.0,-0.5}},{{1.0,-0.5,0.25,-2.0},{0.25,-1.0,1.0,-0.5},{3.0,2.0,-0.5,-0.5}}},np.float16); local r=np.sum(a,2); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{1.5,-4.0,-3.0,-1.25},{4.25,0.5,0.75,-3.0}},2e-3),'half sum 371') end
do local a=np.array({{{-0.5,-2.0,1.0,0.25},{3.0,0.0,-2.0,-1.0},{-1.0,-2.0,-2.0,-0.5}},{{1.0,-0.5,0.25,-2.0},{0.25,-1.0,1.0,-0.5},{3.0,2.0,-0.5,-0.5}}},np.float16); local r=np.prod(a,2); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{1.5,0.0,4.0,0.125},{0.75,1.0,-0.125,-0.5}},2e-3),'half prod 372') end
do local a=np.array({{{-0.5,-2.0,1.0,0.25},{3.0,0.0,-2.0,-1.0},{-1.0,-2.0,-2.0,-0.5}},{{1.0,-0.5,0.25,-2.0},{0.25,-1.0,1.0,-0.5},{3.0,2.0,-0.5,-0.5}}},np.float16); local r=np.mean(a,2); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{0.5,-1.3330078125,-1.0,-0.416748046875},{1.4169921875,0.1666259765625,0.25,-1.0}},2e-3),'half mean 373') end
do local a=np.array({1.0,1.0,1.0,3.0,0.25,0.25,3.0},np.float16); local r=np.sum(a,1); assert(close(r,9.5,2e-3),'half sum scalar 374') end
do local a=np.array({1.0,1.0,1.0,3.0,0.25,0.25,3.0},np.float16); local r=np.prod(a,1); assert(close(r,0.5625,2e-3),'half prod scalar 375') end
do local a=np.array({1.0,1.0,1.0,3.0,0.25,0.25,3.0},np.float16); local r=np.mean(a,1); assert(close(r,1.357421875,2e-3),'half mean scalar 376') end
do local a=np.array({{-2.0,3.0,0.0,-0.5,-2.0},{0.25,2.0,-0.5,-0.5,-2.0}},np.float16); local r=np.sum(a,2); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{-1.5,-0.75},2e-3),'half sum 377') end
do local a=np.array({{-2.0,3.0,0.0,-0.5,-2.0},{0.25,2.0,-0.5,-0.5,-2.0}},np.float16); local r=np.prod(a,2); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{-0.0,-0.25},2e-3),'half prod 378') end
do local a=np.array({{-2.0,3.0,0.0,-0.5,-2.0},{0.25,2.0,-0.5,-0.5,-2.0}},np.float16); local r=np.mean(a,2); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{-0.300048828125,-0.1500244140625},2e-3),'half mean 379') end
do local a=np.array({{{2.0,2.0,-0.5,-2.0},{2.0,0.25,-0.5,2.0},{0.0,1.0,-0.5,1.0}},{{-2.0,-1.0,-0.5,-2.0},{0.25,-2.0,-2.0,0.25},{1.0,0.25,-0.5,1.0}}},np.float16); local r=np.sum(a,1); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{0.0,1.0,-1.0,-4.0},{2.25,-1.75,-2.5,2.25},{1.0,1.25,-1.0,2.0}},2e-3),'half sum 380') end
do local a=np.array({{{2.0,2.0,-0.5,-2.0},{2.0,0.25,-0.5,2.0},{0.0,1.0,-0.5,1.0}},{{-2.0,-1.0,-0.5,-2.0},{0.25,-2.0,-2.0,0.25},{1.0,0.25,-0.5,1.0}}},np.float16); local r=np.prod(a,1); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{-4.0,-2.0,0.25,4.0},{0.5,-0.5,1.0,0.5},{0.0,0.25,0.25,1.0}},2e-3),'half prod 381') end
do local a=np.array({{{2.0,2.0,-0.5,-2.0},{2.0,0.25,-0.5,2.0},{0.0,1.0,-0.5,1.0}},{{-2.0,-1.0,-0.5,-2.0},{0.25,-2.0,-2.0,0.25},{1.0,0.25,-0.5,1.0}}},np.float16); local r=np.mean(a,1); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{0.0,0.5,-0.5,-2.0},{1.125,-0.875,-1.25,1.125},{0.5,0.625,-0.5,1.0}},2e-3),'half mean 382') end
do local a=np.array({{{-0.5,-2.0,-2.0,1.0},{-1.0,1.0,1.0,-2.0},{0.25,0.25,0.0,-0.5}},{{0.25,-1.0,0.25,-1.0},{0.25,2.0,-1.0,0.0},{3.0,0.0,0.25,-2.0}}},np.float16); local r=np.sum(a,2); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{-1.25,-0.75,-1.0,-1.5},{3.5,1.0,-0.5,-3.0}},2e-3),'half sum 383') end
do local a=np.array({{{-0.5,-2.0,-2.0,1.0},{-1.0,1.0,1.0,-2.0},{0.25,0.25,0.0,-0.5}},{{0.25,-1.0,0.25,-1.0},{0.25,2.0,-1.0,0.0},{3.0,0.0,0.25,-2.0}}},np.float16); local r=np.prod(a,2); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{0.125,-0.5,-0.0,1.0},{0.1875,-0.0,-0.0625,0.0}},2e-3),'half prod 384') end
do local a=np.array({{{-0.5,-2.0,-2.0,1.0},{-1.0,1.0,1.0,-2.0},{0.25,0.25,0.0,-0.5}},{{0.25,-1.0,0.25,-1.0},{0.25,2.0,-1.0,0.0},{3.0,0.0,0.25,-2.0}}},np.float16); local r=np.mean(a,2); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{-0.416748046875,-0.25,-0.333251953125,-0.5},{1.1669921875,0.333251953125,-0.1666259765625,-1.0}},2e-3),'half mean 385') end
do local a=np.array({{2.0,1.0,-1.0,-0.5,3.0},{0.25,-1.0,0.25,0.0,-1.0}},np.float16); local r=np.sum(a,2); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{4.5,-1.5},2e-3),'half sum 386') end
do local a=np.array({{2.0,1.0,-1.0,-0.5,3.0},{0.25,-1.0,0.25,0.0,-1.0}},np.float16); local r=np.prod(a,2); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{3.0,0.0},2e-3),'half prod 387') end
do local a=np.array({{2.0,1.0,-1.0,-0.5,3.0},{0.25,-1.0,0.25,0.0,-1.0}},np.float16); local r=np.mean(a,2); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{0.89990234375,-0.300048828125},2e-3),'half mean 388') end
do local a=np.array({0.0,-0.5,3.0,-1.0,0.25,0.0,-1.0},np.float16); local r=np.sum(a,1); assert(close(r,0.75,2e-3),'half sum scalar 389') end
do local a=np.array({0.0,-0.5,3.0,-1.0,0.25,0.0,-1.0},np.float16); local r=np.prod(a,1); assert(close(r,-0.0,2e-3),'half prod scalar 390') end
do local a=np.array({0.0,-0.5,3.0,-1.0,0.25,0.0,-1.0},np.float16); local r=np.mean(a,1); assert(close(r,0.10711669921875,2e-3),'half mean scalar 391') end
do local a=np.array({-1.0,-1.0,3.0,3.0,-2.0,1.0,-2.0},np.float16); local r=np.sum(a,1); assert(close(r,1.0,2e-3),'half sum scalar 392') end
do local a=np.array({-1.0,-1.0,3.0,3.0,-2.0,1.0,-2.0},np.float16); local r=np.prod(a,1); assert(close(r,36.0,2e-3),'half prod scalar 393') end
do local a=np.array({-1.0,-1.0,3.0,3.0,-2.0,1.0,-2.0},np.float16); local r=np.mean(a,1); assert(close(r,0.142822265625,2e-3),'half mean scalar 394') end
do local a=np.array({{2.0,-2.0,0.0,2.0,1.0},{0.25,0.0,0.25,0.25,-1.0}},np.float16); local r=np.sum(a,1); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{2.25,-2.0,0.25,2.25,0.0},2e-3),'half sum 395') end
do local a=np.array({{2.0,-2.0,0.0,2.0,1.0},{0.25,0.0,0.25,0.25,-1.0}},np.float16); local r=np.prod(a,1); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{0.5,-0.0,0.0,0.5,-1.0},2e-3),'half prod 396') end
do local a=np.array({{2.0,-2.0,0.0,2.0,1.0},{0.25,0.0,0.25,0.25,-1.0}},np.float16); local r=np.mean(a,1); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{1.125,-1.0,0.125,1.125,0.0},2e-3),'half mean 397') end
do local a=np.array({{{-1.0,0.0,-1.0,1.0},{-2.0,-0.5,2.0,0.0},{0.0,1.0,-0.5,-2.0}},{{0.0,-0.5,-2.0,2.0},{-0.5,0.0,0.25,1.0},{1.0,0.25,2.0,0.25}}},np.float16); local r=np.sum(a,1); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{-1.0,-0.5,-3.0,3.0},{-2.5,-0.5,2.25,1.0},{1.0,1.25,1.5,-1.75}},2e-3),'half sum 398') end
do local a=np.array({{{-1.0,0.0,-1.0,1.0},{-2.0,-0.5,2.0,0.0},{0.0,1.0,-0.5,-2.0}},{{0.0,-0.5,-2.0,2.0},{-0.5,0.0,0.25,1.0},{1.0,0.25,2.0,0.25}}},np.float16); local r=np.prod(a,1); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{-0.0,-0.0,2.0,2.0},{1.0,-0.0,0.5,0.0},{0.0,0.25,-1.0,-0.5}},2e-3),'half prod 399') end
do local a=np.array({{{-1.0,0.0,-1.0,1.0},{-2.0,-0.5,2.0,0.0},{0.0,1.0,-0.5,-2.0}},{{0.0,-0.5,-2.0,2.0},{-0.5,0.0,0.25,1.0},{1.0,0.25,2.0,0.25}}},np.float16); local r=np.mean(a,1); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{-0.5,-0.25,-1.5,1.5},{-1.25,-0.25,1.125,0.5},{0.5,0.625,0.75,-0.875}},2e-3),'half mean 400') end
do local a=np.array({-1.0,1.0,3.0,0.25,1.0,-2.0,0.25},np.float16); local r=np.sum(a,1); assert(close(r,2.5,2e-3),'half sum scalar 401') end
do local a=np.array({-1.0,1.0,3.0,0.25,1.0,-2.0,0.25},np.float16); local r=np.prod(a,1); assert(close(r,0.375,2e-3),'half prod scalar 402') end
do local a=np.array({-1.0,1.0,3.0,0.25,1.0,-2.0,0.25},np.float16); local r=np.mean(a,1); assert(close(r,0.357177734375,2e-3),'half mean scalar 403') end
do local a=np.array({1.0,0.25,2.0,-0.5,3.0,1.0,-2.0},np.float16); local r=np.sum(a,1); assert(close(r,4.75,2e-3),'half sum scalar 404') end
do local a=np.array({1.0,0.25,2.0,-0.5,3.0,1.0,-2.0},np.float16); local r=np.prod(a,1); assert(close(r,1.5,2e-3),'half prod scalar 405') end
do local a=np.array({1.0,0.25,2.0,-0.5,3.0,1.0,-2.0},np.float16); local r=np.mean(a,1); assert(close(r,0.6787109375,2e-3),'half mean scalar 406') end
do local a=np.array({{-1.0,-2.0,-0.5,3.0,2.0},{0.25,0.0,-1.0,0.25,3.0}},np.float16); local r=np.sum(a,1); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{-0.75,-2.0,-1.5,3.25,5.0},2e-3),'half sum 407') end
do local a=np.array({{-1.0,-2.0,-0.5,3.0,2.0},{0.25,0.0,-1.0,0.25,3.0}},np.float16); local r=np.prod(a,1); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{-0.25,-0.0,0.5,0.75,6.0},2e-3),'half prod 408') end
do local a=np.array({{-1.0,-2.0,-0.5,3.0,2.0},{0.25,0.0,-1.0,0.25,3.0}},np.float16); local r=np.mean(a,1); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{-0.375,-1.0,-0.75,1.625,2.5},2e-3),'half mean 409') end
do local a=np.array({-2.0,2.0,-2.0,-0.5,2.0,0.25,0.25},np.float16); local r=np.sum(a,1); assert(close(r,0.0,2e-3),'half sum scalar 410') end
do local a=np.array({-2.0,2.0,-2.0,-0.5,2.0,0.25,0.25},np.float16); local r=np.prod(a,1); assert(close(r,-0.5,2e-3),'half prod scalar 411') end
do local a=np.array({-2.0,2.0,-2.0,-0.5,2.0,0.25,0.25},np.float16); local r=np.mean(a,1); assert(close(r,0.0,2e-3),'half mean scalar 412') end
do local a=np.array({2.0,3.0,-2.0,-0.5,-0.5,-1.0,3.0},np.float16); local r=np.sum(a,1); assert(close(r,4.0,2e-3),'half sum scalar 413') end
do local a=np.array({2.0,3.0,-2.0,-0.5,-0.5,-1.0,3.0},np.float16); local r=np.prod(a,1); assert(close(r,9.0,2e-3),'half prod scalar 414') end
do local a=np.array({2.0,3.0,-2.0,-0.5,-0.5,-1.0,3.0},np.float16); local r=np.mean(a,1); assert(close(r,0.5712890625,2e-3),'half mean scalar 415') end
do local a=np.array({{{-1.0,0.0,1.0,1.0},{0.0,0.25,-1.0,1.0},{-2.0,1.0,0.25,1.0}},{{0.0,0.0,-2.0,1.0},{0.0,-2.0,0.0,-1.0},{0.0,3.0,0.0,0.0}}},np.float16); local r=np.sum(a,1); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{-1.0,0.0,-1.0,2.0},{0.0,-1.75,-1.0,0.0},{-2.0,4.0,0.25,1.0}},2e-3),'half sum 416') end
do local a=np.array({{{-1.0,0.0,1.0,1.0},{0.0,0.25,-1.0,1.0},{-2.0,1.0,0.25,1.0}},{{0.0,0.0,-2.0,1.0},{0.0,-2.0,0.0,-1.0},{0.0,3.0,0.0,0.0}}},np.float16); local r=np.prod(a,1); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{-0.0,0.0,-2.0,1.0},{0.0,-0.5,-0.0,-1.0},{-0.0,3.0,0.0,0.0}},2e-3),'half prod 417') end
do local a=np.array({{{-1.0,0.0,1.0,1.0},{0.0,0.25,-1.0,1.0},{-2.0,1.0,0.25,1.0}},{{0.0,0.0,-2.0,1.0},{0.0,-2.0,0.0,-1.0},{0.0,3.0,0.0,0.0}}},np.float16); local r=np.mean(a,1); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{-0.5,0.0,-0.5,1.0},{0.0,-0.875,-0.5,0.0},{-1.0,2.0,0.125,0.5}},2e-3),'half mean 418') end
do local a=np.array({{{0.0,0.25,-2.0,-0.5},{-0.5,-2.0,0.0,1.0},{-1.0,-2.0,2.0,3.0}},{{0.25,3.0,0.0,3.0},{2.0,0.0,3.0,3.0},{2.0,-1.0,1.0,-1.0}}},np.float16); local r=np.sum(a,2); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{-1.5,-3.75,0.0,3.5},{4.25,2.0,4.0,5.0}},2e-3),'half sum 419') end
do local a=np.array({{{0.0,0.25,-2.0,-0.5},{-0.5,-2.0,0.0,1.0},{-1.0,-2.0,2.0,3.0}},{{0.25,3.0,0.0,3.0},{2.0,0.0,3.0,3.0},{2.0,-1.0,1.0,-1.0}}},np.float16); local r=np.prod(a,2); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{0.0,1.0,-0.0,-1.5},{1.0,-0.0,0.0,-9.0}},2e-3),'half prod 420') end
do local a=np.array({{{0.0,0.25,-2.0,-0.5},{-0.5,-2.0,0.0,1.0},{-1.0,-2.0,2.0,3.0}},{{0.25,3.0,0.0,3.0},{2.0,0.0,3.0,3.0},{2.0,-1.0,1.0,-1.0}}},np.float16); local r=np.mean(a,2); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{-0.5,-1.25,0.0,1.1669921875},{1.4169921875,0.66650390625,1.3330078125,1.6669921875}},2e-3),'half mean 421') end
do local a=np.array({{-2.0,2.0,1.0,2.0,3.0},{-2.0,3.0,1.0,2.0,0.25}},np.float16); local r=np.sum(a,1); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{-4.0,5.0,2.0,4.0,3.25},2e-3),'half sum 422') end
do local a=np.array({{-2.0,2.0,1.0,2.0,3.0},{-2.0,3.0,1.0,2.0,0.25}},np.float16); local r=np.prod(a,1); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{4.0,6.0,1.0,4.0,0.75},2e-3),'half prod 423') end
do local a=np.array({{-2.0,2.0,1.0,2.0,3.0},{-2.0,3.0,1.0,2.0,0.25}},np.float16); local r=np.mean(a,1); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{-2.0,2.5,1.0,2.0,1.625},2e-3),'half mean 424') end
do local a=np.array({{{0.25,0.25,-1.0,-1.0},{-0.5,-1.0,0.0,1.0},{-0.5,-1.0,0.0,0.25}},{{3.0,0.25,1.0,-1.0},{0.25,3.0,0.0,0.25},{0.0,2.0,3.0,0.25}}},np.float16); local r=np.sum(a,1); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{3.25,0.5,0.0,-2.0},{-0.25,2.0,0.0,1.25},{-0.5,1.0,3.0,0.5}},2e-3),'half sum 425') end
do local a=np.array({{{0.25,0.25,-1.0,-1.0},{-0.5,-1.0,0.0,1.0},{-0.5,-1.0,0.0,0.25}},{{3.0,0.25,1.0,-1.0},{0.25,3.0,0.0,0.25},{0.0,2.0,3.0,0.25}}},np.float16); local r=np.prod(a,1); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{0.75,0.0625,-1.0,1.0},{-0.125,-3.0,0.0,0.25},{-0.0,-2.0,0.0,0.0625}},2e-3),'half prod 426') end
do local a=np.array({{{0.25,0.25,-1.0,-1.0},{-0.5,-1.0,0.0,1.0},{-0.5,-1.0,0.0,0.25}},{{3.0,0.25,1.0,-1.0},{0.25,3.0,0.0,0.25},{0.0,2.0,3.0,0.25}}},np.float16); local r=np.mean(a,1); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{1.625,0.25,0.0,-1.0},{-0.125,1.0,0.0,0.625},{-0.25,0.5,1.5,0.25}},2e-3),'half mean 427') end
do local a=np.array({-0.5,-1.0,0.25,2.0,3.0,-1.0,3.0},np.float16); local r=np.sum(a,1); assert(close(r,5.75,2e-3),'half sum scalar 428') end
do local a=np.array({-0.5,-1.0,0.25,2.0,3.0,-1.0,3.0},np.float16); local r=np.prod(a,1); assert(close(r,-2.25,2e-3),'half prod scalar 429') end
do local a=np.array({-0.5,-1.0,0.25,2.0,3.0,-1.0,3.0},np.float16); local r=np.mean(a,1); assert(close(r,0.8212890625,2e-3),'half mean scalar 430') end
do local a=np.array({{1.0,0.0,-1.0,0.25,-0.5},{-2.0,-2.0,-1.0,3.0,0.0}},np.float16); local r=np.sum(a,1); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{-1.0,-2.0,-2.0,3.25,-0.5},2e-3),'half sum 431') end
do local a=np.array({{1.0,0.0,-1.0,0.25,-0.5},{-2.0,-2.0,-1.0,3.0,0.0}},np.float16); local r=np.prod(a,1); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{-2.0,-0.0,1.0,0.75,-0.0},2e-3),'half prod 432') end
do local a=np.array({{1.0,0.0,-1.0,0.25,-0.5},{-2.0,-2.0,-1.0,3.0,0.0}},np.float16); local r=np.mean(a,1); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{-0.5,-1.0,-1.0,1.625,-0.25},2e-3),'half mean 433') end
do local a=np.array({{3.0,0.0,-1.0,1.0,2.0},{-1.0,-1.0,-0.5,-1.0,-1.0}},np.float16); local r=np.sum(a,1); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{2.0,-1.0,-1.5,0.0,1.0},2e-3),'half sum 434') end
do local a=np.array({{3.0,0.0,-1.0,1.0,2.0},{-1.0,-1.0,-0.5,-1.0,-1.0}},np.float16); local r=np.prod(a,1); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{-3.0,-0.0,0.5,-1.0,-2.0},2e-3),'half prod 435') end
do local a=np.array({{3.0,0.0,-1.0,1.0,2.0},{-1.0,-1.0,-0.5,-1.0,-1.0}},np.float16); local r=np.mean(a,1); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{1.0,-0.5,-0.75,0.0,0.5},2e-3),'half mean 436') end
do local a=np.array({-2.0,1.0,0.0,-0.5,-0.5,-2.0,0.0},np.float16); local r=np.sum(a,1); assert(close(r,-4.0,2e-3),'half sum scalar 437') end
do local a=np.array({-2.0,1.0,0.0,-0.5,-0.5,-2.0,0.0},np.float16); local r=np.prod(a,1); assert(close(r,0.0,2e-3),'half prod scalar 438') end
do local a=np.array({-2.0,1.0,0.0,-0.5,-0.5,-2.0,0.0},np.float16); local r=np.mean(a,1); assert(close(r,-0.5712890625,2e-3),'half mean scalar 439') end
do local a=np.array({-2.0,-0.5,-1.0,0.25,3.0,1.0,0.25},np.float16); local r=np.sum(a,1); assert(close(r,1.0,2e-3),'half sum scalar 440') end
do local a=np.array({-2.0,-0.5,-1.0,0.25,3.0,1.0,0.25},np.float16); local r=np.prod(a,1); assert(close(r,-0.1875,2e-3),'half prod scalar 441') end
do local a=np.array({-2.0,-0.5,-1.0,0.25,3.0,1.0,0.25},np.float16); local r=np.mean(a,1); assert(close(r,0.142822265625,2e-3),'half mean scalar 442') end
do local a=np.array({3.0,3.0,0.0,0.25,0.25,0.0,2.0},np.float16); local r=np.sum(a,1); assert(close(r,8.5,2e-3),'half sum scalar 443') end
do local a=np.array({3.0,3.0,0.0,0.25,0.25,0.0,2.0},np.float16); local r=np.prod(a,1); assert(close(r,0.0,2e-3),'half prod scalar 444') end
do local a=np.array({3.0,3.0,0.0,0.25,0.25,0.0,2.0},np.float16); local r=np.mean(a,1); assert(close(r,1.2138671875,2e-3),'half mean scalar 445') end
do local a=np.array({0.25,0.25,-1.0,-0.5,2.0,3.0,0.25},np.float16); local r=np.sum(a,1); assert(close(r,4.25,2e-3),'half sum scalar 446') end
do local a=np.array({0.25,0.25,-1.0,-0.5,2.0,3.0,0.25},np.float16); local r=np.prod(a,1); assert(close(r,0.046875,2e-3),'half prod scalar 447') end
do local a=np.array({0.25,0.25,-1.0,-0.5,2.0,3.0,0.25},np.float16); local r=np.mean(a,1); assert(close(r,0.60693359375,2e-3),'half mean scalar 448') end
do local a=np.array({{{0.25,1.0,-2.0,2.0},{0.0,-2.0,-2.0,-1.0},{-1.0,1.0,-2.0,0.0}},{{0.0,2.0,3.0,1.0},{1.0,-2.0,-1.0,-1.0},{-1.0,0.25,-2.0,-1.0}}},np.float16); local r=np.sum(a,3); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{1.25,-5.0,-2.0},{6.0,-3.0,-3.75}},2e-3),'half sum 449') end
do local a=np.array({{{0.25,1.0,-2.0,2.0},{0.0,-2.0,-2.0,-1.0},{-1.0,1.0,-2.0,0.0}},{{0.0,2.0,3.0,1.0},{1.0,-2.0,-1.0,-1.0},{-1.0,0.25,-2.0,-1.0}}},np.float16); local r=np.prod(a,3); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{-1.0,-0.0,0.0},{0.0,-2.0,-0.5}},2e-3),'half prod 450') end
do local a=np.array({{{0.25,1.0,-2.0,2.0},{0.0,-2.0,-2.0,-1.0},{-1.0,1.0,-2.0,0.0}},{{0.0,2.0,3.0,1.0},{1.0,-2.0,-1.0,-1.0},{-1.0,0.25,-2.0,-1.0}}},np.float16); local r=np.mean(a,3); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{0.3125,-1.25,-0.5},{1.5,-0.75,-0.9375}},2e-3),'half mean 451') end
do local a=np.array({2.0,-1.0,0.0,3.0,1.0,-1.0,-1.0},np.float16); local r=np.sum(a,1); assert(close(r,3.0,2e-3),'half sum scalar 452') end
do local a=np.array({2.0,-1.0,0.0,3.0,1.0,-1.0,-1.0},np.float16); local r=np.prod(a,1); assert(close(r,-0.0,2e-3),'half prod scalar 453') end
do local a=np.array({2.0,-1.0,0.0,3.0,1.0,-1.0,-1.0},np.float16); local r=np.mean(a,1); assert(close(r,0.428466796875,2e-3),'half mean scalar 454') end
do local a=np.array({{-0.5,3.0,-0.5,-2.0,0.0},{0.25,-2.0,2.0,-2.0,-0.5}},np.float16); local r=np.sum(a,1); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{-0.25,1.0,1.5,-4.0,-0.5},2e-3),'half sum 455') end
do local a=np.array({{-0.5,3.0,-0.5,-2.0,0.0},{0.25,-2.0,2.0,-2.0,-0.5}},np.float16); local r=np.prod(a,1); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{-0.125,-6.0,-1.0,4.0,-0.0},2e-3),'half prod 456') end
do local a=np.array({{-0.5,3.0,-0.5,-2.0,0.0},{0.25,-2.0,2.0,-2.0,-0.5}},np.float16); local r=np.mean(a,1); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{-0.125,0.5,0.75,-2.0,-0.25},2e-3),'half mean 457') end
do local a=np.array({{2.0,1.0,3.0,3.0,-0.5},{3.0,-0.5,3.0,-2.0,-1.0}},np.float16); local r=np.sum(a,2); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{8.5,2.5},2e-3),'half sum 458') end
do local a=np.array({{2.0,1.0,3.0,3.0,-0.5},{3.0,-0.5,3.0,-2.0,-1.0}},np.float16); local r=np.prod(a,2); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{-9.0,-9.0},2e-3),'half prod 459') end
do local a=np.array({{2.0,1.0,3.0,3.0,-0.5},{3.0,-0.5,3.0,-2.0,-1.0}},np.float16); local r=np.mean(a,2); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{1.7001953125,0.5},2e-3),'half mean 460') end
do local a=np.array({-0.5,0.0,1.0,0.25,0.0,-1.0,-0.5},np.float16); local r=np.sum(a,1); assert(close(r,-0.75,2e-3),'half sum scalar 461') end
do local a=np.array({-0.5,0.0,1.0,0.25,0.0,-1.0,-0.5},np.float16); local r=np.prod(a,1); assert(close(r,-0.0,2e-3),'half prod scalar 462') end
do local a=np.array({-0.5,0.0,1.0,0.25,0.0,-1.0,-0.5},np.float16); local r=np.mean(a,1); assert(close(r,-0.10711669921875,2e-3),'half mean scalar 463') end
do local a=np.array({{0.0,2.0,3.0,0.0,2.0},{-0.5,-0.5,0.0,2.0,3.0}},np.float16); local r=np.sum(a,2); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{7.0,4.0},2e-3),'half sum 464') end
do local a=np.array({{0.0,2.0,3.0,0.0,2.0},{-0.5,-0.5,0.0,2.0,3.0}},np.float16); local r=np.prod(a,2); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{0.0,0.0},2e-3),'half prod 465') end
do local a=np.array({{0.0,2.0,3.0,0.0,2.0},{-0.5,-0.5,0.0,2.0,3.0}},np.float16); local r=np.mean(a,2); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{1.400390625,0.7998046875},2e-3),'half mean 466') end
do local a=np.array({{{-1.0,-1.0,2.0,3.0},{2.0,-2.0,-2.0,0.0},{2.0,-2.0,-1.0,-0.5}},{{1.0,0.25,2.0,-0.5},{-2.0,-2.0,2.0,-2.0},{-0.5,0.25,3.0,-1.0}}},np.float16); local r=np.sum(a,1); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{0.0,-0.75,4.0,2.5},{0.0,-4.0,0.0,-2.0},{1.5,-1.75,2.0,-1.5}},2e-3),'half sum 467') end
do local a=np.array({{{-1.0,-1.0,2.0,3.0},{2.0,-2.0,-2.0,0.0},{2.0,-2.0,-1.0,-0.5}},{{1.0,0.25,2.0,-0.5},{-2.0,-2.0,2.0,-2.0},{-0.5,0.25,3.0,-1.0}}},np.float16); local r=np.prod(a,1); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{-1.0,-0.25,4.0,-1.5},{-4.0,4.0,-4.0,-0.0},{-1.0,-0.5,-3.0,0.5}},2e-3),'half prod 468') end
do local a=np.array({{{-1.0,-1.0,2.0,3.0},{2.0,-2.0,-2.0,0.0},{2.0,-2.0,-1.0,-0.5}},{{1.0,0.25,2.0,-0.5},{-2.0,-2.0,2.0,-2.0},{-0.5,0.25,3.0,-1.0}}},np.float16); local r=np.mean(a,1); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{0.0,-0.375,2.0,1.25},{0.0,-2.0,0.0,-1.0},{0.75,-0.875,1.0,-0.75}},2e-3),'half mean 469') end
do local a=np.array({-1.0,0.0,0.25,-2.0,1.0,0.25,-2.0},np.float16); local r=np.sum(a,1); assert(close(r,-3.5,2e-3),'half sum scalar 470') end
do local a=np.array({-1.0,0.0,0.25,-2.0,1.0,0.25,-2.0},np.float16); local r=np.prod(a,1); assert(close(r,-0.0,2e-3),'half prod scalar 471') end
do local a=np.array({-1.0,0.0,0.25,-2.0,1.0,0.25,-2.0},np.float16); local r=np.mean(a,1); assert(close(r,-0.5,2e-3),'half mean scalar 472') end
do local a=np.array({{{0.0,-1.0,-2.0,0.0},{0.0,3.0,2.0,0.0},{0.25,-2.0,-0.5,0.25}},{{-2.0,-2.0,-1.0,-2.0},{2.0,-0.5,2.0,-0.5},{0.25,0.25,-0.5,1.0}}},np.float16); local r=np.sum(a,2); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{0.25,0.0,-0.5,0.25},{0.25,-2.25,0.5,-1.5}},2e-3),'half sum 473') end
do local a=np.array({{{0.0,-1.0,-2.0,0.0},{0.0,3.0,2.0,0.0},{0.25,-2.0,-0.5,0.25}},{{-2.0,-2.0,-1.0,-2.0},{2.0,-0.5,2.0,-0.5},{0.25,0.25,-0.5,1.0}}},np.float16); local r=np.prod(a,2); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{0.0,6.0,2.0,0.0},{-1.0,0.25,1.0,1.0}},2e-3),'half prod 474') end
do local a=np.array({{{0.0,-1.0,-2.0,0.0},{0.0,3.0,2.0,0.0},{0.25,-2.0,-0.5,0.25}},{{-2.0,-2.0,-1.0,-2.0},{2.0,-0.5,2.0,-0.5},{0.25,0.25,-0.5,1.0}}},np.float16); local r=np.mean(a,2); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{0.08331298828125,0.0,-0.1666259765625,0.08331298828125},{0.08331298828125,-0.75,0.1666259765625,-0.5}},2e-3),'half mean 475') end
do local a=np.array({-0.5,-1.0,0.0,3.0,-1.0,1.0,3.0},np.float16); local r=np.sum(a,1); assert(close(r,4.5,2e-3),'half sum scalar 476') end
do local a=np.array({-0.5,-1.0,0.0,3.0,-1.0,1.0,3.0},np.float16); local r=np.prod(a,1); assert(close(r,-0.0,2e-3),'half prod scalar 477') end
do local a=np.array({-0.5,-1.0,0.0,3.0,-1.0,1.0,3.0},np.float16); local r=np.mean(a,1); assert(close(r,0.64306640625,2e-3),'half mean scalar 478') end
do local a=np.array({{{0.0,-0.5,-1.0,3.0},{0.0,-0.5,0.25,-2.0},{-2.0,3.0,-1.0,0.0}},{{1.0,1.0,-1.0,0.0},{-0.5,-0.5,-1.0,2.0},{-0.5,3.0,0.0,-1.0}}},np.float16); local r=np.sum(a,1); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{1.0,0.5,-2.0,3.0},{-0.5,-1.0,-0.75,0.0},{-2.5,6.0,-1.0,-1.0}},2e-3),'half sum 479') end
do local a=np.array({{{0.0,-0.5,-1.0,3.0},{0.0,-0.5,0.25,-2.0},{-2.0,3.0,-1.0,0.0}},{{1.0,1.0,-1.0,0.0},{-0.5,-0.5,-1.0,2.0},{-0.5,3.0,0.0,-1.0}}},np.float16); local r=np.prod(a,1); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{0.0,-0.5,1.0,0.0},{-0.0,0.25,-0.25,-4.0},{1.0,9.0,-0.0,-0.0}},2e-3),'half prod 480') end
do local a=np.array({{{0.0,-0.5,-1.0,3.0},{0.0,-0.5,0.25,-2.0},{-2.0,3.0,-1.0,0.0}},{{1.0,1.0,-1.0,0.0},{-0.5,-0.5,-1.0,2.0},{-0.5,3.0,0.0,-1.0}}},np.float16); local r=np.mean(a,1); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{0.5,0.25,-1.0,1.5},{-0.25,-0.5,-0.375,0.0},{-1.25,3.0,-0.5,-0.5}},2e-3),'half mean 481') end
do local a=np.array({{{-0.5,-2.0,1.0,0.0},{-0.5,0.0,0.0,0.25},{1.0,-0.5,-0.5,-1.0}},{{0.0,3.0,0.25,-2.0},{0.25,0.25,-0.5,-1.0},{2.0,1.0,-0.5,3.0}}},np.float16); local r=np.sum(a,1); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{-0.5,1.0,1.25,-2.0},{-0.25,0.25,-0.5,-0.75},{3.0,0.5,-1.0,2.0}},2e-3),'half sum 482') end
do local a=np.array({{{-0.5,-2.0,1.0,0.0},{-0.5,0.0,0.0,0.25},{1.0,-0.5,-0.5,-1.0}},{{0.0,3.0,0.25,-2.0},{0.25,0.25,-0.5,-1.0},{2.0,1.0,-0.5,3.0}}},np.float16); local r=np.prod(a,1); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{-0.0,-6.0,0.25,-0.0},{-0.125,0.0,-0.0,-0.25},{2.0,-0.5,0.25,-3.0}},2e-3),'half prod 483') end
do local a=np.array({{{-0.5,-2.0,1.0,0.0},{-0.5,0.0,0.0,0.25},{1.0,-0.5,-0.5,-1.0}},{{0.0,3.0,0.25,-2.0},{0.25,0.25,-0.5,-1.0},{2.0,1.0,-0.5,3.0}}},np.float16); local r=np.mean(a,1); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{-0.25,0.5,0.625,-1.0},{-0.125,0.125,-0.25,-0.375},{1.5,0.25,-0.5,1.0}},2e-3),'half mean 484') end
do local a=np.array({3.0,1.0,-1.0,2.0,1.0,1.0,0.0},np.float16); local r=np.sum(a,1); assert(close(r,7.0,2e-3),'half sum scalar 485') end
do local a=np.array({3.0,1.0,-1.0,2.0,1.0,1.0,0.0},np.float16); local r=np.prod(a,1); assert(close(r,-0.0,2e-3),'half prod scalar 486') end
do local a=np.array({3.0,1.0,-1.0,2.0,1.0,1.0,0.0},np.float16); local r=np.mean(a,1); assert(close(r,1.0,2e-3),'half mean scalar 487') end
do local a=np.array({1.0,-2.0,-0.5,1.0,0.0,-0.5,2.0},np.float16); local r=np.sum(a,1); assert(close(r,1.0,2e-3),'half sum scalar 488') end
do local a=np.array({1.0,-2.0,-0.5,1.0,0.0,-0.5,2.0},np.float16); local r=np.prod(a,1); assert(close(r,-0.0,2e-3),'half prod scalar 489') end
do local a=np.array({1.0,-2.0,-0.5,1.0,0.0,-0.5,2.0},np.float16); local r=np.mean(a,1); assert(close(r,0.142822265625,2e-3),'half mean scalar 490') end
do local a=np.array({3.0,1.0,0.0,0.25,-1.0,-1.0,-0.5},np.float16); local r=np.sum(a,1); assert(close(r,1.75,2e-3),'half sum scalar 491') end
do local a=np.array({3.0,1.0,0.0,0.25,-1.0,-1.0,-0.5},np.float16); local r=np.prod(a,1); assert(close(r,-0.0,2e-3),'half prod scalar 492') end
do local a=np.array({3.0,1.0,0.0,0.25,-1.0,-1.0,-0.5},np.float16); local r=np.mean(a,1); assert(close(r,0.25,2e-3),'half mean scalar 493') end
do local a=np.array({{{-0.5,-0.5,0.0,1.0},{0.25,0.25,-0.5,1.0},{1.0,-1.0,0.25,-1.0}},{{-0.5,-2.0,3.0,-0.5},{-1.0,1.0,0.0,-1.0},{-2.0,0.0,0.0,1.0}}},np.float16); local r=np.sum(a,1); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{-1.0,-2.5,3.0,0.5},{-0.75,1.25,-0.5,0.0},{-1.0,-1.0,0.25,0.0}},2e-3),'half sum 494') end
do local a=np.array({{{-0.5,-0.5,0.0,1.0},{0.25,0.25,-0.5,1.0},{1.0,-1.0,0.25,-1.0}},{{-0.5,-2.0,3.0,-0.5},{-1.0,1.0,0.0,-1.0},{-2.0,0.0,0.0,1.0}}},np.float16); local r=np.prod(a,1); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{0.25,1.0,0.0,-0.5},{-0.25,0.25,-0.0,-1.0},{-2.0,-0.0,0.0,-1.0}},2e-3),'half prod 495') end
do local a=np.array({{{-0.5,-0.5,0.0,1.0},{0.25,0.25,-0.5,1.0},{1.0,-1.0,0.25,-1.0}},{{-0.5,-2.0,3.0,-0.5},{-1.0,1.0,0.0,-1.0},{-2.0,0.0,0.0,1.0}}},np.float16); local r=np.mean(a,1); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{-0.5,-1.25,1.5,0.25},{-0.375,0.625,-0.25,0.0},{-0.5,-0.5,0.125,0.0}},2e-3),'half mean 496') end
do local a=np.array({{{3.0,-0.5,-2.0,-0.5},{3.0,-2.0,1.0,-0.5},{0.0,-0.5,1.0,0.25}},{{-1.0,-2.0,-2.0,0.25},{-0.5,2.0,-0.5,1.0},{3.0,2.0,-0.5,2.0}}},np.float16); local r=np.sum(a,1); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{2.0,-2.5,-4.0,-0.25},{2.5,0.0,0.5,0.5},{3.0,1.5,0.5,2.25}},2e-3),'half sum 497') end
do local a=np.array({{{3.0,-0.5,-2.0,-0.5},{3.0,-2.0,1.0,-0.5},{0.0,-0.5,1.0,0.25}},{{-1.0,-2.0,-2.0,0.25},{-0.5,2.0,-0.5,1.0},{3.0,2.0,-0.5,2.0}}},np.float16); local r=np.prod(a,1); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{-3.0,1.0,4.0,-0.125},{-1.5,-4.0,-0.5,-0.5},{0.0,-1.0,-0.5,0.5}},2e-3),'half prod 498') end
do local a=np.array({{{3.0,-0.5,-2.0,-0.5},{3.0,-2.0,1.0,-0.5},{0.0,-0.5,1.0,0.25}},{{-1.0,-2.0,-2.0,0.25},{-0.5,2.0,-0.5,1.0},{3.0,2.0,-0.5,2.0}}},np.float16); local r=np.mean(a,1); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{1.0,-1.25,-2.0,-0.125},{1.25,0.0,0.25,0.25},{1.5,0.75,0.25,1.125}},2e-3),'half mean 499') end
do local a=np.array({{0.25,-1.0,-0.5,-2.0,-2.0},{2.0,0.25,3.0,-1.0,1.0}},np.float16); local r=np.sum(a,1); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{2.25,-0.75,2.5,-3.0,-1.0},2e-3),'half sum 500') end
do local a=np.array({{0.25,-1.0,-0.5,-2.0,-2.0},{2.0,0.25,3.0,-1.0,1.0}},np.float16); local r=np.prod(a,1); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{0.5,-0.25,-1.5,2.0,-2.0},2e-3),'half prod 501') end
do local a=np.array({{0.25,-1.0,-0.5,-2.0,-2.0},{2.0,0.25,3.0,-1.0,1.0}},np.float16); local r=np.mean(a,1); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{1.125,-0.375,1.25,-1.5,-0.5},2e-3),'half mean 502') end
do local a=np.array({1.0,3.0,-2.0,0.0,1.0,3.0,3.0},np.float16); local r=np.sum(a,1); assert(close(r,9.0,2e-3),'half sum scalar 503') end
do local a=np.array({1.0,3.0,-2.0,0.0,1.0,3.0,3.0},np.float16); local r=np.prod(a,1); assert(close(r,-0.0,2e-3),'half prod scalar 504') end
do local a=np.array({1.0,3.0,-2.0,0.0,1.0,3.0,3.0},np.float16); local r=np.mean(a,1); assert(close(r,1.2861328125,2e-3),'half mean scalar 505') end
do local a=np.array({{{3.0,-1.0,0.0,-2.0},{2.0,2.0,0.25,2.0},{3.0,3.0,1.0,-1.0}},{{1.0,0.25,-0.5,-0.5},{2.0,1.0,-2.0,3.0},{0.25,-2.0,0.0,2.0}}},np.float16); local r=np.sum(a,3); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{0.0,6.25,6.0},{0.25,4.0,0.25}},2e-3),'half sum 506') end
do local a=np.array({{{3.0,-1.0,0.0,-2.0},{2.0,2.0,0.25,2.0},{3.0,3.0,1.0,-1.0}},{{1.0,0.25,-0.5,-0.5},{2.0,1.0,-2.0,3.0},{0.25,-2.0,0.0,2.0}}},np.float16); local r=np.prod(a,3); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{0.0,2.0,-9.0},{0.0625,-12.0,-0.0}},2e-3),'half prod 507') end
do local a=np.array({{{3.0,-1.0,0.0,-2.0},{2.0,2.0,0.25,2.0},{3.0,3.0,1.0,-1.0}},{{1.0,0.25,-0.5,-0.5},{2.0,1.0,-2.0,3.0},{0.25,-2.0,0.0,2.0}}},np.float16); local r=np.mean(a,3); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{0.0,1.5625,1.5},{0.0625,1.0,0.0625}},2e-3),'half mean 508') end
do local a=np.array({3.0,1.0,-2.0,0.0,0.0,1.0,-2.0},np.float16); local r=np.sum(a,1); assert(close(r,1.0,2e-3),'half sum scalar 509') end
do local a=np.array({3.0,1.0,-2.0,0.0,0.0,1.0,-2.0},np.float16); local r=np.prod(a,1); assert(close(r,0.0,2e-3),'half prod scalar 510') end
do local a=np.array({3.0,1.0,-2.0,0.0,0.0,1.0,-2.0},np.float16); local r=np.mean(a,1); assert(close(r,0.142822265625,2e-3),'half mean scalar 511') end
do local a=np.array({{1.0,-2.0,2.0,0.0,-1.0},{2.0,-1.0,-2.0,-0.5,0.25}},np.float16); local r=np.sum(a,2); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{0.0,-1.25},2e-3),'half sum 512') end
do local a=np.array({{1.0,-2.0,2.0,0.0,-1.0},{2.0,-1.0,-2.0,-0.5,0.25}},np.float16); local r=np.prod(a,2); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{0.0,-0.5},2e-3),'half prod 513') end
do local a=np.array({{1.0,-2.0,2.0,0.0,-1.0},{2.0,-1.0,-2.0,-0.5,0.25}},np.float16); local r=np.mean(a,2); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{0.0,-0.25},2e-3),'half mean 514') end
do local a=np.array({0.25,-1.0,0.25,-1.0,-1.0,0.0,3.0},np.float16); local r=np.sum(a,1); assert(close(r,0.5,2e-3),'half sum scalar 515') end
do local a=np.array({0.25,-1.0,0.25,-1.0,-1.0,0.0,3.0},np.float16); local r=np.prod(a,1); assert(close(r,-0.0,2e-3),'half prod scalar 516') end
do local a=np.array({0.25,-1.0,0.25,-1.0,-1.0,0.0,3.0},np.float16); local r=np.mean(a,1); assert(close(r,0.0714111328125,2e-3),'half mean scalar 517') end
do local a=np.array({-0.5,0.25,-2.0,-1.0,0.25,0.0,2.0},np.float16); local r=np.sum(a,1); assert(close(r,-1.0,2e-3),'half sum scalar 518') end
do local a=np.array({-0.5,0.25,-2.0,-1.0,0.25,0.0,2.0},np.float16); local r=np.prod(a,1); assert(close(r,-0.0,2e-3),'half prod scalar 519') end
do local a=np.array({-0.5,0.25,-2.0,-1.0,0.25,0.0,2.0},np.float16); local r=np.mean(a,1); assert(close(r,-0.142822265625,2e-3),'half mean scalar 520') end
do local a=np.array({2.0,-2.0,-2.0,0.25,1.0,3.0,-1.0},np.float16); local r=np.sum(a,1); assert(close(r,1.25,2e-3),'half sum scalar 521') end
do local a=np.array({2.0,-2.0,-2.0,0.25,1.0,3.0,-1.0},np.float16); local r=np.prod(a,1); assert(close(r,-6.0,2e-3),'half prod scalar 522') end
do local a=np.array({2.0,-2.0,-2.0,0.25,1.0,3.0,-1.0},np.float16); local r=np.mean(a,1); assert(close(r,0.1785888671875,2e-3),'half mean scalar 523') end
do local a=np.array({0.25,-0.5,-2.0,0.0,0.0,1.0,-2.0},np.float16); local r=np.sum(a,1); assert(close(r,-3.25,2e-3),'half sum scalar 524') end
do local a=np.array({0.25,-0.5,-2.0,0.0,0.0,1.0,-2.0},np.float16); local r=np.prod(a,1); assert(close(r,-0.0,2e-3),'half prod scalar 525') end
do local a=np.array({0.25,-0.5,-2.0,0.0,0.0,1.0,-2.0},np.float16); local r=np.mean(a,1); assert(close(r,-0.46435546875,2e-3),'half mean scalar 526') end
do local a=np.array({0.25,1.0,2.0,-0.5,-1.0,0.0,3.0},np.float16); local r=np.sum(a,1); assert(close(r,4.75,2e-3),'half sum scalar 527') end
do local a=np.array({0.25,1.0,2.0,-0.5,-1.0,0.0,3.0},np.float16); local r=np.prod(a,1); assert(close(r,0.0,2e-3),'half prod scalar 528') end
do local a=np.array({0.25,1.0,2.0,-0.5,-1.0,0.0,3.0},np.float16); local r=np.mean(a,1); assert(close(r,0.6787109375,2e-3),'half mean scalar 529') end
do local a=np.array({{{3.0,0.0,0.0,-2.0},{3.0,1.0,0.0,-1.0},{0.0,-1.0,-1.0,3.0}},{{-2.0,0.0,1.0,-1.0},{-1.0,-0.5,1.0,1.0},{0.25,0.0,2.0,2.0}}},np.float16); local r=np.sum(a,2); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{6.0,0.0,-1.0,0.0},{-2.75,-0.5,4.0,2.0}},2e-3),'half sum 530') end
do local a=np.array({{{3.0,0.0,0.0,-2.0},{3.0,1.0,0.0,-1.0},{0.0,-1.0,-1.0,3.0}},{{-2.0,0.0,1.0,-1.0},{-1.0,-0.5,1.0,1.0},{0.25,0.0,2.0,2.0}}},np.float16); local r=np.prod(a,2); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{0.0,-0.0,-0.0,6.0},{0.5,-0.0,2.0,-2.0}},2e-3),'half prod 531') end
do local a=np.array({{{3.0,0.0,0.0,-2.0},{3.0,1.0,0.0,-1.0},{0.0,-1.0,-1.0,3.0}},{{-2.0,0.0,1.0,-1.0},{-1.0,-0.5,1.0,1.0},{0.25,0.0,2.0,2.0}}},np.float16); local r=np.mean(a,2); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{2.0,0.0,-0.333251953125,0.0},{-0.91650390625,-0.1666259765625,1.3330078125,0.66650390625}},2e-3),'half mean 532') end
do local a=np.array({{1.0,-0.5,1.0,3.0,-1.0},{-1.0,-0.5,-0.5,-2.0,3.0}},np.float16); local r=np.sum(a,2); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{3.5,-1.0},2e-3),'half sum 533') end
do local a=np.array({{1.0,-0.5,1.0,3.0,-1.0},{-1.0,-0.5,-0.5,-2.0,3.0}},np.float16); local r=np.prod(a,2); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{1.5,1.5},2e-3),'half prod 534') end
do local a=np.array({{1.0,-0.5,1.0,3.0,-1.0},{-1.0,-0.5,-0.5,-2.0,3.0}},np.float16); local r=np.mean(a,2); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{0.7001953125,-0.199951171875},2e-3),'half mean 535') end
do local a=np.array({0.0,0.0,-1.0,3.0,-0.5,2.0,1.0},np.float16); local r=np.sum(a,1); assert(close(r,4.5,2e-3),'half sum scalar 536') end
do local a=np.array({0.0,0.0,-1.0,3.0,-0.5,2.0,1.0},np.float16); local r=np.prod(a,1); assert(close(r,0.0,2e-3),'half prod scalar 537') end
do local a=np.array({0.0,0.0,-1.0,3.0,-0.5,2.0,1.0},np.float16); local r=np.mean(a,1); assert(close(r,0.64306640625,2e-3),'half mean scalar 538') end
do local a=np.array({{3.0,3.0,0.25,0.0,-2.0},{0.0,-1.0,-1.0,3.0,-0.5}},np.float16); local r=np.sum(a,1); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{3.0,2.0,-0.75,3.0,-2.5},2e-3),'half sum 539') end
do local a=np.array({{3.0,3.0,0.25,0.0,-2.0},{0.0,-1.0,-1.0,3.0,-0.5}},np.float16); local r=np.prod(a,1); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{0.0,-3.0,-0.25,0.0,1.0},2e-3),'half prod 540') end
do local a=np.array({{3.0,3.0,0.25,0.0,-2.0},{0.0,-1.0,-1.0,3.0,-0.5}},np.float16); local r=np.mean(a,1); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{1.5,1.0,-0.375,1.5,-1.25},2e-3),'half mean 541') end
do local a=np.array({{0.0,1.0,2.0,-1.0,-0.5},{2.0,1.0,-0.5,2.0,-1.0}},np.float16); local r=np.sum(a,2); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{1.5,3.5},2e-3),'half sum 542') end
do local a=np.array({{0.0,1.0,2.0,-1.0,-0.5},{2.0,1.0,-0.5,2.0,-1.0}},np.float16); local r=np.prod(a,2); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{0.0,2.0},2e-3),'half prod 543') end
do local a=np.array({{0.0,1.0,2.0,-1.0,-0.5},{2.0,1.0,-0.5,2.0,-1.0}},np.float16); local r=np.mean(a,2); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{0.300048828125,0.7001953125},2e-3),'half mean 544') end
do local a=np.array({-2.0,1.0,1.0,0.0,1.0,-2.0,-2.0},np.float16); local r=np.sum(a,1); assert(close(r,-3.0,2e-3),'half sum scalar 545') end
do local a=np.array({-2.0,1.0,1.0,0.0,1.0,-2.0,-2.0},np.float16); local r=np.prod(a,1); assert(close(r,-0.0,2e-3),'half prod scalar 546') end
do local a=np.array({-2.0,1.0,1.0,0.0,1.0,-2.0,-2.0},np.float16); local r=np.mean(a,1); assert(close(r,-0.428466796875,2e-3),'half mean scalar 547') end
do local a=np.array({-2.0,-0.5,-0.5,3.0,3.0,-1.0,0.25},np.float16); local r=np.sum(a,1); assert(close(r,2.25,2e-3),'half sum scalar 548') end
do local a=np.array({-2.0,-0.5,-0.5,3.0,3.0,-1.0,0.25},np.float16); local r=np.prod(a,1); assert(close(r,1.125,2e-3),'half prod scalar 549') end
do local a=np.array({-2.0,-0.5,-0.5,3.0,3.0,-1.0,0.25},np.float16); local r=np.mean(a,1); assert(close(r,0.321533203125,2e-3),'half mean scalar 550') end
do local a=np.array({{{1.0,1.0,3.0,0.25},{2.0,-1.0,-2.0,0.0},{-2.0,-2.0,-0.5,0.25}},{{0.25,3.0,1.0,1.0},{3.0,0.25,-1.0,2.0},{3.0,3.0,-1.0,-0.5}}},np.float16); local r=np.sum(a,2); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{1.0,-2.0,0.5,0.5},{6.25,6.25,-1.0,2.5}},2e-3),'half sum 551') end
do local a=np.array({{{1.0,1.0,3.0,0.25},{2.0,-1.0,-2.0,0.0},{-2.0,-2.0,-0.5,0.25}},{{0.25,3.0,1.0,1.0},{3.0,0.25,-1.0,2.0},{3.0,3.0,-1.0,-0.5}}},np.float16); local r=np.prod(a,2); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{-4.0,2.0,3.0,0.0},{2.25,2.25,1.0,-1.0}},2e-3),'half prod 552') end
do local a=np.array({{{1.0,1.0,3.0,0.25},{2.0,-1.0,-2.0,0.0},{-2.0,-2.0,-0.5,0.25}},{{0.25,3.0,1.0,1.0},{3.0,0.25,-1.0,2.0},{3.0,3.0,-1.0,-0.5}}},np.float16); local r=np.mean(a,2); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{0.333251953125,-0.66650390625,0.1666259765625,0.1666259765625},{2.083984375,2.083984375,-0.333251953125,0.83349609375}},2e-3),'half mean 553') end
do local a=np.array({{{-1.0,0.25,0.0,0.0},{2.0,3.0,3.0,0.0},{-2.0,1.0,2.0,-2.0}},{{-0.5,1.0,0.25,3.0},{0.25,-1.0,0.25,-1.0},{-0.5,-0.5,2.0,-2.0}}},np.float16); local r=np.sum(a,3); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{-0.75,8.0,-1.0},{3.75,-1.5,-1.0}},2e-3),'half sum 554') end
do local a=np.array({{{-1.0,0.25,0.0,0.0},{2.0,3.0,3.0,0.0},{-2.0,1.0,2.0,-2.0}},{{-0.5,1.0,0.25,3.0},{0.25,-1.0,0.25,-1.0},{-0.5,-0.5,2.0,-2.0}}},np.float16); local r=np.prod(a,3); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{-0.0,0.0,8.0},{-0.375,0.0625,-1.0}},2e-3),'half prod 555') end
do local a=np.array({{{-1.0,0.25,0.0,0.0},{2.0,3.0,3.0,0.0},{-2.0,1.0,2.0,-2.0}},{{-0.5,1.0,0.25,3.0},{0.25,-1.0,0.25,-1.0},{-0.5,-0.5,2.0,-2.0}}},np.float16); local r=np.mean(a,3); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{-0.1875,2.0,-0.25},{0.9375,-0.375,-0.25}},2e-3),'half mean 556') end
do local a=np.array({3.0,2.0,0.0,-1.0,0.0,1.0,-0.5},np.float16); local r=np.sum(a,1); assert(close(r,4.5,2e-3),'half sum scalar 557') end
do local a=np.array({3.0,2.0,0.0,-1.0,0.0,1.0,-0.5},np.float16); local r=np.prod(a,1); assert(close(r,0.0,2e-3),'half prod scalar 558') end
do local a=np.array({3.0,2.0,0.0,-1.0,0.0,1.0,-0.5},np.float16); local r=np.mean(a,1); assert(close(r,0.64306640625,2e-3),'half mean scalar 559') end
do local a=np.array({2.0,3.0,-0.5,0.0,1.0,-2.0,1.0},np.float16); local r=np.sum(a,1); assert(close(r,4.5,2e-3),'half sum scalar 560') end
do local a=np.array({2.0,3.0,-0.5,0.0,1.0,-2.0,1.0},np.float16); local r=np.prod(a,1); assert(close(r,0.0,2e-3),'half prod scalar 561') end
do local a=np.array({2.0,3.0,-0.5,0.0,1.0,-2.0,1.0},np.float16); local r=np.mean(a,1); assert(close(r,0.64306640625,2e-3),'half mean scalar 562') end
do local a=np.array({{{-1.0,-1.0,3.0,3.0},{-1.0,1.0,3.0,1.0},{3.0,-2.0,0.0,-1.0}},{{0.25,3.0,1.0,-0.5},{0.0,0.0,-1.0,-2.0},{-2.0,0.0,2.0,3.0}}},np.float16); local r=np.sum(a,2); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{1.0,-2.0,6.0,3.0},{-1.75,3.0,2.0,0.5}},2e-3),'half sum 563') end
do local a=np.array({{{-1.0,-1.0,3.0,3.0},{-1.0,1.0,3.0,1.0},{3.0,-2.0,0.0,-1.0}},{{0.25,3.0,1.0,-0.5},{0.0,0.0,-1.0,-2.0},{-2.0,0.0,2.0,3.0}}},np.float16); local r=np.prod(a,2); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{3.0,2.0,0.0,-3.0},{-0.0,0.0,-2.0,3.0}},2e-3),'half prod 564') end
do local a=np.array({{{-1.0,-1.0,3.0,3.0},{-1.0,1.0,3.0,1.0},{3.0,-2.0,0.0,-1.0}},{{0.25,3.0,1.0,-0.5},{0.0,0.0,-1.0,-2.0},{-2.0,0.0,2.0,3.0}}},np.float16); local r=np.mean(a,2); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{0.333251953125,-0.66650390625,2.0,1.0},{-0.58349609375,1.0,0.66650390625,0.1666259765625}},2e-3),'half mean 565') end
do local a=np.array({{{-2.0,1.0,2.0,-0.5},{0.25,2.0,0.25,2.0},{0.25,0.0,0.25,-2.0}},{{-2.0,-0.5,-0.5,0.0},{3.0,1.0,3.0,2.0},{0.25,0.0,-2.0,0.25}}},np.float16); local r=np.sum(a,3); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{0.5,4.5,-1.5},{-3.0,9.0,-1.5}},2e-3),'half sum 566') end
do local a=np.array({{{-2.0,1.0,2.0,-0.5},{0.25,2.0,0.25,2.0},{0.25,0.0,0.25,-2.0}},{{-2.0,-0.5,-0.5,0.0},{3.0,1.0,3.0,2.0},{0.25,0.0,-2.0,0.25}}},np.float16); local r=np.prod(a,3); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{2.0,0.25,-0.0},{-0.0,18.0,-0.0}},2e-3),'half prod 567') end
do local a=np.array({{{-2.0,1.0,2.0,-0.5},{0.25,2.0,0.25,2.0},{0.25,0.0,0.25,-2.0}},{{-2.0,-0.5,-0.5,0.0},{3.0,1.0,3.0,2.0},{0.25,0.0,-2.0,0.25}}},np.float16); local r=np.mean(a,3); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{0.125,1.125,-0.375},{-0.75,2.25,-0.375}},2e-3),'half mean 568') end
do local a=np.array({1.0,0.0,-2.0,1.0,1.0,1.0,1.0},np.float16); local r=np.sum(a,1); assert(close(r,3.0,2e-3),'half sum scalar 569') end
do local a=np.array({1.0,0.0,-2.0,1.0,1.0,1.0,1.0},np.float16); local r=np.prod(a,1); assert(close(r,-0.0,2e-3),'half prod scalar 570') end
do local a=np.array({1.0,0.0,-2.0,1.0,1.0,1.0,1.0},np.float16); local r=np.mean(a,1); assert(close(r,0.428466796875,2e-3),'half mean scalar 571') end
do local a=np.array({{{-1.0,2.0,-2.0,3.0},{0.0,2.0,3.0,0.25},{2.0,2.0,1.0,0.0}},{{0.0,1.0,2.0,-2.0},{-2.0,-0.5,2.0,-0.5},{-2.0,-0.5,0.25,2.0}}},np.float16); local r=np.sum(a,1); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{-1.0,3.0,0.0,1.0},{-2.0,1.5,5.0,-0.25},{0.0,1.5,1.25,2.0}},2e-3),'half sum 572') end
do local a=np.array({{{-1.0,2.0,-2.0,3.0},{0.0,2.0,3.0,0.25},{2.0,2.0,1.0,0.0}},{{0.0,1.0,2.0,-2.0},{-2.0,-0.5,2.0,-0.5},{-2.0,-0.5,0.25,2.0}}},np.float16); local r=np.prod(a,1); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{-0.0,2.0,-4.0,-6.0},{-0.0,-1.0,6.0,-0.125},{-4.0,-1.0,0.25,0.0}},2e-3),'half prod 573') end
do local a=np.array({{{-1.0,2.0,-2.0,3.0},{0.0,2.0,3.0,0.25},{2.0,2.0,1.0,0.0}},{{0.0,1.0,2.0,-2.0},{-2.0,-0.5,2.0,-0.5},{-2.0,-0.5,0.25,2.0}}},np.float16); local r=np.mean(a,1); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{-0.5,1.5,0.0,0.5},{-1.0,0.75,2.5,-0.125},{0.0,0.75,0.625,1.0}},2e-3),'half mean 574') end
do local a=np.array({{{3.0,3.0,3.0,1.0},{1.0,1.0,-1.0,-1.0},{-1.0,3.0,0.0,0.0}},{{-2.0,2.0,-2.0,0.0},{1.0,1.0,-2.0,-1.0},{1.0,0.25,3.0,1.0}}},np.float16); local r=np.sum(a,1); assert(r.dtype=='float16','half sum dtype'); assert(close(r:tolist(),{{1.0,5.0,1.0,1.0},{2.0,2.0,-3.0,-2.0},{0.0,3.25,3.0,1.0}},2e-3),'half sum 575') end
do local a=np.array({{{3.0,3.0,3.0,1.0},{1.0,1.0,-1.0,-1.0},{-1.0,3.0,0.0,0.0}},{{-2.0,2.0,-2.0,0.0},{1.0,1.0,-2.0,-1.0},{1.0,0.25,3.0,1.0}}},np.float16); local r=np.prod(a,1); assert(r.dtype=='float16','half prod dtype'); assert(close(r:tolist(),{{-6.0,6.0,-6.0,0.0},{1.0,1.0,2.0,1.0},{-1.0,0.75,0.0,0.0}},2e-3),'half prod 576') end
do local a=np.array({{{3.0,3.0,3.0,1.0},{1.0,1.0,-1.0,-1.0},{-1.0,3.0,0.0,0.0}},{{-2.0,2.0,-2.0,0.0},{1.0,1.0,-2.0,-1.0},{1.0,0.25,3.0,1.0}}},np.float16); local r=np.mean(a,1); assert(r.dtype=='float16','half mean dtype'); assert(close(r:tolist(),{{0.5,2.5,0.5,0.5},{1.0,1.0,-1.5,-1.0},{0.0,1.625,1.5,0.5}},2e-3),'half mean 577') end
do local a=np.ones({10017},np.float16); for i=1,10000 do a[i]=0.1 end; assert(close(np.sum(a),1017.0,0),'half pairwise sum') end
do local a=np.array({0.5,1.25,-0.75,2.0,0.125},np.float16); local r=np.add_accumulate(a); assert(r.dtype=='float16' and close(r:tolist(),{0.5,1.75,1.0,3.0,3.125},0),'half accumulate') end
do local a=np.array({{0.0,1.0},{1.0,1.0},{2.0,2.0}},np.float16); local b=np.array({{0.0,0.5,0.0,0.0},{-2.0,-0.5,0.5,0.5}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-2.0,-0.5,0.5,0.5},{-2.0,0.0,0.5,0.5},{-4.0,0.0,1.0,1.0}},0),'half matmul 580') end
do local a=np.array({{0.5,1.0,2.0,0.5},{0.0,-0.5,-2.0,0.5}},np.float16); local b=np.array({{0.0,0.0},{-1.0,-1.0},{-1.0,-2.0},{2.0,0.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-2.0,-5.0},{3.5,4.5}},0),'half matmul 581') end
do local a=np.array({{1.0,-1.0,-0.5,1.0}},np.float16); local b=np.array({{-1.0,-2.0},{-2.0,-0.5},{1.0,-1.0},{-0.5,-1.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{0.0,-2.0}},0),'half matmul 582') end
do local a=np.array({{1.0,-2.0,-0.5}},np.float16); local b=np.array({{2.0,2.0,0.0,1.0},{0.5,-2.0,-0.5,0.5},{0.0,1.0,1.0,-1.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{1.0,5.5,0.5,0.5}},0),'half matmul 583') end
do local a=np.array({{0.5,1.0,0.0}},np.float16); local b=np.array({{0.0,1.0,0.5},{2.0,-0.5,-0.5},{0.0,-1.0,2.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{2.0,0.0,-0.25}},0),'half matmul 584') end
do local a=np.array({{-1.0,1.0,-1.0},{1.0,0.0,-1.0},{-2.0,-1.0,1.0},{0.0,2.0,-2.0}},np.float16); local b=np.array({{0.5},{0.5},{-2.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{2.0},{2.5},{-3.5},{5.0}},0),'half matmul 585') end
do local a=np.array({{-2.0,-2.0,-2.0}},np.float16); local b=np.array({{0.0,2.0,-0.5},{0.5,-1.0,1.0},{-2.0,-1.0,-1.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{3.0,0.0,1.0}},0),'half matmul 586') end
do local a=np.array({{1.0,1.0}},np.float16); local b=np.array({{2.0,-1.0,2.0},{0.0,-0.5,-0.5}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{2.0,-1.5,1.5}},0),'half matmul 587') end
do local a=np.array({{0.5,-1.0},{0.0,0.5},{-2.0,-2.0},{-0.5,0.5}},np.float16); local b=np.array({{-0.5,-0.5,2.0,2.0},{1.0,-1.0,-0.5,2.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-1.25,0.75,1.5,-1.0},{0.5,-0.5,-0.25,1.0},{-1.0,3.0,-3.0,-8.0},{0.75,-0.25,-1.25,0.0}},0),'half matmul 588') end
do local a=np.array({{0.5},{-0.5},{-2.0}},np.float16); local b=np.array({{0.5,0.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{0.25,0.0},{-0.25,0.0},{-1.0,0.0}},0),'half matmul 589') end
do local a=np.array({{1.0,-2.0,-2.0},{-0.5,-0.5,-2.0}},np.float16); local b=np.array({{0.0},{-2.0},{-0.5}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{5.0},{2.0}},0),'half matmul 590') end
do local a=np.array({{0.0,-2.0,-0.5},{-2.0,-2.0,-1.0},{-1.0,1.0,-2.0},{0.0,-0.5,-2.0}},np.float16); local b=np.array({{1.0,1.0,2.0,-2.0},{-0.5,-0.5,-2.0,2.0},{-1.0,-1.0,0.0,-1.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{1.5,1.5,4.0,-3.5},{0.0,0.0,0.0,1.0},{0.5,0.5,-4.0,6.0},{2.25,2.25,1.0,1.0}},0),'half matmul 591') end
do local a=np.array({{0.0,1.0,0.0,2.0},{-2.0,0.0,1.0,-1.0},{2.0,2.0,0.5,-0.5},{-0.5,1.0,-0.5,2.0}},np.float16); local b=np.array({{1.0,-1.0},{-0.5,2.0},{-0.5,0.0},{-2.0,2.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-4.5,6.0},{-0.5,0.0},{1.75,1.0},{-4.75,6.5}},0),'half matmul 592') end
do local a=np.array({{0.5},{1.0}},np.float16); local b=np.array({{-2.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-1.0},{-2.0}},0),'half matmul 593') end
do local a=np.array({{0.5,1.0},{0.5,1.0},{0.5,2.0},{0.0,-1.0}},np.float16); local b=np.array({{-2.0,-0.5,-1.0,0.5},{0.0,-1.0,0.5,-0.5}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-1.0,-1.25,0.0,-0.25},{-1.0,-1.25,0.0,-0.25},{-1.0,-2.25,0.5,-0.75},{0.0,1.0,-0.5,0.5}},0),'half matmul 594') end
do local a=np.array({{0.5,-1.0},{1.0,-2.0},{-1.0,1.0},{-2.0,2.0}},np.float16); local b=np.array({{1.0,-0.5},{0.0,-0.5}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{0.5,0.25},{1.0,0.5},{-1.0,0.0},{-2.0,0.0}},0),'half matmul 595') end
do local a=np.array({{1.0,0.5},{-1.0,0.5}},np.float16); local b=np.array({{-1.0,0.0,-1.0,-1.0},{1.0,-1.0,-2.0,0.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-0.5,-0.5,-2.0,-1.0},{1.5,-0.5,0.0,1.0}},0),'half matmul 596') end
do local a=np.array({{-2.0,0.0,0.5},{-1.0,0.0,2.0},{-2.0,1.0,0.5}},np.float16); local b=np.array({{-0.5},{-1.0},{-2.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{0.0},{-3.5},{-1.0}},0),'half matmul 597') end
do local a=np.array({{1.0},{-0.5},{0.0}},np.float16); local b=np.array({{-0.5,2.0,0.5}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-0.5,2.0,0.5},{0.25,-1.0,-0.25},{0.0,0.0,0.0}},0),'half matmul 598') end
do local a=np.array({{1.0},{2.0},{-1.0},{0.5}},np.float16); local b=np.array({{-0.5,1.0,-2.0,-0.5}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-0.5,1.0,-2.0,-0.5},{-1.0,2.0,-4.0,-1.0},{0.5,-1.0,2.0,0.5},{-0.25,0.5,-1.0,-0.25}},0),'half matmul 599') end
do local a=np.array({{0.0,-1.0,0.0,-1.0},{-0.5,1.0,0.0,-1.0}},np.float16); local b=np.array({{1.0},{-1.0},{-1.0},{0.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{1.0},{-1.5}},0),'half matmul 600') end
do local a=np.array({{0.5,-0.5},{-2.0,-2.0},{-2.0,2.0}},np.float16); local b=np.array({{-2.0,0.5},{-2.0,1.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{0.0,-0.25},{8.0,-3.0},{0.0,1.0}},0),'half matmul 601') end
do local a=np.array({{0.0,-2.0,-0.5,-0.5},{0.0,-1.0,-0.5,2.0},{0.0,-0.5,1.0,1.0},{0.5,-2.0,1.0,-1.0}},np.float16); local b=np.array({{-1.0,0.5},{-0.5,0.0},{2.0,2.0},{2.0,-0.5}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-1.0,-0.75},{3.5,-2.0},{4.25,1.5},{0.5,2.75}},0),'half matmul 602') end
do local a=np.array({{2.0,1.0,1.0}},np.float16); local b=np.array({{-2.0,1.0,0.5},{0.5,0.0,2.0},{0.0,0.0,-1.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-3.5,2.0,2.0}},0),'half matmul 603') end
do local a=np.array({{0.5,0.5},{1.0,0.5}},np.float16); local b=np.array({{0.0},{0.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{0.0},{0.0}},0),'half matmul 604') end
do local a=np.array({{1.0},{1.0}},np.float16); local b=np.array({{1.0,0.5,-0.5,1.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{1.0,0.5,-0.5,1.0},{1.0,0.5,-0.5,1.0}},0),'half matmul 605') end
do local a=np.array({{-0.5,2.0,0.0},{1.0,0.5,2.0},{-1.0,0.5,0.0},{-0.5,1.0,-1.0}},np.float16); local b=np.array({{-0.5},{-0.5},{-0.5}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-0.75},{-1.75},{0.25},{0.25}},0),'half matmul 606') end
do local a=np.array({{0.5},{-1.0}},np.float16); local b=np.array({{-2.0,-1.0,-2.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-1.0,-0.5,-1.0},{2.0,1.0,2.0}},0),'half matmul 607') end
do local a=np.array({{-1.0},{0.0},{-0.5},{0.0}},np.float16); local b=np.array({{1.0,2.0,2.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-1.0,-2.0,-2.0},{0.0,0.0,0.0},{-0.5,-1.0,-1.0},{0.0,0.0,0.0}},0),'half matmul 608') end
do local a=np.array({{-2.0,-2.0},{-0.5,1.0},{1.0,-1.0},{-0.5,0.5}},np.float16); local b=np.array({{2.0,0.0,1.0,0.0},{-2.0,-0.5,-0.5,-1.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{0.0,1.0,-1.0,2.0},{-3.0,-0.5,-1.0,-1.0},{4.0,0.5,1.5,1.0},{-2.0,-0.25,-0.75,-0.5}},0),'half matmul 609') end
do local a=np.array({{0.0},{0.0},{0.0},{0.5}},np.float16); local b=np.array({{-1.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{0.0},{0.0},{0.0},{-0.5}},0),'half matmul 610') end
do local a=np.array({{-2.0,-0.5,-1.0},{-0.5,0.5,-2.0},{-2.0,2.0,-0.5},{-1.0,-2.0,-1.0}},np.float16); local b=np.array({{0.5,2.0,1.0},{2.0,-1.0,-2.0},{0.0,-0.5,2.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-2.0,-3.0,-3.0},{0.75,-0.5,-5.5},{3.0,-5.75,-7.0},{-4.5,0.5,1.0}},0),'half matmul 611') end
do local a=np.array({{0.5,2.0,1.0}},np.float16); local b=np.array({{-0.5},{1.0},{2.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{3.75}},0),'half matmul 612') end
do local a=np.array({{1.0}},np.float16); local b=np.array({{2.0,0.5,-0.5,-0.5}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{2.0,0.5,-0.5,-0.5}},0),'half matmul 613') end
do local a=np.array({{-2.0},{-2.0},{-0.5},{-1.0}},np.float16); local b=np.array({{-2.0,-1.0,-1.0,-0.5}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{4.0,2.0,2.0,1.0},{4.0,2.0,2.0,1.0},{1.0,0.5,0.5,0.25},{2.0,1.0,1.0,0.5}},0),'half matmul 614') end
do local a=np.array({{-0.5,-0.5,1.0,2.0},{1.0,0.5,-1.0,0.0},{-1.0,1.0,2.0,0.5},{-0.5,-1.0,-0.5,1.0}},np.float16); local b=np.array({{0.0,1.0,-0.5},{1.0,-0.5,1.0},{-0.5,-0.5,0.5},{0.0,2.0,-2.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-1.0,3.25,-3.75},{1.0,1.25,-0.5},{0.0,-1.5,1.5},{-0.75,2.25,-3.0}},0),'half matmul 615') end
do local a=np.array({{2.0,-1.0,0.0,-0.5}},np.float16); local b=np.array({{0.0,0.5,-0.5},{2.0,0.0,0.5},{-0.5,2.0,0.0},{-1.0,-1.0,-2.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-1.5,1.5,-0.5}},0),'half matmul 616') end
do local a=np.array({{0.0},{-1.0},{-1.0}},np.float16); local b=np.array({{-1.0,-1.0,0.5,-2.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{0.0,0.0,0.0,0.0},{1.0,1.0,-0.5,2.0},{1.0,1.0,-0.5,2.0}},0),'half matmul 617') end
do local a=np.array({{-2.0,0.0,2.0,0.0}},np.float16); local b=np.array({{-1.0,0.0,0.0},{0.5,-1.0,1.0},{2.0,-2.0,-0.5},{-2.0,0.0,2.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{6.0,-4.0,-1.0}},0),'half matmul 618') end
do local a=np.array({{-0.5,-2.0,-2.0},{-0.5,0.0,1.0},{-2.0,-0.5,-1.0}},np.float16); local b=np.array({{0.0},{2.0},{0.5}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-5.0},{0.5},{-1.5}},0),'half matmul 619') end
do local a=np.array({{-2.0,-1.0}},np.float16); local b=np.array({{-0.5,-2.0,-2.0,-1.0},{0.5,2.0,2.0,0.5}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{0.5,2.0,2.0,1.5}},0),'half matmul 620') end
do local a=np.array({{-0.5}},np.float16); local b=np.array({{0.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{0.0}},0),'half matmul 621') end
do local a=np.array({{0.5,0.0,0.5,-0.5},{1.0,-0.5,2.0,-1.0},{-0.5,0.0,-1.0,-2.0},{1.0,-1.0,-0.5,-0.5}},np.float16); local b=np.array({{-1.0,1.0},{2.0,-1.0},{0.5,2.0},{2.0,0.5}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-1.25,1.25},{-3.0,5.0},{-4.0,-3.5},{-4.25,0.75}},0),'half matmul 622') end
do local a=np.array({{1.0,-0.5,0.5},{0.0,-1.0,1.0},{0.5,0.5,-2.0}},np.float16); local b=np.array({{0.0,2.0},{0.5,0.5},{-2.0,-2.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-1.25,0.75},{-2.5,-2.5},{4.25,5.25}},0),'half matmul 623') end
do local a=np.array({{2.0}},np.float16); local b=np.array({{-1.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-2.0}},0),'half matmul 624') end
do local a=np.array({{2.0,1.0},{0.0,1.0},{0.5,0.0}},np.float16); local b=np.array({{0.5,0.5,1.0,0.5},{-1.0,-1.0,-1.0,-2.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{0.0,0.0,1.0,-1.0},{-1.0,-1.0,-1.0,-2.0},{0.25,0.25,0.5,0.25}},0),'half matmul 625') end
do local a=np.array({{-1.0,2.0,-2.0,-2.0}},np.float16); local b=np.array({{0.5,0.0,0.0,0.5},{-1.0,0.5,0.5,-0.5},{-0.5,-2.0,-0.5,1.0},{-0.5,1.0,-1.0,2.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-0.5,3.0,4.0,-7.5}},0),'half matmul 626') end
do local a=np.array({{-0.5,2.0}},np.float16); local b=np.array({{-0.5,0.5,1.0,0.0},{2.0,2.0,1.0,-0.5}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{4.25,3.75,1.5,-1.0}},0),'half matmul 627') end
do local a=np.array({{0.5,2.0,-2.0},{-1.0,2.0,0.5},{-0.5,0.0,-2.0},{1.0,1.0,-0.5}},np.float16); local b=np.array({{-1.0},{0.5},{1.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-1.5},{2.5},{-1.5},{-1.0}},0),'half matmul 628') end
do local a=np.array({{0.0},{-1.0}},np.float16); local b=np.array({{-2.0,0.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{0.0,0.0},{2.0,0.0}},0),'half matmul 629') end
do local a=np.array({{-0.5,2.0,-0.5,-1.0},{0.5,0.0,-1.0,-1.0}},np.float16); local b=np.array({{-1.0,1.0,0.0,-1.0},{0.5,0.5,2.0,0.0},{0.5,0.5,2.0,0.0},{0.0,2.0,0.0,2.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{1.25,-1.75,3.0,-1.5},{-1.0,-2.0,-2.0,-2.5}},0),'half matmul 630') end
do local a=np.array({{0.0,1.0,-0.5,-0.5}},np.float16); local b=np.array({{0.0,1.0,-1.0},{-0.5,0.0,2.0},{0.5,-0.5,0.0},{2.0,-2.0,2.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-1.75,1.25,1.0}},0),'half matmul 631') end
do local a=np.array({{1.0,2.0,-2.0},{0.5,2.0,1.0},{0.5,1.0,2.0},{1.0,-1.0,2.0}},np.float16); local b=np.array({{-2.0},{-2.0},{0.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-6.0},{-5.0},{-3.0},{0.0}},0),'half matmul 632') end
do local a=np.array({{-1.0,1.0,2.0},{0.0,-0.5,0.5}},np.float16); local b=np.array({{1.0,-0.5},{1.0,1.0},{2.0,-1.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{4.0,-0.5},{0.5,-1.0}},0),'half matmul 633') end
do local a=np.array({{1.0,2.0},{-1.0,-1.0},{-0.5,2.0},{-0.5,-1.0}},np.float16); local b=np.array({{-2.0,-1.0},{-2.0,0.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-6.0,-1.0},{4.0,1.0},{-3.0,0.5},{3.0,0.5}},0),'half matmul 634') end
do local a=np.array({{1.0},{2.0},{0.5}},np.float16); local b=np.array({{-2.0,-2.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-2.0,-2.0},{-4.0,-4.0},{-1.0,-1.0}},0),'half matmul 635') end
do local a=np.array({{0.5}},np.float16); local b=np.array({{-2.0,-0.5}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-1.0,-0.25}},0),'half matmul 636') end
do local a=np.array({{2.0,0.0,1.0}},np.float16); local b=np.array({{-0.5},{0.0},{-1.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{-2.0}},0),'half matmul 637') end
do local a=np.array({{1.0,-1.0,-1.0},{-0.5,0.5,-0.5},{2.0,0.5,2.0},{-1.0,2.0,0.0}},np.float16); local b=np.array({{2.0,-0.5},{1.0,-2.0},{0.0,0.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{1.0,1.5},{-0.5,-0.75},{4.5,-2.0},{0.0,-3.5}},0),'half matmul 638') end
do local a=np.array({{1.0,0.0,0.0}},np.float16); local b=np.array({{1.0,-1.0,0.5,-1.0},{0.5,0.0,2.0,-0.5},{1.0,2.0,0.0,2.0}},np.float16); local r=np.matmul(a,b); assert(r.dtype=='float16' and close(r:tolist(),{{1.0,-1.0,0.5,-1.0}},0),'half matmul 639') end
do local a=np.array({-1.0,2.0,1.0,0.0,-2.0,0.0,-1.0,0.5,-1.0,2.0,-2.0,0.5},np.float16); local b=np.array({0.0,-1.0,-1.0,0.5,1.0,-1.0,0.0,1.0,-0.5,1.0,0.5,0.5},np.float16); assert(close(np.dot(a,b),-2.75,0),'half dot 640') end
do local a=np.array({2.0,0.0,0.0,1.0,-0.5,-2.0,-2.0,-0.5,-2.0,0.5,-1.0,0.5,-0.5,2.0,1.0,0.5},np.float16); local b=np.array({-2.0,0.0,2.0,2.0,0.0,-1.0,2.0,0.5,-0.5,1.0,-1.0,-0.5,-1.0,2.0,-1.0,-0.5},np.float16); assert(close(np.dot(a,b),1.25,0),'half dot 641') end
do local a=np.array({2.0,0.0,-1.0},np.float16); local b=np.array({0.5,-2.0,0.5},np.float16); assert(close(np.dot(a,b),0.5,0),'half dot 642') end
do local a=np.array({0.5,0.5,-1.0,0.0,-2.0,0.0,0.0,0.0,-0.5,2.0,1.0,0.0},np.float16); local b=np.array({0.5,0.5,-2.0,1.0,0.5,1.0,-0.5,-2.0,0.0,2.0,1.0,-2.0},np.float16); assert(close(np.dot(a,b),6.5,0),'half dot 643') end
do local a=np.array({0.0,1.0,0.5},np.float16); local b=np.array({0.0,1.0,2.0},np.float16); assert(close(np.dot(a,b),2.0,0),'half dot 644') end
do local a=np.array({-1.0,0.5,0.0,-2.0,-1.0,-1.0,-2.0,0.5,-0.5,-0.5,1.0,1.0,0.5},np.float16); local b=np.array({-0.5,1.0,2.0,-1.0,-2.0,0.0,0.0,0.5,2.0,-2.0,1.0,2.0,0.0},np.float16); assert(close(np.dot(a,b),8.25,0),'half dot 645') end
do local a=np.array({0.0,0.0,0.5,-2.0,1.0},np.float16); local b=np.array({0.5,-1.0,2.0,-0.5,2.0},np.float16); assert(close(np.dot(a,b),4.0,0),'half dot 646') end
do local a=np.array({2.0,1.0,-0.5,-0.5,1.0,1.0,-2.0,-0.5,-0.5},np.float16); local b=np.array({2.0,-1.0,0.0,-2.0,-2.0,0.5,0.5,-2.0,0.0},np.float16); assert(close(np.dot(a,b),2.5,0),'half dot 647') end
do local a=np.array({-1.0,0.0},np.float16); local b=np.array({-0.5,2.0},np.float16); assert(close(np.dot(a,b),0.5,0),'half dot 648') end
do local a=np.array({2.0,-2.0,0.5,0.5,0.0,0.0,0.5,-0.5,-2.0,-0.5,-2.0,0.0,-1.0,-1.0,2.0,-2.0},np.float16); local b=np.array({-2.0,-0.5,-0.5,0.5,-1.0,2.0,1.0,1.0,-0.5,0.5,-2.0,0.5,-0.5,-2.0,-0.5,0.0},np.float16); assert(close(np.dot(a,b),3.25,0),'half dot 649') end
do local a=np.array({0.5,0.0,-0.5,-2.0,-1.0,-2.0,0.0,1.0,0.0,-2.0,-2.0},np.float16); local b=np.array({1.0,-0.5,-2.0,1.0,0.0,1.0,-1.0,0.0,-0.5,0.5,-0.5},np.float16); assert(close(np.dot(a,b),-2.5,0),'half dot 650') end
do local a=np.array({0.0},np.float16); local b=np.array({2.0},np.float16); assert(close(np.dot(a,b),0.0,0),'half dot 651') end
do local a=np.array({0.5,-0.5,-2.0},np.float16); local b=np.array({-1.0,2.0,2.0},np.float16); assert(close(np.dot(a,b),-5.5,0),'half dot 652') end
do local a=np.array({2.0},np.float16); local b=np.array({2.0},np.float16); assert(close(np.dot(a,b),4.0,0),'half dot 653') end
do local a=np.array({1.0,-0.5,1.0,0.5,-0.5},np.float16); local b=np.array({-1.0,-0.5,-1.0,1.0,0.5},np.float16); assert(close(np.dot(a,b),-1.5,0),'half dot 654') end
do local a=np.array({2.0,0.0,1.0,-2.0,-2.0,0.5,-1.0,1.0},np.float16); local b=np.array({2.0,2.0,-2.0,-0.5,-2.0,2.0,-1.0,-2.0},np.float16); assert(close(np.dot(a,b),7.0,0),'half dot 655') end
do local a=np.array({-2.0,0.0,-2.0,-1.0,-1.0,0.0,1.0,2.0,0.0,0.5,-0.5},np.float16); local b=np.array({-1.0,-2.0,0.0,-0.5,-0.5,-1.0,0.5,-1.0,2.0,0.5,2.0},np.float16); assert(close(np.dot(a,b),0.75,0),'half dot 656') end
do local a=np.array({2.0,-1.0},np.float16); local b=np.array({2.0,0.5},np.float16); assert(close(np.dot(a,b),3.5,0),'half dot 657') end
do local a=np.array({1.0,-2.0},np.float16); local b=np.array({-0.5,-1.0},np.float16); assert(close(np.dot(a,b),1.5,0),'half dot 658') end
do local a=np.array({0.0,0.0,2.0,-2.0,2.0,0.5,1.0,-1.0,-0.5,0.5,1.0,1.0,0.0,2.0,-0.5,0.0},np.float16); local b=np.array({-2.0,-2.0,0.0,-2.0,0.5,2.0,0.0,1.0,0.5,-2.0,0.0,-0.5,0.0,-1.0,2.0,-0.5},np.float16); assert(close(np.dot(a,b),0.25,0),'half dot 659') end
do local a=np.array({-2.0,0.0,2.0,2.0,0.5,0.5,-2.0,0.5},np.float16); local b=np.array({0.5,0.5,-0.5,-0.5,-0.5,1.0,2.0,2.0},np.float16); assert(close(np.dot(a,b),-5.75,0),'half dot 660') end
do local a=np.array({0.5,1.0,0.0,2.0,0.5,0.0},np.float16); local b=np.array({1.0,-1.0,0.5,0.0,-0.5,1.0},np.float16); assert(close(np.dot(a,b),-0.75,0),'half dot 661') end
do local a=np.array({0.5,1.0,-2.0},np.float16); local b=np.array({-0.5,-1.0,0.5},np.float16); assert(close(np.dot(a,b),-2.25,0),'half dot 662') end
do local a=np.array({0.5,0.0,-2.0},np.float16); local b=np.array({0.0,2.0,-1.0},np.float16); assert(close(np.dot(a,b),2.0,0),'half dot 663') end
do local a=np.array({-1.0,2.0,2.0,0.0,1.0,1.0,0.0,-1.0,0.0,1.0,-1.0},np.float16); local b=np.array({-1.0,1.0,-2.0,1.0,0.5,-0.5,0.0,-2.0,0.0,0.0,-0.5},np.float16); assert(close(np.dot(a,b),1.5,0),'half dot 664') end
do local a=np.array({1.0,-2.0,4.0,(0/0),-4.0,-0.0,0.0,-0.0,-0.0,0.0,2.0,0.5},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-2.0,-0.0,-0.0,-0.0,0.0,0.0,0.5,1.0,2.0,4.0,(0/0)},0),'half sort 665'); local q=np.argsort(a); assert(eq(q:tolist(),{5,2,6,7,8,9,10,12,1,11,3,4}),'half argsort 665') end
do local a=np.array({-4.0,-0.0,0.0,-4.0,1.0,-1.0,0.0,0.5,2.0,-1.0,2.0,4.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-4.0,-1.0,-1.0,-0.0,0.0,0.0,0.5,1.0,2.0,2.0,4.0},0),'half sort 666'); local q=np.argsort(a); assert(eq(q:tolist(),{1,4,6,10,2,3,7,8,5,9,11,12}),'half argsort 666') end
do local a=np.array({-0.0,1.0,2.0,-1.0,4.0,0.0,-0.0,-0.0,-1.0,0.0,1.0,1.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-1.0,-1.0,-0.0,-0.0,-0.0,0.0,0.0,1.0,1.0,1.0,2.0,4.0},0),'half sort 667'); local q=np.argsort(a); assert(eq(q:tolist(),{4,9,1,6,7,8,10,2,11,12,3,5}),'half argsort 667') end
do local a=np.array({0.0,1.0,4.0,1.0,-2.0,4.0,-4.0,4.0,1.0,-0.0,2.0,-0.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-2.0,-0.0,-0.0,0.0,1.0,1.0,1.0,2.0,4.0,4.0,4.0},0),'half sort 668'); local q=np.argsort(a); assert(eq(q:tolist(),{7,5,1,10,12,2,4,9,11,3,6,8}),'half argsort 668') end
do local a=np.array({2.0,-1.0,0.0,-1.0,4.0,4.0,1.0,2.0,-0.0,-2.0,2.0,2.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-2.0,-1.0,-1.0,-0.0,0.0,1.0,2.0,2.0,2.0,2.0,4.0,4.0},0),'half sort 669'); local q=np.argsort(a); assert(eq(q:tolist(),{10,2,4,3,9,7,1,8,11,12,5,6}),'half argsort 669') end
do local a=np.array({1.0,4.0,2.0,0.5,4.0,-0.0,-2.0,0.0,2.0,-0.0,1.0,2.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-2.0,-0.0,-0.0,0.0,0.5,1.0,1.0,2.0,2.0,2.0,4.0,4.0},0),'half sort 670'); local q=np.argsort(a); assert(eq(q:tolist(),{7,6,8,10,4,1,11,3,9,12,2,5}),'half argsort 670') end
do local a=np.array({4.0,4.0,-2.0,-2.0,4.0,-2.0,4.0,-1.0,-0.0,2.0,1.0,0.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-2.0,-2.0,-2.0,-1.0,-0.0,0.0,1.0,2.0,4.0,4.0,4.0,4.0},0),'half sort 671'); local q=np.argsort(a); assert(eq(q:tolist(),{3,4,6,8,9,12,11,10,1,2,5,7}),'half argsort 671') end
do local a=np.array({2.0,-0.0,0.5,(0/0),2.0,-0.0,0.0,-4.0,1.0,2.0,-2.0,-2.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-2.0,-2.0,-0.0,-0.0,0.0,0.5,1.0,2.0,2.0,2.0,(0/0)},0),'half sort 672'); local q=np.argsort(a); assert(eq(q:tolist(),{8,11,12,2,6,7,3,9,1,5,10,4}),'half argsort 672') end
do local a=np.array({-4.0,0.0,-2.0,-1.0,-2.0,2.0,1.0,2.0,-1.0,1.0,-2.0,4.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-2.0,-2.0,-2.0,-1.0,-1.0,0.0,1.0,1.0,2.0,2.0,4.0},0),'half sort 673'); local q=np.argsort(a); assert(eq(q:tolist(),{1,3,5,11,4,9,2,7,10,6,8,12}),'half argsort 673') end
do local a=np.array({-1.0,0.0,0.5,2.0,2.0,4.0,-1.0,-0.0,0.5,2.0,4.0,-1.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-1.0,-1.0,-1.0,-0.0,0.0,0.5,0.5,2.0,2.0,2.0,4.0,4.0},0),'half sort 674'); local q=np.argsort(a); assert(eq(q:tolist(),{1,7,12,2,8,3,9,4,5,10,6,11}),'half argsort 674') end
do local a=np.array({-4.0,-0.0,1.0,4.0,1.0,1.0,4.0,-2.0,0.5,0.0,-2.0,-2.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-2.0,-2.0,-2.0,-0.0,0.0,0.5,1.0,1.0,1.0,4.0,4.0},0),'half sort 675'); local q=np.argsort(a); assert(eq(q:tolist(),{1,8,11,12,2,10,9,3,5,6,4,7}),'half argsort 675') end
do local a=np.array({-2.0,-4.0,2.0,-2.0,-2.0,2.0,-2.0,-0.0,2.0,-4.0,0.0,-4.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-4.0,-4.0,-2.0,-2.0,-2.0,-2.0,-0.0,0.0,2.0,2.0,2.0},0),'half sort 676'); local q=np.argsort(a); assert(eq(q:tolist(),{2,10,12,1,4,5,7,8,11,3,6,9}),'half argsort 676') end
do local a=np.array({-0.0,-4.0,-2.0,2.0,-0.0,-2.0,-1.0,-0.0,4.0,4.0,1.0,-4.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-4.0,-2.0,-2.0,-1.0,-0.0,-0.0,-0.0,1.0,2.0,4.0,4.0},0),'half sort 677'); local q=np.argsort(a); assert(eq(q:tolist(),{2,12,3,6,7,1,5,8,11,4,9,10}),'half argsort 677') end
do local a=np.array({-4.0,0.5,-2.0,4.0,1.0,2.0,1.0,4.0,-0.0,-2.0,0.5,-4.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-4.0,-2.0,-2.0,-0.0,0.5,0.5,1.0,1.0,2.0,4.0,4.0},0),'half sort 678'); local q=np.argsort(a); assert(eq(q:tolist(),{1,12,3,10,9,2,11,5,7,6,4,8}),'half argsort 678') end
do local a=np.array({-1.0,-2.0,-0.0,(0/0),1.0,1.0,1.0,1.0,-2.0,1.0,-2.0,-4.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-2.0,-2.0,-2.0,-1.0,-0.0,1.0,1.0,1.0,1.0,1.0,(0/0)},0),'half sort 679'); local q=np.argsort(a); assert(eq(q:tolist(),{12,2,9,11,1,3,5,6,7,8,10,4}),'half argsort 679') end
do local a=np.array({-2.0,2.0,0.0,-2.0,0.5,-2.0,-1.0,0.0,1.0,-0.0,4.0,0.5},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-2.0,-2.0,-2.0,-1.0,-0.0,0.0,0.0,0.5,0.5,1.0,2.0,4.0},0),'half sort 680'); local q=np.argsort(a); assert(eq(q:tolist(),{1,4,6,7,3,8,10,5,12,9,2,11}),'half argsort 680') end
do local a=np.array({0.5,1.0,-4.0,-2.0,4.0,-1.0,4.0,-2.0,-0.0,-1.0,-0.0,-4.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-4.0,-2.0,-2.0,-1.0,-1.0,-0.0,-0.0,0.5,1.0,4.0,4.0},0),'half sort 681'); local q=np.argsort(a); assert(eq(q:tolist(),{3,12,4,8,6,10,9,11,1,2,5,7}),'half argsort 681') end
do local a=np.array({-4.0,1.0,0.5,4.0,-1.0,2.0,4.0,-1.0,-2.0,1.0,0.5,4.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-2.0,-1.0,-1.0,0.5,0.5,1.0,1.0,2.0,4.0,4.0,4.0},0),'half sort 682'); local q=np.argsort(a); assert(eq(q:tolist(),{1,9,5,8,3,11,2,10,6,4,7,12}),'half argsort 682') end
do local a=np.array({-0.0,0.0,-4.0,1.0,0.5,-4.0,0.0,1.0,-4.0,-1.0,-0.0,-2.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-4.0,-4.0,-2.0,-1.0,-0.0,-0.0,0.0,0.0,0.5,1.0,1.0},0),'half sort 683'); local q=np.argsort(a); assert(eq(q:tolist(),{3,6,9,12,10,1,2,7,11,5,4,8}),'half argsort 683') end
do local a=np.array({-0.0,-1.0,-1.0,2.0,-0.0,1.0,-4.0,2.0,-1.0,-0.0,-0.0,-4.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-4.0,-1.0,-1.0,-1.0,-0.0,-0.0,-0.0,-0.0,1.0,2.0,2.0},0),'half sort 684'); local q=np.argsort(a); assert(eq(q:tolist(),{7,12,2,3,9,1,5,10,11,6,4,8}),'half argsort 684') end
do local a=np.array({4.0,4.0,0.0,0.0,1.0,-1.0,-4.0,4.0,0.5,-1.0,-0.0,1.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-1.0,-1.0,-0.0,0.0,0.0,0.5,1.0,1.0,4.0,4.0,4.0},0),'half sort 685'); local q=np.argsort(a); assert(eq(q:tolist(),{7,6,10,3,4,11,9,5,12,1,2,8}),'half argsort 685') end
do local a=np.array({0.0,-1.0,0.0,(0/0),0.5,-2.0,0.5,1.0,4.0,-1.0,-0.0,0.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-2.0,-1.0,-1.0,-0.0,0.0,0.0,0.0,0.5,0.5,1.0,4.0,(0/0)},0),'half sort 686'); local q=np.argsort(a); assert(eq(q:tolist(),{6,2,10,1,3,11,12,5,7,8,9,4}),'half argsort 686') end
do local a=np.array({-2.0,0.0,-4.0,-1.0,-1.0,0.0,-4.0,0.5,-1.0,-0.0,0.0,0.5},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-4.0,-2.0,-1.0,-1.0,-1.0,-0.0,0.0,0.0,0.0,0.5,0.5},0),'half sort 687'); local q=np.argsort(a); assert(eq(q:tolist(),{3,7,1,4,5,9,2,6,10,11,8,12}),'half argsort 687') end
do local a=np.array({4.0,-2.0,0.0,4.0,-0.0,-0.0,4.0,-4.0,-1.0,-0.0,2.0,4.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-2.0,-1.0,-0.0,-0.0,-0.0,0.0,2.0,4.0,4.0,4.0,4.0},0),'half sort 688'); local q=np.argsort(a); assert(eq(q:tolist(),{8,2,9,3,5,6,10,11,1,4,7,12}),'half argsort 688') end
do local a=np.array({1.0,2.0,-0.0,2.0,4.0,-0.0,-4.0,0.5,-2.0,0.5,1.0,2.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-2.0,-0.0,-0.0,0.5,0.5,1.0,1.0,2.0,2.0,2.0,4.0},0),'half sort 689'); local q=np.argsort(a); assert(eq(q:tolist(),{7,9,3,6,8,10,1,11,2,4,12,5}),'half argsort 689') end
do local a=np.array({0.5,0.0,1.0,0.0,0.5,0.5,4.0,2.0,-0.0,-1.0,-0.0,1.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-1.0,-0.0,-0.0,0.0,0.0,0.5,0.5,0.5,1.0,1.0,2.0,4.0},0),'half sort 690'); local q=np.argsort(a); assert(eq(q:tolist(),{10,2,4,9,11,1,5,6,3,12,8,7}),'half argsort 690') end
do local a=np.array({-1.0,-4.0,-0.0,-1.0,1.0,1.0,-0.0,-1.0,-4.0,1.0,-1.0,1.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-4.0,-1.0,-1.0,-1.0,-1.0,-0.0,-0.0,1.0,1.0,1.0,1.0},0),'half sort 691'); local q=np.argsort(a); assert(eq(q:tolist(),{2,9,1,4,8,11,3,7,5,6,10,12}),'half argsort 691') end
do local a=np.array({1.0,4.0,-1.0,-1.0,0.0,2.0,1.0,1.0,-2.0,-1.0,0.5,0.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-2.0,-1.0,-1.0,-1.0,0.0,0.0,0.5,1.0,1.0,1.0,2.0,4.0},0),'half sort 692'); local q=np.argsort(a); assert(eq(q:tolist(),{9,3,4,10,5,12,11,1,7,8,6,2}),'half argsort 692') end
do local a=np.array({4.0,2.0,0.0,(0/0),-2.0,-0.0,0.5,1.0,-4.0,-1.0,0.5,0.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-2.0,-1.0,-0.0,0.0,0.0,0.5,0.5,1.0,2.0,4.0,(0/0)},0),'half sort 693'); local q=np.argsort(a); assert(eq(q:tolist(),{9,5,10,3,6,12,7,11,8,2,1,4}),'half argsort 693') end
do local a=np.array({2.0,-2.0,0.5,2.0,2.0,0.5,4.0,-0.0,1.0,-1.0,-2.0,-4.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-2.0,-2.0,-1.0,-0.0,0.5,0.5,1.0,2.0,2.0,2.0,4.0},0),'half sort 694'); local q=np.argsort(a); assert(eq(q:tolist(),{12,2,11,10,8,3,6,9,1,4,5,7}),'half argsort 694') end
do local a=np.array({-1.0,1.0,-2.0,-4.0,-4.0,-1.0,4.0,-1.0,-0.0,1.0,1.0,-1.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-4.0,-2.0,-1.0,-1.0,-1.0,-1.0,-0.0,1.0,1.0,1.0,4.0},0),'half sort 695'); local q=np.argsort(a); assert(eq(q:tolist(),{4,5,3,1,6,8,12,9,2,10,11,7}),'half argsort 695') end
do local a=np.array({4.0,1.0,2.0,0.5,0.0,0.0,0.0,0.5,4.0,-0.0,-0.0,-0.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-0.0,-0.0,-0.0,0.0,0.0,0.0,0.5,0.5,1.0,2.0,4.0,4.0},0),'half sort 696'); local q=np.argsort(a); assert(eq(q:tolist(),{5,6,7,10,11,12,4,8,2,3,1,9}),'half argsort 696') end
do local a=np.array({0.0,0.0,-2.0,-4.0,2.0,4.0,2.0,0.0,1.0,-4.0,-0.0,-2.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-4.0,-2.0,-2.0,-0.0,0.0,0.0,0.0,1.0,2.0,2.0,4.0},0),'half sort 697'); local q=np.argsort(a); assert(eq(q:tolist(),{4,10,3,12,1,2,8,11,9,5,7,6}),'half argsort 697') end
do local a=np.array({-1.0,1.0,4.0,1.0,0.0,0.5,4.0,2.0,-1.0,-2.0,-1.0,0.5},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-2.0,-1.0,-1.0,-1.0,0.0,0.5,0.5,1.0,1.0,2.0,4.0,4.0},0),'half sort 698'); local q=np.argsort(a); assert(eq(q:tolist(),{10,1,9,11,5,6,12,2,4,8,3,7}),'half argsort 698') end
do local a=np.array({0.5,-0.0,-4.0,-4.0,1.0,-0.0,-2.0,0.5,4.0,-1.0,-2.0,2.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-4.0,-2.0,-2.0,-1.0,-0.0,-0.0,0.5,0.5,1.0,2.0,4.0},0),'half sort 699'); local q=np.argsort(a); assert(eq(q:tolist(),{3,4,7,11,10,2,6,1,8,5,12,9}),'half argsort 699') end
do local a=np.array({1.0,-4.0,-1.0,(0/0),-0.0,0.5,2.0,-1.0,4.0,-4.0,0.5,-4.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-4.0,-4.0,-1.0,-1.0,-0.0,0.5,0.5,1.0,2.0,4.0,(0/0)},0),'half sort 700'); local q=np.argsort(a); assert(eq(q:tolist(),{2,10,12,3,8,5,6,11,1,7,9,4}),'half argsort 700') end
do local a=np.array({0.5,2.0,-1.0,4.0,0.0,-0.0,0.5,1.0,-4.0,-0.0,0.0,-0.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-1.0,-0.0,-0.0,-0.0,0.0,0.0,0.5,0.5,1.0,2.0,4.0},0),'half sort 701'); local q=np.argsort(a); assert(eq(q:tolist(),{9,3,5,6,10,11,12,1,7,8,2,4}),'half argsort 701') end
do local a=np.array({-2.0,0.5,2.0,1.0,-0.0,-1.0,0.5,0.0,-1.0,-4.0,-0.0,-2.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-2.0,-2.0,-1.0,-1.0,-0.0,-0.0,0.0,0.5,0.5,1.0,2.0},0),'half sort 702'); local q=np.argsort(a); assert(eq(q:tolist(),{10,1,12,6,9,5,8,11,2,7,4,3}),'half argsort 702') end
do local a=np.array({0.5,0.0,-4.0,0.0,2.0,0.5,-4.0,0.0,1.0,-4.0,4.0,-1.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-4.0,-4.0,-1.0,0.0,0.0,0.0,0.5,0.5,1.0,2.0,4.0},0),'half sort 703'); local q=np.argsort(a); assert(eq(q:tolist(),{3,7,10,12,2,4,8,1,6,9,5,11}),'half argsort 703') end
do local a=np.array({0.5,-1.0,-4.0,-0.0,2.0,-2.0,0.0,-4.0,-0.0,0.0,0.0,0.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-4.0,-2.0,-1.0,-0.0,-0.0,0.0,0.0,0.0,0.0,0.5,2.0},0),'half sort 704'); local q=np.argsort(a); assert(eq(q:tolist(),{3,8,6,2,4,7,9,10,11,12,1,5}),'half argsort 704') end
do local a=np.array({-4.0,-1.0,-2.0,-2.0,-1.0,1.0,2.0,-1.0,-0.0,1.0,-1.0,-1.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-2.0,-2.0,-1.0,-1.0,-1.0,-1.0,-1.0,-0.0,1.0,1.0,2.0},0),'half sort 705'); local q=np.argsort(a); assert(eq(q:tolist(),{1,3,4,2,5,8,11,12,9,6,10,7}),'half argsort 705') end
do local a=np.array({4.0,4.0,0.0,-2.0,0.5,-0.0,0.0,2.0,0.5,4.0,2.0,4.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-2.0,-0.0,0.0,0.0,0.5,0.5,2.0,2.0,4.0,4.0,4.0,4.0},0),'half sort 706'); local q=np.argsort(a); assert(eq(q:tolist(),{4,3,6,7,5,9,8,11,1,2,10,12}),'half argsort 706') end
do local a=np.array({4.0,1.0,2.0,(0/0),-2.0,-1.0,0.0,-4.0,0.0,1.0,-1.0,0.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-2.0,-1.0,-1.0,0.0,0.0,0.0,1.0,1.0,2.0,4.0,(0/0)},0),'half sort 707'); local q=np.argsort(a); assert(eq(q:tolist(),{8,5,6,11,7,9,12,2,10,3,1,4}),'half argsort 707') end
do local a=np.array({-4.0,-2.0,4.0,0.5,-2.0,4.0,-1.0,-2.0,4.0,0.0,4.0,2.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-2.0,-2.0,-2.0,-1.0,0.0,0.5,2.0,4.0,4.0,4.0,4.0},0),'half sort 708'); local q=np.argsort(a); assert(eq(q:tolist(),{1,2,5,8,7,10,4,12,3,6,9,11}),'half argsort 708') end
do local a=np.array({1.0,2.0,2.0,4.0,0.0,0.5,-4.0,-2.0,-2.0,-4.0,-0.0,2.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-4.0,-2.0,-2.0,-0.0,0.0,0.5,1.0,2.0,2.0,2.0,4.0},0),'half sort 709'); local q=np.argsort(a); assert(eq(q:tolist(),{7,10,8,9,5,11,6,1,2,3,12,4}),'half argsort 709') end
do local a=np.array({-1.0,-4.0,-4.0,-4.0,-4.0,0.0,-2.0,0.0,2.0,1.0,-0.0,0.5},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-4.0,-4.0,-4.0,-2.0,-1.0,-0.0,0.0,0.0,0.5,1.0,2.0},0),'half sort 710'); local q=np.argsort(a); assert(eq(q:tolist(),{2,3,4,5,7,1,6,8,11,12,10,9}),'half argsort 710') end
do local a=np.array({-0.0,-4.0,-4.0,-0.0,-4.0,0.5,1.0,1.0,-4.0,-4.0,-2.0,4.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-4.0,-4.0,-4.0,-4.0,-2.0,-0.0,-0.0,0.5,1.0,1.0,4.0},0),'half sort 711'); local q=np.argsort(a); assert(eq(q:tolist(),{2,3,5,9,10,11,1,4,6,7,8,12}),'half argsort 711') end
do local a=np.array({4.0,-2.0,-1.0,4.0,-1.0,4.0,0.0,-1.0,-4.0,2.0,-4.0,-0.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-4.0,-2.0,-1.0,-1.0,-1.0,-0.0,0.0,2.0,4.0,4.0,4.0},0),'half sort 712'); local q=np.argsort(a); assert(eq(q:tolist(),{9,11,2,3,5,8,7,12,10,1,4,6}),'half argsort 712') end
do local a=np.array({0.0,2.0,-2.0,-4.0,0.5,0.5,-2.0,-4.0,-0.0,4.0,4.0,-1.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-4.0,-2.0,-2.0,-1.0,-0.0,0.0,0.5,0.5,2.0,4.0,4.0},0),'half sort 713'); local q=np.argsort(a); assert(eq(q:tolist(),{4,8,3,7,12,1,9,5,6,2,10,11}),'half argsort 713') end
do local a=np.array({1.0,-2.0,0.5,(0/0),-2.0,0.5,4.0,-1.0,-2.0,-4.0,-0.0,-1.0},np.float16); local r=np.sort(a); assert(close(r:tolist(),{-4.0,-2.0,-2.0,-2.0,-1.0,-1.0,-0.0,0.5,0.5,1.0,4.0,(0/0)},0),'half sort 714'); local q=np.argsort(a); assert(eq(q:tolist(),{10,2,5,9,8,12,11,3,6,1,7,4}),'half argsort 714') end
do local a=np.array({-3.0,-3.0,-3.0,-1.0,-0.0,0.0,0.0,0.5,0.5,0.5,1.0,1.0,2.0,2.0},np.float16); local k=np.array({3.0,0.0,-2.0,0.0,0.75},np.float16); local r=np.searchsorted(a,k,'left'); assert(eq(r:tolist(),{15,5,4,5,11}),'half searchsorted 715') end
do local a=np.array({-5.0,-5.0,-3.0,-3.0,-0.0,0.0,0.0,0.0,1.0,2.0,2.0,4.0,4.0,4.0},np.float16); local k=np.array({-0.0,0.0,-2.0,-0.0,-6.0},np.float16); local r=np.searchsorted(a,k,'left'); assert(eq(r:tolist(),{5,5,5,5,1}),'half searchsorted 716') end
do local a=np.array({-5.0,-5.0,-3.0,-3.0,-1.0,-0.0,0.0,0.5,1.0,1.0,2.0,2.0,2.0,4.0},np.float16); local k=np.array({-0.0,-0.0,9.0,9.0,0.75},np.float16); local r=np.searchsorted(a,k,'left'); assert(eq(r:tolist(),{6,6,15,15,9}),'half searchsorted 717') end
do local a=np.array({-5.0,-5.0,-3.0,-1.0,-1.0,0.0,0.0,0.0,0.5,0.5,1.0,1.0,1.0,1.0},np.float16); local k=np.array({9.0,0.0,-2.0,3.0,0.75},np.float16); local r=np.searchsorted(a,k,'right'); assert(eq(r:tolist(),{15,9,4,15,11}),'half searchsorted 718') end
do local a=np.array({-5.0,0.0,0.0,0.0,0.0,0.5,0.5,0.5,1.0,1.0,2.0,2.0,8.0,8.0},np.float16); local k=np.array({-0.0,3.0,0.0,0.0,3.0},np.float16); local r=np.searchsorted(a,k,'left'); assert(eq(r:tolist(),{2,13,2,2,13}),'half searchsorted 719') end
do local a=np.array({-5.0,-3.0,-3.0,-3.0,-3.0,-1.0,0.5,0.5,1.0,1.0,1.0,2.0,4.0,4.0},np.float16); local k=np.array({3.0,9.0,-0.0,-6.0,0.0},np.float16); local r=np.searchsorted(a,k,'left'); assert(eq(r:tolist(),{13,15,7,1,7}),'half searchsorted 720') end
do local a=np.array({-5.0,-5.0,-5.0,-1.0,-0.0,-0.0,0.5,0.5,1.0,2.0,2.0,2.0,8.0,8.0},np.float16); local k=np.array({9.0,-2.0,0.0,3.0,0.75},np.float16); local r=np.searchsorted(a,k,'right'); assert(eq(r:tolist(),{15,4,7,13,9}),'half searchsorted 721') end
do local a=np.array({-0.0,0.0,0.5,0.5,1.0,2.0,2.0,4.0,4.0,8.0,8.0,8.0,8.0,8.0},np.float16); local k=np.array({3.0,0.0,0.0,0.75,-0.0},np.float16); local r=np.searchsorted(a,k,'left'); assert(eq(r:tolist(),{8,1,1,5,1}),'half searchsorted 722') end
do local a=np.array({-5.0,-3.0,-3.0,-3.0,-0.0,0.0,0.5,0.5,1.0,1.0,2.0,2.0,4.0,4.0},np.float16); local k=np.array({3.0,0.75,-6.0,-6.0,0.75},np.float16); local r=np.searchsorted(a,k,'right'); assert(eq(r:tolist(),{13,9,1,1,9}),'half searchsorted 723') end
do local a=np.array({-5.0,-3.0,-3.0,-1.0,-1.0,-1.0,0.0,0.5,1.0,1.0,1.0,4.0,8.0,8.0},np.float16); local k=np.array({9.0,0.0,0.75,-2.0,-0.0},np.float16); local r=np.searchsorted(a,k,'right'); assert(eq(r:tolist(),{15,8,9,4,8}),'half searchsorted 724') end
do local a=np.array({-5.0,-3.0,-1.0,-0.0,-0.0,0.0,1.0,1.0,1.0,1.0,4.0,8.0,8.0,8.0},np.float16); local k=np.array({0.75,0.75,3.0,-2.0,-0.0},np.float16); local r=np.searchsorted(a,k,'right'); assert(eq(r:tolist(),{7,7,11,3,7}),'half searchsorted 725') end
do local a=np.array({-3.0,-3.0,-1.0,-1.0,-0.0,0.0,0.5,0.5,1.0,2.0,2.0,2.0,4.0,8.0},np.float16); local k=np.array({-6.0,3.0,3.0,0.0,3.0},np.float16); local r=np.searchsorted(a,k,'right'); assert(eq(r:tolist(),{1,13,13,7,13}),'half searchsorted 726') end
do local a=np.array({-5.0,-5.0,-5.0,-3.0,-1.0,-0.0,-0.0,-0.0,0.0,0.0,0.0,8.0,8.0,8.0},np.float16); local k=np.array({-6.0,9.0,3.0,-2.0,9.0},np.float16); local r=np.searchsorted(a,k,'right'); assert(eq(r:tolist(),{1,15,12,5,15}),'half searchsorted 727') end
do local a=np.array({-5.0,-3.0,-1.0,-0.0,-0.0,0.5,0.5,0.5,0.5,2.0,2.0,2.0,4.0,8.0},np.float16); local k=np.array({0.0,-6.0,0.75,0.0,0.75},np.float16); local r=np.searchsorted(a,k,'right'); assert(eq(r:tolist(),{6,1,10,6,10}),'half searchsorted 728') end
do local a=np.array({-5.0,-3.0,-1.0,-0.0,0.0,0.0,1.0,1.0,1.0,2.0,4.0,4.0,8.0,8.0},np.float16); local k=np.array({-0.0,-2.0,0.0,-6.0,-0.0},np.float16); local r=np.searchsorted(a,k,'right'); assert(eq(r:tolist(),{7,3,7,1,7}),'half searchsorted 729') end
do local a=np.array({-5.0,-3.0,-1.0,-0.0,-0.0,-0.0,0.0,0.0,0.0,0.5,1.0,2.0,2.0,4.0},np.float16); local k=np.array({9.0,9.0,-6.0,-6.0,0.75},np.float16); local r=np.searchsorted(a,k,'right'); assert(eq(r:tolist(),{15,15,1,1,11}),'half searchsorted 730') end
do local a=np.array({-5.0,-5.0,-3.0,-1.0,-1.0,-0.0,0.0,1.0,1.0,2.0,4.0,4.0,8.0,8.0},np.float16); local k=np.array({-2.0,-0.0,0.0,-6.0,-2.0},np.float16); local r=np.searchsorted(a,k,'left'); assert(eq(r:tolist(),{4,6,6,1,4}),'half searchsorted 731') end
do local a=np.array({-5.0,-5.0,-1.0,-1.0,-0.0,-0.0,0.0,1.0,1.0,2.0,2.0,4.0,4.0,8.0},np.float16); local k=np.array({-2.0,3.0,0.0,-2.0,9.0},np.float16); local r=np.searchsorted(a,k,'left'); assert(eq(r:tolist(),{3,12,5,3,15}),'half searchsorted 732') end
do local a=np.array({-5.0,-3.0,-3.0,-3.0,-3.0,-0.0,0.0,0.0,0.5,1.0,1.0,1.0,1.0,4.0},np.float16); local k=np.array({-0.0,0.0,3.0,0.0,-2.0},np.float16); local r=np.searchsorted(a,k,'right'); assert(eq(r:tolist(),{9,9,14,9,6}),'half searchsorted 733') end
do local a=np.array({-5.0,-5.0,-3.0,-0.0,-0.0,-0.0,0.0,0.0,1.0,1.0,2.0,4.0,8.0,8.0},np.float16); local k=np.array({9.0,-0.0,-6.0,-6.0,0.0},np.float16); local r=np.searchsorted(a,k,'right'); assert(eq(r:tolist(),{15,9,1,1,9}),'half searchsorted 734') end
do local a=np.array({-0.0,-0.0,-0.0,0.5,1.0,1.0,1.0,1.0,2.0,4.0,8.0,8.0,8.0,8.0},np.float16); local k=np.array({3.0,0.0,-0.0,-6.0,-0.0},np.float16); local r=np.searchsorted(a,k,'right'); assert(eq(r:tolist(),{10,4,4,1,4}),'half searchsorted 735') end
do local a=np.array({-5.0,-5.0,-3.0,-3.0,-1.0,-0.0,0.5,0.5,0.5,4.0,4.0,4.0,8.0,8.0},np.float16); local k=np.array({3.0,0.75,0.0,0.0,3.0},np.float16); local r=np.searchsorted(a,k,'left'); assert(eq(r:tolist(),{10,10,6,6,10}),'half searchsorted 736') end
do local a=np.array({-5.0,-5.0,-3.0,-3.0,-3.0,-0.0,0.5,1.0,1.0,2.0,4.0,8.0,8.0,8.0},np.float16); local k=np.array({3.0,9.0,0.0,-2.0,3.0},np.float16); local r=np.searchsorted(a,k,'right'); assert(eq(r:tolist(),{11,15,7,6,11}),'half searchsorted 737') end
do local a=np.array({-5.0,-5.0,-1.0,-0.0,-0.0,0.5,0.5,0.5,1.0,2.0,8.0,8.0,8.0,8.0},np.float16); local k=np.array({9.0,0.75,0.0,-0.0,-2.0},np.float16); local r=np.searchsorted(a,k,'right'); assert(eq(r:tolist(),{15,9,6,6,3}),'half searchsorted 738') end
do local a=np.array({-5.0,-3.0,-1.0,-1.0,-0.0,0.5,1.0,2.0,2.0,4.0,4.0,8.0,8.0,8.0},np.float16); local k=np.array({3.0,-0.0,3.0,0.75,0.0},np.float16); local r=np.searchsorted(a,k,'right'); assert(eq(r:tolist(),{10,6,10,7,6}),'half searchsorted 739') end
do local a=np.array({-5.0,-1.0,-1.0,-0.0,0.0,0.0,0.0,0.5,1.0,4.0,4.0,8.0,8.0,8.0},np.float16); local k=np.array({0.0,-2.0,9.0,-2.0,0.0},np.float16); local r=np.searchsorted(a,k,'left'); assert(eq(r:tolist(),{4,2,15,2,4}),'half searchsorted 740') end
do local a=np.array({-5.0,-3.0,-3.0,-1.0,0.0,0.0,0.5,0.5,1.0,1.0,4.0,4.0,4.0,8.0},np.float16); local k=np.array({0.0,-6.0,0.0,-0.0,0.75},np.float16); local r=np.searchsorted(a,k,'left'); assert(eq(r:tolist(),{5,1,5,5,9}),'half searchsorted 741') end
do local a=np.array({-5.0,-5.0,-5.0,-3.0,-1.0,-1.0,-1.0,-0.0,0.0,2.0,4.0,4.0,8.0,8.0},np.float16); local k=np.array({-0.0,0.75,9.0,0.75,-0.0},np.float16); local r=np.searchsorted(a,k,'left'); assert(eq(r:tolist(),{8,10,15,10,8}),'half searchsorted 742') end
do local a=np.array({-5.0,-3.0,-3.0,-3.0,-0.0,0.5,1.0,1.0,1.0,2.0,2.0,4.0,8.0,8.0},np.float16); local k=np.array({0.0,3.0,0.75,3.0,-6.0},np.float16); local r=np.searchsorted(a,k,'right'); assert(eq(r:tolist(),{6,12,7,12,1}),'half searchsorted 743') end
do local a=np.array({-5.0,-5.0,-5.0,-5.0,-1.0,0.0,0.0,1.0,1.0,2.0,2.0,4.0,8.0,8.0},np.float16); local k=np.array({-0.0,3.0,0.0,-0.0,3.0},np.float16); local r=np.searchsorted(a,k,'right'); assert(eq(r:tolist(),{8,12,8,8,12}),'half searchsorted 744') end
do local a=np.array({-5.0,-3.0,-3.0,-1.0,0.5,0.5,1.0,1.0,1.0,2.0,2.0,2.0,8.0,8.0},np.float16); local k=np.array({0.75,3.0,-2.0,-2.0,-6.0},np.float16); local r=np.searchsorted(a,k,'left'); assert(eq(r:tolist(),{7,13,4,4,1}),'half searchsorted 745') end
do local a=np.array({-5.0,-5.0,-5.0,-3.0,-1.0,-1.0,-1.0,-0.0,0.0,0.0,0.0,0.5,2.0,8.0},np.float16); local k=np.array({-6.0,0.0,9.0,9.0,3.0},np.float16); local r=np.searchsorted(a,k,'left'); assert(eq(r:tolist(),{1,8,15,15,14}),'half searchsorted 746') end
do local a=np.array({-3.0,-3.0,-3.0,-3.0,-0.0,-0.0,0.5,0.5,1.0,2.0,4.0,8.0,8.0,8.0},np.float16); local k=np.array({-6.0,0.75,0.75,9.0,9.0},np.float16); local r=np.searchsorted(a,k,'right'); assert(eq(r:tolist(),{1,9,9,15,15}),'half searchsorted 747') end
do local a=np.array({-1.0,-1.0,-0.0,0.0,0.5,1.0,2.0,2.0,4.0,4.0,8.0,8.0,8.0,8.0},np.float16); local k=np.array({0.75,-2.0,0.75,0.0,0.0},np.float16); local r=np.searchsorted(a,k,'right'); assert(eq(r:tolist(),{6,1,6,5,5}),'half searchsorted 748') end
do local a=np.array({-3.0,-3.0,-3.0,-3.0,-1.0,-0.0,0.0,0.0,0.0,1.0,2.0,2.0,4.0,8.0},np.float16); local k=np.array({-2.0,0.75,0.75,3.0,-6.0},np.float16); local r=np.searchsorted(a,k,'left'); assert(eq(r:tolist(),{5,10,10,13,1}),'half searchsorted 749') end
do local a=np.array({-5.0,-3.0,-0.0,-0.0,-0.0,-0.0,0.5,1.0,2.0,4.0,8.0,8.0,8.0,8.0},np.float16); local k=np.array({-0.0,0.75,9.0,3.0,-0.0},np.float16); local r=np.searchsorted(a,k,'left'); assert(eq(r:tolist(),{3,8,15,10,3}),'half searchsorted 750') end
do local a=np.array({-5.0,-5.0,-3.0,-1.0,-0.0,-0.0,0.0,0.0,0.5,0.5,1.0,2.0,4.0,4.0},np.float16); local k=np.array({9.0,0.75,-6.0,-6.0,0.75},np.float16); local r=np.searchsorted(a,k,'left'); assert(eq(r:tolist(),{15,11,1,1,11}),'half searchsorted 751') end
do local a=np.array({-5.0,-3.0,-0.0,0.0,0.5,0.5,2.0,2.0,2.0,2.0,4.0,8.0,8.0,8.0},np.float16); local k=np.array({0.0,-6.0,-2.0,-0.0,-2.0},np.float16); local r=np.searchsorted(a,k,'right'); assert(eq(r:tolist(),{5,1,3,5,3}),'half searchsorted 752') end
do local a=np.array({-3.0,-1.0,-1.0,0.0,0.0,1.0,1.0,2.0,2.0,2.0,4.0,4.0,8.0,8.0},np.float16); local k=np.array({-6.0,-2.0,3.0,-2.0,-0.0},np.float16); local r=np.searchsorted(a,k,'right'); assert(eq(r:tolist(),{1,2,11,2,6}),'half searchsorted 753') end
do local a=np.array({-5.0,-5.0,-3.0,-1.0,-0.0,0.0,0.5,2.0,2.0,2.0,4.0,4.0,8.0,8.0},np.float16); local k=np.array({9.0,0.75,0.0,9.0,-2.0},np.float16); local r=np.searchsorted(a,k,'left'); assert(eq(r:tolist(),{15,8,5,15,4}),'half searchsorted 754') end
print('float16 differential: 755 cases ok')
