local np=require('luaray_core')
assert(np._version=='0.109.0-dev')
for _,method in ipairs({'count','marginals'}) do
 local r=np.random.default_rng(42)
 local colors={15,15,10}
 local a=r:multivariate_hypergeometric(colors,12,{2,3},method)
 assert(a.dtype=='int64' and #a.shape==3 and a.shape[1]==2 and a.shape[2]==3 and a.shape[3]==3)
 for i=1,2 do for j=1,3 do
  local s=0
  for k=1,3 do local v=a:get(i,j,k);assert(v>=0 and v<=colors[k]);s=s+v end
  assert(s==12)
 end end
 local b=r:multivariate_hypergeometric(np.array({1,0,0},'int64'),1)
 assert(b.shape[1]==3 and b:get(1)==1 and b:get(2)==0 and b:get(3)==0)
end
local r=np.random.default_rng(123)
assert(r:multivariate_hypergeometric({},0).shape[1]==0)
assert(r:multivariate_hypergeometric({0,0},0,{0}).shape[1]==0)
local zero=r:multivariate_hypergeometric({0,0},0,{2,1},'count')
assert(zero:get(1,1,1)==0 and zero:get(2,1,2)==0)
for _,method in ipairs({'count','marginals'}) do
 local empty=r:multivariate_hypergeometric({1,2,3},1,{0},method)
 assert(empty.shape[1]==0 and empty.shape[2]==3)
end
print('distributions67 regression passed')
