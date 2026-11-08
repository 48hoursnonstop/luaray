#include "ln_datetime_strings.h"

#include <ctype.h>
#include <limits.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

#if defined(__GNUC__)
__extension__ typedef __int128 ln_i128;
#else
typedef int64_t ln_i128;
#endif

static void dtserr(ln_error *e,const char *fmt,const char *s,long long pos){
    if(!e)return;
    if(s)snprintf(e->message,sizeof(e->message),fmt,s,pos);
    else snprintf(e->message,sizeof(e->message),"%s",fmt);
}
static int leap(int64_t y){return (y&3)==0 && ((y%100)!=0 || (y%400)==0);}
static const int mdays[2][12]={{31,28,31,30,31,30,31,31,30,31,30,31},{31,29,31,30,31,30,31,31,30,31,30,31}};

/* Direct port of NumPy datetime.c:get_datetimestruct_days. */
static int64_t dts_days(const ln_datetimestruct *d){
    int64_t y=d->year-(d->month<=2);
    int64_t era=(y>=0?y:y-399)/400;
    uint32_t yoe=(uint32_t)(y-era*400);
    uint32_t doy=(153*(uint32_t)(d->month>2?d->month-3:d->month+9)+2)/5+(uint32_t)d->day-1;
    uint32_t doe=yoe*365+yoe/4-yoe/100+doy;
    return era*INT64_C(146097)+(int64_t)doe-INT64_C(719468);
}

static ln_i128 floor_div128(ln_i128 a,ln_i128 b,ln_i128 *rem){
    ln_i128 q=a/b,r=a%b; if(r<0){q--;r+=b;} if(rem)*rem=r; return q;
}

/* Civil-from-days fallback adapted from NumPy's classical 400-year decomposition. */
static int set_days(int64_t z,ln_datetimestruct *d){
    /* Howard Hinnant civil_from_days, inverse of the algorithm NumPy now uses. */
    ln_i128 zz=(ln_i128)z+719468;
    ln_i128 era=(zz>=0?zz:zz-146096)/146097;
    unsigned doe=(unsigned)(zz-era*146097);                           /* [0,146096] */
    unsigned yoe=(doe-doe/1460+doe/36524-doe/146096)/365;            /* [0,399] */
    ln_i128 y=(ln_i128)yoe+era*400;
    unsigned doy=doe-(365*yoe+yoe/4-yoe/100);
    unsigned mp=(5*doy+2)/153;
    unsigned day=doy-(153*mp+2)/5+1;
    unsigned month=mp+(mp<10?3:(unsigned)-9);
    y+=(month<=2);
    if(y<INT64_MIN||y>INT64_MAX)return -1;
    d->year=(int64_t)y;d->month=(int)month;d->day=(int)day;return 0;
}

static void add_minutes(ln_datetimestruct *d,int minutes){
    d->min+=minutes;
    int q=d->min/60,r=d->min%60;if(r<0){q--;r+=60;}d->min=r;d->hour+=q;
    q=d->hour/24;r=d->hour%24;if(r<0){q--;r+=24;}d->hour=r;
    if(q){int64_t days=dts_days(d);days+=q;(void)set_days(days,d);}
}

static int unit_from_fraction_digits(int n){
    if(n<=3)return LN_FR_ms;
    if(n<=6)return LN_FR_us;
    if(n<=9)return LN_FR_ns;
    if(n<=12)return LN_FR_ps;
    if(n<=15)return LN_FR_fs;
    return LN_FR_as;
}

static int strieq(const char *s,size_t n,const char *lit){
    size_t m=strlen(lit);if(n!=m)return 0;for(size_t i=0;i<n;i++)if(tolower((unsigned char)s[i])!=tolower((unsigned char)lit[i]))return 0;return 1;
}

static int parse2(const char **p,size_t *n,int *out){
    if(*n<2||!isdigit((unsigned char)(*p)[0])||!isdigit((unsigned char)(*p)[1]))return -1;
    *out=10*((*p)[0]-'0')+((*p)[1]-'0');*p+=2;*n-=2;return 0;
}

static int parse_iso_struct(const char *str,ln_datetimestruct *out,ln_datetime_unit *best,int *had_tz,ln_error *e){
    const char *orig=str;size_t len=strlen(str);memset(out,0,sizeof(*out));out->month=1;out->day=1;if(had_tz)*had_tz=0;
    if(len==0||strieq(str,len,"NaT")){out->year=LN_DATETIME_NAT;*best=LN_FR_GENERIC;return 0;}
    if(strieq(str,len,"today")){
        time_t now=time(NULL);struct tm *tmv=localtime(&now);if(!tmv){dtserr(e,"failed to get local time",NULL,0);return -1;}
        out->year=tmv->tm_year+1900;out->month=tmv->tm_mon+1;out->day=tmv->tm_mday;*best=LN_FR_D;return 0;
    }
    if(strieq(str,len,"now")){
        time_t now=time(NULL);struct tm *tmv=gmtime(&now);if(!tmv){dtserr(e,"failed to get UTC time",NULL,0);return -1;}
        out->year=tmv->tm_year+1900;out->month=tmv->tm_mon+1;out->day=tmv->tm_mday;out->hour=tmv->tm_hour;out->min=tmv->tm_min;out->sec=tmv->tm_sec;*best=LN_FR_s;return 0;
    }
    const char *p=str;size_t n=len;while(n&&isspace((unsigned char)*p)){p++;n--;}
    int neg=0;if(n&&(*p=='-'||*p=='+')){neg=*p=='-';p++;n--;}
    if(!n||!isdigit((unsigned char)*p))goto bad;
    ln_i128 yr=0;while(n&&isdigit((unsigned char)*p)){yr=yr*10+(*p-'0');if(yr>(ln_i128)INT64_MAX+1)goto range;p++;n--;}
    if(neg)yr=-yr;
    if(yr<INT64_MIN||yr>INT64_MAX)goto range;
    out->year=(int64_t)yr;
    if(!n){*best=LN_FR_Y;return 0;}if(*p!='-')goto bad;p++;n--;if(!n)goto bad;
    if(parse2(&p,&n,&out->month)<0)goto bad;
    if(out->month<1||out->month>12){dtserr(e,"Month out of range in datetime string \"%s\"",orig,0);return -1;}
    if(!n){*best=LN_FR_M;return 0;}if(*p!='-')goto bad;p++;n--;if(!n)goto bad;
    if(parse2(&p,&n,&out->day)<0)goto bad;
    if(out->day<1||out->day>mdays[leap(out->year)][out->month-1]){dtserr(e,"Day out of range in datetime string \"%s\"",orig,0);return -1;}
    if(!n){*best=LN_FR_D;return 0;}if(*p!='T'&&*p!=' ')goto bad;p++;n--;
    if(parse2(&p,&n,&out->hour)<0)goto bad;
    if(out->hour>=24){dtserr(e,"Hours out of range in datetime string \"%s\"",orig,0);return -1;}
    if(!n){*best=LN_FR_h;goto tz;}if(*p!=':'){*best=LN_FR_h;goto tz;}p++;n--;if(!n)goto bad;
    if(parse2(&p,&n,&out->min)<0)goto bad;
    if(out->min>=60){dtserr(e,"Minutes out of range in datetime string \"%s\"",orig,0);return -1;}
    if(!n){*best=LN_FR_m;goto tz;}if(*p!=':'){*best=LN_FR_m;goto tz;}p++;n--;if(!n)goto bad;
    if(parse2(&p,&n,&out->sec)<0)goto bad;
    if(out->sec>=60){dtserr(e,"Seconds out of range in datetime string \"%s\"",orig,0);return -1;}
    if(!n||*p!='.'){*best=LN_FR_s;goto tz;}
    p++;n--;
    {char digs[18];int nd=0;while(n&&isdigit((unsigned char)*p)&&nd<18){digs[nd++]=*p++;n--;}if(n&&isdigit((unsigned char)*p))goto bad;
     char buf[19];memset(buf,'0',18);if(nd)memcpy(buf,digs,(size_t)nd);buf[18]='\0';
     int us=0,ps=0,as=0;for(int i=0;i<6;i++)us=us*10+(buf[i]-'0');for(int i=6;i<12;i++)ps=ps*10+(buf[i]-'0');for(int i=12;i<18;i++)as=as*10+(buf[i]-'0');out->us=us;out->ps=ps;out->as=as;*best=(ln_datetime_unit)unit_from_fraction_digits(nd);}

tz:
    if(n){if(had_tz)*had_tz=1;
        if(*p=='Z') {p++;n--;}
        else if(*p=='+'||*p=='-'){
            int sgn=*p=='-'?-1:1,oh=0,om=0;p++;n--;if(parse2(&p,&n,&oh)<0)goto bad;if(oh>=24){dtserr(e,"Timezone hours offset out of range in datetime string \"%s\"",orig,0);return -1;}
            if(n&&!isspace((unsigned char)*p)){if(*p==':'){p++;n--;}if(parse2(&p,&n,&om)<0)goto bad;if(om>=60){dtserr(e,"Timezone minutes offset out of range in datetime string \"%s\"",orig,0);return -1;}}
            add_minutes(out,-sgn*(60*oh+om));
        }
        else if(!isspace((unsigned char)*p))goto bad;
        while(n&&isspace((unsigned char)*p)){p++;n--;}
        if(n)goto bad;
    }
    return 0;
bad:dtserr(e,"Error parsing datetime string \"%s\" at position %lld",orig,(long long)(p-orig));return -1;
range:dtserr(e,"Year out of range in datetime string \"%s\"",orig,0);return -1;
}

static ln_i128 unit_per_day(ln_datetime_unit u){
    ln_i128 p=1;switch(u){
        case LN_FR_D:return 1;case LN_FR_h:return 24;case LN_FR_m:return 24*60;case LN_FR_s:return 24*60*60;
        case LN_FR_ms:p=1000;break;case LN_FR_us:p=1000000;break;case LN_FR_ns:p=1000000000;break;
        case LN_FR_ps:p=(ln_i128)1000000000000LL;break;case LN_FR_fs:p=(ln_i128)1000000000000000LL;break;
        case LN_FR_as:p=(ln_i128)1000000000000000000LL;break;default:return 0;}
    return p*24*60*60;
}
static ln_i128 unit_per_second(ln_datetime_unit u){
    switch(u){case LN_FR_s:return 1;case LN_FR_ms:return 1000;case LN_FR_us:return 1000000;case LN_FR_ns:return 1000000000;
        case LN_FR_ps:return (ln_i128)1000000000000LL;case LN_FR_fs:return (ln_i128)1000000000000000LL;case LN_FR_as:return (ln_i128)1000000000000000000LL;default:return 0;}
}

int ln_datetime_struct_to_value(const ln_datetimestruct *d,const ln_datetime_meta *m,int64_t *out,ln_error *e){
    if(!d||!m||!out)return -1;
    if(d->year==LN_DATETIME_NAT){*out=LN_DATETIME_NAT;return 0;}
    if(m->base==LN_FR_GENERIC){dtserr(e,"Cannot create a datetime other than NaT with generic units",NULL,0);return -1;}
    /* NumPy computes this in npy_int64.  Execute the exact nested formulas
     * with uint64_t wrap, then reinterpret the bits, so the historical
     * fs/as overflow quirks are deterministic without signed-overflow UB. */
    uint64_t u=(uint64_t)dts_days(d);
    switch(m->base){
        case LN_FR_Y: u=(uint64_t)d->year-(uint64_t)1970; break;
        case LN_FR_M: u=12*((uint64_t)d->year-(uint64_t)1970)+(uint64_t)(d->month-1); break;
        case LN_FR_W: {int64_t days=dts_days(d);int64_t w=(int64_t)floor_div128((ln_i128)days,7,NULL);memcpy(&u,&w,8);break;}
        case LN_FR_D: break;
        case LN_FR_h: u=u*24+(uint64_t)d->hour; break;
        case LN_FR_m: u=(u*24+(uint64_t)d->hour)*60+(uint64_t)d->min; break;
        case LN_FR_s: u=((u*24+(uint64_t)d->hour)*60+(uint64_t)d->min)*60+(uint64_t)d->sec; break;
        case LN_FR_ms: u=(((u*24+(uint64_t)d->hour)*60+(uint64_t)d->min)*60+(uint64_t)d->sec)*1000+(uint64_t)(d->us/1000); break;
        case LN_FR_us: u=(((u*24+(uint64_t)d->hour)*60+(uint64_t)d->min)*60+(uint64_t)d->sec)*1000000ULL+(uint64_t)d->us; break;
        case LN_FR_ns: u=((((u*24+(uint64_t)d->hour)*60+(uint64_t)d->min)*60+(uint64_t)d->sec)*1000000ULL+(uint64_t)d->us)*1000ULL+(uint64_t)(d->ps/1000); break;
        case LN_FR_ps: u=((((u*24+(uint64_t)d->hour)*60+(uint64_t)d->min)*60+(uint64_t)d->sec)*1000000ULL+(uint64_t)d->us)*1000000ULL+(uint64_t)d->ps; break;
        case LN_FR_fs: u=(((((u*24+(uint64_t)d->hour)*60+(uint64_t)d->min)*60+(uint64_t)d->sec)*1000000ULL+(uint64_t)d->us)*1000000ULL+(uint64_t)d->ps)*1000ULL+(uint64_t)(d->as/1000); break;
        case LN_FR_as: u=(((((u*24+(uint64_t)d->hour)*60+(uint64_t)d->min)*60+(uint64_t)d->sec)*1000000ULL+(uint64_t)d->us)*1000000ULL+(uint64_t)d->ps)*1000000ULL+(uint64_t)d->as; break;
        default: dtserr(e,"invalid datetime unit",NULL,0);return -1;
    }
    int64_t ret;memcpy(&ret,&u,8);
    if(m->num>1)ret=(int64_t)floor_div128((ln_i128)ret,m->num,NULL);
    *out=ret;return 0;
}

int ln_datetime_value_to_struct(int64_t value,const ln_datetime_meta *m,ln_datetimestruct *d,ln_error *e){
    if(!m||!d)return -1;
    memset(d,0,sizeof(*d));d->year=1970;d->month=1;d->day=1;
    if(value==LN_DATETIME_NAT){d->year=LN_DATETIME_NAT;return 0;}
    if(m->base==LN_FR_GENERIC){dtserr(e,"Cannot convert a datetime value other than NaT with generic units",NULL,0);return -1;}
    ln_i128 x=(ln_i128)value*m->num,rem=0;
    if(m->base==LN_FR_Y){ln_i128 y=1970+x;if(y<INT64_MIN||y>INT64_MAX){dtserr(e,"datetime conversion overflow",NULL,0);return -1;}d->year=(int64_t)y;return 0;}
    if(m->base==LN_FR_M){ln_i128 q=floor_div128(x,12,&rem),y=1970+q;if(y<INT64_MIN||y>INT64_MAX)return -1;d->year=(int64_t)y;d->month=(int)rem+1;return 0;}
    if(m->base==LN_FR_W)x*=7;
    ln_i128 upd=unit_per_day(m->base==LN_FR_W?LN_FR_D:m->base);if(!upd){dtserr(e,"invalid datetime unit",NULL,0);return -1;}
    ln_i128 days=floor_div128(x,upd,&rem);if(days<INT64_MIN||days>INT64_MAX){dtserr(e,"datetime conversion overflow",NULL,0);return -1;}if(set_days((int64_t)days,d)<0){dtserr(e,"datetime year overflow",NULL,0);return -1;}
    if(m->base==LN_FR_W||m->base==LN_FR_D)return 0;
    ln_i128 hour_unit=upd/24;d->hour=(int)(rem/hour_unit);rem%=hour_unit;
    if(m->base==LN_FR_h)return 0;
    ln_i128 minute_unit=upd/(24*60);d->min=(int)(rem/minute_unit);rem%=minute_unit;
    if(m->base==LN_FR_m)return 0;
    ln_i128 ups=unit_per_second(m->base);d->sec=(int)(rem/ups);rem%=ups;
    if(m->base==LN_FR_s)return 0;
    ln_i128 attos=rem*((ln_i128)1000000000000000000LL/ups);d->us=(int)(attos/1000000000000LL);attos%=1000000000000LL;d->ps=(int)(attos/1000000LL);d->as=(int)(attos%1000000LL);return 0;
}

int ln_datetime_parse_iso8601(const char *str,const ln_dtype_descr *requested,const ln_dtype_descr **out_descr,int64_t *out_value,int *out_had_timezone,ln_error *e){
    if(!str||!out_descr||!out_value){dtserr(e,"invalid datetime string arguments",NULL,0);return -1;}if(requested&&requested->type_num!=LN_DATETIME){dtserr(e,"datetime ISO parser requires datetime64 dtype",NULL,0);return -1;}
    ln_datetimestruct d;ln_datetime_unit best;int tz=0;if(parse_iso_struct(str,&d,&best,&tz,e)<0)return -1;if(out_had_timezone)*out_had_timezone=tz;
    const ln_dtype_descr *descr=requested;
    if(d.year==LN_DATETIME_NAT){if(!descr)descr=ln_datetime_default_dtype(0);*out_descr=descr;*out_value=LN_DATETIME_NAT;return 0;}
    if(!descr||ln_datetime_metadata(descr)->base==LN_FR_GENERIC){ln_datetime_meta m={best,1};descr=ln_datetime_make_dtype(0,m,e);if(!descr)return -1;}
    if(ln_datetime_struct_to_value(&d,ln_datetime_metadata(descr),out_value,e)<0)return -1;
    *out_descr=descr;return 0;
}

static ln_datetime_unit lossless(const ln_datetimestruct *d){
    if(d->as%1000)return LN_FR_as;else if(d->as)return LN_FR_fs;else if(d->ps%1000)return LN_FR_ps;else if(d->ps)return LN_FR_ns;else if(d->us%1000)return LN_FR_us;else if(d->us)return LN_FR_ms;else if(d->sec)return LN_FR_s;else if(d->min)return LN_FR_m;else if(d->hour)return LN_FR_h;else if(d->day!=1)return LN_FR_D;else if(d->month!=1)return LN_FR_M;return LN_FR_Y;
}
static int appendf(char **p,size_t *n,const char *fmt,long long v){int q=snprintf(*p,*n,fmt,v);if(q<0||(size_t)q>=*n)return -1;*p+=q;*n-=(size_t)q;return 0;}
static int localize(ln_datetimestruct *d,int *offset){
    if(d->year<1970||d->year>=10000)return 1;
    int64_t days=dts_days(d);
    ln_i128 sec=(ln_i128)days*86400+d->hour*3600+d->min*60;
    if(sec<INT64_MIN||sec>INT64_MAX)return -1;
    time_t tt=(time_t)(int64_t)sec;struct tm *tmv=localtime(&tt);if(!tmv)return -1;
    ln_datetimestruct l=*d;l.year=tmv->tm_year+1900;l.month=tmv->tm_mon+1;l.day=tmv->tm_mday;l.hour=tmv->tm_hour;l.min=tmv->tm_min;
    int64_t localmins=dts_days(&l)*1440+l.hour*60+l.min;int64_t utcmins=days*1440+d->hour*60+d->min;
    *offset=(int)(localmins-utcmins);*d=l;return 0;
}

int ln_datetime_format_iso8601(int64_t value,const ln_datetime_meta *meta,ln_datetime_unit unit,int auto_unit,ln_datetime_timezone_mode timezone,int timezone_offset_minutes,ln_datetime_string_casting casting,char *out,size_t outlen,ln_error *e){
    if(!out||outlen<4||!meta){dtserr(e,"datetime output buffer too small",NULL,0);return -1;}ln_datetimestruct d;if(ln_datetime_value_to_struct(value,meta,&d,e)<0)return -1;if(d.year==LN_DATETIME_NAT||meta->base==LN_FR_GENERIC){snprintf(out,outlen,"NaT");return 0;}
    int tzoff=0;if(timezone==LN_DT_TZ_LOCAL){int r=localize(&d,&tzoff);if(r<0){dtserr(e,"failed to convert datetime to local time",NULL,0);return -1;}if(r>0)timezone=LN_DT_TZ_NAIVE;}else if(timezone==LN_DT_TZ_OFFSET){tzoff=timezone_offset_minutes;add_minutes(&d,tzoff);}
    ln_datetime_unit base=unit;if(auto_unit){base=lossless(&d);if((timezone==LN_DT_TZ_LOCAL||timezone==LN_DT_TZ_OFFSET)&&base<LN_FR_m)base=LN_FR_m;else if(base==LN_FR_h)base=LN_FR_m;else if(base<LN_FR_D)base=LN_FR_D;}if(base==LN_FR_W)base=LN_FR_D;if(base==LN_FR_GENERIC){snprintf(out,outlen,"NaT");return 0;}
    if((timezone==LN_DT_TZ_LOCAL||timezone==LN_DT_TZ_OFFSET)&&base<=LN_FR_D&&casting!=LN_DT_CAST_UNSAFE){dtserr(e,"Cannot create a local timezone-based date string without unsafe casting",NULL,0);return -1;}
    ln_datetime_unit prec=lossless(&d);if(casting==LN_DT_CAST_SAFE && prec>base){dtserr(e,"datetime string precision requires unsafe or same_kind casting",NULL,0);return -1;}if(casting==LN_DT_CAST_SAME_VALUE && prec>base){dtserr(e,"datetime string conversion would change the value",NULL,0);return -1;}
    char *p=out;size_t n=outlen;if(appendf(&p,&n,"%04lld",(long long)d.year)<0)goto shortbuf;if(base==LN_FR_Y)return 0;
    int q=snprintf(p,n,"-%02d",d.month);if(q<0||(size_t)q>=n)goto shortbuf;p+=q;n-=q;if(base==LN_FR_M)return 0;
    q=snprintf(p,n,"-%02d",d.day);if(q<0||(size_t)q>=n)goto shortbuf;p+=q;n-=q;if(base==LN_FR_D)return 0;
    q=snprintf(p,n,"T%02d",d.hour);if(q<0||(size_t)q>=n)goto shortbuf;p+=q;n-=q;if(base==LN_FR_h)goto tzsuffix;
    q=snprintf(p,n,":%02d",d.min);if(q<0||(size_t)q>=n)goto shortbuf;p+=q;n-=q;if(base==LN_FR_m)goto tzsuffix;
    q=snprintf(p,n,":%02d",d.sec);if(q<0||(size_t)q>=n)goto shortbuf;p+=q;n-=q;if(base==LN_FR_s)goto tzsuffix;
    {char frac[19];snprintf(frac,sizeof(frac),"%06d%06d%06d",d.us,d.ps,d.as);int nd=base==LN_FR_ms?3:base==LN_FR_us?6:base==LN_FR_ns?9:base==LN_FR_ps?12:base==LN_FR_fs?15:18;if(n<(size_t)nd+2)goto shortbuf;*p++='.';memcpy(p,frac,(size_t)nd);p+=nd;n-=(size_t)nd+1;*p='\0';}
tzsuffix:
    if(base>=LN_FR_h){if(timezone==LN_DT_TZ_UTC){if(n<2)goto shortbuf;*p++='Z';*p='\0';}
        else if(timezone==LN_DT_TZ_LOCAL||timezone==LN_DT_TZ_OFFSET){int off=tzoff,neg=off<0;if(neg)off=-off;q=snprintf(p,n,"%c%02d%02d",neg?'-':'+',off/60,off%60);if(q<0||(size_t)q>=n)goto shortbuf;}}
    return 0;
shortbuf:dtserr(e,"datetime output string too short",NULL,0);return -1;
}


int
ln_datetime_iso8601_strlen(int local, ln_datetime_unit base)
{
    int len=0;
    switch(base){
        case LN_FR_ERROR:return 62;
        case LN_FR_GENERIC:return 4;
        case LN_FR_as:len+=3; /* fallthrough */
        case LN_FR_fs:len+=3; /* fallthrough */
        case LN_FR_ps:len+=3; /* fallthrough */
        case LN_FR_ns:len+=3; /* fallthrough */
        case LN_FR_us:len+=3; /* fallthrough */
        case LN_FR_ms:len+=4; /* fallthrough */
        case LN_FR_s:len+=3; /* fallthrough */
        case LN_FR_m:len+=3; /* fallthrough */
        case LN_FR_h:len+=3; /* fallthrough */
        case LN_FR_D:case LN_FR_W:len+=3; /* fallthrough */
        case LN_FR_M:len+=3; /* fallthrough */
        case LN_FR_Y:len+=21;break;
    }
    if(base>=LN_FR_h)len+=local?5:1;
    return len+1;
}
