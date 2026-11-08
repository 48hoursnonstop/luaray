/* Adapted from NumPy 2.5.3 random_hypergeometric.c and logfactorial.c.
 * Copyright NumPy contributors, BSD-3-Clause. See THIRD_PARTY_NUMPY_LICENSE.txt.
 * Exact PCG64 next_uint32/masked-interval consumption is significant.
 */
#include "ln_random.h"
#include <stdint.h>
#include <math.h>
#define MIN(a,b) ((a) < (b) ? (a) : (b))
#define MAX(a,b) ((a) > (b) ? (a) : (b))

static uint64_t ln_random_interval(ln_pcg64 *rng, uint64_t max) {
    if (max == 0) return 0;
    uint64_t mask = max;
    mask |= mask >> 1; mask |= mask >> 2;
    mask |= mask >> 4; mask |= mask >> 8;
    mask |= mask >> 16; mask |= mask >> 32;
    if (max <= UINT32_MAX) {
        uint64_t value;
        do { value = ln_pcg64_next32(rng) & mask; } while (value > max);
        return value;
    }
    uint64_t value;
    do { value = ln_pcg64_next64(rng) & mask; } while (value > max);
    return value;
}

/*
 *  logfact[k] holds log(k!) for k = 0, 1, 2, ..., 125.
 */

static const double logfact[] = {
    0,
    0,
    0.69314718055994529,
    1.791759469228055,
    3.1780538303479458,
    4.7874917427820458,
    6.5792512120101012,
    8.5251613610654147,
    10.604602902745251,
    12.801827480081469,
    15.104412573075516,
    17.502307845873887,
    19.987214495661885,
    22.552163853123425,
    25.19122118273868,
    27.89927138384089,
    30.671860106080672,
    33.505073450136891,
    36.395445208033053,
    39.339884187199495,
    42.335616460753485,
    45.380138898476908,
    48.471181351835227,
    51.606675567764377,
    54.784729398112319,
    58.003605222980518,
    61.261701761002001,
    64.557538627006338,
    67.88974313718154,
    71.257038967168015,
    74.658236348830158,
    78.092223553315307,
    81.557959456115043,
    85.054467017581516,
    88.580827542197682,
    92.136175603687093,
    95.719694542143202,
    99.330612454787428,
    102.96819861451381,
    106.63176026064346,
    110.32063971475739,
    114.03421178146171,
    117.77188139974507,
    121.53308151543864,
    125.3172711493569,
    129.12393363912722,
    132.95257503561632,
    136.80272263732635,
    140.67392364823425,
    144.5657439463449,
    148.47776695177302,
    152.40959258449735,
    156.3608363030788,
    160.3311282166309,
    164.32011226319517,
    168.32744544842765,
    172.35279713916279,
    176.39584840699735,
    180.45629141754378,
    184.53382886144948,
    188.6281734236716,
    192.7390472878449,
    196.86618167289001,
    201.00931639928152,
    205.1681994826412,
    209.34258675253685,
    213.53224149456327,
    217.73693411395422,
    221.95644181913033,
    226.1905483237276,
    230.43904356577696,
    234.70172344281826,
    238.97838956183432,
    243.26884900298271,
    247.57291409618688,
    251.89040220972319,
    256.22113555000954,
    260.56494097186322,
    264.92164979855278,
    269.29109765101981,
    273.67312428569369,
    278.06757344036612,
    282.4742926876304,
    286.89313329542699,
    291.32395009427029,
    295.76660135076065,
    300.22094864701415,
    304.68685676566872,
    309.1641935801469,
    313.65282994987905,
    318.1526396202093,
    322.66349912672615,
    327.1852877037752,
    331.71788719692847,
    336.26118197919845,
    340.81505887079902,
    345.37940706226686,
    349.95411804077025,
    354.53908551944079,
    359.1342053695754,
    363.73937555556347,
    368.35449607240474,
    372.97946888568902,
    377.61419787391867,
    382.25858877306001,
    386.91254912321756,
    391.57598821732961,
    396.24881705179155,
    400.93094827891576,
    405.6222961611449,
    410.32277652693733,
    415.03230672824964,
    419.75080559954472,
    424.47819341825709,
    429.21439186665157,
    433.95932399501481,
    438.71291418612117,
    443.47508812091894,
    448.24577274538461,
    453.02489623849613,
    457.81238798127816,
    462.60817852687489,
    467.4121995716082,
    472.22438392698058,
    477.04466549258564,
    481.87297922988796
};

/*
 *  Compute log(k!)
 */

static double logfactorial(int64_t k)
{
    const double halfln2pi = 0.9189385332046728;

    if (k < (int64_t) (sizeof(logfact)/sizeof(logfact[0]))) {
        /* Use the lookup table. */
        return logfact[k];
    }

    /*
     *  Use the Stirling series, truncated at the 1/k**3 term.
     *  (In a Python implementation of this approximation, the result
     *  was within 2 ULP of the best 64 bit floating point value for
     *  k up to 10000000.)
     */
    return (k + 0.5)*log((double)k) - k + (halfln2pi + (1.0/k)*(1/12.0 - 1/(360.0*k*k)));
}

/*
 *  Generate a sample from the hypergeometric distribution.
 *
 *  Assume sample is not greater than half the total.  See below
 *  for how the opposite case is handled.
 *
 *  We initialize the following:
 *      computed_sample = sample
 *      remaining_good = good
 *      remaining_total = good + bad
 *
 *  In the loop:
 *  * computed_sample counts down to 0;
 *  * remaining_good is the number of good choices not selected yet;
 *  * remaining_total is the total number of choices not selected yet.
 *
 *  In the loop, we select items by choosing a random integer in
 *  the interval [0, remaining_total), and if the value is less
 *  than remaining_good, it means we have selected a good one,
 *  so remaining_good is decremented.  Then, regardless of that
 *  result, computed_sample is decremented.  The loop continues
 *  until either computed_sample is 0, remaining_good is 0, or
 *  remaining_total == remaining_good.  In the latter case, it
 *  means there are only good choices left, so we can stop the
 *  loop early and select what is left of computed_sample from
 *  the good choices (i.e. decrease remaining_good by computed_sample).
 *
 *  When the loop exits, the actual number of good choices is
 *  good - remaining_good.
 *
 *  If sample is more than half the total, then initially we set
 *      computed_sample = total - sample
 *  and at the end we return remaining_good (i.e. the loop in effect
 *  selects the complement of the result).
 *
 *  It is assumed that when this function is called:
 *    * good, bad and sample are nonnegative;
 *    * the sum good+bad will not result in overflow; 
 *    * sample <= good+bad.
 */

static int64_t hypergeometric_sample(ln_pcg64 *rng,
                                     int64_t good, int64_t bad, int64_t sample)
{
    int64_t remaining_total, remaining_good, result, computed_sample;
    int64_t total = good + bad;

    if (sample > total/2) {
        computed_sample = total - sample;
    }
    else {
        computed_sample = sample;
    }

    remaining_total = total;
    remaining_good = good;

    while ((computed_sample > 0) && (remaining_good > 0) &&
           (remaining_total > remaining_good)) {
         // ln_random_interval(rng, max) returns an integer in
         // [0, max] *inclusive*, so we decrement remaining_total before
         // passing it to random_interval().
        --remaining_total;
        if ((int64_t) ln_random_interval(rng,
                                      remaining_total) < remaining_good) {
            // Selected a "good" one, so decrement remaining_good.
            --remaining_good;
        }
        --computed_sample;
    }

    if (remaining_total == remaining_good) {
        // Only "good" choices are left.
        remaining_good -= computed_sample;
    }

    if (sample > total/2) {
        result = remaining_good;
    }
    else {
        result = good - remaining_good;
    }

    return result;
}


// D1 = 2*sqrt(2/e)
// D2 = 3 - 2*sqrt(3/e)
#define D1 1.7155277699214135
#define D2 0.8989161620588988

/*
 *  Generate variates from the hypergeometric distribution
 *  using the ratio-of-uniforms method.
 *
 *  In the code, the variable names a, b, c, g, h, m, p, q, K, T,
 *  U and X match the names used in "Algorithm HRUA" beginning on
 *  page 82 of Stadlober's 1989 thesis.
 *
 *  It is assumed that when this function is called:
 *    * good, bad and sample are nonnegative;
 *    * the sum good+bad will not result in overflow; 
 *    * sample <= good+bad.
 *
 *  References:
 *  -  Ernst Stadlober's thesis "Sampling from Poisson, Binomial and
 *     Hypergeometric Distributions: Ratio of Uniforms as a Simple and
 *     Fast Alternative" (1989)
 *  -  Ernst Stadlober, "The ratio of uniforms approach for generating
 *     discrete random variates", Journal of Computational and Applied
 *     Mathematics, 31, pp. 181-189 (1990).
 */

static int64_t hypergeometric_hrua(ln_pcg64 *rng,
                                   int64_t good, int64_t bad, int64_t sample)
{
    int64_t mingoodbad, maxgoodbad, popsize;
    int64_t computed_sample;
    double p, q;
    double mu, var;
    double a, c, b, h, g;
    int64_t m, K;

    popsize = good + bad;
    computed_sample = MIN(sample, popsize - sample);
    mingoodbad = MIN(good, bad);
    maxgoodbad = MAX(good, bad);

    /*
     *  Variables that do not match Stadlober (1989)
     *    Here               Stadlober
     *    ----------------   ---------
     *    mingoodbad            M
     *    popsize               N
     *    computed_sample       n
     */

    p = ((double) mingoodbad) / popsize;
    q = ((double) maxgoodbad) / popsize;

    // mu is the mean of the distribution.
    mu = computed_sample * p;

    a = mu + 0.5;

    // var is the variance of the distribution.
    var = ((double)(popsize - computed_sample) *
           computed_sample * p * q / (popsize - 1));

    c = sqrt(var + 0.5);

    /*
     *  h is 2*s_hat (See Stadlober's thesis (1989), Eq. (5.17); or
     *  Stadlober (1990), Eq. 8).  s_hat is the scale of the "table mountain"
     *  function that dominates the scaled hypergeometric PMF ("scaled" means
     *  normalized to have a maximum value of 1).
     */
    h = D1*c + D2;

    m = (int64_t) floor((double)(computed_sample + 1) * (mingoodbad + 1) /
                        (popsize + 2));

    g = (logfactorial(m) +
         logfactorial(mingoodbad - m) +
         logfactorial(computed_sample - m) +
         logfactorial(maxgoodbad - computed_sample + m));

    /*
     *  b is the upper bound for random samples:
     *  ... min(computed_sample, mingoodbad) + 1 is the length of the support.
     *  ... floor(a + 16*c) is 16 standard deviations beyond the mean.
     *
     *  The idea behind the second upper bound is that values that far out in
     *  the tail have negligible probabilities.
     *
     *  There is a comment in a previous version of this algorithm that says
     *      "16 for 16-decimal-digit precision in D1 and D2",
     *  but there is no documented justification for this value.  A lower value
     *  might work just as well, but I've kept the value 16 here.
     */
    b = MIN(MIN(computed_sample, mingoodbad) + 1, floor(a + 16*c));

    while (1) {
        double U, V, X, T;
        double gp;
        U = ln_pcg64_next_double(rng);
        V = ln_pcg64_next_double(rng);  // "U star" in Stadlober (1989)
        X = a + h*(V - 0.5) / U;

        // fast rejection:
        if ((X < 0.0) || (X >= b)) {
            continue;
        }

        K = (int64_t) floor(X);

        gp = (logfactorial(K) +
              logfactorial(mingoodbad - K) +
              logfactorial(computed_sample - K) +
              logfactorial(maxgoodbad - computed_sample + K));

        T = g - gp;

        // fast acceptance:
        if ((U*(4.0 - U) - 3.0) <= T) {
            break;
        }

        // fast rejection:
        if (U*(U - T) >= 1) {
            continue;
        }

        if (2.0*log(U) <= T) {
            // acceptance
            break;  
        }
    }

    if (good > bad) {
        K = computed_sample - K;
    }

    if (computed_sample < sample) {
        K = good - K;
    }

    return K;
}


/*
 *  Draw a sample from the hypergeometric distribution.
 *
 *  It is assumed that when this function is called:
 *    * good, bad and sample are nonnegative;
 *    * the sum good+bad will not result in overflow; 
 *    * sample <= good+bad.
 */

int64_t ln_pcg64_hypergeometric(ln_pcg64 *rng,
                              int64_t good, int64_t bad, int64_t sample)
{
    int64_t r;

    if ((sample >= 10) && (sample <= good + bad - 10)) {
        // This will use the ratio-of-uniforms method.
        r = hypergeometric_hrua(rng, good, bad, sample);
    }
    else {
        // The simpler implementation is faster for small samples.
        r = hypergeometric_sample(rng, good, bad, sample);
    }
    return r;
}
