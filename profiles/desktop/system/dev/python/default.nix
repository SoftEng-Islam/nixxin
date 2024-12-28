{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Python --------------------------------
    meson # An open source, fast and friendly build system made in Python
    pyenv # Simple Python version management
    python3

    # NOTE: add here any python package you need globally
    (python3.withPackages (ps:
      with ps; [
        pip
        beautifulsoup4
        build
        cairosvg
        certifi
        charset-normalizer
        click
        dbus-python
        django
        html2text
        i3ipc
        icalendar
        idna
        lockfile
        loguru
        markupsafe
        material-color-utilities
        materialyoucolor
        opencv-python # Open Computer Vision Library with more than 500 algorithms
        pillow
        psutil
        pycairo
        pygobject3
        pynvim # required by nvim
        pytz
        pywal
        pywayland
        pywlroots
        requests
        setuptools
        setuptools-scm
        sv-ttk
        systemd
        tkinter
        tzlocal
        urllib3
        virtualenv
        watchdog
        wheel
      ]))

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
