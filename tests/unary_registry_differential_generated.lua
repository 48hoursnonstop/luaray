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
 local a=np.array({true,false,true,true},np.bool)
 local r=np.sqrt(a)
 assert(r.dtype=='float16','unary-reg dtype sqrt 0 '..r.dtype)
 assert(same(r:tolist(),{1.0,0.0,1.0,1.0},0.008),'unary-reg values sqrt 0')
end
do
 local a=np.array({-2,0,0,2},np.int8)
 local r=np.sqrt(a)
 assert(r.dtype=='float16','unary-reg dtype sqrt 1 '..r.dtype)
 assert(same(r:tolist(),{(0/0),0.0,0.0,1.4140625},0.008),'unary-reg values sqrt 1')
end
do
 local a=np.array({0,1,2,7},np.uint8)
 local r=np.sqrt(a)
 assert(r.dtype=='float16','unary-reg dtype sqrt 2 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.0,1.4140625,2.646484375},0.008),'unary-reg values sqrt 2')
end
do
 local a=np.array({-2,0,0,2},np.int16)
 local r=np.sqrt(a)
 assert(r.dtype=='float32','unary-reg dtype sqrt 3 '..r.dtype)
 assert(same(r:tolist(),{(0/0),0.0,0.0,1.4142135381698608},2e-05),'unary-reg values sqrt 3')
end
do
 local a=np.array({0,1,2,7},np.uint16)
 local r=np.sqrt(a)
 assert(r.dtype=='float32','unary-reg dtype sqrt 4 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.0,1.4142135381698608,2.6457512378692627},2e-05),'unary-reg values sqrt 4')
end
do
 local a=np.array({-2,0,0,2},np.int32)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','unary-reg dtype sqrt 5 '..r.dtype)
 assert(same(r:tolist(),{(0/0),0.0,0.0,1.4142135623730951},6e-12),'unary-reg values sqrt 5')
end
do
 local a=np.array({0,1,2,7},np.uint32)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','unary-reg dtype sqrt 6 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.0,1.4142135623730951,2.6457513110645907},6e-12),'unary-reg values sqrt 6')
end
do
 local a=np.array({-2,0,0,2},np.int64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','unary-reg dtype sqrt 7 '..r.dtype)
 assert(same(r:tolist(),{(0/0),0.0,0.0,1.4142135623730951},6e-12),'unary-reg values sqrt 7')
end
do
 local a=np.array({0,1,2,7},np.uint64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','unary-reg dtype sqrt 8 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.0,1.4142135623730951,2.6457513110645907},6e-12),'unary-reg values sqrt 8')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float16)
 local r=np.sqrt(a)
 assert(r.dtype=='float16','unary-reg dtype sqrt 9 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-0.0,0.5,1.4140625},0.008),'unary-reg values sqrt 9')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float32)
 local r=np.sqrt(a)
 assert(r.dtype=='float32','unary-reg dtype sqrt 10 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-0.0,0.5,1.4142135381698608},2e-05),'unary-reg values sqrt 10')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float64)
 local r=np.sqrt(a)
 assert(r.dtype=='float64','unary-reg dtype sqrt 11 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-0.0,0.5,1.4142135623730951},6e-12),'unary-reg values sqrt 11')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex64)
 local r=np.sqrt(a)
 assert(r.dtype=='complex64','unary-reg cdtype sqrt 12')
 assert(same(r:tolist(),{np.complex(0.0,1.4142135381698608),np.complex(0.0,0.0),np.complex(0.721307635307312,0.5198891162872314),np.complex(1.5,-0.5)},2e-05),'unary-reg cvalues sqrt 12')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex128)
 local r=np.sqrt(a)
 assert(r.dtype=='complex128','unary-reg cdtype sqrt 13')
 assert(same(r:tolist(),{np.complex(0.0,1.4142135623730951),np.complex(0.0,0.0),np.complex(0.7213076372263415,0.5198891300277853),np.complex(1.5,-0.5)},6e-12),'unary-reg cvalues sqrt 13')
end
do
 local a=np.array({true,false,true,true},np.bool)
 local r=np.exp(a)
 assert(r.dtype=='float16','unary-reg dtype exp 14 '..r.dtype)
 assert(same(r:tolist(),{2.71875,1.0,2.71875,2.71875},0.008),'unary-reg values exp 14')
end
do
 local a=np.array({-2,0,0,2},np.int8)
 local r=np.exp(a)
 assert(r.dtype=='float16','unary-reg dtype exp 15 '..r.dtype)
 assert(same(r:tolist(),{0.1353759765625,1.0,1.0,7.390625},0.008),'unary-reg values exp 15')
end
do
 local a=np.array({0,1,2,7},np.uint8)
 local r=np.exp(a)
 assert(r.dtype=='float16','unary-reg dtype exp 16 '..r.dtype)
 assert(same(r:tolist(),{1.0,2.71875,7.390625,1097.0},0.008),'unary-reg values exp 16')
end
do
 local a=np.array({-2,0,0,2},np.int16)
 local r=np.exp(a)
 assert(r.dtype=='float32','unary-reg dtype exp 17 '..r.dtype)
 assert(same(r:tolist(),{0.1353352814912796,1.0,1.0,7.3890557289123535},2e-05),'unary-reg values exp 17')
end
do
 local a=np.array({0,1,2,7},np.uint16)
 local r=np.exp(a)
 assert(r.dtype=='float32','unary-reg dtype exp 18 '..r.dtype)
 assert(same(r:tolist(),{1.0,2.7182819843292236,7.3890557289123535,1096.6331787109375},2e-05),'unary-reg values exp 18')
end
do
 local a=np.array({-2,0,0,2},np.int32)
 local r=np.exp(a)
 assert(r.dtype=='float64','unary-reg dtype exp 19 '..r.dtype)
 assert(same(r:tolist(),{0.1353352832366127,1.0,1.0,7.38905609893065},6e-12),'unary-reg values exp 19')
end
do
 local a=np.array({0,1,2,7},np.uint32)
 local r=np.exp(a)
 assert(r.dtype=='float64','unary-reg dtype exp 20 '..r.dtype)
 assert(same(r:tolist(),{1.0,2.718281828459045,7.38905609893065,1096.6331584284585},6e-12),'unary-reg values exp 20')
end
do
 local a=np.array({-2,0,0,2},np.int64)
 local r=np.exp(a)
 assert(r.dtype=='float64','unary-reg dtype exp 21 '..r.dtype)
 assert(same(r:tolist(),{0.1353352832366127,1.0,1.0,7.38905609893065},6e-12),'unary-reg values exp 21')
end
do
 local a=np.array({0,1,2,7},np.uint64)
 local r=np.exp(a)
 assert(r.dtype=='float64','unary-reg dtype exp 22 '..r.dtype)
 assert(same(r:tolist(),{1.0,2.718281828459045,7.38905609893065,1096.6331584284585},6e-12),'unary-reg values exp 22')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float16)
 local r=np.exp(a)
 assert(r.dtype=='float16','unary-reg dtype exp 23 '..r.dtype)
 assert(same(r:tolist(),{0.08209228515625,1.0,1.2841796875,7.390625},0.008),'unary-reg values exp 23')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float32)
 local r=np.exp(a)
 assert(r.dtype=='float32','unary-reg dtype exp 24 '..r.dtype)
 assert(same(r:tolist(),{0.0820850059390068,1.0,1.2840255498886108,7.3890557289123535},2e-05),'unary-reg values exp 24')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float64)
 local r=np.exp(a)
 assert(r.dtype=='float64','unary-reg dtype exp 25 '..r.dtype)
 assert(same(r:tolist(),{0.0820849986238988,1.0,1.2840254166877414,7.38905609893065},6e-12),'unary-reg values exp 25')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex64)
 local r=np.exp(a)
 assert(r.dtype=='complex64','unary-reg cdtype exp 26')
 assert(same(r:tolist(),{np.complex(0.1353352814912796,0.0),np.complex(1.0,0.0),np.complex(0.9395071268081665,0.8752415180206299),np.complex(0.5226811170578003,-7.370546817779541)},2e-05),'unary-reg cvalues exp 26')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex128)
 local r=np.exp(a)
 assert(r.dtype=='complex128','unary-reg cdtype exp 27')
 assert(same(r:tolist(),{np.complex(0.1353352832366127,0.0),np.complex(1.0,0.0),np.complex(0.93950710474149,0.875241492869477),np.complex(0.5226811514040275,-7.370546414419436)},6e-12),'unary-reg cvalues exp 27')
end
do
 local a=np.array({true,false,true,true},np.bool)
 local r=np.log(a)
 assert(r.dtype=='float16','unary-reg dtype log 28 '..r.dtype)
 assert(same(r:tolist(),{0.0,-math.huge,0.0,0.0},0.008),'unary-reg values log 28')
end
do
 local a=np.array({-2,0,0,2},np.int8)
 local r=np.log(a)
 assert(r.dtype=='float16','unary-reg dtype log 29 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-math.huge,-math.huge,0.693359375},0.008),'unary-reg values log 29')
end
do
 local a=np.array({0,1,2,7},np.uint8)
 local r=np.log(a)
 assert(r.dtype=='float16','unary-reg dtype log 30 '..r.dtype)
 assert(same(r:tolist(),{-math.huge,0.0,0.693359375,1.9462890625},0.008),'unary-reg values log 30')
end
do
 local a=np.array({-2,0,0,2},np.int16)
 local r=np.log(a)
 assert(r.dtype=='float32','unary-reg dtype log 31 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-math.huge,-math.huge,0.6931471824645996},2e-05),'unary-reg values log 31')
end
do
 local a=np.array({0,1,2,7},np.uint16)
 local r=np.log(a)
 assert(r.dtype=='float32','unary-reg dtype log 32 '..r.dtype)
 assert(same(r:tolist(),{-math.huge,0.0,0.6931471824645996,1.9459102153778076},2e-05),'unary-reg values log 32')
end
do
 local a=np.array({-2,0,0,2},np.int32)
 local r=np.log(a)
 assert(r.dtype=='float64','unary-reg dtype log 33 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-math.huge,-math.huge,0.6931471805599453},6e-12),'unary-reg values log 33')
end
do
 local a=np.array({0,1,2,7},np.uint32)
 local r=np.log(a)
 assert(r.dtype=='float64','unary-reg dtype log 34 '..r.dtype)
 assert(same(r:tolist(),{-math.huge,0.0,0.6931471805599453,1.9459101490553132},6e-12),'unary-reg values log 34')
end
do
 local a=np.array({-2,0,0,2},np.int64)
 local r=np.log(a)
 assert(r.dtype=='float64','unary-reg dtype log 35 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-math.huge,-math.huge,0.6931471805599453},6e-12),'unary-reg values log 35')
end
do
 local a=np.array({0,1,2,7},np.uint64)
 local r=np.log(a)
 assert(r.dtype=='float64','unary-reg dtype log 36 '..r.dtype)
 assert(same(r:tolist(),{-math.huge,0.0,0.6931471805599453,1.9459101490553132},6e-12),'unary-reg values log 36')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float16)
 local r=np.log(a)
 assert(r.dtype=='float16','unary-reg dtype log 37 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-math.huge,-1.38671875,0.693359375},0.008),'unary-reg values log 37')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float32)
 local r=np.log(a)
 assert(r.dtype=='float32','unary-reg dtype log 38 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-math.huge,-1.3862943649291992,0.6931471824645996},2e-05),'unary-reg values log 38')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float64)
 local r=np.log(a)
 assert(r.dtype=='float64','unary-reg dtype log 39 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-math.huge,-1.3862943611198906,0.6931471805599453},6e-12),'unary-reg values log 39')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex64)
 local r=np.log(a)
 assert(r.dtype=='complex64','unary-reg cdtype log 40')
 assert(same(r:tolist(),{np.complex(0.6931471824645996,3.1415927410125732),np.complex(-math.huge,0.0),np.complex(-0.2350018173456192,1.249045729637146),np.complex(0.9162907600402832,-0.6435011029243469)},2e-05),'unary-reg cvalues log 40')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex128)
 local r=np.log(a)
 assert(r.dtype=='complex128','unary-reg cdtype log 41')
 assert(same(r:tolist(),{np.complex(0.6931471805599453,3.141592653589793),np.complex(-math.huge,0.0),np.complex(-0.2350018146228678,1.2490457723982544),np.complex(0.9162907318741551,-0.6435011087932844)},6e-12),'unary-reg cvalues log 41')
end
do
 local a=np.array({true,false,true,true},np.bool)
 local r=np.sin(a)
 assert(r.dtype=='float16','unary-reg dtype sin 42 '..r.dtype)
 assert(same(r:tolist(),{0.84130859375,0.0,0.84130859375,0.84130859375},0.008),'unary-reg values sin 42')
end
do
 local a=np.array({-2,0,0,2},np.int8)
 local r=np.sin(a)
 assert(r.dtype=='float16','unary-reg dtype sin 43 '..r.dtype)
 assert(same(r:tolist(),{-0.9091796875,0.0,0.0,0.9091796875},0.008),'unary-reg values sin 43')
end
do
 local a=np.array({0,1,2,7},np.uint8)
 local r=np.sin(a)
 assert(r.dtype=='float16','unary-reg dtype sin 44 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.84130859375,0.9091796875,0.6572265625},0.008),'unary-reg values sin 44')
end
do
 local a=np.array({-2,0,0,2},np.int16)
 local r=np.sin(a)
 assert(r.dtype=='float32','unary-reg dtype sin 45 '..r.dtype)
 assert(same(r:tolist(),{-0.9092974066734314,0.0,0.0,0.9092974066734314},2e-05),'unary-reg values sin 45')
end
do
 local a=np.array({0,1,2,7},np.uint16)
 local r=np.sin(a)
 assert(r.dtype=='float32','unary-reg dtype sin 46 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.8414710164070129,0.9092974066734314,0.6569865942001343},2e-05),'unary-reg values sin 46')
end
do
 local a=np.array({-2,0,0,2},np.int32)
 local r=np.sin(a)
 assert(r.dtype=='float64','unary-reg dtype sin 47 '..r.dtype)
 assert(same(r:tolist(),{-0.9092974268256817,0.0,0.0,0.9092974268256817},6e-12),'unary-reg values sin 47')
end
do
 local a=np.array({0,1,2,7},np.uint32)
 local r=np.sin(a)
 assert(r.dtype=='float64','unary-reg dtype sin 48 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.8414709848078965,0.9092974268256817,0.6569865987187891},6e-12),'unary-reg values sin 48')
end
do
 local a=np.array({-2,0,0,2},np.int64)
 local r=np.sin(a)
 assert(r.dtype=='float64','unary-reg dtype sin 49 '..r.dtype)
 assert(same(r:tolist(),{-0.9092974268256817,0.0,0.0,0.9092974268256817},6e-12),'unary-reg values sin 49')
end
do
 local a=np.array({0,1,2,7},np.uint64)
 local r=np.sin(a)
 assert(r.dtype=='float64','unary-reg dtype sin 50 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.8414709848078965,0.9092974268256817,0.6569865987187891},6e-12),'unary-reg values sin 50')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float16)
 local r=np.sin(a)
 assert(r.dtype=='float16','unary-reg dtype sin 51 '..r.dtype)
 assert(same(r:tolist(),{-0.5986328125,-0.0,0.2474365234375,0.9091796875},0.008),'unary-reg values sin 51')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float32)
 local r=np.sin(a)
 assert(r.dtype=='float32','unary-reg dtype sin 52 '..r.dtype)
 assert(same(r:tolist(),{-0.5984721779823303,-0.0,0.24740396440029144,0.9092974066734314},2e-05),'unary-reg values sin 52')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float64)
 local r=np.sin(a)
 assert(r.dtype=='float64','unary-reg dtype sin 53 '..r.dtype)
 assert(same(r:tolist(),{-0.5984721441039565,-0.0,0.24740395925452294,0.9092974268256817},6e-12),'unary-reg values sin 53')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex64)
 local r=np.sin(a)
 assert(r.dtype=='complex64','unary-reg cdtype sin 54')
 assert(same(r:tolist(),{np.complex(-0.9092974066734314,-0.0),np.complex(0.0,0.0),np.complex(0.3203097879886627,0.7967528700828552),np.complex(2.139039993286133,0.8860929012298584)},2e-05),'unary-reg cvalues sin 54')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex128)
 local r=np.sin(a)
 assert(r.dtype=='complex128','unary-reg cdtype sin 55')
 assert(same(r:tolist(),{np.complex(-0.9092974268256817,-0.0),np.complex(0.0,0.0),np.complex(0.320309770609702,0.796752896153128),np.complex(2.139040009980677,0.8860929093625314)},6e-12),'unary-reg cvalues sin 55')
end
do
 local a=np.array({true,false,true,true},np.bool)
 local r=np.cos(a)
 assert(r.dtype=='float16','unary-reg dtype cos 56 '..r.dtype)
 assert(same(r:tolist(),{0.54052734375,1.0,0.54052734375,0.54052734375},0.008),'unary-reg values cos 56')
end
do
 local a=np.array({-2,0,0,2},np.int8)
 local r=np.cos(a)
 assert(r.dtype=='float16','unary-reg dtype cos 57 '..r.dtype)
 assert(same(r:tolist(),{-0.416259765625,1.0,1.0,-0.416259765625},0.008),'unary-reg values cos 57')
end
do
 local a=np.array({0,1,2,7},np.uint8)
 local r=np.cos(a)
 assert(r.dtype=='float16','unary-reg dtype cos 58 '..r.dtype)
 assert(same(r:tolist(),{1.0,0.54052734375,-0.416259765625,0.75390625},0.008),'unary-reg values cos 58')
end
do
 local a=np.array({-2,0,0,2},np.int16)
 local r=np.cos(a)
 assert(r.dtype=='float32','unary-reg dtype cos 59 '..r.dtype)
 assert(same(r:tolist(),{-0.41614681482315063,1.0,1.0,-0.41614681482315063},2e-05),'unary-reg values cos 59')
end
do
 local a=np.array({0,1,2,7},np.uint16)
 local r=np.cos(a)
 assert(r.dtype=='float32','unary-reg dtype cos 60 '..r.dtype)
 assert(same(r:tolist(),{1.0,0.5403022766113281,-0.41614681482315063,0.7539022564888},2e-05),'unary-reg values cos 60')
end
do
 local a=np.array({-2,0,0,2},np.int32)
 local r=np.cos(a)
 assert(r.dtype=='float64','unary-reg dtype cos 61 '..r.dtype)
 assert(same(r:tolist(),{-0.4161468365471424,1.0,1.0,-0.4161468365471424},6e-12),'unary-reg values cos 61')
end
do
 local a=np.array({0,1,2,7},np.uint32)
 local r=np.cos(a)
 assert(r.dtype=='float64','unary-reg dtype cos 62 '..r.dtype)
 assert(same(r:tolist(),{1.0,0.5403023058681398,-0.4161468365471424,0.7539022543433046},6e-12),'unary-reg values cos 62')
end
do
 local a=np.array({-2,0,0,2},np.int64)
 local r=np.cos(a)
 assert(r.dtype=='float64','unary-reg dtype cos 63 '..r.dtype)
 assert(same(r:tolist(),{-0.4161468365471424,1.0,1.0,-0.4161468365471424},6e-12),'unary-reg values cos 63')
end
do
 local a=np.array({0,1,2,7},np.uint64)
 local r=np.cos(a)
 assert(r.dtype=='float64','unary-reg dtype cos 64 '..r.dtype)
 assert(same(r:tolist(),{1.0,0.5403023058681398,-0.4161468365471424,0.7539022543433046},6e-12),'unary-reg values cos 64')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float16)
 local r=np.cos(a)
 assert(r.dtype=='float16','unary-reg dtype cos 65 '..r.dtype)
 assert(same(r:tolist(),{-0.80126953125,1.0,0.96875,-0.416259765625},0.008),'unary-reg values cos 65')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float32)
 local r=np.cos(a)
 assert(r.dtype=='float32','unary-reg dtype cos 66 '..r.dtype)
 assert(same(r:tolist(),{-0.8011435866355896,1.0,0.9689124226570129,-0.41614681482315063},2e-05),'unary-reg values cos 66')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float64)
 local r=np.cos(a)
 assert(r.dtype=='float64','unary-reg dtype cos 67 '..r.dtype)
 assert(same(r:tolist(),{-0.8011436155469337,1.0,0.9689124217106447,-0.4161468365471424},6e-12),'unary-reg values cos 67')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex64)
 local r=np.cos(a)
 assert(r.dtype=='complex64','unary-reg cdtype cos 68')
 assert(same(r:tolist(),{np.complex(-0.416146844625473,0.0),np.complex(1.0,-0.0),np.complex(1.2544348239898682,-0.20344440639019012),np.complex(-0.9789478182792664,1.9361481666564941)},2e-05),'unary-reg cvalues cos 68')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex128)
 local r=np.cos(a)
 assert(r.dtype=='complex128','unary-reg cdtype cos 69')
 assert(same(r:tolist(),{np.complex(-0.4161468365471424,0.0),np.complex(1.0,-0.0),np.complex(1.2544347167045338,-0.20344441524216456),np.complex(-0.9789478196465577,1.936148329510507)},6e-12),'unary-reg cvalues cos 69')
end
do
 local a=np.array({true,false,true,true},np.bool)
 local r=np.tan(a)
 assert(r.dtype=='float16','unary-reg dtype tan 70 '..r.dtype)
 assert(same(r:tolist(),{1.5576171875,0.0,1.5576171875,1.5576171875},0.008),'unary-reg values tan 70')
end
do
 local a=np.array({-2,0,0,2},np.int8)
 local r=np.tan(a)
 assert(r.dtype=='float16','unary-reg dtype tan 71 '..r.dtype)
 assert(same(r:tolist(),{2.185546875,0.0,0.0,-2.185546875},0.008),'unary-reg values tan 71')
end
do
 local a=np.array({0,1,2,7},np.uint8)
 local r=np.tan(a)
 assert(r.dtype=='float16','unary-reg dtype tan 72 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.5576171875,-2.185546875,0.87158203125},0.008),'unary-reg values tan 72')
end
do
 local a=np.array({-2,0,0,2},np.int16)
 local r=np.tan(a)
 assert(r.dtype=='float32','unary-reg dtype tan 73 '..r.dtype)
 assert(same(r:tolist(),{2.18503999710083,0.0,0.0,-2.18503999710083},2e-05),'unary-reg values tan 73')
end
do
 local a=np.array({0,1,2,7},np.uint16)
 local r=np.tan(a)
 assert(r.dtype=='float32','unary-reg dtype tan 74 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.5574077367782593,-2.18503999710083,0.8714479804039001},2e-05),'unary-reg values tan 74')
end
do
 local a=np.array({-2,0,0,2},np.int32)
 local r=np.tan(a)
 assert(r.dtype=='float64','unary-reg dtype tan 75 '..r.dtype)
 assert(same(r:tolist(),{2.185039863261519,0.0,0.0,-2.185039863261519},6e-12),'unary-reg values tan 75')
end
do
 local a=np.array({0,1,2,7},np.uint32)
 local r=np.tan(a)
 assert(r.dtype=='float64','unary-reg dtype tan 76 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.5574077246549023,-2.185039863261519,0.8714479827243188},6e-12),'unary-reg values tan 76')
end
do
 local a=np.array({-2,0,0,2},np.int64)
 local r=np.tan(a)
 assert(r.dtype=='float64','unary-reg dtype tan 77 '..r.dtype)
 assert(same(r:tolist(),{2.185039863261519,0.0,0.0,-2.185039863261519},6e-12),'unary-reg values tan 77')
end
do
 local a=np.array({0,1,2,7},np.uint64)
 local r=np.tan(a)
 assert(r.dtype=='float64','unary-reg dtype tan 78 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.5574077246549023,-2.185039863261519,0.8714479827243188},6e-12),'unary-reg values tan 78')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float16)
 local r=np.tan(a)
 assert(r.dtype=='float16','unary-reg dtype tan 79 '..r.dtype)
 assert(same(r:tolist(),{0.7470703125,-0.0,0.25537109375,-2.185546875},0.008),'unary-reg values tan 79')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float32)
 local r=np.tan(a)
 assert(r.dtype=='float32','unary-reg dtype tan 80 '..r.dtype)
 assert(same(r:tolist(),{0.747022271156311,-0.0,0.25534191727638245,-2.18503999710083},2e-05),'unary-reg values tan 80')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float64)
 local r=np.tan(a)
 assert(r.dtype=='float64','unary-reg dtype tan 81 '..r.dtype)
 assert(same(r:tolist(),{0.7470222972386603,-0.0,0.25534192122103627,-2.185039863261519},6e-12),'unary-reg values tan 81')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex64)
 local r=np.tan(a)
 assert(r.dtype=='complex64','unary-reg cdtype tan 82')
 assert(same(r:tolist(),{np.complex(2.185039758682251,0.0),np.complex(0.0,0.0),np.complex(0.14842933416366577,0.6592212915420532),np.complex(-0.08039101958274841,-1.064144492149353)},2e-05),'unary-reg cvalues tan 82')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex128)
 local r=np.tan(a)
 assert(r.dtype=='complex128','unary-reg cdtype tan 83')
 assert(same(r:tolist(),{np.complex(2.185039863261519,0.0),np.complex(0.0,0.0),np.complex(0.14842931880709936,0.6592212421345232),np.complex(-0.08039101531016819,-1.0641443991765371)},6e-12),'unary-reg cvalues tan 83')
end
do
 local a=np.array({true,false,true,true},np.bool)
 local r=np.sinh(a)
 assert(r.dtype=='float16','unary-reg dtype sinh 84 '..r.dtype)
 assert(same(r:tolist(),{1.1748046875,0.0,1.1748046875,1.1748046875},0.008),'unary-reg values sinh 84')
end
do
 local a=np.array({-2,0,0,2},np.int8)
 local r=np.sinh(a)
 assert(r.dtype=='float16','unary-reg dtype sinh 85 '..r.dtype)
 assert(same(r:tolist(),{-3.626953125,0.0,0.0,3.626953125},0.008),'unary-reg values sinh 85')
end
do
 local a=np.array({0,1,2,7},np.uint8)
 local r=np.sinh(a)
 assert(r.dtype=='float16','unary-reg dtype sinh 86 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.1748046875,3.626953125,548.5},0.008),'unary-reg values sinh 86')
end
do
 local a=np.array({-2,0,0,2},np.int16)
 local r=np.sinh(a)
 assert(r.dtype=='float32','unary-reg dtype sinh 87 '..r.dtype)
 assert(same(r:tolist(),{-3.6268603801727295,0.0,0.0,3.6268603801727295},2e-05),'unary-reg values sinh 87')
end
do
 local a=np.array({0,1,2,7},np.uint16)
 local r=np.sinh(a)
 assert(r.dtype=='float32','unary-reg dtype sinh 88 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.175201177597046,3.6268603801727295,548.3161010742188},2e-05),'unary-reg values sinh 88')
end
do
 local a=np.array({-2,0,0,2},np.int32)
 local r=np.sinh(a)
 assert(r.dtype=='float64','unary-reg dtype sinh 89 '..r.dtype)
 assert(same(r:tolist(),{-3.6268604078470186,0.0,0.0,3.6268604078470186},6e-12),'unary-reg values sinh 89')
end
do
 local a=np.array({0,1,2,7},np.uint32)
 local r=np.sinh(a)
 assert(r.dtype=='float64','unary-reg dtype sinh 90 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.1752011936438014,3.6268604078470186,548.3161232732465},6e-12),'unary-reg values sinh 90')
end
do
 local a=np.array({-2,0,0,2},np.int64)
 local r=np.sinh(a)
 assert(r.dtype=='float64','unary-reg dtype sinh 91 '..r.dtype)
 assert(same(r:tolist(),{-3.6268604078470186,0.0,0.0,3.6268604078470186},6e-12),'unary-reg values sinh 91')
end
do
 local a=np.array({0,1,2,7},np.uint64)
 local r=np.sinh(a)
 assert(r.dtype=='float64','unary-reg dtype sinh 92 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.1752011936438014,3.6268604078470186,548.3161232732465},6e-12),'unary-reg values sinh 92')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float16)
 local r=np.sinh(a)
 assert(r.dtype=='float16','unary-reg dtype sinh 93 '..r.dtype)
 assert(same(r:tolist(),{-6.05078125,-0.0,0.252685546875,3.626953125},0.008),'unary-reg values sinh 93')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float32)
 local r=np.sinh(a)
 assert(r.dtype=='float32','unary-reg dtype sinh 94 '..r.dtype)
 assert(same(r:tolist(),{-6.050204277038574,-0.0,0.25261232256889343,3.6268603801727295},2e-05),'unary-reg values sinh 94')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float64)
 local r=np.sinh(a)
 assert(r.dtype=='float64','unary-reg dtype sinh 95 '..r.dtype)
 assert(same(r:tolist(),{-6.0502044810397875,-0.0,0.2526123168081683,3.6268604078470186},6e-12),'unary-reg values sinh 95')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex64)
 local r=np.sinh(a)
 assert(r.dtype=='complex64','unary-reg cdtype sinh 96')
 assert(same(r:tolist(),{np.complex(-3.6268603801727295,0.0),np.complex(0.0,0.0),np.complex(0.1848336160182953,0.7030511498451233),np.complex(0.2565539479255676,-3.7527713775634766)},2e-05),'unary-reg cvalues sinh 96')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex128)
 local r=np.sinh(a)
 assert(r.dtype=='complex128','unary-reg cdtype sinh 97')
 assert(same(r:tolist(),{np.complex(-3.626860407847019,0.0),np.complex(0.0,0.0),np.complex(0.18483362034896397,0.7030511464737356),np.complex(0.2565539560904818,-3.752771340479298)},6e-12),'unary-reg cvalues sinh 97')
end
do
 local a=np.array({true,false,true,true},np.bool)
 local r=np.cosh(a)
 assert(r.dtype=='float16','unary-reg dtype cosh 98 '..r.dtype)
 assert(same(r:tolist(),{1.54296875,1.0,1.54296875,1.54296875},0.008),'unary-reg values cosh 98')
end
do
 local a=np.array({-2,0,0,2},np.int8)
 local r=np.cosh(a)
 assert(r.dtype=='float16','unary-reg dtype cosh 99 '..r.dtype)
 assert(same(r:tolist(),{3.76171875,1.0,1.0,3.76171875},0.008),'unary-reg values cosh 99')
end
do
 local a=np.array({0,1,2,7},np.uint8)
 local r=np.cosh(a)
 assert(r.dtype=='float16','unary-reg dtype cosh 100 '..r.dtype)
 assert(same(r:tolist(),{1.0,1.54296875,3.76171875,548.5},0.008),'unary-reg values cosh 100')
end
do
 local a=np.array({-2,0,0,2},np.int16)
 local r=np.cosh(a)
 assert(r.dtype=='float32','unary-reg dtype cosh 101 '..r.dtype)
 assert(same(r:tolist(),{3.762195587158203,1.0,1.0,3.762195587158203},2e-05),'unary-reg values cosh 101')
end
do
 local a=np.array({0,1,2,7},np.uint16)
 local r=np.cosh(a)
 assert(r.dtype=='float32','unary-reg dtype cosh 102 '..r.dtype)
 assert(same(r:tolist(),{1.0,1.5430806875228882,3.762195587158203,548.3170166015625},2e-05),'unary-reg values cosh 102')
end
do
 local a=np.array({-2,0,0,2},np.int32)
 local r=np.cosh(a)
 assert(r.dtype=='float64','unary-reg dtype cosh 103 '..r.dtype)
 assert(same(r:tolist(),{3.7621956910836314,1.0,1.0,3.7621956910836314},6e-12),'unary-reg values cosh 103')
end
do
 local a=np.array({0,1,2,7},np.uint32)
 local r=np.cosh(a)
 assert(r.dtype=='float64','unary-reg dtype cosh 104 '..r.dtype)
 assert(same(r:tolist(),{1.0,1.5430806348152437,3.7621956910836314,548.3170351552121},6e-12),'unary-reg values cosh 104')
end
do
 local a=np.array({-2,0,0,2},np.int64)
 local r=np.cosh(a)
 assert(r.dtype=='float64','unary-reg dtype cosh 105 '..r.dtype)
 assert(same(r:tolist(),{3.7621956910836314,1.0,1.0,3.7621956910836314},6e-12),'unary-reg values cosh 105')
end
do
 local a=np.array({0,1,2,7},np.uint64)
 local r=np.cosh(a)
 assert(r.dtype=='float64','unary-reg dtype cosh 106 '..r.dtype)
 assert(same(r:tolist(),{1.0,1.5430806348152437,3.7621956910836314,548.3170351552121},6e-12),'unary-reg values cosh 106')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float16)
 local r=np.cosh(a)
 assert(r.dtype=='float16','unary-reg dtype cosh 107 '..r.dtype)
 assert(same(r:tolist(),{6.1328125,1.0,1.03125,3.76171875},0.008),'unary-reg values cosh 107')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float32)
 local r=np.cosh(a)
 assert(r.dtype=='float32','unary-reg dtype cosh 108 '..r.dtype)
 assert(same(r:tolist(),{6.132289886474609,1.0,1.031413197517395,3.762195587158203},2e-05),'unary-reg values cosh 108')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float64)
 local r=np.cosh(a)
 assert(r.dtype=='float64','unary-reg dtype cosh 109 '..r.dtype)
 assert(same(r:tolist(),{6.132289479663686,1.0,1.0314130998795732,3.7621956910836314},6e-12),'unary-reg values cosh 109')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex64)
 local r=np.cosh(a)
 assert(r.dtype=='complex64','unary-reg cdtype cosh 110')
 assert(same(r:tolist(),{np.complex(3.762195587158203,-0.0),np.complex(1.0,0.0),np.complex(0.7546734809875488,0.1721903532743454),np.complex(0.26612716913223267,-3.6177749633789062)},2e-05),'unary-reg cvalues cosh 110')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex128)
 local r=np.cosh(a)
 assert(r.dtype=='complex128','unary-reg cdtype cosh 111')
 assert(same(r:tolist(),{np.complex(3.7621956910836314,-0.0),np.complex(1.0,0.0),np.complex(0.7546734843925261,0.1721903463957415),np.complex(0.26612719531354573,-3.6177750739401375)},6e-12),'unary-reg cvalues cosh 111')
end
do
 local a=np.array({true,false,true,true},np.bool)
 local r=np.tanh(a)
 assert(r.dtype=='float16','unary-reg dtype tanh 112 '..r.dtype)
 assert(same(r:tolist(),{0.76171875,0.0,0.76171875,0.76171875},0.008),'unary-reg values tanh 112')
end
do
 local a=np.array({-2,0,0,2},np.int8)
 local r=np.tanh(a)
 assert(r.dtype=='float16','unary-reg dtype tanh 113 '..r.dtype)
 assert(same(r:tolist(),{-0.9638671875,0.0,0.0,0.9638671875},0.008),'unary-reg values tanh 113')
end
do
 local a=np.array({0,1,2,7},np.uint8)
 local r=np.tanh(a)
 assert(r.dtype=='float16','unary-reg dtype tanh 114 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.76171875,0.9638671875,1.0},0.008),'unary-reg values tanh 114')
end
do
 local a=np.array({-2,0,0,2},np.int16)
 local r=np.tanh(a)
 assert(r.dtype=='float32','unary-reg dtype tanh 115 '..r.dtype)
 assert(same(r:tolist(),{-0.9640275835990906,0.0,0.0,0.9640275835990906},2e-05),'unary-reg values tanh 115')
end
do
 local a=np.array({0,1,2,7},np.uint16)
 local r=np.tanh(a)
 assert(r.dtype=='float32','unary-reg dtype tanh 116 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.7615941762924194,0.9640275835990906,0.9999983310699463},2e-05),'unary-reg values tanh 116')
end
do
 local a=np.array({-2,0,0,2},np.int32)
 local r=np.tanh(a)
 assert(r.dtype=='float64','unary-reg dtype tanh 117 '..r.dtype)
 assert(same(r:tolist(),{-0.9640275800758169,0.0,0.0,0.9640275800758169},6e-12),'unary-reg values tanh 117')
end
do
 local a=np.array({0,1,2,7},np.uint32)
 local r=np.tanh(a)
 assert(r.dtype=='float64','unary-reg dtype tanh 118 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.7615941559557649,0.9640275800758169,0.9999983369439447},6e-12),'unary-reg values tanh 118')
end
do
 local a=np.array({-2,0,0,2},np.int64)
 local r=np.tanh(a)
 assert(r.dtype=='float64','unary-reg dtype tanh 119 '..r.dtype)
 assert(same(r:tolist(),{-0.9640275800758169,0.0,0.0,0.9640275800758169},6e-12),'unary-reg values tanh 119')
end
do
 local a=np.array({0,1,2,7},np.uint64)
 local r=np.tanh(a)
 assert(r.dtype=='float64','unary-reg dtype tanh 120 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.7615941559557649,0.9640275800758169,0.9999983369439447},6e-12),'unary-reg values tanh 120')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float16)
 local r=np.tanh(a)
 assert(r.dtype=='float16','unary-reg dtype tanh 121 '..r.dtype)
 assert(same(r:tolist(),{-0.98681640625,-0.0,0.244873046875,0.9638671875},0.008),'unary-reg values tanh 121')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float32)
 local r=np.tanh(a)
 assert(r.dtype=='float32','unary-reg dtype tanh 122 '..r.dtype)
 assert(same(r:tolist(),{-0.9866142868995667,-0.0,0.24491865932941437,0.9640275835990906},2e-05),'unary-reg values tanh 122')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float64)
 local r=np.tanh(a)
 assert(r.dtype=='float64','unary-reg dtype tanh 123 '..r.dtype)
 assert(same(r:tolist(),{-0.9866142981514303,-0.0,0.24491866240370913,0.9640275800758169},6e-12),'unary-reg values tanh 123')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex64)
 local r=np.tanh(a)
 assert(r.dtype=='complex64','unary-reg cdtype tanh 124')
 assert(same(r:tolist(),{np.complex(-0.9640275835990906,0.0),np.complex(0.0,0.0),np.complex(0.43483927845954895,0.8323813080787659),np.complex(1.036920189857483,-0.005362060386687517)},2e-05),'unary-reg cvalues tanh 124')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex128)
 local r=np.tanh(a)
 assert(r.dtype=='complex128','unary-reg cdtype tanh 125')
 assert(same(r:tolist(),{np.complex(-0.9640275800758168,0.0),np.complex(0.0,0.0),np.complex(0.43483922061207736,0.8323812131225697),np.complex(1.036920282100185,-0.0053620609220030565)},6e-12),'unary-reg cvalues tanh 125')
end
do
 local a=np.array({true,false,true,true},np.bool)
 local r=np.exp2(a)
 assert(r.dtype=='float16','unary-reg dtype exp2 126 '..r.dtype)
 assert(same(r:tolist(),{2.0,1.0,2.0,2.0},0.008),'unary-reg values exp2 126')
end
do
 local a=np.array({-2,0,0,2},np.int8)
 local r=np.exp2(a)
 assert(r.dtype=='float16','unary-reg dtype exp2 127 '..r.dtype)
 assert(same(r:tolist(),{0.25,1.0,1.0,4.0},0.008),'unary-reg values exp2 127')
end
do
 local a=np.array({0,1,2,7},np.uint8)
 local r=np.exp2(a)
 assert(r.dtype=='float16','unary-reg dtype exp2 128 '..r.dtype)
 assert(same(r:tolist(),{1.0,2.0,4.0,128.0},0.008),'unary-reg values exp2 128')
end
do
 local a=np.array({-2,0,0,2},np.int16)
 local r=np.exp2(a)
 assert(r.dtype=='float32','unary-reg dtype exp2 129 '..r.dtype)
 assert(same(r:tolist(),{0.25,1.0,1.0,4.0},2e-05),'unary-reg values exp2 129')
end
do
 local a=np.array({0,1,2,7},np.uint16)
 local r=np.exp2(a)
 assert(r.dtype=='float32','unary-reg dtype exp2 130 '..r.dtype)
 assert(same(r:tolist(),{1.0,2.0,4.0,128.0},2e-05),'unary-reg values exp2 130')
end
do
 local a=np.array({-2,0,0,2},np.int32)
 local r=np.exp2(a)
 assert(r.dtype=='float64','unary-reg dtype exp2 131 '..r.dtype)
 assert(same(r:tolist(),{0.25,1.0,1.0,4.0},6e-12),'unary-reg values exp2 131')
end
do
 local a=np.array({0,1,2,7},np.uint32)
 local r=np.exp2(a)
 assert(r.dtype=='float64','unary-reg dtype exp2 132 '..r.dtype)
 assert(same(r:tolist(),{1.0,2.0,4.0,128.0},6e-12),'unary-reg values exp2 132')
end
do
 local a=np.array({-2,0,0,2},np.int64)
 local r=np.exp2(a)
 assert(r.dtype=='float64','unary-reg dtype exp2 133 '..r.dtype)
 assert(same(r:tolist(),{0.25,1.0,1.0,4.0},6e-12),'unary-reg values exp2 133')
end
do
 local a=np.array({0,1,2,7},np.uint64)
 local r=np.exp2(a)
 assert(r.dtype=='float64','unary-reg dtype exp2 134 '..r.dtype)
 assert(same(r:tolist(),{1.0,2.0,4.0,128.0},6e-12),'unary-reg values exp2 134')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float16)
 local r=np.exp2(a)
 assert(r.dtype=='float16','unary-reg dtype exp2 135 '..r.dtype)
 assert(same(r:tolist(),{0.1767578125,1.0,1.189453125,4.0},0.008),'unary-reg values exp2 135')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float32)
 local r=np.exp2(a)
 assert(r.dtype=='float32','unary-reg dtype exp2 136 '..r.dtype)
 assert(same(r:tolist(),{0.1767766922712326,1.0,1.1892070770263672,4.0},2e-05),'unary-reg values exp2 136')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float64)
 local r=np.exp2(a)
 assert(r.dtype=='float64','unary-reg dtype exp2 137 '..r.dtype)
 assert(same(r:tolist(),{0.1767766952966369,1.0,1.189207115002721,4.0},6e-12),'unary-reg values exp2 137')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex64)
 local r=np.exp2(a)
 assert(r.dtype=='complex64','unary-reg cdtype exp2 138')
 assert(same(r:tolist(),{np.complex(0.25,0.0),np.complex(1.0,0.0),np.complex(1.0320992469787598,0.5907492637634277),np.complex(2.025844097137451,-3.4490513801574707)},2e-05),'unary-reg cvalues exp2 138')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex128)
 local r=np.exp2(a)
 assert(r.dtype=='complex128','unary-reg cdtype exp2 139')
 assert(same(r:tolist(),{np.complex(0.25,0.0),np.complex(1.0,0.0),np.complex(1.0320992302832874,0.5907493048846869),np.complex(2.0258441836117975,-3.449051368670268)},6e-12),'unary-reg cvalues exp2 139')
end
do
 local a=np.array({true,false,true,true},np.bool)
 local r=np.log2(a)
 assert(r.dtype=='float16','unary-reg dtype log2 140 '..r.dtype)
 assert(same(r:tolist(),{0.0,-math.huge,0.0,0.0},0.008),'unary-reg values log2 140')
end
do
 local a=np.array({-2,0,0,2},np.int8)
 local r=np.log2(a)
 assert(r.dtype=='float16','unary-reg dtype log2 141 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-math.huge,-math.huge,1.0},0.008),'unary-reg values log2 141')
end
do
 local a=np.array({0,1,2,7},np.uint8)
 local r=np.log2(a)
 assert(r.dtype=='float16','unary-reg dtype log2 142 '..r.dtype)
 assert(same(r:tolist(),{-math.huge,0.0,1.0,2.806640625},0.008),'unary-reg values log2 142')
end
do
 local a=np.array({-2,0,0,2},np.int16)
 local r=np.log2(a)
 assert(r.dtype=='float32','unary-reg dtype log2 143 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-math.huge,-math.huge,1.0},2e-05),'unary-reg values log2 143')
end
do
 local a=np.array({0,1,2,7},np.uint16)
 local r=np.log2(a)
 assert(r.dtype=='float32','unary-reg dtype log2 144 '..r.dtype)
 assert(same(r:tolist(),{-math.huge,0.0,1.0,2.8073549270629883},2e-05),'unary-reg values log2 144')
end
do
 local a=np.array({-2,0,0,2},np.int32)
 local r=np.log2(a)
 assert(r.dtype=='float64','unary-reg dtype log2 145 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-math.huge,-math.huge,1.0},6e-12),'unary-reg values log2 145')
end
do
 local a=np.array({0,1,2,7},np.uint32)
 local r=np.log2(a)
 assert(r.dtype=='float64','unary-reg dtype log2 146 '..r.dtype)
 assert(same(r:tolist(),{-math.huge,0.0,1.0,2.807354922057604},6e-12),'unary-reg values log2 146')
end
do
 local a=np.array({-2,0,0,2},np.int64)
 local r=np.log2(a)
 assert(r.dtype=='float64','unary-reg dtype log2 147 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-math.huge,-math.huge,1.0},6e-12),'unary-reg values log2 147')
end
do
 local a=np.array({0,1,2,7},np.uint64)
 local r=np.log2(a)
 assert(r.dtype=='float64','unary-reg dtype log2 148 '..r.dtype)
 assert(same(r:tolist(),{-math.huge,0.0,1.0,2.807354922057604},6e-12),'unary-reg values log2 148')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float16)
 local r=np.log2(a)
 assert(r.dtype=='float16','unary-reg dtype log2 149 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-math.huge,-2.0,1.0},0.008),'unary-reg values log2 149')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float32)
 local r=np.log2(a)
 assert(r.dtype=='float32','unary-reg dtype log2 150 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-math.huge,-2.0,1.0},2e-05),'unary-reg values log2 150')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float64)
 local r=np.log2(a)
 assert(r.dtype=='float64','unary-reg dtype log2 151 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-math.huge,-2.0,1.0},6e-12),'unary-reg values log2 151')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex64)
 local r=np.log2(a)
 assert(r.dtype=='complex64','unary-reg cdtype log2 152')
 assert(same(r:tolist(),{np.complex(1.0,4.532360076904297),np.complex(-math.huge,0.0),np.complex(-0.3390359580516815,1.8019920587539673),np.complex(1.3219281435012817,-0.9283758401870728)},2e-05),'unary-reg cvalues log2 152')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex128)
 local r=np.log2(a)
 assert(r.dtype=='complex128','unary-reg cdtype log2 153')
 assert(same(r:tolist(),{np.complex(1.0,4.532360141827193),np.complex(-math.huge,0.0),np.complex(-0.33903595255631885,1.8019921416822866),np.complex(1.3219280948873624,-0.9283758584626207)},6e-12),'unary-reg cvalues log2 153')
end
do
 local a=np.array({true,false,true,true},np.bool)
 local r=np.log10(a)
 assert(r.dtype=='float16','unary-reg dtype log10 154 '..r.dtype)
 assert(same(r:tolist(),{0.0,-math.huge,0.0,0.0},0.008),'unary-reg values log10 154')
end
do
 local a=np.array({-2,0,0,2},np.int8)
 local r=np.log10(a)
 assert(r.dtype=='float16','unary-reg dtype log10 155 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-math.huge,-math.huge,0.301025390625},0.008),'unary-reg values log10 155')
end
do
 local a=np.array({0,1,2,7},np.uint8)
 local r=np.log10(a)
 assert(r.dtype=='float16','unary-reg dtype log10 156 '..r.dtype)
 assert(same(r:tolist(),{-math.huge,0.0,0.301025390625,0.84521484375},0.008),'unary-reg values log10 156')
end
do
 local a=np.array({-2,0,0,2},np.int16)
 local r=np.log10(a)
 assert(r.dtype=='float32','unary-reg dtype log10 157 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-math.huge,-math.huge,0.3010300099849701},2e-05),'unary-reg values log10 157')
end
do
 local a=np.array({0,1,2,7},np.uint16)
 local r=np.log10(a)
 assert(r.dtype=='float32','unary-reg dtype log10 158 '..r.dtype)
 assert(same(r:tolist(),{-math.huge,0.0,0.3010300099849701,0.845098078250885},2e-05),'unary-reg values log10 158')
end
do
 local a=np.array({-2,0,0,2},np.int32)
 local r=np.log10(a)
 assert(r.dtype=='float64','unary-reg dtype log10 159 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-math.huge,-math.huge,0.3010299956639812},6e-12),'unary-reg values log10 159')
end
do
 local a=np.array({0,1,2,7},np.uint32)
 local r=np.log10(a)
 assert(r.dtype=='float64','unary-reg dtype log10 160 '..r.dtype)
 assert(same(r:tolist(),{-math.huge,0.0,0.3010299956639812,0.8450980400142568},6e-12),'unary-reg values log10 160')
end
do
 local a=np.array({-2,0,0,2},np.int64)
 local r=np.log10(a)
 assert(r.dtype=='float64','unary-reg dtype log10 161 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-math.huge,-math.huge,0.3010299956639812},6e-12),'unary-reg values log10 161')
end
do
 local a=np.array({0,1,2,7},np.uint64)
 local r=np.log10(a)
 assert(r.dtype=='float64','unary-reg dtype log10 162 '..r.dtype)
 assert(same(r:tolist(),{-math.huge,0.0,0.3010299956639812,0.8450980400142568},6e-12),'unary-reg values log10 162')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float16)
 local r=np.log10(a)
 assert(r.dtype=='float16','unary-reg dtype log10 163 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-math.huge,-0.60205078125,0.301025390625},0.008),'unary-reg values log10 163')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float32)
 local r=np.log10(a)
 assert(r.dtype=='float32','unary-reg dtype log10 164 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-math.huge,-0.6020600199699402,0.3010300099849701},2e-05),'unary-reg values log10 164')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float64)
 local r=np.log10(a)
 assert(r.dtype=='float64','unary-reg dtype log10 165 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-math.huge,-0.6020599913279624,0.3010299956639812},6e-12),'unary-reg values log10 165')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex64)
 local r=np.log10(a)
 assert(r.dtype=='complex64','unary-reg cdtype log10 166')
 assert(same(r:tolist(),{np.complex(0.3010300099849701,1.364376425743103),np.complex(-math.huge,0.0),np.complex(-0.1020599976181984,0.5424537062644958),np.complex(0.3979400396347046,-0.27946898341178894)},2e-05),'unary-reg cvalues log10 166')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex128)
 local r=np.log10(a)
 assert(r.dtype=='complex128','unary-reg cdtype log10 167')
 assert(same(r:tolist(),{np.complex(0.3010299956639812,1.3643763538418412),np.complex(-math.huge,0.0),np.complex(-0.1020599913279624,0.5424536865971469),np.complex(0.3979400086720376,-0.2794689806475475)},6e-12),'unary-reg cvalues log10 167')
end
do
 local a=np.array({true,false,true,true},np.bool)
 local r=np.expm1(a)
 assert(r.dtype=='float16','unary-reg dtype expm1 168 '..r.dtype)
 assert(same(r:tolist(),{1.71875,0.0,1.71875,1.71875},0.008),'unary-reg values expm1 168')
end
do
 local a=np.array({-2,0,0,2},np.int8)
 local r=np.expm1(a)
 assert(r.dtype=='float16','unary-reg dtype expm1 169 '..r.dtype)
 assert(same(r:tolist(),{-0.86474609375,0.0,0.0,6.390625},0.008),'unary-reg values expm1 169')
end
do
 local a=np.array({0,1,2,7},np.uint8)
 local r=np.expm1(a)
 assert(r.dtype=='float16','unary-reg dtype expm1 170 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.71875,6.390625,1096.0},0.008),'unary-reg values expm1 170')
end
do
 local a=np.array({-2,0,0,2},np.int16)
 local r=np.expm1(a)
 assert(r.dtype=='float32','unary-reg dtype expm1 171 '..r.dtype)
 assert(same(r:tolist(),{-0.8646647334098816,0.0,0.0,6.389056205749512},2e-05),'unary-reg values expm1 171')
end
do
 local a=np.array({0,1,2,7},np.uint16)
 local r=np.expm1(a)
 assert(r.dtype=='float32','unary-reg dtype expm1 172 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.718281865119934,6.389056205749512,1095.6331787109375},2e-05),'unary-reg values expm1 172')
end
do
 local a=np.array({-2,0,0,2},np.int32)
 local r=np.expm1(a)
 assert(r.dtype=='float64','unary-reg dtype expm1 173 '..r.dtype)
 assert(same(r:tolist(),{-0.8646647167633873,0.0,0.0,6.38905609893065},6e-12),'unary-reg values expm1 173')
end
do
 local a=np.array({0,1,2,7},np.uint32)
 local r=np.expm1(a)
 assert(r.dtype=='float64','unary-reg dtype expm1 174 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.7182818284590453,6.38905609893065,1095.6331584284585},6e-12),'unary-reg values expm1 174')
end
do
 local a=np.array({-2,0,0,2},np.int64)
 local r=np.expm1(a)
 assert(r.dtype=='float64','unary-reg dtype expm1 175 '..r.dtype)
 assert(same(r:tolist(),{-0.8646647167633873,0.0,0.0,6.38905609893065},6e-12),'unary-reg values expm1 175')
end
do
 local a=np.array({0,1,2,7},np.uint64)
 local r=np.expm1(a)
 assert(r.dtype=='float64','unary-reg dtype expm1 176 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.7182818284590453,6.38905609893065,1095.6331584284585},6e-12),'unary-reg values expm1 176')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float16)
 local r=np.expm1(a)
 assert(r.dtype=='float16','unary-reg dtype expm1 177 '..r.dtype)
 assert(same(r:tolist(),{-0.91796875,-0.0,0.283935546875,6.390625},0.008),'unary-reg values expm1 177')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float32)
 local r=np.expm1(a)
 assert(r.dtype=='float32','unary-reg dtype expm1 178 '..r.dtype)
 assert(same(r:tolist(),{-0.9179150462150574,-0.0,0.2840254306793213,6.389056205749512},2e-05),'unary-reg values expm1 178')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float64)
 local r=np.expm1(a)
 assert(r.dtype=='float64','unary-reg dtype expm1 179 '..r.dtype)
 assert(same(r:tolist(),{-0.9179150013761012,-0.0,0.2840254166877415,6.38905609893065},6e-12),'unary-reg values expm1 179')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex64)
 local r=np.expm1(a)
 assert(r.dtype=='complex64','unary-reg cdtype expm1 180')
 assert(same(r:tolist(),{np.complex(-0.8646647334098816,0.0),np.complex(0.0,0.0),np.complex(-0.060492902994155884,0.8752415180206299),np.complex(-0.4773188829421997,-7.370546817779541)},2e-05),'unary-reg cvalues expm1 180')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex128)
 local r=np.expm1(a)
 assert(r.dtype=='complex128','unary-reg cdtype expm1 181')
 assert(same(r:tolist(),{np.complex(-0.8646647167633873,0.0),np.complex(0.0,0.0),np.complex(-0.06049289525850987,0.875241492869477),np.complex(-0.47731884859597234,-7.370546414419436)},6e-12),'unary-reg cvalues expm1 181')
end
do
 local a=np.array({true,false,true,true},np.bool)
 local r=np.log1p(a)
 assert(r.dtype=='float16','unary-reg dtype log1p 182 '..r.dtype)
 assert(same(r:tolist(),{0.693359375,0.0,0.693359375,0.693359375},0.008),'unary-reg values log1p 182')
end
do
 local a=np.array({-2,0,0,2},np.int8)
 local r=np.log1p(a)
 assert(r.dtype=='float16','unary-reg dtype log1p 183 '..r.dtype)
 assert(same(r:tolist(),{(0/0),0.0,0.0,1.0986328125},0.008),'unary-reg values log1p 183')
end
do
 local a=np.array({0,1,2,7},np.uint8)
 local r=np.log1p(a)
 assert(r.dtype=='float16','unary-reg dtype log1p 184 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.693359375,1.0986328125,2.080078125},0.008),'unary-reg values log1p 184')
end
do
 local a=np.array({-2,0,0,2},np.int16)
 local r=np.log1p(a)
 assert(r.dtype=='float32','unary-reg dtype log1p 185 '..r.dtype)
 assert(same(r:tolist(),{(0/0),0.0,0.0,1.0986123085021973},2e-05),'unary-reg values log1p 185')
end
do
 local a=np.array({0,1,2,7},np.uint16)
 local r=np.log1p(a)
 assert(r.dtype=='float32','unary-reg dtype log1p 186 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.6931471824645996,1.0986123085021973,2.079441547393799},2e-05),'unary-reg values log1p 186')
end
do
 local a=np.array({-2,0,0,2},np.int32)
 local r=np.log1p(a)
 assert(r.dtype=='float64','unary-reg dtype log1p 187 '..r.dtype)
 assert(same(r:tolist(),{(0/0),0.0,0.0,1.0986122886681098},6e-12),'unary-reg values log1p 187')
end
do
 local a=np.array({0,1,2,7},np.uint32)
 local r=np.log1p(a)
 assert(r.dtype=='float64','unary-reg dtype log1p 188 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.6931471805599453,1.0986122886681098,2.0794415416798357},6e-12),'unary-reg values log1p 188')
end
do
 local a=np.array({-2,0,0,2},np.int64)
 local r=np.log1p(a)
 assert(r.dtype=='float64','unary-reg dtype log1p 189 '..r.dtype)
 assert(same(r:tolist(),{(0/0),0.0,0.0,1.0986122886681098},6e-12),'unary-reg values log1p 189')
end
do
 local a=np.array({0,1,2,7},np.uint64)
 local r=np.log1p(a)
 assert(r.dtype=='float64','unary-reg dtype log1p 190 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.6931471805599453,1.0986122886681098,2.0794415416798357},6e-12),'unary-reg values log1p 190')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float16)
 local r=np.log1p(a)
 assert(r.dtype=='float16','unary-reg dtype log1p 191 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-0.0,0.22314453125,1.0986328125},0.008),'unary-reg values log1p 191')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float32)
 local r=np.log1p(a)
 assert(r.dtype=='float32','unary-reg dtype log1p 192 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-0.0,0.2231435626745224,1.0986123085021973},2e-05),'unary-reg values log1p 192')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float64)
 local r=np.log1p(a)
 assert(r.dtype=='float64','unary-reg dtype log1p 193 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-0.0,0.22314355131420976,1.0986122886681098},6e-12),'unary-reg values log1p 193')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex64)
 local r=np.log1p(a)
 assert(r.dtype=='complex64','unary-reg cdtype log1p 194')
 assert(same(r:tolist(),{np.complex(0.0,3.1415927410125732),np.complex(0.0,0.0),np.complex(0.37688586115837097,0.5404195189476013),np.complex(1.210184097290039,-0.46364760398864746)},2e-05),'unary-reg cvalues log1p 194')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex128)
 local r=np.log1p(a)
 assert(r.dtype=='complex128','unary-reg cdtype log1p 195')
 assert(same(r:tolist(),{np.complex(0.0,3.141592653589793),np.complex(0.0,0.0),np.complex(0.3768859011881901,0.5404195002705842),np.complex(1.2101840643252146,-0.4636476090008061)},6e-12),'unary-reg cvalues log1p 195')
end
do
 local a=np.array({true,false,true,true},np.bool)
 local r=np.cbrt(a)
 assert(r.dtype=='float16','unary-reg dtype cbrt 196 '..r.dtype)
 assert(same(r:tolist(),{1.0,0.0,1.0,1.0},0.008),'unary-reg values cbrt 196')
end
do
 local a=np.array({-2,0,0,2},np.int8)
 local r=np.cbrt(a)
 assert(r.dtype=='float16','unary-reg dtype cbrt 197 '..r.dtype)
 assert(same(r:tolist(),{-1.259765625,0.0,0.0,1.259765625},0.008),'unary-reg values cbrt 197')
end
do
 local a=np.array({0,1,2,7},np.uint8)
 local r=np.cbrt(a)
 assert(r.dtype=='float16','unary-reg dtype cbrt 198 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.0,1.259765625,1.9130859375},0.008),'unary-reg values cbrt 198')
end
do
 local a=np.array({-2,0,0,2},np.int16)
 local r=np.cbrt(a)
 assert(r.dtype=='float32','unary-reg dtype cbrt 199 '..r.dtype)
 assert(same(r:tolist(),{-1.2599210739135742,0.0,0.0,1.2599210739135742},2e-05),'unary-reg values cbrt 199')
end
do
 local a=np.array({0,1,2,7},np.uint16)
 local r=np.cbrt(a)
 assert(r.dtype=='float32','unary-reg dtype cbrt 200 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.0,1.2599210739135742,1.912931203842163},2e-05),'unary-reg values cbrt 200')
end
do
 local a=np.array({-2,0,0,2},np.int32)
 local r=np.cbrt(a)
 assert(r.dtype=='float64','unary-reg dtype cbrt 201 '..r.dtype)
 assert(same(r:tolist(),{-1.2599210498948732,0.0,0.0,1.2599210498948732},6e-12),'unary-reg values cbrt 201')
end
do
 local a=np.array({0,1,2,7},np.uint32)
 local r=np.cbrt(a)
 assert(r.dtype=='float64','unary-reg dtype cbrt 202 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.0,1.2599210498948732,1.9129311827723892},6e-12),'unary-reg values cbrt 202')
end
do
 local a=np.array({-2,0,0,2},np.int64)
 local r=np.cbrt(a)
 assert(r.dtype=='float64','unary-reg dtype cbrt 203 '..r.dtype)
 assert(same(r:tolist(),{-1.2599210498948732,0.0,0.0,1.2599210498948732},6e-12),'unary-reg values cbrt 203')
end
do
 local a=np.array({0,1,2,7},np.uint64)
 local r=np.cbrt(a)
 assert(r.dtype=='float64','unary-reg dtype cbrt 204 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.0,1.2599210498948732,1.9129311827723892},6e-12),'unary-reg values cbrt 204')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float16)
 local r=np.cbrt(a)
 assert(r.dtype=='float16','unary-reg dtype cbrt 205 '..r.dtype)
 assert(same(r:tolist(),{-1.357421875,-0.0,0.6298828125,1.259765625},0.008),'unary-reg values cbrt 205')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float32)
 local r=np.cbrt(a)
 assert(r.dtype=='float32','unary-reg dtype cbrt 206 '..r.dtype)
 assert(same(r:tolist(),{-1.3572087287902832,-0.0,0.6299605369567871,1.2599210739135742},2e-05),'unary-reg values cbrt 206')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float64)
 local r=np.cbrt(a)
 assert(r.dtype=='float64','unary-reg dtype cbrt 207 '..r.dtype)
 assert(same(r:tolist(),{-1.3572088082974534,-0.0,0.6299605249474366,1.2599210498948732},6e-12),'unary-reg values cbrt 207')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex64)
 assert(not pcall(function() return np.cbrt(a) end),'unary-reg reject cbrt 208')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex128)
 assert(not pcall(function() return np.cbrt(a) end),'unary-reg reject cbrt 209')
end
do
 local a=np.array({true,false,true,true},np.bool)
 local r=np.arcsin(a)
 assert(r.dtype=='float16','unary-reg dtype arcsin 210 '..r.dtype)
 assert(same(r:tolist(),{1.5703125,0.0,1.5703125,1.5703125},0.008),'unary-reg values arcsin 210')
end
do
 local a=np.array({-2,0,0,2},np.int8)
 local r=np.arcsin(a)
 assert(r.dtype=='float16','unary-reg dtype arcsin 211 '..r.dtype)
 assert(same(r:tolist(),{(0/0),0.0,0.0,(0/0)},0.008),'unary-reg values arcsin 211')
end
do
 local a=np.array({0,1,2,7},np.uint8)
 local r=np.arcsin(a)
 assert(r.dtype=='float16','unary-reg dtype arcsin 212 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.5703125,(0/0),(0/0)},0.008),'unary-reg values arcsin 212')
end
do
 local a=np.array({-2,0,0,2},np.int16)
 local r=np.arcsin(a)
 assert(r.dtype=='float32','unary-reg dtype arcsin 213 '..r.dtype)
 assert(same(r:tolist(),{(0/0),0.0,0.0,(0/0)},2e-05),'unary-reg values arcsin 213')
end
do
 local a=np.array({0,1,2,7},np.uint16)
 local r=np.arcsin(a)
 assert(r.dtype=='float32','unary-reg dtype arcsin 214 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.5707963705062866,(0/0),(0/0)},2e-05),'unary-reg values arcsin 214')
end
do
 local a=np.array({-2,0,0,2},np.int32)
 local r=np.arcsin(a)
 assert(r.dtype=='float64','unary-reg dtype arcsin 215 '..r.dtype)
 assert(same(r:tolist(),{(0/0),0.0,0.0,(0/0)},6e-12),'unary-reg values arcsin 215')
end
do
 local a=np.array({0,1,2,7},np.uint32)
 local r=np.arcsin(a)
 assert(r.dtype=='float64','unary-reg dtype arcsin 216 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.5707963267948966,(0/0),(0/0)},6e-12),'unary-reg values arcsin 216')
end
do
 local a=np.array({-2,0,0,2},np.int64)
 local r=np.arcsin(a)
 assert(r.dtype=='float64','unary-reg dtype arcsin 217 '..r.dtype)
 assert(same(r:tolist(),{(0/0),0.0,0.0,(0/0)},6e-12),'unary-reg values arcsin 217')
end
do
 local a=np.array({0,1,2,7},np.uint64)
 local r=np.arcsin(a)
 assert(r.dtype=='float64','unary-reg dtype arcsin 218 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.5707963267948966,(0/0),(0/0)},6e-12),'unary-reg values arcsin 218')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float16)
 local r=np.arcsin(a)
 assert(r.dtype=='float16','unary-reg dtype arcsin 219 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-0.0,0.252685546875,(0/0)},0.008),'unary-reg values arcsin 219')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float32)
 local r=np.arcsin(a)
 assert(r.dtype=='float32','unary-reg dtype arcsin 220 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-0.0,0.252680242061615,(0/0)},2e-05),'unary-reg values arcsin 220')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float64)
 local r=np.arcsin(a)
 assert(r.dtype=='float64','unary-reg dtype arcsin 221 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-0.0,0.25268025514207865,(0/0)},6e-12),'unary-reg values arcsin 221')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex64)
 local r=np.arcsin(a)
 assert(r.dtype=='complex64','unary-reg cdtype arcsin 222')
 assert(same(r:tolist(),{np.complex(-1.5707963705062866,1.316957950592041),np.complex(0.0,0.0),np.complex(0.19986692070960999,0.7052894830703735),np.complex(0.8877651691436768,-1.6004101037979126)},2e-05),'unary-reg cvalues arcsin 222')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex128)
 local r=np.arcsin(a)
 assert(r.dtype=='complex128','unary-reg cdtype arcsin 223')
 assert(same(r:tolist(),{np.complex(-1.5707963267948966,1.3169578969248166),np.complex(0.0,0.0),np.complex(0.19986691917327254,0.7052894487791671),np.complex(0.8877651461839051,-1.6004100552346137)},6e-12),'unary-reg cvalues arcsin 223')
end
do
 local a=np.array({true,false,true,true},np.bool)
 local r=np.arccos(a)
 assert(r.dtype=='float16','unary-reg dtype arccos 224 '..r.dtype)
 assert(same(r:tolist(),{0.0,1.5703125,0.0,0.0},0.008),'unary-reg values arccos 224')
end
do
 local a=np.array({-2,0,0,2},np.int8)
 local r=np.arccos(a)
 assert(r.dtype=='float16','unary-reg dtype arccos 225 '..r.dtype)
 assert(same(r:tolist(),{(0/0),1.5703125,1.5703125,(0/0)},0.008),'unary-reg values arccos 225')
end
do
 local a=np.array({0,1,2,7},np.uint8)
 local r=np.arccos(a)
 assert(r.dtype=='float16','unary-reg dtype arccos 226 '..r.dtype)
 assert(same(r:tolist(),{1.5703125,0.0,(0/0),(0/0)},0.008),'unary-reg values arccos 226')
end
do
 local a=np.array({-2,0,0,2},np.int16)
 local r=np.arccos(a)
 assert(r.dtype=='float32','unary-reg dtype arccos 227 '..r.dtype)
 assert(same(r:tolist(),{(0/0),1.5707963705062866,1.5707963705062866,(0/0)},2e-05),'unary-reg values arccos 227')
end
do
 local a=np.array({0,1,2,7},np.uint16)
 local r=np.arccos(a)
 assert(r.dtype=='float32','unary-reg dtype arccos 228 '..r.dtype)
 assert(same(r:tolist(),{1.5707963705062866,0.0,(0/0),(0/0)},2e-05),'unary-reg values arccos 228')
end
do
 local a=np.array({-2,0,0,2},np.int32)
 local r=np.arccos(a)
 assert(r.dtype=='float64','unary-reg dtype arccos 229 '..r.dtype)
 assert(same(r:tolist(),{(0/0),1.5707963267948966,1.5707963267948966,(0/0)},6e-12),'unary-reg values arccos 229')
end
do
 local a=np.array({0,1,2,7},np.uint32)
 local r=np.arccos(a)
 assert(r.dtype=='float64','unary-reg dtype arccos 230 '..r.dtype)
 assert(same(r:tolist(),{1.5707963267948966,0.0,(0/0),(0/0)},6e-12),'unary-reg values arccos 230')
end
do
 local a=np.array({-2,0,0,2},np.int64)
 local r=np.arccos(a)
 assert(r.dtype=='float64','unary-reg dtype arccos 231 '..r.dtype)
 assert(same(r:tolist(),{(0/0),1.5707963267948966,1.5707963267948966,(0/0)},6e-12),'unary-reg values arccos 231')
end
do
 local a=np.array({0,1,2,7},np.uint64)
 local r=np.arccos(a)
 assert(r.dtype=='float64','unary-reg dtype arccos 232 '..r.dtype)
 assert(same(r:tolist(),{1.5707963267948966,0.0,(0/0),(0/0)},6e-12),'unary-reg values arccos 232')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float16)
 local r=np.arccos(a)
 assert(r.dtype=='float16','unary-reg dtype arccos 233 '..r.dtype)
 assert(same(r:tolist(),{(0/0),1.5703125,1.318359375,(0/0)},0.008),'unary-reg values arccos 233')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float32)
 local r=np.arccos(a)
 assert(r.dtype=='float32','unary-reg dtype arccos 234 '..r.dtype)
 assert(same(r:tolist(),{(0/0),1.5707963705062866,1.3181161880493164,(0/0)},2e-05),'unary-reg values arccos 234')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float64)
 local r=np.arccos(a)
 assert(r.dtype=='float64','unary-reg dtype arccos 235 '..r.dtype)
 assert(same(r:tolist(),{(0/0),1.5707963267948966,1.318116071652818,(0/0)},6e-12),'unary-reg values arccos 235')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex64)
 local r=np.arccos(a)
 assert(r.dtype=='complex64','unary-reg cdtype arccos 236')
 assert(same(r:tolist(),{np.complex(3.1415927410125732,-1.316957950592041),np.complex(1.5707963705062866,-0.0),np.complex(1.3709293603897095,-0.7052894830703735),np.complex(0.6830312013626099,1.6004101037979126)},2e-05),'unary-reg cvalues arccos 236')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex128)
 local r=np.arccos(a)
 assert(r.dtype=='complex128','unary-reg cdtype arccos 237')
 assert(same(r:tolist(),{np.complex(3.141592653589793,-1.3169578969248166),np.complex(1.5707963267948966,-0.0),np.complex(1.370929407621624,-0.7052894487791671),np.complex(0.6830311806109914,1.6004100552346137)},6e-12),'unary-reg cvalues arccos 237')
end
do
 local a=np.array({true,false,true,true},np.bool)
 local r=np.arctan(a)
 assert(r.dtype=='float16','unary-reg dtype arctan 238 '..r.dtype)
 assert(same(r:tolist(),{0.78515625,0.0,0.78515625,0.78515625},0.008),'unary-reg values arctan 238')
end
do
 local a=np.array({-2,0,0,2},np.int8)
 local r=np.arctan(a)
 assert(r.dtype=='float16','unary-reg dtype arctan 239 '..r.dtype)
 assert(same(r:tolist(),{-1.107421875,0.0,0.0,1.107421875},0.008),'unary-reg values arctan 239')
end
do
 local a=np.array({0,1,2,7},np.uint8)
 local r=np.arctan(a)
 assert(r.dtype=='float16','unary-reg dtype arctan 240 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.78515625,1.107421875,1.4287109375},0.008),'unary-reg values arctan 240')
end
do
 local a=np.array({-2,0,0,2},np.int16)
 local r=np.arctan(a)
 assert(r.dtype=='float32','unary-reg dtype arctan 241 '..r.dtype)
 assert(same(r:tolist(),{-1.1071487665176392,0.0,0.0,1.1071487665176392},2e-05),'unary-reg values arctan 241')
end
do
 local a=np.array({0,1,2,7},np.uint16)
 local r=np.arctan(a)
 assert(r.dtype=='float32','unary-reg dtype arctan 242 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.7853981852531433,1.1071487665176392,1.4288992881774902},2e-05),'unary-reg values arctan 242')
end
do
 local a=np.array({-2,0,0,2},np.int32)
 local r=np.arctan(a)
 assert(r.dtype=='float64','unary-reg dtype arctan 243 '..r.dtype)
 assert(same(r:tolist(),{-1.1071487177940904,0.0,0.0,1.1071487177940904},6e-12),'unary-reg values arctan 243')
end
do
 local a=np.array({0,1,2,7},np.uint32)
 local r=np.arctan(a)
 assert(r.dtype=='float64','unary-reg dtype arctan 244 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.7853981633974483,1.1071487177940904,1.4288992721907328},6e-12),'unary-reg values arctan 244')
end
do
 local a=np.array({-2,0,0,2},np.int64)
 local r=np.arctan(a)
 assert(r.dtype=='float64','unary-reg dtype arctan 245 '..r.dtype)
 assert(same(r:tolist(),{-1.1071487177940904,0.0,0.0,1.1071487177940904},6e-12),'unary-reg values arctan 245')
end
do
 local a=np.array({0,1,2,7},np.uint64)
 local r=np.arctan(a)
 assert(r.dtype=='float64','unary-reg dtype arctan 246 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.7853981633974483,1.1071487177940904,1.4288992721907328},6e-12),'unary-reg values arctan 246')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float16)
 local r=np.arctan(a)
 assert(r.dtype=='float16','unary-reg dtype arctan 247 '..r.dtype)
 assert(same(r:tolist(),{-1.1904296875,-0.0,0.2449951171875,1.107421875},0.008),'unary-reg values arctan 247')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float32)
 local r=np.arctan(a)
 assert(r.dtype=='float32','unary-reg dtype arctan 248 '..r.dtype)
 assert(same(r:tolist(),{-1.1902899742126465,-0.0,0.244978666305542,1.1071487665176392},2e-05),'unary-reg values arctan 248')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float64)
 local r=np.arctan(a)
 assert(r.dtype=='float64','unary-reg dtype arctan 249 '..r.dtype)
 assert(same(r:tolist(),{-1.1902899496825317,-0.0,0.24497866312686414,1.1071487177940904},6e-12),'unary-reg values arctan 249')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex64)
 local r=np.arctan(a)
 assert(r.dtype=='complex64','unary-reg cdtype arctan 250')
 assert(same(r:tolist(),{np.complex(-1.1071487665176392,0.0),np.complex(0.0,0.0),np.complex(0.46364760398864746,0.8047189712524414),np.complex(1.2452579736709595,-0.22008968889713287)},2e-05),'unary-reg cvalues arctan 250')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex128)
 local r=np.arctan(a)
 assert(r.dtype=='complex128','unary-reg cdtype arctan 251')
 assert(same(r:tolist(),{np.complex(-1.1071487177940904,0.0),np.complex(0.0,0.0),np.complex(0.4636476090008061,0.8047189562170501),np.complex(1.2452579660726568,-0.22008968066202295)},6e-12),'unary-reg cvalues arctan 251')
end
do
 local a=np.array({true,false,true,true},np.bool)
 local r=np.arcsinh(a)
 assert(r.dtype=='float16','unary-reg dtype arcsinh 252 '..r.dtype)
 assert(same(r:tolist(),{0.88134765625,0.0,0.88134765625,0.88134765625},0.008),'unary-reg values arcsinh 252')
end
do
 local a=np.array({-2,0,0,2},np.int8)
 local r=np.arcsinh(a)
 assert(r.dtype=='float16','unary-reg dtype arcsinh 253 '..r.dtype)
 assert(same(r:tolist(),{-1.443359375,0.0,0.0,1.443359375},0.008),'unary-reg values arcsinh 253')
end
do
 local a=np.array({0,1,2,7},np.uint8)
 local r=np.arcsinh(a)
 assert(r.dtype=='float16','unary-reg dtype arcsinh 254 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.88134765625,1.443359375,2.64453125},0.008),'unary-reg values arcsinh 254')
end
do
 local a=np.array({-2,0,0,2},np.int16)
 local r=np.arcsinh(a)
 assert(r.dtype=='float32','unary-reg dtype arcsinh 255 '..r.dtype)
 assert(same(r:tolist(),{-1.4436354637145996,0.0,0.0,1.4436354637145996},2e-05),'unary-reg values arcsinh 255')
end
do
 local a=np.array({0,1,2,7},np.uint16)
 local r=np.arcsinh(a)
 assert(r.dtype=='float32','unary-reg dtype arcsinh 256 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.8813735842704773,1.4436354637145996,2.644120693206787},2e-05),'unary-reg values arcsinh 256')
end
do
 local a=np.array({-2,0,0,2},np.int32)
 local r=np.arcsinh(a)
 assert(r.dtype=='float64','unary-reg dtype arcsinh 257 '..r.dtype)
 assert(same(r:tolist(),{-1.4436354751788103,0.0,0.0,1.4436354751788103},6e-12),'unary-reg values arcsinh 257')
end
do
 local a=np.array({0,1,2,7},np.uint32)
 local r=np.arcsinh(a)
 assert(r.dtype=='float64','unary-reg dtype arcsinh 258 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.881373587019543,1.4436354751788103,2.644120761058629},6e-12),'unary-reg values arcsinh 258')
end
do
 local a=np.array({-2,0,0,2},np.int64)
 local r=np.arcsinh(a)
 assert(r.dtype=='float64','unary-reg dtype arcsinh 259 '..r.dtype)
 assert(same(r:tolist(),{-1.4436354751788103,0.0,0.0,1.4436354751788103},6e-12),'unary-reg values arcsinh 259')
end
do
 local a=np.array({0,1,2,7},np.uint64)
 local r=np.arcsinh(a)
 assert(r.dtype=='float64','unary-reg dtype arcsinh 260 '..r.dtype)
 assert(same(r:tolist(),{0.0,0.881373587019543,1.4436354751788103,2.644120761058629},6e-12),'unary-reg values arcsinh 260')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float16)
 local r=np.arcsinh(a)
 assert(r.dtype=='float16','unary-reg dtype arcsinh 261 '..r.dtype)
 assert(same(r:tolist(),{-1.6474609375,-0.0,0.2474365234375,1.443359375},0.008),'unary-reg values arcsinh 261')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float32)
 local r=np.arcsinh(a)
 assert(r.dtype=='float32','unary-reg dtype arcsinh 262 '..r.dtype)
 assert(same(r:tolist(),{-1.647231101989746,-0.0,0.24746645987033844,1.4436354637145996},2e-05),'unary-reg values arcsinh 262')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float64)
 local r=np.arcsinh(a)
 assert(r.dtype=='float64','unary-reg dtype arcsinh 263 '..r.dtype)
 assert(same(r:tolist(),{-1.6472311463710958,-0.0,0.24746646154726346,1.4436354751788103},6e-12),'unary-reg values arcsinh 263')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex64)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex64','unary-reg cdtype arcsinh 264')
 assert(same(r:tolist(),{np.complex(-1.4436354637145996,0.0),np.complex(0.0,0.0),np.complex(0.3465735912322998,0.7853981852531433),np.complex(1.622494101524353,-0.6065115332603455)},2e-05),'unary-reg cvalues arcsinh 264')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex128)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex128','unary-reg cdtype arcsinh 265')
 assert(same(r:tolist(),{np.complex(-1.4436354751788103,0.0),np.complex(0.0,0.0),np.complex(0.34657359027997264,0.7853981633974483),np.complex(1.6224941488715938,-0.6065115181997549)},6e-12),'unary-reg cvalues arcsinh 265')
end
do
 local a=np.array({true,false,true,true},np.bool)
 local r=np.arccosh(a)
 assert(r.dtype=='float16','unary-reg dtype arccosh 266 '..r.dtype)
 assert(same(r:tolist(),{0.0,(0/0),0.0,0.0},0.008),'unary-reg values arccosh 266')
end
do
 local a=np.array({-2,0,0,2},np.int8)
 local r=np.arccosh(a)
 assert(r.dtype=='float16','unary-reg dtype arccosh 267 '..r.dtype)
 assert(same(r:tolist(),{(0/0),(0/0),(0/0),1.3173828125},0.008),'unary-reg values arccosh 267')
end
do
 local a=np.array({0,1,2,7},np.uint8)
 local r=np.arccosh(a)
 assert(r.dtype=='float16','unary-reg dtype arccosh 268 '..r.dtype)
 assert(same(r:tolist(),{(0/0),0.0,1.3173828125,2.634765625},0.008),'unary-reg values arccosh 268')
end
do
 local a=np.array({-2,0,0,2},np.int16)
 local r=np.arccosh(a)
 assert(r.dtype=='float32','unary-reg dtype arccosh 269 '..r.dtype)
 assert(same(r:tolist(),{(0/0),(0/0),(0/0),1.316957950592041},2e-05),'unary-reg values arccosh 269')
end
do
 local a=np.array({0,1,2,7},np.uint16)
 local r=np.arccosh(a)
 assert(r.dtype=='float32','unary-reg dtype arccosh 270 '..r.dtype)
 assert(same(r:tolist(),{(0/0),0.0,1.316957950592041,2.633915901184082},2e-05),'unary-reg values arccosh 270')
end
do
 local a=np.array({-2,0,0,2},np.int32)
 local r=np.arccosh(a)
 assert(r.dtype=='float64','unary-reg dtype arccosh 271 '..r.dtype)
 assert(same(r:tolist(),{(0/0),(0/0),(0/0),1.3169578969248168},6e-12),'unary-reg values arccosh 271')
end
do
 local a=np.array({0,1,2,7},np.uint32)
 local r=np.arccosh(a)
 assert(r.dtype=='float64','unary-reg dtype arccosh 272 '..r.dtype)
 assert(same(r:tolist(),{(0/0),0.0,1.3169578969248168,2.6339157938496336},6e-12),'unary-reg values arccosh 272')
end
do
 local a=np.array({-2,0,0,2},np.int64)
 local r=np.arccosh(a)
 assert(r.dtype=='float64','unary-reg dtype arccosh 273 '..r.dtype)
 assert(same(r:tolist(),{(0/0),(0/0),(0/0),1.3169578969248168},6e-12),'unary-reg values arccosh 273')
end
do
 local a=np.array({0,1,2,7},np.uint64)
 local r=np.arccosh(a)
 assert(r.dtype=='float64','unary-reg dtype arccosh 274 '..r.dtype)
 assert(same(r:tolist(),{(0/0),0.0,1.3169578969248168,2.6339157938496336},6e-12),'unary-reg values arccosh 274')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float16)
 local r=np.arccosh(a)
 assert(r.dtype=='float16','unary-reg dtype arccosh 275 '..r.dtype)
 assert(same(r:tolist(),{(0/0),(0/0),(0/0),1.3173828125},0.008),'unary-reg values arccosh 275')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float32)
 local r=np.arccosh(a)
 assert(r.dtype=='float32','unary-reg dtype arccosh 276 '..r.dtype)
 assert(same(r:tolist(),{(0/0),(0/0),(0/0),1.316957950592041},2e-05),'unary-reg values arccosh 276')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float64)
 local r=np.arccosh(a)
 assert(r.dtype=='float64','unary-reg dtype arccosh 277 '..r.dtype)
 assert(same(r:tolist(),{(0/0),(0/0),(0/0),1.3169578969248168},6e-12),'unary-reg values arccosh 277')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex64)
 local r=np.arccosh(a)
 assert(r.dtype=='complex64','unary-reg cdtype arccosh 278')
 assert(same(r:tolist(),{np.complex(1.316957950592041,3.1415927410125732),np.complex(0.0,1.5707963705062866),np.complex(0.7052894830703735,1.3709293603897095),np.complex(1.6004101037979126,-0.6830312013626099)},2e-05),'unary-reg cvalues arccosh 278')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex128)
 local r=np.arccosh(a)
 assert(r.dtype=='complex128','unary-reg cdtype arccosh 279')
 assert(same(r:tolist(),{np.complex(1.3169578969248166,3.141592653589793),np.complex(0.0,1.5707963267948966),np.complex(0.7052894487791671,1.370929407621624),np.complex(1.6004100552346137,-0.6830311806109914)},6e-12),'unary-reg cvalues arccosh 279')
end
do
 local a=np.array({true,false,true,true},np.bool)
 local r=np.arctanh(a)
 assert(r.dtype=='float16','unary-reg dtype arctanh 280 '..r.dtype)
 assert(same(r:tolist(),{math.huge,0.0,math.huge,math.huge},0.008),'unary-reg values arctanh 280')
end
do
 local a=np.array({-2,0,0,2},np.int8)
 local r=np.arctanh(a)
 assert(r.dtype=='float16','unary-reg dtype arctanh 281 '..r.dtype)
 assert(same(r:tolist(),{(0/0),0.0,0.0,(0/0)},0.008),'unary-reg values arctanh 281')
end
do
 local a=np.array({0,1,2,7},np.uint8)
 local r=np.arctanh(a)
 assert(r.dtype=='float16','unary-reg dtype arctanh 282 '..r.dtype)
 assert(same(r:tolist(),{0.0,math.huge,(0/0),(0/0)},0.008),'unary-reg values arctanh 282')
end
do
 local a=np.array({-2,0,0,2},np.int16)
 local r=np.arctanh(a)
 assert(r.dtype=='float32','unary-reg dtype arctanh 283 '..r.dtype)
 assert(same(r:tolist(),{(0/0),0.0,0.0,(0/0)},2e-05),'unary-reg values arctanh 283')
end
do
 local a=np.array({0,1,2,7},np.uint16)
 local r=np.arctanh(a)
 assert(r.dtype=='float32','unary-reg dtype arctanh 284 '..r.dtype)
 assert(same(r:tolist(),{0.0,math.huge,(0/0),(0/0)},2e-05),'unary-reg values arctanh 284')
end
do
 local a=np.array({-2,0,0,2},np.int32)
 local r=np.arctanh(a)
 assert(r.dtype=='float64','unary-reg dtype arctanh 285 '..r.dtype)
 assert(same(r:tolist(),{(0/0),0.0,0.0,(0/0)},6e-12),'unary-reg values arctanh 285')
end
do
 local a=np.array({0,1,2,7},np.uint32)
 local r=np.arctanh(a)
 assert(r.dtype=='float64','unary-reg dtype arctanh 286 '..r.dtype)
 assert(same(r:tolist(),{0.0,math.huge,(0/0),(0/0)},6e-12),'unary-reg values arctanh 286')
end
do
 local a=np.array({-2,0,0,2},np.int64)
 local r=np.arctanh(a)
 assert(r.dtype=='float64','unary-reg dtype arctanh 287 '..r.dtype)
 assert(same(r:tolist(),{(0/0),0.0,0.0,(0/0)},6e-12),'unary-reg values arctanh 287')
end
do
 local a=np.array({0,1,2,7},np.uint64)
 local r=np.arctanh(a)
 assert(r.dtype=='float64','unary-reg dtype arctanh 288 '..r.dtype)
 assert(same(r:tolist(),{0.0,math.huge,(0/0),(0/0)},6e-12),'unary-reg values arctanh 288')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float16)
 local r=np.arctanh(a)
 assert(r.dtype=='float16','unary-reg dtype arctanh 289 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-0.0,0.25537109375,(0/0)},0.008),'unary-reg values arctanh 289')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float32)
 local r=np.arctanh(a)
 assert(r.dtype=='float32','unary-reg dtype arctanh 290 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-0.0,0.2554128170013428,(0/0)},2e-05),'unary-reg values arctanh 290')
end
do
 local a=np.array({-2.5,-0.0,0.25,2.0},np.float64)
 local r=np.arctanh(a)
 assert(r.dtype=='float64','unary-reg dtype arctanh 291 '..r.dtype)
 assert(same(r:tolist(),{(0/0),-0.0,0.25541281188299536,(0/0)},6e-12),'unary-reg values arctanh 291')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex64)
 local r=np.arctanh(a)
 assert(r.dtype=='complex64','unary-reg cdtype arctanh 292')
 assert(same(r:tolist(),{np.complex(-0.5493061542510986,1.5707963705062866),np.complex(0.0,0.0),np.complex(0.15899719297885895,0.6629088521003723),np.complex(0.31042829155921936,-1.3112232685089111)},2e-05),'unary-reg cvalues arctanh 292')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(0.0,0.0),np.complex(0.25,0.75),np.complex(2.0,-1.5)},np.complex128)
 local r=np.arctanh(a)
 assert(r.dtype=='complex128','unary-reg cdtype arctanh 293')
 assert(same(r:tolist(),{np.complex(-0.5493061443340549,1.5707963267948966),np.complex(0.0,0.0),np.complex(0.15899719167999918,0.6629088318340163),np.complex(0.3104282830771958,-1.311223269671635)},6e-12),'unary-reg cvalues arctanh 293')
end
do
 local a=np.array({0.25,0.5,1.0,1.5},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.sqrt(a,{out=o,where=m})
 assert(r==o,'unary-reg out identity')
 assert(same(o:tolist(),{0.5,80.0,1.0,60.0},3e-5),'unary-reg out sqrt 294')
end
do
 local a=np.array({0.25,0.5,1.0,1.5},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.exp(a,{out=o,where=m})
 assert(r==o,'unary-reg out identity')
 assert(same(o:tolist(),{1.2840255498886108,80.0,2.7182819843292236,60.0},3e-5),'unary-reg out exp 295')
end
do
 local a=np.array({0.25,0.5,1.0,1.5},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.log(a,{out=o,where=m})
 assert(r==o,'unary-reg out identity')
 assert(same(o:tolist(),{-1.3862943649291992,80.0,0.0,60.0},3e-5),'unary-reg out log 296')
end
do
 local a=np.array({0.25,0.5,1.0,1.5},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.sin(a,{out=o,where=m})
 assert(r==o,'unary-reg out identity')
 assert(same(o:tolist(),{0.24740396440029144,80.0,0.8414710164070129,60.0},3e-5),'unary-reg out sin 297')
end
do
 local a=np.array({0.25,0.5,1.0,1.5},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.cos(a,{out=o,where=m})
 assert(r==o,'unary-reg out identity')
 assert(same(o:tolist(),{0.9689124226570129,80.0,0.5403022766113281,60.0},3e-5),'unary-reg out cos 298')
end
do
 local a=np.array({0.25,0.5,1.0,1.5},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.tan(a,{out=o,where=m})
 assert(r==o,'unary-reg out identity')
 assert(same(o:tolist(),{0.25534191727638245,80.0,1.5574077367782593,60.0},3e-5),'unary-reg out tan 299')
end
do
 local a=np.array({0.25,0.5,1.0,1.5},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.sinh(a,{out=o,where=m})
 assert(r==o,'unary-reg out identity')
 assert(same(o:tolist(),{0.25261232256889343,80.0,1.175201177597046,60.0},3e-5),'unary-reg out sinh 300')
end
do
 local a=np.array({0.25,0.5,1.0,1.5},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.cosh(a,{out=o,where=m})
 assert(r==o,'unary-reg out identity')
 assert(same(o:tolist(),{1.031413197517395,80.0,1.5430806875228882,60.0},3e-5),'unary-reg out cosh 301')
end
do
 local a=np.array({0.25,0.5,1.0,1.5},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.tanh(a,{out=o,where=m})
 assert(r==o,'unary-reg out identity')
 assert(same(o:tolist(),{0.24491865932941437,80.0,0.7615941762924194,60.0},3e-5),'unary-reg out tanh 302')
end
do
 local a=np.array({0.25,0.5,1.0,1.5},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.exp2(a,{out=o,where=m})
 assert(r==o,'unary-reg out identity')
 assert(same(o:tolist(),{1.1892070770263672,80.0,2.0,60.0},3e-5),'unary-reg out exp2 303')
end
do
 local a=np.array({0.25,0.5,1.0,1.5},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.log2(a,{out=o,where=m})
 assert(r==o,'unary-reg out identity')
 assert(same(o:tolist(),{-2.0,80.0,0.0,60.0},3e-5),'unary-reg out log2 304')
end
do
 local a=np.array({0.25,0.5,1.0,1.5},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.log10(a,{out=o,where=m})
 assert(r==o,'unary-reg out identity')
 assert(same(o:tolist(),{-0.6020600199699402,80.0,0.0,60.0},3e-5),'unary-reg out log10 305')
end
do
 local a=np.array({0.25,0.5,1.0,1.5},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.expm1(a,{out=o,where=m})
 assert(r==o,'unary-reg out identity')
 assert(same(o:tolist(),{0.2840254306793213,80.0,1.718281865119934,60.0},3e-5),'unary-reg out expm1 306')
end
do
 local a=np.array({0.25,0.5,1.0,1.5},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.log1p(a,{out=o,where=m})
 assert(r==o,'unary-reg out identity')
 assert(same(o:tolist(),{0.2231435626745224,80.0,0.6931471824645996,60.0},3e-5),'unary-reg out log1p 307')
end
do
 local a=np.array({0.25,0.5,1.0,1.5},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.cbrt(a,{out=o,where=m})
 assert(r==o,'unary-reg out identity')
 assert(same(o:tolist(),{0.6299605369567871,80.0,1.0,60.0},3e-5),'unary-reg out cbrt 308')
end
do
 local a=np.array({0.25,0.5,1.0,1.5},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.arcsin(a,{out=o,where=m})
 assert(r==o,'unary-reg out identity')
 assert(same(o:tolist(),{0.252680242061615,80.0,1.5707963705062866,60.0},3e-5),'unary-reg out arcsin 309')
end
do
 local a=np.array({0.25,0.5,1.0,1.5},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.arccos(a,{out=o,where=m})
 assert(r==o,'unary-reg out identity')
 assert(same(o:tolist(),{1.3181161880493164,80.0,0.0,60.0},3e-5),'unary-reg out arccos 310')
end
do
 local a=np.array({0.25,0.5,1.0,1.5},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.arctan(a,{out=o,where=m})
 assert(r==o,'unary-reg out identity')
 assert(same(o:tolist(),{0.244978666305542,80.0,0.7853981852531433,60.0},3e-5),'unary-reg out arctan 311')
end
do
 local a=np.array({0.25,0.5,1.0,1.5},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.arcsinh(a,{out=o,where=m})
 assert(r==o,'unary-reg out identity')
 assert(same(o:tolist(),{0.24746645987033844,80.0,0.8813735842704773,60.0},3e-5),'unary-reg out arcsinh 312')
end
do
 local a=np.array({0.25,0.5,1.0,1.5},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.arccosh(a,{out=o,where=m})
 assert(r==o,'unary-reg out identity')
 assert(same(o:tolist(),{(0/0),80.0,0.0,60.0},3e-5),'unary-reg out arccosh 313')
end
do
 local a=np.array({0.25,0.5,1.0,1.5},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({90.0,80.0,70.0,60.0},np.float64)
 local r=np.arctanh(a,{out=o,where=m})
 assert(r==o,'unary-reg out identity')
 assert(same(o:tolist(),{0.2554128170013428,80.0,math.huge,60.0},3e-5),'unary-reg out arctanh 314')
end
do
 local v={} for i=1,24 do v[i]=i-1 end
 local a=np.reshape(np.array(v,np.float64),{2,3,4}); local t=a:transpose()
 local r=np.sqrt(t)
 assert(seqeq(r.strides,{8,32,96}),'unary-reg KEEPORDER sqrt 315')
end
do
 local v={} for i=1,24 do v[i]=i-1 end
 local a=np.reshape(np.array(v,np.float64),{2,3,4}); local t=a:transpose()
 local r=np.exp(t)
 assert(seqeq(r.strides,{8,32,96}),'unary-reg KEEPORDER exp 316')
end
do
 local v={} for i=1,24 do v[i]=i-1 end
 local a=np.reshape(np.array(v,np.float64),{2,3,4}); local t=a:transpose()
 local r=np.sin(t)
 assert(seqeq(r.strides,{8,32,96}),'unary-reg KEEPORDER sin 317')
end
do
 local v={} for i=1,24 do v[i]=i-1 end
 local a=np.reshape(np.array(v,np.float64),{2,3,4}); local t=a:transpose()
 local r=np.arcsin(t)
 assert(seqeq(r.strides,{8,32,96}),'unary-reg KEEPORDER arcsin 318')
end
do
 local v={} for i=1,24 do v[i]=i-1 end
 local a=np.reshape(np.array(v,np.float64),{2,3,4}); local t=a:transpose()
 local r=np.arcsinh(t)
 assert(seqeq(r.strides,{8,32,96}),'unary-reg KEEPORDER arcsinh 319')
end
do
 local a=np.array({-0.0},np.float64)
 local r=np.sqrt(a)
 assert(1/r:tolist()[1]==-math.huge,'unary-reg signed zero sqrt 320')
end
do
 local a=np.array({-0.0},np.float64)
 local r=np.sin(a)
 assert(1/r:tolist()[1]==-math.huge,'unary-reg signed zero sin 321')
end
do
 local a=np.array({-0.0},np.float64)
 local r=np.tan(a)
 assert(1/r:tolist()[1]==-math.huge,'unary-reg signed zero tan 322')
end
do
 local a=np.array({-0.0},np.float64)
 local r=np.sinh(a)
 assert(1/r:tolist()[1]==-math.huge,'unary-reg signed zero sinh 323')
end
do
 local a=np.array({-0.0},np.float64)
 local r=np.tanh(a)
 assert(1/r:tolist()[1]==-math.huge,'unary-reg signed zero tanh 324')
end
do
 local a=np.array({-0.0},np.float64)
 local r=np.expm1(a)
 assert(1/r:tolist()[1]==-math.huge,'unary-reg signed zero expm1 325')
end
do
 local a=np.array({-0.0},np.float64)
 local r=np.log1p(a)
 assert(1/r:tolist()[1]==-math.huge,'unary-reg signed zero log1p 326')
end
do
 local a=np.array({-0.0},np.float64)
 local r=np.cbrt(a)
 assert(1/r:tolist()[1]==-math.huge,'unary-reg signed zero cbrt 327')
end
do
 local a=np.array({-0.0},np.float64)
 local r=np.arcsin(a)
 assert(1/r:tolist()[1]==-math.huge,'unary-reg signed zero arcsin 328')
end
do
 local a=np.array({-0.0},np.float64)
 local r=np.arctan(a)
 assert(1/r:tolist()[1]==-math.huge,'unary-reg signed zero arctan 329')
end
do
 local a=np.array({-0.0},np.float64)
 local r=np.arcsinh(a)
 assert(1/r:tolist()[1]==-math.huge,'unary-reg signed zero arcsinh 330')
end
do
 local a=np.array({-0.0},np.float64)
 local r=np.arctanh(a)
 assert(1/r:tolist()[1]==-math.huge,'unary-reg signed zero arctanh 331')
end
do
 local a=np.array({0.25,0.5},np.float64)
 local r=np.asin(a)
 assert(same(r:tolist(),{0.25268025514207865,0.5235987755982989},1e-12),'unary-reg alias asin 332')
end
do
 local a=np.array({0.25,0.5},np.float64)
 local r=np.acos(a)
 assert(same(r:tolist(),{1.318116071652818,1.0471975511965976},1e-12),'unary-reg alias acos 333')
end
do
 local a=np.array({0.25,0.5},np.float64)
 local r=np.atan(a)
 assert(same(r:tolist(),{0.24497866312686414,0.4636476090008061},1e-12),'unary-reg alias atan 334')
end
do
 local a=np.array({0.25,0.5},np.float64)
 local r=np.asinh(a)
 assert(same(r:tolist(),{0.24746646154726346,0.48121182505960347},1e-12),'unary-reg alias asinh 335')
end
do
 local a=np.array({0.25,0.5},np.float64)
 local r=np.acosh(a)
 assert(same(r:tolist(),{(0/0),(0/0)},1e-12),'unary-reg alias acosh 336')
end
do
 local a=np.array({0.25,0.5},np.float64)
 local r=np.atanh(a)
 assert(same(r:tolist(),{0.25541281188299536,0.5493061443340549},1e-12),'unary-reg alias atanh 337')
end
print('unary registry differential: 338 cases ok')
