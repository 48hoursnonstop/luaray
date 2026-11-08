#include "ln_random.h"
#include <assert.h>
#include <stdint.h>
#include <stdio.h>

int main(void)
{
    const uint64_t seeds[]={0,1,42,123456789,UINT64_C(1099511627779)};
    const uint64_t first[]={
        UINT64_C(0xa30febcfd9c2825f), UINT64_C(0x8306bdf37922e4ff),
        UINT64_C(0xc621fbcd16d92688), UINT64_C(0x07182e9ce6a6f13c),
        UINT64_C(0xc60e533fbbb0872c)
    };
    for (int i=0;i<5;i++) {
        ln_pcg64 rng;ln_pcg64_seed(&rng,seeds[i]);
        assert(ln_pcg64_next64(&rng)==first[i]);
        ln_pcg64_seed(&rng,seeds[i]);
        double d=ln_pcg64_next_double(&rng);
        assert(d>=0.0 && d<1.0);
    }
    ln_pcg64 a,b;
    ln_pcg64_seed(&a,42);ln_pcg64_seed(&b,42);
    for (int i=0;i<1000;i++) (void)ln_pcg64_next64(&a);
    ln_pcg64_advance(&b,1000);
    assert(ln_pcg64_next64(&a)==ln_pcg64_next64(&b));
    /* Lemire rejection is bit-for-bit identical to NumPy's uint64 and uint32
     * samplers, including 32-bit word buffering. */
    const uint64_t integer10[]={0,7,6,4,4,8,0,6,2,0,5,9};
    ln_pcg64_seed(&a,42);
    for(size_t i=0;i<12;i++)assert(ln_pcg64_bounded64(&a,9)==integer10[i]);
    const uint32_t small16[]={1,1,12,10,12,8,4,5,1,5,0,11};
    ln_pcg64_seed(&a,42);
    uint32_t buf=0;int remaining=0;
    for(size_t i=0;i<12;i++)assert(ln_pcg64_bounded_small(&a,12,16,&buf,&remaining)==small16[i]);
    /* Advancing a PCG64 must invalidate its half-consumed uint32 cache. */
    ln_pcg64_seed(&a,42);
    assert(ln_pcg64_next32(&a)==UINT32_C(0x16d92688));
    ln_pcg64_advance(&a,0);
    assert(ln_pcg64_next32(&a)==UINT32_C(0xa791ffc1));
    ln_pcg64_seed(&a,42);
    const double normals[]={0.30471707975443135,-1.0399841062404955,0.7504511958064572};
    for(size_t i=0;i<3;i++)assert(ln_pcg64_standard_normal(&a)==normals[i]);
    ln_pcg64_seed(&a,42);
    const float normals_f[]={0.14190717041492462f,-1.6685079336166382f,-1.3321080207824707f};
    for(size_t i=0;i<3;i++)assert(ln_pcg64_standard_normal_f(&a)==normals_f[i]);
    ln_pcg64_seed(&a,42);
    const double expo[]={2.4042086039659947,2.3361896558244535,2.384760999874255};
    for(size_t i=0;i<3;i++)assert(ln_pcg64_standard_exponential(&a)==expo[i]);
    ln_pcg64_seed(&a,42);
    const float expo_f[]={0.08859460800886154f,2.997854471206665f,2.3619742393493652f};
    for(size_t i=0;i<3;i++)assert(ln_pcg64_standard_exponential_f(&a)==expo_f[i]);
    ln_pcg64_seed(&a,42);
    assert(ln_pcg64_standard_exponential_inv(&a)==1.4870258232016522);
    ln_pcg64_seed(&a,42);
    assert(ln_pcg64_standard_exponential_inv_f(&a)==0.09348785877227783f);
    puts("PCG64, bounded-integer, normal and exponential native tests passed");
    return 0;
}
