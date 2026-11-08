local np=require('luaray_core')

local function time_array(kind, unit, vals)
  local xs={}
  for i,v in ipairs(vals) do
    if v=='NaT' then
      xs[i]=(kind=='M') and np.datetime64('NaT',unit) or np.timedelta64('NaT',unit)
    else
      xs[i]=(kind=='M') and np.datetime64(v,unit) or np.timedelta64(v,unit)
    end
  end
  local root=(kind=='M') and 'datetime64' or 'timedelta64'
  return np.array(xs, root..'['..unit..']')
end
local function assert_time(a,dtype,vals,label)
  assert(a.dtype==dtype,label..' dtype '..a.dtype..' ~= '..dtype)
  assert(a.size==#vals,label..' size')
  for i,v in ipairs(vals) do
    local x=a[i]
    assert(x.dtype==dtype,label..' scalar dtype '..i..' '..x.dtype)
    if v=='NaT' then assert(x.isnat,label..' expected NaT '..i)
    else assert(not x.isnat and x.value==v,label..' value '..i..' '..tostring(x.value)..' ~= '..tostring(v)) end
  end
end
local function assert_plain(a,dtype,vals,label)
  assert(a.dtype==dtype,label..' dtype '..a.dtype..' ~= '..dtype)
  local got=a:tolist()
  assert(#got==#vals,label..' size')
  for i,v in ipairs(vals) do
    if v~=v then assert(got[i]~=got[i],label..' nan '..i)
    else assert(got[i]==v,label..' value '..i..' '..tostring(got[i])..' ~= '..tostring(v)) end
  end
end

-- Development oracle NumPy 2.3.5; exact source truth is uploaded NumPy main.
do
 local a=time_array('M','D',{1,2,'NaT'})
 local b=time_array('m','h',{24,48,1})
 local r=np.add(a,b)
 assert_time(r,'datetime64[h]',{48,96,'NaT'},'dt bin 0')
end
do
 local a=time_array('m','h',{24,48,'NaT'})
 local b=time_array('M','D',{1,2,3})
 local r=np.add(a,b)
 assert_time(r,'datetime64[h]',{48,96,'NaT'},'dt bin 1')
end
do
 local a=time_array('m','2D',{1,-2,'NaT'})
 local b=time_array('m','3D',{2,1,4})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[D]',{8,-1,'NaT'},'dt bin 2')
end
do
 local a=time_array('M','W',{1,2,3})
 local b=time_array('m','D',{1,-2,4})
 local r=np.add(a,b)
 assert_time(r,'datetime64[D]',{8,12,25},'dt bin 3')
end
do
 local a=time_array('M','Y',{1,2,3})
 local b=time_array('m','M',{6,-12,3})
 local r=np.add(a,b)
 assert_time(r,'datetime64[M]',{18,12,39},'dt bin 4')
end
do
 local a=time_array('M','D',{2,4,'NaT'})
 local b=time_array('m','h',{24,12,1})
 local r=np.subtract(a,b)
 assert_time(r,'datetime64[h]',{24,84,'NaT'},'dt bin 5')
end
do
 local a=time_array('M','D',{2,4,'NaT'})
 local b=time_array('M','h',{24,48,1})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[h]',{24,48,'NaT'},'dt bin 6')
end
do
 local a=time_array('m','2D',{3,-1,'NaT'})
 local b=time_array('m','3D',{1,2,4})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[D]',{3,-8,'NaT'},'dt bin 7')
end
do
 local a=time_array('M','Y',{2,4,6})
 local b=time_array('M','M',{12,24,18})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[M]',{12,24,54},'dt bin 8')
end
do
 local a=time_array('m','Y',{1,2})
 local b=time_array('m','D',{1,2})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 9')
end
do
 local a=time_array('m','M',{1,2})
 local b=time_array('m','W',{1,2})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 10')
end
do
 local a=time_array('M','Y',{0})
 local b=time_array('M','Y',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[Y]',{0},'dt bin 11')
end
do
 local a=time_array('m','Y',{0})
 local b=time_array('m','Y',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[Y]',{0},'dt bin 12')
end
do
 local a=time_array('M','Y',{0})
 local b=time_array('M','M',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[M]',{0},'dt bin 13')
end
do
 local a=time_array('m','Y',{0})
 local b=time_array('m','M',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[M]',{0},'dt bin 14')
end
do
 local a=time_array('M','Y',{0})
 local b=time_array('M','W',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[W]',{0},'dt bin 15')
end
do
 local a=time_array('m','Y',{0})
 local b=time_array('m','W',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 16')
end
do
 local a=time_array('M','Y',{0})
 local b=time_array('M','D',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[D]',{0},'dt bin 17')
end
do
 local a=time_array('m','Y',{0})
 local b=time_array('m','D',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 18')
end
do
 local a=time_array('M','Y',{0})
 local b=time_array('M','h',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[h]',{0},'dt bin 19')
end
do
 local a=time_array('m','Y',{0})
 local b=time_array('m','h',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 20')
end
do
 local a=time_array('M','Y',{0})
 local b=time_array('M','m',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[m]',{0},'dt bin 21')
end
do
 local a=time_array('m','Y',{0})
 local b=time_array('m','m',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 22')
end
do
 local a=time_array('M','Y',{0})
 local b=time_array('M','s',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[s]',{0},'dt bin 23')
end
do
 local a=time_array('m','Y',{0})
 local b=time_array('m','s',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 24')
end
do
 local a=time_array('M','Y',{0})
 local b=time_array('M','ms',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 25')
end
do
 local a=time_array('m','Y',{0})
 local b=time_array('m','ms',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 26')
end
do
 local a=time_array('M','Y',{0})
 local b=time_array('M','us',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 27')
end
do
 local a=time_array('m','Y',{0})
 local b=time_array('m','us',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 28')
end
do
 local a=time_array('M','Y',{0})
 local b=time_array('M','ns',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 29')
end
do
 local a=time_array('m','Y',{0})
 local b=time_array('m','ns',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 30')
end
do
 local a=time_array('M','Y',{0})
 local b=time_array('M','ps',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 31')
end
do
 local a=time_array('m','Y',{0})
 local b=time_array('m','ps',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 32')
end
do
 local a=time_array('M','Y',{0})
 local b=time_array('M','fs',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 33')
end
do
 local a=time_array('m','Y',{0})
 local b=time_array('m','fs',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 34')
end
do
 local a=time_array('M','Y',{0})
 local b=time_array('M','as',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 35')
end
do
 local a=time_array('m','Y',{0})
 local b=time_array('m','as',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 36')
end
do
 local a=time_array('M','M',{0})
 local b=time_array('M','Y',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[M]',{0},'dt bin 37')
end
do
 local a=time_array('m','M',{0})
 local b=time_array('m','Y',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[M]',{0},'dt bin 38')
end
do
 local a=time_array('M','M',{0})
 local b=time_array('M','M',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[M]',{0},'dt bin 39')
end
do
 local a=time_array('m','M',{0})
 local b=time_array('m','M',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[M]',{0},'dt bin 40')
end
do
 local a=time_array('M','M',{0})
 local b=time_array('M','W',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[W]',{0},'dt bin 41')
end
do
 local a=time_array('m','M',{0})
 local b=time_array('m','W',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 42')
end
do
 local a=time_array('M','M',{0})
 local b=time_array('M','D',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[D]',{0},'dt bin 43')
end
do
 local a=time_array('m','M',{0})
 local b=time_array('m','D',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 44')
end
do
 local a=time_array('M','M',{0})
 local b=time_array('M','h',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[h]',{0},'dt bin 45')
end
do
 local a=time_array('m','M',{0})
 local b=time_array('m','h',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 46')
end
do
 local a=time_array('M','M',{0})
 local b=time_array('M','m',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[m]',{0},'dt bin 47')
end
do
 local a=time_array('m','M',{0})
 local b=time_array('m','m',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 48')
end
do
 local a=time_array('M','M',{0})
 local b=time_array('M','s',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[s]',{0},'dt bin 49')
end
do
 local a=time_array('m','M',{0})
 local b=time_array('m','s',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 50')
end
do
 local a=time_array('M','M',{0})
 local b=time_array('M','ms',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 51')
end
do
 local a=time_array('m','M',{0})
 local b=time_array('m','ms',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 52')
end
do
 local a=time_array('M','M',{0})
 local b=time_array('M','us',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 53')
end
do
 local a=time_array('m','M',{0})
 local b=time_array('m','us',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 54')
end
do
 local a=time_array('M','M',{0})
 local b=time_array('M','ns',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 55')
end
do
 local a=time_array('m','M',{0})
 local b=time_array('m','ns',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 56')
end
do
 local a=time_array('M','M',{0})
 local b=time_array('M','ps',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 57')
end
do
 local a=time_array('m','M',{0})
 local b=time_array('m','ps',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 58')
end
do
 local a=time_array('M','M',{0})
 local b=time_array('M','fs',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 59')
end
do
 local a=time_array('m','M',{0})
 local b=time_array('m','fs',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 60')
end
do
 local a=time_array('M','M',{0})
 local b=time_array('M','as',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 61')
end
do
 local a=time_array('m','M',{0})
 local b=time_array('m','as',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 62')
end
do
 local a=time_array('M','W',{0})
 local b=time_array('M','Y',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[W]',{0},'dt bin 63')
end
do
 local a=time_array('m','W',{0})
 local b=time_array('m','Y',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 64')
end
do
 local a=time_array('M','W',{0})
 local b=time_array('M','M',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[W]',{0},'dt bin 65')
end
do
 local a=time_array('m','W',{0})
 local b=time_array('m','M',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 66')
end
do
 local a=time_array('M','W',{0})
 local b=time_array('M','W',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[W]',{0},'dt bin 67')
end
do
 local a=time_array('m','W',{0})
 local b=time_array('m','W',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[W]',{0},'dt bin 68')
end
do
 local a=time_array('M','W',{0})
 local b=time_array('M','D',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[D]',{0},'dt bin 69')
end
do
 local a=time_array('m','W',{0})
 local b=time_array('m','D',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[D]',{0},'dt bin 70')
end
do
 local a=time_array('M','W',{0})
 local b=time_array('M','h',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[h]',{0},'dt bin 71')
end
do
 local a=time_array('m','W',{0})
 local b=time_array('m','h',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[h]',{0},'dt bin 72')
end
do
 local a=time_array('M','W',{0})
 local b=time_array('M','m',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[m]',{0},'dt bin 73')
end
do
 local a=time_array('m','W',{0})
 local b=time_array('m','m',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[m]',{0},'dt bin 74')
end
do
 local a=time_array('M','W',{0})
 local b=time_array('M','s',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[s]',{0},'dt bin 75')
end
do
 local a=time_array('m','W',{0})
 local b=time_array('m','s',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[s]',{0},'dt bin 76')
end
do
 local a=time_array('M','W',{0})
 local b=time_array('M','ms',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 77')
end
do
 local a=time_array('m','W',{0})
 local b=time_array('m','ms',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 78')
end
do
 local a=time_array('M','W',{0})
 local b=time_array('M','us',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 79')
end
do
 local a=time_array('m','W',{0})
 local b=time_array('m','us',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 80')
end
do
 local a=time_array('M','W',{0})
 local b=time_array('M','ns',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 81')
end
do
 local a=time_array('m','W',{0})
 local b=time_array('m','ns',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 82')
end
do
 local a=time_array('M','W',{0})
 local b=time_array('M','ps',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 83')
end
do
 local a=time_array('m','W',{0})
 local b=time_array('m','ps',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 84')
end
do
 local a=time_array('M','W',{0})
 local b=time_array('M','fs',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 85')
end
do
 local a=time_array('m','W',{0})
 local b=time_array('m','fs',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 86')
end
do
 local a=time_array('M','W',{0})
 local b=time_array('M','as',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 87')
end
do
 local a=time_array('m','W',{0})
 local b=time_array('m','as',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 88')
end
do
 local a=time_array('M','D',{0})
 local b=time_array('M','Y',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[D]',{0},'dt bin 89')
end
do
 local a=time_array('m','D',{0})
 local b=time_array('m','Y',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 90')
end
do
 local a=time_array('M','D',{0})
 local b=time_array('M','M',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[D]',{0},'dt bin 91')
end
do
 local a=time_array('m','D',{0})
 local b=time_array('m','M',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 92')
end
do
 local a=time_array('M','D',{0})
 local b=time_array('M','W',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[D]',{0},'dt bin 93')
end
do
 local a=time_array('m','D',{0})
 local b=time_array('m','W',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[D]',{0},'dt bin 94')
end
do
 local a=time_array('M','D',{0})
 local b=time_array('M','D',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[D]',{0},'dt bin 95')
end
do
 local a=time_array('m','D',{0})
 local b=time_array('m','D',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[D]',{0},'dt bin 96')
end
do
 local a=time_array('M','D',{0})
 local b=time_array('M','h',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[h]',{0},'dt bin 97')
end
do
 local a=time_array('m','D',{0})
 local b=time_array('m','h',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[h]',{0},'dt bin 98')
end
do
 local a=time_array('M','D',{0})
 local b=time_array('M','m',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[m]',{0},'dt bin 99')
end
do
 local a=time_array('m','D',{0})
 local b=time_array('m','m',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[m]',{0},'dt bin 100')
end
do
 local a=time_array('M','D',{0})
 local b=time_array('M','s',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[s]',{0},'dt bin 101')
end
do
 local a=time_array('m','D',{0})
 local b=time_array('m','s',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[s]',{0},'dt bin 102')
end
do
 local a=time_array('M','D',{0})
 local b=time_array('M','ms',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 103')
end
do
 local a=time_array('m','D',{0})
 local b=time_array('m','ms',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 104')
end
do
 local a=time_array('M','D',{0})
 local b=time_array('M','us',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 105')
end
do
 local a=time_array('m','D',{0})
 local b=time_array('m','us',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 106')
end
do
 local a=time_array('M','D',{0})
 local b=time_array('M','ns',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 107')
end
do
 local a=time_array('m','D',{0})
 local b=time_array('m','ns',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 108')
end
do
 local a=time_array('M','D',{0})
 local b=time_array('M','ps',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 109')
end
do
 local a=time_array('m','D',{0})
 local b=time_array('m','ps',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 110')
end
do
 local a=time_array('M','D',{0})
 local b=time_array('M','fs',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 111')
end
do
 local a=time_array('m','D',{0})
 local b=time_array('m','fs',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 112')
end
do
 local a=time_array('M','D',{0})
 local b=time_array('M','as',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 113')
end
do
 local a=time_array('m','D',{0})
 local b=time_array('m','as',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 114')
end
do
 local a=time_array('M','h',{0})
 local b=time_array('M','Y',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[h]',{0},'dt bin 115')
end
do
 local a=time_array('m','h',{0})
 local b=time_array('m','Y',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 116')
end
do
 local a=time_array('M','h',{0})
 local b=time_array('M','M',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[h]',{0},'dt bin 117')
end
do
 local a=time_array('m','h',{0})
 local b=time_array('m','M',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 118')
end
do
 local a=time_array('M','h',{0})
 local b=time_array('M','W',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[h]',{0},'dt bin 119')
end
do
 local a=time_array('m','h',{0})
 local b=time_array('m','W',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[h]',{0},'dt bin 120')
end
do
 local a=time_array('M','h',{0})
 local b=time_array('M','D',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[h]',{0},'dt bin 121')
end
do
 local a=time_array('m','h',{0})
 local b=time_array('m','D',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[h]',{0},'dt bin 122')
end
do
 local a=time_array('M','h',{0})
 local b=time_array('M','h',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[h]',{0},'dt bin 123')
end
do
 local a=time_array('m','h',{0})
 local b=time_array('m','h',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[h]',{0},'dt bin 124')
end
do
 local a=time_array('M','h',{0})
 local b=time_array('M','m',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[m]',{0},'dt bin 125')
end
do
 local a=time_array('m','h',{0})
 local b=time_array('m','m',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[m]',{0},'dt bin 126')
end
do
 local a=time_array('M','h',{0})
 local b=time_array('M','s',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[s]',{0},'dt bin 127')
end
do
 local a=time_array('m','h',{0})
 local b=time_array('m','s',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[s]',{0},'dt bin 128')
end
do
 local a=time_array('M','h',{0})
 local b=time_array('M','ms',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 129')
end
do
 local a=time_array('m','h',{0})
 local b=time_array('m','ms',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 130')
end
do
 local a=time_array('M','h',{0})
 local b=time_array('M','us',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 131')
end
do
 local a=time_array('m','h',{0})
 local b=time_array('m','us',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 132')
end
do
 local a=time_array('M','h',{0})
 local b=time_array('M','ns',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 133')
end
do
 local a=time_array('m','h',{0})
 local b=time_array('m','ns',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 134')
end
do
 local a=time_array('M','h',{0})
 local b=time_array('M','ps',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 135')
end
do
 local a=time_array('m','h',{0})
 local b=time_array('m','ps',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 136')
end
do
 local a=time_array('M','h',{0})
 local b=time_array('M','fs',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 137')
end
do
 local a=time_array('m','h',{0})
 local b=time_array('m','fs',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 138')
end
do
 local a=time_array('M','h',{0})
 local b=time_array('M','as',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 139')
end
do
 local a=time_array('m','h',{0})
 local b=time_array('m','as',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 140')
end
do
 local a=time_array('M','m',{0})
 local b=time_array('M','Y',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[m]',{0},'dt bin 141')
end
do
 local a=time_array('m','m',{0})
 local b=time_array('m','Y',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 142')
end
do
 local a=time_array('M','m',{0})
 local b=time_array('M','M',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[m]',{0},'dt bin 143')
end
do
 local a=time_array('m','m',{0})
 local b=time_array('m','M',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 144')
end
do
 local a=time_array('M','m',{0})
 local b=time_array('M','W',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[m]',{0},'dt bin 145')
end
do
 local a=time_array('m','m',{0})
 local b=time_array('m','W',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[m]',{0},'dt bin 146')
end
do
 local a=time_array('M','m',{0})
 local b=time_array('M','D',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[m]',{0},'dt bin 147')
end
do
 local a=time_array('m','m',{0})
 local b=time_array('m','D',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[m]',{0},'dt bin 148')
end
do
 local a=time_array('M','m',{0})
 local b=time_array('M','h',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[m]',{0},'dt bin 149')
end
do
 local a=time_array('m','m',{0})
 local b=time_array('m','h',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[m]',{0},'dt bin 150')
end
do
 local a=time_array('M','m',{0})
 local b=time_array('M','m',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[m]',{0},'dt bin 151')
end
do
 local a=time_array('m','m',{0})
 local b=time_array('m','m',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[m]',{0},'dt bin 152')
end
do
 local a=time_array('M','m',{0})
 local b=time_array('M','s',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[s]',{0},'dt bin 153')
end
do
 local a=time_array('m','m',{0})
 local b=time_array('m','s',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[s]',{0},'dt bin 154')
end
do
 local a=time_array('M','m',{0})
 local b=time_array('M','ms',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 155')
end
do
 local a=time_array('m','m',{0})
 local b=time_array('m','ms',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 156')
end
do
 local a=time_array('M','m',{0})
 local b=time_array('M','us',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 157')
end
do
 local a=time_array('m','m',{0})
 local b=time_array('m','us',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 158')
end
do
 local a=time_array('M','m',{0})
 local b=time_array('M','ns',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 159')
end
do
 local a=time_array('m','m',{0})
 local b=time_array('m','ns',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 160')
end
do
 local a=time_array('M','m',{0})
 local b=time_array('M','ps',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 161')
end
do
 local a=time_array('m','m',{0})
 local b=time_array('m','ps',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 162')
end
do
 local a=time_array('M','m',{0})
 local b=time_array('M','fs',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 163')
end
do
 local a=time_array('m','m',{0})
 local b=time_array('m','fs',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 164')
end
do
 local a=time_array('M','m',{0})
 local b=time_array('M','as',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 165')
end
do
 local a=time_array('m','m',{0})
 local b=time_array('m','as',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 166')
end
do
 local a=time_array('M','s',{0})
 local b=time_array('M','Y',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[s]',{0},'dt bin 167')
end
do
 local a=time_array('m','s',{0})
 local b=time_array('m','Y',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 168')
end
do
 local a=time_array('M','s',{0})
 local b=time_array('M','M',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[s]',{0},'dt bin 169')
end
do
 local a=time_array('m','s',{0})
 local b=time_array('m','M',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 170')
end
do
 local a=time_array('M','s',{0})
 local b=time_array('M','W',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[s]',{0},'dt bin 171')
end
do
 local a=time_array('m','s',{0})
 local b=time_array('m','W',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[s]',{0},'dt bin 172')
end
do
 local a=time_array('M','s',{0})
 local b=time_array('M','D',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[s]',{0},'dt bin 173')
end
do
 local a=time_array('m','s',{0})
 local b=time_array('m','D',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[s]',{0},'dt bin 174')
end
do
 local a=time_array('M','s',{0})
 local b=time_array('M','h',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[s]',{0},'dt bin 175')
end
do
 local a=time_array('m','s',{0})
 local b=time_array('m','h',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[s]',{0},'dt bin 176')
end
do
 local a=time_array('M','s',{0})
 local b=time_array('M','m',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[s]',{0},'dt bin 177')
end
do
 local a=time_array('m','s',{0})
 local b=time_array('m','m',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[s]',{0},'dt bin 178')
end
do
 local a=time_array('M','s',{0})
 local b=time_array('M','s',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[s]',{0},'dt bin 179')
end
do
 local a=time_array('m','s',{0})
 local b=time_array('m','s',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[s]',{0},'dt bin 180')
end
do
 local a=time_array('M','s',{0})
 local b=time_array('M','ms',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 181')
end
do
 local a=time_array('m','s',{0})
 local b=time_array('m','ms',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 182')
end
do
 local a=time_array('M','s',{0})
 local b=time_array('M','us',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 183')
end
do
 local a=time_array('m','s',{0})
 local b=time_array('m','us',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 184')
end
do
 local a=time_array('M','s',{0})
 local b=time_array('M','ns',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 185')
end
do
 local a=time_array('m','s',{0})
 local b=time_array('m','ns',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 186')
end
do
 local a=time_array('M','s',{0})
 local b=time_array('M','ps',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 187')
end
do
 local a=time_array('m','s',{0})
 local b=time_array('m','ps',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 188')
end
do
 local a=time_array('M','s',{0})
 local b=time_array('M','fs',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 189')
end
do
 local a=time_array('m','s',{0})
 local b=time_array('m','fs',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 190')
end
do
 local a=time_array('M','s',{0})
 local b=time_array('M','as',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 191')
end
do
 local a=time_array('m','s',{0})
 local b=time_array('m','as',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 192')
end
do
 local a=time_array('M','ms',{0})
 local b=time_array('M','Y',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 193')
end
do
 local a=time_array('m','ms',{0})
 local b=time_array('m','Y',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 194')
end
do
 local a=time_array('M','ms',{0})
 local b=time_array('M','M',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 195')
end
do
 local a=time_array('m','ms',{0})
 local b=time_array('m','M',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 196')
end
do
 local a=time_array('M','ms',{0})
 local b=time_array('M','W',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 197')
end
do
 local a=time_array('m','ms',{0})
 local b=time_array('m','W',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 198')
end
do
 local a=time_array('M','ms',{0})
 local b=time_array('M','D',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 199')
end
do
 local a=time_array('m','ms',{0})
 local b=time_array('m','D',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 200')
end
do
 local a=time_array('M','ms',{0})
 local b=time_array('M','h',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 201')
end
do
 local a=time_array('m','ms',{0})
 local b=time_array('m','h',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 202')
end
do
 local a=time_array('M','ms',{0})
 local b=time_array('M','m',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 203')
end
do
 local a=time_array('m','ms',{0})
 local b=time_array('m','m',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 204')
end
do
 local a=time_array('M','ms',{0})
 local b=time_array('M','s',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 205')
end
do
 local a=time_array('m','ms',{0})
 local b=time_array('m','s',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 206')
end
do
 local a=time_array('M','ms',{0})
 local b=time_array('M','ms',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 207')
end
do
 local a=time_array('m','ms',{0})
 local b=time_array('m','ms',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ms]',{0},'dt bin 208')
end
do
 local a=time_array('M','ms',{0})
 local b=time_array('M','us',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 209')
end
do
 local a=time_array('m','ms',{0})
 local b=time_array('m','us',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 210')
end
do
 local a=time_array('M','ms',{0})
 local b=time_array('M','ns',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 211')
end
do
 local a=time_array('m','ms',{0})
 local b=time_array('m','ns',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 212')
end
do
 local a=time_array('M','ms',{0})
 local b=time_array('M','ps',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 213')
end
do
 local a=time_array('m','ms',{0})
 local b=time_array('m','ps',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 214')
end
do
 local a=time_array('M','ms',{0})
 local b=time_array('M','fs',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 215')
end
do
 local a=time_array('m','ms',{0})
 local b=time_array('m','fs',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 216')
end
do
 local a=time_array('M','ms',{0})
 local b=time_array('M','as',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[as]',{0},'dt bin 217')
end
do
 local a=time_array('m','ms',{0})
 local b=time_array('m','as',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[as]',{0},'dt bin 218')
end
do
 local a=time_array('M','us',{0})
 local b=time_array('M','Y',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 219')
end
do
 local a=time_array('m','us',{0})
 local b=time_array('m','Y',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 220')
end
do
 local a=time_array('M','us',{0})
 local b=time_array('M','M',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 221')
end
do
 local a=time_array('m','us',{0})
 local b=time_array('m','M',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 222')
end
do
 local a=time_array('M','us',{0})
 local b=time_array('M','W',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 223')
end
do
 local a=time_array('m','us',{0})
 local b=time_array('m','W',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 224')
end
do
 local a=time_array('M','us',{0})
 local b=time_array('M','D',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 225')
end
do
 local a=time_array('m','us',{0})
 local b=time_array('m','D',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 226')
end
do
 local a=time_array('M','us',{0})
 local b=time_array('M','h',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 227')
end
do
 local a=time_array('m','us',{0})
 local b=time_array('m','h',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 228')
end
do
 local a=time_array('M','us',{0})
 local b=time_array('M','m',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 229')
end
do
 local a=time_array('m','us',{0})
 local b=time_array('m','m',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 230')
end
do
 local a=time_array('M','us',{0})
 local b=time_array('M','s',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 231')
end
do
 local a=time_array('m','us',{0})
 local b=time_array('m','s',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 232')
end
do
 local a=time_array('M','us',{0})
 local b=time_array('M','ms',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 233')
end
do
 local a=time_array('m','us',{0})
 local b=time_array('m','ms',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 234')
end
do
 local a=time_array('M','us',{0})
 local b=time_array('M','us',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 235')
end
do
 local a=time_array('m','us',{0})
 local b=time_array('m','us',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[us]',{0},'dt bin 236')
end
do
 local a=time_array('M','us',{0})
 local b=time_array('M','ns',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 237')
end
do
 local a=time_array('m','us',{0})
 local b=time_array('m','ns',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 238')
end
do
 local a=time_array('M','us',{0})
 local b=time_array('M','ps',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 239')
end
do
 local a=time_array('m','us',{0})
 local b=time_array('m','ps',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 240')
end
do
 local a=time_array('M','us',{0})
 local b=time_array('M','fs',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 241')
end
do
 local a=time_array('m','us',{0})
 local b=time_array('m','fs',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 242')
end
do
 local a=time_array('M','us',{0})
 local b=time_array('M','as',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[as]',{0},'dt bin 243')
end
do
 local a=time_array('m','us',{0})
 local b=time_array('m','as',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[as]',{0},'dt bin 244')
end
do
 local a=time_array('M','ns',{0})
 local b=time_array('M','Y',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 245')
end
do
 local a=time_array('m','ns',{0})
 local b=time_array('m','Y',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 246')
end
do
 local a=time_array('M','ns',{0})
 local b=time_array('M','M',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 247')
end
do
 local a=time_array('m','ns',{0})
 local b=time_array('m','M',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 248')
end
do
 local a=time_array('M','ns',{0})
 local b=time_array('M','W',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 249')
end
do
 local a=time_array('m','ns',{0})
 local b=time_array('m','W',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 250')
end
do
 local a=time_array('M','ns',{0})
 local b=time_array('M','D',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 251')
end
do
 local a=time_array('m','ns',{0})
 local b=time_array('m','D',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 252')
end
do
 local a=time_array('M','ns',{0})
 local b=time_array('M','h',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 253')
end
do
 local a=time_array('m','ns',{0})
 local b=time_array('m','h',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 254')
end
do
 local a=time_array('M','ns',{0})
 local b=time_array('M','m',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 255')
end
do
 local a=time_array('m','ns',{0})
 local b=time_array('m','m',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 256')
end
do
 local a=time_array('M','ns',{0})
 local b=time_array('M','s',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 257')
end
do
 local a=time_array('m','ns',{0})
 local b=time_array('m','s',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 258')
end
do
 local a=time_array('M','ns',{0})
 local b=time_array('M','ms',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 259')
end
do
 local a=time_array('m','ns',{0})
 local b=time_array('m','ms',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 260')
end
do
 local a=time_array('M','ns',{0})
 local b=time_array('M','us',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 261')
end
do
 local a=time_array('m','ns',{0})
 local b=time_array('m','us',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 262')
end
do
 local a=time_array('M','ns',{0})
 local b=time_array('M','ns',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 263')
end
do
 local a=time_array('m','ns',{0})
 local b=time_array('m','ns',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ns]',{0},'dt bin 264')
end
do
 local a=time_array('M','ns',{0})
 local b=time_array('M','ps',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 265')
end
do
 local a=time_array('m','ns',{0})
 local b=time_array('m','ps',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 266')
end
do
 local a=time_array('M','ns',{0})
 local b=time_array('M','fs',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 267')
end
do
 local a=time_array('m','ns',{0})
 local b=time_array('m','fs',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 268')
end
do
 local a=time_array('M','ns',{0})
 local b=time_array('M','as',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[as]',{0},'dt bin 269')
end
do
 local a=time_array('m','ns',{0})
 local b=time_array('m','as',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[as]',{0},'dt bin 270')
end
do
 local a=time_array('M','ps',{0})
 local b=time_array('M','Y',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 271')
end
do
 local a=time_array('m','ps',{0})
 local b=time_array('m','Y',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 272')
end
do
 local a=time_array('M','ps',{0})
 local b=time_array('M','M',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 273')
end
do
 local a=time_array('m','ps',{0})
 local b=time_array('m','M',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 274')
end
do
 local a=time_array('M','ps',{0})
 local b=time_array('M','W',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 275')
end
do
 local a=time_array('m','ps',{0})
 local b=time_array('m','W',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 276')
end
do
 local a=time_array('M','ps',{0})
 local b=time_array('M','D',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 277')
end
do
 local a=time_array('m','ps',{0})
 local b=time_array('m','D',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 278')
end
do
 local a=time_array('M','ps',{0})
 local b=time_array('M','h',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 279')
end
do
 local a=time_array('m','ps',{0})
 local b=time_array('m','h',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 280')
end
do
 local a=time_array('M','ps',{0})
 local b=time_array('M','m',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 281')
end
do
 local a=time_array('m','ps',{0})
 local b=time_array('m','m',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 282')
end
do
 local a=time_array('M','ps',{0})
 local b=time_array('M','s',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 283')
end
do
 local a=time_array('m','ps',{0})
 local b=time_array('m','s',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 284')
end
do
 local a=time_array('M','ps',{0})
 local b=time_array('M','ms',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 285')
end
do
 local a=time_array('m','ps',{0})
 local b=time_array('m','ms',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 286')
end
do
 local a=time_array('M','ps',{0})
 local b=time_array('M','us',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 287')
end
do
 local a=time_array('m','ps',{0})
 local b=time_array('m','us',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 288')
end
do
 local a=time_array('M','ps',{0})
 local b=time_array('M','ns',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 289')
end
do
 local a=time_array('m','ps',{0})
 local b=time_array('m','ns',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 290')
end
do
 local a=time_array('M','ps',{0})
 local b=time_array('M','ps',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 291')
end
do
 local a=time_array('m','ps',{0})
 local b=time_array('m','ps',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ps]',{0},'dt bin 292')
end
do
 local a=time_array('M','ps',{0})
 local b=time_array('M','fs',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 293')
end
do
 local a=time_array('m','ps',{0})
 local b=time_array('m','fs',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 294')
end
do
 local a=time_array('M','ps',{0})
 local b=time_array('M','as',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[as]',{0},'dt bin 295')
end
do
 local a=time_array('m','ps',{0})
 local b=time_array('m','as',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[as]',{0},'dt bin 296')
end
do
 local a=time_array('M','fs',{0})
 local b=time_array('M','Y',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 297')
end
do
 local a=time_array('m','fs',{0})
 local b=time_array('m','Y',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 298')
end
do
 local a=time_array('M','fs',{0})
 local b=time_array('M','M',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 299')
end
do
 local a=time_array('m','fs',{0})
 local b=time_array('m','M',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 300')
end
do
 local a=time_array('M','fs',{0})
 local b=time_array('M','W',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 301')
end
do
 local a=time_array('m','fs',{0})
 local b=time_array('m','W',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 302')
end
do
 local a=time_array('M','fs',{0})
 local b=time_array('M','D',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 303')
end
do
 local a=time_array('m','fs',{0})
 local b=time_array('m','D',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 304')
end
do
 local a=time_array('M','fs',{0})
 local b=time_array('M','h',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 305')
end
do
 local a=time_array('m','fs',{0})
 local b=time_array('m','h',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 306')
end
do
 local a=time_array('M','fs',{0})
 local b=time_array('M','m',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 307')
end
do
 local a=time_array('m','fs',{0})
 local b=time_array('m','m',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 308')
end
do
 local a=time_array('M','fs',{0})
 local b=time_array('M','s',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 309')
end
do
 local a=time_array('m','fs',{0})
 local b=time_array('m','s',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 310')
end
do
 local a=time_array('M','fs',{0})
 local b=time_array('M','ms',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 311')
end
do
 local a=time_array('m','fs',{0})
 local b=time_array('m','ms',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 312')
end
do
 local a=time_array('M','fs',{0})
 local b=time_array('M','us',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 313')
end
do
 local a=time_array('m','fs',{0})
 local b=time_array('m','us',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 314')
end
do
 local a=time_array('M','fs',{0})
 local b=time_array('M','ns',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 315')
end
do
 local a=time_array('m','fs',{0})
 local b=time_array('m','ns',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 316')
end
do
 local a=time_array('M','fs',{0})
 local b=time_array('M','ps',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 317')
end
do
 local a=time_array('m','fs',{0})
 local b=time_array('m','ps',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 318')
end
do
 local a=time_array('M','fs',{0})
 local b=time_array('M','fs',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 319')
end
do
 local a=time_array('m','fs',{0})
 local b=time_array('m','fs',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[fs]',{0},'dt bin 320')
end
do
 local a=time_array('M','fs',{0})
 local b=time_array('M','as',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[as]',{0},'dt bin 321')
end
do
 local a=time_array('m','fs',{0})
 local b=time_array('m','as',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[as]',{0},'dt bin 322')
end
do
 local a=time_array('M','as',{0})
 local b=time_array('M','Y',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 323')
end
do
 local a=time_array('m','as',{0})
 local b=time_array('m','Y',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 324')
end
do
 local a=time_array('M','as',{0})
 local b=time_array('M','M',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 325')
end
do
 local a=time_array('m','as',{0})
 local b=time_array('m','M',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 326')
end
do
 local a=time_array('M','as',{0})
 local b=time_array('M','W',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 327')
end
do
 local a=time_array('m','as',{0})
 local b=time_array('m','W',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 328')
end
do
 local a=time_array('M','as',{0})
 local b=time_array('M','D',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 329')
end
do
 local a=time_array('m','as',{0})
 local b=time_array('m','D',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 330')
end
do
 local a=time_array('M','as',{0})
 local b=time_array('M','h',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 331')
end
do
 local a=time_array('m','as',{0})
 local b=time_array('m','h',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 332')
end
do
 local a=time_array('M','as',{0})
 local b=time_array('M','m',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 333')
end
do
 local a=time_array('m','as',{0})
 local b=time_array('m','m',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 334')
end
do
 local a=time_array('M','as',{0})
 local b=time_array('M','s',{0})
 assert(not pcall(function() return np.subtract(a,b) end),'dt reject 335')
end
do
 local a=time_array('m','as',{0})
 local b=time_array('m','s',{0})
 assert(not pcall(function() return np.add(a,b) end),'dt reject 336')
end
do
 local a=time_array('M','as',{0})
 local b=time_array('M','ms',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[as]',{0},'dt bin 337')
end
do
 local a=time_array('m','as',{0})
 local b=time_array('m','ms',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[as]',{0},'dt bin 338')
end
do
 local a=time_array('M','as',{0})
 local b=time_array('M','us',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[as]',{0},'dt bin 339')
end
do
 local a=time_array('m','as',{0})
 local b=time_array('m','us',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[as]',{0},'dt bin 340')
end
do
 local a=time_array('M','as',{0})
 local b=time_array('M','ns',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[as]',{0},'dt bin 341')
end
do
 local a=time_array('m','as',{0})
 local b=time_array('m','ns',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[as]',{0},'dt bin 342')
end
do
 local a=time_array('M','as',{0})
 local b=time_array('M','ps',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[as]',{0},'dt bin 343')
end
do
 local a=time_array('m','as',{0})
 local b=time_array('m','ps',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[as]',{0},'dt bin 344')
end
do
 local a=time_array('M','as',{0})
 local b=time_array('M','fs',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[as]',{0},'dt bin 345')
end
do
 local a=time_array('m','as',{0})
 local b=time_array('m','fs',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[as]',{0},'dt bin 346')
end
do
 local a=time_array('M','as',{0})
 local b=time_array('M','as',{0})
 local r=np.subtract(a,b)
 assert_time(r,'timedelta64[as]',{0},'dt bin 347')
end
do
 local a=time_array('m','as',{0})
 local b=time_array('m','as',{0})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[as]',{0},'dt bin 348')
end
do
 local a=time_array('M','D',{1,2,'NaT',4})
 local b=time_array('M','h',{24,49,72,'NaT'})
 local r=np.equal(a,b)
 assert_plain(r,'bool',{true,false,false,false},'dt bin 349')
end
do
 local a=time_array('m','2D',{1,-1,'NaT',3})
 local b=time_array('m','h',{48,-24,1,'NaT'})
 local r=np.equal(a,b)
 assert_plain(r,'bool',{true,false,false,false},'dt bin 350')
end
do
 local a=time_array('M','D',{1,2,'NaT',4})
 local b=time_array('M','h',{24,49,72,'NaT'})
 local r=np.not_equal(a,b)
 assert_plain(r,'bool',{false,true,true,true},'dt bin 351')
end
do
 local a=time_array('m','2D',{1,-1,'NaT',3})
 local b=time_array('m','h',{48,-24,1,'NaT'})
 local r=np.not_equal(a,b)
 assert_plain(r,'bool',{false,true,true,true},'dt bin 352')
end
do
 local a=time_array('M','D',{1,2,'NaT',4})
 local b=time_array('M','h',{24,49,72,'NaT'})
 local r=np.less(a,b)
 assert_plain(r,'bool',{false,true,false,false},'dt bin 353')
end
do
 local a=time_array('m','2D',{1,-1,'NaT',3})
 local b=time_array('m','h',{48,-24,1,'NaT'})
 local r=np.less(a,b)
 assert_plain(r,'bool',{false,true,false,false},'dt bin 354')
end
do
 local a=time_array('M','D',{1,2,'NaT',4})
 local b=time_array('M','h',{24,49,72,'NaT'})
 local r=np.less_equal(a,b)
 assert_plain(r,'bool',{true,true,false,false},'dt bin 355')
end
do
 local a=time_array('m','2D',{1,-1,'NaT',3})
 local b=time_array('m','h',{48,-24,1,'NaT'})
 local r=np.less_equal(a,b)
 assert_plain(r,'bool',{true,true,false,false},'dt bin 356')
end
do
 local a=time_array('M','D',{1,2,'NaT',4})
 local b=time_array('M','h',{24,49,72,'NaT'})
 local r=np.greater(a,b)
 assert_plain(r,'bool',{false,false,false,false},'dt bin 357')
end
do
 local a=time_array('m','2D',{1,-1,'NaT',3})
 local b=time_array('m','h',{48,-24,1,'NaT'})
 local r=np.greater(a,b)
 assert_plain(r,'bool',{false,false,false,false},'dt bin 358')
end
do
 local a=time_array('M','D',{1,2,'NaT',4})
 local b=time_array('M','h',{24,49,72,'NaT'})
 local r=np.greater_equal(a,b)
 assert_plain(r,'bool',{true,false,false,false},'dt bin 359')
end
do
 local a=time_array('m','2D',{1,-1,'NaT',3})
 local b=time_array('m','h',{48,-24,1,'NaT'})
 local r=np.greater_equal(a,b)
 assert_plain(r,'bool',{true,false,false,false},'dt bin 360')
end
do
 local a=time_array('M','D',{1,2})
 local b=time_array('m','D',{1,2})
 assert(not pcall(function() return np.equal(a,b) end),'dt reject 361')
end
do
 local a=time_array('M','D',{1,2})
 local b=time_array('m','D',{1,2})
 assert(not pcall(function() return np.less(a,b) end),'dt reject 362')
end
do
 local a=time_array('M','D',{1,'NaT',4,3})
 local b=time_array('M','h',{48,72,'NaT',95})
 local r=np.maximum(a,b)
 assert_time(r,'datetime64[h]',{48,'NaT','NaT',95},'dt bin 363')
end
do
 local a=time_array('m','D',{1,'NaT',-2,4})
 local b=time_array('m','h',{48,72,'NaT',12})
 local r=np.maximum(a,b)
 assert_time(r,'timedelta64[h]',{48,'NaT','NaT',96},'dt bin 364')
end
do
 local a=time_array('M','D',{1,'NaT',4,3})
 local b=time_array('M','h',{48,72,'NaT',95})
 local r=np.minimum(a,b)
 assert_time(r,'datetime64[h]',{24,'NaT','NaT',72},'dt bin 365')
end
do
 local a=time_array('m','D',{1,'NaT',-2,4})
 local b=time_array('m','h',{48,72,'NaT',12})
 local r=np.minimum(a,b)
 assert_time(r,'timedelta64[h]',{24,'NaT','NaT',12},'dt bin 366')
end
do
 local a=time_array('M','D',{1,'NaT',4,3})
 local b=time_array('M','h',{48,72,'NaT',95})
 local r=np.fmax(a,b)
 assert_time(r,'datetime64[h]',{48,72,96,95},'dt bin 367')
end
do
 local a=time_array('m','D',{1,'NaT',-2,4})
 local b=time_array('m','h',{48,72,'NaT',12})
 local r=np.fmax(a,b)
 assert_time(r,'timedelta64[h]',{48,72,-48,96},'dt bin 368')
end
do
 local a=time_array('M','D',{1,'NaT',4,3})
 local b=time_array('M','h',{48,72,'NaT',95})
 local r=np.fmin(a,b)
 assert_time(r,'datetime64[h]',{24,72,96,72},'dt bin 369')
end
do
 local a=time_array('m','D',{1,'NaT',-2,4})
 local b=time_array('m','h',{48,72,'NaT',12})
 local r=np.fmin(a,b)
 assert_time(r,'timedelta64[h]',{24,72,-48,12},'dt bin 370')
end
do
 local a=time_array('m','h',{1,-2,'NaT',0})
 local r=np.negative(a)
 assert_time(r,'timedelta64[h]',{-1,2,'NaT',0},'dt unary 371')
end
do
 local a=time_array('m','2D',{1,-2,'NaT',0})
 local r=np.positive(a)
 assert_time(r,'timedelta64[2D]',{1,-2,'NaT',0},'dt unary 372')
end
do
 local a=time_array('m','m',{1,-2,'NaT',0})
 local r=np.absolute(a)
 assert_time(r,'timedelta64[m]',{1,2,'NaT',0},'dt unary 373')
end
do
 local a=time_array('m','h',{1,-2,0,'NaT'})
 local r=np.sign(a)
 assert_plain(r,'float64',{1.0,-1.0,0.0,0/0},'dt unary 374')
end
do
 local a=time_array('M','D',{1,'NaT',-2})
 local r=np.isnat(a)
 assert_plain(r,'bool',{false,true,false},'dt unary 375')
end
do
 local a=time_array('m','D',{1,'NaT',-2})
 local r=np.isnat(a)
 assert_plain(r,'bool',{false,true,false},'dt unary 376')
end
do
 local a=time_array('M','D',{1,'NaT',-2})
 local r=np.isfinite(a)
 assert_plain(r,'bool',{true,false,true},'dt unary 377')
end
do
 local a=time_array('m','D',{1,'NaT',-2})
 local r=np.isfinite(a)
 assert_plain(r,'bool',{true,false,true},'dt unary 378')
end
do
 local a=time_array('M','D',{1,2,3,4})
 local b=time_array('m','h',{12,24,36,48})
 local o=time_array('M','D',{90,80,70,60})
 local w=np.array({true,false,true,false},np.bool)
 local r=np.add(a,b,{out=o,where=w})
 assert(r==o,'dt out identity')
 assert_time(o,'datetime64[D]',{1,80,4,60},'dt out 379')
end
do
 local a=time_array('m','ns',{9223372036854775807,5})
 local b=time_array('m','ns',{1,2})
 local o=time_array('m','ns',{77,88})
 local w=np.array({false,true},np.bool)
 local r=np.add(a,b,{out=o,where=w})
 assert(r==o,'dt masked overflow out identity')
 assert_time(o,'timedelta64[ns]',{77,7},'dt masked overflow 380')
end
do
 local a=time_array('m','ns',{9223372036854775806})
 local b=time_array('m','ns',{1})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ns]',{9223372036854775807},'dt boundary 381')
end
do
 local a=time_array('m','ns',{9223372036854775807})
 local b=time_array('m','ns',{1})
 assert(not pcall(function() return np.add(a,b) end),'dt overflow 382')
end
do
 local a=time_array('m','ns',{-9223372036854775807})
 local b=time_array('m','ns',{-1})
 assert(not pcall(function() return np.add(a,b) end),'dt NaT-sentinel overflow 383')
end
do
 local a=time_array('m','ns',{'NaT'})
 local b=time_array('m','ns',{9223372036854775807})
 local r=np.add(a,b)
 assert_time(r,'timedelta64[ns]',{'NaT'},'dt NaT arithmetic 384')
end
do
 local a=time_array('M','2D',{3,'NaT'})
 assert(a[1].dtype=='datetime64[2D]' and a[1].value==3,'dt scalar descriptor')
 assert(a[2].dtype=='datetime64[2D]' and a[2].isnat,'dt scalar NaT descriptor')
end
print('datetime differential: 386 cases ok')
