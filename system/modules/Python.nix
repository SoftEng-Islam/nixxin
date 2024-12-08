{ pkgs, ... }: {
  #__ Python __#
  environment.systemPackages = with pkgs; [
    # python312Packages.opencv-python # Open Computer Vision Library with more than 500 algorithms
    meson # An open source, fast and friendly build system made in Python
    pyenv # Simple Python version management
    python312 # Python Version 3.12
    python312Packages.aria2p
    python312Packages.build
    python312Packages.cairosvg
    python312Packages.certifi
    python312Packages.charset-normalizer
    python312Packages.click
    python312Packages.idna
    python312Packages.loguru
    python312Packages.markupsafe
    python312Packages.pillow
    python312Packages.psutil
    python312Packages.pycairo
    python312Packages.pygobject3
    python312Packages.pywal
    python312Packages.pywayland
    python312Packages.requests
    python312Packages.setuptools-scm
    python312Packages.urllib3
    python312Packages.wheel
  ];
}
