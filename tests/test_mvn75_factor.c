#include "ln_multivariate_normal.h"
#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <string.h>
static void near(double a,double b){ assert(fabs(a-b)<1e-9); }
int main(void){
    char error[160];int warning=0;
    double c[4]={2,.5,.5,3},f[4]={0};
    for(int method=0;method<3;method++){
        assert(ln_mvn_factor(c,2,method,2,1e-8,f,&warning,error,sizeof error)==0);
        assert(warning==0);
        near(f[0]*f[0]+f[1]*f[1],2);
        near(f[0]*f[2]+f[1]*f[3],.5);
        near(f[2]*f[2]+f[3]*f[3],3);
    }
    double invalid[4]={1,2,2,1};
    for(int method=0;method<2;method++){
        assert(ln_mvn_factor(invalid,2,method,2,1e-8,f,&warning,error,sizeof error)<0);
        assert(strstr(error,"positive-semidefinite")!=NULL);
        assert(ln_mvn_factor(invalid,2,method,1,1e-8,f,&warning,error,sizeof error)==0);
        assert(warning);
        assert(ln_mvn_factor(invalid,2,method,0,1e-8,f,&warning,error,sizeof error)==0);
    }
    assert(ln_mvn_factor(invalid,2,2,0,1e-8,f,&warning,error,sizeof error)<0);
    double scalar[1]={9},result[1]={0};
    for(int method=0;method<3;method++){
        assert(ln_mvn_factor(scalar,1,method,2,1e-8,result,&warning,error,sizeof error)==0);
        near(result[0]*result[0],9);
    }
    double zeros[4]={0,0,0,0};
    for(int method=0;method<2;method++){
        assert(ln_mvn_factor(zeros,2,method,2,1e-8,f,&warning,error,sizeof error)==0);
        for(int j=0;j<4;j++)near(f[j],0);
    }
    assert(ln_mvn_factor(c,0,0,0,1e-8,f,&warning,error,sizeof error)<0);
    puts("mvn75 LAPACK native factor tests passed");
    return 0;
}
