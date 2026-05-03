{
  lib,
  stdenv,
  fetchFromGitHub,
  kernel,
  bc,
}:

stdenv.mkDerivation {
  pname = "rtl8188eus-aircrack";
  version = "${kernel.version}-unstable-2025-10-17";

  src = fetchFromGitHub {
    owner = "SimplyCEO";
    repo = "rtl8188eus";
    rev = "369a5bd463e15e031e6fd2d2839656ef4101421b";
    sha256 = "sha256-ClShboLp+bjdWBVy3uj9jevh3tYDvIRgddjQRG2Gn0M=";
  };

  prePatch = ''
    substituteInPlace ./Makefile \
      --replace /lib/modules/ "${kernel.dev}/lib/modules/" \
      --replace /sbin/depmod \# \
      --replace '$(MODDESTDIR)' "$out/lib/modules/${kernel.modDirVersion}/kernel/net/wireless/"
  '';

  hardeningDisable = [ "pic" ];

  enableParallelBuilding = true;

  nativeBuildInputs = [ bc ] ++ kernel.moduleBuildDependencies;

  preInstall = ''
    mkdir -p "$out/lib/modules/${kernel.modDirVersion}/kernel/net/wireless/"
  '';

  meta = with lib; {
    description = "RealTek RTL8188eus WiFi driver with monitor mode & frame injection support (kernels up to 6.17+)";
    homepage = "https://github.com/SimplyCEO/rtl8188eus";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ moni ];
    broken = (lib.versions.majorMinor kernel.version) == "5.4" && kernel.isHardened;
  };
}
