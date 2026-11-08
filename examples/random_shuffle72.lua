local np=require("luaray_core")
local rng=np.random.default_rng(42)
local indices=rng:permutation(10)
print('random permutation:', table.concat(indices:tolist(),', '))
local matrix=np.arange(12,'int64'):reshape({3,4})
rng:shuffle(matrix,2) -- Lua axis 2 == NumPy axis 1
print('shuffled columns of first row:',table.concat(matrix:tolist()[1],', '))
local clone=rng:permutation(matrix,1) -- shuffled rows; input unchanged
print('permuted row:',table.concat(clone:tolist()[1],', '))
local list={'red','green','blue','yellow'}
rng:shuffle(list) -- pure Lua table, in-place
print('shuffled Lua table:',table.concat(list,', '))
