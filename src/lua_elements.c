#include "lua_elements.h"
#include "lua_array_api.h"
#include "ln_write.h"
#include "ln_datetime_strings.h"
#include <stdio.h>
#include <limits.h>
#include <stdint.h>
#include <string.h>

static ln_array *input(lua_State *L)
{
    ln_array *a=ln_lua_test_array(L,1);
    if(!a)luaL_error(L,"element methods require an ndarray");
    return a;
}
static ln_intp index_at(lua_State *L,int arg,ln_intp length)
{
    if(!lua_isinteger(L,arg))luaL_error(L,"item indices must be Lua integers");
    lua_Integer value=lua_tointegerx(L,arg,NULL);
    if(value<0){if(value<-(lua_Integer)length)luaL_error(L,"item index is out of bounds");return length+(ln_intp)value;}
    if(value==0||(uint64_t)value>(uint64_t)length)luaL_error(L,"item index is out of bounds");
    return (ln_intp)value-1;
}
int ln_lua_array_item(lua_State *L)
{
    ln_array *a=input(L);int argc=lua_gettop(L)-1;
    if(argc>1)return luaL_error(L,"item accepts no index, one flat index, or one coordinate table");
    ln_intp location[LN_MAXDIMS]={0},count=ln_array_size(a);
    int table=argc==1&&lua_type(L,2)==LUA_TTABLE;
    size_t n=table?lua_rawlen(L,2):0;
    if(argc==0||(table&&n==0)){
        if(count!=1)return luaL_error(L,"item without an index requires exactly one element");
    }else if(table&&n!=1){
        if(n!=(size_t)a->nd)return luaL_error(L,"item coordinate count must equal ndim");
        for(int d=0;d<a->nd;++d){lua_geti(L,2,d+1);location[d]=index_at(L,-1,a->dimensions[d]);lua_pop(L,1);}
    }else{
        int arg=2;if(table){lua_geti(L,2,1);arg=lua_gettop(L);}
        ln_intp flat=index_at(L,arg,count);if(table)lua_pop(L,1);
        for(int d=a->nd-1;d>=0;--d){location[d]=flat%a->dimensions[d];flat/=a->dimensions[d];}
    }
    char *value=a->data;for(int d=0;d<a->nd;++d)value+=location[d]*a->strides[d];
    ln_error error={0};ln_array *scalar=ln_array_new(0,NULL,a->descr,0,0,&error);
    if(!scalar)return ln_lua_fail(L,&error);
    memcpy(scalar->data,value,a->descr->elsize);
    int preserve=a->descr->type_num==LN_LONGDOUBLE||a->descr->type_num==LN_CLONGDOUBLE;
    if(a->descr->kind=='u'&&a->descr->elsize==8){uint64_t u;memcpy(&u,value,8);if(u>INT64_MAX)preserve=1;}
    return preserve?ln_lua_push_array(L,scalar):ln_lua_push_scalar_or_array(L,scalar);
}
/* Scalar packing differs from casting a rank-zero array. NumPy temporal
 * scalar integer conversion follows its Python item representation, while
 * floating conversion uses raw ticks and text uses the scalar's display. */
static int temporal_integer_item(int64_t ticks,const ln_dtype *dtype,const ln_datetime_meta *meta,ln_error *error)
{
    if(ticks==LN_DATETIME_NAT)return 0;
    if(dtype->kind=='M'){
        if(meta->base==LN_FR_GENERIC)return 0;
        if(meta->base>LN_FR_us)return 1;
        ln_datetimestruct date;
        if(ln_datetime_value_to_struct(ticks,meta,&date,error)<0)return -1;
        return date.year<1||date.year>9999||date.sec==60;
    }
    if(meta->base>LN_FR_us||meta->base<=LN_FR_M)return 1;
    /* datetime.c's item conversion applies int64 wrapping to the multiplier
     * before deciding whether datetime.timedelta's day range can represent it. */
    uint64_t bits=(uint64_t)ticks*(uint64_t)meta->num;int64_t scaled;memcpy(&scaled,&bits,8);
    if(meta->base==LN_FR_W){bits=(uint64_t)scaled*7;memcpy(&scaled,&bits,8);}
    int64_t divisor=1;
    switch(meta->base){
      case LN_FR_h:divisor=24;break;
      case LN_FR_m:divisor=1440;break;
      case LN_FR_s:divisor=86400;break;
      case LN_FR_ms:divisor=86400000;break;
      case LN_FR_us:divisor=86400000000LL;break;
      default:break;
    }
    int64_t days=scaled/divisor;if(scaled<0&&scaled%divisor)--days;
    return days< -999999999||days>999999999;
}
static ln_array *temporal_fill_value(lua_State *L,const ln_array *destination,int *argument)
{
    const ln_dtype *dtype=ln_lua_temporal_scalar_dtype(L,2);
    if(!dtype)return NULL;
    ln_array *value=ln_lua_legacy_array(L,2,NULL);int64_t ticks;memcpy(&ticks,value->data,8);
    const ln_datetime_meta *meta=ln_datetime_metadata(dtype);
    const ln_dtype *target=destination->descr;
    if(target->kind=='S'||target->kind=='U'){
        char text[192];ln_error error={0};
        if(dtype->kind=='M'){
            if(ln_datetime_format_iso8601(ticks,meta,meta->base,0,LN_DT_TZ_NAIVE,0,LN_DT_CAST_SAME_KIND,text,sizeof text,&error)<0)
                ln_lua_fail(L,&error);
        }else return value; /* timedelta uses its ordinary native string cast. */
        lua_pushstring(L,text);*argument=lua_gettop(L);return NULL;
    }
    if(target->kind=='i'){
        ln_error error={0};int integer_item=temporal_integer_item(ticks,dtype,meta,&error);
        if(integer_item<0)ln_lua_fail(L,&error);
        if(!integer_item)luaL_error(L,"temporal scalar does not have an integer item representation");
        lua_pushinteger(L,(lua_Integer)ticks);*argument=lua_gettop(L);return NULL;
    }
    if((target->kind=='m'||target->kind=='M')&&(target->kind!=dtype->kind||ticks==LN_DATETIME_NAT)){
        ln_error error={0};ln_array *raw=ln_array_view(value,0,NULL,NULL,value->data,&error);
        if(!raw){ln_lua_fail(L,&error);return NULL;}
        raw->descr=target;ln_lua_push_array(L,raw);return raw;
    }
    if(target->kind=='m'&&dtype->kind=='m'&&ticks!=LN_DATETIME_NAT&&
       !ln_datetime_can_cast_same_kind(meta,ln_datetime_metadata(target),1))
        luaL_error(L,"temporal scalar units cannot be assigned under same_kind casting");
    if(target->kind=='M'&&dtype->kind=='M'&&(meta->base!=ln_datetime_metadata(target)->base||meta->num!=ln_datetime_metadata(target)->num)){
        ln_error error={0};ln_datetimestruct calendar;int64_t converted;
        if(ln_datetime_value_to_struct(ticks,meta,&calendar,&error)<0||
           ln_datetime_struct_to_value(&calendar,ln_datetime_metadata(target),&converted,&error)<0)
            ln_lua_fail(L,&error);
        value=ln_array_new(0,NULL,target,0,0,&error);
        if(!value){ln_lua_fail(L,&error);return NULL;}
        memcpy(value->data,&converted,8);ln_lua_push_array(L,value);
    }
    return value;
}
int ln_lua_array_fill(lua_State *L)
{
    ln_array *a=input(L);
    if(lua_gettop(L)!=2)return luaL_error(L,"fill requires exactly one scalar value");
    if(!(a->flags&LN_ARRAY_WRITEABLE))return luaL_error(L,"fill destination is read-only");
    ln_array *source=ln_lua_test_array(L,2);int argument=2;
    if(!source)source=temporal_fill_value(L,a,&argument);
    ln_error error={0};
    if(a->descr->type_num==LN_BOOL&&lua_type(L,2)==LUA_TTABLE){
        /* Boolean scalar packing uses sequence truth, not array broadcasting. */
        lua_pushboolean(L,lua_rawlen(L,2)!=0);argument=lua_gettop(L);
    }else if(lua_type(L,2)==LUA_TTABLE)return luaL_error(L,"fill requires a scalar rather than a sequence");
    if(source&&source->nd!=0){
        if(a->descr->type_num!=LN_BOOL||ln_array_size(source)!=1)
            return luaL_error(L,"fill requires a scalar rather than an ambiguous array");
        source=ln_array_view(source,0,NULL,NULL,source->data,&error);
        if(!source)return ln_lua_fail(L,&error);
        ln_lua_push_array(L,source);
    }
    if(!source)source=ln_lua_assignment_values(L,argument,a->descr);
    if(source->nd!=0)return luaL_error(L,"fill requires a scalar value");
    /* Pack once before examining destination size or writing aliases, just as
     * PyArray_FillWithScalar does. Invalid values still raise on empty arrays. */
    ln_array *packed=ln_array_new(0,NULL,a->descr,0,0,&error);
    if(!packed)return ln_lua_fail(L,&error);
    int status=ln_array_copyto(packed,source,NULL,1,LN_UNSAFE_CASTING,&error);
    if(status==0)status=ln_array_copyto(a,packed,NULL,1,LN_UNSAFE_CASTING,&error);
    ln_array_free(packed);
    if(status<0)return ln_lua_fail(L,&error);
    return 0;
}
