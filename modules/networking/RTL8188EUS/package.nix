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
