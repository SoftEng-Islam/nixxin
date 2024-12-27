{ pkgs, settings, ... }: {
  environment.systemPackages = with pkgs; [
    kdePackages.xdg-desktop-portal-kde
    qt5.qtquickcontrols2
    qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2
    qt5.full

    settings.browserPkg
    settings.termPkg

    # screenshot
    grim # Grab images from a Wayland compositor
    grimblast # A helper for screenshots within Hyprland, based on grimshot
    swappy # A Wayland native snapshot editing tool, inspired by Snappy on macOS
    flameshot # Powerful yet simple to use screenshot software
    scrot # A command-line screen capture utility
    wayshot # A native, blazing-fast screenshot tool for wlroots based compositors such as sway and river

    # Editors
    # gedit # Former GNOME text editor
    vscode # Open source source code editor developed by Microsoft for Windows, Linux and macOS
    zed-editor # Zed editor (like vscode)
    neovim # Vim text editor fork focused on extensibility and agility

    # Linux --------------------------------
    man-pages # Linux development manual pages
    strace # System call tracer for Linux
    sudo # A command to run commands as root
    shfmt # Shell parser and formatter
    fwupd # The Linux Vendor Firmware Service is a secure portal which allows hardware vendors to upload firmware updates.
    bpftrace # High-level tracing language for Linux eBPF

    # JavaScript --------------------------------
    nodejs_23 # Event-driven I/O framework for the V8 JavaScript engine
    nodePackages.pnpm # Fast, disk space efficient package manager
    typescript # Superset of JavaScript that compiles to clean JavaScript output

    # Android --------------------------------
    waydroid # Waydroid is a container-based approach to boot a full Android system on a regular GNU/Linux system like Ubuntu
    scrcpy # Display and control Android devices over USB or TCP/IP

    # clipboard --------------------------------
    cliphist # Wayland clipboard manager
    gpaste # Clipboard management system with GNOME integration
    wl-clipboard # Command-line copy/paste utilities for Wayland
    clipman # A simple clipboard manager for Wayland
    fuzzel # Wayland-native application launcher, similar to rofi’s drun mode

    # Process Management --------------------------------
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
    # gvfs # Virtual Filesystem support library
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

    # Wayland Tools
    anyrun # A wayland-native, highly customizable runner
    seatd # A minimal seat management daemon, and a universal seat management library
    slurp # Select a region in a Wayland compositor
    swww # Efficient animated wallpaper daemon for wayland, controlled at runtime
    uwsm # Universal wayland session manager
    wl-gammactl # Contrast, brightness, and gamma adjustments for Wayland
    wl-gammarelay-rs # A simple program that provides DBus interface to control display temperature and brightness under wayland without flickering
    wlogout # Wayland based logout menu
    wlr-protocols # Wayland roots protocol extensions
    wlroots # A modular Wayland compositor library
    wf-recorder # Utility program for screen recording of wlroots-based compositors
    weston # Lightweight and functional Wayland compositor
    waypipe # Network proxy for Wayland clients (applications)
    wayland-utils
    wlrctl
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
    # notify # Notify allows sending the output from any tool to Slack, Discord and Telegram
    # libnotify # A library that sends desktop notifications to a notification daemon
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
    libsForQt5.qt5ct # Qt5 Configuration Tool
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
    pciutils # A collection of programs for inspecting and manipulating configuration of PCI devices

    # GTK  Stuff
    gtk4-layer-shell # A library to create panels and other desktop components for Wayland using the Layer Shell protocol and GTK4
    gtkmm2 # C++ interface to the GTK graphical user interface library
    gtkmm3 # C++ interface to the GTK graphical user interface library
    gtkmm4 # C++ interface to the GTK graphical user interface library
    gtksourceview
    libdbusmenu-gtk3 # Library for passing menu structures across DBus
    webkitgtk_6_0 # Web content rendering engine, GTK port

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
    ninja # Small build system with a focus on speed
    pango # A library for laying out and rendering of text, with an emphasis on internationalization
    pkg-config # A tool that allows packages to find out information about other packages (wrapper script)
    zlib # Lossless data-compression library

    #__ Databases __#
    sqlite # A self-contained, serverless, zero-configuration, transactional SQL database engine

    #__ C & C++ __#
    clang # A C language family frontend for LLVM (wrapper script)

    #__ Sass (Css) __#
    dart-sass # The reference implementation of Sass, written in Dart
    libsass # A C/C++ implementation of a Sass compiler
    rsass # Sass reimplemented in rust with nom
    grass-sass # A Sass compiler written purely in Rust
    sassc # A front-end for libsass

    #__ Ruby __#
    ruby_3_3 # An object-oriented language for quick and easy programming
    rubyPackages.execjs

  ];
}
