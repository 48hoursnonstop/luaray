#include "ln_datetime.h"
#include <limits.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#if defined(__GNUC__)
__extension__ typedef __int128 ln_i128;
#else
typedef int64_t ln_i128;
#endif

static void dterr(ln_error *e,const char *m){if(e)snprintf(e->message,sizeof(e->message),"%s",m);}
static const char *UNAMES[15]={"Y","M","W",NULL,"D","h","m","s","ms","us","ns","ps","fs","as","generic"};
const char *ln_datetime_unit_name(ln_datetime_unit u){return u>=0&&u<=LN_FR_GENERIC?UNAMES[u]:NULL;}

typedef struct dt_node { ln_dtype_descr d; ln_datetime_meta m; char name[64]; struct dt_node *next; } dt_node;
static dt_node *cache=NULL;
static ln_dtype_class dt_cls, td_cls;
static dt_node dt_generic, td_generic;
static int ready=0;

static const ln_dtype_descr *dt_default(const ln_dtype_class *c){return c==&dt_cls?&dt_generic.d:c==&td_cls?&td_generic.d:NULL;}
static const ln_dtype_class *dt_common_class(const ln_dtype_class *a,const ln_dtype_class *b){
    if((a==&dt_cls||a==&td_cls)&&(b==&dt_cls||b==&td_cls)) return (a==&dt_cls||b==&dt_cls)?&dt_cls:&td_cls;
    /* NumPy promotes timedelta with integer, but not datetime with numeric. */
    if(a==&td_cls && b && (b->kind=='i'||b->kind=='u'||b->kind=='b')) {
        const ln_dtype_descr *numeric=ln_dtype_default_descr(b);
        if(b->kind=='u' && (!numeric || numeric->elsize>=sizeof(int64_t)))return NULL;
        return &td_cls;
    }
    return NULL;
}
static uint64_t gcd64(uint64_t a,uint64_t b){while(b){uint64_t t=a%b;a=b;b=t;}return a;}
static const uint32_t FACTORS[15]={1,1,7,1,24,60,60,1000,1000,1000,1000,1000,1000,1,0};
static uint64_t factor(ln_datetime_unit big,ln_datetime_unit small){uint64_t f=1;for(int u=big;u<small;++u){f*=FACTORS[u];if(f&0xff00000000000000ULL)return 0;}return f;}

int ln_datetime_metadata_gcd(const ln_datetime_meta *a,const ln_datetime_meta *b,int sa,int sb,ln_datetime_meta *o,ln_error *e){
    if(a->base==LN_FR_GENERIC){*o=*b;return 0;} if(b->base==LN_FR_GENERIC){*o=*a;return 0;}
    uint64_t n1=(uint64_t)a->num,n2=(uint64_t)b->num; ln_datetime_unit base=a->base;
    if(a->base==b->base) base=a->base;
    else if(a->base==LN_FR_Y){if(b->base==LN_FR_M){base=LN_FR_M;n1*=12;}else if(sa){dterr(e,"incompatible nonlinear datetime units");return -1;}else base=b->base;}
    else if(b->base==LN_FR_Y){if(a->base==LN_FR_M){base=LN_FR_M;n2*=12;}else if(sb){dterr(e,"incompatible nonlinear datetime units");return -1;}else base=a->base;}
    else if(a->base==LN_FR_M){if(sa){dterr(e,"incompatible nonlinear datetime units");return -1;}base=b->base;}
    else if(b->base==LN_FR_M){if(sb){dterr(e,"incompatible nonlinear datetime units");return -1;}base=a->base;}
    if(a->base!=b->base && a->base!=LN_FR_Y && b->base!=LN_FR_Y && a->base!=LN_FR_M && b->base!=LN_FR_M){
        if(a->base>b->base){base=a->base;uint64_t f=factor(b->base,a->base);if(!f)return -1;n2*=f;}
        else{base=b->base;uint64_t f=factor(a->base,b->base);if(!f)return -1;n1*=f;}
    }
    uint64_t g=gcd64(n1,n2); if(!g||g>INT_MAX){dterr(e,"overflow getting common datetime metadata divisor");return -1;} o->base=base;o->num=(int)g;return 0;
}

static const ln_dtype_descr *dt_common_instance(const ln_dtype_descr *a,const ln_dtype_descr *b){
    if(!a||!b)return NULL;
    int at=(a->type_num==LN_DATETIME||a->type_num==LN_TIMEDELTA);
    int bt=(b->type_num==LN_DATETIME||b->type_num==LN_TIMEDELTA);
    if(at && !bt){return a->type_num==LN_TIMEDELTA && (b->kind=='i'||b->kind=='u'||b->kind=='b') && !(b->kind=='u' && b->elsize>=sizeof(int64_t)) ? a : NULL;}
    if(bt && !at){return b->type_num==LN_TIMEDELTA && (a->kind=='i'||a->kind=='u'||a->kind=='b') && !(a->kind=='u' && a->elsize>=sizeof(int64_t)) ? b : NULL;}
    if(!at||!bt)return NULL;
    ln_datetime_meta out; ln_error e={{0}}; const ln_datetime_meta *ma=ln_datetime_metadata(a),*mb=ln_datetime_metadata(b);
    if(ln_datetime_metadata_gcd(ma,mb,a->type_num==LN_TIMEDELTA,b->type_num==LN_TIMEDELTA,&out,&e)<0)return NULL;
    return ln_datetime_make_dtype(a->type_num==LN_DATETIME||b->type_num==LN_DATETIME?0:1,out,NULL);
}
static const ln_dtype_class_slots SLOTS={dt_default,dt_common_class,dt_common_instance};
static void init(void){if(ready)return; memset(&dt_generic,0,sizeof(dt_generic));memset(&td_generic,0,sizeof(td_generic));
    dt_cls=(ln_dtype_class){"datetime64",'M',LN_DATETIME,LN_DTYPE_CLASS_PARAMETRIC,&dt_generic.d,&SLOTS};
    td_cls=(ln_dtype_class){"timedelta64",'m',LN_TIMEDELTA,LN_DTYPE_CLASS_PARAMETRIC,&td_generic.d,&SLOTS};
    dt_generic.m=(ln_datetime_meta){LN_FR_GENERIC,1};td_generic.m=dt_generic.m;
    dt_generic.d=(ln_dtype_descr){&dt_cls,LN_DATETIME,"datetime64",'M','=',0,8,_Alignof(int64_t),&dt_generic.m};
    td_generic.d=(ln_dtype_descr){&td_cls,LN_TIMEDELTA,"timedelta64",'m','=',0,8,_Alignof(int64_t),&td_generic.m};ready=1;}
const ln_dtype_class *ln_datetime_dtype_class(int td){init();return td?&td_cls:&dt_cls;}
const ln_dtype_descr *ln_datetime_default_dtype(int td){init();return td?&td_generic.d:&dt_generic.d;}
const ln_datetime_meta *ln_datetime_metadata(const ln_dtype_descr *d){return d&&(d->type_num==LN_DATETIME||d->type_num==LN_TIMEDELTA)?(const ln_datetime_meta*)d->metadata:NULL;}

const ln_dtype_descr *ln_datetime_make_dtype(int td,ln_datetime_meta m,ln_error *e){init();if(m.num<=0||m.base<LN_FR_Y||m.base>LN_FR_GENERIC){dterr(e,"invalid datetime metadata");return NULL;} if(m.base==LN_FR_GENERIC&&m.num!=1){dterr(e,"generic datetime unit cannot have a multiplier");return NULL;}
    if(m.base==LN_FR_GENERIC)return ln_datetime_default_dtype(td);
    for(dt_node*n=cache;n;n=n->next)if(n->d.type_num==(td?LN_TIMEDELTA:LN_DATETIME)&&n->m.base==m.base&&n->m.num==m.num)return &n->d;
    dt_node*n=(dt_node*)calloc(1,sizeof(*n));if(!n){dterr(e,"out of memory creating datetime descriptor");return NULL;}n->m=m;const char*root=td?"timedelta64":"datetime64";const char*u=ln_datetime_unit_name(m.base);if(m.num==1)snprintf(n->name,sizeof(n->name),"%s[%s]",root,u);else snprintf(n->name,sizeof(n->name),"%s[%d%s]",root,m.num,u);
    n->d=(ln_dtype_descr){td?&td_cls:&dt_cls,td?LN_TIMEDELTA:LN_DATETIME,n->name,td?'m':'M','=',0,8,_Alignof(int64_t),&n->m};n->next=cache;cache=n;return &n->d;}

static ln_datetime_unit parse_unit(const char*s,size_t n){
    if(n==1){switch(*s){case'Y':return LN_FR_Y;case'M':return LN_FR_M;case'W':return LN_FR_W;case'D':return LN_FR_D;case'h':return LN_FR_h;case'm':return LN_FR_m;case's':return LN_FR_s;}}
    if(n==2&&s[1]=='s'){switch(s[0]){case'm':return LN_FR_ms;case'u':return LN_FR_us;case'n':return LN_FR_ns;case'p':return LN_FR_ps;case'f':return LN_FR_fs;case'a':return LN_FR_as;}}
    if(n==3 && (unsigned char)s[0]==0xce && (unsigned char)s[1]==0xbc && s[2]=='s')return LN_FR_us;
    if(n==7&&!strncmp(s,"generic",7))return LN_FR_GENERIC;
    return LN_FR_ERROR;
}

/* Port of NumPy datetime.c:_multiples_table and
 * convert_datetime_divisor_to_multiple.  The odd W fourth entry is retained:
 * upstream can consequently spell some unsupported divisors as 0Y. */
static int convert_divisor_to_multiple(ln_datetime_meta *m,int den,ln_error *e){
    static const int totry[15][4]={
        [LN_FR_Y]={12,52,365,0}, [LN_FR_M]={4,30,720,0},
        [LN_FR_W]={7,168,10080,0}, [LN_FR_D]={24,1440,86400,0},
        [LN_FR_h]={60,3600,0,0}, [LN_FR_m]={60,60000,0,0},
        [LN_FR_s]={1000,1000000,0,0}, [LN_FR_ms]={1000,1000000,0,0},
        [LN_FR_us]={1000,1000000,0,0}, [LN_FR_ns]={1000,1000000,0,0},
        [LN_FR_ps]={1000,1000000,0,0}, [LN_FR_fs]={1000,1000000,0,0},
        [LN_FR_as]={1000,1000000,0,0}
    };
    static const ln_datetime_unit bases[15][4]={
        [LN_FR_Y]={LN_FR_M,LN_FR_W,LN_FR_D,LN_FR_Y},
        [LN_FR_M]={LN_FR_W,LN_FR_D,LN_FR_h,LN_FR_Y},
        [LN_FR_W]={LN_FR_D,LN_FR_h,LN_FR_m,LN_FR_Y},
        [LN_FR_D]={LN_FR_h,LN_FR_m,LN_FR_s,LN_FR_Y},
        [LN_FR_h]={LN_FR_m,LN_FR_s,LN_FR_Y,LN_FR_Y},
        [LN_FR_m]={LN_FR_s,LN_FR_ms,LN_FR_Y,LN_FR_Y},
        [LN_FR_s]={LN_FR_ms,LN_FR_us,LN_FR_Y,LN_FR_Y},
        [LN_FR_ms]={LN_FR_us,LN_FR_ns,LN_FR_Y,LN_FR_Y},
        [LN_FR_us]={LN_FR_ns,LN_FR_ps,LN_FR_Y,LN_FR_Y},
        [LN_FR_ns]={LN_FR_ps,LN_FR_fs,LN_FR_Y,LN_FR_Y},
        [LN_FR_ps]={LN_FR_fs,LN_FR_as,LN_FR_Y,LN_FR_Y},
        [LN_FR_fs]={LN_FR_as,LN_FR_Y,LN_FR_Y,LN_FR_Y},
        [LN_FR_as]={LN_FR_Y,LN_FR_Y,LN_FR_Y,LN_FR_Y}
    };
    if(!m||den<=0){dterr(e,"invalid datetime metadata divisor");return -1;}
    if(m->base==LN_FR_GENERIC){dterr(e,"can't use divisor with generic datetime units");return -1;}
    int n=3;
    if(m->base==LN_FR_W)n=4;
    else if(m->base>LN_FR_D)n=2;
    if(m->base==LN_FR_fs)n=1;
    if(m->base==LN_FR_as)n=0;
    for(int i=0;i<n;i++){
        int q=totry[m->base][i]/den, r=totry[m->base][i]%den;
        if(r==0){
            ln_i128 mult=(ln_i128)m->num*q;
            if(mult<0||mult>INT_MAX){dterr(e,"datetime metadata multiplier overflow");return -1;}
            m->base=bases[m->base][i]; m->num=(int)mult; return 0;
        }
    }
    dterr(e,"divisor is not a multiple of a lower-unit in datetime metadata");return -1;
}

const ln_dtype_descr *ln_datetime_parse_dtype(const char *s,ln_error *e){
    if(!s)return NULL;
    int td=0;
    const char*p=NULL;
    if(!strncmp(s,"datetime64",10)){td=0;p=s+10;}
    else if(!strncmp(s,"timedelta64",11)){td=1;p=s+11;}
    else if(!strncmp(s,"M8",2)){td=0;p=s+2;}
    else if(!strncmp(s,"m8",2)){td=1;p=s+2;}
    else return NULL;
    if(!*p)return ln_datetime_default_dtype(td);
    if(*p!='['){dterr(e,"invalid datetime metadata string");return NULL;}
    const char*end=strchr(p,']'); if(!end||end[1]||end==p+1){dterr(e,"invalid datetime metadata string");return NULL;}
    const char*q=p+1,*unit_start=NULL,*unit_end=NULL; char*ep=NULL;
    long mult=strtol(q,&ep,10);
    if(ep==q)mult=1; else {if(mult<0||mult>INT_MAX){dterr(e,"invalid datetime metadata multiplier");return NULL;}q=ep;}
    unit_start=q; while(q<end&&*q!='/')q++; unit_end=q;
    if(unit_start==unit_end){dterr(e,"invalid datetime unit");return NULL;}
    ln_datetime_unit u=parse_unit(unit_start,(size_t)(unit_end-unit_start));
    if(u==LN_FR_ERROR){dterr(e,"invalid datetime unit");return NULL;}
    ln_datetime_meta meta={u,(int)mult};
    if(q<end){
        q++; if(q==end){dterr(e,"invalid datetime metadata divisor");return NULL;}
        long den=strtol(q,&ep,10);
        if(ep!=end||den<=0||den>INT_MAX){dterr(e,"invalid datetime metadata divisor");return NULL;}
        if(den!=1&&convert_divisor_to_multiple(&meta,(int)den,e)<0)return NULL;
    }
    /* Upstream's W divisor table deliberately permits a 0Y result in one
     * historical corner.  Keep that parse quirk representable. */
    if(meta.num==0){
        init();
        for(dt_node*n=cache;n;n=n->next)if(n->d.type_num==(td?LN_TIMEDELTA:LN_DATETIME)&&n->m.base==meta.base&&n->m.num==0)return &n->d;
        dt_node*n=(dt_node*)calloc(1,sizeof(*n));if(!n){dterr(e,"out of memory creating datetime descriptor");return NULL;}
        n->m=meta;snprintf(n->name,sizeof(n->name),"%s[0%s]",td?"timedelta64":"datetime64",ln_datetime_unit_name(meta.base));
        n->d=(ln_dtype_descr){td?&td_cls:&dt_cls,td?LN_TIMEDELTA:LN_DATETIME,n->name,td?'m':'M','=',0,8,_Alignof(int64_t),&n->m};n->next=cache;cache=n;return &n->d;
    }
    return ln_datetime_make_dtype(td,meta,e);
}

int ln_datetime_conversion_factor(const ln_datetime_meta*s,const ln_datetime_meta*d,int64_t*outn,int64_t*outd,ln_error*e){if(s->base==LN_FR_GENERIC){*outn=1;*outd=1;return 0;}if(d->base==LN_FR_GENERIC){dterr(e,"cannot convert specific datetime units to generic units");return -1;}int sb=s->base,db=d->base,swap=0;uint64_t n=1,den=1;if(sb>db){int t=sb;sb=db;db=t;swap=1;}if(sb!=db){if(sb==LN_FR_Y){if(db==LN_FR_M)n*=12;else if(db==LN_FR_W){n*=146097;den*=2800;}else{n*=146097;den*=400;n*=factor(LN_FR_D,(ln_datetime_unit)db);}}else if(sb==LN_FR_M){if(db==LN_FR_W){n*=146097;den*=33600;}else{n*=146097;den*=4800;n*=factor(LN_FR_D,(ln_datetime_unit)db);}}else n*=factor((ln_datetime_unit)sb,(ln_datetime_unit)db);}if(!n){dterr(e,"overflow computing datetime conversion factor");return -1;}if(swap){uint64_t t=n;n=den;den=t;}n*=s->num;den*=d->num;uint64_t g=gcd64(n,den);n/=g;den/=g;if(n>INT64_MAX||den>INT64_MAX){dterr(e,"overflow computing datetime conversion factor");return -1;}*outn=(int64_t)n;*outd=(int64_t)den;return 0;}
int ln_datetime_cast_value(int64_t v,const ln_datetime_meta*s,const ln_datetime_meta*d,int64_t*out,ln_error*e){if(v==LN_DATETIME_NAT){*out=v;return 0;}int64_t n,den;if(ln_datetime_conversion_factor(s,d,&n,&den,e)<0)return -1;ln_i128 z=(ln_i128)v*n;/* NumPy integer cast truncates toward -inf via divmod-style adjustment. */ln_i128 q=z/den,r=z%den;if(r<0)q--;if(q<INT64_MIN||q>INT64_MAX||q==LN_DATETIME_NAT){dterr(e,"datetime cast overflow");return -1;}*out=(int64_t)q;return 0;}

static int divides(const ln_datetime_meta*a,const ln_datetime_meta*b,int strict){
    if(a->base==LN_FR_GENERIC)return 1;
    if(b->base==LN_FR_GENERIC)return 0;
    uint64_t n1=(uint64_t)a->num,n2=(uint64_t)b->num;
    if(a->base!=b->base){
        if(a->base==LN_FR_Y){if(b->base==LN_FR_M)n1*=12;else if(strict)return 0;else return 1;}
        else if(b->base==LN_FR_Y){if(a->base==LN_FR_M)n2*=12;else if(strict)return 0;else return 1;}
        else if(a->base==LN_FR_M||b->base==LN_FR_M){if(strict)return 0;else return 1;}
        if(a->base>b->base){uint64_t f=factor(b->base,a->base);if(!f)return 0;n2*=f;}
        else{uint64_t f=factor(a->base,b->base);if(!f)return 0;n1*=f;}
    }
    if((n1&0xff00000000000000ULL)||(n2&0xff00000000000000ULL)||n2==0)return 0;
    return n1%n2==0;
}
int ln_datetime_can_cast_metadata(const ln_datetime_meta*s,const ln_datetime_meta*d,int td,int safe){
    if(!s||!d)return 0;
    if(!safe)return s->base==d->base&&s->num==d->num;
    if(s->base==LN_FR_GENERIC||d->base==LN_FR_GENERIC)return s->base==LN_FR_GENERIC;
    if(td&&((s->base<=LN_FR_M)!=(d->base<=LN_FR_M)))return 0;
    return s->base<=d->base&&divides(s,d,td);
}
int ln_datetime_can_cast_same_kind(const ln_datetime_meta*s,const ln_datetime_meta*d,int td){
    if(!s||!d)return 0;
    if(s->base==LN_FR_GENERIC||d->base==LN_FR_GENERIC)return s->base==LN_FR_GENERIC;
    if(!td)return 1;
    return ((s->base<=LN_FR_M)&&(d->base<=LN_FR_M))||((s->base>LN_FR_M)&&(d->base>LN_FR_M));
}

static inline int64_t load64(const char *p){int64_t v;memcpy(&v,p,8);return v;}
static inline void store64(char *p,int64_t v){memcpy(p,&v,8);}
void ln_datetime_add_loop(char **args,const ln_intp *dimensions,const ln_intp *steps,void *data){
    (void)data;for(ln_intp i=0;i<dimensions[0];++i){int64_t a=load64(args[0]+i*steps[0]),b=load64(args[1]+i*steps[1]);int64_t r=(a==LN_DATETIME_NAT||b==LN_DATETIME_NAT)?LN_DATETIME_NAT:(int64_t)((uint64_t)a+(uint64_t)b);store64(args[2]+i*steps[2],r);}}
void ln_datetime_subtract_loop(char **args,const ln_intp *dimensions,const ln_intp *steps,void *data){
    (void)data;for(ln_intp i=0;i<dimensions[0];++i){int64_t a=load64(args[0]+i*steps[0]),b=load64(args[1]+i*steps[1]);int64_t r=(a==LN_DATETIME_NAT||b==LN_DATETIME_NAT)?LN_DATETIME_NAT:(int64_t)((uint64_t)a-(uint64_t)b);store64(args[2]+i*steps[2],r);}}
void ln_datetime_compare_loop(char **args,const ln_intp *dimensions,const ln_intp *steps,void *data){
    ln_binary_op op=*(const ln_binary_op*)data;for(ln_intp i=0;i<dimensions[0];++i){int64_t a=load64(args[0]+i*steps[0]),b=load64(args[1]+i*steps[1]);int nat=a==LN_DATETIME_NAT||b==LN_DATETIME_NAT;int r=0;
        switch(op){case LN_OP_EQUAL:r=!nat&&a==b;break;case LN_OP_NOT_EQUAL:r=nat||a!=b;break;case LN_OP_LESS:r=!nat&&a<b;break;case LN_OP_LESS_EQUAL:r=!nat&&a<=b;break;case LN_OP_GREATER:r=!nat&&a>b;break;case LN_OP_GREATER_EQUAL:r=!nat&&a>=b;break;default:r=0;break;}uint8_t q=(uint8_t)r;memcpy(args[2]+i*steps[2],&q,1);}}
void ln_datetime_minmax_loop(char **args,const ln_intp *dimensions,const ln_intp *steps,void *data){
    const ln_binary_op op=*(const ln_binary_op *)data;
    for(ln_intp i=0;i<dimensions[0];++i){
        int64_t a=load64(args[0]+i*steps[0]),b=load64(args[1]+i*steps[1]),r;
        if(op==LN_OP_MAXIMUM||op==LN_OP_MINIMUM){
            if(a==LN_DATETIME_NAT)r=a; else if(b==LN_DATETIME_NAT)r=b;
            else r=(op==LN_OP_MAXIMUM)?((a>b)?a:b):((a<b)?a:b);
        }else{
            if(a==LN_DATETIME_NAT)r=b; else if(b==LN_DATETIME_NAT)r=a;
            else r=(op==LN_OP_FMAX)?((a>=b)?a:b):((a<=b)?a:b);
        }
        store64(args[2]+i*steps[2],r);
    }
}

void ln_timedelta_negative_loop(char **args,const ln_intp *dimensions,const ln_intp *steps,void *data){(void)data;for(ln_intp i=0;i<dimensions[0];++i){int64_t a=load64(args[0]+i*steps[0]);store64(args[1]+i*steps[1],a==LN_DATETIME_NAT?a:-a);}}
void ln_timedelta_positive_loop(char **args,const ln_intp *dimensions,const ln_intp *steps,void *data){(void)data;for(ln_intp i=0;i<dimensions[0];++i)store64(args[1]+i*steps[1],load64(args[0]+i*steps[0]));}
void ln_timedelta_absolute_loop(char **args,const ln_intp *dimensions,const ln_intp *steps,void *data){(void)data;for(ln_intp i=0;i<dimensions[0];++i){int64_t a=load64(args[0]+i*steps[0]);store64(args[1]+i*steps[1],a==LN_DATETIME_NAT?a:(a>=0?a:-a));}}
void ln_timedelta_sign_loop(char **args,const ln_intp *dimensions,const ln_intp *steps,void *data){(void)data;for(ln_intp i=0;i<dimensions[0];++i){int64_t a=load64(args[0]+i*steps[0]);double q=a==LN_DATETIME_NAT?NAN:(a>0?1.0:(a<0?-1.0:0.0));memcpy(args[1]+i*steps[1],&q,8);}}
void ln_datetime_isnat_loop(char **args,const ln_intp *dimensions,const ln_intp *steps,void *data){(void)data;for(ln_intp i=0;i<dimensions[0];++i){uint8_t q=(uint8_t)(load64(args[0]+i*steps[0])==LN_DATETIME_NAT);memcpy(args[1]+i*steps[1],&q,1);}}
void ln_datetime_isfinite_loop(char **args,const ln_intp *dimensions,const ln_intp *steps,void *data){(void)data;for(ln_intp i=0;i<dimensions[0];++i){uint8_t q=(uint8_t)(load64(args[0]+i*steps[0])!=LN_DATETIME_NAT);memcpy(args[1]+i*steps[1],&q,1);}}
