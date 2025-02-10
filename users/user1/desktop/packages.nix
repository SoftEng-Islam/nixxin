{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [

    # ---- Settings.nix Packages ---- #
    settings.browserPkg
    settings.termPkg
    settings.style.cursor.package

    proot # User-space implementation of chroot, mount --bind and binfmt_misc
    # matugen # A material you color generation tool

    # ---- Disks & Filesystem ---- #
    cifs-utils
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
    cacert

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
    ddcutil # Query and change Linux monitor settings using DDC/CI and USB
    gojq # Pure Go implementation of jq
    rsync # Fast incremental file transfer utility
    tesseract # OCR engine
    tinyxml2 # Simple, small, efficient, C++ XML parser
    webp-pixbuf-loader # WebP GDK Pixbuf Loader library
    libbsd # Common functions found on BSD systems
    libselinux # SELinux core library
    audit # Audit Library
    # xmlto # Front-end to an XSL toolchain
    # fop # XML formatter driven by XSL Formatting Objects (XSL-FO)

    libgcc
    libpulseaudio
    llvmPackages_12.bintools # System binary utilities (wrapper script)
    meson
    mlocate
    nodejs_20
    pango # A library for laying out and rendering of text, with an emphasis on internationalization
    pkg-config # A tool that allows packages to find out information about other packages (wrapper script)
    tinyxml-2

    # Databases
    sqlite # A self-contained, serverless, zero-configuration, transactional SQL database engine

    # C & C++
    clang # A C language family frontend for LLVM (wrapper script)

    # Sass (Css)
    dart-sass # The reference implementation of Sass, written in Dart
    grass-sass # A Sass compiler written purely in Rust
    # libsass # A C/C++ implementation of a Sass compiler
    # rsass # Sass reimplemented in rust with nom
    # sassc # A front-end for libsass

    # ---- misc ---- #
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    gnupg

    # ---- Linux ---- #
    binutils # Tools for manipulating binaries (linker, assembler, etc.) (wrapper script)
    bpftrace # High-level tracing language for Linux eBPF
    ethtool # Utility for controlling network drivers and hardware
    fwupd # The Linux Vendor Firmware Service is a secure portal which allows hardware vendors to upload firmware updates.
    geoclue2 # Geolocation framework and some data providers
    linux-pam # Pluggable Authentication Modules, a flexible mechanism for authenticating user
    lm_sensors # for `sensors` command, Tools for reading hardware sensors
    lsof # list open files
    ltrace # library call monitoring
    man
    man-db
    man-pages # Linux development manual pages
    pciutils # Collection of programs for inspecting and manipulating configuration of PCI devices
    shfmt # Shell parser and formatter
    strace # System call tracer for Linux
    sudo # A command to run commands as root
    sysstat # Collection of performance monitoring tools for Linux (such as sar, iostat and pidstat)
    udevil # Mount without password
    usbutils # Tools for working with USB devices, such as lsusb
    whois # Intelligent WHOIS client from Debian
    busybox # Tiny versions of common UNIX utilities in a single small executable
    fdupes # Identifies duplicate files residing within specified directories

    # ---- productivity ---- #
    # hugo # static site generator
    # glow # markdown previewer in terminal
    # graphviz # Graph visualization tools
  ];
}
