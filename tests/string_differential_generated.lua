local np=require('luaray_core')

local function check1(a, dtype, expected, label)
  assert(a.dtype==dtype,label..' dtype '..tostring(a.dtype)..' ~= '..dtype)
  assert(a.ndim==1 and a.size==#expected,label..' shape')
  for i=1,#expected do
    assert(a[i]==expected[i],label..' value '..i..' '..tostring(a[i])..' ~= '..tostring(expected[i]))
  end
end
local function check_bool(a, expected, label)
  assert(a.dtype=='bool',label..' dtype')
  for i=1,#expected do assert(a[i]==expected[i],label..' value '..i) end
end

-- Development oracle NumPy 2.3.5; exact source truth is uploaded NumPy main.
do
 local a=np.array({'a','bb','é','😊'})
 local e={'a','bb','é','😊'}
 check1(a,'<U2',e,'discover 0')
end
do
 local a=np.array({'','x','xyz'})
 local e={'','x','xyz'}
 check1(a,'<U3',e,'discover 1')
end
do
 local a=np.array({'éé','😊x','abc'})
 local e={'éé','😊x','abc'}
 check1(a,'<U3',e,'discover 2')
end
do
 local a=np.array({'α','βγ','日本'})
 local e={'α','βγ','日本'}
 check1(a,'<U2',e,'discover 3')
end
do
 local a=np.array({'á','é','😊😊'})
 local e={'á','é','😊😊'}
 check1(a,'<U2',e,'discover 4')
end
do
 local a=np.array({'abcdef','é','😊','日本'},'U1')
 local e={'a','é','😊','日'}
 check1(a,'<U1',e,'unicode 5')
end
do
 local a=np.array({'abcdef','é😊x','日本語',''},'U2')
 local e={'ab','é😊','日本',''}
 check1(a,'<U2',e,'unicode 6')
end
do
 local a=np.array({'abcdef','é😊x','日本語文','xy'},'U3')
 local e={'abc','é😊x','日本語','xy'}
 check1(a,'<U3',e,'unicode 7')
end
do
 local a=np.array({'hello','αβγδε','😊😊😊😊😊'},'<U4')
 local e={'hell','αβγδ','😊😊😊😊'}
 check1(a,'<U4',e,'unicode 8')
end
do
 local a=np.array({'é','😊','日'},'>U1')
 local e={'é','😊','日'}
 check1(a,'>U1',e,'unicode 9')
end
do
 local a=np.array({'abc','é😊x','日本語'},'>U3')
 local e={'abc','é😊x','日本語'}
 check1(a,'>U3',e,'unicode 10')
end
do
 local a=np.array({'a','b',''},'S1')
 local e={'a','b',''}
 check1(a,'|S1',e,'bytes 11')
end
do
 local a=np.array({'abc','x','zz'},'S2')
 local e={'ab','x','zz'}
 check1(a,'|S2',e,'bytes 12')
end
do
 local a=np.array({'abc','x','hello',''},'S4')
 local e={'abc','x','hell',''}
 check1(a,'|S4',e,'bytes 13')
end
do
 local a=np.array({'abcdefg','xy','123456'},'|S6')
 local e={'abcdef','xy','123456'}
 check1(a,'|S6',e,'bytes 14')
end
do
 local a=np.array({{'a','bb'},{'ccc','d'}},'U3')
 local e={{'a','bb'},{'ccc','d'}}
 assert(a.dtype=='<U3','2d dtype 15')
 local t=a:tolist(); for i=1,#e do for j=1,#e[i] do assert(t[i][j]==e[i][j],'2d value') end end
 local tr=a.T; assert(tr:get(2,1)==e[1][2] and tr:get(1,2)==e[2][1],'transpose values')
end
do
 local a=np.array({{'a','bb'},{'ccc','d'}},'S3')
 local e={{'a','bb'},{'ccc','d'}}
 assert(a.dtype=='|S3','2d dtype 16')
 local t=a:tolist(); for i=1,#e do for j=1,#e[i] do assert(t[i][j]==e[i][j],'2d value') end end
 local tr=a.T; assert(tr:get(2,1)==e[1][2] and tr:get(1,2)==e[2][1],'transpose values')
end
do
 local a=np.array({{'é','😊'},{'日本','x'}},'>U2')
 local e={{'é','😊'},{'日本','x'}}
 assert(a.dtype=='>U2','2d dtype 17')
 local t=a:tolist(); for i=1,#e do for j=1,#e[i] do assert(t[i][j]==e[i][j],'2d value') end end
 local tr=a.T; assert(tr:get(2,1)==e[1][2] and tr:get(1,2)==e[2][1],'transpose values')
end
do
 local a=np.array({'a','bb','é','😊'},'U3')
 local b=np.array({'a','c','é','x'},'U1')
 local r=np.equal(a,b)
 local e={true,false,true,false}
 check_bool(r,e,'cmp 18')
end
do
 local a=np.array({'a','bb','é','😊'},'U3')
 local b=np.array({'a','c','é','x'},'U1')
 local r=np.not_equal(a,b)
 local e={false,true,false,true}
 check_bool(r,e,'cmp 19')
end
do
 local a=np.array({'a','bb','é','😊'},'U3')
 local b=np.array({'a','c','é','x'},'U1')
 local r=np.less(a,b)
 local e={false,true,false,false}
 check_bool(r,e,'cmp 20')
end
do
 local a=np.array({'a','bb','é','😊'},'U3')
 local b=np.array({'a','c','é','x'},'U1')
 local r=np.less_equal(a,b)
 local e={true,true,true,false}
 check_bool(r,e,'cmp 21')
end
do
 local a=np.array({'a','bb','é','😊'},'U3')
 local b=np.array({'a','c','é','x'},'U1')
 local r=np.greater(a,b)
 local e={false,false,false,true}
 check_bool(r,e,'cmp 22')
end
do
 local a=np.array({'a','bb','é','😊'},'U3')
 local b=np.array({'a','c','é','x'},'U1')
 local r=np.greater_equal(a,b)
 local e={true,false,true,true}
 check_bool(r,e,'cmp 23')
end
do
 local a=np.array({'z','a','日','😊'},'U1')
 local b=np.array({'aa','a','日本','😊'},'U4')
 local r=np.equal(a,b)
 local e={false,true,false,true}
 check_bool(r,e,'cmp 24')
end
do
 local a=np.array({'z','a','日','😊'},'U1')
 local b=np.array({'aa','a','日本','😊'},'U4')
 local r=np.not_equal(a,b)
 local e={true,false,true,false}
 check_bool(r,e,'cmp 25')
end
do
 local a=np.array({'z','a','日','😊'},'U1')
 local b=np.array({'aa','a','日本','😊'},'U4')
 local r=np.less(a,b)
 local e={false,false,true,false}
 check_bool(r,e,'cmp 26')
end
do
 local a=np.array({'z','a','日','😊'},'U1')
 local b=np.array({'aa','a','日本','😊'},'U4')
 local r=np.less_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'cmp 27')
end
do
 local a=np.array({'z','a','日','😊'},'U1')
 local b=np.array({'aa','a','日本','😊'},'U4')
 local r=np.greater(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'cmp 28')
end
do
 local a=np.array({'z','a','日','😊'},'U1')
 local b=np.array({'aa','a','日本','😊'},'U4')
 local r=np.greater_equal(a,b)
 local e={true,true,false,true}
 check_bool(r,e,'cmp 29')
end
do
 local a=np.array({'é','日本','😊'},'>U2')
 local b=np.array({'é','日','😊x'},'<U3')
 local r=np.equal(a,b)
 local e={true,false,false}
 check_bool(r,e,'cmp 30')
end
do
 local a=np.array({'é','日本','😊'},'>U2')
 local b=np.array({'é','日','😊x'},'<U3')
 local r=np.not_equal(a,b)
 local e={false,true,true}
 check_bool(r,e,'cmp 31')
end
do
 local a=np.array({'é','日本','😊'},'>U2')
 local b=np.array({'é','日','😊x'},'<U3')
 local r=np.less(a,b)
 local e={false,false,true}
 check_bool(r,e,'cmp 32')
end
do
 local a=np.array({'é','日本','😊'},'>U2')
 local b=np.array({'é','日','😊x'},'<U3')
 local r=np.less_equal(a,b)
 local e={true,false,true}
 check_bool(r,e,'cmp 33')
end
do
 local a=np.array({'é','日本','😊'},'>U2')
 local b=np.array({'é','日','😊x'},'<U3')
 local r=np.greater(a,b)
 local e={false,true,false}
 check_bool(r,e,'cmp 34')
end
do
 local a=np.array({'é','日本','😊'},'>U2')
 local b=np.array({'é','日','😊x'},'<U3')
 local r=np.greater_equal(a,b)
 local e={true,true,false}
 check_bool(r,e,'cmp 35')
end
do
 local a=np.array({'a','bb','z',''},'S3')
 local b=np.array({'a','c','y',''},'S1')
 local r=np.equal(a,b)
 local e={true,false,false,true}
 check_bool(r,e,'cmp 36')
end
do
 local a=np.array({'a','bb','z',''},'S3')
 local b=np.array({'a','c','y',''},'S1')
 local r=np.not_equal(a,b)
 local e={false,true,true,false}
 check_bool(r,e,'cmp 37')
end
do
 local a=np.array({'a','bb','z',''},'S3')
 local b=np.array({'a','c','y',''},'S1')
 local r=np.less(a,b)
 local e={false,true,false,false}
 check_bool(r,e,'cmp 38')
end
do
 local a=np.array({'a','bb','z',''},'S3')
 local b=np.array({'a','c','y',''},'S1')
 local r=np.less_equal(a,b)
 local e={true,true,false,true}
 check_bool(r,e,'cmp 39')
end
do
 local a=np.array({'a','bb','z',''},'S3')
 local b=np.array({'a','c','y',''},'S1')
 local r=np.greater(a,b)
 local e={false,false,true,false}
 check_bool(r,e,'cmp 40')
end
do
 local a=np.array({'a','bb','z',''},'S3')
 local b=np.array({'a','c','y',''},'S1')
 local r=np.greater_equal(a,b)
 local e={true,false,true,true}
 check_bool(r,e,'cmp 41')
end
do
 local a=np.array({'z','a','x'},'S1')
 local b=np.array({'aa','a','xy'},'S4')
 local r=np.equal(a,b)
 local e={false,true,false}
 check_bool(r,e,'cmp 42')
end
do
 local a=np.array({'z','a','x'},'S1')
 local b=np.array({'aa','a','xy'},'S4')
 local r=np.not_equal(a,b)
 local e={true,false,true}
 check_bool(r,e,'cmp 43')
end
do
 local a=np.array({'z','a','x'},'S1')
 local b=np.array({'aa','a','xy'},'S4')
 local r=np.less(a,b)
 local e={false,false,true}
 check_bool(r,e,'cmp 44')
end
do
 local a=np.array({'z','a','x'},'S1')
 local b=np.array({'aa','a','xy'},'S4')
 local r=np.less_equal(a,b)
 local e={false,true,true}
 check_bool(r,e,'cmp 45')
end
do
 local a=np.array({'z','a','x'},'S1')
 local b=np.array({'aa','a','xy'},'S4')
 local r=np.greater(a,b)
 local e={true,false,false}
 check_bool(r,e,'cmp 46')
end
do
 local a=np.array({'z','a','x'},'S1')
 local b=np.array({'aa','a','xy'},'S4')
 local r=np.greater_equal(a,b)
 local e={true,true,false}
 check_bool(r,e,'cmp 47')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 48')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.not_equal(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 49')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.less(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 50')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.less_equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 51')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.greater(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 52')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.greater_equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 53')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 54')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 55')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.less(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 56')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.less_equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 57')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.greater(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 58')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.greater_equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 59')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 60')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 61')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.less(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 62')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.less_equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 63')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.greater(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 64')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.greater_equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 65')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 66')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 67')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.less(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 68')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.less_equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 69')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.greater(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 70')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U1')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.greater_equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 71')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 72')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 73')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.less(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 74')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.less_equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 75')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.greater(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 76')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.greater_equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 77')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.equal(a,b)
 local e={true,false,false,true}
 check_bool(r,e,'width matrix 78')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.not_equal(a,b)
 local e={false,true,true,false}
 check_bool(r,e,'width matrix 79')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.less(a,b)
 local e={false,true,false,false}
 check_bool(r,e,'width matrix 80')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.less_equal(a,b)
 local e={true,true,false,true}
 check_bool(r,e,'width matrix 81')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.greater(a,b)
 local e={false,false,true,false}
 check_bool(r,e,'width matrix 82')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.greater_equal(a,b)
 local e={true,false,true,true}
 check_bool(r,e,'width matrix 83')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.equal(a,b)
 local e={true,false,false,true}
 check_bool(r,e,'width matrix 84')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.not_equal(a,b)
 local e={false,true,true,false}
 check_bool(r,e,'width matrix 85')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.less(a,b)
 local e={false,true,false,false}
 check_bool(r,e,'width matrix 86')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.less_equal(a,b)
 local e={true,true,false,true}
 check_bool(r,e,'width matrix 87')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.greater(a,b)
 local e={false,false,true,false}
 check_bool(r,e,'width matrix 88')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.greater_equal(a,b)
 local e={true,false,true,true}
 check_bool(r,e,'width matrix 89')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.equal(a,b)
 local e={true,false,false,true}
 check_bool(r,e,'width matrix 90')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.not_equal(a,b)
 local e={false,true,true,false}
 check_bool(r,e,'width matrix 91')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.less(a,b)
 local e={false,true,false,false}
 check_bool(r,e,'width matrix 92')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.less_equal(a,b)
 local e={true,true,false,true}
 check_bool(r,e,'width matrix 93')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.greater(a,b)
 local e={false,false,true,false}
 check_bool(r,e,'width matrix 94')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U2')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.greater_equal(a,b)
 local e={true,false,true,true}
 check_bool(r,e,'width matrix 95')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 96')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 97')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.less(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 98')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.less_equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 99')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.greater(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 100')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.greater_equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 101')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 102')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 103')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.less(a,b)
 local e={false,true,false,false}
 check_bool(r,e,'width matrix 104')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.less_equal(a,b)
 local e={true,true,false,false}
 check_bool(r,e,'width matrix 105')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.greater(a,b)
 local e={false,false,true,true}
 check_bool(r,e,'width matrix 106')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.greater_equal(a,b)
 local e={true,false,true,true}
 check_bool(r,e,'width matrix 107')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 108')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 109')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.less(a,b)
 local e={false,true,false,false}
 check_bool(r,e,'width matrix 110')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.less_equal(a,b)
 local e={true,true,false,false}
 check_bool(r,e,'width matrix 111')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.greater(a,b)
 local e={false,false,true,true}
 check_bool(r,e,'width matrix 112')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.greater_equal(a,b)
 local e={true,false,true,true}
 check_bool(r,e,'width matrix 113')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 114')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 115')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.less(a,b)
 local e={false,true,false,false}
 check_bool(r,e,'width matrix 116')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.less_equal(a,b)
 local e={true,true,false,false}
 check_bool(r,e,'width matrix 117')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.greater(a,b)
 local e={false,false,true,true}
 check_bool(r,e,'width matrix 118')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U3')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.greater_equal(a,b)
 local e={true,false,true,true}
 check_bool(r,e,'width matrix 119')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 120')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 121')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.less(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 122')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.less_equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 123')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.greater(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 124')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U1')
 local r=np.greater_equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 125')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 126')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 127')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.less(a,b)
 local e={false,true,false,false}
 check_bool(r,e,'width matrix 128')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.less_equal(a,b)
 local e={true,true,false,false}
 check_bool(r,e,'width matrix 129')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.greater(a,b)
 local e={false,false,true,true}
 check_bool(r,e,'width matrix 130')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U2')
 local r=np.greater_equal(a,b)
 local e={true,false,true,true}
 check_bool(r,e,'width matrix 131')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 132')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 133')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.less(a,b)
 local e={false,true,false,false}
 check_bool(r,e,'width matrix 134')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.less_equal(a,b)
 local e={true,true,false,false}
 check_bool(r,e,'width matrix 135')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.greater(a,b)
 local e={false,false,true,true}
 check_bool(r,e,'width matrix 136')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U3')
 local r=np.greater_equal(a,b)
 local e={true,false,true,true}
 check_bool(r,e,'width matrix 137')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 138')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 139')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.less(a,b)
 local e={false,true,false,false}
 check_bool(r,e,'width matrix 140')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.less_equal(a,b)
 local e={true,true,false,false}
 check_bool(r,e,'width matrix 141')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.greater(a,b)
 local e={false,false,true,true}
 check_bool(r,e,'width matrix 142')
end
do
 local a=np.array({'a','bb','é😊','日本語'},'U4')
 local b=np.array({'a','bc','éx','日本'},'U4')
 local r=np.greater_equal(a,b)
 local e={true,false,true,true}
 check_bool(r,e,'width matrix 143')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 144')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.not_equal(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 145')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.less(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 146')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.less_equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 147')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.greater(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 148')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.greater_equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 149')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 150')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 151')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.less(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 152')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.less_equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 153')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.greater(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 154')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.greater_equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 155')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 156')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 157')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.less(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 158')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.less_equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 159')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.greater(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 160')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.greater_equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 161')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 162')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 163')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.less(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 164')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.less_equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 165')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.greater(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 166')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S1')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.greater_equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 167')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 168')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 169')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.less(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 170')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.less_equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 171')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.greater(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 172')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.greater_equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 173')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.equal(a,b)
 local e={true,false,false,true}
 check_bool(r,e,'width matrix 174')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.not_equal(a,b)
 local e={false,true,true,false}
 check_bool(r,e,'width matrix 175')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.less(a,b)
 local e={false,true,true,false}
 check_bool(r,e,'width matrix 176')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.less_equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 177')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.greater(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 178')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.greater_equal(a,b)
 local e={true,false,false,true}
 check_bool(r,e,'width matrix 179')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 180')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 181')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.less(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 182')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.less_equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 183')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.greater(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 184')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.greater_equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 185')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 186')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 187')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.less(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 188')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.less_equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 189')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.greater(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 190')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S2')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.greater_equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 191')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 192')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 193')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.less(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 194')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.less_equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 195')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.greater(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 196')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.greater_equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 197')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 198')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 199')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.less(a,b)
 local e={false,true,true,false}
 check_bool(r,e,'width matrix 200')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.less_equal(a,b)
 local e={true,true,true,false}
 check_bool(r,e,'width matrix 201')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.greater(a,b)
 local e={false,false,false,true}
 check_bool(r,e,'width matrix 202')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.greater_equal(a,b)
 local e={true,false,false,true}
 check_bool(r,e,'width matrix 203')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.equal(a,b)
 local e={true,false,false,true}
 check_bool(r,e,'width matrix 204')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.not_equal(a,b)
 local e={false,true,true,false}
 check_bool(r,e,'width matrix 205')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.less(a,b)
 local e={false,true,true,false}
 check_bool(r,e,'width matrix 206')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.less_equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 207')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.greater(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 208')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.greater_equal(a,b)
 local e={true,false,false,true}
 check_bool(r,e,'width matrix 209')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.equal(a,b)
 local e={true,false,false,true}
 check_bool(r,e,'width matrix 210')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.not_equal(a,b)
 local e={false,true,true,false}
 check_bool(r,e,'width matrix 211')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.less(a,b)
 local e={false,true,true,false}
 check_bool(r,e,'width matrix 212')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.less_equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 213')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.greater(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 214')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S3')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.greater_equal(a,b)
 local e={true,false,false,true}
 check_bool(r,e,'width matrix 215')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 216')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 217')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.less(a,b)
 local e={false,false,false,false}
 check_bool(r,e,'width matrix 218')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.less_equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 219')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.greater(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 220')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S1')
 local r=np.greater_equal(a,b)
 local e={true,true,true,true}
 check_bool(r,e,'width matrix 221')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 222')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 223')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.less(a,b)
 local e={false,true,true,false}
 check_bool(r,e,'width matrix 224')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.less_equal(a,b)
 local e={true,true,true,false}
 check_bool(r,e,'width matrix 225')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.greater(a,b)
 local e={false,false,false,true}
 check_bool(r,e,'width matrix 226')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S2')
 local r=np.greater_equal(a,b)
 local e={true,false,false,true}
 check_bool(r,e,'width matrix 227')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 228')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 229')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.less(a,b)
 local e={false,true,true,false}
 check_bool(r,e,'width matrix 230')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.less_equal(a,b)
 local e={true,true,true,false}
 check_bool(r,e,'width matrix 231')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.greater(a,b)
 local e={false,false,false,true}
 check_bool(r,e,'width matrix 232')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S3')
 local r=np.greater_equal(a,b)
 local e={true,false,false,true}
 check_bool(r,e,'width matrix 233')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.equal(a,b)
 local e={true,false,false,false}
 check_bool(r,e,'width matrix 234')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.not_equal(a,b)
 local e={false,true,true,true}
 check_bool(r,e,'width matrix 235')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.less(a,b)
 local e={false,true,true,false}
 check_bool(r,e,'width matrix 236')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.less_equal(a,b)
 local e={true,true,true,false}
 check_bool(r,e,'width matrix 237')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.greater(a,b)
 local e={false,false,false,true}
 check_bool(r,e,'width matrix 238')
end
do
 local a=np.array({'a','bb','cc','zzzz'},'S4')
 local b=np.array({'a','bc','cd','zzz'},'S4')
 local r=np.greater_equal(a,b)
 local e={true,false,false,true}
 check_bool(r,e,'width matrix 239')
end
do
 local a=np.array({'a','bb','ccc'},'U3')
 local r=np.equal(a,'bb')
 local e={false,true,false}
 check_bool(r,e,'scalar cmp 240')
end
do
 local a=np.array({'a','bb','ccc'},'U3')
 local r=np.not_equal(a,'bb')
 local e={true,false,true}
 check_bool(r,e,'scalar cmp 241')
end
do
 local a=np.array({'a','bb','ccc'},'U3')
 local r=np.less(a,'bb')
 local e={true,false,false}
 check_bool(r,e,'scalar cmp 242')
end
do
 local a=np.array({'a','bb','ccc'},'U3')
 local r=np.less_equal(a,'bb')
 local e={true,true,false}
 check_bool(r,e,'scalar cmp 243')
end
do
 local a=np.array({'a','bb','ccc'},'U3')
 local r=np.greater(a,'bb')
 local e={false,false,true}
 check_bool(r,e,'scalar cmp 244')
end
do
 local a=np.array({'a','bb','ccc'},'U3')
 local r=np.greater_equal(a,'bb')
 local e={false,true,true}
 check_bool(r,e,'scalar cmp 245')
end
do
 local a=np.array({'é','日本','😊'},'>U2')
 local r=np.equal(a,'日本')
 local e={false,true,false}
 check_bool(r,e,'scalar cmp 246')
end
do
 local a=np.array({'é','日本','😊'},'>U2')
 local r=np.not_equal(a,'日本')
 local e={true,false,true}
 check_bool(r,e,'scalar cmp 247')
end
do
 local a=np.array({'é','日本','😊'},'>U2')
 local r=np.less(a,'日本')
 local e={true,false,false}
 check_bool(r,e,'scalar cmp 248')
end
do
 local a=np.array({'é','日本','😊'},'>U2')
 local r=np.less_equal(a,'日本')
 local e={true,true,false}
 check_bool(r,e,'scalar cmp 249')
end
do
 local a=np.array({'é','日本','😊'},'>U2')
 local r=np.greater(a,'日本')
 local e={false,false,true}
 check_bool(r,e,'scalar cmp 250')
end
do
 local a=np.array({'é','日本','😊'},'>U2')
 local r=np.greater_equal(a,'日本')
 local e={false,true,true}
 check_bool(r,e,'scalar cmp 251')
end
do
 local a=np.array({'a','bb','ccc'},'S3')
 local r=np.equal(a,'bb')
 local e={false,true,false}
 check_bool(r,e,'scalar cmp 252')
end
do
 local a=np.array({'a','bb','ccc'},'S3')
 local r=np.not_equal(a,'bb')
 local e={true,false,true}
 check_bool(r,e,'scalar cmp 253')
end
do
 local a=np.array({'a','bb','ccc'},'S3')
 local r=np.less(a,'bb')
 local e={true,false,false}
 check_bool(r,e,'scalar cmp 254')
end
do
 local a=np.array({'a','bb','ccc'},'S3')
 local r=np.less_equal(a,'bb')
 local e={true,true,false}
 check_bool(r,e,'scalar cmp 255')
end
do
 local a=np.array({'a','bb','ccc'},'S3')
 local r=np.greater(a,'bb')
 local e={false,false,true}
 check_bool(r,e,'scalar cmp 256')
end
do
 local a=np.array({'a','bb','ccc'},'S3')
 local r=np.greater_equal(a,'bb')
 local e={false,true,true}
 check_bool(r,e,'scalar cmp 257')
end
do
 local a=np.array({'a','bb','c'},'U2')
 local b=np.array({'a'},'U2')
 local m=np.array({true,false,true},np.bool)
 local o=np.array({false,true,false},np.bool)
 local r=np.equal(a,b,{out=o,where=m}); assert(r==o,'out identity')
 local e={true,true,false}
 check_bool(o,e,'out where 258')
end
do
 local a=np.array({'a','bb','c'},'S2')
 local b=np.array({'b'},'S2')
 local m=np.array({false,true,true},np.bool)
 local o=np.array({true,false,true},np.bool)
 local r=np.equal(a,b,{out=o,where=m}); assert(r==o,'out identity')
 local e={true,false,false}
 check_bool(o,e,'out where 259')
end
do
 local d=np.zeros({3},'U2'); local s=np.array({'abc','é😊x','日本語'},'U3'); d:set(s)
 local e={'ab','é😊','日本'}; check1(d,'<U2',e,'assign U narrow')
end
do
 local d=np.zeros({3},'>U2'); local s=np.array({'é','😊','日本'},'<U2'); d:set(s)
 local e={'é','😊','日本'}; check1(d,'>U2',e,'assign U endian')
end
do
 local d=np.zeros({3},'S2'); local s=np.array({'abc','x','zz'},'S3'); d:set(s)
 local e={'ab','x','zz'}; check1(d,'|S2',e,'assign S')
end
do
 local d=np.zeros({3},'U3'); local s=np.array({'abc','x','zz'},'S3'); d:set(s)
 local e={'abc','x','zz'}; check1(d,'<U3',e,'assign S to U')
end
do
 local raw=string.char(0xC3,0xA9); local a=np.array({raw},'S1')
 assert(a.dtype=='|S1' and #a[1]==1 and string.byte(a[1],1)==0xC3,'S raw byte truncation')
end
do
 local bad=string.char(0xFF); assert(not pcall(function() return np.array({bad},'U1') end),'U invalid UTF-8 reject')
end
do
 local s=np.array({'a'},'S1'); local u=np.array({'a'},'U1')
 assert(not pcall(function() return np.equal(s,u) end),'mixed S/U equal')
end
do
 local s=np.array({'a'},'S1'); local u=np.array({'a'},'U1')
 assert(not pcall(function() return np.less(s,u) end),'mixed S/U less')
end
do
 local s=np.array({'a'},'S1'); local u=np.array({'a'},'U1')
 assert(not pcall(function() return np.greater_equal(s,u) end),'mixed S/U greater_equal')
end
do
 local d=np.array({'2026-10-07','2026-10-08','NaT'},'datetime64[D]')
 local r=np.datetime_as_string(d)
 local e={'2026-10-07','2026-10-08','NaT'}
 check1(r,'<U28',e,'datetime string array default')
end
do
 local d=np.array({'2026-10-07','2026-10-08','NaT'},'datetime64[D]')
 local r=np.datetime_as_string(d,{unit='auto'})
 local e={'2026-10-07','2026-10-08','NaT'}
 check1(r,'<U62',e,'datetime string array auto')
end
do
 local d=np.array({'2026-10-07','2026-10-08','NaT'},'datetime64[D]')
 local r=np.datetime_as_string(d,{unit='D'})
 local e={'2026-10-07','2026-10-08','NaT'}
 check1(r,'<U28',e,'datetime string array D')
end
do
 local d=np.array({'2026-10-07','2026-10-08','NaT'},'datetime64[D]')
 local r=np.datetime_as_string(d,{unit='s'})
 local e={'2026-10-07T00:00:00','2026-10-08T00:00:00','NaT'}
 check1(r,'<U38',e,'datetime string array s')
end
do
 local d=np.array({'2026-10-07','2026-10-08','NaT'},'datetime64[D]')
 local r=np.datetime_as_string(d,{timezone='UTC'})
 local e={'2026-10-07','2026-10-08','NaT'}
 check1(r,'<U28',e,'datetime string array UTC')
end
do
 local d=np.array({{'2026-10-07','2026-10-08'},{'2026-10-09','2026-10-10'}},'datetime64[D]').T
 local r=np.datetime_as_string(d,{unit='D'})
 local e={{'2026-10-07','2026-10-09'},{'2026-10-08','2026-10-10'}}
 assert(r.dtype=='<U28','datetime transposed dtype')
 local t=r:tolist(); for i=1,#e do for j=1,#e[i] do assert(t[i][j]==e[i][j],'datetime transposed values') end end
 assert(r.strides[1] < r.strides[2],'datetime output keeporder F')
end
print('string/unicode differential: 275 cases ok')
