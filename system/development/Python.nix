{ pkgs, ... }: {
  #__ Python __#
  environment.systemPackages = with pkgs; [
    meson # An open source, fast and friendly build system made in Python
    pyenv # Simple Python version management
    python3
    pythonPackages.aria2p
    pythonPackages.build
    pythonPackages.cairosvg
    pythonPackages.certifi
    pythonPackages.charset-normalizer
    pythonPackages.click
    pythonPackages.idna
    pythonPackages.loguru
    pythonPackages.markupsafe
    pythonPackages.opencv-python # Open Computer Vision Library with more than 500 algorithms
    pythonPackages.pillow
    pythonPackages.psutil
    pythonPackages.pycairo
    pythonPackages.pygobject3
    pythonPackages.pywal
    pythonPackages.pywayland
    pythonPackages.requests
    pythonPackages.setuptools-scm
    pythonPackages.urllib3
    pythonPackages.wheel
  ];
}
