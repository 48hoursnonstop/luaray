local lr=require('luaray')
local checks=0
local function eq(a,b)
 checks=checks+1
 if type(b)=='table' then assert(type(a)=='table' and #a==#b);for i=1,#b do eq(a[i],b[i])end
 else assert(a==b,tostring(a)..' ~= '..tostring(b))end
end
local function fails(fn)checks=checks+1;assert(not pcall(fn))end
local values=lr.array({1,0,1,0,1,0,1,0,1},'int16')
eq(lr.packbits(values):tolist(),{170,128})
eq(lr.packbits(values,{bitorder='little'}):tolist(),{85,1})
eq(lr.unpackbits(lr.packbits(values),{count=9}):tolist(),values:tolist())
eq(lr.unpackbits(lr.packbits(values),{count=-7}):tolist(),values:tolist())
eq(lr.unpackbits(lr.array({128},'uint8'),{count=10}):tolist(),{1,0,0,0,0,0,0,0,0,0})
eq(lr.unpackbits(lr.empty({0},'uint8'),{count=3}):tolist(),{0,0,0})
eq(lr.unpackbits(lr.empty({0},'uint8'),{count=0}):tolist(),{})
eq(lr.packbits(3):tolist(),{128})
eq(lr.packbits(3,1,'little'):tolist(),{1})
eq(lr.unpackbits(lr.array(3,'uint8'),1,3,'little'):tolist(),{1,1,0})
local a=lr.asfortranarray(lr.array({{1,0,1},{0,1,0}},'int32'))
local out=lr.packbits(a,{axis=2})
eq(out:tolist(),{{160},{64}});eq(out.strides,{1,2})
eq(lr.packbits(a,{axis=1}):tolist(),{{128,64,128}})
eq(lr.packbits(a):tolist(),{168})
eq(lr.packbits(a,2,'big_suffix'):tolist(),out:tolist())
eq(lr.unpackbits(out,2,3,'banana'):tolist(),a:tolist())
eq(lr.packbits(a,{axis=-1}):tolist(),out:tolist())
eq(lr.unpackbits(lr.array({1},'uint8'),{bitorder='le',count=2}):tolist(),{1,0})
a:setflags(false);eq(lr.packbits(a,{axis=2}):tolist(),out:tolist())
eq(lr.shares_memory(out,a),false);out:fill(0);eq(a:tolist(),{{1,0,1},{0,1,0}})
local all={};for i=0,255 do all[#all+1]=string.char(i)end
local bytes=lr.ndarray({256},{dtype='uint8',buffer=table.concat(all)})
for _,order in ipairs({'big','little'})do
 eq(lr.packbits(lr.unpackbits(bytes,{bitorder=order}),{bitorder=order}):tobytes(),bytes:tobytes())
end
local truth=lr.ndarray({8},{dtype='bool',buffer=string.char(0,2,0,128,0,255,0,1)})
eq(lr.packbits(truth):tolist(),{85})
eq(lr.packbits(truth:get(lr.s(nil,nil,-1))):tolist(),{170})
local empty=lr.empty({2,0,3},'int32')
eq(lr.packbits(empty,{axis=3}).shape,{2,0,1})
fails(function()lr.packbits({},nil,'big')end)
fails(function()lr.unpackbits({1})end)
fails(function()lr.packbits({1},0)end)
fails(function()lr.packbits({1},2)end)
fails(function()lr.packbits({1},1.0)end)
fails(function()lr.unpackbits(bytes,{count=true})end)
fails(function()lr.unpackbits(bytes,{count=1.0})end)
fails(function()lr.unpackbits(bytes,{count=math.mininteger})end)
fails(function()lr.unpackbits(lr.array({1},'uint8'),{count=-9})end)
fails(function()lr.packbits(values,{bitorder='b'})end)
fails(function()lr.packbits(values,{bitorder='big\0bad'})end)
fails(function()lr.unpackbits(bytes,{bitorder='BIG'})end)
fails(function()lr.packbits(values,{count=1})end)
fails(function()lr.unpackbits(bytes,{['count\0bad']=1})end)
fails(function()lr.packbits(values,{},1)end)
for _,dtype in ipairs({'float64','complex128','S3','U2','datetime64[D]'})do
 fails(function()lr.packbits(lr.empty({0},dtype))end)
end
local shape={};for i=1,64 do shape[i]=1 end
local high=lr.ones(shape,'uint8')
eq(lr.packbits(high):tolist(),{128})
eq(lr.unpackbits(high).size,8)
fails(function()lr.packbits(high,{axis=1})end)
fails(function()lr.unpackbits(high,{axis=1})end)
-- Empty packed axes have a defined zero-padding policy in LuaRay.
for _,shape in ipairs({{0},{3,0},{0,3},{2,0,3}}) do
 for axis,length in ipairs(shape) do
  if length==0 then
   local source=lr.empty(shape,'uint8');source:setflags(false)
   for _,order in ipairs({'big','little'}) do
    local padded=lr.unpackbits(source,{axis=axis,count=17,bitorder=order})
    local expected={table.unpack(shape)};expected[axis]=17
    eq(padded.shape,expected);eq(lr.count_nonzero(padded),0)
    eq(lr.shares_memory(padded,source),false)
   end
  end
 end
end
-- No input addresses may be calculated for zero-length packed axes.
for _,stride in ipairs({math.maxinteger,math.mininteger}) do
 local empty=lr.ndarray({3,0},{dtype='uint8',buffer='',strides={stride,1}})
 for _,order in ipairs({'big','little'}) do
  local padded=lr.unpackbits(empty,{axis=2,count=17,bitorder=order})
  eq(padded.shape,{3,17});eq(lr.count_nonzero(padded),0)
  eq(lr.shares_memory(padded,empty),false);eq(padded.flags.writeable,true)
 end
end
print('bits regression: '..checks..' checks passed')
