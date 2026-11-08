/* LuaRay multivariate hypergeometric distributions.
 * Based on NumPy 2.5.3 random_mvhg_marginals.c and random_mvhg_count.c,
 * BSD-3-Clause, see THIRD_PARTY_NUMPY_LICENSE.txt.
 */
#include "ln_random.h"
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

static uint64_t masked_interval(ln_pcg64 *rng, uint64_t max) {
    if (max == 0) return 0;
    uint64_t mask=max;
    mask|=mask>>1; mask|=mask>>2; mask|=mask>>4;
    mask|=mask>>8; mask|=mask>>16; mask|=mask>>32;
    if (max<=UINT32_MAX) {
        uint64_t k;
        do {k=ln_pcg64_next32(rng)&mask;} while(k>max);
        return k;
    }
    uint64_t k;
    do {k=ln_pcg64_next64(rng)&mask;} while(k>max);
    return k;
}

/* Caller guarantees 0<=nsample<=total=sum(colors), k>0,
 * total < 1e9 for the marginals algorithm and pre-zeroed out.
 * `count` may use a single work buffer shared across all output samples.
 * The buffer must NOT be reset between draws: NumPy reuses its shuffled
 * choices array, which changes the precise PCG64-to-output mapping.
 * Returns -1 on allocation failure, 0 on success.
 */
int ln_pcg64_multivariate_hypergeometric(ln_pcg64 *rng,
       const int64_t *colors, size_t k, int64_t total, int64_t nsample,
       size_t nvariates, int count_method, int64_t *out) {
    if(k==0||total==0||nsample==0||nvariates==0)return 0;
    int complement=nsample > total/2;
    if(complement)nsample=total-nsample;
    if(!count_method) {
        for(size_t i=0;i<nvariates;i++) {
            int64_t rest=total, todo=nsample;
            int64_t *dest=out+i*k;
            for(size_t j=0;todo>0 && j+1<k;j++) {
                rest-=colors[j];
                int64_t x=ln_pcg64_hypergeometric(rng,colors[j],rest,todo);
                dest[j]=x;
                todo-=x;
            }
            if(todo>0)dest[k-1]=todo;
            if(complement)for(size_t j=0;j<k;j++)dest[j]=colors[j]-dest[j];
        }
        return 0;
    }
    if((uint64_t)total>SIZE_MAX/sizeof(size_t))return -1;
    size_t *choices=malloc((size_t)total*sizeof(size_t));
    if(!choices)return -1;
    size_t off=0;
    for(size_t i=0;i<k;i++)for(int64_t j=0;j<colors[i];j++)choices[off++]=i;
    for(size_t i=0;i<nvariates;i++) {
        int64_t *dest=out+i*k;
        for(size_t j=0;j<(size_t)nsample;j++) {
            size_t target=j+(size_t)masked_interval(rng,(size_t)total-j-1);
            size_t temp=choices[target];choices[target]=choices[j];choices[j]=temp;
        }
        for(size_t j=0;j<(size_t)nsample;j++)dest[choices[j]]++;
        if(complement)for(size_t j=0;j<k;j++)dest[j]=colors[j]-dest[j];
    }
    free(choices);
    return 0;
}
