/* Source reference: NumPy 2.5.5 array_fromfile_binary and PyArray_ToFile. */
#define _POSIX_C_SOURCE 200809L
#define _FILE_OFFSET_BITS 64
#include "ln_raw_file.h"
#include "ln_resize.h"
#include <sys/types.h>
#include <stdint.h>

static void error(ln_error *err,const char *message)
{
    if(err)snprintf(err->message,sizeof err->message,"%s",message);
}

ln_array *ln_read_raw_file(FILE *file,const ln_dtype *dtype,ln_intp count,
                           int64_t offset,ln_error *err)
{
    if(!file||!dtype||!dtype->elsize){
        error(err,"fromfile requires an open file and a nonzero itemsize");
        return NULL;
    }
    if(offset!=0){
        off_t amount=(off_t)offset;
        if((int64_t)amount!=offset||fseeko(file,amount,SEEK_CUR)!=0){
            error(err,"cannot seek to binary input offset");
            return NULL;
        }
    }
    size_t width=dtype->elsize;
    if(count<0){
        off_t start=ftello(file);
        if(start<0||fseeko(file,0,SEEK_END)!=0){
            error(err,"cannot determine binary input size");
            return NULL;
        }
        off_t end=ftello(file);
        if(fseeko(file,start,SEEK_SET)!=0||end<0){
            error(err,"cannot restore binary input position");
            return NULL;
        }
        if(end<start&&(uintmax_t)(start-end)>=width){
            error(err,"binary input offset is beyond the end of the file");
            return NULL;
        }
        uintmax_t available=end>start?(uintmax_t)(end-start)/width:0;
        if(available>INTPTR_MAX){
            error(err,"binary input has too many elements");
            return NULL;
        }
        count=(ln_intp)available;
    }
    ln_array *result=ln_array_new(1,&count,dtype,0,0,err);
    if(!result||count==0)return result;
    size_t read_count=fread(result->data,width,(size_t)count,file);
    if(ferror(file)){
        error(err,"cannot read binary input");
        ln_array_free(result);
        return NULL;
    }
    if(read_count!=(size_t)count){
        ln_intp actual=(ln_intp)read_count;
        if(ln_array_resize_inplace(result,1,&actual,err)<0){
            ln_array_free(result);
            return NULL;
        }
        if(!actual)result->strides[0]=(ln_intp)width;
    }
    return result;
}

int ln_write_raw_file(FILE *file,const ln_array *array,ln_error *err)
{
    if(!file||!array){
        error(err,"tofile requires an open file and an array");
        return -1;
    }
    ln_intp count=ln_array_size(array);
    if(count<0){
        error(err,"binary output has too many elements");
        return -1;
    }
    if(!count||!array->descr->elsize)return 0;
    size_t width=array->descr->elsize;
    size_t written=0;
    if(array->flags&LN_ARRAY_C_CONTIGUOUS){
        written=fwrite(array->data,width,(size_t)count,file);
    }else{
        ln_intp coord[LN_MAXDIMS]={0};
        for(;written<(size_t)count;++written){
            const char *cell=array->data;
            for(int d=0;d<array->nd;++d)cell+=coord[d]*array->strides[d];
            if(fwrite(cell,width,1,file)!=1)break;
            for(int d=array->nd-1;d>=0;--d){
                if(++coord[d]<array->dimensions[d])break;
                coord[d]=0;
            }
        }
    }
    if(written!=(size_t)count||fflush(file)!=0){
        error(err,"cannot write binary output");
        return -1;
    }
    return 0;
}
