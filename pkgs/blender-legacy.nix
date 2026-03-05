{ pkgs }:

let
  python39Packages = pkgs.python39Packages;
  python = python39Packages.python;
in
pkgs.stdenv.mkDerivation rec {
  pname = "blender293"; # Changed name here
  version = "2.93.2";

  src = pkgs.fetchurl {
    url = "https://download.blender.org/source/blender-${version}.tar.xz";
    sha256 = "sha256-nG1Kk6UtiCwsQBDz7VELcMRVEovS49QiO3haIpvSfu4=";
  };

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
    libXi
    libX11
    libXext
    libXrender
    libGLU
    libGL
    openal
    libXxf86vm
    openxr-loader
    openvdb
  ];

  pythonPath = with python39Packages; [
    numpy
    requests
  ];

  postPatch = ''
    # Fix OpenCL discovery
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
  ];

  postInstall = ''
    # 1. Rename the binary
    mv $out/bin/blender $out/bin/blender293

    # 2. Wrap the renamed binary
    buildPythonPath "$pythonPath"
    wrapProgram $out/bin/blender293 \
      --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.stdenv.cc ]} \
      --prefix PYTHONPATH : "$program_PYTHONPATH" \
      --add-flags '--python-use-system-env'

    # 3. Fix the Desktop Entry for the App Menu
    if [ -d "$out/share/applications" ]; then
      substituteInPlace $out/share/applications/blender.desktop \
        --replace "Name=Blender" "Name=Blender 2.93 (Legacy)" \
        --replace "Exec=blender" "Exec=blender293"

      # Rename the desktop file itself to avoid conflict with modern Blender
      mv $out/share/applications/blender.desktop $out/share/applications/blender293.desktop
    fi
  '';

  meta = with pkgs.lib; {
    description = "Blender 2.93 with OpenCL support for legacy AMD GPUs";
    homepage = "https://www.blender.org";
    license = licenses.gpl2Plus;
    platforms = [ "x86_64-linux" ];
  };
}
