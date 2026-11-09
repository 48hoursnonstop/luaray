#!/usr/bin/env python3
"""Original NumPy 2.5.3 component views, identity, interleaving and writes."""
import numpy as np
from generate_layout110_differential import Suite,views,array,base_array
from generate_binary109_differential import lua,dtype
assert np.__version__=='2.5.3'

class Components(Suite):
    def case(self,original,view,imaginary,property):
        self.count+=1
        if (self.count-1)%60==0:
            if self.count>1:self.lines+=['end','chunk()','end']
            self.lines+=['do','local function chunk()']
        base=np.array(original,copy=True)
        name,a,expr=next(v for v in views(base) if v[0]==view)
        op='imag' if imaginary else 'real';result=getattr(a,op)
        real,imag=a.real,a.imag
        label=f'{op}/{dtype(base.dtype)}{base.shape}/{view}/property{property}'
        self.lines+=['do','local base='+array(base),'local a='+expr,
                     'local result='+('a.'+op if property else 'np.'+op+'(a)'),
                     'eq(rawequal(result,a),'+lua(result is a)+','+lua(label+': identity')+')',
                     'eq(np.shares_memory(result,a),'+lua(np.shares_memory(result,a))+','+lua(label+': sharing')+')',
                     'eq(np.shares_memory(a.real,a.imag),'+lua(np.shares_memory(real,imag))+','+lua(label+': interleaved exact query')+')',
                     'eq(np.may_share_memory(a.real,a.imag),'+lua(np.may_share_memory(real,imag))+','+lua(label+': interleaved bounds query')+')']
        self.check('result',result,label+': initial')
        fill=np.array('Z' if result.dtype.kind in 'SU' else 7,dtype=result.dtype)
        try:np.copyto(result,fill,casting='unsafe');writable=True
        except (ValueError,TypeError):writable=False
        self.lines+=['local ok=pcall(function()np.copyto(result,'+array(fill)+',"unsafe")end)',
                     'eq(ok,'+lua(writable)+','+lua(label+': writable')+')']
        self.check('result',result,label+': after write')
        self.check('a',a,label+': input after write')
        self.check('base',base,label+': backing after write')
        self.lines+=['cases=cases+1','end']

def main():
    s=Components('components111')
    for dt in ['bool','int8','uint64','float16','float32','float64','longdouble','complex64','complex128','clongdouble','S4','U4','>U4','datetime64[ms]','timedelta64[h]']:
        for shape in [(2,3,4),(2,1,3),(2,0,3),(),(1,),(6,)]:
            base=np.array(base_array(shape,dt),copy=True)
            for name,_,_ in views(base):
                for imag in [False,True]:
                    for property in [False,True]:s.case(base,name,imag,property)
    s.write()
if __name__=='__main__':main()
