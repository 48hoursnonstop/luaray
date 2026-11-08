local np=require('luaray_core')
local count=0
do
local base=np.arange(12,'int32')
local a=base
local b=base
assert(np.shares_memory(a,b)==true,'1d whole/whole exact')
assert(np.may_share_memory(a,b)==true,'1d whole/whole maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base
local b=np.flip(base)
assert(np.shares_memory(a,b)==true,'1d whole/reverse exact')
assert(np.may_share_memory(a,b)==true,'1d whole/reverse maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base
local b=base:get(np.slice(1,nil,2))
assert(np.shares_memory(a,b)==true,'1d whole/even exact')
assert(np.may_share_memory(a,b)==true,'1d whole/even maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base
local b=base:get(np.slice(2,nil,2))
assert(np.shares_memory(a,b)==true,'1d whole/odd exact')
assert(np.may_share_memory(a,b)==true,'1d whole/odd maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base
local b=base:get(np.slice(1,7))
assert(np.shares_memory(a,b)==true,'1d whole/first exact')
assert(np.may_share_memory(a,b)==true,'1d whole/first maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base
local b=base:get(np.slice(7,nil))
assert(np.shares_memory(a,b)==true,'1d whole/last exact')
assert(np.may_share_memory(a,b)==true,'1d whole/last maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base
local b=base:get(np.slice(3,10))
assert(np.shares_memory(a,b)==true,'1d whole/middle exact')
assert(np.may_share_memory(a,b)==true,'1d whole/middle maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base
local b=base:get(np.slice(1,nil,3))
assert(np.shares_memory(a,b)==true,'1d whole/step3 exact')
assert(np.may_share_memory(a,b)==true,'1d whole/step3 maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base
local b=np.astype(base,'int32')
assert(np.shares_memory(a,b)==false,'1d whole/copy exact')
assert(np.may_share_memory(a,b)==false,'1d whole/copy maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=np.flip(base)
local b=base
assert(np.shares_memory(a,b)==true,'1d reverse/whole exact')
assert(np.may_share_memory(a,b)==true,'1d reverse/whole maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=np.flip(base)
local b=np.flip(base)
assert(np.shares_memory(a,b)==true,'1d reverse/reverse exact')
assert(np.may_share_memory(a,b)==true,'1d reverse/reverse maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=np.flip(base)
local b=base:get(np.slice(1,nil,2))
assert(np.shares_memory(a,b)==true,'1d reverse/even exact')
assert(np.may_share_memory(a,b)==true,'1d reverse/even maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=np.flip(base)
local b=base:get(np.slice(2,nil,2))
assert(np.shares_memory(a,b)==true,'1d reverse/odd exact')
assert(np.may_share_memory(a,b)==true,'1d reverse/odd maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=np.flip(base)
local b=base:get(np.slice(1,7))
assert(np.shares_memory(a,b)==true,'1d reverse/first exact')
assert(np.may_share_memory(a,b)==true,'1d reverse/first maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=np.flip(base)
local b=base:get(np.slice(7,nil))
assert(np.shares_memory(a,b)==true,'1d reverse/last exact')
assert(np.may_share_memory(a,b)==true,'1d reverse/last maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=np.flip(base)
local b=base:get(np.slice(3,10))
assert(np.shares_memory(a,b)==true,'1d reverse/middle exact')
assert(np.may_share_memory(a,b)==true,'1d reverse/middle maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=np.flip(base)
local b=base:get(np.slice(1,nil,3))
assert(np.shares_memory(a,b)==true,'1d reverse/step3 exact')
assert(np.may_share_memory(a,b)==true,'1d reverse/step3 maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=np.flip(base)
local b=np.astype(base,'int32')
assert(np.shares_memory(a,b)==false,'1d reverse/copy exact')
assert(np.may_share_memory(a,b)==false,'1d reverse/copy maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,nil,2))
local b=base
assert(np.shares_memory(a,b)==true,'1d even/whole exact')
assert(np.may_share_memory(a,b)==true,'1d even/whole maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,nil,2))
local b=np.flip(base)
assert(np.shares_memory(a,b)==true,'1d even/reverse exact')
assert(np.may_share_memory(a,b)==true,'1d even/reverse maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,nil,2))
local b=base:get(np.slice(1,nil,2))
assert(np.shares_memory(a,b)==true,'1d even/even exact')
assert(np.may_share_memory(a,b)==true,'1d even/even maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,nil,2))
local b=base:get(np.slice(2,nil,2))
assert(np.shares_memory(a,b)==false,'1d even/odd exact')
assert(np.may_share_memory(a,b)==true,'1d even/odd maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,nil,2))
local b=base:get(np.slice(1,7))
assert(np.shares_memory(a,b)==true,'1d even/first exact')
assert(np.may_share_memory(a,b)==true,'1d even/first maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,nil,2))
local b=base:get(np.slice(7,nil))
assert(np.shares_memory(a,b)==true,'1d even/last exact')
assert(np.may_share_memory(a,b)==true,'1d even/last maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,nil,2))
local b=base:get(np.slice(3,10))
assert(np.shares_memory(a,b)==true,'1d even/middle exact')
assert(np.may_share_memory(a,b)==true,'1d even/middle maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,nil,2))
local b=base:get(np.slice(1,nil,3))
assert(np.shares_memory(a,b)==true,'1d even/step3 exact')
assert(np.may_share_memory(a,b)==true,'1d even/step3 maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,nil,2))
local b=np.astype(base,'int32')
assert(np.shares_memory(a,b)==false,'1d even/copy exact')
assert(np.may_share_memory(a,b)==false,'1d even/copy maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(2,nil,2))
local b=base
assert(np.shares_memory(a,b)==true,'1d odd/whole exact')
assert(np.may_share_memory(a,b)==true,'1d odd/whole maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(2,nil,2))
local b=np.flip(base)
assert(np.shares_memory(a,b)==true,'1d odd/reverse exact')
assert(np.may_share_memory(a,b)==true,'1d odd/reverse maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(2,nil,2))
local b=base:get(np.slice(1,nil,2))
assert(np.shares_memory(a,b)==false,'1d odd/even exact')
assert(np.may_share_memory(a,b)==true,'1d odd/even maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(2,nil,2))
local b=base:get(np.slice(2,nil,2))
assert(np.shares_memory(a,b)==true,'1d odd/odd exact')
assert(np.may_share_memory(a,b)==true,'1d odd/odd maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(2,nil,2))
local b=base:get(np.slice(1,7))
assert(np.shares_memory(a,b)==true,'1d odd/first exact')
assert(np.may_share_memory(a,b)==true,'1d odd/first maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(2,nil,2))
local b=base:get(np.slice(7,nil))
assert(np.shares_memory(a,b)==true,'1d odd/last exact')
assert(np.may_share_memory(a,b)==true,'1d odd/last maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(2,nil,2))
local b=base:get(np.slice(3,10))
assert(np.shares_memory(a,b)==true,'1d odd/middle exact')
assert(np.may_share_memory(a,b)==true,'1d odd/middle maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(2,nil,2))
local b=base:get(np.slice(1,nil,3))
assert(np.shares_memory(a,b)==true,'1d odd/step3 exact')
assert(np.may_share_memory(a,b)==true,'1d odd/step3 maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(2,nil,2))
local b=np.astype(base,'int32')
assert(np.shares_memory(a,b)==false,'1d odd/copy exact')
assert(np.may_share_memory(a,b)==false,'1d odd/copy maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,7))
local b=base
assert(np.shares_memory(a,b)==true,'1d first/whole exact')
assert(np.may_share_memory(a,b)==true,'1d first/whole maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,7))
local b=np.flip(base)
assert(np.shares_memory(a,b)==true,'1d first/reverse exact')
assert(np.may_share_memory(a,b)==true,'1d first/reverse maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,7))
local b=base:get(np.slice(1,nil,2))
assert(np.shares_memory(a,b)==true,'1d first/even exact')
assert(np.may_share_memory(a,b)==true,'1d first/even maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,7))
local b=base:get(np.slice(2,nil,2))
assert(np.shares_memory(a,b)==true,'1d first/odd exact')
assert(np.may_share_memory(a,b)==true,'1d first/odd maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,7))
local b=base:get(np.slice(1,7))
assert(np.shares_memory(a,b)==true,'1d first/first exact')
assert(np.may_share_memory(a,b)==true,'1d first/first maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,7))
local b=base:get(np.slice(7,nil))
assert(np.shares_memory(a,b)==false,'1d first/last exact')
assert(np.may_share_memory(a,b)==false,'1d first/last maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,7))
local b=base:get(np.slice(3,10))
assert(np.shares_memory(a,b)==true,'1d first/middle exact')
assert(np.may_share_memory(a,b)==true,'1d first/middle maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,7))
local b=base:get(np.slice(1,nil,3))
assert(np.shares_memory(a,b)==true,'1d first/step3 exact')
assert(np.may_share_memory(a,b)==true,'1d first/step3 maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,7))
local b=np.astype(base,'int32')
assert(np.shares_memory(a,b)==false,'1d first/copy exact')
assert(np.may_share_memory(a,b)==false,'1d first/copy maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(7,nil))
local b=base
assert(np.shares_memory(a,b)==true,'1d last/whole exact')
assert(np.may_share_memory(a,b)==true,'1d last/whole maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(7,nil))
local b=np.flip(base)
assert(np.shares_memory(a,b)==true,'1d last/reverse exact')
assert(np.may_share_memory(a,b)==true,'1d last/reverse maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(7,nil))
local b=base:get(np.slice(1,nil,2))
assert(np.shares_memory(a,b)==true,'1d last/even exact')
assert(np.may_share_memory(a,b)==true,'1d last/even maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(7,nil))
local b=base:get(np.slice(2,nil,2))
assert(np.shares_memory(a,b)==true,'1d last/odd exact')
assert(np.may_share_memory(a,b)==true,'1d last/odd maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(7,nil))
local b=base:get(np.slice(1,7))
assert(np.shares_memory(a,b)==false,'1d last/first exact')
assert(np.may_share_memory(a,b)==false,'1d last/first maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(7,nil))
local b=base:get(np.slice(7,nil))
assert(np.shares_memory(a,b)==true,'1d last/last exact')
assert(np.may_share_memory(a,b)==true,'1d last/last maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(7,nil))
local b=base:get(np.slice(3,10))
assert(np.shares_memory(a,b)==true,'1d last/middle exact')
assert(np.may_share_memory(a,b)==true,'1d last/middle maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(7,nil))
local b=base:get(np.slice(1,nil,3))
assert(np.shares_memory(a,b)==true,'1d last/step3 exact')
assert(np.may_share_memory(a,b)==true,'1d last/step3 maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(7,nil))
local b=np.astype(base,'int32')
assert(np.shares_memory(a,b)==false,'1d last/copy exact')
assert(np.may_share_memory(a,b)==false,'1d last/copy maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(3,10))
local b=base
assert(np.shares_memory(a,b)==true,'1d middle/whole exact')
assert(np.may_share_memory(a,b)==true,'1d middle/whole maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(3,10))
local b=np.flip(base)
assert(np.shares_memory(a,b)==true,'1d middle/reverse exact')
assert(np.may_share_memory(a,b)==true,'1d middle/reverse maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(3,10))
local b=base:get(np.slice(1,nil,2))
assert(np.shares_memory(a,b)==true,'1d middle/even exact')
assert(np.may_share_memory(a,b)==true,'1d middle/even maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(3,10))
local b=base:get(np.slice(2,nil,2))
assert(np.shares_memory(a,b)==true,'1d middle/odd exact')
assert(np.may_share_memory(a,b)==true,'1d middle/odd maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(3,10))
local b=base:get(np.slice(1,7))
assert(np.shares_memory(a,b)==true,'1d middle/first exact')
assert(np.may_share_memory(a,b)==true,'1d middle/first maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(3,10))
local b=base:get(np.slice(7,nil))
assert(np.shares_memory(a,b)==true,'1d middle/last exact')
assert(np.may_share_memory(a,b)==true,'1d middle/last maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(3,10))
local b=base:get(np.slice(3,10))
assert(np.shares_memory(a,b)==true,'1d middle/middle exact')
assert(np.may_share_memory(a,b)==true,'1d middle/middle maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(3,10))
local b=base:get(np.slice(1,nil,3))
assert(np.shares_memory(a,b)==true,'1d middle/step3 exact')
assert(np.may_share_memory(a,b)==true,'1d middle/step3 maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(3,10))
local b=np.astype(base,'int32')
assert(np.shares_memory(a,b)==false,'1d middle/copy exact')
assert(np.may_share_memory(a,b)==false,'1d middle/copy maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,nil,3))
local b=base
assert(np.shares_memory(a,b)==true,'1d step3/whole exact')
assert(np.may_share_memory(a,b)==true,'1d step3/whole maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,nil,3))
local b=np.flip(base)
assert(np.shares_memory(a,b)==true,'1d step3/reverse exact')
assert(np.may_share_memory(a,b)==true,'1d step3/reverse maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,nil,3))
local b=base:get(np.slice(1,nil,2))
assert(np.shares_memory(a,b)==true,'1d step3/even exact')
assert(np.may_share_memory(a,b)==true,'1d step3/even maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,nil,3))
local b=base:get(np.slice(2,nil,2))
assert(np.shares_memory(a,b)==true,'1d step3/odd exact')
assert(np.may_share_memory(a,b)==true,'1d step3/odd maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,nil,3))
local b=base:get(np.slice(1,7))
assert(np.shares_memory(a,b)==true,'1d step3/first exact')
assert(np.may_share_memory(a,b)==true,'1d step3/first maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,nil,3))
local b=base:get(np.slice(7,nil))
assert(np.shares_memory(a,b)==true,'1d step3/last exact')
assert(np.may_share_memory(a,b)==true,'1d step3/last maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,nil,3))
local b=base:get(np.slice(3,10))
assert(np.shares_memory(a,b)==true,'1d step3/middle exact')
assert(np.may_share_memory(a,b)==true,'1d step3/middle maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,nil,3))
local b=base:get(np.slice(1,nil,3))
assert(np.shares_memory(a,b)==true,'1d step3/step3 exact')
assert(np.may_share_memory(a,b)==true,'1d step3/step3 maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=base:get(np.slice(1,nil,3))
local b=np.astype(base,'int32')
assert(np.shares_memory(a,b)==false,'1d step3/copy exact')
assert(np.may_share_memory(a,b)==false,'1d step3/copy maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=np.astype(base,'int32')
local b=base
assert(np.shares_memory(a,b)==false,'1d copy/whole exact')
assert(np.may_share_memory(a,b)==false,'1d copy/whole maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=np.astype(base,'int32')
local b=np.flip(base)
assert(np.shares_memory(a,b)==false,'1d copy/reverse exact')
assert(np.may_share_memory(a,b)==false,'1d copy/reverse maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=np.astype(base,'int32')
local b=base:get(np.slice(1,nil,2))
assert(np.shares_memory(a,b)==false,'1d copy/even exact')
assert(np.may_share_memory(a,b)==false,'1d copy/even maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=np.astype(base,'int32')
local b=base:get(np.slice(2,nil,2))
assert(np.shares_memory(a,b)==false,'1d copy/odd exact')
assert(np.may_share_memory(a,b)==false,'1d copy/odd maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=np.astype(base,'int32')
local b=base:get(np.slice(1,7))
assert(np.shares_memory(a,b)==false,'1d copy/first exact')
assert(np.may_share_memory(a,b)==false,'1d copy/first maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=np.astype(base,'int32')
local b=base:get(np.slice(7,nil))
assert(np.shares_memory(a,b)==false,'1d copy/last exact')
assert(np.may_share_memory(a,b)==false,'1d copy/last maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=np.astype(base,'int32')
local b=base:get(np.slice(3,10))
assert(np.shares_memory(a,b)==false,'1d copy/middle exact')
assert(np.may_share_memory(a,b)==false,'1d copy/middle maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=np.astype(base,'int32')
local b=base:get(np.slice(1,nil,3))
assert(np.shares_memory(a,b)==false,'1d copy/step3 exact')
assert(np.may_share_memory(a,b)==false,'1d copy/step3 maybe')
count=count+1
end
do
local base=np.arange(12,'int32')
local a=np.astype(base,'int32')
local b=np.astype(base,'int32')
assert(np.shares_memory(a,b)==false,'1d copy/copy exact')
assert(np.may_share_memory(a,b)==false,'1d copy/copy maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base
local b=base
assert(np.shares_memory(a,b)==true,'2d whole/whole exact')
assert(np.may_share_memory(a,b)==true,'2d whole/whole maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base
local b=np.transpose(base)
assert(np.shares_memory(a,b)==true,'2d whole/transpose exact')
assert(np.may_share_memory(a,b)==true,'2d whole/transpose maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base
local b=np.flip(base,1)
assert(np.shares_memory(a,b)==true,'2d whole/flipx exact')
assert(np.may_share_memory(a,b)==true,'2d whole/flipx maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base
local b=np.flip(base,2)
assert(np.shares_memory(a,b)==true,'2d whole/flipy exact')
assert(np.may_share_memory(a,b)==true,'2d whole/flipy maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base
local b=base:get(np.slice(1,nil,2),np.slice())
assert(np.shares_memory(a,b)==true,'2d whole/evenrows exact')
assert(np.may_share_memory(a,b)==true,'2d whole/evenrows maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base
local b=base:get(np.slice(2,nil,2),np.slice())
assert(np.shares_memory(a,b)==true,'2d whole/oddrows exact')
assert(np.may_share_memory(a,b)==true,'2d whole/oddrows maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base
local b=base:get(np.slice(),np.slice(1,nil,2))
assert(np.shares_memory(a,b)==true,'2d whole/evencols exact')
assert(np.may_share_memory(a,b)==true,'2d whole/evencols maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base
local b=base:get(np.slice(),np.slice(2,nil,2))
assert(np.shares_memory(a,b)==true,'2d whole/oddcols exact')
assert(np.may_share_memory(a,b)==true,'2d whole/oddcols maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base
local b=np.astype(base,'int32')
assert(np.shares_memory(a,b)==false,'2d whole/copy exact')
assert(np.may_share_memory(a,b)==false,'2d whole/copy maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.transpose(base)
local b=base
assert(np.shares_memory(a,b)==true,'2d transpose/whole exact')
assert(np.may_share_memory(a,b)==true,'2d transpose/whole maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.transpose(base)
local b=np.transpose(base)
assert(np.shares_memory(a,b)==true,'2d transpose/transpose exact')
assert(np.may_share_memory(a,b)==true,'2d transpose/transpose maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.transpose(base)
local b=np.flip(base,1)
assert(np.shares_memory(a,b)==true,'2d transpose/flipx exact')
assert(np.may_share_memory(a,b)==true,'2d transpose/flipx maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.transpose(base)
local b=np.flip(base,2)
assert(np.shares_memory(a,b)==true,'2d transpose/flipy exact')
assert(np.may_share_memory(a,b)==true,'2d transpose/flipy maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.transpose(base)
local b=base:get(np.slice(1,nil,2),np.slice())
assert(np.shares_memory(a,b)==true,'2d transpose/evenrows exact')
assert(np.may_share_memory(a,b)==true,'2d transpose/evenrows maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.transpose(base)
local b=base:get(np.slice(2,nil,2),np.slice())
assert(np.shares_memory(a,b)==true,'2d transpose/oddrows exact')
assert(np.may_share_memory(a,b)==true,'2d transpose/oddrows maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.transpose(base)
local b=base:get(np.slice(),np.slice(1,nil,2))
assert(np.shares_memory(a,b)==true,'2d transpose/evencols exact')
assert(np.may_share_memory(a,b)==true,'2d transpose/evencols maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.transpose(base)
local b=base:get(np.slice(),np.slice(2,nil,2))
assert(np.shares_memory(a,b)==true,'2d transpose/oddcols exact')
assert(np.may_share_memory(a,b)==true,'2d transpose/oddcols maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.transpose(base)
local b=np.astype(base,'int32')
assert(np.shares_memory(a,b)==false,'2d transpose/copy exact')
assert(np.may_share_memory(a,b)==false,'2d transpose/copy maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.flip(base,1)
local b=base
assert(np.shares_memory(a,b)==true,'2d flipx/whole exact')
assert(np.may_share_memory(a,b)==true,'2d flipx/whole maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.flip(base,1)
local b=np.transpose(base)
assert(np.shares_memory(a,b)==true,'2d flipx/transpose exact')
assert(np.may_share_memory(a,b)==true,'2d flipx/transpose maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.flip(base,1)
local b=np.flip(base,1)
assert(np.shares_memory(a,b)==true,'2d flipx/flipx exact')
assert(np.may_share_memory(a,b)==true,'2d flipx/flipx maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.flip(base,1)
local b=np.flip(base,2)
assert(np.shares_memory(a,b)==true,'2d flipx/flipy exact')
assert(np.may_share_memory(a,b)==true,'2d flipx/flipy maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.flip(base,1)
local b=base:get(np.slice(1,nil,2),np.slice())
assert(np.shares_memory(a,b)==true,'2d flipx/evenrows exact')
assert(np.may_share_memory(a,b)==true,'2d flipx/evenrows maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.flip(base,1)
local b=base:get(np.slice(2,nil,2),np.slice())
assert(np.shares_memory(a,b)==true,'2d flipx/oddrows exact')
assert(np.may_share_memory(a,b)==true,'2d flipx/oddrows maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.flip(base,1)
local b=base:get(np.slice(),np.slice(1,nil,2))
assert(np.shares_memory(a,b)==true,'2d flipx/evencols exact')
assert(np.may_share_memory(a,b)==true,'2d flipx/evencols maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.flip(base,1)
local b=base:get(np.slice(),np.slice(2,nil,2))
assert(np.shares_memory(a,b)==true,'2d flipx/oddcols exact')
assert(np.may_share_memory(a,b)==true,'2d flipx/oddcols maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.flip(base,1)
local b=np.astype(base,'int32')
assert(np.shares_memory(a,b)==false,'2d flipx/copy exact')
assert(np.may_share_memory(a,b)==false,'2d flipx/copy maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.flip(base,2)
local b=base
assert(np.shares_memory(a,b)==true,'2d flipy/whole exact')
assert(np.may_share_memory(a,b)==true,'2d flipy/whole maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.flip(base,2)
local b=np.transpose(base)
assert(np.shares_memory(a,b)==true,'2d flipy/transpose exact')
assert(np.may_share_memory(a,b)==true,'2d flipy/transpose maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.flip(base,2)
local b=np.flip(base,1)
assert(np.shares_memory(a,b)==true,'2d flipy/flipx exact')
assert(np.may_share_memory(a,b)==true,'2d flipy/flipx maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.flip(base,2)
local b=np.flip(base,2)
assert(np.shares_memory(a,b)==true,'2d flipy/flipy exact')
assert(np.may_share_memory(a,b)==true,'2d flipy/flipy maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.flip(base,2)
local b=base:get(np.slice(1,nil,2),np.slice())
assert(np.shares_memory(a,b)==true,'2d flipy/evenrows exact')
assert(np.may_share_memory(a,b)==true,'2d flipy/evenrows maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.flip(base,2)
local b=base:get(np.slice(2,nil,2),np.slice())
assert(np.shares_memory(a,b)==true,'2d flipy/oddrows exact')
assert(np.may_share_memory(a,b)==true,'2d flipy/oddrows maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.flip(base,2)
local b=base:get(np.slice(),np.slice(1,nil,2))
assert(np.shares_memory(a,b)==true,'2d flipy/evencols exact')
assert(np.may_share_memory(a,b)==true,'2d flipy/evencols maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.flip(base,2)
local b=base:get(np.slice(),np.slice(2,nil,2))
assert(np.shares_memory(a,b)==true,'2d flipy/oddcols exact')
assert(np.may_share_memory(a,b)==true,'2d flipy/oddcols maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.flip(base,2)
local b=np.astype(base,'int32')
assert(np.shares_memory(a,b)==false,'2d flipy/copy exact')
assert(np.may_share_memory(a,b)==false,'2d flipy/copy maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(1,nil,2),np.slice())
local b=base
assert(np.shares_memory(a,b)==true,'2d evenrows/whole exact')
assert(np.may_share_memory(a,b)==true,'2d evenrows/whole maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(1,nil,2),np.slice())
local b=np.transpose(base)
assert(np.shares_memory(a,b)==true,'2d evenrows/transpose exact')
assert(np.may_share_memory(a,b)==true,'2d evenrows/transpose maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(1,nil,2),np.slice())
local b=np.flip(base,1)
assert(np.shares_memory(a,b)==true,'2d evenrows/flipx exact')
assert(np.may_share_memory(a,b)==true,'2d evenrows/flipx maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(1,nil,2),np.slice())
local b=np.flip(base,2)
assert(np.shares_memory(a,b)==true,'2d evenrows/flipy exact')
assert(np.may_share_memory(a,b)==true,'2d evenrows/flipy maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(1,nil,2),np.slice())
local b=base:get(np.slice(1,nil,2),np.slice())
assert(np.shares_memory(a,b)==true,'2d evenrows/evenrows exact')
assert(np.may_share_memory(a,b)==true,'2d evenrows/evenrows maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(1,nil,2),np.slice())
local b=base:get(np.slice(2,nil,2),np.slice())
assert(np.shares_memory(a,b)==false,'2d evenrows/oddrows exact')
assert(np.may_share_memory(a,b)==true,'2d evenrows/oddrows maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(1,nil,2),np.slice())
local b=base:get(np.slice(),np.slice(1,nil,2))
assert(np.shares_memory(a,b)==true,'2d evenrows/evencols exact')
assert(np.may_share_memory(a,b)==true,'2d evenrows/evencols maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(1,nil,2),np.slice())
local b=base:get(np.slice(),np.slice(2,nil,2))
assert(np.shares_memory(a,b)==true,'2d evenrows/oddcols exact')
assert(np.may_share_memory(a,b)==true,'2d evenrows/oddcols maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(1,nil,2),np.slice())
local b=np.astype(base,'int32')
assert(np.shares_memory(a,b)==false,'2d evenrows/copy exact')
assert(np.may_share_memory(a,b)==false,'2d evenrows/copy maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(2,nil,2),np.slice())
local b=base
assert(np.shares_memory(a,b)==true,'2d oddrows/whole exact')
assert(np.may_share_memory(a,b)==true,'2d oddrows/whole maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(2,nil,2),np.slice())
local b=np.transpose(base)
assert(np.shares_memory(a,b)==true,'2d oddrows/transpose exact')
assert(np.may_share_memory(a,b)==true,'2d oddrows/transpose maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(2,nil,2),np.slice())
local b=np.flip(base,1)
assert(np.shares_memory(a,b)==true,'2d oddrows/flipx exact')
assert(np.may_share_memory(a,b)==true,'2d oddrows/flipx maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(2,nil,2),np.slice())
local b=np.flip(base,2)
assert(np.shares_memory(a,b)==true,'2d oddrows/flipy exact')
assert(np.may_share_memory(a,b)==true,'2d oddrows/flipy maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(2,nil,2),np.slice())
local b=base:get(np.slice(1,nil,2),np.slice())
assert(np.shares_memory(a,b)==false,'2d oddrows/evenrows exact')
assert(np.may_share_memory(a,b)==true,'2d oddrows/evenrows maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(2,nil,2),np.slice())
local b=base:get(np.slice(2,nil,2),np.slice())
assert(np.shares_memory(a,b)==true,'2d oddrows/oddrows exact')
assert(np.may_share_memory(a,b)==true,'2d oddrows/oddrows maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(2,nil,2),np.slice())
local b=base:get(np.slice(),np.slice(1,nil,2))
assert(np.shares_memory(a,b)==true,'2d oddrows/evencols exact')
assert(np.may_share_memory(a,b)==true,'2d oddrows/evencols maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(2,nil,2),np.slice())
local b=base:get(np.slice(),np.slice(2,nil,2))
assert(np.shares_memory(a,b)==true,'2d oddrows/oddcols exact')
assert(np.may_share_memory(a,b)==true,'2d oddrows/oddcols maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(2,nil,2),np.slice())
local b=np.astype(base,'int32')
assert(np.shares_memory(a,b)==false,'2d oddrows/copy exact')
assert(np.may_share_memory(a,b)==false,'2d oddrows/copy maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(),np.slice(1,nil,2))
local b=base
assert(np.shares_memory(a,b)==true,'2d evencols/whole exact')
assert(np.may_share_memory(a,b)==true,'2d evencols/whole maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(),np.slice(1,nil,2))
local b=np.transpose(base)
assert(np.shares_memory(a,b)==true,'2d evencols/transpose exact')
assert(np.may_share_memory(a,b)==true,'2d evencols/transpose maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(),np.slice(1,nil,2))
local b=np.flip(base,1)
assert(np.shares_memory(a,b)==true,'2d evencols/flipx exact')
assert(np.may_share_memory(a,b)==true,'2d evencols/flipx maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(),np.slice(1,nil,2))
local b=np.flip(base,2)
assert(np.shares_memory(a,b)==true,'2d evencols/flipy exact')
assert(np.may_share_memory(a,b)==true,'2d evencols/flipy maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(),np.slice(1,nil,2))
local b=base:get(np.slice(1,nil,2),np.slice())
assert(np.shares_memory(a,b)==true,'2d evencols/evenrows exact')
assert(np.may_share_memory(a,b)==true,'2d evencols/evenrows maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(),np.slice(1,nil,2))
local b=base:get(np.slice(2,nil,2),np.slice())
assert(np.shares_memory(a,b)==true,'2d evencols/oddrows exact')
assert(np.may_share_memory(a,b)==true,'2d evencols/oddrows maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(),np.slice(1,nil,2))
local b=base:get(np.slice(),np.slice(1,nil,2))
assert(np.shares_memory(a,b)==true,'2d evencols/evencols exact')
assert(np.may_share_memory(a,b)==true,'2d evencols/evencols maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(),np.slice(1,nil,2))
local b=base:get(np.slice(),np.slice(2,nil,2))
assert(np.shares_memory(a,b)==false,'2d evencols/oddcols exact')
assert(np.may_share_memory(a,b)==true,'2d evencols/oddcols maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(),np.slice(1,nil,2))
local b=np.astype(base,'int32')
assert(np.shares_memory(a,b)==false,'2d evencols/copy exact')
assert(np.may_share_memory(a,b)==false,'2d evencols/copy maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(),np.slice(2,nil,2))
local b=base
assert(np.shares_memory(a,b)==true,'2d oddcols/whole exact')
assert(np.may_share_memory(a,b)==true,'2d oddcols/whole maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(),np.slice(2,nil,2))
local b=np.transpose(base)
assert(np.shares_memory(a,b)==true,'2d oddcols/transpose exact')
assert(np.may_share_memory(a,b)==true,'2d oddcols/transpose maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(),np.slice(2,nil,2))
local b=np.flip(base,1)
assert(np.shares_memory(a,b)==true,'2d oddcols/flipx exact')
assert(np.may_share_memory(a,b)==true,'2d oddcols/flipx maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(),np.slice(2,nil,2))
local b=np.flip(base,2)
assert(np.shares_memory(a,b)==true,'2d oddcols/flipy exact')
assert(np.may_share_memory(a,b)==true,'2d oddcols/flipy maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(),np.slice(2,nil,2))
local b=base:get(np.slice(1,nil,2),np.slice())
assert(np.shares_memory(a,b)==true,'2d oddcols/evenrows exact')
assert(np.may_share_memory(a,b)==true,'2d oddcols/evenrows maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(),np.slice(2,nil,2))
local b=base:get(np.slice(2,nil,2),np.slice())
assert(np.shares_memory(a,b)==true,'2d oddcols/oddrows exact')
assert(np.may_share_memory(a,b)==true,'2d oddcols/oddrows maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(),np.slice(2,nil,2))
local b=base:get(np.slice(),np.slice(1,nil,2))
assert(np.shares_memory(a,b)==false,'2d oddcols/evencols exact')
assert(np.may_share_memory(a,b)==true,'2d oddcols/evencols maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(),np.slice(2,nil,2))
local b=base:get(np.slice(),np.slice(2,nil,2))
assert(np.shares_memory(a,b)==true,'2d oddcols/oddcols exact')
assert(np.may_share_memory(a,b)==true,'2d oddcols/oddcols maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=base:get(np.slice(),np.slice(2,nil,2))
local b=np.astype(base,'int32')
assert(np.shares_memory(a,b)==false,'2d oddcols/copy exact')
assert(np.may_share_memory(a,b)==false,'2d oddcols/copy maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.astype(base,'int32')
local b=base
assert(np.shares_memory(a,b)==false,'2d copy/whole exact')
assert(np.may_share_memory(a,b)==false,'2d copy/whole maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.astype(base,'int32')
local b=np.transpose(base)
assert(np.shares_memory(a,b)==false,'2d copy/transpose exact')
assert(np.may_share_memory(a,b)==false,'2d copy/transpose maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.astype(base,'int32')
local b=np.flip(base,1)
assert(np.shares_memory(a,b)==false,'2d copy/flipx exact')
assert(np.may_share_memory(a,b)==false,'2d copy/flipx maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.astype(base,'int32')
local b=np.flip(base,2)
assert(np.shares_memory(a,b)==false,'2d copy/flipy exact')
assert(np.may_share_memory(a,b)==false,'2d copy/flipy maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.astype(base,'int32')
local b=base:get(np.slice(1,nil,2),np.slice())
assert(np.shares_memory(a,b)==false,'2d copy/evenrows exact')
assert(np.may_share_memory(a,b)==false,'2d copy/evenrows maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.astype(base,'int32')
local b=base:get(np.slice(2,nil,2),np.slice())
assert(np.shares_memory(a,b)==false,'2d copy/oddrows exact')
assert(np.may_share_memory(a,b)==false,'2d copy/oddrows maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.astype(base,'int32')
local b=base:get(np.slice(),np.slice(1,nil,2))
assert(np.shares_memory(a,b)==false,'2d copy/evencols exact')
assert(np.may_share_memory(a,b)==false,'2d copy/evencols maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.astype(base,'int32')
local b=base:get(np.slice(),np.slice(2,nil,2))
assert(np.shares_memory(a,b)==false,'2d copy/oddcols exact')
assert(np.may_share_memory(a,b)==false,'2d copy/oddcols maybe')
count=count+1
end
do
local base=np.arange(12,'int32'):reshape({3,4})
local a=np.astype(base,'int32')
local b=np.astype(base,'int32')
assert(np.shares_memory(a,b)==false,'2d copy/copy exact')
assert(np.may_share_memory(a,b)==false,'2d copy/copy maybe')
count=count+1
end
assert(count==162)
print('overlap97 differential: 162 cases passed')
