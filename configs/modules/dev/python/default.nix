{ pkgs, ... }:
let
  pythonWithOverrides = pkgs.python313.override {
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
    python313Full
    python313Packages.virtualenv
    python313Packages.babel
    python313Packages.beautifulsoup4
    python313Packages.build
    python313Packages.cairosvg
    python313Packages.certifi
    python313Packages.charset-normalizer
    python313Packages.click
    python313Packages.dbus-python
    python313Packages.django
    python313Packages.flit-core
    python313Packages.html2text
    python313Packages.i3ipc
    python313Packages.icalendar
    python313Packages.idna
    python313Packages.installer
    python313Packages.lockfile
    python313Packages.loguru
    python313Packages.markupsafe
    python313Packages.material-color-utilities
    python313Packages.materialyoucolor
    python313Packages.mypy
    python313Packages.opencv-python # Open Computer Vision Library with more than 500 algorithms
    python313Packages.pillow
    python313Packages.pip
    python313Packages.psutil
    python313Packages.pycairo
    python313Packages.pygobject-stubs
    python313Packages.pygobject3
    python313Packages.pynvim # required by nvim
    python313Packages.pytest
    python313Packages.pytz
    python313Packages.pywal
    python313Packages.pywayland
    python313Packages.pywlroots
    python313Packages.requests
    python313Packages.ruff
    python313Packages.setuptools
    python313Packages.setuptools-scm
    python313Packages.sv-ttk
    python313Packages.systemd
    python313Packages.tkinter
    python313Packages.trio
    python313Packages.tzlocal
    python313Packages.urllib3
    python313Packages.virtualenv
    python313Packages.watchdog
    python313Packages.types-requests
    python313Packages.wheel

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

  ];
}
