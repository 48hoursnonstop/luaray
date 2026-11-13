#include "ln_core.h"
#include <assert.h>
#include <stdio.h>
int main(void)
{
    ln_error error={0};ln_intp dims[]={4},stride[]={8};
    ln_array *a=ln_array_new(1,dims,ln_dtype_by_name("int64"),0,1,&error);assert(a);
    ln_array *b=ln_array_view(a,1,dims,stride,a->data,&error);assert(b);
    assert(ln_array_setflags(a,0,-1,&error)==0&&!a->owner->root_writeable);
    assert(b->flags&LN_ARRAY_WRITEABLE); /* Earlier views retain permission. */
    assert(ln_array_setflags(b,0,-1,&error)==0);
    int saved=b->flags;assert(ln_array_setflags(b,1,0,&error)<0&&b->flags==saved);
    assert(ln_array_setflags(a,1,-1,&error)==0&&a->owner->root_writeable);
    assert(ln_array_setflags(b,1,-1,&error)==0);
    assert(ln_array_setflags(a,0,-1,&error)==0);ln_array_free(a);
    assert(ln_array_setflags(b,1,-1,&error)<0);ln_array_free(b);
    _Alignas(int64_t) unsigned char raw[18]={0};a=ln_array_from_buffer(raw,sizeof raw,ln_dtype_by_name("int64"),2,1,1,NULL,NULL,&error);assert(a);
    assert(!(a->flags&LN_ARRAY_ALIGNED));saved=a->flags;
    assert(ln_array_setflags(a,0,1,&error)<0&&a->flags==saved);
    assert(ln_array_setflags(a,0,0,&error)==0);
    assert(ln_array_setflags(a,1,-1,&error)==0);ln_array_free(a);
    a=ln_array_from_buffer(raw,sizeof raw,ln_dtype_by_name("int64"),0,1,0,NULL,NULL,&error);assert(a);
    assert(a->flags&LN_ARRAY_ALIGNED);saved=a->flags;
    assert(ln_array_setflags(a,1,0,&error)<0&&a->flags==saved);
    assert(ln_array_setflags(a,-1,0,&error)==0&&!(a->flags&LN_ARRAY_ALIGNED));
    assert(ln_array_setflags(a,-1,1,&error)==0&&(a->flags&LN_ARRAY_ALIGNED));
    assert(ln_array_setflags(a,2,-1,&error)<0);ln_array_free(a);
    puts("flags137 native: root permissions, surviving views, alignment and failure rollback passed");return 0;
}
