local np=require('luaray_core')
assert(np._version=='0.135.0-dev')
for _,dtype in ipairs({'float32','float64'}) do
  local rng=np.random.default_rng(202680)
  local n=20000
  local s=rng:standard_gamma({1.0,2.0,5.0},{n,3},dtype):tolist()
  local sum={0,0,0}
  local squared={0,0,0}
  for i=1,n do
    for j=1,3 do
      local x=s[i][j]
      assert(x>=0 and x==x, 'invalid gamma sample')
      sum[j]=sum[j]+x
      squared[j]=squared[j]+x*x
    end
  end
  for j=1,3 do
    local expected=({1,2,5})[j]
    local mean=sum[j]/n
    local variance=squared[j]/n-mean*mean
    assert(math.abs(mean-expected)<0.13, 'gamma mean '..dtype..' '..j..'='..mean)
    assert(math.abs(variance-expected)<0.38, 'gamma variance '..dtype..' '..j..'='..variance)
  end
end
print('random80 statistical passed: 120000 samples')
