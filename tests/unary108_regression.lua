local np=require('luaray_core')
local checks=0
local function check(value)checks=checks+1;assert(value)end
local function rejects(fn)check(not pcall(fn))end
for _,name in ipairs({'floor','ceil','trunc','rint','fabs','conjugate','conj','square','reciprocal','degrees','rad2deg','radians','deg2rad'})do
 local a=np.array({-2.5,-0.0,0.5,2.5},'float32')
 local out=np.full({4},9,'float64')
 check(rawequal(np[name](a,{out=out,where=false}),out))
 for _,v in ipairs(out:tolist())do check(v==9)end
 check(rawequal(np[name](a,out,false),out))
 for _,v in ipairs(out:tolist())do check(v==9)end
 check(np[name]({-1,0,1}).ndim==1)
 check(np[name](2).ndim==0)
 check(np[name](np.array(2,'int8')).ndim==0)
 rejects(function()np[name]()end)
 rejects(function()np[name](a,{out=3})end)
 rejects(function()np[name](a,{out=np.empty({3})})end)
 rejects(function()np[name](a,{out=np.broadcast_to(np.array(0.0),{4})})end)
 rejects(function()np[name](a,{where=np.array({true,false,true})})end)
 rejects(function()np[name](np.array({1},'datetime64[D]'))end)
 rejects(function()np[name](np.array({1},'timedelta64[h]'))end)
end
for _,name in ipairs({'negative','absolute','positive','sign','logical_not','isnan','isinf','isfinite','signbit',
 'sqrt','exp','log','sin','cos','tan','sinh','cosh','tanh','exp2','log2','log10','expm1','log1p','cbrt',
 'arcsin','arccos','arctan','arcsinh','arccosh','arctanh'})do
 -- The shared entry point now coerces scalars/tables before evaluation.
 local raw=np[name](0.5);local typed=np[name](np.array(0.5))
 check(raw.dtype==typed.dtype and raw.ndim==0)
 local r,t=raw:tolist(),typed:tolist()
 check(r==t or r~=r and t~=t)
 check(np[name]({0.5,1}).ndim==1)
end
check(np.rint(np.array({-.5,.5,1.5,2.5})):tolist()[3]==2)
check(1/np.rint(-.5):tolist()==-math.huge)
check(np.floor(np.array({1,2},'int16')).dtype=='int16')
check(np.square(np.array({true,false},'bool')).dtype=='int8')
check(np.conjugate(np.array({true},'bool')).dtype=='int8')
check(np.reciprocal(np.array({0},'int32')):tolist()[1]==-2147483648)
check(np.reciprocal(np.array({0},'int8')):tolist()[1]==0)
local z=np.conj(np.complex(1,-0.0)):tolist();check(z.real==1 and 1/z.imag==math.huge)
collectgarbage('collect')
print('unary108 regression: '..checks..' checks passed')
