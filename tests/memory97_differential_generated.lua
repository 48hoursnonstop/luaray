local np=require('luaray_core')
local function flat(x,t) if type(x)=='table' then for _,v in ipairs(x) do flat(v,t) end else t[#t+1]=x end end
local function check(a, expected, label) local v={} flat(a:tolist(),v); assert(#v==#expected,label..': count'); for i=1,#v do assert(v[i]==expected[i],label..' index '..i..' got '..tostring(v[i])..' expected '..tostring(expected[i])) end end
local cases=0
-- case 1: copyto-int32-plain-scalar
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=base
local src=8
np.copyto(v,src,'same_kind',true)
check(base,{8,8,8,8,8,8,8,8,8,8,8,8},'1:copyto-int32-plain-scalar')
cases=cases+1
end
-- case 2: copyto-int32-plain-vector
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=base
local src=np.array({3,4,5,6},'int16')
np.copyto(v,src,'same_kind',true)
check(base,{3,4,5,6,3,4,5,6,3,4,5,6},'2:copyto-int32-plain-vector')
cases=cases+1
end
-- case 3: copyto-int32-plain-full
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=base
local src=np.array({{0.5,1.5,2.5,3.5},{4.5,5.5,6.5,7.5},{8.5,9.5,10.5,11.5}},'float64')
np.copyto(v,src,'unsafe',true)
check(base,{0,1,2,3,4,5,6,7,8,9,10,11},'3:copyto-int32-plain-full')
cases=cases+1
end
-- case 4: copyto-int32-plain-alias
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=base
local src=base
np.copyto(v,src,'same_kind',true)
check(base,{0,1,2,3,4,5,6,7,8,9,10,11},'4:copyto-int32-plain-alias')
cases=cases+1
end
-- case 5: copyto-int32-plain-masked
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=base
local src=np.array({6,7,8,9},'int16')
np.copyto(v,src,'same_kind',np.array({{true,false,true,true},{false,true,true,false},{true,true,false,true}},'bool'))
check(base,{6,1,8,9,4,7,8,7,6,7,10,9},'5:copyto-int32-plain-masked')
cases=cases+1
end
-- case 6: copyto-int32-plain-masked_scalar
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=base
local src=99
np.copyto(v,src,'same_kind',false)
check(base,{0,1,2,3,4,5,6,7,8,9,10,11},'6:copyto-int32-plain-masked_scalar')
cases=cases+1
end
-- case 7: copyto-int32-revcols-scalar
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,2)
local src=8
np.copyto(v,src,'same_kind',true)
check(base,{8,8,8,8,8,8,8,8,8,8,8,8},'7:copyto-int32-revcols-scalar')
cases=cases+1
end
-- case 8: copyto-int32-revcols-vector
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,2)
local src=np.array({3,4,5,6},'int16')
np.copyto(v,src,'same_kind',true)
check(base,{6,5,4,3,6,5,4,3,6,5,4,3},'8:copyto-int32-revcols-vector')
cases=cases+1
end
-- case 9: copyto-int32-revcols-full
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,2)
local src=np.array({{0.5,1.5,2.5,3.5},{4.5,5.5,6.5,7.5},{8.5,9.5,10.5,11.5}},'float64')
np.copyto(v,src,'unsafe',true)
check(base,{3,2,1,0,7,6,5,4,11,10,9,8},'9:copyto-int32-revcols-full')
cases=cases+1
end
-- case 10: copyto-int32-revcols-alias
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,2)
local src=base
np.copyto(v,src,'same_kind',true)
check(base,{3,2,1,0,7,6,5,4,11,10,9,8},'10:copyto-int32-revcols-alias')
cases=cases+1
end
-- case 11: copyto-int32-revcols-masked
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,2)
local src=np.array({6,7,8,9},'int16')
np.copyto(v,src,'same_kind',np.array({{true,false,true,true},{false,true,true,false},{true,true,false,true}},'bool'))
check(base,{9,8,2,6,4,8,7,7,9,9,7,6},'11:copyto-int32-revcols-masked')
cases=cases+1
end
-- case 12: copyto-int32-revcols-masked_scalar
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,2)
local src=99
np.copyto(v,src,'same_kind',false)
check(base,{0,1,2,3,4,5,6,7,8,9,10,11},'12:copyto-int32-revcols-masked_scalar')
cases=cases+1
end
-- case 13: copyto-int32-transpose-scalar
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.transpose(base)
local src=8
np.copyto(v,src,'same_kind',true)
check(base,{8,8,8,8,8,8,8,8,8,8,8,8},'13:copyto-int32-transpose-scalar')
cases=cases+1
end
-- case 14: copyto-int32-transpose-vector
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.transpose(base)
local src=np.array({3,4,5},'int16')
np.copyto(v,src,'same_kind',true)
check(base,{3,3,3,3,4,4,4,4,5,5,5,5},'14:copyto-int32-transpose-vector')
cases=cases+1
end
-- case 15: copyto-int32-transpose-full
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.transpose(base)
local src=np.array({{0.5,1.5,2.5},{3.5,4.5,5.5},{6.5,7.5,8.5},{9.5,10.5,11.5}},'float64')
np.copyto(v,src,'unsafe',true)
check(base,{0,3,6,9,1,4,7,10,2,5,8,11},'15:copyto-int32-transpose-full')
cases=cases+1
end
-- case 16: copyto-int32-transpose-alias
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.transpose(base)
local src=np.transpose(base)
np.copyto(v,src,'same_kind',true)
check(base,{0,1,2,3,4,5,6,7,8,9,10,11},'16:copyto-int32-transpose-alias')
cases=cases+1
end
-- case 17: copyto-int32-transpose-masked
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.transpose(base)
local src=np.array({6,7,8},'int16')
np.copyto(v,src,'same_kind',np.array({{true,false,true},{true,false,true},{true,false,true},{true,false,true}},'bool'))
check(base,{6,6,6,6,4,5,6,7,8,8,8,8},'17:copyto-int32-transpose-masked')
cases=cases+1
end
-- case 18: copyto-int32-transpose-masked_scalar
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.transpose(base)
local src=99
np.copyto(v,src,'same_kind',false)
check(base,{0,1,2,3,4,5,6,7,8,9,10,11},'18:copyto-int32-transpose-masked_scalar')
cases=cases+1
end
-- case 19: copyto-int32-revrows-scalar
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,1)
local src=8
np.copyto(v,src,'same_kind',true)
check(base,{8,8,8,8,8,8,8,8,8,8,8,8},'19:copyto-int32-revrows-scalar')
cases=cases+1
end
-- case 20: copyto-int32-revrows-vector
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,1)
local src=np.array({3,4,5,6},'int16')
np.copyto(v,src,'same_kind',true)
check(base,{3,4,5,6,3,4,5,6,3,4,5,6},'20:copyto-int32-revrows-vector')
cases=cases+1
end
-- case 21: copyto-int32-revrows-full
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,1)
local src=np.array({{0.5,1.5,2.5,3.5},{4.5,5.5,6.5,7.5},{8.5,9.5,10.5,11.5}},'float64')
np.copyto(v,src,'unsafe',true)
check(base,{8,9,10,11,4,5,6,7,0,1,2,3},'21:copyto-int32-revrows-full')
cases=cases+1
end
-- case 22: copyto-int32-revrows-alias
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,1)
local src=base
np.copyto(v,src,'same_kind',true)
check(base,{8,9,10,11,4,5,6,7,0,1,2,3},'22:copyto-int32-revrows-alias')
cases=cases+1
end
-- case 23: copyto-int32-revrows-masked
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,1)
local src=np.array({6,7,8,9},'int16')
np.copyto(v,src,'same_kind',np.array({{true,false,true,true},{false,true,true,false},{true,true,false,true}},'bool'))
check(base,{6,7,2,9,4,7,8,7,6,9,8,9},'23:copyto-int32-revrows-masked')
cases=cases+1
end
-- case 24: copyto-int32-revrows-masked_scalar
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,1)
local src=99
np.copyto(v,src,'same_kind',false)
check(base,{0,1,2,3,4,5,6,7,8,9,10,11},'24:copyto-int32-revrows-masked_scalar')
cases=cases+1
end
-- case 25: copyto-int64-plain-scalar
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=base
local src=8
np.copyto(v,src,'same_kind',true)
check(base,{8,8,8,8,8,8,8,8,8,8,8,8},'25:copyto-int64-plain-scalar')
cases=cases+1
end
-- case 26: copyto-int64-plain-vector
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=base
local src=np.array({3,4,5,6},'int16')
np.copyto(v,src,'same_kind',true)
check(base,{3,4,5,6,3,4,5,6,3,4,5,6},'26:copyto-int64-plain-vector')
cases=cases+1
end
-- case 27: copyto-int64-plain-full
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=base
local src=np.array({{0.5,1.5,2.5,3.5},{4.5,5.5,6.5,7.5},{8.5,9.5,10.5,11.5}},'float64')
np.copyto(v,src,'unsafe',true)
check(base,{0,1,2,3,4,5,6,7,8,9,10,11},'27:copyto-int64-plain-full')
cases=cases+1
end
-- case 28: copyto-int64-plain-alias
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=base
local src=base
np.copyto(v,src,'same_kind',true)
check(base,{0,1,2,3,4,5,6,7,8,9,10,11},'28:copyto-int64-plain-alias')
cases=cases+1
end
-- case 29: copyto-int64-plain-masked
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=base
local src=np.array({6,7,8,9},'int16')
np.copyto(v,src,'same_kind',np.array({{true,false,true,true},{false,true,true,false},{true,true,false,true}},'bool'))
check(base,{6,1,8,9,4,7,8,7,6,7,10,9},'29:copyto-int64-plain-masked')
cases=cases+1
end
-- case 30: copyto-int64-plain-masked_scalar
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=base
local src=99
np.copyto(v,src,'same_kind',false)
check(base,{0,1,2,3,4,5,6,7,8,9,10,11},'30:copyto-int64-plain-masked_scalar')
cases=cases+1
end
-- case 31: copyto-int64-revcols-scalar
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=np.flip(base,2)
local src=8
np.copyto(v,src,'same_kind',true)
check(base,{8,8,8,8,8,8,8,8,8,8,8,8},'31:copyto-int64-revcols-scalar')
cases=cases+1
end
-- case 32: copyto-int64-revcols-vector
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=np.flip(base,2)
local src=np.array({3,4,5,6},'int16')
np.copyto(v,src,'same_kind',true)
check(base,{6,5,4,3,6,5,4,3,6,5,4,3},'32:copyto-int64-revcols-vector')
cases=cases+1
end
-- case 33: copyto-int64-revcols-full
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=np.flip(base,2)
local src=np.array({{0.5,1.5,2.5,3.5},{4.5,5.5,6.5,7.5},{8.5,9.5,10.5,11.5}},'float64')
np.copyto(v,src,'unsafe',true)
check(base,{3,2,1,0,7,6,5,4,11,10,9,8},'33:copyto-int64-revcols-full')
cases=cases+1
end
-- case 34: copyto-int64-revcols-alias
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=np.flip(base,2)
local src=base
np.copyto(v,src,'same_kind',true)
check(base,{3,2,1,0,7,6,5,4,11,10,9,8},'34:copyto-int64-revcols-alias')
cases=cases+1
end
-- case 35: copyto-int64-revcols-masked
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=np.flip(base,2)
local src=np.array({6,7,8,9},'int16')
np.copyto(v,src,'same_kind',np.array({{true,false,true,true},{false,true,true,false},{true,true,false,true}},'bool'))
check(base,{9,8,2,6,4,8,7,7,9,9,7,6},'35:copyto-int64-revcols-masked')
cases=cases+1
end
-- case 36: copyto-int64-revcols-masked_scalar
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=np.flip(base,2)
local src=99
np.copyto(v,src,'same_kind',false)
check(base,{0,1,2,3,4,5,6,7,8,9,10,11},'36:copyto-int64-revcols-masked_scalar')
cases=cases+1
end
-- case 37: copyto-int64-transpose-scalar
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=np.transpose(base)
local src=8
np.copyto(v,src,'same_kind',true)
check(base,{8,8,8,8,8,8,8,8,8,8,8,8},'37:copyto-int64-transpose-scalar')
cases=cases+1
end
-- case 38: copyto-int64-transpose-vector
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=np.transpose(base)
local src=np.array({3,4,5},'int16')
np.copyto(v,src,'same_kind',true)
check(base,{3,3,3,3,4,4,4,4,5,5,5,5},'38:copyto-int64-transpose-vector')
cases=cases+1
end
-- case 39: copyto-int64-transpose-full
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=np.transpose(base)
local src=np.array({{0.5,1.5,2.5},{3.5,4.5,5.5},{6.5,7.5,8.5},{9.5,10.5,11.5}},'float64')
np.copyto(v,src,'unsafe',true)
check(base,{0,3,6,9,1,4,7,10,2,5,8,11},'39:copyto-int64-transpose-full')
cases=cases+1
end
-- case 40: copyto-int64-transpose-alias
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=np.transpose(base)
local src=np.transpose(base)
np.copyto(v,src,'same_kind',true)
check(base,{0,1,2,3,4,5,6,7,8,9,10,11},'40:copyto-int64-transpose-alias')
cases=cases+1
end
-- case 41: copyto-int64-transpose-masked
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=np.transpose(base)
local src=np.array({6,7,8},'int16')
np.copyto(v,src,'same_kind',np.array({{true,false,true},{true,false,true},{true,false,true},{true,false,true}},'bool'))
check(base,{6,6,6,6,4,5,6,7,8,8,8,8},'41:copyto-int64-transpose-masked')
cases=cases+1
end
-- case 42: copyto-int64-transpose-masked_scalar
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=np.transpose(base)
local src=99
np.copyto(v,src,'same_kind',false)
check(base,{0,1,2,3,4,5,6,7,8,9,10,11},'42:copyto-int64-transpose-masked_scalar')
cases=cases+1
end
-- case 43: copyto-int64-revrows-scalar
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=np.flip(base,1)
local src=8
np.copyto(v,src,'same_kind',true)
check(base,{8,8,8,8,8,8,8,8,8,8,8,8},'43:copyto-int64-revrows-scalar')
cases=cases+1
end
-- case 44: copyto-int64-revrows-vector
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=np.flip(base,1)
local src=np.array({3,4,5,6},'int16')
np.copyto(v,src,'same_kind',true)
check(base,{3,4,5,6,3,4,5,6,3,4,5,6},'44:copyto-int64-revrows-vector')
cases=cases+1
end
-- case 45: copyto-int64-revrows-full
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=np.flip(base,1)
local src=np.array({{0.5,1.5,2.5,3.5},{4.5,5.5,6.5,7.5},{8.5,9.5,10.5,11.5}},'float64')
np.copyto(v,src,'unsafe',true)
check(base,{8,9,10,11,4,5,6,7,0,1,2,3},'45:copyto-int64-revrows-full')
cases=cases+1
end
-- case 46: copyto-int64-revrows-alias
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=np.flip(base,1)
local src=base
np.copyto(v,src,'same_kind',true)
check(base,{8,9,10,11,4,5,6,7,0,1,2,3},'46:copyto-int64-revrows-alias')
cases=cases+1
end
-- case 47: copyto-int64-revrows-masked
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=np.flip(base,1)
local src=np.array({6,7,8,9},'int16')
np.copyto(v,src,'same_kind',np.array({{true,false,true,true},{false,true,true,false},{true,true,false,true}},'bool'))
check(base,{6,7,2,9,4,7,8,7,6,9,8,9},'47:copyto-int64-revrows-masked')
cases=cases+1
end
-- case 48: copyto-int64-revrows-masked_scalar
do
local base=np.arange(12,'int64'):reshape({3,4})
local v=np.flip(base,1)
local src=99
np.copyto(v,src,'same_kind',false)
check(base,{0,1,2,3,4,5,6,7,8,9,10,11},'48:copyto-int64-revrows-masked_scalar')
cases=cases+1
end
-- case 49: copyto-float32-plain-scalar
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=base
local src=8
np.copyto(v,src,'same_kind',true)
check(base,{8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0},'49:copyto-float32-plain-scalar')
cases=cases+1
end
-- case 50: copyto-float32-plain-vector
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=base
local src=np.array({3,4,5,6},'int16')
np.copyto(v,src,'same_kind',true)
check(base,{3.0,4.0,5.0,6.0,3.0,4.0,5.0,6.0,3.0,4.0,5.0,6.0},'50:copyto-float32-plain-vector')
cases=cases+1
end
-- case 51: copyto-float32-plain-full
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=base
local src=np.array({{0.5,1.5,2.5,3.5},{4.5,5.5,6.5,7.5},{8.5,9.5,10.5,11.5}},'float64')
np.copyto(v,src,'unsafe',true)
check(base,{0.5,1.5,2.5,3.5,4.5,5.5,6.5,7.5,8.5,9.5,10.5,11.5},'51:copyto-float32-plain-full')
cases=cases+1
end
-- case 52: copyto-float32-plain-alias
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=base
local src=base
np.copyto(v,src,'same_kind',true)
check(base,{0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},'52:copyto-float32-plain-alias')
cases=cases+1
end
-- case 53: copyto-float32-plain-masked
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=base
local src=np.array({6,7,8,9},'int16')
np.copyto(v,src,'same_kind',np.array({{true,false,true,true},{false,true,true,false},{true,true,false,true}},'bool'))
check(base,{6.0,1.0,8.0,9.0,4.0,7.0,8.0,7.0,6.0,7.0,10.0,9.0},'53:copyto-float32-plain-masked')
cases=cases+1
end
-- case 54: copyto-float32-plain-masked_scalar
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=base
local src=99
np.copyto(v,src,'same_kind',false)
check(base,{0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},'54:copyto-float32-plain-masked_scalar')
cases=cases+1
end
-- case 55: copyto-float32-revcols-scalar
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,2)
local src=8
np.copyto(v,src,'same_kind',true)
check(base,{8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0},'55:copyto-float32-revcols-scalar')
cases=cases+1
end
-- case 56: copyto-float32-revcols-vector
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,2)
local src=np.array({3,4,5,6},'int16')
np.copyto(v,src,'same_kind',true)
check(base,{6.0,5.0,4.0,3.0,6.0,5.0,4.0,3.0,6.0,5.0,4.0,3.0},'56:copyto-float32-revcols-vector')
cases=cases+1
end
-- case 57: copyto-float32-revcols-full
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,2)
local src=np.array({{0.5,1.5,2.5,3.5},{4.5,5.5,6.5,7.5},{8.5,9.5,10.5,11.5}},'float64')
np.copyto(v,src,'unsafe',true)
check(base,{3.5,2.5,1.5,0.5,7.5,6.5,5.5,4.5,11.5,10.5,9.5,8.5},'57:copyto-float32-revcols-full')
cases=cases+1
end
-- case 58: copyto-float32-revcols-alias
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,2)
local src=base
np.copyto(v,src,'same_kind',true)
check(base,{3.0,2.0,1.0,0.0,7.0,6.0,5.0,4.0,11.0,10.0,9.0,8.0},'58:copyto-float32-revcols-alias')
cases=cases+1
end
-- case 59: copyto-float32-revcols-masked
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,2)
local src=np.array({6,7,8,9},'int16')
np.copyto(v,src,'same_kind',np.array({{true,false,true,true},{false,true,true,false},{true,true,false,true}},'bool'))
check(base,{9.0,8.0,2.0,6.0,4.0,8.0,7.0,7.0,9.0,9.0,7.0,6.0},'59:copyto-float32-revcols-masked')
cases=cases+1
end
-- case 60: copyto-float32-revcols-masked_scalar
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,2)
local src=99
np.copyto(v,src,'same_kind',false)
check(base,{0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},'60:copyto-float32-revcols-masked_scalar')
cases=cases+1
end
-- case 61: copyto-float32-transpose-scalar
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.transpose(base)
local src=8
np.copyto(v,src,'same_kind',true)
check(base,{8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0},'61:copyto-float32-transpose-scalar')
cases=cases+1
end
-- case 62: copyto-float32-transpose-vector
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.transpose(base)
local src=np.array({3,4,5},'int16')
np.copyto(v,src,'same_kind',true)
check(base,{3.0,3.0,3.0,3.0,4.0,4.0,4.0,4.0,5.0,5.0,5.0,5.0},'62:copyto-float32-transpose-vector')
cases=cases+1
end
-- case 63: copyto-float32-transpose-full
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.transpose(base)
local src=np.array({{0.5,1.5,2.5},{3.5,4.5,5.5},{6.5,7.5,8.5},{9.5,10.5,11.5}},'float64')
np.copyto(v,src,'unsafe',true)
check(base,{0.5,3.5,6.5,9.5,1.5,4.5,7.5,10.5,2.5,5.5,8.5,11.5},'63:copyto-float32-transpose-full')
cases=cases+1
end
-- case 64: copyto-float32-transpose-alias
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.transpose(base)
local src=np.transpose(base)
np.copyto(v,src,'same_kind',true)
check(base,{0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},'64:copyto-float32-transpose-alias')
cases=cases+1
end
-- case 65: copyto-float32-transpose-masked
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.transpose(base)
local src=np.array({6,7,8},'int16')
np.copyto(v,src,'same_kind',np.array({{true,false,true},{true,false,true},{true,false,true},{true,false,true}},'bool'))
check(base,{6.0,6.0,6.0,6.0,4.0,5.0,6.0,7.0,8.0,8.0,8.0,8.0},'65:copyto-float32-transpose-masked')
cases=cases+1
end
-- case 66: copyto-float32-transpose-masked_scalar
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.transpose(base)
local src=99
np.copyto(v,src,'same_kind',false)
check(base,{0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},'66:copyto-float32-transpose-masked_scalar')
cases=cases+1
end
-- case 67: copyto-float32-revrows-scalar
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,1)
local src=8
np.copyto(v,src,'same_kind',true)
check(base,{8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0},'67:copyto-float32-revrows-scalar')
cases=cases+1
end
-- case 68: copyto-float32-revrows-vector
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,1)
local src=np.array({3,4,5,6},'int16')
np.copyto(v,src,'same_kind',true)
check(base,{3.0,4.0,5.0,6.0,3.0,4.0,5.0,6.0,3.0,4.0,5.0,6.0},'68:copyto-float32-revrows-vector')
cases=cases+1
end
-- case 69: copyto-float32-revrows-full
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,1)
local src=np.array({{0.5,1.5,2.5,3.5},{4.5,5.5,6.5,7.5},{8.5,9.5,10.5,11.5}},'float64')
np.copyto(v,src,'unsafe',true)
check(base,{8.5,9.5,10.5,11.5,4.5,5.5,6.5,7.5,0.5,1.5,2.5,3.5},'69:copyto-float32-revrows-full')
cases=cases+1
end
-- case 70: copyto-float32-revrows-alias
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,1)
local src=base
np.copyto(v,src,'same_kind',true)
check(base,{8.0,9.0,10.0,11.0,4.0,5.0,6.0,7.0,0.0,1.0,2.0,3.0},'70:copyto-float32-revrows-alias')
cases=cases+1
end
-- case 71: copyto-float32-revrows-masked
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,1)
local src=np.array({6,7,8,9},'int16')
np.copyto(v,src,'same_kind',np.array({{true,false,true,true},{false,true,true,false},{true,true,false,true}},'bool'))
check(base,{6.0,7.0,2.0,9.0,4.0,7.0,8.0,7.0,6.0,9.0,8.0,9.0},'71:copyto-float32-revrows-masked')
cases=cases+1
end
-- case 72: copyto-float32-revrows-masked_scalar
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,1)
local src=99
np.copyto(v,src,'same_kind',false)
check(base,{0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},'72:copyto-float32-revrows-masked_scalar')
cases=cases+1
end
-- case 73: copyto-float64-plain-scalar
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=base
local src=8
np.copyto(v,src,'same_kind',true)
check(base,{8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0},'73:copyto-float64-plain-scalar')
cases=cases+1
end
-- case 74: copyto-float64-plain-vector
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=base
local src=np.array({3,4,5,6},'int16')
np.copyto(v,src,'same_kind',true)
check(base,{3.0,4.0,5.0,6.0,3.0,4.0,5.0,6.0,3.0,4.0,5.0,6.0},'74:copyto-float64-plain-vector')
cases=cases+1
end
-- case 75: copyto-float64-plain-full
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=base
local src=np.array({{0.5,1.5,2.5,3.5},{4.5,5.5,6.5,7.5},{8.5,9.5,10.5,11.5}},'float64')
np.copyto(v,src,'unsafe',true)
check(base,{0.5,1.5,2.5,3.5,4.5,5.5,6.5,7.5,8.5,9.5,10.5,11.5},'75:copyto-float64-plain-full')
cases=cases+1
end
-- case 76: copyto-float64-plain-alias
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=base
local src=base
np.copyto(v,src,'same_kind',true)
check(base,{0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},'76:copyto-float64-plain-alias')
cases=cases+1
end
-- case 77: copyto-float64-plain-masked
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=base
local src=np.array({6,7,8,9},'int16')
np.copyto(v,src,'same_kind',np.array({{true,false,true,true},{false,true,true,false},{true,true,false,true}},'bool'))
check(base,{6.0,1.0,8.0,9.0,4.0,7.0,8.0,7.0,6.0,7.0,10.0,9.0},'77:copyto-float64-plain-masked')
cases=cases+1
end
-- case 78: copyto-float64-plain-masked_scalar
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=base
local src=99
np.copyto(v,src,'same_kind',false)
check(base,{0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},'78:copyto-float64-plain-masked_scalar')
cases=cases+1
end
-- case 79: copyto-float64-revcols-scalar
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,2)
local src=8
np.copyto(v,src,'same_kind',true)
check(base,{8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0},'79:copyto-float64-revcols-scalar')
cases=cases+1
end
-- case 80: copyto-float64-revcols-vector
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,2)
local src=np.array({3,4,5,6},'int16')
np.copyto(v,src,'same_kind',true)
check(base,{6.0,5.0,4.0,3.0,6.0,5.0,4.0,3.0,6.0,5.0,4.0,3.0},'80:copyto-float64-revcols-vector')
cases=cases+1
end
-- case 81: copyto-float64-revcols-full
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,2)
local src=np.array({{0.5,1.5,2.5,3.5},{4.5,5.5,6.5,7.5},{8.5,9.5,10.5,11.5}},'float64')
np.copyto(v,src,'unsafe',true)
check(base,{3.5,2.5,1.5,0.5,7.5,6.5,5.5,4.5,11.5,10.5,9.5,8.5},'81:copyto-float64-revcols-full')
cases=cases+1
end
-- case 82: copyto-float64-revcols-alias
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,2)
local src=base
np.copyto(v,src,'same_kind',true)
check(base,{3.0,2.0,1.0,0.0,7.0,6.0,5.0,4.0,11.0,10.0,9.0,8.0},'82:copyto-float64-revcols-alias')
cases=cases+1
end
-- case 83: copyto-float64-revcols-masked
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,2)
local src=np.array({6,7,8,9},'int16')
np.copyto(v,src,'same_kind',np.array({{true,false,true,true},{false,true,true,false},{true,true,false,true}},'bool'))
check(base,{9.0,8.0,2.0,6.0,4.0,8.0,7.0,7.0,9.0,9.0,7.0,6.0},'83:copyto-float64-revcols-masked')
cases=cases+1
end
-- case 84: copyto-float64-revcols-masked_scalar
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,2)
local src=99
np.copyto(v,src,'same_kind',false)
check(base,{0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},'84:copyto-float64-revcols-masked_scalar')
cases=cases+1
end
-- case 85: copyto-float64-transpose-scalar
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.transpose(base)
local src=8
np.copyto(v,src,'same_kind',true)
check(base,{8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0},'85:copyto-float64-transpose-scalar')
cases=cases+1
end
-- case 86: copyto-float64-transpose-vector
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.transpose(base)
local src=np.array({3,4,5},'int16')
np.copyto(v,src,'same_kind',true)
check(base,{3.0,3.0,3.0,3.0,4.0,4.0,4.0,4.0,5.0,5.0,5.0,5.0},'86:copyto-float64-transpose-vector')
cases=cases+1
end
-- case 87: copyto-float64-transpose-full
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.transpose(base)
local src=np.array({{0.5,1.5,2.5},{3.5,4.5,5.5},{6.5,7.5,8.5},{9.5,10.5,11.5}},'float64')
np.copyto(v,src,'unsafe',true)
check(base,{0.5,3.5,6.5,9.5,1.5,4.5,7.5,10.5,2.5,5.5,8.5,11.5},'87:copyto-float64-transpose-full')
cases=cases+1
end
-- case 88: copyto-float64-transpose-alias
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.transpose(base)
local src=np.transpose(base)
np.copyto(v,src,'same_kind',true)
check(base,{0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},'88:copyto-float64-transpose-alias')
cases=cases+1
end
-- case 89: copyto-float64-transpose-masked
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.transpose(base)
local src=np.array({6,7,8},'int16')
np.copyto(v,src,'same_kind',np.array({{true,false,true},{true,false,true},{true,false,true},{true,false,true}},'bool'))
check(base,{6.0,6.0,6.0,6.0,4.0,5.0,6.0,7.0,8.0,8.0,8.0,8.0},'89:copyto-float64-transpose-masked')
cases=cases+1
end
-- case 90: copyto-float64-transpose-masked_scalar
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.transpose(base)
local src=99
np.copyto(v,src,'same_kind',false)
check(base,{0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},'90:copyto-float64-transpose-masked_scalar')
cases=cases+1
end
-- case 91: copyto-float64-revrows-scalar
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,1)
local src=8
np.copyto(v,src,'same_kind',true)
check(base,{8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0,8.0},'91:copyto-float64-revrows-scalar')
cases=cases+1
end
-- case 92: copyto-float64-revrows-vector
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,1)
local src=np.array({3,4,5,6},'int16')
np.copyto(v,src,'same_kind',true)
check(base,{3.0,4.0,5.0,6.0,3.0,4.0,5.0,6.0,3.0,4.0,5.0,6.0},'92:copyto-float64-revrows-vector')
cases=cases+1
end
-- case 93: copyto-float64-revrows-full
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,1)
local src=np.array({{0.5,1.5,2.5,3.5},{4.5,5.5,6.5,7.5},{8.5,9.5,10.5,11.5}},'float64')
np.copyto(v,src,'unsafe',true)
check(base,{8.5,9.5,10.5,11.5,4.5,5.5,6.5,7.5,0.5,1.5,2.5,3.5},'93:copyto-float64-revrows-full')
cases=cases+1
end
-- case 94: copyto-float64-revrows-alias
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,1)
local src=base
np.copyto(v,src,'same_kind',true)
check(base,{8.0,9.0,10.0,11.0,4.0,5.0,6.0,7.0,0.0,1.0,2.0,3.0},'94:copyto-float64-revrows-alias')
cases=cases+1
end
-- case 95: copyto-float64-revrows-masked
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,1)
local src=np.array({6,7,8,9},'int16')
np.copyto(v,src,'same_kind',np.array({{true,false,true,true},{false,true,true,false},{true,true,false,true}},'bool'))
check(base,{6.0,7.0,2.0,9.0,4.0,7.0,8.0,7.0,6.0,9.0,8.0,9.0},'95:copyto-float64-revrows-masked')
cases=cases+1
end
-- case 96: copyto-float64-revrows-masked_scalar
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,1)
local src=99
np.copyto(v,src,'same_kind',false)
check(base,{0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},'96:copyto-float64-revrows-masked_scalar')
cases=cases+1
end
-- case 97: copyto-uint8-plain-scalar
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=base
local src=8
np.copyto(v,src,'same_kind',true)
check(base,{8,8,8,8,8,8,8,8,8,8,8,8},'97:copyto-uint8-plain-scalar')
cases=cases+1
end
-- case 98: copyto-uint8-plain-full
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=base
local src=np.array({{0.5,1.5,2.5,3.5},{4.5,5.5,6.5,7.5},{8.5,9.5,10.5,11.5}},'float64')
np.copyto(v,src,'unsafe',true)
check(base,{0,1,2,3,4,5,6,7,8,9,10,11},'98:copyto-uint8-plain-full')
cases=cases+1
end
-- case 99: copyto-uint8-plain-alias
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=base
local src=base
np.copyto(v,src,'same_kind',true)
check(base,{0,1,2,3,4,5,6,7,8,9,10,11},'99:copyto-uint8-plain-alias')
cases=cases+1
end
-- case 100: copyto-uint8-plain-masked_scalar
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=base
local src=99
np.copyto(v,src,'same_kind',false)
check(base,{0,1,2,3,4,5,6,7,8,9,10,11},'100:copyto-uint8-plain-masked_scalar')
cases=cases+1
end
-- case 101: copyto-uint8-revcols-scalar
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,2)
local src=8
np.copyto(v,src,'same_kind',true)
check(base,{8,8,8,8,8,8,8,8,8,8,8,8},'101:copyto-uint8-revcols-scalar')
cases=cases+1
end
-- case 102: copyto-uint8-revcols-full
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,2)
local src=np.array({{0.5,1.5,2.5,3.5},{4.5,5.5,6.5,7.5},{8.5,9.5,10.5,11.5}},'float64')
np.copyto(v,src,'unsafe',true)
check(base,{3,2,1,0,7,6,5,4,11,10,9,8},'102:copyto-uint8-revcols-full')
cases=cases+1
end
-- case 103: copyto-uint8-revcols-alias
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,2)
local src=base
np.copyto(v,src,'same_kind',true)
check(base,{3,2,1,0,7,6,5,4,11,10,9,8},'103:copyto-uint8-revcols-alias')
cases=cases+1
end
-- case 104: copyto-uint8-revcols-masked_scalar
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,2)
local src=99
np.copyto(v,src,'same_kind',false)
check(base,{0,1,2,3,4,5,6,7,8,9,10,11},'104:copyto-uint8-revcols-masked_scalar')
cases=cases+1
end
-- case 105: copyto-uint8-transpose-scalar
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.transpose(base)
local src=8
np.copyto(v,src,'same_kind',true)
check(base,{8,8,8,8,8,8,8,8,8,8,8,8},'105:copyto-uint8-transpose-scalar')
cases=cases+1
end
-- case 106: copyto-uint8-transpose-full
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.transpose(base)
local src=np.array({{0.5,1.5,2.5},{3.5,4.5,5.5},{6.5,7.5,8.5},{9.5,10.5,11.5}},'float64')
np.copyto(v,src,'unsafe',true)
check(base,{0,3,6,9,1,4,7,10,2,5,8,11},'106:copyto-uint8-transpose-full')
cases=cases+1
end
-- case 107: copyto-uint8-transpose-alias
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.transpose(base)
local src=np.transpose(base)
np.copyto(v,src,'same_kind',true)
check(base,{0,1,2,3,4,5,6,7,8,9,10,11},'107:copyto-uint8-transpose-alias')
cases=cases+1
end
-- case 108: copyto-uint8-transpose-masked_scalar
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.transpose(base)
local src=99
np.copyto(v,src,'same_kind',false)
check(base,{0,1,2,3,4,5,6,7,8,9,10,11},'108:copyto-uint8-transpose-masked_scalar')
cases=cases+1
end
-- case 109: copyto-uint8-revrows-scalar
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,1)
local src=8
np.copyto(v,src,'same_kind',true)
check(base,{8,8,8,8,8,8,8,8,8,8,8,8},'109:copyto-uint8-revrows-scalar')
cases=cases+1
end
-- case 110: copyto-uint8-revrows-full
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,1)
local src=np.array({{0.5,1.5,2.5,3.5},{4.5,5.5,6.5,7.5},{8.5,9.5,10.5,11.5}},'float64')
np.copyto(v,src,'unsafe',true)
check(base,{8,9,10,11,4,5,6,7,0,1,2,3},'110:copyto-uint8-revrows-full')
cases=cases+1
end
-- case 111: copyto-uint8-revrows-alias
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,1)
local src=base
np.copyto(v,src,'same_kind',true)
check(base,{8,9,10,11,4,5,6,7,0,1,2,3},'111:copyto-uint8-revrows-alias')
cases=cases+1
end
-- case 112: copyto-uint8-revrows-masked_scalar
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,1)
local src=99
np.copyto(v,src,'same_kind',false)
check(base,{0,1,2,3,4,5,6,7,8,9,10,11},'112:copyto-uint8-revrows-masked_scalar')
cases=cases+1
end
-- case 113: putmask-int32-plain-vals1-step2
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20},'int16'))
check(base,{20,1,20,3,20,5,20,7,20,9,20,11},'113:putmask-int32-plain-vals1-step2')
cases=cases+1
end
-- case 114: putmask-int32-plain-vals1-step3
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20},'int16'))
check(base,{20,1,2,20,4,5,20,7,8,20,10,11},'114:putmask-int32-plain-vals1-step3')
cases=cases+1
end
-- case 115: putmask-int32-plain-vals2-step2
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21},'int16'))
check(base,{20,1,20,3,20,5,20,7,20,9,20,11},'115:putmask-int32-plain-vals2-step2')
cases=cases+1
end
-- case 116: putmask-int32-plain-vals2-step3
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21},'int16'))
check(base,{20,1,2,21,4,5,20,7,8,21,10,11},'116:putmask-int32-plain-vals2-step3')
cases=cases+1
end
-- case 117: putmask-int32-plain-vals3-step2
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{20,1,22,3,21,5,20,7,22,9,21,11},'117:putmask-int32-plain-vals3-step2')
cases=cases+1
end
-- case 118: putmask-int32-plain-vals3-step3
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{20,1,2,20,4,5,20,7,8,20,10,11},'118:putmask-int32-plain-vals3-step3')
cases=cases+1
end
-- case 119: putmask-int32-plain-vals7-step2
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{20,1,22,3,24,5,26,7,21,9,23,11},'119:putmask-int32-plain-vals7-step2')
cases=cases+1
end
-- case 120: putmask-int32-plain-vals7-step3
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{20,1,2,23,4,5,26,7,8,22,10,11},'120:putmask-int32-plain-vals7-step3')
cases=cases+1
end
-- case 121: putmask-int32-plain-vals15-step2
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{20,1,22,3,24,5,26,7,28,9,30,11},'121:putmask-int32-plain-vals15-step2')
cases=cases+1
end
-- case 122: putmask-int32-plain-vals15-step3
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{20,1,2,23,4,5,26,7,8,29,10,11},'122:putmask-int32-plain-vals15-step3')
cases=cases+1
end
-- case 123: putmask-int32-revcols-vals1-step2
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20},'int16'))
check(base,{0,20,2,20,4,20,6,20,8,20,10,20},'123:putmask-int32-revcols-vals1-step2')
cases=cases+1
end
-- case 124: putmask-int32-revcols-vals1-step3
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20},'int16'))
check(base,{20,1,2,20,4,20,6,7,8,9,20,11},'124:putmask-int32-revcols-vals1-step3')
cases=cases+1
end
-- case 125: putmask-int32-revcols-vals2-step2
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21},'int16'))
check(base,{0,20,2,20,4,20,6,20,8,20,10,20},'125:putmask-int32-revcols-vals2-step2')
cases=cases+1
end
-- case 126: putmask-int32-revcols-vals2-step3
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21},'int16'))
check(base,{21,1,2,20,4,20,6,7,8,9,21,11},'126:putmask-int32-revcols-vals2-step3')
cases=cases+1
end
-- case 127: putmask-int32-revcols-vals3-step2
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{0,22,2,20,4,20,6,21,8,21,10,22},'127:putmask-int32-revcols-vals3-step2')
cases=cases+1
end
-- case 128: putmask-int32-revcols-vals3-step3
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{20,1,2,20,4,20,6,7,8,9,20,11},'128:putmask-int32-revcols-vals3-step3')
cases=cases+1
end
-- case 129: putmask-int32-revcols-vals7-step2
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{0,22,2,20,4,26,6,24,8,23,10,21},'129:putmask-int32-revcols-vals7-step2')
cases=cases+1
end
-- case 130: putmask-int32-revcols-vals7-step3
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{23,1,2,20,4,26,6,7,8,9,22,11},'130:putmask-int32-revcols-vals7-step3')
cases=cases+1
end
-- case 131: putmask-int32-revcols-vals15-step2
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{0,22,2,20,4,26,6,24,8,30,10,28},'131:putmask-int32-revcols-vals15-step2')
cases=cases+1
end
-- case 132: putmask-int32-revcols-vals15-step3
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{23,1,2,20,4,26,6,7,8,9,29,11},'132:putmask-int32-revcols-vals15-step3')
cases=cases+1
end
-- case 133: putmask-int32-transpose-vals1-step2
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,true},{false,true,false},{true,false,true},{false,true,false}},'bool'),np.array({20},'int16'))
check(base,{20,1,20,3,4,20,6,20,20,9,20,11},'133:putmask-int32-transpose-vals1-step2')
cases=cases+1
end
-- case 134: putmask-int32-transpose-vals1-step3
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,false},{true,false,false},{true,false,false},{true,false,false}},'bool'),np.array({20},'int16'))
check(base,{20,20,20,20,4,5,6,7,8,9,10,11},'134:putmask-int32-transpose-vals1-step3')
cases=cases+1
end
-- case 135: putmask-int32-transpose-vals2-step2
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,true},{false,true,false},{true,false,true},{false,true,false}},'bool'),np.array({20,21},'int16'))
check(base,{20,1,20,3,4,20,6,20,20,9,20,11},'135:putmask-int32-transpose-vals2-step2')
cases=cases+1
end
-- case 136: putmask-int32-transpose-vals2-step3
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,false},{true,false,false},{true,false,false},{true,false,false}},'bool'),np.array({20,21},'int16'))
check(base,{20,21,20,21,4,5,6,7,8,9,10,11},'136:putmask-int32-transpose-vals2-step3')
cases=cases+1
end
-- case 137: putmask-int32-transpose-vals3-step2
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,true},{false,true,false},{true,false,true},{false,true,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{20,1,20,3,4,21,6,21,22,9,22,11},'137:putmask-int32-transpose-vals3-step2')
cases=cases+1
end
-- case 138: putmask-int32-transpose-vals3-step3
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,false},{true,false,false},{true,false,false},{true,false,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{20,20,20,20,4,5,6,7,8,9,10,11},'138:putmask-int32-transpose-vals3-step3')
cases=cases+1
end
-- case 139: putmask-int32-transpose-vals7-step2
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,true},{false,true,false},{true,false,true},{false,true,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{20,1,26,3,4,24,6,23,22,9,21,11},'139:putmask-int32-transpose-vals7-step2')
cases=cases+1
end
-- case 140: putmask-int32-transpose-vals7-step3
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,false},{true,false,false},{true,false,false},{true,false,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{20,23,26,22,4,5,6,7,8,9,10,11},'140:putmask-int32-transpose-vals7-step3')
cases=cases+1
end
-- case 141: putmask-int32-transpose-vals15-step2
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,true},{false,true,false},{true,false,true},{false,true,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{20,1,26,3,4,24,6,30,22,9,28,11},'141:putmask-int32-transpose-vals15-step2')
cases=cases+1
end
-- case 142: putmask-int32-transpose-vals15-step3
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,false},{true,false,false},{true,false,false},{true,false,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{20,23,26,29,4,5,6,7,8,9,10,11},'142:putmask-int32-transpose-vals15-step3')
cases=cases+1
end
-- case 143: putmask-int32-revrows-vals1-step2
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20},'int16'))
check(base,{20,1,20,3,20,5,20,7,20,9,20,11},'143:putmask-int32-revrows-vals1-step2')
cases=cases+1
end
-- case 144: putmask-int32-revrows-vals1-step3
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20},'int16'))
check(base,{0,20,2,3,4,5,20,7,20,9,10,20},'144:putmask-int32-revrows-vals1-step3')
cases=cases+1
end
-- case 145: putmask-int32-revrows-vals2-step2
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21},'int16'))
check(base,{20,1,20,3,20,5,20,7,20,9,20,11},'145:putmask-int32-revrows-vals2-step2')
cases=cases+1
end
-- case 146: putmask-int32-revrows-vals2-step3
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21},'int16'))
check(base,{0,21,2,3,4,5,20,7,20,9,10,21},'146:putmask-int32-revrows-vals2-step3')
cases=cases+1
end
-- case 147: putmask-int32-revrows-vals3-step2
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{22,1,21,3,21,5,20,7,20,9,22,11},'147:putmask-int32-revrows-vals3-step2')
cases=cases+1
end
-- case 148: putmask-int32-revrows-vals3-step3
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{0,20,2,3,4,5,20,7,20,9,10,20},'148:putmask-int32-revrows-vals3-step3')
cases=cases+1
end
-- case 149: putmask-int32-revrows-vals7-step2
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{21,1,23,3,24,5,26,7,20,9,22,11},'149:putmask-int32-revrows-vals7-step2')
cases=cases+1
end
-- case 150: putmask-int32-revrows-vals7-step3
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{0,22,2,3,4,5,26,7,20,9,10,23},'150:putmask-int32-revrows-vals7-step3')
cases=cases+1
end
-- case 151: putmask-int32-revrows-vals15-step2
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{28,1,30,3,24,5,26,7,20,9,22,11},'151:putmask-int32-revrows-vals15-step2')
cases=cases+1
end
-- case 152: putmask-int32-revrows-vals15-step3
do
local base=np.arange(12,'int32'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{0,29,2,3,4,5,26,7,20,9,10,23},'152:putmask-int32-revrows-vals15-step3')
cases=cases+1
end
-- case 153: putmask-float32-plain-vals1-step2
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20},'int16'))
check(base,{20.0,1.0,20.0,3.0,20.0,5.0,20.0,7.0,20.0,9.0,20.0,11.0},'153:putmask-float32-plain-vals1-step2')
cases=cases+1
end
-- case 154: putmask-float32-plain-vals1-step3
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20},'int16'))
check(base,{20.0,1.0,2.0,20.0,4.0,5.0,20.0,7.0,8.0,20.0,10.0,11.0},'154:putmask-float32-plain-vals1-step3')
cases=cases+1
end
-- case 155: putmask-float32-plain-vals2-step2
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21},'int16'))
check(base,{20.0,1.0,20.0,3.0,20.0,5.0,20.0,7.0,20.0,9.0,20.0,11.0},'155:putmask-float32-plain-vals2-step2')
cases=cases+1
end
-- case 156: putmask-float32-plain-vals2-step3
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21},'int16'))
check(base,{20.0,1.0,2.0,21.0,4.0,5.0,20.0,7.0,8.0,21.0,10.0,11.0},'156:putmask-float32-plain-vals2-step3')
cases=cases+1
end
-- case 157: putmask-float32-plain-vals3-step2
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{20.0,1.0,22.0,3.0,21.0,5.0,20.0,7.0,22.0,9.0,21.0,11.0},'157:putmask-float32-plain-vals3-step2')
cases=cases+1
end
-- case 158: putmask-float32-plain-vals3-step3
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{20.0,1.0,2.0,20.0,4.0,5.0,20.0,7.0,8.0,20.0,10.0,11.0},'158:putmask-float32-plain-vals3-step3')
cases=cases+1
end
-- case 159: putmask-float32-plain-vals7-step2
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{20.0,1.0,22.0,3.0,24.0,5.0,26.0,7.0,21.0,9.0,23.0,11.0},'159:putmask-float32-plain-vals7-step2')
cases=cases+1
end
-- case 160: putmask-float32-plain-vals7-step3
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{20.0,1.0,2.0,23.0,4.0,5.0,26.0,7.0,8.0,22.0,10.0,11.0},'160:putmask-float32-plain-vals7-step3')
cases=cases+1
end
-- case 161: putmask-float32-plain-vals15-step2
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{20.0,1.0,22.0,3.0,24.0,5.0,26.0,7.0,28.0,9.0,30.0,11.0},'161:putmask-float32-plain-vals15-step2')
cases=cases+1
end
-- case 162: putmask-float32-plain-vals15-step3
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{20.0,1.0,2.0,23.0,4.0,5.0,26.0,7.0,8.0,29.0,10.0,11.0},'162:putmask-float32-plain-vals15-step3')
cases=cases+1
end
-- case 163: putmask-float32-revcols-vals1-step2
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20},'int16'))
check(base,{0.0,20.0,2.0,20.0,4.0,20.0,6.0,20.0,8.0,20.0,10.0,20.0},'163:putmask-float32-revcols-vals1-step2')
cases=cases+1
end
-- case 164: putmask-float32-revcols-vals1-step3
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20},'int16'))
check(base,{20.0,1.0,2.0,20.0,4.0,20.0,6.0,7.0,8.0,9.0,20.0,11.0},'164:putmask-float32-revcols-vals1-step3')
cases=cases+1
end
-- case 165: putmask-float32-revcols-vals2-step2
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21},'int16'))
check(base,{0.0,20.0,2.0,20.0,4.0,20.0,6.0,20.0,8.0,20.0,10.0,20.0},'165:putmask-float32-revcols-vals2-step2')
cases=cases+1
end
-- case 166: putmask-float32-revcols-vals2-step3
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21},'int16'))
check(base,{21.0,1.0,2.0,20.0,4.0,20.0,6.0,7.0,8.0,9.0,21.0,11.0},'166:putmask-float32-revcols-vals2-step3')
cases=cases+1
end
-- case 167: putmask-float32-revcols-vals3-step2
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{0.0,22.0,2.0,20.0,4.0,20.0,6.0,21.0,8.0,21.0,10.0,22.0},'167:putmask-float32-revcols-vals3-step2')
cases=cases+1
end
-- case 168: putmask-float32-revcols-vals3-step3
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{20.0,1.0,2.0,20.0,4.0,20.0,6.0,7.0,8.0,9.0,20.0,11.0},'168:putmask-float32-revcols-vals3-step3')
cases=cases+1
end
-- case 169: putmask-float32-revcols-vals7-step2
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{0.0,22.0,2.0,20.0,4.0,26.0,6.0,24.0,8.0,23.0,10.0,21.0},'169:putmask-float32-revcols-vals7-step2')
cases=cases+1
end
-- case 170: putmask-float32-revcols-vals7-step3
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{23.0,1.0,2.0,20.0,4.0,26.0,6.0,7.0,8.0,9.0,22.0,11.0},'170:putmask-float32-revcols-vals7-step3')
cases=cases+1
end
-- case 171: putmask-float32-revcols-vals15-step2
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{0.0,22.0,2.0,20.0,4.0,26.0,6.0,24.0,8.0,30.0,10.0,28.0},'171:putmask-float32-revcols-vals15-step2')
cases=cases+1
end
-- case 172: putmask-float32-revcols-vals15-step3
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{23.0,1.0,2.0,20.0,4.0,26.0,6.0,7.0,8.0,9.0,29.0,11.0},'172:putmask-float32-revcols-vals15-step3')
cases=cases+1
end
-- case 173: putmask-float32-transpose-vals1-step2
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,true},{false,true,false},{true,false,true},{false,true,false}},'bool'),np.array({20},'int16'))
check(base,{20.0,1.0,20.0,3.0,4.0,20.0,6.0,20.0,20.0,9.0,20.0,11.0},'173:putmask-float32-transpose-vals1-step2')
cases=cases+1
end
-- case 174: putmask-float32-transpose-vals1-step3
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,false},{true,false,false},{true,false,false},{true,false,false}},'bool'),np.array({20},'int16'))
check(base,{20.0,20.0,20.0,20.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},'174:putmask-float32-transpose-vals1-step3')
cases=cases+1
end
-- case 175: putmask-float32-transpose-vals2-step2
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,true},{false,true,false},{true,false,true},{false,true,false}},'bool'),np.array({20,21},'int16'))
check(base,{20.0,1.0,20.0,3.0,4.0,20.0,6.0,20.0,20.0,9.0,20.0,11.0},'175:putmask-float32-transpose-vals2-step2')
cases=cases+1
end
-- case 176: putmask-float32-transpose-vals2-step3
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,false},{true,false,false},{true,false,false},{true,false,false}},'bool'),np.array({20,21},'int16'))
check(base,{20.0,21.0,20.0,21.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},'176:putmask-float32-transpose-vals2-step3')
cases=cases+1
end
-- case 177: putmask-float32-transpose-vals3-step2
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,true},{false,true,false},{true,false,true},{false,true,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{20.0,1.0,20.0,3.0,4.0,21.0,6.0,21.0,22.0,9.0,22.0,11.0},'177:putmask-float32-transpose-vals3-step2')
cases=cases+1
end
-- case 178: putmask-float32-transpose-vals3-step3
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,false},{true,false,false},{true,false,false},{true,false,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{20.0,20.0,20.0,20.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},'178:putmask-float32-transpose-vals3-step3')
cases=cases+1
end
-- case 179: putmask-float32-transpose-vals7-step2
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,true},{false,true,false},{true,false,true},{false,true,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{20.0,1.0,26.0,3.0,4.0,24.0,6.0,23.0,22.0,9.0,21.0,11.0},'179:putmask-float32-transpose-vals7-step2')
cases=cases+1
end
-- case 180: putmask-float32-transpose-vals7-step3
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,false},{true,false,false},{true,false,false},{true,false,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{20.0,23.0,26.0,22.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},'180:putmask-float32-transpose-vals7-step3')
cases=cases+1
end
-- case 181: putmask-float32-transpose-vals15-step2
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,true},{false,true,false},{true,false,true},{false,true,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{20.0,1.0,26.0,3.0,4.0,24.0,6.0,30.0,22.0,9.0,28.0,11.0},'181:putmask-float32-transpose-vals15-step2')
cases=cases+1
end
-- case 182: putmask-float32-transpose-vals15-step3
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,false},{true,false,false},{true,false,false},{true,false,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{20.0,23.0,26.0,29.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},'182:putmask-float32-transpose-vals15-step3')
cases=cases+1
end
-- case 183: putmask-float32-revrows-vals1-step2
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20},'int16'))
check(base,{20.0,1.0,20.0,3.0,20.0,5.0,20.0,7.0,20.0,9.0,20.0,11.0},'183:putmask-float32-revrows-vals1-step2')
cases=cases+1
end
-- case 184: putmask-float32-revrows-vals1-step3
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20},'int16'))
check(base,{0.0,20.0,2.0,3.0,4.0,5.0,20.0,7.0,20.0,9.0,10.0,20.0},'184:putmask-float32-revrows-vals1-step3')
cases=cases+1
end
-- case 185: putmask-float32-revrows-vals2-step2
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21},'int16'))
check(base,{20.0,1.0,20.0,3.0,20.0,5.0,20.0,7.0,20.0,9.0,20.0,11.0},'185:putmask-float32-revrows-vals2-step2')
cases=cases+1
end
-- case 186: putmask-float32-revrows-vals2-step3
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21},'int16'))
check(base,{0.0,21.0,2.0,3.0,4.0,5.0,20.0,7.0,20.0,9.0,10.0,21.0},'186:putmask-float32-revrows-vals2-step3')
cases=cases+1
end
-- case 187: putmask-float32-revrows-vals3-step2
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{22.0,1.0,21.0,3.0,21.0,5.0,20.0,7.0,20.0,9.0,22.0,11.0},'187:putmask-float32-revrows-vals3-step2')
cases=cases+1
end
-- case 188: putmask-float32-revrows-vals3-step3
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{0.0,20.0,2.0,3.0,4.0,5.0,20.0,7.0,20.0,9.0,10.0,20.0},'188:putmask-float32-revrows-vals3-step3')
cases=cases+1
end
-- case 189: putmask-float32-revrows-vals7-step2
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{21.0,1.0,23.0,3.0,24.0,5.0,26.0,7.0,20.0,9.0,22.0,11.0},'189:putmask-float32-revrows-vals7-step2')
cases=cases+1
end
-- case 190: putmask-float32-revrows-vals7-step3
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{0.0,22.0,2.0,3.0,4.0,5.0,26.0,7.0,20.0,9.0,10.0,23.0},'190:putmask-float32-revrows-vals7-step3')
cases=cases+1
end
-- case 191: putmask-float32-revrows-vals15-step2
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{28.0,1.0,30.0,3.0,24.0,5.0,26.0,7.0,20.0,9.0,22.0,11.0},'191:putmask-float32-revrows-vals15-step2')
cases=cases+1
end
-- case 192: putmask-float32-revrows-vals15-step3
do
local base=np.arange(12,'float32'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{0.0,29.0,2.0,3.0,4.0,5.0,26.0,7.0,20.0,9.0,10.0,23.0},'192:putmask-float32-revrows-vals15-step3')
cases=cases+1
end
-- case 193: putmask-float64-plain-vals1-step2
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20},'int16'))
check(base,{20.0,1.0,20.0,3.0,20.0,5.0,20.0,7.0,20.0,9.0,20.0,11.0},'193:putmask-float64-plain-vals1-step2')
cases=cases+1
end
-- case 194: putmask-float64-plain-vals1-step3
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20},'int16'))
check(base,{20.0,1.0,2.0,20.0,4.0,5.0,20.0,7.0,8.0,20.0,10.0,11.0},'194:putmask-float64-plain-vals1-step3')
cases=cases+1
end
-- case 195: putmask-float64-plain-vals2-step2
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21},'int16'))
check(base,{20.0,1.0,20.0,3.0,20.0,5.0,20.0,7.0,20.0,9.0,20.0,11.0},'195:putmask-float64-plain-vals2-step2')
cases=cases+1
end
-- case 196: putmask-float64-plain-vals2-step3
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21},'int16'))
check(base,{20.0,1.0,2.0,21.0,4.0,5.0,20.0,7.0,8.0,21.0,10.0,11.0},'196:putmask-float64-plain-vals2-step3')
cases=cases+1
end
-- case 197: putmask-float64-plain-vals3-step2
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{20.0,1.0,22.0,3.0,21.0,5.0,20.0,7.0,22.0,9.0,21.0,11.0},'197:putmask-float64-plain-vals3-step2')
cases=cases+1
end
-- case 198: putmask-float64-plain-vals3-step3
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{20.0,1.0,2.0,20.0,4.0,5.0,20.0,7.0,8.0,20.0,10.0,11.0},'198:putmask-float64-plain-vals3-step3')
cases=cases+1
end
-- case 199: putmask-float64-plain-vals7-step2
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{20.0,1.0,22.0,3.0,24.0,5.0,26.0,7.0,21.0,9.0,23.0,11.0},'199:putmask-float64-plain-vals7-step2')
cases=cases+1
end
-- case 200: putmask-float64-plain-vals7-step3
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{20.0,1.0,2.0,23.0,4.0,5.0,26.0,7.0,8.0,22.0,10.0,11.0},'200:putmask-float64-plain-vals7-step3')
cases=cases+1
end
-- case 201: putmask-float64-plain-vals15-step2
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{20.0,1.0,22.0,3.0,24.0,5.0,26.0,7.0,28.0,9.0,30.0,11.0},'201:putmask-float64-plain-vals15-step2')
cases=cases+1
end
-- case 202: putmask-float64-plain-vals15-step3
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{20.0,1.0,2.0,23.0,4.0,5.0,26.0,7.0,8.0,29.0,10.0,11.0},'202:putmask-float64-plain-vals15-step3')
cases=cases+1
end
-- case 203: putmask-float64-revcols-vals1-step2
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20},'int16'))
check(base,{0.0,20.0,2.0,20.0,4.0,20.0,6.0,20.0,8.0,20.0,10.0,20.0},'203:putmask-float64-revcols-vals1-step2')
cases=cases+1
end
-- case 204: putmask-float64-revcols-vals1-step3
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20},'int16'))
check(base,{20.0,1.0,2.0,20.0,4.0,20.0,6.0,7.0,8.0,9.0,20.0,11.0},'204:putmask-float64-revcols-vals1-step3')
cases=cases+1
end
-- case 205: putmask-float64-revcols-vals2-step2
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21},'int16'))
check(base,{0.0,20.0,2.0,20.0,4.0,20.0,6.0,20.0,8.0,20.0,10.0,20.0},'205:putmask-float64-revcols-vals2-step2')
cases=cases+1
end
-- case 206: putmask-float64-revcols-vals2-step3
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21},'int16'))
check(base,{21.0,1.0,2.0,20.0,4.0,20.0,6.0,7.0,8.0,9.0,21.0,11.0},'206:putmask-float64-revcols-vals2-step3')
cases=cases+1
end
-- case 207: putmask-float64-revcols-vals3-step2
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{0.0,22.0,2.0,20.0,4.0,20.0,6.0,21.0,8.0,21.0,10.0,22.0},'207:putmask-float64-revcols-vals3-step2')
cases=cases+1
end
-- case 208: putmask-float64-revcols-vals3-step3
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{20.0,1.0,2.0,20.0,4.0,20.0,6.0,7.0,8.0,9.0,20.0,11.0},'208:putmask-float64-revcols-vals3-step3')
cases=cases+1
end
-- case 209: putmask-float64-revcols-vals7-step2
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{0.0,22.0,2.0,20.0,4.0,26.0,6.0,24.0,8.0,23.0,10.0,21.0},'209:putmask-float64-revcols-vals7-step2')
cases=cases+1
end
-- case 210: putmask-float64-revcols-vals7-step3
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{23.0,1.0,2.0,20.0,4.0,26.0,6.0,7.0,8.0,9.0,22.0,11.0},'210:putmask-float64-revcols-vals7-step3')
cases=cases+1
end
-- case 211: putmask-float64-revcols-vals15-step2
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{0.0,22.0,2.0,20.0,4.0,26.0,6.0,24.0,8.0,30.0,10.0,28.0},'211:putmask-float64-revcols-vals15-step2')
cases=cases+1
end
-- case 212: putmask-float64-revcols-vals15-step3
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{23.0,1.0,2.0,20.0,4.0,26.0,6.0,7.0,8.0,9.0,29.0,11.0},'212:putmask-float64-revcols-vals15-step3')
cases=cases+1
end
-- case 213: putmask-float64-transpose-vals1-step2
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,true},{false,true,false},{true,false,true},{false,true,false}},'bool'),np.array({20},'int16'))
check(base,{20.0,1.0,20.0,3.0,4.0,20.0,6.0,20.0,20.0,9.0,20.0,11.0},'213:putmask-float64-transpose-vals1-step2')
cases=cases+1
end
-- case 214: putmask-float64-transpose-vals1-step3
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,false},{true,false,false},{true,false,false},{true,false,false}},'bool'),np.array({20},'int16'))
check(base,{20.0,20.0,20.0,20.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},'214:putmask-float64-transpose-vals1-step3')
cases=cases+1
end
-- case 215: putmask-float64-transpose-vals2-step2
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,true},{false,true,false},{true,false,true},{false,true,false}},'bool'),np.array({20,21},'int16'))
check(base,{20.0,1.0,20.0,3.0,4.0,20.0,6.0,20.0,20.0,9.0,20.0,11.0},'215:putmask-float64-transpose-vals2-step2')
cases=cases+1
end
-- case 216: putmask-float64-transpose-vals2-step3
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,false},{true,false,false},{true,false,false},{true,false,false}},'bool'),np.array({20,21},'int16'))
check(base,{20.0,21.0,20.0,21.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},'216:putmask-float64-transpose-vals2-step3')
cases=cases+1
end
-- case 217: putmask-float64-transpose-vals3-step2
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,true},{false,true,false},{true,false,true},{false,true,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{20.0,1.0,20.0,3.0,4.0,21.0,6.0,21.0,22.0,9.0,22.0,11.0},'217:putmask-float64-transpose-vals3-step2')
cases=cases+1
end
-- case 218: putmask-float64-transpose-vals3-step3
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,false},{true,false,false},{true,false,false},{true,false,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{20.0,20.0,20.0,20.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},'218:putmask-float64-transpose-vals3-step3')
cases=cases+1
end
-- case 219: putmask-float64-transpose-vals7-step2
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,true},{false,true,false},{true,false,true},{false,true,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{20.0,1.0,26.0,3.0,4.0,24.0,6.0,23.0,22.0,9.0,21.0,11.0},'219:putmask-float64-transpose-vals7-step2')
cases=cases+1
end
-- case 220: putmask-float64-transpose-vals7-step3
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,false},{true,false,false},{true,false,false},{true,false,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{20.0,23.0,26.0,22.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},'220:putmask-float64-transpose-vals7-step3')
cases=cases+1
end
-- case 221: putmask-float64-transpose-vals15-step2
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,true},{false,true,false},{true,false,true},{false,true,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{20.0,1.0,26.0,3.0,4.0,24.0,6.0,30.0,22.0,9.0,28.0,11.0},'221:putmask-float64-transpose-vals15-step2')
cases=cases+1
end
-- case 222: putmask-float64-transpose-vals15-step3
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,false},{true,false,false},{true,false,false},{true,false,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{20.0,23.0,26.0,29.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0},'222:putmask-float64-transpose-vals15-step3')
cases=cases+1
end
-- case 223: putmask-float64-revrows-vals1-step2
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20},'int16'))
check(base,{20.0,1.0,20.0,3.0,20.0,5.0,20.0,7.0,20.0,9.0,20.0,11.0},'223:putmask-float64-revrows-vals1-step2')
cases=cases+1
end
-- case 224: putmask-float64-revrows-vals1-step3
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20},'int16'))
check(base,{0.0,20.0,2.0,3.0,4.0,5.0,20.0,7.0,20.0,9.0,10.0,20.0},'224:putmask-float64-revrows-vals1-step3')
cases=cases+1
end
-- case 225: putmask-float64-revrows-vals2-step2
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21},'int16'))
check(base,{20.0,1.0,20.0,3.0,20.0,5.0,20.0,7.0,20.0,9.0,20.0,11.0},'225:putmask-float64-revrows-vals2-step2')
cases=cases+1
end
-- case 226: putmask-float64-revrows-vals2-step3
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21},'int16'))
check(base,{0.0,21.0,2.0,3.0,4.0,5.0,20.0,7.0,20.0,9.0,10.0,21.0},'226:putmask-float64-revrows-vals2-step3')
cases=cases+1
end
-- case 227: putmask-float64-revrows-vals3-step2
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{22.0,1.0,21.0,3.0,21.0,5.0,20.0,7.0,20.0,9.0,22.0,11.0},'227:putmask-float64-revrows-vals3-step2')
cases=cases+1
end
-- case 228: putmask-float64-revrows-vals3-step3
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22},'int16'))
check(base,{0.0,20.0,2.0,3.0,4.0,5.0,20.0,7.0,20.0,9.0,10.0,20.0},'228:putmask-float64-revrows-vals3-step3')
cases=cases+1
end
-- case 229: putmask-float64-revrows-vals7-step2
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{21.0,1.0,23.0,3.0,24.0,5.0,26.0,7.0,20.0,9.0,22.0,11.0},'229:putmask-float64-revrows-vals7-step2')
cases=cases+1
end
-- case 230: putmask-float64-revrows-vals7-step3
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26},'int16'))
check(base,{0.0,22.0,2.0,3.0,4.0,5.0,26.0,7.0,20.0,9.0,10.0,23.0},'230:putmask-float64-revrows-vals7-step3')
cases=cases+1
end
-- case 231: putmask-float64-revrows-vals15-step2
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{28.0,1.0,30.0,3.0,24.0,5.0,26.0,7.0,20.0,9.0,22.0,11.0},'231:putmask-float64-revrows-vals15-step2')
cases=cases+1
end
-- case 232: putmask-float64-revrows-vals15-step3
do
local base=np.arange(12,'float64'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'int16'))
check(base,{0.0,29.0,2.0,3.0,4.0,5.0,26.0,7.0,20.0,9.0,10.0,23.0},'232:putmask-float64-revrows-vals15-step3')
cases=cases+1
end
-- case 233: putmask-uint8-plain-vals1-step2
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20},'uint8'))
check(base,{20,1,20,3,20,5,20,7,20,9,20,11},'233:putmask-uint8-plain-vals1-step2')
cases=cases+1
end
-- case 234: putmask-uint8-plain-vals1-step3
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20},'uint8'))
check(base,{20,1,2,20,4,5,20,7,8,20,10,11},'234:putmask-uint8-plain-vals1-step3')
cases=cases+1
end
-- case 235: putmask-uint8-plain-vals2-step2
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21},'uint8'))
check(base,{20,1,20,3,20,5,20,7,20,9,20,11},'235:putmask-uint8-plain-vals2-step2')
cases=cases+1
end
-- case 236: putmask-uint8-plain-vals2-step3
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21},'uint8'))
check(base,{20,1,2,21,4,5,20,7,8,21,10,11},'236:putmask-uint8-plain-vals2-step3')
cases=cases+1
end
-- case 237: putmask-uint8-plain-vals3-step2
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22},'uint8'))
check(base,{20,1,22,3,21,5,20,7,22,9,21,11},'237:putmask-uint8-plain-vals3-step2')
cases=cases+1
end
-- case 238: putmask-uint8-plain-vals3-step3
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22},'uint8'))
check(base,{20,1,2,20,4,5,20,7,8,20,10,11},'238:putmask-uint8-plain-vals3-step3')
cases=cases+1
end
-- case 239: putmask-uint8-plain-vals7-step2
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26},'uint8'))
check(base,{20,1,22,3,24,5,26,7,21,9,23,11},'239:putmask-uint8-plain-vals7-step2')
cases=cases+1
end
-- case 240: putmask-uint8-plain-vals7-step3
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26},'uint8'))
check(base,{20,1,2,23,4,5,26,7,8,22,10,11},'240:putmask-uint8-plain-vals7-step3')
cases=cases+1
end
-- case 241: putmask-uint8-plain-vals15-step2
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'uint8'))
check(base,{20,1,22,3,24,5,26,7,28,9,30,11},'241:putmask-uint8-plain-vals15-step2')
cases=cases+1
end
-- case 242: putmask-uint8-plain-vals15-step3
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=base
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'uint8'))
check(base,{20,1,2,23,4,5,26,7,8,29,10,11},'242:putmask-uint8-plain-vals15-step3')
cases=cases+1
end
-- case 243: putmask-uint8-revcols-vals1-step2
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20},'uint8'))
check(base,{0,20,2,20,4,20,6,20,8,20,10,20},'243:putmask-uint8-revcols-vals1-step2')
cases=cases+1
end
-- case 244: putmask-uint8-revcols-vals1-step3
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20},'uint8'))
check(base,{20,1,2,20,4,20,6,7,8,9,20,11},'244:putmask-uint8-revcols-vals1-step3')
cases=cases+1
end
-- case 245: putmask-uint8-revcols-vals2-step2
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21},'uint8'))
check(base,{0,20,2,20,4,20,6,20,8,20,10,20},'245:putmask-uint8-revcols-vals2-step2')
cases=cases+1
end
-- case 246: putmask-uint8-revcols-vals2-step3
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21},'uint8'))
check(base,{21,1,2,20,4,20,6,7,8,9,21,11},'246:putmask-uint8-revcols-vals2-step3')
cases=cases+1
end
-- case 247: putmask-uint8-revcols-vals3-step2
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22},'uint8'))
check(base,{0,22,2,20,4,20,6,21,8,21,10,22},'247:putmask-uint8-revcols-vals3-step2')
cases=cases+1
end
-- case 248: putmask-uint8-revcols-vals3-step3
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22},'uint8'))
check(base,{20,1,2,20,4,20,6,7,8,9,20,11},'248:putmask-uint8-revcols-vals3-step3')
cases=cases+1
end
-- case 249: putmask-uint8-revcols-vals7-step2
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26},'uint8'))
check(base,{0,22,2,20,4,26,6,24,8,23,10,21},'249:putmask-uint8-revcols-vals7-step2')
cases=cases+1
end
-- case 250: putmask-uint8-revcols-vals7-step3
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26},'uint8'))
check(base,{23,1,2,20,4,26,6,7,8,9,22,11},'250:putmask-uint8-revcols-vals7-step3')
cases=cases+1
end
-- case 251: putmask-uint8-revcols-vals15-step2
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'uint8'))
check(base,{0,22,2,20,4,26,6,24,8,30,10,28},'251:putmask-uint8-revcols-vals15-step2')
cases=cases+1
end
-- case 252: putmask-uint8-revcols-vals15-step3
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,2)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'uint8'))
check(base,{23,1,2,20,4,26,6,7,8,9,29,11},'252:putmask-uint8-revcols-vals15-step3')
cases=cases+1
end
-- case 253: putmask-uint8-transpose-vals1-step2
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,true},{false,true,false},{true,false,true},{false,true,false}},'bool'),np.array({20},'uint8'))
check(base,{20,1,20,3,4,20,6,20,20,9,20,11},'253:putmask-uint8-transpose-vals1-step2')
cases=cases+1
end
-- case 254: putmask-uint8-transpose-vals1-step3
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,false},{true,false,false},{true,false,false},{true,false,false}},'bool'),np.array({20},'uint8'))
check(base,{20,20,20,20,4,5,6,7,8,9,10,11},'254:putmask-uint8-transpose-vals1-step3')
cases=cases+1
end
-- case 255: putmask-uint8-transpose-vals2-step2
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,true},{false,true,false},{true,false,true},{false,true,false}},'bool'),np.array({20,21},'uint8'))
check(base,{20,1,20,3,4,20,6,20,20,9,20,11},'255:putmask-uint8-transpose-vals2-step2')
cases=cases+1
end
-- case 256: putmask-uint8-transpose-vals2-step3
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,false},{true,false,false},{true,false,false},{true,false,false}},'bool'),np.array({20,21},'uint8'))
check(base,{20,21,20,21,4,5,6,7,8,9,10,11},'256:putmask-uint8-transpose-vals2-step3')
cases=cases+1
end
-- case 257: putmask-uint8-transpose-vals3-step2
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,true},{false,true,false},{true,false,true},{false,true,false}},'bool'),np.array({20,21,22},'uint8'))
check(base,{20,1,20,3,4,21,6,21,22,9,22,11},'257:putmask-uint8-transpose-vals3-step2')
cases=cases+1
end
-- case 258: putmask-uint8-transpose-vals3-step3
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,false},{true,false,false},{true,false,false},{true,false,false}},'bool'),np.array({20,21,22},'uint8'))
check(base,{20,20,20,20,4,5,6,7,8,9,10,11},'258:putmask-uint8-transpose-vals3-step3')
cases=cases+1
end
-- case 259: putmask-uint8-transpose-vals7-step2
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,true},{false,true,false},{true,false,true},{false,true,false}},'bool'),np.array({20,21,22,23,24,25,26},'uint8'))
check(base,{20,1,26,3,4,24,6,23,22,9,21,11},'259:putmask-uint8-transpose-vals7-step2')
cases=cases+1
end
-- case 260: putmask-uint8-transpose-vals7-step3
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,false},{true,false,false},{true,false,false},{true,false,false}},'bool'),np.array({20,21,22,23,24,25,26},'uint8'))
check(base,{20,23,26,22,4,5,6,7,8,9,10,11},'260:putmask-uint8-transpose-vals7-step3')
cases=cases+1
end
-- case 261: putmask-uint8-transpose-vals15-step2
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,true},{false,true,false},{true,false,true},{false,true,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'uint8'))
check(base,{20,1,26,3,4,24,6,30,22,9,28,11},'261:putmask-uint8-transpose-vals15-step2')
cases=cases+1
end
-- case 262: putmask-uint8-transpose-vals15-step3
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.transpose(base)
np.putmask(v,np.array({{true,false,false},{true,false,false},{true,false,false},{true,false,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'uint8'))
check(base,{20,23,26,29,4,5,6,7,8,9,10,11},'262:putmask-uint8-transpose-vals15-step3')
cases=cases+1
end
-- case 263: putmask-uint8-revrows-vals1-step2
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20},'uint8'))
check(base,{20,1,20,3,20,5,20,7,20,9,20,11},'263:putmask-uint8-revrows-vals1-step2')
cases=cases+1
end
-- case 264: putmask-uint8-revrows-vals1-step3
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20},'uint8'))
check(base,{0,20,2,3,4,5,20,7,20,9,10,20},'264:putmask-uint8-revrows-vals1-step3')
cases=cases+1
end
-- case 265: putmask-uint8-revrows-vals2-step2
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21},'uint8'))
check(base,{20,1,20,3,20,5,20,7,20,9,20,11},'265:putmask-uint8-revrows-vals2-step2')
cases=cases+1
end
-- case 266: putmask-uint8-revrows-vals2-step3
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21},'uint8'))
check(base,{0,21,2,3,4,5,20,7,20,9,10,21},'266:putmask-uint8-revrows-vals2-step3')
cases=cases+1
end
-- case 267: putmask-uint8-revrows-vals3-step2
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22},'uint8'))
check(base,{22,1,21,3,21,5,20,7,20,9,22,11},'267:putmask-uint8-revrows-vals3-step2')
cases=cases+1
end
-- case 268: putmask-uint8-revrows-vals3-step3
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22},'uint8'))
check(base,{0,20,2,3,4,5,20,7,20,9,10,20},'268:putmask-uint8-revrows-vals3-step3')
cases=cases+1
end
-- case 269: putmask-uint8-revrows-vals7-step2
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26},'uint8'))
check(base,{21,1,23,3,24,5,26,7,20,9,22,11},'269:putmask-uint8-revrows-vals7-step2')
cases=cases+1
end
-- case 270: putmask-uint8-revrows-vals7-step3
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26},'uint8'))
check(base,{0,22,2,3,4,5,26,7,20,9,10,23},'270:putmask-uint8-revrows-vals7-step3')
cases=cases+1
end
-- case 271: putmask-uint8-revrows-vals15-step2
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'uint8'))
check(base,{28,1,30,3,24,5,26,7,20,9,22,11},'271:putmask-uint8-revrows-vals15-step2')
cases=cases+1
end
-- case 272: putmask-uint8-revrows-vals15-step3
do
local base=np.arange(12,'uint8'):reshape({3,4})
local v=np.flip(base,1)
np.putmask(v,np.array({{true,false,false,true},{false,false,true,false},{false,true,false,false}},'bool'),np.array({20,21,22,23,24,25,26,27,28,29,30,31,32,33,34},'uint8'))
check(base,{0,29,2,3,4,5,26,7,20,9,10,23},'272:putmask-uint8-revrows-vals15-step3')
cases=cases+1
end
-- case 273: copyto-reverse-alias
do
local base=np.arange(11,'int32')
local v=np.flip(base)
local mask=np.array({false,true,true,false,true,true,false,true,true,false,true},'bool')
np.copyto(v,base,'same_kind',mask)
check(base,{10,1,8,7,4,5,4,7,2,1,10},'273:copyto-reverse-alias')
cases=cases+1
end
-- case 274: putmask-reverse-alias
do
local base=np.arange(11,'int32')
local v=np.flip(base)
local mask=np.array({false,true,true,false,true,true,false,true,true,false,true},'bool')
np.putmask(v,mask,base)
check(base,{10,1,8,7,4,5,4,7,2,1,10},'274:putmask-reverse-alias')
cases=cases+1
end
assert(cases==274)
print('memory97 differential: 274 cases passed')
