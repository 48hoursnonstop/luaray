#include "ln_core.h"
#include "ln_dtype_transfer.h"
#include "ln_dot.h"
#include "ln_join.h"
#include "ln_split.h"
#include "ln_half.h"
#include "ln_datetime.h"
#include "ln_datetime_strings.h"
#include "ln_string.h"
#include "ln_sort.h"
#include "ln_fft.h"
#include "ln_ufunc.h"
#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static void chk(int ok,const char*msg){if(!ok){fprintf(stderr,"FAIL: %s\n",msg);assert(ok);}}
int main(void){
    ln_error e={0};
    const ln_dtype*f8=ln_dtype_by_name("float64");
    ln_intp sh22[]={2,2}; ln_array*a=ln_array_new(2,sh22,f8,0,1,&e); chk(a!=NULL,e.message); chk(a->strides[0]==16&&a->strides[1]==8,"C strides 2x2"); chk((a->flags&LN_ARRAY_C_CONTIGUOUS)!=0,"C flag"); chk((a->flags&LN_ARRAY_F_CONTIGUOUS)==0,"not F flag"); ln_array_free(a);

    /* From numpy/_core/tests/test_api.py::test_contiguous_flags */
    ln_intp zsh[]={2,2,0,2,2}; a=ln_array_new(5,zsh,f8,0,0,&e); chk(a!=NULL,e.message); chk((a->flags&3)==3,"zero-size arrays C and F contiguous"); for(int i=0;i<5;i++)chk(a->strides[i]==0,"zero-size strides zeroed by ctor"); ln_array_free(a);

    /* From numpy/_core/tests/test_numeric.py::TestBroadcast::test_broadcast_in_args */
    ln_intp s0[]={6,7},s1[]={5,6,1},s2[]={7},s3[]={5,1,7};
    ln_array*x0=ln_array_new(2,s0,f8,0,0,&e),*x1=ln_array_new(3,s1,f8,0,0,&e),*x2=ln_array_new(1,s2,f8,0,0,&e),*x3=ln_array_new(3,s3,f8,0,0,&e);
    const ln_array*xs[]={x0,x1,x2,x3};ln_intp out[64];int nd=0;chk(ln_broadcast_shape(4,xs,&nd,out,&e)==0,e.message);chk(nd==3&&out[0]==5&&out[1]==6&&out[2]==7,"broadcast => (5,6,7)");
    ln_array_free(x0);ln_array_free(x1);ln_array_free(x2);ln_array_free(x3);

    ln_intp m0[]={1,3},m1[]={2},m2[]={2,1}; x0=ln_array_new(2,m0,f8,0,0,&e);x1=ln_array_new(2,m2,f8,0,0,&e);x2=ln_array_new(1,m1,f8,0,0,&e);const ln_array*bad[]={x0,x1,x2};chk(ln_broadcast_shape(3,bad,&nd,out,&e)<0,"mismatch should fail");chk(strstr(e.message,"arg 0")&&strstr(e.message,"arg 2"),"NumPy-style mismatch indexes");ln_array_free(x0);ln_array_free(x1);ln_array_free(x2);

    /* NumPy halffloat.cpp / half_private.hpp conversion invariants. */
    chk(ln_float_to_half(1.0f)==UINT16_C(0x3c00),"float16 1.0 bits");
    chk(ln_float_to_half(-0.0f)==UINT16_C(0x8000),"float16 negative zero bits");
    chk(ln_float_to_half(65504.0f)==UINT16_C(0x7bff),"float16 max finite bits");
    chk(ln_float_to_half(ldexpf(1.0f,-24))==UINT16_C(0x0001),"float16 minimum subnormal bits");
    chk(ln_half_to_float(UINT16_C(0x3c00))==1.0f,"float16 decode 1.0");
    chk(isinf(ln_half_to_float(UINT16_C(0x7c00))),"float16 decode infinity");
    chk(isnan(ln_half_to_float(UINT16_C(0x7e00))),"float16 decode NaN");

    /* NumPy 2.x DTypeMeta/descriptor split, adapted without Python objects. */
    {
        const ln_dtype_descr *f32d=ln_dtype_by_name("float32");
        const ln_dtype_descr *f64d=ln_dtype_by_name("float64");
        const ln_dtype_class *f32c=ln_dtype_class_by_name("float32");
        const ln_dtype_class *f64c=ln_dtype_class_by_num(LN_DOUBLE);
        chk(f32d&&f32c&&f32d->cls==f32c,"descriptor owns DType class");
        chk(ln_dtype_default_descr(f32c)==f32d,"builtin DType default descriptor singleton");
        chk(f32c->legacy_type_num==LN_FLOAT&&f32c->kind=='f',"DType class numeric identity");
        chk((f32c->flags&LN_DTYPE_CLASS_LEGACY_NUMERIC)!=0,"builtin numeric DType class flag");
        chk((f32c->flags&LN_DTYPE_CLASS_PARAMETRIC)==0,"builtin numeric DType is non-parametric");
        chk(ln_dtype_same_class(f32d,ln_dtype_by_num(LN_FLOAT)),"same-class descriptor check");
        chk(!ln_dtype_same_class(f32d,f64d),"different-class descriptor check");
        chk(ln_common_dtype_class(f32c,ln_dtype_class_by_name("int32"))==f64c,
            "common DType class float32+int32 -> float64");
        chk(ln_common_dtype_descr(f32d,ln_dtype_by_name("int32"))==f64d,
            "common descriptor float32+int32 -> float64 singleton");
    }

    /* NumPy datetime.c / dtype_api.h: first genuinely parametric DTypes. */
    {
        const ln_dtype_descr *md=ln_dtype_by_name("datetime64[D]");
        const ln_dtype_descr *mh=ln_dtype_by_name("datetime64[h]");
        const ln_dtype_descr *td2=ln_dtype_by_name("timedelta64[2D]");
        const ln_dtype_descr *td3=ln_dtype_by_name("timedelta64[3D]");
        chk(md&&mh&&md!=mh&&md->cls==mh->cls,"datetime descriptors share a parametric DType class");
        chk((md->cls->flags&LN_DTYPE_CLASS_PARAMETRIC)!=0,"datetime DType class is parametric");
        chk(ln_dtype_default_descr(md->cls)->type_num==LN_DATETIME,"datetime class has generic default descriptor");
        chk(strcmp(ln_common_dtype_descr(md,mh)->name,"datetime64[h]")==0,"datetime D+h common metadata -> h");
        chk(strcmp(ln_common_dtype_descr(td2,td3)->name,"timedelta64[D]")==0,"timedelta 2D+3D common metadata -> D");
        chk(strcmp(ln_common_dtype_descr(md,ln_dtype_by_name("timedelta64[h]"))->name,"datetime64[h]")==0,
            "datetime + timedelta common metadata keeps datetime class");
        chk(ln_common_dtype_descr(ln_dtype_by_name("timedelta64[Y]"),ln_dtype_by_name("timedelta64[D]"))==NULL,
            "nonlinear timedelta Y+D promotion is incompatible");

        chk(strcmp(ln_dtype_by_name("M8[Y/4]")->name,"datetime64[3M]")==0,"datetime divisor Y/4 -> 3M");
        chk(strcmp(ln_dtype_by_name("M8[Y/13]")->name,"datetime64[4W]")==0,"datetime divisor Y/13 -> 4W");
        chk(strcmp(ln_dtype_by_name("M8[3Y/73]")->name,"datetime64[15D]")==0,"datetime divisor 3Y/73 -> 15D");
        chk(strcmp(ln_dtype_by_name("M8[D/120]")->name,"datetime64[12m]")==0,"datetime divisor D/120 -> 12m");
        chk(strcmp(ln_dtype_by_name("m8[3s/10000]")->name,"timedelta64[300us]")==0,"timedelta divisor 3s/10000 -> 300us");
        chk(strcmp(ln_dtype_by_name("M8[fs/100]")->name,"datetime64[10as]")==0,"datetime divisor fs/100 -> 10as");
        chk(ln_dtype_by_name("M8[3fs/10000]")==NULL,"datetime divisor below attoseconds rejected");
        chk(ln_dtype_by_name("M8[as/10]")==NULL,"attoseconds cannot be subdivided");
        chk(strcmp(ln_dtype_by_name("m8[W/13]")->name,"timedelta64[0Y]")==0,"upstream W divisor 0Y quirk preserved");
        chk(strcmp(ln_dtype_by_name("M8[μs]")->name,"datetime64[us]")==0,"UTF-8 microsecond unit accepted");

        int64_t cv=0; ln_error de={0};
        chk(ln_datetime_cast_value(24,ln_datetime_metadata(ln_dtype_by_name("timedelta64[h]")),
                ln_datetime_metadata(ln_dtype_by_name("timedelta64[D]")),&cv,&de)==0&&cv==1,
            "datetime cast 24h -> 1D");
        chk(ln_datetime_cast_value(-1,ln_datetime_metadata(ln_dtype_by_name("timedelta64[h]")),
                ln_datetime_metadata(ln_dtype_by_name("timedelta64[D]")),&cv,&de)==0&&cv==-1,
            "datetime cast floors negative fractional conversion");
        chk(ln_datetime_cast_value(LN_DATETIME_NAT,ln_datetime_metadata(md),ln_datetime_metadata(mh),&cv,&de)==0&&cv==LN_DATETIME_NAT,
            "NaT is invariant under metadata casts");

        const ln_dtype_descr *parsed=NULL;int hadtz=0;char iso[192];
        chk(ln_datetime_parse_iso8601("2010-03-15T12:30:45.1234",NULL,&parsed,&cv,&hadtz,&de)==0,de.message);
        chk(strcmp(parsed->name,"datetime64[us]")==0&&cv==INT64_C(1268656245123400),"ISO parser inferred us descriptor/value");
        chk(ln_datetime_format_iso8601(cv,ln_datetime_metadata(parsed),LN_FR_us,0,LN_DT_TZ_NAIVE,0,LN_DT_CAST_SAME_KIND,iso,sizeof(iso),&de)==0,de.message);
        chk(strcmp(iso,"2010-03-15T12:30:45.123400")==0,"ISO formatter us roundtrip");
        chk(ln_datetime_parse_iso8601("1977-03-02T12:30-0230",NULL,&parsed,&cv,&hadtz,&de)==0&&hadtz,de.message);
        chk(strcmp(parsed->name,"datetime64[m]")==0,"timezone parser keeps detected minute precision");
        chk(ln_datetime_format_iso8601(cv,ln_datetime_metadata(parsed),LN_FR_m,0,LN_DT_TZ_NAIVE,0,LN_DT_CAST_SAME_KIND,iso,sizeof(iso),&de)==0,de.message);
        chk(strcmp(iso,"1977-03-02T15:00")==0,"timezone offset normalized to UTC");
        chk(ln_datetime_parse_iso8601("1969-12-31T23:34:56.789012345678901234",NULL,&parsed,&cv,&hadtz,&de)==0,de.message);
        chk(cv==INT64_C(-9024717683847417870),"attosecond constructor preserves NumPy int64 wrap quirk");
    }

    /* Promotion machinery ported from scalartypes.c.src/can_cast_table.h. */
    chk(ln_promote_dtype(ln_dtype_by_name("int8"),ln_dtype_by_name("uint8"))->type_num==LN_SHORT,"int8+uint8 -> int16");
    chk(ln_promote_dtype(ln_dtype_by_name("int32"),ln_dtype_by_name("uint32"))->type_num==LN_LONG,"int32+uint32 -> platform long when 64-bit");
    chk(ln_promote_dtype(ln_dtype_by_name("int64"),ln_dtype_by_name("uint64"))->type_num==LN_DOUBLE,"int64+uint64 -> float64");
    chk(ln_promote_dtype(ln_dtype_by_name("float32"),ln_dtype_by_name("int32"))->type_num==LN_DOUBLE,"float32+int32 -> float64");

    const ln_dtype*i8=ln_dtype_by_name("int64"); ln_intp sh23[]={2,3}; a=ln_array_new(2,sh23,i8,0,1,&e);chk(a!=NULL,e.message);ln_intp ij[2];for(int i=0;i<2;i++)for(int j=0;j<3;j++){ij[0]=i;ij[1]=j;chk(ln_array_set_number(a,ij,0,i*3+j,1,&e)==0,e.message);}ln_array*row=ln_array_index_axis0(a,2,&e);chk(row&&row->nd==1&&row->dimensions[0]==3,"1-based row view");ln_intp k[]={1};double dv=0;int64_t iv=0;int isint=0;chk(ln_array_get_number(row,k,&dv,&iv,&isint,&e)==0&&iv==4,"view shares data");ln_array_free(row);
    ln_intp resh[]={3,2};ln_array*r=ln_array_reshape_c(a,2,resh,&e);chk(r&&r->strides[0]==16&&r->strides[1]==8,"reshape view strides");ln_array_free(r);
    ln_intp bsh[]={3};ln_array*b=ln_array_new(1,bsh,i8,0,1,&e);for(int j=0;j<3;j++){ln_intp q[]={j};ln_array_set_number(b,q,0,j+10,1,&e);}ln_array*c=ln_binary_add(a,b,&e);chk(c&&c->nd==2&&c->dimensions[0]==2&&c->dimensions[1]==3,"binary broadcast shape");ij[0]=1;ij[1]=2;ln_array_get_number(c,ij,&dv,&iv,&isint,&e);chk(iv==17,"broadcast add value");chk(fabs(ln_mean_all(a,&e)-2.5)<1e-12,"mean");ln_array_free(c);ln_array_free(b);ln_array_free(a);

    /*
     * Adapted from mapping.c:get_view_from_index and
     * numpy/_core/tests/test_indexing.py basic indexing cases.
     */
    {
        ln_intp sh[]={2,3,4};
        ln_array *q=ln_array_new(3,sh,i8,0,1,&e);
        chk(q!=NULL,e.message);
        ln_intp qi[3];
        for(int x=0;x<2;x++)for(int y=0;y<3;y++)for(int z=0;z<4;z++){
            qi[0]=x;qi[1]=y;qi[2]=z;
            chk(ln_array_set_number(q,qi,0,x*12+y*4+z,1,&e)==0,e.message);
        }

        ln_index revix[2]={{0}};
        revix[0].kind=LN_INDEX_ELLIPSIS; revix[0].value=2;
        revix[1].kind=LN_INDEX_SLICE; revix[1].start=3; revix[1].step=-1; revix[1].length=4;
        ln_array *rev=ln_array_basic_view(q,revix,2,&e);
        chk(rev&&rev->nd==3,"reverse basic view");
        chk(rev->strides[0]==96&&rev->strides[1]==32&&rev->strides[2]==-8,"negative slice stride");
        qi[0]=0;qi[1]=0;qi[2]=0;
        ln_array_get_number(rev,qi,&dv,&iv,&isint,&e);chk(iv==3,"reverse slice first value");
        chk(ln_array_set_number(rev,qi,0,999,1,&e)==0,e.message);
        qi[2]=3;ln_array_get_number(q,qi,&dv,&iv,&isint,&e);chk(iv==999,"slice is a sharing view");

        ln_array_free(rev);

        ln_index subix[3]={{0}};
        subix[0].kind=LN_INDEX_INTEGER;subix[0].value=1;
        subix[1].kind=LN_INDEX_SLICE;subix[1].start=0;subix[1].step=2;subix[1].length=2;
        subix[2].kind=LN_INDEX_ELLIPSIS;subix[2].value=1;
        ln_array *sub=ln_array_basic_view(q,subix,3,&e);
        chk(sub&&sub->nd==2&&sub->dimensions[0]==2&&sub->dimensions[1]==4,"integer+slice+ellipsis shape");
        ln_intp si[]={1,3};ln_array_get_number(sub,si,&dv,&iv,&isint,&e);chk(iv==23,"integer+slice+ellipsis value");
        ln_array_free(sub);

        ln_index naix[2]={{0}};
        naix[0].kind=LN_INDEX_NEWAXIS;
        naix[1].kind=LN_INDEX_ELLIPSIS;naix[1].value=3;
        ln_array *na=ln_array_basic_view(q,naix,2,&e);
        chk(na&&na->nd==4&&na->dimensions[0]==1&&na->dimensions[1]==2&&na->dimensions[2]==3&&na->dimensions[3]==4,"newaxis shape");
        chk(na->strides[0]==0&&na->strides[1]==96,"newaxis stride");
        ln_array_free(na);

        /* array_assign_scalar.c semantics: pack once, then strided assignment. */
        rev=ln_array_basic_view(q,revix,2,&e);
        chk(rev!=NULL,e.message);
        chk(ln_array_assign_scalar(rev,0,42,1,&e)==0,e.message);
        for(int x=0;x<2;x++)for(int y=0;y<3;y++)for(int z=0;z<4;z++){
            qi[0]=x;qi[1]=y;qi[2]=z;
            ln_array_get_number(q,qi,&dv,&iv,&isint,&e);
            chk(iv==42,"scalar assignment through reverse view updates base");
        }
        ln_array_free(rev);
        ln_array_free(q);
    }

    /* NumPy integer ufuncs wrap; avoid C signed-overflow UB in the port. */
    {
        const ln_dtype *i1=ln_dtype_by_name("int8"); ln_intp one[]={1};
        ln_array *q=ln_array_new(1,one,i1,0,1,&e); ln_intp qi[]={0};
        chk(ln_array_set_number(q,qi,0,127,1,&e)==0,e.message);
        ln_array *qq=ln_binary_scalar(q,0,1,1,0,&e);
        ln_array_get_number(qq,qi,&dv,&iv,&isint,&e); chk(iv==-128,"int8 overflow wraps");
        ln_array_free(qq); ln_array_free(q);
    }

    /* subtract/true_divide: generated ufunc loops plus resolver behavior. */
    {
        const ln_dtype *i1=ln_dtype_by_name("int8");
        ln_intp two[]={2};
        ln_array *x=ln_array_new(1,two,i1,0,1,&e);
        ln_array *y=ln_array_new(1,two,i1,0,1,&e);
        ln_intp q[]={0};
        chk(ln_array_set_number(x,q,0,1,1,&e)==0,e.message);
        chk(ln_array_set_number(y,q,0,2,1,&e)==0,e.message);
        q[0]=1;
        chk(ln_array_set_number(x,q,0,2,1,&e)==0,e.message);
        chk(ln_array_set_number(y,q,0,4,1,&e)==0,e.message);
        ln_array *sub=ln_binary_subtract(x,y,&e);
        chk(sub&&sub->descr->type_num==LN_BYTE,"int8 subtract dtype");
        q[0]=0;ln_array_get_number(sub,q,&dv,&iv,&isint,&e);chk(iv==-1,"int8 subtract value");
        ln_array *div=ln_binary_true_divide(x,y,&e);
        chk(div&&div->descr->type_num==LN_DOUBLE,"integer true_divide -> float64");
        q[0]=1;ln_array_get_number(div,q,&dv,&iv,&isint,&e);chk(!isint&&fabs(dv-0.5)<1e-12,"true_divide value");
        ln_array_free(div);ln_array_free(sub);ln_array_free(y);ln_array_free(x);

        x=ln_array_new(1,two,ln_dtype_by_name("timedelta64[h]"),0,0,&e);
        y=ln_array_new(1,two,ln_dtype_by_name("int64"),0,0,&e);
        ((int64_t*)x->data)[0]=INT64_MAX;((int64_t*)x->data)[1]=-7;
        ((int64_t*)y->data)[0]=1;((int64_t*)y->data)[1]=2;
        div=NULL;
        const ln_array *duration_inputs[]={x,y};
        chk(ln_ufunc_execute(ln_ufunc_by_name("true_divide"),duration_inputs,&div,NULL,&e)==0,e.message);
        chk(div&&div->descr==x->descr,"integer duration division descriptor");
        chk(((int64_t*)div->data)[0]==INT64_MAX&&((int64_t*)div->data)[1]==-3,"exact duration quotient and negative truncation");
        ln_array_free(div);ln_array_free(y);
        y=ln_array_new(1,two,ln_dtype_by_name("timedelta64[D]"),0,0,&e);
        ((int64_t*)y->data)[0]=1;((int64_t*)y->data)[1]=0;
        ((int64_t*)x->data)[0]=48;((int64_t*)x->data)[1]=LN_DATETIME_NAT;
        div=NULL;duration_inputs[0]=x;duration_inputs[1]=y;
        chk(ln_ufunc_execute(ln_ufunc_by_name("true_divide"),duration_inputs,&div,NULL,&e)==0,e.message);
        chk(div&&div->descr->type_num==LN_DOUBLE,"duration ratio dtype");
        chk(((double*)div->data)[0]==2&&isnan(((double*)div->data)[1]),"duration common units and NaT ratio");
        ln_array_free(div);ln_array_free(y);ln_array_free(x);

        const ln_dtype *bt=ln_dtype_by_name("bool");
        x=ln_array_new(1,two,bt,0,1,&e);y=ln_array_new(1,two,bt,0,1,&e);
        e.message[0]='\0';
        sub=ln_binary_subtract(x,y,&e);
        chk(sub==NULL&&strstr(e.message,"boolean subtract"),"bool subtract error");
        ln_array_free(y);ln_array_free(x);
    }

    /* NpyIter subset: keep-order output, masked out=, and overlap writeback. */
    {
        const ln_dtype *i8=ln_dtype_by_name("int64");
        const ln_dtype *i1=ln_dtype_by_name("int8");
        const ln_dtype *bt=ln_dtype_by_name("bool");
        ln_intp sh23[]={2,3};
        ln_array *base=ln_array_new(2,sh23,i8,0,1,&e);
        for(ln_intp k=0;k<6;k++){
            ln_intp q[]={k/3,k%3};
            chk(ln_array_set_number(base,q,0,(int64_t)k,1,&e)==0,e.message);
        }
        ln_array *tr=ln_array_transpose(base,&e);
        ln_array *sum=ln_binary_add(tr,tr,&e);
        chk(sum&&sum->nd==2&&sum->strides[0]==8&&sum->strides[1]==24,
            "nditer keep-order output strides");
        ln_array_free(sum);ln_array_free(tr);ln_array_free(base);

        ln_intp three[]={3};
        ln_array *a=ln_array_new(1,three,i1,0,1,&e);
        ln_array *b=ln_array_new(1,three,i1,0,1,&e);
        ln_array *out=ln_array_new(1,three,i8,0,1,&e);
        ln_array *mask=ln_array_new(1,three,bt,0,1,&e);
        for(ln_intp k=0;k<3;k++){
            ln_intp q[]={k};
            chk(ln_array_set_number(a,q,0,k+1,1,&e)==0,e.message);
            chk(ln_array_set_number(b,q,0,(k+1)*10,1,&e)==0,e.message);
            chk(ln_array_set_number(out,q,0,100,1,&e)==0,e.message);
            chk(ln_array_set_number(mask,q,0,k!=1,1,&e)==0,e.message);
        }
        chk(ln_binary_array_op_into(a,b,out,mask,LN_OP_ADD,&e)==0,e.message);
        ln_intp q[]={0};ln_array_get_number(out,q,&dv,&iv,&isint,&e);chk(iv==11,"masked out first");
        q[0]=1;ln_array_get_number(out,q,&dv,&iv,&isint,&e);chk(iv==100,"masked out preserved false");
        q[0]=2;ln_array_get_number(out,q,&dv,&iv,&isint,&e);chk(iv==33,"masked out third");
        ln_array_free(mask);ln_array_free(out);ln_array_free(b);ln_array_free(a);
    }


    /* PyArray_MatrixProduct2 / PyArray_InnerProduct native contraction core. */
    {
        const ln_dtype *i8=ln_dtype_by_name("int64");
        ln_intp ash[]={2,3}, bsh[]={3,2};
        ln_array *aa=ln_array_new(2,ash,i8,0,1,&e);
        ln_array *bb=ln_array_new(2,bsh,i8,0,1,&e);
        for(ln_intp i=0;i<6;i++){
            ln_intp aq[]={i/3,i%3};
            ln_intp bq[]={i/2,i%2};
            chk(ln_array_set_number(aa,aq,0,(int64_t)i,1,&e)==0,e.message);
            chk(ln_array_set_number(bb,bq,0,(int64_t)i,1,&e)==0,e.message);
        }
        ln_array *dr=ln_dot(aa,bb,&e);
        chk(dr&&dr->nd==2&&dr->dimensions[0]==2&&dr->dimensions[1]==2,"dot matrix shape");
        ln_intp q[]={1,1};ln_array_get_number(dr,q,&dv,&iv,&isint,&e);chk(iv==40,"dot matrix value");
        chk((dr->flags&LN_ARRAY_C_CONTIGUOUS)!=0,"dot output C contiguous");
        ln_array_free(dr);

        ln_intp ibsh[]={2,3};
        ln_array *ib=ln_array_new(2,ibsh,i8,0,1,&e);
        for(ln_intp i=0;i<6;i++){ln_intp iq[]={i/3,i%3};chk(ln_array_set_number(ib,iq,0,(int64_t)(i+1),1,&e)==0,e.message);}
        ln_array *ir=ln_inner(aa,ib,&e);
        chk(ir&&ir->nd==2&&ir->dimensions[0]==2&&ir->dimensions[1]==2,"inner shape");
        q[0]=1;q[1]=1;ln_array_get_number(ir,q,&dv,&iv,&isint,&e);chk(iv==62,"inner value");
        ln_array_free(ir);

        ln_array *or=ln_outer(aa,bb,&e);
        chk(or&&or->nd==2&&or->dimensions[0]==6&&or->dimensions[1]==6,"outer flattened shape");
        q[0]=5;q[1]=5;ln_array_get_number(or,q,&dv,&iv,&isint,&e);chk(iv==25,"outer flattened value");
        ln_array_free(or);ln_array_free(ib);ln_array_free(bb);ln_array_free(aa);
    }


    /* NumPy npysort: introsort/argsort + introselect/argpartition. */
    {
        const ln_dtype *f8=ln_dtype_by_name("float64");
        ln_intp sh[]={2,4};
        ln_array *q=ln_array_new(2,sh,f8,0,1,&e);
        double vals[8]={3.0,NAN,1.0,2.0, 9.0,7.0,8.0,6.0};
        for(ln_intp i=0;i<8;i++){ln_intp ij[]={i/4,i%4};chk(ln_array_set_number(q,ij,vals[i],0,0,&e)==0,e.message);}
        ln_array *sq=ln_sort_copy(q,1,0,&e);chk(sq!=NULL,e.message);
        ln_intp ij[]={0,0};ln_array_get_number(sq,ij,&dv,&iv,&isint,&e);chk(dv==1.0,"sort row first");
        ij[1]=3;ln_array_get_number(sq,ij,&dv,&iv,&isint,&e);chk(isnan(dv),"sort NaN to end");
        ln_array *aq=ln_argsort(q,1,0,&e);chk(aq!=NULL,e.message);
        ij[0]=1;ij[1]=0;ln_array_get_number(aq,ij,&dv,&iv,&isint,&e);chk(iv==4,"argsort public index is 1-based");
        ln_intp kth[]={1};
        ln_array *pq=ln_partition_copy(q,kth,1,1,0,&e);chk(pq!=NULL,e.message);
        ij[0]=1;ij[1]=1;ln_array_get_number(pq,ij,&dv,&iv,&isint,&e);chk(dv==7.0,"partition kth value");
        ln_array *ap=ln_argpartition(q,kth,1,1,0,&e);chk(ap!=NULL,e.message);
        ln_array_free(ap);ln_array_free(pq);ln_array_free(aq);ln_array_free(sq);ln_array_free(q);
    }


    /* PyArray_SearchSorted/binsearch numeric subset, Lua-facing positions +1. */
    {
        const ln_dtype *i8=ln_dtype_by_name("int64");
        ln_intp four[]={4}, three[]={3};
        ln_array *a=ln_array_new(1,four,i8,0,1,&e);
        ln_array *k=ln_array_new(1,three,i8,0,1,&e);
        int64_t av[4]={1,3,5,7}, kv[3]={0,3,8};
        for(ln_intp i=0;i<4;i++){ln_intp q[]={i};chk(ln_array_set_number(a,q,0,av[i],1,&e)==0,e.message);}
        for(ln_intp i=0;i<3;i++){ln_intp q[]={i};chk(ln_array_set_number(k,q,0,kv[i],1,&e)==0,e.message);}
        ln_array *r=ln_searchsorted(a,k,0,NULL,0,&e);chk(r!=NULL,e.message);
        ln_intp q[]={0};ln_array_get_number(r,q,&dv,&iv,&isint,&e);chk(iv==1,"searchsorted before first");
        q[0]=1;ln_array_get_number(r,q,&dv,&iv,&isint,&e);chk(iv==2,"searchsorted left equal");
        q[0]=2;ln_array_get_number(r,q,&dv,&iv,&isint,&e);chk(iv==5,"searchsorted after last");
        ln_array_free(r);ln_array_free(k);ln_array_free(a);
    }

    /* Comparison/logical/unary ufunc loops, including exact qQ/Qq ordering. */
    {
        const ln_dtype *i8=ln_dtype_by_name("int64");
        const ln_dtype *u8=ln_dtype_by_name("uint64");
        ln_intp one[]={1};
        ln_array *sa=ln_array_new(1,one,i8,0,1,&e);
        ln_array *ua=ln_array_new(1,one,u8,0,1,&e);
        ln_intp q[]={0};
        chk(ln_array_set_number(sa,q,0,INT64_C(9007199254740993),1,&e)==0,e.message);
        chk(ln_array_set_number(ua,q,0,INT64_C(9007199254740992),1,&e)==0,e.message);
        ln_array *eq=ln_binary_array_op_where(sa,ua,NULL,LN_OP_EQUAL,&e);
        ln_array *gt=ln_binary_array_op_where(sa,ua,NULL,LN_OP_GREATER,&e);
        chk(eq&&gt&&eq->descr->type_num==LN_BOOL,"comparison bool output");
        ln_array_get_number(eq,q,&dv,&iv,&isint,&e);chk(iv==0,"mixed int64/uint64 exact equality");
        ln_array_get_number(gt,q,&dv,&iv,&isint,&e);chk(iv==1,"mixed int64/uint64 exact greater");
        ln_array_free(gt);ln_array_free(eq);ln_array_free(ua);ln_array_free(sa);

        const ln_dtype *f8=ln_dtype_by_name("float64");
        ln_intp three[]={3};
        ln_array *fa=ln_array_new(1,three,f8,0,1,&e);
        double fv[3]={-INFINITY,-0.0,NAN};
        for(ln_intp i=0;i<3;i++){q[0]=i;chk(ln_array_set_number(fa,q,fv[i],0,0,&e)==0,e.message);}
        ln_array *finite=ln_unary_array_op_where(fa,NULL,LN_OP_ISFINITE,&e);
        ln_array *signb=ln_unary_array_op_where(fa,NULL,LN_OP_SIGNBIT,&e);
        chk(finite&&signb&&finite->descr->type_num==LN_BOOL,"unary predicate bool output");
        q[0]=0;ln_array_get_number(finite,q,&dv,&iv,&isint,&e);chk(iv==0,"isfinite inf false");
        q[0]=1;ln_array_get_number(signb,q,&dv,&iv,&isint,&e);chk(iv==1,"signbit negative zero");
        ln_array_free(signb);ln_array_free(finite);ln_array_free(fa);
    }

    /* Failed scalar packing must happen before raw iteration touches dst. */
    {
        const ln_dtype *i1=ln_dtype_by_name("int8"); ln_intp two[]={2};
        ln_array *q=ln_array_new(1,two,i1,0,1,&e); ln_intp qi[]={0};
        chk(ln_array_set_number(q,qi,0,7,1,&e)==0,e.message); qi[0]=1;
        chk(ln_array_set_number(q,qi,0,8,1,&e)==0,e.message);
        e.message[0]='\0';
        chk(ln_array_assign_scalar(q,0,200,1,&e)<0,"int8 assignment overflow");
        qi[0]=0;ln_array_get_number(q,qi,&dv,&iv,&isint,&e);chk(iv==7,"failed assignment leaves first element");
        qi[0]=1;ln_array_get_number(q,qi,&dv,&iv,&isint,&e);chk(iv==8,"failed assignment leaves second element");
        ln_array_free(q);
    }

    /* native PocketFFT core */
    {
        ln_intp sh[]={4}; ln_error fe={0};
        ln_array *x=ln_array_new(1,sh,ln_dtype_by_num(LN_DOUBLE),0,1,&fe);
        chk(x!=NULL,"fft input alloc");
        ln_intp ix[]={1}; chk(ln_array_set_number(x,ix,1.0,1,0,&fe)==0,"fft input set");
        ln_array *f=ln_fft_fft(x,4,0,0,LN_FFT_NORM_BACKWARD,NULL,&fe);
        chk(f&&f->descr->type_num==LN_CDOUBLE,"fft core dtype");
        long double rr=0,ii=0; ln_intp qi[]={1};
        chk(ln_array_get_complex(f,qi,&rr,&ii,&fe)==0 && fabsl(ii+1.0L)<1e-12L,"fft core value");
        ln_array *inv=ln_fft_fft(f,4,0,1,LN_FFT_NORM_BACKWARD,NULL,&fe);
        chk(inv!=NULL,"ifft core");
        ln_array_free(inv);ln_array_free(f);ln_array_free(x);
    }


    /* Fixed-width S/U descriptors are genuinely parametric. */
    {
        const ln_dtype_descr *s2=ln_dtype_by_name("S2"),*s5=ln_dtype_by_name("S5");
        const ln_dtype_descr *u2=ln_dtype_by_name("U2"),*u5=ln_dtype_by_name(">U5");
        chk(s2&&s5&&u2&&u5,"string dtype parse");
        chk(s2->cls==s5->cls&&s2!=s5&&s2->elsize==2&&s5->elsize==5,"bytes parametric descriptors");
        chk(u2->cls==u5->cls&&u2!=u5&&u2->elsize==8&&u5->elsize==20,"unicode parametric descriptors");
        chk(ln_common_dtype_descr(s2,s5)->elsize==5,"S common instance uses max width");
        const ln_dtype_descr *su=ln_common_dtype_descr(s2,u5);
        chk(su&&su->type_num==LN_UNICODE&&ln_string_nchars(su)==5,"S/U common dtype is Unicode max width");
        ln_intp two[]={2};ln_array *sa=ln_array_new(1,two,u2,0,1,&e);chk(sa!=NULL,e.message);
        ln_intp q[]={0};chk(ln_array_pack_string(sa,q,"é",strlen("é"),&e)==0,e.message);q[0]=1;chk(ln_array_pack_string(sa,q,"😊x",strlen("😊x"),&e)==0,e.message);
        char *got=NULL;size_t gn=0;q[0]=0;chk(ln_array_get_string(sa,q,&got,&gn,&e)==0&&strcmp(got,"é")==0,"U scalar roundtrip");free(got);
        q[0]=1;got=NULL;chk(ln_array_get_string(sa,q,&got,&gn,&e)==0&&strcmp(got,"😊x")==0,"U UCS4 roundtrip");free(got);ln_array_free(sa);
    }

    /* Descriptor-level casting policy and ndarray.astype same_value substrate. */
    {
        const ln_dtype_descr *i8=ln_dtype_by_name("int8"),*i64=ln_dtype_by_name("int64");
        const ln_dtype_descr *f32=ln_dtype_by_name("float32"),*f64=ln_dtype_by_name("float64");
        const ln_dtype_descr *dD=ln_dtype_by_name("datetime64[D]"),*dh=ln_dtype_by_name("datetime64[h]");
        ln_casting c=LN_NO_CASTING;
        chk(ln_parse_casting("safe",&c)==0&&c==LN_SAFE_CASTING,"parse safe casting");
        chk(ln_parse_casting("same_value",&c)<0,"regular casting parser rejects same_value");
        chk(ln_parse_casting_same_value("same_value",&c)==0&&c==LN_SAME_VALUE_CASTING,"astype parser accepts same_value");
        chk(ln_dtype_can_cast(i8,i64,LN_SAFE_CASTING),"int8->int64 safe");
        chk(!ln_dtype_can_cast(i64,i8,LN_SAFE_CASTING),"int64->int8 not safe");
        chk(ln_dtype_can_cast(i64,i8,LN_SAME_KIND_CASTING),"int64->int8 same kind");
        chk(ln_dtype_can_cast(dD,dh,LN_SAFE_CASTING),"datetime day->hour safe");
        chk(!ln_dtype_can_cast(dh,dD,LN_SAFE_CASTING),"datetime hour->day not safe");
        chk(ln_dtype_supports_same_value(i64,f64),"numeric same_value supported");
        chk(ln_dtype_supports_same_value(dD,dh),"safe datetime same_value supported");
        chk(!ln_dtype_supports_same_value(dh,dD),"unsafe datetime same_value rejected");
        int64_t exact=INT64_C(9007199254740992),inexact=INT64_C(9007199254740993);
        chk(ln_cast_same_value_one((const char *)&exact,i64,f64,&e)==0,"exact int64->float64 same_value");
        e.message[0]='\0';
        chk(ln_cast_same_value_one((const char *)&inexact,i64,f64,&e)<0,"inexact int64->float64 same_value fails");
        double onehalf=1.5,onetenth=1.1;
        chk(ln_cast_same_value_one((const char *)&onehalf,f64,f32,&e)==0,"exact float64->float32 same_value");
        e.message[0]='\0';
        chk(ln_cast_same_value_one((const char *)&onetenth,f64,f32,&e)<0,"rounded float64->float32 same_value fails");
    }

    /* Generic host-neutral ufunc registry metadata. */
    {
        chk(ln_ufunc_registry_count()==74,"registered builtin and extended numeric ufunc count");
        const ln_ufunc *u=ln_ufunc_by_name("frexp");
        chk(u&&u->nin==1&&u->nout==2&&u->nloops==4,"frexp registry arity/signatures");
        chk(u->loops[0].classes[0]==ln_dtype_class_by_num(LN_HALF),
            "ufunc signatures store DType classes, not descriptors");
        chk(ln_dtype_default_descr(u->loops[0].classes[2])->type_num==LN_INT,
            "class signature resolves concrete output descriptor");
        u=ln_ufunc_by_name("modf");
        chk(u&&u->nin==1&&u->nout==2,"modf registry arity");
        u=ln_ufunc_by_name("divmod");
        chk(u&&u->nin==2&&u->nout==2&&u->nloops>=14,"divmod registry arity/signatures");
        u=ln_ufunc_by_name("ldexp");
        chk(u&&u->nin==2&&u->nout==1&&u->nloops==8,"ldexp heterogeneous registry signatures");
        u=ln_ufunc_by_name("add");
        chk(u&&u->nin==2&&u->nout==1&&u->nloops>=18,"add migrated registry signatures");
        u=ln_ufunc_by_name("true_divide");
        chk(u&&u->nin==2&&u->nout==1&&u->nloops==10,"true_divide numeric, duration scaling and ratio signatures");
        chk(u->loops[7].classes[0]->legacy_type_num==LN_TIMEDELTA && u->loops[7].classes[1]->legacy_type_num==LN_DOUBLE,"timedelta division signature preserves temporal operand class");
        u=ln_ufunc_by_name("equal");
        chk(u&&u->nin==2&&u->nout==1&&u->nloops>=20,"comparison mixed-64 registry signatures");
        u=ln_ufunc_by_name("absolute");
        chk(u&&u->nin==1&&u->nout==1&&u->nloops>=18,"absolute migrated unary signatures");
        u=ln_ufunc_by_name("signbit");
        chk(u&&u->nin==1&&u->nout==1&&u->nloops>=15,"signbit migrated unary signatures");
        u=ln_ufunc_by_name("sqrt");
        chk(u&&u->nin==1&&u->nout==1&&u->nloops==7,"sqrt transcendental registry signatures");
        u=ln_ufunc_by_name("cbrt");
        chk(u&&u->nin==1&&u->nout==1&&u->nloops==4,"cbrt real-only registry signatures");
        u=ln_ufunc_by_name("arccosh");
        chk(u&&u->nin==1&&u->nout==1&&u->nloops==7,"arccosh transcendental registry signatures");
        chk(ln_ufunc_by_name("definitely_not_a_ufunc")==NULL,"unknown ufunc lookup");
    }

    /* Host-neutral concatenate/stack (source: NumPy 2.5.3 multiarraymodule.c). */
    {
        const ln_dtype_descr *i8=ln_dtype_by_name("int8");
        const ln_dtype_descr *i32=ln_dtype_by_name("int32");
        ln_intp shape[]={2};
        ln_array *aa=ln_array_new(1,shape,i8,0,1,&e);
        ln_array *bb=ln_array_new(1,shape,i32,0,1,&e);
        chk(aa!=NULL&&bb!=NULL,"join inputs allocated");
        for(int i=0;i<2;i++){
            ln_intp coord[]={i};
            chk(ln_array_pack_number(aa,coord,i+1,i+1,1,&e)==0,e.message);
            chk(ln_array_pack_number(bb,coord,i+3,i+3,1,&e)==0,e.message);
        }
        const ln_array *src[]={aa,bb};
        ln_array *cat=ln_join_arrays(src,2,0,0,NULL,LN_SAME_KIND_CASTING,NULL,&e);
        chk(cat!=NULL,e.message);
        chk(cat->nd==1&&cat->dimensions[0]==4&&cat->descr==i32,"joined shape/promotion");
        for(int i=0;i<4;i++){
            ln_intp coord[]={i}; double d=0;int64_t v=0;int isint=0;
            chk(ln_array_get_number(cat,coord,&d,&v,&isint,&e)==0,e.message);
            chk(v==i+1,"joined value order");
        }
        ln_array *stacked=ln_join_arrays(src,2,1,1,NULL,LN_SAME_KIND_CASTING,NULL,&e);
        chk(stacked!=NULL,e.message);
        chk(stacked->nd==2&&stacked->dimensions[0]==2&&stacked->dimensions[1]==2,
            "stack inserts final axis");
        ln_intp coord[]={1,1};double d=0;int64_t v=0;int isint=0;
        chk(ln_array_get_number(stacked,coord,&d,&v,&isint,&e)==0&&v==4,
            "stack row/column semantics");
        ln_array *out=ln_array_new(1,shape,i32,0,1,&e);
        const ln_array *alias[]={out};
        chk(ln_array_pack_number(out,(ln_intp[]){0},42,42,1,&e)==0,e.message);
        chk(ln_join_arrays(alias,1,0,0,NULL,LN_NO_CASTING,out,&e)==out,
            "alias-safe out uses staging");
        coord[0]=0;
        chk(ln_array_get_number(out,coord,&d,&v,&isint,&e)==0&&v==42,
            "alias-safe out retained value");
        chk(ln_join_arrays(src,2,0,0,i8,LN_SAFE_CASTING,NULL,&e)==NULL,
            "casting policy rejects unsafe narrowing");
        ln_array_free(aa);ln_array_free(bb);ln_array_free(cat);
        ln_array_free(stacked);ln_array_free(out);
    }

    /* 0.31 NumPy _shape_base_impl.py:split / array_split share base storage,
     * including negative strides and slices past either end of the axis. */
    {
        ln_intp sh[]={2,3};
        ln_array *base=ln_array_new(2,sh,ln_dtype_by_name("int64"),0,1,&e);
        chk(base!=NULL,e.message);
        for (int i=0;i<2;++i) for(int j=0;j<3;++j)
            chk(ln_array_pack_number(base,(ln_intp[]){i,j},0,i*3+j+1,1,&e)==0,e.message);
        ln_array *p=ln_split_view(base,1,1,2,&e);
        chk(p!=NULL&&p->nd==2&&p->dimensions[0]==2&&p->dimensions[1]==1,e.message);
        chk(p->owner==base->owner&&p->data==base->data+8,"split shares original buffer");
        chk(ln_array_pack_number(p,(ln_intp[]){1,0},0,99,1,&e)==0,e.message);
        int64_t value=0;double fp=0;int asint=0;
        chk(ln_array_get_number(base,(ln_intp[]){1,1},&fp,&value,&asint,&e)==0&&value==99,
            "split view mutation writes original array");
        ln_array_free(base);
        chk(ln_array_get_number(p,(ln_intp[]){1,0},&fp,&value,&asint,&e)==0&&value==99,
            "split view survives base deallocation");
        ln_array *empty=ln_split_view(p,1,10,100,&e);
        chk(empty!=NULL&&empty->dimensions[1]==0,"overlong split boundary produces empty view");
        ln_array_free(empty);
        ln_array_free(p);
        ln_intp emptyshape[]={0,4};
        base=ln_array_new(2,emptyshape,ln_dtype_by_name("float32"),0,0,&e);
        chk(base!=NULL,e.message);
        p=ln_split_view(base,0,INTPTR_MIN,INTPTR_MAX,&e);
        chk(p!=NULL&&p->dimensions[0]==0&&p->dimensions[1]==4,
            "INTP_MIN/MAX and zero-volume boundary handling");
        ln_array_free(p);ln_array_free(base);
    }

    /* 0.40: numeric/flexible DTypes share NumPy's descriptor-width rules.
     * Validate both promotion order and an actual native strided transfer. */
    {
        const ln_dtype_descr *i32 = ln_dtype_by_name("int32");
        const ln_dtype_descr *u2 = ln_dtype_by_name("U2");
        const ln_dtype_descr *s3 = ln_dtype_by_name("S3");
        const ln_dtype_descr *f64 = ln_dtype_by_name("float64");
        const ln_dtype_descr *t = ln_dtype_by_name("datetime64[D]");
        const ln_dtype_descr *uni = ln_promote_dtype(i32, u2);
        chk(uni && uni->type_num == LN_UNICODE && ln_string_nchars(uni) == 11,
            "int32 plus U2 promotes to U11");
        chk(ln_promote_dtype(u2, i32) == uni, "symmetric flexible promotion");
        const ln_dtype_descr *bytes = ln_promote_dtype(s3, f64);
        chk(bytes && bytes->type_num == LN_STRING && ln_string_nchars(bytes) == 32,
            "float64 plus S3 promotes to S32");
        chk(ln_promote_dtype(t, u2) == NULL, "datetime plus Unicode has no common DType");
        ln_intp one[]={1};
        ln_array *a=ln_array_new(1,one,i32,0,0,&e);
        ln_array *b=ln_array_new(1,one,u2,0,0,&e);
        chk(a && b,"mixed joining inputs allocate");
        chk(ln_array_pack_number(a,(ln_intp[]){0},-17,-17,1,&e)==0,e.message);
        chk(ln_string_pack_utf8(u2,b->data,"é",2,&e)==0,e.message);
        const ln_array *pair[]={a,b};
        ln_array *result=ln_join_arrays(pair,2,0,0,NULL,LN_SAME_KIND_CASTING,NULL,&e);
        chk(result && result->descr == uni && result->dimensions[0]==2,
            "mixed numeric/string join preserves promoted descriptor");
        char *text=NULL;
        chk(ln_string_unpack_utf8(uni,result->data,&text,NULL,&e)==0,e.message);
        chk(strcmp(text,"-17")==0,"numeric value formatted in Unicode output");
        free(text);text=NULL;
        chk(ln_string_unpack_utf8(uni,result->data+uni->elsize,&text,NULL,&e)==0,e.message);
        chk(strcmp(text,"é")==0,"UTF-8 string value survives mixed join");
        free(text);
        ln_array_free(a);ln_array_free(b);ln_array_free(result);
    }
    /* High-rank incompatibility diagnostics must remain in the bounded
     * buffer even when the shape representation is much longer than it. */
    {
        ln_intp shape[LN_MAXDIMS], source[LN_MAXDIMS], strides[LN_MAXDIMS], output[LN_MAXDIMS];
        for (int i=0;i<LN_MAXDIMS;++i) {
            shape[i]=123456789;source[i]=987654321;strides[i]=8;output[i]=0;
        }
        chk(ln_broadcast_strides(LN_MAXDIMS,shape,LN_MAXDIMS,source,strides,
                                 "input",output,&e)<0,
            "reject incompatible high-rank broadcasting");
        chk(strlen(e.message) < sizeof(e.message),"bounded diagnostic message");
    }

    puts("core tests: ok"); return 0;
}
