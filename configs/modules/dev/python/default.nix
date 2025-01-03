{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Python --------------------------------
    meson # An open source, fast and friendly build system made in Python
    pyenv # Simple Python version management
    python313Full

    python313Packages.pip
    python313Packages.beautifulsoup4
    python313Packages.build
    python313Packages.cairosvg
    python313Packages.certifi
    python313Packages.charset-normalizer
    python313Packages.click
    python313Packages.dbus-python
    python313Packages.django
    python313Packages.html2text
    python313Packages.i3ipc
    python313Packages.icalendar
    python313Packages.idna
    python313Packages.lockfile
    python313Packages.loguru
    python313Packages.markupsafe
    python313Packages.material-color-utilities
    python313Packages.materialyoucolor
    python313Packages.opencv-python # Open Computer Vision Library with more than 500 algorithms
    python313Packages.pillow
    python313Packages.psutil
    python313Packages.pycairo
    python313Packages.pygobject3
    python313Packages.pynvim # required by nvim
    python313Packages.pytz
    python313Packages.pywal
    python313Packages.pywayland
    python313Packages.pywlroots
    python313Packages.requests
    python313Packages.setuptools
    python313Packages.setuptools-scm
    python313Packages.sv-ttk
    python313Packages.systemd
    python313Packages.tkinter
    python313Packages.tzlocal
    python313Packages.urllib3
    python313Packages.virtualenv
    python313Packages.watchdog
    python313Packages.wheel
    python313Packages.ruff
    python313Packages.mypy
    python313Packages.jinja2

    cairo.dev
    dbus.dev
    glib.dev
    gobject-introspection
    gobject-introspection.dev
    libffi.dev
    linuxHeaders
    pip-audit
    pkg-config
    systemd.dev
    wrapGAppsHook

  ];
}
