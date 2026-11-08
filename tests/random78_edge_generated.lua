local np=require('luaray_core')
local function eq(a,b) return a==b or (a~=a and b~=b) end
do local r=np.random.default_rng(42);local x=r:lognormal({0.75}, {0.0}, nil);
  assert(eq(x:tolist()[1],2.117000016612675),"lognormal value 0")
  assert(r:raw_hex()=="705a5661a791ffc1","lognormal PCG64 0")
end
do local r=np.random.default_rng(42);local x=r:lognormal({0.75}, {0.0}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 1");for i=1,#e do assert(eq(t[i],e[i]),"lognormal value 1") end
  assert(r:raw_hex()=="c621fbcd16d92688","lognormal PCG64 1")
end
do local r=np.random.default_rng(42);local x=r:lognormal({0.75}, {0.0}, {2});
  local e={2.117000016612675,2.117000016612675};local t=x:tolist(); assert(#t==#e,"length 2");for i=1,#e do assert(eq(t[i],e[i]),"lognormal value 2") end
  assert(r:raw_hex()=="dbcd12c26eda1624","lognormal PCG64 2")
end
do local r=np.random.default_rng(43);local x=r:lognormal({0.75}, {(0/0)}, nil);
  assert(eq(x:tolist()[1],(0/0)),"lognormal value 3")
  assert(r:raw_hex()=="0b34dc0f66bc04b6","lognormal PCG64 3")
end
do local r=np.random.default_rng(43);local x=r:lognormal({0.75}, {(0/0)}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 4");for i=1,#e do assert(eq(t[i],e[i]),"lognormal value 4") end
  assert(r:raw_hex()=="a6fd15a0815ce843","lognormal PCG64 4")
end
do local r=np.random.default_rng(43);local x=r:lognormal({0.75}, {(0/0)}, {2});
  local e={(0/0),(0/0)};local t=x:tolist(); assert(#t==#e,"length 5");for i=1,#e do assert(eq(t[i],e[i]),"lognormal value 5") end
  assert(r:raw_hex()=="0520a8b493c045ff","lognormal PCG64 5")
end
do local r=np.random.default_rng(44);local x=r:lognormal({0.75}, {(1/0)}, nil);
  assert(eq(x:tolist()[1],(1/0)),"lognormal value 6")
  assert(r:raw_hex()=="4213b2ced1ae1c86","lognormal PCG64 6")
end
do local r=np.random.default_rng(44);local x=r:lognormal({0.75}, {(1/0)}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 7");for i=1,#e do assert(eq(t[i],e[i]),"lognormal value 7") end
  assert(r:raw_hex()=="1f607407aab6b677","lognormal PCG64 7")
end
do local r=np.random.default_rng(44);local x=r:lognormal({0.75}, {(1/0)}, {2});
  local e={(1/0),(1/0)};local t=x:tolist(); assert(#t==#e,"length 8");for i=1,#e do assert(eq(t[i],e[i]),"lognormal value 8") end
  assert(r:raw_hex()=="67e09725aa76d661","lognormal PCG64 8")
end
do local r=np.random.default_rng(45);local x=r:lognormal({0.75}, {1e-300}, nil);
  assert(eq(x:tolist()[1],2.117000016612675),"lognormal value 9")
  assert(r:raw_hex()=="874b3218bb4ac3f1","lognormal PCG64 9")
end
do local r=np.random.default_rng(45);local x=r:lognormal({0.75}, {1e-300}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 10");for i=1,#e do assert(eq(t[i],e[i]),"lognormal value 10") end
  assert(r:raw_hex()=="92b8b0d3ecae231c","lognormal PCG64 10")
end
do local r=np.random.default_rng(45);local x=r:lognormal({0.75}, {1e-300}, {2});
  local e={2.117000016612675,2.117000016612675};local t=x:tolist(); assert(#t==#e,"length 11");for i=1,#e do assert(eq(t[i],e[i]),"lognormal value 11") end
  assert(r:raw_hex()=="c37e950588260454","lognormal PCG64 11")
end
do local r=np.random.default_rng(46);local x=r:lognormal({0.75}, {1e+100}, nil);
  assert(eq(x:tolist()[1],0.0),"lognormal value 12")
  assert(r:raw_hex()=="13c52297382a14ba","lognormal PCG64 12")
end
do local r=np.random.default_rng(46);local x=r:lognormal({0.75}, {1e+100}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 13");for i=1,#e do assert(eq(t[i],e[i]),"lognormal value 13") end
  assert(r:raw_hex()=="e7d5ae8f80ac13c3","lognormal PCG64 13")
end
do local r=np.random.default_rng(46);local x=r:lognormal({0.75}, {1e+100}, {2});
  local e={0.0,(1/0)};local t=x:tolist(); assert(#t==#e,"length 14");for i=1,#e do assert(eq(t[i],e[i]),"lognormal value 14") end
  assert(r:raw_hex()=="45c721ab8c9bc77b","lognormal PCG64 14")
end
do local r=np.random.default_rng(62);local x=r:laplace({0.75}, {0.0}, nil);
  assert(eq(x:tolist()[1],0.75),"laplace value 15")
  assert(r:raw_hex()=="bf6e123d912ad97b","laplace PCG64 15")
end
do local r=np.random.default_rng(62);local x=r:laplace({0.75}, {0.0}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 16");for i=1,#e do assert(eq(t[i],e[i]),"laplace value 16") end
  assert(r:raw_hex()=="9bfc680d72992b4a","laplace PCG64 16")
end
do local r=np.random.default_rng(62);local x=r:laplace({0.75}, {0.0}, {2});
  local e={0.75,0.75};local t=x:tolist(); assert(#t==#e,"length 17");for i=1,#e do assert(eq(t[i],e[i]),"laplace value 17") end
  assert(r:raw_hex()=="c7dbc8a5cde8d1b3","laplace PCG64 17")
end
do local r=np.random.default_rng(63);local x=r:laplace({0.75}, {(0/0)}, nil);
  assert(eq(x:tolist()[1],(0/0)),"laplace value 18")
  assert(r:raw_hex()=="fe04ad5eeb047ae5","laplace PCG64 18")
end
do local r=np.random.default_rng(63);local x=r:laplace({0.75}, {(0/0)}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 19");for i=1,#e do assert(eq(t[i],e[i]),"laplace value 19") end
  assert(r:raw_hex()=="8f615c9974a7c078","laplace PCG64 19")
end
do local r=np.random.default_rng(63);local x=r:laplace({0.75}, {(0/0)}, {2});
  local e={(0/0),(0/0)};local t=x:tolist(); assert(#t==#e,"length 20");for i=1,#e do assert(eq(t[i],e[i]),"laplace value 20") end
  assert(r:raw_hex()=="325a1a98ee248bf6","laplace PCG64 20")
end
do local r=np.random.default_rng(64);local x=r:laplace({0.75}, {(1/0)}, nil);
  assert(eq(x:tolist()[1],(1/0)),"laplace value 21")
  assert(r:raw_hex()=="85f995ffdc39e92f","laplace PCG64 21")
end
do local r=np.random.default_rng(64);local x=r:laplace({0.75}, {(1/0)}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 22");for i=1,#e do assert(eq(t[i],e[i]),"laplace value 22") end
  assert(r:raw_hex()=="f188c9738299812e","laplace PCG64 22")
end
do local r=np.random.default_rng(64);local x=r:laplace({0.75}, {(1/0)}, {2});
  local e={(1/0),(1/0)};local t=x:tolist(); assert(#t==#e,"length 23");for i=1,#e do assert(eq(t[i],e[i]),"laplace value 23") end
  assert(r:raw_hex()=="10d26e973f4b8df1","laplace PCG64 23")
end
do local r=np.random.default_rng(65);local x=r:laplace({0.75}, {1e-300}, nil);
  assert(eq(x:tolist()[1],0.75),"laplace value 24")
  assert(r:raw_hex()=="84aa3568982ca463","laplace PCG64 24")
end
do local r=np.random.default_rng(65);local x=r:laplace({0.75}, {1e-300}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 25");for i=1,#e do assert(eq(t[i],e[i]),"laplace value 25") end
  assert(r:raw_hex()=="0c21d9302ca9e9f7","laplace PCG64 25")
end
do local r=np.random.default_rng(65);local x=r:laplace({0.75}, {1e-300}, {2});
  local e={0.75,0.75};local t=x:tolist(); assert(#t==#e,"length 26");for i=1,#e do assert(eq(t[i],e[i]),"laplace value 26") end
  assert(r:raw_hex()=="5ff6bb164e250245","laplace PCG64 26")
end
do local r=np.random.default_rng(66);local x=r:laplace({0.75}, {1e+100}, nil);
  assert(eq(x:tolist()[1],1.8803792683784858e+100),"laplace value 27")
  assert(r:raw_hex()=="b15c876f413c1933","laplace PCG64 27")
end
do local r=np.random.default_rng(66);local x=r:laplace({0.75}, {1e+100}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 28");for i=1,#e do assert(eq(t[i],e[i]),"laplace value 28") end
  assert(r:raw_hex()=="ec79d2cbf12c466a","laplace PCG64 28")
end
do local r=np.random.default_rng(66);local x=r:laplace({0.75}, {1e+100}, {2});
  local e={1.8803792683784858e+100,4.871681194774594e+99};local t=x:tolist(); assert(#t==#e,"length 29");for i=1,#e do assert(eq(t[i],e[i]),"laplace value 29") end
  assert(r:raw_hex()=="12abda7ea5563122","laplace PCG64 29")
end
do local r=np.random.default_rng(82);local x=r:gumbel({0.75}, {0.0}, nil);
  assert(eq(x:tolist()[1],0.75),"gumbel value 30")
  assert(r:raw_hex()=="dad3620da77b4e52","gumbel PCG64 30")
end
do local r=np.random.default_rng(82);local x=r:gumbel({0.75}, {0.0}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 31");for i=1,#e do assert(eq(t[i],e[i]),"gumbel value 31") end
  assert(r:raw_hex()=="ff6540d6b78a60a0","gumbel PCG64 31")
end
do local r=np.random.default_rng(82);local x=r:gumbel({0.75}, {0.0}, {2});
  local e={0.75,0.75};local t=x:tolist(); assert(#t==#e,"length 32");for i=1,#e do assert(eq(t[i],e[i]),"gumbel value 32") end
  assert(r:raw_hex()=="37ba4bbdee8e267a","gumbel PCG64 32")
end
do local r=np.random.default_rng(83);local x=r:gumbel({0.75}, {(0/0)}, nil);
  assert(eq(x:tolist()[1],(0/0)),"gumbel value 33")
  assert(r:raw_hex()=="0b6b395d8d59374b","gumbel PCG64 33")
end
do local r=np.random.default_rng(83);local x=r:gumbel({0.75}, {(0/0)}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 34");for i=1,#e do assert(eq(t[i],e[i]),"gumbel value 34") end
  assert(r:raw_hex()=="51008763bf02c3f2","gumbel PCG64 34")
end
do local r=np.random.default_rng(83);local x=r:gumbel({0.75}, {(0/0)}, {2});
  local e={(0/0),(0/0)};local t=x:tolist(); assert(#t==#e,"length 35");for i=1,#e do assert(eq(t[i],e[i]),"gumbel value 35") end
  assert(r:raw_hex()=="a10c41004d88af54","gumbel PCG64 35")
end
do local r=np.random.default_rng(84);local x=r:gumbel({0.75}, {(1/0)}, nil);
  assert(eq(x:tolist()[1],(-1/0)),"gumbel value 36")
  assert(r:raw_hex()=="e673bf4b2c3279a5","gumbel PCG64 36")
end
do local r=np.random.default_rng(84);local x=r:gumbel({0.75}, {(1/0)}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 37");for i=1,#e do assert(eq(t[i],e[i]),"gumbel value 37") end
  assert(r:raw_hex()=="bb6aca49a79355a6","gumbel PCG64 37")
end
do local r=np.random.default_rng(84);local x=r:gumbel({0.75}, {(1/0)}, {2});
  local e={(-1/0),(-1/0)};local t=x:tolist(); assert(#t==#e,"length 38");for i=1,#e do assert(eq(t[i],e[i]),"gumbel value 38") end
  assert(r:raw_hex()=="bfd166a28a14addf","gumbel PCG64 38")
end
do local r=np.random.default_rng(85);local x=r:gumbel({0.75}, {1e-300}, nil);
  assert(eq(x:tolist()[1],0.75),"gumbel value 39")
  assert(r:raw_hex()=="78c5da56ee244371","gumbel PCG64 39")
end
do local r=np.random.default_rng(85);local x=r:gumbel({0.75}, {1e-300}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 40");for i=1,#e do assert(eq(t[i],e[i]),"gumbel value 40") end
  assert(r:raw_hex()=="0b58c065b64ea8ff","gumbel PCG64 40")
end
do local r=np.random.default_rng(85);local x=r:gumbel({0.75}, {1e-300}, {2});
  local e={0.75,0.75};local t=x:tolist(); assert(#t==#e,"length 41");for i=1,#e do assert(eq(t[i],e[i]),"gumbel value 41") end
  assert(r:raw_hex()=="7680f95f824b6360","gumbel PCG64 41")
end
do local r=np.random.default_rng(86);local x=r:gumbel({0.75}, {1e+100}, nil);
  assert(eq(x:tolist()[1],4.529710438255889e+98),"gumbel value 42")
  assert(r:raw_hex()=="2ce404052f312b10","gumbel PCG64 42")
end
do local r=np.random.default_rng(86);local x=r:gumbel({0.75}, {1e+100}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 43");for i=1,#e do assert(eq(t[i],e[i]),"gumbel value 43") end
  assert(r:raw_hex()=="9d8ef040f5315da3","gumbel PCG64 43")
end
do local r=np.random.default_rng(86);local x=r:gumbel({0.75}, {1e+100}, {2});
  local e={4.529710438255889e+98,1.646094786046008e+100};local t=x:tolist(); assert(#t==#e,"length 44");for i=1,#e do assert(eq(t[i],e[i]),"gumbel value 44") end
  assert(r:raw_hex()=="9d96f58724a03a17","gumbel PCG64 44")
end
do local r=np.random.default_rng(102);local x=r:logistic({0.75}, {0.0}, nil);
  assert(eq(x:tolist()[1],0.75),"logistic value 45")
  assert(r:raw_hex()=="960064e98ac4eefb","logistic PCG64 45")
end
do local r=np.random.default_rng(102);local x=r:logistic({0.75}, {0.0}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 46");for i=1,#e do assert(eq(t[i],e[i]),"logistic value 46") end
  assert(r:raw_hex()=="28f52dff716d94d4","logistic PCG64 46")
end
do local r=np.random.default_rng(102);local x=r:logistic({0.75}, {0.0}, {2});
  local e={0.75,0.75};local t=x:tolist(); assert(#t==#e,"length 47");for i=1,#e do assert(eq(t[i],e[i]),"logistic value 47") end
  assert(r:raw_hex()=="d2e6f78f3e0b928c","logistic PCG64 47")
end
do local r=np.random.default_rng(103);local x=r:logistic({0.75}, {(0/0)}, nil);
  assert(eq(x:tolist()[1],(0/0)),"logistic value 48")
  assert(r:raw_hex()=="396ceb461362858b","logistic PCG64 48")
end
do local r=np.random.default_rng(103);local x=r:logistic({0.75}, {(0/0)}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 49");for i=1,#e do assert(eq(t[i],e[i]),"logistic value 49") end
  assert(r:raw_hex()=="500c02228d7848d1","logistic PCG64 49")
end
do local r=np.random.default_rng(103);local x=r:logistic({0.75}, {(0/0)}, {2});
  local e={(0/0),(0/0)};local t=x:tolist(); assert(#t==#e,"length 50");for i=1,#e do assert(eq(t[i],e[i]),"logistic value 50") end
  assert(r:raw_hex()=="2e983085b809626f","logistic PCG64 50")
end
do local r=np.random.default_rng(104);local x=r:logistic({0.75}, {(1/0)}, nil);
  assert(eq(x:tolist()[1],(1/0)),"logistic value 51")
  assert(r:raw_hex()=="b1309efe57663239","logistic PCG64 51")
end
do local r=np.random.default_rng(104);local x=r:logistic({0.75}, {(1/0)}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 52");for i=1,#e do assert(eq(t[i],e[i]),"logistic value 52") end
  assert(r:raw_hex()=="d6ac2efcb41aa81d","logistic PCG64 52")
end
do local r=np.random.default_rng(104);local x=r:logistic({0.75}, {(1/0)}, {2});
  local e={(1/0),(1/0)};local t=x:tolist(); assert(#t==#e,"length 53");for i=1,#e do assert(eq(t[i],e[i]),"logistic value 53") end
  assert(r:raw_hex()=="375198f243e26923","logistic PCG64 53")
end
do local r=np.random.default_rng(105);local x=r:logistic({0.75}, {1e-300}, nil);
  assert(eq(x:tolist()[1],0.75),"logistic value 54")
  assert(r:raw_hex()=="fdd04ecefdd36263","logistic PCG64 54")
end
do local r=np.random.default_rng(105);local x=r:logistic({0.75}, {1e-300}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 55");for i=1,#e do assert(eq(t[i],e[i]),"logistic value 55") end
  assert(r:raw_hex()=="a360c4f647481b0e","logistic PCG64 55")
end
do local r=np.random.default_rng(105);local x=r:logistic({0.75}, {1e-300}, {2});
  local e={0.75,0.75};local t=x:tolist(); assert(#t==#e,"length 56");for i=1,#e do assert(eq(t[i],e[i]),"logistic value 56") end
  assert(r:raw_hex()=="18c342f7b400daea","logistic PCG64 56")
end
do local r=np.random.default_rng(106);local x=r:logistic({0.75}, {1e+100}, nil);
  assert(eq(x:tolist()[1],4.0225540842935514e+100),"logistic value 57")
  assert(r:raw_hex()=="0a57aa176e811c34","logistic PCG64 57")
end
do local r=np.random.default_rng(106);local x=r:logistic({0.75}, {1e+100}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 58");for i=1,#e do assert(eq(t[i],e[i]),"logistic value 58") end
  assert(r:raw_hex()=="fb7f14ca8c6bec37","logistic PCG64 58")
end
do local r=np.random.default_rng(106);local x=r:logistic({0.75}, {1e+100}, {2});
  local e={4.0225540842935514e+100,-3.167682802178505e+100};local t=x:tolist(); assert(#t==#e,"length 59");for i=1,#e do assert(eq(t[i],e[i]),"logistic value 59") end
  assert(r:raw_hex()=="1f6ef2d1353d3b05","logistic PCG64 59")
end
do local r=np.random.default_rng(122);local x=r:rayleigh({0.0}, nil);
  assert(eq(x:tolist()[1],0.0),"rayleigh value 60")
  assert(r:raw_hex()=="2cf5b1cd2c90db49","rayleigh PCG64 60")
end
do local r=np.random.default_rng(122);local x=r:rayleigh({0.0}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 61");for i=1,#e do assert(eq(t[i],e[i]),"rayleigh value 61") end
  assert(r:raw_hex()=="d34a4e75dd0587f8","rayleigh PCG64 61")
end
do local r=np.random.default_rng(122);local x=r:rayleigh({0.0}, {2});
  local e={0.0,0.0};local t=x:tolist(); assert(#t==#e,"length 62");for i=1,#e do assert(eq(t[i],e[i]),"rayleigh value 62") end
  assert(r:raw_hex()=="60a95fed8cfaec3b","rayleigh PCG64 62")
end
do local r=np.random.default_rng(123);local x=r:rayleigh({(0/0)}, nil);
  assert(eq(x:tolist()[1],(0/0)),"rayleigh value 63")
  assert(r:raw_hex()=="0dc736db97cb6d23","rayleigh PCG64 63")
end
do local r=np.random.default_rng(123);local x=r:rayleigh({(0/0)}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 64");for i=1,#e do assert(eq(t[i],e[i]),"rayleigh value 64") end
  assert(r:raw_hex()=="aeae9c9903f3e9cd","rayleigh PCG64 64")
end
do local r=np.random.default_rng(123);local x=r:rayleigh({(0/0)}, {2});
  local e={(0/0),(0/0)};local t=x:tolist(); assert(#t==#e,"length 65");for i=1,#e do assert(eq(t[i],e[i]),"rayleigh value 65") end
  assert(r:raw_hex()=="3869812ee8b9ea96","rayleigh PCG64 65")
end
do local r=np.random.default_rng(124);local x=r:rayleigh({(1/0)}, nil);
  assert(eq(x:tolist()[1],(1/0)),"rayleigh value 66")
  assert(r:raw_hex()=="c92e142fd4a57bbf","rayleigh PCG64 66")
end
do local r=np.random.default_rng(124);local x=r:rayleigh({(1/0)}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 67");for i=1,#e do assert(eq(t[i],e[i]),"rayleigh value 67") end
  assert(r:raw_hex()=="c906591be11a833c","rayleigh PCG64 67")
end
do local r=np.random.default_rng(124);local x=r:rayleigh({(1/0)}, {2});
  local e={(1/0),(1/0)};local t=x:tolist(); assert(#t==#e,"length 68");for i=1,#e do assert(eq(t[i],e[i]),"rayleigh value 68") end
  assert(r:raw_hex()=="f8194c4ca2e6cd77","rayleigh PCG64 68")
end
do local r=np.random.default_rng(125);local x=r:rayleigh({1e-300}, nil);
  assert(eq(x:tolist()[1],3.6210539433704605e-300),"rayleigh value 69")
  assert(r:raw_hex()=="7e5fd8421ac6b3f5","rayleigh PCG64 69")
end
do local r=np.random.default_rng(125);local x=r:rayleigh({1e-300}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 70");for i=1,#e do assert(eq(t[i],e[i]),"rayleigh value 70") end
  assert(r:raw_hex()=="da0c4110735d07fa","rayleigh PCG64 70")
end
do local r=np.random.default_rng(125);local x=r:rayleigh({1e-300}, {2});
  local e={3.6210539433704605e-300,1.2745745570212316e-300};local t=x:tolist(); assert(#t==#e,"length 71");for i=1,#e do assert(eq(t[i],e[i]),"rayleigh value 71") end
  assert(r:raw_hex()=="63e1a4645537738d","rayleigh PCG64 71")
end
do local r=np.random.default_rng(126);local x=r:rayleigh({1e+100}, nil);
  assert(eq(x:tolist()[1],1.1540248858663472e+99),"rayleigh value 72")
  assert(r:raw_hex()=="f1170f3017d39601","rayleigh PCG64 72")
end
do local r=np.random.default_rng(126);local x=r:rayleigh({1e+100}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 73");for i=1,#e do assert(eq(t[i],e[i]),"rayleigh value 73") end
  assert(r:raw_hex()=="0194c15c4d91a265","rayleigh PCG64 73")
end
do local r=np.random.default_rng(126);local x=r:rayleigh({1e+100}, {2});
  local e={1.1540248858663472e+99,2.2504886524426006e+100};local t=x:tolist(); assert(#t==#e,"length 74");for i=1,#e do assert(eq(t[i],e[i]),"rayleigh value 74") end
  assert(r:raw_hex()=="10edc0f0af49ad54","rayleigh PCG64 74")
end
do local r=np.random.default_rng(142);local x=r:weibull({0.0}, nil);
  assert(eq(x:tolist()[1],0.0),"weibull value 75")
  assert(r:raw_hex()=="05b4cd3f0407699e","weibull PCG64 75")
end
do local r=np.random.default_rng(142);local x=r:weibull({0.0}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 76");for i=1,#e do assert(eq(t[i],e[i]),"weibull value 76") end
  assert(r:raw_hex()=="05b4cd3f0407699e","weibull PCG64 76")
end
do local r=np.random.default_rng(142);local x=r:weibull({0.0}, {2});
  local e={0.0,0.0};local t=x:tolist(); assert(#t==#e,"length 77");for i=1,#e do assert(eq(t[i],e[i]),"weibull value 77") end
  assert(r:raw_hex()=="05b4cd3f0407699e","weibull PCG64 77")
end
do local r=np.random.default_rng(143);local x=r:weibull({(0/0)}, nil);
  assert(eq(x:tolist()[1],(0/0)),"weibull value 78")
  assert(r:raw_hex()=="fa0f0c0eacad769b","weibull PCG64 78")
end
do local r=np.random.default_rng(143);local x=r:weibull({(0/0)}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 79");for i=1,#e do assert(eq(t[i],e[i]),"weibull value 79") end
  assert(r:raw_hex()=="69cf5998ec8bafff","weibull PCG64 79")
end
do local r=np.random.default_rng(143);local x=r:weibull({(0/0)}, {2});
  local e={(0/0),(0/0)};local t=x:tolist(); assert(#t==#e,"length 80");for i=1,#e do assert(eq(t[i],e[i]),"weibull value 80") end
  assert(r:raw_hex()=="817287971ae87447","weibull PCG64 80")
end
do local r=np.random.default_rng(144);local x=r:weibull({(1/0)}, nil);
  assert(eq(x:tolist()[1],1.0),"weibull value 81")
  assert(r:raw_hex()=="0f47abd7507d875c","weibull PCG64 81")
end
do local r=np.random.default_rng(144);local x=r:weibull({(1/0)}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 82");for i=1,#e do assert(eq(t[i],e[i]),"weibull value 82") end
  assert(r:raw_hex()=="caf270a050424990","weibull PCG64 82")
end
do local r=np.random.default_rng(144);local x=r:weibull({(1/0)}, {2});
  local e={1.0,1.0};local t=x:tolist(); assert(#t==#e,"length 83");for i=1,#e do assert(eq(t[i],e[i]),"weibull value 83") end
  assert(r:raw_hex()=="4cb78207f5cf230b","weibull PCG64 83")
end
do local r=np.random.default_rng(145);local x=r:weibull({1e-300}, nil);
  assert(eq(x:tolist()[1],0.0),"weibull value 84")
  assert(r:raw_hex()=="44c307c40f5f725d","weibull PCG64 84")
end
do local r=np.random.default_rng(145);local x=r:weibull({1e-300}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 85");for i=1,#e do assert(eq(t[i],e[i]),"weibull value 85") end
  assert(r:raw_hex()=="99c2ec9586379ba1","weibull PCG64 85")
end
do local r=np.random.default_rng(145);local x=r:weibull({1e-300}, {2});
  local e={0.0,0.0};local t=x:tolist(); assert(#t==#e,"length 86");for i=1,#e do assert(eq(t[i],e[i]),"weibull value 86") end
  assert(r:raw_hex()=="ded06fd837b4c3d0","weibull PCG64 86")
end
do local r=np.random.default_rng(146);local x=r:weibull({1e+100}, nil);
  assert(eq(x:tolist()[1],1.0),"weibull value 87")
  assert(r:raw_hex()=="6109226e797d237f","weibull PCG64 87")
end
do local r=np.random.default_rng(146);local x=r:weibull({1e+100}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 88");for i=1,#e do assert(eq(t[i],e[i]),"weibull value 88") end
  assert(r:raw_hex()=="ccedd53be0010d59","weibull PCG64 88")
end
do local r=np.random.default_rng(146);local x=r:weibull({1e+100}, {2});
  local e={1.0,1.0};local t=x:tolist(); assert(#t==#e,"length 89");for i=1,#e do assert(eq(t[i],e[i]),"weibull value 89") end
  assert(r:raw_hex()=="6cc8d555f99f7d2c","weibull PCG64 89")
end
do local r=np.random.default_rng(163);local x=r:pareto({(0/0)}, nil);
  assert(eq(x:tolist()[1],(0/0)),"pareto value 90")
  assert(r:raw_hex()=="06fc6f710b17609d","pareto PCG64 90")
end
do local r=np.random.default_rng(163);local x=r:pareto({(0/0)}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 91");for i=1,#e do assert(eq(t[i],e[i]),"pareto value 91") end
  assert(r:raw_hex()=="ce800830727d7c01","pareto PCG64 91")
end
do local r=np.random.default_rng(163);local x=r:pareto({(0/0)}, {2});
  local e={(0/0),(0/0)};local t=x:tolist(); assert(#t==#e,"length 92");for i=1,#e do assert(eq(t[i],e[i]),"pareto value 92") end
  assert(r:raw_hex()=="91652739377bc498","pareto PCG64 92")
end
do local r=np.random.default_rng(164);local x=r:pareto({(1/0)}, nil);
  assert(eq(x:tolist()[1],0.0),"pareto value 93")
  assert(r:raw_hex()=="5b02c33a1e22801b","pareto PCG64 93")
end
do local r=np.random.default_rng(164);local x=r:pareto({(1/0)}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 94");for i=1,#e do assert(eq(t[i],e[i]),"pareto value 94") end
  assert(r:raw_hex()=="12b2c48b8f525adb","pareto PCG64 94")
end
do local r=np.random.default_rng(164);local x=r:pareto({(1/0)}, {2});
  local e={0.0,0.0};local t=x:tolist(); assert(#t==#e,"length 95");for i=1,#e do assert(eq(t[i],e[i]),"pareto value 95") end
  assert(r:raw_hex()=="5dd4a6fc20dd6dae","pareto PCG64 95")
end
do local r=np.random.default_rng(165);local x=r:pareto({1e-300}, nil);
  assert(eq(x:tolist()[1],(1/0)),"pareto value 96")
  assert(r:raw_hex()=="93d0000be20e8631","pareto PCG64 96")
end
do local r=np.random.default_rng(165);local x=r:pareto({1e-300}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 97");for i=1,#e do assert(eq(t[i],e[i]),"pareto value 97") end
  assert(r:raw_hex()=="76724ee695a434e9","pareto PCG64 97")
end
do local r=np.random.default_rng(165);local x=r:pareto({1e-300}, {2});
  local e={(1/0),(1/0)};local t=x:tolist(); assert(#t==#e,"length 98");for i=1,#e do assert(eq(t[i],e[i]),"pareto value 98") end
  assert(r:raw_hex()=="c558ef17aa672605","pareto PCG64 98")
end
do local r=np.random.default_rng(166);local x=r:pareto({1e+100}, nil);
  assert(eq(x:tolist()[1],1.5460754604485144e-100),"pareto value 99")
  assert(r:raw_hex()=="2b5dbaaf0da022ea","pareto PCG64 99")
end
do local r=np.random.default_rng(166);local x=r:pareto({1e+100}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 100");for i=1,#e do assert(eq(t[i],e[i]),"pareto value 100") end
  assert(r:raw_hex()=="b75b9677ed2e4d1e","pareto PCG64 100")
end
do local r=np.random.default_rng(166);local x=r:pareto({1e+100}, {2});
  local e={1.5460754604485144e-100,2.138514178394629e-101};local t=x:tolist(); assert(#t==#e,"length 101");for i=1,#e do assert(eq(t[i],e[i]),"pareto value 101") end
  assert(r:raw_hex()=="b48d012e52ca52bb","pareto PCG64 101")
end
do local r=np.random.default_rng(183);local x=r:power({(0/0)}, nil);
  assert(eq(x:tolist()[1],(0/0)),"power value 102")
  assert(r:raw_hex()=="e712e1dee6b8105c","power PCG64 102")
end
do local r=np.random.default_rng(183);local x=r:power({(0/0)}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 103");for i=1,#e do assert(eq(t[i],e[i]),"power value 103") end
  assert(r:raw_hex()=="f391fffcf840e6bd","power PCG64 103")
end
do local r=np.random.default_rng(183);local x=r:power({(0/0)}, {2});
  local e={(0/0),(0/0)};local t=x:tolist(); assert(#t==#e,"length 104");for i=1,#e do assert(eq(t[i],e[i]),"power value 104") end
  assert(r:raw_hex()=="b04f058641440abd","power PCG64 104")
end
do local r=np.random.default_rng(184);local x=r:power({(1/0)}, nil);
  assert(eq(x:tolist()[1],1.0),"power value 105")
  assert(r:raw_hex()=="956a83ef53d3448a","power PCG64 105")
end
do local r=np.random.default_rng(184);local x=r:power({(1/0)}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 106");for i=1,#e do assert(eq(t[i],e[i]),"power value 106") end
  assert(r:raw_hex()=="048d56bd5c7cb3fc","power PCG64 106")
end
do local r=np.random.default_rng(184);local x=r:power({(1/0)}, {2});
  local e={1.0,1.0};local t=x:tolist(); assert(#t==#e,"length 107");for i=1,#e do assert(eq(t[i],e[i]),"power value 107") end
  assert(r:raw_hex()=="e148b732545886ab","power PCG64 107")
end
do local r=np.random.default_rng(185);local x=r:power({1e-300}, nil);
  assert(eq(x:tolist()[1],0.0),"power value 108")
  assert(r:raw_hex()=="8964cfa7e6bcb41e","power PCG64 108")
end
do local r=np.random.default_rng(185);local x=r:power({1e-300}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 109");for i=1,#e do assert(eq(t[i],e[i]),"power value 109") end
  assert(r:raw_hex()=="3836452f489ad2b1","power PCG64 109")
end
do local r=np.random.default_rng(185);local x=r:power({1e-300}, {2});
  local e={0.0,0.0};local t=x:tolist(); assert(#t==#e,"length 110");for i=1,#e do assert(eq(t[i],e[i]),"power value 110") end
  assert(r:raw_hex()=="5c643b64e343b030","power PCG64 110")
end
do local r=np.random.default_rng(186);local x=r:power({1e+100}, nil);
  assert(eq(x:tolist()[1],1.0),"power value 111")
  assert(r:raw_hex()=="a27ea3890c81bbff","power PCG64 111")
end
do local r=np.random.default_rng(186);local x=r:power({1e+100}, {0});
  local e={};local t=x:tolist(); assert(#t==#e,"length 112");for i=1,#e do assert(eq(t[i],e[i]),"power value 112") end
  assert(r:raw_hex()=="8c18ddd402595113","power PCG64 112")
end
do local r=np.random.default_rng(186);local x=r:power({1e+100}, {2});
  local e={1.0,1.0};local t=x:tolist(); assert(#t==#e,"length 113");for i=1,#e do assert(eq(t[i],e[i]),"power value 113") end
  assert(r:raw_hex()=="df4eb40d6ba44885","power PCG64 113")
end
print("random78 edge oracle passed: 114 cases")