{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [

    # ---- Settings.nix Packages ---- #
    settings.browserPkg
    settings.termPkg
    settings.cursorPackage

    # ---- Screenshot ---- #
    grim # Grab images from a Wayland compositor
    grimblast # A helper for screenshots within Hyprland, based on grimshot
    swappy # A Wayland native snapshot editing tool, inspired by Snappy on macOS
    flameshot # Powerful yet simple to use screenshot software
    scrot # A command-line screen capture utility
    wayshot # A native, blazing-fast screenshot tool for wlroots based compositors such as sway and river

    # ---- Editors ---- #
    vscode # Open source source code editor developed by Microsoft for Windows, Linux and macOS
    zed-editor # Zed editor (like vscode)
    neovim # Vim text editor fork focused on extensibility and agility

    # ---- clipboard ---- #
    cliphist # Wayland clipboard manager
    wl-clipboard # Command-line copy/paste utilities for Wayland
    # gpaste # Clipboard management system with GNOME integration
    # clipman # A simple clipboard manager for Wayland

    # ---- Text Search ---- #
    # silver-searcher # Code-searching tool similar to ack, but faster
    # ripgrep # Utility that combines the usability of The Silver Searcher with the raw speed of grep

    # ---- D-Bus ---- #
    dbus # Simple interprocess messaging system
    dbus-broker # Linux D-Bus Message Broker

    dconf # dconf is a simple key/value storage system that is heavily optimised for reading.
    dconf-editor # GSettings editor for GNOME
    proot # User-space implementation of chroot, mount --bind and binfmt_misc
    matugen # A material you color generation tool

    # ---- Disks & Filesystem ---- #
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

    # ---- Cryptographic ---- #
    openssl # A cryptographic library that implements the SSL and TLS protocols
    nettle # Cryptographic library
    libgcrypt # General-purpose cryptographic library

    # ---- Image Viewers ---- #
    imv # A command line image viewer for tiling window managers
    feh # A light-weight image viewer
    loupe # A simple image viewer application written with GTK4 and Rust

    # ---- Notifications ---- #
    notify # Notify allows sending the output from any tool to Slack, Discord and Telegram
    libnotify # A library that sends desktop notifications to a notification daemon
    libnotify.dev # Library that sends desktop notifications to a notification daemon
    # dunst # Lightweight and customizable notification daemon
    # mako # A lightweight Wayland notification daemon
    # avizo # Neat notification daemon for Wayland

    # ---- GNU Utilities ---- #
    autoconf # Part of the GNU Build System
    autoconf-archive # Archive of autoconf m4 macros
    automake # GNU standard-compliant makefile generator
    autobuild # Continuous integration tool
    libtool # GNU Libtool, a generic library support script
    bc # GNU software calculator
    coreutils # The GNU Core Utilities
    cups # A standards-based printing system for UNIX
    gdb # The GNU Project debugger
    gnuchess # GNU Chess engine
    gnumake # A tool to control the generation of non-source files from sources
    libGL # Stub bindings using libglvnd
    libGLU # OpenGL utility library

    # Other Tools
    upower # D-Bus service for power management
    bpftune # BPF-based auto-tuning of Linux system parameters
    axel # Console downloading program with some features for parallel connections for faster downloading
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

    # developers packages
    # bintools # Tools for manipulating binaries (linker, assembler, etc.) (wrapper script)
    at-spi2-atk # Assistive Technology Service Provider Interface protocol definitions and daemon for D-Bus
    atk.dev
    atkmm # C++ wrappers for ATK accessibility toolkit
    bun # Incredibly fast JavaScript runtime, bundler, transpiler and package manager – all in one
    cairo # A 2D graphics library with support for multiple output devices
    cairo.dev
    cairomm # C++ bindings for the Cairo vector graphics library
    gdk-pixbuf # A library for image loading and manipulation
    gdk-pixbuf.dev
    glib # C library of programming buildings blocks
    glib-networking
    glib.dev
    glibc
    glibc_memusage
    glibc.dev
    glibtool
    gobject-introspection # A middleware layer between C libraries and language bindings
    gobject-introspection-unwrapped
    gobject-introspection.dev
    gtksourceviewmm
    harfbuzz # An OpenType text shaping engine
    harfbuzz.dev
    jetbrains-toolbox
    libdbusmenu-gtk3
    libgcc
    libpulseaudio
    libpulseaudio.dev
    llvmPackages_12.bintools # System binary utilities (wrapper script)
    meson
    mlocate
    nodejs_20
    pango # A library for laying out and rendering of text, with an emphasis on internationalization
    pango.dev
    pkg-config # A tool that allows packages to find out information about other packages (wrapper script)
    tinyxml-2
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
