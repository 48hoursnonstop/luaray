local np=require('luaray_core')

local function fsame(a,b,tol,zero_sign)
  if a~=a and b~=b then return true end
  if a==0 and b==0 then
    if not zero_sign then return true end
    return (1/a)==(1/b)
  end
  if a==b then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return false end
  return math.abs(a-b)<=tol*math.max(1,math.abs(a),math.abs(b))
end
local function zsame(a,b,tol,zero_sign)
  return type(a)=='userdata' and type(b)=='userdata' and
         fsame(a.real,b.real,tol,zero_sign) and fsame(a.imag,b.imag,tol,zero_sign)
end
local function list_same(a,b,tol,complex_,zero_sign)
  if #a~=#b then return false end
  for i=1,#a do
    if complex_ then
      if not zsame(a[i],b[i],tol,zero_sign) then return false end
    else
      if not fsame(a[i],b[i],tol,zero_sign) then return false end
    end
  end
  return true
end
-- Generated against development NumPy 2.3.5.
do
 local a=np.array({0.0,1.0},np.bool)
 local r=np.arcsin(a)
 assert(r.dtype=='float16','inv real dtype 0')
 assert(list_same(r:tolist(),{0.0,1.5703125},0.004,false,true),'inv real arcsin 0')
end
do
 local a=np.array({0.0,1.0},np.bool)
 local r=np.arccos(a)
 assert(r.dtype=='float16','inv real dtype 1')
 assert(list_same(r:tolist(),{1.5703125,0.0},0.004,false,true),'inv real arccos 1')
end
do
 local a=np.array({0.0,1.0},np.bool)
 local r=np.arctan(a)
 assert(r.dtype=='float16','inv real dtype 2')
 assert(list_same(r:tolist(),{0.0,0.78515625},0.004,false,true),'inv real arctan 2')
end
do
 local a=np.array({0.0,1.0},np.bool)
 local r=np.arcsinh(a)
 assert(r.dtype=='float16','inv real dtype 3')
 assert(list_same(r:tolist(),{0.0,0.88134765625},0.004,false,true),'inv real arcsinh 3')
end
do
 local a=np.array({0.0,1.0},np.bool)
 local r=np.arccosh(a)
 assert(r.dtype=='float16','inv real dtype 4')
 assert(list_same(r:tolist(),{(0/0),0.0},0.004,false,true),'inv real arccosh 4')
end
do
 local a=np.array({0.0,1.0},np.bool)
 local r=np.arctanh(a)
 assert(r.dtype=='float16','inv real dtype 5')
 assert(list_same(r:tolist(),{0.0,math.huge},0.004,false,true),'inv real arctanh 5')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int8)
 local r=np.arcsin(a)
 assert(r.dtype=='float16','inv real dtype 6')
 assert(list_same(r:tolist(),{(0/0),(0/0),-1.5703125,0.0,1.5703125,(0/0),(0/0)},0.004,false,true),'inv real arcsin 6')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int8)
 local r=np.arccos(a)
 assert(r.dtype=='float16','inv real dtype 7')
 assert(list_same(r:tolist(),{(0/0),(0/0),3.140625,1.5703125,0.0,(0/0),(0/0)},0.004,false,true),'inv real arccos 7')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int8)
 local r=np.arctan(a)
 assert(r.dtype=='float16','inv real dtype 8')
 assert(list_same(r:tolist(),{-1.326171875,-1.107421875,-0.78515625,0.0,0.78515625,1.107421875,1.326171875},0.004,false,true),'inv real arctan 8')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int8)
 local r=np.arcsinh(a)
 assert(r.dtype=='float16','inv real dtype 9')
 assert(list_same(r:tolist(),{-2.09375,-1.443359375,-0.88134765625,0.0,0.88134765625,1.443359375,2.09375},0.004,false,true),'inv real arcsinh 9')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int8)
 local r=np.arccosh(a)
 assert(r.dtype=='float16','inv real dtype 10')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),(0/0),0.0,1.3173828125,2.0625},0.004,false,true),'inv real arccosh 10')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int8)
 local r=np.arctanh(a)
 assert(r.dtype=='float16','inv real dtype 11')
 assert(list_same(r:tolist(),{(0/0),(0/0),-math.huge,0.0,math.huge,(0/0),(0/0)},0.004,false,true),'inv real arctanh 11')
end
do
 local a=np.array({0.0,1.0,2.0,4.0},np.uint8)
 local r=np.arcsin(a)
 assert(r.dtype=='float16','inv real dtype 12')
 assert(list_same(r:tolist(),{0.0,1.5703125,(0/0),(0/0)},0.004,false,true),'inv real arcsin 12')
end
do
 local a=np.array({0.0,1.0,2.0,4.0},np.uint8)
 local r=np.arccos(a)
 assert(r.dtype=='float16','inv real dtype 13')
 assert(list_same(r:tolist(),{1.5703125,0.0,(0/0),(0/0)},0.004,false,true),'inv real arccos 13')
end
do
 local a=np.array({0.0,1.0,2.0,4.0},np.uint8)
 local r=np.arctan(a)
 assert(r.dtype=='float16','inv real dtype 14')
 assert(list_same(r:tolist(),{0.0,0.78515625,1.107421875,1.326171875},0.004,false,true),'inv real arctan 14')
end
do
 local a=np.array({0.0,1.0,2.0,4.0},np.uint8)
 local r=np.arcsinh(a)
 assert(r.dtype=='float16','inv real dtype 15')
 assert(list_same(r:tolist(),{0.0,0.88134765625,1.443359375,2.09375},0.004,false,true),'inv real arcsinh 15')
end
do
 local a=np.array({0.0,1.0,2.0,4.0},np.uint8)
 local r=np.arccosh(a)
 assert(r.dtype=='float16','inv real dtype 16')
 assert(list_same(r:tolist(),{(0/0),0.0,1.3173828125,2.0625},0.004,false,true),'inv real arccosh 16')
end
do
 local a=np.array({0.0,1.0,2.0,4.0},np.uint8)
 local r=np.arctanh(a)
 assert(r.dtype=='float16','inv real dtype 17')
 assert(list_same(r:tolist(),{0.0,math.huge,(0/0),(0/0)},0.004,false,true),'inv real arctanh 17')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int16)
 local r=np.arcsin(a)
 assert(r.dtype=='float32','inv real dtype 18')
 assert(list_same(r:tolist(),{(0/0),(0/0),-1.5707963705062866,0.0,1.5707963705062866,(0/0),(0/0)},8e-05,false,true),'inv real arcsin 18')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int16)
 local r=np.arccos(a)
 assert(r.dtype=='float32','inv real dtype 19')
 assert(list_same(r:tolist(),{(0/0),(0/0),3.1415927410125732,1.5707963705062866,0.0,(0/0),(0/0)},8e-05,false,true),'inv real arccos 19')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int16)
 local r=np.arctan(a)
 assert(r.dtype=='float32','inv real dtype 20')
 assert(list_same(r:tolist(),{-1.3258177042007446,-1.1071487665176392,-0.7853981852531433,0.0,0.7853981852531433,1.1071487665176392,1.3258177042007446},8e-05,false,true),'inv real arctan 20')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int16)
 local r=np.arcsinh(a)
 assert(r.dtype=='float32','inv real dtype 21')
 assert(list_same(r:tolist(),{-2.094712495803833,-1.4436354637145996,-0.8813735842704773,0.0,0.8813735842704773,1.4436354637145996,2.094712495803833},8e-05,false,true),'inv real arcsinh 21')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int16)
 local r=np.arccosh(a)
 assert(r.dtype=='float32','inv real dtype 22')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),(0/0),0.0,1.316957950592041,2.063436985015869},8e-05,false,true),'inv real arccosh 22')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int16)
 local r=np.arctanh(a)
 assert(r.dtype=='float32','inv real dtype 23')
 assert(list_same(r:tolist(),{(0/0),(0/0),-math.huge,0.0,math.huge,(0/0),(0/0)},8e-05,false,true),'inv real arctanh 23')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int32)
 local r=np.arcsin(a)
 assert(r.dtype=='float64','inv real dtype 24')
 assert(list_same(r:tolist(),{(0/0),(0/0),-1.5707963267948966,0.0,1.5707963267948966,(0/0),(0/0)},6e-12,false,true),'inv real arcsin 24')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int32)
 local r=np.arccos(a)
 assert(r.dtype=='float64','inv real dtype 25')
 assert(list_same(r:tolist(),{(0/0),(0/0),3.141592653589793,1.5707963267948966,0.0,(0/0),(0/0)},6e-12,false,true),'inv real arccos 25')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int32)
 local r=np.arctan(a)
 assert(r.dtype=='float64','inv real dtype 26')
 assert(list_same(r:tolist(),{-1.3258176636680326,-1.1071487177940904,-0.7853981633974483,0.0,0.7853981633974483,1.1071487177940904,1.3258176636680326},6e-12,false,true),'inv real arctan 26')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int32)
 local r=np.arcsinh(a)
 assert(r.dtype=='float64','inv real dtype 27')
 assert(list_same(r:tolist(),{-2.0947125472611012,-1.4436354751788103,-0.881373587019543,0.0,0.881373587019543,1.4436354751788103,2.0947125472611012},6e-12,false,true),'inv real arcsinh 27')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int32)
 local r=np.arccosh(a)
 assert(r.dtype=='float64','inv real dtype 28')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),(0/0),0.0,1.3169578969248168,2.0634370688955603},6e-12,false,true),'inv real arccosh 28')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int32)
 local r=np.arctanh(a)
 assert(r.dtype=='float64','inv real dtype 29')
 assert(list_same(r:tolist(),{(0/0),(0/0),-math.huge,0.0,math.huge,(0/0),(0/0)},6e-12,false,true),'inv real arctanh 29')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int64)
 local r=np.arcsin(a)
 assert(r.dtype=='float64','inv real dtype 30')
 assert(list_same(r:tolist(),{(0/0),(0/0),-1.5707963267948966,0.0,1.5707963267948966,(0/0),(0/0)},6e-12,false,true),'inv real arcsin 30')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int64)
 local r=np.arccos(a)
 assert(r.dtype=='float64','inv real dtype 31')
 assert(list_same(r:tolist(),{(0/0),(0/0),3.141592653589793,1.5707963267948966,0.0,(0/0),(0/0)},6e-12,false,true),'inv real arccos 31')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int64)
 local r=np.arctan(a)
 assert(r.dtype=='float64','inv real dtype 32')
 assert(list_same(r:tolist(),{-1.3258176636680326,-1.1071487177940904,-0.7853981633974483,0.0,0.7853981633974483,1.1071487177940904,1.3258176636680326},6e-12,false,true),'inv real arctan 32')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int64)
 local r=np.arcsinh(a)
 assert(r.dtype=='float64','inv real dtype 33')
 assert(list_same(r:tolist(),{-2.0947125472611012,-1.4436354751788103,-0.881373587019543,0.0,0.881373587019543,1.4436354751788103,2.0947125472611012},6e-12,false,true),'inv real arcsinh 33')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int64)
 local r=np.arccosh(a)
 assert(r.dtype=='float64','inv real dtype 34')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),(0/0),0.0,1.3169578969248168,2.0634370688955603},6e-12,false,true),'inv real arccosh 34')
end
do
 local a=np.array({-4.0,-2.0,-1.0,0.0,1.0,2.0,4.0},np.int64)
 local r=np.arctanh(a)
 assert(r.dtype=='float64','inv real dtype 35')
 assert(list_same(r:tolist(),{(0/0),(0/0),-math.huge,0.0,math.huge,(0/0),(0/0)},6e-12,false,true),'inv real arctanh 35')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.float16)
 local r=np.arcsin(a)
 assert(r.dtype=='float16','inv real dtype 36')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),-1.5703125,-0.0,0.0,0.252685546875,0.84814453125,1.5703125,(0/0),(0/0),(0/0),(0/0)},0.004,false,true),'inv real arcsin 36')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.float16)
 local r=np.arccos(a)
 assert(r.dtype=='float16','inv real dtype 37')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),3.140625,1.5703125,1.5703125,1.318359375,0.72265625,0.0,(0/0),(0/0),(0/0),(0/0)},0.004,false,true),'inv real arccos 37')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.float16)
 local r=np.arctan(a)
 assert(r.dtype=='float16','inv real dtype 38')
 assert(list_same(r:tolist(),{-1.5703125,-1.326171875,-1.107421875,-0.78515625,-0.0,0.0,0.2449951171875,0.6435546875,0.78515625,1.107421875,1.326171875,1.5703125,(0/0)},0.004,false,true),'inv real arctan 38')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.float16)
 local r=np.arcsinh(a)
 assert(r.dtype=='float16','inv real dtype 39')
 assert(list_same(r:tolist(),{-math.huge,-2.09375,-1.443359375,-0.88134765625,-0.0,0.0,0.2474365234375,0.693359375,0.88134765625,1.443359375,2.09375,math.huge,(0/0)},0.004,false,true),'inv real arcsinh 39')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.float16)
 local r=np.arccosh(a)
 assert(r.dtype=='float16','inv real dtype 40')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),0.0,1.3173828125,2.0625,math.huge,(0/0)},0.004,false,true),'inv real arccosh 40')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.float16)
 local r=np.arctanh(a)
 assert(r.dtype=='float16','inv real dtype 41')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),-math.huge,-0.0,0.0,0.25537109375,0.97314453125,math.huge,(0/0),(0/0),(0/0),(0/0)},0.004,false,true),'inv real arctanh 41')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.float32)
 local r=np.arcsin(a)
 assert(r.dtype=='float32','inv real dtype 42')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),-1.5707963705062866,-0.0,0.0,0.252680242061615,0.8480621576309204,1.5707963705062866,(0/0),(0/0),(0/0),(0/0)},8e-05,false,true),'inv real arcsin 42')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.float32)
 local r=np.arccos(a)
 assert(r.dtype=='float32','inv real dtype 43')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),3.1415927410125732,1.5707963705062866,1.5707963705062866,1.3181161880493164,0.7227342128753662,0.0,(0/0),(0/0),(0/0),(0/0)},8e-05,false,true),'inv real arccos 43')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.float32)
 local r=np.arctan(a)
 assert(r.dtype=='float32','inv real dtype 44')
 assert(list_same(r:tolist(),{-1.5707963705062866,-1.3258177042007446,-1.1071487665176392,-0.7853981852531433,-0.0,0.0,0.244978666305542,0.6435011029243469,0.7853981852531433,1.1071487665176392,1.3258177042007446,1.5707963705062866,(0/0)},8e-05,false,true),'inv real arctan 44')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.float32)
 local r=np.arcsinh(a)
 assert(r.dtype=='float32','inv real dtype 45')
 assert(list_same(r:tolist(),{-math.huge,-2.094712495803833,-1.4436354637145996,-0.8813735842704773,-0.0,0.0,0.24746645987033844,0.6931471824645996,0.8813735842704773,1.4436354637145996,2.094712495803833,math.huge,(0/0)},8e-05,false,true),'inv real arcsinh 45')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.float32)
 local r=np.arccosh(a)
 assert(r.dtype=='float32','inv real dtype 46')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),0.0,1.316957950592041,2.063436985015869,math.huge,(0/0)},8e-05,false,true),'inv real arccosh 46')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.float32)
 local r=np.arctanh(a)
 assert(r.dtype=='float32','inv real dtype 47')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),-math.huge,-0.0,0.0,0.2554128170013428,0.972955048084259,math.huge,(0/0),(0/0),(0/0),(0/0)},8e-05,false,true),'inv real arctanh 47')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.float64)
 local r=np.arcsin(a)
 assert(r.dtype=='float64','inv real dtype 48')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),-1.5707963267948966,-0.0,0.0,0.25268025514207865,0.848062078981481,1.5707963267948966,(0/0),(0/0),(0/0),(0/0)},6e-12,false,true),'inv real arcsin 48')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.float64)
 local r=np.arccos(a)
 assert(r.dtype=='float64','inv real dtype 49')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),3.141592653589793,1.5707963267948966,1.5707963267948966,1.318116071652818,0.7227342478134156,0.0,(0/0),(0/0),(0/0),(0/0)},6e-12,false,true),'inv real arccos 49')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.float64)
 local r=np.arctan(a)
 assert(r.dtype=='float64','inv real dtype 50')
 assert(list_same(r:tolist(),{-1.5707963267948966,-1.3258176636680326,-1.1071487177940904,-0.7853981633974483,-0.0,0.0,0.24497866312686414,0.6435011087932844,0.7853981633974483,1.1071487177940904,1.3258176636680326,1.5707963267948966,(0/0)},6e-12,false,true),'inv real arctan 50')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.float64)
 local r=np.arcsinh(a)
 assert(r.dtype=='float64','inv real dtype 51')
 assert(list_same(r:tolist(),{-math.huge,-2.0947125472611012,-1.4436354751788103,-0.881373587019543,-0.0,0.0,0.24746646154726346,0.6931471805599453,0.881373587019543,1.4436354751788103,2.0947125472611012,math.huge,(0/0)},6e-12,false,true),'inv real arcsinh 51')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.float64)
 local r=np.arccosh(a)
 assert(r.dtype=='float64','inv real dtype 52')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),0.0,1.3169578969248168,2.0634370688955603,math.huge,(0/0)},6e-12,false,true),'inv real arccosh 52')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.float64)
 local r=np.arctanh(a)
 assert(r.dtype=='float64','inv real dtype 53')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),-math.huge,-0.0,0.0,0.25541281188299536,0.9729550745276566,math.huge,(0/0),(0/0),(0/0),(0/0)},6e-12,false,true),'inv real arctanh 53')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.longdouble)
 local r=np.arcsin(a)
 assert(r.dtype=='longdouble','inv real dtype 54')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),-1.5707963267948966,-0.0,0.0,0.25268025514207865,0.848062078981481,1.5707963267948966,(0/0),(0/0),(0/0),(0/0)},6e-12,false,true),'inv real arcsin 54')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.longdouble)
 local r=np.arccos(a)
 assert(r.dtype=='longdouble','inv real dtype 55')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),3.141592653589793,1.5707963267948966,1.5707963267948966,1.318116071652818,0.7227342478134157,0.0,(0/0),(0/0),(0/0),(0/0)},6e-12,false,true),'inv real arccos 55')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.longdouble)
 local r=np.arctan(a)
 assert(r.dtype=='longdouble','inv real dtype 56')
 assert(list_same(r:tolist(),{-1.5707963267948966,-1.3258176636680326,-1.1071487177940904,-0.7853981633974483,-0.0,0.0,0.24497866312686414,0.6435011087932844,0.7853981633974483,1.1071487177940904,1.3258176636680326,1.5707963267948966,(0/0)},6e-12,false,true),'inv real arctan 56')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.longdouble)
 local r=np.arcsinh(a)
 assert(r.dtype=='longdouble','inv real dtype 57')
 assert(list_same(r:tolist(),{-math.huge,-2.0947125472611012,-1.4436354751788103,-0.881373587019543,-0.0,0.0,0.24746646154726346,0.6931471805599453,0.881373587019543,1.4436354751788103,2.0947125472611012,math.huge,(0/0)},6e-12,false,true),'inv real arcsinh 57')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.longdouble)
 local r=np.arccosh(a)
 assert(r.dtype=='longdouble','inv real dtype 58')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),0.0,1.3169578969248168,2.0634370688955603,math.huge,(0/0)},6e-12,false,true),'inv real arccosh 58')
end
do
 local a=np.array({-math.huge,-4.0,-2.0,-1.0,-0.0,0.0,0.25,0.75,1.0,2.0,4.0,math.huge,(0/0)},np.longdouble)
 local r=np.arctanh(a)
 assert(r.dtype=='longdouble','inv real dtype 59')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),-math.huge,-0.0,0.0,0.25541281188299536,0.9729550745276566,math.huge,(0/0),(0/0),(0/0),(0/0)},6e-12,false,true),'inv real arctanh 59')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(-2.0,-0.0),np.complex(-1.0,0.0),np.complex(-1.0,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(1.0,0.0),np.complex(1.0,-0.0),np.complex(2.0,0.0),np.complex(2.0,-0.0),np.complex(0.0,1.0),np.complex(0.0,-1.0),np.complex(0.0,2.0),np.complex(0.0,-2.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,math.huge),np.complex(-math.huge,-math.huge),np.complex((0/0),0.0),np.complex(0.0,(0/0)),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex64)
 local r=np.arcsin(a)
 assert(r.dtype=='complex64','inv complex dtype 60')
 assert(list_same(r:tolist(),{np.complex(-1.5707963705062866,1.316957950592041),np.complex(-1.5707963705062866,-1.316957950592041),np.complex(-1.5707963705062866,0.0),np.complex(-1.5707963705062866,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(1.5707963705062866,0.0),np.complex(1.5707963705062866,-0.0),np.complex(1.5707963705062866,1.316957950592041),np.complex(1.5707963705062866,-1.316957950592041),np.complex(0.0,0.8813736438751221),np.complex(0.0,-0.8813736438751221),np.complex(0.0,1.4436354637145996),np.complex(0.0,-1.4436354637145996),np.complex(1.5707963705062866,math.huge),np.complex(-1.5707963705062866,math.huge),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(0.7853981852531433,math.huge),np.complex(-0.7853981852531433,-math.huge),np.complex((0/0),(0/0)),np.complex(0.0,(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},0.00024000000000000003,true,true),'inv complex arcsin 60')
end
do
 local a=np.array({np.complex(0.25,-1.0),np.complex(0.75,-1.0),np.complex(0.0,1.0),np.complex(0.0,0.0),np.complex(1.0,0.0),np.complex(0.75,-0.0),np.complex(-0.0,1.0),np.complex(-0.0,-1.0),np.complex(-5.0,0.5),np.complex(1.0,3.0),np.complex(-0.0,0.0),np.complex(2.0,1.0),np.complex(2.0,-1.0)},np.complex64)
 local r=np.arcsin(a)
 assert(r.dtype=='complex64','inv complex dtype 61')
 assert(list_same(r:tolist(),{np.complex(0.17630243301391602,-0.8924633860588074),np.complex(0.5148381590843201,-0.982866108417511),np.complex(0.0,0.8813736438751221),np.complex(0.0,0.0),np.complex(1.5707963705062866,0.0),np.complex(0.8480620980262756,-0.0),np.complex(-0.0,0.8813736438751221),np.complex(-0.0,-0.8813736438751221),np.complex(-1.4691081047058105,2.2977170944213867),np.complex(0.307603657245636,1.8641616106033325),np.complex(-0.0,0.0),np.complex(1.063439965248108,1.4693516492843628),np.complex(1.063439965248108,-1.4693516492843628)},0.00024000000000000003,true,true),'inv complex arcsin 61')
end
do
 local a=np.array({np.complex(-5.0,0.5),np.complex(-5.0,-3.0),np.complex(5.0,-3.0),np.complex(-0.0,1.0),np.complex(1.0,-3.0),np.complex(2.0,-0.0),np.complex(-2.0,-0.0),np.complex(0.0,0.5),np.complex(-5.0,0.0),np.complex(1.0,-3.0),np.complex(1.0,-3.0),np.complex(-2.0,-0.0),np.complex(-5.0,-0.0)},np.complex64)
 local r=np.arcsin(a)
 assert(r.dtype=='complex64','inv complex dtype 62')
 assert(list_same(r:tolist(),{np.complex(-1.4691081047058105,2.2977170944213867),np.complex(-1.0238217115402222,-2.452913761138916),np.complex(1.0238217115402222,-2.452913761138916),np.complex(-0.0,0.8813736438751221),np.complex(0.307603657245636,-1.8641616106033325),np.complex(1.5707963705062866,-1.316957950592041),np.complex(-1.5707963705062866,-1.316957950592041),np.complex(0.0,0.4812118411064148),np.complex(-1.5707963705062866,2.292431592941284),np.complex(0.307603657245636,-1.8641616106033325),np.complex(0.307603657245636,-1.8641616106033325),np.complex(-1.5707963705062866,-1.316957950592041),np.complex(-1.5707963705062866,-2.292431592941284)},0.00024000000000000003,true,true),'inv complex arcsin 62')
end
do
 local a=np.array({np.complex(0.0,0.5),np.complex(5.0,0.5),np.complex(-5.0,-1.0),np.complex(-0.0,1.0),np.complex(0.0,-0.0),np.complex(0.0,0.0),np.complex(-0.0,-1.0),np.complex(0.75,3.0),np.complex(0.0,0.5),np.complex(0.75,1.0),np.complex(-2.0,3.0),np.complex(-5.0,0.5),np.complex(0.25,0.5)},np.complex64)
 local r=np.arcsin(a)
 assert(r.dtype=='complex64','inv complex dtype 63')
 assert(list_same(r:tolist(),{np.complex(0.0,0.4812118411064148),np.complex(1.4691081047058105,2.2977170944213867),np.complex(-1.3696012496948242,-2.313220977783203),np.complex(-0.0,0.8813736438751221),np.complex(0.0,-0.0),np.complex(0.0,0.0),np.complex(-0.0,-0.8813736438751221),np.complex(0.23347146809101105,1.8445760011672974),np.complex(0.0,0.4812118411064148),np.complex(0.5148381590843201,0.982866108417511),np.complex(-0.5706527829170227,1.9833869934082031),np.complex(-1.4691081047058105,2.2977170944213867),np.complex(0.2243284434080124,0.49267566204071045)},0.00024000000000000003,true,true),'inv complex arcsin 63')
end
do
 local a=np.array({np.complex(-5.0,1.0),np.complex(2.0,0.0),np.complex(-1.0,0.5),np.complex(0.25,1.0),np.complex(1.0,1.0),np.complex(5.0,1.0),np.complex(-0.0,1.0),np.complex(-2.0,-3.0),np.complex(-0.0,1.0),np.complex(-5.0,0.5),np.complex(2.0,1.0),np.complex(5.0,0.5),np.complex(-0.0,0.5)},np.complex64)
 local r=np.arcsin(a)
 assert(r.dtype=='complex64','inv complex dtype 64')
 assert(list_same(r:tolist(),{np.complex(-1.3696012496948242,2.313220977783203),np.complex(1.5707963705062866,1.316957950592041),np.complex(-0.8959074020385742,0.7328576445579529),np.complex(0.17630243301391602,0.8924633860588074),np.complex(0.6662394404411316,1.0612751245498657),np.complex(1.3696012496948242,2.313220977783203),np.complex(-0.0,0.8813736438751221),np.complex(-0.5706527829170227,-1.9833869934082031),np.complex(-0.0,0.8813736438751221),np.complex(-1.4691081047058105,2.2977170944213867),np.complex(1.063439965248108,1.4693516492843628),np.complex(1.4691081047058105,2.2977170944213867),np.complex(-0.0,0.4812118411064148)},0.00024000000000000003,true,true),'inv complex arcsin 64')
end
do
 local a=np.array({np.complex(0.0,0.5),np.complex(-1.0,1.0),np.complex(-2.0,-3.0),np.complex(2.0,0.5),np.complex(0.0,0.0),np.complex(-2.0,-3.0),np.complex(2.0,-1.0),np.complex(-5.0,0.5),np.complex(1.0,0.5),np.complex(-1.0,-1.0),np.complex(-2.0,1.0),np.complex(0.75,0.0),np.complex(2.0,0.0)},np.complex64)
 local r=np.arcsin(a)
 assert(r.dtype=='complex64','inv complex dtype 65')
 assert(list_same(r:tolist(),{np.complex(0.0,0.4812118411064148),np.complex(-0.6662394404411316,1.0612751245498657),np.complex(-0.5706527829170227,-1.9833869934082031),np.complex(1.2930420637130737,1.3618009090423584),np.complex(0.0,0.0),np.complex(-0.5706527829170227,-1.9833869934082031),np.complex(1.063439965248108,-1.4693516492843628),np.complex(-1.4691081047058105,2.2977170944213867),np.complex(0.8959074020385742,0.7328576445579529),np.complex(-0.6662394404411316,-1.0612751245498657),np.complex(-1.063439965248108,1.4693516492843628),np.complex(0.8480620980262756,0.0),np.complex(1.5707963705062866,1.316957950592041)},0.00024000000000000003,true,true),'inv complex arcsin 65')
end
do
 local a=np.array({np.complex(0.0,-3.0),np.complex(2.0,-0.0),np.complex(1.0,-1.0),np.complex(-2.0,-3.0),np.complex(-2.0,-1.0),np.complex(-0.0,0.0),np.complex(-1.0,-1.0),np.complex(-0.0,-0.0),np.complex(-1.0,0.0),np.complex(0.25,0.0),np.complex(2.0,0.0),np.complex(-5.0,1.0),np.complex(-2.0,0.5)},np.complex64)
 local r=np.arcsin(a)
 assert(r.dtype=='complex64','inv complex dtype 66')
 assert(list_same(r:tolist(),{np.complex(0.0,-1.8184465169906616),np.complex(1.5707963705062866,-1.316957950592041),np.complex(0.6662394404411316,-1.0612751245498657),np.complex(-0.5706527829170227,-1.9833869934082031),np.complex(-1.063439965248108,-1.4693516492843628),np.complex(-0.0,0.0),np.complex(-0.6662394404411316,-1.0612751245498657),np.complex(-0.0,-0.0),np.complex(-1.5707963705062866,0.0),np.complex(0.252680242061615,0.0),np.complex(1.5707963705062866,1.316957950592041),np.complex(-1.3696012496948242,2.313220977783203),np.complex(-1.2930420637130737,1.3618009090423584)},0.00024000000000000003,true,true),'inv complex arcsin 66')
end
do
 local a=np.array({np.complex(1.0,1.0),np.complex(0.75,1.0),np.complex(0.75,0.0),np.complex(0.0,-0.0),np.complex(0.0,0.0),np.complex(-0.0,-3.0),np.complex(-1.0,0.0),np.complex(2.0,0.0),np.complex(0.25,-1.0),np.complex(1.0,0.5),np.complex(-0.0,0.5),np.complex(-1.0,3.0),np.complex(-0.0,0.5)},np.complex64)
 local r=np.arcsin(a)
 assert(r.dtype=='complex64','inv complex dtype 67')
 assert(list_same(r:tolist(),{np.complex(0.6662394404411316,1.0612751245498657),np.complex(0.5148381590843201,0.982866108417511),np.complex(0.8480620980262756,0.0),np.complex(0.0,-0.0),np.complex(0.0,0.0),np.complex(-0.0,-1.8184465169906616),np.complex(-1.5707963705062866,0.0),np.complex(1.5707963705062866,1.316957950592041),np.complex(0.17630243301391602,-0.8924633860588074),np.complex(0.8959074020385742,0.7328576445579529),np.complex(-0.0,0.4812118411064148),np.complex(-0.307603657245636,1.8641616106033325),np.complex(-0.0,0.4812118411064148)},0.00024000000000000003,true,true),'inv complex arcsin 67')
end
do
 local a=np.array({np.complex(5.0,-0.0),np.complex(0.0,0.5),np.complex(5.0,3.0),np.complex(5.0,-0.0),np.complex(0.75,3.0),np.complex(0.25,-3.0),np.complex(0.25,0.0),np.complex(-0.0,-0.0),np.complex(-5.0,-3.0),np.complex(2.0,-3.0),np.complex(-1.0,1.0),np.complex(-5.0,0.5),np.complex(0.0,-0.0)},np.complex64)
 local r=np.arcsin(a)
 assert(r.dtype=='complex64','inv complex dtype 68')
 assert(list_same(r:tolist(),{np.complex(1.5707963705062866,-2.292431592941284),np.complex(0.0,0.4812118411064148),np.complex(1.0238217115402222,2.452913761138916),np.complex(1.5707963705062866,-2.292431592941284),np.complex(0.23347146809101105,1.8445760011672974),np.complex(0.07891727983951569,-1.821404218673706),np.complex(0.252680242061615,0.0),np.complex(-0.0,-0.0),np.complex(-1.0238217115402222,-2.452913761138916),np.complex(0.5706527829170227,-1.9833869934082031),np.complex(-0.6662394404411316,1.0612751245498657),np.complex(-1.4691081047058105,2.2977170944213867),np.complex(0.0,-0.0)},0.00024000000000000003,true,true),'inv complex arcsin 68')
end
do
 local a=np.array({np.complex(-0.0,0.5),np.complex(0.25,3.0),np.complex(0.0,-1.0),np.complex(0.25,-0.0),np.complex(0.75,3.0),np.complex(-1.0,-0.0),np.complex(0.25,3.0),np.complex(-2.0,0.0),np.complex(2.0,3.0),np.complex(-2.0,-0.0),np.complex(-0.0,-0.0),np.complex(2.0,-1.0),np.complex(0.75,0.5)},np.complex64)
 local r=np.arcsin(a)
 assert(r.dtype=='complex64','inv complex dtype 69')
 assert(list_same(r:tolist(),{np.complex(-0.0,0.4812118411064148),np.complex(0.07891727983951569,1.821404218673706),np.complex(0.0,-0.8813736438751221),np.complex(0.252680242061615,-0.0),np.complex(0.23347146809101105,1.8445760011672974),np.complex(-1.5707963705062866,-0.0),np.complex(0.07891727983951569,1.821404218673706),np.complex(-1.5707963705062866,1.316957950592041),np.complex(0.5706527829170227,1.9833869934082031),np.complex(-1.5707963705062866,-1.316957950592041),np.complex(-0.0,-0.0),np.complex(1.063439965248108,-1.4693516492843628),np.complex(0.6822039484977722,0.6063349843025208)},0.00024000000000000003,true,true),'inv complex arcsin 69')
end
do
 local a=np.array({np.complex(-5.0,1.0),np.complex(-1.0,-1.0),np.complex(0.25,-3.0),np.complex(-0.0,-0.0),np.complex(1.0,0.0),np.complex(5.0,3.0),np.complex(5.0,0.5),np.complex(-2.0,3.0),np.complex(1.0,1.0),np.complex(0.25,-0.0),np.complex(2.0,0.0),np.complex(-5.0,0.5),np.complex(5.0,-1.0)},np.complex64)
 local r=np.arcsin(a)
 assert(r.dtype=='complex64','inv complex dtype 70')
 assert(list_same(r:tolist(),{np.complex(-1.3696012496948242,2.313220977783203),np.complex(-0.6662394404411316,-1.0612751245498657),np.complex(0.07891727983951569,-1.821404218673706),np.complex(-0.0,-0.0),np.complex(1.5707963705062866,0.0),np.complex(1.0238217115402222,2.452913761138916),np.complex(1.4691081047058105,2.2977170944213867),np.complex(-0.5706527829170227,1.9833869934082031),np.complex(0.6662394404411316,1.0612751245498657),np.complex(0.252680242061615,-0.0),np.complex(1.5707963705062866,1.316957950592041),np.complex(-1.4691081047058105,2.2977170944213867),np.complex(1.3696012496948242,-2.313220977783203)},0.00024000000000000003,true,true),'inv complex arcsin 70')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(-2.0,-0.0),np.complex(-1.0,0.0),np.complex(-1.0,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(1.0,0.0),np.complex(1.0,-0.0),np.complex(2.0,0.0),np.complex(2.0,-0.0),np.complex(0.0,1.0),np.complex(0.0,-1.0),np.complex(0.0,2.0),np.complex(0.0,-2.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,math.huge),np.complex(-math.huge,-math.huge),np.complex((0/0),0.0),np.complex(0.0,(0/0)),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex64)
 local r=np.arccos(a)
 assert(r.dtype=='complex64','inv complex dtype 71')
 assert(list_same(r:tolist(),{np.complex(3.1415927410125732,-1.316957950592041),np.complex(3.1415927410125732,1.316957950592041),np.complex(3.1415927410125732,-0.0),np.complex(3.1415927410125732,0.0),np.complex(1.5707963705062866,-0.0),np.complex(1.5707963705062866,0.0),np.complex(1.5707963705062866,-0.0),np.complex(1.5707963705062866,0.0),np.complex(0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-1.316957950592041),np.complex(0.0,1.316957950592041),np.complex(1.5707963705062866,-0.8813736438751221),np.complex(1.5707963705062866,0.8813736438751221),np.complex(1.5707963705062866,-1.4436354637145996),np.complex(1.5707963705062866,1.4436354637145996),np.complex(0.0,-math.huge),np.complex(3.1415927410125732,-math.huge),np.complex(1.5707963705062866,-math.huge),np.complex(1.5707963705062866,math.huge),np.complex(0.7853981852531433,-math.huge),np.complex(2.356194496154785,math.huge),np.complex((0/0),(0/0)),np.complex(1.5707963705062866,(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},0.00024000000000000003,true,true),'inv complex arccos 71')
end
do
 local a=np.array({np.complex(1.0,3.0),np.complex(5.0,-0.0),np.complex(-5.0,0.0),np.complex(-1.0,0.5),np.complex(-0.0,-1.0),np.complex(0.75,1.0),np.complex(0.75,0.5),np.complex(0.75,1.0),np.complex(-2.0,3.0),np.complex(-1.0,0.5),np.complex(-5.0,0.5),np.complex(0.0,-0.0),np.complex(2.0,0.5)},np.complex64)
 local r=np.arccos(a)
 assert(r.dtype=='complex64','inv complex dtype 72')
 assert(list_same(r:tolist(),{np.complex(1.2631926536560059,-1.8641616106033325),np.complex(0.0,2.292431592941284),np.complex(3.1415927410125732,-2.292431592941284),np.complex(2.4667036533355713,-0.7328576445579529),np.complex(1.5707963705062866,0.8813736438751221),np.complex(1.0559581518173218,-0.982866108417511),np.complex(0.8885923624038696,-0.6063349843025208),np.complex(1.0559581518173218,-0.982866108417511),np.complex(2.141449213027954,-1.9833869934082031),np.complex(2.4667036533355713,-0.7328576445579529),np.complex(3.0399043560028076,-2.2977170944213867),np.complex(1.5707963705062866,0.0),np.complex(0.2777542471885681,-1.3618009090423584)},0.00024000000000000003,true,true),'inv complex arccos 72')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(1.0,0.0),np.complex(-0.0,-3.0),np.complex(-2.0,-1.0),np.complex(-0.0,0.5),np.complex(1.0,-3.0),np.complex(5.0,3.0),np.complex(-0.0,-3.0),np.complex(5.0,-0.0),np.complex(2.0,0.5),np.complex(0.75,0.5),np.complex(-1.0,0.5),np.complex(0.25,3.0)},np.complex64)
 local r=np.arccos(a)
 assert(r.dtype=='complex64','inv complex dtype 73')
 assert(list_same(r:tolist(),{np.complex(3.1415927410125732,-1.316957950592041),np.complex(0.0,-0.0),np.complex(1.5707963705062866,1.8184465169906616),np.complex(2.6342363357543945,1.4693516492843628),np.complex(1.5707963705062866,-0.4812118411064148),np.complex(1.2631926536560059,1.8641616106033325),np.complex(0.5469745993614197,-2.452913761138916),np.complex(1.5707963705062866,1.8184465169906616),np.complex(0.0,2.292431592941284),np.complex(0.2777542471885681,-1.3618009090423584),np.complex(0.8885923624038696,-0.6063349843025208),np.complex(2.4667036533355713,-0.7328576445579529),np.complex(1.4918789863586426,-1.821404218673706)},0.00024000000000000003,true,true),'inv complex arccos 73')
end
do
 local a=np.array({np.complex(0.25,-1.0),np.complex(1.0,-3.0),np.complex(1.0,1.0),np.complex(0.25,0.5),np.complex(0.25,3.0),np.complex(0.75,-0.0),np.complex(5.0,-0.0),np.complex(0.0,0.0),np.complex(-5.0,-1.0),np.complex(-2.0,0.0),np.complex(-2.0,-0.0),np.complex(-2.0,0.0),np.complex(-2.0,1.0)},np.complex64)
 local r=np.arccos(a)
 assert(r.dtype=='complex64','inv complex dtype 74')
 assert(list_same(r:tolist(),{np.complex(1.3944939374923706,0.8924633860588074),np.complex(1.2631926536560059,1.8641616106033325),np.complex(0.9045568704605103,-1.0612751245498657),np.complex(1.3464678525924683,-0.49267566204071045),np.complex(1.4918789863586426,-1.821404218673706),np.complex(0.7227342128753662,0.0),np.complex(0.0,2.292431592941284),np.complex(1.5707963705062866,-0.0),np.complex(2.9403975009918213,2.313220977783203),np.complex(3.1415927410125732,-1.316957950592041),np.complex(3.1415927410125732,1.316957950592041),np.complex(3.1415927410125732,-1.316957950592041),np.complex(2.6342363357543945,-1.4693516492843628)},0.00024000000000000003,true,true),'inv complex arccos 74')
end
do
 local a=np.array({np.complex(2.0,3.0),np.complex(0.75,-0.0),np.complex(2.0,-0.0),np.complex(-2.0,3.0),np.complex(0.0,-1.0),np.complex(-2.0,-3.0),np.complex(5.0,-1.0),np.complex(-1.0,-1.0),np.complex(-0.0,-3.0),np.complex(0.0,-3.0),np.complex(0.25,3.0),np.complex(1.0,-0.0),np.complex(0.0,3.0)},np.complex64)
 local r=np.arccos(a)
 assert(r.dtype=='complex64','inv complex dtype 75')
 assert(list_same(r:tolist(),{np.complex(1.0001435279846191,-1.9833869934082031),np.complex(0.7227342128753662,0.0),np.complex(0.0,1.316957950592041),np.complex(2.141449213027954,-1.9833869934082031),np.complex(1.5707963705062866,0.8813736438751221),np.complex(2.141449213027954,1.9833869934082031),np.complex(0.20119507610797882,2.313220977783203),np.complex(2.2370357513427734,1.0612751245498657),np.complex(1.5707963705062866,1.8184465169906616),np.complex(1.5707963705062866,1.8184465169906616),np.complex(1.4918789863586426,-1.821404218673706),np.complex(0.0,0.0),np.complex(1.5707963705062866,-1.8184465169906616)},0.00024000000000000003,true,true),'inv complex arccos 75')
end
do
 local a=np.array({np.complex(0.25,1.0),np.complex(0.25,-1.0),np.complex(-0.0,3.0),np.complex(-2.0,-0.0),np.complex(-1.0,0.5),np.complex(0.25,0.0),np.complex(0.25,0.0),np.complex(0.25,0.5),np.complex(1.0,1.0),np.complex(-2.0,-0.0),np.complex(2.0,-0.0),np.complex(1.0,0.0),np.complex(-1.0,0.5)},np.complex64)
 local r=np.arccos(a)
 assert(r.dtype=='complex64','inv complex dtype 76')
 assert(list_same(r:tolist(),{np.complex(1.3944939374923706,-0.8924633860588074),np.complex(1.3944939374923706,0.8924633860588074),np.complex(1.5707963705062866,-1.8184465169906616),np.complex(3.1415927410125732,1.316957950592041),np.complex(2.4667036533355713,-0.7328576445579529),np.complex(1.3181160688400269,-0.0),np.complex(1.3181160688400269,-0.0),np.complex(1.3464678525924683,-0.49267566204071045),np.complex(0.9045568704605103,-1.0612751245498657),np.complex(3.1415927410125732,1.316957950592041),np.complex(0.0,1.316957950592041),np.complex(0.0,-0.0),np.complex(2.4667036533355713,-0.7328576445579529)},0.00024000000000000003,true,true),'inv complex arccos 76')
end
do
 local a=np.array({np.complex(-0.0,-0.0),np.complex(0.0,-1.0),np.complex(-1.0,-1.0),np.complex(-1.0,-1.0),np.complex(5.0,-1.0),np.complex(-0.0,-0.0),np.complex(-1.0,-1.0),np.complex(-5.0,0.0),np.complex(0.0,1.0),np.complex(-2.0,-3.0),np.complex(0.0,0.0),np.complex(-2.0,3.0),np.complex(-2.0,-0.0)},np.complex64)
 local r=np.arccos(a)
 assert(r.dtype=='complex64','inv complex dtype 77')
 assert(list_same(r:tolist(),{np.complex(1.5707963705062866,0.0),np.complex(1.5707963705062866,0.8813736438751221),np.complex(2.2370357513427734,1.0612751245498657),np.complex(2.2370357513427734,1.0612751245498657),np.complex(0.20119507610797882,2.313220977783203),np.complex(1.5707963705062866,0.0),np.complex(2.2370357513427734,1.0612751245498657),np.complex(3.1415927410125732,-2.292431592941284),np.complex(1.5707963705062866,-0.8813736438751221),np.complex(2.141449213027954,1.9833869934082031),np.complex(1.5707963705062866,-0.0),np.complex(2.141449213027954,-1.9833869934082031),np.complex(3.1415927410125732,1.316957950592041)},0.00024000000000000003,true,true),'inv complex arccos 77')
end
do
 local a=np.array({np.complex(0.25,0.5),np.complex(-1.0,-1.0),np.complex(0.75,-0.0),np.complex(5.0,-0.0),np.complex(-5.0,0.0),np.complex(2.0,0.5),np.complex(2.0,0.5),np.complex(-5.0,-3.0),np.complex(-5.0,0.5),np.complex(0.75,0.0),np.complex(-2.0,3.0),np.complex(0.0,-3.0),np.complex(0.0,-0.0)},np.complex64)
 local r=np.arccos(a)
 assert(r.dtype=='complex64','inv complex dtype 78')
 assert(list_same(r:tolist(),{np.complex(1.3464678525924683,-0.49267566204071045),np.complex(2.2370357513427734,1.0612751245498657),np.complex(0.7227342128753662,0.0),np.complex(0.0,2.292431592941284),np.complex(3.1415927410125732,-2.292431592941284),np.complex(0.2777542471885681,-1.3618009090423584),np.complex(0.2777542471885681,-1.3618009090423584),np.complex(2.594618082046509,2.452913761138916),np.complex(3.0399043560028076,-2.2977170944213867),np.complex(0.7227342128753662,-0.0),np.complex(2.141449213027954,-1.9833869934082031),np.complex(1.5707963705062866,1.8184465169906616),np.complex(1.5707963705062866,0.0)},0.00024000000000000003,true,true),'inv complex arccos 78')
end
do
 local a=np.array({np.complex(2.0,-0.0),np.complex(2.0,3.0),np.complex(0.0,-0.0),np.complex(-0.0,0.0),np.complex(-5.0,3.0),np.complex(0.25,0.5),np.complex(-0.0,0.0),np.complex(-0.0,0.5),np.complex(-0.0,0.5),np.complex(0.25,-3.0),np.complex(-0.0,0.5),np.complex(0.75,-1.0),np.complex(-2.0,-1.0)},np.complex64)
 local r=np.arccos(a)
 assert(r.dtype=='complex64','inv complex dtype 79')
 assert(list_same(r:tolist(),{np.complex(0.0,1.316957950592041),np.complex(1.0001435279846191,-1.9833869934082031),np.complex(1.5707963705062866,0.0),np.complex(1.5707963705062866,-0.0),np.complex(2.594618082046509,-2.452913761138916),np.complex(1.3464678525924683,-0.49267566204071045),np.complex(1.5707963705062866,-0.0),np.complex(1.5707963705062866,-0.4812118411064148),np.complex(1.5707963705062866,-0.4812118411064148),np.complex(1.4918789863586426,1.821404218673706),np.complex(1.5707963705062866,-0.4812118411064148),np.complex(1.0559581518173218,0.982866108417511),np.complex(2.6342363357543945,1.4693516492843628)},0.00024000000000000003,true,true),'inv complex arccos 79')
end
do
 local a=np.array({np.complex(2.0,3.0),np.complex(0.75,0.0),np.complex(-5.0,1.0),np.complex(-0.0,0.0),np.complex(2.0,1.0),np.complex(-0.0,-1.0),np.complex(0.25,3.0),np.complex(-2.0,1.0),np.complex(0.0,-0.0),np.complex(5.0,0.0),np.complex(-2.0,-3.0),np.complex(0.25,1.0),np.complex(1.0,1.0)},np.complex64)
 local r=np.arccos(a)
 assert(r.dtype=='complex64','inv complex dtype 80')
 assert(list_same(r:tolist(),{np.complex(1.0001435279846191,-1.9833869934082031),np.complex(0.7227342128753662,-0.0),np.complex(2.9403975009918213,-2.313220977783203),np.complex(1.5707963705062866,-0.0),np.complex(0.5073562860488892,-1.4693516492843628),np.complex(1.5707963705062866,0.8813736438751221),np.complex(1.4918789863586426,-1.821404218673706),np.complex(2.6342363357543945,-1.4693516492843628),np.complex(1.5707963705062866,0.0),np.complex(0.0,-2.292431592941284),np.complex(2.141449213027954,1.9833869934082031),np.complex(1.3944939374923706,-0.8924633860588074),np.complex(0.9045568704605103,-1.0612751245498657)},0.00024000000000000003,true,true),'inv complex arccos 80')
end
do
 local a=np.array({np.complex(-1.0,0.0),np.complex(2.0,1.0),np.complex(0.75,0.5),np.complex(5.0,1.0),np.complex(0.75,-0.0),np.complex(-2.0,-0.0),np.complex(-1.0,-0.0),np.complex(-5.0,-3.0),np.complex(5.0,-1.0),np.complex(-1.0,1.0),np.complex(-5.0,3.0),np.complex(1.0,0.0),np.complex(2.0,0.5)},np.complex64)
 local r=np.arccos(a)
 assert(r.dtype=='complex64','inv complex dtype 81')
 assert(list_same(r:tolist(),{np.complex(3.1415927410125732,-0.0),np.complex(0.5073562860488892,-1.4693516492843628),np.complex(0.8885923624038696,-0.6063349843025208),np.complex(0.20119507610797882,-2.313220977783203),np.complex(0.7227342128753662,0.0),np.complex(3.1415927410125732,1.316957950592041),np.complex(3.1415927410125732,0.0),np.complex(2.594618082046509,2.452913761138916),np.complex(0.20119507610797882,2.313220977783203),np.complex(2.2370357513427734,-1.0612751245498657),np.complex(2.594618082046509,-2.452913761138916),np.complex(0.0,-0.0),np.complex(0.2777542471885681,-1.3618009090423584)},0.00024000000000000003,true,true),'inv complex arccos 81')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(-2.0,-0.0),np.complex(-1.0,0.0),np.complex(-1.0,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(1.0,0.0),np.complex(1.0,-0.0),np.complex(2.0,0.0),np.complex(2.0,-0.0),np.complex(0.0,1.0),np.complex(0.0,-1.0),np.complex(0.0,2.0),np.complex(0.0,-2.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,math.huge),np.complex(-math.huge,-math.huge),np.complex((0/0),0.0),np.complex(0.0,(0/0)),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex64)
 local r=np.arctan(a)
 assert(r.dtype=='complex64','inv complex dtype 82')
 assert(list_same(r:tolist(),{np.complex(-1.1071487665176392,0.0),np.complex(-1.1071487665176392,-0.0),np.complex(-0.7853981852531433,0.0),np.complex(-0.7853981852531433,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(0.7853981852531433,0.0),np.complex(0.7853981852531433,-0.0),np.complex(1.1071487665176392,0.0),np.complex(1.1071487665176392,-0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(1.5707963705062866,0.5493061542510986),np.complex(1.5707963705062866,-0.5493061542510986),np.complex(1.5707963705062866,0.0),np.complex(-1.5707963705062866,0.0),np.complex(1.5707963705062866,0.0),np.complex(1.5707963705062866,-0.0),np.complex(1.5707963705062866,0.0),np.complex(-1.5707963705062866,-0.0),np.complex((0/0),0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},0.00024000000000000003,true,true),'inv complex arctan 82')
end
do
 local a=np.array({np.complex(5.0,-0.0),np.complex(5.0,0.0),np.complex(0.75,-0.0),np.complex(5.0,-1.0),np.complex(-0.0,0.0),np.complex(-1.0,-3.0),np.complex(1.0,3.0),np.complex(2.0,-3.0),np.complex(-5.0,1.0),np.complex(0.25,3.0),np.complex(-5.0,-0.0),np.complex(-1.0,-3.0),np.complex(5.0,3.0)},np.complex64)
 local r=np.arctan(a)
 assert(r.dtype=='complex64','inv complex dtype 83')
 assert(list_same(r:tolist(),{np.complex(1.3734008073806763,-0.0),np.complex(1.3734008073806763,0.0),np.complex(0.6435011029243469,-0.0),np.complex(1.3805431127548218,-0.037105001509189606),np.complex(-0.0,0.0),np.complex(-1.4614619016647339,-0.3059438467025757),np.complex(1.4614619016647339,0.30594387650489807),np.complex(1.4099210500717163,-0.2290726751089096),np.complex(-1.3805431127548218,0.037105001509189606),np.complex(1.5398281812667847,0.3436722159385681),np.complex(-1.3734008073806763,-0.0),np.complex(-1.4614619016647339,-0.3059438467025757),np.complex(1.423678994178772,0.08656906336545944)},0.00024000000000000003,true,true),'inv complex arctan 83')
end
do
 local a=np.array({np.complex(2.0,1.0),np.complex(2.0,-1.0),np.complex(-2.0,0.5),np.complex(-0.0,3.0),np.complex(2.0,-0.0),np.complex(0.25,-0.0),np.complex(5.0,-0.0),np.complex(-0.0,3.0),np.complex(-5.0,-0.0),np.complex(5.0,0.0),np.complex(-5.0,1.0),np.complex(2.0,0.5),np.complex(0.75,-3.0)},np.complex64)
 local r=np.arctan(a)
 assert(r.dtype=='complex64','inv complex dtype 84')
 assert(list_same(r:tolist(),{np.complex(1.1780972480773926,0.1732867956161499),np.complex(1.1780972480773926,-0.1732867956161499),np.complex(-1.126556396484375,0.09641562402248383),np.complex(-1.5707963705062866,0.3465735912322998),np.complex(1.1071487665176392,-0.0),np.complex(0.244978666305542,-0.0),np.complex(1.3734008073806763,-0.0),np.complex(-1.5707963705062866,0.3465735912322998),np.complex(-1.3734008073806763,-0.0),np.complex(1.3734008073806763,0.0),np.complex(-1.3805431127548218,0.037105001509189606),np.complex(1.126556396484375,0.09641562402248383),np.complex(1.484084963798523,-0.32231760025024414)},0.00024000000000000003,true,true),'inv complex arctan 84')
end
do
 local a=np.array({np.complex(0.0,-3.0),np.complex(1.0,1.0),np.complex(5.0,-1.0),np.complex(-1.0,3.0),np.complex(-0.0,0.5),np.complex(-1.0,-0.0),np.complex(0.25,-0.0),np.complex(0.75,0.5),np.complex(0.25,0.5),np.complex(-0.0,-0.0),np.complex(-2.0,-1.0),np.complex(1.0,-0.0),np.complex(2.0,1.0)},np.complex64)
 local r=np.arctan(a)
 assert(r.dtype=='complex64','inv complex dtype 85')
 assert(list_same(r:tolist(),{np.complex(1.5707963705062866,-0.3465735912322998),np.complex(1.0172219276428223,0.4023594856262207),np.complex(1.3805431127548218,-0.037105001509189606),np.complex(-1.4614619016647339,0.30594387650489807),np.complex(-0.0,0.5493061542510986),np.complex(-0.7853981852531433,-0.0),np.complex(0.244978666305542,-0.0),np.complex(0.7232206463813782,0.31042829155921936),np.complex(0.3143981397151947,0.5003700256347656),np.complex(-0.0,-0.0),np.complex(-1.1780972480773926,-0.1732867956161499),np.complex(0.7853981852531433,-0.0),np.complex(1.1780972480773926,0.1732867956161499)},0.00024000000000000003,true,true),'inv complex arctan 85')
end
do
 local a=np.array({np.complex(0.25,-3.0),np.complex(5.0,1.0),np.complex(-0.0,-1.0),np.complex(1.0,1.0),np.complex(2.0,0.0),np.complex(0.0,-3.0),np.complex(0.0,0.0),np.complex(5.0,0.5),np.complex(0.0,1.0),np.complex(-0.0,3.0),np.complex(0.0,1.0),np.complex(5.0,3.0),np.complex(-5.0,-1.0)},np.complex64)
 local r=np.arctan(a)
 assert(r.dtype=='complex64','inv complex dtype 86')
 assert(list_same(r:tolist(),{np.complex(1.5398281812667847,-0.3436722159385681),np.complex(1.3805431127548218,0.037105001509189606),np.complex(-0.0,-math.huge),np.complex(1.0172219276428223,0.4023594856262207),np.complex(1.1071487665176392,0.0),np.complex(1.5707963705062866,-0.3465735912322998),np.complex(0.0,0.0),np.complex(1.3752336502075195,0.019056841731071472),np.complex(0.0,math.huge),np.complex(-1.5707963705062866,0.3465735912322998),np.complex(0.0,math.huge),np.complex(1.423678994178772,0.08656906336545944),np.complex(-1.3805431127548218,-0.037105001509189606)},0.00024000000000000003,true,true),'inv complex arctan 86')
end
do
 local a=np.array({np.complex(5.0,-0.0),np.complex(1.0,0.0),np.complex(-0.0,3.0),np.complex(0.75,-3.0),np.complex(1.0,1.0),np.complex(5.0,0.5),np.complex(0.0,1.0),np.complex(0.75,0.0),np.complex(-1.0,-0.0),np.complex(-0.0,-3.0),np.complex(0.25,-0.0),np.complex(0.75,3.0),np.complex(0.75,0.5)},np.complex64)
 local r=np.arctan(a)
 assert(r.dtype=='complex64','inv complex dtype 87')
 assert(list_same(r:tolist(),{np.complex(1.3734008073806763,-0.0),np.complex(0.7853981852531433,0.0),np.complex(-1.5707963705062866,0.3465735912322998),np.complex(1.484084963798523,-0.32231760025024414),np.complex(1.0172219276428223,0.4023594856262207),np.complex(1.3752336502075195,0.019056841731071472),np.complex(0.0,math.huge),np.complex(0.6435011029243469,0.0),np.complex(-0.7853981852531433,-0.0),np.complex(-1.5707963705062866,-0.3465735912322998),np.complex(0.244978666305542,-0.0),np.complex(1.484084963798523,0.32231760025024414),np.complex(0.7232206463813782,0.31042829155921936)},0.00024000000000000003,true,true),'inv complex arctan 87')
end
do
 local a=np.array({np.complex(-1.0,-0.0),np.complex(0.25,3.0),np.complex(-0.0,0.5),np.complex(-5.0,3.0),np.complex(0.75,-0.0),np.complex(-1.0,-1.0),np.complex(2.0,3.0),np.complex(5.0,-1.0),np.complex(2.0,0.0),np.complex(0.75,-0.0),np.complex(0.0,-0.0),np.complex(-0.0,3.0),np.complex(5.0,-3.0)},np.complex64)
 local r=np.arctan(a)
 assert(r.dtype=='complex64','inv complex dtype 88')
 assert(list_same(r:tolist(),{np.complex(-0.7853981852531433,-0.0),np.complex(1.5398281812667847,0.3436722159385681),np.complex(-0.0,0.5493061542510986),np.complex(-1.423678994178772,0.08656906336545944),np.complex(0.6435011029243469,-0.0),np.complex(-1.0172219276428223,-0.4023594856262207),np.complex(1.4099210500717163,0.2290726900100708),np.complex(1.3805431127548218,-0.037105001509189606),np.complex(1.1071487665176392,0.0),np.complex(0.6435011029243469,-0.0),np.complex(0.0,-0.0),np.complex(-1.5707963705062866,0.3465735912322998),np.complex(1.423678994178772,-0.08656905591487885)},0.00024000000000000003,true,true),'inv complex arctan 88')
end
do
 local a=np.array({np.complex(2.0,0.5),np.complex(-1.0,0.5),np.complex(-5.0,0.5),np.complex(1.0,-3.0),np.complex(-0.0,3.0),np.complex(2.0,-1.0),np.complex(5.0,1.0),np.complex(2.0,-1.0),np.complex(1.0,-0.0),np.complex(5.0,-0.0),np.complex(-1.0,0.5),np.complex(0.0,1.0),np.complex(0.0,0.5)},np.complex64)
 local r=np.arctan(a)
 assert(r.dtype=='complex64','inv complex dtype 89')
 assert(list_same(r:tolist(),{np.complex(1.126556396484375,0.09641562402248383),np.complex(-0.8475756645202637,0.23887786269187927),np.complex(-1.3752336502075195,0.019056841731071472),np.complex(1.4614619016647339,-0.3059438467025757),np.complex(-1.5707963705062866,0.3465735912322998),np.complex(1.1780972480773926,-0.1732867956161499),np.complex(1.3805431127548218,0.037105001509189606),np.complex(1.1780972480773926,-0.1732867956161499),np.complex(0.7853981852531433,-0.0),np.complex(1.3734008073806763,-0.0),np.complex(-0.8475756645202637,0.23887786269187927),np.complex(0.0,math.huge),np.complex(0.0,0.5493061542510986)},0.00024000000000000003,true,true),'inv complex arctan 89')
end
do
 local a=np.array({np.complex(-1.0,0.5),np.complex(-0.0,0.0),np.complex(-1.0,3.0),np.complex(1.0,3.0),np.complex(-1.0,-1.0),np.complex(-0.0,-1.0),np.complex(0.75,-3.0),np.complex(2.0,0.0),np.complex(-1.0,-1.0),np.complex(5.0,0.5),np.complex(0.75,0.0),np.complex(-2.0,0.5),np.complex(1.0,3.0)},np.complex64)
 local r=np.arctan(a)
 assert(r.dtype=='complex64','inv complex dtype 90')
 assert(list_same(r:tolist(),{np.complex(-0.8475756645202637,0.23887786269187927),np.complex(-0.0,0.0),np.complex(-1.4614619016647339,0.30594387650489807),np.complex(1.4614619016647339,0.30594387650489807),np.complex(-1.0172219276428223,-0.4023594856262207),np.complex(-0.0,-math.huge),np.complex(1.484084963798523,-0.32231760025024414),np.complex(1.1071487665176392,0.0),np.complex(-1.0172219276428223,-0.4023594856262207),np.complex(1.3752336502075195,0.019056841731071472),np.complex(0.6435011029243469,0.0),np.complex(-1.126556396484375,0.09641562402248383),np.complex(1.4614619016647339,0.30594387650489807)},0.00024000000000000003,true,true),'inv complex arctan 90')
end
do
 local a=np.array({np.complex(-2.0,-0.0),np.complex(2.0,-3.0),np.complex(-5.0,3.0),np.complex(0.75,0.0),np.complex(5.0,-3.0),np.complex(0.25,-3.0),np.complex(-1.0,0.0),np.complex(0.0,0.5),np.complex(0.75,-1.0),np.complex(5.0,-1.0),np.complex(2.0,0.0),np.complex(-0.0,0.0),np.complex(0.25,3.0)},np.complex64)
 local r=np.arctan(a)
 assert(r.dtype=='complex64','inv complex dtype 91')
 assert(list_same(r:tolist(),{np.complex(-1.1071487665176392,-0.0),np.complex(1.4099210500717163,-0.2290726751089096),np.complex(-1.423678994178772,0.08656906336545944),np.complex(0.6435011029243469,0.0),np.complex(1.423678994178772,-0.08656905591487885),np.complex(1.5398281812667847,-0.3436722159385681),np.complex(-0.7853981852531433,0.0),np.complex(0.0,0.5493061542510986),np.complex(0.9647834897041321,-0.5233086943626404),np.complex(1.3805431127548218,-0.037105001509189606),np.complex(1.1071487665176392,0.0),np.complex(-0.0,0.0),np.complex(1.5398281812667847,0.3436722159385681)},0.00024000000000000003,true,true),'inv complex arctan 91')
end
do
 local a=np.array({np.complex(-0.0,-0.0),np.complex(-5.0,-1.0),np.complex(-0.0,-1.0),np.complex(0.25,3.0),np.complex(5.0,1.0),np.complex(-2.0,1.0),np.complex(-1.0,-1.0),np.complex(-1.0,3.0),np.complex(0.75,1.0),np.complex(2.0,1.0),np.complex(0.0,0.5),np.complex(-5.0,1.0),np.complex(-0.0,0.5)},np.complex64)
 local r=np.arctan(a)
 assert(r.dtype=='complex64','inv complex dtype 92')
 assert(list_same(r:tolist(),{np.complex(-0.0,-0.0),np.complex(-1.3805431127548218,-0.037105001509189606),np.complex(-0.0,-math.huge),np.complex(1.5398281812667847,0.3436722159385681),np.complex(1.3805431127548218,0.037105001509189606),np.complex(-1.1780972480773926,0.1732867956161499),np.complex(-1.0172219276428223,-0.4023594856262207),np.complex(-1.4614619016647339,0.30594387650489807),np.complex(0.9647834897041321,0.5233086943626404),np.complex(1.1780972480773926,0.1732867956161499),np.complex(0.0,0.5493061542510986),np.complex(-1.3805431127548218,0.037105001509189606),np.complex(-0.0,0.5493061542510986)},0.00024000000000000003,true,true),'inv complex arctan 92')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(-2.0,-0.0),np.complex(-1.0,0.0),np.complex(-1.0,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(1.0,0.0),np.complex(1.0,-0.0),np.complex(2.0,0.0),np.complex(2.0,-0.0),np.complex(0.0,1.0),np.complex(0.0,-1.0),np.complex(0.0,2.0),np.complex(0.0,-2.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,math.huge),np.complex(-math.huge,-math.huge),np.complex((0/0),0.0),np.complex(0.0,(0/0)),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex64)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex64','inv complex dtype 93')
 assert(list_same(r:tolist(),{np.complex(-1.4436354637145996,0.0),np.complex(-1.4436354637145996,-0.0),np.complex(-0.8813736438751221,0.0),np.complex(-0.8813736438751221,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(0.8813736438751221,0.0),np.complex(0.8813736438751221,-0.0),np.complex(1.4436354637145996,0.0),np.complex(1.4436354637145996,-0.0),np.complex(0.0,1.5707963705062866),np.complex(0.0,-1.5707963705062866),np.complex(1.316957950592041,1.5707963705062866),np.complex(1.316957950592041,-1.5707963705062866),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(math.huge,1.5707963705062866),np.complex(math.huge,-1.5707963705062866),np.complex(math.huge,0.7853981852531433),np.complex(-math.huge,-0.7853981852531433),np.complex((0/0),0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},0.00024000000000000003,true,true),'inv complex arcsinh 93')
end
do
 local a=np.array({np.complex(2.0,0.0),np.complex(-2.0,1.0),np.complex(0.0,-3.0),np.complex(5.0,1.0),np.complex(-2.0,0.5),np.complex(0.0,0.5),np.complex(-0.0,-1.0),np.complex(-0.0,-1.0),np.complex(1.0,-3.0),np.complex(2.0,0.5),np.complex(0.0,3.0),np.complex(-1.0,0.5),np.complex(-1.0,0.5)},np.complex64)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex64','inv complex dtype 94')
 assert(list_same(r:tolist(),{np.complex(1.4436354637145996,0.0),np.complex(-1.5285710096359253,0.427078515291214),np.complex(1.7627471685409546,-1.5707963705062866),np.complex(2.330974578857422,0.1937931478023529),np.complex(-1.4657154083251953,0.22101862728595734),np.complex(0.0,0.5235987901687622),np.complex(-0.0,-1.5707963705062866),np.complex(-0.0,-1.5707963705062866),np.complex(1.824198603630066,-1.2330951690673828),np.complex(1.4657154083251953,0.22101862728595734),np.complex(1.7627471685409546,1.5707963705062866),np.complex(-0.9261330962181091,0.3494390547275543),np.complex(-0.9261330962181091,0.3494390547275543)},0.00024000000000000003,true,true),'inv complex arcsinh 94')
end
do
 local a=np.array({np.complex(1.0,-1.0),np.complex(0.0,1.0),np.complex(0.0,-0.0),np.complex(5.0,0.5),np.complex(5.0,-1.0),np.complex(5.0,-1.0),np.complex(-2.0,1.0),np.complex(0.75,-3.0),np.complex(1.0,3.0),np.complex(-2.0,0.5),np.complex(1.0,-1.0),np.complex(0.25,1.0),np.complex(2.0,-0.0)},np.complex64)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex64','inv complex dtype 95')
 assert(list_same(r:tolist(),{np.complex(1.0612751245498657,-0.6662394404411316),np.complex(0.0,1.5707963705062866),np.complex(0.0,-0.0),np.complex(2.3171324729919434,0.09776337444782257),np.complex(2.330974578857422,-0.1937931478023529),np.complex(2.330974578857422,-0.1937931478023529),np.complex(-1.5285710096359253,0.427078515291214),np.complex(1.7984284162521362,-1.312600016593933),np.complex(1.824198603630066,1.2330951690673828),np.complex(-1.4657154083251953,0.22101862728595734),np.complex(1.0612751245498657,-0.6662394404411316),np.complex(0.5097911357879639,1.0817519426345825),np.complex(1.4436354637145996,-0.0)},0.00024000000000000003,true,true),'inv complex arcsinh 95')
end
do
 local a=np.array({np.complex(-2.0,-1.0),np.complex(-2.0,-3.0),np.complex(-2.0,-0.0),np.complex(-2.0,0.5),np.complex(-1.0,1.0),np.complex(-0.0,-1.0),np.complex(0.0,-1.0),np.complex(0.0,-3.0),np.complex(0.25,-3.0),np.complex(-0.0,0.0),np.complex(2.0,-1.0),np.complex(-5.0,-1.0),np.complex(0.25,-3.0)},np.complex64)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex64','inv complex dtype 96')
 assert(list_same(r:tolist(),{np.complex(-1.5285710096359253,-0.427078515291214),np.complex(-1.9686379432678223,-0.9646584987640381),np.complex(-1.4436354637145996,-0.0),np.complex(-1.4657154083251953,0.22101862728595734),np.complex(-1.0612751245498657,0.6662394404411316),np.complex(-0.0,-1.5707963705062866),np.complex(0.0,-1.5707963705062866),np.complex(1.7627471685409546,-1.5707963705062866),np.complex(1.766869306564331,-1.4826794862747192),np.complex(-0.0,0.0),np.complex(1.5285710096359253,-0.427078515291214),np.complex(-2.330974578857422,-0.1937931478023529),np.complex(1.766869306564331,-1.4826794862747192)},0.00024000000000000003,true,true),'inv complex arcsinh 96')
end
do
 local a=np.array({np.complex(-5.0,0.5),np.complex(1.0,0.5),np.complex(-1.0,1.0),np.complex(1.0,0.0),np.complex(0.25,-0.0),np.complex(1.0,0.5),np.complex(-2.0,1.0),np.complex(-1.0,0.5),np.complex(2.0,3.0),np.complex(-5.0,1.0),np.complex(0.0,-0.0),np.complex(0.0,-3.0),np.complex(-5.0,0.5)},np.complex64)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex64','inv complex dtype 97')
 assert(list_same(r:tolist(),{np.complex(-2.3171324729919434,0.09776337444782257),np.complex(0.9261330962181091,0.3494390547275543),np.complex(-1.0612751245498657,0.6662394404411316),np.complex(0.8813736438751221,0.0),np.complex(0.24746645987033844,-0.0),np.complex(0.9261330962181091,0.3494390547275543),np.complex(-1.5285710096359253,0.427078515291214),np.complex(-0.9261330962181091,0.3494390547275543),np.complex(1.9686379432678223,0.9646584987640381),np.complex(-2.330974578857422,0.1937931478023529),np.complex(0.0,-0.0),np.complex(1.7627471685409546,-1.5707963705062866),np.complex(-2.3171324729919434,0.09776337444782257)},0.00024000000000000003,true,true),'inv complex arcsinh 97')
end
do
 local a=np.array({np.complex(-0.0,-0.0),np.complex(-1.0,-1.0),np.complex(-2.0,0.5),np.complex(2.0,0.0),np.complex(-1.0,0.0),np.complex(0.25,0.5),np.complex(-2.0,1.0),np.complex(2.0,-0.0),np.complex(5.0,3.0),np.complex(0.75,1.0),np.complex(0.75,0.5),np.complex(-5.0,3.0),np.complex(-2.0,0.0)},np.complex64)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex64','inv complex dtype 98')
 assert(list_same(r:tolist(),{np.complex(-0.0,-0.0),np.complex(-1.0612751245498657,-0.6662394404411316),np.complex(-1.4657154083251953,0.22101862728595734),np.complex(1.4436354637145996,0.0),np.complex(-0.8813736438751221,0.0),np.complex(0.2813960611820221,0.5016088485717773),np.complex(-1.5285710096359253,0.427078515291214),np.complex(1.4436354637145996,-0.0),np.complex(2.459831476211548,0.5339990258216858),np.complex(0.9095935821533203,0.7656426429748535),np.complex(0.7433204054832458,0.3982778787612915),np.complex(-2.459831476211548,0.5339990258216858),np.complex(-1.4436354637145996,0.0)},0.00024000000000000003,true,true),'inv complex arcsinh 98')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(1.0,3.0),np.complex(2.0,1.0),np.complex(-5.0,3.0),np.complex(-1.0,0.0),np.complex(-0.0,0.0),np.complex(0.75,-0.0),np.complex(0.75,3.0),np.complex(0.0,0.0),np.complex(-5.0,0.5),np.complex(2.0,3.0),np.complex(1.0,0.0),np.complex(-2.0,-3.0)},np.complex64)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex64','inv complex dtype 99')
 assert(list_same(r:tolist(),{np.complex(0.0,0.0),np.complex(1.824198603630066,1.2330951690673828),np.complex(1.5285710096359253,0.427078515291214),np.complex(-2.459831476211548,0.5339990258216858),np.complex(-0.8813736438751221,0.0),np.complex(-0.0,0.0),np.complex(0.6931471824645996,-0.0),np.complex(1.7984284162521362,1.312600016593933),np.complex(0.0,0.0),np.complex(-2.3171324729919434,0.09776337444782257),np.complex(1.9686379432678223,0.9646584987640381),np.complex(0.8813736438751221,0.0),np.complex(-1.9686379432678223,-0.9646584987640381)},0.00024000000000000003,true,true),'inv complex arcsinh 99')
end
do
 local a=np.array({np.complex(2.0,3.0),np.complex(1.0,0.5),np.complex(5.0,-3.0),np.complex(-0.0,0.5),np.complex(2.0,0.0),np.complex(-0.0,0.5),np.complex(-2.0,-0.0),np.complex(-5.0,0.0),np.complex(2.0,-3.0),np.complex(-1.0,-3.0),np.complex(0.0,0.0),np.complex(5.0,0.5),np.complex(0.0,-0.0)},np.complex64)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex64','inv complex dtype 100')
 assert(list_same(r:tolist(),{np.complex(1.9686379432678223,0.9646584987640381),np.complex(0.9261330962181091,0.3494390547275543),np.complex(2.459831476211548,-0.5339990258216858),np.complex(-0.0,0.5235987901687622),np.complex(1.4436354637145996,0.0),np.complex(-0.0,0.5235987901687622),np.complex(-1.4436354637145996,-0.0),np.complex(-2.312438488006592,0.0),np.complex(1.9686379432678223,-0.9646584987640381),np.complex(-1.824198603630066,-1.2330951690673828),np.complex(0.0,0.0),np.complex(2.3171324729919434,0.09776337444782257),np.complex(0.0,-0.0)},0.00024000000000000003,true,true),'inv complex arcsinh 100')
end
do
 local a=np.array({np.complex(5.0,-0.0),np.complex(-1.0,-3.0),np.complex(-0.0,0.0),np.complex(-1.0,1.0),np.complex(0.0,1.0),np.complex(0.75,0.0),np.complex(-5.0,-1.0),np.complex(1.0,-0.0),np.complex(0.75,1.0),np.complex(-5.0,1.0),np.complex(-2.0,-3.0),np.complex(-2.0,1.0),np.complex(0.25,-1.0)},np.complex64)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex64','inv complex dtype 101')
 assert(list_same(r:tolist(),{np.complex(2.312438488006592,-0.0),np.complex(-1.824198603630066,-1.2330951690673828),np.complex(-0.0,0.0),np.complex(-1.0612751245498657,0.6662394404411316),np.complex(0.0,1.5707963705062866),np.complex(0.6931471824645996,0.0),np.complex(-2.330974578857422,-0.1937931478023529),np.complex(0.8813736438751221,-0.0),np.complex(0.9095935821533203,0.7656426429748535),np.complex(-2.330974578857422,0.1937931478023529),np.complex(-1.9686379432678223,-0.9646584987640381),np.complex(-1.5285710096359253,0.427078515291214),np.complex(0.5097911357879639,-1.0817519426345825)},0.00024000000000000003,true,true),'inv complex arcsinh 101')
end
do
 local a=np.array({np.complex(-5.0,0.5),np.complex(-0.0,1.0),np.complex(2.0,-0.0),np.complex(2.0,0.0),np.complex(0.25,-1.0),np.complex(-5.0,0.5),np.complex(5.0,-0.0),np.complex(-0.0,0.5),np.complex(1.0,-3.0),np.complex(-0.0,0.5),np.complex(1.0,3.0),np.complex(5.0,0.5),np.complex(1.0,3.0)},np.complex64)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex64','inv complex dtype 102')
 assert(list_same(r:tolist(),{np.complex(-2.3171324729919434,0.09776337444782257),np.complex(-0.0,1.5707963705062866),np.complex(1.4436354637145996,-0.0),np.complex(1.4436354637145996,0.0),np.complex(0.5097911357879639,-1.0817519426345825),np.complex(-2.3171324729919434,0.09776337444782257),np.complex(2.312438488006592,-0.0),np.complex(-0.0,0.5235987901687622),np.complex(1.824198603630066,-1.2330951690673828),np.complex(-0.0,0.5235987901687622),np.complex(1.824198603630066,1.2330951690673828),np.complex(2.3171324729919434,0.09776337444782257),np.complex(1.824198603630066,1.2330951690673828)},0.00024000000000000003,true,true),'inv complex arcsinh 102')
end
do
 local a=np.array({np.complex(0.25,-1.0),np.complex(-2.0,1.0),np.complex(2.0,1.0),np.complex(0.25,0.5),np.complex(2.0,1.0),np.complex(-0.0,1.0),np.complex(0.0,0.0),np.complex(0.25,-3.0),np.complex(-5.0,-0.0),np.complex(-1.0,3.0),np.complex(0.75,3.0),np.complex(1.0,-0.0),np.complex(0.75,-1.0)},np.complex64)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex64','inv complex dtype 103')
 assert(list_same(r:tolist(),{np.complex(0.5097911357879639,-1.0817519426345825),np.complex(-1.5285710096359253,0.427078515291214),np.complex(1.5285710096359253,0.427078515291214),np.complex(0.2813960611820221,0.5016088485717773),np.complex(1.5285710096359253,0.427078515291214),np.complex(-0.0,1.5707963705062866),np.complex(0.0,0.0),np.complex(1.766869306564331,-1.4826794862747192),np.complex(-2.312438488006592,-0.0),np.complex(-1.824198603630066,1.2330951690673828),np.complex(1.7984284162521362,1.312600016593933),np.complex(0.8813736438751221,-0.0),np.complex(0.9095935821533203,-0.7656426429748535)},0.00024000000000000003,true,true),'inv complex arcsinh 103')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(-2.0,-0.0),np.complex(-1.0,0.0),np.complex(-1.0,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(1.0,0.0),np.complex(1.0,-0.0),np.complex(2.0,0.0),np.complex(2.0,-0.0),np.complex(0.0,1.0),np.complex(0.0,-1.0),np.complex(0.0,2.0),np.complex(0.0,-2.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,math.huge),np.complex(-math.huge,-math.huge),np.complex((0/0),0.0),np.complex(0.0,(0/0)),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex64)
 local r=np.arccosh(a)
 assert(r.dtype=='complex64','inv complex dtype 104')
 assert(list_same(r:tolist(),{np.complex(1.316957950592041,3.1415927410125732),np.complex(1.316957950592041,-3.1415927410125732),np.complex(0.0,3.1415927410125732),np.complex(0.0,-3.1415927410125732),np.complex(0.0,1.5707963705062866),np.complex(0.0,-1.5707963705062866),np.complex(0.0,1.5707963705062866),np.complex(0.0,-1.5707963705062866),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(1.316957950592041,0.0),np.complex(1.316957950592041,-0.0),np.complex(0.8813736438751221,1.5707963705062866),np.complex(0.8813736438751221,-1.5707963705062866),np.complex(1.4436354637145996,1.5707963705062866),np.complex(1.4436354637145996,-1.5707963705062866),np.complex(math.huge,0.0),np.complex(math.huge,3.1415927410125732),np.complex(math.huge,1.5707963705062866),np.complex(math.huge,-1.5707963705062866),np.complex(math.huge,0.7853981852531433),np.complex(math.huge,-2.356194496154785),np.complex((0/0),(0/0)),np.complex((0/0),1.5707963705062866),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},0.00024000000000000003,true,true),'inv complex arccosh 104')
end
do
 local a=np.array({np.complex(0.75,-1.0),np.complex(0.25,-3.0),np.complex(-0.0,1.0),np.complex(0.75,0.5),np.complex(1.0,-3.0),np.complex(0.0,0.5),np.complex(1.0,1.0),np.complex(1.0,-3.0),np.complex(0.0,-1.0),np.complex(-2.0,-0.0),np.complex(-5.0,-3.0),np.complex(1.0,-0.0),np.complex(-1.0,-1.0)},np.complex64)
 local r=np.arccosh(a)
 assert(r.dtype=='complex64','inv complex dtype 105')
 assert(list_same(r:tolist(),{np.complex(0.982866108417511,-1.0559581518173218),np.complex(1.821404218673706,-1.4918789863586426),np.complex(0.8813736438751221,1.5707963705062866),np.complex(0.6063349843025208,0.8885923624038696),np.complex(1.8641616106033325,-1.2631926536560059),np.complex(0.4812118411064148,1.5707963705062866),np.complex(1.0612751245498657,0.9045568704605103),np.complex(1.8641616106033325,-1.2631926536560059),np.complex(0.8813736438751221,-1.5707963705062866),np.complex(1.316957950592041,-3.1415927410125732),np.complex(2.452913761138916,-2.594618082046509),np.complex(0.0,-0.0),np.complex(1.0612751245498657,-2.2370357513427734)},0.00024000000000000003,true,true),'inv complex arccosh 105')
end
do
 local a=np.array({np.complex(0.25,-1.0),np.complex(-1.0,-0.0),np.complex(1.0,1.0),np.complex(0.75,0.0),np.complex(-2.0,-3.0),np.complex(5.0,3.0),np.complex(2.0,0.5),np.complex(2.0,-3.0),np.complex(1.0,1.0),np.complex(-2.0,-0.0),np.complex(2.0,1.0),np.complex(5.0,0.0),np.complex(-2.0,0.0)},np.complex64)
 local r=np.arccosh(a)
 assert(r.dtype=='complex64','inv complex dtype 106')
 assert(list_same(r:tolist(),{np.complex(0.8924633860588074,-1.3944939374923706),np.complex(0.0,-3.1415927410125732),np.complex(1.0612751245498657,0.9045568704605103),np.complex(0.0,0.7227342128753662),np.complex(1.9833869934082031,-2.141449213027954),np.complex(2.452913761138916,0.5469745993614197),np.complex(1.3618009090423584,0.2777542471885681),np.complex(1.9833869934082031,-1.0001435279846191),np.complex(1.0612751245498657,0.9045568704605103),np.complex(1.316957950592041,-3.1415927410125732),np.complex(1.4693516492843628,0.5073562860488892),np.complex(2.292431592941284,0.0),np.complex(1.316957950592041,3.1415927410125732)},0.00024000000000000003,true,true),'inv complex arccosh 106')
end
do
 local a=np.array({np.complex(0.75,0.0),np.complex(-1.0,-3.0),np.complex(-5.0,3.0),np.complex(1.0,-1.0),np.complex(2.0,-3.0),np.complex(-5.0,-3.0),np.complex(-5.0,1.0),np.complex(-2.0,3.0),np.complex(-5.0,-3.0),np.complex(-2.0,0.5),np.complex(-1.0,-1.0),np.complex(-0.0,1.0),np.complex(0.75,-1.0)},np.complex64)
 local r=np.arccosh(a)
 assert(r.dtype=='complex64','inv complex dtype 107')
 assert(list_same(r:tolist(),{np.complex(0.0,0.7227342128753662),np.complex(1.8641616106033325,-1.8783999681472778),np.complex(2.452913761138916,2.594618082046509),np.complex(1.0612751245498657,-0.9045568704605103),np.complex(1.9833869934082031,-1.0001435279846191),np.complex(2.452913761138916,-2.594618082046509),np.complex(2.313220977783203,2.9403975009918213),np.complex(1.9833869934082031,2.141449213027954),np.complex(2.452913761138916,-2.594618082046509),np.complex(1.3618009090423584,2.8638384342193604),np.complex(1.0612751245498657,-2.2370357513427734),np.complex(0.8813736438751221,1.5707963705062866),np.complex(0.982866108417511,-1.0559581518173218)},0.00024000000000000003,true,true),'inv complex arccosh 107')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(0.0,0.5),np.complex(2.0,0.5),np.complex(0.75,-1.0),np.complex(-5.0,-0.0),np.complex(-2.0,3.0),np.complex(0.25,3.0),np.complex(0.75,-1.0),np.complex(0.25,0.5),np.complex(-5.0,-0.0),np.complex(5.0,1.0),np.complex(5.0,3.0),np.complex(1.0,-3.0)},np.complex64)
 local r=np.arccosh(a)
 assert(r.dtype=='complex64','inv complex dtype 108')
 assert(list_same(r:tolist(),{np.complex(0.0,1.5707963705062866),np.complex(0.4812118411064148,1.5707963705062866),np.complex(1.3618009090423584,0.2777542471885681),np.complex(0.982866108417511,-1.0559581518173218),np.complex(2.292431592941284,-3.1415927410125732),np.complex(1.9833869934082031,2.141449213027954),np.complex(1.821404218673706,1.4918789863586426),np.complex(0.982866108417511,-1.0559581518173218),np.complex(0.49267566204071045,1.3464678525924683),np.complex(2.292431592941284,-3.1415927410125732),np.complex(2.313220977783203,0.20119507610797882),np.complex(2.452913761138916,0.5469745993614197),np.complex(1.8641616106033325,-1.2631926536560059)},0.00024000000000000003,true,true),'inv complex arccosh 108')
end
do
 local a=np.array({np.complex(5.0,-1.0),np.complex(0.0,1.0),np.complex(-2.0,0.5),np.complex(-2.0,0.0),np.complex(0.75,0.5),np.complex(0.0,-0.0),np.complex(0.75,0.5),np.complex(0.75,-3.0),np.complex(0.75,1.0),np.complex(2.0,1.0),np.complex(-2.0,-1.0),np.complex(1.0,-0.0),np.complex(5.0,-0.0)},np.complex64)
 local r=np.arccosh(a)
 assert(r.dtype=='complex64','inv complex dtype 109')
 assert(list_same(r:tolist(),{np.complex(2.313220977783203,-0.20119507610797882),np.complex(0.8813736438751221,1.5707963705062866),np.complex(1.3618009090423584,2.8638384342193604),np.complex(1.316957950592041,3.1415927410125732),np.complex(0.6063349843025208,0.8885923624038696),np.complex(0.0,-1.5707963705062866),np.complex(0.6063349843025208,0.8885923624038696),np.complex(1.8445760011672974,-1.337324857711792),np.complex(0.982866108417511,1.0559581518173218),np.complex(1.4693516492843628,0.5073562860488892),np.complex(1.4693516492843628,-2.6342363357543945),np.complex(0.0,-0.0),np.complex(2.292431592941284,-0.0)},0.00024000000000000003,true,true),'inv complex arccosh 109')
end
do
 local a=np.array({np.complex(-1.0,3.0),np.complex(0.0,0.0),np.complex(2.0,1.0),np.complex(0.25,3.0),np.complex(-1.0,-3.0),np.complex(0.0,-3.0),np.complex(0.25,0.5),np.complex(0.25,1.0),np.complex(-5.0,-3.0),np.complex(2.0,-3.0),np.complex(5.0,0.0),np.complex(5.0,-3.0),np.complex(-2.0,0.0)},np.complex64)
 local r=np.arccosh(a)
 assert(r.dtype=='complex64','inv complex dtype 110')
 assert(list_same(r:tolist(),{np.complex(1.8641616106033325,1.8783999681472778),np.complex(0.0,1.5707963705062866),np.complex(1.4693516492843628,0.5073562860488892),np.complex(1.821404218673706,1.4918789863586426),np.complex(1.8641616106033325,-1.8783999681472778),np.complex(1.8184465169906616,-1.5707963705062866),np.complex(0.49267566204071045,1.3464678525924683),np.complex(0.8924633860588074,1.3944939374923706),np.complex(2.452913761138916,-2.594618082046509),np.complex(1.9833869934082031,-1.0001435279846191),np.complex(2.292431592941284,0.0),np.complex(2.452913761138916,-0.5469745993614197),np.complex(1.316957950592041,3.1415927410125732)},0.00024000000000000003,true,true),'inv complex arccosh 110')
end
do
 local a=np.array({np.complex(2.0,0.5),np.complex(0.25,-1.0),np.complex(0.75,-0.0),np.complex(-2.0,3.0),np.complex(0.0,3.0),np.complex(0.0,-1.0),np.complex(0.0,0.0),np.complex(-1.0,0.0),np.complex(-1.0,-3.0),np.complex(2.0,-0.0),np.complex(0.0,0.0),np.complex(2.0,3.0),np.complex(-2.0,-1.0)},np.complex64)
 local r=np.arccosh(a)
 assert(r.dtype=='complex64','inv complex dtype 111')
 assert(list_same(r:tolist(),{np.complex(1.3618009090423584,0.2777542471885681),np.complex(0.8924633860588074,-1.3944939374923706),np.complex(0.0,-0.7227342128753662),np.complex(1.9833869934082031,2.141449213027954),np.complex(1.8184465169906616,1.5707963705062866),np.complex(0.8813736438751221,-1.5707963705062866),np.complex(0.0,1.5707963705062866),np.complex(0.0,3.1415927410125732),np.complex(1.8641616106033325,-1.8783999681472778),np.complex(1.316957950592041,-0.0),np.complex(0.0,1.5707963705062866),np.complex(1.9833869934082031,1.0001435279846191),np.complex(1.4693516492843628,-2.6342363357543945)},0.00024000000000000003,true,true),'inv complex arccosh 111')
end
do
 local a=np.array({np.complex(2.0,-0.0),np.complex(5.0,0.0),np.complex(-1.0,0.0),np.complex(2.0,-1.0),np.complex(0.75,0.5),np.complex(5.0,1.0),np.complex(0.25,-0.0),np.complex(-0.0,3.0),np.complex(5.0,0.5),np.complex(-0.0,-0.0),np.complex(2.0,3.0),np.complex(0.0,1.0),np.complex(-5.0,-0.0)},np.complex64)
 local r=np.arccosh(a)
 assert(r.dtype=='complex64','inv complex dtype 112')
 assert(list_same(r:tolist(),{np.complex(1.316957950592041,-0.0),np.complex(2.292431592941284,0.0),np.complex(0.0,3.1415927410125732),np.complex(1.4693516492843628,-0.5073562860488892),np.complex(0.6063349843025208,0.8885923624038696),np.complex(2.313220977783203,0.20119507610797882),np.complex(0.0,-1.3181160688400269),np.complex(1.8184465169906616,1.5707963705062866),np.complex(2.2977170944213867,0.1016882136464119),np.complex(0.0,-1.5707963705062866),np.complex(1.9833869934082031,1.0001435279846191),np.complex(0.8813736438751221,1.5707963705062866),np.complex(2.292431592941284,-3.1415927410125732)},0.00024000000000000003,true,true),'inv complex arccosh 112')
end
do
 local a=np.array({np.complex(5.0,0.5),np.complex(1.0,3.0),np.complex(-1.0,0.5),np.complex(5.0,-1.0),np.complex(-0.0,-0.0),np.complex(1.0,-1.0),np.complex(-2.0,1.0),np.complex(0.75,-1.0),np.complex(0.25,-0.0),np.complex(5.0,3.0),np.complex(0.0,0.5),np.complex(-0.0,-3.0),np.complex(-2.0,1.0)},np.complex64)
 local r=np.arccosh(a)
 assert(r.dtype=='complex64','inv complex dtype 113')
 assert(list_same(r:tolist(),{np.complex(2.2977170944213867,0.1016882136464119),np.complex(1.8641616106033325,1.2631926536560059),np.complex(0.7328576445579529,2.4667036533355713),np.complex(2.313220977783203,-0.20119507610797882),np.complex(0.0,-1.5707963705062866),np.complex(1.0612751245498657,-0.9045568704605103),np.complex(1.4693516492843628,2.6342363357543945),np.complex(0.982866108417511,-1.0559581518173218),np.complex(0.0,-1.3181160688400269),np.complex(2.452913761138916,0.5469745993614197),np.complex(0.4812118411064148,1.5707963705062866),np.complex(1.8184465169906616,-1.5707963705062866),np.complex(1.4693516492843628,2.6342363357543945)},0.00024000000000000003,true,true),'inv complex arccosh 113')
end
do
 local a=np.array({np.complex(1.0,-0.0),np.complex(0.75,3.0),np.complex(5.0,0.0),np.complex(-5.0,0.5),np.complex(1.0,0.5),np.complex(5.0,0.5),np.complex(-5.0,-3.0),np.complex(-2.0,-0.0),np.complex(0.25,-1.0),np.complex(0.0,0.0),np.complex(-2.0,0.5),np.complex(-5.0,-0.0),np.complex(-0.0,-1.0)},np.complex64)
 local r=np.arccosh(a)
 assert(r.dtype=='complex64','inv complex dtype 114')
 assert(list_same(r:tolist(),{np.complex(0.0,-0.0),np.complex(1.8445760011672974,1.337324857711792),np.complex(2.292431592941284,0.0),np.complex(2.2977170944213867,3.0399043560028076),np.complex(0.7328576445579529,0.6748889088630676),np.complex(2.2977170944213867,0.1016882136464119),np.complex(2.452913761138916,-2.594618082046509),np.complex(1.316957950592041,-3.1415927410125732),np.complex(0.8924633860588074,-1.3944939374923706),np.complex(0.0,1.5707963705062866),np.complex(1.3618009090423584,2.8638384342193604),np.complex(2.292431592941284,-3.1415927410125732),np.complex(0.8813736438751221,-1.5707963705062866)},0.00024000000000000003,true,true),'inv complex arccosh 114')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(-2.0,-0.0),np.complex(-1.0,0.0),np.complex(-1.0,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(1.0,0.0),np.complex(1.0,-0.0),np.complex(2.0,0.0),np.complex(2.0,-0.0),np.complex(0.0,1.0),np.complex(0.0,-1.0),np.complex(0.0,2.0),np.complex(0.0,-2.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,math.huge),np.complex(-math.huge,-math.huge),np.complex((0/0),0.0),np.complex(0.0,(0/0)),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex64)
 local r=np.arctanh(a)
 assert(r.dtype=='complex64','inv complex dtype 115')
 assert(list_same(r:tolist(),{np.complex(-0.5493061542510986,1.5707963705062866),np.complex(-0.5493061542510986,-1.5707963705062866),np.complex(-math.huge,0.0),np.complex(-math.huge,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(math.huge,-0.0),np.complex(0.5493061542510986,1.5707963705062866),np.complex(0.5493061542510986,-1.5707963705062866),np.complex(0.0,0.7853981852531433),np.complex(0.0,-0.7853981852531433),np.complex(0.0,1.1071487665176392),np.complex(0.0,-1.1071487665176392),np.complex(0.0,1.5707963705062866),np.complex(-0.0,1.5707963705062866),np.complex(0.0,1.5707963705062866),np.complex(0.0,-1.5707963705062866),np.complex(0.0,1.5707963705062866),np.complex(-0.0,-1.5707963705062866),np.complex((0/0),(0/0)),np.complex(0.0,(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},0.00024000000000000003,true,true),'inv complex arctanh 115')
end
do
 local a=np.array({np.complex(2.0,-0.0),np.complex(-5.0,1.0),np.complex(0.0,0.0),np.complex(-2.0,1.0),np.complex(0.25,0.0),np.complex(-5.0,1.0),np.complex(2.0,-3.0),np.complex(5.0,-1.0),np.complex(0.25,0.5),np.complex(0.25,1.0),np.complex(2.0,-0.0),np.complex(0.25,-0.0),np.complex(0.75,-0.0)},np.complex64)
 local r=np.arctanh(a)
 assert(r.dtype=='complex64','inv complex dtype 116')
 assert(list_same(r:tolist(),{np.complex(0.5493061542510986,-1.5707963705062866),np.complex(-0.19442614912986755,1.5308812856674194),np.complex(0.0,0.0),np.complex(-0.4023594856262207,1.338972568511963),np.complex(0.2554128170013428,0.0),np.complex(-0.19442614912986755,1.5308812856674194),np.complex(0.14694666862487793,-1.338972568511963),np.complex(0.19442614912986755,-1.5308812856674194),np.complex(0.20058661699295044,0.48425447940826416),np.complex(0.12367405742406845,0.8010180592536926),np.complex(0.5493061542510986,-1.5707963705062866),np.complex(0.2554128170013428,-0.0),np.complex(0.972955048084259,-0.0)},0.00024000000000000003,true,true),'inv complex arctanh 116')
end
do
 local a=np.array({np.complex(1.0,1.0),np.complex(-0.0,-3.0),np.complex(-5.0,0.0),np.complex(-0.0,-0.0),np.complex(2.0,0.0),np.complex(0.0,-3.0),np.complex(-2.0,0.0),np.complex(-0.0,3.0),np.complex(-5.0,0.5),np.complex(0.0,0.5),np.complex(5.0,0.0),np.complex(0.0,-0.0),np.complex(0.25,-3.0)},np.complex64)
 local r=np.arctanh(a)
 assert(r.dtype=='complex64','inv complex dtype 117')
 assert(list_same(r:tolist(),{np.complex(0.4023594856262207,1.0172219276428223),np.complex(-0.0,-1.249045729637146),np.complex(-0.20273254811763763,1.5707963705062866),np.complex(-0.0,-0.0),np.complex(0.5493061542510986,1.5707963705062866),np.complex(0.0,-1.249045729637146),np.complex(-0.5493061542510986,1.5707963705062866),np.complex(-0.0,1.249045729637146),np.complex(-0.20058661699295044,1.55018949508667),np.complex(0.0,0.46364760398864746),np.complex(0.20273254811763763,1.5707963705062866),np.complex(0.0,-0.0),np.complex(0.024865198880434036,-1.2509114742279053)},0.00024000000000000003,true,true),'inv complex arctanh 117')
end
do
 local a=np.array({np.complex(2.0,-1.0),np.complex(-2.0,3.0),np.complex(2.0,-1.0),np.complex(0.25,0.0),np.complex(0.0,1.0),np.complex(-1.0,0.0),np.complex(-5.0,-0.0),np.complex(5.0,0.0),np.complex(-5.0,0.5),np.complex(-1.0,1.0),np.complex(5.0,0.5),np.complex(-2.0,-0.0),np.complex(0.75,3.0)},np.complex64)
 local r=np.arctanh(a)
 assert(r.dtype=='complex64','inv complex dtype 118')
 assert(list_same(r:tolist(),{np.complex(0.4023594856262207,-1.338972568511963),np.complex(-0.14694666862487793,1.338972568511963),np.complex(0.4023594856262207,-1.338972568511963),np.complex(0.2554128170013428,0.0),np.complex(0.0,0.7853981852531433),np.complex(-math.huge,0.0),np.complex(-0.20273254811763763,-1.5707963705062866),np.complex(0.20273254811763763,1.5707963705062866),np.complex(-0.20058661699295044,1.55018949508667),np.complex(-0.4023594856262207,1.0172219276428223),np.complex(0.20058661699295044,1.55018949508667),np.complex(-0.5493061542510986,-1.5707963705062866),np.complex(0.0714891105890274,1.265188455581665)},0.00024000000000000003,true,true),'inv complex arctanh 118')
end
do
 local a=np.array({np.complex(-1.0,0.5),np.complex(1.0,3.0),np.complex(0.75,0.5),np.complex(5.0,-3.0),np.complex(-2.0,-1.0),np.complex(5.0,3.0),np.complex(-0.0,0.0),np.complex(5.0,3.0),np.complex(0.75,0.0),np.complex(0.25,0.0),np.complex(0.75,1.0),np.complex(-0.0,0.0),np.complex(5.0,-1.0)},np.complex64)
 local r=np.arctanh(a)
 assert(r.dtype=='complex64','inv complex dtype 119')
 assert(list_same(r:tolist(),{np.complex(-0.7083033323287964,0.9078875184059143),np.complex(0.09193119406700134,1.2767950296401978),np.complex(0.5902135372161865,0.6927241683006287),np.complex(0.14694666862487793,-1.4808695316314697),np.complex(-0.4023594856262207,-1.338972568511963),np.complex(0.14694666862487793,1.4808695316314697),np.complex(-0.0,0.0),np.complex(0.14694666862487793,1.4808695316314697),np.complex(0.972955048084259,0.0),np.complex(0.2554128170013428,0.0),np.complex(0.3352934718132019,0.922481894493103),np.complex(-0.0,0.0),np.complex(0.19442614912986755,-1.5308812856674194)},0.00024000000000000003,true,true),'inv complex arctanh 119')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(2.0,-3.0),np.complex(2.0,-0.0),np.complex(-5.0,-3.0),np.complex(2.0,-0.0),np.complex(1.0,-3.0),np.complex(0.75,-3.0),np.complex(-5.0,0.0),np.complex(-2.0,1.0),np.complex(-0.0,-3.0),np.complex(-0.0,-0.0),np.complex(-5.0,-1.0),np.complex(5.0,3.0)},np.complex64)
 local r=np.arctanh(a)
 assert(r.dtype=='complex64','inv complex dtype 120')
 assert(list_same(r:tolist(),{np.complex(-0.5493061542510986,1.5707963705062866),np.complex(0.14694666862487793,-1.338972568511963),np.complex(0.5493061542510986,-1.5707963705062866),np.complex(-0.14694666862487793,-1.4808695316314697),np.complex(0.5493061542510986,-1.5707963705062866),np.complex(0.09193119406700134,-1.2767950296401978),np.complex(0.0714891105890274,-1.265188455581665),np.complex(-0.20273254811763763,1.5707963705062866),np.complex(-0.4023594856262207,1.338972568511963),np.complex(-0.0,-1.249045729637146),np.complex(-0.0,-0.0),np.complex(-0.19442614912986755,-1.5308812856674194),np.complex(0.14694666862487793,1.4808695316314697)},0.00024000000000000003,true,true),'inv complex arctanh 120')
end
do
 local a=np.array({np.complex(0.25,-0.0),np.complex(5.0,0.5),np.complex(1.0,0.5),np.complex(-0.0,-3.0),np.complex(-0.0,3.0),np.complex(0.75,3.0),np.complex(0.75,1.0),np.complex(-2.0,0.5),np.complex(-2.0,1.0),np.complex(-2.0,3.0),np.complex(-1.0,0.0),np.complex(-0.0,1.0),np.complex(-5.0,0.0)},np.complex64)
 local r=np.arctanh(a)
 assert(r.dtype=='complex64','inv complex dtype 121')
 assert(list_same(r:tolist(),{np.complex(0.2554128170013428,-0.0),np.complex(0.20058661699295044,1.55018949508667),np.complex(0.7083033323287964,0.9078875184059143),np.complex(-0.0,-1.249045729637146),np.complex(-0.0,1.249045729637146),np.complex(0.0714891105890274,1.265188455581665),np.complex(0.3352934718132019,0.922481894493103),np.complex(-0.5003700256347656,1.4215468168258667),np.complex(-0.4023594856262207,1.338972568511963),np.complex(-0.14694666862487793,1.338972568511963),np.complex(-math.huge,0.0),np.complex(-0.0,0.7853981852531433),np.complex(-0.20273254811763763,1.5707963705062866)},0.00024000000000000003,true,true),'inv complex arctanh 121')
end
do
 local a=np.array({np.complex(-1.0,-1.0),np.complex(0.75,0.0),np.complex(0.25,0.5),np.complex(0.75,0.0),np.complex(-1.0,0.5),np.complex(0.75,-1.0),np.complex(5.0,-3.0),np.complex(0.75,1.0),np.complex(1.0,-3.0),np.complex(0.0,0.0),np.complex(-2.0,0.5),np.complex(5.0,0.5),np.complex(5.0,0.5)},np.complex64)
 local r=np.arctanh(a)
 assert(r.dtype=='complex64','inv complex dtype 122')
 assert(list_same(r:tolist(),{np.complex(-0.4023594856262207,-1.0172219276428223),np.complex(0.972955048084259,0.0),np.complex(0.20058661699295044,0.48425447940826416),np.complex(0.972955048084259,0.0),np.complex(-0.7083033323287964,0.9078875184059143),np.complex(0.3352934718132019,-0.922481894493103),np.complex(0.14694666862487793,-1.4808695316314697),np.complex(0.3352934718132019,0.922481894493103),np.complex(0.09193119406700134,-1.2767950296401978),np.complex(0.0,0.0),np.complex(-0.5003700256347656,1.4215468168258667),np.complex(0.20058661699295044,1.55018949508667),np.complex(0.20058661699295044,1.55018949508667)},0.00024000000000000003,true,true),'inv complex arctanh 122')
end
do
 local a=np.array({np.complex(0.25,-1.0),np.complex(-1.0,1.0),np.complex(-0.0,-0.0),np.complex(-5.0,3.0),np.complex(-1.0,0.5),np.complex(-2.0,0.5),np.complex(-0.0,-3.0),np.complex(5.0,1.0),np.complex(-5.0,3.0),np.complex(0.25,-0.0),np.complex(-2.0,-1.0),np.complex(0.75,3.0),np.complex(-0.0,-1.0)},np.complex64)
 local r=np.arctanh(a)
 assert(r.dtype=='complex64','inv complex dtype 123')
 assert(list_same(r:tolist(),{np.complex(0.12367405742406845,-0.8010180592536926),np.complex(-0.4023594856262207,1.0172219276428223),np.complex(-0.0,-0.0),np.complex(-0.14694666862487793,1.4808695316314697),np.complex(-0.7083033323287964,0.9078875184059143),np.complex(-0.5003700256347656,1.4215468168258667),np.complex(-0.0,-1.249045729637146),np.complex(0.19442614912986755,1.5308812856674194),np.complex(-0.14694666862487793,1.4808695316314697),np.complex(0.2554128170013428,-0.0),np.complex(-0.4023594856262207,-1.338972568511963),np.complex(0.0714891105890274,1.265188455581665),np.complex(-0.0,-0.7853981852531433)},0.00024000000000000003,true,true),'inv complex arctanh 123')
end
do
 local a=np.array({np.complex(0.0,3.0),np.complex(1.0,-0.0),np.complex(-2.0,-3.0),np.complex(-0.0,3.0),np.complex(-5.0,1.0),np.complex(0.75,-0.0),np.complex(0.75,0.0),np.complex(0.75,-1.0),np.complex(0.25,3.0),np.complex(-1.0,1.0),np.complex(-5.0,-1.0),np.complex(5.0,0.5),np.complex(-5.0,0.0)},np.complex64)
 local r=np.arctanh(a)
 assert(r.dtype=='complex64','inv complex dtype 124')
 assert(list_same(r:tolist(),{np.complex(0.0,1.249045729637146),np.complex(math.huge,-0.0),np.complex(-0.14694666862487793,-1.338972568511963),np.complex(-0.0,1.249045729637146),np.complex(-0.19442614912986755,1.5308812856674194),np.complex(0.972955048084259,-0.0),np.complex(0.972955048084259,0.0),np.complex(0.3352934718132019,-0.922481894493103),np.complex(0.024865198880434036,1.2509114742279053),np.complex(-0.4023594856262207,1.0172219276428223),np.complex(-0.19442614912986755,-1.5308812856674194),np.complex(0.20058661699295044,1.55018949508667),np.complex(-0.20273254811763763,1.5707963705062866)},0.00024000000000000003,true,true),'inv complex arctanh 124')
end
do
 local a=np.array({np.complex(1.0,-0.0),np.complex(1.0,-1.0),np.complex(0.25,1.0),np.complex(-0.0,0.5),np.complex(5.0,-0.0),np.complex(-5.0,-1.0),np.complex(-0.0,-3.0),np.complex(1.0,-3.0),np.complex(-1.0,1.0),np.complex(-0.0,1.0),np.complex(2.0,3.0),np.complex(1.0,0.0),np.complex(5.0,0.0)},np.complex64)
 local r=np.arctanh(a)
 assert(r.dtype=='complex64','inv complex dtype 125')
 assert(list_same(r:tolist(),{np.complex(math.huge,-0.0),np.complex(0.4023594856262207,-1.0172219276428223),np.complex(0.12367405742406845,0.8010180592536926),np.complex(-0.0,0.46364760398864746),np.complex(0.20273254811763763,-1.5707963705062866),np.complex(-0.19442614912986755,-1.5308812856674194),np.complex(-0.0,-1.249045729637146),np.complex(0.09193119406700134,-1.2767950296401978),np.complex(-0.4023594856262207,1.0172219276428223),np.complex(-0.0,0.7853981852531433),np.complex(0.14694666862487793,1.338972568511963),np.complex(math.huge,0.0),np.complex(0.20273254811763763,1.5707963705062866)},0.00024000000000000003,true,true),'inv complex arctanh 125')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(-2.0,-0.0),np.complex(-1.0,0.0),np.complex(-1.0,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(1.0,0.0),np.complex(1.0,-0.0),np.complex(2.0,0.0),np.complex(2.0,-0.0),np.complex(0.0,1.0),np.complex(0.0,-1.0),np.complex(0.0,2.0),np.complex(0.0,-2.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,math.huge),np.complex(-math.huge,-math.huge),np.complex((0/0),0.0),np.complex(0.0,(0/0)),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex128)
 local r=np.arcsin(a)
 assert(r.dtype=='complex128','inv complex dtype 126')
 assert(list_same(r:tolist(),{np.complex(-1.5707963267948966,1.3169578969248166),np.complex(-1.5707963267948966,-1.3169578969248166),np.complex(-1.5707963267948966,0.0),np.complex(-1.5707963267948966,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(1.5707963267948966,0.0),np.complex(1.5707963267948966,-0.0),np.complex(1.5707963267948966,1.3169578969248166),np.complex(1.5707963267948966,-1.3169578969248166),np.complex(0.0,0.8813735870195429),np.complex(0.0,-0.8813735870195429),np.complex(0.0,1.4436354751788103),np.complex(0.0,-1.4436354751788103),np.complex(1.5707963267948966,math.huge),np.complex(-1.5707963267948966,math.huge),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(0.7853981633974483,math.huge),np.complex(-0.7853981633974483,-math.huge),np.complex((0/0),(0/0)),np.complex(0.0,(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},1.8000000000000002e-11,true,true),'inv complex arcsin 126')
end
do
 local a=np.array({np.complex(2.0,0.5),np.complex(-0.0,1.0),np.complex(0.25,3.0),np.complex(-5.0,0.5),np.complex(-2.0,-3.0),np.complex(0.75,0.0),np.complex(0.75,-0.0),np.complex(0.25,0.5),np.complex(-5.0,-3.0),np.complex(0.75,-0.0),np.complex(5.0,1.0),np.complex(5.0,1.0),np.complex(2.0,0.0)},np.complex128)
 local r=np.arcsin(a)
 assert(r.dtype=='complex128','inv complex dtype 127')
 assert(list_same(r:tolist(),{np.complex(1.2930420702371825,1.3618009008578458),np.complex(-0.0,0.8813735870195429),np.complex(0.07891728019870327,1.8214041607957312),np.complex(-1.469108116249534,2.2977170809810494),np.complex(-0.5706527843210994,-1.9833870299165355),np.complex(0.848062078981481,0.0),np.complex(0.848062078981481,-0.0),np.complex(0.2243284526346675,0.4926756834207706),np.complex(-1.023821746511783,-2.452913742502812),np.complex(0.848062078981481,-0.0),np.complex(1.3696012470939865,2.3132209417695293),np.complex(1.3696012470939865,2.3132209417695293),np.complex(1.5707963267948966,1.3169578969248166)},1.8000000000000002e-11,true,true),'inv complex arcsin 127')
end
do
 local a=np.array({np.complex(1.0,-3.0),np.complex(0.25,-3.0),np.complex(1.0,1.0),np.complex(0.25,-3.0),np.complex(0.75,-1.0),np.complex(-5.0,0.5),np.complex(-2.0,-0.0),np.complex(0.25,-3.0),np.complex(-0.0,-0.0),np.complex(1.0,-0.0),np.complex(0.75,-3.0),np.complex(0.25,-0.0),np.complex(-0.0,-0.0)},np.complex128)
 local r=np.arcsin(a)
 assert(r.dtype=='complex128','inv complex dtype 128')
 assert(list_same(r:tolist(),{np.complex(0.30760364953071123,-1.8641615441578825),np.complex(0.07891728019870327,-1.8214041607957312),np.complex(0.6662394324925153,1.0612750619050357),np.complex(0.07891728019870327,-1.8214041607957312),np.complex(0.5148381840389585,-0.9828661390291652),np.complex(-1.469108116249534,2.2977170809810494),np.complex(-1.5707963267948966,-1.3169578969248166),np.complex(0.07891728019870327,-1.8214041607957312),np.complex(-0.0,-0.0),np.complex(1.5707963267948966,-0.0),np.complex(0.23347144902560832,-1.8445760096309898),np.complex(0.25268025514207865,-0.0),np.complex(-0.0,-0.0)},1.8000000000000002e-11,true,true),'inv complex arcsin 128')
end
do
 local a=np.array({np.complex(-2.0,3.0),np.complex(1.0,-1.0),np.complex(-0.0,-3.0),np.complex(5.0,1.0),np.complex(-1.0,-1.0),np.complex(-0.0,-1.0),np.complex(-2.0,-3.0),np.complex(0.75,-0.0),np.complex(0.75,0.0),np.complex(-2.0,-1.0),np.complex(-2.0,0.5),np.complex(0.0,3.0),np.complex(-0.0,-3.0)},np.complex128)
 local r=np.arcsin(a)
 assert(r.dtype=='complex128','inv complex dtype 129')
 assert(list_same(r:tolist(),{np.complex(-0.5706527843210994,1.9833870299165355),np.complex(0.6662394324925153,-1.0612750619050357),np.complex(-0.0,-1.8184464592320668),np.complex(1.3696012470939865,2.3132209417695293),np.complex(-0.6662394324925153,-1.0612750619050357),np.complex(-0.0,-0.8813735870195429),np.complex(-0.5706527843210994,-1.9833870299165355),np.complex(0.848062078981481,-0.0),np.complex(0.848062078981481,0.0),np.complex(-1.0634400235777521,-1.4693517443681852),np.complex(-1.2930420702371825,1.3618009008578458),np.complex(0.0,1.8184464592320668),np.complex(-0.0,-1.8184464592320668)},1.8000000000000002e-11,true,true),'inv complex arcsin 129')
end
do
 local a=np.array({np.complex(5.0,0.5),np.complex(0.75,-3.0),np.complex(2.0,0.0),np.complex(0.75,-0.0),np.complex(-2.0,-3.0),np.complex(1.0,-3.0),np.complex(0.75,0.0),np.complex(-0.0,-0.0),np.complex(1.0,0.0),np.complex(-2.0,0.0),np.complex(-0.0,-3.0),np.complex(0.75,3.0),np.complex(1.0,0.0)},np.complex128)
 local r=np.arcsin(a)
 assert(r.dtype=='complex128','inv complex dtype 130')
 assert(list_same(r:tolist(),{np.complex(1.469108116249534,2.2977170809810494),np.complex(0.23347144902560832,-1.8445760096309898),np.complex(1.5707963267948966,1.3169578969248166),np.complex(0.848062078981481,-0.0),np.complex(-0.5706527843210994,-1.9833870299165355),np.complex(0.30760364953071123,-1.8641615441578825),np.complex(0.848062078981481,0.0),np.complex(-0.0,-0.0),np.complex(1.5707963267948966,0.0),np.complex(-1.5707963267948966,1.3169578969248166),np.complex(-0.0,-1.8184464592320668),np.complex(0.23347144902560832,1.8445760096309898),np.complex(1.5707963267948966,0.0)},1.8000000000000002e-11,true,true),'inv complex arcsin 130')
end
do
 local a=np.array({np.complex(-5.0,-1.0),np.complex(0.0,-0.0),np.complex(1.0,-0.0),np.complex(-2.0,3.0),np.complex(-5.0,3.0),np.complex(5.0,0.5),np.complex(0.25,0.0),np.complex(1.0,1.0),np.complex(-0.0,-3.0),np.complex(0.75,-0.0),np.complex(-1.0,-3.0),np.complex(-2.0,-0.0),np.complex(0.75,0.5)},np.complex128)
 local r=np.arcsin(a)
 assert(r.dtype=='complex128','inv complex dtype 131')
 assert(list_same(r:tolist(),{np.complex(-1.3696012470939865,-2.3132209417695293),np.complex(0.0,-0.0),np.complex(1.5707963267948966,-0.0),np.complex(-0.5706527843210994,1.9833870299165355),np.complex(-1.023821746511783,2.452913742502812),np.complex(1.469108116249534,2.2977170809810494),np.complex(0.25268025514207865,0.0),np.complex(0.6662394324925153,1.0612750619050357),np.complex(-0.0,-1.8184464592320668),np.complex(0.848062078981481,-0.0),np.complex(-0.30760364953071123,-1.8641615441578825),np.complex(-1.5707963267948966,-1.3169578969248166),np.complex(0.6822039655834323,0.6063349998873513)},1.8000000000000002e-11,true,true),'inv complex arcsin 131')
end
do
 local a=np.array({np.complex(-5.0,-0.0),np.complex(-2.0,-1.0),np.complex(-0.0,1.0),np.complex(-0.0,3.0),np.complex(0.75,1.0),np.complex(0.75,0.0),np.complex(-0.0,3.0),np.complex(5.0,0.5),np.complex(1.0,-0.0),np.complex(-2.0,0.5),np.complex(2.0,0.0),np.complex(0.25,1.0),np.complex(0.75,-1.0)},np.complex128)
 local r=np.arcsin(a)
 assert(r.dtype=='complex128','inv complex dtype 132')
 assert(list_same(r:tolist(),{np.complex(-1.5707963267948966,-2.2924316695611777),np.complex(-1.0634400235777521,-1.4693517443681852),np.complex(-0.0,0.8813735870195429),np.complex(-0.0,1.8184464592320668),np.complex(0.5148381840389585,0.9828661390291652),np.complex(0.848062078981481,0.0),np.complex(-0.0,1.8184464592320668),np.complex(1.469108116249534,2.2977170809810494),np.complex(1.5707963267948966,-0.0),np.complex(-1.2930420702371825,1.3618009008578458),np.complex(1.5707963267948966,1.3169578969248166),np.complex(0.17630243277696694,0.8924633639033482),np.complex(0.5148381840389585,-0.9828661390291652)},1.8000000000000002e-11,true,true),'inv complex arcsin 132')
end
do
 local a=np.array({np.complex(2.0,-0.0),np.complex(-5.0,-0.0),np.complex(0.0,-0.0),np.complex(-5.0,1.0),np.complex(1.0,0.0),np.complex(5.0,0.0),np.complex(-0.0,-1.0),np.complex(2.0,3.0),np.complex(1.0,1.0),np.complex(0.25,-0.0),np.complex(5.0,-1.0),np.complex(-2.0,0.5),np.complex(-2.0,3.0)},np.complex128)
 local r=np.arcsin(a)
 assert(r.dtype=='complex128','inv complex dtype 133')
 assert(list_same(r:tolist(),{np.complex(1.5707963267948966,-1.3169578969248166),np.complex(-1.5707963267948966,-2.2924316695611777),np.complex(0.0,-0.0),np.complex(-1.3696012470939865,2.3132209417695293),np.complex(1.5707963267948966,0.0),np.complex(1.5707963267948966,2.2924316695611777),np.complex(-0.0,-0.8813735870195429),np.complex(0.5706527843210994,1.9833870299165355),np.complex(0.6662394324925153,1.0612750619050357),np.complex(0.25268025514207865,-0.0),np.complex(1.3696012470939865,-2.3132209417695293),np.complex(-1.2930420702371825,1.3618009008578458),np.complex(-0.5706527843210994,1.9833870299165355)},1.8000000000000002e-11,true,true),'inv complex arcsin 133')
end
do
 local a=np.array({np.complex(-2.0,3.0),np.complex(0.25,-3.0),np.complex(-2.0,1.0),np.complex(-1.0,0.0),np.complex(1.0,1.0),np.complex(-1.0,-1.0),np.complex(1.0,0.0),np.complex(-1.0,1.0),np.complex(-2.0,3.0),np.complex(0.0,3.0),np.complex(-5.0,-0.0),np.complex(0.25,0.5),np.complex(-0.0,0.5)},np.complex128)
 local r=np.arcsin(a)
 assert(r.dtype=='complex128','inv complex dtype 134')
 assert(list_same(r:tolist(),{np.complex(-0.5706527843210994,1.9833870299165355),np.complex(0.07891728019870327,-1.8214041607957312),np.complex(-1.0634400235777521,1.4693517443681852),np.complex(-1.5707963267948966,0.0),np.complex(0.6662394324925153,1.0612750619050357),np.complex(-0.6662394324925153,-1.0612750619050357),np.complex(1.5707963267948966,0.0),np.complex(-0.6662394324925153,1.0612750619050357),np.complex(-0.5706527843210994,1.9833870299165355),np.complex(0.0,1.8184464592320668),np.complex(-1.5707963267948966,-2.2924316695611777),np.complex(0.2243284526346675,0.4926756834207706),np.complex(-0.0,0.48121182505960347)},1.8000000000000002e-11,true,true),'inv complex arcsin 134')
end
do
 local a=np.array({np.complex(1.0,1.0),np.complex(5.0,-3.0),np.complex(5.0,3.0),np.complex(-2.0,0.0),np.complex(0.75,-1.0),np.complex(-2.0,1.0),np.complex(-5.0,-1.0),np.complex(-1.0,1.0),np.complex(5.0,-3.0),np.complex(0.0,0.0),np.complex(-2.0,3.0),np.complex(0.25,1.0),np.complex(1.0,3.0)},np.complex128)
 local r=np.arcsin(a)
 assert(r.dtype=='complex128','inv complex dtype 135')
 assert(list_same(r:tolist(),{np.complex(0.6662394324925153,1.0612750619050357),np.complex(1.023821746511783,-2.452913742502812),np.complex(1.023821746511783,2.452913742502812),np.complex(-1.5707963267948966,1.3169578969248166),np.complex(0.5148381840389585,-0.9828661390291652),np.complex(-1.0634400235777521,1.4693517443681852),np.complex(-1.3696012470939865,-2.3132209417695293),np.complex(-0.6662394324925153,1.0612750619050357),np.complex(1.023821746511783,-2.452913742502812),np.complex(0.0,0.0),np.complex(-0.5706527843210994,1.9833870299165355),np.complex(0.17630243277696694,0.8924633639033482),np.complex(0.30760364953071123,1.8641615441578825)},1.8000000000000002e-11,true,true),'inv complex arcsin 135')
end
do
 local a=np.array({np.complex(0.25,3.0),np.complex(-5.0,3.0),np.complex(0.25,-1.0),np.complex(-0.0,0.5),np.complex(-5.0,0.0),np.complex(0.75,0.5),np.complex(-5.0,1.0),np.complex(1.0,-3.0),np.complex(-1.0,-1.0),np.complex(-2.0,-3.0),np.complex(0.25,0.0),np.complex(-0.0,3.0),np.complex(-5.0,0.0)},np.complex128)
 local r=np.arcsin(a)
 assert(r.dtype=='complex128','inv complex dtype 136')
 assert(list_same(r:tolist(),{np.complex(0.07891728019870327,1.8214041607957312),np.complex(-1.023821746511783,2.452913742502812),np.complex(0.17630243277696694,-0.8924633639033482),np.complex(-0.0,0.48121182505960347),np.complex(-1.5707963267948966,2.2924316695611777),np.complex(0.6822039655834323,0.6063349998873513),np.complex(-1.3696012470939865,2.3132209417695293),np.complex(0.30760364953071123,-1.8641615441578825),np.complex(-0.6662394324925153,-1.0612750619050357),np.complex(-0.5706527843210994,-1.9833870299165355),np.complex(0.25268025514207865,0.0),np.complex(-0.0,1.8184464592320668),np.complex(-1.5707963267948966,2.2924316695611777)},1.8000000000000002e-11,true,true),'inv complex arcsin 136')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(-2.0,-0.0),np.complex(-1.0,0.0),np.complex(-1.0,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(1.0,0.0),np.complex(1.0,-0.0),np.complex(2.0,0.0),np.complex(2.0,-0.0),np.complex(0.0,1.0),np.complex(0.0,-1.0),np.complex(0.0,2.0),np.complex(0.0,-2.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,math.huge),np.complex(-math.huge,-math.huge),np.complex((0/0),0.0),np.complex(0.0,(0/0)),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex128)
 local r=np.arccos(a)
 assert(r.dtype=='complex128','inv complex dtype 137')
 assert(list_same(r:tolist(),{np.complex(3.141592653589793,-1.3169578969248166),np.complex(3.141592653589793,1.3169578969248166),np.complex(3.141592653589793,-0.0),np.complex(3.141592653589793,0.0),np.complex(1.5707963267948966,-0.0),np.complex(1.5707963267948966,0.0),np.complex(1.5707963267948966,-0.0),np.complex(1.5707963267948966,0.0),np.complex(0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-1.3169578969248166),np.complex(0.0,1.3169578969248166),np.complex(1.5707963267948966,-0.8813735870195429),np.complex(1.5707963267948966,0.8813735870195429),np.complex(1.5707963267948966,-1.4436354751788103),np.complex(1.5707963267948966,1.4436354751788103),np.complex(0.0,-math.huge),np.complex(3.141592653589793,-math.huge),np.complex(1.5707963267948966,-math.huge),np.complex(1.5707963267948966,math.huge),np.complex(0.7853981633974483,-math.huge),np.complex(2.356194490192345,math.huge),np.complex((0/0),(0/0)),np.complex(1.5707963267948966,(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},1.8000000000000002e-11,true,true),'inv complex arccos 137')
end
do
 local a=np.array({np.complex(0.0,-1.0),np.complex(0.0,-3.0),np.complex(-1.0,0.0),np.complex(0.25,3.0),np.complex(1.0,-3.0),np.complex(-1.0,1.0),np.complex(0.0,0.0),np.complex(5.0,-0.0),np.complex(-5.0,0.0),np.complex(2.0,-3.0),np.complex(0.0,0.0),np.complex(-1.0,-3.0),np.complex(-0.0,-1.0)},np.complex128)
 local r=np.arccos(a)
 assert(r.dtype=='complex128','inv complex dtype 138')
 assert(list_same(r:tolist(),{np.complex(1.5707963267948966,0.8813735870195429),np.complex(1.5707963267948966,1.8184464592320668),np.complex(3.141592653589793,-0.0),np.complex(1.4918790465961933,-1.8214041607957312),np.complex(1.2631926772641855,1.8641615441578825),np.complex(2.2370357592874117,-1.0612750619050357),np.complex(1.5707963267948966,-0.0),np.complex(0.0,2.2924316695611777),np.complex(3.141592653589793,-2.2924316695611777),np.complex(1.0001435424737972,1.9833870299165355),np.complex(1.5707963267948966,-0.0),np.complex(1.8783999763256078,1.8641615441578825),np.complex(1.5707963267948966,0.8813735870195429)},1.8000000000000002e-11,true,true),'inv complex arccos 138')
end
do
 local a=np.array({np.complex(0.25,0.5),np.complex(-2.0,3.0),np.complex(5.0,3.0),np.complex(-2.0,0.5),np.complex(5.0,-3.0),np.complex(-0.0,-3.0),np.complex(0.25,0.5),np.complex(-5.0,3.0),np.complex(5.0,-3.0),np.complex(0.75,-0.0),np.complex(0.25,-3.0),np.complex(-0.0,-1.0),np.complex(-1.0,-1.0)},np.complex128)
 local r=np.arccos(a)
 assert(r.dtype=='complex128','inv complex dtype 139')
 assert(list_same(r:tolist(),{np.complex(1.3464678741602292,-0.4926756834207706),np.complex(2.141449111115996,-1.9833870299165355),np.complex(0.5469745802831137,-2.452913742502812),np.complex(2.863838397032079,-1.3618009008578458),np.complex(0.5469745802831137,2.452913742502812),np.complex(1.5707963267948966,1.8184464592320668),np.complex(1.3464678741602292,-0.4926756834207706),np.complex(2.5946180733066795,-2.452913742502812),np.complex(0.5469745802831137,2.452913742502812),np.complex(0.7227342478134157,0.0),np.complex(1.4918790465961933,1.8214041607957312),np.complex(1.5707963267948966,0.8813735870195429),np.complex(2.2370357592874117,1.0612750619050357)},1.8000000000000002e-11,true,true),'inv complex arccos 139')
end
do
 local a=np.array({np.complex(-2.0,-1.0),np.complex(-0.0,0.0),np.complex(0.0,0.5),np.complex(-1.0,0.5),np.complex(0.25,1.0),np.complex(-0.0,0.5),np.complex(0.75,-0.0),np.complex(-0.0,-0.0),np.complex(5.0,0.0),np.complex(-1.0,-3.0),np.complex(-0.0,-3.0),np.complex(0.25,-0.0),np.complex(1.0,1.0)},np.complex128)
 local r=np.arccos(a)
 assert(r.dtype=='complex128','inv complex dtype 140')
 assert(list_same(r:tolist(),{np.complex(2.6342363503726487,1.4693517443681852),np.complex(1.5707963267948966,-0.0),np.complex(1.5707963267948966,-0.48121182505960347),np.complex(2.466703808003787,-0.7328576759736453),np.complex(1.3944938940179297,-0.8924633639033482),np.complex(1.5707963267948966,-0.48121182505960347),np.complex(0.7227342478134157,0.0),np.complex(1.5707963267948966,0.0),np.complex(0.0,-2.2924316695611777),np.complex(1.8783999763256078,1.8641615441578825),np.complex(1.5707963267948966,1.8184464592320668),np.complex(1.318116071652818,0.0),np.complex(0.9045568943023813,-1.0612750619050357)},1.8000000000000002e-11,true,true),'inv complex arccos 140')
end
do
 local a=np.array({np.complex(-5.0,1.0),np.complex(1.0,0.5),np.complex(0.0,3.0),np.complex(-0.0,0.5),np.complex(-2.0,-1.0),np.complex(2.0,0.0),np.complex(-1.0,-1.0),np.complex(5.0,-3.0),np.complex(0.25,0.5),np.complex(5.0,0.0),np.complex(5.0,0.0),np.complex(-5.0,3.0),np.complex(0.75,3.0)},np.complex128)
 local r=np.arccos(a)
 assert(r.dtype=='complex128','inv complex dtype 141')
 assert(list_same(r:tolist(),{np.complex(2.940397573888883,-2.3132209417695293),np.complex(0.6748888455860064,-0.7328576759736453),np.complex(1.5707963267948966,-1.8184464592320668),np.complex(1.5707963267948966,-0.48121182505960347),np.complex(2.6342363503726487,1.4693517443681852),np.complex(0.0,-1.3169578969248166),np.complex(2.2370357592874117,1.0612750619050357),np.complex(0.5469745802831137,2.452913742502812),np.complex(1.3464678741602292,-0.4926756834207706),np.complex(0.0,-2.2924316695611777),np.complex(0.0,-2.2924316695611777),np.complex(2.5946180733066795,-2.452913742502812),np.complex(1.3373248777692883,-1.8445760096309898)},1.8000000000000002e-11,true,true),'inv complex arccos 141')
end
do
 local a=np.array({np.complex(0.0,-0.0),np.complex(-2.0,-0.0),np.complex(-1.0,-3.0),np.complex(-2.0,0.0),np.complex(-0.0,3.0),np.complex(0.25,0.5),np.complex(-1.0,-3.0),np.complex(-0.0,0.0),np.complex(2.0,0.5),np.complex(-2.0,-1.0),np.complex(0.25,3.0),np.complex(-5.0,3.0),np.complex(0.25,-0.0)},np.complex128)
 local r=np.arccos(a)
 assert(r.dtype=='complex128','inv complex dtype 142')
 assert(list_same(r:tolist(),{np.complex(1.5707963267948966,0.0),np.complex(3.141592653589793,1.3169578969248166),np.complex(1.8783999763256078,1.8641615441578825),np.complex(3.141592653589793,-1.3169578969248166),np.complex(1.5707963267948966,-1.8184464592320668),np.complex(1.3464678741602292,-0.4926756834207706),np.complex(1.8783999763256078,1.8641615441578825),np.complex(1.5707963267948966,-0.0),np.complex(0.27775425655771396,-1.3618009008578458),np.complex(2.6342363503726487,1.4693517443681852),np.complex(1.4918790465961933,-1.8214041607957312),np.complex(2.5946180733066795,-2.452913742502812),np.complex(1.318116071652818,0.0)},1.8000000000000002e-11,true,true),'inv complex arccos 142')
end
do
 local a=np.array({np.complex(0.25,1.0),np.complex(-1.0,3.0),np.complex(0.0,0.5),np.complex(-5.0,-0.0),np.complex(-5.0,-3.0),np.complex(5.0,3.0),np.complex(5.0,3.0),np.complex(-5.0,-3.0),np.complex(-2.0,3.0),np.complex(-2.0,-1.0),np.complex(-1.0,0.0),np.complex(0.75,3.0),np.complex(-5.0,-1.0)},np.complex128)
 local r=np.arccos(a)
 assert(r.dtype=='complex128','inv complex dtype 143')
 assert(list_same(r:tolist(),{np.complex(1.3944938940179297,-0.8924633639033482),np.complex(1.8783999763256078,-1.8641615441578825),np.complex(1.5707963267948966,-0.48121182505960347),np.complex(3.141592653589793,2.2924316695611777),np.complex(2.5946180733066795,2.452913742502812),np.complex(0.5469745802831137,-2.452913742502812),np.complex(0.5469745802831137,-2.452913742502812),np.complex(2.5946180733066795,2.452913742502812),np.complex(2.141449111115996,-1.9833870299165355),np.complex(2.6342363503726487,1.4693517443681852),np.complex(3.141592653589793,-0.0),np.complex(1.3373248777692883,-1.8445760096309898),np.complex(2.940397573888883,2.3132209417695293)},1.8000000000000002e-11,true,true),'inv complex arccos 143')
end
do
 local a=np.array({np.complex(-2.0,1.0),np.complex(1.0,0.0),np.complex(0.25,-1.0),np.complex(-5.0,-3.0),np.complex(0.75,-0.0),np.complex(-0.0,-1.0),np.complex(-2.0,0.0),np.complex(5.0,-1.0),np.complex(0.0,1.0),np.complex(-0.0,0.5),np.complex(-0.0,3.0),np.complex(5.0,1.0),np.complex(0.0,0.0)},np.complex128)
 local r=np.arccos(a)
 assert(r.dtype=='complex128','inv complex dtype 144')
 assert(list_same(r:tolist(),{np.complex(2.6342363503726487,-1.4693517443681852),np.complex(0.0,-0.0),np.complex(1.3944938940179297,0.8924633639033482),np.complex(2.5946180733066795,2.452913742502812),np.complex(0.7227342478134157,0.0),np.complex(1.5707963267948966,0.8813735870195429),np.complex(3.141592653589793,-1.3169578969248166),np.complex(0.20119507970091022,2.3132209417695293),np.complex(1.5707963267948966,-0.8813735870195429),np.complex(1.5707963267948966,-0.48121182505960347),np.complex(1.5707963267948966,-1.8184464592320668),np.complex(0.20119507970091022,-2.3132209417695293),np.complex(1.5707963267948966,-0.0)},1.8000000000000002e-11,true,true),'inv complex arccos 144')
end
do
 local a=np.array({np.complex(0.0,0.5),np.complex(0.75,-3.0),np.complex(0.0,3.0),np.complex(-5.0,0.5),np.complex(-0.0,-0.0),np.complex(5.0,0.0),np.complex(0.75,1.0),np.complex(5.0,1.0),np.complex(-1.0,-1.0),np.complex(0.75,-3.0),np.complex(-5.0,-0.0),np.complex(5.0,0.5),np.complex(-1.0,3.0)},np.complex128)
 local r=np.arccos(a)
 assert(r.dtype=='complex128','inv complex dtype 145')
 assert(list_same(r:tolist(),{np.complex(1.5707963267948966,-0.48121182505960347),np.complex(1.3373248777692883,1.8445760096309898),np.complex(1.5707963267948966,-1.8184464592320668),np.complex(3.0399044430444304,-2.2977170809810494),np.complex(1.5707963267948966,0.0),np.complex(0.0,-2.2924316695611777),np.complex(1.0559581427559381,-0.9828661390291652),np.complex(0.20119507970091022,-2.3132209417695293),np.complex(2.2370357592874117,1.0612750619050357),np.complex(1.3373248777692883,1.8445760096309898),np.complex(3.141592653589793,2.2924316695611777),np.complex(0.10168821054536263,-2.2977170809810494),np.complex(1.8783999763256078,-1.8641615441578825)},1.8000000000000002e-11,true,true),'inv complex arccos 145')
end
do
 local a=np.array({np.complex(-1.0,3.0),np.complex(-1.0,-0.0),np.complex(5.0,0.5),np.complex(-0.0,0.0),np.complex(0.25,0.0),np.complex(5.0,1.0),np.complex(-1.0,-1.0),np.complex(-2.0,-0.0),np.complex(1.0,-3.0),np.complex(-5.0,3.0),np.complex(2.0,3.0),np.complex(1.0,1.0),np.complex(2.0,-0.0)},np.complex128)
 local r=np.arccos(a)
 assert(r.dtype=='complex128','inv complex dtype 146')
 assert(list_same(r:tolist(),{np.complex(1.8783999763256078,-1.8641615441578825),np.complex(3.141592653589793,0.0),np.complex(0.10168821054536263,-2.2977170809810494),np.complex(1.5707963267948966,-0.0),np.complex(1.318116071652818,-0.0),np.complex(0.20119507970091022,-2.3132209417695293),np.complex(2.2370357592874117,1.0612750619050357),np.complex(3.141592653589793,1.3169578969248166),np.complex(1.2631926772641855,1.8641615441578825),np.complex(2.5946180733066795,-2.452913742502812),np.complex(1.0001435424737972,-1.9833870299165355),np.complex(0.9045568943023813,-1.0612750619050357),np.complex(0.0,1.3169578969248166)},1.8000000000000002e-11,true,true),'inv complex arccos 146')
end
do
 local a=np.array({np.complex(0.25,-1.0),np.complex(2.0,3.0),np.complex(-5.0,-1.0),np.complex(5.0,-3.0),np.complex(-2.0,3.0),np.complex(-0.0,0.5),np.complex(0.25,3.0),np.complex(0.25,-0.0),np.complex(-5.0,-3.0),np.complex(-2.0,1.0),np.complex(-0.0,0.0),np.complex(2.0,0.5),np.complex(-2.0,1.0)},np.complex128)
 local r=np.arccos(a)
 assert(r.dtype=='complex128','inv complex dtype 147')
 assert(list_same(r:tolist(),{np.complex(1.3944938940179297,0.8924633639033482),np.complex(1.0001435424737972,-1.9833870299165355),np.complex(2.940397573888883,2.3132209417695293),np.complex(0.5469745802831137,2.452913742502812),np.complex(2.141449111115996,-1.9833870299165355),np.complex(1.5707963267948966,-0.48121182505960347),np.complex(1.4918790465961933,-1.8214041607957312),np.complex(1.318116071652818,0.0),np.complex(2.5946180733066795,2.452913742502812),np.complex(2.6342363503726487,-1.4693517443681852),np.complex(1.5707963267948966,-0.0),np.complex(0.27775425655771396,-1.3618009008578458),np.complex(2.6342363503726487,-1.4693517443681852)},1.8000000000000002e-11,true,true),'inv complex arccos 147')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(-2.0,-0.0),np.complex(-1.0,0.0),np.complex(-1.0,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(1.0,0.0),np.complex(1.0,-0.0),np.complex(2.0,0.0),np.complex(2.0,-0.0),np.complex(0.0,1.0),np.complex(0.0,-1.0),np.complex(0.0,2.0),np.complex(0.0,-2.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,math.huge),np.complex(-math.huge,-math.huge),np.complex((0/0),0.0),np.complex(0.0,(0/0)),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex128)
 local r=np.arctan(a)
 assert(r.dtype=='complex128','inv complex dtype 148')
 assert(list_same(r:tolist(),{np.complex(-1.1071487177940904,0.0),np.complex(-1.1071487177940904,-0.0),np.complex(-0.7853981633974483,0.0),np.complex(-0.7853981633974483,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(0.7853981633974483,0.0),np.complex(0.7853981633974483,-0.0),np.complex(1.1071487177940904,0.0),np.complex(1.1071487177940904,-0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(1.5707963267948966,0.5493061443340549),np.complex(1.5707963267948966,-0.5493061443340549),np.complex(1.5707963267948966,0.0),np.complex(-1.5707963267948966,0.0),np.complex(1.5707963267948966,0.0),np.complex(1.5707963267948966,-0.0),np.complex(1.5707963267948966,0.0),np.complex(-1.5707963267948966,-0.0),np.complex((0/0),0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},1.8000000000000002e-11,true,true),'inv complex arctan 148')
end
do
 local a=np.array({np.complex(-1.0,0.5),np.complex(2.0,3.0),np.complex(-2.0,3.0),np.complex(-0.0,-1.0),np.complex(-2.0,-3.0),np.complex(2.0,3.0),np.complex(-5.0,3.0),np.complex(-1.0,3.0),np.complex(5.0,1.0),np.complex(1.0,0.5),np.complex(1.0,-1.0),np.complex(-2.0,-1.0),np.complex(-5.0,0.5)},np.complex128)
 local r=np.arctan(a)
 assert(r.dtype=='complex128','inv complex dtype 149')
 assert(list_same(r:tolist(),{np.complex(-0.847575660670829,0.23887786125685911),np.complex(1.4099210495965755,0.22907268296853878),np.complex(-1.4099210495965755,0.22907268296853878),np.complex(-0.0,-math.huge),np.complex(-1.4099210495965755,-0.22907268296853875),np.complex(1.4099210495965755,0.22907268296853878),np.complex(-1.4236790442393028,0.08656905917945845),np.complex(-1.4614618538579256,0.3059438579055289),np.complex(1.380543138238714,0.03710500127956832),np.complex(0.847575660670829,0.23887786125685911),np.complex(1.0172219678978514,-0.40235947810852507),np.complex(-1.1780972450961724,-0.17328679513998632),np.complex(-1.375233603310382,0.01905684134697106)},1.8000000000000002e-11,true,true),'inv complex arctan 149')
end
do
 local a=np.array({np.complex(2.0,-0.0),np.complex(-2.0,0.5),np.complex(2.0,0.5),np.complex(0.25,-0.0),np.complex(-0.0,1.0),np.complex(0.75,-1.0),np.complex(-2.0,-1.0),np.complex(5.0,3.0),np.complex(1.0,0.5),np.complex(5.0,3.0),np.complex(1.0,-0.0),np.complex(2.0,-3.0),np.complex(0.75,0.0)},np.complex128)
 local r=np.arctan(a)
 assert(r.dtype=='complex128','inv complex dtype 150')
 assert(list_same(r:tolist(),{np.complex(1.1071487177940904,-0.0),np.complex(-1.1265564408348223,0.09641562020299617),np.complex(1.1265564408348223,0.09641562020299617),np.complex(0.24497866312686414,-0.0),np.complex(-0.0,math.huge),np.complex(0.9647834985327344,-0.523308715953043),np.complex(-1.1780972450961724,-0.17328679513998632),np.complex(1.4236790442393028,0.08656905917945845),np.complex(0.847575660670829,0.23887786125685911),np.complex(1.4236790442393028,0.08656905917945845),np.complex(0.7853981633974483,-0.0),np.complex(1.4099210495965755,-0.22907268296853875),np.complex(0.6435011087932844,0.0)},1.8000000000000002e-11,true,true),'inv complex arctan 150')
end
do
 local a=np.array({np.complex(-5.0,3.0),np.complex(-1.0,-0.0),np.complex(0.0,-0.0),np.complex(5.0,-1.0),np.complex(-0.0,-1.0),np.complex(0.0,-3.0),np.complex(1.0,0.5),np.complex(-0.0,-1.0),np.complex(-5.0,-3.0),np.complex(0.25,-0.0),np.complex(0.0,-3.0),np.complex(5.0,3.0),np.complex(-1.0,0.0)},np.complex128)
 local r=np.arctan(a)
 assert(r.dtype=='complex128','inv complex dtype 151')
 assert(list_same(r:tolist(),{np.complex(-1.4236790442393028,0.08656905917945845),np.complex(-0.7853981633974483,-0.0),np.complex(0.0,-0.0),np.complex(1.380543138238714,-0.03710500127956832),np.complex(-0.0,-math.huge),np.complex(1.5707963267948966,-0.34657359027997264),np.complex(0.847575660670829,0.23887786125685911),np.complex(-0.0,-math.huge),np.complex(-1.4236790442393028,-0.08656905917945844),np.complex(0.24497866312686414,-0.0),np.complex(1.5707963267948966,-0.34657359027997264),np.complex(1.4236790442393028,0.08656905917945845),np.complex(-0.7853981633974483,0.0)},1.8000000000000002e-11,true,true),'inv complex arctan 151')
end
do
 local a=np.array({np.complex(1.0,-0.0),np.complex(5.0,0.5),np.complex(-1.0,-3.0),np.complex(1.0,-0.0),np.complex(-1.0,1.0),np.complex(-2.0,0.5),np.complex(-0.0,1.0),np.complex(5.0,3.0),np.complex(0.0,1.0),np.complex(5.0,3.0),np.complex(5.0,0.5),np.complex(-0.0,0.0),np.complex(0.0,0.0)},np.complex128)
 local r=np.arctan(a)
 assert(r.dtype=='complex128','inv complex dtype 152')
 assert(list_same(r:tolist(),{np.complex(0.7853981633974483,-0.0),np.complex(1.375233603310382,0.01905684134697106),np.complex(-1.4614618538579256,-0.3059438579055289),np.complex(0.7853981633974483,-0.0),np.complex(-1.0172219678978514,0.40235947810852507),np.complex(-1.1265564408348223,0.09641562020299617),np.complex(-0.0,math.huge),np.complex(1.4236790442393028,0.08656905917945845),np.complex(0.0,math.huge),np.complex(1.4236790442393028,0.08656905917945845),np.complex(1.375233603310382,0.01905684134697106),np.complex(-0.0,0.0),np.complex(0.0,0.0)},1.8000000000000002e-11,true,true),'inv complex arctan 152')
end
do
 local a=np.array({np.complex(2.0,3.0),np.complex(-0.0,0.5),np.complex(-2.0,-1.0),np.complex(0.25,1.0),np.complex(-1.0,3.0),np.complex(0.25,-3.0),np.complex(0.25,-1.0),np.complex(0.75,-1.0),np.complex(1.0,-0.0),np.complex(-2.0,-0.0),np.complex(0.0,0.0),np.complex(-5.0,0.0),np.complex(2.0,0.5)},np.complex128)
 local r=np.arctan(a)
 assert(r.dtype=='complex128','inv complex dtype 153')
 assert(list_same(r:tolist(),{np.complex(1.4099210495965755,0.22907268296853878),np.complex(-0.0,0.5493061443340549),np.complex(-1.1780972450961724,-0.17328679513998632),np.complex(0.847575660670829,1.0435968174739092),np.complex(-1.4614618538579256,0.3059438579055289),np.complex(1.5398282345194945,-0.34367220374989566),np.complex(0.847575660670829,-1.0435968174739092),np.complex(0.9647834985327344,-0.523308715953043),np.complex(0.7853981633974483,-0.0),np.complex(-1.1071487177940904,-0.0),np.complex(0.0,0.0),np.complex(-1.373400766945016,0.0),np.complex(1.1265564408348223,0.09641562020299617)},1.8000000000000002e-11,true,true),'inv complex arctan 153')
end
do
 local a=np.array({np.complex(1.0,-1.0),np.complex(-0.0,1.0),np.complex(2.0,3.0),np.complex(0.75,1.0),np.complex(-2.0,-0.0),np.complex(0.0,-3.0),np.complex(5.0,-3.0),np.complex(-2.0,-3.0),np.complex(1.0,1.0),np.complex(2.0,-3.0),np.complex(0.0,-3.0),np.complex(0.25,3.0),np.complex(0.0,-0.0)},np.complex128)
 local r=np.arctan(a)
 assert(r.dtype=='complex128','inv complex dtype 154')
 assert(list_same(r:tolist(),{np.complex(1.0172219678978514,-0.40235947810852507),np.complex(-0.0,math.huge),np.complex(1.4099210495965755,0.22907268296853878),np.complex(0.9647834985327344,0.523308715953043),np.complex(-1.1071487177940904,-0.0),np.complex(1.5707963267948966,-0.34657359027997264),np.complex(1.4236790442393028,-0.08656905917945844),np.complex(-1.4099210495965755,-0.22907268296853875),np.complex(1.0172219678978514,0.40235947810852507),np.complex(1.4099210495965755,-0.22907268296853875),np.complex(1.5707963267948966,-0.34657359027997264),np.complex(1.5398282345194945,0.34367220374989566),np.complex(0.0,-0.0)},1.8000000000000002e-11,true,true),'inv complex arctan 154')
end
do
 local a=np.array({np.complex(-0.0,0.0),np.complex(0.25,0.0),np.complex(0.75,0.5),np.complex(-2.0,-3.0),np.complex(-5.0,-1.0),np.complex(-1.0,1.0),np.complex(5.0,-1.0),np.complex(0.0,0.5),np.complex(-0.0,-0.0),np.complex(2.0,-0.0),np.complex(-2.0,0.5),np.complex(-1.0,-0.0),np.complex(0.75,1.0)},np.complex128)
 local r=np.arctan(a)
 assert(r.dtype=='complex128','inv complex dtype 155')
 assert(list_same(r:tolist(),{np.complex(-0.0,0.0),np.complex(0.24497866312686414,0.0),np.complex(0.7232206661240675,0.3104282830771958),np.complex(-1.4099210495965755,-0.22907268296853875),np.complex(-1.380543138238714,-0.03710500127956832),np.complex(-1.0172219678978514,0.40235947810852507),np.complex(1.380543138238714,-0.03710500127956832),np.complex(0.0,0.5493061443340549),np.complex(-0.0,-0.0),np.complex(1.1071487177940904,-0.0),np.complex(-1.1265564408348223,0.09641562020299617),np.complex(-0.7853981633974483,-0.0),np.complex(0.9647834985327344,0.523308715953043)},1.8000000000000002e-11,true,true),'inv complex arctan 155')
end
do
 local a=np.array({np.complex(0.25,0.0),np.complex(0.75,0.5),np.complex(-1.0,-1.0),np.complex(1.0,1.0),np.complex(-1.0,0.5),np.complex(0.0,0.5),np.complex(-1.0,1.0),np.complex(2.0,0.0),np.complex(-0.0,1.0),np.complex(0.25,0.5),np.complex(5.0,-1.0),np.complex(-2.0,0.0),np.complex(0.75,0.0)},np.complex128)
 local r=np.arctan(a)
 assert(r.dtype=='complex128','inv complex dtype 156')
 assert(list_same(r:tolist(),{np.complex(0.24497866312686414,0.0),np.complex(0.7232206661240675,0.3104282830771958),np.complex(-1.0172219678978514,-0.40235947810852507),np.complex(1.0172219678978514,0.40235947810852507),np.complex(-0.847575660670829,0.23887786125685911),np.complex(0.0,0.5493061443340549),np.complex(-1.0172219678978514,0.40235947810852507),np.complex(1.1071487177940904,0.0),np.complex(-0.0,math.huge),np.complex(0.3143981432077165,0.5003700000525311),np.complex(1.380543138238714,-0.03710500127956832),np.complex(-1.1071487177940904,0.0),np.complex(0.6435011087932844,0.0)},1.8000000000000002e-11,true,true),'inv complex arctan 156')
end
do
 local a=np.array({np.complex(0.25,-3.0),np.complex(2.0,-3.0),np.complex(-1.0,0.5),np.complex(0.75,0.5),np.complex(0.25,0.0),np.complex(0.0,3.0),np.complex(-2.0,1.0),np.complex(5.0,-0.0),np.complex(0.75,-0.0),np.complex(0.25,-0.0),np.complex(-0.0,-1.0),np.complex(0.0,-0.0),np.complex(0.75,0.5)},np.complex128)
 local r=np.arctan(a)
 assert(r.dtype=='complex128','inv complex dtype 157')
 assert(list_same(r:tolist(),{np.complex(1.5398282345194945,-0.34367220374989566),np.complex(1.4099210495965755,-0.22907268296853875),np.complex(-0.847575660670829,0.23887786125685911),np.complex(0.7232206661240675,0.3104282830771958),np.complex(0.24497866312686414,0.0),np.complex(1.5707963267948966,0.34657359027997264),np.complex(-1.1780972450961724,0.17328679513998632),np.complex(1.373400766945016,-0.0),np.complex(0.6435011087932844,-0.0),np.complex(0.24497866312686414,-0.0),np.complex(-0.0,-math.huge),np.complex(0.0,-0.0),np.complex(0.7232206661240675,0.3104282830771958)},1.8000000000000002e-11,true,true),'inv complex arctan 157')
end
do
 local a=np.array({np.complex(-5.0,1.0),np.complex(-0.0,-1.0),np.complex(-2.0,0.5),np.complex(5.0,0.0),np.complex(5.0,-0.0),np.complex(-5.0,1.0),np.complex(0.25,1.0),np.complex(2.0,3.0),np.complex(0.75,3.0),np.complex(-5.0,-1.0),np.complex(0.25,3.0),np.complex(0.0,0.5),np.complex(0.75,-0.0)},np.complex128)
 local r=np.arctan(a)
 assert(r.dtype=='complex128','inv complex dtype 158')
 assert(list_same(r:tolist(),{np.complex(-1.380543138238714,0.03710500127956832),np.complex(-0.0,-math.huge),np.complex(-1.1265564408348223,0.09641562020299617),np.complex(1.373400766945016,0.0),np.complex(1.373400766945016,-0.0),np.complex(-1.380543138238714,0.03710500127956832),np.complex(0.847575660670829,1.0435968174739092),np.complex(1.4099210495965755,0.22907268296853878),np.complex(1.4840849666574578,0.32231759620945777),np.complex(-1.380543138238714,-0.03710500127956832),np.complex(1.5398282345194945,0.34367220374989566),np.complex(0.0,0.5493061443340549),np.complex(0.6435011087932844,-0.0)},1.8000000000000002e-11,true,true),'inv complex arctan 158')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(-2.0,-0.0),np.complex(-1.0,0.0),np.complex(-1.0,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(1.0,0.0),np.complex(1.0,-0.0),np.complex(2.0,0.0),np.complex(2.0,-0.0),np.complex(0.0,1.0),np.complex(0.0,-1.0),np.complex(0.0,2.0),np.complex(0.0,-2.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,math.huge),np.complex(-math.huge,-math.huge),np.complex((0/0),0.0),np.complex(0.0,(0/0)),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex128)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex128','inv complex dtype 159')
 assert(list_same(r:tolist(),{np.complex(-1.4436354751788103,0.0),np.complex(-1.4436354751788103,-0.0),np.complex(-0.8813735870195429,0.0),np.complex(-0.8813735870195429,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(0.8813735870195429,0.0),np.complex(0.8813735870195429,-0.0),np.complex(1.4436354751788103,0.0),np.complex(1.4436354751788103,-0.0),np.complex(0.0,1.5707963267948966),np.complex(0.0,-1.5707963267948966),np.complex(1.3169578969248166,1.5707963267948966),np.complex(1.3169578969248166,-1.5707963267948966),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(math.huge,1.5707963267948966),np.complex(math.huge,-1.5707963267948966),np.complex(math.huge,0.7853981633974483),np.complex(-math.huge,-0.7853981633974483),np.complex((0/0),0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},1.8000000000000002e-11,true,true),'inv complex arcsinh 159')
end
do
 local a=np.array({np.complex(0.0,-3.0),np.complex(2.0,0.5),np.complex(-0.0,0.0),np.complex(-1.0,3.0),np.complex(-5.0,3.0),np.complex(5.0,3.0),np.complex(2.0,3.0),np.complex(-2.0,-3.0),np.complex(-0.0,1.0),np.complex(0.75,1.0),np.complex(5.0,-3.0),np.complex(-1.0,0.0),np.complex(-0.0,3.0)},np.complex128)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex128','inv complex dtype 160')
 assert(list_same(r:tolist(),{np.complex(1.762747174039086,-1.5707963267948966),np.complex(1.4657153519472905,0.22101863562288385),np.complex(-0.0,0.0),np.complex(-1.8241987021938828,1.2330952175293441),np.complex(-2.4598315216234345,0.5339990695941685),np.complex(2.4598315216234345,0.5339990695941685),np.complex(1.9686379257930964,0.9646585044076028),np.complex(-1.9686379257930964,-0.9646585044076028),np.complex(-0.0,1.5707963267948966),np.complex(0.9095935920071839,0.7656426725674891),np.complex(2.4598315216234345,-0.5339990695941685),np.complex(-0.8813735870195429,0.0),np.complex(-1.762747174039086,1.5707963267948966)},1.8000000000000002e-11,true,true),'inv complex arcsinh 160')
end
do
 local a=np.array({np.complex(-5.0,0.5),np.complex(5.0,0.0),np.complex(-5.0,1.0),np.complex(1.0,0.5),np.complex(-2.0,-0.0),np.complex(0.25,1.0),np.complex(5.0,3.0),np.complex(-5.0,-1.0),np.complex(-0.0,3.0),np.complex(1.0,3.0),np.complex(-2.0,-3.0),np.complex(-2.0,-3.0),np.complex(0.0,-0.0)},np.complex128)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex128','inv complex dtype 161')
 assert(list_same(r:tolist(),{np.complex(-2.3171322930349234,0.09776337936492775),np.complex(2.3124383412727525,0.0),np.complex(-2.3309746530493123,0.1937931365549322),np.complex(0.9261330313501825,0.34943906285721327),np.complex(-1.4436354751788103,-0.0),np.complex(0.5097911466811016,1.0817519965238165),np.complex(2.4598315216234345,0.5339990695941685),np.complex(-2.3309746530493123,-0.1937931365549322),np.complex(-1.762747174039086,1.5707963267948966),np.complex(1.8241987021938828,1.2330952175293441),np.complex(-1.9686379257930964,-0.9646585044076028),np.complex(-1.9686379257930964,-0.9646585044076028),np.complex(0.0,-0.0)},1.8000000000000002e-11,true,true),'inv complex arcsinh 161')
end
do
 local a=np.array({np.complex(2.0,3.0),np.complex(5.0,-3.0),np.complex(0.0,-3.0),np.complex(-0.0,-0.0),np.complex(1.0,0.0),np.complex(-1.0,-3.0),np.complex(0.75,0.5),np.complex(-1.0,-3.0),np.complex(0.0,0.0),np.complex(5.0,0.0),np.complex(5.0,-0.0),np.complex(2.0,0.0),np.complex(0.0,-1.0)},np.complex128)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex128','inv complex dtype 162')
 assert(list_same(r:tolist(),{np.complex(1.9686379257930964,0.9646585044076028),np.complex(2.4598315216234345,-0.5339990695941685),np.complex(1.762747174039086,-1.5707963267948966),np.complex(-0.0,-0.0),np.complex(0.8813735870195429,0.0),np.complex(-1.8241987021938828,-1.2330952175293441),np.complex(0.7433204263252785,0.39827787353830835),np.complex(-1.8241987021938828,-1.2330952175293441),np.complex(0.0,0.0),np.complex(2.3124383412727525,0.0),np.complex(2.3124383412727525,-0.0),np.complex(1.4436354751788103,0.0),np.complex(0.0,-1.5707963267948966)},1.8000000000000002e-11,true,true),'inv complex arcsinh 162')
end
do
 local a=np.array({np.complex(0.75,1.0),np.complex(-0.0,0.0),np.complex(0.25,-0.0),np.complex(-1.0,0.5),np.complex(-0.0,3.0),np.complex(5.0,1.0),np.complex(-0.0,0.0),np.complex(-5.0,-3.0),np.complex(-1.0,0.5),np.complex(5.0,1.0),np.complex(5.0,-0.0),np.complex(-1.0,-1.0),np.complex(2.0,0.0)},np.complex128)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex128','inv complex dtype 163')
 assert(list_same(r:tolist(),{np.complex(0.9095935920071839,0.7656426725674891),np.complex(-0.0,0.0),np.complex(0.24746646154726346,-0.0),np.complex(-0.9261330313501825,0.34943906285721327),np.complex(-1.762747174039086,1.5707963267948966),np.complex(2.3309746530493123,0.1937931365549322),np.complex(-0.0,0.0),np.complex(-2.4598315216234345,-0.5339990695941685),np.complex(-0.9261330313501825,0.34943906285721327),np.complex(2.3309746530493123,0.1937931365549322),np.complex(2.3124383412727525,-0.0),np.complex(-1.0612750619050357,-0.6662394324925153),np.complex(1.4436354751788103,0.0)},1.8000000000000002e-11,true,true),'inv complex arcsinh 163')
end
do
 local a=np.array({np.complex(2.0,0.5),np.complex(0.75,1.0),np.complex(1.0,-1.0),np.complex(0.75,0.0),np.complex(0.0,-1.0),np.complex(2.0,-1.0),np.complex(1.0,-0.0),np.complex(-0.0,0.0),np.complex(0.25,3.0),np.complex(5.0,-1.0),np.complex(2.0,0.0),np.complex(0.25,-0.0),np.complex(-0.0,0.0)},np.complex128)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex128','inv complex dtype 164')
 assert(list_same(r:tolist(),{np.complex(1.4657153519472905,0.22101863562288385),np.complex(0.9095935920071839,0.7656426725674891),np.complex(1.0612750619050357,-0.6662394324925153),np.complex(0.6931471805599453,0.0),np.complex(0.0,-1.5707963267948966),np.complex(1.528570919480998,-0.42707858639247614),np.complex(0.8813735870195429,-0.0),np.complex(-0.0,0.0),np.complex(1.7668693026241513,1.4826795045905576),np.complex(2.3309746530493123,-0.1937931365549322),np.complex(1.4436354751788103,0.0),np.complex(0.24746646154726346,-0.0),np.complex(-0.0,0.0)},1.8000000000000002e-11,true,true),'inv complex arcsinh 164')
end
do
 local a=np.array({np.complex(1.0,-1.0),np.complex(0.0,-0.0),np.complex(-1.0,-1.0),np.complex(5.0,-0.0),np.complex(0.25,3.0),np.complex(-2.0,0.0),np.complex(1.0,1.0),np.complex(1.0,3.0),np.complex(-1.0,0.5),np.complex(-2.0,3.0),np.complex(0.25,1.0),np.complex(0.0,-0.0),np.complex(-5.0,3.0)},np.complex128)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex128','inv complex dtype 165')
 assert(list_same(r:tolist(),{np.complex(1.0612750619050357,-0.6662394324925153),np.complex(0.0,-0.0),np.complex(-1.0612750619050357,-0.6662394324925153),np.complex(2.3124383412727525,-0.0),np.complex(1.7668693026241513,1.4826795045905576),np.complex(-1.4436354751788103,0.0),np.complex(1.0612750619050357,0.6662394324925153),np.complex(1.8241987021938828,1.2330952175293441),np.complex(-0.9261330313501825,0.34943906285721327),np.complex(-1.9686379257930964,0.9646585044076028),np.complex(0.5097911466811016,1.0817519965238165),np.complex(0.0,-0.0),np.complex(-2.4598315216234345,0.5339990695941685)},1.8000000000000002e-11,true,true),'inv complex arcsinh 165')
end
do
 local a=np.array({np.complex(-0.0,0.0),np.complex(1.0,3.0),np.complex(-1.0,0.5),np.complex(1.0,0.0),np.complex(0.25,0.5),np.complex(-1.0,-3.0),np.complex(0.25,-1.0),np.complex(1.0,1.0),np.complex(1.0,0.0),np.complex(5.0,0.0),np.complex(1.0,-3.0),np.complex(0.25,-1.0),np.complex(-1.0,0.5)},np.complex128)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex128','inv complex dtype 166')
 assert(list_same(r:tolist(),{np.complex(-0.0,0.0),np.complex(1.8241987021938828,1.2330952175293441),np.complex(-0.9261330313501825,0.34943906285721327),np.complex(0.8813735870195429,0.0),np.complex(0.28139605624529274,0.5016088532755008),np.complex(-1.8241987021938828,-1.2330952175293441),np.complex(0.5097911466811016,-1.0817519965238165),np.complex(1.0612750619050357,0.6662394324925153),np.complex(0.8813735870195429,0.0),np.complex(2.3124383412727525,0.0),np.complex(1.8241987021938828,-1.2330952175293441),np.complex(0.5097911466811016,-1.0817519965238165),np.complex(-0.9261330313501825,0.34943906285721327)},1.8000000000000002e-11,true,true),'inv complex arcsinh 166')
end
do
 local a=np.array({np.complex(-0.0,-1.0),np.complex(2.0,-1.0),np.complex(-5.0,-3.0),np.complex(0.75,0.0),np.complex(0.0,1.0),np.complex(-0.0,1.0),np.complex(-2.0,-0.0),np.complex(-1.0,1.0),np.complex(5.0,3.0),np.complex(-2.0,1.0),np.complex(1.0,0.5),np.complex(0.75,-0.0),np.complex(-0.0,0.5)},np.complex128)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex128','inv complex dtype 167')
 assert(list_same(r:tolist(),{np.complex(-0.0,-1.5707963267948966),np.complex(1.528570919480998,-0.42707858639247614),np.complex(-2.4598315216234345,-0.5339990695941685),np.complex(0.6931471805599453,0.0),np.complex(0.0,1.5707963267948966),np.complex(-0.0,1.5707963267948966),np.complex(-1.4436354751788103,-0.0),np.complex(-1.0612750619050357,0.6662394324925153),np.complex(2.4598315216234345,0.5339990695941685),np.complex(-1.528570919480998,0.42707858639247614),np.complex(0.9261330313501825,0.34943906285721327),np.complex(0.6931471805599453,-0.0),np.complex(-0.0,0.5235987755982989)},1.8000000000000002e-11,true,true),'inv complex arcsinh 167')
end
do
 local a=np.array({np.complex(-5.0,3.0),np.complex(2.0,3.0),np.complex(0.25,0.5),np.complex(-5.0,-0.0),np.complex(2.0,0.0),np.complex(0.25,-0.0),np.complex(0.25,1.0),np.complex(0.25,-3.0),np.complex(5.0,-3.0),np.complex(-5.0,-0.0),np.complex(-5.0,3.0),np.complex(-5.0,-1.0),np.complex(0.25,-3.0)},np.complex128)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex128','inv complex dtype 168')
 assert(list_same(r:tolist(),{np.complex(-2.4598315216234345,0.5339990695941685),np.complex(1.9686379257930964,0.9646585044076028),np.complex(0.28139605624529274,0.5016088532755008),np.complex(-2.3124383412727525,-0.0),np.complex(1.4436354751788103,0.0),np.complex(0.24746646154726346,-0.0),np.complex(0.5097911466811016,1.0817519965238165),np.complex(1.7668693026241513,-1.4826795045905576),np.complex(2.4598315216234345,-0.5339990695941685),np.complex(-2.3124383412727525,-0.0),np.complex(-2.4598315216234345,0.5339990695941685),np.complex(-2.3309746530493123,-0.1937931365549322),np.complex(1.7668693026241513,-1.4826795045905576)},1.8000000000000002e-11,true,true),'inv complex arcsinh 168')
end
do
 local a=np.array({np.complex(1.0,0.0),np.complex(2.0,1.0),np.complex(0.0,-0.0),np.complex(-1.0,0.0),np.complex(0.25,3.0),np.complex(-1.0,-3.0),np.complex(0.25,-1.0),np.complex(0.25,3.0),np.complex(-1.0,-1.0),np.complex(-5.0,-3.0),np.complex(5.0,0.0),np.complex(0.75,-1.0),np.complex(-1.0,0.0)},np.complex128)
 local r=np.arcsinh(a)
 assert(r.dtype=='complex128','inv complex dtype 169')
 assert(list_same(r:tolist(),{np.complex(0.8813735870195429,0.0),np.complex(1.528570919480998,0.42707858639247614),np.complex(0.0,-0.0),np.complex(-0.8813735870195429,0.0),np.complex(1.7668693026241513,1.4826795045905576),np.complex(-1.8241987021938828,-1.2330952175293441),np.complex(0.5097911466811016,-1.0817519965238165),np.complex(1.7668693026241513,1.4826795045905576),np.complex(-1.0612750619050357,-0.6662394324925153),np.complex(-2.4598315216234345,-0.5339990695941685),np.complex(2.3124383412727525,0.0),np.complex(0.9095935920071839,-0.7656426725674891),np.complex(-0.8813735870195429,0.0)},1.8000000000000002e-11,true,true),'inv complex arcsinh 169')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(-2.0,-0.0),np.complex(-1.0,0.0),np.complex(-1.0,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(1.0,0.0),np.complex(1.0,-0.0),np.complex(2.0,0.0),np.complex(2.0,-0.0),np.complex(0.0,1.0),np.complex(0.0,-1.0),np.complex(0.0,2.0),np.complex(0.0,-2.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,math.huge),np.complex(-math.huge,-math.huge),np.complex((0/0),0.0),np.complex(0.0,(0/0)),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex128)
 local r=np.arccosh(a)
 assert(r.dtype=='complex128','inv complex dtype 170')
 assert(list_same(r:tolist(),{np.complex(1.3169578969248166,3.141592653589793),np.complex(1.3169578969248166,-3.141592653589793),np.complex(0.0,3.141592653589793),np.complex(0.0,-3.141592653589793),np.complex(0.0,1.5707963267948966),np.complex(0.0,-1.5707963267948966),np.complex(0.0,1.5707963267948966),np.complex(0.0,-1.5707963267948966),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(1.3169578969248166,0.0),np.complex(1.3169578969248166,-0.0),np.complex(0.8813735870195429,1.5707963267948966),np.complex(0.8813735870195429,-1.5707963267948966),np.complex(1.4436354751788103,1.5707963267948966),np.complex(1.4436354751788103,-1.5707963267948966),np.complex(math.huge,0.0),np.complex(math.huge,3.141592653589793),np.complex(math.huge,1.5707963267948966),np.complex(math.huge,-1.5707963267948966),np.complex(math.huge,0.7853981633974483),np.complex(math.huge,-2.356194490192345),np.complex((0/0),(0/0)),np.complex((0/0),1.5707963267948966),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},1.8000000000000002e-11,true,true),'inv complex arccosh 170')
end
do
 local a=np.array({np.complex(1.0,3.0),np.complex(-0.0,0.0),np.complex(0.25,-1.0),np.complex(-5.0,-3.0),np.complex(-5.0,-3.0),np.complex(-5.0,-3.0),np.complex(0.0,0.5),np.complex(-2.0,-3.0),np.complex(0.0,0.5),np.complex(0.0,0.5),np.complex(2.0,-3.0),np.complex(-2.0,1.0),np.complex(-0.0,3.0)},np.complex128)
 local r=np.arccosh(a)
 assert(r.dtype=='complex128','inv complex dtype 171')
 assert(list_same(r:tolist(),{np.complex(1.8641615441578825,1.2631926772641855),np.complex(0.0,1.5707963267948966),np.complex(0.8924633639033482,-1.3944938940179297),np.complex(2.452913742502812,-2.5946180733066795),np.complex(2.452913742502812,-2.5946180733066795),np.complex(2.452913742502812,-2.5946180733066795),np.complex(0.48121182505960347,1.5707963267948966),np.complex(1.9833870299165355,-2.141449111115996),np.complex(0.48121182505960347,1.5707963267948966),np.complex(0.48121182505960347,1.5707963267948966),np.complex(1.9833870299165355,-1.0001435424737972),np.complex(1.4693517443681852,2.6342363503726487),np.complex(1.8184464592320668,1.5707963267948966)},1.8000000000000002e-11,true,true),'inv complex arccosh 171')
end
do
 local a=np.array({np.complex(0.25,0.0),np.complex(-2.0,-3.0),np.complex(-0.0,-0.0),np.complex(2.0,-3.0),np.complex(-0.0,3.0),np.complex(5.0,-0.0),np.complex(-2.0,3.0),np.complex(1.0,0.5),np.complex(-2.0,-3.0),np.complex(0.0,0.5),np.complex(-5.0,0.0),np.complex(2.0,-3.0),np.complex(1.0,-0.0)},np.complex128)
 local r=np.arccosh(a)
 assert(r.dtype=='complex128','inv complex dtype 172')
 assert(list_same(r:tolist(),{np.complex(0.0,1.318116071652818),np.complex(1.9833870299165355,-2.141449111115996),np.complex(0.0,-1.5707963267948966),np.complex(1.9833870299165355,-1.0001435424737972),np.complex(1.8184464592320668,1.5707963267948966),np.complex(2.2924316695611777,-0.0),np.complex(1.9833870299165355,2.141449111115996),np.complex(0.7328576759736453,0.6748888455860064),np.complex(1.9833870299165355,-2.141449111115996),np.complex(0.48121182505960347,1.5707963267948966),np.complex(2.2924316695611777,3.141592653589793),np.complex(1.9833870299165355,-1.0001435424737972),np.complex(0.0,-0.0)},1.8000000000000002e-11,true,true),'inv complex arccosh 172')
end
do
 local a=np.array({np.complex(2.0,-3.0),np.complex(1.0,1.0),np.complex(-0.0,-0.0),np.complex(5.0,1.0),np.complex(5.0,1.0),np.complex(0.75,-3.0),np.complex(2.0,-1.0),np.complex(1.0,-3.0),np.complex(-0.0,-3.0),np.complex(5.0,-1.0),np.complex(-2.0,1.0),np.complex(-1.0,0.5),np.complex(5.0,0.5)},np.complex128)
 local r=np.arccosh(a)
 assert(r.dtype=='complex128','inv complex dtype 173')
 assert(list_same(r:tolist(),{np.complex(1.9833870299165355,-1.0001435424737972),np.complex(1.0612750619050357,0.9045568943023813),np.complex(0.0,-1.5707963267948966),np.complex(2.3132209417695293,0.20119507970091022),np.complex(2.3132209417695293,0.20119507970091022),np.complex(1.8445760096309898,-1.3373248777692883),np.complex(1.4693517443681852,-0.5073563032171445),np.complex(1.8641615441578825,-1.2631926772641855),np.complex(1.8184464592320668,-1.5707963267948966),np.complex(2.3132209417695293,-0.20119507970091022),np.complex(1.4693517443681852,2.6342363503726487),np.complex(0.7328576759736453,2.466703808003787),np.complex(2.2977170809810494,0.10168821054536263)},1.8000000000000002e-11,true,true),'inv complex arccosh 173')
end
do
 local a=np.array({np.complex(0.25,-0.0),np.complex(0.25,-0.0),np.complex(0.75,0.0),np.complex(-5.0,-1.0),np.complex(0.0,3.0),np.complex(2.0,1.0),np.complex(-5.0,1.0),np.complex(-1.0,0.0),np.complex(0.0,0.0),np.complex(2.0,-1.0),np.complex(0.25,-3.0),np.complex(-2.0,-0.0),np.complex(0.25,1.0)},np.complex128)
 local r=np.arccosh(a)
 assert(r.dtype=='complex128','inv complex dtype 174')
 assert(list_same(r:tolist(),{np.complex(0.0,-1.318116071652818),np.complex(0.0,-1.318116071652818),np.complex(0.0,0.7227342478134157),np.complex(2.3132209417695293,-2.940397573888883),np.complex(1.8184464592320668,1.5707963267948966),np.complex(1.4693517443681852,0.5073563032171445),np.complex(2.3132209417695293,2.940397573888883),np.complex(0.0,3.141592653589793),np.complex(0.0,1.5707963267948966),np.complex(1.4693517443681852,-0.5073563032171445),np.complex(1.8214041607957312,-1.4918790465961933),np.complex(1.3169578969248166,-3.141592653589793),np.complex(0.8924633639033482,1.3944938940179297)},1.8000000000000002e-11,true,true),'inv complex arccosh 174')
end
do
 local a=np.array({np.complex(0.75,-3.0),np.complex(-2.0,-3.0),np.complex(5.0,0.0),np.complex(1.0,3.0),np.complex(0.0,-3.0),np.complex(-2.0,0.5),np.complex(5.0,0.5),np.complex(-1.0,-1.0),np.complex(5.0,0.0),np.complex(-1.0,0.5),np.complex(0.0,3.0),np.complex(0.0,0.5),np.complex(0.75,-3.0)},np.complex128)
 local r=np.arccosh(a)
 assert(r.dtype=='complex128','inv complex dtype 175')
 assert(list_same(r:tolist(),{np.complex(1.8445760096309898,-1.3373248777692883),np.complex(1.9833870299165355,-2.141449111115996),np.complex(2.2924316695611777,0.0),np.complex(1.8641615441578825,1.2631926772641855),np.complex(1.8184464592320668,-1.5707963267948966),np.complex(1.3618009008578458,2.863838397032079),np.complex(2.2977170809810494,0.10168821054536263),np.complex(1.0612750619050357,-2.2370357592874117),np.complex(2.2924316695611777,0.0),np.complex(0.7328576759736453,2.466703808003787),np.complex(1.8184464592320668,1.5707963267948966),np.complex(0.48121182505960347,1.5707963267948966),np.complex(1.8445760096309898,-1.3373248777692883)},1.8000000000000002e-11,true,true),'inv complex arccosh 175')
end
do
 local a=np.array({np.complex(-2.0,3.0),np.complex(5.0,-0.0),np.complex(0.0,-1.0),np.complex(5.0,-0.0),np.complex(-5.0,1.0),np.complex(-1.0,3.0),np.complex(1.0,-0.0),np.complex(5.0,-1.0),np.complex(0.0,-3.0),np.complex(0.75,1.0),np.complex(-5.0,0.5),np.complex(0.0,-0.0),np.complex(-1.0,-3.0)},np.complex128)
 local r=np.arccosh(a)
 assert(r.dtype=='complex128','inv complex dtype 176')
 assert(list_same(r:tolist(),{np.complex(1.9833870299165355,2.141449111115996),np.complex(2.2924316695611777,-0.0),np.complex(0.8813735870195429,-1.5707963267948966),np.complex(2.2924316695611777,-0.0),np.complex(2.3132209417695293,2.940397573888883),np.complex(1.8641615441578825,1.8783999763256078),np.complex(0.0,-0.0),np.complex(2.3132209417695293,-0.20119507970091022),np.complex(1.8184464592320668,-1.5707963267948966),np.complex(0.9828661390291652,1.0559581427559381),np.complex(2.2977170809810494,3.0399044430444304),np.complex(0.0,-1.5707963267948966),np.complex(1.8641615441578825,-1.8783999763256078)},1.8000000000000002e-11,true,true),'inv complex arccosh 176')
end
do
 local a=np.array({np.complex(0.25,-1.0),np.complex(0.25,3.0),np.complex(-2.0,-1.0),np.complex(2.0,-1.0),np.complex(0.0,0.5),np.complex(-0.0,3.0),np.complex(2.0,-3.0),np.complex(5.0,-1.0),np.complex(0.0,3.0),np.complex(-5.0,0.5),np.complex(2.0,-0.0),np.complex(-2.0,-3.0),np.complex(1.0,1.0)},np.complex128)
 local r=np.arccosh(a)
 assert(r.dtype=='complex128','inv complex dtype 177')
 assert(list_same(r:tolist(),{np.complex(0.8924633639033482,-1.3944938940179297),np.complex(1.8214041607957312,1.4918790465961933),np.complex(1.4693517443681852,-2.6342363503726487),np.complex(1.4693517443681852,-0.5073563032171445),np.complex(0.48121182505960347,1.5707963267948966),np.complex(1.8184464592320668,1.5707963267948966),np.complex(1.9833870299165355,-1.0001435424737972),np.complex(2.3132209417695293,-0.20119507970091022),np.complex(1.8184464592320668,1.5707963267948966),np.complex(2.2977170809810494,3.0399044430444304),np.complex(1.3169578969248166,-0.0),np.complex(1.9833870299165355,-2.141449111115996),np.complex(1.0612750619050357,0.9045568943023813)},1.8000000000000002e-11,true,true),'inv complex arccosh 177')
end
do
 local a=np.array({np.complex(5.0,0.0),np.complex(0.75,3.0),np.complex(0.25,0.0),np.complex(1.0,-3.0),np.complex(5.0,3.0),np.complex(-5.0,3.0),np.complex(1.0,-1.0),np.complex(0.25,-0.0),np.complex(0.75,-0.0),np.complex(2.0,-0.0),np.complex(5.0,0.5),np.complex(1.0,3.0),np.complex(0.0,-3.0)},np.complex128)
 local r=np.arccosh(a)
 assert(r.dtype=='complex128','inv complex dtype 178')
 assert(list_same(r:tolist(),{np.complex(2.2924316695611777,0.0),np.complex(1.8445760096309898,1.3373248777692883),np.complex(0.0,1.318116071652818),np.complex(1.8641615441578825,-1.2631926772641855),np.complex(2.452913742502812,0.5469745802831137),np.complex(2.452913742502812,2.5946180733066795),np.complex(1.0612750619050357,-0.9045568943023813),np.complex(0.0,-1.318116071652818),np.complex(0.0,-0.7227342478134157),np.complex(1.3169578969248166,-0.0),np.complex(2.2977170809810494,0.10168821054536263),np.complex(1.8641615441578825,1.2631926772641855),np.complex(1.8184464592320668,-1.5707963267948966)},1.8000000000000002e-11,true,true),'inv complex arccosh 178')
end
do
 local a=np.array({np.complex(0.0,3.0),np.complex(-2.0,0.5),np.complex(-0.0,1.0),np.complex(1.0,1.0),np.complex(1.0,3.0),np.complex(0.25,0.5),np.complex(2.0,0.0),np.complex(0.25,-3.0),np.complex(-1.0,1.0),np.complex(-2.0,-3.0),np.complex(-1.0,-1.0),np.complex(0.75,0.0),np.complex(5.0,3.0)},np.complex128)
 local r=np.arccosh(a)
 assert(r.dtype=='complex128','inv complex dtype 179')
 assert(list_same(r:tolist(),{np.complex(1.8184464592320668,1.5707963267948966),np.complex(1.3618009008578458,2.863838397032079),np.complex(0.8813735870195429,1.5707963267948966),np.complex(1.0612750619050357,0.9045568943023813),np.complex(1.8641615441578825,1.2631926772641855),np.complex(0.4926756834207706,1.3464678741602292),np.complex(1.3169578969248166,0.0),np.complex(1.8214041607957312,-1.4918790465961933),np.complex(1.0612750619050357,2.2370357592874117),np.complex(1.9833870299165355,-2.141449111115996),np.complex(1.0612750619050357,-2.2370357592874117),np.complex(0.0,0.7227342478134157),np.complex(2.452913742502812,0.5469745802831137)},1.8000000000000002e-11,true,true),'inv complex arccosh 179')
end
do
 local a=np.array({np.complex(-5.0,-0.0),np.complex(-5.0,-0.0),np.complex(-2.0,1.0),np.complex(-5.0,-3.0),np.complex(0.75,3.0),np.complex(-2.0,0.5),np.complex(0.75,0.0),np.complex(-0.0,-1.0),np.complex(-5.0,-3.0),np.complex(-1.0,0.5),np.complex(-2.0,-3.0),np.complex(1.0,-0.0),np.complex(1.0,-3.0)},np.complex128)
 local r=np.arccosh(a)
 assert(r.dtype=='complex128','inv complex dtype 180')
 assert(list_same(r:tolist(),{np.complex(2.2924316695611777,-3.141592653589793),np.complex(2.2924316695611777,-3.141592653589793),np.complex(1.4693517443681852,2.6342363503726487),np.complex(2.452913742502812,-2.5946180733066795),np.complex(1.8445760096309898,1.3373248777692883),np.complex(1.3618009008578458,2.863838397032079),np.complex(0.0,0.7227342478134157),np.complex(0.8813735870195429,-1.5707963267948966),np.complex(2.452913742502812,-2.5946180733066795),np.complex(0.7328576759736453,2.466703808003787),np.complex(1.9833870299165355,-2.141449111115996),np.complex(0.0,-0.0),np.complex(1.8641615441578825,-1.2631926772641855)},1.8000000000000002e-11,true,true),'inv complex arccosh 180')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(-2.0,-0.0),np.complex(-1.0,0.0),np.complex(-1.0,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(1.0,0.0),np.complex(1.0,-0.0),np.complex(2.0,0.0),np.complex(2.0,-0.0),np.complex(0.0,1.0),np.complex(0.0,-1.0),np.complex(0.0,2.0),np.complex(0.0,-2.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex(0.0,-math.huge),np.complex(math.huge,math.huge),np.complex(-math.huge,-math.huge),np.complex((0/0),0.0),np.complex(0.0,(0/0)),np.complex((0/0),2.0),np.complex(2.0,(0/0)),np.complex((0/0),(0/0))},np.complex128)
 local r=np.arctanh(a)
 assert(r.dtype=='complex128','inv complex dtype 181')
 assert(list_same(r:tolist(),{np.complex(-0.5493061443340549,1.5707963267948966),np.complex(-0.5493061443340549,-1.5707963267948966),np.complex(-math.huge,0.0),np.complex(-math.huge,-0.0),np.complex(-0.0,0.0),np.complex(-0.0,-0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(math.huge,-0.0),np.complex(0.5493061443340549,1.5707963267948966),np.complex(0.5493061443340549,-1.5707963267948966),np.complex(0.0,0.7853981633974483),np.complex(0.0,-0.7853981633974483),np.complex(0.0,1.1071487177940904),np.complex(0.0,-1.1071487177940904),np.complex(0.0,1.5707963267948966),np.complex(-0.0,1.5707963267948966),np.complex(0.0,1.5707963267948966),np.complex(0.0,-1.5707963267948966),np.complex(0.0,1.5707963267948966),np.complex(-0.0,-1.5707963267948966),np.complex((0/0),(0/0)),np.complex(0.0,(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},1.8000000000000002e-11,true,true),'inv complex arctanh 181')
end
do
 local a=np.array({np.complex(-1.0,3.0),np.complex(5.0,-1.0),np.complex(2.0,3.0),np.complex(-0.0,3.0),np.complex(5.0,0.5),np.complex(0.75,-1.0),np.complex(-0.0,1.0),np.complex(-5.0,-1.0),np.complex(0.25,-0.0),np.complex(0.75,0.5),np.complex(-5.0,0.5),np.complex(1.0,-1.0),np.complex(5.0,-0.0)},np.complex128)
 local r=np.arctanh(a)
 assert(r.dtype=='complex128','inv complex dtype 182')
 assert(list_same(r:tolist(),{np.complex(-0.09193119503132935,1.2767950250211129),np.complex(0.1944261421470021,-1.530881333938778),np.complex(0.14694666622552977,1.3389725222944935),np.complex(-0.0,1.2490457723982544),np.complex(0.20058661813123432,1.5501894454657366),np.complex(0.33529348145985527,-0.9224818889572777),np.complex(-0.0,0.7853981633974483),np.complex(-0.19442614214700207,-1.530881333938778),np.complex(0.25541281188299536,-0.0),np.complex(0.5902135002795054,0.6927241883996009),np.complex(-0.20058661813123432,1.5501894454657366),np.complex(0.40235947810852507,-1.0172219678978514),np.complex(0.2027325540540822,-1.5707963267948966)},1.8000000000000002e-11,true,true),'inv complex arctanh 182')
end
do
 local a=np.array({np.complex(-2.0,-0.0),np.complex(-2.0,0.0),np.complex(-2.0,-1.0),np.complex(0.0,-3.0),np.complex(-0.0,0.0),np.complex(0.75,3.0),np.complex(-0.0,0.5),np.complex(1.0,3.0),np.complex(0.0,0.0),np.complex(0.25,1.0),np.complex(-5.0,-3.0),np.complex(2.0,-3.0),np.complex(-0.0,0.5)},np.complex128)
 local r=np.arctanh(a)
 assert(r.dtype=='complex128','inv complex dtype 183')
 assert(list_same(r:tolist(),{np.complex(-0.5493061443340549,-1.5707963267948966),np.complex(-0.5493061443340549,1.5707963267948966),np.complex(-0.40235947810852507,-1.3389725222944935),np.complex(0.0,-1.2490457723982544),np.complex(-0.0,0.0),np.complex(0.0714891116210778,1.2651884866374963),np.complex(-0.0,0.4636476090008061),np.complex(0.09193119503132934,1.2767950250211129),np.complex(0.0,0.0),np.complex(0.12367406045902676,0.8010180801125825),np.complex(-0.14694666622552974,-1.4808695768986575),np.complex(0.14694666622552977,-1.3389725222944935),np.complex(-0.0,0.4636476090008061)},1.8000000000000002e-11,true,true),'inv complex arctanh 183')
end
do
 local a=np.array({np.complex(1.0,0.5),np.complex(2.0,-3.0),np.complex(0.75,-3.0),np.complex(-2.0,-3.0),np.complex(0.0,1.0),np.complex(-5.0,3.0),np.complex(-2.0,-0.0),np.complex(0.75,1.0),np.complex(-5.0,-1.0),np.complex(1.0,-3.0),np.complex(5.0,1.0),np.complex(0.75,-3.0),np.complex(-1.0,3.0)},np.complex128)
 local r=np.arctanh(a)
 assert(r.dtype=='complex128','inv complex dtype 184')
 assert(list_same(r:tolist(),{np.complex(0.708303336014054,0.9078874949608804),np.complex(0.14694666622552977,-1.3389725222944935),np.complex(0.0714891116210778,-1.2651884866374963),np.complex(-0.14694666622552974,-1.3389725222944935),np.complex(0.0,0.7853981633974483),np.complex(-0.14694666622552974,1.4808695768986575),np.complex(-0.5493061443340549,-1.5707963267948966),np.complex(0.33529348145985527,0.9224818889572777),np.complex(-0.19442614214700207,-1.530881333938778),np.complex(0.09193119503132934,-1.2767950250211129),np.complex(0.1944261421470021,1.530881333938778),np.complex(0.0714891116210778,-1.2651884866374963),np.complex(-0.09193119503132935,1.2767950250211129)},1.8000000000000002e-11,true,true),'inv complex arctanh 184')
end
do
 local a=np.array({np.complex(-1.0,-3.0),np.complex(-2.0,-0.0),np.complex(-5.0,-0.0),np.complex(0.25,-0.0),np.complex(0.25,0.5),np.complex(2.0,0.5),np.complex(-0.0,1.0),np.complex(-1.0,-3.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(-1.0,0.0),np.complex(0.75,0.5),np.complex(1.0,1.0)},np.complex128)
 local r=np.arctanh(a)
 assert(r.dtype=='complex128','inv complex dtype 185')
 assert(list_same(r:tolist(),{np.complex(-0.09193119503132935,-1.2767950250211129),np.complex(-0.5493061443340549,-1.5707963267948966),np.complex(-0.2027325540540822,-1.5707963267948966),np.complex(0.25541281188299536,-0.0),np.complex(0.20058661813123432,0.4842544903299662),np.complex(0.5003700000525311,1.421546861001807),np.complex(-0.0,0.7853981633974483),np.complex(-0.09193119503132935,-1.2767950250211129),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(-math.huge,0.0),np.complex(0.5902135002795054,0.6927241883996009),np.complex(0.40235947810852507,1.0172219678978514)},1.8000000000000002e-11,true,true),'inv complex arctanh 185')
end
do
 local a=np.array({np.complex(2.0,-3.0),np.complex(0.75,3.0),np.complex(5.0,-3.0),np.complex(1.0,3.0),np.complex(-5.0,-3.0),np.complex(2.0,-1.0),np.complex(0.0,0.5),np.complex(0.25,0.0),np.complex(-0.0,-3.0),np.complex(-2.0,-1.0),np.complex(-5.0,3.0),np.complex(-2.0,-1.0),np.complex(1.0,3.0)},np.complex128)
 local r=np.arctanh(a)
 assert(r.dtype=='complex128','inv complex dtype 186')
 assert(list_same(r:tolist(),{np.complex(0.14694666622552977,-1.3389725222944935),np.complex(0.0714891116210778,1.2651884866374963),np.complex(0.14694666622552977,-1.4808695768986575),np.complex(0.09193119503132934,1.2767950250211129),np.complex(-0.14694666622552974,-1.4808695768986575),np.complex(0.40235947810852507,-1.3389725222944935),np.complex(0.0,0.4636476090008061),np.complex(0.25541281188299536,0.0),np.complex(-0.0,-1.2490457723982544),np.complex(-0.40235947810852507,-1.3389725222944935),np.complex(-0.14694666622552974,1.4808695768986575),np.complex(-0.40235947810852507,-1.3389725222944935),np.complex(0.09193119503132934,1.2767950250211129)},1.8000000000000002e-11,true,true),'inv complex arctanh 186')
end
do
 local a=np.array({np.complex(-0.0,-0.0),np.complex(5.0,-0.0),np.complex(0.0,0.0),np.complex(5.0,-0.0),np.complex(5.0,0.5),np.complex(0.0,0.5),np.complex(-0.0,-0.0),np.complex(5.0,0.5),np.complex(0.25,-0.0),np.complex(-5.0,3.0),np.complex(-1.0,-1.0),np.complex(0.75,-1.0),np.complex(-5.0,0.0)},np.complex128)
 local r=np.arctanh(a)
 assert(r.dtype=='complex128','inv complex dtype 187')
 assert(list_same(r:tolist(),{np.complex(-0.0,-0.0),np.complex(0.2027325540540822,-1.5707963267948966),np.complex(0.0,0.0),np.complex(0.2027325540540822,-1.5707963267948966),np.complex(0.20058661813123432,1.5501894454657366),np.complex(0.0,0.4636476090008061),np.complex(-0.0,-0.0),np.complex(0.20058661813123432,1.5501894454657366),np.complex(0.25541281188299536,-0.0),np.complex(-0.14694666622552974,1.4808695768986575),np.complex(-0.40235947810852507,-1.0172219678978514),np.complex(0.33529348145985527,-0.9224818889572777),np.complex(-0.2027325540540822,1.5707963267948966)},1.8000000000000002e-11,true,true),'inv complex arctanh 187')
end
do
 local a=np.array({np.complex(1.0,-1.0),np.complex(1.0,-0.0),np.complex(-2.0,1.0),np.complex(5.0,3.0),np.complex(0.25,1.0),np.complex(1.0,0.0),np.complex(-0.0,0.0),np.complex(2.0,-0.0),np.complex(-1.0,-3.0),np.complex(0.0,0.0),np.complex(-5.0,-3.0),np.complex(2.0,-1.0),np.complex(-2.0,1.0)},np.complex128)
 local r=np.arctanh(a)
 assert(r.dtype=='complex128','inv complex dtype 188')
 assert(list_same(r:tolist(),{np.complex(0.40235947810852507,-1.0172219678978514),np.complex(math.huge,-0.0),np.complex(-0.40235947810852507,1.3389725222944935),np.complex(0.14694666622552977,1.4808695768986575),np.complex(0.12367406045902676,0.8010180801125825),np.complex(math.huge,0.0),np.complex(-0.0,0.0),np.complex(0.5493061443340549,-1.5707963267948966),np.complex(-0.09193119503132935,-1.2767950250211129),np.complex(0.0,0.0),np.complex(-0.14694666622552974,-1.4808695768986575),np.complex(0.40235947810852507,-1.3389725222944935),np.complex(-0.40235947810852507,1.3389725222944935)},1.8000000000000002e-11,true,true),'inv complex arctanh 188')
end
do
 local a=np.array({np.complex(-0.0,3.0),np.complex(0.75,-1.0),np.complex(0.25,0.5),np.complex(1.0,0.0),np.complex(0.75,0.0),np.complex(-1.0,-3.0),np.complex(-1.0,-0.0),np.complex(2.0,1.0),np.complex(-1.0,3.0),np.complex(0.75,3.0),np.complex(0.0,-3.0),np.complex(0.0,-3.0),np.complex(5.0,-1.0)},np.complex128)
 local r=np.arctanh(a)
 assert(r.dtype=='complex128','inv complex dtype 189')
 assert(list_same(r:tolist(),{np.complex(-0.0,1.2490457723982544),np.complex(0.33529348145985527,-0.9224818889572777),np.complex(0.20058661813123432,0.4842544903299662),np.complex(math.huge,0.0),np.complex(0.9729550745276566,0.0),np.complex(-0.09193119503132935,-1.2767950250211129),np.complex(-math.huge,-0.0),np.complex(0.40235947810852507,1.3389725222944935),np.complex(-0.09193119503132935,1.2767950250211129),np.complex(0.0714891116210778,1.2651884866374963),np.complex(0.0,-1.2490457723982544),np.complex(0.0,-1.2490457723982544),np.complex(0.1944261421470021,-1.530881333938778)},1.8000000000000002e-11,true,true),'inv complex arctanh 189')
end
do
 local a=np.array({np.complex(-2.0,-0.0),np.complex(0.0,1.0),np.complex(0.75,0.5),np.complex(1.0,0.5),np.complex(-5.0,-0.0),np.complex(-2.0,-1.0),np.complex(-0.0,-1.0),np.complex(-5.0,3.0),np.complex(-2.0,1.0),np.complex(-0.0,-3.0),np.complex(0.75,-0.0),np.complex(5.0,-0.0),np.complex(0.0,0.0)},np.complex128)
 local r=np.arctanh(a)
 assert(r.dtype=='complex128','inv complex dtype 190')
 assert(list_same(r:tolist(),{np.complex(-0.5493061443340549,-1.5707963267948966),np.complex(0.0,0.7853981633974483),np.complex(0.5902135002795054,0.6927241883996009),np.complex(0.708303336014054,0.9078874949608804),np.complex(-0.2027325540540822,-1.5707963267948966),np.complex(-0.40235947810852507,-1.3389725222944935),np.complex(-0.0,-0.7853981633974483),np.complex(-0.14694666622552974,1.4808695768986575),np.complex(-0.40235947810852507,1.3389725222944935),np.complex(-0.0,-1.2490457723982544),np.complex(0.9729550745276566,-0.0),np.complex(0.2027325540540822,-1.5707963267948966),np.complex(0.0,0.0)},1.8000000000000002e-11,true,true),'inv complex arctanh 190')
end
do
 local a=np.array({np.complex(-5.0,-3.0),np.complex(0.25,-3.0),np.complex(-1.0,3.0),np.complex(-2.0,1.0),np.complex(5.0,0.0),np.complex(0.75,-0.0),np.complex(-1.0,0.5),np.complex(0.0,0.0),np.complex(-2.0,1.0),np.complex(5.0,3.0),np.complex(0.0,-3.0),np.complex(5.0,0.0),np.complex(1.0,-0.0)},np.complex128)
 local r=np.arctanh(a)
 assert(r.dtype=='complex128','inv complex dtype 191')
 assert(list_same(r:tolist(),{np.complex(-0.14694666622552974,-1.4808695768986575),np.complex(0.024865198382659503,-1.2509114353815838),np.complex(-0.09193119503132935,1.2767950250211129),np.complex(-0.40235947810852507,1.3389725222944935),np.complex(0.2027325540540822,1.5707963267948966),np.complex(0.9729550745276566,-0.0),np.complex(-0.708303336014054,0.9078874949608804),np.complex(0.0,0.0),np.complex(-0.40235947810852507,1.3389725222944935),np.complex(0.14694666622552977,1.4808695768986575),np.complex(0.0,-1.2490457723982544),np.complex(0.2027325540540822,1.5707963267948966),np.complex(math.huge,-0.0)},1.8000000000000002e-11,true,true),'inv complex arctanh 191')
end
do
 local a=np.array({0.25},np.float64)
 assert(fsame(np.asin(a)[1],np.arcsin(a)[1],1e-15,true))
 assert(fsame(np.acos(a)[1],np.arccos(a)[1],1e-15,true))
 assert(fsame(np.atan(a)[1],np.arctan(a)[1],1e-15,true))
 assert(fsame(np.asinh(a)[1],np.arcsinh(a)[1],1e-15,true))
 assert(fsame(np.acosh(np.array({2.0},np.float64))[1],np.arccosh(np.array({2.0},np.float64))[1],1e-15,true))
 assert(fsame(np.atanh(a)[1],np.arctanh(a)[1],1e-15,true))
end
do
 local a=np.array({0.0,1.0},np.bool)
 local b=np.array({1.0,0.0},np.bool)
 local r=np.arctan2(a,b)
 assert(r.dtype=='float16','binary inv dtype 193')
 assert(list_same(r:tolist(),{0.0,1.5703125},0.004,false,true),'binary inv arctan2 193')
end
do
 local a=np.array({0.0,1.0},np.bool)
 local b=np.array({1.0,0.0},np.bool)
 local r=np.hypot(a,b)
 assert(r.dtype=='float16','binary inv dtype 194')
 assert(list_same(r:tolist(),{1.0,1.0},0.004,false,true),'binary inv hypot 194')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,3.0},np.int8)
 local b=np.array({2.0,-2.0,1.0,4.0,-1.0},np.int8)
 local r=np.arctan2(a,b)
 assert(r.dtype=='float16','binary inv dtype 195')
 assert(list_same(r:tolist(),{-0.98291015625,-2.677734375,0.0,0.2449951171875,1.892578125},0.004,false,true),'binary inv arctan2 195')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,3.0},np.int8)
 local b=np.array({2.0,-2.0,1.0,4.0,-1.0},np.int8)
 local r=np.hypot(a,b)
 assert(r.dtype=='float16','binary inv dtype 196')
 assert(list_same(r:tolist(),{3.60546875,2.236328125,1.0,4.125,3.162109375},0.004,false,true),'binary inv hypot 196')
end
do
 local a=np.array({0.0,1.0,2.0,4.0},np.uint8)
 local b=np.array({1.0,2.0,4.0,1.0},np.uint8)
 local r=np.arctan2(a,b)
 assert(r.dtype=='float16','binary inv dtype 197')
 assert(list_same(r:tolist(),{0.0,0.463623046875,0.463623046875,1.326171875},0.004,false,true),'binary inv arctan2 197')
end
do
 local a=np.array({0.0,1.0,2.0,4.0},np.uint8)
 local b=np.array({1.0,2.0,4.0,1.0},np.uint8)
 local r=np.hypot(a,b)
 assert(r.dtype=='float16','binary inv dtype 198')
 assert(list_same(r:tolist(),{1.0,2.236328125,4.47265625,4.125},0.004,false,true),'binary inv hypot 198')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,3.0},np.int16)
 local b=np.array({2.0,-2.0,1.0,4.0,-1.0},np.int16)
 local r=np.arctan2(a,b)
 assert(r.dtype=='float32','binary inv dtype 199')
 assert(list_same(r:tolist(),{-0.9827938079833984,-2.677945137023926,0.0,0.24497868120670319,1.8925468921661377},8e-05,false,true),'binary inv arctan2 199')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,3.0},np.int16)
 local b=np.array({2.0,-2.0,1.0,4.0,-1.0},np.int16)
 local r=np.hypot(a,b)
 assert(r.dtype=='float32','binary inv dtype 200')
 assert(list_same(r:tolist(),{3.605551242828369,2.2360680103302,1.0,4.123105525970459,3.1622776985168457},8e-05,false,true),'binary inv hypot 200')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,3.0},np.int32)
 local b=np.array({2.0,-2.0,1.0,4.0,-1.0},np.int32)
 local r=np.arctan2(a,b)
 assert(r.dtype=='float64','binary inv dtype 201')
 assert(list_same(r:tolist(),{-0.982793723247329,-2.677945044588987,0.0,0.24497866312686414,1.8925468811915387},6e-12,false,true),'binary inv arctan2 201')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,3.0},np.int32)
 local b=np.array({2.0,-2.0,1.0,4.0,-1.0},np.int32)
 local r=np.hypot(a,b)
 assert(r.dtype=='float64','binary inv dtype 202')
 assert(list_same(r:tolist(),{3.605551275463989,2.23606797749979,1.0,4.123105625617661,3.1622776601683795},6e-12,false,true),'binary inv hypot 202')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,3.0},np.int64)
 local b=np.array({2.0,-2.0,1.0,4.0,-1.0},np.int64)
 local r=np.arctan2(a,b)
 assert(r.dtype=='float64','binary inv dtype 203')
 assert(list_same(r:tolist(),{-0.982793723247329,-2.677945044588987,0.0,0.24497866312686414,1.8925468811915387},6e-12,false,true),'binary inv arctan2 203')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,3.0},np.int64)
 local b=np.array({2.0,-2.0,1.0,4.0,-1.0},np.int64)
 local r=np.hypot(a,b)
 assert(r.dtype=='float64','binary inv dtype 204')
 assert(list_same(r:tolist(),{3.605551275463989,2.23606797749979,1.0,4.123105625617661,3.1622776601683795},6e-12,false,true),'binary inv hypot 204')
end
do
 local a=np.array({-3.0,-1.0,-0.0,0.0,0.5,2.0,4.0},np.float16)
 local b=np.array({2.0,-2.0,1.0,-1.0,4.0,0.5,3.0},np.float16)
 local r=np.arctan2(a,b)
 assert(r.dtype=='float16','binary inv dtype 205')
 assert(list_same(r:tolist(),{-0.98291015625,-2.677734375,-0.0,3.140625,0.12432861328125,1.326171875,0.92724609375},0.004,false,true),'binary inv arctan2 205')
end
do
 local a=np.array({-3.0,-1.0,-0.0,0.0,0.5,2.0,4.0},np.float16)
 local b=np.array({2.0,-2.0,1.0,-1.0,4.0,0.5,3.0},np.float16)
 local r=np.hypot(a,b)
 assert(r.dtype=='float16','binary inv dtype 206')
 assert(list_same(r:tolist(),{3.60546875,2.236328125,1.0,1.0,4.03125,2.0625,5.0},0.004,false,true),'binary inv hypot 206')
end
do
 local a=np.array({-3.0,-1.0,-0.0,0.0,0.5,2.0,4.0},np.float32)
 local b=np.array({2.0,-2.0,1.0,-1.0,4.0,0.5,3.0},np.float32)
 local r=np.arctan2(a,b)
 assert(r.dtype=='float32','binary inv dtype 207')
 assert(list_same(r:tolist(),{-0.9827938079833984,-2.677945137023926,-0.0,3.1415927410125732,0.12435498833656311,1.3258177042007446,0.9272952079772949},8e-05,false,true),'binary inv arctan2 207')
end
do
 local a=np.array({-3.0,-1.0,-0.0,0.0,0.5,2.0,4.0},np.float32)
 local b=np.array({2.0,-2.0,1.0,-1.0,4.0,0.5,3.0},np.float32)
 local r=np.hypot(a,b)
 assert(r.dtype=='float32','binary inv dtype 208')
 assert(list_same(r:tolist(),{3.605551242828369,2.2360680103302,1.0,1.0,4.031128883361816,2.0615527629852295,5.0},8e-05,false,true),'binary inv hypot 208')
end
do
 local a=np.array({-3.0,-1.0,-0.0,0.0,0.5,2.0,4.0},np.float64)
 local b=np.array({2.0,-2.0,1.0,-1.0,4.0,0.5,3.0},np.float64)
 local r=np.arctan2(a,b)
 assert(r.dtype=='float64','binary inv dtype 209')
 assert(list_same(r:tolist(),{-0.982793723247329,-2.677945044588987,-0.0,3.141592653589793,0.12435499454676144,1.3258176636680326,0.9272952180016122},6e-12,false,true),'binary inv arctan2 209')
end
do
 local a=np.array({-3.0,-1.0,-0.0,0.0,0.5,2.0,4.0},np.float64)
 local b=np.array({2.0,-2.0,1.0,-1.0,4.0,0.5,3.0},np.float64)
 local r=np.hypot(a,b)
 assert(r.dtype=='float64','binary inv dtype 210')
 assert(list_same(r:tolist(),{3.605551275463989,2.23606797749979,1.0,1.0,4.031128874149275,2.0615528128088303,5.0},6e-12,false,true),'binary inv hypot 210')
end
do
 local a=np.array({-3.0,-1.0,-0.0,0.0,0.5,2.0,4.0},np.longdouble)
 local b=np.array({2.0,-2.0,1.0,-1.0,4.0,0.5,3.0},np.longdouble)
 local r=np.arctan2(a,b)
 assert(r.dtype=='longdouble','binary inv dtype 211')
 assert(list_same(r:tolist(),{-0.982793723247329,-2.677945044588987,-0.0,3.141592653589793,0.12435499454676144,1.3258176636680326,0.9272952180016122},6e-12,false,true),'binary inv arctan2 211')
end
do
 local a=np.array({-3.0,-1.0,-0.0,0.0,0.5,2.0,4.0},np.longdouble)
 local b=np.array({2.0,-2.0,1.0,-1.0,4.0,0.5,3.0},np.longdouble)
 local r=np.hypot(a,b)
 assert(r.dtype=='longdouble','binary inv dtype 212')
 assert(list_same(r:tolist(),{3.605551275463989,2.23606797749979,1.0,1.0,4.031128874149275,2.0615528128088303,5.0},6e-12,false,true),'binary inv hypot 212')
end
do
 local a=np.reshape(np.array({-3.0,0.0,2.0},np.int8),{3,1})
 local b=np.reshape(np.array({0.5,-2.0,4.0,1.0},np.float32),{1,4})
 local r=np.arctan2(a,b)
 assert(r.dtype=='float32','binary broadcast dtype 213')
 assert(list_same(r:tolist()[1],{-1.4056476354599,-2.158798933029175,-0.6435011625289917,-1.2490458488464355},8e-05,false,true),'binary broadcast arctan2 213')
end
do
 local a=np.reshape(np.array({-3.0,0.0,2.0},np.int8),{3,1})
 local b=np.reshape(np.array({0.5,-2.0,4.0,1.0},np.float32),{1,4})
 local r=np.hypot(a,b)
 assert(r.dtype=='float32','binary broadcast dtype 214')
 assert(list_same(r:tolist()[1],{3.041381359100342,3.605551242828369,5.0,3.1622776985168457},8e-05,false,true),'binary broadcast hypot 214')
end
do
 local a=np.reshape(np.array({-3.0,0.0,2.0},np.int16),{3,1})
 local b=np.reshape(np.array({0.5,-2.0,4.0,1.0},np.float64),{1,4})
 local r=np.arctan2(a,b)
 assert(r.dtype=='float64','binary broadcast dtype 215')
 assert(list_same(r:tolist()[1],{-1.4056476493802699,-2.1587989303424644,-0.6435011087932844,-1.2490457723982544},6e-12,false,true),'binary broadcast arctan2 215')
end
do
 local a=np.reshape(np.array({-3.0,0.0,2.0},np.int16),{3,1})
 local b=np.reshape(np.array({0.5,-2.0,4.0,1.0},np.float64),{1,4})
 local r=np.hypot(a,b)
 assert(r.dtype=='float64','binary broadcast dtype 216')
 assert(list_same(r:tolist()[1],{3.0413812651491097,3.605551275463989,5.0,3.1622776601683795},6e-12,false,true),'binary broadcast hypot 216')
end
do
 local a=np.reshape(np.array({-3.0,0.0,2.0},np.float16),{3,1})
 local b=np.reshape(np.array({0.5,-2.0,4.0,1.0},np.float32),{1,4})
 local r=np.arctan2(a,b)
 assert(r.dtype=='float32','binary broadcast dtype 217')
 assert(list_same(r:tolist()[1],{-1.4056476354599,-2.158798933029175,-0.6435011625289917,-1.2490458488464355},8e-05,false,true),'binary broadcast arctan2 217')
end
do
 local a=np.reshape(np.array({-3.0,0.0,2.0},np.float16),{3,1})
 local b=np.reshape(np.array({0.5,-2.0,4.0,1.0},np.float32),{1,4})
 local r=np.hypot(a,b)
 assert(r.dtype=='float32','binary broadcast dtype 218')
 assert(list_same(r:tolist()[1],{3.041381359100342,3.605551242828369,5.0,3.1622776985168457},8e-05,false,true),'binary broadcast hypot 218')
end
do
 local a=np.reshape(np.array({-3.0,0.0,2.0},np.float32),{3,1})
 local b=np.reshape(np.array({0.5,-2.0,4.0,1.0},np.float64),{1,4})
 local r=np.arctan2(a,b)
 assert(r.dtype=='float64','binary broadcast dtype 219')
 assert(list_same(r:tolist()[1],{-1.4056476493802699,-2.1587989303424644,-0.6435011087932844,-1.2490457723982544},6e-12,false,true),'binary broadcast arctan2 219')
end
do
 local a=np.reshape(np.array({-3.0,0.0,2.0},np.float32),{3,1})
 local b=np.reshape(np.array({0.5,-2.0,4.0,1.0},np.float64),{1,4})
 local r=np.hypot(a,b)
 assert(r.dtype=='float64','binary broadcast dtype 220')
 assert(list_same(r:tolist()[1],{3.0413812651491097,3.605551275463989,5.0,3.1622776601683795},6e-12,false,true),'binary broadcast hypot 220')
end
do
 local a=np.reshape(np.array({1.0,0.0,1.0},np.bool),{3,1})
 local b=np.reshape(np.array({0.0,-2.0,4.0,1.0},np.int16),{1,4})
 local r=np.arctan2(a,b)
 assert(r.dtype=='float32','binary broadcast dtype 221')
 assert(list_same(r:tolist()[1],{1.5707963705062866,2.677945137023926,0.24497868120670319,0.7853981256484985},8e-05,false,true),'binary broadcast arctan2 221')
end
do
 local a=np.reshape(np.array({1.0,0.0,1.0},np.bool),{3,1})
 local b=np.reshape(np.array({0.0,-2.0,4.0,1.0},np.int16),{1,4})
 local r=np.hypot(a,b)
 assert(r.dtype=='float32','binary broadcast dtype 222')
 assert(list_same(r:tolist()[1],{1.0,2.2360680103302,4.123105525970459,1.4142135381698608},8e-05,false,true),'binary broadcast hypot 222')
end
do
 local a=np.array({1.0,1.0},np.bool)
 local r=np.arctan2(a,true)
 assert(r.dtype=='float16','weak binary dtype 223')
 assert(list_same(r:tolist(),{0.78515625,0.78515625},0.004,false,true),'weak binary arctan2 223')
end
do
 local a=np.array({1.0,1.0},np.bool)
 local r=np.hypot(a,true)
 assert(r.dtype=='float16','weak binary dtype 224')
 assert(list_same(r:tolist(),{1.4140625,1.4140625},0.004,false,true),'weak binary hypot 224')
end
do
 local a=np.array({1.0,1.0},np.bool)
 local r=np.arctan2(a,2)
 assert(r.dtype=='float64','weak binary dtype 225')
 assert(list_same(r:tolist(),{0.4636476090008061,0.4636476090008061},6e-12,false,true),'weak binary arctan2 225')
end
do
 local a=np.array({1.0,1.0},np.bool)
 local r=np.hypot(a,2)
 assert(r.dtype=='float64','weak binary dtype 226')
 assert(list_same(r:tolist(),{2.23606797749979,2.23606797749979},6e-12,false,true),'weak binary hypot 226')
end
do
 local a=np.array({1.0,1.0},np.bool)
 local r=np.arctan2(a,2.0)
 assert(r.dtype=='float64','weak binary dtype 227')
 assert(list_same(r:tolist(),{0.4636476090008061,0.4636476090008061},6e-12,false,true),'weak binary arctan2 227')
end
do
 local a=np.array({1.0,1.0},np.bool)
 local r=np.hypot(a,2.0)
 assert(r.dtype=='float64','weak binary dtype 228')
 assert(list_same(r:tolist(),{2.23606797749979,2.23606797749979},6e-12,false,true),'weak binary hypot 228')
end
do
 local a=np.array({1.0,2.0},np.int8)
 local r=np.arctan2(a,true)
 assert(r.dtype=='float16','weak binary dtype 229')
 assert(list_same(r:tolist(),{0.78515625,1.107421875},0.004,false,true),'weak binary arctan2 229')
end
do
 local a=np.array({1.0,2.0},np.int8)
 local r=np.hypot(a,true)
 assert(r.dtype=='float16','weak binary dtype 230')
 assert(list_same(r:tolist(),{1.4140625,2.236328125},0.004,false,true),'weak binary hypot 230')
end
do
 local a=np.array({1.0,2.0},np.int8)
 local r=np.arctan2(a,2)
 assert(r.dtype=='float16','weak binary dtype 231')
 assert(list_same(r:tolist(),{0.463623046875,0.78515625},0.004,false,true),'weak binary arctan2 231')
end
do
 local a=np.array({1.0,2.0},np.int8)
 local r=np.hypot(a,2)
 assert(r.dtype=='float16','weak binary dtype 232')
 assert(list_same(r:tolist(),{2.236328125,2.828125},0.004,false,true),'weak binary hypot 232')
end
do
 local a=np.array({1.0,2.0},np.int8)
 local r=np.arctan2(a,2.0)
 assert(r.dtype=='float64','weak binary dtype 233')
 assert(list_same(r:tolist(),{0.4636476090008061,0.7853981633974483},6e-12,false,true),'weak binary arctan2 233')
end
do
 local a=np.array({1.0,2.0},np.int8)
 local r=np.hypot(a,2.0)
 assert(r.dtype=='float64','weak binary dtype 234')
 assert(list_same(r:tolist(),{2.23606797749979,2.8284271247461903},6e-12,false,true),'weak binary hypot 234')
end
do
 local a=np.array({1.0,2.0},np.int16)
 local r=np.arctan2(a,true)
 assert(r.dtype=='float32','weak binary dtype 235')
 assert(list_same(r:tolist(),{0.7853981256484985,1.1071487665176392},8e-05,false,true),'weak binary arctan2 235')
end
do
 local a=np.array({1.0,2.0},np.int16)
 local r=np.hypot(a,true)
 assert(r.dtype=='float32','weak binary dtype 236')
 assert(list_same(r:tolist(),{1.4142135381698608,2.2360680103302},8e-05,false,true),'weak binary hypot 236')
end
do
 local a=np.array({1.0,2.0},np.int16)
 local r=np.arctan2(a,2)
 assert(r.dtype=='float32','weak binary dtype 237')
 assert(list_same(r:tolist(),{0.46364763379096985,0.7853981256484985},8e-05,false,true),'weak binary arctan2 237')
end
do
 local a=np.array({1.0,2.0},np.int16)
 local r=np.hypot(a,2)
 assert(r.dtype=='float32','weak binary dtype 238')
 assert(list_same(r:tolist(),{2.2360680103302,2.8284270763397217},8e-05,false,true),'weak binary hypot 238')
end
do
 local a=np.array({1.0,2.0},np.int16)
 local r=np.arctan2(a,2.0)
 assert(r.dtype=='float64','weak binary dtype 239')
 assert(list_same(r:tolist(),{0.4636476090008061,0.7853981633974483},6e-12,false,true),'weak binary arctan2 239')
end
do
 local a=np.array({1.0,2.0},np.int16)
 local r=np.hypot(a,2.0)
 assert(r.dtype=='float64','weak binary dtype 240')
 assert(list_same(r:tolist(),{2.23606797749979,2.8284271247461903},6e-12,false,true),'weak binary hypot 240')
end
do
 local a=np.array({1.0,2.0},np.int32)
 local r=np.arctan2(a,true)
 assert(r.dtype=='float64','weak binary dtype 241')
 assert(list_same(r:tolist(),{0.7853981633974483,1.1071487177940904},6e-12,false,true),'weak binary arctan2 241')
end
do
 local a=np.array({1.0,2.0},np.int32)
 local r=np.hypot(a,true)
 assert(r.dtype=='float64','weak binary dtype 242')
 assert(list_same(r:tolist(),{1.4142135623730951,2.23606797749979},6e-12,false,true),'weak binary hypot 242')
end
do
 local a=np.array({1.0,2.0},np.int32)
 local r=np.arctan2(a,2)
 assert(r.dtype=='float64','weak binary dtype 243')
 assert(list_same(r:tolist(),{0.4636476090008061,0.7853981633974483},6e-12,false,true),'weak binary arctan2 243')
end
do
 local a=np.array({1.0,2.0},np.int32)
 local r=np.hypot(a,2)
 assert(r.dtype=='float64','weak binary dtype 244')
 assert(list_same(r:tolist(),{2.23606797749979,2.8284271247461903},6e-12,false,true),'weak binary hypot 244')
end
do
 local a=np.array({1.0,2.0},np.int32)
 local r=np.arctan2(a,2.0)
 assert(r.dtype=='float64','weak binary dtype 245')
 assert(list_same(r:tolist(),{0.4636476090008061,0.7853981633974483},6e-12,false,true),'weak binary arctan2 245')
end
do
 local a=np.array({1.0,2.0},np.int32)
 local r=np.hypot(a,2.0)
 assert(r.dtype=='float64','weak binary dtype 246')
 assert(list_same(r:tolist(),{2.23606797749979,2.8284271247461903},6e-12,false,true),'weak binary hypot 246')
end
do
 local a=np.array({1.0,2.0},np.float16)
 local r=np.arctan2(a,true)
 assert(r.dtype=='float16','weak binary dtype 247')
 assert(list_same(r:tolist(),{0.78515625,1.107421875},0.004,false,true),'weak binary arctan2 247')
end
do
 local a=np.array({1.0,2.0},np.float16)
 local r=np.hypot(a,true)
 assert(r.dtype=='float16','weak binary dtype 248')
 assert(list_same(r:tolist(),{1.4140625,2.236328125},0.004,false,true),'weak binary hypot 248')
end
do
 local a=np.array({1.0,2.0},np.float16)
 local r=np.arctan2(a,2)
 assert(r.dtype=='float16','weak binary dtype 249')
 assert(list_same(r:tolist(),{0.463623046875,0.78515625},0.004,false,true),'weak binary arctan2 249')
end
do
 local a=np.array({1.0,2.0},np.float16)
 local r=np.hypot(a,2)
 assert(r.dtype=='float16','weak binary dtype 250')
 assert(list_same(r:tolist(),{2.236328125,2.828125},0.004,false,true),'weak binary hypot 250')
end
do
 local a=np.array({1.0,2.0},np.float16)
 local r=np.arctan2(a,2.0)
 assert(r.dtype=='float16','weak binary dtype 251')
 assert(list_same(r:tolist(),{0.463623046875,0.78515625},0.004,false,true),'weak binary arctan2 251')
end
do
 local a=np.array({1.0,2.0},np.float16)
 local r=np.hypot(a,2.0)
 assert(r.dtype=='float16','weak binary dtype 252')
 assert(list_same(r:tolist(),{2.236328125,2.828125},0.004,false,true),'weak binary hypot 252')
end
do
 local a=np.array({1.0,2.0},np.float32)
 local r=np.arctan2(a,true)
 assert(r.dtype=='float32','weak binary dtype 253')
 assert(list_same(r:tolist(),{0.7853981256484985,1.1071487665176392},8e-05,false,true),'weak binary arctan2 253')
end
do
 local a=np.array({1.0,2.0},np.float32)
 local r=np.hypot(a,true)
 assert(r.dtype=='float32','weak binary dtype 254')
 assert(list_same(r:tolist(),{1.4142135381698608,2.2360680103302},8e-05,false,true),'weak binary hypot 254')
end
do
 local a=np.array({1.0,2.0},np.float32)
 local r=np.arctan2(a,2)
 assert(r.dtype=='float32','weak binary dtype 255')
 assert(list_same(r:tolist(),{0.46364763379096985,0.7853981256484985},8e-05,false,true),'weak binary arctan2 255')
end
do
 local a=np.array({1.0,2.0},np.float32)
 local r=np.hypot(a,2)
 assert(r.dtype=='float32','weak binary dtype 256')
 assert(list_same(r:tolist(),{2.2360680103302,2.8284270763397217},8e-05,false,true),'weak binary hypot 256')
end
do
 local a=np.array({1.0,2.0},np.float32)
 local r=np.arctan2(a,2.0)
 assert(r.dtype=='float32','weak binary dtype 257')
 assert(list_same(r:tolist(),{0.46364763379096985,0.7853981256484985},8e-05,false,true),'weak binary arctan2 257')
end
do
 local a=np.array({1.0,2.0},np.float32)
 local r=np.hypot(a,2.0)
 assert(r.dtype=='float32','weak binary dtype 258')
 assert(list_same(r:tolist(),{2.2360680103302,2.8284270763397217},8e-05,false,true),'weak binary hypot 258')
end
do
 local a=np.array({1.0,2.0},np.float64)
 local r=np.arctan2(a,true)
 assert(r.dtype=='float64','weak binary dtype 259')
 assert(list_same(r:tolist(),{0.7853981633974483,1.1071487177940904},6e-12,false,true),'weak binary arctan2 259')
end
do
 local a=np.array({1.0,2.0},np.float64)
 local r=np.hypot(a,true)
 assert(r.dtype=='float64','weak binary dtype 260')
 assert(list_same(r:tolist(),{1.4142135623730951,2.23606797749979},6e-12,false,true),'weak binary hypot 260')
end
do
 local a=np.array({1.0,2.0},np.float64)
 local r=np.arctan2(a,2)
 assert(r.dtype=='float64','weak binary dtype 261')
 assert(list_same(r:tolist(),{0.4636476090008061,0.7853981633974483},6e-12,false,true),'weak binary arctan2 261')
end
do
 local a=np.array({1.0,2.0},np.float64)
 local r=np.hypot(a,2)
 assert(r.dtype=='float64','weak binary dtype 262')
 assert(list_same(r:tolist(),{2.23606797749979,2.8284271247461903},6e-12,false,true),'weak binary hypot 262')
end
do
 local a=np.array({1.0,2.0},np.float64)
 local r=np.arctan2(a,2.0)
 assert(r.dtype=='float64','weak binary dtype 263')
 assert(list_same(r:tolist(),{0.4636476090008061,0.7853981633974483},6e-12,false,true),'weak binary arctan2 263')
end
do
 local a=np.array({1.0,2.0},np.float64)
 local r=np.hypot(a,2.0)
 assert(r.dtype=='float64','weak binary dtype 264')
 assert(list_same(r:tolist(),{2.23606797749979,2.8284271247461903},6e-12,false,true),'weak binary hypot 264')
end
do
 local a=np.array({-0.5,0.25,0.75,2.0},np.float32)
 local m=np.array({false,true,false,true},np.bool)
 local o=np.array({9,8,7,6},np.float64)
 np.arctan(a,{out=o,where=m})
 assert(list_same(o:tolist(),{9.0,0.244978666305542,7.0,1.1071487665176392},8e-5,false,true),'inv out where 265')
end
do
 local a=np.array({-0.5,0.25,0.75,2.0},np.float32)
 local m=np.array({false,true,false,true},np.bool)
 local o=np.array({9,8,7,6},np.float64)
 np.arcsinh(a,{out=o,where=m})
 assert(list_same(o:tolist(),{9.0,0.24746645987033844,7.0,1.4436354637145996},8e-5,false,true),'inv out where 266')
end
do
 local a=np.array({3.0,4.0,5.0,6.0},np.float32)
 local b=np.array({4.0,3.0,12.0,8.0},np.float32)
 local m=np.array({false,true,false,true},np.bool)
 local o=np.array({9,8,7,6},np.float64)
 np.arctan2(a,b,{out=o,where=m})
 assert(list_same(o:tolist(),{9.0,0.9272952079772949,7.0,0.6435011625289917},8e-5,false,true),'binary out where 267')
end
do
 local a=np.array({3.0,4.0,5.0,6.0},np.float32)
 local b=np.array({4.0,3.0,12.0,8.0},np.float32)
 local m=np.array({false,true,false,true},np.bool)
 local o=np.array({9,8,7,6},np.float64)
 np.hypot(a,b,{out=o,where=m})
 assert(list_same(o:tolist(),{9.0,5.0,7.0,10.0},8e-5,false,true),'binary out where 268')
end
do
 local z=np.array({np.complex(1,2)},np.complex128)
 assert(not pcall(function() np.arctan2(z,z) end),'complex arctan2 must reject')
 assert(not pcall(function() np.hypot(z,z) end),'complex hypot must reject')
end
print('inverse math differential: 270 cases ok')
