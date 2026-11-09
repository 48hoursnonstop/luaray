#!/usr/bin/env python3
"""Original NumPy2.5.3 rounding composition, output precision and writes."""
import warnings
import numpy as np
from generate_layout110_differential import Suite,views,array
from generate_binary109_differential import lua,dtype
assert np.__version__=='2.5.3'

class Round(Suite):
    def check(self,name,a,label):
        super().check(name,a,label)
        a=np.asarray(a)
        parts=[(name,a)] if a.dtype.kind=='f' else [(name+'.real',a.real),(name+'.imag',a.imag)] if a.dtype.kind=='c' else []
        for expr,part in parts:
            negative_zero=np.signbit(part)&(part==0)
            self.lines.append('eq(np.logical_and(np.signbit('+expr+'),np.equal('+expr+',0)):tolist(),'+lua(negative_zero)+','+lua(label+': signed zero')+')')
    def case(self,original,view,decimals,*,mode='new',out_dtype='float64',method=False,alias=False):
        self.count+=1
        if (self.count-1)%60==0:
            if self.count>1:self.lines+=['end','chunk()','end']
            self.lines+=['do','local function chunk()']
        base=np.array(original,copy=True)
        _,a,expr=next(v for v in views(base) if v[0]==view)
        out=None
        self.lines+=['do','local base='+array(base),'local a='+expr]
        if mode=='inplace':out=a;out_expr='a'
        elif mode=='reverse':out=np.flip(base,0);out_expr='np.flip(base,1)'
        elif mode=='component':out=a.real;out_expr='a.real'
        elif mode=='Fout':out=np.full(a.shape,7,dtype=out_dtype,order='F');out_expr='np.full(a.shape,7,{dtype='+lua(dtype(out.dtype))+',order="F"})'
        elif mode=='out':out=np.full(a.shape,7,dtype=out_dtype);out_expr='np.full(a.shape,7,'+lua(dtype(out.dtype))+')'
        elif mode=='readonly':out=np.broadcast_to(np.array(7,dtype=out_dtype),a.shape);out_expr='np.broadcast_to(np.array(7,'+lua(dtype(out.dtype))+'),a.shape)'
        elif mode=='flatout':out=np.full((a.size,),7,dtype=out_dtype);out_expr='np.full({a.size},7,'+lua(dtype(out.dtype))+')'
        elif mode=='badsize':out=np.full((a.size+1,),7,dtype=out_dtype);out_expr='np.full({a.size+1},7,'+lua(dtype(out.dtype))+')'
        if out is not None:self.lines+=['local out='+out_expr]
        label=f'round/{dtype(base.dtype)}{base.shape}/{view}/d{decimals}/{mode}/{out_dtype}/method{method}'
        try:
            with warnings.catch_warnings(),np.errstate(all='ignore'):
                warnings.simplefilter('ignore');result=a.round(decimals,out=out) if method else np.round(a,decimals,out=out)
            ok=True
        except (TypeError,ValueError,OverflowError):ok=False
        fn='a:round(' if method else 'np.'+('around' if alias else 'round')+'(a,'
        call=fn+lua(decimals)+(',out' if out is not None else '')+')'
        self.lines+=['local ok,result=pcall(function()return '+call+'end)',
                     'assert(ok=='+lua(ok)+','+lua(label+': acceptance')+'..": "..tostring(result))']
        if ok:
            self.check('result',np.asarray(result),label+': result')
            self.lines+=['eq(rawequal(result,a),'+lua(result is a)+','+lua(label+': input identity')+')']
            if out is not None:self.lines+=['eq(rawequal(result,out),true,'+lua(label+': output identity')+')']
            else:self.lines+=['eq(np.shares_memory(result,a),'+lua(np.shares_memory(result,a))+','+lua(label+': output sharing')+')']
        if out is not None:self.check('out',out,label+': output state')
        self.check('a',a,label+': input state')
        self.check('base',base,label+': backing state')
        self.lines+=['cases=cases+1','end']

def values(dt):
    kind=np.dtype(dt).kind
    if kind=='c':return np.array([[-2.5+1.25j,-1.25-2.5j,0j],[.125-.125j,1.25+2.5j,2.5+1.25j]],dt)
    if kind in 'Mm':return np.arange(6).reshape(2,3).astype(dt)
    if kind in 'iu':return np.array([[0,1,15],[25,125,127]],dt)
    return np.array([[-2.5,-1.25,-0.0],[.125,1.25,2.5]],dt)

def main():
    s=Round('round113');o=Round('round_out113')
    dtypes=['bool','int8','uint8','int16','int64','uint64','float16','float32','float64','longdouble','complex64','complex128','clongdouble','S5','U5','datetime64[ms]','timedelta64[h]']
    for dt in dtypes:
        base=values(dt)
        for view,_,_ in views(base):
            for decimals in [-4,-2,-1,0,1,2,5,23,309]:
                s.case(base,view,decimals,method=decimals%2==0,alias=decimals==1)
            for d in [-1,0,1]:o.case(base,view,d,mode='inplace')
        for d in [-2,0,1,5,23,309]:
            for out_dt in ['bool','int8','uint64','float16','float32','float64','complex64','complex128','S20','U20','datetime64[ms]','timedelta64[ms]']:
                o.case(base,'base',d,mode='out',out_dtype=out_dt)
            o.case(base,'F',d,mode='Fout')
            o.case(base,'base',d,mode='readonly')
            o.case(base,'base',d,mode='reverse')
            o.case(base,'base',d,mode='component')
            o.case(base,'base',d,mode='badsize')
            o.case(base,'base',d,mode='flatout')
        for shape in [(),(1,),(2,0,3)]:
            a=np.array(base.flat[0],dt) if shape==() else np.empty(shape,dt) if 0 in shape else np.array([base.flat[0]],dt)
            for name,_,_ in views(a):
                for d in [-1,0,1]:s.case(a,name,d)
        if np.dtype(dt).kind in 'iu':
            ii=np.iinfo(dt);a=np.array([ii.min,ii.max,ii.max-1,0,1],dt)
            for d in [-19,-10,-1,0,1,308,309]:s.case(a,'base',d)
        elif np.dtype(dt).kind in 'fc':
            a=np.array([0.,-0.,np.inf,-np.inf,np.nan,1e-6,-1e-6],dt)
            for d in [-309,-23,0,2,23,309]:s.case(a,'base',d)
    for suite in [s,o]:suite.write()

if __name__=='__main__':main()
