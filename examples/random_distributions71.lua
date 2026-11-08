local np=require("luaray_core")
local r=np.random.default_rng(42)
local t=r:standard_t(5,{2,3})
local circular=r:vonmises(0.8,4,{2,3})
print("Student's t distribution:")
for i=1,2 do
  for j=1,3 do io.write(string.format(" %.8f",t:get(i,j))) end
  io.write("\n")
end
print("Circular von Mises distribution:")
for i=1,2 do
  for j=1,3 do io.write(string.format(" %.8f",circular:get(i,j))) end
  io.write("\n")
end
