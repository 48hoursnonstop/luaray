#ifndef LUARAY_RANDOM_H
#define LUARAY_RANDOM_H
#include <stdint.h>

#if !defined(__SIZEOF_INT128__)
#error "PCG64 currently requires compiler support for unsigned 128-bit integers"
#endif

typedef struct ln_pcg64 {
    __uint128_t state;
    __uint128_t increment;
    uint32_t cached_uint32;
    int has_uint32;
} ln_pcg64;

/* NumPy-compatible SeedSequence(pool_size=4) + PCG64 for a scalar uint64 seed. */
void ln_pcg64_seed(ln_pcg64 *rng, uint64_t seed);
uint64_t ln_pcg64_next64(ln_pcg64 *rng);
double ln_pcg64_next_double(ln_pcg64 *rng);
uint32_t ln_pcg64_next32(ln_pcg64 *rng);
/* NumPy-compatible Lemire bounded integer draw, range inclusive. */
uint64_t ln_pcg64_bounded64(ln_pcg64 *rng, uint64_t inclusive_range);
/* NumPy shuffle/permutation masked-rejection index, inclusive maximum. */
uint64_t ln_pcg64_interval(ln_pcg64 *rng, uint64_t max);
uint32_t ln_pcg64_bounded_small(ln_pcg64 *rng, uint32_t range, unsigned bits, uint32_t *buf, int *remaining);
uint32_t ln_pcg64_bounded32(ln_pcg64 *rng, uint32_t inclusive_range);
void ln_pcg64_advance(ln_pcg64 *rng, uint64_t delta);
/* Ziggurat normal draws, compatible with NumPy Generator for supported seeds. */
double ln_pcg64_standard_normal(ln_pcg64 *rng);
float ln_pcg64_standard_normal_f(ln_pcg64 *rng);

/* Exponential Ziggurat and inverse-CDF methods, following NumPy Generator. */
double ln_pcg64_standard_exponential(ln_pcg64 *rng);
float ln_pcg64_standard_exponential_f(ln_pcg64 *rng);
double ln_pcg64_standard_exponential_inv(ln_pcg64 *rng);
float ln_pcg64_standard_exponential_inv_f(ln_pcg64 *rng);

/* Distribution samplers matching NumPy's scalar algorithms. */
double ln_pcg64_lognormal(ln_pcg64 *rng, double mean, double sigma);
double ln_pcg64_standard_cauchy(ln_pcg64 *rng);
double ln_pcg64_laplace(ln_pcg64 *rng, double loc, double scale);
/* NumPy scalar distribution algorithms, preserving exact PCG64 draw order. */
double ln_pcg64_gumbel(ln_pcg64 *rng, double loc, double scale);
double ln_pcg64_logistic(ln_pcg64 *rng, double loc, double scale);
double ln_pcg64_rayleigh(ln_pcg64 *rng, double scale);
double ln_pcg64_weibull(ln_pcg64 *rng, double a);
/* More NumPy scalar distributions (2.5.3). */
double ln_pcg64_pareto(ln_pcg64 *rng, double a);
double ln_pcg64_power(ln_pcg64 *rng, double a);
double ln_pcg64_triangular(ln_pcg64 *rng, double left, double mode, double right);

/* NumPy 2.5.3 scalar Gamma / Beta samplers and float32 Gamma path. */
double ln_pcg64_standard_gamma(ln_pcg64 *rng, double shape);
float ln_pcg64_standard_gamma_f(ln_pcg64 *rng, float shape);
double ln_pcg64_gamma(ln_pcg64 *rng, double shape, double scale);
double ln_pcg64_beta(ln_pcg64 *rng, double a, double b);
/* NumPy chi-square and Fisher F: preserve the exact order of Gamma draws. */
double ln_pcg64_chisquare(ln_pcg64 *rng, double df);
double ln_pcg64_f(ln_pcg64 *rng, double dfnum, double dfden);
/* Scalar Poisson sampler: caller validates 0 <= lam <= 1e12. */
int64_t ln_pcg64_poisson(ln_pcg64 *rng, double lam);
double ln_pcg64_noncentral_chisquare(ln_pcg64 *rng, double df, double nonc);
double ln_pcg64_noncentral_f(ln_pcg64 *rng, double dfnum, double dfden, double nonc);
/* Wald inverse Gaussian and logarithmic-series (NumPy 2.5.3). */
double ln_pcg64_standard_t(ln_pcg64 *rng, double df);
double ln_pcg64_vonmises(ln_pcg64 *rng, double mu, double kappa);
double ln_pcg64_wald(ln_pcg64 *rng, double mean, double scale);
int64_t ln_pcg64_logseries(ln_pcg64 *rng, double p);

/* NumPy binomial inversion / BTPE, with scalar bounded n and probability. */
int64_t ln_pcg64_binomial(ln_pcg64 *rng, int64_t n, double p);
/* Gamma--Poisson mixture, matching NumPy draw order for supported parameters. */
int64_t ln_pcg64_negative_binomial(ln_pcg64 *rng, double n, double p);
/* NumPy geometric: search (p >= 1/3), exponential inversion otherwise. */
int64_t ln_pcg64_geometric(ln_pcg64 *rng, double p);
/* NumPy Zipf rejection sampler; a > 1. */
int64_t ln_pcg64_zipf(ln_pcg64 *rng, double a);
/* NumPy hypergeometric: direct sample and HRUA ratio of uniforms. */
int64_t ln_pcg64_hypergeometric(ln_pcg64 *rng, int64_t good, int64_t bad, int64_t sample);

/* Multivariate hypergeometric: NumPy count/marginals algorithms. */
#include <stddef.h>
int ln_pcg64_multivariate_hypergeometric(ln_pcg64 *rng, const int64_t *colors,
    size_t k, int64_t total, int64_t nsample, size_t nvariates,
    int count_method, int64_t *out);

/* Multinomial: sequential binomial, matching NumPy's draw order. */
void ln_pcg64_multinomial(ln_pcg64 *rng, int64_t n, const double *pvals,
                         size_t k, size_t nvariates, int64_t *out);

/* Dirichlet sampling: gamma normalization, with small-alpha stick breaking. */
void ln_pcg64_dirichlet(ln_pcg64 *rng, const double *alpha,
                        size_t k, size_t nvariates, double *out, double *scratch);

#endif
