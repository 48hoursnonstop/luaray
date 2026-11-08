local np=require('luaray_core')

local function fsame(a,b,tol)
  if type(a)=='userdata' or type(b)=='userdata' then
    if type(a)~='userdata' or type(b)~='userdata' then return false end
    return fsame(a.real,b.real,tol) and fsame(a.imag,b.imag,tol)
  end
  if a~=a and b~=b then return true end
  if a==b then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return false end
  return math.abs(a-b)<=tol*math.max(1,math.abs(a),math.abs(b))
end
local function same(a,b,tol)
  if type(a)~='table' or type(b)~='table' then return fsame(a,b,tol) end
  if #a~=#b then return false end
  for i=1,#a do if not same(a[i],b[i],tol) then return false end end
  return true
end

-- Development oracle NumPy 2.3.5; semantics pinned to uploaded NumPy main.
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.add(a,true)
 assert(r.dtype=='bool','weak dtype add 0 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values add 0')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.add(true,a)
 assert(r.dtype=='bool','weak dtype add 1 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values add 1')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.add(a,2)
 assert(r.dtype=='int64','weak dtype add 2 '..r.dtype)
 assert(same(r:tolist(),{2,3,3,2},0.0),'weak values add 2')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.add(2,a)
 assert(r.dtype=='int64','weak dtype add 3 '..r.dtype)
 assert(same(r:tolist(),{2,3,3,2},0.0),'weak values add 3')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.add(a,2)
 assert(r.dtype=='int8','weak dtype add 4 '..r.dtype)
 assert(same(r:tolist(),{-5,1,4,13},0.0),'weak values add 4')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.add(2,a)
 assert(r.dtype=='int8','weak dtype add 5 '..r.dtype)
 assert(same(r:tolist(),{-5,1,4,13},0.0),'weak values add 5')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.add(a,-3)
 assert(r.dtype=='int8','weak dtype add 6 '..r.dtype)
 assert(same(r:tolist(),{-10,-4,-1,8},0.0),'weak values add 6')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.add(-3,a)
 assert(r.dtype=='int8','weak dtype add 7 '..r.dtype)
 assert(same(r:tolist(),{-10,-4,-1,8},0.0),'weak values add 7')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.add(a,2)
 assert(r.dtype=='uint8','weak dtype add 8 '..r.dtype)
 assert(same(r:tolist(),{2,3,7,19},0.0),'weak values add 8')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.add(2,a)
 assert(r.dtype=='uint8','weak dtype add 9 '..r.dtype)
 assert(same(r:tolist(),{2,3,7,19},0.0),'weak values add 9')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.add(a,300) end)
 assert(not ok,'weak reject add 10')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.add(300,a) end)
 assert(not ok,'weak reject add 11')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.add(a,-1) end)
 assert(not ok,'weak reject add 12')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.add(-1,a) end)
 assert(not ok,'weak reject add 13')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.add(a,127)
 assert(r.dtype=='int16','weak dtype add 14 '..r.dtype)
 assert(same(r:tolist(),{120,126,129,138},0.0),'weak values add 14')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.add(127,a)
 assert(r.dtype=='int16','weak dtype add 15 '..r.dtype)
 assert(same(r:tolist(),{120,126,129,138},0.0),'weak values add 15')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.add(a,5)
 assert(r.dtype=='int64','weak dtype add 16 '..r.dtype)
 assert(same(r:tolist(),{-2,4,7,16},0.0),'weak values add 16')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.add(5,a)
 assert(r.dtype=='int64','weak dtype add 17 '..r.dtype)
 assert(same(r:tolist(),{-2,4,7,16},0.0),'weak values add 17')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.add(a,5)
 assert(r.dtype=='uint64','weak dtype add 18 '..r.dtype)
 assert(same(r:tolist(),{5,6,10,22},0.0),'weak values add 18')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.add(5,a)
 assert(r.dtype=='uint64','weak dtype add 19 '..r.dtype)
 assert(same(r:tolist(),{5,6,10,22},0.0),'weak values add 19')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.add(a,-1) end)
 assert(not ok,'weak reject add 20')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.add(-1,a) end)
 assert(not ok,'weak reject add 21')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.add(a,2)
 assert(r.dtype=='float16','weak dtype add 22 '..r.dtype)
 assert(same(r:tolist(),{-0.5,2.0,3.25,9.0},0.006),'weak values add 22')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.add(2,a)
 assert(r.dtype=='float16','weak dtype add 23 '..r.dtype)
 assert(same(r:tolist(),{-0.5,2.0,3.25,9.0},0.006),'weak values add 23')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.add(a,2.0)
 assert(r.dtype=='float16','weak dtype add 24 '..r.dtype)
 assert(same(r:tolist(),{-0.5,2.0,3.25,9.0},0.006),'weak values add 24')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.add(2.0,a)
 assert(r.dtype=='float16','weak dtype add 25 '..r.dtype)
 assert(same(r:tolist(),{-0.5,2.0,3.25,9.0},0.006),'weak values add 25')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.add(a,2)
 assert(r.dtype=='float32','weak dtype add 26 '..r.dtype)
 assert(same(r:tolist(),{-0.5,2.0,3.25,9.0},1e-05),'weak values add 26')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.add(2,a)
 assert(r.dtype=='float32','weak dtype add 27 '..r.dtype)
 assert(same(r:tolist(),{-0.5,2.0,3.25,9.0},1e-05),'weak values add 27')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.add(a,2.0)
 assert(r.dtype=='float32','weak dtype add 28 '..r.dtype)
 assert(same(r:tolist(),{-0.5,2.0,3.25,9.0},1e-05),'weak values add 28')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.add(2.0,a)
 assert(r.dtype=='float32','weak dtype add 29 '..r.dtype)
 assert(same(r:tolist(),{-0.5,2.0,3.25,9.0},1e-05),'weak values add 29')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.add(a,np.complex(0.0,2.0))
 assert(r.dtype=='complex64','weak dtype add 30 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-2.5,2.0),np.complex(0.0,2.0),np.complex(1.25,2.0),np.complex(7.0,2.0)},1e-05),'weak values add 30')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.add(np.complex(0.0,2.0),a)
 assert(r.dtype=='complex64','weak dtype add 31 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-2.5,2.0),np.complex(0.0,2.0),np.complex(1.25,2.0),np.complex(7.0,2.0)},1e-05),'weak values add 31')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.add(a,2.0)
 assert(r.dtype=='float64','weak dtype add 32 '..r.dtype)
 assert(same(r:tolist(),{-0.5,2.0,3.25,9.0},3e-12),'weak values add 32')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.add(2.0,a)
 assert(r.dtype=='float64','weak dtype add 33 '..r.dtype)
 assert(same(r:tolist(),{-0.5,2.0,3.25,9.0},3e-12),'weak values add 33')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.add(a,2)
 assert(r.dtype=='complex64','weak dtype add 34 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-0.5,1.0),np.complex(2.0,-2.0),np.complex(3.25,0.5),np.complex(9.0,-3.0)},1e-05),'weak values add 34')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.add(2,a)
 assert(r.dtype=='complex64','weak dtype add 35 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-0.5,1.0),np.complex(2.0,-2.0),np.complex(3.25,0.5),np.complex(9.0,-3.0)},1e-05),'weak values add 35')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.add(a,2.0)
 assert(r.dtype=='complex64','weak dtype add 36 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-0.5,1.0),np.complex(2.0,-2.0),np.complex(3.25,0.5),np.complex(9.0,-3.0)},1e-05),'weak values add 36')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.add(2.0,a)
 assert(r.dtype=='complex64','weak dtype add 37 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-0.5,1.0),np.complex(2.0,-2.0),np.complex(3.25,0.5),np.complex(9.0,-3.0)},1e-05),'weak values add 37')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.add(a,np.complex(1.0,2.0))
 assert(r.dtype=='complex64','weak dtype add 38 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-1.5,3.0),np.complex(1.0,0.0),np.complex(2.25,2.5),np.complex(8.0,-1.0)},1e-05),'weak values add 38')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.add(np.complex(1.0,2.0),a)
 assert(r.dtype=='complex64','weak dtype add 39 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-1.5,3.0),np.complex(1.0,0.0),np.complex(2.25,2.5),np.complex(8.0,-1.0)},1e-05),'weak values add 39')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local ok=pcall(function() return np.subtract(a,true) end)
 assert(not ok,'weak reject subtract 40')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local ok=pcall(function() return np.subtract(true,a) end)
 assert(not ok,'weak reject subtract 41')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.subtract(a,2)
 assert(r.dtype=='int64','weak dtype subtract 42 '..r.dtype)
 assert(same(r:tolist(),{-2,-1,-1,-2},0.0),'weak values subtract 42')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.subtract(2,a)
 assert(r.dtype=='int64','weak dtype subtract 43 '..r.dtype)
 assert(same(r:tolist(),{2,1,1,2},0.0),'weak values subtract 43')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.subtract(a,2)
 assert(r.dtype=='int8','weak dtype subtract 44 '..r.dtype)
 assert(same(r:tolist(),{-9,-3,0,9},0.0),'weak values subtract 44')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.subtract(2,a)
 assert(r.dtype=='int8','weak dtype subtract 45 '..r.dtype)
 assert(same(r:tolist(),{9,3,0,-9},0.0),'weak values subtract 45')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.subtract(a,-3)
 assert(r.dtype=='int8','weak dtype subtract 46 '..r.dtype)
 assert(same(r:tolist(),{-4,2,5,14},0.0),'weak values subtract 46')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.subtract(-3,a)
 assert(r.dtype=='int8','weak dtype subtract 47 '..r.dtype)
 assert(same(r:tolist(),{4,-2,-5,-14},0.0),'weak values subtract 47')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.subtract(a,2)
 assert(r.dtype=='uint8','weak dtype subtract 48 '..r.dtype)
 assert(same(r:tolist(),{254,255,3,15},0.0),'weak values subtract 48')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.subtract(2,a)
 assert(r.dtype=='uint8','weak dtype subtract 49 '..r.dtype)
 assert(same(r:tolist(),{2,1,253,241},0.0),'weak values subtract 49')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.subtract(a,300) end)
 assert(not ok,'weak reject subtract 50')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.subtract(300,a) end)
 assert(not ok,'weak reject subtract 51')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.subtract(a,-1) end)
 assert(not ok,'weak reject subtract 52')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.subtract(-1,a) end)
 assert(not ok,'weak reject subtract 53')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.subtract(a,127)
 assert(r.dtype=='int16','weak dtype subtract 54 '..r.dtype)
 assert(same(r:tolist(),{-134,-128,-125,-116},0.0),'weak values subtract 54')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.subtract(127,a)
 assert(r.dtype=='int16','weak dtype subtract 55 '..r.dtype)
 assert(same(r:tolist(),{134,128,125,116},0.0),'weak values subtract 55')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.subtract(a,5)
 assert(r.dtype=='int64','weak dtype subtract 56 '..r.dtype)
 assert(same(r:tolist(),{-12,-6,-3,6},0.0),'weak values subtract 56')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.subtract(5,a)
 assert(r.dtype=='int64','weak dtype subtract 57 '..r.dtype)
 assert(same(r:tolist(),{12,6,3,-6},0.0),'weak values subtract 57')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.subtract(a,5)
 assert(r.dtype=='uint64','weak dtype subtract 58 '..r.dtype)
 assert(same(r:tolist(),{18446744073709551611,18446744073709551612,0,12},0.0),'weak values subtract 58')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.subtract(5,a)
 assert(r.dtype=='uint64','weak dtype subtract 59 '..r.dtype)
 assert(same(r:tolist(),{5,4,0,18446744073709551604},0.0),'weak values subtract 59')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.subtract(a,-1) end)
 assert(not ok,'weak reject subtract 60')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.subtract(-1,a) end)
 assert(not ok,'weak reject subtract 61')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.subtract(a,2)
 assert(r.dtype=='float16','weak dtype subtract 62 '..r.dtype)
 assert(same(r:tolist(),{-4.5,-2.0,-0.75,5.0},0.006),'weak values subtract 62')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.subtract(2,a)
 assert(r.dtype=='float16','weak dtype subtract 63 '..r.dtype)
 assert(same(r:tolist(),{4.5,2.0,0.75,-5.0},0.006),'weak values subtract 63')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.subtract(a,2.0)
 assert(r.dtype=='float16','weak dtype subtract 64 '..r.dtype)
 assert(same(r:tolist(),{-4.5,-2.0,-0.75,5.0},0.006),'weak values subtract 64')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.subtract(2.0,a)
 assert(r.dtype=='float16','weak dtype subtract 65 '..r.dtype)
 assert(same(r:tolist(),{4.5,2.0,0.75,-5.0},0.006),'weak values subtract 65')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.subtract(a,2)
 assert(r.dtype=='float32','weak dtype subtract 66 '..r.dtype)
 assert(same(r:tolist(),{-4.5,-2.0,-0.75,5.0},1e-05),'weak values subtract 66')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.subtract(2,a)
 assert(r.dtype=='float32','weak dtype subtract 67 '..r.dtype)
 assert(same(r:tolist(),{4.5,2.0,0.75,-5.0},1e-05),'weak values subtract 67')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.subtract(a,2.0)
 assert(r.dtype=='float32','weak dtype subtract 68 '..r.dtype)
 assert(same(r:tolist(),{-4.5,-2.0,-0.75,5.0},1e-05),'weak values subtract 68')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.subtract(2.0,a)
 assert(r.dtype=='float32','weak dtype subtract 69 '..r.dtype)
 assert(same(r:tolist(),{4.5,2.0,0.75,-5.0},1e-05),'weak values subtract 69')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.subtract(a,np.complex(0.0,2.0))
 assert(r.dtype=='complex64','weak dtype subtract 70 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-2.5,-2.0),np.complex(-0.0,-2.0),np.complex(1.25,-2.0),np.complex(7.0,-2.0)},1e-05),'weak values subtract 70')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.subtract(np.complex(0.0,2.0),a)
 assert(r.dtype=='complex64','weak dtype subtract 71 '..r.dtype)
 assert(same(r:tolist(),{np.complex(2.5,2.0),np.complex(0.0,2.0),np.complex(-1.25,2.0),np.complex(-7.0,2.0)},1e-05),'weak values subtract 71')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.subtract(a,2.0)
 assert(r.dtype=='float64','weak dtype subtract 72 '..r.dtype)
 assert(same(r:tolist(),{-4.5,-2.0,-0.75,5.0},3e-12),'weak values subtract 72')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.subtract(2.0,a)
 assert(r.dtype=='float64','weak dtype subtract 73 '..r.dtype)
 assert(same(r:tolist(),{4.5,2.0,0.75,-5.0},3e-12),'weak values subtract 73')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.subtract(a,2)
 assert(r.dtype=='complex64','weak dtype subtract 74 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-4.5,1.0),np.complex(-2.0,-2.0),np.complex(-0.75,0.5),np.complex(5.0,-3.0)},1e-05),'weak values subtract 74')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.subtract(2,a)
 assert(r.dtype=='complex64','weak dtype subtract 75 '..r.dtype)
 assert(same(r:tolist(),{np.complex(4.5,-1.0),np.complex(2.0,2.0),np.complex(0.75,-0.5),np.complex(-5.0,3.0)},1e-05),'weak values subtract 75')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.subtract(a,2.0)
 assert(r.dtype=='complex64','weak dtype subtract 76 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-4.5,1.0),np.complex(-2.0,-2.0),np.complex(-0.75,0.5),np.complex(5.0,-3.0)},1e-05),'weak values subtract 76')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.subtract(2.0,a)
 assert(r.dtype=='complex64','weak dtype subtract 77 '..r.dtype)
 assert(same(r:tolist(),{np.complex(4.5,-1.0),np.complex(2.0,2.0),np.complex(0.75,-0.5),np.complex(-5.0,3.0)},1e-05),'weak values subtract 77')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.subtract(a,np.complex(1.0,2.0))
 assert(r.dtype=='complex64','weak dtype subtract 78 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-3.5,-1.0),np.complex(-1.0,-4.0),np.complex(0.25,-1.5),np.complex(6.0,-5.0)},1e-05),'weak values subtract 78')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.subtract(np.complex(1.0,2.0),a)
 assert(r.dtype=='complex64','weak dtype subtract 79 '..r.dtype)
 assert(same(r:tolist(),{np.complex(3.5,1.0),np.complex(1.0,4.0),np.complex(-0.25,1.5),np.complex(-6.0,5.0)},1e-05),'weak values subtract 79')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.multiply(a,true)
 assert(r.dtype=='bool','weak dtype multiply 80 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,false},0.0),'weak values multiply 80')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.multiply(true,a)
 assert(r.dtype=='bool','weak dtype multiply 81 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,false},0.0),'weak values multiply 81')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.multiply(a,2)
 assert(r.dtype=='int64','weak dtype multiply 82 '..r.dtype)
 assert(same(r:tolist(),{0,2,2,0},0.0),'weak values multiply 82')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.multiply(2,a)
 assert(r.dtype=='int64','weak dtype multiply 83 '..r.dtype)
 assert(same(r:tolist(),{0,2,2,0},0.0),'weak values multiply 83')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.multiply(a,2)
 assert(r.dtype=='int8','weak dtype multiply 84 '..r.dtype)
 assert(same(r:tolist(),{-14,-2,4,22},0.0),'weak values multiply 84')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.multiply(2,a)
 assert(r.dtype=='int8','weak dtype multiply 85 '..r.dtype)
 assert(same(r:tolist(),{-14,-2,4,22},0.0),'weak values multiply 85')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.multiply(a,-3)
 assert(r.dtype=='int8','weak dtype multiply 86 '..r.dtype)
 assert(same(r:tolist(),{21,3,-6,-33},0.0),'weak values multiply 86')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.multiply(-3,a)
 assert(r.dtype=='int8','weak dtype multiply 87 '..r.dtype)
 assert(same(r:tolist(),{21,3,-6,-33},0.0),'weak values multiply 87')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.multiply(a,2)
 assert(r.dtype=='uint8','weak dtype multiply 88 '..r.dtype)
 assert(same(r:tolist(),{0,2,10,34},0.0),'weak values multiply 88')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.multiply(2,a)
 assert(r.dtype=='uint8','weak dtype multiply 89 '..r.dtype)
 assert(same(r:tolist(),{0,2,10,34},0.0),'weak values multiply 89')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.multiply(a,300) end)
 assert(not ok,'weak reject multiply 90')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.multiply(300,a) end)
 assert(not ok,'weak reject multiply 91')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.multiply(a,-1) end)
 assert(not ok,'weak reject multiply 92')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.multiply(-1,a) end)
 assert(not ok,'weak reject multiply 93')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.multiply(a,127)
 assert(r.dtype=='int16','weak dtype multiply 94 '..r.dtype)
 assert(same(r:tolist(),{-889,-127,254,1397},0.0),'weak values multiply 94')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.multiply(127,a)
 assert(r.dtype=='int16','weak dtype multiply 95 '..r.dtype)
 assert(same(r:tolist(),{-889,-127,254,1397},0.0),'weak values multiply 95')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.multiply(a,5)
 assert(r.dtype=='int64','weak dtype multiply 96 '..r.dtype)
 assert(same(r:tolist(),{-35,-5,10,55},0.0),'weak values multiply 96')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.multiply(5,a)
 assert(r.dtype=='int64','weak dtype multiply 97 '..r.dtype)
 assert(same(r:tolist(),{-35,-5,10,55},0.0),'weak values multiply 97')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.multiply(a,5)
 assert(r.dtype=='uint64','weak dtype multiply 98 '..r.dtype)
 assert(same(r:tolist(),{0,5,25,85},0.0),'weak values multiply 98')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.multiply(5,a)
 assert(r.dtype=='uint64','weak dtype multiply 99 '..r.dtype)
 assert(same(r:tolist(),{0,5,25,85},0.0),'weak values multiply 99')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.multiply(a,-1) end)
 assert(not ok,'weak reject multiply 100')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.multiply(-1,a) end)
 assert(not ok,'weak reject multiply 101')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.multiply(a,2)
 assert(r.dtype=='float16','weak dtype multiply 102 '..r.dtype)
 assert(same(r:tolist(),{-5.0,-0.0,2.5,14.0},0.006),'weak values multiply 102')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.multiply(2,a)
 assert(r.dtype=='float16','weak dtype multiply 103 '..r.dtype)
 assert(same(r:tolist(),{-5.0,-0.0,2.5,14.0},0.006),'weak values multiply 103')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.multiply(a,2.0)
 assert(r.dtype=='float16','weak dtype multiply 104 '..r.dtype)
 assert(same(r:tolist(),{-5.0,-0.0,2.5,14.0},0.006),'weak values multiply 104')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.multiply(2.0,a)
 assert(r.dtype=='float16','weak dtype multiply 105 '..r.dtype)
 assert(same(r:tolist(),{-5.0,-0.0,2.5,14.0},0.006),'weak values multiply 105')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.multiply(a,2)
 assert(r.dtype=='float32','weak dtype multiply 106 '..r.dtype)
 assert(same(r:tolist(),{-5.0,-0.0,2.5,14.0},1e-05),'weak values multiply 106')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.multiply(2,a)
 assert(r.dtype=='float32','weak dtype multiply 107 '..r.dtype)
 assert(same(r:tolist(),{-5.0,-0.0,2.5,14.0},1e-05),'weak values multiply 107')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.multiply(a,2.0)
 assert(r.dtype=='float32','weak dtype multiply 108 '..r.dtype)
 assert(same(r:tolist(),{-5.0,-0.0,2.5,14.0},1e-05),'weak values multiply 108')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.multiply(2.0,a)
 assert(r.dtype=='float32','weak dtype multiply 109 '..r.dtype)
 assert(same(r:tolist(),{-5.0,-0.0,2.5,14.0},1e-05),'weak values multiply 109')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.multiply(a,np.complex(0.0,2.0))
 assert(r.dtype=='complex64','weak dtype multiply 110 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-0.0,-5.0),np.complex(-0.0,0.0),np.complex(0.0,2.5),np.complex(0.0,14.0)},1e-05),'weak values multiply 110')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.multiply(np.complex(0.0,2.0),a)
 assert(r.dtype=='complex64','weak dtype multiply 111 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-0.0,-5.0),np.complex(-0.0,0.0),np.complex(0.0,2.5),np.complex(0.0,14.0)},1e-05),'weak values multiply 111')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.multiply(a,2.0)
 assert(r.dtype=='float64','weak dtype multiply 112 '..r.dtype)
 assert(same(r:tolist(),{-5.0,-0.0,2.5,14.0},3e-12),'weak values multiply 112')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.multiply(2.0,a)
 assert(r.dtype=='float64','weak dtype multiply 113 '..r.dtype)
 assert(same(r:tolist(),{-5.0,-0.0,2.5,14.0},3e-12),'weak values multiply 113')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.multiply(a,2)
 assert(r.dtype=='complex64','weak dtype multiply 114 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-5.0,2.0),np.complex(0.0,-4.0),np.complex(2.5,1.0),np.complex(14.0,-6.0)},1e-05),'weak values multiply 114')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.multiply(2,a)
 assert(r.dtype=='complex64','weak dtype multiply 115 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-5.0,2.0),np.complex(0.0,-4.0),np.complex(2.5,1.0),np.complex(14.0,-6.0)},1e-05),'weak values multiply 115')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.multiply(a,2.0)
 assert(r.dtype=='complex64','weak dtype multiply 116 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-5.0,2.0),np.complex(0.0,-4.0),np.complex(2.5,1.0),np.complex(14.0,-6.0)},1e-05),'weak values multiply 116')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.multiply(2.0,a)
 assert(r.dtype=='complex64','weak dtype multiply 117 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-5.0,2.0),np.complex(0.0,-4.0),np.complex(2.5,1.0),np.complex(14.0,-6.0)},1e-05),'weak values multiply 117')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.multiply(a,np.complex(1.0,2.0))
 assert(r.dtype=='complex64','weak dtype multiply 118 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-4.5,-4.0),np.complex(4.0,-2.0),np.complex(0.25,3.0),np.complex(13.0,11.0)},1e-05),'weak values multiply 118')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.multiply(np.complex(1.0,2.0),a)
 assert(r.dtype=='complex64','weak dtype multiply 119 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-4.5,-4.0),np.complex(4.0,-2.0),np.complex(0.25,3.0),np.complex(13.0,11.0)},1e-05),'weak values multiply 119')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.true_divide(a,true)
 assert(r.dtype=='float64','weak dtype true_divide 120 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.0,1.0,0.0},3e-12),'weak values true_divide 120')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.true_divide(true,a)
 assert(r.dtype=='float64','weak dtype true_divide 121 '..r.dtype)
 assert(same(r:tolist(),{math.huge,1.0,1.0,math.huge},3e-12),'weak values true_divide 121')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.true_divide(a,2)
 assert(r.dtype=='float64','weak dtype true_divide 122 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.5,0.5,0.0},3e-12),'weak values true_divide 122')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.true_divide(2,a)
 assert(r.dtype=='float64','weak dtype true_divide 123 '..r.dtype)
 assert(same(r:tolist(),{math.huge,2.0,2.0,math.huge},3e-12),'weak values true_divide 123')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.true_divide(a,2)
 assert(r.dtype=='float64','weak dtype true_divide 124 '..r.dtype)
 assert(same(r:tolist(),{-3.5,-0.5,1.0,5.5},3e-12),'weak values true_divide 124')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.true_divide(2,a)
 assert(r.dtype=='float64','weak dtype true_divide 125 '..r.dtype)
 assert(same(r:tolist(),{-0.2857142857142857,-2.0,1.0,0.18181818181818182},3e-12),'weak values true_divide 125')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.true_divide(a,-3)
 assert(r.dtype=='float64','weak dtype true_divide 126 '..r.dtype)
 assert(same(r:tolist(),{2.3333333333333335,0.3333333333333333,-0.6666666666666666,-3.6666666666666665},3e-12),'weak values true_divide 126')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.true_divide(-3,a)
 assert(r.dtype=='float64','weak dtype true_divide 127 '..r.dtype)
 assert(same(r:tolist(),{0.42857142857142855,3.0,-1.5,-0.2727272727272727},3e-12),'weak values true_divide 127')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.true_divide(a,2)
 assert(r.dtype=='float64','weak dtype true_divide 128 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.5,2.5,8.5},3e-12),'weak values true_divide 128')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.true_divide(2,a)
 assert(r.dtype=='float64','weak dtype true_divide 129 '..r.dtype)
 assert(same(r:tolist(),{math.huge,2.0,0.4,0.11764705882352941},3e-12),'weak values true_divide 129')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.true_divide(a,300)
 assert(r.dtype=='float64','weak dtype true_divide 130 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.0033333333333333335,0.016666666666666666,0.056666666666666664},3e-12),'weak values true_divide 130')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.true_divide(300,a)
 assert(r.dtype=='float64','weak dtype true_divide 131 '..r.dtype)
 assert(same(r:tolist(),{math.huge,300.0,60.0,17.647058823529413},3e-12),'weak values true_divide 131')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.true_divide(a,-1)
 assert(r.dtype=='float64','weak dtype true_divide 132 '..r.dtype)
 assert(same(r:tolist(),{-0.0,-1.0,-5.0,-17.0},3e-12),'weak values true_divide 132')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.true_divide(-1,a)
 assert(r.dtype=='float64','weak dtype true_divide 133 '..r.dtype)
 assert(same(r:tolist(),{-math.huge,-1.0,-0.2,-0.058823529411764705},3e-12),'weak values true_divide 133')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.true_divide(a,127)
 assert(r.dtype=='float64','weak dtype true_divide 134 '..r.dtype)
 assert(same(r:tolist(),{-0.05511811023622047,-0.007874015748031496,0.015748031496062992,0.08661417322834646},3e-12),'weak values true_divide 134')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.true_divide(127,a)
 assert(r.dtype=='float64','weak dtype true_divide 135 '..r.dtype)
 assert(same(r:tolist(),{-18.142857142857142,-127.0,63.5,11.545454545454545},3e-12),'weak values true_divide 135')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.true_divide(a,5)
 assert(r.dtype=='float64','weak dtype true_divide 136 '..r.dtype)
 assert(same(r:tolist(),{-1.4,-0.2,0.4,2.2},3e-12),'weak values true_divide 136')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.true_divide(5,a)
 assert(r.dtype=='float64','weak dtype true_divide 137 '..r.dtype)
 assert(same(r:tolist(),{-0.7142857142857143,-5.0,2.5,0.45454545454545453},3e-12),'weak values true_divide 137')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.true_divide(a,5)
 assert(r.dtype=='float64','weak dtype true_divide 138 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.2,1.0,3.4},3e-12),'weak values true_divide 138')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.true_divide(5,a)
 assert(r.dtype=='float64','weak dtype true_divide 139 '..r.dtype)
 assert(same(r:tolist(),{math.huge,5.0,1.0,0.29411764705882354},3e-12),'weak values true_divide 139')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.true_divide(a,-1)
 assert(r.dtype=='float64','weak dtype true_divide 140 '..r.dtype)
 assert(same(r:tolist(),{-0.0,-1.0,-5.0,-17.0},3e-12),'weak values true_divide 140')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.true_divide(-1,a)
 assert(r.dtype=='float64','weak dtype true_divide 141 '..r.dtype)
 assert(same(r:tolist(),{-math.huge,-1.0,-0.2,-0.058823529411764705},3e-12),'weak values true_divide 141')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.true_divide(a,2)
 assert(r.dtype=='float16','weak dtype true_divide 142 '..r.dtype)
 assert(same(r:tolist(),{-1.25,-0.0,0.625,3.5},0.006),'weak values true_divide 142')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.true_divide(2,a)
 assert(r.dtype=='float16','weak dtype true_divide 143 '..r.dtype)
 assert(same(r:tolist(),{-0.7998046875,-math.huge,1.599609375,0.28564453125},0.006),'weak values true_divide 143')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.true_divide(a,2.0)
 assert(r.dtype=='float16','weak dtype true_divide 144 '..r.dtype)
 assert(same(r:tolist(),{-1.25,-0.0,0.625,3.5},0.006),'weak values true_divide 144')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.true_divide(2.0,a)
 assert(r.dtype=='float16','weak dtype true_divide 145 '..r.dtype)
 assert(same(r:tolist(),{-0.7998046875,-math.huge,1.599609375,0.28564453125},0.006),'weak values true_divide 145')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.true_divide(a,2)
 assert(r.dtype=='float32','weak dtype true_divide 146 '..r.dtype)
 assert(same(r:tolist(),{-1.25,-0.0,0.625,3.5},1e-05),'weak values true_divide 146')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.true_divide(2,a)
 assert(r.dtype=='float32','weak dtype true_divide 147 '..r.dtype)
 assert(same(r:tolist(),{-0.800000011920929,-math.huge,1.600000023841858,0.2857142984867096},1e-05),'weak values true_divide 147')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.true_divide(a,2.0)
 assert(r.dtype=='float32','weak dtype true_divide 148 '..r.dtype)
 assert(same(r:tolist(),{-1.25,-0.0,0.625,3.5},1e-05),'weak values true_divide 148')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.true_divide(2.0,a)
 assert(r.dtype=='float32','weak dtype true_divide 149 '..r.dtype)
 assert(same(r:tolist(),{-0.800000011920929,-math.huge,1.600000023841858,0.2857142984867096},1e-05),'weak values true_divide 149')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.true_divide(a,np.complex(0.0,2.0))
 assert(r.dtype=='complex64','weak dtype true_divide 150 '..r.dtype)
 assert(same(r:tolist(),{np.complex(0.0,1.25),np.complex(0.0,0.0),np.complex(0.0,-0.625),np.complex(0.0,-3.5)},1e-05),'weak values true_divide 150')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.true_divide(np.complex(0.0,2.0),a)
 assert(r.dtype=='complex64','weak dtype true_divide 151 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-0.0,-0.800000011920929),np.complex((0/0),math.huge),np.complex(0.0,1.600000023841858),np.complex(0.0,0.2857142984867096)},1e-05),'weak values true_divide 151')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.true_divide(a,2.0)
 assert(r.dtype=='float64','weak dtype true_divide 152 '..r.dtype)
 assert(same(r:tolist(),{-1.25,-0.0,0.625,3.5},3e-12),'weak values true_divide 152')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.true_divide(2.0,a)
 assert(r.dtype=='float64','weak dtype true_divide 153 '..r.dtype)
 assert(same(r:tolist(),{-0.8,-math.huge,1.6,0.2857142857142857},3e-12),'weak values true_divide 153')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.true_divide(a,2)
 assert(r.dtype=='complex64','weak dtype true_divide 154 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-1.25,0.5),np.complex(-0.0,-1.0),np.complex(0.625,0.25),np.complex(3.5,-1.5)},1e-05),'weak values true_divide 154')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.true_divide(2,a)
 assert(r.dtype=='complex64','weak dtype true_divide 155 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-0.6896551251411438,-0.27586206793785095),np.complex(-0.0,1.0),np.complex(1.3793102502822876,-0.5517241358757019),np.complex(0.24137932062149048,0.1034482792019844)},1e-05),'weak values true_divide 155')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.true_divide(a,2.0)
 assert(r.dtype=='complex64','weak dtype true_divide 156 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-1.25,0.5),np.complex(-0.0,-1.0),np.complex(0.625,0.25),np.complex(3.5,-1.5)},1e-05),'weak values true_divide 156')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.true_divide(2.0,a)
 assert(r.dtype=='complex64','weak dtype true_divide 157 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-0.6896551251411438,-0.27586206793785095),np.complex(-0.0,1.0),np.complex(1.3793102502822876,-0.5517241358757019),np.complex(0.24137932062149048,0.1034482792019844)},1e-05),'weak values true_divide 157')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.true_divide(a,np.complex(1.0,2.0))
 assert(r.dtype=='complex64','weak dtype true_divide 158 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-0.10000000149011612,1.2000000476837158),np.complex(-0.800000011920929,-0.4000000059604645),np.complex(0.45000001788139343,-0.4000000059604645),np.complex(0.20000000298023224,-3.4000000953674316)},1e-05),'weak values true_divide 158')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.true_divide(np.complex(1.0,2.0),a)
 assert(r.dtype=='complex64','weak dtype true_divide 159 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-0.06896550953388214,-0.8275861740112305),np.complex(-1.0,0.5),np.complex(1.2413791418075562,1.1034482717514038),np.complex(0.017241379246115685,0.2931034564971924)},1e-05),'weak values true_divide 159')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.equal(a,true)
 assert(r.dtype=='bool','weak dtype equal 160 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,false},0.0),'weak values equal 160')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.equal(true,a)
 assert(r.dtype=='bool','weak dtype equal 161 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,false},0.0),'weak values equal 161')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.equal(a,2)
 assert(r.dtype=='bool','weak dtype equal 162 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 162')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.equal(2,a)
 assert(r.dtype=='bool','weak dtype equal 163 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 163')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.equal(a,2)
 assert(r.dtype=='bool','weak dtype equal 164 '..r.dtype)
 assert(same(r:tolist(),{false,false,true,false},0.0),'weak values equal 164')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.equal(2,a)
 assert(r.dtype=='bool','weak dtype equal 165 '..r.dtype)
 assert(same(r:tolist(),{false,false,true,false},0.0),'weak values equal 165')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.equal(a,-3)
 assert(r.dtype=='bool','weak dtype equal 166 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 166')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.equal(-3,a)
 assert(r.dtype=='bool','weak dtype equal 167 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 167')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.equal(a,2)
 assert(r.dtype=='bool','weak dtype equal 168 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 168')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.equal(2,a)
 assert(r.dtype=='bool','weak dtype equal 169 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 169')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.equal(a,300)
 assert(r.dtype=='bool','weak dtype equal 170 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 170')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.equal(300,a)
 assert(r.dtype=='bool','weak dtype equal 171 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 171')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.equal(a,-1)
 assert(r.dtype=='bool','weak dtype equal 172 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 172')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.equal(-1,a)
 assert(r.dtype=='bool','weak dtype equal 173 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 173')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.equal(a,127)
 assert(r.dtype=='bool','weak dtype equal 174 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 174')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.equal(127,a)
 assert(r.dtype=='bool','weak dtype equal 175 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 175')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.equal(a,5)
 assert(r.dtype=='bool','weak dtype equal 176 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 176')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.equal(5,a)
 assert(r.dtype=='bool','weak dtype equal 177 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 177')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.equal(a,5)
 assert(r.dtype=='bool','weak dtype equal 178 '..r.dtype)
 assert(same(r:tolist(),{false,false,true,false},0.0),'weak values equal 178')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.equal(5,a)
 assert(r.dtype=='bool','weak dtype equal 179 '..r.dtype)
 assert(same(r:tolist(),{false,false,true,false},0.0),'weak values equal 179')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.equal(a,-1)
 assert(r.dtype=='bool','weak dtype equal 180 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 180')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.equal(-1,a)
 assert(r.dtype=='bool','weak dtype equal 181 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 181')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.equal(a,2)
 assert(r.dtype=='bool','weak dtype equal 182 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 182')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.equal(2,a)
 assert(r.dtype=='bool','weak dtype equal 183 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 183')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.equal(a,2.0)
 assert(r.dtype=='bool','weak dtype equal 184 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 184')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.equal(2.0,a)
 assert(r.dtype=='bool','weak dtype equal 185 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 185')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.equal(a,2)
 assert(r.dtype=='bool','weak dtype equal 186 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 186')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.equal(2,a)
 assert(r.dtype=='bool','weak dtype equal 187 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 187')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.equal(a,2.0)
 assert(r.dtype=='bool','weak dtype equal 188 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 188')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.equal(2.0,a)
 assert(r.dtype=='bool','weak dtype equal 189 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 189')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.equal(a,np.complex(0.0,2.0))
 assert(r.dtype=='bool','weak dtype equal 190 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 190')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.equal(np.complex(0.0,2.0),a)
 assert(r.dtype=='bool','weak dtype equal 191 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 191')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.equal(a,2.0)
 assert(r.dtype=='bool','weak dtype equal 192 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 192')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.equal(2.0,a)
 assert(r.dtype=='bool','weak dtype equal 193 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 193')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.equal(a,2)
 assert(r.dtype=='bool','weak dtype equal 194 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 194')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.equal(2,a)
 assert(r.dtype=='bool','weak dtype equal 195 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 195')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.equal(a,2.0)
 assert(r.dtype=='bool','weak dtype equal 196 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 196')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.equal(2.0,a)
 assert(r.dtype=='bool','weak dtype equal 197 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 197')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.equal(a,np.complex(1.0,2.0))
 assert(r.dtype=='bool','weak dtype equal 198 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 198')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.equal(np.complex(1.0,2.0),a)
 assert(r.dtype=='bool','weak dtype equal 199 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values equal 199')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.not_equal(a,true)
 assert(r.dtype=='bool','weak dtype not_equal 200 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,true},0.0),'weak values not_equal 200')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.not_equal(true,a)
 assert(r.dtype=='bool','weak dtype not_equal 201 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,true},0.0),'weak values not_equal 201')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.not_equal(a,2)
 assert(r.dtype=='bool','weak dtype not_equal 202 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 202')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.not_equal(2,a)
 assert(r.dtype=='bool','weak dtype not_equal 203 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 203')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.not_equal(a,2)
 assert(r.dtype=='bool','weak dtype not_equal 204 '..r.dtype)
 assert(same(r:tolist(),{true,true,false,true},0.0),'weak values not_equal 204')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.not_equal(2,a)
 assert(r.dtype=='bool','weak dtype not_equal 205 '..r.dtype)
 assert(same(r:tolist(),{true,true,false,true},0.0),'weak values not_equal 205')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.not_equal(a,-3)
 assert(r.dtype=='bool','weak dtype not_equal 206 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 206')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.not_equal(-3,a)
 assert(r.dtype=='bool','weak dtype not_equal 207 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 207')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.not_equal(a,2)
 assert(r.dtype=='bool','weak dtype not_equal 208 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 208')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.not_equal(2,a)
 assert(r.dtype=='bool','weak dtype not_equal 209 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 209')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.not_equal(a,300)
 assert(r.dtype=='bool','weak dtype not_equal 210 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 210')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.not_equal(300,a)
 assert(r.dtype=='bool','weak dtype not_equal 211 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 211')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.not_equal(a,-1)
 assert(r.dtype=='bool','weak dtype not_equal 212 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 212')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.not_equal(-1,a)
 assert(r.dtype=='bool','weak dtype not_equal 213 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 213')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.not_equal(a,127)
 assert(r.dtype=='bool','weak dtype not_equal 214 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 214')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.not_equal(127,a)
 assert(r.dtype=='bool','weak dtype not_equal 215 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 215')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.not_equal(a,5)
 assert(r.dtype=='bool','weak dtype not_equal 216 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 216')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.not_equal(5,a)
 assert(r.dtype=='bool','weak dtype not_equal 217 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 217')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.not_equal(a,5)
 assert(r.dtype=='bool','weak dtype not_equal 218 '..r.dtype)
 assert(same(r:tolist(),{true,true,false,true},0.0),'weak values not_equal 218')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.not_equal(5,a)
 assert(r.dtype=='bool','weak dtype not_equal 219 '..r.dtype)
 assert(same(r:tolist(),{true,true,false,true},0.0),'weak values not_equal 219')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.not_equal(a,-1)
 assert(r.dtype=='bool','weak dtype not_equal 220 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 220')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.not_equal(-1,a)
 assert(r.dtype=='bool','weak dtype not_equal 221 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 221')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.not_equal(a,2)
 assert(r.dtype=='bool','weak dtype not_equal 222 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 222')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.not_equal(2,a)
 assert(r.dtype=='bool','weak dtype not_equal 223 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 223')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.not_equal(a,2.0)
 assert(r.dtype=='bool','weak dtype not_equal 224 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 224')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.not_equal(2.0,a)
 assert(r.dtype=='bool','weak dtype not_equal 225 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 225')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.not_equal(a,2)
 assert(r.dtype=='bool','weak dtype not_equal 226 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 226')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.not_equal(2,a)
 assert(r.dtype=='bool','weak dtype not_equal 227 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 227')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.not_equal(a,2.0)
 assert(r.dtype=='bool','weak dtype not_equal 228 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 228')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.not_equal(2.0,a)
 assert(r.dtype=='bool','weak dtype not_equal 229 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 229')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.not_equal(a,np.complex(0.0,2.0))
 assert(r.dtype=='bool','weak dtype not_equal 230 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 230')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.not_equal(np.complex(0.0,2.0),a)
 assert(r.dtype=='bool','weak dtype not_equal 231 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 231')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.not_equal(a,2.0)
 assert(r.dtype=='bool','weak dtype not_equal 232 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 232')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.not_equal(2.0,a)
 assert(r.dtype=='bool','weak dtype not_equal 233 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 233')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.not_equal(a,2)
 assert(r.dtype=='bool','weak dtype not_equal 234 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 234')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.not_equal(2,a)
 assert(r.dtype=='bool','weak dtype not_equal 235 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 235')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.not_equal(a,2.0)
 assert(r.dtype=='bool','weak dtype not_equal 236 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 236')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.not_equal(2.0,a)
 assert(r.dtype=='bool','weak dtype not_equal 237 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 237')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.not_equal(a,np.complex(1.0,2.0))
 assert(r.dtype=='bool','weak dtype not_equal 238 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 238')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.not_equal(np.complex(1.0,2.0),a)
 assert(r.dtype=='bool','weak dtype not_equal 239 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values not_equal 239')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.less(a,true)
 assert(r.dtype=='bool','weak dtype less 240 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,true},0.0),'weak values less 240')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.less(true,a)
 assert(r.dtype=='bool','weak dtype less 241 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values less 241')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.less(a,2)
 assert(r.dtype=='bool','weak dtype less 242 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values less 242')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.less(2,a)
 assert(r.dtype=='bool','weak dtype less 243 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values less 243')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.less(a,2)
 assert(r.dtype=='bool','weak dtype less 244 '..r.dtype)
 assert(same(r:tolist(),{true,true,false,false},0.0),'weak values less 244')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.less(2,a)
 assert(r.dtype=='bool','weak dtype less 245 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values less 245')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.less(a,-3)
 assert(r.dtype=='bool','weak dtype less 246 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,false},0.0),'weak values less 246')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.less(-3,a)
 assert(r.dtype=='bool','weak dtype less 247 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,true},0.0),'weak values less 247')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.less(a,2)
 assert(r.dtype=='bool','weak dtype less 248 '..r.dtype)
 assert(same(r:tolist(),{true,true,false,false},0.0),'weak values less 248')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.less(2,a)
 assert(r.dtype=='bool','weak dtype less 249 '..r.dtype)
 assert(same(r:tolist(),{false,false,true,true},0.0),'weak values less 249')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.less(a,300)
 assert(r.dtype=='bool','weak dtype less 250 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values less 250')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.less(300,a)
 assert(r.dtype=='bool','weak dtype less 251 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values less 251')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.less(a,-1)
 assert(r.dtype=='bool','weak dtype less 252 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values less 252')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.less(-1,a)
 assert(r.dtype=='bool','weak dtype less 253 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values less 253')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.less(a,127)
 assert(r.dtype=='bool','weak dtype less 254 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values less 254')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.less(127,a)
 assert(r.dtype=='bool','weak dtype less 255 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values less 255')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.less(a,5)
 assert(r.dtype=='bool','weak dtype less 256 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values less 256')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.less(5,a)
 assert(r.dtype=='bool','weak dtype less 257 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values less 257')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.less(a,5)
 assert(r.dtype=='bool','weak dtype less 258 '..r.dtype)
 assert(same(r:tolist(),{true,true,false,false},0.0),'weak values less 258')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.less(5,a)
 assert(r.dtype=='bool','weak dtype less 259 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values less 259')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.less(a,-1)
 assert(r.dtype=='bool','weak dtype less 260 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values less 260')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.less(-1,a)
 assert(r.dtype=='bool','weak dtype less 261 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values less 261')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.less(a,2)
 assert(r.dtype=='bool','weak dtype less 262 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values less 262')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.less(2,a)
 assert(r.dtype=='bool','weak dtype less 263 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values less 263')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.less(a,2.0)
 assert(r.dtype=='bool','weak dtype less 264 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values less 264')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.less(2.0,a)
 assert(r.dtype=='bool','weak dtype less 265 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values less 265')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.less(a,2)
 assert(r.dtype=='bool','weak dtype less 266 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values less 266')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.less(2,a)
 assert(r.dtype=='bool','weak dtype less 267 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values less 267')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.less(a,2.0)
 assert(r.dtype=='bool','weak dtype less 268 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values less 268')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.less(2.0,a)
 assert(r.dtype=='bool','weak dtype less 269 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values less 269')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.less(a,np.complex(0.0,2.0))
 assert(r.dtype=='bool','weak dtype less 270 '..r.dtype)
 assert(same(r:tolist(),{true,true,false,false},0.0),'weak values less 270')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.less(np.complex(0.0,2.0),a)
 assert(r.dtype=='bool','weak dtype less 271 '..r.dtype)
 assert(same(r:tolist(),{false,false,true,true},0.0),'weak values less 271')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.less(a,2.0)
 assert(r.dtype=='bool','weak dtype less 272 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values less 272')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.less(2.0,a)
 assert(r.dtype=='bool','weak dtype less 273 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values less 273')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.less(a,2)
 assert(r.dtype=='bool','weak dtype less 274 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values less 274')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.less(2,a)
 assert(r.dtype=='bool','weak dtype less 275 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values less 275')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.less(a,2.0)
 assert(r.dtype=='bool','weak dtype less 276 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values less 276')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.less(2.0,a)
 assert(r.dtype=='bool','weak dtype less 277 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values less 277')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.less(a,np.complex(1.0,2.0))
 assert(r.dtype=='bool','weak dtype less 278 '..r.dtype)
 assert(same(r:tolist(),{true,true,false,false},0.0),'weak values less 278')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.less(np.complex(1.0,2.0),a)
 assert(r.dtype=='bool','weak dtype less 279 '..r.dtype)
 assert(same(r:tolist(),{false,false,true,true},0.0),'weak values less 279')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.less_equal(a,true)
 assert(r.dtype=='bool','weak dtype less_equal 280 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values less_equal 280')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.less_equal(true,a)
 assert(r.dtype=='bool','weak dtype less_equal 281 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,false},0.0),'weak values less_equal 281')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.less_equal(a,2)
 assert(r.dtype=='bool','weak dtype less_equal 282 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values less_equal 282')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.less_equal(2,a)
 assert(r.dtype=='bool','weak dtype less_equal 283 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values less_equal 283')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.less_equal(a,2)
 assert(r.dtype=='bool','weak dtype less_equal 284 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values less_equal 284')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.less_equal(2,a)
 assert(r.dtype=='bool','weak dtype less_equal 285 '..r.dtype)
 assert(same(r:tolist(),{false,false,true,true},0.0),'weak values less_equal 285')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.less_equal(a,-3)
 assert(r.dtype=='bool','weak dtype less_equal 286 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,false},0.0),'weak values less_equal 286')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.less_equal(-3,a)
 assert(r.dtype=='bool','weak dtype less_equal 287 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,true},0.0),'weak values less_equal 287')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.less_equal(a,2)
 assert(r.dtype=='bool','weak dtype less_equal 288 '..r.dtype)
 assert(same(r:tolist(),{true,true,false,false},0.0),'weak values less_equal 288')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.less_equal(2,a)
 assert(r.dtype=='bool','weak dtype less_equal 289 '..r.dtype)
 assert(same(r:tolist(),{false,false,true,true},0.0),'weak values less_equal 289')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.less_equal(a,300)
 assert(r.dtype=='bool','weak dtype less_equal 290 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values less_equal 290')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.less_equal(300,a)
 assert(r.dtype=='bool','weak dtype less_equal 291 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values less_equal 291')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.less_equal(a,-1)
 assert(r.dtype=='bool','weak dtype less_equal 292 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values less_equal 292')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.less_equal(-1,a)
 assert(r.dtype=='bool','weak dtype less_equal 293 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values less_equal 293')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.less_equal(a,127)
 assert(r.dtype=='bool','weak dtype less_equal 294 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values less_equal 294')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.less_equal(127,a)
 assert(r.dtype=='bool','weak dtype less_equal 295 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values less_equal 295')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.less_equal(a,5)
 assert(r.dtype=='bool','weak dtype less_equal 296 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values less_equal 296')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.less_equal(5,a)
 assert(r.dtype=='bool','weak dtype less_equal 297 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values less_equal 297')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.less_equal(a,5)
 assert(r.dtype=='bool','weak dtype less_equal 298 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values less_equal 298')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.less_equal(5,a)
 assert(r.dtype=='bool','weak dtype less_equal 299 '..r.dtype)
 assert(same(r:tolist(),{false,false,true,true},0.0),'weak values less_equal 299')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.less_equal(a,-1)
 assert(r.dtype=='bool','weak dtype less_equal 300 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values less_equal 300')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.less_equal(-1,a)
 assert(r.dtype=='bool','weak dtype less_equal 301 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values less_equal 301')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.less_equal(a,2)
 assert(r.dtype=='bool','weak dtype less_equal 302 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values less_equal 302')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.less_equal(2,a)
 assert(r.dtype=='bool','weak dtype less_equal 303 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values less_equal 303')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.less_equal(a,2.0)
 assert(r.dtype=='bool','weak dtype less_equal 304 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values less_equal 304')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.less_equal(2.0,a)
 assert(r.dtype=='bool','weak dtype less_equal 305 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values less_equal 305')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.less_equal(a,2)
 assert(r.dtype=='bool','weak dtype less_equal 306 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values less_equal 306')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.less_equal(2,a)
 assert(r.dtype=='bool','weak dtype less_equal 307 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values less_equal 307')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.less_equal(a,2.0)
 assert(r.dtype=='bool','weak dtype less_equal 308 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values less_equal 308')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.less_equal(2.0,a)
 assert(r.dtype=='bool','weak dtype less_equal 309 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values less_equal 309')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.less_equal(a,np.complex(0.0,2.0))
 assert(r.dtype=='bool','weak dtype less_equal 310 '..r.dtype)
 assert(same(r:tolist(),{true,true,false,false},0.0),'weak values less_equal 310')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.less_equal(np.complex(0.0,2.0),a)
 assert(r.dtype=='bool','weak dtype less_equal 311 '..r.dtype)
 assert(same(r:tolist(),{false,false,true,true},0.0),'weak values less_equal 311')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.less_equal(a,2.0)
 assert(r.dtype=='bool','weak dtype less_equal 312 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values less_equal 312')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.less_equal(2.0,a)
 assert(r.dtype=='bool','weak dtype less_equal 313 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values less_equal 313')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.less_equal(a,2)
 assert(r.dtype=='bool','weak dtype less_equal 314 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values less_equal 314')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.less_equal(2,a)
 assert(r.dtype=='bool','weak dtype less_equal 315 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values less_equal 315')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.less_equal(a,2.0)
 assert(r.dtype=='bool','weak dtype less_equal 316 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values less_equal 316')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.less_equal(2.0,a)
 assert(r.dtype=='bool','weak dtype less_equal 317 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values less_equal 317')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.less_equal(a,np.complex(1.0,2.0))
 assert(r.dtype=='bool','weak dtype less_equal 318 '..r.dtype)
 assert(same(r:tolist(),{true,true,false,false},0.0),'weak values less_equal 318')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.less_equal(np.complex(1.0,2.0),a)
 assert(r.dtype=='bool','weak dtype less_equal 319 '..r.dtype)
 assert(same(r:tolist(),{false,false,true,true},0.0),'weak values less_equal 319')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.greater(a,true)
 assert(r.dtype=='bool','weak dtype greater 320 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values greater 320')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.greater(true,a)
 assert(r.dtype=='bool','weak dtype greater 321 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,true},0.0),'weak values greater 321')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.greater(a,2)
 assert(r.dtype=='bool','weak dtype greater 322 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values greater 322')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.greater(2,a)
 assert(r.dtype=='bool','weak dtype greater 323 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values greater 323')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.greater(a,2)
 assert(r.dtype=='bool','weak dtype greater 324 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values greater 324')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.greater(2,a)
 assert(r.dtype=='bool','weak dtype greater 325 '..r.dtype)
 assert(same(r:tolist(),{true,true,false,false},0.0),'weak values greater 325')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.greater(a,-3)
 assert(r.dtype=='bool','weak dtype greater 326 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,true},0.0),'weak values greater 326')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.greater(-3,a)
 assert(r.dtype=='bool','weak dtype greater 327 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,false},0.0),'weak values greater 327')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.greater(a,2)
 assert(r.dtype=='bool','weak dtype greater 328 '..r.dtype)
 assert(same(r:tolist(),{false,false,true,true},0.0),'weak values greater 328')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.greater(2,a)
 assert(r.dtype=='bool','weak dtype greater 329 '..r.dtype)
 assert(same(r:tolist(),{true,true,false,false},0.0),'weak values greater 329')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.greater(a,300)
 assert(r.dtype=='bool','weak dtype greater 330 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values greater 330')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.greater(300,a)
 assert(r.dtype=='bool','weak dtype greater 331 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values greater 331')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.greater(a,-1)
 assert(r.dtype=='bool','weak dtype greater 332 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values greater 332')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.greater(-1,a)
 assert(r.dtype=='bool','weak dtype greater 333 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values greater 333')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.greater(a,127)
 assert(r.dtype=='bool','weak dtype greater 334 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values greater 334')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.greater(127,a)
 assert(r.dtype=='bool','weak dtype greater 335 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values greater 335')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.greater(a,5)
 assert(r.dtype=='bool','weak dtype greater 336 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values greater 336')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.greater(5,a)
 assert(r.dtype=='bool','weak dtype greater 337 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values greater 337')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.greater(a,5)
 assert(r.dtype=='bool','weak dtype greater 338 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values greater 338')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.greater(5,a)
 assert(r.dtype=='bool','weak dtype greater 339 '..r.dtype)
 assert(same(r:tolist(),{true,true,false,false},0.0),'weak values greater 339')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.greater(a,-1)
 assert(r.dtype=='bool','weak dtype greater 340 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values greater 340')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.greater(-1,a)
 assert(r.dtype=='bool','weak dtype greater 341 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values greater 341')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.greater(a,2)
 assert(r.dtype=='bool','weak dtype greater 342 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values greater 342')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.greater(2,a)
 assert(r.dtype=='bool','weak dtype greater 343 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values greater 343')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.greater(a,2.0)
 assert(r.dtype=='bool','weak dtype greater 344 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values greater 344')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.greater(2.0,a)
 assert(r.dtype=='bool','weak dtype greater 345 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values greater 345')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.greater(a,2)
 assert(r.dtype=='bool','weak dtype greater 346 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values greater 346')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.greater(2,a)
 assert(r.dtype=='bool','weak dtype greater 347 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values greater 347')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.greater(a,2.0)
 assert(r.dtype=='bool','weak dtype greater 348 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values greater 348')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.greater(2.0,a)
 assert(r.dtype=='bool','weak dtype greater 349 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values greater 349')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.greater(a,np.complex(0.0,2.0))
 assert(r.dtype=='bool','weak dtype greater 350 '..r.dtype)
 assert(same(r:tolist(),{false,false,true,true},0.0),'weak values greater 350')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.greater(np.complex(0.0,2.0),a)
 assert(r.dtype=='bool','weak dtype greater 351 '..r.dtype)
 assert(same(r:tolist(),{true,true,false,false},0.0),'weak values greater 351')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.greater(a,2.0)
 assert(r.dtype=='bool','weak dtype greater 352 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values greater 352')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.greater(2.0,a)
 assert(r.dtype=='bool','weak dtype greater 353 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values greater 353')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.greater(a,2)
 assert(r.dtype=='bool','weak dtype greater 354 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values greater 354')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.greater(2,a)
 assert(r.dtype=='bool','weak dtype greater 355 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values greater 355')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.greater(a,2.0)
 assert(r.dtype=='bool','weak dtype greater 356 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values greater 356')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.greater(2.0,a)
 assert(r.dtype=='bool','weak dtype greater 357 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values greater 357')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.greater(a,np.complex(1.0,2.0))
 assert(r.dtype=='bool','weak dtype greater 358 '..r.dtype)
 assert(same(r:tolist(),{false,false,true,true},0.0),'weak values greater 358')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.greater(np.complex(1.0,2.0),a)
 assert(r.dtype=='bool','weak dtype greater 359 '..r.dtype)
 assert(same(r:tolist(),{true,true,false,false},0.0),'weak values greater 359')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.greater_equal(a,true)
 assert(r.dtype=='bool','weak dtype greater_equal 360 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,false},0.0),'weak values greater_equal 360')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.greater_equal(true,a)
 assert(r.dtype=='bool','weak dtype greater_equal 361 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values greater_equal 361')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.greater_equal(a,2)
 assert(r.dtype=='bool','weak dtype greater_equal 362 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values greater_equal 362')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.greater_equal(2,a)
 assert(r.dtype=='bool','weak dtype greater_equal 363 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values greater_equal 363')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.greater_equal(a,2)
 assert(r.dtype=='bool','weak dtype greater_equal 364 '..r.dtype)
 assert(same(r:tolist(),{false,false,true,true},0.0),'weak values greater_equal 364')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.greater_equal(2,a)
 assert(r.dtype=='bool','weak dtype greater_equal 365 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values greater_equal 365')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.greater_equal(a,-3)
 assert(r.dtype=='bool','weak dtype greater_equal 366 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,true},0.0),'weak values greater_equal 366')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.greater_equal(-3,a)
 assert(r.dtype=='bool','weak dtype greater_equal 367 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,false},0.0),'weak values greater_equal 367')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.greater_equal(a,2)
 assert(r.dtype=='bool','weak dtype greater_equal 368 '..r.dtype)
 assert(same(r:tolist(),{false,false,true,true},0.0),'weak values greater_equal 368')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.greater_equal(2,a)
 assert(r.dtype=='bool','weak dtype greater_equal 369 '..r.dtype)
 assert(same(r:tolist(),{true,true,false,false},0.0),'weak values greater_equal 369')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.greater_equal(a,300)
 assert(r.dtype=='bool','weak dtype greater_equal 370 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values greater_equal 370')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.greater_equal(300,a)
 assert(r.dtype=='bool','weak dtype greater_equal 371 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values greater_equal 371')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.greater_equal(a,-1)
 assert(r.dtype=='bool','weak dtype greater_equal 372 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values greater_equal 372')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.greater_equal(-1,a)
 assert(r.dtype=='bool','weak dtype greater_equal 373 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values greater_equal 373')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.greater_equal(a,127)
 assert(r.dtype=='bool','weak dtype greater_equal 374 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values greater_equal 374')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.greater_equal(127,a)
 assert(r.dtype=='bool','weak dtype greater_equal 375 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values greater_equal 375')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.greater_equal(a,5)
 assert(r.dtype=='bool','weak dtype greater_equal 376 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values greater_equal 376')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.greater_equal(5,a)
 assert(r.dtype=='bool','weak dtype greater_equal 377 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values greater_equal 377')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.greater_equal(a,5)
 assert(r.dtype=='bool','weak dtype greater_equal 378 '..r.dtype)
 assert(same(r:tolist(),{false,false,true,true},0.0),'weak values greater_equal 378')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.greater_equal(5,a)
 assert(r.dtype=='bool','weak dtype greater_equal 379 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values greater_equal 379')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.greater_equal(a,-1)
 assert(r.dtype=='bool','weak dtype greater_equal 380 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values greater_equal 380')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.greater_equal(-1,a)
 assert(r.dtype=='bool','weak dtype greater_equal 381 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values greater_equal 381')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.greater_equal(a,2)
 assert(r.dtype=='bool','weak dtype greater_equal 382 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values greater_equal 382')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.greater_equal(2,a)
 assert(r.dtype=='bool','weak dtype greater_equal 383 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values greater_equal 383')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.greater_equal(a,2.0)
 assert(r.dtype=='bool','weak dtype greater_equal 384 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values greater_equal 384')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.greater_equal(2.0,a)
 assert(r.dtype=='bool','weak dtype greater_equal 385 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values greater_equal 385')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.greater_equal(a,2)
 assert(r.dtype=='bool','weak dtype greater_equal 386 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values greater_equal 386')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.greater_equal(2,a)
 assert(r.dtype=='bool','weak dtype greater_equal 387 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values greater_equal 387')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.greater_equal(a,2.0)
 assert(r.dtype=='bool','weak dtype greater_equal 388 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values greater_equal 388')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.greater_equal(2.0,a)
 assert(r.dtype=='bool','weak dtype greater_equal 389 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values greater_equal 389')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.greater_equal(a,np.complex(0.0,2.0))
 assert(r.dtype=='bool','weak dtype greater_equal 390 '..r.dtype)
 assert(same(r:tolist(),{false,false,true,true},0.0),'weak values greater_equal 390')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.greater_equal(np.complex(0.0,2.0),a)
 assert(r.dtype=='bool','weak dtype greater_equal 391 '..r.dtype)
 assert(same(r:tolist(),{true,true,false,false},0.0),'weak values greater_equal 391')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.greater_equal(a,2.0)
 assert(r.dtype=='bool','weak dtype greater_equal 392 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values greater_equal 392')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.greater_equal(2.0,a)
 assert(r.dtype=='bool','weak dtype greater_equal 393 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values greater_equal 393')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.greater_equal(a,2)
 assert(r.dtype=='bool','weak dtype greater_equal 394 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values greater_equal 394')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.greater_equal(2,a)
 assert(r.dtype=='bool','weak dtype greater_equal 395 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values greater_equal 395')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.greater_equal(a,2.0)
 assert(r.dtype=='bool','weak dtype greater_equal 396 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,true},0.0),'weak values greater_equal 396')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.greater_equal(2.0,a)
 assert(r.dtype=='bool','weak dtype greater_equal 397 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,false},0.0),'weak values greater_equal 397')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.greater_equal(a,np.complex(1.0,2.0))
 assert(r.dtype=='bool','weak dtype greater_equal 398 '..r.dtype)
 assert(same(r:tolist(),{false,false,true,true},0.0),'weak values greater_equal 398')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.greater_equal(np.complex(1.0,2.0),a)
 assert(r.dtype=='bool','weak dtype greater_equal 399 '..r.dtype)
 assert(same(r:tolist(),{true,true,false,false},0.0),'weak values greater_equal 399')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.logical_and(a,true)
 assert(r.dtype=='bool','weak dtype logical_and 400 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,false},0.0),'weak values logical_and 400')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.logical_and(true,a)
 assert(r.dtype=='bool','weak dtype logical_and 401 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,false},0.0),'weak values logical_and 401')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.logical_and(a,2)
 assert(r.dtype=='bool','weak dtype logical_and 402 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,false},0.0),'weak values logical_and 402')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.logical_and(2,a)
 assert(r.dtype=='bool','weak dtype logical_and 403 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,false},0.0),'weak values logical_and 403')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.logical_and(a,2)
 assert(r.dtype=='bool','weak dtype logical_and 404 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_and 404')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.logical_and(2,a)
 assert(r.dtype=='bool','weak dtype logical_and 405 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_and 405')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.logical_and(a,-3)
 assert(r.dtype=='bool','weak dtype logical_and 406 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_and 406')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.logical_and(-3,a)
 assert(r.dtype=='bool','weak dtype logical_and 407 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_and 407')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.logical_and(a,2)
 assert(r.dtype=='bool','weak dtype logical_and 408 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,true},0.0),'weak values logical_and 408')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.logical_and(2,a)
 assert(r.dtype=='bool','weak dtype logical_and 409 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,true},0.0),'weak values logical_and 409')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.logical_and(a,300)
 assert(r.dtype=='bool','weak dtype logical_and 410 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,true},0.0),'weak values logical_and 410')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.logical_and(300,a)
 assert(r.dtype=='bool','weak dtype logical_and 411 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,true},0.0),'weak values logical_and 411')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.logical_and(a,-1)
 assert(r.dtype=='bool','weak dtype logical_and 412 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,true},0.0),'weak values logical_and 412')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.logical_and(-1,a)
 assert(r.dtype=='bool','weak dtype logical_and 413 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,true},0.0),'weak values logical_and 413')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.logical_and(a,127)
 assert(r.dtype=='bool','weak dtype logical_and 414 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_and 414')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.logical_and(127,a)
 assert(r.dtype=='bool','weak dtype logical_and 415 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_and 415')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.logical_and(a,5)
 assert(r.dtype=='bool','weak dtype logical_and 416 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_and 416')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.logical_and(5,a)
 assert(r.dtype=='bool','weak dtype logical_and 417 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_and 417')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.logical_and(a,5)
 assert(r.dtype=='bool','weak dtype logical_and 418 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,true},0.0),'weak values logical_and 418')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.logical_and(5,a)
 assert(r.dtype=='bool','weak dtype logical_and 419 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,true},0.0),'weak values logical_and 419')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.logical_and(a,-1)
 assert(r.dtype=='bool','weak dtype logical_and 420 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,true},0.0),'weak values logical_and 420')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.logical_and(-1,a)
 assert(r.dtype=='bool','weak dtype logical_and 421 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,true},0.0),'weak values logical_and 421')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.logical_and(a,2)
 assert(r.dtype=='bool','weak dtype logical_and 422 '..r.dtype)
 assert(same(r:tolist(),{true,false,true,true},0.0),'weak values logical_and 422')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.logical_and(2,a)
 assert(r.dtype=='bool','weak dtype logical_and 423 '..r.dtype)
 assert(same(r:tolist(),{true,false,true,true},0.0),'weak values logical_and 423')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.logical_and(a,2.0)
 assert(r.dtype=='bool','weak dtype logical_and 424 '..r.dtype)
 assert(same(r:tolist(),{true,false,true,true},0.0),'weak values logical_and 424')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.logical_and(2.0,a)
 assert(r.dtype=='bool','weak dtype logical_and 425 '..r.dtype)
 assert(same(r:tolist(),{true,false,true,true},0.0),'weak values logical_and 425')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.logical_and(a,2)
 assert(r.dtype=='bool','weak dtype logical_and 426 '..r.dtype)
 assert(same(r:tolist(),{true,false,true,true},0.0),'weak values logical_and 426')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.logical_and(2,a)
 assert(r.dtype=='bool','weak dtype logical_and 427 '..r.dtype)
 assert(same(r:tolist(),{true,false,true,true},0.0),'weak values logical_and 427')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.logical_and(a,2.0)
 assert(r.dtype=='bool','weak dtype logical_and 428 '..r.dtype)
 assert(same(r:tolist(),{true,false,true,true},0.0),'weak values logical_and 428')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.logical_and(2.0,a)
 assert(r.dtype=='bool','weak dtype logical_and 429 '..r.dtype)
 assert(same(r:tolist(),{true,false,true,true},0.0),'weak values logical_and 429')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.logical_and(a,np.complex(0.0,2.0))
 assert(r.dtype=='bool','weak dtype logical_and 430 '..r.dtype)
 assert(same(r:tolist(),{true,false,true,true},0.0),'weak values logical_and 430')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.logical_and(np.complex(0.0,2.0),a)
 assert(r.dtype=='bool','weak dtype logical_and 431 '..r.dtype)
 assert(same(r:tolist(),{true,false,true,true},0.0),'weak values logical_and 431')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.logical_and(a,2.0)
 assert(r.dtype=='bool','weak dtype logical_and 432 '..r.dtype)
 assert(same(r:tolist(),{true,false,true,true},0.0),'weak values logical_and 432')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.logical_and(2.0,a)
 assert(r.dtype=='bool','weak dtype logical_and 433 '..r.dtype)
 assert(same(r:tolist(),{true,false,true,true},0.0),'weak values logical_and 433')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.logical_and(a,2)
 assert(r.dtype=='bool','weak dtype logical_and 434 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_and 434')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.logical_and(2,a)
 assert(r.dtype=='bool','weak dtype logical_and 435 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_and 435')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.logical_and(a,2.0)
 assert(r.dtype=='bool','weak dtype logical_and 436 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_and 436')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.logical_and(2.0,a)
 assert(r.dtype=='bool','weak dtype logical_and 437 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_and 437')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.logical_and(a,np.complex(1.0,2.0))
 assert(r.dtype=='bool','weak dtype logical_and 438 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_and 438')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.logical_and(np.complex(1.0,2.0),a)
 assert(r.dtype=='bool','weak dtype logical_and 439 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_and 439')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.logical_or(a,true)
 assert(r.dtype=='bool','weak dtype logical_or 440 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 440')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.logical_or(true,a)
 assert(r.dtype=='bool','weak dtype logical_or 441 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 441')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.logical_or(a,2)
 assert(r.dtype=='bool','weak dtype logical_or 442 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 442')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.logical_or(2,a)
 assert(r.dtype=='bool','weak dtype logical_or 443 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 443')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.logical_or(a,2)
 assert(r.dtype=='bool','weak dtype logical_or 444 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 444')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.logical_or(2,a)
 assert(r.dtype=='bool','weak dtype logical_or 445 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 445')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.logical_or(a,-3)
 assert(r.dtype=='bool','weak dtype logical_or 446 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 446')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.logical_or(-3,a)
 assert(r.dtype=='bool','weak dtype logical_or 447 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 447')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.logical_or(a,2)
 assert(r.dtype=='bool','weak dtype logical_or 448 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 448')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.logical_or(2,a)
 assert(r.dtype=='bool','weak dtype logical_or 449 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 449')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.logical_or(a,300)
 assert(r.dtype=='bool','weak dtype logical_or 450 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 450')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.logical_or(300,a)
 assert(r.dtype=='bool','weak dtype logical_or 451 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 451')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.logical_or(a,-1)
 assert(r.dtype=='bool','weak dtype logical_or 452 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 452')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.logical_or(-1,a)
 assert(r.dtype=='bool','weak dtype logical_or 453 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 453')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.logical_or(a,127)
 assert(r.dtype=='bool','weak dtype logical_or 454 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 454')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.logical_or(127,a)
 assert(r.dtype=='bool','weak dtype logical_or 455 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 455')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.logical_or(a,5)
 assert(r.dtype=='bool','weak dtype logical_or 456 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 456')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.logical_or(5,a)
 assert(r.dtype=='bool','weak dtype logical_or 457 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 457')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.logical_or(a,5)
 assert(r.dtype=='bool','weak dtype logical_or 458 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 458')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.logical_or(5,a)
 assert(r.dtype=='bool','weak dtype logical_or 459 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 459')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.logical_or(a,-1)
 assert(r.dtype=='bool','weak dtype logical_or 460 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 460')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.logical_or(-1,a)
 assert(r.dtype=='bool','weak dtype logical_or 461 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 461')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.logical_or(a,2)
 assert(r.dtype=='bool','weak dtype logical_or 462 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 462')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.logical_or(2,a)
 assert(r.dtype=='bool','weak dtype logical_or 463 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 463')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.logical_or(a,2.0)
 assert(r.dtype=='bool','weak dtype logical_or 464 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 464')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.logical_or(2.0,a)
 assert(r.dtype=='bool','weak dtype logical_or 465 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 465')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.logical_or(a,2)
 assert(r.dtype=='bool','weak dtype logical_or 466 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 466')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.logical_or(2,a)
 assert(r.dtype=='bool','weak dtype logical_or 467 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 467')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.logical_or(a,2.0)
 assert(r.dtype=='bool','weak dtype logical_or 468 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 468')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.logical_or(2.0,a)
 assert(r.dtype=='bool','weak dtype logical_or 469 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 469')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.logical_or(a,np.complex(0.0,2.0))
 assert(r.dtype=='bool','weak dtype logical_or 470 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 470')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.logical_or(np.complex(0.0,2.0),a)
 assert(r.dtype=='bool','weak dtype logical_or 471 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 471')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.logical_or(a,2.0)
 assert(r.dtype=='bool','weak dtype logical_or 472 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 472')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.logical_or(2.0,a)
 assert(r.dtype=='bool','weak dtype logical_or 473 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 473')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.logical_or(a,2)
 assert(r.dtype=='bool','weak dtype logical_or 474 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 474')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.logical_or(2,a)
 assert(r.dtype=='bool','weak dtype logical_or 475 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 475')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.logical_or(a,2.0)
 assert(r.dtype=='bool','weak dtype logical_or 476 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 476')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.logical_or(2.0,a)
 assert(r.dtype=='bool','weak dtype logical_or 477 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 477')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.logical_or(a,np.complex(1.0,2.0))
 assert(r.dtype=='bool','weak dtype logical_or 478 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 478')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.logical_or(np.complex(1.0,2.0),a)
 assert(r.dtype=='bool','weak dtype logical_or 479 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values logical_or 479')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.logical_xor(a,true)
 assert(r.dtype=='bool','weak dtype logical_xor 480 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,true},0.0),'weak values logical_xor 480')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.logical_xor(true,a)
 assert(r.dtype=='bool','weak dtype logical_xor 481 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,true},0.0),'weak values logical_xor 481')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.logical_xor(a,2)
 assert(r.dtype=='bool','weak dtype logical_xor 482 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,true},0.0),'weak values logical_xor 482')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.logical_xor(2,a)
 assert(r.dtype=='bool','weak dtype logical_xor 483 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,true},0.0),'weak values logical_xor 483')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.logical_xor(a,2)
 assert(r.dtype=='bool','weak dtype logical_xor 484 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values logical_xor 484')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.logical_xor(2,a)
 assert(r.dtype=='bool','weak dtype logical_xor 485 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values logical_xor 485')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.logical_xor(a,-3)
 assert(r.dtype=='bool','weak dtype logical_xor 486 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values logical_xor 486')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.logical_xor(-3,a)
 assert(r.dtype=='bool','weak dtype logical_xor 487 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values logical_xor 487')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.logical_xor(a,2)
 assert(r.dtype=='bool','weak dtype logical_xor 488 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,false},0.0),'weak values logical_xor 488')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.logical_xor(2,a)
 assert(r.dtype=='bool','weak dtype logical_xor 489 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,false},0.0),'weak values logical_xor 489')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.logical_xor(a,300)
 assert(r.dtype=='bool','weak dtype logical_xor 490 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,false},0.0),'weak values logical_xor 490')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.logical_xor(300,a)
 assert(r.dtype=='bool','weak dtype logical_xor 491 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,false},0.0),'weak values logical_xor 491')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.logical_xor(a,-1)
 assert(r.dtype=='bool','weak dtype logical_xor 492 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,false},0.0),'weak values logical_xor 492')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.logical_xor(-1,a)
 assert(r.dtype=='bool','weak dtype logical_xor 493 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,false},0.0),'weak values logical_xor 493')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.logical_xor(a,127)
 assert(r.dtype=='bool','weak dtype logical_xor 494 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values logical_xor 494')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.logical_xor(127,a)
 assert(r.dtype=='bool','weak dtype logical_xor 495 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values logical_xor 495')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.logical_xor(a,5)
 assert(r.dtype=='bool','weak dtype logical_xor 496 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values logical_xor 496')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.logical_xor(5,a)
 assert(r.dtype=='bool','weak dtype logical_xor 497 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values logical_xor 497')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.logical_xor(a,5)
 assert(r.dtype=='bool','weak dtype logical_xor 498 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,false},0.0),'weak values logical_xor 498')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.logical_xor(5,a)
 assert(r.dtype=='bool','weak dtype logical_xor 499 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,false},0.0),'weak values logical_xor 499')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.logical_xor(a,-1)
 assert(r.dtype=='bool','weak dtype logical_xor 500 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,false},0.0),'weak values logical_xor 500')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.logical_xor(-1,a)
 assert(r.dtype=='bool','weak dtype logical_xor 501 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,false},0.0),'weak values logical_xor 501')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.logical_xor(a,2)
 assert(r.dtype=='bool','weak dtype logical_xor 502 '..r.dtype)
 assert(same(r:tolist(),{false,true,false,false},0.0),'weak values logical_xor 502')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.logical_xor(2,a)
 assert(r.dtype=='bool','weak dtype logical_xor 503 '..r.dtype)
 assert(same(r:tolist(),{false,true,false,false},0.0),'weak values logical_xor 503')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.logical_xor(a,2.0)
 assert(r.dtype=='bool','weak dtype logical_xor 504 '..r.dtype)
 assert(same(r:tolist(),{false,true,false,false},0.0),'weak values logical_xor 504')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.logical_xor(2.0,a)
 assert(r.dtype=='bool','weak dtype logical_xor 505 '..r.dtype)
 assert(same(r:tolist(),{false,true,false,false},0.0),'weak values logical_xor 505')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.logical_xor(a,2)
 assert(r.dtype=='bool','weak dtype logical_xor 506 '..r.dtype)
 assert(same(r:tolist(),{false,true,false,false},0.0),'weak values logical_xor 506')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.logical_xor(2,a)
 assert(r.dtype=='bool','weak dtype logical_xor 507 '..r.dtype)
 assert(same(r:tolist(),{false,true,false,false},0.0),'weak values logical_xor 507')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.logical_xor(a,2.0)
 assert(r.dtype=='bool','weak dtype logical_xor 508 '..r.dtype)
 assert(same(r:tolist(),{false,true,false,false},0.0),'weak values logical_xor 508')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.logical_xor(2.0,a)
 assert(r.dtype=='bool','weak dtype logical_xor 509 '..r.dtype)
 assert(same(r:tolist(),{false,true,false,false},0.0),'weak values logical_xor 509')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.logical_xor(a,np.complex(0.0,2.0))
 assert(r.dtype=='bool','weak dtype logical_xor 510 '..r.dtype)
 assert(same(r:tolist(),{false,true,false,false},0.0),'weak values logical_xor 510')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.logical_xor(np.complex(0.0,2.0),a)
 assert(r.dtype=='bool','weak dtype logical_xor 511 '..r.dtype)
 assert(same(r:tolist(),{false,true,false,false},0.0),'weak values logical_xor 511')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.logical_xor(a,2.0)
 assert(r.dtype=='bool','weak dtype logical_xor 512 '..r.dtype)
 assert(same(r:tolist(),{false,true,false,false},0.0),'weak values logical_xor 512')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.logical_xor(2.0,a)
 assert(r.dtype=='bool','weak dtype logical_xor 513 '..r.dtype)
 assert(same(r:tolist(),{false,true,false,false},0.0),'weak values logical_xor 513')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.logical_xor(a,2)
 assert(r.dtype=='bool','weak dtype logical_xor 514 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values logical_xor 514')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.logical_xor(2,a)
 assert(r.dtype=='bool','weak dtype logical_xor 515 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values logical_xor 515')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.logical_xor(a,2.0)
 assert(r.dtype=='bool','weak dtype logical_xor 516 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values logical_xor 516')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.logical_xor(2.0,a)
 assert(r.dtype=='bool','weak dtype logical_xor 517 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values logical_xor 517')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.logical_xor(a,np.complex(1.0,2.0))
 assert(r.dtype=='bool','weak dtype logical_xor 518 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values logical_xor 518')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.logical_xor(np.complex(1.0,2.0),a)
 assert(r.dtype=='bool','weak dtype logical_xor 519 '..r.dtype)
 assert(same(r:tolist(),{false,false,false,false},0.0),'weak values logical_xor 519')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.maximum(a,true)
 assert(r.dtype=='bool','weak dtype maximum 520 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values maximum 520')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.maximum(true,a)
 assert(r.dtype=='bool','weak dtype maximum 521 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values maximum 521')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.maximum(a,2)
 assert(r.dtype=='int64','weak dtype maximum 522 '..r.dtype)
 assert(same(r:tolist(),{2,2,2,2},0.0),'weak values maximum 522')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.maximum(2,a)
 assert(r.dtype=='int64','weak dtype maximum 523 '..r.dtype)
 assert(same(r:tolist(),{2,2,2,2},0.0),'weak values maximum 523')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.maximum(a,2)
 assert(r.dtype=='int8','weak dtype maximum 524 '..r.dtype)
 assert(same(r:tolist(),{2,2,2,11},0.0),'weak values maximum 524')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.maximum(2,a)
 assert(r.dtype=='int8','weak dtype maximum 525 '..r.dtype)
 assert(same(r:tolist(),{2,2,2,11},0.0),'weak values maximum 525')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.maximum(a,-3)
 assert(r.dtype=='int8','weak dtype maximum 526 '..r.dtype)
 assert(same(r:tolist(),{-3,-1,2,11},0.0),'weak values maximum 526')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.maximum(-3,a)
 assert(r.dtype=='int8','weak dtype maximum 527 '..r.dtype)
 assert(same(r:tolist(),{-3,-1,2,11},0.0),'weak values maximum 527')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.maximum(a,2)
 assert(r.dtype=='uint8','weak dtype maximum 528 '..r.dtype)
 assert(same(r:tolist(),{2,2,5,17},0.0),'weak values maximum 528')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.maximum(2,a)
 assert(r.dtype=='uint8','weak dtype maximum 529 '..r.dtype)
 assert(same(r:tolist(),{2,2,5,17},0.0),'weak values maximum 529')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.maximum(a,300) end)
 assert(not ok,'weak reject maximum 530')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.maximum(300,a) end)
 assert(not ok,'weak reject maximum 531')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.maximum(a,-1) end)
 assert(not ok,'weak reject maximum 532')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.maximum(-1,a) end)
 assert(not ok,'weak reject maximum 533')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.maximum(a,127)
 assert(r.dtype=='int16','weak dtype maximum 534 '..r.dtype)
 assert(same(r:tolist(),{127,127,127,127},0.0),'weak values maximum 534')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.maximum(127,a)
 assert(r.dtype=='int16','weak dtype maximum 535 '..r.dtype)
 assert(same(r:tolist(),{127,127,127,127},0.0),'weak values maximum 535')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.maximum(a,5)
 assert(r.dtype=='int64','weak dtype maximum 536 '..r.dtype)
 assert(same(r:tolist(),{5,5,5,11},0.0),'weak values maximum 536')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.maximum(5,a)
 assert(r.dtype=='int64','weak dtype maximum 537 '..r.dtype)
 assert(same(r:tolist(),{5,5,5,11},0.0),'weak values maximum 537')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.maximum(a,5)
 assert(r.dtype=='uint64','weak dtype maximum 538 '..r.dtype)
 assert(same(r:tolist(),{5,5,5,17},0.0),'weak values maximum 538')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.maximum(5,a)
 assert(r.dtype=='uint64','weak dtype maximum 539 '..r.dtype)
 assert(same(r:tolist(),{5,5,5,17},0.0),'weak values maximum 539')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.maximum(a,-1) end)
 assert(not ok,'weak reject maximum 540')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.maximum(-1,a) end)
 assert(not ok,'weak reject maximum 541')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.maximum(a,2)
 assert(r.dtype=='float16','weak dtype maximum 542 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.0,2.0,7.0},0.006),'weak values maximum 542')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.maximum(2,a)
 assert(r.dtype=='float16','weak dtype maximum 543 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.0,2.0,7.0},0.006),'weak values maximum 543')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.maximum(a,2.0)
 assert(r.dtype=='float16','weak dtype maximum 544 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.0,2.0,7.0},0.006),'weak values maximum 544')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.maximum(2.0,a)
 assert(r.dtype=='float16','weak dtype maximum 545 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.0,2.0,7.0},0.006),'weak values maximum 545')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.maximum(a,2)
 assert(r.dtype=='float32','weak dtype maximum 546 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.0,2.0,7.0},1e-05),'weak values maximum 546')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.maximum(2,a)
 assert(r.dtype=='float32','weak dtype maximum 547 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.0,2.0,7.0},1e-05),'weak values maximum 547')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.maximum(a,2.0)
 assert(r.dtype=='float32','weak dtype maximum 548 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.0,2.0,7.0},1e-05),'weak values maximum 548')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.maximum(2.0,a)
 assert(r.dtype=='float32','weak dtype maximum 549 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.0,2.0,7.0},1e-05),'weak values maximum 549')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.maximum(a,np.complex(0.0,2.0))
 assert(r.dtype=='complex64','weak dtype maximum 550 '..r.dtype)
 assert(same(r:tolist(),{np.complex(0.0,2.0),np.complex(0.0,2.0),np.complex(1.25,0.0),np.complex(7.0,0.0)},1e-05),'weak values maximum 550')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.maximum(np.complex(0.0,2.0),a)
 assert(r.dtype=='complex64','weak dtype maximum 551 '..r.dtype)
 assert(same(r:tolist(),{np.complex(0.0,2.0),np.complex(0.0,2.0),np.complex(1.25,0.0),np.complex(7.0,0.0)},1e-05),'weak values maximum 551')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.maximum(a,2.0)
 assert(r.dtype=='float64','weak dtype maximum 552 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.0,2.0,7.0},3e-12),'weak values maximum 552')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.maximum(2.0,a)
 assert(r.dtype=='float64','weak dtype maximum 553 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.0,2.0,7.0},3e-12),'weak values maximum 553')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.maximum(a,2)
 assert(r.dtype=='complex64','weak dtype maximum 554 '..r.dtype)
 assert(same(r:tolist(),{np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(7.0,-3.0)},1e-05),'weak values maximum 554')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.maximum(2,a)
 assert(r.dtype=='complex64','weak dtype maximum 555 '..r.dtype)
 assert(same(r:tolist(),{np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(7.0,-3.0)},1e-05),'weak values maximum 555')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.maximum(a,2.0)
 assert(r.dtype=='complex64','weak dtype maximum 556 '..r.dtype)
 assert(same(r:tolist(),{np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(7.0,-3.0)},1e-05),'weak values maximum 556')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.maximum(2.0,a)
 assert(r.dtype=='complex64','weak dtype maximum 557 '..r.dtype)
 assert(same(r:tolist(),{np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(7.0,-3.0)},1e-05),'weak values maximum 557')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.maximum(a,np.complex(1.0,2.0))
 assert(r.dtype=='complex64','weak dtype maximum 558 '..r.dtype)
 assert(same(r:tolist(),{np.complex(1.0,2.0),np.complex(1.0,2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},1e-05),'weak values maximum 558')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.maximum(np.complex(1.0,2.0),a)
 assert(r.dtype=='complex64','weak dtype maximum 559 '..r.dtype)
 assert(same(r:tolist(),{np.complex(1.0,2.0),np.complex(1.0,2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},1e-05),'weak values maximum 559')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.minimum(a,true)
 assert(r.dtype=='bool','weak dtype minimum 560 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,false},0.0),'weak values minimum 560')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.minimum(true,a)
 assert(r.dtype=='bool','weak dtype minimum 561 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,false},0.0),'weak values minimum 561')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.minimum(a,2)
 assert(r.dtype=='int64','weak dtype minimum 562 '..r.dtype)
 assert(same(r:tolist(),{0,1,1,0},0.0),'weak values minimum 562')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.minimum(2,a)
 assert(r.dtype=='int64','weak dtype minimum 563 '..r.dtype)
 assert(same(r:tolist(),{0,1,1,0},0.0),'weak values minimum 563')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.minimum(a,2)
 assert(r.dtype=='int8','weak dtype minimum 564 '..r.dtype)
 assert(same(r:tolist(),{-7,-1,2,2},0.0),'weak values minimum 564')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.minimum(2,a)
 assert(r.dtype=='int8','weak dtype minimum 565 '..r.dtype)
 assert(same(r:tolist(),{-7,-1,2,2},0.0),'weak values minimum 565')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.minimum(a,-3)
 assert(r.dtype=='int8','weak dtype minimum 566 '..r.dtype)
 assert(same(r:tolist(),{-7,-3,-3,-3},0.0),'weak values minimum 566')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.minimum(-3,a)
 assert(r.dtype=='int8','weak dtype minimum 567 '..r.dtype)
 assert(same(r:tolist(),{-7,-3,-3,-3},0.0),'weak values minimum 567')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.minimum(a,2)
 assert(r.dtype=='uint8','weak dtype minimum 568 '..r.dtype)
 assert(same(r:tolist(),{0,1,2,2},0.0),'weak values minimum 568')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.minimum(2,a)
 assert(r.dtype=='uint8','weak dtype minimum 569 '..r.dtype)
 assert(same(r:tolist(),{0,1,2,2},0.0),'weak values minimum 569')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.minimum(a,300) end)
 assert(not ok,'weak reject minimum 570')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.minimum(300,a) end)
 assert(not ok,'weak reject minimum 571')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.minimum(a,-1) end)
 assert(not ok,'weak reject minimum 572')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.minimum(-1,a) end)
 assert(not ok,'weak reject minimum 573')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.minimum(a,127)
 assert(r.dtype=='int16','weak dtype minimum 574 '..r.dtype)
 assert(same(r:tolist(),{-7,-1,2,11},0.0),'weak values minimum 574')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.minimum(127,a)
 assert(r.dtype=='int16','weak dtype minimum 575 '..r.dtype)
 assert(same(r:tolist(),{-7,-1,2,11},0.0),'weak values minimum 575')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.minimum(a,5)
 assert(r.dtype=='int64','weak dtype minimum 576 '..r.dtype)
 assert(same(r:tolist(),{-7,-1,2,5},0.0),'weak values minimum 576')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.minimum(5,a)
 assert(r.dtype=='int64','weak dtype minimum 577 '..r.dtype)
 assert(same(r:tolist(),{-7,-1,2,5},0.0),'weak values minimum 577')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.minimum(a,5)
 assert(r.dtype=='uint64','weak dtype minimum 578 '..r.dtype)
 assert(same(r:tolist(),{0,1,5,5},0.0),'weak values minimum 578')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.minimum(5,a)
 assert(r.dtype=='uint64','weak dtype minimum 579 '..r.dtype)
 assert(same(r:tolist(),{0,1,5,5},0.0),'weak values minimum 579')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.minimum(a,-1) end)
 assert(not ok,'weak reject minimum 580')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.minimum(-1,a) end)
 assert(not ok,'weak reject minimum 581')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.minimum(a,2)
 assert(r.dtype=='float16','weak dtype minimum 582 '..r.dtype)
 assert(same(r:tolist(),{-2.5,-0.0,1.25,2.0},0.006),'weak values minimum 582')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.minimum(2,a)
 assert(r.dtype=='float16','weak dtype minimum 583 '..r.dtype)
 assert(same(r:tolist(),{-2.5,-0.0,1.25,2.0},0.006),'weak values minimum 583')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.minimum(a,2.0)
 assert(r.dtype=='float16','weak dtype minimum 584 '..r.dtype)
 assert(same(r:tolist(),{-2.5,-0.0,1.25,2.0},0.006),'weak values minimum 584')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.minimum(2.0,a)
 assert(r.dtype=='float16','weak dtype minimum 585 '..r.dtype)
 assert(same(r:tolist(),{-2.5,-0.0,1.25,2.0},0.006),'weak values minimum 585')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.minimum(a,2)
 assert(r.dtype=='float32','weak dtype minimum 586 '..r.dtype)
 assert(same(r:tolist(),{-2.5,-0.0,1.25,2.0},1e-05),'weak values minimum 586')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.minimum(2,a)
 assert(r.dtype=='float32','weak dtype minimum 587 '..r.dtype)
 assert(same(r:tolist(),{-2.5,-0.0,1.25,2.0},1e-05),'weak values minimum 587')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.minimum(a,2.0)
 assert(r.dtype=='float32','weak dtype minimum 588 '..r.dtype)
 assert(same(r:tolist(),{-2.5,-0.0,1.25,2.0},1e-05),'weak values minimum 588')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.minimum(2.0,a)
 assert(r.dtype=='float32','weak dtype minimum 589 '..r.dtype)
 assert(same(r:tolist(),{-2.5,-0.0,1.25,2.0},1e-05),'weak values minimum 589')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.minimum(a,np.complex(0.0,2.0))
 assert(r.dtype=='complex64','weak dtype minimum 590 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-2.5,0.0),np.complex(-0.0,0.0),np.complex(0.0,2.0),np.complex(0.0,2.0)},1e-05),'weak values minimum 590')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.minimum(np.complex(0.0,2.0),a)
 assert(r.dtype=='complex64','weak dtype minimum 591 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-2.5,0.0),np.complex(-0.0,0.0),np.complex(0.0,2.0),np.complex(0.0,2.0)},1e-05),'weak values minimum 591')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.minimum(a,2.0)
 assert(r.dtype=='float64','weak dtype minimum 592 '..r.dtype)
 assert(same(r:tolist(),{-2.5,-0.0,1.25,2.0},3e-12),'weak values minimum 592')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.minimum(2.0,a)
 assert(r.dtype=='float64','weak dtype minimum 593 '..r.dtype)
 assert(same(r:tolist(),{-2.5,-0.0,1.25,2.0},3e-12),'weak values minimum 593')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.minimum(a,2)
 assert(r.dtype=='complex64','weak dtype minimum 594 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(2.0,0.0)},1e-05),'weak values minimum 594')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.minimum(2,a)
 assert(r.dtype=='complex64','weak dtype minimum 595 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(2.0,0.0)},1e-05),'weak values minimum 595')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.minimum(a,2.0)
 assert(r.dtype=='complex64','weak dtype minimum 596 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(2.0,0.0)},1e-05),'weak values minimum 596')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.minimum(2.0,a)
 assert(r.dtype=='complex64','weak dtype minimum 597 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(2.0,0.0)},1e-05),'weak values minimum 597')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.minimum(a,np.complex(1.0,2.0))
 assert(r.dtype=='complex64','weak dtype minimum 598 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.0,2.0),np.complex(1.0,2.0)},1e-05),'weak values minimum 598')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.minimum(np.complex(1.0,2.0),a)
 assert(r.dtype=='complex64','weak dtype minimum 599 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.0,2.0),np.complex(1.0,2.0)},1e-05),'weak values minimum 599')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.floor_divide(a,true)
 assert(r.dtype=='int8','weak dtype floor_divide 600 '..r.dtype)
 assert(same(r:tolist(),{0,1,1,0},0.0),'weak values floor_divide 600')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.floor_divide(true,a)
 assert(r.dtype=='int8','weak dtype floor_divide 601 '..r.dtype)
 assert(same(r:tolist(),{0,1,1,0},0.0),'weak values floor_divide 601')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.floor_divide(a,2)
 assert(r.dtype=='int64','weak dtype floor_divide 602 '..r.dtype)
 assert(same(r:tolist(),{0,0,0,0},0.0),'weak values floor_divide 602')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.floor_divide(2,a)
 assert(r.dtype=='int64','weak dtype floor_divide 603 '..r.dtype)
 assert(same(r:tolist(),{0,2,2,0},0.0),'weak values floor_divide 603')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.floor_divide(a,2)
 assert(r.dtype=='int8','weak dtype floor_divide 604 '..r.dtype)
 assert(same(r:tolist(),{-4,-1,1,5},0.0),'weak values floor_divide 604')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.floor_divide(2,a)
 assert(r.dtype=='int8','weak dtype floor_divide 605 '..r.dtype)
 assert(same(r:tolist(),{-1,-2,1,0},0.0),'weak values floor_divide 605')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.floor_divide(a,-3)
 assert(r.dtype=='int8','weak dtype floor_divide 606 '..r.dtype)
 assert(same(r:tolist(),{2,0,-1,-4},0.0),'weak values floor_divide 606')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.floor_divide(-3,a)
 assert(r.dtype=='int8','weak dtype floor_divide 607 '..r.dtype)
 assert(same(r:tolist(),{0,3,-2,-1},0.0),'weak values floor_divide 607')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.floor_divide(a,2)
 assert(r.dtype=='uint8','weak dtype floor_divide 608 '..r.dtype)
 assert(same(r:tolist(),{0,0,2,8},0.0),'weak values floor_divide 608')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.floor_divide(2,a)
 assert(r.dtype=='uint8','weak dtype floor_divide 609 '..r.dtype)
 assert(same(r:tolist(),{0,2,0,0},0.0),'weak values floor_divide 609')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.floor_divide(a,300) end)
 assert(not ok,'weak reject floor_divide 610')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.floor_divide(300,a) end)
 assert(not ok,'weak reject floor_divide 611')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.floor_divide(a,-1) end)
 assert(not ok,'weak reject floor_divide 612')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.floor_divide(-1,a) end)
 assert(not ok,'weak reject floor_divide 613')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.floor_divide(a,127)
 assert(r.dtype=='int16','weak dtype floor_divide 614 '..r.dtype)
 assert(same(r:tolist(),{-1,-1,0,0},0.0),'weak values floor_divide 614')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.floor_divide(127,a)
 assert(r.dtype=='int16','weak dtype floor_divide 615 '..r.dtype)
 assert(same(r:tolist(),{-19,-127,63,11},0.0),'weak values floor_divide 615')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.floor_divide(a,5)
 assert(r.dtype=='int64','weak dtype floor_divide 616 '..r.dtype)
 assert(same(r:tolist(),{-2,-1,0,2},0.0),'weak values floor_divide 616')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.floor_divide(5,a)
 assert(r.dtype=='int64','weak dtype floor_divide 617 '..r.dtype)
 assert(same(r:tolist(),{-1,-5,2,0},0.0),'weak values floor_divide 617')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.floor_divide(a,5)
 assert(r.dtype=='uint64','weak dtype floor_divide 618 '..r.dtype)
 assert(same(r:tolist(),{0,0,1,3},0.0),'weak values floor_divide 618')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.floor_divide(5,a)
 assert(r.dtype=='uint64','weak dtype floor_divide 619 '..r.dtype)
 assert(same(r:tolist(),{0,5,1,0},0.0),'weak values floor_divide 619')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.floor_divide(a,-1) end)
 assert(not ok,'weak reject floor_divide 620')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.floor_divide(-1,a) end)
 assert(not ok,'weak reject floor_divide 621')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.floor_divide(a,2)
 assert(r.dtype=='float16','weak dtype floor_divide 622 '..r.dtype)
 assert(same(r:tolist(),{-2.0,-0.0,0.0,3.0},0.006),'weak values floor_divide 622')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.floor_divide(2,a)
 assert(r.dtype=='float16','weak dtype floor_divide 623 '..r.dtype)
 assert(same(r:tolist(),{-1.0,-math.huge,1.0,0.0},0.006),'weak values floor_divide 623')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.floor_divide(a,2.0)
 assert(r.dtype=='float16','weak dtype floor_divide 624 '..r.dtype)
 assert(same(r:tolist(),{-2.0,-0.0,0.0,3.0},0.006),'weak values floor_divide 624')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.floor_divide(2.0,a)
 assert(r.dtype=='float16','weak dtype floor_divide 625 '..r.dtype)
 assert(same(r:tolist(),{-1.0,-math.huge,1.0,0.0},0.006),'weak values floor_divide 625')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.floor_divide(a,2)
 assert(r.dtype=='float32','weak dtype floor_divide 626 '..r.dtype)
 assert(same(r:tolist(),{-2.0,-0.0,0.0,3.0},1e-05),'weak values floor_divide 626')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.floor_divide(2,a)
 assert(r.dtype=='float32','weak dtype floor_divide 627 '..r.dtype)
 assert(same(r:tolist(),{-1.0,-math.huge,1.0,0.0},1e-05),'weak values floor_divide 627')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.floor_divide(a,2.0)
 assert(r.dtype=='float32','weak dtype floor_divide 628 '..r.dtype)
 assert(same(r:tolist(),{-2.0,-0.0,0.0,3.0},1e-05),'weak values floor_divide 628')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.floor_divide(2.0,a)
 assert(r.dtype=='float32','weak dtype floor_divide 629 '..r.dtype)
 assert(same(r:tolist(),{-1.0,-math.huge,1.0,0.0},1e-05),'weak values floor_divide 629')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.floor_divide(a,np.complex(0.0,2.0)) end)
 assert(not ok,'weak reject floor_divide 630')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.floor_divide(np.complex(0.0,2.0),a) end)
 assert(not ok,'weak reject floor_divide 631')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.floor_divide(a,2.0)
 assert(r.dtype=='float64','weak dtype floor_divide 632 '..r.dtype)
 assert(same(r:tolist(),{-2.0,-0.0,0.0,3.0},3e-12),'weak values floor_divide 632')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.floor_divide(2.0,a)
 assert(r.dtype=='float64','weak dtype floor_divide 633 '..r.dtype)
 assert(same(r:tolist(),{-1.0,-math.huge,1.0,0.0},3e-12),'weak values floor_divide 633')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.floor_divide(a,2) end)
 assert(not ok,'weak reject floor_divide 634')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.floor_divide(2,a) end)
 assert(not ok,'weak reject floor_divide 635')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.floor_divide(a,2.0) end)
 assert(not ok,'weak reject floor_divide 636')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.floor_divide(2.0,a) end)
 assert(not ok,'weak reject floor_divide 637')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.floor_divide(a,np.complex(1.0,2.0)) end)
 assert(not ok,'weak reject floor_divide 638')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.floor_divide(np.complex(1.0,2.0),a) end)
 assert(not ok,'weak reject floor_divide 639')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.remainder(a,true)
 assert(r.dtype=='int8','weak dtype remainder 640 '..r.dtype)
 assert(same(r:tolist(),{0,0,0,0},0.0),'weak values remainder 640')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.remainder(true,a)
 assert(r.dtype=='int8','weak dtype remainder 641 '..r.dtype)
 assert(same(r:tolist(),{0,0,0,0},0.0),'weak values remainder 641')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.remainder(a,2)
 assert(r.dtype=='int64','weak dtype remainder 642 '..r.dtype)
 assert(same(r:tolist(),{0,1,1,0},0.0),'weak values remainder 642')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.remainder(2,a)
 assert(r.dtype=='int64','weak dtype remainder 643 '..r.dtype)
 assert(same(r:tolist(),{0,0,0,0},0.0),'weak values remainder 643')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.remainder(a,2)
 assert(r.dtype=='int8','weak dtype remainder 644 '..r.dtype)
 assert(same(r:tolist(),{1,1,0,1},0.0),'weak values remainder 644')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.remainder(2,a)
 assert(r.dtype=='int8','weak dtype remainder 645 '..r.dtype)
 assert(same(r:tolist(),{-5,0,0,2},0.0),'weak values remainder 645')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.remainder(a,-3)
 assert(r.dtype=='int8','weak dtype remainder 646 '..r.dtype)
 assert(same(r:tolist(),{-1,-1,-1,-1},0.0),'weak values remainder 646')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.remainder(-3,a)
 assert(r.dtype=='int8','weak dtype remainder 647 '..r.dtype)
 assert(same(r:tolist(),{-3,0,1,8},0.0),'weak values remainder 647')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.remainder(a,2)
 assert(r.dtype=='uint8','weak dtype remainder 648 '..r.dtype)
 assert(same(r:tolist(),{0,1,1,1},0.0),'weak values remainder 648')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.remainder(2,a)
 assert(r.dtype=='uint8','weak dtype remainder 649 '..r.dtype)
 assert(same(r:tolist(),{0,0,2,2},0.0),'weak values remainder 649')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.remainder(a,300) end)
 assert(not ok,'weak reject remainder 650')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.remainder(300,a) end)
 assert(not ok,'weak reject remainder 651')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.remainder(a,-1) end)
 assert(not ok,'weak reject remainder 652')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.remainder(-1,a) end)
 assert(not ok,'weak reject remainder 653')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.remainder(a,127)
 assert(r.dtype=='int16','weak dtype remainder 654 '..r.dtype)
 assert(same(r:tolist(),{120,126,2,11},0.0),'weak values remainder 654')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.remainder(127,a)
 assert(r.dtype=='int16','weak dtype remainder 655 '..r.dtype)
 assert(same(r:tolist(),{-6,0,1,6},0.0),'weak values remainder 655')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.remainder(a,5)
 assert(r.dtype=='int64','weak dtype remainder 656 '..r.dtype)
 assert(same(r:tolist(),{3,4,2,1},0.0),'weak values remainder 656')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.remainder(5,a)
 assert(r.dtype=='int64','weak dtype remainder 657 '..r.dtype)
 assert(same(r:tolist(),{-2,0,1,5},0.0),'weak values remainder 657')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.remainder(a,5)
 assert(r.dtype=='uint64','weak dtype remainder 658 '..r.dtype)
 assert(same(r:tolist(),{0,1,0,2},0.0),'weak values remainder 658')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.remainder(5,a)
 assert(r.dtype=='uint64','weak dtype remainder 659 '..r.dtype)
 assert(same(r:tolist(),{0,0,0,5},0.0),'weak values remainder 659')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.remainder(a,-1) end)
 assert(not ok,'weak reject remainder 660')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.remainder(-1,a) end)
 assert(not ok,'weak reject remainder 661')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.remainder(a,2)
 assert(r.dtype=='float16','weak dtype remainder 662 '..r.dtype)
 assert(same(r:tolist(),{1.5,0.0,1.25,1.0},0.006),'weak values remainder 662')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.remainder(2,a)
 assert(r.dtype=='float16','weak dtype remainder 663 '..r.dtype)
 assert(same(r:tolist(),{-0.5,(0/0),0.75,2.0},0.006),'weak values remainder 663')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.remainder(a,2.0)
 assert(r.dtype=='float16','weak dtype remainder 664 '..r.dtype)
 assert(same(r:tolist(),{1.5,0.0,1.25,1.0},0.006),'weak values remainder 664')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.remainder(2.0,a)
 assert(r.dtype=='float16','weak dtype remainder 665 '..r.dtype)
 assert(same(r:tolist(),{-0.5,(0/0),0.75,2.0},0.006),'weak values remainder 665')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.remainder(a,2)
 assert(r.dtype=='float32','weak dtype remainder 666 '..r.dtype)
 assert(same(r:tolist(),{1.5,0.0,1.25,1.0},1e-05),'weak values remainder 666')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.remainder(2,a)
 assert(r.dtype=='float32','weak dtype remainder 667 '..r.dtype)
 assert(same(r:tolist(),{-0.5,(0/0),0.75,2.0},1e-05),'weak values remainder 667')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.remainder(a,2.0)
 assert(r.dtype=='float32','weak dtype remainder 668 '..r.dtype)
 assert(same(r:tolist(),{1.5,0.0,1.25,1.0},1e-05),'weak values remainder 668')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.remainder(2.0,a)
 assert(r.dtype=='float32','weak dtype remainder 669 '..r.dtype)
 assert(same(r:tolist(),{-0.5,(0/0),0.75,2.0},1e-05),'weak values remainder 669')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.remainder(a,np.complex(0.0,2.0)) end)
 assert(not ok,'weak reject remainder 670')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.remainder(np.complex(0.0,2.0),a) end)
 assert(not ok,'weak reject remainder 671')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.remainder(a,2.0)
 assert(r.dtype=='float64','weak dtype remainder 672 '..r.dtype)
 assert(same(r:tolist(),{1.5,0.0,1.25,1.0},3e-12),'weak values remainder 672')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.remainder(2.0,a)
 assert(r.dtype=='float64','weak dtype remainder 673 '..r.dtype)
 assert(same(r:tolist(),{-0.5,(0/0),0.75,2.0},3e-12),'weak values remainder 673')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.remainder(a,2) end)
 assert(not ok,'weak reject remainder 674')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.remainder(2,a) end)
 assert(not ok,'weak reject remainder 675')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.remainder(a,2.0) end)
 assert(not ok,'weak reject remainder 676')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.remainder(2.0,a) end)
 assert(not ok,'weak reject remainder 677')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.remainder(a,np.complex(1.0,2.0)) end)
 assert(not ok,'weak reject remainder 678')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.remainder(np.complex(1.0,2.0),a) end)
 assert(not ok,'weak reject remainder 679')
end
do
 local a=np.array({false,true,true,true},np.bool)
 local r=np.power(a,true)
 assert(r.dtype=='int8','weak dtype power 680 '..r.dtype)
 assert(same(r:tolist(),{0,1,1,1},0.0),'weak values power 680')
end
do
 local a=np.array({false,true,true,true},np.bool)
 local r=np.power(true,a)
 assert(r.dtype=='int8','weak dtype power 681 '..r.dtype)
 assert(same(r:tolist(),{1,1,1,1},0.0),'weak values power 681')
end
do
 local a=np.array({false,true,true,true},np.bool)
 local r=np.power(a,2)
 assert(r.dtype=='int64','weak dtype power 682 '..r.dtype)
 assert(same(r:tolist(),{0,1,1,1},0.0),'weak values power 682')
end
do
 local a=np.array({false,true,true,true},np.bool)
 local r=np.power(2,a)
 assert(r.dtype=='int64','weak dtype power 683 '..r.dtype)
 assert(same(r:tolist(),{1,2,2,2},0.0),'weak values power 683')
end
do
 local a=np.array({0,1,2,3},np.int8)
 local r=np.power(a,2)
 assert(r.dtype=='int8','weak dtype power 684 '..r.dtype)
 assert(same(r:tolist(),{0,1,4,9},0.0),'weak values power 684')
end
do
 local a=np.array({0,1,2,3},np.int8)
 local r=np.power(2,a)
 assert(r.dtype=='int8','weak dtype power 685 '..r.dtype)
 assert(same(r:tolist(),{1,2,4,8},0.0),'weak values power 685')
end
do
 local a=np.array({0,1,2,3},np.int8)
 local ok=pcall(function() return np.power(a,-3) end)
 assert(not ok,'weak reject power 686')
end
do
 local a=np.array({0,1,2,3},np.int8)
 local r=np.power(-3,a)
 assert(r.dtype=='int8','weak dtype power 687 '..r.dtype)
 assert(same(r:tolist(),{1,-3,9,-27},0.0),'weak values power 687')
end
do
 local a=np.array({0,1,2,3},np.uint8)
 local r=np.power(a,2)
 assert(r.dtype=='uint8','weak dtype power 688 '..r.dtype)
 assert(same(r:tolist(),{0,1,4,9},0.0),'weak values power 688')
end
do
 local a=np.array({0,1,2,3},np.uint8)
 local r=np.power(2,a)
 assert(r.dtype=='uint8','weak dtype power 689 '..r.dtype)
 assert(same(r:tolist(),{1,2,4,8},0.0),'weak values power 689')
end
do
 local a=np.array({0,1,2,3},np.uint8)
 local ok=pcall(function() return np.power(a,300) end)
 assert(not ok,'weak reject power 690')
end
do
 local a=np.array({0,1,2,3},np.uint8)
 local ok=pcall(function() return np.power(300,a) end)
 assert(not ok,'weak reject power 691')
end
do
 local a=np.array({0,1,2,3},np.uint8)
 local ok=pcall(function() return np.power(a,-1) end)
 assert(not ok,'weak reject power 692')
end
do
 local a=np.array({0,1,2,3},np.uint8)
 local ok=pcall(function() return np.power(-1,a) end)
 assert(not ok,'weak reject power 693')
end
do
 local a=np.array({0,1,2,3},np.int16)
 local r=np.power(a,127)
 assert(r.dtype=='int16','weak dtype power 694 '..r.dtype)
 assert(same(r:tolist(),{0,1,0,10411},0.0),'weak values power 694')
end
do
 local a=np.array({0,1,2,3},np.int16)
 local r=np.power(127,a)
 assert(r.dtype=='int16','weak dtype power 695 '..r.dtype)
 assert(same(r:tolist(),{1,127,16129,16767},0.0),'weak values power 695')
end
do
 local a=np.array({0,1,2,3},np.int64)
 local r=np.power(a,5)
 assert(r.dtype=='int64','weak dtype power 696 '..r.dtype)
 assert(same(r:tolist(),{0,1,32,243},0.0),'weak values power 696')
end
do
 local a=np.array({0,1,2,3},np.int64)
 local r=np.power(5,a)
 assert(r.dtype=='int64','weak dtype power 697 '..r.dtype)
 assert(same(r:tolist(),{1,5,25,125},0.0),'weak values power 697')
end
do
 local a=np.array({0,1,2,3},np.uint64)
 local r=np.power(a,5)
 assert(r.dtype=='uint64','weak dtype power 698 '..r.dtype)
 assert(same(r:tolist(),{0,1,32,243},0.0),'weak values power 698')
end
do
 local a=np.array({0,1,2,3},np.uint64)
 local r=np.power(5,a)
 assert(r.dtype=='uint64','weak dtype power 699 '..r.dtype)
 assert(same(r:tolist(),{1,5,25,125},0.0),'weak values power 699')
end
do
 local a=np.array({0,1,2,3},np.uint64)
 local ok=pcall(function() return np.power(a,-1) end)
 assert(not ok,'weak reject power 700')
end
do
 local a=np.array({0,1,2,3},np.uint64)
 local ok=pcall(function() return np.power(-1,a) end)
 assert(not ok,'weak reject power 701')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.power(a,2)
 assert(r.dtype=='float16','weak dtype power 702 '..r.dtype)
 assert(same(r:tolist(),{6.25,0.0,1.5625,49.0},0.006),'weak values power 702')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.power(2,a)
 assert(r.dtype=='float16','weak dtype power 703 '..r.dtype)
 assert(same(r:tolist(),{0.1767578125,1.0,2.37890625,128.0},0.006),'weak values power 703')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.power(a,2.0)
 assert(r.dtype=='float16','weak dtype power 704 '..r.dtype)
 assert(same(r:tolist(),{6.25,0.0,1.5625,49.0},0.006),'weak values power 704')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.power(2.0,a)
 assert(r.dtype=='float16','weak dtype power 705 '..r.dtype)
 assert(same(r:tolist(),{0.1767578125,1.0,2.37890625,128.0},0.006),'weak values power 705')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.power(a,2)
 assert(r.dtype=='float32','weak dtype power 706 '..r.dtype)
 assert(same(r:tolist(),{6.25,0.0,1.5625,49.0},1e-05),'weak values power 706')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.power(2,a)
 assert(r.dtype=='float32','weak dtype power 707 '..r.dtype)
 assert(same(r:tolist(),{0.1767766922712326,1.0,2.3784141540527344,128.0},1e-05),'weak values power 707')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.power(a,2.0)
 assert(r.dtype=='float32','weak dtype power 708 '..r.dtype)
 assert(same(r:tolist(),{6.25,0.0,1.5625,49.0},1e-05),'weak values power 708')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.power(2.0,a)
 assert(r.dtype=='float32','weak dtype power 709 '..r.dtype)
 assert(same(r:tolist(),{0.1767766922712326,1.0,2.3784141540527344,128.0},1e-05),'weak values power 709')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.power(a,np.complex(0.0,2.0))
 assert(r.dtype=='complex64','weak dtype power 710 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-0.0004833040584344417,0.001803817693144083),np.complex((0/0),(0/0)),np.complex(0.9020558595657349,0.431619256734848),np.complex(-0.7315337657928467,-0.6818052530288696)},1e-05),'weak values power 710')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.power(np.complex(0.0,2.0),a)
 assert(r.dtype=='complex64','weak dtype power 711 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-0.12499997764825821,0.1250000149011612),np.complex(1.0,0.0),np.complex(-0.9101799130439758,2.1973681449890137),np.complex(-0.0,-128.0)},1e-05),'weak values power 711')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.power(a,2.0)
 assert(r.dtype=='float64','weak dtype power 712 '..r.dtype)
 assert(same(r:tolist(),{6.25,0.0,1.5625,49.0},3e-12),'weak values power 712')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.power(2.0,a)
 assert(r.dtype=='float64','weak dtype power 713 '..r.dtype)
 assert(same(r:tolist(),{0.1767766952966369,1.0,2.378414230005442,128.0},3e-12),'weak values power 713')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.power(a,2)
 assert(r.dtype=='complex64','weak dtype power 714 '..r.dtype)
 assert(same(r:tolist(),{np.complex(5.25,-5.0),np.complex(-4.0,0.0),np.complex(1.3125,1.25),np.complex(40.0,-42.0)},1e-05),'weak values power 714')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.power(2,a)
 assert(r.dtype=='complex64','weak dtype power 715 '..r.dtype)
 assert(same(r:tolist(),{np.complex(0.13598351180553436,0.11295345425605774),np.complex(0.18345697224140167,-0.9830277562141418),np.complex(2.2369985580444336,0.8078928589820862),np.complex(-62.33528518676758,-111.79585266113281)},1e-05),'weak values power 715')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.power(a,2.0)
 assert(r.dtype=='complex64','weak dtype power 716 '..r.dtype)
 assert(same(r:tolist(),{np.complex(5.25,-5.0),np.complex(-4.0,0.0),np.complex(1.3125,1.25),np.complex(40.0,-42.0)},1e-05),'weak values power 716')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.power(2.0,a)
 assert(r.dtype=='complex64','weak dtype power 717 '..r.dtype)
 assert(same(r:tolist(),{np.complex(0.13598351180553436,0.11295345425605774),np.complex(0.18345697224140167,-0.9830277562141418),np.complex(2.2369985580444336,0.8078928589820862),np.complex(-62.33528518676758,-111.79585266113281)},1e-05),'weak values power 717')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.power(a,np.complex(1.0,2.0))
 assert(r.dtype=='complex64','weak dtype power 718 '..r.dtype)
 assert(same(r:tolist(),{np.complex(0.00031959210173226893,-0.010757924988865852),np.complex(45.49589157104492,-8.490646362304688),np.complex(0.35285112261772156,0.5206815600395203),np.complex(-14.904571533203125,-8.414634704589844)},1e-05),'weak values power 718')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.power(np.complex(1.0,2.0),a)
 assert(r.dtype=='complex64','weak dtype power 719 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-0.016902046278119087,-0.040844716131687164),np.complex(-0.3536750376224518,-9.148141860961914),np.complex(-0.3361404538154602,1.5356019735336304),np.complex(4520.66162109375,-6285.685546875)},1e-05),'weak values power 719')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.bitwise_and(a,true)
 assert(r.dtype=='bool','weak dtype bitwise_and 720 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,false},0.0),'weak values bitwise_and 720')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.bitwise_and(true,a)
 assert(r.dtype=='bool','weak dtype bitwise_and 721 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,false},0.0),'weak values bitwise_and 721')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.bitwise_and(a,2)
 assert(r.dtype=='int64','weak dtype bitwise_and 722 '..r.dtype)
 assert(same(r:tolist(),{0,0,0,0},0.0),'weak values bitwise_and 722')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.bitwise_and(2,a)
 assert(r.dtype=='int64','weak dtype bitwise_and 723 '..r.dtype)
 assert(same(r:tolist(),{0,0,0,0},0.0),'weak values bitwise_and 723')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.bitwise_and(a,2)
 assert(r.dtype=='int8','weak dtype bitwise_and 724 '..r.dtype)
 assert(same(r:tolist(),{0,2,2,2},0.0),'weak values bitwise_and 724')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.bitwise_and(2,a)
 assert(r.dtype=='int8','weak dtype bitwise_and 725 '..r.dtype)
 assert(same(r:tolist(),{0,2,2,2},0.0),'weak values bitwise_and 725')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.bitwise_and(a,-3)
 assert(r.dtype=='int8','weak dtype bitwise_and 726 '..r.dtype)
 assert(same(r:tolist(),{-7,-3,0,9},0.0),'weak values bitwise_and 726')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.bitwise_and(-3,a)
 assert(r.dtype=='int8','weak dtype bitwise_and 727 '..r.dtype)
 assert(same(r:tolist(),{-7,-3,0,9},0.0),'weak values bitwise_and 727')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.bitwise_and(a,2)
 assert(r.dtype=='uint8','weak dtype bitwise_and 728 '..r.dtype)
 assert(same(r:tolist(),{0,0,0,0},0.0),'weak values bitwise_and 728')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.bitwise_and(2,a)
 assert(r.dtype=='uint8','weak dtype bitwise_and 729 '..r.dtype)
 assert(same(r:tolist(),{0,0,0,0},0.0),'weak values bitwise_and 729')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.bitwise_and(a,300) end)
 assert(not ok,'weak reject bitwise_and 730')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.bitwise_and(300,a) end)
 assert(not ok,'weak reject bitwise_and 731')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.bitwise_and(a,-1) end)
 assert(not ok,'weak reject bitwise_and 732')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.bitwise_and(-1,a) end)
 assert(not ok,'weak reject bitwise_and 733')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.bitwise_and(a,127)
 assert(r.dtype=='int16','weak dtype bitwise_and 734 '..r.dtype)
 assert(same(r:tolist(),{121,127,2,11},0.0),'weak values bitwise_and 734')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.bitwise_and(127,a)
 assert(r.dtype=='int16','weak dtype bitwise_and 735 '..r.dtype)
 assert(same(r:tolist(),{121,127,2,11},0.0),'weak values bitwise_and 735')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.bitwise_and(a,5)
 assert(r.dtype=='int64','weak dtype bitwise_and 736 '..r.dtype)
 assert(same(r:tolist(),{1,5,0,1},0.0),'weak values bitwise_and 736')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.bitwise_and(5,a)
 assert(r.dtype=='int64','weak dtype bitwise_and 737 '..r.dtype)
 assert(same(r:tolist(),{1,5,0,1},0.0),'weak values bitwise_and 737')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.bitwise_and(a,5)
 assert(r.dtype=='uint64','weak dtype bitwise_and 738 '..r.dtype)
 assert(same(r:tolist(),{0,1,5,1},0.0),'weak values bitwise_and 738')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.bitwise_and(5,a)
 assert(r.dtype=='uint64','weak dtype bitwise_and 739 '..r.dtype)
 assert(same(r:tolist(),{0,1,5,1},0.0),'weak values bitwise_and 739')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.bitwise_and(a,-1) end)
 assert(not ok,'weak reject bitwise_and 740')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.bitwise_and(-1,a) end)
 assert(not ok,'weak reject bitwise_and 741')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local ok=pcall(function() return np.bitwise_and(a,2) end)
 assert(not ok,'weak reject bitwise_and 742')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local ok=pcall(function() return np.bitwise_and(2,a) end)
 assert(not ok,'weak reject bitwise_and 743')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local ok=pcall(function() return np.bitwise_and(a,2.0) end)
 assert(not ok,'weak reject bitwise_and 744')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local ok=pcall(function() return np.bitwise_and(2.0,a) end)
 assert(not ok,'weak reject bitwise_and 745')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.bitwise_and(a,2) end)
 assert(not ok,'weak reject bitwise_and 746')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.bitwise_and(2,a) end)
 assert(not ok,'weak reject bitwise_and 747')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.bitwise_and(a,2.0) end)
 assert(not ok,'weak reject bitwise_and 748')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.bitwise_and(2.0,a) end)
 assert(not ok,'weak reject bitwise_and 749')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.bitwise_and(a,np.complex(0.0,2.0)) end)
 assert(not ok,'weak reject bitwise_and 750')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.bitwise_and(np.complex(0.0,2.0),a) end)
 assert(not ok,'weak reject bitwise_and 751')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local ok=pcall(function() return np.bitwise_and(a,2.0) end)
 assert(not ok,'weak reject bitwise_and 752')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local ok=pcall(function() return np.bitwise_and(2.0,a) end)
 assert(not ok,'weak reject bitwise_and 753')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.bitwise_and(a,2) end)
 assert(not ok,'weak reject bitwise_and 754')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.bitwise_and(2,a) end)
 assert(not ok,'weak reject bitwise_and 755')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.bitwise_and(a,2.0) end)
 assert(not ok,'weak reject bitwise_and 756')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.bitwise_and(2.0,a) end)
 assert(not ok,'weak reject bitwise_and 757')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.bitwise_and(a,np.complex(1.0,2.0)) end)
 assert(not ok,'weak reject bitwise_and 758')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.bitwise_and(np.complex(1.0,2.0),a) end)
 assert(not ok,'weak reject bitwise_and 759')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.bitwise_or(a,true)
 assert(r.dtype=='bool','weak dtype bitwise_or 760 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values bitwise_or 760')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.bitwise_or(true,a)
 assert(r.dtype=='bool','weak dtype bitwise_or 761 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values bitwise_or 761')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.bitwise_or(a,2)
 assert(r.dtype=='int64','weak dtype bitwise_or 762 '..r.dtype)
 assert(same(r:tolist(),{2,3,3,2},0.0),'weak values bitwise_or 762')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.bitwise_or(2,a)
 assert(r.dtype=='int64','weak dtype bitwise_or 763 '..r.dtype)
 assert(same(r:tolist(),{2,3,3,2},0.0),'weak values bitwise_or 763')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.bitwise_or(a,2)
 assert(r.dtype=='int8','weak dtype bitwise_or 764 '..r.dtype)
 assert(same(r:tolist(),{-5,-1,2,11},0.0),'weak values bitwise_or 764')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.bitwise_or(2,a)
 assert(r.dtype=='int8','weak dtype bitwise_or 765 '..r.dtype)
 assert(same(r:tolist(),{-5,-1,2,11},0.0),'weak values bitwise_or 765')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.bitwise_or(a,-3)
 assert(r.dtype=='int8','weak dtype bitwise_or 766 '..r.dtype)
 assert(same(r:tolist(),{-3,-1,-1,-1},0.0),'weak values bitwise_or 766')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.bitwise_or(-3,a)
 assert(r.dtype=='int8','weak dtype bitwise_or 767 '..r.dtype)
 assert(same(r:tolist(),{-3,-1,-1,-1},0.0),'weak values bitwise_or 767')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.bitwise_or(a,2)
 assert(r.dtype=='uint8','weak dtype bitwise_or 768 '..r.dtype)
 assert(same(r:tolist(),{2,3,7,19},0.0),'weak values bitwise_or 768')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.bitwise_or(2,a)
 assert(r.dtype=='uint8','weak dtype bitwise_or 769 '..r.dtype)
 assert(same(r:tolist(),{2,3,7,19},0.0),'weak values bitwise_or 769')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.bitwise_or(a,300) end)
 assert(not ok,'weak reject bitwise_or 770')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.bitwise_or(300,a) end)
 assert(not ok,'weak reject bitwise_or 771')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.bitwise_or(a,-1) end)
 assert(not ok,'weak reject bitwise_or 772')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.bitwise_or(-1,a) end)
 assert(not ok,'weak reject bitwise_or 773')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.bitwise_or(a,127)
 assert(r.dtype=='int16','weak dtype bitwise_or 774 '..r.dtype)
 assert(same(r:tolist(),{-1,-1,127,127},0.0),'weak values bitwise_or 774')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.bitwise_or(127,a)
 assert(r.dtype=='int16','weak dtype bitwise_or 775 '..r.dtype)
 assert(same(r:tolist(),{-1,-1,127,127},0.0),'weak values bitwise_or 775')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.bitwise_or(a,5)
 assert(r.dtype=='int64','weak dtype bitwise_or 776 '..r.dtype)
 assert(same(r:tolist(),{-3,-1,7,15},0.0),'weak values bitwise_or 776')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.bitwise_or(5,a)
 assert(r.dtype=='int64','weak dtype bitwise_or 777 '..r.dtype)
 assert(same(r:tolist(),{-3,-1,7,15},0.0),'weak values bitwise_or 777')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.bitwise_or(a,5)
 assert(r.dtype=='uint64','weak dtype bitwise_or 778 '..r.dtype)
 assert(same(r:tolist(),{5,5,5,21},0.0),'weak values bitwise_or 778')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.bitwise_or(5,a)
 assert(r.dtype=='uint64','weak dtype bitwise_or 779 '..r.dtype)
 assert(same(r:tolist(),{5,5,5,21},0.0),'weak values bitwise_or 779')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.bitwise_or(a,-1) end)
 assert(not ok,'weak reject bitwise_or 780')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.bitwise_or(-1,a) end)
 assert(not ok,'weak reject bitwise_or 781')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local ok=pcall(function() return np.bitwise_or(a,2) end)
 assert(not ok,'weak reject bitwise_or 782')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local ok=pcall(function() return np.bitwise_or(2,a) end)
 assert(not ok,'weak reject bitwise_or 783')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local ok=pcall(function() return np.bitwise_or(a,2.0) end)
 assert(not ok,'weak reject bitwise_or 784')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local ok=pcall(function() return np.bitwise_or(2.0,a) end)
 assert(not ok,'weak reject bitwise_or 785')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.bitwise_or(a,2) end)
 assert(not ok,'weak reject bitwise_or 786')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.bitwise_or(2,a) end)
 assert(not ok,'weak reject bitwise_or 787')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.bitwise_or(a,2.0) end)
 assert(not ok,'weak reject bitwise_or 788')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.bitwise_or(2.0,a) end)
 assert(not ok,'weak reject bitwise_or 789')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.bitwise_or(a,np.complex(0.0,2.0)) end)
 assert(not ok,'weak reject bitwise_or 790')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.bitwise_or(np.complex(0.0,2.0),a) end)
 assert(not ok,'weak reject bitwise_or 791')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local ok=pcall(function() return np.bitwise_or(a,2.0) end)
 assert(not ok,'weak reject bitwise_or 792')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local ok=pcall(function() return np.bitwise_or(2.0,a) end)
 assert(not ok,'weak reject bitwise_or 793')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.bitwise_or(a,2) end)
 assert(not ok,'weak reject bitwise_or 794')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.bitwise_or(2,a) end)
 assert(not ok,'weak reject bitwise_or 795')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.bitwise_or(a,2.0) end)
 assert(not ok,'weak reject bitwise_or 796')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.bitwise_or(2.0,a) end)
 assert(not ok,'weak reject bitwise_or 797')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.bitwise_or(a,np.complex(1.0,2.0)) end)
 assert(not ok,'weak reject bitwise_or 798')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.bitwise_or(np.complex(1.0,2.0),a) end)
 assert(not ok,'weak reject bitwise_or 799')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.bitwise_xor(a,true)
 assert(r.dtype=='bool','weak dtype bitwise_xor 800 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,true},0.0),'weak values bitwise_xor 800')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.bitwise_xor(true,a)
 assert(r.dtype=='bool','weak dtype bitwise_xor 801 '..r.dtype)
 assert(same(r:tolist(),{true,false,false,true},0.0),'weak values bitwise_xor 801')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.bitwise_xor(a,2)
 assert(r.dtype=='int64','weak dtype bitwise_xor 802 '..r.dtype)
 assert(same(r:tolist(),{2,3,3,2},0.0),'weak values bitwise_xor 802')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.bitwise_xor(2,a)
 assert(r.dtype=='int64','weak dtype bitwise_xor 803 '..r.dtype)
 assert(same(r:tolist(),{2,3,3,2},0.0),'weak values bitwise_xor 803')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.bitwise_xor(a,2)
 assert(r.dtype=='int8','weak dtype bitwise_xor 804 '..r.dtype)
 assert(same(r:tolist(),{-5,-3,0,9},0.0),'weak values bitwise_xor 804')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.bitwise_xor(2,a)
 assert(r.dtype=='int8','weak dtype bitwise_xor 805 '..r.dtype)
 assert(same(r:tolist(),{-5,-3,0,9},0.0),'weak values bitwise_xor 805')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.bitwise_xor(a,-3)
 assert(r.dtype=='int8','weak dtype bitwise_xor 806 '..r.dtype)
 assert(same(r:tolist(),{4,2,-1,-10},0.0),'weak values bitwise_xor 806')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.bitwise_xor(-3,a)
 assert(r.dtype=='int8','weak dtype bitwise_xor 807 '..r.dtype)
 assert(same(r:tolist(),{4,2,-1,-10},0.0),'weak values bitwise_xor 807')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.bitwise_xor(a,2)
 assert(r.dtype=='uint8','weak dtype bitwise_xor 808 '..r.dtype)
 assert(same(r:tolist(),{2,3,7,19},0.0),'weak values bitwise_xor 808')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.bitwise_xor(2,a)
 assert(r.dtype=='uint8','weak dtype bitwise_xor 809 '..r.dtype)
 assert(same(r:tolist(),{2,3,7,19},0.0),'weak values bitwise_xor 809')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.bitwise_xor(a,300) end)
 assert(not ok,'weak reject bitwise_xor 810')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.bitwise_xor(300,a) end)
 assert(not ok,'weak reject bitwise_xor 811')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.bitwise_xor(a,-1) end)
 assert(not ok,'weak reject bitwise_xor 812')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.bitwise_xor(-1,a) end)
 assert(not ok,'weak reject bitwise_xor 813')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.bitwise_xor(a,127)
 assert(r.dtype=='int16','weak dtype bitwise_xor 814 '..r.dtype)
 assert(same(r:tolist(),{-122,-128,125,116},0.0),'weak values bitwise_xor 814')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.bitwise_xor(127,a)
 assert(r.dtype=='int16','weak dtype bitwise_xor 815 '..r.dtype)
 assert(same(r:tolist(),{-122,-128,125,116},0.0),'weak values bitwise_xor 815')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.bitwise_xor(a,5)
 assert(r.dtype=='int64','weak dtype bitwise_xor 816 '..r.dtype)
 assert(same(r:tolist(),{-4,-6,7,14},0.0),'weak values bitwise_xor 816')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.bitwise_xor(5,a)
 assert(r.dtype=='int64','weak dtype bitwise_xor 817 '..r.dtype)
 assert(same(r:tolist(),{-4,-6,7,14},0.0),'weak values bitwise_xor 817')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.bitwise_xor(a,5)
 assert(r.dtype=='uint64','weak dtype bitwise_xor 818 '..r.dtype)
 assert(same(r:tolist(),{5,4,0,20},0.0),'weak values bitwise_xor 818')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.bitwise_xor(5,a)
 assert(r.dtype=='uint64','weak dtype bitwise_xor 819 '..r.dtype)
 assert(same(r:tolist(),{5,4,0,20},0.0),'weak values bitwise_xor 819')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.bitwise_xor(a,-1) end)
 assert(not ok,'weak reject bitwise_xor 820')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.bitwise_xor(-1,a) end)
 assert(not ok,'weak reject bitwise_xor 821')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local ok=pcall(function() return np.bitwise_xor(a,2) end)
 assert(not ok,'weak reject bitwise_xor 822')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local ok=pcall(function() return np.bitwise_xor(2,a) end)
 assert(not ok,'weak reject bitwise_xor 823')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local ok=pcall(function() return np.bitwise_xor(a,2.0) end)
 assert(not ok,'weak reject bitwise_xor 824')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local ok=pcall(function() return np.bitwise_xor(2.0,a) end)
 assert(not ok,'weak reject bitwise_xor 825')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.bitwise_xor(a,2) end)
 assert(not ok,'weak reject bitwise_xor 826')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.bitwise_xor(2,a) end)
 assert(not ok,'weak reject bitwise_xor 827')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.bitwise_xor(a,2.0) end)
 assert(not ok,'weak reject bitwise_xor 828')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.bitwise_xor(2.0,a) end)
 assert(not ok,'weak reject bitwise_xor 829')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.bitwise_xor(a,np.complex(0.0,2.0)) end)
 assert(not ok,'weak reject bitwise_xor 830')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.bitwise_xor(np.complex(0.0,2.0),a) end)
 assert(not ok,'weak reject bitwise_xor 831')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local ok=pcall(function() return np.bitwise_xor(a,2.0) end)
 assert(not ok,'weak reject bitwise_xor 832')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local ok=pcall(function() return np.bitwise_xor(2.0,a) end)
 assert(not ok,'weak reject bitwise_xor 833')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.bitwise_xor(a,2) end)
 assert(not ok,'weak reject bitwise_xor 834')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.bitwise_xor(2,a) end)
 assert(not ok,'weak reject bitwise_xor 835')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.bitwise_xor(a,2.0) end)
 assert(not ok,'weak reject bitwise_xor 836')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.bitwise_xor(2.0,a) end)
 assert(not ok,'weak reject bitwise_xor 837')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.bitwise_xor(a,np.complex(1.0,2.0)) end)
 assert(not ok,'weak reject bitwise_xor 838')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.bitwise_xor(np.complex(1.0,2.0),a) end)
 assert(not ok,'weak reject bitwise_xor 839')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.fmax(a,true)
 assert(r.dtype=='bool','weak dtype fmax 840 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values fmax 840')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.fmax(true,a)
 assert(r.dtype=='bool','weak dtype fmax 841 '..r.dtype)
 assert(same(r:tolist(),{true,true,true,true},0.0),'weak values fmax 841')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.fmax(a,2)
 assert(r.dtype=='int64','weak dtype fmax 842 '..r.dtype)
 assert(same(r:tolist(),{2,2,2,2},0.0),'weak values fmax 842')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.fmax(2,a)
 assert(r.dtype=='int64','weak dtype fmax 843 '..r.dtype)
 assert(same(r:tolist(),{2,2,2,2},0.0),'weak values fmax 843')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.fmax(a,2)
 assert(r.dtype=='int8','weak dtype fmax 844 '..r.dtype)
 assert(same(r:tolist(),{2,2,2,11},0.0),'weak values fmax 844')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.fmax(2,a)
 assert(r.dtype=='int8','weak dtype fmax 845 '..r.dtype)
 assert(same(r:tolist(),{2,2,2,11},0.0),'weak values fmax 845')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.fmax(a,-3)
 assert(r.dtype=='int8','weak dtype fmax 846 '..r.dtype)
 assert(same(r:tolist(),{-3,-1,2,11},0.0),'weak values fmax 846')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.fmax(-3,a)
 assert(r.dtype=='int8','weak dtype fmax 847 '..r.dtype)
 assert(same(r:tolist(),{-3,-1,2,11},0.0),'weak values fmax 847')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.fmax(a,2)
 assert(r.dtype=='uint8','weak dtype fmax 848 '..r.dtype)
 assert(same(r:tolist(),{2,2,5,17},0.0),'weak values fmax 848')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.fmax(2,a)
 assert(r.dtype=='uint8','weak dtype fmax 849 '..r.dtype)
 assert(same(r:tolist(),{2,2,5,17},0.0),'weak values fmax 849')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.fmax(a,300) end)
 assert(not ok,'weak reject fmax 850')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.fmax(300,a) end)
 assert(not ok,'weak reject fmax 851')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.fmax(a,-1) end)
 assert(not ok,'weak reject fmax 852')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.fmax(-1,a) end)
 assert(not ok,'weak reject fmax 853')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.fmax(a,127)
 assert(r.dtype=='int16','weak dtype fmax 854 '..r.dtype)
 assert(same(r:tolist(),{127,127,127,127},0.0),'weak values fmax 854')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.fmax(127,a)
 assert(r.dtype=='int16','weak dtype fmax 855 '..r.dtype)
 assert(same(r:tolist(),{127,127,127,127},0.0),'weak values fmax 855')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.fmax(a,5)
 assert(r.dtype=='int64','weak dtype fmax 856 '..r.dtype)
 assert(same(r:tolist(),{5,5,5,11},0.0),'weak values fmax 856')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.fmax(5,a)
 assert(r.dtype=='int64','weak dtype fmax 857 '..r.dtype)
 assert(same(r:tolist(),{5,5,5,11},0.0),'weak values fmax 857')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.fmax(a,5)
 assert(r.dtype=='uint64','weak dtype fmax 858 '..r.dtype)
 assert(same(r:tolist(),{5,5,5,17},0.0),'weak values fmax 858')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.fmax(5,a)
 assert(r.dtype=='uint64','weak dtype fmax 859 '..r.dtype)
 assert(same(r:tolist(),{5,5,5,17},0.0),'weak values fmax 859')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.fmax(a,-1) end)
 assert(not ok,'weak reject fmax 860')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.fmax(-1,a) end)
 assert(not ok,'weak reject fmax 861')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.fmax(a,2)
 assert(r.dtype=='float16','weak dtype fmax 862 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.0,2.0,7.0},0.006),'weak values fmax 862')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.fmax(2,a)
 assert(r.dtype=='float16','weak dtype fmax 863 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.0,2.0,7.0},0.006),'weak values fmax 863')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.fmax(a,2.0)
 assert(r.dtype=='float16','weak dtype fmax 864 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.0,2.0,7.0},0.006),'weak values fmax 864')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.fmax(2.0,a)
 assert(r.dtype=='float16','weak dtype fmax 865 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.0,2.0,7.0},0.006),'weak values fmax 865')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.fmax(a,2)
 assert(r.dtype=='float32','weak dtype fmax 866 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.0,2.0,7.0},1e-05),'weak values fmax 866')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.fmax(2,a)
 assert(r.dtype=='float32','weak dtype fmax 867 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.0,2.0,7.0},1e-05),'weak values fmax 867')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.fmax(a,2.0)
 assert(r.dtype=='float32','weak dtype fmax 868 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.0,2.0,7.0},1e-05),'weak values fmax 868')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.fmax(2.0,a)
 assert(r.dtype=='float32','weak dtype fmax 869 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.0,2.0,7.0},1e-05),'weak values fmax 869')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.fmax(a,np.complex(0.0,2.0))
 assert(r.dtype=='complex64','weak dtype fmax 870 '..r.dtype)
 assert(same(r:tolist(),{np.complex(0.0,2.0),np.complex(0.0,2.0),np.complex(1.25,0.0),np.complex(7.0,0.0)},1e-05),'weak values fmax 870')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.fmax(np.complex(0.0,2.0),a)
 assert(r.dtype=='complex64','weak dtype fmax 871 '..r.dtype)
 assert(same(r:tolist(),{np.complex(0.0,2.0),np.complex(0.0,2.0),np.complex(1.25,0.0),np.complex(7.0,0.0)},1e-05),'weak values fmax 871')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.fmax(a,2.0)
 assert(r.dtype=='float64','weak dtype fmax 872 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.0,2.0,7.0},3e-12),'weak values fmax 872')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.fmax(2.0,a)
 assert(r.dtype=='float64','weak dtype fmax 873 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.0,2.0,7.0},3e-12),'weak values fmax 873')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.fmax(a,2)
 assert(r.dtype=='complex64','weak dtype fmax 874 '..r.dtype)
 assert(same(r:tolist(),{np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(7.0,-3.0)},1e-05),'weak values fmax 874')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.fmax(2,a)
 assert(r.dtype=='complex64','weak dtype fmax 875 '..r.dtype)
 assert(same(r:tolist(),{np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(7.0,-3.0)},1e-05),'weak values fmax 875')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.fmax(a,2.0)
 assert(r.dtype=='complex64','weak dtype fmax 876 '..r.dtype)
 assert(same(r:tolist(),{np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(7.0,-3.0)},1e-05),'weak values fmax 876')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.fmax(2.0,a)
 assert(r.dtype=='complex64','weak dtype fmax 877 '..r.dtype)
 assert(same(r:tolist(),{np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(2.0,0.0),np.complex(7.0,-3.0)},1e-05),'weak values fmax 877')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.fmax(a,np.complex(1.0,2.0))
 assert(r.dtype=='complex64','weak dtype fmax 878 '..r.dtype)
 assert(same(r:tolist(),{np.complex(1.0,2.0),np.complex(1.0,2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},1e-05),'weak values fmax 878')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.fmax(np.complex(1.0,2.0),a)
 assert(r.dtype=='complex64','weak dtype fmax 879 '..r.dtype)
 assert(same(r:tolist(),{np.complex(1.0,2.0),np.complex(1.0,2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},1e-05),'weak values fmax 879')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.fmin(a,true)
 assert(r.dtype=='bool','weak dtype fmin 880 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,false},0.0),'weak values fmin 880')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.fmin(true,a)
 assert(r.dtype=='bool','weak dtype fmin 881 '..r.dtype)
 assert(same(r:tolist(),{false,true,true,false},0.0),'weak values fmin 881')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.fmin(a,2)
 assert(r.dtype=='int64','weak dtype fmin 882 '..r.dtype)
 assert(same(r:tolist(),{0,1,1,0},0.0),'weak values fmin 882')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.fmin(2,a)
 assert(r.dtype=='int64','weak dtype fmin 883 '..r.dtype)
 assert(same(r:tolist(),{0,1,1,0},0.0),'weak values fmin 883')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.fmin(a,2)
 assert(r.dtype=='int8','weak dtype fmin 884 '..r.dtype)
 assert(same(r:tolist(),{-7,-1,2,2},0.0),'weak values fmin 884')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.fmin(2,a)
 assert(r.dtype=='int8','weak dtype fmin 885 '..r.dtype)
 assert(same(r:tolist(),{-7,-1,2,2},0.0),'weak values fmin 885')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.fmin(a,-3)
 assert(r.dtype=='int8','weak dtype fmin 886 '..r.dtype)
 assert(same(r:tolist(),{-7,-3,-3,-3},0.0),'weak values fmin 886')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.fmin(-3,a)
 assert(r.dtype=='int8','weak dtype fmin 887 '..r.dtype)
 assert(same(r:tolist(),{-7,-3,-3,-3},0.0),'weak values fmin 887')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.fmin(a,2)
 assert(r.dtype=='uint8','weak dtype fmin 888 '..r.dtype)
 assert(same(r:tolist(),{0,1,2,2},0.0),'weak values fmin 888')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.fmin(2,a)
 assert(r.dtype=='uint8','weak dtype fmin 889 '..r.dtype)
 assert(same(r:tolist(),{0,1,2,2},0.0),'weak values fmin 889')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.fmin(a,300) end)
 assert(not ok,'weak reject fmin 890')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.fmin(300,a) end)
 assert(not ok,'weak reject fmin 891')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.fmin(a,-1) end)
 assert(not ok,'weak reject fmin 892')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local ok=pcall(function() return np.fmin(-1,a) end)
 assert(not ok,'weak reject fmin 893')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.fmin(a,127)
 assert(r.dtype=='int16','weak dtype fmin 894 '..r.dtype)
 assert(same(r:tolist(),{-7,-1,2,11},0.0),'weak values fmin 894')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.fmin(127,a)
 assert(r.dtype=='int16','weak dtype fmin 895 '..r.dtype)
 assert(same(r:tolist(),{-7,-1,2,11},0.0),'weak values fmin 895')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.fmin(a,5)
 assert(r.dtype=='int64','weak dtype fmin 896 '..r.dtype)
 assert(same(r:tolist(),{-7,-1,2,5},0.0),'weak values fmin 896')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.fmin(5,a)
 assert(r.dtype=='int64','weak dtype fmin 897 '..r.dtype)
 assert(same(r:tolist(),{-7,-1,2,5},0.0),'weak values fmin 897')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.fmin(a,5)
 assert(r.dtype=='uint64','weak dtype fmin 898 '..r.dtype)
 assert(same(r:tolist(),{0,1,5,5},0.0),'weak values fmin 898')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.fmin(5,a)
 assert(r.dtype=='uint64','weak dtype fmin 899 '..r.dtype)
 assert(same(r:tolist(),{0,1,5,5},0.0),'weak values fmin 899')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.fmin(a,-1) end)
 assert(not ok,'weak reject fmin 900')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local ok=pcall(function() return np.fmin(-1,a) end)
 assert(not ok,'weak reject fmin 901')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.fmin(a,2)
 assert(r.dtype=='float16','weak dtype fmin 902 '..r.dtype)
 assert(same(r:tolist(),{-2.5,-0.0,1.25,2.0},0.006),'weak values fmin 902')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.fmin(2,a)
 assert(r.dtype=='float16','weak dtype fmin 903 '..r.dtype)
 assert(same(r:tolist(),{-2.5,-0.0,1.25,2.0},0.006),'weak values fmin 903')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.fmin(a,2.0)
 assert(r.dtype=='float16','weak dtype fmin 904 '..r.dtype)
 assert(same(r:tolist(),{-2.5,-0.0,1.25,2.0},0.006),'weak values fmin 904')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.fmin(2.0,a)
 assert(r.dtype=='float16','weak dtype fmin 905 '..r.dtype)
 assert(same(r:tolist(),{-2.5,-0.0,1.25,2.0},0.006),'weak values fmin 905')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.fmin(a,2)
 assert(r.dtype=='float32','weak dtype fmin 906 '..r.dtype)
 assert(same(r:tolist(),{-2.5,-0.0,1.25,2.0},1e-05),'weak values fmin 906')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.fmin(2,a)
 assert(r.dtype=='float32','weak dtype fmin 907 '..r.dtype)
 assert(same(r:tolist(),{-2.5,-0.0,1.25,2.0},1e-05),'weak values fmin 907')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.fmin(a,2.0)
 assert(r.dtype=='float32','weak dtype fmin 908 '..r.dtype)
 assert(same(r:tolist(),{-2.5,-0.0,1.25,2.0},1e-05),'weak values fmin 908')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.fmin(2.0,a)
 assert(r.dtype=='float32','weak dtype fmin 909 '..r.dtype)
 assert(same(r:tolist(),{-2.5,-0.0,1.25,2.0},1e-05),'weak values fmin 909')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.fmin(a,np.complex(0.0,2.0))
 assert(r.dtype=='complex64','weak dtype fmin 910 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-2.5,0.0),np.complex(-0.0,0.0),np.complex(0.0,2.0),np.complex(0.0,2.0)},1e-05),'weak values fmin 910')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.fmin(np.complex(0.0,2.0),a)
 assert(r.dtype=='complex64','weak dtype fmin 911 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-2.5,0.0),np.complex(-0.0,0.0),np.complex(0.0,2.0),np.complex(0.0,2.0)},1e-05),'weak values fmin 911')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.fmin(a,2.0)
 assert(r.dtype=='float64','weak dtype fmin 912 '..r.dtype)
 assert(same(r:tolist(),{-2.5,-0.0,1.25,2.0},3e-12),'weak values fmin 912')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.fmin(2.0,a)
 assert(r.dtype=='float64','weak dtype fmin 913 '..r.dtype)
 assert(same(r:tolist(),{-2.5,-0.0,1.25,2.0},3e-12),'weak values fmin 913')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.fmin(a,2)
 assert(r.dtype=='complex64','weak dtype fmin 914 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(2.0,0.0)},1e-05),'weak values fmin 914')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.fmin(2,a)
 assert(r.dtype=='complex64','weak dtype fmin 915 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(2.0,0.0)},1e-05),'weak values fmin 915')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.fmin(a,2.0)
 assert(r.dtype=='complex64','weak dtype fmin 916 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(2.0,0.0)},1e-05),'weak values fmin 916')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.fmin(2.0,a)
 assert(r.dtype=='complex64','weak dtype fmin 917 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(2.0,0.0)},1e-05),'weak values fmin 917')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.fmin(a,np.complex(1.0,2.0))
 assert(r.dtype=='complex64','weak dtype fmin 918 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.0,2.0),np.complex(1.0,2.0)},1e-05),'weak values fmin 918')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.fmin(np.complex(1.0,2.0),a)
 assert(r.dtype=='complex64','weak dtype fmin 919 '..r.dtype)
 assert(same(r:tolist(),{np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.0,2.0),np.complex(1.0,2.0)},1e-05),'weak values fmin 919')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.copysign(a,true)
 assert(r.dtype=='float16','weak dtype copysign 920 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.0,1.0,0.0},0.006),'weak values copysign 920')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.copysign(true,a)
 assert(r.dtype=='float16','weak dtype copysign 921 '..r.dtype)
 assert(same(r:tolist(),{1.0,1.0,1.0,1.0},0.006),'weak values copysign 921')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.copysign(a,2)
 assert(r.dtype=='float64','weak dtype copysign 922 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.0,1.0,0.0},3e-12),'weak values copysign 922')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.copysign(2,a)
 assert(r.dtype=='float64','weak dtype copysign 923 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.0,2.0,2.0},3e-12),'weak values copysign 923')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.copysign(a,2)
 assert(r.dtype=='float16','weak dtype copysign 924 '..r.dtype)
 assert(same(r:tolist(),{7.0,1.0,2.0,11.0},0.006),'weak values copysign 924')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.copysign(2,a)
 assert(r.dtype=='float16','weak dtype copysign 925 '..r.dtype)
 assert(same(r:tolist(),{-2.0,-2.0,2.0,2.0},0.006),'weak values copysign 925')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.copysign(a,-3)
 assert(r.dtype=='float16','weak dtype copysign 926 '..r.dtype)
 assert(same(r:tolist(),{-7.0,-1.0,-2.0,-11.0},0.006),'weak values copysign 926')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.copysign(-3,a)
 assert(r.dtype=='float16','weak dtype copysign 927 '..r.dtype)
 assert(same(r:tolist(),{-3.0,-3.0,3.0,3.0},0.006),'weak values copysign 927')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.copysign(a,2)
 assert(r.dtype=='float16','weak dtype copysign 928 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.0,5.0,17.0},0.006),'weak values copysign 928')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.copysign(2,a)
 assert(r.dtype=='float16','weak dtype copysign 929 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.0,2.0,2.0},0.006),'weak values copysign 929')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.copysign(a,300)
 assert(r.dtype=='float16','weak dtype copysign 930 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.0,5.0,17.0},0.006),'weak values copysign 930')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.copysign(300,a)
 assert(r.dtype=='float16','weak dtype copysign 931 '..r.dtype)
 assert(same(r:tolist(),{300.0,300.0,300.0,300.0},0.006),'weak values copysign 931')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.copysign(a,-1)
 assert(r.dtype=='float16','weak dtype copysign 932 '..r.dtype)
 assert(same(r:tolist(),{-0.0,-1.0,-5.0,-17.0},0.006),'weak values copysign 932')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.copysign(-1,a)
 assert(r.dtype=='float16','weak dtype copysign 933 '..r.dtype)
 assert(same(r:tolist(),{1.0,1.0,1.0,1.0},0.006),'weak values copysign 933')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.copysign(a,127)
 assert(r.dtype=='float32','weak dtype copysign 934 '..r.dtype)
 assert(same(r:tolist(),{7.0,1.0,2.0,11.0},1e-05),'weak values copysign 934')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.copysign(127,a)
 assert(r.dtype=='float32','weak dtype copysign 935 '..r.dtype)
 assert(same(r:tolist(),{-127.0,-127.0,127.0,127.0},1e-05),'weak values copysign 935')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.copysign(a,5)
 assert(r.dtype=='float64','weak dtype copysign 936 '..r.dtype)
 assert(same(r:tolist(),{7.0,1.0,2.0,11.0},3e-12),'weak values copysign 936')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.copysign(5,a)
 assert(r.dtype=='float64','weak dtype copysign 937 '..r.dtype)
 assert(same(r:tolist(),{-5.0,-5.0,5.0,5.0},3e-12),'weak values copysign 937')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.copysign(a,5)
 assert(r.dtype=='float64','weak dtype copysign 938 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.0,5.0,17.0},3e-12),'weak values copysign 938')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.copysign(5,a)
 assert(r.dtype=='float64','weak dtype copysign 939 '..r.dtype)
 assert(same(r:tolist(),{5.0,5.0,5.0,5.0},3e-12),'weak values copysign 939')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.copysign(a,-1)
 assert(r.dtype=='float64','weak dtype copysign 940 '..r.dtype)
 assert(same(r:tolist(),{-0.0,-1.0,-5.0,-17.0},3e-12),'weak values copysign 940')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.copysign(-1,a)
 assert(r.dtype=='float64','weak dtype copysign 941 '..r.dtype)
 assert(same(r:tolist(),{1.0,1.0,1.0,1.0},3e-12),'weak values copysign 941')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.copysign(a,2)
 assert(r.dtype=='float16','weak dtype copysign 942 '..r.dtype)
 assert(same(r:tolist(),{2.5,0.0,1.25,7.0},0.006),'weak values copysign 942')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.copysign(2,a)
 assert(r.dtype=='float16','weak dtype copysign 943 '..r.dtype)
 assert(same(r:tolist(),{-2.0,-2.0,2.0,2.0},0.006),'weak values copysign 943')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.copysign(a,2.0)
 assert(r.dtype=='float16','weak dtype copysign 944 '..r.dtype)
 assert(same(r:tolist(),{2.5,0.0,1.25,7.0},0.006),'weak values copysign 944')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.copysign(2.0,a)
 assert(r.dtype=='float16','weak dtype copysign 945 '..r.dtype)
 assert(same(r:tolist(),{-2.0,-2.0,2.0,2.0},0.006),'weak values copysign 945')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.copysign(a,2)
 assert(r.dtype=='float32','weak dtype copysign 946 '..r.dtype)
 assert(same(r:tolist(),{2.5,0.0,1.25,7.0},1e-05),'weak values copysign 946')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.copysign(2,a)
 assert(r.dtype=='float32','weak dtype copysign 947 '..r.dtype)
 assert(same(r:tolist(),{-2.0,-2.0,2.0,2.0},1e-05),'weak values copysign 947')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.copysign(a,2.0)
 assert(r.dtype=='float32','weak dtype copysign 948 '..r.dtype)
 assert(same(r:tolist(),{2.5,0.0,1.25,7.0},1e-05),'weak values copysign 948')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.copysign(2.0,a)
 assert(r.dtype=='float32','weak dtype copysign 949 '..r.dtype)
 assert(same(r:tolist(),{-2.0,-2.0,2.0,2.0},1e-05),'weak values copysign 949')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.copysign(a,np.complex(0.0,2.0)) end)
 assert(not ok,'weak reject copysign 950')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.copysign(np.complex(0.0,2.0),a) end)
 assert(not ok,'weak reject copysign 951')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.copysign(a,2.0)
 assert(r.dtype=='float64','weak dtype copysign 952 '..r.dtype)
 assert(same(r:tolist(),{2.5,0.0,1.25,7.0},3e-12),'weak values copysign 952')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.copysign(2.0,a)
 assert(r.dtype=='float64','weak dtype copysign 953 '..r.dtype)
 assert(same(r:tolist(),{-2.0,-2.0,2.0,2.0},3e-12),'weak values copysign 953')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.copysign(a,2) end)
 assert(not ok,'weak reject copysign 954')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.copysign(2,a) end)
 assert(not ok,'weak reject copysign 955')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.copysign(a,2.0) end)
 assert(not ok,'weak reject copysign 956')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.copysign(2.0,a) end)
 assert(not ok,'weak reject copysign 957')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.copysign(a,np.complex(1.0,2.0)) end)
 assert(not ok,'weak reject copysign 958')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.copysign(np.complex(1.0,2.0),a) end)
 assert(not ok,'weak reject copysign 959')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.arctan2(a,true)
 assert(r.dtype=='float16','weak dtype arctan2 960 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.78515625,0.78515625,0.0},0.006),'weak values arctan2 960')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.arctan2(true,a)
 assert(r.dtype=='float16','weak dtype arctan2 961 '..r.dtype)
 assert(same(r:tolist(),{1.5703125,0.78515625,0.78515625,1.5703125},0.006),'weak values arctan2 961')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.arctan2(a,2)
 assert(r.dtype=='float64','weak dtype arctan2 962 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.4636476090008061,0.4636476090008061,0.0},3e-12),'weak values arctan2 962')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.arctan2(2,a)
 assert(r.dtype=='float64','weak dtype arctan2 963 '..r.dtype)
 assert(same(r:tolist(),{1.5707963267948966,1.1071487177940904,1.1071487177940904,1.5707963267948966},3e-12),'weak values arctan2 963')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.arctan2(a,2)
 assert(r.dtype=='float16','weak dtype arctan2 964 '..r.dtype)
 assert(same(r:tolist(),{-1.29296875,-0.463623046875,0.78515625,1.390625},0.006),'weak values arctan2 964')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.arctan2(2,a)
 assert(r.dtype=='float16','weak dtype arctan2 965 '..r.dtype)
 assert(same(r:tolist(),{2.86328125,2.03515625,0.78515625,0.1798095703125},0.006),'weak values arctan2 965')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.arctan2(a,-3)
 assert(r.dtype=='float16','weak dtype arctan2 966 '..r.dtype)
 assert(same(r:tolist(),{-1.9755859375,-2.8203125,2.552734375,1.8369140625},0.006),'weak values arctan2 966')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.arctan2(-3,a)
 assert(r.dtype=='float16','weak dtype arctan2 967 '..r.dtype)
 assert(same(r:tolist(),{-2.736328125,-1.892578125,-0.98291015625,-0.266357421875},0.006),'weak values arctan2 967')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.arctan2(a,2)
 assert(r.dtype=='float16','weak dtype arctan2 968 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.463623046875,1.1904296875,1.4541015625},0.006),'weak values arctan2 968')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.arctan2(2,a)
 assert(r.dtype=='float16','weak dtype arctan2 969 '..r.dtype)
 assert(same(r:tolist(),{1.5703125,1.107421875,0.380615234375,0.11712646484375},0.006),'weak values arctan2 969')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.arctan2(a,300)
 assert(r.dtype=='float16','weak dtype arctan2 970 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.00333404541015625,0.01666259765625,0.056610107421875},0.006),'weak values arctan2 970')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.arctan2(300,a)
 assert(r.dtype=='float16','weak dtype arctan2 971 '..r.dtype)
 assert(same(r:tolist(),{1.5703125,1.5673828125,1.5537109375,1.5146484375},0.006),'weak values arctan2 971')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.arctan2(a,-1)
 assert(r.dtype=='float16','weak dtype arctan2 972 '..r.dtype)
 assert(same(r:tolist(),{3.140625,2.35546875,1.7685546875,1.6298828125},0.006),'weak values arctan2 972')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.arctan2(-1,a)
 assert(r.dtype=='float16','weak dtype arctan2 973 '..r.dtype)
 assert(same(r:tolist(),{-1.5703125,-0.78515625,-0.1973876953125,-0.058746337890625},0.006),'weak values arctan2 973')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.arctan2(a,127)
 assert(r.dtype=='float32','weak dtype arctan2 974 '..r.dtype)
 assert(same(r:tolist(),{-0.055062390863895416,-0.007873852737247944,0.01574672944843769,0.08639854937791824},1e-05),'weak values arctan2 974')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.arctan2(127,a)
 assert(r.dtype=='float32','weak dtype arctan2 975 '..r.dtype)
 assert(same(r:tolist(),{1.6258587837219238,1.5786702632904053,1.5550496578216553,1.4843977689743042},1e-05),'weak values arctan2 975')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.arctan2(a,5)
 assert(r.dtype=='float64','weak dtype arctan2 976 '..r.dtype)
 assert(same(r:tolist(),{-0.9505468408120752,-0.19739555984988075,0.3805063771123649,1.1441688336680205},3e-12),'weak values arctan2 976')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.arctan2(5,a)
 assert(r.dtype=='float64','weak dtype arctan2 977 '..r.dtype)
 assert(same(r:tolist(),{2.5213431676069717,1.7681918866447774,1.1902899496825317,0.4266274931268761},3e-12),'weak values arctan2 977')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.arctan2(a,5)
 assert(r.dtype=='float64','weak dtype arctan2 978 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.19739555984988075,0.7853981633974483,1.2847448850775784},3e-12),'weak values arctan2 978')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.arctan2(5,a)
 assert(r.dtype=='float64','weak dtype arctan2 979 '..r.dtype)
 assert(same(r:tolist(),{1.5707963267948966,1.373400766945016,0.7853981633974483,0.2860514417173182},3e-12),'weak values arctan2 979')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.arctan2(a,-1)
 assert(r.dtype=='float64','weak dtype arctan2 980 '..r.dtype)
 assert(same(r:tolist(),{3.141592653589793,2.356194490192345,1.7681918866447774,1.6295521495106193},3e-12),'weak values arctan2 980')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.arctan2(-1,a)
 assert(r.dtype=='float64','weak dtype arctan2 981 '..r.dtype)
 assert(same(r:tolist(),{-1.5707963267948966,-0.7853981633974483,-0.19739555984988075,-0.058755822715722696},3e-12),'weak values arctan2 981')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.arctan2(a,2)
 assert(r.dtype=='float16','weak dtype arctan2 982 '..r.dtype)
 assert(same(r:tolist(),{-0.89599609375,-0.0,0.55859375,1.29296875},0.006),'weak values arctan2 982')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.arctan2(2,a)
 assert(r.dtype=='float16','weak dtype arctan2 983 '..r.dtype)
 assert(same(r:tolist(),{2.466796875,1.5703125,1.01171875,0.2783203125},0.006),'weak values arctan2 983')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.arctan2(a,2.0)
 assert(r.dtype=='float16','weak dtype arctan2 984 '..r.dtype)
 assert(same(r:tolist(),{-0.89599609375,-0.0,0.55859375,1.29296875},0.006),'weak values arctan2 984')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.arctan2(2.0,a)
 assert(r.dtype=='float16','weak dtype arctan2 985 '..r.dtype)
 assert(same(r:tolist(),{2.466796875,1.5703125,1.01171875,0.2783203125},0.006),'weak values arctan2 985')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.arctan2(a,2)
 assert(r.dtype=='float32','weak dtype arctan2 986 '..r.dtype)
 assert(same(r:tolist(),{-0.8960554003715515,-0.0,0.5585993528366089,1.292496681213379},1e-05),'weak values arctan2 986')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.arctan2(2,a)
 assert(r.dtype=='float32','weak dtype arctan2 987 '..r.dtype)
 assert(same(r:tolist(),{2.4668517112731934,1.5707963705062866,1.0121970176696777,0.2782996594905853},1e-05),'weak values arctan2 987')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.arctan2(a,2.0)
 assert(r.dtype=='float32','weak dtype arctan2 988 '..r.dtype)
 assert(same(r:tolist(),{-0.8960554003715515,-0.0,0.5585993528366089,1.292496681213379},1e-05),'weak values arctan2 988')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.arctan2(2.0,a)
 assert(r.dtype=='float32','weak dtype arctan2 989 '..r.dtype)
 assert(same(r:tolist(),{2.4668517112731934,1.5707963705062866,1.0121970176696777,0.2782996594905853},1e-05),'weak values arctan2 989')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.arctan2(a,np.complex(0.0,2.0)) end)
 assert(not ok,'weak reject arctan2 990')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.arctan2(np.complex(0.0,2.0),a) end)
 assert(not ok,'weak reject arctan2 991')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.arctan2(a,2.0)
 assert(r.dtype=='float64','weak dtype arctan2 992 '..r.dtype)
 assert(same(r:tolist(),{-0.8960553845713439,-0.0,0.5585993153435624,1.2924966677897853},3e-12),'weak values arctan2 992')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.arctan2(2.0,a)
 assert(r.dtype=='float64','weak dtype arctan2 993 '..r.dtype)
 assert(same(r:tolist(),{2.4668517113662407,1.5707963267948966,1.0121970114513341,0.27829965900511133},3e-12),'weak values arctan2 993')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.arctan2(a,2) end)
 assert(not ok,'weak reject arctan2 994')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.arctan2(2,a) end)
 assert(not ok,'weak reject arctan2 995')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.arctan2(a,2.0) end)
 assert(not ok,'weak reject arctan2 996')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.arctan2(2.0,a) end)
 assert(not ok,'weak reject arctan2 997')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.arctan2(a,np.complex(1.0,2.0)) end)
 assert(not ok,'weak reject arctan2 998')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.arctan2(np.complex(1.0,2.0),a) end)
 assert(not ok,'weak reject arctan2 999')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.hypot(a,true)
 assert(r.dtype=='float16','weak dtype hypot 1000 '..r.dtype)
 assert(same(r:tolist(),{1.0,1.4140625,1.4140625,1.0},0.006),'weak values hypot 1000')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.hypot(true,a)
 assert(r.dtype=='float16','weak dtype hypot 1001 '..r.dtype)
 assert(same(r:tolist(),{1.0,1.4140625,1.4140625,1.0},0.006),'weak values hypot 1001')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.hypot(a,2)
 assert(r.dtype=='float64','weak dtype hypot 1002 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.23606797749979,2.23606797749979,2.0},3e-12),'weak values hypot 1002')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.hypot(2,a)
 assert(r.dtype=='float64','weak dtype hypot 1003 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.23606797749979,2.23606797749979,2.0},3e-12),'weak values hypot 1003')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.hypot(a,2)
 assert(r.dtype=='float16','weak dtype hypot 1004 '..r.dtype)
 assert(same(r:tolist(),{7.28125,2.236328125,2.828125,11.1796875},0.006),'weak values hypot 1004')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.hypot(2,a)
 assert(r.dtype=='float16','weak dtype hypot 1005 '..r.dtype)
 assert(same(r:tolist(),{7.28125,2.236328125,2.828125,11.1796875},0.006),'weak values hypot 1005')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.hypot(a,-3)
 assert(r.dtype=='float16','weak dtype hypot 1006 '..r.dtype)
 assert(same(r:tolist(),{7.6171875,3.162109375,3.60546875,11.3984375},0.006),'weak values hypot 1006')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.hypot(-3,a)
 assert(r.dtype=='float16','weak dtype hypot 1007 '..r.dtype)
 assert(same(r:tolist(),{7.6171875,3.162109375,3.60546875,11.3984375},0.006),'weak values hypot 1007')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.hypot(a,2)
 assert(r.dtype=='float16','weak dtype hypot 1008 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.236328125,5.38671875,17.125},0.006),'weak values hypot 1008')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.hypot(2,a)
 assert(r.dtype=='float16','weak dtype hypot 1009 '..r.dtype)
 assert(same(r:tolist(),{2.0,2.236328125,5.38671875,17.125},0.006),'weak values hypot 1009')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.hypot(a,300)
 assert(r.dtype=='float16','weak dtype hypot 1010 '..r.dtype)
 assert(same(r:tolist(),{300.0,300.0,300.0,300.5},0.006),'weak values hypot 1010')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.hypot(300,a)
 assert(r.dtype=='float16','weak dtype hypot 1011 '..r.dtype)
 assert(same(r:tolist(),{300.0,300.0,300.0,300.5},0.006),'weak values hypot 1011')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.hypot(a,-1)
 assert(r.dtype=='float16','weak dtype hypot 1012 '..r.dtype)
 assert(same(r:tolist(),{1.0,1.4140625,5.09765625,17.03125},0.006),'weak values hypot 1012')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.hypot(-1,a)
 assert(r.dtype=='float16','weak dtype hypot 1013 '..r.dtype)
 assert(same(r:tolist(),{1.0,1.4140625,5.09765625,17.03125},0.006),'weak values hypot 1013')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.hypot(a,127)
 assert(r.dtype=='float32','weak dtype hypot 1014 '..r.dtype)
 assert(same(r:tolist(),{127.19276428222656,127.00393676757812,127.0157470703125,127.4754867553711},1e-05),'weak values hypot 1014')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local r=np.hypot(127,a)
 assert(r.dtype=='float32','weak dtype hypot 1015 '..r.dtype)
 assert(same(r:tolist(),{127.19276428222656,127.00393676757812,127.0157470703125,127.4754867553711},1e-05),'weak values hypot 1015')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.hypot(a,5)
 assert(r.dtype=='float64','weak dtype hypot 1016 '..r.dtype)
 assert(same(r:tolist(),{8.602325267042627,5.0990195135927845,5.385164807134504,12.083045973594572},3e-12),'weak values hypot 1016')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.hypot(5,a)
 assert(r.dtype=='float64','weak dtype hypot 1017 '..r.dtype)
 assert(same(r:tolist(),{8.602325267042627,5.0990195135927845,5.385164807134504,12.083045973594572},3e-12),'weak values hypot 1017')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.hypot(a,5)
 assert(r.dtype=='float64','weak dtype hypot 1018 '..r.dtype)
 assert(same(r:tolist(),{5.0,5.0990195135927845,7.0710678118654755,17.72004514666935},3e-12),'weak values hypot 1018')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.hypot(5,a)
 assert(r.dtype=='float64','weak dtype hypot 1019 '..r.dtype)
 assert(same(r:tolist(),{5.0,5.0990195135927845,7.0710678118654755,17.72004514666935},3e-12),'weak values hypot 1019')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.hypot(a,-1)
 assert(r.dtype=='float64','weak dtype hypot 1020 '..r.dtype)
 assert(same(r:tolist(),{1.0,1.4142135623730951,5.0990195135927845,17.029386365926403},3e-12),'weak values hypot 1020')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.hypot(-1,a)
 assert(r.dtype=='float64','weak dtype hypot 1021 '..r.dtype)
 assert(same(r:tolist(),{1.0,1.4142135623730951,5.0990195135927845,17.029386365926403},3e-12),'weak values hypot 1021')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.hypot(a,2)
 assert(r.dtype=='float16','weak dtype hypot 1022 '..r.dtype)
 assert(same(r:tolist(),{3.201171875,2.0,2.359375,7.28125},0.006),'weak values hypot 1022')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.hypot(2,a)
 assert(r.dtype=='float16','weak dtype hypot 1023 '..r.dtype)
 assert(same(r:tolist(),{3.201171875,2.0,2.359375,7.28125},0.006),'weak values hypot 1023')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.hypot(a,2.0)
 assert(r.dtype=='float16','weak dtype hypot 1024 '..r.dtype)
 assert(same(r:tolist(),{3.201171875,2.0,2.359375,7.28125},0.006),'weak values hypot 1024')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.hypot(2.0,a)
 assert(r.dtype=='float16','weak dtype hypot 1025 '..r.dtype)
 assert(same(r:tolist(),{3.201171875,2.0,2.359375,7.28125},0.006),'weak values hypot 1025')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.hypot(a,2)
 assert(r.dtype=='float32','weak dtype hypot 1026 '..r.dtype)
 assert(same(r:tolist(),{3.2015621662139893,2.0,2.3584952354431152,7.280109882354736},1e-05),'weak values hypot 1026')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.hypot(2,a)
 assert(r.dtype=='float32','weak dtype hypot 1027 '..r.dtype)
 assert(same(r:tolist(),{3.2015621662139893,2.0,2.3584952354431152,7.280109882354736},1e-05),'weak values hypot 1027')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.hypot(a,2.0)
 assert(r.dtype=='float32','weak dtype hypot 1028 '..r.dtype)
 assert(same(r:tolist(),{3.2015621662139893,2.0,2.3584952354431152,7.280109882354736},1e-05),'weak values hypot 1028')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.hypot(2.0,a)
 assert(r.dtype=='float32','weak dtype hypot 1029 '..r.dtype)
 assert(same(r:tolist(),{3.2015621662139893,2.0,2.3584952354431152,7.280109882354736},1e-05),'weak values hypot 1029')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.hypot(a,np.complex(0.0,2.0)) end)
 assert(not ok,'weak reject hypot 1030')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local ok=pcall(function() return np.hypot(np.complex(0.0,2.0),a) end)
 assert(not ok,'weak reject hypot 1031')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.hypot(a,2.0)
 assert(r.dtype=='float64','weak dtype hypot 1032 '..r.dtype)
 assert(same(r:tolist(),{3.2015621187164243,2.0,2.358495283014151,7.280109889280518},3e-12),'weak values hypot 1032')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.hypot(2.0,a)
 assert(r.dtype=='float64','weak dtype hypot 1033 '..r.dtype)
 assert(same(r:tolist(),{3.2015621187164243,2.0,2.358495283014151,7.280109889280518},3e-12),'weak values hypot 1033')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.hypot(a,2) end)
 assert(not ok,'weak reject hypot 1034')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.hypot(2,a) end)
 assert(not ok,'weak reject hypot 1035')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.hypot(a,2.0) end)
 assert(not ok,'weak reject hypot 1036')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.hypot(2.0,a) end)
 assert(not ok,'weak reject hypot 1037')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.hypot(a,np.complex(1.0,2.0)) end)
 assert(not ok,'weak reject hypot 1038')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local ok=pcall(function() return np.hypot(np.complex(1.0,2.0),a) end)
 assert(not ok,'weak reject hypot 1039')
end
do
 local a=np.array({1,2},np.uint8)
 local r=np.add(a,2)
 assert(r.dtype=='uint8','explicit dtype 1040')
 assert(same(r:tolist(),{3,4},0.0),'explicit values 1040')
end
do
 local a=np.array({1,2},np.uint8)
 assert(not pcall(function() return np.add(a,300) end),'explicit reject 1041')
end
do
 local a=np.array({1,2},np.uint8)
 assert(not pcall(function() return np.add(a,-1) end),'explicit reject 1042')
end
do
 local a=np.array({1,2},np.uint8)
 local r=np.equal(a,300)
 assert(r.dtype=='bool','explicit dtype 1043')
 assert(same(r:tolist(),{false,false},0.0),'explicit values 1043')
end
do
 local a=np.array({1,2},np.uint8)
 local r=np.less(a,300)
 assert(r.dtype=='bool','explicit dtype 1044')
 assert(same(r:tolist(),{true,true},0.0),'explicit values 1044')
end
do
 local a=np.array({0,9223372036854775808},np.uint64)
 local r=np.greater(a,-1)
 assert(r.dtype=='bool','explicit dtype 1045')
 assert(same(r:tolist(),{true,true},0.0),'explicit values 1045')
end
do
 local a=np.array({1.0},np.float32)
 local r=np.add(a,3e+100)
 assert(r.dtype=='float32','explicit dtype 1046')
 assert(same(r:tolist(),{math.huge},1e-05),'explicit values 1046')
end
do
 local a=np.array({1.0},np.float32)
 local r=np.add(a,np.complex(1.0,2.0))
 assert(r.dtype=='complex64','explicit dtype 1047')
 assert(same(r:tolist(),{np.complex(2.0,2.0)},1e-05),'explicit values 1047')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.add(a,2.0,{out=o,where=m})
 assert(r==o,'weak out identity')
 assert(same(o:tolist(),{-0.5,80.0,3.25,60.0},3e-12),'weak out values 1048')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.maximum(a,2.0,{out=o,where=m})
 assert(r==o,'weak out identity')
 assert(same(o:tolist(),{2.0,80.0,2.0,60.0},3e-12),'weak out values 1049')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({true,false,false,true},np.bool)
 local r=np.equal(a,2,{out=o,where=m})
 assert(r==o,'weak out identity')
 assert(same(o:tolist(),{false,false,true,true},0.0),'weak out values 1050')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90,80,70,60},np.int16)
 local r=np.floor_divide(a,2,{out=o,where=m})
 assert(r==o,'weak out identity')
 assert(same(o:tolist(),{-4,80,1,60},0.0),'weak out values 1051')
end
do
 local a=np.array({0,1,2,3},np.int16)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90,80,70,60},np.int16)
 local r=np.power(a,2,{out=o,where=m})
 assert(r==o,'weak out identity')
 assert(same(o:tolist(),{0,80,4,60},0.0),'weak out values 1052')
end
do
 local a=np.array({-7,-1,2,11},np.int16)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90,80,70,60},np.int16)
 local r=np.bitwise_xor(a,3,{out=o,where=m})
 assert(r==o,'weak out identity')
 assert(same(o:tolist(),{-6,80,1,60},0.0),'weak out values 1053')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.copysign(a,-1.0,{out=o,where=m})
 assert(r==o,'weak out identity')
 assert(same(o:tolist(),{-2.5,80.0,-1.25,60.0},3e-12),'weak out values 1054')
end
do
 local a=np.array({1,2},np.uint8)
 local r=a + 2
 assert(r.dtype=='uint8','weak operator dtype 1055')
 assert(same(r:tolist(),{3,4},0.0),'weak operator values 1055')
end
do
 local a=np.array({2,5},np.int16)
 local r=a - 1
 assert(r.dtype=='int16','weak operator dtype 1056')
 assert(same(r:tolist(),{1,4},0.0),'weak operator values 1056')
end
do
 local a=np.array({1.0,2.0},np.float32)
 local r=a * 2.0
 assert(r.dtype=='float32','weak operator dtype 1057')
 assert(same(r:tolist(),{2.0,4.0},1e-05),'weak operator values 1057')
end
do
 local a=np.array({1.0,2.0},np.float32)
 local r=a / 2.0
 assert(r.dtype=='float32','weak operator dtype 1058')
 assert(same(r:tolist(),{0.5,1.0},1e-05),'weak operator values 1058')
end
do
 local a=np.array({5,7},np.int16)
 local r=a // 2
 assert(r.dtype=='int16','weak operator dtype 1059')
 assert(same(r:tolist(),{2,3},0.0),'weak operator values 1059')
end
do
 local a=np.array({5,7},np.int16)
 local r=a % 2
 assert(r.dtype=='int16','weak operator dtype 1060')
 assert(same(r:tolist(),{1,1},0.0),'weak operator values 1060')
end
do
 local a=np.array({2,3},np.int16)
 local r=a ^ 2
 assert(r.dtype=='int16','weak operator dtype 1061')
 assert(same(r:tolist(),{4,9},0.0),'weak operator values 1061')
end
do
 local a=np.array({3,7},np.int16)
 local r=a & 1
 assert(r.dtype=='int16','weak operator dtype 1062')
 assert(same(r:tolist(),{1,1},0.0),'weak operator values 1062')
end
do
 local a=np.array({2,4},np.int16)
 local r=a | 1
 assert(r.dtype=='int16','weak operator dtype 1063')
 assert(same(r:tolist(),{3,5},0.0),'weak operator values 1063')
end
do
 local a=np.array({2,4},np.int16)
 local r=a ~ 1
 assert(r.dtype=='int16','weak operator dtype 1064')
 assert(same(r:tolist(),{3,5},0.0),'weak operator values 1064')
end
print('weak scalar registry differential: 1065 cases ok')
