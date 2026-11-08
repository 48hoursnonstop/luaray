local np=require('luaray_core')
local rng=np.random.default_rng(42)
local lower={{1},{10}}
local upper={{15,20,50}}
local values=rng:integers(lower,upper,nil,'int16')
assert(values.dtype=='int16')
assert(values.shape[1]==2 and values.shape[2]==3)
for i=1,values.shape[1] do
 for j=1,values.shape[2] do
  assert(values:get(i,j)>=lower[i][1] and values:get(i,j)<upper[1][j])
 end
end
local more=rng:integers(np.flip(np.array({1,3,5},'int64'),1),10,{2,3},'uint8')
assert(more.shape[1]==2 and more.shape[2]==3)
print('random89 example: integer broadcast, int16/uint8, PCG64 PASS')
