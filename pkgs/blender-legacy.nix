{ pkgs }:

let
  # Pin a specific version of nixpkgs from late 2021 (when Python 3.9 was standard)
  legacyPkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-21.11.tar.gz";
    sha256 = "04ffwp2gzq0hhz7siskw6qh9ys8ragp7285vi1zh8xjksxn1msc5"; # Verified hash
  }) { inherit (pkgs) system; };

  # Now we pull Python 3.9 and its packages from that specific legacy set
  python39Packages = legacyPkgs.python39Packages;
  python = python39Packages.python;
in
pkgs.stdenv.mkDerivation rec {
  pname = "blender293";
  version = "2.93.2";

  src = pkgs.fetchurl {
    url = "https://download.blender.org/source/blender-${version}.tar.xz";
    sha256 = "sha256-nG1Kk6UtiCwsQBDz7VELcMRVEovS49QiO3haIpvSfu4=";
  };

  # Use the legacy python packages here
  nativeBuildInputs = [
    pkgs.cmake
    pkgs.makeWrapper
    python39Packages.wrapPython
    pkgs.llvmPackages.llvm.dev
  ];

  buildInputs = with pkgs; [
    boost
    ffmpeg
    gettext
    glew
    ilmbase
    freetype
    libjpeg
    libpng
    libsamplerate
    libsndfile
    libtiff
    opencolorio
    openexr
    openimagedenoise
    openimageio
    openjpeg
    python
    zlib
    fftw
    jemalloc
    alembic
    opensubdiv
    tbb
    embree
    gmp
    pugixml
    potrace
    libharu
    ocl-icd
    xorg.libXi
    xorg.libX11
    xorg.libXext
    xorg.libXrender
    libGLU
    libGL
    openal
    xorg.libXxf86vm
    openxr-loader
    openvdb
  ];

  # Use legacy numpy and requests
  pythonPath = with python39Packages; [
    numpy
    requests
  ];

  postPatch = ''
    substituteInPlace extern/clew/src/clew.c --replace '"libOpenCL.so"' '"${pkgs.ocl-icd}/lib/libOpenCL.so"'
  '';

  cmakeFlags = [
    "-DWITH_ALEMBIC=ON"
    "-DWITH_CYCLES_DEVICE_OPENCL=ON"
    "-DWITH_OPENCOLORIO=ON"
    "-DPYTHON_VERSION=3.9"
    "-DWITH_PYTHON_INSTALL=OFF"
    "-DWITH_OPENVDB=ON"
    "-DWITH_TBB=ON"
    "-DWITH_IMAGE_OPENJPEG=ON"
    "-DWITH_INSTALL_PORTABLE=OFF"
    # Point CMake to the correct Python 3.9 locations
    "-DPYTHON_INCLUDE_DIR=${python}/include/python3.9"
    "-DPYTHON_LIBRARY=${python}/lib/libpython3.9.so"
  ];

  postInstall = ''
    mv $out/bin/blender $out/bin/blender293

    buildPythonPath "$pythonPath"
    wrapProgram $out/bin/blender293 \
      --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.stdenv.cc ]} \
      --prefix PYTHONPATH : "$program_PYTHONPATH" \
      --add-flags '--python-use-system-env'

    if [ -d "$out/share/applications" ]; then
      substituteInPlace $out/share/applications/blender.desktop \
        --replace "Name=Blender" "Name=Blender 2.93 (Legacy)" \
        --replace "Exec=blender" "Exec=blender293"
      mv $out/share/applications/blender.desktop $out/share/applications/blender293.desktop
    fi
  '';
}
