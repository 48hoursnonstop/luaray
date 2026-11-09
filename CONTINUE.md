# Current checkpoint — layout0.110 final validation

Active /mnt/datos/luaray/.dev/layout110 VERSION0.110.0-dev. Directed25,134cases /
1,759,008checks exact;61Lua/native C passed. Full146/146fixture files passed.
Inventory336/675,338missing,1N/A,allpartial. Public example passed. ASan27units(26C+1Cpp),14native57Lua passed; see
artifacts/layout110-sanitize.log. TEST_RESULTS records executed results.
Exact three-fixture/inventory regeneration runs separately; then
clean tools/release.py extraction/fullsuite/13examples; manifest/gzip/SHA;
commitFFmain/tag/publicassets/Downloads/exactCI. Continue until complete/usageout.

Native ln_layout replaces old core C reshape implementation with a delegate;
independent lua_layout uses rooted ownership bridge. Reshape C/F/A with copy
true/false/if_needed, one negative inferred shape; ravel/flatten C/F/A/K.
New strided no-copy F grouping, stable physical K axes, raw-negative K view
rejection and explicit scalar/table coercion. Empty flatten allocation stride0
versus empty reshape view canonical stride is intentional and source-tested.

Latest public0.109 commit65aa72ac6f9194c2af7686b87aa941cda6feea50 SHA
30cf13ae78503400da665a2b74b785cb516704cd34d461c6530b78d1ed0c01a6.
Exact CI42551053140 SUCCESS; public assets and Downloads SHA verified.
Final telemetry97%used/3%remaining at02:37UTC. Earlier50%stop was revoked.
No subagents authorized. luanimath goal is unfinished and suspended for LuaRay.
Next coherent work after0.110: real/imag views, clip/round and dtype views.
Older checkpoints below are historical.

# Current checkpoint — binary 0.109 release gate preparation

Active worktree: /mnt/datos/luaray/.dev/binary109, VERSION0.109.0-dev.
Final directed tests:4,986 cases /514,816 checks;303Lua +native C passed.
Full143/143 fixtures passed. ASan25units(24C+1Cpp),13native/53Lua passed.
Inventory333/675 available,341missing,1N/A,allpartial. Public example passed.
Next: reproduce four fixtures/inventory exactly; tools/release.py clean source
extraction/build/full suite/12examples; manifest/gzip/SHA; commit, FF main,
tag/public assets/Downloads and exact CI. Continue after release; user authorized
work until completion or actual usage exhaustion. No subagents authorized.

New binary module adds fmod/float_power; generic binary calls coerce scalar/table
inputs after option parsing. Float_power weak scalars retain default precision
until forced double signatures. String S/U add sums widths, strips trailing NUL
padding, preserves embedded NUL and canonicalizes Unicode endian. Binary logical
promoter resolves to bool first, including tiny weak float/complex values and
string content truth. Existing unary logical_not remains separately scoped.
Registry73 count and version-only assertions updated, old numerical fixtures
unchanged. Final extreme-divisor/exponent fixtures have1,428 cases each for
fmod/float_power. Float_power tolerance relative2e-12, observed3.23e-15.

Latest published0.108 commit00a19cdaef13acf3bec26e3c83d78b0757e4cea2, SHA
770b63b00b2ae8277fe83b26c06a307c918f91c1acaeeccb238a03f9a69827d6.
Exact Ubuntu CI42549224919 SUCCESS; public asset digest and Downloads verified.
Earlier endian40blocked/takehang/chooseunsafe/legacyastype limits retained.
Next coherent subsystem: missing ravel/flatten and related layout/view functions.
luanimath objective remains unfinished, suspended for dependency work.
Older checkpoint text below is historical.

# Current checkpoint — unary0.108 clean release gate preparation

Active /mnt/datos/luaray/.dev/math108 VERSION0.108.0-dev. Directed5589cases/
501064checks(max0),358Lua andnativeC pass. Full139/139fixtures pass. ASan24units
(23C+1Cpp),12native48Lua pass. Inventory331/675,343missing,1N/A(allpartial).
Needfinalpublicexample/reproduction, tools/release.py cleanextract/fullsuite/
11examples, manifest/gzipSHA;commitFFmain/tagv0.108/publicassets/Downloads/exactCI.
Continueafterrelease, userrequestsworkuntilcompleteorusageout. Noagentsauthorized.

Newln_unary_math independentregistry addsfloor/ceil/trunc/rint/fabs/conjugate/
square/reciprocal/degrees/radians +3aliases. Genericunary parsesoptions BEFORE
coercion, returnsstrong0Darrayforscalars. NativeUFcount71 (oldtest61updated).
GeneraliteratorphysicallytraversesitsKEEPORDERaxispermutation fixingF-order
complexsquareFMAselection. Equalinplacerangesvectorizeupstream, noadditional
aliascontextAPInescessary. 38newFMAcasesstrict;generalcomplexsquare/reciprocal
relativebudgets6e-7/2e-15,observed0. Integerreciprocal0explicitx86signedminfor
int32/64,smallerunsigned0. OtherABIs/nondefaultroundinguncertified.

Latestpublic0.107commit7348a1d1c26af6221420ff8dfaaa1ac140d935a0 SHA
3b7b347cb8a90b5b546558b74535396f680bf7b63b46e1bf1faf0d38cc766427;
exactCI42547753269success/publicassetdigestverified/DownloadssameSHA.
Allold40endianblockedstates,takehang/chooseunsafevariantsandlegacyastype
restrictionsretained. luanimathgoalunfinished/suspendedfordependencies.
After0.108missingbinarymathfmod/float_power and scalar/tablecalls arecoherent.
Oldercheckpointsbelowhistoricalonly.

# Current checkpoint — creation0.107 final clean package gate

Active /mnt/datos/luaray/.dev/creation107 VERSION0.107.0-dev. All136frozen fixtures
passed, finaldirected12551cases/1041748checks and164Lua passed. FinalASan23units
(22C+1Cpp)11native44Lua passed, includesfresh64rank/oldstring_cast andNULvalidation.
NativeCtestpasses. Public.so rebuiltcurrentbinding andexamplepasses; inventory
318/675 observed,356missing,N/A1(allpartial),actualprobe reproducible. All4new
fixtures reproduceexactly. DocsEN/EScreation+README/UPSTREAM/TEST_RESULTS/currentjson
and14sourcepins ready. Releasegate configured136fixtures10publicexamples.

Next: tools/release.py cleanextract/build/fullsuite/10examples +manifest/gzipSHA;
commit,FFmain,tagv0.107/publicassets/Downloads copy/exactUbuntuCI;continueafterrelease.
Do noteditcoveredsourceafterpackagingwithoutretakinggate. Everyarchiveimmutable.
NewbindingCfile separatedusinginternalAPIownershipbridge; normalandsanitized
linkingupdated. SourceordinaryintegerDateGenericpackingrejects evenINT64MIN,
rawnumericarraycastsallowticks, typedNaTvalid. DateBoxUwidthactualISO,TimeBoxU21.
OldLuaastypegenericdatetimelegacyrestriction preservedadapter-side becauseold
77casestringfixtureassertsit; explicitpartialdifference, notNumPyrootastypeparity.
Constructor/tolistLuastackreservationaddedfor64depth; freshprobepassed,no newcrash.
Nestedndarraycoercion/foreignprotocols/subclasses/shape-as-ndarray/device remain
incomplete. Machineavailabilitynotoverallcompletion. Allold40endianblockedstates
andtake/choose differences retained. Nextcoherentstepmissingmathufuncs/scalar
calls orarraycoercion/views. Userrequestscontinuedworkuntilcomplete/usageout;
noagentsauthorized. luanimathgoal unfinished. Old checkpoints historical below.

# Current checkpoint — creation0.107 final metadata/gates pending

Active /mnt/datos/luaray/.dev/creation107 branchcreation107; runtime still0.106.
New ln_creation.h/kernel extendsexisting ln_creation.c for copy/no-copy/like shape,
C/F/A/K, minrank, finitecheck; separate lua_creation.c bindings with explicit
internal lua_array_api.h ownership bridge inlua_module.c. Eleven new rootnames:
asarray/asanyarray/ascontiguousarray/asfortranarray/asarray_chkfinite/copy/
empty_like/zeros_like/ones_like/full_like/full, plusndarray:copy; existingarray/
empty/zeros/ones improved. NewAPIcopy='if_needed' encodesNone sinceLua nil means
absent/default; ndarraycopydefaultC vsrootcopyK. Shapeint nowallowed, negative
ndminignoredlikeactualNumPy. Stringsminimum1char. NumPyBoxdates materializeoriginal
strongdtype, thenconvert; genericM/m adaptunitsfromtemporalinput; DateBox unsized
stringssizeactualISOtext, TimedeltaBox retainslegacywidth21. CoreNumericScalar
packing requiresdateunit evenINT64MIN; typedDateBox usesrawknown-typedsetter.
Numericarray->genericDate casts retainrawticks (removedmisplacedtransferguard).

Executed originals NumPy2.5.3:conversion4726/454982,copy740/77978,like5624/485242,
dense1461/23546 =12551/1041748. NativeCunit+162Lua checks passed. Publicexample
passed. DirectedASan23units(22C+1Cpp)11native42Lua passed beforelatestlegacyguard/
explicitstackreservationchanges. Fresh rank64 process ASanprobepassed; promote
nowtests/creation107_stack.lua. Sanitizers nowinclude this +oldstring_cast =>44Lua.

Fullregression initiallyfailed oldstring_cast fixture's hardcoded genericDate
numeric rejection inLuaRay np.astype. Preserve existing legacy API contract in
array_cast_new whilecreation usesitsseparate rawcastpath. This is a retained
partialcompatibilitydifference, NOTNumPy2.5.3 rootArrayAPIastypeparity; documentit.
Oldtestsnotweakened. GuardNumericNaTacceptedoldastype, scalarpackINTMINDateGen
rejects asactualNumPyintegerconstructiondoes; typedDateNaTaccepted. Justexecuted
oldstring_cast/direct162Lua/freshrank64 onbuild10; inspectlogs andsession19451
completion. Onlytrailingwhitespacecleanupaftercompile, nofunctionalchange.
SourceexplicitlyreservesLuastack forlegacy64deepconstructor/tolist. Noobserved
newcrash, freshprobehadalready passed; thisfixesdocumentedCAPIstackreservation.

Next: confirm targetedgate; reproducible4fixtures; bumpVERSION/module/155test
version-onlyasserts0.107; finalfull-test136fixtures andASan23units11native44Lua.
Newbind objectlua_creation mustlinknormal .so+lua_runner, andsanitizedsharedmodule
(thetoolhandlesmixednormal/sanitizedbindings). ln_core isnowinstrumentedunder
--creation107, no-fwrapv core currently; ufuncloops retain-fwrapv, firstauditpassed.
Checkfreshstackfile withpublicLua loader +LD_PRELOAD sanitizer beforeclaim. Add
creation107 publicexampletorelease+CI (tenth), bilingualdocs/sourcepins/currentJSON/
inventory actualprobe expected318/675availability(allpartial),356missing,N/A1.
Newbindingsavailability includes12names,rootnumpy193 andndarray32. Rootnp.array
nestedsequencescontainingndarrays andtemporalboxeswithoutdtype remainincomplete;
foreign__array__/subclass/device/shape-ndarray args unsupported. Dtype/numericendian
blocked40andearliertake/choose differences remain. Cleanarchivegate,commit,FFmain,
tag/publicrelease/Downloads copy/exactUbuntuCI thencontinue (doNOTstoprelease).
Nextcoherentwork: nestedarraycoercion/views ormissingmathematicalufuncs forManim.

0.106published atb3e003e7ba40261e642ccf9d85367501a1a5d777; exactUbuntuCI42542307712
SUCCESS; publicassetSHA b981d9b586d65970b70b39f96dde20b25f9ae1df33c76080e51495874bb13163.
741files740manifest132fixtures9examples21unitASan10native37Lua+final154direct
checks passed; Downloads/home/yhwh/Downloads/LuaRay-0.106.0-dev-source-20261108.tar.gz
verified. Archivesimmutable. Userprevious50%quotastop revoked; latestweekly83used/
17remaining (2026-11-09T01:23:36Z), continueuntilfinished/usageout. Noagentsauthorized.
Unfinishedluanimathgoal persists; dependencyworkfirst. Oldercheckpoints historical.

# Current checkpoint — sampling0.106 clean release gate

Active sampling106 /mnt/datos/luaray/.dev/sampling106, VERSION0.106. All132frozen
fixtures and existingC/Lua passed afterfunctional/metadata changes. Directed
ASan/UBSan21units(20C+1C++)10native37Lua passed (finalfulltest.log/finalsanitize.log).
Three originalsequencefixtures:linspace2478/504645 exact0error;logspace1542/154195
maxnormalized1.1393306865162e-7(maxabs9.2233720368548e18 atlargepowers);geomspace1392/
150473 maxnormalized1.9546212523884e-7(maxabs9.5367431640625e-7). Combined5412/809313.
Cformatter70828rawstates/141656exactASCII+Unicode comparisons;8threads16384calls;
allhalfpatterns andrandomwider+14x87. TwoCtests and154Lua checks passed; final
24additionalwide-storagechecks ran normal+instrumented module separately.
All3fixtures/header/Dragon4import/APIinventory regenerateexactly. Nativepublic
example0.106passed. Inventory306/675available,368missing,N/A1; allpartial. Complete0.
EN/ESdocs,sourcepins,README/UPSTREAM/TEST_RESULTS/currentjson ready.

New shared ln_creation.c exposes ln_array_new_keeporder inln_core.h, bodyofcore
unchanged;extractedsourceorderfromroll nowshared, dtypeawareitemsize. Sampling
copycasts use NewLikeArray K-order ratherthaniterator allocation, fixing expanded
zero-stridegeomspace. Ufunc canonicalC/Ftrivialoutput andcomplexcomponentcast /
FMAfixes explained inoldercheckpoint andPROGRESS_0_106.md. NativeDragon4 preserves
MIT+NumPylicenses, stripsPythonCAPI, TLSboundedoutput. OtherABIbranchesunverified.
Tolerancesforpower/log followcompute dtypebeforefinalcast; originaloutputbased
criterion correctedafteractualSVML/libmpowf1ULPproof. Allinteger/bool/string and
metadataassertionsremainexact. Linspaceexactallcases. Do notcalltoleranceunchanged.

Next: tools/release.py actualclean gate132fixtures9examples; inspectfinalmanifest/
sourceonlytar/gzipSHAandlogs. Commit0.106, fast-forwardmainonlyifclean,tagpublic
release/assets/Downloads;checkexactUbuntuCIafterpush. Don'teditmanifest-covered
sourceafterpackagingwithoutregenerating/retakinggate. Thencontinuenextcoherentgap:
creation/copy/asarray/like API missing andln_creation foundationready. Do notstop
at release; userrequests continueuntilcomplete/usageexhausted, luanimathunfinished.
Earlier checkpoints historical;0.105 immutablepublishedCIpassed facts below.

# Current checkpoint — sampling0.106 regression gate

Active /mnt/datos/luaray/.dev/sampling106, branchsampling106; runtime still0.105.
Implemented native ln_sampling.c/h with linspace/logspace/geomspace. Options table
num/endpoint/axis/dtype/retstep(linspace)/base(logspace), optional positionaln;
Lua-positiveaxes1based. Weak scalar endpoints cast into the resolved inexact dtype;
strong endpoint layouts retained. Native subtract forces compute dtype, typed
arange/ufuncs preserve half/float precision and subnormal fallback, endpoints
corrected, intlinspace floors before finalcast; geomspace rotates sign, restores
endpoints, reversesrotation; logspace arraysbasepad rank andinsert sampleaxis.
First public examplepassed. New native sampling boundarytest and127Lua checks
passed. Original NumPy2.5.3 fixtures: linspace2416/356658 maxerror0, logspace1476/
138215 maxabs0.5(maxrelative1.1332e-7), geomspace1332/134855 maxabs9.5367e-7,
maxrelative1.9546e-7. Combined5224/629728. Linspace values exact; transcendental
bounds follow compute dtype BEFORE finalcast, not widened storage dtype. Source
NumPy SVML vs libm powf1ULP verified; integer/boolean/string outputs remain exact.
Earlier default output-based tolerance was corrected for valid F32->F64 output
casting; do not call it unchanged. NumPy float128 maps existing Lua longdouble
spelling on primaryx86ABI; rawdecimal test values chosen exact atLua boundary.

Original cases caught shared defects: floatstrings used fixed printf precision;
new native Dragon4 numerical core port (licensedMIT NumPy2.5.3 dragon4.c/h) strips
Python wrappers/4PyErr calls, TLS scratch and nativecopyto callerstorage, type/ABI
shim. 65536half patterns +2063F32+2063F64+576C64+576C128+14x87 states passed
141656 exact ASCII/Unicode comparisons;8threads/16384formattercalls passed.
Complex->real casts now use original component precision instead oflongdouble;
38935.516C64->int8 now23 (was0). New original geomspace integerout exposed complex
multiplyFMA rounding: trace a=2+.25j sign, b=8-.5j divide matched, unfusedrestored
stop8 versusNumPy7.9999995 thenintout8vs7. SourceSIMDmuladdsub verified FMA operand
ordering. ln_ufunc_loops nonreduceCFLOAT/CDOUBLEmultiply now fmaf/fma whenruntime
host FMA available (x86builtin/aarch64);longdouble/reductionsretainbaseline.
Shared ufunc trivial outputalloc nowcanonical C/F for exactcontiguousinput and
0Dother, matching singleton strides. Scope not fullSIMD/ufunc parity.

Current running gates: full-test session53995 artifacts/sampling106-full-test.log;
san session33236 artifacts/sampling106-sanitize.log.20instrumentedunits(19C+1C++),
10native37Lua whenallpass. Newln_ufunc_loops compiled-fwrapv in sanitizer.
Need inspectcompletion/failures. Newformat generator was cleaned after first
execution(noexpectedchanges); import_dragon4.py nowvalidatessourcehash andincludes
MIT header license, but rerunneeded(headercommentupdate). PreserveprivateCAPI
independence. Need fixture/header/import reproducibility check, expandedzero-stride/
3D andbasearraytests if gaps, docsEN/ES/sourcepins/inventory, version0.106 after
functional gates, finalfull/san, sourcecleanrelease132fixtures9examples SHA,
publicreleaseandexactCI. Do notclaimunexecutedgates. Continue afterreleases.
0.105publishedCIpassedfacts incheckpointbelow; immutablearchives retained.

# Current checkpoint — sampling0.106 implementation

Sampling106 implementation in progress; runtime0.105. Native sequence helpers,
Lua wrappers and first public example executed. Original generators now running.
Do not classify unexecuted/incomplete corpora as passed. Full regression,
ASan/UBSan, bilingual docs, inventory/version and release gates remain pending.
0.105 published e2cbff295f5049205410ef3337f33c019df16fa8; exactUbuntuCI42539354346
SUCCESS. PublicsourceSHAa423c2eff701aa82e63028f5ff4d73d383606594a1d7131802f7357f553300de,
719files718manifest129fixtures8examples16unitsASan8native33Lua passed; immutable.

# Current checkpoint — FFT0.105 final release gates

Active /mnt/datos/luaray/.dev/fft105 branch fft105, VERSION0.105.0-dev.
Development full regression129/129 passed after version update; direct native
suite +111 Lua checks; new original NumPy2.5.3 frequency826/28419, shift1800/
86698, transforms6964/343993 (combined9590/459110). All three fixtures regenerated
exactly. Runtime inventory303/675, FFT18/18 available, allpartial, missing371,
N/A1; inventory reproduces exactly. Public FFT example passed. EN/ESdocs ready.

Actual reproduced fixes: zero-stride roll allocation; KEEPORDER conjugation;
float16 normalization with explicit float32 out avoids second half rounding;
exact complex/real FFT compute precision retained for wider output; positional
nil n honors axis/norm/out; read-only out rejection. Expanded U4->complex out
case crashed; core/GDB confirmed norm real_dtNULL after out promotion masked
unsupported input. Validation now precedes promotion; same calls reject and
pass sanitizer. Related irfft unsafe validation reordered before first execution.
Original differential tolerances were retained. 15C+1C++ units instrumented,
8native33Lua passed before version-only metadata change; final version sanitizer
is running (artifacts/fft105-final-sanitize.log). Other dependencies uninstrumented,
leaksdisabled. First sanitizer log artifacts/fft105-sanitize.log.

Next: confirm final sanitizer, run tools/release.py clean gate (129fixtures and
8publicexamples), inspect sourceonly manifest/tar/gzip SHA and logs; commit coherent
0.105; fast-forwardmain, tag/publicrelease/Downloads copy, exactUbuntuCI. Do not
claim any gate not actually completed. Earlier immutable releases remain intact.
Then continue next coherent gap: native linspace/logspace/geomspace are all missing
and useful to luanimath. Inspect actual source and original references first.
Do not stop at release milestones; unfinished luanimath goal remains active.
Older checkpoints below are historical and superseded where contradictory.

# Updated FFT105 differential checkpoint

Active branch fft105 /mnt/datos/luaray/.dev/fft105, runtime still0.104. Initial
826 frequency cases/28419checks,1680shift/79348,6610Hermitian/330013 passed.
Expanded tests add zero-stride and3D layouts; inspect newest logs for result:
artifacts/fft_frequency105.log,fft_shift105.log,fft_hermitian105.log.

Actual corrections: fftfreq boolean n rejected as source's empty(True) rejects;
rfftfreq n=0 has one bin when typed/nonfinite spacing avoids Python zero division.
FFT shift0-D raises upstream and is rejected. hfft conjugation now uses native
NpyIter KEEPORDER (bool->int8) rather than a C-order copy. Typed complex64 test
construction was corrected to retain dtype after adding imaginary data. Original
zero-stride shift tests exposed ln_roll.c sorting zero strides as largest; removed
that special case to match actual empty_like order. Need full old roll regression.
PocketFFT C++ unchanged, normalization includes original half rounding.

Next: inspect expanded passes; add output alias/stride/bad-shape tests, C/Lua
regression and invalid API cases, full prior126 suites, sanitizer (include new
fft_helpers and changed ln_roll plus existing13C units; C++ backend remains
uninstrumented unless separately audited), refresh version/inventory, bilingual
docs/reproducible fixtures/clean package and release. First real public example
passed. Compilation errors were fixed; no0.105 release/parity claim yet.

# Current checkpoint — FFT0.105 initial implementation

Active /mnt/datos/luaray/.dev/fft105 branch fft105; runtime still0.104. New
ln_fft_helpers.{c,h} registers six missing FFT names:fftfreq/rfftfreq,shifts,
hfft/ihfft. Frequencies use real native ufunc operand APIs to retain typed
spacing precision (including ndarray spacing); raw scalar division-by-zero is
separate, with nonfinite zero-length cases retained. Negative rfftfreq can be
empty upstream. Shifts use ln_roll, duplicate-axis modular accumulation safe
from overflow. Hermitian transforms use native conjugation + existing irfft/
rfft with normalization swap; C++ PocketFFT unchanged. Source has half norm
rounding already, do not replace it with generic doubles.

Lua 1-D FFT parser captures original argc for array-like input; positional nil
n now preserves following axis/norm/out. Default real FFT length overflow guard
added. Initial compile mistakes (getter name/forward declaration) corrected.
First actual public example result is in session45609 / output; inspect before
claiming it. A just-added >5arg guard requires rebuild. No original NumPy FFT105
corpus or new C/Lua tests/sanitizers/docs/releases yet. Next strict source tests:
frequency integer/typed/nonfinite/complex spacing, shifts layouts/axes/dtypes,
Hermitian dtype/norm/length/axes/out aliases, all prior126 suites, ASan, docs and
inventory refresh after version0.105. No complete FFT parity claim yet.

0.104 is published at b33a903, SHA
cc3ac956aad319c1ee66d4af933f6436b614b12631793f21032c40a27c307904;
706files705manifest clean126suites7examples13-unitASan7native29Lua passed.
Exact UbuntuCI42536437197 SUCCESS; public asset hash/Downloads verified. Keep
archives immutable, user requests continuing beyond releases until done/usageout.
Older checkpoints below historical; luanimath goal remains unfinished.

# Current checkpoint — selection0.104 release gate

Active /mnt/datos/luaray/.dev/select104, branch select104, VERSION0.104.
where/select native C, scalar views and timedelta/u64 correction are implemented.
Actual NumPy2.5.3:where1487/59988 checks,select1961/19688;65Lua checks and native
suite passed. Full-test126/126 files passed, including oldchoose3481cases.
13-unit ASan/UBSan seven native/29Lua passed (deps uninstrumented, leaks off).
Both fixtures/inventory reproduced. Public module example passed. EN/ES docs,
compatibility record and source hash pins updated. Older checkpoints historical.

Next: clean source extraction/rebuild/full tests/seven examples, commit/integrate,
publish0.104, actual Ubuntu CI. Then FFT inventory gaps (fftfreq/rfftfreq/shifts/
hfft/ihfft), with strict original references. User requests work past releases.
Inventory675 names:297 callable,377 missing direct bindings,1 justified Lua
exception-class adaptation,0 declared complete. It is availability, not overall
behavior/completion. Keep immutable verified archives; luanimath unfinished.

0.103 published at d688125 with SHA
3c4c5c290a93d966c0dbc2af8c87147644d68cd6b97e96e6be49f90740507dfd;
690files/689manifest, clean124 suites/six examples, ten-unit ASan6native26Lua passed.
Exact Ubuntu CI42534239743 SUCCESS; public asset hash and Downloads verified.

# Latest select104 execution checkpoint

Native where/select, grouped broadcasting and shared dtype fixes compile.
Read artifacts/where104.log,select104.log,select104-generation.log for newest
expanded original counts and pass/fail. Last known where1487/59988 passed.
select additionally exposed ndarray scalar sequence items being rejected by the
old ln_array_index_axis0 helper. New selection_array_item creates strong 0-D
views (also fixes choose ndarray1-D choices), preserving dtype and valid empty
pointers. New ndarray-list references added. Old choose3481 cases rerun.

Before any release: C/Lua direct tests (including choose1-D strong dtype), all
old regression, sanitizer with ln_select/ln_nditer_multi/ln_datetime added to
old ten-unit scope, refresh inventory after VERSION0.104, docs EN/ES, reproducible
fixtures and clean tarball verification. Runtime remains0.103 at this checkpoint.

# Updated active checkpoint — select104

Native ln_select.{c,h} and Lua np.where/np.select now compile and execute real
examples. Common selection dtype preparation was factored from choose; all3481
choose cases still pass. Initial where1324 cases passed. Expanded current corpus
files/logs in artifacts:where104.log/select104.log and select104-generation.log.
Inspect actual logs for latest counts/result; no release yet. Runtime still0.103.

Original source tests exposed uint64+timedelta promotion accepted incorrectly;
src/ln_datetime.c now rejects unsigned64 at common-class/descriptor resolution.
select also needed batched shape broadcasting instead of legacy64-operand bound;
ln_select.c folds groups of63 plus a carry shape, without changing core's legacy
limit. Many-condition/bidirectional/layout/binary-string tests added.

Next: finish expanded original corpus, C/Lua tests and full regression (including
shared dtype fix), sanitizer scope should include ln_select, ln_nditer_multi,
ln_datetime in addition to prior ten units. Add docs EN/ES, inventory refresh
once runtime advances0.104, reproducibility and source-release gates. Explicitly
classify API inventory as availability (baseline295/675) rather than completeness.

# Current checkpoint — selection 0.104 work

Active worktree /mnt/datos/luaray/.dev/select104, branch select104. Runtime still
0.103 until new features are verified. tools/inventory_api.py implemented and
executed against exact condition103/build native module:675 scoped public
callable names,295 available, all marked partial or missing. It does NOT infer
behavioral/full compatibility. Scope excludes properties/constants/all submodules;
aliases and callable Python types are included. compatibility/api_inventory.json
is the observed baseline; refresh after new public APIs are implemented. Probe
uses real Lua functions/callable userdata, ndarray/RNG/ufunc prototypes.

Upstream where/select source was inspected. Next implement native ln_select:
where uses existing generalized NpyIter with condition/X/Y and KEEPORDER; power-
of-two common itemsize1/2/4/8/16 buffers both operands, other sizes cast selected
values only. It returns an ndarray even for0-D; unary where returns nonzero table.
Weak numeric where operands must pack into resolved dtype with overflow checks,
distinct from choose's unsafe weak conversion. select resolves dtype with weak
choices/default, separately broadcasts condition/choice groups, bool-only masks,
C-output filled with default UNSAFE then reverse-order SAME_KIND copyto. Preserve
broadcast rank so scalar preconversion/error behavior follows actual upstream.

A reusable common-dtype helper can factor choose's existing verified logic but
must retain its behavior; rerun old choose3481 cases after changes. No new where/
select code or tests implemented yet. Add original NumPy differentials, real Lua
example, C/Lua regression, sanitizers, full suite and bilingual docs before release.

0.103 is published at d688125, SHA
3c4c5c290a93d966c0dbc2af8c87147644d68cd6b97e96e6be49f90740507dfd.
690files/689manifest, clean124 suites/six examples, ten-unit ASan6native26Lua passed.
Exact Ubuntu CI42534239743 SUCCESS; public asset hash/Downloads verified. Keep
archives immutable. User requests work beyond releases until complete/usage out.
Old checkpoint sections below are historical. luanimath goal remains unfinished.

# Current checkpoint — condition selection 0.103 release gate

Active /mnt/datos/luaray/.dev/condition103 branch condition103 VERSION0.103.
New native nonzero/flatnonzero/compress/extract and methods execute correctly.
Actual NumPy2.5.3:168/10188,168/7126,2061/83059,692/21331 cases/checks;
total3089/121704. Native suite and95Lua checks passed. Full-test124/124 files
passed. Ten-unit ASan/UBSan: six native/26Lua passed (dependencies uninstrumented,
leaks off). All four fixtures reproduced; public example passed. Bilingual docs
and compatibility record are updated. Older checkpoint text below is historical.

Next: clean source extraction/rebuild/full tests/six examples, commit/integrate,
publish0.103 and actual Ubuntu CI. Then where/select plus broader measured API
inventory. User requests sustained work beyond releases; luanimath unfinished.
Keep immutable old archives; do not infer full NumPy parity from fixture counts.

0.102 is published at eb1937a. SHA
 a806e125200e169f2bba038f23e98e6d75f987ba8d4f5c0fec30f32e9da9c6da.
676files/675manifest, clean120 suites/five examples, nine-unit ASan5native21Lua
passed. Exact Ubuntu CI42533073659 on eb1937a SUCCESS; public asset hash and
Downloads source/checksum verified. Prior deliberate/blocked states remain.

# Current checkpoint — choose 0.102 release gate

Active /mnt/datos/luaray/.dev/choose102 branch choose102, VERSION0.102. Native
choose, shared date/delta casts and binary-safe output guard implemented.
Final original NumPy2.5.3 corpus3481cases/101519checks, C suite and69Lua checks
passed. Final full-test all120 frozen files passed. Nine-unit ASan/UBSan passed
five native/21Lua suites (dependencies uninstrumented, leaks off). Fixture
regenerated exactly, public choose example passed. English/Spanish docs and
compatibility record updated. Earlier checkpoint text below is historical.

Next: review, clean source extraction/rebuild/full tests/five examples, commit,
integrate, publish0.102, verify actual Ubuntu CI. Then continue compress/extract;
user requests sustained dependency completion. No overall percentage justified.
Two unsafe-span variants stay outside parity, unsafe source calls not executed;
three earlier take hang variants and40 blocked endian states remain separate.
Keep all verified old archives immutable. luanimath goal remains unfinished.

# Current checkpoint — choose 0.102 differential audit

Active worktree /mnt/datos/luaray/.dev/choose102, branch choose102. Runtime VERSION
still0.101 until the full feature gates finish. Native ln_choose.{c,h}, np.choose
and ndarray:choose compile; actual public example passed. First original NumPy
2.5.3 corpus:1530 cases passed; read artifacts/choose102-differential.log for
actual check count. Need expand dtype/broadcast/out/alias/readonly/empty/index
cases, native/Lua regression, ASan, full regression, bilingual docs and release.

Native output preserves upstream direct linear writes for safe in-owner spans,
but guards against owner overrun for reversed/zero-stride insufficient-tail out.
Unsafe upstream memory-corrupting spans have NOT been executed. Retain explicit
non-parity records/tests for the guard. Original in-bounds strided/transposed/
negative out states are frozen and passed. choose negative indices reject in
raise, wrap modulo and clip first; positive Lua positions are one-based.

Corpus caught shared datetime->Unicode too-short formatting: ln_dtype_transfer
now rejects instead of silently truncating. Direct S failed-prefix and Linux
fixed-year equal-capacity behavior follow inspected source/probes; need freeze
expanded width/unit/NaT cases and rerun all previous suites before completion.

0.101 is published at5dbdaa9 with source SHA
8e720711efd20963d485ab98f2ec3f6ee5044c1d95ca33871f27dd9213e815a4.
664files/663manifest, clean119 suites/four examples, eight-unit ASan4native19Lua
passed. Exact Ubuntu CI42531596071 SUCCESS. Downloads/source public hash verified.
Older checkpoint sections below are historical. User requests continuing past
release milestones until complete or usage exhausted; luanimath goal unfinished.

# Current checkpoint — 0.101 along-axis release gate

Active worktree /mnt/datos/luaray/.dev/along101, branch along101. VERSION0.101.
Native ln_along.{c,h}, np.take_along_axis / np.put_along_axis and shared ln_mapping
fixes are implemented. Actual original references: take2061/109722 checks,
put3599/430929 checks, 85 Lua checks and new C suite passed. All119 frozen fixture
files passed. Eight-unit ASan/UBSan: four native / nineteen Lua suites passed;
expanded final fixtures replayed successfully. Both fixture files reproduced.
Public module example passed. English/Spanish docs at docs/{en,es}/along_axis.md.

Next: review diff, clean source packaging/rebuild/full tests/four public examples,
commit/integrate, publish0.101 and verify actual Ubuntu CI. Then continue coherent
selection/advanced indexing work. Do not stop at this development release.
Numeric endian/object/structured/variable strings and general mixed-subspace
buffering remain incomplete. No overall completion percentage is justified.

0.100 is published at tag406aba8, source SHA
cc1497f316aea2cdfaa0d5ca787b00be352beb51910730ecad5e473c9e69cc80;
652 source files/651 manifest entries, clean117 suites/three examples, directed
six-unit ASan passed. Exact Ubuntu CI42530255799 on406aba8 passed. Downloads
source/checksum and public asset hash verified. Older checkpoints below are
historical and do not supersede this one. Keep release archives immutable.

# Current checkpoint — 0.100 native take release gate

0.99.1 is published (d6b7778); exact versioned Ubuntu CI 42527745200 passed.
Active worktree .dev/take100 branch take100 has VERSION 0.100.0-dev, native
np.take/ndarray:take, six-unit sanitizer audit and bilingual API reference.
All 117 frozen fixture files passed; new take 6,704 cases/324,615 checks,
63 Lua checks, C tests, reproducibility and public example passed. ASan/UBSan:
three native and fourteen Lua suites, linked dependencies uninstrumented,
leaks disabled. Older checkpoint sections below are historical.

Next gate: inspect diff, commit, clean source packaging/rebuild/full tests,
merge into main, public tag/release/Downloads artifact and actual Ubuntu CI.
Do not claim 0.100 published until those actions finish. Keep immutable older
archives. Then continue take_along_axis/put_along_axis and dependency parity;
user explicitly requested sustained work. luanimath remains unfinished at
/mnt/datos/luanimath. No overall completion percentage is justified.

# Active dependency work

## Current — 0.99.1 portability correction

Ubuntu native CI initially failed inverse-exponential float32 rounding; direct
loading of official Ubuntu libm 2.39 reproduced three one-ULP differences.
80-digit Decimal calculations confirm the frozen expected values. Corrected
ln_random's inverse float32 path to evaluate log1p in double then round to float.
No fixture or tolerance weakened; next-PCG64 word is preserved. Corrected-code
CI run 42526947924 on commit 965203b passed all 116 suites and both examples.

Current VERSION=0.99.1-dev. Local full-test passed after version metadata updates.
Directed ASan/UBSan passed four modified C units including ln_random, two native
tests and twelve Lua suites; dependencies uninstrumented, leaks off. Read
PROGRESS_0_99_1.md and docs/{en,es}/portability.md. Clean source packaging and
0.99.1 publication are the next gate; do not claim that release exists yet.

Next take work is ISOLATED in git worktree /mnt/datos/luaray/.dev/take100, branch
take100, based on 965203b. It has new ln_take.{c,h}, Makefile links, np.take and
ndarray:take (axis/options/out/modes/scalars). Native compilation and basic actual
Lua take/out examples passed; NO NumPy differential take corpus or sanitizer
has run yet. Do not mark take complete. Merge current main into that branch
after the patch release to inherit 0.99.1/version/docs/packaging changes before
advancing to 0.100. .dev symlinks its oracle venv/source to the parent repo.

Take implementation retains source-derived out preconversion, raise-mode temp,
C-order source normalization, live compatible out/indices and chunk-at-once
index loads. Next: build actual NumPy corpus; arrays of indices use SAME_KIND,
positive Lua coordinates shift by one and negative values are unchanged. For
live out/index alias tests use negative source values so dynamically overwritten
index encodings remain identical in both languages. Read prior source facts below.

No source empty-axis wrap hang has been executed/confirmed yet; use bounded
subprocess investigation before including that potentially hanging oracle case.

Docker command exists but access to daemon is denied. Do not change permissions
or system config; actual Ubuntu CI is available and passed the correction.
Old-libc extraction cannot run the full Arch binary due to ABI requirements;
only the direct log1pf diagnostic was executed locally with that older library.

## Latest checkpoint — 0.99 published

0.99 is published at https://github.com/48hoursnonstop/luaray/releases/tag/v0.99.0-dev
(commit 1953e26). SHA-256:
a556554d0fbdf9a231951bd9be409d6efbcce39baf2adff8bf1de5fdf396c6df.
635 source files/634 manifest entries. Clean extraction, rebuild, all 116 frozen
fixture files and both dynamic-module examples passed. Three changed C units
passed ASan/UBSan: two native and ten Lua suites; dependencies uninstrumented,
leaks off. Downloads copy plus checksum are present. Preserve immutable archives.

0.99 copyto: 4914 original cases/138217 checks; putmask: 1481/36893;
77 Lua regressions. Core now follows destination-stride raw iteration, mask-run
scanning/live aliasing, source overlap direction, weak scalars and alignment-
dependent 128-element text cast buffers. Fix memcpy overlap detected by ASan,
identity string self-copy and complex temporal conversion. Read PROGRESS_0_99.md,
docs/{en,es}/masked_writes.md, compatibility/current.json. Historical .98/.97
fixtures remain; the .98 generator was refactored under main() and reproduced
original fixtures byte-for-byte. No full NumPy parity is claimed.

GitHub native CI run 42526293798 was started on 1953e26; check its actual result
before claiming remote success. Workflow runs Ubuntu native/frozen tests, no
Python/NumPy runtime. 0.99 original source/test hashes have a dedicated manifest.

Continue 0.100 indexing: upstream take/take_along_axis/put_along_axis inspected,
but NO take code has been written yet. Start with genuine take (axis, shape,
raise/wrap/clip, dtype/strides, scalar results and real out aliases). Important
source facts: take casts indices using SAME_KIND (put uses SAFE); source is made
C-contiguous; raise-mode out always uses a temporary; wrap/clip out may read
aliased indices live. Different-dtype out is preconverted to source dtype before
taking and unsafe-cast back. Scalar output should use existing push_scalar_at.
Along-axis helpers require integer indices and matching rank with non-axis
broadcasting. Lua positive indices/axes are one-based, zero rejected; document
and translate the oracle consistently. Proposed Lua take interface:
np.take(a,indices,axis_or_options), options={axis=...,mode=...,out=...}, nil/false
axis flattens; ndarray:take shares it. Resolve ordinary API details autonomously.

Check the edge empty source axis plus zero trailing chunk before testing wrap:
upstream fasttake has while loops with max_item==0 that may hang (inference only,
NOT executed/confirmed). Use a subprocess timeout to investigate if needed;
never launch an unbounded reference call or claim this inference as proven.

User asked to continue dependency work rather than stop at a release; keep
working until actual completion or available usage exhaustion. Latest telemetry
49 percent weekly used/51 remaining (old 50-percent restriction revoked).

## Earlier checkpoint — 0.98

Workspace: /mnt/datos/luaray. Imported verified 0.97 source from Downloads;
the original tarball remains unchanged. Git baseline e6239fd preserves it.
User explicitly requested continuing LuaRay 0.98 put/place first, before more
luanimath features. Do not resume the animation port prematurely.

0.98 implementation is verified in the working tree. Read PROGRESS_0_98.md,
docs/en/writing.md and docs/es/writing.md. Full test: 114 fixture files, 1735 new
original cases/42754 checks, 94 new Lua checks, native C tests, public Lua example.
Directed ASan/UBSan instruments all three changed C units, dependencies excluded,
leaks disabled. Forty original numeric-endian states are explicitly blocked,
retained and diagnosed, never counted as parity.

0.98 is now clean-verified and publicly published at
https://github.com/48hoursnonstop/luaray/releases/tag/v0.98.0-dev (tag commit 3e9e2d9).
Archive SHA-256: add9ff27c360878b3a86d346bdcc1ccba58d88ff8ec85f130c9c50874be2c9c8.
GitHub asset digest matches, and the Downloads copy is
/home/yhwh/Downloads/LuaRay-0.98.0-dev-source-20261108.tar.gz with its checksum.
623 source files, 622 manifest entries, actual clean full-test and example passed.
Immutable archive/reports/logs are preserved under releases/.

Continue the next dependency subsystem; do not stop just at a release.
Current 0.99 technical audit: copyto/putmask conversion and empty values/masks, followed
by more indexing/assignment and numeric descriptor prerequisites.

Development oracle: .dev/venv has NumPy 2.5.3; pinned source .dev/numpy-2.5.3.
Reference source hashes are NUMPY_2_5_3_WRITE98_FILE_HASHES.sha256. Build C at -O2
and PocketFFT at -O0 using documented CXXFLAGS. CBLAS/libblas and LAPACK are
already installed; the updated Makefile discovers libcblas on Arch.

luanimath stays at /mnt/datos/luanimath, commit 91032c5, with tested but unreleased
0.15 arrow families. Its release packaging and final migration-link rebuild are
pending. Portable TeX Live scheme-basic finished in /mnt/datos/Tools/texlive-2026;
no Lua TeX adapter was added. Do not change global config.

The user's old 50-percent usage limit was revoked; continuous engineering until
actual completion or available usage exhaustion remains authorized. Latest
weekly telemetry: 46 percent used/54 remaining at 2026-11-08T21:08:46Z.
