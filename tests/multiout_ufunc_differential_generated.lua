local np=require('luaray_core')

local function fsame(a,b,tol)
  if a~=a and b~=b then return true end
  if a==b then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return false end
  return math.abs(a-b)<=tol*math.max(1,math.abs(a),math.abs(b))
end
local function list_same(a,b,tol)
  if #a~=#b then return false end
  for i=1,#a do if not fsame(a[i],b[i],tol) then return false end end
  return true
end
local function bool_list_same(a,b)
  if #a~=#b then return false end
  for i=1,#a do if a[i]~=b[i] then return false end end
  return true
end
local function zero_sign_same(arr,expected,signs)
  local got=arr:tolist(); local gs=np.signbit(arr):tolist()
  for i=1,#got do
    if expected[i]==0 and gs[i]~=signs[i] then return false end
  end
  return true
end
-- Development oracle NumPy 2.3.5; source signatures pinned to uploaded NumPy main.
do
 local a=np.array({false,true},np.bool)
 local m,e=np.frexp(a)
 assert(m.dtype=='float16' and e.dtype=='int32','frexp dtype 0')
 assert(list_same(m:tolist(),{0.0,0.5},0.004),'frexp mant 0')
 assert(list_same(e:tolist(),{0,1},0),'frexp exp 0')
 assert(zero_sign_same(m,{0.0,0.5},{false,false}),'frexp signs 0')
 local f,i=np.modf(a)
 assert(f.dtype=='float16' and i.dtype=='float16','modf dtype 0')
 assert(list_same(f:tolist(),{0.0,0.0},0.004),'modf frac 0')
 assert(list_same(i:tolist(),{0.0,1.0},0.004),'modf int 0')
 assert(zero_sign_same(f,{0.0,0.0},{false,false}),'modf frac signs 0')
 assert(zero_sign_same(i,{0.0,1.0},{false,false}),'modf int signs 0')
end
do
 local a=np.array({-127,-17,-2,-1,0,1,2,17,127},np.int8)
 local m,e=np.frexp(a)
 assert(m.dtype=='float16' and e.dtype=='int32','frexp dtype 2')
 assert(list_same(m:tolist(),{-0.9921875,-0.53125,-0.5,-0.5,0.0,0.5,0.5,0.53125,0.9921875},0.004),'frexp mant 2')
 assert(list_same(e:tolist(),{7,5,2,1,0,1,2,5,7},0),'frexp exp 2')
 assert(zero_sign_same(m,{-0.9921875,-0.53125,-0.5,-0.5,0.0,0.5,0.5,0.53125,0.9921875},{true,true,true,true,false,false,false,false,false}),'frexp signs 2')
 local f,i=np.modf(a)
 assert(f.dtype=='float16' and i.dtype=='float16','modf dtype 2')
 assert(list_same(f:tolist(),{-0.0,-0.0,-0.0,-0.0,0.0,0.0,0.0,0.0,0.0},0.004),'modf frac 2')
 assert(list_same(i:tolist(),{-127.0,-17.0,-2.0,-1.0,0.0,1.0,2.0,17.0,127.0},0.004),'modf int 2')
 assert(zero_sign_same(f,{-0.0,-0.0,-0.0,-0.0,0.0,0.0,0.0,0.0,0.0},{true,true,true,true,false,false,false,false,false}),'modf frac signs 2')
 assert(zero_sign_same(i,{-127.0,-17.0,-2.0,-1.0,0.0,1.0,2.0,17.0,127.0},{true,true,true,true,false,false,false,false,false}),'modf int signs 2')
end
do
 local a=np.array({0,1,2,5,17,127},np.uint8)
 local m,e=np.frexp(a)
 assert(m.dtype=='float16' and e.dtype=='int32','frexp dtype 4')
 assert(list_same(m:tolist(),{0.0,0.5,0.5,0.625,0.53125,0.9921875},0.004),'frexp mant 4')
 assert(list_same(e:tolist(),{0,1,2,3,5,7},0),'frexp exp 4')
 assert(zero_sign_same(m,{0.0,0.5,0.5,0.625,0.53125,0.9921875},{false,false,false,false,false,false}),'frexp signs 4')
 local f,i=np.modf(a)
 assert(f.dtype=='float16' and i.dtype=='float16','modf dtype 4')
 assert(list_same(f:tolist(),{0.0,0.0,0.0,0.0,0.0,0.0},0.004),'modf frac 4')
 assert(list_same(i:tolist(),{0.0,1.0,2.0,5.0,17.0,127.0},0.004),'modf int 4')
 assert(zero_sign_same(f,{0.0,0.0,0.0,0.0,0.0,0.0},{false,false,false,false,false,false}),'modf frac signs 4')
 assert(zero_sign_same(i,{0.0,1.0,2.0,5.0,17.0,127.0},{false,false,false,false,false,false}),'modf int signs 4')
end
do
 local a=np.array({-127,-17,-2,-1,0,1,2,17,127},np.int16)
 local m,e=np.frexp(a)
 assert(m.dtype=='float32' and e.dtype=='int32','frexp dtype 6')
 assert(list_same(m:tolist(),{-0.9921875,-0.53125,-0.5,-0.5,0.0,0.5,0.5,0.53125,0.9921875},5e-06),'frexp mant 6')
 assert(list_same(e:tolist(),{7,5,2,1,0,1,2,5,7},0),'frexp exp 6')
 assert(zero_sign_same(m,{-0.9921875,-0.53125,-0.5,-0.5,0.0,0.5,0.5,0.53125,0.9921875},{true,true,true,true,false,false,false,false,false}),'frexp signs 6')
 local f,i=np.modf(a)
 assert(f.dtype=='float32' and i.dtype=='float32','modf dtype 6')
 assert(list_same(f:tolist(),{-0.0,-0.0,-0.0,-0.0,0.0,0.0,0.0,0.0,0.0},5e-06),'modf frac 6')
 assert(list_same(i:tolist(),{-127.0,-17.0,-2.0,-1.0,0.0,1.0,2.0,17.0,127.0},5e-06),'modf int 6')
 assert(zero_sign_same(f,{-0.0,-0.0,-0.0,-0.0,0.0,0.0,0.0,0.0,0.0},{true,true,true,true,false,false,false,false,false}),'modf frac signs 6')
 assert(zero_sign_same(i,{-127.0,-17.0,-2.0,-1.0,0.0,1.0,2.0,17.0,127.0},{true,true,true,true,false,false,false,false,false}),'modf int signs 6')
end
do
 local a=np.array({0,1,2,5,17,127},np.uint16)
 local m,e=np.frexp(a)
 assert(m.dtype=='float32' and e.dtype=='int32','frexp dtype 8')
 assert(list_same(m:tolist(),{0.0,0.5,0.5,0.625,0.53125,0.9921875},5e-06),'frexp mant 8')
 assert(list_same(e:tolist(),{0,1,2,3,5,7},0),'frexp exp 8')
 assert(zero_sign_same(m,{0.0,0.5,0.5,0.625,0.53125,0.9921875},{false,false,false,false,false,false}),'frexp signs 8')
 local f,i=np.modf(a)
 assert(f.dtype=='float32' and i.dtype=='float32','modf dtype 8')
 assert(list_same(f:tolist(),{0.0,0.0,0.0,0.0,0.0,0.0},5e-06),'modf frac 8')
 assert(list_same(i:tolist(),{0.0,1.0,2.0,5.0,17.0,127.0},5e-06),'modf int 8')
 assert(zero_sign_same(f,{0.0,0.0,0.0,0.0,0.0,0.0},{false,false,false,false,false,false}),'modf frac signs 8')
 assert(zero_sign_same(i,{0.0,1.0,2.0,5.0,17.0,127.0},{false,false,false,false,false,false}),'modf int signs 8')
end
do
 local a=np.array({-127,-17,-2,-1,0,1,2,17,127},np.int32)
 local m,e=np.frexp(a)
 assert(m.dtype=='float64' and e.dtype=='int32','frexp dtype 10')
 assert(list_same(m:tolist(),{-0.9921875,-0.53125,-0.5,-0.5,0.0,0.5,0.5,0.53125,0.9921875},5e-12),'frexp mant 10')
 assert(list_same(e:tolist(),{7,5,2,1,0,1,2,5,7},0),'frexp exp 10')
 assert(zero_sign_same(m,{-0.9921875,-0.53125,-0.5,-0.5,0.0,0.5,0.5,0.53125,0.9921875},{true,true,true,true,false,false,false,false,false}),'frexp signs 10')
 local f,i=np.modf(a)
 assert(f.dtype=='float64' and i.dtype=='float64','modf dtype 10')
 assert(list_same(f:tolist(),{-0.0,-0.0,-0.0,-0.0,0.0,0.0,0.0,0.0,0.0},5e-12),'modf frac 10')
 assert(list_same(i:tolist(),{-127.0,-17.0,-2.0,-1.0,0.0,1.0,2.0,17.0,127.0},5e-12),'modf int 10')
 assert(zero_sign_same(f,{-0.0,-0.0,-0.0,-0.0,0.0,0.0,0.0,0.0,0.0},{true,true,true,true,false,false,false,false,false}),'modf frac signs 10')
 assert(zero_sign_same(i,{-127.0,-17.0,-2.0,-1.0,0.0,1.0,2.0,17.0,127.0},{true,true,true,true,false,false,false,false,false}),'modf int signs 10')
end
do
 local a=np.array({0,1,2,5,17,127},np.uint32)
 local m,e=np.frexp(a)
 assert(m.dtype=='float64' and e.dtype=='int32','frexp dtype 12')
 assert(list_same(m:tolist(),{0.0,0.5,0.5,0.625,0.53125,0.9921875},5e-12),'frexp mant 12')
 assert(list_same(e:tolist(),{0,1,2,3,5,7},0),'frexp exp 12')
 assert(zero_sign_same(m,{0.0,0.5,0.5,0.625,0.53125,0.9921875},{false,false,false,false,false,false}),'frexp signs 12')
 local f,i=np.modf(a)
 assert(f.dtype=='float64' and i.dtype=='float64','modf dtype 12')
 assert(list_same(f:tolist(),{0.0,0.0,0.0,0.0,0.0,0.0},5e-12),'modf frac 12')
 assert(list_same(i:tolist(),{0.0,1.0,2.0,5.0,17.0,127.0},5e-12),'modf int 12')
 assert(zero_sign_same(f,{0.0,0.0,0.0,0.0,0.0,0.0},{false,false,false,false,false,false}),'modf frac signs 12')
 assert(zero_sign_same(i,{0.0,1.0,2.0,5.0,17.0,127.0},{false,false,false,false,false,false}),'modf int signs 12')
end
do
 local a=np.array({-127,-17,-2,-1,0,1,2,17,127},np.int64)
 local m,e=np.frexp(a)
 assert(m.dtype=='float64' and e.dtype=='int32','frexp dtype 14')
 assert(list_same(m:tolist(),{-0.9921875,-0.53125,-0.5,-0.5,0.0,0.5,0.5,0.53125,0.9921875},5e-12),'frexp mant 14')
 assert(list_same(e:tolist(),{7,5,2,1,0,1,2,5,7},0),'frexp exp 14')
 assert(zero_sign_same(m,{-0.9921875,-0.53125,-0.5,-0.5,0.0,0.5,0.5,0.53125,0.9921875},{true,true,true,true,false,false,false,false,false}),'frexp signs 14')
 local f,i=np.modf(a)
 assert(f.dtype=='float64' and i.dtype=='float64','modf dtype 14')
 assert(list_same(f:tolist(),{-0.0,-0.0,-0.0,-0.0,0.0,0.0,0.0,0.0,0.0},5e-12),'modf frac 14')
 assert(list_same(i:tolist(),{-127.0,-17.0,-2.0,-1.0,0.0,1.0,2.0,17.0,127.0},5e-12),'modf int 14')
 assert(zero_sign_same(f,{-0.0,-0.0,-0.0,-0.0,0.0,0.0,0.0,0.0,0.0},{true,true,true,true,false,false,false,false,false}),'modf frac signs 14')
 assert(zero_sign_same(i,{-127.0,-17.0,-2.0,-1.0,0.0,1.0,2.0,17.0,127.0},{true,true,true,true,false,false,false,false,false}),'modf int signs 14')
end
do
 local a=np.array({0,1,2,5,17,127},np.uint64)
 local m,e=np.frexp(a)
 assert(m.dtype=='float64' and e.dtype=='int32','frexp dtype 16')
 assert(list_same(m:tolist(),{0.0,0.5,0.5,0.625,0.53125,0.9921875},5e-12),'frexp mant 16')
 assert(list_same(e:tolist(),{0,1,2,3,5,7},0),'frexp exp 16')
 assert(zero_sign_same(m,{0.0,0.5,0.5,0.625,0.53125,0.9921875},{false,false,false,false,false,false}),'frexp signs 16')
 local f,i=np.modf(a)
 assert(f.dtype=='float64' and i.dtype=='float64','modf dtype 16')
 assert(list_same(f:tolist(),{0.0,0.0,0.0,0.0,0.0,0.0},5e-12),'modf frac 16')
 assert(list_same(i:tolist(),{0.0,1.0,2.0,5.0,17.0,127.0},5e-12),'modf int 16')
 assert(zero_sign_same(f,{0.0,0.0,0.0,0.0,0.0,0.0},{false,false,false,false,false,false}),'modf frac signs 16')
 assert(zero_sign_same(i,{0.0,1.0,2.0,5.0,17.0,127.0},{false,false,false,false,false,false}),'modf int signs 16')
end
do
 local a=np.array({-math.huge,-8.0,-2.5,-1.0,-0.0,0.0,0.125,0.75,1.0,5.69921875,math.huge,(0/0)},np.float16)
 local m,e=np.frexp(a)
 assert(m.dtype=='float16' and e.dtype=='int32','frexp dtype 18')
 assert(list_same(m:tolist(),{-math.huge,-0.5,-0.625,-0.5,-0.0,0.0,0.5,0.75,0.5,0.71240234375,math.huge,(0/0)},0.004),'frexp mant 18')
 assert(list_same(e:tolist(),{0,4,2,1,0,0,-2,0,1,3,0,0},0),'frexp exp 18')
 assert(zero_sign_same(m,{-math.huge,-0.5,-0.625,-0.5,-0.0,0.0,0.5,0.75,0.5,0.71240234375,math.huge,(0/0)},{true,true,true,true,true,false,false,false,false,false,false,false}),'frexp signs 18')
 local f,i=np.modf(a)
 assert(f.dtype=='float16' and i.dtype=='float16','modf dtype 18')
 assert(list_same(f:tolist(),{-0.0,-0.0,-0.5,-0.0,-0.0,0.0,0.125,0.75,0.0,0.69921875,0.0,(0/0)},0.004),'modf frac 18')
 assert(list_same(i:tolist(),{-math.huge,-8.0,-2.0,-1.0,-0.0,0.0,0.0,0.0,1.0,5.0,math.huge,(0/0)},0.004),'modf int 18')
 assert(zero_sign_same(f,{-0.0,-0.0,-0.5,-0.0,-0.0,0.0,0.125,0.75,0.0,0.69921875,0.0,(0/0)},{true,true,true,true,true,false,false,false,false,false,false,false}),'modf frac signs 18')
 assert(zero_sign_same(i,{-math.huge,-8.0,-2.0,-1.0,-0.0,0.0,0.0,0.0,1.0,5.0,math.huge,(0/0)},{true,true,true,true,true,false,false,false,false,false,false,false}),'modf int signs 18')
end
do
 local a=np.array({-math.huge,-8.0,-2.5,-1.0,-0.0,0.0,0.125,0.75,1.0,5.699999809265137,math.huge,(0/0)},np.float32)
 local m,e=np.frexp(a)
 assert(m.dtype=='float32' and e.dtype=='int32','frexp dtype 20')
 assert(list_same(m:tolist(),{-math.huge,-0.5,-0.625,-0.5,-0.0,0.0,0.5,0.75,0.5,0.7124999761581421,math.huge,(0/0)},5e-06),'frexp mant 20')
 assert(list_same(e:tolist(),{0,4,2,1,0,0,-2,0,1,3,0,0},0),'frexp exp 20')
 assert(zero_sign_same(m,{-math.huge,-0.5,-0.625,-0.5,-0.0,0.0,0.5,0.75,0.5,0.7124999761581421,math.huge,(0/0)},{true,true,true,true,true,false,false,false,false,false,false,false}),'frexp signs 20')
 local f,i=np.modf(a)
 assert(f.dtype=='float32' and i.dtype=='float32','modf dtype 20')
 assert(list_same(f:tolist(),{-0.0,-0.0,-0.5,-0.0,-0.0,0.0,0.125,0.75,0.0,0.6999998092651367,0.0,(0/0)},5e-06),'modf frac 20')
 assert(list_same(i:tolist(),{-math.huge,-8.0,-2.0,-1.0,-0.0,0.0,0.0,0.0,1.0,5.0,math.huge,(0/0)},5e-06),'modf int 20')
 assert(zero_sign_same(f,{-0.0,-0.0,-0.5,-0.0,-0.0,0.0,0.125,0.75,0.0,0.6999998092651367,0.0,(0/0)},{true,true,true,true,true,false,false,false,false,false,false,false}),'modf frac signs 20')
 assert(zero_sign_same(i,{-math.huge,-8.0,-2.0,-1.0,-0.0,0.0,0.0,0.0,1.0,5.0,math.huge,(0/0)},{true,true,true,true,true,false,false,false,false,false,false,false}),'modf int signs 20')
end
do
 local a=np.array({-math.huge,-8.0,-2.5,-1.0,-0.0,0.0,0.125,0.75,1.0,5.7,math.huge,(0/0)},np.float64)
 local m,e=np.frexp(a)
 assert(m.dtype=='float64' and e.dtype=='int32','frexp dtype 22')
 assert(list_same(m:tolist(),{-math.huge,-0.5,-0.625,-0.5,-0.0,0.0,0.5,0.75,0.5,0.7125,math.huge,(0/0)},5e-12),'frexp mant 22')
 assert(list_same(e:tolist(),{0,4,2,1,0,0,-2,0,1,3,0,0},0),'frexp exp 22')
 assert(zero_sign_same(m,{-math.huge,-0.5,-0.625,-0.5,-0.0,0.0,0.5,0.75,0.5,0.7125,math.huge,(0/0)},{true,true,true,true,true,false,false,false,false,false,false,false}),'frexp signs 22')
 local f,i=np.modf(a)
 assert(f.dtype=='float64' and i.dtype=='float64','modf dtype 22')
 assert(list_same(f:tolist(),{-0.0,-0.0,-0.5,-0.0,-0.0,0.0,0.125,0.75,0.0,0.7000000000000002,0.0,(0/0)},5e-12),'modf frac 22')
 assert(list_same(i:tolist(),{-math.huge,-8.0,-2.0,-1.0,-0.0,0.0,0.0,0.0,1.0,5.0,math.huge,(0/0)},5e-12),'modf int 22')
 assert(zero_sign_same(f,{-0.0,-0.0,-0.5,-0.0,-0.0,0.0,0.125,0.75,0.0,0.7000000000000002,0.0,(0/0)},{true,true,true,true,true,false,false,false,false,false,false,false}),'modf frac signs 22')
 assert(zero_sign_same(i,{-math.huge,-8.0,-2.0,-1.0,-0.0,0.0,0.0,0.0,1.0,5.0,math.huge,(0/0)},{true,true,true,true,true,false,false,false,false,false,false,false}),'modf int signs 22')
end
do
 local a=np.array({-math.huge,-8.0,-2.5,-1.0,-0.0,0.0,0.125,0.75,1.0,5.7,math.huge,(0/0)},np.longdouble)
 local m,e=np.frexp(a)
 assert(m.dtype=='longdouble' and e.dtype=='int32','frexp dtype 24')
 assert(list_same(m:tolist(),{-math.huge,-0.5,-0.625,-0.5,-0.0,0.0,0.5,0.75,0.5,0.7125,math.huge,(0/0)},5e-12),'frexp mant 24')
 assert(list_same(e:tolist(),{0,4,2,1,0,0,-2,0,1,3,0,0},0),'frexp exp 24')
 assert(zero_sign_same(m,{-math.huge,-0.5,-0.625,-0.5,-0.0,0.0,0.5,0.75,0.5,0.7125,math.huge,(0/0)},{true,true,true,true,true,false,false,false,false,false,false,false}),'frexp signs 24')
 local f,i=np.modf(a)
 assert(f.dtype=='longdouble' and i.dtype=='longdouble','modf dtype 24')
 assert(list_same(f:tolist(),{-0.0,-0.0,-0.5,-0.0,-0.0,0.0,0.125,0.75,0.0,0.7000000000000002,0.0,(0/0)},5e-12),'modf frac 24')
 assert(list_same(i:tolist(),{-math.huge,-8.0,-2.0,-1.0,-0.0,0.0,0.0,0.0,1.0,5.0,math.huge,(0/0)},5e-12),'modf int 24')
 assert(zero_sign_same(f,{-0.0,-0.0,-0.5,-0.0,-0.0,0.0,0.125,0.75,0.0,0.7000000000000002,0.0,(0/0)},{true,true,true,true,true,false,false,false,false,false,false,false}),'modf frac signs 24')
 assert(zero_sign_same(i,{-math.huge,-8.0,-2.0,-1.0,-0.0,0.0,0.0,0.0,1.0,5.0,math.huge,(0/0)},{true,true,true,true,true,false,false,false,false,false,false,false}),'modf int signs 24')
end
do
 local a=np.array({true,true,true,false,false,true,true},np.bool)
 local b=np.array({true,true,true,true,true,true,true},np.bool)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int8' and r.dtype=='int8','divmod dtype 26')
 assert(list_same(q:tolist(),{1,1,1,0,0,1,1},0),'divmod q 26')
 assert(list_same(r:tolist(),{0,0,0,0,0,0,0},0),'divmod r 26')
 assert(zero_sign_same(q,{1,1,1,0,0,1,1},{false,false,false,false,false,false,false}),'divmod q signs 26')
 assert(zero_sign_same(r,{0,0,0,0,0,0,0},{false,false,false,false,false,false,false}),'divmod r signs 26')
end
do
 local a=np.array({true,true,false,true,true,false,true},np.bool)
 local b=np.array({-7,2,-7,2,-1,-2,2},np.int8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int8' and r.dtype=='int8','divmod dtype 27')
 assert(list_same(q:tolist(),{-1,0,0,0,-1,0,0},0),'divmod q 27')
 assert(list_same(r:tolist(),{-6,1,0,1,0,0,1},0),'divmod r 27')
 assert(zero_sign_same(q,{-1,0,0,0,-1,0,0},{true,false,false,false,true,false,false}),'divmod q signs 27')
 assert(zero_sign_same(r,{-6,1,0,1,0,0,1},{true,false,false,false,false,false,false}),'divmod r signs 27')
end
do
 local a=np.array({true,true,true,true,true,true,false},np.bool)
 local b=np.array({1,7,7,1,7,7,1},np.uint8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint8' and r.dtype=='uint8','divmod dtype 28')
 assert(list_same(q:tolist(),{1,0,0,1,0,0,0},0),'divmod q 28')
 assert(list_same(r:tolist(),{0,1,1,0,1,1,0},0),'divmod r 28')
 assert(zero_sign_same(q,{1,0,0,1,0,0,0},{false,false,false,false,false,false,false}),'divmod q signs 28')
 assert(zero_sign_same(r,{0,1,1,0,1,1,0},{false,false,false,false,false,false,false}),'divmod r signs 28')
end
do
 local a=np.array({true,true,true,true,false,true,true},np.bool)
 local b=np.array({-1,7,7,-1,1,1,-1},np.int16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int16' and r.dtype=='int16','divmod dtype 29')
 assert(list_same(q:tolist(),{-1,0,0,-1,0,1,-1},0),'divmod q 29')
 assert(list_same(r:tolist(),{0,1,1,0,0,0,0},0),'divmod r 29')
 assert(zero_sign_same(q,{-1,0,0,-1,0,1,-1},{true,false,false,true,false,false,true}),'divmod q signs 29')
 assert(zero_sign_same(r,{0,1,1,0,0,0,0},{false,false,false,false,false,false,false}),'divmod r signs 29')
end
do
 local a=np.array({true,true,true,true,false,true,true},np.bool)
 local b=np.array({2,2,7,1,2,7,7},np.uint16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint16' and r.dtype=='uint16','divmod dtype 30')
 assert(list_same(q:tolist(),{0,0,0,1,0,0,0},0),'divmod q 30')
 assert(list_same(r:tolist(),{1,1,1,0,0,1,1},0),'divmod r 30')
 assert(zero_sign_same(q,{0,0,0,1,0,0,0},{false,false,false,false,false,false,false}),'divmod q signs 30')
 assert(zero_sign_same(r,{1,1,1,0,0,1,1},{false,false,false,false,false,false,false}),'divmod r signs 30')
end
do
 local a=np.array({true,true,true,true,true,false,true},np.bool)
 local b=np.array({-1,-7,2,2,-2,7,-2},np.int32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int32' and r.dtype=='int32','divmod dtype 31')
 assert(list_same(q:tolist(),{-1,-1,0,0,-1,0,-1},0),'divmod q 31')
 assert(list_same(r:tolist(),{0,-6,1,1,-1,0,-1},0),'divmod r 31')
 assert(zero_sign_same(q,{-1,-1,0,0,-1,0,-1},{true,true,false,false,true,false,true}),'divmod q signs 31')
 assert(zero_sign_same(r,{0,-6,1,1,-1,0,-1},{false,true,false,false,true,false,true}),'divmod r signs 31')
end
do
 local a=np.array({true,true,false,false,true,true,true},np.bool)
 local b=np.array({1,1,2,1,1,1,7},np.uint32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint32' and r.dtype=='uint32','divmod dtype 32')
 assert(list_same(q:tolist(),{1,1,0,0,1,1,0},0),'divmod q 32')
 assert(list_same(r:tolist(),{0,0,0,0,0,0,1},0),'divmod r 32')
 assert(zero_sign_same(q,{1,1,0,0,1,1,0},{false,false,false,false,false,false,false}),'divmod q signs 32')
 assert(zero_sign_same(r,{0,0,0,0,0,0,1},{false,false,false,false,false,false,false}),'divmod r signs 32')
end
do
 local a=np.array({false,false,true,true,false,true,true},np.bool)
 local b=np.array({-2,-7,1,1,-2,7,2},np.int64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int64' and r.dtype=='int64','divmod dtype 33')
 assert(list_same(q:tolist(),{0,0,1,1,0,0,0},0),'divmod q 33')
 assert(list_same(r:tolist(),{0,0,0,0,0,1,1},0),'divmod r 33')
 assert(zero_sign_same(q,{0,0,1,1,0,0,0},{false,false,false,false,false,false,false}),'divmod q signs 33')
 assert(zero_sign_same(r,{0,0,0,0,0,1,1},{false,false,false,false,false,false,false}),'divmod r signs 33')
end
do
 local a=np.array({true,true,true,true,false,true,true},np.bool)
 local b=np.array({1,1,2,2,7,2,1},np.uint64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint64' and r.dtype=='uint64','divmod dtype 34')
 assert(list_same(q:tolist(),{1,1,0,0,0,0,1},0),'divmod q 34')
 assert(list_same(r:tolist(),{0,0,1,1,0,1,0},0),'divmod r 34')
 assert(zero_sign_same(q,{1,1,0,0,0,0,1},{false,false,false,false,false,false,false}),'divmod q signs 34')
 assert(zero_sign_same(r,{0,0,1,1,0,1,0},{false,false,false,false,false,false,false}),'divmod r signs 34')
end
do
 local a=np.array({true,true,false,true,true,true,true},np.bool)
 local b=np.array({-7.0,2.0,7.0,2.0,7.0,7.0,-1.0},np.float16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float16' and r.dtype=='float16','divmod dtype 35')
 assert(list_same(q:tolist(),{-1.0,0.0,0.0,0.0,0.0,0.0,-1.0},0.004),'divmod q 35')
 assert(list_same(r:tolist(),{-6.0,1.0,0.0,1.0,1.0,1.0,-0.0},0.004),'divmod r 35')
 assert(zero_sign_same(q,{-1.0,0.0,0.0,0.0,0.0,0.0,-1.0},{true,false,false,false,false,false,true}),'divmod q signs 35')
 assert(zero_sign_same(r,{-6.0,1.0,0.0,1.0,1.0,1.0,-0.0},{true,false,false,false,false,false,true}),'divmod r signs 35')
end
do
 local a=np.array({true,true,true,false,true,true,true},np.bool)
 local b=np.array({-2.0,1.0,-7.0,-1.0,-2.0,-2.0,-1.0},np.float32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float32' and r.dtype=='float32','divmod dtype 36')
 assert(list_same(q:tolist(),{-1.0,1.0,-1.0,-0.0,-1.0,-1.0,-1.0},5e-06),'divmod q 36')
 assert(list_same(r:tolist(),{-1.0,0.0,-6.0,-0.0,-1.0,-1.0,-0.0},5e-06),'divmod r 36')
 assert(zero_sign_same(q,{-1.0,1.0,-1.0,-0.0,-1.0,-1.0,-1.0},{true,false,true,true,true,true,true}),'divmod q signs 36')
 assert(zero_sign_same(r,{-1.0,0.0,-6.0,-0.0,-1.0,-1.0,-0.0},{true,false,true,true,true,true,true}),'divmod r signs 36')
end
do
 local a=np.array({true,true,true,false,true,true,true},np.bool)
 local b=np.array({7.0,7.0,7.0,1.0,7.0,-7.0,-1.0},np.float64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 37')
 assert(list_same(q:tolist(),{0.0,0.0,0.0,0.0,0.0,-1.0,-1.0},5e-12),'divmod q 37')
 assert(list_same(r:tolist(),{1.0,1.0,1.0,0.0,1.0,-6.0,-0.0},5e-12),'divmod r 37')
 assert(zero_sign_same(q,{0.0,0.0,0.0,0.0,0.0,-1.0,-1.0},{false,false,false,false,false,true,true}),'divmod q signs 37')
 assert(zero_sign_same(r,{1.0,1.0,1.0,0.0,1.0,-6.0,-0.0},{false,false,false,false,false,true,true}),'divmod r signs 37')
end
do
 local a=np.array({true,true,true,true,true,true,true},np.bool)
 local b=np.array({1.0,7.0,-1.0,7.0,-1.0,-1.0,2.0},np.longdouble)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 38')
 assert(list_same(q:tolist(),{1.0,0.0,-1.0,0.0,-1.0,-1.0,0.0},5e-12),'divmod q 38')
 assert(list_same(r:tolist(),{0.0,1.0,-0.0,1.0,-0.0,-0.0,1.0},5e-12),'divmod r 38')
 assert(zero_sign_same(q,{1.0,0.0,-1.0,0.0,-1.0,-1.0,0.0},{false,false,true,false,true,true,false}),'divmod q signs 38')
 assert(zero_sign_same(r,{0.0,1.0,-0.0,1.0,-0.0,-0.0,1.0},{false,false,true,false,true,true,false}),'divmod r signs 38')
end
do
 local a=np.array({17,-17,-17,-17,-5,0,0},np.int8)
 local b=np.array({true,true,true,true,true,true,true},np.bool)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int8' and r.dtype=='int8','divmod dtype 39')
 assert(list_same(q:tolist(),{17,-17,-17,-17,-5,0,0},0),'divmod q 39')
 assert(list_same(r:tolist(),{0,0,0,0,0,0,0},0),'divmod r 39')
 assert(zero_sign_same(q,{17,-17,-17,-17,-5,0,0},{false,true,true,true,true,false,false}),'divmod q signs 39')
 assert(zero_sign_same(r,{0,0,0,0,0,0,0},{false,false,false,false,false,false,false}),'divmod r signs 39')
end
do
 local a=np.array({1,-17,0,17,-17,-1,-1},np.int8)
 local b=np.array({7,1,7,1,-7,1,1},np.int8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int8' and r.dtype=='int8','divmod dtype 40')
 assert(list_same(q:tolist(),{0,-17,0,17,2,-1,-1},0),'divmod q 40')
 assert(list_same(r:tolist(),{1,0,0,0,-3,0,0},0),'divmod r 40')
 assert(zero_sign_same(q,{0,-17,0,17,2,-1,-1},{false,true,false,false,false,true,true}),'divmod q signs 40')
 assert(zero_sign_same(r,{1,0,0,0,-3,0,0},{false,false,false,false,true,false,false}),'divmod r signs 40')
end
do
 local a=np.array({0,17,17,-5,17,5,5},np.int8)
 local b=np.array({1,2,7,7,2,1,1},np.uint8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int16' and r.dtype=='int16','divmod dtype 41')
 assert(list_same(q:tolist(),{0,8,2,-1,8,5,5},0),'divmod q 41')
 assert(list_same(r:tolist(),{0,1,3,2,1,0,0},0),'divmod r 41')
 assert(zero_sign_same(q,{0,8,2,-1,8,5,5},{false,false,false,true,false,false,false}),'divmod q signs 41')
 assert(zero_sign_same(r,{0,1,3,2,1,0,0},{false,false,false,false,false,false,false}),'divmod r signs 41')
end
do
 local a=np.array({0,-5,-5,1,5,5,0},np.int8)
 local b=np.array({1,-1,-7,1,1,1,-2},np.int16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int16' and r.dtype=='int16','divmod dtype 42')
 assert(list_same(q:tolist(),{0,5,0,1,5,5,0},0),'divmod q 42')
 assert(list_same(r:tolist(),{0,0,-5,0,0,0,0},0),'divmod r 42')
 assert(zero_sign_same(q,{0,5,0,1,5,5,0},{false,false,false,false,false,false,false}),'divmod q signs 42')
 assert(zero_sign_same(r,{0,0,-5,0,0,0,0},{false,false,true,false,false,false,false}),'divmod r signs 42')
end
do
 local a=np.array({1,17,1,1,1,17,-1},np.int8)
 local b=np.array({2,1,1,7,1,1,2},np.uint16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int32' and r.dtype=='int32','divmod dtype 43')
 assert(list_same(q:tolist(),{0,17,1,0,1,17,-1},0),'divmod q 43')
 assert(list_same(r:tolist(),{1,0,0,1,0,0,1},0),'divmod r 43')
 assert(zero_sign_same(q,{0,17,1,0,1,17,-1},{false,false,false,false,false,false,true}),'divmod q signs 43')
 assert(zero_sign_same(r,{1,0,0,1,0,0,1},{false,false,false,false,false,false,false}),'divmod r signs 43')
end
do
 local a=np.array({1,5,-1,17,0,0,5},np.int8)
 local b=np.array({-2,-2,-2,-1,2,2,-7},np.int32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int32' and r.dtype=='int32','divmod dtype 44')
 assert(list_same(q:tolist(),{-1,-3,0,-17,0,0,-1},0),'divmod q 44')
 assert(list_same(r:tolist(),{-1,-1,-1,0,0,0,-2},0),'divmod r 44')
 assert(zero_sign_same(q,{-1,-3,0,-17,0,0,-1},{true,true,false,true,false,false,true}),'divmod q signs 44')
 assert(zero_sign_same(r,{-1,-1,-1,0,0,0,-2},{true,true,true,false,false,false,true}),'divmod r signs 44')
end
do
 local a=np.array({-17,17,-1,17,0,0,0},np.int8)
 local b=np.array({1,1,1,2,7,2,7},np.uint32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int64' and r.dtype=='int64','divmod dtype 45')
 assert(list_same(q:tolist(),{-17,17,-1,8,0,0,0},0),'divmod q 45')
 assert(list_same(r:tolist(),{0,0,0,1,0,0,0},0),'divmod r 45')
 assert(zero_sign_same(q,{-17,17,-1,8,0,0,0},{true,false,true,false,false,false,false}),'divmod q signs 45')
 assert(zero_sign_same(r,{0,0,0,1,0,0,0},{false,false,false,false,false,false,false}),'divmod r signs 45')
end
do
 local a=np.array({-5,-1,0,-5,5,-1,-5},np.int8)
 local b=np.array({2,-2,-2,-2,2,-1,-7},np.int64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int64' and r.dtype=='int64','divmod dtype 46')
 assert(list_same(q:tolist(),{-3,0,0,2,2,1,0},0),'divmod q 46')
 assert(list_same(r:tolist(),{1,-1,0,-1,1,0,-5},0),'divmod r 46')
 assert(zero_sign_same(q,{-3,0,0,2,2,1,0},{true,false,false,false,false,false,false}),'divmod q signs 46')
 assert(zero_sign_same(r,{1,-1,0,-1,1,0,-5},{false,true,false,true,false,false,true}),'divmod r signs 46')
end
do
 local a=np.array({5,-5,-1,0,1,1,1},np.int8)
 local b=np.array({1,7,7,2,7,2,2},np.uint64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 47')
 assert(list_same(q:tolist(),{5.0,-1.0,-1.0,0.0,0.0,0.0,0.0},5e-12),'divmod q 47')
 assert(list_same(r:tolist(),{0.0,2.0,6.0,0.0,1.0,1.0,1.0},5e-12),'divmod r 47')
 assert(zero_sign_same(q,{5.0,-1.0,-1.0,0.0,0.0,0.0,0.0},{false,true,true,false,false,false,false}),'divmod q signs 47')
 assert(zero_sign_same(r,{0.0,2.0,6.0,0.0,1.0,1.0,1.0},{false,false,false,false,false,false,false}),'divmod r signs 47')
end
do
 local a=np.array({-1,-5,5,-5,-17,1,-1},np.int8)
 local b=np.array({7.0,-7.0,7.0,1.0,-7.0,-2.0,-1.0},np.float16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float16' and r.dtype=='float16','divmod dtype 48')
 assert(list_same(q:tolist(),{-1.0,0.0,0.0,-5.0,2.0,-1.0,1.0},0.004),'divmod q 48')
 assert(list_same(r:tolist(),{6.0,-5.0,5.0,0.0,-3.0,-1.0,-0.0},0.004),'divmod r 48')
 assert(zero_sign_same(q,{-1.0,0.0,0.0,-5.0,2.0,-1.0,1.0},{true,false,false,true,false,true,false}),'divmod q signs 48')
 assert(zero_sign_same(r,{6.0,-5.0,5.0,0.0,-3.0,-1.0,-0.0},{false,true,false,false,true,true,true}),'divmod r signs 48')
end
do
 local a=np.array({-1,1,-1,17,-1,-1,-5},np.int8)
 local b=np.array({2.0,-2.0,7.0,-1.0,7.0,1.0,2.0},np.float32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float32' and r.dtype=='float32','divmod dtype 49')
 assert(list_same(q:tolist(),{-1.0,-1.0,-1.0,-17.0,-1.0,-1.0,-3.0},5e-06),'divmod q 49')
 assert(list_same(r:tolist(),{1.0,-1.0,6.0,-0.0,6.0,0.0,1.0},5e-06),'divmod r 49')
 assert(zero_sign_same(q,{-1.0,-1.0,-1.0,-17.0,-1.0,-1.0,-3.0},{true,true,true,true,true,true,true}),'divmod q signs 49')
 assert(zero_sign_same(r,{1.0,-1.0,6.0,-0.0,6.0,0.0,1.0},{false,true,false,true,false,false,false}),'divmod r signs 49')
end
do
 local a=np.array({17,0,1,17,-17,1,17},np.int8)
 local b=np.array({2.0,1.0,2.0,2.0,1.0,1.0,-7.0},np.float64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 50')
 assert(list_same(q:tolist(),{8.0,0.0,0.0,8.0,-17.0,1.0,-3.0},5e-12),'divmod q 50')
 assert(list_same(r:tolist(),{1.0,0.0,1.0,1.0,0.0,0.0,-4.0},5e-12),'divmod r 50')
 assert(zero_sign_same(q,{8.0,0.0,0.0,8.0,-17.0,1.0,-3.0},{false,false,false,false,true,false,true}),'divmod q signs 50')
 assert(zero_sign_same(r,{1.0,0.0,1.0,1.0,0.0,0.0,-4.0},{false,false,false,false,false,false,true}),'divmod r signs 50')
end
do
 local a=np.array({-5,1,-5,-1,-17,5,0},np.int8)
 local b=np.array({-1.0,-2.0,-7.0,1.0,7.0,-2.0,2.0},np.longdouble)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 51')
 assert(list_same(q:tolist(),{5.0,-1.0,0.0,-1.0,-3.0,-3.0,0.0},5e-12),'divmod q 51')
 assert(list_same(r:tolist(),{-0.0,-1.0,-5.0,0.0,4.0,-1.0,0.0},5e-12),'divmod r 51')
 assert(zero_sign_same(q,{5.0,-1.0,0.0,-1.0,-3.0,-3.0,0.0},{false,true,false,true,true,true,false}),'divmod q signs 51')
 assert(zero_sign_same(r,{-0.0,-1.0,-5.0,0.0,4.0,-1.0,0.0},{true,true,true,false,false,true,false}),'divmod r signs 51')
end
do
 local a=np.array({5,17,5,5,5,1,0},np.uint8)
 local b=np.array({true,true,true,true,true,true,true},np.bool)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint8' and r.dtype=='uint8','divmod dtype 52')
 assert(list_same(q:tolist(),{5,17,5,5,5,1,0},0),'divmod q 52')
 assert(list_same(r:tolist(),{0,0,0,0,0,0,0},0),'divmod r 52')
 assert(zero_sign_same(q,{5,17,5,5,5,1,0},{false,false,false,false,false,false,false}),'divmod q signs 52')
 assert(zero_sign_same(r,{0,0,0,0,0,0,0},{false,false,false,false,false,false,false}),'divmod r signs 52')
end
do
 local a=np.array({1,17,0,5,5,0,1},np.uint8)
 local b=np.array({-2,2,7,1,-2,-7,1},np.int8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int16' and r.dtype=='int16','divmod dtype 53')
 assert(list_same(q:tolist(),{-1,8,0,5,-3,0,1},0),'divmod q 53')
 assert(list_same(r:tolist(),{-1,1,0,0,-1,0,0},0),'divmod r 53')
 assert(zero_sign_same(q,{-1,8,0,5,-3,0,1},{true,false,false,false,true,false,false}),'divmod q signs 53')
 assert(zero_sign_same(r,{-1,1,0,0,-1,0,0},{true,false,false,false,true,false,false}),'divmod r signs 53')
end
do
 local a=np.array({17,0,1,0,0,5,1},np.uint8)
 local b=np.array({1,1,1,1,1,2,7},np.uint8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint8' and r.dtype=='uint8','divmod dtype 54')
 assert(list_same(q:tolist(),{17,0,1,0,0,2,0},0),'divmod q 54')
 assert(list_same(r:tolist(),{0,0,0,0,0,1,1},0),'divmod r 54')
 assert(zero_sign_same(q,{17,0,1,0,0,2,0},{false,false,false,false,false,false,false}),'divmod q signs 54')
 assert(zero_sign_same(r,{0,0,0,0,0,1,1},{false,false,false,false,false,false,false}),'divmod r signs 54')
end
do
 local a=np.array({17,0,1,0,0,17,1},np.uint8)
 local b=np.array({-2,-2,-2,2,1,2,-7},np.int16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int16' and r.dtype=='int16','divmod dtype 55')
 assert(list_same(q:tolist(),{-9,0,-1,0,0,8,-1},0),'divmod q 55')
 assert(list_same(r:tolist(),{-1,0,-1,0,0,1,-6},0),'divmod r 55')
 assert(zero_sign_same(q,{-9,0,-1,0,0,8,-1},{true,false,true,false,false,false,true}),'divmod q signs 55')
 assert(zero_sign_same(r,{-1,0,-1,0,0,1,-6},{true,false,true,false,false,false,true}),'divmod r signs 55')
end
do
 local a=np.array({17,5,1,5,0,17,1},np.uint8)
 local b=np.array({7,1,1,2,1,2,1},np.uint16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint16' and r.dtype=='uint16','divmod dtype 56')
 assert(list_same(q:tolist(),{2,5,1,2,0,8,1},0),'divmod q 56')
 assert(list_same(r:tolist(),{3,0,0,1,0,1,0},0),'divmod r 56')
 assert(zero_sign_same(q,{2,5,1,2,0,8,1},{false,false,false,false,false,false,false}),'divmod q signs 56')
 assert(zero_sign_same(r,{3,0,0,1,0,1,0},{false,false,false,false,false,false,false}),'divmod r signs 56')
end
do
 local a=np.array({0,5,1,0,5,1,1},np.uint8)
 local b=np.array({2,2,-7,7,1,-7,1},np.int32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int32' and r.dtype=='int32','divmod dtype 57')
 assert(list_same(q:tolist(),{0,2,-1,0,5,-1,1},0),'divmod q 57')
 assert(list_same(r:tolist(),{0,1,-6,0,0,-6,0},0),'divmod r 57')
 assert(zero_sign_same(q,{0,2,-1,0,5,-1,1},{false,false,true,false,false,true,false}),'divmod q signs 57')
 assert(zero_sign_same(r,{0,1,-6,0,0,-6,0},{false,false,true,false,false,true,false}),'divmod r signs 57')
end
do
 local a=np.array({5,0,5,5,1,17,1},np.uint8)
 local b=np.array({1,1,1,1,2,1,1},np.uint32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint32' and r.dtype=='uint32','divmod dtype 58')
 assert(list_same(q:tolist(),{5,0,5,5,0,17,1},0),'divmod q 58')
 assert(list_same(r:tolist(),{0,0,0,0,1,0,0},0),'divmod r 58')
 assert(zero_sign_same(q,{5,0,5,5,0,17,1},{false,false,false,false,false,false,false}),'divmod q signs 58')
 assert(zero_sign_same(r,{0,0,0,0,1,0,0},{false,false,false,false,false,false,false}),'divmod r signs 58')
end
do
 local a=np.array({1,5,17,1,17,17,0},np.uint8)
 local b=np.array({-7,-1,2,-2,-2,-2,-1},np.int64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int64' and r.dtype=='int64','divmod dtype 59')
 assert(list_same(q:tolist(),{-1,-5,8,-1,-9,-9,0},0),'divmod q 59')
 assert(list_same(r:tolist(),{-6,0,1,-1,-1,-1,0},0),'divmod r 59')
 assert(zero_sign_same(q,{-1,-5,8,-1,-9,-9,0},{true,true,false,true,true,true,false}),'divmod q signs 59')
 assert(zero_sign_same(r,{-6,0,1,-1,-1,-1,0},{true,false,false,true,true,true,false}),'divmod r signs 59')
end
do
 local a=np.array({5,1,1,1,1,0,1},np.uint8)
 local b=np.array({1,7,2,7,2,1,2},np.uint64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint64' and r.dtype=='uint64','divmod dtype 60')
 assert(list_same(q:tolist(),{5,0,0,0,0,0,0},0),'divmod q 60')
 assert(list_same(r:tolist(),{0,1,1,1,1,0,1},0),'divmod r 60')
 assert(zero_sign_same(q,{5,0,0,0,0,0,0},{false,false,false,false,false,false,false}),'divmod q signs 60')
 assert(zero_sign_same(r,{0,1,1,1,1,0,1},{false,false,false,false,false,false,false}),'divmod r signs 60')
end
do
 local a=np.array({0,1,0,17,1,1,17},np.uint8)
 local b=np.array({1.0,1.0,7.0,1.0,-7.0,2.0,2.0},np.float16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float16' and r.dtype=='float16','divmod dtype 61')
 assert(list_same(q:tolist(),{0.0,1.0,0.0,17.0,-1.0,0.0,8.0},0.004),'divmod q 61')
 assert(list_same(r:tolist(),{0.0,0.0,0.0,0.0,-6.0,1.0,1.0},0.004),'divmod r 61')
 assert(zero_sign_same(q,{0.0,1.0,0.0,17.0,-1.0,0.0,8.0},{false,false,false,false,true,false,false}),'divmod q signs 61')
 assert(zero_sign_same(r,{0.0,0.0,0.0,0.0,-6.0,1.0,1.0},{false,false,false,false,true,false,false}),'divmod r signs 61')
end
do
 local a=np.array({17,17,5,5,17,0,5},np.uint8)
 local b=np.array({1.0,7.0,-2.0,7.0,1.0,2.0,-7.0},np.float32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float32' and r.dtype=='float32','divmod dtype 62')
 assert(list_same(q:tolist(),{17.0,2.0,-3.0,0.0,17.0,0.0,-1.0},5e-06),'divmod q 62')
 assert(list_same(r:tolist(),{0.0,3.0,-1.0,5.0,0.0,0.0,-2.0},5e-06),'divmod r 62')
 assert(zero_sign_same(q,{17.0,2.0,-3.0,0.0,17.0,0.0,-1.0},{false,false,true,false,false,false,true}),'divmod q signs 62')
 assert(zero_sign_same(r,{0.0,3.0,-1.0,5.0,0.0,0.0,-2.0},{false,false,true,false,false,false,true}),'divmod r signs 62')
end
do
 local a=np.array({5,5,5,1,5,0,0},np.uint8)
 local b=np.array({-1.0,-7.0,1.0,-1.0,-1.0,7.0,-2.0},np.float64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 63')
 assert(list_same(q:tolist(),{-5.0,-1.0,5.0,-1.0,-5.0,0.0,-0.0},5e-12),'divmod q 63')
 assert(list_same(r:tolist(),{-0.0,-2.0,0.0,-0.0,-0.0,0.0,-0.0},5e-12),'divmod r 63')
 assert(zero_sign_same(q,{-5.0,-1.0,5.0,-1.0,-5.0,0.0,-0.0},{true,true,false,true,true,false,true}),'divmod q signs 63')
 assert(zero_sign_same(r,{-0.0,-2.0,0.0,-0.0,-0.0,0.0,-0.0},{true,true,false,true,true,false,true}),'divmod r signs 63')
end
do
 local a=np.array({5,1,1,17,1,5,0},np.uint8)
 local b=np.array({-2.0,-2.0,-7.0,-7.0,-1.0,1.0,2.0},np.longdouble)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 64')
 assert(list_same(q:tolist(),{-3.0,-1.0,-1.0,-3.0,-1.0,5.0,0.0},5e-12),'divmod q 64')
 assert(list_same(r:tolist(),{-1.0,-1.0,-6.0,-4.0,-0.0,0.0,0.0},5e-12),'divmod r 64')
 assert(zero_sign_same(q,{-3.0,-1.0,-1.0,-3.0,-1.0,5.0,0.0},{true,true,true,true,true,false,false}),'divmod q signs 64')
 assert(zero_sign_same(r,{-1.0,-1.0,-6.0,-4.0,-0.0,0.0,0.0},{true,true,true,true,true,false,false}),'divmod r signs 64')
end
do
 local a=np.array({0,0,17,5,0,-17,0},np.int16)
 local b=np.array({true,true,true,true,true,true,true},np.bool)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int16' and r.dtype=='int16','divmod dtype 65')
 assert(list_same(q:tolist(),{0,0,17,5,0,-17,0},0),'divmod q 65')
 assert(list_same(r:tolist(),{0,0,0,0,0,0,0},0),'divmod r 65')
 assert(zero_sign_same(q,{0,0,17,5,0,-17,0},{false,false,false,false,false,true,false}),'divmod q signs 65')
 assert(zero_sign_same(r,{0,0,0,0,0,0,0},{false,false,false,false,false,false,false}),'divmod r signs 65')
end
do
 local a=np.array({-17,17,-5,-17,17,-5,-5},np.int16)
 local b=np.array({2,-1,-1,-2,1,7,-7},np.int8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int16' and r.dtype=='int16','divmod dtype 66')
 assert(list_same(q:tolist(),{-9,-17,5,8,17,-1,0},0),'divmod q 66')
 assert(list_same(r:tolist(),{1,0,0,-1,0,2,-5},0),'divmod r 66')
 assert(zero_sign_same(q,{-9,-17,5,8,17,-1,0},{true,true,false,false,false,true,false}),'divmod q signs 66')
 assert(zero_sign_same(r,{1,0,0,-1,0,2,-5},{false,false,false,true,false,false,true}),'divmod r signs 66')
end
do
 local a=np.array({1,-17,0,-1,-1,5,-1},np.int16)
 local b=np.array({1,2,2,1,2,2,1},np.uint8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int16' and r.dtype=='int16','divmod dtype 67')
 assert(list_same(q:tolist(),{1,-9,0,-1,-1,2,-1},0),'divmod q 67')
 assert(list_same(r:tolist(),{0,1,0,0,1,1,0},0),'divmod r 67')
 assert(zero_sign_same(q,{1,-9,0,-1,-1,2,-1},{false,true,false,true,true,false,true}),'divmod q signs 67')
 assert(zero_sign_same(r,{0,1,0,0,1,1,0},{false,false,false,false,false,false,false}),'divmod r signs 67')
end
do
 local a=np.array({1,0,-5,0,17,-17,1},np.int16)
 local b=np.array({-7,-2,-7,2,-1,-2,7},np.int16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int16' and r.dtype=='int16','divmod dtype 68')
 assert(list_same(q:tolist(),{-1,0,0,0,-17,8,0},0),'divmod q 68')
 assert(list_same(r:tolist(),{-6,0,-5,0,0,-1,1},0),'divmod r 68')
 assert(zero_sign_same(q,{-1,0,0,0,-17,8,0},{true,false,false,false,true,false,false}),'divmod q signs 68')
 assert(zero_sign_same(r,{-6,0,-5,0,0,-1,1},{true,false,true,false,false,true,false}),'divmod r signs 68')
end
do
 local a=np.array({5,17,5,-1,17,17,-17},np.int16)
 local b=np.array({2,7,1,1,7,7,2},np.uint16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int32' and r.dtype=='int32','divmod dtype 69')
 assert(list_same(q:tolist(),{2,2,5,-1,2,2,-9},0),'divmod q 69')
 assert(list_same(r:tolist(),{1,3,0,0,3,3,1},0),'divmod r 69')
 assert(zero_sign_same(q,{2,2,5,-1,2,2,-9},{false,false,false,true,false,false,true}),'divmod q signs 69')
 assert(zero_sign_same(r,{1,3,0,0,3,3,1},{false,false,false,false,false,false,false}),'divmod r signs 69')
end
do
 local a=np.array({1,-5,0,-1,-17,1,17},np.int16)
 local b=np.array({-1,1,-2,-2,2,-2,1},np.int32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int32' and r.dtype=='int32','divmod dtype 70')
 assert(list_same(q:tolist(),{-1,-5,0,0,-9,-1,17},0),'divmod q 70')
 assert(list_same(r:tolist(),{0,0,0,-1,1,-1,0},0),'divmod r 70')
 assert(zero_sign_same(q,{-1,-5,0,0,-9,-1,17},{true,true,false,false,true,true,false}),'divmod q signs 70')
 assert(zero_sign_same(r,{0,0,0,-1,1,-1,0},{false,false,false,true,false,true,false}),'divmod r signs 70')
end
do
 local a=np.array({0,-5,5,-5,1,1,-1},np.int16)
 local b=np.array({1,2,2,7,1,7,7},np.uint32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int64' and r.dtype=='int64','divmod dtype 71')
 assert(list_same(q:tolist(),{0,-3,2,-1,1,0,-1},0),'divmod q 71')
 assert(list_same(r:tolist(),{0,1,1,2,0,1,6},0),'divmod r 71')
 assert(zero_sign_same(q,{0,-3,2,-1,1,0,-1},{false,true,false,true,false,false,true}),'divmod q signs 71')
 assert(zero_sign_same(r,{0,1,1,2,0,1,6},{false,false,false,false,false,false,false}),'divmod r signs 71')
end
do
 local a=np.array({5,-17,-17,17,17,5,-1},np.int16)
 local b=np.array({-2,1,-7,-2,7,-1,-2},np.int64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int64' and r.dtype=='int64','divmod dtype 72')
 assert(list_same(q:tolist(),{-3,-17,2,-9,2,-5,0},0),'divmod q 72')
 assert(list_same(r:tolist(),{-1,0,-3,-1,3,0,-1},0),'divmod r 72')
 assert(zero_sign_same(q,{-3,-17,2,-9,2,-5,0},{true,true,false,true,false,true,false}),'divmod q signs 72')
 assert(zero_sign_same(r,{-1,0,-3,-1,3,0,-1},{true,false,true,true,false,false,true}),'divmod r signs 72')
end
do
 local a=np.array({5,-17,0,5,-17,5,-17},np.int16)
 local b=np.array({2,7,2,1,1,1,1},np.uint64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 73')
 assert(list_same(q:tolist(),{2.0,-3.0,0.0,5.0,-17.0,5.0,-17.0},5e-12),'divmod q 73')
 assert(list_same(r:tolist(),{1.0,4.0,0.0,0.0,0.0,0.0,0.0},5e-12),'divmod r 73')
 assert(zero_sign_same(q,{2.0,-3.0,0.0,5.0,-17.0,5.0,-17.0},{false,true,false,false,true,false,true}),'divmod q signs 73')
 assert(zero_sign_same(r,{1.0,4.0,0.0,0.0,0.0,0.0,0.0},{false,false,false,false,false,false,false}),'divmod r signs 73')
end
do
 local a=np.array({5,1,5,1,0,-17,-5},np.int16)
 local b=np.array({-1.0,-2.0,7.0,2.0,2.0,-1.0,-7.0},np.float16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float32' and r.dtype=='float32','divmod dtype 74')
 assert(list_same(q:tolist(),{-5.0,-1.0,0.0,0.0,0.0,17.0,0.0},5e-06),'divmod q 74')
 assert(list_same(r:tolist(),{-0.0,-1.0,5.0,1.0,0.0,-0.0,-5.0},5e-06),'divmod r 74')
 assert(zero_sign_same(q,{-5.0,-1.0,0.0,0.0,0.0,17.0,0.0},{true,true,false,false,false,false,false}),'divmod q signs 74')
 assert(zero_sign_same(r,{-0.0,-1.0,5.0,1.0,0.0,-0.0,-5.0},{true,true,false,false,false,true,true}),'divmod r signs 74')
end
do
 local a=np.array({5,-1,-17,-1,-5,5,-1},np.int16)
 local b=np.array({2.0,1.0,1.0,1.0,-1.0,2.0,-1.0},np.float32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float32' and r.dtype=='float32','divmod dtype 75')
 assert(list_same(q:tolist(),{2.0,-1.0,-17.0,-1.0,5.0,2.0,1.0},5e-06),'divmod q 75')
 assert(list_same(r:tolist(),{1.0,0.0,0.0,0.0,-0.0,1.0,-0.0},5e-06),'divmod r 75')
 assert(zero_sign_same(q,{2.0,-1.0,-17.0,-1.0,5.0,2.0,1.0},{false,true,true,true,false,false,false}),'divmod q signs 75')
 assert(zero_sign_same(r,{1.0,0.0,0.0,0.0,-0.0,1.0,-0.0},{false,false,false,false,true,false,true}),'divmod r signs 75')
end
do
 local a=np.array({-1,0,0,17,-1,-17,-1},np.int16)
 local b=np.array({2.0,-1.0,-7.0,1.0,7.0,7.0,7.0},np.float64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 76')
 assert(list_same(q:tolist(),{-1.0,-0.0,-0.0,17.0,-1.0,-3.0,-1.0},5e-12),'divmod q 76')
 assert(list_same(r:tolist(),{1.0,-0.0,-0.0,0.0,6.0,4.0,6.0},5e-12),'divmod r 76')
 assert(zero_sign_same(q,{-1.0,-0.0,-0.0,17.0,-1.0,-3.0,-1.0},{true,true,true,false,true,true,true}),'divmod q signs 76')
 assert(zero_sign_same(r,{1.0,-0.0,-0.0,0.0,6.0,4.0,6.0},{false,true,true,false,false,false,false}),'divmod r signs 76')
end
do
 local a=np.array({5,1,0,-5,5,17,1},np.int16)
 local b=np.array({1.0,2.0,2.0,1.0,-2.0,1.0,-2.0},np.longdouble)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 77')
 assert(list_same(q:tolist(),{5.0,0.0,0.0,-5.0,-3.0,17.0,-1.0},5e-12),'divmod q 77')
 assert(list_same(r:tolist(),{0.0,1.0,0.0,0.0,-1.0,0.0,-1.0},5e-12),'divmod r 77')
 assert(zero_sign_same(q,{5.0,0.0,0.0,-5.0,-3.0,17.0,-1.0},{false,false,false,true,true,false,true}),'divmod q signs 77')
 assert(zero_sign_same(r,{0.0,1.0,0.0,0.0,-1.0,0.0,-1.0},{false,false,false,false,true,false,true}),'divmod r signs 77')
end
do
 local a=np.array({5,0,5,5,1,1,17},np.uint16)
 local b=np.array({true,true,true,true,true,true,true},np.bool)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint16' and r.dtype=='uint16','divmod dtype 78')
 assert(list_same(q:tolist(),{5,0,5,5,1,1,17},0),'divmod q 78')
 assert(list_same(r:tolist(),{0,0,0,0,0,0,0},0),'divmod r 78')
 assert(zero_sign_same(q,{5,0,5,5,1,1,17},{false,false,false,false,false,false,false}),'divmod q signs 78')
 assert(zero_sign_same(r,{0,0,0,0,0,0,0},{false,false,false,false,false,false,false}),'divmod r signs 78')
end
do
 local a=np.array({5,1,0,1,17,5,1},np.uint16)
 local b=np.array({1,2,-7,2,7,7,1},np.int8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int32' and r.dtype=='int32','divmod dtype 79')
 assert(list_same(q:tolist(),{5,0,0,0,2,0,1},0),'divmod q 79')
 assert(list_same(r:tolist(),{0,1,0,1,3,5,0},0),'divmod r 79')
 assert(zero_sign_same(q,{5,0,0,0,2,0,1},{false,false,false,false,false,false,false}),'divmod q signs 79')
 assert(zero_sign_same(r,{0,1,0,1,3,5,0},{false,false,false,false,false,false,false}),'divmod r signs 79')
end
do
 local a=np.array({5,0,1,0,1,5,0},np.uint16)
 local b=np.array({1,7,2,2,7,2,1},np.uint8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint16' and r.dtype=='uint16','divmod dtype 80')
 assert(list_same(q:tolist(),{5,0,0,0,0,2,0},0),'divmod q 80')
 assert(list_same(r:tolist(),{0,0,1,0,1,1,0},0),'divmod r 80')
 assert(zero_sign_same(q,{5,0,0,0,0,2,0},{false,false,false,false,false,false,false}),'divmod q signs 80')
 assert(zero_sign_same(r,{0,0,1,0,1,1,0},{false,false,false,false,false,false,false}),'divmod r signs 80')
end
do
 local a=np.array({5,5,0,5,0,1,17},np.uint16)
 local b=np.array({-2,-7,1,7,-7,1,-2},np.int16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int32' and r.dtype=='int32','divmod dtype 81')
 assert(list_same(q:tolist(),{-3,-1,0,0,0,1,-9},0),'divmod q 81')
 assert(list_same(r:tolist(),{-1,-2,0,5,0,0,-1},0),'divmod r 81')
 assert(zero_sign_same(q,{-3,-1,0,0,0,1,-9},{true,true,false,false,false,false,true}),'divmod q signs 81')
 assert(zero_sign_same(r,{-1,-2,0,5,0,0,-1},{true,true,false,false,false,false,true}),'divmod r signs 81')
end
do
 local a=np.array({1,17,0,1,17,0,5},np.uint16)
 local b=np.array({1,7,7,1,7,1,7},np.uint16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint16' and r.dtype=='uint16','divmod dtype 82')
 assert(list_same(q:tolist(),{1,2,0,1,2,0,0},0),'divmod q 82')
 assert(list_same(r:tolist(),{0,3,0,0,3,0,5},0),'divmod r 82')
 assert(zero_sign_same(q,{1,2,0,1,2,0,0},{false,false,false,false,false,false,false}),'divmod q signs 82')
 assert(zero_sign_same(r,{0,3,0,0,3,0,5},{false,false,false,false,false,false,false}),'divmod r signs 82')
end
do
 local a=np.array({17,0,17,17,1,1,17},np.uint16)
 local b=np.array({-2,2,2,7,-7,-2,2},np.int32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int32' and r.dtype=='int32','divmod dtype 83')
 assert(list_same(q:tolist(),{-9,0,8,2,-1,-1,8},0),'divmod q 83')
 assert(list_same(r:tolist(),{-1,0,1,3,-6,-1,1},0),'divmod r 83')
 assert(zero_sign_same(q,{-9,0,8,2,-1,-1,8},{true,false,false,false,true,true,false}),'divmod q signs 83')
 assert(zero_sign_same(r,{-1,0,1,3,-6,-1,1},{true,false,false,false,true,true,false}),'divmod r signs 83')
end
do
 local a=np.array({0,0,0,17,17,5,1},np.uint16)
 local b=np.array({1,7,7,1,2,1,1},np.uint32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint32' and r.dtype=='uint32','divmod dtype 84')
 assert(list_same(q:tolist(),{0,0,0,17,8,5,1},0),'divmod q 84')
 assert(list_same(r:tolist(),{0,0,0,0,1,0,0},0),'divmod r 84')
 assert(zero_sign_same(q,{0,0,0,17,8,5,1},{false,false,false,false,false,false,false}),'divmod q signs 84')
 assert(zero_sign_same(r,{0,0,0,0,1,0,0},{false,false,false,false,false,false,false}),'divmod r signs 84')
end
do
 local a=np.array({5,1,5,0,5,1,5},np.uint16)
 local b=np.array({7,7,-1,2,-7,1,1},np.int64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int64' and r.dtype=='int64','divmod dtype 85')
 assert(list_same(q:tolist(),{0,0,-5,0,-1,1,5},0),'divmod q 85')
 assert(list_same(r:tolist(),{5,1,0,0,-2,0,0},0),'divmod r 85')
 assert(zero_sign_same(q,{0,0,-5,0,-1,1,5},{false,false,true,false,true,false,false}),'divmod q signs 85')
 assert(zero_sign_same(r,{5,1,0,0,-2,0,0},{false,false,false,false,true,false,false}),'divmod r signs 85')
end
do
 local a=np.array({0,0,1,17,17,0,5},np.uint16)
 local b=np.array({7,1,1,1,2,1,1},np.uint64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint64' and r.dtype=='uint64','divmod dtype 86')
 assert(list_same(q:tolist(),{0,0,1,17,8,0,5},0),'divmod q 86')
 assert(list_same(r:tolist(),{0,0,0,0,1,0,0},0),'divmod r 86')
 assert(zero_sign_same(q,{0,0,1,17,8,0,5},{false,false,false,false,false,false,false}),'divmod q signs 86')
 assert(zero_sign_same(r,{0,0,0,0,1,0,0},{false,false,false,false,false,false,false}),'divmod r signs 86')
end
do
 local a=np.array({17,0,17,0,17,17,5},np.uint16)
 local b=np.array({-7.0,2.0,-2.0,-2.0,7.0,7.0,1.0},np.float16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float32' and r.dtype=='float32','divmod dtype 87')
 assert(list_same(q:tolist(),{-3.0,0.0,-9.0,-0.0,2.0,2.0,5.0},5e-06),'divmod q 87')
 assert(list_same(r:tolist(),{-4.0,0.0,-1.0,-0.0,3.0,3.0,0.0},5e-06),'divmod r 87')
 assert(zero_sign_same(q,{-3.0,0.0,-9.0,-0.0,2.0,2.0,5.0},{true,false,true,true,false,false,false}),'divmod q signs 87')
 assert(zero_sign_same(r,{-4.0,0.0,-1.0,-0.0,3.0,3.0,0.0},{true,false,true,true,false,false,false}),'divmod r signs 87')
end
do
 local a=np.array({0,17,17,5,1,1,17},np.uint16)
 local b=np.array({-1.0,2.0,-2.0,1.0,-1.0,7.0,-1.0},np.float32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float32' and r.dtype=='float32','divmod dtype 88')
 assert(list_same(q:tolist(),{-0.0,8.0,-9.0,5.0,-1.0,0.0,-17.0},5e-06),'divmod q 88')
 assert(list_same(r:tolist(),{-0.0,1.0,-1.0,0.0,-0.0,1.0,-0.0},5e-06),'divmod r 88')
 assert(zero_sign_same(q,{-0.0,8.0,-9.0,5.0,-1.0,0.0,-17.0},{true,false,true,false,true,false,true}),'divmod q signs 88')
 assert(zero_sign_same(r,{-0.0,1.0,-1.0,0.0,-0.0,1.0,-0.0},{true,false,true,false,true,false,true}),'divmod r signs 88')
end
do
 local a=np.array({17,5,0,1,0,17,5},np.uint16)
 local b=np.array({-2.0,-2.0,2.0,1.0,-7.0,-1.0,7.0},np.float64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 89')
 assert(list_same(q:tolist(),{-9.0,-3.0,0.0,1.0,-0.0,-17.0,0.0},5e-12),'divmod q 89')
 assert(list_same(r:tolist(),{-1.0,-1.0,0.0,0.0,-0.0,-0.0,5.0},5e-12),'divmod r 89')
 assert(zero_sign_same(q,{-9.0,-3.0,0.0,1.0,-0.0,-17.0,0.0},{true,true,false,false,true,true,false}),'divmod q signs 89')
 assert(zero_sign_same(r,{-1.0,-1.0,0.0,0.0,-0.0,-0.0,5.0},{true,true,false,false,true,true,false}),'divmod r signs 89')
end
do
 local a=np.array({1,1,5,5,1,1,5},np.uint16)
 local b=np.array({-1.0,2.0,7.0,-2.0,1.0,2.0,-7.0},np.longdouble)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 90')
 assert(list_same(q:tolist(),{-1.0,0.0,0.0,-3.0,1.0,0.0,-1.0},5e-12),'divmod q 90')
 assert(list_same(r:tolist(),{-0.0,1.0,5.0,-1.0,0.0,1.0,-2.0},5e-12),'divmod r 90')
 assert(zero_sign_same(q,{-1.0,0.0,0.0,-3.0,1.0,0.0,-1.0},{true,false,false,true,false,false,true}),'divmod q signs 90')
 assert(zero_sign_same(r,{-0.0,1.0,5.0,-1.0,0.0,1.0,-2.0},{true,false,false,true,false,false,true}),'divmod r signs 90')
end
do
 local a=np.array({-5,5,-1,5,17,5,0},np.int32)
 local b=np.array({true,true,true,true,true,true,true},np.bool)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int32' and r.dtype=='int32','divmod dtype 91')
 assert(list_same(q:tolist(),{-5,5,-1,5,17,5,0},0),'divmod q 91')
 assert(list_same(r:tolist(),{0,0,0,0,0,0,0},0),'divmod r 91')
 assert(zero_sign_same(q,{-5,5,-1,5,17,5,0},{true,false,true,false,false,false,false}),'divmod q signs 91')
 assert(zero_sign_same(r,{0,0,0,0,0,0,0},{false,false,false,false,false,false,false}),'divmod r signs 91')
end
do
 local a=np.array({5,17,5,-1,-5,-17,17},np.int32)
 local b=np.array({7,2,-1,7,2,2,1},np.int8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int32' and r.dtype=='int32','divmod dtype 92')
 assert(list_same(q:tolist(),{0,8,-5,-1,-3,-9,17},0),'divmod q 92')
 assert(list_same(r:tolist(),{5,1,0,6,1,1,0},0),'divmod r 92')
 assert(zero_sign_same(q,{0,8,-5,-1,-3,-9,17},{false,false,true,true,true,true,false}),'divmod q signs 92')
 assert(zero_sign_same(r,{5,1,0,6,1,1,0},{false,false,false,false,false,false,false}),'divmod r signs 92')
end
do
 local a=np.array({1,-1,0,-17,5,1,1},np.int32)
 local b=np.array({7,2,1,1,2,2,2},np.uint8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int32' and r.dtype=='int32','divmod dtype 93')
 assert(list_same(q:tolist(),{0,-1,0,-17,2,0,0},0),'divmod q 93')
 assert(list_same(r:tolist(),{1,1,0,0,1,1,1},0),'divmod r 93')
 assert(zero_sign_same(q,{0,-1,0,-17,2,0,0},{false,true,false,true,false,false,false}),'divmod q signs 93')
 assert(zero_sign_same(r,{1,1,0,0,1,1,1},{false,false,false,false,false,false,false}),'divmod r signs 93')
end
do
 local a=np.array({5,5,-5,1,17,17,-1},np.int32)
 local b=np.array({7,-2,1,-2,-7,-2,-2},np.int16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int32' and r.dtype=='int32','divmod dtype 94')
 assert(list_same(q:tolist(),{0,-3,-5,-1,-3,-9,0},0),'divmod q 94')
 assert(list_same(r:tolist(),{5,-1,0,-1,-4,-1,-1},0),'divmod r 94')
 assert(zero_sign_same(q,{0,-3,-5,-1,-3,-9,0},{false,true,true,true,true,true,false}),'divmod q signs 94')
 assert(zero_sign_same(r,{5,-1,0,-1,-4,-1,-1},{false,true,false,true,true,true,true}),'divmod r signs 94')
end
do
 local a=np.array({5,-17,5,1,-1,0,-17},np.int32)
 local b=np.array({1,1,7,1,1,1,7},np.uint16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int32' and r.dtype=='int32','divmod dtype 95')
 assert(list_same(q:tolist(),{5,-17,0,1,-1,0,-3},0),'divmod q 95')
 assert(list_same(r:tolist(),{0,0,5,0,0,0,4},0),'divmod r 95')
 assert(zero_sign_same(q,{5,-17,0,1,-1,0,-3},{false,true,false,false,true,false,true}),'divmod q signs 95')
 assert(zero_sign_same(r,{0,0,5,0,0,0,4},{false,false,false,false,false,false,false}),'divmod r signs 95')
end
do
 local a=np.array({-1,0,-5,-17,5,-1,17},np.int32)
 local b=np.array({2,-1,-1,-7,2,-7,1},np.int32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int32' and r.dtype=='int32','divmod dtype 96')
 assert(list_same(q:tolist(),{-1,0,5,2,2,0,17},0),'divmod q 96')
 assert(list_same(r:tolist(),{1,0,0,-3,1,-1,0},0),'divmod r 96')
 assert(zero_sign_same(q,{-1,0,5,2,2,0,17},{true,false,false,false,false,false,false}),'divmod q signs 96')
 assert(zero_sign_same(r,{1,0,0,-3,1,-1,0},{false,false,false,true,false,true,false}),'divmod r signs 96')
end
do
 local a=np.array({5,0,1,-1,1,5,-17},np.int32)
 local b=np.array({1,2,1,1,2,2,7},np.uint32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int64' and r.dtype=='int64','divmod dtype 97')
 assert(list_same(q:tolist(),{5,0,1,-1,0,2,-3},0),'divmod q 97')
 assert(list_same(r:tolist(),{0,0,0,0,1,1,4},0),'divmod r 97')
 assert(zero_sign_same(q,{5,0,1,-1,0,2,-3},{false,false,false,true,false,false,true}),'divmod q signs 97')
 assert(zero_sign_same(r,{0,0,0,0,1,1,4},{false,false,false,false,false,false,false}),'divmod r signs 97')
end
do
 local a=np.array({17,5,5,-1,1,-5,0},np.int32)
 local b=np.array({-7,7,1,-1,1,7,-2},np.int64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int64' and r.dtype=='int64','divmod dtype 98')
 assert(list_same(q:tolist(),{-3,0,5,1,1,-1,0},0),'divmod q 98')
 assert(list_same(r:tolist(),{-4,5,0,0,0,2,0},0),'divmod r 98')
 assert(zero_sign_same(q,{-3,0,5,1,1,-1,0},{true,false,false,false,false,true,false}),'divmod q signs 98')
 assert(zero_sign_same(r,{-4,5,0,0,0,2,0},{true,false,false,false,false,false,false}),'divmod r signs 98')
end
do
 local a=np.array({-1,17,17,17,1,-5,17},np.int32)
 local b=np.array({7,1,7,7,1,2,7},np.uint64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 99')
 assert(list_same(q:tolist(),{-1.0,17.0,2.0,2.0,1.0,-3.0,2.0},5e-12),'divmod q 99')
 assert(list_same(r:tolist(),{6.0,0.0,3.0,3.0,0.0,1.0,3.0},5e-12),'divmod r 99')
 assert(zero_sign_same(q,{-1.0,17.0,2.0,2.0,1.0,-3.0,2.0},{true,false,false,false,false,true,false}),'divmod q signs 99')
 assert(zero_sign_same(r,{6.0,0.0,3.0,3.0,0.0,1.0,3.0},{false,false,false,false,false,false,false}),'divmod r signs 99')
end
do
 local a=np.array({-1,-17,1,1,-1,-1,0},np.int32)
 local b=np.array({7.0,-1.0,1.0,2.0,2.0,7.0,1.0},np.float16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 100')
 assert(list_same(q:tolist(),{-1.0,17.0,1.0,0.0,-1.0,-1.0,0.0},5e-12),'divmod q 100')
 assert(list_same(r:tolist(),{6.0,-0.0,0.0,1.0,1.0,6.0,0.0},5e-12),'divmod r 100')
 assert(zero_sign_same(q,{-1.0,17.0,1.0,0.0,-1.0,-1.0,0.0},{true,false,false,false,true,true,false}),'divmod q signs 100')
 assert(zero_sign_same(r,{6.0,-0.0,0.0,1.0,1.0,6.0,0.0},{false,true,false,false,false,false,false}),'divmod r signs 100')
end
do
 local a=np.array({17,-5,17,-5,-1,5,-17},np.int32)
 local b=np.array({-2.0,2.0,2.0,-2.0,-1.0,7.0,-1.0},np.float32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 101')
 assert(list_same(q:tolist(),{-9.0,-3.0,8.0,2.0,1.0,0.0,17.0},5e-12),'divmod q 101')
 assert(list_same(r:tolist(),{-1.0,1.0,1.0,-1.0,-0.0,5.0,-0.0},5e-12),'divmod r 101')
 assert(zero_sign_same(q,{-9.0,-3.0,8.0,2.0,1.0,0.0,17.0},{true,true,false,false,false,false,false}),'divmod q signs 101')
 assert(zero_sign_same(r,{-1.0,1.0,1.0,-1.0,-0.0,5.0,-0.0},{true,false,false,true,true,false,true}),'divmod r signs 101')
end
do
 local a=np.array({5,1,0,-17,5,-5,5},np.int32)
 local b=np.array({7.0,-1.0,-1.0,-2.0,-1.0,2.0,2.0},np.float64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 102')
 assert(list_same(q:tolist(),{0.0,-1.0,-0.0,8.0,-5.0,-3.0,2.0},5e-12),'divmod q 102')
 assert(list_same(r:tolist(),{5.0,-0.0,-0.0,-1.0,-0.0,1.0,1.0},5e-12),'divmod r 102')
 assert(zero_sign_same(q,{0.0,-1.0,-0.0,8.0,-5.0,-3.0,2.0},{false,true,true,false,true,true,false}),'divmod q signs 102')
 assert(zero_sign_same(r,{5.0,-0.0,-0.0,-1.0,-0.0,1.0,1.0},{false,true,true,true,true,false,false}),'divmod r signs 102')
end
do
 local a=np.array({-17,-17,-17,-17,-17,1,1},np.int32)
 local b=np.array({7.0,7.0,-2.0,2.0,-1.0,-7.0,1.0},np.longdouble)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 103')
 assert(list_same(q:tolist(),{-3.0,-3.0,8.0,-9.0,17.0,-1.0,1.0},5e-12),'divmod q 103')
 assert(list_same(r:tolist(),{4.0,4.0,-1.0,1.0,-0.0,-6.0,0.0},5e-12),'divmod r 103')
 assert(zero_sign_same(q,{-3.0,-3.0,8.0,-9.0,17.0,-1.0,1.0},{true,true,false,true,false,true,false}),'divmod q signs 103')
 assert(zero_sign_same(r,{4.0,4.0,-1.0,1.0,-0.0,-6.0,0.0},{false,false,true,false,true,true,false}),'divmod r signs 103')
end
do
 local a=np.array({5,1,17,5,0,0,5},np.uint32)
 local b=np.array({true,true,true,true,true,true,true},np.bool)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint32' and r.dtype=='uint32','divmod dtype 104')
 assert(list_same(q:tolist(),{5,1,17,5,0,0,5},0),'divmod q 104')
 assert(list_same(r:tolist(),{0,0,0,0,0,0,0},0),'divmod r 104')
 assert(zero_sign_same(q,{5,1,17,5,0,0,5},{false,false,false,false,false,false,false}),'divmod q signs 104')
 assert(zero_sign_same(r,{0,0,0,0,0,0,0},{false,false,false,false,false,false,false}),'divmod r signs 104')
end
do
 local a=np.array({0,17,5,0,1,17,0},np.uint32)
 local b=np.array({2,1,2,-7,2,7,-7},np.int8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int64' and r.dtype=='int64','divmod dtype 105')
 assert(list_same(q:tolist(),{0,17,2,0,0,2,0},0),'divmod q 105')
 assert(list_same(r:tolist(),{0,0,1,0,1,3,0},0),'divmod r 105')
 assert(zero_sign_same(q,{0,17,2,0,0,2,0},{false,false,false,false,false,false,false}),'divmod q signs 105')
 assert(zero_sign_same(r,{0,0,1,0,1,3,0},{false,false,false,false,false,false,false}),'divmod r signs 105')
end
do
 local a=np.array({0,17,17,1,1,0,5},np.uint32)
 local b=np.array({7,1,2,7,7,7,7},np.uint8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint32' and r.dtype=='uint32','divmod dtype 106')
 assert(list_same(q:tolist(),{0,17,8,0,0,0,0},0),'divmod q 106')
 assert(list_same(r:tolist(),{0,0,1,1,1,0,5},0),'divmod r 106')
 assert(zero_sign_same(q,{0,17,8,0,0,0,0},{false,false,false,false,false,false,false}),'divmod q signs 106')
 assert(zero_sign_same(r,{0,0,1,1,1,0,5},{false,false,false,false,false,false,false}),'divmod r signs 106')
end
do
 local a=np.array({5,0,1,0,0,5,5},np.uint32)
 local b=np.array({1,2,-1,-2,7,-7,1},np.int16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int64' and r.dtype=='int64','divmod dtype 107')
 assert(list_same(q:tolist(),{5,0,-1,0,0,-1,5},0),'divmod q 107')
 assert(list_same(r:tolist(),{0,0,0,0,0,-2,0},0),'divmod r 107')
 assert(zero_sign_same(q,{5,0,-1,0,0,-1,5},{false,false,true,false,false,true,false}),'divmod q signs 107')
 assert(zero_sign_same(r,{0,0,0,0,0,-2,0},{false,false,false,false,false,true,false}),'divmod r signs 107')
end
do
 local a=np.array({1,5,5,1,0,1,17},np.uint32)
 local b=np.array({7,2,2,7,1,1,7},np.uint16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint32' and r.dtype=='uint32','divmod dtype 108')
 assert(list_same(q:tolist(),{0,2,2,0,0,1,2},0),'divmod q 108')
 assert(list_same(r:tolist(),{1,1,1,1,0,0,3},0),'divmod r 108')
 assert(zero_sign_same(q,{0,2,2,0,0,1,2},{false,false,false,false,false,false,false}),'divmod q signs 108')
 assert(zero_sign_same(r,{1,1,1,1,0,0,3},{false,false,false,false,false,false,false}),'divmod r signs 108')
end
do
 local a=np.array({0,5,1,17,5,0,0},np.uint32)
 local b=np.array({7,2,-7,1,-7,1,-7},np.int32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int64' and r.dtype=='int64','divmod dtype 109')
 assert(list_same(q:tolist(),{0,2,-1,17,-1,0,0},0),'divmod q 109')
 assert(list_same(r:tolist(),{0,1,-6,0,-2,0,0},0),'divmod r 109')
 assert(zero_sign_same(q,{0,2,-1,17,-1,0,0},{false,false,true,false,true,false,false}),'divmod q signs 109')
 assert(zero_sign_same(r,{0,1,-6,0,-2,0,0},{false,false,true,false,true,false,false}),'divmod r signs 109')
end
do
 local a=np.array({5,0,5,17,1,17,0},np.uint32)
 local b=np.array({2,7,7,1,2,2,2},np.uint32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint32' and r.dtype=='uint32','divmod dtype 110')
 assert(list_same(q:tolist(),{2,0,0,17,0,8,0},0),'divmod q 110')
 assert(list_same(r:tolist(),{1,0,5,0,1,1,0},0),'divmod r 110')
 assert(zero_sign_same(q,{2,0,0,17,0,8,0},{false,false,false,false,false,false,false}),'divmod q signs 110')
 assert(zero_sign_same(r,{1,0,5,0,1,1,0},{false,false,false,false,false,false,false}),'divmod r signs 110')
end
do
 local a=np.array({0,5,5,5,17,5,0},np.uint32)
 local b=np.array({2,-1,2,1,2,1,-2},np.int64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int64' and r.dtype=='int64','divmod dtype 111')
 assert(list_same(q:tolist(),{0,-5,2,5,8,5,0},0),'divmod q 111')
 assert(list_same(r:tolist(),{0,0,1,0,1,0,0},0),'divmod r 111')
 assert(zero_sign_same(q,{0,-5,2,5,8,5,0},{false,true,false,false,false,false,false}),'divmod q signs 111')
 assert(zero_sign_same(r,{0,0,1,0,1,0,0},{false,false,false,false,false,false,false}),'divmod r signs 111')
end
do
 local a=np.array({17,17,17,1,17,17,0},np.uint32)
 local b=np.array({1,2,1,7,1,2,1},np.uint64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint64' and r.dtype=='uint64','divmod dtype 112')
 assert(list_same(q:tolist(),{17,8,17,0,17,8,0},0),'divmod q 112')
 assert(list_same(r:tolist(),{0,1,0,1,0,1,0},0),'divmod r 112')
 assert(zero_sign_same(q,{17,8,17,0,17,8,0},{false,false,false,false,false,false,false}),'divmod q signs 112')
 assert(zero_sign_same(r,{0,1,0,1,0,1,0},{false,false,false,false,false,false,false}),'divmod r signs 112')
end
do
 local a=np.array({1,1,17,0,1,1,1},np.uint32)
 local b=np.array({-2.0,-1.0,7.0,2.0,2.0,-1.0,-2.0},np.float16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 113')
 assert(list_same(q:tolist(),{-1.0,-1.0,2.0,0.0,0.0,-1.0,-1.0},5e-12),'divmod q 113')
 assert(list_same(r:tolist(),{-1.0,-0.0,3.0,0.0,1.0,-0.0,-1.0},5e-12),'divmod r 113')
 assert(zero_sign_same(q,{-1.0,-1.0,2.0,0.0,0.0,-1.0,-1.0},{true,true,false,false,false,true,true}),'divmod q signs 113')
 assert(zero_sign_same(r,{-1.0,-0.0,3.0,0.0,1.0,-0.0,-1.0},{true,true,false,false,false,true,true}),'divmod r signs 113')
end
do
 local a=np.array({1,5,5,1,1,1,5},np.uint32)
 local b=np.array({1.0,-2.0,-1.0,1.0,-1.0,7.0,7.0},np.float32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 114')
 assert(list_same(q:tolist(),{1.0,-3.0,-5.0,1.0,-1.0,0.0,0.0},5e-12),'divmod q 114')
 assert(list_same(r:tolist(),{0.0,-1.0,-0.0,0.0,-0.0,1.0,5.0},5e-12),'divmod r 114')
 assert(zero_sign_same(q,{1.0,-3.0,-5.0,1.0,-1.0,0.0,0.0},{false,true,true,false,true,false,false}),'divmod q signs 114')
 assert(zero_sign_same(r,{0.0,-1.0,-0.0,0.0,-0.0,1.0,5.0},{false,true,true,false,true,false,false}),'divmod r signs 114')
end
do
 local a=np.array({0,5,0,1,5,17,1},np.uint32)
 local b=np.array({2.0,-2.0,1.0,-1.0,-1.0,-1.0,-1.0},np.float64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 115')
 assert(list_same(q:tolist(),{0.0,-3.0,0.0,-1.0,-5.0,-17.0,-1.0},5e-12),'divmod q 115')
 assert(list_same(r:tolist(),{0.0,-1.0,0.0,-0.0,-0.0,-0.0,-0.0},5e-12),'divmod r 115')
 assert(zero_sign_same(q,{0.0,-3.0,0.0,-1.0,-5.0,-17.0,-1.0},{false,true,false,true,true,true,true}),'divmod q signs 115')
 assert(zero_sign_same(r,{0.0,-1.0,0.0,-0.0,-0.0,-0.0,-0.0},{false,true,false,true,true,true,true}),'divmod r signs 115')
end
do
 local a=np.array({1,5,5,17,5,0,1},np.uint32)
 local b=np.array({-1.0,-1.0,-1.0,2.0,-7.0,-7.0,-7.0},np.longdouble)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 116')
 assert(list_same(q:tolist(),{-1.0,-5.0,-5.0,8.0,-1.0,-0.0,-1.0},5e-12),'divmod q 116')
 assert(list_same(r:tolist(),{-0.0,-0.0,-0.0,1.0,-2.0,-0.0,-6.0},5e-12),'divmod r 116')
 assert(zero_sign_same(q,{-1.0,-5.0,-5.0,8.0,-1.0,-0.0,-1.0},{true,true,true,false,true,true,true}),'divmod q signs 116')
 assert(zero_sign_same(r,{-0.0,-0.0,-0.0,1.0,-2.0,-0.0,-6.0},{true,true,true,false,true,true,true}),'divmod r signs 116')
end
do
 local a=np.array({-1,-5,-1,-5,-1,17,0},np.int64)
 local b=np.array({true,true,true,true,true,true,true},np.bool)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int64' and r.dtype=='int64','divmod dtype 117')
 assert(list_same(q:tolist(),{-1,-5,-1,-5,-1,17,0},0),'divmod q 117')
 assert(list_same(r:tolist(),{0,0,0,0,0,0,0},0),'divmod r 117')
 assert(zero_sign_same(q,{-1,-5,-1,-5,-1,17,0},{true,true,true,true,true,false,false}),'divmod q signs 117')
 assert(zero_sign_same(r,{0,0,0,0,0,0,0},{false,false,false,false,false,false,false}),'divmod r signs 117')
end
do
 local a=np.array({-5,-5,0,1,-5,5,17},np.int64)
 local b=np.array({-7,7,7,-1,-1,-7,-1},np.int8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int64' and r.dtype=='int64','divmod dtype 118')
 assert(list_same(q:tolist(),{0,-1,0,-1,5,-1,-17},0),'divmod q 118')
 assert(list_same(r:tolist(),{-5,2,0,0,0,-2,0},0),'divmod r 118')
 assert(zero_sign_same(q,{0,-1,0,-1,5,-1,-17},{false,true,false,true,false,true,true}),'divmod q signs 118')
 assert(zero_sign_same(r,{-5,2,0,0,0,-2,0},{true,false,false,false,false,true,false}),'divmod r signs 118')
end
do
 local a=np.array({5,1,1,-1,5,-17,-5},np.int64)
 local b=np.array({1,1,1,2,1,2,7},np.uint8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int64' and r.dtype=='int64','divmod dtype 119')
 assert(list_same(q:tolist(),{5,1,1,-1,5,-9,-1},0),'divmod q 119')
 assert(list_same(r:tolist(),{0,0,0,1,0,1,2},0),'divmod r 119')
 assert(zero_sign_same(q,{5,1,1,-1,5,-9,-1},{false,false,false,true,false,true,true}),'divmod q signs 119')
 assert(zero_sign_same(r,{0,0,0,1,0,1,2},{false,false,false,false,false,false,false}),'divmod r signs 119')
end
do
 local a=np.array({-17,-5,-5,1,1,-1,1},np.int64)
 local b=np.array({7,7,2,-2,-7,-2,-1},np.int16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int64' and r.dtype=='int64','divmod dtype 120')
 assert(list_same(q:tolist(),{-3,-1,-3,-1,-1,0,-1},0),'divmod q 120')
 assert(list_same(r:tolist(),{4,2,1,-1,-6,-1,0},0),'divmod r 120')
 assert(zero_sign_same(q,{-3,-1,-3,-1,-1,0,-1},{true,true,true,true,true,false,true}),'divmod q signs 120')
 assert(zero_sign_same(r,{4,2,1,-1,-6,-1,0},{false,false,false,true,true,true,false}),'divmod r signs 120')
end
do
 local a=np.array({-17,-17,5,-5,-17,-5,17},np.int64)
 local b=np.array({1,1,7,1,1,1,7},np.uint16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int64' and r.dtype=='int64','divmod dtype 121')
 assert(list_same(q:tolist(),{-17,-17,0,-5,-17,-5,2},0),'divmod q 121')
 assert(list_same(r:tolist(),{0,0,5,0,0,0,3},0),'divmod r 121')
 assert(zero_sign_same(q,{-17,-17,0,-5,-17,-5,2},{true,true,false,true,true,true,false}),'divmod q signs 121')
 assert(zero_sign_same(r,{0,0,5,0,0,0,3},{false,false,false,false,false,false,false}),'divmod r signs 121')
end
do
 local a=np.array({-5,5,-5,0,5,-17,17},np.int64)
 local b=np.array({7,1,-7,1,-2,2,-2},np.int32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int64' and r.dtype=='int64','divmod dtype 122')
 assert(list_same(q:tolist(),{-1,5,0,0,-3,-9,-9},0),'divmod q 122')
 assert(list_same(r:tolist(),{2,0,-5,0,-1,1,-1},0),'divmod r 122')
 assert(zero_sign_same(q,{-1,5,0,0,-3,-9,-9},{true,false,false,false,true,true,true}),'divmod q signs 122')
 assert(zero_sign_same(r,{2,0,-5,0,-1,1,-1},{false,false,true,false,true,false,true}),'divmod r signs 122')
end
do
 local a=np.array({1,5,5,-17,-1,-5,17},np.int64)
 local b=np.array({2,1,2,2,2,2,7},np.uint32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int64' and r.dtype=='int64','divmod dtype 123')
 assert(list_same(q:tolist(),{0,5,2,-9,-1,-3,2},0),'divmod q 123')
 assert(list_same(r:tolist(),{1,0,1,1,1,1,3},0),'divmod r 123')
 assert(zero_sign_same(q,{0,5,2,-9,-1,-3,2},{false,false,false,true,true,true,false}),'divmod q signs 123')
 assert(zero_sign_same(r,{1,0,1,1,1,1,3},{false,false,false,false,false,false,false}),'divmod r signs 123')
end
do
 local a=np.array({-17,0,0,1,-1,-5,1},np.int64)
 local b=np.array({-1,7,-1,7,-1,-2,7},np.int64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='int64' and r.dtype=='int64','divmod dtype 124')
 assert(list_same(q:tolist(),{17,0,0,0,1,2,0},0),'divmod q 124')
 assert(list_same(r:tolist(),{0,0,0,1,0,-1,1},0),'divmod r 124')
 assert(zero_sign_same(q,{17,0,0,0,1,2,0},{false,false,false,false,false,false,false}),'divmod q signs 124')
 assert(zero_sign_same(r,{0,0,0,1,0,-1,1},{false,false,false,false,false,true,false}),'divmod r signs 124')
end
do
 local a=np.array({-5,17,1,5,1,5,1},np.int64)
 local b=np.array({2,2,1,2,7,7,7},np.uint64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 125')
 assert(list_same(q:tolist(),{-3.0,8.0,1.0,2.0,0.0,0.0,0.0},5e-12),'divmod q 125')
 assert(list_same(r:tolist(),{1.0,1.0,0.0,1.0,1.0,5.0,1.0},5e-12),'divmod r 125')
 assert(zero_sign_same(q,{-3.0,8.0,1.0,2.0,0.0,0.0,0.0},{true,false,false,false,false,false,false}),'divmod q signs 125')
 assert(zero_sign_same(r,{1.0,1.0,0.0,1.0,1.0,5.0,1.0},{false,false,false,false,false,false,false}),'divmod r signs 125')
end
do
 local a=np.array({-1,-1,-1,-17,17,5,5},np.int64)
 local b=np.array({-7.0,-7.0,1.0,-2.0,2.0,2.0,1.0},np.float16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 126')
 assert(list_same(q:tolist(),{0.0,0.0,-1.0,8.0,8.0,2.0,5.0},5e-12),'divmod q 126')
 assert(list_same(r:tolist(),{-1.0,-1.0,0.0,-1.0,1.0,1.0,0.0},5e-12),'divmod r 126')
 assert(zero_sign_same(q,{0.0,0.0,-1.0,8.0,8.0,2.0,5.0},{false,false,true,false,false,false,false}),'divmod q signs 126')
 assert(zero_sign_same(r,{-1.0,-1.0,0.0,-1.0,1.0,1.0,0.0},{true,true,false,true,false,false,false}),'divmod r signs 126')
end
do
 local a=np.array({-1,-1,-5,0,1,-17,5},np.int64)
 local b=np.array({1.0,2.0,1.0,-7.0,-7.0,2.0,-2.0},np.float32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 127')
 assert(list_same(q:tolist(),{-1.0,-1.0,-5.0,-0.0,-1.0,-9.0,-3.0},5e-12),'divmod q 127')
 assert(list_same(r:tolist(),{0.0,1.0,0.0,-0.0,-6.0,1.0,-1.0},5e-12),'divmod r 127')
 assert(zero_sign_same(q,{-1.0,-1.0,-5.0,-0.0,-1.0,-9.0,-3.0},{true,true,true,true,true,true,true}),'divmod q signs 127')
 assert(zero_sign_same(r,{0.0,1.0,0.0,-0.0,-6.0,1.0,-1.0},{false,false,false,true,true,false,true}),'divmod r signs 127')
end
do
 local a=np.array({0,0,-5,17,5,0,1},np.int64)
 local b=np.array({-1.0,-1.0,-1.0,-7.0,7.0,-1.0,7.0},np.float64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 128')
 assert(list_same(q:tolist(),{-0.0,-0.0,5.0,-3.0,0.0,-0.0,0.0},5e-12),'divmod q 128')
 assert(list_same(r:tolist(),{-0.0,-0.0,-0.0,-4.0,5.0,-0.0,1.0},5e-12),'divmod r 128')
 assert(zero_sign_same(q,{-0.0,-0.0,5.0,-3.0,0.0,-0.0,0.0},{true,true,false,true,false,true,false}),'divmod q signs 128')
 assert(zero_sign_same(r,{-0.0,-0.0,-0.0,-4.0,5.0,-0.0,1.0},{true,true,true,true,false,true,false}),'divmod r signs 128')
end
do
 local a=np.array({0,17,0,1,-1,0,5},np.int64)
 local b=np.array({-2.0,-7.0,-2.0,2.0,-1.0,1.0,1.0},np.longdouble)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 129')
 assert(list_same(q:tolist(),{-0.0,-3.0,-0.0,0.0,1.0,0.0,5.0},5e-12),'divmod q 129')
 assert(list_same(r:tolist(),{-0.0,-4.0,-0.0,1.0,-0.0,0.0,0.0},5e-12),'divmod r 129')
 assert(zero_sign_same(q,{-0.0,-3.0,-0.0,0.0,1.0,0.0,5.0},{true,true,true,false,false,false,false}),'divmod q signs 129')
 assert(zero_sign_same(r,{-0.0,-4.0,-0.0,1.0,-0.0,0.0,0.0},{true,true,true,false,true,false,false}),'divmod r signs 129')
end
do
 local a=np.array({1,0,5,1,0,1,17},np.uint64)
 local b=np.array({true,true,true,true,true,true,true},np.bool)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint64' and r.dtype=='uint64','divmod dtype 130')
 assert(list_same(q:tolist(),{1,0,5,1,0,1,17},0),'divmod q 130')
 assert(list_same(r:tolist(),{0,0,0,0,0,0,0},0),'divmod r 130')
 assert(zero_sign_same(q,{1,0,5,1,0,1,17},{false,false,false,false,false,false,false}),'divmod q signs 130')
 assert(zero_sign_same(r,{0,0,0,0,0,0,0},{false,false,false,false,false,false,false}),'divmod r signs 130')
end
do
 local a=np.array({1,1,0,1,1,5,1},np.uint64)
 local b=np.array({-1,-2,-1,-1,-1,2,1},np.int8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 131')
 assert(list_same(q:tolist(),{-1.0,-1.0,-0.0,-1.0,-1.0,2.0,1.0},5e-12),'divmod q 131')
 assert(list_same(r:tolist(),{-0.0,-1.0,-0.0,-0.0,-0.0,1.0,0.0},5e-12),'divmod r 131')
 assert(zero_sign_same(q,{-1.0,-1.0,-0.0,-1.0,-1.0,2.0,1.0},{true,true,true,true,true,false,false}),'divmod q signs 131')
 assert(zero_sign_same(r,{-0.0,-1.0,-0.0,-0.0,-0.0,1.0,0.0},{true,true,true,true,true,false,false}),'divmod r signs 131')
end
do
 local a=np.array({5,0,17,17,5,1,17},np.uint64)
 local b=np.array({2,7,1,1,1,7,2},np.uint8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint64' and r.dtype=='uint64','divmod dtype 132')
 assert(list_same(q:tolist(),{2,0,17,17,5,0,8},0),'divmod q 132')
 assert(list_same(r:tolist(),{1,0,0,0,0,1,1},0),'divmod r 132')
 assert(zero_sign_same(q,{2,0,17,17,5,0,8},{false,false,false,false,false,false,false}),'divmod q signs 132')
 assert(zero_sign_same(r,{1,0,0,0,0,1,1},{false,false,false,false,false,false,false}),'divmod r signs 132')
end
do
 local a=np.array({17,17,5,5,1,17,1},np.uint64)
 local b=np.array({-1,-1,7,-1,2,-1,7},np.int16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 133')
 assert(list_same(q:tolist(),{-17.0,-17.0,0.0,-5.0,0.0,-17.0,0.0},5e-12),'divmod q 133')
 assert(list_same(r:tolist(),{-0.0,-0.0,5.0,-0.0,1.0,-0.0,1.0},5e-12),'divmod r 133')
 assert(zero_sign_same(q,{-17.0,-17.0,0.0,-5.0,0.0,-17.0,0.0},{true,true,false,true,false,true,false}),'divmod q signs 133')
 assert(zero_sign_same(r,{-0.0,-0.0,5.0,-0.0,1.0,-0.0,1.0},{true,true,false,true,false,true,false}),'divmod r signs 133')
end
do
 local a=np.array({17,1,5,0,17,0,0},np.uint64)
 local b=np.array({1,7,2,1,2,2,2},np.uint16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint64' and r.dtype=='uint64','divmod dtype 134')
 assert(list_same(q:tolist(),{17,0,2,0,8,0,0},0),'divmod q 134')
 assert(list_same(r:tolist(),{0,1,1,0,1,0,0},0),'divmod r 134')
 assert(zero_sign_same(q,{17,0,2,0,8,0,0},{false,false,false,false,false,false,false}),'divmod q signs 134')
 assert(zero_sign_same(r,{0,1,1,0,1,0,0},{false,false,false,false,false,false,false}),'divmod r signs 134')
end
do
 local a=np.array({0,5,17,1,1,5,17},np.uint64)
 local b=np.array({2,-2,2,-2,1,7,7},np.int32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 135')
 assert(list_same(q:tolist(),{0.0,-3.0,8.0,-1.0,1.0,0.0,2.0},5e-12),'divmod q 135')
 assert(list_same(r:tolist(),{0.0,-1.0,1.0,-1.0,0.0,5.0,3.0},5e-12),'divmod r 135')
 assert(zero_sign_same(q,{0.0,-3.0,8.0,-1.0,1.0,0.0,2.0},{false,true,false,true,false,false,false}),'divmod q signs 135')
 assert(zero_sign_same(r,{0.0,-1.0,1.0,-1.0,0.0,5.0,3.0},{false,true,false,true,false,false,false}),'divmod r signs 135')
end
do
 local a=np.array({1,1,0,17,0,17,0},np.uint64)
 local b=np.array({1,1,1,2,7,1,1},np.uint32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint64' and r.dtype=='uint64','divmod dtype 136')
 assert(list_same(q:tolist(),{1,1,0,8,0,17,0},0),'divmod q 136')
 assert(list_same(r:tolist(),{0,0,0,1,0,0,0},0),'divmod r 136')
 assert(zero_sign_same(q,{1,1,0,8,0,17,0},{false,false,false,false,false,false,false}),'divmod q signs 136')
 assert(zero_sign_same(r,{0,0,0,1,0,0,0},{false,false,false,false,false,false,false}),'divmod r signs 136')
end
do
 local a=np.array({1,1,0,1,5,0,0},np.uint64)
 local b=np.array({2,7,2,-7,-1,-2,7},np.int64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 137')
 assert(list_same(q:tolist(),{0.0,0.0,0.0,-1.0,-5.0,-0.0,0.0},5e-12),'divmod q 137')
 assert(list_same(r:tolist(),{1.0,1.0,0.0,-6.0,-0.0,-0.0,0.0},5e-12),'divmod r 137')
 assert(zero_sign_same(q,{0.0,0.0,0.0,-1.0,-5.0,-0.0,0.0},{false,false,false,true,true,true,false}),'divmod q signs 137')
 assert(zero_sign_same(r,{1.0,1.0,0.0,-6.0,-0.0,-0.0,0.0},{false,false,false,true,true,true,false}),'divmod r signs 137')
end
do
 local a=np.array({0,1,1,17,1,5,5},np.uint64)
 local b=np.array({2,1,1,7,1,1,7},np.uint64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='uint64' and r.dtype=='uint64','divmod dtype 138')
 assert(list_same(q:tolist(),{0,1,1,2,1,5,0},0),'divmod q 138')
 assert(list_same(r:tolist(),{0,0,0,3,0,0,5},0),'divmod r 138')
 assert(zero_sign_same(q,{0,1,1,2,1,5,0},{false,false,false,false,false,false,false}),'divmod q signs 138')
 assert(zero_sign_same(r,{0,0,0,3,0,0,5},{false,false,false,false,false,false,false}),'divmod r signs 138')
end
do
 local a=np.array({17,17,1,5,17,5,1},np.uint64)
 local b=np.array({-7.0,1.0,7.0,7.0,-1.0,-2.0,-2.0},np.float16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 139')
 assert(list_same(q:tolist(),{-3.0,17.0,0.0,0.0,-17.0,-3.0,-1.0},5e-12),'divmod q 139')
 assert(list_same(r:tolist(),{-4.0,0.0,1.0,5.0,-0.0,-1.0,-1.0},5e-12),'divmod r 139')
 assert(zero_sign_same(q,{-3.0,17.0,0.0,0.0,-17.0,-3.0,-1.0},{true,false,false,false,true,true,true}),'divmod q signs 139')
 assert(zero_sign_same(r,{-4.0,0.0,1.0,5.0,-0.0,-1.0,-1.0},{true,false,false,false,true,true,true}),'divmod r signs 139')
end
do
 local a=np.array({1,17,5,17,17,0,5},np.uint64)
 local b=np.array({7.0,-2.0,-7.0,7.0,7.0,-1.0,2.0},np.float32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 140')
 assert(list_same(q:tolist(),{0.0,-9.0,-1.0,2.0,2.0,-0.0,2.0},5e-12),'divmod q 140')
 assert(list_same(r:tolist(),{1.0,-1.0,-2.0,3.0,3.0,-0.0,1.0},5e-12),'divmod r 140')
 assert(zero_sign_same(q,{0.0,-9.0,-1.0,2.0,2.0,-0.0,2.0},{false,true,true,false,false,true,false}),'divmod q signs 140')
 assert(zero_sign_same(r,{1.0,-1.0,-2.0,3.0,3.0,-0.0,1.0},{false,true,true,false,false,true,false}),'divmod r signs 140')
end
do
 local a=np.array({17,5,0,0,1,5,17},np.uint64)
 local b=np.array({1.0,2.0,7.0,1.0,-7.0,1.0,-7.0},np.float64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 141')
 assert(list_same(q:tolist(),{17.0,2.0,0.0,0.0,-1.0,5.0,-3.0},5e-12),'divmod q 141')
 assert(list_same(r:tolist(),{0.0,1.0,0.0,0.0,-6.0,0.0,-4.0},5e-12),'divmod r 141')
 assert(zero_sign_same(q,{17.0,2.0,0.0,0.0,-1.0,5.0,-3.0},{false,false,false,false,true,false,true}),'divmod q signs 141')
 assert(zero_sign_same(r,{0.0,1.0,0.0,0.0,-6.0,0.0,-4.0},{false,false,false,false,true,false,true}),'divmod r signs 141')
end
do
 local a=np.array({17,0,1,5,5,5,0},np.uint64)
 local b=np.array({1.0,1.0,7.0,-2.0,-2.0,-2.0,7.0},np.longdouble)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 142')
 assert(list_same(q:tolist(),{17.0,0.0,0.0,-3.0,-3.0,-3.0,0.0},5e-12),'divmod q 142')
 assert(list_same(r:tolist(),{0.0,0.0,1.0,-1.0,-1.0,-1.0,0.0},5e-12),'divmod r 142')
 assert(zero_sign_same(q,{17.0,0.0,0.0,-3.0,-3.0,-3.0,0.0},{false,false,false,true,true,true,false}),'divmod q signs 142')
 assert(zero_sign_same(r,{0.0,0.0,1.0,-1.0,-1.0,-1.0,0.0},{false,false,false,true,true,true,false}),'divmod r signs 142')
end
do
 local a=np.array({5.0,0.0,1.0,5.0,-1.0,1.0,-5.0},np.float16)
 local b=np.array({true,true,true,true,true,true,true},np.bool)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float16' and r.dtype=='float16','divmod dtype 143')
 assert(list_same(q:tolist(),{5.0,0.0,1.0,5.0,-1.0,1.0,-5.0},0.004),'divmod q 143')
 assert(list_same(r:tolist(),{0.0,0.0,0.0,0.0,0.0,0.0,0.0},0.004),'divmod r 143')
 assert(zero_sign_same(q,{5.0,0.0,1.0,5.0,-1.0,1.0,-5.0},{false,false,false,false,true,false,true}),'divmod q signs 143')
 assert(zero_sign_same(r,{0.0,0.0,0.0,0.0,0.0,0.0,0.0},{false,false,false,false,false,false,false}),'divmod r signs 143')
end
do
 local a=np.array({1.0,-5.0,0.0,17.0,5.0,-5.0,-17.0},np.float16)
 local b=np.array({-1,1,7,2,7,-1,1},np.int8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float16' and r.dtype=='float16','divmod dtype 144')
 assert(list_same(q:tolist(),{-1.0,-5.0,0.0,8.0,0.0,5.0,-17.0},0.004),'divmod q 144')
 assert(list_same(r:tolist(),{-0.0,0.0,0.0,1.0,5.0,-0.0,0.0},0.004),'divmod r 144')
 assert(zero_sign_same(q,{-1.0,-5.0,0.0,8.0,0.0,5.0,-17.0},{true,true,false,false,false,false,true}),'divmod q signs 144')
 assert(zero_sign_same(r,{-0.0,0.0,0.0,1.0,5.0,-0.0,0.0},{true,false,false,false,false,true,false}),'divmod r signs 144')
end
do
 local a=np.array({17.0,-1.0,17.0,-17.0,1.0,1.0,0.0},np.float16)
 local b=np.array({2,7,1,1,2,1,2},np.uint8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float16' and r.dtype=='float16','divmod dtype 145')
 assert(list_same(q:tolist(),{8.0,-1.0,17.0,-17.0,0.0,1.0,0.0},0.004),'divmod q 145')
 assert(list_same(r:tolist(),{1.0,6.0,0.0,0.0,1.0,0.0,0.0},0.004),'divmod r 145')
 assert(zero_sign_same(q,{8.0,-1.0,17.0,-17.0,0.0,1.0,0.0},{false,true,false,true,false,false,false}),'divmod q signs 145')
 assert(zero_sign_same(r,{1.0,6.0,0.0,0.0,1.0,0.0,0.0},{false,false,false,false,false,false,false}),'divmod r signs 145')
end
do
 local a=np.array({1.0,5.0,0.0,17.0,5.0,-1.0,-1.0},np.float16)
 local b=np.array({7,-7,-2,7,7,-1,-1},np.int16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float32' and r.dtype=='float32','divmod dtype 146')
 assert(list_same(q:tolist(),{0.0,-1.0,-0.0,2.0,0.0,1.0,1.0},5e-06),'divmod q 146')
 assert(list_same(r:tolist(),{1.0,-2.0,-0.0,3.0,5.0,-0.0,-0.0},5e-06),'divmod r 146')
 assert(zero_sign_same(q,{0.0,-1.0,-0.0,2.0,0.0,1.0,1.0},{false,true,true,false,false,false,false}),'divmod q signs 146')
 assert(zero_sign_same(r,{1.0,-2.0,-0.0,3.0,5.0,-0.0,-0.0},{false,true,true,false,false,true,true}),'divmod r signs 146')
end
do
 local a=np.array({1.0,-1.0,1.0,-1.0,0.0,-5.0,0.0},np.float16)
 local b=np.array({2,1,1,1,2,7,1},np.uint16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float32' and r.dtype=='float32','divmod dtype 147')
 assert(list_same(q:tolist(),{0.0,-1.0,1.0,-1.0,0.0,-1.0,0.0},5e-06),'divmod q 147')
 assert(list_same(r:tolist(),{1.0,0.0,0.0,0.0,0.0,2.0,0.0},5e-06),'divmod r 147')
 assert(zero_sign_same(q,{0.0,-1.0,1.0,-1.0,0.0,-1.0,0.0},{false,true,false,true,false,true,false}),'divmod q signs 147')
 assert(zero_sign_same(r,{1.0,0.0,0.0,0.0,0.0,2.0,0.0},{false,false,false,false,false,false,false}),'divmod r signs 147')
end
do
 local a=np.array({0.0,-5.0,-17.0,17.0,-5.0,-17.0,0.0},np.float16)
 local b=np.array({2,1,-7,-1,2,-2,2},np.int32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 148')
 assert(list_same(q:tolist(),{0.0,-5.0,2.0,-17.0,-3.0,8.0,0.0},5e-12),'divmod q 148')
 assert(list_same(r:tolist(),{0.0,0.0,-3.0,-0.0,1.0,-1.0,0.0},5e-12),'divmod r 148')
 assert(zero_sign_same(q,{0.0,-5.0,2.0,-17.0,-3.0,8.0,0.0},{false,true,false,true,true,false,false}),'divmod q signs 148')
 assert(zero_sign_same(r,{0.0,0.0,-3.0,-0.0,1.0,-1.0,0.0},{false,false,true,true,false,true,false}),'divmod r signs 148')
end
do
 local a=np.array({-17.0,1.0,-1.0,5.0,-17.0,1.0,-1.0},np.float16)
 local b=np.array({2,1,1,7,2,2,1},np.uint32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 149')
 assert(list_same(q:tolist(),{-9.0,1.0,-1.0,0.0,-9.0,0.0,-1.0},5e-12),'divmod q 149')
 assert(list_same(r:tolist(),{1.0,0.0,0.0,5.0,1.0,1.0,0.0},5e-12),'divmod r 149')
 assert(zero_sign_same(q,{-9.0,1.0,-1.0,0.0,-9.0,0.0,-1.0},{true,false,true,false,true,false,true}),'divmod q signs 149')
 assert(zero_sign_same(r,{1.0,0.0,0.0,5.0,1.0,1.0,0.0},{false,false,false,false,false,false,false}),'divmod r signs 149')
end
do
 local a=np.array({17.0,0.0,0.0,5.0,5.0,5.0,-1.0},np.float16)
 local b=np.array({1,-7,-1,-1,2,2,-1},np.int64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 150')
 assert(list_same(q:tolist(),{17.0,-0.0,-0.0,-5.0,2.0,2.0,1.0},5e-12),'divmod q 150')
 assert(list_same(r:tolist(),{0.0,-0.0,-0.0,-0.0,1.0,1.0,-0.0},5e-12),'divmod r 150')
 assert(zero_sign_same(q,{17.0,-0.0,-0.0,-5.0,2.0,2.0,1.0},{false,true,true,true,false,false,false}),'divmod q signs 150')
 assert(zero_sign_same(r,{0.0,-0.0,-0.0,-0.0,1.0,1.0,-0.0},{false,true,true,true,false,false,true}),'divmod r signs 150')
end
do
 local a=np.array({1.0,-5.0,5.0,-17.0,-5.0,-17.0,5.0},np.float16)
 local b=np.array({1,2,1,1,2,7,1},np.uint64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 151')
 assert(list_same(q:tolist(),{1.0,-3.0,5.0,-17.0,-3.0,-3.0,5.0},5e-12),'divmod q 151')
 assert(list_same(r:tolist(),{0.0,1.0,0.0,0.0,1.0,4.0,0.0},5e-12),'divmod r 151')
 assert(zero_sign_same(q,{1.0,-3.0,5.0,-17.0,-3.0,-3.0,5.0},{false,true,false,true,true,true,false}),'divmod q signs 151')
 assert(zero_sign_same(r,{0.0,1.0,0.0,0.0,1.0,4.0,0.0},{false,false,false,false,false,false,false}),'divmod r signs 151')
end
do
 local a=np.array({17.0,-17.0,-1.0,-5.0,1.0,-1.0,5.0},np.float16)
 local b=np.array({2.0,-7.0,7.0,1.0,1.0,-1.0,2.0},np.float16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float16' and r.dtype=='float16','divmod dtype 152')
 assert(list_same(q:tolist(),{8.0,2.0,-1.0,-5.0,1.0,1.0,2.0},0.004),'divmod q 152')
 assert(list_same(r:tolist(),{1.0,-3.0,6.0,0.0,0.0,-0.0,1.0},0.004),'divmod r 152')
 assert(zero_sign_same(q,{8.0,2.0,-1.0,-5.0,1.0,1.0,2.0},{false,false,true,true,false,false,false}),'divmod q signs 152')
 assert(zero_sign_same(r,{1.0,-3.0,6.0,0.0,0.0,-0.0,1.0},{false,true,false,false,false,true,false}),'divmod r signs 152')
end
do
 local a=np.array({-5.0,0.0,-5.0,-5.0,-5.0,-17.0,5.0},np.float16)
 local b=np.array({-7.0,1.0,-1.0,2.0,-7.0,2.0,-7.0},np.float32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float32' and r.dtype=='float32','divmod dtype 153')
 assert(list_same(q:tolist(),{0.0,0.0,5.0,-3.0,0.0,-9.0,-1.0},5e-06),'divmod q 153')
 assert(list_same(r:tolist(),{-5.0,0.0,-0.0,1.0,-5.0,1.0,-2.0},5e-06),'divmod r 153')
 assert(zero_sign_same(q,{0.0,0.0,5.0,-3.0,0.0,-9.0,-1.0},{false,false,false,true,false,true,true}),'divmod q signs 153')
 assert(zero_sign_same(r,{-5.0,0.0,-0.0,1.0,-5.0,1.0,-2.0},{true,false,true,false,true,false,true}),'divmod r signs 153')
end
do
 local a=np.array({1.0,17.0,17.0,1.0,-17.0,1.0,-17.0},np.float16)
 local b=np.array({1.0,-1.0,2.0,-1.0,2.0,2.0,-2.0},np.float64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 154')
 assert(list_same(q:tolist(),{1.0,-17.0,8.0,-1.0,-9.0,0.0,8.0},5e-12),'divmod q 154')
 assert(list_same(r:tolist(),{0.0,-0.0,1.0,-0.0,1.0,1.0,-1.0},5e-12),'divmod r 154')
 assert(zero_sign_same(q,{1.0,-17.0,8.0,-1.0,-9.0,0.0,8.0},{false,true,false,true,true,false,false}),'divmod q signs 154')
 assert(zero_sign_same(r,{0.0,-0.0,1.0,-0.0,1.0,1.0,-1.0},{false,true,false,true,false,false,true}),'divmod r signs 154')
end
do
 local a=np.array({-17.0,1.0,-1.0,-1.0,0.0,0.0,-1.0},np.float16)
 local b=np.array({7.0,7.0,1.0,-2.0,-1.0,-1.0,2.0},np.longdouble)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 155')
 assert(list_same(q:tolist(),{-3.0,0.0,-1.0,0.0,-0.0,-0.0,-1.0},5e-12),'divmod q 155')
 assert(list_same(r:tolist(),{4.0,1.0,0.0,-1.0,-0.0,-0.0,1.0},5e-12),'divmod r 155')
 assert(zero_sign_same(q,{-3.0,0.0,-1.0,0.0,-0.0,-0.0,-1.0},{true,false,true,false,true,true,true}),'divmod q signs 155')
 assert(zero_sign_same(r,{4.0,1.0,0.0,-1.0,-0.0,-0.0,1.0},{false,false,false,true,true,true,false}),'divmod r signs 155')
end
do
 local a=np.array({-5.0,1.0,17.0,-1.0,17.0,-17.0,17.0},np.float32)
 local b=np.array({true,true,true,true,true,true,true},np.bool)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float32' and r.dtype=='float32','divmod dtype 156')
 assert(list_same(q:tolist(),{-5.0,1.0,17.0,-1.0,17.0,-17.0,17.0},5e-06),'divmod q 156')
 assert(list_same(r:tolist(),{0.0,0.0,0.0,0.0,0.0,0.0,0.0},5e-06),'divmod r 156')
 assert(zero_sign_same(q,{-5.0,1.0,17.0,-1.0,17.0,-17.0,17.0},{true,false,false,true,false,true,false}),'divmod q signs 156')
 assert(zero_sign_same(r,{0.0,0.0,0.0,0.0,0.0,0.0,0.0},{false,false,false,false,false,false,false}),'divmod r signs 156')
end
do
 local a=np.array({-5.0,0.0,5.0,-5.0,5.0,17.0,-17.0},np.float32)
 local b=np.array({2,-7,7,-2,1,7,-7},np.int8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float32' and r.dtype=='float32','divmod dtype 157')
 assert(list_same(q:tolist(),{-3.0,-0.0,0.0,2.0,5.0,2.0,2.0},5e-06),'divmod q 157')
 assert(list_same(r:tolist(),{1.0,-0.0,5.0,-1.0,0.0,3.0,-3.0},5e-06),'divmod r 157')
 assert(zero_sign_same(q,{-3.0,-0.0,0.0,2.0,5.0,2.0,2.0},{true,true,false,false,false,false,false}),'divmod q signs 157')
 assert(zero_sign_same(r,{1.0,-0.0,5.0,-1.0,0.0,3.0,-3.0},{false,true,false,true,false,false,true}),'divmod r signs 157')
end
do
 local a=np.array({0.0,-17.0,-17.0,17.0,-1.0,-1.0,-1.0},np.float32)
 local b=np.array({2,7,1,1,2,2,2},np.uint8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float32' and r.dtype=='float32','divmod dtype 158')
 assert(list_same(q:tolist(),{0.0,-3.0,-17.0,17.0,-1.0,-1.0,-1.0},5e-06),'divmod q 158')
 assert(list_same(r:tolist(),{0.0,4.0,0.0,0.0,1.0,1.0,1.0},5e-06),'divmod r 158')
 assert(zero_sign_same(q,{0.0,-3.0,-17.0,17.0,-1.0,-1.0,-1.0},{false,true,true,false,true,true,true}),'divmod q signs 158')
 assert(zero_sign_same(r,{0.0,4.0,0.0,0.0,1.0,1.0,1.0},{false,false,false,false,false,false,false}),'divmod r signs 158')
end
do
 local a=np.array({0.0,-17.0,-17.0,-5.0,17.0,0.0,5.0},np.float32)
 local b=np.array({7,-2,-2,-1,2,-7,1},np.int16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float32' and r.dtype=='float32','divmod dtype 159')
 assert(list_same(q:tolist(),{0.0,8.0,8.0,5.0,8.0,-0.0,5.0},5e-06),'divmod q 159')
 assert(list_same(r:tolist(),{0.0,-1.0,-1.0,-0.0,1.0,-0.0,0.0},5e-06),'divmod r 159')
 assert(zero_sign_same(q,{0.0,8.0,8.0,5.0,8.0,-0.0,5.0},{false,false,false,false,false,true,false}),'divmod q signs 159')
 assert(zero_sign_same(r,{0.0,-1.0,-1.0,-0.0,1.0,-0.0,0.0},{false,true,true,true,false,true,false}),'divmod r signs 159')
end
do
 local a=np.array({1.0,0.0,1.0,1.0,-17.0,-17.0,17.0},np.float32)
 local b=np.array({2,7,1,1,2,1,7},np.uint16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float32' and r.dtype=='float32','divmod dtype 160')
 assert(list_same(q:tolist(),{0.0,0.0,1.0,1.0,-9.0,-17.0,2.0},5e-06),'divmod q 160')
 assert(list_same(r:tolist(),{1.0,0.0,0.0,0.0,1.0,0.0,3.0},5e-06),'divmod r 160')
 assert(zero_sign_same(q,{0.0,0.0,1.0,1.0,-9.0,-17.0,2.0},{false,false,false,false,true,true,false}),'divmod q signs 160')
 assert(zero_sign_same(r,{1.0,0.0,0.0,0.0,1.0,0.0,3.0},{false,false,false,false,false,false,false}),'divmod r signs 160')
end
do
 local a=np.array({-5.0,-17.0,-17.0,1.0,-17.0,-1.0,-17.0},np.float32)
 local b=np.array({2,1,1,-2,2,1,2},np.int32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 161')
 assert(list_same(q:tolist(),{-3.0,-17.0,-17.0,-1.0,-9.0,-1.0,-9.0},5e-12),'divmod q 161')
 assert(list_same(r:tolist(),{1.0,0.0,0.0,-1.0,1.0,0.0,1.0},5e-12),'divmod r 161')
 assert(zero_sign_same(q,{-3.0,-17.0,-17.0,-1.0,-9.0,-1.0,-9.0},{true,true,true,true,true,true,true}),'divmod q signs 161')
 assert(zero_sign_same(r,{1.0,0.0,0.0,-1.0,1.0,0.0,1.0},{false,false,false,true,false,false,false}),'divmod r signs 161')
end
do
 local a=np.array({1.0,1.0,5.0,17.0,-17.0,1.0,-1.0},np.float32)
 local b=np.array({7,1,1,7,1,2,1},np.uint32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 162')
 assert(list_same(q:tolist(),{0.0,1.0,5.0,2.0,-17.0,0.0,-1.0},5e-12),'divmod q 162')
 assert(list_same(r:tolist(),{1.0,0.0,0.0,3.0,0.0,1.0,0.0},5e-12),'divmod r 162')
 assert(zero_sign_same(q,{0.0,1.0,5.0,2.0,-17.0,0.0,-1.0},{false,false,false,false,true,false,true}),'divmod q signs 162')
 assert(zero_sign_same(r,{1.0,0.0,0.0,3.0,0.0,1.0,0.0},{false,false,false,false,false,false,false}),'divmod r signs 162')
end
do
 local a=np.array({-1.0,1.0,17.0,17.0,0.0,0.0,0.0},np.float32)
 local b=np.array({-7,7,-7,1,-2,-7,7},np.int64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 163')
 assert(list_same(q:tolist(),{0.0,0.0,-3.0,17.0,-0.0,-0.0,0.0},5e-12),'divmod q 163')
 assert(list_same(r:tolist(),{-1.0,1.0,-4.0,0.0,-0.0,-0.0,0.0},5e-12),'divmod r 163')
 assert(zero_sign_same(q,{0.0,0.0,-3.0,17.0,-0.0,-0.0,0.0},{false,false,true,false,true,true,false}),'divmod q signs 163')
 assert(zero_sign_same(r,{-1.0,1.0,-4.0,0.0,-0.0,-0.0,0.0},{true,false,true,false,true,true,false}),'divmod r signs 163')
end
do
 local a=np.array({1.0,1.0,17.0,0.0,-17.0,0.0,5.0},np.float32)
 local b=np.array({2,1,1,2,1,1,1},np.uint64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 164')
 assert(list_same(q:tolist(),{0.0,1.0,17.0,0.0,-17.0,0.0,5.0},5e-12),'divmod q 164')
 assert(list_same(r:tolist(),{1.0,0.0,0.0,0.0,0.0,0.0,0.0},5e-12),'divmod r 164')
 assert(zero_sign_same(q,{0.0,1.0,17.0,0.0,-17.0,0.0,5.0},{false,false,false,false,true,false,false}),'divmod q signs 164')
 assert(zero_sign_same(r,{1.0,0.0,0.0,0.0,0.0,0.0,0.0},{false,false,false,false,false,false,false}),'divmod r signs 164')
end
do
 local a=np.array({-1.0,1.0,5.0,-1.0,5.0,0.0,-5.0},np.float32)
 local b=np.array({-2.0,1.0,2.0,7.0,-7.0,-2.0,2.0},np.float16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float32' and r.dtype=='float32','divmod dtype 165')
 assert(list_same(q:tolist(),{0.0,1.0,2.0,-1.0,-1.0,-0.0,-3.0},5e-06),'divmod q 165')
 assert(list_same(r:tolist(),{-1.0,0.0,1.0,6.0,-2.0,-0.0,1.0},5e-06),'divmod r 165')
 assert(zero_sign_same(q,{0.0,1.0,2.0,-1.0,-1.0,-0.0,-3.0},{false,false,false,true,true,true,true}),'divmod q signs 165')
 assert(zero_sign_same(r,{-1.0,0.0,1.0,6.0,-2.0,-0.0,1.0},{true,false,false,false,true,true,false}),'divmod r signs 165')
end
do
 local a=np.array({17.0,-17.0,17.0,1.0,17.0,1.0,-17.0},np.float32)
 local b=np.array({-2.0,-1.0,7.0,-1.0,-7.0,-2.0,1.0},np.float32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float32' and r.dtype=='float32','divmod dtype 166')
 assert(list_same(q:tolist(),{-9.0,17.0,2.0,-1.0,-3.0,-1.0,-17.0},5e-06),'divmod q 166')
 assert(list_same(r:tolist(),{-1.0,-0.0,3.0,-0.0,-4.0,-1.0,0.0},5e-06),'divmod r 166')
 assert(zero_sign_same(q,{-9.0,17.0,2.0,-1.0,-3.0,-1.0,-17.0},{true,false,false,true,true,true,true}),'divmod q signs 166')
 assert(zero_sign_same(r,{-1.0,-0.0,3.0,-0.0,-4.0,-1.0,0.0},{true,true,false,true,true,true,false}),'divmod r signs 166')
end
do
 local a=np.array({5.0,-5.0,-17.0,1.0,-1.0,17.0,-17.0},np.float32)
 local b=np.array({-2.0,-2.0,-2.0,-1.0,-1.0,-2.0,2.0},np.float64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 167')
 assert(list_same(q:tolist(),{-3.0,2.0,8.0,-1.0,1.0,-9.0,-9.0},5e-12),'divmod q 167')
 assert(list_same(r:tolist(),{-1.0,-1.0,-1.0,-0.0,-0.0,-1.0,1.0},5e-12),'divmod r 167')
 assert(zero_sign_same(q,{-3.0,2.0,8.0,-1.0,1.0,-9.0,-9.0},{true,false,false,true,false,true,true}),'divmod q signs 167')
 assert(zero_sign_same(r,{-1.0,-1.0,-1.0,-0.0,-0.0,-1.0,1.0},{true,true,true,true,true,true,false}),'divmod r signs 167')
end
do
 local a=np.array({-1.0,-17.0,5.0,17.0,-17.0,1.0,-1.0},np.float32)
 local b=np.array({7.0,7.0,-2.0,-7.0,2.0,-7.0,7.0},np.longdouble)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 168')
 assert(list_same(q:tolist(),{-1.0,-3.0,-3.0,-3.0,-9.0,-1.0,-1.0},5e-12),'divmod q 168')
 assert(list_same(r:tolist(),{6.0,4.0,-1.0,-4.0,1.0,-6.0,6.0},5e-12),'divmod r 168')
 assert(zero_sign_same(q,{-1.0,-3.0,-3.0,-3.0,-9.0,-1.0,-1.0},{true,true,true,true,true,true,true}),'divmod q signs 168')
 assert(zero_sign_same(r,{6.0,4.0,-1.0,-4.0,1.0,-6.0,6.0},{false,false,true,true,false,true,false}),'divmod r signs 168')
end
do
 local a=np.array({5.0,-1.0,5.0,1.0,0.0,0.0,1.0},np.float64)
 local b=np.array({true,true,true,true,true,true,true},np.bool)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 169')
 assert(list_same(q:tolist(),{5.0,-1.0,5.0,1.0,0.0,0.0,1.0},5e-12),'divmod q 169')
 assert(list_same(r:tolist(),{0.0,0.0,0.0,0.0,0.0,0.0,0.0},5e-12),'divmod r 169')
 assert(zero_sign_same(q,{5.0,-1.0,5.0,1.0,0.0,0.0,1.0},{false,true,false,false,false,false,false}),'divmod q signs 169')
 assert(zero_sign_same(r,{0.0,0.0,0.0,0.0,0.0,0.0,0.0},{false,false,false,false,false,false,false}),'divmod r signs 169')
end
do
 local a=np.array({5.0,17.0,1.0,5.0,5.0,-1.0,17.0},np.float64)
 local b=np.array({7,-7,-7,-1,7,-1,-7},np.int8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 170')
 assert(list_same(q:tolist(),{0.0,-3.0,-1.0,-5.0,0.0,1.0,-3.0},5e-12),'divmod q 170')
 assert(list_same(r:tolist(),{5.0,-4.0,-6.0,-0.0,5.0,-0.0,-4.0},5e-12),'divmod r 170')
 assert(zero_sign_same(q,{0.0,-3.0,-1.0,-5.0,0.0,1.0,-3.0},{false,true,true,true,false,false,true}),'divmod q signs 170')
 assert(zero_sign_same(r,{5.0,-4.0,-6.0,-0.0,5.0,-0.0,-4.0},{false,true,true,true,false,true,true}),'divmod r signs 170')
end
do
 local a=np.array({-17.0,-17.0,-1.0,5.0,-17.0,-5.0,-17.0},np.float64)
 local b=np.array({2,1,7,7,7,2,1},np.uint8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 171')
 assert(list_same(q:tolist(),{-9.0,-17.0,-1.0,0.0,-3.0,-3.0,-17.0},5e-12),'divmod q 171')
 assert(list_same(r:tolist(),{1.0,0.0,6.0,5.0,4.0,1.0,0.0},5e-12),'divmod r 171')
 assert(zero_sign_same(q,{-9.0,-17.0,-1.0,0.0,-3.0,-3.0,-17.0},{true,true,true,false,true,true,true}),'divmod q signs 171')
 assert(zero_sign_same(r,{1.0,0.0,6.0,5.0,4.0,1.0,0.0},{false,false,false,false,false,false,false}),'divmod r signs 171')
end
do
 local a=np.array({5.0,1.0,17.0,5.0,5.0,0.0,-1.0},np.float64)
 local b=np.array({2,2,-1,-7,7,1,-7},np.int16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 172')
 assert(list_same(q:tolist(),{2.0,0.0,-17.0,-1.0,0.0,0.0,0.0},5e-12),'divmod q 172')
 assert(list_same(r:tolist(),{1.0,1.0,-0.0,-2.0,5.0,0.0,-1.0},5e-12),'divmod r 172')
 assert(zero_sign_same(q,{2.0,0.0,-17.0,-1.0,0.0,0.0,0.0},{false,false,true,true,false,false,false}),'divmod q signs 172')
 assert(zero_sign_same(r,{1.0,1.0,-0.0,-2.0,5.0,0.0,-1.0},{false,false,true,true,false,false,true}),'divmod r signs 172')
end
do
 local a=np.array({-17.0,-1.0,17.0,0.0,17.0,5.0,-1.0},np.float64)
 local b=np.array({1,2,7,2,1,2,7},np.uint16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 173')
 assert(list_same(q:tolist(),{-17.0,-1.0,2.0,0.0,17.0,2.0,-1.0},5e-12),'divmod q 173')
 assert(list_same(r:tolist(),{0.0,1.0,3.0,0.0,0.0,1.0,6.0},5e-12),'divmod r 173')
 assert(zero_sign_same(q,{-17.0,-1.0,2.0,0.0,17.0,2.0,-1.0},{true,true,false,false,false,false,true}),'divmod q signs 173')
 assert(zero_sign_same(r,{0.0,1.0,3.0,0.0,0.0,1.0,6.0},{false,false,false,false,false,false,false}),'divmod r signs 173')
end
do
 local a=np.array({-5.0,5.0,-5.0,-1.0,17.0,0.0,5.0},np.float64)
 local b=np.array({-2,7,-7,-7,-7,-7,-2},np.int32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 174')
 assert(list_same(q:tolist(),{2.0,0.0,0.0,0.0,-3.0,-0.0,-3.0},5e-12),'divmod q 174')
 assert(list_same(r:tolist(),{-1.0,5.0,-5.0,-1.0,-4.0,-0.0,-1.0},5e-12),'divmod r 174')
 assert(zero_sign_same(q,{2.0,0.0,0.0,0.0,-3.0,-0.0,-3.0},{false,false,false,false,true,true,true}),'divmod q signs 174')
 assert(zero_sign_same(r,{-1.0,5.0,-5.0,-1.0,-4.0,-0.0,-1.0},{true,false,true,true,true,true,true}),'divmod r signs 174')
end
do
 local a=np.array({1.0,5.0,-17.0,1.0,0.0,-1.0,5.0},np.float64)
 local b=np.array({1,1,7,7,1,1,7},np.uint32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 175')
 assert(list_same(q:tolist(),{1.0,5.0,-3.0,0.0,0.0,-1.0,0.0},5e-12),'divmod q 175')
 assert(list_same(r:tolist(),{0.0,0.0,4.0,1.0,0.0,0.0,5.0},5e-12),'divmod r 175')
 assert(zero_sign_same(q,{1.0,5.0,-3.0,0.0,0.0,-1.0,0.0},{false,false,true,false,false,true,false}),'divmod q signs 175')
 assert(zero_sign_same(r,{0.0,0.0,4.0,1.0,0.0,0.0,5.0},{false,false,false,false,false,false,false}),'divmod r signs 175')
end
do
 local a=np.array({-17.0,0.0,-5.0,17.0,-17.0,5.0,0.0},np.float64)
 local b=np.array({1,-1,7,-1,-2,-7,7},np.int64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 176')
 assert(list_same(q:tolist(),{-17.0,-0.0,-1.0,-17.0,8.0,-1.0,0.0},5e-12),'divmod q 176')
 assert(list_same(r:tolist(),{0.0,-0.0,2.0,-0.0,-1.0,-2.0,0.0},5e-12),'divmod r 176')
 assert(zero_sign_same(q,{-17.0,-0.0,-1.0,-17.0,8.0,-1.0,0.0},{true,true,true,true,false,true,false}),'divmod q signs 176')
 assert(zero_sign_same(r,{0.0,-0.0,2.0,-0.0,-1.0,-2.0,0.0},{false,true,false,true,true,true,false}),'divmod r signs 176')
end
do
 local a=np.array({1.0,-17.0,17.0,0.0,1.0,-1.0,1.0},np.float64)
 local b=np.array({1,1,7,1,1,2,7},np.uint64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 177')
 assert(list_same(q:tolist(),{1.0,-17.0,2.0,0.0,1.0,-1.0,0.0},5e-12),'divmod q 177')
 assert(list_same(r:tolist(),{0.0,0.0,3.0,0.0,0.0,1.0,1.0},5e-12),'divmod r 177')
 assert(zero_sign_same(q,{1.0,-17.0,2.0,0.0,1.0,-1.0,0.0},{false,true,false,false,false,true,false}),'divmod q signs 177')
 assert(zero_sign_same(r,{0.0,0.0,3.0,0.0,0.0,1.0,1.0},{false,false,false,false,false,false,false}),'divmod r signs 177')
end
do
 local a=np.array({-1.0,0.0,-17.0,-1.0,0.0,-5.0,5.0},np.float64)
 local b=np.array({2.0,-1.0,1.0,-1.0,-1.0,1.0,-7.0},np.float16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 178')
 assert(list_same(q:tolist(),{-1.0,-0.0,-17.0,1.0,-0.0,-5.0,-1.0},5e-12),'divmod q 178')
 assert(list_same(r:tolist(),{1.0,-0.0,0.0,-0.0,-0.0,0.0,-2.0},5e-12),'divmod r 178')
 assert(zero_sign_same(q,{-1.0,-0.0,-17.0,1.0,-0.0,-5.0,-1.0},{true,true,true,false,true,true,true}),'divmod q signs 178')
 assert(zero_sign_same(r,{1.0,-0.0,0.0,-0.0,-0.0,0.0,-2.0},{false,true,false,true,true,false,true}),'divmod r signs 178')
end
do
 local a=np.array({5.0,1.0,-5.0,5.0,1.0,5.0,0.0},np.float64)
 local b=np.array({-7.0,1.0,2.0,-7.0,-2.0,-2.0,2.0},np.float32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 179')
 assert(list_same(q:tolist(),{-1.0,1.0,-3.0,-1.0,-1.0,-3.0,0.0},5e-12),'divmod q 179')
 assert(list_same(r:tolist(),{-2.0,0.0,1.0,-2.0,-1.0,-1.0,0.0},5e-12),'divmod r 179')
 assert(zero_sign_same(q,{-1.0,1.0,-3.0,-1.0,-1.0,-3.0,0.0},{true,false,true,true,true,true,false}),'divmod q signs 179')
 assert(zero_sign_same(r,{-2.0,0.0,1.0,-2.0,-1.0,-1.0,0.0},{true,false,false,true,true,true,false}),'divmod r signs 179')
end
do
 local a=np.array({5.0,5.0,-17.0,0.0,-5.0,0.0,5.0},np.float64)
 local b=np.array({7.0,-2.0,-1.0,-1.0,7.0,-1.0,-7.0},np.float64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','divmod dtype 180')
 assert(list_same(q:tolist(),{0.0,-3.0,17.0,-0.0,-1.0,-0.0,-1.0},5e-12),'divmod q 180')
 assert(list_same(r:tolist(),{5.0,-1.0,-0.0,-0.0,2.0,-0.0,-2.0},5e-12),'divmod r 180')
 assert(zero_sign_same(q,{0.0,-3.0,17.0,-0.0,-1.0,-0.0,-1.0},{false,true,false,true,true,true,true}),'divmod q signs 180')
 assert(zero_sign_same(r,{5.0,-1.0,-0.0,-0.0,2.0,-0.0,-2.0},{false,true,true,true,false,true,true}),'divmod r signs 180')
end
do
 local a=np.array({-17.0,0.0,-17.0,5.0,17.0,1.0,-5.0},np.float64)
 local b=np.array({1.0,-1.0,-7.0,-7.0,-1.0,-2.0,-7.0},np.longdouble)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 181')
 assert(list_same(q:tolist(),{-17.0,-0.0,2.0,-1.0,-17.0,-1.0,0.0},5e-12),'divmod q 181')
 assert(list_same(r:tolist(),{0.0,-0.0,-3.0,-2.0,-0.0,-1.0,-5.0},5e-12),'divmod r 181')
 assert(zero_sign_same(q,{-17.0,-0.0,2.0,-1.0,-17.0,-1.0,0.0},{true,true,false,true,true,true,false}),'divmod q signs 181')
 assert(zero_sign_same(r,{0.0,-0.0,-3.0,-2.0,-0.0,-1.0,-5.0},{false,true,true,true,true,true,true}),'divmod r signs 181')
end
do
 local a=np.array({-1.0,-5.0,17.0,-1.0,5.0,-1.0,0.0},np.longdouble)
 local b=np.array({true,true,true,true,true,true,true},np.bool)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 182')
 assert(list_same(q:tolist(),{-1.0,-5.0,17.0,-1.0,5.0,-1.0,0.0},5e-12),'divmod q 182')
 assert(list_same(r:tolist(),{0.0,0.0,0.0,0.0,0.0,0.0,0.0},5e-12),'divmod r 182')
 assert(zero_sign_same(q,{-1.0,-5.0,17.0,-1.0,5.0,-1.0,0.0},{true,true,false,true,false,true,false}),'divmod q signs 182')
 assert(zero_sign_same(r,{0.0,0.0,0.0,0.0,0.0,0.0,0.0},{false,false,false,false,false,false,false}),'divmod r signs 182')
end
do
 local a=np.array({5.0,1.0,5.0,-5.0,-1.0,-17.0,-17.0},np.longdouble)
 local b=np.array({1,-7,1,-7,7,-7,-7},np.int8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 183')
 assert(list_same(q:tolist(),{5.0,-1.0,5.0,0.0,-1.0,2.0,2.0},5e-12),'divmod q 183')
 assert(list_same(r:tolist(),{0.0,-6.0,0.0,-5.0,6.0,-3.0,-3.0},5e-12),'divmod r 183')
 assert(zero_sign_same(q,{5.0,-1.0,5.0,0.0,-1.0,2.0,2.0},{false,true,false,false,true,false,false}),'divmod q signs 183')
 assert(zero_sign_same(r,{0.0,-6.0,0.0,-5.0,6.0,-3.0,-3.0},{false,true,false,true,false,true,true}),'divmod r signs 183')
end
do
 local a=np.array({5.0,-1.0,-1.0,1.0,0.0,5.0,17.0},np.longdouble)
 local b=np.array({1,2,7,7,2,1,2},np.uint8)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 184')
 assert(list_same(q:tolist(),{5.0,-1.0,-1.0,0.0,0.0,5.0,8.0},5e-12),'divmod q 184')
 assert(list_same(r:tolist(),{0.0,1.0,6.0,1.0,0.0,0.0,1.0},5e-12),'divmod r 184')
 assert(zero_sign_same(q,{5.0,-1.0,-1.0,0.0,0.0,5.0,8.0},{false,true,true,false,false,false,false}),'divmod q signs 184')
 assert(zero_sign_same(r,{0.0,1.0,6.0,1.0,0.0,0.0,1.0},{false,false,false,false,false,false,false}),'divmod r signs 184')
end
do
 local a=np.array({5.0,-1.0,0.0,-17.0,-17.0,-17.0,5.0},np.longdouble)
 local b=np.array({-2,1,1,7,-2,2,-1},np.int16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 185')
 assert(list_same(q:tolist(),{-3.0,-1.0,0.0,-3.0,8.0,-9.0,-5.0},5e-12),'divmod q 185')
 assert(list_same(r:tolist(),{-1.0,0.0,0.0,4.0,-1.0,1.0,-0.0},5e-12),'divmod r 185')
 assert(zero_sign_same(q,{-3.0,-1.0,0.0,-3.0,8.0,-9.0,-5.0},{true,true,false,true,false,true,true}),'divmod q signs 185')
 assert(zero_sign_same(r,{-1.0,0.0,0.0,4.0,-1.0,1.0,-0.0},{true,false,false,false,true,false,true}),'divmod r signs 185')
end
do
 local a=np.array({0.0,0.0,1.0,17.0,-5.0,5.0,0.0},np.longdouble)
 local b=np.array({2,1,7,2,7,7,1},np.uint16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 186')
 assert(list_same(q:tolist(),{0.0,0.0,0.0,8.0,-1.0,0.0,0.0},5e-12),'divmod q 186')
 assert(list_same(r:tolist(),{0.0,0.0,1.0,1.0,2.0,5.0,0.0},5e-12),'divmod r 186')
 assert(zero_sign_same(q,{0.0,0.0,0.0,8.0,-1.0,0.0,0.0},{false,false,false,false,true,false,false}),'divmod q signs 186')
 assert(zero_sign_same(r,{0.0,0.0,1.0,1.0,2.0,5.0,0.0},{false,false,false,false,false,false,false}),'divmod r signs 186')
end
do
 local a=np.array({5.0,-17.0,1.0,1.0,0.0,-1.0,1.0},np.longdouble)
 local b=np.array({-2,-1,-2,2,-1,1,7},np.int32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 187')
 assert(list_same(q:tolist(),{-3.0,17.0,-1.0,0.0,-0.0,-1.0,0.0},5e-12),'divmod q 187')
 assert(list_same(r:tolist(),{-1.0,-0.0,-1.0,1.0,-0.0,0.0,1.0},5e-12),'divmod r 187')
 assert(zero_sign_same(q,{-3.0,17.0,-1.0,0.0,-0.0,-1.0,0.0},{true,false,true,false,true,true,false}),'divmod q signs 187')
 assert(zero_sign_same(r,{-1.0,-0.0,-1.0,1.0,-0.0,0.0,1.0},{true,true,true,false,true,false,false}),'divmod r signs 187')
end
do
 local a=np.array({-17.0,5.0,-17.0,17.0,1.0,-1.0,0.0},np.longdouble)
 local b=np.array({1,7,1,1,7,7,1},np.uint32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 188')
 assert(list_same(q:tolist(),{-17.0,0.0,-17.0,17.0,0.0,-1.0,0.0},5e-12),'divmod q 188')
 assert(list_same(r:tolist(),{0.0,5.0,0.0,0.0,1.0,6.0,0.0},5e-12),'divmod r 188')
 assert(zero_sign_same(q,{-17.0,0.0,-17.0,17.0,0.0,-1.0,0.0},{true,false,true,false,false,true,false}),'divmod q signs 188')
 assert(zero_sign_same(r,{0.0,5.0,0.0,0.0,1.0,6.0,0.0},{false,false,false,false,false,false,false}),'divmod r signs 188')
end
do
 local a=np.array({-17.0,-17.0,-1.0,-1.0,-5.0,0.0,0.0},np.longdouble)
 local b=np.array({1,-7,1,-2,2,2,1},np.int64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 189')
 assert(list_same(q:tolist(),{-17.0,2.0,-1.0,0.0,-3.0,0.0,0.0},5e-12),'divmod q 189')
 assert(list_same(r:tolist(),{0.0,-3.0,0.0,-1.0,1.0,0.0,0.0},5e-12),'divmod r 189')
 assert(zero_sign_same(q,{-17.0,2.0,-1.0,0.0,-3.0,0.0,0.0},{true,false,true,false,true,false,false}),'divmod q signs 189')
 assert(zero_sign_same(r,{0.0,-3.0,0.0,-1.0,1.0,0.0,0.0},{false,true,false,true,false,false,false}),'divmod r signs 189')
end
do
 local a=np.array({0.0,-1.0,-5.0,0.0,1.0,-5.0,17.0},np.longdouble)
 local b=np.array({1,7,7,1,7,7,2},np.uint64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 190')
 assert(list_same(q:tolist(),{0.0,-1.0,-1.0,0.0,0.0,-1.0,8.0},5e-12),'divmod q 190')
 assert(list_same(r:tolist(),{0.0,6.0,2.0,0.0,1.0,2.0,1.0},5e-12),'divmod r 190')
 assert(zero_sign_same(q,{0.0,-1.0,-1.0,0.0,0.0,-1.0,8.0},{false,true,true,false,false,true,false}),'divmod q signs 190')
 assert(zero_sign_same(r,{0.0,6.0,2.0,0.0,1.0,2.0,1.0},{false,false,false,false,false,false,false}),'divmod r signs 190')
end
do
 local a=np.array({0.0,5.0,17.0,0.0,17.0,5.0,-5.0},np.longdouble)
 local b=np.array({-1.0,1.0,-2.0,-7.0,1.0,-1.0,2.0},np.float16)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 191')
 assert(list_same(q:tolist(),{-0.0,5.0,-9.0,-0.0,17.0,-5.0,-3.0},5e-12),'divmod q 191')
 assert(list_same(r:tolist(),{-0.0,0.0,-1.0,-0.0,0.0,-0.0,1.0},5e-12),'divmod r 191')
 assert(zero_sign_same(q,{-0.0,5.0,-9.0,-0.0,17.0,-5.0,-3.0},{true,false,true,true,false,true,true}),'divmod q signs 191')
 assert(zero_sign_same(r,{-0.0,0.0,-1.0,-0.0,0.0,-0.0,1.0},{true,false,true,true,false,true,false}),'divmod r signs 191')
end
do
 local a=np.array({-1.0,0.0,1.0,17.0,-5.0,-17.0,5.0},np.longdouble)
 local b=np.array({-7.0,1.0,1.0,-2.0,7.0,7.0,-7.0},np.float32)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 192')
 assert(list_same(q:tolist(),{0.0,0.0,1.0,-9.0,-1.0,-3.0,-1.0},5e-12),'divmod q 192')
 assert(list_same(r:tolist(),{-1.0,0.0,0.0,-1.0,2.0,4.0,-2.0},5e-12),'divmod r 192')
 assert(zero_sign_same(q,{0.0,0.0,1.0,-9.0,-1.0,-3.0,-1.0},{false,false,false,true,true,true,true}),'divmod q signs 192')
 assert(zero_sign_same(r,{-1.0,0.0,0.0,-1.0,2.0,4.0,-2.0},{true,false,false,true,false,false,true}),'divmod r signs 192')
end
do
 local a=np.array({1.0,5.0,0.0,1.0,0.0,17.0,17.0},np.longdouble)
 local b=np.array({-2.0,-7.0,-2.0,-7.0,1.0,-2.0,-1.0},np.float64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 193')
 assert(list_same(q:tolist(),{-1.0,-1.0,-0.0,-1.0,0.0,-9.0,-17.0},5e-12),'divmod q 193')
 assert(list_same(r:tolist(),{-1.0,-2.0,-0.0,-6.0,0.0,-1.0,-0.0},5e-12),'divmod r 193')
 assert(zero_sign_same(q,{-1.0,-1.0,-0.0,-1.0,0.0,-9.0,-17.0},{true,true,true,true,false,true,true}),'divmod q signs 193')
 assert(zero_sign_same(r,{-1.0,-2.0,-0.0,-6.0,0.0,-1.0,-0.0},{true,true,true,true,false,true,true}),'divmod r signs 193')
end
do
 local a=np.array({-1.0,-17.0,1.0,0.0,0.0,-1.0,1.0},np.longdouble)
 local b=np.array({1.0,-2.0,-1.0,1.0,-1.0,-7.0,-1.0},np.longdouble)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='longdouble' and r.dtype=='longdouble','divmod dtype 194')
 assert(list_same(q:tolist(),{-1.0,8.0,-1.0,0.0,-0.0,0.0,-1.0},5e-12),'divmod q 194')
 assert(list_same(r:tolist(),{0.0,-1.0,-0.0,0.0,-0.0,-1.0,-0.0},5e-12),'divmod r 194')
 assert(zero_sign_same(q,{-1.0,8.0,-1.0,0.0,-0.0,0.0,-1.0},{true,false,true,false,true,false,true}),'divmod q signs 194')
 assert(zero_sign_same(r,{0.0,-1.0,-0.0,0.0,-0.0,-1.0,-0.0},{false,true,true,false,true,true,true}),'divmod r signs 194')
end
do
 local a=np.array({false,true},np.bool)
 local e=np.array({false,true},np.bool)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 195')
 assert(list_same(r:tolist(),{0.0,2.0},0.004),'ldexp values 195')
end
do
 local a=np.array({false,true},np.bool)
 local e=np.array({-3,-1},np.int8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 196')
 assert(list_same(r:tolist(),{0.0,0.5},0.004),'ldexp values 196')
end
do
 local a=np.array({false,true},np.bool)
 local e=np.array({0,1},np.uint8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 197')
 assert(list_same(r:tolist(),{0.0,2.0},0.004),'ldexp values 197')
end
do
 local a=np.array({false,true},np.bool)
 local e=np.array({-3,-1},np.int16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 198')
 assert(list_same(r:tolist(),{0.0,0.5},0.004),'ldexp values 198')
end
do
 local a=np.array({false,true},np.bool)
 local e=np.array({0,1},np.uint16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 199')
 assert(list_same(r:tolist(),{0.0,2.0},0.004),'ldexp values 199')
end
do
 local a=np.array({false,true},np.bool)
 local e=np.array({-3,-1},np.int32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 200')
 assert(list_same(r:tolist(),{0.0,0.5},0.004),'ldexp values 200')
end
do
 local a=np.array({false,true},np.bool)
 local e=np.array({0,1},np.uint32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 201')
 assert(list_same(r:tolist(),{0.0,2.0},0.004),'ldexp values 201')
end
do
 local a=np.array({false,true},np.bool)
 local e=np.array({-3,-1},np.int64)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 202')
 assert(list_same(r:tolist(),{0.0,0.5},0.004),'ldexp values 202')
end
do
 local a=np.array({false,true},np.bool)
 local e=np.array({0,1},np.uint64)
 assert(not pcall(function() np.ldexp(a,e) end),'ldexp reject 203')
end
do
 local a=np.array({-5,-1,0,1},np.int8)
 local e=np.array({false,true,true,true},np.bool)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 204')
 assert(list_same(r:tolist(),{-5.0,-2.0,0.0,2.0},0.004),'ldexp values 204')
end
do
 local a=np.array({-5,-1,0,1,5},np.int8)
 local e=np.array({-3,-1,0,1,3},np.int8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 205')
 assert(list_same(r:tolist(),{-0.625,-0.5,0.0,2.0,40.0},0.004),'ldexp values 205')
end
do
 local a=np.array({-5,-1,0,1},np.int8)
 local e=np.array({0,1,2,3},np.uint8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 206')
 assert(list_same(r:tolist(),{-5.0,-2.0,0.0,8.0},0.004),'ldexp values 206')
end
do
 local a=np.array({-5,-1,0,1,5},np.int8)
 local e=np.array({-3,-1,0,1,3},np.int16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 207')
 assert(list_same(r:tolist(),{-0.625,-0.5,0.0,2.0,40.0},0.004),'ldexp values 207')
end
do
 local a=np.array({-5,-1,0,1},np.int8)
 local e=np.array({0,1,2,3},np.uint16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 208')
 assert(list_same(r:tolist(),{-5.0,-2.0,0.0,8.0},0.004),'ldexp values 208')
end
do
 local a=np.array({-5,-1,0,1,5},np.int8)
 local e=np.array({-3,-1,0,1,3},np.int32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 209')
 assert(list_same(r:tolist(),{-0.625,-0.5,0.0,2.0,40.0},0.004),'ldexp values 209')
end
do
 local a=np.array({-5,-1,0,1},np.int8)
 local e=np.array({0,1,2,3},np.uint32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 210')
 assert(list_same(r:tolist(),{-5.0,-2.0,0.0,8.0},0.004),'ldexp values 210')
end
do
 local a=np.array({-5,-1,0,1,5},np.int8)
 local e=np.array({-3,-1,0,1,3},np.int64)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 211')
 assert(list_same(r:tolist(),{-0.625,-0.5,0.0,2.0,40.0},0.004),'ldexp values 211')
end
do
 local a=np.array({-5,-1,0,1},np.int8)
 local e=np.array({0,1,2,3},np.uint64)
 assert(not pcall(function() np.ldexp(a,e) end),'ldexp reject 212')
end
do
 local a=np.array({0,1,2,5},np.uint8)
 local e=np.array({false,true,true,true},np.bool)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 213')
 assert(list_same(r:tolist(),{0.0,2.0,4.0,10.0},0.004),'ldexp values 213')
end
do
 local a=np.array({0,1,2,5},np.uint8)
 local e=np.array({-3,-1,0,1},np.int8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 214')
 assert(list_same(r:tolist(),{0.0,0.5,2.0,10.0},0.004),'ldexp values 214')
end
do
 local a=np.array({0,1,2,5},np.uint8)
 local e=np.array({0,1,2,3},np.uint8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 215')
 assert(list_same(r:tolist(),{0.0,2.0,8.0,40.0},0.004),'ldexp values 215')
end
do
 local a=np.array({0,1,2,5},np.uint8)
 local e=np.array({-3,-1,0,1},np.int16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 216')
 assert(list_same(r:tolist(),{0.0,0.5,2.0,10.0},0.004),'ldexp values 216')
end
do
 local a=np.array({0,1,2,5},np.uint8)
 local e=np.array({0,1,2,3},np.uint16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 217')
 assert(list_same(r:tolist(),{0.0,2.0,8.0,40.0},0.004),'ldexp values 217')
end
do
 local a=np.array({0,1,2,5},np.uint8)
 local e=np.array({-3,-1,0,1},np.int32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 218')
 assert(list_same(r:tolist(),{0.0,0.5,2.0,10.0},0.004),'ldexp values 218')
end
do
 local a=np.array({0,1,2,5},np.uint8)
 local e=np.array({0,1,2,3},np.uint32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 219')
 assert(list_same(r:tolist(),{0.0,2.0,8.0,40.0},0.004),'ldexp values 219')
end
do
 local a=np.array({0,1,2,5},np.uint8)
 local e=np.array({-3,-1,0,1},np.int64)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 220')
 assert(list_same(r:tolist(),{0.0,0.5,2.0,10.0},0.004),'ldexp values 220')
end
do
 local a=np.array({0,1,2,5},np.uint8)
 local e=np.array({0,1,2,3},np.uint64)
 assert(not pcall(function() np.ldexp(a,e) end),'ldexp reject 221')
end
do
 local a=np.array({-5,-1,0,1},np.int16)
 local e=np.array({false,true,true,true},np.bool)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 222')
 assert(list_same(r:tolist(),{-5.0,-2.0,0.0,2.0},5e-06),'ldexp values 222')
end
do
 local a=np.array({-5,-1,0,1,5},np.int16)
 local e=np.array({-3,-1,0,1,3},np.int8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 223')
 assert(list_same(r:tolist(),{-0.625,-0.5,0.0,2.0,40.0},5e-06),'ldexp values 223')
end
do
 local a=np.array({-5,-1,0,1},np.int16)
 local e=np.array({0,1,2,3},np.uint8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 224')
 assert(list_same(r:tolist(),{-5.0,-2.0,0.0,8.0},5e-06),'ldexp values 224')
end
do
 local a=np.array({-5,-1,0,1,5},np.int16)
 local e=np.array({-3,-1,0,1,3},np.int16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 225')
 assert(list_same(r:tolist(),{-0.625,-0.5,0.0,2.0,40.0},5e-06),'ldexp values 225')
end
do
 local a=np.array({-5,-1,0,1},np.int16)
 local e=np.array({0,1,2,3},np.uint16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 226')
 assert(list_same(r:tolist(),{-5.0,-2.0,0.0,8.0},5e-06),'ldexp values 226')
end
do
 local a=np.array({-5,-1,0,1,5},np.int16)
 local e=np.array({-3,-1,0,1,3},np.int32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 227')
 assert(list_same(r:tolist(),{-0.625,-0.5,0.0,2.0,40.0},5e-06),'ldexp values 227')
end
do
 local a=np.array({-5,-1,0,1},np.int16)
 local e=np.array({0,1,2,3},np.uint32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 228')
 assert(list_same(r:tolist(),{-5.0,-2.0,0.0,8.0},5e-06),'ldexp values 228')
end
do
 local a=np.array({-5,-1,0,1,5},np.int16)
 local e=np.array({-3,-1,0,1,3},np.int64)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 229')
 assert(list_same(r:tolist(),{-0.625,-0.5,0.0,2.0,40.0},5e-06),'ldexp values 229')
end
do
 local a=np.array({-5,-1,0,1},np.int16)
 local e=np.array({0,1,2,3},np.uint64)
 assert(not pcall(function() np.ldexp(a,e) end),'ldexp reject 230')
end
do
 local a=np.array({0,1,2,5},np.uint16)
 local e=np.array({false,true,true,true},np.bool)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 231')
 assert(list_same(r:tolist(),{0.0,2.0,4.0,10.0},5e-06),'ldexp values 231')
end
do
 local a=np.array({0,1,2,5},np.uint16)
 local e=np.array({-3,-1,0,1},np.int8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 232')
 assert(list_same(r:tolist(),{0.0,0.5,2.0,10.0},5e-06),'ldexp values 232')
end
do
 local a=np.array({0,1,2,5},np.uint16)
 local e=np.array({0,1,2,3},np.uint8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 233')
 assert(list_same(r:tolist(),{0.0,2.0,8.0,40.0},5e-06),'ldexp values 233')
end
do
 local a=np.array({0,1,2,5},np.uint16)
 local e=np.array({-3,-1,0,1},np.int16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 234')
 assert(list_same(r:tolist(),{0.0,0.5,2.0,10.0},5e-06),'ldexp values 234')
end
do
 local a=np.array({0,1,2,5},np.uint16)
 local e=np.array({0,1,2,3},np.uint16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 235')
 assert(list_same(r:tolist(),{0.0,2.0,8.0,40.0},5e-06),'ldexp values 235')
end
do
 local a=np.array({0,1,2,5},np.uint16)
 local e=np.array({-3,-1,0,1},np.int32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 236')
 assert(list_same(r:tolist(),{0.0,0.5,2.0,10.0},5e-06),'ldexp values 236')
end
do
 local a=np.array({0,1,2,5},np.uint16)
 local e=np.array({0,1,2,3},np.uint32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 237')
 assert(list_same(r:tolist(),{0.0,2.0,8.0,40.0},5e-06),'ldexp values 237')
end
do
 local a=np.array({0,1,2,5},np.uint16)
 local e=np.array({-3,-1,0,1},np.int64)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 238')
 assert(list_same(r:tolist(),{0.0,0.5,2.0,10.0},5e-06),'ldexp values 238')
end
do
 local a=np.array({0,1,2,5},np.uint16)
 local e=np.array({0,1,2,3},np.uint64)
 assert(not pcall(function() np.ldexp(a,e) end),'ldexp reject 239')
end
do
 local a=np.array({-5,-1,0,1},np.int32)
 local e=np.array({false,true,true,true},np.bool)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 240')
 assert(list_same(r:tolist(),{-5.0,-2.0,0.0,2.0},5e-12),'ldexp values 240')
end
do
 local a=np.array({-5,-1,0,1,5},np.int32)
 local e=np.array({-3,-1,0,1,3},np.int8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 241')
 assert(list_same(r:tolist(),{-0.625,-0.5,0.0,2.0,40.0},5e-12),'ldexp values 241')
end
do
 local a=np.array({-5,-1,0,1},np.int32)
 local e=np.array({0,1,2,3},np.uint8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 242')
 assert(list_same(r:tolist(),{-5.0,-2.0,0.0,8.0},5e-12),'ldexp values 242')
end
do
 local a=np.array({-5,-1,0,1,5},np.int32)
 local e=np.array({-3,-1,0,1,3},np.int16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 243')
 assert(list_same(r:tolist(),{-0.625,-0.5,0.0,2.0,40.0},5e-12),'ldexp values 243')
end
do
 local a=np.array({-5,-1,0,1},np.int32)
 local e=np.array({0,1,2,3},np.uint16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 244')
 assert(list_same(r:tolist(),{-5.0,-2.0,0.0,8.0},5e-12),'ldexp values 244')
end
do
 local a=np.array({-5,-1,0,1,5},np.int32)
 local e=np.array({-3,-1,0,1,3},np.int32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 245')
 assert(list_same(r:tolist(),{-0.625,-0.5,0.0,2.0,40.0},5e-12),'ldexp values 245')
end
do
 local a=np.array({-5,-1,0,1},np.int32)
 local e=np.array({0,1,2,3},np.uint32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 246')
 assert(list_same(r:tolist(),{-5.0,-2.0,0.0,8.0},5e-12),'ldexp values 246')
end
do
 local a=np.array({-5,-1,0,1,5},np.int32)
 local e=np.array({-3,-1,0,1,3},np.int64)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 247')
 assert(list_same(r:tolist(),{-0.625,-0.5,0.0,2.0,40.0},5e-12),'ldexp values 247')
end
do
 local a=np.array({-5,-1,0,1},np.int32)
 local e=np.array({0,1,2,3},np.uint64)
 assert(not pcall(function() np.ldexp(a,e) end),'ldexp reject 248')
end
do
 local a=np.array({0,1,2,5},np.uint32)
 local e=np.array({false,true,true,true},np.bool)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 249')
 assert(list_same(r:tolist(),{0.0,2.0,4.0,10.0},5e-12),'ldexp values 249')
end
do
 local a=np.array({0,1,2,5},np.uint32)
 local e=np.array({-3,-1,0,1},np.int8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 250')
 assert(list_same(r:tolist(),{0.0,0.5,2.0,10.0},5e-12),'ldexp values 250')
end
do
 local a=np.array({0,1,2,5},np.uint32)
 local e=np.array({0,1,2,3},np.uint8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 251')
 assert(list_same(r:tolist(),{0.0,2.0,8.0,40.0},5e-12),'ldexp values 251')
end
do
 local a=np.array({0,1,2,5},np.uint32)
 local e=np.array({-3,-1,0,1},np.int16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 252')
 assert(list_same(r:tolist(),{0.0,0.5,2.0,10.0},5e-12),'ldexp values 252')
end
do
 local a=np.array({0,1,2,5},np.uint32)
 local e=np.array({0,1,2,3},np.uint16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 253')
 assert(list_same(r:tolist(),{0.0,2.0,8.0,40.0},5e-12),'ldexp values 253')
end
do
 local a=np.array({0,1,2,5},np.uint32)
 local e=np.array({-3,-1,0,1},np.int32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 254')
 assert(list_same(r:tolist(),{0.0,0.5,2.0,10.0},5e-12),'ldexp values 254')
end
do
 local a=np.array({0,1,2,5},np.uint32)
 local e=np.array({0,1,2,3},np.uint32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 255')
 assert(list_same(r:tolist(),{0.0,2.0,8.0,40.0},5e-12),'ldexp values 255')
end
do
 local a=np.array({0,1,2,5},np.uint32)
 local e=np.array({-3,-1,0,1},np.int64)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 256')
 assert(list_same(r:tolist(),{0.0,0.5,2.0,10.0},5e-12),'ldexp values 256')
end
do
 local a=np.array({0,1,2,5},np.uint32)
 local e=np.array({0,1,2,3},np.uint64)
 assert(not pcall(function() np.ldexp(a,e) end),'ldexp reject 257')
end
do
 local a=np.array({-5,-1,0,1},np.int64)
 local e=np.array({false,true,true,true},np.bool)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 258')
 assert(list_same(r:tolist(),{-5.0,-2.0,0.0,2.0},5e-12),'ldexp values 258')
end
do
 local a=np.array({-5,-1,0,1,5},np.int64)
 local e=np.array({-3,-1,0,1,3},np.int8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 259')
 assert(list_same(r:tolist(),{-0.625,-0.5,0.0,2.0,40.0},5e-12),'ldexp values 259')
end
do
 local a=np.array({-5,-1,0,1},np.int64)
 local e=np.array({0,1,2,3},np.uint8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 260')
 assert(list_same(r:tolist(),{-5.0,-2.0,0.0,8.0},5e-12),'ldexp values 260')
end
do
 local a=np.array({-5,-1,0,1,5},np.int64)
 local e=np.array({-3,-1,0,1,3},np.int16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 261')
 assert(list_same(r:tolist(),{-0.625,-0.5,0.0,2.0,40.0},5e-12),'ldexp values 261')
end
do
 local a=np.array({-5,-1,0,1},np.int64)
 local e=np.array({0,1,2,3},np.uint16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 262')
 assert(list_same(r:tolist(),{-5.0,-2.0,0.0,8.0},5e-12),'ldexp values 262')
end
do
 local a=np.array({-5,-1,0,1,5},np.int64)
 local e=np.array({-3,-1,0,1,3},np.int32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 263')
 assert(list_same(r:tolist(),{-0.625,-0.5,0.0,2.0,40.0},5e-12),'ldexp values 263')
end
do
 local a=np.array({-5,-1,0,1},np.int64)
 local e=np.array({0,1,2,3},np.uint32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 264')
 assert(list_same(r:tolist(),{-5.0,-2.0,0.0,8.0},5e-12),'ldexp values 264')
end
do
 local a=np.array({-5,-1,0,1,5},np.int64)
 local e=np.array({-3,-1,0,1,3},np.int64)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 265')
 assert(list_same(r:tolist(),{-0.625,-0.5,0.0,2.0,40.0},5e-12),'ldexp values 265')
end
do
 local a=np.array({-5,-1,0,1},np.int64)
 local e=np.array({0,1,2,3},np.uint64)
 assert(not pcall(function() np.ldexp(a,e) end),'ldexp reject 266')
end
do
 local a=np.array({0,1,2,5},np.uint64)
 local e=np.array({false,true,true,true},np.bool)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 267')
 assert(list_same(r:tolist(),{0.0,2.0,4.0,10.0},5e-12),'ldexp values 267')
end
do
 local a=np.array({0,1,2,5},np.uint64)
 local e=np.array({-3,-1,0,1},np.int8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 268')
 assert(list_same(r:tolist(),{0.0,0.5,2.0,10.0},5e-12),'ldexp values 268')
end
do
 local a=np.array({0,1,2,5},np.uint64)
 local e=np.array({0,1,2,3},np.uint8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 269')
 assert(list_same(r:tolist(),{0.0,2.0,8.0,40.0},5e-12),'ldexp values 269')
end
do
 local a=np.array({0,1,2,5},np.uint64)
 local e=np.array({-3,-1,0,1},np.int16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 270')
 assert(list_same(r:tolist(),{0.0,0.5,2.0,10.0},5e-12),'ldexp values 270')
end
do
 local a=np.array({0,1,2,5},np.uint64)
 local e=np.array({0,1,2,3},np.uint16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 271')
 assert(list_same(r:tolist(),{0.0,2.0,8.0,40.0},5e-12),'ldexp values 271')
end
do
 local a=np.array({0,1,2,5},np.uint64)
 local e=np.array({-3,-1,0,1},np.int32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 272')
 assert(list_same(r:tolist(),{0.0,0.5,2.0,10.0},5e-12),'ldexp values 272')
end
do
 local a=np.array({0,1,2,5},np.uint64)
 local e=np.array({0,1,2,3},np.uint32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 273')
 assert(list_same(r:tolist(),{0.0,2.0,8.0,40.0},5e-12),'ldexp values 273')
end
do
 local a=np.array({0,1,2,5},np.uint64)
 local e=np.array({-3,-1,0,1},np.int64)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 274')
 assert(list_same(r:tolist(),{0.0,0.5,2.0,10.0},5e-12),'ldexp values 274')
end
do
 local a=np.array({0,1,2,5},np.uint64)
 local e=np.array({0,1,2,3},np.uint64)
 assert(not pcall(function() np.ldexp(a,e) end),'ldexp reject 275')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0},np.float16)
 local e=np.array({false,true,true,true},np.bool)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 276')
 assert(list_same(r:tolist(),{-1.5,-1.0,-0.0,0.0},0.004),'ldexp values 276')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0,0.5},np.float16)
 local e=np.array({-3,-1,0,1,3},np.int8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 277')
 assert(list_same(r:tolist(),{-0.1875,-0.25,-0.0,0.0,4.0},0.004),'ldexp values 277')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0},np.float16)
 local e=np.array({0,1,2,3},np.uint8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 278')
 assert(list_same(r:tolist(),{-1.5,-1.0,-0.0,0.0},0.004),'ldexp values 278')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0,0.5},np.float16)
 local e=np.array({-3,-1,0,1,3},np.int16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 279')
 assert(list_same(r:tolist(),{-0.1875,-0.25,-0.0,0.0,4.0},0.004),'ldexp values 279')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0},np.float16)
 local e=np.array({0,1,2,3},np.uint16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 280')
 assert(list_same(r:tolist(),{-1.5,-1.0,-0.0,0.0},0.004),'ldexp values 280')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0,0.5},np.float16)
 local e=np.array({-3,-1,0,1,3},np.int32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 281')
 assert(list_same(r:tolist(),{-0.1875,-0.25,-0.0,0.0,4.0},0.004),'ldexp values 281')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0},np.float16)
 local e=np.array({0,1,2,3},np.uint32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 282')
 assert(list_same(r:tolist(),{-1.5,-1.0,-0.0,0.0},0.004),'ldexp values 282')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0,0.5},np.float16)
 local e=np.array({-3,-1,0,1,3},np.int64)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float16','ldexp dtype 283')
 assert(list_same(r:tolist(),{-0.1875,-0.25,-0.0,0.0,4.0},0.004),'ldexp values 283')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0},np.float16)
 local e=np.array({0,1,2,3},np.uint64)
 assert(not pcall(function() np.ldexp(a,e) end),'ldexp reject 284')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0},np.float32)
 local e=np.array({false,true,true,true},np.bool)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 285')
 assert(list_same(r:tolist(),{-1.5,-1.0,-0.0,0.0},5e-06),'ldexp values 285')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0,0.5},np.float32)
 local e=np.array({-3,-1,0,1,3},np.int8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 286')
 assert(list_same(r:tolist(),{-0.1875,-0.25,-0.0,0.0,4.0},5e-06),'ldexp values 286')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0},np.float32)
 local e=np.array({0,1,2,3},np.uint8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 287')
 assert(list_same(r:tolist(),{-1.5,-1.0,-0.0,0.0},5e-06),'ldexp values 287')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0,0.5},np.float32)
 local e=np.array({-3,-1,0,1,3},np.int16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 288')
 assert(list_same(r:tolist(),{-0.1875,-0.25,-0.0,0.0,4.0},5e-06),'ldexp values 288')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0},np.float32)
 local e=np.array({0,1,2,3},np.uint16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 289')
 assert(list_same(r:tolist(),{-1.5,-1.0,-0.0,0.0},5e-06),'ldexp values 289')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0,0.5},np.float32)
 local e=np.array({-3,-1,0,1,3},np.int32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 290')
 assert(list_same(r:tolist(),{-0.1875,-0.25,-0.0,0.0,4.0},5e-06),'ldexp values 290')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0},np.float32)
 local e=np.array({0,1,2,3},np.uint32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 291')
 assert(list_same(r:tolist(),{-1.5,-1.0,-0.0,0.0},5e-06),'ldexp values 291')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0,0.5},np.float32)
 local e=np.array({-3,-1,0,1,3},np.int64)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float32','ldexp dtype 292')
 assert(list_same(r:tolist(),{-0.1875,-0.25,-0.0,0.0,4.0},5e-06),'ldexp values 292')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0},np.float32)
 local e=np.array({0,1,2,3},np.uint64)
 assert(not pcall(function() np.ldexp(a,e) end),'ldexp reject 293')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0},np.float64)
 local e=np.array({false,true,true,true},np.bool)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 294')
 assert(list_same(r:tolist(),{-1.5,-1.0,-0.0,0.0},5e-12),'ldexp values 294')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0,0.5},np.float64)
 local e=np.array({-3,-1,0,1,3},np.int8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 295')
 assert(list_same(r:tolist(),{-0.1875,-0.25,-0.0,0.0,4.0},5e-12),'ldexp values 295')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0},np.float64)
 local e=np.array({0,1,2,3},np.uint8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 296')
 assert(list_same(r:tolist(),{-1.5,-1.0,-0.0,0.0},5e-12),'ldexp values 296')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0,0.5},np.float64)
 local e=np.array({-3,-1,0,1,3},np.int16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 297')
 assert(list_same(r:tolist(),{-0.1875,-0.25,-0.0,0.0,4.0},5e-12),'ldexp values 297')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0},np.float64)
 local e=np.array({0,1,2,3},np.uint16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 298')
 assert(list_same(r:tolist(),{-1.5,-1.0,-0.0,0.0},5e-12),'ldexp values 298')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0,0.5},np.float64)
 local e=np.array({-3,-1,0,1,3},np.int32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 299')
 assert(list_same(r:tolist(),{-0.1875,-0.25,-0.0,0.0,4.0},5e-12),'ldexp values 299')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0},np.float64)
 local e=np.array({0,1,2,3},np.uint32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 300')
 assert(list_same(r:tolist(),{-1.5,-1.0,-0.0,0.0},5e-12),'ldexp values 300')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0,0.5},np.float64)
 local e=np.array({-3,-1,0,1,3},np.int64)
 local r=np.ldexp(a,e)
 assert(r.dtype=='float64','ldexp dtype 301')
 assert(list_same(r:tolist(),{-0.1875,-0.25,-0.0,0.0,4.0},5e-12),'ldexp values 301')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0},np.float64)
 local e=np.array({0,1,2,3},np.uint64)
 assert(not pcall(function() np.ldexp(a,e) end),'ldexp reject 302')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0},np.longdouble)
 local e=np.array({false,true,true,true},np.bool)
 local r=np.ldexp(a,e)
 assert(r.dtype=='longdouble','ldexp dtype 303')
 assert(list_same(r:tolist(),{-1.5,-1.0,-0.0,0.0},5e-12),'ldexp values 303')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0,0.5},np.longdouble)
 local e=np.array({-3,-1,0,1,3},np.int8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='longdouble','ldexp dtype 304')
 assert(list_same(r:tolist(),{-0.1875,-0.25,-0.0,0.0,4.0},5e-12),'ldexp values 304')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0},np.longdouble)
 local e=np.array({0,1,2,3},np.uint8)
 local r=np.ldexp(a,e)
 assert(r.dtype=='longdouble','ldexp dtype 305')
 assert(list_same(r:tolist(),{-1.5,-1.0,-0.0,0.0},5e-12),'ldexp values 305')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0,0.5},np.longdouble)
 local e=np.array({-3,-1,0,1,3},np.int16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='longdouble','ldexp dtype 306')
 assert(list_same(r:tolist(),{-0.1875,-0.25,-0.0,0.0,4.0},5e-12),'ldexp values 306')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0},np.longdouble)
 local e=np.array({0,1,2,3},np.uint16)
 local r=np.ldexp(a,e)
 assert(r.dtype=='longdouble','ldexp dtype 307')
 assert(list_same(r:tolist(),{-1.5,-1.0,-0.0,0.0},5e-12),'ldexp values 307')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0,0.5},np.longdouble)
 local e=np.array({-3,-1,0,1,3},np.int32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='longdouble','ldexp dtype 308')
 assert(list_same(r:tolist(),{-0.1875,-0.25,-0.0,0.0,4.0},5e-12),'ldexp values 308')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0},np.longdouble)
 local e=np.array({0,1,2,3},np.uint32)
 local r=np.ldexp(a,e)
 assert(r.dtype=='longdouble','ldexp dtype 309')
 assert(list_same(r:tolist(),{-1.5,-1.0,-0.0,0.0},5e-12),'ldexp values 309')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0,0.5},np.longdouble)
 local e=np.array({-3,-1,0,1,3},np.int64)
 local r=np.ldexp(a,e)
 assert(r.dtype=='longdouble','ldexp dtype 310')
 assert(list_same(r:tolist(),{-0.1875,-0.25,-0.0,0.0,4.0},5e-12),'ldexp values 310')
end
do
 local a=np.array({-1.5,-0.5,-0.0,0.0},np.longdouble)
 local e=np.array({0,1,2,3},np.uint64)
 assert(not pcall(function() np.ldexp(a,e) end),'ldexp reject 311')
end
do
 local a=np.array({0.5,-0.5,1.0,2.0},np.float32)
 local r=np.ldexp(a,2)
 assert(r.dtype=='float32' and list_same(r:tolist(),{2.0,-2.0,4.0,8.0},1e-6),'ldexp scalar 312')
end
do
 local a=np.array({0.5,-0.5,1.0,2.0},np.float32)
 local e=np.array({1,2,-1,4},np.int64)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({9,8,7,6},np.float64); local r=np.ldexp(a,e,{out=o,where=m})
 assert(r==o,'ldexp out identity')
 assert(list_same(o:tolist(),{1.0,8.0,0.5,6.0},1e-6),'ldexp out where 313')
end
do
 local a=np.array({{71.0},{-71.0}},np.float32)
 local b=np.array({{19.0,-19.0,6.0}},np.float64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','broadcast dtype 314')
 assert(list_same(q:tolist()[1],{3.0,-4.0,11.0},1e-12),'broadcast q 314')
 assert(list_same(r:tolist()[1],{14.0,-5.0,5.0},1e-12),'broadcast r 314')
end
do
 local a=np.array({{71.0},{-71.0}},np.float32)
 local b=np.array({{19.0,-19.0,6.0}},np.float64)
 local q,r=np.divmod(a,b)
 assert(q.dtype=='float64' and r.dtype=='float64','broadcast dtype 315')
 assert(list_same(q:tolist()[2],{-4.0,3.0,-12.0},1e-12),'broadcast q 315')
 assert(list_same(r:tolist()[2],{5.0,-14.0,1.0},1e-12),'broadcast r 315')
end
do
 local base=np.array({(0/0),(0/0),math.huge,-math.huge,0.0,-0.0,1.0,-1.0},np.float64)
 local a=base[np.slice(nil,nil,-4)]
 local m,e=np.frexp(a)
 assert(list_same(m:tolist(),{-0.5,-math.huge},1e-12),'strided frexp m 316')
 assert(list_same(e:tolist(),{1,0},0),'strided frexp e 316')
 local f,i=np.modf(a)
 assert(list_same(f:tolist(),{-0.0,-0.0},1e-12),'strided modf f 316')
 assert(list_same(i:tolist(),{-1.0,-math.huge},1e-12),'strided modf i 316')
end
do
 local base=np.array({(0/0),(0/0),math.huge,-math.huge,0.0,-0.0,1.0,-1.0},np.float64)
 local a=base[np.slice(nil,nil,-2)]
 local m,e=np.frexp(a)
 assert(list_same(m:tolist(),{-0.5,-0.0,-math.huge,(0/0)},1e-12),'strided frexp m 317')
 assert(list_same(e:tolist(),{1,0,0,0},0),'strided frexp e 317')
 local f,i=np.modf(a)
 assert(list_same(f:tolist(),{-0.0,-0.0,-0.0,(0/0)},1e-12),'strided modf f 317')
 assert(list_same(i:tolist(),{-1.0,-0.0,-math.huge,(0/0)},1e-12),'strided modf i 317')
end
do
 local base=np.array({(0/0),(0/0),math.huge,-math.huge,0.0,-0.0,1.0,-1.0},np.float64)
 local a=base[np.slice(nil,nil,-1)]
 local m,e=np.frexp(a)
 assert(list_same(m:tolist(),{-0.5,0.5,-0.0,0.0,-math.huge,math.huge,(0/0),(0/0)},1e-12),'strided frexp m 318')
 assert(list_same(e:tolist(),{1,1,0,0,0,0,0,0},0),'strided frexp e 318')
 local f,i=np.modf(a)
 assert(list_same(f:tolist(),{-0.0,0.0,-0.0,0.0,-0.0,0.0,(0/0),(0/0)},1e-12),'strided modf f 318')
 assert(list_same(i:tolist(),{-1.0,1.0,-0.0,0.0,-math.huge,math.huge,(0/0),(0/0)},1e-12),'strided modf i 318')
end
do
 local base=np.array({(0/0),(0/0),math.huge,-math.huge,0.0,-0.0,1.0,-1.0},np.float64)
 local a=base[np.slice(nil,nil,1)]
 local m,e=np.frexp(a)
 assert(list_same(m:tolist(),{(0/0),(0/0),math.huge,-math.huge,0.0,-0.0,0.5,-0.5},1e-12),'strided frexp m 319')
 assert(list_same(e:tolist(),{0,0,0,0,0,0,1,1},0),'strided frexp e 319')
 local f,i=np.modf(a)
 assert(list_same(f:tolist(),{(0/0),(0/0),0.0,-0.0,0.0,-0.0,0.0,-0.0},1e-12),'strided modf f 319')
 assert(list_same(i:tolist(),{(0/0),(0/0),math.huge,-math.huge,0.0,-0.0,1.0,-1.0},1e-12),'strided modf i 319')
end
do
 local base=np.array({(0/0),(0/0),math.huge,-math.huge,0.0,-0.0,1.0,-1.0},np.float64)
 local a=base[np.slice(nil,nil,2)]
 local m,e=np.frexp(a)
 assert(list_same(m:tolist(),{(0/0),math.huge,0.0,0.5},1e-12),'strided frexp m 320')
 assert(list_same(e:tolist(),{0,0,0,1},0),'strided frexp e 320')
 local f,i=np.modf(a)
 assert(list_same(f:tolist(),{(0/0),0.0,0.0,0.0},1e-12),'strided modf f 320')
 assert(list_same(i:tolist(),{(0/0),math.huge,0.0,1.0},1e-12),'strided modf i 320')
end
do
 local base=np.array({(0/0),(0/0),math.huge,-math.huge,0.0,-0.0,1.0,-1.0},np.float64)
 local a=base[np.slice(nil,nil,4)]
 local m,e=np.frexp(a)
 assert(list_same(m:tolist(),{(0/0),0.0},1e-12),'strided frexp m 321')
 assert(list_same(e:tolist(),{0,0},0),'strided frexp e 321')
 local f,i=np.modf(a)
 assert(list_same(f:tolist(),{(0/0),0.0},1e-12),'strided modf f 321')
 assert(list_same(i:tolist(),{(0/0),0.0},1e-12),'strided modf i 321')
end
do
 local a=np.array({5.699999809265137,-2.5,0.0,-0.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o1=np.array({9,8,7,6},np.float64); local o2=np.array({9,8,7,6},np.int64)
 local r1,r2=np.frexp(a,{out={o1,o2},where=m})
 assert(r1==o1 and r2==o2,'frexp out identity')
 assert(list_same(o1:tolist(),{0.7124999761581421,8.0,0.0,6.0},1e-6),'frexp out mant')
 assert(list_same(o2:tolist(),{3,8,0,6},0),'frexp out exp')
end
do
 local a=np.array({5.699999809265137,-2.5,0.0,-0.0},np.float32)
 local o=np.array({3,3,3,3},np.float64)
 local f,i=np.modf(a,{out={[1]=o}})
 assert(f==o and i.dtype=='float32','modf partial out')
 assert(list_same(f:tolist(),{0.6999998092651367,-0.5,0.0,-0.0},1e-6),'modf partial first')
 assert(list_same(i:tolist(),{5.0,-2.0,0.0,-0.0},1e-6),'modf partial second')
end
do
 local a=np.array({71.0,-71.0,5.0,1.0},np.float32)
 local b=np.array({19.0,19.0,-2.0,2.0},np.float32)
 local m=np.array({true,false,true,false},np.bool)
 local o=np.array({99,98,97,96},np.float64)
 local q,r=np.divmod(a,b,{out={[2]=o},where=m})
 assert(r==o and q.dtype=='float32','divmod partial out')
 assert(list_same(r:tolist(),{14.0,98.0,-1.0,96.0},1e-6),'divmod partial rem')
end
do
 local z=np.array({np.complex(1,2)},np.complex128)
 assert(not pcall(function() np.frexp(z) end),'complex frexp must reject')
 assert(not pcall(function() np.modf(z) end),'complex modf must reject')
 assert(not pcall(function() np.divmod(z,z) end),'complex divmod must reject')
 local a=np.array({1.5},np.float64)
 local oi=np.zeros({1},np.int32)
 assert(not pcall(function() np.modf(a,{out={oi,oi}}) end),'unsafe output cast must reject')
end
print('generic multi-output ufunc differential: 329 cases ok')
