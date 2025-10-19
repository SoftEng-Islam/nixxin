{ lib, stdenv, fetchgit, cmake, config, python3, pkg-config, spirv-tools
, spirv-headers, vulkan-headers, vulkan-loader, llvmPackages_19, pkgs, ... }:

stdenv.mkDerivation rec {
  pname = "clvk";
  version = "git";

  src = fetchgit {
    url = "https://github.com/kpet/clvk.git";
    rev = "main";
    fetchSubmodules = true;
    sha256 = "sha256-TKmtbVBeu1hHoff+E5dkmcb5p8JaXUNv6Sg8lH/bSSQ=";
  };
  nativeBuildInputs = [ cmake pkg-config python3 ];

  buildInputs = with llvmPackages_19;
    with pkgs; [
      llvm
      clang-unwrapped
      vulkan-headers
      vulkan-loader
      spirv-tools
      spirv-headers
    ];

  patchPhase = ''
    echo "Disabling CLVK's internal fetch_sources.py network fetch..."
    substituteInPlace external/clspv/utils/fetch_sources.py \
      --replace "git clone" "echo SKIP git clone"
  '';

  cmakeFlags = [
    "-DCLVK_USE_SYSTEM_SPIRV_HEADERS=ON"
    "-DCLVK_USE_SYSTEM_SPIRV_TOOLS=ON"
    "-DCLVK_BUILD_TESTS=OFF"
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r bin include lib $out/ || true
  '';

  meta = with lib; {
    description =
      "An implementation of OpenCL for Vulkan using clspv and Vulkan compute";
    homepage = "https://github.com/kpet/clvk";
    license = licenses.asl20;
    maintainers = [ maintainers.yourname or "SoftEng-Islam" ];
    platforms = platforms.linux;
  };
}
