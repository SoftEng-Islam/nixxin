{ lib, stdenv, fetchFromGitHub, kernel, bc }:

let
  kernelBuildDir = "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build";

  # kernel.makeFlags is meant for building the kernel itself. The CachyOS LTO
  # package set adds flags with spaces that stdenv passes incorrectly to make
  # for this external module, so keep only the reusable toolchain flags.
  moduleMakeFlags = lib.filter (
    flag:
    !(lib.elem flag [
      "O=$(buildRoot)"
      "--eval=undefine modules"
    ])
  ) kernel.makeFlags;
in
stdenv.mkDerivation {
  pname = "rtl8188eus";
  version = "${kernel.version}-unstable";

  src = fetchFromGitHub {
    owner = "SimplyCEO";
    repo = "rtl8188eus";
    rev = "b5f02e742fad6ae27d893ffae62d05e27374c0ed"; # Building support for kernel 7.1.x and newer (2026-07-07)
    hash = "sha256-cw5JHX0C01M7c2icezPNCh1Q9XO8uIgu9zZohCZ9Ioo=";
  };

  # Kernel modules often require format string hardening disabled
  hardeningDisable = [ "pic" "format" ];

  postPatch = ''
    # Kernel 7.2+ compatibility fixes
    # AppleTalk support was completely removed from kernel headers in 7.2
    # Define the missing structs locally
    cat > core/appletalk_compat.h << 'EOF'
#ifndef _APPLETALK_COMPAT_H
#define _APPLETALK_COMPAT_H

#define AARP_PA_ALEN 4

struct elapaarp {
    unsigned short hw_type;
    unsigned short pa_type;
    unsigned char hw_len;
    unsigned char pa_len;
    unsigned short op;
    unsigned char hw_src[6];
    unsigned short pa_src_net;
    unsigned char pa_src_node;
    unsigned char hw_dst[6];
    unsigned short pa_dst_net;
    unsigned char pa_dst_node;
} __attribute__((packed));

struct ddpehdr {
    unsigned short deh_len_hops;
    unsigned short deh_sum;
    unsigned short deh_dnet;
    unsigned short deh_snet;
    unsigned char deh_dnode;
    unsigned char deh_snode;
    unsigned char deh_dport;
    unsigned char deh_sport;
};

#endif
EOF

    # Include the compat header after the existing includes
    sed -i '/#include <linux\/if_pppox.h>/a #include "appletalk_compat.h"' core/rtw_br_ext.c

    # Fix strncpy issue in kernel 7.x - replace with strscpy
    sed -i 's/strncpy(/strscpy(/g' os_dep/linux/os_intfs.c

    # Disable array-bounds and uninitialized-variable warnings-as-errors for CachyOS LTO kernel
    # These are benign warnings in this legacy code that don't affect functionality
    echo 'ccflags-y += -Wno-error=array-bounds -Wno-error=uninitialized' >> Makefile
  '';

  nativeBuildInputs = [ bc ] ++ kernel.moduleBuildDependencies;

  # Pass the kernel build directories natively to the Makefile
  makeFlags = moduleMakeFlags ++ [
    "KSRC=${kernelBuildDir}"
    "KDIR=${kernelBuildDir}"
  ];

  # Skip 'make install' entirely. It's much safer to just copy the compiled .ko file manually.
  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/modules/${kernel.modDirVersion}/kernel/net/wireless/
    cp 8188eu.ko $out/lib/modules/${kernel.modDirVersion}/kernel/net/wireless/

    runHook postInstall
  '';

  meta = with lib; {
    description = "RealTek RTL8188eus WiFi driver with monitor mode & frame injection support";
    homepage = "https://github.com/SimplyCEO/rtl8188eus";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ moni ];
    broken = (lib.versions.majorMinor kernel.version) == "5.4" && kernel.isHardened;
  };
}
