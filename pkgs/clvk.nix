{ pkgs, stdenv, lib, cmake, python3, llvmPackages, fetchFromGitHub }:
stdenv.mkDerivation rec {
  pname = "clvk-git";
  version = "unstable";

  src = fetchFromGitHub {
    owner = "kpet";
    repo = "clvk";
    rev = "7a0e432e9d3c3f882a28b60469b928d17ce4d4e1"; # main at 2025-10
    hash = "sha256-TKmtbVBeu1hHoff+E5dkmcb5p8JaXUNv6Sg8lH/bSSQ=";
  };

  # Pre-fetch the clspv dependency manually
  clspvSrc = fetchFromGitHub {
    owner = "google";
    repo = "clspv";
    rev = "refs/tags/v2025.1"; # latest known stable
    hash =
      "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # fix with nix-prefetch-url
  };

  nativeBuildInputs = with pkgs; [
    cmake
    python3
    llvmPackages.llvm
    llvmPackages.clang
  ];

  preConfigure = ''
    echo "Injecting clspv source..."
    rm -rf external/clspv
    cp -r ${clspvSrc} external/clspv
  '';

  buildInputs = with pkgs.llvmPackages_19;
    with pkgs; [
      llvm
      clang-unwrapped
      vulkan-headers
      vulkan-loader
    ];

  installPhase = ''
    mkdir -p $out/bin
    cp bin/clvk $out/bin/
  '';

  meta = {
    description = "OpenCL implementation on Vulkan using clspv";
    homepage = "https://github.com/kpet/clvk";
    license = lib.licenses.asl20;
    maintainers = [ ];
  };
}
