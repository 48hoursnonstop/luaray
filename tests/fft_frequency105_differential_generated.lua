-- Original NumPy2.5.3 FFT helpers; Lua axes are one-based.
local np=require('luaray_core')
local cases,checks,max_error=0,0,0
local function eq(a,b,label,atol,rtol)
 checks=checks+1
 if type(b)=='table' then
  assert(type(a)=='table' and #a==#b,label..': shape')
  for i=1,#b do eq(a[i],b[i],label..'['..i..']',atol,rtol) end
 elseif type(b)=='userdata' then
  eq(a.real,b.real,label..'.real',atol,rtol);eq(a.imag,b.imag,label..'.imag',atol,rtol)
 elseif type(b)=='number' and atol then
  assert(type(a)=='number',label..': numeric value')
  if b~=b then assert(a~=a,label..': NaN')
  elseif b==math.huge or b==-math.huge then assert(a==b,label..': infinity')
  else local e=math.abs(a-b);if e>max_error then max_error=e end
   assert(e<=atol+rtol*math.abs(b),label..': '..tostring(a)..' != '..tostring(b)..' error '..e)
  end
 else assert(a==b,label..': '..tostring(a)..' != '..tostring(b)) end
end

do
local function chunk()
-- 1: fftfreq/-7/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.fftfreq(-7,spacing) end)
assert(ok==false,"fftfreq/-7/1.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 2: fftfreq/-7/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.fftfreq(-7,spacing) end)
assert(ok==false,"fftfreq/-7/0.5: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 3: fftfreq/-7/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.fftfreq(-7,spacing) end)
assert(ok==false,"fftfreq/-7/2: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 4: fftfreq/-7/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.fftfreq(-7,spacing) end)
assert(ok==false,"fftfreq/-7/-0.25: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 5: fftfreq/-7/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.fftfreq(-7,spacing) end)
assert(ok==false,"fftfreq/-7/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 6: fftfreq/-7/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.fftfreq(-7,spacing) end)
assert(ok==false,"fftfreq/-7/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 7: fftfreq/-7/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.fftfreq(-7,spacing) end)
assert(ok==false,"fftfreq/-7/inf: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 8: fftfreq/-7/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.fftfreq(-7,spacing) end)
assert(ok==false,"fftfreq/-7/nan: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 9: fftfreq/-7/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.fftfreq(-7,spacing) end)
assert(ok==false,"fftfreq/-7/(1+2j): acceptance"..": "..tostring(result))
cases=cases+1
end
-- 10: fftfreq/-2/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.fftfreq(-2,spacing) end)
assert(ok==false,"fftfreq/-2/1.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 11: fftfreq/-2/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.fftfreq(-2,spacing) end)
assert(ok==false,"fftfreq/-2/0.5: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 12: fftfreq/-2/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.fftfreq(-2,spacing) end)
assert(ok==false,"fftfreq/-2/2: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 13: fftfreq/-2/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.fftfreq(-2,spacing) end)
assert(ok==false,"fftfreq/-2/-0.25: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 14: fftfreq/-2/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.fftfreq(-2,spacing) end)
assert(ok==false,"fftfreq/-2/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 15: fftfreq/-2/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.fftfreq(-2,spacing) end)
assert(ok==false,"fftfreq/-2/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 16: fftfreq/-2/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.fftfreq(-2,spacing) end)
assert(ok==false,"fftfreq/-2/inf: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 17: fftfreq/-2/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.fftfreq(-2,spacing) end)
assert(ok==false,"fftfreq/-2/nan: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 18: fftfreq/-2/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.fftfreq(-2,spacing) end)
assert(ok==false,"fftfreq/-2/(1+2j): acceptance"..": "..tostring(result))
cases=cases+1
end
-- 19: fftfreq/-1/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/-1/1.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 20: fftfreq/-1/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/-1/0.5: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 21: fftfreq/-1/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/-1/2: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 22: fftfreq/-1/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/-1/-0.25: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 23: fftfreq/-1/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/-1/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 24: fftfreq/-1/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/-1/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 25: fftfreq/-1/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/-1/inf: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 26: fftfreq/-1/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/-1/nan: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 27: fftfreq/-1/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/-1/(1+2j): acceptance"..": "..tostring(result))
cases=cases+1
end
-- 28: fftfreq/0/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==false,"fftfreq/0/1.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 29: fftfreq/0/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==false,"fftfreq/0/0.5: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 30: fftfreq/0/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==false,"fftfreq/0/2: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 31: fftfreq/0/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==false,"fftfreq/0/-0.25: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 32: fftfreq/0/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==false,"fftfreq/0/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 33: fftfreq/0/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==false,"fftfreq/0/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 34: fftfreq/0/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/0/inf: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/0/inf: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/0/inf: result: shape")
eq(result.strides,{0},"fftfreq/0/inf: result: strides")
eq(result.dtype,"float64","fftfreq/0/inf: result: dtype")
cases=cases+1
end
-- 35: fftfreq/0/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/0/nan: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/0/nan: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/0/nan: result: shape")
eq(result.strides,{0},"fftfreq/0/nan: result: strides")
eq(result.dtype,"float64","fftfreq/0/nan: result: dtype")
cases=cases+1
end
-- 36: fftfreq/0/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==false,"fftfreq/0/(1+2j): acceptance"..": "..tostring(result))
cases=cases+1
end
-- 37: fftfreq/1/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/1/1.0: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"fftfreq/1/1.0: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/1/1.0: result: shape")
eq(result.strides,{8},"fftfreq/1/1.0: result: strides")
eq(result.dtype,"float64","fftfreq/1/1.0: result: dtype")
cases=cases+1
end
-- 38: fftfreq/1/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/1/0.5: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"fftfreq/1/0.5: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/1/0.5: result: shape")
eq(result.strides,{8},"fftfreq/1/0.5: result: strides")
eq(result.dtype,"float64","fftfreq/1/0.5: result: dtype")
cases=cases+1
end
-- 39: fftfreq/1/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"fftfreq/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/1/2: result: shape")
eq(result.strides,{8},"fftfreq/1/2: result: strides")
eq(result.dtype,"float64","fftfreq/1/2: result: dtype")
cases=cases+1
end
-- 40: fftfreq/1/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/1/-0.25: acceptance"..": "..tostring(result))
eq(result:tolist(),{-0.0},"fftfreq/1/-0.25: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/1/-0.25: result: shape")
eq(result.strides,{8},"fftfreq/1/-0.25: result: strides")
eq(result.dtype,"float64","fftfreq/1/-0.25: result: dtype")
cases=cases+1
end
-- 41: fftfreq/1/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==false,"fftfreq/1/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 42: fftfreq/1/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==false,"fftfreq/1/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 43: fftfreq/1/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/1/inf: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"fftfreq/1/inf: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/1/inf: result: shape")
eq(result.strides,{8},"fftfreq/1/inf: result: strides")
eq(result.dtype,"float64","fftfreq/1/inf: result: dtype")
cases=cases+1
end
-- 44: fftfreq/1/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/1/nan: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"fftfreq/1/nan: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/1/nan: result: shape")
eq(result.strides,{8},"fftfreq/1/nan: result: strides")
eq(result.dtype,"float64","fftfreq/1/nan: result: dtype")
cases=cases+1
end
-- 45: fftfreq/1/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/1/(1+2j): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"fftfreq/1/(1+2j): result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/1/(1+2j): result: shape")
eq(result.strides,{16},"fftfreq/1/(1+2j): result: strides")
eq(result.dtype,"complex128","fftfreq/1/(1+2j): result: dtype")
cases=cases+1
end
-- 46: fftfreq/2/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.fftfreq(2,spacing) end)
assert(ok==true,"fftfreq/2/1.0: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,-0.5},"fftfreq/2/1.0: result",2e-12,2e-12)
eq(result.shape,{2},"fftfreq/2/1.0: result: shape")
eq(result.strides,{8},"fftfreq/2/1.0: result: strides")
eq(result.dtype,"float64","fftfreq/2/1.0: result: dtype")
cases=cases+1
end
-- 47: fftfreq/2/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.fftfreq(2,spacing) end)
assert(ok==true,"fftfreq/2/0.5: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,-1.0},"fftfreq/2/0.5: result",2e-12,2e-12)
eq(result.shape,{2},"fftfreq/2/0.5: result: shape")
eq(result.strides,{8},"fftfreq/2/0.5: result: strides")
eq(result.dtype,"float64","fftfreq/2/0.5: result: dtype")
cases=cases+1
end
-- 48: fftfreq/2/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.fftfreq(2,spacing) end)
assert(ok==true,"fftfreq/2/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,-0.25},"fftfreq/2/2: result",2e-12,2e-12)
eq(result.shape,{2},"fftfreq/2/2: result: shape")
eq(result.strides,{8},"fftfreq/2/2: result: strides")
eq(result.dtype,"float64","fftfreq/2/2: result: dtype")
cases=cases+1
end
-- 49: fftfreq/2/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.fftfreq(2,spacing) end)
assert(ok==true,"fftfreq/2/-0.25: acceptance"..": "..tostring(result))
eq(result:tolist(),{-0.0,2.0},"fftfreq/2/-0.25: result",2e-12,2e-12)
eq(result.shape,{2},"fftfreq/2/-0.25: result: shape")
eq(result.strides,{8},"fftfreq/2/-0.25: result: strides")
eq(result.dtype,"float64","fftfreq/2/-0.25: result: dtype")
cases=cases+1
end
-- 50: fftfreq/2/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.fftfreq(2,spacing) end)
assert(ok==false,"fftfreq/2/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 51: fftfreq/2/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.fftfreq(2,spacing) end)
assert(ok==false,"fftfreq/2/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 52: fftfreq/2/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.fftfreq(2,spacing) end)
assert(ok==true,"fftfreq/2/inf: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,-0.0},"fftfreq/2/inf: result",2e-12,2e-12)
eq(result.shape,{2},"fftfreq/2/inf: result: shape")
eq(result.strides,{8},"fftfreq/2/inf: result: strides")
eq(result.dtype,"float64","fftfreq/2/inf: result: dtype")
cases=cases+1
end
-- 53: fftfreq/2/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.fftfreq(2,spacing) end)
assert(ok==true,"fftfreq/2/nan: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),(0/0)},"fftfreq/2/nan: result",2e-12,2e-12)
eq(result.shape,{2},"fftfreq/2/nan: result: shape")
eq(result.strides,{8},"fftfreq/2/nan: result: strides")
eq(result.dtype,"float64","fftfreq/2/nan: result: dtype")
cases=cases+1
end
-- 54: fftfreq/2/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.fftfreq(2,spacing) end)
assert(ok==true,"fftfreq/2/(1+2j): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(-0.1,0.2)},"fftfreq/2/(1+2j): result",2e-12,2e-12)
eq(result.shape,{2},"fftfreq/2/(1+2j): result: shape")
eq(result.strides,{16},"fftfreq/2/(1+2j): result: strides")
eq(result.dtype,"complex128","fftfreq/2/(1+2j): result: dtype")
cases=cases+1
end
-- 55: fftfreq/3/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/3/1.0: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.3333333333333333,-0.3333333333333333},"fftfreq/3/1.0: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/3/1.0: result: shape")
eq(result.strides,{8},"fftfreq/3/1.0: result: strides")
eq(result.dtype,"float64","fftfreq/3/1.0: result: dtype")
cases=cases+1
end
-- 56: fftfreq/3/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/3/0.5: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.6666666666666666,-0.6666666666666666},"fftfreq/3/0.5: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/3/0.5: result: shape")
eq(result.strides,{8},"fftfreq/3/0.5: result: strides")
eq(result.dtype,"float64","fftfreq/3/0.5: result: dtype")
cases=cases+1
end
-- 57: fftfreq/3/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.16666666666666666,-0.16666666666666666},"fftfreq/3/2: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/3/2: result: shape")
eq(result.strides,{8},"fftfreq/3/2: result: strides")
eq(result.dtype,"float64","fftfreq/3/2: result: dtype")
cases=cases+1
end
-- 58: fftfreq/3/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/3/-0.25: acceptance"..": "..tostring(result))
eq(result:tolist(),{-0.0,-1.3333333333333333,1.3333333333333333},"fftfreq/3/-0.25: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/3/-0.25: result: shape")
eq(result.strides,{8},"fftfreq/3/-0.25: result: strides")
eq(result.dtype,"float64","fftfreq/3/-0.25: result: dtype")
cases=cases+1
end
-- 59: fftfreq/3/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==false,"fftfreq/3/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 60: fftfreq/3/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==false,"fftfreq/3/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 61: fftfreq/3/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/3/inf: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0,-0.0},"fftfreq/3/inf: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/3/inf: result: shape")
eq(result.strides,{8},"fftfreq/3/inf: result: strides")
eq(result.dtype,"float64","fftfreq/3/inf: result: dtype")
cases=cases+1
end
-- 62: fftfreq/3/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/3/nan: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),(0/0),(0/0)},"fftfreq/3/nan: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/3/nan: result: shape")
eq(result.strides,{8},"fftfreq/3/nan: result: strides")
eq(result.dtype,"float64","fftfreq/3/nan: result: dtype")
cases=cases+1
end
-- 63: fftfreq/3/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/3/(1+2j): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.06666666666666667,-0.13333333333333333),np.complex(-0.06666666666666667,0.13333333333333333)},"fftfreq/3/(1+2j): result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/3/(1+2j): result: shape")
eq(result.strides,{16},"fftfreq/3/(1+2j): result: strides")
eq(result.dtype,"complex128","fftfreq/3/(1+2j): result: dtype")
cases=cases+1
end
-- 64: fftfreq/4/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/4/1.0: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,-0.5,-0.25},"fftfreq/4/1.0: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/4/1.0: result: shape")
eq(result.strides,{8},"fftfreq/4/1.0: result: strides")
eq(result.dtype,"float64","fftfreq/4/1.0: result: dtype")
cases=cases+1
end
-- 65: fftfreq/4/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/4/0.5: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.5,-1.0,-0.5},"fftfreq/4/0.5: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/4/0.5: result: shape")
eq(result.strides,{8},"fftfreq/4/0.5: result: strides")
eq(result.dtype,"float64","fftfreq/4/0.5: result: dtype")
cases=cases+1
end
-- 66: fftfreq/4/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.125,-0.25,-0.125},"fftfreq/4/2: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/4/2: result: shape")
eq(result.strides,{8},"fftfreq/4/2: result: strides")
eq(result.dtype,"float64","fftfreq/4/2: result: dtype")
cases=cases+1
end
-- 67: fftfreq/4/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/4/-0.25: acceptance"..": "..tostring(result))
eq(result:tolist(),{-0.0,-1.0,2.0,1.0},"fftfreq/4/-0.25: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/4/-0.25: result: shape")
eq(result.strides,{8},"fftfreq/4/-0.25: result: strides")
eq(result.dtype,"float64","fftfreq/4/-0.25: result: dtype")
cases=cases+1
end
-- 68: fftfreq/4/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==false,"fftfreq/4/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 69: fftfreq/4/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==false,"fftfreq/4/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 70: fftfreq/4/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/4/inf: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0,-0.0,-0.0},"fftfreq/4/inf: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/4/inf: result: shape")
eq(result.strides,{8},"fftfreq/4/inf: result: strides")
eq(result.dtype,"float64","fftfreq/4/inf: result: dtype")
cases=cases+1
end
-- 71: fftfreq/4/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/4/nan: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),(0/0),(0/0),(0/0)},"fftfreq/4/nan: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/4/nan: result: shape")
eq(result.strides,{8},"fftfreq/4/nan: result: strides")
eq(result.dtype,"float64","fftfreq/4/nan: result: dtype")
cases=cases+1
end
-- 72: fftfreq/4/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/4/(1+2j): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.05,-0.1),np.complex(-0.1,0.2),np.complex(-0.05,0.1)},"fftfreq/4/(1+2j): result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/4/(1+2j): result: shape")
eq(result.strides,{16},"fftfreq/4/(1+2j): result: strides")
eq(result.dtype,"complex128","fftfreq/4/(1+2j): result: dtype")
cases=cases+1
end
-- 73: fftfreq/5/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.fftfreq(5,spacing) end)
assert(ok==true,"fftfreq/5/1.0: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.2,0.4,-0.4,-0.2},"fftfreq/5/1.0: result",2e-12,2e-12)
eq(result.shape,{5},"fftfreq/5/1.0: result: shape")
eq(result.strides,{8},"fftfreq/5/1.0: result: strides")
eq(result.dtype,"float64","fftfreq/5/1.0: result: dtype")
cases=cases+1
end
-- 74: fftfreq/5/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.fftfreq(5,spacing) end)
assert(ok==true,"fftfreq/5/0.5: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.4,0.8,-0.8,-0.4},"fftfreq/5/0.5: result",2e-12,2e-12)
eq(result.shape,{5},"fftfreq/5/0.5: result: shape")
eq(result.strides,{8},"fftfreq/5/0.5: result: strides")
eq(result.dtype,"float64","fftfreq/5/0.5: result: dtype")
cases=cases+1
end
-- 75: fftfreq/5/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.fftfreq(5,spacing) end)
assert(ok==true,"fftfreq/5/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.1,0.2,-0.2,-0.1},"fftfreq/5/2: result",2e-12,2e-12)
eq(result.shape,{5},"fftfreq/5/2: result: shape")
eq(result.strides,{8},"fftfreq/5/2: result: strides")
eq(result.dtype,"float64","fftfreq/5/2: result: dtype")
cases=cases+1
end
-- 76: fftfreq/5/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.fftfreq(5,spacing) end)
assert(ok==true,"fftfreq/5/-0.25: acceptance"..": "..tostring(result))
eq(result:tolist(),{-0.0,-0.8,-1.6,1.6,0.8},"fftfreq/5/-0.25: result",2e-12,2e-12)
eq(result.shape,{5},"fftfreq/5/-0.25: result: shape")
eq(result.strides,{8},"fftfreq/5/-0.25: result: strides")
eq(result.dtype,"float64","fftfreq/5/-0.25: result: dtype")
cases=cases+1
end
-- 77: fftfreq/5/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.fftfreq(5,spacing) end)
assert(ok==false,"fftfreq/5/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 78: fftfreq/5/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.fftfreq(5,spacing) end)
assert(ok==false,"fftfreq/5/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 79: fftfreq/5/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.fftfreq(5,spacing) end)
assert(ok==true,"fftfreq/5/inf: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0,0.0,-0.0,-0.0},"fftfreq/5/inf: result",2e-12,2e-12)
eq(result.shape,{5},"fftfreq/5/inf: result: shape")
eq(result.strides,{8},"fftfreq/5/inf: result: strides")
eq(result.dtype,"float64","fftfreq/5/inf: result: dtype")
cases=cases+1
end
-- 80: fftfreq/5/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.fftfreq(5,spacing) end)
assert(ok==true,"fftfreq/5/nan: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),(0/0),(0/0),(0/0),(0/0)},"fftfreq/5/nan: result",2e-12,2e-12)
eq(result.shape,{5},"fftfreq/5/nan: result: shape")
eq(result.strides,{8},"fftfreq/5/nan: result: strides")
eq(result.dtype,"float64","fftfreq/5/nan: result: dtype")
cases=cases+1
end
-- 81: fftfreq/5/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.fftfreq(5,spacing) end)
assert(ok==true,"fftfreq/5/(1+2j): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.04,-0.08),np.complex(0.08,-0.16),np.complex(-0.08,0.16),np.complex(-0.04,0.08)},"fftfreq/5/(1+2j): result",2e-12,2e-12)
eq(result.shape,{5},"fftfreq/5/(1+2j): result: shape")
eq(result.strides,{16},"fftfreq/5/(1+2j): result: strides")
eq(result.dtype,"complex128","fftfreq/5/(1+2j): result: dtype")
cases=cases+1
end
-- 82: fftfreq/8/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.fftfreq(8,spacing) end)
assert(ok==true,"fftfreq/8/1.0: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.125,0.25,0.375,-0.5,-0.375,-0.25,-0.125},"fftfreq/8/1.0: result",2e-12,2e-12)
eq(result.shape,{8},"fftfreq/8/1.0: result: shape")
eq(result.strides,{8},"fftfreq/8/1.0: result: strides")
eq(result.dtype,"float64","fftfreq/8/1.0: result: dtype")
cases=cases+1
end
-- 83: fftfreq/8/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.fftfreq(8,spacing) end)
assert(ok==true,"fftfreq/8/0.5: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,0.5,0.75,-1.0,-0.75,-0.5,-0.25},"fftfreq/8/0.5: result",2e-12,2e-12)
eq(result.shape,{8},"fftfreq/8/0.5: result: shape")
eq(result.strides,{8},"fftfreq/8/0.5: result: strides")
eq(result.dtype,"float64","fftfreq/8/0.5: result: dtype")
cases=cases+1
end
-- 84: fftfreq/8/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.fftfreq(8,spacing) end)
assert(ok==true,"fftfreq/8/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0625,0.125,0.1875,-0.25,-0.1875,-0.125,-0.0625},"fftfreq/8/2: result",2e-12,2e-12)
eq(result.shape,{8},"fftfreq/8/2: result: shape")
eq(result.strides,{8},"fftfreq/8/2: result: strides")
eq(result.dtype,"float64","fftfreq/8/2: result: dtype")
cases=cases+1
end
-- 85: fftfreq/8/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.fftfreq(8,spacing) end)
assert(ok==true,"fftfreq/8/-0.25: acceptance"..": "..tostring(result))
eq(result:tolist(),{-0.0,-0.5,-1.0,-1.5,2.0,1.5,1.0,0.5},"fftfreq/8/-0.25: result",2e-12,2e-12)
eq(result.shape,{8},"fftfreq/8/-0.25: result: shape")
eq(result.strides,{8},"fftfreq/8/-0.25: result: strides")
eq(result.dtype,"float64","fftfreq/8/-0.25: result: dtype")
cases=cases+1
end
-- 86: fftfreq/8/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.fftfreq(8,spacing) end)
assert(ok==false,"fftfreq/8/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 87: fftfreq/8/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.fftfreq(8,spacing) end)
assert(ok==false,"fftfreq/8/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 88: fftfreq/8/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.fftfreq(8,spacing) end)
assert(ok==true,"fftfreq/8/inf: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0,0.0,0.0,-0.0,-0.0,-0.0,-0.0},"fftfreq/8/inf: result",2e-12,2e-12)
eq(result.shape,{8},"fftfreq/8/inf: result: shape")
eq(result.strides,{8},"fftfreq/8/inf: result: strides")
eq(result.dtype,"float64","fftfreq/8/inf: result: dtype")
cases=cases+1
end
-- 89: fftfreq/8/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.fftfreq(8,spacing) end)
assert(ok==true,"fftfreq/8/nan: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0)},"fftfreq/8/nan: result",2e-12,2e-12)
eq(result.shape,{8},"fftfreq/8/nan: result: shape")
eq(result.strides,{8},"fftfreq/8/nan: result: strides")
eq(result.dtype,"float64","fftfreq/8/nan: result: dtype")
cases=cases+1
end
-- 90: fftfreq/8/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.fftfreq(8,spacing) end)
assert(ok==true,"fftfreq/8/(1+2j): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.025,-0.05),np.complex(0.05,-0.1),np.complex(0.07500000000000001,-0.15000000000000002),np.complex(-0.1,0.2),np.complex(-0.07500000000000001,0.15000000000000002),np.complex(-0.05,0.1),np.complex(-0.025,0.05)},"fftfreq/8/(1+2j): result",2e-12,2e-12)
eq(result.shape,{8},"fftfreq/8/(1+2j): result: shape")
eq(result.strides,{16},"fftfreq/8/(1+2j): result: strides")
eq(result.dtype,"complex128","fftfreq/8/(1+2j): result: dtype")
cases=cases+1
end
-- 91: fftfreq/15/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/15/1.0: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.06666666666666667,0.13333333333333333,0.2,0.26666666666666666,0.3333333333333333,0.4,0.4666666666666667,-0.4666666666666667,-0.4,-0.3333333333333333,-0.26666666666666666,-0.2,-0.13333333333333333,-0.06666666666666667},"fftfreq/15/1.0: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/15/1.0: result: shape")
eq(result.strides,{8},"fftfreq/15/1.0: result: strides")
eq(result.dtype,"float64","fftfreq/15/1.0: result: dtype")
cases=cases+1
end
-- 92: fftfreq/15/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/15/0.5: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.13333333333333333,0.26666666666666666,0.4,0.5333333333333333,0.6666666666666666,0.8,0.9333333333333333,-0.9333333333333333,-0.8,-0.6666666666666666,-0.5333333333333333,-0.4,-0.26666666666666666,-0.13333333333333333},"fftfreq/15/0.5: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/15/0.5: result: shape")
eq(result.strides,{8},"fftfreq/15/0.5: result: strides")
eq(result.dtype,"float64","fftfreq/15/0.5: result: dtype")
cases=cases+1
end
-- 93: fftfreq/15/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.03333333333333333,0.06666666666666667,0.1,0.13333333333333333,0.16666666666666666,0.2,0.23333333333333334,-0.23333333333333334,-0.2,-0.16666666666666666,-0.13333333333333333,-0.1,-0.06666666666666667,-0.03333333333333333},"fftfreq/15/2: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/15/2: result: shape")
eq(result.strides,{8},"fftfreq/15/2: result: strides")
eq(result.dtype,"float64","fftfreq/15/2: result: dtype")
cases=cases+1
end
-- 94: fftfreq/15/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/15/-0.25: acceptance"..": "..tostring(result))
eq(result:tolist(),{-0.0,-0.26666666666666666,-0.5333333333333333,-0.8,-1.0666666666666667,-1.3333333333333333,-1.6,-1.8666666666666667,1.8666666666666667,1.6,1.3333333333333333,1.0666666666666667,0.8,0.5333333333333333,0.26666666666666666},"fftfreq/15/-0.25: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/15/-0.25: result: shape")
eq(result.strides,{8},"fftfreq/15/-0.25: result: strides")
eq(result.dtype,"float64","fftfreq/15/-0.25: result: dtype")
cases=cases+1
end
-- 95: fftfreq/15/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==false,"fftfreq/15/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 96: fftfreq/15/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==false,"fftfreq/15/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 97: fftfreq/15/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/15/inf: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0},"fftfreq/15/inf: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/15/inf: result: shape")
eq(result.strides,{8},"fftfreq/15/inf: result: strides")
eq(result.dtype,"float64","fftfreq/15/inf: result: dtype")
cases=cases+1
end
-- 98: fftfreq/15/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/15/nan: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0)},"fftfreq/15/nan: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/15/nan: result: shape")
eq(result.strides,{8},"fftfreq/15/nan: result: strides")
eq(result.dtype,"float64","fftfreq/15/nan: result: dtype")
cases=cases+1
end
-- 99: fftfreq/15/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/15/(1+2j): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.013333333333333334,-0.02666666666666667),np.complex(0.02666666666666667,-0.05333333333333334),np.complex(0.04,-0.08),np.complex(0.05333333333333334,-0.10666666666666667),np.complex(0.06666666666666667,-0.13333333333333333),np.complex(0.08,-0.16),np.complex(0.09333333333333334,-0.18666666666666668),np.complex(-0.09333333333333334,0.18666666666666668),np.complex(-0.08,0.16),np.complex(-0.06666666666666667,0.13333333333333333),np.complex(-0.05333333333333334,0.10666666666666667),np.complex(-0.04,0.08),np.complex(-0.02666666666666667,0.05333333333333334),np.complex(-0.013333333333333334,0.02666666666666667)},"fftfreq/15/(1+2j): result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/15/(1+2j): result: shape")
eq(result.strides,{16},"fftfreq/15/(1+2j): result: strides")
eq(result.dtype,"complex128","fftfreq/15/(1+2j): result: dtype")
cases=cases+1
end
-- 100: fftfreq/127/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/127/1.0: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.007874015748031496,0.015748031496062992,0.023622047244094488,0.031496062992125984,0.03937007874015748,0.047244094488188976,0.05511811023622047,0.06299212598425197,0.07086614173228346,0.07874015748031496,0.08661417322834646,0.09448818897637795,0.10236220472440945,0.11023622047244094,0.11811023622047244,0.12598425196850394,0.13385826771653542,0.14173228346456693,0.14960629921259844,0.15748031496062992,0.1653543307086614,0.1732283464566929,0.18110236220472442,0.1889763779527559,0.19685039370078738,0.2047244094488189,0.2125984251968504,0.2204724409448819,0.22834645669291337,0.23622047244094488,0.2440944881889764,0.25196850393700787,0.25984251968503935,0.26771653543307083,0.2755905511811024,0.28346456692913385,0.29133858267716534,0.2992125984251969,0.30708661417322836,0.31496062992125984,0.3228346456692913,0.3307086614173228,0.33858267716535434,0.3464566929133858,0.3543307086614173,0.36220472440944884,0.3700787401574803,0.3779527559055118,0.3858267716535433,0.39370078740157477,0.4015748031496063,0.4094488188976378,0.41732283464566927,0.4251968503937008,0.4330708661417323,0.4409448818897638,0.44881889763779526,0.45669291338582674,0.4645669291338583,0.47244094488188976,0.48031496062992124,0.4881889763779528,0.49606299212598426,-0.49606299212598426,-0.4881889763779528,-0.48031496062992124,-0.47244094488188976,-0.4645669291338583,-0.45669291338582674,-0.44881889763779526,-0.4409448818897638,-0.4330708661417323,-0.4251968503937008,-0.41732283464566927,-0.4094488188976378,-0.4015748031496063,-0.39370078740157477,-0.3858267716535433,-0.3779527559055118,-0.3700787401574803,-0.36220472440944884,-0.3543307086614173,-0.3464566929133858,-0.33858267716535434,-0.3307086614173228,-0.3228346456692913,-0.31496062992125984,-0.30708661417322836,-0.2992125984251969,-0.29133858267716534,-0.28346456692913385,-0.2755905511811024,-0.26771653543307083,-0.25984251968503935,-0.25196850393700787,-0.2440944881889764,-0.23622047244094488,-0.22834645669291337,-0.2204724409448819,-0.2125984251968504,-0.2047244094488189,-0.19685039370078738,-0.1889763779527559,-0.18110236220472442,-0.1732283464566929,-0.1653543307086614,-0.15748031496062992,-0.14960629921259844,-0.14173228346456693,-0.13385826771653542,-0.12598425196850394,-0.11811023622047244,-0.11023622047244094,-0.10236220472440945,-0.09448818897637795,-0.08661417322834646,-0.07874015748031496,-0.07086614173228346,-0.06299212598425197,-0.05511811023622047,-0.047244094488188976,-0.03937007874015748,-0.031496062992125984,-0.023622047244094488,-0.015748031496062992,-0.007874015748031496},"fftfreq/127/1.0: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/127/1.0: result: shape")
eq(result.strides,{8},"fftfreq/127/1.0: result: strides")
eq(result.dtype,"float64","fftfreq/127/1.0: result: dtype")
cases=cases+1
end
-- 101: fftfreq/127/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/127/0.5: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.015748031496062992,0.031496062992125984,0.047244094488188976,0.06299212598425197,0.07874015748031496,0.09448818897637795,0.11023622047244094,0.12598425196850394,0.14173228346456693,0.15748031496062992,0.1732283464566929,0.1889763779527559,0.2047244094488189,0.2204724409448819,0.23622047244094488,0.25196850393700787,0.26771653543307083,0.28346456692913385,0.2992125984251969,0.31496062992125984,0.3307086614173228,0.3464566929133858,0.36220472440944884,0.3779527559055118,0.39370078740157477,0.4094488188976378,0.4251968503937008,0.4409448818897638,0.45669291338582674,0.47244094488188976,0.4881889763779528,0.5039370078740157,0.5196850393700787,0.5354330708661417,0.5511811023622047,0.5669291338582677,0.5826771653543307,0.5984251968503937,0.6141732283464567,0.6299212598425197,0.6456692913385826,0.6614173228346456,0.6771653543307087,0.6929133858267716,0.7086614173228346,0.7244094488188977,0.7401574803149606,0.7559055118110236,0.7716535433070866,0.7874015748031495,0.8031496062992126,0.8188976377952756,0.8346456692913385,0.8503937007874016,0.8661417322834646,0.8818897637795275,0.8976377952755905,0.9133858267716535,0.9291338582677166,0.9448818897637795,0.9606299212598425,0.9763779527559056,0.9921259842519685,-0.9921259842519685,-0.9763779527559056,-0.9606299212598425,-0.9448818897637795,-0.9291338582677166,-0.9133858267716535,-0.8976377952755905,-0.8818897637795275,-0.8661417322834646,-0.8503937007874016,-0.8346456692913385,-0.8188976377952756,-0.8031496062992126,-0.7874015748031495,-0.7716535433070866,-0.7559055118110236,-0.7401574803149606,-0.7244094488188977,-0.7086614173228346,-0.6929133858267716,-0.6771653543307087,-0.6614173228346456,-0.6456692913385826,-0.6299212598425197,-0.6141732283464567,-0.5984251968503937,-0.5826771653543307,-0.5669291338582677,-0.5511811023622047,-0.5354330708661417,-0.5196850393700787,-0.5039370078740157,-0.4881889763779528,-0.47244094488188976,-0.45669291338582674,-0.4409448818897638,-0.4251968503937008,-0.4094488188976378,-0.39370078740157477,-0.3779527559055118,-0.36220472440944884,-0.3464566929133858,-0.3307086614173228,-0.31496062992125984,-0.2992125984251969,-0.28346456692913385,-0.26771653543307083,-0.25196850393700787,-0.23622047244094488,-0.2204724409448819,-0.2047244094488189,-0.1889763779527559,-0.1732283464566929,-0.15748031496062992,-0.14173228346456693,-0.12598425196850394,-0.11023622047244094,-0.09448818897637795,-0.07874015748031496,-0.06299212598425197,-0.047244094488188976,-0.031496062992125984,-0.015748031496062992},"fftfreq/127/0.5: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/127/0.5: result: shape")
eq(result.strides,{8},"fftfreq/127/0.5: result: strides")
eq(result.dtype,"float64","fftfreq/127/0.5: result: dtype")
cases=cases+1
end
-- 102: fftfreq/127/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.003937007874015748,0.007874015748031496,0.011811023622047244,0.015748031496062992,0.01968503937007874,0.023622047244094488,0.027559055118110236,0.031496062992125984,0.03543307086614173,0.03937007874015748,0.04330708661417323,0.047244094488188976,0.051181102362204724,0.05511811023622047,0.05905511811023622,0.06299212598425197,0.06692913385826771,0.07086614173228346,0.07480314960629922,0.07874015748031496,0.0826771653543307,0.08661417322834646,0.09055118110236221,0.09448818897637795,0.09842519685039369,0.10236220472440945,0.1062992125984252,0.11023622047244094,0.11417322834645668,0.11811023622047244,0.1220472440944882,0.12598425196850394,0.12992125984251968,0.13385826771653542,0.1377952755905512,0.14173228346456693,0.14566929133858267,0.14960629921259844,0.15354330708661418,0.15748031496062992,0.16141732283464566,0.1653543307086614,0.16929133858267717,0.1732283464566929,0.17716535433070865,0.18110236220472442,0.18503937007874016,0.1889763779527559,0.19291338582677164,0.19685039370078738,0.20078740157480315,0.2047244094488189,0.20866141732283464,0.2125984251968504,0.21653543307086615,0.2204724409448819,0.22440944881889763,0.22834645669291337,0.23228346456692914,0.23622047244094488,0.24015748031496062,0.2440944881889764,0.24803149606299213,-0.24803149606299213,-0.2440944881889764,-0.24015748031496062,-0.23622047244094488,-0.23228346456692914,-0.22834645669291337,-0.22440944881889763,-0.2204724409448819,-0.21653543307086615,-0.2125984251968504,-0.20866141732283464,-0.2047244094488189,-0.20078740157480315,-0.19685039370078738,-0.19291338582677164,-0.1889763779527559,-0.18503937007874016,-0.18110236220472442,-0.17716535433070865,-0.1732283464566929,-0.16929133858267717,-0.1653543307086614,-0.16141732283464566,-0.15748031496062992,-0.15354330708661418,-0.14960629921259844,-0.14566929133858267,-0.14173228346456693,-0.1377952755905512,-0.13385826771653542,-0.12992125984251968,-0.12598425196850394,-0.1220472440944882,-0.11811023622047244,-0.11417322834645668,-0.11023622047244094,-0.1062992125984252,-0.10236220472440945,-0.09842519685039369,-0.09448818897637795,-0.09055118110236221,-0.08661417322834646,-0.0826771653543307,-0.07874015748031496,-0.07480314960629922,-0.07086614173228346,-0.06692913385826771,-0.06299212598425197,-0.05905511811023622,-0.05511811023622047,-0.051181102362204724,-0.047244094488188976,-0.04330708661417323,-0.03937007874015748,-0.03543307086614173,-0.031496062992125984,-0.027559055118110236,-0.023622047244094488,-0.01968503937007874,-0.015748031496062992,-0.011811023622047244,-0.007874015748031496,-0.003937007874015748},"fftfreq/127/2: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/127/2: result: shape")
eq(result.strides,{8},"fftfreq/127/2: result: strides")
eq(result.dtype,"float64","fftfreq/127/2: result: dtype")
cases=cases+1
end
-- 103: fftfreq/127/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/127/-0.25: acceptance"..": "..tostring(result))
eq(result:tolist(),{-0.0,-0.031496062992125984,-0.06299212598425197,-0.09448818897637795,-0.12598425196850394,-0.15748031496062992,-0.1889763779527559,-0.2204724409448819,-0.25196850393700787,-0.28346456692913385,-0.31496062992125984,-0.3464566929133858,-0.3779527559055118,-0.4094488188976378,-0.4409448818897638,-0.47244094488188976,-0.5039370078740157,-0.5354330708661417,-0.5669291338582677,-0.5984251968503937,-0.6299212598425197,-0.6614173228346456,-0.6929133858267716,-0.7244094488188977,-0.7559055118110236,-0.7874015748031495,-0.8188976377952756,-0.8503937007874016,-0.8818897637795275,-0.9133858267716535,-0.9448818897637795,-0.9763779527559056,-1.0078740157480315,-1.0393700787401574,-1.0708661417322833,-1.1023622047244095,-1.1338582677165354,-1.1653543307086613,-1.1968503937007875,-1.2283464566929134,-1.2598425196850394,-1.2913385826771653,-1.3228346456692912,-1.3543307086614174,-1.3858267716535433,-1.4173228346456692,-1.4488188976377954,-1.4803149606299213,-1.5118110236220472,-1.5433070866141732,-1.574803149606299,-1.6062992125984252,-1.6377952755905512,-1.669291338582677,-1.7007874015748032,-1.7322834645669292,-1.763779527559055,-1.795275590551181,-1.826771653543307,-1.858267716535433,-1.889763779527559,-1.921259842519685,-1.952755905511811,-1.984251968503937,1.984251968503937,1.952755905511811,1.921259842519685,1.889763779527559,1.858267716535433,1.826771653543307,1.795275590551181,1.763779527559055,1.7322834645669292,1.7007874015748032,1.669291338582677,1.6377952755905512,1.6062992125984252,1.574803149606299,1.5433070866141732,1.5118110236220472,1.4803149606299213,1.4488188976377954,1.4173228346456692,1.3858267716535433,1.3543307086614174,1.3228346456692912,1.2913385826771653,1.2598425196850394,1.2283464566929134,1.1968503937007875,1.1653543307086613,1.1338582677165354,1.1023622047244095,1.0708661417322833,1.0393700787401574,1.0078740157480315,0.9763779527559056,0.9448818897637795,0.9133858267716535,0.8818897637795275,0.8503937007874016,0.8188976377952756,0.7874015748031495,0.7559055118110236,0.7244094488188977,0.6929133858267716,0.6614173228346456,0.6299212598425197,0.5984251968503937,0.5669291338582677,0.5354330708661417,0.5039370078740157,0.47244094488188976,0.4409448818897638,0.4094488188976378,0.3779527559055118,0.3464566929133858,0.31496062992125984,0.28346456692913385,0.25196850393700787,0.2204724409448819,0.1889763779527559,0.15748031496062992,0.12598425196850394,0.09448818897637795,0.06299212598425197,0.031496062992125984},"fftfreq/127/-0.25: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/127/-0.25: result: shape")
eq(result.strides,{8},"fftfreq/127/-0.25: result: strides")
eq(result.dtype,"float64","fftfreq/127/-0.25: result: dtype")
cases=cases+1
end
-- 104: fftfreq/127/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==false,"fftfreq/127/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 105: fftfreq/127/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==false,"fftfreq/127/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 106: fftfreq/127/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/127/inf: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0,-0.0},"fftfreq/127/inf: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/127/inf: result: shape")
eq(result.strides,{8},"fftfreq/127/inf: result: strides")
eq(result.dtype,"float64","fftfreq/127/inf: result: dtype")
cases=cases+1
end
-- 107: fftfreq/127/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/127/nan: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0)},"fftfreq/127/nan: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/127/nan: result: shape")
eq(result.strides,{8},"fftfreq/127/nan: result: strides")
eq(result.dtype,"float64","fftfreq/127/nan: result: dtype")
cases=cases+1
end
-- 108: fftfreq/127/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/127/(1+2j): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.0015748031496062992,-0.0031496062992125984),np.complex(0.0031496062992125984,-0.006299212598425197),np.complex(0.004724409448818898,-0.009448818897637795),np.complex(0.006299212598425197,-0.012598425196850394),np.complex(0.007874015748031496,-0.015748031496062992),np.complex(0.009448818897637795,-0.01889763779527559),np.complex(0.011023622047244094,-0.02204724409448819),np.complex(0.012598425196850394,-0.025196850393700787),np.complex(0.014173228346456693,-0.028346456692913385),np.complex(0.015748031496062992,-0.031496062992125984),np.complex(0.01732283464566929,-0.03464566929133858),np.complex(0.01889763779527559,-0.03779527559055118),np.complex(0.02047244094488189,-0.04094488188976378),np.complex(0.02204724409448819,-0.04409448818897638),np.complex(0.023622047244094488,-0.047244094488188976),np.complex(0.025196850393700787,-0.050393700787401574),np.complex(0.026771653543307086,-0.05354330708661417),np.complex(0.028346456692913385,-0.05669291338582677),np.complex(0.029921259842519685,-0.05984251968503937),np.complex(0.031496062992125984,-0.06299212598425197),np.complex(0.03307086614173228,-0.06614173228346457),np.complex(0.03464566929133858,-0.06929133858267716),np.complex(0.03622047244094488,-0.07244094488188976),np.complex(0.03779527559055118,-0.07559055118110236),np.complex(0.03937007874015748,-0.07874015748031496),np.complex(0.04094488188976378,-0.08188976377952756),np.complex(0.04251968503937008,-0.08503937007874016),np.complex(0.04409448818897638,-0.08818897637795275),np.complex(0.04566929133858268,-0.09133858267716535),np.complex(0.047244094488188976,-0.09448818897637795),np.complex(0.048818897637795275,-0.09763779527559055),np.complex(0.050393700787401574,-0.10078740157480315),np.complex(0.05196850393700787,-0.10393700787401575),np.complex(0.05354330708661417,-0.10708661417322834),np.complex(0.05511811023622047,-0.11023622047244094),np.complex(0.05669291338582677,-0.11338582677165354),np.complex(0.05826771653543307,-0.11653543307086614),np.complex(0.05984251968503937,-0.11968503937007874),np.complex(0.06141732283464567,-0.12283464566929134),np.complex(0.06299212598425197,-0.12598425196850394),np.complex(0.06456692913385827,-0.12913385826771653),np.complex(0.06614173228346457,-0.13228346456692913),np.complex(0.06771653543307087,-0.13543307086614173),np.complex(0.06929133858267716,-0.13858267716535433),np.complex(0.07086614173228346,-0.14173228346456693),np.complex(0.07244094488188976,-0.14488188976377953),np.complex(0.07401574803149606,-0.14803149606299212),np.complex(0.07559055118110236,-0.15118110236220472),np.complex(0.07716535433070866,-0.15433070866141732),np.complex(0.07874015748031496,-0.15748031496062992),np.complex(0.08031496062992126,-0.16062992125984252),np.complex(0.08188976377952756,-0.16377952755905512),np.complex(0.08346456692913386,-0.16692913385826771),np.complex(0.08503937007874016,-0.1700787401574803),np.complex(0.08661417322834646,-0.1732283464566929),np.complex(0.08818897637795275,-0.1763779527559055),np.complex(0.08976377952755905,-0.1795275590551181),np.complex(0.09133858267716535,-0.1826771653543307),np.complex(0.09291338582677165,-0.1858267716535433),np.complex(0.09448818897637795,-0.1889763779527559),np.complex(0.09606299212598425,-0.1921259842519685),np.complex(0.09763779527559055,-0.1952755905511811),np.complex(0.09921259842519685,-0.1984251968503937),np.complex(-0.09921259842519685,0.1984251968503937),np.complex(-0.09763779527559055,0.1952755905511811),np.complex(-0.09606299212598425,0.1921259842519685),np.complex(-0.09448818897637795,0.1889763779527559),np.complex(-0.09291338582677165,0.1858267716535433),np.complex(-0.09133858267716535,0.1826771653543307),np.complex(-0.08976377952755905,0.1795275590551181),np.complex(-0.08818897637795275,0.1763779527559055),np.complex(-0.08661417322834646,0.1732283464566929),np.complex(-0.08503937007874016,0.1700787401574803),np.complex(-0.08346456692913386,0.16692913385826771),np.complex(-0.08188976377952756,0.16377952755905512),np.complex(-0.08031496062992126,0.16062992125984252),np.complex(-0.07874015748031496,0.15748031496062992),np.complex(-0.07716535433070866,0.15433070866141732),np.complex(-0.07559055118110236,0.15118110236220472),np.complex(-0.07401574803149606,0.14803149606299212),np.complex(-0.07244094488188976,0.14488188976377953),np.complex(-0.07086614173228346,0.14173228346456693),np.complex(-0.06929133858267716,0.13858267716535433),np.complex(-0.06771653543307087,0.13543307086614173),np.complex(-0.06614173228346457,0.13228346456692913),np.complex(-0.06456692913385827,0.12913385826771653),np.complex(-0.06299212598425197,0.12598425196850394),np.complex(-0.06141732283464567,0.12283464566929134),np.complex(-0.05984251968503937,0.11968503937007874),np.complex(-0.05826771653543307,0.11653543307086614),np.complex(-0.05669291338582677,0.11338582677165354),np.complex(-0.05511811023622047,0.11023622047244094),np.complex(-0.05354330708661417,0.10708661417322834),np.complex(-0.05196850393700787,0.10393700787401575),np.complex(-0.050393700787401574,0.10078740157480315),np.complex(-0.048818897637795275,0.09763779527559055),np.complex(-0.047244094488188976,0.09448818897637795),np.complex(-0.04566929133858268,0.09133858267716535),np.complex(-0.04409448818897638,0.08818897637795275),np.complex(-0.04251968503937008,0.08503937007874016),np.complex(-0.04094488188976378,0.08188976377952756),np.complex(-0.03937007874015748,0.07874015748031496),np.complex(-0.03779527559055118,0.07559055118110236),np.complex(-0.03622047244094488,0.07244094488188976),np.complex(-0.03464566929133858,0.06929133858267716),np.complex(-0.03307086614173228,0.06614173228346457),np.complex(-0.031496062992125984,0.06299212598425197),np.complex(-0.029921259842519685,0.05984251968503937),np.complex(-0.028346456692913385,0.05669291338582677),np.complex(-0.026771653543307086,0.05354330708661417),np.complex(-0.025196850393700787,0.050393700787401574),np.complex(-0.023622047244094488,0.047244094488188976),np.complex(-0.02204724409448819,0.04409448818897638),np.complex(-0.02047244094488189,0.04094488188976378),np.complex(-0.01889763779527559,0.03779527559055118),np.complex(-0.01732283464566929,0.03464566929133858),np.complex(-0.015748031496062992,0.031496062992125984),np.complex(-0.014173228346456693,0.028346456692913385),np.complex(-0.012598425196850394,0.025196850393700787),np.complex(-0.011023622047244094,0.02204724409448819),np.complex(-0.009448818897637795,0.01889763779527559),np.complex(-0.007874015748031496,0.015748031496062992),np.complex(-0.006299212598425197,0.012598425196850394),np.complex(-0.004724409448818898,0.009448818897637795),np.complex(-0.0031496062992125984,0.006299212598425197),np.complex(-0.0015748031496062992,0.0031496062992125984)},"fftfreq/127/(1+2j): result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/127/(1+2j): result: shape")
eq(result.strides,{16},"fftfreq/127/(1+2j): result: strides")
eq(result.dtype,"complex128","fftfreq/127/(1+2j): result: dtype")
cases=cases+1
end
-- 109: fftfreq/typed/bool/-1/0
do
local spacing=np.array(false,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/bool/-1/0: acceptance"..": "..tostring(result))
eq(spacing:tolist(),false,"fftfreq/typed/bool/-1/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/-1/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/-1/0: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/-1/0: spacing state: dtype")
cases=cases+1
end
-- 110: fftfreq/typed/bool/-1/1
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/bool/-1/1: acceptance"..": "..tostring(result))
eq(spacing:tolist(),true,"fftfreq/typed/bool/-1/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/-1/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/-1/1: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/-1/1: spacing state: dtype")
cases=cases+1
end
-- 111: fftfreq/typed/bool/-1/2
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/bool/-1/2: acceptance"..": "..tostring(result))
eq(spacing:tolist(),true,"fftfreq/typed/bool/-1/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/-1/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/-1/2: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/-1/2: spacing state: dtype")
cases=cases+1
end
-- 112: fftfreq/typed/bool/0/0
do
local spacing=np.array(false,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/bool/0/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/bool/0/0: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/bool/0/0: result: shape")
eq(result.strides,{0},"fftfreq/typed/bool/0/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/bool/0/0: result: dtype")
eq(spacing:tolist(),false,"fftfreq/typed/bool/0/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/0/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/0/0: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/0/0: spacing state: dtype")
cases=cases+1
end
-- 113: fftfreq/typed/bool/0/1
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/bool/0/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/bool/0/1: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/bool/0/1: result: shape")
eq(result.strides,{0},"fftfreq/typed/bool/0/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/bool/0/1: result: dtype")
eq(spacing:tolist(),true,"fftfreq/typed/bool/0/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/0/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/0/1: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/0/1: spacing state: dtype")
cases=cases+1
end
-- 114: fftfreq/typed/bool/0/2
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/bool/0/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/bool/0/2: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/bool/0/2: result: shape")
eq(result.strides,{0},"fftfreq/typed/bool/0/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/bool/0/2: result: dtype")
eq(spacing:tolist(),true,"fftfreq/typed/bool/0/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/0/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/0/2: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/0/2: spacing state: dtype")
cases=cases+1
end
-- 115: fftfreq/typed/bool/1/0
do
local spacing=np.array(false,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/bool/1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"fftfreq/typed/bool/1/0: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/bool/1/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/bool/1/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/bool/1/0: result: dtype")
eq(spacing:tolist(),false,"fftfreq/typed/bool/1/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/1/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/1/0: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/1/0: spacing state: dtype")
cases=cases+1
end
-- 116: fftfreq/typed/bool/1/1
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/bool/1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"fftfreq/typed/bool/1/1: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/bool/1/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/bool/1/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/bool/1/1: result: dtype")
eq(spacing:tolist(),true,"fftfreq/typed/bool/1/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/1/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/1/1: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/1/1: spacing state: dtype")
cases=cases+1
end
-- 117: fftfreq/typed/bool/1/2
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/bool/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"fftfreq/typed/bool/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/bool/1/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/bool/1/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/bool/1/2: result: dtype")
eq(spacing:tolist(),true,"fftfreq/typed/bool/1/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/1/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/1/2: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/1/2: spacing state: dtype")
cases=cases+1
end
-- 118: fftfreq/typed/bool/3/0
do
local spacing=np.array(false,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/bool/3/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,-math.huge},"fftfreq/typed/bool/3/0: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/bool/3/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/bool/3/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/bool/3/0: result: dtype")
eq(spacing:tolist(),false,"fftfreq/typed/bool/3/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/3/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/3/0: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/3/0: spacing state: dtype")
cases=cases+1
end
-- 119: fftfreq/typed/bool/3/1
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/bool/3/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.3333333333333333,-0.3333333333333333},"fftfreq/typed/bool/3/1: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/bool/3/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/bool/3/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/bool/3/1: result: dtype")
eq(spacing:tolist(),true,"fftfreq/typed/bool/3/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/3/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/3/1: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/3/1: spacing state: dtype")
cases=cases+1
end
-- 120: fftfreq/typed/bool/3/2
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/bool/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.3333333333333333,-0.3333333333333333},"fftfreq/typed/bool/3/2: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/bool/3/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/bool/3/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/bool/3/2: result: dtype")
eq(spacing:tolist(),true,"fftfreq/typed/bool/3/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/3/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/3/2: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/3/2: spacing state: dtype")
cases=cases+1
end
-- 121: fftfreq/typed/bool/4/0
do
local spacing=np.array(false,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/bool/4/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,-math.huge,-math.huge},"fftfreq/typed/bool/4/0: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/bool/4/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/bool/4/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/bool/4/0: result: dtype")
eq(spacing:tolist(),false,"fftfreq/typed/bool/4/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/4/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/4/0: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/4/0: spacing state: dtype")
cases=cases+1
end
-- 122: fftfreq/typed/bool/4/1
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/bool/4/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,-0.5,-0.25},"fftfreq/typed/bool/4/1: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/bool/4/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/bool/4/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/bool/4/1: result: dtype")
eq(spacing:tolist(),true,"fftfreq/typed/bool/4/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/4/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/4/1: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/4/1: spacing state: dtype")
cases=cases+1
end
-- 123: fftfreq/typed/bool/4/2
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/bool/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,-0.5,-0.25},"fftfreq/typed/bool/4/2: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/bool/4/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/bool/4/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/bool/4/2: result: dtype")
eq(spacing:tolist(),true,"fftfreq/typed/bool/4/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/4/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/4/2: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/4/2: spacing state: dtype")
cases=cases+1
end
-- 124: fftfreq/typed/bool/15/0
do
local spacing=np.array(false,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/bool/15/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/bool/15/0: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/bool/15/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/bool/15/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/bool/15/0: result: dtype")
eq(spacing:tolist(),false,"fftfreq/typed/bool/15/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/15/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/15/0: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/15/0: spacing state: dtype")
cases=cases+1
end
-- 125: fftfreq/typed/bool/15/1
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/bool/15/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.06666666666666667,0.13333333333333333,0.2,0.26666666666666666,0.3333333333333333,0.4,0.4666666666666667,-0.4666666666666667,-0.4,-0.3333333333333333,-0.26666666666666666,-0.2,-0.13333333333333333,-0.06666666666666667},"fftfreq/typed/bool/15/1: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/bool/15/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/bool/15/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/bool/15/1: result: dtype")
eq(spacing:tolist(),true,"fftfreq/typed/bool/15/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/15/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/15/1: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/15/1: spacing state: dtype")
cases=cases+1
end
-- 126: fftfreq/typed/bool/15/2
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/bool/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.06666666666666667,0.13333333333333333,0.2,0.26666666666666666,0.3333333333333333,0.4,0.4666666666666667,-0.4666666666666667,-0.4,-0.3333333333333333,-0.26666666666666666,-0.2,-0.13333333333333333,-0.06666666666666667},"fftfreq/typed/bool/15/2: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/bool/15/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/bool/15/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/bool/15/2: result: dtype")
eq(spacing:tolist(),true,"fftfreq/typed/bool/15/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/15/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/15/2: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/15/2: spacing state: dtype")
cases=cases+1
end
-- 127: fftfreq/typed/bool/127/0
do
local spacing=np.array(false,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/bool/127/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/bool/127/0: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/bool/127/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/bool/127/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/bool/127/0: result: dtype")
eq(spacing:tolist(),false,"fftfreq/typed/bool/127/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/127/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/127/0: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/127/0: spacing state: dtype")
cases=cases+1
end
-- 128: fftfreq/typed/bool/127/1
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/bool/127/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.007874015748031496,0.015748031496062992,0.023622047244094488,0.031496062992125984,0.03937007874015748,0.047244094488188976,0.05511811023622047,0.06299212598425197,0.07086614173228346,0.07874015748031496,0.08661417322834646,0.09448818897637795,0.10236220472440945,0.11023622047244094,0.11811023622047244,0.12598425196850394,0.13385826771653542,0.14173228346456693,0.14960629921259844,0.15748031496062992,0.1653543307086614,0.1732283464566929,0.18110236220472442,0.1889763779527559,0.19685039370078738,0.2047244094488189,0.2125984251968504,0.2204724409448819,0.22834645669291337,0.23622047244094488,0.2440944881889764,0.25196850393700787,0.25984251968503935,0.26771653543307083,0.2755905511811024,0.28346456692913385,0.29133858267716534,0.2992125984251969,0.30708661417322836,0.31496062992125984,0.3228346456692913,0.3307086614173228,0.33858267716535434,0.3464566929133858,0.3543307086614173,0.36220472440944884,0.3700787401574803,0.3779527559055118,0.3858267716535433,0.39370078740157477,0.4015748031496063,0.4094488188976378,0.41732283464566927,0.4251968503937008,0.4330708661417323,0.4409448818897638,0.44881889763779526,0.45669291338582674,0.4645669291338583,0.47244094488188976,0.48031496062992124,0.4881889763779528,0.49606299212598426,-0.49606299212598426,-0.4881889763779528,-0.48031496062992124,-0.47244094488188976,-0.4645669291338583,-0.45669291338582674,-0.44881889763779526,-0.4409448818897638,-0.4330708661417323,-0.4251968503937008,-0.41732283464566927,-0.4094488188976378,-0.4015748031496063,-0.39370078740157477,-0.3858267716535433,-0.3779527559055118,-0.3700787401574803,-0.36220472440944884,-0.3543307086614173,-0.3464566929133858,-0.33858267716535434,-0.3307086614173228,-0.3228346456692913,-0.31496062992125984,-0.30708661417322836,-0.2992125984251969,-0.29133858267716534,-0.28346456692913385,-0.2755905511811024,-0.26771653543307083,-0.25984251968503935,-0.25196850393700787,-0.2440944881889764,-0.23622047244094488,-0.22834645669291337,-0.2204724409448819,-0.2125984251968504,-0.2047244094488189,-0.19685039370078738,-0.1889763779527559,-0.18110236220472442,-0.1732283464566929,-0.1653543307086614,-0.15748031496062992,-0.14960629921259844,-0.14173228346456693,-0.13385826771653542,-0.12598425196850394,-0.11811023622047244,-0.11023622047244094,-0.10236220472440945,-0.09448818897637795,-0.08661417322834646,-0.07874015748031496,-0.07086614173228346,-0.06299212598425197,-0.05511811023622047,-0.047244094488188976,-0.03937007874015748,-0.031496062992125984,-0.023622047244094488,-0.015748031496062992,-0.007874015748031496},"fftfreq/typed/bool/127/1: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/bool/127/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/bool/127/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/bool/127/1: result: dtype")
eq(spacing:tolist(),true,"fftfreq/typed/bool/127/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/127/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/127/1: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/127/1: spacing state: dtype")
cases=cases+1
end
-- 129: fftfreq/typed/bool/127/2
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/bool/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.007874015748031496,0.015748031496062992,0.023622047244094488,0.031496062992125984,0.03937007874015748,0.047244094488188976,0.05511811023622047,0.06299212598425197,0.07086614173228346,0.07874015748031496,0.08661417322834646,0.09448818897637795,0.10236220472440945,0.11023622047244094,0.11811023622047244,0.12598425196850394,0.13385826771653542,0.14173228346456693,0.14960629921259844,0.15748031496062992,0.1653543307086614,0.1732283464566929,0.18110236220472442,0.1889763779527559,0.19685039370078738,0.2047244094488189,0.2125984251968504,0.2204724409448819,0.22834645669291337,0.23622047244094488,0.2440944881889764,0.25196850393700787,0.25984251968503935,0.26771653543307083,0.2755905511811024,0.28346456692913385,0.29133858267716534,0.2992125984251969,0.30708661417322836,0.31496062992125984,0.3228346456692913,0.3307086614173228,0.33858267716535434,0.3464566929133858,0.3543307086614173,0.36220472440944884,0.3700787401574803,0.3779527559055118,0.3858267716535433,0.39370078740157477,0.4015748031496063,0.4094488188976378,0.41732283464566927,0.4251968503937008,0.4330708661417323,0.4409448818897638,0.44881889763779526,0.45669291338582674,0.4645669291338583,0.47244094488188976,0.48031496062992124,0.4881889763779528,0.49606299212598426,-0.49606299212598426,-0.4881889763779528,-0.48031496062992124,-0.47244094488188976,-0.4645669291338583,-0.45669291338582674,-0.44881889763779526,-0.4409448818897638,-0.4330708661417323,-0.4251968503937008,-0.41732283464566927,-0.4094488188976378,-0.4015748031496063,-0.39370078740157477,-0.3858267716535433,-0.3779527559055118,-0.3700787401574803,-0.36220472440944884,-0.3543307086614173,-0.3464566929133858,-0.33858267716535434,-0.3307086614173228,-0.3228346456692913,-0.31496062992125984,-0.30708661417322836,-0.2992125984251969,-0.29133858267716534,-0.28346456692913385,-0.2755905511811024,-0.26771653543307083,-0.25984251968503935,-0.25196850393700787,-0.2440944881889764,-0.23622047244094488,-0.22834645669291337,-0.2204724409448819,-0.2125984251968504,-0.2047244094488189,-0.19685039370078738,-0.1889763779527559,-0.18110236220472442,-0.1732283464566929,-0.1653543307086614,-0.15748031496062992,-0.14960629921259844,-0.14173228346456693,-0.13385826771653542,-0.12598425196850394,-0.11811023622047244,-0.11023622047244094,-0.10236220472440945,-0.09448818897637795,-0.08661417322834646,-0.07874015748031496,-0.07086614173228346,-0.06299212598425197,-0.05511811023622047,-0.047244094488188976,-0.03937007874015748,-0.031496062992125984,-0.023622047244094488,-0.015748031496062992,-0.007874015748031496},"fftfreq/typed/bool/127/2: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/bool/127/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/bool/127/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/bool/127/2: result: dtype")
eq(spacing:tolist(),true,"fftfreq/typed/bool/127/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/127/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/127/2: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/127/2: spacing state: dtype")
cases=cases+1
end
-- 130: fftfreq/typed/bool/128/0
do
local spacing=np.array(false,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/bool/128/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/bool/128/0: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/bool/128/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/bool/128/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/bool/128/0: result: dtype")
eq(spacing:tolist(),false,"fftfreq/typed/bool/128/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/128/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/128/0: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/128/0: spacing state: dtype")
cases=cases+1
end
-- 131: fftfreq/typed/bool/128/1
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/bool/128/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0078125,0.015625,0.0234375,0.03125,0.0390625,0.046875,0.0546875,0.0625,0.0703125,0.078125,0.0859375,0.09375,0.1015625,0.109375,0.1171875,0.125,0.1328125,0.140625,0.1484375,0.15625,0.1640625,0.171875,0.1796875,0.1875,0.1953125,0.203125,0.2109375,0.21875,0.2265625,0.234375,0.2421875,0.25,0.2578125,0.265625,0.2734375,0.28125,0.2890625,0.296875,0.3046875,0.3125,0.3203125,0.328125,0.3359375,0.34375,0.3515625,0.359375,0.3671875,0.375,0.3828125,0.390625,0.3984375,0.40625,0.4140625,0.421875,0.4296875,0.4375,0.4453125,0.453125,0.4609375,0.46875,0.4765625,0.484375,0.4921875,-0.5,-0.4921875,-0.484375,-0.4765625,-0.46875,-0.4609375,-0.453125,-0.4453125,-0.4375,-0.4296875,-0.421875,-0.4140625,-0.40625,-0.3984375,-0.390625,-0.3828125,-0.375,-0.3671875,-0.359375,-0.3515625,-0.34375,-0.3359375,-0.328125,-0.3203125,-0.3125,-0.3046875,-0.296875,-0.2890625,-0.28125,-0.2734375,-0.265625,-0.2578125,-0.25,-0.2421875,-0.234375,-0.2265625,-0.21875,-0.2109375,-0.203125,-0.1953125,-0.1875,-0.1796875,-0.171875,-0.1640625,-0.15625,-0.1484375,-0.140625,-0.1328125,-0.125,-0.1171875,-0.109375,-0.1015625,-0.09375,-0.0859375,-0.078125,-0.0703125,-0.0625,-0.0546875,-0.046875,-0.0390625,-0.03125,-0.0234375,-0.015625,-0.0078125},"fftfreq/typed/bool/128/1: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/bool/128/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/bool/128/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/bool/128/1: result: dtype")
eq(spacing:tolist(),true,"fftfreq/typed/bool/128/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/128/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/128/1: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/128/1: spacing state: dtype")
cases=cases+1
end
-- 132: fftfreq/typed/bool/128/2
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/bool/128/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0078125,0.015625,0.0234375,0.03125,0.0390625,0.046875,0.0546875,0.0625,0.0703125,0.078125,0.0859375,0.09375,0.1015625,0.109375,0.1171875,0.125,0.1328125,0.140625,0.1484375,0.15625,0.1640625,0.171875,0.1796875,0.1875,0.1953125,0.203125,0.2109375,0.21875,0.2265625,0.234375,0.2421875,0.25,0.2578125,0.265625,0.2734375,0.28125,0.2890625,0.296875,0.3046875,0.3125,0.3203125,0.328125,0.3359375,0.34375,0.3515625,0.359375,0.3671875,0.375,0.3828125,0.390625,0.3984375,0.40625,0.4140625,0.421875,0.4296875,0.4375,0.4453125,0.453125,0.4609375,0.46875,0.4765625,0.484375,0.4921875,-0.5,-0.4921875,-0.484375,-0.4765625,-0.46875,-0.4609375,-0.453125,-0.4453125,-0.4375,-0.4296875,-0.421875,-0.4140625,-0.40625,-0.3984375,-0.390625,-0.3828125,-0.375,-0.3671875,-0.359375,-0.3515625,-0.34375,-0.3359375,-0.328125,-0.3203125,-0.3125,-0.3046875,-0.296875,-0.2890625,-0.28125,-0.2734375,-0.265625,-0.2578125,-0.25,-0.2421875,-0.234375,-0.2265625,-0.21875,-0.2109375,-0.203125,-0.1953125,-0.1875,-0.1796875,-0.171875,-0.1640625,-0.15625,-0.1484375,-0.140625,-0.1328125,-0.125,-0.1171875,-0.109375,-0.1015625,-0.09375,-0.0859375,-0.078125,-0.0703125,-0.0625,-0.0546875,-0.046875,-0.0390625,-0.03125,-0.0234375,-0.015625,-0.0078125},"fftfreq/typed/bool/128/2: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/bool/128/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/bool/128/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/bool/128/2: result: dtype")
eq(spacing:tolist(),true,"fftfreq/typed/bool/128/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/bool/128/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/bool/128/2: spacing state: strides")
eq(spacing.dtype,"bool","fftfreq/typed/bool/128/2: spacing state: dtype")
cases=cases+1
end
-- 133: fftfreq/typed/int8/-1/0
do
local spacing=np.array(0,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/int8/-1/0: acceptance"..": "..tostring(result))
eq(spacing:tolist(),0,"fftfreq/typed/int8/-1/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/-1/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/-1/0: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/-1/0: spacing state: dtype")
cases=cases+1
end
-- 134: fftfreq/typed/int8/-1/1
do
local spacing=np.array(1,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/int8/-1/1: acceptance"..": "..tostring(result))
eq(spacing:tolist(),1,"fftfreq/typed/int8/-1/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/-1/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/-1/1: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/-1/1: spacing state: dtype")
cases=cases+1
end
-- 135: fftfreq/typed/int8/-1/2
do
local spacing=np.array(2,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/int8/-1/2: acceptance"..": "..tostring(result))
eq(spacing:tolist(),2,"fftfreq/typed/int8/-1/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/-1/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/-1/2: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/-1/2: spacing state: dtype")
cases=cases+1
end
-- 136: fftfreq/typed/int8/0/0
do
local spacing=np.array(0,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/int8/0/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/int8/0/0: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/int8/0/0: result: shape")
eq(result.strides,{0},"fftfreq/typed/int8/0/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int8/0/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/int8/0/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/0/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/0/0: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/0/0: spacing state: dtype")
cases=cases+1
end
-- 137: fftfreq/typed/int8/0/1
do
local spacing=np.array(1,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/int8/0/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/int8/0/1: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/int8/0/1: result: shape")
eq(result.strides,{0},"fftfreq/typed/int8/0/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int8/0/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/int8/0/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/0/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/0/1: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/0/1: spacing state: dtype")
cases=cases+1
end
-- 138: fftfreq/typed/int8/0/2
do
local spacing=np.array(2,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/int8/0/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/int8/0/2: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/int8/0/2: result: shape")
eq(result.strides,{0},"fftfreq/typed/int8/0/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int8/0/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/int8/0/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/0/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/0/2: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/0/2: spacing state: dtype")
cases=cases+1
end
-- 139: fftfreq/typed/int8/1/0
do
local spacing=np.array(0,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/int8/1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"fftfreq/typed/int8/1/0: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/int8/1/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/int8/1/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int8/1/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/int8/1/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/1/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/1/0: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/1/0: spacing state: dtype")
cases=cases+1
end
-- 140: fftfreq/typed/int8/1/1
do
local spacing=np.array(1,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/int8/1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"fftfreq/typed/int8/1/1: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/int8/1/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/int8/1/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int8/1/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/int8/1/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/1/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/1/1: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/1/1: spacing state: dtype")
cases=cases+1
end
-- 141: fftfreq/typed/int8/1/2
do
local spacing=np.array(2,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/int8/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"fftfreq/typed/int8/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/int8/1/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/int8/1/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int8/1/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/int8/1/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/1/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/1/2: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/1/2: spacing state: dtype")
cases=cases+1
end
-- 142: fftfreq/typed/int8/3/0
do
local spacing=np.array(0,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/int8/3/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,-math.huge},"fftfreq/typed/int8/3/0: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/int8/3/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/int8/3/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int8/3/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/int8/3/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/3/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/3/0: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/3/0: spacing state: dtype")
cases=cases+1
end
-- 143: fftfreq/typed/int8/3/1
do
local spacing=np.array(1,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/int8/3/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.3333333333333333,-0.3333333333333333},"fftfreq/typed/int8/3/1: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/int8/3/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/int8/3/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int8/3/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/int8/3/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/3/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/3/1: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/3/1: spacing state: dtype")
cases=cases+1
end
-- 144: fftfreq/typed/int8/3/2
do
local spacing=np.array(2,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/int8/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.16666666666666666,-0.16666666666666666},"fftfreq/typed/int8/3/2: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/int8/3/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/int8/3/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int8/3/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/int8/3/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/3/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/3/2: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/3/2: spacing state: dtype")
cases=cases+1
end
-- 145: fftfreq/typed/int8/4/0
do
local spacing=np.array(0,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/int8/4/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,-math.huge,-math.huge},"fftfreq/typed/int8/4/0: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/int8/4/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/int8/4/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int8/4/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/int8/4/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/4/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/4/0: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/4/0: spacing state: dtype")
cases=cases+1
end
-- 146: fftfreq/typed/int8/4/1
do
local spacing=np.array(1,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/int8/4/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,-0.5,-0.25},"fftfreq/typed/int8/4/1: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/int8/4/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/int8/4/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int8/4/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/int8/4/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/4/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/4/1: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/4/1: spacing state: dtype")
cases=cases+1
end
-- 147: fftfreq/typed/int8/4/2
do
local spacing=np.array(2,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/int8/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.125,-0.25,-0.125},"fftfreq/typed/int8/4/2: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/int8/4/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/int8/4/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int8/4/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/int8/4/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/4/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/4/2: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/4/2: spacing state: dtype")
cases=cases+1
end
-- 148: fftfreq/typed/int8/15/0
do
local spacing=np.array(0,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/int8/15/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/int8/15/0: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/int8/15/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/int8/15/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int8/15/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/int8/15/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/15/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/15/0: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/15/0: spacing state: dtype")
cases=cases+1
end
-- 149: fftfreq/typed/int8/15/1
do
local spacing=np.array(1,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/int8/15/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.06666666666666667,0.13333333333333333,0.2,0.26666666666666666,0.3333333333333333,0.4,0.4666666666666667,-0.4666666666666667,-0.4,-0.3333333333333333,-0.26666666666666666,-0.2,-0.13333333333333333,-0.06666666666666667},"fftfreq/typed/int8/15/1: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/int8/15/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/int8/15/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int8/15/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/int8/15/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/15/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/15/1: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/15/1: spacing state: dtype")
cases=cases+1
end
-- 150: fftfreq/typed/int8/15/2
do
local spacing=np.array(2,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/int8/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.03333333333333333,0.06666666666666667,0.1,0.13333333333333333,0.16666666666666666,0.2,0.23333333333333334,-0.23333333333333334,-0.2,-0.16666666666666666,-0.13333333333333333,-0.1,-0.06666666666666667,-0.03333333333333333},"fftfreq/typed/int8/15/2: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/int8/15/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/int8/15/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int8/15/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/int8/15/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/15/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/15/2: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/15/2: spacing state: dtype")
cases=cases+1
end
-- 151: fftfreq/typed/int8/127/0
do
local spacing=np.array(0,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/int8/127/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/int8/127/0: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/int8/127/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/int8/127/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int8/127/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/int8/127/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/127/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/127/0: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/127/0: spacing state: dtype")
cases=cases+1
end
-- 152: fftfreq/typed/int8/127/1
do
local spacing=np.array(1,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/int8/127/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.007874015748031496,0.015748031496062992,0.023622047244094488,0.031496062992125984,0.03937007874015748,0.047244094488188976,0.05511811023622047,0.06299212598425197,0.07086614173228346,0.07874015748031496,0.08661417322834646,0.09448818897637795,0.10236220472440945,0.11023622047244094,0.11811023622047244,0.12598425196850394,0.13385826771653542,0.14173228346456693,0.14960629921259844,0.15748031496062992,0.1653543307086614,0.1732283464566929,0.18110236220472442,0.1889763779527559,0.19685039370078738,0.2047244094488189,0.2125984251968504,0.2204724409448819,0.22834645669291337,0.23622047244094488,0.2440944881889764,0.25196850393700787,0.25984251968503935,0.26771653543307083,0.2755905511811024,0.28346456692913385,0.29133858267716534,0.2992125984251969,0.30708661417322836,0.31496062992125984,0.3228346456692913,0.3307086614173228,0.33858267716535434,0.3464566929133858,0.3543307086614173,0.36220472440944884,0.3700787401574803,0.3779527559055118,0.3858267716535433,0.39370078740157477,0.4015748031496063,0.4094488188976378,0.41732283464566927,0.4251968503937008,0.4330708661417323,0.4409448818897638,0.44881889763779526,0.45669291338582674,0.4645669291338583,0.47244094488188976,0.48031496062992124,0.4881889763779528,0.49606299212598426,-0.49606299212598426,-0.4881889763779528,-0.48031496062992124,-0.47244094488188976,-0.4645669291338583,-0.45669291338582674,-0.44881889763779526,-0.4409448818897638,-0.4330708661417323,-0.4251968503937008,-0.41732283464566927,-0.4094488188976378,-0.4015748031496063,-0.39370078740157477,-0.3858267716535433,-0.3779527559055118,-0.3700787401574803,-0.36220472440944884,-0.3543307086614173,-0.3464566929133858,-0.33858267716535434,-0.3307086614173228,-0.3228346456692913,-0.31496062992125984,-0.30708661417322836,-0.2992125984251969,-0.29133858267716534,-0.28346456692913385,-0.2755905511811024,-0.26771653543307083,-0.25984251968503935,-0.25196850393700787,-0.2440944881889764,-0.23622047244094488,-0.22834645669291337,-0.2204724409448819,-0.2125984251968504,-0.2047244094488189,-0.19685039370078738,-0.1889763779527559,-0.18110236220472442,-0.1732283464566929,-0.1653543307086614,-0.15748031496062992,-0.14960629921259844,-0.14173228346456693,-0.13385826771653542,-0.12598425196850394,-0.11811023622047244,-0.11023622047244094,-0.10236220472440945,-0.09448818897637795,-0.08661417322834646,-0.07874015748031496,-0.07086614173228346,-0.06299212598425197,-0.05511811023622047,-0.047244094488188976,-0.03937007874015748,-0.031496062992125984,-0.023622047244094488,-0.015748031496062992,-0.007874015748031496},"fftfreq/typed/int8/127/1: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/int8/127/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/int8/127/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int8/127/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/int8/127/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/127/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/127/1: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/127/1: spacing state: dtype")
cases=cases+1
end
-- 153: fftfreq/typed/int8/127/2
do
local spacing=np.array(2,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/int8/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{-0.0,-0.5,-1.0,-1.5,-2.0,-2.5,-3.0,-3.5,-4.0,-4.5,-5.0,-5.5,-6.0,-6.5,-7.0,-7.5,-8.0,-8.5,-9.0,-9.5,-10.0,-10.5,-11.0,-11.5,-12.0,-12.5,-13.0,-13.5,-14.0,-14.5,-15.0,-15.5,-16.0,-16.5,-17.0,-17.5,-18.0,-18.5,-19.0,-19.5,-20.0,-20.5,-21.0,-21.5,-22.0,-22.5,-23.0,-23.5,-24.0,-24.5,-25.0,-25.5,-26.0,-26.5,-27.0,-27.5,-28.0,-28.5,-29.0,-29.5,-30.0,-30.5,-31.0,-31.5,31.5,31.0,30.5,30.0,29.5,29.0,28.5,28.0,27.5,27.0,26.5,26.0,25.5,25.0,24.5,24.0,23.5,23.0,22.5,22.0,21.5,21.0,20.5,20.0,19.5,19.0,18.5,18.0,17.5,17.0,16.5,16.0,15.5,15.0,14.5,14.0,13.5,13.0,12.5,12.0,11.5,11.0,10.5,10.0,9.5,9.0,8.5,8.0,7.5,7.0,6.5,6.0,5.5,5.0,4.5,4.0,3.5,3.0,2.5,2.0,1.5,1.0,0.5},"fftfreq/typed/int8/127/2: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/int8/127/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/int8/127/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int8/127/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/int8/127/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/127/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/127/2: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/127/2: spacing state: dtype")
cases=cases+1
end
-- 154: fftfreq/typed/int8/128/0
do
local spacing=np.array(0,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==false,"fftfreq/typed/int8/128/0: acceptance"..": "..tostring(result))
eq(spacing:tolist(),0,"fftfreq/typed/int8/128/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/128/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/128/0: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/128/0: spacing state: dtype")
cases=cases+1
end
-- 155: fftfreq/typed/int8/128/1
do
local spacing=np.array(1,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==false,"fftfreq/typed/int8/128/1: acceptance"..": "..tostring(result))
eq(spacing:tolist(),1,"fftfreq/typed/int8/128/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/128/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/128/1: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/128/1: spacing state: dtype")
cases=cases+1
end
-- 156: fftfreq/typed/int8/128/2
do
local spacing=np.array(2,"int8")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==false,"fftfreq/typed/int8/128/2: acceptance"..": "..tostring(result))
eq(spacing:tolist(),2,"fftfreq/typed/int8/128/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int8/128/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int8/128/2: spacing state: strides")
eq(spacing.dtype,"int8","fftfreq/typed/int8/128/2: spacing state: dtype")
cases=cases+1
end
-- 157: fftfreq/typed/uint8/-1/0
do
local spacing=np.array(0,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/uint8/-1/0: acceptance"..": "..tostring(result))
eq(spacing:tolist(),0,"fftfreq/typed/uint8/-1/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/-1/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/-1/0: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/-1/0: spacing state: dtype")
cases=cases+1
end
-- 158: fftfreq/typed/uint8/-1/1
do
local spacing=np.array(1,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/uint8/-1/1: acceptance"..": "..tostring(result))
eq(spacing:tolist(),1,"fftfreq/typed/uint8/-1/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/-1/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/-1/1: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/-1/1: spacing state: dtype")
cases=cases+1
end
-- 159: fftfreq/typed/uint8/-1/2
do
local spacing=np.array(2,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/uint8/-1/2: acceptance"..": "..tostring(result))
eq(spacing:tolist(),2,"fftfreq/typed/uint8/-1/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/-1/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/-1/2: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/-1/2: spacing state: dtype")
cases=cases+1
end
-- 160: fftfreq/typed/uint8/0/0
do
local spacing=np.array(0,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/uint8/0/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/uint8/0/0: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/uint8/0/0: result: shape")
eq(result.strides,{0},"fftfreq/typed/uint8/0/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint8/0/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/uint8/0/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/0/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/0/0: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/0/0: spacing state: dtype")
cases=cases+1
end
-- 161: fftfreq/typed/uint8/0/1
do
local spacing=np.array(1,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/uint8/0/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/uint8/0/1: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/uint8/0/1: result: shape")
eq(result.strides,{0},"fftfreq/typed/uint8/0/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint8/0/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/uint8/0/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/0/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/0/1: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/0/1: spacing state: dtype")
cases=cases+1
end
-- 162: fftfreq/typed/uint8/0/2
do
local spacing=np.array(2,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/uint8/0/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/uint8/0/2: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/uint8/0/2: result: shape")
eq(result.strides,{0},"fftfreq/typed/uint8/0/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint8/0/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/uint8/0/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/0/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/0/2: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/0/2: spacing state: dtype")
cases=cases+1
end
-- 163: fftfreq/typed/uint8/1/0
do
local spacing=np.array(0,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/uint8/1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"fftfreq/typed/uint8/1/0: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/uint8/1/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint8/1/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint8/1/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/uint8/1/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/1/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/1/0: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/1/0: spacing state: dtype")
cases=cases+1
end
-- 164: fftfreq/typed/uint8/1/1
do
local spacing=np.array(1,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/uint8/1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"fftfreq/typed/uint8/1/1: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/uint8/1/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint8/1/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint8/1/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/uint8/1/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/1/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/1/1: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/1/1: spacing state: dtype")
cases=cases+1
end
-- 165: fftfreq/typed/uint8/1/2
do
local spacing=np.array(2,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/uint8/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"fftfreq/typed/uint8/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/uint8/1/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint8/1/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint8/1/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/uint8/1/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/1/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/1/2: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/1/2: spacing state: dtype")
cases=cases+1
end
-- 166: fftfreq/typed/uint8/3/0
do
local spacing=np.array(0,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/uint8/3/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,-math.huge},"fftfreq/typed/uint8/3/0: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/uint8/3/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint8/3/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint8/3/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/uint8/3/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/3/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/3/0: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/3/0: spacing state: dtype")
cases=cases+1
end
-- 167: fftfreq/typed/uint8/3/1
do
local spacing=np.array(1,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/uint8/3/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.3333333333333333,-0.3333333333333333},"fftfreq/typed/uint8/3/1: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/uint8/3/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint8/3/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint8/3/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/uint8/3/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/3/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/3/1: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/3/1: spacing state: dtype")
cases=cases+1
end
-- 168: fftfreq/typed/uint8/3/2
do
local spacing=np.array(2,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/uint8/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.16666666666666666,-0.16666666666666666},"fftfreq/typed/uint8/3/2: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/uint8/3/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint8/3/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint8/3/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/uint8/3/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/3/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/3/2: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/3/2: spacing state: dtype")
cases=cases+1
end
-- 169: fftfreq/typed/uint8/4/0
do
local spacing=np.array(0,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/uint8/4/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,-math.huge,-math.huge},"fftfreq/typed/uint8/4/0: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/uint8/4/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint8/4/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint8/4/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/uint8/4/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/4/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/4/0: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/4/0: spacing state: dtype")
cases=cases+1
end
-- 170: fftfreq/typed/uint8/4/1
do
local spacing=np.array(1,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/uint8/4/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,-0.5,-0.25},"fftfreq/typed/uint8/4/1: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/uint8/4/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint8/4/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint8/4/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/uint8/4/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/4/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/4/1: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/4/1: spacing state: dtype")
cases=cases+1
end
-- 171: fftfreq/typed/uint8/4/2
do
local spacing=np.array(2,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/uint8/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.125,-0.25,-0.125},"fftfreq/typed/uint8/4/2: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/uint8/4/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint8/4/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint8/4/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/uint8/4/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/4/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/4/2: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/4/2: spacing state: dtype")
cases=cases+1
end
-- 172: fftfreq/typed/uint8/15/0
do
local spacing=np.array(0,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/uint8/15/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/uint8/15/0: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/uint8/15/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint8/15/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint8/15/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/uint8/15/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/15/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/15/0: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/15/0: spacing state: dtype")
cases=cases+1
end
-- 173: fftfreq/typed/uint8/15/1
do
local spacing=np.array(1,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/uint8/15/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.06666666666666667,0.13333333333333333,0.2,0.26666666666666666,0.3333333333333333,0.4,0.4666666666666667,-0.4666666666666667,-0.4,-0.3333333333333333,-0.26666666666666666,-0.2,-0.13333333333333333,-0.06666666666666667},"fftfreq/typed/uint8/15/1: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/uint8/15/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint8/15/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint8/15/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/uint8/15/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/15/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/15/1: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/15/1: spacing state: dtype")
cases=cases+1
end
-- 174: fftfreq/typed/uint8/15/2
do
local spacing=np.array(2,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/uint8/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.03333333333333333,0.06666666666666667,0.1,0.13333333333333333,0.16666666666666666,0.2,0.23333333333333334,-0.23333333333333334,-0.2,-0.16666666666666666,-0.13333333333333333,-0.1,-0.06666666666666667,-0.03333333333333333},"fftfreq/typed/uint8/15/2: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/uint8/15/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint8/15/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint8/15/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/uint8/15/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/15/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/15/2: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/15/2: spacing state: dtype")
cases=cases+1
end
-- 175: fftfreq/typed/uint8/127/0
do
local spacing=np.array(0,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/uint8/127/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/uint8/127/0: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/uint8/127/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint8/127/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint8/127/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/uint8/127/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/127/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/127/0: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/127/0: spacing state: dtype")
cases=cases+1
end
-- 176: fftfreq/typed/uint8/127/1
do
local spacing=np.array(1,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/uint8/127/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.007874015748031496,0.015748031496062992,0.023622047244094488,0.031496062992125984,0.03937007874015748,0.047244094488188976,0.05511811023622047,0.06299212598425197,0.07086614173228346,0.07874015748031496,0.08661417322834646,0.09448818897637795,0.10236220472440945,0.11023622047244094,0.11811023622047244,0.12598425196850394,0.13385826771653542,0.14173228346456693,0.14960629921259844,0.15748031496062992,0.1653543307086614,0.1732283464566929,0.18110236220472442,0.1889763779527559,0.19685039370078738,0.2047244094488189,0.2125984251968504,0.2204724409448819,0.22834645669291337,0.23622047244094488,0.2440944881889764,0.25196850393700787,0.25984251968503935,0.26771653543307083,0.2755905511811024,0.28346456692913385,0.29133858267716534,0.2992125984251969,0.30708661417322836,0.31496062992125984,0.3228346456692913,0.3307086614173228,0.33858267716535434,0.3464566929133858,0.3543307086614173,0.36220472440944884,0.3700787401574803,0.3779527559055118,0.3858267716535433,0.39370078740157477,0.4015748031496063,0.4094488188976378,0.41732283464566927,0.4251968503937008,0.4330708661417323,0.4409448818897638,0.44881889763779526,0.45669291338582674,0.4645669291338583,0.47244094488188976,0.48031496062992124,0.4881889763779528,0.49606299212598426,-0.49606299212598426,-0.4881889763779528,-0.48031496062992124,-0.47244094488188976,-0.4645669291338583,-0.45669291338582674,-0.44881889763779526,-0.4409448818897638,-0.4330708661417323,-0.4251968503937008,-0.41732283464566927,-0.4094488188976378,-0.4015748031496063,-0.39370078740157477,-0.3858267716535433,-0.3779527559055118,-0.3700787401574803,-0.36220472440944884,-0.3543307086614173,-0.3464566929133858,-0.33858267716535434,-0.3307086614173228,-0.3228346456692913,-0.31496062992125984,-0.30708661417322836,-0.2992125984251969,-0.29133858267716534,-0.28346456692913385,-0.2755905511811024,-0.26771653543307083,-0.25984251968503935,-0.25196850393700787,-0.2440944881889764,-0.23622047244094488,-0.22834645669291337,-0.2204724409448819,-0.2125984251968504,-0.2047244094488189,-0.19685039370078738,-0.1889763779527559,-0.18110236220472442,-0.1732283464566929,-0.1653543307086614,-0.15748031496062992,-0.14960629921259844,-0.14173228346456693,-0.13385826771653542,-0.12598425196850394,-0.11811023622047244,-0.11023622047244094,-0.10236220472440945,-0.09448818897637795,-0.08661417322834646,-0.07874015748031496,-0.07086614173228346,-0.06299212598425197,-0.05511811023622047,-0.047244094488188976,-0.03937007874015748,-0.031496062992125984,-0.023622047244094488,-0.015748031496062992,-0.007874015748031496},"fftfreq/typed/uint8/127/1: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/uint8/127/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint8/127/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint8/127/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/uint8/127/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/127/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/127/1: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/127/1: spacing state: dtype")
cases=cases+1
end
-- 177: fftfreq/typed/uint8/127/2
do
local spacing=np.array(2,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/uint8/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.003937007874015748,0.007874015748031496,0.011811023622047244,0.015748031496062992,0.01968503937007874,0.023622047244094488,0.027559055118110236,0.031496062992125984,0.03543307086614173,0.03937007874015748,0.04330708661417323,0.047244094488188976,0.051181102362204724,0.05511811023622047,0.05905511811023622,0.06299212598425197,0.06692913385826771,0.07086614173228346,0.07480314960629922,0.07874015748031496,0.0826771653543307,0.08661417322834646,0.09055118110236221,0.09448818897637795,0.09842519685039369,0.10236220472440945,0.1062992125984252,0.11023622047244094,0.11417322834645668,0.11811023622047244,0.1220472440944882,0.12598425196850394,0.12992125984251968,0.13385826771653542,0.1377952755905512,0.14173228346456693,0.14566929133858267,0.14960629921259844,0.15354330708661418,0.15748031496062992,0.16141732283464566,0.1653543307086614,0.16929133858267717,0.1732283464566929,0.17716535433070865,0.18110236220472442,0.18503937007874016,0.1889763779527559,0.19291338582677164,0.19685039370078738,0.20078740157480315,0.2047244094488189,0.20866141732283464,0.2125984251968504,0.21653543307086615,0.2204724409448819,0.22440944881889763,0.22834645669291337,0.23228346456692914,0.23622047244094488,0.24015748031496062,0.2440944881889764,0.24803149606299213,-0.24803149606299213,-0.2440944881889764,-0.24015748031496062,-0.23622047244094488,-0.23228346456692914,-0.22834645669291337,-0.22440944881889763,-0.2204724409448819,-0.21653543307086615,-0.2125984251968504,-0.20866141732283464,-0.2047244094488189,-0.20078740157480315,-0.19685039370078738,-0.19291338582677164,-0.1889763779527559,-0.18503937007874016,-0.18110236220472442,-0.17716535433070865,-0.1732283464566929,-0.16929133858267717,-0.1653543307086614,-0.16141732283464566,-0.15748031496062992,-0.15354330708661418,-0.14960629921259844,-0.14566929133858267,-0.14173228346456693,-0.1377952755905512,-0.13385826771653542,-0.12992125984251968,-0.12598425196850394,-0.1220472440944882,-0.11811023622047244,-0.11417322834645668,-0.11023622047244094,-0.1062992125984252,-0.10236220472440945,-0.09842519685039369,-0.09448818897637795,-0.09055118110236221,-0.08661417322834646,-0.0826771653543307,-0.07874015748031496,-0.07480314960629922,-0.07086614173228346,-0.06692913385826771,-0.06299212598425197,-0.05905511811023622,-0.05511811023622047,-0.051181102362204724,-0.047244094488188976,-0.04330708661417323,-0.03937007874015748,-0.03543307086614173,-0.031496062992125984,-0.027559055118110236,-0.023622047244094488,-0.01968503937007874,-0.015748031496062992,-0.011811023622047244,-0.007874015748031496,-0.003937007874015748},"fftfreq/typed/uint8/127/2: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/uint8/127/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint8/127/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint8/127/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/uint8/127/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/127/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/127/2: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/127/2: spacing state: dtype")
cases=cases+1
end
-- 178: fftfreq/typed/uint8/128/0
do
local spacing=np.array(0,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/uint8/128/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/uint8/128/0: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/uint8/128/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint8/128/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint8/128/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/uint8/128/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/128/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/128/0: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/128/0: spacing state: dtype")
cases=cases+1
end
-- 179: fftfreq/typed/uint8/128/1
do
local spacing=np.array(1,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/uint8/128/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0078125,0.015625,0.0234375,0.03125,0.0390625,0.046875,0.0546875,0.0625,0.0703125,0.078125,0.0859375,0.09375,0.1015625,0.109375,0.1171875,0.125,0.1328125,0.140625,0.1484375,0.15625,0.1640625,0.171875,0.1796875,0.1875,0.1953125,0.203125,0.2109375,0.21875,0.2265625,0.234375,0.2421875,0.25,0.2578125,0.265625,0.2734375,0.28125,0.2890625,0.296875,0.3046875,0.3125,0.3203125,0.328125,0.3359375,0.34375,0.3515625,0.359375,0.3671875,0.375,0.3828125,0.390625,0.3984375,0.40625,0.4140625,0.421875,0.4296875,0.4375,0.4453125,0.453125,0.4609375,0.46875,0.4765625,0.484375,0.4921875,-0.5,-0.4921875,-0.484375,-0.4765625,-0.46875,-0.4609375,-0.453125,-0.4453125,-0.4375,-0.4296875,-0.421875,-0.4140625,-0.40625,-0.3984375,-0.390625,-0.3828125,-0.375,-0.3671875,-0.359375,-0.3515625,-0.34375,-0.3359375,-0.328125,-0.3203125,-0.3125,-0.3046875,-0.296875,-0.2890625,-0.28125,-0.2734375,-0.265625,-0.2578125,-0.25,-0.2421875,-0.234375,-0.2265625,-0.21875,-0.2109375,-0.203125,-0.1953125,-0.1875,-0.1796875,-0.171875,-0.1640625,-0.15625,-0.1484375,-0.140625,-0.1328125,-0.125,-0.1171875,-0.109375,-0.1015625,-0.09375,-0.0859375,-0.078125,-0.0703125,-0.0625,-0.0546875,-0.046875,-0.0390625,-0.03125,-0.0234375,-0.015625,-0.0078125},"fftfreq/typed/uint8/128/1: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/uint8/128/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint8/128/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint8/128/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/uint8/128/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/128/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/128/1: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/128/1: spacing state: dtype")
cases=cases+1
end
-- 180: fftfreq/typed/uint8/128/2
do
local spacing=np.array(2,"uint8")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/uint8/128/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/uint8/128/2: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/uint8/128/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint8/128/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint8/128/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/uint8/128/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint8/128/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint8/128/2: spacing state: strides")
eq(spacing.dtype,"uint8","fftfreq/typed/uint8/128/2: spacing state: dtype")
cases=cases+1
end
-- 181: fftfreq/typed/int32/-1/0
do
local spacing=np.array(0,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/int32/-1/0: acceptance"..": "..tostring(result))
eq(spacing:tolist(),0,"fftfreq/typed/int32/-1/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/-1/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/-1/0: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/-1/0: spacing state: dtype")
cases=cases+1
end
-- 182: fftfreq/typed/int32/-1/1
do
local spacing=np.array(1,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/int32/-1/1: acceptance"..": "..tostring(result))
eq(spacing:tolist(),1,"fftfreq/typed/int32/-1/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/-1/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/-1/1: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/-1/1: spacing state: dtype")
cases=cases+1
end
-- 183: fftfreq/typed/int32/-1/2
do
local spacing=np.array(2,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/int32/-1/2: acceptance"..": "..tostring(result))
eq(spacing:tolist(),2,"fftfreq/typed/int32/-1/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/-1/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/-1/2: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/-1/2: spacing state: dtype")
cases=cases+1
end
-- 184: fftfreq/typed/int32/0/0
do
local spacing=np.array(0,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/int32/0/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/int32/0/0: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/int32/0/0: result: shape")
eq(result.strides,{0},"fftfreq/typed/int32/0/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int32/0/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/int32/0/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/0/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/0/0: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/0/0: spacing state: dtype")
cases=cases+1
end
-- 185: fftfreq/typed/int32/0/1
do
local spacing=np.array(1,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/int32/0/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/int32/0/1: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/int32/0/1: result: shape")
eq(result.strides,{0},"fftfreq/typed/int32/0/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int32/0/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/int32/0/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/0/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/0/1: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/0/1: spacing state: dtype")
cases=cases+1
end
-- 186: fftfreq/typed/int32/0/2
do
local spacing=np.array(2,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/int32/0/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/int32/0/2: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/int32/0/2: result: shape")
eq(result.strides,{0},"fftfreq/typed/int32/0/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int32/0/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/int32/0/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/0/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/0/2: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/0/2: spacing state: dtype")
cases=cases+1
end
-- 187: fftfreq/typed/int32/1/0
do
local spacing=np.array(0,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/int32/1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"fftfreq/typed/int32/1/0: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/int32/1/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/int32/1/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int32/1/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/int32/1/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/1/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/1/0: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/1/0: spacing state: dtype")
cases=cases+1
end
-- 188: fftfreq/typed/int32/1/1
do
local spacing=np.array(1,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/int32/1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"fftfreq/typed/int32/1/1: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/int32/1/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/int32/1/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int32/1/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/int32/1/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/1/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/1/1: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/1/1: spacing state: dtype")
cases=cases+1
end
-- 189: fftfreq/typed/int32/1/2
do
local spacing=np.array(2,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/int32/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"fftfreq/typed/int32/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/int32/1/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/int32/1/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int32/1/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/int32/1/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/1/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/1/2: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/1/2: spacing state: dtype")
cases=cases+1
end
-- 190: fftfreq/typed/int32/3/0
do
local spacing=np.array(0,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/int32/3/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,-math.huge},"fftfreq/typed/int32/3/0: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/int32/3/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/int32/3/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int32/3/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/int32/3/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/3/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/3/0: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/3/0: spacing state: dtype")
cases=cases+1
end
-- 191: fftfreq/typed/int32/3/1
do
local spacing=np.array(1,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/int32/3/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.3333333333333333,-0.3333333333333333},"fftfreq/typed/int32/3/1: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/int32/3/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/int32/3/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int32/3/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/int32/3/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/3/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/3/1: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/3/1: spacing state: dtype")
cases=cases+1
end
-- 192: fftfreq/typed/int32/3/2
do
local spacing=np.array(2,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/int32/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.16666666666666666,-0.16666666666666666},"fftfreq/typed/int32/3/2: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/int32/3/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/int32/3/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int32/3/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/int32/3/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/3/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/3/2: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/3/2: spacing state: dtype")
cases=cases+1
end
-- 193: fftfreq/typed/int32/4/0
do
local spacing=np.array(0,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/int32/4/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,-math.huge,-math.huge},"fftfreq/typed/int32/4/0: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/int32/4/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/int32/4/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int32/4/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/int32/4/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/4/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/4/0: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/4/0: spacing state: dtype")
cases=cases+1
end
-- 194: fftfreq/typed/int32/4/1
do
local spacing=np.array(1,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/int32/4/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,-0.5,-0.25},"fftfreq/typed/int32/4/1: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/int32/4/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/int32/4/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int32/4/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/int32/4/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/4/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/4/1: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/4/1: spacing state: dtype")
cases=cases+1
end
-- 195: fftfreq/typed/int32/4/2
do
local spacing=np.array(2,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/int32/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.125,-0.25,-0.125},"fftfreq/typed/int32/4/2: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/int32/4/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/int32/4/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int32/4/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/int32/4/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/4/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/4/2: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/4/2: spacing state: dtype")
cases=cases+1
end
-- 196: fftfreq/typed/int32/15/0
do
local spacing=np.array(0,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/int32/15/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/int32/15/0: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/int32/15/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/int32/15/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int32/15/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/int32/15/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/15/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/15/0: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/15/0: spacing state: dtype")
cases=cases+1
end
-- 197: fftfreq/typed/int32/15/1
do
local spacing=np.array(1,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/int32/15/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.06666666666666667,0.13333333333333333,0.2,0.26666666666666666,0.3333333333333333,0.4,0.4666666666666667,-0.4666666666666667,-0.4,-0.3333333333333333,-0.26666666666666666,-0.2,-0.13333333333333333,-0.06666666666666667},"fftfreq/typed/int32/15/1: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/int32/15/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/int32/15/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int32/15/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/int32/15/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/15/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/15/1: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/15/1: spacing state: dtype")
cases=cases+1
end
-- 198: fftfreq/typed/int32/15/2
do
local spacing=np.array(2,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/int32/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.03333333333333333,0.06666666666666667,0.1,0.13333333333333333,0.16666666666666666,0.2,0.23333333333333334,-0.23333333333333334,-0.2,-0.16666666666666666,-0.13333333333333333,-0.1,-0.06666666666666667,-0.03333333333333333},"fftfreq/typed/int32/15/2: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/int32/15/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/int32/15/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int32/15/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/int32/15/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/15/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/15/2: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/15/2: spacing state: dtype")
cases=cases+1
end
-- 199: fftfreq/typed/int32/127/0
do
local spacing=np.array(0,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/int32/127/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/int32/127/0: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/int32/127/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/int32/127/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int32/127/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/int32/127/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/127/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/127/0: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/127/0: spacing state: dtype")
cases=cases+1
end
-- 200: fftfreq/typed/int32/127/1
do
local spacing=np.array(1,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/int32/127/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.007874015748031496,0.015748031496062992,0.023622047244094488,0.031496062992125984,0.03937007874015748,0.047244094488188976,0.05511811023622047,0.06299212598425197,0.07086614173228346,0.07874015748031496,0.08661417322834646,0.09448818897637795,0.10236220472440945,0.11023622047244094,0.11811023622047244,0.12598425196850394,0.13385826771653542,0.14173228346456693,0.14960629921259844,0.15748031496062992,0.1653543307086614,0.1732283464566929,0.18110236220472442,0.1889763779527559,0.19685039370078738,0.2047244094488189,0.2125984251968504,0.2204724409448819,0.22834645669291337,0.23622047244094488,0.2440944881889764,0.25196850393700787,0.25984251968503935,0.26771653543307083,0.2755905511811024,0.28346456692913385,0.29133858267716534,0.2992125984251969,0.30708661417322836,0.31496062992125984,0.3228346456692913,0.3307086614173228,0.33858267716535434,0.3464566929133858,0.3543307086614173,0.36220472440944884,0.3700787401574803,0.3779527559055118,0.3858267716535433,0.39370078740157477,0.4015748031496063,0.4094488188976378,0.41732283464566927,0.4251968503937008,0.4330708661417323,0.4409448818897638,0.44881889763779526,0.45669291338582674,0.4645669291338583,0.47244094488188976,0.48031496062992124,0.4881889763779528,0.49606299212598426,-0.49606299212598426,-0.4881889763779528,-0.48031496062992124,-0.47244094488188976,-0.4645669291338583,-0.45669291338582674,-0.44881889763779526,-0.4409448818897638,-0.4330708661417323,-0.4251968503937008,-0.41732283464566927,-0.4094488188976378,-0.4015748031496063,-0.39370078740157477,-0.3858267716535433,-0.3779527559055118,-0.3700787401574803,-0.36220472440944884,-0.3543307086614173,-0.3464566929133858,-0.33858267716535434,-0.3307086614173228,-0.3228346456692913,-0.31496062992125984,-0.30708661417322836,-0.2992125984251969,-0.29133858267716534,-0.28346456692913385,-0.2755905511811024,-0.26771653543307083,-0.25984251968503935,-0.25196850393700787,-0.2440944881889764,-0.23622047244094488,-0.22834645669291337,-0.2204724409448819,-0.2125984251968504,-0.2047244094488189,-0.19685039370078738,-0.1889763779527559,-0.18110236220472442,-0.1732283464566929,-0.1653543307086614,-0.15748031496062992,-0.14960629921259844,-0.14173228346456693,-0.13385826771653542,-0.12598425196850394,-0.11811023622047244,-0.11023622047244094,-0.10236220472440945,-0.09448818897637795,-0.08661417322834646,-0.07874015748031496,-0.07086614173228346,-0.06299212598425197,-0.05511811023622047,-0.047244094488188976,-0.03937007874015748,-0.031496062992125984,-0.023622047244094488,-0.015748031496062992,-0.007874015748031496},"fftfreq/typed/int32/127/1: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/int32/127/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/int32/127/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int32/127/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/int32/127/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/127/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/127/1: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/127/1: spacing state: dtype")
cases=cases+1
end
-- 201: fftfreq/typed/int32/127/2
do
local spacing=np.array(2,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/int32/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.003937007874015748,0.007874015748031496,0.011811023622047244,0.015748031496062992,0.01968503937007874,0.023622047244094488,0.027559055118110236,0.031496062992125984,0.03543307086614173,0.03937007874015748,0.04330708661417323,0.047244094488188976,0.051181102362204724,0.05511811023622047,0.05905511811023622,0.06299212598425197,0.06692913385826771,0.07086614173228346,0.07480314960629922,0.07874015748031496,0.0826771653543307,0.08661417322834646,0.09055118110236221,0.09448818897637795,0.09842519685039369,0.10236220472440945,0.1062992125984252,0.11023622047244094,0.11417322834645668,0.11811023622047244,0.1220472440944882,0.12598425196850394,0.12992125984251968,0.13385826771653542,0.1377952755905512,0.14173228346456693,0.14566929133858267,0.14960629921259844,0.15354330708661418,0.15748031496062992,0.16141732283464566,0.1653543307086614,0.16929133858267717,0.1732283464566929,0.17716535433070865,0.18110236220472442,0.18503937007874016,0.1889763779527559,0.19291338582677164,0.19685039370078738,0.20078740157480315,0.2047244094488189,0.20866141732283464,0.2125984251968504,0.21653543307086615,0.2204724409448819,0.22440944881889763,0.22834645669291337,0.23228346456692914,0.23622047244094488,0.24015748031496062,0.2440944881889764,0.24803149606299213,-0.24803149606299213,-0.2440944881889764,-0.24015748031496062,-0.23622047244094488,-0.23228346456692914,-0.22834645669291337,-0.22440944881889763,-0.2204724409448819,-0.21653543307086615,-0.2125984251968504,-0.20866141732283464,-0.2047244094488189,-0.20078740157480315,-0.19685039370078738,-0.19291338582677164,-0.1889763779527559,-0.18503937007874016,-0.18110236220472442,-0.17716535433070865,-0.1732283464566929,-0.16929133858267717,-0.1653543307086614,-0.16141732283464566,-0.15748031496062992,-0.15354330708661418,-0.14960629921259844,-0.14566929133858267,-0.14173228346456693,-0.1377952755905512,-0.13385826771653542,-0.12992125984251968,-0.12598425196850394,-0.1220472440944882,-0.11811023622047244,-0.11417322834645668,-0.11023622047244094,-0.1062992125984252,-0.10236220472440945,-0.09842519685039369,-0.09448818897637795,-0.09055118110236221,-0.08661417322834646,-0.0826771653543307,-0.07874015748031496,-0.07480314960629922,-0.07086614173228346,-0.06692913385826771,-0.06299212598425197,-0.05905511811023622,-0.05511811023622047,-0.051181102362204724,-0.047244094488188976,-0.04330708661417323,-0.03937007874015748,-0.03543307086614173,-0.031496062992125984,-0.027559055118110236,-0.023622047244094488,-0.01968503937007874,-0.015748031496062992,-0.011811023622047244,-0.007874015748031496,-0.003937007874015748},"fftfreq/typed/int32/127/2: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/int32/127/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/int32/127/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int32/127/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/int32/127/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/127/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/127/2: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/127/2: spacing state: dtype")
cases=cases+1
end
-- 202: fftfreq/typed/int32/128/0
do
local spacing=np.array(0,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/int32/128/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/int32/128/0: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/int32/128/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/int32/128/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int32/128/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/int32/128/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/128/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/128/0: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/128/0: spacing state: dtype")
cases=cases+1
end
-- 203: fftfreq/typed/int32/128/1
do
local spacing=np.array(1,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/int32/128/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0078125,0.015625,0.0234375,0.03125,0.0390625,0.046875,0.0546875,0.0625,0.0703125,0.078125,0.0859375,0.09375,0.1015625,0.109375,0.1171875,0.125,0.1328125,0.140625,0.1484375,0.15625,0.1640625,0.171875,0.1796875,0.1875,0.1953125,0.203125,0.2109375,0.21875,0.2265625,0.234375,0.2421875,0.25,0.2578125,0.265625,0.2734375,0.28125,0.2890625,0.296875,0.3046875,0.3125,0.3203125,0.328125,0.3359375,0.34375,0.3515625,0.359375,0.3671875,0.375,0.3828125,0.390625,0.3984375,0.40625,0.4140625,0.421875,0.4296875,0.4375,0.4453125,0.453125,0.4609375,0.46875,0.4765625,0.484375,0.4921875,-0.5,-0.4921875,-0.484375,-0.4765625,-0.46875,-0.4609375,-0.453125,-0.4453125,-0.4375,-0.4296875,-0.421875,-0.4140625,-0.40625,-0.3984375,-0.390625,-0.3828125,-0.375,-0.3671875,-0.359375,-0.3515625,-0.34375,-0.3359375,-0.328125,-0.3203125,-0.3125,-0.3046875,-0.296875,-0.2890625,-0.28125,-0.2734375,-0.265625,-0.2578125,-0.25,-0.2421875,-0.234375,-0.2265625,-0.21875,-0.2109375,-0.203125,-0.1953125,-0.1875,-0.1796875,-0.171875,-0.1640625,-0.15625,-0.1484375,-0.140625,-0.1328125,-0.125,-0.1171875,-0.109375,-0.1015625,-0.09375,-0.0859375,-0.078125,-0.0703125,-0.0625,-0.0546875,-0.046875,-0.0390625,-0.03125,-0.0234375,-0.015625,-0.0078125},"fftfreq/typed/int32/128/1: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/int32/128/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/int32/128/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int32/128/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/int32/128/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/128/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/128/1: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/128/1: spacing state: dtype")
cases=cases+1
end
-- 204: fftfreq/typed/int32/128/2
do
local spacing=np.array(2,"int32")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/int32/128/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.00390625,0.0078125,0.01171875,0.015625,0.01953125,0.0234375,0.02734375,0.03125,0.03515625,0.0390625,0.04296875,0.046875,0.05078125,0.0546875,0.05859375,0.0625,0.06640625,0.0703125,0.07421875,0.078125,0.08203125,0.0859375,0.08984375,0.09375,0.09765625,0.1015625,0.10546875,0.109375,0.11328125,0.1171875,0.12109375,0.125,0.12890625,0.1328125,0.13671875,0.140625,0.14453125,0.1484375,0.15234375,0.15625,0.16015625,0.1640625,0.16796875,0.171875,0.17578125,0.1796875,0.18359375,0.1875,0.19140625,0.1953125,0.19921875,0.203125,0.20703125,0.2109375,0.21484375,0.21875,0.22265625,0.2265625,0.23046875,0.234375,0.23828125,0.2421875,0.24609375,-0.25,-0.24609375,-0.2421875,-0.23828125,-0.234375,-0.23046875,-0.2265625,-0.22265625,-0.21875,-0.21484375,-0.2109375,-0.20703125,-0.203125,-0.19921875,-0.1953125,-0.19140625,-0.1875,-0.18359375,-0.1796875,-0.17578125,-0.171875,-0.16796875,-0.1640625,-0.16015625,-0.15625,-0.15234375,-0.1484375,-0.14453125,-0.140625,-0.13671875,-0.1328125,-0.12890625,-0.125,-0.12109375,-0.1171875,-0.11328125,-0.109375,-0.10546875,-0.1015625,-0.09765625,-0.09375,-0.08984375,-0.0859375,-0.08203125,-0.078125,-0.07421875,-0.0703125,-0.06640625,-0.0625,-0.05859375,-0.0546875,-0.05078125,-0.046875,-0.04296875,-0.0390625,-0.03515625,-0.03125,-0.02734375,-0.0234375,-0.01953125,-0.015625,-0.01171875,-0.0078125,-0.00390625},"fftfreq/typed/int32/128/2: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/int32/128/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/int32/128/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int32/128/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/int32/128/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int32/128/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int32/128/2: spacing state: strides")
eq(spacing.dtype,"int32","fftfreq/typed/int32/128/2: spacing state: dtype")
cases=cases+1
end
-- 205: fftfreq/typed/int64/-1/0
do
local spacing=np.array(0,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/int64/-1/0: acceptance"..": "..tostring(result))
eq(spacing:tolist(),0,"fftfreq/typed/int64/-1/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/-1/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/-1/0: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/-1/0: spacing state: dtype")
cases=cases+1
end
-- 206: fftfreq/typed/int64/-1/1
do
local spacing=np.array(1,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/int64/-1/1: acceptance"..": "..tostring(result))
eq(spacing:tolist(),1,"fftfreq/typed/int64/-1/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/-1/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/-1/1: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/-1/1: spacing state: dtype")
cases=cases+1
end
-- 207: fftfreq/typed/int64/-1/2
do
local spacing=np.array(2,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/int64/-1/2: acceptance"..": "..tostring(result))
eq(spacing:tolist(),2,"fftfreq/typed/int64/-1/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/-1/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/-1/2: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/-1/2: spacing state: dtype")
cases=cases+1
end
-- 208: fftfreq/typed/int64/0/0
do
local spacing=np.array(0,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/int64/0/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/int64/0/0: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/int64/0/0: result: shape")
eq(result.strides,{0},"fftfreq/typed/int64/0/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int64/0/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/int64/0/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/0/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/0/0: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/0/0: spacing state: dtype")
cases=cases+1
end
-- 209: fftfreq/typed/int64/0/1
do
local spacing=np.array(1,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/int64/0/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/int64/0/1: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/int64/0/1: result: shape")
eq(result.strides,{0},"fftfreq/typed/int64/0/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int64/0/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/int64/0/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/0/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/0/1: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/0/1: spacing state: dtype")
cases=cases+1
end
-- 210: fftfreq/typed/int64/0/2
do
local spacing=np.array(2,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/int64/0/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/int64/0/2: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/int64/0/2: result: shape")
eq(result.strides,{0},"fftfreq/typed/int64/0/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int64/0/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/int64/0/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/0/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/0/2: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/0/2: spacing state: dtype")
cases=cases+1
end
-- 211: fftfreq/typed/int64/1/0
do
local spacing=np.array(0,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/int64/1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"fftfreq/typed/int64/1/0: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/int64/1/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/int64/1/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int64/1/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/int64/1/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/1/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/1/0: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/1/0: spacing state: dtype")
cases=cases+1
end
-- 212: fftfreq/typed/int64/1/1
do
local spacing=np.array(1,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/int64/1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"fftfreq/typed/int64/1/1: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/int64/1/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/int64/1/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int64/1/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/int64/1/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/1/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/1/1: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/1/1: spacing state: dtype")
cases=cases+1
end
-- 213: fftfreq/typed/int64/1/2
do
local spacing=np.array(2,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/int64/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"fftfreq/typed/int64/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/int64/1/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/int64/1/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int64/1/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/int64/1/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/1/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/1/2: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/1/2: spacing state: dtype")
cases=cases+1
end
-- 214: fftfreq/typed/int64/3/0
do
local spacing=np.array(0,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/int64/3/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,-math.huge},"fftfreq/typed/int64/3/0: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/int64/3/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/int64/3/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int64/3/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/int64/3/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/3/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/3/0: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/3/0: spacing state: dtype")
cases=cases+1
end
-- 215: fftfreq/typed/int64/3/1
do
local spacing=np.array(1,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/int64/3/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.3333333333333333,-0.3333333333333333},"fftfreq/typed/int64/3/1: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/int64/3/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/int64/3/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int64/3/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/int64/3/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/3/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/3/1: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/3/1: spacing state: dtype")
cases=cases+1
end
-- 216: fftfreq/typed/int64/3/2
do
local spacing=np.array(2,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/int64/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.16666666666666666,-0.16666666666666666},"fftfreq/typed/int64/3/2: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/int64/3/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/int64/3/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int64/3/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/int64/3/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/3/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/3/2: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/3/2: spacing state: dtype")
cases=cases+1
end
-- 217: fftfreq/typed/int64/4/0
do
local spacing=np.array(0,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/int64/4/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,-math.huge,-math.huge},"fftfreq/typed/int64/4/0: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/int64/4/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/int64/4/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int64/4/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/int64/4/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/4/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/4/0: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/4/0: spacing state: dtype")
cases=cases+1
end
-- 218: fftfreq/typed/int64/4/1
do
local spacing=np.array(1,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/int64/4/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,-0.5,-0.25},"fftfreq/typed/int64/4/1: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/int64/4/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/int64/4/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int64/4/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/int64/4/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/4/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/4/1: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/4/1: spacing state: dtype")
cases=cases+1
end
-- 219: fftfreq/typed/int64/4/2
do
local spacing=np.array(2,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/int64/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.125,-0.25,-0.125},"fftfreq/typed/int64/4/2: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/int64/4/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/int64/4/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int64/4/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/int64/4/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/4/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/4/2: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/4/2: spacing state: dtype")
cases=cases+1
end
-- 220: fftfreq/typed/int64/15/0
do
local spacing=np.array(0,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/int64/15/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/int64/15/0: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/int64/15/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/int64/15/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int64/15/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/int64/15/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/15/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/15/0: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/15/0: spacing state: dtype")
cases=cases+1
end
-- 221: fftfreq/typed/int64/15/1
do
local spacing=np.array(1,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/int64/15/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.06666666666666667,0.13333333333333333,0.2,0.26666666666666666,0.3333333333333333,0.4,0.4666666666666667,-0.4666666666666667,-0.4,-0.3333333333333333,-0.26666666666666666,-0.2,-0.13333333333333333,-0.06666666666666667},"fftfreq/typed/int64/15/1: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/int64/15/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/int64/15/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int64/15/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/int64/15/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/15/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/15/1: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/15/1: spacing state: dtype")
cases=cases+1
end
-- 222: fftfreq/typed/int64/15/2
do
local spacing=np.array(2,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/int64/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.03333333333333333,0.06666666666666667,0.1,0.13333333333333333,0.16666666666666666,0.2,0.23333333333333334,-0.23333333333333334,-0.2,-0.16666666666666666,-0.13333333333333333,-0.1,-0.06666666666666667,-0.03333333333333333},"fftfreq/typed/int64/15/2: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/int64/15/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/int64/15/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int64/15/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/int64/15/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/15/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/15/2: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/15/2: spacing state: dtype")
cases=cases+1
end
-- 223: fftfreq/typed/int64/127/0
do
local spacing=np.array(0,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/int64/127/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/int64/127/0: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/int64/127/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/int64/127/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int64/127/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/int64/127/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/127/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/127/0: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/127/0: spacing state: dtype")
cases=cases+1
end
-- 224: fftfreq/typed/int64/127/1
do
local spacing=np.array(1,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/int64/127/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.007874015748031496,0.015748031496062992,0.023622047244094488,0.031496062992125984,0.03937007874015748,0.047244094488188976,0.05511811023622047,0.06299212598425197,0.07086614173228346,0.07874015748031496,0.08661417322834646,0.09448818897637795,0.10236220472440945,0.11023622047244094,0.11811023622047244,0.12598425196850394,0.13385826771653542,0.14173228346456693,0.14960629921259844,0.15748031496062992,0.1653543307086614,0.1732283464566929,0.18110236220472442,0.1889763779527559,0.19685039370078738,0.2047244094488189,0.2125984251968504,0.2204724409448819,0.22834645669291337,0.23622047244094488,0.2440944881889764,0.25196850393700787,0.25984251968503935,0.26771653543307083,0.2755905511811024,0.28346456692913385,0.29133858267716534,0.2992125984251969,0.30708661417322836,0.31496062992125984,0.3228346456692913,0.3307086614173228,0.33858267716535434,0.3464566929133858,0.3543307086614173,0.36220472440944884,0.3700787401574803,0.3779527559055118,0.3858267716535433,0.39370078740157477,0.4015748031496063,0.4094488188976378,0.41732283464566927,0.4251968503937008,0.4330708661417323,0.4409448818897638,0.44881889763779526,0.45669291338582674,0.4645669291338583,0.47244094488188976,0.48031496062992124,0.4881889763779528,0.49606299212598426,-0.49606299212598426,-0.4881889763779528,-0.48031496062992124,-0.47244094488188976,-0.4645669291338583,-0.45669291338582674,-0.44881889763779526,-0.4409448818897638,-0.4330708661417323,-0.4251968503937008,-0.41732283464566927,-0.4094488188976378,-0.4015748031496063,-0.39370078740157477,-0.3858267716535433,-0.3779527559055118,-0.3700787401574803,-0.36220472440944884,-0.3543307086614173,-0.3464566929133858,-0.33858267716535434,-0.3307086614173228,-0.3228346456692913,-0.31496062992125984,-0.30708661417322836,-0.2992125984251969,-0.29133858267716534,-0.28346456692913385,-0.2755905511811024,-0.26771653543307083,-0.25984251968503935,-0.25196850393700787,-0.2440944881889764,-0.23622047244094488,-0.22834645669291337,-0.2204724409448819,-0.2125984251968504,-0.2047244094488189,-0.19685039370078738,-0.1889763779527559,-0.18110236220472442,-0.1732283464566929,-0.1653543307086614,-0.15748031496062992,-0.14960629921259844,-0.14173228346456693,-0.13385826771653542,-0.12598425196850394,-0.11811023622047244,-0.11023622047244094,-0.10236220472440945,-0.09448818897637795,-0.08661417322834646,-0.07874015748031496,-0.07086614173228346,-0.06299212598425197,-0.05511811023622047,-0.047244094488188976,-0.03937007874015748,-0.031496062992125984,-0.023622047244094488,-0.015748031496062992,-0.007874015748031496},"fftfreq/typed/int64/127/1: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/int64/127/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/int64/127/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int64/127/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/int64/127/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/127/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/127/1: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/127/1: spacing state: dtype")
cases=cases+1
end
-- 225: fftfreq/typed/int64/127/2
do
local spacing=np.array(2,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/int64/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.003937007874015748,0.007874015748031496,0.011811023622047244,0.015748031496062992,0.01968503937007874,0.023622047244094488,0.027559055118110236,0.031496062992125984,0.03543307086614173,0.03937007874015748,0.04330708661417323,0.047244094488188976,0.051181102362204724,0.05511811023622047,0.05905511811023622,0.06299212598425197,0.06692913385826771,0.07086614173228346,0.07480314960629922,0.07874015748031496,0.0826771653543307,0.08661417322834646,0.09055118110236221,0.09448818897637795,0.09842519685039369,0.10236220472440945,0.1062992125984252,0.11023622047244094,0.11417322834645668,0.11811023622047244,0.1220472440944882,0.12598425196850394,0.12992125984251968,0.13385826771653542,0.1377952755905512,0.14173228346456693,0.14566929133858267,0.14960629921259844,0.15354330708661418,0.15748031496062992,0.16141732283464566,0.1653543307086614,0.16929133858267717,0.1732283464566929,0.17716535433070865,0.18110236220472442,0.18503937007874016,0.1889763779527559,0.19291338582677164,0.19685039370078738,0.20078740157480315,0.2047244094488189,0.20866141732283464,0.2125984251968504,0.21653543307086615,0.2204724409448819,0.22440944881889763,0.22834645669291337,0.23228346456692914,0.23622047244094488,0.24015748031496062,0.2440944881889764,0.24803149606299213,-0.24803149606299213,-0.2440944881889764,-0.24015748031496062,-0.23622047244094488,-0.23228346456692914,-0.22834645669291337,-0.22440944881889763,-0.2204724409448819,-0.21653543307086615,-0.2125984251968504,-0.20866141732283464,-0.2047244094488189,-0.20078740157480315,-0.19685039370078738,-0.19291338582677164,-0.1889763779527559,-0.18503937007874016,-0.18110236220472442,-0.17716535433070865,-0.1732283464566929,-0.16929133858267717,-0.1653543307086614,-0.16141732283464566,-0.15748031496062992,-0.15354330708661418,-0.14960629921259844,-0.14566929133858267,-0.14173228346456693,-0.1377952755905512,-0.13385826771653542,-0.12992125984251968,-0.12598425196850394,-0.1220472440944882,-0.11811023622047244,-0.11417322834645668,-0.11023622047244094,-0.1062992125984252,-0.10236220472440945,-0.09842519685039369,-0.09448818897637795,-0.09055118110236221,-0.08661417322834646,-0.0826771653543307,-0.07874015748031496,-0.07480314960629922,-0.07086614173228346,-0.06692913385826771,-0.06299212598425197,-0.05905511811023622,-0.05511811023622047,-0.051181102362204724,-0.047244094488188976,-0.04330708661417323,-0.03937007874015748,-0.03543307086614173,-0.031496062992125984,-0.027559055118110236,-0.023622047244094488,-0.01968503937007874,-0.015748031496062992,-0.011811023622047244,-0.007874015748031496,-0.003937007874015748},"fftfreq/typed/int64/127/2: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/int64/127/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/int64/127/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int64/127/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/int64/127/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/127/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/127/2: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/127/2: spacing state: dtype")
cases=cases+1
end
-- 226: fftfreq/typed/int64/128/0
do
local spacing=np.array(0,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/int64/128/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/int64/128/0: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/int64/128/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/int64/128/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int64/128/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/int64/128/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/128/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/128/0: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/128/0: spacing state: dtype")
cases=cases+1
end
-- 227: fftfreq/typed/int64/128/1
do
local spacing=np.array(1,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/int64/128/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0078125,0.015625,0.0234375,0.03125,0.0390625,0.046875,0.0546875,0.0625,0.0703125,0.078125,0.0859375,0.09375,0.1015625,0.109375,0.1171875,0.125,0.1328125,0.140625,0.1484375,0.15625,0.1640625,0.171875,0.1796875,0.1875,0.1953125,0.203125,0.2109375,0.21875,0.2265625,0.234375,0.2421875,0.25,0.2578125,0.265625,0.2734375,0.28125,0.2890625,0.296875,0.3046875,0.3125,0.3203125,0.328125,0.3359375,0.34375,0.3515625,0.359375,0.3671875,0.375,0.3828125,0.390625,0.3984375,0.40625,0.4140625,0.421875,0.4296875,0.4375,0.4453125,0.453125,0.4609375,0.46875,0.4765625,0.484375,0.4921875,-0.5,-0.4921875,-0.484375,-0.4765625,-0.46875,-0.4609375,-0.453125,-0.4453125,-0.4375,-0.4296875,-0.421875,-0.4140625,-0.40625,-0.3984375,-0.390625,-0.3828125,-0.375,-0.3671875,-0.359375,-0.3515625,-0.34375,-0.3359375,-0.328125,-0.3203125,-0.3125,-0.3046875,-0.296875,-0.2890625,-0.28125,-0.2734375,-0.265625,-0.2578125,-0.25,-0.2421875,-0.234375,-0.2265625,-0.21875,-0.2109375,-0.203125,-0.1953125,-0.1875,-0.1796875,-0.171875,-0.1640625,-0.15625,-0.1484375,-0.140625,-0.1328125,-0.125,-0.1171875,-0.109375,-0.1015625,-0.09375,-0.0859375,-0.078125,-0.0703125,-0.0625,-0.0546875,-0.046875,-0.0390625,-0.03125,-0.0234375,-0.015625,-0.0078125},"fftfreq/typed/int64/128/1: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/int64/128/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/int64/128/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int64/128/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/int64/128/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/128/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/128/1: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/128/1: spacing state: dtype")
cases=cases+1
end
-- 228: fftfreq/typed/int64/128/2
do
local spacing=np.array(2,"int64")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/int64/128/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.00390625,0.0078125,0.01171875,0.015625,0.01953125,0.0234375,0.02734375,0.03125,0.03515625,0.0390625,0.04296875,0.046875,0.05078125,0.0546875,0.05859375,0.0625,0.06640625,0.0703125,0.07421875,0.078125,0.08203125,0.0859375,0.08984375,0.09375,0.09765625,0.1015625,0.10546875,0.109375,0.11328125,0.1171875,0.12109375,0.125,0.12890625,0.1328125,0.13671875,0.140625,0.14453125,0.1484375,0.15234375,0.15625,0.16015625,0.1640625,0.16796875,0.171875,0.17578125,0.1796875,0.18359375,0.1875,0.19140625,0.1953125,0.19921875,0.203125,0.20703125,0.2109375,0.21484375,0.21875,0.22265625,0.2265625,0.23046875,0.234375,0.23828125,0.2421875,0.24609375,-0.25,-0.24609375,-0.2421875,-0.23828125,-0.234375,-0.23046875,-0.2265625,-0.22265625,-0.21875,-0.21484375,-0.2109375,-0.20703125,-0.203125,-0.19921875,-0.1953125,-0.19140625,-0.1875,-0.18359375,-0.1796875,-0.17578125,-0.171875,-0.16796875,-0.1640625,-0.16015625,-0.15625,-0.15234375,-0.1484375,-0.14453125,-0.140625,-0.13671875,-0.1328125,-0.12890625,-0.125,-0.12109375,-0.1171875,-0.11328125,-0.109375,-0.10546875,-0.1015625,-0.09765625,-0.09375,-0.08984375,-0.0859375,-0.08203125,-0.078125,-0.07421875,-0.0703125,-0.06640625,-0.0625,-0.05859375,-0.0546875,-0.05078125,-0.046875,-0.04296875,-0.0390625,-0.03515625,-0.03125,-0.02734375,-0.0234375,-0.01953125,-0.015625,-0.01171875,-0.0078125,-0.00390625},"fftfreq/typed/int64/128/2: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/int64/128/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/int64/128/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/int64/128/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/int64/128/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/int64/128/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/int64/128/2: spacing state: strides")
eq(spacing.dtype,"int64","fftfreq/typed/int64/128/2: spacing state: dtype")
cases=cases+1
end
-- 229: fftfreq/typed/uint64/-1/0
do
local spacing=np.array(0,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/uint64/-1/0: acceptance"..": "..tostring(result))
eq(spacing:tolist(),0,"fftfreq/typed/uint64/-1/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/-1/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/-1/0: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/-1/0: spacing state: dtype")
cases=cases+1
end
-- 230: fftfreq/typed/uint64/-1/1
do
local spacing=np.array(1,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/uint64/-1/1: acceptance"..": "..tostring(result))
eq(spacing:tolist(),1,"fftfreq/typed/uint64/-1/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/-1/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/-1/1: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/-1/1: spacing state: dtype")
cases=cases+1
end
-- 231: fftfreq/typed/uint64/-1/2
do
local spacing=np.array(2,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/uint64/-1/2: acceptance"..": "..tostring(result))
eq(spacing:tolist(),2,"fftfreq/typed/uint64/-1/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/-1/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/-1/2: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/-1/2: spacing state: dtype")
cases=cases+1
end
-- 232: fftfreq/typed/uint64/0/0
do
local spacing=np.array(0,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/uint64/0/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/uint64/0/0: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/uint64/0/0: result: shape")
eq(result.strides,{0},"fftfreq/typed/uint64/0/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint64/0/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/uint64/0/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/0/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/0/0: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/0/0: spacing state: dtype")
cases=cases+1
end
-- 233: fftfreq/typed/uint64/0/1
do
local spacing=np.array(1,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/uint64/0/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/uint64/0/1: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/uint64/0/1: result: shape")
eq(result.strides,{0},"fftfreq/typed/uint64/0/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint64/0/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/uint64/0/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/0/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/0/1: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/0/1: spacing state: dtype")
cases=cases+1
end
-- 234: fftfreq/typed/uint64/0/2
do
local spacing=np.array(2,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/uint64/0/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/uint64/0/2: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/uint64/0/2: result: shape")
eq(result.strides,{0},"fftfreq/typed/uint64/0/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint64/0/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/uint64/0/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/0/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/0/2: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/0/2: spacing state: dtype")
cases=cases+1
end
-- 235: fftfreq/typed/uint64/1/0
do
local spacing=np.array(0,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/uint64/1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"fftfreq/typed/uint64/1/0: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/uint64/1/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint64/1/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint64/1/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/uint64/1/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/1/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/1/0: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/1/0: spacing state: dtype")
cases=cases+1
end
-- 236: fftfreq/typed/uint64/1/1
do
local spacing=np.array(1,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/uint64/1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"fftfreq/typed/uint64/1/1: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/uint64/1/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint64/1/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint64/1/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/uint64/1/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/1/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/1/1: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/1/1: spacing state: dtype")
cases=cases+1
end
-- 237: fftfreq/typed/uint64/1/2
do
local spacing=np.array(2,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/uint64/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"fftfreq/typed/uint64/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/uint64/1/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint64/1/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint64/1/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/uint64/1/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/1/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/1/2: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/1/2: spacing state: dtype")
cases=cases+1
end
-- 238: fftfreq/typed/uint64/3/0
do
local spacing=np.array(0,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/uint64/3/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,-math.huge},"fftfreq/typed/uint64/3/0: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/uint64/3/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint64/3/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint64/3/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/uint64/3/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/3/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/3/0: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/3/0: spacing state: dtype")
cases=cases+1
end
-- 239: fftfreq/typed/uint64/3/1
do
local spacing=np.array(1,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/uint64/3/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.3333333333333333,-0.3333333333333333},"fftfreq/typed/uint64/3/1: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/uint64/3/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint64/3/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint64/3/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/uint64/3/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/3/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/3/1: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/3/1: spacing state: dtype")
cases=cases+1
end
-- 240: fftfreq/typed/uint64/3/2
do
local spacing=np.array(2,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/uint64/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.16666666666666666,-0.16666666666666666},"fftfreq/typed/uint64/3/2: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/uint64/3/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint64/3/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint64/3/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/uint64/3/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/3/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/3/2: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/3/2: spacing state: dtype")
cases=cases+1
end
-- 241: fftfreq/typed/uint64/4/0
do
local spacing=np.array(0,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/uint64/4/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,-math.huge,-math.huge},"fftfreq/typed/uint64/4/0: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/uint64/4/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint64/4/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint64/4/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/uint64/4/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/4/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/4/0: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/4/0: spacing state: dtype")
cases=cases+1
end
-- 242: fftfreq/typed/uint64/4/1
do
local spacing=np.array(1,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/uint64/4/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,-0.5,-0.25},"fftfreq/typed/uint64/4/1: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/uint64/4/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint64/4/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint64/4/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/uint64/4/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/4/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/4/1: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/4/1: spacing state: dtype")
cases=cases+1
end
-- 243: fftfreq/typed/uint64/4/2
do
local spacing=np.array(2,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/uint64/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.125,-0.25,-0.125},"fftfreq/typed/uint64/4/2: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/uint64/4/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint64/4/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint64/4/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/uint64/4/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/4/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/4/2: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/4/2: spacing state: dtype")
cases=cases+1
end
-- 244: fftfreq/typed/uint64/15/0
do
local spacing=np.array(0,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/uint64/15/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/uint64/15/0: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/uint64/15/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint64/15/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint64/15/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/uint64/15/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/15/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/15/0: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/15/0: spacing state: dtype")
cases=cases+1
end
-- 245: fftfreq/typed/uint64/15/1
do
local spacing=np.array(1,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/uint64/15/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.06666666666666667,0.13333333333333333,0.2,0.26666666666666666,0.3333333333333333,0.4,0.4666666666666667,-0.4666666666666667,-0.4,-0.3333333333333333,-0.26666666666666666,-0.2,-0.13333333333333333,-0.06666666666666667},"fftfreq/typed/uint64/15/1: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/uint64/15/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint64/15/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint64/15/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/uint64/15/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/15/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/15/1: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/15/1: spacing state: dtype")
cases=cases+1
end
-- 246: fftfreq/typed/uint64/15/2
do
local spacing=np.array(2,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/uint64/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.03333333333333333,0.06666666666666667,0.1,0.13333333333333333,0.16666666666666666,0.2,0.23333333333333334,-0.23333333333333334,-0.2,-0.16666666666666666,-0.13333333333333333,-0.1,-0.06666666666666667,-0.03333333333333333},"fftfreq/typed/uint64/15/2: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/uint64/15/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint64/15/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint64/15/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/uint64/15/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/15/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/15/2: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/15/2: spacing state: dtype")
cases=cases+1
end
-- 247: fftfreq/typed/uint64/127/0
do
local spacing=np.array(0,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/uint64/127/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/uint64/127/0: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/uint64/127/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint64/127/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint64/127/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/uint64/127/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/127/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/127/0: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/127/0: spacing state: dtype")
cases=cases+1
end
-- 248: fftfreq/typed/uint64/127/1
do
local spacing=np.array(1,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/uint64/127/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.007874015748031496,0.015748031496062992,0.023622047244094488,0.031496062992125984,0.03937007874015748,0.047244094488188976,0.05511811023622047,0.06299212598425197,0.07086614173228346,0.07874015748031496,0.08661417322834646,0.09448818897637795,0.10236220472440945,0.11023622047244094,0.11811023622047244,0.12598425196850394,0.13385826771653542,0.14173228346456693,0.14960629921259844,0.15748031496062992,0.1653543307086614,0.1732283464566929,0.18110236220472442,0.1889763779527559,0.19685039370078738,0.2047244094488189,0.2125984251968504,0.2204724409448819,0.22834645669291337,0.23622047244094488,0.2440944881889764,0.25196850393700787,0.25984251968503935,0.26771653543307083,0.2755905511811024,0.28346456692913385,0.29133858267716534,0.2992125984251969,0.30708661417322836,0.31496062992125984,0.3228346456692913,0.3307086614173228,0.33858267716535434,0.3464566929133858,0.3543307086614173,0.36220472440944884,0.3700787401574803,0.3779527559055118,0.3858267716535433,0.39370078740157477,0.4015748031496063,0.4094488188976378,0.41732283464566927,0.4251968503937008,0.4330708661417323,0.4409448818897638,0.44881889763779526,0.45669291338582674,0.4645669291338583,0.47244094488188976,0.48031496062992124,0.4881889763779528,0.49606299212598426,-0.49606299212598426,-0.4881889763779528,-0.48031496062992124,-0.47244094488188976,-0.4645669291338583,-0.45669291338582674,-0.44881889763779526,-0.4409448818897638,-0.4330708661417323,-0.4251968503937008,-0.41732283464566927,-0.4094488188976378,-0.4015748031496063,-0.39370078740157477,-0.3858267716535433,-0.3779527559055118,-0.3700787401574803,-0.36220472440944884,-0.3543307086614173,-0.3464566929133858,-0.33858267716535434,-0.3307086614173228,-0.3228346456692913,-0.31496062992125984,-0.30708661417322836,-0.2992125984251969,-0.29133858267716534,-0.28346456692913385,-0.2755905511811024,-0.26771653543307083,-0.25984251968503935,-0.25196850393700787,-0.2440944881889764,-0.23622047244094488,-0.22834645669291337,-0.2204724409448819,-0.2125984251968504,-0.2047244094488189,-0.19685039370078738,-0.1889763779527559,-0.18110236220472442,-0.1732283464566929,-0.1653543307086614,-0.15748031496062992,-0.14960629921259844,-0.14173228346456693,-0.13385826771653542,-0.12598425196850394,-0.11811023622047244,-0.11023622047244094,-0.10236220472440945,-0.09448818897637795,-0.08661417322834646,-0.07874015748031496,-0.07086614173228346,-0.06299212598425197,-0.05511811023622047,-0.047244094488188976,-0.03937007874015748,-0.031496062992125984,-0.023622047244094488,-0.015748031496062992,-0.007874015748031496},"fftfreq/typed/uint64/127/1: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/uint64/127/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint64/127/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint64/127/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/uint64/127/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/127/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/127/1: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/127/1: spacing state: dtype")
cases=cases+1
end
-- 249: fftfreq/typed/uint64/127/2
do
local spacing=np.array(2,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/uint64/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.003937007874015748,0.007874015748031496,0.011811023622047244,0.015748031496062992,0.01968503937007874,0.023622047244094488,0.027559055118110236,0.031496062992125984,0.03543307086614173,0.03937007874015748,0.04330708661417323,0.047244094488188976,0.051181102362204724,0.05511811023622047,0.05905511811023622,0.06299212598425197,0.06692913385826771,0.07086614173228346,0.07480314960629922,0.07874015748031496,0.0826771653543307,0.08661417322834646,0.09055118110236221,0.09448818897637795,0.09842519685039369,0.10236220472440945,0.1062992125984252,0.11023622047244094,0.11417322834645668,0.11811023622047244,0.1220472440944882,0.12598425196850394,0.12992125984251968,0.13385826771653542,0.1377952755905512,0.14173228346456693,0.14566929133858267,0.14960629921259844,0.15354330708661418,0.15748031496062992,0.16141732283464566,0.1653543307086614,0.16929133858267717,0.1732283464566929,0.17716535433070865,0.18110236220472442,0.18503937007874016,0.1889763779527559,0.19291338582677164,0.19685039370078738,0.20078740157480315,0.2047244094488189,0.20866141732283464,0.2125984251968504,0.21653543307086615,0.2204724409448819,0.22440944881889763,0.22834645669291337,0.23228346456692914,0.23622047244094488,0.24015748031496062,0.2440944881889764,0.24803149606299213,-0.24803149606299213,-0.2440944881889764,-0.24015748031496062,-0.23622047244094488,-0.23228346456692914,-0.22834645669291337,-0.22440944881889763,-0.2204724409448819,-0.21653543307086615,-0.2125984251968504,-0.20866141732283464,-0.2047244094488189,-0.20078740157480315,-0.19685039370078738,-0.19291338582677164,-0.1889763779527559,-0.18503937007874016,-0.18110236220472442,-0.17716535433070865,-0.1732283464566929,-0.16929133858267717,-0.1653543307086614,-0.16141732283464566,-0.15748031496062992,-0.15354330708661418,-0.14960629921259844,-0.14566929133858267,-0.14173228346456693,-0.1377952755905512,-0.13385826771653542,-0.12992125984251968,-0.12598425196850394,-0.1220472440944882,-0.11811023622047244,-0.11417322834645668,-0.11023622047244094,-0.1062992125984252,-0.10236220472440945,-0.09842519685039369,-0.09448818897637795,-0.09055118110236221,-0.08661417322834646,-0.0826771653543307,-0.07874015748031496,-0.07480314960629922,-0.07086614173228346,-0.06692913385826771,-0.06299212598425197,-0.05905511811023622,-0.05511811023622047,-0.051181102362204724,-0.047244094488188976,-0.04330708661417323,-0.03937007874015748,-0.03543307086614173,-0.031496062992125984,-0.027559055118110236,-0.023622047244094488,-0.01968503937007874,-0.015748031496062992,-0.011811023622047244,-0.007874015748031496,-0.003937007874015748},"fftfreq/typed/uint64/127/2: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/uint64/127/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint64/127/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint64/127/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/uint64/127/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/127/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/127/2: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/127/2: spacing state: dtype")
cases=cases+1
end
-- 250: fftfreq/typed/uint64/128/0
do
local spacing=np.array(0,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/uint64/128/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/uint64/128/0: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/uint64/128/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint64/128/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint64/128/0: result: dtype")
eq(spacing:tolist(),0,"fftfreq/typed/uint64/128/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/128/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/128/0: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/128/0: spacing state: dtype")
cases=cases+1
end
end
chunk()
end
do
local function chunk()
-- 251: fftfreq/typed/uint64/128/1
do
local spacing=np.array(1,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/uint64/128/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0078125,0.015625,0.0234375,0.03125,0.0390625,0.046875,0.0546875,0.0625,0.0703125,0.078125,0.0859375,0.09375,0.1015625,0.109375,0.1171875,0.125,0.1328125,0.140625,0.1484375,0.15625,0.1640625,0.171875,0.1796875,0.1875,0.1953125,0.203125,0.2109375,0.21875,0.2265625,0.234375,0.2421875,0.25,0.2578125,0.265625,0.2734375,0.28125,0.2890625,0.296875,0.3046875,0.3125,0.3203125,0.328125,0.3359375,0.34375,0.3515625,0.359375,0.3671875,0.375,0.3828125,0.390625,0.3984375,0.40625,0.4140625,0.421875,0.4296875,0.4375,0.4453125,0.453125,0.4609375,0.46875,0.4765625,0.484375,0.4921875,-0.5,-0.4921875,-0.484375,-0.4765625,-0.46875,-0.4609375,-0.453125,-0.4453125,-0.4375,-0.4296875,-0.421875,-0.4140625,-0.40625,-0.3984375,-0.390625,-0.3828125,-0.375,-0.3671875,-0.359375,-0.3515625,-0.34375,-0.3359375,-0.328125,-0.3203125,-0.3125,-0.3046875,-0.296875,-0.2890625,-0.28125,-0.2734375,-0.265625,-0.2578125,-0.25,-0.2421875,-0.234375,-0.2265625,-0.21875,-0.2109375,-0.203125,-0.1953125,-0.1875,-0.1796875,-0.171875,-0.1640625,-0.15625,-0.1484375,-0.140625,-0.1328125,-0.125,-0.1171875,-0.109375,-0.1015625,-0.09375,-0.0859375,-0.078125,-0.0703125,-0.0625,-0.0546875,-0.046875,-0.0390625,-0.03125,-0.0234375,-0.015625,-0.0078125},"fftfreq/typed/uint64/128/1: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/uint64/128/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint64/128/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint64/128/1: result: dtype")
eq(spacing:tolist(),1,"fftfreq/typed/uint64/128/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/128/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/128/1: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/128/1: spacing state: dtype")
cases=cases+1
end
-- 252: fftfreq/typed/uint64/128/2
do
local spacing=np.array(2,"uint64")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/uint64/128/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.00390625,0.0078125,0.01171875,0.015625,0.01953125,0.0234375,0.02734375,0.03125,0.03515625,0.0390625,0.04296875,0.046875,0.05078125,0.0546875,0.05859375,0.0625,0.06640625,0.0703125,0.07421875,0.078125,0.08203125,0.0859375,0.08984375,0.09375,0.09765625,0.1015625,0.10546875,0.109375,0.11328125,0.1171875,0.12109375,0.125,0.12890625,0.1328125,0.13671875,0.140625,0.14453125,0.1484375,0.15234375,0.15625,0.16015625,0.1640625,0.16796875,0.171875,0.17578125,0.1796875,0.18359375,0.1875,0.19140625,0.1953125,0.19921875,0.203125,0.20703125,0.2109375,0.21484375,0.21875,0.22265625,0.2265625,0.23046875,0.234375,0.23828125,0.2421875,0.24609375,-0.25,-0.24609375,-0.2421875,-0.23828125,-0.234375,-0.23046875,-0.2265625,-0.22265625,-0.21875,-0.21484375,-0.2109375,-0.20703125,-0.203125,-0.19921875,-0.1953125,-0.19140625,-0.1875,-0.18359375,-0.1796875,-0.17578125,-0.171875,-0.16796875,-0.1640625,-0.16015625,-0.15625,-0.15234375,-0.1484375,-0.14453125,-0.140625,-0.13671875,-0.1328125,-0.12890625,-0.125,-0.12109375,-0.1171875,-0.11328125,-0.109375,-0.10546875,-0.1015625,-0.09765625,-0.09375,-0.08984375,-0.0859375,-0.08203125,-0.078125,-0.07421875,-0.0703125,-0.06640625,-0.0625,-0.05859375,-0.0546875,-0.05078125,-0.046875,-0.04296875,-0.0390625,-0.03515625,-0.03125,-0.02734375,-0.0234375,-0.01953125,-0.015625,-0.01171875,-0.0078125,-0.00390625},"fftfreq/typed/uint64/128/2: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/uint64/128/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/uint64/128/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/uint64/128/2: result: dtype")
eq(spacing:tolist(),2,"fftfreq/typed/uint64/128/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/uint64/128/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/uint64/128/2: spacing state: strides")
eq(spacing.dtype,"uint64","fftfreq/typed/uint64/128/2: spacing state: dtype")
cases=cases+1
end
-- 253: fftfreq/typed/float16/-1/0
do
local spacing=np.array(0.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/float16/-1/0: acceptance"..": "..tostring(result))
eq(spacing:tolist(),0.0,"fftfreq/typed/float16/-1/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/-1/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/-1/0: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/-1/0: spacing state: dtype")
cases=cases+1
end
-- 254: fftfreq/typed/float16/-1/1
do
local spacing=np.array(1.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/float16/-1/1: acceptance"..": "..tostring(result))
eq(spacing:tolist(),1.0,"fftfreq/typed/float16/-1/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/-1/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/-1/1: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/-1/1: spacing state: dtype")
cases=cases+1
end
-- 255: fftfreq/typed/float16/-1/2
do
local spacing=np.array(2.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/float16/-1/2: acceptance"..": "..tostring(result))
eq(spacing:tolist(),2.0,"fftfreq/typed/float16/-1/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/-1/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/-1/2: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/-1/2: spacing state: dtype")
cases=cases+1
end
-- 256: fftfreq/typed/float16/0/0
do
local spacing=np.array(0.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/float16/0/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/float16/0/0: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/float16/0/0: result: shape")
eq(result.strides,{0},"fftfreq/typed/float16/0/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float16/0/0: result: dtype")
eq(spacing:tolist(),0.0,"fftfreq/typed/float16/0/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/0/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/0/0: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/0/0: spacing state: dtype")
cases=cases+1
end
-- 257: fftfreq/typed/float16/0/1
do
local spacing=np.array(1.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/float16/0/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/float16/0/1: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/float16/0/1: result: shape")
eq(result.strides,{0},"fftfreq/typed/float16/0/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float16/0/1: result: dtype")
eq(spacing:tolist(),1.0,"fftfreq/typed/float16/0/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/0/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/0/1: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/0/1: spacing state: dtype")
cases=cases+1
end
-- 258: fftfreq/typed/float16/0/2
do
local spacing=np.array(2.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/float16/0/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/float16/0/2: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/float16/0/2: result: shape")
eq(result.strides,{0},"fftfreq/typed/float16/0/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float16/0/2: result: dtype")
eq(spacing:tolist(),2.0,"fftfreq/typed/float16/0/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/0/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/0/2: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/0/2: spacing state: dtype")
cases=cases+1
end
-- 259: fftfreq/typed/float16/1/0
do
local spacing=np.array(0.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/float16/1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"fftfreq/typed/float16/1/0: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/float16/1/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/float16/1/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float16/1/0: result: dtype")
eq(spacing:tolist(),0.0,"fftfreq/typed/float16/1/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/1/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/1/0: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/1/0: spacing state: dtype")
cases=cases+1
end
-- 260: fftfreq/typed/float16/1/1
do
local spacing=np.array(1.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/float16/1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"fftfreq/typed/float16/1/1: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/float16/1/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/float16/1/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float16/1/1: result: dtype")
eq(spacing:tolist(),1.0,"fftfreq/typed/float16/1/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/1/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/1/1: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/1/1: spacing state: dtype")
cases=cases+1
end
-- 261: fftfreq/typed/float16/1/2
do
local spacing=np.array(2.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/float16/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"fftfreq/typed/float16/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/float16/1/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/float16/1/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float16/1/2: result: dtype")
eq(spacing:tolist(),2.0,"fftfreq/typed/float16/1/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/1/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/1/2: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/1/2: spacing state: dtype")
cases=cases+1
end
-- 262: fftfreq/typed/float16/3/0
do
local spacing=np.array(0.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/float16/3/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,-math.huge},"fftfreq/typed/float16/3/0: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/float16/3/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/float16/3/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float16/3/0: result: dtype")
eq(spacing:tolist(),0.0,"fftfreq/typed/float16/3/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/3/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/3/0: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/3/0: spacing state: dtype")
cases=cases+1
end
-- 263: fftfreq/typed/float16/3/1
do
local spacing=np.array(1.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/float16/3/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.333251953125,-0.333251953125},"fftfreq/typed/float16/3/1: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/float16/3/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/float16/3/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float16/3/1: result: dtype")
eq(spacing:tolist(),1.0,"fftfreq/typed/float16/3/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/3/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/3/1: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/3/1: spacing state: dtype")
cases=cases+1
end
-- 264: fftfreq/typed/float16/3/2
do
local spacing=np.array(2.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/float16/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.1666259765625,-0.1666259765625},"fftfreq/typed/float16/3/2: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/float16/3/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/float16/3/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float16/3/2: result: dtype")
eq(spacing:tolist(),2.0,"fftfreq/typed/float16/3/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/3/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/3/2: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/3/2: spacing state: dtype")
cases=cases+1
end
-- 265: fftfreq/typed/float16/4/0
do
local spacing=np.array(0.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/float16/4/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,-math.huge,-math.huge},"fftfreq/typed/float16/4/0: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/float16/4/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/float16/4/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float16/4/0: result: dtype")
eq(spacing:tolist(),0.0,"fftfreq/typed/float16/4/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/4/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/4/0: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/4/0: spacing state: dtype")
cases=cases+1
end
-- 266: fftfreq/typed/float16/4/1
do
local spacing=np.array(1.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/float16/4/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,-0.5,-0.25},"fftfreq/typed/float16/4/1: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/float16/4/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/float16/4/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float16/4/1: result: dtype")
eq(spacing:tolist(),1.0,"fftfreq/typed/float16/4/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/4/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/4/1: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/4/1: spacing state: dtype")
cases=cases+1
end
-- 267: fftfreq/typed/float16/4/2
do
local spacing=np.array(2.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/float16/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.125,-0.25,-0.125},"fftfreq/typed/float16/4/2: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/float16/4/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/float16/4/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float16/4/2: result: dtype")
eq(spacing:tolist(),2.0,"fftfreq/typed/float16/4/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/4/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/4/2: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/4/2: spacing state: dtype")
cases=cases+1
end
-- 268: fftfreq/typed/float16/15/0
do
local spacing=np.array(0.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/float16/15/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/float16/15/0: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/float16/15/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/float16/15/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float16/15/0: result: dtype")
eq(spacing:tolist(),0.0,"fftfreq/typed/float16/15/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/15/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/15/0: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/15/0: spacing state: dtype")
cases=cases+1
end
-- 269: fftfreq/typed/float16/15/1
do
local spacing=np.array(1.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/float16/15/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.066650390625,0.13330078125,0.199951171875,0.2666015625,0.333251953125,0.39990234375,0.466552734375,-0.466552734375,-0.39990234375,-0.333251953125,-0.2666015625,-0.199951171875,-0.13330078125,-0.066650390625},"fftfreq/typed/float16/15/1: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/float16/15/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/float16/15/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float16/15/1: result: dtype")
eq(spacing:tolist(),1.0,"fftfreq/typed/float16/15/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/15/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/15/1: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/15/1: spacing state: dtype")
cases=cases+1
end
-- 270: fftfreq/typed/float16/15/2
do
local spacing=np.array(2.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/float16/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0333251953125,0.066650390625,0.0999755859375,0.13330078125,0.1666259765625,0.199951171875,0.2332763671875,-0.2332763671875,-0.199951171875,-0.1666259765625,-0.13330078125,-0.0999755859375,-0.066650390625,-0.0333251953125},"fftfreq/typed/float16/15/2: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/float16/15/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/float16/15/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float16/15/2: result: dtype")
eq(spacing:tolist(),2.0,"fftfreq/typed/float16/15/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/15/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/15/2: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/15/2: spacing state: dtype")
cases=cases+1
end
-- 271: fftfreq/typed/float16/127/0
do
local spacing=np.array(0.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/float16/127/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/float16/127/0: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/float16/127/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/float16/127/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float16/127/0: result: dtype")
eq(spacing:tolist(),0.0,"fftfreq/typed/float16/127/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/127/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/127/0: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/127/0: spacing state: dtype")
cases=cases+1
end
-- 272: fftfreq/typed/float16/127/1
do
local spacing=np.array(1.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/float16/127/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.00787353515625,0.0157470703125,0.02362060546875,0.031494140625,0.03936767578125,0.0472412109375,0.05511474609375,0.06298828125,0.07086181640625,0.0787353515625,0.08660888671875,0.094482421875,0.10235595703125,0.1102294921875,0.11810302734375,0.1259765625,0.13385009765625,0.1417236328125,0.14959716796875,0.157470703125,0.16534423828125,0.1732177734375,0.18109130859375,0.18896484375,0.19683837890625,0.2047119140625,0.21258544921875,0.220458984375,0.22833251953125,0.2362060546875,0.24407958984375,0.251953125,0.25982666015625,0.2677001953125,0.27557373046875,0.283447265625,0.29132080078125,0.2991943359375,0.30706787109375,0.31494140625,0.32281494140625,0.3306884765625,0.33856201171875,0.346435546875,0.35430908203125,0.3621826171875,0.37005615234375,0.3779296875,0.38580322265625,0.3936767578125,0.40155029296875,0.409423828125,0.41729736328125,0.4251708984375,0.43304443359375,0.44091796875,0.44879150390625,0.4566650390625,0.46453857421875,0.472412109375,0.48028564453125,0.4881591796875,0.49603271484375,-0.49603271484375,-0.4881591796875,-0.48028564453125,-0.472412109375,-0.46453857421875,-0.4566650390625,-0.44879150390625,-0.44091796875,-0.43304443359375,-0.4251708984375,-0.41729736328125,-0.409423828125,-0.40155029296875,-0.3936767578125,-0.38580322265625,-0.3779296875,-0.37005615234375,-0.3621826171875,-0.35430908203125,-0.346435546875,-0.33856201171875,-0.3306884765625,-0.32281494140625,-0.31494140625,-0.30706787109375,-0.2991943359375,-0.29132080078125,-0.283447265625,-0.27557373046875,-0.2677001953125,-0.25982666015625,-0.251953125,-0.24407958984375,-0.2362060546875,-0.22833251953125,-0.220458984375,-0.21258544921875,-0.2047119140625,-0.19683837890625,-0.18896484375,-0.18109130859375,-0.1732177734375,-0.16534423828125,-0.157470703125,-0.14959716796875,-0.1417236328125,-0.13385009765625,-0.1259765625,-0.11810302734375,-0.1102294921875,-0.10235595703125,-0.094482421875,-0.08660888671875,-0.0787353515625,-0.07086181640625,-0.06298828125,-0.05511474609375,-0.0472412109375,-0.03936767578125,-0.031494140625,-0.02362060546875,-0.0157470703125,-0.00787353515625},"fftfreq/typed/float16/127/1: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/float16/127/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/float16/127/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float16/127/1: result: dtype")
eq(spacing:tolist(),1.0,"fftfreq/typed/float16/127/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/127/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/127/1: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/127/1: spacing state: dtype")
cases=cases+1
end
-- 273: fftfreq/typed/float16/127/2
do
local spacing=np.array(2.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/float16/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.003936767578125,0.00787353515625,0.011810302734375,0.0157470703125,0.019683837890625,0.02362060546875,0.027557373046875,0.031494140625,0.035430908203125,0.03936767578125,0.043304443359375,0.0472412109375,0.051177978515625,0.05511474609375,0.059051513671875,0.06298828125,0.066925048828125,0.07086181640625,0.074798583984375,0.0787353515625,0.082672119140625,0.08660888671875,0.090545654296875,0.094482421875,0.098419189453125,0.10235595703125,0.106292724609375,0.1102294921875,0.114166259765625,0.11810302734375,0.122039794921875,0.1259765625,0.129913330078125,0.13385009765625,0.137786865234375,0.1417236328125,0.145660400390625,0.14959716796875,0.153533935546875,0.157470703125,0.161407470703125,0.16534423828125,0.169281005859375,0.1732177734375,0.177154541015625,0.18109130859375,0.185028076171875,0.18896484375,0.192901611328125,0.19683837890625,0.200775146484375,0.2047119140625,0.208648681640625,0.21258544921875,0.216522216796875,0.220458984375,0.224395751953125,0.22833251953125,0.232269287109375,0.2362060546875,0.240142822265625,0.24407958984375,0.248016357421875,-0.248016357421875,-0.24407958984375,-0.240142822265625,-0.2362060546875,-0.232269287109375,-0.22833251953125,-0.224395751953125,-0.220458984375,-0.216522216796875,-0.21258544921875,-0.208648681640625,-0.2047119140625,-0.200775146484375,-0.19683837890625,-0.192901611328125,-0.18896484375,-0.185028076171875,-0.18109130859375,-0.177154541015625,-0.1732177734375,-0.169281005859375,-0.16534423828125,-0.161407470703125,-0.157470703125,-0.153533935546875,-0.14959716796875,-0.145660400390625,-0.1417236328125,-0.137786865234375,-0.13385009765625,-0.129913330078125,-0.1259765625,-0.122039794921875,-0.11810302734375,-0.114166259765625,-0.1102294921875,-0.106292724609375,-0.10235595703125,-0.098419189453125,-0.094482421875,-0.090545654296875,-0.08660888671875,-0.082672119140625,-0.0787353515625,-0.074798583984375,-0.07086181640625,-0.066925048828125,-0.06298828125,-0.059051513671875,-0.05511474609375,-0.051177978515625,-0.0472412109375,-0.043304443359375,-0.03936767578125,-0.035430908203125,-0.031494140625,-0.027557373046875,-0.02362060546875,-0.019683837890625,-0.0157470703125,-0.011810302734375,-0.00787353515625,-0.003936767578125},"fftfreq/typed/float16/127/2: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/float16/127/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/float16/127/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float16/127/2: result: dtype")
eq(spacing:tolist(),2.0,"fftfreq/typed/float16/127/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/127/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/127/2: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/127/2: spacing state: dtype")
cases=cases+1
end
-- 274: fftfreq/typed/float16/128/0
do
local spacing=np.array(0.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/float16/128/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/float16/128/0: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/float16/128/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/float16/128/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float16/128/0: result: dtype")
eq(spacing:tolist(),0.0,"fftfreq/typed/float16/128/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/128/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/128/0: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/128/0: spacing state: dtype")
cases=cases+1
end
-- 275: fftfreq/typed/float16/128/1
do
local spacing=np.array(1.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/float16/128/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0078125,0.015625,0.0234375,0.03125,0.0390625,0.046875,0.0546875,0.0625,0.0703125,0.078125,0.0859375,0.09375,0.1015625,0.109375,0.1171875,0.125,0.1328125,0.140625,0.1484375,0.15625,0.1640625,0.171875,0.1796875,0.1875,0.1953125,0.203125,0.2109375,0.21875,0.2265625,0.234375,0.2421875,0.25,0.2578125,0.265625,0.2734375,0.28125,0.2890625,0.296875,0.3046875,0.3125,0.3203125,0.328125,0.3359375,0.34375,0.3515625,0.359375,0.3671875,0.375,0.3828125,0.390625,0.3984375,0.40625,0.4140625,0.421875,0.4296875,0.4375,0.4453125,0.453125,0.4609375,0.46875,0.4765625,0.484375,0.4921875,-0.5,-0.4921875,-0.484375,-0.4765625,-0.46875,-0.4609375,-0.453125,-0.4453125,-0.4375,-0.4296875,-0.421875,-0.4140625,-0.40625,-0.3984375,-0.390625,-0.3828125,-0.375,-0.3671875,-0.359375,-0.3515625,-0.34375,-0.3359375,-0.328125,-0.3203125,-0.3125,-0.3046875,-0.296875,-0.2890625,-0.28125,-0.2734375,-0.265625,-0.2578125,-0.25,-0.2421875,-0.234375,-0.2265625,-0.21875,-0.2109375,-0.203125,-0.1953125,-0.1875,-0.1796875,-0.171875,-0.1640625,-0.15625,-0.1484375,-0.140625,-0.1328125,-0.125,-0.1171875,-0.109375,-0.1015625,-0.09375,-0.0859375,-0.078125,-0.0703125,-0.0625,-0.0546875,-0.046875,-0.0390625,-0.03125,-0.0234375,-0.015625,-0.0078125},"fftfreq/typed/float16/128/1: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/float16/128/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/float16/128/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float16/128/1: result: dtype")
eq(spacing:tolist(),1.0,"fftfreq/typed/float16/128/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/128/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/128/1: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/128/1: spacing state: dtype")
cases=cases+1
end
-- 276: fftfreq/typed/float16/128/2
do
local spacing=np.array(2.0,"float16")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/float16/128/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.00390625,0.0078125,0.01171875,0.015625,0.01953125,0.0234375,0.02734375,0.03125,0.03515625,0.0390625,0.04296875,0.046875,0.05078125,0.0546875,0.05859375,0.0625,0.06640625,0.0703125,0.07421875,0.078125,0.08203125,0.0859375,0.08984375,0.09375,0.09765625,0.1015625,0.10546875,0.109375,0.11328125,0.1171875,0.12109375,0.125,0.12890625,0.1328125,0.13671875,0.140625,0.14453125,0.1484375,0.15234375,0.15625,0.16015625,0.1640625,0.16796875,0.171875,0.17578125,0.1796875,0.18359375,0.1875,0.19140625,0.1953125,0.19921875,0.203125,0.20703125,0.2109375,0.21484375,0.21875,0.22265625,0.2265625,0.23046875,0.234375,0.23828125,0.2421875,0.24609375,-0.25,-0.24609375,-0.2421875,-0.23828125,-0.234375,-0.23046875,-0.2265625,-0.22265625,-0.21875,-0.21484375,-0.2109375,-0.20703125,-0.203125,-0.19921875,-0.1953125,-0.19140625,-0.1875,-0.18359375,-0.1796875,-0.17578125,-0.171875,-0.16796875,-0.1640625,-0.16015625,-0.15625,-0.15234375,-0.1484375,-0.14453125,-0.140625,-0.13671875,-0.1328125,-0.12890625,-0.125,-0.12109375,-0.1171875,-0.11328125,-0.109375,-0.10546875,-0.1015625,-0.09765625,-0.09375,-0.08984375,-0.0859375,-0.08203125,-0.078125,-0.07421875,-0.0703125,-0.06640625,-0.0625,-0.05859375,-0.0546875,-0.05078125,-0.046875,-0.04296875,-0.0390625,-0.03515625,-0.03125,-0.02734375,-0.0234375,-0.01953125,-0.015625,-0.01171875,-0.0078125,-0.00390625},"fftfreq/typed/float16/128/2: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/float16/128/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/float16/128/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float16/128/2: result: dtype")
eq(spacing:tolist(),2.0,"fftfreq/typed/float16/128/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float16/128/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float16/128/2: spacing state: strides")
eq(spacing.dtype,"float16","fftfreq/typed/float16/128/2: spacing state: dtype")
cases=cases+1
end
-- 277: fftfreq/typed/float32/-1/0
do
local spacing=np.array(0.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/float32/-1/0: acceptance"..": "..tostring(result))
eq(spacing:tolist(),0.0,"fftfreq/typed/float32/-1/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/-1/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/-1/0: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/-1/0: spacing state: dtype")
cases=cases+1
end
-- 278: fftfreq/typed/float32/-1/1
do
local spacing=np.array(1.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/float32/-1/1: acceptance"..": "..tostring(result))
eq(spacing:tolist(),1.0,"fftfreq/typed/float32/-1/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/-1/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/-1/1: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/-1/1: spacing state: dtype")
cases=cases+1
end
-- 279: fftfreq/typed/float32/-1/2
do
local spacing=np.array(2.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/float32/-1/2: acceptance"..": "..tostring(result))
eq(spacing:tolist(),2.0,"fftfreq/typed/float32/-1/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/-1/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/-1/2: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/-1/2: spacing state: dtype")
cases=cases+1
end
-- 280: fftfreq/typed/float32/0/0
do
local spacing=np.array(0.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/float32/0/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/float32/0/0: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/float32/0/0: result: shape")
eq(result.strides,{0},"fftfreq/typed/float32/0/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float32/0/0: result: dtype")
eq(spacing:tolist(),0.0,"fftfreq/typed/float32/0/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/0/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/0/0: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/0/0: spacing state: dtype")
cases=cases+1
end
-- 281: fftfreq/typed/float32/0/1
do
local spacing=np.array(1.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/float32/0/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/float32/0/1: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/float32/0/1: result: shape")
eq(result.strides,{0},"fftfreq/typed/float32/0/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float32/0/1: result: dtype")
eq(spacing:tolist(),1.0,"fftfreq/typed/float32/0/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/0/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/0/1: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/0/1: spacing state: dtype")
cases=cases+1
end
-- 282: fftfreq/typed/float32/0/2
do
local spacing=np.array(2.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/float32/0/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/float32/0/2: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/float32/0/2: result: shape")
eq(result.strides,{0},"fftfreq/typed/float32/0/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float32/0/2: result: dtype")
eq(spacing:tolist(),2.0,"fftfreq/typed/float32/0/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/0/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/0/2: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/0/2: spacing state: dtype")
cases=cases+1
end
-- 283: fftfreq/typed/float32/1/0
do
local spacing=np.array(0.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/float32/1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"fftfreq/typed/float32/1/0: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/float32/1/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/float32/1/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float32/1/0: result: dtype")
eq(spacing:tolist(),0.0,"fftfreq/typed/float32/1/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/1/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/1/0: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/1/0: spacing state: dtype")
cases=cases+1
end
-- 284: fftfreq/typed/float32/1/1
do
local spacing=np.array(1.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/float32/1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"fftfreq/typed/float32/1/1: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/float32/1/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/float32/1/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float32/1/1: result: dtype")
eq(spacing:tolist(),1.0,"fftfreq/typed/float32/1/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/1/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/1/1: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/1/1: spacing state: dtype")
cases=cases+1
end
-- 285: fftfreq/typed/float32/1/2
do
local spacing=np.array(2.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/float32/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"fftfreq/typed/float32/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/float32/1/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/float32/1/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float32/1/2: result: dtype")
eq(spacing:tolist(),2.0,"fftfreq/typed/float32/1/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/1/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/1/2: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/1/2: spacing state: dtype")
cases=cases+1
end
-- 286: fftfreq/typed/float32/3/0
do
local spacing=np.array(0.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/float32/3/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,-math.huge},"fftfreq/typed/float32/3/0: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/float32/3/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/float32/3/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float32/3/0: result: dtype")
eq(spacing:tolist(),0.0,"fftfreq/typed/float32/3/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/3/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/3/0: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/3/0: spacing state: dtype")
cases=cases+1
end
-- 287: fftfreq/typed/float32/3/1
do
local spacing=np.array(1.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/float32/3/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.3333333432674408,-0.3333333432674408},"fftfreq/typed/float32/3/1: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/float32/3/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/float32/3/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float32/3/1: result: dtype")
eq(spacing:tolist(),1.0,"fftfreq/typed/float32/3/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/3/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/3/1: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/3/1: spacing state: dtype")
cases=cases+1
end
-- 288: fftfreq/typed/float32/3/2
do
local spacing=np.array(2.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/float32/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.1666666716337204,-0.1666666716337204},"fftfreq/typed/float32/3/2: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/float32/3/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/float32/3/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float32/3/2: result: dtype")
eq(spacing:tolist(),2.0,"fftfreq/typed/float32/3/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/3/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/3/2: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/3/2: spacing state: dtype")
cases=cases+1
end
-- 289: fftfreq/typed/float32/4/0
do
local spacing=np.array(0.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/float32/4/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,-math.huge,-math.huge},"fftfreq/typed/float32/4/0: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/float32/4/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/float32/4/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float32/4/0: result: dtype")
eq(spacing:tolist(),0.0,"fftfreq/typed/float32/4/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/4/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/4/0: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/4/0: spacing state: dtype")
cases=cases+1
end
-- 290: fftfreq/typed/float32/4/1
do
local spacing=np.array(1.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/float32/4/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,-0.5,-0.25},"fftfreq/typed/float32/4/1: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/float32/4/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/float32/4/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float32/4/1: result: dtype")
eq(spacing:tolist(),1.0,"fftfreq/typed/float32/4/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/4/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/4/1: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/4/1: spacing state: dtype")
cases=cases+1
end
-- 291: fftfreq/typed/float32/4/2
do
local spacing=np.array(2.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/float32/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.125,-0.25,-0.125},"fftfreq/typed/float32/4/2: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/float32/4/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/float32/4/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float32/4/2: result: dtype")
eq(spacing:tolist(),2.0,"fftfreq/typed/float32/4/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/4/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/4/2: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/4/2: spacing state: dtype")
cases=cases+1
end
-- 292: fftfreq/typed/float32/15/0
do
local spacing=np.array(0.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/float32/15/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/float32/15/0: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/float32/15/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/float32/15/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float32/15/0: result: dtype")
eq(spacing:tolist(),0.0,"fftfreq/typed/float32/15/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/15/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/15/0: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/15/0: spacing state: dtype")
cases=cases+1
end
-- 293: fftfreq/typed/float32/15/1
do
local spacing=np.array(1.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/float32/15/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.06666667014360428,0.13333334028720856,0.20000001043081284,0.2666666805744171,0.3333333507180214,0.40000002086162567,0.46666669100522995,-0.46666669100522995,-0.40000002086162567,-0.3333333507180214,-0.2666666805744171,-0.20000001043081284,-0.13333334028720856,-0.06666667014360428},"fftfreq/typed/float32/15/1: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/float32/15/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/float32/15/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float32/15/1: result: dtype")
eq(spacing:tolist(),1.0,"fftfreq/typed/float32/15/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/15/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/15/1: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/15/1: spacing state: dtype")
cases=cases+1
end
-- 294: fftfreq/typed/float32/15/2
do
local spacing=np.array(2.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/float32/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.03333333507180214,0.06666667014360428,0.10000000521540642,0.13333334028720856,0.1666666753590107,0.20000001043081284,0.23333334550261497,-0.23333334550261497,-0.20000001043081284,-0.1666666753590107,-0.13333334028720856,-0.10000000521540642,-0.06666667014360428,-0.03333333507180214},"fftfreq/typed/float32/15/2: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/float32/15/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/float32/15/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float32/15/2: result: dtype")
eq(spacing:tolist(),2.0,"fftfreq/typed/float32/15/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/15/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/15/2: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/15/2: spacing state: dtype")
cases=cases+1
end
-- 295: fftfreq/typed/float32/127/0
do
local spacing=np.array(0.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/float32/127/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/float32/127/0: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/float32/127/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/float32/127/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float32/127/0: result: dtype")
eq(spacing:tolist(),0.0,"fftfreq/typed/float32/127/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/127/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/127/0: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/127/0: spacing state: dtype")
cases=cases+1
end
-- 296: fftfreq/typed/float32/127/1
do
local spacing=np.array(1.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/float32/127/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.007874015718698502,0.015748031437397003,0.023622047156095505,0.031496062874794006,0.03937007859349251,0.04724409431219101,0.05511811003088951,0.06299212574958801,0.07086614146828651,0.07874015718698502,0.08661417290568352,0.09448818862438202,0.10236220434308052,0.11023622006177902,0.11811023578047752,0.12598425149917603,0.13385826721787453,0.14173228293657303,0.14960629865527153,0.15748031437397003,0.16535433009266853,0.17322834581136703,0.18110236153006554,0.18897637724876404,0.19685039296746254,0.20472440868616104,0.21259842440485954,0.22047244012355804,0.22834645584225655,0.23622047156095505,0.24409448727965355,0.25196850299835205,0.25984251871705055,0.26771653443574905,0.27559055015444756,0.28346456587314606,0.29133858159184456,0.29921259731054306,0.30708661302924156,0.31496062874794006,0.32283464446663857,0.33070866018533707,0.33858267590403557,0.34645669162273407,0.35433070734143257,0.3622047230601311,0.3700787387788296,0.3779527544975281,0.3858267702162266,0.3937007859349251,0.4015748016536236,0.4094488173723221,0.4173228330910206,0.4251968488097191,0.4330708645284176,0.4409448802471161,0.4488188959658146,0.4566929116845131,0.4645669274032116,0.4724409431219101,0.4803149588406086,0.4881889745593071,0.4960629902780056,-0.4960629902780056,-0.4881889745593071,-0.4803149588406086,-0.4724409431219101,-0.4645669274032116,-0.4566929116845131,-0.4488188959658146,-0.4409448802471161,-0.4330708645284176,-0.4251968488097191,-0.4173228330910206,-0.4094488173723221,-0.4015748016536236,-0.3937007859349251,-0.3858267702162266,-0.3779527544975281,-0.3700787387788296,-0.3622047230601311,-0.35433070734143257,-0.34645669162273407,-0.33858267590403557,-0.33070866018533707,-0.32283464446663857,-0.31496062874794006,-0.30708661302924156,-0.29921259731054306,-0.29133858159184456,-0.28346456587314606,-0.27559055015444756,-0.26771653443574905,-0.25984251871705055,-0.25196850299835205,-0.24409448727965355,-0.23622047156095505,-0.22834645584225655,-0.22047244012355804,-0.21259842440485954,-0.20472440868616104,-0.19685039296746254,-0.18897637724876404,-0.18110236153006554,-0.17322834581136703,-0.16535433009266853,-0.15748031437397003,-0.14960629865527153,-0.14173228293657303,-0.13385826721787453,-0.12598425149917603,-0.11811023578047752,-0.11023622006177902,-0.10236220434308052,-0.09448818862438202,-0.08661417290568352,-0.07874015718698502,-0.07086614146828651,-0.06299212574958801,-0.05511811003088951,-0.04724409431219101,-0.03937007859349251,-0.031496062874794006,-0.023622047156095505,-0.015748031437397003,-0.007874015718698502},"fftfreq/typed/float32/127/1: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/float32/127/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/float32/127/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float32/127/1: result: dtype")
eq(spacing:tolist(),1.0,"fftfreq/typed/float32/127/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/127/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/127/1: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/127/1: spacing state: dtype")
cases=cases+1
end
-- 297: fftfreq/typed/float32/127/2
do
local spacing=np.array(2.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/float32/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.003937007859349251,0.007874015718698502,0.011811023578047752,0.015748031437397003,0.019685039296746254,0.023622047156095505,0.027559055015444756,0.031496062874794006,0.03543307073414326,0.03937007859349251,0.04330708645284176,0.04724409431219101,0.05118110217154026,0.05511811003088951,0.05905511789023876,0.06299212574958801,0.06692913360893726,0.07086614146828651,0.07480314932763577,0.07874015718698502,0.08267716504633427,0.08661417290568352,0.09055118076503277,0.09448818862438202,0.09842519648373127,0.10236220434308052,0.10629921220242977,0.11023622006177902,0.11417322792112827,0.11811023578047752,0.12204724363982677,0.12598425149917603,0.12992125935852528,0.13385826721787453,0.13779527507722378,0.14173228293657303,0.14566929079592228,0.14960629865527153,0.15354330651462078,0.15748031437397003,0.16141732223331928,0.16535433009266853,0.16929133795201778,0.17322834581136703,0.17716535367071629,0.18110236153006554,0.1850393693894148,0.18897637724876404,0.1929133851081133,0.19685039296746254,0.2007874008268118,0.20472440868616104,0.2086614165455103,0.21259842440485954,0.2165354322642088,0.22047244012355804,0.2244094479829073,0.22834645584225655,0.2322834637016058,0.23622047156095505,0.2401574794203043,0.24409448727965355,0.2480314951390028,-0.2480314951390028,-0.24409448727965355,-0.2401574794203043,-0.23622047156095505,-0.2322834637016058,-0.22834645584225655,-0.2244094479829073,-0.22047244012355804,-0.2165354322642088,-0.21259842440485954,-0.2086614165455103,-0.20472440868616104,-0.2007874008268118,-0.19685039296746254,-0.1929133851081133,-0.18897637724876404,-0.1850393693894148,-0.18110236153006554,-0.17716535367071629,-0.17322834581136703,-0.16929133795201778,-0.16535433009266853,-0.16141732223331928,-0.15748031437397003,-0.15354330651462078,-0.14960629865527153,-0.14566929079592228,-0.14173228293657303,-0.13779527507722378,-0.13385826721787453,-0.12992125935852528,-0.12598425149917603,-0.12204724363982677,-0.11811023578047752,-0.11417322792112827,-0.11023622006177902,-0.10629921220242977,-0.10236220434308052,-0.09842519648373127,-0.09448818862438202,-0.09055118076503277,-0.08661417290568352,-0.08267716504633427,-0.07874015718698502,-0.07480314932763577,-0.07086614146828651,-0.06692913360893726,-0.06299212574958801,-0.05905511789023876,-0.05511811003088951,-0.05118110217154026,-0.04724409431219101,-0.04330708645284176,-0.03937007859349251,-0.03543307073414326,-0.031496062874794006,-0.027559055015444756,-0.023622047156095505,-0.019685039296746254,-0.015748031437397003,-0.011811023578047752,-0.007874015718698502,-0.003937007859349251},"fftfreq/typed/float32/127/2: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/float32/127/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/float32/127/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float32/127/2: result: dtype")
eq(spacing:tolist(),2.0,"fftfreq/typed/float32/127/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/127/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/127/2: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/127/2: spacing state: dtype")
cases=cases+1
end
-- 298: fftfreq/typed/float32/128/0
do
local spacing=np.array(0.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/float32/128/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/float32/128/0: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/float32/128/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/float32/128/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float32/128/0: result: dtype")
eq(spacing:tolist(),0.0,"fftfreq/typed/float32/128/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/128/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/128/0: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/128/0: spacing state: dtype")
cases=cases+1
end
-- 299: fftfreq/typed/float32/128/1
do
local spacing=np.array(1.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/float32/128/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0078125,0.015625,0.0234375,0.03125,0.0390625,0.046875,0.0546875,0.0625,0.0703125,0.078125,0.0859375,0.09375,0.1015625,0.109375,0.1171875,0.125,0.1328125,0.140625,0.1484375,0.15625,0.1640625,0.171875,0.1796875,0.1875,0.1953125,0.203125,0.2109375,0.21875,0.2265625,0.234375,0.2421875,0.25,0.2578125,0.265625,0.2734375,0.28125,0.2890625,0.296875,0.3046875,0.3125,0.3203125,0.328125,0.3359375,0.34375,0.3515625,0.359375,0.3671875,0.375,0.3828125,0.390625,0.3984375,0.40625,0.4140625,0.421875,0.4296875,0.4375,0.4453125,0.453125,0.4609375,0.46875,0.4765625,0.484375,0.4921875,-0.5,-0.4921875,-0.484375,-0.4765625,-0.46875,-0.4609375,-0.453125,-0.4453125,-0.4375,-0.4296875,-0.421875,-0.4140625,-0.40625,-0.3984375,-0.390625,-0.3828125,-0.375,-0.3671875,-0.359375,-0.3515625,-0.34375,-0.3359375,-0.328125,-0.3203125,-0.3125,-0.3046875,-0.296875,-0.2890625,-0.28125,-0.2734375,-0.265625,-0.2578125,-0.25,-0.2421875,-0.234375,-0.2265625,-0.21875,-0.2109375,-0.203125,-0.1953125,-0.1875,-0.1796875,-0.171875,-0.1640625,-0.15625,-0.1484375,-0.140625,-0.1328125,-0.125,-0.1171875,-0.109375,-0.1015625,-0.09375,-0.0859375,-0.078125,-0.0703125,-0.0625,-0.0546875,-0.046875,-0.0390625,-0.03125,-0.0234375,-0.015625,-0.0078125},"fftfreq/typed/float32/128/1: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/float32/128/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/float32/128/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float32/128/1: result: dtype")
eq(spacing:tolist(),1.0,"fftfreq/typed/float32/128/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/128/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/128/1: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/128/1: spacing state: dtype")
cases=cases+1
end
-- 300: fftfreq/typed/float32/128/2
do
local spacing=np.array(2.0,"float32")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/float32/128/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.00390625,0.0078125,0.01171875,0.015625,0.01953125,0.0234375,0.02734375,0.03125,0.03515625,0.0390625,0.04296875,0.046875,0.05078125,0.0546875,0.05859375,0.0625,0.06640625,0.0703125,0.07421875,0.078125,0.08203125,0.0859375,0.08984375,0.09375,0.09765625,0.1015625,0.10546875,0.109375,0.11328125,0.1171875,0.12109375,0.125,0.12890625,0.1328125,0.13671875,0.140625,0.14453125,0.1484375,0.15234375,0.15625,0.16015625,0.1640625,0.16796875,0.171875,0.17578125,0.1796875,0.18359375,0.1875,0.19140625,0.1953125,0.19921875,0.203125,0.20703125,0.2109375,0.21484375,0.21875,0.22265625,0.2265625,0.23046875,0.234375,0.23828125,0.2421875,0.24609375,-0.25,-0.24609375,-0.2421875,-0.23828125,-0.234375,-0.23046875,-0.2265625,-0.22265625,-0.21875,-0.21484375,-0.2109375,-0.20703125,-0.203125,-0.19921875,-0.1953125,-0.19140625,-0.1875,-0.18359375,-0.1796875,-0.17578125,-0.171875,-0.16796875,-0.1640625,-0.16015625,-0.15625,-0.15234375,-0.1484375,-0.14453125,-0.140625,-0.13671875,-0.1328125,-0.12890625,-0.125,-0.12109375,-0.1171875,-0.11328125,-0.109375,-0.10546875,-0.1015625,-0.09765625,-0.09375,-0.08984375,-0.0859375,-0.08203125,-0.078125,-0.07421875,-0.0703125,-0.06640625,-0.0625,-0.05859375,-0.0546875,-0.05078125,-0.046875,-0.04296875,-0.0390625,-0.03515625,-0.03125,-0.02734375,-0.0234375,-0.01953125,-0.015625,-0.01171875,-0.0078125,-0.00390625},"fftfreq/typed/float32/128/2: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/float32/128/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/float32/128/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float32/128/2: result: dtype")
eq(spacing:tolist(),2.0,"fftfreq/typed/float32/128/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float32/128/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float32/128/2: spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/typed/float32/128/2: spacing state: dtype")
cases=cases+1
end
-- 301: fftfreq/typed/float64/-1/0
do
local spacing=np.array(0.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/float64/-1/0: acceptance"..": "..tostring(result))
eq(spacing:tolist(),0.0,"fftfreq/typed/float64/-1/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/-1/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/-1/0: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/-1/0: spacing state: dtype")
cases=cases+1
end
-- 302: fftfreq/typed/float64/-1/1
do
local spacing=np.array(1.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/float64/-1/1: acceptance"..": "..tostring(result))
eq(spacing:tolist(),1.0,"fftfreq/typed/float64/-1/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/-1/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/-1/1: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/-1/1: spacing state: dtype")
cases=cases+1
end
-- 303: fftfreq/typed/float64/-1/2
do
local spacing=np.array(2.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/float64/-1/2: acceptance"..": "..tostring(result))
eq(spacing:tolist(),2.0,"fftfreq/typed/float64/-1/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/-1/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/-1/2: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/-1/2: spacing state: dtype")
cases=cases+1
end
-- 304: fftfreq/typed/float64/0/0
do
local spacing=np.array(0.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/float64/0/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/float64/0/0: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/float64/0/0: result: shape")
eq(result.strides,{0},"fftfreq/typed/float64/0/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float64/0/0: result: dtype")
eq(spacing:tolist(),0.0,"fftfreq/typed/float64/0/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/0/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/0/0: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/0/0: spacing state: dtype")
cases=cases+1
end
-- 305: fftfreq/typed/float64/0/1
do
local spacing=np.array(1.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/float64/0/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/float64/0/1: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/float64/0/1: result: shape")
eq(result.strides,{0},"fftfreq/typed/float64/0/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float64/0/1: result: dtype")
eq(spacing:tolist(),1.0,"fftfreq/typed/float64/0/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/0/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/0/1: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/0/1: spacing state: dtype")
cases=cases+1
end
-- 306: fftfreq/typed/float64/0/2
do
local spacing=np.array(2.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/float64/0/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/float64/0/2: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/float64/0/2: result: shape")
eq(result.strides,{0},"fftfreq/typed/float64/0/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float64/0/2: result: dtype")
eq(spacing:tolist(),2.0,"fftfreq/typed/float64/0/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/0/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/0/2: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/0/2: spacing state: dtype")
cases=cases+1
end
-- 307: fftfreq/typed/float64/1/0
do
local spacing=np.array(0.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/float64/1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"fftfreq/typed/float64/1/0: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/float64/1/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/float64/1/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float64/1/0: result: dtype")
eq(spacing:tolist(),0.0,"fftfreq/typed/float64/1/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/1/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/1/0: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/1/0: spacing state: dtype")
cases=cases+1
end
-- 308: fftfreq/typed/float64/1/1
do
local spacing=np.array(1.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/float64/1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"fftfreq/typed/float64/1/1: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/float64/1/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/float64/1/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float64/1/1: result: dtype")
eq(spacing:tolist(),1.0,"fftfreq/typed/float64/1/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/1/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/1/1: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/1/1: spacing state: dtype")
cases=cases+1
end
-- 309: fftfreq/typed/float64/1/2
do
local spacing=np.array(2.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/float64/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"fftfreq/typed/float64/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/float64/1/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/float64/1/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float64/1/2: result: dtype")
eq(spacing:tolist(),2.0,"fftfreq/typed/float64/1/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/1/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/1/2: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/1/2: spacing state: dtype")
cases=cases+1
end
-- 310: fftfreq/typed/float64/3/0
do
local spacing=np.array(0.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/float64/3/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,-math.huge},"fftfreq/typed/float64/3/0: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/float64/3/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/float64/3/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float64/3/0: result: dtype")
eq(spacing:tolist(),0.0,"fftfreq/typed/float64/3/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/3/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/3/0: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/3/0: spacing state: dtype")
cases=cases+1
end
-- 311: fftfreq/typed/float64/3/1
do
local spacing=np.array(1.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/float64/3/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.3333333333333333,-0.3333333333333333},"fftfreq/typed/float64/3/1: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/float64/3/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/float64/3/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float64/3/1: result: dtype")
eq(spacing:tolist(),1.0,"fftfreq/typed/float64/3/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/3/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/3/1: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/3/1: spacing state: dtype")
cases=cases+1
end
-- 312: fftfreq/typed/float64/3/2
do
local spacing=np.array(2.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/float64/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.16666666666666666,-0.16666666666666666},"fftfreq/typed/float64/3/2: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/float64/3/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/float64/3/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float64/3/2: result: dtype")
eq(spacing:tolist(),2.0,"fftfreq/typed/float64/3/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/3/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/3/2: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/3/2: spacing state: dtype")
cases=cases+1
end
-- 313: fftfreq/typed/float64/4/0
do
local spacing=np.array(0.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/float64/4/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,-math.huge,-math.huge},"fftfreq/typed/float64/4/0: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/float64/4/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/float64/4/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float64/4/0: result: dtype")
eq(spacing:tolist(),0.0,"fftfreq/typed/float64/4/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/4/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/4/0: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/4/0: spacing state: dtype")
cases=cases+1
end
-- 314: fftfreq/typed/float64/4/1
do
local spacing=np.array(1.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/float64/4/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,-0.5,-0.25},"fftfreq/typed/float64/4/1: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/float64/4/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/float64/4/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float64/4/1: result: dtype")
eq(spacing:tolist(),1.0,"fftfreq/typed/float64/4/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/4/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/4/1: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/4/1: spacing state: dtype")
cases=cases+1
end
-- 315: fftfreq/typed/float64/4/2
do
local spacing=np.array(2.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/float64/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.125,-0.25,-0.125},"fftfreq/typed/float64/4/2: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/float64/4/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/float64/4/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float64/4/2: result: dtype")
eq(spacing:tolist(),2.0,"fftfreq/typed/float64/4/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/4/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/4/2: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/4/2: spacing state: dtype")
cases=cases+1
end
-- 316: fftfreq/typed/float64/15/0
do
local spacing=np.array(0.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/float64/15/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/float64/15/0: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/float64/15/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/float64/15/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float64/15/0: result: dtype")
eq(spacing:tolist(),0.0,"fftfreq/typed/float64/15/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/15/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/15/0: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/15/0: spacing state: dtype")
cases=cases+1
end
-- 317: fftfreq/typed/float64/15/1
do
local spacing=np.array(1.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/float64/15/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.06666666666666667,0.13333333333333333,0.2,0.26666666666666666,0.3333333333333333,0.4,0.4666666666666667,-0.4666666666666667,-0.4,-0.3333333333333333,-0.26666666666666666,-0.2,-0.13333333333333333,-0.06666666666666667},"fftfreq/typed/float64/15/1: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/float64/15/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/float64/15/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float64/15/1: result: dtype")
eq(spacing:tolist(),1.0,"fftfreq/typed/float64/15/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/15/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/15/1: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/15/1: spacing state: dtype")
cases=cases+1
end
-- 318: fftfreq/typed/float64/15/2
do
local spacing=np.array(2.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/float64/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.03333333333333333,0.06666666666666667,0.1,0.13333333333333333,0.16666666666666666,0.2,0.23333333333333334,-0.23333333333333334,-0.2,-0.16666666666666666,-0.13333333333333333,-0.1,-0.06666666666666667,-0.03333333333333333},"fftfreq/typed/float64/15/2: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/float64/15/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/float64/15/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float64/15/2: result: dtype")
eq(spacing:tolist(),2.0,"fftfreq/typed/float64/15/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/15/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/15/2: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/15/2: spacing state: dtype")
cases=cases+1
end
-- 319: fftfreq/typed/float64/127/0
do
local spacing=np.array(0.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/float64/127/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/float64/127/0: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/float64/127/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/float64/127/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float64/127/0: result: dtype")
eq(spacing:tolist(),0.0,"fftfreq/typed/float64/127/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/127/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/127/0: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/127/0: spacing state: dtype")
cases=cases+1
end
-- 320: fftfreq/typed/float64/127/1
do
local spacing=np.array(1.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/float64/127/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.007874015748031496,0.015748031496062992,0.023622047244094488,0.031496062992125984,0.03937007874015748,0.047244094488188976,0.05511811023622047,0.06299212598425197,0.07086614173228346,0.07874015748031496,0.08661417322834646,0.09448818897637795,0.10236220472440945,0.11023622047244094,0.11811023622047244,0.12598425196850394,0.13385826771653542,0.14173228346456693,0.14960629921259844,0.15748031496062992,0.1653543307086614,0.1732283464566929,0.18110236220472442,0.1889763779527559,0.19685039370078738,0.2047244094488189,0.2125984251968504,0.2204724409448819,0.22834645669291337,0.23622047244094488,0.2440944881889764,0.25196850393700787,0.25984251968503935,0.26771653543307083,0.2755905511811024,0.28346456692913385,0.29133858267716534,0.2992125984251969,0.30708661417322836,0.31496062992125984,0.3228346456692913,0.3307086614173228,0.33858267716535434,0.3464566929133858,0.3543307086614173,0.36220472440944884,0.3700787401574803,0.3779527559055118,0.3858267716535433,0.39370078740157477,0.4015748031496063,0.4094488188976378,0.41732283464566927,0.4251968503937008,0.4330708661417323,0.4409448818897638,0.44881889763779526,0.45669291338582674,0.4645669291338583,0.47244094488188976,0.48031496062992124,0.4881889763779528,0.49606299212598426,-0.49606299212598426,-0.4881889763779528,-0.48031496062992124,-0.47244094488188976,-0.4645669291338583,-0.45669291338582674,-0.44881889763779526,-0.4409448818897638,-0.4330708661417323,-0.4251968503937008,-0.41732283464566927,-0.4094488188976378,-0.4015748031496063,-0.39370078740157477,-0.3858267716535433,-0.3779527559055118,-0.3700787401574803,-0.36220472440944884,-0.3543307086614173,-0.3464566929133858,-0.33858267716535434,-0.3307086614173228,-0.3228346456692913,-0.31496062992125984,-0.30708661417322836,-0.2992125984251969,-0.29133858267716534,-0.28346456692913385,-0.2755905511811024,-0.26771653543307083,-0.25984251968503935,-0.25196850393700787,-0.2440944881889764,-0.23622047244094488,-0.22834645669291337,-0.2204724409448819,-0.2125984251968504,-0.2047244094488189,-0.19685039370078738,-0.1889763779527559,-0.18110236220472442,-0.1732283464566929,-0.1653543307086614,-0.15748031496062992,-0.14960629921259844,-0.14173228346456693,-0.13385826771653542,-0.12598425196850394,-0.11811023622047244,-0.11023622047244094,-0.10236220472440945,-0.09448818897637795,-0.08661417322834646,-0.07874015748031496,-0.07086614173228346,-0.06299212598425197,-0.05511811023622047,-0.047244094488188976,-0.03937007874015748,-0.031496062992125984,-0.023622047244094488,-0.015748031496062992,-0.007874015748031496},"fftfreq/typed/float64/127/1: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/float64/127/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/float64/127/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float64/127/1: result: dtype")
eq(spacing:tolist(),1.0,"fftfreq/typed/float64/127/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/127/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/127/1: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/127/1: spacing state: dtype")
cases=cases+1
end
-- 321: fftfreq/typed/float64/127/2
do
local spacing=np.array(2.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/float64/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.003937007874015748,0.007874015748031496,0.011811023622047244,0.015748031496062992,0.01968503937007874,0.023622047244094488,0.027559055118110236,0.031496062992125984,0.03543307086614173,0.03937007874015748,0.04330708661417323,0.047244094488188976,0.051181102362204724,0.05511811023622047,0.05905511811023622,0.06299212598425197,0.06692913385826771,0.07086614173228346,0.07480314960629922,0.07874015748031496,0.0826771653543307,0.08661417322834646,0.09055118110236221,0.09448818897637795,0.09842519685039369,0.10236220472440945,0.1062992125984252,0.11023622047244094,0.11417322834645668,0.11811023622047244,0.1220472440944882,0.12598425196850394,0.12992125984251968,0.13385826771653542,0.1377952755905512,0.14173228346456693,0.14566929133858267,0.14960629921259844,0.15354330708661418,0.15748031496062992,0.16141732283464566,0.1653543307086614,0.16929133858267717,0.1732283464566929,0.17716535433070865,0.18110236220472442,0.18503937007874016,0.1889763779527559,0.19291338582677164,0.19685039370078738,0.20078740157480315,0.2047244094488189,0.20866141732283464,0.2125984251968504,0.21653543307086615,0.2204724409448819,0.22440944881889763,0.22834645669291337,0.23228346456692914,0.23622047244094488,0.24015748031496062,0.2440944881889764,0.24803149606299213,-0.24803149606299213,-0.2440944881889764,-0.24015748031496062,-0.23622047244094488,-0.23228346456692914,-0.22834645669291337,-0.22440944881889763,-0.2204724409448819,-0.21653543307086615,-0.2125984251968504,-0.20866141732283464,-0.2047244094488189,-0.20078740157480315,-0.19685039370078738,-0.19291338582677164,-0.1889763779527559,-0.18503937007874016,-0.18110236220472442,-0.17716535433070865,-0.1732283464566929,-0.16929133858267717,-0.1653543307086614,-0.16141732283464566,-0.15748031496062992,-0.15354330708661418,-0.14960629921259844,-0.14566929133858267,-0.14173228346456693,-0.1377952755905512,-0.13385826771653542,-0.12992125984251968,-0.12598425196850394,-0.1220472440944882,-0.11811023622047244,-0.11417322834645668,-0.11023622047244094,-0.1062992125984252,-0.10236220472440945,-0.09842519685039369,-0.09448818897637795,-0.09055118110236221,-0.08661417322834646,-0.0826771653543307,-0.07874015748031496,-0.07480314960629922,-0.07086614173228346,-0.06692913385826771,-0.06299212598425197,-0.05905511811023622,-0.05511811023622047,-0.051181102362204724,-0.047244094488188976,-0.04330708661417323,-0.03937007874015748,-0.03543307086614173,-0.031496062992125984,-0.027559055118110236,-0.023622047244094488,-0.01968503937007874,-0.015748031496062992,-0.011811023622047244,-0.007874015748031496,-0.003937007874015748},"fftfreq/typed/float64/127/2: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/float64/127/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/float64/127/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float64/127/2: result: dtype")
eq(spacing:tolist(),2.0,"fftfreq/typed/float64/127/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/127/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/127/2: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/127/2: spacing state: dtype")
cases=cases+1
end
-- 322: fftfreq/typed/float64/128/0
do
local spacing=np.array(0.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/float64/128/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge,-math.huge},"fftfreq/typed/float64/128/0: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/float64/128/0: result: shape")
eq(result.strides,{8},"fftfreq/typed/float64/128/0: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float64/128/0: result: dtype")
eq(spacing:tolist(),0.0,"fftfreq/typed/float64/128/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/128/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/128/0: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/128/0: spacing state: dtype")
cases=cases+1
end
-- 323: fftfreq/typed/float64/128/1
do
local spacing=np.array(1.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/float64/128/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0078125,0.015625,0.0234375,0.03125,0.0390625,0.046875,0.0546875,0.0625,0.0703125,0.078125,0.0859375,0.09375,0.1015625,0.109375,0.1171875,0.125,0.1328125,0.140625,0.1484375,0.15625,0.1640625,0.171875,0.1796875,0.1875,0.1953125,0.203125,0.2109375,0.21875,0.2265625,0.234375,0.2421875,0.25,0.2578125,0.265625,0.2734375,0.28125,0.2890625,0.296875,0.3046875,0.3125,0.3203125,0.328125,0.3359375,0.34375,0.3515625,0.359375,0.3671875,0.375,0.3828125,0.390625,0.3984375,0.40625,0.4140625,0.421875,0.4296875,0.4375,0.4453125,0.453125,0.4609375,0.46875,0.4765625,0.484375,0.4921875,-0.5,-0.4921875,-0.484375,-0.4765625,-0.46875,-0.4609375,-0.453125,-0.4453125,-0.4375,-0.4296875,-0.421875,-0.4140625,-0.40625,-0.3984375,-0.390625,-0.3828125,-0.375,-0.3671875,-0.359375,-0.3515625,-0.34375,-0.3359375,-0.328125,-0.3203125,-0.3125,-0.3046875,-0.296875,-0.2890625,-0.28125,-0.2734375,-0.265625,-0.2578125,-0.25,-0.2421875,-0.234375,-0.2265625,-0.21875,-0.2109375,-0.203125,-0.1953125,-0.1875,-0.1796875,-0.171875,-0.1640625,-0.15625,-0.1484375,-0.140625,-0.1328125,-0.125,-0.1171875,-0.109375,-0.1015625,-0.09375,-0.0859375,-0.078125,-0.0703125,-0.0625,-0.0546875,-0.046875,-0.0390625,-0.03125,-0.0234375,-0.015625,-0.0078125},"fftfreq/typed/float64/128/1: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/float64/128/1: result: shape")
eq(result.strides,{8},"fftfreq/typed/float64/128/1: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float64/128/1: result: dtype")
eq(spacing:tolist(),1.0,"fftfreq/typed/float64/128/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/128/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/128/1: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/128/1: spacing state: dtype")
cases=cases+1
end
-- 324: fftfreq/typed/float64/128/2
do
local spacing=np.array(2.0,"float64")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/float64/128/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.00390625,0.0078125,0.01171875,0.015625,0.01953125,0.0234375,0.02734375,0.03125,0.03515625,0.0390625,0.04296875,0.046875,0.05078125,0.0546875,0.05859375,0.0625,0.06640625,0.0703125,0.07421875,0.078125,0.08203125,0.0859375,0.08984375,0.09375,0.09765625,0.1015625,0.10546875,0.109375,0.11328125,0.1171875,0.12109375,0.125,0.12890625,0.1328125,0.13671875,0.140625,0.14453125,0.1484375,0.15234375,0.15625,0.16015625,0.1640625,0.16796875,0.171875,0.17578125,0.1796875,0.18359375,0.1875,0.19140625,0.1953125,0.19921875,0.203125,0.20703125,0.2109375,0.21484375,0.21875,0.22265625,0.2265625,0.23046875,0.234375,0.23828125,0.2421875,0.24609375,-0.25,-0.24609375,-0.2421875,-0.23828125,-0.234375,-0.23046875,-0.2265625,-0.22265625,-0.21875,-0.21484375,-0.2109375,-0.20703125,-0.203125,-0.19921875,-0.1953125,-0.19140625,-0.1875,-0.18359375,-0.1796875,-0.17578125,-0.171875,-0.16796875,-0.1640625,-0.16015625,-0.15625,-0.15234375,-0.1484375,-0.14453125,-0.140625,-0.13671875,-0.1328125,-0.12890625,-0.125,-0.12109375,-0.1171875,-0.11328125,-0.109375,-0.10546875,-0.1015625,-0.09765625,-0.09375,-0.08984375,-0.0859375,-0.08203125,-0.078125,-0.07421875,-0.0703125,-0.06640625,-0.0625,-0.05859375,-0.0546875,-0.05078125,-0.046875,-0.04296875,-0.0390625,-0.03515625,-0.03125,-0.02734375,-0.0234375,-0.01953125,-0.015625,-0.01171875,-0.0078125,-0.00390625},"fftfreq/typed/float64/128/2: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/float64/128/2: result: shape")
eq(result.strides,{8},"fftfreq/typed/float64/128/2: result: strides")
eq(result.dtype,"float64","fftfreq/typed/float64/128/2: result: dtype")
eq(spacing:tolist(),2.0,"fftfreq/typed/float64/128/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/float64/128/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/float64/128/2: spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/typed/float64/128/2: spacing state: dtype")
cases=cases+1
end
-- 325: fftfreq/typed/complex64/-1/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/complex64/-1/0: acceptance"..": "..tostring(result))
eq(spacing:tolist(),np.complex(0.0,0.0),"fftfreq/typed/complex64/-1/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/-1/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/-1/0: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/-1/0: spacing state: dtype")
cases=cases+1
end
-- 326: fftfreq/typed/complex64/-1/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/complex64/-1/1: acceptance"..": "..tostring(result))
eq(spacing:tolist(),np.complex(1.0,0.0),"fftfreq/typed/complex64/-1/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/-1/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/-1/1: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/-1/1: spacing state: dtype")
cases=cases+1
end
-- 327: fftfreq/typed/complex64/-1/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/complex64/-1/2: acceptance"..": "..tostring(result))
eq(spacing:tolist(),np.complex(2.0,0.0),"fftfreq/typed/complex64/-1/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/-1/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/-1/2: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/-1/2: spacing state: dtype")
cases=cases+1
end
-- 328: fftfreq/typed/complex64/0/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/complex64/0/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/complex64/0/0: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/complex64/0/0: result: shape")
eq(result.strides,{0},"fftfreq/typed/complex64/0/0: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex64/0/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"fftfreq/typed/complex64/0/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/0/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/0/0: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/0/0: spacing state: dtype")
cases=cases+1
end
-- 329: fftfreq/typed/complex64/0/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/complex64/0/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/complex64/0/1: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/complex64/0/1: result: shape")
eq(result.strides,{0},"fftfreq/typed/complex64/0/1: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex64/0/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"fftfreq/typed/complex64/0/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/0/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/0/1: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/0/1: spacing state: dtype")
cases=cases+1
end
-- 330: fftfreq/typed/complex64/0/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/complex64/0/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/complex64/0/2: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/complex64/0/2: result: shape")
eq(result.strides,{0},"fftfreq/typed/complex64/0/2: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex64/0/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"fftfreq/typed/complex64/0/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/0/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/0/2: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/0/2: spacing state: dtype")
cases=cases+1
end
-- 331: fftfreq/typed/complex64/1/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/complex64/1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0))},"fftfreq/typed/complex64/1/0: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/complex64/1/0: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex64/1/0: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex64/1/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"fftfreq/typed/complex64/1/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/1/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/1/0: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/1/0: spacing state: dtype")
cases=cases+1
end
-- 332: fftfreq/typed/complex64/1/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/complex64/1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"fftfreq/typed/complex64/1/1: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/complex64/1/1: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex64/1/1: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex64/1/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"fftfreq/typed/complex64/1/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/1/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/1/1: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/1/1: spacing state: dtype")
cases=cases+1
end
-- 333: fftfreq/typed/complex64/1/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/complex64/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"fftfreq/typed/complex64/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/complex64/1/2: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex64/1/2: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex64/1/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"fftfreq/typed/complex64/1/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/1/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/1/2: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/1/2: spacing state: dtype")
cases=cases+1
end
-- 334: fftfreq/typed/complex64/3/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/complex64/3/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},"fftfreq/typed/complex64/3/0: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/complex64/3/0: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex64/3/0: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex64/3/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"fftfreq/typed/complex64/3/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/3/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/3/0: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/3/0: spacing state: dtype")
cases=cases+1
end
-- 335: fftfreq/typed/complex64/3/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/complex64/3/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.3333333432674408,0.0),np.complex(-0.3333333432674408,0.0)},"fftfreq/typed/complex64/3/1: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/complex64/3/1: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex64/3/1: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex64/3/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"fftfreq/typed/complex64/3/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/3/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/3/1: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/3/1: spacing state: dtype")
cases=cases+1
end
-- 336: fftfreq/typed/complex64/3/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/complex64/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.1666666716337204,0.0),np.complex(-0.1666666716337204,0.0)},"fftfreq/typed/complex64/3/2: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/complex64/3/2: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex64/3/2: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex64/3/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"fftfreq/typed/complex64/3/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/3/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/3/2: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/3/2: spacing state: dtype")
cases=cases+1
end
-- 337: fftfreq/typed/complex64/4/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/complex64/4/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},"fftfreq/typed/complex64/4/0: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/complex64/4/0: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex64/4/0: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex64/4/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"fftfreq/typed/complex64/4/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/4/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/4/0: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/4/0: spacing state: dtype")
cases=cases+1
end
-- 338: fftfreq/typed/complex64/4/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/complex64/4/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.25,0.0),np.complex(-0.5,0.0),np.complex(-0.25,0.0)},"fftfreq/typed/complex64/4/1: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/complex64/4/1: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex64/4/1: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex64/4/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"fftfreq/typed/complex64/4/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/4/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/4/1: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/4/1: spacing state: dtype")
cases=cases+1
end
-- 339: fftfreq/typed/complex64/4/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/complex64/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.125,0.0),np.complex(-0.25,0.0),np.complex(-0.125,0.0)},"fftfreq/typed/complex64/4/2: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/complex64/4/2: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex64/4/2: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex64/4/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"fftfreq/typed/complex64/4/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/4/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/4/2: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/4/2: spacing state: dtype")
cases=cases+1
end
-- 340: fftfreq/typed/complex64/15/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/complex64/15/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},"fftfreq/typed/complex64/15/0: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/complex64/15/0: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex64/15/0: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex64/15/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"fftfreq/typed/complex64/15/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/15/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/15/0: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/15/0: spacing state: dtype")
cases=cases+1
end
-- 341: fftfreq/typed/complex64/15/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/complex64/15/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.06666667014360428,0.0),np.complex(0.13333334028720856,0.0),np.complex(0.20000001043081284,0.0),np.complex(0.2666666805744171,0.0),np.complex(0.3333333507180214,0.0),np.complex(0.40000002086162567,0.0),np.complex(0.46666669100522995,0.0),np.complex(-0.46666669100522995,0.0),np.complex(-0.40000002086162567,0.0),np.complex(-0.3333333507180214,0.0),np.complex(-0.2666666805744171,0.0),np.complex(-0.20000001043081284,0.0),np.complex(-0.13333334028720856,0.0),np.complex(-0.06666667014360428,0.0)},"fftfreq/typed/complex64/15/1: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/complex64/15/1: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex64/15/1: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex64/15/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"fftfreq/typed/complex64/15/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/15/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/15/1: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/15/1: spacing state: dtype")
cases=cases+1
end
-- 342: fftfreq/typed/complex64/15/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/complex64/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.03333333507180214,0.0),np.complex(0.06666667014360428,0.0),np.complex(0.10000000521540642,0.0),np.complex(0.13333334028720856,0.0),np.complex(0.1666666753590107,0.0),np.complex(0.20000001043081284,0.0),np.complex(0.23333334550261497,0.0),np.complex(-0.23333334550261497,0.0),np.complex(-0.20000001043081284,0.0),np.complex(-0.1666666753590107,0.0),np.complex(-0.13333334028720856,0.0),np.complex(-0.10000000521540642,0.0),np.complex(-0.06666667014360428,0.0),np.complex(-0.03333333507180214,0.0)},"fftfreq/typed/complex64/15/2: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/complex64/15/2: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex64/15/2: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex64/15/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"fftfreq/typed/complex64/15/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/15/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/15/2: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/15/2: spacing state: dtype")
cases=cases+1
end
-- 343: fftfreq/typed/complex64/127/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/complex64/127/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},"fftfreq/typed/complex64/127/0: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/complex64/127/0: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex64/127/0: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex64/127/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"fftfreq/typed/complex64/127/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/127/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/127/0: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/127/0: spacing state: dtype")
cases=cases+1
end
-- 344: fftfreq/typed/complex64/127/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/complex64/127/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.007874015718698502,0.0),np.complex(0.015748031437397003,0.0),np.complex(0.023622047156095505,0.0),np.complex(0.031496062874794006,0.0),np.complex(0.03937007859349251,0.0),np.complex(0.04724409431219101,0.0),np.complex(0.05511811003088951,0.0),np.complex(0.06299212574958801,0.0),np.complex(0.07086614146828651,0.0),np.complex(0.07874015718698502,0.0),np.complex(0.08661417290568352,0.0),np.complex(0.09448818862438202,0.0),np.complex(0.10236220434308052,0.0),np.complex(0.11023622006177902,0.0),np.complex(0.11811023578047752,0.0),np.complex(0.12598425149917603,0.0),np.complex(0.13385826721787453,0.0),np.complex(0.14173228293657303,0.0),np.complex(0.14960629865527153,0.0),np.complex(0.15748031437397003,0.0),np.complex(0.16535433009266853,0.0),np.complex(0.17322834581136703,0.0),np.complex(0.18110236153006554,0.0),np.complex(0.18897637724876404,0.0),np.complex(0.19685039296746254,0.0),np.complex(0.20472440868616104,0.0),np.complex(0.21259842440485954,0.0),np.complex(0.22047244012355804,0.0),np.complex(0.22834645584225655,0.0),np.complex(0.23622047156095505,0.0),np.complex(0.24409448727965355,0.0),np.complex(0.25196850299835205,0.0),np.complex(0.25984251871705055,0.0),np.complex(0.26771653443574905,0.0),np.complex(0.27559055015444756,0.0),np.complex(0.28346456587314606,0.0),np.complex(0.29133858159184456,0.0),np.complex(0.29921259731054306,0.0),np.complex(0.30708661302924156,0.0),np.complex(0.31496062874794006,0.0),np.complex(0.32283464446663857,0.0),np.complex(0.33070866018533707,0.0),np.complex(0.33858267590403557,0.0),np.complex(0.34645669162273407,0.0),np.complex(0.35433070734143257,0.0),np.complex(0.3622047230601311,0.0),np.complex(0.3700787387788296,0.0),np.complex(0.3779527544975281,0.0),np.complex(0.3858267702162266,0.0),np.complex(0.3937007859349251,0.0),np.complex(0.4015748016536236,0.0),np.complex(0.4094488173723221,0.0),np.complex(0.4173228330910206,0.0),np.complex(0.4251968488097191,0.0),np.complex(0.4330708645284176,0.0),np.complex(0.4409448802471161,0.0),np.complex(0.4488188959658146,0.0),np.complex(0.4566929116845131,0.0),np.complex(0.4645669274032116,0.0),np.complex(0.4724409431219101,0.0),np.complex(0.4803149588406086,0.0),np.complex(0.4881889745593071,0.0),np.complex(0.4960629902780056,0.0),np.complex(-0.4960629902780056,0.0),np.complex(-0.4881889745593071,0.0),np.complex(-0.4803149588406086,0.0),np.complex(-0.4724409431219101,0.0),np.complex(-0.4645669274032116,0.0),np.complex(-0.4566929116845131,0.0),np.complex(-0.4488188959658146,0.0),np.complex(-0.4409448802471161,0.0),np.complex(-0.4330708645284176,0.0),np.complex(-0.4251968488097191,0.0),np.complex(-0.4173228330910206,0.0),np.complex(-0.4094488173723221,0.0),np.complex(-0.4015748016536236,0.0),np.complex(-0.3937007859349251,0.0),np.complex(-0.3858267702162266,0.0),np.complex(-0.3779527544975281,0.0),np.complex(-0.3700787387788296,0.0),np.complex(-0.3622047230601311,0.0),np.complex(-0.35433070734143257,0.0),np.complex(-0.34645669162273407,0.0),np.complex(-0.33858267590403557,0.0),np.complex(-0.33070866018533707,0.0),np.complex(-0.32283464446663857,0.0),np.complex(-0.31496062874794006,0.0),np.complex(-0.30708661302924156,0.0),np.complex(-0.29921259731054306,0.0),np.complex(-0.29133858159184456,0.0),np.complex(-0.28346456587314606,0.0),np.complex(-0.27559055015444756,0.0),np.complex(-0.26771653443574905,0.0),np.complex(-0.25984251871705055,0.0),np.complex(-0.25196850299835205,0.0),np.complex(-0.24409448727965355,0.0),np.complex(-0.23622047156095505,0.0),np.complex(-0.22834645584225655,0.0),np.complex(-0.22047244012355804,0.0),np.complex(-0.21259842440485954,0.0),np.complex(-0.20472440868616104,0.0),np.complex(-0.19685039296746254,0.0),np.complex(-0.18897637724876404,0.0),np.complex(-0.18110236153006554,0.0),np.complex(-0.17322834581136703,0.0),np.complex(-0.16535433009266853,0.0),np.complex(-0.15748031437397003,0.0),np.complex(-0.14960629865527153,0.0),np.complex(-0.14173228293657303,0.0),np.complex(-0.13385826721787453,0.0),np.complex(-0.12598425149917603,0.0),np.complex(-0.11811023578047752,0.0),np.complex(-0.11023622006177902,0.0),np.complex(-0.10236220434308052,0.0),np.complex(-0.09448818862438202,0.0),np.complex(-0.08661417290568352,0.0),np.complex(-0.07874015718698502,0.0),np.complex(-0.07086614146828651,0.0),np.complex(-0.06299212574958801,0.0),np.complex(-0.05511811003088951,0.0),np.complex(-0.04724409431219101,0.0),np.complex(-0.03937007859349251,0.0),np.complex(-0.031496062874794006,0.0),np.complex(-0.023622047156095505,0.0),np.complex(-0.015748031437397003,0.0),np.complex(-0.007874015718698502,0.0)},"fftfreq/typed/complex64/127/1: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/complex64/127/1: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex64/127/1: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex64/127/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"fftfreq/typed/complex64/127/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/127/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/127/1: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/127/1: spacing state: dtype")
cases=cases+1
end
-- 345: fftfreq/typed/complex64/127/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/complex64/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.003937007859349251,0.0),np.complex(0.007874015718698502,0.0),np.complex(0.011811023578047752,0.0),np.complex(0.015748031437397003,0.0),np.complex(0.019685039296746254,0.0),np.complex(0.023622047156095505,0.0),np.complex(0.027559055015444756,0.0),np.complex(0.031496062874794006,0.0),np.complex(0.03543307073414326,0.0),np.complex(0.03937007859349251,0.0),np.complex(0.04330708645284176,0.0),np.complex(0.04724409431219101,0.0),np.complex(0.05118110217154026,0.0),np.complex(0.05511811003088951,0.0),np.complex(0.05905511789023876,0.0),np.complex(0.06299212574958801,0.0),np.complex(0.06692913360893726,0.0),np.complex(0.07086614146828651,0.0),np.complex(0.07480314932763577,0.0),np.complex(0.07874015718698502,0.0),np.complex(0.08267716504633427,0.0),np.complex(0.08661417290568352,0.0),np.complex(0.09055118076503277,0.0),np.complex(0.09448818862438202,0.0),np.complex(0.09842519648373127,0.0),np.complex(0.10236220434308052,0.0),np.complex(0.10629921220242977,0.0),np.complex(0.11023622006177902,0.0),np.complex(0.11417322792112827,0.0),np.complex(0.11811023578047752,0.0),np.complex(0.12204724363982677,0.0),np.complex(0.12598425149917603,0.0),np.complex(0.12992125935852528,0.0),np.complex(0.13385826721787453,0.0),np.complex(0.13779527507722378,0.0),np.complex(0.14173228293657303,0.0),np.complex(0.14566929079592228,0.0),np.complex(0.14960629865527153,0.0),np.complex(0.15354330651462078,0.0),np.complex(0.15748031437397003,0.0),np.complex(0.16141732223331928,0.0),np.complex(0.16535433009266853,0.0),np.complex(0.16929133795201778,0.0),np.complex(0.17322834581136703,0.0),np.complex(0.17716535367071629,0.0),np.complex(0.18110236153006554,0.0),np.complex(0.1850393693894148,0.0),np.complex(0.18897637724876404,0.0),np.complex(0.1929133851081133,0.0),np.complex(0.19685039296746254,0.0),np.complex(0.2007874008268118,0.0),np.complex(0.20472440868616104,0.0),np.complex(0.2086614165455103,0.0),np.complex(0.21259842440485954,0.0),np.complex(0.2165354322642088,0.0),np.complex(0.22047244012355804,0.0),np.complex(0.2244094479829073,0.0),np.complex(0.22834645584225655,0.0),np.complex(0.2322834637016058,0.0),np.complex(0.23622047156095505,0.0),np.complex(0.2401574794203043,0.0),np.complex(0.24409448727965355,0.0),np.complex(0.2480314951390028,0.0),np.complex(-0.2480314951390028,0.0),np.complex(-0.24409448727965355,0.0),np.complex(-0.2401574794203043,0.0),np.complex(-0.23622047156095505,0.0),np.complex(-0.2322834637016058,0.0),np.complex(-0.22834645584225655,0.0),np.complex(-0.2244094479829073,0.0),np.complex(-0.22047244012355804,0.0),np.complex(-0.2165354322642088,0.0),np.complex(-0.21259842440485954,0.0),np.complex(-0.2086614165455103,0.0),np.complex(-0.20472440868616104,0.0),np.complex(-0.2007874008268118,0.0),np.complex(-0.19685039296746254,0.0),np.complex(-0.1929133851081133,0.0),np.complex(-0.18897637724876404,0.0),np.complex(-0.1850393693894148,0.0),np.complex(-0.18110236153006554,0.0),np.complex(-0.17716535367071629,0.0),np.complex(-0.17322834581136703,0.0),np.complex(-0.16929133795201778,0.0),np.complex(-0.16535433009266853,0.0),np.complex(-0.16141732223331928,0.0),np.complex(-0.15748031437397003,0.0),np.complex(-0.15354330651462078,0.0),np.complex(-0.14960629865527153,0.0),np.complex(-0.14566929079592228,0.0),np.complex(-0.14173228293657303,0.0),np.complex(-0.13779527507722378,0.0),np.complex(-0.13385826721787453,0.0),np.complex(-0.12992125935852528,0.0),np.complex(-0.12598425149917603,0.0),np.complex(-0.12204724363982677,0.0),np.complex(-0.11811023578047752,0.0),np.complex(-0.11417322792112827,0.0),np.complex(-0.11023622006177902,0.0),np.complex(-0.10629921220242977,0.0),np.complex(-0.10236220434308052,0.0),np.complex(-0.09842519648373127,0.0),np.complex(-0.09448818862438202,0.0),np.complex(-0.09055118076503277,0.0),np.complex(-0.08661417290568352,0.0),np.complex(-0.08267716504633427,0.0),np.complex(-0.07874015718698502,0.0),np.complex(-0.07480314932763577,0.0),np.complex(-0.07086614146828651,0.0),np.complex(-0.06692913360893726,0.0),np.complex(-0.06299212574958801,0.0),np.complex(-0.05905511789023876,0.0),np.complex(-0.05511811003088951,0.0),np.complex(-0.05118110217154026,0.0),np.complex(-0.04724409431219101,0.0),np.complex(-0.04330708645284176,0.0),np.complex(-0.03937007859349251,0.0),np.complex(-0.03543307073414326,0.0),np.complex(-0.031496062874794006,0.0),np.complex(-0.027559055015444756,0.0),np.complex(-0.023622047156095505,0.0),np.complex(-0.019685039296746254,0.0),np.complex(-0.015748031437397003,0.0),np.complex(-0.011811023578047752,0.0),np.complex(-0.007874015718698502,0.0),np.complex(-0.003937007859349251,0.0)},"fftfreq/typed/complex64/127/2: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/complex64/127/2: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex64/127/2: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex64/127/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"fftfreq/typed/complex64/127/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/127/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/127/2: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/127/2: spacing state: dtype")
cases=cases+1
end
-- 346: fftfreq/typed/complex64/128/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/complex64/128/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},"fftfreq/typed/complex64/128/0: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/complex64/128/0: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex64/128/0: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex64/128/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"fftfreq/typed/complex64/128/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/128/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/128/0: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/128/0: spacing state: dtype")
cases=cases+1
end
-- 347: fftfreq/typed/complex64/128/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/complex64/128/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.0078125,0.0),np.complex(0.015625,0.0),np.complex(0.0234375,0.0),np.complex(0.03125,0.0),np.complex(0.0390625,0.0),np.complex(0.046875,0.0),np.complex(0.0546875,0.0),np.complex(0.0625,0.0),np.complex(0.0703125,0.0),np.complex(0.078125,0.0),np.complex(0.0859375,0.0),np.complex(0.09375,0.0),np.complex(0.1015625,0.0),np.complex(0.109375,0.0),np.complex(0.1171875,0.0),np.complex(0.125,0.0),np.complex(0.1328125,0.0),np.complex(0.140625,0.0),np.complex(0.1484375,0.0),np.complex(0.15625,0.0),np.complex(0.1640625,0.0),np.complex(0.171875,0.0),np.complex(0.1796875,0.0),np.complex(0.1875,0.0),np.complex(0.1953125,0.0),np.complex(0.203125,0.0),np.complex(0.2109375,0.0),np.complex(0.21875,0.0),np.complex(0.2265625,0.0),np.complex(0.234375,0.0),np.complex(0.2421875,0.0),np.complex(0.25,0.0),np.complex(0.2578125,0.0),np.complex(0.265625,0.0),np.complex(0.2734375,0.0),np.complex(0.28125,0.0),np.complex(0.2890625,0.0),np.complex(0.296875,0.0),np.complex(0.3046875,0.0),np.complex(0.3125,0.0),np.complex(0.3203125,0.0),np.complex(0.328125,0.0),np.complex(0.3359375,0.0),np.complex(0.34375,0.0),np.complex(0.3515625,0.0),np.complex(0.359375,0.0),np.complex(0.3671875,0.0),np.complex(0.375,0.0),np.complex(0.3828125,0.0),np.complex(0.390625,0.0),np.complex(0.3984375,0.0),np.complex(0.40625,0.0),np.complex(0.4140625,0.0),np.complex(0.421875,0.0),np.complex(0.4296875,0.0),np.complex(0.4375,0.0),np.complex(0.4453125,0.0),np.complex(0.453125,0.0),np.complex(0.4609375,0.0),np.complex(0.46875,0.0),np.complex(0.4765625,0.0),np.complex(0.484375,0.0),np.complex(0.4921875,0.0),np.complex(-0.5,0.0),np.complex(-0.4921875,0.0),np.complex(-0.484375,0.0),np.complex(-0.4765625,0.0),np.complex(-0.46875,0.0),np.complex(-0.4609375,0.0),np.complex(-0.453125,0.0),np.complex(-0.4453125,0.0),np.complex(-0.4375,0.0),np.complex(-0.4296875,0.0),np.complex(-0.421875,0.0),np.complex(-0.4140625,0.0),np.complex(-0.40625,0.0),np.complex(-0.3984375,0.0),np.complex(-0.390625,0.0),np.complex(-0.3828125,0.0),np.complex(-0.375,0.0),np.complex(-0.3671875,0.0),np.complex(-0.359375,0.0),np.complex(-0.3515625,0.0),np.complex(-0.34375,0.0),np.complex(-0.3359375,0.0),np.complex(-0.328125,0.0),np.complex(-0.3203125,0.0),np.complex(-0.3125,0.0),np.complex(-0.3046875,0.0),np.complex(-0.296875,0.0),np.complex(-0.2890625,0.0),np.complex(-0.28125,0.0),np.complex(-0.2734375,0.0),np.complex(-0.265625,0.0),np.complex(-0.2578125,0.0),np.complex(-0.25,0.0),np.complex(-0.2421875,0.0),np.complex(-0.234375,0.0),np.complex(-0.2265625,0.0),np.complex(-0.21875,0.0),np.complex(-0.2109375,0.0),np.complex(-0.203125,0.0),np.complex(-0.1953125,0.0),np.complex(-0.1875,0.0),np.complex(-0.1796875,0.0),np.complex(-0.171875,0.0),np.complex(-0.1640625,0.0),np.complex(-0.15625,0.0),np.complex(-0.1484375,0.0),np.complex(-0.140625,0.0),np.complex(-0.1328125,0.0),np.complex(-0.125,0.0),np.complex(-0.1171875,0.0),np.complex(-0.109375,0.0),np.complex(-0.1015625,0.0),np.complex(-0.09375,0.0),np.complex(-0.0859375,0.0),np.complex(-0.078125,0.0),np.complex(-0.0703125,0.0),np.complex(-0.0625,0.0),np.complex(-0.0546875,0.0),np.complex(-0.046875,0.0),np.complex(-0.0390625,0.0),np.complex(-0.03125,0.0),np.complex(-0.0234375,0.0),np.complex(-0.015625,0.0),np.complex(-0.0078125,0.0)},"fftfreq/typed/complex64/128/1: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/complex64/128/1: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex64/128/1: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex64/128/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"fftfreq/typed/complex64/128/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/128/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/128/1: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/128/1: spacing state: dtype")
cases=cases+1
end
-- 348: fftfreq/typed/complex64/128/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/complex64/128/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.00390625,0.0),np.complex(0.0078125,0.0),np.complex(0.01171875,0.0),np.complex(0.015625,0.0),np.complex(0.01953125,0.0),np.complex(0.0234375,0.0),np.complex(0.02734375,0.0),np.complex(0.03125,0.0),np.complex(0.03515625,0.0),np.complex(0.0390625,0.0),np.complex(0.04296875,0.0),np.complex(0.046875,0.0),np.complex(0.05078125,0.0),np.complex(0.0546875,0.0),np.complex(0.05859375,0.0),np.complex(0.0625,0.0),np.complex(0.06640625,0.0),np.complex(0.0703125,0.0),np.complex(0.07421875,0.0),np.complex(0.078125,0.0),np.complex(0.08203125,0.0),np.complex(0.0859375,0.0),np.complex(0.08984375,0.0),np.complex(0.09375,0.0),np.complex(0.09765625,0.0),np.complex(0.1015625,0.0),np.complex(0.10546875,0.0),np.complex(0.109375,0.0),np.complex(0.11328125,0.0),np.complex(0.1171875,0.0),np.complex(0.12109375,0.0),np.complex(0.125,0.0),np.complex(0.12890625,0.0),np.complex(0.1328125,0.0),np.complex(0.13671875,0.0),np.complex(0.140625,0.0),np.complex(0.14453125,0.0),np.complex(0.1484375,0.0),np.complex(0.15234375,0.0),np.complex(0.15625,0.0),np.complex(0.16015625,0.0),np.complex(0.1640625,0.0),np.complex(0.16796875,0.0),np.complex(0.171875,0.0),np.complex(0.17578125,0.0),np.complex(0.1796875,0.0),np.complex(0.18359375,0.0),np.complex(0.1875,0.0),np.complex(0.19140625,0.0),np.complex(0.1953125,0.0),np.complex(0.19921875,0.0),np.complex(0.203125,0.0),np.complex(0.20703125,0.0),np.complex(0.2109375,0.0),np.complex(0.21484375,0.0),np.complex(0.21875,0.0),np.complex(0.22265625,0.0),np.complex(0.2265625,0.0),np.complex(0.23046875,0.0),np.complex(0.234375,0.0),np.complex(0.23828125,0.0),np.complex(0.2421875,0.0),np.complex(0.24609375,0.0),np.complex(-0.25,0.0),np.complex(-0.24609375,0.0),np.complex(-0.2421875,0.0),np.complex(-0.23828125,0.0),np.complex(-0.234375,0.0),np.complex(-0.23046875,0.0),np.complex(-0.2265625,0.0),np.complex(-0.22265625,0.0),np.complex(-0.21875,0.0),np.complex(-0.21484375,0.0),np.complex(-0.2109375,0.0),np.complex(-0.20703125,0.0),np.complex(-0.203125,0.0),np.complex(-0.19921875,0.0),np.complex(-0.1953125,0.0),np.complex(-0.19140625,0.0),np.complex(-0.1875,0.0),np.complex(-0.18359375,0.0),np.complex(-0.1796875,0.0),np.complex(-0.17578125,0.0),np.complex(-0.171875,0.0),np.complex(-0.16796875,0.0),np.complex(-0.1640625,0.0),np.complex(-0.16015625,0.0),np.complex(-0.15625,0.0),np.complex(-0.15234375,0.0),np.complex(-0.1484375,0.0),np.complex(-0.14453125,0.0),np.complex(-0.140625,0.0),np.complex(-0.13671875,0.0),np.complex(-0.1328125,0.0),np.complex(-0.12890625,0.0),np.complex(-0.125,0.0),np.complex(-0.12109375,0.0),np.complex(-0.1171875,0.0),np.complex(-0.11328125,0.0),np.complex(-0.109375,0.0),np.complex(-0.10546875,0.0),np.complex(-0.1015625,0.0),np.complex(-0.09765625,0.0),np.complex(-0.09375,0.0),np.complex(-0.08984375,0.0),np.complex(-0.0859375,0.0),np.complex(-0.08203125,0.0),np.complex(-0.078125,0.0),np.complex(-0.07421875,0.0),np.complex(-0.0703125,0.0),np.complex(-0.06640625,0.0),np.complex(-0.0625,0.0),np.complex(-0.05859375,0.0),np.complex(-0.0546875,0.0),np.complex(-0.05078125,0.0),np.complex(-0.046875,0.0),np.complex(-0.04296875,0.0),np.complex(-0.0390625,0.0),np.complex(-0.03515625,0.0),np.complex(-0.03125,0.0),np.complex(-0.02734375,0.0),np.complex(-0.0234375,0.0),np.complex(-0.01953125,0.0),np.complex(-0.015625,0.0),np.complex(-0.01171875,0.0),np.complex(-0.0078125,0.0),np.complex(-0.00390625,0.0)},"fftfreq/typed/complex64/128/2: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/complex64/128/2: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex64/128/2: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex64/128/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"fftfreq/typed/complex64/128/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex64/128/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex64/128/2: spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/typed/complex64/128/2: spacing state: dtype")
cases=cases+1
end
-- 349: fftfreq/typed/complex128/-1/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/complex128/-1/0: acceptance"..": "..tostring(result))
eq(spacing:tolist(),np.complex(0.0,0.0),"fftfreq/typed/complex128/-1/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/-1/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/-1/0: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/-1/0: spacing state: dtype")
cases=cases+1
end
-- 350: fftfreq/typed/complex128/-1/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/complex128/-1/1: acceptance"..": "..tostring(result))
eq(spacing:tolist(),np.complex(1.0,0.0),"fftfreq/typed/complex128/-1/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/-1/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/-1/1: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/-1/1: spacing state: dtype")
cases=cases+1
end
-- 351: fftfreq/typed/complex128/-1/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(-1,spacing) end)
assert(ok==false,"fftfreq/typed/complex128/-1/2: acceptance"..": "..tostring(result))
eq(spacing:tolist(),np.complex(2.0,0.0),"fftfreq/typed/complex128/-1/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/-1/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/-1/2: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/-1/2: spacing state: dtype")
cases=cases+1
end
-- 352: fftfreq/typed/complex128/0/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/complex128/0/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/complex128/0/0: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/complex128/0/0: result: shape")
eq(result.strides,{0},"fftfreq/typed/complex128/0/0: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex128/0/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"fftfreq/typed/complex128/0/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/0/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/0/0: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/0/0: spacing state: dtype")
cases=cases+1
end
-- 353: fftfreq/typed/complex128/0/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/complex128/0/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/complex128/0/1: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/complex128/0/1: result: shape")
eq(result.strides,{0},"fftfreq/typed/complex128/0/1: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex128/0/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"fftfreq/typed/complex128/0/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/0/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/0/1: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/0/1: spacing state: dtype")
cases=cases+1
end
-- 354: fftfreq/typed/complex128/0/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/typed/complex128/0/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/typed/complex128/0/2: result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/typed/complex128/0/2: result: shape")
eq(result.strides,{0},"fftfreq/typed/complex128/0/2: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex128/0/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"fftfreq/typed/complex128/0/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/0/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/0/2: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/0/2: spacing state: dtype")
cases=cases+1
end
-- 355: fftfreq/typed/complex128/1/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/complex128/1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0))},"fftfreq/typed/complex128/1/0: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/complex128/1/0: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex128/1/0: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex128/1/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"fftfreq/typed/complex128/1/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/1/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/1/0: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/1/0: spacing state: dtype")
cases=cases+1
end
-- 356: fftfreq/typed/complex128/1/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/complex128/1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"fftfreq/typed/complex128/1/1: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/complex128/1/1: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex128/1/1: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex128/1/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"fftfreq/typed/complex128/1/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/1/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/1/1: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/1/1: spacing state: dtype")
cases=cases+1
end
-- 357: fftfreq/typed/complex128/1/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(1,spacing) end)
assert(ok==true,"fftfreq/typed/complex128/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"fftfreq/typed/complex128/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"fftfreq/typed/complex128/1/2: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex128/1/2: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex128/1/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"fftfreq/typed/complex128/1/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/1/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/1/2: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/1/2: spacing state: dtype")
cases=cases+1
end
-- 358: fftfreq/typed/complex128/3/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/complex128/3/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},"fftfreq/typed/complex128/3/0: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/complex128/3/0: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex128/3/0: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex128/3/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"fftfreq/typed/complex128/3/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/3/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/3/0: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/3/0: spacing state: dtype")
cases=cases+1
end
-- 359: fftfreq/typed/complex128/3/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/complex128/3/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.3333333333333333,0.0),np.complex(-0.3333333333333333,0.0)},"fftfreq/typed/complex128/3/1: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/complex128/3/1: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex128/3/1: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex128/3/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"fftfreq/typed/complex128/3/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/3/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/3/1: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/3/1: spacing state: dtype")
cases=cases+1
end
-- 360: fftfreq/typed/complex128/3/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/typed/complex128/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.16666666666666666,0.0),np.complex(-0.16666666666666666,0.0)},"fftfreq/typed/complex128/3/2: result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/typed/complex128/3/2: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex128/3/2: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex128/3/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"fftfreq/typed/complex128/3/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/3/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/3/2: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/3/2: spacing state: dtype")
cases=cases+1
end
-- 361: fftfreq/typed/complex128/4/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/complex128/4/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},"fftfreq/typed/complex128/4/0: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/complex128/4/0: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex128/4/0: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex128/4/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"fftfreq/typed/complex128/4/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/4/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/4/0: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/4/0: spacing state: dtype")
cases=cases+1
end
-- 362: fftfreq/typed/complex128/4/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/complex128/4/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.25,0.0),np.complex(-0.5,0.0),np.complex(-0.25,0.0)},"fftfreq/typed/complex128/4/1: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/complex128/4/1: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex128/4/1: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex128/4/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"fftfreq/typed/complex128/4/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/4/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/4/1: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/4/1: spacing state: dtype")
cases=cases+1
end
-- 363: fftfreq/typed/complex128/4/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/typed/complex128/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.125,0.0),np.complex(-0.25,0.0),np.complex(-0.125,0.0)},"fftfreq/typed/complex128/4/2: result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/typed/complex128/4/2: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex128/4/2: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex128/4/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"fftfreq/typed/complex128/4/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/4/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/4/2: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/4/2: spacing state: dtype")
cases=cases+1
end
-- 364: fftfreq/typed/complex128/15/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/complex128/15/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},"fftfreq/typed/complex128/15/0: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/complex128/15/0: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex128/15/0: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex128/15/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"fftfreq/typed/complex128/15/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/15/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/15/0: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/15/0: spacing state: dtype")
cases=cases+1
end
-- 365: fftfreq/typed/complex128/15/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/complex128/15/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.06666666666666667,0.0),np.complex(0.13333333333333333,0.0),np.complex(0.2,0.0),np.complex(0.26666666666666666,0.0),np.complex(0.3333333333333333,0.0),np.complex(0.4,0.0),np.complex(0.4666666666666667,0.0),np.complex(-0.4666666666666667,0.0),np.complex(-0.4,0.0),np.complex(-0.3333333333333333,0.0),np.complex(-0.26666666666666666,0.0),np.complex(-0.2,0.0),np.complex(-0.13333333333333333,0.0),np.complex(-0.06666666666666667,0.0)},"fftfreq/typed/complex128/15/1: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/complex128/15/1: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex128/15/1: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex128/15/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"fftfreq/typed/complex128/15/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/15/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/15/1: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/15/1: spacing state: dtype")
cases=cases+1
end
-- 366: fftfreq/typed/complex128/15/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(15,spacing) end)
assert(ok==true,"fftfreq/typed/complex128/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.03333333333333333,0.0),np.complex(0.06666666666666667,0.0),np.complex(0.1,0.0),np.complex(0.13333333333333333,0.0),np.complex(0.16666666666666666,0.0),np.complex(0.2,0.0),np.complex(0.23333333333333334,0.0),np.complex(-0.23333333333333334,0.0),np.complex(-0.2,0.0),np.complex(-0.16666666666666666,0.0),np.complex(-0.13333333333333333,0.0),np.complex(-0.1,0.0),np.complex(-0.06666666666666667,0.0),np.complex(-0.03333333333333333,0.0)},"fftfreq/typed/complex128/15/2: result",2e-12,2e-12)
eq(result.shape,{15},"fftfreq/typed/complex128/15/2: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex128/15/2: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex128/15/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"fftfreq/typed/complex128/15/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/15/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/15/2: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/15/2: spacing state: dtype")
cases=cases+1
end
-- 367: fftfreq/typed/complex128/127/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/complex128/127/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},"fftfreq/typed/complex128/127/0: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/complex128/127/0: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex128/127/0: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex128/127/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"fftfreq/typed/complex128/127/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/127/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/127/0: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/127/0: spacing state: dtype")
cases=cases+1
end
-- 368: fftfreq/typed/complex128/127/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/complex128/127/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.007874015748031496,0.0),np.complex(0.015748031496062992,0.0),np.complex(0.023622047244094488,0.0),np.complex(0.031496062992125984,0.0),np.complex(0.03937007874015748,0.0),np.complex(0.047244094488188976,0.0),np.complex(0.05511811023622047,0.0),np.complex(0.06299212598425197,0.0),np.complex(0.07086614173228346,0.0),np.complex(0.07874015748031496,0.0),np.complex(0.08661417322834646,0.0),np.complex(0.09448818897637795,0.0),np.complex(0.10236220472440945,0.0),np.complex(0.11023622047244094,0.0),np.complex(0.11811023622047244,0.0),np.complex(0.12598425196850394,0.0),np.complex(0.13385826771653542,0.0),np.complex(0.14173228346456693,0.0),np.complex(0.14960629921259844,0.0),np.complex(0.15748031496062992,0.0),np.complex(0.1653543307086614,0.0),np.complex(0.1732283464566929,0.0),np.complex(0.18110236220472442,0.0),np.complex(0.1889763779527559,0.0),np.complex(0.19685039370078738,0.0),np.complex(0.2047244094488189,0.0),np.complex(0.2125984251968504,0.0),np.complex(0.2204724409448819,0.0),np.complex(0.22834645669291337,0.0),np.complex(0.23622047244094488,0.0),np.complex(0.2440944881889764,0.0),np.complex(0.25196850393700787,0.0),np.complex(0.25984251968503935,0.0),np.complex(0.26771653543307083,0.0),np.complex(0.2755905511811024,0.0),np.complex(0.28346456692913385,0.0),np.complex(0.29133858267716534,0.0),np.complex(0.2992125984251969,0.0),np.complex(0.30708661417322836,0.0),np.complex(0.31496062992125984,0.0),np.complex(0.3228346456692913,0.0),np.complex(0.3307086614173228,0.0),np.complex(0.33858267716535434,0.0),np.complex(0.3464566929133858,0.0),np.complex(0.3543307086614173,0.0),np.complex(0.36220472440944884,0.0),np.complex(0.3700787401574803,0.0),np.complex(0.3779527559055118,0.0),np.complex(0.3858267716535433,0.0),np.complex(0.39370078740157477,0.0),np.complex(0.4015748031496063,0.0),np.complex(0.4094488188976378,0.0),np.complex(0.41732283464566927,0.0),np.complex(0.4251968503937008,0.0),np.complex(0.4330708661417323,0.0),np.complex(0.4409448818897638,0.0),np.complex(0.44881889763779526,0.0),np.complex(0.45669291338582674,0.0),np.complex(0.4645669291338583,0.0),np.complex(0.47244094488188976,0.0),np.complex(0.48031496062992124,0.0),np.complex(0.4881889763779528,0.0),np.complex(0.49606299212598426,0.0),np.complex(-0.49606299212598426,0.0),np.complex(-0.4881889763779528,0.0),np.complex(-0.48031496062992124,0.0),np.complex(-0.47244094488188976,0.0),np.complex(-0.4645669291338583,0.0),np.complex(-0.45669291338582674,0.0),np.complex(-0.44881889763779526,0.0),np.complex(-0.4409448818897638,0.0),np.complex(-0.4330708661417323,0.0),np.complex(-0.4251968503937008,0.0),np.complex(-0.41732283464566927,0.0),np.complex(-0.4094488188976378,0.0),np.complex(-0.4015748031496063,0.0),np.complex(-0.39370078740157477,0.0),np.complex(-0.3858267716535433,0.0),np.complex(-0.3779527559055118,0.0),np.complex(-0.3700787401574803,0.0),np.complex(-0.36220472440944884,0.0),np.complex(-0.3543307086614173,0.0),np.complex(-0.3464566929133858,0.0),np.complex(-0.33858267716535434,0.0),np.complex(-0.3307086614173228,0.0),np.complex(-0.3228346456692913,0.0),np.complex(-0.31496062992125984,0.0),np.complex(-0.30708661417322836,0.0),np.complex(-0.2992125984251969,0.0),np.complex(-0.29133858267716534,0.0),np.complex(-0.28346456692913385,0.0),np.complex(-0.2755905511811024,0.0),np.complex(-0.26771653543307083,0.0),np.complex(-0.25984251968503935,0.0),np.complex(-0.25196850393700787,0.0),np.complex(-0.2440944881889764,0.0),np.complex(-0.23622047244094488,0.0),np.complex(-0.22834645669291337,0.0),np.complex(-0.2204724409448819,0.0),np.complex(-0.2125984251968504,0.0),np.complex(-0.2047244094488189,0.0),np.complex(-0.19685039370078738,0.0),np.complex(-0.1889763779527559,0.0),np.complex(-0.18110236220472442,0.0),np.complex(-0.1732283464566929,0.0),np.complex(-0.1653543307086614,0.0),np.complex(-0.15748031496062992,0.0),np.complex(-0.14960629921259844,0.0),np.complex(-0.14173228346456693,0.0),np.complex(-0.13385826771653542,0.0),np.complex(-0.12598425196850394,0.0),np.complex(-0.11811023622047244,0.0),np.complex(-0.11023622047244094,0.0),np.complex(-0.10236220472440945,0.0),np.complex(-0.09448818897637795,0.0),np.complex(-0.08661417322834646,0.0),np.complex(-0.07874015748031496,0.0),np.complex(-0.07086614173228346,0.0),np.complex(-0.06299212598425197,0.0),np.complex(-0.05511811023622047,0.0),np.complex(-0.047244094488188976,0.0),np.complex(-0.03937007874015748,0.0),np.complex(-0.031496062992125984,0.0),np.complex(-0.023622047244094488,0.0),np.complex(-0.015748031496062992,0.0),np.complex(-0.007874015748031496,0.0)},"fftfreq/typed/complex128/127/1: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/complex128/127/1: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex128/127/1: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex128/127/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"fftfreq/typed/complex128/127/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/127/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/127/1: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/127/1: spacing state: dtype")
cases=cases+1
end
-- 369: fftfreq/typed/complex128/127/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(127,spacing) end)
assert(ok==true,"fftfreq/typed/complex128/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.003937007874015748,0.0),np.complex(0.007874015748031496,0.0),np.complex(0.011811023622047244,0.0),np.complex(0.015748031496062992,0.0),np.complex(0.01968503937007874,0.0),np.complex(0.023622047244094488,0.0),np.complex(0.027559055118110236,0.0),np.complex(0.031496062992125984,0.0),np.complex(0.03543307086614173,0.0),np.complex(0.03937007874015748,0.0),np.complex(0.04330708661417323,0.0),np.complex(0.047244094488188976,0.0),np.complex(0.051181102362204724,0.0),np.complex(0.05511811023622047,0.0),np.complex(0.05905511811023622,0.0),np.complex(0.06299212598425197,0.0),np.complex(0.06692913385826771,0.0),np.complex(0.07086614173228346,0.0),np.complex(0.07480314960629922,0.0),np.complex(0.07874015748031496,0.0),np.complex(0.0826771653543307,0.0),np.complex(0.08661417322834646,0.0),np.complex(0.09055118110236221,0.0),np.complex(0.09448818897637795,0.0),np.complex(0.09842519685039369,0.0),np.complex(0.10236220472440945,0.0),np.complex(0.1062992125984252,0.0),np.complex(0.11023622047244094,0.0),np.complex(0.11417322834645668,0.0),np.complex(0.11811023622047244,0.0),np.complex(0.1220472440944882,0.0),np.complex(0.12598425196850394,0.0),np.complex(0.12992125984251968,0.0),np.complex(0.13385826771653542,0.0),np.complex(0.1377952755905512,0.0),np.complex(0.14173228346456693,0.0),np.complex(0.14566929133858267,0.0),np.complex(0.14960629921259844,0.0),np.complex(0.15354330708661418,0.0),np.complex(0.15748031496062992,0.0),np.complex(0.16141732283464566,0.0),np.complex(0.1653543307086614,0.0),np.complex(0.16929133858267717,0.0),np.complex(0.1732283464566929,0.0),np.complex(0.17716535433070865,0.0),np.complex(0.18110236220472442,0.0),np.complex(0.18503937007874016,0.0),np.complex(0.1889763779527559,0.0),np.complex(0.19291338582677164,0.0),np.complex(0.19685039370078738,0.0),np.complex(0.20078740157480315,0.0),np.complex(0.2047244094488189,0.0),np.complex(0.20866141732283464,0.0),np.complex(0.2125984251968504,0.0),np.complex(0.21653543307086615,0.0),np.complex(0.2204724409448819,0.0),np.complex(0.22440944881889763,0.0),np.complex(0.22834645669291337,0.0),np.complex(0.23228346456692914,0.0),np.complex(0.23622047244094488,0.0),np.complex(0.24015748031496062,0.0),np.complex(0.2440944881889764,0.0),np.complex(0.24803149606299213,0.0),np.complex(-0.24803149606299213,0.0),np.complex(-0.2440944881889764,0.0),np.complex(-0.24015748031496062,0.0),np.complex(-0.23622047244094488,0.0),np.complex(-0.23228346456692914,0.0),np.complex(-0.22834645669291337,0.0),np.complex(-0.22440944881889763,0.0),np.complex(-0.2204724409448819,0.0),np.complex(-0.21653543307086615,0.0),np.complex(-0.2125984251968504,0.0),np.complex(-0.20866141732283464,0.0),np.complex(-0.2047244094488189,0.0),np.complex(-0.20078740157480315,0.0),np.complex(-0.19685039370078738,0.0),np.complex(-0.19291338582677164,0.0),np.complex(-0.1889763779527559,0.0),np.complex(-0.18503937007874016,0.0),np.complex(-0.18110236220472442,0.0),np.complex(-0.17716535433070865,0.0),np.complex(-0.1732283464566929,0.0),np.complex(-0.16929133858267717,0.0),np.complex(-0.1653543307086614,0.0),np.complex(-0.16141732283464566,0.0),np.complex(-0.15748031496062992,0.0),np.complex(-0.15354330708661418,0.0),np.complex(-0.14960629921259844,0.0),np.complex(-0.14566929133858267,0.0),np.complex(-0.14173228346456693,0.0),np.complex(-0.1377952755905512,0.0),np.complex(-0.13385826771653542,0.0),np.complex(-0.12992125984251968,0.0),np.complex(-0.12598425196850394,0.0),np.complex(-0.1220472440944882,0.0),np.complex(-0.11811023622047244,0.0),np.complex(-0.11417322834645668,0.0),np.complex(-0.11023622047244094,0.0),np.complex(-0.1062992125984252,0.0),np.complex(-0.10236220472440945,0.0),np.complex(-0.09842519685039369,0.0),np.complex(-0.09448818897637795,0.0),np.complex(-0.09055118110236221,0.0),np.complex(-0.08661417322834646,0.0),np.complex(-0.0826771653543307,0.0),np.complex(-0.07874015748031496,0.0),np.complex(-0.07480314960629922,0.0),np.complex(-0.07086614173228346,0.0),np.complex(-0.06692913385826771,0.0),np.complex(-0.06299212598425197,0.0),np.complex(-0.05905511811023622,0.0),np.complex(-0.05511811023622047,0.0),np.complex(-0.051181102362204724,0.0),np.complex(-0.047244094488188976,0.0),np.complex(-0.04330708661417323,0.0),np.complex(-0.03937007874015748,0.0),np.complex(-0.03543307086614173,0.0),np.complex(-0.031496062992125984,0.0),np.complex(-0.027559055118110236,0.0),np.complex(-0.023622047244094488,0.0),np.complex(-0.01968503937007874,0.0),np.complex(-0.015748031496062992,0.0),np.complex(-0.011811023622047244,0.0),np.complex(-0.007874015748031496,0.0),np.complex(-0.003937007874015748,0.0)},"fftfreq/typed/complex128/127/2: result",2e-12,2e-12)
eq(result.shape,{127},"fftfreq/typed/complex128/127/2: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex128/127/2: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex128/127/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"fftfreq/typed/complex128/127/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/127/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/127/2: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/127/2: spacing state: dtype")
cases=cases+1
end
-- 370: fftfreq/typed/complex128/128/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/complex128/128/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},"fftfreq/typed/complex128/128/0: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/complex128/128/0: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex128/128/0: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex128/128/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"fftfreq/typed/complex128/128/0: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/128/0: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/128/0: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/128/0: spacing state: dtype")
cases=cases+1
end
-- 371: fftfreq/typed/complex128/128/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/complex128/128/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.0078125,0.0),np.complex(0.015625,0.0),np.complex(0.0234375,0.0),np.complex(0.03125,0.0),np.complex(0.0390625,0.0),np.complex(0.046875,0.0),np.complex(0.0546875,0.0),np.complex(0.0625,0.0),np.complex(0.0703125,0.0),np.complex(0.078125,0.0),np.complex(0.0859375,0.0),np.complex(0.09375,0.0),np.complex(0.1015625,0.0),np.complex(0.109375,0.0),np.complex(0.1171875,0.0),np.complex(0.125,0.0),np.complex(0.1328125,0.0),np.complex(0.140625,0.0),np.complex(0.1484375,0.0),np.complex(0.15625,0.0),np.complex(0.1640625,0.0),np.complex(0.171875,0.0),np.complex(0.1796875,0.0),np.complex(0.1875,0.0),np.complex(0.1953125,0.0),np.complex(0.203125,0.0),np.complex(0.2109375,0.0),np.complex(0.21875,0.0),np.complex(0.2265625,0.0),np.complex(0.234375,0.0),np.complex(0.2421875,0.0),np.complex(0.25,0.0),np.complex(0.2578125,0.0),np.complex(0.265625,0.0),np.complex(0.2734375,0.0),np.complex(0.28125,0.0),np.complex(0.2890625,0.0),np.complex(0.296875,0.0),np.complex(0.3046875,0.0),np.complex(0.3125,0.0),np.complex(0.3203125,0.0),np.complex(0.328125,0.0),np.complex(0.3359375,0.0),np.complex(0.34375,0.0),np.complex(0.3515625,0.0),np.complex(0.359375,0.0),np.complex(0.3671875,0.0),np.complex(0.375,0.0),np.complex(0.3828125,0.0),np.complex(0.390625,0.0),np.complex(0.3984375,0.0),np.complex(0.40625,0.0),np.complex(0.4140625,0.0),np.complex(0.421875,0.0),np.complex(0.4296875,0.0),np.complex(0.4375,0.0),np.complex(0.4453125,0.0),np.complex(0.453125,0.0),np.complex(0.4609375,0.0),np.complex(0.46875,0.0),np.complex(0.4765625,0.0),np.complex(0.484375,0.0),np.complex(0.4921875,0.0),np.complex(-0.5,0.0),np.complex(-0.4921875,0.0),np.complex(-0.484375,0.0),np.complex(-0.4765625,0.0),np.complex(-0.46875,0.0),np.complex(-0.4609375,0.0),np.complex(-0.453125,0.0),np.complex(-0.4453125,0.0),np.complex(-0.4375,0.0),np.complex(-0.4296875,0.0),np.complex(-0.421875,0.0),np.complex(-0.4140625,0.0),np.complex(-0.40625,0.0),np.complex(-0.3984375,0.0),np.complex(-0.390625,0.0),np.complex(-0.3828125,0.0),np.complex(-0.375,0.0),np.complex(-0.3671875,0.0),np.complex(-0.359375,0.0),np.complex(-0.3515625,0.0),np.complex(-0.34375,0.0),np.complex(-0.3359375,0.0),np.complex(-0.328125,0.0),np.complex(-0.3203125,0.0),np.complex(-0.3125,0.0),np.complex(-0.3046875,0.0),np.complex(-0.296875,0.0),np.complex(-0.2890625,0.0),np.complex(-0.28125,0.0),np.complex(-0.2734375,0.0),np.complex(-0.265625,0.0),np.complex(-0.2578125,0.0),np.complex(-0.25,0.0),np.complex(-0.2421875,0.0),np.complex(-0.234375,0.0),np.complex(-0.2265625,0.0),np.complex(-0.21875,0.0),np.complex(-0.2109375,0.0),np.complex(-0.203125,0.0),np.complex(-0.1953125,0.0),np.complex(-0.1875,0.0),np.complex(-0.1796875,0.0),np.complex(-0.171875,0.0),np.complex(-0.1640625,0.0),np.complex(-0.15625,0.0),np.complex(-0.1484375,0.0),np.complex(-0.140625,0.0),np.complex(-0.1328125,0.0),np.complex(-0.125,0.0),np.complex(-0.1171875,0.0),np.complex(-0.109375,0.0),np.complex(-0.1015625,0.0),np.complex(-0.09375,0.0),np.complex(-0.0859375,0.0),np.complex(-0.078125,0.0),np.complex(-0.0703125,0.0),np.complex(-0.0625,0.0),np.complex(-0.0546875,0.0),np.complex(-0.046875,0.0),np.complex(-0.0390625,0.0),np.complex(-0.03125,0.0),np.complex(-0.0234375,0.0),np.complex(-0.015625,0.0),np.complex(-0.0078125,0.0)},"fftfreq/typed/complex128/128/1: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/complex128/128/1: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex128/128/1: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex128/128/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"fftfreq/typed/complex128/128/1: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/128/1: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/128/1: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/128/1: spacing state: dtype")
cases=cases+1
end
-- 372: fftfreq/typed/complex128/128/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.fftfreq(128,spacing) end)
assert(ok==true,"fftfreq/typed/complex128/128/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.00390625,0.0),np.complex(0.0078125,0.0),np.complex(0.01171875,0.0),np.complex(0.015625,0.0),np.complex(0.01953125,0.0),np.complex(0.0234375,0.0),np.complex(0.02734375,0.0),np.complex(0.03125,0.0),np.complex(0.03515625,0.0),np.complex(0.0390625,0.0),np.complex(0.04296875,0.0),np.complex(0.046875,0.0),np.complex(0.05078125,0.0),np.complex(0.0546875,0.0),np.complex(0.05859375,0.0),np.complex(0.0625,0.0),np.complex(0.06640625,0.0),np.complex(0.0703125,0.0),np.complex(0.07421875,0.0),np.complex(0.078125,0.0),np.complex(0.08203125,0.0),np.complex(0.0859375,0.0),np.complex(0.08984375,0.0),np.complex(0.09375,0.0),np.complex(0.09765625,0.0),np.complex(0.1015625,0.0),np.complex(0.10546875,0.0),np.complex(0.109375,0.0),np.complex(0.11328125,0.0),np.complex(0.1171875,0.0),np.complex(0.12109375,0.0),np.complex(0.125,0.0),np.complex(0.12890625,0.0),np.complex(0.1328125,0.0),np.complex(0.13671875,0.0),np.complex(0.140625,0.0),np.complex(0.14453125,0.0),np.complex(0.1484375,0.0),np.complex(0.15234375,0.0),np.complex(0.15625,0.0),np.complex(0.16015625,0.0),np.complex(0.1640625,0.0),np.complex(0.16796875,0.0),np.complex(0.171875,0.0),np.complex(0.17578125,0.0),np.complex(0.1796875,0.0),np.complex(0.18359375,0.0),np.complex(0.1875,0.0),np.complex(0.19140625,0.0),np.complex(0.1953125,0.0),np.complex(0.19921875,0.0),np.complex(0.203125,0.0),np.complex(0.20703125,0.0),np.complex(0.2109375,0.0),np.complex(0.21484375,0.0),np.complex(0.21875,0.0),np.complex(0.22265625,0.0),np.complex(0.2265625,0.0),np.complex(0.23046875,0.0),np.complex(0.234375,0.0),np.complex(0.23828125,0.0),np.complex(0.2421875,0.0),np.complex(0.24609375,0.0),np.complex(-0.25,0.0),np.complex(-0.24609375,0.0),np.complex(-0.2421875,0.0),np.complex(-0.23828125,0.0),np.complex(-0.234375,0.0),np.complex(-0.23046875,0.0),np.complex(-0.2265625,0.0),np.complex(-0.22265625,0.0),np.complex(-0.21875,0.0),np.complex(-0.21484375,0.0),np.complex(-0.2109375,0.0),np.complex(-0.20703125,0.0),np.complex(-0.203125,0.0),np.complex(-0.19921875,0.0),np.complex(-0.1953125,0.0),np.complex(-0.19140625,0.0),np.complex(-0.1875,0.0),np.complex(-0.18359375,0.0),np.complex(-0.1796875,0.0),np.complex(-0.17578125,0.0),np.complex(-0.171875,0.0),np.complex(-0.16796875,0.0),np.complex(-0.1640625,0.0),np.complex(-0.16015625,0.0),np.complex(-0.15625,0.0),np.complex(-0.15234375,0.0),np.complex(-0.1484375,0.0),np.complex(-0.14453125,0.0),np.complex(-0.140625,0.0),np.complex(-0.13671875,0.0),np.complex(-0.1328125,0.0),np.complex(-0.12890625,0.0),np.complex(-0.125,0.0),np.complex(-0.12109375,0.0),np.complex(-0.1171875,0.0),np.complex(-0.11328125,0.0),np.complex(-0.109375,0.0),np.complex(-0.10546875,0.0),np.complex(-0.1015625,0.0),np.complex(-0.09765625,0.0),np.complex(-0.09375,0.0),np.complex(-0.08984375,0.0),np.complex(-0.0859375,0.0),np.complex(-0.08203125,0.0),np.complex(-0.078125,0.0),np.complex(-0.07421875,0.0),np.complex(-0.0703125,0.0),np.complex(-0.06640625,0.0),np.complex(-0.0625,0.0),np.complex(-0.05859375,0.0),np.complex(-0.0546875,0.0),np.complex(-0.05078125,0.0),np.complex(-0.046875,0.0),np.complex(-0.04296875,0.0),np.complex(-0.0390625,0.0),np.complex(-0.03515625,0.0),np.complex(-0.03125,0.0),np.complex(-0.02734375,0.0),np.complex(-0.0234375,0.0),np.complex(-0.01953125,0.0),np.complex(-0.015625,0.0),np.complex(-0.01171875,0.0),np.complex(-0.0078125,0.0),np.complex(-0.00390625,0.0)},"fftfreq/typed/complex128/128/2: result",2e-12,2e-12)
eq(result.shape,{128},"fftfreq/typed/complex128/128/2: result: shape")
eq(result.strides,{16},"fftfreq/typed/complex128/128/2: result: strides")
eq(result.dtype,"complex128","fftfreq/typed/complex128/128/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"fftfreq/typed/complex128/128/2: spacing state")
eq(spacing.shape,{},"fftfreq/typed/complex128/128/2: spacing state: shape")
eq(spacing.strides,{},"fftfreq/typed/complex128/128/2: spacing state: strides")
eq(spacing.dtype,"complex128","fftfreq/typed/complex128/128/2: spacing state: dtype")
cases=cases+1
end
-- 373: fftfreq/broadcast/float32/0/(1,)
do
local spacing=np.array({0.5},"float32")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/broadcast/float32/0/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/broadcast/float32/0/(1,): result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/broadcast/float32/0/(1,): result: shape")
eq(result.strides,{0},"fftfreq/broadcast/float32/0/(1,): result: strides")
eq(result.dtype,"float64","fftfreq/broadcast/float32/0/(1,): result: dtype")
eq(spacing:tolist(),{0.5},"fftfreq/broadcast/float32/0/(1,): spacing state")
eq(spacing.shape,{1},"fftfreq/broadcast/float32/0/(1,): spacing state: shape")
eq(spacing.strides,{4},"fftfreq/broadcast/float32/0/(1,): spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/broadcast/float32/0/(1,): spacing state: dtype")
cases=cases+1
end
-- 374: fftfreq/broadcast/float32/0/(3,)
do
local spacing=np.array({0.5,0.5,0.5},"float32")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==false,"fftfreq/broadcast/float32/0/(3,): acceptance"..": "..tostring(result))
eq(spacing:tolist(),{0.5,0.5,0.5},"fftfreq/broadcast/float32/0/(3,): spacing state")
eq(spacing.shape,{3},"fftfreq/broadcast/float32/0/(3,): spacing state: shape")
eq(spacing.strides,{4},"fftfreq/broadcast/float32/0/(3,): spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/broadcast/float32/0/(3,): spacing state: dtype")
cases=cases+1
end
-- 375: fftfreq/broadcast/float32/0/(2, 1)
do
local spacing=np.array({{0.5},{0.5}},"float32")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/broadcast/float32/0/(2, 1): acceptance"..": "..tostring(result))
eq(result:tolist(),{{},{}},"fftfreq/broadcast/float32/0/(2, 1): result",2e-12,2e-12)
eq(result.shape,{2,0},"fftfreq/broadcast/float32/0/(2, 1): result: shape")
eq(result.strides,{0,0},"fftfreq/broadcast/float32/0/(2, 1): result: strides")
eq(result.dtype,"float64","fftfreq/broadcast/float32/0/(2, 1): result: dtype")
eq(spacing:tolist(),{{0.5},{0.5}},"fftfreq/broadcast/float32/0/(2, 1): spacing state")
eq(spacing.shape,{2,1},"fftfreq/broadcast/float32/0/(2, 1): spacing state: shape")
eq(spacing.strides,{4,4},"fftfreq/broadcast/float32/0/(2, 1): spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/broadcast/float32/0/(2, 1): spacing state: dtype")
cases=cases+1
end
-- 376: fftfreq/broadcast/float32/0/(2, 3)
do
local spacing=np.array({{0.5,0.5,0.5},{0.5,0.5,0.5}},"float32")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==false,"fftfreq/broadcast/float32/0/(2, 3): acceptance"..": "..tostring(result))
eq(spacing:tolist(),{{0.5,0.5,0.5},{0.5,0.5,0.5}},"fftfreq/broadcast/float32/0/(2, 3): spacing state")
eq(spacing.shape,{2,3},"fftfreq/broadcast/float32/0/(2, 3): spacing state: shape")
eq(spacing.strides,{12,4},"fftfreq/broadcast/float32/0/(2, 3): spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/broadcast/float32/0/(2, 3): spacing state: dtype")
cases=cases+1
end
-- 377: fftfreq/broadcast/float32/3/(1,)
do
local spacing=np.array({0.5},"float32")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/broadcast/float32/3/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.6666666865348816,-0.6666666865348816},"fftfreq/broadcast/float32/3/(1,): result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/broadcast/float32/3/(1,): result: shape")
eq(result.strides,{8},"fftfreq/broadcast/float32/3/(1,): result: strides")
eq(result.dtype,"float64","fftfreq/broadcast/float32/3/(1,): result: dtype")
eq(spacing:tolist(),{0.5},"fftfreq/broadcast/float32/3/(1,): spacing state")
eq(spacing.shape,{1},"fftfreq/broadcast/float32/3/(1,): spacing state: shape")
eq(spacing.strides,{4},"fftfreq/broadcast/float32/3/(1,): spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/broadcast/float32/3/(1,): spacing state: dtype")
cases=cases+1
end
-- 378: fftfreq/broadcast/float32/3/(3,)
do
local spacing=np.array({0.5,0.5,0.5},"float32")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/broadcast/float32/3/(3,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.6666666865348816,-0.6666666865348816},"fftfreq/broadcast/float32/3/(3,): result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/broadcast/float32/3/(3,): result: shape")
eq(result.strides,{8},"fftfreq/broadcast/float32/3/(3,): result: strides")
eq(result.dtype,"float64","fftfreq/broadcast/float32/3/(3,): result: dtype")
eq(spacing:tolist(),{0.5,0.5,0.5},"fftfreq/broadcast/float32/3/(3,): spacing state")
eq(spacing.shape,{3},"fftfreq/broadcast/float32/3/(3,): spacing state: shape")
eq(spacing.strides,{4},"fftfreq/broadcast/float32/3/(3,): spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/broadcast/float32/3/(3,): spacing state: dtype")
cases=cases+1
end
-- 379: fftfreq/broadcast/float32/3/(2, 1)
do
local spacing=np.array({{0.5},{0.5}},"float32")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/broadcast/float32/3/(2, 1): acceptance"..": "..tostring(result))
eq(result:tolist(),{{0.0,0.6666666865348816,-0.6666666865348816},{0.0,0.6666666865348816,-0.6666666865348816}},"fftfreq/broadcast/float32/3/(2, 1): result",2e-12,2e-12)
eq(result.shape,{2,3},"fftfreq/broadcast/float32/3/(2, 1): result: shape")
eq(result.strides,{24,8},"fftfreq/broadcast/float32/3/(2, 1): result: strides")
eq(result.dtype,"float64","fftfreq/broadcast/float32/3/(2, 1): result: dtype")
eq(spacing:tolist(),{{0.5},{0.5}},"fftfreq/broadcast/float32/3/(2, 1): spacing state")
eq(spacing.shape,{2,1},"fftfreq/broadcast/float32/3/(2, 1): spacing state: shape")
eq(spacing.strides,{4,4},"fftfreq/broadcast/float32/3/(2, 1): spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/broadcast/float32/3/(2, 1): spacing state: dtype")
cases=cases+1
end
-- 380: fftfreq/broadcast/float32/3/(2, 3)
do
local spacing=np.array({{0.5,0.5,0.5},{0.5,0.5,0.5}},"float32")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/broadcast/float32/3/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{{0.0,0.6666666865348816,-0.6666666865348816},{0.0,0.6666666865348816,-0.6666666865348816}},"fftfreq/broadcast/float32/3/(2, 3): result",2e-12,2e-12)
eq(result.shape,{2,3},"fftfreq/broadcast/float32/3/(2, 3): result: shape")
eq(result.strides,{24,8},"fftfreq/broadcast/float32/3/(2, 3): result: strides")
eq(result.dtype,"float64","fftfreq/broadcast/float32/3/(2, 3): result: dtype")
eq(spacing:tolist(),{{0.5,0.5,0.5},{0.5,0.5,0.5}},"fftfreq/broadcast/float32/3/(2, 3): spacing state")
eq(spacing.shape,{2,3},"fftfreq/broadcast/float32/3/(2, 3): spacing state: shape")
eq(spacing.strides,{12,4},"fftfreq/broadcast/float32/3/(2, 3): spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/broadcast/float32/3/(2, 3): spacing state: dtype")
cases=cases+1
end
-- 381: fftfreq/broadcast/float32/4/(1,)
do
local spacing=np.array({0.5},"float32")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/broadcast/float32/4/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.5,-1.0,-0.5},"fftfreq/broadcast/float32/4/(1,): result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/broadcast/float32/4/(1,): result: shape")
eq(result.strides,{8},"fftfreq/broadcast/float32/4/(1,): result: strides")
eq(result.dtype,"float64","fftfreq/broadcast/float32/4/(1,): result: dtype")
eq(spacing:tolist(),{0.5},"fftfreq/broadcast/float32/4/(1,): spacing state")
eq(spacing.shape,{1},"fftfreq/broadcast/float32/4/(1,): spacing state: shape")
eq(spacing.strides,{4},"fftfreq/broadcast/float32/4/(1,): spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/broadcast/float32/4/(1,): spacing state: dtype")
cases=cases+1
end
-- 382: fftfreq/broadcast/float32/4/(3,)
do
local spacing=np.array({0.5,0.5,0.5},"float32")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==false,"fftfreq/broadcast/float32/4/(3,): acceptance"..": "..tostring(result))
eq(spacing:tolist(),{0.5,0.5,0.5},"fftfreq/broadcast/float32/4/(3,): spacing state")
eq(spacing.shape,{3},"fftfreq/broadcast/float32/4/(3,): spacing state: shape")
eq(spacing.strides,{4},"fftfreq/broadcast/float32/4/(3,): spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/broadcast/float32/4/(3,): spacing state: dtype")
cases=cases+1
end
-- 383: fftfreq/broadcast/float32/4/(2, 1)
do
local spacing=np.array({{0.5},{0.5}},"float32")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/broadcast/float32/4/(2, 1): acceptance"..": "..tostring(result))
eq(result:tolist(),{{0.0,0.5,-1.0,-0.5},{0.0,0.5,-1.0,-0.5}},"fftfreq/broadcast/float32/4/(2, 1): result",2e-12,2e-12)
eq(result.shape,{2,4},"fftfreq/broadcast/float32/4/(2, 1): result: shape")
eq(result.strides,{32,8},"fftfreq/broadcast/float32/4/(2, 1): result: strides")
eq(result.dtype,"float64","fftfreq/broadcast/float32/4/(2, 1): result: dtype")
eq(spacing:tolist(),{{0.5},{0.5}},"fftfreq/broadcast/float32/4/(2, 1): spacing state")
eq(spacing.shape,{2,1},"fftfreq/broadcast/float32/4/(2, 1): spacing state: shape")
eq(spacing.strides,{4,4},"fftfreq/broadcast/float32/4/(2, 1): spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/broadcast/float32/4/(2, 1): spacing state: dtype")
cases=cases+1
end
-- 384: fftfreq/broadcast/float32/4/(2, 3)
do
local spacing=np.array({{0.5,0.5,0.5},{0.5,0.5,0.5}},"float32")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==false,"fftfreq/broadcast/float32/4/(2, 3): acceptance"..": "..tostring(result))
eq(spacing:tolist(),{{0.5,0.5,0.5},{0.5,0.5,0.5}},"fftfreq/broadcast/float32/4/(2, 3): spacing state")
eq(spacing.shape,{2,3},"fftfreq/broadcast/float32/4/(2, 3): spacing state: shape")
eq(spacing.strides,{12,4},"fftfreq/broadcast/float32/4/(2, 3): spacing state: strides")
eq(spacing.dtype,"float32","fftfreq/broadcast/float32/4/(2, 3): spacing state: dtype")
cases=cases+1
end
-- 385: fftfreq/broadcast/float64/0/(1,)
do
local spacing=np.array({0.5},"float64")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/broadcast/float64/0/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/broadcast/float64/0/(1,): result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/broadcast/float64/0/(1,): result: shape")
eq(result.strides,{0},"fftfreq/broadcast/float64/0/(1,): result: strides")
eq(result.dtype,"float64","fftfreq/broadcast/float64/0/(1,): result: dtype")
eq(spacing:tolist(),{0.5},"fftfreq/broadcast/float64/0/(1,): spacing state")
eq(spacing.shape,{1},"fftfreq/broadcast/float64/0/(1,): spacing state: shape")
eq(spacing.strides,{8},"fftfreq/broadcast/float64/0/(1,): spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/broadcast/float64/0/(1,): spacing state: dtype")
cases=cases+1
end
-- 386: fftfreq/broadcast/float64/0/(3,)
do
local spacing=np.array({0.5,0.5,0.5},"float64")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==false,"fftfreq/broadcast/float64/0/(3,): acceptance"..": "..tostring(result))
eq(spacing:tolist(),{0.5,0.5,0.5},"fftfreq/broadcast/float64/0/(3,): spacing state")
eq(spacing.shape,{3},"fftfreq/broadcast/float64/0/(3,): spacing state: shape")
eq(spacing.strides,{8},"fftfreq/broadcast/float64/0/(3,): spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/broadcast/float64/0/(3,): spacing state: dtype")
cases=cases+1
end
-- 387: fftfreq/broadcast/float64/0/(2, 1)
do
local spacing=np.array({{0.5},{0.5}},"float64")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/broadcast/float64/0/(2, 1): acceptance"..": "..tostring(result))
eq(result:tolist(),{{},{}},"fftfreq/broadcast/float64/0/(2, 1): result",2e-12,2e-12)
eq(result.shape,{2,0},"fftfreq/broadcast/float64/0/(2, 1): result: shape")
eq(result.strides,{0,0},"fftfreq/broadcast/float64/0/(2, 1): result: strides")
eq(result.dtype,"float64","fftfreq/broadcast/float64/0/(2, 1): result: dtype")
eq(spacing:tolist(),{{0.5},{0.5}},"fftfreq/broadcast/float64/0/(2, 1): spacing state")
eq(spacing.shape,{2,1},"fftfreq/broadcast/float64/0/(2, 1): spacing state: shape")
eq(spacing.strides,{8,8},"fftfreq/broadcast/float64/0/(2, 1): spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/broadcast/float64/0/(2, 1): spacing state: dtype")
cases=cases+1
end
-- 388: fftfreq/broadcast/float64/0/(2, 3)
do
local spacing=np.array({{0.5,0.5,0.5},{0.5,0.5,0.5}},"float64")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==false,"fftfreq/broadcast/float64/0/(2, 3): acceptance"..": "..tostring(result))
eq(spacing:tolist(),{{0.5,0.5,0.5},{0.5,0.5,0.5}},"fftfreq/broadcast/float64/0/(2, 3): spacing state")
eq(spacing.shape,{2,3},"fftfreq/broadcast/float64/0/(2, 3): spacing state: shape")
eq(spacing.strides,{24,8},"fftfreq/broadcast/float64/0/(2, 3): spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/broadcast/float64/0/(2, 3): spacing state: dtype")
cases=cases+1
end
-- 389: fftfreq/broadcast/float64/3/(1,)
do
local spacing=np.array({0.5},"float64")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/broadcast/float64/3/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.6666666666666666,-0.6666666666666666},"fftfreq/broadcast/float64/3/(1,): result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/broadcast/float64/3/(1,): result: shape")
eq(result.strides,{8},"fftfreq/broadcast/float64/3/(1,): result: strides")
eq(result.dtype,"float64","fftfreq/broadcast/float64/3/(1,): result: dtype")
eq(spacing:tolist(),{0.5},"fftfreq/broadcast/float64/3/(1,): spacing state")
eq(spacing.shape,{1},"fftfreq/broadcast/float64/3/(1,): spacing state: shape")
eq(spacing.strides,{8},"fftfreq/broadcast/float64/3/(1,): spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/broadcast/float64/3/(1,): spacing state: dtype")
cases=cases+1
end
-- 390: fftfreq/broadcast/float64/3/(3,)
do
local spacing=np.array({0.5,0.5,0.5},"float64")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/broadcast/float64/3/(3,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.6666666666666666,-0.6666666666666666},"fftfreq/broadcast/float64/3/(3,): result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/broadcast/float64/3/(3,): result: shape")
eq(result.strides,{8},"fftfreq/broadcast/float64/3/(3,): result: strides")
eq(result.dtype,"float64","fftfreq/broadcast/float64/3/(3,): result: dtype")
eq(spacing:tolist(),{0.5,0.5,0.5},"fftfreq/broadcast/float64/3/(3,): spacing state")
eq(spacing.shape,{3},"fftfreq/broadcast/float64/3/(3,): spacing state: shape")
eq(spacing.strides,{8},"fftfreq/broadcast/float64/3/(3,): spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/broadcast/float64/3/(3,): spacing state: dtype")
cases=cases+1
end
-- 391: fftfreq/broadcast/float64/3/(2, 1)
do
local spacing=np.array({{0.5},{0.5}},"float64")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/broadcast/float64/3/(2, 1): acceptance"..": "..tostring(result))
eq(result:tolist(),{{0.0,0.6666666666666666,-0.6666666666666666},{0.0,0.6666666666666666,-0.6666666666666666}},"fftfreq/broadcast/float64/3/(2, 1): result",2e-12,2e-12)
eq(result.shape,{2,3},"fftfreq/broadcast/float64/3/(2, 1): result: shape")
eq(result.strides,{24,8},"fftfreq/broadcast/float64/3/(2, 1): result: strides")
eq(result.dtype,"float64","fftfreq/broadcast/float64/3/(2, 1): result: dtype")
eq(spacing:tolist(),{{0.5},{0.5}},"fftfreq/broadcast/float64/3/(2, 1): spacing state")
eq(spacing.shape,{2,1},"fftfreq/broadcast/float64/3/(2, 1): spacing state: shape")
eq(spacing.strides,{8,8},"fftfreq/broadcast/float64/3/(2, 1): spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/broadcast/float64/3/(2, 1): spacing state: dtype")
cases=cases+1
end
-- 392: fftfreq/broadcast/float64/3/(2, 3)
do
local spacing=np.array({{0.5,0.5,0.5},{0.5,0.5,0.5}},"float64")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/broadcast/float64/3/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{{0.0,0.6666666666666666,-0.6666666666666666},{0.0,0.6666666666666666,-0.6666666666666666}},"fftfreq/broadcast/float64/3/(2, 3): result",2e-12,2e-12)
eq(result.shape,{2,3},"fftfreq/broadcast/float64/3/(2, 3): result: shape")
eq(result.strides,{24,8},"fftfreq/broadcast/float64/3/(2, 3): result: strides")
eq(result.dtype,"float64","fftfreq/broadcast/float64/3/(2, 3): result: dtype")
eq(spacing:tolist(),{{0.5,0.5,0.5},{0.5,0.5,0.5}},"fftfreq/broadcast/float64/3/(2, 3): spacing state")
eq(spacing.shape,{2,3},"fftfreq/broadcast/float64/3/(2, 3): spacing state: shape")
eq(spacing.strides,{24,8},"fftfreq/broadcast/float64/3/(2, 3): spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/broadcast/float64/3/(2, 3): spacing state: dtype")
cases=cases+1
end
-- 393: fftfreq/broadcast/float64/4/(1,)
do
local spacing=np.array({0.5},"float64")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/broadcast/float64/4/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.5,-1.0,-0.5},"fftfreq/broadcast/float64/4/(1,): result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/broadcast/float64/4/(1,): result: shape")
eq(result.strides,{8},"fftfreq/broadcast/float64/4/(1,): result: strides")
eq(result.dtype,"float64","fftfreq/broadcast/float64/4/(1,): result: dtype")
eq(spacing:tolist(),{0.5},"fftfreq/broadcast/float64/4/(1,): spacing state")
eq(spacing.shape,{1},"fftfreq/broadcast/float64/4/(1,): spacing state: shape")
eq(spacing.strides,{8},"fftfreq/broadcast/float64/4/(1,): spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/broadcast/float64/4/(1,): spacing state: dtype")
cases=cases+1
end
-- 394: fftfreq/broadcast/float64/4/(3,)
do
local spacing=np.array({0.5,0.5,0.5},"float64")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==false,"fftfreq/broadcast/float64/4/(3,): acceptance"..": "..tostring(result))
eq(spacing:tolist(),{0.5,0.5,0.5},"fftfreq/broadcast/float64/4/(3,): spacing state")
eq(spacing.shape,{3},"fftfreq/broadcast/float64/4/(3,): spacing state: shape")
eq(spacing.strides,{8},"fftfreq/broadcast/float64/4/(3,): spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/broadcast/float64/4/(3,): spacing state: dtype")
cases=cases+1
end
-- 395: fftfreq/broadcast/float64/4/(2, 1)
do
local spacing=np.array({{0.5},{0.5}},"float64")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/broadcast/float64/4/(2, 1): acceptance"..": "..tostring(result))
eq(result:tolist(),{{0.0,0.5,-1.0,-0.5},{0.0,0.5,-1.0,-0.5}},"fftfreq/broadcast/float64/4/(2, 1): result",2e-12,2e-12)
eq(result.shape,{2,4},"fftfreq/broadcast/float64/4/(2, 1): result: shape")
eq(result.strides,{32,8},"fftfreq/broadcast/float64/4/(2, 1): result: strides")
eq(result.dtype,"float64","fftfreq/broadcast/float64/4/(2, 1): result: dtype")
eq(spacing:tolist(),{{0.5},{0.5}},"fftfreq/broadcast/float64/4/(2, 1): spacing state")
eq(spacing.shape,{2,1},"fftfreq/broadcast/float64/4/(2, 1): spacing state: shape")
eq(spacing.strides,{8,8},"fftfreq/broadcast/float64/4/(2, 1): spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/broadcast/float64/4/(2, 1): spacing state: dtype")
cases=cases+1
end
-- 396: fftfreq/broadcast/float64/4/(2, 3)
do
local spacing=np.array({{0.5,0.5,0.5},{0.5,0.5,0.5}},"float64")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==false,"fftfreq/broadcast/float64/4/(2, 3): acceptance"..": "..tostring(result))
eq(spacing:tolist(),{{0.5,0.5,0.5},{0.5,0.5,0.5}},"fftfreq/broadcast/float64/4/(2, 3): spacing state")
eq(spacing.shape,{2,3},"fftfreq/broadcast/float64/4/(2, 3): spacing state: shape")
eq(spacing.strides,{24,8},"fftfreq/broadcast/float64/4/(2, 3): spacing state: strides")
eq(spacing.dtype,"float64","fftfreq/broadcast/float64/4/(2, 3): spacing state: dtype")
cases=cases+1
end
-- 397: fftfreq/broadcast/complex64/0/(1,)
do
local spacing=np.array({np.complex(0.5,0.0)},"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/broadcast/complex64/0/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"fftfreq/broadcast/complex64/0/(1,): result",2e-12,2e-12)
eq(result.shape,{0},"fftfreq/broadcast/complex64/0/(1,): result: shape")
eq(result.strides,{0},"fftfreq/broadcast/complex64/0/(1,): result: strides")
eq(result.dtype,"complex128","fftfreq/broadcast/complex64/0/(1,): result: dtype")
eq(spacing:tolist(),{np.complex(0.5,0.0)},"fftfreq/broadcast/complex64/0/(1,): spacing state")
eq(spacing.shape,{1},"fftfreq/broadcast/complex64/0/(1,): spacing state: shape")
eq(spacing.strides,{8},"fftfreq/broadcast/complex64/0/(1,): spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/broadcast/complex64/0/(1,): spacing state: dtype")
cases=cases+1
end
-- 398: fftfreq/broadcast/complex64/0/(3,)
do
local spacing=np.array({np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==false,"fftfreq/broadcast/complex64/0/(3,): acceptance"..": "..tostring(result))
eq(spacing:tolist(),{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},"fftfreq/broadcast/complex64/0/(3,): spacing state")
eq(spacing.shape,{3},"fftfreq/broadcast/complex64/0/(3,): spacing state: shape")
eq(spacing.strides,{8},"fftfreq/broadcast/complex64/0/(3,): spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/broadcast/complex64/0/(3,): spacing state: dtype")
cases=cases+1
end
-- 399: fftfreq/broadcast/complex64/0/(2, 1)
do
local spacing=np.array({{np.complex(0.5,0.0)},{np.complex(0.5,0.0)}},"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==true,"fftfreq/broadcast/complex64/0/(2, 1): acceptance"..": "..tostring(result))
eq(result:tolist(),{{},{}},"fftfreq/broadcast/complex64/0/(2, 1): result",2e-12,2e-12)
eq(result.shape,{2,0},"fftfreq/broadcast/complex64/0/(2, 1): result: shape")
eq(result.strides,{0,0},"fftfreq/broadcast/complex64/0/(2, 1): result: strides")
eq(result.dtype,"complex128","fftfreq/broadcast/complex64/0/(2, 1): result: dtype")
eq(spacing:tolist(),{{np.complex(0.5,0.0)},{np.complex(0.5,0.0)}},"fftfreq/broadcast/complex64/0/(2, 1): spacing state")
eq(spacing.shape,{2,1},"fftfreq/broadcast/complex64/0/(2, 1): spacing state: shape")
eq(spacing.strides,{8,8},"fftfreq/broadcast/complex64/0/(2, 1): spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/broadcast/complex64/0/(2, 1): spacing state: dtype")
cases=cases+1
end
-- 400: fftfreq/broadcast/complex64/0/(2, 3)
do
local spacing=np.array({{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)}},"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(0,spacing) end)
assert(ok==false,"fftfreq/broadcast/complex64/0/(2, 3): acceptance"..": "..tostring(result))
eq(spacing:tolist(),{{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)}},"fftfreq/broadcast/complex64/0/(2, 3): spacing state")
eq(spacing.shape,{2,3},"fftfreq/broadcast/complex64/0/(2, 3): spacing state: shape")
eq(spacing.strides,{24,8},"fftfreq/broadcast/complex64/0/(2, 3): spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/broadcast/complex64/0/(2, 3): spacing state: dtype")
cases=cases+1
end
-- 401: fftfreq/broadcast/complex64/3/(1,)
do
local spacing=np.array({np.complex(0.5,0.0)},"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/broadcast/complex64/3/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.6666666865348816,0.0),np.complex(-0.6666666865348816,0.0)},"fftfreq/broadcast/complex64/3/(1,): result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/broadcast/complex64/3/(1,): result: shape")
eq(result.strides,{16},"fftfreq/broadcast/complex64/3/(1,): result: strides")
eq(result.dtype,"complex128","fftfreq/broadcast/complex64/3/(1,): result: dtype")
eq(spacing:tolist(),{np.complex(0.5,0.0)},"fftfreq/broadcast/complex64/3/(1,): spacing state")
eq(spacing.shape,{1},"fftfreq/broadcast/complex64/3/(1,): spacing state: shape")
eq(spacing.strides,{8},"fftfreq/broadcast/complex64/3/(1,): spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/broadcast/complex64/3/(1,): spacing state: dtype")
cases=cases+1
end
-- 402: fftfreq/broadcast/complex64/3/(3,)
do
local spacing=np.array({np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/broadcast/complex64/3/(3,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.6666666865348816,0.0),np.complex(-0.6666666865348816,0.0)},"fftfreq/broadcast/complex64/3/(3,): result",2e-12,2e-12)
eq(result.shape,{3},"fftfreq/broadcast/complex64/3/(3,): result: shape")
eq(result.strides,{16},"fftfreq/broadcast/complex64/3/(3,): result: strides")
eq(result.dtype,"complex128","fftfreq/broadcast/complex64/3/(3,): result: dtype")
eq(spacing:tolist(),{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},"fftfreq/broadcast/complex64/3/(3,): spacing state")
eq(spacing.shape,{3},"fftfreq/broadcast/complex64/3/(3,): spacing state: shape")
eq(spacing.strides,{8},"fftfreq/broadcast/complex64/3/(3,): spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/broadcast/complex64/3/(3,): spacing state: dtype")
cases=cases+1
end
-- 403: fftfreq/broadcast/complex64/3/(2, 1)
do
local spacing=np.array({{np.complex(0.5,0.0)},{np.complex(0.5,0.0)}},"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/broadcast/complex64/3/(2, 1): acceptance"..": "..tostring(result))
eq(result:tolist(),{{np.complex(0.0,0.0),np.complex(0.6666666865348816,0.0),np.complex(-0.6666666865348816,0.0)},{np.complex(0.0,0.0),np.complex(0.6666666865348816,0.0),np.complex(-0.6666666865348816,0.0)}},"fftfreq/broadcast/complex64/3/(2, 1): result",2e-12,2e-12)
eq(result.shape,{2,3},"fftfreq/broadcast/complex64/3/(2, 1): result: shape")
eq(result.strides,{48,16},"fftfreq/broadcast/complex64/3/(2, 1): result: strides")
eq(result.dtype,"complex128","fftfreq/broadcast/complex64/3/(2, 1): result: dtype")
eq(spacing:tolist(),{{np.complex(0.5,0.0)},{np.complex(0.5,0.0)}},"fftfreq/broadcast/complex64/3/(2, 1): spacing state")
eq(spacing.shape,{2,1},"fftfreq/broadcast/complex64/3/(2, 1): spacing state: shape")
eq(spacing.strides,{8,8},"fftfreq/broadcast/complex64/3/(2, 1): spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/broadcast/complex64/3/(2, 1): spacing state: dtype")
cases=cases+1
end
-- 404: fftfreq/broadcast/complex64/3/(2, 3)
do
local spacing=np.array({{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)}},"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(3,spacing) end)
assert(ok==true,"fftfreq/broadcast/complex64/3/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{{np.complex(0.0,0.0),np.complex(0.6666666865348816,0.0),np.complex(-0.6666666865348816,0.0)},{np.complex(0.0,0.0),np.complex(0.6666666865348816,0.0),np.complex(-0.6666666865348816,0.0)}},"fftfreq/broadcast/complex64/3/(2, 3): result",2e-12,2e-12)
eq(result.shape,{2,3},"fftfreq/broadcast/complex64/3/(2, 3): result: shape")
eq(result.strides,{48,16},"fftfreq/broadcast/complex64/3/(2, 3): result: strides")
eq(result.dtype,"complex128","fftfreq/broadcast/complex64/3/(2, 3): result: dtype")
eq(spacing:tolist(),{{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)}},"fftfreq/broadcast/complex64/3/(2, 3): spacing state")
eq(spacing.shape,{2,3},"fftfreq/broadcast/complex64/3/(2, 3): spacing state: shape")
eq(spacing.strides,{24,8},"fftfreq/broadcast/complex64/3/(2, 3): spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/broadcast/complex64/3/(2, 3): spacing state: dtype")
cases=cases+1
end
-- 405: fftfreq/broadcast/complex64/4/(1,)
do
local spacing=np.array({np.complex(0.5,0.0)},"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/broadcast/complex64/4/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.5,0.0),np.complex(-1.0,0.0),np.complex(-0.5,0.0)},"fftfreq/broadcast/complex64/4/(1,): result",2e-12,2e-12)
eq(result.shape,{4},"fftfreq/broadcast/complex64/4/(1,): result: shape")
eq(result.strides,{16},"fftfreq/broadcast/complex64/4/(1,): result: strides")
eq(result.dtype,"complex128","fftfreq/broadcast/complex64/4/(1,): result: dtype")
eq(spacing:tolist(),{np.complex(0.5,0.0)},"fftfreq/broadcast/complex64/4/(1,): spacing state")
eq(spacing.shape,{1},"fftfreq/broadcast/complex64/4/(1,): spacing state: shape")
eq(spacing.strides,{8},"fftfreq/broadcast/complex64/4/(1,): spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/broadcast/complex64/4/(1,): spacing state: dtype")
cases=cases+1
end
-- 406: fftfreq/broadcast/complex64/4/(3,)
do
local spacing=np.array({np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==false,"fftfreq/broadcast/complex64/4/(3,): acceptance"..": "..tostring(result))
eq(spacing:tolist(),{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},"fftfreq/broadcast/complex64/4/(3,): spacing state")
eq(spacing.shape,{3},"fftfreq/broadcast/complex64/4/(3,): spacing state: shape")
eq(spacing.strides,{8},"fftfreq/broadcast/complex64/4/(3,): spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/broadcast/complex64/4/(3,): spacing state: dtype")
cases=cases+1
end
-- 407: fftfreq/broadcast/complex64/4/(2, 1)
do
local spacing=np.array({{np.complex(0.5,0.0)},{np.complex(0.5,0.0)}},"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==true,"fftfreq/broadcast/complex64/4/(2, 1): acceptance"..": "..tostring(result))
eq(result:tolist(),{{np.complex(0.0,0.0),np.complex(0.5,0.0),np.complex(-1.0,0.0),np.complex(-0.5,0.0)},{np.complex(0.0,0.0),np.complex(0.5,0.0),np.complex(-1.0,0.0),np.complex(-0.5,0.0)}},"fftfreq/broadcast/complex64/4/(2, 1): result",2e-12,2e-12)
eq(result.shape,{2,4},"fftfreq/broadcast/complex64/4/(2, 1): result: shape")
eq(result.strides,{64,16},"fftfreq/broadcast/complex64/4/(2, 1): result: strides")
eq(result.dtype,"complex128","fftfreq/broadcast/complex64/4/(2, 1): result: dtype")
eq(spacing:tolist(),{{np.complex(0.5,0.0)},{np.complex(0.5,0.0)}},"fftfreq/broadcast/complex64/4/(2, 1): spacing state")
eq(spacing.shape,{2,1},"fftfreq/broadcast/complex64/4/(2, 1): spacing state: shape")
eq(spacing.strides,{8,8},"fftfreq/broadcast/complex64/4/(2, 1): spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/broadcast/complex64/4/(2, 1): spacing state: dtype")
cases=cases+1
end
-- 408: fftfreq/broadcast/complex64/4/(2, 3)
do
local spacing=np.array({{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)}},"complex64")
local ok,result=pcall(function() return np.fft.fftfreq(4,spacing) end)
assert(ok==false,"fftfreq/broadcast/complex64/4/(2, 3): acceptance"..": "..tostring(result))
eq(spacing:tolist(),{{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)}},"fftfreq/broadcast/complex64/4/(2, 3): spacing state")
eq(spacing.shape,{2,3},"fftfreq/broadcast/complex64/4/(2, 3): spacing state: shape")
eq(spacing.strides,{24,8},"fftfreq/broadcast/complex64/4/(2, 3): spacing state: strides")
eq(spacing.dtype,"complex64","fftfreq/broadcast/complex64/4/(2, 3): spacing state: dtype")
cases=cases+1
end
-- 409: fftfreq/2.0/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.fftfreq(2.0,spacing) end)
assert(ok==false,"fftfreq/2.0/1.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 410: fftfreq/2.5/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.fftfreq(2.5,spacing) end)
assert(ok==false,"fftfreq/2.5/1.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 411: fftfreq/4/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.fftfreq("4",spacing) end)
assert(ok==false,"fftfreq/4/1.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 412: fftfreq/True/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.fftfreq(true,spacing) end)
assert(ok==false,"fftfreq/True/1.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 413: fftfreq/False/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.fftfreq(false,spacing) end)
assert(ok==false,"fftfreq/False/1.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 414: rfftfreq/-7/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.rfftfreq(-7,spacing) end)
assert(ok==true,"rfftfreq/-7/1.0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/-7/1.0: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/-7/1.0: result: shape")
eq(result.strides,{0},"rfftfreq/-7/1.0: result: strides")
eq(result.dtype,"float64","rfftfreq/-7/1.0: result: dtype")
cases=cases+1
end
-- 415: rfftfreq/-7/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.rfftfreq(-7,spacing) end)
assert(ok==true,"rfftfreq/-7/0.5: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/-7/0.5: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/-7/0.5: result: shape")
eq(result.strides,{0},"rfftfreq/-7/0.5: result: strides")
eq(result.dtype,"float64","rfftfreq/-7/0.5: result: dtype")
cases=cases+1
end
-- 416: rfftfreq/-7/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.rfftfreq(-7,spacing) end)
assert(ok==true,"rfftfreq/-7/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/-7/2: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/-7/2: result: shape")
eq(result.strides,{0},"rfftfreq/-7/2: result: strides")
eq(result.dtype,"float64","rfftfreq/-7/2: result: dtype")
cases=cases+1
end
-- 417: rfftfreq/-7/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.rfftfreq(-7,spacing) end)
assert(ok==true,"rfftfreq/-7/-0.25: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/-7/-0.25: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/-7/-0.25: result: shape")
eq(result.strides,{0},"rfftfreq/-7/-0.25: result: strides")
eq(result.dtype,"float64","rfftfreq/-7/-0.25: result: dtype")
cases=cases+1
end
-- 418: rfftfreq/-7/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.rfftfreq(-7,spacing) end)
assert(ok==false,"rfftfreq/-7/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 419: rfftfreq/-7/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.rfftfreq(-7,spacing) end)
assert(ok==false,"rfftfreq/-7/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 420: rfftfreq/-7/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.rfftfreq(-7,spacing) end)
assert(ok==true,"rfftfreq/-7/inf: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/-7/inf: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/-7/inf: result: shape")
eq(result.strides,{0},"rfftfreq/-7/inf: result: strides")
eq(result.dtype,"float64","rfftfreq/-7/inf: result: dtype")
cases=cases+1
end
-- 421: rfftfreq/-7/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.rfftfreq(-7,spacing) end)
assert(ok==true,"rfftfreq/-7/nan: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/-7/nan: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/-7/nan: result: shape")
eq(result.strides,{0},"rfftfreq/-7/nan: result: strides")
eq(result.dtype,"float64","rfftfreq/-7/nan: result: dtype")
cases=cases+1
end
-- 422: rfftfreq/-7/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.rfftfreq(-7,spacing) end)
assert(ok==true,"rfftfreq/-7/(1+2j): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/-7/(1+2j): result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/-7/(1+2j): result: shape")
eq(result.strides,{0},"rfftfreq/-7/(1+2j): result: strides")
eq(result.dtype,"complex128","rfftfreq/-7/(1+2j): result: dtype")
cases=cases+1
end
-- 423: rfftfreq/-2/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.rfftfreq(-2,spacing) end)
assert(ok==true,"rfftfreq/-2/1.0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/-2/1.0: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/-2/1.0: result: shape")
eq(result.strides,{0},"rfftfreq/-2/1.0: result: strides")
eq(result.dtype,"float64","rfftfreq/-2/1.0: result: dtype")
cases=cases+1
end
-- 424: rfftfreq/-2/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.rfftfreq(-2,spacing) end)
assert(ok==true,"rfftfreq/-2/0.5: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/-2/0.5: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/-2/0.5: result: shape")
eq(result.strides,{0},"rfftfreq/-2/0.5: result: strides")
eq(result.dtype,"float64","rfftfreq/-2/0.5: result: dtype")
cases=cases+1
end
-- 425: rfftfreq/-2/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.rfftfreq(-2,spacing) end)
assert(ok==true,"rfftfreq/-2/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/-2/2: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/-2/2: result: shape")
eq(result.strides,{0},"rfftfreq/-2/2: result: strides")
eq(result.dtype,"float64","rfftfreq/-2/2: result: dtype")
cases=cases+1
end
-- 426: rfftfreq/-2/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.rfftfreq(-2,spacing) end)
assert(ok==true,"rfftfreq/-2/-0.25: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/-2/-0.25: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/-2/-0.25: result: shape")
eq(result.strides,{0},"rfftfreq/-2/-0.25: result: strides")
eq(result.dtype,"float64","rfftfreq/-2/-0.25: result: dtype")
cases=cases+1
end
-- 427: rfftfreq/-2/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.rfftfreq(-2,spacing) end)
assert(ok==false,"rfftfreq/-2/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 428: rfftfreq/-2/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.rfftfreq(-2,spacing) end)
assert(ok==false,"rfftfreq/-2/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 429: rfftfreq/-2/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.rfftfreq(-2,spacing) end)
assert(ok==true,"rfftfreq/-2/inf: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/-2/inf: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/-2/inf: result: shape")
eq(result.strides,{0},"rfftfreq/-2/inf: result: strides")
eq(result.dtype,"float64","rfftfreq/-2/inf: result: dtype")
cases=cases+1
end
-- 430: rfftfreq/-2/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.rfftfreq(-2,spacing) end)
assert(ok==true,"rfftfreq/-2/nan: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/-2/nan: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/-2/nan: result: shape")
eq(result.strides,{0},"rfftfreq/-2/nan: result: strides")
eq(result.dtype,"float64","rfftfreq/-2/nan: result: dtype")
cases=cases+1
end
-- 431: rfftfreq/-2/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.rfftfreq(-2,spacing) end)
assert(ok==true,"rfftfreq/-2/(1+2j): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/-2/(1+2j): result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/-2/(1+2j): result: shape")
eq(result.strides,{0},"rfftfreq/-2/(1+2j): result: strides")
eq(result.dtype,"complex128","rfftfreq/-2/(1+2j): result: dtype")
cases=cases+1
end
-- 432: rfftfreq/-1/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/-1/1.0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/-1/1.0: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/-1/1.0: result: shape")
eq(result.strides,{0},"rfftfreq/-1/1.0: result: strides")
eq(result.dtype,"float64","rfftfreq/-1/1.0: result: dtype")
cases=cases+1
end
-- 433: rfftfreq/-1/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/-1/0.5: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/-1/0.5: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/-1/0.5: result: shape")
eq(result.strides,{0},"rfftfreq/-1/0.5: result: strides")
eq(result.dtype,"float64","rfftfreq/-1/0.5: result: dtype")
cases=cases+1
end
-- 434: rfftfreq/-1/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/-1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/-1/2: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/-1/2: result: shape")
eq(result.strides,{0},"rfftfreq/-1/2: result: strides")
eq(result.dtype,"float64","rfftfreq/-1/2: result: dtype")
cases=cases+1
end
-- 435: rfftfreq/-1/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/-1/-0.25: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/-1/-0.25: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/-1/-0.25: result: shape")
eq(result.strides,{0},"rfftfreq/-1/-0.25: result: strides")
eq(result.dtype,"float64","rfftfreq/-1/-0.25: result: dtype")
cases=cases+1
end
-- 436: rfftfreq/-1/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==false,"rfftfreq/-1/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 437: rfftfreq/-1/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==false,"rfftfreq/-1/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 438: rfftfreq/-1/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/-1/inf: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/-1/inf: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/-1/inf: result: shape")
eq(result.strides,{0},"rfftfreq/-1/inf: result: strides")
eq(result.dtype,"float64","rfftfreq/-1/inf: result: dtype")
cases=cases+1
end
-- 439: rfftfreq/-1/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/-1/nan: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/-1/nan: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/-1/nan: result: shape")
eq(result.strides,{0},"rfftfreq/-1/nan: result: strides")
eq(result.dtype,"float64","rfftfreq/-1/nan: result: dtype")
cases=cases+1
end
-- 440: rfftfreq/-1/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/-1/(1+2j): acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/-1/(1+2j): result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/-1/(1+2j): result: shape")
eq(result.strides,{0},"rfftfreq/-1/(1+2j): result: strides")
eq(result.dtype,"complex128","rfftfreq/-1/(1+2j): result: dtype")
cases=cases+1
end
-- 441: rfftfreq/0/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==false,"rfftfreq/0/1.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 442: rfftfreq/0/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==false,"rfftfreq/0/0.5: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 443: rfftfreq/0/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==false,"rfftfreq/0/2: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 444: rfftfreq/0/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==false,"rfftfreq/0/-0.25: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 445: rfftfreq/0/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==false,"rfftfreq/0/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 446: rfftfreq/0/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==false,"rfftfreq/0/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 447: rfftfreq/0/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/0/inf: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/0/inf: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/0/inf: result: shape")
eq(result.strides,{8},"rfftfreq/0/inf: result: strides")
eq(result.dtype,"float64","rfftfreq/0/inf: result: dtype")
cases=cases+1
end
-- 448: rfftfreq/0/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/0/nan: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/0/nan: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/0/nan: result: shape")
eq(result.strides,{8},"rfftfreq/0/nan: result: strides")
eq(result.dtype,"float64","rfftfreq/0/nan: result: dtype")
cases=cases+1
end
-- 449: rfftfreq/0/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==false,"rfftfreq/0/(1+2j): acceptance"..": "..tostring(result))
cases=cases+1
end
-- 450: rfftfreq/1/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/1/1.0: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/1/1.0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/1/1.0: result: shape")
eq(result.strides,{8},"rfftfreq/1/1.0: result: strides")
eq(result.dtype,"float64","rfftfreq/1/1.0: result: dtype")
cases=cases+1
end
-- 451: rfftfreq/1/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/1/0.5: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/1/0.5: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/1/0.5: result: shape")
eq(result.strides,{8},"rfftfreq/1/0.5: result: strides")
eq(result.dtype,"float64","rfftfreq/1/0.5: result: dtype")
cases=cases+1
end
-- 452: rfftfreq/1/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/1/2: result: shape")
eq(result.strides,{8},"rfftfreq/1/2: result: strides")
eq(result.dtype,"float64","rfftfreq/1/2: result: dtype")
cases=cases+1
end
-- 453: rfftfreq/1/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/1/-0.25: acceptance"..": "..tostring(result))
eq(result:tolist(),{-0.0},"rfftfreq/1/-0.25: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/1/-0.25: result: shape")
eq(result.strides,{8},"rfftfreq/1/-0.25: result: strides")
eq(result.dtype,"float64","rfftfreq/1/-0.25: result: dtype")
cases=cases+1
end
-- 454: rfftfreq/1/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==false,"rfftfreq/1/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 455: rfftfreq/1/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==false,"rfftfreq/1/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 456: rfftfreq/1/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/1/inf: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/1/inf: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/1/inf: result: shape")
eq(result.strides,{8},"rfftfreq/1/inf: result: strides")
eq(result.dtype,"float64","rfftfreq/1/inf: result: dtype")
cases=cases+1
end
-- 457: rfftfreq/1/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/1/nan: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/1/nan: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/1/nan: result: shape")
eq(result.strides,{8},"rfftfreq/1/nan: result: strides")
eq(result.dtype,"float64","rfftfreq/1/nan: result: dtype")
cases=cases+1
end
-- 458: rfftfreq/1/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/1/(1+2j): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"rfftfreq/1/(1+2j): result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/1/(1+2j): result: shape")
eq(result.strides,{16},"rfftfreq/1/(1+2j): result: strides")
eq(result.dtype,"complex128","rfftfreq/1/(1+2j): result: dtype")
cases=cases+1
end
-- 459: rfftfreq/2/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.rfftfreq(2,spacing) end)
assert(ok==true,"rfftfreq/2/1.0: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.5},"rfftfreq/2/1.0: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/2/1.0: result: shape")
eq(result.strides,{8},"rfftfreq/2/1.0: result: strides")
eq(result.dtype,"float64","rfftfreq/2/1.0: result: dtype")
cases=cases+1
end
-- 460: rfftfreq/2/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.rfftfreq(2,spacing) end)
assert(ok==true,"rfftfreq/2/0.5: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,1.0},"rfftfreq/2/0.5: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/2/0.5: result: shape")
eq(result.strides,{8},"rfftfreq/2/0.5: result: strides")
eq(result.dtype,"float64","rfftfreq/2/0.5: result: dtype")
cases=cases+1
end
-- 461: rfftfreq/2/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.rfftfreq(2,spacing) end)
assert(ok==true,"rfftfreq/2/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25},"rfftfreq/2/2: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/2/2: result: shape")
eq(result.strides,{8},"rfftfreq/2/2: result: strides")
eq(result.dtype,"float64","rfftfreq/2/2: result: dtype")
cases=cases+1
end
-- 462: rfftfreq/2/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.rfftfreq(2,spacing) end)
assert(ok==true,"rfftfreq/2/-0.25: acceptance"..": "..tostring(result))
eq(result:tolist(),{-0.0,-2.0},"rfftfreq/2/-0.25: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/2/-0.25: result: shape")
eq(result.strides,{8},"rfftfreq/2/-0.25: result: strides")
eq(result.dtype,"float64","rfftfreq/2/-0.25: result: dtype")
cases=cases+1
end
-- 463: rfftfreq/2/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.rfftfreq(2,spacing) end)
assert(ok==false,"rfftfreq/2/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 464: rfftfreq/2/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.rfftfreq(2,spacing) end)
assert(ok==false,"rfftfreq/2/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 465: rfftfreq/2/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.rfftfreq(2,spacing) end)
assert(ok==true,"rfftfreq/2/inf: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0},"rfftfreq/2/inf: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/2/inf: result: shape")
eq(result.strides,{8},"rfftfreq/2/inf: result: strides")
eq(result.dtype,"float64","rfftfreq/2/inf: result: dtype")
cases=cases+1
end
-- 466: rfftfreq/2/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.rfftfreq(2,spacing) end)
assert(ok==true,"rfftfreq/2/nan: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),(0/0)},"rfftfreq/2/nan: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/2/nan: result: shape")
eq(result.strides,{8},"rfftfreq/2/nan: result: strides")
eq(result.dtype,"float64","rfftfreq/2/nan: result: dtype")
cases=cases+1
end
-- 467: rfftfreq/2/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.rfftfreq(2,spacing) end)
assert(ok==true,"rfftfreq/2/(1+2j): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.1,-0.2)},"rfftfreq/2/(1+2j): result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/2/(1+2j): result: shape")
eq(result.strides,{16},"rfftfreq/2/(1+2j): result: strides")
eq(result.dtype,"complex128","rfftfreq/2/(1+2j): result: dtype")
cases=cases+1
end
-- 468: rfftfreq/3/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/3/1.0: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.3333333333333333},"rfftfreq/3/1.0: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/3/1.0: result: shape")
eq(result.strides,{8},"rfftfreq/3/1.0: result: strides")
eq(result.dtype,"float64","rfftfreq/3/1.0: result: dtype")
cases=cases+1
end
-- 469: rfftfreq/3/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/3/0.5: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.6666666666666666},"rfftfreq/3/0.5: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/3/0.5: result: shape")
eq(result.strides,{8},"rfftfreq/3/0.5: result: strides")
eq(result.dtype,"float64","rfftfreq/3/0.5: result: dtype")
cases=cases+1
end
-- 470: rfftfreq/3/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.16666666666666666},"rfftfreq/3/2: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/3/2: result: shape")
eq(result.strides,{8},"rfftfreq/3/2: result: strides")
eq(result.dtype,"float64","rfftfreq/3/2: result: dtype")
cases=cases+1
end
-- 471: rfftfreq/3/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/3/-0.25: acceptance"..": "..tostring(result))
eq(result:tolist(),{-0.0,-1.3333333333333333},"rfftfreq/3/-0.25: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/3/-0.25: result: shape")
eq(result.strides,{8},"rfftfreq/3/-0.25: result: strides")
eq(result.dtype,"float64","rfftfreq/3/-0.25: result: dtype")
cases=cases+1
end
-- 472: rfftfreq/3/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==false,"rfftfreq/3/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 473: rfftfreq/3/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==false,"rfftfreq/3/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 474: rfftfreq/3/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/3/inf: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0},"rfftfreq/3/inf: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/3/inf: result: shape")
eq(result.strides,{8},"rfftfreq/3/inf: result: strides")
eq(result.dtype,"float64","rfftfreq/3/inf: result: dtype")
cases=cases+1
end
-- 475: rfftfreq/3/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/3/nan: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),(0/0)},"rfftfreq/3/nan: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/3/nan: result: shape")
eq(result.strides,{8},"rfftfreq/3/nan: result: strides")
eq(result.dtype,"float64","rfftfreq/3/nan: result: dtype")
cases=cases+1
end
-- 476: rfftfreq/3/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/3/(1+2j): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.06666666666666667,-0.13333333333333333)},"rfftfreq/3/(1+2j): result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/3/(1+2j): result: shape")
eq(result.strides,{16},"rfftfreq/3/(1+2j): result: strides")
eq(result.dtype,"complex128","rfftfreq/3/(1+2j): result: dtype")
cases=cases+1
end
-- 477: rfftfreq/4/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/4/1.0: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,0.5},"rfftfreq/4/1.0: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/4/1.0: result: shape")
eq(result.strides,{8},"rfftfreq/4/1.0: result: strides")
eq(result.dtype,"float64","rfftfreq/4/1.0: result: dtype")
cases=cases+1
end
-- 478: rfftfreq/4/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/4/0.5: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.5,1.0},"rfftfreq/4/0.5: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/4/0.5: result: shape")
eq(result.strides,{8},"rfftfreq/4/0.5: result: strides")
eq(result.dtype,"float64","rfftfreq/4/0.5: result: dtype")
cases=cases+1
end
-- 479: rfftfreq/4/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.125,0.25},"rfftfreq/4/2: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/4/2: result: shape")
eq(result.strides,{8},"rfftfreq/4/2: result: strides")
eq(result.dtype,"float64","rfftfreq/4/2: result: dtype")
cases=cases+1
end
-- 480: rfftfreq/4/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/4/-0.25: acceptance"..": "..tostring(result))
eq(result:tolist(),{-0.0,-1.0,-2.0},"rfftfreq/4/-0.25: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/4/-0.25: result: shape")
eq(result.strides,{8},"rfftfreq/4/-0.25: result: strides")
eq(result.dtype,"float64","rfftfreq/4/-0.25: result: dtype")
cases=cases+1
end
-- 481: rfftfreq/4/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==false,"rfftfreq/4/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 482: rfftfreq/4/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==false,"rfftfreq/4/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 483: rfftfreq/4/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/4/inf: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0,0.0},"rfftfreq/4/inf: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/4/inf: result: shape")
eq(result.strides,{8},"rfftfreq/4/inf: result: strides")
eq(result.dtype,"float64","rfftfreq/4/inf: result: dtype")
cases=cases+1
end
-- 484: rfftfreq/4/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/4/nan: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),(0/0),(0/0)},"rfftfreq/4/nan: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/4/nan: result: shape")
eq(result.strides,{8},"rfftfreq/4/nan: result: strides")
eq(result.dtype,"float64","rfftfreq/4/nan: result: dtype")
cases=cases+1
end
-- 485: rfftfreq/4/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/4/(1+2j): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.05,-0.1),np.complex(0.1,-0.2)},"rfftfreq/4/(1+2j): result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/4/(1+2j): result: shape")
eq(result.strides,{16},"rfftfreq/4/(1+2j): result: strides")
eq(result.dtype,"complex128","rfftfreq/4/(1+2j): result: dtype")
cases=cases+1
end
-- 486: rfftfreq/5/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.rfftfreq(5,spacing) end)
assert(ok==true,"rfftfreq/5/1.0: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.2,0.4},"rfftfreq/5/1.0: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/5/1.0: result: shape")
eq(result.strides,{8},"rfftfreq/5/1.0: result: strides")
eq(result.dtype,"float64","rfftfreq/5/1.0: result: dtype")
cases=cases+1
end
-- 487: rfftfreq/5/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.rfftfreq(5,spacing) end)
assert(ok==true,"rfftfreq/5/0.5: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.4,0.8},"rfftfreq/5/0.5: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/5/0.5: result: shape")
eq(result.strides,{8},"rfftfreq/5/0.5: result: strides")
eq(result.dtype,"float64","rfftfreq/5/0.5: result: dtype")
cases=cases+1
end
-- 488: rfftfreq/5/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.rfftfreq(5,spacing) end)
assert(ok==true,"rfftfreq/5/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.1,0.2},"rfftfreq/5/2: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/5/2: result: shape")
eq(result.strides,{8},"rfftfreq/5/2: result: strides")
eq(result.dtype,"float64","rfftfreq/5/2: result: dtype")
cases=cases+1
end
-- 489: rfftfreq/5/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.rfftfreq(5,spacing) end)
assert(ok==true,"rfftfreq/5/-0.25: acceptance"..": "..tostring(result))
eq(result:tolist(),{-0.0,-0.8,-1.6},"rfftfreq/5/-0.25: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/5/-0.25: result: shape")
eq(result.strides,{8},"rfftfreq/5/-0.25: result: strides")
eq(result.dtype,"float64","rfftfreq/5/-0.25: result: dtype")
cases=cases+1
end
-- 490: rfftfreq/5/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.rfftfreq(5,spacing) end)
assert(ok==false,"rfftfreq/5/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 491: rfftfreq/5/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.rfftfreq(5,spacing) end)
assert(ok==false,"rfftfreq/5/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 492: rfftfreq/5/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.rfftfreq(5,spacing) end)
assert(ok==true,"rfftfreq/5/inf: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0,0.0},"rfftfreq/5/inf: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/5/inf: result: shape")
eq(result.strides,{8},"rfftfreq/5/inf: result: strides")
eq(result.dtype,"float64","rfftfreq/5/inf: result: dtype")
cases=cases+1
end
-- 493: rfftfreq/5/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.rfftfreq(5,spacing) end)
assert(ok==true,"rfftfreq/5/nan: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),(0/0),(0/0)},"rfftfreq/5/nan: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/5/nan: result: shape")
eq(result.strides,{8},"rfftfreq/5/nan: result: strides")
eq(result.dtype,"float64","rfftfreq/5/nan: result: dtype")
cases=cases+1
end
-- 494: rfftfreq/5/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.rfftfreq(5,spacing) end)
assert(ok==true,"rfftfreq/5/(1+2j): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.04,-0.08),np.complex(0.08,-0.16)},"rfftfreq/5/(1+2j): result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/5/(1+2j): result: shape")
eq(result.strides,{16},"rfftfreq/5/(1+2j): result: strides")
eq(result.dtype,"complex128","rfftfreq/5/(1+2j): result: dtype")
cases=cases+1
end
-- 495: rfftfreq/8/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.rfftfreq(8,spacing) end)
assert(ok==true,"rfftfreq/8/1.0: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.125,0.25,0.375,0.5},"rfftfreq/8/1.0: result",2e-12,2e-12)
eq(result.shape,{5},"rfftfreq/8/1.0: result: shape")
eq(result.strides,{8},"rfftfreq/8/1.0: result: strides")
eq(result.dtype,"float64","rfftfreq/8/1.0: result: dtype")
cases=cases+1
end
-- 496: rfftfreq/8/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.rfftfreq(8,spacing) end)
assert(ok==true,"rfftfreq/8/0.5: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,0.5,0.75,1.0},"rfftfreq/8/0.5: result",2e-12,2e-12)
eq(result.shape,{5},"rfftfreq/8/0.5: result: shape")
eq(result.strides,{8},"rfftfreq/8/0.5: result: strides")
eq(result.dtype,"float64","rfftfreq/8/0.5: result: dtype")
cases=cases+1
end
-- 497: rfftfreq/8/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.rfftfreq(8,spacing) end)
assert(ok==true,"rfftfreq/8/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0625,0.125,0.1875,0.25},"rfftfreq/8/2: result",2e-12,2e-12)
eq(result.shape,{5},"rfftfreq/8/2: result: shape")
eq(result.strides,{8},"rfftfreq/8/2: result: strides")
eq(result.dtype,"float64","rfftfreq/8/2: result: dtype")
cases=cases+1
end
-- 498: rfftfreq/8/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.rfftfreq(8,spacing) end)
assert(ok==true,"rfftfreq/8/-0.25: acceptance"..": "..tostring(result))
eq(result:tolist(),{-0.0,-0.5,-1.0,-1.5,-2.0},"rfftfreq/8/-0.25: result",2e-12,2e-12)
eq(result.shape,{5},"rfftfreq/8/-0.25: result: shape")
eq(result.strides,{8},"rfftfreq/8/-0.25: result: strides")
eq(result.dtype,"float64","rfftfreq/8/-0.25: result: dtype")
cases=cases+1
end
-- 499: rfftfreq/8/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.rfftfreq(8,spacing) end)
assert(ok==false,"rfftfreq/8/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 500: rfftfreq/8/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.rfftfreq(8,spacing) end)
assert(ok==false,"rfftfreq/8/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
end
chunk()
end
do
local function chunk()
-- 501: rfftfreq/8/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.rfftfreq(8,spacing) end)
assert(ok==true,"rfftfreq/8/inf: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0,0.0,0.0,0.0},"rfftfreq/8/inf: result",2e-12,2e-12)
eq(result.shape,{5},"rfftfreq/8/inf: result: shape")
eq(result.strides,{8},"rfftfreq/8/inf: result: strides")
eq(result.dtype,"float64","rfftfreq/8/inf: result: dtype")
cases=cases+1
end
-- 502: rfftfreq/8/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.rfftfreq(8,spacing) end)
assert(ok==true,"rfftfreq/8/nan: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),(0/0),(0/0),(0/0),(0/0)},"rfftfreq/8/nan: result",2e-12,2e-12)
eq(result.shape,{5},"rfftfreq/8/nan: result: shape")
eq(result.strides,{8},"rfftfreq/8/nan: result: strides")
eq(result.dtype,"float64","rfftfreq/8/nan: result: dtype")
cases=cases+1
end
-- 503: rfftfreq/8/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.rfftfreq(8,spacing) end)
assert(ok==true,"rfftfreq/8/(1+2j): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.025,-0.05),np.complex(0.05,-0.1),np.complex(0.07500000000000001,-0.15000000000000002),np.complex(0.1,-0.2)},"rfftfreq/8/(1+2j): result",2e-12,2e-12)
eq(result.shape,{5},"rfftfreq/8/(1+2j): result: shape")
eq(result.strides,{16},"rfftfreq/8/(1+2j): result: strides")
eq(result.dtype,"complex128","rfftfreq/8/(1+2j): result: dtype")
cases=cases+1
end
-- 504: rfftfreq/15/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/15/1.0: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.06666666666666667,0.13333333333333333,0.2,0.26666666666666666,0.3333333333333333,0.4,0.4666666666666667},"rfftfreq/15/1.0: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/15/1.0: result: shape")
eq(result.strides,{8},"rfftfreq/15/1.0: result: strides")
eq(result.dtype,"float64","rfftfreq/15/1.0: result: dtype")
cases=cases+1
end
-- 505: rfftfreq/15/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/15/0.5: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.13333333333333333,0.26666666666666666,0.4,0.5333333333333333,0.6666666666666666,0.8,0.9333333333333333},"rfftfreq/15/0.5: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/15/0.5: result: shape")
eq(result.strides,{8},"rfftfreq/15/0.5: result: strides")
eq(result.dtype,"float64","rfftfreq/15/0.5: result: dtype")
cases=cases+1
end
-- 506: rfftfreq/15/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.03333333333333333,0.06666666666666667,0.1,0.13333333333333333,0.16666666666666666,0.2,0.23333333333333334},"rfftfreq/15/2: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/15/2: result: shape")
eq(result.strides,{8},"rfftfreq/15/2: result: strides")
eq(result.dtype,"float64","rfftfreq/15/2: result: dtype")
cases=cases+1
end
-- 507: rfftfreq/15/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/15/-0.25: acceptance"..": "..tostring(result))
eq(result:tolist(),{-0.0,-0.26666666666666666,-0.5333333333333333,-0.8,-1.0666666666666667,-1.3333333333333333,-1.6,-1.8666666666666667},"rfftfreq/15/-0.25: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/15/-0.25: result: shape")
eq(result.strides,{8},"rfftfreq/15/-0.25: result: strides")
eq(result.dtype,"float64","rfftfreq/15/-0.25: result: dtype")
cases=cases+1
end
-- 508: rfftfreq/15/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==false,"rfftfreq/15/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 509: rfftfreq/15/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==false,"rfftfreq/15/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 510: rfftfreq/15/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/15/inf: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},"rfftfreq/15/inf: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/15/inf: result: shape")
eq(result.strides,{8},"rfftfreq/15/inf: result: strides")
eq(result.dtype,"float64","rfftfreq/15/inf: result: dtype")
cases=cases+1
end
-- 511: rfftfreq/15/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/15/nan: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0)},"rfftfreq/15/nan: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/15/nan: result: shape")
eq(result.strides,{8},"rfftfreq/15/nan: result: strides")
eq(result.dtype,"float64","rfftfreq/15/nan: result: dtype")
cases=cases+1
end
-- 512: rfftfreq/15/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/15/(1+2j): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.013333333333333334,-0.02666666666666667),np.complex(0.02666666666666667,-0.05333333333333334),np.complex(0.04,-0.08),np.complex(0.05333333333333334,-0.10666666666666667),np.complex(0.06666666666666667,-0.13333333333333333),np.complex(0.08,-0.16),np.complex(0.09333333333333334,-0.18666666666666668)},"rfftfreq/15/(1+2j): result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/15/(1+2j): result: shape")
eq(result.strides,{16},"rfftfreq/15/(1+2j): result: strides")
eq(result.dtype,"complex128","rfftfreq/15/(1+2j): result: dtype")
cases=cases+1
end
-- 513: rfftfreq/127/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/127/1.0: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.007874015748031496,0.015748031496062992,0.023622047244094488,0.031496062992125984,0.03937007874015748,0.047244094488188976,0.05511811023622047,0.06299212598425197,0.07086614173228346,0.07874015748031496,0.08661417322834646,0.09448818897637795,0.10236220472440945,0.11023622047244094,0.11811023622047244,0.12598425196850394,0.13385826771653542,0.14173228346456693,0.14960629921259844,0.15748031496062992,0.1653543307086614,0.1732283464566929,0.18110236220472442,0.1889763779527559,0.19685039370078738,0.2047244094488189,0.2125984251968504,0.2204724409448819,0.22834645669291337,0.23622047244094488,0.2440944881889764,0.25196850393700787,0.25984251968503935,0.26771653543307083,0.2755905511811024,0.28346456692913385,0.29133858267716534,0.2992125984251969,0.30708661417322836,0.31496062992125984,0.3228346456692913,0.3307086614173228,0.33858267716535434,0.3464566929133858,0.3543307086614173,0.36220472440944884,0.3700787401574803,0.3779527559055118,0.3858267716535433,0.39370078740157477,0.4015748031496063,0.4094488188976378,0.41732283464566927,0.4251968503937008,0.4330708661417323,0.4409448818897638,0.44881889763779526,0.45669291338582674,0.4645669291338583,0.47244094488188976,0.48031496062992124,0.4881889763779528,0.49606299212598426},"rfftfreq/127/1.0: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/127/1.0: result: shape")
eq(result.strides,{8},"rfftfreq/127/1.0: result: strides")
eq(result.dtype,"float64","rfftfreq/127/1.0: result: dtype")
cases=cases+1
end
-- 514: rfftfreq/127/0.5
do
local spacing=0.5
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/127/0.5: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.015748031496062992,0.031496062992125984,0.047244094488188976,0.06299212598425197,0.07874015748031496,0.09448818897637795,0.11023622047244094,0.12598425196850394,0.14173228346456693,0.15748031496062992,0.1732283464566929,0.1889763779527559,0.2047244094488189,0.2204724409448819,0.23622047244094488,0.25196850393700787,0.26771653543307083,0.28346456692913385,0.2992125984251969,0.31496062992125984,0.3307086614173228,0.3464566929133858,0.36220472440944884,0.3779527559055118,0.39370078740157477,0.4094488188976378,0.4251968503937008,0.4409448818897638,0.45669291338582674,0.47244094488188976,0.4881889763779528,0.5039370078740157,0.5196850393700787,0.5354330708661417,0.5511811023622047,0.5669291338582677,0.5826771653543307,0.5984251968503937,0.6141732283464567,0.6299212598425197,0.6456692913385826,0.6614173228346456,0.6771653543307087,0.6929133858267716,0.7086614173228346,0.7244094488188977,0.7401574803149606,0.7559055118110236,0.7716535433070866,0.7874015748031495,0.8031496062992126,0.8188976377952756,0.8346456692913385,0.8503937007874016,0.8661417322834646,0.8818897637795275,0.8976377952755905,0.9133858267716535,0.9291338582677166,0.9448818897637795,0.9606299212598425,0.9763779527559056,0.9921259842519685},"rfftfreq/127/0.5: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/127/0.5: result: shape")
eq(result.strides,{8},"rfftfreq/127/0.5: result: strides")
eq(result.dtype,"float64","rfftfreq/127/0.5: result: dtype")
cases=cases+1
end
-- 515: rfftfreq/127/2
do
local spacing=2
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.003937007874015748,0.007874015748031496,0.011811023622047244,0.015748031496062992,0.01968503937007874,0.023622047244094488,0.027559055118110236,0.031496062992125984,0.03543307086614173,0.03937007874015748,0.04330708661417323,0.047244094488188976,0.051181102362204724,0.05511811023622047,0.05905511811023622,0.06299212598425197,0.06692913385826771,0.07086614173228346,0.07480314960629922,0.07874015748031496,0.0826771653543307,0.08661417322834646,0.09055118110236221,0.09448818897637795,0.09842519685039369,0.10236220472440945,0.1062992125984252,0.11023622047244094,0.11417322834645668,0.11811023622047244,0.1220472440944882,0.12598425196850394,0.12992125984251968,0.13385826771653542,0.1377952755905512,0.14173228346456693,0.14566929133858267,0.14960629921259844,0.15354330708661418,0.15748031496062992,0.16141732283464566,0.1653543307086614,0.16929133858267717,0.1732283464566929,0.17716535433070865,0.18110236220472442,0.18503937007874016,0.1889763779527559,0.19291338582677164,0.19685039370078738,0.20078740157480315,0.2047244094488189,0.20866141732283464,0.2125984251968504,0.21653543307086615,0.2204724409448819,0.22440944881889763,0.22834645669291337,0.23228346456692914,0.23622047244094488,0.24015748031496062,0.2440944881889764,0.24803149606299213},"rfftfreq/127/2: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/127/2: result: shape")
eq(result.strides,{8},"rfftfreq/127/2: result: strides")
eq(result.dtype,"float64","rfftfreq/127/2: result: dtype")
cases=cases+1
end
-- 516: rfftfreq/127/-0.25
do
local spacing=-0.25
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/127/-0.25: acceptance"..": "..tostring(result))
eq(result:tolist(),{-0.0,-0.031496062992125984,-0.06299212598425197,-0.09448818897637795,-0.12598425196850394,-0.15748031496062992,-0.1889763779527559,-0.2204724409448819,-0.25196850393700787,-0.28346456692913385,-0.31496062992125984,-0.3464566929133858,-0.3779527559055118,-0.4094488188976378,-0.4409448818897638,-0.47244094488188976,-0.5039370078740157,-0.5354330708661417,-0.5669291338582677,-0.5984251968503937,-0.6299212598425197,-0.6614173228346456,-0.6929133858267716,-0.7244094488188977,-0.7559055118110236,-0.7874015748031495,-0.8188976377952756,-0.8503937007874016,-0.8818897637795275,-0.9133858267716535,-0.9448818897637795,-0.9763779527559056,-1.0078740157480315,-1.0393700787401574,-1.0708661417322833,-1.1023622047244095,-1.1338582677165354,-1.1653543307086613,-1.1968503937007875,-1.2283464566929134,-1.2598425196850394,-1.2913385826771653,-1.3228346456692912,-1.3543307086614174,-1.3858267716535433,-1.4173228346456692,-1.4488188976377954,-1.4803149606299213,-1.5118110236220472,-1.5433070866141732,-1.574803149606299,-1.6062992125984252,-1.6377952755905512,-1.669291338582677,-1.7007874015748032,-1.7322834645669292,-1.763779527559055,-1.795275590551181,-1.826771653543307,-1.858267716535433,-1.889763779527559,-1.921259842519685,-1.952755905511811,-1.984251968503937},"rfftfreq/127/-0.25: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/127/-0.25: result: shape")
eq(result.strides,{8},"rfftfreq/127/-0.25: result: strides")
eq(result.dtype,"float64","rfftfreq/127/-0.25: result: dtype")
cases=cases+1
end
-- 517: rfftfreq/127/0
do
local spacing=0
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==false,"rfftfreq/127/0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 518: rfftfreq/127/-0.0
do
local spacing=-0.0
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==false,"rfftfreq/127/-0.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 519: rfftfreq/127/inf
do
local spacing=math.huge
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/127/inf: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0},"rfftfreq/127/inf: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/127/inf: result: shape")
eq(result.strides,{8},"rfftfreq/127/inf: result: strides")
eq(result.dtype,"float64","rfftfreq/127/inf: result: dtype")
cases=cases+1
end
-- 520: rfftfreq/127/nan
do
local spacing=(0/0)
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/127/nan: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0),(0/0)},"rfftfreq/127/nan: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/127/nan: result: shape")
eq(result.strides,{8},"rfftfreq/127/nan: result: strides")
eq(result.dtype,"float64","rfftfreq/127/nan: result: dtype")
cases=cases+1
end
-- 521: rfftfreq/127/(1+2j)
do
local spacing=np.complex(1.0,2.0)
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/127/(1+2j): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.0015748031496062992,-0.0031496062992125984),np.complex(0.0031496062992125984,-0.006299212598425197),np.complex(0.004724409448818898,-0.009448818897637795),np.complex(0.006299212598425197,-0.012598425196850394),np.complex(0.007874015748031496,-0.015748031496062992),np.complex(0.009448818897637795,-0.01889763779527559),np.complex(0.011023622047244094,-0.02204724409448819),np.complex(0.012598425196850394,-0.025196850393700787),np.complex(0.014173228346456693,-0.028346456692913385),np.complex(0.015748031496062992,-0.031496062992125984),np.complex(0.01732283464566929,-0.03464566929133858),np.complex(0.01889763779527559,-0.03779527559055118),np.complex(0.02047244094488189,-0.04094488188976378),np.complex(0.02204724409448819,-0.04409448818897638),np.complex(0.023622047244094488,-0.047244094488188976),np.complex(0.025196850393700787,-0.050393700787401574),np.complex(0.026771653543307086,-0.05354330708661417),np.complex(0.028346456692913385,-0.05669291338582677),np.complex(0.029921259842519685,-0.05984251968503937),np.complex(0.031496062992125984,-0.06299212598425197),np.complex(0.03307086614173228,-0.06614173228346457),np.complex(0.03464566929133858,-0.06929133858267716),np.complex(0.03622047244094488,-0.07244094488188976),np.complex(0.03779527559055118,-0.07559055118110236),np.complex(0.03937007874015748,-0.07874015748031496),np.complex(0.04094488188976378,-0.08188976377952756),np.complex(0.04251968503937008,-0.08503937007874016),np.complex(0.04409448818897638,-0.08818897637795275),np.complex(0.04566929133858268,-0.09133858267716535),np.complex(0.047244094488188976,-0.09448818897637795),np.complex(0.048818897637795275,-0.09763779527559055),np.complex(0.050393700787401574,-0.10078740157480315),np.complex(0.05196850393700787,-0.10393700787401575),np.complex(0.05354330708661417,-0.10708661417322834),np.complex(0.05511811023622047,-0.11023622047244094),np.complex(0.05669291338582677,-0.11338582677165354),np.complex(0.05826771653543307,-0.11653543307086614),np.complex(0.05984251968503937,-0.11968503937007874),np.complex(0.06141732283464567,-0.12283464566929134),np.complex(0.06299212598425197,-0.12598425196850394),np.complex(0.06456692913385827,-0.12913385826771653),np.complex(0.06614173228346457,-0.13228346456692913),np.complex(0.06771653543307087,-0.13543307086614173),np.complex(0.06929133858267716,-0.13858267716535433),np.complex(0.07086614173228346,-0.14173228346456693),np.complex(0.07244094488188976,-0.14488188976377953),np.complex(0.07401574803149606,-0.14803149606299212),np.complex(0.07559055118110236,-0.15118110236220472),np.complex(0.07716535433070866,-0.15433070866141732),np.complex(0.07874015748031496,-0.15748031496062992),np.complex(0.08031496062992126,-0.16062992125984252),np.complex(0.08188976377952756,-0.16377952755905512),np.complex(0.08346456692913386,-0.16692913385826771),np.complex(0.08503937007874016,-0.1700787401574803),np.complex(0.08661417322834646,-0.1732283464566929),np.complex(0.08818897637795275,-0.1763779527559055),np.complex(0.08976377952755905,-0.1795275590551181),np.complex(0.09133858267716535,-0.1826771653543307),np.complex(0.09291338582677165,-0.1858267716535433),np.complex(0.09448818897637795,-0.1889763779527559),np.complex(0.09606299212598425,-0.1921259842519685),np.complex(0.09763779527559055,-0.1952755905511811),np.complex(0.09921259842519685,-0.1984251968503937)},"rfftfreq/127/(1+2j): result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/127/(1+2j): result: shape")
eq(result.strides,{16},"rfftfreq/127/(1+2j): result: strides")
eq(result.dtype,"complex128","rfftfreq/127/(1+2j): result: dtype")
cases=cases+1
end
-- 522: rfftfreq/typed/bool/-1/0
do
local spacing=np.array(false,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/-1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/bool/-1/0: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/bool/-1/0: result: shape")
eq(result.strides,{0},"rfftfreq/typed/bool/-1/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/-1/0: result: dtype")
eq(spacing:tolist(),false,"rfftfreq/typed/bool/-1/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/-1/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/-1/0: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/-1/0: spacing state: dtype")
cases=cases+1
end
-- 523: rfftfreq/typed/bool/-1/1
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/-1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/bool/-1/1: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/bool/-1/1: result: shape")
eq(result.strides,{0},"rfftfreq/typed/bool/-1/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/-1/1: result: dtype")
eq(spacing:tolist(),true,"rfftfreq/typed/bool/-1/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/-1/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/-1/1: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/-1/1: spacing state: dtype")
cases=cases+1
end
-- 524: rfftfreq/typed/bool/-1/2
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/-1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/bool/-1/2: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/bool/-1/2: result: shape")
eq(result.strides,{0},"rfftfreq/typed/bool/-1/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/-1/2: result: dtype")
eq(spacing:tolist(),true,"rfftfreq/typed/bool/-1/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/-1/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/-1/2: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/-1/2: spacing state: dtype")
cases=cases+1
end
-- 525: rfftfreq/typed/bool/0/0
do
local spacing=np.array(false,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/0/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/bool/0/0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/bool/0/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/bool/0/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/0/0: result: dtype")
eq(spacing:tolist(),false,"rfftfreq/typed/bool/0/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/0/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/0/0: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/0/0: spacing state: dtype")
cases=cases+1
end
-- 526: rfftfreq/typed/bool/0/1
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/0/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/bool/0/1: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/bool/0/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/bool/0/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/0/1: result: dtype")
eq(spacing:tolist(),true,"rfftfreq/typed/bool/0/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/0/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/0/1: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/0/1: spacing state: dtype")
cases=cases+1
end
-- 527: rfftfreq/typed/bool/0/2
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/0/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/bool/0/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/bool/0/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/bool/0/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/0/2: result: dtype")
eq(spacing:tolist(),true,"rfftfreq/typed/bool/0/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/0/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/0/2: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/0/2: spacing state: dtype")
cases=cases+1
end
-- 528: rfftfreq/typed/bool/1/0
do
local spacing=np.array(false,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/bool/1/0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/bool/1/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/bool/1/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/1/0: result: dtype")
eq(spacing:tolist(),false,"rfftfreq/typed/bool/1/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/1/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/1/0: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/1/0: spacing state: dtype")
cases=cases+1
end
-- 529: rfftfreq/typed/bool/1/1
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/typed/bool/1/1: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/bool/1/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/bool/1/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/1/1: result: dtype")
eq(spacing:tolist(),true,"rfftfreq/typed/bool/1/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/1/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/1/1: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/1/1: spacing state: dtype")
cases=cases+1
end
-- 530: rfftfreq/typed/bool/1/2
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/typed/bool/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/bool/1/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/bool/1/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/1/2: result: dtype")
eq(spacing:tolist(),true,"rfftfreq/typed/bool/1/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/1/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/1/2: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/1/2: spacing state: dtype")
cases=cases+1
end
-- 531: rfftfreq/typed/bool/3/0
do
local spacing=np.array(false,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/3/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge},"rfftfreq/typed/bool/3/0: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/bool/3/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/bool/3/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/3/0: result: dtype")
eq(spacing:tolist(),false,"rfftfreq/typed/bool/3/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/3/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/3/0: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/3/0: spacing state: dtype")
cases=cases+1
end
-- 532: rfftfreq/typed/bool/3/1
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/3/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.3333333333333333},"rfftfreq/typed/bool/3/1: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/bool/3/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/bool/3/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/3/1: result: dtype")
eq(spacing:tolist(),true,"rfftfreq/typed/bool/3/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/3/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/3/1: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/3/1: spacing state: dtype")
cases=cases+1
end
-- 533: rfftfreq/typed/bool/3/2
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.3333333333333333},"rfftfreq/typed/bool/3/2: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/bool/3/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/bool/3/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/3/2: result: dtype")
eq(spacing:tolist(),true,"rfftfreq/typed/bool/3/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/3/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/3/2: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/3/2: spacing state: dtype")
cases=cases+1
end
-- 534: rfftfreq/typed/bool/4/0
do
local spacing=np.array(false,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/4/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge},"rfftfreq/typed/bool/4/0: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/bool/4/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/bool/4/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/4/0: result: dtype")
eq(spacing:tolist(),false,"rfftfreq/typed/bool/4/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/4/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/4/0: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/4/0: spacing state: dtype")
cases=cases+1
end
-- 535: rfftfreq/typed/bool/4/1
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/4/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,0.5},"rfftfreq/typed/bool/4/1: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/bool/4/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/bool/4/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/4/1: result: dtype")
eq(spacing:tolist(),true,"rfftfreq/typed/bool/4/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/4/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/4/1: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/4/1: spacing state: dtype")
cases=cases+1
end
-- 536: rfftfreq/typed/bool/4/2
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,0.5},"rfftfreq/typed/bool/4/2: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/bool/4/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/bool/4/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/4/2: result: dtype")
eq(spacing:tolist(),true,"rfftfreq/typed/bool/4/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/4/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/4/2: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/4/2: spacing state: dtype")
cases=cases+1
end
-- 537: rfftfreq/typed/bool/15/0
do
local spacing=np.array(false,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/15/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/bool/15/0: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/bool/15/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/bool/15/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/15/0: result: dtype")
eq(spacing:tolist(),false,"rfftfreq/typed/bool/15/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/15/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/15/0: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/15/0: spacing state: dtype")
cases=cases+1
end
-- 538: rfftfreq/typed/bool/15/1
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/15/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.06666666666666667,0.13333333333333333,0.2,0.26666666666666666,0.3333333333333333,0.4,0.4666666666666667},"rfftfreq/typed/bool/15/1: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/bool/15/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/bool/15/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/15/1: result: dtype")
eq(spacing:tolist(),true,"rfftfreq/typed/bool/15/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/15/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/15/1: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/15/1: spacing state: dtype")
cases=cases+1
end
-- 539: rfftfreq/typed/bool/15/2
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.06666666666666667,0.13333333333333333,0.2,0.26666666666666666,0.3333333333333333,0.4,0.4666666666666667},"rfftfreq/typed/bool/15/2: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/bool/15/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/bool/15/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/15/2: result: dtype")
eq(spacing:tolist(),true,"rfftfreq/typed/bool/15/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/15/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/15/2: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/15/2: spacing state: dtype")
cases=cases+1
end
-- 540: rfftfreq/typed/bool/127/0
do
local spacing=np.array(false,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/127/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/bool/127/0: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/bool/127/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/bool/127/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/127/0: result: dtype")
eq(spacing:tolist(),false,"rfftfreq/typed/bool/127/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/127/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/127/0: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/127/0: spacing state: dtype")
cases=cases+1
end
-- 541: rfftfreq/typed/bool/127/1
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/127/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.007874015748031496,0.015748031496062992,0.023622047244094488,0.031496062992125984,0.03937007874015748,0.047244094488188976,0.05511811023622047,0.06299212598425197,0.07086614173228346,0.07874015748031496,0.08661417322834646,0.09448818897637795,0.10236220472440945,0.11023622047244094,0.11811023622047244,0.12598425196850394,0.13385826771653542,0.14173228346456693,0.14960629921259844,0.15748031496062992,0.1653543307086614,0.1732283464566929,0.18110236220472442,0.1889763779527559,0.19685039370078738,0.2047244094488189,0.2125984251968504,0.2204724409448819,0.22834645669291337,0.23622047244094488,0.2440944881889764,0.25196850393700787,0.25984251968503935,0.26771653543307083,0.2755905511811024,0.28346456692913385,0.29133858267716534,0.2992125984251969,0.30708661417322836,0.31496062992125984,0.3228346456692913,0.3307086614173228,0.33858267716535434,0.3464566929133858,0.3543307086614173,0.36220472440944884,0.3700787401574803,0.3779527559055118,0.3858267716535433,0.39370078740157477,0.4015748031496063,0.4094488188976378,0.41732283464566927,0.4251968503937008,0.4330708661417323,0.4409448818897638,0.44881889763779526,0.45669291338582674,0.4645669291338583,0.47244094488188976,0.48031496062992124,0.4881889763779528,0.49606299212598426},"rfftfreq/typed/bool/127/1: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/bool/127/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/bool/127/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/127/1: result: dtype")
eq(spacing:tolist(),true,"rfftfreq/typed/bool/127/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/127/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/127/1: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/127/1: spacing state: dtype")
cases=cases+1
end
-- 542: rfftfreq/typed/bool/127/2
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.007874015748031496,0.015748031496062992,0.023622047244094488,0.031496062992125984,0.03937007874015748,0.047244094488188976,0.05511811023622047,0.06299212598425197,0.07086614173228346,0.07874015748031496,0.08661417322834646,0.09448818897637795,0.10236220472440945,0.11023622047244094,0.11811023622047244,0.12598425196850394,0.13385826771653542,0.14173228346456693,0.14960629921259844,0.15748031496062992,0.1653543307086614,0.1732283464566929,0.18110236220472442,0.1889763779527559,0.19685039370078738,0.2047244094488189,0.2125984251968504,0.2204724409448819,0.22834645669291337,0.23622047244094488,0.2440944881889764,0.25196850393700787,0.25984251968503935,0.26771653543307083,0.2755905511811024,0.28346456692913385,0.29133858267716534,0.2992125984251969,0.30708661417322836,0.31496062992125984,0.3228346456692913,0.3307086614173228,0.33858267716535434,0.3464566929133858,0.3543307086614173,0.36220472440944884,0.3700787401574803,0.3779527559055118,0.3858267716535433,0.39370078740157477,0.4015748031496063,0.4094488188976378,0.41732283464566927,0.4251968503937008,0.4330708661417323,0.4409448818897638,0.44881889763779526,0.45669291338582674,0.4645669291338583,0.47244094488188976,0.48031496062992124,0.4881889763779528,0.49606299212598426},"rfftfreq/typed/bool/127/2: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/bool/127/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/bool/127/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/127/2: result: dtype")
eq(spacing:tolist(),true,"rfftfreq/typed/bool/127/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/127/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/127/2: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/127/2: spacing state: dtype")
cases=cases+1
end
-- 543: rfftfreq/typed/bool/128/0
do
local spacing=np.array(false,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/128/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/bool/128/0: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/bool/128/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/bool/128/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/128/0: result: dtype")
eq(spacing:tolist(),false,"rfftfreq/typed/bool/128/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/128/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/128/0: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/128/0: spacing state: dtype")
cases=cases+1
end
-- 544: rfftfreq/typed/bool/128/1
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/128/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0078125,0.015625,0.0234375,0.03125,0.0390625,0.046875,0.0546875,0.0625,0.0703125,0.078125,0.0859375,0.09375,0.1015625,0.109375,0.1171875,0.125,0.1328125,0.140625,0.1484375,0.15625,0.1640625,0.171875,0.1796875,0.1875,0.1953125,0.203125,0.2109375,0.21875,0.2265625,0.234375,0.2421875,0.25,0.2578125,0.265625,0.2734375,0.28125,0.2890625,0.296875,0.3046875,0.3125,0.3203125,0.328125,0.3359375,0.34375,0.3515625,0.359375,0.3671875,0.375,0.3828125,0.390625,0.3984375,0.40625,0.4140625,0.421875,0.4296875,0.4375,0.4453125,0.453125,0.4609375,0.46875,0.4765625,0.484375,0.4921875,0.5},"rfftfreq/typed/bool/128/1: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/bool/128/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/bool/128/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/128/1: result: dtype")
eq(spacing:tolist(),true,"rfftfreq/typed/bool/128/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/128/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/128/1: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/128/1: spacing state: dtype")
cases=cases+1
end
-- 545: rfftfreq/typed/bool/128/2
do
local spacing=np.array(true,"bool")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/bool/128/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0078125,0.015625,0.0234375,0.03125,0.0390625,0.046875,0.0546875,0.0625,0.0703125,0.078125,0.0859375,0.09375,0.1015625,0.109375,0.1171875,0.125,0.1328125,0.140625,0.1484375,0.15625,0.1640625,0.171875,0.1796875,0.1875,0.1953125,0.203125,0.2109375,0.21875,0.2265625,0.234375,0.2421875,0.25,0.2578125,0.265625,0.2734375,0.28125,0.2890625,0.296875,0.3046875,0.3125,0.3203125,0.328125,0.3359375,0.34375,0.3515625,0.359375,0.3671875,0.375,0.3828125,0.390625,0.3984375,0.40625,0.4140625,0.421875,0.4296875,0.4375,0.4453125,0.453125,0.4609375,0.46875,0.4765625,0.484375,0.4921875,0.5},"rfftfreq/typed/bool/128/2: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/bool/128/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/bool/128/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/bool/128/2: result: dtype")
eq(spacing:tolist(),true,"rfftfreq/typed/bool/128/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/bool/128/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/bool/128/2: spacing state: strides")
eq(spacing.dtype,"bool","rfftfreq/typed/bool/128/2: spacing state: dtype")
cases=cases+1
end
-- 546: rfftfreq/typed/int8/-1/0
do
local spacing=np.array(0,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/int8/-1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/int8/-1/0: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/int8/-1/0: result: shape")
eq(result.strides,{0},"rfftfreq/typed/int8/-1/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int8/-1/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int8/-1/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/-1/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/-1/0: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/-1/0: spacing state: dtype")
cases=cases+1
end
-- 547: rfftfreq/typed/int8/-1/1
do
local spacing=np.array(1,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/int8/-1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/int8/-1/1: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/int8/-1/1: result: shape")
eq(result.strides,{0},"rfftfreq/typed/int8/-1/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int8/-1/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int8/-1/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/-1/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/-1/1: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/-1/1: spacing state: dtype")
cases=cases+1
end
-- 548: rfftfreq/typed/int8/-1/2
do
local spacing=np.array(2,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/int8/-1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/int8/-1/2: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/int8/-1/2: result: shape")
eq(result.strides,{0},"rfftfreq/typed/int8/-1/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int8/-1/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int8/-1/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/-1/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/-1/2: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/-1/2: spacing state: dtype")
cases=cases+1
end
-- 549: rfftfreq/typed/int8/0/0
do
local spacing=np.array(0,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/int8/0/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/int8/0/0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/int8/0/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int8/0/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int8/0/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int8/0/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/0/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/0/0: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/0/0: spacing state: dtype")
cases=cases+1
end
-- 550: rfftfreq/typed/int8/0/1
do
local spacing=np.array(1,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/int8/0/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/int8/0/1: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/int8/0/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int8/0/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int8/0/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int8/0/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/0/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/0/1: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/0/1: spacing state: dtype")
cases=cases+1
end
-- 551: rfftfreq/typed/int8/0/2
do
local spacing=np.array(2,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/int8/0/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/int8/0/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/int8/0/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int8/0/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int8/0/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int8/0/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/0/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/0/2: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/0/2: spacing state: dtype")
cases=cases+1
end
-- 552: rfftfreq/typed/int8/1/0
do
local spacing=np.array(0,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/int8/1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/int8/1/0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/int8/1/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int8/1/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int8/1/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int8/1/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/1/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/1/0: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/1/0: spacing state: dtype")
cases=cases+1
end
-- 553: rfftfreq/typed/int8/1/1
do
local spacing=np.array(1,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/int8/1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/typed/int8/1/1: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/int8/1/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int8/1/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int8/1/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int8/1/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/1/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/1/1: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/1/1: spacing state: dtype")
cases=cases+1
end
-- 554: rfftfreq/typed/int8/1/2
do
local spacing=np.array(2,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/int8/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/typed/int8/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/int8/1/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int8/1/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int8/1/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int8/1/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/1/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/1/2: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/1/2: spacing state: dtype")
cases=cases+1
end
-- 555: rfftfreq/typed/int8/3/0
do
local spacing=np.array(0,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/int8/3/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge},"rfftfreq/typed/int8/3/0: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/int8/3/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int8/3/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int8/3/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int8/3/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/3/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/3/0: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/3/0: spacing state: dtype")
cases=cases+1
end
-- 556: rfftfreq/typed/int8/3/1
do
local spacing=np.array(1,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/int8/3/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.3333333333333333},"rfftfreq/typed/int8/3/1: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/int8/3/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int8/3/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int8/3/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int8/3/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/3/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/3/1: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/3/1: spacing state: dtype")
cases=cases+1
end
-- 557: rfftfreq/typed/int8/3/2
do
local spacing=np.array(2,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/int8/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.16666666666666666},"rfftfreq/typed/int8/3/2: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/int8/3/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int8/3/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int8/3/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int8/3/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/3/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/3/2: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/3/2: spacing state: dtype")
cases=cases+1
end
-- 558: rfftfreq/typed/int8/4/0
do
local spacing=np.array(0,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/int8/4/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge},"rfftfreq/typed/int8/4/0: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/int8/4/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int8/4/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int8/4/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int8/4/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/4/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/4/0: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/4/0: spacing state: dtype")
cases=cases+1
end
-- 559: rfftfreq/typed/int8/4/1
do
local spacing=np.array(1,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/int8/4/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,0.5},"rfftfreq/typed/int8/4/1: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/int8/4/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int8/4/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int8/4/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int8/4/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/4/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/4/1: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/4/1: spacing state: dtype")
cases=cases+1
end
-- 560: rfftfreq/typed/int8/4/2
do
local spacing=np.array(2,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/int8/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.125,0.25},"rfftfreq/typed/int8/4/2: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/int8/4/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int8/4/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int8/4/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int8/4/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/4/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/4/2: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/4/2: spacing state: dtype")
cases=cases+1
end
-- 561: rfftfreq/typed/int8/15/0
do
local spacing=np.array(0,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/int8/15/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/int8/15/0: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/int8/15/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int8/15/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int8/15/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int8/15/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/15/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/15/0: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/15/0: spacing state: dtype")
cases=cases+1
end
-- 562: rfftfreq/typed/int8/15/1
do
local spacing=np.array(1,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/int8/15/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.06666666666666667,0.13333333333333333,0.2,0.26666666666666666,0.3333333333333333,0.4,0.4666666666666667},"rfftfreq/typed/int8/15/1: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/int8/15/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int8/15/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int8/15/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int8/15/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/15/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/15/1: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/15/1: spacing state: dtype")
cases=cases+1
end
-- 563: rfftfreq/typed/int8/15/2
do
local spacing=np.array(2,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/int8/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.03333333333333333,0.06666666666666667,0.1,0.13333333333333333,0.16666666666666666,0.2,0.23333333333333334},"rfftfreq/typed/int8/15/2: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/int8/15/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int8/15/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int8/15/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int8/15/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/15/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/15/2: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/15/2: spacing state: dtype")
cases=cases+1
end
-- 564: rfftfreq/typed/int8/127/0
do
local spacing=np.array(0,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/int8/127/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/int8/127/0: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/int8/127/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int8/127/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int8/127/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int8/127/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/127/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/127/0: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/127/0: spacing state: dtype")
cases=cases+1
end
-- 565: rfftfreq/typed/int8/127/1
do
local spacing=np.array(1,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/int8/127/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.007874015748031496,0.015748031496062992,0.023622047244094488,0.031496062992125984,0.03937007874015748,0.047244094488188976,0.05511811023622047,0.06299212598425197,0.07086614173228346,0.07874015748031496,0.08661417322834646,0.09448818897637795,0.10236220472440945,0.11023622047244094,0.11811023622047244,0.12598425196850394,0.13385826771653542,0.14173228346456693,0.14960629921259844,0.15748031496062992,0.1653543307086614,0.1732283464566929,0.18110236220472442,0.1889763779527559,0.19685039370078738,0.2047244094488189,0.2125984251968504,0.2204724409448819,0.22834645669291337,0.23622047244094488,0.2440944881889764,0.25196850393700787,0.25984251968503935,0.26771653543307083,0.2755905511811024,0.28346456692913385,0.29133858267716534,0.2992125984251969,0.30708661417322836,0.31496062992125984,0.3228346456692913,0.3307086614173228,0.33858267716535434,0.3464566929133858,0.3543307086614173,0.36220472440944884,0.3700787401574803,0.3779527559055118,0.3858267716535433,0.39370078740157477,0.4015748031496063,0.4094488188976378,0.41732283464566927,0.4251968503937008,0.4330708661417323,0.4409448818897638,0.44881889763779526,0.45669291338582674,0.4645669291338583,0.47244094488188976,0.48031496062992124,0.4881889763779528,0.49606299212598426},"rfftfreq/typed/int8/127/1: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/int8/127/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int8/127/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int8/127/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int8/127/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/127/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/127/1: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/127/1: spacing state: dtype")
cases=cases+1
end
-- 566: rfftfreq/typed/int8/127/2
do
local spacing=np.array(2,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/int8/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{-0.0,-0.5,-1.0,-1.5,-2.0,-2.5,-3.0,-3.5,-4.0,-4.5,-5.0,-5.5,-6.0,-6.5,-7.0,-7.5,-8.0,-8.5,-9.0,-9.5,-10.0,-10.5,-11.0,-11.5,-12.0,-12.5,-13.0,-13.5,-14.0,-14.5,-15.0,-15.5,-16.0,-16.5,-17.0,-17.5,-18.0,-18.5,-19.0,-19.5,-20.0,-20.5,-21.0,-21.5,-22.0,-22.5,-23.0,-23.5,-24.0,-24.5,-25.0,-25.5,-26.0,-26.5,-27.0,-27.5,-28.0,-28.5,-29.0,-29.5,-30.0,-30.5,-31.0,-31.5},"rfftfreq/typed/int8/127/2: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/int8/127/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int8/127/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int8/127/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int8/127/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/127/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/127/2: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/127/2: spacing state: dtype")
cases=cases+1
end
-- 567: rfftfreq/typed/int8/128/0
do
local spacing=np.array(0,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==false,"rfftfreq/typed/int8/128/0: acceptance"..": "..tostring(result))
eq(spacing:tolist(),0,"rfftfreq/typed/int8/128/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/128/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/128/0: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/128/0: spacing state: dtype")
cases=cases+1
end
-- 568: rfftfreq/typed/int8/128/1
do
local spacing=np.array(1,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==false,"rfftfreq/typed/int8/128/1: acceptance"..": "..tostring(result))
eq(spacing:tolist(),1,"rfftfreq/typed/int8/128/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/128/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/128/1: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/128/1: spacing state: dtype")
cases=cases+1
end
-- 569: rfftfreq/typed/int8/128/2
do
local spacing=np.array(2,"int8")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==false,"rfftfreq/typed/int8/128/2: acceptance"..": "..tostring(result))
eq(spacing:tolist(),2,"rfftfreq/typed/int8/128/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int8/128/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int8/128/2: spacing state: strides")
eq(spacing.dtype,"int8","rfftfreq/typed/int8/128/2: spacing state: dtype")
cases=cases+1
end
-- 570: rfftfreq/typed/uint8/-1/0
do
local spacing=np.array(0,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==false,"rfftfreq/typed/uint8/-1/0: acceptance"..": "..tostring(result))
eq(spacing:tolist(),0,"rfftfreq/typed/uint8/-1/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/-1/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/-1/0: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/-1/0: spacing state: dtype")
cases=cases+1
end
-- 571: rfftfreq/typed/uint8/-1/1
do
local spacing=np.array(1,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==false,"rfftfreq/typed/uint8/-1/1: acceptance"..": "..tostring(result))
eq(spacing:tolist(),1,"rfftfreq/typed/uint8/-1/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/-1/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/-1/1: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/-1/1: spacing state: dtype")
cases=cases+1
end
-- 572: rfftfreq/typed/uint8/-1/2
do
local spacing=np.array(2,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==false,"rfftfreq/typed/uint8/-1/2: acceptance"..": "..tostring(result))
eq(spacing:tolist(),2,"rfftfreq/typed/uint8/-1/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/-1/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/-1/2: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/-1/2: spacing state: dtype")
cases=cases+1
end
-- 573: rfftfreq/typed/uint8/0/0
do
local spacing=np.array(0,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/uint8/0/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/uint8/0/0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/uint8/0/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint8/0/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint8/0/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/uint8/0/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/0/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/0/0: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/0/0: spacing state: dtype")
cases=cases+1
end
-- 574: rfftfreq/typed/uint8/0/1
do
local spacing=np.array(1,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/uint8/0/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/uint8/0/1: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/uint8/0/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint8/0/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint8/0/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/uint8/0/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/0/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/0/1: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/0/1: spacing state: dtype")
cases=cases+1
end
-- 575: rfftfreq/typed/uint8/0/2
do
local spacing=np.array(2,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/uint8/0/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/uint8/0/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/uint8/0/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint8/0/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint8/0/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/uint8/0/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/0/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/0/2: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/0/2: spacing state: dtype")
cases=cases+1
end
-- 576: rfftfreq/typed/uint8/1/0
do
local spacing=np.array(0,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/uint8/1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/uint8/1/0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/uint8/1/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint8/1/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint8/1/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/uint8/1/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/1/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/1/0: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/1/0: spacing state: dtype")
cases=cases+1
end
-- 577: rfftfreq/typed/uint8/1/1
do
local spacing=np.array(1,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/uint8/1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/typed/uint8/1/1: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/uint8/1/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint8/1/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint8/1/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/uint8/1/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/1/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/1/1: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/1/1: spacing state: dtype")
cases=cases+1
end
-- 578: rfftfreq/typed/uint8/1/2
do
local spacing=np.array(2,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/uint8/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/typed/uint8/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/uint8/1/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint8/1/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint8/1/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/uint8/1/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/1/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/1/2: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/1/2: spacing state: dtype")
cases=cases+1
end
-- 579: rfftfreq/typed/uint8/3/0
do
local spacing=np.array(0,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/uint8/3/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge},"rfftfreq/typed/uint8/3/0: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/uint8/3/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint8/3/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint8/3/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/uint8/3/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/3/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/3/0: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/3/0: spacing state: dtype")
cases=cases+1
end
-- 580: rfftfreq/typed/uint8/3/1
do
local spacing=np.array(1,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/uint8/3/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.3333333333333333},"rfftfreq/typed/uint8/3/1: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/uint8/3/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint8/3/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint8/3/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/uint8/3/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/3/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/3/1: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/3/1: spacing state: dtype")
cases=cases+1
end
-- 581: rfftfreq/typed/uint8/3/2
do
local spacing=np.array(2,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/uint8/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.16666666666666666},"rfftfreq/typed/uint8/3/2: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/uint8/3/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint8/3/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint8/3/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/uint8/3/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/3/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/3/2: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/3/2: spacing state: dtype")
cases=cases+1
end
-- 582: rfftfreq/typed/uint8/4/0
do
local spacing=np.array(0,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/uint8/4/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge},"rfftfreq/typed/uint8/4/0: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/uint8/4/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint8/4/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint8/4/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/uint8/4/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/4/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/4/0: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/4/0: spacing state: dtype")
cases=cases+1
end
-- 583: rfftfreq/typed/uint8/4/1
do
local spacing=np.array(1,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/uint8/4/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,0.5},"rfftfreq/typed/uint8/4/1: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/uint8/4/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint8/4/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint8/4/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/uint8/4/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/4/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/4/1: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/4/1: spacing state: dtype")
cases=cases+1
end
-- 584: rfftfreq/typed/uint8/4/2
do
local spacing=np.array(2,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/uint8/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.125,0.25},"rfftfreq/typed/uint8/4/2: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/uint8/4/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint8/4/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint8/4/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/uint8/4/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/4/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/4/2: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/4/2: spacing state: dtype")
cases=cases+1
end
-- 585: rfftfreq/typed/uint8/15/0
do
local spacing=np.array(0,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/uint8/15/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/uint8/15/0: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/uint8/15/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint8/15/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint8/15/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/uint8/15/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/15/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/15/0: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/15/0: spacing state: dtype")
cases=cases+1
end
-- 586: rfftfreq/typed/uint8/15/1
do
local spacing=np.array(1,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/uint8/15/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.06666666666666667,0.13333333333333333,0.2,0.26666666666666666,0.3333333333333333,0.4,0.4666666666666667},"rfftfreq/typed/uint8/15/1: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/uint8/15/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint8/15/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint8/15/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/uint8/15/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/15/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/15/1: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/15/1: spacing state: dtype")
cases=cases+1
end
-- 587: rfftfreq/typed/uint8/15/2
do
local spacing=np.array(2,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/uint8/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.03333333333333333,0.06666666666666667,0.1,0.13333333333333333,0.16666666666666666,0.2,0.23333333333333334},"rfftfreq/typed/uint8/15/2: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/uint8/15/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint8/15/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint8/15/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/uint8/15/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/15/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/15/2: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/15/2: spacing state: dtype")
cases=cases+1
end
-- 588: rfftfreq/typed/uint8/127/0
do
local spacing=np.array(0,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/uint8/127/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/uint8/127/0: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/uint8/127/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint8/127/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint8/127/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/uint8/127/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/127/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/127/0: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/127/0: spacing state: dtype")
cases=cases+1
end
-- 589: rfftfreq/typed/uint8/127/1
do
local spacing=np.array(1,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/uint8/127/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.007874015748031496,0.015748031496062992,0.023622047244094488,0.031496062992125984,0.03937007874015748,0.047244094488188976,0.05511811023622047,0.06299212598425197,0.07086614173228346,0.07874015748031496,0.08661417322834646,0.09448818897637795,0.10236220472440945,0.11023622047244094,0.11811023622047244,0.12598425196850394,0.13385826771653542,0.14173228346456693,0.14960629921259844,0.15748031496062992,0.1653543307086614,0.1732283464566929,0.18110236220472442,0.1889763779527559,0.19685039370078738,0.2047244094488189,0.2125984251968504,0.2204724409448819,0.22834645669291337,0.23622047244094488,0.2440944881889764,0.25196850393700787,0.25984251968503935,0.26771653543307083,0.2755905511811024,0.28346456692913385,0.29133858267716534,0.2992125984251969,0.30708661417322836,0.31496062992125984,0.3228346456692913,0.3307086614173228,0.33858267716535434,0.3464566929133858,0.3543307086614173,0.36220472440944884,0.3700787401574803,0.3779527559055118,0.3858267716535433,0.39370078740157477,0.4015748031496063,0.4094488188976378,0.41732283464566927,0.4251968503937008,0.4330708661417323,0.4409448818897638,0.44881889763779526,0.45669291338582674,0.4645669291338583,0.47244094488188976,0.48031496062992124,0.4881889763779528,0.49606299212598426},"rfftfreq/typed/uint8/127/1: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/uint8/127/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint8/127/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint8/127/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/uint8/127/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/127/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/127/1: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/127/1: spacing state: dtype")
cases=cases+1
end
-- 590: rfftfreq/typed/uint8/127/2
do
local spacing=np.array(2,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/uint8/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.003937007874015748,0.007874015748031496,0.011811023622047244,0.015748031496062992,0.01968503937007874,0.023622047244094488,0.027559055118110236,0.031496062992125984,0.03543307086614173,0.03937007874015748,0.04330708661417323,0.047244094488188976,0.051181102362204724,0.05511811023622047,0.05905511811023622,0.06299212598425197,0.06692913385826771,0.07086614173228346,0.07480314960629922,0.07874015748031496,0.0826771653543307,0.08661417322834646,0.09055118110236221,0.09448818897637795,0.09842519685039369,0.10236220472440945,0.1062992125984252,0.11023622047244094,0.11417322834645668,0.11811023622047244,0.1220472440944882,0.12598425196850394,0.12992125984251968,0.13385826771653542,0.1377952755905512,0.14173228346456693,0.14566929133858267,0.14960629921259844,0.15354330708661418,0.15748031496062992,0.16141732283464566,0.1653543307086614,0.16929133858267717,0.1732283464566929,0.17716535433070865,0.18110236220472442,0.18503937007874016,0.1889763779527559,0.19291338582677164,0.19685039370078738,0.20078740157480315,0.2047244094488189,0.20866141732283464,0.2125984251968504,0.21653543307086615,0.2204724409448819,0.22440944881889763,0.22834645669291337,0.23228346456692914,0.23622047244094488,0.24015748031496062,0.2440944881889764,0.24803149606299213},"rfftfreq/typed/uint8/127/2: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/uint8/127/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint8/127/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint8/127/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/uint8/127/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/127/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/127/2: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/127/2: spacing state: dtype")
cases=cases+1
end
-- 591: rfftfreq/typed/uint8/128/0
do
local spacing=np.array(0,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/uint8/128/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/uint8/128/0: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/uint8/128/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint8/128/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint8/128/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/uint8/128/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/128/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/128/0: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/128/0: spacing state: dtype")
cases=cases+1
end
-- 592: rfftfreq/typed/uint8/128/1
do
local spacing=np.array(1,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/uint8/128/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0078125,0.015625,0.0234375,0.03125,0.0390625,0.046875,0.0546875,0.0625,0.0703125,0.078125,0.0859375,0.09375,0.1015625,0.109375,0.1171875,0.125,0.1328125,0.140625,0.1484375,0.15625,0.1640625,0.171875,0.1796875,0.1875,0.1953125,0.203125,0.2109375,0.21875,0.2265625,0.234375,0.2421875,0.25,0.2578125,0.265625,0.2734375,0.28125,0.2890625,0.296875,0.3046875,0.3125,0.3203125,0.328125,0.3359375,0.34375,0.3515625,0.359375,0.3671875,0.375,0.3828125,0.390625,0.3984375,0.40625,0.4140625,0.421875,0.4296875,0.4375,0.4453125,0.453125,0.4609375,0.46875,0.4765625,0.484375,0.4921875,0.5},"rfftfreq/typed/uint8/128/1: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/uint8/128/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint8/128/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint8/128/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/uint8/128/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/128/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/128/1: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/128/1: spacing state: dtype")
cases=cases+1
end
-- 593: rfftfreq/typed/uint8/128/2
do
local spacing=np.array(2,"uint8")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/uint8/128/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/uint8/128/2: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/uint8/128/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint8/128/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint8/128/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/uint8/128/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint8/128/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint8/128/2: spacing state: strides")
eq(spacing.dtype,"uint8","rfftfreq/typed/uint8/128/2: spacing state: dtype")
cases=cases+1
end
-- 594: rfftfreq/typed/int32/-1/0
do
local spacing=np.array(0,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/-1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/int32/-1/0: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/int32/-1/0: result: shape")
eq(result.strides,{0},"rfftfreq/typed/int32/-1/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/-1/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int32/-1/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/-1/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/-1/0: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/-1/0: spacing state: dtype")
cases=cases+1
end
-- 595: rfftfreq/typed/int32/-1/1
do
local spacing=np.array(1,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/-1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/int32/-1/1: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/int32/-1/1: result: shape")
eq(result.strides,{0},"rfftfreq/typed/int32/-1/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/-1/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int32/-1/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/-1/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/-1/1: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/-1/1: spacing state: dtype")
cases=cases+1
end
-- 596: rfftfreq/typed/int32/-1/2
do
local spacing=np.array(2,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/-1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/int32/-1/2: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/int32/-1/2: result: shape")
eq(result.strides,{0},"rfftfreq/typed/int32/-1/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/-1/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int32/-1/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/-1/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/-1/2: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/-1/2: spacing state: dtype")
cases=cases+1
end
-- 597: rfftfreq/typed/int32/0/0
do
local spacing=np.array(0,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/0/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/int32/0/0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/int32/0/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int32/0/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/0/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int32/0/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/0/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/0/0: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/0/0: spacing state: dtype")
cases=cases+1
end
-- 598: rfftfreq/typed/int32/0/1
do
local spacing=np.array(1,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/0/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/int32/0/1: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/int32/0/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int32/0/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/0/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int32/0/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/0/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/0/1: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/0/1: spacing state: dtype")
cases=cases+1
end
-- 599: rfftfreq/typed/int32/0/2
do
local spacing=np.array(2,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/0/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/int32/0/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/int32/0/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int32/0/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/0/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int32/0/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/0/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/0/2: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/0/2: spacing state: dtype")
cases=cases+1
end
-- 600: rfftfreq/typed/int32/1/0
do
local spacing=np.array(0,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/int32/1/0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/int32/1/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int32/1/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/1/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int32/1/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/1/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/1/0: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/1/0: spacing state: dtype")
cases=cases+1
end
-- 601: rfftfreq/typed/int32/1/1
do
local spacing=np.array(1,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/typed/int32/1/1: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/int32/1/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int32/1/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/1/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int32/1/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/1/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/1/1: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/1/1: spacing state: dtype")
cases=cases+1
end
-- 602: rfftfreq/typed/int32/1/2
do
local spacing=np.array(2,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/typed/int32/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/int32/1/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int32/1/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/1/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int32/1/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/1/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/1/2: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/1/2: spacing state: dtype")
cases=cases+1
end
-- 603: rfftfreq/typed/int32/3/0
do
local spacing=np.array(0,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/3/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge},"rfftfreq/typed/int32/3/0: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/int32/3/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int32/3/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/3/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int32/3/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/3/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/3/0: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/3/0: spacing state: dtype")
cases=cases+1
end
-- 604: rfftfreq/typed/int32/3/1
do
local spacing=np.array(1,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/3/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.3333333333333333},"rfftfreq/typed/int32/3/1: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/int32/3/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int32/3/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/3/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int32/3/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/3/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/3/1: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/3/1: spacing state: dtype")
cases=cases+1
end
-- 605: rfftfreq/typed/int32/3/2
do
local spacing=np.array(2,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.16666666666666666},"rfftfreq/typed/int32/3/2: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/int32/3/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int32/3/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/3/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int32/3/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/3/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/3/2: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/3/2: spacing state: dtype")
cases=cases+1
end
-- 606: rfftfreq/typed/int32/4/0
do
local spacing=np.array(0,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/4/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge},"rfftfreq/typed/int32/4/0: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/int32/4/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int32/4/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/4/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int32/4/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/4/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/4/0: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/4/0: spacing state: dtype")
cases=cases+1
end
-- 607: rfftfreq/typed/int32/4/1
do
local spacing=np.array(1,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/4/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,0.5},"rfftfreq/typed/int32/4/1: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/int32/4/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int32/4/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/4/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int32/4/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/4/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/4/1: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/4/1: spacing state: dtype")
cases=cases+1
end
-- 608: rfftfreq/typed/int32/4/2
do
local spacing=np.array(2,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.125,0.25},"rfftfreq/typed/int32/4/2: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/int32/4/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int32/4/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/4/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int32/4/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/4/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/4/2: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/4/2: spacing state: dtype")
cases=cases+1
end
-- 609: rfftfreq/typed/int32/15/0
do
local spacing=np.array(0,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/15/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/int32/15/0: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/int32/15/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int32/15/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/15/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int32/15/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/15/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/15/0: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/15/0: spacing state: dtype")
cases=cases+1
end
-- 610: rfftfreq/typed/int32/15/1
do
local spacing=np.array(1,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/15/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.06666666666666667,0.13333333333333333,0.2,0.26666666666666666,0.3333333333333333,0.4,0.4666666666666667},"rfftfreq/typed/int32/15/1: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/int32/15/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int32/15/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/15/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int32/15/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/15/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/15/1: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/15/1: spacing state: dtype")
cases=cases+1
end
-- 611: rfftfreq/typed/int32/15/2
do
local spacing=np.array(2,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.03333333333333333,0.06666666666666667,0.1,0.13333333333333333,0.16666666666666666,0.2,0.23333333333333334},"rfftfreq/typed/int32/15/2: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/int32/15/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int32/15/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/15/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int32/15/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/15/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/15/2: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/15/2: spacing state: dtype")
cases=cases+1
end
-- 612: rfftfreq/typed/int32/127/0
do
local spacing=np.array(0,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/127/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/int32/127/0: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/int32/127/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int32/127/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/127/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int32/127/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/127/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/127/0: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/127/0: spacing state: dtype")
cases=cases+1
end
-- 613: rfftfreq/typed/int32/127/1
do
local spacing=np.array(1,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/127/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.007874015748031496,0.015748031496062992,0.023622047244094488,0.031496062992125984,0.03937007874015748,0.047244094488188976,0.05511811023622047,0.06299212598425197,0.07086614173228346,0.07874015748031496,0.08661417322834646,0.09448818897637795,0.10236220472440945,0.11023622047244094,0.11811023622047244,0.12598425196850394,0.13385826771653542,0.14173228346456693,0.14960629921259844,0.15748031496062992,0.1653543307086614,0.1732283464566929,0.18110236220472442,0.1889763779527559,0.19685039370078738,0.2047244094488189,0.2125984251968504,0.2204724409448819,0.22834645669291337,0.23622047244094488,0.2440944881889764,0.25196850393700787,0.25984251968503935,0.26771653543307083,0.2755905511811024,0.28346456692913385,0.29133858267716534,0.2992125984251969,0.30708661417322836,0.31496062992125984,0.3228346456692913,0.3307086614173228,0.33858267716535434,0.3464566929133858,0.3543307086614173,0.36220472440944884,0.3700787401574803,0.3779527559055118,0.3858267716535433,0.39370078740157477,0.4015748031496063,0.4094488188976378,0.41732283464566927,0.4251968503937008,0.4330708661417323,0.4409448818897638,0.44881889763779526,0.45669291338582674,0.4645669291338583,0.47244094488188976,0.48031496062992124,0.4881889763779528,0.49606299212598426},"rfftfreq/typed/int32/127/1: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/int32/127/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int32/127/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/127/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int32/127/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/127/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/127/1: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/127/1: spacing state: dtype")
cases=cases+1
end
-- 614: rfftfreq/typed/int32/127/2
do
local spacing=np.array(2,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.003937007874015748,0.007874015748031496,0.011811023622047244,0.015748031496062992,0.01968503937007874,0.023622047244094488,0.027559055118110236,0.031496062992125984,0.03543307086614173,0.03937007874015748,0.04330708661417323,0.047244094488188976,0.051181102362204724,0.05511811023622047,0.05905511811023622,0.06299212598425197,0.06692913385826771,0.07086614173228346,0.07480314960629922,0.07874015748031496,0.0826771653543307,0.08661417322834646,0.09055118110236221,0.09448818897637795,0.09842519685039369,0.10236220472440945,0.1062992125984252,0.11023622047244094,0.11417322834645668,0.11811023622047244,0.1220472440944882,0.12598425196850394,0.12992125984251968,0.13385826771653542,0.1377952755905512,0.14173228346456693,0.14566929133858267,0.14960629921259844,0.15354330708661418,0.15748031496062992,0.16141732283464566,0.1653543307086614,0.16929133858267717,0.1732283464566929,0.17716535433070865,0.18110236220472442,0.18503937007874016,0.1889763779527559,0.19291338582677164,0.19685039370078738,0.20078740157480315,0.2047244094488189,0.20866141732283464,0.2125984251968504,0.21653543307086615,0.2204724409448819,0.22440944881889763,0.22834645669291337,0.23228346456692914,0.23622047244094488,0.24015748031496062,0.2440944881889764,0.24803149606299213},"rfftfreq/typed/int32/127/2: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/int32/127/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int32/127/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/127/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int32/127/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/127/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/127/2: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/127/2: spacing state: dtype")
cases=cases+1
end
-- 615: rfftfreq/typed/int32/128/0
do
local spacing=np.array(0,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/128/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/int32/128/0: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/int32/128/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int32/128/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/128/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int32/128/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/128/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/128/0: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/128/0: spacing state: dtype")
cases=cases+1
end
-- 616: rfftfreq/typed/int32/128/1
do
local spacing=np.array(1,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/128/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0078125,0.015625,0.0234375,0.03125,0.0390625,0.046875,0.0546875,0.0625,0.0703125,0.078125,0.0859375,0.09375,0.1015625,0.109375,0.1171875,0.125,0.1328125,0.140625,0.1484375,0.15625,0.1640625,0.171875,0.1796875,0.1875,0.1953125,0.203125,0.2109375,0.21875,0.2265625,0.234375,0.2421875,0.25,0.2578125,0.265625,0.2734375,0.28125,0.2890625,0.296875,0.3046875,0.3125,0.3203125,0.328125,0.3359375,0.34375,0.3515625,0.359375,0.3671875,0.375,0.3828125,0.390625,0.3984375,0.40625,0.4140625,0.421875,0.4296875,0.4375,0.4453125,0.453125,0.4609375,0.46875,0.4765625,0.484375,0.4921875,0.5},"rfftfreq/typed/int32/128/1: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/int32/128/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int32/128/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/128/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int32/128/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/128/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/128/1: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/128/1: spacing state: dtype")
cases=cases+1
end
-- 617: rfftfreq/typed/int32/128/2
do
local spacing=np.array(2,"int32")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/int32/128/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.00390625,0.0078125,0.01171875,0.015625,0.01953125,0.0234375,0.02734375,0.03125,0.03515625,0.0390625,0.04296875,0.046875,0.05078125,0.0546875,0.05859375,0.0625,0.06640625,0.0703125,0.07421875,0.078125,0.08203125,0.0859375,0.08984375,0.09375,0.09765625,0.1015625,0.10546875,0.109375,0.11328125,0.1171875,0.12109375,0.125,0.12890625,0.1328125,0.13671875,0.140625,0.14453125,0.1484375,0.15234375,0.15625,0.16015625,0.1640625,0.16796875,0.171875,0.17578125,0.1796875,0.18359375,0.1875,0.19140625,0.1953125,0.19921875,0.203125,0.20703125,0.2109375,0.21484375,0.21875,0.22265625,0.2265625,0.23046875,0.234375,0.23828125,0.2421875,0.24609375,0.25},"rfftfreq/typed/int32/128/2: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/int32/128/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int32/128/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int32/128/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int32/128/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int32/128/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int32/128/2: spacing state: strides")
eq(spacing.dtype,"int32","rfftfreq/typed/int32/128/2: spacing state: dtype")
cases=cases+1
end
-- 618: rfftfreq/typed/int64/-1/0
do
local spacing=np.array(0,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/-1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/int64/-1/0: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/int64/-1/0: result: shape")
eq(result.strides,{0},"rfftfreq/typed/int64/-1/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/-1/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int64/-1/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/-1/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/-1/0: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/-1/0: spacing state: dtype")
cases=cases+1
end
-- 619: rfftfreq/typed/int64/-1/1
do
local spacing=np.array(1,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/-1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/int64/-1/1: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/int64/-1/1: result: shape")
eq(result.strides,{0},"rfftfreq/typed/int64/-1/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/-1/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int64/-1/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/-1/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/-1/1: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/-1/1: spacing state: dtype")
cases=cases+1
end
-- 620: rfftfreq/typed/int64/-1/2
do
local spacing=np.array(2,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/-1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/int64/-1/2: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/int64/-1/2: result: shape")
eq(result.strides,{0},"rfftfreq/typed/int64/-1/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/-1/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int64/-1/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/-1/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/-1/2: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/-1/2: spacing state: dtype")
cases=cases+1
end
-- 621: rfftfreq/typed/int64/0/0
do
local spacing=np.array(0,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/0/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/int64/0/0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/int64/0/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int64/0/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/0/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int64/0/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/0/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/0/0: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/0/0: spacing state: dtype")
cases=cases+1
end
-- 622: rfftfreq/typed/int64/0/1
do
local spacing=np.array(1,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/0/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/int64/0/1: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/int64/0/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int64/0/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/0/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int64/0/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/0/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/0/1: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/0/1: spacing state: dtype")
cases=cases+1
end
-- 623: rfftfreq/typed/int64/0/2
do
local spacing=np.array(2,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/0/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/int64/0/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/int64/0/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int64/0/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/0/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int64/0/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/0/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/0/2: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/0/2: spacing state: dtype")
cases=cases+1
end
-- 624: rfftfreq/typed/int64/1/0
do
local spacing=np.array(0,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/int64/1/0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/int64/1/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int64/1/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/1/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int64/1/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/1/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/1/0: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/1/0: spacing state: dtype")
cases=cases+1
end
-- 625: rfftfreq/typed/int64/1/1
do
local spacing=np.array(1,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/typed/int64/1/1: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/int64/1/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int64/1/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/1/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int64/1/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/1/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/1/1: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/1/1: spacing state: dtype")
cases=cases+1
end
-- 626: rfftfreq/typed/int64/1/2
do
local spacing=np.array(2,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/typed/int64/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/int64/1/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int64/1/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/1/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int64/1/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/1/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/1/2: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/1/2: spacing state: dtype")
cases=cases+1
end
-- 627: rfftfreq/typed/int64/3/0
do
local spacing=np.array(0,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/3/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge},"rfftfreq/typed/int64/3/0: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/int64/3/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int64/3/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/3/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int64/3/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/3/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/3/0: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/3/0: spacing state: dtype")
cases=cases+1
end
-- 628: rfftfreq/typed/int64/3/1
do
local spacing=np.array(1,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/3/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.3333333333333333},"rfftfreq/typed/int64/3/1: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/int64/3/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int64/3/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/3/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int64/3/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/3/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/3/1: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/3/1: spacing state: dtype")
cases=cases+1
end
-- 629: rfftfreq/typed/int64/3/2
do
local spacing=np.array(2,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.16666666666666666},"rfftfreq/typed/int64/3/2: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/int64/3/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int64/3/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/3/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int64/3/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/3/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/3/2: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/3/2: spacing state: dtype")
cases=cases+1
end
-- 630: rfftfreq/typed/int64/4/0
do
local spacing=np.array(0,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/4/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge},"rfftfreq/typed/int64/4/0: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/int64/4/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int64/4/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/4/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int64/4/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/4/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/4/0: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/4/0: spacing state: dtype")
cases=cases+1
end
-- 631: rfftfreq/typed/int64/4/1
do
local spacing=np.array(1,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/4/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,0.5},"rfftfreq/typed/int64/4/1: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/int64/4/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int64/4/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/4/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int64/4/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/4/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/4/1: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/4/1: spacing state: dtype")
cases=cases+1
end
-- 632: rfftfreq/typed/int64/4/2
do
local spacing=np.array(2,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.125,0.25},"rfftfreq/typed/int64/4/2: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/int64/4/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int64/4/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/4/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int64/4/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/4/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/4/2: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/4/2: spacing state: dtype")
cases=cases+1
end
-- 633: rfftfreq/typed/int64/15/0
do
local spacing=np.array(0,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/15/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/int64/15/0: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/int64/15/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int64/15/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/15/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int64/15/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/15/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/15/0: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/15/0: spacing state: dtype")
cases=cases+1
end
-- 634: rfftfreq/typed/int64/15/1
do
local spacing=np.array(1,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/15/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.06666666666666667,0.13333333333333333,0.2,0.26666666666666666,0.3333333333333333,0.4,0.4666666666666667},"rfftfreq/typed/int64/15/1: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/int64/15/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int64/15/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/15/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int64/15/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/15/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/15/1: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/15/1: spacing state: dtype")
cases=cases+1
end
-- 635: rfftfreq/typed/int64/15/2
do
local spacing=np.array(2,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.03333333333333333,0.06666666666666667,0.1,0.13333333333333333,0.16666666666666666,0.2,0.23333333333333334},"rfftfreq/typed/int64/15/2: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/int64/15/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int64/15/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/15/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int64/15/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/15/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/15/2: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/15/2: spacing state: dtype")
cases=cases+1
end
-- 636: rfftfreq/typed/int64/127/0
do
local spacing=np.array(0,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/127/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/int64/127/0: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/int64/127/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int64/127/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/127/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int64/127/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/127/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/127/0: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/127/0: spacing state: dtype")
cases=cases+1
end
-- 637: rfftfreq/typed/int64/127/1
do
local spacing=np.array(1,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/127/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.007874015748031496,0.015748031496062992,0.023622047244094488,0.031496062992125984,0.03937007874015748,0.047244094488188976,0.05511811023622047,0.06299212598425197,0.07086614173228346,0.07874015748031496,0.08661417322834646,0.09448818897637795,0.10236220472440945,0.11023622047244094,0.11811023622047244,0.12598425196850394,0.13385826771653542,0.14173228346456693,0.14960629921259844,0.15748031496062992,0.1653543307086614,0.1732283464566929,0.18110236220472442,0.1889763779527559,0.19685039370078738,0.2047244094488189,0.2125984251968504,0.2204724409448819,0.22834645669291337,0.23622047244094488,0.2440944881889764,0.25196850393700787,0.25984251968503935,0.26771653543307083,0.2755905511811024,0.28346456692913385,0.29133858267716534,0.2992125984251969,0.30708661417322836,0.31496062992125984,0.3228346456692913,0.3307086614173228,0.33858267716535434,0.3464566929133858,0.3543307086614173,0.36220472440944884,0.3700787401574803,0.3779527559055118,0.3858267716535433,0.39370078740157477,0.4015748031496063,0.4094488188976378,0.41732283464566927,0.4251968503937008,0.4330708661417323,0.4409448818897638,0.44881889763779526,0.45669291338582674,0.4645669291338583,0.47244094488188976,0.48031496062992124,0.4881889763779528,0.49606299212598426},"rfftfreq/typed/int64/127/1: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/int64/127/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int64/127/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/127/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int64/127/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/127/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/127/1: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/127/1: spacing state: dtype")
cases=cases+1
end
-- 638: rfftfreq/typed/int64/127/2
do
local spacing=np.array(2,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.003937007874015748,0.007874015748031496,0.011811023622047244,0.015748031496062992,0.01968503937007874,0.023622047244094488,0.027559055118110236,0.031496062992125984,0.03543307086614173,0.03937007874015748,0.04330708661417323,0.047244094488188976,0.051181102362204724,0.05511811023622047,0.05905511811023622,0.06299212598425197,0.06692913385826771,0.07086614173228346,0.07480314960629922,0.07874015748031496,0.0826771653543307,0.08661417322834646,0.09055118110236221,0.09448818897637795,0.09842519685039369,0.10236220472440945,0.1062992125984252,0.11023622047244094,0.11417322834645668,0.11811023622047244,0.1220472440944882,0.12598425196850394,0.12992125984251968,0.13385826771653542,0.1377952755905512,0.14173228346456693,0.14566929133858267,0.14960629921259844,0.15354330708661418,0.15748031496062992,0.16141732283464566,0.1653543307086614,0.16929133858267717,0.1732283464566929,0.17716535433070865,0.18110236220472442,0.18503937007874016,0.1889763779527559,0.19291338582677164,0.19685039370078738,0.20078740157480315,0.2047244094488189,0.20866141732283464,0.2125984251968504,0.21653543307086615,0.2204724409448819,0.22440944881889763,0.22834645669291337,0.23228346456692914,0.23622047244094488,0.24015748031496062,0.2440944881889764,0.24803149606299213},"rfftfreq/typed/int64/127/2: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/int64/127/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int64/127/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/127/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int64/127/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/127/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/127/2: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/127/2: spacing state: dtype")
cases=cases+1
end
-- 639: rfftfreq/typed/int64/128/0
do
local spacing=np.array(0,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/128/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/int64/128/0: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/int64/128/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int64/128/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/128/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/int64/128/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/128/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/128/0: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/128/0: spacing state: dtype")
cases=cases+1
end
-- 640: rfftfreq/typed/int64/128/1
do
local spacing=np.array(1,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/128/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0078125,0.015625,0.0234375,0.03125,0.0390625,0.046875,0.0546875,0.0625,0.0703125,0.078125,0.0859375,0.09375,0.1015625,0.109375,0.1171875,0.125,0.1328125,0.140625,0.1484375,0.15625,0.1640625,0.171875,0.1796875,0.1875,0.1953125,0.203125,0.2109375,0.21875,0.2265625,0.234375,0.2421875,0.25,0.2578125,0.265625,0.2734375,0.28125,0.2890625,0.296875,0.3046875,0.3125,0.3203125,0.328125,0.3359375,0.34375,0.3515625,0.359375,0.3671875,0.375,0.3828125,0.390625,0.3984375,0.40625,0.4140625,0.421875,0.4296875,0.4375,0.4453125,0.453125,0.4609375,0.46875,0.4765625,0.484375,0.4921875,0.5},"rfftfreq/typed/int64/128/1: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/int64/128/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int64/128/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/128/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/int64/128/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/128/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/128/1: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/128/1: spacing state: dtype")
cases=cases+1
end
-- 641: rfftfreq/typed/int64/128/2
do
local spacing=np.array(2,"int64")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/int64/128/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.00390625,0.0078125,0.01171875,0.015625,0.01953125,0.0234375,0.02734375,0.03125,0.03515625,0.0390625,0.04296875,0.046875,0.05078125,0.0546875,0.05859375,0.0625,0.06640625,0.0703125,0.07421875,0.078125,0.08203125,0.0859375,0.08984375,0.09375,0.09765625,0.1015625,0.10546875,0.109375,0.11328125,0.1171875,0.12109375,0.125,0.12890625,0.1328125,0.13671875,0.140625,0.14453125,0.1484375,0.15234375,0.15625,0.16015625,0.1640625,0.16796875,0.171875,0.17578125,0.1796875,0.18359375,0.1875,0.19140625,0.1953125,0.19921875,0.203125,0.20703125,0.2109375,0.21484375,0.21875,0.22265625,0.2265625,0.23046875,0.234375,0.23828125,0.2421875,0.24609375,0.25},"rfftfreq/typed/int64/128/2: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/int64/128/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/int64/128/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/int64/128/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/int64/128/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/int64/128/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/int64/128/2: spacing state: strides")
eq(spacing.dtype,"int64","rfftfreq/typed/int64/128/2: spacing state: dtype")
cases=cases+1
end
-- 642: rfftfreq/typed/uint64/-1/0
do
local spacing=np.array(0,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==false,"rfftfreq/typed/uint64/-1/0: acceptance"..": "..tostring(result))
eq(spacing:tolist(),0,"rfftfreq/typed/uint64/-1/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/-1/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/-1/0: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/-1/0: spacing state: dtype")
cases=cases+1
end
-- 643: rfftfreq/typed/uint64/-1/1
do
local spacing=np.array(1,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==false,"rfftfreq/typed/uint64/-1/1: acceptance"..": "..tostring(result))
eq(spacing:tolist(),1,"rfftfreq/typed/uint64/-1/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/-1/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/-1/1: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/-1/1: spacing state: dtype")
cases=cases+1
end
-- 644: rfftfreq/typed/uint64/-1/2
do
local spacing=np.array(2,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==false,"rfftfreq/typed/uint64/-1/2: acceptance"..": "..tostring(result))
eq(spacing:tolist(),2,"rfftfreq/typed/uint64/-1/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/-1/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/-1/2: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/-1/2: spacing state: dtype")
cases=cases+1
end
-- 645: rfftfreq/typed/uint64/0/0
do
local spacing=np.array(0,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/uint64/0/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/uint64/0/0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/uint64/0/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint64/0/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint64/0/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/uint64/0/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/0/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/0/0: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/0/0: spacing state: dtype")
cases=cases+1
end
-- 646: rfftfreq/typed/uint64/0/1
do
local spacing=np.array(1,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/uint64/0/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/uint64/0/1: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/uint64/0/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint64/0/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint64/0/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/uint64/0/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/0/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/0/1: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/0/1: spacing state: dtype")
cases=cases+1
end
-- 647: rfftfreq/typed/uint64/0/2
do
local spacing=np.array(2,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/uint64/0/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/uint64/0/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/uint64/0/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint64/0/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint64/0/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/uint64/0/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/0/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/0/2: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/0/2: spacing state: dtype")
cases=cases+1
end
-- 648: rfftfreq/typed/uint64/1/0
do
local spacing=np.array(0,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/uint64/1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/uint64/1/0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/uint64/1/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint64/1/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint64/1/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/uint64/1/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/1/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/1/0: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/1/0: spacing state: dtype")
cases=cases+1
end
-- 649: rfftfreq/typed/uint64/1/1
do
local spacing=np.array(1,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/uint64/1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/typed/uint64/1/1: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/uint64/1/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint64/1/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint64/1/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/uint64/1/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/1/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/1/1: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/1/1: spacing state: dtype")
cases=cases+1
end
-- 650: rfftfreq/typed/uint64/1/2
do
local spacing=np.array(2,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/uint64/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/typed/uint64/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/uint64/1/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint64/1/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint64/1/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/uint64/1/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/1/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/1/2: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/1/2: spacing state: dtype")
cases=cases+1
end
-- 651: rfftfreq/typed/uint64/3/0
do
local spacing=np.array(0,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/uint64/3/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge},"rfftfreq/typed/uint64/3/0: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/uint64/3/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint64/3/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint64/3/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/uint64/3/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/3/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/3/0: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/3/0: spacing state: dtype")
cases=cases+1
end
-- 652: rfftfreq/typed/uint64/3/1
do
local spacing=np.array(1,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/uint64/3/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.3333333333333333},"rfftfreq/typed/uint64/3/1: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/uint64/3/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint64/3/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint64/3/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/uint64/3/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/3/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/3/1: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/3/1: spacing state: dtype")
cases=cases+1
end
-- 653: rfftfreq/typed/uint64/3/2
do
local spacing=np.array(2,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/uint64/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.16666666666666666},"rfftfreq/typed/uint64/3/2: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/uint64/3/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint64/3/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint64/3/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/uint64/3/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/3/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/3/2: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/3/2: spacing state: dtype")
cases=cases+1
end
-- 654: rfftfreq/typed/uint64/4/0
do
local spacing=np.array(0,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/uint64/4/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge},"rfftfreq/typed/uint64/4/0: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/uint64/4/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint64/4/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint64/4/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/uint64/4/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/4/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/4/0: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/4/0: spacing state: dtype")
cases=cases+1
end
-- 655: rfftfreq/typed/uint64/4/1
do
local spacing=np.array(1,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/uint64/4/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,0.5},"rfftfreq/typed/uint64/4/1: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/uint64/4/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint64/4/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint64/4/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/uint64/4/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/4/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/4/1: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/4/1: spacing state: dtype")
cases=cases+1
end
-- 656: rfftfreq/typed/uint64/4/2
do
local spacing=np.array(2,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/uint64/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.125,0.25},"rfftfreq/typed/uint64/4/2: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/uint64/4/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint64/4/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint64/4/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/uint64/4/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/4/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/4/2: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/4/2: spacing state: dtype")
cases=cases+1
end
-- 657: rfftfreq/typed/uint64/15/0
do
local spacing=np.array(0,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/uint64/15/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/uint64/15/0: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/uint64/15/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint64/15/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint64/15/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/uint64/15/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/15/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/15/0: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/15/0: spacing state: dtype")
cases=cases+1
end
-- 658: rfftfreq/typed/uint64/15/1
do
local spacing=np.array(1,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/uint64/15/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.06666666666666667,0.13333333333333333,0.2,0.26666666666666666,0.3333333333333333,0.4,0.4666666666666667},"rfftfreq/typed/uint64/15/1: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/uint64/15/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint64/15/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint64/15/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/uint64/15/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/15/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/15/1: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/15/1: spacing state: dtype")
cases=cases+1
end
-- 659: rfftfreq/typed/uint64/15/2
do
local spacing=np.array(2,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/uint64/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.03333333333333333,0.06666666666666667,0.1,0.13333333333333333,0.16666666666666666,0.2,0.23333333333333334},"rfftfreq/typed/uint64/15/2: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/uint64/15/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint64/15/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint64/15/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/uint64/15/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/15/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/15/2: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/15/2: spacing state: dtype")
cases=cases+1
end
-- 660: rfftfreq/typed/uint64/127/0
do
local spacing=np.array(0,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/uint64/127/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/uint64/127/0: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/uint64/127/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint64/127/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint64/127/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/uint64/127/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/127/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/127/0: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/127/0: spacing state: dtype")
cases=cases+1
end
-- 661: rfftfreq/typed/uint64/127/1
do
local spacing=np.array(1,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/uint64/127/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.007874015748031496,0.015748031496062992,0.023622047244094488,0.031496062992125984,0.03937007874015748,0.047244094488188976,0.05511811023622047,0.06299212598425197,0.07086614173228346,0.07874015748031496,0.08661417322834646,0.09448818897637795,0.10236220472440945,0.11023622047244094,0.11811023622047244,0.12598425196850394,0.13385826771653542,0.14173228346456693,0.14960629921259844,0.15748031496062992,0.1653543307086614,0.1732283464566929,0.18110236220472442,0.1889763779527559,0.19685039370078738,0.2047244094488189,0.2125984251968504,0.2204724409448819,0.22834645669291337,0.23622047244094488,0.2440944881889764,0.25196850393700787,0.25984251968503935,0.26771653543307083,0.2755905511811024,0.28346456692913385,0.29133858267716534,0.2992125984251969,0.30708661417322836,0.31496062992125984,0.3228346456692913,0.3307086614173228,0.33858267716535434,0.3464566929133858,0.3543307086614173,0.36220472440944884,0.3700787401574803,0.3779527559055118,0.3858267716535433,0.39370078740157477,0.4015748031496063,0.4094488188976378,0.41732283464566927,0.4251968503937008,0.4330708661417323,0.4409448818897638,0.44881889763779526,0.45669291338582674,0.4645669291338583,0.47244094488188976,0.48031496062992124,0.4881889763779528,0.49606299212598426},"rfftfreq/typed/uint64/127/1: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/uint64/127/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint64/127/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint64/127/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/uint64/127/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/127/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/127/1: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/127/1: spacing state: dtype")
cases=cases+1
end
-- 662: rfftfreq/typed/uint64/127/2
do
local spacing=np.array(2,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/uint64/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.003937007874015748,0.007874015748031496,0.011811023622047244,0.015748031496062992,0.01968503937007874,0.023622047244094488,0.027559055118110236,0.031496062992125984,0.03543307086614173,0.03937007874015748,0.04330708661417323,0.047244094488188976,0.051181102362204724,0.05511811023622047,0.05905511811023622,0.06299212598425197,0.06692913385826771,0.07086614173228346,0.07480314960629922,0.07874015748031496,0.0826771653543307,0.08661417322834646,0.09055118110236221,0.09448818897637795,0.09842519685039369,0.10236220472440945,0.1062992125984252,0.11023622047244094,0.11417322834645668,0.11811023622047244,0.1220472440944882,0.12598425196850394,0.12992125984251968,0.13385826771653542,0.1377952755905512,0.14173228346456693,0.14566929133858267,0.14960629921259844,0.15354330708661418,0.15748031496062992,0.16141732283464566,0.1653543307086614,0.16929133858267717,0.1732283464566929,0.17716535433070865,0.18110236220472442,0.18503937007874016,0.1889763779527559,0.19291338582677164,0.19685039370078738,0.20078740157480315,0.2047244094488189,0.20866141732283464,0.2125984251968504,0.21653543307086615,0.2204724409448819,0.22440944881889763,0.22834645669291337,0.23228346456692914,0.23622047244094488,0.24015748031496062,0.2440944881889764,0.24803149606299213},"rfftfreq/typed/uint64/127/2: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/uint64/127/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint64/127/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint64/127/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/uint64/127/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/127/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/127/2: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/127/2: spacing state: dtype")
cases=cases+1
end
-- 663: rfftfreq/typed/uint64/128/0
do
local spacing=np.array(0,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/uint64/128/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/uint64/128/0: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/uint64/128/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint64/128/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint64/128/0: result: dtype")
eq(spacing:tolist(),0,"rfftfreq/typed/uint64/128/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/128/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/128/0: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/128/0: spacing state: dtype")
cases=cases+1
end
-- 664: rfftfreq/typed/uint64/128/1
do
local spacing=np.array(1,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/uint64/128/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0078125,0.015625,0.0234375,0.03125,0.0390625,0.046875,0.0546875,0.0625,0.0703125,0.078125,0.0859375,0.09375,0.1015625,0.109375,0.1171875,0.125,0.1328125,0.140625,0.1484375,0.15625,0.1640625,0.171875,0.1796875,0.1875,0.1953125,0.203125,0.2109375,0.21875,0.2265625,0.234375,0.2421875,0.25,0.2578125,0.265625,0.2734375,0.28125,0.2890625,0.296875,0.3046875,0.3125,0.3203125,0.328125,0.3359375,0.34375,0.3515625,0.359375,0.3671875,0.375,0.3828125,0.390625,0.3984375,0.40625,0.4140625,0.421875,0.4296875,0.4375,0.4453125,0.453125,0.4609375,0.46875,0.4765625,0.484375,0.4921875,0.5},"rfftfreq/typed/uint64/128/1: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/uint64/128/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint64/128/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint64/128/1: result: dtype")
eq(spacing:tolist(),1,"rfftfreq/typed/uint64/128/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/128/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/128/1: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/128/1: spacing state: dtype")
cases=cases+1
end
-- 665: rfftfreq/typed/uint64/128/2
do
local spacing=np.array(2,"uint64")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/uint64/128/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.00390625,0.0078125,0.01171875,0.015625,0.01953125,0.0234375,0.02734375,0.03125,0.03515625,0.0390625,0.04296875,0.046875,0.05078125,0.0546875,0.05859375,0.0625,0.06640625,0.0703125,0.07421875,0.078125,0.08203125,0.0859375,0.08984375,0.09375,0.09765625,0.1015625,0.10546875,0.109375,0.11328125,0.1171875,0.12109375,0.125,0.12890625,0.1328125,0.13671875,0.140625,0.14453125,0.1484375,0.15234375,0.15625,0.16015625,0.1640625,0.16796875,0.171875,0.17578125,0.1796875,0.18359375,0.1875,0.19140625,0.1953125,0.19921875,0.203125,0.20703125,0.2109375,0.21484375,0.21875,0.22265625,0.2265625,0.23046875,0.234375,0.23828125,0.2421875,0.24609375,0.25},"rfftfreq/typed/uint64/128/2: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/uint64/128/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/uint64/128/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/uint64/128/2: result: dtype")
eq(spacing:tolist(),2,"rfftfreq/typed/uint64/128/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/uint64/128/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/uint64/128/2: spacing state: strides")
eq(spacing.dtype,"uint64","rfftfreq/typed/uint64/128/2: spacing state: dtype")
cases=cases+1
end
-- 666: rfftfreq/typed/float16/-1/0
do
local spacing=np.array(0.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/-1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/float16/-1/0: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/float16/-1/0: result: shape")
eq(result.strides,{0},"rfftfreq/typed/float16/-1/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/-1/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float16/-1/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/-1/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/-1/0: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/-1/0: spacing state: dtype")
cases=cases+1
end
-- 667: rfftfreq/typed/float16/-1/1
do
local spacing=np.array(1.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/-1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/float16/-1/1: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/float16/-1/1: result: shape")
eq(result.strides,{0},"rfftfreq/typed/float16/-1/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/-1/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float16/-1/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/-1/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/-1/1: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/-1/1: spacing state: dtype")
cases=cases+1
end
-- 668: rfftfreq/typed/float16/-1/2
do
local spacing=np.array(2.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/-1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/float16/-1/2: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/float16/-1/2: result: shape")
eq(result.strides,{0},"rfftfreq/typed/float16/-1/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/-1/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float16/-1/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/-1/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/-1/2: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/-1/2: spacing state: dtype")
cases=cases+1
end
-- 669: rfftfreq/typed/float16/0/0
do
local spacing=np.array(0.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/0/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/float16/0/0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/float16/0/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float16/0/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/0/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float16/0/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/0/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/0/0: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/0/0: spacing state: dtype")
cases=cases+1
end
-- 670: rfftfreq/typed/float16/0/1
do
local spacing=np.array(1.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/0/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/float16/0/1: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/float16/0/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float16/0/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/0/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float16/0/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/0/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/0/1: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/0/1: spacing state: dtype")
cases=cases+1
end
-- 671: rfftfreq/typed/float16/0/2
do
local spacing=np.array(2.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/0/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/float16/0/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/float16/0/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float16/0/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/0/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float16/0/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/0/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/0/2: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/0/2: spacing state: dtype")
cases=cases+1
end
-- 672: rfftfreq/typed/float16/1/0
do
local spacing=np.array(0.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/float16/1/0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/float16/1/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float16/1/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/1/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float16/1/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/1/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/1/0: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/1/0: spacing state: dtype")
cases=cases+1
end
-- 673: rfftfreq/typed/float16/1/1
do
local spacing=np.array(1.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/typed/float16/1/1: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/float16/1/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float16/1/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/1/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float16/1/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/1/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/1/1: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/1/1: spacing state: dtype")
cases=cases+1
end
-- 674: rfftfreq/typed/float16/1/2
do
local spacing=np.array(2.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/typed/float16/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/float16/1/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float16/1/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/1/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float16/1/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/1/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/1/2: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/1/2: spacing state: dtype")
cases=cases+1
end
-- 675: rfftfreq/typed/float16/3/0
do
local spacing=np.array(0.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/3/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge},"rfftfreq/typed/float16/3/0: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/float16/3/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float16/3/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/3/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float16/3/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/3/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/3/0: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/3/0: spacing state: dtype")
cases=cases+1
end
-- 676: rfftfreq/typed/float16/3/1
do
local spacing=np.array(1.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/3/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.333251953125},"rfftfreq/typed/float16/3/1: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/float16/3/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float16/3/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/3/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float16/3/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/3/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/3/1: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/3/1: spacing state: dtype")
cases=cases+1
end
-- 677: rfftfreq/typed/float16/3/2
do
local spacing=np.array(2.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.1666259765625},"rfftfreq/typed/float16/3/2: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/float16/3/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float16/3/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/3/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float16/3/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/3/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/3/2: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/3/2: spacing state: dtype")
cases=cases+1
end
-- 678: rfftfreq/typed/float16/4/0
do
local spacing=np.array(0.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/4/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge},"rfftfreq/typed/float16/4/0: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/float16/4/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float16/4/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/4/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float16/4/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/4/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/4/0: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/4/0: spacing state: dtype")
cases=cases+1
end
-- 679: rfftfreq/typed/float16/4/1
do
local spacing=np.array(1.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/4/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,0.5},"rfftfreq/typed/float16/4/1: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/float16/4/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float16/4/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/4/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float16/4/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/4/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/4/1: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/4/1: spacing state: dtype")
cases=cases+1
end
-- 680: rfftfreq/typed/float16/4/2
do
local spacing=np.array(2.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.125,0.25},"rfftfreq/typed/float16/4/2: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/float16/4/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float16/4/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/4/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float16/4/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/4/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/4/2: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/4/2: spacing state: dtype")
cases=cases+1
end
-- 681: rfftfreq/typed/float16/15/0
do
local spacing=np.array(0.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/15/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/float16/15/0: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/float16/15/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float16/15/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/15/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float16/15/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/15/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/15/0: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/15/0: spacing state: dtype")
cases=cases+1
end
-- 682: rfftfreq/typed/float16/15/1
do
local spacing=np.array(1.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/15/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.066650390625,0.13330078125,0.199951171875,0.2666015625,0.333251953125,0.39990234375,0.466552734375},"rfftfreq/typed/float16/15/1: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/float16/15/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float16/15/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/15/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float16/15/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/15/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/15/1: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/15/1: spacing state: dtype")
cases=cases+1
end
-- 683: rfftfreq/typed/float16/15/2
do
local spacing=np.array(2.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0333251953125,0.066650390625,0.0999755859375,0.13330078125,0.1666259765625,0.199951171875,0.2332763671875},"rfftfreq/typed/float16/15/2: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/float16/15/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float16/15/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/15/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float16/15/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/15/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/15/2: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/15/2: spacing state: dtype")
cases=cases+1
end
-- 684: rfftfreq/typed/float16/127/0
do
local spacing=np.array(0.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/127/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/float16/127/0: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/float16/127/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float16/127/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/127/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float16/127/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/127/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/127/0: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/127/0: spacing state: dtype")
cases=cases+1
end
-- 685: rfftfreq/typed/float16/127/1
do
local spacing=np.array(1.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/127/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.00787353515625,0.0157470703125,0.02362060546875,0.031494140625,0.03936767578125,0.0472412109375,0.05511474609375,0.06298828125,0.07086181640625,0.0787353515625,0.08660888671875,0.094482421875,0.10235595703125,0.1102294921875,0.11810302734375,0.1259765625,0.13385009765625,0.1417236328125,0.14959716796875,0.157470703125,0.16534423828125,0.1732177734375,0.18109130859375,0.18896484375,0.19683837890625,0.2047119140625,0.21258544921875,0.220458984375,0.22833251953125,0.2362060546875,0.24407958984375,0.251953125,0.25982666015625,0.2677001953125,0.27557373046875,0.283447265625,0.29132080078125,0.2991943359375,0.30706787109375,0.31494140625,0.32281494140625,0.3306884765625,0.33856201171875,0.346435546875,0.35430908203125,0.3621826171875,0.37005615234375,0.3779296875,0.38580322265625,0.3936767578125,0.40155029296875,0.409423828125,0.41729736328125,0.4251708984375,0.43304443359375,0.44091796875,0.44879150390625,0.4566650390625,0.46453857421875,0.472412109375,0.48028564453125,0.4881591796875,0.49603271484375},"rfftfreq/typed/float16/127/1: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/float16/127/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float16/127/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/127/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float16/127/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/127/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/127/1: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/127/1: spacing state: dtype")
cases=cases+1
end
-- 686: rfftfreq/typed/float16/127/2
do
local spacing=np.array(2.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.003936767578125,0.00787353515625,0.011810302734375,0.0157470703125,0.019683837890625,0.02362060546875,0.027557373046875,0.031494140625,0.035430908203125,0.03936767578125,0.043304443359375,0.0472412109375,0.051177978515625,0.05511474609375,0.059051513671875,0.06298828125,0.066925048828125,0.07086181640625,0.074798583984375,0.0787353515625,0.082672119140625,0.08660888671875,0.090545654296875,0.094482421875,0.098419189453125,0.10235595703125,0.106292724609375,0.1102294921875,0.114166259765625,0.11810302734375,0.122039794921875,0.1259765625,0.129913330078125,0.13385009765625,0.137786865234375,0.1417236328125,0.145660400390625,0.14959716796875,0.153533935546875,0.157470703125,0.161407470703125,0.16534423828125,0.169281005859375,0.1732177734375,0.177154541015625,0.18109130859375,0.185028076171875,0.18896484375,0.192901611328125,0.19683837890625,0.200775146484375,0.2047119140625,0.208648681640625,0.21258544921875,0.216522216796875,0.220458984375,0.224395751953125,0.22833251953125,0.232269287109375,0.2362060546875,0.240142822265625,0.24407958984375,0.248016357421875},"rfftfreq/typed/float16/127/2: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/float16/127/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float16/127/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/127/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float16/127/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/127/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/127/2: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/127/2: spacing state: dtype")
cases=cases+1
end
-- 687: rfftfreq/typed/float16/128/0
do
local spacing=np.array(0.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/128/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/float16/128/0: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/float16/128/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float16/128/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/128/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float16/128/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/128/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/128/0: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/128/0: spacing state: dtype")
cases=cases+1
end
-- 688: rfftfreq/typed/float16/128/1
do
local spacing=np.array(1.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/128/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0078125,0.015625,0.0234375,0.03125,0.0390625,0.046875,0.0546875,0.0625,0.0703125,0.078125,0.0859375,0.09375,0.1015625,0.109375,0.1171875,0.125,0.1328125,0.140625,0.1484375,0.15625,0.1640625,0.171875,0.1796875,0.1875,0.1953125,0.203125,0.2109375,0.21875,0.2265625,0.234375,0.2421875,0.25,0.2578125,0.265625,0.2734375,0.28125,0.2890625,0.296875,0.3046875,0.3125,0.3203125,0.328125,0.3359375,0.34375,0.3515625,0.359375,0.3671875,0.375,0.3828125,0.390625,0.3984375,0.40625,0.4140625,0.421875,0.4296875,0.4375,0.4453125,0.453125,0.4609375,0.46875,0.4765625,0.484375,0.4921875,0.5},"rfftfreq/typed/float16/128/1: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/float16/128/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float16/128/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/128/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float16/128/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/128/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/128/1: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/128/1: spacing state: dtype")
cases=cases+1
end
-- 689: rfftfreq/typed/float16/128/2
do
local spacing=np.array(2.0,"float16")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/float16/128/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.00390625,0.0078125,0.01171875,0.015625,0.01953125,0.0234375,0.02734375,0.03125,0.03515625,0.0390625,0.04296875,0.046875,0.05078125,0.0546875,0.05859375,0.0625,0.06640625,0.0703125,0.07421875,0.078125,0.08203125,0.0859375,0.08984375,0.09375,0.09765625,0.1015625,0.10546875,0.109375,0.11328125,0.1171875,0.12109375,0.125,0.12890625,0.1328125,0.13671875,0.140625,0.14453125,0.1484375,0.15234375,0.15625,0.16015625,0.1640625,0.16796875,0.171875,0.17578125,0.1796875,0.18359375,0.1875,0.19140625,0.1953125,0.19921875,0.203125,0.20703125,0.2109375,0.21484375,0.21875,0.22265625,0.2265625,0.23046875,0.234375,0.23828125,0.2421875,0.24609375,0.25},"rfftfreq/typed/float16/128/2: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/float16/128/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float16/128/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float16/128/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float16/128/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float16/128/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float16/128/2: spacing state: strides")
eq(spacing.dtype,"float16","rfftfreq/typed/float16/128/2: spacing state: dtype")
cases=cases+1
end
-- 690: rfftfreq/typed/float32/-1/0
do
local spacing=np.array(0.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/-1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/float32/-1/0: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/float32/-1/0: result: shape")
eq(result.strides,{0},"rfftfreq/typed/float32/-1/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/-1/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float32/-1/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/-1/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/-1/0: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/-1/0: spacing state: dtype")
cases=cases+1
end
-- 691: rfftfreq/typed/float32/-1/1
do
local spacing=np.array(1.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/-1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/float32/-1/1: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/float32/-1/1: result: shape")
eq(result.strides,{0},"rfftfreq/typed/float32/-1/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/-1/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float32/-1/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/-1/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/-1/1: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/-1/1: spacing state: dtype")
cases=cases+1
end
-- 692: rfftfreq/typed/float32/-1/2
do
local spacing=np.array(2.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/-1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/float32/-1/2: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/float32/-1/2: result: shape")
eq(result.strides,{0},"rfftfreq/typed/float32/-1/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/-1/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float32/-1/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/-1/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/-1/2: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/-1/2: spacing state: dtype")
cases=cases+1
end
-- 693: rfftfreq/typed/float32/0/0
do
local spacing=np.array(0.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/0/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/float32/0/0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/float32/0/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float32/0/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/0/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float32/0/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/0/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/0/0: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/0/0: spacing state: dtype")
cases=cases+1
end
-- 694: rfftfreq/typed/float32/0/1
do
local spacing=np.array(1.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/0/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/float32/0/1: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/float32/0/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float32/0/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/0/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float32/0/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/0/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/0/1: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/0/1: spacing state: dtype")
cases=cases+1
end
-- 695: rfftfreq/typed/float32/0/2
do
local spacing=np.array(2.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/0/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/float32/0/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/float32/0/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float32/0/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/0/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float32/0/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/0/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/0/2: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/0/2: spacing state: dtype")
cases=cases+1
end
-- 696: rfftfreq/typed/float32/1/0
do
local spacing=np.array(0.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/float32/1/0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/float32/1/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float32/1/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/1/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float32/1/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/1/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/1/0: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/1/0: spacing state: dtype")
cases=cases+1
end
-- 697: rfftfreq/typed/float32/1/1
do
local spacing=np.array(1.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/typed/float32/1/1: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/float32/1/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float32/1/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/1/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float32/1/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/1/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/1/1: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/1/1: spacing state: dtype")
cases=cases+1
end
-- 698: rfftfreq/typed/float32/1/2
do
local spacing=np.array(2.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/typed/float32/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/float32/1/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float32/1/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/1/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float32/1/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/1/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/1/2: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/1/2: spacing state: dtype")
cases=cases+1
end
-- 699: rfftfreq/typed/float32/3/0
do
local spacing=np.array(0.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/3/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge},"rfftfreq/typed/float32/3/0: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/float32/3/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float32/3/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/3/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float32/3/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/3/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/3/0: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/3/0: spacing state: dtype")
cases=cases+1
end
-- 700: rfftfreq/typed/float32/3/1
do
local spacing=np.array(1.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/3/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.3333333432674408},"rfftfreq/typed/float32/3/1: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/float32/3/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float32/3/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/3/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float32/3/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/3/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/3/1: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/3/1: spacing state: dtype")
cases=cases+1
end
-- 701: rfftfreq/typed/float32/3/2
do
local spacing=np.array(2.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.1666666716337204},"rfftfreq/typed/float32/3/2: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/float32/3/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float32/3/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/3/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float32/3/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/3/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/3/2: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/3/2: spacing state: dtype")
cases=cases+1
end
-- 702: rfftfreq/typed/float32/4/0
do
local spacing=np.array(0.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/4/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge},"rfftfreq/typed/float32/4/0: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/float32/4/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float32/4/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/4/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float32/4/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/4/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/4/0: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/4/0: spacing state: dtype")
cases=cases+1
end
-- 703: rfftfreq/typed/float32/4/1
do
local spacing=np.array(1.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/4/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,0.5},"rfftfreq/typed/float32/4/1: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/float32/4/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float32/4/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/4/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float32/4/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/4/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/4/1: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/4/1: spacing state: dtype")
cases=cases+1
end
-- 704: rfftfreq/typed/float32/4/2
do
local spacing=np.array(2.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.125,0.25},"rfftfreq/typed/float32/4/2: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/float32/4/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float32/4/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/4/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float32/4/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/4/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/4/2: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/4/2: spacing state: dtype")
cases=cases+1
end
-- 705: rfftfreq/typed/float32/15/0
do
local spacing=np.array(0.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/15/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/float32/15/0: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/float32/15/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float32/15/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/15/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float32/15/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/15/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/15/0: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/15/0: spacing state: dtype")
cases=cases+1
end
-- 706: rfftfreq/typed/float32/15/1
do
local spacing=np.array(1.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/15/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.06666667014360428,0.13333334028720856,0.20000001043081284,0.2666666805744171,0.3333333507180214,0.40000002086162567,0.46666669100522995},"rfftfreq/typed/float32/15/1: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/float32/15/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float32/15/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/15/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float32/15/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/15/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/15/1: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/15/1: spacing state: dtype")
cases=cases+1
end
-- 707: rfftfreq/typed/float32/15/2
do
local spacing=np.array(2.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.03333333507180214,0.06666667014360428,0.10000000521540642,0.13333334028720856,0.1666666753590107,0.20000001043081284,0.23333334550261497},"rfftfreq/typed/float32/15/2: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/float32/15/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float32/15/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/15/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float32/15/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/15/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/15/2: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/15/2: spacing state: dtype")
cases=cases+1
end
-- 708: rfftfreq/typed/float32/127/0
do
local spacing=np.array(0.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/127/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/float32/127/0: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/float32/127/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float32/127/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/127/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float32/127/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/127/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/127/0: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/127/0: spacing state: dtype")
cases=cases+1
end
-- 709: rfftfreq/typed/float32/127/1
do
local spacing=np.array(1.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/127/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.007874015718698502,0.015748031437397003,0.023622047156095505,0.031496062874794006,0.03937007859349251,0.04724409431219101,0.05511811003088951,0.06299212574958801,0.07086614146828651,0.07874015718698502,0.08661417290568352,0.09448818862438202,0.10236220434308052,0.11023622006177902,0.11811023578047752,0.12598425149917603,0.13385826721787453,0.14173228293657303,0.14960629865527153,0.15748031437397003,0.16535433009266853,0.17322834581136703,0.18110236153006554,0.18897637724876404,0.19685039296746254,0.20472440868616104,0.21259842440485954,0.22047244012355804,0.22834645584225655,0.23622047156095505,0.24409448727965355,0.25196850299835205,0.25984251871705055,0.26771653443574905,0.27559055015444756,0.28346456587314606,0.29133858159184456,0.29921259731054306,0.30708661302924156,0.31496062874794006,0.32283464446663857,0.33070866018533707,0.33858267590403557,0.34645669162273407,0.35433070734143257,0.3622047230601311,0.3700787387788296,0.3779527544975281,0.3858267702162266,0.3937007859349251,0.4015748016536236,0.4094488173723221,0.4173228330910206,0.4251968488097191,0.4330708645284176,0.4409448802471161,0.4488188959658146,0.4566929116845131,0.4645669274032116,0.4724409431219101,0.4803149588406086,0.4881889745593071,0.4960629902780056},"rfftfreq/typed/float32/127/1: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/float32/127/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float32/127/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/127/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float32/127/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/127/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/127/1: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/127/1: spacing state: dtype")
cases=cases+1
end
-- 710: rfftfreq/typed/float32/127/2
do
local spacing=np.array(2.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.003937007859349251,0.007874015718698502,0.011811023578047752,0.015748031437397003,0.019685039296746254,0.023622047156095505,0.027559055015444756,0.031496062874794006,0.03543307073414326,0.03937007859349251,0.04330708645284176,0.04724409431219101,0.05118110217154026,0.05511811003088951,0.05905511789023876,0.06299212574958801,0.06692913360893726,0.07086614146828651,0.07480314932763577,0.07874015718698502,0.08267716504633427,0.08661417290568352,0.09055118076503277,0.09448818862438202,0.09842519648373127,0.10236220434308052,0.10629921220242977,0.11023622006177902,0.11417322792112827,0.11811023578047752,0.12204724363982677,0.12598425149917603,0.12992125935852528,0.13385826721787453,0.13779527507722378,0.14173228293657303,0.14566929079592228,0.14960629865527153,0.15354330651462078,0.15748031437397003,0.16141732223331928,0.16535433009266853,0.16929133795201778,0.17322834581136703,0.17716535367071629,0.18110236153006554,0.1850393693894148,0.18897637724876404,0.1929133851081133,0.19685039296746254,0.2007874008268118,0.20472440868616104,0.2086614165455103,0.21259842440485954,0.2165354322642088,0.22047244012355804,0.2244094479829073,0.22834645584225655,0.2322834637016058,0.23622047156095505,0.2401574794203043,0.24409448727965355,0.2480314951390028},"rfftfreq/typed/float32/127/2: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/float32/127/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float32/127/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/127/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float32/127/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/127/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/127/2: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/127/2: spacing state: dtype")
cases=cases+1
end
-- 711: rfftfreq/typed/float32/128/0
do
local spacing=np.array(0.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/128/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/float32/128/0: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/float32/128/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float32/128/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/128/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float32/128/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/128/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/128/0: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/128/0: spacing state: dtype")
cases=cases+1
end
-- 712: rfftfreq/typed/float32/128/1
do
local spacing=np.array(1.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/128/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0078125,0.015625,0.0234375,0.03125,0.0390625,0.046875,0.0546875,0.0625,0.0703125,0.078125,0.0859375,0.09375,0.1015625,0.109375,0.1171875,0.125,0.1328125,0.140625,0.1484375,0.15625,0.1640625,0.171875,0.1796875,0.1875,0.1953125,0.203125,0.2109375,0.21875,0.2265625,0.234375,0.2421875,0.25,0.2578125,0.265625,0.2734375,0.28125,0.2890625,0.296875,0.3046875,0.3125,0.3203125,0.328125,0.3359375,0.34375,0.3515625,0.359375,0.3671875,0.375,0.3828125,0.390625,0.3984375,0.40625,0.4140625,0.421875,0.4296875,0.4375,0.4453125,0.453125,0.4609375,0.46875,0.4765625,0.484375,0.4921875,0.5},"rfftfreq/typed/float32/128/1: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/float32/128/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float32/128/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/128/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float32/128/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/128/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/128/1: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/128/1: spacing state: dtype")
cases=cases+1
end
-- 713: rfftfreq/typed/float32/128/2
do
local spacing=np.array(2.0,"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/float32/128/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.00390625,0.0078125,0.01171875,0.015625,0.01953125,0.0234375,0.02734375,0.03125,0.03515625,0.0390625,0.04296875,0.046875,0.05078125,0.0546875,0.05859375,0.0625,0.06640625,0.0703125,0.07421875,0.078125,0.08203125,0.0859375,0.08984375,0.09375,0.09765625,0.1015625,0.10546875,0.109375,0.11328125,0.1171875,0.12109375,0.125,0.12890625,0.1328125,0.13671875,0.140625,0.14453125,0.1484375,0.15234375,0.15625,0.16015625,0.1640625,0.16796875,0.171875,0.17578125,0.1796875,0.18359375,0.1875,0.19140625,0.1953125,0.19921875,0.203125,0.20703125,0.2109375,0.21484375,0.21875,0.22265625,0.2265625,0.23046875,0.234375,0.23828125,0.2421875,0.24609375,0.25},"rfftfreq/typed/float32/128/2: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/float32/128/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float32/128/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float32/128/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float32/128/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float32/128/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float32/128/2: spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/typed/float32/128/2: spacing state: dtype")
cases=cases+1
end
-- 714: rfftfreq/typed/float64/-1/0
do
local spacing=np.array(0.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/-1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/float64/-1/0: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/float64/-1/0: result: shape")
eq(result.strides,{0},"rfftfreq/typed/float64/-1/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/-1/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float64/-1/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/-1/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/-1/0: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/-1/0: spacing state: dtype")
cases=cases+1
end
-- 715: rfftfreq/typed/float64/-1/1
do
local spacing=np.array(1.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/-1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/float64/-1/1: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/float64/-1/1: result: shape")
eq(result.strides,{0},"rfftfreq/typed/float64/-1/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/-1/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float64/-1/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/-1/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/-1/1: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/-1/1: spacing state: dtype")
cases=cases+1
end
-- 716: rfftfreq/typed/float64/-1/2
do
local spacing=np.array(2.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/-1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/float64/-1/2: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/float64/-1/2: result: shape")
eq(result.strides,{0},"rfftfreq/typed/float64/-1/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/-1/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float64/-1/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/-1/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/-1/2: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/-1/2: spacing state: dtype")
cases=cases+1
end
-- 717: rfftfreq/typed/float64/0/0
do
local spacing=np.array(0.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/0/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/float64/0/0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/float64/0/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float64/0/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/0/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float64/0/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/0/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/0/0: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/0/0: spacing state: dtype")
cases=cases+1
end
-- 718: rfftfreq/typed/float64/0/1
do
local spacing=np.array(1.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/0/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/float64/0/1: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/float64/0/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float64/0/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/0/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float64/0/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/0/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/0/1: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/0/1: spacing state: dtype")
cases=cases+1
end
-- 719: rfftfreq/typed/float64/0/2
do
local spacing=np.array(2.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/0/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/float64/0/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/float64/0/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float64/0/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/0/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float64/0/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/0/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/0/2: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/0/2: spacing state: dtype")
cases=cases+1
end
-- 720: rfftfreq/typed/float64/1/0
do
local spacing=np.array(0.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/typed/float64/1/0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/float64/1/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float64/1/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/1/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float64/1/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/1/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/1/0: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/1/0: spacing state: dtype")
cases=cases+1
end
-- 721: rfftfreq/typed/float64/1/1
do
local spacing=np.array(1.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/typed/float64/1/1: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/float64/1/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float64/1/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/1/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float64/1/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/1/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/1/1: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/1/1: spacing state: dtype")
cases=cases+1
end
-- 722: rfftfreq/typed/float64/1/2
do
local spacing=np.array(2.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/typed/float64/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/float64/1/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float64/1/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/1/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float64/1/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/1/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/1/2: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/1/2: spacing state: dtype")
cases=cases+1
end
-- 723: rfftfreq/typed/float64/3/0
do
local spacing=np.array(0.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/3/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge},"rfftfreq/typed/float64/3/0: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/float64/3/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float64/3/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/3/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float64/3/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/3/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/3/0: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/3/0: spacing state: dtype")
cases=cases+1
end
-- 724: rfftfreq/typed/float64/3/1
do
local spacing=np.array(1.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/3/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.3333333333333333},"rfftfreq/typed/float64/3/1: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/float64/3/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float64/3/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/3/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float64/3/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/3/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/3/1: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/3/1: spacing state: dtype")
cases=cases+1
end
-- 725: rfftfreq/typed/float64/3/2
do
local spacing=np.array(2.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.16666666666666666},"rfftfreq/typed/float64/3/2: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/float64/3/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float64/3/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/3/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float64/3/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/3/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/3/2: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/3/2: spacing state: dtype")
cases=cases+1
end
-- 726: rfftfreq/typed/float64/4/0
do
local spacing=np.array(0.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/4/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge},"rfftfreq/typed/float64/4/0: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/float64/4/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float64/4/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/4/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float64/4/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/4/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/4/0: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/4/0: spacing state: dtype")
cases=cases+1
end
-- 727: rfftfreq/typed/float64/4/1
do
local spacing=np.array(1.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/4/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.25,0.5},"rfftfreq/typed/float64/4/1: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/float64/4/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float64/4/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/4/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float64/4/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/4/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/4/1: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/4/1: spacing state: dtype")
cases=cases+1
end
-- 728: rfftfreq/typed/float64/4/2
do
local spacing=np.array(2.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.125,0.25},"rfftfreq/typed/float64/4/2: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/float64/4/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float64/4/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/4/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float64/4/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/4/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/4/2: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/4/2: spacing state: dtype")
cases=cases+1
end
-- 729: rfftfreq/typed/float64/15/0
do
local spacing=np.array(0.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/15/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/float64/15/0: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/float64/15/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float64/15/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/15/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float64/15/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/15/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/15/0: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/15/0: spacing state: dtype")
cases=cases+1
end
-- 730: rfftfreq/typed/float64/15/1
do
local spacing=np.array(1.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/15/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.06666666666666667,0.13333333333333333,0.2,0.26666666666666666,0.3333333333333333,0.4,0.4666666666666667},"rfftfreq/typed/float64/15/1: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/float64/15/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float64/15/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/15/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float64/15/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/15/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/15/1: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/15/1: spacing state: dtype")
cases=cases+1
end
-- 731: rfftfreq/typed/float64/15/2
do
local spacing=np.array(2.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.03333333333333333,0.06666666666666667,0.1,0.13333333333333333,0.16666666666666666,0.2,0.23333333333333334},"rfftfreq/typed/float64/15/2: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/float64/15/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float64/15/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/15/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float64/15/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/15/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/15/2: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/15/2: spacing state: dtype")
cases=cases+1
end
-- 732: rfftfreq/typed/float64/127/0
do
local spacing=np.array(0.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/127/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/float64/127/0: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/float64/127/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float64/127/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/127/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float64/127/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/127/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/127/0: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/127/0: spacing state: dtype")
cases=cases+1
end
-- 733: rfftfreq/typed/float64/127/1
do
local spacing=np.array(1.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/127/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.007874015748031496,0.015748031496062992,0.023622047244094488,0.031496062992125984,0.03937007874015748,0.047244094488188976,0.05511811023622047,0.06299212598425197,0.07086614173228346,0.07874015748031496,0.08661417322834646,0.09448818897637795,0.10236220472440945,0.11023622047244094,0.11811023622047244,0.12598425196850394,0.13385826771653542,0.14173228346456693,0.14960629921259844,0.15748031496062992,0.1653543307086614,0.1732283464566929,0.18110236220472442,0.1889763779527559,0.19685039370078738,0.2047244094488189,0.2125984251968504,0.2204724409448819,0.22834645669291337,0.23622047244094488,0.2440944881889764,0.25196850393700787,0.25984251968503935,0.26771653543307083,0.2755905511811024,0.28346456692913385,0.29133858267716534,0.2992125984251969,0.30708661417322836,0.31496062992125984,0.3228346456692913,0.3307086614173228,0.33858267716535434,0.3464566929133858,0.3543307086614173,0.36220472440944884,0.3700787401574803,0.3779527559055118,0.3858267716535433,0.39370078740157477,0.4015748031496063,0.4094488188976378,0.41732283464566927,0.4251968503937008,0.4330708661417323,0.4409448818897638,0.44881889763779526,0.45669291338582674,0.4645669291338583,0.47244094488188976,0.48031496062992124,0.4881889763779528,0.49606299212598426},"rfftfreq/typed/float64/127/1: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/float64/127/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float64/127/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/127/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float64/127/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/127/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/127/1: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/127/1: spacing state: dtype")
cases=cases+1
end
-- 734: rfftfreq/typed/float64/127/2
do
local spacing=np.array(2.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.003937007874015748,0.007874015748031496,0.011811023622047244,0.015748031496062992,0.01968503937007874,0.023622047244094488,0.027559055118110236,0.031496062992125984,0.03543307086614173,0.03937007874015748,0.04330708661417323,0.047244094488188976,0.051181102362204724,0.05511811023622047,0.05905511811023622,0.06299212598425197,0.06692913385826771,0.07086614173228346,0.07480314960629922,0.07874015748031496,0.0826771653543307,0.08661417322834646,0.09055118110236221,0.09448818897637795,0.09842519685039369,0.10236220472440945,0.1062992125984252,0.11023622047244094,0.11417322834645668,0.11811023622047244,0.1220472440944882,0.12598425196850394,0.12992125984251968,0.13385826771653542,0.1377952755905512,0.14173228346456693,0.14566929133858267,0.14960629921259844,0.15354330708661418,0.15748031496062992,0.16141732283464566,0.1653543307086614,0.16929133858267717,0.1732283464566929,0.17716535433070865,0.18110236220472442,0.18503937007874016,0.1889763779527559,0.19291338582677164,0.19685039370078738,0.20078740157480315,0.2047244094488189,0.20866141732283464,0.2125984251968504,0.21653543307086615,0.2204724409448819,0.22440944881889763,0.22834645669291337,0.23228346456692914,0.23622047244094488,0.24015748031496062,0.2440944881889764,0.24803149606299213},"rfftfreq/typed/float64/127/2: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/float64/127/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float64/127/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/127/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float64/127/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/127/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/127/2: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/127/2: spacing state: dtype")
cases=cases+1
end
-- 735: rfftfreq/typed/float64/128/0
do
local spacing=np.array(0.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/128/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge,math.huge},"rfftfreq/typed/float64/128/0: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/float64/128/0: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float64/128/0: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/128/0: result: dtype")
eq(spacing:tolist(),0.0,"rfftfreq/typed/float64/128/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/128/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/128/0: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/128/0: spacing state: dtype")
cases=cases+1
end
-- 736: rfftfreq/typed/float64/128/1
do
local spacing=np.array(1.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/128/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.0078125,0.015625,0.0234375,0.03125,0.0390625,0.046875,0.0546875,0.0625,0.0703125,0.078125,0.0859375,0.09375,0.1015625,0.109375,0.1171875,0.125,0.1328125,0.140625,0.1484375,0.15625,0.1640625,0.171875,0.1796875,0.1875,0.1953125,0.203125,0.2109375,0.21875,0.2265625,0.234375,0.2421875,0.25,0.2578125,0.265625,0.2734375,0.28125,0.2890625,0.296875,0.3046875,0.3125,0.3203125,0.328125,0.3359375,0.34375,0.3515625,0.359375,0.3671875,0.375,0.3828125,0.390625,0.3984375,0.40625,0.4140625,0.421875,0.4296875,0.4375,0.4453125,0.453125,0.4609375,0.46875,0.4765625,0.484375,0.4921875,0.5},"rfftfreq/typed/float64/128/1: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/float64/128/1: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float64/128/1: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/128/1: result: dtype")
eq(spacing:tolist(),1.0,"rfftfreq/typed/float64/128/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/128/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/128/1: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/128/1: spacing state: dtype")
cases=cases+1
end
-- 737: rfftfreq/typed/float64/128/2
do
local spacing=np.array(2.0,"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/float64/128/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.00390625,0.0078125,0.01171875,0.015625,0.01953125,0.0234375,0.02734375,0.03125,0.03515625,0.0390625,0.04296875,0.046875,0.05078125,0.0546875,0.05859375,0.0625,0.06640625,0.0703125,0.07421875,0.078125,0.08203125,0.0859375,0.08984375,0.09375,0.09765625,0.1015625,0.10546875,0.109375,0.11328125,0.1171875,0.12109375,0.125,0.12890625,0.1328125,0.13671875,0.140625,0.14453125,0.1484375,0.15234375,0.15625,0.16015625,0.1640625,0.16796875,0.171875,0.17578125,0.1796875,0.18359375,0.1875,0.19140625,0.1953125,0.19921875,0.203125,0.20703125,0.2109375,0.21484375,0.21875,0.22265625,0.2265625,0.23046875,0.234375,0.23828125,0.2421875,0.24609375,0.25},"rfftfreq/typed/float64/128/2: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/float64/128/2: result: shape")
eq(result.strides,{8},"rfftfreq/typed/float64/128/2: result: strides")
eq(result.dtype,"float64","rfftfreq/typed/float64/128/2: result: dtype")
eq(spacing:tolist(),2.0,"rfftfreq/typed/float64/128/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/float64/128/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/float64/128/2: spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/typed/float64/128/2: spacing state: dtype")
cases=cases+1
end
-- 738: rfftfreq/typed/complex64/-1/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/-1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/complex64/-1/0: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/complex64/-1/0: result: shape")
eq(result.strides,{0},"rfftfreq/typed/complex64/-1/0: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/-1/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"rfftfreq/typed/complex64/-1/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/-1/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/-1/0: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/-1/0: spacing state: dtype")
cases=cases+1
end
-- 739: rfftfreq/typed/complex64/-1/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/-1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/complex64/-1/1: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/complex64/-1/1: result: shape")
eq(result.strides,{0},"rfftfreq/typed/complex64/-1/1: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/-1/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"rfftfreq/typed/complex64/-1/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/-1/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/-1/1: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/-1/1: spacing state: dtype")
cases=cases+1
end
-- 740: rfftfreq/typed/complex64/-1/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/-1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/complex64/-1/2: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/complex64/-1/2: result: shape")
eq(result.strides,{0},"rfftfreq/typed/complex64/-1/2: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/-1/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"rfftfreq/typed/complex64/-1/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/-1/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/-1/2: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/-1/2: spacing state: dtype")
cases=cases+1
end
-- 741: rfftfreq/typed/complex64/0/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/0/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0))},"rfftfreq/typed/complex64/0/0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/complex64/0/0: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex64/0/0: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/0/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"rfftfreq/typed/complex64/0/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/0/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/0/0: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/0/0: spacing state: dtype")
cases=cases+1
end
-- 742: rfftfreq/typed/complex64/0/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/0/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0))},"rfftfreq/typed/complex64/0/1: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/complex64/0/1: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex64/0/1: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/0/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"rfftfreq/typed/complex64/0/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/0/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/0/1: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/0/1: spacing state: dtype")
cases=cases+1
end
-- 743: rfftfreq/typed/complex64/0/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/0/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0))},"rfftfreq/typed/complex64/0/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/complex64/0/2: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex64/0/2: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/0/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"rfftfreq/typed/complex64/0/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/0/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/0/2: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/0/2: spacing state: dtype")
cases=cases+1
end
-- 744: rfftfreq/typed/complex64/1/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0))},"rfftfreq/typed/complex64/1/0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/complex64/1/0: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex64/1/0: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/1/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"rfftfreq/typed/complex64/1/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/1/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/1/0: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/1/0: spacing state: dtype")
cases=cases+1
end
-- 745: rfftfreq/typed/complex64/1/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"rfftfreq/typed/complex64/1/1: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/complex64/1/1: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex64/1/1: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/1/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"rfftfreq/typed/complex64/1/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/1/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/1/1: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/1/1: spacing state: dtype")
cases=cases+1
end
-- 746: rfftfreq/typed/complex64/1/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"rfftfreq/typed/complex64/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/complex64/1/2: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex64/1/2: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/1/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"rfftfreq/typed/complex64/1/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/1/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/1/2: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/1/2: spacing state: dtype")
cases=cases+1
end
-- 747: rfftfreq/typed/complex64/3/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/3/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},"rfftfreq/typed/complex64/3/0: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/complex64/3/0: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex64/3/0: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/3/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"rfftfreq/typed/complex64/3/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/3/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/3/0: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/3/0: spacing state: dtype")
cases=cases+1
end
-- 748: rfftfreq/typed/complex64/3/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/3/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.3333333432674408,0.0)},"rfftfreq/typed/complex64/3/1: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/complex64/3/1: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex64/3/1: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/3/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"rfftfreq/typed/complex64/3/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/3/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/3/1: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/3/1: spacing state: dtype")
cases=cases+1
end
-- 749: rfftfreq/typed/complex64/3/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.1666666716337204,0.0)},"rfftfreq/typed/complex64/3/2: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/complex64/3/2: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex64/3/2: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/3/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"rfftfreq/typed/complex64/3/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/3/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/3/2: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/3/2: spacing state: dtype")
cases=cases+1
end
-- 750: rfftfreq/typed/complex64/4/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/4/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},"rfftfreq/typed/complex64/4/0: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/complex64/4/0: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex64/4/0: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/4/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"rfftfreq/typed/complex64/4/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/4/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/4/0: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/4/0: spacing state: dtype")
cases=cases+1
end
end
chunk()
end
do
local function chunk()
-- 751: rfftfreq/typed/complex64/4/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/4/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.25,0.0),np.complex(0.5,0.0)},"rfftfreq/typed/complex64/4/1: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/complex64/4/1: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex64/4/1: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/4/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"rfftfreq/typed/complex64/4/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/4/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/4/1: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/4/1: spacing state: dtype")
cases=cases+1
end
-- 752: rfftfreq/typed/complex64/4/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.125,0.0),np.complex(0.25,0.0)},"rfftfreq/typed/complex64/4/2: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/complex64/4/2: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex64/4/2: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/4/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"rfftfreq/typed/complex64/4/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/4/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/4/2: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/4/2: spacing state: dtype")
cases=cases+1
end
-- 753: rfftfreq/typed/complex64/15/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/15/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},"rfftfreq/typed/complex64/15/0: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/complex64/15/0: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex64/15/0: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/15/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"rfftfreq/typed/complex64/15/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/15/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/15/0: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/15/0: spacing state: dtype")
cases=cases+1
end
-- 754: rfftfreq/typed/complex64/15/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/15/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.06666667014360428,0.0),np.complex(0.13333334028720856,0.0),np.complex(0.20000001043081284,0.0),np.complex(0.2666666805744171,0.0),np.complex(0.3333333507180214,0.0),np.complex(0.40000002086162567,0.0),np.complex(0.46666669100522995,0.0)},"rfftfreq/typed/complex64/15/1: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/complex64/15/1: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex64/15/1: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/15/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"rfftfreq/typed/complex64/15/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/15/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/15/1: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/15/1: spacing state: dtype")
cases=cases+1
end
-- 755: rfftfreq/typed/complex64/15/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.03333333507180214,0.0),np.complex(0.06666667014360428,0.0),np.complex(0.10000000521540642,0.0),np.complex(0.13333334028720856,0.0),np.complex(0.1666666753590107,0.0),np.complex(0.20000001043081284,0.0),np.complex(0.23333334550261497,0.0)},"rfftfreq/typed/complex64/15/2: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/complex64/15/2: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex64/15/2: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/15/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"rfftfreq/typed/complex64/15/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/15/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/15/2: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/15/2: spacing state: dtype")
cases=cases+1
end
-- 756: rfftfreq/typed/complex64/127/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/127/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},"rfftfreq/typed/complex64/127/0: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/complex64/127/0: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex64/127/0: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/127/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"rfftfreq/typed/complex64/127/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/127/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/127/0: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/127/0: spacing state: dtype")
cases=cases+1
end
-- 757: rfftfreq/typed/complex64/127/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/127/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.007874015718698502,0.0),np.complex(0.015748031437397003,0.0),np.complex(0.023622047156095505,0.0),np.complex(0.031496062874794006,0.0),np.complex(0.03937007859349251,0.0),np.complex(0.04724409431219101,0.0),np.complex(0.05511811003088951,0.0),np.complex(0.06299212574958801,0.0),np.complex(0.07086614146828651,0.0),np.complex(0.07874015718698502,0.0),np.complex(0.08661417290568352,0.0),np.complex(0.09448818862438202,0.0),np.complex(0.10236220434308052,0.0),np.complex(0.11023622006177902,0.0),np.complex(0.11811023578047752,0.0),np.complex(0.12598425149917603,0.0),np.complex(0.13385826721787453,0.0),np.complex(0.14173228293657303,0.0),np.complex(0.14960629865527153,0.0),np.complex(0.15748031437397003,0.0),np.complex(0.16535433009266853,0.0),np.complex(0.17322834581136703,0.0),np.complex(0.18110236153006554,0.0),np.complex(0.18897637724876404,0.0),np.complex(0.19685039296746254,0.0),np.complex(0.20472440868616104,0.0),np.complex(0.21259842440485954,0.0),np.complex(0.22047244012355804,0.0),np.complex(0.22834645584225655,0.0),np.complex(0.23622047156095505,0.0),np.complex(0.24409448727965355,0.0),np.complex(0.25196850299835205,0.0),np.complex(0.25984251871705055,0.0),np.complex(0.26771653443574905,0.0),np.complex(0.27559055015444756,0.0),np.complex(0.28346456587314606,0.0),np.complex(0.29133858159184456,0.0),np.complex(0.29921259731054306,0.0),np.complex(0.30708661302924156,0.0),np.complex(0.31496062874794006,0.0),np.complex(0.32283464446663857,0.0),np.complex(0.33070866018533707,0.0),np.complex(0.33858267590403557,0.0),np.complex(0.34645669162273407,0.0),np.complex(0.35433070734143257,0.0),np.complex(0.3622047230601311,0.0),np.complex(0.3700787387788296,0.0),np.complex(0.3779527544975281,0.0),np.complex(0.3858267702162266,0.0),np.complex(0.3937007859349251,0.0),np.complex(0.4015748016536236,0.0),np.complex(0.4094488173723221,0.0),np.complex(0.4173228330910206,0.0),np.complex(0.4251968488097191,0.0),np.complex(0.4330708645284176,0.0),np.complex(0.4409448802471161,0.0),np.complex(0.4488188959658146,0.0),np.complex(0.4566929116845131,0.0),np.complex(0.4645669274032116,0.0),np.complex(0.4724409431219101,0.0),np.complex(0.4803149588406086,0.0),np.complex(0.4881889745593071,0.0),np.complex(0.4960629902780056,0.0)},"rfftfreq/typed/complex64/127/1: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/complex64/127/1: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex64/127/1: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/127/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"rfftfreq/typed/complex64/127/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/127/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/127/1: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/127/1: spacing state: dtype")
cases=cases+1
end
-- 758: rfftfreq/typed/complex64/127/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.003937007859349251,0.0),np.complex(0.007874015718698502,0.0),np.complex(0.011811023578047752,0.0),np.complex(0.015748031437397003,0.0),np.complex(0.019685039296746254,0.0),np.complex(0.023622047156095505,0.0),np.complex(0.027559055015444756,0.0),np.complex(0.031496062874794006,0.0),np.complex(0.03543307073414326,0.0),np.complex(0.03937007859349251,0.0),np.complex(0.04330708645284176,0.0),np.complex(0.04724409431219101,0.0),np.complex(0.05118110217154026,0.0),np.complex(0.05511811003088951,0.0),np.complex(0.05905511789023876,0.0),np.complex(0.06299212574958801,0.0),np.complex(0.06692913360893726,0.0),np.complex(0.07086614146828651,0.0),np.complex(0.07480314932763577,0.0),np.complex(0.07874015718698502,0.0),np.complex(0.08267716504633427,0.0),np.complex(0.08661417290568352,0.0),np.complex(0.09055118076503277,0.0),np.complex(0.09448818862438202,0.0),np.complex(0.09842519648373127,0.0),np.complex(0.10236220434308052,0.0),np.complex(0.10629921220242977,0.0),np.complex(0.11023622006177902,0.0),np.complex(0.11417322792112827,0.0),np.complex(0.11811023578047752,0.0),np.complex(0.12204724363982677,0.0),np.complex(0.12598425149917603,0.0),np.complex(0.12992125935852528,0.0),np.complex(0.13385826721787453,0.0),np.complex(0.13779527507722378,0.0),np.complex(0.14173228293657303,0.0),np.complex(0.14566929079592228,0.0),np.complex(0.14960629865527153,0.0),np.complex(0.15354330651462078,0.0),np.complex(0.15748031437397003,0.0),np.complex(0.16141732223331928,0.0),np.complex(0.16535433009266853,0.0),np.complex(0.16929133795201778,0.0),np.complex(0.17322834581136703,0.0),np.complex(0.17716535367071629,0.0),np.complex(0.18110236153006554,0.0),np.complex(0.1850393693894148,0.0),np.complex(0.18897637724876404,0.0),np.complex(0.1929133851081133,0.0),np.complex(0.19685039296746254,0.0),np.complex(0.2007874008268118,0.0),np.complex(0.20472440868616104,0.0),np.complex(0.2086614165455103,0.0),np.complex(0.21259842440485954,0.0),np.complex(0.2165354322642088,0.0),np.complex(0.22047244012355804,0.0),np.complex(0.2244094479829073,0.0),np.complex(0.22834645584225655,0.0),np.complex(0.2322834637016058,0.0),np.complex(0.23622047156095505,0.0),np.complex(0.2401574794203043,0.0),np.complex(0.24409448727965355,0.0),np.complex(0.2480314951390028,0.0)},"rfftfreq/typed/complex64/127/2: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/complex64/127/2: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex64/127/2: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/127/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"rfftfreq/typed/complex64/127/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/127/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/127/2: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/127/2: spacing state: dtype")
cases=cases+1
end
-- 759: rfftfreq/typed/complex64/128/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/128/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},"rfftfreq/typed/complex64/128/0: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/complex64/128/0: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex64/128/0: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/128/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"rfftfreq/typed/complex64/128/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/128/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/128/0: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/128/0: spacing state: dtype")
cases=cases+1
end
-- 760: rfftfreq/typed/complex64/128/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/128/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.0078125,0.0),np.complex(0.015625,0.0),np.complex(0.0234375,0.0),np.complex(0.03125,0.0),np.complex(0.0390625,0.0),np.complex(0.046875,0.0),np.complex(0.0546875,0.0),np.complex(0.0625,0.0),np.complex(0.0703125,0.0),np.complex(0.078125,0.0),np.complex(0.0859375,0.0),np.complex(0.09375,0.0),np.complex(0.1015625,0.0),np.complex(0.109375,0.0),np.complex(0.1171875,0.0),np.complex(0.125,0.0),np.complex(0.1328125,0.0),np.complex(0.140625,0.0),np.complex(0.1484375,0.0),np.complex(0.15625,0.0),np.complex(0.1640625,0.0),np.complex(0.171875,0.0),np.complex(0.1796875,0.0),np.complex(0.1875,0.0),np.complex(0.1953125,0.0),np.complex(0.203125,0.0),np.complex(0.2109375,0.0),np.complex(0.21875,0.0),np.complex(0.2265625,0.0),np.complex(0.234375,0.0),np.complex(0.2421875,0.0),np.complex(0.25,0.0),np.complex(0.2578125,0.0),np.complex(0.265625,0.0),np.complex(0.2734375,0.0),np.complex(0.28125,0.0),np.complex(0.2890625,0.0),np.complex(0.296875,0.0),np.complex(0.3046875,0.0),np.complex(0.3125,0.0),np.complex(0.3203125,0.0),np.complex(0.328125,0.0),np.complex(0.3359375,0.0),np.complex(0.34375,0.0),np.complex(0.3515625,0.0),np.complex(0.359375,0.0),np.complex(0.3671875,0.0),np.complex(0.375,0.0),np.complex(0.3828125,0.0),np.complex(0.390625,0.0),np.complex(0.3984375,0.0),np.complex(0.40625,0.0),np.complex(0.4140625,0.0),np.complex(0.421875,0.0),np.complex(0.4296875,0.0),np.complex(0.4375,0.0),np.complex(0.4453125,0.0),np.complex(0.453125,0.0),np.complex(0.4609375,0.0),np.complex(0.46875,0.0),np.complex(0.4765625,0.0),np.complex(0.484375,0.0),np.complex(0.4921875,0.0),np.complex(0.5,0.0)},"rfftfreq/typed/complex64/128/1: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/complex64/128/1: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex64/128/1: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/128/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"rfftfreq/typed/complex64/128/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/128/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/128/1: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/128/1: spacing state: dtype")
cases=cases+1
end
-- 761: rfftfreq/typed/complex64/128/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/complex64/128/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.00390625,0.0),np.complex(0.0078125,0.0),np.complex(0.01171875,0.0),np.complex(0.015625,0.0),np.complex(0.01953125,0.0),np.complex(0.0234375,0.0),np.complex(0.02734375,0.0),np.complex(0.03125,0.0),np.complex(0.03515625,0.0),np.complex(0.0390625,0.0),np.complex(0.04296875,0.0),np.complex(0.046875,0.0),np.complex(0.05078125,0.0),np.complex(0.0546875,0.0),np.complex(0.05859375,0.0),np.complex(0.0625,0.0),np.complex(0.06640625,0.0),np.complex(0.0703125,0.0),np.complex(0.07421875,0.0),np.complex(0.078125,0.0),np.complex(0.08203125,0.0),np.complex(0.0859375,0.0),np.complex(0.08984375,0.0),np.complex(0.09375,0.0),np.complex(0.09765625,0.0),np.complex(0.1015625,0.0),np.complex(0.10546875,0.0),np.complex(0.109375,0.0),np.complex(0.11328125,0.0),np.complex(0.1171875,0.0),np.complex(0.12109375,0.0),np.complex(0.125,0.0),np.complex(0.12890625,0.0),np.complex(0.1328125,0.0),np.complex(0.13671875,0.0),np.complex(0.140625,0.0),np.complex(0.14453125,0.0),np.complex(0.1484375,0.0),np.complex(0.15234375,0.0),np.complex(0.15625,0.0),np.complex(0.16015625,0.0),np.complex(0.1640625,0.0),np.complex(0.16796875,0.0),np.complex(0.171875,0.0),np.complex(0.17578125,0.0),np.complex(0.1796875,0.0),np.complex(0.18359375,0.0),np.complex(0.1875,0.0),np.complex(0.19140625,0.0),np.complex(0.1953125,0.0),np.complex(0.19921875,0.0),np.complex(0.203125,0.0),np.complex(0.20703125,0.0),np.complex(0.2109375,0.0),np.complex(0.21484375,0.0),np.complex(0.21875,0.0),np.complex(0.22265625,0.0),np.complex(0.2265625,0.0),np.complex(0.23046875,0.0),np.complex(0.234375,0.0),np.complex(0.23828125,0.0),np.complex(0.2421875,0.0),np.complex(0.24609375,0.0),np.complex(0.25,0.0)},"rfftfreq/typed/complex64/128/2: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/complex64/128/2: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex64/128/2: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex64/128/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"rfftfreq/typed/complex64/128/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex64/128/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex64/128/2: spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/typed/complex64/128/2: spacing state: dtype")
cases=cases+1
end
-- 762: rfftfreq/typed/complex128/-1/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/-1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/complex128/-1/0: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/complex128/-1/0: result: shape")
eq(result.strides,{0},"rfftfreq/typed/complex128/-1/0: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/-1/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"rfftfreq/typed/complex128/-1/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/-1/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/-1/0: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/-1/0: spacing state: dtype")
cases=cases+1
end
-- 763: rfftfreq/typed/complex128/-1/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/-1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/complex128/-1/1: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/complex128/-1/1: result: shape")
eq(result.strides,{0},"rfftfreq/typed/complex128/-1/1: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/-1/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"rfftfreq/typed/complex128/-1/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/-1/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/-1/1: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/-1/1: spacing state: dtype")
cases=cases+1
end
-- 764: rfftfreq/typed/complex128/-1/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(-1,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/-1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{},"rfftfreq/typed/complex128/-1/2: result",2e-12,2e-12)
eq(result.shape,{0},"rfftfreq/typed/complex128/-1/2: result: shape")
eq(result.strides,{0},"rfftfreq/typed/complex128/-1/2: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/-1/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"rfftfreq/typed/complex128/-1/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/-1/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/-1/2: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/-1/2: spacing state: dtype")
cases=cases+1
end
-- 765: rfftfreq/typed/complex128/0/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/0/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0))},"rfftfreq/typed/complex128/0/0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/complex128/0/0: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex128/0/0: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/0/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"rfftfreq/typed/complex128/0/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/0/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/0/0: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/0/0: spacing state: dtype")
cases=cases+1
end
-- 766: rfftfreq/typed/complex128/0/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/0/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0))},"rfftfreq/typed/complex128/0/1: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/complex128/0/1: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex128/0/1: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/0/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"rfftfreq/typed/complex128/0/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/0/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/0/1: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/0/1: spacing state: dtype")
cases=cases+1
end
-- 767: rfftfreq/typed/complex128/0/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/0/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0))},"rfftfreq/typed/complex128/0/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/complex128/0/2: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex128/0/2: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/0/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"rfftfreq/typed/complex128/0/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/0/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/0/2: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/0/2: spacing state: dtype")
cases=cases+1
end
-- 768: rfftfreq/typed/complex128/1/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/1/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0))},"rfftfreq/typed/complex128/1/0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/complex128/1/0: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex128/1/0: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/1/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"rfftfreq/typed/complex128/1/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/1/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/1/0: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/1/0: spacing state: dtype")
cases=cases+1
end
-- 769: rfftfreq/typed/complex128/1/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/1/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"rfftfreq/typed/complex128/1/1: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/complex128/1/1: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex128/1/1: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/1/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"rfftfreq/typed/complex128/1/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/1/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/1/1: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/1/1: spacing state: dtype")
cases=cases+1
end
-- 770: rfftfreq/typed/complex128/1/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(1,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/1/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0)},"rfftfreq/typed/complex128/1/2: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/typed/complex128/1/2: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex128/1/2: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/1/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"rfftfreq/typed/complex128/1/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/1/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/1/2: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/1/2: spacing state: dtype")
cases=cases+1
end
-- 771: rfftfreq/typed/complex128/3/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/3/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},"rfftfreq/typed/complex128/3/0: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/complex128/3/0: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex128/3/0: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/3/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"rfftfreq/typed/complex128/3/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/3/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/3/0: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/3/0: spacing state: dtype")
cases=cases+1
end
-- 772: rfftfreq/typed/complex128/3/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/3/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.3333333333333333,0.0)},"rfftfreq/typed/complex128/3/1: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/complex128/3/1: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex128/3/1: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/3/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"rfftfreq/typed/complex128/3/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/3/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/3/1: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/3/1: spacing state: dtype")
cases=cases+1
end
-- 773: rfftfreq/typed/complex128/3/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/3/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.16666666666666666,0.0)},"rfftfreq/typed/complex128/3/2: result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/typed/complex128/3/2: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex128/3/2: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/3/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"rfftfreq/typed/complex128/3/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/3/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/3/2: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/3/2: spacing state: dtype")
cases=cases+1
end
-- 774: rfftfreq/typed/complex128/4/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/4/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},"rfftfreq/typed/complex128/4/0: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/complex128/4/0: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex128/4/0: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/4/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"rfftfreq/typed/complex128/4/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/4/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/4/0: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/4/0: spacing state: dtype")
cases=cases+1
end
-- 775: rfftfreq/typed/complex128/4/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/4/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.25,0.0),np.complex(0.5,0.0)},"rfftfreq/typed/complex128/4/1: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/complex128/4/1: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex128/4/1: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/4/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"rfftfreq/typed/complex128/4/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/4/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/4/1: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/4/1: spacing state: dtype")
cases=cases+1
end
-- 776: rfftfreq/typed/complex128/4/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/4/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.125,0.0),np.complex(0.25,0.0)},"rfftfreq/typed/complex128/4/2: result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/typed/complex128/4/2: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex128/4/2: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/4/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"rfftfreq/typed/complex128/4/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/4/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/4/2: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/4/2: spacing state: dtype")
cases=cases+1
end
-- 777: rfftfreq/typed/complex128/15/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/15/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},"rfftfreq/typed/complex128/15/0: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/complex128/15/0: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex128/15/0: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/15/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"rfftfreq/typed/complex128/15/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/15/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/15/0: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/15/0: spacing state: dtype")
cases=cases+1
end
-- 778: rfftfreq/typed/complex128/15/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/15/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.06666666666666667,0.0),np.complex(0.13333333333333333,0.0),np.complex(0.2,0.0),np.complex(0.26666666666666666,0.0),np.complex(0.3333333333333333,0.0),np.complex(0.4,0.0),np.complex(0.4666666666666667,0.0)},"rfftfreq/typed/complex128/15/1: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/complex128/15/1: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex128/15/1: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/15/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"rfftfreq/typed/complex128/15/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/15/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/15/1: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/15/1: spacing state: dtype")
cases=cases+1
end
-- 779: rfftfreq/typed/complex128/15/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(15,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/15/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.03333333333333333,0.0),np.complex(0.06666666666666667,0.0),np.complex(0.1,0.0),np.complex(0.13333333333333333,0.0),np.complex(0.16666666666666666,0.0),np.complex(0.2,0.0),np.complex(0.23333333333333334,0.0)},"rfftfreq/typed/complex128/15/2: result",2e-12,2e-12)
eq(result.shape,{8},"rfftfreq/typed/complex128/15/2: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex128/15/2: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/15/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"rfftfreq/typed/complex128/15/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/15/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/15/2: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/15/2: spacing state: dtype")
cases=cases+1
end
-- 780: rfftfreq/typed/complex128/127/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/127/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},"rfftfreq/typed/complex128/127/0: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/complex128/127/0: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex128/127/0: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/127/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"rfftfreq/typed/complex128/127/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/127/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/127/0: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/127/0: spacing state: dtype")
cases=cases+1
end
-- 781: rfftfreq/typed/complex128/127/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/127/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.007874015748031496,0.0),np.complex(0.015748031496062992,0.0),np.complex(0.023622047244094488,0.0),np.complex(0.031496062992125984,0.0),np.complex(0.03937007874015748,0.0),np.complex(0.047244094488188976,0.0),np.complex(0.05511811023622047,0.0),np.complex(0.06299212598425197,0.0),np.complex(0.07086614173228346,0.0),np.complex(0.07874015748031496,0.0),np.complex(0.08661417322834646,0.0),np.complex(0.09448818897637795,0.0),np.complex(0.10236220472440945,0.0),np.complex(0.11023622047244094,0.0),np.complex(0.11811023622047244,0.0),np.complex(0.12598425196850394,0.0),np.complex(0.13385826771653542,0.0),np.complex(0.14173228346456693,0.0),np.complex(0.14960629921259844,0.0),np.complex(0.15748031496062992,0.0),np.complex(0.1653543307086614,0.0),np.complex(0.1732283464566929,0.0),np.complex(0.18110236220472442,0.0),np.complex(0.1889763779527559,0.0),np.complex(0.19685039370078738,0.0),np.complex(0.2047244094488189,0.0),np.complex(0.2125984251968504,0.0),np.complex(0.2204724409448819,0.0),np.complex(0.22834645669291337,0.0),np.complex(0.23622047244094488,0.0),np.complex(0.2440944881889764,0.0),np.complex(0.25196850393700787,0.0),np.complex(0.25984251968503935,0.0),np.complex(0.26771653543307083,0.0),np.complex(0.2755905511811024,0.0),np.complex(0.28346456692913385,0.0),np.complex(0.29133858267716534,0.0),np.complex(0.2992125984251969,0.0),np.complex(0.30708661417322836,0.0),np.complex(0.31496062992125984,0.0),np.complex(0.3228346456692913,0.0),np.complex(0.3307086614173228,0.0),np.complex(0.33858267716535434,0.0),np.complex(0.3464566929133858,0.0),np.complex(0.3543307086614173,0.0),np.complex(0.36220472440944884,0.0),np.complex(0.3700787401574803,0.0),np.complex(0.3779527559055118,0.0),np.complex(0.3858267716535433,0.0),np.complex(0.39370078740157477,0.0),np.complex(0.4015748031496063,0.0),np.complex(0.4094488188976378,0.0),np.complex(0.41732283464566927,0.0),np.complex(0.4251968503937008,0.0),np.complex(0.4330708661417323,0.0),np.complex(0.4409448818897638,0.0),np.complex(0.44881889763779526,0.0),np.complex(0.45669291338582674,0.0),np.complex(0.4645669291338583,0.0),np.complex(0.47244094488188976,0.0),np.complex(0.48031496062992124,0.0),np.complex(0.4881889763779528,0.0),np.complex(0.49606299212598426,0.0)},"rfftfreq/typed/complex128/127/1: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/complex128/127/1: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex128/127/1: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/127/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"rfftfreq/typed/complex128/127/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/127/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/127/1: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/127/1: spacing state: dtype")
cases=cases+1
end
-- 782: rfftfreq/typed/complex128/127/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(127,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/127/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.003937007874015748,0.0),np.complex(0.007874015748031496,0.0),np.complex(0.011811023622047244,0.0),np.complex(0.015748031496062992,0.0),np.complex(0.01968503937007874,0.0),np.complex(0.023622047244094488,0.0),np.complex(0.027559055118110236,0.0),np.complex(0.031496062992125984,0.0),np.complex(0.03543307086614173,0.0),np.complex(0.03937007874015748,0.0),np.complex(0.04330708661417323,0.0),np.complex(0.047244094488188976,0.0),np.complex(0.051181102362204724,0.0),np.complex(0.05511811023622047,0.0),np.complex(0.05905511811023622,0.0),np.complex(0.06299212598425197,0.0),np.complex(0.06692913385826771,0.0),np.complex(0.07086614173228346,0.0),np.complex(0.07480314960629922,0.0),np.complex(0.07874015748031496,0.0),np.complex(0.0826771653543307,0.0),np.complex(0.08661417322834646,0.0),np.complex(0.09055118110236221,0.0),np.complex(0.09448818897637795,0.0),np.complex(0.09842519685039369,0.0),np.complex(0.10236220472440945,0.0),np.complex(0.1062992125984252,0.0),np.complex(0.11023622047244094,0.0),np.complex(0.11417322834645668,0.0),np.complex(0.11811023622047244,0.0),np.complex(0.1220472440944882,0.0),np.complex(0.12598425196850394,0.0),np.complex(0.12992125984251968,0.0),np.complex(0.13385826771653542,0.0),np.complex(0.1377952755905512,0.0),np.complex(0.14173228346456693,0.0),np.complex(0.14566929133858267,0.0),np.complex(0.14960629921259844,0.0),np.complex(0.15354330708661418,0.0),np.complex(0.15748031496062992,0.0),np.complex(0.16141732283464566,0.0),np.complex(0.1653543307086614,0.0),np.complex(0.16929133858267717,0.0),np.complex(0.1732283464566929,0.0),np.complex(0.17716535433070865,0.0),np.complex(0.18110236220472442,0.0),np.complex(0.18503937007874016,0.0),np.complex(0.1889763779527559,0.0),np.complex(0.19291338582677164,0.0),np.complex(0.19685039370078738,0.0),np.complex(0.20078740157480315,0.0),np.complex(0.2047244094488189,0.0),np.complex(0.20866141732283464,0.0),np.complex(0.2125984251968504,0.0),np.complex(0.21653543307086615,0.0),np.complex(0.2204724409448819,0.0),np.complex(0.22440944881889763,0.0),np.complex(0.22834645669291337,0.0),np.complex(0.23228346456692914,0.0),np.complex(0.23622047244094488,0.0),np.complex(0.24015748031496062,0.0),np.complex(0.2440944881889764,0.0),np.complex(0.24803149606299213,0.0)},"rfftfreq/typed/complex128/127/2: result",2e-12,2e-12)
eq(result.shape,{64},"rfftfreq/typed/complex128/127/2: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex128/127/2: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/127/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"rfftfreq/typed/complex128/127/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/127/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/127/2: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/127/2: spacing state: dtype")
cases=cases+1
end
-- 783: rfftfreq/typed/complex128/128/0
do
local spacing=np.array(np.complex(0.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/128/0: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},"rfftfreq/typed/complex128/128/0: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/complex128/128/0: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex128/128/0: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/128/0: result: dtype")
eq(spacing:tolist(),np.complex(0.0,0.0),"rfftfreq/typed/complex128/128/0: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/128/0: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/128/0: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/128/0: spacing state: dtype")
cases=cases+1
end
-- 784: rfftfreq/typed/complex128/128/1
do
local spacing=np.array(np.complex(1.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/128/1: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.0078125,0.0),np.complex(0.015625,0.0),np.complex(0.0234375,0.0),np.complex(0.03125,0.0),np.complex(0.0390625,0.0),np.complex(0.046875,0.0),np.complex(0.0546875,0.0),np.complex(0.0625,0.0),np.complex(0.0703125,0.0),np.complex(0.078125,0.0),np.complex(0.0859375,0.0),np.complex(0.09375,0.0),np.complex(0.1015625,0.0),np.complex(0.109375,0.0),np.complex(0.1171875,0.0),np.complex(0.125,0.0),np.complex(0.1328125,0.0),np.complex(0.140625,0.0),np.complex(0.1484375,0.0),np.complex(0.15625,0.0),np.complex(0.1640625,0.0),np.complex(0.171875,0.0),np.complex(0.1796875,0.0),np.complex(0.1875,0.0),np.complex(0.1953125,0.0),np.complex(0.203125,0.0),np.complex(0.2109375,0.0),np.complex(0.21875,0.0),np.complex(0.2265625,0.0),np.complex(0.234375,0.0),np.complex(0.2421875,0.0),np.complex(0.25,0.0),np.complex(0.2578125,0.0),np.complex(0.265625,0.0),np.complex(0.2734375,0.0),np.complex(0.28125,0.0),np.complex(0.2890625,0.0),np.complex(0.296875,0.0),np.complex(0.3046875,0.0),np.complex(0.3125,0.0),np.complex(0.3203125,0.0),np.complex(0.328125,0.0),np.complex(0.3359375,0.0),np.complex(0.34375,0.0),np.complex(0.3515625,0.0),np.complex(0.359375,0.0),np.complex(0.3671875,0.0),np.complex(0.375,0.0),np.complex(0.3828125,0.0),np.complex(0.390625,0.0),np.complex(0.3984375,0.0),np.complex(0.40625,0.0),np.complex(0.4140625,0.0),np.complex(0.421875,0.0),np.complex(0.4296875,0.0),np.complex(0.4375,0.0),np.complex(0.4453125,0.0),np.complex(0.453125,0.0),np.complex(0.4609375,0.0),np.complex(0.46875,0.0),np.complex(0.4765625,0.0),np.complex(0.484375,0.0),np.complex(0.4921875,0.0),np.complex(0.5,0.0)},"rfftfreq/typed/complex128/128/1: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/complex128/128/1: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex128/128/1: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/128/1: result: dtype")
eq(spacing:tolist(),np.complex(1.0,0.0),"rfftfreq/typed/complex128/128/1: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/128/1: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/128/1: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/128/1: spacing state: dtype")
cases=cases+1
end
-- 785: rfftfreq/typed/complex128/128/2
do
local spacing=np.array(np.complex(2.0,0.0),"complex128")
local ok,result=pcall(function() return np.fft.rfftfreq(128,spacing) end)
assert(ok==true,"rfftfreq/typed/complex128/128/2: acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.00390625,0.0),np.complex(0.0078125,0.0),np.complex(0.01171875,0.0),np.complex(0.015625,0.0),np.complex(0.01953125,0.0),np.complex(0.0234375,0.0),np.complex(0.02734375,0.0),np.complex(0.03125,0.0),np.complex(0.03515625,0.0),np.complex(0.0390625,0.0),np.complex(0.04296875,0.0),np.complex(0.046875,0.0),np.complex(0.05078125,0.0),np.complex(0.0546875,0.0),np.complex(0.05859375,0.0),np.complex(0.0625,0.0),np.complex(0.06640625,0.0),np.complex(0.0703125,0.0),np.complex(0.07421875,0.0),np.complex(0.078125,0.0),np.complex(0.08203125,0.0),np.complex(0.0859375,0.0),np.complex(0.08984375,0.0),np.complex(0.09375,0.0),np.complex(0.09765625,0.0),np.complex(0.1015625,0.0),np.complex(0.10546875,0.0),np.complex(0.109375,0.0),np.complex(0.11328125,0.0),np.complex(0.1171875,0.0),np.complex(0.12109375,0.0),np.complex(0.125,0.0),np.complex(0.12890625,0.0),np.complex(0.1328125,0.0),np.complex(0.13671875,0.0),np.complex(0.140625,0.0),np.complex(0.14453125,0.0),np.complex(0.1484375,0.0),np.complex(0.15234375,0.0),np.complex(0.15625,0.0),np.complex(0.16015625,0.0),np.complex(0.1640625,0.0),np.complex(0.16796875,0.0),np.complex(0.171875,0.0),np.complex(0.17578125,0.0),np.complex(0.1796875,0.0),np.complex(0.18359375,0.0),np.complex(0.1875,0.0),np.complex(0.19140625,0.0),np.complex(0.1953125,0.0),np.complex(0.19921875,0.0),np.complex(0.203125,0.0),np.complex(0.20703125,0.0),np.complex(0.2109375,0.0),np.complex(0.21484375,0.0),np.complex(0.21875,0.0),np.complex(0.22265625,0.0),np.complex(0.2265625,0.0),np.complex(0.23046875,0.0),np.complex(0.234375,0.0),np.complex(0.23828125,0.0),np.complex(0.2421875,0.0),np.complex(0.24609375,0.0),np.complex(0.25,0.0)},"rfftfreq/typed/complex128/128/2: result",2e-12,2e-12)
eq(result.shape,{65},"rfftfreq/typed/complex128/128/2: result: shape")
eq(result.strides,{16},"rfftfreq/typed/complex128/128/2: result: strides")
eq(result.dtype,"complex128","rfftfreq/typed/complex128/128/2: result: dtype")
eq(spacing:tolist(),np.complex(2.0,0.0),"rfftfreq/typed/complex128/128/2: spacing state")
eq(spacing.shape,{},"rfftfreq/typed/complex128/128/2: spacing state: shape")
eq(spacing.strides,{},"rfftfreq/typed/complex128/128/2: spacing state: strides")
eq(spacing.dtype,"complex128","rfftfreq/typed/complex128/128/2: spacing state: dtype")
cases=cases+1
end
-- 786: rfftfreq/broadcast/float32/0/(1,)
do
local spacing=np.array({0.5},"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/broadcast/float32/0/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/broadcast/float32/0/(1,): result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/broadcast/float32/0/(1,): result: shape")
eq(result.strides,{8},"rfftfreq/broadcast/float32/0/(1,): result: strides")
eq(result.dtype,"float64","rfftfreq/broadcast/float32/0/(1,): result: dtype")
eq(spacing:tolist(),{0.5},"rfftfreq/broadcast/float32/0/(1,): spacing state")
eq(spacing.shape,{1},"rfftfreq/broadcast/float32/0/(1,): spacing state: shape")
eq(spacing.strides,{4},"rfftfreq/broadcast/float32/0/(1,): spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/broadcast/float32/0/(1,): spacing state: dtype")
cases=cases+1
end
-- 787: rfftfreq/broadcast/float32/0/(3,)
do
local spacing=np.array({0.5,0.5,0.5},"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/broadcast/float32/0/(3,): acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),(0/0),(0/0)},"rfftfreq/broadcast/float32/0/(3,): result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/broadcast/float32/0/(3,): result: shape")
eq(result.strides,{8},"rfftfreq/broadcast/float32/0/(3,): result: strides")
eq(result.dtype,"float64","rfftfreq/broadcast/float32/0/(3,): result: dtype")
eq(spacing:tolist(),{0.5,0.5,0.5},"rfftfreq/broadcast/float32/0/(3,): spacing state")
eq(spacing.shape,{3},"rfftfreq/broadcast/float32/0/(3,): spacing state: shape")
eq(spacing.strides,{4},"rfftfreq/broadcast/float32/0/(3,): spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/broadcast/float32/0/(3,): spacing state: dtype")
cases=cases+1
end
-- 788: rfftfreq/broadcast/float32/0/(2, 1)
do
local spacing=np.array({{0.5},{0.5}},"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/broadcast/float32/0/(2, 1): acceptance"..": "..tostring(result))
eq(result:tolist(),{{(0/0)},{(0/0)}},"rfftfreq/broadcast/float32/0/(2, 1): result",2e-12,2e-12)
eq(result.shape,{2,1},"rfftfreq/broadcast/float32/0/(2, 1): result: shape")
eq(result.strides,{8,8},"rfftfreq/broadcast/float32/0/(2, 1): result: strides")
eq(result.dtype,"float64","rfftfreq/broadcast/float32/0/(2, 1): result: dtype")
eq(spacing:tolist(),{{0.5},{0.5}},"rfftfreq/broadcast/float32/0/(2, 1): spacing state")
eq(spacing.shape,{2,1},"rfftfreq/broadcast/float32/0/(2, 1): spacing state: shape")
eq(spacing.strides,{4,4},"rfftfreq/broadcast/float32/0/(2, 1): spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/broadcast/float32/0/(2, 1): spacing state: dtype")
cases=cases+1
end
-- 789: rfftfreq/broadcast/float32/0/(2, 3)
do
local spacing=np.array({{0.5,0.5,0.5},{0.5,0.5,0.5}},"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/broadcast/float32/0/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{{(0/0),(0/0),(0/0)},{(0/0),(0/0),(0/0)}},"rfftfreq/broadcast/float32/0/(2, 3): result",2e-12,2e-12)
eq(result.shape,{2,3},"rfftfreq/broadcast/float32/0/(2, 3): result: shape")
eq(result.strides,{24,8},"rfftfreq/broadcast/float32/0/(2, 3): result: strides")
eq(result.dtype,"float64","rfftfreq/broadcast/float32/0/(2, 3): result: dtype")
eq(spacing:tolist(),{{0.5,0.5,0.5},{0.5,0.5,0.5}},"rfftfreq/broadcast/float32/0/(2, 3): spacing state")
eq(spacing.shape,{2,3},"rfftfreq/broadcast/float32/0/(2, 3): spacing state: shape")
eq(spacing.strides,{12,4},"rfftfreq/broadcast/float32/0/(2, 3): spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/broadcast/float32/0/(2, 3): spacing state: dtype")
cases=cases+1
end
-- 790: rfftfreq/broadcast/float32/3/(1,)
do
local spacing=np.array({0.5},"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/broadcast/float32/3/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.6666666865348816},"rfftfreq/broadcast/float32/3/(1,): result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/broadcast/float32/3/(1,): result: shape")
eq(result.strides,{8},"rfftfreq/broadcast/float32/3/(1,): result: strides")
eq(result.dtype,"float64","rfftfreq/broadcast/float32/3/(1,): result: dtype")
eq(spacing:tolist(),{0.5},"rfftfreq/broadcast/float32/3/(1,): spacing state")
eq(spacing.shape,{1},"rfftfreq/broadcast/float32/3/(1,): spacing state: shape")
eq(spacing.strides,{4},"rfftfreq/broadcast/float32/3/(1,): spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/broadcast/float32/3/(1,): spacing state: dtype")
cases=cases+1
end
-- 791: rfftfreq/broadcast/float32/3/(3,)
do
local spacing=np.array({0.5,0.5,0.5},"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==false,"rfftfreq/broadcast/float32/3/(3,): acceptance"..": "..tostring(result))
eq(spacing:tolist(),{0.5,0.5,0.5},"rfftfreq/broadcast/float32/3/(3,): spacing state")
eq(spacing.shape,{3},"rfftfreq/broadcast/float32/3/(3,): spacing state: shape")
eq(spacing.strides,{4},"rfftfreq/broadcast/float32/3/(3,): spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/broadcast/float32/3/(3,): spacing state: dtype")
cases=cases+1
end
-- 792: rfftfreq/broadcast/float32/3/(2, 1)
do
local spacing=np.array({{0.5},{0.5}},"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/broadcast/float32/3/(2, 1): acceptance"..": "..tostring(result))
eq(result:tolist(),{{0.0,0.6666666865348816},{0.0,0.6666666865348816}},"rfftfreq/broadcast/float32/3/(2, 1): result",2e-12,2e-12)
eq(result.shape,{2,2},"rfftfreq/broadcast/float32/3/(2, 1): result: shape")
eq(result.strides,{16,8},"rfftfreq/broadcast/float32/3/(2, 1): result: strides")
eq(result.dtype,"float64","rfftfreq/broadcast/float32/3/(2, 1): result: dtype")
eq(spacing:tolist(),{{0.5},{0.5}},"rfftfreq/broadcast/float32/3/(2, 1): spacing state")
eq(spacing.shape,{2,1},"rfftfreq/broadcast/float32/3/(2, 1): spacing state: shape")
eq(spacing.strides,{4,4},"rfftfreq/broadcast/float32/3/(2, 1): spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/broadcast/float32/3/(2, 1): spacing state: dtype")
cases=cases+1
end
-- 793: rfftfreq/broadcast/float32/3/(2, 3)
do
local spacing=np.array({{0.5,0.5,0.5},{0.5,0.5,0.5}},"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==false,"rfftfreq/broadcast/float32/3/(2, 3): acceptance"..": "..tostring(result))
eq(spacing:tolist(),{{0.5,0.5,0.5},{0.5,0.5,0.5}},"rfftfreq/broadcast/float32/3/(2, 3): spacing state")
eq(spacing.shape,{2,3},"rfftfreq/broadcast/float32/3/(2, 3): spacing state: shape")
eq(spacing.strides,{12,4},"rfftfreq/broadcast/float32/3/(2, 3): spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/broadcast/float32/3/(2, 3): spacing state: dtype")
cases=cases+1
end
-- 794: rfftfreq/broadcast/float32/4/(1,)
do
local spacing=np.array({0.5},"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/broadcast/float32/4/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.5,1.0},"rfftfreq/broadcast/float32/4/(1,): result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/broadcast/float32/4/(1,): result: shape")
eq(result.strides,{8},"rfftfreq/broadcast/float32/4/(1,): result: strides")
eq(result.dtype,"float64","rfftfreq/broadcast/float32/4/(1,): result: dtype")
eq(spacing:tolist(),{0.5},"rfftfreq/broadcast/float32/4/(1,): spacing state")
eq(spacing.shape,{1},"rfftfreq/broadcast/float32/4/(1,): spacing state: shape")
eq(spacing.strides,{4},"rfftfreq/broadcast/float32/4/(1,): spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/broadcast/float32/4/(1,): spacing state: dtype")
cases=cases+1
end
-- 795: rfftfreq/broadcast/float32/4/(3,)
do
local spacing=np.array({0.5,0.5,0.5},"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/broadcast/float32/4/(3,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.5,1.0},"rfftfreq/broadcast/float32/4/(3,): result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/broadcast/float32/4/(3,): result: shape")
eq(result.strides,{8},"rfftfreq/broadcast/float32/4/(3,): result: strides")
eq(result.dtype,"float64","rfftfreq/broadcast/float32/4/(3,): result: dtype")
eq(spacing:tolist(),{0.5,0.5,0.5},"rfftfreq/broadcast/float32/4/(3,): spacing state")
eq(spacing.shape,{3},"rfftfreq/broadcast/float32/4/(3,): spacing state: shape")
eq(spacing.strides,{4},"rfftfreq/broadcast/float32/4/(3,): spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/broadcast/float32/4/(3,): spacing state: dtype")
cases=cases+1
end
-- 796: rfftfreq/broadcast/float32/4/(2, 1)
do
local spacing=np.array({{0.5},{0.5}},"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/broadcast/float32/4/(2, 1): acceptance"..": "..tostring(result))
eq(result:tolist(),{{0.0,0.5,1.0},{0.0,0.5,1.0}},"rfftfreq/broadcast/float32/4/(2, 1): result",2e-12,2e-12)
eq(result.shape,{2,3},"rfftfreq/broadcast/float32/4/(2, 1): result: shape")
eq(result.strides,{24,8},"rfftfreq/broadcast/float32/4/(2, 1): result: strides")
eq(result.dtype,"float64","rfftfreq/broadcast/float32/4/(2, 1): result: dtype")
eq(spacing:tolist(),{{0.5},{0.5}},"rfftfreq/broadcast/float32/4/(2, 1): spacing state")
eq(spacing.shape,{2,1},"rfftfreq/broadcast/float32/4/(2, 1): spacing state: shape")
eq(spacing.strides,{4,4},"rfftfreq/broadcast/float32/4/(2, 1): spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/broadcast/float32/4/(2, 1): spacing state: dtype")
cases=cases+1
end
-- 797: rfftfreq/broadcast/float32/4/(2, 3)
do
local spacing=np.array({{0.5,0.5,0.5},{0.5,0.5,0.5}},"float32")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/broadcast/float32/4/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{{0.0,0.5,1.0},{0.0,0.5,1.0}},"rfftfreq/broadcast/float32/4/(2, 3): result",2e-12,2e-12)
eq(result.shape,{2,3},"rfftfreq/broadcast/float32/4/(2, 3): result: shape")
eq(result.strides,{24,8},"rfftfreq/broadcast/float32/4/(2, 3): result: strides")
eq(result.dtype,"float64","rfftfreq/broadcast/float32/4/(2, 3): result: dtype")
eq(spacing:tolist(),{{0.5,0.5,0.5},{0.5,0.5,0.5}},"rfftfreq/broadcast/float32/4/(2, 3): spacing state")
eq(spacing.shape,{2,3},"rfftfreq/broadcast/float32/4/(2, 3): spacing state: shape")
eq(spacing.strides,{12,4},"rfftfreq/broadcast/float32/4/(2, 3): spacing state: strides")
eq(spacing.dtype,"float32","rfftfreq/broadcast/float32/4/(2, 3): spacing state: dtype")
cases=cases+1
end
-- 798: rfftfreq/broadcast/float64/0/(1,)
do
local spacing=np.array({0.5},"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/broadcast/float64/0/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0)},"rfftfreq/broadcast/float64/0/(1,): result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/broadcast/float64/0/(1,): result: shape")
eq(result.strides,{8},"rfftfreq/broadcast/float64/0/(1,): result: strides")
eq(result.dtype,"float64","rfftfreq/broadcast/float64/0/(1,): result: dtype")
eq(spacing:tolist(),{0.5},"rfftfreq/broadcast/float64/0/(1,): spacing state")
eq(spacing.shape,{1},"rfftfreq/broadcast/float64/0/(1,): spacing state: shape")
eq(spacing.strides,{8},"rfftfreq/broadcast/float64/0/(1,): spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/broadcast/float64/0/(1,): spacing state: dtype")
cases=cases+1
end
-- 799: rfftfreq/broadcast/float64/0/(3,)
do
local spacing=np.array({0.5,0.5,0.5},"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/broadcast/float64/0/(3,): acceptance"..": "..tostring(result))
eq(result:tolist(),{(0/0),(0/0),(0/0)},"rfftfreq/broadcast/float64/0/(3,): result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/broadcast/float64/0/(3,): result: shape")
eq(result.strides,{8},"rfftfreq/broadcast/float64/0/(3,): result: strides")
eq(result.dtype,"float64","rfftfreq/broadcast/float64/0/(3,): result: dtype")
eq(spacing:tolist(),{0.5,0.5,0.5},"rfftfreq/broadcast/float64/0/(3,): spacing state")
eq(spacing.shape,{3},"rfftfreq/broadcast/float64/0/(3,): spacing state: shape")
eq(spacing.strides,{8},"rfftfreq/broadcast/float64/0/(3,): spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/broadcast/float64/0/(3,): spacing state: dtype")
cases=cases+1
end
-- 800: rfftfreq/broadcast/float64/0/(2, 1)
do
local spacing=np.array({{0.5},{0.5}},"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/broadcast/float64/0/(2, 1): acceptance"..": "..tostring(result))
eq(result:tolist(),{{(0/0)},{(0/0)}},"rfftfreq/broadcast/float64/0/(2, 1): result",2e-12,2e-12)
eq(result.shape,{2,1},"rfftfreq/broadcast/float64/0/(2, 1): result: shape")
eq(result.strides,{8,8},"rfftfreq/broadcast/float64/0/(2, 1): result: strides")
eq(result.dtype,"float64","rfftfreq/broadcast/float64/0/(2, 1): result: dtype")
eq(spacing:tolist(),{{0.5},{0.5}},"rfftfreq/broadcast/float64/0/(2, 1): spacing state")
eq(spacing.shape,{2,1},"rfftfreq/broadcast/float64/0/(2, 1): spacing state: shape")
eq(spacing.strides,{8,8},"rfftfreq/broadcast/float64/0/(2, 1): spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/broadcast/float64/0/(2, 1): spacing state: dtype")
cases=cases+1
end
-- 801: rfftfreq/broadcast/float64/0/(2, 3)
do
local spacing=np.array({{0.5,0.5,0.5},{0.5,0.5,0.5}},"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/broadcast/float64/0/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{{(0/0),(0/0),(0/0)},{(0/0),(0/0),(0/0)}},"rfftfreq/broadcast/float64/0/(2, 3): result",2e-12,2e-12)
eq(result.shape,{2,3},"rfftfreq/broadcast/float64/0/(2, 3): result: shape")
eq(result.strides,{24,8},"rfftfreq/broadcast/float64/0/(2, 3): result: strides")
eq(result.dtype,"float64","rfftfreq/broadcast/float64/0/(2, 3): result: dtype")
eq(spacing:tolist(),{{0.5,0.5,0.5},{0.5,0.5,0.5}},"rfftfreq/broadcast/float64/0/(2, 3): spacing state")
eq(spacing.shape,{2,3},"rfftfreq/broadcast/float64/0/(2, 3): spacing state: shape")
eq(spacing.strides,{24,8},"rfftfreq/broadcast/float64/0/(2, 3): spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/broadcast/float64/0/(2, 3): spacing state: dtype")
cases=cases+1
end
-- 802: rfftfreq/broadcast/float64/3/(1,)
do
local spacing=np.array({0.5},"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/broadcast/float64/3/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.6666666666666666},"rfftfreq/broadcast/float64/3/(1,): result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/broadcast/float64/3/(1,): result: shape")
eq(result.strides,{8},"rfftfreq/broadcast/float64/3/(1,): result: strides")
eq(result.dtype,"float64","rfftfreq/broadcast/float64/3/(1,): result: dtype")
eq(spacing:tolist(),{0.5},"rfftfreq/broadcast/float64/3/(1,): spacing state")
eq(spacing.shape,{1},"rfftfreq/broadcast/float64/3/(1,): spacing state: shape")
eq(spacing.strides,{8},"rfftfreq/broadcast/float64/3/(1,): spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/broadcast/float64/3/(1,): spacing state: dtype")
cases=cases+1
end
-- 803: rfftfreq/broadcast/float64/3/(3,)
do
local spacing=np.array({0.5,0.5,0.5},"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==false,"rfftfreq/broadcast/float64/3/(3,): acceptance"..": "..tostring(result))
eq(spacing:tolist(),{0.5,0.5,0.5},"rfftfreq/broadcast/float64/3/(3,): spacing state")
eq(spacing.shape,{3},"rfftfreq/broadcast/float64/3/(3,): spacing state: shape")
eq(spacing.strides,{8},"rfftfreq/broadcast/float64/3/(3,): spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/broadcast/float64/3/(3,): spacing state: dtype")
cases=cases+1
end
-- 804: rfftfreq/broadcast/float64/3/(2, 1)
do
local spacing=np.array({{0.5},{0.5}},"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/broadcast/float64/3/(2, 1): acceptance"..": "..tostring(result))
eq(result:tolist(),{{0.0,0.6666666666666666},{0.0,0.6666666666666666}},"rfftfreq/broadcast/float64/3/(2, 1): result",2e-12,2e-12)
eq(result.shape,{2,2},"rfftfreq/broadcast/float64/3/(2, 1): result: shape")
eq(result.strides,{16,8},"rfftfreq/broadcast/float64/3/(2, 1): result: strides")
eq(result.dtype,"float64","rfftfreq/broadcast/float64/3/(2, 1): result: dtype")
eq(spacing:tolist(),{{0.5},{0.5}},"rfftfreq/broadcast/float64/3/(2, 1): spacing state")
eq(spacing.shape,{2,1},"rfftfreq/broadcast/float64/3/(2, 1): spacing state: shape")
eq(spacing.strides,{8,8},"rfftfreq/broadcast/float64/3/(2, 1): spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/broadcast/float64/3/(2, 1): spacing state: dtype")
cases=cases+1
end
-- 805: rfftfreq/broadcast/float64/3/(2, 3)
do
local spacing=np.array({{0.5,0.5,0.5},{0.5,0.5,0.5}},"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==false,"rfftfreq/broadcast/float64/3/(2, 3): acceptance"..": "..tostring(result))
eq(spacing:tolist(),{{0.5,0.5,0.5},{0.5,0.5,0.5}},"rfftfreq/broadcast/float64/3/(2, 3): spacing state")
eq(spacing.shape,{2,3},"rfftfreq/broadcast/float64/3/(2, 3): spacing state: shape")
eq(spacing.strides,{24,8},"rfftfreq/broadcast/float64/3/(2, 3): spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/broadcast/float64/3/(2, 3): spacing state: dtype")
cases=cases+1
end
-- 806: rfftfreq/broadcast/float64/4/(1,)
do
local spacing=np.array({0.5},"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/broadcast/float64/4/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.5,1.0},"rfftfreq/broadcast/float64/4/(1,): result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/broadcast/float64/4/(1,): result: shape")
eq(result.strides,{8},"rfftfreq/broadcast/float64/4/(1,): result: strides")
eq(result.dtype,"float64","rfftfreq/broadcast/float64/4/(1,): result: dtype")
eq(spacing:tolist(),{0.5},"rfftfreq/broadcast/float64/4/(1,): spacing state")
eq(spacing.shape,{1},"rfftfreq/broadcast/float64/4/(1,): spacing state: shape")
eq(spacing.strides,{8},"rfftfreq/broadcast/float64/4/(1,): spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/broadcast/float64/4/(1,): spacing state: dtype")
cases=cases+1
end
-- 807: rfftfreq/broadcast/float64/4/(3,)
do
local spacing=np.array({0.5,0.5,0.5},"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/broadcast/float64/4/(3,): acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0,0.5,1.0},"rfftfreq/broadcast/float64/4/(3,): result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/broadcast/float64/4/(3,): result: shape")
eq(result.strides,{8},"rfftfreq/broadcast/float64/4/(3,): result: strides")
eq(result.dtype,"float64","rfftfreq/broadcast/float64/4/(3,): result: dtype")
eq(spacing:tolist(),{0.5,0.5,0.5},"rfftfreq/broadcast/float64/4/(3,): spacing state")
eq(spacing.shape,{3},"rfftfreq/broadcast/float64/4/(3,): spacing state: shape")
eq(spacing.strides,{8},"rfftfreq/broadcast/float64/4/(3,): spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/broadcast/float64/4/(3,): spacing state: dtype")
cases=cases+1
end
-- 808: rfftfreq/broadcast/float64/4/(2, 1)
do
local spacing=np.array({{0.5},{0.5}},"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/broadcast/float64/4/(2, 1): acceptance"..": "..tostring(result))
eq(result:tolist(),{{0.0,0.5,1.0},{0.0,0.5,1.0}},"rfftfreq/broadcast/float64/4/(2, 1): result",2e-12,2e-12)
eq(result.shape,{2,3},"rfftfreq/broadcast/float64/4/(2, 1): result: shape")
eq(result.strides,{24,8},"rfftfreq/broadcast/float64/4/(2, 1): result: strides")
eq(result.dtype,"float64","rfftfreq/broadcast/float64/4/(2, 1): result: dtype")
eq(spacing:tolist(),{{0.5},{0.5}},"rfftfreq/broadcast/float64/4/(2, 1): spacing state")
eq(spacing.shape,{2,1},"rfftfreq/broadcast/float64/4/(2, 1): spacing state: shape")
eq(spacing.strides,{8,8},"rfftfreq/broadcast/float64/4/(2, 1): spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/broadcast/float64/4/(2, 1): spacing state: dtype")
cases=cases+1
end
-- 809: rfftfreq/broadcast/float64/4/(2, 3)
do
local spacing=np.array({{0.5,0.5,0.5},{0.5,0.5,0.5}},"float64")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/broadcast/float64/4/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{{0.0,0.5,1.0},{0.0,0.5,1.0}},"rfftfreq/broadcast/float64/4/(2, 3): result",2e-12,2e-12)
eq(result.shape,{2,3},"rfftfreq/broadcast/float64/4/(2, 3): result: shape")
eq(result.strides,{24,8},"rfftfreq/broadcast/float64/4/(2, 3): result: strides")
eq(result.dtype,"float64","rfftfreq/broadcast/float64/4/(2, 3): result: dtype")
eq(spacing:tolist(),{{0.5,0.5,0.5},{0.5,0.5,0.5}},"rfftfreq/broadcast/float64/4/(2, 3): spacing state")
eq(spacing.shape,{2,3},"rfftfreq/broadcast/float64/4/(2, 3): spacing state: shape")
eq(spacing.strides,{24,8},"rfftfreq/broadcast/float64/4/(2, 3): spacing state: strides")
eq(spacing.dtype,"float64","rfftfreq/broadcast/float64/4/(2, 3): spacing state: dtype")
cases=cases+1
end
-- 810: rfftfreq/broadcast/complex64/0/(1,)
do
local spacing=np.array({np.complex(0.5,0.0)},"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/broadcast/complex64/0/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0))},"rfftfreq/broadcast/complex64/0/(1,): result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/broadcast/complex64/0/(1,): result: shape")
eq(result.strides,{16},"rfftfreq/broadcast/complex64/0/(1,): result: strides")
eq(result.dtype,"complex128","rfftfreq/broadcast/complex64/0/(1,): result: dtype")
eq(spacing:tolist(),{np.complex(0.5,0.0)},"rfftfreq/broadcast/complex64/0/(1,): spacing state")
eq(spacing.shape,{1},"rfftfreq/broadcast/complex64/0/(1,): spacing state: shape")
eq(spacing.strides,{8},"rfftfreq/broadcast/complex64/0/(1,): spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/broadcast/complex64/0/(1,): spacing state: dtype")
cases=cases+1
end
-- 811: rfftfreq/broadcast/complex64/0/(3,)
do
local spacing=np.array({np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/broadcast/complex64/0/(3,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},"rfftfreq/broadcast/complex64/0/(3,): result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/broadcast/complex64/0/(3,): result: shape")
eq(result.strides,{16},"rfftfreq/broadcast/complex64/0/(3,): result: strides")
eq(result.dtype,"complex128","rfftfreq/broadcast/complex64/0/(3,): result: dtype")
eq(spacing:tolist(),{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},"rfftfreq/broadcast/complex64/0/(3,): spacing state")
eq(spacing.shape,{3},"rfftfreq/broadcast/complex64/0/(3,): spacing state: shape")
eq(spacing.strides,{8},"rfftfreq/broadcast/complex64/0/(3,): spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/broadcast/complex64/0/(3,): spacing state: dtype")
cases=cases+1
end
-- 812: rfftfreq/broadcast/complex64/0/(2, 1)
do
local spacing=np.array({{np.complex(0.5,0.0)},{np.complex(0.5,0.0)}},"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/broadcast/complex64/0/(2, 1): acceptance"..": "..tostring(result))
eq(result:tolist(),{{np.complex((0/0),(0/0))},{np.complex((0/0),(0/0))}},"rfftfreq/broadcast/complex64/0/(2, 1): result",2e-12,2e-12)
eq(result.shape,{2,1},"rfftfreq/broadcast/complex64/0/(2, 1): result: shape")
eq(result.strides,{16,16},"rfftfreq/broadcast/complex64/0/(2, 1): result: strides")
eq(result.dtype,"complex128","rfftfreq/broadcast/complex64/0/(2, 1): result: dtype")
eq(spacing:tolist(),{{np.complex(0.5,0.0)},{np.complex(0.5,0.0)}},"rfftfreq/broadcast/complex64/0/(2, 1): spacing state")
eq(spacing.shape,{2,1},"rfftfreq/broadcast/complex64/0/(2, 1): spacing state: shape")
eq(spacing.strides,{8,8},"rfftfreq/broadcast/complex64/0/(2, 1): spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/broadcast/complex64/0/(2, 1): spacing state: dtype")
cases=cases+1
end
-- 813: rfftfreq/broadcast/complex64/0/(2, 3)
do
local spacing=np.array({{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)}},"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(0,spacing) end)
assert(ok==true,"rfftfreq/broadcast/complex64/0/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))},{np.complex((0/0),(0/0)),np.complex((0/0),(0/0)),np.complex((0/0),(0/0))}},"rfftfreq/broadcast/complex64/0/(2, 3): result",2e-12,2e-12)
eq(result.shape,{2,3},"rfftfreq/broadcast/complex64/0/(2, 3): result: shape")
eq(result.strides,{48,16},"rfftfreq/broadcast/complex64/0/(2, 3): result: strides")
eq(result.dtype,"complex128","rfftfreq/broadcast/complex64/0/(2, 3): result: dtype")
eq(spacing:tolist(),{{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)}},"rfftfreq/broadcast/complex64/0/(2, 3): spacing state")
eq(spacing.shape,{2,3},"rfftfreq/broadcast/complex64/0/(2, 3): spacing state: shape")
eq(spacing.strides,{24,8},"rfftfreq/broadcast/complex64/0/(2, 3): spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/broadcast/complex64/0/(2, 3): spacing state: dtype")
cases=cases+1
end
-- 814: rfftfreq/broadcast/complex64/3/(1,)
do
local spacing=np.array({np.complex(0.5,0.0)},"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/broadcast/complex64/3/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.6666666865348816,0.0)},"rfftfreq/broadcast/complex64/3/(1,): result",2e-12,2e-12)
eq(result.shape,{2},"rfftfreq/broadcast/complex64/3/(1,): result: shape")
eq(result.strides,{16},"rfftfreq/broadcast/complex64/3/(1,): result: strides")
eq(result.dtype,"complex128","rfftfreq/broadcast/complex64/3/(1,): result: dtype")
eq(spacing:tolist(),{np.complex(0.5,0.0)},"rfftfreq/broadcast/complex64/3/(1,): spacing state")
eq(spacing.shape,{1},"rfftfreq/broadcast/complex64/3/(1,): spacing state: shape")
eq(spacing.strides,{8},"rfftfreq/broadcast/complex64/3/(1,): spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/broadcast/complex64/3/(1,): spacing state: dtype")
cases=cases+1
end
-- 815: rfftfreq/broadcast/complex64/3/(3,)
do
local spacing=np.array({np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==false,"rfftfreq/broadcast/complex64/3/(3,): acceptance"..": "..tostring(result))
eq(spacing:tolist(),{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},"rfftfreq/broadcast/complex64/3/(3,): spacing state")
eq(spacing.shape,{3},"rfftfreq/broadcast/complex64/3/(3,): spacing state: shape")
eq(spacing.strides,{8},"rfftfreq/broadcast/complex64/3/(3,): spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/broadcast/complex64/3/(3,): spacing state: dtype")
cases=cases+1
end
-- 816: rfftfreq/broadcast/complex64/3/(2, 1)
do
local spacing=np.array({{np.complex(0.5,0.0)},{np.complex(0.5,0.0)}},"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==true,"rfftfreq/broadcast/complex64/3/(2, 1): acceptance"..": "..tostring(result))
eq(result:tolist(),{{np.complex(0.0,0.0),np.complex(0.6666666865348816,0.0)},{np.complex(0.0,0.0),np.complex(0.6666666865348816,0.0)}},"rfftfreq/broadcast/complex64/3/(2, 1): result",2e-12,2e-12)
eq(result.shape,{2,2},"rfftfreq/broadcast/complex64/3/(2, 1): result: shape")
eq(result.strides,{32,16},"rfftfreq/broadcast/complex64/3/(2, 1): result: strides")
eq(result.dtype,"complex128","rfftfreq/broadcast/complex64/3/(2, 1): result: dtype")
eq(spacing:tolist(),{{np.complex(0.5,0.0)},{np.complex(0.5,0.0)}},"rfftfreq/broadcast/complex64/3/(2, 1): spacing state")
eq(spacing.shape,{2,1},"rfftfreq/broadcast/complex64/3/(2, 1): spacing state: shape")
eq(spacing.strides,{8,8},"rfftfreq/broadcast/complex64/3/(2, 1): spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/broadcast/complex64/3/(2, 1): spacing state: dtype")
cases=cases+1
end
-- 817: rfftfreq/broadcast/complex64/3/(2, 3)
do
local spacing=np.array({{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)}},"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(3,spacing) end)
assert(ok==false,"rfftfreq/broadcast/complex64/3/(2, 3): acceptance"..": "..tostring(result))
eq(spacing:tolist(),{{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)}},"rfftfreq/broadcast/complex64/3/(2, 3): spacing state")
eq(spacing.shape,{2,3},"rfftfreq/broadcast/complex64/3/(2, 3): spacing state: shape")
eq(spacing.strides,{24,8},"rfftfreq/broadcast/complex64/3/(2, 3): spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/broadcast/complex64/3/(2, 3): spacing state: dtype")
cases=cases+1
end
-- 818: rfftfreq/broadcast/complex64/4/(1,)
do
local spacing=np.array({np.complex(0.5,0.0)},"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/broadcast/complex64/4/(1,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.5,0.0),np.complex(1.0,0.0)},"rfftfreq/broadcast/complex64/4/(1,): result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/broadcast/complex64/4/(1,): result: shape")
eq(result.strides,{16},"rfftfreq/broadcast/complex64/4/(1,): result: strides")
eq(result.dtype,"complex128","rfftfreq/broadcast/complex64/4/(1,): result: dtype")
eq(spacing:tolist(),{np.complex(0.5,0.0)},"rfftfreq/broadcast/complex64/4/(1,): spacing state")
eq(spacing.shape,{1},"rfftfreq/broadcast/complex64/4/(1,): spacing state: shape")
eq(spacing.strides,{8},"rfftfreq/broadcast/complex64/4/(1,): spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/broadcast/complex64/4/(1,): spacing state: dtype")
cases=cases+1
end
-- 819: rfftfreq/broadcast/complex64/4/(3,)
do
local spacing=np.array({np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/broadcast/complex64/4/(3,): acceptance"..": "..tostring(result))
eq(result:tolist(),{np.complex(0.0,0.0),np.complex(0.5,0.0),np.complex(1.0,0.0)},"rfftfreq/broadcast/complex64/4/(3,): result",2e-12,2e-12)
eq(result.shape,{3},"rfftfreq/broadcast/complex64/4/(3,): result: shape")
eq(result.strides,{16},"rfftfreq/broadcast/complex64/4/(3,): result: strides")
eq(result.dtype,"complex128","rfftfreq/broadcast/complex64/4/(3,): result: dtype")
eq(spacing:tolist(),{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},"rfftfreq/broadcast/complex64/4/(3,): spacing state")
eq(spacing.shape,{3},"rfftfreq/broadcast/complex64/4/(3,): spacing state: shape")
eq(spacing.strides,{8},"rfftfreq/broadcast/complex64/4/(3,): spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/broadcast/complex64/4/(3,): spacing state: dtype")
cases=cases+1
end
-- 820: rfftfreq/broadcast/complex64/4/(2, 1)
do
local spacing=np.array({{np.complex(0.5,0.0)},{np.complex(0.5,0.0)}},"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/broadcast/complex64/4/(2, 1): acceptance"..": "..tostring(result))
eq(result:tolist(),{{np.complex(0.0,0.0),np.complex(0.5,0.0),np.complex(1.0,0.0)},{np.complex(0.0,0.0),np.complex(0.5,0.0),np.complex(1.0,0.0)}},"rfftfreq/broadcast/complex64/4/(2, 1): result",2e-12,2e-12)
eq(result.shape,{2,3},"rfftfreq/broadcast/complex64/4/(2, 1): result: shape")
eq(result.strides,{48,16},"rfftfreq/broadcast/complex64/4/(2, 1): result: strides")
eq(result.dtype,"complex128","rfftfreq/broadcast/complex64/4/(2, 1): result: dtype")
eq(spacing:tolist(),{{np.complex(0.5,0.0)},{np.complex(0.5,0.0)}},"rfftfreq/broadcast/complex64/4/(2, 1): spacing state")
eq(spacing.shape,{2,1},"rfftfreq/broadcast/complex64/4/(2, 1): spacing state: shape")
eq(spacing.strides,{8,8},"rfftfreq/broadcast/complex64/4/(2, 1): spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/broadcast/complex64/4/(2, 1): spacing state: dtype")
cases=cases+1
end
-- 821: rfftfreq/broadcast/complex64/4/(2, 3)
do
local spacing=np.array({{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)}},"complex64")
local ok,result=pcall(function() return np.fft.rfftfreq(4,spacing) end)
assert(ok==true,"rfftfreq/broadcast/complex64/4/(2, 3): acceptance"..": "..tostring(result))
eq(result:tolist(),{{np.complex(0.0,0.0),np.complex(0.5,0.0),np.complex(1.0,0.0)},{np.complex(0.0,0.0),np.complex(0.5,0.0),np.complex(1.0,0.0)}},"rfftfreq/broadcast/complex64/4/(2, 3): result",2e-12,2e-12)
eq(result.shape,{2,3},"rfftfreq/broadcast/complex64/4/(2, 3): result: shape")
eq(result.strides,{48,16},"rfftfreq/broadcast/complex64/4/(2, 3): result: strides")
eq(result.dtype,"complex128","rfftfreq/broadcast/complex64/4/(2, 3): result: dtype")
eq(spacing:tolist(),{{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)},{np.complex(0.5,0.0),np.complex(0.5,0.0),np.complex(0.5,0.0)}},"rfftfreq/broadcast/complex64/4/(2, 3): spacing state")
eq(spacing.shape,{2,3},"rfftfreq/broadcast/complex64/4/(2, 3): spacing state: shape")
eq(spacing.strides,{24,8},"rfftfreq/broadcast/complex64/4/(2, 3): spacing state: strides")
eq(spacing.dtype,"complex64","rfftfreq/broadcast/complex64/4/(2, 3): spacing state: dtype")
cases=cases+1
end
-- 822: rfftfreq/2.0/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.rfftfreq(2.0,spacing) end)
assert(ok==false,"rfftfreq/2.0/1.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 823: rfftfreq/2.5/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.rfftfreq(2.5,spacing) end)
assert(ok==false,"rfftfreq/2.5/1.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 824: rfftfreq/4/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.rfftfreq("4",spacing) end)
assert(ok==false,"rfftfreq/4/1.0: acceptance"..": "..tostring(result))
cases=cases+1
end
-- 825: rfftfreq/True/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.rfftfreq(true,spacing) end)
assert(ok==true,"rfftfreq/True/1.0: acceptance"..": "..tostring(result))
eq(result:tolist(),{0.0},"rfftfreq/True/1.0: result",2e-12,2e-12)
eq(result.shape,{1},"rfftfreq/True/1.0: result: shape")
eq(result.strides,{8},"rfftfreq/True/1.0: result: strides")
eq(result.dtype,"float64","rfftfreq/True/1.0: result: dtype")
cases=cases+1
end
-- 826: rfftfreq/False/1.0
do
local spacing=1.0
local ok,result=pcall(function() return np.fft.rfftfreq(false,spacing) end)
assert(ok==false,"rfftfreq/False/1.0: acceptance"..": "..tostring(result))
cases=cases+1
end
end
chunk()
end
assert(cases==826)
print('fft_frequency105 differential: '..cases..' cases, '..checks..' checks passed; max absolute error '..max_error)
