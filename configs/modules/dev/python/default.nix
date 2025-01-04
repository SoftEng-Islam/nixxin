{ pkgs, ... }:
let
  pythonWithOverrides = pkgs.python312.override {
    packageOverrides = python-self: python-super: {
      pallets-sphinx-themes = python-super.pallets-sphinx-themes.overrideAttrs
        (old: {
          buildPhase = ''
            echo "Skipping buildPhase"
          '';
          installPhase = ''
            echo "Skipping installPhase"
          '';
        });
    };
  };
in {
  environment.variables = {
    PYENV_ROOT = "$HOME/.pyenv";
    PATH = "$PYENV_ROOT/bin:$PATH";
  };
  environment.systemPackages = with pkgs; [
    # Python --------------------------------
    meson # An open source, fast and friendly build system made in Python
    pyenv # Simple Python version management
    pipx
    python312Full
    python312Packages.virtualenv
    python312Packages.babel
    python312Packages.beautifulsoup4
    python312Packages.build
    python312Packages.cairosvg
    python312Packages.certifi
    python312Packages.charset-normalizer
    python312Packages.click
    python312Packages.dbus-python
    python312Packages.django
    python312Packages.flit-core
    python312Packages.html2text
    python312Packages.i3ipc
    python312Packages.icalendar
    python312Packages.idna
    python312Packages.installer
    python312Packages.lockfile
    python312Packages.loguru
    python312Packages.markupsafe
    python312Packages.material-color-utilities
    python312Packages.materialyoucolor
    python312Packages.mypy
    python312Packages.opencv-python # Open Computer Vision Library with more than 500 algorithms
    python312Packages.pillow
    python312Packages.pip
    python312Packages.psutil
    python312Packages.pycairo
    python312Packages.pygobject-stubs
    python312Packages.pygobject3
    python312Packages.pynvim # required by nvim
    python312Packages.pytest
    python312Packages.pytz
    python312Packages.pywal
    python312Packages.pywayland
    python312Packages.pywlroots
    python312Packages.requests
    python312Packages.ruff
    python312Packages.setuptools
    python312Packages.setuptools-scm
    python312Packages.sv-ttk
    python312Packages.systemd
    python312Packages.tkinter
    python312Packages.trio
    python312Packages.tzlocal
    python312Packages.urllib3
    python312Packages.virtualenv
    python312Packages.watchdog
    python312Packages.types-requests
    python312Packages.wheel

    # python313Packages.jinja2
    pythonWithOverrides
    (pythonWithOverrides.withPackages
      (ps: with ps; [ jinja2 babel beautifulsoup4 ]))

    bzip2
    cairo.dev
    dbus.dev
    devtoolbox # Development tools at your fingertips
    fakeroot # Give a fake root environment through LD_PRELOAD
    gcc
    glib.dev
    gobject-introspection
    gobject-introspection.dev
    libffi
    libffi.dev
    libtool # GNU Libtool, a generic library support script
    linuxHeaders
    openssl
    pip-audit
    pkg-config
    sqlite
    systemd.dev # System and service manager for Linux
    wrapGAppsHook
    xz
    zlib
    zlib-ng
    zlib
    bzip2
  ];
}
