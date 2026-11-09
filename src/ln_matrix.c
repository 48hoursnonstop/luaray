#include "ln_matrix.h"
#include "ln_layout.h"
#include "ln_datetime.h"
#include "ln_creation.h"
#include "ln_write.h"
#include "ln_select.h"
#include "ln_string.h"
#include "ln_ufunc_loops.h"
#include <stdint.h>
#include <stdio.h>
#include <string.h>
/* NumPy 2.5.3 item_selection.c:PyArray_Diagonal and _twodim_base_impl.py.
 * See THIRD_PARTY_NUMPY_LICENSE.txt for the retained BSD notice. */
static ln_array *failure(ln_error *err,const char *message)
{
    if(err){snprintf(err->message,sizeof err->message,"%s",message);err->kind=LN_ERROR_VALUE;}
    return NULL;
}
ln_array *ln_matrix_diagonal(const ln_array *a,ln_intp offset,int axis1,int axis2,ln_error *err)
{
    if(!a||a->nd<2)return failure(err,"diagonal requires at least two dimensions");
    if(axis1<0||axis1>=a->nd||axis2<0||axis2>=a->nd||axis1==axis2)
        return failure(err,"diagonal axes must be distinct existing axes");
    ln_intp n1=a->dimensions[axis1],n2=a->dimensions[axis2];
    ln_intp length=0,start=0;
    int shifted_axis=offset<0?axis1:axis2;
    /* Avoid negating INTPTR_MIN, including empty diagonals. */
    if(offset>=0){if(offset<=n2){start=offset;n2-=offset;length=n1<n2?n1:n2;}}
    else if(offset!=INTPTR_MIN&&-offset<=n1){start=-offset;n1+=offset;length=n1<n2?n1:n2;}
    ln_intp s1=a->strides[axis1],s2=a->strides[axis2];
    if((s2>0&&s1>INTPTR_MAX-s2)||(s2<0&&s1<INTPTR_MIN-s2))
        return failure(err,"diagonal stride overflow");
    ln_intp shape[LN_MAXDIMS],strides[LN_MAXDIMS];int j=0;
    for(int d=0;d<a->nd;++d)if(d!=axis1&&d!=axis2){shape[j]=a->dimensions[d];strides[j++]=a->strides[d];}
    shape[j]=length;strides[j]=s1+s2;
    /* Empty views have no dereferenceable elements. Keep their data inside
     * the owner rather than forming an out-of-allocation pointer. */
    char *data=a->data;
    if(length>0){
        ln_intp stride=a->strides[shifted_axis];
        if(start&&((stride>0&&start>INTPTR_MAX/stride)||(stride<0&&stride<INTPTR_MIN/start)))
            return failure(err,"diagonal offset overflow");
        data+=start*stride;
    }
    ln_array *view=ln_array_view(a,a->nd-1,shape,strides,data,err);
    if(view)view->flags&=~LN_ARRAY_WRITEABLE;
    return view;
}
ln_array *ln_matrix_diag(const ln_array *a,ln_intp offset,int flatten,ln_error *err)
{
    if(!a||(!flatten&&a->nd!=1&&a->nd!=2))return failure(err,"diag input must be one- or two-dimensional");
    if(!flatten&&a->nd==2)return ln_matrix_diagonal(a,offset,0,1,err);
    ln_array *flat=ln_layout_ravel(a,'C',err);if(!flat)return NULL;
    ln_intp size=ln_array_size(flat);
    if(offset==INTPTR_MIN||size<0||size>INTPTR_MAX-(offset<0?-offset:offset)){
        ln_array_free(flat);return failure(err,"diagonal shape overflow");
    }
    ln_intp side=size+(offset<0?-offset:offset),shape[]={side,side};
    ln_array *out=ln_array_new(2,shape,a->descr,0,1,err);
    if(out&&size){
        ln_intp row=offset<0?-offset:0,col=offset>0?offset:0;
        for(ln_intp i=0;i<size;++i)
            memcpy(out->data+(row+i)*out->strides[0]+(col+i)*out->strides[1],
                   flat->data+i*flat->strides[0],a->descr->elsize);
    }
    ln_array_free(flat);return out;
}

/* The shared uniform numeric reduction has no timedelta inner loop. Reduce
 * converted ticks with its int64 loop and restore NaT propagation explicitly.
 * This retains reduction layout and overflow semantics without converting any
 * values through the host floating-point scalar boundary. */
static ln_array *trace_timedelta(const ln_array *diagonal,const ln_dtype *result_dtype,
        ln_array *out,ln_error *err)
{
    const ln_dtype *converted_dtype=ln_datetime_make_dtype(1,*ln_datetime_metadata(result_dtype),err);
    if(!converted_dtype)return NULL;
    ln_array *converted=ln_creation_convert(diagonal,converted_dtype,'K',-1,0,NULL,err);
    if(!converted)return NULL;
    ln_array *raw=ln_array_view(converted,converted->nd,converted->dimensions,
            converted->strides,converted->data,err);
    if(!raw){ln_array_free(converted);return NULL;}
    raw->descr=ln_dtype_by_name("int64");
    uint8_t axes[LN_MAXDIMS]={0};axes[raw->nd-1]=1;
    ln_array *result=ln_reduce_ex(raw,axes,0,raw->descr,NULL,LN_REDUCE_SUM,0,0,0,1,err);
    ln_array_free(raw);
    if(!result){ln_array_free(converted);return NULL;}
    ln_intp index[LN_MAXDIMS]={0},count=ln_array_size(result),length=converted->dimensions[converted->nd-1];
    for(ln_intp i=0;i<count;++i){
        char *input=converted->data,*destination=result->data;
        for(int d=0;d<result->nd;++d){input+=index[d]*converted->strides[d];destination+=index[d]*result->strides[d];}
        for(ln_intp j=0;j<length;++j){
            int64_t tick;memcpy(&tick,input+j*converted->strides[converted->nd-1],sizeof tick);
            if(tick==LN_DATETIME_NAT){memcpy(destination,&tick,sizeof tick);break;}
        }
        for(int d=result->nd-1;d>=0;--d){if(++index[d]<result->dimensions[d])break;index[d]=0;}
    }
    ln_array_free(converted);result->descr=result_dtype;
    if(!out)return result;
    int valid=out->nd==result->nd;
    for(int d=0;valid&&d<result->nd;++d)valid=out->dimensions[d]==result->dimensions[d];
    if(!valid){ln_array_free(result);return failure(err,"trace output has the wrong shape");}
    int status=ln_array_copyto(out,result,NULL,1,LN_UNSAFE_CASTING,err);
    ln_array_free(result);return status<0?NULL:out;
}

ln_array *ln_matrix_trace(const ln_array *a,ln_intp offset,int axis1,int axis2,
        const ln_dtype *dtype,ln_array *out,ln_error *err)
{
    ln_array *diagonal=ln_matrix_diagonal(a,offset,axis1,axis2,err);
    if(!diagonal)return NULL;
    /* methods.c:array_trace passes a dtype type number, dropping parametric
     * metadata. ufunc_object.c resolves (out, input, out), allowing mixed
     * timedelta/integer loops. Keep this legacy trace contract separate from
     * the uniform-dtype reduction helper. */
    const ln_dtype *resolved=dtype;
    char input_kind=a->descr->kind;
    if(input_kind=='S'||input_kind=='U'||input_kind=='M')goto unsupported;
    if(input_kind=='m'){
        if(out&&out->descr->kind!='i'&&out->descr->kind!='u'&&out->descr->kind!='b'&&
                out->descr->kind!='M'&&out->descr->kind!='m')goto unsupported;
        resolved=a->descr;
        if(out&&(out->descr->kind=='M'||out->descr->kind=='m')){
            const ln_dtype *common=ln_common_dtype_descr(a->descr,out->descr);
            if(!common)goto unsupported;
            resolved=ln_datetime_make_dtype(out->descr->kind=='m',*ln_datetime_metadata(common),err);
            if(!resolved)goto unsupported;
        }
    }else{
        if(dtype&&dtype->kind=='M'){
            if(!out||(out->descr->kind!='M'&&out->descr->kind!='m')||
                    (input_kind!='b'&&input_kind!='i'&&input_kind!='u'))goto unsupported;
            resolved=ln_dtype_by_name("int64");
        }else if(dtype&&dtype->kind=='m')resolved=out?NULL:a->descr;
        if(!resolved&&out&&(out->descr->kind=='M'||out->descr->kind=='m')){
            if(input_kind!='b'&&input_kind!='i'&&input_kind!='u')goto unsupported;
            resolved=ln_dtype_by_name("int64");
        }
    }
    if(input_kind=='m'){
        ln_array *result=trace_timedelta(diagonal,resolved,out,err);
        ln_array_free(diagonal);return result;
    }
    uint8_t axes[LN_MAXDIMS]={0};axes[diagonal->nd-1]=1;
    ln_array *result;
    if(out){
        int status=ln_reduce_into_ex(diagonal,axes,0,resolved,out,NULL,LN_REDUCE_SUM,0,0,0,1,err);
        result=status<0?NULL:out;
    }else result=ln_reduce_ex(diagonal,axes,0,resolved,NULL,LN_REDUCE_SUM,0,0,0,1,err);
    ln_array_free(diagonal);return result;
unsupported:
    ln_array_free(diagonal);return failure(err,"trace has no compatible reduction signature");
}

/* _twodim_base_impl.py: tri casts a boolean mask; tril/triu select between
 * input and a typed zero using KEEPORDER iteration. */
static ln_array *triangle_mask(ln_intp rows,ln_intp columns,ln_intp k,int strict,ln_error *err)
{
    rows=rows<0?0:rows;columns=columns<0?0:columns;
    ln_intp effective=0;
    if(columns>0){
        if(k==INTPTR_MIN||(strict&&k==INTPTR_MIN+1))
            return failure(err,"triangle index range exceeds the native integer range");
        effective=k-(strict?1:0);
        /* arange converts its first two values before its fixed-width fill
         * loop. Match those conversion errors, then emulate later wrapping
         * with unsigned arithmetic rather than signed overflow. */
        if(columns>1&&effective==INTPTR_MIN+1)
            return failure(err,"triangle index range exceeds the native integer range");
    }
    ln_intp shape[]={rows,columns};
    ln_array *mask=ln_array_new(2,shape,ln_dtype_by_num(LN_BOOL),0,0,err);
    if(!mask)return NULL;
    for(ln_intp row=0;row<rows;++row)for(ln_intp column=0;column<columns;++column){
        uintptr_t bits=(uintptr_t)column-(uintptr_t)effective;ln_intp shifted;
        memcpy(&shifted,&bits,sizeof shifted);
        mask->data[(size_t)row*(size_t)columns+(size_t)column]=(char)(row>=shifted);
    }
    return mask;
}
ln_array *ln_matrix_tri(ln_intp rows,ln_intp columns,ln_intp k,const ln_dtype *dtype,ln_error *err)
{
    ln_array *mask=triangle_mask(rows,columns,k,0,err);if(!mask)return NULL;
    if(!dtype)dtype=ln_dtype_by_num(LN_DOUBLE);
    if(dtype->type_num==LN_BOOL)return mask;
    if(ln_string_is_dtype(dtype)&&ln_string_nchars(dtype)==0){
        dtype=ln_string_make_dtype(dtype->type_num==LN_UNICODE,
                ln_legacy_string_width_for_dtype(mask->descr),dtype->byteorder,err);
        if(!dtype){ln_array_free(mask);return NULL;}
    }
    ln_array *result=ln_creation_convert(mask,dtype,'C',-1,0,NULL,err);
    ln_array_free(mask);return result;
}
ln_array *ln_matrix_trilu(const ln_array *a,ln_intp k,int upper,ln_error *err)
{
    if(!a||a->nd<1)return failure(err,"tril/triu require an array with at least one dimension");
    ln_intp rows=a->dimensions[a->nd>1?a->nd-2:0],columns=a->dimensions[a->nd-1],one=1;
    ln_array *mask=triangle_mask(rows,columns,k,upper!=0,err);if(!mask)return NULL;
    ln_array *zero=ln_array_new(1,&one,a->descr,0,1,err);
    if(!zero){ln_array_free(mask);return NULL;}
    const ln_dtype *dtype=ln_common_dtype_descr(a->descr,zero->descr);
    if(!dtype){ln_array_free(zero);ln_array_free(mask);return failure(err,"triangle input has no selection dtype");}
    ln_array *result=ln_array_where(mask,upper?zero:a,upper?a:zero,dtype,err);
    ln_array_free(zero);ln_array_free(mask);return result;
}

ln_array *ln_matrix_vander(const ln_array *x,ln_intp columns,int increasing,ln_error *err)
{
    if(!x||x->nd!=1)return failure(err,"vander input must be one-dimensional");
    if(columns<0)return failure(err,"vander column count must be nonnegative");
    const ln_dtype *dtype=ln_common_dtype_descr(x->descr,ln_dtype_by_name("int64"));
    if(!dtype)return failure(err,"vander input has no common dtype with native int");
    ln_intp shape[]={x->dimensions[0],columns};
    ln_array *out=ln_array_new(2,shape,dtype,0,0,err);if(!out||columns==0)return out;
    ln_intp strides[]={out->strides[0],increasing?out->strides[1]:-out->strides[1]};
    char *start=out->data+(increasing?0:(columns-1)*out->strides[1]);
    ln_array *first=ln_array_view(out,1,shape,strides,start,err),*tail=NULL,*column=NULL;
    if(!first)goto failed;
    int64_t value=1;
    ln_array one={.data=(char *)&value,.nd=0,.descr=ln_dtype_by_name("int64"),
        .flags=LN_ARRAY_C_CONTIGUOUS|LN_ARRAY_F_CONTIGUOUS|LN_ARRAY_ALIGNED};
    if(ln_array_copyto(first,&one,NULL,1,LN_UNSAFE_CASTING,err)<0)goto failed;
    if(columns>1){
        /* NumPy resolves multiply.accumulate even when the row count is zero. */
        if(!ln_get_multiply_loop(dtype->type_num)){failure(err,"vander has no multiply accumulation loop");goto failed;}
        ln_intp tail_shape[]={shape[0],columns-1};
        tail=ln_array_view(out,2,tail_shape,strides,start+strides[1],err);
        ln_intp column_shape[]={shape[0],1},column_strides[]={x->strides[0],0};
        column=ln_array_view(x,2,column_shape,column_strides,x->data,err);
        if(!tail||!column||ln_array_copyto(tail,column,NULL,1,LN_UNSAFE_CASTING,err)<0||
                ln_accumulate_into_ex(tail,1,NULL,tail,LN_REDUCE_PROD,err)<0)goto failed;
    }
    ln_array_free(first);ln_array_free(tail);ln_array_free(column);return out;
failed:
    ln_array_free(first);ln_array_free(tail);ln_array_free(column);ln_array_free(out);return NULL;
}
