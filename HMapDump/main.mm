//
//  main.m
//  HMapDump
//
//  Created by Unix_Kernel on 6/28/24.
//  Copyright © 2024 杭城小刘. All rights reserved.
//

#include "HeaderMapTypes.h"
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

unsigned getEndianAdjustedWord(unsigned X, bool NeedsBSwap) {
  if (!NeedsBSwap) return X;
  return ByteSwap_32(X);
}

void dump(const char *path) {
    int fd = open(path, O_RDONLY|O_CLOEXEC);
    if (fd < 0) {
        warn(/*EX_NOINPUT,*/ "%s: cannot open", path);
        return;
    }
    
    struct HMapHeader header;
    // 二进制数据。按照 HMapHeader 的结构，读取 sizeof 长度的数据
    ssize_t nread = read(fd, &header, sizeof(header));
    if (nread < 0) {
        warn(/*EX_IOERR,*/ "%s: failed to read header", path);
        (void)close(fd);
        return;
    } else if ((size_t)nread < sizeof(header)) {
        warn(
            /*EX_DATAERR,*/
            "%s: short read: expected %zu bytes, read only %zd",
            path, sizeof(header), nread);
        (void)close(fd);
        return;
    }

    bool is_swapped = false;
    if (header.Magic == HMAP_HeaderMagicNumber
        && header.Version == HMAP_HeaderVersion) {
        is_swapped = false;
    } else if (header.Magic == ByteSwap_32(HMAP_HeaderMagicNumber)
        && header.Version == ByteSwap_16(HMAP_HeaderVersion)) {
        is_swapped = true;
    } else {
        warn(/*EX_DATAERR,*/ "header lacks HMAP magic");
        (void)close(fd);
        return;
    }
    
    const uint32_t bucket_count = is_swapped ? getSwappedBytes(header.NumBuckets) : header.NumBuckets;
    printf("Header map: %s\n"
        "\tHash bucket count: %" PRIu32 "\n"
        "\tString table entry count: %" PRIu32 "\n"
        "\tMax value length: %" PRIu32 " bytes\n",
        path,
        bucket_count,
        getEndianAdjustedWord(header.NumEntries, is_swapped),
        getEndianAdjustedWord(header.MaxValueLength, is_swapped));

    struct stat stat;
    int stat_err = fstat(fd, &stat);
    if (stat_err) {
        warn("%s: fstat failed; cannot dump buckets", path);
        (void)close(fd);
        return;
    }
    
    off_t hmap_length = stat.st_size;
    const void *hmap = mmap(0, hmap_length, PROT_READ, MAP_FILE|MAP_PRIVATE, fd, 0 /*offset*/);
    (void)close(fd);
    
    if (MAP_FAILED == hmap) {
        warn("%s: failed to mmap; cannot dump buckets", path);
        return;
    }

    const char *raw = (const char *)hmap;
    // buckets 紧跟在 Header 后面。所以 Base + slide = bucket 地址。base 就是 hmap，slide 就是 sizeOf（HMapHeader）
    const struct HMapBucket *const buckets = (const struct HMapBucket *const)(raw
            + sizeof(struct HMapHeader));
    // HMap文件中，String Payload 地址 = Base + Slide = HMap 地址 + SizeOf(HMapHeader + bucketCount * sizeOf(HMapBucket))
    const char *const string_table = (raw
            + sizeof(struct HMapHeader)
            + bucket_count*sizeof(struct HMapBucket));
    int e_bucktes = 0;
    for (uint32_t i = 0; i < bucket_count; ++i) {
        const struct HMapBucket *const bucket = &(buckets[i]);
        if (getEndianAdjustedWord(bucket->Key, is_swapped) == HMAP_EmptyBucketKey) { continue; }
        ++e_bucktes;
        const char *key = string_table + getEndianAdjustedWord(bucket->Key, is_swapped);
        const char *prefix = string_table + getEndianAdjustedWord(bucket->Prefix, is_swapped);
        const char *suffix = string_table + getEndianAdjustedWord(bucket->Suffix, is_swapped);
        
        printf("\t- Bucket %" PRIu32 ": "
            "[Key: %s] -> [Prefix: %s], [Suffix: %s]\n",
            i,
            key, prefix, suffix);
    }
    printf("\t No empty hash bucket count: %" PRIu32 "\n", e_bucktes);
}

int main(int argc, const char *argv[]) {
    // 路径参数必须传进来
    if (argc < 2) {
        fprintf(
                stderr,
                "usage: %s HMAP_FILE [HMAP_FILE...]\n\n"
                "Dump clang headermap (.hmap file) contents.\n\n"
                "See: https://github.com/llvm-mirror/clang/blob/release_40/include/clang/Lex/HeaderMapTypes.h\n"
                "and related files\n",
                getprogname());
        return EX_USAGE;
    }
    
    for (int i = 1; i < argc; i++) {
        dump(argv[i]);
        putchar('\n');
    }
    return EXIT_SUCCESS;
}
