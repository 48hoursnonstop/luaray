#!/usr/bin/env python3
"""Native raw-bit string-cast reference: every half encoding and wider samples."""
from pathlib import Path
import json,warnings
import numpy as np
assert np.__version__=='2.5.3'
ROOT=Path(__file__).resolve().parents[1]
rng=np.random.default_rng(106)
lines=['/* Original NumPy2.5.3 raw-bit numerical string casts. */',
       'static const char *const format106_half_expected[]={']
with warnings.catch_warnings():
    warnings.simplefilter('ignore')
    expected=np.arange(65536,dtype='uint16').view('float16').astype('U128')
lines += [json.dumps(str(x))+',' for x in expected];lines+=['};']
for kind,dt in [('single','float32'),('double','float64')]:
    it='uint32' if dt=='float32' else 'uint64'
    bits=rng.integers(0,np.iinfo(it).max,2048,dtype=it)
    special=np.array([0.,-0.,1.,-1.,.0001,1e-5,1000,1e6,1e16,np.inf,-np.inf,np.nan,1.23456789,np.finfo(dt).tiny,np.finfo(dt).max],dt)
    bits=np.concatenate([special.view(it),bits]);a=bits.view(dt)
    with warnings.catch_warnings():warnings.simplefilter('ignore');expected=a.astype('U128')
    lines += ['static const struct {uint64_t bits;const char *text;} format106_'+kind+'[]={']
    lines += ['{UINT64_C('+str(int(b))+'),'+json.dumps(str(t))+'},' for b,t in zip(bits,expected)]
    lines += ['};']
for kind,dt,it in [('csingle','complex64','uint32'),('cdouble','complex128','uint64')]:
    bits=rng.integers(0,np.iinfo(it).max,1024,dtype=it).reshape(-1,2)
    # Ordinary/nonfinite combinations cover special complex sign formatting.
    real=np.array([0.,-0.,1.,-1.,np.nan,-np.nan,np.inf,-np.inf],dtype='float32' if dt=='complex64' else 'float64')
    extra=np.array([(r,i) for r in real.view(it) for i in real.view(it)],it)
    bits=np.concatenate([extra,bits]);a=bits.reshape(-1).view(dt)
    with warnings.catch_warnings():warnings.simplefilter('ignore');expected=a.astype('U128')
    lines += ['static const struct {uint64_t real,imag;const char *text;} format106_'+kind+'[]={']
    lines += ['{UINT64_C('+str(int(b[0]))+'),UINT64_C('+str(int(b[1]))+'),'+json.dumps(str(t))+'},' for b,t in zip(bits,expected)]
    lines += ['};']
# Executed primary ABI is x86 extended precision stored in16 bytes.
if np.finfo(np.longdouble).nmant==63:
    with warnings.catch_warnings():
        warnings.simplefilter('ignore')
        a=np.array(['0','-0','1','-1','.0001','.00001','1e16','1.234567890123456789','1e4932','1e-4932','inf','-inf','nan'],dtype='longdouble')
    a=np.concatenate([a,np.nextafter(np.zeros(1,'longdouble'),np.ones(1,'longdouble'))])
    with warnings.catch_warnings():warnings.simplefilter('ignore');expected=a.astype('U128')
    lines+=['#if LDBL_MANT_DIG == 64 && __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__',
            'static const struct {unsigned char bytes[10];const char *text;} format106_extended[]={']
    lines += ['{{'+','.join(str(v) for v in a[i:i+1].tobytes()[:10])+'},'+json.dumps(str(t))+'},' for i,t in enumerate(expected)]
    lines+=['};','#endif']
(ROOT/'tests/format106_reference.h').write_text('\n'.join(lines)+'\n')
print('format106 reference:65536 half,2063 single,2063 double,576 complex64,576 complex128,14 x86 extended states')
