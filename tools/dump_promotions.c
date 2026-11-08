#include "ln_core.h"
#include <stdio.h>
int main(void) {
    const char *names[] = {"bool","int8","uint8","int16","uint16","int32","uint32","int64","uint64","float16","float32","float64","longdouble",NULL};
    for (int i=0; names[i]; i++) for (int j=0; names[j]; j++) {
        const ln_dtype *a=ln_dtype_by_name(names[i]), *b=ln_dtype_by_name(names[j]);
        const ln_dtype *r=ln_promote_dtype(a,b);
        printf("%s,%s,%s\n",names[i],names[j],r?r->name:"ERROR");
    }
    return 0;
}
