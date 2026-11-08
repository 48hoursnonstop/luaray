-- Native owning-buffer guard. Upstream unsafe raw writes were NOT executed.
-- These cases are deliberately outside original parity totals.
return {
 {name='reversed-tail',setup=function(np)
   local owner=np.array({8,9,10},'int64')
   return owner,np.flip(owner)
 end},
 {name='zero-stride',setup=function(np)
   local owner=np.array({8},'int64')
   return owner,np.broadcast_arrays(owner,np.zeros({3}))[1]
 end},
}
