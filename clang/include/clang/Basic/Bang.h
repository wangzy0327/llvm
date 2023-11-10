//===--- Bang.h - Utilities for compiling BANG code  ------------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_CLANG_BASIC_BANG_H
#define LLVM_CLANG_BASIC_BANG_H


namespace llvm {
class StringRef;
} // namespace llvm

namespace clang {

enum class BangVersion {
  UNKNOWN,
  BANG_10,
  BANG_20,
  BANG_30,
  BANG_35,
};
const char *BangVersionToString(BangVersion V);

// Sort by arch number value, and tp_xxx list before mtp_xxx for same arch number.
// NOTE(zhouxiaoyong): 'tp_120 < tp_110 < mtp_100' is one exception.
// More info see: http://gitlab.software.cambricon.com/neuware/software/compiler/mlu-architecture-whitepaper/blob/master/BANG-Arch/BANG-Arch.rst // NOLINT
enum class BangArch {
  UNKNOWN,
  MTP_100,
  TP_110,
  TP_120,
  MTP_1FF, // MLU1XX Series Max
  TP_220,
  MTP_220,
  TP_270,
  MTP_270,
  MTP_290,
  MTP_2FF, // MLU2XX Series Max
  TP_322,
  MTP_322,
  TC_303,
  MTP_372,
  TC_306,
  MTP_392,
  // This must be the last enum value
  FUTURE,
};
const char *BangArchToString(BangArch A);

// The input should have the form "MTP100".
// BangArch StringToBangArch(llvm::StringRef S);
BangArch StringToBangArch(llvm::StringRef S);

// VirtualArch only collect mtp(multi-tensor-processor) architecture
// compute_10: mtp_100
// compute_20: mtp_220 + mtp_270 + mtp_290
// compute_30: mtp_322 + mtp_372 + ...
// compute_35: mtp_392 + ...
enum class BangVirtualArch {
  UNKNOWN,
  // BANG 1.0 based on 1H arch, with compute_10 capability
  COMPUTE_10,
  // BANG 2.0 based on 1M arch, with compute_20 capability
  COMPUTE_20,
  // BANG 3.0 based on 1V arch, with compute_30 capability
  COMPUTE_30,
  // BANG 3.5 based on 1V arch, with compute_35 capability
  COMPUTE_35,
};
const char *BangVirtualArchToString(BangVirtualArch A);

// The input should have the form "MTP100".
BangVirtualArch StringToBangVirtualArch(llvm::StringRef S);

/// Get the compute_xx corresponding to an MLUxxx.
BangVirtualArch VirtualArchForBangArch(BangArch A);

/// Get the earliest BangVersion that supports the given BangArch.
BangVersion MinVersionForBangArch(BangArch A);

enum BangMemcpyDirection {
  GDRAM2NRAM = 0,
  NRAM2GDRAM,
  LDRAM2NRAM,
  NRAM2LDRAM,
  GDRAM2WRAM,
  WRAM2GDRAM,
  LDRAM2WRAM,
  WRAM2LDRAM,
  NRAM2NRAM,
  NRAM2WRAM,
  WRAM2NRAM,
  GDRAM2SRAM,
  SRAM2GDRAM,
  LDRAM2SRAM,
  SRAM2LDRAM,
  SRAM2NRAM,
  NRAM2SRAM,
  SRAM2WRAM,
  WRAM2SRAM,
  GDRAM2GDRAM,
  GDRAM2LDRAM,
  LDRAM2GDRAM,
  LDRAM2LDRAM,
  SRAM2SRAM,
};

} // namespace clang

#endif
