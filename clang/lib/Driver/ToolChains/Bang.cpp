//===--- Bang.cpp - Bang Tool and ToolChain Implementations -----*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "Bang.h"
#include "CommonArgs.h"
#include "clang/Basic/Bang.h"
#include "clang/Basic/Cuda.h"
#include "clang/Config/config.h"
#include "clang/Driver/Compilation.h"
#include "clang/Driver/Distro.h"
#include "clang/Driver/Driver.h"
#include "clang/Driver/DriverDiagnostic.h"
#include "clang/Driver/InputInfo.h"
#include "clang/Driver/Options.h"
#include "llvm/ADT/Optional.h"
#include "llvm/ADT/StringExtras.h"
#include "llvm/Option/ArgList.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/Host.h"
#include "llvm/Support/Path.h"
#include "llvm/Support/Process.h"
#include "llvm/Support/Program.h"
#include "llvm/Support/TargetParser.h"
#include "llvm/Support/VirtualFileSystem.h"
#include <system_error>

using namespace clang::driver;
using namespace clang::driver::toolchains;
using namespace clang::driver::tools;
using namespace clang;
using namespace llvm::opt;
 

BangInstallationDetector::BangInstallationDetector(
    const Driver &D, const llvm::Triple &HostTriple,
    const llvm::opt::ArgList &Args)
    : D(D) {
  struct Candidate {
    std::string Path;
    bool StrictChecking;

    Candidate(std::string Path, bool StrictChecking = false)
        : Path(Path), StrictChecking(StrictChecking) {}
  };
  SmallVector<Candidate, 4> Candidates;

  auto &FS = D.getVFS();

  if (Args.hasArg(clang::driver::options::OPT_bang_path_EQ)) {
    Candidates.emplace_back(
        Args.getLastArgValue(clang::driver::options::OPT_bang_path_EQ).str());
  }  else {
    if (!Args.hasArg(clang::driver::options::OPT_bang_path_ignore_env)) {
      // Try to find cnas binary. If the executable is located in a directory
      // called 'bin/', its parent directory might be a good guess for a valid
      // BANG installation.
      // However, some distributions might installs 'cnas' to /usr/bin. In that
      // case the candidate would be '/usr' which passes the following checks
      // because '/usr/include' exists as well. To avoid this case, we always
      // check for the directory potentially containing files for libdevice,
      // even if the user passes -nocudalib.
      if (llvm::ErrorOr<std::string> cnas =
              llvm::sys::findProgramByName("cnas")) {
        SmallString<256> cnasAbsolutePath;
        llvm::sys::fs::real_path(*cnas, cnasAbsolutePath);

        StringRef cnasDir = llvm::sys::path::parent_path(cnasAbsolutePath);
        llvm::outs()<<"Notice : Bang path is "<<std::string(llvm::sys::path::parent_path(cnasDir))<<" !!!\n";
        if (llvm::sys::path::filename(cnasDir) == "bin")
          Candidates.emplace_back(
              std::string(llvm::sys::path::parent_path(cnasDir)),
              /*StrictChecking=*/true);
      }
    }

    Candidates.emplace_back(D.SysRoot + "/usr/local/neuware");

    Distro Dist(FS, llvm::Triple(llvm::sys::getProcessTriple()));

  }

  bool NoBangLib = Args.hasArg(options::OPT_nogpulib);

  for (const auto &Candidate : Candidates) {
    InstallPath = Candidate.Path;
    if (InstallPath.empty() || !FS.exists(InstallPath))
      continue;

    BinPath = InstallPath + "/bin";
    IncludePath = InstallPath + "/include";
    LibDevicePath = InstallPath + "/mlvm/libdevice";

    if (!(FS.exists(IncludePath) && FS.exists(BinPath)))
      continue;
    bool CheckLibDevice = (!NoBangLib || Candidate.StrictChecking);
    if (CheckLibDevice && !FS.exists(LibDevicePath))
      continue;

    // On Linux, we have both lib and lib64 directories, and we need to choose
    // based on our triple.  On MacOS, we have only a lib directory.
    //
    // It's sufficient for our purposes to be flexible: If both lib and lib64
    // exist, we choose whichever one matches our triple.  Otherwise, if only
    // lib exists, we use it.
    if (HostTriple.isArch64Bit() && FS.exists(InstallPath + "/lib64"))
        LibPath = InstallPath + "/lib64";
    else if (FS.exists(InstallPath + "/lib"))
        LibPath = InstallPath + "/lib";
    else
        continue;
    llvm::outs()<<"######## mlu libpath is "<<LibPath<<"\n";

    char buffer[128];     // 存储命令执行结果的缓冲区
    const char* strCmd = "cnmon | grep 'MLU[0-9][0-9][0-9]' -o";
    FILE* fp = popen(strCmd, "r"); // 执行命令并打开命令输出管道
    if (fp == NULL) {
        llvm::outs()<<"Failed to run bang arch command\n";
        exit(1);
    }

    while (fgets(buffer, sizeof(buffer), fp)) {
        llvm::outs()<<"Notice : bang arch is "<<buffer<<"\n"; // 输出命令执行结果
    }
    
    pclose(fp);         // 关闭命令输出管道
    std::string GpuArch(buffer);
    llvm::outs()<<"######## mlu Arch is "<<GpuArch<<"\n";
    GpuArch = GpuArch.substr(3);
    int archNum = std::stoi(GpuArch);
    std::string archName;
    std::string FilePath = LibDevicePath;
    switch (archNum)
    {
    case 100 :  /* constant-expression */
      /* code */
      archName = "mtp_100";
      break;
    case 220 :
      archName = "mtp_220";
      break;
    case 270 :{
      archName = "mtp_270";
      FilePath += "/libdevice.compute_20.bc";
      if (FS.exists(FilePath)) {
        LibDeviceMap[archName] = FilePath;
      }
      break;
    }
    case 290 :
      archName = "mtp_290";
      break;
    case 370 :{
      archName = "mtp_372";
      FilePath += "/libdevice.compute_30.bc";
      if (FS.exists(FilePath)) {
        LibDeviceMap[archName] = FilePath;
      }
      break;
    }
    case 590 :{
      archName = "mtp_592";
      FilePath += "/libdevice.compute_50.bc";
      if (FS.exists(FilePath)) {
        LibDeviceMap[archName] = FilePath;
      }
      break;
    }
    default:
      llvm::errs()<<"Failed to match MLU Arch !!! \n";
      break;
    }
    llvm::outs()<<"MLU GpuArchName is "<<archName<<"\n";

    // Check that we have found at least one libdevice that we can link in if
    // -nobanglib hasn't been specified.
    if (LibDeviceMap.empty() && !NoBangLib)
      continue;

    // //bang mlu arch mapping diff
    // const char* vir_arch_str = CudaArchToVirtualArchString(GpuArch);
    // std::string GpuArchName(vir_arch_str);

    // if (GpuArchName >= "mlu_200"){
    //   // __BANG_ARCH__ >= 200
    //   std::string FilePath = LibDevicePath + "/libdevice.compute_20.bc";
    //   if (FS.exists(FilePath)) {
    //     LibDeviceMap["mtp_270"] = FilePath;
    //   }
    // } else if(GpuArchName >= "mlu300"){
    //   // __BANG_ARCH__ >= 300
    //   std::string FilePath = LibDevicePath + "/libdevice.compute_30.bc";
    //   if (FS.exists(FilePath)) {
    //     LibDeviceMap["mtp_372"] = FilePath;
    //   }
    // }else if(GpuArchName >= "mlu500"){
    //   // __BANG_ARCH__ >= 500
    //   std::string FilePath = LibDevicePath + "/libdevice.compute_50.bc";
    //   if (FS.exists(FilePath)) {
    //     LibDeviceMap["mtp_592"] = FilePath;
    //   }
    // }



    IsValid = true;
    break;
  }
}

void BangInstallationDetector::AddBangIncludeArgs(
    const ArgList &DriverArgs, ArgStringList &CC1Args) const {
  if (!DriverArgs.hasArg(options::OPT_nobuiltininc)) {
    // Add bang_wrappers/* to our system include path.  This lets us wrap
    // standard library headers.
    SmallString<128> P(D.ResourceDir);
    llvm::sys::path::append(P, "include");
    llvm::sys::path::append(P, "bang_wrappers");
    CC1Args.push_back("-internal-isystem");
    CC1Args.push_back(DriverArgs.MakeArgString(P));
  }

  if (DriverArgs.hasArg(options::OPT_nogpuinc))
    return;

  if (!isValid()) {
    D.Diag(diag::err_drv_no_bang_installation);
    return;
  }

  CC1Args.push_back("-include");
  CC1Args.push_back("__clang_bang_runtime_wrapper.h");                            
}

void BangInstallationDetector::CheckBangVersionSupportsArch(
    CudaArch Arch) const {
  if (Arch == CudaArch::UNKNOWN)
    return;
}

void BangInstallationDetector::print(raw_ostream &OS) const {
  std::string arch_num;
  if(LibDeviceMap.count("mtp_270")){
    arch_num = "mtp_270";
  }else if(LibDeviceMap.count("mtp_372")){
    arch_num = "mtp_372";
  }else if(LibDeviceMap.count("mtp_592")){
    arch_num = "mtp_592";
  }
  if (isValid())
    OS << "Found BANG installation: " << InstallPath << ", libdevice arch : "<< arch_num << "\n";
}

namespace {
/// Debug info level for the MLISA devices. We may need to emit different debug
/// info level for the host and for the device itselfi. This type controls
/// emission of the debug info for the devices. It either prohibits disable info
/// emission completely, or emits debug directives only, or emits same debug
/// info as for the host.
enum DeviceDebugInfoLevel {
  DisableDebugInfo,        /// Do not emit debug info for the devices.
  DebugDirectivesOnly,     /// Emit only debug directives.
  EmitSameDebugInfoAsHost, /// Use the same debug info level just like for the
                           /// host.
};
} // anonymous namespace

/// Define debug info level for the MLISA devices. If the debug info for both
/// the host and device are disabled (-g0/-ggdb0 or no debug options at all). If
/// only debug directives are requested for the both host and device
/// (-gline-directvies-only), or the debug info only for the device is disabled
/// (optimization is on and --bang-noopt-device-debug was not specified), the
/// debug directves only must be emitted for the device. Otherwise, use the same
/// debug info level just like for the host (with the limitations of only
/// supported DWARF2 standard).
static DeviceDebugInfoLevel mustEmitDebugInfo(const ArgList &Args) {
  const Arg *A = Args.getLastArg(options::OPT_O_Group);
  bool IsDebugEnabled = !A || A->getOption().matches(options::OPT_O0) ||
                        Args.hasFlag(options::OPT_bang_noopt_device_debug,
                                     options::OPT_no_bang_noopt_device_debug,
                                     /*Default=*/false);
  if (const Arg *A = Args.getLastArg(options::OPT_g_Group)) {
    const Option &Opt = A->getOption();
    if (Opt.matches(options::OPT_gN_Group)) {
      if (Opt.matches(options::OPT_g0) || Opt.matches(options::OPT_ggdb0))
        return DisableDebugInfo;
      if (Opt.matches(options::OPT_gline_directives_only))
        return DebugDirectivesOnly;
    }
    return IsDebugEnabled ? EmitSameDebugInfoAsHost : DebugDirectivesOnly;
  }
  return willEmitRemarks(Args) ? DebugDirectivesOnly : DisableDebugInfo;
}

void MLISA::BackendCompiler::ConstructJob(Compilation &C, const JobAction &JA,
                                    const InputInfo &Output,
                                    const InputInfoList &Inputs,
                                    const ArgList &Args,
                                    const char *LinkingOutput) const {
  llvm::outs()<<"MLISA backend Compiler does not implement ConstructJob"<<"\n";
  return ;
}

void MLISA::Assembler::ConstructJob(Compilation &C, const JobAction &JA,
                                    const InputInfo &Output,
                                    const InputInfoList &Inputs,
                                    const ArgList &Args,
                                    const char *LinkingOutput) const {
  const auto &TC =
      static_cast<const toolchains::BangToolChain &>(getToolChain());
  assert(TC.getTriple().isMLISA() && "Wrong platform");

  StringRef GPUArchName;
  // If this is an OpenMP action we need to extract the device architecture
  // from the -march=arch option. This option may come from -Xopenmp-target
  // flag or the default value.
  if (JA.isDeviceOffloading(Action::OFK_OpenMP)) {
    GPUArchName = Args.getLastArgValue(options::OPT_march_EQ);
    assert(!GPUArchName.empty() && "Must have an architecture passed in.");
  } else
    GPUArchName = JA.getOffloadingArch();

  // Obtain architecture from the action.
  CudaArch mlu_arch = StringToCudaArch(GPUArchName);
  assert(mlu_arch != CudaArch::UNKNOWN &&
         "Device action expected to have an architecture.");

  // Check that our installation's cnas supports mlu_arch.
  if (!Args.hasArg(options::OPT_no_neuware_version_check)) {
    TC.BangInstallation.CheckBangVersionSupportsArch(mlu_arch);
  }

  ArgStringList CmdArgs;
  DeviceDebugInfoLevel DIKind = mustEmitDebugInfo(Args);
  if (DIKind == EmitSameDebugInfoAsHost) {
    // ptxas does not accept -g option if optimization is enabled, so
    // we ignore the compiler's -O* options if we want debug info.
    CmdArgs.push_back("-g");
  } else if (Arg *A = Args.getLastArg(options::OPT_O_Group)) {
    // Map the -O we received to -O{0,1,2,3}.

    // -O3 seems like the least-bad option when -Osomething is specified to
    // clang but it isn't handled below.
    StringRef OOpt = "3";
    if (A->getOption().matches(options::OPT_O4) ||
        A->getOption().matches(options::OPT_Ofast))
      OOpt = "3";
    else if (A->getOption().matches(options::OPT_O0))
      OOpt = "0";
    else if (A->getOption().matches(options::OPT_O)) {
      // -Os, -Oz, and -O(anything else) map to -O2, for lack of better options.
      OOpt = llvm::StringSwitch<const char *>(A->getValue())
                 .Case("1", "1")
                 .Case("2", "2")
                 .Case("3", "3")
                 .Case("s", "2")
                 .Case("z", "2")
                 .Default("2");
    }
    CmdArgs.push_back(Args.MakeArgString(llvm::Twine("-O") + OOpt));
  } else {
    // If no -O was passed, pass -O3 to ptxas -- this makes ptxas's
    // optimization level the same as the ptxjitcompiler.
    CmdArgs.push_back("-O3");
  }
  if (DIKind == DebugDirectivesOnly)
    CmdArgs.push_back("-lineinfo");

  std::string NormalizedTriple =
    C.getSingleOffloadToolChain<Action::OFK_Host>()->getTriple().normalize();
  CmdArgs.push_back("--mcpu");
  CmdArgs.push_back(Args.MakeArgString(NormalizedTriple));
  CmdArgs.push_back("--mlu-arch");
  CmdArgs.push_back(Args.MakeArgString(CudaArchToString(mlu_arch)));
  CmdArgs.push_back("--output");
  CmdArgs.push_back(Args.MakeArgString(Output.getFilename()));
  for (const auto& II : Inputs) {
    CmdArgs.push_back("--input");
    CmdArgs.push_back(Args.MakeArgString(II.getFilename()));
  }

  // TODO(wangshiyu): Set -fenable-profile to cnas for now, need to
  // differentiate user ldram and profile ldram, and remove setting this flag
  // in the future.
  Arg *ProfileArg = Args.getLastArg(
      options::OPT_fprofile_generate,
      options::OPT_fprofile_generate_EQ,
      options::OPT_fprofile_instr_generate,
      options::OPT_fprofile_instr_generate_EQ);
  if (ProfileArg) {
    CmdArgs.push_back(Args.MakeArgString("-fenable-profile"));
  }

  for (const auto& A : Args.getAllArgValues(options::OPT_Xbang_cnas))
    CmdArgs.push_back(Args.MakeArgString(A));

  if (C.getArgs().hasArg(options::OPT_bang_wram_align64)) {
    CmdArgs.push_back("--wram-align");
    CmdArgs.push_back("64");
  }

  if(Arg *A = Args.getLastArg(options::OPT_wram_align_EQ)) {
    StringRef Val = A->getValue();
    CmdArgs.push_back("--wram-align");
    CmdArgs.push_back(Args.MakeArgString(Val));
  }

  // Set global ieee 754 mode.
  // This is an experimental feature, only used by developers.
  if (Args.getLastArg(options::OPT_fbang_enable_global_ieee_754)) {
    CmdArgs.push_back(Args.MakeArgString("--global-ieee-754=ENABLE"));
  }
  if (Args.getLastArg(options::OPT_fbang_disable_global_ieee_754)) {
    CmdArgs.push_back(Args.MakeArgString("--global-ieee-754=DISABLE"));
  }

  // Set uop control.
  // This is an experimental feature, only used by developers.
  if (Args.getLastArg(options::OPT_fbang_disable_uop_cdma)) {
    CmdArgs.push_back(Args.MakeArgString("--disable-uop-cdma"));
  }
  if (Args.getLastArg(options::OPT_fbang_disable_uop_mdma)) {
    CmdArgs.push_back(Args.MakeArgString("--disable-uop-mdma"));
  }
  if (Args.getLastArg(options::OPT_fbang_disable_uop_gdma)) {
    CmdArgs.push_back(Args.MakeArgString("--disable-uop-gdma"));
  }

  const char *Exec;
  if (Arg *A = Args.getLastArg(options::OPT_cnas_path_EQ))
    Exec = A->getValue();
  else
    Exec = Args.MakeArgString(TC.GetProgramPath("cnas"));

  if (C.getArgs().hasArg(options::OPT_bang_device_only)) {
    CmdArgs.push_back(Args.MakeArgString("--device-only"));
  }
  C.addCommand(std::make_unique<Command>(JA, *this,
      ResponseFileSupport{ResponseFileSupport::RF_Full, llvm::sys::WEM_UTF8,
                          "--options-file"},
      Exec, CmdArgs, Inputs));
}

static bool shouldIncludeMLISA(const ArgList &Args, const char *gpu_arch) {
  bool includeMLISA = true;
  for (Arg *A : Args) {
    if (!(A->getOption().matches(options::OPT_bang_include_mlisa_EQ) ||
          A->getOption().matches(options::OPT_no_bang_include_mlisa_EQ)))
      continue;
    A->claim();
    const StringRef ArchStr = A->getValue();
    if (ArchStr == "all" || ArchStr == gpu_arch) {
      includeMLISA = A->getOption().matches(options::OPT_bang_include_mlisa_EQ);
      continue;
    }
  }
  return includeMLISA;
}

// All inputs to this linker must be from BangDeviceActions, as we need to look
// at the Inputs' Actions in order to figure out which GPU architecture they
// correspond to.
void MLISA::Linker::ConstructJob(Compilation &C, const JobAction &JA,
                                 const InputInfo &Output,
                                 const InputInfoList &Inputs,
                                 const ArgList &Args,
                                 const char *LinkingOutput) const {
  const auto &TC =
      static_cast<const toolchains::BangToolChain &>(getToolChain());
  assert(TC.getTriple().isMLISA() && "Wrong platform");

  ArgStringList CmdArgs;
  CmdArgs.push_back(Args.MakeArgString("--fatbin"));
  CmdArgs.push_back(Args.MakeArgString("--output"));
  CmdArgs.push_back(Args.MakeArgString(Output.getFilename()));

  Arg* host_device_arg = Args.getLastArg(options::OPT_bang_host_only,
                         options::OPT_bang_device_only,
                         options::OPT_bang_compile_host_device);
  bool device_only = host_device_arg &&
                     host_device_arg->getOption().matches(
                         options::OPT_bang_device_only);
  Arg* bang_fatbin_arg = Args.getLastArg(options::OPT_bang_fatbin_only);
  bool fatbin_only = bang_fatbin_arg &&
                     bang_fatbin_arg->getOption().matches(
                         options::OPT_bang_fatbin_only);

  std::string FatBinCWrapper(Output.getFilename());
  if (!device_only) {
    FatBinCWrapper += ".c";
    CmdArgs.push_back(Args.MakeArgString("--create"));
    CmdArgs.push_back(Args.MakeArgString(FatBinCWrapper));
  } else {
    CmdArgs.push_back(Args.MakeArgString("--device-only"));
  }

  std::string NormalizedTriple =
    C.getSingleOffloadToolChain<Action::OFK_Host>()->getTriple().normalize();

  CmdArgs.push_back("--mcpu");
  CmdArgs.push_back(Args.MakeArgString(NormalizedTriple));

  for (const auto& II : Inputs) {
    CmdArgs.push_back(Args.MakeArgString("--input"));
    CmdArgs.push_back(Args.MakeArgString(II.getFilename()));
  }

  for (const auto& A : Args.getAllArgValues(options::OPT_Xbang_fatbinary))
    CmdArgs.push_back(Args.MakeArgString(A));

  // TODO(zhouxiaoyong): replace cnas with cnlinker
  const char *Exec = Args.MakeArgString(TC.GetProgramPath("cnas"));

  C.addCommand(std::make_unique<Command>(JA, *this,
      ResponseFileSupport{ResponseFileSupport::RF_Full, llvm::sys::WEM_UTF8,
                          "--options-file"},
      Exec, CmdArgs, Inputs));

  if (!device_only && !fatbin_only) {
    // Host cc should compile *.cnfatbin.c to *.cnfatbin
    CmdArgs.clear();
    CmdArgs.push_back(Args.MakeArgString("-c"));
    CmdArgs.push_back(Args.MakeArgString(FatBinCWrapper));
    CmdArgs.push_back(Args.MakeArgString("-o"));
    CmdArgs.push_back(Args.MakeArgString(Output.getFilename()));
    std::string TargetOption = "--target=" + NormalizedTriple;
    CmdArgs.push_back(Args.MakeArgString(TargetOption));
    const char *Extr = Args.MakeArgString(TC.GetProgramPath("cncc"));
    C.addCommand(std::make_unique<Command>(JA, *this,
      ResponseFileSupport{ResponseFileSupport::RF_Full, llvm::sys::WEM_UTF8,
                          "--options-file"},
      Extr, CmdArgs, Output));

    // Clean up tmp *.cnfatbin.c file generated by cnas or cnlinker
    C.addTempFile(Args.MakeArgString(FatBinCWrapper));
  }
}

void MLISA::getMLISATargetFeatures(const Driver &D, const llvm::Triple &Triple,
                                   const llvm::opt::ArgList &Args,
                                   std::vector<StringRef> &Features) {
  llvm::outs()<<"mlisa does not have target features"<<"\n";
}

/// BANG toolchain.  Our assembler is cnas, and our "linker" is fatbinary,
/// which isn't properly a linker but nonetheless performs the step of stitching
/// together object files from the assembler into a single blob.

BangToolChain::BangToolChain(const Driver &D, const llvm::Triple &Triple,
                             const ToolChain &HostTC, const ArgList &Args,
                             const Action::OffloadKind OK)
    : ToolChain(D, Triple, Args), HostTC(HostTC),
      BangInstallation(D, HostTC.getTriple(), Args),
      OK(OK) {
  if (BangInstallation.isValid())
    getProgramPaths().push_back(std::string(BangInstallation.getBinPath()));
  // Lookup binaries into the driver directory, this is used to
  // discover the clang-offload-bundler executable.
  getProgramPaths().push_back(getDriver().Dir);
}

std::string BangToolChain::getInputFilename(const InputInfo &Input) const {
  // Only object files are changed, for example assembly files keep their .s
  // extensions. If the user requested device-only compilation don't change it.
  return ToolChain::getInputFilename(Input);

  // Replace extension for object files with cubin because nvlink relies on
  // these particular file names.
}

// Select remangled libclc variant. 64-bit longs default
static const char *getLibSpirvTargetName(const ToolChain &HostTC) {
  return "libspirv-mlisa-cambricon-bang.bc";
}

void BangToolChain::addClangTargetOptions(
    const llvm::opt::ArgList &DriverArgs,
    llvm::opt::ArgStringList &CC1Args,
    Action::OffloadKind DeviceOffloadingKind) const {
  HostTC.addClangTargetOptions(DriverArgs, CC1Args, DeviceOffloadingKind);

  StringRef GpuArch = DriverArgs.getLastArgValue(options::OPT_march_EQ);
  llvm::outs()<<"Notice : Clang Target Options GpuArch is "<<GpuArch<<" !!!!!\n";
  assert(!GpuArch.empty() && "Must have an explicit GPU arch.");
  assert((DeviceOffloadingKind == Action::OFK_OpenMP ||
          DeviceOffloadingKind == Action::OFK_SYCL ||
          DeviceOffloadingKind == Action::OFK_BANG) &&
         "Only OpenMP, SYCL or BANG offloading kinds are supported for CAMBRICON GPUs.");

  if (DeviceOffloadingKind == Action::OFK_BANG) {
    CC1Args.append(
        {"-fbang-is-device"});
  }

  if (DeviceOffloadingKind == Action::OFK_SYCL) {
    toolchains::SYCLToolChain::AddSYCLIncludeArgs(getDriver(), DriverArgs,
                                                  CC1Args);
  }

  auto NoLibSpirv = DriverArgs.hasArg(options::OPT_fno_sycl_libspirv,
                                      options::OPT_fsycl_device_only);
  if (DeviceOffloadingKind == Action::OFK_SYCL && !NoLibSpirv) {
    std::string LibSpirvFile;

    if (DriverArgs.hasArg(clang::driver::options::OPT_fsycl_libspirv_path_EQ)) {
      auto ProvidedPath =
        DriverArgs.getLastArgValue(clang::driver::options::OPT_fsycl_libspirv_path_EQ).str();
      if (llvm::sys::fs::exists(ProvidedPath))
        LibSpirvFile = ProvidedPath;
    } else {
      SmallVector<StringRef, 8> LibraryPaths;

      // Expected path w/out install.
      SmallString<256> WithoutInstallPath(getDriver().ResourceDir);
      llvm::sys::path::append(WithoutInstallPath, Twine("../../clc"));
      LibraryPaths.emplace_back(WithoutInstallPath.c_str());
      llvm::outs()<<"WithoutInstallPath : "<<std::string(WithoutInstallPath.str())<<"\n";

      // Expected path w/ install.
      SmallString<256> WithInstallPath(getDriver().ResourceDir);
      llvm::sys::path::append(WithInstallPath, Twine("../../../share/clc"));
      LibraryPaths.emplace_back(WithInstallPath.c_str());
      llvm::outs()<<"WithInstallPath : "<<std::string(WithInstallPath.str())<<"\n";

      // Select remangled libclc variant
      std::string LibSpirvTargetName = getLibSpirvTargetName(HostTC);

      for (StringRef LibraryPath : LibraryPaths) {
        SmallString<128> LibSpirvTargetFile(LibraryPath);
        llvm::sys::path::append(LibSpirvTargetFile, LibSpirvTargetName);
        llvm::outs()<<"MLISA LIBCLC PATH : "<<std::string(LibSpirvTargetFile.str())<<"\n";
        if (llvm::sys::fs::exists(LibSpirvTargetFile) ||
            DriverArgs.hasArg(options::OPT__HASH_HASH_HASH)) {
          LibSpirvFile = std::string(LibSpirvTargetFile.str());
          break;
        }
      }
    }

    if (LibSpirvFile.empty()) {
      getDriver().Diag(diag::err_drv_no_sycl_libspirv)
          << getLibSpirvTargetName(HostTC);
      return;
    }

    CC1Args.push_back("-mlink-builtin-bitcode");
    CC1Args.push_back(DriverArgs.MakeArgString(LibSpirvFile));
  }

  if (DriverArgs.hasArg(options::OPT_nogpulib))
    return;

  if (DeviceOffloadingKind == Action::OFK_OpenMP &&
      DriverArgs.hasArg(options::OPT_S))
    return;

  std::string LibDeviceFile = BangInstallation.getLibDeviceFile(GpuArch);
  if (LibDeviceFile.empty()) {
    getDriver().Diag(diag::err_drv_no_bang_libdevice) << GpuArch;
    return;
  }

  CC1Args.push_back("-mlink-builtin-bitcode");
  CC1Args.push_back(DriverArgs.MakeArgString(LibDeviceFile));

    // Enable register allocation in LLVM only when compiling with -g option.
  // TODO(wangshiyu): close register allocation in LLVM.
  if (DriverArgs.getLastArg(options::OPT_g_Group)) {
    CC1Args.push_back("-mllvm");
    CC1Args.push_back("-mlisa-enable-register-allocation=true");
  }

  // If --bang-stack-on-ldram, -fprofile-generate* or -fprofile-instr-generate*
  // is enabled, promote stack to LDRAM.
  Arg *ProfileArg = DriverArgs.getLastArg(
      options::OPT_fprofile_generate,
      options::OPT_fprofile_generate_EQ,
      options::OPT_fprofile_instr_generate,
      options::OPT_fprofile_instr_generate_EQ);
}

bool BangToolChain::supportsDebugInfoOption(const llvm::opt::Arg *A) const {
  const Option &O = A->getOption();
  return (O.matches(options::OPT_gN_Group) &&
          !O.matches(options::OPT_gmodules)) ||
         O.matches(options::OPT_g_Flag) ||
         O.matches(options::OPT_ggdbN_Group) || O.matches(options::OPT_ggdb) ||
         O.matches(options::OPT_gdwarf) || O.matches(options::OPT_gdwarf_2) ||
         O.matches(options::OPT_gdwarf_3) || O.matches(options::OPT_gdwarf_4) ||
         O.matches(options::OPT_gdwarf_5) ||
         O.matches(options::OPT_gcolumn_info);
}

void BangToolChain::adjustDebugInfoKind(
    codegenoptions::DebugInfoKind &DebugInfoKind, const ArgList &Args) const {
  switch (mustEmitDebugInfo(Args)) {
  case DisableDebugInfo:
    DebugInfoKind = codegenoptions::NoDebugInfo;
    break;
  case DebugDirectivesOnly:
    DebugInfoKind = codegenoptions::DebugDirectivesOnly;
    break;
  case EmitSameDebugInfoAsHost:
    // Use same debug info level as the host.
    break;
  }
}

void BangToolChain::AddBangIncludeArgs(const ArgList &DriverArgs,
                                       ArgStringList &CC1Args) const {
  // Check our BANG version if we're going to include the BANG headers.
  if (!DriverArgs.hasArg(options::OPT_noneuwareinc) &&
      !DriverArgs.hasArg(options::OPT_no_neuware_version_check)) {
    StringRef Arch = DriverArgs.getLastArgValue(options::OPT_march_EQ);
    assert(!Arch.empty() && "Must have an explicit MLU arch.");
    // if (Arch.empty()) Arch = "mtp_372";
    BangInstallation.CheckBangVersionSupportsArch(StringToCudaArch(Arch));
  }
  BangInstallation.AddBangIncludeArgs(DriverArgs, CC1Args);
}

llvm::opt::DerivedArgList *
BangToolChain::TranslateArgs(const llvm::opt::DerivedArgList &Args,
                             StringRef BoundArch,
                             Action::OffloadKind DeviceOffloadKind) const {
  DerivedArgList *DAL =
      HostTC.TranslateArgs(Args, BoundArch, DeviceOffloadKind);
  if (!DAL)
    DAL = new DerivedArgList(Args.getBaseArgs());

  const OptTable &Opts = getDriver().getOpts();

  // For OpenMP device offloading, append derived arguments. Make sure
  // flags are not duplicated.
  // Also append the compute capability.
  if (DeviceOffloadKind == Action::OFK_OpenMP) {
    for (Arg *A : Args)
      if (!llvm::is_contained(*DAL, A))
        DAL->append(A);

    if (!DAL->hasArg(options::OPT_march_EQ))
      DAL->AddJoinedArg(nullptr, Opts.getOption(options::OPT_march_EQ),
                        BoundArch);

    return DAL;
  }

  for (Arg *A : Args) {
    if (A->getOption().matches(options::OPT_Xarch__)) {
      // Skip this argument unless the architecture matches BoundArch
      if (BoundArch.empty() || A->getValue(0) != BoundArch)
        continue;

      unsigned Index = Args.getBaseArgs().MakeIndex(A->getValue(1));
      unsigned Prev = Index;
      std::unique_ptr<Arg> XarchArg(Opts.ParseOneArg(Args, Index));

      // If the argument parsing failed or more than one argument was
      // consumed, the -Xarch_ argument's parameter tried to consume
      // extra arguments. Emit an error and ignore.
      //
      // We also want to disallow any options which would alter the
      // driver behavior; that isn't going to work in our model. We
      // use isDriverOption() as an approximation, although things
      // like -O4 are going to slip through.
      if (!XarchArg || Index > Prev + 1) {
        getDriver().Diag(diag::err_drv_invalid_Xarch_argument_with_args)
            << A->getAsString(Args);
        continue;
      } else if (XarchArg->getOption().hasFlag(options::NoXarchOption)) {
        auto &Diags = getDriver().getDiags();
        unsigned DiagID =
            Diags.getCustomDiagID(DiagnosticsEngine::Error,
                                  "invalid Xarch argument: '%0', not all driver "
                                  "options can be forwared via Xarch argument");
        Diags.Report(DiagID) << A->getAsString(Args);
        continue;
      }
      XarchArg->setBaseArg(A);
      A = XarchArg.release();
      DAL->AddSynthesizedArg(A);
    }    
    DAL->append(A);
  }

  if (!BoundArch.empty()) {
    DAL->eraseArg(options::OPT_march_EQ);
    DAL->AddJoinedArg(nullptr, Opts.getOption(options::OPT_march_EQ), BoundArch);
  }
  return DAL;

}

Tool *BangToolChain::buildBackendCompiler() const {
  return new tools::MLISA::BackendCompiler(*this);
}

Tool *BangToolChain::buildAssembler() const {
  return new tools::MLISA::Assembler(*this);
}

Tool *BangToolChain::buildLinker() const {
  if (OK == Action::OFK_SYCL)
    return new tools::MLISA::SYCLLinker(*this);
  return new tools::MLISA::Linker(*this);
}

Tool *BangToolChain::SelectTool(const JobAction &JA) const {
  if (OK == Action::OFK_SYCL) {
    if (JA.getKind() == Action::LinkJobClass &&
        JA.getType() == types::TY_LLVM_BC) {
      return static_cast<tools::MLISA::SYCLLinker *>(ToolChain::SelectTool(JA))
          ->GetSYCLToolChainLinker();
    }
  }
  return ToolChain::SelectTool(JA);
}

void BangToolChain::addClangWarningOptions(ArgStringList &CC1Args) const {
  HostTC.addClangWarningOptions(CC1Args);
}

ToolChain::CXXStdlibType
BangToolChain::GetCXXStdlibType(const ArgList &Args) const {
  return HostTC.GetCXXStdlibType(Args);
}

void BangToolChain::AddClangSystemIncludeArgs(const ArgList &DriverArgs,
                                              ArgStringList &CC1Args) const {
  if (DriverArgs.hasArg(options::OPT_fsycl)) {
    toolchains::SYCLToolChain::AddSYCLIncludeArgs(getDriver(), DriverArgs,
                                                  CC1Args);
  }
  HostTC.AddClangSystemIncludeArgs(DriverArgs, CC1Args);

  if (!DriverArgs.hasArg(options::OPT_nogpuinc) && BangInstallation.isValid())
    CC1Args.append(
        {"-internal-isystem",
         DriverArgs.MakeArgString(BangInstallation.getIncludePath())});
}

void BangToolChain::AddClangCXXStdlibIncludeArgs(const ArgList &Args,
                                                 ArgStringList &CC1Args) const {
  HostTC.AddClangCXXStdlibIncludeArgs(Args, CC1Args);
}

void BangToolChain::AddIAMCUIncludeArgs(const ArgList &Args,
                                        ArgStringList &CC1Args) const {
  HostTC.AddIAMCUIncludeArgs(Args, CC1Args);
}

SanitizerMask BangToolChain::getSupportedSanitizers() const {
  // The BangToolChain only supports sanitizers in the sense that it allows
  // sanitizer arguments on the command line if they are supported by the host
  // toolchain. The BangToolChain will actually ignore any command line
  // arguments for any of these "supported" sanitizers. That means that no
  // sanitization of device code is actually supported at this time.
  //
  // This behavior is necessary because the host and device toolchains
  // invocations often share the command line, so the device toolchain must
  // tolerate flags meant only for the host toolchain.
  return HostTC.getSupportedSanitizers();
}

// VersionTuple BangToolChain::computeMSVCVersion(const Driver *D,
//                                                const ArgList &Args) const {
//   return HostTC.computeMSVCVersion(D, Args);
// }



