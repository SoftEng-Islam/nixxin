{ pkgs }:

let
  system = pkgs.stdenv.hostPlatform.system;

  # Pin a specific version of nixpkgs to keep legacy deps/build tooling stable.
  legacyPkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-21.11.tar.gz";
    sha256 = "04ffwp2gzq0hhz7siskw6qh9ys8ragp7285vi1zh8xjksxn1msc5"; # Verified hash
  }) { inherit system; };

  lib = legacyPkgs.lib;
  stdenv = legacyPkgs.stdenv;

  # Blender 2.90.x requires Python 3.8.
  pythonPackages = legacyPkgs.python38Packages;
  python = pythonPackages.python;

  # Some attrs were renamed across nixpkgs revisions; prefer a best-effort fallback.
  embree = legacyPkgs.embree3 or legacyPkgs.embree;
  libopenjpeg = legacyPkgs.libopenjpeg or legacyPkgs.openjpeg;
  blosc =
    legacyPkgs.blosc or legacyPkgs."c-blosc" or legacyPkgs.blosc2 or legacyPkgs."c-blosc2";
in
stdenv.mkDerivation rec {
  pname = "blender290";
  version = "2.90.1";

  src = legacyPkgs.fetchurl {
    url = "https://download.blender.org/source/blender-${version}.tar.xz";
    sha256 = "1jqavwq1i45vh9z25jbpz0ckfjyw50qahlkh9zpy1zcmf5fpjwf0";
  };

  nativeBuildInputs = [
    legacyPkgs.cmake
    legacyPkgs.makeWrapper
    legacyPkgs.pkg-config
    pythonPackages.wrapPython
    legacyPkgs.llvmPackages.libclang
    legacyPkgs.libxkbcommon
  ];

  buildInputs =
    (with legacyPkgs; [
      boost
      fftw
      ffmpeg
      gettext
      glew
      eigen
      freetype
      jemalloc
      libGL
      libGLU
      libjpeg
      libopenjpeg
      libpng
      libpulseaudio
      libsamplerate
      libsndfile
      libtiff
      openal
      openexr
      ilmbase
      openimageio
      tbb
      openvdb
      zlib
      ocl-icd
      opencl-headers
      xorg.libX11
      xorg.libXi
      xorg.libXxf86vm
      xorg.libXext
      xorg.libXrender
      xorg.libXfixes
      xorg.libXcursor
      xorg.libXinerama
      xorg.libXrandr
    ])
    ++ [ embree blosc ];

  pythonPath = with pythonPackages; [
    numpy
    requests
  ];

  patches = [
    (legacyPkgs.fetchurl {
      url = "https://developer.blender.org/file/download/xw4pbww7o7q3hw2alxz6obc7/blender-2.90.1-ffmpeg-4.3.patch";
      sha256 = "sha256-TXknol6j8Dfbs3WQEbO/XXk+nMd8gavaDiq5tKNwe/o=";
    })
  ];

  # Fixes: blender build failure on `#include <io.h>`
  NIX_CFLAGS_COMPILE = "-isystem ${stdenv.cc.cc}/include/c++/${stdenv.cc.cc.version}/${stdenv.hostPlatform.config}";

  postPatch = ''
    substituteInPlace build_files/cmake/Modules/FindOpenEXR.cmake \
      --replace "2.2" "${legacyPkgs.openexr.version}"

    substituteInPlace extern/clew/src/clew.c \
      --replace '"libOpenCL.so"' '"${legacyPkgs.ocl-icd}/lib/libOpenCL.so"'
  '';

  cmakeFlags = [
    "-DWITH_MOD_OCEANSIM=OFF"
    "-DWITH_CODEC_FFMPEG=ON"
    "-DWITH_INSTALL_PORTABLE=OFF"
    "-DWITH_PYTHON_INSTALL=OFF"
    "-DPYTHON_VERSION=${python.pythonVersion}"
    "-DPYTHON_INCLUDE_DIR=${python}/include/${python.libPrefix}"
    "-DPYTHON_LIBRARY=${python}/lib/libpython${python.pythonVersion}.so"
    "-DWITH_BOOST_ICU=ON"
    "-DWITH_PYTHON_MODULE=ON"
    "-DPYTHON_LIBPATH=${python}/lib"
    "-DWITH_ALEMBIC=ON"
    "-DWITH_IMAGE_OPENJPEG=ON"
    "-DWITH_JEMALLOC=ON"
    "-DWITH_OPENVDB=ON"
    "-DOPENVDB_ROOT_DIR=${legacyPkgs.openvdb}"
    "-DBLOSC_ROOT_DIR=${blosc}"
    "-DWITH_TBB=ON"
    "-DWITH_CYCLES_EMBREE=ON"
    "-DEMBREE_ROOT_DIR=${embree}"
    "-DWITH_CYCLES_DEVICE_OPENCL=ON"
    "-DWITH_GHOST_X11=ON"
  ];

  postInstall = ''
    mv $out/bin/blender $out/bin/blender290

    buildPythonPath "$pythonPath"
    wrapProgram $out/bin/blender290 \
      --prefix PATH : ${stdenv.cc}/bin \
      --prefix PYTHONPATH : "$program_PYTHONPATH" \
      --add-flags '--python-use-system-env'

    if [ -d "$out/share/applications" ]; then
      substituteInPlace $out/share/applications/blender.desktop \
        --replace "Name=Blender" "Name=Blender 2.90 (Legacy)" \
        --replace "Exec=blender" "Exec=blender290"
      mv $out/share/applications/blender.desktop $out/share/applications/blender290.desktop
    fi
  '';

  meta = with lib; {
    description = "Blender 2.90.1 (legacy)";
    homepage = "https://www.blender.org/";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    mainProgram = "blender290";
  };
}
