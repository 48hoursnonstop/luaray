#include "ln_random.h"
#include <assert.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
/* Executable NumPy 2.3.5 reference values, generated from seed 42. */
static const double alpha_gamma[]={1,2,3};
static const double alpha_beta[]={0.01,0.02,0.03};
static const double expected_gamma[]={0x1.451881024ebb2p-2,0x1.60d152e968a34p-4,0x1.31599521ab8e0p-1,0x1.f5c31fad80f13p-3,0x1.3d4ba6ed06224p-2,0x1.c7d2c93c39653p-2,0x1.236d1965d1ad5p-7,0x1.75236cc58f0c5p-2,0x1.40e09537a1332p-1,0x1.771465428960cp-6,0x1.4dc896ccd8c6ep-2,0x1.4d63116f7f518p-1,0x1.1584905fc7fe0p-2,0x1.9f2f916a11e57p-3,0x1.0d71d37597879p-1,0x1.1085fab3b301cp-4,0x1.90a3a6d5e1601p-2,0x1.159d6d3e98efbp-1};
static const double expected_beta[]={0x1.bbf9b15715973p-14,0x1.f9affe5dc7186p-1,0x1.9088752b8bba1p-7,0x1.d219a5b911b3dp-341,0x1.d7f25b4d3c973p-9,0x1.fe280da4b2c37p-1,0x1.7ab38f17d9c49p-274,0x1.11000c6739cf9p-68,0x1.0000000000000p+0,0x1.14aff0c31b9dfp-58,0x1.ffeacc5bf0c2bp-1,0x1.533a40f3d5000p-13,0x1.3f16a106bcfedp-6,0x1.f497a5cc0ab8ep-1,0x1.6fa52bbf5f2ffp-9,0x1.f30c6086f664fp-11,0x1.d014d02fc3fc3p-1,0x1.7b7365c0d2318p-4};
static void check_sample(const double *alpha,const double *expected, uint64_t next) {
    ln_pcg64 r;ln_pcg64_seed(&r,42);
    double out[18]={0},scratch[3]={0};
    ln_pcg64_dirichlet(&r,alpha,3,6,out,scratch);
    for(int i=0;i<18;i++) assert(out[i]==expected[i]);
    for(int i=0;i<6;i++){double sum=out[3*i]+out[3*i+1]+out[3*i+2]; assert(fabs(sum-1.0)<1e-12);}
    assert(ln_pcg64_next64(&r)==next);
}
int main(void) {
    check_sample(alpha_gamma,expected_gamma,UINT64_C(13738436885815675092));
    check_sample(alpha_beta,expected_beta,UINT64_C(14358641161718733232));
    ln_pcg64 r;ln_pcg64_seed(&r,2);
    double out[3]={0},scratch[3]={0};
    const double zero[]={0,0,0};
    ln_pcg64_dirichlet(&r,zero,3,1,out,scratch);
    for(int i=0;i<3;i++)assert(out[i]==0);
    /* Degenerate all-zero concentration does not consume bits. */
    ln_pcg64 ref;ln_pcg64_seed(&ref,2);
    assert(ln_pcg64_next64(&r)==ln_pcg64_next64(&ref));
    puts("distributions69 native tests passed");
}
