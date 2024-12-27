{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Python --------------------------------
    meson # An open source, fast and friendly build system made in Python
    pyenv # Simple Python version management
    python3
    python3Packages.pip
    # NOTE: add here any python package you need globally
    python312Packages.materialyoucolor
    python3Packages.beautifulsoup4
    python3Packages.build
    python3Packages.cairosvg
    python3Packages.certifi
    python3Packages.charset-normalizer
    python3Packages.click
    python3Packages.html2text
    python3Packages.icalendar
    python3Packages.idna
    python3Packages.loguru
    python3Packages.markupsafe
    python3Packages.opencv-python # Open Computer Vision Library with more than 500 algorithms
    python3Packages.pillow
    python3Packages.psutil
    python3Packages.pycairo
    python3Packages.pygobject3
    python3Packages.pynvim # required by nvim
    python3Packages.pytz
    python3Packages.pywal
    python3Packages.pywayland
    python3Packages.requests
    python3Packages.setuptools-scm
    python3Packages.tzlocal
    python3Packages.urllib3
    python3Packages.wheel
    python3Packages.jinja2
    python312Packages.pallets-sphinx-themes
  ];
}
