{ pkgs, ... }: {
  # imports = [ ./jinja2.nix ];
  # Set environment variables for pyenv
  environment.sessionVariables = {

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
    pipx # Install and run Python applications in isolated environments
    python312Full # High-level dynamically-typed programming language
    python312Packages.virtualenv # Tool to create isolated Python environments
    python312Packages.babel # Collection of internationalizing tools
    python312Packages.beautifulsoup4 # HTML and XML parser
    python312Packages.build # Simple, correct PEP517 package builder
    python312Packages.cairosvg # SVG converter based on Cairo
    python312Packages.certifi # Python package for providing Mozilla's CA Bundle
    python312Packages.charset-normalizer # Python module for encoding and language detection
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
    # python312Packages.

    build-essential
    bzip2
    bzip2.dev
    cairo.dev
    dbus.dev
    devtoolbox # Development tools at your fingertips
    fakeroot # Give a fake root environment through LD_PRELOAD
    gcc
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
    pyenv
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
    zlib-ng
    zlib.dev
    zlib1g-dev
  ];
}
