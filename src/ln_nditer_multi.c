#include "ln_nditer_multi.h"
#include "ln_order.h"
#include "ln_datetime.h"
#include "ln_dtype_transfer.h"

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LN_NDITER_MULTI_BUFSIZE 8192

#define LN_NDITER_MULTI_ORDER_MAXOPS (LN_NDITER_MULTI_MAXARGS + 1)

typedef struct ln_multi_order_axis {
    ln_intp shape;
    ln_intp strides[LN_NDITER_MULTI_ORDER_MAXOPS];
    int original_axis;
} ln_multi_order_axis;

static int
build_keeporder_axes(int nin,int nout,const ln_array *const *inputs,
        ln_array *const *outputs,const ln_array *where,int nd,const ln_intp *shape,
        ln_multi_order_axis *axes,ln_error *err)
{
    const ln_array *ops[LN_NDITER_MULTI_ORDER_MAXOPS];int nop=0;
    for(int i=0;i<nin;++i)ops[nop++]=inputs[i];
    for(int j=0;j<nout;++j)if(outputs[j])ops[nop++]=outputs[j];
    if(where)ops[nop++]=where;
    ln_intp bs[LN_NDITER_MULTI_ORDER_MAXOPS][LN_MAXDIMS];memset(bs,0,sizeof(bs));
    for(int k=0;k<nop;++k){
        char nm[32];snprintf(nm,sizeof(nm),"operand %d",k);
        if(ln_broadcast_strides(nd,shape,ops[k]->nd,ops[k]->dimensions,ops[k]->strides,nm,bs[k],err)<0)return -1;
    }
    const ln_intp *rows[LN_NDITER_MULTI_ORDER_MAXOPS];
    for(int k=0;k<nop;k++)rows[k]=bs[k];
    int order[LN_MAXDIMS];
    if(ln_keeporder_axes(nd,nop,rows,order,err)<0)return -1;
    for(int ia=0;ia<nd;++ia){
        int d=order[ia];axes[ia].shape=shape[d];axes[ia].original_axis=d;
        for(int k=0;k<nop;++k)axes[ia].strides[k]=bs[k][d];
    }
    return 0;
}

static void
apply_keeporder_strides(ln_array *a,const ln_multi_order_axis *axes,int nd)
{
    if(!a||nd<=0||ln_array_size(a)<=0)return;
    ln_intp stride=(ln_intp)a->descr->elsize;
    for(int ia=0;ia<nd;++ia){int d=axes[ia].original_axis;a->strides[d]=stride;stride*=axes[ia].shape;}
    ln_update_contiguous_flags(a);
}

static void
iter_error(ln_error *err, const char *msg)
{
    if (err){snprintf(err->message,sizeof(err->message),"%s",msg?msg:"iterator error");err->kind=LN_ERROR_VALUE;}
}

static int
can_cast_same_kind(const ln_dtype *from,const ln_dtype *to)
{return ln_dtype_can_cast(from,to,LN_SAME_KIND_CASTING);}

static int
same_shape(const ln_array *a,int nd,const ln_intp *shape)
{
    if(!a||a->nd!=nd)return 0;
    for(int i=0;i<nd;++i)if(a->dimensions[i]!=shape[i])return 0;
    return 1;
}

static int
copy_same_shape(const ln_array *src,ln_array *dst,ln_error *err)
{
    if(!same_shape(src,dst->nd,dst->dimensions)){
        iter_error(err,"writeback shape mismatch");return -1;
    }
    ln_intp total=ln_array_size(dst);
    if(total<=0)return 0;
    if(dst->nd==0)return ln_cast_strided_numeric(src->data,0,src->descr,
            dst->data,0,dst->descr,1,err);
    ln_intp coord[LN_MAXDIMS]={0};
    for(ln_intp i=0;i<total;++i){
        const char *sp=src->data;char *dp=dst->data;
        for(int d=0;d<dst->nd;++d){sp+=coord[d]*src->strides[d];dp+=coord[d]*dst->strides[d];}
        if(ln_cast_strided_numeric(sp,0,src->descr,dp,0,dst->descr,1,err)<0)return -1;
        for(int d=dst->nd-1;d>=0;--d){if(++coord[d]<dst->dimensions[d])break;coord[d]=0;}
    }
    return 0;
}

static int
build_shape(int nin,int nout,const ln_array *const *inputs,
            ln_array *const *outputs,const ln_array *where,
            int *nd,ln_intp *shape,ln_error *err)
{
    const ln_array *arrs[LN_NDITER_MULTI_MAXARGS+1];
    int n=0;
    for(int i=0;i<nin;++i)arrs[n++]=inputs[i];
    for(int i=0;i<nout;++i)if(outputs[i])arrs[n++]=outputs[i];
    if(where)arrs[n++]=where;
    if(ln_broadcast_shape(n,arrs,nd,shape,err)<0)return -1;
    for(int i=0;i<nout;++i){
        if(outputs[i]&&!same_shape(outputs[i],*nd,shape)){
            iter_error(err,"non-broadcastable output operand does not match the broadcast shape");return -1;
        }
    }
    return 0;
}

/* Non-reduction portion of NumPy2.5.3 nditer_constr.c buffering setup.
 * This predicts which operands acquire dense strides when NpyIter amortizes
 * calls by buffering across axes. Physical work may still use smaller rows;
 * keeping the predicted scalar/dense stride distinction is observable for
 * uniform clip. Reduction operands and foreign iterator protocols are outside
 * this elementwise executor's scope. */
static void uniform_buffer_plan(int nin,int nout,const ln_array *const *inputs,
        ln_array *const *outputs,const ln_array *where,const ln_dtype_descr *const *dtypes,
        const ln_multi_order_axis *order,int nd,const ln_intp *shape,
        ln_intp strides[][LN_MAXDIMS],const ln_intp *mstrides,int *dense)
{
    int nop=nin+nout+(where!=NULL),axes[LN_MAXDIMS],na=0;
    for(int j=0;j<nd;++j)if(shape[order[j].original_axis]>1)axes[na++]=order[j].original_axis;
    if(!na)return;
    ln_intp bs[LN_NDITER_MULTI_ORDER_MAXOPS][LN_MAXDIMS];memset(bs,0,sizeof bs);
    for(int k=0;k<nin+nout;++k)memcpy(bs[k],strides[k],sizeof bs[k]);
    if(where)memcpy(bs[nin+nout],mstrides,sizeof bs[0]);
    int cast[LN_NDITER_MULTI_ORDER_MAXOPS]={0},single[LN_NDITER_MULTI_ORDER_MAXOPS];
    int cost=1;
    for(int k=0;k<nop;++k){
        single[k]=1;
        if(k<nin)cast[k]=inputs[k]->descr!=dtypes[k]||!(inputs[k]->flags&LN_ARRAY_ALIGNED);
        else if(k<nin+nout)cast[k]=outputs[k-nin]->descr!=dtypes[k];
        cost+=cast[k];
    }
    ln_intp size=shape[axes[0]],best_size=size;
    int best_cost=cost,best_dim=0;
    for(int j=1;j<na;++j){
        if(size>=LN_NDITER_MULTI_BUFSIZE&&cost>1)break;
        int previous=axes[j-1],current=axes[j];
        for(int k=0;k<nop;++k)if(single[k]==j){
            /* size*stride is bounded by valid ndarray metadata in ordinary
             * contiguous layouts; checked multiply also handles exotic strides. */
            ln_intp expected;
            int overflow=__builtin_mul_overflow(bs[k][previous],shape[previous],&expected);
            if(!overflow&&expected==bs[k][current])single[k]++;
            else if(!cast[k])cost++;
        }
        size*=shape[current]; /* bounded by already validated total size */
        double effective=(size>LN_NDITER_MULTI_BUFSIZE&&cost>1)?LN_NDITER_MULTI_BUFSIZE:(double)size;
        if(cost*(double)best_size<=best_cost*effective){best_cost=cost;best_size=size;best_dim=j;}
    }
    for(int k=0;k<nin+nout;++k)dense[k]=single[k]<=best_dim;
}

/* Legacy masked kernels finish later true runs even if a previous run raised.
 * Keep a separate write mask so failed run suffixes never copy uninitialized
 * native buffer cells into caller-owned output. */
static int masked_validated_chunk(int nop,char **args,const ln_intp *steps,ln_intp count,
        const uint8_t *mask,ln_intp mask_step,uint8_t *written,int *failed_run,
        ln_strided_loop loop,void *loop_data,ln_nditer_validate_fn validate,void *validate_data,
        int *partial,int *deferred,ln_error *err)
{
    for(ln_intp i=0;i<count;++i)written[i]=mask[i*mask_step]!=0;
    ln_intp at=0;
    while(at<count){
        if(!written[at]){*failed_run=0;++at;continue;}
        ln_intp end=at+1;while(end<count&&written[end])++end;
        if(*failed_run){for(ln_intp i=at;i<end;++i)written[i]=0;at=end;continue;}
        char *subargs[LN_NDITER_MULTI_MAXARGS];for(int k=0;k<nop;++k)subargs[k]=args[k]+at*steps[k];
        ln_intp dims[]={end-at};
        int status=validate(subargs,dims,steps,NULL,0,validate_data,err);
        if(status==-1)return -1;
        if(status!=0)*partial=1;
        if(status< -1){
            ln_intp prefix=-(ln_intp)status-2;
            if(prefix>dims[0]){iter_error(err,"invalid partial validation prefix");return -1;}
            dims[0]=prefix;*deferred=1;*failed_run=1;
            for(ln_intp i=at+prefix;i<end;++i)written[i]=0;
        }
        loop(subargs,dims,steps,loop_data);at=end;
    }
    return 0;
}

static int
execute(int nin,int nout,
        const ln_array *const *inputs,ln_array **outputs,const ln_array *where,
        const ln_dtype_descr *const *loop_dtypes,ln_strided_loop loop,void *loop_data,
        ln_nditer_validate_fn validate,void *validate_data,int uniform,ln_error *err)
{
    if(nin<1||nout<1||nin+nout>LN_NDITER_MULTI_MAXARGS||!inputs||!outputs||!loop_dtypes||!loop){
        iter_error(err,"invalid generalized iterator call");return -1;
    }
    for(int i=0;i<nin;++i)if(!inputs[i]){iter_error(err,"invalid iterator input");return -1;}
    if(where&&where->descr->type_num!=LN_BOOL){iter_error(err,"where mask must have bool dtype");return -1;}

    int nd=0;ln_intp shape[LN_MAXDIMS]={0};
    if(build_shape(nin,nout,inputs,outputs,where,&nd,shape,err)<0)return -1;

    int allocated[LN_NDITER_MULTI_MAXARGS]={0};
    ln_multi_order_axis order_axes[LN_MAXDIMS];memset(order_axes,0,sizeof(order_axes));
    if(build_keeporder_axes(nin,nout,inputs,outputs,where,nd,shape,order_axes,err)<0)return -1;
    for(int j=0;j<nout;++j){
        const ln_dtype *loopdt=loop_dtypes[nin+j];
        if(!outputs[j]){
            outputs[j]=ln_array_new(nd,nd?shape:NULL,loopdt,0,0,err);
            if(!outputs[j])goto fail;
            apply_keeporder_strides(outputs[j],order_axes,nd);
            allocated[j]=1;
        }else{
            if(!(outputs[j]->flags&LN_ARRAY_WRITEABLE)){iter_error(err,"output array is not writeable");goto fail;}
            if(!can_cast_same_kind(loopdt,outputs[j]->descr)){
                char msg[256];snprintf(msg,sizeof(msg),
                    "Cannot cast ufunc output from dtype('%s') to dtype('%s') with casting rule 'same_kind'",
                    loopdt->name,outputs[j]->descr->name);
                iter_error(err,msg);if(err)err->kind=LN_ERROR_TYPE;goto fail;
            }
        }
    }

    /* Existing write operands use temporaries.  This is the generalized
     * COPY_IF_OVERLAP/writeback path and also preserves masked-out values. */
    int partial_writeback=0,deferred_error=0;
    ln_array *work[LN_NDITER_MULTI_MAXARGS]={0};
    char *buffers[LN_NDITER_MULTI_MAXARGS]={0};
    for(int j=0;j<nout;++j){
        if(allocated[j])work[j]=outputs[j];
        else{
            work[j]=ln_array_new(nd,nd?shape:NULL,outputs[j]->descr,0,0,err);
            if(!work[j])goto fail_work;
            apply_keeporder_strides(work[j],order_axes,nd);
            if((where||validate)&&copy_same_shape(outputs[j],work[j],err)<0)goto fail_work;
        }
    }

    ln_intp total=1;
    for(int d=0;d<nd;++d){
        if(shape[d]==0){total=0;break;}
        if(ln_mul_sizes_with_overflow(&total,total,shape[d])){iter_error(err,"broadcast result is too large");goto fail_work;}
    }

    if(total>0){
        const int nop=nin+nout;
        ln_intp strides[LN_NDITER_MULTI_MAXARGS][LN_MAXDIMS];memset(strides,0,sizeof(strides));
        for(int i=0;i<nin;++i){
            char nm[32];snprintf(nm,sizeof(nm),"operand %d",i);
            if(ln_broadcast_strides(nd,shape,inputs[i]->nd,inputs[i]->dimensions,inputs[i]->strides,nm,strides[i],err)<0)goto fail_work;
        }
        for(int j=0;j<nout;++j){
            if(ln_broadcast_strides(nd,shape,work[j]->nd,work[j]->dimensions,work[j]->strides,
                    "output operand",strides[nin+j],err)<0)goto fail_work;
        }
        ln_intp mstrides[LN_MAXDIMS]={0};
        if(where&&ln_broadcast_strides(nd,shape,where->nd,where->dimensions,where->strides,
                "where mask",mstrides,err)<0)goto fail_work;

        /* NpyIter negates unanimous negative strides only when no operand
         * needs allocation. This also determines which writes precede an
         * arithmetic error for a reversed in-place output. Use the original
         * operand strides to choose direction, then transform work storage. */
        ln_intp origins[LN_NDITER_MULTI_MAXARGS]={0},mask_origin=0;
        int any_allocate=0;for(int j=0;j<nout;++j)any_allocate|=allocated[j];
        if(!any_allocate)for(int ia=0;ia<nd;++ia){
            int negative=0,positive=0,d=order_axes[ia].original_axis;
            int original_nop=nin+nout+(where?1:0);
            for(int k=0;k<original_nop;++k){
                negative|=order_axes[ia].strides[k]<0;
                positive|=order_axes[ia].strides[k]>0;
            }
            if(shape[d]>1&&negative&&!positive){
                for(int k=0;k<nin+nout;++k){
                    origins[k]+=(shape[d]-1)*strides[k][d];strides[k][d]=-strides[k][d];
                }
                mask_origin+=(shape[d]-1)*mstrides[d];mstrides[d]=-mstrides[d];
            }
        }

        int dense[LN_NDITER_MULTI_MAXARGS]={0};
        if(uniform)uniform_buffer_plan(nin,nout,inputs,work,where,loop_dtypes,
                order_axes,nd,shape,strides,mstrides,dense);
        size_t isz[LN_NDITER_MULTI_MAXARGS]={0};
        for(int k=0;k<nop;++k){
            isz[k]=loop_dtypes[k]->elsize;
            int needs;
            if(k<nin)needs=inputs[k]->descr!=loop_dtypes[k]||!(inputs[k]->flags&LN_ARRAY_ALIGNED);
            else{int j=k-nin;needs=work[j]->descr!=loop_dtypes[k]||where!=NULL;}
            if(needs||dense[k]){
                buffers[k]=(char*)malloc((size_t)LN_NDITER_MULTI_BUFSIZE*isz[k]);
                if(!buffers[k]){iter_error(err,"out of memory");goto fail_work;}
            }
        }

        /* Traverse the same KEEPORDER axis permutation used for allocation.
         * Fixed C-order traversal made F-contiguous arrays take an unrelated
         * scalar arithmetic path despite a vector-eligible physical layout. */
        int inner_axis=nd?order_axes[0].original_axis:0;
        ln_intp inner=(nd==0)?1:shape[inner_axis];
        ln_intp outer=(nd==0)?1:(inner?total/inner:0);
        int merged_axes=1;ln_intp merged_length=inner;
        for(int ia=1;ia<nd;++ia){
            int d=order_axes[ia].original_axis,compatible=1;
            for(int k=0;k<nop;++k)if(shape[d]>1&&
                    (strides[k][inner_axis]>INTPTR_MAX/merged_length||
                     strides[k][inner_axis]<INTPTR_MIN/merged_length||
                     strides[k][d]!=strides[k][inner_axis]*merged_length)){compatible=0;break;}
            if(where&&shape[d]>1&&
                    (mstrides[inner_axis]>INTPTR_MAX/merged_length||
                     mstrides[inner_axis]<INTPTR_MIN/merged_length||
                     mstrides[d]!=mstrides[inner_axis]*merged_length))compatible=0;
            if(!compatible)break;
            ++merged_axes;merged_length*=shape[d];
        }
        int source_buffered=merged_axes<nd;
        for(int i=0;i<nin;++i)if(inputs[i]->descr!=loop_dtypes[i]||
                !(inputs[i]->flags&LN_ARRAY_ALIGNED))source_buffered=1;
        for(int j=0;j<nout;++j)if(outputs[j]->descr!=loop_dtypes[nin+j])source_buffered=1;
        ln_intp source_span=merged_length>LN_NDITER_MULTI_BUFSIZE?LN_NDITER_MULTI_BUFSIZE:
            (LN_NDITER_MULTI_BUFSIZE/merged_length)*merged_length;
        ln_intp coord[LN_MAXDIMS]={0};
        int failed_mask_run=0;
        for(ln_intp oi=0;oi<outer;++oi){
            const char *inrow[LN_NDITER_MULTI_MAXARGS]={0};
            char *outrow[LN_NDITER_MULTI_MAXARGS]={0};
            const char *mrow=where?where->data+mask_origin:NULL;
            for(int i=0;i<nin;++i)inrow[i]=inputs[i]->data+origins[i];
            for(int j=0;j<nout;++j)outrow[j]=work[j]->data+origins[nin+j];
            for(int ia=1;ia<nd;++ia){
                int d=order_axes[ia].original_axis;
                for(int i=0;i<nin;++i)inrow[i]+=coord[d]*strides[i][d];
                for(int j=0;j<nout;++j)outrow[j]+=coord[d]*strides[nin+j][d];
                if(where)mrow+=coord[d]*mstrides[d];
            }
            ln_intp mstep=(where&&nd)?mstrides[inner_axis]:0;
            for(ln_intp off=0;off<inner;){
                ln_intp count=inner-off;if(count>LN_NDITER_MULTI_BUFSIZE)count=LN_NDITER_MULTI_BUFSIZE;
                if(source_buffered){
                    ln_intp global=oi*inner+off,remaining=source_span-global%source_span;
                    if(global%source_span==0)failed_mask_run=0;
                    if(count>remaining)count=remaining;
                }
                char *args[LN_NDITER_MULTI_MAXARGS]={0};ln_intp steps[LN_NDITER_MULTI_MAXARGS]={0};
                for(int i=0;i<nin;++i){
                    ln_intp st=nd?strides[i][inner_axis]:0;const char *src=inrow[i]+off*st;
                    if(buffers[i]){
                        /* NpyIter retains broadcast scalar stride zero even
                         * when dtype conversion needs a buffer. Expanding a
                         * scalar to dense storage changes clip's real loop
                         * selection and observable signed-zero semantics. */
                        ln_intp converted=(st||dense[i])?count:1;
                        if(ln_cast_strided_numeric(src,st,inputs[i]->descr,buffers[i],(ln_intp)isz[i],loop_dtypes[i],converted,err)<0)goto fail_work;
                        args[i]=buffers[i];steps[i]=(st||dense[i])?(ln_intp)isz[i]:0;
                    }else{args[i]=(char*)src;steps[i]=st;}
                }
                for(int j=0;j<nout;++j){
                    int k=nin+j;ln_intp st=nd?strides[k][inner_axis]:0;char *dst=outrow[j]+off*st;
                    if(buffers[k]){args[k]=buffers[k];steps[k]=(ln_intp)isz[k];}
                    else{args[k]=dst;steps[k]=st;}
                }
                ln_intp dims[1]={count};
                const uint8_t *maskp=where?(const uint8_t *)(mrow+off*mstep):NULL;
                ln_intp write_mask_step=mstep;uint8_t written[LN_NDITER_MULTI_BUFSIZE];
                int validation=0;
                if(where&&validate){
                    if(masked_validated_chunk(nop,args,steps,count,maskp,mstep,written,&failed_mask_run,
                            loop,loop_data,validate,validate_data,&partial_writeback,&deferred_error,err)<0)goto fail_work;
                    maskp=written;write_mask_step=1;
                }else validation=validate?validate(args,dims,steps,maskp,mstep,validate_data,err):0;
                if(validation==-1)goto fail_work;
                if(validation!=0)partial_writeback=1;
                if(validation< -1){
                    ln_intp prefix=-(ln_intp)validation-2;
                    if(prefix>count){iter_error(err,"invalid partial validation prefix");goto fail_work;}
                    dims[0]=count=prefix;
                }
                if(!(where&&validate))loop(args,dims,steps,loop_data);
                for(int j=0;j<nout;++j){
                    int k=nin+j;if(!buffers[k])continue;
                    ln_intp st=nd?strides[k][inner_axis]:0;char *dst=outrow[j]+off*st;
                    if(!where){
                        if(ln_cast_strided_numeric(buffers[k],(ln_intp)isz[k],loop_dtypes[k],dst,st,work[j]->descr,count,err)<0)goto fail_work;
                    }else{
                        for(ln_intp z=0;z<count;++z)if(maskp[z*write_mask_step]){
                            if(ln_cast_strided_numeric(buffers[k]+z*(ln_intp)isz[k],0,loop_dtypes[k],dst+z*st,0,work[j]->descr,1,err)<0)goto fail_work;
                        }
                    }
                }
                if(validation< -1)goto fail_work;
                off+=count;
            }
            for(int ia=1;ia<nd;++ia){
                int d=order_axes[ia].original_axis;
                if(++coord[d]<shape[d])break;
                coord[d]=0;
            }
        }
    }

    if(deferred_error)goto fail_work;
    for(int k=0;k<LN_NDITER_MULTI_MAXARGS;++k){free(buffers[k]);buffers[k]=NULL;}
    for(int j=0;j<nout;++j)if(!allocated[j]){
        if(copy_same_shape(work[j],outputs[j],err)<0)goto fail_work;
        ln_array_free(work[j]);work[j]=NULL;
    }
    return 0;

fail_work:
    if(partial_writeback)for(int j=0;j<nout;++j)if(!allocated[j]&&work[j]){
        ln_error writeback_error={0};
        if(copy_same_shape(work[j],outputs[j],&writeback_error)<0&&err)*err=writeback_error;
    }
    for(int k=0;k<LN_NDITER_MULTI_MAXARGS;++k)free(buffers[k]);
    for(int j=0;j<nout;++j)if(!allocated[j]&&work[j])ln_array_free(work[j]);
fail:
    for(int j=0;j<nout;++j)if(allocated[j]&&outputs[j]){ln_array_free(outputs[j]);outputs[j]=NULL;}
    return -1;
}

int ln_nditer_multi_execute(int nin,int nout,const ln_array *const *inputs,
        ln_array **outputs,const ln_array *where,const ln_dtype_descr *const *dtypes,
        ln_strided_loop loop,void *data,ln_nditer_validate_fn validate,void *validation,ln_error *err)
{return execute(nin,nout,inputs,outputs,where,dtypes,loop,data,validate,validation,0,err);}
int ln_nditer_multi_execute_uniform(int nin,int nout,const ln_array *const *inputs,
        ln_array **outputs,const ln_array *where,const ln_dtype_descr *const *dtypes,
        ln_strided_loop loop,void *data,ln_nditer_validate_fn validate,void *validation,ln_error *err)
{return execute(nin,nout,inputs,outputs,where,dtypes,loop,data,validate,validation,1,err);}
