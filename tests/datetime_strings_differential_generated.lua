local np=require('luaray_core')

local function check_scalar(s, unit, dtype, value, iso, label)
  local x
  if unit==nil then x=np.datetime64(s) else x=np.datetime64(s,unit) end
  assert(x.dtype==dtype,label..' dtype '..x.dtype..' ~= '..dtype)
  if value == -9223372036854775808 then assert(x.isnat,label..' expected NaT')
  else assert(not x.isnat and x.value==value,label..' value '..tostring(x.value)..' ~= '..tostring(value)) end
  assert(tostring(x)==iso,label..' iso '..tostring(x)..' ~= '..iso)
end

-- Development oracle NumPy 2.3.5; exact source truth is uploaded NumPy main.
check_scalar('2010',nil,'datetime64[Y]',40,'2010','infer 0')
check_scalar('2010-03',nil,'datetime64[M]',482,'2010-03','infer 1')
check_scalar('2010-03-15',nil,'datetime64[D]',14683,'2010-03-15','infer 2')
check_scalar('2010-03-15T12',nil,'datetime64[h]',352404,'2010-03-15T12','infer 3')
check_scalar('2010-03-15T12:30',nil,'datetime64[m]',21144270,'2010-03-15T12:30','infer 4')
check_scalar('2010-03-15T12:30:45',nil,'datetime64[s]',1268656245,'2010-03-15T12:30:45','infer 5')
check_scalar('2010-03-15T12:30:45.1',nil,'datetime64[ms]',1268656245100,'2010-03-15T12:30:45.100','infer 6')
check_scalar('2010-03-15T12:30:45.123',nil,'datetime64[ms]',1268656245123,'2010-03-15T12:30:45.123','infer 7')
check_scalar('2010-03-15T12:30:45.1234',nil,'datetime64[us]',1268656245123400,'2010-03-15T12:30:45.123400','infer 8')
check_scalar('2010-03-15T12:30:45.123456',nil,'datetime64[us]',1268656245123456,'2010-03-15T12:30:45.123456','infer 9')
check_scalar('2010-03-15T12:30:45.1234567',nil,'datetime64[ns]',1268656245123456700,'2010-03-15T12:30:45.123456700','infer 10')
check_scalar('2010-03-15T12:30:45.123456789',nil,'datetime64[ns]',1268656245123456789,'2010-03-15T12:30:45.123456789','infer 11')
check_scalar('1970-01-01T00:00:00.123456789012',nil,'datetime64[ps]',123456789012,'1970-01-01T00:00:00.123456789012','infer 12')
check_scalar('1970-01-01T00:00:00.123456789012345',nil,'datetime64[fs]',123456789012345,'1970-01-01T00:00:00.123456789012345','infer 13')
check_scalar('1970-01-01T00:00:05.789012345678901234',nil,'datetime64[as]',5789012345678901234,'1970-01-01T00:00:05.789012345678901234','infer 14')
check_scalar('1969-12-31T23:34:56.789012345678901234',nil,'datetime64[as]',-9024717683847417870,'1969-12-31T23:59:50.975282316152582130','infer 15')
check_scalar('-1980-02-29',nil,'datetime64[D]',-1442649,'-1980-02-29','infer 16')
check_scalar('+10000-01-01T00',nil,'datetime64[h]',70389528,'10000-01-01T00','infer 17')
check_scalar('NaT',nil,'datetime64',-9223372036854775808,'NaT','infer 18')
check_scalar('',nil,'datetime64',-9223372036854775808,'NaT','infer 19')
check_scalar('2010-03-15T12:30:45.123456789','Y','datetime64[Y]',40,'2010','explicit 20')
check_scalar('2010-03-15T12:30:45.123456789','M','datetime64[M]',482,'2010-03','explicit 21')
check_scalar('2010-03-15T12:30:45.123456789','W','datetime64[W]',2097,'2010-03-11','explicit 22')
check_scalar('2010-03-15T12:30:45.123456789','D','datetime64[D]',14683,'2010-03-15','explicit 23')
check_scalar('2010-03-15T12:30:45.123456789','h','datetime64[h]',352404,'2010-03-15T12','explicit 24')
check_scalar('2010-03-15T12:30:45.123456789','m','datetime64[m]',21144270,'2010-03-15T12:30','explicit 25')
check_scalar('2010-03-15T12:30:45.123456789','s','datetime64[s]',1268656245,'2010-03-15T12:30:45','explicit 26')
check_scalar('2010-03-15T12:30:45.123456789','ms','datetime64[ms]',1268656245123,'2010-03-15T12:30:45.123','explicit 27')
check_scalar('2010-03-15T12:30:45.123456789','us','datetime64[us]',1268656245123456,'2010-03-15T12:30:45.123456','explicit 28')
check_scalar('2010-03-15T12:30:45.123456789','ns','datetime64[ns]',1268656245123456789,'2010-03-15T12:30:45.123456789','explicit 29')
check_scalar('2010-03-15T12:30:45.123456789','ps','datetime64[ps]',-4169095962502272504,'1969-11-13T17:55:04.037497727496','explicit 30')
check_scalar('2010-03-15T12:30:45.123456789','fs','datetime64[fs]',-131801843913838784,'1969-12-31T23:57:48.198156086161216','explicit 31')
check_scalar('2010-03-15T12:30:45.123456789','as','datetime64[as]',-2674635397871922688,'1969-12-31T23:59:57.325364602128077312','explicit 32')
check_scalar('1969-12-31T23:59:59.999999999','Y','datetime64[Y]',-1,'1969','explicit 33')
check_scalar('1969-12-31T23:59:59.999999999','M','datetime64[M]',-1,'1969-12','explicit 34')
check_scalar('1969-12-31T23:59:59.999999999','W','datetime64[W]',-1,'1969-12-25','explicit 35')
check_scalar('1969-12-31T23:59:59.999999999','D','datetime64[D]',-1,'1969-12-31','explicit 36')
check_scalar('1969-12-31T23:59:59.999999999','h','datetime64[h]',-1,'1969-12-31T23','explicit 37')
check_scalar('1969-12-31T23:59:59.999999999','m','datetime64[m]',-1,'1969-12-31T23:59','explicit 38')
check_scalar('1969-12-31T23:59:59.999999999','s','datetime64[s]',-1,'1969-12-31T23:59:59','explicit 39')
check_scalar('1969-12-31T23:59:59.999999999','ms','datetime64[ms]',-1,'1969-12-31T23:59:59.999','explicit 40')
check_scalar('1969-12-31T23:59:59.999999999','us','datetime64[us]',-1,'1969-12-31T23:59:59.999999','explicit 41')
check_scalar('1969-12-31T23:59:59.999999999','ns','datetime64[ns]',-1,'1969-12-31T23:59:59.999999999','explicit 42')
check_scalar('1969-12-31T23:59:59.999999999','ps','datetime64[ps]',-1000,'1969-12-31T23:59:59.999999999000','explicit 43')
check_scalar('1969-12-31T23:59:59.999999999','fs','datetime64[fs]',-1000000,'1969-12-31T23:59:59.999999999000000','explicit 44')
check_scalar('1969-12-31T23:59:59.999999999','as','datetime64[as]',-1000000000,'1969-12-31T23:59:59.999999999000000000','explicit 45')
check_scalar('2032-07-18T12:23:34.123456','Y','datetime64[Y]',62,'2032','explicit 46')
check_scalar('2032-07-18T12:23:34.123456','M','datetime64[M]',750,'2032-07','explicit 47')
check_scalar('2032-07-18T12:23:34.123456','W','datetime64[W]',3263,'2032-07-15','explicit 48')
check_scalar('2032-07-18T12:23:34.123456','D','datetime64[D]',22844,'2032-07-18','explicit 49')
check_scalar('2032-07-18T12:23:34.123456','h','datetime64[h]',548268,'2032-07-18T12','explicit 50')
check_scalar('2032-07-18T12:23:34.123456','m','datetime64[m]',32896103,'2032-07-18T12:23','explicit 51')
check_scalar('2032-07-18T12:23:34.123456','s','datetime64[s]',1973766214,'2032-07-18T12:23:34','explicit 52')
check_scalar('2032-07-18T12:23:34.123456','ms','datetime64[ms]',1973766214123,'2032-07-18T12:23:34.123','explicit 53')
check_scalar('2032-07-18T12:23:34.123456','us','datetime64[us]',1973766214123456,'2032-07-18T12:23:34.123456','explicit 54')
check_scalar('2032-07-18T12:23:34.123456','ns','datetime64[ns]',1973766214123456000,'2032-07-18T12:23:34.123456000','explicit 55')
check_scalar('2032-07-18T12:23:34.123456','ps','datetime64[ps]',-35401763466022912,'1969-12-31T14:09:58.236533977088','explicit 56')
check_scalar('2032-07-18T12:23:34.123456','fs','datetime64[fs]',1491724681396191232,'1970-01-01T00:24:51.724681396191232','explicit 57')
check_scalar('2032-07-18T12:23:34.123456','as','datetime64[as]',-2461588574282448896,'1969-12-31T23:59:57.538411425717551104','explicit 58')
check_scalar('-0044-03-15T12:00:00','Y','datetime64[Y]',-2014,'-044','explicit 59')
check_scalar('-0044-03-15T12:00:00','M','datetime64[M]',-24166,'-044-03','explicit 60')
check_scalar('-0044-03-15T12:00:00','W','datetime64[W]',-105075,'-044-03-15','explicit 61')
check_scalar('-0044-03-15T12:00:00','D','datetime64[D]',-735525,'-044-03-15','explicit 62')
check_scalar('-0044-03-15T12:00:00','h','datetime64[h]',-17652588,'-044-03-15T12','explicit 63')
check_scalar('-0044-03-15T12:00:00','m','datetime64[m]',-1059155280,'-044-03-15T12:00','explicit 64')
check_scalar('-0044-03-15T12:00:00','s','datetime64[s]',-63549316800,'-044-03-15T12:00:00','explicit 65')
check_scalar('-0044-03-15T12:00:00','ms','datetime64[ms]',-63549316800000,'-044-03-15T12:00:00.000','explicit 66')
check_scalar('-0044-03-15T12:00:00','us','datetime64[us]',-63549316800000000,'-044-03-15T12:00:00.000000','explicit 67')
check_scalar('-0044-03-15T12:00:00','ns','datetime64[ns]',-8209084578871345152,'1709-11-12T10:43:41.128654848','explicit 68')
check_scalar('-0044-03-15T12:00:00','ps','datetime64[ps]',-283466070594682880,'1969-12-28T17:15:33.929405317120','explicit 69')
check_scalar('-0044-03-15T12:00:00','fs','datetime64[fs]',-6764909489039605760,'1969-12-31T22:07:15.090510960394240','explicit 70')
check_scalar('-0044-03-15T12:00:00','as','datetime64[as]',5045586011799683072,'1970-01-01T00:00:05.045586011799683072','explicit 71')
check_scalar('1980-02-29 01:02:03','s','datetime64[s]',320634123,'1980-02-29T01:02:03','variant 72')
check_scalar('+1980-02-29 01:02:03','s','datetime64[s]',320634123,'1980-02-29T01:02:03','variant 73')
check_scalar('-1980-02-29 01:02:03','s','datetime64[s]',-124644869877,'-1980-02-29T01:02:03','variant 74')
check_scalar('+1980-02-29 01:02:03Z','s','datetime64[s]',320634123,'1980-02-29T01:02:03','variant 75')
check_scalar('-1980-02-29 01:02:03Z','s','datetime64[s]',-124644869877,'-1980-02-29T01:02:03','variant 76')
check_scalar('1980-02-29 00:32:03-0130','s','datetime64[s]',320637723,'1980-02-29T02:02:03','variant 77')
check_scalar('1980-02-29 00:02:03+01:30','s','datetime64[s]',320625123,'1980-02-28T22:32:03','variant 78')
check_scalar('1980-02-29 00:32:03.506-02','ms','datetime64[ms]',320639523506,'1980-02-29T02:32:03.506','variant 79')
check_scalar('1977-03-02T12:30-0230','m','datetime64[m]',3769380,'1977-03-02T15:00','variant 80')
check_scalar('  2010-01-02T03:04:05  ','s','datetime64[s]',1262401445,'2010-01-02T03:04:05','variant 81')
do
 local a=np.array({'1980-02-29T01:02:03','1980-02-29 00:02:03+01:30','NaT'},'datetime64[s]')
 local expected={320634123,320625123,-9223372036854775808}
 assert(a.dtype=='datetime64[s]','array dtype 82')
 for i=1,#expected do assert(a[i].value==expected[i] or (a[i].isnat and expected[i]==-9223372036854775808),'array parse '..i) end
end
do
 local a=np.array({'1970-01-01','1969-12-31','2000-02-29','1900-02-28'},'datetime64[D]')
 local expected={0,-1,11016,-25509}
 assert(a.dtype=='datetime64[D]','array dtype 83')
 for i=1,#expected do assert(a[i].value==expected[i] or (a[i].isnat and expected[i]==-9223372036854775808),'array parse '..i) end
end
do
 local a=np.array({'2010-01-01T00:00:00.123456789','2010-01-01T00:00:00.000000001'},'datetime64[ns]')
 local expected={1262304000123456789,1262304000000000001}
 assert(a.dtype=='datetime64[ns]','array dtype 84')
 for i=1,#expected do assert(a[i].value==expected[i] or (a[i].isnat and expected[i]==-9223372036854775808),'array parse '..i) end
end
do
 local a=np.array({'2010','2010-01-02'},'datetime64')
 local expected={14610,14611}
 assert(a.dtype=='datetime64[D]','generic discovery 85')
 for i=1,#expected do assert(a[i].value==expected[i],'generic discovery value '..i) end
end
do
 local a=np.array({'2010-01','2010-01-02T03:04'},'datetime64')
 local expected={21038400,21040024}
 assert(a.dtype=='datetime64[m]','generic discovery 86')
 for i=1,#expected do assert(a[i].value==expected[i],'generic discovery value '..i) end
end
do
 local x=np.datetime64('1959-10-13','Y')
 assert(np.datetime_as_string(x)=='1959','fmt default 87')
end
do
 local x=np.datetime64('1959-10-13','M')
 assert(np.datetime_as_string(x)=='1959-10','fmt default 88')
end
do
 local x=np.datetime64('1959-10-13','D')
 assert(np.datetime_as_string(x)=='1959-10-13','fmt default 89')
end
do
 local x=np.datetime64('1959-10-13T12:34:56.789012345678901234','h')
 assert(np.datetime_as_string(x)=='1959-10-13T12','fmt default 90')
end
do
 local x=np.datetime64('1959-10-13T12:34:56.789012345678901234','m')
 assert(np.datetime_as_string(x)=='1959-10-13T12:34','fmt default 91')
end
do
 local x=np.datetime64('1959-10-13T12:34:56.789012345678901234','s')
 assert(np.datetime_as_string(x)=='1959-10-13T12:34:56','fmt default 92')
end
do
 local x=np.datetime64('1959-10-13T12:34:56.789012345678901234','ms')
 assert(np.datetime_as_string(x)=='1959-10-13T12:34:56.789','fmt default 93')
end
do
 local x=np.datetime64('1959-10-13T12:34:56.789012345678901234','us')
 assert(np.datetime_as_string(x)=='1959-10-13T12:34:56.789012','fmt default 94')
end
do
 local x=np.datetime64('1969-12-31T23:34:56.789012345678901234','ns')
 assert(np.datetime_as_string(x)=='1969-12-31T23:34:56.789012345','fmt default 95')
end
do
 local x=np.datetime64('1969-12-31T23:34:56.789012345678901234','ps')
 assert(np.datetime_as_string(x)=='1969-12-31T23:34:56.789012345678','fmt default 96')
end
do
 local x=np.datetime64('1969-12-31T23:34:56.789012345678901234','fs')
 assert(np.datetime_as_string(x)=='1969-12-31T23:34:56.789012345678901','fmt default 97')
end
do
 local x=np.datetime64('1970-01-01T00:00:05.789012345678901234','as')
 assert(np.datetime_as_string(x)=='1970-01-01T00:00:05.789012345678901234','fmt default 98')
end
do
 local x=np.datetime64('2032-07-18T12:23:34.123456','us')
 assert(np.datetime_as_string(x,{unit='Y',casting='unsafe'})=='2032','fmt unit 99')
end
do
 local x=np.datetime64('2032-07-18T12:23:34.123456','us')
 assert(np.datetime_as_string(x,{unit='M',casting='unsafe'})=='2032-07','fmt unit 100')
end
do
 local x=np.datetime64('2032-07-18T12:23:34.123456','us')
 assert(np.datetime_as_string(x,{unit='W',casting='unsafe'})=='2032-07-18','fmt unit 101')
end
do
 local x=np.datetime64('2032-07-18T12:23:34.123456','us')
 assert(np.datetime_as_string(x,{unit='D',casting='unsafe'})=='2032-07-18','fmt unit 102')
end
do
 local x=np.datetime64('2032-07-18T12:23:34.123456','us')
 assert(np.datetime_as_string(x,{unit='h',casting='unsafe'})=='2032-07-18T12','fmt unit 103')
end
do
 local x=np.datetime64('2032-07-18T12:23:34.123456','us')
 assert(np.datetime_as_string(x,{unit='m',casting='unsafe'})=='2032-07-18T12:23','fmt unit 104')
end
do
 local x=np.datetime64('2032-07-18T12:23:34.123456','us')
 assert(np.datetime_as_string(x,{unit='s',casting='unsafe'})=='2032-07-18T12:23:34','fmt unit 105')
end
do
 local x=np.datetime64('2032-07-18T12:23:34.123456','us')
 assert(np.datetime_as_string(x,{unit='ms',casting='unsafe'})=='2032-07-18T12:23:34.123','fmt unit 106')
end
do
 local x=np.datetime64('2032-07-18T12:23:34.123456','us')
 assert(np.datetime_as_string(x,{unit='us',casting='unsafe'})=='2032-07-18T12:23:34.123456','fmt unit 107')
end
do
 local x=np.datetime64('2032-07-18T12:23:34.123456','us')
 assert(np.datetime_as_string(x,{unit='ns',casting='unsafe'})=='2032-07-18T12:23:34.123456000','fmt unit 108')
end
do
 local x=np.datetime64('2032-07-18T12:23:34.123456','us')
 assert(np.datetime_as_string(x,{unit='ps',casting='unsafe'})=='2032-07-18T12:23:34.123456000000','fmt unit 109')
end
do
 local x=np.datetime64('2032-07-18T12:23:34.123456','us')
 assert(np.datetime_as_string(x,{unit='fs',casting='unsafe'})=='2032-07-18T12:23:34.123456000000000','fmt unit 110')
end
do
 local x=np.datetime64('2032-07-18T12:23:34.123456','us')
 assert(np.datetime_as_string(x,{unit='as',casting='unsafe'})=='2032-07-18T12:23:34.123456000000000000','fmt unit 111')
end
do
 local x=np.datetime64('2032-07-18T12:23:34.123456','us')
 assert(np.datetime_as_string(x,{unit='auto'})=='2032-07-18T12:23:34.123456','fmt auto 112')
end
do
 local x=np.datetime64('2032-07-18T12:23:34.12','us')
 assert(np.datetime_as_string(x,{unit='auto'})=='2032-07-18T12:23:34.120','fmt auto 113')
end
do
 local x=np.datetime64('2032-07-18T12:23:34','us')
 assert(np.datetime_as_string(x,{unit='auto'})=='2032-07-18T12:23:34','fmt auto 114')
end
do
 local x=np.datetime64('2032-07-18T12:23:00','us')
 assert(np.datetime_as_string(x,{unit='auto'})=='2032-07-18T12:23','fmt auto 115')
end
do
 local x=np.datetime64('2032-07-18T12:00:00','us')
 assert(np.datetime_as_string(x,{unit='auto'})=='2032-07-18T12:00','fmt auto 116')
end
do
 local x=np.datetime64('2032-07-18T00:00:00','us')
 assert(np.datetime_as_string(x,{unit='auto'})=='2032-07-18','fmt auto 117')
end
do
 local x=np.datetime64('2032-07-01T00:00:00','us')
 assert(np.datetime_as_string(x,{unit='auto'})=='2032-07-01','fmt auto 118')
end
do
 local x=np.datetime64('2032-01-01T00:00:00','us')
 assert(np.datetime_as_string(x,{unit='auto'})=='2032-01-01','fmt auto 119')
end
do
 local x=np.datetime64('2010-03-15T06:30','m')
 assert(np.datetime_as_string(x,{timezone='UTC'})=='2010-03-15T06:30Z','fmt UTC 120')
end
do
 local x=np.datetime64('2010-03-15T06:30','m')
 assert(np.datetime_as_string(x,{timezone=-300})=='2010-03-15T01:30-0500','fmt numeric offset 121')
end
do
 local x=np.datetime64('2032-07-18T12:23:34.123456','us')
 assert(not pcall(function() return np.datetime_as_string(x,{unit='Y',casting='same_value'}) end),'same_value reject 122')
end
do
 local x=np.datetime64('2032-07-18T12:23:34.123456','us')
 assert(not pcall(function() return np.datetime_as_string(x,{unit='Y',casting='safe'}) end),'safe reject 123')
end
do
 assert(not pcall(function() return np.datetime64('badvalue','us') end),'bad parser 124')
end
do
 assert(not pcall(function() return np.datetime64('1980X','us') end),'bad parser 125')
end
do
 assert(not pcall(function() return np.datetime64('1980-','us') end),'bad parser 126')
end
do
 assert(not pcall(function() return np.datetime64('1980-00','us') end),'bad parser 127')
end
do
 assert(not pcall(function() return np.datetime64('1980-13','us') end),'bad parser 128')
end
do
 assert(not pcall(function() return np.datetime64('1980-1','us') end),'bad parser 129')
end
do
 assert(not pcall(function() return np.datetime64('1980-1-02','us') end),'bad parser 130')
end
do
 assert(not pcall(function() return np.datetime64('1980-Mor','us') end),'bad parser 131')
end
do
 assert(not pcall(function() return np.datetime64('1980-01-','us') end),'bad parser 132')
end
do
 assert(not pcall(function() return np.datetime64('1980-01-0','us') end),'bad parser 133')
end
do
 assert(not pcall(function() return np.datetime64('1980-01-00','us') end),'bad parser 134')
end
do
 assert(not pcall(function() return np.datetime64('1980-01-32','us') end),'bad parser 135')
end
do
 assert(not pcall(function() return np.datetime64('1979-02-29','us') end),'bad parser 136')
end
do
 assert(not pcall(function() return np.datetime64('1980-02-30','us') end),'bad parser 137')
end
do
 assert(not pcall(function() return np.datetime64('1980-03-32','us') end),'bad parser 138')
end
do
 assert(not pcall(function() return np.datetime64('1980-04-31','us') end),'bad parser 139')
end
do
 assert(not pcall(function() return np.datetime64('1980-05-32','us') end),'bad parser 140')
end
do
 assert(not pcall(function() return np.datetime64('1980-06-31','us') end),'bad parser 141')
end
do
 assert(not pcall(function() return np.datetime64('1980-07-32','us') end),'bad parser 142')
end
do
 assert(not pcall(function() return np.datetime64('1980-08-32','us') end),'bad parser 143')
end
do
 assert(not pcall(function() return np.datetime64('1980-09-31','us') end),'bad parser 144')
end
do
 assert(not pcall(function() return np.datetime64('1980-10-32','us') end),'bad parser 145')
end
do
 assert(not pcall(function() return np.datetime64('1980-11-31','us') end),'bad parser 146')
end
do
 assert(not pcall(function() return np.datetime64('1980-12-32','us') end),'bad parser 147')
end
do
 assert(not pcall(function() return np.datetime64('1980-02-03%','us') end),'bad parser 148')
end
do
 assert(not pcall(function() return np.datetime64('1980-02-03 q','us') end),'bad parser 149')
end
do
 assert(not pcall(function() return np.datetime64('1980-02-03 25','us') end),'bad parser 150')
end
do
 assert(not pcall(function() return np.datetime64('1980-02-03T25','us') end),'bad parser 151')
end
do
 assert(not pcall(function() return np.datetime64('1980-02-03 24:01','us') end),'bad parser 152')
end
do
 assert(not pcall(function() return np.datetime64('1980-02-03T24:01','us') end),'bad parser 153')
end
do
 assert(not pcall(function() return np.datetime64('1980-02-03 -1','us') end),'bad parser 154')
end
do
 assert(not pcall(function() return np.datetime64('1980-02-03 01:','us') end),'bad parser 155')
end
do
 assert(not pcall(function() return np.datetime64('1980-02-03 01:-1','us') end),'bad parser 156')
end
do
 assert(not pcall(function() return np.datetime64('1980-02-03 01:60','us') end),'bad parser 157')
end
do
 assert(not pcall(function() return np.datetime64('1980-02-03 01:02:','us') end),'bad parser 158')
end
do
 assert(not pcall(function() return np.datetime64('1980-02-03 01:02:-1','us') end),'bad parser 159')
end
do
 assert(not pcall(function() return np.datetime64('1980-02-03 01:02:60','us') end),'bad parser 160')
end
do
 assert(not pcall(function() return np.datetime64('1980-02-03T01:02:03.1234567890123456789','us') end),'bad parser 161')
end
do
 assert(not pcall(function() return np.datetime64('1980-02-03T01:02:03+25','us') end),'bad parser 162')
end
do
 assert(not pcall(function() return np.datetime64('1980-02-03T01:02:03+01:60','us') end),'bad parser 163')
end
do
 assert(not pcall(function() return np.datetime64('1980-02-03T01:02:03Zx','us') end),'bad parser 164')
end
print('datetime strings differential: 165 cases ok')
