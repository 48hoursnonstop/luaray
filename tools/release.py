#!/usr/bin/env python3
"""Source-only archive, SHA-256 manifest and an actual clean build/test gate."""
from pathlib import Path
import hashlib
import json
import os
import subprocess
import tarfile
import tempfile

ROOT=Path(__file__).resolve().parents[1]
VERSION=(ROOT/'VERSION').read_text().strip()
NAME='luaray-'+VERSION
RELEASES=ROOT/'releases';RELEASES.mkdir(exist_ok=True)
(ROOT/'.dev').mkdir(exist_ok=True)
coverage=json.loads((ROOT/'compatibility/current.json').read_text())
assert coverage['version']==VERSION,'release compatibility record has stale version'
assert not (RELEASES/(NAME+'-verification.json')).exists(),'verified release already exists; preserve immutable archives'
EXCLUDED={'.git','.dev','artifacts','releases','build','__pycache__','.pytest_cache'}
files=[]
for directory,dirs,names in os.walk(ROOT):
    dirs[:]=sorted(d for d in dirs if d not in EXCLUDED and not d.startswith('build-'))
    for name in sorted(names):
        p=Path(directory)/name
        if name not in EXCLUDED and name!='PROJECT_SHA256SUMS' and not name.endswith('.pyc'):
            assert not p.is_symlink(),f'unexpected source symlink: {p}'
            assert p.suffix not in {'.o','.so'},f'compiled file in source tree: {p}'
            files.append(p)
files.sort()
manifest=ROOT/'PROJECT_SHA256SUMS'
manifest.write_text(''.join(hashlib.sha256(p.read_bytes()).hexdigest()+'  '+p.relative_to(ROOT).as_posix()+'\n' for p in files))
files.append(manifest)
archive=RELEASES/(NAME+'-source.tar.gz')
with tarfile.open(archive,'w:gz') as tar:
    for path in sorted(files):tar.add(path,arcname=NAME+'/'+path.relative_to(ROOT).as_posix(),recursive=False)
digest=hashlib.sha256(archive.read_bytes()).hexdigest()
archive.with_suffix(archive.suffix+'.sha256').write_text(digest+'  '+archive.name+'\n')
log=RELEASES/(NAME+'-clean-build.log')
with tempfile.TemporaryDirectory(prefix='clean-release-',dir=ROOT/'.dev') as temp:
    with tarfile.open(archive) as tar:tar.extractall(temp,filter='data')
    clean=Path(temp)/NAME
    env=os.environ.copy()
    for key in ['LUA_PATH','LUA_CPATH','LD_PRELOAD']:env.pop(key,None)
    with log.open('w') as output:
        subprocess.run(['sha256sum','--check','PROJECT_SHA256SUMS'],cwd=clean,env=env,stdout=output,stderr=subprocess.STDOUT,check=True)
        subprocess.run(['make','-j4','full-test','CXXFLAGS=-O0 -g -std=c++11 -Wall -Wextra -Wpedantic'],cwd=clean,env=env,stdout=output,stderr=subprocess.STDOUT,check=True)
        env['LUA_PATH']=str(clean/'lua/?.lua')+';;'
        env['LUA_CPATH']=str(clean/'build/?.so')+';;'
        subprocess.run(['lua5.4','examples/writing98.lua'],cwd=clean,env=env,stdout=output,stderr=subprocess.STDOUT,check=True)
        subprocess.run(['lua5.4','examples/masked_writes99.lua'],cwd=clean,env=env,stdout=output,stderr=subprocess.STDOUT,check=True)
        subprocess.run(['lua5.4','examples/take100.lua'],cwd=clean,env=env,stdout=output,stderr=subprocess.STDOUT,check=True)
        subprocess.run(['lua5.4','examples/along101.lua'],cwd=clean,env=env,stdout=output,stderr=subprocess.STDOUT,check=True)
        subprocess.run(['lua5.4','examples/choose102.lua'],cwd=clean,env=env,stdout=output,stderr=subprocess.STDOUT,check=True)
report=dict(version=VERSION,archive=archive.name,sha256=digest,source_files=len(files),
            manifest_entries=len(files)-1,clean_build='passed',clean_log=log.name,
            differential_fixture_files=len(list((ROOT/'tests').glob('*_differential_generated.lua'))),
            new_oracle=coverage['new_oracle'],new_reference_cases=coverage['new_reference_cases'],
            blocked_original_states=coverage['blocked_original_states'],
            runtime='Lua 5.4, native C/C++ module, CBLAS/BLAS and LAPACK; no Python',
            build_flags='C: -O2; C++ PocketFFT: -O0',
            sanitizers=coverage.get('sanitizers','Separate directed audit: ln_write, ln_dtype_transfer and lua_module; other dependencies uninstrumented; leaks disabled'))
(RELEASES/(NAME+'-verification.json')).write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2))
