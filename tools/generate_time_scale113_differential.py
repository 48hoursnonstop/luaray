#!/usr/bin/env python3
"""Original NumPy2.5.3 floating timedelta scaling required by round."""
import warnings
import numpy as np
from generate_layout110_differential import Suite,views,array as plain_array
from generate_binary109_differential import lua,dtype
assert np.__version__=='2.5.3'

def array(a):
    a=np.asarray(a)
    if a.dtype.kind in 'Mm':
        # A bare Lua -9223372036854775808 token is parsed through a float;
        # preserve NaT and every int64 tick via a real typed array conversion.
        return 'np.array('+plain_array(a.astype('int64'))+','+lua(str(a.dtype))+')'
    return plain_array(a)

class Scale(Suite):
    def case(self,original,view,factors,op,*,reverse=False,raw=False,mode='new',out_dtype=None,mask=False):
        self.count+=1
        if (self.count-1)%60==0:
            if self.count>1:self.lines+=['end','chunk()','end']
            self.lines+=['do','local function chunk()']
        base=np.array(original,copy=True)
        _,a,expr=next(v for v in views(base) if v[0]==view)
        b=factors if raw else np.array(factors,copy=True)
        self.lines+=['do','local base='+array(base),'local a='+expr,
                     'local b='+(lua(b) if raw else array(b))]
        out=None;kwargs={};opts=[]
        if mode=='inplace':out=a;out_expr='a'
        elif mode=='out':
            out=np.full(a.shape,7,dtype=out_dtype or a.dtype)
            out_expr='np.full(a.shape,7,'+lua(dtype(out.dtype))+')'
        elif mode=='readonly':
            out=np.broadcast_to(np.array(7,dtype=out_dtype or a.dtype),a.shape)
            out_expr='np.broadcast_to(np.array(7,'+lua(dtype(out.dtype))+'),a.shape)'
        if out is not None:self.lines+=['local out='+out_expr];kwargs['out']=out;opts+=['out=out']
        if mask:
            where=np.arange(a.size).reshape(a.shape)%2==0
            self.lines+=['local where='+array(where)];kwargs['where']=where;opts+=['where=where']
        label=f'{op}/{dtype(base.dtype)}/{view}/{dtype(np.asarray(b).dtype)}/reverse{reverse}/{mode}/{out_dtype}/mask{mask}/raw{raw}'
        try:
            with warnings.catch_warnings(),np.errstate(all='ignore'):
                warnings.simplefilter('ignore');result=getattr(np,op)(b,a,**kwargs) if reverse else getattr(np,op)(a,b,**kwargs)
            ok=True
        except (TypeError,ValueError,OverflowError):ok=False
        call='np.'+op+'('+('b,a' if reverse else 'a,b')+(',{'+','.join(opts)+'}' if opts else '')+')'
        self.lines+=['local ok,result=pcall(function()return '+call+'end)',
                     'assert(ok=='+lua(ok)+','+lua(label+': acceptance')+'..": "..tostring(result))']
        if ok:
            self.check('result',result,label+': result')
            if out is not None:self.lines+=['eq(rawequal(result,out),true,'+lua(label+': identity')+')']
        if out is not None:self.check('out',out,label+': output')
        self.check('a',a,label+': input')
        self.check('base',base,label+': backing')
        self.lines+=['cases=cases+1','end']

def main():
    s=Scale('time_scale113')
    for unit in ['h','ms','2D','M','Y']:
        base=np.array([[0,1,-1],[10,-10,-2**63]],dtype='int64').astype('timedelta64['+unit+']')
        for view,a,_ in views(base):
            for dt in ['float16','float32','float64','longdouble','complex128','U2']:
                factors=np.array(.5,dtype=dt)
                for op in ['multiply','true_divide']:
                    for reverse in [False,True]:s.case(base,view,factors,op,reverse=reverse)
                    s.case(base,view,factors,op,mode='inplace')
                    s.case(base,view,factors,op,mode='out',mask=True)
        for op in ['multiply','true_divide']:
            for value in [0.,-0.,.5,-2.,np.inf,-np.inf,np.nan,1e300,1e-300]:
                for reverse in [False,True]:s.case(base,'base',value,op,reverse=reverse,raw=True)
                for out_dt in ['timedelta64[h]','timedelta64[ms]','datetime64[ms]','float64','U40']:
                    s.case(base,'base',value,op,raw=True,mode='out',out_dtype=out_dt,mask=True)
            s.case(base,'base',np.array(.5),op,mode='readonly')
            extremes=np.array([-2**63,-2**63+1,2**63-1,2**63-2,0,1],dtype='int64').astype(base.dtype)
            for value in [1.,2.,-1.,.5]:s.case(extremes,'base',value,op,raw=True)
            for shape in [(),(0,)]:
                small=np.array(10,dtype=base.dtype) if not shape else np.empty(shape,dtype=base.dtype)
                s.case(small,'base',.5,op,raw=True)
    s.write()
if __name__=='__main__':main()
