local np=require('luaray_core')
local checks=0
local function deep(a,b)
 assert(type(a)==type(b),'type '..tostring(a)..' vs '..tostring(b))
 if type(a)=='table' then
  assert(#a==#b,'length '..#a..' vs '..#b)
  for i=1,#a do deep(a[i],b[i]) end
 else assert(a==b,tostring(a)..' differs from '..tostring(b)) end
 checks=checks+1
end
local function normalized(a,kind)
 local function walk(x)
  if type(x)=='table' then
   local out={};for i,v in ipairs(x) do out[i]=walk(v) end;return out
  end
  if kind=='complex64' then return {x.real,x.imag} end
  if kind=='datetime64[D]' then return tostring(x) end
  return x
 end
 return walk(a:tolist())
end

local cases=0
do
local r=np.random.default_rng(0)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,nil)
deep(normalized(y,"U3"),{{"ab","xyz",""},{"☃","é","猫"}})
deep(r:raw_hex(),"d0327a782cde513b")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,nil,x)
deep(normalized(y,"U3"),{{"ab","xyz",""},{"☃","é","猫"}})
deep(r:raw_hex(),"d0327a782cde513b")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,1)
deep(normalized(y,"U3"),{{"é","猫","xyz"},{"ab","☃",""}})
deep(r:raw_hex(),"0a7d3da94ecde8b8")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,1,x)
deep(normalized(y,"U3"),{{"é","猫","xyz"},{"ab","☃",""}})
deep(r:raw_hex(),"0a7d3da94ecde8b8")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,2)
deep(normalized(y,"U3"),{{"xyz","é","猫"},{"","☃","ab"}})
deep(r:raw_hex(),"043b27b61342f01d")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,2,x)
deep(normalized(y,"U3"),{{"xyz","é","猫"},{"","☃","ab"}})
deep(r:raw_hex(),"043b27b61342f01d")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,nil)
deep(normalized(y,"U3"),{{"☃","é","xyz"},{"猫","","ab"}})
deep(r:raw_hex(),"4fd42fa03fcd72a9")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,nil,x)
deep(normalized(y,"U3"),{{"☃","é","xyz"},{"猫","","ab"}})
deep(r:raw_hex(),"4fd42fa03fcd72a9")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,1)
deep(normalized(y,"U3"),{{"é","猫",""},{"ab","☃","xyz"}})
deep(r:raw_hex(),"24e7a4f608ec18cd")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,1,x)
deep(normalized(y,"U3"),{{"é","猫",""},{"ab","☃","xyz"}})
deep(r:raw_hex(),"24e7a4f608ec18cd")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,2)
deep(normalized(y,"U3"),{{"é","猫","xyz"},{"","ab","☃"}})
deep(r:raw_hex(),"f2dab0aed2ac6fd2")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,2,x)
deep(normalized(y,"U3"),{{"é","猫","xyz"},{"","ab","☃"}})
deep(r:raw_hex(),"f2dab0aed2ac6fd2")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,nil)
deep(normalized(y,"U3"),{{"ab","xyz",""},{"☃","猫","é"}})
deep(r:raw_hex(),"b286b60e1600888d")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,nil,x)
deep(normalized(y,"U3"),{{"ab","xyz",""},{"☃","猫","é"}})
deep(r:raw_hex(),"b286b60e1600888d")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,1)
deep(normalized(y,"U3"),{{"ab","猫","xyz"},{"é","☃",""}})
deep(r:raw_hex(),"dbcd12c26eda1624")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,1,x)
deep(normalized(y,"U3"),{{"ab","猫","xyz"},{"é","☃",""}})
deep(r:raw_hex(),"dbcd12c26eda1624")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,2)
deep(normalized(y,"U3"),{{"xyz","猫","é"},{"ab","","☃"}})
deep(r:raw_hex(),"dbcd12c26eda1624")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,2,x)
deep(normalized(y,"U3"),{{"xyz","猫","é"},{"ab","","☃"}})
deep(r:raw_hex(),"dbcd12c26eda1624")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,nil)
deep(normalized(y,"U3"),{{"é","","ab"},{"☃","猫","xyz"}})
deep(r:raw_hex(),"5438d9338499fd38")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,nil,x)
deep(normalized(y,"U3"),{{"é","","ab"},{"☃","猫","xyz"}})
deep(r:raw_hex(),"5438d9338499fd38")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,1)
deep(normalized(y,"U3"),{{"é","☃","xyz"},{"ab","猫",""}})
deep(r:raw_hex(),"5fef6c5d42ad2531")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,1,x)
deep(normalized(y,"U3"),{{"é","☃","xyz"},{"ab","猫",""}})
deep(r:raw_hex(),"5fef6c5d42ad2531")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,2)
deep(normalized(y,"U3"),{{"é","猫","xyz"},{"ab","","☃"}})
deep(r:raw_hex(),"79d5d3707e1b5fef")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{"é","猫","xyz"},{"ab","☃",""}},"U3")
local y=r:permuted(x,2,x)
deep(normalized(y,"U3"),{{"é","猫","xyz"},{"ab","","☃"}})
deep(r:raw_hex(),"79d5d3707e1b5fef")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,nil)
deep(normalized(y,"S3"),{{"xyz","xy",""},{"m","a","b"}})
deep(r:raw_hex(),"d0327a782cde513b")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,nil,x)
deep(normalized(y,"S3"),{{"xyz","xy",""},{"m","a","b"}})
deep(r:raw_hex(),"d0327a782cde513b")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,1)
deep(normalized(y,"S3"),{{"a","b","xy"},{"xyz","m",""}})
deep(r:raw_hex(),"0a7d3da94ecde8b8")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,1,x)
deep(normalized(y,"S3"),{{"a","b","xy"},{"xyz","m",""}})
deep(r:raw_hex(),"0a7d3da94ecde8b8")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,2)
deep(normalized(y,"S3"),{{"xy","a","b"},{"","m","xyz"}})
deep(r:raw_hex(),"043b27b61342f01d")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,2,x)
deep(normalized(y,"S3"),{{"xy","a","b"},{"","m","xyz"}})
deep(r:raw_hex(),"043b27b61342f01d")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,nil)
deep(normalized(y,"S3"),{{"m","a","xy"},{"b","","xyz"}})
deep(r:raw_hex(),"4fd42fa03fcd72a9")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,nil,x)
deep(normalized(y,"S3"),{{"m","a","xy"},{"b","","xyz"}})
deep(r:raw_hex(),"4fd42fa03fcd72a9")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,1)
deep(normalized(y,"S3"),{{"a","b",""},{"xyz","m","xy"}})
deep(r:raw_hex(),"24e7a4f608ec18cd")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,1,x)
deep(normalized(y,"S3"),{{"a","b",""},{"xyz","m","xy"}})
deep(r:raw_hex(),"24e7a4f608ec18cd")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,2)
deep(normalized(y,"S3"),{{"a","b","xy"},{"","xyz","m"}})
deep(r:raw_hex(),"f2dab0aed2ac6fd2")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,2,x)
deep(normalized(y,"S3"),{{"a","b","xy"},{"","xyz","m"}})
deep(r:raw_hex(),"f2dab0aed2ac6fd2")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,nil)
deep(normalized(y,"S3"),{{"xyz","xy",""},{"m","b","a"}})
deep(r:raw_hex(),"b286b60e1600888d")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,nil,x)
deep(normalized(y,"S3"),{{"xyz","xy",""},{"m","b","a"}})
deep(r:raw_hex(),"b286b60e1600888d")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,1)
deep(normalized(y,"S3"),{{"xyz","b","xy"},{"a","m",""}})
deep(r:raw_hex(),"dbcd12c26eda1624")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,1,x)
deep(normalized(y,"S3"),{{"xyz","b","xy"},{"a","m",""}})
deep(r:raw_hex(),"dbcd12c26eda1624")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,2)
deep(normalized(y,"S3"),{{"xy","b","a"},{"xyz","","m"}})
deep(r:raw_hex(),"dbcd12c26eda1624")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,2,x)
deep(normalized(y,"S3"),{{"xy","b","a"},{"xyz","","m"}})
deep(r:raw_hex(),"dbcd12c26eda1624")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,nil)
deep(normalized(y,"S3"),{{"a","","xyz"},{"m","b","xy"}})
deep(r:raw_hex(),"5438d9338499fd38")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,nil,x)
deep(normalized(y,"S3"),{{"a","","xyz"},{"m","b","xy"}})
deep(r:raw_hex(),"5438d9338499fd38")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,1)
deep(normalized(y,"S3"),{{"a","m","xy"},{"xyz","b",""}})
deep(r:raw_hex(),"5fef6c5d42ad2531")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,1,x)
deep(normalized(y,"S3"),{{"a","m","xy"},{"xyz","b",""}})
deep(r:raw_hex(),"5fef6c5d42ad2531")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,2)
deep(normalized(y,"S3"),{{"a","b","xy"},{"xyz","","m"}})
deep(r:raw_hex(),"79d5d3707e1b5fef")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{"a","b","xy"},{"xyz","m",""}},"S3")
local y=r:permuted(x,2,x)
deep(normalized(y,"S3"),{{"a","b","xy"},{"xyz","","m"}})
deep(r:raw_hex(),"79d5d3707e1b5fef")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,nil)
deep(normalized(y,"complex64"),{{{-2.0,0.5},{5.0,-1.0},{1.0,-3.0}},{{8.0,7.0},{1.0,2.0},{3.0,4.0}}})
deep(r:raw_hex(),"d0327a782cde513b")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,nil,x)
deep(normalized(y,"complex64"),{{{-2.0,0.5},{5.0,-1.0},{1.0,-3.0}},{{8.0,7.0},{1.0,2.0},{3.0,4.0}}})
deep(r:raw_hex(),"d0327a782cde513b")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,1)
deep(normalized(y,"complex64"),{{{1.0,2.0},{3.0,4.0},{5.0,-1.0}},{{-2.0,0.5},{8.0,7.0},{1.0,-3.0}}})
deep(r:raw_hex(),"0a7d3da94ecde8b8")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,1,x)
deep(normalized(y,"complex64"),{{{1.0,2.0},{3.0,4.0},{5.0,-1.0}},{{-2.0,0.5},{8.0,7.0},{1.0,-3.0}}})
deep(r:raw_hex(),"0a7d3da94ecde8b8")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,2)
deep(normalized(y,"complex64"),{{{5.0,-1.0},{1.0,2.0},{3.0,4.0}},{{1.0,-3.0},{8.0,7.0},{-2.0,0.5}}})
deep(r:raw_hex(),"043b27b61342f01d")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,2,x)
deep(normalized(y,"complex64"),{{{5.0,-1.0},{1.0,2.0},{3.0,4.0}},{{1.0,-3.0},{8.0,7.0},{-2.0,0.5}}})
deep(r:raw_hex(),"043b27b61342f01d")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,nil)
deep(normalized(y,"complex64"),{{{8.0,7.0},{1.0,2.0},{5.0,-1.0}},{{3.0,4.0},{1.0,-3.0},{-2.0,0.5}}})
deep(r:raw_hex(),"4fd42fa03fcd72a9")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,nil,x)
deep(normalized(y,"complex64"),{{{8.0,7.0},{1.0,2.0},{5.0,-1.0}},{{3.0,4.0},{1.0,-3.0},{-2.0,0.5}}})
deep(r:raw_hex(),"4fd42fa03fcd72a9")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,1)
deep(normalized(y,"complex64"),{{{1.0,2.0},{3.0,4.0},{1.0,-3.0}},{{-2.0,0.5},{8.0,7.0},{5.0,-1.0}}})
deep(r:raw_hex(),"24e7a4f608ec18cd")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,1,x)
deep(normalized(y,"complex64"),{{{1.0,2.0},{3.0,4.0},{1.0,-3.0}},{{-2.0,0.5},{8.0,7.0},{5.0,-1.0}}})
deep(r:raw_hex(),"24e7a4f608ec18cd")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,2)
deep(normalized(y,"complex64"),{{{1.0,2.0},{3.0,4.0},{5.0,-1.0}},{{1.0,-3.0},{-2.0,0.5},{8.0,7.0}}})
deep(r:raw_hex(),"f2dab0aed2ac6fd2")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,2,x)
deep(normalized(y,"complex64"),{{{1.0,2.0},{3.0,4.0},{5.0,-1.0}},{{1.0,-3.0},{-2.0,0.5},{8.0,7.0}}})
deep(r:raw_hex(),"f2dab0aed2ac6fd2")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,nil)
deep(normalized(y,"complex64"),{{{-2.0,0.5},{5.0,-1.0},{1.0,-3.0}},{{8.0,7.0},{3.0,4.0},{1.0,2.0}}})
deep(r:raw_hex(),"b286b60e1600888d")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,nil,x)
deep(normalized(y,"complex64"),{{{-2.0,0.5},{5.0,-1.0},{1.0,-3.0}},{{8.0,7.0},{3.0,4.0},{1.0,2.0}}})
deep(r:raw_hex(),"b286b60e1600888d")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,1)
deep(normalized(y,"complex64"),{{{-2.0,0.5},{3.0,4.0},{5.0,-1.0}},{{1.0,2.0},{8.0,7.0},{1.0,-3.0}}})
deep(r:raw_hex(),"dbcd12c26eda1624")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,1,x)
deep(normalized(y,"complex64"),{{{-2.0,0.5},{3.0,4.0},{5.0,-1.0}},{{1.0,2.0},{8.0,7.0},{1.0,-3.0}}})
deep(r:raw_hex(),"dbcd12c26eda1624")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,2)
deep(normalized(y,"complex64"),{{{5.0,-1.0},{3.0,4.0},{1.0,2.0}},{{-2.0,0.5},{1.0,-3.0},{8.0,7.0}}})
deep(r:raw_hex(),"dbcd12c26eda1624")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,2,x)
deep(normalized(y,"complex64"),{{{5.0,-1.0},{3.0,4.0},{1.0,2.0}},{{-2.0,0.5},{1.0,-3.0},{8.0,7.0}}})
deep(r:raw_hex(),"dbcd12c26eda1624")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,nil)
deep(normalized(y,"complex64"),{{{1.0,2.0},{1.0,-3.0},{-2.0,0.5}},{{8.0,7.0},{3.0,4.0},{5.0,-1.0}}})
deep(r:raw_hex(),"5438d9338499fd38")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,nil,x)
deep(normalized(y,"complex64"),{{{1.0,2.0},{1.0,-3.0},{-2.0,0.5}},{{8.0,7.0},{3.0,4.0},{5.0,-1.0}}})
deep(r:raw_hex(),"5438d9338499fd38")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,1)
deep(normalized(y,"complex64"),{{{1.0,2.0},{8.0,7.0},{5.0,-1.0}},{{-2.0,0.5},{3.0,4.0},{1.0,-3.0}}})
deep(r:raw_hex(),"5fef6c5d42ad2531")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,1,x)
deep(normalized(y,"complex64"),{{{1.0,2.0},{8.0,7.0},{5.0,-1.0}},{{-2.0,0.5},{3.0,4.0},{1.0,-3.0}}})
deep(r:raw_hex(),"5fef6c5d42ad2531")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,2)
deep(normalized(y,"complex64"),{{{1.0,2.0},{3.0,4.0},{5.0,-1.0}},{{-2.0,0.5},{1.0,-3.0},{8.0,7.0}}})
deep(r:raw_hex(),"79d5d3707e1b5fef")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{np.complex(1.0,2.0),np.complex(3.0,4.0),np.complex(5.0,-1.0)},{np.complex(-2.0,0.5),np.complex(8.0,7.0),np.complex(1.0,-3.0)}},"complex64")
local y=r:permuted(x,2,x)
deep(normalized(y,"complex64"),{{{1.0,2.0},{3.0,4.0},{5.0,-1.0}},{{-2.0,0.5},{1.0,-3.0},{8.0,7.0}}})
deep(r:raw_hex(),"79d5d3707e1b5fef")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,nil)
deep(normalized(y,"float16"),{{3.75,-2.0,6.5},{5.0,0.25,1.5}})
deep(r:raw_hex(),"d0327a782cde513b")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,nil,x)
deep(normalized(y,"float16"),{{3.75,-2.0,6.5},{5.0,0.25,1.5}})
deep(r:raw_hex(),"d0327a782cde513b")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,1)
deep(normalized(y,"float16"),{{0.25,1.5,-2.0},{3.75,5.0,6.5}})
deep(r:raw_hex(),"0a7d3da94ecde8b8")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,1,x)
deep(normalized(y,"float16"),{{0.25,1.5,-2.0},{3.75,5.0,6.5}})
deep(r:raw_hex(),"0a7d3da94ecde8b8")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,2)
deep(normalized(y,"float16"),{{-2.0,0.25,1.5},{6.5,5.0,3.75}})
deep(r:raw_hex(),"043b27b61342f01d")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,2,x)
deep(normalized(y,"float16"),{{-2.0,0.25,1.5},{6.5,5.0,3.75}})
deep(r:raw_hex(),"043b27b61342f01d")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,nil)
deep(normalized(y,"float16"),{{5.0,0.25,-2.0},{1.5,6.5,3.75}})
deep(r:raw_hex(),"4fd42fa03fcd72a9")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,nil,x)
deep(normalized(y,"float16"),{{5.0,0.25,-2.0},{1.5,6.5,3.75}})
deep(r:raw_hex(),"4fd42fa03fcd72a9")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,1)
deep(normalized(y,"float16"),{{0.25,1.5,6.5},{3.75,5.0,-2.0}})
deep(r:raw_hex(),"24e7a4f608ec18cd")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,1,x)
deep(normalized(y,"float16"),{{0.25,1.5,6.5},{3.75,5.0,-2.0}})
deep(r:raw_hex(),"24e7a4f608ec18cd")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,2)
deep(normalized(y,"float16"),{{0.25,1.5,-2.0},{6.5,3.75,5.0}})
deep(r:raw_hex(),"f2dab0aed2ac6fd2")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,2,x)
deep(normalized(y,"float16"),{{0.25,1.5,-2.0},{6.5,3.75,5.0}})
deep(r:raw_hex(),"f2dab0aed2ac6fd2")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,nil)
deep(normalized(y,"float16"),{{3.75,-2.0,6.5},{5.0,1.5,0.25}})
deep(r:raw_hex(),"b286b60e1600888d")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,nil,x)
deep(normalized(y,"float16"),{{3.75,-2.0,6.5},{5.0,1.5,0.25}})
deep(r:raw_hex(),"b286b60e1600888d")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,1)
deep(normalized(y,"float16"),{{3.75,1.5,-2.0},{0.25,5.0,6.5}})
deep(r:raw_hex(),"dbcd12c26eda1624")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,1,x)
deep(normalized(y,"float16"),{{3.75,1.5,-2.0},{0.25,5.0,6.5}})
deep(r:raw_hex(),"dbcd12c26eda1624")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,2)
deep(normalized(y,"float16"),{{-2.0,1.5,0.25},{3.75,6.5,5.0}})
deep(r:raw_hex(),"dbcd12c26eda1624")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,2,x)
deep(normalized(y,"float16"),{{-2.0,1.5,0.25},{3.75,6.5,5.0}})
deep(r:raw_hex(),"dbcd12c26eda1624")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,nil)
deep(normalized(y,"float16"),{{0.25,6.5,3.75},{5.0,1.5,-2.0}})
deep(r:raw_hex(),"5438d9338499fd38")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,nil,x)
deep(normalized(y,"float16"),{{0.25,6.5,3.75},{5.0,1.5,-2.0}})
deep(r:raw_hex(),"5438d9338499fd38")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,1)
deep(normalized(y,"float16"),{{0.25,5.0,-2.0},{3.75,1.5,6.5}})
deep(r:raw_hex(),"5fef6c5d42ad2531")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,1,x)
deep(normalized(y,"float16"),{{0.25,5.0,-2.0},{3.75,1.5,6.5}})
deep(r:raw_hex(),"5fef6c5d42ad2531")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,2)
deep(normalized(y,"float16"),{{0.25,1.5,-2.0},{3.75,6.5,5.0}})
deep(r:raw_hex(),"79d5d3707e1b5fef")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{0.25,1.5,-2.0},{3.75,5.0,6.5}},"float16")
local y=r:permuted(x,2,x)
deep(normalized(y,"float16"),{{0.25,1.5,-2.0},{3.75,6.5,5.0}})
deep(r:raw_hex(),"79d5d3707e1b5fef")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,nil)
deep(normalized(y,"datetime64[D]"),{{"2023-11-11","2024-03-03","2026-10-09"},{"2025-07-01","2024-01-01","2024-02-02"}})
deep(r:raw_hex(),"d0327a782cde513b")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,nil,x)
deep(normalized(y,"datetime64[D]"),{{"2023-11-11","2024-03-03","2026-10-09"},{"2025-07-01","2024-01-01","2024-02-02"}})
deep(r:raw_hex(),"d0327a782cde513b")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,1)
deep(normalized(y,"datetime64[D]"),{{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}})
deep(r:raw_hex(),"0a7d3da94ecde8b8")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,1,x)
deep(normalized(y,"datetime64[D]"),{{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}})
deep(r:raw_hex(),"0a7d3da94ecde8b8")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,2)
deep(normalized(y,"datetime64[D]"),{{"2024-03-03","2024-01-01","2024-02-02"},{"2026-10-09","2025-07-01","2023-11-11"}})
deep(r:raw_hex(),"043b27b61342f01d")
cases=cases+1; end
do
local r=np.random.default_rng(0)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,2,x)
deep(normalized(y,"datetime64[D]"),{{"2024-03-03","2024-01-01","2024-02-02"},{"2026-10-09","2025-07-01","2023-11-11"}})
deep(r:raw_hex(),"043b27b61342f01d")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,nil)
deep(normalized(y,"datetime64[D]"),{{"2025-07-01","2024-01-01","2024-03-03"},{"2024-02-02","2026-10-09","2023-11-11"}})
deep(r:raw_hex(),"4fd42fa03fcd72a9")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,nil,x)
deep(normalized(y,"datetime64[D]"),{{"2025-07-01","2024-01-01","2024-03-03"},{"2024-02-02","2026-10-09","2023-11-11"}})
deep(r:raw_hex(),"4fd42fa03fcd72a9")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,1)
deep(normalized(y,"datetime64[D]"),{{"2024-01-01","2024-02-02","2026-10-09"},{"2023-11-11","2025-07-01","2024-03-03"}})
deep(r:raw_hex(),"24e7a4f608ec18cd")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,1,x)
deep(normalized(y,"datetime64[D]"),{{"2024-01-01","2024-02-02","2026-10-09"},{"2023-11-11","2025-07-01","2024-03-03"}})
deep(r:raw_hex(),"24e7a4f608ec18cd")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,2)
deep(normalized(y,"datetime64[D]"),{{"2024-01-01","2024-02-02","2024-03-03"},{"2026-10-09","2023-11-11","2025-07-01"}})
deep(r:raw_hex(),"f2dab0aed2ac6fd2")
cases=cases+1; end
do
local r=np.random.default_rng(1)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,2,x)
deep(normalized(y,"datetime64[D]"),{{"2024-01-01","2024-02-02","2024-03-03"},{"2026-10-09","2023-11-11","2025-07-01"}})
deep(r:raw_hex(),"f2dab0aed2ac6fd2")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,nil)
deep(normalized(y,"datetime64[D]"),{{"2023-11-11","2024-03-03","2026-10-09"},{"2025-07-01","2024-02-02","2024-01-01"}})
deep(r:raw_hex(),"b286b60e1600888d")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,nil,x)
deep(normalized(y,"datetime64[D]"),{{"2023-11-11","2024-03-03","2026-10-09"},{"2025-07-01","2024-02-02","2024-01-01"}})
deep(r:raw_hex(),"b286b60e1600888d")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,1)
deep(normalized(y,"datetime64[D]"),{{"2023-11-11","2024-02-02","2024-03-03"},{"2024-01-01","2025-07-01","2026-10-09"}})
deep(r:raw_hex(),"dbcd12c26eda1624")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,1,x)
deep(normalized(y,"datetime64[D]"),{{"2023-11-11","2024-02-02","2024-03-03"},{"2024-01-01","2025-07-01","2026-10-09"}})
deep(r:raw_hex(),"dbcd12c26eda1624")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,2)
deep(normalized(y,"datetime64[D]"),{{"2024-03-03","2024-02-02","2024-01-01"},{"2023-11-11","2026-10-09","2025-07-01"}})
deep(r:raw_hex(),"dbcd12c26eda1624")
cases=cases+1; end
do
local r=np.random.default_rng(42)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,2,x)
deep(normalized(y,"datetime64[D]"),{{"2024-03-03","2024-02-02","2024-01-01"},{"2023-11-11","2026-10-09","2025-07-01"}})
deep(r:raw_hex(),"dbcd12c26eda1624")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,nil)
deep(normalized(y,"datetime64[D]"),{{"2024-01-01","2026-10-09","2023-11-11"},{"2025-07-01","2024-02-02","2024-03-03"}})
deep(r:raw_hex(),"5438d9338499fd38")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,nil,x)
deep(normalized(y,"datetime64[D]"),{{"2024-01-01","2026-10-09","2023-11-11"},{"2025-07-01","2024-02-02","2024-03-03"}})
deep(r:raw_hex(),"5438d9338499fd38")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,1)
deep(normalized(y,"datetime64[D]"),{{"2024-01-01","2025-07-01","2024-03-03"},{"2023-11-11","2024-02-02","2026-10-09"}})
deep(r:raw_hex(),"5fef6c5d42ad2531")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,1,x)
deep(normalized(y,"datetime64[D]"),{{"2024-01-01","2025-07-01","2024-03-03"},{"2023-11-11","2024-02-02","2026-10-09"}})
deep(r:raw_hex(),"5fef6c5d42ad2531")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,2)
deep(normalized(y,"datetime64[D]"),{{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2026-10-09","2025-07-01"}})
deep(r:raw_hex(),"79d5d3707e1b5fef")
cases=cases+1; end
do
local r=np.random.default_rng(9876)
local x=np.array({{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2025-07-01","2026-10-09"}},"datetime64[D]")
local y=r:permuted(x,2,x)
deep(normalized(y,"datetime64[D]"),{{"2024-01-01","2024-02-02","2024-03-03"},{"2023-11-11","2026-10-09","2025-07-01"}})
deep(r:raw_hex(),"79d5d3707e1b5fef")
cases=cases+1; end
print("permuted73 dtypes differential: "..cases.." cases and "..checks.." comparisons passed")
