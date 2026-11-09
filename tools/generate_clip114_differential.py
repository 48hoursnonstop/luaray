#!/usr/bin/env python3
"""Original NumPy2.5.3 fused clip, strong/weak bounds and observable writes."""
import itertools
import warnings
import numpy as np
from generate_round113_differential import Round
from generate_layout110_differential import views
from generate_time_scale113_differential import array
from generate_binary109_differential import lua,dtype
assert np.__version__=='2.5.3'

class Clip(Round):
    def case(self,original,view,lower,upper,*,raw=(True,True),mode='new',out_dtype='float64',mask=False,method=False):
        self.count+=1
        if (self.count-1)%60==0:
            if self.count>1:self.lines+=['end','chunk()','end']
            self.lines+=['do','local function chunk()']
        base=np.array(original,copy=True)
        _,a,expr=next(v for v in views(base) if v[0]==view)
        bounds=[x if weak or x is None else np.array(x,copy=True) for x,weak in zip([lower,upper],raw)]
        self.lines+=['do','local base='+array(base),'local a='+expr]
        for name,x,weak in zip(['lo','hi'],bounds,raw):
            self.lines+=['local '+name+'='+("nil" if x is None else ("(-9223372036854775807-1)" if isinstance(x,int) and x==-2**63 else lua(x)) if weak else array(x))]
        try:shape=np.broadcast_shapes(a.shape,*(np.shape(x) for x in bounds if x is not None))
        except ValueError:shape=a.shape
        out=None;opts=[];kwargs={}
        if mode=='inplace':out=a;out_expr='a'
        elif mode=='reverse':out=np.flip(base,0);out_expr='np.flip(base,1)'
        elif mode=='lower':out=bounds[0];out_expr='lo'
        elif mode=='upper':out=bounds[1];out_expr='hi'
        elif mode=='readonly':out=np.broadcast_to(np.array(7,dtype=out_dtype),shape);out_expr='np.broadcast_to(np.array(7,'+lua(dtype(np.dtype(out_dtype)))+'),'+lua(shape)+')'
        elif mode=='badshape':out=np.full((a.size+1,),7,dtype=out_dtype);out_expr='np.full({a.size+1},7,'+lua(dtype(out.dtype))+')'
        elif mode in ['out','Fout']:
            out=np.full(shape,7,dtype=out_dtype,order='F' if mode=='Fout' else 'C')
            out_expr='np.full('+lua(shape)+',7,{dtype='+lua(dtype(out.dtype))+',order='+lua('F' if mode=='Fout' else 'C')+'})'
        if out is not None:self.lines+=['local out='+out_expr];opts+=['out=out'];kwargs['out']=out
        if mask:
            assert out is not None
            where=np.arange(np.prod(shape,dtype=int)).reshape(shape)%3!=1
            self.lines+=['local where='+array(where)];opts+=['where=where'];kwargs['where']=where
        bound_labels=[str(x) if weak or x is None else f'{dtype(x.dtype)}{x.shape}' for x,weak in zip(bounds,raw)]
        label=f'clip/{dtype(base.dtype)}{base.shape}/{view}/{bound_labels}/weak{raw}/{mode}/{out_dtype}/mask{mask}'
        label=label.replace('\n',' ')
        try:
            with warnings.catch_warnings(),np.errstate(all='ignore'):
                warnings.simplefilter('ignore');result=a.clip(*bounds,**kwargs) if method else np.clip(a,*bounds,**kwargs)
            ok=True
        except (TypeError,ValueError,OverflowError):ok=False
        call=('a:clip(' if method else 'np.clip(a,')+'lo,hi'+(',{'+','.join(opts)+'}' if opts else '')+')'
        self.lines+=['local ok,result=pcall(function()return '+call+'end)',
                     'assert(ok=='+lua(ok)+','+lua(label+': acceptance')+'..": "..tostring(result))']
        if ok:
            self.check('result',np.asarray(result),label+': result')
            if out is not None:self.lines+=['eq(rawequal(result,out),true,'+lua(label+': output identity')+')']
            else:self.lines+=['eq(np.shares_memory(result,a),false,'+lua(label+': no sharing')+')']
        if out is not None:self.check('out',out,label+': output')
        for name,x,weak in zip(['lo','hi'],bounds,raw):
            if x is not None and not weak:self.check(name,x,label+': bound '+name)
        self.check('a',a,label+': input');self.check('base',base,label+': backing')
        self.lines+=['cases=cases+1','end']

def values(dt):
    kind=np.dtype(dt).kind
    a=np.array([[0,1,2],[3,4,5]])
    if kind in 'fc':a=np.array([[-np.inf,-1.,-0.],[0.,1.,np.nan]])
    if kind=='c':a=a+1j*np.array([[0,2,-1],[-1,2,0]])
    if kind=='b':a=a%2
    return a.astype(dt)

def main():
    s,o,buff=Clip('clip114'),Clip('clip_out114'),Clip('clip_buffer114')
    dtypes=['bool','int8','uint8','int16','uint16','int32','uint32','int64','uint64','float16','float32','float64','longdouble','complex64','complex128','clongdouble','timedelta64[D]','datetime64[D]','S5','U5']
    pairs=[(-1,2),(2,-1),(None,1),(-1,None),(None,None),(False,True),(-999,2.),(-999,1+2j),(np.nan,np.inf),(-np.inf,np.nan),(0.,-0.)]
    for dt in dtypes:
        base=values(dt)
        for view,_,_ in views(base):
            for lo,hi in pairs:s.case(base,view,lo,hi,method=view=='F')
        for lo,hi in pairs[:7]:
            for out_dt in ['bool','int8','uint64','float16','float32','float64','complex64','U20','timedelta64[h]','datetime64[h]']:
                o.case(base,'base',lo,hi,mode='out',out_dtype=out_dt,mask=True)
            o.case(base,'base',lo,hi,mode='inplace')
            o.case(base,'F',lo,hi,mode='Fout')
            o.case(base,'base',lo,hi,mode='reverse')
            o.case(base,'base',lo,hi,mode='readonly')
            o.case(base,'base',lo,hi,mode='badshape')
        for shape in [(),(1,),(2,0,3),(2,1,3)]:
            a=np.zeros(shape,dt)
            for lo,hi in pairs[:6]:s.case(a,'base',lo,hi)
        if np.dtype(dt).kind in 'iu':
            ii=np.iinfo(dt);a=np.array([ii.min,ii.max,0,1],dt)
            for lo in [-999,-1,0,ii.min,ii.max]:
                for hi in [-1,0,256,ii.max]:
                    if not -2**63<=int(lo)<2**63 or not -2**63<=int(hi)<2**63:continue
                    s.case(a,'base',int(lo),int(hi))
    # Dtype resolution sees every strong descriptor before weak value packing.
    for adt,bdt,cdt in itertools.product(['bool','int8','uint8','int64','uint64','float16','float32','complex64'],repeat=3):
        s.case(values(adt),'base',np.array(0,bdt),np.array(1,cdt),raw=(False,False))
    for dt in dtypes[:18]:
        a=values(dt)
        for bounddt in ['int8','uint8','float16','float32','complex64','timedelta64[h]','datetime64[h]']:
            lo=np.array([[0],[1]],bounddt);hi=np.array([1,2,3],bounddt)
            s.case(a,'base',lo,hi,raw=(False,False))
            s.case(a,'base',lo,2.,raw=(False,True))
            s.case(a,'base',-999,hi,raw=(True,False))
        for raw in [(False,False),(True,False),(False,True)]:
            for lo,hi in [(0.,-0.),(-0.,0.),(np.nan,1.),(0.,np.nan)]:
                for view in ['base','F','reverse_last']:
                    s.case(np.array([[-0.,0.,np.nan],[1.,-1.,np.inf]],dt) if np.dtype(dt).kind in 'fc' else a,view,lo,hi,raw=raw)
    for dt in ['float16','float32','float64','complex64','int8','timedelta64[h]']:
        a=values(dt)
        for mode in ['lower','upper']:
            o.case(a,'base',np.zeros(a.shape,dt),np.ones(a.shape,dt),raw=(False,False),mode=mode,mask=True)
    # Actual time descriptors, NaT, mixed units and nonlinear rejection.
    for dt in ['datetime64[D]','timedelta64[D]','timedelta64[Y]']:
        a=np.array([-2**63,-1,0,1,4,9],'int64').reshape(2,3).astype(dt)
        for bd in ['datetime64[h]','timedelta64[h]','timedelta64[M]','int8','uint64']:
            for view in ['base','F','reverse_first']:
                s.case(a,view,np.array(-1).astype(bd),np.array(24).astype(bd),raw=(False,False))
    for width in [3,127,128,129,4096,4097,5000,8191,8192,8193]:
        for adt in ['float16','float32']:
            a=np.zeros((2,width),adt);a[:,::2]=-0.
            for view in ['base','F','reverse_last']:
                buff.case(a,view,np.array([[0.],[1.]],'float32'),2.,raw=(False,True))
            buff.case(a,'base',np.array([[0.],[1.]],'float32'),np.array([[2.],[3.]],'float32'),raw=(False,False),mode='inplace',mask=True)
    s.write();o.write();buff.write()
if __name__=='__main__':main()
