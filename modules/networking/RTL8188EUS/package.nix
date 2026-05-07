{ lib, stdenv, fetchFromGitHub, kernel, bc }:

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

  nativeBuildInputs = [ bc ] ++ kernel.moduleBuildDependencies;

  # Pass the kernel build directories natively to the Makefile
  makeFlags = kernel.makeFlags ++ [
    "KSRC=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
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