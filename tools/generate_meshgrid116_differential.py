#!/usr/bin/env python3
"""Original NumPy2.5.3 meshgrid geometry, strides, ownership and writes."""
import warnings
import numpy as np
from generate_layout110_differential import Suite,views
from generate_time_scale113_differential import array
from generate_binary109_differential import lua,dtype
assert np.__version__=='2.5.3'
class Grid(Suite):
    def __init__(self,name):
        super().__init__(name);self.lines[0]=self.lines[0].replace('generate_layout110_differential.py','generate_meshgrid116_differential.py')
    def case(self,originals,layout,indexing,copy,sparse,*,same=False,varying=False):
        self.count+=1
        if (self.count-1)%50==0:
            if self.count>1:self.lines+=['end','chunk()','end']
            self.lines+=['do','local function chunk()']
        bases=[np.array(a,copy=True) for a in originals]
        if same and bases:bases=[bases[0]]*len(bases)
        self.lines+=['do','local bases={}']
        for i,base in enumerate(bases):self.lines+=['bases['+str(i+1)+']='+(('bases[1]' if same and i else array(base)))]
        values=[];self.lines+=['local inputs={}']
        for i,base in enumerate(bases):
            _,value,expr=next(v for v in views(base) if v[0]==layout)
            values.append(value);self.lines+=['local base=bases['+str(i+1)+']','inputs['+str(i+1)+']='+expr]
        label=f'meshgrid/{[(dtype(x.dtype),x.shape) for x in values]}/{layout}/{indexing}/copy{copy}/sparse{sparse}/same{same}/varying{varying}'
        with warnings.catch_warnings():
            warnings.simplefilter('ignore');result=np.meshgrid(*values,copy=copy,sparse=sparse,indexing=indexing)
        self.lines+=['local result=np.meshgrid(inputs,{copy='+lua(copy)+',sparse='+lua(sparse)+',indexing='+lua(indexing)+'})',
                     'eq(#result,'+str(len(result))+','+lua(label+': result count')+')']
        for i,a in enumerate(result):
            self.check('result['+str(i+1)+']',a,label+': initial '+str(i))
            for j,b in enumerate(values):self.lines+=['eq(np.shares_memory(result['+str(i+1)+'],inputs['+str(j+1)+']),'+lua(np.shares_memory(a,b))+','+lua(label+': sharing '+str(i)+','+str(j))+')']
        for i,a in enumerate(result):
            if a.dtype.kind in 'SU':fill=np.full(a.shape,'Z',a.dtype)
            else:fill=(np.arange(a.size).reshape(a.shape)%81).astype(a.dtype) if varying else np.full(a.shape,i+7,a.dtype)
            try:
                with warnings.catch_warnings():warnings.simplefilter('ignore');np.copyto(a,fill)
                writable=True
            except (TypeError,ValueError):writable=False
            self.lines+=['local writable=pcall(function()np.copyto(result['+str(i+1)+'],'+array(fill)+')end)',
                         'eq(writable,'+lua(writable)+','+lua(label+': writable '+str(i))+')']
            for j,value in enumerate(result):self.check('result['+str(j+1)+']',value,label+': after write '+str(i)+' output '+str(j))
            for j,value in enumerate(values):self.check('inputs['+str(j+1)+']',value,label+': after write '+str(i)+' input '+str(j))
        self.lines+=['cases=cases+1','end']
def values(shape,dt):
    a=np.arange(int(np.prod(shape))).reshape(shape)
    if np.dtype(dt).kind=='f':a=a+.25
    if np.dtype(dt).kind=='c':a=a+1j*(a+1)
    return a.astype(dt)
def main():
    s=Grid('meshgrid116')
    dtypes=['bool','int8','uint64','float16','float32','float64','longdouble','complex64','complex128','clongdouble','S3','U3','>U3','datetime64[ms]','timedelta64[h]']
    for dt in dtypes:
        cases=[[],[values((),dt)],[values((0,),dt)],[values((1,),dt)],[values((3,),dt)],
               [values((2,),dt),values((3,),dt)],
               [values((1,),dt),values((3,),dt)],
               [values((0,),dt),values((2,),dt)],
               [values((2,2),dt),values((3,1),dt)],
               [values((2,),dt),values((3,),dt),values((1,),dt)],
               [values((2,),dt),values((2,),dt),values((2,),dt),values((1,),dt)]]
        for original in cases:
            for index in ['xy','ij']:
                for copy in [False,True]:
                    for sparse in [False,True]:s.case(original,'base',index,copy,sparse)
        for layout in ['F','transpose','reverse_first','reverse_last','step_first','step_last','broadcast','constant','newaxis']:
            for copy in [False,True]:
                for sparse in [False,True]:s.case([values((2,3),dt),values((3,2),dt)],layout,'xy',copy,sparse)
        for sparse in [False,True]:s.case([values((3,),dt)]*2,'base','xy',False,sparse,same=True,varying=True)
    # Each grid retains its own input dtype; there is no common-dtype cast.
    for adt,bdt in [('float32','int8'),('complex64','U3'),('timedelta64[h]','float64')]:
        for copy in [False,True]:
            for sparse in [False,True]:s.case([values((2,),adt),values((3,),bdt)],'base','ij',copy,sparse)
    s.write()
if __name__=='__main__':main()
