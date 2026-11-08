local np=require('luaray_core')
local rng=np.random.default_rng(42)
local shapes={{0.5},{2.0}}
local scales={{0.2,1.0,2.0}}
local values=rng:gamma(shapes,scales)
assert(values.shape[1]==2 and values.shape[2]==3)
print('Gamma shape=(2,3)')
for _,row in ipairs(values:tolist()) do print(table.concat(row,', ')) end
local beta=rng:beta({{0.5},{2.0}},{{1.0,3.0}})
assert(beta.shape[1]==2 and beta.shape[2]==2)
print('Beta shape=(2,2)')
for _,row in ipairs(beta:tolist()) do print(table.concat(row,', ')) end
local chisq=rng:chisquare({1,2,3})
assert(chisq.shape[1]==3)
print('Chi-square:',table.concat(chisq:tolist(),', '))
local ratio=rng:f({{1},{3}},{{2,4,6}})
assert(ratio.shape[1]==2 and ratio.shape[2]==3)
print('F shape=(2,3)')
