{ settings, lib, pkgs, ... }:

lib.mkIf (settings.modules.pkgs.enable or false) {
  environment.systemPackages = with pkgs; [
    # ------------------------------------------------
    # ---- Hardware Packages
    # ------------------------------------------------

    # glaxnimate # Simple vector animation program.
    # hwdata # Hardware Database, including Monitors, pci.ids, usb.ids, and video cards
    # libplacebo # Reusable library for GPU-accelerated video/image rendering primitives
    # libva # An implementation for VA-API (Video Acceleration API)
    # openal # OpenAL alternative
    # spirv-cross
    # spirv-headers
    # spirv-llvm-translator
    # spirv-tools
    # libunwind

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
    # nfs-utils # Linux user-space NFS utilities
    ntfs3g # FUSE-based NTFS driver with full write support
    hdparm # Tool to get/set ATA/SATA drive parameters under Linux
    fio # Flexible IO Tester - an IO benchmark tool
    jmtpfs # FUSE filesystem for MTP devices like Android phones
    go-mtpfs # Simple FUSE filesystem for mounting Android devices as a MTP device

    # ---- Cryptographic ---- #
    # openssl # A cryptographic library that implements the SSL and TLS protocols
    # nettle # Cryptographic library
    # libgcrypt # General-purpose cryptographic library
    # cacert

    # ---- Utilities ---- #
    # autoconf # Part of the GNU Build System
    # autoconf-archive # Archive of autoconf m4 macros
    # automake # GNU standard-compliant makefile generator
    # autobuild # Continuous integration tool
    # libtool # GNU Libtool, a generic library support script
    # bc # GNU software calculator
    # coreutils # The GNU Core Utilities
    # cups # A standards-based printing system for UNIX
    # gdb # The GNU Project debugger
    # gnumake # A tool to control the generation of non-source files from sources
    # gcc
    # bpftune # BPF-based auto-tuning of Linux system parameters
    # tesseract # OCR engine
    # webp-pixbuf-loader # WebP GDK Pixbuf Loader library
    # libgcc
    # libpulseaudio
    # meson
    # mlocate
    # pkg-config # A tool that allows packages to find out information about other packages (wrapper script)

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
    ethtool # Utility for controlling network drivers and hardware
    lsof # list open files
    pciutils # Collection of programs for inspecting and manipulating configuration of PCI devices
    udevil # Mount without password
    usbutils # Tools for working with USB devices, such as lsusb
    whois # Intelligent WHOIS client from Debian
    udev # System and service manager for Linux

    gojq
    grim
    imagemagick
    playerctl
    swappy
    metadata-cleaner
    libqalculate # Advanced calculator library
    mkvtoolnix-cli # Cross-platform tools for Matroska
    slurp # Select a region in a Wayland compositor
    waypipe # Network proxy for Wayland clients (apps)
    wayvnc # VNC server for wlroots based Wayland compositors
    wev # Wayland event viewer
    gsettings-desktop-schemas # Crucial for many GTK/GNOME apps and portals

    # ---- Productivity ---- #
    # hugo # static site generator
    # graphviz # Graph visualization tools
  ];
  nixpkgs.config.permittedInsecurePackages = [ "libsoup-2.74.3" ];
}
