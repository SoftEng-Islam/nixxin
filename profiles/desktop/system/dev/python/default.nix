{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Python --------------------------------
    meson # An open source, fast and friendly build system made in Python
    pyenv # Simple Python version management
    python3
    python3Packages.pip
    # NOTE: add here any python package you need globally
    python-xwaykeyz
    python3Packages.beautifulsoup4
    python3Packages.build
    python3Packages.cairosvg
    python3Packages.certifi
    python3Packages.charset-normalizer
    python3Packages.click
    python3Packages.dbus-python
    python3Packages.django
    python3Packages.html2text
    python3Packages.i3ipc
    python3Packages.icalendar
    python3Packages.idna
    python3Packages.lockfile
    python3Packages.loguru
    python3Packages.markupsafe
    python3Packages.material-color-utilities
    python3Packages.materialyoucolor
    python3Packages.opencv-python # Open Computer Vision Library with more than 500 algorithms
    python3Packages.pillow
    python3Packages.psutil
    python3Packages.pycairo
    python3Packages.pygobject3
    python3Packages.pynvim # required by nvim
    python3Packages.pytz
    python3Packages.pywal
    python3Packages.pywayland
    python3Packages.pywlroots
    python3Packages.requests
    python3Packages.setuptools
    python3Packages.setuptools-scm
    python3Packages.sv-ttk
    python3Packages.systemd
    python3Packages.tkinter
    python3Packages.tzlocal
    python3Packages.urllib3
    python3Packages.virtualenv
    python3Packages.watchdog
    python3Packages.wheel

    (python3.withPackages (ps: [ ps.jinja2 ]))
    cairo.dev
    dbus.dev
    glib.dev
    gobject-introspection
    gobject-introspection.dev
    jinja2-cli
    libffi.dev
    linuxHeaders
    pip-audit
    pkg-config
    systemd.dev
    wrapGAppsHook

  ];
}
