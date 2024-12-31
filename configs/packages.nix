{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # required by personal nvim config
    statix # nvim-lint
    nixfmt-classic # conform.nvim
    nixd # lsp server

    wayland
    settings.browserPkg
    settings.termPkg

    # Icons
    gruvbox-dark-icons-gtk
    gruvbox-plus-icons
    papirus-icon-theme # Pixel perfect icon theme for Linux

    # Plymouth Theme For Nixos:
    plymouth # Boot splash and boot logger
    nixos-bgrt-plymouth # BGRT theme with a spinning NixOS logo

    # nix related
    # it provides the command `nom` works just like `nix`
    # with more details log output
    cached-nix-shell # fast nix-shell scripts
    direnv # Shell extension that manages your environment
    fmt # Small, safe and fast formatting library
    home-manager # A Nix-based user environment configurator
    inxi # Full featured CLI system information tool
    nix-bash-completions # Bash completions for Nix, NixOS, and NixOps
    nix-btm # Rust tool to monitor Nix processes
    nix-direnv # Fast, persistent use_nix implementation for direnv
    nix-doc # Interactive Nix documentation tool
    nix-index # A files database for nixpkgs
    nix-output-monitor # Processes output of Nix commands to show helpful and pretty information
    nix-prefetch # Prefetch any fetcher function call, e.g. package sources
    nix-prefetch-github
    nixfmt-classic # An opinionated formatter for Nix
    nixos-install-tools # The essential commands from the NixOS installer as a package
    nixos-shell # Spawns lightweight nixos vms in a shell
    nixpkgs-lint # A utility for Nixpkgs contributors to check Nixpkgs for common errors
    nixpkgs-review

    # Nix language server
    nixd # Feature-rich Nix language server interoperating with C++ nix
    nil # Yet another language server for Nix

    # Nix Formatters:
    alejandra # Uncompromising Nix Code Formatter [alejandra file.nix]
    nixdoc # Generate documentation for Nix functions
    nixfmt-rfc-style # Official formatter for Nix code [nixfmt file.nix]
    nixpkgs-fmt # Nix code formatter for nixpkgs [nixpkgs-fmt file.nix]
    node2nix # Generate Nix expressions to build NPM packages

    # productivity
    # hugo # static site generator
    # glow # markdown previewer in terminal
    # iotop # io monitoring
    # iftop # network monitoring

    # Other
    # graphviz

    # QT & KDE Stuff
    adwaita-qt
    adwaita-qt6
    gsettings-qt
    kdePackages.xdg-desktop-portal-kde
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5ct # Qt5 Configuration Tool
    libsForQt5.qwt
    qt5.full
    qt5.qtgraphicaleffects
    qt5.qtquickcontrols2
    qt6.qtwayland
    qt6ct
    qt6Packages.qt6ct

    # GTK  Stuff & Themes & Graphical Interfaces
    gjs
    gjs.dev
    gobject-introspection
    gruvbox-dark-gtk # Gruvbox theme for GTK based desktop environments
    gruvbox-gtk-theme # GTK theme based on the Gruvbox colour palette
    gtk_engines # Theme engines for GTK 2
    gtk-layer-shell
    gtk3 # A multi-platform toolkit for creating graphical user interfaces
    gtk3.dev
    gtk4 # A multi-platform toolkit for creating graphical user interfaces
    gtk4-layer-shell # A library to create panels and other desktop components for Wayland using the Layer Shell protocol and GTK4
    gtk4.dev
    gtkmm2 # C++ interface to the GTK graphical user interface library
    gtkmm3 # C++ interface to the GTK graphical user interface library
    gtkmm4 # C++ interface to the GTK graphical user interface library
    gtksourceview
    gtksourceview.dev
    gtksourceview3
    libadwaita # Library to help with developing UI for mobile devices using GTK/GNOME
    libappindicator-gtk3.dev
    libdbusmenu-gtk3 # Library for passing menu structures across DBus
    tk
    upower
    #webkitgtk_6_0 # Web content rendering engine, GTK port
    webp-pixbuf-loader
    wrapGAppsHook
    yad
    ydotool

    # screenshot
    grim # Grab images from a Wayland compositor
    grimblast # A helper for screenshots within Hyprland, based on grimshot
    swappy # A Wayland native snapshot editing tool, inspired by Snappy on macOS
    flameshot # Powerful yet simple to use screenshot software
    scrot # A command-line screen capture utility
    wayshot # A native, blazing-fast screenshot tool for wlroots based compositors such as sway and river

    # Editors
    vscode # Open source source code editor developed by Microsoft for Windows, Linux and macOS
    zed-editor # Zed editor (like vscode)
    neovim # Vim text editor fork focused on extensibility and agility

    vim

    # Linux & system call monitoring
    bpftrace # High-level tracing language for Linux eBPF
    ethtool # Utility for controlling network drivers and hardware
    fwupd # The Linux Vendor Firmware Service is a secure portal which allows hardware vendors to upload firmware updates.
    linux-pam # Pluggable Authentication Modules, a flexible mechanism for authenticating user
    lm_sensors # for `sensors` command
    lsof # list open files
    ltrace # library call monitoring
    man-pages # Linux development manual pages
    shfmt # Shell parser and formatter
    strace # System call tracer for Linux
    sudo # A command to run commands as root
    sysstat # Collection of performance monitoring tools for Linux (such as sar, iostat and pidstat)

    # Audio.
    ladspaPlugins
    calf
    lsp-plugins
    easyeffects
    alsa-utils

    # Development.
    atk.dev
    cairo.dev
    cmake
    gcc13
    gdk-pixbuf.dev
    glib
    glib.dev
    glibc.dev
    gobject-introspection.dev
    gtksourceviewmm
    harfbuzz.dev
    jetbrains-toolbox
    libpulseaudio.dev
    meson
    mlocate
    nodejs_20
    tinyxml-2

    # Latex
    texliveFull # TeX Live environment
    texlive.combined.scheme-full # TeX Live environment for scheme-full

    # JavaScript
    nodejs_23 # Event-driven I/O framework for the V8 JavaScript engine
    nodePackages.pnpm # Fast, disk space efficient package manager
    typescript # Superset of JavaScript that compiles to clean JavaScript output

    # Android
    waydroid # Waydroid is a container-based approach to boot a full Android system on a regular GNU/Linux system like Ubuntu
    scrcpy # Display and control Android devices over USB or TCP/IP

    # clipboard
    cliphist # Wayland clipboard manager
    gpaste # Clipboard management system with GNOME integration
    wl-clipboard # Command-line copy/paste utilities for Wayland
    clipman # A simple clipboard manager for Wayland
    fuzzel # Wayland-native application launcher, similar to rofi’s drun mode

    # Process Management
    htop # Interactive process viewer
    iotop # Tool to find out the processes doing the most IO

    # Hardware & System Utilities
    binutils # Tools for manipulating binaries (linker, assembler, etc.) (wrapper script)
    pciutils # Collection of programs for inspecting and manipulating configuration of PCI devices
    usbutils # Tools for working with USB devices, such as lsusb
    lm_sensors # Tools for reading hardware sensors
    geoclue2 # Geolocation framework and some data providers
    udevil # Mount without password
    whois # Intelligent WHOIS client from Debian

    # Text Search
    silver-searcher # Code-searching tool similar to ack, but faster
    ripgrep # Utility that combines the usability of The Silver Searcher with the raw speed of grep

    # D-Bus Tools
    dbus # Simple interprocess messaging system
    dbus-broker # Linux D-Bus Message Broker

    # Disk, Partition & Filesystem Tools
    gvfs # Virtual Filesystem support library
    bees # Bees is a deduplication tool designed specifically for filesystems that use the Btrfs (B-tree file system).
    btrfs-progs # Utilities for the btrfs filesystem
    dos2unix # Convert text files with DOS or Mac line breaks to Unix line breaks and vice versa
    dosfstools # Utilities for creating and checking FAT and VFAT file systems
    duf # Disk Usage/Free Utility
    e2fsprogs # Tools for creating and checking ext2/ext3/ext4 filesystems
    efibootmgr # A Linux user-space application to modify the Intel Extensible Firmware Interface (EFI) Boot Manager
    efitools # Tools for manipulating UEFI secure boot platforms
    exfatprogs # exFAT filesystem userspace utilities
    f2fs-tools # Userland tools for the f2fs filesystem
    fuse3 # Library that allows filesystems to be implemented in user space
    mtools # Utilities to access MS-DOS disks
    mtpfs # FUSE Filesystem providing access to MTP devices
    nfs-utils # Linux user-space NFS utilities
    ntfs3g # FUSE-based NTFS driver with full write support
    hdparm # Tool to get/set ATA/SATA drive parameters under Linux
    fio # Flexible IO Tester - an IO benchmark tool
    jmtpfs # FUSE filesystem for MTP devices like Android phones
    go-mtpfs # Simple FUSE filesystem for mounting Android devices as a MTP device

    # Wayland
    anyrun # A wayland-native, highly customizable runner
    brightnessctl
    fcitx5 # Next generation of fcitx
    libqalculate # Advanced calculator library
    libva-utils # Collection of utilities and examples for VA-API
    mkvtoolnix-cli # Cross-platform tools for Matroska
    seatd # A minimal seat management daemon, and a universal seat management library
    slurp # Select a region in a Wayland compositor
    swww # Efficient animated wallpaper daemon for wayland, controlled at runtime
    wayland-utils # Wayland utilities (wayland-info)
    waypipe # Network proxy for Wayland clients (applications)
    wayvnc # VNC server for wlroots based Wayland compositors
    weston # Lightweight and functional Wayland compositor
    wev # Wayland event viewer
    wf-recorder # Utility program for screen recording of wlroots-based compositors
    wl-gammactl # Contrast, brightness, and gamma adjustments for Wayland
    wl-gammarelay-rs # A simple program that provides DBus interface to control display temperature and brightness under wayland without flickering
    wlogout # Wayland based logout menu
    wlr-protocols # Wayland roots protocol extensions
    wlrctl # Command line utility for miscellaneous wlroots Wayland extensions
    wlroots # A modular Wayland compositor library
    wlsunset # Day/night gamma adjustments for Wayland
    wtype # xdotool type for wayland

    # Cryptographic Tools
    openssl # A cryptographic library that implements the SSL and TLS protocols
    nettle # Cryptographic library
    libgcrypt # General-purpose cryptographic library

    # System Tools
    busybox # Tiny versions of common UNIX utilities in a single small executable
    resources # Monitor your system resources and processes
    fdupes # Identifies duplicate files residing within specified directories

    # Image Viewers
    imv # A command line image viewer for tiling window managers
    feh # A light-weight image viewer
    loupe # A simple image viewer application written with GTK4 and Rust

    # Notifications
    notify # Notify allows sending the output from any tool to Slack, Discord and Telegram
    libnotify # A library that sends desktop notifications to a notification daemon
    libnotify.dev # Library that sends desktop notifications to a notification daemon
    # dunst # Lightweight and customizable notification daemon
    # mako # A lightweight Wayland notification daemon
    # avizo # Neat notification daemon for Wayland

    # GNU Utilities
    autoconf # Part of the GNU Build System
    autoconf-archive # Archive of autoconf m4 macros
    automake # GNU standard-compliant makefile generator
    autobuild # Continuous integration tool
    libtool # GNU Libtool, a generic library support script
    bc # GNU software calculator
    coreutils # The GNU Core Utilities
    cups # A standards-based printing system for UNIX
    gcc # GNU Compiler Collection, version 13.2.0 (wrapper script)
    gdb # The GNU Project debugger
    glibc # The GNU C Library
    gnuchess # GNU Chess engine
    gnumake # A tool to control the generation of non-source files from sources
    libGL # Stub bindings using libglvnd
    libGLU # OpenGL utility library

    # Other Tools
    upower # D-Bus service for power management
    bpftune # BPF-based auto-tuning of Linux system parameters
    axel # Console downloading program with some features for parallel connections for faster downloading
    cmake # Cross-platform, open-source build system generator
    ddcutil # Query and change Linux monitor settings using DDC/CI and USB
    gammastep # Screen color temperature manager
    gojq # Pure Go implementation of jq
    rsync # Fast incremental file transfer utility
    starship # Minimal, blazing fast, and extremely customizable prompt for any shell
    tesseract # OCR engine
    tinyxml2 # Simple, small, efficient, C++ XML parser
    webp-pixbuf-loader # WebP GDK Pixbuf Loader library
    clblast # Tuned OpenCL BLAS library
    libbsd # Common functions found on BSD systems
    libselinux # SELinux core library
    audit # Audit Library
    xmlto # Front-end to an XSL toolchain
    fop # XML formatter driven by XSL Formatting Objects (XSL-FO)
    libdbusmenu # Library for passing menu structures across DBus

    dconf # dconf is a simple key/value storage system that is heavily optimised for reading.
    dconf-editor # GSettings editor for GNOME

    proot # User-space implementation of chroot, mount --bind and binfmt_misc
    matugen # A material you color generation tool

    # developers packages
    at-spi2-atk # Assistive Technology Service Provider Interface protocol definitions and daemon for D-Bus
    atkmm # C++ wrappers for ATK accessibility toolkit
    bun # Incredibly fast JavaScript runtime, bundler, transpiler and package manager – all in one
    cairo # A 2D graphics library with support for multiple output devices
    cairomm # C++ bindings for the Cairo vector graphics library
    direnv # A shell extension that manages your environment
    gdk-pixbuf # A library for image loading and manipulation
    glib # C library of programming buildings blocks
    gobject-introspection-unwrapped
    gobject-introspection # A middleware layer between C libraries and language bindings
    harfbuzz # An OpenType text shaping engine
    # bintools # Tools for manipulating binaries (linker, assembler, etc.) (wrapper script)
    llvmPackages_12.bintools # System binary utilities (wrapper script)
    pango # A library for laying out and rendering of text, with an emphasis on internationalization
    pango.dev
    pkg-config # A tool that allows packages to find out information about other packages (wrapper script)
    zlib # Lossless data-compression library

    # Databases
    sqlite # A self-contained, serverless, zero-configuration, transactional SQL database engine

    # C & C++
    clang # A C language family frontend for LLVM (wrapper script)

    # Sass (Css)
    dart-sass # The reference implementation of Sass, written in Dart
    libsass # A C/C++ implementation of a Sass compiler
    rsass # Sass reimplemented in rust with nom
    grass-sass # A Sass compiler written purely in Rust
    sassc # A front-end for libsass

    # Ruby
    ruby_3_3 # An object-oriented language for quick and easy programming
    rubyPackages.execjs
  ];
}
