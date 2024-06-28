//
//  HeaderMapTypes.h
//  HMapDump
//
//  Created by Unix_Kernel on 6/28/24.
//  Copyright © 2024 杭城小刘. All rights reserved.
//

#ifndef HeaderMapTypes_h
#define HeaderMapTypes_h

#include <stdio.h>
#include <stdlib.h>

enum {
  HMAP_HeaderMagicNumber = ('h' << 24) | ('m' << 16) | ('a' << 8) | 'p',
  HMAP_HeaderVersion = 1,
  HMAP_EmptyBucketKey = 0
};

struct HMapBucket {
  uint32_t Key;    // Offset (into strings) of key.
  uint32_t Prefix; // Offset (into strings) of value prefix.
  uint32_t Suffix; // Offset (into strings) of value suffix.
};

struct HMapHeader {
  uint32_t Magic;          // Magic word, also indicates byte order.
  uint16_t Version;        // Version number -- currently 1.
  uint16_t Reserved;       // Reserved for future use - zero for now.
  uint32_t StringsOffset;  // Offset to start of string pool.
  uint32_t NumEntries;     // Number of entries in the string table.
  uint32_t NumBuckets;     // Number of buckets (always a power of 2).
  uint32_t MaxValueLength; // Length of longest result path (excluding nul).
  // An array of 'NumBuckets' HMapBucket objects follows this header.
  // Strings follow the buckets, at StringsOffset.
};

// 字节序处理
inline uint32_t ByteSwap_32(uint32_t value) {
#if defined(__llvm__) || (defined(__GNUC__) && !defined(__ICC))
  return __builtin_bswap32(value);
#elif defined(_MSC_VER) && !defined(_DEBUG)
  return _byteswap_ulong(value);
#else
  uint32_t Byte0 = value & 0x000000FF;
  uint32_t Byte1 = value & 0x0000FF00;
  uint32_t Byte2 = value & 0x00FF0000;
  uint32_t Byte3 = value & 0xFF000000;
  return (Byte0 << 24) | (Byte1 << 8) | (Byte2 >> 8) | (Byte3 >> 24);
#endif
}
inline uint16_t ByteSwap_16(uint16_t value) {
#if defined(_MSC_VER) && !defined(_DEBUG)
  // The DLL version of the runtime lacks these functions (bug!?), but in a
  // release build they're replaced with BSWAP instructions anyway.
  return _byteswap_ushort(value);
#else
  uint16_t Hi = value << 8;
  uint16_t Lo = value >> 8;
  return Hi | Lo;
#endif
}

inline unsigned short getSwappedBytes(unsigned short C) { return ByteSwap_16(C); }
inline   signed short getSwappedBytes(  signed short C) { return ByteSwap_16(C); }
inline unsigned int   getSwappedBytes(unsigned int   C) { return ByteSwap_32(C); }
inline   signed int   getSwappedBytes(  signed int   C) { return ByteSwap_32(C); }

#endif /* HeaderMapTypes_h */
