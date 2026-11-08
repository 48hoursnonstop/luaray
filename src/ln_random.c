#include "ln_random.h"
#include <math.h>
#include <stdlib.h>
#include "third_party/numpy_ziggurat_constants.h"

/* Native SeedSequence mixing, derived from NumPy's documented constants and
 * algorithms. The generated PCG64 stream is the same for supported seeds.
 * See NUMPY_2_5_3_RANDOM_FILE_HASHES.sha256 and THIRD_PARTY_NUMPY_LICENSE.txt.
 */

static uint32_t seed_hash(uint32_t value, uint32_t *constant)
{
    value ^= *constant;
    *constant *= UINT32_C(0x931e8875);
    value *= *constant;
    return value ^ (value >> 16);
}

static uint32_t seed_mix(uint32_t left, uint32_t right)
{
    uint32_t value = UINT32_C(0xca01f9dd)*left - UINT32_C(0x4973f715)*right;
    return value ^ (value >> 16);
}

void ln_pcg64_seed(ln_pcg64 *rng, uint64_t seed)
{
    rng->has_uint32=0;
    rng->cached_uint32=0;
    uint32_t pool[4], entropy[2] = {(uint32_t)seed, (uint32_t)(seed >> 32)};
    const int entropy_size = seed > UINT32_MAX ? 2 : 1;
    uint32_t hash = UINT32_C(0x43b0d7e5);
    for (int i=0;i<4;i++)
        pool[i] = seed_hash(i<entropy_size?entropy[i]:0,&hash);
    for (int source=0;source<4;source++)
        for (int target=0;target<4;target++)
            if (source!=target)
                pool[target] = seed_mix(pool[target],seed_hash(pool[source],&hash));
    hash = UINT32_C(0x8b51f9dd);
    uint32_t words[8];
    for (int i=0;i<8;i++) {
        uint32_t value=pool[i%4]^hash;
        hash*=UINT32_C(0x58f38ded);
        value*=hash;
        words[i]=value^(value>>16);
    }
    uint64_t states[4];
    for (int i=0;i<4;i++)
        states[i]=(uint64_t)words[i*2] | ((uint64_t)words[i*2+1]<<32);
    const __uint128_t initstate=((__uint128_t)states[0]<<64)|states[1];
    const __uint128_t initseq=((__uint128_t)states[2]<<64)|states[3];
    const __uint128_t mult=((__uint128_t)UINT64_C(2549297995355413924)<<64)
                           | UINT64_C(4865540595714422341);
    rng->increment=(initseq<<1)|1;
    rng->state=rng->increment;
    rng->state=rng->state+initstate;
    rng->state=rng->state*mult+rng->increment;
}

uint64_t ln_pcg64_next64(ln_pcg64 *rng)
{
    const __uint128_t mult=((__uint128_t)UINT64_C(2549297995355413924)<<64)
                           | UINT64_C(4865540595714422341);
    rng->state=rng->state*mult+rng->increment;
    uint64_t high=(uint64_t)(rng->state>>64);
    uint64_t x=high^(uint64_t)rng->state;
    unsigned int r=(unsigned int)(rng->state>>122);
    return (x>>r)|(x<<((-r)&63));
}

double ln_pcg64_next_double(ln_pcg64 *rng)
{
    return (ln_pcg64_next64(rng)>>11)*0x1.0p-53;
}

void ln_pcg64_advance(ln_pcg64 *rng,uint64_t delta)
{
    rng->has_uint32=0;
    rng->cached_uint32=0;
    const __uint128_t mult=((__uint128_t)UINT64_C(2549297995355413924)<<64)
                           | UINT64_C(4865540595714422341);
    __uint128_t acc_mult=1,acc_plus=0,cur_mult=mult,cur_plus=rng->increment;
    while (delta) {
        if(delta&1) {acc_mult*=cur_mult; acc_plus=acc_plus*cur_mult+cur_plus;}
        cur_plus=(cur_mult+1)*cur_plus;
        cur_mult*=cur_mult;
        delta>>=1;
    }
    rng->state=acc_mult*rng->state+acc_plus;
}

/* PCG64's 32-bit output consumes the lower half first, then reuses
 * the upper half. PCG64 raw/float64 output does not consume this cache. */
uint32_t ln_pcg64_next32(ln_pcg64 *rng)
{
    if(rng->has_uint32){rng->has_uint32=0;return rng->cached_uint32;}
    uint64_t value=ln_pcg64_next64(rng);
    rng->cached_uint32=(uint32_t)(value>>32);
    rng->has_uint32=1;
    return (uint32_t)value;
}

uint32_t ln_pcg64_bounded32(ln_pcg64 *rng, uint32_t inclusive_range)
{
    if(!inclusive_range)return 0;
    if(inclusive_range==UINT32_MAX)return ln_pcg64_next32(rng);
    uint32_t exclusive=inclusive_range+1;
    uint64_t product=(uint64_t)ln_pcg64_next32(rng)*exclusive;
    uint32_t remainder=(uint32_t)product;
    if(remainder<exclusive){
        uint32_t threshold=(UINT32_MAX-inclusive_range)%exclusive;
        while(remainder<threshold){product=(uint64_t)ln_pcg64_next32(rng)*exclusive;remainder=(uint32_t)product;}
    }
    return (uint32_t)(product>>32);
}

uint64_t ln_pcg64_bounded64(ln_pcg64 *rng, uint64_t inclusive_range)
{
    if(!inclusive_range)return 0;
    if(inclusive_range<=UINT32_MAX)return ln_pcg64_bounded32(rng,(uint32_t)inclusive_range);
    if(inclusive_range==UINT64_MAX)return ln_pcg64_next64(rng);
    uint64_t exclusive=inclusive_range+1;
    __uint128_t product=(__uint128_t)ln_pcg64_next64(rng)*exclusive;
    uint64_t remainder=(uint64_t)product;
    if(remainder<exclusive){
        uint64_t threshold=(UINT64_MAX-inclusive_range)%exclusive;
        while(remainder<threshold){product=(__uint128_t)ln_pcg64_next64(rng)*exclusive;remainder=(uint64_t)product;}
    }
    return (uint64_t)(product>>64);
}

/* NumPy 2.5.3 random_interval: masked rejection, not Lemire bounded integers.
 * A max of zero consumes no state, and <= UINT32_MAX uses cached uint32.
 * This function is required for bit-for-bit shuffle/permutation order. */
uint64_t ln_pcg64_interval(ln_pcg64 *rng, uint64_t max)
{
    if(max==0)return 0;
    uint64_t mask=max;
    mask|=mask>>1; mask|=mask>>2; mask|=mask>>4;
    mask|=mask>>8; mask|=mask>>16; mask|=mask>>32;
    uint64_t v;
    if(max<=UINT32_MAX){
        do {v=(uint64_t)ln_pcg64_next32(rng)&mask;} while(v>max);
    }else{
        do {v=ln_pcg64_next64(rng)&mask;} while(v>max);
    }
    return v;
}

uint32_t ln_pcg64_bounded_small(ln_pcg64 *rng, uint32_t range, unsigned bits, uint32_t *buf, int *remaining)
{
    if(!range)return 0;
    const uint32_t max=(UINT32_C(1)<<bits)-1;
    const uint32_t exclusive=range+1;
    uint32_t threshold=(max-range)%exclusive;
    for(;;){
        if(!*remaining){*buf=ln_pcg64_next32(rng);*remaining=32/(int)bits-1;}
        else {*buf>>=bits;--*remaining;}
        uint32_t value=*buf&max;
        if(range==max)return value;
        uint32_t product=value*exclusive;
        if((product&max)>=threshold)return product>>bits;
    }
}

/* Ziggurat normal sampler using the same 256-table layout and PCG64 bit
 * consumption as NumPy 2.5.3. NumPy Developers BSD-3-Clause applies to the
 * upstream constants and algorithm; see THIRD_PARTY_NUMPY_LICENSE.txt. */
double ln_pcg64_standard_normal(ln_pcg64 *rng)
{
    for (;;) {
        uint64_t r = ln_pcg64_next64(rng);
        int idx = (int)(r & 255);
        r >>= 8;
        int sign = (int)(r & 1);
        uint64_t magnitude = (r >> 1) & UINT64_C(0x000fffffffffffff);
        double x = (double)magnitude * wi_double[idx];
        if (sign) x = -x;
        if (magnitude < ki_double[idx]) return x;
        if (!idx) {
            for (;;) {
                double xx = -ziggurat_nor_inv_r * log1p(-ln_pcg64_next_double(rng));
                double yy = -log1p(-ln_pcg64_next_double(rng));
                if (yy + yy > xx * xx)
                    return ((magnitude >> 8) & 1) ? -(ziggurat_nor_r + xx) : ziggurat_nor_r + xx;
            }
        } else {
            if ((fi_double[idx-1] - fi_double[idx]) * ln_pcg64_next_double(rng)
                + fi_double[idx] < exp(-0.5 * x * x)) return x;
        }
    }
}

float ln_pcg64_standard_normal_f(ln_pcg64 *rng)
{
    for (;;) {
        uint32_t r = ln_pcg64_next32(rng);
        int idx = (int)(r & 255);
        int sign = (int)((r >> 8) & 1);
        uint32_t magnitude = (r >> 9) & UINT32_C(0x0007fffff);
        float x = (float)magnitude * wi_float[idx];
        if (sign) x = -x;
        if (magnitude < ki_float[idx]) return x;
        if (!idx) {
            for (;;) {
                float u1 = (float)(ln_pcg64_next32(rng) >> 8) * (1.0f / 16777216.0f);
                float u2 = (float)(ln_pcg64_next32(rng) >> 8) * (1.0f / 16777216.0f);
                float xx = -ziggurat_nor_inv_r_f * log1pf(-u1);
                float yy = -log1pf(-u2);
                if (yy + yy > xx * xx)
                    return ((magnitude >> 8) & 1) ? -(ziggurat_nor_r_f + xx) : ziggurat_nor_r_f + xx;
            }
        } else {
            float u = (float)(ln_pcg64_next32(rng) >> 8) * (1.0f / 16777216.0f);
            if (((fi_float[idx-1] - fi_float[idx]) * u + fi_float[idx]) < expf(-0.5f * x * x)) return x;
        }
    }
}

/* Exponential distribution: NumPy's 256-entry Ziggurat, including
 * the exact consumption of PCG64 uint32 and uint64 words. */
double ln_pcg64_standard_exponential(ln_pcg64 *rng)
{
    for (;;) {
        uint64_t r = ln_pcg64_next64(rng) >> 3;
        int idx = (int)(r & 255);
        r >>= 8;
        double x = (double)r * we_double[idx];
        if (r < ke_double[idx]) return x;
        if (idx == 0) return ziggurat_exp_r - log1p(-ln_pcg64_next_double(rng));
        if ((fe_double[idx-1] - fe_double[idx]) * ln_pcg64_next_double(rng)
             + fe_double[idx] < exp(-x)) return x;
    }
}

float ln_pcg64_standard_exponential_f(ln_pcg64 *rng)
{
    for (;;) {
        uint32_t r = ln_pcg64_next32(rng) >> 1;
        int idx = (int)(r & 255);
        r >>= 8;
        float x = (float)r * we_float[idx];
        if (r < ke_float[idx]) return x;
        float u = (float)(ln_pcg64_next32(rng) >> 8) * (1.0f / 16777216.0f);
        if (idx == 0) return ziggurat_exp_r_f - log1pf(-u);
        if ((fe_float[idx-1] - fe_float[idx]) * u
             + fe_float[idx] < expf(-x)) return x;
    }
}

double ln_pcg64_standard_exponential_inv(ln_pcg64 *rng)
{
    return -log1p(-ln_pcg64_next_double(rng));
}

float ln_pcg64_standard_exponential_inv_f(ln_pcg64 *rng)
{
    float u = (float)(ln_pcg64_next32(rng) >> 8) * (1.0f / 16777216.0f);
    return -log1pf(-u);
}

/* NumPy 2.5.3 distributions.c algorithms. All draws consume the existing
 * PCG64 stream, including draws at zero scale. */
double ln_pcg64_lognormal(ln_pcg64 *rng, double mean, double sigma)
{
    return exp(mean + sigma * ln_pcg64_standard_normal(rng));
}

double ln_pcg64_standard_cauchy(ln_pcg64 *rng)
{
    double a = ln_pcg64_standard_normal(rng);
    double b = ln_pcg64_standard_normal(rng);
    return a / b;
}

double ln_pcg64_laplace(ln_pcg64 *rng, double loc, double scale)
{
    double u;
    do { u = ln_pcg64_next_double(rng); } while (u == 0.0);
    if (u >= 0.5) return loc - scale * log(2.0 - u - u);
    return loc + scale * log(u + u);
}

/* These formulas follow numpy/random/src/distributions/distributions.c (2.5.3).
 * In particular, zero-shape Weibull consumes no bits; zero-scale Gumbel,
 * logistic and Rayleigh do consume bits. */
double ln_pcg64_gumbel(ln_pcg64 *rng, double loc, double scale)
{
    double u;
    do { u = 1.0 - ln_pcg64_next_double(rng); } while (u == 1.0);
    return loc - scale * log(-log(u));
}

double ln_pcg64_logistic(ln_pcg64 *rng, double loc, double scale)
{
    double u;
    do { u = ln_pcg64_next_double(rng); } while (u == 0.0);
    return loc + scale * log(u / (1.0 - u));
}

double ln_pcg64_rayleigh(ln_pcg64 *rng, double scale)
{
    return scale * sqrt(2.0 * ln_pcg64_standard_exponential(rng));
}

double ln_pcg64_weibull(ln_pcg64 *rng, double a)
{
    if (a == 0.0) return 0.0;
    return pow(ln_pcg64_standard_exponential(rng), 1.0 / a);
}

/* NumPy 2.5.3 random/src/distributions/distributions.c.  The exponential
 * source is Ziggurat, not an inverse-CDF substitute, so the bit consumption
 * remains identical to Generator.pareto and Generator.power. */
double ln_pcg64_pareto(ln_pcg64 *rng, double a)
{
    return expm1(ln_pcg64_standard_exponential(rng) / a);
}

double ln_pcg64_power(ln_pcg64 *rng, double a)
{
    return pow(-expm1(-ln_pcg64_standard_exponential(rng)), 1.0 / a);
}

double ln_pcg64_triangular(ln_pcg64 *rng, double left, double mode, double right)
{
    double base = right-left;
    double leftbase = mode-left;
    double ratio = leftbase/base;
    double leftprod = leftbase*base;
    double rightprod = (right-mode)*base;
    double u = ln_pcg64_next_double(rng);
    if(u <= ratio) return left + sqrt(u*leftprod);
    return right - sqrt((1.0-u)*rightprod);
}

/* Scalar algorithms from NumPy 2.5.3 random/src/distributions/distributions.c.
 * Preserve drawing order and floating point expression evaluation. */
double ln_pcg64_standard_gamma(ln_pcg64 *rng, double shape)
{
    double b,c,U,V,X,Y;
    if (shape==1.0) return ln_pcg64_standard_exponential(rng);
    if (shape==0.0) return 0.0;
    if (shape<1.0) {
        for (;;) {
            U=ln_pcg64_next_double(rng);
            V=ln_pcg64_standard_exponential(rng);
            if (U<=1.0-shape) {
                X=pow(U,1. / shape);
                if (X<=V) return X;
            } else {
                Y=-log((1-U)/shape);
                X=pow(1.0-shape+shape*Y,1. / shape);
                if (X<=(V+Y)) return X;
            }
        }
    }
    b=shape-1. / 3.; c=1. / sqrt(9*b);
    for (;;) {
        do { X=ln_pcg64_standard_normal(rng); V=1.0+c*X; } while(V<=0.0);
        V=V*V*V;
        U=ln_pcg64_next_double(rng);
        if (U<1.0-0.0331*(X*X)*(X*X)) return b*V;
        if (log(U)<0.5*X*X+b*(1.-V+log(V))) return b*V;
    }
}

/* Float32 draws use the independent NumPy float32 RNG bit stream. */
static float ln_pcg64_next_float(ln_pcg64 *rng)
{
    return (float)(ln_pcg64_next32(rng)>>8)*(1.0f/16777216.0f);
}
float ln_pcg64_standard_gamma_f(ln_pcg64 *rng, float shape)
{
    float b,c,U,V,X,Y;
    if (shape==1.0f) return ln_pcg64_standard_exponential_f(rng);
    if (shape==0.0f) return 0.0f;
    if (shape<1.0f) {
        for (;;) {
            U=ln_pcg64_next_float(rng);
            V=ln_pcg64_standard_exponential_f(rng);
            if (U<=1.0f-shape) {
                X=powf(U,1.0f/shape);
                if (X<=V) return X;
            } else {
                Y=-logf((1.0f-U)/shape);
                X=powf(1.0f-shape+shape*Y,1.0f/shape);
                if (X<=(V+Y)) return X;
            }
        }
    }
    b=shape-1.0f/3.0f; c=1.0f/sqrtf(9.0f*b);
    for (;;) {
        do { X=ln_pcg64_standard_normal_f(rng); V=1.0f+c*X; } while(V<=0.0f);
        V=V*V*V;
        U=ln_pcg64_next_float(rng);
        if (U<1.0f-0.0331f*(X*X)*(X*X)) return b*V;
        if (logf(U)<0.5f*X*X+b*(1.0f-V+logf(V))) return b*V;
    }
}

double ln_pcg64_gamma(ln_pcg64 *rng,double shape,double scale)
{ return scale*ln_pcg64_standard_gamma(rng,shape); }


/* NumPy 2.5.3 random/src/distributions/distributions.c:
 * random_chisquare / random_f. Do not algebraically reorder either expression:
 * preserving rounding and the Gamma consumption order matters for fidelity. */
double ln_pcg64_chisquare(ln_pcg64 *rng, double df)
{
    return 2.0 * ln_pcg64_standard_gamma(rng, df / 2.0);
}

double ln_pcg64_f(ln_pcg64 *rng, double dfnum, double dfden)
{
    double subexpr1 = ln_pcg64_chisquare(rng, dfnum) * dfden;
    double subexpr2 = ln_pcg64_chisquare(rng, dfden) * dfnum;
    return subexpr1 / subexpr2;
}

/* NumPy 2.5.3 random/src/distributions/distributions.c:
 * Hoermann PTRS Poisson + multiplicative Poisson and the two-branch
 * noncentral chi-square/F samplers.  Keep the original floating-point
 * expression order to preserve PCG64 consumption and numerical results. */
static double ln_random_loggam(double x)
{
    double x0,x2,lg2pi,gl,gl0;
    int64_t k,n;
    static const double a[10]={8.333333333333333e-02,-2.777777777777778e-03,
        7.936507936507937e-04,-5.952380952380952e-04,
        8.417508417508418e-04,-1.917526917526918e-03,
        6.410256410256410e-03,-2.955065359477124e-02,
        1.796443723688307e-01,-1.39243221690590e+00};
    if (x==1.0||x==2.0) return 0.0;
    else if(x<7.0)n=(int64_t)(7-x);
    else n=0;
    x0=x+n;
    x2=(1.0/x0)*(1.0/x0);
    lg2pi=1.8378770664093453e+00;
    gl0=a[9];
    for(k=8;k>=0;k--){gl0*=x2;gl0+=a[k];}
    gl=gl0/x0+0.5*lg2pi+(x0-0.5)*log(x0)-x0;
    if(x<7.0)for(k=1;k<=n;k++){gl-=log(x0-1.0);x0-=1.0;}
    return gl;
}

static int64_t ln_pcg64_poisson_mult(ln_pcg64 *rng,double lam)
{
    int64_t X=0;
    double enlam=exp(-lam),prod=1.0;
    for(;;){
        double U=ln_pcg64_next_double(rng);
        prod*=U;
        if(prod>enlam)X++;
        else return X;
    }
}

static int64_t ln_pcg64_poisson_ptrs(ln_pcg64 *rng,double lam)
{
    double slam=sqrt(lam),loglam=log(lam);
    double b=0.931+2.53*slam;
    double a=-0.059+0.02483*b;
    double invalpha=1.1239+1.1328/(b-3.4);
    double vr=0.9277-3.6224/(b-2);
    for(;;){
        double U=ln_pcg64_next_double(rng)-0.5;
        double V=ln_pcg64_next_double(rng);
        double us=0.5-fabs(U);
        double estimate=floor((2*a/us+b)*U+lam+0.43);
        /* Public API bounds the intensity, so the conversion is safe. */
        int64_t k=(int64_t)estimate;
        if(us>=0.07&&V<=vr)return k;
        if(k<0||(us<0.013&&V>us))continue;
        if(log(V)+log(invalpha)-log(a/(us*us)+b)
             <=-lam+(double)k*loglam-ln_random_loggam((double)k+1))return k;
    }
}

int64_t ln_pcg64_poisson(ln_pcg64 *rng,double lam)
{
    if(lam>=10.0)return ln_pcg64_poisson_ptrs(rng,lam);
    if(lam==0.0)return 0;
    return ln_pcg64_poisson_mult(rng,lam);
}

/* NumPy 2.5.3 negative_binomial draws Gamma even if p == 1.0.
 * The Lua entrypoint bounds n and p to keep Gamma/Poisson conversion safe. */
int64_t ln_pcg64_negative_binomial(ln_pcg64 *rng, double n, double p)
{
    double y = ln_pcg64_gamma(rng, n, (1.0 - p) / p);
    return ln_pcg64_poisson(rng, y);
}

/* NumPy 2.5.3 random_geometric_search / random_geometric_inversion.
 * The search path always draws one uniform, including p == 1. */
int64_t ln_pcg64_geometric(ln_pcg64 *rng, double p)
{
    if (p >= 0.333333333333333333333333) {
        double prod=p, sum=p, q=1.0-p;
        double u=ln_pcg64_next_double(rng);
        int64_t x=1;
        while(u>sum) {
            prod*=q;
            sum+=prod;
            x++;
        }
        return x;
    }
    double z=ceil(-ln_pcg64_standard_exponential(rng)/log1p(-p));
    if(z >= 9.223372036854776e+18) return INT64_MAX;
    return (int64_t)z;
}

double ln_pcg64_noncentral_chisquare(ln_pcg64 *rng,double df,double nonc)
{
    if(isnan(nonc))return NAN;
    if(nonc==0.0)return ln_pcg64_chisquare(rng,df);
    if(1.0<df){
        const double Chi2=ln_pcg64_chisquare(rng,df-1.0);
        const double n=ln_pcg64_standard_normal(rng)+sqrt(nonc);
        return Chi2+n*n;
    }
    const int64_t i=ln_pcg64_poisson(rng,nonc/2.0);
    return ln_pcg64_chisquare(rng,df+2*i);
}

double ln_pcg64_noncentral_f(ln_pcg64 *rng,double dfnum,double dfden,double nonc)
{
    double t=ln_pcg64_noncentral_chisquare(rng,dfnum,nonc)*dfden;
    return t/(ln_pcg64_chisquare(rng,dfden)*dfnum);
}

double ln_pcg64_beta(ln_pcg64 *rng,double a,double b)
{
    if (a<=1.0 && b<=1.0) {
        double U,V,X,Y,XpY;
        if (a<3e-103 && b<3e-103) {
            U=ln_pcg64_next_double(rng);
            return (a+b)*U<a;
        }
        for (;;) {
            U=ln_pcg64_next_double(rng);
            V=ln_pcg64_next_double(rng);
            X=pow(U,1.0/a);
            Y=pow(V,1.0/b);
            XpY=X+Y;
            if(XpY<=1.0 && U+V>0.0) {
                if(X>0 && Y>0) return X/XpY;
                double logX=log(U)/a;
                double logY=log(V)/b;
                double delta=logX-logY;
                if(delta>0) return exp(-log1p(exp(-delta)));
                else return exp(delta-log1p(exp(delta)));
            }
        }
    }
    double Ga=ln_pcg64_standard_gamma(rng,a);
    double Gb=ln_pcg64_standard_gamma(rng,b);
    return Ga/(Ga+Gb);
}

/* Binomial inversion and BTPE adapted from NumPy 2.5.3,
 * numpy/random/src/distributions/distributions.c; see bundled BSD license.
 * The Lua adapter validates 0 <= n <= 1e12, 0 <= p <= 1.
 */
typedef struct ln_binomial_cache {
    int has_binomial;
    int64_t nsave, m;
    double psave, r, q, fm, p1, xm, xl, xr, c, laml, lamr, p2, p3, p4;
} ln_binomial_cache;

int64_t ln_binomial_btpe(ln_pcg64 *rng, int64_t n,
                                   double p, ln_binomial_cache *binomial) {
  double r, q, fm, p1, xm, xl, xr, c, laml, lamr, p2, p3, p4;
  double a, u, v, s, F, rho, t, A, nrq, x1, x2, f1, f2, z, z2, w, w2, x;
  int64_t m, y, k, i;

  if (!(binomial->has_binomial) || (binomial->nsave != n) ||
      (binomial->psave != p)) {
    /* initialize */
    binomial->nsave = n;
    binomial->psave = p;
    binomial->has_binomial = 1;
    binomial->r = r = fmin(p, 1.0 - p);
    binomial->q = q = 1.0 - r;
    binomial->fm = fm = n * r + r;
    binomial->m = m = (int64_t)floor(binomial->fm);
    binomial->p1 = p1 = floor(2.195 * sqrt(n * r * q) - 4.6 * q) + 0.5;
    binomial->xm = xm = m + 0.5;
    binomial->xl = xl = xm - p1;
    binomial->xr = xr = xm + p1;
    binomial->c = c = 0.134 + 20.5 / (15.3 + m);
    a = (fm - xl) / (fm - xl * r);
    binomial->laml = laml = a * (1.0 + a / 2.0);
    a = (xr - fm) / (xr * q);
    binomial->lamr = lamr = a * (1.0 + a / 2.0);
    binomial->p2 = p2 = p1 * (1.0 + 2.0 * c);
    binomial->p3 = p3 = p2 + c / laml;
    binomial->p4 = p4 = p3 + c / lamr;
  } else {
    r = binomial->r;
    q = binomial->q;
    fm = binomial->fm;
    m = binomial->m;
    p1 = binomial->p1;
    xm = binomial->xm;
    xl = binomial->xl;
    xr = binomial->xr;
    c = binomial->c;
    laml = binomial->laml;
    lamr = binomial->lamr;
    p2 = binomial->p2;
    p3 = binomial->p3;
    p4 = binomial->p4;
  }

/* sigh ... */
Step10:
  nrq = n * r * q;
  u = ln_pcg64_next_double(rng) * p4;
  v = ln_pcg64_next_double(rng);
  if (u > p1)
    goto Step20;
  y = (int64_t)floor(xm - p1 * v + u);
  goto Step60;

Step20:
  if (u > p2)
    goto Step30;
  x = xl + (u - p1) / c;
  v = v * c + 1.0 - fabs(m - x + 0.5) / p1;
  if (v > 1.0)
    goto Step10;
  y = (int64_t)floor(x);
  goto Step50;

Step30:
  if (u > p3)
    goto Step40;
  if (v == 0.0) goto Step10; /* avoid float-to-integer of infinity */
  y = (int64_t)floor(xl + log(v) / laml);
  if (y < 0)
    goto Step10;
  v = v * (u - p2) * laml;
  goto Step50;

Step40:
  if (v == 0.0) goto Step10;
  y = (int64_t)floor(xr - log(v) / lamr);
  if (y > n)
    goto Step10;
  v = v * (u - p3) * lamr;

Step50:
  k = llabs(y - m);
  if ((k > 20) && (k < ((nrq) / 2.0 - 1)))
    goto Step52;

  s = r / q;
  a = s * (n + 1);
  F = 1.0;
  if (m < y) {
    for (i = m + 1; i <= y; i++) {
      F *= (a / i - s);
    }
  } else if (m > y) {
    for (i = y + 1; i <= m; i++) {
      F /= (a / i - s);
    }
  }
  if (v > F)
    goto Step10;
  goto Step60;

Step52:
  rho =
      (k / (nrq)) * ((k * (k / 3.0 + 0.625) + 0.16666666666666666) / nrq + 0.5);
  t = -k * k / (2 * nrq);
  /* log(0.0) ok here */
  A = log(v);
  if (A < (t - rho))
    goto Step60;
  if (A > (t + rho))
    goto Step10;

  x1 = (double)y + 1;
  f1 = (double)m + 1;
  z = (double)n + 1 - (double)m;
  w = (double)n - (double)y + 1;
  x2 = x1 * x1;
  f2 = f1 * f1;
  z2 = z * z;
  w2 = w * w;
  /*
   * Note that the third and fourth error terms are subtracted.
   * This is a correction from the original 1988 paper
   * (Kachitvichyanukul & Schmeiser) which erroneously adds
   * all four terms
   */
  if (A > (xm * log(f1 / x1) + (n - m + 0.5) * log(z / w) +
           (y - m) * log(w * r / (x1 * q)) +
           (13860. - (462. - (132. - (99. - 140. / f2) / f2) / f2) / f2) / f1 /
               166320. +
           (13860. - (462. - (132. - (99. - 140. / z2) / z2) / z2) / z2) / z /
               166320. -
           (13860. - (462. - (132. - (99. - 140. / x2) / x2) / x2) / x2) / x1 /
               166320. -
           (13860. - (462. - (132. - (99. - 140. / w2) / w2) / w2) / w2) / w /
               166320.)) {
    goto Step10;
  }

Step60:
  if (p > 0.5) {
    y = n - y;
  }

  return y;
}

int64_t ln_binomial_inversion(ln_pcg64 *rng, int64_t n,
                                        double p, ln_binomial_cache *binomial) {
  double q, qn, np, px, U;
  int64_t X, bound;

  if (!(binomial->has_binomial) || (binomial->nsave != n) ||
      (binomial->psave != p)) {
    binomial->nsave = n;
    binomial->psave = p;
    binomial->has_binomial = 1;
    binomial->q = q = 1.0 - p;
    binomial->r = qn = exp(n * log1p(-p));
    binomial->c = np = n * p;
    binomial->m = bound = (int64_t)fmin((double)n, np + 10.0 * sqrt(np * q + 1));
  } else {
    q = binomial->q;
    qn = binomial->r;
    np = binomial->c;
    bound = binomial->m;
  }
  X = 0;
  px = qn;
  U = ln_pcg64_next_double(rng);
  while (U > px) {
    X++;
    if (X > bound) {
      X = 0;
      px = qn;
      U = ln_pcg64_next_double(rng);
    } else {
      U -= px;
      px = ((n - X + 1) * p * px) / (X * q);
    }
  }
  return X;
}

static int64_t ln_binomial_draw(ln_pcg64 *rng, double p, int64_t n,
                        ln_binomial_cache *binomial) {
  double q;

  if ((n == 0LL) || (p == 0.0f))
    return 0;

  if (p <= 0.5) {
    if (p * n <= 30.0) {
      return ln_binomial_inversion(rng, n, p, binomial);
    } else {
      return ln_binomial_btpe(rng, n, p, binomial);
    }
  } else {
    q = 1.0 - p;
    if (q * n <= 30.0) {
      return n - ln_binomial_inversion(rng, n, q, binomial);
    } else {
      return n - ln_binomial_btpe(rng, n, q, binomial);
    }
  }
}


int64_t ln_pcg64_binomial(ln_pcg64 *rng, int64_t n, double p)
{
    ln_binomial_cache cache = {0};
    return ln_binomial_draw(rng, p, n, &cache);
}

/* Adapted from NumPy 2.5.3 random_zipf, BSD-3-Clause. Caller validates
 * a > 1 and not NaN. a >= 1025 returns 1 without consuming PCG64 state.
 * Reject values outside int64 range before conversion. */
int64_t ln_pcg64_zipf(ln_pcg64 *rng, double a)
{
    if(a>=1025.0)return 1;
    const double am1=a-1.0;
    const double b=pow(2.0,am1);
    const double umin=pow((double)INT64_MAX,-am1);
    for(;;){
        double u01=ln_pcg64_next_double(rng);
        double u=u01*umin+(1.0-u01);
        double v=ln_pcg64_next_double(rng);
        double x=floor(pow(u,-1.0/am1));
        /* 2^63 is the smallest representable double larger than INT64_MAX. */
        if(!(x>=1.0) || x>=0x1.0p63)continue;
        double t=pow(1.0+1.0/x,am1);
        if(v*x*(t-1.0)/(b-1.0)<=t/b)return (int64_t)x;
    }
}

/* NumPy 2.5.3 random_wald() and random_logseries() in
 * numpy/random/src/distributions/distributions.c (BSD-3-Clause).
 * Keep the exact expression order: reproducibility depends on the
 * underlying standard normal and PCG64 draw sequences. */
/* NumPy 2.5.3 random_standard_t. Preserve normal-then-Gamma draw order. */
double ln_pcg64_standard_t(ln_pcg64 *rng, double df)
{
    double num=ln_pcg64_standard_normal(rng);
    double denom=ln_pcg64_standard_gamma(rng,isnan(df)?INFINITY:df/2.0);
    return sqrt(df/2.0)*num/sqrt(denom);
}

/* NumPy 2.5.3 random_vonmises: Best-Fisher rejection sampler with the
 * small/large-kappa branches and wrap-to-[-pi,pi] convention. */
double ln_pcg64_vonmises(ln_pcg64 *rng, double mu, double kappa)
{
    const double pi=3.141592653589793238462643383279502884;
    double s,U,V,W,Y,Z,result,mod;
    int neg;
    if(isnan(kappa))return NAN;
    if(kappa<1e-8)return pi*(2.0*ln_pcg64_next_double(rng)-1.0);
    if(kappa<1e-5){
        s=1.0/kappa+kappa;
    }else if(kappa<=1e6){
        double r=1.0+sqrt(1.0+4.0*kappa*kappa);
        double rho=(r-sqrt(2.0*r))/(2.0*kappa);
        s=(1.0+rho*rho)/(2.0*rho);
    }else{
        result=mu+sqrt(1.0/kappa)*ln_pcg64_standard_normal(rng);
        if(result<-pi)result+=2*pi;
        if(result>pi)result-=2*pi;
        return result;
    }
    for(;;){
        U=ln_pcg64_next_double(rng);
        Z=cos(pi*U);
        W=(1.0+s*Z)/(s+Z);
        Y=kappa*(s-W);
        V=ln_pcg64_next_double(rng);
        if((Y*(2.0-Y)-V>=0.0)||(log(Y/V)+1.0-Y>=0.0))break;
    }
    U=ln_pcg64_next_double(rng);
    result=acos(W);
    if(U<0.5)result=-result;
    result+=mu;
    neg=(result<0.0);
    mod=fabs(result);
    mod=fmod(mod+pi,2.0*pi)-pi;
    if(neg)mod=-mod;
    return mod;
}

double ln_pcg64_wald(ln_pcg64 *rng, double mean, double scale)
{
    double U, X, Y, d;
    Y = ln_pcg64_standard_normal(rng);
    Y = mean * Y * Y;
    d = 1 + sqrt(1 + 4 * scale / Y);
    X = mean * (1 - 2 / d);
    U = ln_pcg64_next_double(rng);
    if (U <= mean / (mean + X))
        return X;
    return mean * mean / X;
}

int64_t ln_pcg64_logseries(ln_pcg64 *rng, double p)
{
    double q, r, U, V;
    int64_t result;
    r = log1p(-p);
    for (;;) {
        V = ln_pcg64_next_double(rng);
        if (V >= p) return 1;
        U = ln_pcg64_next_double(rng);
        q = -expm1(r * U);
        if (V <= q * q) {
            result = (int64_t)floor(1 + log(V) / log(q));
            if (result < 1 || V == 0.0) continue;
            return result;
        }
        if (V >= q) return 1;
        return 2;
    }
}
