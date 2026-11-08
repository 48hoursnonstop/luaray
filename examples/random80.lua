local np=require('luaray_core')
local rng=np.random.default_rng(42)
local shapes={{0.5},{2.0}}
local samples=rng:standard_gamma(shapes,{2,3},'float32')
assert(samples.dtype=='float32')
assert(samples.shape[1]==2 and samples.shape[2]==3)
print('standard_gamma float32 broadcasting:')
for _,row in ipairs(samples:tolist()) do print(table.concat(row,', ')) end
local next_double=rng:random()
print('Next PCG64 sample:',next_double)
