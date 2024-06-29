//
//  main.m
//  HMapWritor
//
//  Created by Unix_Kernel on 6/28/24.
//  Copyright © 2024 杭城小刘. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "HeaderMapTypes.h"
#include <stdio.h>
#include <stdlib.h>
#include <sysexits.h>
#include <err.h>
#include <fcntl.h>
#include <stdbool.h>
#include <inttypes.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>
#include <assert.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <string>
#include <malloc/malloc.h>
#include <string.h>
#include <map>

void write();
// The header map hash function.
static inline unsigned getHash(std::string Str) {
    unsigned Result = 0;
    for (char C : Str)
        Result += C * 13;
    return Result;
    
    return Result;
}

template <class FileTy> struct FileMaker {
    FileTy &File;
    unsigned SI = 1;
    unsigned BI = 0;
    std::string Bytes;
    FileMaker(FileTy &File) : File(File) {}
    
    unsigned addString(std::string S) {
        Bytes = Bytes + '\0' + S.data();
        auto OldSI = SI;
        SI += S.size() + 1;
        return OldSI;
    }
    
    bool isVaild() {
        assert(SI <= File.Bytes);
        return SI <= File.Bytes;
    }
    
    NSData *getBuffer() const {
        NSMutableData *data = [NSMutableData dataWithBytes:&(File.mapile.Header) length:sizeof(struct HMapHeader)];
        [data appendData:[NSData dataWithBytes:(File.mapile.Buckets) length:sizeof(struct HMapBucket) * File.NumBuckets]];
        [data appendData:[NSData dataWithBytes:Bytes.data() length:File.Bytes]];
        return data;
    }
    
    void addBucket(unsigned Hash, unsigned Key, unsigned Prefix, unsigned Suffix) {
        assert(!(File.mapile.Header.NumBuckets & (File.mapile.Header.NumBuckets - 1)));
        unsigned I = Hash & (File.mapile.Header.NumBuckets - 1);
        
        do {
            if (!File.mapile.Buckets[I].Key) {
                
                File.mapile.Buckets[I].Key = Key;
                File.mapile.Buckets[I].Prefix = Prefix;
                File.mapile.Buckets[I].Suffix = Suffix;
                (++File.mapile.Header.NumEntries);
                return;
            }
            ++I;
            // 空槽位
            I &= File.mapile.Header.NumBuckets - 1;
            
        } while (I != (Hash & (File.mapile.Header.NumBuckets - 1)));
    }
};

struct MapFile {
    HMapHeader Header;
    HMapBucket *Buckets;
    unsigned char *Bytes;
};

struct MapFileWithCount {
    MapFile mapile;
    unsigned Bytes;
    unsigned NumBuckets;
    
    void init() {
        memset(&mapile, 0, sizeof(MapFile));
        mapile.Header.Magic = HMAP_HeaderMagicNumber;
        mapile.Header.Version = HMAP_HeaderVersion;
    }
    void setNumBuckets(unsigned nums) {
        NumBuckets = nums;
        mapile.Header.NumBuckets = nums;
        mapile.Buckets = new HMapBucket[nums * sizeof(HMapBucket)]();
        mapile.Header.StringsOffset = sizeof(struct HMapHeader) + nums * sizeof(struct HMapBucket);
        
    }
    void setNumBytes(unsigned bytes) {
        Bytes = bytes;
    }
    
    void swapBytes() {
        mapile.Header.Magic = getSwappedBytes(mapile.Header.Magic);
        mapile.Header.Version = getSwappedBytes(mapile.Header.Version);
        mapile.Header.NumBuckets = getSwappedBytes(mapile.Header.NumBuckets);
        mapile.Header.StringsOffset = getSwappedBytes(mapile.Header.StringsOffset);
    }
};


void write(NSArray *array, const char *writeToPath) {
    unsigned count = (unsigned)array.count < 8 ? 8 : (unsigned)array.count;
    unsigned nums = count;
    
    typedef MapFileWithCount FileTy;
    FileTy File;
    File.init();
    File.setNumBuckets(nums);
    
    FileMaker<FileTy> Maker(File);
    std::map<std::string, unsigned> map;
    auto setString = [&](std::string key) -> unsigned {
        unsigned a = map[key];
        if (!a) {
            a = Maker.addString(key);
            map[key] = a;
        }
        return a;
    };

    for (int i = 0; i < array.count; i++) {
        NSArray *value = array[i];
        NSString *key = value[0];
        NSString *path = value[1];
        NSString *suffix = value[2];
        unsigned a = setString(key.UTF8String);
        unsigned b = setString(path.UTF8String);
        unsigned c = setString(suffix.UTF8String);
        Maker.addBucket(getHash(key.lowercaseString.UTF8String), a, b, c );
    }
    File.setNumBytes(Maker.SI);
    if (Maker.isVaild()) {
        FILE *fp = fopen(writeToPath,"w");;
        if(!fp) {
            warn(/*EX_NOINPUT,*/ "%s: cannot open", writeToPath);
            return;
        }
        NSData *data = Maker.getBuffer();
        ssize_t nwrite = fwrite(data.bytes,data.length,1,fp);
        if (nwrite < 0) {
            warn(/*EX_IOERR,*/ "%s: failed to write file", writeToPath);
            (void)fclose(fp);
            return;
        }
        fclose(fp);
    }
}

int main(int argc, const char *argv[]) {
    if (argc < 3) {
        fprintf(
                stderr,
                "usage: %s HMAP_FILE [HMAP_FILE...]\n\n"
                "Dump clang headermap (.hmap file) contents.\n\n"
                "See: https://github.com/llvm-mirror/clang/blob/release_40/include/clang/Lex/HeaderMapTypes.h\n"
                "and related files\n",
                getprogname());
        return EX_USAGE;
    }
    
    const char *path = argv[1];
    NSError *error = nil;
    NSData *jsonData = [NSData dataWithContentsOfFile:[NSString stringWithUTF8String:path]];
    
    NSArray * array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    
    if (array && error== nil) {
        const char *writePath = argv[2];
        write(array, writePath);
    }
    return EXIT_SUCCESS;
}
