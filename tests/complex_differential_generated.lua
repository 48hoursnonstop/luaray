local np=require('luaray_core')
local function fclose(a,b,tol)
  tol=tol or 2e-5
  if a~=a and b~=b then return true end
  if a==b then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return false end
  return math.abs(a-b)<=tol*math.max(1,math.abs(a),math.abs(b))
end
local function close(a,b,tol)
  tol=tol or 2e-5
  if type(a)=='userdata' and a.real~=nil and a.imag~=nil then
    return type(b)=='userdata' and b.real~=nil and fclose(a.real,b.real,tol) and fclose(a.imag,b.imag,tol)
  end
  if type(a)~=type(b) then return false end
  if type(a)=='table' then
    if #a~=#b then return false end
    for i=1,#a do if not close(a[i],b[i],tol) then return false end end
    return true
  end
  if type(a)=='number' then return fclose(a,b,tol) end
  return a==b
end
local function exact(a,b)
  if type(a)=='userdata' and a.real~=nil and a.imag~=nil then
    return type(b)=='userdata' and b.real~=nil and ((a.real==b.real) or (a.real~=a.real and b.real~=b.real)) and ((a.imag==b.imag) or (a.imag~=a.imag and b.imag~=b.imag))
  end
  if type(a)~=type(b) then return false end
  if type(a)=='table' then if #a~=#b then return false end; for i=1,#a do if not exact(a[i],b[i]) then return false end end; return true end
  if type(a)=='number' and a~=a and b~=b then return true end
  return a==b
end
-- Generated against development NumPy 2.3.5.
do
 local a=np.array({np.complex(1.0,2.0),np.complex(-3.0,0.5),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(4.0,-5.0)},np.complex64)
 assert(a.dtype=='complex64','complex ctor dtype 0')
 assert(close(a:tolist(),{np.complex(1.0,2.0),np.complex(-3.0,0.5),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(4.0,-5.0)},3e-05),'complex ctor 0')
end
do
 local a=np.array({np.complex(1.0,2.0),np.complex(-3.0,0.5),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(4.0,-5.0)},np.complex128)
 assert(a.dtype=='complex128','complex ctor dtype 1')
 assert(close(a:tolist(),{np.complex(1.0,2.0),np.complex(-3.0,0.5),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(4.0,-5.0)},2e-12),'complex ctor 1')
end
do
 local a=np.array({np.complex(1.0,2.0),np.complex(-3.0,0.5),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(4.0,-5.0)},np.complex256)
 assert(a.dtype=='complex256','complex ctor dtype 2')
 assert(close(a:tolist(),{np.complex(1.0,2.0),np.complex(-3.0,0.5),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(4.0,-5.0)},2e-12),'complex ctor 2')
end
do local a=np.array({np.complex(1,2),3}); assert(a.dtype=='complex128','complex inference'); assert(close(a:tolist(),{np.complex(1,2),np.complex(3,0)}),'complex inference values') end
do local a=np.array({false,true,true,true},np.complex64); assert(close(a:tolist(),{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(1.0,0.0)},3e-05),'real->complex 4') end
do local a=np.array({false,true,true,true},np.complex128); assert(close(a:tolist(),{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(1.0,0.0)},2e-12),'real->complex 5') end
do local a=np.array({0,1,-2,3},np.complex64); assert(close(a:tolist(),{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(-2.0,0.0),np.complex(3.0,0.0)},3e-05),'real->complex 6') end
do local a=np.array({0,1,-2,3},np.complex128); assert(close(a:tolist(),{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(-2.0,0.0),np.complex(3.0,0.0)},2e-12),'real->complex 7') end
do local a=np.array({0,1,2,3},np.complex64); assert(close(a:tolist(),{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},3e-05),'real->complex 8') end
do local a=np.array({0,1,2,3},np.complex128); assert(close(a:tolist(),{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(3.0,0.0)},2e-12),'real->complex 9') end
do local a=np.array({0,1,-2,3},np.complex64); assert(close(a:tolist(),{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(-2.0,0.0),np.complex(3.0,0.0)},3e-05),'real->complex 10') end
do local a=np.array({0,1,-2,3},np.complex128); assert(close(a:tolist(),{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(-2.0,0.0),np.complex(3.0,0.0)},2e-12),'real->complex 11') end
do local a=np.array({0.0,1.0,-2.0,3.0},np.complex64); assert(close(a:tolist(),{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(-2.0,0.0),np.complex(3.0,0.0)},3e-05),'real->complex 12') end
do local a=np.array({0.0,1.0,-2.0,3.0},np.complex128); assert(close(a:tolist(),{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(-2.0,0.0),np.complex(3.0,0.0)},2e-12),'real->complex 13') end
do local a=np.array({0.0,1.0,-2.0,3.0},np.complex64); assert(close(a:tolist(),{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(-2.0,0.0),np.complex(3.0,0.0)},3e-05),'real->complex 14') end
do local a=np.array({0.0,1.0,-2.0,3.0},np.complex128); assert(close(a:tolist(),{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(-2.0,0.0),np.complex(3.0,0.0)},2e-12),'real->complex 15') end
do local a=np.array({0.0,1.0,-2.0,3.0},np.complex64); assert(close(a:tolist(),{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(-2.0,0.0),np.complex(3.0,0.0)},3e-05),'real->complex 16') end
do local a=np.array({0.0,1.0,-2.0,3.0},np.complex128); assert(close(a:tolist(),{np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(-2.0,0.0),np.complex(3.0,0.0)},2e-12),'real->complex 17') end
do local ok=pcall(function() np.array({np.complex(1,2)},np.float64) end); assert(not ok,'complex->real constructor must reject') end
do -- add 19
 local a=np.array({np.complex(4.0,-3.0),np.complex(-1.0,3.0),np.complex(4.0,0.0),np.complex(0.25,0.5),np.complex(-0.0,-1.0),np.complex(-3.0,-1.0)},np.complex64)
 local b=np.array({-1.0,-3.0,-0.0,-3.0,1.0,0.0},np.float32)
 local r=np.add(a,b)
 assert(r.dtype=='complex64','complex add dtype 19 '..r.dtype)
 assert(close(r:tolist(),{np.complex(3.0,-3.0),np.complex(-4.0,3.0),np.complex(4.0,0.0),np.complex(-2.75,0.5),np.complex(1.0,-1.0),np.complex(-3.0,-1.0)},3e-05),'complex add values 19')
end
do -- add 20
 local a=np.array({np.complex(-2.0,1.0),np.complex(-0.0,0.5),np.complex(4.0,1.0),np.complex(-3.0,-1.0),np.complex(-3.0,0.5),np.complex(-1.0,-1.0)},np.complex64)
 local b=np.array({-3.0,-1.0,-3.0,4.0,-3.0,-3.0},np.float64)
 local r=np.add(a,b)
 assert(r.dtype=='complex128','complex add dtype 20 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-5.0,1.0),np.complex(-1.0,0.5),np.complex(1.0,1.0),np.complex(1.0,-1.0),np.complex(-6.0,0.5),np.complex(-4.0,-1.0)},2e-12),'complex add values 20')
end
do -- add 21
 local a=np.array({np.complex(4.0,-1.0),np.complex(2.0,0.5),np.complex(-0.0,-0.0),np.complex(0.0,0.5),np.complex(0.25,0.0),np.complex(-1.0,0.5)},np.complex128)
 local b=np.array({2.0,4.0,0.0,-0.0,-1.0,1.0},np.float64)
 local r=np.add(a,b)
 assert(r.dtype=='complex128','complex add dtype 21 '..r.dtype)
 assert(close(r:tolist(),{np.complex(6.0,-1.0),np.complex(6.0,0.5),np.complex(0.0,0.0),np.complex(0.0,0.5),np.complex(-0.75,0.0),np.complex(0.0,0.5)},2e-12),'complex add values 21')
end
do -- add 22
 local a=np.array({np.complex(0.25,3.0),np.complex(2.0,0.0),np.complex(0.0,1.0),np.complex(4.0,-0.0),np.complex(0.0,1.0),np.complex(-1.0,-3.0)},np.complex128)
 local b=np.array({-3.0,0.5,0.0,1.0,0.5,4.0},np.float16)
 local r=np.add(a,b)
 assert(r.dtype=='complex128','complex add dtype 22 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-2.75,3.0),np.complex(2.5,0.0),np.complex(0.0,1.0),np.complex(5.0,0.0),np.complex(0.5,1.0),np.complex(3.0,-3.0)},2e-12),'complex add values 22')
end
do -- add 23
 local a=np.array({np.complex(-1.0,-3.0),np.complex(-1.0,-1.0),np.complex(4.0,-0.0),np.complex(1.0,3.0),np.complex(-1.0,0.0),np.complex(-0.0,0.5)},np.complex128)
 local b=np.array({2.0,2.0,1.0,4.0,0.0,1.0},np.float32)
 local r=np.add(a,b)
 assert(r.dtype=='complex128','complex add dtype 23 '..r.dtype)
 assert(close(r:tolist(),{np.complex(1.0,-3.0),np.complex(1.0,-1.0),np.complex(5.0,0.0),np.complex(5.0,3.0),np.complex(-1.0,0.0),np.complex(1.0,0.5)},2e-12),'complex add values 23')
end
do -- add 24
 local a=np.array({np.complex(2.0,0.5),np.complex(-0.0,3.0),np.complex(2.0,3.0),np.complex(0.0,-0.0),np.complex(-0.0,-1.0),np.complex(1.0,0.5)},np.complex128)
 local b=np.array({-1.0,-0.0,-1.0,-3.0,4.0,0.5},np.float16)
 local r=np.add(a,b)
 assert(r.dtype=='complex128','complex add dtype 24 '..r.dtype)
 assert(close(r:tolist(),{np.complex(1.0,0.5),np.complex(-0.0,3.0),np.complex(1.0,3.0),np.complex(-3.0,0.0),np.complex(4.0,-1.0),np.complex(1.5,0.5)},2e-12),'complex add values 24')
end
do -- add 25
 local a=np.array({np.complex(-1.0,1.0),np.complex(0.0,-1.0),np.complex(0.0,0.0),np.complex(0.25,3.0),np.complex(1.0,0.5),np.complex(2.0,-3.0)},np.complex64)
 local b=np.array({0.0,1.0,-3.0,0.0,0.0,0.5},np.float64)
 local r=np.add(a,b)
 assert(r.dtype=='complex128','complex add dtype 25 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-1.0,1.0),np.complex(1.0,-1.0),np.complex(-3.0,0.0),np.complex(0.25,3.0),np.complex(1.0,0.5),np.complex(2.5,-3.0)},2e-12),'complex add values 25')
end
do -- add 26
 local a=np.array({np.complex(0.25,0.5),np.complex(-3.0,-1.0),np.complex(-3.0,3.0),np.complex(-0.0,3.0),np.complex(-1.0,-0.0),np.complex(2.0,-0.0)},np.complex64)
 local b=np.array({np.complex(0.0,3.0),np.complex(4.0,0.0),np.complex(4.0,3.0),np.complex(2.0,0.0),np.complex(-2.0,3.0),np.complex(2.0,-1.0)},np.complex64)
 local r=np.add(a,b)
 assert(r.dtype=='complex64','complex add dtype 26 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.25,3.5),np.complex(1.0,-1.0),np.complex(1.0,6.0),np.complex(2.0,3.0),np.complex(-3.0,3.0),np.complex(4.0,-1.0)},3e-05),'complex add values 26')
end
do -- add 27
 local a=np.array({np.complex(1.0,0.5),np.complex(-2.0,1.0),np.complex(-3.0,1.0),np.complex(1.0,3.0),np.complex(-3.0,0.5),np.complex(1.0,-1.0)},np.complex128)
 local b=np.array({-0.0,-1.0,1.0,-1.0,2.0,0.0},np.float16)
 local r=np.add(a,b)
 assert(r.dtype=='complex128','complex add dtype 27 '..r.dtype)
 assert(close(r:tolist(),{np.complex(1.0,0.5),np.complex(-3.0,1.0),np.complex(-2.0,1.0),np.complex(0.0,3.0),np.complex(-1.0,0.5),np.complex(1.0,-1.0)},2e-12),'complex add values 27')
end
do -- add 28
 local a=np.array({np.complex(-2.0,-1.0),np.complex(0.25,1.0),np.complex(-3.0,-0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(-0.0,-0.0)},np.complex128)
 local b=np.array({2.0,-1.0,-1.0,-0.0,-0.0,4.0},np.float64)
 local r=np.add(a,b)
 assert(r.dtype=='complex128','complex add dtype 28 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,-1.0),np.complex(-0.75,1.0),np.complex(-4.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,0.0),np.complex(4.0,0.0)},2e-12),'complex add values 28')
end
do -- add 29
 local a=np.array({np.complex(2.0,1.0),np.complex(-3.0,-0.0),np.complex(-0.0,0.0),np.complex(0.25,1.0),np.complex(2.0,0.5),np.complex(4.0,0.5)},np.complex64)
 local b=np.array({np.complex(-0.0,0.5),np.complex(-2.0,1.0),np.complex(1.0,-0.0),np.complex(0.25,-1.0),np.complex(4.0,1.0),np.complex(0.0,-0.0)},np.complex64)
 local r=np.add(a,b)
 assert(r.dtype=='complex64','complex add dtype 29 '..r.dtype)
 assert(close(r:tolist(),{np.complex(2.0,1.5),np.complex(-5.0,1.0),np.complex(1.0,0.0),np.complex(0.5,0.0),np.complex(6.0,1.5),np.complex(4.0,0.5)},3e-05),'complex add values 29')
end
do -- add 30
 local a=np.array({np.complex(-2.0,0.0),np.complex(4.0,3.0),np.complex(0.25,3.0),np.complex(0.25,-0.0),np.complex(-2.0,-1.0),np.complex(0.0,-1.0)},np.complex64)
 local b=np.array({1.0,-3.0,1.0,-3.0,4.0,0.5},np.float16)
 local r=np.add(a,b)
 assert(r.dtype=='complex64','complex add dtype 30 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-1.0,0.0),np.complex(1.0,3.0),np.complex(1.25,3.0),np.complex(-2.75,0.0),np.complex(2.0,-1.0),np.complex(0.5,-1.0)},3e-05),'complex add values 30')
end
do -- add 31
 local a=np.array({np.complex(-0.0,1.0),np.complex(-2.0,3.0),np.complex(-1.0,0.5),np.complex(-0.0,-3.0),np.complex(2.0,3.0),np.complex(-1.0,1.0)},np.complex64)
 local b=np.array({np.complex(-1.0,-3.0),np.complex(4.0,-3.0),np.complex(0.0,-0.0),np.complex(2.0,1.0),np.complex(-2.0,-1.0),np.complex(-1.0,1.0)},np.complex64)
 local r=np.add(a,b)
 assert(r.dtype=='complex64','complex add dtype 31 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-1.0,-2.0),np.complex(2.0,0.0),np.complex(-1.0,0.5),np.complex(2.0,-2.0),np.complex(0.0,2.0),np.complex(-2.0,2.0)},3e-05),'complex add values 31')
end
do -- add 32
 local a=np.array({np.complex(-3.0,-0.0),np.complex(-0.0,0.5),np.complex(-2.0,3.0),np.complex(-2.0,-1.0),np.complex(0.25,1.0),np.complex(4.0,0.5)},np.complex64)
 local b=np.array({0.0,4.0,2.0,-0.0,4.0,0.0},np.float32)
 local r=np.add(a,b)
 assert(r.dtype=='complex64','complex add dtype 32 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-3.0,0.0),np.complex(4.0,0.5),np.complex(0.0,3.0),np.complex(-2.0,-1.0),np.complex(4.25,1.0),np.complex(4.0,0.5)},3e-05),'complex add values 32')
end
do -- add 33
 local a=np.array({np.complex(0.25,-0.0),np.complex(-0.0,0.5),np.complex(4.0,-1.0),np.complex(0.0,-0.0),np.complex(2.0,-1.0),np.complex(-3.0,-3.0)},np.complex128)
 local b=np.array({-0.0,-1.0,-0.0,0.0,0.5,1.0},np.float32)
 local r=np.add(a,b)
 assert(r.dtype=='complex128','complex add dtype 33 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.25,0.0),np.complex(-1.0,0.5),np.complex(4.0,-1.0),np.complex(0.0,0.0),np.complex(2.5,-1.0),np.complex(-2.0,-3.0)},2e-12),'complex add values 33')
end
do -- add 34
 local a=np.array({np.complex(2.0,-0.0),np.complex(2.0,0.5),np.complex(1.0,1.0),np.complex(4.0,-1.0),np.complex(-2.0,-1.0),np.complex(-1.0,-1.0)},np.complex128)
 local b=np.array({4.0,0.0,2.0,-0.0,0.5,0.5},np.float64)
 local r=np.add(a,b)
 assert(r.dtype=='complex128','complex add dtype 34 '..r.dtype)
 assert(close(r:tolist(),{np.complex(6.0,0.0),np.complex(2.0,0.5),np.complex(3.0,1.0),np.complex(4.0,-1.0),np.complex(-1.5,-1.0),np.complex(-0.5,-1.0)},2e-12),'complex add values 34')
end
do -- add 35
 local a=np.array({np.complex(-2.0,-1.0),np.complex(4.0,-1.0),np.complex(1.0,0.5),np.complex(0.0,1.0),np.complex(1.0,0.5),np.complex(-0.0,3.0)},np.complex128)
 local b=np.array({-3.0,1.0,1.0,0.5,-3.0,0.0},np.float64)
 local r=np.add(a,b)
 assert(r.dtype=='complex128','complex add dtype 35 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-5.0,-1.0),np.complex(5.0,-1.0),np.complex(2.0,0.5),np.complex(0.5,1.0),np.complex(-2.0,0.5),np.complex(0.0,3.0)},2e-12),'complex add values 35')
end
do -- add 36
 local a=np.array({np.complex(-3.0,-0.0),np.complex(4.0,-3.0),np.complex(-2.0,0.5),np.complex(2.0,0.5),np.complex(4.0,0.0),np.complex(-1.0,-3.0)},np.complex128)
 local b=np.array({np.complex(2.0,-3.0),np.complex(-3.0,0.0),np.complex(1.0,1.0),np.complex(0.0,0.0),np.complex(-1.0,-3.0),np.complex(1.0,1.0)},np.complex64)
 local r=np.add(a,b)
 assert(r.dtype=='complex128','complex add dtype 36 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-1.0,-3.0),np.complex(1.0,-3.0),np.complex(-1.0,1.5),np.complex(2.0,0.5),np.complex(3.0,-3.0),np.complex(0.0,-2.0)},2e-12),'complex add values 36')
end
do -- add 37
 local a=np.array({np.complex(1.0,-0.0),np.complex(-1.0,-1.0),np.complex(-0.0,1.0),np.complex(-3.0,-3.0),np.complex(1.0,-1.0),np.complex(-1.0,0.5)},np.complex64)
 local b=np.array({np.complex(-2.0,-3.0),np.complex(2.0,0.0),np.complex(1.0,-3.0),np.complex(-1.0,3.0),np.complex(4.0,3.0),np.complex(2.0,3.0)},np.complex128)
 local r=np.add(a,b)
 assert(r.dtype=='complex128','complex add dtype 37 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-1.0,-3.0),np.complex(1.0,-1.0),np.complex(1.0,-2.0),np.complex(-4.0,0.0),np.complex(5.0,2.0),np.complex(1.0,3.5)},2e-12),'complex add values 37')
end
do -- add 38
 local a=np.array({np.complex(-2.0,0.0),np.complex(-3.0,-1.0),np.complex(0.25,-0.0),np.complex(-1.0,-3.0),np.complex(0.0,3.0),np.complex(-3.0,-0.0)},np.complex64)
 local b=np.array({2.0,-0.0,0.0,-3.0,0.0,1.0},np.float32)
 local r=np.add(a,b)
 assert(r.dtype=='complex64','complex add dtype 38 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,0.0),np.complex(-3.0,-1.0),np.complex(0.25,0.0),np.complex(-4.0,-3.0),np.complex(0.0,3.0),np.complex(-2.0,0.0)},3e-05),'complex add values 38')
end
do -- add 39
 local a=np.array({np.complex(0.25,-1.0),np.complex(1.0,1.0),np.complex(-1.0,0.0),np.complex(2.0,-3.0),np.complex(1.0,1.0),np.complex(4.0,-0.0)},np.complex64)
 local b=np.array({np.complex(0.0,-0.0),np.complex(-3.0,-3.0),np.complex(4.0,-0.0),np.complex(-1.0,-3.0),np.complex(1.0,-3.0),np.complex(2.0,-1.0)},np.complex64)
 local r=np.add(a,b)
 assert(r.dtype=='complex64','complex add dtype 39 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.25,-1.0),np.complex(-2.0,-2.0),np.complex(3.0,0.0),np.complex(1.0,-6.0),np.complex(2.0,-2.0),np.complex(6.0,-1.0)},3e-05),'complex add values 39')
end
do -- add 40
 local a=np.array({np.complex(-1.0,-0.0),np.complex(1.0,0.0),np.complex(0.25,0.5),np.complex(-2.0,3.0),np.complex(-0.0,3.0),np.complex(4.0,1.0)},np.complex128)
 local b=np.array({-1.0,0.5,-0.0,-3.0,4.0,-3.0},np.float64)
 local r=np.add(a,b)
 assert(r.dtype=='complex128','complex add dtype 40 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-2.0,0.0),np.complex(1.5,0.0),np.complex(0.25,0.5),np.complex(-5.0,3.0),np.complex(4.0,3.0),np.complex(1.0,1.0)},2e-12),'complex add values 40')
end
do -- add 41
 local a=np.array({np.complex(2.0,-0.0),np.complex(2.0,-3.0),np.complex(2.0,3.0),np.complex(-0.0,-0.0),np.complex(-1.0,0.0),np.complex(-3.0,-1.0)},np.complex128)
 local b=np.array({0.5,-0.0,1.0,-3.0,-1.0,0.5},np.float32)
 local r=np.add(a,b)
 assert(r.dtype=='complex128','complex add dtype 41 '..r.dtype)
 assert(close(r:tolist(),{np.complex(2.5,0.0),np.complex(2.0,-3.0),np.complex(3.0,3.0),np.complex(-3.0,0.0),np.complex(-2.0,0.0),np.complex(-2.5,-1.0)},2e-12),'complex add values 41')
end
do -- add 42
 local a=np.array({np.complex(2.0,-3.0),np.complex(4.0,-3.0),np.complex(-0.0,3.0),np.complex(0.25,1.0),np.complex(-0.0,-1.0),np.complex(2.0,0.5)},np.complex64)
 local b=np.array({0.0,-3.0,-0.0,-0.0,4.0,-3.0},np.float64)
 local r=np.add(a,b)
 assert(r.dtype=='complex128','complex add dtype 42 '..r.dtype)
 assert(close(r:tolist(),{np.complex(2.0,-3.0),np.complex(1.0,-3.0),np.complex(-0.0,3.0),np.complex(0.25,1.0),np.complex(4.0,-1.0),np.complex(-1.0,0.5)},2e-12),'complex add values 42')
end
do -- subtract 43
 local a=np.array({np.complex(4.0,3.0),np.complex(-3.0,0.0),np.complex(4.0,3.0),np.complex(-0.0,1.0),np.complex(0.25,1.0),np.complex(-1.0,-1.0)},np.complex64)
 local b=np.array({np.complex(-3.0,0.0),np.complex(-0.0,0.5),np.complex(4.0,-1.0),np.complex(4.0,-3.0),np.complex(1.0,-3.0),np.complex(-2.0,-0.0)},np.complex64)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex64','complex subtract dtype 43 '..r.dtype)
 assert(close(r:tolist(),{np.complex(7.0,3.0),np.complex(-3.0,-0.5),np.complex(0.0,4.0),np.complex(-4.0,4.0),np.complex(-0.75,4.0),np.complex(1.0,-1.0)},3e-05),'complex subtract values 43')
end
do -- subtract 44
 local a=np.array({np.complex(0.0,0.5),np.complex(-3.0,1.0),np.complex(2.0,-3.0),np.complex(-0.0,0.5),np.complex(-0.0,0.5),np.complex(1.0,-1.0)},np.complex128)
 local b=np.array({np.complex(-3.0,-3.0),np.complex(-1.0,-0.0),np.complex(-0.0,1.0),np.complex(-2.0,-1.0),np.complex(-0.0,1.0),np.complex(-3.0,-0.0)},np.complex64)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex128','complex subtract dtype 44 '..r.dtype)
 assert(close(r:tolist(),{np.complex(3.0,3.5),np.complex(-2.0,1.0),np.complex(2.0,-4.0),np.complex(2.0,1.5),np.complex(0.0,-0.5),np.complex(4.0,-1.0)},2e-12),'complex subtract values 44')
end
do -- subtract 45
 local a=np.array({np.complex(-2.0,-3.0),np.complex(-0.0,0.5),np.complex(-1.0,3.0),np.complex(-2.0,0.5),np.complex(-0.0,0.0),np.complex(2.0,3.0)},np.complex128)
 local b=np.array({1.0,1.0,0.0,4.0,0.5,0.5},np.float32)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex128','complex subtract dtype 45 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-3.0,-3.0),np.complex(-1.0,0.5),np.complex(-1.0,3.0),np.complex(-6.0,0.5),np.complex(-0.5,0.0),np.complex(1.5,3.0)},2e-12),'complex subtract values 45')
end
do -- subtract 46
 local a=np.array({np.complex(-2.0,3.0),np.complex(-1.0,-0.0),np.complex(-3.0,3.0),np.complex(1.0,3.0),np.complex(2.0,-3.0),np.complex(2.0,-1.0)},np.complex128)
 local b=np.array({np.complex(1.0,0.5),np.complex(-2.0,-3.0),np.complex(1.0,3.0),np.complex(1.0,-0.0),np.complex(4.0,0.0),np.complex(0.0,-0.0)},np.complex64)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex128','complex subtract dtype 46 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-3.0,2.5),np.complex(1.0,3.0),np.complex(-4.0,0.0),np.complex(0.0,3.0),np.complex(-2.0,-3.0),np.complex(2.0,-1.0)},2e-12),'complex subtract values 46')
end
do -- subtract 47
 local a=np.array({np.complex(-1.0,1.0),np.complex(0.25,1.0),np.complex(-1.0,-3.0),np.complex(0.0,3.0),np.complex(-3.0,-0.0),np.complex(2.0,0.0)},np.complex64)
 local b=np.array({4.0,2.0,2.0,2.0,2.0,-0.0},np.float64)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex128','complex subtract dtype 47 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-5.0,1.0),np.complex(-1.75,1.0),np.complex(-3.0,-3.0),np.complex(-2.0,3.0),np.complex(-5.0,-0.0),np.complex(2.0,0.0)},2e-12),'complex subtract values 47')
end
do -- subtract 48
 local a=np.array({np.complex(-2.0,0.5),np.complex(4.0,-1.0),np.complex(-1.0,0.0),np.complex(1.0,3.0),np.complex(0.25,-3.0),np.complex(4.0,-0.0)},np.complex64)
 local b=np.array({np.complex(-1.0,-1.0),np.complex(0.0,0.0),np.complex(0.25,0.0),np.complex(0.25,0.5),np.complex(-2.0,-0.0),np.complex(-3.0,0.0)},np.complex64)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex64','complex subtract dtype 48 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-1.0,1.5),np.complex(4.0,-1.0),np.complex(-1.25,0.0),np.complex(0.75,2.5),np.complex(2.25,-3.0),np.complex(7.0,-0.0)},3e-05),'complex subtract values 48')
end
do -- subtract 49
 local a=np.array({np.complex(0.0,0.5),np.complex(4.0,0.5),np.complex(1.0,-1.0),np.complex(2.0,0.5),np.complex(0.0,1.0),np.complex(-2.0,0.5)},np.complex64)
 local b=np.array({-0.0,4.0,4.0,-1.0,2.0,0.5},np.float16)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex64','complex subtract dtype 49 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,0.5),np.complex(0.0,0.5),np.complex(-3.0,-1.0),np.complex(3.0,0.5),np.complex(-2.0,1.0),np.complex(-2.5,0.5)},3e-05),'complex subtract values 49')
end
do -- subtract 50
 local a=np.array({np.complex(4.0,0.0),np.complex(-3.0,3.0),np.complex(1.0,1.0),np.complex(-0.0,0.5),np.complex(-1.0,-1.0),np.complex(4.0,1.0)},np.complex128)
 local b=np.array({0.5,1.0,1.0,0.5,-0.0,-3.0},np.float32)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex128','complex subtract dtype 50 '..r.dtype)
 assert(close(r:tolist(),{np.complex(3.5,0.0),np.complex(-4.0,3.0),np.complex(0.0,1.0),np.complex(-0.5,0.5),np.complex(-1.0,-1.0),np.complex(7.0,1.0)},2e-12),'complex subtract values 50')
end
do -- subtract 51
 local a=np.array({np.complex(1.0,0.5),np.complex(0.25,1.0),np.complex(-0.0,-0.0),np.complex(-1.0,1.0),np.complex(0.25,3.0),np.complex(4.0,0.5)},np.complex64)
 local b=np.array({1.0,0.5,2.0,4.0,-1.0,4.0},np.float64)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex128','complex subtract dtype 51 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,0.5),np.complex(-0.25,1.0),np.complex(-2.0,-0.0),np.complex(-5.0,1.0),np.complex(1.25,3.0),np.complex(0.0,0.5)},2e-12),'complex subtract values 51')
end
do -- subtract 52
 local a=np.array({np.complex(-3.0,0.0),np.complex(4.0,-3.0),np.complex(2.0,1.0),np.complex(-0.0,-0.0),np.complex(-2.0,3.0),np.complex(-3.0,0.0)},np.complex64)
 local b=np.array({np.complex(-0.0,3.0),np.complex(0.0,3.0),np.complex(1.0,3.0),np.complex(4.0,0.0),np.complex(1.0,0.5),np.complex(-3.0,-0.0)},np.complex128)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex128','complex subtract dtype 52 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-3.0,-3.0),np.complex(4.0,-6.0),np.complex(1.0,-2.0),np.complex(-4.0,-0.0),np.complex(-3.0,2.5),np.complex(0.0,0.0)},2e-12),'complex subtract values 52')
end
do -- subtract 53
 local a=np.array({np.complex(-3.0,0.0),np.complex(0.25,0.0),np.complex(4.0,0.5),np.complex(0.0,-0.0),np.complex(1.0,1.0),np.complex(1.0,-0.0)},np.complex128)
 local b=np.array({np.complex(0.25,1.0),np.complex(0.0,0.5),np.complex(-3.0,0.0),np.complex(0.0,3.0),np.complex(0.0,-0.0),np.complex(-1.0,0.0)},np.complex128)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex128','complex subtract dtype 53 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-3.25,-1.0),np.complex(0.25,-0.5),np.complex(7.0,0.5),np.complex(0.0,-3.0),np.complex(1.0,1.0),np.complex(2.0,-0.0)},2e-12),'complex subtract values 53')
end
do -- subtract 54
 local a=np.array({np.complex(1.0,0.5),np.complex(1.0,1.0),np.complex(4.0,-0.0),np.complex(-3.0,3.0),np.complex(-1.0,1.0),np.complex(0.25,-1.0)},np.complex128)
 local b=np.array({0.5,0.5,-3.0,-3.0,0.5,-3.0},np.float16)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex128','complex subtract dtype 54 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.5,0.5),np.complex(0.5,1.0),np.complex(7.0,-0.0),np.complex(0.0,3.0),np.complex(-1.5,1.0),np.complex(3.25,-1.0)},2e-12),'complex subtract values 54')
end
do -- subtract 55
 local a=np.array({np.complex(4.0,-3.0),np.complex(1.0,3.0),np.complex(-3.0,-1.0),np.complex(-3.0,-3.0),np.complex(-2.0,-0.0),np.complex(4.0,3.0)},np.complex128)
 local b=np.array({np.complex(-2.0,0.5),np.complex(4.0,1.0),np.complex(-3.0,-3.0),np.complex(-2.0,-3.0),np.complex(-3.0,0.5),np.complex(1.0,-0.0)},np.complex64)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex128','complex subtract dtype 55 '..r.dtype)
 assert(close(r:tolist(),{np.complex(6.0,-3.5),np.complex(-3.0,2.0),np.complex(0.0,2.0),np.complex(-1.0,0.0),np.complex(1.0,-0.5),np.complex(3.0,3.0)},2e-12),'complex subtract values 55')
end
do -- subtract 56
 local a=np.array({np.complex(1.0,0.5),np.complex(1.0,-0.0),np.complex(0.25,0.5),np.complex(0.25,-1.0),np.complex(4.0,-0.0),np.complex(2.0,-1.0)},np.complex64)
 local b=np.array({np.complex(0.0,-0.0),np.complex(1.0,-3.0),np.complex(4.0,3.0),np.complex(-3.0,-1.0),np.complex(1.0,-3.0),np.complex(4.0,0.0)},np.complex128)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex128','complex subtract dtype 56 '..r.dtype)
 assert(close(r:tolist(),{np.complex(1.0,0.5),np.complex(0.0,3.0),np.complex(-3.75,-2.5),np.complex(3.25,0.0),np.complex(3.0,3.0),np.complex(-2.0,-1.0)},2e-12),'complex subtract values 56')
end
do -- subtract 57
 local a=np.array({np.complex(-3.0,3.0),np.complex(1.0,0.5),np.complex(1.0,0.0),np.complex(-2.0,0.0),np.complex(0.0,-0.0),np.complex(-0.0,-3.0)},np.complex128)
 local b=np.array({4.0,4.0,4.0,0.0,0.5,1.0},np.float64)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex128','complex subtract dtype 57 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-7.0,3.0),np.complex(-3.0,0.5),np.complex(-3.0,0.0),np.complex(-2.0,0.0),np.complex(-0.5,-0.0),np.complex(-1.0,-3.0)},2e-12),'complex subtract values 57')
end
do -- subtract 58
 local a=np.array({np.complex(-3.0,0.0),np.complex(-1.0,-1.0),np.complex(1.0,-3.0),np.complex(0.0,1.0),np.complex(4.0,-0.0),np.complex(0.25,-3.0)},np.complex64)
 local b=np.array({np.complex(-0.0,0.5),np.complex(0.0,0.5),np.complex(1.0,1.0),np.complex(0.0,3.0),np.complex(1.0,-1.0),np.complex(-2.0,3.0)},np.complex64)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex64','complex subtract dtype 58 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-3.0,-0.5),np.complex(-1.0,-1.5),np.complex(0.0,-4.0),np.complex(0.0,-2.0),np.complex(3.0,1.0),np.complex(2.25,-6.0)},3e-05),'complex subtract values 58')
end
do -- subtract 59
 local a=np.array({np.complex(0.0,1.0),np.complex(2.0,-3.0),np.complex(-0.0,3.0),np.complex(0.25,1.0),np.complex(0.25,-0.0),np.complex(-2.0,0.0)},np.complex64)
 local b=np.array({0.0,2.0,4.0,0.0,1.0,2.0},np.float32)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex64','complex subtract dtype 59 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,1.0),np.complex(0.0,-3.0),np.complex(-4.0,3.0),np.complex(0.25,1.0),np.complex(-0.75,-0.0),np.complex(-4.0,0.0)},3e-05),'complex subtract values 59')
end
do -- subtract 60
 local a=np.array({np.complex(1.0,0.0),np.complex(-0.0,-1.0),np.complex(-3.0,1.0),np.complex(-2.0,0.5),np.complex(-0.0,0.5),np.complex(-0.0,-1.0)},np.complex128)
 local b=np.array({4.0,-3.0,1.0,2.0,2.0,1.0},np.float32)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex128','complex subtract dtype 60 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-3.0,0.0),np.complex(3.0,-1.0),np.complex(-4.0,1.0),np.complex(-4.0,0.5),np.complex(-2.0,0.5),np.complex(-1.0,-1.0)},2e-12),'complex subtract values 60')
end
do -- subtract 61
 local a=np.array({np.complex(-0.0,0.0),np.complex(0.25,-0.0),np.complex(1.0,0.5),np.complex(0.25,-0.0),np.complex(4.0,3.0),np.complex(2.0,-3.0)},np.complex64)
 local b=np.array({np.complex(-0.0,-3.0),np.complex(-2.0,3.0),np.complex(-2.0,0.5),np.complex(-0.0,-1.0),np.complex(-3.0,-0.0),np.complex(-1.0,-0.0)},np.complex64)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex64','complex subtract dtype 61 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,3.0),np.complex(2.25,-3.0),np.complex(3.0,0.0),np.complex(0.25,1.0),np.complex(7.0,3.0),np.complex(3.0,-3.0)},3e-05),'complex subtract values 61')
end
do -- subtract 62
 local a=np.array({np.complex(-2.0,3.0),np.complex(2.0,-0.0),np.complex(-0.0,3.0),np.complex(1.0,0.0),np.complex(-2.0,1.0),np.complex(-0.0,1.0)},np.complex128)
 local b=np.array({np.complex(-3.0,0.0),np.complex(0.0,-3.0),np.complex(0.0,0.5),np.complex(0.25,0.0),np.complex(4.0,0.0),np.complex(1.0,1.0)},np.complex128)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex128','complex subtract dtype 62 '..r.dtype)
 assert(close(r:tolist(),{np.complex(1.0,3.0),np.complex(2.0,3.0),np.complex(-0.0,2.5),np.complex(0.75,0.0),np.complex(-6.0,1.0),np.complex(-1.0,0.0)},2e-12),'complex subtract values 62')
end
do -- subtract 63
 local a=np.array({np.complex(-2.0,3.0),np.complex(-2.0,-0.0),np.complex(1.0,3.0),np.complex(1.0,0.5),np.complex(-0.0,3.0),np.complex(0.0,1.0)},np.complex128)
 local b=np.array({0.0,0.5,-3.0,-0.0,1.0,0.0},np.float16)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex128','complex subtract dtype 63 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-2.0,3.0),np.complex(-2.5,-0.0),np.complex(4.0,3.0),np.complex(1.0,0.5),np.complex(-1.0,3.0),np.complex(0.0,1.0)},2e-12),'complex subtract values 63')
end
do -- subtract 64
 local a=np.array({np.complex(-0.0,-1.0),np.complex(-1.0,-3.0),np.complex(0.25,-1.0),np.complex(4.0,0.0),np.complex(4.0,-0.0),np.complex(4.0,0.5)},np.complex64)
 local b=np.array({np.complex(4.0,3.0),np.complex(1.0,-3.0),np.complex(0.0,1.0),np.complex(-0.0,0.0),np.complex(2.0,1.0),np.complex(4.0,1.0)},np.complex64)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex64','complex subtract dtype 64 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-4.0,-4.0),np.complex(-2.0,0.0),np.complex(0.25,-2.0),np.complex(4.0,0.0),np.complex(2.0,-1.0),np.complex(0.0,-0.5)},3e-05),'complex subtract values 64')
end
do -- subtract 65
 local a=np.array({np.complex(2.0,1.0),np.complex(-2.0,0.0),np.complex(4.0,-0.0),np.complex(0.0,1.0),np.complex(-3.0,1.0),np.complex(-0.0,0.0)},np.complex128)
 local b=np.array({2.0,-0.0,0.5,1.0,-3.0,-1.0},np.float32)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex128','complex subtract dtype 65 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,1.0),np.complex(-2.0,0.0),np.complex(3.5,-0.0),np.complex(-1.0,1.0),np.complex(0.0,1.0),np.complex(1.0,0.0)},2e-12),'complex subtract values 65')
end
do -- subtract 66
 local a=np.array({np.complex(-0.0,0.5),np.complex(1.0,3.0),np.complex(-1.0,-3.0),np.complex(-0.0,-0.0),np.complex(-1.0,3.0),np.complex(2.0,0.0)},np.complex128)
 local b=np.array({-1.0,-0.0,4.0,-1.0,4.0,-1.0},np.float16)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex128','complex subtract dtype 66 '..r.dtype)
 assert(close(r:tolist(),{np.complex(1.0,0.5),np.complex(1.0,3.0),np.complex(-5.0,-3.0),np.complex(1.0,-0.0),np.complex(-5.0,3.0),np.complex(3.0,0.0)},2e-12),'complex subtract values 66')
end
do -- multiply 67
 local a=np.array({np.complex(-1.0,3.0),np.complex(0.25,1.0),np.complex(-1.0,0.0),np.complex(-3.0,0.0),np.complex(0.0,-0.0),np.complex(0.0,-3.0)},np.complex64)
 local b=np.array({2.0,0.5,0.0,4.0,-0.0,2.0},np.float64)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex128','complex multiply dtype 67 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-2.0,6.0),np.complex(0.125,0.5),np.complex(-0.0,0.0),np.complex(-12.0,0.0),np.complex(0.0,0.0),np.complex(0.0,-6.0)},2e-12),'complex multiply values 67')
end
do -- multiply 68
 local a=np.array({np.complex(0.0,-1.0),np.complex(-1.0,0.0),np.complex(0.0,0.5),np.complex(0.0,3.0),np.complex(0.25,-0.0),np.complex(-2.0,0.0)},np.complex128)
 local b=np.array({np.complex(-0.0,-0.0),np.complex(2.0,-1.0),np.complex(-2.0,0.0),np.complex(0.0,3.0),np.complex(1.0,0.0),np.complex(-1.0,-0.0)},np.complex128)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex128','complex multiply dtype 68 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-0.0,0.0),np.complex(-2.0,1.0),np.complex(-0.0,-1.0),np.complex(-9.0,0.0),np.complex(0.25,0.0),np.complex(2.0,0.0)},2e-12),'complex multiply values 68')
end
do -- multiply 69
 local a=np.array({np.complex(-1.0,3.0),np.complex(-3.0,-3.0),np.complex(-2.0,3.0),np.complex(4.0,0.0),np.complex(2.0,0.5),np.complex(1.0,3.0)},np.complex128)
 local b=np.array({2.0,-3.0,-1.0,0.0,0.0,-0.0},np.float32)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex128','complex multiply dtype 69 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-2.0,6.0),np.complex(9.0,9.0),np.complex(2.0,-3.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(-0.0,0.0)},2e-12),'complex multiply values 69')
end
do -- multiply 70
 local a=np.array({np.complex(-3.0,-0.0),np.complex(0.0,1.0),np.complex(0.25,3.0),np.complex(-2.0,-3.0),np.complex(0.0,1.0),np.complex(0.25,-0.0)},np.complex64)
 local b=np.array({0.5,4.0,0.5,-3.0,-3.0,1.0},np.float64)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex128','complex multiply dtype 70 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-1.5,-0.0),np.complex(0.0,4.0),np.complex(0.125,1.5),np.complex(6.0,9.0),np.complex(-0.0,-3.0),np.complex(0.25,0.0)},2e-12),'complex multiply values 70')
end
do -- multiply 71
 local a=np.array({np.complex(-1.0,3.0),np.complex(0.25,0.0),np.complex(-1.0,-0.0),np.complex(4.0,0.0),np.complex(2.0,1.0),np.complex(4.0,-1.0)},np.complex64)
 local b=np.array({-1.0,4.0,-3.0,1.0,-0.0,0.5},np.float64)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex128','complex multiply dtype 71 '..r.dtype)
 assert(close(r:tolist(),{np.complex(1.0,-3.0),np.complex(1.0,0.0),np.complex(3.0,0.0),np.complex(4.0,0.0),np.complex(-0.0,0.0),np.complex(2.0,-0.5)},2e-12),'complex multiply values 71')
end
do -- multiply 72
 local a=np.array({np.complex(-3.0,-0.0),np.complex(4.0,-3.0),np.complex(0.25,-1.0),np.complex(1.0,-3.0),np.complex(0.0,-3.0),np.complex(-0.0,-0.0)},np.complex64)
 local b=np.array({np.complex(1.0,-1.0),np.complex(-0.0,3.0),np.complex(0.0,1.0),np.complex(0.0,3.0),np.complex(0.0,-1.0),np.complex(-3.0,-0.0)},np.complex128)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex128','complex multiply dtype 72 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-3.0,3.0),np.complex(9.0,12.0),np.complex(1.0,0.25),np.complex(9.0,3.0),np.complex(-3.0,-0.0),np.complex(0.0,0.0)},2e-12),'complex multiply values 72')
end
do -- multiply 73
 local a=np.array({np.complex(4.0,3.0),np.complex(-0.0,0.5),np.complex(-2.0,-1.0),np.complex(-2.0,-3.0),np.complex(-1.0,-0.0),np.complex(-3.0,3.0)},np.complex64)
 local b=np.array({-0.0,0.5,-1.0,4.0,-0.0,4.0},np.float64)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex128','complex multiply dtype 73 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-0.0,0.0),np.complex(-0.0,0.25),np.complex(2.0,1.0),np.complex(-8.0,-12.0),np.complex(0.0,0.0),np.complex(-12.0,12.0)},2e-12),'complex multiply values 73')
end
do -- multiply 74
 local a=np.array({np.complex(2.0,-1.0),np.complex(-1.0,-1.0),np.complex(2.0,3.0),np.complex(-0.0,3.0),np.complex(4.0,0.5),np.complex(2.0,-3.0)},np.complex64)
 local b=np.array({np.complex(2.0,-1.0),np.complex(-3.0,0.0),np.complex(-2.0,0.0),np.complex(0.0,1.0),np.complex(1.0,0.0),np.complex(0.0,3.0)},np.complex64)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex64','complex multiply dtype 74 '..r.dtype)
 assert(close(r:tolist(),{np.complex(3.0,-4.0),np.complex(3.0,3.0),np.complex(-4.0,-6.0),np.complex(-3.0,0.0),np.complex(4.0,0.5),np.complex(9.0,6.0)},3e-05),'complex multiply values 74')
end
do -- multiply 75
 local a=np.array({np.complex(0.0,1.0),np.complex(4.0,0.0),np.complex(-2.0,-1.0),np.complex(0.25,1.0),np.complex(-0.0,0.5),np.complex(4.0,-1.0)},np.complex128)
 local b=np.array({-1.0,2.0,2.0,4.0,2.0,-0.0},np.float16)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex128','complex multiply dtype 75 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-0.0,-1.0),np.complex(8.0,0.0),np.complex(-4.0,-2.0),np.complex(1.0,4.0),np.complex(-0.0,1.0),np.complex(0.0,0.0)},2e-12),'complex multiply values 75')
end
do -- multiply 76
 local a=np.array({np.complex(-0.0,-3.0),np.complex(-1.0,-3.0),np.complex(-0.0,-3.0),np.complex(-2.0,-3.0),np.complex(-3.0,1.0),np.complex(4.0,-1.0)},np.complex64)
 local b=np.array({np.complex(2.0,-0.0),np.complex(1.0,0.5),np.complex(2.0,0.5),np.complex(2.0,-0.0),np.complex(2.0,-1.0),np.complex(-1.0,-1.0)},np.complex64)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex64','complex multiply dtype 76 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-0.0,-6.0),np.complex(0.5,-3.5),np.complex(1.5,-6.0),np.complex(-4.0,-6.0),np.complex(-5.0,5.0),np.complex(-5.0,-3.0)},3e-05),'complex multiply values 76')
end
do -- multiply 77
 local a=np.array({np.complex(-3.0,0.0),np.complex(1.0,-3.0),np.complex(-0.0,-0.0),np.complex(-2.0,0.0),np.complex(4.0,0.5),np.complex(0.25,-1.0)},np.complex64)
 local b=np.array({4.0,0.5,0.5,-0.0,-1.0,0.0},np.float16)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex64','complex multiply dtype 77 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-12.0,0.0),np.complex(0.5,-1.5),np.complex(0.0,-0.0),np.complex(0.0,-0.0),np.complex(-4.0,-0.5),np.complex(0.0,0.0)},3e-05),'complex multiply values 77')
end
do -- multiply 78
 local a=np.array({np.complex(0.25,-1.0),np.complex(0.25,-0.0),np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(-3.0,3.0),np.complex(0.0,0.0)},np.complex128)
 local b=np.array({-1.0,-0.0,4.0,-3.0,-1.0,-3.0},np.float64)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex128','complex multiply dtype 78 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-0.25,1.0),np.complex(0.0,0.0),np.complex(8.0,0.0),np.complex(-6.0,0.0),np.complex(3.0,-3.0),np.complex(-0.0,0.0)},2e-12),'complex multiply values 78')
end
do -- multiply 79
 local a=np.array({np.complex(4.0,0.5),np.complex(0.25,0.5),np.complex(2.0,0.0),np.complex(-3.0,1.0),np.complex(0.25,0.0),np.complex(1.0,0.5)},np.complex128)
 local b=np.array({0.5,0.5,-3.0,0.5,-1.0,-1.0},np.float32)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex128','complex multiply dtype 79 '..r.dtype)
 assert(close(r:tolist(),{np.complex(2.0,0.25),np.complex(0.125,0.25),np.complex(-6.0,0.0),np.complex(-1.5,0.5),np.complex(-0.25,0.0),np.complex(-1.0,-0.5)},2e-12),'complex multiply values 79')
end
do -- multiply 80
 local a=np.array({np.complex(-0.0,-0.0),np.complex(-0.0,-1.0),np.complex(1.0,0.5),np.complex(-1.0,0.0),np.complex(-2.0,0.5),np.complex(-3.0,3.0)},np.complex64)
 local b=np.array({np.complex(0.25,1.0),np.complex(-0.0,-0.0),np.complex(-0.0,0.5),np.complex(0.0,1.0),np.complex(-0.0,-1.0),np.complex(-0.0,-0.0)},np.complex128)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex128','complex multiply dtype 80 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,-0.0),np.complex(0.0,0.0),np.complex(-0.25,0.5),np.complex(-0.0,-1.0),np.complex(0.5,2.0),np.complex(0.0,0.0)},2e-12),'complex multiply values 80')
end
do -- multiply 81
 local a=np.array({np.complex(-3.0,-0.0),np.complex(0.25,-0.0),np.complex(-0.0,0.5),np.complex(0.0,-0.0),np.complex(-2.0,0.0),np.complex(1.0,-0.0)},np.complex64)
 local b=np.array({4.0,-1.0,-1.0,-3.0,0.0,4.0},np.float32)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex64','complex multiply dtype 81 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-12.0,-0.0),np.complex(-0.25,0.0),np.complex(0.0,-0.5),np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(4.0,0.0)},3e-05),'complex multiply values 81')
end
do -- multiply 82
 local a=np.array({np.complex(1.0,-1.0),np.complex(-0.0,0.0),np.complex(0.0,0.5),np.complex(-2.0,-1.0),np.complex(-0.0,-0.0),np.complex(0.0,-1.0)},np.complex64)
 local b=np.array({np.complex(2.0,0.5),np.complex(-2.0,-3.0),np.complex(-3.0,-3.0),np.complex(-3.0,-1.0),np.complex(2.0,-1.0),np.complex(-1.0,-0.0)},np.complex128)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex128','complex multiply dtype 82 '..r.dtype)
 assert(close(r:tolist(),{np.complex(2.5,-1.5),np.complex(0.0,0.0),np.complex(1.5,-1.5),np.complex(5.0,5.0),np.complex(-0.0,0.0),np.complex(-0.0,1.0)},2e-12),'complex multiply values 82')
end
do -- multiply 83
 local a=np.array({np.complex(0.0,-0.0),np.complex(2.0,3.0),np.complex(4.0,0.5),np.complex(-0.0,1.0),np.complex(-3.0,-3.0),np.complex(1.0,1.0)},np.complex64)
 local b=np.array({np.complex(4.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(1.0,-3.0),np.complex(-3.0,-1.0),np.complex(0.25,1.0)},np.complex128)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex128','complex multiply dtype 83 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(3.0,1.0),np.complex(6.0,12.0),np.complex(-0.75,1.25)},2e-12),'complex multiply values 83')
end
do -- multiply 84
 local a=np.array({np.complex(-3.0,-3.0),np.complex(-3.0,-3.0),np.complex(-0.0,3.0),np.complex(-3.0,-1.0),np.complex(-0.0,3.0),np.complex(2.0,0.0)},np.complex64)
 local b=np.array({np.complex(0.25,1.0),np.complex(1.0,0.5),np.complex(-0.0,0.0),np.complex(0.0,0.5),np.complex(-0.0,0.0),np.complex(0.0,1.0)},np.complex128)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex128','complex multiply dtype 84 '..r.dtype)
 assert(close(r:tolist(),{np.complex(2.25,-3.75),np.complex(-1.5,-4.5),np.complex(0.0,-0.0),np.complex(0.5,-1.5),np.complex(0.0,-0.0),np.complex(0.0,2.0)},2e-12),'complex multiply values 84')
end
do -- multiply 85
 local a=np.array({np.complex(2.0,-1.0),np.complex(-0.0,0.0),np.complex(0.0,-3.0),np.complex(-0.0,1.0),np.complex(4.0,3.0),np.complex(-3.0,1.0)},np.complex64)
 local b=np.array({-1.0,2.0,4.0,-3.0,-3.0,-3.0},np.float64)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex128','complex multiply dtype 85 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-2.0,1.0),np.complex(-0.0,0.0),np.complex(0.0,-12.0),np.complex(0.0,-3.0),np.complex(-12.0,-9.0),np.complex(9.0,-3.0)},2e-12),'complex multiply values 85')
end
do -- multiply 86
 local a=np.array({np.complex(-0.0,-3.0),np.complex(1.0,1.0),np.complex(0.25,1.0),np.complex(0.0,0.5),np.complex(4.0,-3.0),np.complex(2.0,1.0)},np.complex64)
 local b=np.array({np.complex(0.0,-1.0),np.complex(-0.0,-0.0),np.complex(2.0,-1.0),np.complex(-1.0,1.0),np.complex(1.0,-1.0),np.complex(-1.0,1.0)},np.complex128)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex128','complex multiply dtype 86 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-3.0,0.0),np.complex(0.0,-0.0),np.complex(1.5,1.75),np.complex(-0.5,-0.5),np.complex(1.0,-7.0),np.complex(-3.0,1.0)},2e-12),'complex multiply values 86')
end
do -- multiply 87
 local a=np.array({np.complex(2.0,1.0),np.complex(4.0,3.0),np.complex(4.0,-0.0),np.complex(0.25,1.0),np.complex(-3.0,1.0),np.complex(0.0,-0.0)},np.complex128)
 local b=np.array({np.complex(2.0,-0.0),np.complex(-1.0,-0.0),np.complex(-0.0,-3.0),np.complex(-2.0,-0.0),np.complex(4.0,1.0),np.complex(4.0,3.0)},np.complex128)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex128','complex multiply dtype 87 '..r.dtype)
 assert(close(r:tolist(),{np.complex(4.0,2.0),np.complex(-4.0,-3.0),np.complex(-0.0,-12.0),np.complex(-0.5,-2.0),np.complex(-13.0,1.0),np.complex(0.0,0.0)},2e-12),'complex multiply values 87')
end
do -- multiply 88
 local a=np.array({np.complex(-3.0,1.0),np.complex(2.0,-1.0),np.complex(-2.0,1.0),np.complex(-3.0,3.0),np.complex(0.25,-0.0),np.complex(0.25,0.0)},np.complex64)
 local b=np.array({0.5,4.0,-0.0,-0.0,1.0,-0.0},np.float64)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex128','complex multiply dtype 88 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-1.5,0.5),np.complex(8.0,-4.0),np.complex(0.0,-0.0),np.complex(0.0,-0.0),np.complex(0.25,0.0),np.complex(-0.0,0.0)},2e-12),'complex multiply values 88')
end
do -- multiply 89
 local a=np.array({np.complex(4.0,0.0),np.complex(-1.0,0.5),np.complex(0.25,0.0),np.complex(-1.0,-3.0),np.complex(0.25,3.0),np.complex(-2.0,0.5)},np.complex64)
 local b=np.array({-1.0,1.0,0.5,-1.0,0.5,4.0},np.float64)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex128','complex multiply dtype 89 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-4.0,0.0),np.complex(-1.0,0.5),np.complex(0.125,0.0),np.complex(1.0,3.0),np.complex(0.125,1.5),np.complex(-8.0,2.0)},2e-12),'complex multiply values 89')
end
do -- multiply 90
 local a=np.array({np.complex(-3.0,0.0),np.complex(0.25,1.0),np.complex(0.0,-0.0),np.complex(0.0,1.0),np.complex(-2.0,0.5),np.complex(-0.0,-1.0)},np.complex64)
 local b=np.array({-0.0,0.5,2.0,0.5,2.0,1.0},np.float32)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex64','complex multiply dtype 90 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,-0.0),np.complex(0.125,0.5),np.complex(0.0,0.0),np.complex(0.0,0.5),np.complex(-4.0,1.0),np.complex(0.0,-1.0)},3e-05),'complex multiply values 90')
end
do -- true_divide 91
 local a=np.array({np.complex(-3.0,3.0),np.complex(-3.0,1.0),np.complex(0.25,0.0),np.complex(-0.0,1.0),np.complex(-0.0,0.0),np.complex(0.25,1.0)},np.complex64)
 local b=np.array({1.0,4.0,1.0,1.0,2.0,-3.0},np.float32)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex64','complex true_divide dtype 91 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-3.0,3.0),np.complex(-0.75,0.25),np.complex(0.25,0.0),np.complex(0.0,1.0),np.complex(0.0,0.0),np.complex(-0.0833333358168602,-0.3333333432674408)},3e-05),'complex true_divide values 91')
end
do -- true_divide 92
 local a=np.array({np.complex(-2.0,-1.0),np.complex(1.0,0.5),np.complex(0.25,-0.0),np.complex(2.0,3.0),np.complex(4.0,0.0),np.complex(-3.0,0.0)},np.complex128)
 local b=np.array({-3.0,2.0,1.0,0.5,0.5,1.0},np.float16)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex128','complex true_divide dtype 92 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.6666666666666666,0.3333333333333333),np.complex(0.5,0.25),np.complex(0.25,-0.0),np.complex(4.0,6.0),np.complex(8.0,0.0),np.complex(-3.0,0.0)},2e-12),'complex true_divide values 92')
end
do -- true_divide 93
 local a=np.array({np.complex(0.25,3.0),np.complex(-2.0,0.0),np.complex(-2.0,1.0),np.complex(-1.0,-1.0),np.complex(-0.0,1.0),np.complex(0.25,-3.0)},np.complex64)
 local b=np.array({np.complex(1.0,0.0),np.complex(-1.0,1.0),np.complex(-0.0,3.0),np.complex(-2.0,-0.0),np.complex(1.0,3.0),np.complex(-0.0,3.0)},np.complex128)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex128','complex true_divide dtype 93 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.25,3.0),np.complex(1.0,1.0),np.complex(0.3333333333333333,0.6666666666666666),np.complex(0.5,0.5),np.complex(0.3,0.09999999999999999),np.complex(-1.0,-0.08333333333333333)},2e-12),'complex true_divide values 93')
end
do -- true_divide 94
 local a=np.array({np.complex(-2.0,3.0),np.complex(-1.0,-1.0),np.complex(2.0,3.0),np.complex(0.25,-1.0),np.complex(-3.0,-3.0),np.complex(-3.0,0.0)},np.complex64)
 local b=np.array({1.0,1.0,-3.0,1.0,4.0,-1.0},np.float32)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex64','complex true_divide dtype 94 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-2.0,3.0),np.complex(-1.0,-1.0),np.complex(-0.6666666865348816,-1.0),np.complex(0.25,-1.0),np.complex(-0.75,-0.75),np.complex(3.0,-0.0)},3e-05),'complex true_divide values 94')
end
do -- true_divide 95
 local a=np.array({np.complex(1.0,-1.0),np.complex(1.0,3.0),np.complex(1.0,-1.0),np.complex(-1.0,-1.0),np.complex(1.0,1.0),np.complex(0.25,1.0)},np.complex128)
 local b=np.array({2.0,4.0,1.0,4.0,2.0,4.0},np.float32)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex128','complex true_divide dtype 95 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.5,-0.5),np.complex(0.25,0.75),np.complex(1.0,-1.0),np.complex(-0.25,-0.25),np.complex(0.5,0.5),np.complex(0.0625,0.25)},2e-12),'complex true_divide values 95')
end
do -- true_divide 96
 local a=np.array({np.complex(-0.0,1.0),np.complex(2.0,0.5),np.complex(4.0,1.0),np.complex(4.0,1.0),np.complex(0.25,0.5),np.complex(1.0,1.0)},np.complex64)
 local b=np.array({-3.0,0.5,1.0,-1.0,-3.0,0.5},np.float64)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex128','complex true_divide dtype 96 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,-0.3333333333333333),np.complex(4.0,1.0),np.complex(4.0,1.0),np.complex(-4.0,-1.0),np.complex(-0.08333333333333333,-0.16666666666666666),np.complex(2.0,2.0)},2e-12),'complex true_divide values 96')
end
do -- true_divide 97
 local a=np.array({np.complex(-0.0,-1.0),np.complex(0.0,-3.0),np.complex(-0.0,-3.0),np.complex(-3.0,-0.0),np.complex(2.0,1.0),np.complex(-1.0,-1.0)},np.complex128)
 local b=np.array({0.5,1.0,-3.0,4.0,-1.0,1.0},np.float16)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex128','complex true_divide dtype 97 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-0.0,-2.0),np.complex(0.0,-3.0),np.complex(-0.0,1.0),np.complex(-0.75,0.0),np.complex(-2.0,-1.0),np.complex(-1.0,-1.0)},2e-12),'complex true_divide values 97')
end
do -- true_divide 98
 local a=np.array({np.complex(0.25,3.0),np.complex(-3.0,3.0),np.complex(-3.0,-3.0),np.complex(0.25,-3.0),np.complex(-0.0,1.0),np.complex(-2.0,-1.0)},np.complex128)
 local b=np.array({2.0,1.0,-3.0,4.0,-1.0,1.0},np.float64)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex128','complex true_divide dtype 98 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.125,1.5),np.complex(-3.0,3.0),np.complex(1.0,1.0),np.complex(0.0625,-0.75),np.complex(0.0,-1.0),np.complex(-2.0,-1.0)},2e-12),'complex true_divide values 98')
end
do -- true_divide 99
 local a=np.array({np.complex(1.0,0.5),np.complex(0.0,0.0),np.complex(-0.0,1.0),np.complex(-1.0,0.5),np.complex(-0.0,1.0),np.complex(2.0,3.0)},np.complex64)
 local b=np.array({-1.0,2.0,2.0,0.5,-1.0,2.0},np.float32)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex64','complex true_divide dtype 99 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-1.0,-0.5),np.complex(0.0,0.0),np.complex(0.0,0.5),np.complex(-2.0,1.0),np.complex(0.0,-1.0),np.complex(1.0,1.5)},3e-05),'complex true_divide values 99')
end
do -- true_divide 100
 local a=np.array({np.complex(-3.0,1.0),np.complex(-1.0,1.0),np.complex(1.0,-0.0),np.complex(-2.0,1.0),np.complex(-0.0,1.0),np.complex(1.0,0.0)},np.complex128)
 local b=np.array({2.0,-3.0,-3.0,-1.0,-3.0,-3.0},np.float64)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex128','complex true_divide dtype 100 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-1.5,0.5),np.complex(0.3333333333333333,-0.3333333333333333),np.complex(-0.3333333333333333,-0.0),np.complex(2.0,-1.0),np.complex(0.0,-0.3333333333333333),np.complex(-0.3333333333333333,-0.0)},2e-12),'complex true_divide values 100')
end
do -- true_divide 101
 local a=np.array({np.complex(0.0,1.0),np.complex(2.0,1.0),np.complex(-1.0,1.0),np.complex(1.0,-1.0),np.complex(-3.0,1.0),np.complex(4.0,-0.0)},np.complex64)
 local b=np.array({1.0,2.0,1.0,4.0,1.0,1.0},np.float64)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex128','complex true_divide dtype 101 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,1.0),np.complex(1.0,0.5),np.complex(-1.0,1.0),np.complex(0.25,-0.25),np.complex(-3.0,1.0),np.complex(4.0,-0.0)},2e-12),'complex true_divide values 101')
end
do -- true_divide 102
 local a=np.array({np.complex(0.25,0.5),np.complex(-2.0,-0.0),np.complex(-0.0,-0.0),np.complex(1.0,-0.0),np.complex(0.0,0.0),np.complex(1.0,0.0)},np.complex128)
 local b=np.array({np.complex(2.0,1.0),np.complex(1.0,0.5),np.complex(0.0,0.5),np.complex(-0.0,1.0),np.complex(0.0,-1.0),np.complex(1.0,-1.0)},np.complex64)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex128','complex true_divide dtype 102 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.2,0.15000000000000002),np.complex(-1.6,0.8),np.complex(-0.0,0.0),np.complex(-0.0,-1.0),np.complex(-0.0,0.0),np.complex(0.5,0.5)},2e-12),'complex true_divide values 102')
end
do -- true_divide 103
 local a=np.array({np.complex(0.0,-1.0),np.complex(2.0,0.0),np.complex(-1.0,-3.0),np.complex(4.0,0.5),np.complex(0.0,1.0),np.complex(-1.0,3.0)},np.complex64)
 local b=np.array({np.complex(0.0,-1.0),np.complex(-2.0,0.0),np.complex(1.0,1.0),np.complex(-0.0,0.5),np.complex(0.25,0.5),np.complex(-3.0,-0.0)},np.complex128)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex128','complex true_divide dtype 103 '..r.dtype)
 assert(close(r:tolist(),{np.complex(1.0,-0.0),np.complex(-1.0,-0.0),np.complex(-2.0,-1.0),np.complex(1.0,-8.0),np.complex(1.6,0.8),np.complex(0.3333333333333333,-1.0)},2e-12),'complex true_divide values 103')
end
do -- true_divide 104
 local a=np.array({np.complex(2.0,-0.0),np.complex(-1.0,-1.0),np.complex(0.25,0.5),np.complex(-3.0,0.0),np.complex(0.0,-0.0),np.complex(2.0,-1.0)},np.complex128)
 local b=np.array({0.5,0.5,0.5,1.0,-1.0,1.0},np.float16)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex128','complex true_divide dtype 104 '..r.dtype)
 assert(close(r:tolist(),{np.complex(4.0,-0.0),np.complex(-2.0,-2.0),np.complex(0.5,1.0),np.complex(-3.0,0.0),np.complex(-0.0,-0.0),np.complex(2.0,-1.0)},2e-12),'complex true_divide values 104')
end
do -- true_divide 105
 local a=np.array({np.complex(4.0,-1.0),np.complex(0.25,-1.0),np.complex(-3.0,0.5),np.complex(0.0,-0.0),np.complex(-0.0,0.0),np.complex(0.25,1.0)},np.complex128)
 local b=np.array({np.complex(4.0,1.0),np.complex(0.25,0.0),np.complex(-0.0,-3.0),np.complex(4.0,1.0),np.complex(-1.0,-3.0),np.complex(-2.0,0.0)},np.complex128)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex128','complex true_divide dtype 105 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.8823529411764706,-0.47058823529411764),np.complex(1.0,-4.0),np.complex(-0.16666666666666666,-1.0),np.complex(0.0,-0.0),np.complex(-0.0,-0.0),np.complex(-0.125,-0.5)},2e-12),'complex true_divide values 105')
end
do -- true_divide 106
 local a=np.array({np.complex(0.25,-1.0),np.complex(2.0,-1.0),np.complex(-3.0,1.0),np.complex(-1.0,1.0),np.complex(2.0,-0.0),np.complex(0.25,1.0)},np.complex128)
 local b=np.array({np.complex(0.0,-1.0),np.complex(2.0,-0.0),np.complex(-0.0,3.0),np.complex(0.25,0.5),np.complex(-1.0,-1.0),np.complex(2.0,0.5)},np.complex64)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex128','complex true_divide dtype 106 '..r.dtype)
 assert(close(r:tolist(),{np.complex(1.0,0.25),np.complex(1.0,-0.5),np.complex(0.3333333333333333,1.0),np.complex(0.8,2.4000000000000004),np.complex(-1.0,1.0),np.complex(0.23529411764705882,0.4411764705882353)},2e-12),'complex true_divide values 106')
end
do -- true_divide 107
 local a=np.array({np.complex(0.0,0.5),np.complex(-3.0,3.0),np.complex(1.0,-3.0),np.complex(-0.0,-1.0),np.complex(0.0,3.0),np.complex(-0.0,-1.0)},np.complex128)
 local b=np.array({1.0,-3.0,1.0,-3.0,2.0,0.5},np.float32)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex128','complex true_divide dtype 107 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,0.5),np.complex(1.0,-1.0),np.complex(1.0,-3.0),np.complex(-0.0,0.3333333333333333),np.complex(0.0,1.5),np.complex(-0.0,-2.0)},2e-12),'complex true_divide values 107')
end
do -- true_divide 108
 local a=np.array({np.complex(-2.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,3.0),np.complex(0.0,3.0),np.complex(-2.0,1.0),np.complex(-0.0,3.0)},np.complex128)
 local b=np.array({np.complex(-3.0,-1.0),np.complex(1.0,0.0),np.complex(-1.0,0.5),np.complex(-2.0,1.0),np.complex(0.25,3.0),np.complex(4.0,-1.0)},np.complex64)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex128','complex true_divide dtype 108 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.6,-0.19999999999999998),np.complex(-3.0,3.0),np.complex(2.8000000000000003,-1.6),np.complex(0.6000000000000001,-1.2000000000000002),np.complex(0.27586206896551724,0.6896551724137931),np.complex(-0.1764705882352941,0.7058823529411764)},2e-12),'complex true_divide values 108')
end
do -- true_divide 109
 local a=np.array({np.complex(4.0,3.0),np.complex(-2.0,1.0),np.complex(0.25,-1.0),np.complex(-0.0,-3.0),np.complex(0.25,-1.0),np.complex(0.25,1.0)},np.complex64)
 local b=np.array({np.complex(0.25,1.0),np.complex(0.25,1.0),np.complex(-3.0,0.5),np.complex(-0.0,1.0),np.complex(4.0,-3.0),np.complex(-3.0,-1.0)},np.complex128)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex128','complex true_divide dtype 109 '..r.dtype)
 assert(close(r:tolist(),{np.complex(3.764705882352941,-3.0588235294117645),np.complex(0.47058823529411764,2.1176470588235294),np.complex(-0.13513513513513511,0.3108108108108108),np.complex(-3.0,0.0),np.complex(0.16,-0.13),np.complex(-0.17499999999999996,-0.27499999999999997)},2e-12),'complex true_divide values 109')
end
do -- true_divide 110
 local a=np.array({np.complex(0.0,0.5),np.complex(1.0,0.5),np.complex(4.0,-3.0),np.complex(2.0,-3.0),np.complex(-2.0,1.0),np.complex(-3.0,1.0)},np.complex64)
 local b=np.array({np.complex(-3.0,3.0),np.complex(-1.0,0.5),np.complex(2.0,1.0),np.complex(-3.0,-0.0),np.complex(-2.0,3.0),np.complex(-0.0,-1.0)},np.complex128)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex128','complex true_divide dtype 110 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.08333333333333333,-0.08333333333333333),np.complex(-0.6000000000000001,-0.8),np.complex(1.0,-2.0),np.complex(-0.6666666666666666,1.0),np.complex(0.5384615384615384,0.30769230769230776),np.complex(-1.0,-3.0)},2e-12),'complex true_divide values 110')
end
do -- true_divide 111
 local a=np.array({np.complex(0.25,0.0),np.complex(-3.0,-0.0),np.complex(0.25,0.0),np.complex(-2.0,3.0),np.complex(-2.0,3.0),np.complex(-1.0,0.5)},np.complex128)
 local b=np.array({1.0,1.0,-3.0,-3.0,4.0,1.0},np.float64)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex128','complex true_divide dtype 111 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.25,0.0),np.complex(-3.0,0.0),np.complex(-0.08333333333333333,-0.0),np.complex(0.6666666666666666,-1.0),np.complex(-0.5,0.75),np.complex(-1.0,0.5)},2e-12),'complex true_divide values 111')
end
do -- true_divide 112
 local a=np.array({np.complex(-0.0,0.5),np.complex(0.25,3.0),np.complex(2.0,0.5),np.complex(0.0,1.0),np.complex(2.0,0.5),np.complex(0.0,-3.0)},np.complex128)
 local b=np.array({0.5,1.0,1.0,1.0,1.0,4.0},np.float32)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex128','complex true_divide dtype 112 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,1.0),np.complex(0.25,3.0),np.complex(2.0,0.5),np.complex(0.0,1.0),np.complex(2.0,0.5),np.complex(0.0,-0.75)},2e-12),'complex true_divide values 112')
end
do -- true_divide 113
 local a=np.array({np.complex(-1.0,1.0),np.complex(1.0,0.0),np.complex(-0.0,-1.0),np.complex(-2.0,-0.0),np.complex(-3.0,-3.0),np.complex(4.0,-3.0)},np.complex64)
 local b=np.array({2.0,0.5,1.0,-3.0,4.0,1.0},np.float16)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex64','complex true_divide dtype 113 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-0.5,0.5),np.complex(2.0,0.0),np.complex(-0.0,-1.0),np.complex(0.6666666865348816,0.0),np.complex(-0.75,-0.75),np.complex(4.0,-3.0)},3e-05),'complex true_divide values 113')
end
do -- true_divide 114
 local a=np.array({np.complex(-1.0,0.0),np.complex(-1.0,-3.0),np.complex(-1.0,0.0),np.complex(-2.0,0.5),np.complex(2.0,-1.0),np.complex(-2.0,-1.0)},np.complex64)
 local b=np.array({1.0,1.0,4.0,-1.0,-3.0,-1.0},np.float32)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex64','complex true_divide dtype 114 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-1.0,0.0),np.complex(-1.0,-3.0),np.complex(-0.25,0.0),np.complex(2.0,-0.5),np.complex(-0.6666666865348816,0.3333333432674408),np.complex(2.0,1.0)},3e-05),'complex true_divide values 114')
end
do -- equal 115
 local a=np.array({np.complex(2.0,0.5),np.complex(-3.0,-0.0),np.complex(1.0,-0.0),np.complex(1.0,1.0),np.complex(-3.0,1.0),np.complex(2.0,-3.0)},np.complex64)
 local b=np.array({-3.0,0.5,-1.0,4.0,-3.0,4.0},np.float16)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 115 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex equal values 115')
end
do -- equal 116
 local a=np.array({np.complex(1.0,1.0),np.complex(-2.0,-0.0),np.complex(-3.0,0.0),np.complex(-0.0,0.5),np.complex(0.0,3.0),np.complex(0.0,0.0)},np.complex64)
 local b=np.array({np.complex(-1.0,0.0),np.complex(-2.0,3.0),np.complex(0.0,-3.0),np.complex(0.0,-3.0),np.complex(-1.0,0.5),np.complex(-0.0,-0.0)},np.complex128)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 116 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,true}),'complex equal values 116')
end
do -- equal 117
 local a=np.array({np.complex(2.0,-3.0),np.complex(-1.0,-1.0),np.complex(1.0,-0.0),np.complex(0.25,3.0),np.complex(0.25,3.0),np.complex(1.0,3.0)},np.complex128)
 local b=np.array({-0.0,4.0,-3.0,0.5,1.0,1.0},np.float64)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 117 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex equal values 117')
end
do -- equal 118
 local a=np.array({np.complex(-0.0,3.0),np.complex(-3.0,-0.0),np.complex(-1.0,3.0),np.complex(4.0,0.5),np.complex(0.0,3.0),np.complex(-3.0,-1.0)},np.complex128)
 local b=np.array({0.5,-0.0,1.0,0.0,0.0,-0.0},np.float32)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 118 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex equal values 118')
end
do -- equal 119
 local a=np.array({np.complex(4.0,0.0),np.complex(-1.0,1.0),np.complex(0.25,1.0),np.complex(-3.0,-0.0),np.complex(-3.0,-1.0),np.complex(2.0,-0.0)},np.complex64)
 local b=np.array({np.complex(-2.0,-3.0),np.complex(1.0,-0.0),np.complex(-0.0,1.0),np.complex(1.0,1.0),np.complex(0.25,1.0),np.complex(2.0,1.0)},np.complex128)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 119 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex equal values 119')
end
do -- equal 120
 local a=np.array({np.complex(-3.0,3.0),np.complex(-3.0,0.5),np.complex(0.0,-1.0),np.complex(0.0,3.0),np.complex(4.0,0.5),np.complex(0.0,0.0)},np.complex64)
 local b=np.array({2.0,1.0,1.0,-3.0,-0.0,2.0},np.float64)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 120 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex equal values 120')
end
do -- equal 121
 local a=np.array({np.complex(1.0,-1.0),np.complex(-0.0,0.5),np.complex(0.25,0.5),np.complex(-1.0,-1.0),np.complex(-2.0,-0.0),np.complex(0.25,-1.0)},np.complex128)
 local b=np.array({0.5,-0.0,0.0,-1.0,2.0,1.0},np.float16)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 121 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex equal values 121')
end
do -- equal 122
 local a=np.array({np.complex(0.25,0.0),np.complex(1.0,-1.0),np.complex(-2.0,-1.0),np.complex(1.0,-3.0),np.complex(-0.0,-3.0),np.complex(2.0,-1.0)},np.complex64)
 local b=np.array({np.complex(-2.0,0.0),np.complex(2.0,0.0),np.complex(-0.0,3.0),np.complex(0.0,-3.0),np.complex(2.0,0.5),np.complex(-3.0,3.0)},np.complex64)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 122 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex equal values 122')
end
do -- equal 123
 local a=np.array({np.complex(-0.0,-0.0),np.complex(-1.0,-1.0),np.complex(4.0,0.5),np.complex(2.0,-0.0),np.complex(-1.0,1.0),np.complex(2.0,0.5)},np.complex128)
 local b=np.array({-0.0,-0.0,-0.0,-1.0,-0.0,1.0},np.float32)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 123 '..r.dtype)
 assert(exact(r:tolist(),{true,false,false,false,false,false}),'complex equal values 123')
end
do -- equal 124
 local a=np.array({np.complex(-2.0,3.0),np.complex(4.0,-3.0),np.complex(-3.0,-1.0),np.complex(1.0,0.5),np.complex(0.25,0.5),np.complex(4.0,0.0)},np.complex64)
 local b=np.array({np.complex(-3.0,0.0),np.complex(-3.0,-3.0),np.complex(-2.0,0.0),np.complex(-2.0,-3.0),np.complex(4.0,-0.0),np.complex(-2.0,1.0)},np.complex64)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 124 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex equal values 124')
end
do -- equal 125
 local a=np.array({np.complex(1.0,-3.0),np.complex(4.0,0.5),np.complex(1.0,0.0),np.complex(4.0,0.5),np.complex(0.25,1.0),np.complex(0.0,0.0)},np.complex128)
 local b=np.array({np.complex(-1.0,1.0),np.complex(1.0,0.5),np.complex(1.0,0.5),np.complex(0.25,-3.0),np.complex(0.0,0.5),np.complex(0.25,3.0)},np.complex128)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 125 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex equal values 125')
end
do -- equal 126
 local a=np.array({np.complex(0.25,0.5),np.complex(-0.0,-1.0),np.complex(4.0,1.0),np.complex(1.0,0.0),np.complex(2.0,0.5),np.complex(2.0,0.0)},np.complex128)
 local b=np.array({-0.0,0.0,2.0,-1.0,2.0,-0.0},np.float16)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 126 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex equal values 126')
end
do -- equal 127
 local a=np.array({np.complex(-1.0,1.0),np.complex(0.0,-0.0),np.complex(4.0,3.0),np.complex(-3.0,-1.0),np.complex(-1.0,0.5),np.complex(2.0,-1.0)},np.complex128)
 local b=np.array({np.complex(2.0,-3.0),np.complex(0.25,1.0),np.complex(0.25,0.0),np.complex(-0.0,-1.0),np.complex(2.0,0.0),np.complex(0.25,1.0)},np.complex64)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 127 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex equal values 127')
end
do -- equal 128
 local a=np.array({np.complex(2.0,-0.0),np.complex(0.0,0.5),np.complex(1.0,0.0),np.complex(-0.0,-0.0),np.complex(4.0,-3.0),np.complex(2.0,0.0)},np.complex64)
 local b=np.array({np.complex(0.25,-0.0),np.complex(0.25,-0.0),np.complex(-0.0,-3.0),np.complex(1.0,0.5),np.complex(0.0,0.5),np.complex(-3.0,0.5)},np.complex64)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 128 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex equal values 128')
end
do -- equal 129
 local a=np.array({np.complex(4.0,-3.0),np.complex(1.0,3.0),np.complex(-2.0,-1.0),np.complex(0.25,0.5),np.complex(-0.0,-3.0),np.complex(-0.0,-1.0)},np.complex128)
 local b=np.array({2.0,-1.0,4.0,-1.0,-3.0,1.0},np.float16)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 129 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex equal values 129')
end
do -- equal 130
 local a=np.array({np.complex(4.0,0.5),np.complex(-2.0,1.0),np.complex(-3.0,-0.0),np.complex(0.0,3.0),np.complex(4.0,0.0),np.complex(-1.0,-0.0)},np.complex128)
 local b=np.array({np.complex(-0.0,3.0),np.complex(4.0,-3.0),np.complex(0.25,-1.0),np.complex(4.0,0.5),np.complex(-3.0,3.0),np.complex(-2.0,3.0)},np.complex128)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 130 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex equal values 130')
end
do -- equal 131
 local a=np.array({np.complex(1.0,3.0),np.complex(-1.0,0.5),np.complex(-0.0,-0.0),np.complex(2.0,-3.0),np.complex(-1.0,3.0),np.complex(4.0,0.0)},np.complex64)
 local b=np.array({np.complex(0.25,0.5),np.complex(1.0,-1.0),np.complex(-0.0,0.0),np.complex(1.0,3.0),np.complex(1.0,-0.0),np.complex(2.0,3.0)},np.complex64)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 131 '..r.dtype)
 assert(exact(r:tolist(),{false,false,true,false,false,false}),'complex equal values 131')
end
do -- equal 132
 local a=np.array({np.complex(-2.0,0.0),np.complex(-2.0,-0.0),np.complex(4.0,-3.0),np.complex(0.25,1.0),np.complex(-0.0,-3.0),np.complex(-1.0,0.5)},np.complex128)
 local b=np.array({-1.0,-0.0,0.5,1.0,-0.0,-0.0},np.float32)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 132 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex equal values 132')
end
do -- equal 133
 local a=np.array({np.complex(0.0,0.5),np.complex(2.0,1.0),np.complex(4.0,3.0),np.complex(2.0,3.0),np.complex(0.0,-0.0),np.complex(0.0,-1.0)},np.complex128)
 local b=np.array({np.complex(0.25,0.0),np.complex(1.0,0.5),np.complex(0.25,1.0),np.complex(4.0,-0.0),np.complex(-1.0,0.5),np.complex(-3.0,0.0)},np.complex64)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 133 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex equal values 133')
end
do -- equal 134
 local a=np.array({np.complex(-1.0,0.5),np.complex(-2.0,1.0),np.complex(-0.0,1.0),np.complex(4.0,0.0),np.complex(-2.0,-1.0),np.complex(0.25,-0.0)},np.complex64)
 local b=np.array({np.complex(0.0,-0.0),np.complex(-1.0,-0.0),np.complex(4.0,0.5),np.complex(-1.0,-3.0),np.complex(-0.0,0.5),np.complex(2.0,1.0)},np.complex128)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 134 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex equal values 134')
end
do -- equal 135
 local a=np.array({np.complex(0.25,3.0),np.complex(-2.0,0.5),np.complex(0.25,0.5),np.complex(-2.0,-0.0),np.complex(-1.0,-0.0),np.complex(-0.0,-3.0)},np.complex128)
 local b=np.array({-3.0,0.0,0.5,0.0,2.0,4.0},np.float16)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 135 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex equal values 135')
end
do -- equal 136
 local a=np.array({np.complex(-1.0,-1.0),np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(-3.0,3.0),np.complex(-0.0,-0.0),np.complex(0.25,0.0)},np.complex64)
 local b=np.array({0.5,1.0,4.0,0.0,0.0,-3.0},np.float64)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 136 '..r.dtype)
 assert(exact(r:tolist(),{false,true,false,false,true,false}),'complex equal values 136')
end
do -- equal 137
 local a=np.array({np.complex(4.0,3.0),np.complex(2.0,0.0),np.complex(0.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,0.0),np.complex(0.0,-3.0)},np.complex64)
 local b=np.array({1.0,-0.0,4.0,0.0,2.0,4.0},np.float32)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 137 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex equal values 137')
end
do -- equal 138
 local a=np.array({np.complex(0.25,0.5),np.complex(-0.0,1.0),np.complex(1.0,1.0),np.complex(-1.0,3.0),np.complex(-1.0,-1.0),np.complex(2.0,-1.0)},np.complex64)
 local b=np.array({np.complex(2.0,1.0),np.complex(2.0,0.0),np.complex(0.25,-3.0),np.complex(-2.0,-1.0),np.complex(0.25,-1.0),np.complex(0.25,-1.0)},np.complex64)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','complex equal dtype 138 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex equal values 138')
end
do -- not_equal 139
 local a=np.array({np.complex(-3.0,-0.0),np.complex(-1.0,0.5),np.complex(-2.0,0.5),np.complex(-2.0,0.0),np.complex(-3.0,0.0),np.complex(-2.0,3.0)},np.complex64)
 local b=np.array({-0.0,2.0,-3.0,0.0,-1.0,0.5},np.float16)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 139 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex not_equal values 139')
end
do -- not_equal 140
 local a=np.array({np.complex(-3.0,3.0),np.complex(-1.0,-1.0),np.complex(4.0,-0.0),np.complex(2.0,0.0),np.complex(2.0,-0.0),np.complex(4.0,-3.0)},np.complex128)
 local b=np.array({np.complex(-0.0,0.0),np.complex(4.0,1.0),np.complex(0.25,3.0),np.complex(-2.0,-3.0),np.complex(4.0,-1.0),np.complex(2.0,1.0)},np.complex128)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 140 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex not_equal values 140')
end
do -- not_equal 141
 local a=np.array({np.complex(1.0,3.0),np.complex(0.0,0.5),np.complex(0.0,3.0),np.complex(-0.0,-3.0),np.complex(1.0,0.5),np.complex(0.25,0.0)},np.complex128)
 local b=np.array({np.complex(-3.0,0.0),np.complex(4.0,1.0),np.complex(-0.0,3.0),np.complex(0.25,0.0),np.complex(-2.0,-3.0),np.complex(-2.0,-0.0)},np.complex64)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 141 '..r.dtype)
 assert(exact(r:tolist(),{true,true,false,true,true,true}),'complex not_equal values 141')
end
do -- not_equal 142
 local a=np.array({np.complex(0.0,-3.0),np.complex(2.0,-0.0),np.complex(2.0,3.0),np.complex(-0.0,3.0),np.complex(0.25,-3.0),np.complex(4.0,3.0)},np.complex128)
 local b=np.array({0.5,1.0,0.5,-1.0,1.0,-1.0},np.float64)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 142 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex not_equal values 142')
end
do -- not_equal 143
 local a=np.array({np.complex(4.0,-3.0),np.complex(0.25,3.0),np.complex(-3.0,-0.0),np.complex(2.0,0.5),np.complex(-3.0,0.5),np.complex(-1.0,-3.0)},np.complex128)
 local b=np.array({-0.0,0.5,4.0,2.0,-0.0,0.5},np.float16)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 143 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex not_equal values 143')
end
do -- not_equal 144
 local a=np.array({np.complex(-2.0,-0.0),np.complex(2.0,-0.0),np.complex(4.0,-1.0),np.complex(-2.0,1.0),np.complex(2.0,0.5),np.complex(-1.0,3.0)},np.complex128)
 local b=np.array({0.5,1.0,2.0,1.0,0.0,0.0},np.float64)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 144 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex not_equal values 144')
end
do -- not_equal 145
 local a=np.array({np.complex(2.0,0.5),np.complex(-2.0,0.5),np.complex(4.0,-1.0),np.complex(4.0,0.0),np.complex(-1.0,-1.0),np.complex(-3.0,1.0)},np.complex128)
 local b=np.array({np.complex(-0.0,1.0),np.complex(4.0,3.0),np.complex(0.0,-0.0),np.complex(1.0,0.0),np.complex(-2.0,1.0),np.complex(4.0,-0.0)},np.complex64)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 145 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex not_equal values 145')
end
do -- not_equal 146
 local a=np.array({np.complex(0.0,-0.0),np.complex(4.0,0.5),np.complex(-1.0,-3.0),np.complex(4.0,3.0),np.complex(-2.0,0.5),np.complex(-0.0,1.0)},np.complex128)
 local b=np.array({-0.0,2.0,4.0,2.0,0.0,-3.0},np.float32)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 146 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,true,true,true}),'complex not_equal values 146')
end
do -- not_equal 147
 local a=np.array({np.complex(-1.0,0.0),np.complex(-2.0,3.0),np.complex(-0.0,-3.0),np.complex(-3.0,3.0),np.complex(4.0,-0.0),np.complex(1.0,3.0)},np.complex128)
 local b=np.array({4.0,-3.0,-1.0,2.0,0.5,1.0},np.float32)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 147 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex not_equal values 147')
end
do -- not_equal 148
 local a=np.array({np.complex(4.0,-1.0),np.complex(-2.0,-1.0),np.complex(1.0,0.0),np.complex(-3.0,-0.0),np.complex(0.25,-0.0),np.complex(0.0,3.0)},np.complex64)
 local b=np.array({2.0,-1.0,0.0,-3.0,0.0,-0.0},np.float64)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 148 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,false,true,true}),'complex not_equal values 148')
end
do -- not_equal 149
 local a=np.array({np.complex(0.25,3.0),np.complex(1.0,-0.0),np.complex(-0.0,-0.0),np.complex(-1.0,0.5),np.complex(-2.0,-1.0),np.complex(-0.0,-1.0)},np.complex64)
 local b=np.array({4.0,-3.0,-3.0,-1.0,-3.0,-1.0},np.float16)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 149 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex not_equal values 149')
end
do -- not_equal 150
 local a=np.array({np.complex(4.0,0.5),np.complex(-1.0,0.5),np.complex(-1.0,1.0),np.complex(1.0,0.0),np.complex(0.0,0.0),np.complex(0.0,3.0)},np.complex64)
 local b=np.array({np.complex(0.25,-3.0),np.complex(-1.0,-3.0),np.complex(-3.0,-3.0),np.complex(2.0,-1.0),np.complex(-2.0,3.0),np.complex(0.25,0.5)},np.complex128)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 150 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex not_equal values 150')
end
do -- not_equal 151
 local a=np.array({np.complex(-1.0,0.5),np.complex(-0.0,3.0),np.complex(2.0,-0.0),np.complex(4.0,0.5),np.complex(0.0,-3.0),np.complex(-0.0,1.0)},np.complex64)
 local b=np.array({np.complex(0.25,1.0),np.complex(1.0,-0.0),np.complex(2.0,-0.0),np.complex(-2.0,0.0),np.complex(0.0,0.5),np.complex(-3.0,-0.0)},np.complex128)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 151 '..r.dtype)
 assert(exact(r:tolist(),{true,true,false,true,true,true}),'complex not_equal values 151')
end
do -- not_equal 152
 local a=np.array({np.complex(0.0,0.5),np.complex(-3.0,3.0),np.complex(-2.0,-0.0),np.complex(1.0,3.0),np.complex(-2.0,0.0),np.complex(0.25,0.5)},np.complex128)
 local b=np.array({np.complex(1.0,-0.0),np.complex(0.0,-1.0),np.complex(1.0,0.5),np.complex(2.0,1.0),np.complex(-0.0,-1.0),np.complex(1.0,-0.0)},np.complex128)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 152 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex not_equal values 152')
end
do -- not_equal 153
 local a=np.array({np.complex(-1.0,-0.0),np.complex(2.0,-3.0),np.complex(-3.0,-1.0),np.complex(4.0,0.0),np.complex(1.0,-3.0),np.complex(0.0,-1.0)},np.complex128)
 local b=np.array({-0.0,0.0,0.0,4.0,1.0,2.0},np.float16)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 153 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,false,true,true}),'complex not_equal values 153')
end
do -- not_equal 154
 local a=np.array({np.complex(-0.0,3.0),np.complex(-1.0,-1.0),np.complex(0.0,0.0),np.complex(4.0,1.0),np.complex(0.25,1.0),np.complex(-1.0,0.0)},np.complex64)
 local b=np.array({1.0,-1.0,0.5,4.0,-1.0,0.0},np.float64)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 154 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex not_equal values 154')
end
do -- not_equal 155
 local a=np.array({np.complex(-0.0,-3.0),np.complex(1.0,1.0),np.complex(-0.0,1.0),np.complex(-2.0,-1.0),np.complex(-2.0,3.0),np.complex(-0.0,3.0)},np.complex128)
 local b=np.array({np.complex(0.0,0.5),np.complex(-0.0,-1.0),np.complex(2.0,3.0),np.complex(-1.0,3.0),np.complex(1.0,-3.0),np.complex(-2.0,-3.0)},np.complex128)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 155 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex not_equal values 155')
end
do -- not_equal 156
 local a=np.array({np.complex(2.0,1.0),np.complex(-3.0,0.0),np.complex(-0.0,0.0),np.complex(4.0,1.0),np.complex(4.0,3.0),np.complex(-3.0,-3.0)},np.complex128)
 local b=np.array({np.complex(-1.0,0.5),np.complex(0.0,1.0),np.complex(4.0,1.0),np.complex(-0.0,0.5),np.complex(0.25,0.5),np.complex(0.25,-1.0)},np.complex128)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 156 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex not_equal values 156')
end
do -- not_equal 157
 local a=np.array({np.complex(-0.0,-1.0),np.complex(0.25,3.0),np.complex(-2.0,0.5),np.complex(-0.0,3.0),np.complex(2.0,3.0),np.complex(4.0,-3.0)},np.complex128)
 local b=np.array({-3.0,-3.0,-1.0,0.0,2.0,-3.0},np.float32)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 157 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex not_equal values 157')
end
do -- not_equal 158
 local a=np.array({np.complex(-3.0,-1.0),np.complex(1.0,1.0),np.complex(-3.0,0.0),np.complex(-2.0,0.0),np.complex(0.25,0.5),np.complex(4.0,0.5)},np.complex64)
 local b=np.array({np.complex(0.25,0.5),np.complex(-2.0,-1.0),np.complex(4.0,-3.0),np.complex(-3.0,-1.0),np.complex(-1.0,1.0),np.complex(-2.0,-3.0)},np.complex128)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 158 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex not_equal values 158')
end
do -- not_equal 159
 local a=np.array({np.complex(1.0,1.0),np.complex(4.0,-0.0),np.complex(-2.0,-3.0),np.complex(-3.0,1.0),np.complex(-0.0,3.0),np.complex(-0.0,-0.0)},np.complex128)
 local b=np.array({np.complex(2.0,0.5),np.complex(0.25,-1.0),np.complex(-0.0,1.0),np.complex(0.0,-0.0),np.complex(0.25,-1.0),np.complex(-0.0,0.5)},np.complex128)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 159 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex not_equal values 159')
end
do -- not_equal 160
 local a=np.array({np.complex(-1.0,1.0),np.complex(0.0,-0.0),np.complex(2.0,0.0),np.complex(0.0,-0.0),np.complex(-2.0,0.0),np.complex(0.0,-1.0)},np.complex64)
 local b=np.array({-1.0,0.0,-1.0,1.0,0.5,-0.0},np.float16)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 160 '..r.dtype)
 assert(exact(r:tolist(),{true,false,true,true,true,true}),'complex not_equal values 160')
end
do -- not_equal 161
 local a=np.array({np.complex(-0.0,-3.0),np.complex(-0.0,0.0),np.complex(0.0,0.5),np.complex(-1.0,0.5),np.complex(4.0,3.0),np.complex(2.0,0.5)},np.complex128)
 local b=np.array({1.0,1.0,0.5,0.5,-3.0,-3.0},np.float32)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 161 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex not_equal values 161')
end
do -- not_equal 162
 local a=np.array({np.complex(-0.0,0.0),np.complex(-0.0,-1.0),np.complex(0.25,-3.0),np.complex(1.0,3.0),np.complex(-2.0,3.0),np.complex(-0.0,1.0)},np.complex128)
 local b=np.array({np.complex(0.25,-1.0),np.complex(-1.0,-1.0),np.complex(2.0,0.5),np.complex(1.0,0.0),np.complex(-3.0,0.0),np.complex(-1.0,-0.0)},np.complex64)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','complex not_equal dtype 162 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex not_equal values 162')
end
do -- less 163
 local a=np.array({np.complex(-3.0,-1.0),np.complex(2.0,0.5),np.complex(0.25,-1.0),np.complex(-1.0,-0.0),np.complex(-2.0,3.0),np.complex(-0.0,-3.0)},np.complex128)
 local b=np.array({np.complex(-2.0,0.5),np.complex(-2.0,-1.0),np.complex(1.0,0.5),np.complex(-3.0,1.0),np.complex(-3.0,0.0),np.complex(-1.0,-3.0)},np.complex128)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 163 '..r.dtype)
 assert(exact(r:tolist(),{true,false,true,false,false,false}),'complex less values 163')
end
do -- less 164
 local a=np.array({np.complex(-0.0,-3.0),np.complex(0.0,0.5),np.complex(0.0,0.5),np.complex(-2.0,0.5),np.complex(-3.0,3.0),np.complex(0.25,3.0)},np.complex64)
 local b=np.array({4.0,-0.0,4.0,4.0,0.5,-1.0},np.float32)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 164 '..r.dtype)
 assert(exact(r:tolist(),{true,false,true,true,true,false}),'complex less values 164')
end
do -- less 165
 local a=np.array({np.complex(-0.0,0.5),np.complex(1.0,0.5),np.complex(4.0,3.0),np.complex(-1.0,1.0),np.complex(-0.0,3.0),np.complex(-0.0,1.0)},np.complex128)
 local b=np.array({np.complex(0.0,0.5),np.complex(-3.0,-3.0),np.complex(2.0,0.0),np.complex(-2.0,-0.0),np.complex(0.25,-0.0),np.complex(-2.0,0.5)},np.complex64)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 165 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,true,false}),'complex less values 165')
end
do -- less 166
 local a=np.array({np.complex(1.0,0.5),np.complex(0.0,-0.0),np.complex(0.0,1.0),np.complex(0.0,0.5),np.complex(1.0,1.0),np.complex(2.0,1.0)},np.complex64)
 local b=np.array({-3.0,4.0,0.0,-3.0,-0.0,-1.0},np.float32)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 166 '..r.dtype)
 assert(exact(r:tolist(),{false,true,false,false,false,false}),'complex less values 166')
end
do -- less 167
 local a=np.array({np.complex(-0.0,1.0),np.complex(2.0,0.5),np.complex(2.0,0.0),np.complex(0.25,-1.0),np.complex(-0.0,-1.0),np.complex(-0.0,1.0)},np.complex64)
 local b=np.array({np.complex(0.25,-1.0),np.complex(-0.0,3.0),np.complex(-0.0,3.0),np.complex(0.25,-1.0),np.complex(-1.0,-1.0),np.complex(-0.0,-0.0)},np.complex64)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 167 '..r.dtype)
 assert(exact(r:tolist(),{true,false,false,false,false,false}),'complex less values 167')
end
do -- less 168
 local a=np.array({np.complex(2.0,-0.0),np.complex(4.0,-3.0),np.complex(0.0,0.0),np.complex(-3.0,-3.0),np.complex(-1.0,0.0),np.complex(4.0,0.0)},np.complex128)
 local b=np.array({1.0,-1.0,-1.0,-1.0,4.0,1.0},np.float64)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 168 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,true,true,false}),'complex less values 168')
end
do -- less 169
 local a=np.array({np.complex(0.0,-3.0),np.complex(-0.0,-3.0),np.complex(4.0,1.0),np.complex(-2.0,-1.0),np.complex(-2.0,-3.0),np.complex(-2.0,1.0)},np.complex128)
 local b=np.array({-1.0,0.0,-0.0,-3.0,-0.0,-0.0},np.float64)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 169 '..r.dtype)
 assert(exact(r:tolist(),{false,true,false,false,true,true}),'complex less values 169')
end
do -- less 170
 local a=np.array({np.complex(-0.0,-3.0),np.complex(-1.0,1.0),np.complex(-1.0,0.5),np.complex(-3.0,3.0),np.complex(-3.0,-3.0),np.complex(0.0,-1.0)},np.complex64)
 local b=np.array({np.complex(1.0,0.5),np.complex(2.0,-3.0),np.complex(-1.0,-0.0),np.complex(0.25,-3.0),np.complex(1.0,-0.0),np.complex(-3.0,-3.0)},np.complex128)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 170 '..r.dtype)
 assert(exact(r:tolist(),{true,true,false,true,true,false}),'complex less values 170')
end
do -- less 171
 local a=np.array({np.complex(-0.0,-3.0),np.complex(2.0,1.0),np.complex(4.0,-1.0),np.complex(-0.0,3.0),np.complex(2.0,-3.0),np.complex(-3.0,3.0)},np.complex128)
 local b=np.array({np.complex(1.0,3.0),np.complex(1.0,-0.0),np.complex(0.0,0.5),np.complex(-1.0,-0.0),np.complex(-3.0,0.0),np.complex(4.0,3.0)},np.complex128)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 171 '..r.dtype)
 assert(exact(r:tolist(),{true,false,false,false,false,true}),'complex less values 171')
end
do -- less 172
 local a=np.array({np.complex(-2.0,-3.0),np.complex(0.25,0.0),np.complex(-3.0,-1.0),np.complex(-1.0,0.0),np.complex(0.25,0.0),np.complex(-1.0,1.0)},np.complex128)
 local b=np.array({1.0,0.5,-1.0,0.5,-0.0,4.0},np.float16)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 172 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,false,true}),'complex less values 172')
end
do -- less 173
 local a=np.array({np.complex(4.0,3.0),np.complex(0.25,3.0),np.complex(-2.0,-0.0),np.complex(0.0,1.0),np.complex(0.25,-3.0),np.complex(-1.0,-0.0)},np.complex128)
 local b=np.array({-0.0,-0.0,0.0,2.0,-3.0,-0.0},np.float32)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 173 '..r.dtype)
 assert(exact(r:tolist(),{false,false,true,true,false,true}),'complex less values 173')
end
do -- less 174
 local a=np.array({np.complex(-0.0,-3.0),np.complex(0.0,-3.0),np.complex(-0.0,3.0),np.complex(0.25,3.0),np.complex(0.25,0.0),np.complex(4.0,-3.0)},np.complex64)
 local b=np.array({0.0,1.0,1.0,4.0,2.0,-1.0},np.float64)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 174 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,false}),'complex less values 174')
end
do -- less 175
 local a=np.array({np.complex(-2.0,-1.0),np.complex(0.25,0.0),np.complex(-1.0,0.0),np.complex(-1.0,-1.0),np.complex(-0.0,0.5),np.complex(0.25,1.0)},np.complex64)
 local b=np.array({np.complex(-1.0,1.0),np.complex(-0.0,1.0),np.complex(4.0,0.0),np.complex(2.0,1.0),np.complex(-1.0,-3.0),np.complex(1.0,-1.0)},np.complex64)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 175 '..r.dtype)
 assert(exact(r:tolist(),{true,false,true,true,false,true}),'complex less values 175')
end
do -- less 176
 local a=np.array({np.complex(4.0,-1.0),np.complex(-3.0,1.0),np.complex(-1.0,1.0),np.complex(-2.0,0.5),np.complex(-0.0,-1.0),np.complex(-1.0,-1.0)},np.complex128)
 local b=np.array({0.5,-1.0,-1.0,4.0,4.0,2.0},np.float64)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 176 '..r.dtype)
 assert(exact(r:tolist(),{false,true,false,true,true,true}),'complex less values 176')
end
do -- less 177
 local a=np.array({np.complex(-1.0,-0.0),np.complex(-3.0,0.0),np.complex(2.0,-0.0),np.complex(-2.0,-3.0),np.complex(2.0,3.0),np.complex(2.0,-3.0)},np.complex64)
 local b=np.array({np.complex(1.0,3.0),np.complex(0.25,0.0),np.complex(4.0,0.0),np.complex(-0.0,-1.0),np.complex(1.0,0.0),np.complex(0.0,-3.0)},np.complex128)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 177 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,false,false}),'complex less values 177')
end
do -- less 178
 local a=np.array({np.complex(-0.0,0.0),np.complex(-2.0,-0.0),np.complex(-0.0,3.0),np.complex(4.0,-3.0),np.complex(0.25,-3.0),np.complex(0.25,-3.0)},np.complex128)
 local b=np.array({np.complex(2.0,-0.0),np.complex(-2.0,-3.0),np.complex(4.0,-0.0),np.complex(-3.0,3.0),np.complex(4.0,0.5),np.complex(0.25,1.0)},np.complex64)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 178 '..r.dtype)
 assert(exact(r:tolist(),{true,false,true,false,true,true}),'complex less values 178')
end
do -- less 179
 local a=np.array({np.complex(1.0,0.5),np.complex(-2.0,0.0),np.complex(-1.0,0.5),np.complex(0.0,0.0),np.complex(0.25,0.5),np.complex(0.0,-1.0)},np.complex128)
 local b=np.array({-3.0,-0.0,2.0,0.0,-3.0,-3.0},np.float64)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 179 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,false,false,false}),'complex less values 179')
end
do -- less 180
 local a=np.array({np.complex(0.0,-1.0),np.complex(0.0,1.0),np.complex(2.0,-1.0),np.complex(2.0,3.0),np.complex(-1.0,0.5),np.complex(4.0,-0.0)},np.complex64)
 local b=np.array({np.complex(-3.0,-1.0),np.complex(0.0,-1.0),np.complex(-3.0,0.0),np.complex(-1.0,1.0),np.complex(1.0,1.0),np.complex(-2.0,-1.0)},np.complex64)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 180 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,true,false}),'complex less values 180')
end
do -- less 181
 local a=np.array({np.complex(0.25,1.0),np.complex(-0.0,-3.0),np.complex(0.0,-1.0),np.complex(0.25,-0.0),np.complex(2.0,-3.0),np.complex(1.0,-0.0)},np.complex64)
 local b=np.array({2.0,-1.0,-1.0,1.0,-0.0,4.0},np.float16)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 181 '..r.dtype)
 assert(exact(r:tolist(),{true,false,false,true,false,true}),'complex less values 181')
end
do -- less 182
 local a=np.array({np.complex(-2.0,-1.0),np.complex(0.25,1.0),np.complex(4.0,3.0),np.complex(-1.0,0.0),np.complex(-3.0,3.0),np.complex(-1.0,-3.0)},np.complex128)
 local b=np.array({0.5,0.0,-3.0,-3.0,-0.0,0.0},np.float64)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 182 '..r.dtype)
 assert(exact(r:tolist(),{true,false,false,false,true,true}),'complex less values 182')
end
do -- less 183
 local a=np.array({np.complex(-1.0,-3.0),np.complex(0.25,0.5),np.complex(0.0,1.0),np.complex(0.0,-1.0),np.complex(-1.0,0.5),np.complex(-0.0,1.0)},np.complex64)
 local b=np.array({-0.0,1.0,-3.0,-3.0,4.0,-1.0},np.float64)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 183 '..r.dtype)
 assert(exact(r:tolist(),{true,true,false,false,true,false}),'complex less values 183')
end
do -- less 184
 local a=np.array({np.complex(-3.0,3.0),np.complex(0.25,-1.0),np.complex(0.0,1.0),np.complex(-1.0,-0.0),np.complex(0.0,-0.0),np.complex(1.0,3.0)},np.complex128)
 local b=np.array({4.0,-3.0,0.0,0.0,-3.0,-1.0},np.float16)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 184 '..r.dtype)
 assert(exact(r:tolist(),{true,false,false,true,false,false}),'complex less values 184')
end
do -- less 185
 local a=np.array({np.complex(-1.0,1.0),np.complex(-0.0,3.0),np.complex(4.0,0.5),np.complex(0.0,1.0),np.complex(-3.0,0.5),np.complex(0.25,0.5)},np.complex128)
 local b=np.array({1.0,4.0,-0.0,-0.0,-1.0,2.0},np.float64)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 185 '..r.dtype)
 assert(exact(r:tolist(),{true,true,false,false,true,true}),'complex less values 185')
end
do -- less 186
 local a=np.array({np.complex(0.25,0.5),np.complex(0.0,1.0),np.complex(2.0,-1.0),np.complex(0.25,1.0),np.complex(-3.0,-3.0),np.complex(-0.0,0.0)},np.complex64)
 local b=np.array({np.complex(4.0,1.0),np.complex(2.0,-3.0),np.complex(-2.0,-1.0),np.complex(4.0,0.0),np.complex(0.25,1.0),np.complex(-0.0,3.0)},np.complex128)
 local r=np.less(a,b)
 assert(r.dtype=='bool','complex less dtype 186 '..r.dtype)
 assert(exact(r:tolist(),{true,true,false,true,true,true}),'complex less values 186')
end
do -- less_equal 187
 local a=np.array({np.complex(1.0,-1.0),np.complex(2.0,0.5),np.complex(0.25,-0.0),np.complex(4.0,1.0),np.complex(-2.0,1.0),np.complex(0.0,-0.0)},np.complex128)
 local b=np.array({0.0,-3.0,1.0,0.5,-1.0,-0.0},np.float32)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 187 '..r.dtype)
 assert(exact(r:tolist(),{false,false,true,false,true,true}),'complex less_equal values 187')
end
do -- less_equal 188
 local a=np.array({np.complex(-0.0,3.0),np.complex(-2.0,-0.0),np.complex(0.0,-1.0),np.complex(-3.0,1.0),np.complex(-1.0,3.0),np.complex(1.0,3.0)},np.complex64)
 local b=np.array({np.complex(-3.0,-1.0),np.complex(-1.0,1.0),np.complex(-2.0,1.0),np.complex(1.0,-1.0),np.complex(0.25,1.0),np.complex(2.0,0.0)},np.complex64)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 188 '..r.dtype)
 assert(exact(r:tolist(),{false,true,false,true,true,true}),'complex less_equal values 188')
end
do -- less_equal 189
 local a=np.array({np.complex(1.0,-0.0),np.complex(-0.0,1.0),np.complex(-0.0,-0.0),np.complex(-2.0,-3.0),np.complex(1.0,-1.0),np.complex(-3.0,1.0)},np.complex128)
 local b=np.array({0.0,4.0,0.5,-1.0,-0.0,0.0},np.float16)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 189 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,true,false,true}),'complex less_equal values 189')
end
do -- less_equal 190
 local a=np.array({np.complex(0.25,1.0),np.complex(0.0,-1.0),np.complex(-2.0,0.0),np.complex(4.0,3.0),np.complex(4.0,-0.0),np.complex(0.0,0.5)},np.complex128)
 local b=np.array({np.complex(-0.0,-0.0),np.complex(-0.0,-0.0),np.complex(4.0,-0.0),np.complex(0.0,-1.0),np.complex(-3.0,1.0),np.complex(-1.0,0.5)},np.complex64)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 190 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,false,false,false}),'complex less_equal values 190')
end
do -- less_equal 191
 local a=np.array({np.complex(-0.0,-3.0),np.complex(1.0,-1.0),np.complex(-2.0,0.0),np.complex(-0.0,3.0),np.complex(-1.0,-3.0),np.complex(-1.0,-0.0)},np.complex128)
 local b=np.array({np.complex(-3.0,-1.0),np.complex(2.0,1.0),np.complex(0.0,-3.0),np.complex(-3.0,3.0),np.complex(-2.0,3.0),np.complex(-2.0,0.0)},np.complex64)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 191 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,false,false,false}),'complex less_equal values 191')
end
do -- less_equal 192
 local a=np.array({np.complex(-1.0,0.0),np.complex(-2.0,0.5),np.complex(2.0,0.0),np.complex(-1.0,-3.0),np.complex(0.0,3.0),np.complex(0.0,-3.0)},np.complex128)
 local b=np.array({-3.0,-0.0,0.0,-3.0,0.0,-3.0},np.float64)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 192 '..r.dtype)
 assert(exact(r:tolist(),{false,true,false,false,false,false}),'complex less_equal values 192')
end
do -- less_equal 193
 local a=np.array({np.complex(1.0,-0.0),np.complex(0.25,3.0),np.complex(-0.0,0.0),np.complex(1.0,-3.0),np.complex(1.0,0.0),np.complex(0.25,1.0)},np.complex64)
 local b=np.array({np.complex(-2.0,-3.0),np.complex(0.0,0.5),np.complex(-0.0,1.0),np.complex(-0.0,-0.0),np.complex(-2.0,0.0),np.complex(-3.0,-1.0)},np.complex64)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 193 '..r.dtype)
 assert(exact(r:tolist(),{false,false,true,false,false,false}),'complex less_equal values 193')
end
do -- less_equal 194
 local a=np.array({np.complex(4.0,-1.0),np.complex(0.25,1.0),np.complex(-2.0,-1.0),np.complex(-0.0,-1.0),np.complex(1.0,3.0),np.complex(-0.0,1.0)},np.complex64)
 local b=np.array({np.complex(-0.0,-3.0),np.complex(2.0,-3.0),np.complex(-1.0,3.0),np.complex(-0.0,-3.0),np.complex(-1.0,3.0),np.complex(1.0,-3.0)},np.complex64)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 194 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,false,false,true}),'complex less_equal values 194')
end
do -- less_equal 195
 local a=np.array({np.complex(0.25,3.0),np.complex(4.0,0.0),np.complex(-2.0,1.0),np.complex(1.0,0.5),np.complex(0.0,0.5),np.complex(4.0,1.0)},np.complex64)
 local b=np.array({4.0,0.0,0.0,-3.0,2.0,-1.0},np.float16)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 195 '..r.dtype)
 assert(exact(r:tolist(),{true,false,true,false,true,false}),'complex less_equal values 195')
end
do -- less_equal 196
 local a=np.array({np.complex(-1.0,-1.0),np.complex(2.0,-1.0),np.complex(0.0,3.0),np.complex(0.0,1.0),np.complex(0.0,3.0),np.complex(0.25,0.5)},np.complex64)
 local b=np.array({np.complex(0.25,3.0),np.complex(-3.0,-3.0),np.complex(4.0,0.5),np.complex(-2.0,3.0),np.complex(-0.0,1.0),np.complex(0.0,-1.0)},np.complex128)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 196 '..r.dtype)
 assert(exact(r:tolist(),{true,false,true,false,false,false}),'complex less_equal values 196')
end
do -- less_equal 197
 local a=np.array({np.complex(0.25,-1.0),np.complex(-0.0,1.0),np.complex(0.0,-0.0),np.complex(-1.0,3.0),np.complex(-0.0,3.0),np.complex(0.0,-3.0)},np.complex128)
 local b=np.array({-0.0,-3.0,-0.0,4.0,0.5,0.0},np.float64)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 197 '..r.dtype)
 assert(exact(r:tolist(),{false,false,true,true,true,true}),'complex less_equal values 197')
end
do -- less_equal 198
 local a=np.array({np.complex(0.25,-1.0),np.complex(1.0,-1.0),np.complex(-3.0,-1.0),np.complex(1.0,0.0),np.complex(-1.0,-3.0),np.complex(0.25,-1.0)},np.complex128)
 local b=np.array({-3.0,-1.0,-0.0,-1.0,2.0,2.0},np.float32)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 198 '..r.dtype)
 assert(exact(r:tolist(),{false,false,true,false,true,true}),'complex less_equal values 198')
end
do -- less_equal 199
 local a=np.array({np.complex(2.0,3.0),np.complex(2.0,0.5),np.complex(-3.0,-3.0),np.complex(0.0,0.0),np.complex(-3.0,-1.0),np.complex(0.0,-1.0)},np.complex64)
 local b=np.array({-0.0,-0.0,0.5,4.0,1.0,0.0},np.float32)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 199 '..r.dtype)
 assert(exact(r:tolist(),{false,false,true,true,true,true}),'complex less_equal values 199')
end
do -- less_equal 200
 local a=np.array({np.complex(0.0,0.5),np.complex(4.0,0.5),np.complex(-3.0,1.0),np.complex(-1.0,1.0),np.complex(2.0,0.5),np.complex(0.0,1.0)},np.complex64)
 local b=np.array({np.complex(0.25,1.0),np.complex(0.0,-1.0),np.complex(0.25,-0.0),np.complex(1.0,-1.0),np.complex(-0.0,0.0),np.complex(-3.0,-0.0)},np.complex128)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 200 '..r.dtype)
 assert(exact(r:tolist(),{true,false,true,true,false,false}),'complex less_equal values 200')
end
do -- less_equal 201
 local a=np.array({np.complex(-0.0,-1.0),np.complex(0.25,3.0),np.complex(-0.0,1.0),np.complex(4.0,0.0),np.complex(0.0,-1.0),np.complex(-1.0,1.0)},np.complex128)
 local b=np.array({np.complex(-3.0,1.0),np.complex(-2.0,0.5),np.complex(-2.0,3.0),np.complex(4.0,0.5),np.complex(0.0,-3.0),np.complex(-2.0,-0.0)},np.complex64)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 201 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,true,false,false}),'complex less_equal values 201')
end
do -- less_equal 202
 local a=np.array({np.complex(-3.0,-0.0),np.complex(-3.0,0.5),np.complex(-3.0,1.0),np.complex(4.0,0.5),np.complex(0.0,0.5),np.complex(0.25,-3.0)},np.complex64)
 local b=np.array({-1.0,1.0,1.0,-1.0,-0.0,0.5},np.float64)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 202 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,false,false,true}),'complex less_equal values 202')
end
do -- less_equal 203
 local a=np.array({np.complex(1.0,1.0),np.complex(-1.0,-3.0),np.complex(-1.0,-0.0),np.complex(-0.0,0.5),np.complex(-1.0,3.0),np.complex(0.25,-0.0)},np.complex64)
 local b=np.array({-1.0,2.0,4.0,-3.0,1.0,0.5},np.float32)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 203 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,false,true,true}),'complex less_equal values 203')
end
do -- less_equal 204
 local a=np.array({np.complex(-2.0,0.5),np.complex(1.0,-0.0),np.complex(4.0,0.0),np.complex(0.25,1.0),np.complex(-3.0,-3.0),np.complex(-0.0,3.0)},np.complex64)
 local b=np.array({0.0,-3.0,-3.0,4.0,-3.0,-3.0},np.float64)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 204 '..r.dtype)
 assert(exact(r:tolist(),{true,false,false,true,true,false}),'complex less_equal values 204')
end
do -- less_equal 205
 local a=np.array({np.complex(4.0,0.0),np.complex(-3.0,1.0),np.complex(-3.0,3.0),np.complex(-1.0,0.0),np.complex(-1.0,-0.0),np.complex(-2.0,0.0)},np.complex128)
 local b=np.array({np.complex(0.0,3.0),np.complex(0.25,1.0),np.complex(4.0,1.0),np.complex(1.0,1.0),np.complex(2.0,3.0),np.complex(1.0,3.0)},np.complex64)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 205 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,true,true,true}),'complex less_equal values 205')
end
do -- less_equal 206
 local a=np.array({np.complex(-1.0,1.0),np.complex(-1.0,3.0),np.complex(4.0,0.5),np.complex(2.0,1.0),np.complex(-2.0,3.0),np.complex(-2.0,-1.0)},np.complex64)
 local b=np.array({4.0,4.0,-1.0,0.5,0.0,2.0},np.float64)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 206 '..r.dtype)
 assert(exact(r:tolist(),{true,true,false,false,true,true}),'complex less_equal values 206')
end
do -- less_equal 207
 local a=np.array({np.complex(-2.0,0.5),np.complex(-1.0,-0.0),np.complex(0.25,1.0),np.complex(2.0,0.0),np.complex(4.0,3.0),np.complex(0.25,-3.0)},np.complex64)
 local b=np.array({0.0,2.0,4.0,2.0,-3.0,2.0},np.float64)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 207 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,false,true}),'complex less_equal values 207')
end
do -- less_equal 208
 local a=np.array({np.complex(0.25,0.0),np.complex(-2.0,-3.0),np.complex(-3.0,0.0),np.complex(-1.0,0.5),np.complex(2.0,0.5),np.complex(-3.0,1.0)},np.complex128)
 local b=np.array({-1.0,2.0,0.5,-1.0,1.0,-1.0},np.float64)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 208 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,false,false,true}),'complex less_equal values 208')
end
do -- less_equal 209
 local a=np.array({np.complex(-0.0,0.0),np.complex(-1.0,0.0),np.complex(-2.0,-3.0),np.complex(0.0,-3.0),np.complex(-3.0,1.0),np.complex(0.0,3.0)},np.complex128)
 local b=np.array({np.complex(1.0,-3.0),np.complex(4.0,-0.0),np.complex(1.0,-0.0),np.complex(-0.0,0.0),np.complex(-2.0,-3.0),np.complex(-0.0,-1.0)},np.complex128)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 209 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,false}),'complex less_equal values 209')
end
do -- less_equal 210
 local a=np.array({np.complex(-1.0,0.5),np.complex(2.0,0.5),np.complex(-1.0,0.5),np.complex(4.0,3.0),np.complex(0.0,-0.0),np.complex(-2.0,3.0)},np.complex64)
 local b=np.array({-1.0,0.5,-0.0,1.0,2.0,-1.0},np.float16)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','complex less_equal dtype 210 '..r.dtype)
 assert(exact(r:tolist(),{false,false,true,false,true,true}),'complex less_equal values 210')
end
do -- greater 211
 local a=np.array({np.complex(-1.0,0.0),np.complex(0.0,3.0),np.complex(4.0,3.0),np.complex(-3.0,3.0),np.complex(1.0,-3.0),np.complex(-3.0,0.0)},np.complex64)
 local b=np.array({np.complex(-1.0,0.0),np.complex(1.0,3.0),np.complex(-0.0,-0.0),np.complex(-2.0,0.5),np.complex(0.25,0.0),np.complex(2.0,1.0)},np.complex64)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 211 '..r.dtype)
 assert(exact(r:tolist(),{false,false,true,false,true,false}),'complex greater values 211')
end
do -- greater 212
 local a=np.array({np.complex(-0.0,-1.0),np.complex(-1.0,3.0),np.complex(0.25,0.5),np.complex(-2.0,0.0),np.complex(4.0,-1.0),np.complex(-0.0,3.0)},np.complex128)
 local b=np.array({0.5,-1.0,-0.0,-1.0,4.0,-3.0},np.float16)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 212 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,false,false,true}),'complex greater values 212')
end
do -- greater 213
 local a=np.array({np.complex(2.0,-1.0),np.complex(2.0,-0.0),np.complex(-0.0,0.5),np.complex(-0.0,-1.0),np.complex(1.0,0.5),np.complex(0.25,-3.0)},np.complex64)
 local b=np.array({-3.0,4.0,2.0,-0.0,1.0,1.0},np.float16)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 213 '..r.dtype)
 assert(exact(r:tolist(),{true,false,false,false,true,false}),'complex greater values 213')
end
do -- greater 214
 local a=np.array({np.complex(-0.0,1.0),np.complex(0.0,0.5),np.complex(-0.0,-3.0),np.complex(-0.0,-1.0),np.complex(1.0,-3.0),np.complex(-0.0,-0.0)},np.complex64)
 local b=np.array({4.0,4.0,-0.0,4.0,4.0,-3.0},np.float32)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 214 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,true}),'complex greater values 214')
end
do -- greater 215
 local a=np.array({np.complex(-3.0,0.5),np.complex(0.25,1.0),np.complex(0.25,1.0),np.complex(-2.0,-3.0),np.complex(1.0,0.0),np.complex(-2.0,3.0)},np.complex64)
 local b=np.array({0.0,4.0,-0.0,4.0,2.0,2.0},np.float64)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 215 '..r.dtype)
 assert(exact(r:tolist(),{false,false,true,false,false,false}),'complex greater values 215')
end
do -- greater 216
 local a=np.array({np.complex(-2.0,0.5),np.complex(4.0,-1.0),np.complex(-0.0,-1.0),np.complex(2.0,0.5),np.complex(-3.0,3.0),np.complex(-1.0,0.5)},np.complex64)
 local b=np.array({2.0,-1.0,-3.0,-3.0,0.0,0.0},np.float16)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 216 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,true,false,false}),'complex greater values 216')
end
do -- greater 217
 local a=np.array({np.complex(4.0,-0.0),np.complex(-3.0,-3.0),np.complex(4.0,3.0),np.complex(-2.0,-1.0),np.complex(0.0,-3.0),np.complex(0.25,0.5)},np.complex128)
 local b=np.array({np.complex(1.0,3.0),np.complex(-1.0,3.0),np.complex(4.0,-0.0),np.complex(0.25,0.5),np.complex(0.25,-0.0),np.complex(-2.0,1.0)},np.complex64)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 217 '..r.dtype)
 assert(exact(r:tolist(),{true,false,true,false,false,true}),'complex greater values 217')
end
do -- greater 218
 local a=np.array({np.complex(-2.0,0.5),np.complex(-2.0,-3.0),np.complex(2.0,3.0),np.complex(0.25,1.0),np.complex(-3.0,-1.0),np.complex(4.0,-1.0)},np.complex128)
 local b=np.array({-0.0,0.0,2.0,4.0,4.0,1.0},np.float64)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 218 '..r.dtype)
 assert(exact(r:tolist(),{false,false,true,false,false,true}),'complex greater values 218')
end
do -- greater 219
 local a=np.array({np.complex(-2.0,-1.0),np.complex(0.25,-3.0),np.complex(-2.0,-1.0),np.complex(-0.0,-3.0),np.complex(0.25,0.0),np.complex(1.0,0.0)},np.complex64)
 local b=np.array({1.0,0.0,-1.0,-3.0,1.0,1.0},np.float32)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 219 '..r.dtype)
 assert(exact(r:tolist(),{false,true,false,true,false,false}),'complex greater values 219')
end
do -- greater 220
 local a=np.array({np.complex(2.0,0.0),np.complex(2.0,-1.0),np.complex(2.0,-1.0),np.complex(4.0,3.0),np.complex(1.0,1.0),np.complex(-3.0,1.0)},np.complex64)
 local b=np.array({-0.0,4.0,2.0,4.0,0.5,0.5},np.float16)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 220 '..r.dtype)
 assert(exact(r:tolist(),{true,false,false,true,true,false}),'complex greater values 220')
end
do -- greater 221
 local a=np.array({np.complex(4.0,-0.0),np.complex(-1.0,3.0),np.complex(4.0,3.0),np.complex(2.0,-0.0),np.complex(-2.0,0.0),np.complex(0.0,0.5)},np.complex64)
 local b=np.array({np.complex(-1.0,-0.0),np.complex(-0.0,-1.0),np.complex(0.25,-3.0),np.complex(-0.0,-0.0),np.complex(-0.0,1.0),np.complex(0.25,1.0)},np.complex64)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 221 '..r.dtype)
 assert(exact(r:tolist(),{true,false,true,true,false,false}),'complex greater values 221')
end
do -- greater 222
 local a=np.array({np.complex(-2.0,0.5),np.complex(1.0,-3.0),np.complex(-0.0,1.0),np.complex(-2.0,-1.0),np.complex(1.0,-0.0),np.complex(4.0,1.0)},np.complex128)
 local b=np.array({-1.0,0.5,-0.0,-3.0,-3.0,1.0},np.float16)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 222 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,true,true,true}),'complex greater values 222')
end
do -- greater 223
 local a=np.array({np.complex(-1.0,-3.0),np.complex(4.0,1.0),np.complex(0.0,-0.0),np.complex(1.0,0.5),np.complex(2.0,0.5),np.complex(-3.0,1.0)},np.complex128)
 local b=np.array({np.complex(-2.0,1.0),np.complex(1.0,0.0),np.complex(2.0,0.5),np.complex(-0.0,1.0),np.complex(0.25,-3.0),np.complex(-3.0,-1.0)},np.complex64)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 223 '..r.dtype)
 assert(exact(r:tolist(),{true,true,false,true,true,true}),'complex greater values 223')
end
do -- greater 224
 local a=np.array({np.complex(-3.0,1.0),np.complex(2.0,-1.0),np.complex(-0.0,-3.0),np.complex(0.25,3.0),np.complex(0.0,1.0),np.complex(-1.0,-1.0)},np.complex64)
 local b=np.array({0.0,-3.0,0.0,-3.0,0.0,0.0},np.float16)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 224 '..r.dtype)
 assert(exact(r:tolist(),{false,true,false,true,true,false}),'complex greater values 224')
end
do -- greater 225
 local a=np.array({np.complex(0.0,1.0),np.complex(-3.0,0.5),np.complex(4.0,-0.0),np.complex(-3.0,3.0),np.complex(2.0,3.0),np.complex(1.0,-0.0)},np.complex64)
 local b=np.array({np.complex(4.0,3.0),np.complex(2.0,1.0),np.complex(-3.0,3.0),np.complex(1.0,1.0),np.complex(4.0,3.0),np.complex(0.0,3.0)},np.complex128)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 225 '..r.dtype)
 assert(exact(r:tolist(),{false,false,true,false,false,true}),'complex greater values 225')
end
do -- greater 226
 local a=np.array({np.complex(-0.0,-3.0),np.complex(1.0,1.0),np.complex(-2.0,0.5),np.complex(1.0,1.0),np.complex(-3.0,-1.0),np.complex(-1.0,3.0)},np.complex128)
 local b=np.array({2.0,-0.0,2.0,0.5,1.0,0.0},np.float64)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 226 '..r.dtype)
 assert(exact(r:tolist(),{false,true,false,true,false,false}),'complex greater values 226')
end
do -- greater 227
 local a=np.array({np.complex(-3.0,0.0),np.complex(4.0,3.0),np.complex(2.0,-1.0),np.complex(1.0,-1.0),np.complex(-3.0,1.0),np.complex(0.25,3.0)},np.complex128)
 local b=np.array({np.complex(1.0,0.5),np.complex(4.0,-0.0),np.complex(1.0,-1.0),np.complex(1.0,-0.0),np.complex(2.0,-0.0),np.complex(-3.0,-3.0)},np.complex64)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 227 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,false,false,true}),'complex greater values 227')
end
do -- greater 228
 local a=np.array({np.complex(0.0,-0.0),np.complex(1.0,0.0),np.complex(-3.0,-1.0),np.complex(4.0,-3.0),np.complex(0.25,3.0),np.complex(0.0,1.0)},np.complex64)
 local b=np.array({1.0,2.0,0.0,0.5,1.0,-1.0},np.float64)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 228 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,true,false,true}),'complex greater values 228')
end
do -- greater 229
 local a=np.array({np.complex(-3.0,0.0),np.complex(0.0,-0.0),np.complex(4.0,3.0),np.complex(0.25,1.0),np.complex(1.0,1.0),np.complex(4.0,-3.0)},np.complex128)
 local b=np.array({-1.0,1.0,-1.0,-0.0,-3.0,-1.0},np.float16)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 229 '..r.dtype)
 assert(exact(r:tolist(),{false,false,true,true,true,true}),'complex greater values 229')
end
do -- greater 230
 local a=np.array({np.complex(-1.0,-1.0),np.complex(1.0,0.5),np.complex(-0.0,-1.0),np.complex(-0.0,0.5),np.complex(-3.0,3.0),np.complex(-2.0,-1.0)},np.complex128)
 local b=np.array({np.complex(2.0,-3.0),np.complex(2.0,-0.0),np.complex(-0.0,-3.0),np.complex(0.0,-0.0),np.complex(0.0,-1.0),np.complex(-0.0,-0.0)},np.complex128)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 230 '..r.dtype)
 assert(exact(r:tolist(),{false,false,true,true,false,false}),'complex greater values 230')
end
do -- greater 231
 local a=np.array({np.complex(0.25,-1.0),np.complex(2.0,-0.0),np.complex(2.0,-0.0),np.complex(0.0,-0.0),np.complex(-2.0,-0.0),np.complex(0.25,1.0)},np.complex128)
 local b=np.array({-3.0,0.0,4.0,-0.0,2.0,-3.0},np.float32)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 231 '..r.dtype)
 assert(exact(r:tolist(),{true,true,false,false,false,true}),'complex greater values 231')
end
do -- greater 232
 local a=np.array({np.complex(-1.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,1.0),np.complex(4.0,-3.0),np.complex(0.0,-1.0),np.complex(4.0,-0.0)},np.complex128)
 local b=np.array({np.complex(0.0,0.0),np.complex(0.25,0.5),np.complex(0.25,3.0),np.complex(0.25,0.0),np.complex(1.0,-1.0),np.complex(-2.0,3.0)},np.complex64)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 232 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,true,false,true}),'complex greater values 232')
end
do -- greater 233
 local a=np.array({np.complex(0.0,-3.0),np.complex(-2.0,-0.0),np.complex(-0.0,-3.0),np.complex(1.0,0.0),np.complex(2.0,-3.0),np.complex(1.0,-3.0)},np.complex64)
 local b=np.array({np.complex(-3.0,-0.0),np.complex(1.0,3.0),np.complex(-0.0,-1.0),np.complex(2.0,-3.0),np.complex(0.25,0.5),np.complex(4.0,-3.0)},np.complex128)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 233 '..r.dtype)
 assert(exact(r:tolist(),{true,false,false,false,true,false}),'complex greater values 233')
end
do -- greater 234
 local a=np.array({np.complex(4.0,-3.0),np.complex(1.0,-3.0),np.complex(0.0,0.5),np.complex(0.0,1.0),np.complex(-1.0,-3.0),np.complex(-3.0,-3.0)},np.complex64)
 local b=np.array({1.0,1.0,0.5,-3.0,-3.0,0.0},np.float16)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','complex greater dtype 234 '..r.dtype)
 assert(exact(r:tolist(),{true,false,false,true,true,false}),'complex greater values 234')
end
do -- greater_equal 235
 local a=np.array({np.complex(-2.0,0.5),np.complex(0.0,3.0),np.complex(2.0,0.5),np.complex(0.25,-1.0),np.complex(0.0,1.0),np.complex(-1.0,3.0)},np.complex64)
 local b=np.array({4.0,1.0,0.5,-1.0,0.5,0.0},np.float32)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 235 '..r.dtype)
 assert(exact(r:tolist(),{false,false,true,true,false,false}),'complex greater_equal values 235')
end
do -- greater_equal 236
 local a=np.array({np.complex(2.0,-0.0),np.complex(2.0,0.0),np.complex(2.0,1.0),np.complex(-1.0,-3.0),np.complex(-0.0,-0.0),np.complex(-3.0,0.5)},np.complex128)
 local b=np.array({0.5,0.5,-0.0,0.5,2.0,2.0},np.float16)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 236 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,false,false,false}),'complex greater_equal values 236')
end
do -- greater_equal 237
 local a=np.array({np.complex(-2.0,0.5),np.complex(-1.0,-3.0),np.complex(-1.0,1.0),np.complex(4.0,-0.0),np.complex(2.0,0.0),np.complex(-3.0,-0.0)},np.complex128)
 local b=np.array({-0.0,1.0,-1.0,-3.0,-1.0,-0.0},np.float64)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 237 '..r.dtype)
 assert(exact(r:tolist(),{false,false,true,true,true,false}),'complex greater_equal values 237')
end
do -- greater_equal 238
 local a=np.array({np.complex(2.0,1.0),np.complex(-2.0,-1.0),np.complex(2.0,-1.0),np.complex(-3.0,-1.0),np.complex(-2.0,3.0),np.complex(1.0,3.0)},np.complex128)
 local b=np.array({np.complex(-1.0,0.5),np.complex(1.0,0.0),np.complex(-1.0,-1.0),np.complex(1.0,-3.0),np.complex(4.0,0.0),np.complex(-3.0,1.0)},np.complex128)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 238 '..r.dtype)
 assert(exact(r:tolist(),{true,false,true,false,false,true}),'complex greater_equal values 238')
end
do -- greater_equal 239
 local a=np.array({np.complex(0.25,3.0),np.complex(4.0,-1.0),np.complex(-3.0,-0.0),np.complex(-3.0,0.5),np.complex(1.0,1.0),np.complex(-1.0,0.0)},np.complex128)
 local b=np.array({2.0,0.5,1.0,-0.0,-3.0,4.0},np.float64)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 239 '..r.dtype)
 assert(exact(r:tolist(),{false,true,false,false,true,false}),'complex greater_equal values 239')
end
do -- greater_equal 240
 local a=np.array({np.complex(4.0,0.5),np.complex(1.0,0.0),np.complex(4.0,1.0),np.complex(4.0,0.0),np.complex(-2.0,0.5),np.complex(-0.0,1.0)},np.complex64)
 local b=np.array({0.5,-3.0,-3.0,-3.0,-0.0,0.0},np.float64)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 240 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,false,true}),'complex greater_equal values 240')
end
do -- greater_equal 241
 local a=np.array({np.complex(-2.0,3.0),np.complex(-3.0,0.0),np.complex(1.0,0.5),np.complex(2.0,1.0),np.complex(2.0,0.5),np.complex(-1.0,0.5)},np.complex64)
 local b=np.array({-3.0,2.0,2.0,0.5,0.5,-0.0},np.float32)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 241 '..r.dtype)
 assert(exact(r:tolist(),{true,false,false,true,true,false}),'complex greater_equal values 241')
end
do -- greater_equal 242
 local a=np.array({np.complex(4.0,0.0),np.complex(0.25,3.0),np.complex(0.0,-3.0),np.complex(0.25,-0.0),np.complex(1.0,-1.0),np.complex(2.0,-0.0)},np.complex64)
 local b=np.array({0.5,0.5,-0.0,0.5,-3.0,4.0},np.float64)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 242 '..r.dtype)
 assert(exact(r:tolist(),{true,false,false,false,true,false}),'complex greater_equal values 242')
end
do -- greater_equal 243
 local a=np.array({np.complex(2.0,3.0),np.complex(2.0,0.0),np.complex(-2.0,0.5),np.complex(-0.0,3.0),np.complex(0.25,-0.0),np.complex(-0.0,-1.0)},np.complex64)
 local b=np.array({1.0,-0.0,0.5,1.0,4.0,0.5},np.float32)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 243 '..r.dtype)
 assert(exact(r:tolist(),{true,true,false,false,false,false}),'complex greater_equal values 243')
end
do -- greater_equal 244
 local a=np.array({np.complex(1.0,-0.0),np.complex(0.0,0.5),np.complex(-1.0,-3.0),np.complex(0.0,-0.0),np.complex(-0.0,3.0),np.complex(2.0,-1.0)},np.complex128)
 local b=np.array({np.complex(-3.0,0.5),np.complex(-2.0,-1.0),np.complex(0.25,1.0),np.complex(-2.0,0.0),np.complex(0.0,-0.0),np.complex(0.0,-1.0)},np.complex128)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 244 '..r.dtype)
 assert(exact(r:tolist(),{true,true,false,true,true,true}),'complex greater_equal values 244')
end
do -- greater_equal 245
 local a=np.array({np.complex(-1.0,-3.0),np.complex(-0.0,-3.0),np.complex(4.0,3.0),np.complex(-0.0,-0.0),np.complex(0.25,-0.0),np.complex(1.0,-0.0)},np.complex64)
 local b=np.array({np.complex(-2.0,-3.0),np.complex(4.0,3.0),np.complex(0.0,-3.0),np.complex(0.25,0.0),np.complex(-2.0,-3.0),np.complex(-1.0,-3.0)},np.complex64)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 245 '..r.dtype)
 assert(exact(r:tolist(),{true,false,true,false,true,true}),'complex greater_equal values 245')
end
do -- greater_equal 246
 local a=np.array({np.complex(-3.0,-1.0),np.complex(-1.0,3.0),np.complex(-0.0,1.0),np.complex(-2.0,-3.0),np.complex(2.0,3.0),np.complex(-0.0,1.0)},np.complex64)
 local b=np.array({np.complex(2.0,0.0),np.complex(0.25,0.0),np.complex(2.0,0.0),np.complex(-1.0,3.0),np.complex(0.0,1.0),np.complex(4.0,3.0)},np.complex64)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 246 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,true,false}),'complex greater_equal values 246')
end
do -- greater_equal 247
 local a=np.array({np.complex(0.0,1.0),np.complex(0.0,0.0),np.complex(4.0,3.0),np.complex(-1.0,1.0),np.complex(2.0,0.5),np.complex(-2.0,-0.0)},np.complex128)
 local b=np.array({2.0,-1.0,2.0,0.0,-1.0,1.0},np.float64)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 247 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,false,true,false}),'complex greater_equal values 247')
end
do -- greater_equal 248
 local a=np.array({np.complex(-1.0,-3.0),np.complex(-1.0,3.0),np.complex(2.0,0.5),np.complex(-2.0,3.0),np.complex(0.0,-3.0),np.complex(0.0,-0.0)},np.complex64)
 local b=np.array({2.0,4.0,-1.0,2.0,0.0,0.0},np.float16)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 248 '..r.dtype)
 assert(exact(r:tolist(),{false,false,true,false,false,true}),'complex greater_equal values 248')
end
do -- greater_equal 249
 local a=np.array({np.complex(0.25,-1.0),np.complex(2.0,0.5),np.complex(0.0,0.5),np.complex(0.0,-1.0),np.complex(-1.0,3.0),np.complex(-2.0,0.5)},np.complex128)
 local b=np.array({np.complex(-3.0,0.5),np.complex(-2.0,0.5),np.complex(-1.0,1.0),np.complex(0.25,3.0),np.complex(-0.0,-1.0),np.complex(-1.0,3.0)},np.complex64)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 249 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,false,false,false}),'complex greater_equal values 249')
end
do -- greater_equal 250
 local a=np.array({np.complex(0.25,0.5),np.complex(0.0,-0.0),np.complex(0.25,1.0),np.complex(-3.0,-3.0),np.complex(-0.0,-3.0),np.complex(-0.0,0.0)},np.complex128)
 local b=np.array({0.0,0.5,0.0,2.0,4.0,0.5},np.float32)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 250 '..r.dtype)
 assert(exact(r:tolist(),{true,false,true,false,false,false}),'complex greater_equal values 250')
end
do -- greater_equal 251
 local a=np.array({np.complex(0.25,-1.0),np.complex(0.25,0.5),np.complex(-2.0,3.0),np.complex(4.0,3.0),np.complex(0.0,-1.0),np.complex(2.0,-0.0)},np.complex64)
 local b=np.array({-0.0,-1.0,1.0,1.0,0.0,-3.0},np.float16)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 251 '..r.dtype)
 assert(exact(r:tolist(),{true,true,false,true,false,true}),'complex greater_equal values 251')
end
do -- greater_equal 252
 local a=np.array({np.complex(0.25,-1.0),np.complex(4.0,-1.0),np.complex(-0.0,3.0),np.complex(1.0,0.0),np.complex(-1.0,-1.0),np.complex(-2.0,-1.0)},np.complex64)
 local b=np.array({np.complex(0.0,3.0),np.complex(2.0,-1.0),np.complex(4.0,3.0),np.complex(4.0,-1.0),np.complex(-1.0,1.0),np.complex(2.0,-0.0)},np.complex64)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 252 '..r.dtype)
 assert(exact(r:tolist(),{true,true,false,false,false,false}),'complex greater_equal values 252')
end
do -- greater_equal 253
 local a=np.array({np.complex(-0.0,0.0),np.complex(4.0,0.0),np.complex(0.0,1.0),np.complex(0.0,-3.0),np.complex(-3.0,3.0),np.complex(-0.0,-1.0)},np.complex128)
 local b=np.array({2.0,-3.0,4.0,2.0,-3.0,0.0},np.float32)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 253 '..r.dtype)
 assert(exact(r:tolist(),{false,true,false,false,true,false}),'complex greater_equal values 253')
end
do -- greater_equal 254
 local a=np.array({np.complex(-1.0,0.5),np.complex(2.0,-0.0),np.complex(-2.0,0.0),np.complex(0.25,-3.0),np.complex(2.0,0.5),np.complex(-1.0,-0.0)},np.complex64)
 local b=np.array({np.complex(-0.0,-3.0),np.complex(-3.0,-0.0),np.complex(0.0,3.0),np.complex(-1.0,3.0),np.complex(0.0,0.5),np.complex(-0.0,-0.0)},np.complex128)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 254 '..r.dtype)
 assert(exact(r:tolist(),{false,true,false,true,true,false}),'complex greater_equal values 254')
end
do -- greater_equal 255
 local a=np.array({np.complex(2.0,0.0),np.complex(-2.0,0.5),np.complex(4.0,-3.0),np.complex(2.0,0.0),np.complex(-0.0,-1.0),np.complex(1.0,3.0)},np.complex64)
 local b=np.array({np.complex(0.0,-3.0),np.complex(-1.0,-0.0),np.complex(0.0,-3.0),np.complex(0.25,-1.0),np.complex(0.25,1.0),np.complex(-0.0,1.0)},np.complex128)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 255 '..r.dtype)
 assert(exact(r:tolist(),{true,false,true,true,false,true}),'complex greater_equal values 255')
end
do -- greater_equal 256
 local a=np.array({np.complex(-2.0,-1.0),np.complex(-2.0,1.0),np.complex(-3.0,-3.0),np.complex(1.0,1.0),np.complex(-1.0,1.0),np.complex(-0.0,0.0)},np.complex128)
 local b=np.array({1.0,4.0,0.5,4.0,-3.0,-0.0},np.float64)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 256 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,true,true}),'complex greater_equal values 256')
end
do -- greater_equal 257
 local a=np.array({np.complex(0.0,3.0),np.complex(1.0,0.5),np.complex(-2.0,-0.0),np.complex(-3.0,-1.0),np.complex(0.0,-3.0),np.complex(0.25,0.0)},np.complex64)
 local b=np.array({4.0,2.0,2.0,-1.0,-0.0,4.0},np.float16)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 257 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex greater_equal values 257')
end
do -- greater_equal 258
 local a=np.array({np.complex(1.0,3.0),np.complex(2.0,0.5),np.complex(-2.0,-3.0),np.complex(-1.0,1.0),np.complex(-1.0,-1.0),np.complex(-3.0,-3.0)},np.complex64)
 local b=np.array({-3.0,4.0,-3.0,-3.0,2.0,2.0},np.float32)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','complex greater_equal dtype 258 '..r.dtype)
 assert(exact(r:tolist(),{true,false,true,true,false,false}),'complex greater_equal values 258')
end
do -- logical_and 259
 local a=np.array({np.complex(-1.0,-0.0),np.complex(0.0,-3.0),np.complex(2.0,-0.0),np.complex(-3.0,3.0),np.complex(-0.0,0.5),np.complex(2.0,-3.0)},np.complex64)
 local b=np.array({0.5,-3.0,-3.0,0.5,0.0,-1.0},np.float64)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 259 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,false,true}),'complex logical_and values 259')
end
do -- logical_and 260
 local a=np.array({np.complex(-0.0,0.0),np.complex(-2.0,0.5),np.complex(0.25,-1.0),np.complex(-3.0,0.0),np.complex(2.0,-0.0),np.complex(-2.0,0.0)},np.complex128)
 local b=np.array({np.complex(-3.0,-1.0),np.complex(-3.0,-3.0),np.complex(4.0,-0.0),np.complex(-2.0,-0.0),np.complex(-2.0,0.0),np.complex(0.25,0.5)},np.complex128)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 260 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,true,true,true}),'complex logical_and values 260')
end
do -- logical_and 261
 local a=np.array({np.complex(0.25,0.5),np.complex(1.0,-1.0),np.complex(-1.0,3.0),np.complex(4.0,-1.0),np.complex(2.0,-3.0),np.complex(0.0,-0.0)},np.complex128)
 local b=np.array({np.complex(4.0,-0.0),np.complex(1.0,1.0),np.complex(-3.0,1.0),np.complex(-3.0,0.0),np.complex(-1.0,1.0),np.complex(2.0,3.0)},np.complex64)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 261 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,false}),'complex logical_and values 261')
end
do -- logical_and 262
 local a=np.array({np.complex(-3.0,0.0),np.complex(0.25,-0.0),np.complex(-3.0,0.0),np.complex(4.0,-3.0),np.complex(1.0,0.0),np.complex(-0.0,-1.0)},np.complex128)
 local b=np.array({np.complex(1.0,-3.0),np.complex(-0.0,0.0),np.complex(2.0,-0.0),np.complex(-3.0,-1.0),np.complex(-0.0,-0.0),np.complex(1.0,-0.0)},np.complex64)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 262 '..r.dtype)
 assert(exact(r:tolist(),{true,false,true,true,false,true}),'complex logical_and values 262')
end
do -- logical_and 263
 local a=np.array({np.complex(-0.0,-3.0),np.complex(1.0,3.0),np.complex(4.0,1.0),np.complex(0.0,1.0),np.complex(-1.0,-0.0),np.complex(-3.0,-0.0)},np.complex128)
 local b=np.array({0.0,-3.0,1.0,4.0,1.0,2.0},np.float16)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 263 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,true,true,true}),'complex logical_and values 263')
end
do -- logical_and 264
 local a=np.array({np.complex(1.0,-0.0),np.complex(-1.0,3.0),np.complex(0.25,0.0),np.complex(2.0,0.5),np.complex(2.0,1.0),np.complex(-0.0,0.5)},np.complex64)
 local b=np.array({np.complex(-3.0,0.0),np.complex(0.25,-0.0),np.complex(-1.0,1.0),np.complex(-0.0,3.0),np.complex(4.0,-3.0),np.complex(2.0,0.5)},np.complex64)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 264 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_and values 264')
end
do -- logical_and 265
 local a=np.array({np.complex(0.25,1.0),np.complex(2.0,0.5),np.complex(-1.0,3.0),np.complex(-0.0,0.0),np.complex(0.25,0.5),np.complex(1.0,-0.0)},np.complex64)
 local b=np.array({2.0,-1.0,1.0,2.0,1.0,-1.0},np.float32)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 265 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,false,true,true}),'complex logical_and values 265')
end
do -- logical_and 266
 local a=np.array({np.complex(0.25,3.0),np.complex(0.0,-3.0),np.complex(0.25,-1.0),np.complex(4.0,-3.0),np.complex(4.0,1.0),np.complex(0.25,-0.0)},np.complex64)
 local b=np.array({1.0,-3.0,4.0,-1.0,-3.0,0.5},np.float16)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 266 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_and values 266')
end
do -- logical_and 267
 local a=np.array({np.complex(1.0,-0.0),np.complex(-0.0,-3.0),np.complex(2.0,0.0),np.complex(-2.0,-1.0),np.complex(1.0,-0.0),np.complex(4.0,3.0)},np.complex128)
 local b=np.array({0.0,-3.0,-3.0,-0.0,0.5,1.0},np.float16)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 267 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,false,true,true}),'complex logical_and values 267')
end
do -- logical_and 268
 local a=np.array({np.complex(0.25,0.5),np.complex(4.0,1.0),np.complex(-0.0,0.5),np.complex(-2.0,-1.0),np.complex(4.0,-3.0),np.complex(4.0,-1.0)},np.complex64)
 local b=np.array({2.0,-3.0,0.5,4.0,-0.0,-3.0},np.float64)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 268 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,false,true}),'complex logical_and values 268')
end
do -- logical_and 269
 local a=np.array({np.complex(-0.0,1.0),np.complex(-3.0,-0.0),np.complex(1.0,0.0),np.complex(2.0,-3.0),np.complex(2.0,-1.0),np.complex(0.25,3.0)},np.complex64)
 local b=np.array({-3.0,0.0,-3.0,1.0,1.0,4.0},np.float16)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 269 '..r.dtype)
 assert(exact(r:tolist(),{true,false,true,true,true,true}),'complex logical_and values 269')
end
do -- logical_and 270
 local a=np.array({np.complex(-0.0,0.0),np.complex(-2.0,-1.0),np.complex(0.0,-3.0),np.complex(2.0,1.0),np.complex(-3.0,0.0),np.complex(2.0,3.0)},np.complex128)
 local b=np.array({2.0,2.0,-3.0,2.0,2.0,0.5},np.float32)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 270 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,true,true,true}),'complex logical_and values 270')
end
do -- logical_and 271
 local a=np.array({np.complex(2.0,1.0),np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(-3.0,1.0),np.complex(-1.0,-1.0),np.complex(4.0,-0.0)},np.complex128)
 local b=np.array({1.0,0.0,-0.0,0.0,-3.0,-0.0},np.float32)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 271 '..r.dtype)
 assert(exact(r:tolist(),{true,false,false,false,true,false}),'complex logical_and values 271')
end
do -- logical_and 272
 local a=np.array({np.complex(4.0,3.0),np.complex(-3.0,-0.0),np.complex(0.25,0.0),np.complex(2.0,-0.0),np.complex(-0.0,3.0),np.complex(1.0,0.0)},np.complex64)
 local b=np.array({0.0,1.0,0.5,0.5,2.0,0.5},np.float32)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 272 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,true,true,true}),'complex logical_and values 272')
end
do -- logical_and 273
 local a=np.array({np.complex(0.25,-3.0),np.complex(-0.0,1.0),np.complex(-0.0,0.0),np.complex(-2.0,-1.0),np.complex(-0.0,0.0),np.complex(1.0,-1.0)},np.complex128)
 local b=np.array({-1.0,2.0,-3.0,0.0,0.5,0.5},np.float16)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 273 '..r.dtype)
 assert(exact(r:tolist(),{true,true,false,false,false,true}),'complex logical_and values 273')
end
do -- logical_and 274
 local a=np.array({np.complex(-2.0,0.5),np.complex(2.0,1.0),np.complex(-3.0,0.0),np.complex(2.0,1.0),np.complex(-1.0,3.0),np.complex(-1.0,-0.0)},np.complex128)
 local b=np.array({0.0,-3.0,2.0,0.5,-0.0,0.0},np.float16)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 274 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,true,false,false}),'complex logical_and values 274')
end
do -- logical_and 275
 local a=np.array({np.complex(-0.0,-1.0),np.complex(4.0,3.0),np.complex(1.0,0.5),np.complex(-2.0,-1.0),np.complex(4.0,-3.0),np.complex(-3.0,1.0)},np.complex64)
 local b=np.array({-0.0,4.0,-1.0,0.0,-3.0,2.0},np.float16)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 275 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,false,true,true}),'complex logical_and values 275')
end
do -- logical_and 276
 local a=np.array({np.complex(1.0,0.0),np.complex(0.0,3.0),np.complex(2.0,-3.0),np.complex(2.0,0.5),np.complex(-0.0,-0.0),np.complex(2.0,-1.0)},np.complex128)
 local b=np.array({2.0,4.0,0.5,0.5,-1.0,1.0},np.float32)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 276 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,false,true}),'complex logical_and values 276')
end
do -- logical_and 277
 local a=np.array({np.complex(1.0,-0.0),np.complex(-2.0,-0.0),np.complex(0.0,-0.0),np.complex(0.0,0.5),np.complex(1.0,-3.0),np.complex(2.0,3.0)},np.complex128)
 local b=np.array({-1.0,1.0,-0.0,1.0,0.0,0.0},np.float64)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 277 '..r.dtype)
 assert(exact(r:tolist(),{true,true,false,true,false,false}),'complex logical_and values 277')
end
do -- logical_and 278
 local a=np.array({np.complex(-0.0,0.5),np.complex(4.0,0.5),np.complex(1.0,-3.0),np.complex(-1.0,-0.0),np.complex(1.0,0.0),np.complex(-3.0,3.0)},np.complex128)
 local b=np.array({-1.0,4.0,4.0,-1.0,0.0,1.0},np.float64)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 278 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,false,true}),'complex logical_and values 278')
end
do -- logical_and 279
 local a=np.array({np.complex(-1.0,1.0),np.complex(4.0,-3.0),np.complex(0.0,-3.0),np.complex(-2.0,0.5),np.complex(-0.0,0.5),np.complex(-0.0,-3.0)},np.complex64)
 local b=np.array({np.complex(0.25,-1.0),np.complex(-3.0,-1.0),np.complex(-2.0,0.5),np.complex(1.0,0.0),np.complex(4.0,-1.0),np.complex(-0.0,3.0)},np.complex64)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 279 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_and values 279')
end
do -- logical_and 280
 local a=np.array({np.complex(2.0,-3.0),np.complex(1.0,1.0),np.complex(4.0,-0.0),np.complex(0.0,-1.0),np.complex(-2.0,-3.0),np.complex(-1.0,0.0)},np.complex128)
 local b=np.array({-0.0,2.0,-1.0,0.5,0.5,-0.0},np.float32)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 280 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,true,true,false}),'complex logical_and values 280')
end
do -- logical_and 281
 local a=np.array({np.complex(-2.0,-3.0),np.complex(0.0,0.0),np.complex(0.25,0.0),np.complex(-3.0,-3.0),np.complex(0.0,-1.0),np.complex(0.25,0.0)},np.complex128)
 local b=np.array({2.0,4.0,-3.0,0.5,2.0,1.0},np.float64)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 281 '..r.dtype)
 assert(exact(r:tolist(),{true,false,true,true,true,true}),'complex logical_and values 281')
end
do -- logical_and 282
 local a=np.array({np.complex(-0.0,0.0),np.complex(0.25,0.5),np.complex(2.0,1.0),np.complex(-3.0,3.0),np.complex(-0.0,0.5),np.complex(-3.0,-1.0)},np.complex128)
 local b=np.array({np.complex(4.0,-1.0),np.complex(-1.0,-3.0),np.complex(4.0,3.0),np.complex(-2.0,-1.0),np.complex(4.0,3.0),np.complex(4.0,0.5)},np.complex64)
 local r=np.logical_and(a,b)
 assert(r.dtype=='bool','complex logical_and dtype 282 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,true,true,true}),'complex logical_and values 282')
end
do -- logical_or 283
 local a=np.array({np.complex(-3.0,0.5),np.complex(4.0,-0.0),np.complex(4.0,1.0),np.complex(-3.0,0.0),np.complex(-1.0,1.0),np.complex(-2.0,-1.0)},np.complex64)
 local b=np.array({4.0,-3.0,-3.0,2.0,0.5,0.0},np.float32)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 283 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_or values 283')
end
do -- logical_or 284
 local a=np.array({np.complex(0.25,-1.0),np.complex(0.0,3.0),np.complex(-2.0,-0.0),np.complex(-1.0,1.0),np.complex(0.0,3.0),np.complex(4.0,0.0)},np.complex64)
 local b=np.array({1.0,4.0,-0.0,2.0,-1.0,1.0},np.float32)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 284 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_or values 284')
end
do -- logical_or 285
 local a=np.array({np.complex(-2.0,0.0),np.complex(-1.0,-3.0),np.complex(4.0,-3.0),np.complex(-1.0,-0.0),np.complex(-3.0,-3.0),np.complex(0.25,0.5)},np.complex64)
 local b=np.array({-1.0,-0.0,0.5,1.0,2.0,-3.0},np.float16)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 285 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_or values 285')
end
do -- logical_or 286
 local a=np.array({np.complex(0.25,-0.0),np.complex(-0.0,1.0),np.complex(0.0,0.0),np.complex(-0.0,-1.0),np.complex(2.0,0.5),np.complex(-0.0,0.0)},np.complex64)
 local b=np.array({np.complex(0.25,0.5),np.complex(-2.0,-3.0),np.complex(2.0,1.0),np.complex(0.0,1.0),np.complex(4.0,3.0),np.complex(-0.0,1.0)},np.complex64)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 286 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_or values 286')
end
do -- logical_or 287
 local a=np.array({np.complex(-2.0,-0.0),np.complex(4.0,-0.0),np.complex(0.0,-3.0),np.complex(4.0,-1.0),np.complex(-2.0,-0.0),np.complex(0.25,-0.0)},np.complex128)
 local b=np.array({np.complex(1.0,-3.0),np.complex(-0.0,3.0),np.complex(-3.0,-0.0),np.complex(-0.0,3.0),np.complex(-1.0,0.0),np.complex(-2.0,-1.0)},np.complex64)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 287 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_or values 287')
end
do -- logical_or 288
 local a=np.array({np.complex(0.0,-3.0),np.complex(4.0,-3.0),np.complex(0.0,-3.0),np.complex(2.0,-1.0),np.complex(1.0,1.0),np.complex(4.0,-3.0)},np.complex128)
 local b=np.array({4.0,-3.0,-1.0,-3.0,1.0,-1.0},np.float16)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 288 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_or values 288')
end
do -- logical_or 289
 local a=np.array({np.complex(-2.0,-3.0),np.complex(1.0,0.0),np.complex(2.0,-1.0),np.complex(0.25,-3.0),np.complex(2.0,-1.0),np.complex(-0.0,-0.0)},np.complex64)
 local b=np.array({-0.0,1.0,0.5,0.0,-1.0,-0.0},np.float16)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 289 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,false}),'complex logical_or values 289')
end
do -- logical_or 290
 local a=np.array({np.complex(4.0,1.0),np.complex(-2.0,-0.0),np.complex(-2.0,0.5),np.complex(-2.0,1.0),np.complex(-0.0,0.5),np.complex(0.0,1.0)},np.complex64)
 local b=np.array({np.complex(1.0,0.5),np.complex(0.25,-3.0),np.complex(4.0,1.0),np.complex(0.25,0.5),np.complex(2.0,0.0),np.complex(-3.0,0.5)},np.complex128)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 290 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_or values 290')
end
do -- logical_or 291
 local a=np.array({np.complex(-0.0,1.0),np.complex(-2.0,0.5),np.complex(-1.0,3.0),np.complex(2.0,-1.0),np.complex(1.0,0.0),np.complex(-0.0,0.5)},np.complex128)
 local b=np.array({-1.0,1.0,2.0,0.5,0.0,4.0},np.float64)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 291 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_or values 291')
end
do -- logical_or 292
 local a=np.array({np.complex(-0.0,1.0),np.complex(0.25,-0.0),np.complex(1.0,-1.0),np.complex(-1.0,-3.0),np.complex(-3.0,-1.0),np.complex(-0.0,0.0)},np.complex128)
 local b=np.array({0.5,2.0,1.0,4.0,1.0,-0.0},np.float64)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 292 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,false}),'complex logical_or values 292')
end
do -- logical_or 293
 local a=np.array({np.complex(-0.0,0.5),np.complex(0.25,1.0),np.complex(-2.0,-0.0),np.complex(-2.0,-3.0),np.complex(0.25,1.0),np.complex(-0.0,-0.0)},np.complex128)
 local b=np.array({4.0,-0.0,1.0,-3.0,0.0,0.0},np.float64)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 293 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,false}),'complex logical_or values 293')
end
do -- logical_or 294
 local a=np.array({np.complex(1.0,-0.0),np.complex(-0.0,0.5),np.complex(2.0,1.0),np.complex(0.0,1.0),np.complex(1.0,1.0),np.complex(0.0,-1.0)},np.complex128)
 local b=np.array({0.0,0.5,-3.0,1.0,0.0,1.0},np.float64)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 294 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_or values 294')
end
do -- logical_or 295
 local a=np.array({np.complex(-0.0,0.0),np.complex(2.0,0.0),np.complex(0.0,-3.0),np.complex(-3.0,1.0),np.complex(1.0,3.0),np.complex(4.0,0.5)},np.complex128)
 local b=np.array({np.complex(-1.0,0.5),np.complex(-1.0,3.0),np.complex(1.0,1.0),np.complex(-0.0,0.5),np.complex(-1.0,0.0),np.complex(2.0,-3.0)},np.complex64)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 295 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_or values 295')
end
do -- logical_or 296
 local a=np.array({np.complex(0.25,0.5),np.complex(1.0,3.0),np.complex(0.0,0.0),np.complex(-2.0,0.0),np.complex(-2.0,-1.0),np.complex(-3.0,0.0)},np.complex128)
 local b=np.array({np.complex(1.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,1.0),np.complex(-2.0,-1.0),np.complex(0.0,-0.0),np.complex(0.25,0.0)},np.complex64)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 296 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_or values 296')
end
do -- logical_or 297
 local a=np.array({np.complex(1.0,-3.0),np.complex(-2.0,3.0),np.complex(0.0,3.0),np.complex(-3.0,1.0),np.complex(-0.0,-3.0),np.complex(1.0,-1.0)},np.complex64)
 local b=np.array({1.0,4.0,0.0,-1.0,-0.0,2.0},np.float32)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 297 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_or values 297')
end
do -- logical_or 298
 local a=np.array({np.complex(-1.0,0.5),np.complex(-2.0,-0.0),np.complex(2.0,3.0),np.complex(0.25,0.5),np.complex(4.0,3.0),np.complex(0.25,1.0)},np.complex128)
 local b=np.array({4.0,4.0,-1.0,4.0,2.0,0.5},np.float16)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 298 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_or values 298')
end
do -- logical_or 299
 local a=np.array({np.complex(0.0,1.0),np.complex(0.0,-0.0),np.complex(0.0,1.0),np.complex(0.25,-3.0),np.complex(1.0,-3.0),np.complex(-3.0,0.5)},np.complex64)
 local b=np.array({np.complex(2.0,3.0),np.complex(1.0,0.0),np.complex(2.0,-3.0),np.complex(1.0,-1.0),np.complex(0.25,-0.0),np.complex(2.0,3.0)},np.complex128)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 299 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_or values 299')
end
do -- logical_or 300
 local a=np.array({np.complex(4.0,0.5),np.complex(2.0,-3.0),np.complex(0.0,0.0),np.complex(-0.0,1.0),np.complex(0.25,-3.0),np.complex(0.0,0.0)},np.complex64)
 local b=np.array({0.5,4.0,-0.0,2.0,-3.0,2.0},np.float16)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 300 '..r.dtype)
 assert(exact(r:tolist(),{true,true,false,true,true,true}),'complex logical_or values 300')
end
do -- logical_or 301
 local a=np.array({np.complex(-2.0,0.0),np.complex(-1.0,-1.0),np.complex(-2.0,0.0),np.complex(0.0,-0.0),np.complex(0.0,3.0),np.complex(-3.0,0.5)},np.complex64)
 local b=np.array({np.complex(4.0,0.0),np.complex(-3.0,-3.0),np.complex(4.0,-0.0),np.complex(1.0,-0.0),np.complex(0.25,1.0),np.complex(-2.0,0.5)},np.complex64)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 301 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_or values 301')
end
do -- logical_or 302
 local a=np.array({np.complex(4.0,-0.0),np.complex(-0.0,-0.0),np.complex(1.0,-3.0),np.complex(-1.0,0.5),np.complex(4.0,-3.0),np.complex(-2.0,-0.0)},np.complex64)
 local b=np.array({-0.0,-3.0,2.0,4.0,-1.0,2.0},np.float64)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 302 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_or values 302')
end
do -- logical_or 303
 local a=np.array({np.complex(1.0,0.0),np.complex(-2.0,3.0),np.complex(4.0,-1.0),np.complex(0.25,0.5),np.complex(-3.0,1.0),np.complex(0.0,0.0)},np.complex64)
 local b=np.array({4.0,0.0,2.0,0.0,4.0,0.5},np.float64)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 303 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_or values 303')
end
do -- logical_or 304
 local a=np.array({np.complex(-3.0,0.0),np.complex(4.0,-0.0),np.complex(0.25,-0.0),np.complex(-2.0,-3.0),np.complex(-0.0,1.0),np.complex(0.25,-0.0)},np.complex64)
 local b=np.array({np.complex(2.0,1.0),np.complex(4.0,-3.0),np.complex(4.0,-3.0),np.complex(2.0,0.0),np.complex(0.0,0.5),np.complex(4.0,-1.0)},np.complex128)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 304 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_or values 304')
end
do -- logical_or 305
 local a=np.array({np.complex(0.0,-1.0),np.complex(0.0,1.0),np.complex(2.0,-3.0),np.complex(2.0,0.0),np.complex(4.0,1.0),np.complex(0.0,-0.0)},np.complex128)
 local b=np.array({-3.0,2.0,-3.0,-3.0,4.0,0.5},np.float16)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 305 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_or values 305')
end
do -- logical_or 306
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.25,1.0),np.complex(1.0,-0.0),np.complex(4.0,0.5),np.complex(-1.0,-3.0),np.complex(-3.0,0.5)},np.complex64)
 local b=np.array({np.complex(-2.0,-0.0),np.complex(0.25,3.0),np.complex(2.0,-0.0),np.complex(-3.0,-0.0),np.complex(0.0,1.0),np.complex(1.0,-3.0)},np.complex64)
 local r=np.logical_or(a,b)
 assert(r.dtype=='bool','complex logical_or dtype 306 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,true,true,true}),'complex logical_or values 306')
end
do -- logical_xor 307
 local a=np.array({np.complex(-1.0,0.0),np.complex(0.0,-0.0),np.complex(0.25,-0.0),np.complex(0.25,-0.0),np.complex(-3.0,-3.0),np.complex(0.0,3.0)},np.complex64)
 local b=np.array({0.5,-3.0,-0.0,-0.0,-0.0,1.0},np.float16)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 307 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,true,true,false}),'complex logical_xor values 307')
end
do -- logical_xor 308
 local a=np.array({np.complex(0.0,-1.0),np.complex(0.0,0.5),np.complex(0.25,0.5),np.complex(1.0,3.0),np.complex(-3.0,1.0),np.complex(4.0,0.0)},np.complex64)
 local b=np.array({-3.0,-0.0,-1.0,0.5,-3.0,-0.0},np.float32)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 308 '..r.dtype)
 assert(exact(r:tolist(),{false,true,false,false,false,true}),'complex logical_xor values 308')
end
do -- logical_xor 309
 local a=np.array({np.complex(-3.0,1.0),np.complex(0.25,3.0),np.complex(2.0,0.0),np.complex(-1.0,-0.0),np.complex(4.0,0.5),np.complex(0.0,0.5)},np.complex128)
 local b=np.array({0.5,4.0,4.0,1.0,0.5,0.0},np.float64)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 309 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,true}),'complex logical_xor values 309')
end
do -- logical_xor 310
 local a=np.array({np.complex(-0.0,-3.0),np.complex(0.0,0.5),np.complex(-0.0,1.0),np.complex(-2.0,0.0),np.complex(1.0,-1.0),np.complex(4.0,0.0)},np.complex128)
 local b=np.array({np.complex(-1.0,1.0),np.complex(0.0,3.0),np.complex(-1.0,-1.0),np.complex(1.0,-0.0),np.complex(-1.0,-1.0),np.complex(1.0,-1.0)},np.complex64)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 310 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex logical_xor values 310')
end
do -- logical_xor 311
 local a=np.array({np.complex(2.0,0.0),np.complex(4.0,0.0),np.complex(-0.0,0.0),np.complex(1.0,0.0),np.complex(4.0,-0.0),np.complex(-3.0,3.0)},np.complex64)
 local b=np.array({np.complex(1.0,0.5),np.complex(0.25,1.0),np.complex(-3.0,-0.0),np.complex(-3.0,3.0),np.complex(0.0,-1.0),np.complex(-3.0,0.0)},np.complex64)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 311 '..r.dtype)
 assert(exact(r:tolist(),{false,false,true,false,false,false}),'complex logical_xor values 311')
end
do -- logical_xor 312
 local a=np.array({np.complex(-3.0,-3.0),np.complex(0.25,-3.0),np.complex(0.0,-0.0),np.complex(-1.0,3.0),np.complex(4.0,-1.0),np.complex(2.0,1.0)},np.complex128)
 local b=np.array({-1.0,-1.0,-0.0,2.0,0.5,-0.0},np.float16)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 312 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,true}),'complex logical_xor values 312')
end
do -- logical_xor 313
 local a=np.array({np.complex(-3.0,0.0),np.complex(4.0,-0.0),np.complex(1.0,0.5),np.complex(-2.0,-0.0),np.complex(-2.0,-1.0),np.complex(0.0,-0.0)},np.complex128)
 local b=np.array({np.complex(-3.0,0.5),np.complex(-3.0,0.0),np.complex(1.0,-0.0),np.complex(2.0,0.0),np.complex(1.0,-3.0),np.complex(1.0,3.0)},np.complex64)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 313 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,true}),'complex logical_xor values 313')
end
do -- logical_xor 314
 local a=np.array({np.complex(1.0,3.0),np.complex(2.0,0.5),np.complex(-0.0,-0.0),np.complex(-2.0,3.0),np.complex(2.0,-0.0),np.complex(-1.0,-1.0)},np.complex128)
 local b=np.array({0.0,-0.0,0.5,-1.0,2.0,0.0},np.float64)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 314 '..r.dtype)
 assert(exact(r:tolist(),{true,true,true,false,false,true}),'complex logical_xor values 314')
end
do -- logical_xor 315
 local a=np.array({np.complex(-1.0,0.5),np.complex(0.0,-0.0),np.complex(-0.0,0.0),np.complex(-1.0,0.0),np.complex(-3.0,1.0),np.complex(0.25,0.5)},np.complex64)
 local b=np.array({np.complex(0.0,-1.0),np.complex(0.0,-3.0),np.complex(0.0,0.5),np.complex(4.0,0.5),np.complex(1.0,1.0),np.complex(1.0,0.5)},np.complex128)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 315 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,false,false,false}),'complex logical_xor values 315')
end
do -- logical_xor 316
 local a=np.array({np.complex(0.0,-1.0),np.complex(-0.0,0.0),np.complex(-1.0,-3.0),np.complex(0.0,-0.0),np.complex(0.0,-0.0),np.complex(-3.0,-0.0)},np.complex128)
 local b=np.array({0.5,1.0,0.0,0.0,4.0,4.0},np.float16)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 316 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,false,true,false}),'complex logical_xor values 316')
end
do -- logical_xor 317
 local a=np.array({np.complex(2.0,1.0),np.complex(-0.0,0.0),np.complex(0.0,-3.0),np.complex(-0.0,0.5),np.complex(2.0,3.0),np.complex(1.0,-3.0)},np.complex64)
 local b=np.array({-1.0,-0.0,4.0,-0.0,1.0,2.0},np.float32)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 317 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,true,false,false}),'complex logical_xor values 317')
end
do -- logical_xor 318
 local a=np.array({np.complex(-0.0,-1.0),np.complex(-3.0,3.0),np.complex(0.0,0.0),np.complex(0.0,-1.0),np.complex(-3.0,0.5),np.complex(-2.0,3.0)},np.complex128)
 local b=np.array({0.5,2.0,-1.0,0.0,-0.0,-0.0},np.float16)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 318 '..r.dtype)
 assert(exact(r:tolist(),{false,false,true,true,true,true}),'complex logical_xor values 318')
end
do -- logical_xor 319
 local a=np.array({np.complex(2.0,-3.0),np.complex(2.0,-1.0),np.complex(0.25,0.0),np.complex(2.0,-1.0),np.complex(4.0,-0.0),np.complex(-2.0,-0.0)},np.complex64)
 local b=np.array({np.complex(1.0,-0.0),np.complex(-3.0,-0.0),np.complex(-0.0,3.0),np.complex(-0.0,0.0),np.complex(0.0,0.5),np.complex(2.0,1.0)},np.complex128)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 319 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,true,false,false}),'complex logical_xor values 319')
end
do -- logical_xor 320
 local a=np.array({np.complex(1.0,-1.0),np.complex(-1.0,-0.0),np.complex(4.0,1.0),np.complex(2.0,1.0),np.complex(2.0,-3.0),np.complex(4.0,1.0)},np.complex128)
 local b=np.array({4.0,0.5,0.0,0.5,0.5,-3.0},np.float64)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 320 '..r.dtype)
 assert(exact(r:tolist(),{false,false,true,false,false,false}),'complex logical_xor values 320')
end
do -- logical_xor 321
 local a=np.array({np.complex(-3.0,-0.0),np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0),np.complex(1.0,1.0),np.complex(-0.0,-1.0)},np.complex64)
 local b=np.array({np.complex(-0.0,1.0),np.complex(-3.0,-3.0),np.complex(-1.0,-1.0),np.complex(0.25,-3.0),np.complex(-2.0,0.5),np.complex(4.0,0.0)},np.complex64)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 321 '..r.dtype)
 assert(exact(r:tolist(),{false,true,true,true,false,false}),'complex logical_xor values 321')
end
do -- logical_xor 322
 local a=np.array({np.complex(-2.0,1.0),np.complex(-2.0,3.0),np.complex(4.0,-1.0),np.complex(0.0,0.5),np.complex(1.0,1.0),np.complex(-3.0,-1.0)},np.complex64)
 local b=np.array({np.complex(-3.0,0.0),np.complex(4.0,3.0),np.complex(-1.0,1.0),np.complex(-0.0,1.0),np.complex(-3.0,0.5),np.complex(0.25,1.0)},np.complex64)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 322 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex logical_xor values 322')
end
do -- logical_xor 323
 local a=np.array({np.complex(0.25,0.0),np.complex(-0.0,-1.0),np.complex(0.0,-0.0),np.complex(0.25,-3.0),np.complex(2.0,0.5),np.complex(-3.0,0.0)},np.complex128)
 local b=np.array({np.complex(1.0,0.0),np.complex(0.0,3.0),np.complex(4.0,-1.0),np.complex(2.0,-0.0),np.complex(-3.0,0.0),np.complex(-2.0,-3.0)},np.complex128)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 323 '..r.dtype)
 assert(exact(r:tolist(),{false,false,true,false,false,false}),'complex logical_xor values 323')
end
do -- logical_xor 324
 local a=np.array({np.complex(-3.0,-1.0),np.complex(-1.0,0.0),np.complex(-1.0,3.0),np.complex(4.0,1.0),np.complex(-2.0,1.0),np.complex(0.0,1.0)},np.complex128)
 local b=np.array({2.0,0.5,2.0,4.0,-1.0,0.5},np.float32)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 324 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,false,false,false}),'complex logical_xor values 324')
end
do -- logical_xor 325
 local a=np.array({np.complex(1.0,-3.0),np.complex(-1.0,0.0),np.complex(0.0,0.5),np.complex(-0.0,-0.0),np.complex(-3.0,0.0),np.complex(0.0,1.0)},np.complex128)
 local b=np.array({2.0,2.0,-1.0,0.5,2.0,1.0},np.float16)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 325 '..r.dtype)
 assert(exact(r:tolist(),{false,false,false,true,false,false}),'complex logical_xor values 325')
end
do -- logical_xor 326
 local a=np.array({np.complex(-3.0,0.5),np.complex(-1.0,-3.0),np.complex(-1.0,0.0),np.complex(1.0,-0.0),np.complex(-3.0,1.0),np.complex(-0.0,-1.0)},np.complex64)
 local b=np.array({-0.0,1.0,4.0,-3.0,-3.0,2.0},np.float32)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 326 '..r.dtype)
 assert(exact(r:tolist(),{true,false,false,false,false,false}),'complex logical_xor values 326')
end
do -- logical_xor 327
 local a=np.array({np.complex(-0.0,0.0),np.complex(-1.0,3.0),np.complex(-3.0,-3.0),np.complex(2.0,0.0),np.complex(4.0,0.5),np.complex(0.25,0.0)},np.complex128)
 local b=np.array({np.complex(2.0,1.0),np.complex(4.0,-3.0),np.complex(0.25,3.0),np.complex(1.0,3.0),np.complex(2.0,-3.0),np.complex(-3.0,0.0)},np.complex128)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 327 '..r.dtype)
 assert(exact(r:tolist(),{true,false,false,false,false,false}),'complex logical_xor values 327')
end
do -- logical_xor 328
 local a=np.array({np.complex(4.0,-1.0),np.complex(0.0,3.0),np.complex(1.0,-0.0),np.complex(2.0,-0.0),np.complex(4.0,-1.0),np.complex(-0.0,-3.0)},np.complex64)
 local b=np.array({2.0,0.0,2.0,-0.0,4.0,0.5},np.float64)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 328 '..r.dtype)
 assert(exact(r:tolist(),{false,true,false,true,false,false}),'complex logical_xor values 328')
end
do -- logical_xor 329
 local a=np.array({np.complex(4.0,-3.0),np.complex(2.0,0.5),np.complex(0.0,3.0),np.complex(2.0,-3.0),np.complex(-2.0,3.0),np.complex(0.0,0.5)},np.complex64)
 local b=np.array({0.5,-0.0,4.0,-3.0,-0.0,0.5},np.float32)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 329 '..r.dtype)
 assert(exact(r:tolist(),{false,true,false,false,true,false}),'complex logical_xor values 329')
end
do -- logical_xor 330
 local a=np.array({np.complex(4.0,-1.0),np.complex(0.0,0.5),np.complex(4.0,0.5),np.complex(-3.0,3.0),np.complex(4.0,1.0),np.complex(0.25,0.5)},np.complex64)
 local b=np.array({np.complex(-2.0,-3.0),np.complex(0.0,0.0),np.complex(2.0,-3.0),np.complex(0.25,-3.0),np.complex(2.0,-1.0),np.complex(4.0,-1.0)},np.complex128)
 local r=np.logical_xor(a,b)
 assert(r.dtype=='bool','complex logical_xor dtype 330 '..r.dtype)
 assert(exact(r:tolist(),{false,true,false,false,false,false}),'complex logical_xor values 330')
end
do -- maximum 331
 local a=np.array({np.complex(-2.0,-3.0),np.complex(0.25,-0.0),np.complex(1.0,0.5),np.complex(-2.0,-3.0),np.complex(4.0,1.0),np.complex(-2.0,0.5)},np.complex64)
 local b=np.array({np.complex(0.25,1.0),np.complex(2.0,-0.0),np.complex(-3.0,0.5),np.complex(-3.0,1.0),np.complex(-0.0,0.5),np.complex(4.0,-0.0)},np.complex64)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex64','complex maximum dtype 331 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.25,1.0),np.complex(2.0,-0.0),np.complex(1.0,0.5),np.complex(-2.0,-3.0),np.complex(4.0,1.0),np.complex(4.0,-0.0)},3e-05),'complex maximum values 331')
end
do -- maximum 332
 local a=np.array({np.complex(1.0,-1.0),np.complex(1.0,1.0),np.complex(-3.0,-0.0),np.complex(-0.0,0.0),np.complex(4.0,-1.0),np.complex(-2.0,-1.0)},np.complex64)
 local b=np.array({4.0,2.0,4.0,-0.0,2.0,4.0},np.float64)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex128','complex maximum dtype 332 '..r.dtype)
 assert(close(r:tolist(),{np.complex(4.0,0.0),np.complex(2.0,0.0),np.complex(4.0,0.0),np.complex(-0.0,0.0),np.complex(4.0,-1.0),np.complex(4.0,0.0)},2e-12),'complex maximum values 332')
end
do -- maximum 333
 local a=np.array({np.complex(-0.0,0.0),np.complex(-2.0,-1.0),np.complex(0.25,1.0),np.complex(-3.0,0.5),np.complex(-1.0,1.0),np.complex(-2.0,0.5)},np.complex64)
 local b=np.array({0.5,-0.0,-3.0,-0.0,-0.0,2.0},np.float32)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex64','complex maximum dtype 333 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.5,0.0),np.complex(-0.0,0.0),np.complex(0.25,1.0),np.complex(-0.0,0.0),np.complex(-0.0,0.0),np.complex(2.0,0.0)},3e-05),'complex maximum values 333')
end
do -- maximum 334
 local a=np.array({np.complex(0.0,0.0),np.complex(-3.0,3.0),np.complex(1.0,0.5),np.complex(-0.0,-0.0),np.complex(1.0,-0.0),np.complex(-3.0,1.0)},np.complex128)
 local b=np.array({1.0,0.0,2.0,-3.0,0.5,-3.0},np.float64)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex128','complex maximum dtype 334 '..r.dtype)
 assert(close(r:tolist(),{np.complex(1.0,0.0),np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(-0.0,-0.0),np.complex(1.0,-0.0),np.complex(-3.0,1.0)},2e-12),'complex maximum values 334')
end
do -- maximum 335
 local a=np.array({np.complex(4.0,0.5),np.complex(-3.0,-3.0),np.complex(-2.0,0.5),np.complex(0.0,-3.0),np.complex(-3.0,-3.0),np.complex(0.25,-3.0)},np.complex64)
 local b=np.array({np.complex(2.0,0.5),np.complex(-3.0,3.0),np.complex(-0.0,0.5),np.complex(1.0,-0.0),np.complex(2.0,1.0),np.complex(1.0,0.5)},np.complex128)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex128','complex maximum dtype 335 '..r.dtype)
 assert(close(r:tolist(),{np.complex(4.0,0.5),np.complex(-3.0,3.0),np.complex(-0.0,0.5),np.complex(1.0,-0.0),np.complex(2.0,1.0),np.complex(1.0,0.5)},2e-12),'complex maximum values 335')
end
do -- maximum 336
 local a=np.array({np.complex(0.0,3.0),np.complex(-2.0,0.5),np.complex(2.0,0.0),np.complex(-2.0,0.5),np.complex(1.0,-1.0),np.complex(-3.0,-0.0)},np.complex64)
 local b=np.array({-1.0,4.0,0.5,-3.0,1.0,0.5},np.float32)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex64','complex maximum dtype 336 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,3.0),np.complex(4.0,0.0),np.complex(2.0,0.0),np.complex(-2.0,0.5),np.complex(1.0,0.0),np.complex(0.5,0.0)},3e-05),'complex maximum values 336')
end
do -- maximum 337
 local a=np.array({np.complex(0.25,-1.0),np.complex(4.0,0.5),np.complex(-2.0,-0.0),np.complex(1.0,3.0),np.complex(-3.0,-3.0),np.complex(1.0,3.0)},np.complex64)
 local b=np.array({-3.0,-3.0,4.0,-1.0,0.0,2.0},np.float16)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex64','complex maximum dtype 337 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.25,-1.0),np.complex(4.0,0.5),np.complex(4.0,0.0),np.complex(1.0,3.0),np.complex(0.0,0.0),np.complex(2.0,0.0)},3e-05),'complex maximum values 337')
end
do -- maximum 338
 local a=np.array({np.complex(-2.0,-1.0),np.complex(-1.0,1.0),np.complex(2.0,1.0),np.complex(0.0,0.5),np.complex(0.25,-0.0),np.complex(-0.0,-1.0)},np.complex64)
 local b=np.array({np.complex(-1.0,0.5),np.complex(-1.0,-1.0),np.complex(4.0,0.5),np.complex(0.0,0.5),np.complex(2.0,-0.0),np.complex(2.0,0.0)},np.complex128)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex128','complex maximum dtype 338 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-1.0,0.5),np.complex(-1.0,1.0),np.complex(4.0,0.5),np.complex(0.0,0.5),np.complex(2.0,-0.0),np.complex(2.0,0.0)},2e-12),'complex maximum values 338')
end
do -- maximum 339
 local a=np.array({np.complex(-1.0,-3.0),np.complex(2.0,1.0),np.complex(-0.0,-3.0),np.complex(-3.0,-1.0),np.complex(-0.0,3.0),np.complex(1.0,-3.0)},np.complex64)
 local b=np.array({4.0,4.0,0.5,0.5,4.0,0.0},np.float32)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex64','complex maximum dtype 339 '..r.dtype)
 assert(close(r:tolist(),{np.complex(4.0,0.0),np.complex(4.0,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(4.0,0.0),np.complex(1.0,-3.0)},3e-05),'complex maximum values 339')
end
do -- maximum 340
 local a=np.array({np.complex(1.0,0.5),np.complex(-2.0,1.0),np.complex(0.25,-0.0),np.complex(-3.0,0.5),np.complex(-3.0,-0.0),np.complex(1.0,-1.0)},np.complex128)
 local b=np.array({2.0,2.0,2.0,-3.0,2.0,0.0},np.float64)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex128','complex maximum dtype 340 '..r.dtype)
 assert(close(r:tolist(),{np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(-3.0,0.5),np.complex(2.0,0.0),np.complex(1.0,-1.0)},2e-12),'complex maximum values 340')
end
do -- maximum 341
 local a=np.array({np.complex(-0.0,0.0),np.complex(-2.0,-1.0),np.complex(-2.0,1.0),np.complex(2.0,-3.0),np.complex(4.0,-0.0),np.complex(0.25,-1.0)},np.complex64)
 local b=np.array({1.0,-0.0,0.5,-1.0,1.0,-1.0},np.float32)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex64','complex maximum dtype 341 '..r.dtype)
 assert(close(r:tolist(),{np.complex(1.0,0.0),np.complex(-0.0,0.0),np.complex(0.5,0.0),np.complex(2.0,-3.0),np.complex(4.0,-0.0),np.complex(0.25,-1.0)},3e-05),'complex maximum values 341')
end
do -- maximum 342
 local a=np.array({np.complex(-3.0,3.0),np.complex(-3.0,1.0),np.complex(2.0,0.0),np.complex(-2.0,-1.0),np.complex(0.25,3.0),np.complex(0.25,-1.0)},np.complex128)
 local b=np.array({np.complex(0.25,3.0),np.complex(0.25,0.0),np.complex(-2.0,-3.0),np.complex(-2.0,0.5),np.complex(0.0,3.0),np.complex(-2.0,-3.0)},np.complex128)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex128','complex maximum dtype 342 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.25,3.0),np.complex(0.25,0.0),np.complex(2.0,0.0),np.complex(-2.0,0.5),np.complex(0.25,3.0),np.complex(0.25,-1.0)},2e-12),'complex maximum values 342')
end
do -- maximum 343
 local a=np.array({np.complex(-2.0,3.0),np.complex(2.0,-3.0),np.complex(-1.0,0.0),np.complex(2.0,0.0),np.complex(-3.0,1.0),np.complex(-2.0,3.0)},np.complex64)
 local b=np.array({np.complex(1.0,1.0),np.complex(1.0,-0.0),np.complex(4.0,3.0),np.complex(-2.0,0.5),np.complex(-3.0,-1.0),np.complex(-3.0,0.0)},np.complex128)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex128','complex maximum dtype 343 '..r.dtype)
 assert(close(r:tolist(),{np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(4.0,3.0),np.complex(2.0,0.0),np.complex(-3.0,1.0),np.complex(-2.0,3.0)},2e-12),'complex maximum values 343')
end
do -- maximum 344
 local a=np.array({np.complex(4.0,0.5),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(4.0,-1.0),np.complex(-0.0,1.0),np.complex(1.0,1.0)},np.complex64)
 local b=np.array({-0.0,-0.0,-3.0,1.0,4.0,4.0},np.float64)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex128','complex maximum dtype 344 '..r.dtype)
 assert(close(r:tolist(),{np.complex(4.0,0.5),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(4.0,-1.0),np.complex(4.0,0.0),np.complex(4.0,0.0)},2e-12),'complex maximum values 344')
end
do -- maximum 345
 local a=np.array({np.complex(2.0,-1.0),np.complex(4.0,-1.0),np.complex(-2.0,-0.0),np.complex(-3.0,-1.0),np.complex(0.0,3.0),np.complex(0.0,1.0)},np.complex64)
 local b=np.array({-0.0,-3.0,0.0,1.0,2.0,-0.0},np.float16)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex64','complex maximum dtype 345 '..r.dtype)
 assert(close(r:tolist(),{np.complex(2.0,-1.0),np.complex(4.0,-1.0),np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(0.0,1.0)},3e-05),'complex maximum values 345')
end
do -- maximum 346
 local a=np.array({np.complex(-3.0,-3.0),np.complex(-1.0,0.5),np.complex(2.0,-0.0),np.complex(1.0,0.5),np.complex(-2.0,0.5),np.complex(0.25,0.0)},np.complex128)
 local b=np.array({-0.0,0.0,4.0,0.0,0.5,0.5},np.float64)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex128','complex maximum dtype 346 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-0.0,0.0),np.complex(0.0,0.0),np.complex(4.0,0.0),np.complex(1.0,0.5),np.complex(0.5,0.0),np.complex(0.5,0.0)},2e-12),'complex maximum values 346')
end
do -- maximum 347
 local a=np.array({np.complex(-0.0,0.5),np.complex(0.0,0.0),np.complex(2.0,-3.0),np.complex(-0.0,3.0),np.complex(1.0,0.5),np.complex(-1.0,0.0)},np.complex64)
 local b=np.array({-3.0,4.0,4.0,0.5,1.0,4.0},np.float64)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex128','complex maximum dtype 347 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-0.0,0.5),np.complex(4.0,0.0),np.complex(4.0,0.0),np.complex(0.5,0.0),np.complex(1.0,0.5),np.complex(4.0,0.0)},2e-12),'complex maximum values 347')
end
do -- maximum 348
 local a=np.array({np.complex(0.0,0.0),np.complex(0.25,1.0),np.complex(1.0,-0.0),np.complex(1.0,1.0),np.complex(-3.0,1.0),np.complex(1.0,0.5)},np.complex64)
 local b=np.array({4.0,4.0,-3.0,-3.0,4.0,4.0},np.float64)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex128','complex maximum dtype 348 '..r.dtype)
 assert(close(r:tolist(),{np.complex(4.0,0.0),np.complex(4.0,0.0),np.complex(1.0,-0.0),np.complex(1.0,1.0),np.complex(4.0,0.0),np.complex(4.0,0.0)},2e-12),'complex maximum values 348')
end
do -- maximum 349
 local a=np.array({np.complex(-1.0,3.0),np.complex(-1.0,0.0),np.complex(-2.0,-3.0),np.complex(2.0,1.0),np.complex(4.0,-3.0),np.complex(-1.0,3.0)},np.complex64)
 local b=np.array({np.complex(0.25,-3.0),np.complex(1.0,-3.0),np.complex(0.25,-3.0),np.complex(-1.0,-1.0),np.complex(0.25,-3.0),np.complex(4.0,-1.0)},np.complex128)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex128','complex maximum dtype 349 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.25,-3.0),np.complex(1.0,-3.0),np.complex(0.25,-3.0),np.complex(2.0,1.0),np.complex(4.0,-3.0),np.complex(4.0,-1.0)},2e-12),'complex maximum values 349')
end
do -- maximum 350
 local a=np.array({np.complex(0.0,0.5),np.complex(2.0,-1.0),np.complex(1.0,1.0),np.complex(-2.0,0.0),np.complex(2.0,1.0),np.complex(-0.0,0.0)},np.complex128)
 local b=np.array({-0.0,4.0,-0.0,0.0,0.5,-1.0},np.float32)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex128','complex maximum dtype 350 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,0.5),np.complex(4.0,0.0),np.complex(1.0,1.0),np.complex(0.0,0.0),np.complex(2.0,1.0),np.complex(-0.0,0.0)},2e-12),'complex maximum values 350')
end
do -- maximum 351
 local a=np.array({np.complex(2.0,3.0),np.complex(-1.0,1.0),np.complex(-1.0,-3.0),np.complex(1.0,1.0),np.complex(0.0,0.5),np.complex(4.0,-0.0)},np.complex64)
 local b=np.array({np.complex(2.0,-1.0),np.complex(-3.0,0.5),np.complex(0.25,-1.0),np.complex(1.0,0.0),np.complex(0.0,0.5),np.complex(2.0,-1.0)},np.complex64)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex64','complex maximum dtype 351 '..r.dtype)
 assert(close(r:tolist(),{np.complex(2.0,3.0),np.complex(-1.0,1.0),np.complex(0.25,-1.0),np.complex(1.0,1.0),np.complex(0.0,0.5),np.complex(4.0,-0.0)},3e-05),'complex maximum values 351')
end
do -- maximum 352
 local a=np.array({np.complex(0.25,-0.0),np.complex(-2.0,-0.0),np.complex(-2.0,3.0),np.complex(0.25,-1.0),np.complex(0.25,-0.0),np.complex(-1.0,3.0)},np.complex128)
 local b=np.array({0.5,4.0,-1.0,-0.0,-1.0,0.5},np.float16)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex128','complex maximum dtype 352 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.5,0.0),np.complex(4.0,0.0),np.complex(-1.0,0.0),np.complex(0.25,-1.0),np.complex(0.25,-0.0),np.complex(0.5,0.0)},2e-12),'complex maximum values 352')
end
do -- maximum 353
 local a=np.array({np.complex(1.0,-3.0),np.complex(0.25,3.0),np.complex(0.0,-3.0),np.complex(4.0,0.5),np.complex(-3.0,1.0),np.complex(-1.0,0.0)},np.complex128)
 local b=np.array({0.0,-1.0,1.0,-1.0,4.0,1.0},np.float32)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex128','complex maximum dtype 353 '..r.dtype)
 assert(close(r:tolist(),{np.complex(1.0,-3.0),np.complex(0.25,3.0),np.complex(1.0,0.0),np.complex(4.0,0.5),np.complex(4.0,0.0),np.complex(1.0,0.0)},2e-12),'complex maximum values 353')
end
do -- maximum 354
 local a=np.array({np.complex(2.0,-3.0),np.complex(-2.0,-1.0),np.complex(-0.0,0.5),np.complex(4.0,3.0),np.complex(-2.0,-1.0),np.complex(-3.0,0.5)},np.complex64)
 local b=np.array({0.0,2.0,1.0,-1.0,4.0,2.0},np.float64)
 local r=np.maximum(a,b)
 assert(r.dtype=='complex128','complex maximum dtype 354 '..r.dtype)
 assert(close(r:tolist(),{np.complex(2.0,-3.0),np.complex(2.0,0.0),np.complex(1.0,0.0),np.complex(4.0,3.0),np.complex(4.0,0.0),np.complex(2.0,0.0)},2e-12),'complex maximum values 354')
end
do -- minimum 355
 local a=np.array({np.complex(-2.0,3.0),np.complex(2.0,-1.0),np.complex(0.25,-0.0),np.complex(-0.0,-0.0),np.complex(4.0,-1.0),np.complex(1.0,3.0)},np.complex64)
 local b=np.array({np.complex(-0.0,-0.0),np.complex(0.25,0.5),np.complex(-2.0,-3.0),np.complex(-1.0,1.0),np.complex(0.25,1.0),np.complex(-3.0,0.0)},np.complex128)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex128','complex minimum dtype 355 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-2.0,3.0),np.complex(0.25,0.5),np.complex(-2.0,-3.0),np.complex(-1.0,1.0),np.complex(0.25,1.0),np.complex(-3.0,0.0)},2e-12),'complex minimum values 355')
end
do -- minimum 356
 local a=np.array({np.complex(0.25,-1.0),np.complex(1.0,-1.0),np.complex(-2.0,-3.0),np.complex(2.0,0.5),np.complex(-1.0,-0.0),np.complex(0.0,0.0)},np.complex128)
 local b=np.array({0.0,-0.0,4.0,0.5,-1.0,-3.0},np.float16)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex128','complex minimum dtype 356 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(-2.0,-3.0),np.complex(0.5,0.0),np.complex(-1.0,-0.0),np.complex(-3.0,0.0)},2e-12),'complex minimum values 356')
end
do -- minimum 357
 local a=np.array({np.complex(-2.0,-0.0),np.complex(2.0,-1.0),np.complex(0.25,0.0),np.complex(-2.0,-1.0),np.complex(-1.0,-0.0),np.complex(0.25,0.5)},np.complex128)
 local b=np.array({np.complex(2.0,3.0),np.complex(4.0,-3.0),np.complex(0.25,-0.0),np.complex(-2.0,0.5),np.complex(4.0,-1.0),np.complex(0.0,-1.0)},np.complex128)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex128','complex minimum dtype 357 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-2.0,-0.0),np.complex(2.0,-1.0),np.complex(0.25,0.0),np.complex(-2.0,-1.0),np.complex(-1.0,-0.0),np.complex(0.0,-1.0)},2e-12),'complex minimum values 357')
end
do -- minimum 358
 local a=np.array({np.complex(0.25,3.0),np.complex(1.0,-3.0),np.complex(-2.0,-0.0),np.complex(-1.0,0.5),np.complex(4.0,3.0),np.complex(-0.0,0.0)},np.complex64)
 local b=np.array({-1.0,1.0,0.5,0.0,-1.0,-0.0},np.float64)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex128','complex minimum dtype 358 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-1.0,0.0),np.complex(1.0,-3.0),np.complex(-2.0,-0.0),np.complex(-1.0,0.5),np.complex(-1.0,0.0),np.complex(-0.0,0.0)},2e-12),'complex minimum values 358')
end
do -- minimum 359
 local a=np.array({np.complex(0.25,-3.0),np.complex(0.25,0.5),np.complex(-3.0,-1.0),np.complex(-0.0,0.0),np.complex(1.0,0.0),np.complex(4.0,-0.0)},np.complex64)
 local b=np.array({np.complex(0.0,1.0),np.complex(2.0,0.0),np.complex(0.25,-0.0),np.complex(0.25,-0.0),np.complex(-1.0,3.0),np.complex(4.0,3.0)},np.complex128)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex128','complex minimum dtype 359 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,1.0),np.complex(0.25,0.5),np.complex(-3.0,-1.0),np.complex(-0.0,0.0),np.complex(-1.0,3.0),np.complex(4.0,-0.0)},2e-12),'complex minimum values 359')
end
do -- minimum 360
 local a=np.array({np.complex(-3.0,-3.0),np.complex(2.0,-3.0),np.complex(-0.0,1.0),np.complex(2.0,-0.0),np.complex(4.0,0.0),np.complex(-3.0,3.0)},np.complex64)
 local b=np.array({0.5,0.0,0.0,4.0,-0.0,-3.0},np.float64)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex128','complex minimum dtype 360 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-3.0,-3.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(2.0,-0.0),np.complex(-0.0,0.0),np.complex(-3.0,0.0)},2e-12),'complex minimum values 360')
end
do -- minimum 361
 local a=np.array({np.complex(0.25,-1.0),np.complex(-3.0,1.0),np.complex(-3.0,1.0),np.complex(-3.0,3.0),np.complex(-3.0,3.0),np.complex(0.25,-0.0)},np.complex64)
 local b=np.array({np.complex(-3.0,-0.0),np.complex(1.0,0.0),np.complex(-0.0,-0.0),np.complex(4.0,-1.0),np.complex(2.0,1.0),np.complex(2.0,3.0)},np.complex64)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex64','complex minimum dtype 361 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-3.0,-0.0),np.complex(-3.0,1.0),np.complex(-3.0,1.0),np.complex(-3.0,3.0),np.complex(-3.0,3.0),np.complex(0.25,-0.0)},3e-05),'complex minimum values 361')
end
do -- minimum 362
 local a=np.array({np.complex(-0.0,3.0),np.complex(0.25,-3.0),np.complex(0.25,-1.0),np.complex(-1.0,0.0),np.complex(-3.0,0.0),np.complex(-3.0,-0.0)},np.complex64)
 local b=np.array({np.complex(-2.0,0.5),np.complex(-1.0,1.0),np.complex(-2.0,3.0),np.complex(0.0,-3.0),np.complex(0.0,1.0),np.complex(1.0,0.5)},np.complex64)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex64','complex minimum dtype 362 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-2.0,0.5),np.complex(-1.0,1.0),np.complex(-2.0,3.0),np.complex(-1.0,0.0),np.complex(-3.0,0.0),np.complex(-3.0,-0.0)},3e-05),'complex minimum values 362')
end
do -- minimum 363
 local a=np.array({np.complex(-2.0,0.5),np.complex(-0.0,1.0),np.complex(2.0,-1.0),np.complex(0.0,-1.0),np.complex(-1.0,-0.0),np.complex(-0.0,-1.0)},np.complex128)
 local b=np.array({-1.0,2.0,4.0,0.5,0.5,4.0},np.float32)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex128','complex minimum dtype 363 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-2.0,0.5),np.complex(-0.0,1.0),np.complex(2.0,-1.0),np.complex(0.0,-1.0),np.complex(-1.0,-0.0),np.complex(-0.0,-1.0)},2e-12),'complex minimum values 363')
end
do -- minimum 364
 local a=np.array({np.complex(0.0,-0.0),np.complex(-0.0,0.5),np.complex(2.0,-1.0),np.complex(-1.0,-0.0),np.complex(-2.0,0.5),np.complex(0.0,-3.0)},np.complex128)
 local b=np.array({np.complex(0.25,-1.0),np.complex(0.25,-1.0),np.complex(0.25,0.0),np.complex(4.0,3.0),np.complex(-3.0,1.0),np.complex(-2.0,-3.0)},np.complex128)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex128','complex minimum dtype 364 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,-0.0),np.complex(-0.0,0.5),np.complex(0.25,0.0),np.complex(-1.0,-0.0),np.complex(-3.0,1.0),np.complex(-2.0,-3.0)},2e-12),'complex minimum values 364')
end
do -- minimum 365
 local a=np.array({np.complex(1.0,1.0),np.complex(0.0,-1.0),np.complex(-1.0,-3.0),np.complex(-2.0,0.0),np.complex(-2.0,-3.0),np.complex(-3.0,3.0)},np.complex128)
 local b=np.array({-0.0,2.0,0.5,0.5,-0.0,-1.0},np.float16)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex128','complex minimum dtype 365 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-0.0,0.0),np.complex(0.0,-1.0),np.complex(-1.0,-3.0),np.complex(-2.0,0.0),np.complex(-2.0,-3.0),np.complex(-3.0,3.0)},2e-12),'complex minimum values 365')
end
do -- minimum 366
 local a=np.array({np.complex(4.0,0.0),np.complex(-3.0,-1.0),np.complex(1.0,-3.0),np.complex(4.0,-1.0),np.complex(1.0,-3.0),np.complex(2.0,1.0)},np.complex64)
 local b=np.array({0.0,2.0,0.0,-0.0,-0.0,-3.0},np.float64)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex128','complex minimum dtype 366 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,0.0),np.complex(-3.0,-1.0),np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(-0.0,0.0),np.complex(-3.0,0.0)},2e-12),'complex minimum values 366')
end
do -- minimum 367
 local a=np.array({np.complex(1.0,1.0),np.complex(0.0,-0.0),np.complex(0.0,1.0),np.complex(-2.0,1.0),np.complex(-1.0,3.0),np.complex(4.0,-0.0)},np.complex128)
 local b=np.array({np.complex(0.0,0.0),np.complex(0.0,0.5),np.complex(-3.0,3.0),np.complex(0.0,-3.0),np.complex(-2.0,-1.0),np.complex(0.0,0.5)},np.complex128)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex128','complex minimum dtype 367 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(-3.0,3.0),np.complex(-2.0,1.0),np.complex(-2.0,-1.0),np.complex(0.0,0.5)},2e-12),'complex minimum values 367')
end
do -- minimum 368
 local a=np.array({np.complex(2.0,-0.0),np.complex(1.0,-0.0),np.complex(0.25,0.0),np.complex(-1.0,1.0),np.complex(-0.0,1.0),np.complex(-0.0,-0.0)},np.complex128)
 local b=np.array({0.0,4.0,-0.0,0.5,-1.0,1.0},np.float16)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex128','complex minimum dtype 368 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,0.0),np.complex(1.0,-0.0),np.complex(-0.0,0.0),np.complex(-1.0,1.0),np.complex(-1.0,0.0),np.complex(-0.0,-0.0)},2e-12),'complex minimum values 368')
end
do -- minimum 369
 local a=np.array({np.complex(1.0,1.0),np.complex(1.0,1.0),np.complex(0.0,-3.0),np.complex(-1.0,0.5),np.complex(4.0,-1.0),np.complex(1.0,-1.0)},np.complex128)
 local b=np.array({np.complex(-2.0,-1.0),np.complex(-3.0,1.0),np.complex(0.25,0.0),np.complex(4.0,0.5),np.complex(0.0,0.0),np.complex(-1.0,-3.0)},np.complex128)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex128','complex minimum dtype 369 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-2.0,-1.0),np.complex(-3.0,1.0),np.complex(0.0,-3.0),np.complex(-1.0,0.5),np.complex(0.0,0.0),np.complex(-1.0,-3.0)},2e-12),'complex minimum values 369')
end
do -- minimum 370
 local a=np.array({np.complex(-0.0,-1.0),np.complex(4.0,-1.0),np.complex(0.25,-1.0),np.complex(4.0,1.0),np.complex(-0.0,-0.0),np.complex(-2.0,-0.0)},np.complex64)
 local b=np.array({2.0,0.5,-1.0,-1.0,-3.0,1.0},np.float32)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex64','complex minimum dtype 370 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-0.0,-1.0),np.complex(0.5,0.0),np.complex(-1.0,0.0),np.complex(-1.0,0.0),np.complex(-3.0,0.0),np.complex(-2.0,-0.0)},3e-05),'complex minimum values 370')
end
do -- minimum 371
 local a=np.array({np.complex(-0.0,3.0),np.complex(-2.0,0.0),np.complex(-1.0,-0.0),np.complex(1.0,0.5),np.complex(4.0,1.0),np.complex(4.0,3.0)},np.complex128)
 local b=np.array({np.complex(0.25,0.0),np.complex(-3.0,-1.0),np.complex(-0.0,-1.0),np.complex(0.0,0.0),np.complex(2.0,-3.0),np.complex(-2.0,0.0)},np.complex64)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex128','complex minimum dtype 371 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-0.0,3.0),np.complex(-3.0,-1.0),np.complex(-1.0,-0.0),np.complex(0.0,0.0),np.complex(2.0,-3.0),np.complex(-2.0,0.0)},2e-12),'complex minimum values 371')
end
do -- minimum 372
 local a=np.array({np.complex(-3.0,3.0),np.complex(0.0,-0.0),np.complex(0.25,3.0),np.complex(-1.0,3.0),np.complex(-1.0,-0.0),np.complex(4.0,0.5)},np.complex64)
 local b=np.array({np.complex(0.25,0.0),np.complex(-0.0,-3.0),np.complex(2.0,-1.0),np.complex(-2.0,0.0),np.complex(0.25,1.0),np.complex(0.0,-3.0)},np.complex128)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex128','complex minimum dtype 372 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-3.0,3.0),np.complex(-0.0,-3.0),np.complex(0.25,3.0),np.complex(-2.0,0.0),np.complex(-1.0,-0.0),np.complex(0.0,-3.0)},2e-12),'complex minimum values 372')
end
do -- minimum 373
 local a=np.array({np.complex(1.0,-1.0),np.complex(-0.0,0.5),np.complex(-2.0,3.0),np.complex(0.25,-3.0),np.complex(4.0,0.5),np.complex(2.0,1.0)},np.complex64)
 local b=np.array({0.5,1.0,-0.0,0.5,-3.0,-3.0},np.float64)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex128','complex minimum dtype 373 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.5,0.0),np.complex(-0.0,0.5),np.complex(-2.0,3.0),np.complex(0.25,-3.0),np.complex(-3.0,0.0),np.complex(-3.0,0.0)},2e-12),'complex minimum values 373')
end
do -- minimum 374
 local a=np.array({np.complex(0.25,0.0),np.complex(-2.0,1.0),np.complex(0.0,0.0),np.complex(-2.0,-1.0),np.complex(0.0,0.5),np.complex(-3.0,-3.0)},np.complex64)
 local b=np.array({1.0,-3.0,0.0,4.0,2.0,4.0},np.float64)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex128','complex minimum dtype 374 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.25,0.0),np.complex(-3.0,0.0),np.complex(0.0,0.0),np.complex(-2.0,-1.0),np.complex(0.0,0.5),np.complex(-3.0,-3.0)},2e-12),'complex minimum values 374')
end
do -- minimum 375
 local a=np.array({np.complex(4.0,0.0),np.complex(-2.0,0.0),np.complex(0.25,-0.0),np.complex(2.0,-1.0),np.complex(-3.0,-1.0),np.complex(0.25,0.0)},np.complex64)
 local b=np.array({1.0,4.0,1.0,-3.0,-0.0,0.0},np.float32)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex64','complex minimum dtype 375 '..r.dtype)
 assert(close(r:tolist(),{np.complex(1.0,0.0),np.complex(-2.0,0.0),np.complex(0.25,-0.0),np.complex(-3.0,0.0),np.complex(-3.0,-1.0),np.complex(0.0,0.0)},3e-05),'complex minimum values 375')
end
do -- minimum 376
 local a=np.array({np.complex(1.0,0.0),np.complex(-3.0,0.5),np.complex(0.25,0.5),np.complex(4.0,-0.0),np.complex(-2.0,-1.0),np.complex(1.0,-0.0)},np.complex64)
 local b=np.array({np.complex(0.25,-3.0),np.complex(-2.0,-1.0),np.complex(-3.0,0.0),np.complex(4.0,1.0),np.complex(-3.0,-1.0),np.complex(4.0,0.5)},np.complex128)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex128','complex minimum dtype 376 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.25,-3.0),np.complex(-3.0,0.5),np.complex(-3.0,0.0),np.complex(4.0,-0.0),np.complex(-3.0,-1.0),np.complex(1.0,-0.0)},2e-12),'complex minimum values 376')
end
do -- minimum 377
 local a=np.array({np.complex(-0.0,0.5),np.complex(0.0,-3.0),np.complex(-3.0,-1.0),np.complex(0.0,0.5),np.complex(2.0,1.0),np.complex(-1.0,-0.0)},np.complex128)
 local b=np.array({np.complex(-2.0,0.5),np.complex(1.0,0.0),np.complex(-3.0,-1.0),np.complex(-0.0,-1.0),np.complex(-2.0,-1.0),np.complex(-3.0,1.0)},np.complex64)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex128','complex minimum dtype 377 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-2.0,0.5),np.complex(0.0,-3.0),np.complex(-3.0,-1.0),np.complex(-0.0,-1.0),np.complex(-2.0,-1.0),np.complex(-3.0,1.0)},2e-12),'complex minimum values 377')
end
do -- minimum 378
 local a=np.array({np.complex(2.0,3.0),np.complex(0.0,-1.0),np.complex(-0.0,-0.0),np.complex(-2.0,0.5),np.complex(-2.0,-0.0),np.complex(-1.0,0.0)},np.complex128)
 local b=np.array({0.0,-1.0,-0.0,0.5,-1.0,-3.0},np.float32)
 local r=np.minimum(a,b)
 assert(r.dtype=='complex128','complex minimum dtype 378 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,0.0),np.complex(-1.0,0.0),np.complex(-0.0,-0.0),np.complex(-2.0,0.5),np.complex(-2.0,-0.0),np.complex(-3.0,0.0)},2e-12),'complex minimum values 378')
end
do -- fmax 379
 local a=np.array({np.complex(0.25,-1.0),np.complex(2.0,-0.0),np.complex(-2.0,0.5),np.complex(1.0,-3.0),np.complex(-1.0,-1.0),np.complex(2.0,1.0)},np.complex128)
 local b=np.array({np.complex(-0.0,3.0),np.complex(0.25,0.5),np.complex(4.0,0.0),np.complex(0.25,0.5),np.complex(0.0,3.0),np.complex(2.0,0.0)},np.complex128)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex128','complex fmax dtype 379 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.25,-1.0),np.complex(2.0,-0.0),np.complex(4.0,0.0),np.complex(1.0,-3.0),np.complex(0.0,3.0),np.complex(2.0,1.0)},2e-12),'complex fmax values 379')
end
do -- fmax 380
 local a=np.array({np.complex(-2.0,-1.0),np.complex(-2.0,3.0),np.complex(-3.0,3.0),np.complex(-3.0,-1.0),np.complex(1.0,-3.0),np.complex(0.0,0.0)},np.complex64)
 local b=np.array({2.0,0.0,0.5,-0.0,2.0,-1.0},np.float64)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex128','complex fmax dtype 380 '..r.dtype)
 assert(close(r:tolist(),{np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(0.5,0.0),np.complex(-0.0,0.0),np.complex(2.0,0.0),np.complex(0.0,0.0)},2e-12),'complex fmax values 380')
end
do -- fmax 381
 local a=np.array({np.complex(-2.0,0.5),np.complex(2.0,3.0),np.complex(-2.0,0.5),np.complex(0.25,3.0),np.complex(1.0,0.0),np.complex(0.25,-0.0)},np.complex128)
 local b=np.array({np.complex(0.0,-0.0),np.complex(0.25,-3.0),np.complex(-1.0,3.0),np.complex(4.0,1.0),np.complex(0.25,-1.0),np.complex(1.0,3.0)},np.complex64)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex128','complex fmax dtype 381 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,-0.0),np.complex(2.0,3.0),np.complex(-1.0,3.0),np.complex(4.0,1.0),np.complex(1.0,0.0),np.complex(1.0,3.0)},2e-12),'complex fmax values 381')
end
do -- fmax 382
 local a=np.array({np.complex(-3.0,-0.0),np.complex(-2.0,1.0),np.complex(-0.0,-0.0),np.complex(0.0,-1.0),np.complex(0.25,-3.0),np.complex(1.0,-3.0)},np.complex64)
 local b=np.array({0.0,-3.0,4.0,4.0,1.0,0.5},np.float32)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex64','complex fmax dtype 382 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,0.0),np.complex(-2.0,1.0),np.complex(4.0,0.0),np.complex(4.0,0.0),np.complex(1.0,0.0),np.complex(1.0,-3.0)},3e-05),'complex fmax values 382')
end
do -- fmax 383
 local a=np.array({np.complex(4.0,-0.0),np.complex(-3.0,-0.0),np.complex(1.0,1.0),np.complex(0.25,1.0),np.complex(-0.0,-1.0),np.complex(-1.0,3.0)},np.complex64)
 local b=np.array({-3.0,0.5,0.5,2.0,-0.0,4.0},np.float16)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex64','complex fmax dtype 383 '..r.dtype)
 assert(close(r:tolist(),{np.complex(4.0,-0.0),np.complex(0.5,0.0),np.complex(1.0,1.0),np.complex(2.0,0.0),np.complex(-0.0,0.0),np.complex(4.0,0.0)},3e-05),'complex fmax values 383')
end
do -- fmax 384
 local a=np.array({np.complex(-3.0,-3.0),np.complex(-1.0,-0.0),np.complex(4.0,0.0),np.complex(1.0,1.0),np.complex(-3.0,-0.0),np.complex(0.0,0.5)},np.complex64)
 local b=np.array({np.complex(-3.0,-3.0),np.complex(-3.0,3.0),np.complex(-1.0,0.0),np.complex(-1.0,-0.0),np.complex(-0.0,0.0),np.complex(0.0,1.0)},np.complex64)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex64','complex fmax dtype 384 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-3.0,-3.0),np.complex(-1.0,-0.0),np.complex(4.0,0.0),np.complex(1.0,1.0),np.complex(-0.0,0.0),np.complex(0.0,1.0)},3e-05),'complex fmax values 384')
end
do -- fmax 385
 local a=np.array({np.complex(-3.0,-0.0),np.complex(4.0,-0.0),np.complex(-2.0,0.5),np.complex(0.0,-1.0),np.complex(-2.0,3.0),np.complex(0.25,-1.0)},np.complex128)
 local b=np.array({0.0,-3.0,0.0,2.0,-0.0,1.0},np.float32)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex128','complex fmax dtype 385 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,0.0),np.complex(4.0,-0.0),np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(-0.0,0.0),np.complex(1.0,0.0)},2e-12),'complex fmax values 385')
end
do -- fmax 386
 local a=np.array({np.complex(-3.0,-0.0),np.complex(1.0,0.0),np.complex(0.0,1.0),np.complex(-3.0,-3.0),np.complex(0.25,-1.0),np.complex(-3.0,0.0)},np.complex64)
 local b=np.array({-1.0,-1.0,0.0,4.0,-0.0,2.0},np.float16)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex64','complex fmax dtype 386 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-1.0,0.0),np.complex(1.0,0.0),np.complex(0.0,1.0),np.complex(4.0,0.0),np.complex(0.25,-1.0),np.complex(2.0,0.0)},3e-05),'complex fmax values 386')
end
do -- fmax 387
 local a=np.array({np.complex(0.25,-3.0),np.complex(-0.0,0.0),np.complex(-1.0,0.0),np.complex(-0.0,0.0),np.complex(0.25,-1.0),np.complex(-1.0,0.0)},np.complex128)
 local b=np.array({0.0,0.0,0.5,-0.0,-0.0,-3.0},np.float64)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex128','complex fmax dtype 387 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.25,-3.0),np.complex(-0.0,0.0),np.complex(0.5,0.0),np.complex(-0.0,0.0),np.complex(0.25,-1.0),np.complex(-1.0,0.0)},2e-12),'complex fmax values 387')
end
do -- fmax 388
 local a=np.array({np.complex(-0.0,-0.0),np.complex(-0.0,3.0),np.complex(-1.0,-0.0),np.complex(-1.0,1.0),np.complex(-0.0,-3.0),np.complex(-3.0,0.5)},np.complex128)
 local b=np.array({-1.0,2.0,0.0,0.0,0.5,2.0},np.float64)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex128','complex fmax dtype 388 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-0.0,-0.0),np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.5,0.0),np.complex(2.0,0.0)},2e-12),'complex fmax values 388')
end
do -- fmax 389
 local a=np.array({np.complex(-1.0,-1.0),np.complex(-2.0,-3.0),np.complex(-2.0,0.5),np.complex(4.0,1.0),np.complex(2.0,0.5),np.complex(-1.0,-0.0)},np.complex128)
 local b=np.array({np.complex(-1.0,-1.0),np.complex(-3.0,-1.0),np.complex(-3.0,0.0),np.complex(0.25,0.0),np.complex(-1.0,-0.0),np.complex(4.0,3.0)},np.complex64)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex128','complex fmax dtype 389 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-1.0,-1.0),np.complex(-2.0,-3.0),np.complex(-2.0,0.5),np.complex(4.0,1.0),np.complex(2.0,0.5),np.complex(4.0,3.0)},2e-12),'complex fmax values 389')
end
do -- fmax 390
 local a=np.array({np.complex(-0.0,3.0),np.complex(1.0,-0.0),np.complex(1.0,0.5),np.complex(1.0,-3.0),np.complex(-3.0,-1.0),np.complex(1.0,-1.0)},np.complex128)
 local b=np.array({np.complex(0.25,3.0),np.complex(4.0,1.0),np.complex(0.0,3.0),np.complex(-0.0,3.0),np.complex(4.0,-3.0),np.complex(-0.0,0.5)},np.complex64)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex128','complex fmax dtype 390 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.25,3.0),np.complex(4.0,1.0),np.complex(1.0,0.5),np.complex(1.0,-3.0),np.complex(4.0,-3.0),np.complex(1.0,-1.0)},2e-12),'complex fmax values 390')
end
do -- fmax 391
 local a=np.array({np.complex(-2.0,3.0),np.complex(0.25,0.0),np.complex(4.0,0.0),np.complex(1.0,-3.0),np.complex(-0.0,-1.0),np.complex(1.0,0.0)},np.complex128)
 local b=np.array({np.complex(-3.0,-3.0),np.complex(1.0,0.0),np.complex(0.0,1.0),np.complex(-2.0,3.0),np.complex(-1.0,0.0),np.complex(0.25,1.0)},np.complex128)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex128','complex fmax dtype 391 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-2.0,3.0),np.complex(1.0,0.0),np.complex(4.0,0.0),np.complex(1.0,-3.0),np.complex(-0.0,-1.0),np.complex(1.0,0.0)},2e-12),'complex fmax values 391')
end
do -- fmax 392
 local a=np.array({np.complex(-3.0,1.0),np.complex(0.25,1.0),np.complex(4.0,3.0),np.complex(4.0,3.0),np.complex(-1.0,1.0),np.complex(1.0,-1.0)},np.complex128)
 local b=np.array({np.complex(-1.0,3.0),np.complex(-1.0,3.0),np.complex(-0.0,-3.0),np.complex(0.0,-3.0),np.complex(-2.0,0.5),np.complex(-2.0,0.5)},np.complex128)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex128','complex fmax dtype 392 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-1.0,3.0),np.complex(0.25,1.0),np.complex(4.0,3.0),np.complex(4.0,3.0),np.complex(-1.0,1.0),np.complex(1.0,-1.0)},2e-12),'complex fmax values 392')
end
do -- fmax 393
 local a=np.array({np.complex(-1.0,-1.0),np.complex(0.25,1.0),np.complex(-0.0,3.0),np.complex(-0.0,-0.0),np.complex(0.25,0.5),np.complex(-2.0,0.0)},np.complex128)
 local b=np.array({-3.0,2.0,-0.0,1.0,2.0,0.5},np.float16)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex128','complex fmax dtype 393 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-1.0,-1.0),np.complex(2.0,0.0),np.complex(-0.0,3.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(0.5,0.0)},2e-12),'complex fmax values 393')
end
do -- fmax 394
 local a=np.array({np.complex(-3.0,-3.0),np.complex(-3.0,-0.0),np.complex(0.25,-1.0),np.complex(-0.0,0.0),np.complex(-1.0,0.5),np.complex(2.0,-0.0)},np.complex64)
 local b=np.array({4.0,2.0,1.0,-1.0,-1.0,0.5},np.float32)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex64','complex fmax dtype 394 '..r.dtype)
 assert(close(r:tolist(),{np.complex(4.0,0.0),np.complex(2.0,0.0),np.complex(1.0,0.0),np.complex(-0.0,0.0),np.complex(-1.0,0.5),np.complex(2.0,-0.0)},3e-05),'complex fmax values 394')
end
do -- fmax 395
 local a=np.array({np.complex(-1.0,1.0),np.complex(4.0,-3.0),np.complex(0.0,0.0),np.complex(4.0,-0.0),np.complex(0.25,-3.0),np.complex(-1.0,3.0)},np.complex64)
 local b=np.array({-1.0,4.0,-3.0,4.0,-3.0,0.5},np.float16)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex64','complex fmax dtype 395 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-1.0,1.0),np.complex(4.0,0.0),np.complex(0.0,0.0),np.complex(4.0,-0.0),np.complex(0.25,-3.0),np.complex(0.5,0.0)},3e-05),'complex fmax values 395')
end
do -- fmax 396
 local a=np.array({np.complex(-3.0,3.0),np.complex(-3.0,1.0),np.complex(-1.0,1.0),np.complex(1.0,-3.0),np.complex(1.0,0.5),np.complex(2.0,1.0)},np.complex128)
 local b=np.array({4.0,4.0,2.0,-3.0,4.0,-1.0},np.float32)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex128','complex fmax dtype 396 '..r.dtype)
 assert(close(r:tolist(),{np.complex(4.0,0.0),np.complex(4.0,0.0),np.complex(2.0,0.0),np.complex(1.0,-3.0),np.complex(4.0,0.0),np.complex(2.0,1.0)},2e-12),'complex fmax values 396')
end
do -- fmax 397
 local a=np.array({np.complex(-0.0,0.0),np.complex(-2.0,-0.0),np.complex(2.0,-3.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(-3.0,-3.0)},np.complex64)
 local b=np.array({np.complex(0.0,3.0),np.complex(-2.0,-0.0),np.complex(-3.0,-3.0),np.complex(-0.0,3.0),np.complex(-2.0,3.0),np.complex(4.0,-1.0)},np.complex128)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex128','complex fmax dtype 397 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,3.0),np.complex(-2.0,-0.0),np.complex(2.0,-3.0),np.complex(-0.0,3.0),np.complex(0.0,-0.0),np.complex(4.0,-1.0)},2e-12),'complex fmax values 397')
end
do -- fmax 398
 local a=np.array({np.complex(-0.0,-3.0),np.complex(-0.0,0.5),np.complex(2.0,1.0),np.complex(-0.0,3.0),np.complex(-3.0,0.5),np.complex(0.0,0.0)},np.complex64)
 local b=np.array({np.complex(0.25,-3.0),np.complex(2.0,1.0),np.complex(2.0,3.0),np.complex(-0.0,1.0),np.complex(0.25,-1.0),np.complex(4.0,-3.0)},np.complex64)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex64','complex fmax dtype 398 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.25,-3.0),np.complex(2.0,1.0),np.complex(2.0,3.0),np.complex(-0.0,3.0),np.complex(0.25,-1.0),np.complex(4.0,-3.0)},3e-05),'complex fmax values 398')
end
do -- fmax 399
 local a=np.array({np.complex(-1.0,3.0),np.complex(-3.0,3.0),np.complex(0.0,-0.0),np.complex(4.0,-3.0),np.complex(2.0,1.0),np.complex(-3.0,1.0)},np.complex128)
 local b=np.array({0.5,-0.0,-3.0,-1.0,1.0,1.0},np.float16)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex128','complex fmax dtype 399 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.5,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(4.0,-3.0),np.complex(2.0,1.0),np.complex(1.0,0.0)},2e-12),'complex fmax values 399')
end
do -- fmax 400
 local a=np.array({np.complex(2.0,-0.0),np.complex(1.0,3.0),np.complex(0.25,-1.0),np.complex(2.0,0.5),np.complex(0.25,-0.0),np.complex(4.0,0.5)},np.complex128)
 local b=np.array({0.0,0.0,-0.0,0.0,-3.0,-1.0},np.float32)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex128','complex fmax dtype 400 '..r.dtype)
 assert(close(r:tolist(),{np.complex(2.0,-0.0),np.complex(1.0,3.0),np.complex(0.25,-1.0),np.complex(2.0,0.5),np.complex(0.25,-0.0),np.complex(4.0,0.5)},2e-12),'complex fmax values 400')
end
do -- fmax 401
 local a=np.array({np.complex(-0.0,-0.0),np.complex(0.0,-0.0),np.complex(0.0,-0.0),np.complex(0.0,3.0),np.complex(4.0,-1.0),np.complex(-3.0,3.0)},np.complex128)
 local b=np.array({np.complex(-1.0,-1.0),np.complex(2.0,-3.0),np.complex(2.0,-1.0),np.complex(1.0,3.0),np.complex(0.0,3.0),np.complex(4.0,0.5)},np.complex64)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex128','complex fmax dtype 401 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-0.0,-0.0),np.complex(2.0,-3.0),np.complex(2.0,-1.0),np.complex(1.0,3.0),np.complex(4.0,-1.0),np.complex(4.0,0.5)},2e-12),'complex fmax values 401')
end
do -- fmax 402
 local a=np.array({np.complex(1.0,-3.0),np.complex(-3.0,1.0),np.complex(-0.0,-0.0),np.complex(-3.0,0.0),np.complex(0.25,1.0),np.complex(4.0,-0.0)},np.complex64)
 local b=np.array({np.complex(4.0,-0.0),np.complex(-1.0,1.0),np.complex(0.0,-0.0),np.complex(0.25,1.0),np.complex(4.0,-1.0),np.complex(-0.0,0.0)},np.complex64)
 local r=np.fmax(a,b)
 assert(r.dtype=='complex64','complex fmax dtype 402 '..r.dtype)
 assert(close(r:tolist(),{np.complex(4.0,-0.0),np.complex(-1.0,1.0),np.complex(-0.0,-0.0),np.complex(0.25,1.0),np.complex(4.0,-1.0),np.complex(4.0,-0.0)},3e-05),'complex fmax values 402')
end
do -- fmin 403
 local a=np.array({np.complex(-2.0,-3.0),np.complex(0.0,1.0),np.complex(2.0,0.0),np.complex(2.0,-1.0),np.complex(-0.0,0.0),np.complex(-2.0,0.0)},np.complex128)
 local b=np.array({np.complex(0.25,0.5),np.complex(-0.0,3.0),np.complex(4.0,3.0),np.complex(-2.0,0.0),np.complex(4.0,-1.0),np.complex(2.0,1.0)},np.complex64)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex128','complex fmin dtype 403 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-2.0,-3.0),np.complex(0.0,1.0),np.complex(2.0,0.0),np.complex(-2.0,0.0),np.complex(-0.0,0.0),np.complex(-2.0,0.0)},2e-12),'complex fmin values 403')
end
do -- fmin 404
 local a=np.array({np.complex(2.0,0.0),np.complex(0.0,3.0),np.complex(-3.0,-3.0),np.complex(-3.0,0.5),np.complex(2.0,-3.0),np.complex(0.0,-1.0)},np.complex128)
 local b=np.array({0.5,4.0,0.0,1.0,4.0,1.0},np.float16)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex128','complex fmin dtype 404 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.5,0.0),np.complex(0.0,3.0),np.complex(-3.0,-3.0),np.complex(-3.0,0.5),np.complex(2.0,-3.0),np.complex(0.0,-1.0)},2e-12),'complex fmin values 404')
end
do -- fmin 405
 local a=np.array({np.complex(2.0,0.5),np.complex(-3.0,0.5),np.complex(0.25,3.0),np.complex(4.0,-1.0),np.complex(0.0,-3.0),np.complex(-0.0,1.0)},np.complex64)
 local b=np.array({4.0,4.0,4.0,-3.0,-1.0,1.0},np.float16)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex64','complex fmin dtype 405 '..r.dtype)
 assert(close(r:tolist(),{np.complex(2.0,0.5),np.complex(-3.0,0.5),np.complex(0.25,3.0),np.complex(-3.0,0.0),np.complex(-1.0,0.0),np.complex(-0.0,1.0)},3e-05),'complex fmin values 405')
end
do -- fmin 406
 local a=np.array({np.complex(0.0,3.0),np.complex(-2.0,1.0),np.complex(0.25,0.0),np.complex(-1.0,-0.0),np.complex(0.0,0.5),np.complex(-1.0,0.5)},np.complex64)
 local b=np.array({-3.0,2.0,-0.0,1.0,0.0,2.0},np.float16)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex64','complex fmin dtype 406 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-3.0,0.0),np.complex(-2.0,1.0),np.complex(-0.0,0.0),np.complex(-1.0,-0.0),np.complex(0.0,0.0),np.complex(-1.0,0.5)},3e-05),'complex fmin values 406')
end
do -- fmin 407
 local a=np.array({np.complex(-3.0,-0.0),np.complex(2.0,1.0),np.complex(-0.0,0.5),np.complex(-2.0,-0.0),np.complex(2.0,0.0),np.complex(2.0,0.0)},np.complex64)
 local b=np.array({-0.0,-0.0,4.0,-3.0,-3.0,0.0},np.float16)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex64','complex fmin dtype 407 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-3.0,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,0.5),np.complex(-3.0,0.0),np.complex(-3.0,0.0),np.complex(0.0,0.0)},3e-05),'complex fmin values 407')
end
do -- fmin 408
 local a=np.array({np.complex(-3.0,1.0),np.complex(-1.0,0.5),np.complex(-0.0,-1.0),np.complex(-3.0,-1.0),np.complex(1.0,0.0),np.complex(0.25,3.0)},np.complex64)
 local b=np.array({1.0,0.5,1.0,4.0,-0.0,-3.0},np.float16)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex64','complex fmin dtype 408 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-3.0,1.0),np.complex(-1.0,0.5),np.complex(-0.0,-1.0),np.complex(-3.0,-1.0),np.complex(-0.0,0.0),np.complex(-3.0,0.0)},3e-05),'complex fmin values 408')
end
do -- fmin 409
 local a=np.array({np.complex(0.25,1.0),np.complex(1.0,-0.0),np.complex(0.25,-3.0),np.complex(0.0,-1.0),np.complex(-1.0,-3.0),np.complex(-3.0,1.0)},np.complex128)
 local b=np.array({np.complex(0.0,-0.0),np.complex(-0.0,-0.0),np.complex(-0.0,-3.0),np.complex(-3.0,-0.0),np.complex(-1.0,3.0),np.complex(0.25,3.0)},np.complex64)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex128','complex fmin dtype 409 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,-0.0),np.complex(-0.0,-0.0),np.complex(-0.0,-3.0),np.complex(-3.0,-0.0),np.complex(-1.0,-3.0),np.complex(-3.0,1.0)},2e-12),'complex fmin values 409')
end
do -- fmin 410
 local a=np.array({np.complex(-0.0,-3.0),np.complex(-0.0,-0.0),np.complex(1.0,0.0),np.complex(0.25,0.5),np.complex(0.25,-0.0),np.complex(0.25,0.5)},np.complex64)
 local b=np.array({-1.0,2.0,4.0,2.0,-0.0,0.0},np.float64)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex128','complex fmin dtype 410 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-1.0,0.0),np.complex(-0.0,-0.0),np.complex(1.0,0.0),np.complex(0.25,0.5),np.complex(-0.0,0.0),np.complex(0.0,0.0)},2e-12),'complex fmin values 410')
end
do -- fmin 411
 local a=np.array({np.complex(-0.0,-3.0),np.complex(-3.0,3.0),np.complex(4.0,-3.0),np.complex(-0.0,-3.0),np.complex(0.0,0.5),np.complex(-2.0,-0.0)},np.complex128)
 local b=np.array({np.complex(-3.0,-0.0),np.complex(0.0,-3.0),np.complex(-1.0,1.0),np.complex(1.0,-0.0),np.complex(-0.0,3.0),np.complex(-3.0,-1.0)},np.complex128)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex128','complex fmin dtype 411 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-3.0,-0.0),np.complex(-3.0,3.0),np.complex(-1.0,1.0),np.complex(-0.0,-3.0),np.complex(0.0,0.5),np.complex(-3.0,-1.0)},2e-12),'complex fmin values 411')
end
do -- fmin 412
 local a=np.array({np.complex(0.25,3.0),np.complex(-0.0,-1.0),np.complex(-2.0,3.0),np.complex(0.25,-0.0),np.complex(4.0,1.0),np.complex(-3.0,-0.0)},np.complex64)
 local b=np.array({np.complex(-0.0,-1.0),np.complex(-2.0,0.0),np.complex(0.25,0.5),np.complex(-3.0,-0.0),np.complex(1.0,0.5),np.complex(-3.0,0.0)},np.complex64)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex64','complex fmin dtype 412 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-0.0,-1.0),np.complex(-2.0,0.0),np.complex(-2.0,3.0),np.complex(-3.0,-0.0),np.complex(1.0,0.5),np.complex(-3.0,-0.0)},3e-05),'complex fmin values 412')
end
do -- fmin 413
 local a=np.array({np.complex(1.0,-3.0),np.complex(-3.0,3.0),np.complex(1.0,0.0),np.complex(-2.0,0.0),np.complex(0.25,-0.0),np.complex(-3.0,1.0)},np.complex64)
 local b=np.array({-1.0,2.0,0.0,4.0,4.0,-3.0},np.float64)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex128','complex fmin dtype 413 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-1.0,0.0),np.complex(-3.0,3.0),np.complex(0.0,0.0),np.complex(-2.0,0.0),np.complex(0.25,-0.0),np.complex(-3.0,0.0)},2e-12),'complex fmin values 413')
end
do -- fmin 414
 local a=np.array({np.complex(2.0,0.0),np.complex(-0.0,-0.0),np.complex(1.0,0.0),np.complex(4.0,-0.0),np.complex(-3.0,1.0),np.complex(-2.0,-1.0)},np.complex128)
 local b=np.array({4.0,1.0,-3.0,-1.0,-1.0,-0.0},np.float64)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex128','complex fmin dtype 414 '..r.dtype)
 assert(close(r:tolist(),{np.complex(2.0,0.0),np.complex(-0.0,-0.0),np.complex(-3.0,0.0),np.complex(-1.0,0.0),np.complex(-3.0,1.0),np.complex(-2.0,-1.0)},2e-12),'complex fmin values 414')
end
do -- fmin 415
 local a=np.array({np.complex(0.25,1.0),np.complex(-1.0,0.5),np.complex(2.0,0.5),np.complex(-2.0,-0.0),np.complex(1.0,-0.0),np.complex(4.0,-0.0)},np.complex128)
 local b=np.array({np.complex(0.0,-3.0),np.complex(1.0,3.0),np.complex(2.0,-1.0),np.complex(1.0,1.0),np.complex(1.0,-3.0),np.complex(2.0,1.0)},np.complex128)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex128','complex fmin dtype 415 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,-3.0),np.complex(-1.0,0.5),np.complex(2.0,-1.0),np.complex(-2.0,-0.0),np.complex(1.0,-3.0),np.complex(2.0,1.0)},2e-12),'complex fmin values 415')
end
do -- fmin 416
 local a=np.array({np.complex(-3.0,-3.0),np.complex(4.0,-0.0),np.complex(0.25,-3.0),np.complex(4.0,0.5),np.complex(2.0,0.0),np.complex(-3.0,0.0)},np.complex64)
 local b=np.array({np.complex(-0.0,-0.0),np.complex(-0.0,-1.0),np.complex(0.0,-0.0),np.complex(-0.0,-1.0),np.complex(4.0,1.0),np.complex(-2.0,-1.0)},np.complex64)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex64','complex fmin dtype 416 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-3.0,-3.0),np.complex(-0.0,-1.0),np.complex(0.0,-0.0),np.complex(-0.0,-1.0),np.complex(2.0,0.0),np.complex(-3.0,0.0)},3e-05),'complex fmin values 416')
end
do -- fmin 417
 local a=np.array({np.complex(0.0,0.0),np.complex(-1.0,0.5),np.complex(-0.0,0.0),np.complex(4.0,3.0),np.complex(1.0,-1.0),np.complex(-3.0,0.5)},np.complex64)
 local b=np.array({1.0,-3.0,0.5,1.0,-3.0,4.0},np.float64)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex128','complex fmin dtype 417 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,0.0),np.complex(-3.0,0.0),np.complex(-0.0,0.0),np.complex(1.0,0.0),np.complex(-3.0,0.0),np.complex(-3.0,0.5)},2e-12),'complex fmin values 417')
end
do -- fmin 418
 local a=np.array({np.complex(0.0,-0.0),np.complex(1.0,3.0),np.complex(-3.0,-3.0),np.complex(-3.0,3.0),np.complex(0.0,3.0),np.complex(-3.0,1.0)},np.complex128)
 local b=np.array({4.0,-0.0,1.0,0.5,0.0,1.0},np.float32)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex128','complex fmin dtype 418 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,-0.0),np.complex(-0.0,0.0),np.complex(-3.0,-3.0),np.complex(-3.0,3.0),np.complex(0.0,0.0),np.complex(-3.0,1.0)},2e-12),'complex fmin values 418')
end
do -- fmin 419
 local a=np.array({np.complex(-2.0,-0.0),np.complex(0.25,-3.0),np.complex(4.0,1.0),np.complex(0.25,-0.0),np.complex(1.0,0.5),np.complex(0.0,-1.0)},np.complex128)
 local b=np.array({np.complex(-0.0,0.0),np.complex(4.0,0.5),np.complex(-3.0,0.0),np.complex(1.0,0.0),np.complex(2.0,-3.0),np.complex(-3.0,0.5)},np.complex64)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex128','complex fmin dtype 419 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-2.0,-0.0),np.complex(0.25,-3.0),np.complex(-3.0,0.0),np.complex(0.25,-0.0),np.complex(1.0,0.5),np.complex(-3.0,0.5)},2e-12),'complex fmin values 419')
end
do -- fmin 420
 local a=np.array({np.complex(0.25,0.5),np.complex(1.0,-0.0),np.complex(4.0,1.0),np.complex(-0.0,0.0),np.complex(-0.0,-1.0),np.complex(1.0,-3.0)},np.complex128)
 local b=np.array({0.0,0.5,1.0,2.0,-0.0,2.0},np.float32)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex128','complex fmin dtype 420 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,0.0),np.complex(0.5,0.0),np.complex(1.0,0.0),np.complex(-0.0,0.0),np.complex(-0.0,-1.0),np.complex(1.0,-3.0)},2e-12),'complex fmin values 420')
end
do -- fmin 421
 local a=np.array({np.complex(1.0,0.0),np.complex(-1.0,-3.0),np.complex(4.0,-0.0),np.complex(0.0,-1.0),np.complex(-1.0,-3.0),np.complex(0.25,3.0)},np.complex64)
 local b=np.array({np.complex(4.0,-1.0),np.complex(4.0,3.0),np.complex(-3.0,-1.0),np.complex(4.0,0.5),np.complex(1.0,0.0),np.complex(-1.0,1.0)},np.complex128)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex128','complex fmin dtype 421 '..r.dtype)
 assert(close(r:tolist(),{np.complex(1.0,0.0),np.complex(-1.0,-3.0),np.complex(-3.0,-1.0),np.complex(0.0,-1.0),np.complex(-1.0,-3.0),np.complex(-1.0,1.0)},2e-12),'complex fmin values 421')
end
do -- fmin 422
 local a=np.array({np.complex(2.0,-3.0),np.complex(-1.0,-1.0),np.complex(1.0,-0.0),np.complex(2.0,-3.0),np.complex(-0.0,3.0),np.complex(1.0,0.0)},np.complex64)
 local b=np.array({-3.0,-1.0,0.5,0.0,4.0,0.5},np.float16)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex64','complex fmin dtype 422 '..r.dtype)
 assert(close(r:tolist(),{np.complex(-3.0,0.0),np.complex(-1.0,-1.0),np.complex(0.5,0.0),np.complex(0.0,0.0),np.complex(-0.0,3.0),np.complex(0.5,0.0)},3e-05),'complex fmin values 422')
end
do -- fmin 423
 local a=np.array({np.complex(1.0,0.5),np.complex(-0.0,0.5),np.complex(-2.0,0.0),np.complex(-1.0,-0.0),np.complex(-2.0,0.5),np.complex(-0.0,0.0)},np.complex128)
 local b=np.array({1.0,-1.0,-0.0,0.0,0.5,2.0},np.float64)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex128','complex fmin dtype 423 '..r.dtype)
 assert(close(r:tolist(),{np.complex(1.0,0.0),np.complex(-1.0,0.0),np.complex(-2.0,0.0),np.complex(-1.0,-0.0),np.complex(-2.0,0.5),np.complex(-0.0,0.0)},2e-12),'complex fmin values 423')
end
do -- fmin 424
 local a=np.array({np.complex(4.0,0.0),np.complex(-2.0,1.0),np.complex(0.25,-3.0),np.complex(2.0,-1.0),np.complex(2.0,0.5),np.complex(1.0,-0.0)},np.complex64)
 local b=np.array({np.complex(2.0,0.0),np.complex(4.0,-0.0),np.complex(4.0,1.0),np.complex(-0.0,0.5),np.complex(0.0,0.5),np.complex(-3.0,1.0)},np.complex64)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex64','complex fmin dtype 424 '..r.dtype)
 assert(close(r:tolist(),{np.complex(2.0,0.0),np.complex(-2.0,1.0),np.complex(0.25,-3.0),np.complex(-0.0,0.5),np.complex(0.0,0.5),np.complex(-3.0,1.0)},3e-05),'complex fmin values 424')
end
do -- fmin 425
 local a=np.array({np.complex(0.25,-0.0),np.complex(-0.0,-1.0),np.complex(2.0,0.5),np.complex(-1.0,0.5),np.complex(1.0,3.0),np.complex(-0.0,1.0)},np.complex128)
 local b=np.array({0.5,4.0,-0.0,-1.0,-0.0,2.0},np.float32)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex128','complex fmin dtype 425 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.25,-0.0),np.complex(-0.0,-1.0),np.complex(-0.0,0.0),np.complex(-1.0,0.0),np.complex(-0.0,0.0),np.complex(-0.0,1.0)},2e-12),'complex fmin values 425')
end
do -- fmin 426
 local a=np.array({np.complex(0.0,-1.0),np.complex(2.0,1.0),np.complex(2.0,-0.0),np.complex(1.0,-1.0),np.complex(0.0,0.0),np.complex(0.0,0.5)},np.complex64)
 local b=np.array({-0.0,-3.0,-0.0,1.0,-0.0,-0.0},np.float64)
 local r=np.fmin(a,b)
 assert(r.dtype=='complex128','complex fmin dtype 426 '..r.dtype)
 assert(close(r:tolist(),{np.complex(0.0,-1.0),np.complex(-3.0,0.0),np.complex(-0.0,0.0),np.complex(1.0,-1.0),np.complex(0.0,0.0),np.complex(-0.0,0.0)},2e-12),'complex fmin values 426')
end
do local a=np.array({true,true,true},np.bool); local r=np.add(a,np.complex(1.25,-2)); assert(r.dtype=='complex128','weak complex dtype 427 '..r.dtype); assert(close(r:tolist(),{np.complex(2.25,-2.0),np.complex(2.25,-2.0),np.complex(2.25,-2.0)},2e-12),'weak complex 427') end
do local a=np.array({true,true,true},np.bool); local r=np.add(np.complex(1.25,-2),a); assert(r.dtype=='complex128','weak complex dtype 428 '..r.dtype); assert(close(r:tolist(),{np.complex(2.25,-2.0),np.complex(2.25,-2.0),np.complex(2.25,-2.0)},2e-12),'weak complex 428') end
do local a=np.array({1,2,-3},np.int8); local r=np.add(a,np.complex(1.25,-2)); assert(r.dtype=='complex128','weak complex dtype 429 '..r.dtype); assert(close(r:tolist(),{np.complex(2.25,-2.0),np.complex(3.25,-2.0),np.complex(-1.75,-2.0)},2e-12),'weak complex 429') end
do local a=np.array({1,2,-3},np.int8); local r=np.add(np.complex(1.25,-2),a); assert(r.dtype=='complex128','weak complex dtype 430 '..r.dtype); assert(close(r:tolist(),{np.complex(2.25,-2.0),np.complex(3.25,-2.0),np.complex(-1.75,-2.0)},2e-12),'weak complex 430') end
do local a=np.array({1,2,-3},np.int32); local r=np.add(a,np.complex(1.25,-2)); assert(r.dtype=='complex128','weak complex dtype 431 '..r.dtype); assert(close(r:tolist(),{np.complex(2.25,-2.0),np.complex(3.25,-2.0),np.complex(-1.75,-2.0)},2e-12),'weak complex 431') end
do local a=np.array({1,2,-3},np.int32); local r=np.add(np.complex(1.25,-2),a); assert(r.dtype=='complex128','weak complex dtype 432 '..r.dtype); assert(close(r:tolist(),{np.complex(2.25,-2.0),np.complex(3.25,-2.0),np.complex(-1.75,-2.0)},2e-12),'weak complex 432') end
do local a=np.array({1,2,-3},np.int64); local r=np.add(a,np.complex(1.25,-2)); assert(r.dtype=='complex128','weak complex dtype 433 '..r.dtype); assert(close(r:tolist(),{np.complex(2.25,-2.0),np.complex(3.25,-2.0),np.complex(-1.75,-2.0)},2e-12),'weak complex 433') end
do local a=np.array({1,2,-3},np.int64); local r=np.add(np.complex(1.25,-2),a); assert(r.dtype=='complex128','weak complex dtype 434 '..r.dtype); assert(close(r:tolist(),{np.complex(2.25,-2.0),np.complex(3.25,-2.0),np.complex(-1.75,-2.0)},2e-12),'weak complex 434') end
do local a=np.array({1.0,2.0,-3.0},np.float16); local r=np.add(a,np.complex(1.25,-2)); assert(r.dtype=='complex64','weak complex dtype 435 '..r.dtype); assert(close(r:tolist(),{np.complex(2.25,-2.0),np.complex(3.25,-2.0),np.complex(-1.75,-2.0)},3e-05),'weak complex 435') end
do local a=np.array({1.0,2.0,-3.0},np.float16); local r=np.add(np.complex(1.25,-2),a); assert(r.dtype=='complex64','weak complex dtype 436 '..r.dtype); assert(close(r:tolist(),{np.complex(2.25,-2.0),np.complex(3.25,-2.0),np.complex(-1.75,-2.0)},3e-05),'weak complex 436') end
do local a=np.array({1.0,2.0,-3.0},np.float32); local r=np.add(a,np.complex(1.25,-2)); assert(r.dtype=='complex64','weak complex dtype 437 '..r.dtype); assert(close(r:tolist(),{np.complex(2.25,-2.0),np.complex(3.25,-2.0),np.complex(-1.75,-2.0)},3e-05),'weak complex 437') end
do local a=np.array({1.0,2.0,-3.0},np.float32); local r=np.add(np.complex(1.25,-2),a); assert(r.dtype=='complex64','weak complex dtype 438 '..r.dtype); assert(close(r:tolist(),{np.complex(2.25,-2.0),np.complex(3.25,-2.0),np.complex(-1.75,-2.0)},3e-05),'weak complex 438') end
do local a=np.array({1.0,2.0,-3.0},np.float64); local r=np.add(a,np.complex(1.25,-2)); assert(r.dtype=='complex128','weak complex dtype 439 '..r.dtype); assert(close(r:tolist(),{np.complex(2.25,-2.0),np.complex(3.25,-2.0),np.complex(-1.75,-2.0)},2e-12),'weak complex 439') end
do local a=np.array({1.0,2.0,-3.0},np.float64); local r=np.add(np.complex(1.25,-2),a); assert(r.dtype=='complex128','weak complex dtype 440 '..r.dtype); assert(close(r:tolist(),{np.complex(2.25,-2.0),np.complex(3.25,-2.0),np.complex(-1.75,-2.0)},2e-12),'weak complex 440') end
do local a=np.array({1.0,2.0,-3.0},np.longdouble); local r=np.add(a,np.complex(1.25,-2)); assert(r.dtype=='complex256','weak complex dtype 441 '..r.dtype); assert(close(r:tolist(),{np.complex(2.25,-2.0),np.complex(3.25,-2.0),np.complex(-1.75,-2.0)},2e-12),'weak complex 441') end
do local a=np.array({1.0,2.0,-3.0},np.longdouble); local r=np.add(np.complex(1.25,-2),a); assert(r.dtype=='complex256','weak complex dtype 442 '..r.dtype); assert(close(r:tolist(),{np.complex(2.25,-2.0),np.complex(3.25,-2.0),np.complex(-1.75,-2.0)},2e-12),'weak complex 442') end
do local a=np.array({np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(-3.0,0.0)},np.complex64); local r=np.add(a,np.complex(1.25,-2)); assert(r.dtype=='complex64','weak complex dtype 443 '..r.dtype); assert(close(r:tolist(),{np.complex(2.25,-2.0),np.complex(3.25,-2.0),np.complex(-1.75,-2.0)},3e-05),'weak complex 443') end
do local a=np.array({np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(-3.0,0.0)},np.complex64); local r=np.add(np.complex(1.25,-2),a); assert(r.dtype=='complex64','weak complex dtype 444 '..r.dtype); assert(close(r:tolist(),{np.complex(2.25,-2.0),np.complex(3.25,-2.0),np.complex(-1.75,-2.0)},3e-05),'weak complex 444') end
do local a=np.array({np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(-3.0,0.0)},np.complex128); local r=np.add(a,np.complex(1.25,-2)); assert(r.dtype=='complex128','weak complex dtype 445 '..r.dtype); assert(close(r:tolist(),{np.complex(2.25,-2.0),np.complex(3.25,-2.0),np.complex(-1.75,-2.0)},2e-12),'weak complex 445') end
do local a=np.array({np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(-3.0,0.0)},np.complex128); local r=np.add(np.complex(1.25,-2),a); assert(r.dtype=='complex128','weak complex dtype 446 '..r.dtype); assert(close(r:tolist(),{np.complex(2.25,-2.0),np.complex(3.25,-2.0),np.complex(-1.75,-2.0)},2e-12),'weak complex 446') end
do local a=np.array({np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(-3.0,0.0)},np.complex256); local r=np.add(a,np.complex(1.25,-2)); assert(r.dtype=='complex256','weak complex dtype 447 '..r.dtype); assert(close(r:tolist(),{np.complex(2.25,-2.0),np.complex(3.25,-2.0),np.complex(-1.75,-2.0)},2e-12),'weak complex 447') end
do local a=np.array({np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(-3.0,0.0)},np.complex256); local r=np.add(np.complex(1.25,-2),a); assert(r.dtype=='complex256','weak complex dtype 448 '..r.dtype); assert(close(r:tolist(),{np.complex(2.25,-2.0),np.complex(3.25,-2.0),np.complex(-1.75,-2.0)},2e-12),'weak complex 448') end
do
 local a=np.array({np.complex(1.0,2.0),np.complex(2.0,-1.0),np.complex(-3.0,0.5),np.complex(4.0,0.0)},np.complex64)
 local b=np.array({np.complex(2.0,-1.0),np.complex(-1.0,3.0),np.complex(1.0,0.0),np.complex(0.5,-2.0)},np.complex64)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.ones({4},np.complex64)*np.complex(7,8)
 local r=np.add(a,b,{out=o,where=m})
 assert(r==o,'complex out identity')
 assert(close(o:tolist(),{np.complex(3.0,1.0),np.complex(7.0,8.0),np.complex(-2.0,0.5),np.complex(7.0,8.0)},3e-5),'complex outwhere add')
end
do
 local a=np.array({np.complex(1.0,2.0),np.complex(2.0,-1.0),np.complex(-3.0,0.5),np.complex(4.0,0.0)},np.complex64)
 local b=np.array({np.complex(2.0,-1.0),np.complex(-1.0,3.0),np.complex(1.0,0.0),np.complex(0.5,-2.0)},np.complex64)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.ones({4},np.complex64)*np.complex(7,8)
 local r=np.multiply(a,b,{out=o,where=m})
 assert(r==o,'complex out identity')
 assert(close(o:tolist(),{np.complex(4.0,3.0),np.complex(7.0,8.0),np.complex(-3.0,0.5),np.complex(7.0,8.0)},3e-5),'complex outwhere multiply')
end
do
 local a=np.array({np.complex(1.0,2.0),np.complex(2.0,-1.0),np.complex(-3.0,0.5),np.complex(4.0,0.0)},np.complex64)
 local b=np.array({np.complex(2.0,-1.0),np.complex(-1.0,3.0),np.complex(1.0,0.0),np.complex(0.5,-2.0)},np.complex64)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.ones({4},np.complex64)*np.complex(7,8)
 local r=np.maximum(a,b,{out=o,where=m})
 assert(r==o,'complex out identity')
 assert(close(o:tolist(),{np.complex(2.0,-1.0),np.complex(7.0,8.0),np.complex(1.0,0.0),np.complex(7.0,8.0)},3e-5),'complex outwhere maximum')
end
do
 local a=np.array({np.complex(1.0,2.0),np.complex(2.0,-1.0),np.complex(-3.0,0.5),np.complex(4.0,0.0)},np.complex64)
 local b=np.array({np.complex(2.0,-1.0),np.complex(-1.0,3.0),np.complex(1.0,0.0),np.complex(0.5,-2.0)},np.complex64)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.ones({4},np.bool)
 local r=np.equal(a,b,{out=o,where=m})
 assert(r==o,'complex out identity')
 assert(exact(o:tolist(),{false,true,false,true}),'complex outwhere equal')
end
do local a=np.array({np.complex(1.0,2.0),np.complex(-3.0,4.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(math.huge,1.0),np.complex(1.0,math.huge),np.complex((0/0),2.0)},np.complex128); local r=np.negative(a); assert(r.dtype=='complex128','complex unary dtype negative'); assert(close(r:tolist(),{np.complex(-1.0,-2.0),np.complex(3.0,-4.0),np.complex(-0.0,-0.0),np.complex(-0.0,-0.0),np.complex(-math.huge,-1.0),np.complex(-1.0,-math.huge),np.complex((0/0),-2.0)},2e-12),'complex unary negative') end
do local a=np.array({np.complex(1.0,2.0),np.complex(-3.0,4.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(math.huge,1.0),np.complex(1.0,math.huge),np.complex((0/0),2.0)},np.complex128); local r=np.absolute(a); assert(r.dtype=='float64','complex unary dtype absolute'); assert(close(r:tolist(),{2.23606797749979,5.0,0.0,0.0,math.huge,math.huge,(0/0)},2e-12),'complex unary absolute') end
do local a=np.array({np.complex(1.0,2.0),np.complex(-3.0,4.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(math.huge,1.0),np.complex(1.0,math.huge),np.complex((0/0),2.0)},np.complex128); local r=np.positive(a); assert(r.dtype=='complex128','complex unary dtype positive'); assert(close(r:tolist(),{np.complex(1.0,2.0),np.complex(-3.0,4.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(math.huge,1.0),np.complex(1.0,math.huge),np.complex((0/0),2.0)},2e-12),'complex unary positive') end
do local a=np.array({np.complex(1.0,2.0),np.complex(-3.0,4.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(math.huge,1.0),np.complex(1.0,math.huge),np.complex((0/0),2.0)},np.complex128); local r=np.sign(a); assert(r.dtype=='complex128','complex unary dtype sign'); assert(close(r:tolist(),{np.complex(0.4472135954999579,0.8944271909999159),np.complex(-0.6,0.8),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(0.0,1.0),np.complex((0/0),(0/0))},2e-12),'complex unary sign') end
do local a=np.array({np.complex(1.0,2.0),np.complex(-3.0,4.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(math.huge,1.0),np.complex(1.0,math.huge),np.complex((0/0),2.0)},np.complex128); local r=np.logical_not(a); assert(r.dtype=='bool','complex unary dtype logical_not'); assert(exact(r:tolist(),{false,false,true,true,false,false,false}),'complex unary logical_not') end
do local a=np.array({np.complex(1.0,2.0),np.complex(-3.0,4.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(math.huge,1.0),np.complex(1.0,math.huge),np.complex((0/0),2.0)},np.complex128); local r=np.isnan(a); assert(r.dtype=='bool','complex unary dtype isnan'); assert(exact(r:tolist(),{false,false,false,false,false,false,true}),'complex unary isnan') end
do local a=np.array({np.complex(1.0,2.0),np.complex(-3.0,4.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(math.huge,1.0),np.complex(1.0,math.huge),np.complex((0/0),2.0)},np.complex128); local r=np.isinf(a); assert(r.dtype=='bool','complex unary dtype isinf'); assert(exact(r:tolist(),{false,false,false,false,true,true,false}),'complex unary isinf') end
do local a=np.array({np.complex(1.0,2.0),np.complex(-3.0,4.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(math.huge,1.0),np.complex(1.0,math.huge),np.complex((0/0),2.0)},np.complex128); local r=np.isfinite(a); assert(r.dtype=='bool','complex unary dtype isfinite'); assert(exact(r:tolist(),{true,true,true,true,false,false,false}),'complex unary isfinite') end
do local a=np.array({np.complex(1,2)},np.complex128); local ok=pcall(function() np.signbit(a) end); assert(not ok,'signbit complex reject') end
do local a=np.array({{np.complex(-2.0,0.0),np.complex(4.0,-3.0),np.complex(-2.0,0.5),np.complex(1.0,3.0),np.complex(-3.0,3.0)},{np.complex(0.0,-1.0),np.complex(-2.0,0.0),np.complex(-0.0,-0.0),np.complex(-0.0,3.0),np.complex(-0.0,-0.0)}},np.complex128); local r=np.sum(a,2); assert(r.dtype=='complex128','complex reduce dtype 462'); assert(close(r:tolist(),{np.complex(-2.0,3.5),np.complex(-2.0,2.0)},2e-12),'complex reduce 462') end
do local a=np.array({{np.complex(-2.0,0.0),np.complex(4.0,-3.0),np.complex(-2.0,0.5),np.complex(1.0,3.0),np.complex(-3.0,3.0)},{np.complex(0.0,-1.0),np.complex(-2.0,0.0),np.complex(-0.0,-0.0),np.complex(-0.0,3.0),np.complex(-0.0,-0.0)}},np.complex128); local r=np.prod(a,2); assert(r.dtype=='complex128','complex reduce dtype 463'); assert(close(r:tolist(),{np.complex(-252.0,114.0),np.complex(0.0,-0.0)},2e-12),'complex reduce 463') end
do local a=np.array({{np.complex(-2.0,0.0),np.complex(4.0,-3.0),np.complex(-2.0,0.5),np.complex(1.0,3.0),np.complex(-3.0,3.0)},{np.complex(0.0,-1.0),np.complex(-2.0,0.0),np.complex(-0.0,-0.0),np.complex(-0.0,3.0),np.complex(-0.0,-0.0)}},np.complex128); local r=np.mean(a,2); assert(r.dtype=='complex128','complex reduce dtype 464'); assert(close(r:tolist(),{np.complex(-0.4,0.7000000000000001),np.complex(-0.4,0.4)},2e-12),'complex reduce 464') end
do local a=np.array({{np.complex(2.0,-3.0),np.complex(2.0,0.0),np.complex(4.0,0.5),np.complex(-1.0,1.0),np.complex(4.0,-0.0)},{np.complex(1.0,0.5),np.complex(-2.0,0.5),np.complex(1.0,1.0),np.complex(-3.0,3.0),np.complex(-1.0,0.5)}},np.complex128); local r=np.sum(a,1); assert(r.dtype=='complex128','complex reduce dtype 465'); assert(close(r:tolist(),{np.complex(3.0,-2.5),np.complex(0.0,0.5),np.complex(5.0,1.5),np.complex(-4.0,4.0),np.complex(3.0,0.5)},2e-12),'complex reduce 465') end
do local a=np.array({{np.complex(2.0,-3.0),np.complex(2.0,0.0),np.complex(4.0,0.5),np.complex(-1.0,1.0),np.complex(4.0,-0.0)},{np.complex(1.0,0.5),np.complex(-2.0,0.5),np.complex(1.0,1.0),np.complex(-3.0,3.0),np.complex(-1.0,0.5)}},np.complex128); local r=np.prod(a,1); assert(r.dtype=='complex128','complex reduce dtype 466'); assert(close(r:tolist(),{np.complex(3.5,-2.0),np.complex(-4.0,1.0),np.complex(3.5,4.5),np.complex(0.0,-6.0),np.complex(-4.0,2.0)},2e-12),'complex reduce 466') end
do local a=np.array({{np.complex(2.0,-3.0),np.complex(2.0,0.0),np.complex(4.0,0.5),np.complex(-1.0,1.0),np.complex(4.0,-0.0)},{np.complex(1.0,0.5),np.complex(-2.0,0.5),np.complex(1.0,1.0),np.complex(-3.0,3.0),np.complex(-1.0,0.5)}},np.complex128); local r=np.mean(a,1); assert(r.dtype=='complex128','complex reduce dtype 467'); assert(close(r:tolist(),{np.complex(1.5,-1.25),np.complex(0.0,0.25),np.complex(2.5,0.75),np.complex(-2.0,2.0),np.complex(1.5,0.25)},2e-12),'complex reduce 467') end
do local a=np.array({{np.complex(-0.0,1.0),np.complex(-3.0,1.0),np.complex(-0.0,-3.0),np.complex(4.0,3.0),np.complex(-0.0,-0.0)},{np.complex(-0.0,-1.0),np.complex(0.0,-1.0),np.complex(-0.0,0.0),np.complex(0.25,-3.0),np.complex(-1.0,0.0)}},np.complex128); local r=np.sum(a,1); assert(r.dtype=='complex128','complex reduce dtype 468'); assert(close(r:tolist(),{np.complex(0.0,0.0),np.complex(-3.0,0.0),np.complex(0.0,-3.0),np.complex(4.25,0.0),np.complex(-1.0,0.0)},2e-12),'complex reduce 468') end
do local a=np.array({{np.complex(-0.0,1.0),np.complex(-3.0,1.0),np.complex(-0.0,-3.0),np.complex(4.0,3.0),np.complex(-0.0,-0.0)},{np.complex(-0.0,-1.0),np.complex(0.0,-1.0),np.complex(-0.0,0.0),np.complex(0.25,-3.0),np.complex(-1.0,0.0)}},np.complex128); local r=np.prod(a,1); assert(r.dtype=='complex128','complex reduce dtype 469'); assert(close(r:tolist(),{np.complex(1.0,0.0),np.complex(1.0,3.0),np.complex(0.0,0.0),np.complex(10.0,-11.25),np.complex(0.0,0.0)},2e-12),'complex reduce 469') end
do local a=np.array({{np.complex(-0.0,1.0),np.complex(-3.0,1.0),np.complex(-0.0,-3.0),np.complex(4.0,3.0),np.complex(-0.0,-0.0)},{np.complex(-0.0,-1.0),np.complex(0.0,-1.0),np.complex(-0.0,0.0),np.complex(0.25,-3.0),np.complex(-1.0,0.0)}},np.complex128); local r=np.mean(a,1); assert(r.dtype=='complex128','complex reduce dtype 470'); assert(close(r:tolist(),{np.complex(0.0,0.0),np.complex(-1.5,0.0),np.complex(0.0,-1.5),np.complex(2.125,0.0),np.complex(-0.5,0.0)},2e-12),'complex reduce 470') end
do local a=np.array({{{np.complex(4.0,-1.0),np.complex(0.25,0.5),np.complex(2.0,3.0),np.complex(-1.0,-0.0)},{np.complex(-1.0,0.0),np.complex(2.0,-3.0),np.complex(2.0,0.5),np.complex(0.25,0.5)},{np.complex(-1.0,0.0),np.complex(1.0,0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0)}},{{np.complex(-0.0,0.0),np.complex(4.0,3.0),np.complex(4.0,-1.0),np.complex(0.25,-1.0)},{np.complex(-0.0,0.0),np.complex(2.0,0.5),np.complex(-1.0,1.0),np.complex(0.25,-1.0)},{np.complex(0.0,0.0),np.complex(0.0,-3.0),np.complex(-3.0,-0.0),np.complex(-1.0,0.0)}}},np.complex64); local r=np.sum(a,2); assert(r.dtype=='complex64','complex reduce dtype 471'); assert(close(r:tolist(),{{np.complex(2.0,-1.0),np.complex(3.25,-2.5),np.complex(4.0,3.5),np.complex(-0.75,0.5)},{np.complex(0.0,0.0),np.complex(6.0,0.5),np.complex(0.0,0.0),np.complex(-0.5,-2.0)}},3e-05),'complex reduce 471') end
do local a=np.array({{{np.complex(4.0,-1.0),np.complex(0.25,0.5),np.complex(2.0,3.0),np.complex(-1.0,-0.0)},{np.complex(-1.0,0.0),np.complex(2.0,-3.0),np.complex(2.0,0.5),np.complex(0.25,0.5)},{np.complex(-1.0,0.0),np.complex(1.0,0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0)}},{{np.complex(-0.0,0.0),np.complex(4.0,3.0),np.complex(4.0,-1.0),np.complex(0.25,-1.0)},{np.complex(-0.0,0.0),np.complex(2.0,0.5),np.complex(-1.0,1.0),np.complex(0.25,-1.0)},{np.complex(0.0,0.0),np.complex(0.0,-3.0),np.complex(-3.0,-0.0),np.complex(-1.0,0.0)}}},np.complex64); local r=np.prod(a,2); assert(r.dtype=='complex64','complex reduce dtype 472'); assert(close(r:tolist(),{{np.complex(4.0,-1.0),np.complex(2.0,0.25),np.complex(-0.0,0.0),np.complex(0.0,0.0)},{np.complex(0.0,0.0),np.complex(24.0,-19.5),np.complex(9.0,-15.0),np.complex(0.9375,0.5)}},3e-05),'complex reduce 472') end
do local a=np.array({{{np.complex(4.0,-1.0),np.complex(0.25,0.5),np.complex(2.0,3.0),np.complex(-1.0,-0.0)},{np.complex(-1.0,0.0),np.complex(2.0,-3.0),np.complex(2.0,0.5),np.complex(0.25,0.5)},{np.complex(-1.0,0.0),np.complex(1.0,0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0)}},{{np.complex(-0.0,0.0),np.complex(4.0,3.0),np.complex(4.0,-1.0),np.complex(0.25,-1.0)},{np.complex(-0.0,0.0),np.complex(2.0,0.5),np.complex(-1.0,1.0),np.complex(0.25,-1.0)},{np.complex(0.0,0.0),np.complex(0.0,-3.0),np.complex(-3.0,-0.0),np.complex(-1.0,0.0)}}},np.complex64); local r=np.mean(a,2); assert(r.dtype=='complex64','complex reduce dtype 473'); assert(close(r:tolist(),{{np.complex(0.6666666865348816,-0.3333333432674408),np.complex(1.0833333730697632,-0.8333333134651184),np.complex(1.3333333730697632,1.1666666269302368),np.complex(-0.25,0.1666666716337204)},{np.complex(0.0,0.0),np.complex(2.0,0.1666666716337204),np.complex(0.0,0.0),np.complex(-0.1666666716337204,-0.6666666865348816)}},3e-05),'complex reduce 473') end
do local a=np.array({{np.complex(-1.0,1.0),np.complex(0.0,0.5),np.complex(-1.0,-3.0),np.complex(0.25,-1.0),np.complex(0.0,-3.0)},{np.complex(-0.0,0.0),np.complex(-2.0,-0.0),np.complex(-3.0,3.0),np.complex(0.25,3.0),np.complex(-0.0,0.0)}},np.complex64); local r=np.sum(a,1); assert(r.dtype=='complex64','complex reduce dtype 474'); assert(close(r:tolist(),{np.complex(-1.0,1.0),np.complex(-2.0,0.5),np.complex(-4.0,0.0),np.complex(0.5,2.0),np.complex(0.0,-3.0)},3e-05),'complex reduce 474') end
do local a=np.array({{np.complex(-1.0,1.0),np.complex(0.0,0.5),np.complex(-1.0,-3.0),np.complex(0.25,-1.0),np.complex(0.0,-3.0)},{np.complex(-0.0,0.0),np.complex(-2.0,-0.0),np.complex(-3.0,3.0),np.complex(0.25,3.0),np.complex(-0.0,0.0)}},np.complex64); local r=np.prod(a,1); assert(r.dtype=='complex64','complex reduce dtype 475'); assert(close(r:tolist(),{np.complex(0.0,-0.0),np.complex(0.0,-1.0),np.complex(12.0,6.0),np.complex(3.0625,0.5),np.complex(0.0,0.0)},3e-05),'complex reduce 475') end
do local a=np.array({{np.complex(-1.0,1.0),np.complex(0.0,0.5),np.complex(-1.0,-3.0),np.complex(0.25,-1.0),np.complex(0.0,-3.0)},{np.complex(-0.0,0.0),np.complex(-2.0,-0.0),np.complex(-3.0,3.0),np.complex(0.25,3.0),np.complex(-0.0,0.0)}},np.complex64); local r=np.mean(a,1); assert(r.dtype=='complex64','complex reduce dtype 476'); assert(close(r:tolist(),{np.complex(-0.5,0.5),np.complex(-1.0,0.25),np.complex(-2.0,0.0),np.complex(0.25,1.0),np.complex(0.0,-1.5)},3e-05),'complex reduce 476') end
do local a=np.array({{np.complex(4.0,1.0),np.complex(0.25,-0.0),np.complex(1.0,-3.0),np.complex(1.0,0.5),np.complex(-3.0,-1.0)},{np.complex(-0.0,-0.0),np.complex(1.0,-0.0),np.complex(1.0,-0.0),np.complex(-1.0,-3.0),np.complex(0.0,-0.0)}},np.complex128); local r=np.sum(a,2); assert(r.dtype=='complex128','complex reduce dtype 477'); assert(close(r:tolist(),{np.complex(3.25,-2.5),np.complex(1.0,-3.0)},2e-12),'complex reduce 477') end
do local a=np.array({{np.complex(4.0,1.0),np.complex(0.25,-0.0),np.complex(1.0,-3.0),np.complex(1.0,0.5),np.complex(-3.0,-1.0)},{np.complex(-0.0,-0.0),np.complex(1.0,-0.0),np.complex(1.0,-0.0),np.complex(-1.0,-3.0),np.complex(0.0,-0.0)}},np.complex128); local r=np.prod(a,2); assert(r.dtype=='complex128','complex reduce dtype 478'); assert(close(r:tolist(),{np.complex(-11.25,2.5),np.complex(0.0,0.0)},2e-12),'complex reduce 478') end
do local a=np.array({{np.complex(4.0,1.0),np.complex(0.25,-0.0),np.complex(1.0,-3.0),np.complex(1.0,0.5),np.complex(-3.0,-1.0)},{np.complex(-0.0,-0.0),np.complex(1.0,-0.0),np.complex(1.0,-0.0),np.complex(-1.0,-3.0),np.complex(0.0,-0.0)}},np.complex128); local r=np.mean(a,2); assert(r.dtype=='complex128','complex reduce dtype 479'); assert(close(r:tolist(),{np.complex(0.65,-0.5),np.complex(0.2,-0.6000000000000001)},2e-12),'complex reduce 479') end
do local a=np.array({np.complex(1.0,1.0),np.complex(-3.0,-1.0),np.complex(1.0,-1.0),np.complex(-1.0,-0.0),np.complex(4.0,0.0),np.complex(-2.0,-1.0),np.complex(-3.0,3.0)},np.complex64); local r=np.sum(a,1); assert(close(r,np.complex(-3.0,1.0),3e-05),'complex reduce scalar 480') end
do local a=np.array({np.complex(1.0,1.0),np.complex(-3.0,-1.0),np.complex(1.0,-1.0),np.complex(-1.0,-0.0),np.complex(4.0,0.0),np.complex(-2.0,-1.0),np.complex(-3.0,3.0)},np.complex64); local r=np.prod(a,1); assert(close(r,np.complex(240.0,0.0),3e-05),'complex reduce scalar 481') end
do local a=np.array({np.complex(1.0,1.0),np.complex(-3.0,-1.0),np.complex(1.0,-1.0),np.complex(-1.0,-0.0),np.complex(4.0,0.0),np.complex(-2.0,-1.0),np.complex(-3.0,3.0)},np.complex64); local r=np.mean(a,1); assert(close(r,np.complex(-0.4285714328289032,0.1428571492433548),3e-05),'complex reduce scalar 482') end
do local a=np.array({{np.complex(2.0,3.0),np.complex(0.25,3.0),np.complex(0.25,3.0),np.complex(-2.0,-0.0),np.complex(2.0,0.0)},{np.complex(0.0,3.0),np.complex(-3.0,3.0),np.complex(-2.0,-0.0),np.complex(0.25,-3.0),np.complex(-1.0,0.5)}},np.complex128); local r=np.sum(a,1); assert(r.dtype=='complex128','complex reduce dtype 483'); assert(close(r:tolist(),{np.complex(2.0,6.0),np.complex(-2.75,6.0),np.complex(-1.75,3.0),np.complex(-1.75,-3.0),np.complex(1.0,0.5)},2e-12),'complex reduce 483') end
do local a=np.array({{np.complex(2.0,3.0),np.complex(0.25,3.0),np.complex(0.25,3.0),np.complex(-2.0,-0.0),np.complex(2.0,0.0)},{np.complex(0.0,3.0),np.complex(-3.0,3.0),np.complex(-2.0,-0.0),np.complex(0.25,-3.0),np.complex(-1.0,0.5)}},np.complex128); local r=np.prod(a,1); assert(r.dtype=='complex128','complex reduce dtype 484'); assert(close(r:tolist(),{np.complex(-9.0,6.0),np.complex(-9.75,-8.25),np.complex(-0.5,-6.0),np.complex(-0.5,6.0),np.complex(-2.0,1.0)},2e-12),'complex reduce 484') end
do local a=np.array({{np.complex(2.0,3.0),np.complex(0.25,3.0),np.complex(0.25,3.0),np.complex(-2.0,-0.0),np.complex(2.0,0.0)},{np.complex(0.0,3.0),np.complex(-3.0,3.0),np.complex(-2.0,-0.0),np.complex(0.25,-3.0),np.complex(-1.0,0.5)}},np.complex128); local r=np.mean(a,1); assert(r.dtype=='complex128','complex reduce dtype 485'); assert(close(r:tolist(),{np.complex(1.0,3.0),np.complex(-1.375,3.0),np.complex(-0.875,1.5),np.complex(-0.875,-1.5),np.complex(0.5,0.25)},2e-12),'complex reduce 485') end
do local a=np.array({{np.complex(-2.0,-0.0),np.complex(1.0,1.0),np.complex(-0.0,-3.0),np.complex(-0.0,-0.0),np.complex(-1.0,-0.0)},{np.complex(4.0,1.0),np.complex(1.0,-1.0),np.complex(4.0,-0.0),np.complex(1.0,-1.0),np.complex(-3.0,0.0)}},np.complex128); local r=np.sum(a,1); assert(r.dtype=='complex128','complex reduce dtype 486'); assert(close(r:tolist(),{np.complex(2.0,1.0),np.complex(2.0,0.0),np.complex(4.0,-3.0),np.complex(1.0,-1.0),np.complex(-4.0,0.0)},2e-12),'complex reduce 486') end
do local a=np.array({{np.complex(-2.0,-0.0),np.complex(1.0,1.0),np.complex(-0.0,-3.0),np.complex(-0.0,-0.0),np.complex(-1.0,-0.0)},{np.complex(4.0,1.0),np.complex(1.0,-1.0),np.complex(4.0,-0.0),np.complex(1.0,-1.0),np.complex(-3.0,0.0)}},np.complex128); local r=np.prod(a,1); assert(r.dtype=='complex128','complex reduce dtype 487'); assert(close(r:tolist(),{np.complex(-8.0,-2.0),np.complex(2.0,0.0),np.complex(0.0,-12.0),np.complex(0.0,-0.0),np.complex(3.0,0.0)},2e-12),'complex reduce 487') end
do local a=np.array({{np.complex(-2.0,-0.0),np.complex(1.0,1.0),np.complex(-0.0,-3.0),np.complex(-0.0,-0.0),np.complex(-1.0,-0.0)},{np.complex(4.0,1.0),np.complex(1.0,-1.0),np.complex(4.0,-0.0),np.complex(1.0,-1.0),np.complex(-3.0,0.0)}},np.complex128); local r=np.mean(a,1); assert(r.dtype=='complex128','complex reduce dtype 488'); assert(close(r:tolist(),{np.complex(1.0,0.5),np.complex(1.0,0.0),np.complex(2.0,-1.5),np.complex(0.5,-0.5),np.complex(-2.0,0.0)},2e-12),'complex reduce 488') end
do local a=np.array({{{np.complex(-3.0,1.0),np.complex(-2.0,0.0),np.complex(2.0,-0.0),np.complex(-0.0,1.0)},{np.complex(2.0,-1.0),np.complex(0.25,-3.0),np.complex(4.0,1.0),np.complex(-0.0,0.5)},{np.complex(-3.0,1.0),np.complex(-2.0,0.5),np.complex(4.0,0.0),np.complex(0.25,3.0)}},{{np.complex(-0.0,-3.0),np.complex(-1.0,3.0),np.complex(1.0,-3.0),np.complex(4.0,1.0)},{np.complex(-0.0,-1.0),np.complex(-0.0,-0.0),np.complex(0.0,0.5),np.complex(-2.0,-3.0)},{np.complex(-1.0,0.0),np.complex(4.0,0.5),np.complex(-0.0,1.0),np.complex(-1.0,-1.0)}}},np.complex128); local r=np.sum(a,3); assert(r.dtype=='complex128','complex reduce dtype 489'); assert(close(r:tolist(),{{np.complex(-3.0,2.0),np.complex(6.25,-2.5),np.complex(-0.75,4.5)},{np.complex(4.0,-2.0),np.complex(-2.0,-3.5),np.complex(2.0,0.5)}},2e-12),'complex reduce 489') end
do local a=np.array({{{np.complex(-3.0,1.0),np.complex(-2.0,0.0),np.complex(2.0,-0.0),np.complex(-0.0,1.0)},{np.complex(2.0,-1.0),np.complex(0.25,-3.0),np.complex(4.0,1.0),np.complex(-0.0,0.5)},{np.complex(-3.0,1.0),np.complex(-2.0,0.5),np.complex(4.0,0.0),np.complex(0.25,3.0)}},{{np.complex(-0.0,-3.0),np.complex(-1.0,3.0),np.complex(1.0,-3.0),np.complex(4.0,1.0)},{np.complex(-0.0,-1.0),np.complex(-0.0,-0.0),np.complex(0.0,0.5),np.complex(-2.0,-3.0)},{np.complex(-1.0,0.0),np.complex(4.0,0.5),np.complex(-0.0,1.0),np.complex(-1.0,-1.0)}}},np.complex128); local r=np.prod(a,3); assert(r.dtype=='complex128','complex reduce dtype 490'); assert(close(r:tolist(),{{np.complex(4.0,12.0),np.complex(13.75,-1.875),np.complex(47.5,62.5)},{np.complex(96.0,-78.0),np.complex(0.0,0.0),np.complex(-4.5,3.5)}},2e-12),'complex reduce 490') end
do local a=np.array({{{np.complex(-3.0,1.0),np.complex(-2.0,0.0),np.complex(2.0,-0.0),np.complex(-0.0,1.0)},{np.complex(2.0,-1.0),np.complex(0.25,-3.0),np.complex(4.0,1.0),np.complex(-0.0,0.5)},{np.complex(-3.0,1.0),np.complex(-2.0,0.5),np.complex(4.0,0.0),np.complex(0.25,3.0)}},{{np.complex(-0.0,-3.0),np.complex(-1.0,3.0),np.complex(1.0,-3.0),np.complex(4.0,1.0)},{np.complex(-0.0,-1.0),np.complex(-0.0,-0.0),np.complex(0.0,0.5),np.complex(-2.0,-3.0)},{np.complex(-1.0,0.0),np.complex(4.0,0.5),np.complex(-0.0,1.0),np.complex(-1.0,-1.0)}}},np.complex128); local r=np.mean(a,3); assert(r.dtype=='complex128','complex reduce dtype 491'); assert(close(r:tolist(),{{np.complex(-0.75,0.5),np.complex(1.5625,-0.625),np.complex(-0.1875,1.125)},{np.complex(1.0,-0.5),np.complex(-0.5,-0.875),np.complex(0.5,0.125)}},2e-12),'complex reduce 491') end
do local a=np.array({np.complex(2.0,-1.0),np.complex(4.0,-0.0),np.complex(0.0,-1.0),np.complex(-2.0,-0.0),np.complex(-0.0,-1.0),np.complex(-3.0,3.0),np.complex(0.0,0.0)},np.complex128); local r=np.sum(a,1); assert(close(r,np.complex(1.0,0.0),2e-12),'complex reduce scalar 492') end
do local a=np.array({np.complex(2.0,-1.0),np.complex(4.0,-0.0),np.complex(0.0,-1.0),np.complex(-2.0,-0.0),np.complex(-0.0,-1.0),np.complex(-3.0,3.0),np.complex(0.0,0.0)},np.complex128); local r=np.prod(a,1); assert(close(r,np.complex(-0.0,0.0),2e-12),'complex reduce scalar 493') end
do local a=np.array({np.complex(2.0,-1.0),np.complex(4.0,-0.0),np.complex(0.0,-1.0),np.complex(-2.0,-0.0),np.complex(-0.0,-1.0),np.complex(-3.0,3.0),np.complex(0.0,0.0)},np.complex128); local r=np.mean(a,1); assert(close(r,np.complex(0.14285714285714285,0.0),2e-12),'complex reduce scalar 494') end
do local a=np.array({np.complex(-1.0,0.5),np.complex(2.0,-3.0),np.complex(1.0,-1.0),np.complex(-1.0,0.0),np.complex(2.0,0.0),np.complex(-2.0,-3.0),np.complex(0.0,1.0)},np.complex128); local r=np.sum(a,1); assert(close(r,np.complex(1.0,-5.5),2e-12),'complex reduce scalar 495') end
do local a=np.array({np.complex(-1.0,0.5),np.complex(2.0,-3.0),np.complex(1.0,-1.0),np.complex(-1.0,0.0),np.complex(2.0,0.0),np.complex(-2.0,-3.0),np.complex(0.0,1.0)},np.complex128); local r=np.prod(a,1); assert(close(r,np.complex(-39.0,-13.0),2e-12),'complex reduce scalar 496') end
do local a=np.array({np.complex(-1.0,0.5),np.complex(2.0,-3.0),np.complex(1.0,-1.0),np.complex(-1.0,0.0),np.complex(2.0,0.0),np.complex(-2.0,-3.0),np.complex(0.0,1.0)},np.complex128); local r=np.mean(a,1); assert(close(r,np.complex(0.14285714285714285,-0.7857142857142857),2e-12),'complex reduce scalar 497') end
do local a=np.array({np.complex(2.0,1.0),np.complex(2.0,3.0),np.complex(-1.0,0.5),np.complex(-2.0,1.0),np.complex(0.25,0.5),np.complex(-1.0,-1.0),np.complex(2.0,1.0)},np.complex64); local r=np.sum(a,1); assert(close(r,np.complex(2.25,6.0),3e-05),'complex reduce scalar 498') end
do local a=np.array({np.complex(2.0,1.0),np.complex(2.0,3.0),np.complex(-1.0,0.5),np.complex(-2.0,1.0),np.complex(0.25,0.5),np.complex(-1.0,-1.0),np.complex(2.0,1.0)},np.complex64); local r=np.prod(a,1); assert(close(r,np.complex(34.375,-9.375),3e-05),'complex reduce scalar 499') end
do local a=np.array({np.complex(2.0,1.0),np.complex(2.0,3.0),np.complex(-1.0,0.5),np.complex(-2.0,1.0),np.complex(0.25,0.5),np.complex(-1.0,-1.0),np.complex(2.0,1.0)},np.complex64); local r=np.mean(a,1); assert(close(r,np.complex(0.3214285671710968,0.8571428656578064),3e-05),'complex reduce scalar 500') end
do local a=np.array({{{np.complex(-1.0,3.0),np.complex(-3.0,-0.0),np.complex(-2.0,0.5),np.complex(2.0,3.0)},{np.complex(4.0,-0.0),np.complex(-0.0,3.0),np.complex(0.25,1.0),np.complex(-1.0,1.0)},{np.complex(-2.0,3.0),np.complex(-3.0,-3.0),np.complex(0.0,1.0),np.complex(0.0,3.0)}},{{np.complex(-2.0,-1.0),np.complex(0.0,0.5),np.complex(0.0,0.5),np.complex(2.0,0.5)},{np.complex(2.0,3.0),np.complex(-3.0,-0.0),np.complex(1.0,-3.0),np.complex(4.0,-1.0)},{np.complex(-2.0,1.0),np.complex(2.0,-3.0),np.complex(-1.0,-1.0),np.complex(4.0,-3.0)}}},np.complex128); local r=np.sum(a,1); assert(r.dtype=='complex128','complex reduce dtype 501'); assert(close(r:tolist(),{{np.complex(-3.0,2.0),np.complex(-3.0,0.5),np.complex(-2.0,1.0),np.complex(4.0,3.5)},{np.complex(6.0,3.0),np.complex(-3.0,3.0),np.complex(1.25,-2.0),np.complex(3.0,0.0)},{np.complex(-4.0,4.0),np.complex(-1.0,-6.0),np.complex(-1.0,0.0),np.complex(4.0,0.0)}},2e-12),'complex reduce 501') end
do local a=np.array({{{np.complex(-1.0,3.0),np.complex(-3.0,-0.0),np.complex(-2.0,0.5),np.complex(2.0,3.0)},{np.complex(4.0,-0.0),np.complex(-0.0,3.0),np.complex(0.25,1.0),np.complex(-1.0,1.0)},{np.complex(-2.0,3.0),np.complex(-3.0,-3.0),np.complex(0.0,1.0),np.complex(0.0,3.0)}},{{np.complex(-2.0,-1.0),np.complex(0.0,0.5),np.complex(0.0,0.5),np.complex(2.0,0.5)},{np.complex(2.0,3.0),np.complex(-3.0,-0.0),np.complex(1.0,-3.0),np.complex(4.0,-1.0)},{np.complex(-2.0,1.0),np.complex(2.0,-3.0),np.complex(-1.0,-1.0),np.complex(4.0,-3.0)}}},np.complex128); local r=np.prod(a,1); assert(r.dtype=='complex128','complex reduce dtype 502'); assert(close(r:tolist(),{{np.complex(5.0,-5.0),np.complex(0.0,-1.5),np.complex(-0.25,-1.0),np.complex(2.5,7.0)},{np.complex(8.0,12.0),np.complex(0.0,-9.0),np.complex(3.25,0.25),np.complex(-3.0,5.0)},{np.complex(1.0,-8.0),np.complex(-15.0,3.0),np.complex(1.0,-1.0),np.complex(9.0,12.0)}},2e-12),'complex reduce 502') end
do local a=np.array({{{np.complex(-1.0,3.0),np.complex(-3.0,-0.0),np.complex(-2.0,0.5),np.complex(2.0,3.0)},{np.complex(4.0,-0.0),np.complex(-0.0,3.0),np.complex(0.25,1.0),np.complex(-1.0,1.0)},{np.complex(-2.0,3.0),np.complex(-3.0,-3.0),np.complex(0.0,1.0),np.complex(0.0,3.0)}},{{np.complex(-2.0,-1.0),np.complex(0.0,0.5),np.complex(0.0,0.5),np.complex(2.0,0.5)},{np.complex(2.0,3.0),np.complex(-3.0,-0.0),np.complex(1.0,-3.0),np.complex(4.0,-1.0)},{np.complex(-2.0,1.0),np.complex(2.0,-3.0),np.complex(-1.0,-1.0),np.complex(4.0,-3.0)}}},np.complex128); local r=np.mean(a,1); assert(r.dtype=='complex128','complex reduce dtype 503'); assert(close(r:tolist(),{{np.complex(-1.5,1.0),np.complex(-1.5,0.25),np.complex(-1.0,0.5),np.complex(2.0,1.75)},{np.complex(3.0,1.5),np.complex(-1.5,1.5),np.complex(0.625,-1.0),np.complex(1.5,0.0)},{np.complex(-2.0,2.0),np.complex(-0.5,-3.0),np.complex(-0.5,0.0),np.complex(2.0,0.0)}},2e-12),'complex reduce 503') end
do local a=np.array({np.complex(-1.0,-1.0),np.complex(0.0,-1.0),np.complex(0.25,0.0),np.complex(-3.0,-1.0),np.complex(0.0,-0.0),np.complex(-3.0,0.0),np.complex(-2.0,3.0)},np.complex64); local r=np.sum(a,1); assert(close(r,np.complex(-8.75,0.0),3e-05),'complex reduce scalar 504') end
do local a=np.array({np.complex(-1.0,-1.0),np.complex(0.0,-1.0),np.complex(0.25,0.0),np.complex(-3.0,-1.0),np.complex(0.0,-0.0),np.complex(-3.0,0.0),np.complex(-2.0,3.0)},np.complex64); local r=np.prod(a,1); assert(close(r,np.complex(-0.0,0.0),3e-05),'complex reduce scalar 505') end
do local a=np.array({np.complex(-1.0,-1.0),np.complex(0.0,-1.0),np.complex(0.25,0.0),np.complex(-3.0,-1.0),np.complex(0.0,-0.0),np.complex(-3.0,0.0),np.complex(-2.0,3.0)},np.complex64); local r=np.mean(a,1); assert(close(r,np.complex(-1.25,0.0),3e-05),'complex reduce scalar 506') end
do local a=np.array({{{np.complex(-0.0,3.0),np.complex(1.0,0.0),np.complex(-2.0,-0.0),np.complex(-1.0,-3.0)},{np.complex(0.25,1.0),np.complex(1.0,3.0),np.complex(4.0,1.0),np.complex(0.0,0.5)},{np.complex(4.0,0.0),np.complex(1.0,-1.0),np.complex(1.0,-1.0),np.complex(-0.0,3.0)}},{{np.complex(1.0,-0.0),np.complex(1.0,0.0),np.complex(0.25,1.0),np.complex(0.0,-1.0)},{np.complex(-3.0,3.0),np.complex(4.0,-1.0),np.complex(-2.0,-3.0),np.complex(0.0,-1.0)},{np.complex(1.0,-1.0),np.complex(2.0,0.0),np.complex(2.0,-0.0),np.complex(0.25,1.0)}}},np.complex64); local r=np.sum(a,3); assert(r.dtype=='complex64','complex reduce dtype 507'); assert(close(r:tolist(),{{np.complex(-2.0,0.0),np.complex(5.25,5.5),np.complex(6.0,1.0)},{np.complex(2.25,0.0),np.complex(-1.0,-2.0),np.complex(5.25,0.0)}},3e-05),'complex reduce 507') end
do local a=np.array({{{np.complex(-0.0,3.0),np.complex(1.0,0.0),np.complex(-2.0,-0.0),np.complex(-1.0,-3.0)},{np.complex(0.25,1.0),np.complex(1.0,3.0),np.complex(4.0,1.0),np.complex(0.0,0.5)},{np.complex(4.0,0.0),np.complex(1.0,-1.0),np.complex(1.0,-1.0),np.complex(-0.0,3.0)}},{{np.complex(1.0,-0.0),np.complex(1.0,0.0),np.complex(0.25,1.0),np.complex(0.0,-1.0)},{np.complex(-3.0,3.0),np.complex(4.0,-1.0),np.complex(-2.0,-3.0),np.complex(0.0,-1.0)},{np.complex(1.0,-1.0),np.complex(2.0,0.0),np.complex(2.0,-0.0),np.complex(0.25,1.0)}}},np.complex64); local r=np.prod(a,3); assert(r.dtype=='complex64','complex reduce dtype 508'); assert(close(r:tolist(),{{np.complex(-18.0,6.0),np.complex(-2.125,-6.375),np.complex(24.0,0.0)},{np.complex(1.0,-0.25),np.complex(-3.0,-63.0),np.complex(5.0,3.0)}},3e-05),'complex reduce 508') end
do local a=np.array({{{np.complex(-0.0,3.0),np.complex(1.0,0.0),np.complex(-2.0,-0.0),np.complex(-1.0,-3.0)},{np.complex(0.25,1.0),np.complex(1.0,3.0),np.complex(4.0,1.0),np.complex(0.0,0.5)},{np.complex(4.0,0.0),np.complex(1.0,-1.0),np.complex(1.0,-1.0),np.complex(-0.0,3.0)}},{{np.complex(1.0,-0.0),np.complex(1.0,0.0),np.complex(0.25,1.0),np.complex(0.0,-1.0)},{np.complex(-3.0,3.0),np.complex(4.0,-1.0),np.complex(-2.0,-3.0),np.complex(0.0,-1.0)},{np.complex(1.0,-1.0),np.complex(2.0,0.0),np.complex(2.0,-0.0),np.complex(0.25,1.0)}}},np.complex64); local r=np.mean(a,3); assert(r.dtype=='complex64','complex reduce dtype 509'); assert(close(r:tolist(),{{np.complex(-0.5,0.0),np.complex(1.3125,1.375),np.complex(1.5,0.25)},{np.complex(0.5625,0.0),np.complex(-0.25,-0.5),np.complex(1.3125,0.0)}},3e-05),'complex reduce 509') end
do local a=np.array({{{np.complex(0.25,3.0),np.complex(2.0,0.0),np.complex(-2.0,3.0),np.complex(-2.0,0.5)},{np.complex(2.0,0.5),np.complex(-1.0,-3.0),np.complex(-1.0,1.0),np.complex(4.0,0.0)},{np.complex(-2.0,1.0),np.complex(-0.0,1.0),np.complex(1.0,3.0),np.complex(-1.0,1.0)}},{{np.complex(0.25,1.0),np.complex(0.0,-0.0),np.complex(0.0,0.5),np.complex(2.0,1.0)},{np.complex(1.0,-1.0),np.complex(-1.0,-3.0),np.complex(-0.0,-0.0),np.complex(0.25,-1.0)},{np.complex(-0.0,-0.0),np.complex(1.0,1.0),np.complex(4.0,3.0),np.complex(1.0,-3.0)}}},np.complex128); local r=np.sum(a,2); assert(r.dtype=='complex128','complex reduce dtype 510'); assert(close(r:tolist(),{{np.complex(0.25,4.5),np.complex(1.0,-2.0),np.complex(-2.0,7.0),np.complex(1.0,1.5)},{np.complex(1.25,0.0),np.complex(0.0,-2.0),np.complex(4.0,3.5),np.complex(3.25,-3.0)}},2e-12),'complex reduce 510') end
do local a=np.array({{{np.complex(0.25,3.0),np.complex(2.0,0.0),np.complex(-2.0,3.0),np.complex(-2.0,0.5)},{np.complex(2.0,0.5),np.complex(-1.0,-3.0),np.complex(-1.0,1.0),np.complex(4.0,0.0)},{np.complex(-2.0,1.0),np.complex(-0.0,1.0),np.complex(1.0,3.0),np.complex(-1.0,1.0)}},{{np.complex(0.25,1.0),np.complex(0.0,-0.0),np.complex(0.0,0.5),np.complex(2.0,1.0)},{np.complex(1.0,-1.0),np.complex(-1.0,-3.0),np.complex(-0.0,-0.0),np.complex(0.25,-1.0)},{np.complex(-0.0,-0.0),np.complex(1.0,1.0),np.complex(4.0,3.0),np.complex(1.0,-3.0)}}},np.complex128); local r=np.prod(a,2); assert(r.dtype=='complex128','complex reduce dtype 511'); assert(close(r:tolist(),{{np.complex(-4.125,-13.25),np.complex(6.0,-2.0),np.complex(14.0,-8.0),np.complex(6.0,-10.0)},{np.complex(0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(-3.75,-6.25)}},2e-12),'complex reduce 511') end
do local a=np.array({{{np.complex(0.25,3.0),np.complex(2.0,0.0),np.complex(-2.0,3.0),np.complex(-2.0,0.5)},{np.complex(2.0,0.5),np.complex(-1.0,-3.0),np.complex(-1.0,1.0),np.complex(4.0,0.0)},{np.complex(-2.0,1.0),np.complex(-0.0,1.0),np.complex(1.0,3.0),np.complex(-1.0,1.0)}},{{np.complex(0.25,1.0),np.complex(0.0,-0.0),np.complex(0.0,0.5),np.complex(2.0,1.0)},{np.complex(1.0,-1.0),np.complex(-1.0,-3.0),np.complex(-0.0,-0.0),np.complex(0.25,-1.0)},{np.complex(-0.0,-0.0),np.complex(1.0,1.0),np.complex(4.0,3.0),np.complex(1.0,-3.0)}}},np.complex128); local r=np.mean(a,2); assert(r.dtype=='complex128','complex reduce dtype 512'); assert(close(r:tolist(),{{np.complex(0.08333333333333333,1.5),np.complex(0.3333333333333333,-0.6666666666666666),np.complex(-0.6666666666666666,2.333333333333333),np.complex(0.3333333333333333,0.5)},{np.complex(0.41666666666666663,0.0),np.complex(0.0,-0.6666666666666666),np.complex(1.3333333333333333,1.1666666666666665),np.complex(1.0833333333333333,-1.0)}},2e-12),'complex reduce 512') end
do local a=np.array({np.complex(-3.0,-3.0),np.complex(0.25,-3.0),np.complex(1.0,0.5),np.complex(2.0,0.0),np.complex(-0.0,0.5),np.complex(1.0,-0.0),np.complex(0.25,-3.0)},np.complex64); local r=np.sum(a,1); assert(close(r,np.complex(1.5,-8.0),3e-05),'complex reduce scalar 513') end
do local a=np.array({np.complex(-3.0,-3.0),np.complex(0.25,-3.0),np.complex(1.0,0.5),np.complex(2.0,0.0),np.complex(-0.0,0.5),np.complex(1.0,-0.0),np.complex(0.25,-3.0)},np.complex64); local r=np.prod(a,1); assert(close(r,np.complex(-42.46875,6.65625),3e-05),'complex reduce scalar 514') end
do local a=np.array({np.complex(-3.0,-3.0),np.complex(0.25,-3.0),np.complex(1.0,0.5),np.complex(2.0,0.0),np.complex(-0.0,0.5),np.complex(1.0,-0.0),np.complex(0.25,-3.0)},np.complex64); local r=np.mean(a,1); assert(close(r,np.complex(0.2142857164144516,-1.1428571939468384),3e-05),'complex reduce scalar 515') end
do local a=np.array({np.complex(4.0,0.0),np.complex(-0.0,1.0),np.complex(4.0,0.0),np.complex(0.0,-3.0),np.complex(1.0,-3.0),np.complex(2.0,1.0),np.complex(-0.0,3.0)},np.complex64); local r=np.sum(a,1); assert(close(r,np.complex(11.0,-1.0),3e-05),'complex reduce scalar 516') end
do local a=np.array({np.complex(4.0,0.0),np.complex(-0.0,1.0),np.complex(4.0,0.0),np.complex(0.0,-3.0),np.complex(1.0,-3.0),np.complex(2.0,1.0),np.complex(-0.0,3.0)},np.complex64); local r=np.prod(a,1); assert(close(r,np.complex(720.0,720.0),3e-05),'complex reduce scalar 517') end
do local a=np.array({np.complex(4.0,0.0),np.complex(-0.0,1.0),np.complex(4.0,0.0),np.complex(0.0,-3.0),np.complex(1.0,-3.0),np.complex(2.0,1.0),np.complex(-0.0,3.0)},np.complex64); local r=np.mean(a,1); assert(close(r,np.complex(1.5714285373687744,-0.1428571492433548),3e-05),'complex reduce scalar 518') end
do local a=np.array({np.complex(-1.0,3.0),np.complex(-0.0,3.0),np.complex(0.0,0.0),np.complex(-2.0,0.5),np.complex(2.0,1.0),np.complex(0.25,-3.0),np.complex(0.0,0.5)},np.complex64); local r=np.sum(a,1); assert(close(r,np.complex(-0.75,5.0),3e-05),'complex reduce scalar 519') end
do local a=np.array({np.complex(-1.0,3.0),np.complex(-0.0,3.0),np.complex(0.0,0.0),np.complex(-2.0,0.5),np.complex(2.0,1.0),np.complex(0.25,-3.0),np.complex(0.0,0.5)},np.complex64); local r=np.prod(a,1); assert(close(r,np.complex(0.0,0.0),3e-05),'complex reduce scalar 520') end
do local a=np.array({np.complex(-1.0,3.0),np.complex(-0.0,3.0),np.complex(0.0,0.0),np.complex(-2.0,0.5),np.complex(2.0,1.0),np.complex(0.25,-3.0),np.complex(0.0,0.5)},np.complex64); local r=np.mean(a,1); assert(close(r,np.complex(-0.1071428582072258,0.7142857313156128),3e-05),'complex reduce scalar 521') end
do local a=np.array({{{np.complex(-3.0,1.0),np.complex(-1.0,0.0),np.complex(0.25,0.0),np.complex(4.0,1.0)},{np.complex(0.25,0.0),np.complex(2.0,3.0),np.complex(0.25,-0.0),np.complex(0.0,-1.0)},{np.complex(4.0,-1.0),np.complex(2.0,3.0),np.complex(0.25,3.0),np.complex(0.25,1.0)}},{{np.complex(-0.0,1.0),np.complex(-3.0,-0.0),np.complex(-0.0,-1.0),np.complex(2.0,-3.0)},{np.complex(0.25,-1.0),np.complex(0.0,0.5),np.complex(4.0,-1.0),np.complex(-0.0,-0.0)},{np.complex(0.25,1.0),np.complex(0.0,-1.0),np.complex(-2.0,1.0),np.complex(0.0,-3.0)}}},np.complex128); local r=np.sum(a,1); assert(r.dtype=='complex128','complex reduce dtype 522'); assert(close(r:tolist(),{{np.complex(-3.0,2.0),np.complex(-4.0,0.0),np.complex(0.25,-1.0),np.complex(6.0,-2.0)},{np.complex(0.5,-1.0),np.complex(2.0,3.5),np.complex(4.25,-1.0),np.complex(0.0,-1.0)},{np.complex(4.25,0.0),np.complex(2.0,2.0),np.complex(-1.75,4.0),np.complex(0.25,-2.0)}},2e-12),'complex reduce 522') end
do local a=np.array({{{np.complex(-3.0,1.0),np.complex(-1.0,0.0),np.complex(0.25,0.0),np.complex(4.0,1.0)},{np.complex(0.25,0.0),np.complex(2.0,3.0),np.complex(0.25,-0.0),np.complex(0.0,-1.0)},{np.complex(4.0,-1.0),np.complex(2.0,3.0),np.complex(0.25,3.0),np.complex(0.25,1.0)}},{{np.complex(-0.0,1.0),np.complex(-3.0,-0.0),np.complex(-0.0,-1.0),np.complex(2.0,-3.0)},{np.complex(0.25,-1.0),np.complex(0.0,0.5),np.complex(4.0,-1.0),np.complex(-0.0,-0.0)},{np.complex(0.25,1.0),np.complex(0.0,-1.0),np.complex(-2.0,1.0),np.complex(0.0,-3.0)}}},np.complex128); local r=np.prod(a,1); assert(r.dtype=='complex128','complex reduce dtype 523'); assert(close(r:tolist(),{{np.complex(-1.0,-3.0),np.complex(3.0,0.0),np.complex(0.0,-0.25),np.complex(11.0,-10.0)},{np.complex(0.0625,-0.25),np.complex(-1.5,1.0),np.complex(1.0,-0.25),np.complex(-0.0,0.0)},{np.complex(2.0,3.75),np.complex(3.0,-2.0),np.complex(-3.5,-5.75),np.complex(3.0,-0.75)}},2e-12),'complex reduce 523') end
do local a=np.array({{{np.complex(-3.0,1.0),np.complex(-1.0,0.0),np.complex(0.25,0.0),np.complex(4.0,1.0)},{np.complex(0.25,0.0),np.complex(2.0,3.0),np.complex(0.25,-0.0),np.complex(0.0,-1.0)},{np.complex(4.0,-1.0),np.complex(2.0,3.0),np.complex(0.25,3.0),np.complex(0.25,1.0)}},{{np.complex(-0.0,1.0),np.complex(-3.0,-0.0),np.complex(-0.0,-1.0),np.complex(2.0,-3.0)},{np.complex(0.25,-1.0),np.complex(0.0,0.5),np.complex(4.0,-1.0),np.complex(-0.0,-0.0)},{np.complex(0.25,1.0),np.complex(0.0,-1.0),np.complex(-2.0,1.0),np.complex(0.0,-3.0)}}},np.complex128); local r=np.mean(a,1); assert(r.dtype=='complex128','complex reduce dtype 524'); assert(close(r:tolist(),{{np.complex(-1.5,1.0),np.complex(-2.0,0.0),np.complex(0.125,-0.5),np.complex(3.0,-1.0)},{np.complex(0.25,-0.5),np.complex(1.0,1.75),np.complex(2.125,-0.5),np.complex(0.0,-0.5)},{np.complex(2.125,0.0),np.complex(1.0,1.0),np.complex(-0.875,2.0),np.complex(0.125,-1.0)}},2e-12),'complex reduce 524') end
do local a=np.array({np.complex(-3.0,-3.0),np.complex(2.0,0.0),np.complex(4.0,0.5),np.complex(-3.0,0.5),np.complex(-0.0,3.0),np.complex(-1.0,-0.0),np.complex(-0.0,-1.0)},np.complex64); local r=np.sum(a,1); assert(close(r,np.complex(-1.0,0.0),3e-05),'complex reduce scalar 525') end
do local a=np.array({np.complex(-3.0,-3.0),np.complex(2.0,0.0),np.complex(4.0,0.5),np.complex(-3.0,0.5),np.complex(-0.0,3.0),np.complex(-1.0,-0.0),np.complex(-0.0,-1.0)},np.complex64); local r=np.prod(a,1); assert(close(r,np.complex(-229.5,-211.5),3e-05),'complex reduce scalar 526') end
do local a=np.array({np.complex(-3.0,-3.0),np.complex(2.0,0.0),np.complex(4.0,0.5),np.complex(-3.0,0.5),np.complex(-0.0,3.0),np.complex(-1.0,-0.0),np.complex(-0.0,-1.0)},np.complex64); local r=np.mean(a,1); assert(close(r,np.complex(-0.1428571492433548,0.0),3e-05),'complex reduce scalar 527') end
do local a=np.array({np.complex(1.0,0.5),np.complex(-1.0,-1.0),np.complex(-3.0,-0.0),np.complex(-2.0,0.0),np.complex(-3.0,-1.0),np.complex(2.0,0.0),np.complex(0.25,-0.0)},np.complex64); local r=np.sum(a,1); assert(close(r,np.complex(-5.75,-1.5),3e-05),'complex reduce scalar 528') end
do local a=np.array({np.complex(1.0,0.5),np.complex(-1.0,-1.0),np.complex(-3.0,-0.0),np.complex(-2.0,0.0),np.complex(-3.0,-1.0),np.complex(2.0,0.0),np.complex(0.25,-0.0)},np.complex64); local r=np.prod(a,1); assert(close(r,np.complex(0.0,15.0),3e-05),'complex reduce scalar 529') end
do local a=np.array({np.complex(1.0,0.5),np.complex(-1.0,-1.0),np.complex(-3.0,-0.0),np.complex(-2.0,0.0),np.complex(-3.0,-1.0),np.complex(2.0,0.0),np.complex(0.25,-0.0)},np.complex64); local r=np.mean(a,1); assert(close(r,np.complex(-0.8214285969734192,-0.2142857164144516),3e-05),'complex reduce scalar 530') end
do local a=np.array({{{np.complex(-1.0,3.0),np.complex(-3.0,0.0),np.complex(-0.0,-1.0),np.complex(0.0,3.0)},{np.complex(-3.0,1.0),np.complex(-2.0,1.0),np.complex(1.0,0.0),np.complex(0.0,0.5)},{np.complex(-1.0,-1.0),np.complex(0.0,-1.0),np.complex(-2.0,-3.0),np.complex(-1.0,3.0)}},{{np.complex(0.0,-1.0),np.complex(1.0,0.0),np.complex(4.0,1.0),np.complex(4.0,-0.0)},{np.complex(-1.0,-1.0),np.complex(-2.0,3.0),np.complex(1.0,0.5),np.complex(0.0,0.5)},{np.complex(0.25,-1.0),np.complex(-0.0,-1.0),np.complex(2.0,-1.0),np.complex(-1.0,-0.0)}}},np.complex64); local r=np.sum(a,1); assert(r.dtype=='complex64','complex reduce dtype 531'); assert(close(r:tolist(),{{np.complex(-1.0,2.0),np.complex(-2.0,0.0),np.complex(4.0,0.0),np.complex(4.0,3.0)},{np.complex(-4.0,0.0),np.complex(-4.0,4.0),np.complex(2.0,0.5),np.complex(0.0,1.0)},{np.complex(-0.75,-2.0),np.complex(0.0,-2.0),np.complex(0.0,-4.0),np.complex(-2.0,3.0)}},3e-05),'complex reduce 531') end
do local a=np.array({{{np.complex(-1.0,3.0),np.complex(-3.0,0.0),np.complex(-0.0,-1.0),np.complex(0.0,3.0)},{np.complex(-3.0,1.0),np.complex(-2.0,1.0),np.complex(1.0,0.0),np.complex(0.0,0.5)},{np.complex(-1.0,-1.0),np.complex(0.0,-1.0),np.complex(-2.0,-3.0),np.complex(-1.0,3.0)}},{{np.complex(0.0,-1.0),np.complex(1.0,0.0),np.complex(4.0,1.0),np.complex(4.0,-0.0)},{np.complex(-1.0,-1.0),np.complex(-2.0,3.0),np.complex(1.0,0.5),np.complex(0.0,0.5)},{np.complex(0.25,-1.0),np.complex(-0.0,-1.0),np.complex(2.0,-1.0),np.complex(-1.0,-0.0)}}},np.complex64); local r=np.prod(a,1); assert(r.dtype=='complex64','complex reduce dtype 532'); assert(close(r:tolist(),{{np.complex(3.0,1.0),np.complex(-3.0,0.0),np.complex(1.0,-4.0),np.complex(0.0,12.0)},{np.complex(4.0,2.0),np.complex(1.0,-8.0),np.complex(1.0,0.5),np.complex(-0.25,0.0)},{np.complex(-1.25,0.75),np.complex(-1.0,0.0),np.complex(-7.0,-4.0),np.complex(1.0,-3.0)}},3e-05),'complex reduce 532') end
do local a=np.array({{{np.complex(-1.0,3.0),np.complex(-3.0,0.0),np.complex(-0.0,-1.0),np.complex(0.0,3.0)},{np.complex(-3.0,1.0),np.complex(-2.0,1.0),np.complex(1.0,0.0),np.complex(0.0,0.5)},{np.complex(-1.0,-1.0),np.complex(0.0,-1.0),np.complex(-2.0,-3.0),np.complex(-1.0,3.0)}},{{np.complex(0.0,-1.0),np.complex(1.0,0.0),np.complex(4.0,1.0),np.complex(4.0,-0.0)},{np.complex(-1.0,-1.0),np.complex(-2.0,3.0),np.complex(1.0,0.5),np.complex(0.0,0.5)},{np.complex(0.25,-1.0),np.complex(-0.0,-1.0),np.complex(2.0,-1.0),np.complex(-1.0,-0.0)}}},np.complex64); local r=np.mean(a,1); assert(r.dtype=='complex64','complex reduce dtype 533'); assert(close(r:tolist(),{{np.complex(-0.5,1.0),np.complex(-1.0,0.0),np.complex(2.0,0.0),np.complex(2.0,1.5)},{np.complex(-2.0,0.0),np.complex(-2.0,2.0),np.complex(1.0,0.25),np.complex(0.0,0.5)},{np.complex(-0.375,-1.0),np.complex(0.0,-1.0),np.complex(0.0,-2.0),np.complex(-1.0,1.5)}},3e-05),'complex reduce 533') end
do local a=np.array({np.complex(-0.0,3.0),np.complex(-2.0,-0.0),np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(0.25,0.5),np.complex(-2.0,0.0),np.complex(0.0,1.0)},np.complex64); local r=np.sum(a,1); assert(close(r,np.complex(-1.75,4.5),3e-05),'complex reduce scalar 534') end
do local a=np.array({np.complex(-0.0,3.0),np.complex(-2.0,-0.0),np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(0.25,0.5),np.complex(-2.0,0.0),np.complex(0.0,1.0)},np.complex64); local r=np.prod(a,1); assert(close(r,np.complex(-0.0,0.0),3e-05),'complex reduce scalar 535') end
do local a=np.array({np.complex(-0.0,3.0),np.complex(-2.0,-0.0),np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(0.25,0.5),np.complex(-2.0,0.0),np.complex(0.0,1.0)},np.complex64); local r=np.mean(a,1); assert(close(r,np.complex(-0.25,0.6428571343421936),3e-05),'complex reduce scalar 536') end
do local a=np.array({{np.complex(0.0,1.0),np.complex(-1.0,-1.0),np.complex(-0.0,1.0),np.complex(4.0,-0.0),np.complex(-3.0,-3.0)},{np.complex(1.0,3.0),np.complex(-3.0,1.0),np.complex(2.0,1.0),np.complex(0.25,1.0),np.complex(-0.0,0.5)}},np.complex64); local r=np.sum(a,1); assert(r.dtype=='complex64','complex reduce dtype 537'); assert(close(r:tolist(),{np.complex(1.0,4.0),np.complex(-4.0,0.0),np.complex(2.0,2.0),np.complex(4.25,1.0),np.complex(-3.0,-2.5)},3e-05),'complex reduce 537') end
do local a=np.array({{np.complex(0.0,1.0),np.complex(-1.0,-1.0),np.complex(-0.0,1.0),np.complex(4.0,-0.0),np.complex(-3.0,-3.0)},{np.complex(1.0,3.0),np.complex(-3.0,1.0),np.complex(2.0,1.0),np.complex(0.25,1.0),np.complex(-0.0,0.5)}},np.complex64); local r=np.prod(a,1); assert(r.dtype=='complex64','complex reduce dtype 538'); assert(close(r:tolist(),{np.complex(-3.0,1.0),np.complex(4.0,2.0),np.complex(-1.0,2.0),np.complex(1.0,4.0),np.complex(1.5,-1.5)},3e-05),'complex reduce 538') end
do local a=np.array({{np.complex(0.0,1.0),np.complex(-1.0,-1.0),np.complex(-0.0,1.0),np.complex(4.0,-0.0),np.complex(-3.0,-3.0)},{np.complex(1.0,3.0),np.complex(-3.0,1.0),np.complex(2.0,1.0),np.complex(0.25,1.0),np.complex(-0.0,0.5)}},np.complex64); local r=np.mean(a,1); assert(r.dtype=='complex64','complex reduce dtype 539'); assert(close(r:tolist(),{np.complex(0.5,2.0),np.complex(-2.0,0.0),np.complex(1.0,1.0),np.complex(2.125,0.5),np.complex(-1.5,-1.25)},3e-05),'complex reduce 539') end
do local a=np.array({{{np.complex(-2.0,0.0),np.complex(2.0,3.0),np.complex(0.25,-1.0),np.complex(4.0,0.5)},{np.complex(0.0,0.5),np.complex(2.0,0.0),np.complex(-3.0,-0.0),np.complex(4.0,3.0)},{np.complex(-0.0,0.5),np.complex(-1.0,3.0),np.complex(0.25,3.0),np.complex(-1.0,-0.0)}},{{np.complex(-3.0,-1.0),np.complex(0.25,-3.0),np.complex(-3.0,-3.0),np.complex(-2.0,-3.0)},{np.complex(1.0,-0.0),np.complex(0.0,0.0),np.complex(-1.0,3.0),np.complex(-0.0,0.0)},{np.complex(-0.0,3.0),np.complex(0.25,0.5),np.complex(4.0,1.0),np.complex(0.0,0.0)}}},np.complex128); local r=np.sum(a,3); assert(r.dtype=='complex128','complex reduce dtype 540'); assert(close(r:tolist(),{{np.complex(4.25,2.5),np.complex(3.0,3.5),np.complex(-1.75,6.5)},{np.complex(-7.75,-10.0),np.complex(0.0,3.0),np.complex(4.25,4.5)}},2e-12),'complex reduce 540') end
do local a=np.array({{{np.complex(-2.0,0.0),np.complex(2.0,3.0),np.complex(0.25,-1.0),np.complex(4.0,0.5)},{np.complex(0.0,0.5),np.complex(2.0,0.0),np.complex(-3.0,-0.0),np.complex(4.0,3.0)},{np.complex(-0.0,0.5),np.complex(-1.0,3.0),np.complex(0.25,3.0),np.complex(-1.0,-0.0)}},{{np.complex(-3.0,-1.0),np.complex(0.25,-3.0),np.complex(-3.0,-3.0),np.complex(-2.0,-3.0)},{np.complex(1.0,-0.0),np.complex(0.0,0.0),np.complex(-1.0,3.0),np.complex(-0.0,0.0)},{np.complex(-0.0,3.0),np.complex(0.25,0.5),np.complex(4.0,1.0),np.complex(0.0,0.0)}}},np.complex128); local r=np.prod(a,3); assert(r.dtype=='complex128','complex reduce dtype 541'); assert(close(r:tolist(),{{np.complex(-29.25,6.5),np.complex(9.0,-12.0),np.complex(-1.125,4.625)},{np.complex(-120.0,-82.5),np.complex(0.0,-0.0),np.complex(-0.0,0.0)}},2e-12),'complex reduce 541') end
do local a=np.array({{{np.complex(-2.0,0.0),np.complex(2.0,3.0),np.complex(0.25,-1.0),np.complex(4.0,0.5)},{np.complex(0.0,0.5),np.complex(2.0,0.0),np.complex(-3.0,-0.0),np.complex(4.0,3.0)},{np.complex(-0.0,0.5),np.complex(-1.0,3.0),np.complex(0.25,3.0),np.complex(-1.0,-0.0)}},{{np.complex(-3.0,-1.0),np.complex(0.25,-3.0),np.complex(-3.0,-3.0),np.complex(-2.0,-3.0)},{np.complex(1.0,-0.0),np.complex(0.0,0.0),np.complex(-1.0,3.0),np.complex(-0.0,0.0)},{np.complex(-0.0,3.0),np.complex(0.25,0.5),np.complex(4.0,1.0),np.complex(0.0,0.0)}}},np.complex128); local r=np.mean(a,3); assert(r.dtype=='complex128','complex reduce dtype 542'); assert(close(r:tolist(),{{np.complex(1.0625,0.625),np.complex(0.75,0.875),np.complex(-0.4375,1.625)},{np.complex(-1.9375,-2.5),np.complex(0.0,0.75),np.complex(1.0625,1.125)}},2e-12),'complex reduce 542') end
do local a=np.array({np.complex(2.0,-3.0),np.complex(-2.0,0.5),np.complex(-0.0,-3.0),np.complex(0.0,0.5),np.complex(-0.0,-1.0),np.complex(-3.0,3.0),np.complex(1.0,-3.0)},np.complex64); local r=np.sum(a,1); assert(close(r,np.complex(-2.0,-6.0),3e-05),'complex reduce scalar 543') end
do local a=np.array({np.complex(2.0,-3.0),np.complex(-2.0,0.5),np.complex(-0.0,-3.0),np.complex(0.0,0.5),np.complex(-0.0,-1.0),np.complex(-3.0,3.0),np.complex(1.0,-3.0)},np.complex64); local r=np.prod(a,1); assert(close(r,np.complex(18.0,148.5),3e-05),'complex reduce scalar 544') end
do local a=np.array({np.complex(2.0,-3.0),np.complex(-2.0,0.5),np.complex(-0.0,-3.0),np.complex(0.0,0.5),np.complex(-0.0,-1.0),np.complex(-3.0,3.0),np.complex(1.0,-3.0)},np.complex64); local r=np.mean(a,1); assert(close(r,np.complex(-0.2857142984867096,-0.8571428656578064),3e-05),'complex reduce scalar 545') end
do local a=np.array({{np.complex(-2.0,0.5),np.complex(4.0,0.5),np.complex(1.0,0.5),np.complex(-3.0,-3.0),np.complex(-0.0,-3.0)},{np.complex(-0.0,-3.0),np.complex(-1.0,0.0),np.complex(0.0,0.5),np.complex(-2.0,1.0),np.complex(-2.0,1.0)}},np.complex64); local r=np.sum(a,1); assert(r.dtype=='complex64','complex reduce dtype 546'); assert(close(r:tolist(),{np.complex(-2.0,-2.5),np.complex(3.0,0.5),np.complex(1.0,1.0),np.complex(-5.0,-2.0),np.complex(-2.0,-2.0)},3e-05),'complex reduce 546') end
do local a=np.array({{np.complex(-2.0,0.5),np.complex(4.0,0.5),np.complex(1.0,0.5),np.complex(-3.0,-3.0),np.complex(-0.0,-3.0)},{np.complex(-0.0,-3.0),np.complex(-1.0,0.0),np.complex(0.0,0.5),np.complex(-2.0,1.0),np.complex(-2.0,1.0)}},np.complex64); local r=np.prod(a,1); assert(r.dtype=='complex64','complex reduce dtype 547'); assert(close(r:tolist(),{np.complex(1.5,6.0),np.complex(-4.0,-0.5),np.complex(-0.25,0.5),np.complex(9.0,3.0),np.complex(3.0,6.0)},3e-05),'complex reduce 547') end
do local a=np.array({{np.complex(-2.0,0.5),np.complex(4.0,0.5),np.complex(1.0,0.5),np.complex(-3.0,-3.0),np.complex(-0.0,-3.0)},{np.complex(-0.0,-3.0),np.complex(-1.0,0.0),np.complex(0.0,0.5),np.complex(-2.0,1.0),np.complex(-2.0,1.0)}},np.complex64); local r=np.mean(a,1); assert(r.dtype=='complex64','complex reduce dtype 548'); assert(close(r:tolist(),{np.complex(-1.0,-1.25),np.complex(1.5,0.25),np.complex(0.5,0.5),np.complex(-2.5,-1.0),np.complex(-1.0,-1.0)},3e-05),'complex reduce 548') end
do local a=np.array({{{np.complex(-2.0,-1.0),np.complex(1.0,3.0),np.complex(-3.0,-0.0),np.complex(4.0,-3.0)},{np.complex(-3.0,0.0),np.complex(0.25,-1.0),np.complex(2.0,0.0),np.complex(0.0,-0.0)},{np.complex(4.0,-3.0),np.complex(0.0,3.0),np.complex(-0.0,1.0),np.complex(-3.0,0.0)}},{{np.complex(0.25,0.5),np.complex(-2.0,-3.0),np.complex(-3.0,0.5),np.complex(2.0,-1.0)},{np.complex(-3.0,3.0),np.complex(-1.0,-1.0),np.complex(2.0,1.0),np.complex(0.0,3.0)},{np.complex(-3.0,1.0),np.complex(4.0,0.5),np.complex(2.0,3.0),np.complex(0.25,3.0)}}},np.complex128); local r=np.sum(a,3); assert(r.dtype=='complex128','complex reduce dtype 549'); assert(close(r:tolist(),{{np.complex(0.0,-1.0),np.complex(-0.75,-1.0),np.complex(1.0,1.0)},{np.complex(-2.75,-3.0),np.complex(-2.0,6.0),np.complex(3.25,7.5)}},2e-12),'complex reduce 549') end
do local a=np.array({{{np.complex(-2.0,-1.0),np.complex(1.0,3.0),np.complex(-3.0,-0.0),np.complex(4.0,-3.0)},{np.complex(-3.0,0.0),np.complex(0.25,-1.0),np.complex(2.0,0.0),np.complex(0.0,-0.0)},{np.complex(4.0,-3.0),np.complex(0.0,3.0),np.complex(-0.0,1.0),np.complex(-3.0,0.0)}},{{np.complex(0.25,0.5),np.complex(-2.0,-3.0),np.complex(-3.0,0.5),np.complex(2.0,-1.0)},{np.complex(-3.0,3.0),np.complex(-1.0,-1.0),np.complex(2.0,1.0),np.complex(0.0,3.0)},{np.complex(-3.0,1.0),np.complex(4.0,0.5),np.complex(2.0,3.0),np.complex(0.25,3.0)}}},np.complex128); local r=np.prod(a,3); assert(r.dtype=='complex128','complex reduce dtype 550'); assert(close(r:tolist(),{{np.complex(51.0,93.0),np.complex(0.0,0.0),np.complex(36.0,-27.0)},{np.complex(1.5,13.625),np.complex(-18.0,36.0),np.complex(89.375,-105.625)}},2e-12),'complex reduce 550') end
do local a=np.array({{{np.complex(-2.0,-1.0),np.complex(1.0,3.0),np.complex(-3.0,-0.0),np.complex(4.0,-3.0)},{np.complex(-3.0,0.0),np.complex(0.25,-1.0),np.complex(2.0,0.0),np.complex(0.0,-0.0)},{np.complex(4.0,-3.0),np.complex(0.0,3.0),np.complex(-0.0,1.0),np.complex(-3.0,0.0)}},{{np.complex(0.25,0.5),np.complex(-2.0,-3.0),np.complex(-3.0,0.5),np.complex(2.0,-1.0)},{np.complex(-3.0,3.0),np.complex(-1.0,-1.0),np.complex(2.0,1.0),np.complex(0.0,3.0)},{np.complex(-3.0,1.0),np.complex(4.0,0.5),np.complex(2.0,3.0),np.complex(0.25,3.0)}}},np.complex128); local r=np.mean(a,3); assert(r.dtype=='complex128','complex reduce dtype 551'); assert(close(r:tolist(),{{np.complex(0.0,-0.25),np.complex(-0.1875,-0.25),np.complex(0.25,0.25)},{np.complex(-0.6875,-0.75),np.complex(-0.5,1.5),np.complex(0.8125,1.875)}},2e-12),'complex reduce 551') end
do local a=np.array({{{np.complex(0.0,3.0),np.complex(4.0,-1.0),np.complex(2.0,-0.0),np.complex(-3.0,0.5)},{np.complex(0.0,-3.0),np.complex(0.0,-3.0),np.complex(-3.0,3.0),np.complex(4.0,0.5)},{np.complex(-2.0,-1.0),np.complex(1.0,-3.0),np.complex(-1.0,1.0),np.complex(4.0,-3.0)}},{{np.complex(1.0,3.0),np.complex(-3.0,-0.0),np.complex(-1.0,0.0),np.complex(2.0,-0.0)},{np.complex(2.0,-0.0),np.complex(4.0,0.0),np.complex(4.0,0.5),np.complex(4.0,0.5)},{np.complex(0.25,0.5),np.complex(4.0,0.0),np.complex(1.0,-3.0),np.complex(-1.0,1.0)}}},np.complex128); local r=np.sum(a,1); assert(r.dtype=='complex128','complex reduce dtype 552'); assert(close(r:tolist(),{{np.complex(1.0,6.0),np.complex(1.0,-1.0),np.complex(1.0,0.0),np.complex(-1.0,0.5)},{np.complex(2.0,-3.0),np.complex(4.0,-3.0),np.complex(1.0,3.5),np.complex(8.0,1.0)},{np.complex(-1.75,-0.5),np.complex(5.0,-3.0),np.complex(0.0,-2.0),np.complex(3.0,-2.0)}},2e-12),'complex reduce 552') end
do local a=np.array({{{np.complex(0.0,3.0),np.complex(4.0,-1.0),np.complex(2.0,-0.0),np.complex(-3.0,0.5)},{np.complex(0.0,-3.0),np.complex(0.0,-3.0),np.complex(-3.0,3.0),np.complex(4.0,0.5)},{np.complex(-2.0,-1.0),np.complex(1.0,-3.0),np.complex(-1.0,1.0),np.complex(4.0,-3.0)}},{{np.complex(1.0,3.0),np.complex(-3.0,-0.0),np.complex(-1.0,0.0),np.complex(2.0,-0.0)},{np.complex(2.0,-0.0),np.complex(4.0,0.0),np.complex(4.0,0.5),np.complex(4.0,0.5)},{np.complex(0.25,0.5),np.complex(4.0,0.0),np.complex(1.0,-3.0),np.complex(-1.0,1.0)}}},np.complex128); local r=np.prod(a,1); assert(r.dtype=='complex128','complex reduce dtype 553'); assert(close(r:tolist(),{{np.complex(-9.0,3.0),np.complex(-12.0,3.0),np.complex(-2.0,0.0),np.complex(-6.0,1.0)},{np.complex(0.0,-6.0),np.complex(0.0,-12.0),np.complex(-13.5,10.5),np.complex(15.75,4.0)},{np.complex(0.0,-1.25),np.complex(4.0,-12.0),np.complex(2.0,4.0),np.complex(-1.0,7.0)}},2e-12),'complex reduce 553') end
do local a=np.array({{{np.complex(0.0,3.0),np.complex(4.0,-1.0),np.complex(2.0,-0.0),np.complex(-3.0,0.5)},{np.complex(0.0,-3.0),np.complex(0.0,-3.0),np.complex(-3.0,3.0),np.complex(4.0,0.5)},{np.complex(-2.0,-1.0),np.complex(1.0,-3.0),np.complex(-1.0,1.0),np.complex(4.0,-3.0)}},{{np.complex(1.0,3.0),np.complex(-3.0,-0.0),np.complex(-1.0,0.0),np.complex(2.0,-0.0)},{np.complex(2.0,-0.0),np.complex(4.0,0.0),np.complex(4.0,0.5),np.complex(4.0,0.5)},{np.complex(0.25,0.5),np.complex(4.0,0.0),np.complex(1.0,-3.0),np.complex(-1.0,1.0)}}},np.complex128); local r=np.mean(a,1); assert(r.dtype=='complex128','complex reduce dtype 554'); assert(close(r:tolist(),{{np.complex(0.5,3.0),np.complex(0.5,-0.5),np.complex(0.5,0.0),np.complex(-0.5,0.25)},{np.complex(1.0,-1.5),np.complex(2.0,-1.5),np.complex(0.5,1.75),np.complex(4.0,0.5)},{np.complex(-0.875,-0.25),np.complex(2.5,-1.5),np.complex(0.0,-1.0),np.complex(1.5,-1.0)}},2e-12),'complex reduce 554') end
do local a=np.array({np.complex(4.0,3.0),np.complex(1.0,0.0),np.complex(-1.0,-3.0),np.complex(-3.0,0.5),np.complex(2.0,-1.0),np.complex(-3.0,1.0),np.complex(1.0,3.0)},np.complex64); local r=np.sum(a,1); assert(close(r,np.complex(1.0,3.5),3e-05),'complex reduce scalar 555') end
do local a=np.array({np.complex(4.0,3.0),np.complex(1.0,0.0),np.complex(-1.0,-3.0),np.complex(-3.0,0.5),np.complex(2.0,-1.0),np.complex(-3.0,1.0),np.complex(1.0,3.0)},np.complex64); local r=np.prod(a,1); assert(close(r,np.complex(625.0,-875.0),3e-05),'complex reduce scalar 556') end
do local a=np.array({np.complex(4.0,3.0),np.complex(1.0,0.0),np.complex(-1.0,-3.0),np.complex(-3.0,0.5),np.complex(2.0,-1.0),np.complex(-3.0,1.0),np.complex(1.0,3.0)},np.complex64); local r=np.mean(a,1); assert(close(r,np.complex(0.1428571492433548,0.5),3e-05),'complex reduce scalar 557') end
do local a=np.array({np.complex(0.0,-1.0),np.complex(-1.0,-0.0),np.complex(-1.0,-3.0),np.complex(0.25,1.0),np.complex(0.0,-3.0),np.complex(1.0,-0.0),np.complex(0.0,3.0)},np.complex64); local r=np.sum(a,1); assert(close(r,np.complex(-0.75,-3.0),3e-05),'complex reduce scalar 558') end
do local a=np.array({np.complex(0.0,-1.0),np.complex(-1.0,-0.0),np.complex(-1.0,-3.0),np.complex(0.25,1.0),np.complex(0.0,-3.0),np.complex(1.0,-0.0),np.complex(0.0,3.0)},np.complex64); local r=np.prod(a,1); assert(close(r,np.complex(15.75,24.75),3e-05),'complex reduce scalar 559') end
do local a=np.array({np.complex(0.0,-1.0),np.complex(-1.0,-0.0),np.complex(-1.0,-3.0),np.complex(0.25,1.0),np.complex(0.0,-3.0),np.complex(1.0,-0.0),np.complex(0.0,3.0)},np.complex64); local r=np.mean(a,1); assert(close(r,np.complex(-0.1071428582072258,-0.4285714328289032),3e-05),'complex reduce scalar 560') end
do local a=np.array({{np.complex(4.0,1.0),np.complex(-2.0,0.0),np.complex(-1.0,1.0),np.complex(1.0,0.0),np.complex(4.0,0.0)},{np.complex(1.0,-1.0),np.complex(-0.0,0.0),np.complex(2.0,1.0),np.complex(1.0,-3.0),np.complex(2.0,1.0)}},np.complex64); local r=np.sum(a,1); assert(r.dtype=='complex64','complex reduce dtype 561'); assert(close(r:tolist(),{np.complex(5.0,0.0),np.complex(-2.0,0.0),np.complex(1.0,2.0),np.complex(2.0,-3.0),np.complex(6.0,1.0)},3e-05),'complex reduce 561') end
do local a=np.array({{np.complex(4.0,1.0),np.complex(-2.0,0.0),np.complex(-1.0,1.0),np.complex(1.0,0.0),np.complex(4.0,0.0)},{np.complex(1.0,-1.0),np.complex(-0.0,0.0),np.complex(2.0,1.0),np.complex(1.0,-3.0),np.complex(2.0,1.0)}},np.complex64); local r=np.prod(a,1); assert(r.dtype=='complex64','complex reduce dtype 562'); assert(close(r:tolist(),{np.complex(5.0,-3.0),np.complex(0.0,-0.0),np.complex(-3.0,1.0),np.complex(1.0,-3.0),np.complex(8.0,4.0)},3e-05),'complex reduce 562') end
do local a=np.array({{np.complex(4.0,1.0),np.complex(-2.0,0.0),np.complex(-1.0,1.0),np.complex(1.0,0.0),np.complex(4.0,0.0)},{np.complex(1.0,-1.0),np.complex(-0.0,0.0),np.complex(2.0,1.0),np.complex(1.0,-3.0),np.complex(2.0,1.0)}},np.complex64); local r=np.mean(a,1); assert(r.dtype=='complex64','complex reduce dtype 563'); assert(close(r:tolist(),{np.complex(2.5,0.0),np.complex(-1.0,0.0),np.complex(0.5,1.0),np.complex(1.0,-1.5),np.complex(3.0,0.5)},3e-05),'complex reduce 563') end
do local a=np.array({{{np.complex(-0.0,0.5),np.complex(-1.0,3.0),np.complex(1.0,0.0),np.complex(1.0,-1.0)},{np.complex(0.25,-3.0),np.complex(2.0,-1.0),np.complex(0.25,3.0),np.complex(0.25,0.0)},{np.complex(2.0,0.0),np.complex(0.0,3.0),np.complex(2.0,0.0),np.complex(-0.0,0.5)}},{{np.complex(4.0,1.0),np.complex(-2.0,1.0),np.complex(4.0,0.5),np.complex(4.0,1.0)},{np.complex(0.25,1.0),np.complex(-2.0,-3.0),np.complex(4.0,-3.0),np.complex(-1.0,1.0)},{np.complex(-3.0,3.0),np.complex(4.0,-3.0),np.complex(2.0,0.5),np.complex(0.0,1.0)}}},np.complex64); local r=np.sum(a,1); assert(r.dtype=='complex64','complex reduce dtype 564'); assert(close(r:tolist(),{{np.complex(4.0,1.5),np.complex(-3.0,4.0),np.complex(5.0,0.5),np.complex(5.0,0.0)},{np.complex(0.5,-2.0),np.complex(0.0,-4.0),np.complex(4.25,0.0),np.complex(-0.75,1.0)},{np.complex(-1.0,3.0),np.complex(4.0,0.0),np.complex(4.0,0.5),np.complex(0.0,1.5)}},3e-05),'complex reduce 564') end
do local a=np.array({{{np.complex(-0.0,0.5),np.complex(-1.0,3.0),np.complex(1.0,0.0),np.complex(1.0,-1.0)},{np.complex(0.25,-3.0),np.complex(2.0,-1.0),np.complex(0.25,3.0),np.complex(0.25,0.0)},{np.complex(2.0,0.0),np.complex(0.0,3.0),np.complex(2.0,0.0),np.complex(-0.0,0.5)}},{{np.complex(4.0,1.0),np.complex(-2.0,1.0),np.complex(4.0,0.5),np.complex(4.0,1.0)},{np.complex(0.25,1.0),np.complex(-2.0,-3.0),np.complex(4.0,-3.0),np.complex(-1.0,1.0)},{np.complex(-3.0,3.0),np.complex(4.0,-3.0),np.complex(2.0,0.5),np.complex(0.0,1.0)}}},np.complex64); local r=np.prod(a,1); assert(r.dtype=='complex64','complex reduce dtype 565'); assert(close(r:tolist(),{{np.complex(-0.5,2.0),np.complex(-1.0,-7.0),np.complex(4.0,0.5),np.complex(5.0,-3.0)},{np.complex(3.0625,-0.5),np.complex(-7.0,-4.0),np.complex(10.0,11.25),np.complex(-0.25,0.25)},{np.complex(-6.0,6.0),np.complex(9.0,12.0),np.complex(4.0,1.0),np.complex(-0.5,0.0)}},3e-05),'complex reduce 565') end
do local a=np.array({{{np.complex(-0.0,0.5),np.complex(-1.0,3.0),np.complex(1.0,0.0),np.complex(1.0,-1.0)},{np.complex(0.25,-3.0),np.complex(2.0,-1.0),np.complex(0.25,3.0),np.complex(0.25,0.0)},{np.complex(2.0,0.0),np.complex(0.0,3.0),np.complex(2.0,0.0),np.complex(-0.0,0.5)}},{{np.complex(4.0,1.0),np.complex(-2.0,1.0),np.complex(4.0,0.5),np.complex(4.0,1.0)},{np.complex(0.25,1.0),np.complex(-2.0,-3.0),np.complex(4.0,-3.0),np.complex(-1.0,1.0)},{np.complex(-3.0,3.0),np.complex(4.0,-3.0),np.complex(2.0,0.5),np.complex(0.0,1.0)}}},np.complex64); local r=np.mean(a,1); assert(r.dtype=='complex64','complex reduce dtype 566'); assert(close(r:tolist(),{{np.complex(2.0,0.75),np.complex(-1.5,2.0),np.complex(2.5,0.25),np.complex(2.5,0.0)},{np.complex(0.25,-1.0),np.complex(0.0,-2.0),np.complex(2.125,0.0),np.complex(-0.375,0.5)},{np.complex(-0.5,1.5),np.complex(2.0,0.0),np.complex(2.0,0.25),np.complex(0.0,0.75)}},3e-05),'complex reduce 566') end
do local a=np.array({np.complex(1.0,-1.0),np.complex(-3.0,-0.0),np.complex(-1.0,-1.0),np.complex(-3.0,3.0),np.complex(1.0,3.0),np.complex(2.0,-0.0),np.complex(0.0,3.0)},np.complex64); local r=np.sum(a,1); assert(close(r,np.complex(-3.0,7.0),3e-05),'complex reduce scalar 567') end
do local a=np.array({np.complex(1.0,-1.0),np.complex(-3.0,-0.0),np.complex(-1.0,-1.0),np.complex(-3.0,3.0),np.complex(1.0,3.0),np.complex(2.0,-0.0),np.complex(0.0,3.0)},np.complex64); local r=np.prod(a,1); assert(close(r,np.complex(216.0,-432.0),3e-05),'complex reduce scalar 568') end
do local a=np.array({np.complex(1.0,-1.0),np.complex(-3.0,-0.0),np.complex(-1.0,-1.0),np.complex(-3.0,3.0),np.complex(1.0,3.0),np.complex(2.0,-0.0),np.complex(0.0,3.0)},np.complex64); local r=np.mean(a,1); assert(close(r,np.complex(-0.4285714328289032,1.0),3e-05),'complex reduce scalar 569') end
do local a=np.array({{np.complex(4.0,0.5),np.complex(1.0,-3.0),np.complex(4.0,0.5),np.complex(2.0,-3.0),np.complex(-1.0,-3.0)},{np.complex(2.0,0.5),np.complex(0.25,0.5),np.complex(2.0,-0.0),np.complex(0.25,0.0),np.complex(0.0,-0.0)}},np.complex64); local r=np.sum(a,1); assert(r.dtype=='complex64','complex reduce dtype 570'); assert(close(r:tolist(),{np.complex(6.0,1.0),np.complex(1.25,-2.5),np.complex(6.0,0.5),np.complex(2.25,-3.0),np.complex(-1.0,-3.0)},3e-05),'complex reduce 570') end
do local a=np.array({{np.complex(4.0,0.5),np.complex(1.0,-3.0),np.complex(4.0,0.5),np.complex(2.0,-3.0),np.complex(-1.0,-3.0)},{np.complex(2.0,0.5),np.complex(0.25,0.5),np.complex(2.0,-0.0),np.complex(0.25,0.0),np.complex(0.0,-0.0)}},np.complex64); local r=np.prod(a,1); assert(r.dtype=='complex64','complex reduce dtype 571'); assert(close(r:tolist(),{np.complex(7.75,3.0),np.complex(1.75,-0.25),np.complex(8.0,1.0),np.complex(0.5,-0.75),np.complex(-0.0,0.0)},3e-05),'complex reduce 571') end
do local a=np.array({{np.complex(4.0,0.5),np.complex(1.0,-3.0),np.complex(4.0,0.5),np.complex(2.0,-3.0),np.complex(-1.0,-3.0)},{np.complex(2.0,0.5),np.complex(0.25,0.5),np.complex(2.0,-0.0),np.complex(0.25,0.0),np.complex(0.0,-0.0)}},np.complex64); local r=np.mean(a,1); assert(r.dtype=='complex64','complex reduce dtype 572'); assert(close(r:tolist(),{np.complex(3.0,0.5),np.complex(0.625,-1.25),np.complex(3.0,0.25),np.complex(1.125,-1.5),np.complex(-0.5,-1.5)},3e-05),'complex reduce 572') end
do local a=np.array({{np.complex(-2.0,-3.0),np.complex(-2.0,0.5),np.complex(4.0,0.5),np.complex(0.0,-0.0),np.complex(-0.0,-1.0)},{np.complex(-3.0,1.0),np.complex(1.0,-1.0),np.complex(-2.0,1.0),np.complex(0.0,3.0),np.complex(-2.0,-1.0)}},np.complex64); local r=np.sum(a,1); assert(r.dtype=='complex64','complex reduce dtype 573'); assert(close(r:tolist(),{np.complex(-5.0,-2.0),np.complex(-1.0,-0.5),np.complex(2.0,1.5),np.complex(0.0,3.0),np.complex(-2.0,-2.0)},3e-05),'complex reduce 573') end
do local a=np.array({{np.complex(-2.0,-3.0),np.complex(-2.0,0.5),np.complex(4.0,0.5),np.complex(0.0,-0.0),np.complex(-0.0,-1.0)},{np.complex(-3.0,1.0),np.complex(1.0,-1.0),np.complex(-2.0,1.0),np.complex(0.0,3.0),np.complex(-2.0,-1.0)}},np.complex64); local r=np.prod(a,1); assert(r.dtype=='complex64','complex reduce dtype 574'); assert(close(r:tolist(),{np.complex(9.0,7.0),np.complex(-1.5,2.5),np.complex(-8.5,3.0),np.complex(0.0,0.0),np.complex(-1.0,2.0)},3e-05),'complex reduce 574') end
do local a=np.array({{np.complex(-2.0,-3.0),np.complex(-2.0,0.5),np.complex(4.0,0.5),np.complex(0.0,-0.0),np.complex(-0.0,-1.0)},{np.complex(-3.0,1.0),np.complex(1.0,-1.0),np.complex(-2.0,1.0),np.complex(0.0,3.0),np.complex(-2.0,-1.0)}},np.complex64); local r=np.mean(a,1); assert(r.dtype=='complex64','complex reduce dtype 575'); assert(close(r:tolist(),{np.complex(-2.5,-1.0),np.complex(-0.5,-0.25),np.complex(1.0,0.75),np.complex(0.0,1.5),np.complex(-1.0,-1.0)},3e-05),'complex reduce 575') end
do local a=np.array({np.complex(2.0,0.0),np.complex(1.0,1.0),np.complex(2.0,-0.0),np.complex(-2.0,3.0),np.complex(0.25,0.0),np.complex(-1.0,1.0),np.complex(0.25,-3.0)},np.complex128); local r=np.sum(a,1); assert(close(r,np.complex(2.5,2.0),2e-12),'complex reduce scalar 576') end
do local a=np.array({np.complex(2.0,0.0),np.complex(1.0,1.0),np.complex(2.0,-0.0),np.complex(-2.0,3.0),np.complex(0.25,0.0),np.complex(-1.0,1.0),np.complex(0.25,-3.0)},np.complex128); local r=np.prod(a,1); assert(close(r,np.complex(-17.0,-13.5),2e-12),'complex reduce scalar 577') end
do local a=np.array({np.complex(2.0,0.0),np.complex(1.0,1.0),np.complex(2.0,-0.0),np.complex(-2.0,3.0),np.complex(0.25,0.0),np.complex(-1.0,1.0),np.complex(0.25,-3.0)},np.complex128); local r=np.mean(a,1); assert(close(r,np.complex(0.3571428571428571,0.2857142857142857),2e-12),'complex reduce scalar 578') end
do local a=np.array({{{np.complex(0.25,3.0),np.complex(0.0,-0.0),np.complex(2.0,3.0),np.complex(4.0,1.0)},{np.complex(0.0,0.5),np.complex(-1.0,1.0),np.complex(4.0,0.0),np.complex(2.0,-1.0)},{np.complex(0.25,-3.0),np.complex(0.0,0.5),np.complex(0.0,0.0),np.complex(0.0,-0.0)}},{{np.complex(4.0,0.5),np.complex(-0.0,0.5),np.complex(4.0,3.0),np.complex(-2.0,-1.0)},{np.complex(0.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,-1.0),np.complex(-0.0,-1.0)},{np.complex(-1.0,-1.0),np.complex(0.0,-0.0),np.complex(0.0,-1.0),np.complex(-1.0,-3.0)}}},np.complex64); local r=np.sum(a,1); assert(r.dtype=='complex64','complex reduce dtype 579'); assert(close(r:tolist(),{{np.complex(4.25,3.5),np.complex(0.0,0.5),np.complex(6.0,6.0),np.complex(2.0,0.0)},{np.complex(0.0,3.5),np.complex(-3.0,0.0),np.complex(3.0,-1.0),np.complex(2.0,-2.0)},{np.complex(-0.75,-4.0),np.complex(0.0,0.5),np.complex(0.0,-1.0),np.complex(-1.0,-3.0)}},3e-05),'complex reduce 579') end
do local a=np.array({{{np.complex(0.25,3.0),np.complex(0.0,-0.0),np.complex(2.0,3.0),np.complex(4.0,1.0)},{np.complex(0.0,0.5),np.complex(-1.0,1.0),np.complex(4.0,0.0),np.complex(2.0,-1.0)},{np.complex(0.25,-3.0),np.complex(0.0,0.5),np.complex(0.0,0.0),np.complex(0.0,-0.0)}},{{np.complex(4.0,0.5),np.complex(-0.0,0.5),np.complex(4.0,3.0),np.complex(-2.0,-1.0)},{np.complex(0.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,-1.0),np.complex(-0.0,-1.0)},{np.complex(-1.0,-1.0),np.complex(0.0,-0.0),np.complex(0.0,-1.0),np.complex(-1.0,-3.0)}}},np.complex64); local r=np.prod(a,1); assert(r.dtype=='complex64','complex reduce dtype 580'); assert(close(r:tolist(),{{np.complex(-0.5,12.125),np.complex(-0.0,0.0),np.complex(-1.0,18.0),np.complex(-7.0,-6.0)},{np.complex(-1.5,0.0),np.complex(3.0,-1.0),np.complex(-4.0,-4.0),np.complex(-1.0,-2.0)},{np.complex(-3.25,2.75),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0)}},3e-05),'complex reduce 580') end
do local a=np.array({{{np.complex(0.25,3.0),np.complex(0.0,-0.0),np.complex(2.0,3.0),np.complex(4.0,1.0)},{np.complex(0.0,0.5),np.complex(-1.0,1.0),np.complex(4.0,0.0),np.complex(2.0,-1.0)},{np.complex(0.25,-3.0),np.complex(0.0,0.5),np.complex(0.0,0.0),np.complex(0.0,-0.0)}},{{np.complex(4.0,0.5),np.complex(-0.0,0.5),np.complex(4.0,3.0),np.complex(-2.0,-1.0)},{np.complex(0.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,-1.0),np.complex(-0.0,-1.0)},{np.complex(-1.0,-1.0),np.complex(0.0,-0.0),np.complex(0.0,-1.0),np.complex(-1.0,-3.0)}}},np.complex64); local r=np.mean(a,1); assert(r.dtype=='complex64','complex reduce dtype 581'); assert(close(r:tolist(),{{np.complex(2.125,1.75),np.complex(0.0,0.25),np.complex(3.0,3.0),np.complex(1.0,0.0)},{np.complex(0.0,1.75),np.complex(-1.5,0.0),np.complex(1.5,-0.5),np.complex(1.0,-1.0)},{np.complex(-0.375,-2.0),np.complex(0.0,0.25),np.complex(0.0,-0.5),np.complex(-0.5,-1.5)}},3e-05),'complex reduce 581') end
do local a=np.array({{np.complex(-3.0,-3.0),np.complex(1.0,-1.0),np.complex(0.0,3.0),np.complex(2.0,1.0),np.complex(1.0,1.0)},{np.complex(-3.0,-3.0),np.complex(-0.0,3.0),np.complex(0.25,-0.0),np.complex(0.0,0.0),np.complex(0.25,3.0)}},np.complex64); local r=np.sum(a,1); assert(r.dtype=='complex64','complex reduce dtype 582'); assert(close(r:tolist(),{np.complex(-6.0,-6.0),np.complex(1.0,2.0),np.complex(0.25,3.0),np.complex(2.0,1.0),np.complex(1.25,4.0)},3e-05),'complex reduce 582') end
do local a=np.array({{np.complex(-3.0,-3.0),np.complex(1.0,-1.0),np.complex(0.0,3.0),np.complex(2.0,1.0),np.complex(1.0,1.0)},{np.complex(-3.0,-3.0),np.complex(-0.0,3.0),np.complex(0.25,-0.0),np.complex(0.0,0.0),np.complex(0.25,3.0)}},np.complex64); local r=np.prod(a,1); assert(r.dtype=='complex64','complex reduce dtype 583'); assert(close(r:tolist(),{np.complex(0.0,18.0),np.complex(3.0,3.0),np.complex(0.0,0.75),np.complex(0.0,0.0),np.complex(-2.75,3.25)},3e-05),'complex reduce 583') end
do local a=np.array({{np.complex(-3.0,-3.0),np.complex(1.0,-1.0),np.complex(0.0,3.0),np.complex(2.0,1.0),np.complex(1.0,1.0)},{np.complex(-3.0,-3.0),np.complex(-0.0,3.0),np.complex(0.25,-0.0),np.complex(0.0,0.0),np.complex(0.25,3.0)}},np.complex64); local r=np.mean(a,1); assert(r.dtype=='complex64','complex reduce dtype 584'); assert(close(r:tolist(),{np.complex(-3.0,-3.0),np.complex(0.5,1.0),np.complex(0.125,1.5),np.complex(1.0,0.5),np.complex(0.625,2.0)},3e-05),'complex reduce 584') end
do local a=np.array({np.complex(0.0,1.0),np.complex(1.0,-1.0),np.complex(4.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,-1.0),np.complex(0.0,1.0),np.complex(0.25,-1.0)},np.complex128); local r=np.sum(a,1); assert(close(r,np.complex(4.25,-1.0),2e-12),'complex reduce scalar 585') end
do local a=np.array({np.complex(0.0,1.0),np.complex(1.0,-1.0),np.complex(4.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,-1.0),np.complex(0.0,1.0),np.complex(0.25,-1.0)},np.complex128); local r=np.prod(a,1); assert(close(r,np.complex(-5.0,3.0),2e-12),'complex reduce scalar 586') end
do local a=np.array({np.complex(0.0,1.0),np.complex(1.0,-1.0),np.complex(4.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,-1.0),np.complex(0.0,1.0),np.complex(0.25,-1.0)},np.complex128); local r=np.mean(a,1); assert(close(r,np.complex(0.6071428571428571,-0.14285714285714285),2e-12),'complex reduce scalar 587') end
do local a=np.array({{np.complex(-3.0,-1.0),np.complex(0.25,0.5),np.complex(4.0,-1.0),np.complex(1.0,1.0),np.complex(4.0,-1.0)},{np.complex(4.0,-1.0),np.complex(2.0,1.0),np.complex(0.0,-1.0),np.complex(-1.0,-1.0),np.complex(-3.0,1.0)}},np.complex128); local r=np.sum(a,2); assert(r.dtype=='complex128','complex reduce dtype 588'); assert(close(r:tolist(),{np.complex(6.25,-1.5),np.complex(2.0,-1.0)},2e-12),'complex reduce 588') end
do local a=np.array({{np.complex(-3.0,-1.0),np.complex(0.25,0.5),np.complex(4.0,-1.0),np.complex(1.0,1.0),np.complex(4.0,-1.0)},{np.complex(4.0,-1.0),np.complex(2.0,1.0),np.complex(0.0,-1.0),np.complex(-1.0,-1.0),np.complex(-3.0,1.0)}},np.complex128); local r=np.prod(a,2); assert(r.dtype=='complex128','complex reduce dtype 589'); assert(close(r:tolist(),{np.complex(6.5,-42.0),np.complex(26.0,-32.0)},2e-12),'complex reduce 589') end
do local a=np.array({{np.complex(-3.0,-1.0),np.complex(0.25,0.5),np.complex(4.0,-1.0),np.complex(1.0,1.0),np.complex(4.0,-1.0)},{np.complex(4.0,-1.0),np.complex(2.0,1.0),np.complex(0.0,-1.0),np.complex(-1.0,-1.0),np.complex(-3.0,1.0)}},np.complex128); local r=np.mean(a,2); assert(r.dtype=='complex128','complex reduce dtype 590'); assert(close(r:tolist(),{np.complex(1.25,-0.30000000000000004),np.complex(0.4,-0.2)},2e-12),'complex reduce 590') end
do local a=np.array({{np.complex(-2.0,3.0),np.complex(-2.0,0.0),np.complex(0.0,3.0),np.complex(0.25,3.0),np.complex(1.0,0.0)},{np.complex(2.0,-3.0),np.complex(-1.0,1.0),np.complex(2.0,0.5),np.complex(-3.0,0.0),np.complex(4.0,-1.0)}},np.complex64); local r=np.sum(a,1); assert(r.dtype=='complex64','complex reduce dtype 591'); assert(close(r:tolist(),{np.complex(0.0,0.0),np.complex(-3.0,1.0),np.complex(2.0,3.5),np.complex(-2.75,3.0),np.complex(5.0,-1.0)},3e-05),'complex reduce 591') end
do local a=np.array({{np.complex(-2.0,3.0),np.complex(-2.0,0.0),np.complex(0.0,3.0),np.complex(0.25,3.0),np.complex(1.0,0.0)},{np.complex(2.0,-3.0),np.complex(-1.0,1.0),np.complex(2.0,0.5),np.complex(-3.0,0.0),np.complex(4.0,-1.0)}},np.complex64); local r=np.prod(a,1); assert(r.dtype=='complex64','complex reduce dtype 592'); assert(close(r:tolist(),{np.complex(5.0,12.0),np.complex(2.0,-2.0),np.complex(-1.5,6.0),np.complex(-0.75,-9.0),np.complex(4.0,-1.0)},3e-05),'complex reduce 592') end
do local a=np.array({{np.complex(-2.0,3.0),np.complex(-2.0,0.0),np.complex(0.0,3.0),np.complex(0.25,3.0),np.complex(1.0,0.0)},{np.complex(2.0,-3.0),np.complex(-1.0,1.0),np.complex(2.0,0.5),np.complex(-3.0,0.0),np.complex(4.0,-1.0)}},np.complex64); local r=np.mean(a,1); assert(r.dtype=='complex64','complex reduce dtype 593'); assert(close(r:tolist(),{np.complex(0.0,0.0),np.complex(-1.5,0.5),np.complex(1.0,1.75),np.complex(-1.375,1.5),np.complex(2.5,-0.5)},3e-05),'complex reduce 593') end
do local a=np.array({{{np.complex(0.25,0.0),np.complex(-3.0,-1.0),np.complex(1.0,-3.0),np.complex(1.0,0.0)},{np.complex(4.0,3.0),np.complex(-1.0,3.0),np.complex(-0.0,0.5),np.complex(-1.0,-0.0)},{np.complex(0.25,0.5),np.complex(0.0,-3.0),np.complex(1.0,-3.0),np.complex(4.0,1.0)}},{{np.complex(4.0,-3.0),np.complex(-2.0,-1.0),np.complex(-3.0,0.5),np.complex(-2.0,-1.0)},{np.complex(-2.0,-3.0),np.complex(-2.0,0.0),np.complex(1.0,3.0),np.complex(-3.0,-0.0)},{np.complex(-1.0,0.0),np.complex(4.0,-0.0),np.complex(-0.0,0.5),np.complex(-0.0,-0.0)}}},np.complex128); local r=np.sum(a,2); assert(r.dtype=='complex128','complex reduce dtype 594'); assert(close(r:tolist(),{{np.complex(4.5,3.5),np.complex(-4.0,-1.0),np.complex(2.0,-5.5),np.complex(4.0,1.0)},{np.complex(1.0,-6.0),np.complex(0.0,-1.0),np.complex(-2.0,4.0),np.complex(-5.0,-1.0)}},2e-12),'complex reduce 594') end
do local a=np.array({{{np.complex(0.25,0.0),np.complex(-3.0,-1.0),np.complex(1.0,-3.0),np.complex(1.0,0.0)},{np.complex(4.0,3.0),np.complex(-1.0,3.0),np.complex(-0.0,0.5),np.complex(-1.0,-0.0)},{np.complex(0.25,0.5),np.complex(0.0,-3.0),np.complex(1.0,-3.0),np.complex(4.0,1.0)}},{{np.complex(4.0,-3.0),np.complex(-2.0,-1.0),np.complex(-3.0,0.5),np.complex(-2.0,-1.0)},{np.complex(-2.0,-3.0),np.complex(-2.0,0.0),np.complex(1.0,3.0),np.complex(-3.0,-0.0)},{np.complex(-1.0,0.0),np.complex(4.0,-0.0),np.complex(-0.0,0.5),np.complex(-0.0,-0.0)}}},np.complex128); local r=np.prod(a,2); assert(r.dtype=='complex128','complex reduce dtype 595'); assert(close(r:tolist(),{{np.complex(-0.125,0.6875),np.complex(-24.0,-18.0),np.complex(3.0,-4.0),np.complex(-4.0,-1.0)},{np.complex(17.0,6.0),np.complex(16.0,8.0),np.complex(4.25,-2.25),np.complex(0.0,-0.0)}},2e-12),'complex reduce 595') end
do local a=np.array({{{np.complex(0.25,0.0),np.complex(-3.0,-1.0),np.complex(1.0,-3.0),np.complex(1.0,0.0)},{np.complex(4.0,3.0),np.complex(-1.0,3.0),np.complex(-0.0,0.5),np.complex(-1.0,-0.0)},{np.complex(0.25,0.5),np.complex(0.0,-3.0),np.complex(1.0,-3.0),np.complex(4.0,1.0)}},{{np.complex(4.0,-3.0),np.complex(-2.0,-1.0),np.complex(-3.0,0.5),np.complex(-2.0,-1.0)},{np.complex(-2.0,-3.0),np.complex(-2.0,0.0),np.complex(1.0,3.0),np.complex(-3.0,-0.0)},{np.complex(-1.0,0.0),np.complex(4.0,-0.0),np.complex(-0.0,0.5),np.complex(-0.0,-0.0)}}},np.complex128); local r=np.mean(a,2); assert(r.dtype=='complex128','complex reduce dtype 596'); assert(close(r:tolist(),{{np.complex(1.5,1.1666666666666665),np.complex(-1.3333333333333333,-0.3333333333333333),np.complex(0.6666666666666666,-1.8333333333333333),np.complex(1.3333333333333333,0.3333333333333333)},{np.complex(0.3333333333333333,-2.0),np.complex(0.0,-0.3333333333333333),np.complex(-0.6666666666666666,1.3333333333333333),np.complex(-1.6666666666666665,-0.3333333333333333)}},2e-12),'complex reduce 596') end
do local a=np.array({{np.complex(2.0,-1.0),np.complex(4.0,-0.0),np.complex(-0.0,1.0),np.complex(-1.0,1.0),np.complex(2.0,-3.0)},{np.complex(-3.0,1.0),np.complex(0.25,0.5),np.complex(0.25,-0.0),np.complex(2.0,3.0),np.complex(0.25,-1.0)}},np.complex64); local r=np.sum(a,1); assert(r.dtype=='complex64','complex reduce dtype 597'); assert(close(r:tolist(),{np.complex(-1.0,0.0),np.complex(4.25,0.5),np.complex(0.25,1.0),np.complex(1.0,4.0),np.complex(2.25,-4.0)},3e-05),'complex reduce 597') end
do local a=np.array({{np.complex(2.0,-1.0),np.complex(4.0,-0.0),np.complex(-0.0,1.0),np.complex(-1.0,1.0),np.complex(2.0,-3.0)},{np.complex(-3.0,1.0),np.complex(0.25,0.5),np.complex(0.25,-0.0),np.complex(2.0,3.0),np.complex(0.25,-1.0)}},np.complex64); local r=np.prod(a,1); assert(r.dtype=='complex64','complex reduce dtype 598'); assert(close(r:tolist(),{np.complex(-5.0,5.0),np.complex(1.0,2.0),np.complex(0.0,0.25),np.complex(-5.0,-1.0),np.complex(-2.5,-2.75)},3e-05),'complex reduce 598') end
do local a=np.array({{np.complex(2.0,-1.0),np.complex(4.0,-0.0),np.complex(-0.0,1.0),np.complex(-1.0,1.0),np.complex(2.0,-3.0)},{np.complex(-3.0,1.0),np.complex(0.25,0.5),np.complex(0.25,-0.0),np.complex(2.0,3.0),np.complex(0.25,-1.0)}},np.complex64); local r=np.mean(a,1); assert(r.dtype=='complex64','complex reduce dtype 599'); assert(close(r:tolist(),{np.complex(-0.5,0.0),np.complex(2.125,0.25),np.complex(0.125,0.5),np.complex(0.5,2.0),np.complex(1.125,-2.0)},3e-05),'complex reduce 599') end
do local a=np.array({np.complex(-0.0,0.0),np.complex(-1.0,3.0),np.complex(-2.0,0.0),np.complex(1.0,-3.0),np.complex(-2.0,3.0),np.complex(1.0,-0.0),np.complex(1.0,0.0)},np.complex128); local r=np.sum(a,1); assert(close(r,np.complex(-2.0,3.0),2e-12),'complex reduce scalar 600') end
do local a=np.array({np.complex(-0.0,0.0),np.complex(-1.0,3.0),np.complex(-2.0,0.0),np.complex(1.0,-3.0),np.complex(-2.0,3.0),np.complex(1.0,-0.0),np.complex(1.0,0.0)},np.complex128); local r=np.prod(a,1); assert(close(r,np.complex(0.0,0.0),2e-12),'complex reduce scalar 601') end
do local a=np.array({np.complex(-0.0,0.0),np.complex(-1.0,3.0),np.complex(-2.0,0.0),np.complex(1.0,-3.0),np.complex(-2.0,3.0),np.complex(1.0,-0.0),np.complex(1.0,0.0)},np.complex128); local r=np.mean(a,1); assert(close(r,np.complex(-0.2857142857142857,0.42857142857142855),2e-12),'complex reduce scalar 602') end
do local a=np.array({{{np.complex(2.0,0.0),np.complex(1.0,0.0),np.complex(4.0,-3.0),np.complex(1.0,-0.0)},{np.complex(2.0,-1.0),np.complex(0.0,-1.0),np.complex(1.0,0.5),np.complex(-2.0,-1.0)},{np.complex(2.0,-0.0),np.complex(-1.0,-0.0),np.complex(-1.0,0.5),np.complex(1.0,-0.0)}},{{np.complex(-1.0,1.0),np.complex(-1.0,-3.0),np.complex(0.0,1.0),np.complex(-3.0,0.5)},{np.complex(2.0,-1.0),np.complex(0.0,3.0),np.complex(2.0,0.5),np.complex(0.0,0.5)},{np.complex(-0.0,-0.0),np.complex(-0.0,-0.0),np.complex(-1.0,1.0),np.complex(-0.0,0.5)}}},np.complex128); local r=np.sum(a,2); assert(r.dtype=='complex128','complex reduce dtype 603'); assert(close(r:tolist(),{{np.complex(6.0,-1.0),np.complex(0.0,-1.0),np.complex(4.0,-2.0),np.complex(0.0,-1.0)},{np.complex(1.0,0.0),np.complex(-1.0,0.0),np.complex(1.0,2.5),np.complex(-3.0,1.5)}},2e-12),'complex reduce 603') end
do local a=np.array({{{np.complex(2.0,0.0),np.complex(1.0,0.0),np.complex(4.0,-3.0),np.complex(1.0,-0.0)},{np.complex(2.0,-1.0),np.complex(0.0,-1.0),np.complex(1.0,0.5),np.complex(-2.0,-1.0)},{np.complex(2.0,-0.0),np.complex(-1.0,-0.0),np.complex(-1.0,0.5),np.complex(1.0,-0.0)}},{{np.complex(-1.0,1.0),np.complex(-1.0,-3.0),np.complex(0.0,1.0),np.complex(-3.0,0.5)},{np.complex(2.0,-1.0),np.complex(0.0,3.0),np.complex(2.0,0.5),np.complex(0.0,0.5)},{np.complex(-0.0,-0.0),np.complex(-0.0,-0.0),np.complex(-1.0,1.0),np.complex(-0.0,0.5)}}},np.complex128); local r=np.prod(a,2); assert(r.dtype=='complex128','complex reduce dtype 604'); assert(close(r:tolist(),{{np.complex(8.0,-4.0),np.complex(-0.0,1.0),np.complex(-5.0,3.75),np.complex(-2.0,-1.0)},{np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(-1.5,-2.5),np.complex(0.75,-0.125)}},2e-12),'complex reduce 604') end
do local a=np.array({{{np.complex(2.0,0.0),np.complex(1.0,0.0),np.complex(4.0,-3.0),np.complex(1.0,-0.0)},{np.complex(2.0,-1.0),np.complex(0.0,-1.0),np.complex(1.0,0.5),np.complex(-2.0,-1.0)},{np.complex(2.0,-0.0),np.complex(-1.0,-0.0),np.complex(-1.0,0.5),np.complex(1.0,-0.0)}},{{np.complex(-1.0,1.0),np.complex(-1.0,-3.0),np.complex(0.0,1.0),np.complex(-3.0,0.5)},{np.complex(2.0,-1.0),np.complex(0.0,3.0),np.complex(2.0,0.5),np.complex(0.0,0.5)},{np.complex(-0.0,-0.0),np.complex(-0.0,-0.0),np.complex(-1.0,1.0),np.complex(-0.0,0.5)}}},np.complex128); local r=np.mean(a,2); assert(r.dtype=='complex128','complex reduce dtype 605'); assert(close(r:tolist(),{{np.complex(2.0,-0.3333333333333333),np.complex(0.0,-0.3333333333333333),np.complex(1.3333333333333333,-0.6666666666666666),np.complex(0.0,-0.3333333333333333)},{np.complex(0.3333333333333333,0.0),np.complex(-0.3333333333333333,0.0),np.complex(0.3333333333333333,0.8333333333333333),np.complex(-1.0,0.5)}},2e-12),'complex reduce 605') end
do local a=np.array({np.complex(-0.0,-0.0),np.complex(2.0,-3.0),np.complex(-3.0,1.0),np.complex(0.0,-1.0),np.complex(1.0,1.0),np.complex(4.0,1.0),np.complex(-2.0,-3.0)},np.complex128); local r=np.sum(a,1); assert(close(r,np.complex(2.0,-4.0),2e-12),'complex reduce scalar 606') end
do local a=np.array({np.complex(-0.0,-0.0),np.complex(2.0,-3.0),np.complex(-3.0,1.0),np.complex(0.0,-1.0),np.complex(1.0,1.0),np.complex(4.0,1.0),np.complex(-2.0,-3.0)},np.complex128); local r=np.prod(a,1); assert(close(r,np.complex(0.0,-0.0),2e-12),'complex reduce scalar 607') end
do local a=np.array({np.complex(-0.0,-0.0),np.complex(2.0,-3.0),np.complex(-3.0,1.0),np.complex(0.0,-1.0),np.complex(1.0,1.0),np.complex(4.0,1.0),np.complex(-2.0,-3.0)},np.complex128); local r=np.mean(a,1); assert(close(r,np.complex(0.2857142857142857,-0.5714285714285714),2e-12),'complex reduce scalar 608') end
do local a=np.array({{{np.complex(2.0,0.5),np.complex(4.0,-3.0),np.complex(2.0,-0.0),np.complex(-3.0,0.0)},{np.complex(2.0,0.0),np.complex(-1.0,0.0),np.complex(-2.0,1.0),np.complex(-2.0,-3.0)},{np.complex(-2.0,-1.0),np.complex(0.25,0.0),np.complex(4.0,3.0),np.complex(-1.0,-1.0)}},{{np.complex(0.25,-0.0),np.complex(1.0,1.0),np.complex(2.0,-0.0),np.complex(2.0,0.0)},{np.complex(-0.0,0.5),np.complex(-0.0,3.0),np.complex(1.0,1.0),np.complex(2.0,0.5)},{np.complex(2.0,-0.0),np.complex(4.0,-0.0),np.complex(0.0,-1.0),np.complex(0.0,0.5)}}},np.complex64); local r=np.sum(a,1); assert(r.dtype=='complex64','complex reduce dtype 609'); assert(close(r:tolist(),{{np.complex(2.25,0.5),np.complex(5.0,-2.0),np.complex(4.0,0.0),np.complex(-1.0,0.0)},{np.complex(2.0,0.5),np.complex(-1.0,3.0),np.complex(-1.0,2.0),np.complex(0.0,-2.5)},{np.complex(0.0,-1.0),np.complex(4.25,0.0),np.complex(4.0,2.0),np.complex(-1.0,-0.5)}},3e-05),'complex reduce 609') end
do local a=np.array({{{np.complex(2.0,0.5),np.complex(4.0,-3.0),np.complex(2.0,-0.0),np.complex(-3.0,0.0)},{np.complex(2.0,0.0),np.complex(-1.0,0.0),np.complex(-2.0,1.0),np.complex(-2.0,-3.0)},{np.complex(-2.0,-1.0),np.complex(0.25,0.0),np.complex(4.0,3.0),np.complex(-1.0,-1.0)}},{{np.complex(0.25,-0.0),np.complex(1.0,1.0),np.complex(2.0,-0.0),np.complex(2.0,0.0)},{np.complex(-0.0,0.5),np.complex(-0.0,3.0),np.complex(1.0,1.0),np.complex(2.0,0.5)},{np.complex(2.0,-0.0),np.complex(4.0,-0.0),np.complex(0.0,-1.0),np.complex(0.0,0.5)}}},np.complex64); local r=np.prod(a,1); assert(r.dtype=='complex64','complex reduce dtype 610'); assert(close(r:tolist(),{{np.complex(0.5,0.125),np.complex(7.0,1.0),np.complex(4.0,0.0),np.complex(-6.0,0.0)},{np.complex(-0.0,1.0),np.complex(0.0,-3.0),np.complex(-3.0,-1.0),np.complex(-2.5,-7.0)},{np.complex(-4.0,-2.0),np.complex(1.0,0.0),np.complex(3.0,-4.0),np.complex(0.5,-0.5)}},3e-05),'complex reduce 610') end
do local a=np.array({{{np.complex(2.0,0.5),np.complex(4.0,-3.0),np.complex(2.0,-0.0),np.complex(-3.0,0.0)},{np.complex(2.0,0.0),np.complex(-1.0,0.0),np.complex(-2.0,1.0),np.complex(-2.0,-3.0)},{np.complex(-2.0,-1.0),np.complex(0.25,0.0),np.complex(4.0,3.0),np.complex(-1.0,-1.0)}},{{np.complex(0.25,-0.0),np.complex(1.0,1.0),np.complex(2.0,-0.0),np.complex(2.0,0.0)},{np.complex(-0.0,0.5),np.complex(-0.0,3.0),np.complex(1.0,1.0),np.complex(2.0,0.5)},{np.complex(2.0,-0.0),np.complex(4.0,-0.0),np.complex(0.0,-1.0),np.complex(0.0,0.5)}}},np.complex64); local r=np.mean(a,1); assert(r.dtype=='complex64','complex reduce dtype 611'); assert(close(r:tolist(),{{np.complex(1.125,0.25),np.complex(2.5,-1.0),np.complex(2.0,0.0),np.complex(-0.5,0.0)},{np.complex(1.0,0.25),np.complex(-0.5,1.5),np.complex(-0.5,1.0),np.complex(0.0,-1.25)},{np.complex(0.0,-0.5),np.complex(2.125,0.0),np.complex(2.0,1.0),np.complex(-0.5,-0.25)}},3e-05),'complex reduce 611') end
do local a=np.array({np.complex(0.25,3.0),np.complex(0.0,0.5),np.complex(1.0,3.0),np.complex(0.25,-3.0),np.complex(0.0,0.5),np.complex(4.0,3.0),np.complex(2.0,1.0)},np.complex64); local r=np.sum(a,1); assert(close(r,np.complex(7.5,8.0),3e-05),'complex reduce scalar 612') end
do local a=np.array({np.complex(0.25,3.0),np.complex(0.0,0.5),np.complex(1.0,3.0),np.complex(0.25,-3.0),np.complex(0.0,0.5),np.complex(4.0,3.0),np.complex(2.0,1.0)},np.complex64); local r=np.prod(a,1); assert(close(r,np.complex(56.640625,-56.640625),3e-05),'complex reduce scalar 613') end
do local a=np.array({np.complex(0.25,3.0),np.complex(0.0,0.5),np.complex(1.0,3.0),np.complex(0.25,-3.0),np.complex(0.0,0.5),np.complex(4.0,3.0),np.complex(2.0,1.0)},np.complex64); local r=np.mean(a,1); assert(close(r,np.complex(1.0714285373687744,1.1428571939468384),3e-05),'complex reduce scalar 614') end
do local a=np.array({np.complex(0.25,0.5),np.complex(0.0,-3.0),np.complex(-0.0,3.0),np.complex(2.0,1.0),np.complex(1.0,0.0),np.complex(0.25,-1.0),np.complex(-1.0,1.0)},np.complex64); local r=np.sum(a,1); assert(close(r,np.complex(2.5,1.5),3e-05),'complex reduce scalar 615') end
do local a=np.array({np.complex(0.25,0.5),np.complex(0.0,-3.0),np.complex(-0.0,3.0),np.complex(2.0,1.0),np.complex(1.0,0.0),np.complex(0.25,-1.0),np.complex(-1.0,1.0)},np.complex64); local r=np.prod(a,1); assert(close(r,np.complex(-14.0625,8.4375),3e-05),'complex reduce scalar 616') end
do local a=np.array({np.complex(0.25,0.5),np.complex(0.0,-3.0),np.complex(-0.0,3.0),np.complex(2.0,1.0),np.complex(1.0,0.0),np.complex(0.25,-1.0),np.complex(-1.0,1.0)},np.complex64); local r=np.mean(a,1); assert(close(r,np.complex(0.3571428656578064,0.2142857164144516),3e-05),'complex reduce scalar 617') end
do local a=np.array({{{np.complex(1.0,-0.0),np.complex(2.0,-3.0),np.complex(-1.0,-0.0),np.complex(4.0,-0.0)},{np.complex(4.0,-3.0),np.complex(1.0,-1.0),np.complex(0.0,-0.0),np.complex(-2.0,-0.0)},{np.complex(4.0,0.5),np.complex(-2.0,0.5),np.complex(2.0,-0.0),np.complex(-2.0,-3.0)}},{{np.complex(4.0,-3.0),np.complex(0.25,0.5),np.complex(0.0,-3.0),np.complex(-0.0,-1.0)},{np.complex(0.25,-3.0),np.complex(-1.0,0.0),np.complex(1.0,-0.0),np.complex(-2.0,0.0)},{np.complex(-2.0,1.0),np.complex(-2.0,3.0),np.complex(-3.0,1.0),np.complex(0.25,3.0)}}},np.complex64); local r=np.sum(a,2); assert(r.dtype=='complex64','complex reduce dtype 618'); assert(close(r:tolist(),{{np.complex(9.0,-2.5),np.complex(1.0,-3.5),np.complex(1.0,0.0),np.complex(0.0,-3.0)},{np.complex(2.25,-5.0),np.complex(-2.75,3.5),np.complex(-2.0,-2.0),np.complex(-1.75,2.0)}},3e-05),'complex reduce 618') end
do local a=np.array({{{np.complex(1.0,-0.0),np.complex(2.0,-3.0),np.complex(-1.0,-0.0),np.complex(4.0,-0.0)},{np.complex(4.0,-3.0),np.complex(1.0,-1.0),np.complex(0.0,-0.0),np.complex(-2.0,-0.0)},{np.complex(4.0,0.5),np.complex(-2.0,0.5),np.complex(2.0,-0.0),np.complex(-2.0,-3.0)}},{{np.complex(4.0,-3.0),np.complex(0.25,0.5),np.complex(0.0,-3.0),np.complex(-0.0,-1.0)},{np.complex(0.25,-3.0),np.complex(-1.0,0.0),np.complex(1.0,-0.0),np.complex(-2.0,0.0)},{np.complex(-2.0,1.0),np.complex(-2.0,3.0),np.complex(-3.0,1.0),np.complex(0.25,3.0)}}},np.complex64); local r=np.prod(a,2); assert(r.dtype=='complex64','complex reduce dtype 619'); assert(close(r:tolist(),{{np.complex(17.5,-10.0),np.complex(4.5,9.5),np.complex(0.0,0.0),np.complex(16.0,24.0)},{np.complex(28.75,17.5),np.complex(2.0,0.25),np.complex(3.0,9.0),np.complex(-6.0,0.5)}},3e-05),'complex reduce 619') end
do local a=np.array({{{np.complex(1.0,-0.0),np.complex(2.0,-3.0),np.complex(-1.0,-0.0),np.complex(4.0,-0.0)},{np.complex(4.0,-3.0),np.complex(1.0,-1.0),np.complex(0.0,-0.0),np.complex(-2.0,-0.0)},{np.complex(4.0,0.5),np.complex(-2.0,0.5),np.complex(2.0,-0.0),np.complex(-2.0,-3.0)}},{{np.complex(4.0,-3.0),np.complex(0.25,0.5),np.complex(0.0,-3.0),np.complex(-0.0,-1.0)},{np.complex(0.25,-3.0),np.complex(-1.0,0.0),np.complex(1.0,-0.0),np.complex(-2.0,0.0)},{np.complex(-2.0,1.0),np.complex(-2.0,3.0),np.complex(-3.0,1.0),np.complex(0.25,3.0)}}},np.complex64); local r=np.mean(a,2); assert(r.dtype=='complex64','complex reduce dtype 620'); assert(close(r:tolist(),{{np.complex(3.0,-0.8333333134651184),np.complex(0.3333333432674408,-1.1666666269302368),np.complex(0.3333333432674408,0.0),np.complex(0.0,-1.0)},{np.complex(0.75,-1.6666666269302368),np.complex(-0.9166666865348816,1.1666666269302368),np.complex(-0.6666666865348816,-0.6666666865348816),np.complex(-0.5833333134651184,0.6666666865348816)}},3e-05),'complex reduce 620') end
do local a=np.array({{np.complex(-1.0,-3.0),np.complex(0.25,-0.0),np.complex(1.0,1.0),np.complex(1.0,1.0),np.complex(-1.0,-3.0)},{np.complex(0.0,3.0),np.complex(-1.0,1.0),np.complex(1.0,-1.0),np.complex(-3.0,-0.0),np.complex(-0.0,-0.0)}},np.complex128); local r=np.sum(a,2); assert(r.dtype=='complex128','complex reduce dtype 621'); assert(close(r:tolist(),{np.complex(0.25,-4.0),np.complex(-3.0,3.0)},2e-12),'complex reduce 621') end
do local a=np.array({{np.complex(-1.0,-3.0),np.complex(0.25,-0.0),np.complex(1.0,1.0),np.complex(1.0,1.0),np.complex(-1.0,-3.0)},{np.complex(0.0,3.0),np.complex(-1.0,1.0),np.complex(1.0,-1.0),np.complex(-3.0,-0.0),np.complex(-0.0,-0.0)}},np.complex128); local r=np.prod(a,2); assert(r.dtype=='complex128','complex reduce dtype 622'); assert(close(r:tolist(),{np.complex(-3.0,-4.0),np.complex(0.0,-0.0)},2e-12),'complex reduce 622') end
do local a=np.array({{np.complex(-1.0,-3.0),np.complex(0.25,-0.0),np.complex(1.0,1.0),np.complex(1.0,1.0),np.complex(-1.0,-3.0)},{np.complex(0.0,3.0),np.complex(-1.0,1.0),np.complex(1.0,-1.0),np.complex(-3.0,-0.0),np.complex(-0.0,-0.0)}},np.complex128); local r=np.mean(a,2); assert(r.dtype=='complex128','complex reduce dtype 623'); assert(close(r:tolist(),{np.complex(0.05,-0.8),np.complex(-0.6000000000000001,0.6000000000000001)},2e-12),'complex reduce 623') end
do local a=np.array({{{np.complex(2.0,3.0),np.complex(0.0,1.0),np.complex(-1.0,0.0),np.complex(2.0,0.0)},{np.complex(1.0,-0.0),np.complex(1.0,-0.0),np.complex(-3.0,1.0),np.complex(-1.0,0.5)},{np.complex(4.0,0.0),np.complex(1.0,-0.0),np.complex(1.0,-3.0),np.complex(2.0,-0.0)}},{{np.complex(0.0,-3.0),np.complex(-3.0,0.0),np.complex(-2.0,0.5),np.complex(-3.0,0.5)},{np.complex(-2.0,0.0),np.complex(2.0,-0.0),np.complex(-3.0,-1.0),np.complex(0.0,-0.0)},{np.complex(-0.0,-0.0),np.complex(-0.0,0.5),np.complex(-2.0,0.5),np.complex(-1.0,0.5)}}},np.complex128); local r=np.sum(a,2); assert(r.dtype=='complex128','complex reduce dtype 624'); assert(close(r:tolist(),{{np.complex(7.0,3.0),np.complex(2.0,1.0),np.complex(-3.0,-2.0),np.complex(3.0,0.5)},{np.complex(-2.0,-3.0),np.complex(-1.0,0.5),np.complex(-7.0,0.0),np.complex(-4.0,1.0)}},2e-12),'complex reduce 624') end
do local a=np.array({{{np.complex(2.0,3.0),np.complex(0.0,1.0),np.complex(-1.0,0.0),np.complex(2.0,0.0)},{np.complex(1.0,-0.0),np.complex(1.0,-0.0),np.complex(-3.0,1.0),np.complex(-1.0,0.5)},{np.complex(4.0,0.0),np.complex(1.0,-0.0),np.complex(1.0,-3.0),np.complex(2.0,-0.0)}},{{np.complex(0.0,-3.0),np.complex(-3.0,0.0),np.complex(-2.0,0.5),np.complex(-3.0,0.5)},{np.complex(-2.0,0.0),np.complex(2.0,-0.0),np.complex(-3.0,-1.0),np.complex(0.0,-0.0)},{np.complex(-0.0,-0.0),np.complex(-0.0,0.5),np.complex(-2.0,0.5),np.complex(-1.0,0.5)}}},np.complex128); local r=np.prod(a,2); assert(r.dtype=='complex128','complex reduce dtype 625'); assert(close(r:tolist(),{{np.complex(8.0,12.0),np.complex(0.0,1.0),np.complex(0.0,-10.0),np.complex(-4.0,2.0)},{np.complex(0.0,-0.0),np.complex(0.0,-3.0),np.complex(-13.25,2.25),np.complex(-0.0,0.0)}},2e-12),'complex reduce 625') end
do local a=np.array({{{np.complex(2.0,3.0),np.complex(0.0,1.0),np.complex(-1.0,0.0),np.complex(2.0,0.0)},{np.complex(1.0,-0.0),np.complex(1.0,-0.0),np.complex(-3.0,1.0),np.complex(-1.0,0.5)},{np.complex(4.0,0.0),np.complex(1.0,-0.0),np.complex(1.0,-3.0),np.complex(2.0,-0.0)}},{{np.complex(0.0,-3.0),np.complex(-3.0,0.0),np.complex(-2.0,0.5),np.complex(-3.0,0.5)},{np.complex(-2.0,0.0),np.complex(2.0,-0.0),np.complex(-3.0,-1.0),np.complex(0.0,-0.0)},{np.complex(-0.0,-0.0),np.complex(-0.0,0.5),np.complex(-2.0,0.5),np.complex(-1.0,0.5)}}},np.complex128); local r=np.mean(a,2); assert(r.dtype=='complex128','complex reduce dtype 626'); assert(close(r:tolist(),{{np.complex(2.333333333333333,1.0),np.complex(0.6666666666666666,0.3333333333333333),np.complex(-1.0,-0.6666666666666666),np.complex(1.0,0.16666666666666666)},{np.complex(-0.6666666666666666,-1.0),np.complex(-0.3333333333333333,0.16666666666666666),np.complex(-2.333333333333333,0.0),np.complex(-1.3333333333333333,0.3333333333333333)}},2e-12),'complex reduce 626') end
do local a=np.array({{{np.complex(4.0,1.0),np.complex(2.0,-3.0),np.complex(4.0,-3.0),np.complex(-0.0,-0.0)},{np.complex(-2.0,0.5),np.complex(-3.0,-1.0),np.complex(-3.0,3.0),np.complex(-1.0,0.0)},{np.complex(-1.0,-0.0),np.complex(0.25,3.0),np.complex(-3.0,0.5),np.complex(0.0,-1.0)}},{{np.complex(1.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,3.0),np.complex(-2.0,0.0)},{np.complex(1.0,0.5),np.complex(0.25,-0.0),np.complex(1.0,1.0),np.complex(-3.0,0.0)},{np.complex(2.0,-1.0),np.complex(-1.0,3.0),np.complex(1.0,0.5),np.complex(2.0,-1.0)}}},np.complex128); local r=np.sum(a,3); assert(r.dtype=='complex128','complex reduce dtype 627'); assert(close(r:tolist(),{{np.complex(10.0,-5.0),np.complex(-9.0,2.5),np.complex(-3.75,2.5)},{np.complex(-1.0,3.0),np.complex(-0.75,1.5),np.complex(4.0,1.5)}},2e-12),'complex reduce 627') end
do local a=np.array({{{np.complex(4.0,1.0),np.complex(2.0,-3.0),np.complex(4.0,-3.0),np.complex(-0.0,-0.0)},{np.complex(-2.0,0.5),np.complex(-3.0,-1.0),np.complex(-3.0,3.0),np.complex(-1.0,0.0)},{np.complex(-1.0,-0.0),np.complex(0.25,3.0),np.complex(-3.0,0.5),np.complex(0.0,-1.0)}},{{np.complex(1.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,3.0),np.complex(-2.0,0.0)},{np.complex(1.0,0.5),np.complex(0.25,-0.0),np.complex(1.0,1.0),np.complex(-3.0,0.0)},{np.complex(2.0,-1.0),np.complex(-1.0,3.0),np.complex(1.0,0.5),np.complex(2.0,-1.0)}}},np.complex128); local r=np.prod(a,3); assert(r.dtype=='complex128','complex reduce dtype 628'); assert(close(r:tolist(),{{np.complex(-0.0,0.0),np.complex(21.0,-18.0),np.complex(8.875,-2.25)},{np.complex(-0.0,0.0),np.complex(-0.375,-1.125),np.complex(2.5,17.5)}},2e-12),'complex reduce 628') end
do local a=np.array({{{np.complex(4.0,1.0),np.complex(2.0,-3.0),np.complex(4.0,-3.0),np.complex(-0.0,-0.0)},{np.complex(-2.0,0.5),np.complex(-3.0,-1.0),np.complex(-3.0,3.0),np.complex(-1.0,0.0)},{np.complex(-1.0,-0.0),np.complex(0.25,3.0),np.complex(-3.0,0.5),np.complex(0.0,-1.0)}},{{np.complex(1.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,3.0),np.complex(-2.0,0.0)},{np.complex(1.0,0.5),np.complex(0.25,-0.0),np.complex(1.0,1.0),np.complex(-3.0,0.0)},{np.complex(2.0,-1.0),np.complex(-1.0,3.0),np.complex(1.0,0.5),np.complex(2.0,-1.0)}}},np.complex128); local r=np.mean(a,3); assert(r.dtype=='complex128','complex reduce dtype 629'); assert(close(r:tolist(),{{np.complex(2.5,-1.25),np.complex(-2.25,0.625),np.complex(-0.9375,0.625)},{np.complex(-0.25,0.75),np.complex(-0.1875,0.375),np.complex(1.0,0.375)}},2e-12),'complex reduce 629') end
do local a=np.array({{np.complex(2.0,0.5),np.complex(2.0,0.5),np.complex(-3.0,1.0),np.complex(-0.0,3.0),np.complex(-1.0,0.5)},{np.complex(0.25,0.5),np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(1.0,-1.0),np.complex(0.25,0.5)}},np.complex128); local r=np.sum(a,1); assert(r.dtype=='complex128','complex reduce dtype 630'); assert(close(r:tolist(),{np.complex(2.25,1.0),np.complex(2.0,0.5),np.complex(-1.0,1.0),np.complex(1.0,2.0),np.complex(-0.75,1.0)},2e-12),'complex reduce 630') end
do local a=np.array({{np.complex(2.0,0.5),np.complex(2.0,0.5),np.complex(-3.0,1.0),np.complex(-0.0,3.0),np.complex(-1.0,0.5)},{np.complex(0.25,0.5),np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(1.0,-1.0),np.complex(0.25,0.5)}},np.complex128); local r=np.prod(a,1); assert(r.dtype=='complex128','complex reduce dtype 631'); assert(close(r:tolist(),{np.complex(0.25,1.125),np.complex(0.0,0.0),np.complex(-6.0,2.0),np.complex(3.0,3.0),np.complex(-0.5,-0.375)},2e-12),'complex reduce 631') end
do local a=np.array({{np.complex(2.0,0.5),np.complex(2.0,0.5),np.complex(-3.0,1.0),np.complex(-0.0,3.0),np.complex(-1.0,0.5)},{np.complex(0.25,0.5),np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(1.0,-1.0),np.complex(0.25,0.5)}},np.complex128); local r=np.mean(a,1); assert(r.dtype=='complex128','complex reduce dtype 632'); assert(close(r:tolist(),{np.complex(1.125,0.5),np.complex(1.0,0.25),np.complex(-0.5,0.5),np.complex(0.5,1.0),np.complex(-0.375,0.5)},2e-12),'complex reduce 632') end
do local a=np.array({np.complex(4.0,3.0),np.complex(4.0,1.0),np.complex(-1.0,0.5),np.complex(4.0,1.0),np.complex(2.0,3.0),np.complex(0.25,-0.0),np.complex(2.0,-3.0)},np.complex128); local r=np.sum(a,1); assert(close(r,np.complex(15.25,5.5),2e-12),'complex reduce scalar 633') end
do local a=np.array({np.complex(4.0,3.0),np.complex(4.0,1.0),np.complex(-1.0,0.5),np.complex(4.0,1.0),np.complex(2.0,3.0),np.complex(0.25,-0.0),np.complex(2.0,-3.0)},np.complex128); local r=np.prod(a,1); assert(close(r,np.complex(-242.125,-191.75),2e-12),'complex reduce scalar 634') end
do local a=np.array({np.complex(4.0,3.0),np.complex(4.0,1.0),np.complex(-1.0,0.5),np.complex(4.0,1.0),np.complex(2.0,3.0),np.complex(0.25,-0.0),np.complex(2.0,-3.0)},np.complex128); local r=np.mean(a,1); assert(close(r,np.complex(2.1785714285714284,0.7857142857142857),2e-12),'complex reduce scalar 635') end
do local a=np.array({{{np.complex(1.0,3.0),np.complex(0.25,1.0),np.complex(-3.0,1.0),np.complex(0.0,-1.0)},{np.complex(0.0,3.0),np.complex(4.0,0.0),np.complex(0.25,0.5),np.complex(-3.0,0.5)},{np.complex(-2.0,-0.0),np.complex(-2.0,-1.0),np.complex(-1.0,1.0),np.complex(4.0,3.0)}},{{np.complex(-0.0,-0.0),np.complex(0.25,0.0),np.complex(0.0,0.5),np.complex(2.0,1.0)},{np.complex(-0.0,1.0),np.complex(1.0,0.0),np.complex(-2.0,1.0),np.complex(1.0,-0.0)},{np.complex(4.0,-0.0),np.complex(-1.0,0.0),np.complex(2.0,3.0),np.complex(-2.0,1.0)}}},np.complex128); local r=np.sum(a,3); assert(r.dtype=='complex128','complex reduce dtype 636'); assert(close(r:tolist(),{{np.complex(-1.75,4.0),np.complex(1.25,4.0),np.complex(-1.0,3.0)},{np.complex(2.25,1.5),np.complex(0.0,2.0),np.complex(3.0,4.0)}},2e-12),'complex reduce 636') end
do local a=np.array({{{np.complex(1.0,3.0),np.complex(0.25,1.0),np.complex(-3.0,1.0),np.complex(0.0,-1.0)},{np.complex(0.0,3.0),np.complex(4.0,0.0),np.complex(0.25,0.5),np.complex(-3.0,0.5)},{np.complex(-2.0,-0.0),np.complex(-2.0,-1.0),np.complex(-1.0,1.0),np.complex(4.0,3.0)}},{{np.complex(-0.0,-0.0),np.complex(0.25,0.0),np.complex(0.0,0.5),np.complex(2.0,1.0)},{np.complex(-0.0,1.0),np.complex(1.0,0.0),np.complex(-2.0,1.0),np.complex(1.0,-0.0)},{np.complex(4.0,-0.0),np.complex(-1.0,0.0),np.complex(2.0,3.0),np.complex(-2.0,1.0)}}},np.complex128); local r=np.prod(a,3); assert(r.dtype=='complex128','complex reduce dtype 637'); assert(close(r:tolist(),{{np.complex(-8.0,-6.5),np.complex(16.5,-12.0),np.complex(-30.0,-10.0)},{np.complex(0.0,0.0),np.complex(-1.0,-2.0),np.complex(28.0,16.0)}},2e-12),'complex reduce 637') end
do local a=np.array({{{np.complex(1.0,3.0),np.complex(0.25,1.0),np.complex(-3.0,1.0),np.complex(0.0,-1.0)},{np.complex(0.0,3.0),np.complex(4.0,0.0),np.complex(0.25,0.5),np.complex(-3.0,0.5)},{np.complex(-2.0,-0.0),np.complex(-2.0,-1.0),np.complex(-1.0,1.0),np.complex(4.0,3.0)}},{{np.complex(-0.0,-0.0),np.complex(0.25,0.0),np.complex(0.0,0.5),np.complex(2.0,1.0)},{np.complex(-0.0,1.0),np.complex(1.0,0.0),np.complex(-2.0,1.0),np.complex(1.0,-0.0)},{np.complex(4.0,-0.0),np.complex(-1.0,0.0),np.complex(2.0,3.0),np.complex(-2.0,1.0)}}},np.complex128); local r=np.mean(a,3); assert(r.dtype=='complex128','complex reduce dtype 638'); assert(close(r:tolist(),{{np.complex(-0.4375,1.0),np.complex(0.3125,1.0),np.complex(-0.25,0.75)},{np.complex(0.5625,0.375),np.complex(0.0,0.5),np.complex(0.75,1.0)}},2e-12),'complex reduce 638') end
do local a=np.array({{np.complex(0.0,-1.0),np.complex(0.25,-0.0),np.complex(0.0,-1.0),np.complex(-1.0,1.0),np.complex(-1.0,0.5)},{np.complex(-0.0,1.0),np.complex(4.0,-0.0),np.complex(4.0,-1.0),np.complex(1.0,-0.0),np.complex(2.0,0.0)}},np.complex64); local r=np.sum(a,1); assert(r.dtype=='complex64','complex reduce dtype 639'); assert(close(r:tolist(),{np.complex(0.0,0.0),np.complex(4.25,0.0),np.complex(4.0,-2.0),np.complex(0.0,1.0),np.complex(1.0,0.5)},3e-05),'complex reduce 639') end
do local a=np.array({{np.complex(0.0,-1.0),np.complex(0.25,-0.0),np.complex(0.0,-1.0),np.complex(-1.0,1.0),np.complex(-1.0,0.5)},{np.complex(-0.0,1.0),np.complex(4.0,-0.0),np.complex(4.0,-1.0),np.complex(1.0,-0.0),np.complex(2.0,0.0)}},np.complex64); local r=np.prod(a,1); assert(r.dtype=='complex64','complex reduce dtype 640'); assert(close(r:tolist(),{np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(-1.0,-4.0),np.complex(-1.0,1.0),np.complex(-2.0,1.0)},3e-05),'complex reduce 640') end
do local a=np.array({{np.complex(0.0,-1.0),np.complex(0.25,-0.0),np.complex(0.0,-1.0),np.complex(-1.0,1.0),np.complex(-1.0,0.5)},{np.complex(-0.0,1.0),np.complex(4.0,-0.0),np.complex(4.0,-1.0),np.complex(1.0,-0.0),np.complex(2.0,0.0)}},np.complex64); local r=np.mean(a,1); assert(r.dtype=='complex64','complex reduce dtype 641'); assert(close(r:tolist(),{np.complex(0.0,0.0),np.complex(2.125,0.0),np.complex(2.0,-1.0),np.complex(0.0,0.5),np.complex(0.5,0.25)},3e-05),'complex reduce 641') end
do local a=np.array({{np.complex(-2.0,0.5),np.complex(-0.0,3.0),np.complex(0.0,-3.0),np.complex(2.0,-3.0),np.complex(-2.0,-1.0)},{np.complex(2.0,-3.0),np.complex(1.0,1.0),np.complex(-0.0,0.0),np.complex(2.0,-1.0),np.complex(-0.0,1.0)}},np.complex64); local r=np.sum(a,2); assert(r.dtype=='complex64','complex reduce dtype 642'); assert(close(r:tolist(),{np.complex(-2.0,-3.5),np.complex(5.0,-2.0)},3e-05),'complex reduce 642') end
do local a=np.array({{np.complex(-2.0,0.5),np.complex(-0.0,3.0),np.complex(0.0,-3.0),np.complex(2.0,-3.0),np.complex(-2.0,-1.0)},{np.complex(2.0,-3.0),np.complex(1.0,1.0),np.complex(-0.0,0.0),np.complex(2.0,-1.0),np.complex(-0.0,1.0)}},np.complex64); local r=np.prod(a,2); assert(r.dtype=='complex64','complex reduce dtype 643'); assert(close(r:tolist(),{np.complex(108.0,-103.5),np.complex(-0.0,0.0)},3e-05),'complex reduce 643') end
do local a=np.array({{np.complex(-2.0,0.5),np.complex(-0.0,3.0),np.complex(0.0,-3.0),np.complex(2.0,-3.0),np.complex(-2.0,-1.0)},{np.complex(2.0,-3.0),np.complex(1.0,1.0),np.complex(-0.0,0.0),np.complex(2.0,-1.0),np.complex(-0.0,1.0)}},np.complex64); local r=np.mean(a,2); assert(r.dtype=='complex64','complex reduce dtype 644'); assert(close(r:tolist(),{np.complex(-0.4000000059604645,-0.699999988079071),np.complex(1.0,-0.4000000059604645)},3e-05),'complex reduce 644') end
do local a=np.array({{{np.complex(-1.0,-3.0),np.complex(0.0,-0.0),np.complex(-1.0,-1.0),np.complex(2.0,0.0)},{np.complex(2.0,0.5),np.complex(-2.0,1.0),np.complex(-1.0,1.0),np.complex(-0.0,1.0)},{np.complex(-0.0,0.5),np.complex(0.25,0.5),np.complex(2.0,-3.0),np.complex(-0.0,1.0)}},{{np.complex(4.0,-3.0),np.complex(0.25,1.0),np.complex(2.0,3.0),np.complex(0.25,0.0)},{np.complex(2.0,1.0),np.complex(1.0,1.0),np.complex(1.0,1.0),np.complex(0.0,-1.0)},{np.complex(-1.0,0.0),np.complex(4.0,3.0),np.complex(-2.0,0.0),np.complex(0.0,-0.0)}}},np.complex128); local r=np.sum(a,1); assert(r.dtype=='complex128','complex reduce dtype 645'); assert(close(r:tolist(),{{np.complex(3.0,-6.0),np.complex(0.25,1.0),np.complex(1.0,2.0),np.complex(2.25,0.0)},{np.complex(4.0,1.5),np.complex(-1.0,2.0),np.complex(0.0,2.0),np.complex(0.0,0.0)},{np.complex(-1.0,0.5),np.complex(4.25,3.5),np.complex(0.0,-3.0),np.complex(0.0,1.0)}},2e-12),'complex reduce 645') end
do local a=np.array({{{np.complex(-1.0,-3.0),np.complex(0.0,-0.0),np.complex(-1.0,-1.0),np.complex(2.0,0.0)},{np.complex(2.0,0.5),np.complex(-2.0,1.0),np.complex(-1.0,1.0),np.complex(-0.0,1.0)},{np.complex(-0.0,0.5),np.complex(0.25,0.5),np.complex(2.0,-3.0),np.complex(-0.0,1.0)}},{{np.complex(4.0,-3.0),np.complex(0.25,1.0),np.complex(2.0,3.0),np.complex(0.25,0.0)},{np.complex(2.0,1.0),np.complex(1.0,1.0),np.complex(1.0,1.0),np.complex(0.0,-1.0)},{np.complex(-1.0,0.0),np.complex(4.0,3.0),np.complex(-2.0,0.0),np.complex(0.0,-0.0)}}},np.complex128); local r=np.prod(a,1); assert(r.dtype=='complex128','complex reduce dtype 646'); assert(close(r:tolist(),{{np.complex(-13.0,-9.0),np.complex(0.0,0.0),np.complex(1.0,-5.0),np.complex(0.5,0.0)},{np.complex(3.5,3.0),np.complex(-3.0,-1.0),np.complex(-2.0,0.0),np.complex(1.0,0.0)},{np.complex(0.0,-0.5),np.complex(-0.5,2.75),np.complex(-4.0,6.0),np.complex(0.0,0.0)}},2e-12),'complex reduce 646') end
do local a=np.array({{{np.complex(-1.0,-3.0),np.complex(0.0,-0.0),np.complex(-1.0,-1.0),np.complex(2.0,0.0)},{np.complex(2.0,0.5),np.complex(-2.0,1.0),np.complex(-1.0,1.0),np.complex(-0.0,1.0)},{np.complex(-0.0,0.5),np.complex(0.25,0.5),np.complex(2.0,-3.0),np.complex(-0.0,1.0)}},{{np.complex(4.0,-3.0),np.complex(0.25,1.0),np.complex(2.0,3.0),np.complex(0.25,0.0)},{np.complex(2.0,1.0),np.complex(1.0,1.0),np.complex(1.0,1.0),np.complex(0.0,-1.0)},{np.complex(-1.0,0.0),np.complex(4.0,3.0),np.complex(-2.0,0.0),np.complex(0.0,-0.0)}}},np.complex128); local r=np.mean(a,1); assert(r.dtype=='complex128','complex reduce dtype 647'); assert(close(r:tolist(),{{np.complex(1.5,-3.0),np.complex(0.125,0.5),np.complex(0.5,1.0),np.complex(1.125,0.0)},{np.complex(2.0,0.75),np.complex(-0.5,1.0),np.complex(0.0,1.0),np.complex(0.0,0.0)},{np.complex(-0.5,0.25),np.complex(2.125,1.75),np.complex(0.0,-1.5),np.complex(0.0,0.5)}},2e-12),'complex reduce 647') end
do local a=np.array({{{np.complex(4.0,1.0),np.complex(0.25,0.0),np.complex(-3.0,-3.0),np.complex(0.25,0.5)},{np.complex(-0.0,-3.0),np.complex(-1.0,-0.0),np.complex(-3.0,0.0),np.complex(-0.0,0.5)},{np.complex(2.0,0.0),np.complex(0.0,3.0),np.complex(-0.0,1.0),np.complex(-2.0,-3.0)}},{{np.complex(-1.0,-0.0),np.complex(2.0,-3.0),np.complex(0.0,0.0),np.complex(1.0,1.0)},{np.complex(-3.0,3.0),np.complex(-3.0,-1.0),np.complex(-2.0,3.0),np.complex(0.25,1.0)},{np.complex(4.0,-0.0),np.complex(-3.0,-0.0),np.complex(-0.0,-0.0),np.complex(1.0,-1.0)}}},np.complex128); local r=np.sum(a,1); assert(r.dtype=='complex128','complex reduce dtype 648'); assert(close(r:tolist(),{{np.complex(3.0,1.0),np.complex(2.25,-3.0),np.complex(-3.0,-3.0),np.complex(1.25,1.5)},{np.complex(-3.0,0.0),np.complex(-4.0,-1.0),np.complex(-5.0,3.0),np.complex(0.25,1.5)},{np.complex(6.0,0.0),np.complex(-3.0,3.0),np.complex(0.0,1.0),np.complex(-1.0,-4.0)}},2e-12),'complex reduce 648') end
do local a=np.array({{{np.complex(4.0,1.0),np.complex(0.25,0.0),np.complex(-3.0,-3.0),np.complex(0.25,0.5)},{np.complex(-0.0,-3.0),np.complex(-1.0,-0.0),np.complex(-3.0,0.0),np.complex(-0.0,0.5)},{np.complex(2.0,0.0),np.complex(0.0,3.0),np.complex(-0.0,1.0),np.complex(-2.0,-3.0)}},{{np.complex(-1.0,-0.0),np.complex(2.0,-3.0),np.complex(0.0,0.0),np.complex(1.0,1.0)},{np.complex(-3.0,3.0),np.complex(-3.0,-1.0),np.complex(-2.0,3.0),np.complex(0.25,1.0)},{np.complex(4.0,-0.0),np.complex(-3.0,-0.0),np.complex(-0.0,-0.0),np.complex(1.0,-1.0)}}},np.complex128); local r=np.prod(a,1); assert(r.dtype=='complex128','complex reduce dtype 649'); assert(close(r:tolist(),{{np.complex(-4.0,-1.0),np.complex(0.5,-0.75),np.complex(0.0,-0.0),np.complex(-0.25,0.75)},{np.complex(9.0,9.0),np.complex(3.0,1.0),np.complex(6.0,-9.0),np.complex(-0.5,0.125)},{np.complex(8.0,0.0),np.complex(0.0,-9.0),np.complex(0.0,0.0),np.complex(-5.0,-1.0)}},2e-12),'complex reduce 649') end
do local a=np.array({{{np.complex(4.0,1.0),np.complex(0.25,0.0),np.complex(-3.0,-3.0),np.complex(0.25,0.5)},{np.complex(-0.0,-3.0),np.complex(-1.0,-0.0),np.complex(-3.0,0.0),np.complex(-0.0,0.5)},{np.complex(2.0,0.0),np.complex(0.0,3.0),np.complex(-0.0,1.0),np.complex(-2.0,-3.0)}},{{np.complex(-1.0,-0.0),np.complex(2.0,-3.0),np.complex(0.0,0.0),np.complex(1.0,1.0)},{np.complex(-3.0,3.0),np.complex(-3.0,-1.0),np.complex(-2.0,3.0),np.complex(0.25,1.0)},{np.complex(4.0,-0.0),np.complex(-3.0,-0.0),np.complex(-0.0,-0.0),np.complex(1.0,-1.0)}}},np.complex128); local r=np.mean(a,1); assert(r.dtype=='complex128','complex reduce dtype 650'); assert(close(r:tolist(),{{np.complex(1.5,0.5),np.complex(1.125,-1.5),np.complex(-1.5,-1.5),np.complex(0.625,0.75)},{np.complex(-1.5,0.0),np.complex(-2.0,-0.5),np.complex(-2.5,1.5),np.complex(0.125,0.75)},{np.complex(3.0,0.0),np.complex(-1.5,1.5),np.complex(0.0,0.5),np.complex(-0.5,-2.0)}},2e-12),'complex reduce 650') end
do local a=np.array({{{np.complex(-2.0,0.0),np.complex(4.0,-3.0),np.complex(-1.0,-3.0),np.complex(-3.0,1.0)},{np.complex(4.0,3.0),np.complex(-1.0,-3.0),np.complex(-1.0,1.0),np.complex(-1.0,3.0)},{np.complex(-3.0,-1.0),np.complex(4.0,3.0),np.complex(0.0,-1.0),np.complex(1.0,-0.0)}},{{np.complex(-1.0,1.0),np.complex(0.0,3.0),np.complex(-0.0,0.5),np.complex(0.0,-0.0)},{np.complex(-3.0,1.0),np.complex(-0.0,1.0),np.complex(-2.0,3.0),np.complex(4.0,-1.0)},{np.complex(2.0,0.0),np.complex(-1.0,0.0),np.complex(0.25,-1.0),np.complex(-3.0,-0.0)}}},np.complex64); local r=np.sum(a,1); assert(r.dtype=='complex64','complex reduce dtype 651'); assert(close(r:tolist(),{{np.complex(-3.0,1.0),np.complex(4.0,0.0),np.complex(-1.0,-2.5),np.complex(-3.0,1.0)},{np.complex(1.0,4.0),np.complex(-1.0,-2.0),np.complex(-3.0,4.0),np.complex(3.0,2.0)},{np.complex(-1.0,-1.0),np.complex(3.0,3.0),np.complex(0.25,-2.0),np.complex(-2.0,0.0)}},3e-05),'complex reduce 651') end
do local a=np.array({{{np.complex(-2.0,0.0),np.complex(4.0,-3.0),np.complex(-1.0,-3.0),np.complex(-3.0,1.0)},{np.complex(4.0,3.0),np.complex(-1.0,-3.0),np.complex(-1.0,1.0),np.complex(-1.0,3.0)},{np.complex(-3.0,-1.0),np.complex(4.0,3.0),np.complex(0.0,-1.0),np.complex(1.0,-0.0)}},{{np.complex(-1.0,1.0),np.complex(0.0,3.0),np.complex(-0.0,0.5),np.complex(0.0,-0.0)},{np.complex(-3.0,1.0),np.complex(-0.0,1.0),np.complex(-2.0,3.0),np.complex(4.0,-1.0)},{np.complex(2.0,0.0),np.complex(-1.0,0.0),np.complex(0.25,-1.0),np.complex(-3.0,-0.0)}}},np.complex64); local r=np.prod(a,1); assert(r.dtype=='complex64','complex reduce dtype 652'); assert(close(r:tolist(),{{np.complex(2.0,-2.0),np.complex(9.0,12.0),np.complex(1.5,-0.5),np.complex(0.0,0.0)},{np.complex(-15.0,-5.0),np.complex(3.0,-1.0),np.complex(-1.0,-5.0),np.complex(-1.0,13.0)},{np.complex(-6.0,-2.0),np.complex(-4.0,-3.0),np.complex(-1.0,-0.25),np.complex(-3.0,-0.0)}},3e-05),'complex reduce 652') end
do local a=np.array({{{np.complex(-2.0,0.0),np.complex(4.0,-3.0),np.complex(-1.0,-3.0),np.complex(-3.0,1.0)},{np.complex(4.0,3.0),np.complex(-1.0,-3.0),np.complex(-1.0,1.0),np.complex(-1.0,3.0)},{np.complex(-3.0,-1.0),np.complex(4.0,3.0),np.complex(0.0,-1.0),np.complex(1.0,-0.0)}},{{np.complex(-1.0,1.0),np.complex(0.0,3.0),np.complex(-0.0,0.5),np.complex(0.0,-0.0)},{np.complex(-3.0,1.0),np.complex(-0.0,1.0),np.complex(-2.0,3.0),np.complex(4.0,-1.0)},{np.complex(2.0,0.0),np.complex(-1.0,0.0),np.complex(0.25,-1.0),np.complex(-3.0,-0.0)}}},np.complex64); local r=np.mean(a,1); assert(r.dtype=='complex64','complex reduce dtype 653'); assert(close(r:tolist(),{{np.complex(-1.5,0.5),np.complex(2.0,0.0),np.complex(-0.5,-1.25),np.complex(-1.5,0.5)},{np.complex(0.5,2.0),np.complex(-0.5,-1.0),np.complex(-1.5,2.0),np.complex(1.5,1.0)},{np.complex(-0.5,-0.5),np.complex(1.5,1.5),np.complex(0.125,-1.0),np.complex(-1.0,0.0)}},3e-05),'complex reduce 653') end
do local a=np.array({{{np.complex(1.0,-1.0),np.complex(0.25,-3.0),np.complex(-1.0,1.0),np.complex(0.25,1.0)},{np.complex(0.0,-1.0),np.complex(-2.0,1.0),np.complex(1.0,-3.0),np.complex(1.0,0.5)},{np.complex(2.0,-1.0),np.complex(-0.0,0.0),np.complex(1.0,-0.0),np.complex(0.25,3.0)}},{{np.complex(4.0,0.0),np.complex(-0.0,1.0),np.complex(-2.0,-3.0),np.complex(1.0,0.5)},{np.complex(0.0,-0.0),np.complex(0.25,3.0),np.complex(-0.0,1.0),np.complex(-1.0,3.0)},{np.complex(1.0,-0.0),np.complex(-2.0,1.0),np.complex(0.0,1.0),np.complex(1.0,1.0)}}},np.complex64); local r=np.sum(a,1); assert(r.dtype=='complex64','complex reduce dtype 654'); assert(close(r:tolist(),{{np.complex(5.0,-1.0),np.complex(0.25,-2.0),np.complex(-3.0,-2.0),np.complex(1.25,1.5)},{np.complex(0.0,-1.0),np.complex(-1.75,4.0),np.complex(1.0,-2.0),np.complex(0.0,3.5)},{np.complex(3.0,-1.0),np.complex(-2.0,1.0),np.complex(1.0,1.0),np.complex(1.25,4.0)}},3e-05),'complex reduce 654') end
do local a=np.array({{{np.complex(1.0,-1.0),np.complex(0.25,-3.0),np.complex(-1.0,1.0),np.complex(0.25,1.0)},{np.complex(0.0,-1.0),np.complex(-2.0,1.0),np.complex(1.0,-3.0),np.complex(1.0,0.5)},{np.complex(2.0,-1.0),np.complex(-0.0,0.0),np.complex(1.0,-0.0),np.complex(0.25,3.0)}},{{np.complex(4.0,0.0),np.complex(-0.0,1.0),np.complex(-2.0,-3.0),np.complex(1.0,0.5)},{np.complex(0.0,-0.0),np.complex(0.25,3.0),np.complex(-0.0,1.0),np.complex(-1.0,3.0)},{np.complex(1.0,-0.0),np.complex(-2.0,1.0),np.complex(0.0,1.0),np.complex(1.0,1.0)}}},np.complex64); local r=np.prod(a,1); assert(r.dtype=='complex64','complex reduce dtype 655'); assert(close(r:tolist(),{{np.complex(4.0,-4.0),np.complex(3.0,0.25),np.complex(5.0,1.0),np.complex(-0.25,1.125)},{np.complex(0.0,-0.0),np.complex(-3.5,-5.75),np.complex(3.0,1.0),np.complex(-2.5,2.5)},{np.complex(2.0,-1.0),np.complex(0.0,-0.0),np.complex(0.0,1.0),np.complex(-2.75,3.25)}},3e-05),'complex reduce 655') end
do local a=np.array({{{np.complex(1.0,-1.0),np.complex(0.25,-3.0),np.complex(-1.0,1.0),np.complex(0.25,1.0)},{np.complex(0.0,-1.0),np.complex(-2.0,1.0),np.complex(1.0,-3.0),np.complex(1.0,0.5)},{np.complex(2.0,-1.0),np.complex(-0.0,0.0),np.complex(1.0,-0.0),np.complex(0.25,3.0)}},{{np.complex(4.0,0.0),np.complex(-0.0,1.0),np.complex(-2.0,-3.0),np.complex(1.0,0.5)},{np.complex(0.0,-0.0),np.complex(0.25,3.0),np.complex(-0.0,1.0),np.complex(-1.0,3.0)},{np.complex(1.0,-0.0),np.complex(-2.0,1.0),np.complex(0.0,1.0),np.complex(1.0,1.0)}}},np.complex64); local r=np.mean(a,1); assert(r.dtype=='complex64','complex reduce dtype 656'); assert(close(r:tolist(),{{np.complex(2.5,-0.5),np.complex(0.125,-1.0),np.complex(-1.5,-1.0),np.complex(0.625,0.75)},{np.complex(0.0,-0.5),np.complex(-0.875,2.0),np.complex(0.5,-1.0),np.complex(0.0,1.75)},{np.complex(1.5,-0.5),np.complex(-1.0,0.5),np.complex(0.5,0.5),np.complex(0.625,2.0)}},3e-05),'complex reduce 656') end
do local a=np.array({{np.complex(-2.0,3.0),np.complex(4.0,0.0),np.complex(-0.0,0.5),np.complex(1.0,-1.0),np.complex(0.25,1.0)},{np.complex(0.0,-1.0),np.complex(0.25,-3.0),np.complex(-2.0,-1.0),np.complex(0.0,0.0),np.complex(-2.0,0.0)}},np.complex64); local r=np.sum(a,1); assert(r.dtype=='complex64','complex reduce dtype 657'); assert(close(r:tolist(),{np.complex(-2.0,2.0),np.complex(4.25,-3.0),np.complex(-2.0,-0.5),np.complex(1.0,-1.0),np.complex(-1.75,1.0)},3e-05),'complex reduce 657') end
do local a=np.array({{np.complex(-2.0,3.0),np.complex(4.0,0.0),np.complex(-0.0,0.5),np.complex(1.0,-1.0),np.complex(0.25,1.0)},{np.complex(0.0,-1.0),np.complex(0.25,-3.0),np.complex(-2.0,-1.0),np.complex(0.0,0.0),np.complex(-2.0,0.0)}},np.complex64); local r=np.prod(a,1); assert(r.dtype=='complex64','complex reduce dtype 658'); assert(close(r:tolist(),{np.complex(3.0,2.0),np.complex(1.0,-12.0),np.complex(0.5,-1.0),np.complex(0.0,0.0),np.complex(-0.5,-2.0)},3e-05),'complex reduce 658') end
do local a=np.array({{np.complex(-2.0,3.0),np.complex(4.0,0.0),np.complex(-0.0,0.5),np.complex(1.0,-1.0),np.complex(0.25,1.0)},{np.complex(0.0,-1.0),np.complex(0.25,-3.0),np.complex(-2.0,-1.0),np.complex(0.0,0.0),np.complex(-2.0,0.0)}},np.complex64); local r=np.mean(a,1); assert(r.dtype=='complex64','complex reduce dtype 659'); assert(close(r:tolist(),{np.complex(-1.0,1.0),np.complex(2.125,-1.5),np.complex(-1.0,-0.25),np.complex(0.5,-0.5),np.complex(-0.875,0.5)},3e-05),'complex reduce 659') end
do local a=np.array({{{np.complex(0.25,1.0),np.complex(-1.0,0.5),np.complex(0.25,0.0),np.complex(2.0,0.5)},{np.complex(-3.0,-0.0),np.complex(2.0,-0.0),np.complex(2.0,-1.0),np.complex(-2.0,-3.0)},{np.complex(2.0,-1.0),np.complex(-2.0,0.0),np.complex(-2.0,-0.0),np.complex(-2.0,1.0)}},{{np.complex(0.0,1.0),np.complex(-0.0,3.0),np.complex(-2.0,1.0),np.complex(0.25,-1.0)},{np.complex(-2.0,1.0),np.complex(4.0,-3.0),np.complex(0.0,3.0),np.complex(0.0,0.5)},{np.complex(-0.0,0.0),np.complex(1.0,-1.0),np.complex(-0.0,0.0),np.complex(-0.0,1.0)}}},np.complex128); local r=np.sum(a,1); assert(r.dtype=='complex128','complex reduce dtype 660'); assert(close(r:tolist(),{{np.complex(0.25,2.0),np.complex(-1.0,3.5),np.complex(-1.75,1.0),np.complex(2.25,-0.5)},{np.complex(-5.0,1.0),np.complex(6.0,-3.0),np.complex(2.0,2.0),np.complex(-2.0,-2.5)},{np.complex(2.0,-1.0),np.complex(-1.0,-1.0),np.complex(-2.0,0.0),np.complex(-2.0,2.0)}},2e-12),'complex reduce 660') end
do local a=np.array({{{np.complex(0.25,1.0),np.complex(-1.0,0.5),np.complex(0.25,0.0),np.complex(2.0,0.5)},{np.complex(-3.0,-0.0),np.complex(2.0,-0.0),np.complex(2.0,-1.0),np.complex(-2.0,-3.0)},{np.complex(2.0,-1.0),np.complex(-2.0,0.0),np.complex(-2.0,-0.0),np.complex(-2.0,1.0)}},{{np.complex(0.0,1.0),np.complex(-0.0,3.0),np.complex(-2.0,1.0),np.complex(0.25,-1.0)},{np.complex(-2.0,1.0),np.complex(4.0,-3.0),np.complex(0.0,3.0),np.complex(0.0,0.5)},{np.complex(-0.0,0.0),np.complex(1.0,-1.0),np.complex(-0.0,0.0),np.complex(-0.0,1.0)}}},np.complex128); local r=np.prod(a,1); assert(r.dtype=='complex128','complex reduce dtype 661'); assert(close(r:tolist(),{{np.complex(-1.0,0.25),np.complex(-1.5,-3.0),np.complex(-0.5,0.25),np.complex(1.0,-1.875)},{np.complex(6.0,-3.0),np.complex(8.0,-6.0),np.complex(3.0,6.0),np.complex(1.5,-1.0)},{np.complex(0.0,0.0),np.complex(-2.0,2.0),np.complex(0.0,0.0),np.complex(-1.0,-2.0)}},2e-12),'complex reduce 661') end
do local a=np.array({{{np.complex(0.25,1.0),np.complex(-1.0,0.5),np.complex(0.25,0.0),np.complex(2.0,0.5)},{np.complex(-3.0,-0.0),np.complex(2.0,-0.0),np.complex(2.0,-1.0),np.complex(-2.0,-3.0)},{np.complex(2.0,-1.0),np.complex(-2.0,0.0),np.complex(-2.0,-0.0),np.complex(-2.0,1.0)}},{{np.complex(0.0,1.0),np.complex(-0.0,3.0),np.complex(-2.0,1.0),np.complex(0.25,-1.0)},{np.complex(-2.0,1.0),np.complex(4.0,-3.0),np.complex(0.0,3.0),np.complex(0.0,0.5)},{np.complex(-0.0,0.0),np.complex(1.0,-1.0),np.complex(-0.0,0.0),np.complex(-0.0,1.0)}}},np.complex128); local r=np.mean(a,1); assert(r.dtype=='complex128','complex reduce dtype 662'); assert(close(r:tolist(),{{np.complex(0.125,1.0),np.complex(-0.5,1.75),np.complex(-0.875,0.5),np.complex(1.125,-0.25)},{np.complex(-2.5,0.5),np.complex(3.0,-1.5),np.complex(1.0,1.0),np.complex(-1.0,-1.25)},{np.complex(1.0,-0.5),np.complex(-0.5,-0.5),np.complex(-1.0,0.0),np.complex(-1.0,1.0)}},2e-12),'complex reduce 662') end
do local a=np.array({{np.complex(2.0,0.5),np.complex(1.0,-1.0),np.complex(-3.0,3.0),np.complex(-3.0,1.0),np.complex(-3.0,0.5)},{np.complex(-0.0,3.0),np.complex(-1.0,-1.0),np.complex(-3.0,0.5),np.complex(2.0,-0.0),np.complex(1.0,-1.0)}},np.complex64); local r=np.sum(a,1); assert(r.dtype=='complex64','complex reduce dtype 663'); assert(close(r:tolist(),{np.complex(2.0,3.5),np.complex(0.0,-2.0),np.complex(-6.0,3.5),np.complex(-1.0,1.0),np.complex(-2.0,-0.5)},3e-05),'complex reduce 663') end
do local a=np.array({{np.complex(2.0,0.5),np.complex(1.0,-1.0),np.complex(-3.0,3.0),np.complex(-3.0,1.0),np.complex(-3.0,0.5)},{np.complex(-0.0,3.0),np.complex(-1.0,-1.0),np.complex(-3.0,0.5),np.complex(2.0,-0.0),np.complex(1.0,-1.0)}},np.complex64); local r=np.prod(a,1); assert(r.dtype=='complex64','complex reduce dtype 664'); assert(close(r:tolist(),{np.complex(-1.5,6.0),np.complex(-2.0,0.0),np.complex(7.5,-10.5),np.complex(-6.0,2.0),np.complex(-2.5,3.5)},3e-05),'complex reduce 664') end
do local a=np.array({{np.complex(2.0,0.5),np.complex(1.0,-1.0),np.complex(-3.0,3.0),np.complex(-3.0,1.0),np.complex(-3.0,0.5)},{np.complex(-0.0,3.0),np.complex(-1.0,-1.0),np.complex(-3.0,0.5),np.complex(2.0,-0.0),np.complex(1.0,-1.0)}},np.complex64); local r=np.mean(a,1); assert(r.dtype=='complex64','complex reduce dtype 665'); assert(close(r:tolist(),{np.complex(1.0,1.75),np.complex(0.0,-1.0),np.complex(-3.0,1.75),np.complex(-0.5,0.5),np.complex(-1.0,-0.25)},3e-05),'complex reduce 665') end
do local a=np.array({{np.complex(1.0,0.0),np.complex(-1.0,1.0),np.complex(-1.0,-1.0),np.complex(0.0,0.0),np.complex(2.0,3.0)},{np.complex(0.0,0.0),np.complex(4.0,-3.0),np.complex(1.0,0.5),np.complex(-0.0,0.5),np.complex(0.25,-0.0)}},np.complex64); local r=np.sum(a,1); assert(r.dtype=='complex64','complex reduce dtype 666'); assert(close(r:tolist(),{np.complex(1.0,0.0),np.complex(3.0,-2.0),np.complex(0.0,-0.5),np.complex(0.0,0.5),np.complex(2.25,3.0)},3e-05),'complex reduce 666') end
do local a=np.array({{np.complex(1.0,0.0),np.complex(-1.0,1.0),np.complex(-1.0,-1.0),np.complex(0.0,0.0),np.complex(2.0,3.0)},{np.complex(0.0,0.0),np.complex(4.0,-3.0),np.complex(1.0,0.5),np.complex(-0.0,0.5),np.complex(0.25,-0.0)}},np.complex64); local r=np.prod(a,1); assert(r.dtype=='complex64','complex reduce dtype 667'); assert(close(r:tolist(),{np.complex(0.0,0.0),np.complex(-1.0,7.0),np.complex(-0.5,-1.5),np.complex(-0.0,0.0),np.complex(0.5,0.75)},3e-05),'complex reduce 667') end
do local a=np.array({{np.complex(1.0,0.0),np.complex(-1.0,1.0),np.complex(-1.0,-1.0),np.complex(0.0,0.0),np.complex(2.0,3.0)},{np.complex(0.0,0.0),np.complex(4.0,-3.0),np.complex(1.0,0.5),np.complex(-0.0,0.5),np.complex(0.25,-0.0)}},np.complex64); local r=np.mean(a,1); assert(r.dtype=='complex64','complex reduce dtype 668'); assert(close(r:tolist(),{np.complex(0.5,0.0),np.complex(1.5,-1.0),np.complex(0.0,-0.25),np.complex(0.0,0.25),np.complex(1.125,1.5)},3e-05),'complex reduce 668') end
do local a=np.array({{{np.complex(2.0,1.0),np.complex(2.0,1.0),np.complex(1.0,-3.0),np.complex(-1.0,3.0)},{np.complex(2.0,1.0),np.complex(4.0,3.0),np.complex(-1.0,-1.0),np.complex(-0.0,0.0)},{np.complex(-3.0,3.0),np.complex(0.25,0.0),np.complex(0.0,3.0),np.complex(0.25,0.5)}},{{np.complex(-0.0,-1.0),np.complex(2.0,3.0),np.complex(0.25,3.0),np.complex(0.25,0.0)},{np.complex(-1.0,-0.0),np.complex(-2.0,0.0),np.complex(-1.0,-1.0),np.complex(0.0,-1.0)},{np.complex(2.0,-1.0),np.complex(-2.0,-3.0),np.complex(-1.0,0.0),np.complex(0.0,0.0)}}},np.complex128); local r=np.sum(a,2); assert(r.dtype=='complex128','complex reduce dtype 669'); assert(close(r:tolist(),{{np.complex(1.0,5.0),np.complex(6.25,4.0),np.complex(0.0,-1.0),np.complex(-0.75,3.5)},{np.complex(1.0,-2.0),np.complex(-2.0,0.0),np.complex(-1.75,2.0),np.complex(0.25,-1.0)}},2e-12),'complex reduce 669') end
do local a=np.array({{{np.complex(2.0,1.0),np.complex(2.0,1.0),np.complex(1.0,-3.0),np.complex(-1.0,3.0)},{np.complex(2.0,1.0),np.complex(4.0,3.0),np.complex(-1.0,-1.0),np.complex(-0.0,0.0)},{np.complex(-3.0,3.0),np.complex(0.25,0.0),np.complex(0.0,3.0),np.complex(0.25,0.5)}},{{np.complex(-0.0,-1.0),np.complex(2.0,3.0),np.complex(0.25,3.0),np.complex(0.25,0.0)},{np.complex(-1.0,-0.0),np.complex(-2.0,0.0),np.complex(-1.0,-1.0),np.complex(0.0,-1.0)},{np.complex(2.0,-1.0),np.complex(-2.0,-3.0),np.complex(-1.0,0.0),np.complex(0.0,0.0)}}},np.complex128); local r=np.prod(a,2); assert(r.dtype=='complex128','complex reduce dtype 670'); assert(close(r:tolist(),{{np.complex(-21.0,-3.0),np.complex(1.25,2.5),np.complex(-6.0,-12.0),np.complex(0.0,0.0)},{np.complex(1.0,2.0),np.complex(-10.0,24.0),np.complex(-2.75,3.25),np.complex(0.0,0.0)}},2e-12),'complex reduce 670') end
do local a=np.array({{{np.complex(2.0,1.0),np.complex(2.0,1.0),np.complex(1.0,-3.0),np.complex(-1.0,3.0)},{np.complex(2.0,1.0),np.complex(4.0,3.0),np.complex(-1.0,-1.0),np.complex(-0.0,0.0)},{np.complex(-3.0,3.0),np.complex(0.25,0.0),np.complex(0.0,3.0),np.complex(0.25,0.5)}},{{np.complex(-0.0,-1.0),np.complex(2.0,3.0),np.complex(0.25,3.0),np.complex(0.25,0.0)},{np.complex(-1.0,-0.0),np.complex(-2.0,0.0),np.complex(-1.0,-1.0),np.complex(0.0,-1.0)},{np.complex(2.0,-1.0),np.complex(-2.0,-3.0),np.complex(-1.0,0.0),np.complex(0.0,0.0)}}},np.complex128); local r=np.mean(a,2); assert(r.dtype=='complex128','complex reduce dtype 671'); assert(close(r:tolist(),{{np.complex(0.3333333333333333,1.6666666666666665),np.complex(2.083333333333333,1.3333333333333333),np.complex(0.0,-0.3333333333333333),np.complex(-0.25,1.1666666666666665)},{np.complex(0.3333333333333333,-0.6666666666666666),np.complex(-0.6666666666666666,0.0),np.complex(-0.5833333333333333,0.6666666666666666),np.complex(0.08333333333333333,-0.3333333333333333)}},2e-12),'complex reduce 671') end
do local a=np.array({np.complex(-1.0,-0.0),np.complex(4.0,0.5),np.complex(-3.0,3.0),np.complex(-0.0,1.0),np.complex(-2.0,-1.0),np.complex(0.0,-1.0),np.complex(2.0,1.0),np.complex(-2.0,-0.0)},np.complex64); local r=np.add_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(-1.0,-0.0),np.complex(3.0,0.5),np.complex(0.0,3.5),np.complex(0.0,4.5),np.complex(-2.0,3.5),np.complex(-2.0,2.5),np.complex(0.0,3.5),np.complex(-2.0,3.5)},3e-05),'complex accumulate 672') end
do local a=np.array({np.complex(0.0,1.0),np.complex(2.0,3.0),np.complex(1.0,3.0),np.complex(0.0,-0.0),np.complex(4.0,0.5),np.complex(-1.0,3.0),np.complex(-1.0,1.0),np.complex(2.0,0.5)},np.complex64); local r=np.add_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(0.0,1.0),np.complex(2.0,4.0),np.complex(3.0,7.0),np.complex(3.0,7.0),np.complex(7.0,7.5),np.complex(6.0,10.5),np.complex(5.0,11.5),np.complex(7.0,12.0)},3e-05),'complex accumulate 673') end
do local a=np.array({np.complex(-3.0,-3.0),np.complex(-2.0,0.5),np.complex(-0.0,0.0),np.complex(0.25,0.5),np.complex(2.0,1.0),np.complex(-0.0,-3.0),np.complex(1.0,1.0),np.complex(-2.0,-3.0)},np.complex128); local r=np.add_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(-3.0,-3.0),np.complex(-5.0,-2.5),np.complex(-5.0,-2.5),np.complex(-4.75,-2.0),np.complex(-2.75,-1.0),np.complex(-2.75,-4.0),np.complex(-1.75,-3.0),np.complex(-3.75,-6.0)},2e-12),'complex accumulate 674') end
do local a=np.array({np.complex(-3.0,3.0),np.complex(0.0,-1.0),np.complex(-1.0,-1.0),np.complex(4.0,1.0),np.complex(-3.0,3.0),np.complex(0.0,-0.0),np.complex(0.0,1.0),np.complex(1.0,1.0)},np.complex128); local r=np.add_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(-3.0,3.0),np.complex(-3.0,2.0),np.complex(-4.0,1.0),np.complex(0.0,2.0),np.complex(-3.0,5.0),np.complex(-3.0,5.0),np.complex(-3.0,6.0),np.complex(-2.0,7.0)},2e-12),'complex accumulate 675') end
do local a=np.array({np.complex(4.0,0.0),np.complex(-2.0,0.5),np.complex(-3.0,-3.0),np.complex(0.0,3.0),np.complex(4.0,-3.0),np.complex(4.0,3.0),np.complex(4.0,0.5),np.complex(-1.0,3.0)},np.complex128); local r=np.add_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(4.0,0.0),np.complex(2.0,0.5),np.complex(-1.0,-2.5),np.complex(-1.0,0.5),np.complex(3.0,-2.5),np.complex(7.0,0.5),np.complex(11.0,1.0),np.complex(10.0,4.0)},2e-12),'complex accumulate 676') end
do local a=np.array({np.complex(-0.0,0.5),np.complex(0.0,-0.0),np.complex(1.0,0.5),np.complex(0.0,-3.0),np.complex(0.25,-3.0),np.complex(-2.0,-0.0),np.complex(1.0,1.0),np.complex(0.0,-3.0)},np.complex128); local r=np.add_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(-0.0,0.5),np.complex(0.0,0.5),np.complex(1.0,1.0),np.complex(1.0,-2.0),np.complex(1.25,-5.0),np.complex(-0.75,-5.0),np.complex(0.25,-4.0),np.complex(0.25,-7.0)},2e-12),'complex accumulate 677') end
do local a=np.array({np.complex(0.25,0.0),np.complex(2.0,-3.0),np.complex(0.0,1.0),np.complex(4.0,1.0),np.complex(0.25,-1.0),np.complex(2.0,-0.0),np.complex(-3.0,3.0),np.complex(4.0,-3.0)},np.complex128); local r=np.add_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(0.25,0.0),np.complex(2.25,-3.0),np.complex(2.25,-2.0),np.complex(6.25,-1.0),np.complex(6.5,-2.0),np.complex(8.5,-2.0),np.complex(5.5,1.0),np.complex(9.5,-2.0)},2e-12),'complex accumulate 678') end
do local a=np.array({np.complex(4.0,0.5),np.complex(0.0,-0.0),np.complex(2.0,3.0),np.complex(-1.0,0.5),np.complex(0.0,0.0),np.complex(0.25,0.0),np.complex(2.0,0.0),np.complex(-3.0,-0.0)},np.complex128); local r=np.add_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(4.0,0.5),np.complex(4.0,0.5),np.complex(6.0,3.5),np.complex(5.0,4.0),np.complex(5.0,4.0),np.complex(5.25,4.0),np.complex(7.25,4.0),np.complex(4.25,4.0)},2e-12),'complex accumulate 679') end
do local a=np.array({np.complex(0.25,-0.0),np.complex(-1.0,1.0),np.complex(-2.0,0.0),np.complex(-2.0,1.0),np.complex(1.0,-1.0),np.complex(-3.0,1.0),np.complex(-1.0,-3.0),np.complex(2.0,3.0)},np.complex64); local r=np.add_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(0.25,-0.0),np.complex(-0.75,1.0),np.complex(-2.75,1.0),np.complex(-4.75,2.0),np.complex(-3.75,1.0),np.complex(-6.75,2.0),np.complex(-7.75,-1.0),np.complex(-5.75,2.0)},3e-05),'complex accumulate 680') end
do local a=np.array({np.complex(4.0,-3.0),np.complex(-2.0,1.0),np.complex(0.25,-3.0),np.complex(-1.0,0.5),np.complex(-2.0,0.5),np.complex(2.0,-3.0),np.complex(1.0,0.5),np.complex(-2.0,-1.0)},np.complex64); local r=np.add_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(4.0,-3.0),np.complex(2.0,-2.0),np.complex(2.25,-5.0),np.complex(1.25,-4.5),np.complex(-0.75,-4.0),np.complex(1.25,-7.0),np.complex(2.25,-6.5),np.complex(0.25,-7.5)},3e-05),'complex accumulate 681') end
do local a=np.array({np.complex(-0.0,-3.0),np.complex(1.0,0.5),np.complex(1.0,1.0),np.complex(-3.0,0.5),np.complex(-3.0,3.0),np.complex(-1.0,0.0),np.complex(-3.0,-1.0),np.complex(-2.0,0.5)},np.complex64); local r=np.add_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(-0.0,-3.0),np.complex(1.0,-2.5),np.complex(2.0,-1.5),np.complex(-1.0,-1.0),np.complex(-4.0,2.0),np.complex(-5.0,2.0),np.complex(-8.0,1.0),np.complex(-10.0,1.5)},3e-05),'complex accumulate 682') end
do local a=np.array({np.complex(2.0,1.0),np.complex(2.0,-3.0),np.complex(-1.0,-3.0),np.complex(-2.0,-0.0),np.complex(0.25,1.0),np.complex(-0.0,1.0),np.complex(-3.0,3.0),np.complex(2.0,3.0)},np.complex64); local r=np.add_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(2.0,1.0),np.complex(4.0,-2.0),np.complex(3.0,-5.0),np.complex(1.0,-5.0),np.complex(1.25,-4.0),np.complex(1.25,-3.0),np.complex(-1.75,0.0),np.complex(0.25,3.0)},3e-05),'complex accumulate 683') end
do local a=np.array({np.complex(1.0,3.0),np.complex(-1.0,0.5),np.complex(0.25,-3.0),np.complex(2.0,0.0),np.complex(-2.0,-3.0),np.complex(-0.0,0.0),np.complex(-0.0,0.5),np.complex(1.0,-0.0)},np.complex128); local r=np.add_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(1.0,3.0),np.complex(0.0,3.5),np.complex(0.25,0.5),np.complex(2.25,0.5),np.complex(0.25,-2.5),np.complex(0.25,-2.5),np.complex(0.25,-2.0),np.complex(1.25,-2.0)},2e-12),'complex accumulate 684') end
do local a=np.array({np.complex(0.0,1.0),np.complex(4.0,0.5),np.complex(4.0,1.0),np.complex(-2.0,0.0),np.complex(-3.0,1.0),np.complex(-2.0,-0.0),np.complex(-0.0,3.0),np.complex(-0.0,-0.0)},np.complex64); local r=np.add_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(0.0,1.0),np.complex(4.0,1.5),np.complex(8.0,2.5),np.complex(6.0,2.5),np.complex(3.0,3.5),np.complex(1.0,3.5),np.complex(1.0,6.5),np.complex(1.0,6.5)},3e-05),'complex accumulate 685') end
do local a=np.array({np.complex(-2.0,-3.0),np.complex(-1.0,-3.0),np.complex(0.25,1.0),np.complex(-1.0,0.5),np.complex(-2.0,3.0),np.complex(-3.0,-1.0),np.complex(4.0,-0.0),np.complex(-1.0,0.0)},np.complex64); local r=np.add_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(-2.0,-3.0),np.complex(-3.0,-6.0),np.complex(-2.75,-5.0),np.complex(-3.75,-4.5),np.complex(-5.75,-1.5),np.complex(-8.75,-2.5),np.complex(-4.75,-2.5),np.complex(-5.75,-2.5)},3e-05),'complex accumulate 686') end
do local a=np.array({np.complex(-1.0,-3.0),np.complex(-2.0,0.5),np.complex(0.0,-1.0),np.complex(-1.0,1.0),np.complex(-2.0,-0.0),np.complex(0.0,-0.0),np.complex(1.0,3.0),np.complex(2.0,-0.0)},np.complex128); local r=np.add_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(-1.0,-3.0),np.complex(-3.0,-2.5),np.complex(-3.0,-3.5),np.complex(-4.0,-2.5),np.complex(-6.0,-2.5),np.complex(-6.0,-2.5),np.complex(-5.0,0.5),np.complex(-3.0,0.5)},2e-12),'complex accumulate 687') end
do local a=np.array({np.complex(-0.0,1.0),np.complex(0.0,1.0),np.complex(0.0,-3.0),np.complex(-1.0,3.0),np.complex(-1.0,0.0),np.complex(-1.0,0.0),np.complex(-2.0,0.5),np.complex(0.0,-3.0)},np.complex128); local r=np.add_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(-0.0,1.0),np.complex(0.0,2.0),np.complex(0.0,-1.0),np.complex(-1.0,2.0),np.complex(-2.0,2.0),np.complex(-3.0,2.0),np.complex(-5.0,2.5),np.complex(-5.0,-0.5)},2e-12),'complex accumulate 688') end
do local a=np.array({np.complex(2.0,-0.0),np.complex(1.0,-3.0),np.complex(-2.0,0.5),np.complex(2.0,0.0),np.complex(-2.0,-0.0),np.complex(-0.0,1.0),np.complex(0.25,0.5),np.complex(4.0,0.5)},np.complex64); local r=np.add_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(2.0,-0.0),np.complex(3.0,-3.0),np.complex(1.0,-2.5),np.complex(3.0,-2.5),np.complex(1.0,-2.5),np.complex(1.0,-1.5),np.complex(1.25,-1.0),np.complex(5.25,-0.5)},3e-05),'complex accumulate 689') end
do local a=np.array({np.complex(0.25,-1.0),np.complex(-1.0,0.5),np.complex(-3.0,1.0),np.complex(4.0,1.0),np.complex(0.0,1.0),np.complex(4.0,-1.0),np.complex(-3.0,0.0),np.complex(4.0,0.0)},np.complex128); local r=np.add_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(0.25,-1.0),np.complex(-0.75,-0.5),np.complex(-3.75,0.5),np.complex(0.25,1.5),np.complex(0.25,2.5),np.complex(4.25,1.5),np.complex(1.25,1.5),np.complex(5.25,1.5)},2e-12),'complex accumulate 690') end
do local a=np.array({np.complex(-0.0,-3.0),np.complex(-1.0,3.0),np.complex(-3.0,3.0),np.complex(-1.0,-0.0),np.complex(1.0,0.5),np.complex(-3.0,0.5),np.complex(0.0,-0.0),np.complex(-2.0,3.0)},np.complex64); local r=np.add_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(-0.0,-3.0),np.complex(-1.0,0.0),np.complex(-4.0,3.0),np.complex(-5.0,3.0),np.complex(-4.0,3.5),np.complex(-7.0,4.0),np.complex(-7.0,4.0),np.complex(-9.0,7.0)},3e-05),'complex accumulate 691') end
do local a=np.array({np.complex(0.0,1.0),np.complex(1.0,1.0),np.complex(-3.0,0.0),np.complex(1.0,-3.0),np.complex(0.0,0.0),np.complex(1.0,-3.0),np.complex(-1.0,0.5),np.complex(-2.0,-3.0)},np.complex64); local r=np.add_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(0.0,1.0),np.complex(1.0,2.0),np.complex(-2.0,2.0),np.complex(-1.0,-1.0),np.complex(-1.0,-1.0),np.complex(0.0,-4.0),np.complex(-1.0,-3.5),np.complex(-3.0,-6.5)},3e-05),'complex accumulate 692') end
do local a=np.array({np.complex(2.0,0.0),np.complex(-1.0,0.0),np.complex(2.0,-3.0),np.complex(1.0,0.0),np.complex(0.25,-0.0),np.complex(4.0,-0.0),np.complex(0.25,3.0),np.complex(2.0,-3.0)},np.complex64); local r=np.add_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(2.0,0.0),np.complex(1.0,0.0),np.complex(3.0,-3.0),np.complex(4.0,-3.0),np.complex(4.25,-3.0),np.complex(8.25,-3.0),np.complex(8.5,0.0),np.complex(10.5,-3.0)},3e-05),'complex accumulate 693') end
do local a=np.array({np.complex(0.0,0.5),np.complex(-1.0,-1.0),np.complex(0.0,-1.0),np.complex(-2.0,-0.0),np.complex(2.0,-0.0),np.complex(0.25,-3.0),np.complex(0.25,0.5),np.complex(0.25,-0.0)},np.complex64); local r=np.add_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(0.0,0.5),np.complex(-1.0,-0.5),np.complex(-1.0,-1.5),np.complex(-3.0,-1.5),np.complex(-1.0,-1.5),np.complex(-0.75,-4.5),np.complex(-0.5,-4.0),np.complex(-0.25,-4.0)},3e-05),'complex accumulate 694') end
do local a=np.array({np.complex(2.0,-0.0),np.complex(0.25,3.0),np.complex(-0.0,-1.0),np.complex(-3.0,-3.0),np.complex(0.25,-3.0),np.complex(2.0,-0.0),np.complex(-3.0,0.0),np.complex(-0.0,-3.0)},np.complex64); local r=np.add_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(2.0,-0.0),np.complex(2.25,3.0),np.complex(2.25,2.0),np.complex(-0.75,-1.0),np.complex(-0.5,-4.0),np.complex(1.5,-4.0),np.complex(-1.5,-4.0),np.complex(-1.5,-7.0)},3e-05),'complex accumulate 695') end
do local a=np.array({np.complex(-2.0,0.5),np.complex(-2.0,3.0),np.complex(-2.0,3.0),np.complex(1.0,-1.0),np.complex(-1.0,0.5),np.complex(4.0,1.0),np.complex(4.0,3.0),np.complex(-3.0,-1.0)},np.complex64); local r=np.add_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(-2.0,0.5),np.complex(-4.0,3.5),np.complex(-6.0,6.5),np.complex(-5.0,5.5),np.complex(-6.0,6.0),np.complex(-2.0,7.0),np.complex(2.0,10.0),np.complex(-1.0,9.0)},3e-05),'complex accumulate 696') end
do local a=np.array({np.complex(-2.0,-3.0),np.complex(-3.0,-3.0),np.complex(2.0,-3.0),np.complex(1.0,-0.0),np.complex(-1.0,1.0),np.complex(-0.0,1.0),np.complex(-2.0,1.0),np.complex(1.0,0.5)},np.complex128); local r=np.multiply_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(-2.0,-3.0),np.complex(-3.0,15.0),np.complex(39.0,39.0),np.complex(39.0,39.0),np.complex(-78.0,0.0),np.complex(0.0,-78.0),np.complex(78.0,156.0),np.complex(0.0,195.0)},2e-12),'complex accumulate 697') end
do local a=np.array({np.complex(0.0,-1.0),np.complex(2.0,0.5),np.complex(0.25,-3.0),np.complex(0.25,3.0),np.complex(-2.0,0.5),np.complex(0.0,3.0),np.complex(-1.0,-1.0),np.complex(0.0,-1.0)},np.complex128); local r=np.multiply_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(0.0,-1.0),np.complex(0.5,-2.0),np.complex(-5.875,-2.0),np.complex(4.53125,-18.125),np.complex(0.0,38.515625),np.complex(-115.546875,0.0),np.complex(115.546875,115.546875),np.complex(115.546875,-115.546875)},2e-12),'complex accumulate 698') end
do local a=np.array({np.complex(4.0,0.0),np.complex(0.25,0.0),np.complex(0.25,0.5),np.complex(-2.0,3.0),np.complex(-3.0,1.0),np.complex(4.0,1.0),np.complex(1.0,1.0),np.complex(2.0,-0.0)},np.complex64); local r=np.multiply_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(4.0,0.0),np.complex(1.0,0.0),np.complex(0.25,0.5),np.complex(-2.0,-0.25),np.complex(6.25,-1.25),np.complex(26.25,1.25),np.complex(25.0,27.5),np.complex(50.0,55.0)},3e-05),'complex accumulate 699') end
do local a=np.array({np.complex(-0.0,-1.0),np.complex(-0.0,-3.0),np.complex(1.0,0.0),np.complex(4.0,-1.0),np.complex(4.0,1.0),np.complex(-0.0,3.0),np.complex(-0.0,-0.0),np.complex(0.0,-0.0)},np.complex128); local r=np.multiply_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(-0.0,-1.0),np.complex(-3.0,0.0),np.complex(-3.0,0.0),np.complex(-12.0,3.0),np.complex(-51.0,0.0),np.complex(0.0,-153.0),np.complex(-0.0,0.0),np.complex(0.0,0.0)},2e-12),'complex accumulate 700') end
do local a=np.array({np.complex(0.0,-1.0),np.complex(-3.0,0.5),np.complex(-2.0,-3.0),np.complex(-3.0,-0.0),np.complex(-2.0,0.5),np.complex(-2.0,0.0),np.complex(-2.0,0.5),np.complex(0.25,0.5)},np.complex64); local r=np.multiply_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(0.0,-1.0),np.complex(0.5,3.0),np.complex(8.0,-7.5),np.complex(-24.0,22.5),np.complex(36.75,-57.0),np.complex(-73.5,114.0),np.complex(90.0,-264.75),np.complex(154.875,-21.1875)},3e-05),'complex accumulate 701') end
do local a=np.array({np.complex(-0.0,0.0),np.complex(-1.0,1.0),np.complex(-3.0,0.5),np.complex(2.0,0.5),np.complex(0.0,0.0),np.complex(0.0,1.0),np.complex(-3.0,0.5),np.complex(-1.0,3.0)},np.complex128); local r=np.multiply_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0)},2e-12),'complex accumulate 702') end
do local a=np.array({np.complex(-1.0,1.0),np.complex(4.0,-0.0),np.complex(4.0,-0.0),np.complex(1.0,-0.0),np.complex(-1.0,1.0),np.complex(2.0,0.0),np.complex(-1.0,3.0),np.complex(-1.0,0.0)},np.complex128); local r=np.multiply_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(-1.0,1.0),np.complex(-4.0,4.0),np.complex(-16.0,16.0),np.complex(-16.0,16.0),np.complex(0.0,-32.0),np.complex(0.0,-64.0),np.complex(192.0,64.0),np.complex(-192.0,-64.0)},2e-12),'complex accumulate 703') end
do local a=np.array({np.complex(-0.0,-0.0),np.complex(0.0,-0.0),np.complex(0.0,3.0),np.complex(-2.0,-0.0),np.complex(0.0,1.0),np.complex(-3.0,-3.0),np.complex(1.0,-3.0),np.complex(0.0,-0.0)},np.complex128); local r=np.multiply_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(-0.0,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(0.0,-0.0),np.complex(0.0,-0.0)},2e-12),'complex accumulate 704') end
do local a=np.array({np.complex(-3.0,-3.0),np.complex(-2.0,1.0),np.complex(1.0,3.0),np.complex(4.0,0.0),np.complex(2.0,-0.0),np.complex(-0.0,0.5),np.complex(4.0,0.0),np.complex(0.0,-0.0)},np.complex64); local r=np.multiply_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(-3.0,-3.0),np.complex(9.0,3.0),np.complex(0.0,30.0),np.complex(0.0,120.0),np.complex(0.0,240.0),np.complex(-120.0,0.0),np.complex(-480.0,0.0),np.complex(0.0,0.0)},3e-05),'complex accumulate 705') end
do local a=np.array({np.complex(4.0,1.0),np.complex(4.0,0.5),np.complex(1.0,0.5),np.complex(-1.0,-3.0),np.complex(-1.0,-3.0),np.complex(-1.0,0.0),np.complex(-3.0,-1.0),np.complex(-3.0,0.0)},np.complex64); local r=np.multiply_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(4.0,1.0),np.complex(15.5,6.0),np.complex(12.5,13.75),np.complex(28.75,-51.25),np.complex(-182.5,-35.0),np.complex(182.5,35.0),np.complex(-512.5,-287.5),np.complex(1537.5,862.5)},3e-05),'complex accumulate 706') end
do local a=np.array({np.complex(-2.0,-1.0),np.complex(2.0,-1.0),np.complex(-2.0,-3.0),np.complex(-2.0,-3.0),np.complex(-3.0,-0.0),np.complex(-0.0,-0.0),np.complex(-3.0,-0.0),np.complex(-1.0,1.0)},np.complex128); local r=np.multiply_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(-2.0,-1.0),np.complex(-5.0,0.0),np.complex(10.0,15.0),np.complex(25.0,-60.0),np.complex(-75.0,180.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(0.0,0.0)},2e-12),'complex accumulate 707') end
do local a=np.array({np.complex(1.0,-1.0),np.complex(-2.0,0.5),np.complex(-3.0,0.5),np.complex(0.0,-3.0),np.complex(0.0,0.5),np.complex(-1.0,3.0),np.complex(-2.0,1.0),np.complex(-3.0,0.0)},np.complex64); local r=np.multiply_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(1.0,-1.0),np.complex(-1.5,2.5),np.complex(3.25,-8.25),np.complex(-24.75,-9.75),np.complex(4.875,-12.375),np.complex(32.25,27.0),np.complex(-91.5,-21.75),np.complex(274.5,65.25)},3e-05),'complex accumulate 708') end
do local a=np.array({np.complex(-3.0,-0.0),np.complex(-1.0,-3.0),np.complex(1.0,0.0),np.complex(-1.0,-0.0),np.complex(1.0,3.0),np.complex(-3.0,0.0),np.complex(0.0,-0.0),np.complex(0.25,-3.0)},np.complex128); local r=np.multiply_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(-3.0,-0.0),np.complex(3.0,9.0),np.complex(3.0,9.0),np.complex(-3.0,-9.0),np.complex(24.0,-18.0),np.complex(-72.0,54.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},2e-12),'complex accumulate 709') end
do local a=np.array({np.complex(-0.0,3.0),np.complex(-0.0,-1.0),np.complex(-3.0,0.5),np.complex(2.0,1.0),np.complex(2.0,-3.0),np.complex(0.25,0.5),np.complex(-1.0,1.0),np.complex(0.0,3.0)},np.complex128); local r=np.multiply_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(-0.0,3.0),np.complex(3.0,0.0),np.complex(-9.0,1.5),np.complex(-19.5,-6.0),np.complex(-57.0,46.5),np.complex(-37.5,-16.875),np.complex(54.375,-20.625),np.complex(61.875,163.125)},2e-12),'complex accumulate 710') end
do local a=np.array({np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(-3.0,0.0),np.complex(4.0,0.5),np.complex(-0.0,-0.0),np.complex(0.25,-3.0),np.complex(-3.0,0.5),np.complex(1.0,0.5)},np.complex128); local r=np.multiply_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(-1.0,1.0),np.complex(3.0,3.0),np.complex(-9.0,-9.0),np.complex(-31.5,-40.5),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(-0.0,0.0)},2e-12),'complex accumulate 711') end
do local a=np.array({np.complex(-3.0,1.0),np.complex(-0.0,1.0),np.complex(0.0,1.0),np.complex(-2.0,0.0),np.complex(0.25,0.5),np.complex(-1.0,1.0),np.complex(-0.0,-1.0),np.complex(-1.0,-1.0)},np.complex64); local r=np.multiply_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(-3.0,1.0),np.complex(-1.0,-3.0),np.complex(3.0,-1.0),np.complex(-6.0,2.0),np.complex(-2.5,-2.5),np.complex(5.0,0.0),np.complex(0.0,-5.0),np.complex(-5.0,5.0)},3e-05),'complex accumulate 712') end
do local a=np.array({np.complex(0.0,0.0),np.complex(0.25,-3.0),np.complex(-0.0,0.5),np.complex(-3.0,-0.0),np.complex(0.25,3.0),np.complex(-1.0,-3.0),np.complex(0.0,0.5),np.complex(-3.0,-1.0)},np.complex128); local r=np.multiply_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0)},2e-12),'complex accumulate 713') end
do local a=np.array({np.complex(-3.0,-3.0),np.complex(-3.0,-1.0),np.complex(0.25,0.5),np.complex(4.0,1.0),np.complex(0.25,0.5),np.complex(1.0,0.0),np.complex(-0.0,0.0),np.complex(2.0,-0.0)},np.complex128); local r=np.multiply_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(-3.0,-3.0),np.complex(6.0,12.0),np.complex(-4.5,6.0),np.complex(-24.0,19.5),np.complex(-15.75,-7.125),np.complex(-15.75,-7.125),np.complex(0.0,0.0),np.complex(0.0,0.0)},2e-12),'complex accumulate 714') end
do local a=np.array({np.complex(-0.0,-0.0),np.complex(0.0,1.0),np.complex(-3.0,0.0),np.complex(1.0,0.5),np.complex(-3.0,-1.0),np.complex(-1.0,-3.0),np.complex(-3.0,-3.0),np.complex(0.0,0.0)},np.complex128); local r=np.multiply_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(-0.0,-0.0),np.complex(0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(-0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},2e-12),'complex accumulate 715') end
do local a=np.array({np.complex(-3.0,0.5),np.complex(0.0,0.0),np.complex(2.0,3.0),np.complex(-1.0,3.0),np.complex(2.0,-3.0),np.complex(2.0,1.0),np.complex(0.0,0.5),np.complex(0.0,-0.0)},np.complex64); local r=np.multiply_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(-3.0,0.5),np.complex(-0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},3e-05),'complex accumulate 716') end
do local a=np.array({np.complex(-0.0,0.5),np.complex(1.0,-3.0),np.complex(2.0,-3.0),np.complex(-2.0,-1.0),np.complex(-3.0,-3.0),np.complex(-3.0,1.0),np.complex(-2.0,3.0),np.complex(-3.0,-1.0)},np.complex128); local r=np.multiply_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(-0.0,0.5),np.complex(1.5,0.5),np.complex(4.5,-3.5),np.complex(-12.5,2.5),np.complex(45.0,30.0),np.complex(-165.0,-45.0),np.complex(465.0,-405.0),np.complex(-1800.0,750.0)},2e-12),'complex accumulate 717') end
do local a=np.array({np.complex(-3.0,0.5),np.complex(4.0,-3.0),np.complex(-3.0,1.0),np.complex(-1.0,3.0),np.complex(-0.0,-3.0),np.complex(1.0,-0.0),np.complex(4.0,0.5),np.complex(2.0,3.0)},np.complex64); local r=np.multiply_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(-3.0,0.5),np.complex(-10.5,11.0),np.complex(20.5,-43.5),np.complex(110.0,105.0),np.complex(315.0,-330.0),np.complex(315.0,-330.0),np.complex(1425.0,-1162.5),np.complex(6337.5,1950.0)},3e-05),'complex accumulate 718') end
do local a=np.array({np.complex(-1.0,1.0),np.complex(0.25,0.0),np.complex(-0.0,3.0),np.complex(-1.0,-1.0),np.complex(-3.0,1.0),np.complex(-0.0,-0.0),np.complex(1.0,3.0),np.complex(-0.0,-1.0)},np.complex128); local r=np.multiply_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(-1.0,1.0),np.complex(-0.25,0.25),np.complex(-0.75,-0.75),np.complex(0.0,1.5),np.complex(-1.5,-4.5),np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0)},2e-12),'complex accumulate 719') end
do local a=np.array({np.complex(2.0,0.0),np.complex(-2.0,-0.0),np.complex(-2.0,1.0),np.complex(1.0,-1.0),np.complex(-2.0,0.5),np.complex(2.0,-0.0),np.complex(2.0,-0.0),np.complex(0.25,3.0)},np.complex128); local r=np.multiply_accumulate(a); assert(r.dtype=='complex128' and close(r:tolist(),{np.complex(2.0,0.0),np.complex(-4.0,-0.0),np.complex(8.0,-4.0),np.complex(4.0,-12.0),np.complex(-2.0,26.0),np.complex(-4.0,52.0),np.complex(-8.0,104.0),np.complex(-314.0,2.0)},2e-12),'complex accumulate 720') end
do local a=np.array({np.complex(-0.0,1.0),np.complex(1.0,0.5),np.complex(-3.0,-0.0),np.complex(0.0,0.5),np.complex(4.0,-3.0),np.complex(0.0,-3.0),np.complex(-0.0,-0.0),np.complex(-1.0,-0.0)},np.complex64); local r=np.multiply_accumulate(a); assert(r.dtype=='complex64' and close(r:tolist(),{np.complex(-0.0,1.0),np.complex(-0.5,1.0),np.complex(1.5,-3.0),np.complex(1.5,0.75),np.complex(8.25,-1.5),np.complex(-4.5,-24.75),np.complex(0.0,0.0),np.complex(0.0,-0.0)},3e-05),'complex accumulate 721') end
do local a=np.array({{np.complex(-1.0,1.0),np.complex(-2.0,0.0)},{np.complex(-1.0,2.0),np.complex(0.0,-2.0)}},np.complex128); local b=np.array({{np.complex(2.0,1.0)},{np.complex(2.0,0.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(-7.0,1.0)},{np.complex(-4.0,-1.0)}},2e-12),'complex matmul 722') end
do local a=np.array({{np.complex(2.0,2.0),np.complex(2.0,1.0)},{np.complex(-1.0,-2.0),np.complex(0.0,0.0)}},np.complex128); local b=np.array({{np.complex(2.0,1.0),np.complex(0.0,1.0),np.complex(-2.0,1.0)},{np.complex(1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,-1.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(2.0,11.0),np.complex(0.0,-2.0),np.complex(-3.0,-3.0)},{np.complex(0.0,-5.0),np.complex(2.0,-1.0),np.complex(4.0,3.0)}},2e-12),'complex matmul 723') end
do local a=np.array({{np.complex(0.0,2.0),np.complex(2.0,1.0)},{np.complex(-2.0,2.0),np.complex(-1.0,-2.0)}},np.complex128); local b=np.array({{np.complex(0.0,1.0)},{np.complex(1.0,2.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(-2.0,5.0)},{np.complex(1.0,-6.0)}},2e-12),'complex matmul 724') end
do local a=np.array({{np.complex(-2.0,-2.0),np.complex(-1.0,0.0)},{np.complex(-1.0,2.0),np.complex(-2.0,0.0)},{np.complex(0.0,-1.0),np.complex(2.0,-2.0)}},np.complex128); local b=np.array({{np.complex(-1.0,-1.0)},{np.complex(1.0,-2.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(-1.0,6.0)},{np.complex(1.0,3.0)},{np.complex(-3.0,-5.0)}},2e-12),'complex matmul 725') end
do local a=np.array({{np.complex(-1.0,2.0),np.complex(0.0,1.0),np.complex(0.0,-2.0)}},np.complex128); local b=np.array({{np.complex(1.0,2.0),np.complex(-2.0,-1.0),np.complex(-2.0,-2.0),np.complex(0.0,-1.0)},{np.complex(2.0,0.0),np.complex(-1.0,0.0),np.complex(-1.0,0.0),np.complex(-1.0,-1.0)},{np.complex(-2.0,2.0),np.complex(1.0,1.0),np.complex(0.0,1.0),np.complex(-2.0,-1.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(-1.0,6.0),np.complex(6.0,-6.0),np.complex(8.0,-3.0),np.complex(1.0,4.0)}},2e-12),'complex matmul 726') end
do local a=np.array({{np.complex(2.0,-1.0)}},np.complex128); local b=np.array({{np.complex(1.0,-1.0),np.complex(-2.0,-2.0),np.complex(2.0,1.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(1.0,-3.0),np.complex(-6.0,-2.0),np.complex(5.0,0.0)}},2e-12),'complex matmul 727') end
do local a=np.array({{np.complex(2.0,0.0),np.complex(-2.0,-2.0),np.complex(0.0,1.0)}},np.complex64); local b=np.array({{np.complex(1.0,1.0)},{np.complex(-1.0,-1.0)},{np.complex(-2.0,1.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(1.0,4.0)}},3e-05),'complex matmul 728') end
do local a=np.array({{np.complex(-1.0,2.0)}},np.complex64); local b=np.array({{np.complex(0.0,1.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(-2.0,-1.0)}},3e-05),'complex matmul 729') end
do local a=np.array({{np.complex(0.0,-2.0),np.complex(0.0,-1.0)},{np.complex(1.0,1.0),np.complex(1.0,2.0)},{np.complex(0.0,-2.0),np.complex(1.0,0.0)}},np.complex128); local b=np.array({{np.complex(0.0,-1.0)},{np.complex(-1.0,-2.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(-4.0,1.0)},{np.complex(4.0,-5.0)},{np.complex(-3.0,-2.0)}},2e-12),'complex matmul 730') end
do local a=np.array({{np.complex(-2.0,-1.0),np.complex(2.0,1.0),np.complex(2.0,-2.0)}},np.complex64); local b=np.array({{np.complex(-1.0,-2.0),np.complex(2.0,0.0),np.complex(-1.0,2.0),np.complex(1.0,1.0)},{np.complex(-2.0,0.0),np.complex(0.0,1.0),np.complex(-2.0,-2.0),np.complex(0.0,0.0)},{np.complex(-1.0,2.0),np.complex(-1.0,-2.0),np.complex(-2.0,0.0),np.complex(2.0,1.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(-2.0,9.0),np.complex(-11.0,-2.0),np.complex(-2.0,-5.0),np.complex(5.0,-5.0)}},3e-05),'complex matmul 731') end
do local a=np.array({{np.complex(-1.0,0.0),np.complex(2.0,2.0)}},np.complex64); local b=np.array({{np.complex(-1.0,0.0),np.complex(0.0,2.0),np.complex(-1.0,2.0)},{np.complex(2.0,-1.0),np.complex(2.0,0.0),np.complex(-2.0,2.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(7.0,2.0),np.complex(4.0,2.0),np.complex(-7.0,-2.0)}},3e-05),'complex matmul 732') end
do local a=np.array({{np.complex(1.0,0.0),np.complex(1.0,-1.0),np.complex(1.0,-1.0),np.complex(-2.0,2.0)},{np.complex(-2.0,2.0),np.complex(1.0,-1.0),np.complex(2.0,2.0),np.complex(-2.0,0.0)},{np.complex(2.0,2.0),np.complex(0.0,-2.0),np.complex(-1.0,-1.0),np.complex(0.0,-2.0)},{np.complex(-1.0,-1.0),np.complex(0.0,-1.0),np.complex(-1.0,0.0),np.complex(-1.0,2.0)}},np.complex64); local b=np.array({{np.complex(2.0,2.0),np.complex(-2.0,1.0),np.complex(0.0,2.0),np.complex(-1.0,-2.0)},{np.complex(1.0,-1.0),np.complex(1.0,-1.0),np.complex(0.0,-2.0),np.complex(1.0,2.0)},{np.complex(-1.0,-2.0),np.complex(-2.0,0.0),np.complex(-2.0,0.0),np.complex(-2.0,1.0)},{np.complex(0.0,-2.0),np.complex(-1.0,0.0),np.complex(0.0,2.0),np.complex(1.0,2.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(3.0,3.0),np.complex(-2.0,-1.0),np.complex(-8.0,-2.0),np.complex(-5.0,0.0)},{np.complex(-6.0,-4.0),np.complex(0.0,-12.0),np.complex(-10.0,-14.0),np.complex(1.0,-3.0)},{np.complex(-7.0,9.0),np.complex(-6.0,0.0),np.complex(-2.0,6.0),np.complex(13.0,-9.0)},{np.complex(4.0,-1.0),np.complex(5.0,-2.0),np.complex(-2.0,-4.0),np.complex(-2.0,1.0)}},3e-05),'complex matmul 733') end
do local a=np.array({{np.complex(-1.0,1.0),np.complex(2.0,-1.0)},{np.complex(2.0,-2.0),np.complex(-2.0,1.0)},{np.complex(-1.0,-1.0),np.complex(-2.0,0.0)}},np.complex64); local b=np.array({{np.complex(-1.0,-1.0),np.complex(1.0,-2.0)},{np.complex(1.0,2.0),np.complex(0.0,-2.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(6.0,3.0),np.complex(-1.0,-1.0)},{np.complex(-8.0,-3.0),np.complex(0.0,-2.0)},{np.complex(-2.0,-2.0),np.complex(-3.0,5.0)}},3e-05),'complex matmul 734') end
do local a=np.array({{np.complex(2.0,2.0),np.complex(2.0,2.0),np.complex(0.0,-1.0),np.complex(1.0,0.0)}},np.complex64); local b=np.array({{np.complex(0.0,2.0),np.complex(0.0,1.0),np.complex(-1.0,2.0)},{np.complex(-1.0,0.0),np.complex(-1.0,2.0),np.complex(-1.0,0.0)},{np.complex(1.0,-1.0),np.complex(2.0,-1.0),np.complex(1.0,-2.0)},{np.complex(1.0,1.0),np.complex(1.0,2.0),np.complex(-1.0,-1.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(-6.0,2.0),np.complex(-8.0,4.0),np.complex(-11.0,-2.0)}},3e-05),'complex matmul 735') end
do local a=np.array({{np.complex(-2.0,-2.0),np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(-2.0,1.0)}},np.complex64); local b=np.array({{np.complex(2.0,1.0),np.complex(0.0,-2.0),np.complex(-2.0,-1.0)},{np.complex(-2.0,1.0),np.complex(-1.0,-2.0),np.complex(0.0,1.0)},{np.complex(-2.0,-2.0),np.complex(-2.0,-1.0),np.complex(0.0,-1.0)},{np.complex(-2.0,-1.0),np.complex(-1.0,1.0),np.complex(1.0,-1.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(-3.0,-9.0),np.complex(-8.0,-3.0),np.complex(1.0,8.0)}},3e-05),'complex matmul 736') end
do local a=np.array({{np.complex(1.0,1.0)},{np.complex(0.0,1.0)},{np.complex(1.0,2.0)}},np.complex64); local b=np.array({{np.complex(0.0,-2.0),np.complex(-2.0,2.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(2.0,-2.0),np.complex(-4.0,0.0)},{np.complex(2.0,0.0),np.complex(-2.0,-2.0)},{np.complex(4.0,-2.0),np.complex(-6.0,-2.0)}},3e-05),'complex matmul 737') end
do local a=np.array({{np.complex(1.0,0.0),np.complex(2.0,0.0),np.complex(2.0,0.0)},{np.complex(2.0,-2.0),np.complex(2.0,0.0),np.complex(-1.0,2.0)},{np.complex(0.0,2.0),np.complex(2.0,2.0),np.complex(-2.0,2.0)},{np.complex(1.0,2.0),np.complex(0.0,-1.0),np.complex(1.0,1.0)}},np.complex128); local b=np.array({{np.complex(-2.0,2.0),np.complex(2.0,1.0),np.complex(0.0,2.0)},{np.complex(-2.0,2.0),np.complex(1.0,-1.0),np.complex(1.0,2.0)},{np.complex(0.0,-2.0),np.complex(0.0,-1.0),np.complex(2.0,-1.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(-6.0,2.0),np.complex(4.0,-3.0),np.complex(6.0,4.0)},{np.complex(-0.0,14.0),np.complex(10.0,-3.0),np.complex(6.0,13.0)},{np.complex(-8.0,0.0),np.complex(4.0,6.0),np.complex(-8.0,12.0)},{np.complex(-2.0,-2.0),np.complex(0.0,3.0),np.complex(1.0,2.0)}},2e-12),'complex matmul 738') end
do local a=np.array({{np.complex(1.0,0.0)},{np.complex(0.0,1.0)}},np.complex128); local b=np.array({{np.complex(0.0,-1.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(0.0,-1.0)},{np.complex(1.0,0.0)}},2e-12),'complex matmul 739') end
do local a=np.array({{np.complex(-1.0,1.0)}},np.complex64); local b=np.array({{np.complex(0.0,2.0),np.complex(-2.0,1.0),np.complex(-1.0,2.0),np.complex(-1.0,-2.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(-2.0,-2.0),np.complex(1.0,-3.0),np.complex(-1.0,-3.0),np.complex(3.0,1.0)}},3e-05),'complex matmul 740') end
do local a=np.array({{np.complex(1.0,-2.0)}},np.complex64); local b=np.array({{np.complex(1.0,0.0),np.complex(-1.0,1.0),np.complex(-2.0,-2.0),np.complex(-1.0,2.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(1.0,-2.0),np.complex(1.0,3.0),np.complex(-6.0,2.0),np.complex(3.0,4.0)}},3e-05),'complex matmul 741') end
do local a=np.array({{np.complex(-1.0,2.0),np.complex(2.0,1.0),np.complex(-2.0,2.0)},{np.complex(1.0,1.0),np.complex(0.0,-2.0),np.complex(0.0,-2.0)},{np.complex(-1.0,0.0),np.complex(0.0,1.0),np.complex(-2.0,-2.0)}},np.complex128); local b=np.array({{np.complex(-1.0,-1.0),np.complex(-2.0,-1.0),np.complex(-2.0,0.0)},{np.complex(-1.0,0.0),np.complex(-1.0,2.0),np.complex(1.0,0.0)},{np.complex(0.0,0.0),np.complex(0.0,-2.0),np.complex(1.0,-2.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(1.0,-2.0),np.complex(4.0,4.0),np.complex(6.0,3.0)},{np.complex(0.0,0.0),np.complex(-1.0,-1.0),np.complex(-6.0,-6.0)},{np.complex(1.0,0.0),np.complex(-4.0,4.0),np.complex(-4.0,3.0)}},2e-12),'complex matmul 742') end
do local a=np.array({{np.complex(2.0,-1.0)},{np.complex(2.0,0.0)},{np.complex(0.0,1.0)},{np.complex(-2.0,-1.0)}},np.complex128); local b=np.array({{np.complex(-2.0,1.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(-3.0,4.0)},{np.complex(-4.0,2.0)},{np.complex(-1.0,-2.0)},{np.complex(5.0,0.0)}},2e-12),'complex matmul 743') end
do local a=np.array({{np.complex(-2.0,1.0),np.complex(-1.0,0.0),np.complex(-2.0,0.0),np.complex(-1.0,-2.0)},{np.complex(0.0,-2.0),np.complex(-1.0,2.0),np.complex(-1.0,-2.0),np.complex(1.0,1.0)},{np.complex(-1.0,1.0),np.complex(-1.0,-2.0),np.complex(-2.0,1.0),np.complex(2.0,1.0)}},np.complex64); local b=np.array({{np.complex(-1.0,2.0)},{np.complex(0.0,2.0)},{np.complex(2.0,0.0)},{np.complex(0.0,-2.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(-8.0,-5.0)},{np.complex(0.0,-6.0)},{np.complex(1.0,-7.0)}},3e-05),'complex matmul 744') end
do local a=np.array({{np.complex(-2.0,-2.0),np.complex(-2.0,-2.0),np.complex(2.0,-1.0)}},np.complex128); local b=np.array({{np.complex(2.0,-1.0)},{np.complex(0.0,-2.0)},{np.complex(0.0,-1.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(-11.0,0.0)}},2e-12),'complex matmul 745') end
do local a=np.array({{np.complex(-2.0,2.0)},{np.complex(-2.0,2.0)},{np.complex(-1.0,2.0)},{np.complex(2.0,-1.0)}},np.complex64); local b=np.array({{np.complex(0.0,-2.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(4.0,4.0)},{np.complex(4.0,4.0)},{np.complex(4.0,2.0)},{np.complex(-2.0,-4.0)}},3e-05),'complex matmul 746') end
do local a=np.array({{np.complex(0.0,-2.0),np.complex(0.0,1.0),np.complex(-1.0,0.0)},{np.complex(1.0,0.0),np.complex(-1.0,1.0),np.complex(-1.0,2.0)},{np.complex(-2.0,-2.0),np.complex(-1.0,-2.0),np.complex(0.0,1.0)}},np.complex64); local b=np.array({{np.complex(-2.0,2.0),np.complex(-1.0,2.0),np.complex(0.0,1.0)},{np.complex(1.0,2.0),np.complex(-1.0,-1.0),np.complex(1.0,1.0)},{np.complex(2.0,2.0),np.complex(-1.0,-2.0),np.complex(-2.0,1.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(0.0,3.0),np.complex(6.0,3.0),np.complex(3.0,0.0)},{np.complex(-11.0,3.0),np.complex(6.0,2.0),np.complex(-2.0,-4.0)},{np.complex(9.0,-2.0),np.complex(7.0,0.0),np.complex(2.0,-7.0)}},3e-05),'complex matmul 747') end
do local a=np.array({{np.complex(1.0,-1.0)},{np.complex(1.0,1.0)},{np.complex(-1.0,-1.0)}},np.complex64); local b=np.array({{np.complex(0.0,0.0),np.complex(-2.0,2.0),np.complex(2.0,2.0),np.complex(0.0,-2.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(0.0,0.0),np.complex(0.0,4.0),np.complex(4.0,0.0),np.complex(-2.0,-2.0)},{np.complex(0.0,0.0),np.complex(-4.0,0.0),np.complex(0.0,4.0),np.complex(2.0,-2.0)},{np.complex(0.0,0.0),np.complex(4.0,0.0),np.complex(0.0,-4.0),np.complex(-2.0,2.0)}},3e-05),'complex matmul 748') end
do local a=np.array({{np.complex(-2.0,2.0),np.complex(2.0,-1.0),np.complex(2.0,0.0),np.complex(0.0,-1.0)}},np.complex128); local b=np.array({{np.complex(1.0,0.0),np.complex(2.0,1.0)},{np.complex(0.0,0.0),np.complex(0.0,-1.0)},{np.complex(0.0,0.0),np.complex(0.0,-1.0)},{np.complex(1.0,1.0),np.complex(-1.0,1.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(-1.0,1.0),np.complex(-6.0,-1.0)}},2e-12),'complex matmul 749') end
do local a=np.array({{np.complex(-1.0,-1.0),np.complex(2.0,0.0),np.complex(-2.0,0.0)},{np.complex(-1.0,2.0),np.complex(2.0,0.0),np.complex(0.0,1.0)},{np.complex(-2.0,1.0),np.complex(-1.0,1.0),np.complex(-1.0,-2.0)}},np.complex64); local b=np.array({{np.complex(1.0,-2.0),np.complex(1.0,1.0),np.complex(-2.0,-2.0)},{np.complex(-1.0,-1.0),np.complex(1.0,-2.0),np.complex(-2.0,-1.0)},{np.complex(1.0,-2.0),np.complex(-2.0,-1.0),np.complex(-1.0,-1.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(-7.0,3.0),np.complex(6.0,-4.0),np.complex(-2.0,4.0)},{np.complex(3.0,3.0),np.complex(0.0,-5.0),np.complex(3.0,-5.0)},{np.complex(-3.0,5.0),np.complex(-2.0,7.0),np.complex(8.0,4.0)}},3e-05),'complex matmul 750') end
do local a=np.array({{np.complex(-2.0,1.0)},{np.complex(1.0,2.0)},{np.complex(-1.0,2.0)},{np.complex(2.0,-2.0)}},np.complex128); local b=np.array({{np.complex(-1.0,2.0),np.complex(1.0,-1.0),np.complex(0.0,1.0),np.complex(0.0,1.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(0.0,-5.0),np.complex(-1.0,3.0),np.complex(-1.0,-2.0),np.complex(-1.0,-2.0)},{np.complex(-5.0,0.0),np.complex(3.0,1.0),np.complex(-2.0,1.0),np.complex(-2.0,1.0)},{np.complex(-3.0,-4.0),np.complex(1.0,3.0),np.complex(-2.0,-1.0),np.complex(-2.0,-1.0)},{np.complex(2.0,6.0),np.complex(0.0,-4.0),np.complex(2.0,2.0),np.complex(2.0,2.0)}},2e-12),'complex matmul 751') end
do local a=np.array({{np.complex(2.0,0.0),np.complex(-1.0,1.0),np.complex(1.0,-1.0),np.complex(-1.0,-2.0)},{np.complex(-2.0,-1.0),np.complex(-1.0,-1.0),np.complex(0.0,1.0),np.complex(-2.0,0.0)},{np.complex(1.0,0.0),np.complex(-2.0,0.0),np.complex(2.0,-1.0),np.complex(-1.0,2.0)},{np.complex(2.0,-2.0),np.complex(0.0,-1.0),np.complex(0.0,1.0),np.complex(-1.0,-1.0)}},np.complex64); local b=np.array({{np.complex(0.0,-1.0)},{np.complex(-1.0,2.0)},{np.complex(-1.0,0.0)},{np.complex(1.0,1.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(-1.0,-7.0)},{np.complex(0.0,-2.0)},{np.complex(-3.0,-3.0)},{np.complex(0.0,-4.0)}},3e-05),'complex matmul 752') end
do local a=np.array({{np.complex(-1.0,-2.0),np.complex(-2.0,1.0),np.complex(-2.0,2.0),np.complex(-2.0,2.0)}},np.complex128); local b=np.array({{np.complex(0.0,-2.0),np.complex(2.0,-2.0),np.complex(-1.0,1.0)},{np.complex(0.0,-1.0),np.complex(2.0,0.0),np.complex(1.0,-2.0)},{np.complex(2.0,-2.0),np.complex(-1.0,1.0),np.complex(-2.0,2.0)},{np.complex(-2.0,2.0),np.complex(0.0,-1.0),np.complex(0.0,-2.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(-3.0,4.0),np.complex(-8.0,-2.0),np.complex(7.0,2.0)}},2e-12),'complex matmul 753') end
do local a=np.array({{np.complex(0.0,1.0),np.complex(2.0,-2.0),np.complex(1.0,-2.0)},{np.complex(0.0,0.0),np.complex(2.0,1.0),np.complex(0.0,-2.0)},{np.complex(0.0,1.0),np.complex(-1.0,-2.0),np.complex(1.0,1.0)}},np.complex128); local b=np.array({{np.complex(-2.0,-1.0),np.complex(2.0,2.0),np.complex(1.0,1.0),np.complex(0.0,0.0)},{np.complex(2.0,2.0),np.complex(-2.0,2.0),np.complex(1.0,-2.0),np.complex(0.0,0.0)},{np.complex(2.0,-1.0),np.complex(-1.0,-2.0),np.complex(0.0,1.0),np.complex(2.0,-1.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(9.0,-7.0),np.complex(-7.0,10.0),np.complex(-1.0,-4.0),np.complex(0.0,-5.0)},{np.complex(0.0,2.0),np.complex(-10.0,4.0),np.complex(6.0,-3.0),np.complex(-2.0,-4.0)},{np.complex(6.0,-7.0),np.complex(5.0,1.0),np.complex(-7.0,2.0),np.complex(3.0,1.0)}},2e-12),'complex matmul 754') end
do local a=np.array({{np.complex(1.0,-2.0),np.complex(1.0,2.0),np.complex(0.0,-1.0)}},np.complex64); local b=np.array({{np.complex(1.0,2.0)},{np.complex(2.0,-2.0)},{np.complex(1.0,-1.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(10.0,1.0)}},3e-05),'complex matmul 755') end
do local a=np.array({{np.complex(1.0,0.0),np.complex(1.0,-2.0)},{np.complex(-2.0,1.0),np.complex(1.0,1.0)},{np.complex(1.0,1.0),np.complex(-1.0,0.0)},{np.complex(2.0,1.0),np.complex(0.0,-1.0)}},np.complex64); local b=np.array({{np.complex(0.0,1.0)},{np.complex(2.0,2.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(6.0,-1.0)},{np.complex(-1.0,2.0)},{np.complex(-3.0,-1.0)},{np.complex(1.0,0.0)}},3e-05),'complex matmul 756') end
do local a=np.array({{np.complex(2.0,-1.0),np.complex(1.0,1.0)}},np.complex128); local b=np.array({{np.complex(-1.0,1.0),np.complex(0.0,0.0),np.complex(1.0,1.0)},{np.complex(-1.0,0.0),np.complex(-1.0,1.0),np.complex(-1.0,0.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(-2.0,2.0),np.complex(-2.0,0.0),np.complex(2.0,0.0)}},2e-12),'complex matmul 757') end
do local a=np.array({{np.complex(0.0,1.0)},{np.complex(1.0,2.0)}},np.complex128); local b=np.array({{np.complex(1.0,-1.0),np.complex(-1.0,0.0),np.complex(2.0,-2.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(1.0,1.0),np.complex(0.0,-1.0),np.complex(2.0,2.0)},{np.complex(3.0,1.0),np.complex(-1.0,-2.0),np.complex(6.0,2.0)}},2e-12),'complex matmul 758') end
do local a=np.array({{np.complex(2.0,1.0),np.complex(1.0,-1.0),np.complex(-2.0,-1.0)},{np.complex(1.0,2.0),np.complex(1.0,-1.0),np.complex(-2.0,-1.0)},{np.complex(2.0,-1.0),np.complex(-2.0,0.0),np.complex(0.0,-2.0)}},np.complex128); local b=np.array({{np.complex(-2.0,1.0),np.complex(2.0,-2.0),np.complex(1.0,-1.0)},{np.complex(-2.0,2.0),np.complex(2.0,-2.0),np.complex(0.0,-1.0)},{np.complex(-1.0,1.0),np.complex(2.0,1.0),np.complex(1.0,-2.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(-2.0,3.0),np.complex(3.0,-10.0),np.complex(-2.0,1.0)},{np.complex(-1.0,0.0),np.complex(3.0,-6.0),np.complex(-2.0,3.0)},{np.complex(3.0,2.0),np.complex(0.0,-6.0),np.complex(-3.0,-3.0)}},2e-12),'complex matmul 759') end
do local a=np.array({{np.complex(-1.0,0.0),np.complex(-2.0,1.0),np.complex(-1.0,-1.0)},{np.complex(1.0,-1.0),np.complex(1.0,-2.0),np.complex(1.0,-1.0)},{np.complex(1.0,1.0),np.complex(-1.0,2.0),np.complex(-2.0,2.0)},{np.complex(2.0,2.0),np.complex(-1.0,-1.0),np.complex(0.0,2.0)}},np.complex128); local b=np.array({{np.complex(-2.0,0.0),np.complex(-1.0,-1.0)},{np.complex(1.0,-1.0),np.complex(-1.0,-1.0)},{np.complex(2.0,2.0),np.complex(-1.0,0.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(1.0,-1.0),np.complex(5.0,3.0)},{np.complex(1.0,-1.0),np.complex(-6.0,2.0)},{np.complex(-9.0,1.0),np.complex(5.0,-5.0)},{np.complex(-10.0,0.0),np.complex(0.0,-4.0)}},2e-12),'complex matmul 760') end
do local a=np.array({{np.complex(0.0,-1.0)},{np.complex(1.0,-1.0)}},np.complex64); local b=np.array({{np.complex(1.0,0.0),np.complex(2.0,-1.0),np.complex(-1.0,-1.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(0.0,-1.0),np.complex(-1.0,-2.0),np.complex(-1.0,1.0)},{np.complex(1.0,-1.0),np.complex(1.0,-3.0),np.complex(-2.0,0.0)}},3e-05),'complex matmul 761') end
do local a=np.array({{np.complex(1.0,-2.0),np.complex(0.0,2.0),np.complex(1.0,-2.0)},{np.complex(-1.0,2.0),np.complex(-1.0,0.0),np.complex(-2.0,1.0)},{np.complex(1.0,-2.0),np.complex(1.0,-2.0),np.complex(0.0,-1.0)}},np.complex64); local b=np.array({{np.complex(2.0,2.0),np.complex(-1.0,1.0)},{np.complex(-1.0,2.0),np.complex(1.0,1.0)},{np.complex(-1.0,1.0),np.complex(0.0,0.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(3.0,-1.0),np.complex(-1.0,5.0)},{np.complex(-4.0,-3.0),np.complex(-2.0,-4.0)},{np.complex(10.0,3.0),np.complex(4.0,2.0)}},3e-05),'complex matmul 762') end
do local a=np.array({{np.complex(-2.0,1.0),np.complex(1.0,-2.0),np.complex(0.0,-1.0),np.complex(0.0,0.0)},{np.complex(1.0,2.0),np.complex(0.0,-2.0),np.complex(0.0,-1.0),np.complex(-1.0,-2.0)},{np.complex(-1.0,-2.0),np.complex(-1.0,-1.0),np.complex(-1.0,1.0),np.complex(-1.0,0.0)},{np.complex(1.0,-1.0),np.complex(2.0,-2.0),np.complex(0.0,-1.0),np.complex(-1.0,0.0)}},np.complex128); local b=np.array({{np.complex(-2.0,-1.0),np.complex(1.0,1.0),np.complex(-1.0,0.0)},{np.complex(-1.0,2.0),np.complex(-1.0,1.0),np.complex(-2.0,2.0)},{np.complex(-2.0,2.0),np.complex(1.0,-2.0),np.complex(2.0,-2.0)},{np.complex(2.0,-1.0),np.complex(-1.0,0.0),np.complex(-2.0,0.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(10.0,6.0),np.complex(-4.0,1.0),np.complex(2.0,3.0)},{np.complex(2.0,-4.0),np.complex(0.0,6.0),np.complex(3.0,4.0)},{np.complex(1.0,1.0),np.complex(5.0,0.0),np.complex(7.0,6.0)},{np.complex(-1.0,10.0),np.complex(1.0,3.0),np.complex(-1.0,7.0)}},2e-12),'complex matmul 763') end
do local a=np.array({{np.complex(2.0,0.0)},{np.complex(-1.0,-2.0)},{np.complex(0.0,0.0)}},np.complex64); local b=np.array({{np.complex(2.0,-2.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(4.0,-4.0)},{np.complex(-6.0,-2.0)},{np.complex(0.0,0.0)}},3e-05),'complex matmul 764') end
do local a=np.array({{np.complex(-1.0,2.0),np.complex(-1.0,2.0)},{np.complex(0.0,-2.0),np.complex(-1.0,2.0)},{np.complex(1.0,0.0),np.complex(0.0,-1.0)}},np.complex64); local b=np.array({{np.complex(1.0,2.0),np.complex(-1.0,1.0),np.complex(-2.0,1.0),np.complex(2.0,0.0)},{np.complex(2.0,2.0),np.complex(0.0,1.0),np.complex(0.0,-1.0),np.complex(0.0,-1.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(-11.0,2.0),np.complex(-3.0,-4.0),np.complex(2.0,-4.0),np.complex(-0.0,5.0)},{np.complex(-2.0,0.0),np.complex(-0.0,1.0),np.complex(4.0,5.0),np.complex(2.0,-3.0)},{np.complex(3.0,0.0),np.complex(0.0,1.0),np.complex(-3.0,1.0),np.complex(1.0,0.0)}},3e-05),'complex matmul 765') end
do local a=np.array({{np.complex(-1.0,2.0)},{np.complex(-2.0,2.0)},{np.complex(1.0,0.0)}},np.complex64); local b=np.array({{np.complex(-2.0,-1.0),np.complex(0.0,-2.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(4.0,-3.0),np.complex(4.0,2.0)},{np.complex(6.0,-2.0),np.complex(4.0,4.0)},{np.complex(-2.0,-1.0),np.complex(0.0,-2.0)}},3e-05),'complex matmul 766') end
do local a=np.array({{np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-1.0),np.complex(-1.0,-1.0)},{np.complex(1.0,-2.0),np.complex(0.0,2.0),np.complex(-2.0,-2.0),np.complex(2.0,0.0)},{np.complex(-1.0,2.0),np.complex(-1.0,0.0),np.complex(-2.0,2.0),np.complex(2.0,0.0)}},np.complex128); local b=np.array({{np.complex(2.0,-1.0),np.complex(0.0,2.0),np.complex(1.0,2.0),np.complex(-2.0,0.0)},{np.complex(0.0,-2.0),np.complex(1.0,-1.0),np.complex(2.0,2.0),np.complex(-2.0,-1.0)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(0.0,-1.0)},{np.complex(-2.0,2.0),np.complex(2.0,0.0),np.complex(0.0,0.0),np.complex(1.0,2.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(3.0,2.0),np.complex(1.0,-3.0),np.complex(-6.0,-4.0),np.complex(8.0,-4.0)},{np.complex(0.0,-1.0),np.complex(10.0,4.0),np.complex(-1.0,2.0),np.complex(0.0,6.0)},{np.complex(-4.0,11.0),np.complex(-1.0,-1.0),np.complex(-9.0,0.0),np.complex(8.0,3.0)}},2e-12),'complex matmul 767') end
do local a=np.array({{np.complex(1.0,0.0)},{np.complex(1.0,2.0)},{np.complex(-1.0,0.0)},{np.complex(0.0,-1.0)}},np.complex64); local b=np.array({{np.complex(-1.0,-1.0),np.complex(-2.0,2.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(-1.0,-1.0),np.complex(-2.0,2.0)},{np.complex(1.0,-3.0),np.complex(-6.0,-2.0)},{np.complex(1.0,1.0),np.complex(2.0,-2.0)},{np.complex(-1.0,1.0),np.complex(2.0,2.0)}},3e-05),'complex matmul 768') end
do local a=np.array({{np.complex(0.0,-1.0),np.complex(-1.0,1.0),np.complex(2.0,-1.0)},{np.complex(-1.0,-2.0),np.complex(0.0,-1.0),np.complex(1.0,-2.0)},{np.complex(-1.0,1.0),np.complex(-1.0,1.0),np.complex(2.0,-2.0)},{np.complex(2.0,2.0),np.complex(0.0,1.0),np.complex(2.0,-1.0)}},np.complex128); local b=np.array({{np.complex(-1.0,0.0)},{np.complex(0.0,-1.0)},{np.complex(-2.0,-2.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(-5.0,0.0)},{np.complex(-6.0,4.0)},{np.complex(-6.0,0.0)},{np.complex(-7.0,-4.0)}},2e-12),'complex matmul 769') end
do local a=np.array({{np.complex(-2.0,-1.0),np.complex(2.0,1.0),np.complex(2.0,0.0)},{np.complex(1.0,2.0),np.complex(-1.0,0.0),np.complex(-2.0,1.0)}},np.complex128); local b=np.array({{np.complex(1.0,1.0),np.complex(-1.0,-1.0),np.complex(1.0,-2.0)},{np.complex(-1.0,0.0),np.complex(-1.0,2.0),np.complex(1.0,1.0)},{np.complex(2.0,-2.0),np.complex(-2.0,-2.0),np.complex(0.0,2.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(1.0,-8.0),np.complex(-7.0,2.0),np.complex(-3.0,10.0)},{np.complex(-2.0,9.0),np.complex(8.0,-3.0),np.complex(2.0,-5.0)}},2e-12),'complex matmul 770') end
do local a=np.array({{np.complex(2.0,0.0),np.complex(2.0,2.0),np.complex(2.0,1.0)},{np.complex(1.0,0.0),np.complex(2.0,-1.0),np.complex(-2.0,-2.0)},{np.complex(1.0,2.0),np.complex(2.0,-1.0),np.complex(-1.0,-2.0)},{np.complex(-1.0,-1.0),np.complex(-1.0,2.0),np.complex(-2.0,2.0)}},np.complex64); local b=np.array({{np.complex(-1.0,1.0)},{np.complex(-1.0,2.0)},{np.complex(-2.0,0.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(-12.0,2.0)},{np.complex(3.0,10.0)},{np.complex(-1.0,8.0)},{np.complex(3.0,-8.0)}},3e-05),'complex matmul 771') end
do local a=np.array({{np.complex(1.0,-1.0)},{np.complex(-2.0,0.0)},{np.complex(1.0,-1.0)}},np.complex128); local b=np.array({{np.complex(-1.0,-2.0),np.complex(1.0,1.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(-3.0,-1.0),np.complex(2.0,0.0)},{np.complex(2.0,4.0),np.complex(-2.0,-2.0)},{np.complex(-3.0,-1.0),np.complex(2.0,0.0)}},2e-12),'complex matmul 772') end
do local a=np.array({{np.complex(-2.0,0.0),np.complex(-1.0,1.0),np.complex(-2.0,2.0),np.complex(2.0,0.0)},{np.complex(2.0,1.0),np.complex(-1.0,1.0),np.complex(0.0,2.0),np.complex(-1.0,-1.0)},{np.complex(-2.0,-1.0),np.complex(-2.0,2.0),np.complex(-1.0,-2.0),np.complex(-2.0,0.0)}},np.complex128); local b=np.array({{np.complex(1.0,2.0),np.complex(2.0,0.0)},{np.complex(-1.0,-1.0),np.complex(1.0,-2.0)},{np.complex(-2.0,0.0),np.complex(2.0,-1.0)},{np.complex(0.0,1.0),np.complex(2.0,-2.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(4.0,-6.0),np.complex(-1.0,5.0)},{np.complex(3.0,0.0),np.complex(3.0,9.0)},{np.complex(6.0,-3.0),np.complex(-10.0,5.0)}},2e-12),'complex matmul 773') end
do local a=np.array({{np.complex(-2.0,1.0),np.complex(-2.0,0.0),np.complex(0.0,1.0)},{np.complex(0.0,-2.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0)},{np.complex(0.0,1.0),np.complex(2.0,-1.0),np.complex(0.0,-2.0)}},np.complex128); local b=np.array({{np.complex(2.0,-1.0)},{np.complex(-2.0,0.0)},{np.complex(0.0,1.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(0.0,4.0)},{np.complex(0.0,-3.0)},{np.complex(-1.0,4.0)}},2e-12),'complex matmul 774') end
do local a=np.array({{np.complex(1.0,-1.0)},{np.complex(1.0,-1.0)},{np.complex(2.0,2.0)}},np.complex128); local b=np.array({{np.complex(-2.0,-1.0),np.complex(0.0,-1.0),np.complex(1.0,0.0)}},np.complex128); local r=np.matmul(a,b); assert(r.dtype=='complex128' and close(r:tolist(),{{np.complex(-3.0,1.0),np.complex(-1.0,-1.0),np.complex(1.0,-1.0)},{np.complex(-3.0,1.0),np.complex(-1.0,-1.0),np.complex(1.0,-1.0)},{np.complex(-2.0,-6.0),np.complex(2.0,-2.0),np.complex(2.0,2.0)}},2e-12),'complex matmul 775') end
do local a=np.array({{np.complex(2.0,0.0),np.complex(2.0,1.0)},{np.complex(-1.0,-1.0),np.complex(2.0,2.0)},{np.complex(2.0,-2.0),np.complex(0.0,-2.0)}},np.complex64); local b=np.array({{np.complex(-1.0,-1.0)},{np.complex(-1.0,-2.0)}},np.complex64); local r=np.matmul(a,b); assert(r.dtype=='complex64' and close(r:tolist(),{{np.complex(-2.0,-7.0)},{np.complex(2.0,-4.0)},{np.complex(-8.0,2.0)}},3e-05),'complex matmul 776') end
do local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,-2.0),np.complex(-1.0,-1.0),np.complex(2.0,-2.0),np.complex(-2.0,0.0),np.complex(0.0,-1.0)},np.complex64); local b=np.array({np.complex(1.0,2.0),np.complex(2.0,-1.0),np.complex(-2.0,1.0),np.complex(0.0,-2.0),np.complex(1.0,-1.0),np.complex(1.0,-2.0)},np.complex64); local r=np.dot(a,b); assert(close(r,np.complex(-9.0,-10.0),3e-05),'complex dot 777') end
do local a=np.array({np.complex(-2.0,-2.0),np.complex(0.0,1.0),np.complex(-2.0,-1.0),np.complex(0.0,2.0),np.complex(2.0,2.0),np.complex(2.0,-1.0)},np.complex128); local b=np.array({np.complex(2.0,-1.0),np.complex(0.0,0.0),np.complex(2.0,-1.0),np.complex(-2.0,1.0),np.complex(-2.0,0.0),np.complex(-2.0,1.0)},np.complex128); local r=np.dot(a,b); assert(close(r,np.complex(-20.0,-6.0),2e-12),'complex dot 778') end
do local a=np.array({np.complex(2.0,-1.0),np.complex(2.0,2.0)},np.complex64); local b=np.array({np.complex(0.0,-2.0),np.complex(-1.0,-1.0)},np.complex64); local r=np.dot(a,b); assert(close(r,np.complex(-2.0,-8.0),3e-05),'complex dot 779') end
do local a=np.array({np.complex(-1.0,-1.0),np.complex(0.0,1.0),np.complex(-2.0,0.0)},np.complex128); local b=np.array({np.complex(-2.0,-1.0),np.complex(1.0,0.0),np.complex(-1.0,-1.0)},np.complex128); local r=np.dot(a,b); assert(close(r,np.complex(3.0,6.0),2e-12),'complex dot 780') end
do local a=np.array({np.complex(-2.0,-1.0),np.complex(2.0,-2.0)},np.complex128); local b=np.array({np.complex(2.0,-2.0),np.complex(-2.0,-1.0)},np.complex128); local r=np.dot(a,b); assert(close(r,np.complex(-12.0,4.0),2e-12),'complex dot 781') end
do local a=np.array({np.complex(1.0,0.0),np.complex(1.0,-2.0),np.complex(-2.0,2.0)},np.complex128); local b=np.array({np.complex(0.0,-1.0),np.complex(-2.0,2.0),np.complex(1.0,2.0)},np.complex128); local r=np.dot(a,b); assert(close(r,np.complex(-4.0,3.0),2e-12),'complex dot 782') end
do local a=np.array({np.complex(-1.0,0.0),np.complex(-2.0,2.0),np.complex(-1.0,1.0),np.complex(2.0,1.0),np.complex(-2.0,0.0)},np.complex64); local b=np.array({np.complex(1.0,-2.0),np.complex(2.0,2.0),np.complex(-2.0,0.0),np.complex(-1.0,1.0),np.complex(2.0,-1.0)},np.complex64); local r=np.dot(a,b); assert(close(r,np.complex(-14.0,3.0),3e-05),'complex dot 783') end
do local a=np.array({np.complex(2.0,0.0),np.complex(-1.0,-1.0),np.complex(-2.0,-1.0),np.complex(-1.0,1.0),np.complex(0.0,0.0),np.complex(-2.0,0.0)},np.complex64); local b=np.array({np.complex(-2.0,0.0),np.complex(-2.0,0.0),np.complex(-2.0,1.0),np.complex(-2.0,-2.0),np.complex(-2.0,-1.0),np.complex(2.0,0.0)},np.complex64); local r=np.dot(a,b); assert(close(r,np.complex(3.0,2.0),3e-05),'complex dot 784') end
do local a=np.array({np.complex(0.0,-1.0),np.complex(1.0,-2.0),np.complex(-1.0,-2.0),np.complex(-1.0,2.0),np.complex(2.0,-2.0)},np.complex128); local b=np.array({np.complex(2.0,1.0),np.complex(2.0,-1.0),np.complex(-1.0,-2.0),np.complex(1.0,-1.0),np.complex(2.0,-1.0)},np.complex128); local r=np.dot(a,b); assert(close(r,np.complex(1.0,-6.0),2e-12),'complex dot 785') end
do local a=np.array({np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(2.0,-1.0)},np.complex128); local b=np.array({np.complex(0.0,-2.0),np.complex(2.0,-1.0),np.complex(2.0,0.0)},np.complex128); local r=np.dot(a,b); assert(close(r,np.complex(6.0,-3.0),2e-12),'complex dot 786') end
do local a=np.array({np.complex(-2.0,2.0),np.complex(-1.0,-2.0),np.complex(2.0,-1.0),np.complex(2.0,-1.0),np.complex(1.0,0.0),np.complex(0.0,-1.0),np.complex(-1.0,-2.0),np.complex(-2.0,2.0),np.complex(-2.0,0.0),np.complex(0.0,-2.0)},np.complex64); local b=np.array({np.complex(1.0,-1.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(1.0,1.0),np.complex(-2.0,1.0),np.complex(1.0,1.0),np.complex(0.0,2.0),np.complex(-2.0,-2.0),np.complex(2.0,-1.0),np.complex(1.0,2.0)},np.complex64); local r=np.dot(a,b); assert(close(r,np.complex(13.0,6.0),3e-05),'complex dot 787') end
do local a=np.array({np.complex(1.0,-2.0),np.complex(1.0,2.0),np.complex(-2.0,0.0),np.complex(1.0,-2.0),np.complex(2.0,-1.0),np.complex(1.0,1.0)},np.complex128); local b=np.array({np.complex(-2.0,-1.0),np.complex(-2.0,-2.0),np.complex(-2.0,1.0),np.complex(-1.0,-1.0),np.complex(-2.0,0.0),np.complex(-1.0,-1.0)},np.complex128); local r=np.dot(a,b); assert(close(r,np.complex(-5.0,-4.0),2e-12),'complex dot 788') end
do local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.0,-1.0),np.complex(1.0,1.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(0.0,-2.0)},np.complex128); local b=np.array({np.complex(1.0,0.0),np.complex(0.0,-2.0),np.complex(1.0,-2.0),np.complex(2.0,2.0),np.complex(-2.0,-1.0),np.complex(-1.0,-2.0),np.complex(1.0,0.0)},np.complex128); local r=np.dot(a,b); assert(close(r,np.complex(0.0,-2.0),2e-12),'complex dot 789') end
do local a=np.array({np.complex(2.0,-2.0),np.complex(-1.0,-2.0),np.complex(1.0,0.0),np.complex(1.0,-1.0),np.complex(2.0,2.0),np.complex(1.0,0.0),np.complex(2.0,-2.0)},np.complex64); local b=np.array({np.complex(-2.0,1.0),np.complex(-1.0,-1.0),np.complex(2.0,2.0),np.complex(1.0,-2.0),np.complex(0.0,1.0),np.complex(0.0,2.0),np.complex(2.0,-2.0)},np.complex64); local r=np.dot(a,b); assert(close(r,np.complex(-4.0,4.0),3e-05),'complex dot 790') end
do local a=np.array({np.complex(2.0,0.0),np.complex(-2.0,1.0),np.complex(-2.0,2.0),np.complex(-2.0,-2.0),np.complex(2.0,2.0),np.complex(-1.0,-2.0),np.complex(-2.0,-1.0),np.complex(-2.0,2.0),np.complex(1.0,-2.0),np.complex(2.0,2.0),np.complex(-1.0,-1.0),np.complex(-2.0,0.0)},np.complex64); local b=np.array({np.complex(2.0,-1.0),np.complex(2.0,2.0),np.complex(-2.0,0.0),np.complex(-1.0,-1.0),np.complex(-2.0,-2.0),np.complex(0.0,-2.0),np.complex(-2.0,-1.0),np.complex(2.0,1.0),np.complex(-1.0,1.0),np.complex(-2.0,1.0),np.complex(1.0,-2.0),np.complex(0.0,-1.0)},np.complex64); local r=np.dot(a,b); assert(close(r,np.complex(-13.0,0.0),3e-05),'complex dot 791') end
do local a=np.array({np.complex(1.0,-2.0),np.complex(-1.0,1.0),np.complex(2.0,-1.0)},np.complex128); local b=np.array({np.complex(1.0,-2.0),np.complex(0.0,1.0),np.complex(-2.0,-1.0)},np.complex128); local r=np.dot(a,b); assert(close(r,np.complex(-9.0,-5.0),2e-12),'complex dot 792') end
do local a=np.array({np.complex(-2.0,-2.0),np.complex(-1.0,-1.0),np.complex(-2.0,2.0),np.complex(-1.0,0.0),np.complex(-2.0,0.0)},np.complex128); local b=np.array({np.complex(1.0,-2.0),np.complex(-2.0,0.0),np.complex(2.0,0.0),np.complex(1.0,1.0),np.complex(2.0,-2.0)},np.complex128); local r=np.dot(a,b); assert(close(r,np.complex(-13.0,11.0),2e-12),'complex dot 793') end
do local a=np.array({np.complex(0.0,0.0),np.complex(0.0,-1.0),np.complex(-2.0,2.0)},np.complex64); local b=np.array({np.complex(0.0,-2.0),np.complex(-1.0,1.0),np.complex(1.0,2.0)},np.complex64); local r=np.dot(a,b); assert(close(r,np.complex(-5.0,-1.0),3e-05),'complex dot 794') end
do local a=np.array({np.complex(-2.0,2.0),np.complex(-2.0,-2.0),np.complex(0.0,1.0),np.complex(-1.0,-2.0)},np.complex64); local b=np.array({np.complex(1.0,-1.0),np.complex(-2.0,1.0),np.complex(2.0,-2.0),np.complex(2.0,1.0)},np.complex64); local r=np.dot(a,b); assert(close(r,np.complex(8.0,3.0),3e-05),'complex dot 795') end
do local a=np.array({np.complex(1.0,2.0),np.complex(2.0,1.0),np.complex(-1.0,-2.0),np.complex(0.0,2.0),np.complex(-2.0,-1.0),np.complex(2.0,2.0),np.complex(-1.0,-2.0),np.complex(-2.0,0.0),np.complex(0.0,1.0)},np.complex128); local b=np.array({np.complex(-2.0,-2.0),np.complex(-2.0,1.0),np.complex(1.0,-2.0),np.complex(1.0,0.0),np.complex(2.0,-1.0),np.complex(1.0,0.0),np.complex(-1.0,-1.0),np.complex(1.0,-2.0),np.complex(-2.0,-2.0)},np.complex128); local r=np.dot(a,b); assert(close(r,np.complex(-12.0,3.0),2e-12),'complex dot 796') end
do local a=np.array({np.complex(1.0,1.0),np.complex(2.0,1.0),np.complex(-1.0,1.0),np.complex(-1.0,0.0)},np.complex64); local b=np.array({np.complex(-1.0,-1.0),np.complex(-1.0,1.0),np.complex(-1.0,1.0),np.complex(0.0,0.0)},np.complex64); local r=np.dot(a,b); assert(close(r,np.complex(-3.0,-3.0),3e-05),'complex dot 797') end
do local a=np.array({np.complex(-1.0,0.0),np.complex(0.0,2.0),np.complex(-1.0,2.0),np.complex(-1.0,-1.0),np.complex(0.0,0.0),np.complex(0.0,2.0),np.complex(-1.0,-2.0)},np.complex64); local b=np.array({np.complex(-1.0,2.0),np.complex(1.0,1.0),np.complex(-2.0,0.0),np.complex(0.0,-2.0),np.complex(0.0,-1.0),np.complex(0.0,1.0),np.complex(-2.0,-1.0)},np.complex64); local r=np.dot(a,b); assert(close(r,np.complex(-3.0,3.0),3e-05),'complex dot 798') end
do local a=np.array({np.complex(2.0,-1.0),np.complex(1.0,-2.0),np.complex(2.0,0.0),np.complex(0.0,2.0),np.complex(1.0,0.0),np.complex(1.0,2.0)},np.complex64); local b=np.array({np.complex(-2.0,-2.0),np.complex(1.0,1.0),np.complex(0.0,2.0),np.complex(-1.0,-1.0),np.complex(1.0,2.0),np.complex(2.0,2.0)},np.complex64); local r=np.dot(a,b); assert(close(r,np.complex(-2.0,7.0),3e-05),'complex dot 799') end
do local a=np.array({np.complex(2.0,2.0),np.complex(-1.0,-2.0),np.complex(-1.0,-2.0),np.complex(-1.0,1.0),np.complex(1.0,2.0),np.complex(-2.0,1.0),np.complex(2.0,-2.0),np.complex(-2.0,-2.0),np.complex(0.0,1.0),np.complex(0.0,1.0),np.complex(-2.0,2.0),np.complex(-1.0,2.0)},np.complex64); local b=np.array({np.complex(-2.0,0.0),np.complex(-1.0,-1.0),np.complex(2.0,2.0),np.complex(-1.0,1.0),np.complex(1.0,-1.0),np.complex(-2.0,-1.0),np.complex(-1.0,1.0),np.complex(0.0,-2.0),np.complex(2.0,-2.0),np.complex(0.0,-1.0),np.complex(0.0,-2.0),np.complex(-2.0,2.0)},np.complex64); local r=np.dot(a,b); assert(close(r,np.complex(6.0,0.0),3e-05),'complex dot 800') end
do local a=np.array({np.complex(1.0,-1.0),np.complex(-1.0,2.0),np.complex(2.0,2.0),np.complex(-1.0,-2.0),np.complex(1.0,-1.0),np.complex(1.0,1.0),np.complex(-1.0,0.0),np.complex(0.0,0.0),np.complex(-2.0,-1.0),np.complex(1.0,-1.0),np.complex(-1.0,0.0),np.complex(-2.0,-1.0)},np.complex128); local b=np.array({np.complex(-2.0,-1.0),np.complex(-2.0,-1.0),np.complex(1.0,0.0),np.complex(1.0,-1.0),np.complex(-1.0,0.0),np.complex(0.0,2.0),np.complex(-1.0,1.0),np.complex(1.0,1.0),np.complex(0.0,-1.0),np.complex(0.0,1.0),np.complex(-2.0,1.0),np.complex(0.0,1.0)},np.complex128); local r=np.dot(a,b); assert(close(r,np.complex(1.0,1.0),2e-12),'complex dot 801') end
do local a=np.array({np.complex(-1.0,0.0),np.complex(0.0,-1.0),np.complex(1.0,2.0)},np.complex64); local b=np.array({np.complex(1.0,-2.0),np.complex(2.0,-1.0),np.complex(2.0,2.0)},np.complex64); local r=np.dot(a,b); assert(close(r,np.complex(-4.0,6.0),3e-05),'complex dot 802') end
do local a=np.array({np.complex(0.0,0.0),np.complex(2.0,0.0),np.complex(0.0,1.0),np.complex(0.0,-1.0),np.complex(1.0,0.0),np.complex(0.0,-2.0),np.complex(-2.0,2.0),np.complex(0.0,1.0),np.complex(-1.0,0.0),np.complex(0.0,0.0),np.complex(0.0,-1.0),np.complex(-1.0,-2.0)},np.complex128); local b=np.array({np.complex(-1.0,1.0),np.complex(0.0,2.0),np.complex(2.0,-1.0),np.complex(0.0,-2.0),np.complex(-2.0,-1.0),np.complex(1.0,2.0),np.complex(1.0,-2.0),np.complex(1.0,1.0),np.complex(0.0,2.0),np.complex(-2.0,-2.0),np.complex(2.0,-2.0),np.complex(0.0,1.0)},np.complex128); local r=np.dot(a,b); assert(close(r,np.complex(2.0,5.0),2e-12),'complex dot 803') end
do local a=np.array({np.complex(0.0,0.0),np.complex(-1.0,-2.0)},np.complex64); local b=np.array({np.complex(2.0,-2.0),np.complex(1.0,2.0)},np.complex64); local r=np.dot(a,b); assert(close(r,np.complex(3.0,-4.0),3e-05),'complex dot 804') end
do local a=np.array({np.complex(2.0,0.0),np.complex(2.0,-2.0),np.complex(-2.0,2.0),np.complex(-2.0,0.0),np.complex(1.0,1.0),np.complex(-1.0,-1.0),np.complex(0.0,0.0),np.complex(1.0,-1.0),np.complex(-2.0,-2.0),np.complex(-1.0,-1.0)},np.complex64); local b=np.array({np.complex(0.0,1.0),np.complex(2.0,-2.0),np.complex(-2.0,-1.0),np.complex(0.0,0.0),np.complex(0.0,-2.0),np.complex(-2.0,0.0),np.complex(1.0,-1.0),np.complex(2.0,0.0),np.complex(0.0,2.0),np.complex(0.0,-2.0)},np.complex64); local r=np.dot(a,b); assert(close(r,np.complex(14.0,-12.0),3e-05),'complex dot 805') end
do local a=np.array({np.complex(-2.0,1.0),np.complex(-2.0,-2.0),np.complex(2.0,2.0),np.complex(0.0,0.0),np.complex(1.0,2.0),np.complex(-2.0,0.0),np.complex(0.0,2.0),np.complex(0.0,2.0),np.complex(-1.0,-2.0),np.complex(-1.0,2.0)},np.complex64); local b=np.array({np.complex(0.0,-2.0),np.complex(0.0,2.0),np.complex(2.0,0.0),np.complex(-2.0,-1.0),np.complex(2.0,-2.0),np.complex(1.0,2.0),np.complex(2.0,-1.0),np.complex(2.0,0.0),np.complex(-2.0,0.0),np.complex(2.0,0.0)},np.complex64); local r=np.dot(a,b); assert(close(r,np.complex(16.0,18.0),3e-05),'complex dot 806') end
do local a=np.array({np.complex(-1.0,-2.0),np.complex(-2.0,2.0)},np.complex64); local b=np.array({np.complex(-1.0,1.0),np.complex(-1.0,2.0)},np.complex64); local r=np.dot(a,b); assert(close(r,np.complex(1.0,-5.0),3e-05),'complex dot 807') end
do local a=np.array({np.complex(2.0,-2.0),np.complex(-2.0,-1.0),np.complex(0.0,2.0)},np.complex128); local b=np.array({np.complex(1.0,-1.0),np.complex(-1.0,0.0),np.complex(-2.0,2.0)},np.complex128); local r=np.dot(a,b); assert(close(r,np.complex(-2.0,-7.0),2e-12),'complex dot 808') end
do local a=np.array({np.complex(0.0,0.0),np.complex(-2.0,0.0),np.complex(0.0,-2.0)},np.complex128); local b=np.array({np.complex(1.0,1.0),np.complex(-1.0,-1.0),np.complex(1.0,-1.0)},np.complex128); local r=np.dot(a,b); assert(close(r,np.complex(0.0,0.0),2e-12),'complex dot 809') end
do local a=np.array({np.complex(-1.0,1.0),np.complex(0.0,0.0),np.complex(1.0,2.0),np.complex(2.0,1.0),np.complex(1.0,2.0),np.complex(1.0,2.0)},np.complex64); local b=np.array({np.complex(-2.0,-2.0),np.complex(2.0,1.0),np.complex(1.0,0.0),np.complex(0.0,-2.0),np.complex(2.0,-1.0),np.complex(0.0,-2.0)},np.complex64); local r=np.dot(a,b); assert(close(r,np.complex(15.0,-1.0),3e-05),'complex dot 810') end
do local a=np.array({np.complex(2.0,-1.0),np.complex(1.0,-1.0),np.complex(2.0,0.0),np.complex(-2.0,0.0),np.complex(-2.0,-1.0),np.complex(2.0,0.0),np.complex(0.0,-1.0),np.complex(2.0,2.0)},np.complex128); local b=np.array({np.complex(2.0,0.0),np.complex(-1.0,0.0),np.complex(1.0,-2.0),np.complex(-2.0,-1.0),np.complex(1.0,-2.0),np.complex(1.0,0.0),np.complex(0.0,2.0),np.complex(-2.0,1.0)},np.complex128); local r=np.dot(a,b); assert(close(r,np.complex(3.0,-2.0),2e-12),'complex dot 811') end
do local a=np.array({{np.complex(-3.0,0.5),np.complex(-1.0,-3.0),np.complex(4.0,0.5)},{np.complex(2.0,0.5),np.complex(-2.0,-0.0),np.complex(-2.0,1.0)}},np.complex64); local b=np.array({{np.complex(4.0,-1.0),np.complex(0.25,1.0),np.complex(0.25,-1.0)},{np.complex(0.0,0.0),np.complex(-3.0,-0.0),np.complex(-1.0,-1.0)},{np.complex(-1.0,-3.0),np.complex(-0.0,3.0),np.complex(0.25,-0.0)},{np.complex(2.0,-1.0),np.complex(2.0,-0.0),np.complex(2.0,1.0)}},np.complex64); local r=np.inner(a,b); assert(close(r:tolist(),{{np.complex(-7.25,-0.625),np.complex(-0.5,4.5),np.complex(14.5,5.625),np.complex(0.0,3.0)},{np.complex(8.5,0.25),np.complex(9.0,1.0),np.complex(-1.0,-12.25),np.complex(-4.5,-1.0)}},3e-05),'complex inner 812') end
do local a=np.array({{np.complex(0.25,0.0),np.complex(-1.0,3.0),np.complex(-1.0,-3.0)},{np.complex(-3.0,1.0),np.complex(-0.0,0.0),np.complex(0.25,-1.0)}},np.complex64); local b=np.array({{np.complex(1.0,-1.0),np.complex(2.0,0.5),np.complex(-2.0,0.5)},{np.complex(0.25,0.0),np.complex(1.0,-1.0),np.complex(4.0,3.0)},{np.complex(-2.0,0.0),np.complex(-1.0,-1.0),np.complex(2.0,-1.0)},{np.complex(4.0,-3.0),np.complex(1.0,1.0),np.complex(1.0,-1.0)}},np.complex64); local r=np.inner(a,b); assert(close(r:tolist(),{{np.complex(0.25,10.75),np.complex(7.0625,-11.0),np.complex(-1.5,-7.0),np.complex(-7.0,-0.75)},{np.complex(-2.0,6.125),np.complex(3.25,-3.0),np.complex(5.5,-4.25),np.complex(-9.75,11.75)}},3e-05),'complex inner 813') end
do local a=np.array({{np.complex(-0.0,1.0),np.complex(4.0,1.0),np.complex(-1.0,-0.0)},{np.complex(1.0,1.0),np.complex(4.0,0.0),np.complex(0.25,3.0)}},np.complex128); local b=np.array({{np.complex(0.25,-1.0),np.complex(2.0,-0.0),np.complex(2.0,-1.0)},{np.complex(-1.0,-3.0),np.complex(0.0,1.0),np.complex(2.0,3.0)},{np.complex(0.0,-3.0),np.complex(-0.0,-1.0),np.complex(-3.0,1.0)},{np.complex(-3.0,-1.0),np.complex(-2.0,-3.0),np.complex(1.0,-3.0)}},np.complex128); local r=np.inner(a,b); assert(close(r:tolist(),{{np.complex(7.0,3.25),np.complex(0.0,0.0),np.complex(7.0,-5.0),np.complex(-5.0,-14.0)},{np.complex(12.75,5.0),np.complex(-6.5,6.75),np.complex(-0.75,-15.75),np.complex(-0.75,-13.75)}},2e-12),'complex inner 814') end
do local a=np.array({{np.complex(2.0,1.0),np.complex(1.0,-0.0),np.complex(1.0,-1.0)},{np.complex(-0.0,-3.0),np.complex(1.0,-0.0),np.complex(-3.0,3.0)}},np.complex64); local b=np.array({{np.complex(-1.0,-0.0),np.complex(-1.0,0.0),np.complex(-2.0,-0.0)},{np.complex(-3.0,-1.0),np.complex(1.0,3.0),np.complex(-2.0,-3.0)},{np.complex(0.25,1.0),np.complex(-0.0,-1.0),np.complex(-0.0,-0.0)},{np.complex(-1.0,-0.0),np.complex(-1.0,-0.0),np.complex(2.0,0.5)}},np.complex64); local r=np.inner(a,b); assert(close(r:tolist(),{{np.complex(-5.0,1.0),np.complex(-9.0,-3.0),np.complex(-0.5,1.25),np.complex(-0.5,-2.5)},{np.complex(5.0,-3.0),np.complex(13.0,15.0),np.complex(3.0,-1.75),np.complex(-8.5,7.5)}},3e-05),'complex inner 815') end
do local a=np.array({{np.complex(1.0,3.0),np.complex(0.0,-0.0),np.complex(-3.0,1.0)},{np.complex(-2.0,-1.0),np.complex(0.0,3.0),np.complex(-1.0,0.0)}},np.complex64); local b=np.array({{np.complex(2.0,0.5),np.complex(0.0,1.0),np.complex(0.0,0.0)},{np.complex(-3.0,-0.0),np.complex(-1.0,0.5),np.complex(-1.0,0.0)},{np.complex(1.0,-1.0),np.complex(4.0,3.0),np.complex(-0.0,3.0)},{np.complex(0.0,-3.0),np.complex(2.0,3.0),np.complex(-3.0,3.0)}},np.complex64); local r=np.inner(a,b); assert(close(r:tolist(),{{np.complex(0.5,6.5),np.complex(0.0,-10.0),np.complex(1.0,-7.0),np.complex(15.0,-15.0)},{np.complex(-6.5,-3.0),np.complex(5.5,0.0),np.complex(-12.0,10.0),np.complex(-9.0,9.0)}},3e-05),'complex inner 816') end
do local a=np.array({{np.complex(4.0,0.0),np.complex(1.0,0.0),np.complex(4.0,-0.0)},{np.complex(4.0,3.0),np.complex(2.0,3.0),np.complex(2.0,0.5)}},np.complex128); local b=np.array({{np.complex(0.0,-3.0),np.complex(4.0,0.0),np.complex(-2.0,-0.0)},{np.complex(-0.0,-1.0),np.complex(-1.0,-0.0),np.complex(-3.0,0.0)},{np.complex(-3.0,1.0),np.complex(4.0,-1.0),np.complex(0.0,-0.0)},{np.complex(2.0,0.5),np.complex(0.25,0.5),np.complex(-1.0,0.0)}},np.complex128); local r=np.inner(a,b); assert(close(r:tolist(),{{np.complex(-4.0,-12.0),np.complex(-13.0,-4.0),np.complex(-8.0,3.0),np.complex(4.25,2.5)},{np.complex(13.0,-1.0),np.complex(-5.0,-8.5),np.complex(-4.0,5.0),np.complex(3.5,9.25)}},2e-12),'complex inner 817') end
do local a=np.array({{np.complex(2.0,1.0),np.complex(-2.0,0.0),np.complex(-0.0,-3.0)},{np.complex(2.0,-0.0),np.complex(2.0,0.5),np.complex(0.25,3.0)}},np.complex128); local b=np.array({{np.complex(1.0,0.5),np.complex(1.0,0.5),np.complex(1.0,3.0)},{np.complex(-2.0,-3.0),np.complex(-1.0,-1.0),np.complex(-0.0,-0.0)},{np.complex(1.0,-0.0),np.complex(-3.0,0.0),np.complex(2.0,0.0)},{np.complex(2.0,-1.0),np.complex(4.0,-0.0),np.complex(1.0,-3.0)}},np.complex128); local r=np.inner(a,b); assert(close(r:tolist(),{{np.complex(8.5,-2.0),np.complex(1.0,-6.0),np.complex(8.0,-5.0),np.complex(-12.0,-3.0)},{np.complex(-5.0,6.25),np.complex(-5.5,-8.5),np.complex(-3.5,4.5),np.complex(21.25,2.25)}},2e-12),'complex inner 818') end
do local a=np.array({{np.complex(-2.0,-3.0),np.complex(-2.0,1.0),np.complex(0.25,-3.0)},{np.complex(4.0,-1.0),np.complex(2.0,-1.0),np.complex(4.0,-0.0)}},np.complex64); local b=np.array({{np.complex(4.0,0.5),np.complex(-2.0,1.0),np.complex(-0.0,-3.0)},{np.complex(1.0,-0.0),np.complex(-3.0,3.0),np.complex(-0.0,-0.0)},{np.complex(-3.0,-0.0),np.complex(-1.0,1.0),np.complex(0.25,0.5)},{np.complex(4.0,-3.0),np.complex(0.25,-3.0),np.complex(-0.0,0.0)}},np.complex64); local r=np.inner(a,b); assert(close(r:tolist(),{{np.complex(-12.5,-17.75),np.complex(1.0,-12.0),np.complex(8.5625,5.375),np.complex(-14.5,0.25)},{np.complex(13.5,-10.0),np.complex(1.0,8.0),np.complex(-12.0,8.0),np.complex(10.5,-22.25)}},3e-05),'complex inner 819') end
do local a=np.array({{np.complex(2.0,0.0),np.complex(-0.0,-1.0),np.complex(0.0,-3.0)},{np.complex(0.0,-3.0),np.complex(2.0,1.0),np.complex(0.0,-0.0)}},np.complex64); local b=np.array({{np.complex(-1.0,0.0),np.complex(4.0,-3.0),np.complex(-1.0,-1.0)},{np.complex(-0.0,-3.0),np.complex(4.0,-1.0),np.complex(-1.0,-0.0)},{np.complex(1.0,-0.0),np.complex(1.0,0.0),np.complex(1.0,-0.0)},{np.complex(4.0,-3.0),np.complex(-2.0,3.0),np.complex(-0.0,-3.0)}},np.complex64); local r=np.inner(a,b); assert(close(r:tolist(),{{np.complex(-8.0,-1.0),np.complex(-1.0,-7.0),np.complex(2.0,-4.0),np.complex(2.0,-4.0)},{np.complex(11.0,1.0),np.complex(-0.0,2.0),np.complex(2.0,-2.0),np.complex(-16.0,-8.0)}},3e-05),'complex inner 820') end
do local a=np.array({{np.complex(-2.0,0.5),np.complex(4.0,1.0),np.complex(-2.0,0.0)},{np.complex(1.0,0.5),np.complex(-3.0,0.0),np.complex(1.0,-3.0)}},np.complex64); local b=np.array({{np.complex(1.0,-3.0),np.complex(4.0,3.0),np.complex(1.0,0.0)},{np.complex(0.0,0.0),np.complex(-0.0,-1.0),np.complex(0.25,-1.0)},{np.complex(1.0,-0.0),np.complex(0.0,-1.0),np.complex(-0.0,1.0)},{np.complex(-2.0,0.0),np.complex(4.0,0.5),np.complex(0.25,-0.0)}},np.complex64); local r=np.inner(a,b); assert(close(r:tolist(),{{np.complex(10.5,22.5),np.complex(0.5,-2.0),np.complex(-1.0,-5.5),np.complex(19.0,5.0)},{np.complex(-8.5,-14.5),np.complex(-2.75,1.25),np.complex(4.0,4.5),np.complex(-13.75,-3.25)}},3e-05),'complex inner 821') end
do local a=np.array({{np.complex(-0.0,1.0),np.complex(-0.0,-0.0),np.complex(2.0,-3.0)},{np.complex(0.25,-0.0),np.complex(-3.0,-3.0),np.complex(4.0,-1.0)}},np.complex64); local b=np.array({{np.complex(2.0,0.0),np.complex(4.0,-1.0),np.complex(0.25,0.5)},{np.complex(-1.0,3.0),np.complex(-2.0,3.0),np.complex(-1.0,-1.0)},{np.complex(1.0,0.5),np.complex(-0.0,0.0),np.complex(-0.0,3.0)},{np.complex(4.0,1.0),np.complex(2.0,0.0),np.complex(4.0,0.5)}},np.complex64); local r=np.inner(a,b); assert(close(r:tolist(),{{np.complex(2.0,2.25),np.complex(-8.0,0.0),np.complex(8.5,7.0),np.complex(8.5,-7.0)},{np.complex(-13.0,-7.25),np.complex(9.75,-5.25),np.complex(3.25,12.125),np.complex(11.5,-7.75)}},3e-05),'complex inner 822') end
do local a=np.array({{np.complex(4.0,0.0),np.complex(-3.0,1.0),np.complex(4.0,0.5)},{np.complex(1.0,-3.0),np.complex(-1.0,-1.0),np.complex(4.0,0.5)}},np.complex128); local b=np.array({{np.complex(0.25,1.0),np.complex(2.0,0.5),np.complex(0.25,-1.0)},{np.complex(-1.0,0.5),np.complex(-2.0,3.0),np.complex(-1.0,1.0)},{np.complex(-2.0,0.0),np.complex(2.0,-3.0),np.complex(4.0,-3.0)},{np.complex(1.0,-0.0),np.complex(-1.0,1.0),np.complex(0.25,0.0)}},np.complex128); local r=np.inner(a,b); assert(close(r:tolist(),{{np.complex(-4.0,0.625),np.complex(-5.5,-5.5),np.complex(6.5,1.0),np.complex(7.0,-3.875)},{np.complex(3.25,-6.125),np.complex(1.0,6.0),np.complex(10.5,-3.0),np.complex(4.0,-2.875)}},2e-12),'complex inner 823') end
do local a=np.array({{np.complex(-3.0,0.0),np.complex(1.0,-0.0),np.complex(0.25,0.5)},{np.complex(4.0,-0.0),np.complex(0.25,1.0),np.complex(-1.0,-0.0)}},np.complex64); local b=np.array({{np.complex(0.0,3.0),np.complex(-3.0,-0.0),np.complex(0.0,1.0)},{np.complex(-3.0,-3.0),np.complex(-1.0,-0.0),np.complex(0.0,-3.0)},{np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(2.0,-3.0)},{np.complex(-1.0,3.0),np.complex(4.0,-0.0),np.complex(-1.0,-3.0)}},np.complex64); local r=np.inner(a,b); assert(close(r:tolist(),{{np.complex(-3.5,-8.75),np.complex(9.5,8.25),np.complex(2.0,0.25),np.complex(8.25,-10.25)},{np.complex(-0.75,8.0),np.complex(-12.25,-10.0),np.complex(-2.0,3.0),np.complex(-2.0,19.0)}},3e-05),'complex inner 824') end
do local a=np.array({{np.complex(2.0,-0.0),np.complex(1.0,1.0),np.complex(0.0,0.0)},{np.complex(0.25,1.0),np.complex(2.0,3.0),np.complex(0.25,0.5)}},np.complex128); local b=np.array({{np.complex(-1.0,0.5),np.complex(0.0,3.0),np.complex(-1.0,1.0)},{np.complex(-3.0,-3.0),np.complex(2.0,1.0),np.complex(4.0,-0.0)},{np.complex(0.0,-3.0),np.complex(-2.0,3.0),np.complex(0.25,-0.0)},{np.complex(-2.0,0.5),np.complex(0.0,3.0),np.complex(1.0,-0.0)}},np.complex128); local r=np.inner(a,b); assert(close(r:tolist(),{{np.complex(-5.0,4.0),np.complex(-5.0,-3.0),np.complex(-5.0,-5.0),np.complex(-7.0,4.0)},{np.complex(-10.5,4.875),np.complex(4.25,6.25),np.complex(-9.9375,-0.625),np.complex(-9.75,4.625)}},2e-12),'complex inner 825') end
do local a=np.array({{np.complex(-1.0,0.5),np.complex(0.25,-1.0),np.complex(2.0,0.5)},{np.complex(-0.0,-0.0),np.complex(0.0,1.0),np.complex(0.25,0.5)}},np.complex128); local b=np.array({{np.complex(-2.0,0.0),np.complex(4.0,1.0),np.complex(2.0,3.0)},{np.complex(2.0,3.0),np.complex(4.0,1.0),np.complex(-1.0,-3.0)},{np.complex(4.0,-0.0),np.complex(1.0,3.0),np.complex(2.0,1.0)},{np.complex(1.0,0.5),np.complex(-0.0,1.0),np.complex(-2.0,3.0)}},np.complex128); local r=np.inner(a,b); assert(close(r:tolist(),{{np.complex(6.5,2.25),np.complex(-2.0,-12.25),np.complex(2.75,4.75),np.complex(-5.75,5.25)},{np.complex(-2.0,5.75),np.complex(0.25,2.75),np.complex(-3.0,2.25),np.complex(-3.0,-0.25)}},2e-12),'complex inner 826') end
do local a=np.array({{np.complex(-0.0,1.0),np.complex(0.0,-1.0),np.complex(2.0,3.0)},{np.complex(-2.0,0.5),np.complex(4.0,3.0),np.complex(2.0,-1.0)}},np.complex128); local b=np.array({{np.complex(0.0,1.0),np.complex(-1.0,-0.0),np.complex(2.0,-0.0)},{np.complex(-3.0,-0.0),np.complex(0.25,-3.0),np.complex(-1.0,-0.0)},{np.complex(2.0,1.0),np.complex(0.0,-3.0),np.complex(0.0,-1.0)},{np.complex(-2.0,-1.0),np.complex(-3.0,0.5),np.complex(0.25,1.0)}},np.complex128); local r=np.inner(a,b); assert(close(r:tolist(),{{np.complex(3.0,7.0),np.complex(-5.0,-6.25),np.complex(-1.0,0.0),np.complex(-1.0,3.75)},{np.complex(-0.5,-7.0),np.complex(14.0,-11.75),np.complex(3.5,-15.0),np.complex(-7.5,-4.25)}},2e-12),'complex inner 827') end
do local a=np.array({{np.complex(-1.0,0.0),np.complex(1.0,-1.0),np.complex(0.0,0.0)},{np.complex(-0.0,-3.0),np.complex(2.0,-1.0),np.complex(0.25,-0.0)}},np.complex64); local b=np.array({{np.complex(-3.0,0.5),np.complex(-2.0,-0.0),np.complex(-1.0,-0.0)},{np.complex(-2.0,1.0),np.complex(-2.0,1.0),np.complex(-1.0,0.0)},{np.complex(-1.0,3.0),np.complex(0.25,-1.0),np.complex(-2.0,-0.0)},{np.complex(0.0,1.0),np.complex(-3.0,3.0),np.complex(-2.0,1.0)}},np.complex64); local r=np.inner(a,b); assert(close(r:tolist(),{{np.complex(1.0,1.5),np.complex(1.0,2.0),np.complex(0.25,-4.25),np.complex(-0.0,5.0)},{np.complex(-2.75,11.0),np.complex(-0.25,10.0),np.complex(8.0,0.75),np.complex(-0.5,9.25)}},3e-05),'complex inner 828') end
do local a=np.array({{np.complex(4.0,0.5),np.complex(-0.0,-3.0),np.complex(0.25,0.5)},{np.complex(0.25,-0.0),np.complex(1.0,-3.0),np.complex(-0.0,0.0)}},np.complex128); local b=np.array({{np.complex(-3.0,0.5),np.complex(4.0,0.5),np.complex(-1.0,-1.0)},{np.complex(2.0,-1.0),np.complex(-3.0,3.0),np.complex(-1.0,0.0)},{np.complex(0.0,0.5),np.complex(-1.0,-3.0),np.complex(-2.0,0.0)},{np.complex(2.0,3.0),np.complex(1.0,3.0),np.complex(-2.0,0.5)}},np.complex128); local r=np.inner(a,b); assert(close(r:tolist(),{{np.complex(-10.5,-12.25),np.complex(17.25,5.5),np.complex(-9.75,4.0),np.complex(14.75,9.125)},{np.complex(4.75,-11.375),np.complex(6.5,11.75),np.complex(-10.0,0.125),np.complex(10.5,0.75)}},2e-12),'complex inner 829') end
do local a=np.array({{np.complex(4.0,0.0),np.complex(0.0,-1.0),np.complex(-0.0,-0.0)},{np.complex(2.0,3.0),np.complex(2.0,0.5),np.complex(-1.0,0.0)}},np.complex128); local b=np.array({{np.complex(2.0,-0.0),np.complex(0.25,1.0),np.complex(1.0,3.0)},{np.complex(-0.0,-1.0),np.complex(4.0,-0.0),np.complex(-3.0,1.0)},{np.complex(-1.0,-1.0),np.complex(-3.0,-1.0),np.complex(4.0,1.0)},{np.complex(0.25,0.5),np.complex(1.0,0.0),np.complex(-3.0,-1.0)}},np.complex128); local r=np.inner(a,b); assert(close(r:tolist(),{{np.complex(9.0,-0.25),np.complex(0.0,-8.0),np.complex(-5.0,-1.0),np.complex(1.0,1.0)},{np.complex(3.0,5.125),np.complex(14.0,-1.0),np.complex(-8.5,-9.5),np.complex(4.0,3.25)}},2e-12),'complex inner 830') end
do local a=np.array({{np.complex(1.0,-1.0),np.complex(-2.0,-3.0),np.complex(0.0,1.0)},{np.complex(1.0,0.0),np.complex(-0.0,-0.0),np.complex(-2.0,-1.0)}},np.complex64); local b=np.array({{np.complex(2.0,0.0),np.complex(4.0,-0.0),np.complex(-3.0,-1.0)},{np.complex(0.0,1.0),np.complex(2.0,-3.0),np.complex(-2.0,3.0)},{np.complex(2.0,1.0),np.complex(-3.0,1.0),np.complex(-3.0,-0.0)},{np.complex(-3.0,0.0),np.complex(-2.0,-1.0),np.complex(-3.0,-1.0)}},np.complex64); local r=np.inner(a,b); assert(close(r:tolist(),{{np.complex(-5.0,-17.0),np.complex(-15.0,-1.0),np.complex(12.0,3.0),np.complex(-1.0,8.0)},{np.complex(7.0,5.0),np.complex(7.0,-3.0),np.complex(8.0,4.0),np.complex(2.0,5.0)}},3e-05),'complex inner 831') end
do local a=np.array({np.complex(1.0,-0.0),np.complex(-2.0,0.5),np.complex(-1.0,0.0),np.complex(0.25,-1.0)},np.complex64); local b=np.array({np.complex(2.0,3.0),np.complex(-3.0,1.0),np.complex(2.0,3.0)},np.complex64); local r=np.outer(a,b); assert(close(r:tolist(),{{np.complex(2.0,3.0),np.complex(-3.0,1.0),np.complex(2.0,3.0)},{np.complex(-5.5,-5.0),np.complex(5.5,-3.5),np.complex(-5.5,-5.0)},{np.complex(-2.0,-3.0),np.complex(3.0,-1.0),np.complex(-2.0,-3.0)},{np.complex(3.5,-1.25),np.complex(0.25,3.25),np.complex(3.5,-1.25)}},3e-05),'complex outer 832') end
do local a=np.array({np.complex(0.0,-1.0),np.complex(2.0,1.0),np.complex(0.0,-3.0),np.complex(-0.0,1.0)},np.complex128); local b=np.array({np.complex(-0.0,3.0),np.complex(-0.0,0.5),np.complex(2.0,-3.0)},np.complex128); local r=np.outer(a,b); assert(close(r:tolist(),{{np.complex(3.0,0.0),np.complex(0.5,0.0),np.complex(-3.0,-2.0)},{np.complex(-3.0,6.0),np.complex(-0.5,1.0),np.complex(7.0,-4.0)},{np.complex(9.0,0.0),np.complex(1.5,0.0),np.complex(-9.0,-6.0)},{np.complex(-3.0,-0.0),np.complex(-0.5,-0.0),np.complex(3.0,2.0)}},2e-12),'complex outer 833') end
do local a=np.array({np.complex(0.25,-1.0),np.complex(1.0,0.5),np.complex(4.0,1.0),np.complex(-2.0,-0.0)},np.complex128); local b=np.array({np.complex(-3.0,1.0),np.complex(1.0,3.0),np.complex(-3.0,-1.0)},np.complex128); local r=np.outer(a,b); assert(close(r:tolist(),{{np.complex(0.25,3.25),np.complex(3.25,-0.25),np.complex(-1.75,2.75)},{np.complex(-3.5,-0.5),np.complex(-0.5,3.5),np.complex(-2.5,-2.5)},{np.complex(-13.0,1.0),np.complex(1.0,13.0),np.complex(-11.0,-7.0)},{np.complex(6.0,-2.0),np.complex(-2.0,-6.0),np.complex(6.0,2.0)}},2e-12),'complex outer 834') end
do local a=np.array({np.complex(-1.0,0.5),np.complex(-1.0,0.0),np.complex(-0.0,-0.0),np.complex(-3.0,0.5)},np.complex64); local b=np.array({np.complex(4.0,-1.0),np.complex(1.0,1.0),np.complex(0.25,1.0)},np.complex64); local r=np.outer(a,b); assert(close(r:tolist(),{{np.complex(-3.5,3.0),np.complex(-1.5,-0.5),np.complex(-0.75,-0.875)},{np.complex(-4.0,1.0),np.complex(-1.0,-1.0),np.complex(-0.25,-1.0)},{np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(0.0,-0.0)},{np.complex(-11.5,5.0),np.complex(-3.5,-2.5),np.complex(-1.25,-2.875)}},3e-05),'complex outer 835') end
do local a=np.array({np.complex(2.0,1.0),np.complex(-1.0,-0.0),np.complex(-1.0,3.0),np.complex(2.0,-1.0)},np.complex128); local b=np.array({np.complex(-1.0,0.5),np.complex(-2.0,0.0),np.complex(-3.0,-3.0)},np.complex128); local r=np.outer(a,b); assert(close(r:tolist(),{{np.complex(-2.5,0.0),np.complex(-4.0,-2.0),np.complex(-3.0,-9.0)},{np.complex(1.0,-0.5),np.complex(2.0,0.0),np.complex(3.0,3.0)},{np.complex(-0.5,-3.5),np.complex(2.0,-6.0),np.complex(12.0,-6.0)},{np.complex(-1.5,2.0),np.complex(-4.0,2.0),np.complex(-9.0,-3.0)}},2e-12),'complex outer 836') end
do local a=np.array({np.complex(1.0,0.0),np.complex(-0.0,3.0),np.complex(-3.0,3.0),np.complex(-1.0,-1.0)},np.complex128); local b=np.array({np.complex(4.0,-1.0),np.complex(1.0,1.0),np.complex(1.0,3.0)},np.complex128); local r=np.outer(a,b); assert(close(r:tolist(),{{np.complex(4.0,-1.0),np.complex(1.0,1.0),np.complex(1.0,3.0)},{np.complex(3.0,12.0),np.complex(-3.0,3.0),np.complex(-9.0,3.0)},{np.complex(-9.0,15.0),np.complex(-6.0,0.0),np.complex(-12.0,-6.0)},{np.complex(-5.0,-3.0),np.complex(0.0,-2.0),np.complex(2.0,-4.0)}},2e-12),'complex outer 837') end
do local a=np.array({np.complex(-3.0,3.0),np.complex(-3.0,1.0),np.complex(-2.0,-1.0),np.complex(0.25,3.0)},np.complex64); local b=np.array({np.complex(4.0,-0.0),np.complex(-0.0,1.0),np.complex(0.0,0.0)},np.complex64); local r=np.outer(a,b); assert(close(r:tolist(),{{np.complex(-12.0,12.0),np.complex(-3.0,-3.0),np.complex(-0.0,0.0)},{np.complex(-12.0,4.0),np.complex(-1.0,-3.0),np.complex(-0.0,0.0)},{np.complex(-8.0,-4.0),np.complex(1.0,-2.0),np.complex(0.0,-0.0)},{np.complex(1.0,12.0),np.complex(-3.0,0.25),np.complex(0.0,0.0)}},3e-05),'complex outer 838') end
do local a=np.array({np.complex(0.0,0.0),np.complex(0.25,0.0),np.complex(-0.0,-0.0),np.complex(-0.0,0.5)},np.complex128); local b=np.array({np.complex(1.0,0.0),np.complex(-1.0,0.5),np.complex(-2.0,3.0)},np.complex128); local r=np.outer(a,b); assert(close(r:tolist(),{{np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(-0.0,0.0)},{np.complex(0.25,0.0),np.complex(-0.25,0.125),np.complex(-0.5,0.75)},{np.complex(0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,0.0)},{np.complex(-0.0,0.5),np.complex(-0.25,-0.5),np.complex(-1.5,-1.0)}},2e-12),'complex outer 839') end
do local a=np.array({np.complex(0.25,0.0),np.complex(-3.0,1.0),np.complex(0.0,0.5),np.complex(-3.0,1.0)},np.complex64); local b=np.array({np.complex(1.0,-1.0),np.complex(-1.0,-3.0),np.complex(-0.0,1.0)},np.complex64); local r=np.outer(a,b); assert(close(r:tolist(),{{np.complex(0.25,-0.25),np.complex(-0.25,-0.75),np.complex(-0.0,0.25)},{np.complex(-2.0,4.0),np.complex(6.0,8.0),np.complex(-1.0,-3.0)},{np.complex(0.5,0.5),np.complex(1.5,-0.5),np.complex(-0.5,0.0)},{np.complex(-2.0,4.0),np.complex(6.0,8.0),np.complex(-1.0,-3.0)}},3e-05),'complex outer 840') end
do local a=np.array({np.complex(0.0,3.0),np.complex(-1.0,0.0),np.complex(1.0,0.5),np.complex(-0.0,1.0)},np.complex128); local b=np.array({np.complex(0.0,1.0),np.complex(0.0,0.5),np.complex(4.0,3.0)},np.complex128); local r=np.outer(a,b); assert(close(r:tolist(),{{np.complex(-3.0,0.0),np.complex(-1.5,0.0),np.complex(-9.0,12.0)},{np.complex(-0.0,-1.0),np.complex(-0.0,-0.5),np.complex(-4.0,-3.0)},{np.complex(-0.5,1.0),np.complex(-0.25,0.5),np.complex(2.5,5.0)},{np.complex(-1.0,0.0),np.complex(-0.5,0.0),np.complex(-3.0,4.0)}},2e-12),'complex outer 841') end
do local a=np.array({np.complex(-3.0,1.0),np.complex(0.25,-1.0),np.complex(2.0,-3.0),np.complex(0.0,1.0)},np.complex64); local b=np.array({np.complex(0.0,0.5),np.complex(4.0,3.0),np.complex(-2.0,0.0)},np.complex64); local r=np.outer(a,b); assert(close(r:tolist(),{{np.complex(-0.5,-1.5),np.complex(-15.0,-5.0),np.complex(6.0,-2.0)},{np.complex(0.5,0.125),np.complex(4.0,-3.25),np.complex(-0.5,2.0)},{np.complex(1.5,1.0),np.complex(17.0,-6.0),np.complex(-4.0,6.0)},{np.complex(-0.5,0.0),np.complex(-3.0,4.0),np.complex(-0.0,-2.0)}},3e-05),'complex outer 842') end
do local a=np.array({np.complex(0.25,-0.0),np.complex(0.0,-3.0),np.complex(0.0,-3.0),np.complex(-2.0,0.0)},np.complex128); local b=np.array({np.complex(0.25,3.0),np.complex(-0.0,0.5),np.complex(4.0,1.0)},np.complex128); local r=np.outer(a,b); assert(close(r:tolist(),{{np.complex(0.0625,0.75),np.complex(0.0,0.125),np.complex(1.0,0.25)},{np.complex(9.0,-0.75),np.complex(1.5,0.0),np.complex(3.0,-12.0)},{np.complex(9.0,-0.75),np.complex(1.5,0.0),np.complex(3.0,-12.0)},{np.complex(-0.5,-6.0),np.complex(0.0,-1.0),np.complex(-8.0,-2.0)}},2e-12),'complex outer 843') end
do local a=np.array({np.complex(-0.0,0.5),np.complex(-1.0,3.0),np.complex(0.0,-0.0),np.complex(0.0,1.0)},np.complex64); local b=np.array({np.complex(0.0,0.5),np.complex(-0.0,1.0),np.complex(0.25,-3.0)},np.complex64); local r=np.outer(a,b); assert(close(r:tolist(),{{np.complex(-0.25,0.0),np.complex(-0.5,-0.0),np.complex(1.5,0.125)},{np.complex(-1.5,-0.5),np.complex(-3.0,-1.0),np.complex(8.75,3.75)},{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0)},{np.complex(-0.5,0.0),np.complex(-1.0,0.0),np.complex(3.0,0.25)}},3e-05),'complex outer 844') end
do local a=np.array({np.complex(-3.0,3.0),np.complex(-0.0,0.0),np.complex(4.0,1.0),np.complex(0.0,-1.0)},np.complex128); local b=np.array({np.complex(0.0,3.0),np.complex(-0.0,-0.0),np.complex(-1.0,0.5)},np.complex128); local r=np.outer(a,b); assert(close(r:tolist(),{{np.complex(-9.0,-9.0),np.complex(0.0,0.0),np.complex(1.5,-4.5)},{np.complex(-0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0)},{np.complex(-3.0,12.0),np.complex(0.0,-0.0),np.complex(-4.5,1.0)},{np.complex(3.0,0.0),np.complex(-0.0,0.0),np.complex(0.5,1.0)}},2e-12),'complex outer 845') end
do local a=np.array({np.complex(-3.0,-1.0),np.complex(0.0,-0.0),np.complex(-3.0,-1.0),np.complex(-3.0,-1.0)},np.complex128); local b=np.array({np.complex(0.0,-0.0),np.complex(-0.0,-3.0),np.complex(-1.0,-0.0)},np.complex128); local r=np.outer(a,b); assert(close(r:tolist(),{{np.complex(-0.0,0.0),np.complex(-3.0,9.0),np.complex(3.0,1.0)},{np.complex(0.0,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,0.0)},{np.complex(-0.0,0.0),np.complex(-3.0,9.0),np.complex(3.0,1.0)},{np.complex(-0.0,0.0),np.complex(-3.0,9.0),np.complex(3.0,1.0)}},2e-12),'complex outer 846') end
do local a=np.array({np.complex(0.0,-3.0),np.complex(4.0,3.0),np.complex(-4.0,2.0),np.complex((0/0),2.0),np.complex(3.0,-4.0),np.complex(-3.0,-2.0),np.complex(-5.0,-5.0),np.complex(1.0,4.0),np.complex(-2.0,5.0),np.complex(2.0,0.0),np.complex(5.0,-1.0)},np.complex128); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex((0/0),2.0)},2e-12),'complex sort 847'); local q=np.argsort(a); assert(exact(q:tolist(),{7,3,6,9,1,8,10,5,2,11,4}),'complex argsort 847') end
do local a=np.array({np.complex(1.0,4.0),np.complex(-3.0,-2.0),np.complex(0.0,-3.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(2.0,0.0),np.complex(-1.0,1.0),np.complex(-5.0,-5.0),np.complex(-2.0,5.0),np.complex(-4.0,2.0),np.complex(3.0,-4.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},3e-05),'complex sort 848'); local q=np.argsort(a); assert(exact(q:tolist(),{8,10,2,9,7,3,1,6,11,4,5}),'complex argsort 848') end
do local a=np.array({np.complex(-4.0,2.0),np.complex(1.0,4.0),np.complex(-5.0,-5.0),np.complex(2.0,0.0),np.complex(0.0,-3.0),np.complex(5.0,-1.0),np.complex(3.0,-4.0),np.complex(-3.0,-2.0),np.complex(4.0,3.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},3e-05),'complex sort 849'); local q=np.argsort(a); assert(exact(q:tolist(),{3,1,8,10,11,5,2,4,7,9,6}),'complex argsort 849') end
do local a=np.array({np.complex(0.0,-3.0),np.complex(-1.0,1.0),np.complex(3.0,-4.0),np.complex(1.0,4.0),np.complex(-2.0,5.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(-5.0,-5.0),np.complex(2.0,0.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},3e-05),'complex sort 850'); local q=np.argsort(a); assert(exact(q:tolist(),{8,10,11,5,2,1,4,9,3,6,7}),'complex argsort 850') end
do local a=np.array({np.complex(4.0,3.0),np.complex(-3.0,-2.0),np.complex(5.0,-1.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(-5.0,-5.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(-4.0,2.0),np.complex(1.0,4.0),np.complex(0.0,-3.0)},np.complex128); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},2e-12),'complex sort 851'); local q=np.argsort(a); assert(exact(q:tolist(),{6,9,2,7,8,11,10,4,5,1,3}),'complex argsort 851') end
do local a=np.array({np.complex(-2.0,5.0),np.complex(-3.0,-2.0),np.complex(5.0,-1.0),np.complex((0/0),2.0),np.complex(4.0,3.0),np.complex(1.0,4.0),np.complex(3.0,-4.0),np.complex(2.0,0.0),np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(0.0,-3.0)},np.complex128); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex((0/0),2.0)},2e-12),'complex sort 852'); local q=np.argsort(a); assert(exact(q:tolist(),{9,10,2,1,11,6,8,7,5,3,4}),'complex argsort 852') end
do local a=np.array({np.complex(4.0,3.0),np.complex(3.0,-4.0),np.complex(-3.0,-2.0),np.complex(5.0,-1.0),np.complex(-5.0,-5.0),np.complex(1.0,4.0),np.complex(-2.0,5.0),np.complex(2.0,0.0),np.complex(-4.0,2.0),np.complex(0.0,-3.0),np.complex(-1.0,1.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},3e-05),'complex sort 853'); local q=np.argsort(a); assert(exact(q:tolist(),{5,9,3,7,11,10,6,8,2,1,4}),'complex argsort 853') end
do local a=np.array({np.complex(-3.0,-2.0),np.complex(-4.0,2.0),np.complex(4.0,3.0),np.complex(0.0,-3.0),np.complex(5.0,-1.0),np.complex(1.0,4.0),np.complex(-5.0,-5.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(-1.0,1.0),np.complex(-2.0,5.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},3e-05),'complex sort 854'); local q=np.argsort(a); assert(exact(q:tolist(),{7,2,1,11,10,4,6,8,9,3,5}),'complex argsort 854') end
do local a=np.array({np.complex(0.0,-3.0),np.complex(4.0,3.0),np.complex(-3.0,-2.0),np.complex(1.0,4.0),np.complex(-1.0,1.0),np.complex(3.0,-4.0),np.complex(2.0,0.0),np.complex(-4.0,2.0),np.complex(-2.0,5.0),np.complex(-5.0,-5.0),np.complex(5.0,-1.0)},np.complex128); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},2e-12),'complex sort 855'); local q=np.argsort(a); assert(exact(q:tolist(),{10,8,3,9,5,1,4,7,6,2,11}),'complex argsort 855') end
do local a=np.array({np.complex(2.0,0.0),np.complex(-4.0,2.0),np.complex(-5.0,-5.0),np.complex(5.0,-1.0),np.complex(0.0,-3.0),np.complex(-1.0,1.0),np.complex(4.0,3.0),np.complex(3.0,-4.0),np.complex(1.0,4.0),np.complex(-2.0,5.0),np.complex(-3.0,-2.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},3e-05),'complex sort 856'); local q=np.argsort(a); assert(exact(q:tolist(),{3,2,11,10,6,5,9,1,8,7,4}),'complex argsort 856') end
do local a=np.array({np.complex(1.0,4.0),np.complex(-4.0,2.0),np.complex(5.0,-1.0),np.complex((0/0),2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(4.0,3.0),np.complex(-5.0,-5.0),np.complex(-1.0,1.0),np.complex(3.0,-4.0),np.complex(2.0,0.0)},np.complex128); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex((0/0),2.0)},2e-12),'complex sort 857'); local q=np.argsort(a); assert(exact(q:tolist(),{8,2,5,6,9,1,11,10,7,3,4}),'complex argsort 857') end
do local a=np.array({np.complex(-3.0,-2.0),np.complex(3.0,-4.0),np.complex(-5.0,-5.0),np.complex(0.0,-3.0),np.complex(4.0,3.0),np.complex(-4.0,2.0),np.complex(-1.0,1.0),np.complex(5.0,-1.0),np.complex(-2.0,5.0),np.complex(2.0,0.0),np.complex(1.0,4.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},3e-05),'complex sort 858'); local q=np.argsort(a); assert(exact(q:tolist(),{3,6,1,9,7,4,11,10,2,5,8}),'complex argsort 858') end
do local a=np.array({np.complex(3.0,-4.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(-3.0,-2.0),np.complex(2.0,0.0),np.complex(0.0,-3.0),np.complex(4.0,3.0),np.complex(-5.0,-5.0),np.complex(5.0,-1.0),np.complex(1.0,4.0),np.complex(-4.0,2.0)},np.complex128); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},2e-12),'complex sort 859'); local q=np.argsort(a); assert(exact(q:tolist(),{8,11,4,2,3,6,10,5,1,7,9}),'complex argsort 859') end
do local a=np.array({np.complex(1.0,4.0),np.complex(-4.0,2.0),np.complex(4.0,3.0),np.complex(3.0,-4.0),np.complex(-1.0,1.0),np.complex(5.0,-1.0),np.complex(0.0,-3.0),np.complex(2.0,0.0),np.complex(-5.0,-5.0),np.complex(-2.0,5.0),np.complex(-3.0,-2.0)},np.complex128); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},2e-12),'complex sort 860'); local q=np.argsort(a); assert(exact(q:tolist(),{9,2,11,10,5,7,1,8,4,3,6}),'complex argsort 860') end
do local a=np.array({np.complex(0.0,-3.0),np.complex(-3.0,-2.0),np.complex(5.0,-1.0),np.complex(1.0,4.0),np.complex(-2.0,5.0),np.complex(-4.0,2.0),np.complex(-1.0,1.0),np.complex(4.0,3.0),np.complex(2.0,0.0),np.complex(-5.0,-5.0),np.complex(3.0,-4.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},3e-05),'complex sort 861'); local q=np.argsort(a); assert(exact(q:tolist(),{10,6,2,5,7,1,4,9,11,8,3}),'complex argsort 861') end
do local a=np.array({np.complex(-3.0,-2.0),np.complex(3.0,-4.0),np.complex(0.0,-3.0),np.complex((0/0),2.0),np.complex(-4.0,2.0),np.complex(-5.0,-5.0),np.complex(1.0,4.0),np.complex(-1.0,1.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(-2.0,5.0)},np.complex128); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex((0/0),2.0)},2e-12),'complex sort 862'); local q=np.argsort(a); assert(exact(q:tolist(),{6,5,1,11,8,3,7,2,9,10,4}),'complex argsort 862') end
do local a=np.array({np.complex(4.0,3.0),np.complex(0.0,-3.0),np.complex(2.0,0.0),np.complex(1.0,4.0),np.complex(-5.0,-5.0),np.complex(5.0,-1.0),np.complex(3.0,-4.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-1.0,1.0),np.complex(-2.0,5.0)},np.complex128); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},2e-12),'complex sort 863'); local q=np.argsort(a); assert(exact(q:tolist(),{5,8,9,11,10,2,4,3,7,1,6}),'complex argsort 863') end
do local a=np.array({np.complex(-3.0,-2.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(-1.0,1.0),np.complex(1.0,4.0),np.complex(-4.0,2.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(-2.0,5.0),np.complex(-5.0,-5.0),np.complex(0.0,-3.0)},np.complex128); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},2e-12),'complex sort 864'); local q=np.argsort(a); assert(exact(q:tolist(),{10,6,1,9,4,11,5,2,3,7,8}),'complex argsort 864') end
do local a=np.array({np.complex(-2.0,5.0),np.complex(1.0,4.0),np.complex(-4.0,2.0),np.complex(3.0,-4.0),np.complex(-3.0,-2.0),np.complex(4.0,3.0),np.complex(-1.0,1.0),np.complex(5.0,-1.0),np.complex(0.0,-3.0),np.complex(2.0,0.0),np.complex(-5.0,-5.0)},np.complex128); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},2e-12),'complex sort 865'); local q=np.argsort(a); assert(exact(q:tolist(),{11,3,5,1,7,9,2,10,4,6,8}),'complex argsort 865') end
do local a=np.array({np.complex(0.0,-3.0),np.complex(5.0,-1.0),np.complex(2.0,0.0),np.complex(-5.0,-5.0),np.complex(-2.0,5.0),np.complex(-4.0,2.0),np.complex(3.0,-4.0),np.complex(-1.0,1.0),np.complex(1.0,4.0),np.complex(4.0,3.0),np.complex(-3.0,-2.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},3e-05),'complex sort 866'); local q=np.argsort(a); assert(exact(q:tolist(),{4,6,11,5,8,1,9,3,7,10,2}),'complex argsort 866') end
do local a=np.array({np.complex(-2.0,5.0),np.complex(5.0,-1.0),np.complex(-4.0,2.0),np.complex((0/0),2.0),np.complex(3.0,-4.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(-3.0,-2.0),np.complex(0.0,-3.0),np.complex(-1.0,1.0),np.complex(-5.0,-5.0)},np.complex128); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(5.0,-1.0),np.complex((0/0),2.0)},2e-12),'complex sort 867'); local q=np.argsort(a); assert(exact(q:tolist(),{11,3,8,1,10,9,6,7,5,2,4}),'complex argsort 867') end
do local a=np.array({np.complex(-2.0,5.0),np.complex(-3.0,-2.0),np.complex(4.0,3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(-1.0,1.0),np.complex(5.0,-1.0),np.complex(3.0,-4.0),np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(0.0,-3.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},3e-05),'complex sort 868'); local q=np.argsort(a); assert(exact(q:tolist(),{9,10,2,1,6,11,4,5,8,3,7}),'complex argsort 868') end
do local a=np.array({np.complex(5.0,-1.0),np.complex(1.0,4.0),np.complex(-5.0,-5.0),np.complex(3.0,-4.0),np.complex(2.0,0.0),np.complex(-1.0,1.0),np.complex(-3.0,-2.0),np.complex(0.0,-3.0),np.complex(-4.0,2.0),np.complex(4.0,3.0),np.complex(-2.0,5.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},3e-05),'complex sort 869'); local q=np.argsort(a); assert(exact(q:tolist(),{3,9,7,11,6,8,2,5,4,10,1}),'complex argsort 869') end
do local a=np.array({np.complex(3.0,-4.0),np.complex(2.0,0.0),np.complex(-1.0,1.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(0.0,-3.0),np.complex(-5.0,-5.0),np.complex(5.0,-1.0),np.complex(4.0,3.0),np.complex(1.0,4.0),np.complex(-2.0,5.0)},np.complex128); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},2e-12),'complex sort 870'); local q=np.argsort(a); assert(exact(q:tolist(),{7,4,5,11,3,6,10,2,1,9,8}),'complex argsort 870') end
do local a=np.array({np.complex(-3.0,-2.0),np.complex(5.0,-1.0),np.complex(-5.0,-5.0),np.complex(-2.0,5.0),np.complex(2.0,0.0),np.complex(-1.0,1.0),np.complex(4.0,3.0),np.complex(1.0,4.0),np.complex(3.0,-4.0),np.complex(0.0,-3.0),np.complex(-4.0,2.0)},np.complex128); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},2e-12),'complex sort 871'); local q=np.argsort(a); assert(exact(q:tolist(),{3,11,1,4,6,10,8,5,9,7,2}),'complex argsort 871') end
do local a=np.array({np.complex(-3.0,-2.0),np.complex(0.0,-3.0),np.complex(5.0,-1.0),np.complex((0/0),2.0),np.complex(-4.0,2.0),np.complex(-5.0,-5.0),np.complex(1.0,4.0),np.complex(4.0,3.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(-2.0,5.0)},np.complex128); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex((0/0),2.0)},2e-12),'complex sort 872'); local q=np.argsort(a); assert(exact(q:tolist(),{6,5,1,11,2,7,9,10,8,3,4}),'complex argsort 872') end
do local a=np.array({np.complex(1.0,4.0),np.complex(-2.0,5.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(-3.0,-2.0),np.complex(0.0,-3.0),np.complex(-1.0,1.0),np.complex(2.0,0.0),np.complex(-4.0,2.0),np.complex(-5.0,-5.0),np.complex(5.0,-1.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},3e-05),'complex sort 873'); local q=np.argsort(a); assert(exact(q:tolist(),{10,9,5,2,7,6,1,8,3,4,11}),'complex argsort 873') end
do local a=np.array({np.complex(3.0,-4.0),np.complex(5.0,-1.0),np.complex(-3.0,-2.0),np.complex(0.0,-3.0),np.complex(-5.0,-5.0),np.complex(1.0,4.0),np.complex(-2.0,5.0),np.complex(4.0,3.0),np.complex(-4.0,2.0),np.complex(2.0,0.0),np.complex(-1.0,1.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},3e-05),'complex sort 874'); local q=np.argsort(a); assert(exact(q:tolist(),{5,9,3,7,11,4,6,10,1,8,2}),'complex argsort 874') end
do local a=np.array({np.complex(-4.0,2.0),np.complex(0.0,-3.0),np.complex(-1.0,1.0),np.complex(-2.0,5.0),np.complex(-3.0,-2.0),np.complex(5.0,-1.0),np.complex(4.0,3.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(1.0,4.0),np.complex(-5.0,-5.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},3e-05),'complex sort 875'); local q=np.argsort(a); assert(exact(q:tolist(),{11,1,5,4,3,2,10,8,9,7,6}),'complex argsort 875') end
do local a=np.array({np.complex(-5.0,-5.0),np.complex(-1.0,1.0),np.complex(2.0,0.0),np.complex(5.0,-1.0),np.complex(-4.0,2.0),np.complex(0.0,-3.0),np.complex(-2.0,5.0),np.complex(-3.0,-2.0),np.complex(3.0,-4.0),np.complex(1.0,4.0),np.complex(4.0,3.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},3e-05),'complex sort 876'); local q=np.argsort(a); assert(exact(q:tolist(),{1,5,8,7,2,6,10,3,9,11,4}),'complex argsort 876') end
do local a=np.array({np.complex(0.0,-3.0),np.complex(5.0,-1.0),np.complex(-2.0,5.0),np.complex((0/0),2.0),np.complex(-4.0,2.0),np.complex(3.0,-4.0),np.complex(-3.0,-2.0),np.complex(1.0,4.0),np.complex(4.0,3.0),np.complex(-1.0,1.0),np.complex(2.0,0.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex((0/0),2.0)},3e-05),'complex sort 877'); local q=np.argsort(a); assert(exact(q:tolist(),{5,7,3,10,1,8,11,6,9,2,4}),'complex argsort 877') end
do local a=np.array({np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(1.0,4.0),np.complex(-2.0,5.0),np.complex(-5.0,-5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(-4.0,2.0),np.complex(2.0,0.0),np.complex(-3.0,-2.0),np.complex(3.0,-4.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},3e-05),'complex sort 878'); local q=np.argsort(a); assert(exact(q:tolist(),{5,8,10,4,6,7,3,9,11,1,2}),'complex argsort 878') end
do local a=np.array({np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(-3.0,-2.0),np.complex(3.0,-4.0),np.complex(-2.0,5.0),np.complex(5.0,-1.0),np.complex(4.0,3.0),np.complex(-5.0,-5.0),np.complex(-4.0,2.0)},np.complex128); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},2e-12),'complex sort 879'); local q=np.argsort(a); assert(exact(q:tolist(),{10,11,5,7,3,4,1,2,6,9,8}),'complex argsort 879') end
do local a=np.array({np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-4.0,2.0),np.complex(4.0,3.0),np.complex(3.0,-4.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(2.0,0.0),np.complex(-5.0,-5.0),np.complex(5.0,-1.0),np.complex(1.0,4.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},3e-05),'complex sort 880'); local q=np.argsort(a); assert(exact(q:tolist(),{9,3,1,2,6,7,11,8,5,4,10}),'complex argsort 880') end
do local a=np.array({np.complex(-4.0,2.0),np.complex(5.0,-1.0),np.complex(-5.0,-5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(-2.0,5.0),np.complex(4.0,3.0),np.complex(-3.0,-2.0)},np.complex128); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},2e-12),'complex sort 881'); local q=np.argsort(a); assert(exact(q:tolist(),{3,1,11,9,4,5,6,7,8,10,2}),'complex argsort 881') end
do local a=np.array({np.complex(0.0,-3.0),np.complex(5.0,-1.0),np.complex(-5.0,-5.0),np.complex((0/0),2.0),np.complex(-4.0,2.0),np.complex(3.0,-4.0),np.complex(2.0,0.0),np.complex(4.0,3.0),np.complex(-3.0,-2.0),np.complex(-1.0,1.0),np.complex(-2.0,5.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex((0/0),2.0)},3e-05),'complex sort 882'); local q=np.argsort(a); assert(exact(q:tolist(),{3,5,9,11,10,1,7,6,8,2,4}),'complex argsort 882') end
do local a=np.array({np.complex(0.0,-3.0),np.complex(4.0,3.0),np.complex(1.0,4.0),np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(3.0,-4.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(5.0,-1.0),np.complex(2.0,0.0),np.complex(-3.0,-2.0)},np.complex128); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},2e-12),'complex sort 883'); local q=np.argsort(a); assert(exact(q:tolist(),{4,5,11,7,8,1,3,10,6,2,9}),'complex argsort 883') end
do local a=np.array({np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(-1.0,1.0),np.complex(-5.0,-5.0),np.complex(1.0,4.0),np.complex(-4.0,2.0),np.complex(4.0,3.0),np.complex(-2.0,5.0),np.complex(0.0,-3.0),np.complex(5.0,-1.0),np.complex(-3.0,-2.0)},np.complex128); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},2e-12),'complex sort 884'); local q=np.argsort(a); assert(exact(q:tolist(),{4,6,11,8,3,9,5,1,2,7,10}),'complex argsort 884') end
do local a=np.array({np.complex(1.0,4.0),np.complex(0.0,-3.0),np.complex(5.0,-1.0),np.complex(2.0,0.0),np.complex(-5.0,-5.0),np.complex(4.0,3.0),np.complex(-3.0,-2.0),np.complex(3.0,-4.0),np.complex(-2.0,5.0),np.complex(-4.0,2.0),np.complex(-1.0,1.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},3e-05),'complex sort 885'); local q=np.argsort(a); assert(exact(q:tolist(),{5,10,7,9,11,2,1,4,8,6,3}),'complex argsort 885') end
do local a=np.array({np.complex(1.0,4.0),np.complex(-1.0,1.0),np.complex(-3.0,-2.0),np.complex(-4.0,2.0),np.complex(0.0,-3.0),np.complex(2.0,0.0),np.complex(-2.0,5.0),np.complex(4.0,3.0),np.complex(-5.0,-5.0),np.complex(3.0,-4.0),np.complex(5.0,-1.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},3e-05),'complex sort 886'); local q=np.argsort(a); assert(exact(q:tolist(),{9,4,3,7,2,5,1,6,10,8,11}),'complex argsort 886') end
do local a=np.array({np.complex(-3.0,-2.0),np.complex(-4.0,2.0),np.complex(1.0,4.0),np.complex((0/0),2.0),np.complex(5.0,-1.0),np.complex(-5.0,-5.0),np.complex(-2.0,5.0),np.complex(2.0,0.0),np.complex(4.0,3.0),np.complex(3.0,-4.0),np.complex(0.0,-3.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex((0/0),2.0)},3e-05),'complex sort 887'); local q=np.argsort(a); assert(exact(q:tolist(),{6,2,1,7,11,3,8,10,9,5,4}),'complex argsort 887') end
do local a=np.array({np.complex(3.0,-4.0),np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(0.0,-3.0),np.complex(5.0,-1.0),np.complex(-3.0,-2.0),np.complex(4.0,3.0),np.complex(-2.0,5.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(-1.0,1.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},3e-05),'complex sort 888'); local q=np.argsort(a); assert(exact(q:tolist(),{2,3,6,8,11,4,9,10,1,7,5}),'complex argsort 888') end
do local a=np.array({np.complex(5.0,-1.0),np.complex(2.0,0.0),np.complex(-3.0,-2.0),np.complex(-1.0,1.0),np.complex(4.0,3.0),np.complex(-2.0,5.0),np.complex(-4.0,2.0),np.complex(3.0,-4.0),np.complex(-5.0,-5.0),np.complex(1.0,4.0),np.complex(0.0,-3.0)},np.complex128); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},2e-12),'complex sort 889'); local q=np.argsort(a); assert(exact(q:tolist(),{9,7,3,6,4,11,10,2,8,5,1}),'complex argsort 889') end
do local a=np.array({np.complex(1.0,4.0),np.complex(-5.0,-5.0),np.complex(0.0,-3.0),np.complex(2.0,0.0),np.complex(-3.0,-2.0),np.complex(-4.0,2.0),np.complex(5.0,-1.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(3.0,-4.0),np.complex(4.0,3.0)},np.complex128); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},2e-12),'complex sort 890'); local q=np.argsort(a); assert(exact(q:tolist(),{2,6,5,8,9,3,1,4,10,11,7}),'complex argsort 890') end
do local a=np.array({np.complex(-1.0,1.0),np.complex(-2.0,5.0),np.complex(4.0,3.0),np.complex(3.0,-4.0),np.complex(-4.0,2.0),np.complex(0.0,-3.0),np.complex(2.0,0.0),np.complex(-5.0,-5.0),np.complex(5.0,-1.0),np.complex(-3.0,-2.0),np.complex(1.0,4.0)},np.complex64); local r=np.sort(a); assert(close(r:tolist(),{np.complex(-5.0,-5.0),np.complex(-4.0,2.0),np.complex(-3.0,-2.0),np.complex(-2.0,5.0),np.complex(-1.0,1.0),np.complex(0.0,-3.0),np.complex(1.0,4.0),np.complex(2.0,0.0),np.complex(3.0,-4.0),np.complex(4.0,3.0),np.complex(5.0,-1.0)},3e-05),'complex sort 891'); local q=np.argsort(a); assert(exact(q:tolist(),{8,5,10,2,1,6,11,7,4,3,9}),'complex argsort 891') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex64); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex64); local r=np.searchsorted(a,k,'left'); assert(exact(r:tolist(),{1,5,7,11,13}),'complex searchsorted 892') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex128); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex128); local r=np.searchsorted(a,k,'left'); assert(exact(r:tolist(),{1,5,7,11,13}),'complex searchsorted 893') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex64); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex64); local r=np.searchsorted(a,k,'right'); assert(exact(r:tolist(),{1,6,7,11,13}),'complex searchsorted 894') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex64); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex64); local r=np.searchsorted(a,k,'left'); assert(exact(r:tolist(),{1,5,7,11,13}),'complex searchsorted 895') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex128); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex128); local r=np.searchsorted(a,k,'left'); assert(exact(r:tolist(),{1,5,7,11,13}),'complex searchsorted 896') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex64); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex64); local r=np.searchsorted(a,k,'left'); assert(exact(r:tolist(),{1,5,7,11,13}),'complex searchsorted 897') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex64); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex64); local r=np.searchsorted(a,k,'left'); assert(exact(r:tolist(),{1,5,7,11,13}),'complex searchsorted 898') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex128); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex128); local r=np.searchsorted(a,k,'right'); assert(exact(r:tolist(),{1,6,7,11,13}),'complex searchsorted 899') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex128); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex128); local r=np.searchsorted(a,k,'right'); assert(exact(r:tolist(),{1,6,7,11,13}),'complex searchsorted 900') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex64); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex64); local r=np.searchsorted(a,k,'left'); assert(exact(r:tolist(),{1,5,7,11,13}),'complex searchsorted 901') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex64); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex64); local r=np.searchsorted(a,k,'right'); assert(exact(r:tolist(),{1,6,7,11,13}),'complex searchsorted 902') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex64); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex64); local r=np.searchsorted(a,k,'left'); assert(exact(r:tolist(),{1,5,7,11,13}),'complex searchsorted 903') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex64); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex64); local r=np.searchsorted(a,k,'right'); assert(exact(r:tolist(),{1,6,7,11,13}),'complex searchsorted 904') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex64); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex64); local r=np.searchsorted(a,k,'left'); assert(exact(r:tolist(),{1,5,7,11,13}),'complex searchsorted 905') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex128); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex128); local r=np.searchsorted(a,k,'left'); assert(exact(r:tolist(),{1,5,7,11,13}),'complex searchsorted 906') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex128); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex128); local r=np.searchsorted(a,k,'left'); assert(exact(r:tolist(),{1,5,7,11,13}),'complex searchsorted 907') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex64); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex64); local r=np.searchsorted(a,k,'right'); assert(exact(r:tolist(),{1,6,7,11,13}),'complex searchsorted 908') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex128); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex128); local r=np.searchsorted(a,k,'right'); assert(exact(r:tolist(),{1,6,7,11,13}),'complex searchsorted 909') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex128); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex128); local r=np.searchsorted(a,k,'left'); assert(exact(r:tolist(),{1,5,7,11,13}),'complex searchsorted 910') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex128); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex128); local r=np.searchsorted(a,k,'left'); assert(exact(r:tolist(),{1,5,7,11,13}),'complex searchsorted 911') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex128); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex128); local r=np.searchsorted(a,k,'right'); assert(exact(r:tolist(),{1,6,7,11,13}),'complex searchsorted 912') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex64); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex64); local r=np.searchsorted(a,k,'right'); assert(exact(r:tolist(),{1,6,7,11,13}),'complex searchsorted 913') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex128); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex128); local r=np.searchsorted(a,k,'left'); assert(exact(r:tolist(),{1,5,7,11,13}),'complex searchsorted 914') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex128); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex128); local r=np.searchsorted(a,k,'right'); assert(exact(r:tolist(),{1,6,7,11,13}),'complex searchsorted 915') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex128); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex128); local r=np.searchsorted(a,k,'right'); assert(exact(r:tolist(),{1,6,7,11,13}),'complex searchsorted 916') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex64); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex64); local r=np.searchsorted(a,k,'right'); assert(exact(r:tolist(),{1,6,7,11,13}),'complex searchsorted 917') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex128); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex128); local r=np.searchsorted(a,k,'right'); assert(exact(r:tolist(),{1,6,7,11,13}),'complex searchsorted 918') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex128); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex128); local r=np.searchsorted(a,k,'right'); assert(exact(r:tolist(),{1,6,7,11,13}),'complex searchsorted 919') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex128); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex128); local r=np.searchsorted(a,k,'right'); assert(exact(r:tolist(),{1,6,7,11,13}),'complex searchsorted 920') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex128); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex128); local r=np.searchsorted(a,k,'left'); assert(exact(r:tolist(),{1,5,7,11,13}),'complex searchsorted 921') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex64); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex64); local r=np.searchsorted(a,k,'right'); assert(exact(r:tolist(),{1,6,7,11,13}),'complex searchsorted 922') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex128); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex128); local r=np.searchsorted(a,k,'right'); assert(exact(r:tolist(),{1,6,7,11,13}),'complex searchsorted 923') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex64); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex64); local r=np.searchsorted(a,k,'right'); assert(exact(r:tolist(),{1,6,7,11,13}),'complex searchsorted 924') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex128); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex128); local r=np.searchsorted(a,k,'right'); assert(exact(r:tolist(),{1,6,7,11,13}),'complex searchsorted 925') end
do local a=np.array({np.complex(-5.0,-3.0),np.complex(-4.0,0.0),np.complex(-3.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,2.0),np.complex(0.0,-2.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(3.0,0.0),np.complex(4.0,3.0),np.complex(5.0,-1.0),np.complex(6.0,2.0)},np.complex64); local k=np.array({np.complex(-6.0,0.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(4.0,5.0),np.complex(7.0,0.0)},np.complex64); local r=np.searchsorted(a,k,'right'); assert(exact(r:tolist(),{1,6,7,11,13}),'complex searchsorted 926') end
do
 local a=np.array({np.complex(1,1),np.complex(2,2),np.complex(3,3),np.complex(4,4)},np.complex64)
 a[np.slice(2,5,2)]=np.complex(9,-1)
 assert(close(a:tolist(),{np.complex(1,1),np.complex(9,-1),np.complex(3,3),np.complex(9,-1)},3e-5),'complex slice assignment')
 local idx=np.array({4,1,4},np.int64)
 a[idx]=np.complex(-2,5)
 assert(close(a:tolist(),{np.complex(-2,5),np.complex(9,-1),np.complex(3,3),np.complex(-2,5)},3e-5),'complex fancy assignment')
end
print('complex differential: 929 cases ok')
