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
local function seqeq(a,b)
  if #a~=#b then return false end
  for i=1,#a do if a[i]~=b[i] then return false end end
  return true
end

-- Development oracle NumPy 2.3.5; semantics pinned to uploaded NumPy main.
do
 local a=np.array({false,true,true,false},np.bool)
 local b=np.array({false,true,true,false},np.bool)
 local r=np.add(a,b)
 assert(r.dtype=='bool','dtype add 0')
 assert(same(r:tolist(),{false,true,true,false},0.0),'values add 0')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local b=np.array({1,-3,5,2},np.int8)
 local r=np.add(a,b)
 assert(r.dtype=='int8','dtype add 1')
 assert(same(r:tolist(),{-6,-4,7,13},0.0),'values add 1')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local b=np.array({1,-3,5,2},np.int16)
 local r=np.add(a,b)
 assert(r.dtype=='int16','dtype add 2')
 assert(same(r:tolist(),{1,-2,10,19},0.0),'values add 2')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local b=np.array({1,2,7,3},np.uint64)
 local r=np.add(a,b)
 assert(r.dtype=='float64','dtype add 3')
 assert(same(r:tolist(),{-6.0,1.0,9.0,14.0},2e-12),'values add 3')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local b=np.array({1,-3,5,2},np.int64)
 local r=np.add(a,b)
 assert(r.dtype=='float64','dtype add 4')
 assert(same(r:tolist(),{1.0,-2.0,10.0,19.0},2e-12),'values add 4')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local b=np.array({1,-3,5,2},np.int8)
 local r=np.add(a,b)
 assert(r.dtype=='float16','dtype add 5')
 assert(same(r:tolist(),{-1.5,-3.0,6.25,9.0},0.006),'values add 5')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float64)
 local r=np.add(a,b)
 assert(r.dtype=='float64','dtype add 6')
 assert(same(r:tolist(),{-1.5,-2.0,1.75,11.0},2e-12),'values add 6')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local b=np.array({1,2,7,3},np.uint64)
 local r=np.add(a,b)
 assert(r.dtype=='float64','dtype add 7')
 assert(same(r:tolist(),{-1.5,2.0,8.25,10.0},2e-12),'values add 7')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float32)
 local r=np.add(a,b)
 assert(r.dtype=='complex64','dtype add 8')
 assert(same(r:tolist(),{np.complex(-1.5,1.0),np.complex(-2.0,-2.0),np.complex(1.75,0.5),np.complex(11.0,-3.0)},8e-06),'values add 8')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex128)
 local b=np.array({np.complex(1.0,0.5),np.complex(-2.0,1.0),np.complex(0.5,-1.0),np.complex(4.0,2.0)},np.complex64)
 local r=np.add(a,b)
 assert(r.dtype=='complex128','dtype add 9')
 assert(same(r:tolist(),{np.complex(-1.5,1.5),np.complex(-2.0,-1.0),np.complex(1.75,-0.5),np.complex(11.0,-1.0)},2e-12),'values add 9')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local b=np.array({false,true,true,false},np.bool)
 assert(not pcall(function() np.subtract(a,b) end),'reject subtract 10')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local b=np.array({1,-3,5,2},np.int8)
 local r=np.subtract(a,b)
 assert(r.dtype=='int8','dtype subtract 11')
 assert(same(r:tolist(),{-8,2,-3,9},0.0),'values subtract 11')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local b=np.array({1,-3,5,2},np.int16)
 local r=np.subtract(a,b)
 assert(r.dtype=='int16','dtype subtract 12')
 assert(same(r:tolist(),{-1,4,0,15},0.0),'values subtract 12')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local b=np.array({1,2,7,3},np.uint64)
 local r=np.subtract(a,b)
 assert(r.dtype=='float64','dtype subtract 13')
 assert(same(r:tolist(),{-8.0,-3.0,-5.0,8.0},2e-12),'values subtract 13')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local b=np.array({1,-3,5,2},np.int64)
 local r=np.subtract(a,b)
 assert(r.dtype=='float64','dtype subtract 14')
 assert(same(r:tolist(),{-1.0,4.0,0.0,15.0},2e-12),'values subtract 14')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local b=np.array({1,-3,5,2},np.int8)
 local r=np.subtract(a,b)
 assert(r.dtype=='float16','dtype subtract 15')
 assert(same(r:tolist(),{-3.5,3.0,-3.75,5.0},0.006),'values subtract 15')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float64)
 local r=np.subtract(a,b)
 assert(r.dtype=='float64','dtype subtract 16')
 assert(same(r:tolist(),{-3.5,2.0,0.75,3.0},2e-12),'values subtract 16')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local b=np.array({1,2,7,3},np.uint64)
 local r=np.subtract(a,b)
 assert(r.dtype=='float64','dtype subtract 17')
 assert(same(r:tolist(),{-3.5,-2.0,-5.75,4.0},2e-12),'values subtract 17')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float32)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex64','dtype subtract 18')
 assert(same(r:tolist(),{np.complex(-3.5,1.0),np.complex(2.0,-2.0),np.complex(0.75,0.5),np.complex(3.0,-3.0)},8e-06),'values subtract 18')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex128)
 local b=np.array({np.complex(1.0,0.5),np.complex(-2.0,1.0),np.complex(0.5,-1.0),np.complex(4.0,2.0)},np.complex64)
 local r=np.subtract(a,b)
 assert(r.dtype=='complex128','dtype subtract 19')
 assert(same(r:tolist(),{np.complex(-3.5,0.5),np.complex(2.0,-3.0),np.complex(0.75,1.5),np.complex(3.0,-5.0)},2e-12),'values subtract 19')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local b=np.array({false,true,true,false},np.bool)
 local r=np.multiply(a,b)
 assert(r.dtype=='bool','dtype multiply 20')
 assert(same(r:tolist(),{false,true,true,false},0.0),'values multiply 20')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local b=np.array({1,-3,5,2},np.int8)
 local r=np.multiply(a,b)
 assert(r.dtype=='int8','dtype multiply 21')
 assert(same(r:tolist(),{-7,3,10,22},0.0),'values multiply 21')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local b=np.array({1,-3,5,2},np.int16)
 local r=np.multiply(a,b)
 assert(r.dtype=='int16','dtype multiply 22')
 assert(same(r:tolist(),{0,-3,25,34},0.0),'values multiply 22')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local b=np.array({1,2,7,3},np.uint64)
 local r=np.multiply(a,b)
 assert(r.dtype=='float64','dtype multiply 23')
 assert(same(r:tolist(),{-7.0,-2.0,14.0,33.0},2e-12),'values multiply 23')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local b=np.array({1,-3,5,2},np.int64)
 local r=np.multiply(a,b)
 assert(r.dtype=='float64','dtype multiply 24')
 assert(same(r:tolist(),{0.0,-3.0,25.0,34.0},2e-12),'values multiply 24')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local b=np.array({1,-3,5,2},np.int8)
 local r=np.multiply(a,b)
 assert(r.dtype=='float16','dtype multiply 25')
 assert(same(r:tolist(),{-2.5,0.0,6.25,14.0},0.006),'values multiply 25')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float64)
 local r=np.multiply(a,b)
 assert(r.dtype=='float64','dtype multiply 26')
 assert(same(r:tolist(),{-2.5,0.0,0.625,28.0},2e-12),'values multiply 26')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local b=np.array({1,2,7,3},np.uint64)
 local r=np.multiply(a,b)
 assert(r.dtype=='float64','dtype multiply 27')
 assert(same(r:tolist(),{-2.5,-0.0,8.75,21.0},2e-12),'values multiply 27')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float32)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex64','dtype multiply 28')
 assert(same(r:tolist(),{np.complex(-2.5,1.0),np.complex(0.0,4.0),np.complex(0.625,0.25),np.complex(28.0,-12.0)},8e-06),'values multiply 28')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex128)
 local b=np.array({np.complex(1.0,0.5),np.complex(-2.0,1.0),np.complex(0.5,-1.0),np.complex(4.0,2.0)},np.complex64)
 local r=np.multiply(a,b)
 assert(r.dtype=='complex128','dtype multiply 29')
 assert(same(r:tolist(),{np.complex(-3.0,-0.25),np.complex(2.0,4.0),np.complex(1.125,-1.0),np.complex(34.0,2.0)},2e-12),'values multiply 29')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local b=np.array({true,true,true,true},np.bool)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float64','dtype true_divide 30')
 assert(same(r:tolist(),{0.0,1.0,1.0,0.0},2e-12),'values true_divide 30')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local b=np.array({1,2,5,2},np.int8)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float64','dtype true_divide 31')
 assert(same(r:tolist(),{-7.0,-0.5,0.4,5.5},2e-12),'values true_divide 31')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local b=np.array({1,2,5,2},np.int16)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float64','dtype true_divide 32')
 assert(same(r:tolist(),{0.0,0.5,1.0,8.5},2e-12),'values true_divide 32')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local b=np.array({1,2,5,2},np.uint64)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float64','dtype true_divide 33')
 assert(same(r:tolist(),{-7.0,-0.5,0.4,5.5},2e-12),'values true_divide 33')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local b=np.array({1,2,5,2},np.int64)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float64','dtype true_divide 34')
 assert(same(r:tolist(),{0.0,0.5,1.0,8.5},2e-12),'values true_divide 34')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local b=np.array({1,2,5,2},np.int8)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float16','dtype true_divide 35')
 assert(same(r:tolist(),{-2.5,-0.0,0.25,3.5},0.006),'values true_divide 35')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float64)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float64','dtype true_divide 36')
 assert(same(r:tolist(),{-2.5,0.0,2.5,1.75},2e-12),'values true_divide 36')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local b=np.array({1,2,5,2},np.uint64)
 local r=np.true_divide(a,b)
 assert(r.dtype=='float64','dtype true_divide 37')
 assert(same(r:tolist(),{-2.5,-0.0,0.25,3.5},2e-12),'values true_divide 37')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float32)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex64','dtype true_divide 38')
 assert(same(r:tolist(),{np.complex(-2.5,1.0),np.complex(-0.0,1.0),np.complex(2.5,1.0),np.complex(1.75,-0.75)},8e-06),'values true_divide 38')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex128)
 local b=np.array({np.complex(1.0,0.5),np.complex(-2.0,1.0),np.complex(0.5,-1.0),np.complex(4.0,2.0)},np.complex64)
 local r=np.true_divide(a,b)
 assert(r.dtype=='complex128','dtype true_divide 39')
 assert(same(r:tolist(),{np.complex(-1.6,1.8),np.complex(-0.4,0.8),np.complex(0.1,1.2000000000000002),np.complex(1.1,-1.3)},2e-12),'values true_divide 39')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local b=np.array({false,true,true,false},np.bool)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','dtype equal 40')
 assert(same(r:tolist(),{true,true,true,true},0.0),'values equal 40')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local b=np.array({1,-3,5,2},np.int8)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','dtype equal 41')
 assert(same(r:tolist(),{false,false,false,false},0.0),'values equal 41')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local b=np.array({1,-3,5,2},np.int16)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','dtype equal 42')
 assert(same(r:tolist(),{false,false,true,false},0.0),'values equal 42')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local b=np.array({1,2,7,3},np.uint64)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','dtype equal 43')
 assert(same(r:tolist(),{false,false,false,false},0.0),'values equal 43')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local b=np.array({1,-3,5,2},np.int64)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','dtype equal 44')
 assert(same(r:tolist(),{false,false,true,false},0.0),'values equal 44')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local b=np.array({1,-3,5,2},np.int8)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','dtype equal 45')
 assert(same(r:tolist(),{false,false,false,false},0.0),'values equal 45')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float64)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','dtype equal 46')
 assert(same(r:tolist(),{false,false,false,false},0.0),'values equal 46')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local b=np.array({1,2,7,3},np.uint64)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','dtype equal 47')
 assert(same(r:tolist(),{false,false,false,false},0.0),'values equal 47')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float32)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','dtype equal 48')
 assert(same(r:tolist(),{false,false,false,false},0.0),'values equal 48')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex128)
 local b=np.array({np.complex(1.0,0.5),np.complex(-2.0,1.0),np.complex(0.5,-1.0),np.complex(4.0,2.0)},np.complex64)
 local r=np.equal(a,b)
 assert(r.dtype=='bool','dtype equal 49')
 assert(same(r:tolist(),{false,false,false,false},0.0),'values equal 49')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local b=np.array({false,true,true,false},np.bool)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','dtype not_equal 50')
 assert(same(r:tolist(),{false,false,false,false},0.0),'values not_equal 50')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local b=np.array({1,-3,5,2},np.int8)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','dtype not_equal 51')
 assert(same(r:tolist(),{true,true,true,true},0.0),'values not_equal 51')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local b=np.array({1,-3,5,2},np.int16)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','dtype not_equal 52')
 assert(same(r:tolist(),{true,true,false,true},0.0),'values not_equal 52')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local b=np.array({1,2,7,3},np.uint64)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','dtype not_equal 53')
 assert(same(r:tolist(),{true,true,true,true},0.0),'values not_equal 53')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local b=np.array({1,-3,5,2},np.int64)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','dtype not_equal 54')
 assert(same(r:tolist(),{true,true,false,true},0.0),'values not_equal 54')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local b=np.array({1,-3,5,2},np.int8)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','dtype not_equal 55')
 assert(same(r:tolist(),{true,true,true,true},0.0),'values not_equal 55')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float64)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','dtype not_equal 56')
 assert(same(r:tolist(),{true,true,true,true},0.0),'values not_equal 56')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local b=np.array({1,2,7,3},np.uint64)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','dtype not_equal 57')
 assert(same(r:tolist(),{true,true,true,true},0.0),'values not_equal 57')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float32)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','dtype not_equal 58')
 assert(same(r:tolist(),{true,true,true,true},0.0),'values not_equal 58')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex128)
 local b=np.array({np.complex(1.0,0.5),np.complex(-2.0,1.0),np.complex(0.5,-1.0),np.complex(4.0,2.0)},np.complex64)
 local r=np.not_equal(a,b)
 assert(r.dtype=='bool','dtype not_equal 59')
 assert(same(r:tolist(),{true,true,true,true},0.0),'values not_equal 59')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local b=np.array({false,true,true,false},np.bool)
 local r=np.less(a,b)
 assert(r.dtype=='bool','dtype less 60')
 assert(same(r:tolist(),{false,false,false,false},0.0),'values less 60')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local b=np.array({1,-3,5,2},np.int8)
 local r=np.less(a,b)
 assert(r.dtype=='bool','dtype less 61')
 assert(same(r:tolist(),{true,false,true,false},0.0),'values less 61')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local b=np.array({1,-3,5,2},np.int16)
 local r=np.less(a,b)
 assert(r.dtype=='bool','dtype less 62')
 assert(same(r:tolist(),{true,false,false,false},0.0),'values less 62')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local b=np.array({1,2,7,3},np.uint64)
 local r=np.less(a,b)
 assert(r.dtype=='bool','dtype less 63')
 assert(same(r:tolist(),{true,true,true,false},0.0),'values less 63')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local b=np.array({1,-3,5,2},np.int64)
 local r=np.less(a,b)
 assert(r.dtype=='bool','dtype less 64')
 assert(same(r:tolist(),{true,false,false,false},0.0),'values less 64')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local b=np.array({1,-3,5,2},np.int8)
 local r=np.less(a,b)
 assert(r.dtype=='bool','dtype less 65')
 assert(same(r:tolist(),{true,false,true,false},0.0),'values less 65')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float64)
 local r=np.less(a,b)
 assert(r.dtype=='bool','dtype less 66')
 assert(same(r:tolist(),{true,false,false,false},0.0),'values less 66')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local b=np.array({1,2,7,3},np.uint64)
 local r=np.less(a,b)
 assert(r.dtype=='bool','dtype less 67')
 assert(same(r:tolist(),{true,true,true,false},0.0),'values less 67')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float32)
 local r=np.less(a,b)
 assert(r.dtype=='bool','dtype less 68')
 assert(same(r:tolist(),{true,false,false,false},0.0),'values less 68')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex128)
 local b=np.array({np.complex(1.0,0.5),np.complex(-2.0,1.0),np.complex(0.5,-1.0),np.complex(4.0,2.0)},np.complex64)
 local r=np.less(a,b)
 assert(r.dtype=='bool','dtype less 69')
 assert(same(r:tolist(),{true,false,false,false},0.0),'values less 69')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local b=np.array({false,true,true,false},np.bool)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','dtype less_equal 70')
 assert(same(r:tolist(),{true,true,true,true},0.0),'values less_equal 70')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local b=np.array({1,-3,5,2},np.int8)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','dtype less_equal 71')
 assert(same(r:tolist(),{true,false,true,false},0.0),'values less_equal 71')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local b=np.array({1,-3,5,2},np.int16)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','dtype less_equal 72')
 assert(same(r:tolist(),{true,false,true,false},0.0),'values less_equal 72')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local b=np.array({1,2,7,3},np.uint64)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','dtype less_equal 73')
 assert(same(r:tolist(),{true,true,true,false},0.0),'values less_equal 73')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local b=np.array({1,-3,5,2},np.int64)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','dtype less_equal 74')
 assert(same(r:tolist(),{true,false,true,false},0.0),'values less_equal 74')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local b=np.array({1,-3,5,2},np.int8)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','dtype less_equal 75')
 assert(same(r:tolist(),{true,false,true,false},0.0),'values less_equal 75')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float64)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','dtype less_equal 76')
 assert(same(r:tolist(),{true,false,false,false},0.0),'values less_equal 76')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local b=np.array({1,2,7,3},np.uint64)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','dtype less_equal 77')
 assert(same(r:tolist(),{true,true,true,false},0.0),'values less_equal 77')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float32)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','dtype less_equal 78')
 assert(same(r:tolist(),{true,false,false,false},0.0),'values less_equal 78')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex128)
 local b=np.array({np.complex(1.0,0.5),np.complex(-2.0,1.0),np.complex(0.5,-1.0),np.complex(4.0,2.0)},np.complex64)
 local r=np.less_equal(a,b)
 assert(r.dtype=='bool','dtype less_equal 79')
 assert(same(r:tolist(),{true,false,false,false},0.0),'values less_equal 79')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local b=np.array({false,true,true,false},np.bool)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','dtype greater 80')
 assert(same(r:tolist(),{false,false,false,false},0.0),'values greater 80')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local b=np.array({1,-3,5,2},np.int8)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','dtype greater 81')
 assert(same(r:tolist(),{false,true,false,true},0.0),'values greater 81')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local b=np.array({1,-3,5,2},np.int16)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','dtype greater 82')
 assert(same(r:tolist(),{false,true,false,true},0.0),'values greater 82')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local b=np.array({1,2,7,3},np.uint64)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','dtype greater 83')
 assert(same(r:tolist(),{false,false,false,true},0.0),'values greater 83')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local b=np.array({1,-3,5,2},np.int64)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','dtype greater 84')
 assert(same(r:tolist(),{false,true,false,true},0.0),'values greater 84')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local b=np.array({1,-3,5,2},np.int8)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','dtype greater 85')
 assert(same(r:tolist(),{false,true,false,true},0.0),'values greater 85')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float64)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','dtype greater 86')
 assert(same(r:tolist(),{false,true,true,true},0.0),'values greater 86')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local b=np.array({1,2,7,3},np.uint64)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','dtype greater 87')
 assert(same(r:tolist(),{false,false,false,true},0.0),'values greater 87')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float32)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','dtype greater 88')
 assert(same(r:tolist(),{false,true,true,true},0.0),'values greater 88')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex128)
 local b=np.array({np.complex(1.0,0.5),np.complex(-2.0,1.0),np.complex(0.5,-1.0),np.complex(4.0,2.0)},np.complex64)
 local r=np.greater(a,b)
 assert(r.dtype=='bool','dtype greater 89')
 assert(same(r:tolist(),{false,true,true,true},0.0),'values greater 89')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local b=np.array({false,true,true,false},np.bool)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','dtype greater_equal 90')
 assert(same(r:tolist(),{true,true,true,true},0.0),'values greater_equal 90')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local b=np.array({1,-3,5,2},np.int8)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','dtype greater_equal 91')
 assert(same(r:tolist(),{false,true,false,true},0.0),'values greater_equal 91')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local b=np.array({1,-3,5,2},np.int16)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','dtype greater_equal 92')
 assert(same(r:tolist(),{false,true,true,true},0.0),'values greater_equal 92')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local b=np.array({1,2,7,3},np.uint64)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','dtype greater_equal 93')
 assert(same(r:tolist(),{false,false,false,true},0.0),'values greater_equal 93')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local b=np.array({1,-3,5,2},np.int64)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','dtype greater_equal 94')
 assert(same(r:tolist(),{false,true,true,true},0.0),'values greater_equal 94')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local b=np.array({1,-3,5,2},np.int8)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','dtype greater_equal 95')
 assert(same(r:tolist(),{false,true,false,true},0.0),'values greater_equal 95')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float64)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','dtype greater_equal 96')
 assert(same(r:tolist(),{false,true,true,true},0.0),'values greater_equal 96')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local b=np.array({1,2,7,3},np.uint64)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','dtype greater_equal 97')
 assert(same(r:tolist(),{false,false,false,true},0.0),'values greater_equal 97')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float32)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','dtype greater_equal 98')
 assert(same(r:tolist(),{false,true,true,true},0.0),'values greater_equal 98')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex128)
 local b=np.array({np.complex(1.0,0.5),np.complex(-2.0,1.0),np.complex(0.5,-1.0),np.complex(4.0,2.0)},np.complex64)
 local r=np.greater_equal(a,b)
 assert(r.dtype=='bool','dtype greater_equal 99')
 assert(same(r:tolist(),{false,true,true,true},0.0),'values greater_equal 99')
end
do
 local a=np.array({false,true,true,false},np.bool)
 assert(not pcall(function() np.negative(a) end),'unary reject negative 100')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.negative(a)
 assert(r.dtype=='int8','unary dtype negative 101')
 assert(same(r:tolist(),{7,1,-2,-11},0.0),'unary values negative 101')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.negative(a)
 assert(r.dtype=='uint8','unary dtype negative 102')
 assert(same(r:tolist(),{0,255,251,239},0.0),'unary values negative 102')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.negative(a)
 assert(r.dtype=='int64','unary dtype negative 103')
 assert(same(r:tolist(),{7,1,-2,-11},0.0),'unary values negative 103')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.negative(a)
 assert(r.dtype=='uint64','unary dtype negative 104')
 assert(same(r:tolist(),{0,18446744073709551615,18446744073709551611,18446744073709551599},0.0),'unary values negative 104')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.negative(a)
 assert(r.dtype=='float16','unary dtype negative 105')
 assert(same(r:tolist(),{2.5,0.0,-1.25,-7.0},0.006),'unary values negative 105')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.negative(a)
 assert(r.dtype=='float32','unary dtype negative 106')
 assert(same(r:tolist(),{2.5,0.0,-1.25,-7.0},8e-06),'unary values negative 106')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.negative(a)
 assert(r.dtype=='float64','unary dtype negative 107')
 assert(same(r:tolist(),{2.5,0.0,-1.25,-7.0},2e-12),'unary values negative 107')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.negative(a)
 assert(r.dtype=='complex64','unary dtype negative 108')
 assert(same(r:tolist(),{np.complex(2.5,-1.0),np.complex(0.0,2.0),np.complex(-1.25,-0.5),np.complex(-7.0,3.0)},8e-06),'unary values negative 108')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex128)
 local r=np.negative(a)
 assert(r.dtype=='complex128','unary dtype negative 109')
 assert(same(r:tolist(),{np.complex(2.5,-1.0),np.complex(0.0,2.0),np.complex(-1.25,-0.5),np.complex(-7.0,3.0)},2e-12),'unary values negative 109')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.absolute(a)
 assert(r.dtype=='bool','unary dtype absolute 110')
 assert(same(r:tolist(),{false,true,true,false},0.0),'unary values absolute 110')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.absolute(a)
 assert(r.dtype=='int8','unary dtype absolute 111')
 assert(same(r:tolist(),{7,1,2,11},0.0),'unary values absolute 111')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.absolute(a)
 assert(r.dtype=='uint8','unary dtype absolute 112')
 assert(same(r:tolist(),{0,1,5,17},0.0),'unary values absolute 112')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.absolute(a)
 assert(r.dtype=='int64','unary dtype absolute 113')
 assert(same(r:tolist(),{7,1,2,11},0.0),'unary values absolute 113')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.absolute(a)
 assert(r.dtype=='uint64','unary dtype absolute 114')
 assert(same(r:tolist(),{0,1,5,17},0.0),'unary values absolute 114')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.absolute(a)
 assert(r.dtype=='float16','unary dtype absolute 115')
 assert(same(r:tolist(),{2.5,0.0,1.25,7.0},0.006),'unary values absolute 115')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.absolute(a)
 assert(r.dtype=='float32','unary dtype absolute 116')
 assert(same(r:tolist(),{2.5,0.0,1.25,7.0},8e-06),'unary values absolute 116')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.absolute(a)
 assert(r.dtype=='float64','unary dtype absolute 117')
 assert(same(r:tolist(),{2.5,0.0,1.25,7.0},2e-12),'unary values absolute 117')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.absolute(a)
 assert(r.dtype=='float32','unary dtype absolute 118')
 assert(same(r:tolist(),{2.692582368850708,2.0,1.346291184425354,7.6157732009887695},8e-06),'unary values absolute 118')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex128)
 local r=np.absolute(a)
 assert(r.dtype=='float64','unary dtype absolute 119')
 assert(same(r:tolist(),{2.692582403567252,2.0,1.346291201783626,7.615773105863909},2e-12),'unary values absolute 119')
end
do
 local a=np.array({false,true,true,false},np.bool)
 assert(not pcall(function() np.positive(a) end),'unary reject positive 120')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.positive(a)
 assert(r.dtype=='int8','unary dtype positive 121')
 assert(same(r:tolist(),{-7,-1,2,11},0.0),'unary values positive 121')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.positive(a)
 assert(r.dtype=='uint8','unary dtype positive 122')
 assert(same(r:tolist(),{0,1,5,17},0.0),'unary values positive 122')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.positive(a)
 assert(r.dtype=='int64','unary dtype positive 123')
 assert(same(r:tolist(),{-7,-1,2,11},0.0),'unary values positive 123')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.positive(a)
 assert(r.dtype=='uint64','unary dtype positive 124')
 assert(same(r:tolist(),{0,1,5,17},0.0),'unary values positive 124')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.positive(a)
 assert(r.dtype=='float16','unary dtype positive 125')
 assert(same(r:tolist(),{-2.5,-0.0,1.25,7.0},0.006),'unary values positive 125')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.positive(a)
 assert(r.dtype=='float32','unary dtype positive 126')
 assert(same(r:tolist(),{-2.5,-0.0,1.25,7.0},8e-06),'unary values positive 126')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.positive(a)
 assert(r.dtype=='float64','unary dtype positive 127')
 assert(same(r:tolist(),{-2.5,-0.0,1.25,7.0},2e-12),'unary values positive 127')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.positive(a)
 assert(r.dtype=='complex64','unary dtype positive 128')
 assert(same(r:tolist(),{np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},8e-06),'unary values positive 128')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex128)
 local r=np.positive(a)
 assert(r.dtype=='complex128','unary dtype positive 129')
 assert(same(r:tolist(),{np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},2e-12),'unary values positive 129')
end
do
 local a=np.array({false,true,true,false},np.bool)
 assert(not pcall(function() np.sign(a) end),'unary reject sign 130')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.sign(a)
 assert(r.dtype=='int8','unary dtype sign 131')
 assert(same(r:tolist(),{-1,-1,1,1},0.0),'unary values sign 131')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.sign(a)
 assert(r.dtype=='uint8','unary dtype sign 132')
 assert(same(r:tolist(),{0,1,1,1},0.0),'unary values sign 132')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.sign(a)
 assert(r.dtype=='int64','unary dtype sign 133')
 assert(same(r:tolist(),{-1,-1,1,1},0.0),'unary values sign 133')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.sign(a)
 assert(r.dtype=='uint64','unary dtype sign 134')
 assert(same(r:tolist(),{0,1,1,1},0.0),'unary values sign 134')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.sign(a)
 assert(r.dtype=='float16','unary dtype sign 135')
 assert(same(r:tolist(),{-1.0,0.0,1.0,1.0},0.006),'unary values sign 135')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.sign(a)
 assert(r.dtype=='float32','unary dtype sign 136')
 assert(same(r:tolist(),{-1.0,0.0,1.0,1.0},8e-06),'unary values sign 136')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.sign(a)
 assert(r.dtype=='float64','unary dtype sign 137')
 assert(same(r:tolist(),{-1.0,0.0,1.0,1.0},2e-12),'unary values sign 137')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.sign(a)
 assert(r.dtype=='complex64','unary dtype sign 138')
 assert(same(r:tolist(),{np.complex(-0.9284766912460327,0.3713906705379486),np.complex(-0.0,-1.0),np.complex(0.9284766912460327,0.3713906705379486),np.complex(0.9191450476646423,-0.39391928911209106)},8e-06),'unary values sign 138')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex128)
 local r=np.sign(a)
 assert(r.dtype=='complex128','unary dtype sign 139')
 assert(same(r:tolist(),{np.complex(-0.9284766908852594,0.3713906763541037),np.complex(-0.0,-1.0),np.complex(0.9284766908852594,0.3713906763541037),np.complex(0.9191450300180578,-0.39391929857916763)},2e-12),'unary values sign 139')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.logical_not(a)
 assert(r.dtype=='bool','unary dtype logical_not 140')
 assert(same(r:tolist(),{true,false,false,true},0.0),'unary values logical_not 140')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.logical_not(a)
 assert(r.dtype=='bool','unary dtype logical_not 141')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values logical_not 141')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.logical_not(a)
 assert(r.dtype=='bool','unary dtype logical_not 142')
 assert(same(r:tolist(),{true,false,false,false},0.0),'unary values logical_not 142')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.logical_not(a)
 assert(r.dtype=='bool','unary dtype logical_not 143')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values logical_not 143')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.logical_not(a)
 assert(r.dtype=='bool','unary dtype logical_not 144')
 assert(same(r:tolist(),{true,false,false,false},0.0),'unary values logical_not 144')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.logical_not(a)
 assert(r.dtype=='bool','unary dtype logical_not 145')
 assert(same(r:tolist(),{false,true,false,false},0.0),'unary values logical_not 145')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.logical_not(a)
 assert(r.dtype=='bool','unary dtype logical_not 146')
 assert(same(r:tolist(),{false,true,false,false},0.0),'unary values logical_not 146')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.logical_not(a)
 assert(r.dtype=='bool','unary dtype logical_not 147')
 assert(same(r:tolist(),{false,true,false,false},0.0),'unary values logical_not 147')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.logical_not(a)
 assert(r.dtype=='bool','unary dtype logical_not 148')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values logical_not 148')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex128)
 local r=np.logical_not(a)
 assert(r.dtype=='bool','unary dtype logical_not 149')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values logical_not 149')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.isnan(a)
 assert(r.dtype=='bool','unary dtype isnan 150')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values isnan 150')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.isnan(a)
 assert(r.dtype=='bool','unary dtype isnan 151')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values isnan 151')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.isnan(a)
 assert(r.dtype=='bool','unary dtype isnan 152')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values isnan 152')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.isnan(a)
 assert(r.dtype=='bool','unary dtype isnan 153')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values isnan 153')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.isnan(a)
 assert(r.dtype=='bool','unary dtype isnan 154')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values isnan 154')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.isnan(a)
 assert(r.dtype=='bool','unary dtype isnan 155')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values isnan 155')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.isnan(a)
 assert(r.dtype=='bool','unary dtype isnan 156')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values isnan 156')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.isnan(a)
 assert(r.dtype=='bool','unary dtype isnan 157')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values isnan 157')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.isnan(a)
 assert(r.dtype=='bool','unary dtype isnan 158')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values isnan 158')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex128)
 local r=np.isnan(a)
 assert(r.dtype=='bool','unary dtype isnan 159')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values isnan 159')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.isinf(a)
 assert(r.dtype=='bool','unary dtype isinf 160')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values isinf 160')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.isinf(a)
 assert(r.dtype=='bool','unary dtype isinf 161')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values isinf 161')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.isinf(a)
 assert(r.dtype=='bool','unary dtype isinf 162')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values isinf 162')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.isinf(a)
 assert(r.dtype=='bool','unary dtype isinf 163')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values isinf 163')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.isinf(a)
 assert(r.dtype=='bool','unary dtype isinf 164')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values isinf 164')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.isinf(a)
 assert(r.dtype=='bool','unary dtype isinf 165')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values isinf 165')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.isinf(a)
 assert(r.dtype=='bool','unary dtype isinf 166')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values isinf 166')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.isinf(a)
 assert(r.dtype=='bool','unary dtype isinf 167')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values isinf 167')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.isinf(a)
 assert(r.dtype=='bool','unary dtype isinf 168')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values isinf 168')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex128)
 local r=np.isinf(a)
 assert(r.dtype=='bool','unary dtype isinf 169')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values isinf 169')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.isfinite(a)
 assert(r.dtype=='bool','unary dtype isfinite 170')
 assert(same(r:tolist(),{true,true,true,true},0.0),'unary values isfinite 170')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.isfinite(a)
 assert(r.dtype=='bool','unary dtype isfinite 171')
 assert(same(r:tolist(),{true,true,true,true},0.0),'unary values isfinite 171')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.isfinite(a)
 assert(r.dtype=='bool','unary dtype isfinite 172')
 assert(same(r:tolist(),{true,true,true,true},0.0),'unary values isfinite 172')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.isfinite(a)
 assert(r.dtype=='bool','unary dtype isfinite 173')
 assert(same(r:tolist(),{true,true,true,true},0.0),'unary values isfinite 173')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.isfinite(a)
 assert(r.dtype=='bool','unary dtype isfinite 174')
 assert(same(r:tolist(),{true,true,true,true},0.0),'unary values isfinite 174')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.isfinite(a)
 assert(r.dtype=='bool','unary dtype isfinite 175')
 assert(same(r:tolist(),{true,true,true,true},0.0),'unary values isfinite 175')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.isfinite(a)
 assert(r.dtype=='bool','unary dtype isfinite 176')
 assert(same(r:tolist(),{true,true,true,true},0.0),'unary values isfinite 176')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.isfinite(a)
 assert(r.dtype=='bool','unary dtype isfinite 177')
 assert(same(r:tolist(),{true,true,true,true},0.0),'unary values isfinite 177')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 local r=np.isfinite(a)
 assert(r.dtype=='bool','unary dtype isfinite 178')
 assert(same(r:tolist(),{true,true,true,true},0.0),'unary values isfinite 178')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex128)
 local r=np.isfinite(a)
 assert(r.dtype=='bool','unary dtype isfinite 179')
 assert(same(r:tolist(),{true,true,true,true},0.0),'unary values isfinite 179')
end
do
 local a=np.array({false,true,true,false},np.bool)
 local r=np.signbit(a)
 assert(r.dtype=='bool','unary dtype signbit 180')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values signbit 180')
end
do
 local a=np.array({-7,-1,2,11},np.int8)
 local r=np.signbit(a)
 assert(r.dtype=='bool','unary dtype signbit 181')
 assert(same(r:tolist(),{true,true,false,false},0.0),'unary values signbit 181')
end
do
 local a=np.array({0,1,5,17},np.uint8)
 local r=np.signbit(a)
 assert(r.dtype=='bool','unary dtype signbit 182')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values signbit 182')
end
do
 local a=np.array({-7,-1,2,11},np.int64)
 local r=np.signbit(a)
 assert(r.dtype=='bool','unary dtype signbit 183')
 assert(same(r:tolist(),{true,true,false,false},0.0),'unary values signbit 183')
end
do
 local a=np.array({0,1,5,17},np.uint64)
 local r=np.signbit(a)
 assert(r.dtype=='bool','unary dtype signbit 184')
 assert(same(r:tolist(),{false,false,false,false},0.0),'unary values signbit 184')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float16)
 local r=np.signbit(a)
 assert(r.dtype=='bool','unary dtype signbit 185')
 assert(same(r:tolist(),{true,true,false,false},0.0),'unary values signbit 185')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local r=np.signbit(a)
 assert(r.dtype=='bool','unary dtype signbit 186')
 assert(same(r:tolist(),{true,true,false,false},0.0),'unary values signbit 186')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float64)
 local r=np.signbit(a)
 assert(r.dtype=='bool','unary dtype signbit 187')
 assert(same(r:tolist(),{true,true,false,false},0.0),'unary values signbit 187')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex64)
 assert(not pcall(function() np.signbit(a) end),'unary reject signbit 188')
end
do
 local a=np.array({np.complex(-2.5,1.0),np.complex(-0.0,-2.0),np.complex(1.25,0.5),np.complex(7.0,-3.0)},np.complex128)
 assert(not pcall(function() np.signbit(a) end),'unary reject signbit 189')
end
do
 local a=np.array({-2.5,-1.0,1.25,7.0},np.float32)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.add(a,b,{out=o,where=m})
 assert(r==o,'binary out identity')
 assert(same(o:tolist(),{-1.5,80.0,1.75,60.0},2e-12),'binary out where add 190')
end
do
 local a=np.array({-2.5,-1.0,1.25,7.0},np.float32)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.subtract(a,b,{out=o,where=m})
 assert(r==o,'binary out identity')
 assert(same(o:tolist(),{-3.5,80.0,0.75,60.0},2e-12),'binary out where subtract 191')
end
do
 local a=np.array({-2.5,-1.0,1.25,7.0},np.float32)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.multiply(a,b,{out=o,where=m})
 assert(r==o,'binary out identity')
 assert(same(o:tolist(),{-2.5,80.0,0.625,60.0},2e-12),'binary out where multiply 192')
end
do
 local a=np.array({-2.5,-1.0,1.25,7.0},np.float32)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.true_divide(a,b,{out=o,where=m})
 assert(r==o,'binary out identity')
 assert(same(o:tolist(),{-2.5,80.0,2.5,60.0},2e-12),'binary out where true_divide 193')
end
do
 local a=np.array({-2.5,-1.0,1.25,7.0},np.float32)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({true,false,false,true},np.bool)
 local r=np.equal(a,b,{out=o,where=m})
 assert(r==o,'binary out identity')
 assert(same(o:tolist(),{false,false,false,true},0.0),'binary out where equal 194')
end
do
 local a=np.array({-2.5,-1.0,1.25,7.0},np.float32)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({true,false,false,true},np.bool)
 local r=np.not_equal(a,b,{out=o,where=m})
 assert(r==o,'binary out identity')
 assert(same(o:tolist(),{true,false,true,true},0.0),'binary out where not_equal 195')
end
do
 local a=np.array({-2.5,-1.0,1.25,7.0},np.float32)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({true,false,false,true},np.bool)
 local r=np.less(a,b,{out=o,where=m})
 assert(r==o,'binary out identity')
 assert(same(o:tolist(),{true,false,false,true},0.0),'binary out where less 196')
end
do
 local a=np.array({-2.5,-1.0,1.25,7.0},np.float32)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({true,false,false,true},np.bool)
 local r=np.less_equal(a,b,{out=o,where=m})
 assert(r==o,'binary out identity')
 assert(same(o:tolist(),{true,false,false,true},0.0),'binary out where less_equal 197')
end
do
 local a=np.array({-2.5,-1.0,1.25,7.0},np.float32)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({true,false,false,true},np.bool)
 local r=np.greater(a,b,{out=o,where=m})
 assert(r==o,'binary out identity')
 assert(same(o:tolist(),{false,false,true,true},0.0),'binary out where greater 198')
end
do
 local a=np.array({-2.5,-1.0,1.25,7.0},np.float32)
 local b=np.array({1.0,-2.0,0.5,4.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({true,false,false,true},np.bool)
 local r=np.greater_equal(a,b,{out=o,where=m})
 assert(r==o,'binary out identity')
 assert(same(o:tolist(),{false,false,true,true},0.0),'binary out where greater_equal 199')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.negative(a,{out=o,where=m})
 assert(r==o,'unary out identity')
 assert(same(o:tolist(),{2.5,80.0,-1.25,60.0},2e-12),'unary out where negative 200')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.absolute(a,{out=o,where=m})
 assert(r==o,'unary out identity')
 assert(same(o:tolist(),{2.5,80.0,1.25,60.0},2e-12),'unary out where absolute 201')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.positive(a,{out=o,where=m})
 assert(r==o,'unary out identity')
 assert(same(o:tolist(),{-2.5,80.0,1.25,60.0},2e-12),'unary out where positive 202')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.sign(a,{out=o,where=m})
 assert(r==o,'unary out identity')
 assert(same(o:tolist(),{-1.0,80.0,1.0,60.0},2e-12),'unary out where sign 203')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({true,false,false,true},np.bool)
 local r=np.logical_not(a,{out=o,where=m})
 assert(r==o,'unary out identity')
 assert(same(o:tolist(),{false,false,false,true},0.0),'unary out where logical_not 204')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({true,false,false,true},np.bool)
 local r=np.isnan(a,{out=o,where=m})
 assert(r==o,'unary out identity')
 assert(same(o:tolist(),{false,false,false,true},0.0),'unary out where isnan 205')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({true,false,false,true},np.bool)
 local r=np.isinf(a,{out=o,where=m})
 assert(r==o,'unary out identity')
 assert(same(o:tolist(),{false,false,false,true},0.0),'unary out where isinf 206')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({true,false,false,true},np.bool)
 local r=np.isfinite(a,{out=o,where=m})
 assert(r==o,'unary out identity')
 assert(same(o:tolist(),{true,false,true,true},0.0),'unary out where isfinite 207')
end
do
 local a=np.array({-2.5,-0.0,1.25,7.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({true,false,false,true},np.bool)
 local r=np.signbit(a,{out=o,where=m})
 assert(r==o,'unary out identity')
 assert(same(o:tolist(),{true,false,false,true},0.0),'unary out where signbit 208')
end
do
 local v={} for i=1,24 do v[i]=i-1 end
 local a=np.reshape(np.array(v,np.float64),{2,3,4}); local t=a:transpose()
 local r=np.add(t,t); local u=np.negative(t)
 assert(seqeq(r.strides,{8,32,96}) and seqeq(u.strides,{8,32,96}),'KEEPORDER transpose 209')
end
do
 local v={} for i=1,24 do v[i]=i-1 end
 local a=np.reshape(np.array(v,np.float64),{2,3,4})
 local x=a:get(np.slice(nil,nil,1),np.slice(nil,nil,-1),np.slice(nil,nil,2))
 local r=np.add(x,x); local p=np.isfinite(x)
 assert(seqeq(r.strides,{48,16,8}) and seqeq(p.strides,{6,2,1}),'KEEPORDER strided 210')
end
do
 local a=np.array({2,4,8},np.float64); local b=np.array({1,2,4},np.float64)
 local r=a + b
 assert(same(r:tolist(),{3.0,6.0,12.0},1e-12),'operator add 211')
end
do
 local a=np.array({2,4,8},np.float64); local b=np.array({1,2,4},np.float64)
 local r=a - b
 assert(same(r:tolist(),{1.0,2.0,4.0},1e-12),'operator subtract 212')
end
do
 local a=np.array({2,4,8},np.float64); local b=np.array({1,2,4},np.float64)
 local r=a * b
 assert(same(r:tolist(),{2.0,8.0,32.0},1e-12),'operator multiply 213')
end
do
 local a=np.array({2,4,8},np.float64); local b=np.array({1,2,4},np.float64)
 local r=a / b
 assert(same(r:tolist(),{2.0,2.0,2.0},1e-12),'operator true_divide 214')
end
print('registry migration differential: 215 cases ok')
