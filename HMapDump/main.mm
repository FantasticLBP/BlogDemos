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
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#define COLOR_RESET   "\033[0m"
#define COLOR_RED     "\033[31m"
#define COLOR_GREEN   "\033[32m"
#define COLOR_YELLOW  "\033[33m"
#define COLOR_BLUE    "\033[34m"
#define COLOR_MAGENTA "\033[35m"
#define COLOR_CYAN    "\033[36m"
#define COLOR_BOLD    "\033[1m"

// 假设HeaderMapTypes.h中定义了这些函数
extern uint32_t ByteSwap_32(uint32_t value);
extern uint16_t ByteSwap_16(uint16_t value);
extern uint32_t getSwappedBytes(uint32_t value);

unsigned getEndianAdjustedWord(unsigned X, bool NeedsBSwap) {
  if (!NeedsBSwap) return X;
  return ByteSwap_32(X);
}

// 计算字符串长度的安全函数
size_t safe_strlen(const char *str) {
    return str ? strlen(str) : 0;
}

// 智能拼接路径，处理多余的路径分隔符
void smart_path_join(char *dest, size_t size, const char *prefix, const char *suffix) {
    size_t prefix_len = safe_strlen(prefix);
    size_t suffix_len = safe_strlen(suffix);
    
    if (prefix_len == 0) {
        snprintf(dest, size, "%s", suffix);
        return;
    }
    
    if (suffix_len == 0) {
        snprintf(dest, size, "%s", prefix);
        return;
    }
    
    // 检查prefix是否以路径分隔符结尾
    bool prefix_has_sep = (prefix[prefix_len - 1] == '/' || prefix[prefix_len - 1] == '\\');
    // 检查suffix是否以路径分隔符开头
    bool suffix_has_sep = (suffix[0] == '/' || suffix[0] == '\\');
    
    if (prefix_has_sep && suffix_has_sep) {
        // 两个都有分隔符，去掉一个
        snprintf(dest, size, "%.*s%s", (int)(prefix_len - 1), prefix, suffix);
    } else if (!prefix_has_sep && !suffix_has_sep) {
        // 两个都没有分隔符，添加一个
        snprintf(dest, size, "%s/%s", prefix, suffix);
    } else {
        // 只有一个有分隔符，直接拼接
        snprintf(dest, size, "%s%s", prefix, suffix);
    }
}

void dump(const char *path) {
    int fd = open(path, O_RDONLY|O_CLOEXEC);
    if (fd < 0) {
        warn(/*EX_NOINPUT,*/ "%s: cannot open", path);
        return;
    }
    
    struct HMapHeader header;
    // 1. 二进制数据。按照 HMapHeader 的结构，读取 sizeof 长度的数据
    ssize_t nread = read(fd, &header, sizeof(header));
    if (nread < 0) {
        warn(/*EX_IOERR,*/ "%s: failed to read header", path);
        (void)close(fd);
        return;
    }
    if ((size_t)nread < sizeof(header)) {
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
    // 2. buckets 紧跟在 Header 后面。所以 Base + slide = bucket 地址。base 就是 hmap，slide 就是 sizeOf（HMapHeader）
    const struct HMapBucket *const buckets = (const struct HMapBucket *const)(raw + sizeof(struct HMapHeader));
    // 3. HMap文件中，String Payload 地址 = Base + Slide = HMap 地址 + SizeOf(HMapHeader + bucketCount * sizeOf(HMapBucket))
    const char *const string_table = (raw + sizeof(struct HMapHeader) + bucket_count*sizeof(struct HMapBucket));
    int e_buckets = 0;
    
    // 计算各列最大宽度
    size_t max_key_len = 4;      // "Key" 标题长度
    size_t max_prefix_len = 6;   // "Prefix" 标题长度
    size_t max_suffix_len = 6;   // "Suffix" 标题长度
    size_t max_fullpath_len = 8; // "Full Path" 标题长度
    
    // 第一遍扫描：计算最大列宽
    for (uint32_t i = 0; i < bucket_count; ++i) {
        const struct HMapBucket *const bucket = &(buckets[i]);
        if (getEndianAdjustedWord(bucket->Key, is_swapped) == HMAP_EmptyBucketKey) {
            continue;
        }
        
        const char *key = string_table + getEndianAdjustedWord(bucket->Key, is_swapped);
        const char *prefix = string_table + getEndianAdjustedWord(bucket->Prefix, is_swapped);
        const char *suffix = string_table + getEndianAdjustedWord(bucket->Suffix, is_swapped);
        
        // 计算fullpath的长度 - 修复：使用实际拼接后的长度
        char temp_fullpath[1024]; // 使用足够大的临时缓冲区
        smart_path_join(temp_fullpath, sizeof(temp_fullpath), prefix, suffix);
        size_t fullpath_len = safe_strlen(temp_fullpath);
        
        // 更新最大列宽
        if (safe_strlen(key) > max_key_len) {
            max_key_len = safe_strlen(key);
        }
        
        if (safe_strlen(prefix) > max_prefix_len) {
            max_prefix_len = safe_strlen(prefix);
        }
        
        if (safe_strlen(suffix) > max_suffix_len) {
            max_suffix_len = safe_strlen(suffix);
        }
        
        if (fullpath_len > max_fullpath_len) {
            max_fullpath_len = fullpath_len;
        }
        
        e_buckets++;
    }
    
    // 确保各列有最小宽度
    if (max_key_len < 4) max_key_len = 4;
    if (max_prefix_len < 6) max_prefix_len = 6;
    if (max_suffix_len < 6) max_suffix_len = 6;
    if (max_fullpath_len < 8) max_fullpath_len = 8;
    
    // 美化分隔线
    printf(COLOR_BOLD "══════════════════════════════════════════════════════════════════════════════\n" COLOR_RESET);
    
    // 使用表情符号和颜色的摘要信息
    printf(COLOR_BOLD COLOR_BLUE "📊 [ Summary ]\n" COLOR_RESET);
    printf(COLOR_YELLOW "  • 🪣 Hash bucket count    : " COLOR_GREEN "%" PRIu32 "\n" COLOR_RESET, bucket_count);
    printf(COLOR_YELLOW "  • 📝 String table entries : " COLOR_GREEN "%" PRIu32 "\n" COLOR_RESET,
           getEndianAdjustedWord(header.NumEntries, is_swapped));
    printf(COLOR_YELLOW "  • 📏 Max value length     : " COLOR_GREEN "%" PRIu32 " bytes\n" COLOR_RESET,
           getEndianAdjustedWord(header.MaxValueLength, is_swapped));
    printf(COLOR_YELLOW "  • ✅ Non-empty buckets    : " COLOR_GREEN "%d (%.1f%% fill rate)\n" COLOR_RESET,
           e_buckets, (float)e_buckets / bucket_count * 100);
    printf(COLOR_YELLOW "  • ❌ Empty buckets        : " COLOR_GREEN "%d\n\n" COLOR_RESET,
           bucket_count - e_buckets);
    
    // 打印表格标题
    printf(COLOR_BOLD COLOR_BLUE "🔍 [ Header Map Entries ]\n" COLOR_RESET);
    
    // 打印表格顶部
    printf(COLOR_BOLD "┌");
    for (size_t i = 0; i < 10; i++) printf("─");
    printf("┬");
    for (size_t i = 0; i < max_key_len; i++) printf("─");
    printf("┬");
    for (size_t i = 0; i < max_prefix_len; i++) printf("─");
    printf("┬");
    for (size_t i = 0; i < max_suffix_len; i++) printf("─");
    printf("┬");
    for (size_t i = 0; i < max_fullpath_len; i++) printf("─");
    printf("┐\n" COLOR_RESET);
    
    // 打印表头
    printf(COLOR_BOLD "│ " COLOR_MAGENTA "%-10s" COLOR_RESET COLOR_BOLD " │ " COLOR_MAGENTA "%-*s" COLOR_RESET COLOR_BOLD " │ " COLOR_MAGENTA "%-*s" COLOR_RESET COLOR_BOLD " │ " COLOR_MAGENTA "%-*s" COLOR_RESET COLOR_BOLD " │ " COLOR_MAGENTA "%-*s" COLOR_RESET COLOR_BOLD " │\n" COLOR_RESET,
           "Bucket #", (int)max_key_len, "Key", (int)max_prefix_len, "Prefix", (int)max_suffix_len, "Suffix", (int)max_fullpath_len, "Full Path");
    
    // 打印分隔线
    printf(COLOR_BOLD "├");
    for (size_t i = 0; i < 10; i++) printf("─");
    printf("┼");
    for (size_t i = 0; i < max_key_len; i++) printf("─");
    printf("┼");
    for (size_t i = 0; i < max_prefix_len; i++) printf("─");
    printf("┼");
    for (size_t i = 0; i < max_suffix_len; i++) printf("─");
    printf("┼");
    for (size_t i = 0; i < max_fullpath_len; i++) printf("─");
    printf("┤\n" COLOR_RESET);

    // 用于存储拼接后的完整路径
    char *fullpath = (char*)malloc(max_fullpath_len + 1);
    if (!fullpath) {
        warn("%s: failed to allocate memory for fullpath", path);
        (void)munmap((void *)hmap, hmap_length);
        return;
    }
    
    // 第二遍扫描：打印内容
    // 3. 遍历 bucketCount 次，依次取出 key、prefix、suffix
    for (uint32_t i = 0; i < bucket_count; ++i) {
        const struct HMapBucket *const bucket = &(buckets[i]);
        if (getEndianAdjustedWord(bucket->Key, is_swapped) == HMAP_EmptyBucketKey) {
            continue;
        }
        
        const char *key = string_table + getEndianAdjustedWord(bucket->Key, is_swapped);
        const char *prefix = string_table + getEndianAdjustedWord(bucket->Prefix, is_swapped);
        const char *suffix = string_table + getEndianAdjustedWord(bucket->Suffix, is_swapped);
        
        // 智能拼接路径 - 修复：确保分配足够空间
        smart_path_join(fullpath, max_fullpath_len + 1, prefix, suffix);
        
        // 打印行
        printf("│ %-10" PRIu32 " │ %-*s │ %-*s │ %-*s │ %-*s │\n",
               i,
               (int)max_key_len, key,
               (int)max_prefix_len, prefix,
               (int)max_suffix_len, suffix,
               (int)max_fullpath_len, fullpath);
    }
    
    // 释放内存
    free(fullpath);
    
    // 打印表格底部
    printf(COLOR_BOLD "└");
    for (size_t i = 0; i < 10; i++) printf("─");
    printf("┴");
    for (size_t i = 0; i < max_key_len; i++) printf("─");
    printf("┴");
    for (size_t i = 0; i < max_prefix_len; i++) printf("─");
    printf("┴");
    for (size_t i = 0; i < max_suffix_len; i++) printf("─");
    printf("┴");
    for (size_t i = 0; i < max_fullpath_len; i++) printf("─");
    printf("┘\n" COLOR_RESET);
       
    // 添加结束表情
    printf(COLOR_GREEN "\n✨ Analysis complete! Found %d mappings in %d buckets.\n" COLOR_RESET,
              e_buckets, bucket_count);
              
    // 释放内存映射
    if (munmap((void *)hmap, hmap_length) == -1) {
        warn("%s: failed to unmap file", path);
    }
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
