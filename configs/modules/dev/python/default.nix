{ lib, pkgs, ... }:
let
  ldLibraryPaths = [
    "${pkgs.stdenv.cc.cc.lib}/lib"
    "${pkgs.pipewire}/lib"
    # Add other necessary paths here
  ];
in {
  # imports = [ ./globalEnv.nix ];
  # Set environment variables for Python
  environment.sessionVariables = {
    # PYENV_ROOT = "$HOME/.pyenv";
    PYENV_ROOT = "${pkgs.pyenv}";
    # pyenv flags to be able to install Python
    CPPFLAGS =
      "-I${pkgs.zlib.dev}/include -I${pkgs.libffi.dev}/include -I${pkgs.readline.dev}/include -I${pkgs.bzip2.dev}/include -I${pkgs.openssl_3_3.dev}/include";
    CXXFLAGS =
      "-I${pkgs.zlib.dev}/include -I${pkgs.libffi.dev}/include -I${pkgs.readline.dev}/include -I${pkgs.bzip2.dev}/include -I${pkgs.openssl_3_3.dev}/include";
    CFLAGS = "-I${pkgs.openssl_3_3.dev}/include";
    LDFLAGS =
      "-L${pkgs.zlib.out}/lib -L${pkgs.libffi.out}/lib -L${pkgs.readline.out}/lib -L${pkgs.bzip2.out}/lib -L${pkgs.openssl_3_3.out}/lib";
    CONFIGURE_OPTS = "-with-openssl=${pkgs.openssl_3_3.dev}";
    PYENV_VIRTUALENV_DISABLE_PROMPT = "1";
    PYTHONPATH = "${pkgs.python3.sitePackages}:$PYTHONPATH";
    LD_LIBRARY_PATH = lib.mkForce (lib.makeLibraryPath ldLibraryPaths);
    PYTHON_BUILD_HOOK = "echo 'Using NixOS dependencies'";
    PYTHON_CFLAGS = "$CPPFLAGS";
    PYTHON_LDFLAGS = "$LDFLAGS";
    PYTHON_CONFIGURE_OPTS = "--enable-shared";
    PATH = "$PYENV_ROOT/bin:$PATH";
    # PIP_PREFIX = "$(pwd)/_build/pip_packages";
    # CPPFLAGS = "-I${pkgs.readline.dev}/include";
    # LDFLAGS = "-L${pkgs.readline.dev}/lib";
    # Flags to help pyenv find dependencies
    # CPPFLAGS = "-I${pkgs.zlib.dev}/include -I${pkgs.libffi.dev}/include -I${pkgs.readline.dev}/include -I${pkgs.bzip2.dev}/include -I${pkgs.openssl.dev}/include";
    # LDFLAGS = "-L${pkgs.zlib.dev}/lib -L${pkgs.libffi.dev}/lib -L${pkgs.readline.dev}/lib -L${pkgs.bzip2.dev}/lib -L${pkgs.openssl.dev}/lib";
  };
  environment.systemPackages = with pkgs; [
    python312Full # High-level dynamically-typed programming language
    python310
    python314
    openssl_3_3
    autoconf
    automake
    base16-schemes
    bzip2 # High-quality data compression program
    bzip2.dev
    c-ares
    cairo
    cairo.dev
    clang
    cmake
    dbus.dev
    devtoolbox # Development tools at your fingertips
    fakeroot # Give a fake root environment through LD_PRELOAD
    gcc
    gdbm
    gdbm.dev
    git
    glib.dev
    gnumake
    gobject-introspection
    gobject-introspection.dev
    icu
    libedit
    libffi
    libffi.dev
    libtool
    libtool # GNU Libtool, a generic library support script
    libuuid
    linuxHeaders
    lz4
    meson # An open source, fast and friendly build system made in Python
    ncurses
    ncurses.dev
    nghttp2
    openssl
    openssl.dev
    pip-audit
    pipx # Install and run Python applications in isolated environments
    pkg-config
    pkgconf
    pychess # Advanced GTK chess client written in Python
    pyenv # Simple Python version management
    pyenv.out
    pypy3
    readline
    readline.dev
    sqlite
    sqlite.dev
    systemd.dev # System and service manager for Linux
    tk
    tk.dev
    wrapGAppsHook
    xz
    xz.dev
    zlib
    zlib-ng
    zlib-ng.dev
    zlib.dev
    (python3.withPackages (subpkgs: with subpkgs; [ requests ]))
    (python3.withPackages (ps:
      with ps; [
        # Python packages
        babel # Collection of internationalizing tools
        beautifulsoup4 # HTML and XML parser
        build # Simple, correct PEP517 package builder
        cairosvg # SVG converter based on Cairo
        certifi # Python package for providing Mozilla's CA Bundle
        charset-normalizer # Python module for encoding and language detection
        click # The "Command Line Interactive Controller for Kubernetes"
        dbus-python # Python DBus bindings
        django # High-level Python Web framework that encourages rapid development and clean, pragmatic design
        flit-core # Distribution-building parts of Flit. See flit package for more information
        html2text # Convert HTML to plain text
        i3ipc # Improved Python library to control i3wm and sway
        icalendar # Parser/generator of iCalendar files
        idna
        installer
        jinja2
        lockfile
        loguru
        markupsafe
        material-color-utilities
        materialyoucolor
        matplotlib
        mypy
        numpy
        opencv-python # Open Computer Vision Library with more than 500 algorithms
        pandas
        pillow # Friendly PIL fork (Python Imaging Library)
        pip
        psutil
        pycairo
        pygobject-stubs
        pygobject3
        pynvim # required by nvim
        pytest # Framework for writing tests
        pytz # World timezone definitions, modern and historical
        pywal # Generate and change colorschemes on the fly. A 'wal' rewrite in Python 3
        pywayland # Python bindings to wayland using cffi
        pywlroots # Python bindings to wlroots using cffi
        ruff
        setuptools # Utilities to facilitate the installation of Python packages
        setuptools-scm # Handles managing your python package versions in scm metadata
        sv-ttk # Gorgeous theme for Tkinter/ttk, based on the Sun Valley visual style
        systemd # Python module for native access to the systemd facilities
        tkinter # Standard Python interface to the Tcl/Tk GUI toolkit
        trio # Async/await-native I/O library for humans and snake people
        types-requests # Typing stubs for requests
        tzlocal # Tzinfo object for the local timezone
        urllib3 # Powerful, user-friendly HTTP client for Python
        virtualenv # Tool to create isolated Python environments
        watchdog # Python API and shell utilities to monitor file system events
        wheel # Built-package format for Python
      ]))
  ];
}
