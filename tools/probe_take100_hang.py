#!/usr/bin/env python3
"""Bound the known upstream empty-axis wrap loop; never run it in this process."""
import json
import subprocess
import sys

code="import numpy as np;print(np.__version__+' entered',flush=True);np.take(np.zeros((3,0,0),dtype=np.int32),[0],axis=1,mode='wrap');print('returned',flush=True)"
try:
    result=subprocess.run([sys.executable,'-c',code],capture_output=True,text=True,timeout=3)
    print(json.dumps(dict(returncode=result.returncode,stdout=result.stdout,stderr=result.stderr,timed_out=False),indent=2))
except subprocess.TimeoutExpired as error:
    output=(error.stdout or b'').decode('utf-8','replace')
    assert '2.5.3 entered' in output,'reference did not reach the actual take call'
    print(json.dumps(dict(numpy='2.5.3',shape=[3,0,0],dtype='int32',indices=[0],axis=1,mode='wrap',
                         timeout_seconds=3,timed_out=True,stdout=output),indent=2))
