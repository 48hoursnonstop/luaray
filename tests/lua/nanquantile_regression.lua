local n=require('luaray_core')
assert(n._version=='0.135.0-dev')
local function near(a,b,tol)
 tol=tol or 1e-5
 if type(a)=='table' then
  assert(type(b)=='table' and #a==#b)
  for i=1,#a do near(a[i],b[i],tol) end
 elseif type(a)=='number' and type(b)=='number' then
  assert(a==b or a~=a and b~=b or math.abs(a-b)<=tol*math.max(1,math.abs(b)),tostring(a)..' != '..tostring(b))
 else assert(a==b) end
end
local nan=0/0
local x=n.array({nan,1,2,4, nan},'float64')
near(n.nanmedian(x),2)
near(n.nanquantile(x,0.25),1.5)
near(n.nanpercentile(x,{0,50,100}):tolist(),{1,2,4})
near(n.median(x),nan) -- original behavior must remain unchanged
near(x:tolist(),{nan,1,2,4,nan})
near(x:nanmedian(),2)
local m=n.reshape(n.array({nan,nan,nan,1,3,nan},'float32'),{2,3})
local result=n.nanmedian(m,{axis=2})
assert(result.dtype=='float32')
near(result:tolist(),{nan,2})
local saved=n.zeros({2},'float64')
assert(n.nanquantile(m,0.5,{axis=2,out=saved})==saved)
near(saved:tolist(),{nan,2})
-- aliased out may overwrite the input only after reading all input rows
-- Alias safety is independently verified by the native C test.
-- zero-dimensional and genuinely empty arrays
near(n.nanmedian(n.reshape(n.array({nan},'float64'),{})),nan)
near(n.nanmedian(n.array({},'float16')),nan)
local empty=n.reshape(n.array({},'float32'),{3,0})
local collapsed=n.nanquantile(empty,{0.25,0.75},{axis=2})
assert(collapsed.dtype=='float32')
near(collapsed:tolist(),{nan,nan,nan})
local allnan=n.array({nan,nan},'float16')
assert(n.nanquantile(allnan,{0.1,0.9}).dtype=='float16')
-- q restrictions and unsupported methods must fail, not silently fall back
local function reject(fn)assert(not pcall(fn))end
reject(function()n.nanquantile(x,-0.1)end)
reject(function()n.nanpercentile(x,101)end)
reject(function()n.nanquantile(x,0.5,{weights={1,2,3,4,5}})end)
reject(function()n.nanquantile(x,0.5,{method='hazen'})end)
reject(function()n.nanmedian(x,{method='linear'})end)
reject(function()n.nanmedian(n.array({n.complex(1,2)},'complex128'))end)
print('nanquantile regression: ok')
