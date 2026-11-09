local np=require('luaray_core')
assert(np._version=='0.125.0-dev')
local checked=0
local function same(a,b)
 if type(a)~='userdata' or type(b)~='userdata' then return a==b end
 if a.dtype~=b.dtype or #a.shape~=#b.shape then return false end
 for j=1,#a.shape do if a.shape[j]~=b.shape[j] then return false end end
 local function eq(x,y)
  if type(x)~=type(y) then return false end
  if type(x)~='table' then return x==y end
  if #x~=#y then return false end
  for i=1,#x do if not eq(x[i],y[i]) then return false end end
  return true
 end
 return eq(a:tolist(),b:tolist())
end
local lo={9007199254740993,9007199254740999,9007199254741007}
local hi={9007199254740994,9007199254741020,9007199254741099}
for _,dt in ipairs({'int64','uint64'}) do
 for _,sz in ipairs({false,{2,3},{0,3}}) do
  local rng=np.random.default_rng(90090)
  local control=np.random.default_rng(90090)
  local actual=rng:integers(lo,hi,sz or nil,dt)
  local expected=control:integers(np.array(lo,'int64'),np.array(hi,'int64'),sz or nil,dt)
  assert(same(actual,expected),'integer table lost precision: '..dt)
  assert(rng:raw_hex()==control:raw_hex(),'integer table changed PCG64')
  checked=checked+1
 end
end
-- Unrepresentable upper/lower relationship must fail before drawing.
local function rejects(low,high,dt)
 local r=np.random.default_rng(90090)
 local c=np.random.default_rng(90090)
 assert(not pcall(function()r:integers(low,high,nil,dt)end))
 assert(r:raw_hex()==c:raw_hex())
 checked=checked+1
end
rejects({9007199254740993},{9007199254740993},'int64')
rejects({9223372036854775807},{math.mininteger},'int64')
rejects({-1},{10},'uint64')
rejects({9007199254740993,7},{9007199254740994,6},'int64')
local l=np.transpose(np.array({{0,3},{1,4},{2,5}},'int64'))
local h=np.transpose(np.array({{4,10},{6,12},{8,14}},'int64'))
local left=np.random.default_rng(1234)
local right=np.random.default_rng(1234)
local a=left:integers(l,h,{2,2,3},'int16')
local b=right:integers(np.array({{0,1,2},{3,4,5}},'int64'),np.array({{4,6,8},{10,12,14}},'int64'),{2,2,3},'int16')
assert(same(a,b) and left:raw_hex()==right:raw_hex())
checked=checked+1
print('random90 regression PASS: '..checked..' exact-table, rejection, and Fortran layout checks')
