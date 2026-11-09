#!/usr/bin/env python3
"""Original NumPy2.5.3 reality/value/type predicates and strict closeness."""
import warnings
import numpy as np
from generate_layout110_differential import Suite,views,array as plain_array,base_array
from generate_binary109_differential import lua,dtype
assert np.__version__=='2.5.3'

def array(a):
    a=np.asarray(a)
    if a.dtype==np.dtype('clongdouble') and a.size:
        # Decimal complex casts in NumPy itself round through complex128;
        # they cannot initialize an exact x87 boundary/subnormal reference.
        # Build original binary significands with real native ldexp/stack,
        # then write the actual imaginary component view.
        rounded=a.imag.astype('float64').astype('longdouble')
        if np.any((rounded!=a.imag)&~np.isnan(a.imag)):
            def scalar(x):
                if not np.isfinite(x) or x==0:return 'np.array('+lua(x)+',"longdouble")'
                mantissa,exponent=np.frexp(abs(x))
                significand=int(np.ldexp(mantissa,64))
                high,low=divmod(significand,2**32)
                term='(np.ldexp(np.array('+str(high)+',"longdouble"),32)+np.array('+str(low)+',"longdouble"))'
                value='np.ldexp('+term+','+str(int(exponent)-64)+')'
                return '-'+value if x<0 else value
            values=','.join(scalar(x) for x in a.imag.flat)
            imag='np.reshape(np.stack({'+values+'}),'+lua(a.shape)+')'
            return '(function()local out='+plain_array(a.real.astype('float64').astype('clongdouble'))+';np.copyto(out.imag,'+imag+',"unsafe");return out end)()'
    return plain_array(a)

class Predicates(Suite):
    def case(self,original,view,op,tol=None):
        self.count+=1
        if (self.count-1)%60==0:
            if self.count>1:self.lines+=['end','chunk()','end']
            self.lines+=['do','local function chunk()']
        base=np.array(original,copy=True)
        _,a,expr=next(v for v in views(base) if v[0]==view)
        label=f'{op}/{dtype(base.dtype)}{base.shape}/{view}/tol{tol}'
        self.lines+=['do','local base='+array(base),'local a='+expr]
        try:
            with warnings.catch_warnings(),np.errstate(all='ignore'):
                warnings.simplefilter('ignore')
                result=getattr(np,op)(a,tol=tol) if op=='real_if_close' and tol is not None else getattr(np,op)(a)
            ok=True
        except (TypeError,ValueError,OverflowError):ok=False
        call='np.'+op+'(a'+(','+lua(tol) if tol is not None else '')+')'
        self.lines+=['local ok,result=pcall(function()return '+call+'end)',
                     'assert(ok=='+lua(ok)+','+lua(label+': acceptance')+'..": "..tostring(result))']
        if ok:
            if op.endswith('obj'):
                self.lines+=['eq(result,'+lua(bool(result))+','+lua(label+': object predicate')+')']
            else:
                self.check('result',np.asarray(result),label+': initial')
                if op=='real_if_close':
                    self.lines+=['eq(rawequal(result,a),'+lua(result is a)+','+lua(label+': identity')+')',
                                 'eq(np.shares_memory(result,a),'+lua(np.shares_memory(result,a))+','+lua(label+': sharing')+')']
                fill=np.array(7+2j if np.asarray(result).dtype.kind=='c' else 7,dtype=np.asarray(result).dtype)
                if np.asarray(result).dtype.kind in 'SU':fill=np.array('Z',dtype=np.asarray(result).dtype)
                # Array results may be scalar NumPy bools; normalize only the
                # output for the deliberate typed-0D Lua return adaptation.
                writable_result=np.asarray(result)
                try:np.copyto(writable_result,fill,casting='unsafe');writable=True
                except (ValueError,TypeError):writable=False
                self.lines+=['local write_ok=pcall(function()np.copyto(result,'+array(fill)+',"unsafe")end)',
                             'eq(write_ok,'+lua(writable)+','+lua(label+': writable')+')']
                self.check('result',writable_result,label+': after write')
        self.check('a',a,label+': input after write')
        self.check('base',base,label+': backing after write')
        self.lines+=['cases=cases+1','end']

def main():
    pred,close=Predicates('predicates112'),Predicates('close112')
    dtypes=['bool','int8','uint64','float16','float32','float64','longdouble','complex64','complex128','clongdouble','S4','U4','>U4','datetime64[ms]','timedelta64[h]']
    for dt in dtypes:
        for shape in [(2,3,4),(2,0,3),(),(1,),(6,)]:
            base=np.array(base_array(shape,dt),copy=True)
            for name,_,_ in views(base):
                for op in ['isreal','iscomplex','isrealobj','iscomplexobj']:pred.case(base,name,op)
                for tol in [None,0,1,100,'bad']:close.case(base,name,'real_if_close',tol)
    for dt in ['complex64','complex128','clongdouble']:
        component=np.empty((),dt).real.dtype
        special=np.array([complex(0,np.nan),complex(np.nan,0),complex(0,np.inf),complex(1,-0.0)],dt)
        for op in ['isreal','iscomplex','isrealobj','iscomplexobj']:pred.case(special,'base',op)
        for tol in [False,True,-1,0,.1,1.,1.0000000001,100,1e12,2**62+1,np.inf,-np.inf,np.nan]:
            t=np.asarray(tol,dtype=component)
            threshold=np.asarray(np.finfo(component).eps*t if tol>1 else t,dtype=component)
            if np.isfinite(threshold):
                points=[np.nextafter(threshold,np.asarray(-np.inf,component)),threshold,
                        np.nextafter(threshold,np.asarray(np.inf,component))]
            else:points=[np.asarray(0,component)]
            for value in points:
                for sign in [1,-1]:
                    base=np.array([1,2],dt);base.imag=sign*value
                    for name in ['base','F','reverse_first','broadcast']:
                        close.case(base,name,'real_if_close',tol)
            close.case(special,'base','real_if_close',tol)
            close.case(np.empty((0,),dt),'base','real_if_close',tol)
    for s in [pred,close]:s.write()
    # LuaRay's legacy root astype exposes ndarray.astype string conversions;
    # this is not a claim about NumPy's numeric-only root Array API astype.
    text=Predicates('complex_text112')
    samples=['1+2j','1+j','1-j','j','-j','+j',' ( 1+2j ) ',
             '(1-4e-4951j)','(1+1e-4000j)','(1+0.5000000000000000001j)',
             '1e5000+2j','-1e5000-1e-5000j','5e-324j','1e-324j',
             '1.0000000596046448+1.0000000596046447j','1_0+2_0j',
             'nan+infj','-infinity-infj','NAN+NANj','1J','1e+2-3e-4j',
             '','()','_1j','1__2j','1_j','1+_2j','0x1p0+2j','nan(0x1)j',
             '1\x00+2j','1 +2j','1+ 2j','1+2j trailing','((1+2j))']
    for src in ['S80','U80','>U80']:
        for target in ['complex64','complex128','clongdouble','bool','int64','float64']:
            for value in samples:
                text.count+=1
                if (text.count-1)%60==0:
                    if text.count>1:text.lines+=['end','chunk()','end']
                    text.lines+=['do','local function chunk()']
                a=np.array([value],src)
                try:
                    with warnings.catch_warnings(),np.errstate(all='ignore'):
                        warnings.simplefilter('ignore');r=a.astype(target)
                    ok=True
                except (ValueError,TypeError,OverflowError):ok=False
                label=f'{src}->{target}/{value!r}'
                text.lines+=['do','local a='+array(a),
                    'local ok,result=pcall(function()return np.astype(a,'+lua(target)+')end)',
                    'assert(ok=='+lua(ok)+','+lua(label+': acceptance')+'..": "..tostring(result))']
                if ok:text.check('result',r,label)
                text.check('a',a,label+': input')
                text.lines+=['cases=cases+1','end']
    text.write()

if __name__=='__main__':main()
