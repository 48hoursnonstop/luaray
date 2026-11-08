#include "ln_multivariate_normal.h"
#include <limits.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern void dgesdd_(const char *jobz,const int *m,const int *n,double *a,
                    const int *lda,double *s,double *u,const int *ldu,
                    double *vt,const int *ldvt,double *work,const int *lwork,
                    int *iwork,int *info);
extern void dsyevd_(const char *jobz,const char *uplo,const int *n,
                    double *a,const int *lda,double *w,double *work,
                    const int *lwork,int *iwork,const int *liwork,int *info);
extern void dpotrf_(const char *uplo,const int *n,double *a,const int *lda,int *info);

static int fail(char *dst,size_t cap,const char *msg) {
    if (dst && cap) snprintf(dst,cap,"%s",msg);
    return -1;
}
static void *allocated(size_t count,size_t bytes) {
    if(count && bytes>SIZE_MAX/count)return NULL;
    return malloc((count?count:1)*bytes);
}
static int lwork_count(double v,int *out) {
    if(!isfinite(v)||v<1||v>INT_MAX-1)return -1;
    *out=(int)ceil(v);return 0;
}
int ln_mvn_factor(const double *cov,size_t n,int method,int check,double tol,
                  double *factor,int *warning,char *err,size_t errcap)
{
    if(warning)*warning=0;
    if(n==0||n>INT_MAX||n>SIZE_MAX/n)
        return fail(err,errcap,"invalid multivariate dimension");
    size_t nn=n*n;
    int ni=(int)n,info=0,one=1;
    double *a=allocated(nn,sizeof(double));
    if(!a)return fail(err,errcap,"out of memory allocating covariance");
    /* LAPACK operates on Fortran-contiguous data.  For a non-symmetric
       covariance, preserve exact matrix entries in the SVD path. */
    for(size_t i=0;i<n;i++)for(size_t j=0;j<n;j++)a[j*n+i]=cov[i*n+j];
    int invalid=0;
    if(method==2){
        const char lower='L';
        dpotrf_(&lower,&ni,a,&ni,&info);
        if(info){free(a);return fail(err,errcap,"covariance is not positive definite (cholesky)");}
        for(size_t i=0;i<n;i++)for(size_t j=0;j<n;j++)
            factor[i*n+j]=j<=i?a[j*n+i]:0.0;
    }else if(method==1){
        double *eig=allocated(n,sizeof(double));
        if(!eig){free(a);return fail(err,errcap,"out of memory allocating eigenvalues");}
        const char jobz='V',lower='L';
        double query=0;int iquery=0,lwork=-1,liwork=-1;
        dsyevd_(&jobz,&lower,&ni,a,&ni,eig,&query,&lwork,&iquery,&liwork,&info);
        if(info||lwork_count(query,&lwork)||iquery<1){free(eig);free(a);return fail(err,errcap,"LAPACK eigh workspace query failed");}
        liwork=iquery;
        double *work=allocated((size_t)lwork,sizeof(double));
        int *iwork=allocated((size_t)liwork,sizeof(int));
        if(!work||!iwork){free(work);free(iwork);free(eig);free(a);return fail(err,errcap,"out of memory in eigh");}
        dsyevd_(&jobz,&lower,&ni,a,&ni,eig,work,&lwork,iwork,&liwork,&info);
        free(work);free(iwork);
        if(info){free(eig);free(a);return fail(err,errcap,"LAPACK eigh failed");}
        if(check!=0)for(size_t k=0;k<n;k++)if(eig[k]<-tol)invalid=1;
        for(size_t i=0;i<n;i++)for(size_t k=0;k<n;k++)
            factor[i*n+k]=a[k*n+i]*sqrt(fabs(eig[k]));
        free(eig);
    }else if(method==0){
        double *s=allocated(n,sizeof(double));
        double *u=allocated(nn,sizeof(double));
        double *vt=allocated(nn,sizeof(double));
        int *iwork=allocated(n*8,sizeof(int));
        if(!s||!u||!vt||!iwork){free(iwork);free(s);free(u);free(vt);free(a);return fail(err,errcap,"out of memory in svd");}
        const char jobz='A';double query=0;int lwork=-1;
        dgesdd_(&jobz,&ni,&ni,a,&ni,s,u,&ni,vt,&ni,&query,&lwork,iwork,&info);
        if(info||lwork_count(query,&lwork)){
            free(iwork);free(s);free(u);free(vt);free(a);return fail(err,errcap,"LAPACK svd workspace query failed");
        }
        double *work=allocated((size_t)lwork,sizeof(double));
        if(!work){free(iwork);free(s);free(u);free(vt);free(a);return fail(err,errcap,"out of memory allocating svd work");}
        dgesdd_(&jobz,&ni,&ni,a,&ni,s,u,&ni,vt,&ni,work,&lwork,iwork,&info);
        free(work);free(iwork);
        if(info){free(s);free(u);free(vt);free(a);return fail(err,errcap,"LAPACK svd failed");}
        if(check!=0){
            for(size_t i=0;i<n&&!invalid;i++)for(size_t j=0;j<n;j++){
                double reconstructed=0.0;
                for(size_t k=0;k<n;k++)reconstructed+=vt[i*n+k]*s[k]*vt[j*n+k];
                if(!isfinite(reconstructed)||!(fabs(reconstructed-cov[i*n+j])<=tol+tol*fabs(cov[i*n+j]))){invalid=1;break;}
            }
        }
        for(size_t i=0;i<n;i++)for(size_t k=0;k<n;k++)
            factor[i*n+k]=u[k*n+i]*sqrt(s[k]);
        free(s);free(u);free(vt);
    }else{
        free(a);return fail(err,errcap,"unsupported multivariate factor method");
    }
    free(a);
    if(invalid){
        if(check==2)return fail(err,errcap,"covariance is not symmetric positive-semidefinite");
        if(warning)*warning=1;
    }
    return 0;
}
