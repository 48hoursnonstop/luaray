#include "ln_order.h"
#include <stdint.h>
#include <stdio.h>
/* NumPy nditer_constr.c:npyiter_find_best_axis_ordering. */
static uintmax_t magnitude(ln_intp value)
{return value<0?(uintmax_t)(-(value+1))+1:(uintmax_t)value;}
int ln_keeporder_axes(int nd,int nop,const ln_intp *const *strides,
                      int *order,ln_error *err)
{
    if(nd<0||nd>LN_MAXDIMS||nop<0||nop>LN_MAXDIMS+1||
       (nd&&!order)||(nop&&!strides)){
        if(err)snprintf(err->message,sizeof err->message,"invalid KEEPORDER plan");
        return -1;
    }
    for(int k=0;k<nop;k++)if(!strides[k]){
        if(err)snprintf(err->message,sizeof err->message,"missing operand strides");
        return -1;
    }
    for(int i=0;i<nd;i++)order[i]=nd-1-i;
    for(int i=1;i<nd;i++){
        int candidate=order[i],position=i;
        for(int j=i-1;j>=0;j--){
            int previous=order[j],ambiguous=1,swap=0;
            for(int k=0;k<nop;k++){
                ln_intp a=strides[k][candidate],b=strides[k][previous];
                if(a&&b){
                    if(magnitude(b)<=magnitude(a))swap=0;
                    else if(ambiguous)swap=1;
                    ambiguous=0;
                }
            }
            if(!ambiguous&&swap)position=j;
            else if(!ambiguous)break;
        }
        if(position!=i){for(int j=i;j>position;j--)order[j]=order[j-1];order[position]=candidate;}
    }
    return 0;
}
