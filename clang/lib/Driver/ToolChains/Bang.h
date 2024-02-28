//===--- Bang.h - Bang ToolChain Implementations ----------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_CLANG_LIB_DRIVER_TOOLCHAINS_BANG_H
#define LLVM_CLANG_LIB_DRIVER_TOOLCHAINS_BANG_H

#include "SYCL.h"
#include "clang/Basic/Cuda.h"
#include "clang/Basic/Bang.h"
#include "clang/Driver/Action.h"
#include "clang/Driver/Multilib.h"
#include "clang/Driver/Tool.h"
#include "clang/Driver/ToolChain.h"
#include "llvm/ADT/Optional.h"
#include "llvm/Support/Compiler.h"
#include "llvm/Support/VersionTuple.h"
#include <bitset>
#include <set>
#include <vector>

namespace clang {
namespace driver {

/// A class to find a viable Bang installation
class BangInstallationDetector {
private:
  const Driver &D;
  bool IsValid = false;
  BangVersion Version = BangVersion::UNKNOWN;
  std::string DetectedVersion;
  bool DetectedVersionIsNotSupported = false;
  std::string InstallPath;
  std::string BinPath;
  std::string LibPath;
  std::string LibDevicePath;
  std::string IncludePath;
  llvm::StringMap<std::string> LibDeviceMap;

  // BANG architectures for which we have raised an error in
  // CheckBangVersionSupportsArch.
  mutable std::bitset<(int)CudaArch::LAST> ArchsWithBadVersion;

public:
  BangInstallationDetector(const Driver &D, const llvm::Triple &HostTriple,
                           const llvm::opt::ArgList &Args);

  void AddBangIncludeArgs(const llvm::opt::ArgList &DriverArgs,
                          llvm::opt::ArgStringList &CC1Args) const;

  /// Emit an error if Version does not support the given Arch.
  ///
  /// If either Version or Arch is unknown, does not emit an error.  Emits at
  /// most one error per Arch.
  void CheckBangVersionSupportsArch(CudaArch Arch) const;

  /// Check whether we detected a valid Cuda install.
  bool isValid() const { return IsValid; }
  /// Print information about the detected BANG installation.
  void print(raw_ostream &OS) const;

  /// Get the detected Bang install's version.
  BangVersion version() const { return Version; }
  /// Get the detected Bang installation path.
  StringRef getInstallPath() const { return InstallPath; }
  /// Get the detected path to Bang's bin directory.
  StringRef getBinPath() const { return BinPath; }
  /// Get the detected Bang Include path.
  StringRef getIncludePath() const { return IncludePath; }
  /// Get the detected Bang library path.
  StringRef getLibPath() const { return LibPath; }
  /// Get the detected Bang device library path.
  StringRef getLibDevicePath() const { return LibDevicePath; }
  /// Get libdevice file for given architecture
  std::string getLibDeviceFile(StringRef Mlu) const {
    return LibDeviceMap.lookup(Mlu);
  }
  void WarnIfUnsupportedVersion();

private:
  void ParseBangVersionFile(llvm::StringRef V);
};

namespace tools {
namespace MLISA {

// Run llc, the MLISA backend
// class LLVM_LIBRARY_VISIBILITY BackendCompiler : public Tool {
//  public:
//    BackendCompiler(const ToolChain &TC)
//        : Tool("MLISA::Backend", "llc", TC) {}

//    bool hasIntegratedCPP() const override { return false; }

//    void ConstructJob(Compilation &C, const JobAction &JA,
//                      const InputInfo &Output, const InputInfoList &Inputs,
//                      const llvm::opt::ArgList &TCArgs,
//                      const char *LinkingOutput) const override;
// };


// Run cnas, the MLISA assembler.
class LLVM_LIBRARY_VISIBILITY Assembler : public Tool {
 public:
   Assembler(const ToolChain &TC)
       : Tool("MLISA::Assembler", "cnas", TC) {}

   bool hasIntegratedCPP() const override { return false; }

   void ConstructJob(Compilation &C, const JobAction &JA,
                     const InputInfo &Output, const InputInfoList &Inputs,
                     const llvm::opt::ArgList &TCArgs,
                     const char *LinkingOutput) const override;
};

// Runs fatbinary, which combines MLU object files ("fatbin" files) and/or MLISA
// assembly into a single output file.
class LLVM_LIBRARY_VISIBILITY Linker : public Tool {
 public:
   Linker(const ToolChain &TC)
       : Tool("MLISA::Linker", "fatbinary", TC) {}

   bool hasIntegratedCPP() const override { return false; }

   void ConstructJob(Compilation &C, const JobAction &JA,
                     const InputInfo &Output, const InputInfoList &Inputs,
                     const llvm::opt::ArgList &TCArgs,
                     const char *LinkingOutput) const override;
};

class LLVM_LIBRARY_VISIBILITY OpenMPLinker : public Tool {
 public:
   OpenMPLinker(const ToolChain &TC)
       : Tool("MLISA::OpenMPLinker", "cnlink", TC) {}

   bool hasIntegratedCPP() const override { return false; }

   void ConstructJob(Compilation &C, const JobAction &JA,
                     const InputInfo &Output, const InputInfoList &Inputs,
                     const llvm::opt::ArgList &TCArgs,
                     const char *LinkingOutput) const override;
};


class LLVM_LIBRARY_VISIBILITY SYCLLinker : public Linker {
public:
  SYCLLinker(const ToolChain &TC) : Linker(TC) {}

  Tool *GetSYCLToolChainLinker() const {
    if (!SYCLToolChainLinker)
      SYCLToolChainLinker.reset(new SYCL::Linker(getToolChain()));
    return SYCLToolChainLinker.get();
  }

private:
  mutable std::unique_ptr<Tool> SYCLToolChainLinker;
};

void getMLISATargetFeatures(const Driver &D, const llvm::Triple &Triple,
                            const llvm::opt::ArgList &Args,
                            std::vector<StringRef> &Features);

} // end namespace MLISA
} // end namespace tools

namespace toolchains {

class LLVM_LIBRARY_VISIBILITY BangToolChain final : public ToolChain {
public:
  BangToolChain(const Driver &D, const llvm::Triple &Triple,
                const ToolChain &HostTC, const llvm::opt::ArgList &Args,
                const Action::OffloadKind OK);

  const llvm::Triple *getAuxTriple() const override {
    return &HostTC.getTriple();
  }

  std::string getInputFilename(const InputInfo &Input) const override;

  llvm::opt::DerivedArgList *
  TranslateArgs(const llvm::opt::DerivedArgList &Args, StringRef BoundArch,
                Action::OffloadKind DeviceOffloadKind) const override;
  void addClangTargetOptions(const llvm::opt::ArgList &DriverArgs,
                             llvm::opt::ArgStringList &CC1Args,
                             Action::OffloadKind DeviceOffloadKind) const override;

  // Never try to use the integrated assembler with BANG; always fork out to
  // cnas.
  bool useIntegratedAs() const override { return false; }
  bool isCrossCompiling() const override { return true; }
  bool isPICDefault() const override { return false; }
  bool isPIEDefault(const llvm::opt::ArgList &Args) const override { return false; }
  bool isPICDefaultForced() const override { return false; }
  bool SupportsProfiling() const override { return false; }
  bool supportsDebugInfoOption(const llvm::opt::Arg *A) const override;
  void adjustDebugInfoKind(codegenoptions::DebugInfoKind &DebugInfoKind,
                           const llvm::opt::ArgList &Args) const override;
  bool IsMathErrnoDefault() const override { return false; }

  void AddBangIncludeArgs(const llvm::opt::ArgList &DriverArgs,
                          llvm::opt::ArgStringList &CC1Args) const ;

  void addClangWarningOptions(llvm::opt::ArgStringList &CC1Args) const override;
  CXXStdlibType GetCXXStdlibType(const llvm::opt::ArgList &Args) const override;
  void
  AddClangSystemIncludeArgs(const llvm::opt::ArgList &DriverArgs,
                            llvm::opt::ArgStringList &CC1Args) const override;
  void AddClangCXXStdlibIncludeArgs(
      const llvm::opt::ArgList &Args,
      llvm::opt::ArgStringList &CC1Args) const override;
  void AddIAMCUIncludeArgs(const llvm::opt::ArgList &DriverArgs,
                           llvm::opt::ArgStringList &CC1Args) const override;

  Tool *SelectTool(const JobAction &JA) const override;

  SanitizerMask getSupportedSanitizers() const override;

  unsigned GetDefaultDwarfVersion() const override { return 2; }

  const ToolChain &HostTC;
  BangInstallationDetector BangInstallation;

protected:
  Tool *buildAssembler() const override;  // cnas
  Tool *buildLinker() const override;     // fatbinary (ok, not really a linker)
  // Tool *buildBackendCompiler() const override; //llc

private:
  const Action::OffloadKind OK;
};

} // end namespace toolchains
} // end namespace driver
} // end namespace clang

#endif // LLVM_CLANG_LIB_DRIVER_TOOLCHAINS_BANG_H
