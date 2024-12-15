{ pkgs, ... }: {
  imports = [
    # /android
    ./android/pkgs.nix

    # /apps
    ./apps/browsers.nix
    ./apps/community-apps.nix
    ./apps/desktop-apps.nix
    ./apps/download-manager.nix
    ./apps/graphic-apps.nix
    ./apps/media-player.nix
    ./apps/nautilus.nix
    ./apps/office.nix

    # /development
    ./development/cli-tools.nix
    ./development/dev-apps.nix
    ./development/dev-pkgs.nix
    ./development/editors.nix
    ./development/git.nix
    ./development/hacking.nix
    ./development/javascript.nix
    ./development/python.nix
    ./development/rust.nix
    ./development/spell-checker.nix
    ./development/terminals.nix

    # /drivers
    ./drivers/drivers.nix
    ./drivers/media.nix

    # /gaming
    ./gaming/gameing.nix
    # ./gaming/lutris.nix
    ./gaming/steam.nix

    # /hardware
    ./hardware/desktop/audio.nix
    ./hardware/desktop/boot.nix
    ./hardware/desktop/graphic.nix
    # ./hardware/desktop/mouse.nix
    # ./hardware/desktop/printing.nix

    # /os
    ./os/appearance.nix
    ./os/clipboard.nix
    ./os/environment.nix
    ./os/locale.nix
    ./os/networking.nix
    ./os/nixos.nix
    ./os/notifications.nix
    ./os/power-management.nix
    ./os/programs.nix
    ./os/screenshots.nix
    ./os/services.nix
    ./os/users.nix
    ./os/zram.nix

    # /security
    # ./security/vpn.nix

    # /virtualization
    # ./virtualization/general.nix
    # ./virtualization/nemu/default.nix

    # /windows
    ./windows/wine.nix

    # /window-manager
    ./wm/gnome.nix
    ./wm/hyprland.nix

  ];
  nixpkgs.config = {
    rocmSupport = true;
    allowUnfree = true;
  };
  environment.systemPackages = with pkgs; [
    # Process Management
    htop # Interactive process viewer
    iotop # Tool to find out the processes doing the most IO

    # Linux Tools
    man-pages # Linux development manual pages
    strace # System call tracer for Linux
    sudo # A command to run commands as root
    shfmt # Shell parser and formatter

    # Hardware & System Utilities
    binutils # Tools for manipulating binaries (linker, assembler, etc.) (wrapper script)
    pciutils # Collection of programs for inspecting and manipulating configuration of PCI devices
    usbutils # Tools for working with USB devices, such as lsusb
    lm_sensors # Tools for reading hardware sensors
    geoclue2 # Geolocation framework and some data providers
    udevil # Mount without password
    corectrl # Control your computer hardware via application profiles
    whois # Intelligent WHOIS client from Debian

    # Text Search
    silver-searcher # Code-searching tool similar to ack, but faster
    ripgrep # Utility that combines the usability of The Silver Searcher with the raw speed of grep

    # D-Bus Tools
    dbus # Simple interprocess messaging system
    dbus-broker # Linux D-Bus Message Broker

    # Themes & Graphical Interfaces
    adw-gtk3 # The theme from libadwaita ported to GTK-3
    colloid-gtk-theme # A modern and clean Gtk theme
    gtk_engines # Theme engines for GTK 2
    gtk3 # A multi-platform toolkit for creating graphical user interfaces
    gtk4 # A multi-platform toolkit for creating graphical user interfaces
    libadwaita # Library to help with developing UI for mobile devices using GTK/GNOME
    papirus-icon-theme # Pixel perfect icon theme for Linux

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

    # XDG Tools
    xdg-dbus-proxy # DBus proxy for Flatpak and others
    xdg-desktop-portal # Desktop integration portals for sandboxed apps
    xdg-desktop-portal-gnome # Backend implementation for xdg-desktop-portal for the GNOME desktop environment
    xdg-desktop-portal-gtk # Desktop integration portals for sandboxed apps
    xdg-desktop-portal-hyprland # xdg-desktop-portal backend for Hyprland
    xdg-desktop-portal-wlr # xdg-desktop-portal backend for wlroots
    xdg-user-dirs # Tool to help manage well known user directories like the desktop folder and the music folder
    xdg-utils # A set of command line tools that assist applications with a variety of desktop integration tasks
    libxdg_basedir # Implementation of the XDG Base Directory specification

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
    kdePackages.breeze # Artwork, styles and assets for the Breeze visual style for the Plasma Desktop
    kdePackages.qt6ct # Qt6 Configuration Tool
    libdbusmenu-gtk3 # Library for passing menu structures across DBus
    webkitgtk_6_0 # Web content rendering engine, GTK port

    matugen # A material you color generation tool
  ];
}
