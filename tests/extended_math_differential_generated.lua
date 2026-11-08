local np=require('luaray_core')

local function fsame(a,b,tol)
  if a~=a and b~=b then return true end
  if a==b then return true end
  if a==0 and b==0 then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return false end
  return math.abs(a-b)<=tol*math.max(1,math.abs(a),math.abs(b))
end
local function zsame(a,b,tol)
  return type(a)=='userdata' and type(b)=='userdata' and
         fsame(a.real,b.real,tol) and fsame(a.imag,b.imag,tol)
end
local function list_same(a,b,tol,complex)
  if #a~=#b then return false end
  for i=1,#a do
    if complex then
      if not zsame(a[i],b[i],tol) then return false end
    else
      if not fsame(a[i],b[i],tol) then return false end
    end
  end
  return true
end
-- Generated against development NumPy 2.3.5.
do
 local a=np.array({1.0,1.0,0.0,1.0,1.0,1.0},np.bool)
 local r=np.sinh(a)
 assert(r.dtype=='float16','ext math dtype 0')
 assert(list_same(r:tolist(),{1.1748046875,1.1748046875,0.0,1.1748046875,1.1748046875,1.1748046875},0.004,false),'ext math sinh 0')
end
do
 local a=np.array({1.0,1.0,0.0,1.0,1.0,1.0},np.bool)
 local r=np.cosh(a)
 assert(r.dtype=='float16','ext math dtype 1')
 assert(list_same(r:tolist(),{1.54296875,1.54296875,1.0,1.54296875,1.54296875,1.54296875},0.004,false),'ext math cosh 1')
end
do
 local a=np.array({1.0,1.0,0.0,1.0,1.0,1.0},np.bool)
 local r=np.tanh(a)
 assert(r.dtype=='float16','ext math dtype 2')
 assert(list_same(r:tolist(),{0.76171875,0.76171875,0.0,0.76171875,0.76171875,0.76171875},0.004,false),'ext math tanh 2')
end
do
 local a=np.array({1.0,1.0,0.0,1.0,1.0,1.0},np.bool)
 local r=np.exp2(a)
 assert(r.dtype=='float16','ext math dtype 3')
 assert(list_same(r:tolist(),{2.0,2.0,1.0,2.0,2.0,2.0},0.004,false),'ext math exp2 3')
end
do
 local a=np.array({1.0,1.0,0.0,1.0,1.0,1.0},np.bool)
 local r=np.log2(a)
 assert(r.dtype=='float16','ext math dtype 4')
 assert(list_same(r:tolist(),{0.0,0.0,-math.huge,0.0,0.0,0.0},0.004,false),'ext math log2 4')
end
do
 local a=np.array({1.0,1.0,0.0,1.0,1.0,1.0},np.bool)
 local r=np.log10(a)
 assert(r.dtype=='float16','ext math dtype 5')
 assert(list_same(r:tolist(),{0.0,0.0,-math.huge,0.0,0.0,0.0},0.004,false),'ext math log10 5')
end
do
 local a=np.array({1.0,1.0,0.0,1.0,1.0,1.0},np.bool)
 local r=np.expm1(a)
 assert(r.dtype=='float16','ext math dtype 6')
 assert(list_same(r:tolist(),{1.71875,1.71875,0.0,1.71875,1.71875,1.71875},0.004,false),'ext math expm1 6')
end
do
 local a=np.array({1.0,1.0,0.0,1.0,1.0,1.0},np.bool)
 local r=np.log1p(a)
 assert(r.dtype=='float16','ext math dtype 7')
 assert(list_same(r:tolist(),{0.693359375,0.693359375,0.0,0.693359375,0.693359375,0.693359375},0.004,false),'ext math log1p 7')
end
do
 local a=np.array({1.0,1.0,0.0,1.0,1.0,1.0},np.bool)
 local r=np.cbrt(a)
 assert(r.dtype=='float16','ext math dtype 8')
 assert(list_same(r:tolist(),{1.0,1.0,0.0,1.0,1.0,1.0},0.004,false),'ext math cbrt 8')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int8)
 local r=np.sinh(a)
 assert(r.dtype=='float16','ext math dtype 9')
 assert(list_same(r:tolist(),{-10.015625,-1.1748046875,0.0,1.1748046875,3.626953125,74.1875},0.004,false),'ext math sinh 9')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int8)
 local r=np.cosh(a)
 assert(r.dtype=='float16','ext math dtype 10')
 assert(list_same(r:tolist(),{10.0703125,1.54296875,1.0,1.54296875,3.76171875,74.1875},0.004,false),'ext math cosh 10')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int8)
 local r=np.tanh(a)
 assert(r.dtype=='float16','ext math dtype 11')
 assert(list_same(r:tolist(),{-0.9951171875,-0.76171875,0.0,0.76171875,0.9638671875,1.0},0.004,false),'ext math tanh 11')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int8)
 local r=np.exp2(a)
 assert(r.dtype=='float16','ext math dtype 12')
 assert(list_same(r:tolist(),{0.125,0.5,1.0,2.0,4.0,32.0},0.004,false),'ext math exp2 12')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int8)
 local r=np.log2(a)
 assert(r.dtype=='float16','ext math dtype 13')
 assert(list_same(r:tolist(),{(0/0),(0/0),-math.huge,0.0,1.0,2.322265625},0.004,false),'ext math log2 13')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int8)
 local r=np.log10(a)
 assert(r.dtype=='float16','ext math dtype 14')
 assert(list_same(r:tolist(),{(0/0),(0/0),-math.huge,0.0,0.301025390625,0.69873046875},0.004,false),'ext math log10 14')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int8)
 local r=np.expm1(a)
 assert(r.dtype=='float16','ext math dtype 15')
 assert(list_same(r:tolist(),{-0.9501953125,-0.63232421875,0.0,1.71875,6.390625,147.375},0.004,false),'ext math expm1 15')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int8)
 local r=np.log1p(a)
 assert(r.dtype=='float16','ext math dtype 16')
 assert(list_same(r:tolist(),{(0/0),-math.huge,0.0,0.693359375,1.0986328125,1.7919921875},0.004,false),'ext math log1p 16')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int8)
 local r=np.cbrt(a)
 assert(r.dtype=='float16','ext math dtype 17')
 assert(list_same(r:tolist(),{-1.4423828125,-1.0,0.0,1.0,1.259765625,1.7099609375},0.004,false),'ext math cbrt 17')
end
do
 local a=np.array({0.0,1.0,2.0,5.0,8.0},np.uint8)
 local r=np.sinh(a)
 assert(r.dtype=='float16','ext math dtype 18')
 assert(list_same(r:tolist(),{0.0,1.1748046875,3.626953125,74.1875,1490.0},0.004,false),'ext math sinh 18')
end
do
 local a=np.array({0.0,1.0,2.0,5.0,8.0},np.uint8)
 local r=np.cosh(a)
 assert(r.dtype=='float16','ext math dtype 19')
 assert(list_same(r:tolist(),{1.0,1.54296875,3.76171875,74.1875,1490.0},0.004,false),'ext math cosh 19')
end
do
 local a=np.array({0.0,1.0,2.0,5.0,8.0},np.uint8)
 local r=np.tanh(a)
 assert(r.dtype=='float16','ext math dtype 20')
 assert(list_same(r:tolist(),{0.0,0.76171875,0.9638671875,1.0,1.0},0.004,false),'ext math tanh 20')
end
do
 local a=np.array({0.0,1.0,2.0,5.0,8.0},np.uint8)
 local r=np.exp2(a)
 assert(r.dtype=='float16','ext math dtype 21')
 assert(list_same(r:tolist(),{1.0,2.0,4.0,32.0,256.0},0.004,false),'ext math exp2 21')
end
do
 local a=np.array({0.0,1.0,2.0,5.0,8.0},np.uint8)
 local r=np.log2(a)
 assert(r.dtype=='float16','ext math dtype 22')
 assert(list_same(r:tolist(),{-math.huge,0.0,1.0,2.322265625,3.0},0.004,false),'ext math log2 22')
end
do
 local a=np.array({0.0,1.0,2.0,5.0,8.0},np.uint8)
 local r=np.log10(a)
 assert(r.dtype=='float16','ext math dtype 23')
 assert(list_same(r:tolist(),{-math.huge,0.0,0.301025390625,0.69873046875,0.9033203125},0.004,false),'ext math log10 23')
end
do
 local a=np.array({0.0,1.0,2.0,5.0,8.0},np.uint8)
 local r=np.expm1(a)
 assert(r.dtype=='float16','ext math dtype 24')
 assert(list_same(r:tolist(),{0.0,1.71875,6.390625,147.375,2980.0},0.004,false),'ext math expm1 24')
end
do
 local a=np.array({0.0,1.0,2.0,5.0,8.0},np.uint8)
 local r=np.log1p(a)
 assert(r.dtype=='float16','ext math dtype 25')
 assert(list_same(r:tolist(),{0.0,0.693359375,1.0986328125,1.7919921875,2.197265625},0.004,false),'ext math log1p 25')
end
do
 local a=np.array({0.0,1.0,2.0,5.0,8.0},np.uint8)
 local r=np.cbrt(a)
 assert(r.dtype=='float16','ext math dtype 26')
 assert(list_same(r:tolist(),{0.0,1.0,1.259765625,1.7099609375,2.0},0.004,false),'ext math cbrt 26')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int16)
 local r=np.sinh(a)
 assert(r.dtype=='float32','ext math dtype 27')
 assert(list_same(r:tolist(),{-10.017874717712402,-1.175201177597046,0.0,1.175201177597046,3.6268603801727295,74.20320892333984},5e-05,false),'ext math sinh 27')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int16)
 local r=np.cosh(a)
 assert(r.dtype=='float32','ext math dtype 28')
 assert(list_same(r:tolist(),{10.06766128540039,1.5430806875228882,1.0,1.5430806875228882,3.762195587158203,74.20994567871094},5e-05,false),'ext math cosh 28')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int16)
 local r=np.tanh(a)
 assert(r.dtype=='float32','ext math dtype 29')
 assert(list_same(r:tolist(),{-0.9950547814369202,-0.7615941762924194,0.0,0.7615941762924194,0.9640275835990906,0.9999092221260071},5e-05,false),'ext math tanh 29')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int16)
 local r=np.exp2(a)
 assert(r.dtype=='float32','ext math dtype 30')
 assert(list_same(r:tolist(),{0.125,0.5,1.0,2.0,4.0,32.0},5e-05,false),'ext math exp2 30')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int16)
 local r=np.log2(a)
 assert(r.dtype=='float32','ext math dtype 31')
 assert(list_same(r:tolist(),{(0/0),(0/0),-math.huge,0.0,1.0,2.321928024291992},5e-05,false),'ext math log2 31')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int16)
 local r=np.log10(a)
 assert(r.dtype=='float32','ext math dtype 32')
 assert(list_same(r:tolist(),{(0/0),(0/0),-math.huge,0.0,0.3010300099849701,0.6989700198173523},5e-05,false),'ext math log10 32')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int16)
 local r=np.expm1(a)
 assert(r.dtype=='float32','ext math dtype 33')
 assert(list_same(r:tolist(),{-0.9502128958702087,-0.6321205496788025,0.0,1.718281865119934,6.389056205749512,147.4131622314453},5e-05,false),'ext math expm1 33')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int16)
 local r=np.log1p(a)
 assert(r.dtype=='float32','ext math dtype 34')
 assert(list_same(r:tolist(),{(0/0),-math.huge,0.0,0.6931471824645996,1.0986123085021973,1.7917594909667969},5e-05,false),'ext math log1p 34')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int16)
 local r=np.cbrt(a)
 assert(r.dtype=='float32','ext math dtype 35')
 assert(list_same(r:tolist(),{-1.4422496557235718,-1.0,0.0,1.0,1.2599210739135742,1.7099759578704834},5e-05,false),'ext math cbrt 35')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int32)
 local r=np.sinh(a)
 assert(r.dtype=='float64','ext math dtype 36')
 assert(list_same(r:tolist(),{-10.017874927409903,-1.1752011936438014,0.0,1.1752011936438014,3.6268604078470186,74.20321057778875},4e-12,false),'ext math sinh 36')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int32)
 local r=np.cosh(a)
 assert(r.dtype=='float64','ext math dtype 37')
 assert(list_same(r:tolist(),{10.067661995777765,1.5430806348152437,1.0,1.5430806348152437,3.7621956910836314,74.20994852478785},4e-12,false),'ext math cosh 37')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int32)
 local r=np.tanh(a)
 assert(r.dtype=='float64','ext math dtype 38')
 assert(list_same(r:tolist(),{-0.9950547536867305,-0.7615941559557649,0.0,0.7615941559557649,0.9640275800758169,0.9999092042625951},4e-12,false),'ext math tanh 38')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int32)
 local r=np.exp2(a)
 assert(r.dtype=='float64','ext math dtype 39')
 assert(list_same(r:tolist(),{0.125,0.5,1.0,2.0,4.0,32.0},4e-12,false),'ext math exp2 39')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int32)
 local r=np.log2(a)
 assert(r.dtype=='float64','ext math dtype 40')
 assert(list_same(r:tolist(),{(0/0),(0/0),-math.huge,0.0,1.0,2.321928094887362},4e-12,false),'ext math log2 40')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int32)
 local r=np.log10(a)
 assert(r.dtype=='float64','ext math dtype 41')
 assert(list_same(r:tolist(),{(0/0),(0/0),-math.huge,0.0,0.3010299956639812,0.6989700043360189},4e-12,false),'ext math log10 41')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int32)
 local r=np.expm1(a)
 assert(r.dtype=='float64','ext math dtype 42')
 assert(list_same(r:tolist(),{-0.950212931632136,-0.6321205588285577,0.0,1.7182818284590453,6.38905609893065,147.4131591025766},4e-12,false),'ext math expm1 42')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int32)
 local r=np.log1p(a)
 assert(r.dtype=='float64','ext math dtype 43')
 assert(list_same(r:tolist(),{(0/0),-math.huge,0.0,0.6931471805599453,1.0986122886681098,1.791759469228055},4e-12,false),'ext math log1p 43')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int32)
 local r=np.cbrt(a)
 assert(r.dtype=='float64','ext math dtype 44')
 assert(list_same(r:tolist(),{-1.4422495703074083,-1.0,0.0,1.0,1.2599210498948732,1.709975946676697},4e-12,false),'ext math cbrt 44')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int64)
 local r=np.sinh(a)
 assert(r.dtype=='float64','ext math dtype 45')
 assert(list_same(r:tolist(),{-10.017874927409903,-1.1752011936438014,0.0,1.1752011936438014,3.6268604078470186,74.20321057778875},4e-12,false),'ext math sinh 45')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int64)
 local r=np.cosh(a)
 assert(r.dtype=='float64','ext math dtype 46')
 assert(list_same(r:tolist(),{10.067661995777765,1.5430806348152437,1.0,1.5430806348152437,3.7621956910836314,74.20994852478785},4e-12,false),'ext math cosh 46')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int64)
 local r=np.tanh(a)
 assert(r.dtype=='float64','ext math dtype 47')
 assert(list_same(r:tolist(),{-0.9950547536867305,-0.7615941559557649,0.0,0.7615941559557649,0.9640275800758169,0.9999092042625951},4e-12,false),'ext math tanh 47')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int64)
 local r=np.exp2(a)
 assert(r.dtype=='float64','ext math dtype 48')
 assert(list_same(r:tolist(),{0.125,0.5,1.0,2.0,4.0,32.0},4e-12,false),'ext math exp2 48')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int64)
 local r=np.log2(a)
 assert(r.dtype=='float64','ext math dtype 49')
 assert(list_same(r:tolist(),{(0/0),(0/0),-math.huge,0.0,1.0,2.321928094887362},4e-12,false),'ext math log2 49')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int64)
 local r=np.log10(a)
 assert(r.dtype=='float64','ext math dtype 50')
 assert(list_same(r:tolist(),{(0/0),(0/0),-math.huge,0.0,0.3010299956639812,0.6989700043360189},4e-12,false),'ext math log10 50')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int64)
 local r=np.expm1(a)
 assert(r.dtype=='float64','ext math dtype 51')
 assert(list_same(r:tolist(),{-0.950212931632136,-0.6321205588285577,0.0,1.7182818284590453,6.38905609893065,147.4131591025766},4e-12,false),'ext math expm1 51')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int64)
 local r=np.log1p(a)
 assert(r.dtype=='float64','ext math dtype 52')
 assert(list_same(r:tolist(),{(0/0),-math.huge,0.0,0.6931471805599453,1.0986122886681098,1.791759469228055},4e-12,false),'ext math log1p 52')
end
do
 local a=np.array({-3.0,-1.0,0.0,1.0,2.0,5.0},np.int64)
 local r=np.cbrt(a)
 assert(r.dtype=='float64','ext math dtype 53')
 assert(list_same(r:tolist(),{-1.4422495703074083,-1.0,0.0,1.0,1.2599210498948732,1.709975946676697},4e-12,false),'ext math cbrt 53')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.00010001659393310547,0.25,0.75,1.0,2.0,5.0,8.0},np.float16)
 local r=np.sinh(a)
 assert(r.dtype=='float16','ext math dtype 54')
 assert(list_same(r:tolist(),{-1490.0,-10.015625,-2.12890625,-1.1748046875,-0.0,0.0,0.00010001659393310547,0.252685546875,0.822265625,1.1748046875,3.626953125,74.1875,1490.0},0.004,false),'ext math sinh 54')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.00010001659393310547,0.25,0.75,1.0,2.0,5.0,8.0},np.float16)
 local r=np.cosh(a)
 assert(r.dtype=='float16','ext math dtype 55')
 assert(list_same(r:tolist(),{1490.0,10.0703125,2.3515625,1.54296875,1.0,1.0,1.0,1.03125,1.294921875,1.54296875,3.76171875,74.1875,1490.0},0.004,false),'ext math cosh 55')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.00010001659393310547,0.25,0.75,1.0,2.0,5.0,8.0},np.float16)
 local r=np.tanh(a)
 assert(r.dtype=='float16','ext math dtype 56')
 assert(list_same(r:tolist(),{-1.0,-0.9951171875,-0.9052734375,-0.76171875,-0.0,0.0,0.00010001659393310547,0.244873046875,0.63525390625,0.76171875,0.9638671875,1.0,1.0},0.004,false),'ext math tanh 56')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.00010001659393310547,0.25,0.75,1.0,2.0,5.0,8.0},np.float16)
 local r=np.exp2(a)
 assert(r.dtype=='float16','ext math dtype 57')
 assert(list_same(r:tolist(),{0.00390625,0.125,0.353515625,0.5,1.0,1.0,1.0,1.189453125,1.681640625,2.0,4.0,32.0,256.0},0.004,false),'ext math exp2 57')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.00010001659393310547,0.25,0.75,1.0,2.0,5.0,8.0},np.float16)
 local r=np.log2(a)
 assert(r.dtype=='float16','ext math dtype 58')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),(0/0),-math.huge,-math.huge,-13.2890625,-2.0,-0.4150390625,0.0,1.0,2.322265625,3.0},0.004,false),'ext math log2 58')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.00010001659393310547,0.25,0.75,1.0,2.0,5.0,8.0},np.float16)
 local r=np.log10(a)
 assert(r.dtype=='float16','ext math dtype 59')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),(0/0),-math.huge,-math.huge,-4.0,-0.60205078125,-0.12493896484375,0.0,0.301025390625,0.69873046875,0.9033203125},0.004,false),'ext math log10 59')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.00010001659393310547,0.25,0.75,1.0,2.0,5.0,8.0},np.float16)
 local r=np.expm1(a)
 assert(r.dtype=='float16','ext math dtype 60')
 assert(list_same(r:tolist(),{-0.99951171875,-0.9501953125,-0.77685546875,-0.63232421875,-0.0,0.0,0.00010001659393310547,0.283935546875,1.1171875,1.71875,6.390625,147.375,2980.0},0.004,false),'ext math expm1 60')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.00010001659393310547,0.25,0.75,1.0,2.0,5.0,8.0},np.float16)
 local r=np.log1p(a)
 assert(r.dtype=='float16','ext math dtype 61')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),-math.huge,-0.0,0.0,0.00010001659393310547,0.22314453125,0.5595703125,0.693359375,1.0986328125,1.7919921875,2.197265625},0.004,false),'ext math log1p 61')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.00010001659393310547,0.25,0.75,1.0,2.0,5.0,8.0},np.float16)
 local r=np.cbrt(a)
 assert(r.dtype=='float16','ext math dtype 62')
 assert(list_same(r:tolist(),{-2.0,-1.4423828125,-1.14453125,-1.0,-0.0,0.0,0.046417236328125,0.6298828125,0.90869140625,1.0,1.259765625,1.7099609375,2.0},0.004,false),'ext math cbrt 62')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,9.999999747378752e-05,0.25,0.75,1.0,2.0,5.0,8.0},np.float32)
 local r=np.sinh(a)
 assert(r.dtype=='float32','ext math dtype 63')
 assert(list_same(r:tolist(),{-1490.4788818359375,-10.017874717712402,-2.129279375076294,-1.175201177597046,-0.0,0.0,9.999999747378752e-05,0.25261232256889343,0.8223167657852173,1.175201177597046,3.6268603801727295,74.20320892333984,1490.4788818359375},5e-05,false),'ext math sinh 63')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,9.999999747378752e-05,0.25,0.75,1.0,2.0,5.0,8.0},np.float32)
 local r=np.cosh(a)
 assert(r.dtype=='float32','ext math dtype 64')
 assert(list_same(r:tolist(),{1490.4791259765625,10.06766128540039,2.352409601211548,1.5430806875228882,1.0,1.0,1.0,1.031413197517395,1.2946833372116089,1.5430806875228882,3.762195587158203,74.20994567871094,1490.4791259765625},5e-05,false),'ext math cosh 64')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,9.999999747378752e-05,0.25,0.75,1.0,2.0,5.0,8.0},np.float32)
 local r=np.tanh(a)
 assert(r.dtype=='float32','ext math dtype 65')
 assert(list_same(r:tolist(),{-0.9999997615814209,-0.9950547814369202,-0.9051482081413269,-0.7615941762924194,-0.0,0.0,9.999999747378752e-05,0.24491865932941437,0.6351490020751953,0.7615941762924194,0.9640275835990906,0.9999092221260071,0.9999997615814209},5e-05,false),'ext math tanh 65')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,9.999999747378752e-05,0.25,0.75,1.0,2.0,5.0,8.0},np.float32)
 local r=np.exp2(a)
 assert(r.dtype=='float32','ext math dtype 66')
 assert(list_same(r:tolist(),{0.00390625,0.125,0.3535533845424652,0.5,1.0,1.0,1.000069260597229,1.1892070770263672,1.6817928552627563,2.0,4.0,32.0,256.0},5e-05,false),'ext math exp2 66')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,9.999999747378752e-05,0.25,0.75,1.0,2.0,5.0,8.0},np.float32)
 local r=np.log2(a)
 assert(r.dtype=='float32','ext math dtype 67')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),(0/0),-math.huge,-math.huge,-13.287712097167969,-2.0,-0.41503751277923584,0.0,1.0,2.321928024291992,3.0},5e-05,false),'ext math log2 67')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,9.999999747378752e-05,0.25,0.75,1.0,2.0,5.0,8.0},np.float32)
 local r=np.log10(a)
 assert(r.dtype=='float32','ext math dtype 68')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),(0/0),-math.huge,-math.huge,-4.0,-0.6020600199699402,-0.12493874132633209,0.0,0.3010300099849701,0.6989700198173523,0.9030900001525879},5e-05,false),'ext math log10 68')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,9.999999747378752e-05,0.25,0.75,1.0,2.0,5.0,8.0},np.float32)
 local r=np.expm1(a)
 assert(r.dtype=='float32','ext math dtype 69')
 assert(list_same(r:tolist(),{-0.9996645450592041,-0.9502128958702087,-0.7768698334693909,-0.6321205496788025,-0.0,0.0,0.00010000499605666846,0.2840254306793213,1.1169999837875366,1.718281865119934,6.389056205749512,147.4131622314453,2979.9580078125},5e-05,false),'ext math expm1 69')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,9.999999747378752e-05,0.25,0.75,1.0,2.0,5.0,8.0},np.float32)
 local r=np.log1p(a)
 assert(r.dtype=='float32','ext math dtype 70')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),-math.huge,-0.0,0.0,9.999499889090657e-05,0.2231435626745224,0.5596157908439636,0.6931471824645996,1.0986123085021973,1.7917594909667969,2.1972246170043945},5e-05,false),'ext math log1p 70')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,9.999999747378752e-05,0.25,0.75,1.0,2.0,5.0,8.0},np.float32)
 local r=np.cbrt(a)
 assert(r.dtype=='float32','ext math dtype 71')
 assert(list_same(r:tolist(),{-2.0,-1.4422496557235718,-1.1447142362594604,-1.0,-0.0,0.0,0.04641588404774666,0.6299605369567871,0.9085603356361389,1.0,1.2599210739135742,1.7099759578704834,2.0},5e-05,false),'ext math cbrt 71')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.0001,0.25,0.75,1.0,2.0,5.0,8.0},np.float64)
 local r=np.sinh(a)
 assert(r.dtype=='float64','ext math dtype 72')
 assert(list_same(r:tolist(),{-1490.4788257895502,-10.017874927409903,-2.1292794550948173,-1.1752011936438014,-0.0,0.0,0.00010000000016666667,0.2526123168081683,0.82231673193583,1.1752011936438014,3.6268604078470186,74.20321057778875,1490.4788257895502},4e-12,false),'ext math sinh 72')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.0001,0.25,0.75,1.0,2.0,5.0,8.0},np.float64)
 local r=np.cosh(a)
 assert(r.dtype=='float64','ext math dtype 73')
 assert(list_same(r:tolist(),{1490.479161252178,10.067661995777765,2.352409615243247,1.5430806348152437,1.0,1.0,1.000000005,1.0314130998795732,1.2946832846768448,1.5430806348152437,3.7621956910836314,74.20994852478785,1490.479161252178},4e-12,false),'ext math cosh 73')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.0001,0.25,0.75,1.0,2.0,5.0,8.0},np.float64)
 local r=np.tanh(a)
 assert(r.dtype=='float64','ext math dtype 74')
 assert(list_same(r:tolist(),{-0.9999997749296758,-0.9950547536867305,-0.9051482536448665,-0.7615941559557649,-0.0,0.0,9.999999966666668e-05,0.24491866240370913,0.6351489523872873,0.7615941559557649,0.9640275800758169,0.9999092042625951,0.9999997749296758},4e-12,false),'ext math tanh 74')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.0001,0.25,0.75,1.0,2.0,5.0,8.0},np.float64)
 local r=np.exp2(a)
 assert(r.dtype=='float64','ext math dtype 75')
 assert(list_same(r:tolist(),{0.00390625,0.125,0.3535533905932738,0.5,1.0,1.0,1.0000693171203765,1.189207115002721,1.681792830507429,2.0,4.0,32.0,256.0},4e-12,false),'ext math exp2 75')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.0001,0.25,0.75,1.0,2.0,5.0,8.0},np.float64)
 local r=np.log2(a)
 assert(r.dtype=='float64','ext math dtype 76')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),(0/0),-math.huge,-math.huge,-13.287712379549449,-2.0,-0.4150374992788438,0.0,1.0,2.321928094887362,3.0},4e-12,false),'ext math log2 76')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.0001,0.25,0.75,1.0,2.0,5.0,8.0},np.float64)
 local r=np.log10(a)
 assert(r.dtype=='float64','ext math dtype 77')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),(0/0),-math.huge,-math.huge,-4.0,-0.6020599913279624,-0.12493873660829995,0.0,0.3010299956639812,0.6989700043360189,0.9030899869919435},4e-12,false),'ext math log10 77')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.0001,0.25,0.75,1.0,2.0,5.0,8.0},np.float64)
 local r=np.expm1(a)
 assert(r.dtype=='float64','ext math dtype 78')
 assert(list_same(r:tolist(),{-0.9996645373720975,-0.950212931632136,-0.7768698398515702,-0.6321205588285577,-0.0,0.0,0.00010000500016667084,0.2840254166877415,1.1170000166126746,1.7182818284590453,6.38905609893065,147.4131591025766,2979.9579870417283},4e-12,false),'ext math expm1 78')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.0001,0.25,0.75,1.0,2.0,5.0,8.0},np.float64)
 local r=np.log1p(a)
 assert(r.dtype=='float64','ext math dtype 79')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),-math.huge,-0.0,0.0,9.999500033330834e-05,0.22314355131420976,0.5596157879354227,0.6931471805599453,1.0986122886681098,1.791759469228055,2.1972245773362196},4e-12,false),'ext math log1p 79')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.0001,0.25,0.75,1.0,2.0,5.0,8.0},np.float64)
 local r=np.cbrt(a)
 assert(r.dtype=='float64','ext math dtype 80')
 assert(list_same(r:tolist(),{-2.0,-1.4422495703074083,-1.1447142425533319,-1.0,-0.0,0.0,0.04641588833612779,0.6299605249474366,0.9085602964160698,1.0,1.2599210498948732,1.709975946676697,2.0},4e-12,false),'ext math cbrt 80')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.0001,0.25,0.75,1.0,2.0,5.0,8.0},np.longdouble)
 local r=np.sinh(a)
 assert(r.dtype=='longdouble','ext math dtype 81')
 assert(list_same(r:tolist(),{-1490.4788257895502,-10.017874927409903,-2.1292794550948173,-1.1752011936438014,-0.0,0.0,0.00010000000016666667,0.2526123168081683,0.82231673193583,1.1752011936438014,3.6268604078470186,74.20321057778875,1490.4788257895502},4e-12,false),'ext math sinh 81')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.0001,0.25,0.75,1.0,2.0,5.0,8.0},np.longdouble)
 local r=np.cosh(a)
 assert(r.dtype=='longdouble','ext math dtype 82')
 assert(list_same(r:tolist(),{1490.479161252178,10.067661995777765,2.352409615243247,1.5430806348152437,1.0,1.0,1.000000005,1.0314130998795732,1.2946832846768448,1.5430806348152437,3.7621956910836314,74.20994852478785,1490.479161252178},4e-12,false),'ext math cosh 82')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.0001,0.25,0.75,1.0,2.0,5.0,8.0},np.longdouble)
 local r=np.tanh(a)
 assert(r.dtype=='longdouble','ext math dtype 83')
 assert(list_same(r:tolist(),{-0.9999997749296758,-0.9950547536867305,-0.9051482536448664,-0.7615941559557649,-0.0,0.0,9.999999966666667e-05,0.24491866240370913,0.6351489523872873,0.7615941559557649,0.9640275800758169,0.9999092042625951,0.9999997749296758},4e-12,false),'ext math tanh 83')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.0001,0.25,0.75,1.0,2.0,5.0,8.0},np.longdouble)
 local r=np.exp2(a)
 assert(r.dtype=='longdouble','ext math dtype 84')
 assert(list_same(r:tolist(),{0.00390625,0.125,0.3535533905932738,0.5,1.0,1.0,1.0000693171203765,1.189207115002721,1.681792830507429,2.0,4.0,32.0,256.0},4e-12,false),'ext math exp2 84')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.0001,0.25,0.75,1.0,2.0,5.0,8.0},np.longdouble)
 local r=np.log2(a)
 assert(r.dtype=='longdouble','ext math dtype 85')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),(0/0),-math.huge,-math.huge,-13.287712379549449,-2.0,-0.4150374992788438,0.0,1.0,2.321928094887362,3.0},4e-12,false),'ext math log2 85')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.0001,0.25,0.75,1.0,2.0,5.0,8.0},np.longdouble)
 local r=np.log10(a)
 assert(r.dtype=='longdouble','ext math dtype 86')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),(0/0),-math.huge,-math.huge,-4.0,-0.6020599913279624,-0.12493873660829995,0.0,0.3010299956639812,0.6989700043360189,0.9030899869919435},4e-12,false),'ext math log10 86')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.0001,0.25,0.75,1.0,2.0,5.0,8.0},np.longdouble)
 local r=np.expm1(a)
 assert(r.dtype=='longdouble','ext math dtype 87')
 assert(list_same(r:tolist(),{-0.9996645373720975,-0.950212931632136,-0.7768698398515702,-0.6321205588285577,-0.0,0.0,0.00010000500016667084,0.2840254166877415,1.1170000166126746,1.7182818284590453,6.38905609893065,147.4131591025766,2979.9579870417283},4e-12,false),'ext math expm1 87')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.0001,0.25,0.75,1.0,2.0,5.0,8.0},np.longdouble)
 local r=np.log1p(a)
 assert(r.dtype=='longdouble','ext math dtype 88')
 assert(list_same(r:tolist(),{(0/0),(0/0),(0/0),-math.huge,-0.0,0.0,9.999500033330834e-05,0.22314355131420976,0.5596157879354227,0.6931471805599453,1.0986122886681098,1.791759469228055,2.1972245773362196},4e-12,false),'ext math log1p 88')
end
do
 local a=np.array({-8.0,-3.0,-1.5,-1.0,-0.0,0.0,0.0001,0.25,0.75,1.0,2.0,5.0,8.0},np.longdouble)
 local r=np.cbrt(a)
 assert(r.dtype=='longdouble','ext math dtype 89')
 assert(list_same(r:tolist(),{-2.0,-1.4422495703074083,-1.1447142425533319,-1.0,-0.0,0.0,0.04641588833612779,0.6299605249474366,0.9085602964160698,1.0,1.2599210498948732,1.709975946676697,2.0},4e-12,false),'ext math cbrt 89')
end
do
 local a=np.reshape(np.array({2.4296875,2.83203125,-0.2083740234375,2.873046875,-1.892578125,-1.3681640625,1.0068359375,0.8447265625,-2.40625,-0.51708984375,1.3828125,2.158203125},np.float16),{3,4}).T
 local r=np.sinh(a)
 assert(r.dtype=='float16','ext strided dtype 90')
 assert(list_same(r:tolist()[1],{5.6328125,-3.2421875,-5.5},0.004,false),'ext strided row 90')
end
do
 local a=np.reshape(np.array({0.55859375,2.57421875,-3.84375,2.349609375,2.8359375,2.9765625,3.705078125,2.029296875,3.0859375,-3.115234375,2.447265625,0.974609375},np.float16),{3,4}).T
 local r=np.sinh(a)
 assert(r.dtype=='float16','ext strided dtype 91')
 assert(list_same(r:tolist()[1],{0.587890625,8.4921875,10.921875},0.004,false),'ext strided row 91')
end
do
 local a=np.reshape(np.array({-0.83251953125,-3.1015625,-3.1875,-3.091796875,0.650390625,2.65234375,1.1884765625,-1.587890625,-2.61328125,-0.208984375,-1.234375,-3.75},np.float16),{3,4}).T
 local r=np.sinh(a)
 assert(r.dtype=='float16','ext strided dtype 92')
 assert(list_same(r:tolist()[1],{-0.93212890625,0.697265625,-6.78515625},0.004,false),'ext strided row 92')
end
do
 local a=np.reshape(np.array({3.78125,-2.498046875,-1.6572265625,2.54296875,-0.58203125,1.759765625,0.90478515625,0.576171875,-0.76416015625,-0.7021484375,3.5625,0.2998046875},np.float16),{3,4}).T
 local r=np.sinh(a)
 assert(r.dtype=='float16','ext strided dtype 93')
 assert(list_same(r:tolist()[1],{21.921875,-0.615234375,-0.8408203125},0.004,false),'ext strided row 93')
end
do
 local a=np.reshape(np.array({0.3642578125,0.06610107421875,-3.24609375,-0.6484375,-3.921875,0.346923828125,1.1953125,-1.1279296875,-1.544921875,2.958984375,-1.005859375,3.6484375},np.float16),{3,4}).T
 local r=np.cosh(a)
 assert(r.dtype=='float16','ext strided dtype 94')
 assert(list_same(r:tolist()[1],{1.0673828125,25.25,2.451171875},0.004,false),'ext strided row 94')
end
do
 local a=np.reshape(np.array({-2.478515625,1.26953125,1.685546875,2.98046875,2.189453125,-3.587890625,3.861328125,-1.5625,1.8759765625,2.77734375,2.189453125,0.7138671875},np.float16),{3,4}).T
 local r=np.cosh(a)
 assert(r.dtype=='float16','ext strided dtype 95')
 assert(list_same(r:tolist()[1],{6.00390625,4.51953125,3.33984375},0.004,false),'ext strided row 95')
end
do
 local a=np.reshape(np.array({3.08203125,-1.875,3.4296875,3.017578125,3.11328125,-3.52734375,2.455078125,-2.365234375,-1.4833984375,-1.484375,2.453125,1.5029296875},np.float16),{3,4}).T
 local r=np.cosh(a)
 assert(r.dtype=='float16','ext strided dtype 96')
 assert(list_same(r:tolist()[1],{10.921875,11.2734375,2.31640625},0.004,false),'ext strided row 96')
end
do
 local a=np.reshape(np.array({-0.76904296875,0.06591796875,2.689453125,2.580078125,-0.650390625,3.54296875,-2.26953125,1.669921875,-2.91015625,-2.337890625,1.841796875,-2.80859375},np.float16),{3,4}).T
 local r=np.cosh(a)
 assert(r.dtype=='float16','ext strided dtype 97')
 assert(list_same(r:tolist()[1],{1.310546875,1.21875,9.2109375},0.004,false),'ext strided row 97')
end
do
 local a=np.reshape(np.array({-0.86962890625,1.12890625,-1.8125,3.021484375,3.064453125,3.62109375,-0.916015625,-3.27734375,0.027801513671875,-0.370849609375,-1.2900390625,-3.494140625},np.float16),{3,4}).T
 local r=np.tanh(a)
 assert(r.dtype=='float16','ext strided dtype 98')
 assert(list_same(r:tolist()[1],{-0.701171875,0.99560546875,0.027801513671875},0.004,false),'ext strided row 98')
end
do
 local a=np.reshape(np.array({1.5048828125,-0.9150390625,-2.16015625,0.9580078125,-2.041015625,0.455078125,-0.96142578125,0.2154541015625,1.3720703125,3.08203125,2.173828125,-1.701171875},np.float16),{3,4}).T
 local r=np.tanh(a)
 assert(r.dtype=='float16','ext strided dtype 99')
 assert(list_same(r:tolist()[1],{0.90625,-0.966796875,0.87939453125},0.004,false),'ext strided row 99')
end
do
 local a=np.reshape(np.array({-1.6767578125,1.8837890625,0.10589599609375,1.4140625,2.83203125,0.62744140625,-2.861328125,1.400390625,-1.6123046875,0.48828125,-3.03515625,-1.8984375},np.float16),{3,4}).T
 local r=np.tanh(a)
 assert(r.dtype=='float16','ext strided dtype 100')
 assert(list_same(r:tolist()[1],{-0.9326171875,0.9931640625,-0.92333984375},0.004,false),'ext strided row 100')
end
do
 local a=np.reshape(np.array({-0.84814453125,2.6640625,-3.390625,2.759765625,3.3359375,-1.107421875,3.056640625,-3.669921875,-2.59765625,-3.623046875,-3.615234375,-1.986328125},np.float16),{3,4}).T
 local r=np.tanh(a)
 assert(r.dtype=='float16','ext strided dtype 101')
 assert(list_same(r:tolist()[1],{-0.68994140625,0.99755859375,-0.98876953125},0.004,false),'ext strided row 101')
end
do
 local a=np.reshape(np.array({0.7587890625,-0.6708984375,2.248046875,-0.826171875,-2.552734375,-0.282470703125,0.09814453125,1.8330078125,-0.634765625,3.177734375,-2.431640625,-2.638671875},np.float16),{3,4}).T
 local r=np.exp2(a)
 assert(r.dtype=='float16','ext strided dtype 102')
 assert(list_same(r:tolist()[1],{1.6923828125,0.17041015625,0.64404296875},0.004,false),'ext strided row 102')
end
do
 local a=np.reshape(np.array({-1.205078125,-1.00390625,-0.257080078125,3.955078125,-3.41796875,-0.166748046875,-2.00390625,2.40234375,-2.41015625,-0.85107421875,-2.853515625,2.14453125},np.float16),{3,4}).T
 local r=np.exp2(a)
 assert(r.dtype=='float16','ext strided dtype 103')
 assert(list_same(r:tolist()[1],{0.433837890625,0.09356689453125,0.1881103515625},0.004,false),'ext strided row 103')
end
do
 local a=np.reshape(np.array({0.79638671875,-0.13037109375,-0.0562744140625,-1.0458984375,-2.3125,-0.73779296875,-3.1484375,-3.0703125,-3.794921875,1.5,1.50390625,-2.099609375},np.float16),{3,4}).T
 local r=np.exp2(a)
 assert(r.dtype=='float16','ext strided dtype 104')
 assert(list_same(r:tolist()[1],{1.736328125,0.2012939453125,0.072021484375},0.004,false),'ext strided row 104')
end
do
 local a=np.reshape(np.array({2.392578125,0.1533203125,1.5947265625,0.12445068359375,2.955078125,1.3916015625,2.328125,-3.05859375,0.71435546875,-0.384521484375,-0.0357666015625,1.0029296875},np.float16),{3,4}).T
 local r=np.exp2(a)
 assert(r.dtype=='float16','ext strided dtype 105')
 assert(list_same(r:tolist()[1],{5.25,7.75390625,1.640625},0.004,false),'ext strided row 105')
end
do
 local a=np.reshape(np.array({-3.27734375,-2.212890625,1.7783203125,0.185791015625,-1.17578125,-0.69873046875,3.73828125,-2.72265625,0.9345703125,0.299560546875,-0.1961669921875,-1.54296875},np.float16),{3,4}).T
 local r=np.log2(a)
 assert(r.dtype=='float16','ext strided dtype 106')
 assert(list_same(r:tolist()[1],{(0/0),(0/0),-0.09759521484375},0.004,false),'ext strided row 106')
end
do
 local a=np.reshape(np.array({-1.8583984375,3.71484375,3.935546875,0.92431640625,-2.947265625,-3.45703125,-2.279296875,2.31640625,0.06292724609375,-1.9658203125,-2.357421875,-3.51171875},np.float16),{3,4}).T
 local r=np.log2(a)
 assert(r.dtype=='float16','ext strided dtype 107')
 assert(list_same(r:tolist()[1],{(0/0),(0/0),-3.990234375},0.004,false),'ext strided row 107')
end
do
 local a=np.reshape(np.array({0.2139892578125,-0.5205078125,-2.212890625,-3.55859375,1.1728515625,3.234375,2.44921875,0.2020263671875,0.07757568359375,-1.09765625,-1.0576171875,-1.833984375},np.float16),{3,4}).T
 local r=np.log2(a)
 assert(r.dtype=='float16','ext strided dtype 108')
 assert(list_same(r:tolist()[1],{-2.224609375,0.22998046875,-3.6875},0.004,false),'ext strided row 108')
end
do
 local a=np.reshape(np.array({1.58203125,1.06640625,3.30078125,-0.19873046875,2.302734375,-2.390625,0.09051513671875,-0.685546875,-3.64453125,2.419921875,1.63671875,0.9365234375},np.float16),{3,4}).T
 local r=np.log2(a)
 assert(r.dtype=='float16','ext strided dtype 109')
 assert(list_same(r:tolist()[1],{0.66162109375,1.203125,(0/0)},0.004,false),'ext strided row 109')
end
do
 local a=np.reshape(np.array({0.70947265625,0.90478515625,-1.0556640625,1.478515625,2.822265625,2.22265625,-0.256103515625,1.3193359375,3.791015625,2.580078125,3.265625,1.0068359375},np.float16),{3,4}).T
 local r=np.log10(a)
 assert(r.dtype=='float16','ext strided dtype 110')
 assert(list_same(r:tolist()[1],{-0.1490478515625,0.45068359375,0.57861328125},0.004,false),'ext strided row 110')
end
do
 local a=np.reshape(np.array({-1.7255859375,-3.802734375,2.712890625,-3.400390625,2.609375,3.607421875,-0.2086181640625,1.1123046875,-3.40234375,-3.62109375,-1.716796875,0.1553955078125},np.float16),{3,4}).T
 local r=np.log10(a)
 assert(r.dtype=='float16','ext strided dtype 111')
 assert(list_same(r:tolist()[1],{(0/0),0.41650390625,(0/0)},0.004,false),'ext strided row 111')
end
do
 local a=np.reshape(np.array({2.626953125,-3.158203125,2.17578125,3.5625,1.5830078125,2.931640625,0.178466796875,-2.994140625,3.78125,-0.37890625,0.03692626953125,-0.59375},np.float16),{3,4}).T
 local r=np.log10(a)
 assert(r.dtype=='float16','ext strided dtype 112')
 assert(list_same(r:tolist()[1],{0.41943359375,0.199462890625,0.57763671875},0.004,false),'ext strided row 112')
end
do
 local a=np.reshape(np.array({3.95703125,-1.404296875,3.31640625,0.736328125,-2.16015625,-1.9501953125,2.0234375,-1.4150390625,2.96484375,-2.609375,0.87841796875,0.91552734375},np.float16),{3,4}).T
 local r=np.log10(a)
 assert(r.dtype=='float16','ext strided dtype 113')
 assert(list_same(r:tolist()[1],{0.59716796875,(0/0),0.471923828125},0.004,false),'ext strided row 113')
end
do
 local a=np.reshape(np.array({0.479248046875,2.173828125,-2.572265625,0.1998291015625,1.826171875,3.59375,3.58984375,-0.59033203125,0.67236328125,0.12493896484375,-1.8623046875,0.059722900390625},np.float16),{3,4}).T
 local r=np.expm1(a)
 assert(r.dtype=='float16','ext strided dtype 114')
 assert(list_same(r:tolist()[1],{0.61474609375,5.2109375,0.958984375},0.004,false),'ext strided row 114')
end
do
 local a=np.reshape(np.array({3.673828125,3.974609375,-0.57373046875,2.8984375,1.6845703125,-0.12078857421875,3.306640625,2.486328125,3.9921875,3.833984375,3.720703125,-3.12890625},np.float16),{3,4}).T
 local r=np.expm1(a)
 assert(r.dtype=='float16','ext strided dtype 115')
 assert(list_same(r:tolist()[1],{38.40625,4.390625,53.1875},0.004,false),'ext strided row 115')
end
do
 local a=np.reshape(np.array({-1.228515625,-3.4921875,0.6962890625,1.455078125,1.6318359375,-1.046875,2.44140625,-1.078125,3.25,-0.023040771484375,-0.418212890625,-1.75390625},np.float16),{3,4}).T
 local r=np.expm1(a)
 assert(r.dtype=='float16','ext strided dtype 116')
 assert(list_same(r:tolist()[1],{-0.70703125,4.11328125,24.796875},0.004,false),'ext strided row 116')
end
do
 local a=np.reshape(np.array({3.326171875,2.412109375,-3.44921875,1.65234375,-0.923828125,1.34765625,-1.1171875,2.3984375,3.08984375,-1.947265625,0.67626953125,1.5107421875},np.float16),{3,4}).T
 local r=np.expm1(a)
 assert(r.dtype=='float16','ext strided dtype 117')
 assert(list_same(r:tolist()[1],{26.828125,-0.60302734375,20.96875},0.004,false),'ext strided row 117')
end
do
 local a=np.reshape(np.array({-2.404296875,-0.65283203125,-3.34765625,2.0234375,-3.28125,-1.6142578125,-0.48828125,-2.427734375,2.451171875,3.61328125,-2.47265625,-3.837890625},np.float16),{3,4}).T
 local r=np.log1p(a)
 assert(r.dtype=='float16','ext strided dtype 118')
 assert(list_same(r:tolist()[1],{(0/0),(0/0),1.23828125},0.004,false),'ext strided row 118')
end
do
 local a=np.reshape(np.array({-0.11004638671875,-3.642578125,-2.380859375,-1.2001953125,2.564453125,2.275390625,2.6171875,-1.3330078125,-2.08984375,-2.73046875,-2.916015625,1.85546875},np.float16),{3,4}).T
 local r=np.log1p(a)
 assert(r.dtype=='float16','ext strided dtype 119')
 assert(list_same(r:tolist()[1],{-0.1165771484375,1.271484375,(0/0)},0.004,false),'ext strided row 119')
end
do
 local a=np.reshape(np.array({-1.64453125,3.50390625,-0.8427734375,2.349609375,-2.341796875,-2.630859375,-2.3515625,1.921875,-3.78515625,-1.3759765625,3.10546875,-2.947265625},np.float16),{3,4}).T
 local r=np.log1p(a)
 assert(r.dtype=='float16','ext strided dtype 120')
 assert(list_same(r:tolist()[1],{(0/0),(0/0),(0/0)},0.004,false),'ext strided row 120')
end
do
 local a=np.reshape(np.array({-2.26171875,-1.9658203125,-1.5927734375,2.9609375,-2.201171875,2.728515625,0.6142578125,1.078125,0.97265625,-3.048828125,-2.251953125,2.392578125},np.float16),{3,4}).T
 local r=np.log1p(a)
 assert(r.dtype=='float16','ext strided dtype 121')
 assert(list_same(r:tolist()[1],{(0/0),(0/0),0.67919921875},0.004,false),'ext strided row 121')
end
do
 local a=np.reshape(np.array({-1.58203125,-2.58203125,1.4443359375,-1.126953125,-1.0634765625,2.7421875,-2.572265625,-2.63671875,3.29296875,2.939453125,2.857421875,2.013671875},np.float16),{3,4}).T
 local r=np.cbrt(a)
 assert(r.dtype=='float16','ext strided dtype 122')
 assert(list_same(r:tolist()[1],{-1.1650390625,-1.0205078125,1.4873046875},0.004,false),'ext strided row 122')
end
do
 local a=np.reshape(np.array({0.693359375,0.82470703125,3.150390625,2.4296875,-3.841796875,-2.60546875,3.953125,-1.4658203125,3.837890625,-2.658203125,2.72265625,1.1591796875},np.float16),{3,4}).T
 local r=np.cbrt(a)
 assert(r.dtype=='float16','ext strided dtype 123')
 assert(list_same(r:tolist()[1],{0.88525390625,-1.56640625,1.5654296875},0.004,false),'ext strided row 123')
end
do
 local a=np.reshape(np.array({0.529296875,-2.21484375,-1.037109375,-3.263671875,1.953125,-2.0546875,-0.74560546875,1.37890625,-1.771484375,3.068359375,-3.166015625,3.353515625},np.float16),{3,4}).T
 local r=np.cbrt(a)
 assert(r.dtype=='float16','ext strided dtype 124')
 assert(list_same(r:tolist()[1],{0.80908203125,1.25,-1.2099609375},0.004,false),'ext strided row 124')
end
do
 local a=np.reshape(np.array({0.80029296875,-1.4921875,-3.19140625,3.962890625,0.09820556640625,2.76171875,-0.61474609375,-3.259765625,3.716796875,3.275390625,-3.115234375,2.466796875},np.float16),{3,4}).T
 local r=np.cbrt(a)
 assert(r.dtype=='float16','ext strided dtype 125')
 assert(list_same(r:tolist()[1],{0.92822265625,0.46142578125,1.548828125},0.004,false),'ext strided row 125')
end
do
 local a=np.reshape(np.array({-1.3191089630126953,-1.2593578100204468,-3.623868942260742,2.677255392074585,-2.7800943851470947,0.7779034376144409,-2.956078290939331,-3.8522770404815674,-2.701258420944214,3.7766480445861816,-0.8452843427658081,-1.997676968574524},np.float32),{3,4}).T
 local r=np.sinh(a)
 assert(r.dtype=='float32','ext strided dtype 126')
 assert(list_same(r:tolist()[1],{-1.7363569736480713,-8.029254913330078,-7.415673732757568},5e-05,false),'ext strided row 126')
end
do
 local a=np.reshape(np.array({2.0669164657592773,1.0388140678405762,-2.5611987113952637,2.1061484813690186,-3.5319888591766357,-3.757925271987915,3.572230815887451,-3.6498336791992188,-3.334777593612671,-3.2253196239471436,3.5657718181610107,2.5356390476226807},np.float32),{3,4}).T
 local r=np.sinh(a)
 assert(r.dtype=='float32','ext strided dtype 127')
 assert(list_same(r:tolist()[1],{3.8869245052337646,-17.081327438354492,-14.018258094787598},5e-05,false),'ext strided row 127')
end
do
 local a=np.reshape(np.array({-1.9028822183609009,-3.3504815101623535,3.5857937335968018,-3.911290407180786,-2.809075355529785,0.2794484496116638,-1.0164837837219238,0.6266810297966003,-1.4582394361495972,-2.4533753395080566,-1.586279034614563,-0.46327027678489685},np.float32),{3,4}).T
 local r=np.sinh(a)
 assert(r.dtype=='float32','ext strided dtype 128')
 assert(list_same(r:tolist()[1],{-3.278027057647705,-8.267152786254883,-2.032869815826416},5e-05,false),'ext strided row 128')
end
do
 local a=np.reshape(np.array({0.08371449261903763,1.436694622039795,-1.2748913764953613,2.8705201148986816,-1.0966403484344482,3.4623796939849854,3.12406849861145,1.9182120561599731,2.3670828342437744,2.135751247406006,0.9829879999160767,-0.7157824039459229},np.float32),{3,4}).T
 local r=np.sinh(a)
 assert(r.dtype=='float32','ext strided dtype 129')
 assert(list_same(r:tolist()[1],{0.08381230384111404,-1.3300492763519287,5.286238670349121},5e-05,false),'ext strided row 129')
end
do
 local a=np.reshape(np.array({-2.425873279571533,1.5893977880477905,-3.5991432666778564,2.7475316524505615,-2.03760027885437,3.0132081508636475,-0.4771043658256531,3.5826849937438965,-1.0181775093078613,-1.3389074802398682,3.248241662979126,1.258164644241333},np.float32),{3,4}).T
 local r=np.cosh(a)
 assert(r.dtype=='float32','ext strided dtype 130')
 assert(list_same(r:tolist()[1],{5.700252056121826,3.9012584686279297,1.5646990537643433},5e-05,false),'ext strided row 130')
end
do
 local a=np.reshape(np.array({2.305107593536377,0.37319275736808777,1.3245562314987183,-3.8343660831451416,-3.4349701404571533,-0.8738488554954529,1.183045506477356,-2.5901577472686768,2.438260316848755,1.081979751586914,-0.21797505021095276,-0.9634310007095337},np.float32),{3,4}).T
 local r=np.cosh(a)
 assert(r.dtype=='float32','ext strided dtype 131')
 assert(list_same(r:tolist()[1],{5.062502384185791,15.531356811523438,5.770205497741699},5e-05,false),'ext strided row 131')
end
do
 local a=np.reshape(np.array({-2.3771116733551025,-2.7844526767730713,1.0069059133529663,-3.2594311237335205,1.557005763053894,1.9690033197402954,-3.153242588043213,0.32396718859672546,1.724005937576294,1.8806140422821045,1.6644272804260254,2.2742881774902344},np.float32),{3,4}).T
 local r=np.cosh(a)
 assert(r.dtype=='float32','ext strided dtype 132')
 assert(list_same(r:tolist()[1],{5.433278560638428,2.477679967880249,2.8926472663879395},5e-05,false),'ext strided row 132')
end
do
 local a=np.reshape(np.array({-1.9559736251831055,-0.8252388834953308,2.4173834323883057,-2.6258745193481445,2.890887498855591,-3.514286518096924,3.544027328491211,1.0654104948043823,2.7709598541259766,-0.3207099437713623,-2.794550657272339,-2.7713072299957275},np.float32),{3,4}).T
 local r=np.cosh(a)
 assert(r.dtype=='float32','ext strided dtype 133')
 assert(list_same(r:tolist()[1],{3.6061134338378906,9.0324068069458,8.018280029296875},5e-05,false),'ext strided row 133')
end
do
 local a=np.reshape(np.array({-3.9888813495635986,-0.3374503552913666,1.275622010231018,2.632340669631958,-0.8990467190742493,-3.118495225906372,2.8792765140533447,3.516547441482544,-3.891024589538574,-1.8596067428588867,-3.6731340885162354,-1.915779709815979},np.float32),{3,4}).T
 local r=np.tanh(a)
 assert(r.dtype=='float32','ext strided dtype 134')
 assert(list_same(r:tolist()[1],{-0.9993142485618591,-0.7158333659172058,-0.9991660714149475},5e-05,false),'ext strided row 134')
end
do
 local a=np.reshape(np.array({2.9688239097595215,0.13810402154922485,1.5730549097061157,-0.8498488068580627,0.15891432762145996,3.372833013534546,2.342198133468628,-1.5576257705688477,3.5351967811584473,2.0627477169036865,-2.726104497909546,-0.02906784787774086},np.float32),{3,4}).T
 local r=np.tanh(a)
 assert(r.dtype=='float32','ext strided dtype 135')
 assert(list_same(r:tolist()[1],{0.994737446308136,0.15758998692035675,0.9983016848564148},5e-05,false),'ext strided row 135')
end
do
 local a=np.reshape(np.array({-3.3765389919281006,-0.6325200796127319,3.78943133354187,0.5587798953056335,-1.8526461124420166,-2.66343092918396,3.9923477172851562,-3.823460817337036,-2.602264165878296,3.4909005165100098,1.481402039527893,-2.6669979095458984},np.float32),{3,4}).T
 local r=np.tanh(a)
 assert(r.dtype=='float32','ext strided dtype 136')
 assert(list_same(r:tolist()[1],{-0.9976682066917419,-0.9519945383071899,-0.9890767335891724},5e-05,false),'ext strided row 136')
end
do
 local a=np.reshape(np.array({-3.1014742851257324,1.2375928163528442,-0.6701647639274597,-0.19897869229316711,-2.9797863960266113,-2.9981606006622314,-1.3090589046478271,-3.7299482822418213,1.754996418952942,1.2933320999145508,3.8585832118988037,-3.1914772987365723},np.float32),{3,4}).T
 local r=np.tanh(a)
 assert(r.dtype=='float32','ext strided dtype 137')
 assert(list_same(r:tolist()[1],{-0.9959613084793091,-0.994851291179657,0.941941499710083},5e-05,false),'ext strided row 137')
end
do
 local a=np.reshape(np.array({-0.19881173968315125,3.812453269958496,-0.660464882850647,0.45044854283332825,-2.7712531089782715,-2.4232378005981445,-3.3612897396087646,0.9393706917762756,0.1828339397907257,2.4241209030151367,0.10501974821090698,3.878739833831787},np.float32),{3,4}).T
 local r=np.exp2(a)
 assert(r.dtype=='float32','ext strided dtype 138')
 assert(list_same(r:tolist()[1],{0.8712679147720337,0.14647707343101501,1.1351114511489868},5e-05,false),'ext strided row 138')
end
do
 local a=np.reshape(np.array({0.09211106598377228,-0.8803016543388367,-2.417896032333374,2.094588279724121,-1.4757169485092163,0.4564901292324066,-1.5189317464828491,-2.0284335613250732,1.5261584520339966,-0.808042585849762,-2.3700125217437744,-3.0145463943481445},np.float32),{3,4}).T
 local r=np.exp2(a)
 assert(r.dtype=='float32','ext strided dtype 139')
 assert(list_same(r:tolist()[1],{1.0659286975860596,0.3595546782016754,2.880178928375244},5e-05,false),'ext strided row 139')
end
do
 local a=np.reshape(np.array({0.37525880336761475,-0.9067426323890686,-0.9546083807945251,-2.7621893882751465,-2.746199131011963,3.0060319900512695,-1.4867651462554932,3.2400190830230713,1.6757140159606934,-2.090850591659546,-2.5834124088287354,-1.1676908731460571},np.float32),{3,4}).T
 local r=np.exp2(a)
 assert(r.dtype=='float32','ext strided dtype 140')
 assert(list_same(r:tolist()[1],{1.2970722913742065,0.1490430384874344,3.1947743892669678},5e-05,false),'ext strided row 140')
end
do
 local a=np.reshape(np.array({0.3784092366695404,3.0768399238586426,-3.9827191829681396,0.8408739566802979,1.3891925811767578,-1.4400402307510376,-0.702459454536438,-1.4524636268615723,-2.082942247390747,0.12719792127609253,-1.5034167766571045,-3.8791215419769287},np.float32),{3,4}).T
 local r=np.exp2(a)
 assert(r.dtype=='float32','ext strided dtype 141')
 assert(list_same(r:tolist()[1],{1.2999078035354614,2.6193206310272217,0.23603256046772003},5e-05,false),'ext strided row 141')
end
do
 local a=np.reshape(np.array({0.7417343854904175,-1.5116153955459595,-0.5661221742630005,1.493833065032959,-3.771745204925537,-3.0415072441101074,1.0336050987243652,1.322677731513977,0.04622231796383858,2.8107454776763916,0.8056650757789612,3.2036826610565186},np.float32),{3,4}).T
 local r=np.log2(a)
 assert(r.dtype=='float32','ext strided dtype 142')
 assert(list_same(r:tolist()[1],{-0.4310254156589508,(0/0),-4.435266494750977},5e-05,false),'ext strided row 142')
end
do
 local a=np.reshape(np.array({-1.5250295400619507,-2.2388954162597656,0.026128681376576424,0.1165919154882431,0.9606723785400391,-2.292370319366455,1.4109888076782227,3.1604580879211426,-0.8747051358222961,-3.5865018367767334,2.4840848445892334,1.3684271574020386},np.float32),{3,4}).T
 local r=np.log2(a)
 assert(r.dtype=='float32','ext strided dtype 143')
 assert(list_same(r:tolist()[1],{(0/0),-0.05788358673453331,(0/0)},5e-05,false),'ext strided row 143')
end
do
 local a=np.reshape(np.array({3.224173069000244,2.671337842941284,2.2453927993774414,3.374717950820923,-3.7074973583221436,3.7499897480010986,1.4888774156570435,1.616721272468567,0.9624409675598145,-3.894597053527832,-3.41571307182312,0.3283362090587616},np.float32),{3,4}).T
 local r=np.log2(a)
 assert(r.dtype=='float32','ext strided dtype 144')
 assert(list_same(r:tolist()[1],{1.6889292001724243,(0/0),-0.055230043828487396},5e-05,false),'ext strided row 144')
end
do
 local a=np.reshape(np.array({-0.17261956632137299,-0.861136794090271,1.0746808052062988,1.5572279691696167,-0.9446520209312439,-3.823439359664917,1.9157506227493286,-0.8421746492385864,3.3561902046203613,3.265263557434082,3.589799404144287,3.04709792137146},np.float32),{3,4}).T
 local r=np.log2(a)
 assert(r.dtype=='float32','ext strided dtype 145')
 assert(list_same(r:tolist()[1],{(0/0),(0/0),1.7468245029449463},5e-05,false),'ext strided row 145')
end
do
 local a=np.reshape(np.array({-0.17154784500598907,1.612642526626587,2.216867685317993,3.3901636600494385,0.6668475270271301,1.5970327854156494,-2.839576005935669,-2.5976736545562744,1.7658734321594238,1.0849285125732422,1.6084716320037842,-0.37742897868156433},np.float32),{3,4}).T
 local r=np.log10(a)
 assert(r.dtype=='float32','ext strided dtype 146')
 assert(list_same(r:tolist()[1],{(0/0),-0.17597346007823944,0.24695958197116852},5e-05,false),'ext strided row 146')
end
do
 local a=np.reshape(np.array({0.1905589997768402,-0.3499521017074585,-2.6974685192108154,2.2702908515930176,-3.130387306213379,-3.608022451400757,3.0091185569763184,-0.21887367963790894,2.853074312210083,3.0586962699890137,-1.0235705375671387,0.9824090600013733},np.float32),{3,4}).T
 local r=np.log10(a)
 assert(r.dtype=='float32','ext strided dtype 147')
 assert(list_same(r:tolist()[1],{-0.7199705839157104,(0/0),0.4553130865097046},5e-05,false),'ext strided row 147')
end
do
 local a=np.reshape(np.array({1.1453816890716553,1.3631987571716309,2.13601016998291,-1.4096075296401978,-2.400376796722412,3.9619741439819336,3.695556879043579,-2.2615742683410645,2.411083936691284,-0.27613434195518494,-1.5417040586471558,-0.5938656330108643},np.float32),{3,4}).T
 local r=np.log10(a)
 assert(r.dtype=='float32','ext strided dtype 148')
 assert(list_same(r:tolist()[1],{0.058950237929821014,(0/0),0.3822123408317566},5e-05,false),'ext strided row 148')
end
do
 local a=np.reshape(np.array({-1.0153650045394897,-0.4238862991333008,-2.2764196395874023,-1.0286320447921753,-3.861062526702881,-0.7721145749092102,3.3455145359039307,-0.8068631887435913,3.549877643585205,-0.7437423467636108,-3.468482255935669,2.9512431621551514},np.float32),{3,4}).T
 local r=np.log10(a)
 assert(r.dtype=='float32','ext strided dtype 149')
 assert(list_same(r:tolist()[1],{(0/0),(0/0),0.5502133965492249},5e-05,false),'ext strided row 149')
end
do
 local a=np.reshape(np.array({-0.49341997504234314,-3.8829197883605957,0.6973481774330139,3.853652238845825,2.7179205417633057,0.5431674718856812,2.7422540187835693,-2.5110621452331543,3.3931996822357178,3.248887538909912,1.1967196464538574,2.7557296752929688},np.float32),{3,4}).T
 local r=np.expm1(a)
 assert(r.dtype=='float32','ext strided dtype 150')
 assert(list_same(r:tolist()[1],{-0.38946518301963806,14.148788452148438,28.76102638244629},5e-05,false),'ext strided row 150')
end
do
 local a=np.reshape(np.array({-3.7587080001831055,1.4134289026260376,0.28697311878204346,3.4487733840942383,3.390946865081787,3.4064228534698486,3.874221086502075,-3.183072805404663,1.5475223064422607,0.7117634415626526,-2.9498696327209473,1.324026346206665},np.float32),{3,4}).T
 local r=np.expm1(a)
 assert(r.dtype=='float32','ext strided dtype 151')
 assert(list_same(r:tolist()[1],{-0.9766861796379089,28.694055557250977,3.6998109817504883},5e-05,false),'ext strided row 151')
end
do
 local a=np.reshape(np.array({-0.09549464285373688,3.060506820678711,-2.7019665241241455,-3.623783588409424,3.435072660446167,-2.770155429840088,-1.013046145439148,3.0999159812927246,-2.922429084777832,2.7855613231658936,1.6789509057998657,-2.17673659324646},np.float32),{3,4}).T
 local r=np.expm1(a)
 assert(r.dtype=='float32','ext strided dtype 152')
 assert(list_same(r:tolist()[1],{-0.09107676893472672,30.033666610717773,-0.9461971521377563},5e-05,false),'ext strided row 152')
end
do
 local a=np.reshape(np.array({-1.7629982233047485,-3.6612606048583984,3.6938424110412598,-1.8859964609146118,-0.5706217885017395,-3.630505084991455,2.2567806243896484,0.5243828296661377,2.2144994735717773,3.5163638591766357,-0.5139456391334534,2.8493971824645996},np.float32),{3,4}).T
 local r=np.expm1(a)
 assert(r.dtype=='float32','ext strided dtype 153')
 assert(list_same(r:tolist()[1],{-0.8284701704978943,-0.4348260760307312,8.156825065612793},5e-05,false),'ext strided row 153')
end
do
 local a=np.reshape(np.array({3.15576171875,-0.22131729125976562,2.2060561180114746,0.8658204078674316,0.19587862491607666,2.016469955444336,2.652508020401001,-2.6203396320343018,-3.5929908752441406,3.9199845790863037,0.48135682940483093,0.4927637279033661},np.float32),{3,4}).T
 local r=np.log1p(a)
 assert(r.dtype=='float32','ext strided dtype 154')
 assert(list_same(r:tolist()[1],{1.4244956970214844,0.17888116836547852,(0/0)},5e-05,false),'ext strided row 154')
end
do
 local a=np.reshape(np.array({1.4454454183578491,2.3121047019958496,0.9079694747924805,1.222285509109497,0.877301812171936,1.4334492683410645,1.1250066757202148,-2.3283188343048096,-1.9266527891159058,-2.78100323677063,-3.8374273777008057,-3.5816476345062256},np.float32),{3,4}).T
 local r=np.log1p(a)
 assert(r.dtype=='float32','ext strided dtype 155')
 assert(list_same(r:tolist()[1],{0.8942272663116455,0.6298355460166931,(0/0)},5e-05,false),'ext strided row 155')
end
do
 local a=np.reshape(np.array({-1.133471965789795,3.490905523300171,0.630890429019928,2.6233723163604736,-1.8282147645950317,-1.4417592287063599,-2.620441198348999,3.171065092086792,0.9397047162055969,1.2580217123031616,1.2403128147125244,-3.9886319637298584},np.float32),{3,4}).T
 local r=np.log1p(a)
 assert(r.dtype=='float32','ext strided dtype 156')
 assert(list_same(r:tolist()[1],{(0/0),(0/0),0.6625357270240784},5e-05,false),'ext strided row 156')
end
do
 local a=np.reshape(np.array({-3.6528780460357666,-2.526470899581909,-2.115847587585449,1.0538452863693237,-1.5213086605072021,-1.0698411464691162,0.4807966351509094,2.0730819702148438,1.2746518850326538,1.552133321762085,-2.9041953086853027,3.25551438331604},np.float32),{3,4}).T
 local r=np.log1p(a)
 assert(r.dtype=='float32','ext strided dtype 157')
 assert(list_same(r:tolist()[1],{(0/0),(0/0),0.8218270540237427},5e-05,false),'ext strided row 157')
end
do
 local a=np.reshape(np.array({2.051689386367798,2.333648681640625,-0.8075530529022217,1.8730568885803223,-0.20512816309928894,-0.30705177783966064,0.8987372517585754,-3.493178129196167,1.2725437879562378,-0.8478277921676636,-3.273587465286255,3.3021461963653564},np.float32),{3,4}).T
 local r=np.cbrt(a)
 assert(r.dtype=='float32','ext strided dtype 158')
 assert(list_same(r:tolist()[1],{1.27068293094635,-0.5897596478462219,1.0836546421051025},5e-05,false),'ext strided row 158')
end
do
 local a=np.reshape(np.array({-0.5368195176124573,-1.424716591835022,-3.9656834602355957,3.9150986671447754,1.2028754949569702,-1.0059690475463867,0.8888214826583862,3.5183322429656982,-2.81091046333313,0.062398865818977356,-3.286111354827881,1.9636523723602295},np.float32),{3,4}).T
 local r=np.cbrt(a)
 assert(r.dtype=='float32','ext strided dtype 159')
 assert(list_same(r:tolist()[1],{-0.8127233982086182,1.0635067224502563,-1.4112881422042847},5e-05,false),'ext strided row 159')
end
do
 local a=np.reshape(np.array({3.5829432010650635,-3.3523995876312256,-2.741360902786255,2.6662216186523438,-1.4770305156707764,0.6509234309196472,-0.06711318343877792,-2.719115734100342,-3.596628427505493,-0.010497253388166428,2.4114904403686523,-2.7153220176696777},np.float32),{3,4}).T
 local r=np.cbrt(a)
 assert(r.dtype=='float32','ext strided dtype 160')
 assert(list_same(r:tolist()[1],{1.5301945209503174,-1.138841152191162,-1.5321402549743652},5e-05,false),'ext strided row 160')
end
do
 local a=np.reshape(np.array({2.602351665496826,0.773282527923584,2.71598744392395,-0.45134299993515015,0.6373559236526489,-1.1247516870498657,3.611565589904785,1.6990628242492676,-0.8240907192230225,0.1728982776403427,3.3185348510742188,-0.04475950077176094},np.float32),{3,4}).T
 local r=np.cbrt(a)
 assert(r.dtype=='float32','ext strided dtype 161')
 assert(list_same(r:tolist()[1],{1.3754832744598389,0.8605854511260986,-0.9375439882278442},5e-05,false),'ext strided row 161')
end
do
 local a=np.reshape(np.array({3.9607647597266915,3.237221217443624,0.9951302134247326,2.7529616297057515,2.0197831052961224,-3.0197369190426704,-3.837637813526247,2.5762137862351766,-0.8965245172256964,-0.029495146818248053,-3.5045630537949313,-0.6408554223946927},np.float64),{3,4}).T
 local r=np.sinh(a)
 assert(r.dtype=='float64','ext strided dtype 162')
 assert(list_same(r:tolist()[1],{26.239205001066015,3.702002923870166,-1.0215422482785605},4e-12,false),'ext strided row 162')
end
do
 local a=np.reshape(np.array({-2.2175231034090537,-1.856486749246871,2.1686573346946423,-0.18045704654273553,0.5604035624858952,-1.432697430524386,-1.0711907235620792,2.778389467035357,1.4540109945560928,-3.107818681029258,-2.048972140020905,1.75607353264557},np.float64),{3,4}).T
 local r=np.sinh(a)
 assert(r.dtype=='float64','ext strided dtype 163')
 assert(list_same(r:tolist()[1],{-4.537837511958972,0.5902002784069953,2.023308435258465},4e-12,false),'ext strided row 163')
end
do
 local a=np.reshape(np.array({-3.313752592066832,-3.439820272226574,0.27202332374732663,-3.301658231359398,-2.0604094564883066,-2.7594211510537168,2.2016100161804157,2.515696029160215,-0.5652775466134585,3.2177999611259898,1.7492203817371728,-3.1305596052419276},np.float64),{3,4}).T
 local r=np.sinh(a)
 assert(r.dtype=='float64','ext strided dtype 164')
 assert(list_same(r:tolist()[1],{-13.7258521678108,-3.8608906288190465,-0.5958668785280915},4e-12,false),'ext strided row 164')
end
do
 local a=np.reshape(np.array({0.6986857342375705,1.130701288536602,-1.7383809089603304,-2.456563501878155,2.251601238421167,-3.3004186100833044,-2.784473499414723,-3.518974779739013,0.3898574759551332,-2.754572481709321,-2.448452544682392,-3.340423888208571},np.float64),{3,4}).T
 local r=np.sinh(a)
 assert(r.dtype=='float64','ext strided dtype 165')
 assert(list_same(r:tolist()[1],{0.756934730863292,4.698854771395634,0.39980846267330705},4e-12,false),'ext strided row 165')
end
do
 local a=np.reshape(np.array({0.9282780241203596,-2.7007495771318055,-0.9705106263047165,0.6359848743598615,3.9517357264578648,1.5576246006812235,-2.9471518670337638,-2.116451458061137,-0.7529941081708849,-0.720618016277693,-2.2660770166413426,-1.857153188457727},np.float64),{3,4}).T
 local r=np.cosh(a)
 assert(r.dtype=='float64','ext strided dtype 166')
 assert(list_same(r:tolist()[1],{1.4626911385506611,26.022406007170332,1.2971511968190865},4e-12,false),'ext strided row 166')
end
do
 local a=np.reshape(np.array({2.2254563573941653,1.7559632515202157,-2.12236539871368,1.2128187504395003,-3.6531858300665547,-3.2408402630778,3.983819807473947,0.1525286015522047,-3.5037557464749565,2.7993142465485352,1.6256733997537758,1.6010216901964327},np.float64),{3,4}).T
 local r=np.cosh(a)
 assert(r.dtype=='float64','ext strided dtype 167')
 assert(list_same(r:tolist()[1],{4.682862387724153,19.311671855612325,16.635071616460042},4e-12,false),'ext strided row 167')
end
do
 local a=np.reshape(np.array({3.533014815303587,-3.2085265672172563,3.8286229575618247,2.3316561012817987,3.7267734160915014,2.0423626128284154,3.9988112404105713,2.7310542184531554,-2.8493888140234374,0.343761309407288,-1.5758253336831647,-1.838146642678696},np.float64),{3,4}).T
 local r=np.cosh(a)
 assert(r.dtype=='float64','ext strided dtype 168')
 assert(list_same(r:tolist()[1],{17.128108504386226,20.784457062126897,8.667549352156218},4e-12,false),'ext strided row 168')
end
do
 local a=np.reshape(np.array({2.344575308067884,2.0775165705233416,1.7752187437623768,-3.0430828811511415,3.417982453603586,-2.64160518875659,-0.22631643675656044,1.884457360158807,2.018786916760739,-2.956561593848888,-2.5352419338385657,2.9829971207243107},np.float64),{3,4}).T
 local r=np.cosh(a)
 assert(r.dtype=='float64','ext strided dtype 169')
 assert(list_same(r:tolist()[1],{5.262365328930519,15.270290241416294,3.8310011736137364},4e-12,false),'ext strided row 169')
end
do
 local a=np.reshape(np.array({-2.9778749784901715,-0.11627716741703065,1.7807481334309845,-2.9651720337798944,3.878944000608027,-1.2669293542080498,1.3124575056213548,-3.4672741585679008,-2.635371543052231,-0.19989982177581922,2.865683561010796,-1.466659545699068},np.float64),{3,4}).T
 local r=np.tanh(a)
 assert(r.dtype=='float64','ext strided dtype 170')
 assert(list_same(r:tolist()[1],{-0.994831590747269,0.9991456486975449,-0.9897729850133424},4e-12,false),'ext strided row 170')
end
do
 local a=np.reshape(np.array({-3.917444373709725,-1.0200423620196473,2.573900783994186,3.1051332220243495,-1.6288245604718137,-0.6260757756227786,-2.4659129194049045,2.3709162213303925,-1.9798912144070862,-0.8748648547033735,-2.304956665147813,-0.007247066886198361},np.float64),{3,4}).T
 local r=np.tanh(a)
 assert(r.dtype=='float64','ext strided dtype 171')
 assert(list_same(r:tolist()[1],{-0.9992089403442745,-0.9258940047903211,-0.962578991530588},4e-12,false),'ext strided row 171')
end
do
 local a=np.reshape(np.array({-1.868687158772536,-3.3861009165372264,-3.169094379108251,2.786922487250439,-0.3449150140553128,3.9349668859505806,-0.40281406676554266,1.5142969522872276,3.1840213821386634,-3.5475024369578625,-1.4126113298928695,0.74386456627259},np.float64),{3,4}).T
 local r=np.tanh(a)
 assert(r.dtype=='float64','ext strided dtype 172')
 assert(list_same(r:tolist()[1],{-0.9534749547028203,-0.3318582291842432,0.9965748486809899},4e-12,false),'ext strided row 172')
end
do
 local a=np.reshape(np.array({-2.8564435983317225,2.87909166091619,-3.9092190781589125,-3.23355830132999,0.33868219187320303,0.16912936784908972,-0.3739281322162986,-3.6678488137556133,2.7525840093692207,2.5749988002365916,0.7712939549928004,3.419356141914932},np.float64),{3,4}).T
 local r=np.tanh(a)
 assert(r.dtype=='float64','ext strided dtype 173')
 assert(list_same(r:tolist()[1],{-0.9934155053859011,0.32630040307624103,0.9919015152357191},4e-12,false),'ext strided row 173')
end
do
 local a=np.reshape(np.array({0.3885727893572959,0.10638022544033543,-2.6194832510991617,-2.3940199121599566,-3.2205884554841644,3.603776367583059,-0.5632553499323718,3.0565698883327252,3.0983539454023035,-0.31660866575616975,1.6599312050745745,-1.5207958166051405},np.float64),{3,4}).T
 local r=np.exp2(a)
 assert(r.dtype=='float64','ext strided dtype 174')
 assert(list_same(r:tolist()[1],{1.3090977158599724,0.10727691385046506,8.56441049010752},4e-12,false),'ext strided row 174')
end
do
 local a=np.reshape(np.array({3.578943090907197,3.8887335851311846,-2.1621128231886484,1.6823896669325933,3.2201174244694277,1.8310357505648867,-1.7141501599978364,-3.9940113134814528,-2.9207785363513414,2.7446373250842173,-1.0990629270732333,-2.6887475498335824},np.float64),{3,4}).T
 local r=np.exp2(a)
 assert(r.dtype=='float64','ext strided dtype 175')
 assert(list_same(r:tolist()[1],{11.950036261963152,9.31862712668027,0.1320559731166974},4e-12,false),'ext strided row 175')
end
do
 local a=np.reshape(np.array({2.7314464744741747,-1.581226582112473,-1.3372787598819382,0.9966831534969955,-0.6188440949299263,-0.7274123958018892,-1.6687507532693067,-3.8171389285599684,-3.8054382233401007,2.9666850764732517,2.3626709196674156,3.512351077394386},np.float64),{3,4}).T
 local r=np.exp2(a)
 assert(r.dtype=='float64','ext strided dtype 176')
 assert(list_same(r:tolist()[1],{6.641211639249028,0.6511924621997727,0.07152353123080422},4e-12,false),'ext strided row 176')
end
do
 local a=np.reshape(np.array({-1.2452827083163376,2.2887143857210495,2.2702435057043973,-2.274847536115071,2.6692920871496257,2.211880525758456,-2.5181921285446203,3.922947987437613,0.6650341916212286,-3.2064859280623734,-3.7555313958463383,-2.827188989581865},np.float64),{3,4}).T
 local r=np.exp2(a)
 assert(r.dtype=='float64','ext strided dtype 177')
 assert(list_same(r:tolist()[1],{0.4218252297378588,6.361169755740844,1.5856058513578188},4e-12,false),'ext strided row 177')
end
do
 local a=np.reshape(np.array({-0.20782749231943143,2.337267493637234,-3.502426822362647,3.3590548396988877,-1.415499748312925,-2.8400400331821007,-3.2129460733700075,0.7859655638603442,-3.5084224602325325,-3.0603960059052424,-1.3391301957465087,1.4256284997413537},np.float64),{3,4}).T
 local r=np.log2(a)
 assert(r.dtype=='float64','ext strided dtype 178')
 assert(list_same(r:tolist()[1],{(0/0),(0/0),(0/0)},4e-12,false),'ext strided row 178')
end
do
 local a=np.reshape(np.array({0.2305211654475885,3.2070450323278132,1.426589841504975,1.9938318721370738,1.2414922370422259,3.026788654061244,-3.452247026159446,-2.1366179591699668,-0.7108692594391224,0.25745313738251596,-1.3786702362136989,-2.672455058315216},np.float64),{3,4}).T
 local r=np.log2(a)
 assert(r.dtype=='float64','ext strided dtype 179')
 assert(list_same(r:tolist()[1],{-2.117028876187531,0.312075240479153,(0/0)},4e-12,false),'ext strided row 179')
end
do
 local a=np.reshape(np.array({-1.334930949066135,-1.1827336948972444,-1.5237264378418063,-0.0148189166712962,-1.794614145161094,-1.5618290505077415,-3.217327434272116,-0.13045420078867753,0.9461680939546149,-0.614402653660937,0.37195789595530826,-2.4294405335685205},np.float64),{3,4}).T
 local r=np.log2(a)
 assert(r.dtype=='float64','ext strided dtype 180')
 assert(list_same(r:tolist()[1],{(0/0),(0/0),-0.07983158281135182},4e-12,false),'ext strided row 180')
end
do
 local a=np.reshape(np.array({-3.6731901794147985,3.1581151386245745,1.4005550345219175,3.869700602104171,3.7980385314892535,1.7912224980511295,3.673028312327114,2.0983422003649066,0.12720793461151203,-1.0399231179901856,-1.099966413712382,2.103118666533229},np.float64),{3,4}).T
 local r=np.log2(a)
 assert(r.dtype=='float64','ext strided dtype 181')
 assert(list_same(r:tolist()[1],{(0/0),1.9252545418503604,-2.974739433167128},4e-12,false),'ext strided row 181')
end
do
 local a=np.reshape(np.array({0.7430545080145023,-3.2800694883529573,0.3619895710513097,0.19341383113594635,-1.9818398857571902,1.1777465297974654,-0.2967881860812067,2.1824158120421053,3.7631732683806725,2.2034082243301807,-2.329281794208396,1.6284269103948361},np.float64),{3,4}).T
 local r=np.log10(a)
 assert(r.dtype=='float64','ext strided dtype 182')
 assert(list_same(r:tolist()[1],{-0.12897932666792067,(0/0),0.575554215069592},4e-12,false),'ext strided row 182')
end
do
 local a=np.reshape(np.array({3.8785112263429857,1.4892898108740944,-1.0851279047053346,2.904537162574801,-2.6846217581824225,2.547359933190327,-3.80558035415274,-1.4612742108084538,2.090803609035854,-2.079197564138072,-2.844352911184922,0.7758303122507133},np.float64),{3,4}).T
 local r=np.log10(a)
 assert(r.dtype=='float64','ext strided dtype 183')
 assert(list_same(r:tolist()[1],{0.5886650528465325,(0/0),0.32031324108278375},4e-12,false),'ext strided row 183')
end
do
 local a=np.reshape(np.array({-3.6898891511025793,1.8378277084290255,3.173626739074371,0.3969992822992383,-2.4727602717592996,-0.48431478684760876,3.0105396079567637,-0.09728976267328093,-3.8116480437955067,2.2375609462465897,0.2629579997497551,-2.6914714459547637},np.float64),{3,4}).T
 local r=np.log10(a)
 assert(r.dtype=='float64','ext strided dtype 184')
 assert(list_same(r:tolist()[1],{(0/0),(0/0),(0/0)},4e-12,false),'ext strided row 184')
end
do
 local a=np.reshape(np.array({-2.497795057795349,-2.623216804732654,3.784367748910502,0.6112736716903102,-3.1282219831288867,0.03191866707369595,-1.4326194807637131,0.5209845213763318,-3.6583250904814557,1.4637446298026004,2.4760509059479423,-1.1086992788604064},np.float64),{3,4}).T
 local r=np.log10(a)
 assert(r.dtype=='float64','ext strided dtype 185')
 assert(list_same(r:tolist()[1],{(0/0),(0/0),(0/0)},4e-12,false),'ext strided row 185')
end
do
 local a=np.reshape(np.array({3.310440417037171,1.6038564057108466,0.6881629060265073,-2.1233159616321187,0.507321805831392,-0.9209786789038841,-3.0852567807860165,1.883286485543211,-3.491623714519446,0.9322695908979837,-0.8606754974779758,3.823531091430902},np.float64),{3,4}).T
 local r=np.expm1(a)
 assert(r.dtype=='float64','ext strided dtype 186')
 assert(list_same(r:tolist()[1],{26.397189004023648,0.6608371887874875,-0.9695486123525409},4e-12,false),'ext strided row 186')
end
do
 local a=np.reshape(np.array({-3.3661477518900718,-3.185215408407073,-3.107534664089415,-1.613501665384761,-2.9556592711142047,2.9097904532053143,-0.5761404733088646,-3.6445579292019534,-1.0688007879047072,1.5221047310569,1.4381936680496352,3.646521980120964},np.float64),{3,4}).T
 local r=np.expm1(a)
 assert(r.dtype=='float64','ext strided dtype 187')
 assert(list_same(r:tolist()[1],{-0.9654776297451606,-0.9479556620654124,-0.6565798958778655},4e-12,false),'ext strided row 187')
end
do
 local a=np.reshape(np.array({0.7879705538258905,1.1695025684311195,3.260353518042468,-1.480561733772551,3.5618626496232277,2.9488160656691678,-0.426479061642314,0.26458602531893494,-0.9273917598365093,3.666687481911805,3.0116599929629704,0.25581986338442864},np.float64),{3,4}).T
 local r=np.expm1(a)
 assert(r.dtype=='float64','ext strided dtype 188')
 assert(list_same(r:tolist()[1],{1.1989292862519363,34.22875489762776,-0.6044158555687663},4e-12,false),'ext strided row 188')
end
do
 local a=np.reshape(np.array({1.9721801472735203,3.600973379455491,-1.520450722206908,-0.9240287414368824,-0.3347377801020448,0.07210029841930954,-0.16175904517602113,-2.4593929475317413,-2.3330259849171044,3.5255456072810336,3.2211128969076794,0.6866947860892783},np.float64),{3,4}).T
 local r=np.expm1(a)
 assert(r.dtype=='float64','ext strided dtype 189')
 assert(list_same(r:tolist()[1],{6.186326672796626,-0.28447431317221944,-0.9029982233742501},4e-12,false),'ext strided row 189')
end
do
 local a=np.reshape(np.array({-2.5807265318899475,-1.7425424755048633,0.8250268279505475,0.25755357243719956,1.6942602532398965,-1.8995102703462798,-2.846841582319896,-0.7158670841074075,-0.43321359893122136,-3.3414281839700175,3.5440913625020176,0.6788490473853939},np.float64),{3,4}).T
 local r=np.log1p(a)
 assert(r.dtype=='float64','ext strided dtype 190')
 assert(list_same(r:tolist()[1],{(0/0),0.9911236780883409,-0.5677727639220689},4e-12,false),'ext strided row 190')
end
do
 local a=np.reshape(np.array({0.6327887169360462,-1.0059309509960404,-3.470159615194344,-3.789793846406379,-2.492721430837501,-0.6367099060771535,-0.6997727237896418,-2.379556205507324,0.21322793587065902,-1.635127403099605,-3.6956843941819466,1.8454837187974453},np.float64),{3,4}).T
 local r=np.log1p(a)
 assert(r.dtype=='float64','ext strided dtype 191')
 assert(list_same(r:tolist()[1],{0.4902894222348733,(0/0),0.19328452316680095},4e-12,false),'ext strided row 191')
end
do
 local a=np.reshape(np.array({1.6733907345291374,-1.3569558659631102,0.6956302939770191,1.7286959187062072,3.9417803025612033,-2.5312977083674344,1.3941487098705716,1.805260448425119,1.0337530836452578,2.0235692833221286,-0.5614117201183202,-2.686219990958989},np.float64),{3,4}).T
 local r=np.log1p(a)
 assert(r.dtype=='float64','ext strided dtype 192')
 assert(list_same(r:tolist()[1],{0.9833476047488023,1.5977256514105533,0.709882895786105},4e-12,false),'ext strided row 192')
end
do
 local a=np.reshape(np.array({-1.518115933112342,0.15944141861295336,-3.712408202469728,-2.549903587367603,2.2697351474732077,2.037133306509549,2.268980192582055,1.9383964862165444,-2.3987326968194873,-0.9070738267314509,0.7912932790084479,2.854026517737898},np.float64),{3,4}).T
 local r=np.log1p(a)
 assert(r.dtype=='float64','ext strided dtype 193')
 assert(list_same(r:tolist()[1],{(0/0),1.1847089869724063,(0/0)},4e-12,false),'ext strided row 193')
end
do
 local a=np.reshape(np.array({2.940750969787369,-1.3737889720951078,-3.4088599718916592,-0.25251648788644054,1.3498754815270946,2.347544930872119,-1.6177871354012838,3.417932370676578,3.085252064454881,0.9053137646274596,-2.101206856395403,3.0206157367371995},np.float64),{3,4}).T
 local r=np.cbrt(a)
 assert(r.dtype=='float64','ext strided dtype 194')
 assert(list_same(r:tolist()[1],{1.432691715618782,1.1051754685490893,1.4557838054709107},4e-12,false),'ext strided row 194')
end
do
 local a=np.reshape(np.array({-2.0123442707357233,-1.435384809143316,0.3871294543095605,1.2525000647778324,-0.2705837742001398,3.0192066281558905,3.8653903000716374,3.673361272828319,2.4977460363177215,3.531636355897029,-0.5813764283279017,1.6368181534302773},np.float64),{3,4}).T
 local r=np.cbrt(a)
 assert(r.dtype=='float64','ext strided dtype 195')
 assert(list_same(r:tolist()[1],{-1.2625078695293748,-0.6467958877640633,1.3568008057413938},4e-12,false),'ext strided row 195')
end
do
 local a=np.reshape(np.array({3.472262141871129,-2.127568902060334,-3.9021470924735127,-0.6343809216765344,3.2985378936579073,-2.223347619886578,3.5598587683861744,1.890559896299191,0.9849908540885366,-0.6276253556298412,0.7918661263241225,2.7625958543549602},np.float64),{3,4}).T
 local r=np.cbrt(a)
 assert(r.dtype=='float64','ext strided dtype 196')
 assert(list_same(r:tolist()[1],{1.5142729637764976,1.488585642488649,0.9949717100408572},4e-12,false),'ext strided row 196')
end
do
 local a=np.reshape(np.array({2.3107337715287013,3.21280215634071,-3.4849983961580726,-0.10951111570696792,-2.871614098463862,3.0004609670412448,-1.894501578310659,-0.5256079057062841,-1.4547777881121373,2.883645625107227,-2.1319364028478986,3.6739336772007833},np.float64),{3,4}).T
 local r=np.cbrt(a)
 assert(r.dtype=='float64','ext strided dtype 197')
 assert(list_same(r:tolist()[1],{1.322056362387719,-1.4213750646439305,-1.1330929928557198},4e-12,false),'ext strided row 197')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex((0/0),0.0),np.complex(1.0,(0/0)),np.complex((0/0),2.0)},np.complex64)
 local r=np.sinh(a)
 assert(r.dtype=='complex64','ext complex dtype 198')
 assert(list_same(r:tolist(),{np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,(0/0)),np.complex((0/0),0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},0.00015000000000000001,true),'ext complex sinh 198')
end
do
 local a=np.array({np.complex(3.0,0.0),np.complex(0.25,-1.0),np.complex(-2.0,-0.0),np.complex(5.0,3.0),np.complex(0.25,-3.0),np.complex(1.0,3.0),np.complex(-5.0,-1.0),np.complex(-0.0,-3.0),np.complex(-1.0,0.5)},np.complex64)
 local r=np.sinh(a)
 assert(r.dtype=='complex64','ext complex dtype 199')
 assert(list_same(r:tolist(),{np.complex(10.017874717712402,0.0),np.complex(0.13648700714111328,-0.8679041266441345),np.complex(-3.6268603801727295,-0.0),np.complex(-73.46061706542969,10.47250747680664),np.complex(-0.2500843107700348,-0.14555302262306213),np.complex(-1.1634403467178345,0.21775954961776733),np.complex(-40.0921630859375,-62.44551467895508),np.complex(0.0,-0.14112000167369843),np.complex(-1.0313360691070557,0.7397922873497009)},0.00015000000000000001,true),'ext complex sinh 199')
end
do
 local a=np.array({np.complex(-1.0,-3.0),np.complex(0.25,0.5),np.complex(3.0,2.0),np.complex(0.25,2.0),np.complex(-0.0,-3.0),np.complex(-0.0,0.0),np.complex(-5.0,2.0),np.complex(0.25,-3.0),np.complex(-5.0,0.5)},np.complex64)
 local r=np.sinh(a)
 assert(r.dtype=='complex64','ext complex dtype 200')
 assert(list_same(r:tolist(),{np.complex(1.1634403467178345,-0.21775954961776733),np.complex(0.2216881662607193,0.4944857954978943),np.complex(-4.168907165527344,9.154499053955078),np.complex(-0.10512381792068481,0.9378612637519836),np.complex(0.0,-0.14112000167369843),np.complex(-0.0,0.0),np.complex(30.879430770874023,67.47891235351562),np.complex(-0.2500843107700348,-0.14555302262306213),np.complex(-65.11943817138672,35.57814407348633)},0.00015000000000000001,true),'ext complex sinh 200')
end
do
 local a=np.array({np.complex(-5.0,3.0),np.complex(0.25,-1.0),np.complex(-1.0,0.0),np.complex(-5.0,-1.0),np.complex(0.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,0.5),np.complex(3.0,0.0),np.complex(-2.0,0.5)},np.complex64)
 local r=np.sinh(a)
 assert(r.dtype=='complex64','ext complex dtype 201')
 assert(list_same(r:tolist(),{np.complex(73.46061706542969,10.47250747680664),np.complex(0.13648700714111328,-0.8679041266441345),np.complex(-1.175201177597046,0.0),np.complex(-40.0921630859375,-62.44551467895508),np.complex(0.0,0.0),np.complex(-1.175201177597046,0.0),np.complex(0.0,0.4794255495071411),np.complex(10.017874717712402,0.0),np.complex(-3.1828694343566895,1.8036926984786987)},0.00015000000000000001,true),'ext complex sinh 201')
end
do
 local a=np.array({np.complex(1.0,-1.0),np.complex(-1.0,2.0),np.complex(3.0,2.0),np.complex(5.0,3.0),np.complex(-5.0,-0.0),np.complex(5.0,-1.0),np.complex(3.0,3.0),np.complex(-5.0,0.0),np.complex(5.0,-1.0)},np.complex64)
 local r=np.sinh(a)
 assert(r.dtype=='complex64','ext complex dtype 202')
 assert(list_same(r:tolist(),{np.complex(0.634963870048523,-1.2984576225280762),np.complex(0.489056259393692,1.4031193256378174),np.complex(-4.168907165527344,9.154499053955078),np.complex(-73.46061706542969,10.47250747680664),np.complex(-74.20320892333984,-0.0),np.complex(40.0921630859375,-62.44551467895508),np.complex(-9.917620658874512,1.4207484722137451),np.complex(-74.20320892333984,0.0),np.complex(40.0921630859375,-62.44551467895508)},0.00015000000000000001,true),'ext complex sinh 202')
end
do
 local a=np.array({np.complex(-0.0,0.5),np.complex(0.0,-1.0),np.complex(3.0,0.0),np.complex(0.25,-0.0),np.complex(1.0,-3.0),np.complex(5.0,2.0),np.complex(-1.0,0.0),np.complex(3.0,-3.0),np.complex(0.25,2.0)},np.complex64)
 local r=np.sinh(a)
 assert(r.dtype=='complex64','ext complex dtype 203')
 assert(list_same(r:tolist(),{np.complex(-0.0,0.4794255495071411),np.complex(0.0,-0.8414709568023682),np.complex(10.017874717712402,0.0),np.complex(0.25261232256889343,-0.0),np.complex(-1.1634403467178345,-0.21775954961776733),np.complex(-30.879430770874023,67.47891235351562),np.complex(-1.175201177597046,0.0),np.complex(-9.917620658874512,-1.4207484722137451),np.complex(-0.10512381792068481,0.9378612637519836)},0.00015000000000000001,true),'ext complex sinh 203')
end
do
 local a=np.array({np.complex(5.0,-3.0),np.complex(-5.0,0.0),np.complex(0.25,-1.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(-5.0,-1.0),np.complex(0.25,3.0),np.complex(-0.0,3.0),np.complex(-5.0,-3.0)},np.complex64)
 local r=np.sinh(a)
 assert(r.dtype=='complex64','ext complex dtype 204')
 assert(list_same(r:tolist(),{np.complex(-73.46061706542969,-10.47250747680664),np.complex(-74.20320892333984,0.0),np.complex(0.13648700714111328,-0.8679041266441345),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(-40.0921630859375,-62.44551467895508),np.complex(-0.2500843107700348,0.14555302262306213),np.complex(0.0,0.14112000167369843),np.complex(73.46061706542969,-10.47250747680664)},0.00015000000000000001,true),'ext complex sinh 204')
end
do
 local a=np.array({np.complex(1.0,-1.0),np.complex(1.0,3.0),np.complex(1.0,2.0),np.complex(-5.0,-3.0),np.complex(0.25,0.0),np.complex(0.0,-3.0),np.complex(-1.0,0.5),np.complex(-0.0,3.0),np.complex(5.0,0.0)},np.complex64)
 local r=np.sinh(a)
 assert(r.dtype=='complex64','ext complex dtype 205')
 assert(list_same(r:tolist(),{np.complex(0.634963870048523,-1.2984576225280762),np.complex(-1.1634403467178345,0.21775954961776733),np.complex(-0.489056259393692,1.4031193256378174),np.complex(73.46061706542969,-10.47250747680664),np.complex(0.25261232256889343,0.0),np.complex(-0.0,-0.14112000167369843),np.complex(-1.0313360691070557,0.7397922873497009),np.complex(0.0,0.14112000167369843),np.complex(74.20320892333984,0.0)},0.00015000000000000001,true),'ext complex sinh 205')
end
do
 local a=np.array({np.complex(3.0,2.0),np.complex(1.0,-3.0),np.complex(0.25,0.0),np.complex(-1.0,-1.0),np.complex(0.0,0.0),np.complex(-2.0,2.0),np.complex(-2.0,0.0),np.complex(-2.0,-3.0),np.complex(5.0,2.0)},np.complex64)
 local r=np.sinh(a)
 assert(r.dtype=='complex64','ext complex dtype 206')
 assert(list_same(r:tolist(),{np.complex(-4.168907165527344,9.154499053955078),np.complex(-1.1634403467178345,-0.21775954961776733),np.complex(0.25261232256889343,0.0),np.complex(-0.634963870048523,-1.2984576225280762),np.complex(0.0,0.0),np.complex(1.50930655002594,3.420954704284668),np.complex(-3.6268603801727295,0.0),np.complex(3.590564489364624,-0.5309210419654846),np.complex(-30.879430770874023,67.47891235351562)},0.00015000000000000001,true),'ext complex sinh 206')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex((0/0),0.0),np.complex(1.0,(0/0)),np.complex((0/0),2.0)},np.complex64)
 local r=np.cosh(a)
 assert(r.dtype=='complex64','ext complex dtype 207')
 assert(list_same(r:tolist(),{np.complex(1.0,0.0),np.complex(1.0,-0.0),np.complex(1.0,-0.0),np.complex(math.huge,0.0),np.complex(math.huge,-0.0),np.complex((0/0),0.0),np.complex((0/0),0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},0.00015000000000000001,true),'ext complex cosh 207')
end
do
 local a=np.array({np.complex(5.0,-3.0),np.complex(0.25,0.0),np.complex(1.0,-0.0),np.complex(0.25,0.0),np.complex(-5.0,0.0),np.complex(0.0,-1.0),np.complex(3.0,-0.0),np.complex(-2.0,3.0),np.complex(3.0,3.0)},np.complex64)
 local r=np.cosh(a)
 assert(r.dtype=='complex64','ext complex dtype 208')
 assert(list_same(r:tolist(),{np.complex(-73.46729278564453,-10.471556663513184),np.complex(1.0314130783081055,0.0),np.complex(1.5430806875228882,-0.0),np.complex(1.0314130783081055,0.0),np.complex(74.20994567871094,-0.0),np.complex(0.5403022766113281,-0.0),np.complex(10.067662239074707,-0.0),np.complex(-3.724545478820801,-0.511822521686554),np.complex(-9.966910362243652,1.4137225151062012)},0.00015000000000000001,true),'ext complex cosh 208')
end
do
 local a=np.array({np.complex(0.25,2.0),np.complex(1.0,-1.0),np.complex(1.0,2.0),np.complex(-0.0,3.0),np.complex(0.25,-3.0),np.complex(1.0,-0.0),np.complex(0.25,0.0),np.complex(3.0,0.5),np.complex(5.0,2.0)},np.complex64)
 local r=np.cosh(a)
 assert(r.dtype=='complex64','ext complex dtype 209')
 assert(list_same(r:tolist(),{np.complex(-0.4292193055152893,0.2296997308731079),np.complex(0.8337299823760986,-0.9888976812362671),np.complex(-0.6421481370925903,1.0686073303222656),np.complex(-0.9899924993515015,-0.0),np.complex(-1.0210912227630615,-0.0356486514210701),np.complex(1.5430806875228882,-0.0),np.complex(1.0314130783081055,0.0),np.complex(8.835205078125,4.802824974060059),np.complex(-30.882234573364258,67.47278594970703)},0.00015000000000000001,true),'ext complex cosh 209')
end
do
 local a=np.array({np.complex(-5.0,2.0),np.complex(0.0,-0.0),np.complex(3.0,0.5),np.complex(-5.0,-3.0),np.complex(5.0,-3.0),np.complex(-0.0,3.0),np.complex(-1.0,-0.0),np.complex(-2.0,0.5),np.complex(0.0,-1.0)},np.complex64)
 local r=np.cosh(a)
 assert(r.dtype=='complex64','ext complex dtype 210')
 assert(list_same(r:tolist(),{np.complex(-30.882234573364258,-67.47278594970703),np.complex(1.0,-0.0),np.complex(8.835205078125,4.802824974060059),np.complex(-73.46729278564453,10.471556663513184),np.complex(-73.46729278564453,-10.471556663513184),np.complex(-0.9899924993515015,-0.0),np.complex(1.5430806875228882,0.0),np.complex(3.3016371726989746,-1.738809585571289),np.complex(0.5403022766113281,-0.0)},0.00015000000000000001,true),'ext complex cosh 210')
end
do
 local a=np.array({np.complex(-5.0,-1.0),np.complex(0.25,3.0),np.complex(-5.0,-1.0),np.complex(-1.0,-0.0),np.complex(-0.0,0.5),np.complex(-1.0,0.0),np.complex(0.25,-1.0),np.complex(-5.0,-0.0),np.complex(-1.0,-0.0)},np.complex64)
 local r=np.cosh(a)
 assert(r.dtype=='complex64','ext complex dtype 211')
 assert(list_same(r:tolist(),{np.complex(40.095802307128906,62.43984603881836),np.complex(-1.0210912227630615,0.0356486514210701),np.complex(40.095802307128906,62.43984603881836),np.complex(1.5430806875228882,0.0),np.complex(0.8775825500488281,-0.0),np.complex(1.5430806875228882,-0.0),np.complex(0.5572748184204102,-0.21256592869758606),np.complex(74.20994567871094,0.0),np.complex(1.5430806875228882,0.0)},0.00015000000000000001,true),'ext complex cosh 211')
end
do
 local a=np.array({np.complex(-5.0,3.0),np.complex(-2.0,2.0),np.complex(-2.0,2.0),np.complex(-2.0,-1.0),np.complex(3.0,2.0),np.complex(-0.0,0.5),np.complex(1.0,2.0),np.complex(-0.0,-0.0),np.complex(5.0,-0.0)},np.complex64)
 local r=np.cosh(a)
 assert(r.dtype=='complex64','ext complex dtype 212')
 assert(list_same(r:tolist(),{np.complex(-73.46729278564453,-10.471556663513184),np.complex(-1.565625786781311,-3.2978947162628174),np.complex(-1.565625786781311,-3.2978947162628174),np.complex(2.0327229499816895,3.0518977642059326),np.complex(-4.1896257400512695,9.109227180480957),np.complex(0.8775825500488281,-0.0),np.complex(-0.6421481370925903,1.0686073303222656),np.complex(1.0,0.0),np.complex(74.20994567871094,-0.0)},0.00015000000000000001,true),'ext complex cosh 212')
end
do
 local a=np.array({np.complex(1.0,-0.0),np.complex(0.25,-3.0),np.complex(1.0,3.0),np.complex(0.25,-1.0),np.complex(-5.0,0.0),np.complex(0.0,0.5),np.complex(-1.0,-1.0),np.complex(1.0,3.0),np.complex(0.0,3.0)},np.complex64)
 local r=np.cosh(a)
 assert(r.dtype=='complex64','ext complex dtype 213')
 assert(list_same(r:tolist(),{np.complex(1.5430806875228882,-0.0),np.complex(-1.0210912227630615,-0.0356486514210701),np.complex(-1.52763831615448,0.1658443957567215),np.complex(0.5572748184204102,-0.21256592869758606),np.complex(74.20994567871094,-0.0),np.complex(0.8775825500488281,0.0),np.complex(0.8337299823760986,0.9888976812362671),np.complex(-1.52763831615448,0.1658443957567215),np.complex(-0.9899924993515015,0.0)},0.00015000000000000001,true),'ext complex cosh 213')
end
do
 local a=np.array({np.complex(5.0,2.0),np.complex(1.0,-1.0),np.complex(5.0,-0.0),np.complex(5.0,0.5),np.complex(-5.0,-0.0),np.complex(-2.0,-3.0),np.complex(-5.0,3.0),np.complex(5.0,-3.0),np.complex(5.0,2.0)},np.complex64)
 local r=np.cosh(a)
 assert(r.dtype=='complex64','ext complex dtype 214')
 assert(list_same(r:tolist(),{np.complex(-30.882234573364258,67.47278594970703),np.complex(0.8337299823760986,-0.9888976812362671),np.complex(74.20994567871094,-0.0),np.complex(65.12535095214844,35.574913024902344),np.complex(74.20994567871094,0.0),np.complex(-3.724545478820801,0.511822521686554),np.complex(-73.46729278564453,-10.471556663513184),np.complex(-73.46729278564453,-10.471556663513184),np.complex(-30.882234573364258,67.47278594970703)},0.00015000000000000001,true),'ext complex cosh 214')
end
do
 local a=np.array({np.complex(0.0,3.0),np.complex(-2.0,3.0),np.complex(0.25,-0.0),np.complex(1.0,0.0),np.complex(1.0,-0.0),np.complex(-0.0,-1.0),np.complex(-0.0,0.5),np.complex(-1.0,0.5),np.complex(-5.0,-3.0)},np.complex64)
 local r=np.cosh(a)
 assert(r.dtype=='complex64','ext complex dtype 215')
 assert(list_same(r:tolist(),{np.complex(-0.9899924993515015,0.0),np.complex(-3.724545478820801,-0.511822521686554),np.complex(1.0314130783081055,-0.0),np.complex(1.5430806875228882,0.0),np.complex(1.5430806875228882,-0.0),np.complex(0.5403022766113281,0.0),np.complex(0.8775825500488281,-0.0),np.complex(1.3541806936264038,-0.5634214878082275),np.complex(-73.46729278564453,10.471556663513184)},0.00015000000000000001,true),'ext complex cosh 215')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex((0/0),0.0),np.complex(1.0,(0/0)),np.complex((0/0),2.0)},np.complex64)
 local r=np.tanh(a)
 assert(r.dtype=='complex64','ext complex dtype 216')
 assert(list_same(r:tolist(),{np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(1.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,(0/0)),np.complex((0/0),0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},0.00015000000000000001,true),'ext complex tanh 216')
end
do
 local a=np.array({np.complex(-5.0,-1.0),np.complex(0.25,0.0),np.complex(0.25,3.0),np.complex(-0.0,0.0),np.complex(5.0,-3.0),np.complex(-2.0,2.0),np.complex(1.0,2.0),np.complex(1.0,-0.0),np.complex(-5.0,2.0)},np.complex64)
 local r=np.tanh(a)
 assert(r.dtype=='complex64','ext complex dtype 217')
 assert(list_same(r:tolist(),{np.complex(-1.0000377893447876,-8.25671959319152e-05),np.complex(0.24491867423057556,0.0),np.complex(0.24959109723567963,-0.13383273780345917),np.complex(-0.0,0.0),np.complex(0.9999128580093384,2.5368677597725764e-05),np.complex(-1.02383553981781,-0.02839295193552971),np.complex(1.1667362451553345,-0.24345821142196655),np.complex(0.7615941762924194,-0.0),np.complex(-1.0000593662261963,-6.872163794469088e-05)},0.00015000000000000001,true),'ext complex tanh 217')
end
do
 local a=np.array({np.complex(5.0,0.5),np.complex(5.0,-1.0),np.complex(3.0,-3.0),np.complex(-2.0,-1.0),np.complex(-0.0,-3.0),np.complex(-0.0,0.0),np.complex(-1.0,3.0),np.complex(-0.0,-0.0),np.complex(-0.0,-3.0)},np.complex64)
 local r=np.tanh(a)
 assert(r.dtype=='complex64','ext complex dtype 218')
 assert(list_same(r:tolist(),{np.complex(0.9999509453773499,7.640170952072367e-05),np.complex(1.0000377893447876,-8.25671959319152e-05),np.complex(0.995250403881073,0.001378632732667029),np.complex(-1.0147936344146729,-0.03381282463669777),np.complex(-0.0,0.14254653453826904),np.complex(-0.0,0.0),np.complex(-0.7680176496505737,-0.05916853994131088),np.complex(-0.0,-0.0),np.complex(-0.0,0.14254653453826904)},0.00015000000000000001,true),'ext complex tanh 218')
end
do
 local a=np.array({np.complex(-2.0,3.0),np.complex(3.0,0.5),np.complex(0.25,-0.0),np.complex(-1.0,0.0),np.complex(0.0,3.0),np.complex(5.0,-3.0),np.complex(5.0,2.0),np.complex(0.0,3.0),np.complex(-0.0,-3.0)},np.complex64)
 local r=np.tanh(a)
 assert(r.dtype=='complex64','ext complex dtype 219')
 assert(list_same(r:tolist(),{np.complex(-0.9653858542442322,-0.009884374216198921),np.complex(0.9973164796829224,0.004160427022725344),np.complex(0.24491867423057556,-0.0),np.complex(-0.7615941762924194,0.0),np.complex(0.0,-0.14254653453826904),np.complex(0.9999128580093384,2.5368677597725764e-05),np.complex(1.0000593662261963,-6.872163794469088e-05),np.complex(0.0,-0.14254653453826904),np.complex(-0.0,0.14254653453826904)},0.00015000000000000001,true),'ext complex tanh 219')
end
do
 local a=np.array({np.complex(3.0,2.0),np.complex(1.0,2.0),np.complex(3.0,3.0),np.complex(1.0,0.0),np.complex(0.0,0.5),np.complex(-1.0,-0.0),np.complex(0.0,0.5),np.complex(-0.0,-1.0),np.complex(1.0,2.0)},np.complex64)
 local r=np.tanh(a)
 assert(r.dtype=='complex64','ext complex dtype 220')
 assert(list_same(r:tolist(),{np.complex(1.0032386779785156,-0.003764025866985321),np.complex(1.1667362451553345,-0.24345821142196655),np.complex(0.995250403881073,-0.001378632732667029),np.complex(0.7615941762924194,0.0),np.complex(0.0,0.5463024973869324),np.complex(-0.7615941762924194,-0.0),np.complex(0.0,0.5463024973869324),np.complex(-0.0,-1.5574077367782593),np.complex(1.1667362451553345,-0.24345821142196655)},0.00015000000000000001,true),'ext complex tanh 220')
end
do
 local a=np.array({np.complex(3.0,-0.0),np.complex(-0.0,3.0),np.complex(3.0,0.5),np.complex(0.0,-0.0),np.complex(0.0,3.0),np.complex(0.0,3.0),np.complex(-2.0,0.0),np.complex(-5.0,0.0),np.complex(3.0,-1.0)},np.complex64)
 local r=np.tanh(a)
 assert(r.dtype=='complex64','ext complex dtype 221')
 assert(list_same(r:tolist(),{np.complex(0.9950548410415649,-0.0),np.complex(-0.0,-0.14254653453826904),np.complex(0.9973164796829224,0.004160427022725344),np.complex(0.0,-0.0),np.complex(0.0,-0.14254653453826904),np.complex(0.0,-0.14254653453826904),np.complex(-0.9640275835990906,0.0),np.complex(-0.9999092221260071,0.0),np.complex(1.0020551681518555,-0.004517137538641691)},0.00015000000000000001,true),'ext complex tanh 221')
end
do
 local a=np.array({np.complex(-5.0,2.0),np.complex(3.0,-0.0),np.complex(-2.0,3.0),np.complex(-5.0,0.0),np.complex(5.0,0.5),np.complex(5.0,-1.0),np.complex(0.0,-3.0),np.complex(-2.0,-3.0),np.complex(0.25,-3.0)},np.complex64)
 local r=np.tanh(a)
 assert(r.dtype=='complex64','ext complex dtype 222')
 assert(list_same(r:tolist(),{np.complex(-1.0000593662261963,-6.872163794469088e-05),np.complex(0.9950548410415649,-0.0),np.complex(-0.9653858542442322,-0.009884374216198921),np.complex(-0.9999092221260071,0.0),np.complex(0.9999509453773499,7.640170952072367e-05),np.complex(1.0000377893447876,-8.25671959319152e-05),np.complex(0.0,0.14254653453826904),np.complex(-0.9653858542442322,0.009884374216198921),np.complex(0.24959109723567963,0.13383273780345917)},0.00015000000000000001,true),'ext complex tanh 222')
end
do
 local a=np.array({np.complex(0.25,-3.0),np.complex(-5.0,2.0),np.complex(5.0,-3.0),np.complex(0.0,3.0),np.complex(-5.0,-0.0),np.complex(0.0,0.5),np.complex(1.0,-0.0),np.complex(-0.0,-3.0),np.complex(0.0,-0.0)},np.complex64)
 local r=np.tanh(a)
 assert(r.dtype=='complex64','ext complex dtype 223')
 assert(list_same(r:tolist(),{np.complex(0.24959109723567963,0.13383273780345917),np.complex(-1.0000593662261963,-6.872163794469088e-05),np.complex(0.9999128580093384,2.5368677597725764e-05),np.complex(0.0,-0.14254653453826904),np.complex(-0.9999092221260071,-0.0),np.complex(0.0,0.5463024973869324),np.complex(0.7615941762924194,-0.0),np.complex(-0.0,0.14254653453826904),np.complex(0.0,-0.0)},0.00015000000000000001,true),'ext complex tanh 223')
end
do
 local a=np.array({np.complex(5.0,-1.0),np.complex(3.0,-3.0),np.complex(-5.0,2.0),np.complex(5.0,0.5),np.complex(-2.0,2.0),np.complex(5.0,3.0),np.complex(-1.0,-3.0),np.complex(-1.0,2.0),np.complex(-5.0,0.0)},np.complex64)
 local r=np.tanh(a)
 assert(r.dtype=='complex64','ext complex dtype 224')
 assert(list_same(r:tolist(),{np.complex(1.0000377893447876,-8.25671959319152e-05),np.complex(0.995250403881073,0.001378632732667029),np.complex(-1.0000593662261963,-6.872163794469088e-05),np.complex(0.9999509453773499,7.640170952072367e-05),np.complex(-1.02383553981781,-0.02839295193552971),np.complex(0.9999128580093384,-2.5368677597725764e-05),np.complex(-0.7680176496505737,0.05916853994131088),np.complex(-1.1667362451553345,-0.24345821142196655),np.complex(-0.9999092221260071,0.0)},0.00015000000000000001,true),'ext complex tanh 224')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex((0/0),0.0),np.complex(1.0,(0/0)),np.complex((0/0),2.0)},np.complex64)
 local r=np.exp2(a)
 assert(r.dtype=='complex64','ext complex dtype 225')
 assert(list_same(r:tolist(),{np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(1.0,-0.0),np.complex(math.huge,0.0),np.complex(0.0,0.0),np.complex((0/0),(0/0)),np.complex((0/0),0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},0.00015000000000000001,true),'ext complex exp2 225')
end
do
 local a=np.array({np.complex(0.25,-1.0),np.complex(0.25,3.0),np.complex(-1.0,0.0),np.complex(-5.0,3.0),np.complex(-2.0,3.0),np.complex(5.0,2.0),np.complex(0.0,2.0),np.complex(-2.0,-0.0),np.complex(-5.0,-3.0)},np.complex64)
 local r=np.exp2(a)
 assert(r.dtype=='complex64','ext complex dtype 226')
 assert(list_same(r:tolist(),{np.complex(0.91478431224823,-0.7598572373390198),np.complex(-0.5791372060775757,1.0386595726013184),np.complex(0.5,0.0),np.complex(-0.015218575485050678,0.027293909341096878),np.complex(-0.12174860388040543,0.21835127472877502),np.complex(5.8706231117248535,31.45688819885254),np.complex(0.18345697224140167,0.9830277562141418),np.complex(0.25,-0.0),np.complex(-0.015218575485050678,-0.027293909341096878)},0.00015000000000000001,true),'ext complex exp2 226')
end
do
 local a=np.array({np.complex(0.0,-0.0),np.complex(1.0,-3.0),np.complex(-0.0,0.5),np.complex(0.25,0.0),np.complex(-2.0,-3.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(1.0,2.0),np.complex(5.0,0.0)},np.complex64)
 local r=np.exp2(a)
 assert(r.dtype=='complex64','ext complex dtype 227')
 assert(list_same(r:tolist(),{np.complex(1.0,-0.0),np.complex(-0.9739888310432434,-1.7468101978302002),np.complex(0.9405421018600464,0.3396771252155304),np.complex(1.1892070770263672,0.0),np.complex(-0.12174860388040543,-0.21835127472877502),np.complex(0.09172848612070084,0.4915138781070709),np.complex(1.0,0.0),np.complex(0.36691394448280334,1.9660555124282837),np.complex(32.0,0.0)},0.00015000000000000001,true),'ext complex exp2 227')
end
do
 local a=np.array({np.complex(-5.0,-0.0),np.complex(5.0,-0.0),np.complex(-2.0,0.0),np.complex(-1.0,0.5),np.complex(0.25,3.0),np.complex(-1.0,-3.0),np.complex(-5.0,-1.0),np.complex(5.0,-3.0),np.complex(-2.0,-1.0)},np.complex64)
 local r=np.exp2(a)
 assert(r.dtype=='complex64','ext complex dtype 228')
 assert(list_same(r:tolist(),{np.complex(0.03125,-0.0),np.complex(32.0,-0.0),np.complex(0.25,0.0),np.complex(0.4702710509300232,0.1698385626077652),np.complex(-0.5791372060775757,1.0386595726013184),np.complex(-0.24349720776081085,-0.43670254945755005),np.complex(0.024038715288043022,-0.019967539235949516),np.complex(-15.583821296691895,-27.948963165283203),np.complex(0.19230972230434418,-0.15974031388759613)},0.00015000000000000001,true),'ext complex exp2 228')
end
do
 local a=np.array({np.complex(1.0,0.0),np.complex(-0.0,0.5),np.complex(1.0,-0.0),np.complex(1.0,0.5),np.complex(3.0,0.0),np.complex(0.25,3.0),np.complex(3.0,0.5),np.complex(1.0,3.0),np.complex(3.0,-1.0)},np.complex64)
 local r=np.exp2(a)
 assert(r.dtype=='complex64','ext complex dtype 229')
 assert(list_same(r:tolist(),{np.complex(2.0,0.0),np.complex(0.9405421018600464,0.3396771252155304),np.complex(2.0,-0.0),np.complex(1.8810842037200928,0.6793542504310608),np.complex(8.0,0.0),np.complex(-0.5791372060775757,1.0386595726013184),np.complex(7.524336814880371,2.717417001724243),np.complex(-0.9739888310432434,1.7468101978302002),np.complex(6.153911113739014,-5.111690044403076)},0.00015000000000000001,true),'ext complex exp2 229')
end
do
 local a=np.array({np.complex(-5.0,-0.0),np.complex(3.0,-3.0),np.complex(1.0,2.0),np.complex(-2.0,3.0),np.complex(0.25,3.0),np.complex(-0.0,-1.0),np.complex(5.0,-0.0),np.complex(5.0,-3.0),np.complex(3.0,-3.0)},np.complex64)
 local r=np.exp2(a)
 assert(r.dtype=='complex64','ext complex dtype 230')
 assert(list_same(r:tolist(),{np.complex(0.03125,-0.0),np.complex(-3.8959553241729736,-6.987240791320801),np.complex(0.36691394448280334,1.9660555124282837),np.complex(-0.12174860388040543,0.21835127472877502),np.complex(-0.5791372060775757,1.0386595726013184),np.complex(0.7692388892173767,-0.6389612555503845),np.complex(32.0,-0.0),np.complex(-15.583821296691895,-27.948963165283203),np.complex(-3.8959553241729736,-6.987240791320801)},0.00015000000000000001,true),'ext complex exp2 230')
end
do
 local a=np.array({np.complex(5.0,-3.0),np.complex(-2.0,2.0),np.complex(-1.0,0.5),np.complex(3.0,-0.0),np.complex(-1.0,-3.0),np.complex(5.0,-1.0),np.complex(0.0,-1.0),np.complex(-2.0,-3.0),np.complex(-1.0,-0.0)},np.complex64)
 local r=np.exp2(a)
 assert(r.dtype=='complex64','ext complex dtype 231')
 assert(list_same(r:tolist(),{np.complex(-15.583821296691895,-27.948963165283203),np.complex(0.04586424306035042,0.24575693905353546),np.complex(0.4702710509300232,0.1698385626077652),np.complex(8.0,-0.0),np.complex(-0.24349720776081085,-0.43670254945755005),np.complex(24.615644454956055,-20.446760177612305),np.complex(0.7692388892173767,-0.6389612555503845),np.complex(-0.12174860388040543,-0.21835127472877502),np.complex(0.5,-0.0)},0.00015000000000000001,true),'ext complex exp2 231')
end
do
 local a=np.array({np.complex(5.0,2.0),np.complex(5.0,-0.0),np.complex(-0.0,2.0),np.complex(-5.0,-3.0),np.complex(-1.0,0.5),np.complex(-1.0,-0.0),np.complex(5.0,-0.0),np.complex(-2.0,3.0),np.complex(3.0,0.0)},np.complex64)
 local r=np.exp2(a)
 assert(r.dtype=='complex64','ext complex dtype 232')
 assert(list_same(r:tolist(),{np.complex(5.8706231117248535,31.45688819885254),np.complex(32.0,-0.0),np.complex(0.18345697224140167,0.9830277562141418),np.complex(-0.015218575485050678,-0.027293909341096878),np.complex(0.4702710509300232,0.1698385626077652),np.complex(0.5,-0.0),np.complex(32.0,-0.0),np.complex(-0.12174860388040543,0.21835127472877502),np.complex(8.0,0.0)},0.00015000000000000001,true),'ext complex exp2 232')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(0.0,-1.0),np.complex(-1.0,0.0),np.complex(-1.0,-0.0),np.complex(-1.0,2.0),np.complex(-0.0,-1.0),np.complex(-1.0,-0.0),np.complex(3.0,3.0),np.complex(0.0,3.0)},np.complex64)
 local r=np.exp2(a)
 assert(r.dtype=='complex64','ext complex dtype 233')
 assert(list_same(r:tolist(),{np.complex(1.0,0.0),np.complex(0.7692388892173767,-0.6389612555503845),np.complex(0.5,0.0),np.complex(0.5,-0.0),np.complex(0.09172848612070084,0.4915138781070709),np.complex(0.7692388892173767,-0.6389612555503845),np.complex(0.5,-0.0),np.complex(-3.8959553241729736,6.987240791320801),np.complex(-0.4869944155216217,0.8734050989151001)},0.00015000000000000001,true),'ext complex exp2 233')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex((0/0),0.0),np.complex(1.0,(0/0)),np.complex((0/0),2.0)},np.complex64)
 local r=np.log2(a)
 assert(r.dtype=='complex64','ext complex dtype 234')
 assert(list_same(r:tolist(),{np.complex(-math.huge,0.0),np.complex(-math.huge,4.532360076904297),np.complex(-math.huge,-0.0),np.complex(math.huge,0.0),np.complex(math.huge,4.532360076904297),np.complex(math.huge,2.2661800384521484),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},0.00015000000000000001,true),'ext complex log2 234')
end
do
 local a=np.array({np.complex(-0.0,-0.0),np.complex(-1.0,-1.0),np.complex(-1.0,0.5),np.complex(-1.0,0.0),np.complex(-2.0,3.0),np.complex(5.0,-0.0),np.complex(5.0,3.0),np.complex(0.25,-1.0),np.complex(3.0,0.0)},np.complex64)
 local r=np.log2(a)
 assert(r.dtype=='complex64','ext complex dtype 235')
 assert(list_same(r:tolist(),{np.complex(-math.huge,-4.532360076904297),np.complex(0.5,-3.3992700576782227),np.complex(0.16096404194831848,3.8634581565856934),np.complex(0.0,4.532360076904297),np.complex(1.8502197265625,3.114488363265991),np.complex(2.321928024291992,-0.0),np.complex(2.543731451034546,0.7796605229377747),np.complex(0.04373142123222351,-1.9127506017684937),np.complex(1.5849624872207642,0.0)},0.00015000000000000001,true),'ext complex log2 235')
end
do
 local a=np.array({np.complex(0.25,-3.0),np.complex(-5.0,0.0),np.complex(5.0,0.0),np.complex(-5.0,0.0),np.complex(1.0,2.0),np.complex(-2.0,0.0),np.complex(3.0,3.0),np.complex(-2.0,0.5),np.complex(5.0,0.5)},np.complex64)
 local r=np.log2(a)
 assert(r.dtype=='complex64','ext complex dtype 236')
 assert(list_same(r:tolist(),{np.complex(1.5899544954299927,-2.1462326049804688),np.complex(2.321928024291992,4.532360076904297),np.complex(2.321928024291992,0.0),np.complex(2.321928024291992,4.532360076904297),np.complex(1.160964012145996,1.5972779989242554),np.complex(1.0,4.532360076904297),np.complex(2.0849623680114746,1.1330900192260742),np.complex(1.043731451034546,4.178930759429932),np.complex(2.3291056156158447,0.14379146695137024)},0.00015000000000000001,true),'ext complex log2 236')
end
do
 local a=np.array({np.complex(5.0,2.0),np.complex(3.0,2.0),np.complex(-1.0,2.0),np.complex(0.0,0.0),np.complex(5.0,-3.0),np.complex(3.0,2.0),np.complex(5.0,2.0),np.complex(-5.0,-3.0),np.complex(3.0,-0.0)},np.complex64)
 local r=np.log2(a)
 assert(r.dtype=='complex64','ext complex dtype 237')
 assert(list_same(r:tolist(),{np.complex(2.428990364074707,0.5489546656608582),np.complex(1.8502197265625,0.8483084440231323),np.complex(1.160964012145996,2.935081958770752),np.complex(-math.huge,0.0),np.complex(2.543731451034546,-0.7796605229377747),np.complex(1.8502197265625,0.8483084440231323),np.complex(2.428990364074707,0.5489546656608582),np.complex(2.543731451034546,-3.752699613571167),np.complex(1.5849624872207642,-0.0)},0.00015000000000000001,true),'ext complex log2 237')
end
do
 local a=np.array({np.complex(-2.0,-1.0),np.complex(-5.0,-0.0),np.complex(-2.0,2.0),np.complex(5.0,3.0),np.complex(-5.0,-0.0),np.complex(-0.0,0.0),np.complex(0.0,2.0),np.complex(0.25,2.0),np.complex(-0.0,-1.0)},np.complex64)
 local r=np.log2(a)
 assert(r.dtype=='complex64','ext complex dtype 238')
 assert(list_same(r:tolist(),{np.complex(1.160964012145996,-3.8634581565856934),np.complex(2.321928024291992,-4.532360076904297),np.complex(1.5,3.3992700576782227),np.complex(2.543731451034546,0.7796605229377747),np.complex(2.321928024291992,-4.532360076904297),np.complex(-math.huge,4.532360076904297),np.complex(1.0,2.2661800384521484),np.complex(1.0111839771270752,2.086773633956909),np.complex(0.0,-2.2661800384521484)},0.00015000000000000001,true),'ext complex log2 238')
end
do
 local a=np.array({np.complex(-1.0,-1.0),np.complex(-5.0,-3.0),np.complex(-2.0,-0.0),np.complex(0.0,2.0),np.complex(0.25,0.0),np.complex(0.25,-1.0),np.complex(5.0,-3.0),np.complex(-5.0,-3.0),np.complex(-1.0,3.0)},np.complex64)
 local r=np.log2(a)
 assert(r.dtype=='complex64','ext complex dtype 239')
 assert(list_same(r:tolist(),{np.complex(0.5,-3.3992700576782227),np.complex(2.543731451034546,-3.752699613571167),np.complex(1.0,-4.532360076904297),np.complex(1.0,2.2661800384521484),np.complex(-2.0,0.0),np.complex(0.04373142123222351,-1.9127506017684937),np.complex(2.543731451034546,-0.7796605229377747),np.complex(2.543731451034546,-3.752699613571167),np.complex(1.660964012145996,2.73036789894104)},0.00015000000000000001,true),'ext complex log2 239')
end
do
 local a=np.array({np.complex(-1.0,-0.0),np.complex(5.0,-0.0),np.complex(-2.0,3.0),np.complex(-1.0,-1.0),np.complex(5.0,-3.0),np.complex(-0.0,-0.0),np.complex(-1.0,-0.0),np.complex(5.0,0.5),np.complex(-2.0,0.0)},np.complex64)
 local r=np.log2(a)
 assert(r.dtype=='complex64','ext complex dtype 240')
 assert(list_same(r:tolist(),{np.complex(0.0,-4.532360076904297),np.complex(2.321928024291992,-0.0),np.complex(1.8502197265625,3.114488363265991),np.complex(0.5,-3.3992700576782227),np.complex(2.543731451034546,-0.7796605229377747),np.complex(-math.huge,-4.532360076904297),np.complex(0.0,-4.532360076904297),np.complex(2.3291056156158447,0.14379146695137024),np.complex(1.0,4.532360076904297)},0.00015000000000000001,true),'ext complex log2 240')
end
do
 local a=np.array({np.complex(1.0,2.0),np.complex(-1.0,-0.0),np.complex(-1.0,0.5),np.complex(-0.0,0.5),np.complex(0.25,-1.0),np.complex(0.25,-0.0),np.complex(0.25,0.0),np.complex(-5.0,0.5),np.complex(5.0,0.0)},np.complex64)
 local r=np.log2(a)
 assert(r.dtype=='complex64','ext complex dtype 241')
 assert(list_same(r:tolist(),{np.complex(1.160964012145996,1.5972779989242554),np.complex(0.0,-4.532360076904297),np.complex(0.16096404194831848,3.8634581565856934),np.complex(-1.0,2.2661800384521484),np.complex(0.04373142123222351,-1.9127506017684937),np.complex(-2.0,-0.0),np.complex(-2.0,0.0),np.complex(2.3291056156158447,4.38856840133667),np.complex(2.321928024291992,0.0)},0.00015000000000000001,true),'ext complex log2 241')
end
do
 local a=np.array({np.complex(0.25,0.5),np.complex(0.25,-0.0),np.complex(-1.0,-3.0),np.complex(3.0,-1.0),np.complex(0.0,-0.0),np.complex(0.25,-1.0),np.complex(1.0,-3.0),np.complex(0.0,3.0),np.complex(-0.0,-1.0)},np.complex64)
 local r=np.log2(a)
 assert(r.dtype=='complex64','ext complex dtype 242')
 assert(list_same(r:tolist(),{np.complex(-0.8390359282493591,1.5972779989242554),np.complex(-2.0,-0.0),np.complex(1.660964012145996,-2.73036789894104),np.complex(1.660964012145996,-0.4641879200935364),np.complex(-math.huge,-0.0),np.complex(0.04373142123222351,-1.9127506017684937),np.complex(1.660964012145996,-1.8019920587539673),np.complex(1.5849624872207642,2.2661800384521484),np.complex(0.0,-2.2661800384521484)},0.00015000000000000001,true),'ext complex log2 242')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex((0/0),0.0),np.complex(1.0,(0/0)),np.complex((0/0),2.0)},np.complex64)
 local r=np.log10(a)
 assert(r.dtype=='complex64','ext complex dtype 243')
 assert(list_same(r:tolist(),{np.complex(-math.huge,0.0),np.complex(-math.huge,1.364376425743103),np.complex(-math.huge,-0.0),np.complex(math.huge,0.0),np.complex(math.huge,1.364376425743103),np.complex(math.huge,0.6821882128715515),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},0.00015000000000000001,true),'ext complex log10 243')
end
do
 local a=np.array({np.complex(5.0,0.5),np.complex(0.25,-1.0),np.complex(0.25,-0.0),np.complex(-2.0,-1.0),np.complex(-5.0,-0.0),np.complex(3.0,3.0),np.complex(3.0,-0.0),np.complex(-1.0,3.0),np.complex(-1.0,-0.0)},np.complex64)
 local r=np.log10(a)
 assert(r.dtype=='complex64','ext complex dtype 244')
 assert(list_same(r:tolist(),{np.complex(0.7011306881904602,0.0432855449616909),np.complex(0.013164469972252846,-0.5757953524589539),np.complex(-0.6020600199699402,-0.0),np.complex(0.34948500990867615,-1.1630167961120605),np.complex(0.6989700198173523,-1.364376425743103),np.complex(0.6276362538337708,0.34109410643577576),np.complex(0.4771212637424469,-0.0),np.complex(0.5,0.8219227194786072),np.complex(0.0,-1.364376425743103)},0.00015000000000000001,true),'ext complex log10 244')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-1.0,-1.0),np.complex(0.25,2.0),np.complex(5.0,0.0),np.complex(3.0,0.5),np.complex(1.0,0.0),np.complex(3.0,-3.0),np.complex(-5.0,-0.0),np.complex(-1.0,-1.0)},np.complex64)
 local r=np.log10(a)
 assert(r.dtype=='complex64','ext complex dtype 245')
 assert(list_same(r:tolist(),{np.complex(-math.huge,0.0),np.complex(0.15051500499248505,-1.0232822895050049),np.complex(0.30439671874046326,0.6281814575195312),np.complex(0.6989700198173523,0.0),np.complex(0.48307090997695923,0.07172316312789917),np.complex(0.0,0.0),np.complex(0.6276362538337708,-0.34109410643577576),np.complex(0.6989700198173523,-1.364376425743103),np.complex(0.15051500499248505,-1.0232822895050049)},0.00015000000000000001,true),'ext complex log10 245')
end
do
 local a=np.array({np.complex(-5.0,2.0),np.complex(-5.0,0.5),np.complex(-2.0,0.0),np.complex(-2.0,-3.0),np.complex(0.0,0.0),np.complex(-0.0,2.0),np.complex(3.0,3.0),np.complex(0.0,-1.0),np.complex(-2.0,-1.0)},np.complex64)
 local r=np.log10(a)
 assert(r.dtype=='complex64','ext complex dtype 246')
 assert(list_same(r:tolist(),{np.complex(0.7311990261077881,1.1991245746612549),np.complex(0.7011306881904602,1.321090817451477),np.complex(0.3010300099849701,1.364376425743103),np.complex(0.5569716691970825,-0.9375544786453247),np.complex(-math.huge,0.0),np.complex(0.3010300099849701,0.6821882128715515),np.complex(0.6276362538337708,0.34109410643577576),np.complex(0.0,-0.6821882128715515),np.complex(0.34948500990867615,-1.1630167961120605)},0.00015000000000000001,true),'ext complex log10 246')
end
do
 local a=np.array({np.complex(0.25,0.5),np.complex(3.0,0.5),np.complex(3.0,-0.0),np.complex(0.25,-3.0),np.complex(0.25,3.0),np.complex(-2.0,0.0),np.complex(-0.0,-0.0),np.complex(-2.0,-0.0),np.complex(5.0,0.0)},np.complex64)
 local r=np.log10(a)
 assert(r.dtype=='complex64','ext complex dtype 247')
 assert(list_same(r:tolist(),{np.complex(-0.25257498025894165,0.4808286130428314),np.complex(0.48307090997695923,0.07172316312789917),np.complex(0.4771212637424469,-0.0),np.complex(0.47862401604652405,-0.6460803747177124),np.complex(0.47862401604652405,0.6460803747177124),np.complex(0.3010300099849701,1.364376425743103),np.complex(-math.huge,-1.364376425743103),np.complex(0.3010300099849701,-1.364376425743103),np.complex(0.6989700198173523,0.0)},0.00015000000000000001,true),'ext complex log10 247')
end
do
 local a=np.array({np.complex(5.0,-0.0),np.complex(-1.0,2.0),np.complex(0.25,0.0),np.complex(-2.0,-3.0),np.complex(-2.0,0.5),np.complex(-5.0,-1.0),np.complex(-1.0,3.0),np.complex(3.0,-1.0),np.complex(-0.0,0.0)},np.complex64)
 local r=np.log10(a)
 assert(r.dtype=='complex64','ext complex dtype 248')
 assert(list_same(r:tolist(),{np.complex(0.6989700198173523,-0.0),np.complex(0.34948500990867615,0.8835477828979492),np.complex(-0.6020600199699402,0.0),np.complex(0.5569716691970825,-0.9375544786453247),np.complex(0.3141944706439972,1.2579835653305054),np.complex(0.7074866890907288,-1.2786486148834229),np.complex(0.5,0.8219227194786072),np.complex(0.5,-0.13973449170589447),np.complex(-math.huge,1.364376425743103)},0.00015000000000000001,true),'ext complex log10 248')
end
do
 local a=np.array({np.complex(0.0,3.0),np.complex(-2.0,3.0),np.complex(0.0,-3.0),np.complex(-2.0,2.0),np.complex(0.25,0.5),np.complex(-2.0,-0.0),np.complex(0.25,3.0),np.complex(-1.0,2.0),np.complex(5.0,0.0)},np.complex64)
 local r=np.log10(a)
 assert(r.dtype=='complex64','ext complex dtype 249')
 assert(list_same(r:tolist(),{np.complex(0.4771212637424469,0.6821882128715515),np.complex(0.5569716691970825,0.9375544786453247),np.complex(0.4771212637424469,-0.6821882128715515),np.complex(0.45154500007629395,1.0232822895050049),np.complex(-0.25257498025894165,0.4808286130428314),np.complex(0.3010300099849701,-1.364376425743103),np.complex(0.47862401604652405,0.6460803747177124),np.complex(0.34948500990867615,0.8835477828979492),np.complex(0.6989700198173523,0.0)},0.00015000000000000001,true),'ext complex log10 249')
end
do
 local a=np.array({np.complex(0.0,-3.0),np.complex(-0.0,0.0),np.complex(3.0,2.0),np.complex(-5.0,-3.0),np.complex(0.0,-0.0),np.complex(-0.0,0.0),np.complex(5.0,-0.0),np.complex(-2.0,2.0),np.complex(-1.0,0.5)},np.complex64)
 local r=np.log10(a)
 assert(r.dtype=='complex64','ext complex dtype 250')
 assert(list_same(r:tolist(),{np.complex(0.4771212637424469,-0.6821882128715515),np.complex(-math.huge,1.364376425743103),np.complex(0.5569716691970825,0.2553662955760956),np.complex(0.7657395005226135,-1.1296751499176025),np.complex(-math.huge,-0.0),np.complex(-math.huge,1.364376425743103),np.complex(0.6989700198173523,-0.0),np.complex(0.45154500007629395,1.0232822895050049),np.complex(0.04845500737428665,1.1630167961120605)},0.00015000000000000001,true),'ext complex log10 250')
end
do
 local a=np.array({np.complex(5.0,2.0),np.complex(-1.0,0.0),np.complex(1.0,0.5),np.complex(-5.0,0.0),np.complex(5.0,-1.0),np.complex(-1.0,-0.0),np.complex(0.25,0.5),np.complex(0.0,-3.0),np.complex(-1.0,2.0)},np.complex64)
 local r=np.log10(a)
 assert(r.dtype=='complex64','ext complex dtype 251')
 assert(list_same(r:tolist(),{np.complex(0.7311990261077881,0.16525182127952576),np.complex(0.0,1.364376425743103),np.complex(0.04845500737428665,0.2013595998287201),np.complex(0.6989700198173523,1.364376425743103),np.complex(0.7074866890907288,-0.08572780340909958),np.complex(0.0,-1.364376425743103),np.complex(-0.25257498025894165,0.4808286130428314),np.complex(0.4771212637424469,-0.6821882128715515),np.complex(0.34948500990867615,0.8835477828979492)},0.00015000000000000001,true),'ext complex log10 251')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex((0/0),0.0),np.complex(1.0,(0/0)),np.complex((0/0),2.0)},np.complex64)
 local r=np.expm1(a)
 assert(r.dtype=='complex64','ext complex dtype 252')
 assert(list_same(r:tolist(),{np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,(0/0)),np.complex(-1.0,0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},0.00015000000000000001,true),'ext complex expm1 252')
end
do
 local a=np.array({np.complex(-1.0,0.5),np.complex(1.0,-3.0),np.complex(-5.0,0.5),np.complex(0.25,3.0),np.complex(3.0,2.0),np.complex(-2.0,0.0),np.complex(0.0,-1.0),np.complex(-1.0,-1.0),np.complex(0.0,3.0)},np.complex64)
 local r=np.expm1(a)
 assert(r.dtype=='complex64','ext complex dtype 253')
 assert(list_same(r:tolist(),{np.complex(-0.6771554350852966,0.17637081444263458),np.complex(-3.6910786628723145,-0.38360393047332764),np.complex(-0.9940869212150574,0.0032303440384566784),np.complex(-2.2711756229400635,0.18120166659355164),np.complex(-9.358532905578613,18.26372718811035),np.complex(-0.8646647334098816,0.0),np.complex(-0.4596977233886719,-0.8414709568023682),np.complex(-0.8012338876724243,-0.3095598816871643),np.complex(-1.9899924993515015,0.14112000167369843)},0.00015000000000000001,true),'ext complex expm1 253')
end
do
 local a=np.array({np.complex(-1.0,-3.0),np.complex(-1.0,-3.0),np.complex(3.0,3.0),np.complex(-2.0,3.0),np.complex(5.0,0.5),np.complex(-5.0,-0.0),np.complex(0.25,3.0),np.complex(-0.0,2.0),np.complex(-5.0,2.0)},np.complex64)
 local r=np.expm1(a)
 assert(r.dtype=='complex64','ext complex dtype 254')
 assert(list_same(r:tolist(),{np.complex(-1.3641979694366455,-0.05191515013575554),np.complex(-1.3641979694366455,-0.05191515013575554),np.complex(-20.884531021118164,2.8344709873199463),np.complex(-1.1339808702468872,0.019098514690995216),np.complex(129.2447967529297,71.15306091308594),np.complex(-0.9932620525360107,-0.0),np.complex(-2.2711756229400635,0.18120166659355164),np.complex(-1.4161467552185059,0.9092974066734314),np.complex(-1.002803921699524,0.006126797758042812)},0.00015000000000000001,true),'ext complex expm1 254')
end
do
 local a=np.array({np.complex(0.25,-1.0),np.complex(-5.0,3.0),np.complex(-0.0,0.5),np.complex(-0.0,-1.0),np.complex(-1.0,-0.0),np.complex(0.25,3.0),np.complex(-0.0,-1.0),np.complex(3.0,2.0),np.complex(3.0,-0.0)},np.complex64)
 local r=np.expm1(a)
 assert(r.dtype=='complex64','ext complex dtype 255')
 assert(list_same(r:tolist(),{np.complex(-0.3062381148338318,-1.080470085144043),np.complex(-1.0066704750061035,0.0009508591028861701),np.complex(-0.12241744250059128,0.4794255495071411),np.complex(-0.4596977233886719,-0.8414709568023682),np.complex(-0.6321205496788025,-0.0),np.complex(-2.2711756229400635,0.18120166659355164),np.complex(-0.4596977233886719,-0.8414709568023682),np.complex(-9.358532905578613,18.26372718811035),np.complex(19.08553695678711,-0.0)},0.00015000000000000001,true),'ext complex expm1 255')
end
do
 local a=np.array({np.complex(3.0,0.5),np.complex(5.0,3.0),np.complex(0.0,3.0),np.complex(0.0,-1.0),np.complex(0.0,-1.0),np.complex(-5.0,3.0),np.complex(-0.0,2.0),np.complex(0.0,3.0),np.complex(-1.0,2.0)},np.complex64)
 local r=np.expm1(a)
 assert(r.dtype=='complex64','ext complex dtype 256')
 assert(list_same(r:tolist(),{np.complex(16.62671661376953,9.62951946258545),np.complex(-147.92791748046875,20.94406509399414),np.complex(-1.9899924993515015,0.14112000167369843),np.complex(-0.4596977233886719,-0.8414709568023682),np.complex(-0.4596977233886719,-0.8414709568023682),np.complex(-1.0066704750061035,0.0009508591028861701),np.complex(-1.4161467552185059,0.9092974066734314),np.complex(-1.9899924993515015,0.14112000167369843),np.complex(-1.1530917882919312,0.33451181650161743)},0.00015000000000000001,true),'ext complex expm1 256')
end
do
 local a=np.array({np.complex(-5.0,2.0),np.complex(5.0,-1.0),np.complex(-1.0,0.0),np.complex(0.25,-3.0),np.complex(-5.0,-3.0),np.complex(5.0,-3.0),np.complex(0.0,-3.0),np.complex(-0.0,0.0),np.complex(-1.0,-1.0)},np.complex64)
 local r=np.expm1(a)
 assert(r.dtype=='complex64','ext complex dtype 257')
 assert(list_same(r:tolist(),{np.complex(-1.002803921699524,0.006126797758042812),np.complex(79.18797302246094,-124.88536834716797),np.complex(-0.6321205496788025,0.0),np.complex(-2.2711756229400635,-0.18120166659355164),np.complex(-1.0066704750061035,-0.0009508591028861701),np.complex(-147.92791748046875,-20.94406509399414),np.complex(-1.9899924993515015,-0.14112000167369843),np.complex(-0.0,0.0),np.complex(-0.8012338876724243,-0.3095598816871643)},0.00015000000000000001,true),'ext complex expm1 257')
end
do
 local a=np.array({np.complex(0.25,0.5),np.complex(0.25,2.0),np.complex(-2.0,-3.0),np.complex(3.0,3.0),np.complex(0.0,-0.0),np.complex(5.0,-3.0),np.complex(-5.0,2.0),np.complex(-1.0,0.0),np.complex(-2.0,3.0)},np.complex64)
 local r=np.expm1(a)
 assert(r.dtype=='complex64','ext complex dtype 258')
 assert(list_same(r:tolist(),{np.complex(0.1268383264541626,0.6155946254730225),np.complex(-1.5343430042266846,1.1675609350204468),np.complex(-1.1339808702468872,-0.019098514690995216),np.complex(-20.884531021118164,2.8344709873199463),np.complex(0.0,-0.0),np.complex(-147.92791748046875,-20.94406509399414),np.complex(-1.002803921699524,0.006126797758042812),np.complex(-0.6321205496788025,0.0),np.complex(-1.1339808702468872,0.019098514690995216)},0.00015000000000000001,true),'ext complex expm1 258')
end
do
 local a=np.array({np.complex(-0.0,0.0),np.complex(3.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,-3.0),np.complex(1.0,-1.0),np.complex(0.0,3.0),np.complex(-2.0,-3.0),np.complex(-0.0,-1.0),np.complex(-5.0,2.0)},np.complex64)
 local r=np.expm1(a)
 assert(r.dtype=='complex64','ext complex dtype 259')
 assert(list_same(r:tolist(),{np.complex(-0.0,0.0),np.complex(19.08553695678711,0.0),np.complex(-0.6321205496788025,0.0),np.complex(-1.9899924993515015,-0.14112000167369843),np.complex(0.4686938524246216,-2.2873551845550537),np.complex(-1.9899924993515015,0.14112000167369843),np.complex(-1.1339808702468872,-0.019098514690995216),np.complex(-0.4596977233886719,-0.8414709568023682),np.complex(-1.002803921699524,0.006126797758042812)},0.00015000000000000001,true),'ext complex expm1 259')
end
do
 local a=np.array({np.complex(1.0,-1.0),np.complex(-0.0,-0.0),np.complex(-5.0,3.0),np.complex(3.0,3.0),np.complex(3.0,-0.0),np.complex(5.0,0.0),np.complex(0.25,3.0),np.complex(5.0,-0.0),np.complex(-0.0,0.0)},np.complex64)
 local r=np.expm1(a)
 assert(r.dtype=='complex64','ext complex dtype 260')
 assert(list_same(r:tolist(),{np.complex(0.4686938524246216,-2.2873551845550537),np.complex(-0.0,-0.0),np.complex(-1.0066704750061035,0.0009508591028861701),np.complex(-20.884531021118164,2.8344709873199463),np.complex(19.08553695678711,-0.0),np.complex(147.4131622314453,0.0),np.complex(-2.2711756229400635,0.18120166659355164),np.complex(147.4131622314453,-0.0),np.complex(-0.0,0.0)},0.00015000000000000001,true),'ext complex expm1 260')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex((0/0),0.0),np.complex(1.0,(0/0)),np.complex((0/0),2.0)},np.complex64)
 local r=np.log1p(a)
 assert(r.dtype=='complex64','ext complex dtype 261')
 assert(list_same(r:tolist(),{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(math.huge,3.1415927410125732),np.complex(math.huge,1.5707963705062866),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},0.00015000000000000001,true),'ext complex log1p 261')
end
do
 local a=np.array({np.complex(-5.0,0.0),np.complex(-2.0,0.5),np.complex(-5.0,-3.0),np.complex(-0.0,3.0),np.complex(5.0,-3.0),np.complex(5.0,2.0),np.complex(-1.0,3.0),np.complex(0.0,3.0),np.complex(-5.0,-0.0)},np.complex64)
 local r=np.log1p(a)
 assert(r.dtype=='complex64','ext complex dtype 262')
 assert(list_same(r:tolist(),{np.complex(1.3862943649291992,3.1415927410125732),np.complex(0.1115717887878418,2.677945137023926),np.complex(1.6094379425048828,-2.498091459274292),np.complex(1.1512925624847412,1.249045729637146),np.complex(1.9033312797546387,-0.46364760398864746),np.complex(1.8444397449493408,0.32175055146217346),np.complex(1.0986123085021973,1.5707963705062866),np.complex(1.1512925624847412,1.249045729637146),np.complex(1.3862943649291992,-3.1415927410125732)},0.00015000000000000001,true),'ext complex log1p 262')
end
do
 local a=np.array({np.complex(-5.0,0.5),np.complex(-1.0,0.0),np.complex(1.0,-1.0),np.complex(0.25,0.0),np.complex(3.0,-3.0),np.complex(0.25,-3.0),np.complex(-2.0,-0.0),np.complex(-1.0,3.0),np.complex(-1.0,0.5)},np.complex64)
 local r=np.log1p(a)
 assert(r.dtype=='complex64','ext complex dtype 263')
 assert(list_same(r:tolist(),{np.complex(1.394046425819397,3.017237663269043),np.complex(-math.huge,0.0),np.complex(0.8047189712524414,-0.46364760398864746),np.complex(0.2231435477733612,0.0),np.complex(1.6094379425048828,-0.6435011029243469),np.complex(1.1786550283432007,-1.176005244255066),np.complex(0.0,-3.1415927410125732),np.complex(1.0986123085021973,1.5707963705062866),np.complex(-0.6931471824645996,1.5707963705062866)},0.00015000000000000001,true),'ext complex log1p 263')
end
do
 local a=np.array({np.complex(1.0,-3.0),np.complex(0.25,-0.0),np.complex(0.25,-0.0),np.complex(-0.0,-3.0),np.complex(-0.0,0.5),np.complex(-5.0,3.0),np.complex(-5.0,3.0),np.complex(-2.0,0.5),np.complex(-5.0,-1.0)},np.complex64)
 local r=np.log1p(a)
 assert(r.dtype=='complex64','ext complex dtype 264')
 assert(list_same(r:tolist(),{np.complex(1.2824746370315552,-0.9827937483787537),np.complex(0.2231435477733612,-0.0),np.complex(0.2231435477733612,-0.0),np.complex(1.1512925624847412,-1.249045729637146),np.complex(0.1115717887878418,0.46364760398864746),np.complex(1.6094379425048828,2.498091459274292),np.complex(1.6094379425048828,2.498091459274292),np.complex(0.1115717887878418,2.677945137023926),np.complex(1.4166066646575928,-2.8966140747070312)},0.00015000000000000001,true),'ext complex log1p 264')
end
do
 local a=np.array({np.complex(1.0,-1.0),np.complex(0.0,0.0),np.complex(-1.0,3.0),np.complex(5.0,-3.0),np.complex(-2.0,0.5),np.complex(1.0,2.0),np.complex(0.0,-0.0),np.complex(1.0,0.0),np.complex(-1.0,-3.0)},np.complex64)
 local r=np.log1p(a)
 assert(r.dtype=='complex64','ext complex dtype 265')
 assert(list_same(r:tolist(),{np.complex(0.8047189712524414,-0.46364760398864746),np.complex(0.0,0.0),np.complex(1.0986123085021973,1.5707963705062866),np.complex(1.9033312797546387,-0.46364760398864746),np.complex(0.1115717887878418,2.677945137023926),np.complex(1.0397207736968994,0.7853981852531433),np.complex(0.0,-0.0),np.complex(0.6931471824645996,0.0),np.complex(1.0986123085021973,-1.5707963705062866)},0.00015000000000000001,true),'ext complex log1p 265')
end
do
 local a=np.array({np.complex(-5.0,2.0),np.complex(3.0,2.0),np.complex(-0.0,0.5),np.complex(0.0,0.0),np.complex(1.0,-0.0),np.complex(5.0,3.0),np.complex(-5.0,0.5),np.complex(-0.0,0.0),np.complex(5.0,-3.0)},np.complex64)
 local r=np.log1p(a)
 assert(r.dtype=='complex64','ext complex dtype 266')
 assert(list_same(r:tolist(),{np.complex(1.497866153717041,2.677945137023926),np.complex(1.497866153717041,0.46364760398864746),np.complex(0.1115717887878418,0.46364760398864746),np.complex(0.0,0.0),np.complex(0.6931471824645996,-0.0),np.complex(1.9033312797546387,0.46364760398864746),np.complex(1.394046425819397,3.017237663269043),np.complex(0.0,0.0),np.complex(1.9033312797546387,-0.46364760398864746)},0.00015000000000000001,true),'ext complex log1p 266')
end
do
 local a=np.array({np.complex(-1.0,-0.0),np.complex(3.0,3.0),np.complex(-5.0,0.0),np.complex(-0.0,-0.0),np.complex(-5.0,0.0),np.complex(-0.0,0.0),np.complex(1.0,3.0),np.complex(5.0,-3.0),np.complex(0.25,0.0)},np.complex64)
 local r=np.log1p(a)
 assert(r.dtype=='complex64','ext complex dtype 267')
 assert(list_same(r:tolist(),{np.complex(-math.huge,-0.0),np.complex(1.6094379425048828,0.6435011029243469),np.complex(1.3862943649291992,3.1415927410125732),np.complex(0.0,-0.0),np.complex(1.3862943649291992,3.1415927410125732),np.complex(0.0,0.0),np.complex(1.2824746370315552,0.9827937483787537),np.complex(1.9033312797546387,-0.46364760398864746),np.complex(0.2231435477733612,0.0)},0.00015000000000000001,true),'ext complex log1p 267')
end
do
 local a=np.array({np.complex(1.0,0.0),np.complex(-1.0,-0.0),np.complex(-5.0,2.0),np.complex(0.25,3.0),np.complex(-1.0,3.0),np.complex(-1.0,2.0),np.complex(3.0,-1.0),np.complex(0.25,0.0),np.complex(1.0,-1.0)},np.complex64)
 local r=np.log1p(a)
 assert(r.dtype=='complex64','ext complex dtype 268')
 assert(list_same(r:tolist(),{np.complex(0.6931471824645996,0.0),np.complex(-math.huge,-0.0),np.complex(1.497866153717041,2.677945137023926),np.complex(1.1786550283432007,1.176005244255066),np.complex(1.0986123085021973,1.5707963705062866),np.complex(0.6931471824645996,1.5707963705062866),np.complex(1.4166066646575928,-0.244978666305542),np.complex(0.2231435477733612,0.0),np.complex(0.8047189712524414,-0.46364760398864746)},0.00015000000000000001,true),'ext complex log1p 268')
end
do
 local a=np.array({np.complex(3.0,3.0),np.complex(5.0,3.0),np.complex(-5.0,-1.0),np.complex(-1.0,0.0),np.complex(0.25,0.0),np.complex(-5.0,-3.0),np.complex(-0.0,0.5),np.complex(0.25,-0.0),np.complex(3.0,-1.0)},np.complex64)
 local r=np.log1p(a)
 assert(r.dtype=='complex64','ext complex dtype 269')
 assert(list_same(r:tolist(),{np.complex(1.6094379425048828,0.6435011029243469),np.complex(1.9033312797546387,0.46364760398864746),np.complex(1.4166066646575928,-2.8966140747070312),np.complex(-math.huge,0.0),np.complex(0.2231435477733612,0.0),np.complex(1.6094379425048828,-2.498091459274292),np.complex(0.1115717887878418,0.46364760398864746),np.complex(0.2231435477733612,-0.0),np.complex(1.4166066646575928,-0.244978666305542)},0.00015000000000000001,true),'ext complex log1p 269')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex((0/0),0.0),np.complex(1.0,(0/0)),np.complex((0/0),2.0)},np.complex128)
 local r=np.sinh(a)
 assert(r.dtype=='complex128','ext complex dtype 270')
 assert(list_same(r:tolist(),{np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,(0/0)),np.complex((0/0),0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},1.2e-11,true),'ext complex sinh 270')
end
do
 local a=np.array({np.complex(-5.0,-1.0),np.complex(5.0,-1.0),np.complex(-0.0,-1.0),np.complex(-5.0,0.0),np.complex(5.0,-3.0),np.complex(1.0,-0.0),np.complex(1.0,2.0),np.complex(3.0,-0.0),np.complex(-0.0,3.0)},np.complex128)
 local r=np.sinh(a)
 assert(r.dtype=='complex128','ext complex dtype 271')
 assert(list_same(r:tolist(),{np.complex(-40.0921657779984,-62.44551846769654),np.complex(40.0921657779984,-62.44551846769654),np.complex(-0.0,-0.8414709848078965),np.complex(-74.20321057778875,0.0),np.complex(-73.46062169567367,-10.472508533940392),np.complex(1.1752011936438014,-0.0),np.complex(-0.4890562590412937,1.4031192506220405),np.complex(10.017874927409903,-0.0),np.complex(0.0,0.1411200080598672)},1.2e-11,true),'ext complex sinh 271')
end
do
 local a=np.array({np.complex(5.0,2.0),np.complex(1.0,-1.0),np.complex(-0.0,-3.0),np.complex(5.0,0.0),np.complex(3.0,-1.0),np.complex(-1.0,-1.0),np.complex(5.0,-3.0),np.complex(-5.0,0.5),np.complex(5.0,3.0)},np.complex128)
 local r=np.sinh(a)
 assert(r.dtype=='complex128','ext complex dtype 272')
 assert(list_same(r:tolist(),{np.complex(-30.879431343588244,67.47891523845588),np.complex(0.6349639147847361,-1.2984575814159773),np.complex(0.0,-0.1411200080598672),np.complex(74.20321057778875,0.0),np.complex(5.412680923178193,-8.471645454300148),np.complex(-0.6349639147847361,-1.2984575814159773),np.complex(-73.46062169567367,-10.472508533940392),np.complex(-65.11944363934666,35.57814454128659),np.complex(-73.46062169567367,10.472508533940392)},1.2e-11,true),'ext complex sinh 272')
end
do
 local a=np.array({np.complex(-0.0,0.0),np.complex(-1.0,0.5),np.complex(-1.0,0.0),np.complex(0.25,-1.0),np.complex(-2.0,-1.0),np.complex(3.0,3.0),np.complex(0.25,3.0),np.complex(-5.0,-1.0),np.complex(-0.0,3.0)},np.complex128)
 local r=np.sinh(a)
 assert(r.dtype=='complex128','ext complex dtype 273')
 assert(list_same(r:tolist(),{np.complex(-0.0,0.0),np.complex(-1.0313360742545512,0.7397922644560138),np.complex(-1.1752011936438014,0.0),np.complex(0.13648701726214638,-0.8679041968994298),np.complex(-1.9596010414216063,-3.165778513216168),np.complex(-9.917621010017536,1.4207485419881771),np.complex(-0.25008429818894123,0.145553024968058),np.complex(-40.0921657779984,-62.44551846769654),np.complex(0.0,0.1411200080598672)},1.2e-11,true),'ext complex sinh 273')
end
do
 local a=np.array({np.complex(-5.0,-0.0),np.complex(1.0,-0.0),np.complex(-5.0,2.0),np.complex(-5.0,3.0),np.complex(-1.0,-3.0),np.complex(-1.0,-0.0),np.complex(-2.0,0.5),np.complex(-0.0,3.0),np.complex(-0.0,2.0)},np.complex128)
 local r=np.sinh(a)
 assert(r.dtype=='complex128','ext complex dtype 274')
 assert(list_same(r:tolist(),{np.complex(-74.20321057778875,-0.0),np.complex(1.1752011936438014,-0.0),np.complex(30.879431343588244,67.47891523845588),np.complex(73.46062169567367,10.472508533940392),np.complex(1.1634403637032504,-0.21775955162215221),np.complex(-1.1752011936438014,-0.0),np.complex(-3.1828694483371494,1.8036926955321817),np.complex(0.0,0.1411200080598672),np.complex(0.0,0.9092974268256817)},1.2e-11,true),'ext complex sinh 274')
end
do
 local a=np.array({np.complex(-5.0,2.0),np.complex(-2.0,0.5),np.complex(-2.0,0.5),np.complex(-5.0,-0.0),np.complex(0.0,-3.0),np.complex(-0.0,2.0),np.complex(0.0,0.0),np.complex(5.0,0.5),np.complex(-0.0,0.5)},np.complex128)
 local r=np.sinh(a)
 assert(r.dtype=='complex128','ext complex dtype 275')
 assert(list_same(r:tolist(),{np.complex(30.879431343588244,67.47891523845588),np.complex(-3.1828694483371494,1.8036926955321817),np.complex(-3.1828694483371494,1.8036926955321817),np.complex(-74.20321057778875,-0.0),np.complex(-0.0,-0.1411200080598672),np.complex(0.0,0.9092974268256817),np.complex(0.0,0.0),np.complex(65.11944363934666,35.57814454128659),np.complex(-0.0,0.479425538604203)},1.2e-11,true),'ext complex sinh 275')
end
do
 local a=np.array({np.complex(-2.0,0.0),np.complex(5.0,-1.0),np.complex(-5.0,0.0),np.complex(-1.0,-3.0),np.complex(5.0,0.0),np.complex(0.0,-0.0),np.complex(0.25,-3.0),np.complex(0.0,2.0),np.complex(-0.0,-1.0)},np.complex128)
 local r=np.sinh(a)
 assert(r.dtype=='complex128','ext complex dtype 276')
 assert(list_same(r:tolist(),{np.complex(-3.626860407847019,0.0),np.complex(40.0921657779984,-62.44551846769654),np.complex(-74.20321057778875,0.0),np.complex(1.1634403637032504,-0.21775955162215221),np.complex(74.20321057778875,0.0),np.complex(0.0,-0.0),np.complex(-0.25008429818894123,-0.145553024968058),np.complex(-0.0,0.9092974268256817),np.complex(-0.0,-0.8414709848078965)},1.2e-11,true),'ext complex sinh 276')
end
do
 local a=np.array({np.complex(3.0,2.0),np.complex(0.0,-1.0),np.complex(-2.0,3.0),np.complex(1.0,3.0),np.complex(0.0,-1.0),np.complex(1.0,-0.0),np.complex(3.0,2.0),np.complex(3.0,0.5),np.complex(-5.0,-0.0)},np.complex128)
 local r=np.sinh(a)
 assert(r.dtype=='complex128','ext complex dtype 277')
 assert(list_same(r:tolist(),{np.complex(-4.168906959966565,9.15449914691143),np.complex(0.0,-0.8414709848078965),np.complex(3.59056458998578,0.5309210862485197),np.complex(-1.1634403637032504,0.21775955162215221),np.complex(0.0,-0.8414709848078965),np.complex(1.1752011936438014,-0.0),np.complex(-4.168906959966565,9.15449914691143),np.complex(8.791512343493714,4.82669427481082),np.complex(-74.20321057778875,-0.0)},1.2e-11,true),'ext complex sinh 277')
end
do
 local a=np.array({np.complex(5.0,3.0),np.complex(-0.0,-1.0),np.complex(0.0,-0.0),np.complex(-5.0,3.0),np.complex(1.0,-3.0),np.complex(-2.0,-1.0),np.complex(1.0,3.0),np.complex(0.25,-3.0),np.complex(-1.0,3.0)},np.complex128)
 local r=np.sinh(a)
 assert(r.dtype=='complex128','ext complex dtype 278')
 assert(list_same(r:tolist(),{np.complex(-73.46062169567367,10.472508533940392),np.complex(-0.0,-0.8414709848078965),np.complex(0.0,-0.0),np.complex(73.46062169567367,10.472508533940392),np.complex(-1.1634403637032504,-0.21775955162215221),np.complex(-1.9596010414216063,-3.165778513216168),np.complex(-1.1634403637032504,0.21775955162215221),np.complex(-0.25008429818894123,-0.145553024968058),np.complex(1.1634403637032504,0.21775955162215221)},1.2e-11,true),'ext complex sinh 278')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex((0/0),0.0),np.complex(1.0,(0/0)),np.complex((0/0),2.0)},np.complex128)
 local r=np.cosh(a)
 assert(r.dtype=='complex128','ext complex dtype 279')
 assert(list_same(r:tolist(),{np.complex(1.0,0.0),np.complex(1.0,-0.0),np.complex(1.0,-0.0),np.complex(math.huge,0.0),np.complex(math.huge,-0.0),np.complex((0/0),0.0),np.complex((0/0),0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},1.2e-11,true),'ext complex cosh 279')
end
do
 local a=np.array({np.complex(-5.0,-1.0),np.complex(5.0,-0.0),np.complex(-1.0,-3.0),np.complex(0.0,0.0),np.complex(-2.0,0.0),np.complex(0.25,-1.0),np.complex(-2.0,-0.0),np.complex(-5.0,3.0),np.complex(-2.0,3.0)},np.complex128)
 local r=np.cosh(a)
 assert(r.dtype=='complex128','ext complex dtype 280')
 assert(list_same(r:tolist(),{np.complex(40.09580630629883,62.43984868079963),np.complex(74.20994852478785,-0.0),np.complex(-1.5276382501165433,0.1658444019189788),np.complex(1.0,0.0),np.complex(3.7621956910836314,-0.0),np.complex(0.5572748761675393,-0.21256593499917373),np.complex(3.7621956910836314,0.0),np.complex(-73.46729221264526,-10.471557674805572),np.complex(-3.7245455049153224,-0.5118225699873846)},1.2e-11,true),'ext complex cosh 280')
end
do
 local a=np.array({np.complex(-1.0,2.0),np.complex(0.25,-1.0),np.complex(-5.0,0.0),np.complex(3.0,2.0),np.complex(5.0,-1.0),np.complex(-2.0,0.5),np.complex(3.0,2.0),np.complex(-0.0,3.0),np.complex(3.0,0.0)},np.complex128)
 local r=np.cosh(a)
 assert(r.dtype=='complex128','ext complex dtype 281')
 assert(list_same(r:tolist(),{np.complex(-0.64214812471552,-1.0686074213827783),np.complex(0.5572748761675393,-0.21256593499917373),np.complex(74.20994852478785,-0.0),np.complex(-4.189625690968807,9.109227893755337),np.complex(40.09580630629883,-62.43984868079963),np.complex(3.3016373329140944,-1.7388095044743164),np.complex(-4.189625690968807,9.109227893755337),np.complex(-0.9899924966004454,-0.0),np.complex(10.067661995777765,0.0)},1.2e-11,true),'ext complex cosh 281')
end
do
 local a=np.array({np.complex(-2.0,-1.0),np.complex(5.0,-0.0),np.complex(0.25,3.0),np.complex(0.0,0.5),np.complex(-2.0,3.0),np.complex(0.25,0.5),np.complex(0.25,3.0),np.complex(5.0,-3.0),np.complex(5.0,-0.0)},np.complex128)
 local r=np.cosh(a)
 assert(r.dtype=='complex128','ext complex dtype 282')
 assert(list_same(r:tolist(),{np.complex(2.0327230070196656,3.0518977991518),np.complex(74.20994852478785,-0.0),np.complex(-1.0210912297761832,0.035648652183990444),np.complex(0.8775825618903728,0.0),np.complex(-3.7245455049153224,-0.5118225699873846),np.complex(0.9051501505596068,0.12110879604381165),np.complex(-1.0210912297761832,0.035648652183990444),np.complex(-73.46729221264526,-10.471557674805572),np.complex(74.20994852478785,-0.0)},1.2e-11,true),'ext complex cosh 282')
end
do
 local a=np.array({np.complex(3.0,0.0),np.complex(-5.0,-3.0),np.complex(5.0,0.5),np.complex(0.25,-1.0),np.complex(-5.0,-3.0),np.complex(-5.0,-1.0),np.complex(1.0,3.0),np.complex(-2.0,2.0),np.complex(1.0,2.0)},np.complex128)
 local r=np.cosh(a)
 assert(r.dtype=='complex128','ext complex dtype 283')
 assert(list_same(r:tolist(),{np.complex(10.067661995777765,0.0),np.complex(-73.46729221264526,10.471557674805572),np.complex(65.12535674413601,35.57491419741746),np.complex(0.5572748761675393,-0.21256593499917373),np.complex(-73.46729221264526,10.471557674805572),np.complex(40.09580630629883,62.43984868079963),np.complex(-1.5276382501165433,0.1658444019189788),np.complex(-1.5656258353157435,-3.297894836311237),np.complex(-0.64214812471552,1.0686074213827783)},1.2e-11,true),'ext complex cosh 283')
end
do
 local a=np.array({np.complex(3.0,3.0),np.complex(0.25,-0.0),np.complex(-2.0,2.0),np.complex(3.0,-3.0),np.complex(0.25,0.0),np.complex(0.25,-3.0),np.complex(5.0,2.0),np.complex(-1.0,2.0),np.complex(-1.0,-3.0)},np.complex128)
 local r=np.cosh(a)
 assert(r.dtype=='complex128','ext complex dtype 284')
 assert(list_same(r:tolist(),{np.complex(-9.966909834129453,1.413722590498827),np.complex(1.0314130998795732,-0.0),np.complex(-1.5656258353157435,-3.297894836311237),np.complex(-9.966909834129453,-1.413722590498827),np.complex(1.0314130998795732,0.0),np.complex(-1.0210912297761832,-0.035648652183990444),np.complex(-30.88223531891674,67.47278844058752),np.complex(-0.64214812471552,-1.0686074213827783),np.complex(-1.5276382501165433,0.1658444019189788)},1.2e-11,true),'ext complex cosh 284')
end
do
 local a=np.array({np.complex(3.0,-0.0),np.complex(-1.0,-1.0),np.complex(0.0,2.0),np.complex(-1.0,0.0),np.complex(0.25,0.0),np.complex(0.25,0.5),np.complex(1.0,-1.0),np.complex(3.0,0.5),np.complex(-2.0,2.0)},np.complex128)
 local r=np.cosh(a)
 assert(r.dtype=='complex128','ext complex dtype 285')
 assert(list_same(r:tolist(),{np.complex(10.067661995777765,-0.0),np.complex(0.8337300251311491,0.9888977057628651),np.complex(-0.4161468365471424,0.0),np.complex(1.5430806348152437,-0.0),np.complex(1.0314130998795732,0.0),np.complex(0.9051501505596068,0.12110879604381165),np.complex(0.8337300251311491,-0.9888977057628651),np.complex(8.835204606500994,4.802825082743033),np.complex(-1.5656258353157435,-3.297894836311237)},1.2e-11,true),'ext complex cosh 285')
end
do
 local a=np.array({np.complex(-0.0,2.0),np.complex(-5.0,2.0),np.complex(-2.0,-1.0),np.complex(1.0,3.0),np.complex(1.0,0.5),np.complex(-0.0,-3.0),np.complex(0.0,-0.0),np.complex(3.0,0.5),np.complex(0.0,0.0)},np.complex128)
 local r=np.cosh(a)
 assert(r.dtype=='complex128','ext complex dtype 286')
 assert(list_same(r:tolist(),{np.complex(-0.4161468365471424,-0.0),np.complex(-30.88223531891674,-67.47278844058752),np.complex(2.0327230070196656,3.0518977991518),np.complex(-1.5276382501165433,0.1658444019189788),np.complex(1.3541806567045842,0.5634214652309818),np.complex(-0.9899924966004454,0.0),np.complex(1.0,-0.0),np.complex(8.835204606500994,4.802825082743033),np.complex(1.0,0.0)},1.2e-11,true),'ext complex cosh 286')
end
do
 local a=np.array({np.complex(3.0,-1.0),np.complex(-5.0,0.5),np.complex(0.0,0.5),np.complex(0.0,0.5),np.complex(-2.0,0.5),np.complex(-0.0,-3.0),np.complex(5.0,-3.0),np.complex(-2.0,2.0),np.complex(-0.0,3.0)},np.complex128)
 local r=np.cosh(a)
 assert(r.dtype=='complex128','ext complex dtype 287')
 assert(list_same(r:tolist(),{np.complex(5.439580991019764,-8.429751080849945),np.complex(65.12535674413601,-35.57491419741746),np.complex(0.8775825618903728,0.0),np.complex(0.8775825618903728,0.0),np.complex(3.3016373329140944,-1.7388095044743164),np.complex(-0.9899924966004454,0.0),np.complex(-73.46729221264526,-10.471557674805572),np.complex(-1.5656258353157435,-3.297894836311237),np.complex(-0.9899924966004454,-0.0)},1.2e-11,true),'ext complex cosh 287')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex((0/0),0.0),np.complex(1.0,(0/0)),np.complex((0/0),2.0)},np.complex128)
 local r=np.tanh(a)
 assert(r.dtype=='complex128','ext complex dtype 288')
 assert(list_same(r:tolist(),{np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(1.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,(0/0)),np.complex((0/0),0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},1.2e-11,true),'ext complex tanh 288')
end
do
 local a=np.array({np.complex(1.0,-1.0),np.complex(1.0,-3.0),np.complex(0.0,-1.0),np.complex(1.0,0.0),np.complex(0.25,0.5),np.complex(0.0,-3.0),np.complex(5.0,2.0),np.complex(-1.0,0.0),np.complex(1.0,0.0)},np.complex128)
 local r=np.tanh(a)
 assert(r.dtype=='complex128','ext complex dtype 289')
 assert(list_same(r:tolist(),{np.complex(1.0839233273386946,-0.2717525853195118),np.complex(0.7680176472869112,0.05916853956605073),np.complex(0.0,-1.557407724654902),np.complex(0.7615941559557649,0.0),np.complex(0.3124206925025888,0.504500702698564),np.complex(0.0,0.1425465430742778),np.complex(1.0000593501490003,-6.872163880119278e-05),np.complex(-0.7615941559557649,0.0),np.complex(0.7615941559557649,0.0)},1.2e-11,true),'ext complex tanh 289')
end
do
 local a=np.array({np.complex(5.0,-0.0),np.complex(0.25,2.0),np.complex(-0.0,3.0),np.complex(1.0,-0.0),np.complex(-1.0,0.0),np.complex(-2.0,-0.0),np.complex(-0.0,-0.0),np.complex(3.0,3.0),np.complex(1.0,2.0)},np.complex128)
 local r=np.tanh(a)
 assert(r.dtype=='complex128','ext complex dtype 290')
 assert(list_same(r:tolist(),{np.complex(0.9999092042625953,-0.0),np.complex(1.099398135211779,-1.596689210770756),np.complex(-0.0,-0.1425465430742778),np.complex(0.7615941559557649,-0.0),np.complex(-0.7615941559557649,0.0),np.complex(-0.9640275800758168,-0.0),np.complex(-0.0,-0.0),np.complex(0.9952503011786028,-0.0013786327196592895),np.complex(1.16673625724092,-0.2434582011857253)},1.2e-11,true),'ext complex tanh 290')
end
do
 local a=np.array({np.complex(-0.0,-3.0),np.complex(1.0,0.5),np.complex(0.0,3.0),np.complex(-1.0,2.0),np.complex(0.0,-0.0),np.complex(0.25,-1.0),np.complex(1.0,0.5),np.complex(0.25,0.5),np.complex(-5.0,3.0)},np.complex128)
 local r=np.tanh(a)
 assert(r.dtype=='complex128','ext complex dtype 291')
 assert(list_same(r:tolist(),{np.complex(-0.0,0.1425465430742778),np.complex(0.8429662048457833,0.195577310065934),np.complex(0.0,-0.1425465430742778),np.complex(-1.16673625724092,-0.2434582011857253),np.complex(0.0,-0.0),np.complex(0.7324112324640304,-1.278038090223709),np.complex(0.8429662048457833,0.195577310065934),np.complex(0.3124206925025888,0.504500702698564),np.complex(-0.999912820151354,-2.5368676207676034e-05)},1.2e-11,true),'ext complex tanh 291')
end
do
 local a=np.array({np.complex(3.0,-3.0),np.complex(5.0,0.5),np.complex(-0.0,-3.0),np.complex(-1.0,3.0),np.complex(0.0,0.0),np.complex(1.0,2.0),np.complex(-0.0,0.5),np.complex(-0.0,3.0),np.complex(-1.0,-0.0)},np.complex128)
 local r=np.tanh(a)
 assert(r.dtype=='complex128','ext complex dtype 292')
 assert(list_same(r:tolist(),{np.complex(0.9952503011786028,0.0013786327196592895),np.complex(0.9999509389112266,7.640169883794197e-05),np.complex(-0.0,0.1425465430742778),np.complex(-0.7680176472869112,-0.05916853956605073),np.complex(0.0,0.0),np.complex(1.16673625724092,-0.2434582011857253),np.complex(-0.0,0.5463024898437905),np.complex(-0.0,-0.1425465430742778),np.complex(-0.7615941559557649,-0.0)},1.2e-11,true),'ext complex tanh 292')
end
do
 local a=np.array({np.complex(-1.0,-0.0),np.complex(-0.0,-1.0),np.complex(1.0,0.0),np.complex(5.0,-3.0),np.complex(1.0,-3.0),np.complex(0.0,2.0),np.complex(0.0,-1.0),np.complex(5.0,0.0),np.complex(0.0,-1.0)},np.complex128)
 local r=np.tanh(a)
 assert(r.dtype=='complex128','ext complex dtype 293')
 assert(list_same(r:tolist(),{np.complex(-0.7615941559557649,-0.0),np.complex(-0.0,-1.557407724654902),np.complex(0.7615941559557649,0.0),np.complex(0.999912820151354,2.5368676207676034e-05),np.complex(0.7680176472869112,0.05916853956605073),np.complex(0.0,-2.185039863261519),np.complex(0.0,-1.557407724654902),np.complex(0.9999092042625953,0.0),np.complex(0.0,-1.557407724654902)},1.2e-11,true),'ext complex tanh 293')
end
do
 local a=np.array({np.complex(0.25,3.0),np.complex(-1.0,-1.0),np.complex(5.0,3.0),np.complex(0.0,0.0),np.complex(0.25,0.5),np.complex(-1.0,-0.0),np.complex(-2.0,-1.0),np.complex(-2.0,-1.0),np.complex(-5.0,0.0)},np.complex128)
 local r=np.tanh(a)
 assert(r.dtype=='complex128','ext complex dtype 294')
 assert(list_same(r:tolist(),{np.complex(0.24959107241921716,-0.1338327425151915),np.complex(-1.0839233273386946,-0.2717525853195118),np.complex(0.999912820151354,-2.5368676207676034e-05),np.complex(0.0,0.0),np.complex(0.3124206925025888,0.504500702698564),np.complex(-0.7615941559557649,-0.0),np.complex(-1.0147936161466335,-0.03381282607989669),np.complex(-1.0147936161466335,-0.03381282607989669),np.complex(-0.9999092042625953,0.0)},1.2e-11,true),'ext complex tanh 294')
end
do
 local a=np.array({np.complex(0.25,-3.0),np.complex(1.0,-1.0),np.complex(-1.0,3.0),np.complex(-0.0,2.0),np.complex(5.0,-0.0),np.complex(5.0,-1.0),np.complex(-5.0,3.0),np.complex(-0.0,2.0),np.complex(0.25,-0.0)},np.complex128)
 local r=np.tanh(a)
 assert(r.dtype=='complex128','ext complex dtype 295')
 assert(list_same(r:tolist(),{np.complex(0.24959107241921716,0.1338327425151915),np.complex(1.0839233273386946,-0.2717525853195118),np.complex(-0.7680176472869112,-0.05916853956605073),np.complex(-0.0,-2.185039863261519),np.complex(0.9999092042625953,-0.0),np.complex(1.000037783379601,-8.2567198342296e-05),np.complex(-0.999912820151354,-2.5368676207676034e-05),np.complex(-0.0,-2.185039863261519),np.complex(0.24491866240370916,-0.0)},1.2e-11,true),'ext complex tanh 295')
end
do
 local a=np.array({np.complex(3.0,-1.0),np.complex(3.0,-0.0),np.complex(-5.0,0.0),np.complex(-2.0,-3.0),np.complex(5.0,0.0),np.complex(0.0,-1.0),np.complex(-1.0,-1.0),np.complex(0.25,0.0),np.complex(1.0,2.0)},np.complex128)
 local r=np.tanh(a)
 assert(r.dtype=='complex128','ext complex dtype 296')
 assert(list_same(r:tolist(),{np.complex(1.0020549882458116,-0.004517137276658425),np.complex(0.9950547536867302,-0.0),np.complex(-0.9999092042625953,0.0),np.complex(-0.965385879022133,0.009884375038322492),np.complex(0.9999092042625953,0.0),np.complex(0.0,-1.557407724654902),np.complex(-1.0839233273386946,-0.2717525853195118),np.complex(0.24491866240370916,0.0),np.complex(1.16673625724092,-0.2434582011857253)},1.2e-11,true),'ext complex tanh 296')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex((0/0),0.0),np.complex(1.0,(0/0)),np.complex((0/0),2.0)},np.complex128)
 local r=np.exp2(a)
 assert(r.dtype=='complex128','ext complex dtype 297')
 assert(list_same(r:tolist(),{np.complex(1.0,0.0),np.complex(1.0,0.0),np.complex(1.0,-0.0),np.complex(math.huge,0.0),np.complex(0.0,0.0),np.complex((0/0),(0/0)),np.complex((0/0),0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},1.2e-11,true),'ext complex exp2 297')
end
do
 local a=np.array({np.complex(3.0,0.5),np.complex(0.0,2.0),np.complex(0.25,3.0),np.complex(0.25,-0.0),np.complex(-1.0,3.0),np.complex(5.0,3.0),np.complex(5.0,-1.0),np.complex(5.0,-3.0),np.complex(5.0,0.5)},np.complex128)
 local r=np.exp2(a)
 assert(r.dtype=='complex128','ext complex dtype 298')
 assert(list_same(r:tolist(),{np.complex(7.524336837465949,2.7174170008213476),np.complex(0.18345697474330172,0.9830277404112437),np.complex(-0.579137226811516,1.0386595375262107),np.complex(1.189207115002721,-0.0),np.complex(-0.24349720898289062,0.43670254088743576),np.complex(-15.583821374905,27.94896261679589),np.complex(24.615644843647107,-20.446760842036312),np.complex(-15.583821374905,-27.94896261679589),np.complex(30.097347349863803,10.869668003285392)},1.2e-11,true),'ext complex exp2 298')
end
do
 local a=np.array({np.complex(-2.0,0.5),np.complex(5.0,-3.0),np.complex(-2.0,2.0),np.complex(-0.0,2.0),np.complex(-0.0,-1.0),np.complex(1.0,0.5),np.complex(-1.0,-0.0),np.complex(0.25,-1.0),np.complex(-5.0,0.5)},np.complex128)
 local r=np.exp2(a)
 assert(r.dtype=='complex128','ext complex dtype 299')
 assert(list_same(r:tolist(),{np.complex(0.23513552617081096,0.08491928127566713),np.complex(-15.583821374905,-27.94896261679589),np.complex(0.04586424368582543,0.24575693510281094),np.complex(0.18345697474330172,0.9830277404112437),np.complex(0.7692389013639721,-0.6389612763136348),np.complex(1.8810842093664877,0.679354250205337),np.complex(0.5,-0.0),np.complex(0.9147843746389119,-0.759857296003394),np.complex(0.02939194077135137,0.010614910159458391)},1.2e-11,true),'ext complex exp2 299')
end
do
 local a=np.array({np.complex(5.0,3.0),np.complex(-1.0,-1.0),np.complex(-0.0,0.0),np.complex(5.0,0.0),np.complex(3.0,-0.0),np.complex(5.0,-3.0),np.complex(-1.0,0.5),np.complex(0.25,2.0),np.complex(5.0,0.5)},np.complex128)
 local r=np.exp2(a)
 assert(r.dtype=='complex128','ext complex dtype 300')
 assert(list_same(r:tolist(),{np.complex(-15.583821374905,27.94896261679589),np.complex(0.38461945068198605,-0.3194806381568174),np.complex(1.0,0.0),np.complex(32.0,0.0),np.complex(7.999999999999998,-0.0),np.complex(-15.583821374905,-27.94896261679589),np.complex(0.4702710523416219,0.16983856255133425),np.complex(0.2181683396616089,1.169023583142099),np.complex(30.097347349863803,10.869668003285392)},1.2e-11,true),'ext complex exp2 300')
end
do
 local a=np.array({np.complex(-5.0,-1.0),np.complex(0.0,0.0),np.complex(0.0,0.5),np.complex(-2.0,0.0),np.complex(1.0,3.0),np.complex(1.0,-1.0),np.complex(-1.0,0.5),np.complex(0.25,-0.0),np.complex(0.25,-3.0)},np.complex128)
 local r=np.exp2(a)
 assert(r.dtype=='complex128','ext complex dtype 301')
 assert(list_same(r:tolist(),{np.complex(0.02403871566762413,-0.019967539884801086),np.complex(1.0,0.0),np.complex(0.9405421046832438,0.3396771251026685),np.complex(0.25,0.0),np.complex(-0.9739888359315625,1.746810163549743),np.complex(1.5384778027279442,-1.2779225526272695),np.complex(0.4702710523416219,0.16983856255133425),np.complex(1.189207115002721,-0.0),np.complex(-0.579137226811516,-1.0386595375262107)},1.2e-11,true),'ext complex exp2 301')
end
do
 local a=np.array({np.complex(1.0,0.5),np.complex(-0.0,2.0),np.complex(-1.0,-3.0),np.complex(-0.0,-1.0),np.complex(-1.0,3.0),np.complex(-5.0,3.0),np.complex(3.0,3.0),np.complex(-0.0,-1.0),np.complex(0.0,-0.0)},np.complex128)
 local r=np.exp2(a)
 assert(r.dtype=='complex128','ext complex dtype 302')
 assert(list_same(r:tolist(),{np.complex(1.8810842093664877,0.679354250205337),np.complex(0.18345697474330172,0.9830277404112437),np.complex(-0.24349720898289062,-0.43670254088743576),np.complex(0.7692389013639721,-0.6389612763136348),np.complex(-0.24349720898289062,0.43670254088743576),np.complex(-0.015218575561430664,0.027293908805464735),np.complex(-3.895955343726249,6.9872406541989704),np.complex(0.7692389013639721,-0.6389612763136348),np.complex(1.0,-0.0)},1.2e-11,true),'ext complex exp2 302')
end
do
 local a=np.array({np.complex(1.0,0.0),np.complex(1.0,-1.0),np.complex(-2.0,-3.0),np.complex(-1.0,-1.0),np.complex(-1.0,0.5),np.complex(-5.0,3.0),np.complex(3.0,2.0),np.complex(0.0,-3.0),np.complex(0.0,0.0)},np.complex128)
 local r=np.exp2(a)
 assert(r.dtype=='complex128','ext complex dtype 303')
 assert(list_same(r:tolist(),{np.complex(2.0,0.0),np.complex(1.5384778027279442,-1.2779225526272695),np.complex(-0.12174860449144531,-0.21835127044371788),np.complex(0.38461945068198605,-0.3194806381568174),np.complex(0.4702710523416219,0.16983856255133425),np.complex(-0.015218575561430664,0.027293908805464735),np.complex(1.4676557979464135,7.864221923289948),np.complex(-0.48699441796578125,-0.8734050817748715),np.complex(1.0,0.0)},1.2e-11,true),'ext complex exp2 303')
end
do
 local a=np.array({np.complex(1.0,-0.0),np.complex(-1.0,0.0),np.complex(0.25,-0.0),np.complex(-2.0,-0.0),np.complex(-1.0,2.0),np.complex(-1.0,-3.0),np.complex(5.0,0.5),np.complex(3.0,-3.0),np.complex(3.0,3.0)},np.complex128)
 local r=np.exp2(a)
 assert(r.dtype=='complex128','ext complex dtype 304')
 assert(list_same(r:tolist(),{np.complex(2.0,-0.0),np.complex(0.5,0.0),np.complex(1.189207115002721,-0.0),np.complex(0.25,-0.0),np.complex(0.09172848737165086,0.4915138702056219),np.complex(-0.24349720898289062,-0.43670254088743576),np.complex(30.097347349863803,10.869668003285392),np.complex(-3.895955343726249,-6.9872406541989704),np.complex(-3.895955343726249,6.9872406541989704)},1.2e-11,true),'ext complex exp2 304')
end
do
 local a=np.array({np.complex(0.0,3.0),np.complex(5.0,-0.0),np.complex(0.0,-3.0),np.complex(-1.0,-3.0),np.complex(-1.0,-3.0),np.complex(3.0,0.0),np.complex(0.0,-1.0),np.complex(3.0,-0.0),np.complex(-1.0,0.5)},np.complex128)
 local r=np.exp2(a)
 assert(r.dtype=='complex128','ext complex dtype 305')
 assert(list_same(r:tolist(),{np.complex(-0.48699441796578125,0.8734050817748715),np.complex(32.0,-0.0),np.complex(-0.48699441796578125,-0.8734050817748715),np.complex(-0.24349720898289062,-0.43670254088743576),np.complex(-0.24349720898289062,-0.43670254088743576),np.complex(7.999999999999998,0.0),np.complex(0.7692389013639721,-0.6389612763136348),np.complex(7.999999999999998,-0.0),np.complex(0.4702710523416219,0.16983856255133425)},1.2e-11,true),'ext complex exp2 305')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex((0/0),0.0),np.complex(1.0,(0/0)),np.complex((0/0),2.0)},np.complex128)
 local r=np.log2(a)
 assert(r.dtype=='complex128','ext complex dtype 306')
 assert(list_same(r:tolist(),{np.complex(-math.huge,0.0),np.complex(-math.huge,4.532360141827193),np.complex(-math.huge,-0.0),np.complex(math.huge,0.0),np.complex(math.huge,4.532360141827193),np.complex(math.huge,2.2661800709135966),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},1.2e-11,true),'ext complex log2 306')
end
do
 local a=np.array({np.complex(-0.0,0.0),np.complex(1.0,2.0),np.complex(0.25,0.0),np.complex(3.0,-1.0),np.complex(-0.0,-3.0),np.complex(-0.0,0.5),np.complex(-0.0,3.0),np.complex(0.0,3.0),np.complex(0.0,3.0)},np.complex128)
 local r=np.log2(a)
 assert(r.dtype=='complex128','ext complex dtype 307')
 assert(list_same(r:tolist(),{np.complex(-math.huge,4.532360141827193),np.complex(1.1609640474436813,1.5972779646881086),np.complex(-2.0,0.0),np.complex(1.6609640474436813,-0.46418792923131036),np.complex(1.5849625007211563,-2.2661800709135966),np.complex(-1.0,2.2661800709135966),np.complex(1.5849625007211563,2.2661800709135966),np.complex(1.5849625007211563,2.2661800709135966),np.complex(1.5849625007211563,2.2661800709135966)},1.2e-11,true),'ext complex log2 307')
end
do
 local a=np.array({np.complex(-5.0,0.5),np.complex(0.25,-3.0),np.complex(-0.0,-3.0),np.complex(-5.0,0.0),np.complex(0.25,0.0),np.complex(0.25,-3.0),np.complex(3.0,2.0),np.complex(0.0,2.0),np.complex(3.0,-3.0)},np.complex128)
 local r=np.log2(a)
 assert(r.dtype=='complex128','ext complex dtype 308')
 assert(list_same(r:tolist(),{np.complex(2.3291057413758973,4.388568671146109),np.complex(1.5899545450074672,-2.1462326279747432),np.complex(1.5849625007211563,-2.2661800709135966),np.complex(2.321928094887362,4.532360141827193),np.complex(-2.0,0.0),np.complex(1.5899545450074672,-2.1462326279747432),np.complex(1.850219859070546,0.8483084401678749),np.complex(1.0,2.2661800709135966),np.complex(2.084962500721156,-1.1330900354567983)},1.2e-11,true),'ext complex log2 308')
end
do
 local a=np.array({np.complex(0.25,0.0),np.complex(0.25,-3.0),np.complex(1.0,2.0),np.complex(3.0,-0.0),np.complex(0.25,0.0),np.complex(-0.0,0.5),np.complex(0.25,0.0),np.complex(5.0,0.0),np.complex(-1.0,-1.0)},np.complex128)
 local r=np.log2(a)
 assert(r.dtype=='complex128','ext complex dtype 309')
 assert(list_same(r:tolist(),{np.complex(-2.0,0.0),np.complex(1.5899545450074672,-2.1462326279747432),np.complex(1.1609640474436813,1.5972779646881086),np.complex(1.5849625007211563,-0.0),np.complex(-2.0,0.0),np.complex(-1.0,2.2661800709135966),np.complex(-2.0,0.0),np.complex(2.321928094887362,0.0),np.complex(0.5,-3.399270106370395)},1.2e-11,true),'ext complex log2 309')
end
do
 local a=np.array({np.complex(-2.0,-3.0),np.complex(5.0,-0.0),np.complex(0.25,2.0),np.complex(-2.0,0.5),np.complex(1.0,-1.0),np.complex(-0.0,0.0),np.complex(-2.0,-0.0),np.complex(0.25,-1.0),np.complex(-1.0,0.5)},np.complex128)
 local r=np.log2(a)
 assert(r.dtype=='complex128','ext complex dtype 310')
 assert(list_same(r:tolist(),{np.complex(1.850219859070546,-3.1144885110814715),np.complex(2.321928094887362,-0.0),np.complex(1.0111839065142272,2.08677373697121),np.complex(1.0437314206251695,4.178930639410458),np.complex(0.5,-1.1330900354567983),np.complex(-math.huge,4.532360141827193),np.complex(1.0,-4.532360141827193),np.complex(0.0437314206251697,-1.9127505684968622),np.complex(0.16096404744368117,3.8634580356017056)},1.2e-11,true),'ext complex log2 310')
end
do
 local a=np.array({np.complex(0.0,-0.0),np.complex(-0.0,-0.0),np.complex(1.0,0.5),np.complex(-5.0,-0.0),np.complex(3.0,-3.0),np.complex(0.25,-0.0),np.complex(-1.0,-3.0),np.complex(-2.0,0.5),np.complex(-2.0,0.5)},np.complex128)
 local r=np.log2(a)
 assert(r.dtype=='complex128','ext complex dtype 311')
 assert(list_same(r:tolist(),{np.complex(-math.huge,-0.0),np.complex(-math.huge,-4.532360141827193),np.complex(0.16096404744368117,0.6689021062254881),np.complex(2.321928094887362,-4.532360141827193),np.complex(2.084962500721156,-1.1330900354567983),np.complex(-2.0,-0.0),np.complex(1.6609640474436813,-2.7303680001449075),np.complex(1.0437314206251695,4.178930639410458),np.complex(1.0437314206251695,4.178930639410458)},1.2e-11,true),'ext complex log2 311')
end
do
 local a=np.array({np.complex(-1.0,3.0),np.complex(-5.0,0.5),np.complex(-5.0,3.0),np.complex(-5.0,-3.0),np.complex(-0.0,-0.0),np.complex(-2.0,0.0),np.complex(3.0,3.0),np.complex(-0.0,0.5),np.complex(3.0,3.0)},np.complex128)
 local r=np.log2(a)
 assert(r.dtype=='complex128','ext complex dtype 312')
 assert(list_same(r:tolist(),{np.complex(1.6609640474436813,2.7303680001449075),np.complex(2.3291057413758973,4.388568671146109),np.complex(2.54373142062517,3.7526996087871303),np.complex(2.54373142062517,-3.7526996087871303),np.complex(-math.huge,-4.532360141827193),np.complex(1.0,4.532360141827193),np.complex(2.084962500721156,1.1330900354567983),np.complex(-1.0,2.2661800709135966),np.complex(2.084962500721156,1.1330900354567983)},1.2e-11,true),'ext complex log2 312')
end
do
 local a=np.array({np.complex(-1.0,0.0),np.complex(-0.0,0.0),np.complex(-2.0,-0.0),np.complex(-1.0,-1.0),np.complex(-5.0,3.0),np.complex(3.0,0.5),np.complex(0.0,-1.0),np.complex(3.0,0.5),np.complex(-1.0,0.5)},np.complex128)
 local r=np.log2(a)
 assert(r.dtype=='complex128','ext complex dtype 313')
 assert(list_same(r:tolist(),{np.complex(0.0,4.532360141827193),np.complex(-math.huge,4.532360141827193),np.complex(1.0,-4.532360141827193),np.complex(0.5,-3.399270106370395),np.complex(2.54373142062517,3.7526996087871303),np.complex(1.6047266828144746,0.23825917791545329),np.complex(0.0,-2.2661800709135966),np.complex(1.6047266828144746,0.23825917791545329),np.complex(0.16096404744368117,3.8634580356017056)},1.2e-11,true),'ext complex log2 313')
end
do
 local a=np.array({np.complex(-0.0,-3.0),np.complex(5.0,2.0),np.complex(3.0,-1.0),np.complex(-5.0,-0.0),np.complex(0.0,0.5),np.complex(-0.0,-1.0),np.complex(-5.0,0.0),np.complex(-2.0,-1.0),np.complex(5.0,2.0)},np.complex128)
 local r=np.log2(a)
 assert(r.dtype=='complex128','ext complex dtype 314')
 assert(list_same(r:tolist(),{np.complex(1.5849625007211563,-2.2661800709135966),np.complex(2.428990497563786,0.5489546632866346),np.complex(1.6609640474436813,-0.46418792923131036),np.complex(2.321928094887362,-4.532360141827193),np.complex(-1.0,2.2661800709135966),np.complex(0.0,-2.2661800709135966),np.complex(2.321928094887362,4.532360141827193),np.complex(1.1609640474436813,-3.8634580356017056),np.complex(2.428990497563786,0.5489546632866346)},1.2e-11,true),'ext complex log2 314')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex((0/0),0.0),np.complex(1.0,(0/0)),np.complex((0/0),2.0)},np.complex128)
 local r=np.log10(a)
 assert(r.dtype=='complex128','ext complex dtype 315')
 assert(list_same(r:tolist(),{np.complex(-math.huge,0.0),np.complex(-math.huge,1.3643763538418412),np.complex(-math.huge,-0.0),np.complex(math.huge,0.0),np.complex(math.huge,1.3643763538418412),np.complex(math.huge,0.6821881769209206),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},1.2e-11,true),'ext complex log10 315')
end
do
 local a=np.array({np.complex(-0.0,0.0),np.complex(3.0,-3.0),np.complex(3.0,3.0),np.complex(3.0,2.0),np.complex(0.25,-3.0),np.complex(0.25,-1.0),np.complex(0.25,0.0),np.complex(-1.0,-1.0),np.complex(-5.0,2.0)},np.complex128)
 local r=np.log10(a)
 assert(r.dtype=='complex128','ext complex dtype 316')
 assert(list_same(r:tolist(),{np.complex(-math.huge,1.3643763538418412),np.complex(0.627636252551653,-0.3410940884604603),np.complex(0.627636252551653,0.3410940884604603),np.complex(0.5569716761534184,0.25536628606545403),np.complex(0.478624009789525,-0.6460803986931319),np.complex(0.013164469361174573,-0.5757952953408879),np.complex(-0.6020599913279624,0.0),np.complex(0.1505149978319906,-1.023282265381381),np.complex(0.7311989989494779,1.1991245339329435)},1.2e-11,true),'ext complex log10 316')
end
do
 local a=np.array({np.complex(1.0,0.0),np.complex(-0.0,2.0),np.complex(5.0,-1.0),np.complex(-0.0,0.5),np.complex(1.0,-0.0),np.complex(0.25,-3.0),np.complex(0.25,-3.0),np.complex(-2.0,-0.0),np.complex(-1.0,3.0)},np.complex128)
 local r=np.log10(a)
 assert(r.dtype=='complex128','ext complex dtype 317')
 assert(list_same(r:tolist(),{np.complex(0.0,0.0),np.complex(0.3010299956639812,0.6821881769209206),np.complex(0.7074866739854089,-0.0857278023950063),np.complex(-0.3010299956639812,0.6821881769209206),np.complex(0.0,-0.0),np.complex(0.478624009789525,-0.6460803986931319),np.complex(0.478624009789525,-0.6460803986931319),np.complex(0.3010299956639812,-1.3643763538418412),np.complex(0.5,0.8219226672446944)},1.2e-11,true),'ext complex log10 317')
end
do
 local a=np.array({np.complex(-5.0,0.5),np.complex(0.25,0.5),np.complex(-5.0,3.0),np.complex(1.0,2.0),np.complex(5.0,2.0),np.complex(-5.0,0.5),np.complex(1.0,0.5),np.complex(3.0,3.0),np.complex(0.25,-3.0)},np.complex128)
 local r=np.log10(a)
 assert(r.dtype=='complex128','ext complex dtype 318')
 assert(list_same(r:tolist(),{np.complex(0.7011306912273401,1.321090808046197),np.complex(-0.25257498915995297,0.4808285787842341),np.complex(0.7657394585211276,1.1296751469614137),np.complex(0.34948500216800943,0.4808285787842341),np.complex(0.7311989989494779,0.16525181990889787),np.complex(0.7011306912273401,1.321090808046197),np.complex(0.04845500650402821,0.20135959813668655),np.complex(0.627636252551653,0.3410940884604603),np.complex(0.478624009789525,-0.6460803986931319)},1.2e-11,true),'ext complex log10 318')
end
do
 local a=np.array({np.complex(1.0,2.0),np.complex(3.0,0.0),np.complex(0.25,3.0),np.complex(-1.0,0.5),np.complex(1.0,-3.0),np.complex(5.0,2.0),np.complex(-0.0,-3.0),np.complex(-0.0,-1.0),np.complex(1.0,0.5)},np.complex128)
 local r=np.log10(a)
 assert(r.dtype=='complex128','ext complex dtype 319')
 assert(list_same(r:tolist(),{np.complex(0.34948500216800943,0.4808285787842341),np.complex(0.4771212547196625,0.0),np.complex(0.478624009789525,0.6460803986931319),np.complex(0.04845500650402821,1.1630167557051547),np.complex(0.5,-0.5424536865971469),np.complex(0.7311989989494779,0.16525181990889787),np.complex(0.4771212547196625,-0.6821881769209206),np.complex(0.0,-0.6821881769209206),np.complex(0.04845500650402821,0.20135959813668655)},1.2e-11,true),'ext complex log10 319')
end
do
 local a=np.array({np.complex(-5.0,-1.0),np.complex(0.0,3.0),np.complex(0.25,-0.0),np.complex(0.25,-0.0),np.complex(-2.0,2.0),np.complex(-1.0,3.0),np.complex(5.0,0.0),np.complex(3.0,0.0),np.complex(-5.0,2.0)},np.complex128)
 local r=np.log10(a)
 assert(r.dtype=='complex128','ext complex dtype 320')
 assert(list_same(r:tolist(),{np.complex(0.7074866739854089,-1.278648551446835),np.complex(0.4771212547196625,0.6821881769209206),np.complex(-0.6020599913279624,-0.0),np.complex(-0.6020599913279624,-0.0),np.complex(0.4515449934959718,1.023282265381381),np.complex(0.5,0.8219226672446944),np.complex(0.6989700043360187,0.0),np.complex(0.4771212547196625,0.0),np.complex(0.7311989989494779,1.1991245339329435)},1.2e-11,true),'ext complex log10 320')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(-0.0,-1.0),np.complex(5.0,3.0),np.complex(5.0,3.0),np.complex(-2.0,0.0),np.complex(5.0,-0.0),np.complex(3.0,0.0),np.complex(0.25,3.0)},np.complex128)
 local r=np.log10(a)
 assert(r.dtype=='complex128','ext complex dtype 321')
 assert(list_same(r:tolist(),{np.complex(-math.huge,0.0),np.complex(-math.huge,-0.0),np.complex(0.0,-0.6821881769209206),np.complex(0.7657394585211276,0.23470120688042762),np.complex(0.7657394585211276,0.23470120688042762),np.complex(0.3010299956639812,1.3643763538418412),np.complex(0.6989700043360187,-0.0),np.complex(0.4771212547196625,0.0),np.complex(0.478624009789525,0.6460803986931319)},1.2e-11,true),'ext complex log10 321')
end
do
 local a=np.array({np.complex(1.0,-0.0),np.complex(0.25,2.0),np.complex(5.0,-1.0),np.complex(-0.0,-1.0),np.complex(0.25,-1.0),np.complex(-2.0,3.0),np.complex(1.0,-3.0),np.complex(-0.0,0.0),np.complex(0.0,0.5)},np.complex128)
 local r=np.log10(a)
 assert(r.dtype=='complex128','ext complex dtype 322')
 assert(list_same(r:tolist(),{np.complex(0.0,-0.0),np.complex(0.30439668699346534,0.6281814889921532),np.complex(0.7074866739854089,-0.0857278023950063),np.complex(0.0,-0.6821881769209206),np.complex(0.013164469361174573,-0.5757952953408879),np.complex(0.5569716761534184,0.9375544629863746),np.complex(0.5,-0.5424536865971469),np.complex(-math.huge,1.3643763538418412),np.complex(-0.3010299956639812,0.6821881769209206)},1.2e-11,true),'ext complex log10 322')
end
do
 local a=np.array({np.complex(-5.0,-3.0),np.complex(-1.0,0.5),np.complex(-0.0,3.0),np.complex(1.0,-3.0),np.complex(-5.0,2.0),np.complex(0.25,-0.0),np.complex(3.0,-1.0),np.complex(1.0,2.0),np.complex(-0.0,2.0)},np.complex128)
 local r=np.log10(a)
 assert(r.dtype=='complex128','ext complex dtype 323')
 assert(list_same(r:tolist(),{np.complex(0.7657394585211276,-1.1296751469614137),np.complex(0.04845500650402821,1.1630167557051547),np.complex(0.4771212547196625,0.6821881769209206),np.complex(0.5,-0.5424536865971469),np.complex(0.7311989989494779,1.1991245339329435),np.complex(-0.6020599913279624,-0.0),np.complex(0.5,-0.13973449032377375),np.complex(0.34948500216800943,0.4808285787842341),np.complex(0.3010299956639812,0.6821881769209206)},1.2e-11,true),'ext complex log10 323')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex((0/0),0.0),np.complex(1.0,(0/0)),np.complex((0/0),2.0)},np.complex128)
 local r=np.expm1(a)
 assert(r.dtype=='complex128','ext complex dtype 324')
 assert(list_same(r:tolist(),{np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,(0/0)),np.complex(-1.0,0.0),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},1.2e-11,true),'ext complex expm1 324')
end
do
 local a=np.array({np.complex(0.0,-0.0),np.complex(3.0,3.0),np.complex(-1.0,3.0),np.complex(-1.0,3.0),np.complex(-5.0,-0.0),np.complex(-1.0,0.5),np.complex(-2.0,-3.0),np.complex(-2.0,-3.0),np.complex(0.25,-3.0)},np.complex128)
 local r=np.expm1(a)
 assert(r.dtype=='complex128','ext complex dtype 325')
 assert(list_same(r:tolist(),{np.complex(0.0,-0.0),np.complex(-20.88453084414699,2.834471132487004),np.complex(-1.3641978864132929,0.05191514970317339),np.complex(-1.3641978864132929,0.05191514970317339),np.complex(-0.9932620530009145,-0.0),np.complex(-0.677155417549967,0.17637079922503196),np.complex(-1.1339809149295426,-0.019098516261135196),np.complex(-1.1339809149295426,-0.019098516261135196),np.complex(-2.2711755279651245,-0.18120167715204843)},1.2e-11,true),'ext complex expm1 325')
end
do
 local a=np.array({np.complex(5.0,-0.0),np.complex(-1.0,0.0),np.complex(0.25,0.0),np.complex(0.0,0.5),np.complex(0.0,3.0),np.complex(-0.0,-0.0),np.complex(1.0,0.0),np.complex(-2.0,0.0),np.complex(0.0,-3.0)},np.complex128)
 local r=np.expm1(a)
 assert(r.dtype=='complex128','ext complex dtype 326')
 assert(list_same(r:tolist(),{np.complex(147.4131591025766,-0.0),np.complex(-0.6321205588285577,0.0),np.complex(0.2840254166877415,0.0),np.complex(-0.1224174381096273,0.479425538604203),np.complex(-1.9899924966004454,0.1411200080598672),np.complex(-0.0,-0.0),np.complex(1.718281828459045,0.0),np.complex(-0.8646647167633873,0.0),np.complex(-1.9899924966004454,-0.1411200080598672)},1.2e-11,true),'ext complex expm1 326')
end
do
 local a=np.array({np.complex(3.0,-0.0),np.complex(-0.0,2.0),np.complex(-2.0,-0.0),np.complex(3.0,2.0),np.complex(0.0,3.0),np.complex(-1.0,3.0),np.complex(0.25,0.5),np.complex(-0.0,-1.0),np.complex(5.0,3.0)},np.complex128)
 local r=np.expm1(a)
 assert(r.dtype=='complex128','ext complex dtype 327')
 assert(list_same(r:tolist(),{np.complex(19.085536923187668,-0.0),np.complex(-1.4161468365471424,0.9092974268256817),np.complex(-0.8646647167633873,-0.0),np.complex(-9.358532650935372,18.263727040666765),np.complex(-1.9899924966004454,0.1411200080598672),np.complex(-1.3641978864132929,0.05191514970317339),np.complex(0.12683831470918153,0.6155945769770066),np.complex(-0.4596976941318603,-0.8414709848078965),np.complex(-147.92791390831894,20.944066208745966)},1.2e-11,true),'ext complex expm1 327')
end
do
 local a=np.array({np.complex(1.0,0.5),np.complex(1.0,3.0),np.complex(3.0,3.0),np.complex(-5.0,-3.0),np.complex(-5.0,0.5),np.complex(0.25,-3.0),np.complex(5.0,0.0),np.complex(0.25,-3.0),np.complex(-2.0,-0.0)},np.complex128)
 local r=np.expm1(a)
 assert(r.dtype=='complex128','ext complex dtype 328')
 assert(list_same(r:tolist(),{np.complex(1.3855167309591356,1.3032137296869954),np.complex(-3.6910786138197937,0.383603953541131),np.complex(-20.88453084414699,2.834471132487004),np.complex(-1.0066705169715862,-0.0009508591348178992),np.complex(-0.9940868952106612,0.0032303438691231234),np.complex(-2.2711755279651245,-0.18120167715204843),np.complex(147.4131591025766,0.0),np.complex(-2.2711755279651245,-0.18120167715204843),np.complex(-0.8646647167633873,-0.0)},1.2e-11,true),'ext complex expm1 328')
end
do
 local a=np.array({np.complex(-2.0,-0.0),np.complex(0.0,-0.0),np.complex(3.0,3.0),np.complex(0.25,0.0),np.complex(0.25,0.0),np.complex(-2.0,-1.0),np.complex(-0.0,-3.0),np.complex(-1.0,0.5),np.complex(0.25,0.0)},np.complex128)
 local r=np.expm1(a)
 assert(r.dtype=='complex128','ext complex dtype 329')
 assert(list_same(r:tolist(),{np.complex(-0.8646647167633873,-0.0),np.complex(0.0,-0.0),np.complex(-20.88453084414699,2.834471132487004),np.complex(0.2840254166877415,0.0),np.complex(0.2840254166877415,0.0),np.complex(-0.9268780344019404,-0.1138807140643681),np.complex(-1.9899924966004454,-0.1411200080598672),np.complex(-0.677155417549967,0.17637079922503196),np.complex(0.2840254166877415,0.0)},1.2e-11,true),'ext complex expm1 329')
end
do
 local a=np.array({np.complex(-1.0,0.5),np.complex(3.0,0.0),np.complex(0.0,0.5),np.complex(-5.0,-1.0),np.complex(1.0,0.0),np.complex(-1.0,3.0),np.complex(0.0,-1.0),np.complex(-0.0,2.0),np.complex(-5.0,-0.0)},np.complex128)
 local r=np.expm1(a)
 assert(r.dtype=='complex128','ext complex dtype 330')
 assert(list_same(r:tolist(),{np.complex(-0.677155417549967,0.17637079922503196),np.complex(19.085536923187668,0.0),np.complex(-0.1224174381096273,0.479425538604203),np.complex(-0.996359471699577,-0.005669786896903859),np.complex(1.718281828459045,0.0),np.complex(-1.3641978864132929,0.05191514970317339),np.complex(-0.4596976941318603,-0.8414709848078965),np.complex(-1.4161468365471424,0.9092974268256817),np.complex(-0.9932620530009145,-0.0)},1.2e-11,true),'ext complex expm1 330')
end
do
 local a=np.array({np.complex(3.0,-1.0),np.complex(-2.0,2.0),np.complex(5.0,-1.0),np.complex(5.0,3.0),np.complex(1.0,3.0),np.complex(-1.0,2.0),np.complex(0.0,2.0),np.complex(0.25,2.0),np.complex(0.25,0.5)},np.complex128)
 local r=np.expm1(a)
 assert(r.dtype=='complex128','ext complex dtype 331')
 assert(list_same(r:tolist(),{np.complex(9.852261914197959,-16.901396535150095),np.complex(-1.056319349992128,0.12306002480577674),np.complex(79.18797208429723,-124.88536714849616),np.complex(-147.92791390831894,20.944066208745966),np.complex(-3.6910786138197937,0.383603953541131),np.complex(-1.1530918656742262,0.33451182923926226),np.complex(-1.4161468365471424,0.9092974268256817),np.complex(-1.5343431152007299,1.167561007372937),np.complex(0.12683831470918153,0.6155945769770066)},1.2e-11,true),'ext complex expm1 331')
end
do
 local a=np.array({np.complex(0.0,-3.0),np.complex(0.0,-0.0),np.complex(1.0,0.5),np.complex(0.25,3.0),np.complex(-0.0,-1.0),np.complex(5.0,-1.0),np.complex(1.0,0.5),np.complex(-2.0,-0.0),np.complex(3.0,3.0)},np.complex128)
 local r=np.expm1(a)
 assert(r.dtype=='complex128','ext complex dtype 332')
 assert(list_same(r:tolist(),{np.complex(-1.9899924966004454,-0.1411200080598672),np.complex(0.0,-0.0),np.complex(1.3855167309591356,1.3032137296869954),np.complex(-2.2711755279651245,0.18120167715204843),np.complex(-0.4596976941318603,-0.8414709848078965),np.complex(79.18797208429723,-124.88536714849616),np.complex(1.3855167309591356,1.3032137296869954),np.complex(-0.8646647167633873,-0.0),np.complex(-20.88453084414699,2.834471132487004)},1.2e-11,true),'ext complex expm1 332')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(-math.huge,0.0),np.complex(0.0,math.huge),np.complex((0/0),0.0),np.complex(1.0,(0/0)),np.complex((0/0),2.0)},np.complex128)
 local r=np.log1p(a)
 assert(r.dtype=='complex128','ext complex dtype 333')
 assert(list_same(r:tolist(),{np.complex(0.0,0.0),np.complex(0.0,0.0),np.complex(0.0,-0.0),np.complex(math.huge,0.0),np.complex(math.huge,3.141592653589793),np.complex(math.huge,1.5707963267948966),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},1.2e-11,true),'ext complex log1p 333')
end
do
 local a=np.array({np.complex(-1.0,0.5),np.complex(0.25,-3.0),np.complex(-0.0,3.0),np.complex(-0.0,0.5),np.complex(-2.0,-1.0),np.complex(-5.0,-1.0),np.complex(5.0,2.0),np.complex(-2.0,-0.0),np.complex(0.25,-1.0)},np.complex128)
 local r=np.log1p(a)
 assert(r.dtype=='complex128','ext complex dtype 334')
 assert(list_same(r:tolist(),{np.complex(-0.6931471805599453,1.5707963267948966),np.complex(1.1786549963416462,-1.176005207095135),np.complex(1.151292546497023,1.2490457723982544),np.complex(0.11157177565710492,0.4636476090008061),np.complex(0.3465735902799727,-2.356194490192345),np.complex(1.416606672028108,-2.896613990462929),np.complex(1.8444397270569681,0.3217505543966422),np.complex(0.0,-3.141592653589793),np.complex(0.47049167223226324,-0.6747409422235526)},1.2e-11,true),'ext complex log1p 334')
end
do
 local a=np.array({np.complex(0.0,0.0),np.complex(-1.0,0.0),np.complex(0.0,3.0),np.complex(5.0,-1.0),np.complex(-2.0,2.0),np.complex(5.0,-0.0),np.complex(1.0,-3.0),np.complex(-0.0,0.5),np.complex(-5.0,-0.0)},np.complex128)
 local r=np.log1p(a)
 assert(r.dtype=='complex128','ext complex dtype 335')
 assert(list_same(r:tolist(),{np.complex(0.0,0.0),np.complex(-math.huge,0.0),np.complex(1.151292546497023,1.2490457723982544),np.complex(1.8054589563221122,-0.16514867741462683),np.complex(0.8047189562170503,2.0344439357957027),np.complex(1.791759469228055,-0.0),np.complex(1.2824746787307684,-0.982793723247329),np.complex(0.11157177565710492,0.4636476090008061),np.complex(1.3862943611198906,-3.141592653589793)},1.2e-11,true),'ext complex log1p 335')
end
do
 local a=np.array({np.complex(5.0,3.0),np.complex(3.0,0.5),np.complex(-1.0,2.0),np.complex(-1.0,-0.0),np.complex(5.0,-3.0),np.complex(5.0,3.0),np.complex(-5.0,2.0),np.complex(0.25,-1.0),np.complex(1.0,0.5)},np.complex128)
 local r=np.log1p(a)
 assert(r.dtype=='complex128','ext complex dtype 336')
 assert(list_same(r:tolist(),{np.complex(1.90333124488516,0.4636476090008061),np.complex(1.3940464543878732,0.12435499454676144),np.complex(0.6931471805599453,1.5707963267948966),np.complex(-math.huge,-0.0),np.complex(1.90333124488516,-0.4636476090008061),np.complex(1.90333124488516,0.4636476090008061),np.complex(1.4978661367769956,2.677945044588987),np.complex(0.47049167223226324,-0.6747409422235526),np.complex(0.7234594914681627,0.24497866312686414)},1.2e-11,true),'ext complex log1p 336')
end
do
 local a=np.array({np.complex(-1.0,-0.0),np.complex(-1.0,0.5),np.complex(-1.0,3.0),np.complex(-0.0,3.0),np.complex(0.0,2.0),np.complex(1.0,2.0),np.complex(-5.0,-0.0),np.complex(-5.0,-1.0),np.complex(-1.0,-0.0)},np.complex128)
 local r=np.log1p(a)
 assert(r.dtype=='complex128','ext complex dtype 337')
 assert(list_same(r:tolist(),{np.complex(-math.huge,-0.0),np.complex(-0.6931471805599453,1.5707963267948966),np.complex(1.0986122886681098,1.5707963267948966),np.complex(1.151292546497023,1.2490457723982544),np.complex(0.8047189562170503,1.1071487177940904),np.complex(1.039720770839918,0.7853981633974483),np.complex(1.3862943611198906,-3.141592653589793),np.complex(1.416606672028108,-2.896613990462929),np.complex(-math.huge,-0.0)},1.2e-11,true),'ext complex log1p 337')
end
do
 local a=np.array({np.complex(-1.0,-0.0),np.complex(5.0,-1.0),np.complex(3.0,0.5),np.complex(0.25,-3.0),np.complex(-0.0,2.0),np.complex(-2.0,2.0),np.complex(-0.0,0.0),np.complex(-1.0,-0.0),np.complex(-5.0,-3.0)},np.complex128)
 local r=np.log1p(a)
 assert(r.dtype=='complex128','ext complex dtype 338')
 assert(list_same(r:tolist(),{np.complex(-math.huge,-0.0),np.complex(1.8054589563221122,-0.16514867741462683),np.complex(1.3940464543878732,0.12435499454676144),np.complex(1.1786549963416462,-1.176005207095135),np.complex(0.8047189562170503,1.1071487177940904),np.complex(0.8047189562170503,2.0344439357957027),np.complex(0.0,0.0),np.complex(-math.huge,-0.0),np.complex(1.6094379124341003,-2.498091544796509)},1.2e-11,true),'ext complex log1p 338')
end
do
 local a=np.array({np.complex(1.0,0.5),np.complex(-0.0,-3.0),np.complex(1.0,0.0),np.complex(5.0,2.0),np.complex(-2.0,-3.0),np.complex(5.0,2.0),np.complex(-0.0,0.5),np.complex(-0.0,-0.0),np.complex(5.0,3.0)},np.complex128)
 local r=np.log1p(a)
 assert(r.dtype=='complex128','ext complex dtype 339')
 assert(list_same(r:tolist(),{np.complex(0.7234594914681627,0.24497866312686414),np.complex(1.151292546497023,-1.2490457723982544),np.complex(0.6931471805599453,0.0),np.complex(1.8444397270569681,0.3217505543966422),np.complex(1.151292546497023,-1.892546881191539),np.complex(1.8444397270569681,0.3217505543966422),np.complex(0.11157177565710492,0.4636476090008061),np.complex(0.0,-0.0),np.complex(1.90333124488516,0.4636476090008061)},1.2e-11,true),'ext complex log1p 339')
end
do
 local a=np.array({np.complex(5.0,-0.0),np.complex(5.0,-1.0),np.complex(1.0,0.0),np.complex(-2.0,2.0),np.complex(0.0,-1.0),np.complex(1.0,0.5),np.complex(0.0,-0.0),np.complex(-5.0,3.0),np.complex(3.0,0.0)},np.complex128)
 local r=np.log1p(a)
 assert(r.dtype=='complex128','ext complex dtype 340')
 assert(list_same(r:tolist(),{np.complex(1.791759469228055,-0.0),np.complex(1.8054589563221122,-0.16514867741462683),np.complex(0.6931471805599453,0.0),np.complex(0.8047189562170503,2.0344439357957027),np.complex(0.3465735902799727,-0.7853981633974483),np.complex(0.7234594914681627,0.24497866312686414),np.complex(0.0,-0.0),np.complex(1.6094379124341003,2.498091544796509),np.complex(1.3862943611198906,0.0)},1.2e-11,true),'ext complex log1p 340')
end
do
 local a=np.array({np.complex(5.0,-1.0),np.complex(0.25,-1.0),np.complex(-5.0,3.0),np.complex(0.0,-0.0),np.complex(-0.0,-3.0),np.complex(-1.0,-0.0),np.complex(-0.0,0.0),np.complex(5.0,-1.0),np.complex(5.0,0.0)},np.complex128)
 local r=np.log1p(a)
 assert(r.dtype=='complex128','ext complex dtype 341')
 assert(list_same(r:tolist(),{np.complex(1.8054589563221122,-0.16514867741462683),np.complex(0.47049167223226324,-0.6747409422235526),np.complex(1.6094379124341003,2.498091544796509),np.complex(0.0,-0.0),np.complex(1.151292546497023,-1.2490457723982544),np.complex(-math.huge,-0.0),np.complex(0.0,0.0),np.complex(1.8054589563221122,-0.16514867741462683),np.complex(1.791759469228055,0.0)},1.2e-11,true),'ext complex log1p 341')
end
do
 local a=np.array({-1.0,0.25,2.0,4.0},np.float32)
 local m=np.array({false,true,false,true},np.bool)
 local o=np.array({9,8,7,6},np.float64)
 np.exp2(a,{out=o,where=m})
 assert(list_same(o:tolist(),{9.0,1.1892070770263672,7.0,16.0},5e-5,false),'ext out where 342')
end
do
 local a=np.array({-1.0,0.25,2.0,4.0},np.float32)
 local m=np.array({false,true,false,true},np.bool)
 local o=np.array({9,8,7,6},np.float64)
 np.sinh(a,{out=o,where=m})
 assert(list_same(o:tolist(),{9.0,0.25261232256889343,7.0,27.2899169921875},5e-5,false),'ext out where 343')
end
do
 local a=np.array({-1.0,0.25,2.0,4.0},np.float32)
 local m=np.array({false,true,false,true},np.bool)
 local o=np.array({9,8,7,6},np.float64)
 np.log1p(a,{out=o,where=m})
 assert(list_same(o:tolist(),{9.0,0.2231435626745224,7.0,1.6094379425048828},5e-5,false),'ext out where 344')
end
do
 local a=np.array({np.complex(1,1)},np.complex128)
 local ok=pcall(function() np.cbrt(a) end)
 assert(not ok,'complex cbrt must be rejected')
end
print('extended math differential: 346 cases ok')
