#!/usr/bin/env python3
"""NumPy 2.5.3 references for masked writes and literal copyto promotion."""
import numpy as np
from generate_write98_differential import Suite,VIEWS,DTYPES,base_array,vals_array

putmask=Suite('putmask99','generate_memory99_differential.py')
copyto=Suite('copyto99','generate_memory99_differential.py')

for dtype in DTYPES:
    for name,view in VIEWS.items():
        shape=view(base_array(dtype))[0].shape
        for n in [1,2,7]:
            values=vals_array(dtype,n)
            for mask_dtype in ['bool','int16','float64','complex128','U2']:
                mask=(np.arange(np.prod(shape)).reshape(shape)%3).astype(mask_dtype)
                if mask_dtype=='U2':mask=np.where(mask=='0','','a')
                putmask.case(f'{dtype}/{name}/{n}/{mask_dtype}',base_array(dtype),view,'putmask',mask,values)

for dtype in ['uint8','int32','float32','bool','complex64','U4','timedelta64[h]']:
    for values in [[],np.array([],dtype=float),[2,3],[1.5,2.5],np.array([2,3]),
                   np.array([1.5,2.5]),300,1.5,True,2+3j,['2','3'],['','2']]:
        for mask in [np.arange(12)%3!=0,[1,0]*6,np.zeros(12,dtype=bool)]:
            putmask.case(f'conversion/{dtype}/{repr(values)}/{type(mask).__name__}/{repr(mask)}',
                         base_array(dtype),VIEWS['plain'],'putmask',mask,values)

for dtype in ['int8','uint8','int32','int64','float16','float32','float64','bool',
              'complex64','complex128','U4','timedelta64[h]','datetime64[D]']:
    for name in ['plain','transpose','reverse_columns']:
        view=VIEWS[name];shape=view(base_array(dtype))[0].shape
        width=shape[-1]
        sources=[2,2.5,True,2+3j,np.array(2.0),np.arange(width,dtype='int16'),
                 np.arange(width,dtype='float64')+.5,[2]*width]
        for values in sources:
            for rule in ['no','equiv','safe','same_kind','unsafe']:
                for mask in [True,False,(np.arange(np.prod(shape)).reshape(shape)%3!=0).tolist()]:
                    copyto.case(f'{dtype}/{name}/{repr(values)}/{rule}/{repr(mask)}',
                                base_array(dtype),view,'copyto',mask,values,mode=rule)

for dtype in ['int32','bool','float64']:
    for name,view in VIEWS.items():
        for op in ['copyto','putmask']:
            base=base_array(dtype);shape=view(base)[0].shape
            values=view(base)[0]
            if op=='copyto':
                copyto.case(f'alias-source/{dtype}/{name}',base,view,op,True,values,
                            values_expr='a',mode='same_kind')
            else:
                putmask.case(f'alias-values/{dtype}/{name}',base,view,op,np.arange(np.prod(shape))%3!=0,
                            values,values_expr='a')
            if dtype=='bool':
                base=base_array(dtype);mask=view(base)[0]
                suite=copyto if op=='copyto' else putmask
                suite.case(f'alias-mask/{op}/{name}',base,view,op,mask,False,
                           selector_expr='a',mode='unsafe' if op=='copyto' else 'raise')

for dtype in ['int32','bool','float64']:
    for values in [[],np.array([],dtype=np.int32),True]:
        base=np.zeros(0,dtype=dtype)
        putmask.case(f'empty/{dtype}/{repr(values)}',base,VIEWS['plain'],'putmask',[],values)
        copyto.case(f'empty/{dtype}/{repr(values)}',base,VIEWS['plain'],'copyto',[],values,mode='unsafe')

# Leading singleton source dimensions are stripped for assignment, whereas
# extra mask dimensions are rejected. Numeric ndarray masks need safe casting.
for name,view in VIEWS.items():
    base=base_array('int32');shape=view(base)[0].shape
    copyto.case(f'leading-singleton/{name}',base,view,'copyto',True,
                np.arange(np.prod(shape),dtype=np.int32).reshape((1,)+shape),mode='same_kind')
    copyto.case(f'extra-mask-dimension/{name}',base_array('int32'),view,'copyto',
                np.ones((1,)+shape,dtype=bool),2,mode='same_kind')
    for mask in [np.ones(shape,dtype=np.int32),np.ones(shape,dtype=float),np.full(shape,'a'),
                 np.ones(shape,dtype=np.int32).tolist()]:
        copyto.case(f'mask-coercion/{name}/{type(mask).__name__}/{repr(mask)}',
                    base_array('int32'),view,'copyto',mask,2,mode='same_kind')

# Live mask traversal, run scanning, negative/F-order layout and overlapping
# one-dimensional source direction. No diagnostic alteration of the oracle.
for name in ['plain','reverse_columns','transpose']:
    view=VIEWS[name]
    for scalar in [True,False]:
        base=np.array([[1,1,0,1],[1,0,1,1],[0,1,1,0]],dtype=bool)
        a=view(base)[0];mask=np.flip(a,axis=-1)
        copyto.case(f'live-reversed-mask/{name}/{scalar}',base,view,'copyto',mask,scalar,
                    selector_expr='np.flip(a,a.ndim)',mode='same_kind')
    base=np.array([[1,1,0,1],[1,0,1,1],[0,1,1,0]],dtype=bool)
    a=view(base)[0];mask=np.flip(a,axis=-1);values=np.flip(a,axis=0)
    copyto.case(f'live-mask-and-source/{name}',base,view,'copyto',mask,values,
                selector_expr='np.flip(a,a.ndim)',values_expr='np.flip(a,1)',mode='same_kind')

for offset in ['forward','backward']:
    for reverse_mask in [False,True]:
        base=np.array([1,1,0,1,1,0,1,1,0],dtype=bool)
        if offset=='forward':
            view=lambda a:(a[1:],'base:get(np.s(2,nil))')
            a=base[1:];values=base[:-1];value_expr='base:get(np.s(1,9))'
        else:
            view=lambda a:(a[:-1],'base:get(np.s(1,9))')
            a=base[:-1];values=base[1:];value_expr='base:get(np.s(2,nil))'
        mask=np.flip(a) if reverse_mask else a
        copyto.case(f'overlap-direction/{offset}/{reverse_mask}',base,view,'copyto',mask,values,
                    selector_expr='np.flip(a)' if reverse_mask else 'a',values_expr=value_expr,mode='same_kind')

for shape in [(5,),()]:
    for mask in [True,np.ones((2,2),dtype=bool)]:
        base=np.zeros(shape,dtype=np.int32)
        view=lambda a:(np.broadcast_to(a,a.shape),'np.broadcast_to(base,base.shape)')
        a=view(base)[0]
        copyto.case(f'readonly-self/{shape}/{repr(mask)}',base,view,'copyto',mask,a,values_expr='a',mode='no')
        copyto.case(f'readonly-other/{shape}/{repr(mask)}',base,view,'copyto',mask,2,mode='same_kind')

for dtype in ['int32','float64','complex128','timedelta64[h]']:
    for name in ['plain','reverse_columns','transpose']:
        for values in [np.array(['1','bad','3','4'] if name!='transpose' else ['1','bad','3']),
                       'bad','2',np.array('bad')]:
            for mask in [True,False]:
                copyto.case(f'conversion-error-state/{dtype}/{name}/{repr(values)}/{mask}',
                            base_array(dtype),VIEWS[name],'copyto',mask,values,mode='unsafe')

def shared_view(base):
    return np.broadcast_arrays(base,np.zeros((3,4)))[0], 'np.broadcast_arrays(base,np.zeros({3,4}))[1]'
for dtype in ['int32','bool']:
    for values in [True,np.arange(12,dtype=np.int32).reshape(3,4)]:
        base=np.arange(4).reshape(1,4).astype(dtype);a=shared_view(base)[0]
        mask=np.flip(a,axis=1) if dtype=='bool' else np.arange(12).reshape(3,4)%3==0
        copyto.case(f'shared-zero-stride/{dtype}/{repr(values)}',base,shared_view,'copyto',mask,values,
                    selector_expr='np.flip(a,2)' if dtype=='bool' else None,mode='unsafe')

for source_dtype in ['U1','U3','U4','U8','S3']:
    for position in [1,127,128,129,260]:
        for mask in [True,(np.arange(270)%3!=0).tolist()]:
            values=np.full(270,'8',dtype=source_dtype);values[position]='bad'
            copyto.case(f'cast-buffer/{source_dtype}/{position}/{type(mask).__name__}',
                        np.arange(270,dtype=np.int32),VIEWS['plain'],'copyto',mask,values,mode='unsafe')

for dtype in ['int32','float64','S3','U3']:
    base=np.arange(5).astype(dtype)
    values=base.reshape(1,5)
    copyto.case(f'identity-reshape-source/{dtype}',base,VIEWS['plain'],'copyto',True,values,
                values_expr='base:reshape({1,5})',mode='no')

putmask.finish();copyto.finish()
