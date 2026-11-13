local lr=require('luaray')
local checks=0
local function eq(a,b)checks=checks+1;assert(a==b,tostring(a)..' ~= '..tostring(b))end
local pieces={}
for value=0,255 do pieces[#pieces+1]=string.char(value)end
local payload=table.concat(pieces)
local a=lr.ndarray({16,16},{dtype='bool',buffer=payload})
for _,dtype in ipairs({'int8','uint8','int16','uint16','int32','uint32','int64','uint64','longlong','ulonglong','float16','float32','float64','longdouble','complex64','complex128','complex256'}) do
 local result=lr.astype(a,dtype)
 eq(lr.dtype(result.dtype).char,lr.dtype(dtype).char)
 eq(result.flags.owndata,true);eq(result.flags.writeable,true)
 eq(lr.shares_memory(result,a),false)
 for flat=0,255 do
  local value=result:get(flat//16+1,flat%16+1)
  local expected=flat==0 and 0 or 1
  if lr.dtype(dtype).kind=='c' then eq(value.real,expected);eq(value.imag,0)
  else eq(value,expected) end
 end
end
local identity=lr.astype(a,'bool')
eq(identity:tobytes(),payload);eq(identity.flags.owndata,true)
eq(a:tobytes(),payload)
local rows={}
for i=1,16 do rows[i]={};for j=1,16 do rows[i][j]=(i+j)%3~=0 end end
local mask=lr.array(rows)
local output=lr.full({16,16},9,{dtype='int16'})
lr.copyto(output,a,'unsafe',mask)
for flat=0,255 do
 local i,j=flat//16+1,flat%16+1
 local expected=rows[i][j] and (flat==0 and 0 or 1) or 9
 eq(output:get(i,j),expected)
end
for _,dtype in ipairs({'S0','U0'})do
 local words=lr.astype(a,dtype)
 for flat=0,255 do eq(words:get(flat//16+1,flat%16+1),flat==0 and 'False' or 'True')end
end
for _,pair in ipairs({{'longlong','int64'},{'ulonglong','uint64'}})do
 local x,y=lr.dtype(pair[1]),lr.dtype(pair[2])
 eq(lr.dtype(lr.promote_types(x,y)).char,x.char)
 eq(lr.dtype(lr.promote_types(y,x)).char,x.char)
 eq(lr.dtype(lr.result_type(x,y)).char,x.char)
 eq(lr.dtype(lr.result_type(y,x)).char,x.char)
end
eq(a:tobytes(),payload)
print('Boolean transfer regression: '..checks..' checks passed')
