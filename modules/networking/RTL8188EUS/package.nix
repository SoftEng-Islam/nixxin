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
    rev = "369a5bd463e15e031e6fd2d2839656ef4101421b";
    hash = "sha256-ClShboLp+bjdWBVy3uj9jevh3tYDvIRgddjQRG2Gn0M="; # 'hash' is preferred over 'sha256'
  };

  # Kernel modules often require format string hardening disabled
  hardeningDisable = [ "pic" "format" ];

  postPatch = ''
    # Linux 7.x removed 'struct elapaarp' and 'struct ddpehdr' from headers (AppleTalk legacy).
    # Also 'tag_data' was hidden in 'struct pppoe_tag'.
    # We define the missing structs and fix the pointer math locally to prevent build failures.
    sed -i '1i struct elapaarp { unsigned short hw_type; unsigned short pa_type; unsigned char hw_len; unsigned char pa_len; unsigned short op; unsigned char hw_src[6]; unsigned char pa_src_net[2]; unsigned char pa_src_node; unsigned char hw_dst[6]; unsigned char pa_dst_net[2]; unsigned char pa_dst_node; } __attribute__((packed));' core/rtw_br_ext.c
    sed -i '1i struct ddpehdr { unsigned short deh_len_hops; unsigned short deh_sum; unsigned short deh_dnet; unsigned short deh_snet; unsigned char deh_dnode; unsigned char deh_snode; unsigned char deh_dport; unsigned char deh_sport; };' core/rtw_br_ext.c
    sed -i 's/tag->tag_data/(((char *)tag) + sizeof(struct pppoe_tag))/g' core/rtw_br_ext.c
    sed -i 's/pOldTag->tag_data/(((char *)pOldTag) + sizeof(struct pppoe_tag))/g' core/rtw_br_ext.c
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
