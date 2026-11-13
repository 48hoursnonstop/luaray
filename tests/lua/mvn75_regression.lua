local np=require('luaray_core')
assert(np._version=='0.145.0-dev')
local function bad(f)
  local ok,e=pcall(f)
  assert(not ok,'expected a rejection but operation succeeded')
end
local function close(a,b,tol)
  tol=tol or 1e-12
  if type(a)=='table' then
    assert(type(b)=='table' and #a==#b)
    for i=1,#a do close(a[i],b[i],tol) end
  else
    assert(math.abs(a-b)<=tol*math.max(1,math.abs(a),math.abs(b)),tostring(a)..' ~= '..tostring(b))
  end
end
-- Deterministic high-precision sample, independently obtained from NumPy 2.3.5.
local targets={
  svd={0.09045733201414219,0.47899093961360173},
  eigh={0.24785246546525874,-2.1015102434687107},
  cholesky={1.6809350268754408,-2.1909386143828113}
}
for _,method in ipairs({'svd','eigh','cholesky'}) do
  local g=np.random.default_rng(42)
  local a=g:multivariate_normal({1.25,-0.5},{{2,0.4},{0.4,3}},{2,3},'raise',1e-8,method)
  assert(a.dtype=='float64' and a.ndim==3)
  close(a.shape,{2,3,2})
  close(a:tolist()[1][1],targets[method])
  assert(g:raw_hex()=='a4d45831c814ce06')
end
local g=np.random.default_rng(17)
local shape0=g:multivariate_normal({3,4},{{1,0},{0,1}}, {})
close(shape0.shape,{2})
local zero=g:multivariate_normal({3,4},{{1,0},{0,1}}, {0,2})
close(zero.shape,{0,2,2})
local no_cov=np.array({{0,0},{0,0}})
local deg=g:multivariate_normal({3,4},no_cov,4)
for _,v in ipairs(deg:tolist())do close(v,{3,4})end
local deg2=g:multivariate_normal({3,4},no_cov,4,'raise',1e-8,'eigh')
for _,v in ipairs(deg2:tolist())do close(v,{3,4})end
local m=np.flip(np.array({3,4}),1)
local c=np.flip(np.flip(np.array({{1,0.2},{0.2,3}}),1),2)
local good=g:multivariate_normal(m,c,{2},'raise',1e-8,'cholesky')
close(good.shape,{2,2})
-- A non-PSD matrix must be rejected when check_valid=raise, and cholesky
-- rejects it regardless of check_valid. Eigh(ignore) takes sqrt(abs(eig)).
local invalid={{1,2},{2,1}}
bad(function()g:multivariate_normal({0,0},invalid,nil,'raise')end)
bad(function()g:multivariate_normal({0,0},invalid,nil,'raise',1e-8,'eigh')end)
bad(function()g:multivariate_normal({0,0},invalid,nil,'ignore',1e-8,'cholesky')end)
assert(g:multivariate_normal({0,0},invalid,nil,'ignore',1e-8,'eigh').size==2)
assert(g:multivariate_normal({0,0},invalid,nil,'ignore',1e-8,'svd').size==2)
-- NumPy draws Z before factorization. Even a covariance rejection advances PCG64.
local ga=np.random.default_rng(101)
local gb=np.random.default_rng(101)
bad(function()ga:multivariate_normal({0,0},invalid,3,'raise',1e-8,'eigh')end)
gb:standard_normal({3,2})
assert(ga:raw_hex()==gb:raw_hex())
-- Shape validation occurs before drawing.
local validators={
 function()g:multivariate_normal({{1,2}},{{1,0},{0,1}})end,
 function()g:multivariate_normal({1,2},{1,2})end,
 function()g:multivariate_normal({1},{{1,0},{0,1}})end,
 function()g:multivariate_normal({1,2},{{1,0},{0,1}},-1)end,
 function()g:multivariate_normal({1,2},{{1,0},{0,1}},1,'bad')end,
 function()g:multivariate_normal({1,2},{{1,0},{0,1}},1,'warn',1e-8,'invalid')end,
 function()g:multivariate_normal({'x','y'},{{1,0},{0,1}})end,
 function()g:multivariate_normal({1,2},{{1,0},{0,1}},3.5)end,
 function()g:multivariate_normal({1,2},{{1,0},{0,1}},nil,nil,nil,nil,'extra')end,
 function()g:multivariate_normal({},np.array({}))end,
}
for _,validator in ipairs(validators)do bad(validator)end
-- Moments from 30,000 real generated bivariate samples.
local count=30000
local samples=np.random.default_rng(514):multivariate_normal({1,-2},{{2,0.6},{0.6,3}},count,nil,nil,'cholesky'):tolist()
local s1,s2,s11,s22,s12=0,0,0,0,0
for _,v in ipairs(samples)do
 local x,y=v[1],v[2];s1=s1+x;s2=s2+y;s11=s11+x*x;s22=s22+y*y;s12=s12+x*y
end
local a,b=s1/count,s2/count
assert(math.abs(a-1)<0.05 and math.abs(b+2)<0.05)
assert(math.abs(s11/count-a*a-2)<0.09)
assert(math.abs(s22/count-b*b-3)<0.10)
assert(math.abs(s12/count-a*b-0.6)<0.09)
print('mvn75 native Lua regression, validation, PCG64 and 30000 statistical samples passed')
