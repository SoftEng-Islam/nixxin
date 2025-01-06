{ pkgs, ... }: {
  imports = [ ./globalEnv.nix ];
  # Set environment variables for pyenv
  environment.sessionVariables = {

    # PIP_PREFIX = "$(pwd)/_build/pip_packages";
    # PYTHONPATH = "$PIP_PREFIX/${pkgs.python3.sitePackages}:$PYTHONPATH";

    LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    PYTHON_BUILD_HOOK = "echo 'Using NixOS dependencies'";
    LDFLAGS = "-L/nix/store -L$HOME/.nix-profile/lib -L/usr/lib";
    CPPFLAGS = "-I/nix/store -I$HOME/.nix-profile/include";
    # CFLAGS="-I$(nix eval --raw nixpkgs.openssl.dev)/include";
    # LDFLAGS="-L$(nix eval --raw nixpkgs.openssl.out)/lib";
    PYTHON_CFLAGS = "$CPPFLAGS";
    PYTHON_LDFLAGS = "$LDFLAGS";

    PYENV_ROOT = "$HOME/.pyenv";
    PATH = "$PYENV_ROOT/bin:$PATH";
    # Flags to help pyenv find dependencies
    # CPPFLAGS = "-I${pkgs.zlib.dev}/include -I${pkgs.libffi.dev}/include -I${pkgs.readline.dev}/include -I${pkgs.bzip2.dev}/include -I${pkgs.openssl.dev}/include";
    # LDFLAGS = "-L${pkgs.zlib.dev}/lib -L${pkgs.libffi.dev}/lib -L${pkgs.readline.dev}/lib -L${pkgs.bzip2.dev}/lib -L${pkgs.openssl.dev}/lib";
  };
  environment.systemPackages = with pkgs; [
    # Python --------------------------------
    meson # An open source, fast and friendly build system made in Python
    pyenv # Simple Python version management
    python-setup-hook
    pychess # Advanced GTK chess client written in Python
    pipx # Install and run Python applications in isolated environments
    python312Full # High-level dynamically-typed programming language
    python312Packages.virtualenv # Tool to create isolated Python environments
    python312Packages.babel # Collection of internationalizing tools
    python312Packages.beautifulsoup4 # HTML and XML parser
    python312Packages.build # Simple, correct PEP517 package builder
    python312Packages.cairosvg # SVG converter based on Cairo
    python312Packages.certifi # Python package for providing Mozilla's CA Bundle
    python312Packages.charset-normalizer # Python module for encoding and language detection
    python312Packages.click # The "Command Line Interactive Controller for Kubernetes"
    python312Packages.dbus-python # Python DBus bindings
    python312Packages.django # High-level Python Web framework that encourages rapid development and clean, pragmatic design
    python312Packages.flit-core # Distribution-building parts of Flit. See flit package for more information
    python312Packages.html2text # Convert HTML to plain text
    python312Packages.i3ipc # Improved Python library to control i3wm and sway
    python312Packages.icalendar # Parser/generator of iCalendar files
    python312Packages.idna
    python312Packages.installer
    python312Packages.lockfile
    python312Packages.loguru
    python312Packages.markupsafe
    python312Packages.material-color-utilities
    python312Packages.materialyoucolor
    python312Packages.mypy
    python312Packages.opencv-python # Open Computer Vision Library with more than 500 algorithms
    python312Packages.pillow # Friendly PIL fork (Python Imaging Library)
    python312Packages.pip
    python312Packages.psutil
    python312Packages.pycairo
    python312Packages.pygobject-stubs
    python312Packages.pygobject3
    python312Packages.pynvim # required by nvim
    python312Packages.pytest # Framework for writing tests
    python312Packages.pytz # World timezone definitions, modern and historical
    python312Packages.pywal # Generate and change colorschemes on the fly. A 'wal' rewrite in Python 3
    python312Packages.pywayland # Python bindings to wayland using cffi
    python312Packages.pywlroots # Python bindings to wlroots using cffi
    python312Packages.requests # HTTP library for Python
    python312Packages.requests-download
    python312Packages.requests-file
    python312Packages.ruff
    # python312Packages.ruff-api
    # python312Packages.ruff-lsp
    # python312Packages.ruffus
    python312Packages.setuptools # Utilities to facilitate the installation of Python packages
    python312Packages.setuptools-scm # Handles managing your python package versions in scm metadata
    python312Packages.sv-ttk # Gorgeous theme for Tkinter/ttk, based on the Sun Valley visual style
    python312Packages.systemd # Python module for native access to the systemd facilities
    python312Packages.tkinter # Standard Python interface to the Tcl/Tk GUI toolkit
    python312Packages.trio # Async/await-native I/O library for humans and snake people
    python312Packages.tzlocal # Tzinfo object for the local timezone
    python312Packages.urllib3 # Powerful, user-friendly HTTP client for Python
    python312Packages.virtualenv # Tool to create isolated Python environments
    python312Packages.watchdog # Python API and shell utilities to monitor file system events
    python312Packages.types-requests # Typing stubs for requests
    python312Packages.wheel # Built-package format for Python
    python312Packages.jinja2

    bzip2 # High-quality data compression program
    bzip2.dev
    cairo
    cairo.dev
    dbus.dev
    devtoolbox # Development tools at your fingertips
    fakeroot # Give a fake root environment through LD_PRELOAD
    gdbm
    gdbm.dev
    glib.dev
    gnumake
    gobject-introspection
    gobject-introspection.dev
    libbluetooth-dev
    libbz2-dev
    libffi
    libffi-dev
    libffi.dev
    liblzma-dev
    libncurses5-dev
    libncursesw5-dev
    libreadline-dev
    libsqlite3-dev
    libssl-dev
    libtool # GNU Libtool, a generic library support script
    libuuid-dev
    linuxHeaders
    makeWrapper
    ncurses
    ncurses.dev
    openssl
    openssl.dev
    pip-audit
    pkg-config
    pkgconf
    pyenv
    base16-schemes
    readline
    readline.dev
    sqlite
    sqlite.dev
    systemd.dev # System and service manager for Linux
    tk
    tk.dev
    wrapGAppsHook
    xorg.libICE
    xorg.libSM
    xorg.libX11
    xorg.libXext
    xorg.libXrender
    xz
    xz.dev
    zlib
    zlib.dev
    zlib-ng
    zlib-ng.dev
    buildLinux
    git
    gcc
    clang
    c-ares
    gnumake
    cmake
    nghttp2
    autoconf
    automake
    libtool
    readline
    ncurses
    openssl
    icu
    zlib
    lz4
  ];
}
