#!/usr/bin/env python3
"""Diagnose float32 log1pf against 80-digit arithmetic; no NumPy required."""
import argparse
import ctypes
import decimal
import json

parser=argparse.ArgumentParser()
parser.add_argument('libm',help='path/name of a shared libm, loaded only in this process')
args=parser.parse_args()
lib=ctypes.CDLL(args.libm)
lib.log1pf.argtypes=[ctypes.c_float];lib.log1pf.restype=ctypes.c_float
decimal.getcontext().prec=80
rows=[]
# Exact PCG64(seed=0) float32 uniforms at draws 11, 14 and 16.
for draw,u in [(11,0.6494157314300537),(14,0.6066357493400574),(16,0.7294965386390686)]:
    reference=-(decimal.Decimal(1)-decimal.Decimal.from_float(u)).ln()
    expected=ctypes.c_float(float(reference)).value
    actual=-lib.log1pf(-u)
    rows.append(dict(draw=draw,input=u,log1pf_result=actual,reference_80_digit=str(reference),
                     reference_float32=expected,equal=actual==expected))
print(json.dumps(dict(library=args.libm,pcg64_seed=0,results=rows),indent=2))
