#!/usr/bin/env python3
"""Measure runtime callable availability; never infer full behavior from a name."""
from pathlib import Path
import argparse,json,os,subprocess,tempfile,warnings
import numpy as np
assert np.__version__=='2.5.3'
ROOT=Path(__file__).resolve().parents[1]
parser=argparse.ArgumentParser()
parser.add_argument('--module-dir',type=Path,default=ROOT/'build')
options=parser.parse_args()
entries=[]
for group,namespace,prefix in [('numpy',np,[]),('numpy.fft',np.fft,['fft']),('numpy.linalg',np.linalg,['linalg']),('numpy.random',np.random,['random'])]:
    for name in sorted(set(namespace.__all__)):
        with warnings.catch_warnings():
            warnings.simplefilter('ignore')
            value=getattr(namespace,name,None)
        if callable(value):
            kind='type' if isinstance(value,type) else 'ufunc' if isinstance(value,np.ufunc) else 'callable'
            row=dict(api=group+'.'+name,group=group,prototype='module',path=prefix+[name],upstream_kind=kind)
            if isinstance(value,type) and issubclass(value,BaseException):
                row['language_adaptation']='Python exception class: the native Lua API raises Lua errors instead of reproducing a Python exception-class hierarchy; exact Python exception-class fidelity is not claimed.'
            entries.append(row)
for group,namespace,prototype in [('numpy.ndarray',np.ndarray,'array'),('numpy.random.Generator',np.random.Generator,'generator'),('numpy.ufunc',np.ufunc,'ufunc')]:
    for name in sorted(dir(namespace)):
        if not name.startswith('_') and callable(getattr(namespace,name)):
            entries.append(dict(api=group+'.'+name,group=group,prototype=prototype,path=[name],upstream_kind='method'))
entries.sort(key=lambda row:row['api'])
def lua_string(value):return json.dumps(value,ensure_ascii=False)
rows=['{'+','.join([lua_string(row['api']),lua_string(row['prototype']),'{'+','.join(map(lua_string,row['path']))+'}'])+'}' for row in entries]
script='''local np=require('luaray_core')
local prototypes={module=np,array=np.array({{0,1,2},{3,4,5}}),generator=np.random.default_rng(0),ufunc=np.add}
local function callable(v)
 if type(v)=='function' then return true end
 if type(v)=='table' or type(v)=='userdata' then
  local mt=getmetatable(v)
  return type(mt)=='table' and type(mt.__call)=='function'
 end
 return false
end
print('__version__\\t'..np._version)
local rows={'''+','.join(rows)+'''}
for _,row in ipairs(rows) do
 local ok,value=pcall(function()
  local value=prototypes[row[2]]
  for _,key in ipairs(row[3]) do if value==nil then return nil end;value=value[key] end
  return value
 end)
 print(row[1]..'\\t'..(ok and type(value) or 'lookup_error')..'\\t'..(ok and callable(value) and 'true' or 'false'))
end
'''
with tempfile.TemporaryDirectory(prefix='luaray-inventory-') as temp:
    path=Path(temp)/'probe.lua';path.write_text(script)
    env=os.environ.copy();env['LUA_CPATH']=str(options.module_dir.resolve()/'?.so')+';;'
    output=subprocess.check_output(['lua5.4',str(path)],cwd=ROOT,env=env,text=True)
lines=output.splitlines();assert lines[0].startswith('__version__\t')
version=lines.pop(0).split('\t')[1]
assert version==(ROOT/'VERSION').read_text().strip(),'inventory module/version mismatch'
observed={}
for line in lines:
    api,kind,available=line.split('\t');observed[api]=(kind,available=='true')
assert set(observed)=={row['api'] for row in entries}
groups={}
for row in entries:
    kind,available=observed[row['api']]
    row.update(lua_type=kind,lua_callable_available=available,
               status='not_applicable_to_lua' if 'language_adaptation' in row else 'implemented_partial' if available else 'not_implemented',
               behavioral_audit='not_assessed_by_this_availability_inventory')
    group=groups.setdefault(row['group'],dict(scoped_names=0,available_callables=0,not_applicable_to_lua=0))
    group['scoped_names']+=1;group['available_callables']+=available
    group['not_applicable_to_lua']+=row['status']=='not_applicable_to_lua'
for group in groups.values():
    group['missing_callables']=group['scoped_names']-group['available_callables']-group['not_applicable_to_lua']
report=dict(upstream='NumPy 2.5.3',lua_version=version,
            scope='Public callable names in numpy/fft/linalg/random __all__, ndarray/Generator/ufunc public methods. Aliases counted separately; not constants, properties, all submodules or dtype loop combinations.',
            interpretation='Availability is observed at runtime; every available callable remains partial. This inventory alone verifies no behavior or full compatibility. Release-specific original fixtures provide separate behavioral evidence.',
            complete_apis_declared=0,groups=groups,entries=entries)
p=ROOT/'compatibility/api_inventory.json';p.write_text(json.dumps(report,indent=2,ensure_ascii=False)+'\n')
print(json.dumps(dict(lua_version=version,groups=groups,scoped_names=len(entries),available_callables=sum(row['lua_callable_available'] for row in entries),complete_apis_declared=0),indent=2))
