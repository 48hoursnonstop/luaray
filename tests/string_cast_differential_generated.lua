local np=require('luaray_core')

local function eqnum(a,b,eps)
  eps=eps or 1e-6
  if type(a)=='number' and type(b)=='number' then
    if a~=a and b~=b then return true end
    if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return a==b end
    return math.abs(a-b)<=eps*math.max(1,math.abs(a),math.abs(b))
  end
  return a==b
end
local function check_strings(a,dtype,e,label)
  assert(a.dtype==dtype,label..' dtype '..a.dtype..' ~= '..dtype)
  assert(a.size==#e,label..' size')
  for i=1,#e do assert(a[i]==e[i],label..' value '..i..' '..tostring(a[i])..' ~= '..tostring(e[i])) end
end
local function check_numeric(a,dtype,e,label,eps)
  assert(a.dtype==dtype,label..' dtype '..a.dtype..' ~= '..dtype)
  assert(a.size==#e,label..' size')
  for i=1,#e do assert(eqnum(a[i],e[i],eps),label..' value '..i..' '..tostring(a[i])..' ~= '..tostring(e[i])) end
end
local function check_complex(a,dtype,e,label,eps)
  eps=eps or 1e-5
  assert(a.dtype==dtype,label..' dtype')
  for i=1,#e do local z=a[i]; assert(eqnum(z.real,e[i][1],eps) and eqnum(z.imag,e[i][2],eps),label..' complex '..i) end
end

-- Development oracle NumPy 2.3.5; exact source truth is uploaded NumPy main.
do
 local a=np.array({true,false},'bool')
 local r=a:astype('S')
 local e={'True','False'}
 check_strings(r,'|S5',e,'bool->S')
end
do
 local a=np.array({true,false},'bool')
 local r=a:astype('U')
 local e={'True','False'}
 check_strings(r,'<U5',e,'bool->U')
end
do
 local a=np.array({1,-2,127},'int8')
 local r=a:astype('S')
 local e={'1','-2','127'}
 check_strings(r,'|S4',e,'int8->S')
end
do
 local a=np.array({1,-2,127},'int8')
 local r=a:astype('U')
 local e={'1','-2','127'}
 check_strings(r,'<U4',e,'int8->U')
end
do
 local a=np.array({0,9,255},'uint8')
 local r=a:astype('S')
 local e={'0','9','255'}
 check_strings(r,'|S3',e,'uint8->S')
end
do
 local a=np.array({0,9,255},'uint8')
 local r=a:astype('U')
 local e={'0','9','255'}
 check_strings(r,'<U3',e,'uint8->U')
end
do
 local a=np.array({1,-2,32767},'int16')
 local r=a:astype('S')
 local e={'1','-2','32767'}
 check_strings(r,'|S6',e,'int16->S')
end
do
 local a=np.array({1,-2,32767},'int16')
 local r=a:astype('U')
 local e={'1','-2','32767'}
 check_strings(r,'<U6',e,'int16->U')
end
do
 local a=np.array({0,42,65535},'uint16')
 local r=a:astype('S')
 local e={'0','42','65535'}
 check_strings(r,'|S5',e,'uint16->S')
end
do
 local a=np.array({0,42,65535},'uint16')
 local r=a:astype('U')
 local e={'0','42','65535'}
 check_strings(r,'<U5',e,'uint16->U')
end
do
 local a=np.array({1,-2,2147483647},'int32')
 local r=a:astype('S')
 local e={'1','-2','2147483647'}
 check_strings(r,'|S11',e,'int32->S')
end
do
 local a=np.array({1,-2,2147483647},'int32')
 local r=a:astype('U')
 local e={'1','-2','2147483647'}
 check_strings(r,'<U11',e,'int32->U')
end
do
 local a=np.array({0,42,4294967295},'uint32')
 local r=a:astype('S')
 local e={'0','42','4294967295'}
 check_strings(r,'|S10',e,'uint32->S')
end
do
 local a=np.array({0,42,4294967295},'uint32')
 local r=a:astype('U')
 local e={'0','42','4294967295'}
 check_strings(r,'<U10',e,'uint32->U')
end
do
 local a=np.array({1,-2,9223372036854775807},'int64')
 local r=a:astype('S')
 local e={'1','-2','9223372036854775807'}
 check_strings(r,'|S21',e,'int64->S')
end
do
 local a=np.array({1,-2,9223372036854775807},'int64')
 local r=a:astype('U')
 local e={'1','-2','9223372036854775807'}
 check_strings(r,'<U21',e,'int64->U')
end
do
 local a=np.array({0,42,9223372036854775807},'uint64')
 local r=a:astype('S')
 local e={'0','42','9223372036854775807'}
 check_strings(r,'|S20',e,'uint64->S')
end
do
 local a=np.array({0,42,9223372036854775807},'uint64')
 local r=a:astype('U')
 local e={'0','42','9223372036854775807'}
 check_strings(r,'<U20',e,'uint64->U')
end
do
 local a=np.array({0.0,1.5,-2.0},'float16')
 local r=a:astype('S')
 local e={'0.0','1.5','-2.0'}
 check_strings(r,'|S32',e,'float16->S')
end
do
 local a=np.array({0.0,1.5,-2.0},'float16')
 local r=a:astype('U')
 local e={'0.0','1.5','-2.0'}
 check_strings(r,'<U32',e,'float16->U')
end
do
 local a=np.array({1.25,-2.5,math.huge,0/0},'float32')
 local r=a:astype('S')
 local e={'1.25','-2.5','inf','nan'}
 check_strings(r,'|S32',e,'float32->S')
end
do
 local a=np.array({1.25,-2.5,math.huge,0/0},'float32')
 local r=a:astype('U')
 local e={'1.25','-2.5','inf','nan'}
 check_strings(r,'<U32',e,'float32->U')
end
do
 local a=np.array({1.25,-2.5,math.huge,-math.huge},'float64')
 local r=a:astype('S')
 local e={'1.25','-2.5','inf','-inf'}
 check_strings(r,'|S32',e,'float64->S')
end
do
 local a=np.array({1.25,-2.5,math.huge,-math.huge},'float64')
 local r=a:astype('U')
 local e={'1.25','-2.5','inf','-inf'}
 check_strings(r,'<U32',e,'float64->U')
end
do
 local a=np.array({np.complex(1.0,2.0),np.complex(-3.0,0.0),np.complex(0.0,-2.0)},'complex64')
 local r=a:astype('S')
 local e={'(1+2j)','(-3+0j)','-2j'}
 check_strings(r,'|S64',e,'complex64->S')
end
do
 local a=np.array({np.complex(1.0,2.0),np.complex(-3.0,0.0),np.complex(0.0,-2.0)},'complex64')
 local r=a:astype('U')
 local e={'(1+2j)','(-3+0j)','-2j'}
 check_strings(r,'<U64',e,'complex64->U')
end
do
 local a=np.array({np.complex(1.0,2.0),np.complex(-3.0,0.0),np.complex(0.0,-2.0)},'complex128')
 local r=a:astype('S')
 local e={'(1+2j)','(-3+0j)','-2j'}
 check_strings(r,'|S64',e,'complex128->S')
end
do
 local a=np.array({np.complex(1.0,2.0),np.complex(-3.0,0.0),np.complex(0.0,-2.0)},'complex128')
 local r=a:astype('U')
 local e={'(1+2j)','(-3+0j)','-2j'}
 check_strings(r,'<U64',e,'complex128->U')
end
do
 local r=np.astype(np.array({-123,45},'int32'),'U2')
 local e={'-1','45'}
 check_strings(r,'<U2',e,'fixed int32->U2')
end
do
 local r=np.astype(np.array({-123,45},'int32'),'S2')
 local e={'-1','45'}
 check_strings(r,'|S2',e,'fixed int32->S2')
end
do
 local r=np.astype(np.array({12.5,-3.25},'float32'),'U3')
 local e={'12.','-3.'}
 check_strings(r,'<U3',e,'fixed float32->U3')
end
do
 local r=np.astype(np.array({np.complex(1.0,2.0),np.complex(-3.0,0.0)},'complex64'),'U4')
 local e={'(1+2','(-3+'}
 check_strings(r,'<U4',e,'fixed complex64->U4')
end
do
 local r=np.astype(np.array({true,false},'bool'),'S3')
 local e={'Tru','Fal'}
 check_strings(r,'|S3',e,'fixed bool->S3')
end
do
 local a=np.array({'','0','False',' ','x'},'U8')
 local r=a:astype('bool')
 local e={false,true,true,true,true}
 check_numeric(r,'bool',e,'U8->bool',1e-3)
end
do
 local a=np.array({'','0','False',' ','x'},'S8')
 local r=a:astype('bool')
 local e={false,true,true,true,true}
 check_numeric(r,'bool',e,'S8->bool',1e-3)
end
do
 local a=np.array({'1','-2','1_000',' +7 ','01'},'U8')
 local r=a:astype('int64')
 local e={1,-2,1000,7,1}
 check_numeric(r,'int64',e,'U8->int64',1e-3)
end
do
 local a=np.array({'1','-2','1_000',' +7 ','01'},'S8')
 local r=a:astype('int32')
 local e={1,-2,1000,7,1}
 check_numeric(r,'int32',e,'S8->int32',1e-3)
end
do
 local a=np.array({'1.5','-2.25','nan','INF',' 3.0 '},'U12')
 local r=a:astype('float64')
 local e={1.5,-2.25,0/0,math.huge,3.0}
 check_numeric(r,'float64',e,'U12->float64',1e-3)
end
do
 local a=np.array({'1.5','-2.25','nan','INF',' 3.0 '},'S12')
 local r=a:astype('float32')
 local e={1.5,-2.25,0/0,math.huge,3.0}
 check_numeric(r,'float32',e,'S12->float32',1e-3)
end
do
 local a=np.array({'1.5','-2.25','3'},'U8')
 local r=a:astype('float16')
 local e={1.5,-2.25,3.0}
 check_numeric(r,'float16',e,'U8->float16',1e-3)
end
do
 local a=np.array({'1+2j','(1+2j)','-3j','j','+j','-j','1_0+2_0j'},'U16')
 local r=a:astype('complex64')
 local e={{1.0,2.0},{1.0,2.0},{0.0,-3.0},{0.0,1.0},{0.0,1.0},{0.0,-1.0},{10.0,20.0}}
 check_complex(r,'complex64',e,'U16->complex64')
end
do
 local a=np.array({'1+2j','(1+2j)','-3j','j','+j','-j','1_0+2_0j'},'U16')
 local r=a:astype('complex128')
 local e={{1.0,2.0},{1.0,2.0},{0.0,-3.0},{0.0,1.0},{0.0,1.0},{0.0,-1.0},{10.0,20.0}}
 check_complex(r,'complex128',e,'U16->complex128')
end
do
 local a=np.array({'1+2j','(1+2j)','-3j','j','+j','-j','1_0+2_0j'},'S16')
 local r=a:astype('complex64')
 local e={{1.0,2.0},{1.0,2.0},{0.0,-3.0},{0.0,1.0},{0.0,1.0},{0.0,-1.0},{10.0,20.0}}
 check_complex(r,'complex64',e,'S16->complex64')
end
do
 local a=np.array({'1+2j','(1+2j)','-3j','j','+j','-j','1_0+2_0j'},'S16')
 local r=a:astype('complex128')
 local e={{1.0,2.0},{1.0,2.0},{0.0,-3.0},{0.0,1.0},{0.0,1.0},{0.0,-1.0},{10.0,20.0}}
 check_complex(r,'complex128',e,'S16->complex128')
end
do
 local a=np.array({'1e2'},'U8')
 assert(not pcall(function() return a:astype('int64') end),'expected cast failure 1e2->int64')
end
do
 local a=np.array({'nan'},'U8')
 assert(not pcall(function() return a:astype('int64') end),'expected cast failure nan->int64')
end
do
 local a=np.array({'1+2j'},'U8')
 assert(not pcall(function() return a:astype('float64') end),'expected cast failure 1+2j->float64')
end
do
 local a=np.array({'xyz'},'U8')
 assert(not pcall(function() return a:astype('float32') end),'expected cast failure xyz->float32')
end
do
 local a=np.array({'-1'},'U8')
 assert(not pcall(function() return a:astype('uint8') end),'expected cast failure -1->uint8')
end
do
 local r=np.astype(np.array({1,-2},'int64'),'timedelta64[D]')
 assert(r.dtype=='timedelta64[D]','time dtype 49')
 local e={1,-2}
 for i=1,#e do assert(r[i].value==e[i],'time value 49') end
end
do
 local r=np.astype(np.array({1,-2},'int32'),'timedelta64[h]')
 assert(r.dtype=='timedelta64[h]','time dtype 50')
 local e={1,-2}
 for i=1,#e do assert(r[i].value==e[i],'time value 50') end
end
do
 local r=np.astype(np.array({1.5,-2.25},'float64'),'timedelta64[D]')
 assert(r.dtype=='timedelta64[D]','time dtype 51')
 local e={1,-2}
 for i=1,#e do assert(r[i].value==e[i],'time value 51') end
end
do
 local r=np.astype(np.array({1,-2},'int64'),'datetime64[D]')
 assert(r.dtype=='datetime64[D]','time dtype 52')
 local e={1,-2}
 for i=1,#e do assert(r[i].value==e[i],'time value 52') end
end
do
 local r=np.astype(np.array({1.5,-2.25},'float64'),'datetime64[h]')
 assert(r.dtype=='datetime64[h]','time dtype 53')
 local e={1,-2}
 for i=1,#e do assert(r[i].value==e[i],'time value 53') end
end
do
 local r=np.astype(np.array({1,-2},'timedelta64[D]'),'int64')
 local e={1,-2}
 check_numeric(r,'int64',e,'timedelta64[D]->int64')
end
do
 local r=np.astype(np.array({1,-2},'timedelta64[D]'),'float64')
 local e={1.0,-2.0}
 check_numeric(r,'float64',e,'timedelta64[D]->float64')
end
do
 local r=np.astype(np.array({1,-2},'datetime64[D]'),'int64')
 local e={1,-2}
 check_numeric(r,'int64',e,'datetime64[D]->int64')
end
do
 local r=np.astype(np.array({1,-2},'datetime64[D]'),'float64')
 local e={1.0,-2.0}
 check_numeric(r,'float64',e,'datetime64[D]->float64')
end
do
 assert(not pcall(function() return np.astype(np.array({1},'int64'),'datetime64') end),'generic datetime numeric reject')
end
do
 local x=-9223372036854775807-1; local r=np.astype(np.array({x},'int64'),'datetime64'); assert(r[1].isnat,'generic datetime NaT')
end
do
 local r=np.astype(np.array({1,-2},'int64'),'timedelta64'); assert(r.dtype=='timedelta64' and r[1].value==1 and r[2].value==-2,'generic timedelta numeric')
end
do
 local a=np.array({'2011-03-16','1920-01-01','NaT'},'U10')
 local r=a:astype('datetime64')
 assert(r.dtype=='datetime64[D]','generic datetime inferred dtype')
 local e={15049,-18263,-9223372036854775808}
 for i=1,#e do assert(r[i].value==e[i],'generic datetime value') end
end
do
 local a=np.array({'2011-03-16','1920-01-01','NaT'},'S10')
 local r=a:astype('datetime64')
 assert(r.dtype=='datetime64[D]','generic datetime inferred dtype')
 local e={15049,-18263,-9223372036854775808}
 for i=1,#e do assert(r[i].value==e[i],'generic datetime value') end
end
do
 local r=np.astype(np.array({'1','-2','NaT'},'U4'),'timedelta64[D]')
 local e={1,-2,-9223372036854775808}
 for i=1,#e do assert(r[i].value==e[i],'string timedelta') end
end
do
 local r=np.astype(np.array({'1','-2','NaT'},'S4'),'timedelta64[D]')
 local e={1,-2,-9223372036854775808}
 for i=1,#e do assert(r[i].value==e[i],'string timedelta') end
end
do
 local r=np.astype(np.array({1,-2},'datetime64[D]'),'S')
 local e={'1970-01-02','1969-12-30'}
 check_strings(r,'|S28',e,'datetime64[D]->S')
end
do
 local r=np.astype(np.array({1,-2},'datetime64[D]'),'U')
 local e={'1970-01-02','1969-12-30'}
 check_strings(r,'<U28',e,'datetime64[D]->U')
end
do
 local r=np.astype(np.array({1,-2},'timedelta64[D]'),'S')
 local e={'1 days','-2 days'}
 check_strings(r,'|S21',e,'timedelta64[D]->S')
end
do
 local r=np.astype(np.array({1,-2},'timedelta64[D]'),'U')
 local e={'1 days','-2 days'}
 check_strings(r,'<U21',e,'timedelta64[D]->U')
end
do
 local a=np.array({1,'x'})
 local e={'1','x'}
 check_strings(a,'<U21',e,'mixed discovery 69')
end
do
 local a=np.array({1.25,'x'})
 local e={'1.25','x'}
 check_strings(a,'<U32',e,'mixed discovery 70')
end
do
 local a=np.array({true,'x'})
 local e={'True','x'}
 check_strings(a,'<U5',e,'mixed discovery 71')
end
do
 local a=np.array({np.complex(1.0,2.0),'x'})
 local e={'(1+2j)','x'}
 check_strings(a,'<U64',e,'mixed discovery 72')
end
do
 local a=np.array({1,-22},'U')
 local e={'1','-22'}
 check_strings(a,'<U3',e,'explicit unsized U 73')
end
do
 local a=np.array({1.25,-2.5},'S')
 local e={'1.25','-2.5'}
 check_strings(a,'|S4',e,'explicit unsized S 74')
end
do
 local a=np.array({true,false},'U')
 local e={'True','False'}
 check_strings(a,'<U5',e,'explicit unsized U 75')
end
do
 local a=np.array({np.complex(1.0,2.0),np.complex(-3.0,0.0)},'S')
 local e={'(1+2j)','(-3+0j)'}
 check_strings(a,'|S7',e,'explicit unsized S 76')
end
print('string cast/discovery differential: 77 cases ok')
