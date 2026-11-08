-- Generated independently using NumPy 2.3.5 by tools/generate_random78_oracle.py
local np=require('luaray_core')
local cases=0
local function same(a,b)
  if type(a)~=type(b) then return false end
  if type(b)=='table' then
    if #a~=#b then return false end
    for i=1,#b do if not same(a[i],b[i]) then return false end end
    return true
  end
  if type(b)=='number' then
    if a~=a then return b~=b end
    if a==b then return true end
    return math.abs(a-b)<=8e-13*math.max(1,math.abs(b))
  end
  return a==b
end
local function check(v,why) assert(v,('random78 case %d: %s'):format(cases,why)) end
do local r=np.random.default_rng(0);local x=r:lognormal(0.418, {{{0.5529503556723696,0.6779503556723696,0.8029503556723696}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1,3}),"shape");check(same(x:tolist(),{{{1.6282772767180338,1.3887991611951396,2.540161330489332}}}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(0.813, 1.443, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),3.712397852044537),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(np.array({0.8578516167139947,0.9828516167139947,1.1078516167139947},"float64"), np.array({0.8023982039300763,0.9273982039300763,1.0523982039300763},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{3.011252346574161,1.018542032107331,6.670035000185505}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(np.array({1.01041711012206},"float64"), {1.164377518141178}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{4.519958622002907}}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(np.array({{{0.5557038788345241}},{{0.6807038788345241}}},"float64"), 1.889, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.08425192624582606,1.9675490210270634,7.065667819664639}},{{2.635311879893172,10.09778496646585,484.70880576699983}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal({{{0.7062460632313783,0.8312460632313783,0.9562460632313784}}}, {{{1.168981224749617}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1,3}),"shape");check(same(x:tolist(),{{{0.2111120613665391,2.2100977586207207,1.3226669932707293}}}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal({0.9941302016244202,1.1191302016244202,1.2441302016244202}, {1.1078712262014887,1.2328712262014887,1.3578712262014887}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{9.984936067120836,0.5700539718351598,0.9440239419352542}}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal({{{0.924930263582709,1.049930263582709,1.1749302635827092}},{{1.2999302635827092,1.4249302635827092,1.5499302635827092}}}, np.array({{{0.9580388102693025,1.0830388102693025,1.2080388102693025}},{{1.3330388102693025,1.4580388102693025,1.5830388102693025}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{2.8444925753110217,2.476523023054582,7.018753795664584}},{{4.219709095471871,1.9038983132589837,8.350732579664271}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal({{0.745406935626779}}, {{0.9556094289919681},{1.080609428991968}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.9318993287230923,4.620731290652127,2.8897665528935104},{0.5154076921240374,5.60547064483254,3.4135865316470633}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal({{{1.0146717129155245}}}, {{{1.0902524729537728}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{3.845448582755738,0.8876537521786307,6.251697238072156}},{{7.69156843865955,0.3287527842468288,0.6669549912885598}}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal({{0.9466328099065302}}, np.array({{0.31889545991951646,0.44389545991951646,0.5688954599195165}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{2.953664814671865,2.000186867715628,11.666756173764265}}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(np.array({{{1.1243038875071483}}},"float64"), np.array({{{0.4890669619017674}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.4048356118602876,3.17609685144415,4.422253212056296}},{{3.316615690985605,4.696100522581497,12.794360321825696}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(np.array({1.0192954723611882,1.1442954723611882,1.2692954723611884},"float64"), {0.7621171045515946,0.8871171045515946,1.0121171045515949}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.6343450436839191,3.050480647245882,1.9807808025477447}}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(np.array({0.39159240193763306},"float64"), 1.094, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{5.377244041234574}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(np.array({{0.6181693474067655}},"float64"), 0.487, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.972693691930104,1.7399115506661336,2.534649031061218},{1.952783331680537,1.429462304434889,2.212816501396456}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(1.201, {{0.9049776109581551}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{4.543719530714293}}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal({0.8770582939365885}, np.array({0.85246386805894},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{3.1168366536014904}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(np.array({0.6354129029410265,0.7604129029410265,0.8854129029410266},"float64"), {1.034032628572112,1.159032628572112,1.284032628572112}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{2.938035037915979,1.1038383873787876,73.24624910412972}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(np.array({1.128799300410167},"float64"), {0.7061254225920182}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{0.9962962343541732}}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(np.array({{{0.8930260710496838,1.0180260710496838,1.1430260710496838}}},"float64"), np.array({{{0.9012549968793935}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.42715008094029144,2.6873824556923442,1.8615094862815766}},{{3.251296803650042,0.2742901304499475,1.48109318455068}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(0.98, np.array({0.37854030429913926,0.5035403042991393,0.6285403042991393},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{4.164353964745362,1.3409359673905226,1.4585530514923555}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal({{1.2915249225929881},{1.4165249225929881}}, {{1.1249666476639044},{1.2499666476639044}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{4.191116758626354,3.135884769508304,7.478102211462809},{4.700395106381677,2.110565818501339,6.478614535083254}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(1.103, np.array({0.6468260648726871},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{3.767956692067753}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal({{{1.1272604334143574,1.2522604334143574,1.3772604334143574}},{{1.5022604334143574,1.6272604334143574,1.7522604334143574}}}, {{{1.0439666167015034,1.1689666167015034,1.2939666167015034}},{{1.4189666167015034,1.5439666167015034,1.6689666167015034}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{4.243442678294453,1.0372300342584249,10.467960677908414}},{{17.06262445220678,0.2503055854235491,0.6563679863636996}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(1.99, 0.483, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{8.994496521740096}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal({{{1.1778586818285877,1.3028586818285877,1.4278586818285877}}}, {{{1.0532865486803495,1.1782865486803495,1.3032865486803495}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1,3}),"shape");check(same(x:tolist(),{{{0.5996308569174245,3.968494280292367,10.95123616617773}}}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(0.834, np.array({{0.6255254239101549},{0.7505254239101549}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.6864680298907194,2.255911444106234,1.6031195647942065},{2.9217752454445565,0.33588234651932264,1.2327266799582817}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(1.165, 1.384, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{16.40677570548258}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(1.154, np.array({{{0.7131631099430156,0.8381631099430156,0.9631631099430157}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{3.4683055323644445,2.838496688370878,5.875736839639152}},{{3.4171637487813955,2.023890587267838,4.491896598721082}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(1.253, 0.844, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),4.6864391832073835),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(np.array({{1.2300731769498725,1.3550731769498725,1.4800731769498725},{1.6050731769498725,1.7300731769498725,1.8550731769498725}},"float64"), np.array({{0.7599917129993299}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.313094519166493,1.7589092534212436,7.771085563424887},{10.174601510217533,1.2805665559033341,2.3760217200574982}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal({0.5144220284795156}, {1.2280753705310223}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{2.8285261636645633,0.8297676843807167,43.566993052703495}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(np.array({{{1.120474684198507}},{{1.245474684198507}}},"float64"), {{{0.3364347869578485}},{{0.4614347869578485}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.7876254773833242,3.133153875247256,3.9343130389411702}},{{3.7280991379486705,5.176018661992078,13.32550680295761}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal({{{1.2836045957807007,1.4086045957807007,1.5336045957807007}},{{1.6586045957807007,1.7836045957807007,1.9086045957807007}}}, np.array({{{1.010582094211752,1.135582094211752,1.260582094211752}},{{1.385582094211752,1.510582094211752,1.635582094211752}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.5109134944152145,3.941206779284398,2.234440616480867}},{{8.152637563483594,0.12358446649631323,1.7281850091004693}}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal({0.37636809079096495,0.501368090790965,0.626368090790965}, 1.774, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{11.812314193871556,0.14694829742678284,0.3415398245107554}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal({{0.8766628622410093,1.0016628622410093,1.1266628622410093},{1.2516628622410093,1.3766628622410093,1.5016628622410093}}, {{0.35344465153960286}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.5120559876212494,2.5985954950756986,3.8690802711560965},{3.6282093973024883,3.27832751144708,5.101153549966355}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(np.array({{{0.8781296882290612,1.0031296882290612,1.1281296882290612}}},"float64"), np.array({{{1.2467352902745432,1.3717352902745432,1.4967352902745432}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{3.7024016224661778,8.4163167404715,5.066785137782737}},{{0.4739931441602649,9.440776950053136,6.026908925886983}}}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal({{{0.7244250343826149}},{{0.8494250343826149}}}, np.array({{{0.7832075658476387,0.9082075658476387,1.033207565847639}},{{1.158207565847639,1.283207565847639,1.408207565847639}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{2.6197575011837992,0.8024414394678757,4.480778876553856}},{{6.950365200816664,0.19125300749540544,0.37369549440774674}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(np.array({0.8018365452436829},"float64"), np.array({1.08409163150312},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{3.5451425957507925}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal({1.1484884469421472}, np.array({0.838212817323712,0.963212817323712,1.088212817323712},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.8221206486058945,3.3542570681215427,7.062053345508404}}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal({1.2603737865110825,1.3853737865110825,1.5103737865110825}, np.array({0.5181294627089335,0.6431294627089335,0.7681294627089335},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.2942814595116636,3.913188286867,2.903123709952629}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal({{0.7408970429204687}}, np.array({{1.2674285702080037,1.3924285702080037,1.5174285702080037}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{9.356516058732044,0.3141667943414894,0.4897805648751149},{70.36418138145741,2.5465699982210026,1.7429943645227284}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(np.array({{1.2750649028010648,1.4000649028010648,1.525064902801065},{1.650064902801065,1.775064902801065,1.900064902801065}},"float64"), {{0.44345743208396265},{0.5684574320839626}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{3.7841485347265422,3.824707597889036,6.104737363985221},{5.527281780120671,4.351669943494186,8.21216259931224}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(np.array({{0.7088441249295079,0.8338441249295079,0.9588441249295079}},"float64"), np.array({{0.6322347082237267,0.7572347082237267,0.8822347082237267},{1.0072347082237267,1.1322347082237267,1.2572347082237267}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.527762302025368,4.28877824110175,3.491624785362113},{0.5467623295757454,6.416799418639274,4.572415998876533}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(np.array({1.2994056149547513,1.4244056149547513,1.5494056149547513},"float64"), {0.304800612311999}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{4.024028709927531,3.0265332500025846,5.918858438380017}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(1.734, 1.467, nil);cases=cases+1
  check(same(x,10.607258569619352),"scalar")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal({1.2696700928398656}, np.array({0.8469690851337288},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.9150925246979271}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal({{0.5776008266840702,0.7026008266840702,0.8276008266840703},{0.9526008266840703,1.0776008266840704,1.2026008266840704}}, np.array({{0.7676390778641837,0.8926390778641837,1.017639077864184},{1.142639077864184,1.267639077864184,1.392639077864184}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.4035155828452476,1.960940157827411,1.2694711508259453},{3.725629513155272,0.11375380045498472,1.0442561027984891}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(1.096, 0.981, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{9.518890805037804,0.7852913072772186,1.1683080821715004},{45.37339333327912,3.430041253274577,2.6543784931737457}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(0.932, 1.627, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),3.1160403266307064),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(0.844, 1.682, nil);cases=cases+1
  check(same(x,4.158991475273978),"scalar")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(np.array({0.46410820274276404,0.5891082027427641,0.7141082027427641},"float64"), {0.9038182187204438,1.0288182187204438,1.1538182187204438}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{2.094923528880286,0.6182598794935019,4.854919227947133}}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal({{{0.4202663537822086,0.5452663537822087,0.6702663537822087}},{{0.7952663537822087,0.9202663537822087,1.0452663537822087}}}, np.array({{{0.8719894472765495}},{{0.9969894472765495}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{2.210629349305047,1.0486483278493517,19.785078914606338}},{{0.44555437319720864,4.85490670632168,2.4651981783744636}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(1.299, 0.975, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.7674047701025408),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(1.154, 0.721, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.7859131389984167,3.096998441887123,2.0890128319155488}}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(1.741, 1.506, nil);cases=cases+1
  check(same(x,33.704012168513934),"scalar")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(np.array({{{0.9313182897145191,1.0563182897145191,1.1813182897145191}},{{1.3063182897145191,1.4313182897145191,1.5563182897145191}}},"float64"), np.array({{{1.0972820089852842}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{2.913280597544179,2.487708485800282,6.580051303508392}},{{4.143013000388709,2.324576620576126,7.0504400830580956}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal({0.8796189483748422}, np.array({0.7997250586842235},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{3.1771713445727507}}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(np.array({{0.8652758651180745,0.9902758651180745,1.1152758651180745},{1.2402758651180745,1.3652758651180745,1.4902758651180745}},"float64"), np.array({{1.1043148546882833,1.2293148546882833,1.3543148546882833}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.3260302068604934,0.7496176178570694,8.428535796582372},{9.766473541236389,0.3558803591869922,0.7608757667126842}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(np.array({{1.0640980130613416,1.1890980130613416,1.3140980130613418}},"float64"), {{0.8136420782189384}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.10476976863245,2.0639890800891365,32.26164054358035},{0.7829535989906273,5.62655705299859,3.311497917030268}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(np.array({{1.0767075850596004,1.2017075850596004,1.3267075850596004}},"float64"), np.array({{0.4131765731316756},{0.5381765731316757}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.512917324581624,3.415050114956413,5.118321287495145},{3.1862467593900656,5.293895226161954,18.07390782897245}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal({0.36975811659552055,0.49475811659552055,0.6197581165955206}, np.array({0.6798524797607404},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.3884684461146868,1.6040576691079869,1.253908608777852}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal({1.2928593223738398}, np.array({0.887200307947857},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{10.375869401054954}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal({0.5874056597719903}, np.array({0.5558085872992666},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.9295515074226746}}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal({0.8871599635781107}, np.array({1.0262087073077042},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{3.461844261378632}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal({{1.0039771309050847}}, np.array({{0.861605377075185,0.986605377075185,1.111605377075185},{1.236605377075185,1.361605377075185,1.486605377075185}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.5484929964220613,0.9781651282732117,6.285106049923555},{8.73278659647023,0.1915583393120393,0.39382448994833924}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(0.277, 1.275, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{2.2759708402954413,0.6371068583097736,38.91724152942615}}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal({0.39369413272142345}, np.array({0.7181797330139568},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.46853289984710744}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(1.979, 0.306, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),4.002767174544188),"values")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal({0.7215693769052671,0.8465693769052671,0.9715693769052671}, {0.6615469138663255}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{4.490622354285612,0.9459911905900116,1.4012605357345906}}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(np.array({{{0.36875760505691885}},{{0.49375760505691885}}},"float64"), {{{0.3067150324021863,0.4317150324021863,0.5567150324021863}},{{0.6817150324021863,0.8067150324021863,0.9317150324021863}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.502786353399408,1.3657803492510412,2.0653310361945265}},{{1.7599221793971898,1.0635635073865375,2.294835476993685}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal({0.8492822973880179}, {0.6030469357874935}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.8796990307329398}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal({{1.2889709497329989,1.4139709497329989,1.5389709497329989}}, {{0.4175001823175741}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{4.121389591912005,2.663863188710407,6.374364888846848},{5.374453477867356,1.8210502639658255,2.7055650142359577}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal({{0.5980746660172171}}, 1.453, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.385915826087663,0.7934598775892141,86.05667133109783},{0.17567121097870775,4.756668472272083,1.4765034656653828}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal({{1.0735512878135147,1.1985512878135147,1.323551287813515}}, np.array({{0.8325511460281394,0.9575511460281394,1.0825511460281394},{1.2075511460281394,1.3325511460281394,1.4575511460281394}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.7697227587341439,3.525175541135953,8.377956323273233},{3.5178386105065607,10.48068668444483,262.31403636200474}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(np.array({0.3672190768057813},"float64"), np.array({0.8246675441548064},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.2928033284145736}),"values")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(0.375, 1.352, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),7.170276681854459),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(1.123, 1.308, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),3.6235533369463417),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(np.array({0.6457724528236632,0.7707724528236632,0.8957724528236632},"float64"), {0.5234378034647689}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{2.2856816231950505,3.322901839273051,2.9116959443399395}}),"values")
  check(r:raw_hex()=="f2dab0aed2ac6fd2","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(np.array({{0.6241963172085687,0.7491963172085687,0.8741963172085687},{0.9991963172085687,1.1241963172085687,1.2491963172085687}},"float64"), np.array({{0.9927772929183794}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.5261906970214625,0.753311627793118,5.049186917297864},{6.909985989176607,0.4436376666699814,0.9573579457076199}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(np.array({0.7199454150303164},"float64"), {0.6889299345668587}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.7583948886683247}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(np.array({{{1.1906384732110573}},{{1.3156384732110573}}},"float64"), 1.563, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.2681634882654135,3.635790799609256,10.471440182459597}},{{4.731216098588755,14.377581818899676,353.8285797947312}}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(1.636, np.array({{0.5417945570921272,0.6667945570921272,0.7917945570921273}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.8000192464423248,5.023893128276414,3.2469508839272048},{6.097917216307225,0.9284523686963557,2.6561407591597233}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal({{1.1845999246802572,1.3095999246802572,1.4345999246802572},{1.5595999246802572,1.6845999246802572,1.8095999246802572}}, np.array({{0.8410958310670427,0.9660958310670427,1.0910958310670427}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{8.818346295534527,0.9922530110712642,1.4749326196504071},{48.948531551487434,6.166289584236862,5.346096728250161}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal({{0.5435278820612321}}, np.array({{1.190793306674593,1.315793306674593,1.440793306674593},{1.565793306674593,1.690793306674593,1.815793306674593}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{2.0001988243341566,1.4473078668233568,4.332932438245648},{2.029480366858144,0.6961582257268495,3.3204813670461917}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(np.array({{1.1198104416243193,1.2448104416243193,1.3698104416243195}},"float64"), {{0.5121575606753126,0.6371575606753126,0.7621575606753126}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{3.6575883096773505,5.860943829909262,5.061462927220843}}),"values")
  check(r:raw_hex()=="f2dab0aed2ac6fd2","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(1.925, 0.824, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),8.811757186725213),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(0.885, 1.443, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{4.491883305964525}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal({{{1.1068943607014528}}}, np.array({{{0.790814407971032,0.915814407971032,1.0408144079710322}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.850915123253654,3.207840551899525,6.540572475970708}},{{3.4129868530862524,6.672025327733222,62.73314920183686}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(0.732, 1.328, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.15925258713220253),"values")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(np.array({1.2615104572012685,1.3865104572012685,1.5115104572012688},"float64"), {0.4188538244197974,0.5438538244197975,0.6688538244197975}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{5.787087641948499,1.9058086889385086,2.387647250551677}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(1.491, 0.534, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),4.749977770134298),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(1.849, np.array({0.7245013114034344,0.8495013114034344,0.9745013114034345},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{8.161077447148628,12.768301962552556,8.767146335343837}),"values")
  check(r:raw_hex()=="f2dab0aed2ac6fd2","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(np.array({0.4823272963563207},"float64"), np.array({1.191492297600909},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{2.3288983621633643}}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(1.677, {0.9857782667074191,1.110778266707419,1.235778266707419}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{8.155449334858092,2.837507562465862,142.21284306415066}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal({0.9333967537213166}, np.array({1.0145737668467838},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.49966670374719513}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal({0.838117171939889}, {0.41276794168639913}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.04033272172322}}),"values")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(1.593, 1.437, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),26.795075057025297),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal({{{1.2403208100247762}},{{1.3653208100247762}}}, np.array({{{0.9479406209580306}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{3.8942674760961604,3.0498525460243346,6.343327385329601}},{{4.326504288224465,2.3573498704029143,5.518419246615666}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(0.774, 1.985, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{4.305893308573273}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal({0.46864778442037996,0.59364778442038,0.71864778442038}, 1.319, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{2.3882708553611756,0.45928182858650773,5.520635120263552}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(np.array({{{0.6738200498776967}}},"float64"), np.array({{{1.1795440240596005}},{{1.3045440240596005}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{3.249150426141041,1.0004921420056663,44.91955815466591}},{{0.24060524986001683,4.650883780805388,1.6269621946991077}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(1.073, np.array({0.7237883880150491,0.8487883880150491,0.9737883880150492},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.9159088243325328,3.0876406719431646,6.016293311566779}}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal({0.5655067047411537}, np.array({0.8650457588192206},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.33019044321501634}),"values")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(np.array({{{0.8651563942160139,0.9901563942160139,1.1151563942160139}}},"float64"), np.array({{{1.0332333524652866,1.1582333524652866,1.2832333524652868}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{8.036985038408266,0.5547591862994495,0.891343528042966}},{{41.63126747306142,3.1626258649433594,2.607681091414235}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(1.428, 1.438, nil);cases=cases+1
  check(same(x,4.99681174442068),"scalar")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(1.379, 1.006, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{5.62183260594011,9.075222088034584,5.5368165112880545},{1.0703908102424735,9.872844434772075,6.221759968100237}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(np.array({{{1.2297137261510263,1.3547137261510263,1.4797137261510263}}},"float64"), {{{0.6617225985876105,0.7867225985876105,0.9117225985876106}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{4.184352212385772,1.7100707220779772,8.705169464362962}},{{6.373231586849407,0.8350950340261117,1.3397556442904273}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(0.626, np.array({0.36490297449757075},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{2.18604621817869}}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(np.array({{{1.2704647978631896,1.3954647978631896,1.5204647978631896}},{{1.6454647978631896,1.7704647978631896,1.8954647978631896}}},"float64"), np.array({{{0.32206273212862774,0.44706273212862774,0.5720627321286278}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{2.1253335067796733,4.1542066877981725,6.988745690975911}},{{5.44456439528206,8.641813890206942,35.23149046124833}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal({{0.6633057512701885,0.7883057512701885,0.9133057512701886},{1.0383057512701885,1.1633057512701885,1.2883057512701885}}, {{1.247962013817826,1.372962013817826,1.497962013817826},{1.622962013817826,1.747962013817826,1.872962013817826}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.17358123563196554,2.10313507070653,1.047387204879523},{4.727417251992738,0.03615369724578646,0.7627439040954364}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(0.753, {{0.6809312991093419}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{4.741196537184053,0.8390171569144158,1.1054139095357924},{14.01684285514544,2.3344994460935493,1.9539477047693354}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(1.363, 1.086, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),4.479641496433832),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(0.257, 0.534, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.5551032755377021),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(np.array({{{0.5634880114662739}},{{0.6884880114662739}}},"float64"), np.array({{{0.820272438308743}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{2.255651925682297,0.7485761921660895,3.2513244736649454}},{{4.305991068613843,0.40176321554559014,0.684098101947911}}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(0.575, 1.369, nil);cases=cases+1
  check(same(x,3.1919023307908825),"scalar")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(1.556, {1.1474849388821193}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.7524817172879851,5.101597295561103,11.091306501189539}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(np.array({{{0.5721757170194364,0.6971757170194364,0.8221757170194364}},{{0.9471757170194364,1.0721757170194364,1.1971757170194364}}},"float64"), 0.258, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{1.075759137759634,1.9912104704323519,1.959810169346532}},{{2.798423417334189,1.5074828187527767,2.670871415429464}}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(0.441, {0.9782133418293162}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{4.9282843735156625}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(np.array({0.783446075277922},"float64"), {0.5768030157353061}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.35365077972344}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(0.399, {1.0878414097601563}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.170463620400428}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(1.166, {1.191668099201275}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{4.614122104082668}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(np.array({0.39031122959214865},"float64"), {1.1618531937243446}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.4286052677488357}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(0.794, 1.523, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.19231060982382583}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(np.array({0.7573764009632651},"float64"), 1.18, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.2175005872382723}),"values")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(np.array({0.5816824653959491},"float64"), np.array({0.47760997078564954},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{3.142803888972863}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(1.806, 0.444, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{6.435465763605429}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(np.array({{{0.7022605574808665}}},"float64"), {{{0.3871508459045259}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{2.307244071774305,2.77416754038758,2.293753482426053}},{{1.2186481040710897,2.8655773469016492,2.39905485833065}}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal({{0.39408905733000005,0.51908905733,0.6440890573300001},{0.7690890573300001,0.8940890573300001,1.01908905733}}, np.array({{0.8996505879850651,1.0246505879850651,1.1496505879850651}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.950777395131416,0.5789545692647737,4.512474694801208},{5.029238884579273,0.3311975360690637,0.6200455236501236}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(1.891, np.array({{1.0773650662832825},{1.2023650662832825}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{10.505137422502399,3.5822803169732333,115.6794746435939},{0.9578555848572694,14.682022635388034,5.576434844044377}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal({0.5288266964745774,0.6538266964745774,0.7788266964745775}, {1.175857838402138,1.300857838402138,1.425857838402138}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.25741714370731145,2.090099290045886,6.266590069270389}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(1.136, 0.972, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.4749644466101471),"values")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal({{1.1505797875424728,1.2755797875424728,1.400579787542473},{1.525579787542473,1.650579787542473,1.775579787542473}}, 0.979, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{10.029178882864583,0.9423358566762092,1.58733057536905},{69.33587845411623,5.970756528114475,5.238496578782367}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal({0.77622620524276,0.90122620524276,1.02622620524276}, {0.8831583638219076}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{2.428480860539707,2.191435240923818,4.912685932640732}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(np.array({1.1904256760843162},"float64"), np.array({1.1918032574931279},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{4.964407931390073}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal({1.2773625269948452}, np.array({1.2091080539637709},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{5.185148088954118}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(1.131, 0.475, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),3.7969219790871636),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(np.array({0.7706979591593202},"float64"), np.array({0.4464570242316192},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.056174852576879,2.224018769817676,3.0085976777045715}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(np.array({0.304495299888836,0.429495299888836,0.5544952998888361},"float64"), {0.3112993606799926,0.4362993606799926,0.5612993606799926}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.7424710593528677,1.5147257831201382,1.2581221245782408}}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal({{0.8990367326976902,1.0240367326976902,1.1490367326976902},{1.2740367326976902,1.3990367326976902,1.5240367326976902}}, np.array({{1.027238621099424,1.152238621099424,1.277238621099424},{1.402238621099424,1.527238621099424,1.652238621099424}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{8.255357772801267,0.5785870032128496,0.927374190369031},{174.24488387207566,5.011097495725547,3.7519759806099118}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(np.array({{{0.40893723665632414,0.5339372366563242,0.6589372366563242}},{{0.7839372366563242,0.9089372366563242,1.0339372366563242}}},"float64"), {{{0.5752732080334031}},{{0.7002732080334031}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.6181223992994938,1.5808154921411077,2.7936674456120745}},{{2.3570149770482307,1.7054386088882718,3.622457148085696}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal({0.5812060772542003}, {0.5428109263225243}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{2.1571608864148737}}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(1.202, {0.8993077705118908,1.0243077705118908,1.1493077705118908}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{4.375559676263594,1.1465256537440704,7.881351432333984}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(np.array({1.1158782992266771},"float64"), np.array({0.8564020139781992},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{4.402714832725442}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal({0.9318404182619369}, {0.5711887097502022}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.0158715791955284}}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal({{1.1760269316772842,1.3010269316772842,1.4260269316772844}}, {{0.40135710818696196},{0.526357108186962}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.491118832629989,3.625195345987054,3.2993484650258877},{3.8308046798454427,0.9521748895188072,2.685490395865404}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal({{0.6467793880430519},{0.7717793880430519}}, np.array({{0.9092766202638867}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{5.581436529098741,0.5526013100264171,0.7985914344613636},{26.89439108330371,2.455588709037867,1.9362401687607074}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(np.array({{{0.3830442148909155,0.5080442148909154,0.6330442148909156}}},"float64"), {{{0.3345600507184809,0.4595600507184809,0.5845600507184809}},{{0.7095600507184809,0.8345600507184809,0.9595600507184809}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{1.5297564259979965,1.5641367857474324,2.738498320406348}},{{1.5800826366341918,1.0628946154683618,2.664499897056279}}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(np.array({0.3053507184907031},"float64"), np.array({1.057219019944367,1.182219019944367,1.307219019944367},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.9556231693260036,3.5847305644563896,2.090293212863007}),"values")
  check(r:raw_hex()=="f2dab0aed2ac6fd2","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(np.array({{0.43987008050880955,0.5648700805088096,0.6898700805088096},{0.8148700805088096,0.9398700805088096,1.0648700805088096}},"float64"), {{0.6553856680217616},{0.7803856680217616}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.8956793823195404,0.8898337800461282,3.259927770321799},{4.706164782168005,0.5583943652202822,1.049871584445284}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal({{1.2717919025551128,1.3967919025551128,1.5217919025551128}}, np.array({{0.7538805023071058,0.8788805023071058,1.0038805023071058},{1.1288805023071058,1.2538805023071058,1.3788805023071058}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.924778692304191,2.447565614439641,65.79561752277341},{0.580385273206799,9.267413004016218,3.7585177523473443}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(np.array({{{0.9594815697296044,1.0844815697296044,1.2094815697296046}},{{1.3344815697296046,1.4594815697296046,1.5844815697296046}}},"float64"), np.array({{{0.8648221249273895,0.9898221249273895,1.1148221249273895}},{{1.2398221249273895,1.3648221249273895,1.4898221249273895}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.652103501938342,3.1516593213194604,7.655647253244551}},{{4.5891839637938325,13.989937803412719,374.0843263504058}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(np.array({{{0.38495561189900523,0.5099556118990052,0.6349556118990053}},{{0.7599556118990053,0.8849556118990053,1.0099556118990054}}},"float64"), {{{0.47153746318963413,0.5965374631896341,0.7215374631896342}},{{0.8465374631896342,0.9715374631896342,1.0965374631896343}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.5901836164693961,1.633062671831349,1.2427617964488973}},{{2.797197376830175,0.20050739151529423,1.102023454894446}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal({{1.0343615943334972,1.1593615943334972,1.2843615943334972}}, {{0.8473821929727843}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{7.644695442922075,1.003870988429848,1.6032165848677498},{29.457667477739157,3.5870565237471483,3.257265832575806}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(1.076, np.array({1.2552559346892318},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{3.434336011779358}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal({0.708395969292811,0.833395969292811,0.958395969292811}, {0.5403922674782307}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{2.447695560675659,3.5872721284298175,3.1172824421871774}),"values")
  check(r:raw_hex()=="f2dab0aed2ac6fd2","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal({1.1387722108250862}, {0.9310701393070728}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{4.14741473507349}}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(1.216, 1.124, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),5.456532090835469),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(0.941, np.array({{0.5114327788693791}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.128337472143249,2.6479421658475384,3.7431072960105456},{2.7705738318964674,3.985835448483065,11.368591602619142}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(np.array({{0.40158728253572057}},"float64"), np.array({{1.1679712027449418},{1.2929712027449418}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.15597322911882477,1.438226823274442,0.7600097314249928},{2.25225654727605,0.05421998202181697,0.509288458505126}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(np.array({1.1783757269795025},"float64"), {1.1635062720994098}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{12.819344703066728}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(0.639, np.array({1.191654878003879},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.20081342635196}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(1.379, 1.625, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{6.962748613394754}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(np.array({1.0747977593233},"float64"), np.array({1.1236065049320467},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{4.125469585841168}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal({{0.5210629142811065,0.6460629142811065,0.7710629142811065},{0.8960629142811065,1.0210629142811065,1.1460629142811065}}, np.array({{0.8385718115282923},{0.9635718115282923}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.410366349237561,1.1821970689826486,20.025747558102722},{0.5200212203494626,5.252338852465482,2.739736417064806}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(np.array({{{1.1161279297218116}},{{1.2411279297218116}}},"float64"), {{{0.385542737650226,0.5105427376502261,0.6355427376502261}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.645065657879107,3.1545746693867365,4.889040229830133}},{{3.6691834767993368,5.376868280164387,22.032683942334007}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(1.049, np.array({{0.5159882988137952,0.6409882988137952,0.7659882988137952}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.0520328900366562,2.7956053320523755,1.8324480382691055},{3.362743770575066,0.5515368081582253,1.5088632142553413}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal({0.3287388248725615}, np.array({0.8199573200161399},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{3.6547815176306844,0.4541342374718143,0.632977930639417}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal({0.9533599935469736}, np.array({0.7753720186852817},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{2.860074544166308}}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(np.array({{{0.8568909435172549}}},"float64"), np.array({{{0.4989854178063888,0.6239854178063888,0.7489854178063888}},{{0.8739854178063888,0.9989854178063888,1.1239854178063888}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{2.7991965119488484,3.933653682014883,3.017363675723541}},{{0.7542363685094307,5.820162907023777,3.8907792298787975}}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal({0.9643358922595917,1.0893358922595917,1.2143358922595917}, 1.222, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{3.806462056827251,0.8339976573449087,8.426548466006425}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal({1.153968491505813,1.278968491505813,1.403968491505813}, 0.497, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{3.921876207715908,2.705433682602792,15.229517024678021}}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(0.722, 0.62, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.7615657106148291),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal({1.2598605035065984}, np.array({0.812809296577442},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.7314907450463437}),"values")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(np.array({0.7179327768371357},"float64"), np.array({1.1642220262122411,1.2892220262122411,1.4142220262122411},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{8.095891854700847,0.35343272451460955,0.5284419524348294}}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{2.987084015294124,49.447987152152876},{11.945050253373964,160.56118547933892},{13.44016981593197,529.109969010944}},{{7.22827221968418,111.08667165496507},{4.358807771852644,57.45108537982168},{12.585484840293717,416.1286571785889}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{70.75251927726329,274.8467329651991,516.8888221250454},{1.0228901247827575,14.570761736564396,28.072232745694926}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{25.242720315469032,3.3872281102224115,4.7723478562566175},{816.823908447709,34.354176864974455,20.56036862901968}},{{22.106690546666414,5.8288402682299125,2.6842440209462834},{212.77112432947888,287.01901879634954,97.84102343061564}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{3.746520239888954,35.58313651870841},{54.1006130346552,44.41562337468144},{32.992713902264576,362.2847634731584}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{16.397393609544864,155.7224000935717,703.2190749360292},{3.047935253090013,14.123045820814223,178.5420980584994}},{{18.00919533682834,301.60093340838347,115.63034329102365},{3.5177037608987916,5.031243740382358,54.207496870069534}}}),"values")
  check(r:raw_hex()=="acc5059184ba59cd","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.706690876888451,7.2101193462899635,1.7610437685886067},{511.8464309677153,21.679200540496822,29.24375116866023}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{6.58483557593178,19.634597067699172},{3.6002618868000034,1186.4127211494274},{22.296128743480924,368.123265462073}},{{1.684564603759332,65.99480888153242},{2.928125434763049,79.95846777746785},{21.36159997247392,774.4580745959321}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{59.99718628185383,134.4135649295735,652.1776458871592},{2.940780692786641,4.944362161134339,26.34283420126624}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{26.028397253191304,13.683813084822413,3.4827694878982736},{151.81035483383786,292.66157285873425,76.30824015689545}},{{13.42723455011059,11.425395784473151,3.573084745770169},{503.0046288244265,151.61079548358884,82.27232159166297}}}),"values")
  check(r:raw_hex()=="54694c3ad14a9948","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{3.416230703556599,25.02841852630825},{12.972586456747843,300.49272297521657},{4.649332256382006,151.9217172145202}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{75.25087061175948,96.72499339838252,2953.7933873511834},{0.8135005187486862,12.137341153094368,18.037096287673556}},{{41.85118904699442,330.2233055472074,103.1886121468339},{1.2988676448071144,6.782731464263938,74.14001332967126}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{6.032263997747544,7.752961779866513,4.738252855664874},{452.35369965120015,283.6689583018355,485.32774076737184}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.6369813429308794,53.275976329721736},{4.787013275275445,188.29777899000035},{2.933960745491464,216.08371792839927}},{{5.078058704590261,62.35948175176182},{6.702443164897747,237.92048357591392},{27.64484325415882,1064.935742686541}}}),"values")
  check(r:raw_hex()=="1c1c83485525d84a","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{132.2599580934975,53.37236841824191,196.56763865411745},{21.7299069735734,8.202287382438294,18.32777818536155}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{22.0717313612273,6.692057346716997,4.39433841197601},{436.4505528443293,99.31016874907576,71.60724751941147}},{{53.41010892958837,15.033946172237293,1.6035157672828904},{156.1682414132184,92.99485351717148,56.31688968213563}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{3.522560514455717,101.11046253103409},{9.46714901166549,55.847908500310645},{39.60743685530936,563.8458673299731}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{68.61682793441345,68.0342952751314,708.2792216834541},{5.503716202706503,1.7103937522981734,7.563736921522614}},{{60.09221520037069,117.075386426895,398.3771349508408},{1.4336405586678531,14.28983551169108,35.99370102329688}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{27.683248228318593,4.815653859206459,19.902503290221404},{120.73418191907737,243.7850138798021,49.029911076949126}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.8163781566931854,57.287069524298914},{12.879906636198006,166.41162623951797},{38.390418817213764,3586.1139028973826}},{{0.8966250394848889,110.9527828390615},{2.117843612298755,192.06011770970807},{13.676338434029683,1088.786679897361}}}),"values")
  check(r:raw_hex()=="acc5059184ba59cd","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{12.794112282819844,144.81911835049675,261.36206901414204},{3.448794123531524,1.079343839470348,10.758174837683438}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{48.65571947279424,2.6572537553938327,1.3244623309868275},{3225.004140953137,164.74734607456077,49.820066397296394}},{{12.447342359450586,8.931426152128314,1.0771971486205172},{217.34964999091895,157.8420605595252,104.81150288032218}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{2.987084015294124,49.447987152152876},{11.945050253373964,160.56118547933892},{13.44016981593197,529.109969010944}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{70.75251927726329,274.8467329651991,516.8888221250454},{1.0228901247827575,14.570761736564396,28.072232745694926}},{{36.499007684023084,229.4852088910682,530.2927948609776},{3.389218529313643,7.548257040047673,30.26629569101816}}}),"values")
  check(r:raw_hex()=="54694c3ad14a9948","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{25.242720315469032,3.3872281102224115,4.7723478562566175},{816.823908447709,34.354176864974455,20.56036862901968}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{3.746520239888954,35.58313651870841},{54.1006130346552,44.41562337468144},{32.992713902264576,362.2847634731584}},{{2.0836480103591097,121.48236510649312},{1.8899653575110595,70.91577054437553},{18.437375686626073,1489.141975218738}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{16.397393609544864,155.7224000935717,703.2190749360292},{3.047935253090013,14.123045820814223,178.5420980584994}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.706690876888451,7.2101193462899635,1.7610437685886067},{511.8464309677153,21.679200540496822,29.24375116866023}},{{37.52206064188055,8.439438125363067,2.4656910459859365},{646.7349271225955,204.26929765112405,144.12338036527552}}}),"values")
  check(r:raw_hex()=="1c1c83485525d84a","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{6.58483557593178,19.634597067699172},{3.6002618868000034,1186.4127211494274},{22.296128743480924,368.123265462073}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{59.99718628185383,134.4135649295735,652.1776458871592},{2.940780692786641,4.944362161134339,26.34283420126624}},{{145.18372855931824,301.96488094368806,237.98284069324575},{1.0522533335826496,4.629941129918912,20.717825904777833}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{26.028397253191304,13.683813084822413,3.4827694878982736},{151.81035483383786,292.66157285873425,76.30824015689545}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{3.416230703556599,25.02841852630825},{12.972586456747843,300.49272297521657},{4.649332256382006,151.9217172145202}},{{2.991815226557247,43.069627733656795},{7.296531745288123,78.27412231574817},{38.84380020309863,722.9528109056072}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{75.25087061175948,96.72499339838252,2953.7933873511834},{0.8135005187486862,12.137341153094368,18.037096287673556}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{6.032263997747544,7.752961779866513,4.738252855664874},{452.35369965120015,283.6689583018355,485.32774076737184}},{{6.625212716459754,15.015826291414767,0.7791111245809748},{522.0735279420047,101.05523191700674,147.3512537081605}}}),"values")
  check(r:raw_hex()=="acc5059184ba59cd","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.6369813429308794,53.275976329721736},{4.787013275275445,188.29777899000035},{2.933960745491464,216.08371792839927}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{132.2599580934975,53.37236841824191,196.56763865411745},{21.7299069735734,8.202287382438294,18.32777818536155}},{{33.83538454830307,179.3924897552972,159.87023180305866},{1.4644904219085881,7.858493460401602,38.55799710795194}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{22.0717313612273,6.692057346716997,4.39433841197601},{436.4505528443293,99.31016874907576,71.60724751941147}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{3.522560514455717,101.11046253103409},{9.46714901166549,55.847908500310645},{39.60743685530936,563.8458673299731}},{{1.8171785909236486,84.42289040395788},{9.712651335971257,185.0450617585788},{20.51828994849965,607.9147996300611}}}),"values")
  check(r:raw_hex()=="54694c3ad14a9948","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{68.61682793441345,68.0342952751314,708.2792216834541},{5.503716202706503,1.7103937522981734,7.563736921522614}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{27.683248228318593,4.815653859206459,19.902503290221404},{120.73418191907737,243.7850138798021,49.029911076949126}},{{15.396192038968694,16.44085028994084,0.6952793995545538},{192.76905042194724,136.23480326554008,201.5334509957568}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.8163781566931854,57.287069524298914},{12.879906636198006,166.41162623951797},{38.390418817213764,3586.1139028973826}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{12.794112282819844,144.81911835049675,261.36206901414204},{3.448794123531524,1.079343839470348,10.758174837683438}},{{101.99553560916229,169.5106460779376,365.94099750570945},{4.357665661409451,10.169969487612063,53.020028628516776}}}),"values")
  check(r:raw_hex()=="1c1c83485525d84a","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{48.65571947279424,2.6572537553938327,1.3244623309868275},{3225.004140953137,164.74734607456077,49.820066397296394}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{2.987084015294124,49.447987152152876},{11.945050253373964,160.56118547933892},{13.44016981593197,529.109969010944}},{{7.22827221968418,111.08667165496507},{4.358807771852644,57.45108537982168},{12.585484840293717,416.1286571785889}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{70.75251927726329,274.8467329651991,516.8888221250454},{1.0228901247827575,14.570761736564396,28.072232745694926}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{25.242720315469032,3.3872281102224115,4.7723478562566175},{816.823908447709,34.354176864974455,20.56036862901968}},{{22.106690546666414,5.8288402682299125,2.6842440209462834},{212.77112432947888,287.01901879634954,97.84102343061564}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{3.746520239888954,35.58313651870841},{54.1006130346552,44.41562337468144},{32.992713902264576,362.2847634731584}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{16.397393609544864,155.7224000935717,703.2190749360292},{3.047935253090013,14.123045820814223,178.5420980584994}},{{18.00919533682834,301.60093340838347,115.63034329102365},{3.5177037608987916,5.031243740382358,54.207496870069534}}}),"values")
  check(r:raw_hex()=="acc5059184ba59cd","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.706690876888451,7.2101193462899635,1.7610437685886067},{511.8464309677153,21.679200540496822,29.24375116866023}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{6.58483557593178,19.634597067699172},{3.6002618868000034,1186.4127211494274},{22.296128743480924,368.123265462073}},{{1.684564603759332,65.99480888153242},{2.928125434763049,79.95846777746785},{21.36159997247392,774.4580745959321}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{59.99718628185383,134.4135649295735,652.1776458871592},{2.940780692786641,4.944362161134339,26.34283420126624}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{26.028397253191304,13.683813084822413,3.4827694878982736},{151.81035483383786,292.66157285873425,76.30824015689545}},{{13.42723455011059,11.425395784473151,3.573084745770169},{503.0046288244265,151.61079548358884,82.27232159166297}}}),"values")
  check(r:raw_hex()=="54694c3ad14a9948","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{3.416230703556599,25.02841852630825},{12.972586456747843,300.49272297521657},{4.649332256382006,151.9217172145202}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{75.25087061175948,96.72499339838252,2953.7933873511834},{0.8135005187486862,12.137341153094368,18.037096287673556}},{{41.85118904699442,330.2233055472074,103.1886121468339},{1.2988676448071144,6.782731464263938,74.14001332967126}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{6.032263997747544,7.752961779866513,4.738252855664874},{452.35369965120015,283.6689583018355,485.32774076737184}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.6369813429308794,53.275976329721736},{4.787013275275445,188.29777899000035},{2.933960745491464,216.08371792839927}},{{5.078058704590261,62.35948175176182},{6.702443164897747,237.92048357591392},{27.64484325415882,1064.935742686541}}}),"values")
  check(r:raw_hex()=="1c1c83485525d84a","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{132.2599580934975,53.37236841824191,196.56763865411745},{21.7299069735734,8.202287382438294,18.32777818536155}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{22.0717313612273,6.692057346716997,4.39433841197601},{436.4505528443293,99.31016874907576,71.60724751941147}},{{53.41010892958837,15.033946172237293,1.6035157672828904},{156.1682414132184,92.99485351717148,56.31688968213563}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{3.522560514455717,101.11046253103409},{9.46714901166549,55.847908500310645},{39.60743685530936,563.8458673299731}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{68.61682793441345,68.0342952751314,708.2792216834541},{5.503716202706503,1.7103937522981734,7.563736921522614}},{{60.09221520037069,117.075386426895,398.3771349508408},{1.4336405586678531,14.28983551169108,35.99370102329688}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{27.683248228318593,4.815653859206459,19.902503290221404},{120.73418191907737,243.7850138798021,49.029911076949126}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.8163781566931854,57.287069524298914},{12.879906636198006,166.41162623951797},{38.390418817213764,3586.1139028973826}},{{0.8966250394848889,110.9527828390615},{2.117843612298755,192.06011770970807},{13.676338434029683,1088.786679897361}}}),"values")
  check(r:raw_hex()=="acc5059184ba59cd","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{12.794112282819844,144.81911835049675,261.36206901414204},{3.448794123531524,1.079343839470348,10.758174837683438}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{48.65571947279424,2.6572537553938327,1.3244623309868275},{3225.004140953137,164.74734607456077,49.820066397296394}},{{12.447342359450586,8.931426152128314,1.0771971486205172},{217.34964999091895,157.8420605595252,104.81150288032218}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{2.987084015294124,49.447987152152876},{11.945050253373964,160.56118547933892},{13.44016981593197,529.109969010944}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{70.75251927726329,274.8467329651991,516.8888221250454},{1.0228901247827575,14.570761736564396,28.072232745694926}},{{36.499007684023084,229.4852088910682,530.2927948609776},{3.389218529313643,7.548257040047673,30.26629569101816}}}),"values")
  check(r:raw_hex()=="54694c3ad14a9948","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{25.242720315469032,3.3872281102224115,4.7723478562566175},{816.823908447709,34.354176864974455,20.56036862901968}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{3.746520239888954,35.58313651870841},{54.1006130346552,44.41562337468144},{32.992713902264576,362.2847634731584}},{{2.0836480103591097,121.48236510649312},{1.8899653575110595,70.91577054437553},{18.437375686626073,1489.141975218738}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{16.397393609544864,155.7224000935717,703.2190749360292},{3.047935253090013,14.123045820814223,178.5420980584994}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.706690876888451,7.2101193462899635,1.7610437685886067},{511.8464309677153,21.679200540496822,29.24375116866023}},{{37.52206064188055,8.439438125363067,2.4656910459859365},{646.7349271225955,204.26929765112405,144.12338036527552}}}),"values")
  check(r:raw_hex()=="1c1c83485525d84a","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{6.58483557593178,19.634597067699172},{3.6002618868000034,1186.4127211494274},{22.296128743480924,368.123265462073}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{59.99718628185383,134.4135649295735,652.1776458871592},{2.940780692786641,4.944362161134339,26.34283420126624}},{{145.18372855931824,301.96488094368806,237.98284069324575},{1.0522533335826496,4.629941129918912,20.717825904777833}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{26.028397253191304,13.683813084822413,3.4827694878982736},{151.81035483383786,292.66157285873425,76.30824015689545}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:lognormal(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{3.416230703556599,25.02841852630825},{12.972586456747843,300.49272297521657},{4.649332256382006,151.9217172145202}},{{2.991815226557247,43.069627733656795},{7.296531745288123,78.27412231574817},{38.84380020309863,722.9528109056072}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:lognormal(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{75.25087061175948,96.72499339838252,2953.7933873511834},{0.8135005187486862,12.137341153094368,18.037096287673556}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:lognormal(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{6.032263997747544,7.752961779866513,4.738252855664874},{452.35369965120015,283.6689583018355,485.32774076737184}},{{6.625212716459754,15.015826291414767,0.7791111245809748},{522.0735279420047,101.05523191700674,147.3512537081605}}}),"values")
  check(r:raw_hex()=="acc5059184ba59cd","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(1.782, 1.726, nil);cases=cases+1
  check(same(x,1.82329840968318),"scalar")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(np.array({0.5156509001483465},"float64"), {1.2888308245320161}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.5388261657226152}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace({0.3032818839160499}, {0.8128134345055067}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.9928043776488493}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace({{{1.2577522887035615,1.3827522887035615,1.5077522887035615}}}, {{{0.9360968197584958}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{4.127960614644236,1.1263348822075927,3.2620030100891677}},{{0.6516874121809292,0.9623392402975234,0.15682359041803395}}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(np.array({0.30024962575128494},"float64"), np.array({0.7276538911455834},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{2.6739067890760575,0.515402651661015,-0.09559714373712908}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.array({{{0.8738105167059704}}},"float64"), {{{0.6252993276987358}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1,1}),"shape");check(same(x:tolist(),{{{0.6216590257276116}}}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(np.array({{0.5203599815608506,0.6453599815608506,0.7703599815608506}},"float64"), np.array({{0.44785335739375104,0.5728533573937511,0.6978533573937511}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.6637177181735796,0.2919229790325931,-0.9754471998491012},{-1.0066292882317125,1.2095894075582119,1.9887382937576366}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(np.array({{0.5347405753140679,0.6597405753140679,0.7847405753140679}},"float64"), np.array({{1.1113417464075537,1.2363417464075537,1.361341746407554},{1.486341746407554,1.611341746407554,1.736341746407554}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.5613319117805567,3.518041890183116,-0.9083424450360766},{3.917553906817707,-0.10104681585375974,0.4957013666910431}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace({1.1146953176996475}, np.array({0.6318875705462295,0.7568875705462295,0.8818875705462296},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.616337364507054,1.0160080577703394,2.2285198787679272}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace({1.2928324128172421,1.4178324128172421,1.5428324128172421}, 1.657, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{2.698491723567116,1.5967358181293632,0.3532751163847081}}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(1.355, 1.394, nil);cases=cases+1
  check(same(x,5.629205746573884),"scalar")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(1.811, 0.564, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),3.650806886770741),"values")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace({0.8856440400585446,1.0106440400585446,1.1356440400585446}, np.array({0.5784515849185081},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.6523838666743993,0.1350299509921602,0.6770511710252782}}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace({{{1.1554591503516878,1.2804591503516878,1.405459150351688}}}, 1.801, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.7319587553608509,0.16928465283387784,-3.100070127979585}},{{-4.985184052370853,3.054346277145251,4.5498150770199866}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(0.671, 0.287, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.6778671167897292),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(np.array({0.4717692877349355,0.5967692877349355,0.7217692877349355},"float64"), np.array({0.5803893094600063},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.9325279649328029,0.5210948641193706,1.4548013537811888}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace({{0.3241470720254394}}, np.array({{0.5651773753601772}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8035959796296697,0.3851682893201302,-0.08159274127467397},{0.09688296485385756,0.0695976057445517,0.18394547782649806}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace({{{0.3937032532881704,0.5187032532881704,0.6437032532881705}}}, np.array({{{1.0819586964504937}},{{1.2069586964504937}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{3.71114520301865,0.22233108640999433,2.671299954500532}},{{-0.38772795969352164,-0.023357326520059285,-1.0981199281012506}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(np.array({{0.8004746460516627,0.9254746460516627,1.0504746460516627}},"float64"), np.array({{0.8734911811230588}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{3.6498631044979617,1.18374890667331,0.575291778988559},{2.0853181801284926,1.4775981567806635,0.12355059456530715}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(1.754, 0.655, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.4898717349038997}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(np.array({{0.3725967849789866,0.4975967849789866,0.6225967849789866},{0.7475967849789866,0.8725967849789866,0.9975967849789866}},"float64"), np.array({{1.2076280884055164,1.3326280884055164,1.4576280884055164},{1.5826280884055164,1.7076280884055164,1.8326280884055164}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.7591582041704084,-0.32460329637144053,-3.023925163510241},{-4.648491173657939,2.5545176530376463,4.19717201604877}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(np.array({{0.41178937541280664}},"float64"), {{1.0553735698206095}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.4370415480983521,2.8517099483948103,-0.9007650040476578},{2.813748272372172,-0.08650026840817515,0.23610717341902604}}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(1.753, np.array({{{1.1327229571313495,1.2577229571313495,1.3827229571313495}},{{1.5077229571313495,1.6327229571313495,1.7577229571313495}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{2.652244563696536,1.5890110045143113,3.4993799720546406}},{{2.5100135973284994,-0.9727140968920931,7.062978115332533}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(1.337, 1.988, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),3.023451846572571),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace({0.7327082149540856}, np.array({0.6977981200764425},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{2.8722582399032843}}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(0.7, 1.118, nil);cases=cases+1
  check(same(x,4.346993084059732),"scalar")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.array({{0.7755515870042982,0.9005515870042982,1.0255515870042982},{1.1505515870042982,1.2755515870042982,1.4005515870042982}},"float64"), 0.621, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.5251337967376137,-0.03946891512092077,0.5332265954325681},{1.9856890638390632,-0.20088026659618552,1.5965835539721227}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace({{0.8892762690832976,1.0142762690832976,1.1392762690832976},{1.2642762690832976,1.3892762690832976,1.5142762690832976}}, 1.852, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{1.4821009600755075,-0.12836402486616616,-3.4938387911440865},{-5.050255219779637,3.2133956243424198,4.747672813330765}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace({{0.4530731511585984,0.5780731511585984,0.7030731511585985},{0.8280731511585985,0.9530731511585985,1.0780731511585984}}, np.array({{0.7029195044474104},{0.8279195044474104}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.4698920721719048,2.203154363248338,-0.17113869226235534},{2.7123619722361147,0.5621748694689526,0.940253969615475}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace({{{0.9275818548099577}}}, np.array({{{0.5670816168078658,0.6920816168078658,0.817081616807866}},{{0.942081616807866,1.067081616807866,1.192081616807866}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.3777758390284507,0.8373443597472191,1.9595564551938667}},{{1.4005922247479954,-0.8538345163898864,4.528790606882355}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace({1.172887597533003,1.297887597533003,1.422887597533003}, 0.755, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.813366040270574,1.379403633145949,0.8808744660866764}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace({{0.5962182841946067,0.7212182841946067,0.8462182841946067}}, {{1.295422912037445,1.420422912037445,1.545422912037445},{1.670422912037445,1.795422912037445,1.920422912037445}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.5681724125116245,0.33213336098542523,3.7423495401334526},{-0.48527738436854007,-0.08512909750298792,-1.9252412165285844}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(np.array({{1.2322497599028184}},"float64"), {{0.7454361510153007,0.8704361510153007,0.9954361510153008}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.6639138809769753,1.4896207078645214,0.6907283176261477},{2.3287334330038023,1.7824422220019869,0.1759211671988059}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(0.469, 0.86, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.12220563666771556}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(np.array({0.9286373580049192,1.0536373580049192,1.1786373580049192},"float64"), {1.160115237980944,1.285115237980944,1.410115237980944}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.2999899268339727,0.2607515840926725,-2.34902254790525}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace({1.0513520376095615}, {1.2449992673905224,1.3699992673905224,1.4949992673905224}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.0811414291506696,4.218656481328569,-0.8079591028401265}),"values")
  check(r:raw_hex()=="f2dab0aed2ac6fd2","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(np.array({0.4106179762301266},"float64"), np.array({1.2122336628870787,1.3372336628870787,1.462233662887079},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.372984391087505,0.2362619275764021,2.2574200200957475}}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(0.758, np.array({{{0.9671254505278724}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.5784278178622033,0.8624188512151212,0.06370239212973305}},{{0.36910810230671254,0.32241768904559187,0.5180885388096677}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(np.array({{{0.6739038384499165}},{{0.7989038384499165}}},"float64"), {{{0.5906847190642723}},{{0.7156847190642723}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{2.485028673914689,0.5121023660783552,1.7808503344302}},{{0.33554218425614757,0.47748068211758893,-0.23393700183600208}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(np.array({{0.7514735957192735,0.8764735957192735,1.0014735957192735}},"float64"), {{0.9563887151900659}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{3.871279525925841,1.1592590360542483,0.48119412234610304},{2.158253519010664,1.4809956635590698,-0.013418966264033605}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(1.795, {{{0.3206950235497133}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1,1}),"shape");check(same(x:tolist(),{{{1.6656799691677269}}}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(np.array({1.227234727889811},"float64"), 1.174, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.6030318052250454,0.5029044335611553,-1.7097399377186921}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(1.441, 1.149, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.468492394395118}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(0.942, 1.411, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),2.0621627647674483),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace({0.8976717363384374}, {1.2228719011201636}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.9350533136854244}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(np.array({{{0.44623844762607984}}},"float64"), np.array({{{1.0816725858273837}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1,1}),"shape");check(same(x:tolist(),{{{3.76280314077876}}}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace({{0.5264071817037159,0.6514071817037159,0.7764071817037159}}, np.array({{0.764792768025705}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.0212139220692302,0.8775414472342046,0.36035670738486525},{1.651363064650532,1.1348237028866741,-0.035169198694770754}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.array({0.9376375825404006},"float64"), {1.1362244404971338}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.4794559180697208}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(0.799, 1.522, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.2861917816901423}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(np.array({0.5719517898317787},"float64"), np.array({1.2798253517597844},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.6025744733195512}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(1.244, 1.241, nil);cases=cases+1
  check(same(x,2.229203395518358),"scalar")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(0.685, 0.813, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.3746807601929074}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(np.array({{0.9737384166428855,1.0987384166428855,1.2237384166428855}},"float64"), 1.811, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{6.526526513519,0.6026658808083944,4.617562633724358},{-0.19877223419519052,0.28539516561062506,-1.3898073416113434}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(0.362, 0.503, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),2.0028206809320617),"values")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(1.284, 1.865, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.5319401306805692}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(np.array({1.1055409184294318},"float64"), np.array({0.4306361603344964,0.5556361603344964,0.6806361603344965},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.243387434995506,0.7627265201715698,-0.5971943110420022}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace({0.719311072178684}, 0.972, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.7425683457661989,2.966480098158393,-0.48955268310034006}),"values")
  check(r:raw_hex()=="f2dab0aed2ac6fd2","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(1.656, 0.481, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.0378556271106607}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace({0.39847266641715934,0.5234726664171594,0.6484726664171594}, np.array({1.0229123987955755},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.2662254349437068,0.633914737316688,-0.08587429049206385}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(1.419, np.array({{{0.47994775052442135,0.6049477505244214,0.7299477505244214}},{{0.8549477505244214,0.9799477505244214,1.1049477505244214}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{2.890589263519864,1.2532915711485253,2.7869262026139845}},{{0.8654741339591726,0.9788929380158568,-0.17560602234989142}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(np.array({{{0.42106622487903816,0.5460662248790382,0.6710662248790382}},{{0.7960662248790382,0.9210662248790382,1.0460662248790382}}},"float64"), 0.349, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.5595282877921388,0.6492586999777148,0.48120876072948365}},{{1.3094204556753772,1.1416650235946426,0.6757173295956143}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.array({{1.028096305984211}},"float64"), np.array({{0.7435661236485536,0.8685661236485536,0.9935661236485536},{1.1185661236485536,1.2435661236485536,1.3685661236485536}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.7282538170933333,-0.28667014116726786,0.24040317643311482},{2.5323740679434654,-1.928490871170704,1.4601135509831755}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(np.array({0.5958258626663635},"float64"), {0.39848516378480997}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.7233808540733344}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(np.array({1.1805130629136704},"float64"), np.array({0.7935594497349083},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.1995007473071297}}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(1.998, 0.917, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),2.725986715302445),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(np.array({0.9255322442700176,1.0505322442700176,1.1755322442700176},"float64"), np.array({0.9616760299683689,1.0866760299683689,1.2116760299683689},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.7413372324715946,1.1678587634205293,0.30567221870497296}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace({0.32776963166933143,0.45276963166933143,0.5777696316693315}, np.array({0.4265791162155896,0.5515791162155896,0.6765791162155896},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.6357229386256311,0.30168003978947777,1.8456827124998383}}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace({{{0.9274420334965343}},{{1.0524420334965343}}}, np.array({{{0.6415415645721834}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{3.020194850251108,1.1171333284159644,0.5784407309285904}},{{1.996104143539036,1.4579529173668868,0.37165633229966444}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(1.739, 1.144, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.277682846916124),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(np.array({0.8913852794301724},"float64"), {0.306075712435181}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.9893600308581458,0.70254378805451,0.12568117961739544}}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace({{{1.1399464363561522}},{{1.2649464363561522}}}, np.array({{{0.7534984253373131,0.8784984253373131,1.0034984253373134}},{{1.1284984253373134,1.2534984253373134,1.3784984253373134}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.1579755711563904,3.170948957744998,-0.10809150075274898}},{{3.833332560905716,0.6731130782423417,1.0354754265322248}}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(np.array({0.45639743326205956},"float64"), np.array({1.1456486385793985},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.3659034194017918}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(np.array({{{1.156139736271375,1.281139736271375,1.406139736271375}}},"float64"), np.array({{{0.80887866379983}},{{0.93387866379983}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{1.8423243017735769,1.3684729574168837,0.825447209746519}},{{0.7806167412119861,0.860531400189518,1.1744756903253157}}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(1.993, 1.756, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),7.377150137004119),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(np.array({0.7131479084836783,0.8381479084836783,0.9631479084836783},"float64"), {0.7799368063884575}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{3.2573555461423,1.0687599700074097,0.5388590137621463}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(0.567, np.array({{1.212272897708427},{1.337272897708427}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1}),"shape");check(same(x:tolist(),{{0.0781518514583982},{-1.4572575535947216}}),"values")
  check(r:raw_hex()=="39ee1852018c694c","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(np.array({0.8784343129607093},"float64"), {0.8834640593974294}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.1612309155606035}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(0.541, 1.578, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.5787571787254101),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(1.332, 0.57, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.784510826305773}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace({0.8639370085305644,0.9889370085305644,1.1139370085305647}, np.array({0.9453750431165695},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.6659136117335636,1.0910075061229891,0.4352539787149118}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(np.array({0.48685768010860325,0.6118576801086033,0.7368576801086033},"float64"), {0.9275221771424442,1.0525221771424442,1.1775221771424444}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{3.330774910823779,0.32354882012125286,2.943540883276205}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace({{1.2654134208504284,1.3904134208504284,1.5154134208504284}}, np.array({{0.7781769021111147,0.9031769021111147,1.0281769021111147}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{3.803880129414169,1.6574651686464201,0.9560808726213137},{2.410056415139051,1.9613009269633022,0.42434127227511453}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.array({0.32622907412023655},"float64"), np.array({1.2948398065087672,1.4198398065087672,1.5448398065087674},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{-0.19591411926988705,-1.823011711470335,-0.8985104503871744}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(np.array({{1.035544082399316,1.160544082399316,1.285544082399316},{1.410544082399316,1.535544082399316,1.660544082399316}},"float64"), np.array({{0.5557467542261401,0.6807467542261401,0.8057467542261402}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.2134384656844321,0.7405394002426746,-0.7301780675652965},{-0.4843157336883359,2.2060426409380454,3.0672928786484603}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace({{{1.1981796953783197,1.3231796953783197,1.4481796953783197}}}, np.array({{{1.2194804094961353}},{{1.3444804094961353}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{1.2273584911790052,4.1424992468276685,-0.06847222572528144}},{{4.25812621452958,0.6883896233794612,1.2243714765331861}}}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(0.767, 1.531, nil);cases=cases+1
  check(same(x,1.9824282018844532),"scalar")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(np.array({{1.01902838579623}},"float64"), np.array({{0.3216327505489775,0.4466327505489775,0.5716327505489776},{0.6966327505489776,0.8216327505489776,0.9466327505489776}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.2918745357366415,1.0672505463255788,0.6086542703494375},{0.7389046105316902,0.6489743333001353,0.7842004777199101}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace({0.8091616364121024}, np.array({1.2091683254795231},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{4.5166467191522015,0.47794396801266986,3.075149900100814}}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(0.461, {{{0.9232698589893726,1.0482698589893726,1.1732698589893729}},{{1.2982698589893729,1.4232698589893729,1.5482698589893729}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{3.472769937795211,0.7709528977663442,-0.1772637254751513}},{{2.370662821855476,1.360632152267001,-1.1819800340324842}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace({0.3706641986822568}, {0.42018955656953744,0.5451895565695375,0.6701895565695375}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.2012230710666665,-0.4546004723643166,-0.16065797167130053}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace({0.5556760851638094}, {0.6521841829431014}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.7644400628761479}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(1.972, 0.95, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.9947308743910896}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(0.993, 0.883, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.6939948414526271),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace({{{0.35280636306623986}}}, np.array({{{1.2665601502357582,1.3915601502357582,1.5165601502357582}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{1.4272493732072495,0.503050689906206,-0.7359294197893824}},{{-0.15649155696991984,-0.2739365126805567,-0.02340146129356896}}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(np.array({{0.6745228405613726,0.7995228405613726,0.9245228405613726},{1.0495228405613726,1.1745228405613726,1.2995228405613726}},"float64"), {{1.0028305511502695,1.1278305511502695,1.2528305511502695}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.749346444984857,0.49058536872220865,3.272334361485344},{0.4002519945042168,0.6679997223470896,-0.508500336009635}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(1.887, 1.165, nil);cases=cases+1
  check(same(x,5.687310324623961),"scalar")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.array({1.043743016677997},"float64"), {0.48507831658137884,0.6100783165813788,0.7350783165813789}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.8481355446255139,0.12025489189774596,0.46097743533260427}}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(1.156, {{0.7144982961904058,0.8394982961904058,0.964498296190406},{1.0894982961904058,1.2144982961904058,1.3394982961904058}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.3847107082362513,0.638049362889266,-1.256868024645476},{-2.5587253230868434,2.352214821279776,3.4946226576282013}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(np.array({{{0.5261007429687721}}},"float64"), {{{1.0949098118443368}},{{1.2199098118443368}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.552298908655725,3.057425244427481,-0.8356243463707287}},{{3.302533003391587,-0.049873910007386724,0.3230291026442368}}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(1.095, 1.855, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.567644882100366}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace({{{0.964870334473108}}}, {{{0.9413593155313791}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1,1}),"shape");check(same(x:tolist(),{{{1.7634403324440262}}}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace({{{0.33767791233831007}},{{0.46267791233831007}}}, {{{0.7551296304220372,0.8801296304220372,1.0051296304220374}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{2.653014645306807,0.09659114390841864,2.2212965103683824}},{{-0.026221885802638956,0.0674004441233561,-0.9878755289014232}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace({{{1.1563853515903921}},{{1.2813853515903921}}}, 0.788, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{3.72689568275235,1.3893815417845388,0.7277100457168992}},{{2.440477425709347,1.7794708913837913,0.445182115248449}}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.array({0.9755727867730286},"float64"), {0.466026805971037}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.7876478222701172}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(0.594, np.array({{1.1848464745134293,1.3098464745134293,1.4348464745134293},{1.5598464745134293,1.6848464745134293,1.8098464745134293}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9732690308459141,-0.21414436321095764,-2.995529595130851},{-4.724412354809332,2.2534822164147092,3.753800937532497}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(1.866, 1.627, nil);cases=cases+1
  check(same(x,1.9049296132992664),"scalar")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(1.113, 1.794, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),2.5372182848992217),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(np.array({0.8550717604056299,0.9800717604056299,1.10507176040563},"float64"), np.array({0.7906431945287054},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.5257868888729194,1.0654361296802461,0.5374704442159203}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(np.array({{{1.1652624056360288,1.2902624056360288,1.4152624056360288}},{{1.5402624056360288,1.6652624056360288,1.7902624056360288}}},"float64"), {{{1.0650937192931424,1.1900937192931424,1.3150937192931424}},{{1.4400937192931424,1.5650937192931424,1.6900937192931424}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{4.430993894619172,0.9642696893409155,3.8797554549285804}},{{0.607890664014699,0.9623588088276044,-0.6487973796266469}}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace({{0.6072189594995006}}, 0.412, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.9511913661476308,0.7290393025959325,0.3830892310478774},{1.213241719064233,0.8676393178686381,0.17001625217351002}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.array({0.6478488207770692},"float64"), np.array({0.6597775341993488},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.38179401855194395}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace({0.995925172060705}, 1.511, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.4795958567741114,0.06367383072288668,-2.7841163268613123}}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(np.array({1.0642441212590923},"float64"), np.array({1.1966219433248753},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.092875977140502}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(np.array({1.176917653297954},"float64"), np.array({0.9572255485416048},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.9368385724761263}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace({{{1.2529238322763512}},{{1.3779238322763512}}}, {{{0.4201654366819589}},{{0.5451654366819589}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{1.609356818472659,1.2982883630046897,0.9512878268968785}},{{1.1587067481717832,1.1323875157283947,1.2426865304005228}}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace({0.35039817271117274,0.47539817271117274,0.6003981727111728}, {0.6982049675805813}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{2.4911956509890443,0.28414455106570746,1.9088382210057948}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace({{0.8911428691104615,1.0161428691104615,1.1411428691104617}}, np.array({{1.2081923638341534},{1.3331923638341534}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.832349662596093,1.3733817241802813,0.4838811544903804},{2.8521742170750315,1.8588380952383448,-0.2736030310221327}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.array({{1.111264804514099,1.236264804514099,1.361264804514099}},"float64"), np.array({{0.9226531876271062}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.7392055896540465,-0.16037434640484838,0.6297910157505804},{2.3520735889077455,-0.9573496174483542,1.652520068925814}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace({{{0.7910779103550043}},{{0.9160779103550043}}}, {{{0.4519855583010572,0.5769855583010572,0.7019855583010572}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.9357583633424588,0.4350914373843156,-0.9650667236767216}},{{-0.625000405197544,1.4843773296865104,2.1416706092331186}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(0.273, 1.915, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.3188206573251966),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(np.array({0.3962335471248423},"float64"), 1.268, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.4028716659945266}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(1.747, {0.3741849644636775,0.4991849644636775,0.6241849644636775}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{2.0644270242854432,1.8008961315770442,1.2988987454428187}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(np.array({{0.5337455150931947,0.6587455150931947,0.7837455150931948},{0.9087455150931948,1.033745515093195,1.158745515093195}},"float64"), np.array({{0.995209464216019,1.120209464216019,1.245209464216019},{1.370209464216019,1.495209464216019,1.620209464216019}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.585201764014877,0.3518956257616447,3.1172750761066514},{0.021619512513174954,0.36222783060967123,-1.1794607646887671}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(np.array({{0.5290339012220742,0.6540339012220742,0.7790339012220742}},"float64"), {{0.33320371393476117,0.45820371393476117,0.5832037139347612}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{1.6159673898652684,0.7895157789880741,0.46176863414397673},{1.01915291630936,0.9436590842049876,0.16015467147729223}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace({0.6710326605045529}, {0.3054267806232986}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.5478695373291039}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(np.array({{{1.0346354459402984,1.1596354459402984,1.2846354459402984}}},"float64"), np.array({{{0.3498645205759208,0.4748645205759208,0.5998645205759209}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1,3}),"shape");check(same(x:tolist(),{{{1.1466269828191094,0.8666552432529111,-0.21603482640115845}}}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(np.array({0.8547415006603039},"float64"), np.array({1.0025430661907957},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{0.8787295854068732}}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace({1.1642898674914033,1.2892898674914033,1.4142898674914033}, {0.5411047552214592,0.6661047552214592,0.7911047552214592}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.5938613760935882,1.2024393817960868,2.4134556752119916}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace({1.1956016802676563,1.3206016802676563,1.4456016802676563}, {0.8394684415155291}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.9077360380811685,1.411237626459079,0.842948807769379}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace({{1.0561251160619378,1.1811251160619378,1.3061251160619378},{1.4311251160619378,1.5561251160619378,1.6811251160619378}}, 1.772, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{6.489333568665182,0.6957355337876594,4.626863113117912},{0.28386455654505727,0.7602972635886271,-0.8761377683259661}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace({1.0650625022204367}, {1.1645170596744503,1.2895170596744503,1.4145170596744503}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{4.8637974422046,1.4463474794977274,0.2955592874752353}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.array({{0.7858741471676165}},"float64"), np.array({{0.504863392890132}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.5822883577407441,0.021652021420074496,0.38562154547758537},{1.464827995934933,-0.41444210883851396,0.9452451036222095}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(1.868, {0.7902725992853239}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{2.120966041830957}}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace({0.4499424048823834}, np.array({0.8673794937059367},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.4706963989043167}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace({{{1.181197402053151,1.306197402053151,1.431197402053151}},{{1.556197402053151,1.681197402053151,1.806197402053151}}}, {{{1.1512480675452446,1.2762480675452446,1.4012480675452448}},{{1.5262480675452448,1.6512480675452448,1.7762480675452448}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{2.095148655259858,1.139792998443749,3.2009746003128488}},{{2.322512284083193,-1.0754430405371453,7.172138791053362}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(0.464, 0.45, nil);cases=cases+1
  check(same(x,0.8457421181879563),"scalar")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(np.array({1.1889361848048452},"float64"), {0.517772387779946}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.7765012603187094}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace({{0.9911717641397748,1.1161717641397748,1.2411717641397748}}, np.array({{0.7902915331418023,0.9152915331418023,1.0402915331418023},{1.1652915331418023,1.2902915331418023,1.4152915331418023}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.56915723440732,1.386805571422769,0.6752488058058066},{2.705232906401943,1.9317498793374743,-0.2606954444649532}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.array({0.423804470551365},"float64"), {1.0053743006194593}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{0.018388028116520627}}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace({1.0541263556678424}, 0.867, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.3316528173796383,0.5192078163297296,-1.1148319365660355}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(np.array({{{1.04045514489554,1.16545514489554,1.29045514489554}},{{1.41545514489554,1.54045514489554,1.66545514489554}}},"float64"), np.array({{{0.3399555583851191,0.4649555583851191,0.5899555583851191}},{{0.7149555583851191,0.8399555583851191,0.9649555583851191}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.0485893418389134,2.2403869651220214,0.556735091647424}},{{3.042645661601004,1.1438740972156007,1.5048243292573849}}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(np.array({0.8569483351899989},"float64"), np.array({1.0163172662794326},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.663780907037245}}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(np.array({{0.32092440074543044},{0.44592440074543044}},"float64"), {{0.5819824988275193,0.7069824988275193,0.8319824988275193},{0.9569824988275193,1.0819824988275193,1.2069824988275193}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8146293604137347,0.3972560703509319,-0.27635432706654767},{0.061111096716293445,-0.04138821934359438,0.14651243224970167}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace({1.071593600206962}, np.array({0.7010087473707987},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{3.220987873098517}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(np.array({0.9581186234458148},"float64"), {0.9814711759279802,1.1064711759279802,1.2314711759279802}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{4.159745269969354,1.2852805124697446,0.288193137385768}}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(1.85, {1.0811865630653232}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.4140123188585354}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(1.577, 0.851, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.8494048661092712),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace({1.1389042268664986}, np.array({0.7489384553574241},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.1568242541879579,2.8703767569532173,0.2074592128580136}}),"values")
  check(r:raw_hex()=="f2dab0aed2ac6fd2","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(np.array({{1.158809303307841}},"float64"), {{1.269520922710723}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.1666548502346767,0.9932820226909429,2.7622150340739986},{1.7962238866962643,-0.9605649972849666,4.993957663406865}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(1.199, 1.17, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),2.1915295072886862),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(np.array({{0.5651160550373544,0.6901160550373544,0.8151160550373545}},"float64"), 1.191, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{4.216894422447323,0.36387508862162893,3.047056774277572}}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace({0.944358380620266,1.069358380620266,1.1943583806202662}, np.array({0.8675417391229792},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{3.7743393490591366,1.3258735075873451,0.7224120349647268}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(1.782, {0.674345530822015}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.510070663921637}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(np.array({1.0306806909992525,1.1556806909992525,1.2806806909992527},"float64"), 0.699, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.254430398884541,0.7244141869654107,-0.46799502557684924}}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(np.array({{{0.3976817820155322,0.5226817820155323,0.6476817820155323}}},"float64"), np.array({{{0.36318496353699886,0.48818496353699886,0.6131849635369989}},{{0.7381849635369989,0.8631849635369989,0.9881849635369989}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.406371794422787,1.6513177172103652,-0.11492838022929075}},{{2.0777408544354583,0.11513308046373133,0.483184095759439}}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(np.array({0.7246350428599175,0.8496350428599175,0.9746350428599176},"float64"), {0.45666171325483035}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.0871690239250986,0.7900929193669675,1.5513990764063985}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace({{0.4335603632994956,0.5585603632994955,0.6835603632994957},{0.8085603632994957,0.9335603632994957,1.0585603632994958}}, np.array({{0.9763618175744142}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{1.2618235374299396,0.663976448984948,-0.017368015731147213},{0.41595441971220254,0.4938180976042006,0.8163576685230587}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace({0.7382043554571007}, {0.43222427056928997}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.063466522656501}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(np.array({{0.314274393249045,0.439274393249045,0.564274393249045},{0.689274393249045,0.814274393249045,0.939274393249045}},"float64"), np.array({{0.5344283895436226,0.6594283895436226,0.7844283895436226}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.0576166478025084,0.6342544725250929,0.13754205844769501},{1.4753806248533219,1.2310913289862622,0.10686124856011647}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.array({0.8500646615882004,0.9750646615882004,1.1000646615882004},"float64"), {0.7545089803466527}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.5458094738349346,-0.16705113642057157,0.5018945691728051}}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace({1.0224305444237707,1.1474305444237707,1.272430544423771}, {1.0342042621525183,1.1592042621525183,1.2842042621525183}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.3534790444957971,0.4322288711767811,-1.9402401399104772}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace({1.0463832237147859}, {0.6446848256444226,0.7696848256444226,0.8946848256444228}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.0618087498132753,2.8258193347793323,-0.06632465500916052}),"values")
  check(r:raw_hex()=="f2dab0aed2ac6fd2","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(1.102, np.array({0.7758149756598236},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.7179029398179297}}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(1.742, 1.797, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),3.2664235252972382),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(np.array({0.8802512315398368},"float64"), {0.9098547964201222}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{3.6699977160496626}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(np.array({{{0.747997519907861,0.872997519907861,0.997997519907861}},{{1.122997519907861,1.247997519907861,1.372997519907861}}},"float64"), {{{0.561673663658083,0.686673663658083,0.811673663658083}},{{0.936673663658083,1.061673663658083,1.186673663658083}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{2.5802157371346235,1.0760334939421126,0.556443641686938}},{{2.5007780016109673,1.919068966414932,0.11373310616085641}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.array({{{0.9426518341248273,1.0676518341248273,1.1926518341248276}},{{1.3176518341248276,1.4426518341248276,1.5676518341248276}}},"float64"), {{{0.883476516714081,1.008476516714081,1.1334765167140812}},{{1.2584765167140812,1.3834765167140812,1.5084765167140812}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.5863905828075202,-0.4588998593100553,0.2940386029847083}},{{3.0100848499451205,-1.8465732834032105,2.043834794988328}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace({1.2990600734448883,1.4240600734448883,1.5490600734448883}, np.array({1.146919468203952},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.6661886799950814,0.7164378281506516,-1.320167713274179}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(np.array({0.6721604776335175,0.7971604776335175,0.9221604776335176},"float64"), {0.9625066810384879}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.6951906023359075,3.0223818777654325,-0.2748965603513963}}),"values")
  check(r:raw_hex()=="f2dab0aed2ac6fd2","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace({{{0.8081250138903657,0.9331250138903657,1.0581250138903657}},{{1.1831250138903657,1.3081250138903657,1.4331250138903657}}}, np.array({{{1.204775776206774}},{{1.329775776206774}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.7645707717930081,0.7760395697506939,2.579757583547794}},{{1.8507929957468559,-0.9118404512126261,5.450299757674319}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace({{1.2490327204120408,1.3740327204120408,1.4990327204120408}}, {{1.0430791836629785,1.1680791836629785,1.2930791836629787}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{2.133893291543751,1.5001481963513947,0.5707335183653776}}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(np.array({0.4468056681574472},"float64"), np.array({0.7330305136117594},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{2.6943833106921584}}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(np.array({{0.6491840584011712,0.7741840584011712,0.8991840584011712},{1.0241840584011712,1.1491840584011712,1.2741840584011712}},"float64"), np.array({{1.0779511207648924,1.2029511207648924,1.3279511207648924},{1.4529511207648924,1.5779511207648924,1.7029511207648924}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.165534937098845,1.1298731803910174,0.17677307759033634},{3.161372038300713,2.1465884184948014,-0.5329393407304814}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.array({0.7437524064668437},"float64"), {0.4909589162157206}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.5457735869652864}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(0.738, 1.034, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.068983115813145}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.0179454271508603,5.733926717576936},{1.067234756729148,6.706949296660645},{2.645891044126432,5.875151647470448}},{{1.7990395068219145,3.849695368838692},{2.0783435050695793,2.826293878775091},{3.5304744641712387,6.059515092927229}}}),"values")
  check(r:raw_hex()=="54694c3ad14a9948","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.59540898198128,4.902210780270092,6.947250475799079},{1.3765679863869797,0.7479286894692625,5.265706077480446}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.6362368636465936,2.080976194317496,0.461576359490404},{5.698416660309406,4.662208524201803,3.813950097379261}},{{3.6921115269862224,0.7205519364532438,0.7814821726949222},{6.6553650138795595,5.5463366567827554,4.174848142964606}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{3.299608543709048,3.7945585853805257},{3.4055042312595827,4.514421320746242},{2.6631654123278876,4.917637041032208}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{6.446551711131304,5.221760333306611,5.591996853546802},{2.1031967710523047,2.4740661863515854,2.2041212852075414}},{{4.425152074717769,4.504531584413568,5.809751736878938},{2.5990289066115544,3.7418630036452005,2.4188073558146392}}}),"values")
  check(r:raw_hex()=="1c1c83485525d84a","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.6975630552334726,0.8647095384961125,0.40540459955105057},{7.008620141104789,3.2168697420284014,4.236753583294474}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.2400747938683354,3.5372676995345045},{0.12373850152778743,2.4428193214647944},{3.7387092421405734,7.309420846752484}},{{1.1799041023969448,4.460742464997839},{2.068469929809194,6.5310017463813965},{3.749157566896085,2.094601716713478}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.017945427150861,6.733926717576936,5.067234756729148},{2.706949296660645,1.6458910441264318,2.8751516474704477}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.5954089819812802,1.9022107802700927,1.9472504757990792},{6.37656798638698,3.7479286894692625,6.265706077480446}},{{3.554046933412177,2.636699465379106,-0.021267854784896123},{5.921622567410443,4.775787055148162,5.440700873037425}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.6362368636465936,4.080976194317496},{1.461576359490404,4.698416660309406},{2.662208524201803,5.81395009737926}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{6.2996085437090485,4.794558585380526,7.405504231259583},{0.5144213207462413,1.6631654123278876,1.917637041032208}},{{3.4550225730670716,4.661840673278923,7.974969630932967},{0.5200102188906948,1.9058379943518546,3.1860976171959563}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{5.446551711131304,2.221760333306612,0.5919968535468025},{7.103196771052305,5.474066186351585,3.2041212852075414}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.6975630552334728,2.8647095384961125},{1.4054045995510505,6.008620141104789},{1.2168697420284014,6.236753583294474}},{{1.8989843081589213,3.8192821211149854},{1.991339937151395,5.162505535211369},{3.013290993651657,8.10337727304183}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.240074793868335,4.537267699534505,4.123738501527788},{-1.5571806785352056,2.7387092421405734,4.309420846752484}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.01794542715086,3.733926717576936,0.06723475672914803},{7.706949296660645,4.645891044126432,3.8751516474704477}},{{3.7990395068219147,1.8496953688386921,1.078343505069579},{3.826293878775091,5.530474464171238,4.059515092927229}}}),"values")
  check(r:raw_hex()=="54694c3ad14a9948","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.5954089819812802,3.9022107802700927},{2.947250475799079,5.37656798638698},{1.7479286894692625,8.265706077480445}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.636236863646594,5.080976194317496,5.461576359490404},{0.6984166603094065,1.662208524201803,2.813950097379261}},{{4.692111526986222,3.720551936453244,5.781482172694922},{1.65536501387956,2.546336656782756,3.1748481429646063}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{5.2996085437090485,1.7945585853805255,2.4055042312595827},{5.514421320746242,4.663165412327888,2.917637041032208}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{3.446551711131305,4.221760333306611},{1.5919968535468025,6.103196771052305},{3.4740661863515854,5.204121285207542}},{{1.425152074717769,3.5045315844135687},{1.8097517368789373,6.599028906611554},{4.7418630036452,5.418807355814639}}}),"values")
  check(r:raw_hex()=="1c1c83485525d84a","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.6975630552334726,3.8647095384961125,5.4054045995510505},{2.008620141104789,0.21686974202840137,3.2367535832944743}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.2400747938683354,1.5372676995345045,-0.8762614984722126},{3.4428193214647944,5.738709242140573,5.309420846752484}},{{3.1799041023969448,2.4607424649978396,1.0684699298091942},{7.5310017463813965,5.749157566896085,0.09460171671347783}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.0179454271508603,5.733926717576936},{1.067234756729148,6.706949296660645},{2.645891044126432,5.875151647470448}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.59540898198128,4.902210780270092,6.947250475799079},{1.3765679863869797,0.7479286894692625,5.265706077480446}},{{4.554046933412177,5.636699465379106,4.978732145215104},{0.9216225674104431,1.7757870551481616,4.440700873037425}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.6362368636465936,2.080976194317496,0.461576359490404},{5.698416660309406,4.662208524201803,3.813950097379261}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{3.299608543709048,3.7945585853805257},{3.4055042312595827,4.514421320746242},{2.6631654123278876,4.917637041032208}},{{0.45502257306707183,3.661840673278923},{3.974969630932967,4.520010218890695},{2.9058379943518546,6.186097617195956}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{6.446551711131304,5.221760333306611,5.591996853546802},{2.1031967710523047,2.4740661863515854,2.2041212852075414}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{2.6975630552334726,0.8647095384961125,0.40540459955105057},{7.008620141104789,3.2168697420284014,4.236753583294474}},{{3.898984308158921,1.8192821211149857,0.9913399371513949},{6.162505535211369,5.0132909936516565,6.103377273041828}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.2400747938683354,3.5372676995345045},{0.12373850152778743,2.4428193214647944},{3.7387092421405734,7.309420846752484}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.017945427150861,6.733926717576936,5.067234756729148},{2.706949296660645,1.6458910441264318,2.8751516474704477}},{{4.799039506821915,4.849695368838692,6.078343505069579},{-1.173706121224909,2.5304744641712387,3.0595150929272283}}}),"values")
  check(r:raw_hex()=="54694c3ad14a9948","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.5954089819812802,1.9022107802700927,1.9472504757990792},{6.37656798638698,3.7479286894692625,6.265706077480446}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.6362368636465936,4.080976194317496},{1.461576359490404,4.698416660309406},{2.662208524201803,5.81395009737926}},{{1.6921115269862226,2.720551936453244},{1.7814821726949222,5.6553650138795595},{3.546336656782756,6.174848142964606}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{6.2996085437090485,4.794558585380526,7.405504231259583},{0.5144213207462413,1.6631654123278876,1.917637041032208}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{5.446551711131304,2.221760333306612,0.5919968535468025},{7.103196771052305,5.474066186351585,3.2041212852075414}},{{3.425152074717769,1.5045315844135687,0.8097517368789374},{7.599028906611554,6.7418630036452,3.4188073558146392}}}),"values")
  check(r:raw_hex()=="1c1c83485525d84a","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.6975630552334728,2.8647095384961125},{1.4054045995510505,6.008620141104789},{1.2168697420284014,6.236753583294474}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.240074793868335,4.537267699534505,4.123738501527788},{-1.5571806785352056,2.7387092421405734,4.309420846752484}},{{4.179904102396945,5.460742464997839,6.068469929809194},{2.5310017463813965,2.749157566896085,-0.9053982832865222}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.01794542715086,3.733926717576936,0.06723475672914803},{7.706949296660645,4.645891044126432,3.8751516474704477}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.5954089819812802,3.9022107802700927},{2.947250475799079,5.37656798638698},{1.7479286894692625,8.265706077480445}},{{1.554046933412177,4.636699465379106},{0.9787321452151039,4.921622567410443},{2.7757870551481614,7.440700873037425}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.636236863646594,5.080976194317496,5.461576359490404},{0.6984166603094065,1.662208524201803,2.813950097379261}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{5.2996085437090485,1.7945585853805255,2.4055042312595827},{5.514421320746242,4.663165412327888,2.917637041032208}},{{2.4550225730670716,1.661840673278923,2.974969630932967},{5.520010218890695,4.905837994351854,4.186097617195956}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{3.446551711131305,4.221760333306611},{1.5919968535468025,6.103196771052305},{3.4740661863515854,5.204121285207542}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.6975630552334726,3.8647095384961125,5.4054045995510505},{2.008620141104789,0.21686974202840137,3.2367535832944743}},{{4.898984308158921,4.819282121114986,5.991339937151395},{1.1625055352113693,2.013290993651657,5.103377273041828}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.2400747938683354,1.5372676995345045,-0.8762614984722126},{3.4428193214647944,5.738709242140573,5.309420846752484}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.0179454271508603,5.733926717576936},{1.067234756729148,6.706949296660645},{2.645891044126432,5.875151647470448}},{{1.7990395068219145,3.849695368838692},{2.0783435050695793,2.826293878775091},{3.5304744641712387,6.059515092927229}}}),"values")
  check(r:raw_hex()=="54694c3ad14a9948","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.59540898198128,4.902210780270092,6.947250475799079},{1.3765679863869797,0.7479286894692625,5.265706077480446}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.6362368636465936,2.080976194317496,0.461576359490404},{5.698416660309406,4.662208524201803,3.813950097379261}},{{3.6921115269862224,0.7205519364532438,0.7814821726949222},{6.6553650138795595,5.5463366567827554,4.174848142964606}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{3.299608543709048,3.7945585853805257},{3.4055042312595827,4.514421320746242},{2.6631654123278876,4.917637041032208}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{6.446551711131304,5.221760333306611,5.591996853546802},{2.1031967710523047,2.4740661863515854,2.2041212852075414}},{{4.425152074717769,4.504531584413568,5.809751736878938},{2.5990289066115544,3.7418630036452005,2.4188073558146392}}}),"values")
  check(r:raw_hex()=="1c1c83485525d84a","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.6975630552334726,0.8647095384961125,0.40540459955105057},{7.008620141104789,3.2168697420284014,4.236753583294474}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.2400747938683354,3.5372676995345045},{0.12373850152778743,2.4428193214647944},{3.7387092421405734,7.309420846752484}},{{1.1799041023969448,4.460742464997839},{2.068469929809194,6.5310017463813965},{3.749157566896085,2.094601716713478}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.017945427150861,6.733926717576936,5.067234756729148},{2.706949296660645,1.6458910441264318,2.8751516474704477}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.5954089819812802,1.9022107802700927,1.9472504757990792},{6.37656798638698,3.7479286894692625,6.265706077480446}},{{3.554046933412177,2.636699465379106,-0.021267854784896123},{5.921622567410443,4.775787055148162,5.440700873037425}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.6362368636465936,4.080976194317496},{1.461576359490404,4.698416660309406},{2.662208524201803,5.81395009737926}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{6.2996085437090485,4.794558585380526,7.405504231259583},{0.5144213207462413,1.6631654123278876,1.917637041032208}},{{3.4550225730670716,4.661840673278923,7.974969630932967},{0.5200102188906948,1.9058379943518546,3.1860976171959563}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{5.446551711131304,2.221760333306612,0.5919968535468025},{7.103196771052305,5.474066186351585,3.2041212852075414}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.6975630552334728,2.8647095384961125},{1.4054045995510505,6.008620141104789},{1.2168697420284014,6.236753583294474}},{{1.8989843081589213,3.8192821211149854},{1.991339937151395,5.162505535211369},{3.013290993651657,8.10337727304183}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.240074793868335,4.537267699534505,4.123738501527788},{-1.5571806785352056,2.7387092421405734,4.309420846752484}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.01794542715086,3.733926717576936,0.06723475672914803},{7.706949296660645,4.645891044126432,3.8751516474704477}},{{3.7990395068219147,1.8496953688386921,1.078343505069579},{3.826293878775091,5.530474464171238,4.059515092927229}}}),"values")
  check(r:raw_hex()=="54694c3ad14a9948","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.5954089819812802,3.9022107802700927},{2.947250475799079,5.37656798638698},{1.7479286894692625,8.265706077480445}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.636236863646594,5.080976194317496,5.461576359490404},{0.6984166603094065,1.662208524201803,2.813950097379261}},{{4.692111526986222,3.720551936453244,5.781482172694922},{1.65536501387956,2.546336656782756,3.1748481429646063}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{5.2996085437090485,1.7945585853805255,2.4055042312595827},{5.514421320746242,4.663165412327888,2.917637041032208}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{3.446551711131305,4.221760333306611},{1.5919968535468025,6.103196771052305},{3.4740661863515854,5.204121285207542}},{{1.425152074717769,3.5045315844135687},{1.8097517368789373,6.599028906611554},{4.7418630036452,5.418807355814639}}}),"values")
  check(r:raw_hex()=="1c1c83485525d84a","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.6975630552334726,3.8647095384961125,5.4054045995510505},{2.008620141104789,0.21686974202840137,3.2367535832944743}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.2400747938683354,1.5372676995345045,-0.8762614984722126},{3.4428193214647944,5.738709242140573,5.309420846752484}},{{3.1799041023969448,2.4607424649978396,1.0684699298091942},{7.5310017463813965,5.749157566896085,0.09460171671347783}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.0179454271508603,5.733926717576936},{1.067234756729148,6.706949296660645},{2.645891044126432,5.875151647470448}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.59540898198128,4.902210780270092,6.947250475799079},{1.3765679863869797,0.7479286894692625,5.265706077480446}},{{4.554046933412177,5.636699465379106,4.978732145215104},{0.9216225674104431,1.7757870551481616,4.440700873037425}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.6362368636465936,2.080976194317496,0.461576359490404},{5.698416660309406,4.662208524201803,3.813950097379261}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{3.299608543709048,3.7945585853805257},{3.4055042312595827,4.514421320746242},{2.6631654123278876,4.917637041032208}},{{0.45502257306707183,3.661840673278923},{3.974969630932967,4.520010218890695},{2.9058379943518546,6.186097617195956}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{6.446551711131304,5.221760333306611,5.591996853546802},{2.1031967710523047,2.4740661863515854,2.2041212852075414}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{2.6975630552334726,0.8647095384961125,0.40540459955105057},{7.008620141104789,3.2168697420284014,4.236753583294474}},{{3.898984308158921,1.8192821211149857,0.9913399371513949},{6.162505535211369,5.0132909936516565,6.103377273041828}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.2400747938683354,3.5372676995345045},{0.12373850152778743,2.4428193214647944},{3.7387092421405734,7.309420846752484}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.017945427150861,6.733926717576936,5.067234756729148},{2.706949296660645,1.6458910441264318,2.8751516474704477}},{{4.799039506821915,4.849695368838692,6.078343505069579},{-1.173706121224909,2.5304744641712387,3.0595150929272283}}}),"values")
  check(r:raw_hex()=="54694c3ad14a9948","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.5954089819812802,1.9022107802700927,1.9472504757990792},{6.37656798638698,3.7479286894692625,6.265706077480446}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:laplace(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.6362368636465936,4.080976194317496},{1.461576359490404,4.698416660309406},{2.662208524201803,5.81395009737926}},{{1.6921115269862226,2.720551936453244},{1.7814821726949222,5.6553650138795595},{3.546336656782756,6.174848142964606}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:laplace(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{6.2996085437090485,4.794558585380526,7.405504231259583},{0.5144213207462413,1.6631654123278876,1.917637041032208}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:laplace(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{5.446551711131304,2.221760333306612,0.5919968535468025},{7.103196771052305,5.474066186351585,3.2041212852075414}},{{3.425152074717769,1.5045315844135687,0.8097517368789374},{7.599028906611554,6.7418630036452,3.4188073558146392}}}),"values")
  check(r:raw_hex()=="1c1c83485525d84a","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.array({{{0.5773844911569941}},{{0.7023844911569941}}},"float64"), {{{1.0884558822073682}},{{1.2134558822073682}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,1}),"shape");check(same(x:tolist(),{{{0.14550910688083185}},{{1.367961204650351}}}),"values")
  check(r:raw_hex()=="dbcd12c26eda1624","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(np.array({0.5920824394075557},"float64"), {0.6932059034318598}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.2921100869059347,0.7458010029986466,1.4755849987328102}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(np.array({0.8299013401198438},"float64"), {0.8661400409678468}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{-0.317067820447438}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(np.array({{{0.8808356992193218,1.0058356992193218,1.1308356992193218}},{{1.2558356992193218,1.3808356992193218,1.5058356992193218}}},"float64"), {{{1.0501894222111707}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{-0.5632117720205776,1.0176348449619579,2.2552206156474783}},{{0.4450962107216043,1.0851127275576142,3.2500236508389913}}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(1.915, 1.729, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{3.4710778159804963}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(0.896, 1.891, nil);cases=cases+1
  check(same(x,0.8711145672596708),"scalar")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(np.array({1.275714459642276},"float64"), np.array({0.8326959728414154,0.9576959728414154,1.0826959728414156},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.5526488679770247,0.22196729756213585,3.289537639789136}}),"values")
  check(r:raw_hex()=="f2dab0aed2ac6fd2","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(0.725, {{0.5719649533660736},{0.6969649533660736}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.49805687068682725,1.0387209679203786,0.3412245921096261},{0.6006996559454605,2.337447473514012,-0.18951094024572945}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel({1.2652294898597496,1.3902294898597496,1.5152294898597496}, {0.8938682823578827,1.0188682823578827,1.1438682823578827}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.8784241118933829,1.6161637585628883,2.973108815455413}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(np.array({0.5050112069576889,0.6300112069576889,0.7550112069576889},"float64"), np.array({1.2998262247996961,1.4248262247996961,1.5498262247996961},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{-1.216258476263423,1.6806913893507887,-0.7061609801817039}}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(0.681, 1.811, nil);cases=cases+1
  check(same(x,-1.8091888317530613),"scalar")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel({{{0.3123686545903765,0.4373686545903765,0.5623686545903765}},{{0.6873686545903765,0.8123686545903765,0.9373686545903765}}}, np.array({{{0.907397149106622,1.032397149106622,1.1573971491066222}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.1290144463826037,2.6561367145562453,2.1368957801832527}},{{0.04134163344192199,3.958080227623599,0.9272067446800671}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(1.196, {1.0794907706465535,1.2044907706465535,1.3294907706465535}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.1817939741053776,2.5896319725927506,5.415782179469688}}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(np.array({1.1325062213246881},"float64"), {0.5308966768520722}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.3090695312074334,0.548363776900643,2.119978291902194}),"values")
  check(r:raw_hex()=="f2dab0aed2ac6fd2","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(1.938, 0.511, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.7352464249836501),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(np.array({{{0.8375985837363991,0.9625985837363991,1.087598583736399}},{{1.212598583736399,1.337598583736399,1.462598583736399}}},"float64"), np.array({{{0.42516918477401405,0.550169184774014,0.6751691847740141}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.6536142870989223,1.0845987230843988,1.9481130423874609}},{{1.5946482255539118,1.8645477956665186,1.9379915428872432}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel({0.8994352352334485}, {1.1643508882549098}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{-0.6424338595323471}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel({0.36772086927403685,0.49272086927403685,0.6177208692740369}, 1.842, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{-2.1650940551263713,0.5134162086083205,2.589857487923207}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(np.array({0.46692880076507765},"float64"), np.array({1.0181405757150896},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.383242255605946}}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel({{0.5782933655582767}}, np.array({{0.5623801204016079,0.6873801204016079,0.8123801204016079},{0.9373801204016079,1.062380120401608,1.187380120401608}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.570892481020597,1.3736127955295987,3.15677471399142},{4.4163026439647535,0.028343869064241134,-0.4803809156743424}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(1.64, np.array({0.6012962016802375},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.8399764779431225}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(1.473, 0.591, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.2385041823196423}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(np.array({{1.0010999227245205,1.1260999227245205,1.2510999227245208},{1.3760999227245208,1.5010999227245208,1.6260999227245208}},"float64"), {{1.00956850789137,1.13456850789137,1.25956850789137}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.5642273588521701,1.3776907422275344,2.8564411277809283},{2.283280641936683,2.5877837968125696,2.5129739296004607}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(np.array({0.5037919651176075},"float64"), {0.5735353297924037}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{-0.2557010783313475,0.9267222807074149,-0.036935671842329265}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(0.633, {{1.2995879516509217}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{-1.1539792396918624,0.6476012017666463,2.0244033597209823},{-0.37027355131882356,0.2670488650240051,2.7913969514442822}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(np.array({{{0.5338497548123837,0.6588497548123837,0.7838497548123837}}},"float64"), np.array({{{1.2808749640126578}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1,3}),"shape");check(same(x:tolist(),{{{1.6866207880945774,3.4116319195253455,2.5263565312351917}}}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(np.array({{{0.5866025302670803,0.7116025302670803,0.8366025302670803}}},"float64"), {{{0.33966979201960507,0.46466979201960507,0.5896697920196051}},{{0.7146697920196051,0.8396697920196051,0.9646697920196051}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.5821324986630478,1.2492394259893567,2.7082049024489017}},{{3.512746613195689,0.2769408018756738,-0.023502065679625317}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(0.371, 1.166, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.7587832133815464}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(0.977, 0.914, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.6143448775637108),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel({0.6447863859652434}, 0.476, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.4388059707900759,0.7503394920584198,1.251456375584222}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(np.array({{1.0361170962021506,1.1611170962021506,1.2861170962021506},{1.4111170962021506,1.5361170962021506,1.6611170962021506}},"float64"), {{1.171223788824552},{1.296223788824552}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{-0.514853303923245,2.0247884707505204,0.18189031402362743},{2.95714971128261,2.775617345718161,4.349643862263628}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(np.array({{{1.2311809467319177,1.3561809467319177,1.4811809467319177}}},"float64"), np.array({{{0.6786674953218335,0.8036674953218335,0.9286674953218336}},{{1.0536674953218337,1.1786674953218337,1.3036674953218337}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.2979892198825236,1.365210355813144,2.475458457086638}},{{0.41775640813270576,1.0242798182824,3.646353333891339}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel({{0.8206602767798743,0.9456602767798743,1.0706602767798743}}, np.array({{0.873084056909829},{0.998084056909829}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.6064247258508042,2.822041881294445,2.258406878357653},{0.11006814986383895,3.9868199423195403,1.0618971307179865}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel({0.7766107419550885}, np.array({0.9311702346946111},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{0.7643566043319847}}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(np.array({0.5918877324717955},"float64"), np.array({1.1711294114669688},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.9813768632302007}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel({{{0.9559398143541076,1.0809398143541076,1.2059398143541076}}}, np.array({{{0.31880055954185843,0.44380055954185843,0.5688005595418585}},{{0.6938005595418585,0.8188005595418585,0.9438005595418585}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.8294467553241183,1.3243630176180436,0.8242876423778696}},{{0.8322038247038668,2.9752572935454458,-0.03245235004749025}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(np.array({0.9851666153663905},"float64"), np.array({0.8596568966526994},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.6131655975497537,1.175795723803603,2.0808137594171816}}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(np.array({{{0.8286169848233642,0.9536169848233642,1.0786169848233642}},{{1.2036169848233642,1.3286169848233642,1.4536169848233642}}},"float64"), {{{0.9630796891771567}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{-0.4467226258712167,1.6638009538375487,0.17062792559423268}},{{2.3523018209037563,2.249551722582959,3.4511621190250477}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(0.658, 0.481, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),-0.0033919536572183384),"values")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel({{0.8251035130004953},{0.9501035130004953}}, np.array({{0.691930299822074},{0.816930299822074}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{1.4478319049946322,2.3121599721318757,1.7664079104844597},{0.36848492559411705,3.439288126436886,0.9429308911254528}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel({0.4315886188532952}, np.array({0.6789688640498717},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.4226534342953413}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel({{{0.8551911327624098}},{{0.9801911327624098}}}, {{{1.2141371101608975}},{{1.3391371101608975}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.2589835770711384,-0.4807166819194868,3.113495880956637}},{{-0.47712750262998127,2.298229390664539,1.779611228197568}}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.array({0.5218937344451782},"float64"), np.array({0.37840138125663997},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{0.3717523785921282}}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(1.219, 1.142, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.7248200963654596),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel({{{0.8011230031961918}},{{0.9261230031961918}}}, 1.422, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{-1.0819329336984531,1.849719100992627,-0.5395349472658062}},{{2.622171476923117,2.2858954205888002,3.8755250233568383}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(np.array({{0.8667642632234194,0.9917642632234194,1.1167642632234194},{1.2417642632234194,1.3667642632234194,1.4917642632234194}},"float64"), 1.162, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{-0.7310266934287382,1.004819629296404,2.3608591334027547},{0.34470772684086615,1.0395565368806876,3.421650774091856}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel({{{0.9588181484633664,1.0838181484633664,1.2088181484633664}}}, {{{0.36132644038701395,0.48632644038701395,0.611326440387014}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.2840073087950215,2.129002720680896,2.04046877394181}},{{0.7015695510050016,2.565653615678014,1.2034507218909076}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(np.array({{0.7704280785685784},{0.8954280785685784}},"float64"), np.array({{1.0636813159129017}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.7564301040343133,2.001139285853321,4.146535352589967},{5.250564987160441,0.34480500789658675,-0.05295570623302259}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(np.array({0.7646753056330922,0.8896753056330922,1.0146753056330922},"float64"), {0.8991266972776693,1.0241266972776693,1.1491266972776693}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.0637029556395001,-0.2371651859949857,3.1520601652351603}}),"values")
  check(r:raw_hex()=="f2dab0aed2ac6fd2","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel({0.9904178824712444}, np.array({0.8282163484625926},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.6617998285812686}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(np.array({0.8584670770504355},"float64"), np.array({0.9435186219366565},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.450176410092422}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(1.111, 1.412, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{-0.7588136307280158}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(0.501, np.array({{0.4549312953040657,0.5799312953040656,0.7049312953040657}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{-0.12454656586479196,0.5075156758669318,1.255734430565114},{0.14979596208477308,0.3376970735185554,1.6717722873462404}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel({0.6550542722562605}, np.array({0.6426639692056904},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.2334435988097292}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(np.array({0.3921571341910774},"float64"), {0.573574561638752,0.698574561638752,0.8235745616387521}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.3846089315600753,1.200428868657867,3.006169457855173}}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel({{0.5332065400361496,0.6582065400361496,0.7832065400361498},{0.9082065400361498,1.0332065400361499,1.1582065400361499}}, {{0.8546832071898653,0.9796832071898653,1.1046832071898653},{1.2296832071898653,1.3546832071898653,1.4796832071898653}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8174533672294019,-0.4197330447477525,2.8379261521536816},{-0.4299986667865926,2.3665459575355783,2.041527957783582}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(1.66, 0.623, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.4128072852540392),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(0.427, 1.496, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{-0.22036701912195505}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(np.array({0.36421221144265586},"float64"), 0.53, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{-0.3376300153886816,0.7550391677240277,-0.13547042832166128}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(np.array({{{0.7413030349434129,0.8663030349434129,0.9913030349434129}},{{1.1163030349434129,1.2413030349434129,1.3663030349434129}}},"float64"), {{{0.6976882279820618}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{-0.21804286973163622,0.8741417399529806,1.7382826781594143}},{{0.577692204247656,1.0448409189588175,2.525045806005619}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(np.array({{{0.878682145557063}}},"float64"), {{{0.5293358710424789}},{{0.6543358710424789}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,1}),"shape");check(same(x:tolist(),{{{1.3550776378253766}},{{2.2849428393368942}}}),"values")
  check(r:raw_hex()=="39ee1852018c694c","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(np.array({0.7699116246964253},"float64"), 0.606, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.7619367054787418}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel({{1.1661257646242489}}, {{0.4081793152978061,0.5331793152978062,0.6581793152978062}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.3018762676448858,0.5794717467442658,2.390344562041031},{0.721923809311601,1.690904542355332,1.5590368168656439}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.array({0.9887239112805368,1.1137239112805368,1.238723911280537},"float64"), {1.0479806592967018,1.1729806592967018,1.2979806592967018}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.5729082063482518,1.7571000930217318,0.36780856231755765}}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(0.355, 0.699, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.052520356707054405,0.5100034057964922,1.2458872326547605}},{{0.9831092543721984,1.0244986003086503,0.8471724597926725}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(np.array({0.9079887757455298},"float64"), {1.0474405327019471}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{-0.4790640467920868}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(np.array({0.9056754791061985},"float64"), np.array({1.2107067890607817,1.3357067890607817,1.4607067890607817},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{-0.7590890292575607,0.9206824852140809,2.4695806625026244}}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(np.array({{{0.4835434025982967}},{{0.6085434025982968}}},"float64"), {{{0.3987277491717201}},{{0.52372774917172}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.8423932609568561,1.3404659495559776,1.025974025727152}},{{0.23567218736105888,2.204340565651072,0.6039450897298746}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(np.array({{0.9197608750218971,1.044760875021897,1.1697608750218973}},"float64"), np.array({{0.3177386852562209},{0.4427386852562209}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9155794553069609,1.4123940703057096,2.178258317332295},{2.7325102015116096,0.8155736826419732,0.7750127641734771}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel({1.2892817806326886}, np.array({1.227974497925714},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.6976762032366548,-0.06185122920641084,3.5733241808848026}}),"values")
  check(r:raw_hex()=="f2dab0aed2ac6fd2","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.array({1.2766852918643479},"float64"), 1.277, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.7699997433401233}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel({0.7556941207666423}, np.array({0.6012117367230878},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.4955305847615895}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(np.array({{0.6377085763096584},{0.7627085763096584}},"float64"), {{0.757628478327119,0.882628478327119,1.007628478327119},{1.132628478327119,1.257628478327119,1.382628478327119}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{-0.3655662507468376,1.2885670701055956,-0.3122809669963734},{2.1136177197459167,1.9653024695281212,3.6304492423501973}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel({0.46539558565642597}, np.array({0.44458568228563494},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{-0.1459253976594233}),"values")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel({0.4567267417824867}, np.array({0.9780304761228149},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.3369416216249126}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(1.076, 1.341, nil);cases=cases+1
  check(same(x,1.0583525302460173),"scalar")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(0.496, np.array({{0.8326838037429503,0.9576838037429503,1.0826838037429503}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.7729303611888596,-0.5577337724937408,2.509800545526259},{-0.41016981291648424,1.438594961134922,1.14232604320128}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.array({{0.9280426549589689,1.0530426549589689,1.1780426549589689},{1.3030426549589689,1.4280426549589689,1.5530426549589689}},"float64"), {{1.2153623161067841,1.3403623161067841,1.4653623161067841}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.44581358542706756,1.7882271460686698,0.1948180408257817},{1.0862886369651152,4.529007516623387,-0.3697080702121527}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(np.array({{0.43099030564967294,0.5559903056496729,0.680990305649673},{0.805990305649673,0.930990305649673,1.0559903056496731}},"float64"), 1.485, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{-0.21161666186109135,0.885289386633637,2.573647731246697},{2.1403855027064895,2.35331565823672,2.1015927416899003}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel({{1.040726387496382}}, np.array({{0.7608677343003514,0.8858677343003514,1.0108677343003514}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.033162038504923386,1.6939735389387995,0.08768288197228014},{1.9482288906385579,1.8878280123625575,3.137389775443409}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(np.array({0.38390947624623056,0.5089094762462305,0.6339094762462306},"float64"), {1.0768284521085623,1.2018284521085623,1.3268284521085625}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{-1.0967676000401738,0.5224123251267863,2.0544778677059985}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(np.array({{0.9875623137146419}},"float64"), 0.603, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{1.5302545768934963,2.283494931619657,1.8078856205979903},{0.5582527284508422,2.8249018299855573,0.9822679930221757}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(np.array({{{1.17975458758343,1.30475458758343,1.4297545875834303}},{{1.5547545875834303,1.6797545875834303,1.8047545875834303}}},"float64"), {{{0.3489779753872357}},{{0.4739779753872357}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.1751620609126976,1.7085325791485075,2.537405030956056}},{{3.495410067365895,1.434396128866286,1.3821533634333631}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel({{{1.114824651377596}}}, {{{0.8657759151247364}},{{0.9907759151247364}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.4027606431746964,0.16221658009869933,2.725174786988963}},{{0.03661078242152871,2.0899903392178003,1.7062847570039037}}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(1.163, np.array({{0.7862539945878528}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.8510316863530862,1.594257829280832,0.635441544359338},{1.0227753853052155,2.982020111399472,0.13132993339217336}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(1.295, 1.743, nil);cases=cases+1
  check(same(x,0.5407481856085776),"scalar")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel({0.34281992160557756}, np.array({0.6422153070906176},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{-0.5076212505333852}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel({0.3231200959803265}, np.array({1.0437362593078898},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{-1.1120540488149384,0.33484673879350385,1.4405959359330927}}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel({{0.5684477926996683,0.6934477926996683,0.8184477926996683}}, {{0.7554818554980003,0.8804818554980003,1.0054818554980005},{1.1304818554980005,1.2554818554980005,1.3804818554980005}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.2483717694007792,2.5857283167683067,2.1863088220749995},{-0.23640576705505367,4.518897917189897,0.8063272062102201}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(1.232, 1.245, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.2156158837854523),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(1.046, 1.035, nil);cases=cases+1
  check(same(x,1.3902158026156952),"scalar")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.array({0.7389689169385969},"float64"), {0.9171630691556498}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.3750587581435368}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(np.array({0.6768886864472932},"float64"), {0.30299873230969326}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.545771449727335}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(1.328, 0.487, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.6830996896851674}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel({0.8235528125116125}, {1.0400010871720424}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{-0.6064853389444129}),"values")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel({{{0.32710965928592745}}}, {{{1.039466602549537}},{{1.164466602549537}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,1}),"shape");check(same(x:tolist(),{{{1.2626162646531627}},{{2.8297137267900405}}}),"values")
  check(r:raw_hex()=="39ee1852018c694c","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(np.array({{1.1665285011879887,1.2915285011879887,1.416528501187989},{1.541528501187989,1.666528501187989,1.791528501187989}},"float64"), np.array({{1.1515362344698286,1.2765362344698286,1.4015362344698286}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{1.1513743618379353,2.768519237759059,5.864981816302519},{6.256378598950823,1.0057193934858528,0.5419115165723452}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel({1.0712784874578796}, np.array({1.1258695741486668},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.4457152981884827}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel({0.34396544009347424}, 0.619, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.09835983748071384}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(1.485, 0.359, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.329649224689317}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(0.267, 1.544, nil);cases=cases+1
  check(same(x,-1.777612072127519),"scalar")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel({{1.29185825014311,1.41685825014311,1.5418582501431102}}, 0.291, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8917229933567263,1.420127709288754,1.8534172925029953},{1.067208119259011,1.3349155234944567,2.025160293742693}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(0.711, 0.741, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.3778904925630697}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(1.352, 1.819, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.3280620824142473),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(1.022, 1.331, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.4646581964072372),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel({{{0.9585097460943361,1.0835097460943361,1.2085097460943361}},{{1.3335097460943361,1.4585097460943361,1.5835097460943361}}}, 1.923, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.19550558805824847,2.1382691640630247,-0.08177929177412269}},{{0.9905519539378462,5.907422817823519,-0.9397226339545484}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(1.869, np.array({1.0696756016441344,1.1946756016441344,1.3196756016441344},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.406117175358391,2.1339195809396485,3.5509487049366943}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(1.654, 1.106, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.18940093797083146),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(np.array({1.240668063247535},"float64"), {0.9990721506121052}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{-0.13309135782909487}}),"values")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel({{{0.6933649867224441,0.8183649867224441,0.9433649867224441}}}, {{{0.9447850407813663,1.0697850407813663,1.1947850407813663}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.5436594013147589,3.117484934476042,2.568754730783019}},{{0.02071942449808184,4.077997373692755,0.9328748123203581}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(0.796, 0.28, nil);cases=cases+1
  check(same(x,0.7923152188433146),"scalar")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(np.array({0.3689414370920759},"float64"), np.array({1.2443600389101603,1.3693600389101603,1.4943600389101603},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.782785291716577,-1.137757239510244,3.1484630768970785}}),"values")
  check(r:raw_hex()=="f2dab0aed2ac6fd2","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.array({{{0.9395369086038086,1.0645369086038086,1.1895369086038086}}},"float64"), np.array({{{0.7481454632979607,0.8731454632979607,0.9981454632979608}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.6426892230540533,1.5434544336532927,0.5198041215567503}},{{0.8061087669997717,3.08458280833721,-0.12016301494913484}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel({{{0.5366077880419158,0.6616077880419158,0.7866077880419159}}}, {{{1.17251760443988,1.29751760443988,1.42251760443988}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.029221941481581082,0.9493326060234424,2.599630351735942}},{{1.5902117340548048,1.9043634676532644,1.7882157829997927}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(np.array({0.4842775404909911},"float64"), {0.5563711482620508}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{-0.2524861682655107,0.894550828109914,-0.04026775017369916}}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(0.566, 1.521, nil);cases=cases+1
  check(same(x,-1.5254286102133663),"scalar")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(0.668, 0.43, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.0549944828638598),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(0.581, 0.947, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.5685375437307817}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(np.array({0.8985358595605322},"float64"), np.array({0.48435301384921964},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.059619880247914}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.array({{0.342700732018598}},"float64"), {{1.1550723450385736,1.2800723450385736,1.4050723450385738}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{-0.11560660136513895,1.0448163646814685,-0.6000706898302843},{0.1366991401124886,3.304183097385805,-1.5009415130737307}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(0.942, 1.903, nil);cases=cases+1
  check(same(x,0.11851107126398353),"scalar")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(1.657, 0.698, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.7326870295692953),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel({1.0126530122815343,1.1376530122815343,1.2626530122815343}, {0.47174642656946425}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.3639850482491237,1.142953203583158,1.767728149390401}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(np.array({0.6610053075181441,0.7860053075181441,0.9110053075181441},"float64"), {1.1819926941579553,1.3069926941579553,1.4319926941579553}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.7247835666449305,3.594918182680413,2.859093172036302}}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(np.array({0.8989863984441995},"float64"), {0.855017582205073,0.980017582205073,1.105017582205073}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.8877344246029709,2.0328961547895306,4.406294312377281}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel({0.5165384360815413,0.6415384360815413,0.7665384360815414}, {1.0091968035716992,1.1341968035716992,1.2591968035716992}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.8521727237517118,-0.6064115364531661,3.1086545748758834}),"values")
  check(r:raw_hex()=="f2dab0aed2ac6fd2","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.array({1.0957763921723989,1.2207763921723989,1.3457763921723989},"float64"), {0.8166459774367414,0.9416459774367414,1.0666459774367414}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.7717492073426128,1.7372662325747568,0.6300813261437379}}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(np.array({{{0.4810477595751132}},{{0.6060477595751133}}},"float64"), {{{0.9244527654107895,1.0494527654107895,1.1744527654107895}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.08100749816934394,0.713764144212051,1.9779075221796185}},{{1.4367449515414765,1.6112082138420172,1.4329909733984822}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(1.926, {{1.1668289341153255,1.2918289341153255,1.4168289341153257}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.38084940103634723,2.878606736521701,0.590217317182623},{3.317700726305705,3.161297716314847,4.86467659669606}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel({1.1807676977563204,1.3057676977563204,1.4307676977563206}, np.array({0.32027513119534373,0.44527513119534373,0.5702751311953438},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.740378103724906,1.310770477309635,2.041332556027383}}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel({1.2479707766752934,1.3729707766752934,1.4979707766752934}, np.array({0.5609873827978082,0.6859873827978082,0.8109873827978082},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.7528522234171255,2.8472550633070903,2.601240845825161}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(np.array({1.0220262622839458,1.1470262622839458,1.2720262622839458},"float64"), 0.331, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.0176703245594354,1.530003196744461,2.322614902869397}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(np.array({0.6729277256662458},"float64"), {1.2482806916384455}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.088075493938712}}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.array({{0.7008176996104838,0.8258176996104838,0.9508176996104838}},"float64"), {{0.7673561919868488,0.8923561919868488,1.017356191986849},{1.142356191986849,1.267356191986849,1.392356191986849}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.39634761891328985,1.315272248586461,0.26819495279393124},{0.4970839723821401,3.75788089725334,-0.8761392573228384}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(1.817, 1.743, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.0627481856085776,2.2035106384882486,4.03848275610479}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(0.751, 1.027, nil);cases=cases+1
  check(same(x,-0.608984843312799),"scalar")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel({{0.9529947117337672},{1.0779947117337672}}, {{0.6092115296389289}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.11530738579116095,0.9598393584939385,1.6052468105959852},{0.6076873238661125,0.9064467603784043,2.089792571730063}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(np.array({0.47877118209564623},"float64"), np.array({1.1197331808634052},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.4865166780810837}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(np.array({{{0.7345695466689759,0.8595695466689759,0.9845695466689759}}},"float64"), 1.718, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.7119607822861702,2.8473471098205314,6.437473729526394}},{{7.768748954567389,-0.029766781103788387,-0.547208174641084}}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(1.062, {{{0.47442253546623253}},{{0.5994225354662326}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.2197813853376642,0.5399957162280049,1.9444297153323618}},{{0.40967722828311437,1.6519782990094751,1.419835218569087}}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.array({{0.96956374172115,1.09456374172115,1.2195637417211502},{1.3445637417211502,1.4695637417211502,1.5945637417211502}},"float64"), np.array({{0.8750231365033043,1.0000231365033043,1.1250231365033043},{1.2500231365033043,1.3750231365033043,1.5000231365033043}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.6223737825272861,1.6430732692372434,0.4646989365320684},{1.1216281332761664,4.650717358944037,-0.3736666008933196}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel({{1.2685508056953323}}, {{0.3190700733214978,0.4440700733214978,0.5690700733214978},{0.6940700733214978,0.8190700733214978,0.9440700733214978}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{1.1304789860047162,1.3670234434308548,1.9938401659357199},{1.892230113615251,2.0530519038976878,1.9332794039833012}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel({0.3317292886833593}, np.array({0.5593977105247385},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{-0.40904228648463}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel({{1.2964434535791323},{1.4214434535791323}}, {{0.6736417842661175}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.3701622565710201,1.304011990666613,2.0176777807253727},{0.9013963229798839,1.231752578708928,2.5402491270838876}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(np.array({{0.4101123988752678,0.5351123988752677,0.6601123988752678},{0.7851123988752678,0.9101123988752678,1.0351123988752677}},"float64"), {{1.241302947883805,1.366302947883805,1.491302947883805},{1.616302947883805,1.741302947883805,1.866302947883805}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{1.5272691253721924,3.4714914305542046,2.688886139792231},{-0.3656244970064123,6.215858196463907,1.0187263187502398}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel({{0.6466147403433569,0.7716147403433569,0.896614740343357}}, np.array({{0.8147504816710498},{0.9397504816710498}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.6358926788352788,1.7143055011306885,3.482619577065804},{4.494329226218278,0.2851454490790857,0.0587283309055735}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(1.116, 1.487, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.6105399985406172),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.array({{{0.8665808142228741}},{{0.9915808142228741}}},"float64"), 1.603, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.23054562684281776,1.7458212442820567,-0.20899553923689673}},{{0.7056934814996015,4.7001651376663895,-1.1117689024793422}}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel({{0.6288608958151385},{0.7538608958151385}}, 0.844, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.2636351176474045,0.8160180839299302,1.7045530622824032},{1.5122646307080363,1.562239749406699,1.3481292163659477}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(1.721, 0.735, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.747690496752768,2.2629958733336006,1.0280438863645793}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(1.394, 0.51, nil);cases=cases+1
  check(same(x,0.692732024188812),"scalar")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(np.array({{0.5700821075785183},{0.6950821075785183}},"float64"), 1.557, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.9713621304134705,3.916296180676543,2.6882303477400002},{-0.4134336872071136,5.439257276457152,0.6814116974322996}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(np.array({{{0.812533838133191,0.937533838133191,1.062533838133191}}},"float64"), {{{0.6264428938280746}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.8042898918084868,1.662347068020955,3.0508534400403002}},{{3.3774416984298936,0.6132507049804532,0.5039941009743738}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel({1.1629519115725706}, 0.448, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.3119458048786878}}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(1.395, {{1.286621857341308},{1.411621857341308}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8844967098431972,2.1007080194462358,0.5317061474729872},{1.1432440376736253,4.660825758431811,-0.4572360784338718}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel({0.6445130064847864}, np.array({0.5512941050332569},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.40595042531173453}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(np.array({0.3014143141286593},"float64"), {1.2881275081216783}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{-1.4043635702917563,1.2512915845088548,-0.9130289945718539}}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel({{{0.36904894798376736,0.49404894798376736,0.6190489479837674}},{{0.7440489479837674,0.8690489479837674,0.9940489479837674}}}, np.array({{{0.9927055457935383}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{-0.9959561670655956,0.5052022477281879,1.6818887733885162}},{{-0.022313357142999868,0.5895128683220425,2.642765851676744}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel({0.543098113893564}, 1.573, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.9587779314397296}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(np.array({0.6984510975537803,0.8234510975537803,0.9484510975537803},"float64"), np.array({0.8188874016246503,0.9438874016246503,1.0688874016246503},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.6876745944575174,1.9155571505752595,4.341082403329481}}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(np.array({{0.8230482223263906},{0.9480482223263906}},"float64"), np.array({{0.8227379348008892,0.9477379348008892,1.0727379348008892},{1.1977379348008892,1.3227379348008892,1.4477379348008892}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.0966708296402723,-0.219742169940927,2.818349371969925},{-0.3553924780004132,2.2499456830252074,1.8122993801966776}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.array({{0.7970414155821204,0.9220414155821204,1.0470414155821204}},"float64"), {{1.251416310111607,1.376416310111607,1.501416310111607}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.30050691321637196,1.6770014083725149,0.03962539571008872},{0.5738573413312115,4.106418178034943,-0.9230169565484694}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(0.939, {0.9114993348855287}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{0.5445651020344322}}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(np.array({1.1738482912796804},"float64"), {0.6323724414672072}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.33644134315493646}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel({{{0.9100317026525249,1.0350317026525249,1.1600317026525249}},{{1.2850317026525249,1.4100317026525249,1.5350317026525249}}}, {{{0.9177778198216051}},{{1.0427778198216051}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{-0.3519451482312048,1.0453431703043636,2.142650185960987}},{{0.48001392359424666,1.1163957650411152,3.2669102295944468}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(1.901, np.array({{1.0566223670986197,1.1816223670986197,1.30662236709862},{1.43162236709862,1.55662236709862,1.68162236709862}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.8519465733435294,4.44047424140835,3.6785336335424352},{0.8817475876061565,6.6440245223573235,1.8862354094609548}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(1.636, 1.818, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.6120752423469495),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel({0.30155843072600924}, {1.2277597869897707}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.7098814456998825}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.array({{0.9744396198972327},{1.0994396198972327}},"float64"), {{0.4160371954190553},{0.5410371954190554}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.8093651997191715,1.2026347057493014,0.695288172890085},{1.0029482407940302,2.351143962586537,0.38952668682796776}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel({0.4801428467438889}, np.array({0.436650667031851},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.29119014573184165}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel({{0.5546964681868582}}, 0.963, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{-0.7205376156595151}}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(1.038, 1.906, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{-1.5828171801884785}),"values")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel({1.292357961114961,1.417357961114961,1.542357961114961}, {1.1669954242458869}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{2.3426388697440945,3.925396825503263,3.1299426137436877}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel({{{0.4437328102114913,0.5687328102114912,0.6937328102114914}},{{0.8187328102114914,0.9437328102114914,1.0687328102114915}}}, 1.214, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.42775665191071943,1.973367246571205,4.546949153627618}},{{5.789334557119917,0.31529608034179646,-0.013675893903999148}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(np.array({{{0.6386639317221463,0.7636639317221463,0.8886639317221463}},{{1.0136639317221463,1.1386639317221463,1.2636639317221463}}},"float64"), {{{0.8155642236657237}},{{0.9405642236657237}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.9099007373586134,-0.13369651517633574,2.405619919104468}},{{-0.009906963693294912,2.064409041314762,1.8251493358234536}}}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.7024164750249269,4.411372627912905},{1.4967671459171377,4.866241110703397},{4.735145503794533,5.015900007781246}},{{0.7307606728748394,3.675150980900678},{3.4903044371846565,5.384947754632015},{3.5770305607961594,5.279315354206606}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.675451026509715,5.166312667163618,6.955887588685366},{1.6739369682105134,2.718346137670226,3.528082038404155}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{2.0068270375028243,2.5530570136057147,0.29290192486181543},{6.894540334244159,5.717179545038295,5.555591782785151}},{{3.963443619221106,2.7187945055006177,0.09857299778795303},{6.888006407261537,5.40645765508005,4.045388092889667}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{-0.03127643501645272,4.008426441097021},{2.8029872225770234,4.421004817309023},{2.7888074055447083,7.245623823710265}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.674990377088127,6.611856489931611,7.020302620501678},{0.4660328541495029,4.285248154565815,2.9934150240143453}},{{3.521856237366378,5.521175896780501,6.287338734399127},{1.0708803640436104,2.2559508570658044,2.060931468883665}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.990130050473164,2.8677725101069074,3.3804878563114458},{9.070800090758912,4.61175655073948,3.331296105365224}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.2494317410258662,3.174779477024101},{3.395006006299583,4.183811001688266},{3.7381833315841906,6.447724931993208}},{{0.5766399650511628,4.481446736943072},{2.169606167521585,7.683111165748933},{2.7474066823840566,6.193591833438273}}}),"values")
  check(r:raw_hex()=="54694c3ad14a9948","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.702416475024927,5.411372627912905,5.496767145917138},{0.8662411107033972,3.7351455037945334,2.015900007781246}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{2.675451026509715,2.166312667163618,1.9558875886853655},{6.673936968210514,5.718346137670226,4.528082038404155}},{{2.6400519110639924,3.763894603391433,1.5697776801603367},{5.663143476868413,4.736164832220641,4.0574356244131}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.006827037502824429,4.553057013605715},{1.2929019248618154,5.894540334244159},{3.7171795450382956,7.555591782785151}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{2.9687235649835473,5.008426441097021,6.802987222577023},{0.4210048173090233,1.7888074055447083,4.245623823710265}},{{3.8266563203444575,5.90608020002867,6.533507880247708},{0.2210694212580968,1.1721431324998166,4.005002605889144}}}),"values")
  check(r:raw_hex()=="1c1c83485525d84a","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.674990377088127,3.6118564899316112,2.020302620501677},{5.466032854149503,7.285248154565815,3.9934150240143453}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.990130050473164,4.867772510106907},{4.380487856311445,8.070800090758912},{2.61175655073948,5.331296105365224}},{{1.0519970305550863,3.798929252880653},{2.18208849182476,4.245543253030196},{2.60555594407116,10.42423055743502}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.249431741025866,4.174779477024101,7.3950060062995835},{0.18381100168826592,2.7381833315841906,3.447724931993208}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{2.702416475024927,2.411372627912905,0.49676714591713766},{5.866241110703397,6.735145503794533,3.015900007781246}},{{2.7307606728748395,1.6751509809006777,2.4903044371846565},{6.384947754632015,5.577030560796159,3.279315354206606}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.6754510265097151,4.166312667163618},{2.9558875886853655,5.673936968210514},{3.718346137670226,6.528082038404155}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.0068270375028243,5.553057013605715,5.292901924861815},{1.8945403342441587,2.7171795450382956,4.555591782785151}},{{4.963443619221106,5.718794505500617,5.098572997787953},{1.8880064072615372,2.4064576550800503,3.045388092889667}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.9687235649835473,2.008426441097021,1.8029872225770236},{5.421004817309023,4.788807405544708,5.245623823710265}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.6749903770881271,5.611856489931611},{3.020302620501677,4.466032854149503},{5.285248154565815,5.993415024014346}},{{0.5218562373663781,4.521175896780501},{2.2873387343991274,5.07088036404361},{3.2559508570658044,5.060931468883664}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.990130050473164,5.867772510106907,8.380487856311445},{4.070800090758912,1.61175655073948,2.331296105365224}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.249431741025866,1.1747794770241011,2.395006006299583},{5.183811001688266,5.738183331584191,4.447724931993208}},{{2.5766399650511627,2.4814467369430724,1.169606167521585},{8.683111165748933,4.747406682384057,4.193591833438273}}}),"values")
  check(r:raw_hex()=="54694c3ad14a9948","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.7024164750249269,4.411372627912905},{1.4967671459171377,4.866241110703397},{4.735145503794533,5.015900007781246}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.675451026509715,5.166312667163618,6.955887588685366},{1.6739369682105134,2.718346137670226,3.528082038404155}},{{3.6400519110639924,6.763894603391433,6.569777680160336},{0.6631434768684127,1.7361648322206413,3.0574356244131002}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.0068270375028243,2.5530570136057147,0.29290192486181543},{6.894540334244159,5.717179545038295,5.555591782785151}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{-0.03127643501645272,4.008426441097021},{2.8029872225770234,4.421004817309023},{2.7888074055447083,7.245623823710265}},{{0.8266563203444577,4.90608020002867},{2.533507880247708,4.221069421258097},{2.1721431324998166,7.005002605889144}}}),"values")
  check(r:raw_hex()=="1c1c83485525d84a","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.674990377088127,6.611856489931611,7.020302620501678},{0.4660328541495029,4.285248154565815,2.9934150240143453}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{2.990130050473164,2.8677725101069074,3.3804878563114458},{9.070800090758912,4.61175655073948,3.331296105365224}},{{3.0519970305550865,1.798929252880653,1.1820884918247598},{5.245543253030196,4.60555594407116,8.42423055743502}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.2494317410258662,3.174779477024101},{3.395006006299583,4.183811001688266},{3.7381833315841906,6.447724931993208}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.702416475024927,5.411372627912905,5.496767145917138},{0.8662411107033972,3.7351455037945334,2.015900007781246}},{{3.7307606728748395,4.6751509809006775,7.4903044371846565},{1.384947754632015,2.5770305607961594,2.279315354206606}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.675451026509715,2.166312667163618,1.9558875886853655},{6.673936968210514,5.718346137670226,4.528082038404155}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.006827037502824429,4.553057013605715},{1.2929019248618154,5.894540334244159},{3.7171795450382956,7.555591782785151}},{{1.9634436192211062,4.718794505500617},{1.098572997787953,5.888006407261537},{3.4064576550800503,6.045388092889667}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.9687235649835473,5.008426441097021,6.802987222577023},{0.4210048173090233,1.7888074055447083,4.245623823710265}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.674990377088127,3.6118564899316112,2.020302620501677},{5.466032854149503,7.285248154565815,3.9934150240143453}},{{2.521856237366378,2.521175896780501,1.2873387343991276},{6.07088036404361,5.2559508570658044,3.060931468883665}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.990130050473164,4.867772510106907},{4.380487856311445,8.070800090758912},{2.61175655073948,5.331296105365224}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.249431741025866,4.174779477024101,7.3950060062995835},{0.18381100168826592,2.7381833315841906,3.447724931993208}},{{3.5766399650511627,5.481446736943072,6.169606167521585},{3.683111165748933,1.7474066823840568,3.193591833438273}}}),"values")
  check(r:raw_hex()=="54694c3ad14a9948","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.702416475024927,2.411372627912905,0.49676714591713766},{5.866241110703397,6.735145503794533,3.015900007781246}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.6754510265097151,4.166312667163618},{2.9558875886853655,5.673936968210514},{3.718346137670226,6.528082038404155}},{{0.6400519110639923,5.763894603391433},{2.5697776801603367,4.663143476868413},{2.7361648322206413,6.0574356244131}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.0068270375028243,5.553057013605715,5.292901924861815},{1.8945403342441587,2.7171795450382956,4.555591782785151}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{1.9687235649835473,2.008426441097021,1.8029872225770236},{5.421004817309023,4.788807405544708,5.245623823710265}},{{2.8266563203444575,2.9060802000286707,1.533507880247708},{5.221069421258097,4.172143132499817,5.005002605889144}}}),"values")
  check(r:raw_hex()=="1c1c83485525d84a","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.6749903770881271,5.611856489931611},{3.020302620501677,4.466032854149503},{5.285248154565815,5.993415024014346}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.990130050473164,5.867772510106907,8.380487856311445},{4.070800090758912,1.61175655073948,2.331296105365224}},{{4.0519970305550865,4.798929252880653,6.18208849182476},{0.2455432530301962,1.6055559440711602,7.4242305574350205}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.249431741025866,1.1747794770241011,2.395006006299583},{5.183811001688266,5.738183331584191,4.447724931993208}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.7024164750249269,4.411372627912905},{1.4967671459171377,4.866241110703397},{4.735145503794533,5.015900007781246}},{{0.7307606728748394,3.675150980900678},{3.4903044371846565,5.384947754632015},{3.5770305607961594,5.279315354206606}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.675451026509715,5.166312667163618,6.955887588685366},{1.6739369682105134,2.718346137670226,3.528082038404155}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{2.0068270375028243,2.5530570136057147,0.29290192486181543},{6.894540334244159,5.717179545038295,5.555591782785151}},{{3.963443619221106,2.7187945055006177,0.09857299778795303},{6.888006407261537,5.40645765508005,4.045388092889667}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{-0.03127643501645272,4.008426441097021},{2.8029872225770234,4.421004817309023},{2.7888074055447083,7.245623823710265}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.674990377088127,6.611856489931611,7.020302620501678},{0.4660328541495029,4.285248154565815,2.9934150240143453}},{{3.521856237366378,5.521175896780501,6.287338734399127},{1.0708803640436104,2.2559508570658044,2.060931468883665}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.990130050473164,2.8677725101069074,3.3804878563114458},{9.070800090758912,4.61175655073948,3.331296105365224}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.2494317410258662,3.174779477024101},{3.395006006299583,4.183811001688266},{3.7381833315841906,6.447724931993208}},{{0.5766399650511628,4.481446736943072},{2.169606167521585,7.683111165748933},{2.7474066823840566,6.193591833438273}}}),"values")
  check(r:raw_hex()=="54694c3ad14a9948","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.702416475024927,5.411372627912905,5.496767145917138},{0.8662411107033972,3.7351455037945334,2.015900007781246}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{2.675451026509715,2.166312667163618,1.9558875886853655},{6.673936968210514,5.718346137670226,4.528082038404155}},{{2.6400519110639924,3.763894603391433,1.5697776801603367},{5.663143476868413,4.736164832220641,4.0574356244131}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.006827037502824429,4.553057013605715},{1.2929019248618154,5.894540334244159},{3.7171795450382956,7.555591782785151}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{2.9687235649835473,5.008426441097021,6.802987222577023},{0.4210048173090233,1.7888074055447083,4.245623823710265}},{{3.8266563203444575,5.90608020002867,6.533507880247708},{0.2210694212580968,1.1721431324998166,4.005002605889144}}}),"values")
  check(r:raw_hex()=="1c1c83485525d84a","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.674990377088127,3.6118564899316112,2.020302620501677},{5.466032854149503,7.285248154565815,3.9934150240143453}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.990130050473164,4.867772510106907},{4.380487856311445,8.070800090758912},{2.61175655073948,5.331296105365224}},{{1.0519970305550863,3.798929252880653},{2.18208849182476,4.245543253030196},{2.60555594407116,10.42423055743502}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.249431741025866,4.174779477024101,7.3950060062995835},{0.18381100168826592,2.7381833315841906,3.447724931993208}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{2.702416475024927,2.411372627912905,0.49676714591713766},{5.866241110703397,6.735145503794533,3.015900007781246}},{{2.7307606728748395,1.6751509809006777,2.4903044371846565},{6.384947754632015,5.577030560796159,3.279315354206606}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.6754510265097151,4.166312667163618},{2.9558875886853655,5.673936968210514},{3.718346137670226,6.528082038404155}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.0068270375028243,5.553057013605715,5.292901924861815},{1.8945403342441587,2.7171795450382956,4.555591782785151}},{{4.963443619221106,5.718794505500617,5.098572997787953},{1.8880064072615372,2.4064576550800503,3.045388092889667}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.9687235649835473,2.008426441097021,1.8029872225770236},{5.421004817309023,4.788807405544708,5.245623823710265}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.6749903770881271,5.611856489931611},{3.020302620501677,4.466032854149503},{5.285248154565815,5.993415024014346}},{{0.5218562373663781,4.521175896780501},{2.2873387343991274,5.07088036404361},{3.2559508570658044,5.060931468883664}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.990130050473164,5.867772510106907,8.380487856311445},{4.070800090758912,1.61175655073948,2.331296105365224}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.249431741025866,1.1747794770241011,2.395006006299583},{5.183811001688266,5.738183331584191,4.447724931993208}},{{2.5766399650511627,2.4814467369430724,1.169606167521585},{8.683111165748933,4.747406682384057,4.193591833438273}}}),"values")
  check(r:raw_hex()=="54694c3ad14a9948","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.7024164750249269,4.411372627912905},{1.4967671459171377,4.866241110703397},{4.735145503794533,5.015900007781246}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.675451026509715,5.166312667163618,6.955887588685366},{1.6739369682105134,2.718346137670226,3.528082038404155}},{{3.6400519110639924,6.763894603391433,6.569777680160336},{0.6631434768684127,1.7361648322206413,3.0574356244131002}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.0068270375028243,2.5530570136057147,0.29290192486181543},{6.894540334244159,5.717179545038295,5.555591782785151}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{-0.03127643501645272,4.008426441097021},{2.8029872225770234,4.421004817309023},{2.7888074055447083,7.245623823710265}},{{0.8266563203444577,4.90608020002867},{2.533507880247708,4.221069421258097},{2.1721431324998166,7.005002605889144}}}),"values")
  check(r:raw_hex()=="1c1c83485525d84a","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.674990377088127,6.611856489931611,7.020302620501678},{0.4660328541495029,4.285248154565815,2.9934150240143453}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{2.990130050473164,2.8677725101069074,3.3804878563114458},{9.070800090758912,4.61175655073948,3.331296105365224}},{{3.0519970305550865,1.798929252880653,1.1820884918247598},{5.245543253030196,4.60555594407116,8.42423055743502}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.2494317410258662,3.174779477024101},{3.395006006299583,4.183811001688266},{3.7381833315841906,6.447724931993208}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.702416475024927,5.411372627912905,5.496767145917138},{0.8662411107033972,3.7351455037945334,2.015900007781246}},{{3.7307606728748395,4.6751509809006775,7.4903044371846565},{1.384947754632015,2.5770305607961594,2.279315354206606}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.675451026509715,2.166312667163618,1.9558875886853655},{6.673936968210514,5.718346137670226,4.528082038404155}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:gumbel(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.006827037502824429,4.553057013605715},{1.2929019248618154,5.894540334244159},{3.7171795450382956,7.555591782785151}},{{1.9634436192211062,4.718794505500617},{1.098572997787953,5.888006407261537},{3.4064576550800503,6.045388092889667}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:gumbel(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.9687235649835473,5.008426441097021,6.802987222577023},{0.4210048173090233,1.7888074055447083,4.245623823710265}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:gumbel(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.674990377088127,3.6118564899316112,2.020302620501677},{5.466032854149503,7.285248154565815,3.9934150240143453}},{{2.521856237366378,2.521175896780501,1.2873387343991276},{6.07088036404361,5.2559508570658044,3.060931468883665}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(0.503, np.array({0.496662110367086},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.1489480064083843}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic({0.46512028994694593}, {0.7195533808644503}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{3.1531673174061594}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic({{{0.7240480734593115,0.8490480734593115,0.9740480734593117}}}, 1.092, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{5.022024420578481,1.4208110729912293,-0.00259917780197072}},{{2.953989917980233,1.9588944219413056,-0.7342089192008429}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(np.array({{{0.6822140408926154}},{{0.8072140408926154}}},"float64"), np.array({{{0.3680547442575028,0.4930547442575028,0.6180547442575028}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.428321941585059,-0.3484102297141982,-0.07761245604974742}},{{1.5059202628163666,-0.683365819254987,1.1503828439643444}}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic({0.6822771346807794}, np.array({0.7318435987518663},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.0937204365464792}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(np.array({{1.1244940194542585},{1.2494940194542585}},"float64"), {{1.0236337965973428,1.1486337965973428,1.273633796597343},{1.398633796597343,1.523633796597343,1.648633796597343}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.1729071001179037,4.517838703408669,-1.1440551044610126},{5.328418763436728,0.043429742415253436,0.739847388476181}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(np.array({0.7147608296912888},"float64"), np.array({0.8743933450085408},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.790951594906911}}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(1.28, 0.315, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.6896821919196785),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic({0.3685407667026767}, {1.17913417217634,1.30413417217634,1.42913417217634}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{4.773451077437879,-0.2688124442206589,3.923216929019602}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic({{{1.044865093737316}},{{1.169865093737316}}}, np.array({{{1.241352068267682,1.366352068267682,1.491352068267682}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{5.930672628409439,1.7602767759436984,-0.28894891554515634}},{{3.7047945084009575,2.558547194202249,-1.1631134769004603}}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(1.88, 1.376, nil);cases=cases+1
  check(same(x,0.9308055279874958),"scalar")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(0.851, 0.828, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.3165025397855619),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(1.371, 1.364, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.4355108067403795}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(1.646, 0.452, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),2.202315105386249),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.array({0.5941103285789364},"float64"), np.array({0.7766969957498724},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.6042656545352438}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(1.105, 0.806, nil);cases=cases+1
  check(same(x,4.115987039667964),"scalar")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic({{0.402080437502852},{0.5270804375028519}}, np.array({{0.8339532182802623},{0.9589532182802623}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.684416707441018,0.8387320799508546,-0.3437786452022014},{2.485331269353733,1.5017056459949816,-0.9730464313261016}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(0.339, 1.025, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),-0.36806710306164),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(1.586, np.array({0.6584334839211814},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.9561720519869152,0.9303945098886046,-0.49003589056665553}}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic({0.5510000415436045,0.6760000415436045,0.8010000415436045}, 1.495, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.6217065342685806,5.092595058632605,-1.8618383263719267}),"values")
  check(r:raw_hex()=="f2dab0aed2ac6fd2","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(1.945, 1.437, nil);cases=cases+1
  check(same(x,3.7136389523009736),"scalar")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.array({0.7308116140953804},"float64"), {1.2632592694254432}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{2.3737793171463872}}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(1.25, np.array({0.5414031579283047},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{3.2725284016841605}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic({{0.8324121871348316}}, np.array({{0.6715827588931012}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.475678499273646,1.1840478763826705,0.2317716601500186},{2.203832055371582,1.5149704954324248,-0.21817017919221837}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(0.679, 0.896, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.06091987868953219}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(1.531, np.array({{{0.8276055373633511}},{{0.9526055373633511}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,1}),"shape");check(same(x:tolist(),{{{1.9962807724435199}},{{0.5824859352434001}}}),"values")
  check(r:raw_hex()=="0a7d3da94ecde8b8","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic({0.7136432564787827}, {1.1626936885116295,1.2876936885116295,1.4126936885116295}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.7686332182367246,4.517804813814848,-1.8025941722040792}),"values")
  check(r:raw_hex()=="f2dab0aed2ac6fd2","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic({{0.4122564828485696,0.5372564828485695,0.6622564828485696},{0.7872564828485696,0.9122564828485696,1.0372564828485697}}, np.array({{0.5739563755259345}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{1.1186737428879938,0.3962267375859999,1.6974977341489383},{1.2663928776156976,-0.38698781836317464,3.1548162515089277}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(1.544, np.array({1.0719988659927304},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{2.9382185560486076,1.764196071738519,0.33105542869952287}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(np.array({{{0.9429537382978983}},{{1.0679537382978983}}},"float64"), {{{0.604587262328389,0.729587262328389,0.8545872623283891}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{3.201520005319132,0.586391664996986,3.0685630961599086}},{{0.4408814837952134,0.5149817081062417,-0.6503060107559215}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(np.array({{0.451422639301677}},"float64"), np.array({{0.33461487919887184,0.45961487919887184,0.5846148791988719}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.768425236546081,0.6920735385326724,-0.07143680650054357}}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(1.206, np.array({{0.5959871830463119},{0.7209871830463119}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.7948751892893432,-0.0397822644889152,0.47330300556037086},{2.574704625008967,-0.9736544643166813,1.6063210248524145}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(np.array({0.49038138246002544},"float64"), {1.1076446226445975}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.113100446494905}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(0.719, 1.972, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.812266356958965}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(1.318, np.array({0.7057482308655254,0.8307482308655254,0.9557482308655255},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{2.18662478192503,1.113872619641279,3.041876650978385}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.array({{{1.080608077284081}},{{1.205608077284081}}},"float64"), {{{0.6157373452738795}},{{0.7407373452738795}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,1}),"shape");check(same(x:tolist(),{{{1.8814227606447373}},{{1.3577607136287853}}}),"values")
  check(r:raw_hex()=="3e6f74f5cba0e8f3","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(1.994, {0.7572868419214451}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{4.823008519027982}}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic({{{0.6540912077098493,0.7790912077098493,0.9040912077098493}},{{1.0290912077098493,1.1540912077098493,1.2790912077098493}}}, np.array({{{0.33030790458382614}},{{0.45530790458382614}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.9541420879001243,0.9520379460742732,0.6086751755837799}},{{1.9588624060364181,1.6168401228539404,0.566835793956403}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(np.array({{0.45466569734766743},{0.5796656973476675}},"float64"), np.array({{0.8037146175042662,0.9287146175042662,1.0537146175042662}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{-0.09975397707870876,-1.48661128338317,-0.8407539948950864},{2.1054180824559356,-2.2279805545126865,1.1647303496747565}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(0.896, 0.763, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.3249594660101254}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic({{0.545947756073452,0.670947756073452,0.795947756073452}}, np.array({{0.9893839486879183},{1.1143839486879183}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.5927409794648302,3.5938295070854247,-0.9663061162783606},{3.7958965801748734,-0.2111662232959327,0.4514552276313964}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic({0.5232929296973619}, np.array({1.197161190321667},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.9967417211976397}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(1.322, 1.165, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.837173820909287}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(np.array({{1.1817388243403069,1.3067388243403069,1.4317388243403069}},"float64"), {{0.5278287732115812},{0.6528287732115812}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.1535571807967733,1.0487796583269513,2.7446039103825455},{0.5046309258949482,0.8119439303912792,0.11914097332927498}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(0.993, 0.751, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.9488427075883665,1.386217960300797,0.3213314233541913},{2.5265955359296814,1.756273450283862,-0.1818177669301978}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(np.array({{1.058714130898832}},"float64"), {{1.2407163994592059,1.3657163994592059,1.4907163994592059},{1.6157163994592059,1.7407163994592059,1.8657163994592059}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.2028412037898668,-1.7960205297888776,-0.7739484774860728},{4.125951053612063,-4.2037376302537695,2.0946347667688467}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic({0.6581294312680952}, {1.1280043059103422}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.2922947323433538,-0.46503005846502443,-2.8984597777702543}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(np.array({{{1.0210463205072438,1.1460463205072438,1.271046320507244}}},"float64"), np.array({{{0.3040919926116045}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.0354284464358832,2.0444083133534496,0.7294089791680689}},{{1.9078891496509627,0.9053359279959197,1.1770415391775269}}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic({{{1.2002957561060363,1.3252957561060363,1.4502957561060366}}}, {{{0.5882604762334962}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{1.9243182977662188,1.1807512773811037,2.5113372175733426}},{{1.6913731546421824,-0.006328220845399635,3.62062920143728}}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(1.427, 1.548, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),3.440295343148134),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(np.array({1.2217269454175168},"float64"), {0.7830777894914367}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{4.147083118135326}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(0.466, 0.406, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.063965564954563}),"values")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(1.872, 0.975, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.1994239751364888),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic({{{0.42756388124026906}},{{0.5525638812402691}}}, {{{0.8276091377195227,0.9526091377195227,1.0776091377195227}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.8928466778081152,-0.5209537684088523,-2.970129736322043}},{{-2.829093135015814,1.9542339282554766,3.082525578004759}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(1.916, 1.597, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.9915306146366465}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(np.array({{{0.7596848434806989,0.8846848434806989,1.0096848434806989}}},"float64"), {{{0.9786425888224592,1.1036425888224592,1.2286425888224595}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1,3}),"shape");check(same(x:tolist(),{{{1.9641840800652963,0.6135032000675902,3.2257792110847996}}}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.array({{{1.0601198879661202,1.1851198879661202,1.3101198879661202}}},"float64"), np.array({{{1.241091569692505,1.366091569692505,1.4910915696925051}},{{1.6160915696925051,1.7410915696925051,1.8660915696925051}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{2.674256759853929,1.4657246598777323,-0.3770194198684609}},{{-0.05193206552913554,-0.13775741460963653,0.4766023090238628}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(np.array({{1.0869454153170346},{1.2119454153170346}},"float64"), {{1.0598190881307383},{1.1848190881307383}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{5.046128465880773,0.5689932649713937,3.7230265631142268},{-0.016937862690906025,0.3139420503972845,-1.1702887213104294}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(0.291, 1.125, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),4.718860247718926),"values")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(0.859, {0.31778882306393547}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.6397824170642098}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(1.719, 0.586, nil);cases=cases+1
  check(same(x,2.0484498651139362),"scalar")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(np.array({1.2596942816166279},"float64"), np.array({0.9945144209094869},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.3067301522968422}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(np.array({0.6123026800261371},"float64"), np.array({0.8405401557430969,0.9655401557430969,1.090540155743097},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.6468274263172769,0.37505488905865464,2.5793026186369237}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.array({{0.3060661025276515,0.4310661025276515,0.5560661025276515},{0.6810661025276515,0.8060661025276515,0.9310661025276515}},"float64"), np.array({{1.183206198636491,1.308206198636491,1.433206198636491}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{1.8449185118938356,0.6997808139904986,-1.0655771037648014},{-0.13311224556667156,-0.18790590755494685,0.29090321866157687}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(np.array({0.7159719193145748,0.8409719193145748,0.9659719193145748},"float64"), np.array({0.8491545015573942},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{3.888171917906416,0.42597524206745085,3.078068406527906}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic({0.6600332038046983,0.7850332038046983,0.9100332038046984}, np.array({1.1657662832282105,1.2907662832282105,1.4157662832282105},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{5.248344478148907,1.4608687365823783,-0.3561794783777502}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(np.array({{0.3909444836401969,0.515944483640197,0.640944483640197},{0.765944483640197,0.890944483640197,1.015944483640197}},"float64"), np.array({{0.7023258700150881}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{-0.09353504642498778,-0.9521157996101479,-0.22248357104880068},{2.099222923475307,-1.2322939788182299,1.4059039984222288}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic({{{0.6664923735582435}}}, np.array({{{0.6774180129241663,0.8024180129241663,0.9274180129241664}},{{1.0524180129241665,1.1774180129241665,1.3024180129241665}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.0473375492982049,-0.13247922719396543,-2.2576497416368833}},{{-3.633746223668811,2.3989464265214457,3.7242501175649494}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(1.801, 1.681, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.8805034209168459),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(np.array({{{0.8934221040810653}},{{1.0184221040810653}}},"float64"), 1.309, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{2.5045204955646936,0.5717810448985768,3.254456593349406}},{{2.1111698589526036,-1.9447138811717473,5.847858373756511}}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.array({{1.2598393208600913,1.3848393208600913,1.5098393208600913},{1.6348393208600913,1.7598393208600913,1.8848393208600913}},"float64"), np.array({{0.9421373661658841,1.067137366165884,1.192137366165884}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.485162816924447,1.6040368065006319,0.16096051845922754},{0.9865433219489689,0.9490308458752623,1.352353419658081}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(np.array({1.2468956133399896},"float64"), np.array({0.7572964498061658},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{4.075940024695977}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(0.427, 1.339, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{5.697137663729458}),"values")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(0.457, 1.478, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),-0.5625562715366867),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(np.array({{{0.9207910848914009}},{{1.045791084891401}}},"float64"), {{{0.8821863868503015}},{{1.0071863868503015}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.4167572728661153,0.042393718043898465,-1.8607360488194686}},{{-3.069628569796145,2.5277661513800025,3.4104174517634944}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(1.92, {{{0.31558020743484744,0.44058020743484744,0.5655802074348475}},{{0.6905802074348475,0.8155802074348475,0.9405802074348475}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.934925464642902,3.22158150420387,0.9126095809423833}},{{3.933983004460095,1.2744103869027117,1.6292358928506732}}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(1.84, 0.73, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),2.7384735109114198),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.array({0.3264703555529335},"float64"), {0.9067712308313263}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.5057974203677984,0.5127275143323476,-0.6995225598684598}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(np.array({{0.8346054518088475}},"float64"), {{0.4998487421523206},{0.6248487421523206}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{2.7018983605122857,0.5903206170244594,2.077875987973534},{0.18651817991426067,0.36101730772862567,-0.4217348778632706}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(np.array({{{0.9051478628562544}}},"float64"), np.array({{{0.7655126429357635}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{3.9181105302176045,1.3059645340142745,0.22049967739016196}},{{2.4683792502118056,1.6831711334414718,-0.29237258152540657}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(1.724, 0.851, nil);cases=cases+1
  check(same(x,1.1369618490678481),"scalar")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(np.array({0.6756483713683272},"float64"), {0.838110150435756}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.1468348492039597,-0.1588620679724888,-1.9669067158834788}}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(np.array({{{0.6770330102248932,0.8020330102248932,0.9270330102248933}}},"float64"), np.array({{{1.2859675591911797}},{{1.4109675591911797}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.7378532482640279,4.601095160099053,-1.3634845526573542}},{{4.791927490926724,-0.3148479443730965,0.4908567869512324}}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(1.083, np.array({{{0.9076386860849743}},{{1.0326386860849743}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{2.200108653323007,0.8599794741425719,2.7201017888776358}},{{1.9450424796125678,-1.254546868221979,4.89282637436881}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.array({1.2249587664776718},"float64"), {0.8107279445893036}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{2.279374008985232,1.3914879618998048,0.3076368453574134}}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(1.467, np.array({{0.9587119177875347,1.0837119177875347,1.2087119177875347},{1.3337119177875347,1.4587119177875347,1.5837119177875347}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{5.048475383664375,0.9373710053351962,4.473421317828214},{0.08368647148926533,0.3614065606772159,-1.7172604756557637}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic({0.7517189146584033}, 1.757, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{7.667052652651426,1.671670920315527,-0.819681470383788}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(np.array({0.3816116759027606},"float64"), np.array({0.9245946513116021,1.0495946513116021,1.1745946513116023},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{-0.25619365249644105,-1.8123388631389739,-1.0624159729837752}}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(1.755, np.array({{{1.2338104705056545,1.3588104705056545,1.4838104705056545}},{{1.6088104705056545,1.7338104705056545,1.8588104705056545}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{2.4486496469014507,0.4020256658590662,-2.923443406649536}},{{-4.818689157665473,4.3061304767944115,6.119030637190177}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(np.array({{{0.5046762106820601}}},"float64"), np.array({{{0.9120036456312182}},{{1.0370036456312182}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.5478097084312076,3.1989576533990105,-1.119750745348473}},{{3.528955932833628,-0.3161857674048919,0.18410446491369714}}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(np.array({1.0787255541169731},"float64"), 1.595, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{3.0418286361768567}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(0.26, {0.3100895953501461}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.6632958257604253,0.3236945737063421,-0.09085997124485012}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(np.array({1.068556523604984},"float64"), {0.6497589057651094}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{3.4958712186019847}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(np.array({{0.8045240823491477}},"float64"), np.array({{0.6340260882166728}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{3.2999720041547813,1.136495380865863,0.2374729502202495},{2.09925055179262,1.4489119384385223,-0.18730696043940098}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(np.array({{0.5591367941850518,0.6841367941850518,0.8091367941850519},{0.9341367941850519,1.059136794185052,1.184136794185052}},"float64"), 0.515, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.20387868874432535,-0.3923592857011773,0.17600413148635186},{1.911800334473452,-0.4977869286198604,1.4700854665704677}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic({{{0.8323394406671563,0.9573394406671563,1.0823394406671563}},{{1.2073394406671563,1.3323394406671563,1.4573394406671563}}}, np.array({{{0.7778865736625906}},{{0.9028865736625906}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.269668155286751,0.18279391582537063,-1.3703311557552706}},{{-2.481905370141426,2.660847656728022,3.577095452316556}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(np.array({0.7428763097252933,0.8678763097252933,0.9928763097252934},"float64"), np.array({1.2652387498727602},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.802716172242508,4.605700495756029,-1.2607198693614405}}),"values")
  check(r:raw_hex()=="f2dab0aed2ac6fd2","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(1.458, {1.2075111257890252}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.9441873433592693}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic({{{1.241301034256392,1.366301034256392,1.491301034256392}}}, np.array({{{0.5413121205703186,0.6663121205703186,0.7913121205703186}},{{0.9163121205703186,1.0413121205703186,1.1663121205703186}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.9453198789165107,1.5031662084237885,0.5959477169175792}},{{0.6107756959641524,0.5751145204748164,0.9703503634439344}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic({0.4917970048592865,0.6167970048592866,0.7417970048592866}, np.array({0.30445722949658965},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.6291627271265898,0.46800342445287113,1.4990714981900939}}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(0.391, np.array({0.952523001531614,1.077523001531614,1.202523001531614},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{4.140012207573108,0.955182951850138,-0.6844952234654922}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(np.array({0.4440245275651504,0.5690245275651504,0.6940245275651504},"float64"), 0.357, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.19775822923051087,-0.17720673557928412,0.25513450701478946}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic({0.4539759718937901,0.5789759718937901,0.7039759718937901}, np.array({0.6808627328079961},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.8367577730622207,-0.09896243273115535,-1.442779174033599}}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(0.332, 1.635, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.4093278365253083),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(np.array({1.2363439128724643},"float64"), {1.152673591990652}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{2.6550380075720788,0.9531146118643995,3.3154135122298003}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.array({0.8378657753065022,0.9628657753065022,1.0878657753065024},"float64"), np.array({1.2646416857810867,1.3896416857810867,1.5146416857810867},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{2.4826314191915584,1.2483079059282742,-0.6259200023792277}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic({1.1367546687301207}, np.array({0.6392200479866781},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{3.52469918483908}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(np.array({1.1761437990397994},"float64"), {0.6106844575738679}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{3.57972196223191,1.4958935950379284,0.6299686187490436}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic({{{0.8857114137145057,1.0107114137145057,1.1357114137145057}},{{1.2607114137145057,1.3857114137145057,1.5107114137145057}}}, {{{1.0824154944301885,1.2074154944301885,1.3324154944301885}},{{1.4574154944301885,1.5824154944301885,1.7074154944301885}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.13903786448934852,-1.513129453368972,-0.5023386247507178}},{{4.027433728191762,-3.3981725136882615,2.4587370328263507}}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic({{{0.7489810715655871}},{{0.8739810715655871}}}, {{{0.8939050220884059}},{{1.018905022088406}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.2515354895718935,-0.14108459859018663,-2.0694948321225946}},{{-3.289321579173788,2.373198949774922,3.2661199169913617}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic({{1.0494741577148903,1.1744741577148903,1.2994741577148905},{1.4244741577148905,1.5494741577148905,1.6744741577148905}}, np.array({{0.63584467754906},{0.76084467754906}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.079546630669631,3.052914582133446,0.16693127917809036},{3.643373907694034,0.9472116009138567,1.439272181744974}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic({1.2195267534544978}, {0.9822829892237779}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{2.428506542545528}}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.array({0.6699107862637108},"float64"), {0.7184755184748566}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.6043445172142081}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic({0.4055267777326054}, np.array({0.9293494535807731},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{3.877312336112521}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic({1.2471067819741617}, np.array({0.3523312930513817},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{2.633838983333824}}),"values")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(np.array({{{1.0742925430325385,1.1992925430325385,1.3242925430325387}}},"float64"), {{{1.0436842058584868}},{{1.1686842058584868}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.35433667186419837,-0.9823034885127686,0.04120407648542823}},{{3.2928943647388405,-2.3338184561295927,1.973192925756884}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(np.array({{0.5393566483982148,0.6643566483982148,0.789356648398215},{0.914356648398215,1.0393566483982148,1.1643566483982148}},"float64"), {{1.1164587028139956},{1.2414587028139956}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.1670309983083702,-0.44730682698956215,-2.7308293597222386},{-4.1583127331062375,2.8660402371221716,4.078996898091262}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(np.array({1.2894709430815081},"float64"), {0.5778137511700345}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.3167988252176253}}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(0.802, np.array({{{0.8554216863163422,0.9804216863163422,1.1054216863163422}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.8548407202937143,0.5610955923359284,2.795841655139842}},{{1.5161024653862556,-1.4173451332667675,4.8803526242795545}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(0.764, 1.799, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),3.1037405182968296),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(0.971, 0.421, nil);cases=cases+1
  check(same(x,2.5437364065759462),"scalar")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(1.647, 1.027, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),5.68914442169541),"values")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic({1.0385521220619145}, {0.8354194157119315}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.4622617941508088}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(np.array({{0.41175389571441806},{0.536753895714418}},"float64"), np.array({{0.6130249452966579,0.7380249452966579,0.863024945296658}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.7563972157476297,-0.32310120778692736,-2.309357354916725},{-1.9681001627058496,1.6226845453497998,2.562924590195953}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(np.array({{1.0792829630323832,1.2042829630323832,1.3292829630323832},{1.4542829630323832,1.5792829630323832,1.7042829630323832}},"float64"), np.array({{1.1058246666505547,1.2308246666505547,1.355824666650555},{1.480824666650555,1.605824666650555,1.730824666650555}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.131583286609391,4.840439544730758,-1.0856614801270696},{5.772906171620175,0.3081587795438687,1.1692284457752358}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic({0.3000068825785139}, np.array({0.5392469446067054},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.9637042737689832}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(0.682, 0.291, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.0604683106305601}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(1.162, 0.46, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),2.8804293278502024),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(1.737, 1.534, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),7.774633440000739),"values")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(np.array({{0.3930099847704835,0.5180099847704835,0.6430099847704835}},"float64"), np.array({{0.7347170735515056,0.8597170735515056,0.9847170735515057},{1.1097170735515056,1.2347170735515056,1.3597170735515056}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{-0.11381369597682284,-1.2790425579274907,-0.5675852439334708},{2.499670029133295,-3.2147284671996075,1.3979794838031738}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(1.138, 0.641, nil);cases=cases+1
  check(same(x,1.4983709275393056),"scalar")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(np.array({0.33755621151703313},"float64"), {0.6676729675632112}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.3691340134057765}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(np.array({{{0.7199086488505737,0.8449086488505737,0.9699086488505738}},{{1.094908648850574,1.219908648850574,1.344908648850574}}},"float64"), np.array({{{0.7848741773083381,0.9098741773083381,1.034874177308338}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{1.6859205087271967,0.6213388290551198,2.836504236840021}},{{1.750118347177795,-0.8397406382652663,5.162982664468165}}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(0.902, 0.847, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),2.0035898938284684),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(np.array({{0.7884816215760488},{0.9134816215760488}},"float64"), {{1.11572942565598},{1.24072942565598}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.956529810690611,0.24320511005209977,3.563628189469813},{-0.3733913356503009,-0.02689755559591389,-1.5811675799142941}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(np.array({{{1.0300628280232282,1.1550628280232282,1.2800628280232282}},{{1.4050628280232282,1.5300628280232282,1.6550628280232282}}},"float64"), {{{0.3196802838713653}},{{0.4446802838713653}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{2.288284713297468,1.322445023991641,0.9941517744285437}},{{2.3131316672523488,1.9820104372691727,0.9594326041941419}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(np.array({{{0.3551383920988666,0.4801383920988666,0.6051383920988667}},{{0.7301383920988667,0.8551383920988667,0.9801383920988667}}},"float64"), np.array({{{0.424617154646107}},{{0.549617154646107}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.062228322395550206,-0.4074319038797332,0.0831209362762736}},{{1.7735183012533329,-0.806438280773095,1.2853078982955732}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(1.959, 0.323, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),2.14059096660717),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(np.array({{1.153964502241745,1.278964502241745,1.403964502241745},{1.528964502241745,1.653964502241745,1.778964502241745}},"float64"), np.array({{0.3142972594170201,0.4392972594170201,0.5642972594170201}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{1.1688292894567613,2.5767558647581765,0.3988592224522971},{2.4455696003888465,1.3062295460027673,1.6045217620009375}}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(1.703, 0.644, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),2.4956259466122663),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.array({{1.1944665055506172},{1.3194665055506172}},"float64"), 1.34, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1}),"shape");check(same(x:tolist(),{{2.937241544193059},{1.5947118863900558}}),"values")
  check(r:raw_hex()=="3e6f74f5cba0e8f3","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic({0.6962529377367148}, np.array({0.6795398868573326},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{3.2348209182142122,0.36414989337262765,2.38646809330662}}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(1.131, 0.696, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),3.870369539922108),"values")
  check(r:raw_hex()=="a0c3c8b230899767","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic({{0.7447236490952409},{0.8697236490952409}}, 0.952, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.0880135202028689,-1.2452263859565844,-0.425649739039055},{2.676977416773992,-2.008317873448985,1.398312262902844}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(1.272, 0.577, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.5963900548988759}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(np.array({{{1.2729922023797837}}},"float64"), np.array({{{0.8449551335734837}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1,1}),"shape");check(same(x:tolist(),{{{1.3129546197743955}}}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(np.array({{{0.8776241557352644,1.0026241557352644,1.1276241557352644}},{{1.2526241557352644,1.3776241557352644,1.5026241557352644}}},"float64"), np.array({{{0.5106872294915377}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.5061706599255218,0.8771405946927673,2.048747274190892}},{{1.6789437305774677,0.2215999334927612,3.3867581729747602}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.array({0.6793397529928178,0.8043397529928178,0.9293397529928179},"float64"), np.array({1.110132928307221},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{2.12315464629794,1.0323688280930583,-0.3267527220353009}}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic({0.3152056078485665}, np.array({0.6454099121351444},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.726273698062163}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic({{1.2169327535047745},{1.3419327535047745}}, np.array({{0.5073910190738977},{0.6323910190738977}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.2139607743109133,1.4825988807952948,0.7631396728333614},{2.6333202952008485,1.9846588188270935,0.35265951135416385}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic({{{1.0216703187938807,1.1466703187938807,1.2716703187938807}}}, {{{0.8750619302817568,1.0000619302817568,1.1250619302817568}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1,3}),"shape");check(same(x:tolist(),{{{0.4180337294828088,-0.9437427833260543,-0.11146260474054248}}}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(1.508, np.array({1.1738867528583319},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.167960464826304}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic({0.9204497578265736}, np.array({0.4140049041020382},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.9400302492914533,2.1435213273967886,0.1830396286305218}),"values")
  check(r:raw_hex()=="f2dab0aed2ac6fd2","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(0.774, 1.01, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.017093487699362}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.array({{1.196989518793984,1.321989518793984,1.446989518793984},{1.571989518793984,1.696989518793984,1.821989518793984}},"float64"), np.array({{0.3216639637443703,0.4466639637443703,0.5716639637443703},{0.6966639637443703,0.8216639637443703,0.9466639637443703}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.6153387179316525,1.4137374238746352,0.8001635533674973},{1.092606706371367,1.0726911608541858,1.3991479669926916}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(np.array({{{1.1785059129963746,1.3035059129963746,1.4285059129963749}},{{1.5535059129963749,1.6785059129963749,1.8035059129963749}}},"float64"), np.array({{{0.5777177313189314}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{3.3366952449910166,1.0211651393864045,2.865459481141709}},{{0.9543024847779898,1.2406395147459117,0.6419286606799697}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic({{{0.680559019522111}}}, np.array({{{0.3714397680637193}},{{0.4964397680637193}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{2.14249980479436,0.8750420927213344,0.3483560630307559}},{{1.694324415208511,1.1851120083744615,-0.09604052739128988}}}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(1.198, 1.564, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.11911907396253163),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(1.256, 1.623, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),2.168452442115902),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic({{1.133825111967373}}, 1.121, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{1.1868431576828902,4.445532813744476,-0.8628583732722992},{4.40306874752692,0.24647405846614723,0.7872873456631919}}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(0.34, 1.552, nil);cases=cases+1
  check(same(x,2.2501792999103065),"scalar")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.array({0.3731154609833833,0.4981154609833833,0.6231154609833833},"float64"), {0.9104173010230281,1.035417301023028,1.160417301023028}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.5571845258872303,0.7107974231832542,-0.6898727429878868}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic({0.6810032401310895}, np.array({0.6179493259460345},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{2.989486381067893}}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic({{1.156138298781773,1.281138298781773,1.406138298781773}}, {{0.3166264443698999,0.4416264443698999,0.5666264443699}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.4023406511391663,1.5123705886220198,0.8993670905530031},{1.802712069278399,1.7299821602076153,0.5197430736709291}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(np.array({{{1.0113621687695609,1.1363621687695609,1.261362168769561}}},"float64"), {{{0.645314556526966}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.5662102721383133,-0.21252829801645734,0.46802289993043733}},{{2.236411710388575,-0.8145223782754196,1.619666713837268}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic({{{0.9080917988551236}},{{1.0330917988551236}}}, {{{1.177946592360505}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,1}),"shape");check(same(x:tolist(),{{{1.5703347100574945}},{{-0.13979547353942934}}}),"values")
  check(r:raw_hex()=="0a7d3da94ecde8b8","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(0.532, {{{1.2446599480641203,1.3696599480641203,1.4946599480641205}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.5908665816474012,4.578309900820316,-2.130232680061388}},{{4.161881011279663,-0.5521830489323205,0.06995172186756143}}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(0.688, np.array({0.876201737265559},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.766416508421469}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic({1.2797552654119662}, np.array({0.326288427556173,0.451288427556173,0.576288427556173},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.7041189422349445,1.3724530677337052,0.6276968147155374}}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(np.array({0.4988489041808895},"float64"), {0.31442475394518105}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.6734504663145477}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic({1.264469340872917}, np.array({0.4875579074942769,0.6125579074942769,0.737557907494277},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{3.183436698255077,1.5852000611805386,0.604822909553953}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic({{{0.7868502093664389,0.9118502093664389,1.036850209366439}}}, {{{0.32651514649509555}},{{0.45151514649509555}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.5616130203537226,0.22934093708401526,0.6354377741977089}},{{1.643995639689217,-0.45314909701016215,1.2875495427687282}}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(np.array({{{0.6958206633952961}},{{0.8208206633952961}}},"float64"), {{{0.5975447018673194,0.7225447018673194,0.8475447018673194}},{{0.9725447018673194,1.0975447018673194,1.2225447018673194}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.0317609730023536,-0.023620684839389727,-1.9764814945350533}},{{-3.1530511376757095,2.435749045827639,3.6910554823503263}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic({0.8455846657961164,0.9705846657961164,1.0955846657961164}, {0.8678177159335496,0.9928177159335496,1.1178177159335496}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.8866283761762239,3.903610603635446,-0.8954306534838568}),"values")
  check(r:raw_hex()=="f2dab0aed2ac6fd2","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(np.array({{{1.2170007254567723,1.3420007254567723,1.4670007254567725}},{{1.5920007254567725,1.7170007254567725,1.8420007254567725}}},"float64"), np.array({{{0.9018404329745335,1.0268404329745335,1.1518404329745335}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{2.326972972164312,1.0896905310539198,3.544567561504635}},{{2.3448533674623477,-0.607420846781134,6.091611087478073}}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.9754337902849486,4.154055250469835},{1.1513904936523254,4.483916022604997},{2.4301517541050166,5.6650013352186654}},{{2.0458326458883276,2.272085544118113},{1.612475594468942,5.999688516750178},{3.8590572059773227,6.31654172281162}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{6.801786947581852,4.633461864284416,7.865470138243071},{0.22210701385640141,1.4315566566771118,1.4920266559096422}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{5.951906831812616,2.392694367810383,0.3292257889688994},{7.5315534646434905,5.762257107473896,2.8267465709751685}},{{3.6948233748294648,1.2087429400515455,0.6581293138789437},{8.073042921301116,7.224030735132686,3.0953305394903246}}}),"values")
  check(r:raw_hex()=="1c1c83485525d84a","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.48263382702806823,2.432287262301608},{1.0779621417009224,6.423781854788932},{0.732635355138477,6.416430105415654}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.421650851255038,4.253221275055315,3.6352555634740815},{-2.064541758420745,3.1035507572161527,4.760815871131966}},{{4.324894456861219,5.744052381487691,6.131208597406364},{3.0005136612288537,3.1163776462315527,-1.423201976165343}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.0354714846446367,4.21568311894097,-0.3358720909275239},{8.187272726734754,4.406321775088386,3.768150468574366}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.9230892235391301,3.8157136788488417},{3.3527699518344196,5.626096880178498},{1.3022521092898323,8.767056686215877}},{{1.8692035480005647,4.9760223433715645},{0.5616938919945769,4.850666396238478},{2.6034038954857444,7.903519810817334}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.975433790284948,5.154055250469835,5.151390493652325},{0.4839160226049969,1.4301517541050166,2.665001335218666}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{5.801786947581852,1.6334618642844163,2.8654701382430714},{5.222107013856402,4.431556656677111,2.4920266559096422}},{{2.142734903107388,1.4296118987579844,3.4673936789466904},{5.229686931475103,4.822190177193545,4.335076903558207}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{3.9519068318126167,4.392694367810383},{1.3292257889688994,6.5315534646434905},{3.762257107473897,4.8267465709751685}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.482633827028068,3.432287262301608,5.077962141700922},{2.423781854788932,-0.267364644861523,3.4164301054156536}},{{5.296248229735846,4.673764556534345,5.982778729516822},{1.2959944230334597,2.0263505487337707,5.6001856795444525}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.4216508512550377,1.2532212750553149,-1.3647444365259185},{2.935458241579255,6.103550757216153,5.760815871131966}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.035471484644637,6.21568311894097},{0.6641279090724761,7.187272726734754},{2.406321775088386,5.768150468574366}},{{2.177073860746706,3.724542183313982},{2.149271872901302,2.3273929859772213},{3.8380782015761548,6.114652698713348}}}),"values")
  check(r:raw_hex()=="54694c3ad14a9948","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.92308922353913,4.815713678848842,7.35276995183442},{1.626096880178498,0.30225210928983226,5.767056686215878}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.9754337902849484,2.154055250469835,0.1513904936523255},{5.483916022604997,4.430151754105016,3.665001335218666}},{{4.045832645888328,0.2720855441181129,0.6124755944689418},{6.999688516750178,5.859057205977322,4.31654172281162}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{3.801786947581852,3.633461864284416},{3.8654701382430714,4.222107013856402},{2.431556656677112,4.492026655909642}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{6.951906831812616,5.392694367810383,5.329225788968899},{2.5315534646434905,2.762257107473897,1.8267465709751687}},{{4.694823374829465,4.208742940051545,5.658129313878944},{3.0730429213011172,4.224030735132686,2.0953305394903246}}}),"values")
  check(r:raw_hex()=="1c1c83485525d84a","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.482633827028068,0.4322872623016081,0.0779621417009223},{7.423781854788932,2.732635355138477,4.416430105415654}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.4216508512550379,3.253221275055315},{-0.3647444365259185,1.935458241579255},{4.103550757216153,7.760815871131966}},{{1.3248944568612187,4.744052381487691},{2.131208597406365,7.000513661228854},{4.116377646231553,1.576798023834657}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.035471484644637,7.21568311894097,4.6641279090724765},{3.1872727267347547,1.406321775088386,2.768150468574366}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.9230892235391304,1.8157136788488417,2.3527699518344196},{6.626096880178498,3.3022521092898325,6.767056686215878}},{{3.8692035480005647,2.9760223433715645,-0.43830610800542313},{5.850666396238478,4.603403895485744,5.903519810817334}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.9754337902849486,4.154055250469835},{1.1513904936523254,4.483916022604997},{2.4301517541050166,5.6650013352186654}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{6.801786947581852,4.633461864284416,7.865470138243071},{0.22210701385640141,1.4315566566771118,1.4920266559096422}},{{3.142734903107388,4.429611898757984,8.46739367894669},{0.22968693147510355,1.8221901771935454,3.3350769035582064}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{5.951906831812616,2.392694367810383,0.3292257889688994},{7.5315534646434905,5.762257107473896,2.8267465709751685}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.48263382702806823,2.432287262301608},{1.0779621417009224,6.423781854788932},{0.732635355138477,6.416430105415654}},{{2.2962482297358457,3.673764556534345},{1.9827787295168215,5.295994423033459},{3.0263505487337707,8.600185679544452}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.421650851255038,4.253221275055315,3.6352555634740815},{-2.064541758420745,3.1035507572161527,4.760815871131966}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.0354714846446367,4.21568311894097,-0.3358720909275239},{8.187272726734754,4.406321775088386,3.768150468574366}},{{4.177073860746706,1.7245421833139818,1.149271872901302},{3.3273929859772213,5.838078201576154,4.114652698713348}}}),"values")
  check(r:raw_hex()=="54694c3ad14a9948","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.9230892235391301,3.8157136788488417},{3.3527699518344196,5.626096880178498},{1.3022521092898323,8.767056686215877}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.975433790284948,5.154055250469835,5.151390493652325},{0.4839160226049969,1.4301517541050166,2.665001335218666}},{{5.045832645888328,3.272085544118113,5.6124755944689415},{1.9996885167501777,2.8590572059773227,3.3165417228116203}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{5.801786947581852,1.6334618642844163,2.8654701382430714},{5.222107013856402,4.431556656677111,2.4920266559096422}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{3.9519068318126167,4.392694367810383},{1.3292257889688994,6.5315534646434905},{3.762257107473897,4.8267465709751685}},{{1.6948233748294645,3.2087429400515455},{1.6581293138789437,7.073042921301117},{5.224030735132686,5.095330539490325}}}),"values")
  check(r:raw_hex()=="1c1c83485525d84a","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.482633827028068,3.432287262301608,5.077962141700922},{2.423781854788932,-0.267364644861523,3.4164301054156536}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.4216508512550377,1.2532212750553149,-1.3647444365259185},{2.935458241579255,6.103550757216153,5.760815871131966}},{{3.3248944568612187,2.7440523814876907,1.1312085974063646},{8.000513661228855,6.116377646231553,-0.42320197616534294}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.035471484644637,6.21568311894097},{0.6641279090724761,7.187272726734754},{2.406321775088386,5.768150468574366}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.92308922353913,4.815713678848842,7.35276995183442},{1.626096880178498,0.30225210928983226,5.767056686215878}},{{4.869203548000565,5.9760223433715645,4.561693891994577},{0.8506663962384783,1.6034038954857446,4.903519810817334}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.9754337902849484,2.154055250469835,0.1513904936523255},{5.483916022604997,4.430151754105016,3.665001335218666}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{3.801786947581852,3.633461864284416},{3.8654701382430714,4.222107013856402},{2.431556656677112,4.492026655909642}},{{0.1427349031073878,3.4296118987579844},{4.46739367894669,4.229686931475103},{2.8221901771935456,6.335076903558207}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{6.951906831812616,5.392694367810383,5.329225788968899},{2.5315534646434905,2.762257107473897,1.8267465709751687}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{2.482633827028068,0.4322872623016081,0.0779621417009223},{7.423781854788932,2.732635355138477,4.416430105415654}},{{4.296248229735846,1.673764556534345,0.9827787295168215},{6.295994423033459,5.02635054873377,6.6001856795444525}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.4216508512550379,3.253221275055315},{-0.3647444365259185,1.935458241579255},{4.103550757216153,7.760815871131966}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.035471484644637,7.21568311894097,4.6641279090724765},{3.1872727267347547,1.406321775088386,2.768150468574366}},{{5.177073860746706,4.724542183313982,6.149271872901302},{-1.6726070140227787,2.8380782015761548,3.1146526987133485}}}),"values")
  check(r:raw_hex()=="54694c3ad14a9948","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.9230892235391304,1.8157136788488417,2.3527699518344196},{6.626096880178498,3.3022521092898325,6.767056686215878}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.9754337902849486,4.154055250469835},{1.1513904936523254,4.483916022604997},{2.4301517541050166,5.6650013352186654}},{{2.0458326458883276,2.272085544118113},{1.612475594468942,5.999688516750178},{3.8590572059773227,6.31654172281162}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{6.801786947581852,4.633461864284416,7.865470138243071},{0.22210701385640141,1.4315566566771118,1.4920266559096422}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{5.951906831812616,2.392694367810383,0.3292257889688994},{7.5315534646434905,5.762257107473896,2.8267465709751685}},{{3.6948233748294648,1.2087429400515455,0.6581293138789437},{8.073042921301116,7.224030735132686,3.0953305394903246}}}),"values")
  check(r:raw_hex()=="1c1c83485525d84a","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.48263382702806823,2.432287262301608},{1.0779621417009224,6.423781854788932},{0.732635355138477,6.416430105415654}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.421650851255038,4.253221275055315,3.6352555634740815},{-2.064541758420745,3.1035507572161527,4.760815871131966}},{{4.324894456861219,5.744052381487691,6.131208597406364},{3.0005136612288537,3.1163776462315527,-1.423201976165343}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.0354714846446367,4.21568311894097,-0.3358720909275239},{8.187272726734754,4.406321775088386,3.768150468574366}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.9230892235391301,3.8157136788488417},{3.3527699518344196,5.626096880178498},{1.3022521092898323,8.767056686215877}},{{1.8692035480005647,4.9760223433715645},{0.5616938919945769,4.850666396238478},{2.6034038954857444,7.903519810817334}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.975433790284948,5.154055250469835,5.151390493652325},{0.4839160226049969,1.4301517541050166,2.665001335218666}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{5.801786947581852,1.6334618642844163,2.8654701382430714},{5.222107013856402,4.431556656677111,2.4920266559096422}},{{2.142734903107388,1.4296118987579844,3.4673936789466904},{5.229686931475103,4.822190177193545,4.335076903558207}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{3.9519068318126167,4.392694367810383},{1.3292257889688994,6.5315534646434905},{3.762257107473897,4.8267465709751685}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.482633827028068,3.432287262301608,5.077962141700922},{2.423781854788932,-0.267364644861523,3.4164301054156536}},{{5.296248229735846,4.673764556534345,5.982778729516822},{1.2959944230334597,2.0263505487337707,5.6001856795444525}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.4216508512550377,1.2532212750553149,-1.3647444365259185},{2.935458241579255,6.103550757216153,5.760815871131966}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.035471484644637,6.21568311894097},{0.6641279090724761,7.187272726734754},{2.406321775088386,5.768150468574366}},{{2.177073860746706,3.724542183313982},{2.149271872901302,2.3273929859772213},{3.8380782015761548,6.114652698713348}}}),"values")
  check(r:raw_hex()=="54694c3ad14a9948","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.92308922353913,4.815713678848842,7.35276995183442},{1.626096880178498,0.30225210928983226,5.767056686215878}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.9754337902849484,2.154055250469835,0.1513904936523255},{5.483916022604997,4.430151754105016,3.665001335218666}},{{4.045832645888328,0.2720855441181129,0.6124755944689418},{6.999688516750178,5.859057205977322,4.31654172281162}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{3.801786947581852,3.633461864284416},{3.8654701382430714,4.222107013856402},{2.431556656677112,4.492026655909642}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{6.951906831812616,5.392694367810383,5.329225788968899},{2.5315534646434905,2.762257107473897,1.8267465709751687}},{{4.694823374829465,4.208742940051545,5.658129313878944},{3.0730429213011172,4.224030735132686,2.0953305394903246}}}),"values")
  check(r:raw_hex()=="1c1c83485525d84a","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.482633827028068,0.4322872623016081,0.0779621417009223},{7.423781854788932,2.732635355138477,4.416430105415654}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.4216508512550379,3.253221275055315},{-0.3647444365259185,1.935458241579255},{4.103550757216153,7.760815871131966}},{{1.3248944568612187,4.744052381487691},{2.131208597406365,7.000513661228854},{4.116377646231553,1.576798023834657}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.035471484644637,7.21568311894097,4.6641279090724765},{3.1872727267347547,1.406321775088386,2.768150468574366}}),"values")
  check(r:raw_hex()=="d3e4513345ee6d24","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.9230892235391304,1.8157136788488417,2.3527699518344196},{6.626096880178498,3.3022521092898325,6.767056686215878}},{{3.8692035480005647,2.9760223433715645,-0.43830610800542313},{5.850666396238478,4.603403895485744,5.903519810817334}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.9754337902849486,4.154055250469835},{1.1513904936523254,4.483916022604997},{2.4301517541050166,5.6650013352186654}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{6.801786947581852,4.633461864284416,7.865470138243071},{0.22210701385640141,1.4315566566771118,1.4920266559096422}},{{3.142734903107388,4.429611898757984,8.46739367894669},{0.22968693147510355,1.8221901771935454,3.3350769035582064}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{5.951906831812616,2.392694367810383,0.3292257889688994},{7.5315534646434905,5.762257107473896,2.8267465709751685}}),"values")
  check(r:raw_hex()=="b762c230a19c9846","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.48263382702806823,2.432287262301608},{1.0779621417009224,6.423781854788932},{0.732635355138477,6.416430105415654}},{{2.2962482297358457,3.673764556534345},{1.9827787295168215,5.295994423033459},{3.0263505487337707,8.600185679544452}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.421650851255038,4.253221275055315,3.6352555634740815},{-2.064541758420745,3.1035507572161527,4.760815871131966}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.0354714846446367,4.21568311894097,-0.3358720909275239},{8.187272726734754,4.406321775088386,3.768150468574366}},{{4.177073860746706,1.7245421833139818,1.149271872901302},{3.3273929859772213,5.838078201576154,4.114652698713348}}}),"values")
  check(r:raw_hex()=="54694c3ad14a9948","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.9230892235391301,3.8157136788488417},{3.3527699518344196,5.626096880178498},{1.3022521092898323,8.767056686215877}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.975433790284948,5.154055250469835,5.151390493652325},{0.4839160226049969,1.4301517541050166,2.665001335218666}},{{5.045832645888328,3.272085544118113,5.6124755944689415},{1.9996885167501777,2.8590572059773227,3.3165417228116203}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{5.801786947581852,1.6334618642844163,2.8654701382430714},{5.222107013856402,4.431556656677111,2.4920266559096422}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:logistic(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), 0.75, {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{3.9519068318126167,4.392694367810383},{1.3292257889688994,6.5315534646434905},{3.762257107473897,4.8267465709751685}},{{1.6948233748294645,3.2087429400515455},{1.6581293138789437,7.073042921301117},{5.224030735132686,5.095330539490325}}}),"values")
  check(r:raw_hex()=="1c1c83485525d84a","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:logistic(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), 0.75, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.482633827028068,3.432287262301608,5.077962141700922},{2.423781854788932,-0.267364644861523,3.4164301054156536}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:logistic(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), 0.75, {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.4216508512550377,1.2532212750553149,-1.3647444365259185},{2.935458241579255,6.103550757216153,5.760815871131966}},{{3.3248944568612187,2.7440523814876907,1.1312085974063646},{8.000513661228855,6.116377646231553,-0.42320197616534294}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(1.828, nil);cases=cases+1
  check(same(x,3.1911354106782377),"scalar")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(np.array({{{0.37585919144909913,0.5008591914490992,0.6258591914490992}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.4481343103034421,0.8612740224252288,1.233814691295499}},{{0.27829055125306407,0.3019382123724978,0.8406457770462019}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(1.084, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.2281634235658525),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh({{{1.035644599527039}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{1.2076982932660865,1.4789041879138018,0.2061253444292881}},{{0.06977088830332477,1.0865317358260984,1.869870842147131}}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh({{{0.807934636675538}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.183578206861793,0.6345791893577373,2.649098506806562}},{{0.6916478403878699,0.3880812735263639,1.5328617842545582}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(np.array({0.5241572002962278,0.6491572002962278,0.7741572002962279},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.1493773310715445,1.4031978955749531,1.690700128279792}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(np.array({0.9980908379411622},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{2.185701819833935,1.2585799769129045,0.5268659682846014}}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(np.array({1.0000116264824574,1.1250116264824574,1.2500116264824574},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.7457180045722698,1.3449896790827396,2.380230714155618}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh({{0.9778361467266574},{1.1028361467266574}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.1658672640508505,1.6814803157099356,1.9276997445986261},{0.8165528107244114,0.6648343094573343,1.4813149062700475}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.array({1.23354644251277},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.397598359745352}}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(np.array({1.1901567340993673},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.3878798355607307}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(np.array({{0.8372846554392679},{0.9622846554392679}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.2265743119955874,0.6576316867619323,2.745332889332442},{0.8237821149883949,0.4622213699296106,1.8257038464979074}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh({0.8019459413962582}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.7585153562037636}}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh({0.7631424864797411,0.8881424864797411,1.0131424864797411}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.6711924988030935,1.1199364903847928,0.5348113386658346}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(np.array({0.9701087908182202},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.6935166928830796}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(np.array({0.8988203069814582},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.0716572256831776}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh({{{0.656163577115856}},{{0.781163577115856}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.7434281414112787,0.2713740850096782,0.3691562992232962}},{{1.1626041643651719,0.3901800352013394,1.0618156660331968}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(np.array({{{0.765165959740844}},{{0.890165959740844}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.8922844999784099,1.0926597240275315,0.1522917196393206}},{{0.0599700609425896,0.9339048992793714,1.6072071186886578}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(1.307, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.9146805275407504}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(np.array({{{0.6219957322008958}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.3639186759447854,1.344486515874159,1.3583911172293486}},{{0.4652879722760874,0.25861472517258083,1.06019186811052}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(0.457, nil);cases=cases+1
  check(same(x,1.0007763759504542),"scalar")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh({{0.5750248005027652,0.7000248005027652,0.8250248005027653}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{1.0038194764237216,0.8369034680308295,1.5709848840548781},{0.7332044174837243,0.9811851219763307,0.7574491325043357}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(np.array({{0.7196604149478156,0.8446604149478156,0.9696604149478156}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8580461274924112,1.4524722428686827,1.9115821607736279},{0.5328450072451101,0.5091955186312562,1.3024350271302902}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(1.578, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.7878615151170807}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(1.076, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.2547580165510068}}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(np.array({0.5054902855016108},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.7405144655783846}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh({{{0.5684868542683288}},{{0.6934868542683288}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.2465838548796373,1.2288233993358346,1.241531819466463}},{{0.5187673733401358,0.2883394578814816,1.1820485020616813}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(np.array({0.3121696206260322},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{0.6836148394134544}}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(np.array({{{0.774226215449699}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.3515649299764403,0.9256137843757406,1.4742559018459662}},{{0.9872027794333286,1.0851890434420188,0.7108113294256344}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(0.66, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.7869134280312694),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.array({{{0.7842525263686244}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1,1}),"shape");check(same(x:tolist(),{{{0.8885519074954417}}}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(1.828, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),2.131689269753941),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(np.array({1.2267465235384283},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.7971137573430294}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh({{0.7785985480033903,0.9035985480033903,1.0285985480033903}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{1.707318950449524,1.9531903526978538,2.2463805754080686},{0.5824357320519276,0.3757001504357,1.753246460847521}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(np.array({{0.4140507872955596,0.5390507872955597,0.6640507872955597}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9067226397572921,0.6797362540956645,0.35053498914018855},{0.544435865984791,0.7323343422837171,0.4905525039309661}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(1.207, nil);cases=cases+1
  check(same(x,2.107057133855926),"scalar")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh({{0.3175108717273914,0.4425108717273914,0.5675108717273915},{0.6925108717273915,0.8175108717273915,0.9425108717273915}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.3785660128912094,0.76093865295128,1.1187871977815609},{0.512743167191788,0.49282867404368347,1.265968120246429}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh({{{0.5744995125258994,0.6994995125258994,0.8244995125258994}},{{0.9494995125258994,1.0744995125258994,1.1994995125258994}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.6509034023438395,0.2892968259695327,0.4638617554685324}},{{1.4131381949488804,0.5366971398859753,1.6304490008374843}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh({{{0.8289483778870206}},{{0.9539483778870206}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.9666632179002718,1.1837412449998108,0.16498639589690703}},{{0.06426705237596854,1.000821312047999,1.7223671687556767}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(0.513, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.7515157694172953,0.402927550525667,1.682051334726386}}),"values")
  check(r:raw_hex()=="4fd42fa03fcd72a9","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(1.317, nil);cases=cases+1
  check(same(x,2.8879312240025294),"scalar")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(1.964, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),4.300929545660157),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(np.array({0.7035832732170941},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.2282437076170516}}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(np.array({0.6608917620455632,0.7858917620455632,0.9108917620455632},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.7879766697407578,1.3514140713470784,1.7957260251937415}),"values")
  check(r:raw_hex()=="2c4b5eeb383c1bce","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh({0.9007130793638143,1.0257130793638143,1.1507130793638143}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.0205007926217746,0.4242112151642137,0.6473888473251616}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(np.array({0.8571960584342544,0.9821960584342544,1.1071960584342544},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.999603741706604,1.4025794802910319,0.22036630036958196}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(0.318, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.4658518804575047,0.24976795529661228,1.0426750963800988}},{{0.27222995928032095,0.152747313185119,0.6033285680122497}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(0.768, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.6840783447486276),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(np.array({0.9128117720209736},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.9989506720526524,1.1510441487728689,0.4818493866945647}}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh({0.9330561489747697}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.6288339809324162}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(1.473, nil);cases=cases+1
  check(same(x,1.7562476961970603),"scalar")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.array({{0.4265083402613294}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.4832305750505017,0.17639398866996003,0.23995272820658675},{0.6347714960739358,0.21303481638410923,0.5797418756457589}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(1.853, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),2.1608425693949957),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh({0.805740790537034,0.930740790537034,1.0557407905370342}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.180364347273565,0.7310352961119103,3.4616183349861758}),"values")
  check(r:raw_hex()=="4fd42fa03fcd72a9","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh({{{0.6931793518110034,0.8181793518110034,0.9431793518110034}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{1.5200108534007828,1.7685508905087783,2.059831582639204}},{{0.5185373441173748,0.34018437306920524,1.6076494213577774}}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(1.856, nil);cases=cases+1
  check(same(x,4.064422218302063),"scalar")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh({{{1.0961351500757,1.2211351500757,1.3461351500757002}},{{1.4711351500757002,1.5961351500757002,1.7211351500757002}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.9135206194177627,1.4599086222355402,2.5632659422785213}},{{1.8758195990990099,2.2372122541843407,1.5801613788495914}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(np.array({{{0.4354058517728589}},{{0.560405851772859}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.519131380914326,0.7487209094814098,0.858356230815338}},{{0.41493106185333817,0.3378353516840274,0.7527297180601497}}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(1.637, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.854708048318543),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(1.731, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),2.0185744671466477),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(np.array({0.5757920475616156},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.8435025412234453}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh({0.5034325966734023}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.1039322058570922,1.0882041513112632,1.099458295356886}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(0.818, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.791324016471491),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh({0.44527772675632876,0.5702777267563288,0.6952777267563288}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.7773203071326199,0.6817864265956447,1.323924806004143}}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(1.181, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.4080981189468624),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(1.486, nil);cases=cases+1
  check(same(x,1.6836262430063256),"scalar")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(np.array({1.0825527810199438,1.2075527810199438,1.3325527810199438},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.2623994240932723,1.7243896852191594,0.26521926641956134}}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(1.965, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),2.8786130349025054),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(np.array({{1.026084930902795,1.151084930902795,1.276084930902795}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.2500096510498557,2.4881491754751903,2.786871911218698},{0.7675695381276496,0.4786005717472941,2.175087057228477}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(1.682, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{3.6833826353362444,2.1209808172713625,0.8878836724748502}}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(np.array({0.6786819427562547,0.8036819427562547,0.9286819427562548},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.184773512099226,0.9608291086307125,1.76836537916887}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(np.array({0.30809187580702774},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.36733580930286713}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.array({1.0658836730195718},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.2076377684305009}}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh({1.1353223303363764}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.323935683419088,1.6212443436033068,0.2259642994186615}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh({{{0.7459130856318565,0.8709130856318565,0.9959130856318567}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.0927201685517614,0.6840445932054472,3.265452114928924}},{{0.6385531098371663,0.4183321819120363,1.8895057101224182}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(np.array({1.2668743697050087},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.7780152233558226}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh({{0.8377834898615879},{0.9627834898615879}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.8346475378879736,1.0564344298591468,0.4422439249209888},{1.2659651403693255,1.3080018254807133,0.7112345331574521}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(np.array({0.3006422170331378},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.5248304292774935}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(np.array({0.7972788007293097},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{0.9505899911796369}}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.array({0.7004553183161506},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.7936103337620595}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(np.array({{0.5885852569593979},{0.7135852569593979}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1}),"shape");check(same(x:tolist(),{{0.686368094417787},{1.019002296186113}}),"values")
  check(r:raw_hex()=="0a7d3da94ecde8b8","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(np.array({{{0.6190230071003844,0.7440230071003844,0.8690230071003844}},{{0.9940230071003844,1.1190230071003844,1.2440230071003844}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.9068334336609224,0.5843808338902511,2.849398263160115}},{{0.8509523356812574,0.5375086720972203,2.360234652352728}}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(np.array({0.6293633951219961},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.3800745634146194}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh({{0.38347124130901517}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8397570222285738,0.4835524059403442,0.20242440786084298},{0.5042267850907559,0.5209697600066402,0.2832807086574943}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(0.855, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.492571540552458}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh({0.8862735773000561}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.0566978467980657}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(0.446, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.5053144713195298),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(1.307, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{1.524134505234355,1.8664006691929584,0.2601334717451455},{0.08805197367329548,1.3712203775052219,2.359806821570254}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(1.2, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.7579316243679421,0.9425205860249519,3.93462300520792}),"values")
  check(r:raw_hex()=="4fd42fa03fcd72a9","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(0.582, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.2762156206298192,1.2580329923968465,1.271043496440155},{0.43536890342716866,0.2419852134963335,0.9920191334062565}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(np.array({0.749591999557069},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.6415185224467788}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(0.395, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.6895505947581531),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh({{{0.46994786409765094,0.5949478640976509,0.719947864097651}},{{0.844947864097651,0.969947864097651,1.094947864097651}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.5603155829288722,1.0230682570926866,1.4193004813651295}},{{0.625609303242697,0.5847238688639103,1.470719469515548}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.array({{{1.2391979871713275,1.3641979871713275,1.4891979871713275}},{{1.6141979871713275,1.7391979871713275,1.8641979871713275}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{1.4040015151293828,0.5642007472708251,0.8378197707518935}},{{2.402407583984078,0.8687045219927894,2.5339566325843856}}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh({{{0.43800149024627805,0.5630014902462781,0.6880014902462781}},{{0.8130014902462781,0.9380014902462781,1.063001490246278}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.5107675475351348,0.8039681393667072,0.1369336007831662}},{{0.054771527020287133,0.9840908627054034,1.9192640918305377}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(0.867, nil);cases=cases+1
  check(same(x,1.2701055986058383),"scalar")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(0.51, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{1.1183332758096356,1.1024000448838347,1.1138010020351874},{0.3815088329000963,0.21204889842462216,0.8692951169023898}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(np.array({{{0.6061994705158043,0.7311994705158043,0.8561994705158044}},{{0.9811994705158044,1.1061994705158043,1.2311994705158043}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.3275057094220803,0.9220333237592141,0.4519652379623036}},{{1.2901803349374268,1.5028414404867725,0.9095207695781103}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(1.89, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),3.2993686685896435),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(np.array({{1.251573757120976,1.376573757120976,1.501573757120976}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{1.4922427206818827,2.3671467693951316,2.9601926230563573},{0.926679880995364,0.8298544311854578,2.0168939836522464}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh({0.3720022558016058}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.4214756126010334}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(np.array({1.0813170204174227,1.2063170204174227,1.3313170204174227},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.2609583641280762,1.7226250146640654,0.2649733117938692}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh({{{0.921504657292161}},{{1.046504657292161}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{1.3499518158801938,0.7237809246797752,3.021477853323314}},{{0.8958802523311674,0.5026753919405388,1.985491057554181}}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(np.array({0.7478040059098781,0.8728040059098781,0.9978040059098782},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.6397923599858077,1.8866258339016477,2.179127650229699}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(np.array({{{0.3048582696584487,0.4298582696584487,0.5548582696584488}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.6676038387030823,0.5420458645012071,0.2928951237618218}},{{0.40085849643764804,0.5839894507248591,0.40988900053303995}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(0.815, nil);cases=cases+1
  check(same(x,1.4227436322225182),"scalar")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh({0.8226031390288282}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.9807840243067547}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.array({{{1.1899224874725405,1.3149224874725405,1.4399224874725407}},{{1.5649224874725407,1.6899224874725407,1.8149224874725407}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.3481727638305079,0.5438215398437236,0.8100974744441072}},{{2.3290709579185136,0.8440921145914844,2.4669777064483736}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(0.976, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.1381448179867868}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(1.079, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.5806735189108414,0.8474830936007693,3.537881852182788}},{{0.9236985096335418,0.5182841224111427,2.0471431600164065}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh({{{0.880992982482536,1.005992982482536,1.1309929824825362}},{{1.2559929824825362,1.3809929824825362,1.5059929824825362}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.931850525617638,2.17452295890504,2.4700021905564977}},{{0.9395537585835754,0.5741922366030496,2.566965383845755}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(1.309, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.8665564028865305}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(0.336, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.5865544299714923),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(np.array({0.8508755047709524},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.0144929701320407}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.array({{1.283507969286636},{1.408507969286636}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{1.4542043742925552,0.5308292214249057,0.722098983378657},{2.0962795483631567,0.7035295873198637,1.9145488490937956}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(np.array({{{0.511092137974148,0.636092137974148,0.761092137974148}},{{0.886092137974148,1.011092137974148,1.136092137974148}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.5960008897019102,0.9083418454348351,0.15148090296032934}},{{0.059695609491211776,1.0607728715573628,2.0512302808903815}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh({{1.0959120052641051},{1.2209120052641051}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.605448642981881,0.8607663545277539,3.5933338229964096},{1.0451849857795672,0.5864497749671318,2.3163870811476626}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh({0.658768296041514}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.4445539343365452}}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh({{0.6188866770581731}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.3552892030422266,0.7804083056511307,0.3266940402331554},{0.8137748177498264,0.8407964115319007,0.45718853872132453}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh({0.3158973645787651}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.5514613053868875,0.37766604807128334,0.6015212928915457}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh({{0.8858307739254596,1.0108307739254596,1.1358307739254596}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.056169895401933,1.7382176498171829,2.2391693129088517}}),"values")
  check(r:raw_hex()=="2c4b5eeb383c1bce","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.array({0.3573534482199792},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.4048786295100667}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(np.array({0.3710325309137736,0.4960325309137736,0.6210325309137736},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.4326729020123296,0.7083362261965905,0.12360470415705765}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh({0.6386238510325475,0.7636238510325475,0.8886238510325476}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.9355475531714641,0.5997759996481894,2.9136665393742645}}),"values")
  check(r:raw_hex()=="4fd42fa03fcd72a9","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh({0.7650469628403789,0.8900469628403789,1.0150469628403789}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.6776028943166537,1.9238976701646167,2.2167849496556618}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh({{0.3608737126563126,0.4858737126563126,0.6108737126563126}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.7902710860568272,0.6126806326756582,0.32246420654674984}}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh({0.48885020566543186}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{0.8533846837069468}}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh({1.0287225868844656}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.2265388141491669}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(1.466, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.6609664012431178),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(np.array({0.6261237482883188},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.730142929849194,0.8941069493518912,0.12461801406604744}}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(np.array({0.8554468655676122},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.2531809149564477}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(0.293, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.6424934310043592),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(np.array({{{1.0637498604656326,1.1887498604656326,1.3137498604656326}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{2.3294873747803,1.4989986031995337,0.6934940849129297}},{{1.3987259395316651,1.6149913286864994,0.9705030035654967}}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh({0.5490156384816964,0.6740156384816964,0.7990156384816964}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.9584153418900783,0.8058086298474184,1.5214590996698105}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(0.33, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.3934567140156347),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh({{{0.3617373590315996}},{{0.4867373590315996}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,1}),"shape");check(same(x:tolist(),{{{0.40984556577483333}},{{0.20130331833994095}}}),"values")
  check(r:raw_hex()=="39ee1852018c694c","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(1.785, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),2.081545594371326),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(1.029, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.5074263678955102,0.8082114025163963,3.373939226965791}},{{0.8808950569165103,0.4942672492688284,1.9522801776245435}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(np.array({1.2323525242997646,1.3573525242997646,1.4823525242997646},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{2.702315363632214,2.934010752374994,3.2373445626166024}}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh({0.6447904973793381}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.4120155300100323}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh({1.2986062048824205,1.4236062048824205,1.5486062048824205}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{2.266973875780509,1.7019696575330108,2.948804615014382}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh({1.166288550033283}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.3905577590610747}}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.array({1.0627023609549904},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.204033367031361,0.4395091268390618,0.5978741954412632}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh({{{0.5448302565971499}},{{0.6698302565971499}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.6353439889635836,0.7780195527999173,0.10843809193604827}},{{0.045126148522929614,0.7027428441588092,1.209387917989371}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(np.array({0.4062135559056688},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{0.5950797134779419}}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(np.array({0.5692617644415308,0.6942617644415308,0.8192617644415309},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.248283085923667,1.500694510355831,1.7892050473805738}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh({{{0.8992721133305501}},{{1.0242721133305501}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.9693004082543852,1.1339708096796526,0.47470215608688976}},{{1.34681660350793,1.3915379814188062,0.7566578633952077}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh({1.085340859546678}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.8946770511790807}}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(1.335, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.5917112521541585,2.2956568224515275,2.6318102144760984}),"values")
  check(r:raw_hex()=="2c4b5eeb383c1bce","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.array({{{0.4975016206756841,0.6225016206756842,0.7475016206756842}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.5636654000725169,0.2574522780896114,0.42054289749662416}},{{0.7404306510442807,0.3109306570141148,1.0160598298106887}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(np.array({0.7110622894053302,0.8360622894053302,0.9610622894053303},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.8291924794595261,1.1938999360620546,0.19128115524586564}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(np.array({{0.6560113483739325}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9610192460423259,0.5152535004236815,2.150964452491285},{0.5615910146391953,0.31510682667630585,1.2446238597931751}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(0.649, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.4231339137263794,1.4028580963325663,1.417366373178111}},{{0.48548869127875,0.26984261779917607,1.1062206487640216}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(np.array({0.861676176306805,0.986676176306805,1.1116761763068053},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.8869697176524485,1.2441862323456543,0.5868246884792422}}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh({0.9851626266749596}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.7197961396385384}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(1.28, nil);cases=cases+1
  check(same(x,1.5261351331515527),"scalar")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh({{{0.557809493312718}},{{0.682809493312718}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.6319937426240602,0.23069710989265013,0.3138224909222395}},{{1.0162239813130756,0.3410535769220227,0.9281254760910393}}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(np.array({{1.2009041980939228,1.3259041980939228,1.450904198093923}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.4004127970893196,1.8933959316053943,0.28877486321329654},{0.08090434952923957,1.3910534468600668,2.619627868482753}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh({0.685321905077545}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.0039575415065844,0.5382750029911869,2.2470694447425226}),"values")
  check(r:raw_hex()=="4fd42fa03fcd72a9","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh({{0.4080674653990652,0.5330674653990652,0.6580674653990652}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.8948145594726895,1.1522619564353755,1.4371690242514408},{0.30525753425274077,0.22163993887034739,1.121676145615176}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(np.array({{{0.6184909100343765}},{{0.7434909100343765}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,1}),"shape");check(same(x:tolist(),{{{1.3544225196991284}},{{0.9375326741965166}}}),"values")
  check(r:raw_hex()=="3e6f74f5cba0e8f3","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(np.array({1.1176142930153903,1.2426142930153903,1.3676142930153903},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.9510167100227218,1.4855876684688254,2.6041658144522355}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(np.array({{{0.42774958778033406}},{{0.5527495877803341}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.5100028703927046,0.7355552505533727,0.8432627223657106}},{{0.4092622742448615,0.33321984556410067,0.7424459256653065}}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(1.717, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.9453474153713735,0.7101115030030793,0.9659807216859354}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh({1.2978748780300244}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.51349340863228,1.8533699624207858,0.25831728991029657}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(np.array({{0.9464693243034152}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.3865236305726094}}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(np.array({0.43945867488149254},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.9636495283591787}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh({{{0.6835407326585141,0.8085407326585141,0.9335407326585141}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.4968739983468402,1.0195596813027596,0.4927916611876955}},{{0.8987885113117079,1.0984533547047937,0.6896321074962528}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(1.039, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.8137799188701798}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh({{{1.252785498396433}},{{1.377785498396433}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.4936874714106052,2.1542813306832276,2.46973308706162}},{{1.020128533717517,0.8305849179186869,1.850623233990894}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.array({{1.1994656070268082,1.3244656070268082,1.4494656070268084},{1.5744656070268084,1.6994656070268084,1.8244656070268084}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.3589850427818617,0.547768353454684,0.8154664141728006},{2.343273963357899,0.8488587663308838,2.479949424718907}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(0.841, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.9807169999250899}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(1.7, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),2.490403134521251),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(0.347, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.760905189619497,0.7500643442640993,0.7578214660906079},{0.2595756176790851,0.14427640735949782,0.5914615795394691}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(np.array({0.6317529844879681},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.3834649065902673}}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.7456977082484888,4.782136103919499},{3.8083337206288324,6.375415606793454},{4.204930116497158,5.508555369797978}},{{0.6130125723812069,3.4288727763154467},{3.5222030202775376,6.859008976449125},{5.545053318634169,19.542172374710663}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.769172291098602,8.59796562715928,11.82836051449932},{0.7404117222200529,1.205681027831084,4.0295602678605285}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.3989762644811417,0.8271537600501797,0.5625979741909932},{8.929787806986374,2.4974284940545237,5.437097668857218}},{{4.507090765282421,2.466486842542344,1.1845541959198622},{5.395099705191066,8.582849514541786,7.416686972549911}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.1661319856421997,5.712014289802474},{0.39806193075003143,0.33684764220847546},{3.147407140409844,10.833084108203154}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{5.859772081226474,3.9271691084373,19.6731150260396},{0.856069054340632,0.9606749256925723,5.691778943511789}},{{3.9945526822589743,5.25081601669544,1.4626577936359082},{1.236176791500026,2.886462768646088,2.0373600183291587}}}),"values")
  check(r:raw_hex()=="c9d676a873e2d50a","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{6.578431034174327,4.323137430916999,2.183923533402328},{4.488339210589368,2.0789107688688446,6.818000916881489}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{2.1898826607230943,5.0439496249021705},{1.0557475296966115,6.5745058660661275},{4.075688374139304,4.432364331006761}},{{2.461029221594952,2.9641854331809867},{3.8421323139308003,6.096015625881544},{7.9640179743629105,9.308175278367719}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{6.982790832993955,5.977670129899374,11.425001161886497},{1.2750831213586908,2.8032867443314387,2.754277684898989}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.5768792183239517,3.439186250863712,1.9713934190832199},{4.442470333320317,3.0142025695777104,5.372747023814037}},{{3.983788813020277,2.8057574234597626,1.3591753046862616},{7.1456193005036805,1.2232066931823529,1.5898309194975355}}}),"values")
  check(r:raw_hex()=="a87f366a5c2e4ff0","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.1329920881603806,1.6543075201003594},{1.1251959483819864,7.441489839155312},{1.4984570964327142,8.155646503285826}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.664527942568799,7.140017862253093,1.1941857922500942},{0.0673695284416951,2.098271426939896,5.416542054101577}},{{4.642699051774885,6.145328948987968,14.241088107776463},{3.4807335664892745,5.1275165590322525,0.15224817249087452}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.3948290609198555,1.57086764337492,3.2788525043399335},{5.136414326043791,2.4016873142314306,7.589038591349052}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{2.1928103447247755,8.646274861833998},{4.367847066804656,3.74028267549114},{1.2473464613213068,10.227001375322233}},{{1.6792621559825456,9.99887346702537},{0.7964631676782503,7.233812433783324},{1.1259900187659515,8.854925251955834}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{8.759530642892377,6.304937031127713,3.1672425890898346},{1.3149011732132254,2.717125582759536,2.2161821655033807}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{5.237093124745466,2.3910680519597496,1.9041668603144162},{7.6504987281521455,7.008216860828597,3.672370246531986}},{{1.8390377171436207,1.7144363881577234,1.7611015101387688},{8.230810771738952,9.241755531056947,13.028114916473776}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.1922930727746506,6.878372501727424},{3.9427868381664397,3.7020586111002647},{1.808521541746626,8.059120535721057}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.531968352641522,2.0678844001254495,3.3755878451459593},{1.4882979678310624,0.9989713976218094,4.077823251642913}},{{6.009454353709895,6.166217106355861,7.107325175519174},{0.8991832841985109,3.433139805816715,5.562515229412433}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.4983959569265988,2.856007144901237,0.19903096537501572},{0.4042171706501706,5.2456785673497395,7.2220560721354365}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.4649430203066185,3.14173528674984},{6.557705008679867,4.28034527170316},{1.4410123885388584,11.383557887023578}},{{0.9986381705647436,4.200652813356352},{0.48755259787863603,6.1808839575001295},{4.329694152969132,4.074720036658317}}}),"values")
  check(r:raw_hex()=="c9d676a873e2d50a","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{8.771241378899102,10.807843577292498,13.103541200413968},{0.748056535098228,0.8315643075475379,5.113500687661117}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{6.569647982169283,2.5219748124510852,0.5278737648483057},{7.8894070392793525,6.79281395689884,2.954909554004508}},{{7.383087664784856,1.4820927165904934,1.9210661569654002},{7.315218751057854,13.273363290604852,6.205450185578479}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.7456977082484888,4.782136103919499},{3.8083337206288324,6.375415606793454},{4.204930116497158,5.508555369797978}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.769172291098602,8.59796562715928,11.82836051449932},{0.7404117222200529,1.205681027831084,4.0295602678605285}},{{5.311718417360369,7.014393558649407,8.15505182811757},{1.1909365500839468,0.48928267727294117,1.1923731896231518}}}),"values")
  check(r:raw_hex()=="a87f366a5c2e4ff0","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.3989762644811417,0.8271537600501797,0.5625979741909932},{8.929787806986374,2.4974284940545237,5.437097668857218}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.1661319856421997,5.712014289802474},{0.39806193075003143,0.33684764220847546},{3.147407140409844,10.833084108203154}},{{1.1606747629437213,4.9162631591903745},{4.747029369258821,17.403667832446374},{7.691274838548379,0.30449634498174905}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{5.859772081226474,3.9271691084373,19.6731150260396},{0.856069054340632,0.9606749256925723,5.691778943511789}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{6.578431034174327,4.323137430916999,2.183923533402328},{4.488339210589368,2.0789107688688446,6.818000916881489}},{{5.037786467947637,4.999436733512685,0.39823158383912516},{8.68057492053999,1.8766500312765857,5.903283501303889}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{2.1898826607230943,5.0439496249021705},{1.0557475296966115,6.5745058660661275},{4.075688374139304,4.432364331006761}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{6.982790832993955,5.977670129899374,11.425001161886497},{1.2750831213586908,2.8032867443314387,2.754277684898989}},{{2.4520502895248275,4.286090970394309,10.566609060832613},{1.3718017952898252,3.696702212422779,9.771086187355332}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.5768792183239517,3.439186250863712,1.9713934190832199},{4.442470333320317,3.0142025695777104,5.372747023814037}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.1329920881603806,1.6543075201003594},{1.1251959483819864,7.441489839155312},{1.4984570964327142,8.155646503285826}},{{1.5023635884274738,4.932973685084688},{2.3691083918397244,4.495916420992555},{5.149709708725072,11.125030458824867}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.664527942568799,7.140017862253093,1.1941857922500942},{0.0673695284416951,2.098271426939896,5.416542054101577}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.3948290609198555,1.57086764337492,3.2788525043399335},{5.136414326043791,2.4016873142314306,7.589038591349052}},{{2.995914511694231,2.100326406678176,0.24377629893931801},{7.417060749000155,7.2161569216152195,2.7164800244388783}}}),"values")
  check(r:raw_hex()=="c9d676a873e2d50a","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{2.1928103447247755,8.646274861833998},{4.367847066804656,3.74028267549114},{1.2473464613213068,10.227001375322233}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{8.759530642892377,6.304937031127713,3.1672425890898346},{1.3149011732132254,2.717125582759536,2.2161821655033807}},{{9.844116886379808,3.7052317914762334,11.5263969417924},{1.219203125176309,5.309345316241941,4.654087639183859}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{5.237093124745466,2.3910680519597496,1.9041668603144162},{7.6504987281521455,7.008216860828597,3.672370246531986}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.1922930727746506,6.878372501727424},{3.9427868381664397,3.7020586111002647},{1.808521541746626,8.059120535721057}},{{1.3279296043400923,5.611514846919525},{2.718350609372523,5.954682750419734},{0.7339240159094118,2.3847463792463035}}}),"values")
  check(r:raw_hex()=="a87f366a5c2e4ff0","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.531968352641522,2.0678844001254495,3.3755878451459593},{1.4882979678310624,0.9989713976218094,4.077823251642913}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.4983959569265988,2.856007144901237,0.19903096537501572},{0.4042171706501706,5.2456785673497395,7.2220560721354365}},{{3.482024288831164,2.4581315795951872,2.3735146846294106},{20.884401398935648,12.81879139758063,0.20299756332116603}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.4649430203066185,3.14173528674984},{6.557705008679867,4.28034527170316},{1.4410123885388584,11.383557887023578}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{8.771241378899102,10.807843577292498,13.103541200413968},{0.748056535098228,0.8315643075475379,5.113500687661117}},{{6.717048623930182,12.498591833781711,2.389389503034751},{1.4467624867566649,0.7506600125106343,4.427462625977917}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{6.569647982169283,2.5219748124510852,0.5278737648483057},{7.8894070392793525,6.79281395689884,2.954909554004508}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.7456977082484888,4.782136103919499},{3.8083337206288324,6.375415606793454},{4.204930116497158,5.508555369797978}},{{0.6130125723812069,3.4288727763154467},{3.5222030202775376,6.859008976449125},{5.545053318634169,19.542172374710663}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.769172291098602,8.59796562715928,11.82836051449932},{0.7404117222200529,1.205681027831084,4.0295602678605285}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.3989762644811417,0.8271537600501797,0.5625979741909932},{8.929787806986374,2.4974284940545237,5.437097668857218}},{{4.507090765282421,2.466486842542344,1.1845541959198622},{5.395099705191066,8.582849514541786,7.416686972549911}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.1661319856421997,5.712014289802474},{0.39806193075003143,0.33684764220847546},{3.147407140409844,10.833084108203154}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{5.859772081226474,3.9271691084373,19.6731150260396},{0.856069054340632,0.9606749256925723,5.691778943511789}},{{3.9945526822589743,5.25081601669544,1.4626577936359082},{1.236176791500026,2.886462768646088,2.0373600183291587}}}),"values")
  check(r:raw_hex()=="c9d676a873e2d50a","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{6.578431034174327,4.323137430916999,2.183923533402328},{4.488339210589368,2.0789107688688446,6.818000916881489}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{2.1898826607230943,5.0439496249021705},{1.0557475296966115,6.5745058660661275},{4.075688374139304,4.432364331006761}},{{2.461029221594952,2.9641854331809867},{3.8421323139308003,6.096015625881544},{7.9640179743629105,9.308175278367719}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{6.982790832993955,5.977670129899374,11.425001161886497},{1.2750831213586908,2.8032867443314387,2.754277684898989}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{3.5768792183239517,3.439186250863712,1.9713934190832199},{4.442470333320317,3.0142025695777104,5.372747023814037}},{{3.983788813020277,2.8057574234597626,1.3591753046862616},{7.1456193005036805,1.2232066931823529,1.5898309194975355}}}),"values")
  check(r:raw_hex()=="a87f366a5c2e4ff0","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.1329920881603806,1.6543075201003594},{1.1251959483819864,7.441489839155312},{1.4984570964327142,8.155646503285826}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.664527942568799,7.140017862253093,1.1941857922500942},{0.0673695284416951,2.098271426939896,5.416542054101577}},{{4.642699051774885,6.145328948987968,14.241088107776463},{3.4807335664892745,5.1275165590322525,0.15224817249087452}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.3948290609198555,1.57086764337492,3.2788525043399335},{5.136414326043791,2.4016873142314306,7.589038591349052}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{2.1928103447247755,8.646274861833998},{4.367847066804656,3.74028267549114},{1.2473464613213068,10.227001375322233}},{{1.6792621559825456,9.99887346702537},{0.7964631676782503,7.233812433783324},{1.1259900187659515,8.854925251955834}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{8.759530642892377,6.304937031127713,3.1672425890898346},{1.3149011732132254,2.717125582759536,2.2161821655033807}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{5.237093124745466,2.3910680519597496,1.9041668603144162},{7.6504987281521455,7.008216860828597,3.672370246531986}},{{1.8390377171436207,1.7144363881577234,1.7611015101387688},{8.230810771738952,9.241755531056947,13.028114916473776}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.1922930727746506,6.878372501727424},{3.9427868381664397,3.7020586111002647},{1.808521541746626,8.059120535721057}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.531968352641522,2.0678844001254495,3.3755878451459593},{1.4882979678310624,0.9989713976218094,4.077823251642913}},{{6.009454353709895,6.166217106355861,7.107325175519174},{0.8991832841985109,3.433139805816715,5.562515229412433}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.4983959569265988,2.856007144901237,0.19903096537501572},{0.4042171706501706,5.2456785673497395,7.2220560721354365}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.4649430203066185,3.14173528674984},{6.557705008679867,4.28034527170316},{1.4410123885388584,11.383557887023578}},{{0.9986381705647436,4.200652813356352},{0.48755259787863603,6.1808839575001295},{4.329694152969132,4.074720036658317}}}),"values")
  check(r:raw_hex()=="c9d676a873e2d50a","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{8.771241378899102,10.807843577292498,13.103541200413968},{0.748056535098228,0.8315643075475379,5.113500687661117}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{6.569647982169283,2.5219748124510852,0.5278737648483057},{7.8894070392793525,6.79281395689884,2.954909554004508}},{{7.383087664784856,1.4820927165904934,1.9210661569654002},{7.315218751057854,13.273363290604852,6.205450185578479}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.7456977082484888,4.782136103919499},{3.8083337206288324,6.375415606793454},{4.204930116497158,5.508555369797978}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.769172291098602,8.59796562715928,11.82836051449932},{0.7404117222200529,1.205681027831084,4.0295602678605285}},{{5.311718417360369,7.014393558649407,8.15505182811757},{1.1909365500839468,0.48928267727294117,1.1923731896231518}}}),"values")
  check(r:raw_hex()=="a87f366a5c2e4ff0","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.3989762644811417,0.8271537600501797,0.5625979741909932},{8.929787806986374,2.4974284940545237,5.437097668857218}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.1661319856421997,5.712014289802474},{0.39806193075003143,0.33684764220847546},{3.147407140409844,10.833084108203154}},{{1.1606747629437213,4.9162631591903745},{4.747029369258821,17.403667832446374},{7.691274838548379,0.30449634498174905}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{5.859772081226474,3.9271691084373,19.6731150260396},{0.856069054340632,0.9606749256925723,5.691778943511789}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{6.578431034174327,4.323137430916999,2.183923533402328},{4.488339210589368,2.0789107688688446,6.818000916881489}},{{5.037786467947637,4.999436733512685,0.39823158383912516},{8.68057492053999,1.8766500312765857,5.903283501303889}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{2.1898826607230943,5.0439496249021705},{1.0557475296966115,6.5745058660661275},{4.075688374139304,4.432364331006761}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{6.982790832993955,5.977670129899374,11.425001161886497},{1.2750831213586908,2.8032867443314387,2.754277684898989}},{{2.4520502895248275,4.286090970394309,10.566609060832613},{1.3718017952898252,3.696702212422779,9.771086187355332}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.5768792183239517,3.439186250863712,1.9713934190832199},{4.442470333320317,3.0142025695777104,5.372747023814037}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:rayleigh(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.1329920881603806,1.6543075201003594},{1.1251959483819864,7.441489839155312},{1.4984570964327142,8.155646503285826}},{{1.5023635884274738,4.932973685084688},{2.3691083918397244,4.495916420992555},{5.149709708725072,11.125030458824867}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:rayleigh(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.664527942568799,7.140017862253093,1.1941857922500942},{0.0673695284416951,2.098271426939896,5.416542054101577}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:rayleigh(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{4.3948290609198555,1.57086764337492,3.2788525043399335},{5.136414326043791,2.4016873142314306,7.589038591349052}},{{2.995914511694231,2.100326406678176,0.24377629893931801},{7.417060749000155,7.2161569216152195,2.7164800244388783}}}),"values")
  check(r:raw_hex()=="c9d676a873e2d50a","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull({{{1.0140550029284339}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1,1}),"shape");check(same(x:tolist(),{{{0.7141525865651087}}}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.array({{{0.47093117641763754}},{{0.5959311764176376}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.39000797902943213,0.00539918114700072,0.019947680773836875}},{{1.1869187197790174,0.03041398700455885,0.8754852878780223}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull({0.43700334108255484}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.4136457871602586}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull({1.2424546712992854,1.3674546712992854,1.4924546712992854}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.0583709160397912,0.4231081442613441,3.0860596886125564}}),"values")
  check(r:raw_hex()=="4fd42fa03fcd72a9","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(1.542, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.7662966660056654),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull({0.9068193170911314}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.623248535656013}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(0.313, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{3.840350717127291}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(np.array({{0.480360131511076,0.6053601315110759,0.730360131511076},{0.855360131511076,0.980360131511076,1.105360131511076}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.4913017774052235,1.9077855244540158,2.4833237937902655},{0.2202263466967076,0.17560532721225813,0.9109802229419234}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.array({0.8476091960339553},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.5926532496227617}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull({{0.7790978778479529}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.609485492131817,1.025223139189774,0.006514729273578341},{0.0004038306018416274,0.46461542145279866,1.8721041714368747}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(np.array({{0.4167679813261133,0.5417679813261134,0.6667679813261134}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.1842671119500452,0.11406201362589158,12.458167643523632}}),"values")
  check(r:raw_hex()=="4fd42fa03fcd72a9","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull({{0.5082534306126643,0.6332534306126643,0.7582534306126643},{0.8832534306126643,1.0082534306126643,1.1332534306126643}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{5.617864057992023,3.818812247727899,3.1461681921230156},{0.2364412117119511,0.08818723260460423,1.3902601923460598}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull({1.2357927520724412}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{2.029282680354413}}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(0.554, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),2.1387449810129717),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull({0.5128806520496141,0.6378806520496141,0.7628806520496141}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.5139480115944106,1.8459823850154728,2.3888761695231877}),"values")
  check(r:raw_hex()=="2c4b5eeb383c1bce","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(0.445, nil);cases=cases+1
  check(same(x,0.3691853009743471),"scalar")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(0.252, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.21636162625204788),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(np.array({1.2642470780383634},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.0573364454984702,0.3944178055428616,3.7822136552385444}),"values")
  check(r:raw_hex()=="4fd42fa03fcd72a9","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull({{0.40613941640604495,0.531139416406045,0.656139416406045}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{8.670276162218245,4.940907466842818,3.760546887974792},{0.04345120277624208,0.009955901499014043,1.7666434022773445}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull({0.7102895717107136}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{3.425531461638976}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull({0.5110104978674923}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.2799961321099524}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull({{{1.0293380805011998,1.1543380805011998,1.2793380805011998}},{{1.4043380805011998,1.5293380805011998,1.6543380805011998}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.7177312381365168,1.4031878966608078,1.6808161915194928}},{{0.39787995480708366,0.327885169630393,0.9396055165431297}}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(1.918, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.7935883542915336),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull({0.5357506168704507}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.4867321022659253}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(np.array({{{1.1108584000365853,1.2358584000365853,1.3608584000365853}},{{1.4858584000365853,1.6108584000365853,1.7358584000365853}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{1.065507695309405,0.386078220781407,3.4413605361918767}},{{0.5088134462192132,0.261662104076605,1.4029111387685773}}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(np.array({0.5679588509048816,0.6929588509048816,0.8179588509048816},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{4.685697043540604,3.4024307277652137,2.8936583142993366}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull(np.array({{{1.12853044033958,1.25353044033958,1.37853044033958}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{2.1704722151143354,0.832794085009841,0.23937058111332016}},{{0.8789399024669787,0.9379552451225996,0.38978397816687127}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull({0.6826714020020646}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.8532325130750875}}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(np.array({{0.47385336812194695,0.598853368121947,0.723853368121947},{0.848853368121947,0.973853368121947,1.098853368121947}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.4865304823562705,1.9212222451476186,2.5037117604285632},{0.21768681908528795,0.17357616731018008,0.9104774301020284}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.array({{{1.1062228305572366,1.2312228305572366,1.3562228305572366}},{{1.4812228305572366,1.6062228305572366,1.7312228305572366}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.6697542933862193,0.13571776704971822,0.2568379544134514}},{{1.0713745610742393,0.27365221012029495,0.9552577678705785}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull({0.4096763961569048}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.38999254247528664}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(0.996, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.0733328163697506}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(np.array({{{1.1530767665054173,1.2780767665054173,1.4030767665054173}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{2.1399132592533743,1.9423620049248094,1.8578569278091022}},{{0.33133993661242145,0.14724758092251614,1.3049008663091541}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull(1.497, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.7935571786231452,0.8579485758427472,0.2680463268417418}}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull({1.287565330013615}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.386938890057531}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(np.array({{{0.9779811181854396,1.1029811181854396,1.2279811181854396}},{{1.3529811181854396,1.4779811181854396,1.6029811181854396}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.7053390651333457,1.4254954365140549,1.7177184938016565}},{{0.38420171508482526,0.3154235023081632,0.937732086710292}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull({0.9405148752306056}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{0.6240850960076546}}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(0.453, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.42674308208218803,1.043773253020485,0.0001738607515510038},{1.4558883738289325e-06,0.26757570650005474,2.940155315571771}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(np.array({1.228399136618966},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.0590581522777325,0.3838534541161942,3.9319339968921154}),"values")
  check(r:raw_hex()=="4fd42fa03fcd72a9","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(0.755, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{3.1959418610012547}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull(np.array({0.8255138494192942,0.9505138494192942,1.0755138494192944},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{2.8846374951363494,0.7856075216972849,0.1600034741301998}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull({1.2711193291195149}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.3928209567520973,0.7677405225325995,1.5968704053283855}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(0.373, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.40041423269549187}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.array({{1.169846767422462,1.294846767422462,1.4198467674224622},{1.5448467674224622,1.6698467674224622,1.7948467674224622}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.6845156193690609,0.14971168566939475,0.27296855720866464},{1.0683368474839368,0.2875031550155585,0.9568090313711792}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(np.array({{1.0915885785864654,1.2165885785864654,1.3415885785864656},{1.4665885785864656,1.5915885785864656,1.7165885785864656}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.7022992918455877,1.0160803547948183,0.05376116814800768},{0.015743689782886188,0.687130353592258,1.3292320583157555}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull({{{1.2055792991237881}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1,1}),"shape");check(same(x:tolist(),{{{1.0602090396259056}}}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(np.array({1.2240203827925233,1.3490203827925233,1.4740203827925233},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{2.0476068372185363,1.875716428262217,1.8032871401146977}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull({0.9119598022723232}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.6090268458447112}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(np.array({{1.0833309581787076},{1.2083309581787076}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{1.475158225122414,0.7333598648933181,1.731829555077855},{0.8424729976464687,0.9853309076772583,0.48914973681811147}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(np.array({0.7070530364137246},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.6170312603828283}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(0.739, nil);cases=cases+1
  check(same(x,0.5487944199465491),"scalar")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull({0.5437547250027119,0.6687547250027119,0.7937547250027119}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.4919184419123036,1.0294456273995,0.007149295268463533}}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull({{{0.3415904863357901,0.4665904863357901,0.5915904863357901}},{{0.7165904863357901,0.8415904863357901,0.9665904863357901}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.2291772904897775,0.08039457005868289,17.165683830792734}},{{0.24634623443861767,0.07682780800286908,1.8367293454793967}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull({0.4380193952462332}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{7.409022407315942,6.93913652569185,7.272908095608292}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull({{1.0552491102268613,1.1802491102268613,1.3052491102268613},{1.4302491102268613,1.5552491102268613,1.6802491102268613}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{2.2904778563509596,0.8233866782292275,0.22090706095085963},{0.9031945129073373,0.9496832799298736,0.4616351068202025}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(1.703, nil);cases=cases+1
  check(same(x,1.2805703951041583),"scalar")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(1.759, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8235903048774479,1.2489478055151102,1.4588918110877402},{0.47912944063597007,0.37927221940235506,0.9430947322130148}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.array({{1.2177171540007135},{1.3427171540007135}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.6947918295051208,0.13274457968394646,0.22004556240434572},{1.0790209491084746,0.21220241933332842,0.9426893664810032}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(0.621, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.5373015175986111),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(np.array({{1.0646048339111958,1.1896048339111958,1.3146048339111958}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.0684490900477577,0.37205285181499287,3.59430309335852},{0.3894455289425566,0.16276302868829406,1.5636684991348773}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(1.649, nil);cases=cases+1
  check(same(x,1.702284833647328),"scalar")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull(np.array({{{1.235276437021448,1.360276437021448,1.485276437021448}},{{1.610276437021448,1.735276437021448,1.860276437021448}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{2.0298830182883494,0.8448378100293097,0.2652751778801706}},{{0.9135343854813167,0.9547834754248423,0.49749204746242376}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(np.array({{{1.1924939191418014}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.4235831092611124,0.7544774100420709,1.646917985118758}},{{0.8405573086074254,0.9851375481653497,0.48452637666117715}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(np.array({{1.182622433830848,1.307622433830848,1.432622433830848},{1.557622433830848,1.682622433830848,1.807622433830848}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.7492576761020847,1.3485602880038683,1.5899759036732264},{0.4356524224571292,0.3629433021116178,0.9445821714939707}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(1.212, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.6935994046983514),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(1.95, nil);cases=cases+1
  check(same(x,0.82051179905692),"scalar")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(1.299, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.0557605063669837,0.40435808295967857,3.6499698184474227}}),"values")
  check(r:raw_hex()=="4fd42fa03fcd72a9","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull({0.9029375413859031}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.6419539839973547}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull(1.304, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.955539697698812),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull({0.797614707233006}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.6955822071857596,0.6562539595892133,2.1083411196579553}}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(np.array({{{1.2092620941323011,1.3342620941323011,1.4592620941323013}},{{1.5842620941323013,1.7092620941323013,1.8342620941323013}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.7540376579514664,1.3405326493432699,1.5765728507719337}},{{0.44178204247579567,0.36872187828285746,0.9453646234207578}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(1.374, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.7241734843785523),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull({{{0.7843451776612986,0.9093451776612986,1.0343451776612986}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.6115077645108506,1.0215717129831348,0.02256135950298267}},{{0.0004255042337817935,0.5185330670880531,1.6037129025588017}}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(np.array({{0.8569066959765326,0.9819066959765326,1.1069066959765326}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.0857334657710553,0.3018398956690421,4.569506690082219},{0.3098693894397216,0.11086126632367957,1.7004884031814693}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(1.637, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.7089360353609706),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull({{0.9129368440291805,1.0379368440291805,1.1629368440291805}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{2.60635053581867,0.8017375369457358,0.18363626386397683}}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(0.332, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{3.5557234469151946,0.36351618697012206,6.001406444714585}},{{0.5358672595757544,0.9476364268206741,0.07408113988394381}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull({{0.5302335691088198},{0.6552335691088198}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.5252667588943389,2.0906272177400336,3.500508722733725},{0.1387277260532226,0.07407602550298645,0.854462021679583}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.array({{{0.6880435049713429,0.8130435049713429,0.9380435049713429}},{{1.063043504971343,1.188043504971343,1.313043504971343}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.5249408509545306,0.04858683816203865,0.14011530284678697}},{{1.1008284122875451,0.1734197967913636,0.9414328773579594}}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(np.array({0.6074130362635408},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.5298872014476117,1.0324670776899183,0.0015703476662111615}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull({{{0.5700667288787515,0.6950667288787515,0.8200667288787516}},{{0.9450667288787516,1.0700667288787518,1.1950667288787518}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.13161331084522,0.1841157724749946,7.774563496379306}},{{0.345655757564075,0.13288561060131382,1.6351750887870058}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull({{{0.40486783671887655,0.5298678367188765,0.6548678367188766}},{{0.7798678367188766,0.9048678367188766,1.0298678367188767}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{8.729292314992295,4.959886308450202,3.770231285720147}},{{0.19529847431080588,0.06682102578430207,1.4370143650563645}}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull(np.array({0.9814197889708345},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{2.4378236061842564,0.7915998760633689,0.13422238904214762}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(np.array({{0.5201908997401261}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.2470732973936074,0.5242208502789122,3.1383565803420477},{0.6715478153257313,0.96625582809993,0.18994009104225645}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull({1.234389008282674}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.7583833550261649,1.3726988599613479,1.7129012333530833}}),"values")
  check(r:raw_hex()=="2c4b5eeb383c1bce","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.array({1.1213192990281267},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.6733784732193517}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(np.array({{{0.9080315115280719,1.033031511528072,1.158031511528072}},{{1.283031511528072,1.408031511528072,1.533031511528072}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.6538783430520094,1.0189645739055557,0.03382501821311161}},{{0.008693113266899186,0.6543270154545652,1.3753084536042528}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull({{1.0104187447447766,1.1354187447447766,1.2604187447447766},{1.3854187447447766,1.5104187447447766,1.6354187447447766}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{1.0722494340783102,0.35490524174328214,3.7975270447413103},{0.4844899306063549,0.23934360311269595,1.4323859684778633}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull({{0.8790608711116421}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.7125977660235088,2.6254670644424984,2.6876507778324887},{0.23482062274985263,0.06171853534760245,1.529235222681124}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull({1.076598865282985}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.253141649870901}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(1.304, nil);cases=cases+1
  check(same(x,1.3812329768609275),"scalar")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(np.array({{{0.6000346448359084}},{{0.7250346448359084}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.5661189298612922,1.9187541526185057,3.02575145940944}},{{0.16778362180170028,0.09516930683054682,0.8674988135152385}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull({0.5910954952257279,0.7160954952257279,0.841095495225728}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.4722853982935593,0.03226220343562145,0.11171361465868479}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(1.751, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.8022701395164845}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull({{{1.037660117657168}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.0702875625640906,0.3219053649534394,5.05713601762731}},{{0.3800247944833455,0.12476815773713835,1.7618163568259193}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(1.878, nil);cases=cases+1
  check(same(x,1.595366866665075),"scalar")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull({{1.2353519084260294}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{2.0297952225927696,0.8305548564900121,0.202817044927354},{0.8888020702067545,0.9370715848101524,0.34946209073022183}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(np.array({1.2093580807746989},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.4165892627751462,0.7574473144102369,1.635499975530617}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull({{0.7073756497941217,0.8323756497941217,0.9573756497941217},{1.0823756497941217,1.2073756497941217,1.3323756497941217}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.6171671500800467,1.5996322446042142,2.0015293702397514},{0.3024786239183133,0.2435469426403053,0.9255672446534731}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull({1.0801668929455808}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{0.6633094974021249}}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(1.013, nil);cases=cases+1
  check(same(x,0.6833062912120622),"scalar")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(1.944, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.0369233184088562}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(1.926, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.576902541327576}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull(1.112, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{2.1956205094357384,0.8136244917215246,0.169919393939577}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(np.array({1.0813017278738377},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.4762348611969014,0.7329331839618194,1.7336153305309605}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(np.array({{{0.5582070019474152,0.6832070019474152,0.8082070019474152}},{{0.9332070019474152,1.0582070019474152,1.1832070019474152}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.5424909799740363,1.7724136355570732,2.2750112868943875}},{{0.24985395818752168,0.19957823639375558,0.9165854965203519}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.array({{{0.7751761858361612}},{{0.9001761858361612}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.5643792060107591,0.04191361664655959,0.0927169426604231}},{{1.1201286115689588,0.0990307475378336,0.9157307698824192}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull({{{0.5927191075001563,0.7177191075001563,0.8427191075001564}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.521609798157658,1.0274095081618164,0.009526572061940382}},{{3.459621682403534e-05,0.43513471288224465,1.7855433891340013}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(0.557, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.134900418446104}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(1.518, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.7822548032559267),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull(np.array({{0.6248322674726596,0.7498322674726596,0.8748322674726597},{0.9998322674726597,1.1248322674726596,1.2498322674726596}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{4.053795569974204,0.7364766147229526,0.10508995209644169},{0.8644614286025433,0.9311064199445795,0.3537448822018282}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(np.array({{{0.9970573299732051,1.122057329973205,1.247057329973205}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{1.5256254138102063,0.7412514310608237,1.6113569816129767}},{{0.812421699818349,0.9842119680626514,0.500133517760634}}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull({{0.5176958866010695},{0.6426958866010695}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.5171398579541563,2.1283014223361176,3.608353375530829},{0.13348382014858673,0.07040887340023538,0.851844316009216}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(1.054, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.6565836948505728),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(0.404, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.38486679647422795}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(0.3, nil);cases=cases+1
  check(same(x,1.2648476957234613),"scalar")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull({{{1.0972681805625095}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{2.2243369612718125,2.166912692321431,2.207933409712742}},{{0.3132378556503103,0.10738870085407069,1.40536446543264}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull({0.71061586140089,0.83561586140089,0.9606158614008901}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{3.423595386361634,0.7599697505763361,0.12850984152613512}}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull({{1.2648112873345532,1.3898112873345532,1.5148112873345534}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.395124441143031,0.785266951114302,1.4810479097640796},{0.8489464527122295,0.9872341020974218,0.5652944411489172}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(1.79, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.8263632124620208,1.2441487088176575,1.449380664378007}},{{0.48527387789486287,0.3856940529837041,0.9440521401642099}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.array({{{1.2946505413644782}},{{1.4196505413644782}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,1}),"shape");check(same(x:tolist(),{{{0.7099901732067568}},{{0.17691322721378147}}}),"values")
  check(r:raw_hex()=="39ee1852018c694c","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull({0.4957984765962615,0.6207984765962615,0.7457984765962615}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.45929464034284095,1.031756035673334,0.005203413191847828}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(0.616, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.1212280268155757}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(1.021, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.361219086177566}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull({{0.7688965411049333,0.8938965411049333,1.0188965411049336}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.1186729296283144,0.7736921735993895,0.14451237867658884},{0.8274606702031058,0.9140929943543198,0.2795114093273521}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(0.848, nil);cases=cases+1
  check(same(x,1.6432116293561208),"scalar")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(np.array({0.9520296609297583},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{0.6986592356298635}}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull({{0.7046477332304806,0.8296477332304806,0.9546477332304806},{1.0796477332304806,1.2046477332304806,1.3296477332304806}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.5329735466869272,0.051618587135646106,0.1449875737266767},{1.0992032691576032,0.1776587225910316,0.9421426649811584}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(0.422, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.400865448459656),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(np.array({0.40853861913200623},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.188308478410176}}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull({0.5023913758611056}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{5.732148725017661}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull(1.971, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.5584755634532437,0.8901495248289366,0.3678900070345673}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(np.array({0.995534966457599},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.526611190404101}}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(0.311, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.3336314847143603}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull({0.33070367312654364,0.45570367312654364,0.5807036731265437}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.26162385681743267,0.004534744409281709,0.04180900585648669}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull({1.100696887323035}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.7043560753230109}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull({{{0.4258354063097734,0.5508354063097733,0.6758354063097735}},{{0.8008354063097735,0.9258354063097735,1.0508354063097736}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.1800099943732554,0.11821202224604466,12.043615482974921}},{{0.28546511547274894,0.09703511363646766,1.749350378328021}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(np.array({0.8043250242868762},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.97614766141535}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull(np.array({1.1763240041010996,1.3013240041010996,1.4263240041010996},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{2.103198046723442,0.8384092021131023,0.2511175125493847}}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(1.088, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.4726992015524925),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(1.34, nil);cases=cases+1
  check(same(x,0.7750955759039104),"scalar")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.array({{0.3614032443956526},{0.4864032443956526}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.29318585930139335,0.0011093804557999584,0.006090497850259987},{1.2336132971400884,0.01385137565266812,0.8496586645380146}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull({0.44127811748517926,0.5662781174851792,0.6912781174851793}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.417198198461866,1.0348661745642938,0.0034369596813122964}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(np.array({{{1.0081735087183283,1.1331735087183283,1.2581735087183286}},{{1.3831735087183286,1.5081735087183286,1.6331735087183286}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.0724160263168092,0.35417754223618086,3.8065803944013936}},{{0.4839203592265264,0.2388346680204394,1.4330937585456127}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(np.array({{{0.4250981566461966,0.5500981566461967,0.6750981566461967}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{7.874048197282013,4.6762225000804785,3.6232330494841882}},{{0.049974088275476954,0.011670119801055999,1.7386342411974767}}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull(np.array({0.570862583237975},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{4.627319210127085}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull({{{1.1691284545611031,1.2941284545611031,1.4191284545611031}},{{1.5441284545611031,1.6691284545611031,1.7941284545611031}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.4336668355675928,0.7713567926832342,1.520790884943008}},{{0.8744704337019336,0.9893589765773033,0.6177910156385581}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(1.512, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.7978878084572514}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.array({{0.9520592661974692,1.0770592661974692,1.2020592661974692}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.6276631391876922,0.10197359221530838,0.21574873525596555},{1.1132251396093256,0.14477465466948186,0.9362015890625688}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(0.85, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.6351853805867702),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull({0.9855448351408638,1.1105448351408638,1.2355448351408638}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.074138922972152,0.346765483004382,3.9009227495672185}),"values")
  check(r:raw_hex()=="4fd42fa03fcd72a9","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(np.array({{0.4253053952386506},{0.5503053952386505}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{7.866134686905256,7.352842435994875,7.717343665999215},{0.09881220589665435,0.011689696380363972,1.9709710780414011}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull({0.6999421192500492}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{3.4884540198571434}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull({0.6222933305369507,0.7472933305369507,0.8722933305369507}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.9675502679607721,0.6379018960143166,1.9779153888086733}}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull({{0.5927093895672304}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.562152154835934,1.9342702380636103,3.0674383085230392},{0.11263442154824027,0.05629131185599382,0.8404020801133391}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(0.572, nil);cases=cases+1
  check(same(x,0.4606045771129004),"scalar")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull({0.34282372901397423}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{0.32457110044171644}}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(0.724, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.1022523569338645,0.19699727693039848,10.206075878549987},{0.24990383984497136,0.05064152798419112,2.2517424099320857}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(np.array({1.2828863955894485,1.4078863955894485,1.5328863955894487},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.9813665881203344,1.8270297510136817,1.7629153675129339}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull({{{0.8701619874214794,0.9951619874214794,1.1201619874214794}},{{1.2451619874214794,1.3701619874214794,1.4951619874214794}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{2.7320201343867687,0.7941586173514213,0.17212808419355616}},{{0.8896279106417148,0.9430832746155292,0.41950983987380563}}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull({0.8288733771095023}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.6621519505304045}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(np.array({{0.8922856250267028}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.6820842336736018,1.5499646678827839,2.1054531199295496},{0.23445707513330696,0.147900127394724,0.8909223120282126}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.array({{0.8377550332586807,0.9627550332586807,1.0877550332586807}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.5890175286048672,0.07776232680637728,0.18363596644731553},{1.1296368279017903,0.1150919011382791,0.929738447087598}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull({0.5911990295634901}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.5207376590122454}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(np.array({{0.7827362952689056},{0.9077362952689056}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.0942291496576513,0.22253776132981118,8.573424617131582},{0.3308800890556614,0.09262528678538955,1.910578364436658}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(1.561, nil);cases=cases+1
  check(same(x,1.7541085616316983),"scalar")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull({1.0362056710949172}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.325631157025685}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull({{0.310027204892059},{0.435027204892059}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.8902213692763787,0.33835797593150496,6.81413546384392},{0.621189951289285,0.9597843545397512,0.13721261575296934}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(np.array({{{1.0068514789800904,1.1318514789800904,1.2568514789800904}},{{1.3818514789800904,1.5068514789800904,1.6318514789800904}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.7124345300752096,1.4126630775104672,1.6965046489981377}},{{0.39195743118426835,0.32247417164180214,0.938799290849869}}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.array({{{0.684645103898853}},{{0.809645103898853}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.5232642584241626,0.027554226962421317,0.06769956165865575}},{{1.1344276864147613,0.07646828039305263,0.9067610270630816}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(np.array({0.6490202586281517},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.5519063705713266}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(np.array({0.6404298049622437},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.1163447189254445}}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(1.895, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.588695666208452),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull(np.array({{0.3480237135466921,0.4730237135466921,0.5980237135466921}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{12.340664564853663,0.6157745961066424,0.03703983711345887},{0.6580780601368365,0.843881708248882,0.11397001101420172}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(np.array({1.1978356583358603},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.421342744492222}}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.7107813856932091,1.102694862541145},{1.393985655020278,0.771939590579896},{0.5664022315009698,0.9829704622398238}},{{0.8816985170414172,0.9959844628539377},{0.9610820747649474,0.9335755098309342},{0.3104630343146896,0.6550261676154442}}}),"values")
  check(r:raw_hex()=="a87f366a5c2e4ff0","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8950678122739705,0.6115282183547377,0.7354633835073286},{1.107515420525035,0.3531897247348922,0.9739307921957945}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.8793365798586038,1.0097510096384479,0.019806662589055352},{0.36250681025705767,0.8874148037290776,1.1299076093553455}},{{0.8765910437709469,0.8690807544902782,2.8167859790757257},{1.350160073998752,1.2686587852567883,0.1894339948298233}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.0730290263725388,0.7452419617067121},{2.318498840329261,0.8180832866301443},{0.4868041903980222,1.1029028459225267}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{1.245211253005248,1.1849543492321208,1.155865967282245},{0.2797942898515832,0.2940023804297799,1.1325430276881296}},{{1.089686954076812,1.255886619384137,0.6554510060640242},{1.0465608465431644,0.26539839260592407,1.0288350885780082}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.3384553810137463,0.8916527459329169,0.1393253558075622},{0.9760214711894785,0.984069761961069,0.722744177325128}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.5237302442920129,0.9194401649425717},{1.3464492994390211,0.9594213964755097},{0.9940655423343868,0.8658789004463646}},{{0.18789220694871223,0.7785530155292246},{1.2452868201769929,0.9878944546730783},{1.1953992599040446,1.3205926136277402}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9181930717015355,1.0813450111985106,1.1170846947121964},{0.27410475920043237,0.42627261536366307,0.9662309296359728}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.8625969526151497,0.29244301640771625,0.15825824028190472},{1.0171655207543069,0.6594824217812805,0.980383678926586}},{{1.0411341719237022,0.8720347860345439,0.7015843215356756},{0.8598929909158767,1.0805841632018351,1.1450316209856355}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.6799319039689096,1.0048636771415553},{0.14073614528277856,0.29592346521996554},{0.8194914915038408,1.084830671666088}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{1.0177775511921612,0.7903834543616707,1.3235356011344608},{0.36642711289983193,0.33964987723655027,1.2163946875440086}},{{0.8403236414370705,0.8877623438802846,0.5565345880469309},{0.7640665299216493,1.0205186986760728,0.6132266462205076}}}),"values")
  check(r:raw_hex()=="c9d676a873e2d50a","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.339648048201514,1.5284598967013998,2.384760999874255},{0.8087354391371231,0.6128304535862584,1.09784501211043}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{2.39779303386783,0.94427366050998},{0.37326311873470996,0.9712952078158467},{0.9735908388634921,0.8053594042729547}},{{3.0283324147721276,0.723877686577066},{1.358398906698215,0.9423764569480996},{1.5217056483448717,1.0313342361780826}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.1110331621532823,0.9350154288164403,1.104239643834633},{0.812918483186911,0.9911115332635599,0.7497462702382054}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.8924392897864571,1.2159359598746349,1.9431960064023137},{0.8059710256317328,0.7110087958999728,0.974564755947334}},{{0.958900113676295,0.9919850502464468,0.9236787544344961},{0.9443316422367329,0.4956851846714574,0.530136827648474}}}),"values")
  check(r:raw_hex()=="a87f366a5c2e4ff0","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.6418355359170097,0.5407800074038576},{0.3978168426322655,1.0206338229027778},{0.49965707373466844,0.9868793199757478}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.9080637834459279,1.0038890529566635,0.5201579220579547},{0.0022693266812281823,0.7418509773795868,1.1768575861874957}},{{0.9059365295811809,0.9454184058277463,1.1883899627369816},{6.0577530804425725,1.812850864769009,0.10879540598683154}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.023773357577454,0.5553855814884685,5.375436872608127},{0.8459238444527819,0.6492509365599708,1.158259540283321}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{2.4042086039659947,1.2363089810809431},{1.5442671400616717,0.7751179055671412},{0.44214755844391435,1.0642100486690256}},{{1.4099606942575735,1.329499081680755},{0.2815922534153045,1.0091434288992123},{0.4129830165318008,1.0143150834814636}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.2443797167264259,0.9551647806599577,0.7200097212773805},{0.8644825476587582,0.9606489624523589,0.6486037700508885}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{1.1507192084109508,0.8453702169096236,1.8129257159598309},{0.9660683030378869,0.9964350875203408,0.805722952439373}},{{0.5727559232319411,0.606144797989649,1.550739264506526},{0.9899018206529554,1.1130323561364037,1.5175859451375577}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.7107813856932091,1.102694862541145},{1.393985655020278,0.771939590579896},{0.5664022315009698,0.9829704622398238}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.8950678122739705,0.6115282183547377,0.7354633835073286},{1.107515420525035,0.3531897247348922,0.9739307921957945}},{{1.0306946595305624,0.9467024996665138,0.9426416955847319},{0.40426528929100997,1.213798218727233,1.1979075633885485}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8793365798586038,1.0097510096384479,0.019806662589055352},{0.36250681025705767,0.8874148037290776,1.1299076093553455}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.0730290263725388,0.7452419617067121},{2.318498840329261,0.8180832866301443},{0.4868041903980222,1.1029028459225267}},{{0.498639097854449,0.8617293788850745},{0.17237587407255076,0.9476025814421435},{1.0136327743507718,0.783087891759608}}}),"values")
  check(r:raw_hex()=="c9d676a873e2d50a","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.245211253005248,1.1849543492321208,1.155865967282245},{0.2797942898515832,0.2940023804297799,1.1325430276881296}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{1.3384553810137463,0.8916527459329169,0.1393253558075622},{0.9760214711894785,0.984069761961069,0.722744177325128}},{{1.44677561997134,0.5239989051241649,1.8452475897189058},{0.9517444576987237,1.2864662336024082,1.04736764158268}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.5237302442920129,0.9194401649425717},{1.3464492994390211,0.9594213964755097},{0.9940655423343868,0.8658789004463646}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.9181930717015355,1.0813450111985106,1.1170846947121964},{0.27410475920043237,0.42627261536366307,0.9662309296359728}},{{0.9690139463223676,0.9967862782435187,0.9868553330406395},{0.7091649331629267,0.17298754950840287,0.42905928026097595}}}),"values")
  check(r:raw_hex()=="a87f366a5c2e4ff0","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8625969526151497,0.29244301640771625,0.15825824028190472},{1.0171655207543069,0.6594824217812805,0.980383678926586}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.6799319039689096,1.0048636771415553},{0.14073614528277856,0.29592346521996554},{0.8194914915038408,1.084830671666088}},{{0.6735829526672319,0.9322450077583029},{1.678328328747306,1.4337132979647955},{1.4867617703170326,0.32984148615180525}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.0177775511921612,0.7903834543616707,1.3235356011344608},{0.36642711289983193,0.33964987723655027,1.2163946875440086}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{1.339648048201514,1.5284598967013998,2.384760999874255},{0.8087354391371231,0.6128304535862584,1.09784501211043}},{{1.1213357506542636,1.7675678081899708,0.0792941971835091},{1.0076137389101303,0.588246450472126,1.0215492884631956}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{2.39779303386783,0.94427366050998},{0.37326311873470996,0.9712952078158467},{0.9735908388634921,0.8053594042729547}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{1.1110331621532823,0.9350154288164403,1.104239643834633},{0.812918483186911,0.9911115332635599,0.7497462702382054}},{{0.6583808524580288,0.8185223697632745,1.0758617413831861},{0.9409200827801937,1.30698160121573,1.7439648511681458}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8924392897864571,1.2159359598746349,1.9431960064023137},{0.8059710256317328,0.7110087958999728,0.974564755947334}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.6418355359170097,0.5407800074038576},{0.3978168426322655,1.0206338229027778},{0.49965707373466844,0.9868793199757478}},{{1.1285481759163378,0.9338280280836209},{0.8376063046179127,0.8343212224434189},{1.1378831435244263,1.0944896360352383}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9080637834459279,1.0038890529566635,0.5201579220579547},{0.0022693266812281823,0.7418509773795868,1.1768575861874957}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{1.023773357577454,0.5553855814884685,5.375436872608127},{0.8459238444527819,0.6492509365599708,1.158259540283321}},{{0.7929797725055807,0.7425775224336563,0.029713441962275874},{0.9561408264670098,1.0081575030425514,0.69297212177665}}}),"values")
  check(r:raw_hex()=="c9d676a873e2d50a","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{2.4042086039659947,1.2363089810809431},{1.5442671400616717,0.7751179055671412},{0.44214755844391435,1.0642100486690256}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{1.2443797167264259,0.9551647806599577,0.7200097212773805},{0.8644825476587582,0.9606489624523589,0.6486037700508885}},{{1.3191703647702373,0.772204186496436,1.1074967007321104},{0.7432281302198392,1.8771370383878554,1.0636503067130294}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.1507192084109508,0.8453702169096236,1.8129257159598309},{0.9660683030378869,0.9964350875203408,0.805722952439373}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.7107813856932091,1.102694862541145},{1.393985655020278,0.771939590579896},{0.5664022315009698,0.9829704622398238}},{{0.8816985170414172,0.9959844628539377},{0.9610820747649474,0.9335755098309342},{0.3104630343146896,0.6550261676154442}}}),"values")
  check(r:raw_hex()=="a87f366a5c2e4ff0","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8950678122739705,0.6115282183547377,0.7354633835073286},{1.107515420525035,0.3531897247348922,0.9739307921957945}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.8793365798586038,1.0097510096384479,0.019806662589055352},{0.36250681025705767,0.8874148037290776,1.1299076093553455}},{{0.8765910437709469,0.8690807544902782,2.8167859790757257},{1.350160073998752,1.2686587852567883,0.1894339948298233}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.0730290263725388,0.7452419617067121},{2.318498840329261,0.8180832866301443},{0.4868041903980222,1.1029028459225267}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{1.245211253005248,1.1849543492321208,1.155865967282245},{0.2797942898515832,0.2940023804297799,1.1325430276881296}},{{1.089686954076812,1.255886619384137,0.6554510060640242},{1.0465608465431644,0.26539839260592407,1.0288350885780082}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.3384553810137463,0.8916527459329169,0.1393253558075622},{0.9760214711894785,0.984069761961069,0.722744177325128}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.5237302442920129,0.9194401649425717},{1.3464492994390211,0.9594213964755097},{0.9940655423343868,0.8658789004463646}},{{0.18789220694871223,0.7785530155292246},{1.2452868201769929,0.9878944546730783},{1.1953992599040446,1.3205926136277402}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9181930717015355,1.0813450111985106,1.1170846947121964},{0.27410475920043237,0.42627261536366307,0.9662309296359728}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.8625969526151497,0.29244301640771625,0.15825824028190472},{1.0171655207543069,0.6594824217812805,0.980383678926586}},{{1.0411341719237022,0.8720347860345439,0.7015843215356756},{0.8598929909158767,1.0805841632018351,1.1450316209856355}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.6799319039689096,1.0048636771415553},{0.14073614528277856,0.29592346521996554},{0.8194914915038408,1.084830671666088}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{1.0177775511921612,0.7903834543616707,1.3235356011344608},{0.36642711289983193,0.33964987723655027,1.2163946875440086}},{{0.8403236414370705,0.8877623438802846,0.5565345880469309},{0.7640665299216493,1.0205186986760728,0.6132266462205076}}}),"values")
  check(r:raw_hex()=="c9d676a873e2d50a","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.339648048201514,1.5284598967013998,2.384760999874255},{0.8087354391371231,0.6128304535862584,1.09784501211043}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{2.39779303386783,0.94427366050998},{0.37326311873470996,0.9712952078158467},{0.9735908388634921,0.8053594042729547}},{{3.0283324147721276,0.723877686577066},{1.358398906698215,0.9423764569480996},{1.5217056483448717,1.0313342361780826}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.1110331621532823,0.9350154288164403,1.104239643834633},{0.812918483186911,0.9911115332635599,0.7497462702382054}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.8924392897864571,1.2159359598746349,1.9431960064023137},{0.8059710256317328,0.7110087958999728,0.974564755947334}},{{0.958900113676295,0.9919850502464468,0.9236787544344961},{0.9443316422367329,0.4956851846714574,0.530136827648474}}}),"values")
  check(r:raw_hex()=="a87f366a5c2e4ff0","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.6418355359170097,0.5407800074038576},{0.3978168426322655,1.0206338229027778},{0.49965707373466844,0.9868793199757478}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.9080637834459279,1.0038890529566635,0.5201579220579547},{0.0022693266812281823,0.7418509773795868,1.1768575861874957}},{{0.9059365295811809,0.9454184058277463,1.1883899627369816},{6.0577530804425725,1.812850864769009,0.10879540598683154}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.023773357577454,0.5553855814884685,5.375436872608127},{0.8459238444527819,0.6492509365599708,1.158259540283321}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{2.4042086039659947,1.2363089810809431},{1.5442671400616717,0.7751179055671412},{0.44214755844391435,1.0642100486690256}},{{1.4099606942575735,1.329499081680755},{0.2815922534153045,1.0091434288992123},{0.4129830165318008,1.0143150834814636}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.2443797167264259,0.9551647806599577,0.7200097212773805},{0.8644825476587582,0.9606489624523589,0.6486037700508885}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{1.1507192084109508,0.8453702169096236,1.8129257159598309},{0.9660683030378869,0.9964350875203408,0.805722952439373}},{{0.5727559232319411,0.606144797989649,1.550739264506526},{0.9899018206529554,1.1130323561364037,1.5175859451375577}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.7107813856932091,1.102694862541145},{1.393985655020278,0.771939590579896},{0.5664022315009698,0.9829704622398238}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.8950678122739705,0.6115282183547377,0.7354633835073286},{1.107515420525035,0.3531897247348922,0.9739307921957945}},{{1.0306946595305624,0.9467024996665138,0.9426416955847319},{0.40426528929100997,1.213798218727233,1.1979075633885485}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8793365798586038,1.0097510096384479,0.019806662589055352},{0.36250681025705767,0.8874148037290776,1.1299076093553455}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.0730290263725388,0.7452419617067121},{2.318498840329261,0.8180832866301443},{0.4868041903980222,1.1029028459225267}},{{0.498639097854449,0.8617293788850745},{0.17237587407255076,0.9476025814421435},{1.0136327743507718,0.783087891759608}}}),"values")
  check(r:raw_hex()=="c9d676a873e2d50a","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.245211253005248,1.1849543492321208,1.155865967282245},{0.2797942898515832,0.2940023804297799,1.1325430276881296}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{1.3384553810137463,0.8916527459329169,0.1393253558075622},{0.9760214711894785,0.984069761961069,0.722744177325128}},{{1.44677561997134,0.5239989051241649,1.8452475897189058},{0.9517444576987237,1.2864662336024082,1.04736764158268}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.5237302442920129,0.9194401649425717},{1.3464492994390211,0.9594213964755097},{0.9940655423343868,0.8658789004463646}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.9181930717015355,1.0813450111985106,1.1170846947121964},{0.27410475920043237,0.42627261536366307,0.9662309296359728}},{{0.9690139463223676,0.9967862782435187,0.9868553330406395},{0.7091649331629267,0.17298754950840287,0.42905928026097595}}}),"values")
  check(r:raw_hex()=="a87f366a5c2e4ff0","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8625969526151497,0.29244301640771625,0.15825824028190472},{1.0171655207543069,0.6594824217812805,0.980383678926586}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:weibull(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.6799319039689096,1.0048636771415553},{0.14073614528277856,0.29592346521996554},{0.8194914915038408,1.084830671666088}},{{0.6735829526672319,0.9322450077583029},{1.678328328747306,1.4337132979647955},{1.4867617703170326,0.32984148615180525}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:weibull(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.0177775511921612,0.7903834543616707,1.3235356011344608},{0.36642711289983193,0.33964987723655027,1.2163946875440086}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:weibull(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{1.339648048201514,1.5284598967013998,2.384760999874255},{0.8087354391371231,0.6128304535862584,1.09784501211043}},{{1.1213357506542636,1.7675678081899708,0.0792941971835091},{1.0076137389101303,0.588246450472126,1.0215492884631956}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(np.array({0.6861107778137252},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.548409022518451}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(0.435, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),3.773414362977351),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(np.array({{{1.0422672474301446,1.1672672474301446,1.2922672474301446}},{{1.4172672474301446,1.5422672474301446,1.6672672474301446}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.7997056624382477,0.3024568643090109,63.051947325214265}},{{0.2950441993053321,0.07766890935154154,1.9431759667951858}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(1.782, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.8541985147469746}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(1.375, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),4.719317494770803),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(np.array({{1.130822500050545}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{2.8476134214486386}}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto(np.array({0.8591772421476174,0.9841772421476174,1.1091772421476174},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{1.2870926813795212,3.491875488473478,4.765694419537384}}),"values")
  check(r:raw_hex()=="2c4b5eeb383c1bce","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(np.array({1.0261605672788534,1.1511605672788534,1.2761605672788534},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.8691294960119773,0.07712211828478761,0.13202858241672025}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto({{{0.3910273275575192,0.5160273275575191,0.6410273275575192}},{{0.7660273275575192,0.8910273275575192,1.0160273275575191}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{4.690708439498724,6.212810871686796,0.031380619878069345}},{{0.002966854207475925,0.8545643647274875,3.974022814324839}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(np.array({{{0.9978985491435701}},{{1.1228985491435701}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{1.9308388902538973,0.36220227276616895,217.49363364208074}},{{0.38586230044588027,0.10819874059842706,3.9669879867804156}}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto({{1.2069951006988766,1.3319951006988766,1.4569951006988768},{1.5819951006988768,1.7069951006988768,1.8319951006988768}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{6.329416508914922,4.77710440479981,4.1385279980595495},{0.19346598534067283,0.05194114736054017,1.2098819178643145}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto({1.1791102782454668,1.3041102782454668,1.4291102782454668}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{6.6412507693870655,0.8397785971599727,0.10240149342405207}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(np.array({1.2110074893654732},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{2.5191994799858803}}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto(1.142, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.8633957828175585),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(np.array({0.6112205689499484},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.8579033089740578,0.15018354167567158,0.29553230025279}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(np.array({{{1.285427231367798}},{{1.410427231367798}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,1}),"shape");check(same(x:tolist(),{{{0.697156191783832}},{{1.0603986272120094}}}),"values")
  check(r:raw_hex()=="0a7d3da94ecde8b8","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(np.array({1.2125252660051462,1.3375252660051462,1.4625252660051462},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.4228728211114112,0.25937405622766574,38.466369130721695}),"values")
  check(r:raw_hex()=="4fd42fa03fcd72a9","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(1.586, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),3.5534921949665415),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(np.array({{{0.487325084365473,0.6123250843654731,0.7373250843654731}},{{0.8623250843654731,0.9873250843654731,1.112325084365473}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{136.04580713200076,2.6634408361804254,0.20799330003627436}},{{1.7250912508550953,1.546433089387254,0.2780112452632287}}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto({1.2207954522354323,1.3457954522354323,1.4707954522354323}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{2.4838758126481055,0.7006743209281361,2.430190510368087}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto(1.669, nil);cases=cases+1
  check(same(x,0.5309257377168871),"scalar")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(1.361, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.6025420278055258}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(np.array({0.6142571858455299},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.0250187724862103}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(1.622, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.9377875264683773),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(1.232, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{6.039013430943422,5.660921494508169,5.928772227577807},{0.2549625791761294,0.0726800398203269,2.2514711694763694}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(np.array({{{0.905047018406117}},{{1.030047018406117}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,1}),"shape");check(same(x:tolist(),{{{13.144946467961985}},{{1.1637714605367242}}}),"values")
  check(r:raw_hex()=="3e6f74f5cba0e8f3","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(np.array({{{0.7770350404901218}},{{0.9020350404901218}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{6.106105556034398,1.5085754130759672,9.31018778813854}},{{1.462568704370981,1.971254880559263,0.595549139185771}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto({{0.8204395213201263,0.9454395213201263,1.0704395213201263},{1.1954395213201263,1.3204395213201263,1.4454395213201263}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{1.3781959762779927,3.7770499988364836,5.143074545874095},{0.2577092790798212,0.14753023884663796,0.8665349788908001}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(1.419, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.5719476442110618),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(0.537, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),2.5472314249847936),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto({0.3883879051812165}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{14.843774169804748}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto({{0.5308249878326061,0.6558249878326061,0.7808249878326061},{0.9058249878326061,1.0308249878326061,1.1558249878326061}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{91.68369755369432,34.24117246420017,20.20327366771575},{0.3619035449543708,0.08746863588384414,2.5142179775310436}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto({{0.4795713409881264},{0.6045713409881264}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{147.39345609495132,4.24787618700841,0.3371234191112258},{3.178322721381047,3.6017999856348326,0.5703939578170094}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(0.951, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{3.9641396748808546}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto(np.array({0.8214986714720394},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.3755410940703687,5.048194321053193,9.648596049621116}),"values")
  check(r:raw_hex()=="2c4b5eeb383c1bce","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(0.662, nil);cases=cases+1
  check(same(x,1.6367315066707997),"scalar")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto({{{1.2063150814476826,1.3313150814476826,1.4563150814476828}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.7570630730507063,1.150837057616785,0.013693441851261227}},{{0.0018829761729059632,0.5119238119616762,2.062471844442484}}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto({{0.8578657455040284,0.9828657455040284,1.1078657455040286}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.49317931547712,0.36865758427325684,127.00447681569578},{0.5328642790478418,0.12453896229202291,4.07619744206162}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(1.508, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{3.924894178409536,3.7076902007285115,3.861789104124089}},{{0.20386832947807473,0.0589938196410274,1.620336459666954}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(np.array({{{0.605126653081465}},{{0.730126653081465}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{51.586779764977486,2.7204636274790044,0.2589041805970059}},{{2.2674741137564363,2.5393882370354963,0.453122543605207}}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(np.array({0.3579937769038442},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{69.54873303749693}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto({0.971958003224441,1.096958003224441,1.221958003224441}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.0777553785488876,2.8490196167476025,3.904883868182552}),"values")
  check(r:raw_hex()=="2c4b5eeb383c1bce","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto({{{1.1924409984394937,1.3174409984394937,1.4424409984394937}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.713012464577292,0.06706932036724333,0.11596061569013968}},{{1.5314191104263744,0.09931341892446807,0.8973372936788231}}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(np.array({0.9910033248462771,1.116003324846277,1.241003324846277},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.9859642488033685,1.4933189947732384,0.016088245373114228}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(1.794, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8186982054913599,0.18760179786841283,19.012190713296057},{0.22660655282890657,0.06641693429173974,1.7270798218943006}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(1.901, nil);cases=cases+1
  check(same(x,2.542055874310183),"scalar")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(np.array({0.5125601782472371},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{106.56241139561398}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(1.711, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.4364681936485584),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto(0.88, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.242757465339215}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(1.44, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.5616127825102186),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(np.array({0.5511218692771451},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.433991623016206}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto({{{0.3753032496764171}},{{0.500303249676417}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{16.44579563262812,1.2747657811604436,1660974.8925560175}},{{1.0800876236833683,0.2593355354265814,35.503653192786665}}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto({0.9969505460294501}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{10.151372148367212}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(1.224, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{6.092098215009147,0.9146718641215892,0.12055926572291494},{1.0264319596584257,1.1253988967268334,0.24972569437088615}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto({{0.31369648832415103,0.43869648832415103,0.5636964883241511}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{127.68134864852745,4.098938718619762,23.931648846681405},{12.34867627835127,8.385239733436734,1.1120282712283107}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto(0.579, nil);cases=cases+1
  check(same(x,2.4130342410316787),"scalar")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(np.array({{0.502270744785388,0.627270744785388,0.752270744785388}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{2.5889785990962966,0.14607299809490706,0.2341395986362381},{8.070403771027504,0.22001877924168572,2.4145073686575564}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto({{{1.2976572464927814}},{{1.4226572464927814}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.6887165375183772,1.193989169568668,0.015380481375375957}},{{0.0015964053097420531,0.4723231193140236,2.144646317128311}}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(np.array({1.234294103717568,1.359294103717568,1.484294103717568},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.3853510672105134,0.25473144812499526,36.39527332182741}),"values")
  check(r:raw_hex()=="4fd42fa03fcd72a9","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto({{0.7676229388774667,0.8926229388774667,1.0176229388774667},{1.1426229388774667,1.2676229388774667,1.3926229388774667}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{21.920178141739317,12.697576689141705,9.41724188425838},{0.2774554689142179,0.07056716984122993,1.8380328402823864}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(0.931, nil);cases=cases+1
  check(same(x,12.137920215694226),"scalar")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(np.array({{0.7038918150450837,0.8288918150450837,0.9538918150450838},{1.078891815045084,1.203891815045084,1.328891815045084}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{7.712181409272684,1.3683090276556644,5.6896191696010785},{1.1243703195856918,1.2612976358160948,0.3731971055820607}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto({{{0.9618593106405013,1.0868593106405013,1.2118593106405013}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.0937695642354908,2.8975256338997872,3.9703147487917727}},{{0.3297272667580751,0.18197483362085426,1.1051210755023373}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto({{0.4830163092956666,0.6080163092956665,0.7330163092956666},{0.8580163092956666,0.9830163092956666,1.1080163092956665}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{2.776535941452972,0.15103198786267757,0.24097830731231393},{2.635642966722489,0.13530141677467486,1.3019449539535053}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto({{{1.1454834372056477}},{{1.2704834372056477}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.8104517015006509,1.4353780536503038,0.017441451035514585}},{{0.0017877876625080253,0.5421475410502259,2.6071908308532903}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto({{{1.111034115511257,1.236034115511257,1.361034115511257}},{{1.486034115511257,1.611034115511257,1.736034115511257}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.6268700682876875,0.2834485976994053,50.91065028447113}},{{0.27964225715903906,0.07423356705138229,1.819978045734516}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(np.array({0.47286320595445447},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{160.47718749668206}}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto({{{0.4095525035358922}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{347.85829052033506,5.967468829604332,0.4052134910563211}},{{7.254824845146129,8.519138287931078,0.9468975629182038}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(np.array({{0.3700685741731437}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{60.401038191662856,5.897304969660395,133.1409742194255},{7.9950089324925155,13.21614815227741,2.1231272204089056}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto({{{1.2917073144218656,1.4167073144218656,1.5417073144218656}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.7337124717458976,1.8394696656313656,2.526896237294982}},{{0.2363994151828762,0.13684971846134172,0.7951965544524838}}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto({1.277474550573943}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.6527247693489371}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto({{{1.0005441445506662}},{{1.1255441445506662}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.973013607634273,1.7705409639894847,0.019993128759271412}},{{0.0020182379725767166,0.6306148687632536,3.255173351618059}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(np.array({{{0.47008612129321986,0.5950861212932199,0.7200861212932199}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{8.802350670650545,0.6792270883858681,1744.840945837272}},{{1.180358524331356,0.21392355450099593,11.175420565304893}}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(np.array({1.0126721761318445},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{9.741591853912114,9.043799804858171,9.537275844018469}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(np.array({0.9656102181681065},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{10.979410383159054,1.2781410526556811,0.15521603165232767}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto({{1.1897315294325586},{1.3147315294325586}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1}),"shape");check(same(x:tolist(),{{2.5992825150198224},{0.7221468185222438}}),"values")
  check(r:raw_hex()=="ec59dd7c2bde3cb4","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto({{0.9258434353708818,1.0508434353708818,1.175843435370882}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.1548309863729378,3.0835442856118407,4.220522914389971},{0.3445501764562293,0.188767035425709,1.1536692073580188}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(np.array({0.7461862771045693},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.3635259944005849}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(1.476, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.5851173960955058,0.9952791075350145,0.013509588957015914},{0.001538666736174046,0.45188255017712475,2.0170987397621882}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto({1.0193030629861701}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.8654016358161853,0.3533889894507377,194.12482414756718}),"values")
  check(r:raw_hex()=="4fd42fa03fcd72a9","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(0.962, nil);cases=cases+1
  check(same(x,11.172476067978945),"scalar")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(np.array({{{0.6737469716793683}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{34.12427491167172,2.2544862318608776,0.22972652845774832}},{{2.6077948722462128,2.9342590361800136,0.49928370452397985}}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(1.025, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),3.4218850717543723),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto(1.543, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.5851023608015296,1.60699569209453,2.523173991387184}},{{0.19440009114342488,0.12497748461615653,0.7943167758055245}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(1.623, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{0.4850707844431683}}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto({{{0.7110609110673343,0.8360609110673343,0.9610609110673343}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1,3}),"shape");check(same(x:tolist(),{{{1.6018474315286721,2.3855788730805703,0.020822999982698227}}}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(np.array({0.9156135848103406},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.2281959272887377}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto({0.509215432255651,0.634215432255651,0.7592154322556511}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{111.32514719723089,38.78898240678657,22.128972342410506}}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto({0.4352930294436736}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{245.7701229396438}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto({0.8166386262839567,0.9416386262839567,1.066638626283957}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{5.461465827546272,1.136018979889364,4.472100460718531}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto({{0.6935149112282479}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{1.7868085400173728}}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(np.array({0.32802762146231507},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{6.075590374725147}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto({{1.1468717227306802,1.2718717227306802,1.3968717227306802},{1.5218717227306802,1.6468717227306802,1.7718717227306802}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8091513179002655,1.2292180914229702,0.014280302637255797},{0.0014922541976695222,0.39678714840148577,1.5090332951572576}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(np.array({0.7163997279110275},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{3.4718746106267515}}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(np.array({0.6671400014881668},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{35.73589095678143,32.175053709707925,34.68047153638746}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(np.array({{{0.4278086443056212}},{{0.5528086443056213}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,1}),"shape");check(same(x:tolist(),{{{270.73465298378255}},{{3.213069022456301}}}),"values")
  check(r:raw_hex()=="3e6f74f5cba0e8f3","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(np.array({0.9737124621037523,1.0987124621037523,1.2237124621037523},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{3.7820376293847784,0.916391299844487,3.3995245965262004}}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto(1.719, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.5120787960131126,1.3633810161493272,2.0969642029201396},{0.17287258318388535,0.11149487344106,0.6900658605982507}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto({{0.6932743494530527},{0.8182743494530527}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.5238943645528822,0.13129258208281858,0.2564326778711327},{2.8708607123593755,0.164680037659354,2.0924933430300925}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(1.82, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.45293980874063877,0.751054517034047,0.010942214513126386},{0.0012476604734242864,0.353083678289446,1.4487352515123706}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto({{{1.1286082253734444}},{{1.2536082253734444}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,1}),"shape");check(same(x:tolist(),{{{1.5876605736811131}},{{0.2789664178414223}}}),"values")
  check(r:raw_hex()=="f2dab0aed2ac6fd2","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(np.array({1.2539706426889572,1.3789706426889572,1.5039706426889572},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{5.802407725806422,4.442044098904075,3.8824313238035772}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(np.array({0.8663748703252412},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{14.920635424411902}}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto({1.1159105614106823}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.9175212203123335}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto({{{0.438023228676732,0.563023228676732,0.688023228676732}},{{0.813023228676732,0.938023228676732,1.063023228676732}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{4.066764733051919,12.818416589568361,15.84944036809198}},{{0.4009388130741047,0.21374924455291847,1.3363600528245174}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto({0.7868818102260238}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.2606888210343274}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(np.array({1.2843043442239916},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.6979412616774865}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(np.array({0.8137853586145225},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{2.7380540400845432}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(np.array({0.7494124439403167},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{23.73266260641404}}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(0.409, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),350.62830111443856),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(0.892, nil);cases=cases+1
  check(same(x,4.519116331822),"scalar")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto({{{1.2991147835719552}},{{1.4241147835719552}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.7282813418617069,2.1207796312777405,3.4628371317714093}},{{0.21224472134329486,0.1360915289263271,0.8840595964927872}}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(1.109, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.7838101500918162,0.0801686092682075,0.15338783262295053}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(1.881, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.4354431733810147),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto({0.6835789757007835,0.8085789757007835,0.9335789757007835}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{3.8053126197006106,0.4644439188796434,315.67665658209495}}),"values")
  check(r:raw_hex()=="4fd42fa03fcd72a9","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(1.618, nil);cases=cases+1
  check(same(x,3.419001858431748),"scalar")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto({1.208198590148041,1.333198590148041,1.458198590148041}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{6.2761490670146065,0.8154688055577191,0.1002596692091225}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto({{0.4022805345181137}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{43.15607362050145,4.909129886111582,89.61506963221882},{6.544170075913784,10.494095453186576,1.8509277460464217}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto(np.array({1.1668136198635939,1.2918136198635939,1.416813619863594},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.8388942822960239,2.1409181124915118,2.9413586488318715}),"values")
  check(r:raw_hex()=="2c4b5eeb383c1bce","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto({1.096339020519323}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.7957724703208573}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(np.array({1.1325598907874683},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.8227559672296837}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(np.array({0.47403551230359803},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{8.617695922621236}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto({{{1.1814946247935305}},{{1.3064946247935305}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{6.6513910407472165,6.223338272002972,6.526478691992641}},{{0.2388164895054924,0.06839741431684995,2.040057353061135}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(1.488, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{4.00992051470392}}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(1.911, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.219644541472072),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto({{{0.7155984336909316}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1,1}),"shape");check(same(x:tolist(),{{{1.7000451740360796}}}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(0.694, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.5214523532486712}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(1.021, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.946332858401979}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(0.413, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),12.438627855105349),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(1.096, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{7.967626071343733}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(np.array({0.5277657660203114,0.6527657660203114,0.7777657660203116},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{92.99956948351962,2.380295410284852,0.1961826566688662}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(0.508, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{19.07487402964921,3.0828403913389355,34.47227513948573},{3.9541877777589525,5.91481004550022,1.292447516283989}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto({0.3351494591340482,0.4601494591340482,0.5851494591340483}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{7.33771582197874,23.85569817161727,26.68398658223237}}),"values")
  check(r:raw_hex()=="2c4b5eeb383c1bce","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto({0.7206448986212626,0.8456448986212626,0.9706448986212627}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.4366898618686157,0.10642419496592957,0.17708898180484106}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(1.338, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.6622470503647615),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(0.685, nil);cases=cases+1
  check(same(x,3.7896901952519064),"scalar")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(1.373, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),4.760719315753443),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(1.801, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),2.7862178511481006),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(1.779, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.354926253682058}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto({1.0705398584828663}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.9424434304266083}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(np.array({1.2138295916762816},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.6968423166859086}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto({{{0.4753320794932084,0.6003320794932083,0.7253320794932084}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{3.1805196155507076,4.4651332428383474,0.02768328071854034}},{{0.00478560676048445,1.5011002671897549,8.46087061735367}}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(np.array({{{0.995779827434311,1.120779827434311,1.245779827434311}},{{1.370779827434311,1.495779827434311,1.620779827434311}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{1.9375520119702507,0.31681108520775536,73.80743320359727}},{{0.30644915314100707,0.08017710447261622,2.035728145520295}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(np.array({{0.8819368829167606,1.0069368829167606,1.1319368829167606},{1.2569368829167606,1.3819368829167606,1.5069368829167606}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{14.2725206142449,9.176645371233977,7.221862767747721},{0.2493208843465567,0.06454556477218772,1.6221178269219392}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(0.777, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{20.88852923876837}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(np.array({{1.0656762840318588,1.1906762840318588,1.3156762840318588},{1.4406762840318588,1.5656762840318588,1.6906762840318588}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{3.177966617164965,0.8224938188442493,2.966730010700794},{0.758149303335659,0.8727312700418643,0.2830976020401501}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto({0.8914382856909429}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.219633793674768}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto({{0.9921603404857053,1.1171603404857053,1.2421603404857053},{1.3671603404857053,1.4921603404857053,1.6171603404857053}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.9096253425035008,0.07956031605469596,0.135877688276656},{1.2480979752924795,0.08719274686756735,0.7704904008997198}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(1.193, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.7681513011246355}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto({1.07364953426431,1.19864953426431,1.32364953426431}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{1.716711271257372,0.2934769301480997,57.03652843140395}),"values")
  check(r:raw_hex()=="4fd42fa03fcd72a9","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(1.758, nil);cases=cases+1
  check(same(x,2.925845279911765),"scalar")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto({{0.5735822926046013,0.6985822926046013,0.8235822926046013},{0.9485822926046013,1.0735822926046013,1.1985822926046013}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{64.39082116683247,2.120780038285051,0.1843213692690192},{1.4876578510268132,1.362204815693934,0.25564767741561234}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(np.array({0.4451243990718426},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{29.666043590901943}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto({{{0.45828192200593404,0.583281922005934,0.7082819220059341}},{{0.8332819220059341,0.9582819220059341,1.0832819220059342}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{3.7160412202083632,11.613848183820242,14.541823277942319}},{{0.3895028272199201,0.20878881353040848,1.2995752659657882}}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto({0.9837611031637861,1.108761103163786,1.2337611031637863}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.9202017986717381,0.08018655737066432,0.13686332613919983}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(1.444, nil);cases=cases+1
  check(same(x,0.6013819408756735),"scalar")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto({{{0.7580975490666271}},{{0.8830975490666271}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{3.118229841967844,0.5021206961608721,1199.7394477121225}},{{0.5142706488701305,0.13954995054413208,6.675628216460434}}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(0.948, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{11.630127423679465,10.755662977085994,11.373668107340757},{0.343316634018647,0.09546473818798898,3.6290067310180336}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(1.483, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),4.037213355459032),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(0.455, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{27.470192983772385,3.8098269526781894,52.75582982510557},{4.969326034464474,7.661653601124406,1.5250404687045525}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto(np.array({{0.762971231377332},{0.887971231377332}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1}),"shape");check(same(x:tolist(),{{1.5385589426890092},{4.285840865315098}}),"values")
  check(r:raw_hex()=="bbf870193643edf7","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(1.293, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.6427842665596591),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(1.995, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.4060973036121647}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(1.173, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.4962091810712113),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(1.237, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),5.983708758228371),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(1.404, nil);cases=cases+1
  check(same(x,4.516975515122089),"scalar")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(0.799, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{5.733173741037589,1.445944982036984,8.669662302594176}},{{1.7660488081314907,2.4192265042837082,0.6946361463984545}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto({0.7569323268877175}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{1.5574968142479186}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(np.array({1.0591684347321835,1.1841684347321835,1.3091684347321837},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.8330488368849955,0.0748938579387212,0.12849462287939026}}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(np.array({0.3101789737125719},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{7.953666996580506}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto({{{0.5244321868233315,0.6494321868233315,0.7744321868233316}},{{0.8994321868233316,1.0244321868233315,1.1494321868233315}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{6.737493092569957,0.6079469879814192,1032.9410927044316}},{{0.5029025408066374,0.11919615975861762,3.7865699325227427}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(0.499, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{122.72400447840329}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto({0.4599012065473091}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{182.7752038727786}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(1.496, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),1.7691384960081784),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto(1.195, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.8126613757056474}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.8999651348346617,0.02161093498420561},{0.08234406546656904,0.24795109702705667},{0.04245759112370251,0.16645462321032622}},{{2.091165412386612,0.2093840337959872},{0.42019212359545555,0.08421156849100643},{0.6341160870085534,0.33175293554311674}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.18528467285312342,0.22619934269164724,0.0033065650970493295},{0.002271903551906364,0.3167563953888564,0.7217022440982512}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.4300027139314554,0.1667552109678178,215.03423113572126},{0.06297457985322293,0.02334063473052045,0.5682326292484139}},{{0.18082462909286898,0.31746665051622847,0.03015929122841152},{0.13580814734116398,0.23157234571935068,0.059344687742937066}}}),"values")
  check(r:raw_hex()=="c9d676a873e2d50a","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{10.069666324736094,0.7932819164250552},{2.2949154249682957,0.057554172916381784},{0.029231561046690786,0.2739344273801073}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.8211137390627314,0.17234840851407268,0.0234925965552745},{1.373777451424787,0.5863300671708016,0.09521755703073578}},{{1.1320481781786214,0.05645078138966316,0.36007693085484316},{1.102712399716469,4.823035739289152,0.49349790868125154}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.66181450621784,0.42950095639111663,5.128351043474408},{0.14509363833140518,0.21708714064603185,0.11111247589850862}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.035581211418647,0.4471919094945959},{1.64216327298575,0.056351459956970204},{0.06244137894458629,0.162236177278899}},{{1.414998140298284,0.27891055291371253},{0.5869903759421947,0.1523841689035126},{0.010024812545669075,0.013251419287418052}}}),"values")
  check(r:raw_hex()=="a87f366a5c2e4ff0","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.17404949990462457,0.017251704576192926,0.02672730858884773},{2.0268286478495945,0.06435767040705151,0.3606163880087441}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.2543831878606541,0.6649557570432044,0.020004116007037793},{0.0003782926481617441,0.11635462132514703,0.5030330631979786}},{{0.2517313223534554,0.4588532456549963,15.723016082127854},{1.7445730167451268,0.9295477549117629,0.00032198941117119774}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.9242236491868971,0.08016443700383777},{13.698102977449889,0.07603761852182585},{0.03920293747062496,0.3498131573954774}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.8240369534093155,0.5955809967018963,0.48804051914106616},{0.32285765910066744,0.044166228878177186,0.622908925264282}},{{0.4226056765368721,0.8679829106862393,0.013303412859374775},{1.8478400978143597,0.03584565740390189,0.43764718211730813}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.2239042994121228,0.48813299334482096,0.1494980350308187},{0.1549769933637613,0.20270030846579917,0.07059521479062976}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{3.589312562291196,0.1956173954869997},{1.4755506545967523,0.17654678733769855},{0.3874035126519092,0.0727668613534607}},{{0.20670343409364314,0.09620353569203119},{1.1713945963424333,0.20705561313101975},{0.7672069430744861,1.4206102517537904}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.1944613688696675,0.34406694577273783,0.38246204626833785},{0.3153525903069618,0.09510929525362848,0.35079293177586834}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.23855475367498793,0.04368890247930278,0.1714686760507007},{0.20272029463494584,0.02526241692062213,0.25980049063672567}},{{0.45671328783427095,0.4626097412006535,1.0169456679225697},{0.06969926499357258,0.34267141564527415,0.53686419986845}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.9737433235674251,0.29033164614497636},{0.009952531561279761,0.00045396834870136397},{0.2013520420052305,0.31213651884941124}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.30768350695067154,0.06363323635829635,1.4495544366717896},{0.4425712518830134,0.05937702125417627,0.8219955598779478}},{{0.13276299260203958,0.11659544592337952,0.004964522936281801},{1.1469892886974056,0.6832546436395182,0.07989879720067117}}}),"values")
  check(r:raw_hex()=="c9d676a873e2d50a","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.228665259618174,2.215860031777119,9.856467657694006},{0.047736771002254576,0.017437773236014895,0.43787327410888977}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{9.998875429252488,0.2198905661348566},{0.0721464615577569,0.1887430751404555},{0.36017786781388755,0.046526424430236635}},{{19.662746951926987,0.07105453850488602},{1.515882898074703,0.16026174980081154},{2.236679052315559,0.2220875208761652}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.4636488951703193,0.15364922882968213,0.35276992406097624},{1.2544780509890257,0.6341961559012768,0.15082873881815514}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.2673487608866271,1.0943644229066147,5.981026761114771},{0.04674372016393887,0.03701009967673988,0.25297263071566806}},{{0.3416490687818028,0.6356122023540579,1.5185384533331485},{0.12546260494114342,0.006002883984247457,0.01994283425708376}}}),"values")
  check(r:raw_hex()=="a87f366a5c2e4ff0","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.8999651348346617,0.02161093498420561},{0.08234406546656904,0.24795109702705667},{0.04245759112370251,0.16645462321032622}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.18528467285312342,0.22619934269164724,0.0033065650970493295},{0.002271903551906364,0.3167563953888564,0.7217022440982512}},{{0.18340483645485922,0.16306675582301267,0.5991373535936024},{426.4139922611213,4.171765548402828,0.0004293422526201452}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.4300027139314554,0.1667552109678178,215.03423113572126},{0.06297457985322293,0.02334063473052045,0.5682326292484139}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{10.069666324736094,0.7932819164250552},{2.2949154249682957,0.057554172916381784},{0.029231561046690786,0.2739344273801073}},{{3.0957944126670376,1.1838164015778518},{0.04044353540781212,0.23282979009030694},{0.02375656507126285,0.1990192584430444}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8211137390627314,0.17234840851407268,0.0234925965552745},{1.373777451424787,0.5863300671708016,0.09521755703073578}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.66181450621784,0.42950095639111663,5.128351043474408},{0.14509363833140518,0.21708714064603185,0.11111247589850862}},{{0.06463363538987552,0.2016621916637103,3.714954493025119},{0.1697850497823752,0.40725384998977376,2.766060586211572}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.035581211418647,0.4471919094945959},{1.64216327298575,0.056351459956970204},{0.06244137894458629,0.162236177278899}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.17404949990462457,0.017251704576192926,0.02672730858884773},{2.0268286478495945,0.06435767040705151,0.3606163880087441}},{{0.32596042242829293,0.1642637740094779,0.1240415536818078},{0.498201351016489,1.088932265938006,0.7735658813277088}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.2543831878606541,0.6649557570432044,0.020004116007037793},{0.0003782926481617441,0.11635462132514703,0.5030330631979786}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.9242236491868971,0.08016443700383777},{13.698102977449889,0.07603761852182585},{0.03920293747062496,0.3498131573954774}},{{0.6464790484540094,0.14780950096966372},{0.014967630630854907,0.1651074400500949},{0.41503293265076113,0.039181792181075106}}}),"values")
  check(r:raw_hex()=="c9d676a873e2d50a","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8240369534093155,0.5955809967018963,0.48804051914106616},{0.32285765910066744,0.044166228878177186,0.622908925264282}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{1.2239042994121228,0.48813299334482096,0.1494980350308187},{0.1549769933637613,0.20270030846579917,0.07059521479062976}},{{1.7440752645446023,0.1471578244519144,5.329666756824767},{0.1318702522256891,1.0232976739640507,0.35099413642473226}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{3.589312562291196,0.1956173954869997},{1.4755506545967523,0.17654678733769855},{0.3874035126519092,0.0727668613534607}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.1944613688696675,0.34406694577273783,0.38246204626833785},{0.3153525903069618,0.09510929525362848,0.35079293177586834}},{{0.24660596358379058,0.21750887805196487,0.1664284334462627},{1.0322934489906896,0.015074842412609242,0.02667843868796706}}}),"values")
  check(r:raw_hex()=="a87f366a5c2e4ff0","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.23855475367498793,0.04368890247930278,0.1714686760507007},{0.20272029463494584,0.02526241692062213,0.25980049063672567}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.9737433235674251,0.29033164614497636},{0.009952531561279761,0.00045396834870136397},{0.2013520420052305,0.31213651884941124}},{{0.9612518192605146,0.20782997381874752},{3.089378446919269,2.3586886534649123},{1.9906061301291158,0.00021464808940892916}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.30768350695067154,0.06363323635829635,1.4495544366717896},{0.4425712518830134,0.05937702125417627,0.8219955598779478}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{1.228665259618174,2.215860031777119,9.856467657694006},{0.047736771002254576,0.017437773236014895,0.43787327410888977}},{{0.5999732303681398,3.7690540758004376,0.08252275037190719},{0.19056359917592317,0.014186954409810102,0.31292294450399}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{9.998875429252488,0.2198905661348566},{0.0721464615577569,0.1887430751404555},{0.36017786781388755,0.046526424430236635}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.4636488951703193,0.15364922882968213,0.35276992406097624},{1.2544780509890257,0.6341961559012768,0.15082873881815514}},{{0.048093764392859825,0.0762494903593458,0.29492987626678596},{1.5623378970614035,1.349260159769833,4.859353990895548}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.2673487608866271,1.0943644229066147,5.981026761114771},{0.04674372016393887,0.03701009967673988,0.25297263071566806}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.8999651348346617,0.02161093498420561},{0.08234406546656904,0.24795109702705667},{0.04245759112370251,0.16645462321032622}},{{2.091165412386612,0.2093840337959872},{0.42019212359545555,0.08421156849100643},{0.6341160870085534,0.33175293554311674}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.18528467285312342,0.22619934269164724,0.0033065650970493295},{0.002271903551906364,0.3167563953888564,0.7217022440982512}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.4300027139314554,0.1667552109678178,215.03423113572126},{0.06297457985322293,0.02334063473052045,0.5682326292484139}},{{0.18082462909286898,0.31746665051622847,0.03015929122841152},{0.13580814734116398,0.23157234571935068,0.059344687742937066}}}),"values")
  check(r:raw_hex()=="c9d676a873e2d50a","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{10.069666324736094,0.7932819164250552},{2.2949154249682957,0.057554172916381784},{0.029231561046690786,0.2739344273801073}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.8211137390627314,0.17234840851407268,0.0234925965552745},{1.373777451424787,0.5863300671708016,0.09521755703073578}},{{1.1320481781786214,0.05645078138966316,0.36007693085484316},{1.102712399716469,4.823035739289152,0.49349790868125154}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.66181450621784,0.42950095639111663,5.128351043474408},{0.14509363833140518,0.21708714064603185,0.11111247589850862}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.035581211418647,0.4471919094945959},{1.64216327298575,0.056351459956970204},{0.06244137894458629,0.162236177278899}},{{1.414998140298284,0.27891055291371253},{0.5869903759421947,0.1523841689035126},{0.010024812545669075,0.013251419287418052}}}),"values")
  check(r:raw_hex()=="a87f366a5c2e4ff0","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.17404949990462457,0.017251704576192926,0.02672730858884773},{2.0268286478495945,0.06435767040705151,0.3606163880087441}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.2543831878606541,0.6649557570432044,0.020004116007037793},{0.0003782926481617441,0.11635462132514703,0.5030330631979786}},{{0.2517313223534554,0.4588532456549963,15.723016082127854},{1.7445730167451268,0.9295477549117629,0.00032198941117119774}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.9242236491868971,0.08016443700383777},{13.698102977449889,0.07603761852182585},{0.03920293747062496,0.3498131573954774}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.8240369534093155,0.5955809967018963,0.48804051914106616},{0.32285765910066744,0.044166228878177186,0.622908925264282}},{{0.4226056765368721,0.8679829106862393,0.013303412859374775},{1.8478400978143597,0.03584565740390189,0.43764718211730813}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.2239042994121228,0.48813299334482096,0.1494980350308187},{0.1549769933637613,0.20270030846579917,0.07059521479062976}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{3.589312562291196,0.1956173954869997},{1.4755506545967523,0.17654678733769855},{0.3874035126519092,0.0727668613534607}},{{0.20670343409364314,0.09620353569203119},{1.1713945963424333,0.20705561313101975},{0.7672069430744861,1.4206102517537904}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.1944613688696675,0.34406694577273783,0.38246204626833785},{0.3153525903069618,0.09510929525362848,0.35079293177586834}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.23855475367498793,0.04368890247930278,0.1714686760507007},{0.20272029463494584,0.02526241692062213,0.25980049063672567}},{{0.45671328783427095,0.4626097412006535,1.0169456679225697},{0.06969926499357258,0.34267141564527415,0.53686419986845}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.9737433235674251,0.29033164614497636},{0.009952531561279761,0.00045396834870136397},{0.2013520420052305,0.31213651884941124}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.30768350695067154,0.06363323635829635,1.4495544366717896},{0.4425712518830134,0.05937702125417627,0.8219955598779478}},{{0.13276299260203958,0.11659544592337952,0.004964522936281801},{1.1469892886974056,0.6832546436395182,0.07989879720067117}}}),"values")
  check(r:raw_hex()=="c9d676a873e2d50a","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{1.228665259618174,2.215860031777119,9.856467657694006},{0.047736771002254576,0.017437773236014895,0.43787327410888977}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{9.998875429252488,0.2198905661348566},{0.0721464615577569,0.1887430751404555},{0.36017786781388755,0.046526424430236635}},{{19.662746951926987,0.07105453850488602},{1.515882898074703,0.16026174980081154},{2.236679052315559,0.2220875208761652}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.4636488951703193,0.15364922882968213,0.35276992406097624},{1.2544780509890257,0.6341961559012768,0.15082873881815514}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.2673487608866271,1.0943644229066147,5.981026761114771},{0.04674372016393887,0.03701009967673988,0.25297263071566806}},{{0.3416490687818028,0.6356122023540579,1.5185384533331485},{0.12546260494114342,0.006002883984247457,0.01994283425708376}}}),"values")
  check(r:raw_hex()=="a87f366a5c2e4ff0","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.8999651348346617,0.02161093498420561},{0.08234406546656904,0.24795109702705667},{0.04245759112370251,0.16645462321032622}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.18528467285312342,0.22619934269164724,0.0033065650970493295},{0.002271903551906364,0.3167563953888564,0.7217022440982512}},{{0.18340483645485922,0.16306675582301267,0.5991373535936024},{426.4139922611213,4.171765548402828,0.0004293422526201452}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.4300027139314554,0.1667552109678178,215.03423113572126},{0.06297457985322293,0.02334063473052045,0.5682326292484139}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{10.069666324736094,0.7932819164250552},{2.2949154249682957,0.057554172916381784},{0.029231561046690786,0.2739344273801073}},{{3.0957944126670376,1.1838164015778518},{0.04044353540781212,0.23282979009030694},{0.02375656507126285,0.1990192584430444}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8211137390627314,0.17234840851407268,0.0234925965552745},{1.373777451424787,0.5863300671708016,0.09521755703073578}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.66181450621784,0.42950095639111663,5.128351043474408},{0.14509363833140518,0.21708714064603185,0.11111247589850862}},{{0.06463363538987552,0.2016621916637103,3.714954493025119},{0.1697850497823752,0.40725384998977376,2.766060586211572}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{1.035581211418647,0.4471919094945959},{1.64216327298575,0.056351459956970204},{0.06244137894458629,0.162236177278899}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.17404949990462457,0.017251704576192926,0.02672730858884773},{2.0268286478495945,0.06435767040705151,0.3606163880087441}},{{0.32596042242829293,0.1642637740094779,0.1240415536818078},{0.498201351016489,1.088932265938006,0.7735658813277088}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.2543831878606541,0.6649557570432044,0.020004116007037793},{0.0003782926481617441,0.11635462132514703,0.5030330631979786}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:pareto(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{1.9242236491868971,0.08016443700383777},{13.698102977449889,0.07603761852182585},{0.03920293747062496,0.3498131573954774}},{{0.6464790484540094,0.14780950096966372},{0.014967630630854907,0.1651074400500949},{0.41503293265076113,0.039181792181075106}}}),"values")
  check(r:raw_hex()=="c9d676a873e2d50a","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:pareto(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8240369534093155,0.5955809967018963,0.48804051914106616},{0.32285765910066744,0.044166228878177186,0.622908925264282}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:pareto(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{1.2239042994121228,0.48813299334482096,0.1494980350308187},{0.1549769933637613,0.20270030846579917,0.07059521479062976}},{{1.7440752645446023,0.1471578244519144,5.329666756824767},{0.1318702522256891,1.0232976739640507,0.35099413642473226}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(np.array({0.736593421325699},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.38319982618384857}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(np.array({{0.9893219130038338,1.1143219130038338,1.2393219130038338},{1.3643219130038338,1.4893219130038338,1.6143219130038338}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.6550632251473592,0.3041099895846625,0.9962633044362108},{0.4206066202900668,0.22571842071044632,0.8940898365955819}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(1.299, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.9297052937147282}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(np.array({1.0506274697308955},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{0.9132668893852286}}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power({{0.4000965550415903},{0.5250965550415903}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.5410326834796332,0.18640470727469985,0.6406664096984305},{0.32746830601253824,0.4092621154089354,0.1309736060144771}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power({0.7106407996479764}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.3863549328563983}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power({0.32606831199822445}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.10109940324151834,0.00046592619646604604,0.002757906961812385}}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(1.198, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.5544571169998047),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power({0.7580966529205226}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.5757688961290607,0.17382401501535144,0.9938985696801553}),"values")
  check(r:raw_hex()=="4fd42fa03fcd72a9","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power({1.193987146665469}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.9237644154209075,0.9183534164008698,0.9222553388058026}}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power({{{0.5059351086430968}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1,1}),"shape");check(same(x:tolist(),{{{0.8282796771513761}}}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.array({{0.6885665377868444,0.8135665377868444,0.9385665377868444}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.6998219991949757,0.4377483946051466,0.8271231203075229},{0.4268458919773086,0.5617924772120816,0.32069625173395716}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(np.array({0.32504946845949606},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.1250395418320522,0.45112350405996304,0.6214924834726228}}),"values")
  check(r:raw_hex()=="2c4b5eeb383c1bce","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power({0.9249247220332615,1.0499247220332615,1.1749247220332615}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.4457989812535976,0.0923210759437817,0.19485101663208795}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(np.array({{0.636046849916649,0.761046849916649,0.886046849916649}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.3292857891683953,0.5554743670234109,0.01182825507142541},{6.95243595457955e-05,0.3231121731818877,0.7818203848283826}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(0.765, nil);cases=cases+1
  check(same(x,0.578644348949026),"scalar")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(1.678, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.9451374328362486),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(np.array({0.9685558205453071},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.9062727382477735}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(1.081, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.7966388158862975}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(np.array({1.115051672069404},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.5454810503452129}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power({{0.6971470428920366},{0.8221470428920366}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1}),"shape");check(same(x:tolist(),{{0.3423756513840342},{0.04771282628873834}}),"values")
  check(r:raw_hex()=="39ee1852018c694c","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(1.768, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.6705705369064409,0.7764062162218068,0.10820051337496903}},{{0.031929195202512986,0.6148908276304778,0.8839541573259079}}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power({0.5486657052703905,0.6736657052703905,0.7986657052703905}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.4663721892918238,0.13959576926068626,0.9942075987579321}),"values")
  check(r:raw_hex()=="4fd42fa03fcd72a9","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power({{0.9850748320652161,1.110074832065216,1.235074832065216},{1.360074832065216,1.485074832065216,1.610074832065216}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9083590269053017,0.9124597195082077,0.9247417951110809},{0.35453216707618607,0.186836819065039,0.8474506051554164}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power({{{0.8705126607952871,0.9955126607952871,1.120512660795287}},{{1.245512660795287,1.370512660795287,1.495512660795287}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.8962829181188714,0.5469559680789532,0.16195862100318933}},{{0.6446092093935998,0.691042225718789,0.38380621242186924}}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.array({{{0.9797197655170184}},{{1.1047197655170184}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,1}),"shape");check(same(x:tolist(),{{{0.7781336480420712}},{{0.5442284436634756}}}),"values")
  check(r:raw_hex()=="ec59dd7c2bde3cb4","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(np.array({0.8005562345302468,0.9255562345302468,1.0505562345302468},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.4299070559304635,0.7561200605239621,0.8631526583399148}),"values")
  check(r:raw_hex()=="2c4b5eeb383c1bce","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(np.array({0.9920892278415829},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{0.47086063020872126}}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(np.array({{{0.9881292275451012,1.1131292275451012,1.2381292275451012}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.48917872308289223,0.6690008988482955,0.04177508390817805}},{{0.0021068508915166886,0.46189651983739743,0.8385013624439255}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power({{0.7708118034214169}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.5810360725160186,0.17891418213261603,0.9939989149908667},{0.2159076415624814,0.056363279785087185,0.7910007244476537}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power({0.38562902229997637}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.7822948061184121}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power({0.6868892085789495,0.8118892085789495,0.9368892085789496}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.8704272043575628,0.4771836401562622,0.1133582241864245}),"values")
  check(r:raw_hex()=="559eb9afdd730ddf","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.array({{0.5299349714812747}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.6289062816880493,0.2813202063155679,0.7145106595707269},{0.3308231393128702,0.41261408717539555,0.13342711029822604}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(np.array({{{0.7507648928875301,0.8757648928875301,1.0007648928875301}},{{1.1257648928875301,1.2507648928875301,1.3757648928875301}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.4064991810583938,0.7441972754775695,0.856855840145213}},{{0.28121922895603885,0.23811849151963269,0.6850427781679272}}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(1.081, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.5009524836821867}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power({1.2444702266182075}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.5668031880615861}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power({{{0.9672793434414824}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.6487787873153568,0.25377143816329567,0.9952148951199197}},{{0.2947726594921417,0.10108479610307199,0.8295805022960573}}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(np.array({1.0924738428735614,1.2174738428735614,1.3424738428735616},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.9169827333134042,0.919863603684944,0.9305482048866889}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(0.257, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.6901153546731542),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power({{0.8421758244702471}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.7468978244625756,0.450207170894102,0.809348757616265},{0.49854926809672007,0.5729055059382391,0.28155559685574466}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(0.532, nil);cases=cases+1
  check(same(x,0.28073737970025303),"scalar")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power({0.9568745787805328}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.45798815937520454}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power({0.9336736568089314}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.46919790990962323,0.6192600449900568,0.014832734802997214}}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(np.array({0.7259745160653972},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.5618752742682553}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(np.array({0.9034825547606067,1.0284825547606067,1.1534825547606067},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.9005085309028735,0.9058522094991894,0.9196380364774445}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(np.array({{{0.6484923185306717,0.7734923185306717,0.8984923185306718}},{{1.0234923185306717,1.1484923185306717,1.2734923185306717}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.8633045828131037,0.45997602146336025,0.10328690710930172}},{{0.5860413852650385,0.6433961789564643,0.3247926457269989}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(1.043, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.7900672982231003),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power({0.5044963556771878}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.2619528985220334}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(np.array({{0.5343455191912017},{0.6593455191912017}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.2469890534926978,0.009267029497114209,0.027427772696852787},{0.544305719546841,0.03875362636264866,0.4643170684736452}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(1.465, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.6173744921406875),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(1.306, nil);cases=cases+1
  check(same(x,0.7258230442745695),"scalar")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(np.array({1.1383323664090494,1.2633323664090494,1.3883323664090494},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.9201899068349253,0.9226569597693469,0.932763349984036}}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(1.615, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.9426861032243891),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.array({{{0.9855744565449744}},{{1.1105744565449744}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.7792940770224193,0.5056383910503526,0.8346448748163199}},{{0.5898813042790941,0.6554633418321489,0.3824644009023116}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(np.array({{{0.703264642847176,0.828264642847176,0.9532646428471762}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.382520389442102,0.7316940097058714,0.8502852005447028}},{{0.13123444062618198,0.11452319266730426,0.5793025911254684}}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(1.412, nil);cases=cases+1
  check(same(x,0.5890742100018216),"scalar")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power({{{0.6256520603732307}},{{0.7506520603732307}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.32326433093676016,0.48911143223333653,0.0018658434009465583}},{{0.0002998716760320554,0.3180965816217202,0.7478710869778578}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(np.array({{{0.9765232394589787}},{{1.1015232394589787}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.6514414061721616,0.25708714619304557,0.995260084023742}},{{0.3420908049688071,0.1336552164645421,0.8486865883648836}}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(np.array({{{0.8248792513348613,0.9498792513348613,1.0748792513348615}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.891560760537607,0.898470469626778,0.9140213070301584}},{{0.1809108553459696,0.07260702440475071,0.7804079198427696}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(np.array({{{0.9895237032122433,1.1145237032122433,1.2395237032122433}},{{1.3645237032122433,1.4895237032122433,1.6145237032122433}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.9081646524178462,0.5833568870666614,0.1928910041183607}},{{0.6697755431119725,0.7117508004315636,0.4118776856820063}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.array({{{1.0492583218333056,1.1742583218333056,1.2992583218333058}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1,3}),"shape");check(same(x:tolist(),{{{0.7911784887883732,0.5641934519896618,0.871874157680905}}}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power({{{0.8651724038661415,0.9901724038661415,1.1151724038661417}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.4578848968344613,0.7700405988856723,0.8705442928266225}},{{0.19190917579869668,0.16322182109681824,0.6270877971561392}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(1.016, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.47928143153411473),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(np.array({0.6631972966584272},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{0.34460607683191735}}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(np.array({{{0.5318171092265342,0.6568171092265342,0.7818171092265344}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.4552371569461801,0.13272007515159834,0.9940831392931234}},{{0.10841589495030486,0.03421557866761649,0.7936156104896399}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(0.801, nil);cases=cases+1
  check(same(x,0.8885151882436143),"scalar")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(0.487, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.8222343864536477}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.array({0.8951847577930223},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.7599169178539058}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(0.642, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.34900225893364173,0.6682933925639511,0.7859863790216478}),"values")
  check(r:raw_hex()=="2c4b5eeb383c1bce","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(np.array({0.7235757778242926},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.35604528388184686,0.031523053596713965,0.07024841146267832}}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(np.array({1.2610667964005666},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.5710541571493463}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(0.304, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.2524187364008133),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(np.array({{0.44532740584040525}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.8084714274951058,0.7958368601468641,0.8049352145001636},{0.0421311098601202,0.003719443249951313,0.5496656855756649}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(1.147, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.9202553423908764),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.array({1.1681366815255692},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.8102645239016325,0.5625037160140947,0.8585583805454305}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power({0.7067825978780897}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.384354432054824}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(np.array({{0.46638324201862696,0.5913832420186269,0.716383242018627},{0.841383242018627,0.966383242018627,1.091383242018627}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.20145475129295376,0.014555429860252588,0.06840008809996344},{0.6208614383336951,0.10885076073563583,0.6290863215508884}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(1.217, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.55958586664186),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power({0.8727780789152715,0.9977780789152715,1.1227780789152715}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.6190862284203683,0.26463478677325314,0.9958762379881121}}),"values")
  check(r:raw_hex()=="4fd42fa03fcd72a9","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power({{{0.5912254738056097,0.7162254738056097,0.8412254738056099}},{{0.9662254738056099,1.09122547380561,1.21622547380561}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.8520213469318527,0.8676316467787436,0.891480359948673}},{{0.2323206940525393,0.10198019855741831,0.8032222563983494}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(0.69, nil);cases=cases+1
  check(same(x,0.8709719444021606),"scalar")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power({{{0.8529733997190132,0.9779733997190132,1.1029733997190132}},{{1.2279733997190132,1.3529733997190132,1.4779733997190132}}}, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.7496620894236302,0.5029655163435933,0.8508577847199893}},{{0.6204123121369561,0.7069938340144005,0.4856817240853715}}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(0.855, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.4536492013191686),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power({0.9018481692120153,1.0268481692120153,1.1518481692120153}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.43667790511334903,0.08750802214541845,0.18856987639925918}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power({{1.2143842630183057}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.5588865417328703,0.6918032155106589,0.03926015443559001},{0.006641626159187206,0.49262320362730766,0.8356184781045471}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(1.996, nil);cases=cases+1
  check(same(x,0.8108497033389616),"scalar")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(1.588, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9421198181760072,0.9379675272774427,0.9409623916770337},{0.4114276135766714,0.20829658145904095,0.8455029171741941}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(1.211, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.924305954780491}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power({{{1.0827243122760013}},{{1.2077243122760013}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.7969273123512199,0.5375435488026588,0.8482915937539915}},{{0.6154665041054445,0.6781180925249302,0.4132069080526545}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(0.988, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.5045810074780667),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power({{{1.1355624249911842,1.2605624249911842,1.3855624249911842}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1,3}),"shape");check(same(x:tolist(),{{{0.5178702392832463,0.13746660718454284,0.24985289375100073}}}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(np.array({0.9777832426625446},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.48549168495532985}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(np.array({1.00064594955453},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.6582066892599879,0.2656449948350274,0.9953740851272923}),"values")
  check(r:raw_hex()=="4fd42fa03fcd72a9","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(1.62, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{0.9432300389807524}}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(0.309, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.7345624429708862),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.array({0.8750439334515601},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.7551299841768667}),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power({0.7164467950289415,0.8414467950289415,0.9664467950289415}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.38934398684772964,0.7352836705677971,0.8521682424811594}}),"values")
  check(r:raw_hex()=="2c4b5eeb383c1bce","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power({0.9710182919655934}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.4632273555804918}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power({{{0.4759685743754521,0.600968574375452,0.7259685743754521}},{{0.8509685743754521,0.9759685743754521,1.100968574375452}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.22663271640021412,0.4749533013979447,0.004446249595657834}},{{0.000780283202909269,0.41438161436494153,0.8203019320840729}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(0.505, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.4366053321756516}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(1.912, nil);cases=cases+1
  check(same(x,0.9516867248204641),"scalar")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power({{{0.455561017624086}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.8112026307784853,0.2675232843430932,0.01136121028859919}},{{0.3010321962847207,0.3289762720881157,0.043124657248942745}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.array({{1.2288402393685398}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.818729754296408,0.5787206343213596,0.8650506566488874},{0.620621267205917,0.6826594669049051,0.4195301768360587}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power({{1.0854907944667878}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.5365515575059656,0.7879143547543256,0.8672504165905441},{0.2682893109689825,0.19138381647947258,0.6191366394480486}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(np.array({0.6208081325191739},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.3000973003546525}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(np.array({1.0181560675992325},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.4996036391057785}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power({{{1.1533375823830443,1.2783375823830443,1.4033375823830445}},{{1.5283375823830445,1.6533375823830445,1.7783375823830445}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.695679983738717,0.3542907830011685,0.9966993107013812}},{{0.46157296345597126,0.2616344617545793,0.9033691655673323}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(np.array({0.6897140877556476},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.8717297949370617}),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power({0.7558411037006618}, {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{0.8815163785233159}}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.array({{0.9905780235837158,1.1155780235837158,1.240578023583716},{1.365578023583716,1.490578023583716,1.615578023583716}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.7802762875502247,0.5474607110880554,0.8662379860941012},{0.6509854675828629,0.7299901766669147,0.5164952317339743}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(1.691, nil);cases=cases+1
  check(same(x,0.6705505712440714),"scalar")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(np.array({{{1.0777928603490656}},{{1.2027928603490656}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.4999231316669413,0.09818716833493621,0.1681473049014867}},{{0.7164645104877334,0.16832273890666805,0.6566816211436571}}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(1.033, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.5046104758508081),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(0.418, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.367433996873881,0.04186407927368131,0.9889617501643917},{0.05920503970834157,0.004974826327432798,0.6489830363357609}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(np.array({{1.0799040618846634,1.2049040618846634,1.3299040618846636}},"float64"), {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.916058170117452,0.9190623845541748,0.9299153285899215},{0.2709056819226611,0.1264908177689755,0.8184087424526256}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power({0.8575298472233643}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.8947982973099805}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power({{1.256840156785333,1.381840156785333,1.506840156785333},{1.631840156785333,1.756840156785333,1.881840156785333}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8223858521274795,0.6148495309124865,0.8884988515303363},{0.6982167588279626,0.7656536093565288,0.5671065328038362}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(np.array({{{1.1704865519154006,1.2954865519154006,1.4204865519154009}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.5613657683860701,0.818954089767109,0.8968751700764468}},{{0.2951860055821238,0.2502113049665533,0.6932499513882373}}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(1.09, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.5038198547432025,0.10077270742845656,0.17153848596205368}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(np.array({0.5008079908006966},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.2439482761668343}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power({1.2874987765422414}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.7224884438318362}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power({0.31993937658238863}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.7438363013173972,0.7277057747750826,0.7393115979486538}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(1.537, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.9398667405903641),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(1.789, {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.8716405350933478,0.6868202666015525,0.9052211107421194}},{{0.7206018812869733,0.7693377082585104,0.5506568891531397}}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(np.array({{0.9364094000355503,1.0614094000355503,1.1864094000355503},{1.3114094000355503,1.4364094000355503,1.5614094000355503}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.4859193071780444,0.783664755390368,0.8778212324476444},{0.33654162400199755,0.2866405721882843,0.7165559635095904}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power({{{0.5999764562743144,0.7249764562743144,0.8499764562743145}},{{0.9749764562743145,1.0999764562743146,1.2249764562743146}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.2878141874589958,0.031734304172423566,0.10426873749514773}},{{0.6627640858632208,0.14249815024056456,0.6617020141774133}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(np.array({1.1422901521263484,1.2672901521263484,1.3922901521263484},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.5387364037460377,0.7025267492372625,0.05937667316591854}}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power({{{0.805625485335985,0.930625485335985,1.0556254853359852}},{{1.1806254853359852,1.3056254853359852,1.4306254853359852}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.5948296963675342,0.2404285113022601,0.995614484900554}},{{0.3675818512121881,0.18306966825080528,0.8813296052291069}}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(1.894, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.9512389502212051),"values")
  check(r:raw_hex()=="705a5661a791ffc1","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(np.array({{{1.2256268508398995}},{{1.3506268508398995}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.9251746232252797,0.6125653068982669,0.18932520497105748}},{{0.6670190523845329,0.6872924108620247,0.3463366420089038}}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.array({0.7159168107478466,0.8409168107478466,0.9659168107478467},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.7094300036538543,0.44966957108197947,0.8315802962795426}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(np.array({0.7865712808884291},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.42350262374048275}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power({{1.0897692526269807,1.2147692526269807,1.3397692526269807},{1.4647692526269807,1.5897692526269807,1.7147692526269807}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.5037467279447011,0.12755862321505182,0.2382853263335147},{0.7604897276847932,0.25972428609815945,0.7445381906158092}}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power({{0.755229170354494},{0.880229170354494}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.3923779039450756,0.5529643325664315,0.0054842842491218905},{0.000989828767547089,0.376518643513169,0.7805495976316029}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power({0.9698321191529482}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.6495180695842396}),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(np.array({{0.5360016507863057,0.6610016507863057,0.7860016507863058}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.8380787786955527,0.8574001854676732,0.884314354798185}}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(np.array({0.650679450929561},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.8637312216225463}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(1.503, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.8491500881815475),"values")
  check(r:raw_hex()=="615481f7fce9ac81","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(np.array({{{0.9009670993137635}},{{1.0259670993137635}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.4723176731524408,0.7503731184723736,0.8423180892230613}},{{0.24857220317725184,0.17387750191043108,0.6021525785052293}}}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(np.array({0.725906853827549},"float64"), {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.3572279826771334}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power({1.2095155758588128}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.5575791796532676}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(np.array({1.1158176040585284},"float64"), {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.6872431840328354,0.3045956205351414,0.9958505673873617}}),"values")
  check(r:raw_hex()=="4fd42fa03fcd72a9","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power({{{0.5193755586412803}},{{0.6443755586412803}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.8333531122075719,0.8221739534093051,0.8302267712942841}},{{0.11206351037757871,0.02093916448257989,0.6612754187032263}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(np.array({{1.2563202424628825,1.3813202424628825,1.5063202424628825},{1.6313202424628825,1.7563202424628825,1.8813202424628825}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9269342011575675,0.6473560148956603,0.25816427268010567},{0.7151512836407483,0.7494804569704133,0.4670886459190741}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power({0.9064345228069415}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.7625106709514123,0.4764118958340901,0.821576714712626}}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(np.array({{0.5818325898887615},{0.7068325898887615}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1}),"shape");check(same(x:tolist(),{{0.3130055411218445},{0.6934603753889698}}),"values")
  check(r:raw_hex()=="bbf870193643edf7","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(1.976, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.6851241208559034),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power({{0.998291762171037}}, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.4927524086069961,0.6387704858724262,0.019480300985103522},{0.0022432568664623913,0.4226257298263231,0.8037587562753594}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(np.array({{0.794948876246867,0.919948876246867,1.044948876246867}},"float64"), {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.5906940671342387,0.23648407707230032,0.995569775956626},{0.22619430555764794,0.08984168782658178,0.8411814045037325}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(0.467, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.8164879603453148,0.8043158368626486,0.8130820735374084}},{{0.048801424577419095,0.004822003255533918,0.5651453532711994}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power({0.6148863971708418}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.8563970535420504}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.array({1.2443202568305523},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.8207693913572977,0.5826717762740412,0.8666121576852576}),"values")
  check(r:raw_hex()=="42fe46521ada3e8e","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power({{0.7077556257420796,0.8327556257420796,0.9577556257420796},{1.0827556257420796,1.2077556257420796,1.3327556257420796}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.3848600280147049,0.7329277402651334,0.8509320794782155},{0.26739910828670194,0.2262560305885707,0.6767311210516956}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(1.88, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.6720212515872065,0.2643327366290194,0.3598260603698697}}),"values")
  check(r:raw_hex()=="dea52811c4b322f6","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(0.804, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.4152890892136977,0.573198668225793,0.00752082481845128}),"values")
  check(r:raw_hex()=="043b27b61342f01d","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(1.337, nil);cases=cases+1
  check(same(x,0.7312359992067298),"scalar")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(0.576, {1,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,3}),"shape");check(same(x:tolist(),{{{0.8484222811944591,0.8381530285813203,0.8455517745995467},{0.08642281993119466,0.013232579675319106,0.629593750403966}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power({0.6936301569226297}, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.8716018788935823}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power({{0.520080778966362}}, {2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.6234041001129714,0.2746405765361502,0.7099741771343566},{0.32396154133619187,0.4057510013547369,0.12843095341662134}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(1.564, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.6491385819949221}),"values")
  check(r:raw_hex()=="e298cc4552266400","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(np.array({0.38900372825367063},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.14647600535379357}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(1.5, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.6243611607424554}),"values")
  check(r:raw_hex()=="4510bdf882d9d721","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power({1.2262162104262284,1.3512162104262284,1.4762162104262284}, {1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,3}),"shape");check(same(x:tolist(),{{0.7108462912289808,0.3746842097952956,0.9968620049452304}}),"values")
  check(r:raw_hex()=="4fd42fa03fcd72a9","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(np.array({{{0.3519961475158399}},{{0.4769961475158399}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.7641561298008156,0.7490791234412781,0.7599299772042633}},{{0.05198981869950532,0.005392359448907278,0.5719446542020981}}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power({{{0.8803560244238597,1.0053560244238597,1.1303560244238597}},{{1.2553560244238597,1.3803560244238597,1.5053560244238597}}}, {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.8973809298420546,0.5501967918656259,0.16454653291115318}},{{0.6468324954240873,0.6928657337965644,0.38621705479135815}}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power({{{0.7829307952532665}},{{0.9079307952532665}}}, nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,1}),"shape");check(same(x:tolist(),{{{0.7305850194985347}},{{0.4769944025413601}}}),"values")
  check(r:raw_hex()=="ec59dd7c2bde3cb4","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power({0.45047484501503393,0.575474845015034,0.700474845015034}, {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.2230775175094723,0.6378716372732498,0.8019469782690974}),"values")
  check(r:raw_hex()=="2c4b5eeb383c1bce","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(1.748, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.652150537624058),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(np.array({{{1.1161333528165611}}},"float64"), {1,2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,2,1,3}),"shape");check(same(x:tolist(),{{{{0.5309835606645253,0.6697250965100343,0.029524361012667092}},{{0.004271434481599985,0.4628577967839691,0.82251260770849}}}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(0.546, {});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{}),"shape");check(same(x:tolist(),0.4646386326001746),"values")
  check(r:raw_hex()=="f35196bbc152a866","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(np.array({{{0.33958964294309174,0.46458964294309174,0.5895896429430918}}},"float64"), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1,3}),"shape");check(same(x:tolist(),{{{0.7566835591539925,0.8034076446577626,0.8488277602614906}}}),"values")
  check(r:raw_hex()=="b286b60e1600888d","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(np.array({0.646334663413344},"float64"), {1,1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1,1}),"shape");check(same(x:tolist(),{{0.8628810733507456}}),"values")
  check(r:raw_hex()=="8d199af4a27c736b","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.array({{{1.056750248671809}}},"float64"), {2,1,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,1,3}),"shape");check(same(x:tolist(),{{{0.792493416664548,0.52940427081588,0.8448680004455612}},{{0.5742338961967927,0.6415116359680317,0.364192360122013}}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(np.array({0.4615795170172669},"float64"), {3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3}),"shape");check(same(x:tolist(),{0.23127603960958126,0.5708880933715754,0.7153774268943333}),"values")
  check(r:raw_hex()=="2c4b5eeb383c1bce","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(0.498, {1});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{1}),"shape");check(same(x:tolist(),{0.22302498606361107}),"values")
  check(r:raw_hex()=="1c2be53ed153a982","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.4933485078533116,0.8941684451233133},{0.1400421340124417,0.29585633083444557},{0.7508127343812763,0.9643054712242402}},{{0.49012156920417915,0.8532883206644244},{0.9696402293383198,0.999531631067382},{0.9873789976133432,0.3298060957253151}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9006607577311033,0.7669833798201101,0.9992270251376048},{0.3067933395354423,0.33008560569355466,0.9415379858128432}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.9689324849878161,0.9504233899416021,0.9078890085127},{0.7905263118820468,0.6075939606630099,0.9355450361323049}},{{0.910915281016705,0.9777689512223305,0.07623188551331231},{0.9304466238908341,0.5841417670098908,0.9025117814023788}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.9090816141675347,0.8605618029949245},{0.36063147287792524,0.8963864370314947},{0.8446556033568957,0.7876604485854113}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.9404071241001024,0.8742234702845911,0.9707461687410022},{0.5564383518565168,0.7909183904546437,0.7006138992518157}},{{0.6433344169531088,0.7898817408380374,0.9610500348284488},{0.6097314092935042,0.9048803898428324,0.9983402198423209}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.7982983707584881,0.878647060997469,0.8567545958181781},{0.7881805309504436,0.6983979297976614,0.8780040963659034}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.47367455240855155,0.5350704258732282},{0.3825842233699439,0.9229237875132194},{0.4894819603173488,0.9191490766811381}},{{0.6764974155077891,0.8542566354157032},{0.7100709993342779,0.8023557020056715},{0.9168962119263004,0.9676133614568386}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8380857468281573,0.914398430111045,0.5193014955819892},{0.0022667537061101554,0.6505751117387505,0.9298850418330038}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.8697911563106514,0.5151869846062266,0.995371103946153},{0.8212479928548525,0.6418752564363025,0.9558249979443315}},{{0.7322612994424613,0.6510527399336621,0.02927633763555938},{0.9007859024739122,0.9166192376872777,0.6736550642929997}}}),"values")
  check(r:raw_hex()=="c9d676a873e2d50a","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.9096630403605377,0.9748966047441144},{0.9528320988047685,0.7542226933369605},{0.43586876443325356,0.9565546763578808}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.9764515937486067,0.8867999346115149,0.7117943589817716},{0.5787305168815295,0.7762819733793965,0.6204089822657713}},{{0.9876749367747116,0.7517617012411908,0.9717469843132014},{0.5244237870405669,0.9851437524500788,0.8878266058934422}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9213427313907444,0.7145887168636053,0.836823968975338},{0.9069211065948574,0.910442807964997,0.7657888905656997}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.5087398162301393,0.93736175567252},{0.9256103909411227,0.7515378251355923},{0.5497580182171787,0.9169191182344634}},{{0.5859210061849212,0.8895661792873591},{0.7764948932755792,0.8732997801181315},{0.3089223128846581,0.6507570092104449}}}),"values")
  check(r:raw_hex()=="a87f366a5c2e4ff0","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8296024259342744,0.6063575060510964,0.725953860375211},{0.66962120544536,0.3424562021255833,0.8448350251637887}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.7901652743207939,0.7995372082542436,0.019611799298758684},{0.36243827583586635,0.8420133514822534,0.9469388752444093}},{{0.788438709518636,0.7281009581823136,0.9402021743512694},{0.999609677319386,0.9924081703617725,0.1894035075943656}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.6580288924624292,0.7177652712455699},{0.997682867421383,0.7895309975217343},{0.4776220746680189,0.9703288029389023}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.9766076849094162,0.9798663560258669,0.9840234762906371},{0.24406077016642835,0.28776211782692906,0.9149968488621302}},{{0.9324133666022276,0.9910475606497954,0.6511625925655251},{0.6488566894020935,0.2607928318069429,0.87217541361612}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9687260045764993,0.7405666167738751,0.13005505923010174},{0.9128779784067094,0.9036657045639723,0.6990505112492773}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.7821024420483678,0.8453334944645251},{0.9147808311149387,0.8893719152885776},{0.8552395623223069,0.8370268211065973}},{{0.17129596904553307,0.744650684940534},{0.8876423128620813,0.9057903999994398},{0.9355366036912797,0.9991697652763123}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8445472112497039,0.9495673738097351,0.9745618512383254},{0.23974757234740263,0.4076217586611057,0.8407406693838657}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.7795189628816361,0.28630036064415776,0.14637068797158312},{0.9353443626064536,0.651391390864643,0.8812090179561161}},{{0.8778535045406186,0.7297543991517577,0.50420082409558},{0.8323496209478132,0.9492751390110631,0.9518155269150165}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.4933485078533116,0.8941684451233133},{0.1400421340124417,0.29585633083444557},{0.7508127343812763,0.9643054712242402}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.9006607577311033,0.7669833798201101,0.9992270251376048},{0.3067933395354423,0.33008560569355466,0.9415379858128432}},{{0.7915886553083786,0.8422605670717944,0.5551616499844165},{0.5342314909234096,0.8044006624245613,0.590541068255764}}}),"values")
  check(r:raw_hex()=="c9d676a873e2d50a","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9689324849878161,0.9504233899416021,0.9078890085127},{0.7905263118820468,0.6075939606630099,0.9355450361323049}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.9090816141675347,0.8605618029949245},{0.36063147287792524,0.8963864370314947},{0.8446556033568957,0.7876604485854113}},{{0.9516037242131187,0.7000035553546626},{0.9176130991392843,0.8788939530878332},{0.9900711485074974,0.9422455125355823}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9404071241001024,0.8742234702845911,0.9707461687410022},{0.5564383518565168,0.7909183904546437,0.7006138992518157}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.7982983707584881,0.878647060997469,0.8567545958181781},{0.7881805309504436,0.6983979297976614,0.8780040963659034}},{{0.8367833357933665,0.79132798733191,0.602944319283053},{0.8932426658142342,0.4942077671273476,0.5249625006424696}}}),"values")
  check(r:raw_hex()=="a87f366a5c2e4ff0","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.47367455240855155,0.5350704258732282},{0.3825842233699439,0.9229237875132194},{0.4894819603173488,0.9191490766811381}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.8380857468281573,0.914398430111045,0.5193014955819892},{0.0022667537061101554,0.6505751117387505,0.9298850418330038}},{{0.8367119156319882,0.880798651445342,0.9897759004844449},{0.9976603480042622,0.9811283563061779,0.1087720607775757}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8697911563106514,0.5151869846062266,0.995371103946153},{0.8212479928548525,0.6418752564363025,0.9558249979443315}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.9096630403605377,0.9748966047441144},{0.9528320988047685,0.7542226933369605},{0.43586876443325356,0.9565546763578808}},{{0.7558471204249642,0.9888220017891646},{0.27610122331006126,0.917127587307885},{0.4081913212702552,0.9339033213433391}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9764515937486067,0.8867999346115149,0.7117943589817716},{0.5787305168815295,0.7762819733793965,0.6204089822657713}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.9213427313907444,0.7145887168636053,0.836823968975338},{0.9069211065948574,0.910442807964997,0.7657888905656997}},{{0.5553699549407923,0.5545046425824065,0.7879088755831449},{0.9208518421973644,0.960807690506296,0.9987549064338826}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.5087398162301393,0.93736175567252},{0.9256103909411227,0.7515378251355923},{0.5497580182171787,0.9169191182344634}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.8296024259342744,0.6063575060510964,0.725953860375211},{0.66962120544536,0.3424562021255833,0.8448350251637887}},{{0.9069148964872527,0.8815981876059047,0.8921418762469951},{0.33253297407486176,0.8779711953612376,0.9362756172698027}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.7901652743207939,0.7995372082542436,0.019611799298758684},{0.36243827583586635,0.8420133514822534,0.9469388752444093}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.6580288924624292,0.7177652712455699},{0.997682867421383,0.7895309975217343},{0.4776220746680189,0.9703288029389023}},{{0.39264334949238033,0.8068783922832871},{0.17110329522121828,0.882157024885656},{0.8649312989459169,0.7684666995099814}}}),"values")
  check(r:raw_hex()=="c9d676a873e2d50a","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9766076849094162,0.9798663560258669,0.9840234762906371},{0.24406077016642835,0.28776211782692906,0.9149968488621302}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.9687260045764993,0.7405666167738751,0.13005505923010174},{0.9128779784067094,0.9036657045639723,0.6990505112492773}},{{0.9836004324536906,0.4900049775091683,0.8420137997120021},{0.8980083958075622,0.994030804111514,0.9146314204709965}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.7821024420483678,0.8453334944645251},{0.9147808311149387,0.8893719152885776},{0.8552395623223069,0.8370268211065973}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.8445472112497039,0.9495673738097351,0.9745618512383254},{0.23974757234740263,0.4076217586611057,0.8407406693838657}},{{0.8749027207804471,0.9106313769069423,0.919135488008106},{0.5079450753056178,0.17170143174668964,0.4234846850365231}}}),"values")
  check(r:raw_hex()=="a87f366a5c2e4ff0","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.7795189628816361,0.28630036064415776,0.14637068797158312},{0.9353443626064536,0.651391390864643,0.8812090179561161}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.4933485078533116,0.8941684451233133},{0.1400421340124417,0.29585633083444557},{0.7508127343812763,0.9643054712242402}},{{0.49012156920417915,0.8532883206644244},{0.9696402293383198,0.999531631067382},{0.9873789976133432,0.3298060957253151}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9006607577311033,0.7669833798201101,0.9992270251376048},{0.3067933395354423,0.33008560569355466,0.9415379858128432}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.9689324849878161,0.9504233899416021,0.9078890085127},{0.7905263118820468,0.6075939606630099,0.9355450361323049}},{{0.910915281016705,0.9777689512223305,0.07623188551331231},{0.9304466238908341,0.5841417670098908,0.9025117814023788}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.9090816141675347,0.8605618029949245},{0.36063147287792524,0.8963864370314947},{0.8446556033568957,0.7876604485854113}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.9404071241001024,0.8742234702845911,0.9707461687410022},{0.5564383518565168,0.7909183904546437,0.7006138992518157}},{{0.6433344169531088,0.7898817408380374,0.9610500348284488},{0.6097314092935042,0.9048803898428324,0.9983402198423209}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.7982983707584881,0.878647060997469,0.8567545958181781},{0.7881805309504436,0.6983979297976614,0.8780040963659034}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.47367455240855155,0.5350704258732282},{0.3825842233699439,0.9229237875132194},{0.4894819603173488,0.9191490766811381}},{{0.6764974155077891,0.8542566354157032},{0.7100709993342779,0.8023557020056715},{0.9168962119263004,0.9676133614568386}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8380857468281573,0.914398430111045,0.5193014955819892},{0.0022667537061101554,0.6505751117387505,0.9298850418330038}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.8697911563106514,0.5151869846062266,0.995371103946153},{0.8212479928548525,0.6418752564363025,0.9558249979443315}},{{0.7322612994424613,0.6510527399336621,0.02927633763555938},{0.9007859024739122,0.9166192376872777,0.6736550642929997}}}),"values")
  check(r:raw_hex()=="c9d676a873e2d50a","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.9096630403605377,0.9748966047441144},{0.9528320988047685,0.7542226933369605},{0.43586876443325356,0.9565546763578808}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.9764515937486067,0.8867999346115149,0.7117943589817716},{0.5787305168815295,0.7762819733793965,0.6204089822657713}},{{0.9876749367747116,0.7517617012411908,0.9717469843132014},{0.5244237870405669,0.9851437524500788,0.8878266058934422}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9213427313907444,0.7145887168636053,0.836823968975338},{0.9069211065948574,0.910442807964997,0.7657888905656997}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.5087398162301393,0.93736175567252},{0.9256103909411227,0.7515378251355923},{0.5497580182171787,0.9169191182344634}},{{0.5859210061849212,0.8895661792873591},{0.7764948932755792,0.8732997801181315},{0.3089223128846581,0.6507570092104449}}}),"values")
  check(r:raw_hex()=="a87f366a5c2e4ff0","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8296024259342744,0.6063575060510964,0.725953860375211},{0.66962120544536,0.3424562021255833,0.8448350251637887}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.7901652743207939,0.7995372082542436,0.019611799298758684},{0.36243827583586635,0.8420133514822534,0.9469388752444093}},{{0.788438709518636,0.7281009581823136,0.9402021743512694},{0.999609677319386,0.9924081703617725,0.1894035075943656}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.6580288924624292,0.7177652712455699},{0.997682867421383,0.7895309975217343},{0.4776220746680189,0.9703288029389023}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.9766076849094162,0.9798663560258669,0.9840234762906371},{0.24406077016642835,0.28776211782692906,0.9149968488621302}},{{0.9324133666022276,0.9910475606497954,0.6511625925655251},{0.6488566894020935,0.2607928318069429,0.87217541361612}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9687260045764993,0.7405666167738751,0.13005505923010174},{0.9128779784067094,0.9036657045639723,0.6990505112492773}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.7821024420483678,0.8453334944645251},{0.9147808311149387,0.8893719152885776},{0.8552395623223069,0.8370268211065973}},{{0.17129596904553307,0.744650684940534},{0.8876423128620813,0.9057903999994398},{0.9355366036912797,0.9991697652763123}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8445472112497039,0.9495673738097351,0.9745618512383254},{0.23974757234740263,0.4076217586611057,0.8407406693838657}}),"values")
  check(r:raw_hex()=="635266e22330bd56","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.7795189628816361,0.28630036064415776,0.14637068797158312},{0.9353443626064536,0.651391390864643,0.8812090179561161}},{{0.8778535045406186,0.7297543991517577,0.50420082409558},{0.8323496209478132,0.9492751390110631,0.9518155269150165}}}),"values")
  check(r:raw_hex()=="68a3a2ae54ed820a","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.4933485078533116,0.8941684451233133},{0.1400421340124417,0.29585633083444557},{0.7508127343812763,0.9643054712242402}}),"values")
  check(r:raw_hex()=="9b4c7b7180edb27f","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.9006607577311033,0.7669833798201101,0.9992270251376048},{0.3067933395354423,0.33008560569355466,0.9415379858128432}},{{0.7915886553083786,0.8422605670717944,0.5551616499844165},{0.5342314909234096,0.8044006624245613,0.590541068255764}}}),"values")
  check(r:raw_hex()=="c9d676a873e2d50a","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9689324849878161,0.9504233899416021,0.9078890085127},{0.7905263118820468,0.6075939606630099,0.9355450361323049}}),"values")
  check(r:raw_hex()=="c2da0d2fbc5a4471","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.9090816141675347,0.8605618029949245},{0.36063147287792524,0.8963864370314947},{0.8446556033568957,0.7876604485854113}},{{0.9516037242131187,0.7000035553546626},{0.9176130991392843,0.8788939530878332},{0.9900711485074974,0.9422455125355823}}}),"values")
  check(r:raw_hex()=="2178b0a1f897b4b6","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9404071241001024,0.8742234702845911,0.9707461687410022},{0.5564383518565168,0.7909183904546437,0.7006138992518157}}),"values")
  check(r:raw_hex()=="3de46552cbbd5187","PCG64 continuation")
end
do local r=np.random.default_rng(32768);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.7982983707584881,0.878647060997469,0.8567545958181781},{0.7881805309504436,0.6983979297976614,0.8780040963659034}},{{0.8367833357933665,0.79132798733191,0.602944319283053},{0.8932426658142342,0.4942077671273476,0.5249625006424696}}}),"values")
  check(r:raw_hex()=="a87f366a5c2e4ff0","PCG64 continuation")
end
do local r=np.random.default_rng(981239);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{3,2}),"shape");check(same(x:tolist(),{{0.47367455240855155,0.5350704258732282},{0.3825842233699439,0.9229237875132194},{0.4894819603173488,0.9191490766811381}}),"values")
  check(r:raw_hex()=="d96517d7f219f31e","PCG64 continuation")
end
do local r=np.random.default_rng(0);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.8380857468281573,0.914398430111045,0.5193014955819892},{0.0022667537061101554,0.6505751117387505,0.9298850418330038}},{{0.8367119156319882,0.880798651445342,0.9897759004844449},{0.9976603480042622,0.9811283563061779,0.1087720607775757}}}),"values")
  check(r:raw_hex()=="db7ed8bf64e6f5f0","PCG64 continuation")
end
do local r=np.random.default_rng(1);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.8697911563106514,0.5151869846062266,0.995371103946153},{0.8212479928548525,0.6418752564363025,0.9558249979443315}}),"values")
  check(r:raw_hex()=="68c1464c41ca3aca","PCG64 continuation")
end
do local r=np.random.default_rng(42);local x=r:power(np.transpose(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float64")), {2,3,2});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3,2}),"shape");check(same(x:tolist(),{{{0.9096630403605377,0.9748966047441144},{0.9528320988047685,0.7542226933369605},{0.43586876443325356,0.9565546763578808}},{{0.7558471204249642,0.9888220017891646},{0.27610122331006126,0.917127587307885},{0.4081913212702552,0.9339033213433391}}}),"values")
  check(r:raw_hex()=="a4d45831c814ce06","PCG64 continuation")
end
do local r=np.random.default_rng(77);local x=r:power(np.flip(np.array({{1.0,2.0,3.0},{4.0,5.0,6.0}},"float32"),1), nil);cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,3}),"shape");check(same(x:tolist(),{{0.9764515937486067,0.8867999346115149,0.7117943589817716},{0.5787305168815295,0.7762819733793965,0.6204089822657713}}),"values")
  check(r:raw_hex()=="cd220a9553964724","PCG64 continuation")
end
do local r=np.random.default_rng(1234);local x=r:power(np.flip(np.array({{1,2,3},{4,5,6}},"int64"),2), {2,2,3});cases=cases+1
  check(type(x)=="userdata","type");check(same(x.shape,{2,2,3}),"shape");check(same(x:tolist(),{{{0.9213427313907444,0.7145887168636053,0.836823968975338},{0.9069211065948574,0.910442807964997,0.7657888905656997}},{{0.5553699549407923,0.5545046425824065,0.7879088755831449},{0.9208518421973644,0.960807690506296,0.9987549064338826}}}),"values")
  check(r:raw_hex()=="dd164908e5a8465d","PCG64 continuation")
end
print("random78 differential passed: 2000 cases")
