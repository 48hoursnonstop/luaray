local np=require("luaray_core")
local function eq(a,b)
  if type(a)~=type(b) then return false end
  if type(a)~="table" then
    if type(a)=="number" and a~=a and b~=b then return true end
    return a==b
  end
  if #a~=#b then return false end
  for i=1,#a do if not eq(a[i],b[i]) then return false end end
  return true
end
-- Generated against development NumPy 2.3.5.
do local ok=pcall(function() return np.array({-1/0},np.uint32) end); assert(not ok,'cast case 0 expected error') end
do local got=np.array({32768},np.bool)[1]; assert(got==true,'cast case 1') end
do local got=np.array({255},np.int32)[1]; assert(got==255,'cast case 2') end
do local ok=pcall(function() return np.array({-129.0},np.uint16) end); assert(not ok,'cast case 3 expected error') end
do local got=np.array({200},np.uint32)[1]; assert(got==200,'cast case 4') end
do local got=np.array({127},np.int32)[1]; assert(got==127,'cast case 5') end
do local got=np.array({32767},np.uint32)[1]; assert(got==32767,'cast case 6') end
do local ok=pcall(function() return np.array({-1e+20},np.uint64) end); assert(not ok,'cast case 7 expected error') end
do local ok=pcall(function() return np.array({1e+20},np.uint8) end); assert(not ok,'cast case 8 expected error') end
do local got=np.array({200},np.uint64)[1]; assert(got==200,'cast case 9') end
do local ok=pcall(function() return np.array({-1/0},np.int32) end); assert(not ok,'cast case 10 expected error') end
do local got=np.array({1},np.float64)[1]; assert(got==1.0,'cast case 11') end
do local ok=pcall(function() return np.array({-1/0},np.uint64) end); assert(not ok,'cast case 12 expected error') end
do local ok=pcall(function() return np.array({-129.0},np.uint32) end); assert(not ok,'cast case 13 expected error') end
do local got=np.array({200},np.uint64)[1]; assert(got==200,'cast case 14') end
do local got=np.array({255},np.uint8)[1]; assert(got==255,'cast case 15') end
do local got=np.array({1},np.float64)[1]; assert(got==1.0,'cast case 16') end
do local got=np.array({-128},np.int16)[1]; assert(got==-128,'cast case 17') end
do local got=np.array({-1},np.int32)[1]; assert(got==-1,'cast case 18') end
do local got=np.array({-128},np.int64)[1]; assert(got==-128,'cast case 19') end
do local got=np.array({128.0},np.bool)[1]; assert(got==true,'cast case 20') end
do local got=np.array({-1/0},np.float64)[1]; assert(got==-math.huge,'cast case 21') end
do local ok=pcall(function() return np.array({-1},np.uint32) end); assert(not ok,'cast case 22 expected error') end
do local got=np.array({0/0},np.bool)[1]; assert(got==true,'cast case 23') end
do local ok=pcall(function() return np.array({-129.0},np.uint8) end); assert(not ok,'cast case 24 expected error') end
do local ok=pcall(function() return np.array({32768},np.uint8) end); assert(not ok,'cast case 25 expected error') end
do local ok=pcall(function() return np.array({-1e+20},np.int8) end); assert(not ok,'cast case 26 expected error') end
do local got=np.array({127},np.uint32)[1]; assert(got==127,'cast case 27') end
do local got=np.array({-129.0},np.float32)[1]; assert(math.abs(got-(-129.0))<=math.max(1e-6,math.abs(-129.0)*2e-7),'cast case 28') end
do local ok=pcall(function() return np.array({-1/0},np.uint8) end); assert(not ok,'cast case 29 expected error') end
do local got=np.array({256},np.uint32)[1]; assert(got==256,'cast case 30') end
do local ok=pcall(function() return np.array({1e+20},np.uint64) end); assert(not ok,'cast case 31 expected error') end
do local got=np.array({-128},np.float64)[1]; assert(got==-128.0,'cast case 32') end
do local got=np.array({256},np.bool)[1]; assert(got==true,'cast case 33') end
do local got=np.array({127.9},np.int8)[1]; assert(got==127,'cast case 34') end
do local ok=pcall(function() return np.array({-1/0},np.int16) end); assert(not ok,'cast case 35 expected error') end
do local ok=pcall(function() return np.array({0/0},np.uint64) end); assert(not ok,'cast case 36 expected error') end
do local ok=pcall(function() return np.array({32767},np.uint8) end); assert(not ok,'cast case 37 expected error') end
do local got=np.array({-32769},np.float16)[1]; assert(got==-32768.0,'cast case 38') end
do local got=np.array({128},np.uint64)[1]; assert(got==128,'cast case 39') end
do local got=np.array({200},np.bool)[1]; assert(got==true,'cast case 40') end
do local ok=pcall(function() return np.array({-1},np.uint16) end); assert(not ok,'cast case 41 expected error') end
do local ok=pcall(function() return np.array({256},np.uint8) end); assert(not ok,'cast case 42 expected error') end
do local got=np.array({-128.9},np.int32)[1]; assert(got==-128,'cast case 43') end
do local got=np.array({200},np.int32)[1]; assert(got==200,'cast case 44') end
do local ok=pcall(function() return np.array({-128},np.uint32) end); assert(not ok,'cast case 45 expected error') end
do local got=np.array({0},np.bool)[1]; assert(got==false,'cast case 46') end
do local got=np.array({1/0},np.bool)[1]; assert(got==true,'cast case 47') end
do local got=np.array({1},np.int64)[1]; assert(got==1,'cast case 48') end
do local got=np.array({200},np.uint32)[1]; assert(got==200,'cast case 49') end
do local got=np.array({1/0},np.bool)[1]; assert(got==true,'cast case 50') end
do local got=np.array({255},np.int32)[1]; assert(got==255,'cast case 51') end
do local got=np.array({128.0},np.float32)[1]; assert(math.abs(got-(128.0))<=math.max(1e-6,math.abs(128.0)*2e-7),'cast case 52') end
do local got=np.array({127.9},np.int8)[1]; assert(got==127,'cast case 53') end
do local got=np.array({0},np.float16)[1]; assert(got==0.0,'cast case 54') end
do local got=np.array({-1e+20},np.bool)[1]; assert(got==true,'cast case 55') end
do local got=np.array({-128},np.int64)[1]; assert(got==-128,'cast case 56') end
do local got=np.array({-32769},np.float16)[1]; assert(got==-32768.0,'cast case 57') end
do local got=np.array({255},np.uint64)[1]; assert(got==255,'cast case 58') end
do local ok=pcall(function() return np.array({0/0},np.int32) end); assert(not ok,'cast case 59 expected error') end
do local got=np.array({127},np.float64)[1]; assert(got==127.0,'cast case 60') end
do local got=np.array({128},np.uint64)[1]; assert(got==128,'cast case 61') end
do local got=np.array({127.9},np.int8)[1]; assert(got==127,'cast case 62') end
do local ok=pcall(function() return np.array({-128},np.uint8) end); assert(not ok,'cast case 63 expected error') end
do local got=np.array({255},np.int16)[1]; assert(got==255,'cast case 64') end
do local got=np.array({200},np.uint8)[1]; assert(got==200,'cast case 65') end
do local got=np.array({128},np.uint16)[1]; assert(got==128,'cast case 66') end
do local got=np.array({1},np.uint64)[1]; assert(got==1,'cast case 67') end
do local ok=pcall(function() return np.array({1/0},np.uint64) end); assert(not ok,'cast case 68 expected error') end
do local got=np.array({128},np.bool)[1]; assert(got==true,'cast case 69') end
do local got=np.array({0/0},np.bool)[1]; assert(got==true,'cast case 70') end
do local got=np.array({200},np.int64)[1]; assert(got==200,'cast case 71') end
do local got=np.array({127},np.float16)[1]; assert(got==127.0,'cast case 72') end
do local got=np.array({128.0},np.uint16)[1]; assert(got==128,'cast case 73') end
do local got=np.array({1},np.uint32)[1]; assert(got==1,'cast case 74') end
do local got=np.array({-32769},np.int64)[1]; assert(got==-32769,'cast case 75') end
do local ok=pcall(function() return np.array({256},np.uint8) end); assert(not ok,'cast case 76 expected error') end
do local ok=pcall(function() return np.array({-1},np.uint8) end); assert(not ok,'cast case 77 expected error') end
do local got=np.array({-128},np.int32)[1]; assert(got==-128,'cast case 78') end
do local ok=pcall(function() return np.array({-32768},np.uint8) end); assert(not ok,'cast case 79 expected error') end
do local got=np.array({200},np.uint8)[1]; assert(got==200,'cast case 80') end
do local got=np.array({0/0},np.float16)[1]; assert(got~=got,'cast case 81') end
do local got=np.array({256},np.uint64)[1]; assert(got==256,'cast case 82') end
do local got=np.array({128.0},np.uint32)[1]; assert(got==128,'cast case 83') end
do local got=np.array({-32769},np.float64)[1]; assert(got==-32769.0,'cast case 84') end
do local got=np.array({127},np.int32)[1]; assert(got==127,'cast case 85') end
do local ok=pcall(function() return np.array({-1e+20},np.int8) end); assert(not ok,'cast case 86 expected error') end
do local ok=pcall(function() return np.array({-1/0},np.int64) end); assert(not ok,'cast case 87 expected error') end
do local ok=pcall(function() return np.array({-1e+20},np.int16) end); assert(not ok,'cast case 88 expected error') end
do local got=np.array({-129.0},np.float16)[1]; assert(got==-129.0,'cast case 89') end
do local ok=pcall(function() return np.array({-1/0},np.int16) end); assert(not ok,'cast case 90 expected error') end
do local got=np.array({128.0},np.uint8)[1]; assert(got==128,'cast case 91') end
do local got=np.array({-128},np.int16)[1]; assert(got==-128,'cast case 92') end
do local got=np.array({32768},np.float16)[1]; assert(got==32768.0,'cast case 93') end
do local ok=pcall(function() return np.array({-128.9},np.uint8) end); assert(not ok,'cast case 94 expected error') end
do local ok=pcall(function() return np.array({1/0},np.uint64) end); assert(not ok,'cast case 95 expected error') end
do local got=np.array({0},np.float32)[1]; assert(math.abs(got-(0.0))<=math.max(1e-6,math.abs(0.0)*2e-7),'cast case 96') end
do local ok=pcall(function() return np.array({-32769},np.uint16) end); assert(not ok,'cast case 97 expected error') end
do local got=np.array({-129},np.bool)[1]; assert(got==true,'cast case 98') end
do local ok=pcall(function() return np.array({-128.9},np.uint64) end); assert(not ok,'cast case 99 expected error') end
do local got=np.array({127},np.float16)[1]; assert(got==127.0,'cast case 100') end
do local got=np.array({1},np.float32)[1]; assert(math.abs(got-(1.0))<=math.max(1e-6,math.abs(1.0)*2e-7),'cast case 101') end
do local ok=pcall(function() return np.array({-129},np.uint8) end); assert(not ok,'cast case 102 expected error') end
do local got=np.array({-1e+20},np.float64)[1]; assert(got==-1e+20,'cast case 103') end
do local got=np.array({32767},np.bool)[1]; assert(got==true,'cast case 104') end
do local got=np.array({1.5},np.float64)[1]; assert(got==1.5,'cast case 105') end
do local got=np.array({-129},np.float32)[1]; assert(math.abs(got-(-129.0))<=math.max(1e-6,math.abs(-129.0)*2e-7),'cast case 106') end
do local got=np.array({32768},np.uint32)[1]; assert(got==32768,'cast case 107') end
do local ok=pcall(function() return np.array({1e+20},np.int64) end); assert(not ok,'cast case 108 expected error') end
do local got=np.array({32768},np.uint16)[1]; assert(got==32768,'cast case 109') end
do local got=np.array({127.9},np.float64)[1]; assert(got==127.9,'cast case 110') end
do local got=np.array({0},np.int64)[1]; assert(got==0,'cast case 111') end
do local got=np.array({1.5},np.uint16)[1]; assert(got==1,'cast case 112') end
do local got=np.array({256},np.bool)[1]; assert(got==true,'cast case 113') end
do local got=np.array({128},np.int32)[1]; assert(got==128,'cast case 114') end
do local got=np.array({0/0},np.bool)[1]; assert(got==true,'cast case 115') end
do local got=np.array({1},np.float32)[1]; assert(math.abs(got-(1.0))<=math.max(1e-6,math.abs(1.0)*2e-7),'cast case 116') end
do local got=np.array({127},np.bool)[1]; assert(got==true,'cast case 117') end
do local got=np.array({255},np.float16)[1]; assert(got==255.0,'cast case 118') end
do local got=np.array({127.9},np.uint32)[1]; assert(got==127,'cast case 119') end
do local ok=pcall(function() return np.array({32767},np.uint8) end); assert(not ok,'cast case 120 expected error') end
do local got=np.array({255},np.int32)[1]; assert(got==255,'cast case 121') end
do local ok=pcall(function() return np.array({-1/0},np.uint16) end); assert(not ok,'cast case 122 expected error') end
do local got=np.array({-32768},np.int32)[1]; assert(got==-32768,'cast case 123') end
do local ok=pcall(function() return np.array({1e+20},np.int8) end); assert(not ok,'cast case 124 expected error') end
do local ok=pcall(function() return np.array({-129},np.uint16) end); assert(not ok,'cast case 125 expected error') end
do local got=np.array({-32769},np.bool)[1]; assert(got==true,'cast case 126') end
do local got=np.array({200},np.int16)[1]; assert(got==200,'cast case 127') end
do local ok=pcall(function() return np.array({128},np.int8) end); assert(not ok,'cast case 128 expected error') end
do local got=np.array({256},np.uint16)[1]; assert(got==256,'cast case 129') end
do local got=np.array({-32769},np.int32)[1]; assert(got==-32769,'cast case 130') end
do local got=np.array({-1},np.int16)[1]; assert(got==-1,'cast case 131') end
do local got=np.array({127},np.uint8)[1]; assert(got==127,'cast case 132') end
do local got=np.array({0},np.uint64)[1]; assert(got==0,'cast case 133') end
do local got=np.array({-32768},np.int32)[1]; assert(got==-32768,'cast case 134') end
do local got=np.array({0},np.int32)[1]; assert(got==0,'cast case 135') end
do local got=np.array({127},np.int16)[1]; assert(got==127,'cast case 136') end
do local got=np.array({128},np.int64)[1]; assert(got==128,'cast case 137') end
do local got=np.array({255},np.float16)[1]; assert(got==255.0,'cast case 138') end
do local ok=pcall(function() return np.array({-129.0},np.uint16) end); assert(not ok,'cast case 139 expected error') end
do local ok=pcall(function() return np.array({-129},np.uint64) end); assert(not ok,'cast case 140 expected error') end
do local ok=pcall(function() return np.array({-1/0},np.uint8) end); assert(not ok,'cast case 141 expected error') end
do local got=np.array({0},np.uint16)[1]; assert(got==0,'cast case 142') end
do local got=np.array({127},np.int8)[1]; assert(got==127,'cast case 143') end
do local got=np.array({255},np.uint64)[1]; assert(got==255,'cast case 144') end
do local got=np.array({128.0},np.uint64)[1]; assert(got==128,'cast case 145') end
do local got=np.array({-32769},np.float32)[1]; assert(math.abs(got-(-32769.0))<=math.max(1e-6,math.abs(-32769.0)*2e-7),'cast case 146') end
do local ok=pcall(function() return np.array({-1},np.uint64) end); assert(not ok,'cast case 147 expected error') end
do local got=np.array({128},np.uint64)[1]; assert(got==128,'cast case 148') end
do local got=np.array({-128.9},np.float16)[1]; assert(got==-128.875,'cast case 149') end
do local got=np.array({-129.0},np.int32)[1]; assert(got==-129,'cast case 150') end
do local got=np.array({1.5},np.uint8)[1]; assert(got==1,'cast case 151') end
do local got=np.array({1.5},np.uint32)[1]; assert(got==1,'cast case 152') end
do local got=np.array({-129},np.bool)[1]; assert(got==true,'cast case 153') end
do local got=np.array({-1},np.float32)[1]; assert(math.abs(got-(-1.0))<=math.max(1e-6,math.abs(-1.0)*2e-7),'cast case 154') end
do local ok=pcall(function() return np.array({-129},np.uint32) end); assert(not ok,'cast case 155 expected error') end
do local got=np.array({-128.9},np.float32)[1]; assert(math.abs(got-(-128.89999389648438))<=math.max(1e-6,math.abs(-128.89999389648438)*2e-7),'cast case 156') end
do local got=np.array({1e+20},np.float32)[1]; assert(math.abs(got-(1.0000000200408773e+20))<=math.max(1e-6,math.abs(1.0000000200408773e+20)*2e-7),'cast case 157') end
do local got=np.array({-128},np.bool)[1]; assert(got==true,'cast case 158') end
do local got=np.array({1.5},np.int64)[1]; assert(got==1,'cast case 159') end
do local got=np.array({-128},np.bool)[1]; assert(got==true,'cast case 160') end
do local got=np.array({-32768},np.int32)[1]; assert(got==-32768,'cast case 161') end
do local got=np.array({128},np.uint16)[1]; assert(got==128,'cast case 162') end
do local ok=pcall(function() return np.array({-129.0},np.uint32) end); assert(not ok,'cast case 163 expected error') end
do local got=np.array({0},np.float16)[1]; assert(got==0.0,'cast case 164') end
do local got=np.array({127},np.float16)[1]; assert(got==127.0,'cast case 165') end
do local got=np.array({127},np.int64)[1]; assert(got==127,'cast case 166') end
do local ok=pcall(function() return np.array({1e+20},np.int8) end); assert(not ok,'cast case 167 expected error') end
do local got=np.array({0},np.uint8)[1]; assert(got==0,'cast case 168') end
do local got=np.array({32768},np.bool)[1]; assert(got==true,'cast case 169') end
do local got=np.array({128.0},np.int16)[1]; assert(got==128,'cast case 170') end
do local got=np.array({1.5},np.int8)[1]; assert(got==1,'cast case 171') end
do local got=np.array({127.9},np.int64)[1]; assert(got==127,'cast case 172') end
do local got=np.array({-32769},np.bool)[1]; assert(got==true,'cast case 173') end
do local got=np.array({256},np.int16)[1]; assert(got==256,'cast case 174') end
do local ok=pcall(function() return np.array({-1/0},np.int32) end); assert(not ok,'cast case 175 expected error') end
do local ok=pcall(function() return np.array({-32768},np.uint8) end); assert(not ok,'cast case 176 expected error') end
do local got=np.array({-128.9},np.float16)[1]; assert(got==-128.875,'cast case 177') end
do local ok=pcall(function() return np.array({0/0},np.int16) end); assert(not ok,'cast case 178 expected error') end
do local got=np.array({200},np.int64)[1]; assert(got==200,'cast case 179') end
do local got=np.array({-128.9},np.int16)[1]; assert(got==-128,'cast case 180') end
do local got=np.array({-128.9},np.float16)[1]; assert(got==-128.875,'cast case 181') end
do local got=np.array({255},np.float32)[1]; assert(math.abs(got-(255.0))<=math.max(1e-6,math.abs(255.0)*2e-7),'cast case 182') end
do local ok=pcall(function() return np.array({0/0},np.uint8) end); assert(not ok,'cast case 183 expected error') end
do local got=np.array({1.5},np.float64)[1]; assert(got==1.5,'cast case 184') end
do local got=np.array({-1e+20},np.bool)[1]; assert(got==true,'cast case 185') end
do local got=np.array({1},np.int16)[1]; assert(got==1,'cast case 186') end
do local got=np.array({-128.9},np.int8)[1]; assert(got==-128,'cast case 187') end
do local got=np.array({127},np.int8)[1]; assert(got==127,'cast case 188') end
do local ok=pcall(function() return np.array({-129.0},np.uint16) end); assert(not ok,'cast case 189 expected error') end
do local got=np.array({255},np.int16)[1]; assert(got==255,'cast case 190') end
do local got=np.array({256},np.uint16)[1]; assert(got==256,'cast case 191') end
do local got=np.array({-129},np.int64)[1]; assert(got==-129,'cast case 192') end
do local got=np.array({1/0},np.float64)[1]; assert(got==math.huge,'cast case 193') end
do local ok=pcall(function() return np.array({0/0},np.int64) end); assert(not ok,'cast case 194 expected error') end
do local ok=pcall(function() return np.array({-128.9},np.uint32) end); assert(not ok,'cast case 195 expected error') end
do local ok=pcall(function() return np.array({-1e+20},np.int16) end); assert(not ok,'cast case 196 expected error') end
do local got=np.array({128.0},np.int64)[1]; assert(got==128,'cast case 197') end
do local ok=pcall(function() return np.array({128.0},np.int8) end); assert(not ok,'cast case 198 expected error') end
do local got=np.array({128.0},np.bool)[1]; assert(got==true,'cast case 199') end
do local ok=pcall(function() return np.array({0/0},np.uint64) end); assert(not ok,'cast case 200 expected error') end
do local got=np.array({256},np.int32)[1]; assert(got==256,'cast case 201') end
do local got=np.array({127.9},np.uint32)[1]; assert(got==127,'cast case 202') end
do local got=np.array({1},np.float32)[1]; assert(math.abs(got-(1.0))<=math.max(1e-6,math.abs(1.0)*2e-7),'cast case 203') end
do local got=np.array({1.5},np.uint32)[1]; assert(got==1,'cast case 204') end
do local got=np.array({-128},np.int8)[1]; assert(got==-128,'cast case 205') end
do local got=np.array({1.5},np.int16)[1]; assert(got==1,'cast case 206') end
do local ok=pcall(function() return np.array({-32769},np.uint16) end); assert(not ok,'cast case 207 expected error') end
do local got=np.array({127},np.float16)[1]; assert(got==127.0,'cast case 208') end
do local got=np.array({255},np.uint8)[1]; assert(got==255,'cast case 209') end
do local got=np.array({1e+20},np.float64)[1]; assert(got==1e+20,'cast case 210') end
do local got=np.array({32767},np.uint32)[1]; assert(got==32767,'cast case 211') end
do local got=np.array({-1e+20},np.float16)[1]; assert(got==-math.huge,'cast case 212') end
do local ok=pcall(function() return np.array({-1e+20},np.uint8) end); assert(not ok,'cast case 213 expected error') end
do local got=np.array({128.0},np.bool)[1]; assert(got==true,'cast case 214') end
do local got=np.array({-1/0},np.float64)[1]; assert(got==-math.huge,'cast case 215') end
do local ok=pcall(function() return np.array({-1},np.uint16) end); assert(not ok,'cast case 216 expected error') end
do local got=np.array({-128},np.int64)[1]; assert(got==-128,'cast case 217') end
do local got=np.array({-1e+20},np.float64)[1]; assert(got==-1e+20,'cast case 218') end
do local ok=pcall(function() return np.array({-1e+20},np.int16) end); assert(not ok,'cast case 219 expected error') end
do local ok=pcall(function() return np.array({-1},np.uint16) end); assert(not ok,'cast case 220 expected error') end
do local got=np.array({-32768},np.float64)[1]; assert(got==-32768.0,'cast case 221') end
do local got=np.array({255},np.int32)[1]; assert(got==255,'cast case 222') end
do local got=np.array({32767},np.uint64)[1]; assert(got==32767,'cast case 223') end
do local got=np.array({1},np.int16)[1]; assert(got==1,'cast case 224') end
do local got=np.array({32767},np.int16)[1]; assert(got==32767,'cast case 225') end
do local ok=pcall(function() return np.array({-1},np.uint64) end); assert(not ok,'cast case 226 expected error') end
do local got=np.array({128},np.bool)[1]; assert(got==true,'cast case 227') end
do local got=np.array({-129.0},np.float16)[1]; assert(got==-129.0,'cast case 228') end
do local ok=pcall(function() return np.array({-128},np.uint8) end); assert(not ok,'cast case 229 expected error') end
do local got=np.array({128},np.int16)[1]; assert(got==128,'cast case 230') end
do local got=np.array({1e+20},np.float16)[1]; assert(got==math.huge,'cast case 231') end
do local got=np.array({128.0},np.uint16)[1]; assert(got==128,'cast case 232') end
do local ok=pcall(function() return np.array({-1},np.uint16) end); assert(not ok,'cast case 233 expected error') end
do local ok=pcall(function() return np.array({-32769},np.int16) end); assert(not ok,'cast case 234 expected error') end
do local ok=pcall(function() return np.array({0/0},np.uint32) end); assert(not ok,'cast case 235 expected error') end
do local got=np.array({-32768},np.float16)[1]; assert(got==-32768.0,'cast case 236') end
do local got=np.array({-1e+20},np.float32)[1]; assert(math.abs(got-(-1.0000000200408773e+20))<=math.max(1e-6,math.abs(-1.0000000200408773e+20)*2e-7),'cast case 237') end
do local got=np.array({0/0},np.float64)[1]; assert(got~=got,'cast case 238') end
do local got=np.array({-129.0},np.int64)[1]; assert(got==-129,'cast case 239') end
do local got=np.array({32767},np.uint64)[1]; assert(got==32767,'cast case 240') end
do local got=np.array({32768},np.uint64)[1]; assert(got==32768,'cast case 241') end
do local got=np.array({1},np.uint64)[1]; assert(got==1,'cast case 242') end
do local got=np.array({127.9},np.float32)[1]; assert(math.abs(got-(127.9000015258789))<=math.max(1e-6,math.abs(127.9000015258789)*2e-7),'cast case 243') end
do local got=np.array({127.9},np.float64)[1]; assert(got==127.9,'cast case 244') end
do local got=np.array({200},np.float32)[1]; assert(math.abs(got-(200.0))<=math.max(1e-6,math.abs(200.0)*2e-7),'cast case 245') end
do local got=np.array({0},np.uint32)[1]; assert(got==0,'cast case 246') end
do local got=np.array({127},np.float64)[1]; assert(got==127.0,'cast case 247') end
do local got=np.array({127},np.float64)[1]; assert(got==127.0,'cast case 248') end
do local ok=pcall(function() return np.array({0/0},np.uint16) end); assert(not ok,'cast case 249 expected error') end
do local got=np.array({-32769},np.int32)[1]; assert(got==-32769,'cast case 250') end
do local got=np.array({-32768},np.float64)[1]; assert(got==-32768.0,'cast case 251') end
do local got=np.array({1},np.int64)[1]; assert(got==1,'cast case 252') end
do local ok=pcall(function() return np.array({1/0},np.uint32) end); assert(not ok,'cast case 253 expected error') end
do local got=np.array({127},np.float32)[1]; assert(math.abs(got-(127.0))<=math.max(1e-6,math.abs(127.0)*2e-7),'cast case 254') end
do local got=np.array({-32769},np.float64)[1]; assert(got==-32769.0,'cast case 255') end
do local ok=pcall(function() return np.array({1e+20},np.int16) end); assert(not ok,'cast case 256 expected error') end
do local got=np.array({1.5},np.bool)[1]; assert(got==true,'cast case 257') end
do local ok=pcall(function() return np.array({-1e+20},np.uint8) end); assert(not ok,'cast case 258 expected error') end
do local got=np.array({-129},np.bool)[1]; assert(got==true,'cast case 259') end
print('casting differential: 260 cases ok')
