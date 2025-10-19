{ stdenv, lib, fetchgit, cmake, python3, git, pkg-config, llvmPackages }:

stdenv.mkDerivation rec {
  pname = "clvk-git";
  version = "unstable";

  src = fetchgit {
    url = "https://github.com/kpet/clvk.git";
    rev = "main";
    fetchSubmodules = true; # keep this
    sha256 = "sha256-TKmtbVBeu1hHoff+E5dkmcb5p8JaXUNv6Sg8lH/bSSQ=";
  };

  nativeBuildInputs = [ cmake python3 git pkg-config ];
  buildInputs = [ llvmPackages.clang llvmPackages.llvm ];

  # run the fetch_sources.py script before CMake
  preConfigure = ''
    echo ">>> Running CLVK dependency fetch script..."
    cd external/clspv
    ${python3}/bin/python3 utils/fetch_sources.py
    cd ../../
  '';

  cmakeFlags = [ "-DCMAKE_BUILD_TYPE=Release" ];
  installPhase = ''
    mkdir -p $out/bin
    cp -r bin/* $out/bin || true
    cp -r lib/* $out/lib || true
  '';

  meta = with lib; {
    description = "OpenCL over Vulkan implementation (CLVK)";
    homepage = "https://github.com/kpet/clvk";
    license = licenses.mit;
    maintainers = [ maintainers.example ];
    platforms = platforms.linux;
  };
}
