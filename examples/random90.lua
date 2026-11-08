local np=require('luaray_core')
local rng=np.random.default_rng(42)
local low={9007199254740993,9007199254741001}
local high={9007199254740998,9007199254741091}
local draws=rng:integers(low,high,{2,2},'int64')
assert(draws.dtype=='int64' and draws.shape[1]==2 and draws.shape[2]==2)
print('Generator.integers with lossless int64 table bounds:')
for _,row in ipairs(draws:tolist()) do print(table.concat(row,', ')) end
