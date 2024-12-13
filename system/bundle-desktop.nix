{ pkgs, ... }: {
  imports = [
    # /android
    ./android/pkgs.nix
    # /apps
    # ./apps/cron.nix
    ./apps/desktop-apps.nix
    # ./apps/ollama.nix
    # ./apps/thunar.nix
    # ./apps/tlp.nix
    # /development
    ./development/cli-tools.nix
    ./development/dev-pkgs.nix
    ./development/dev-apps.nix
    ./development/git.nix
    ./development/hacking.nix
    ./development/python.nix
    ./development/rust.nix
    ./development/spell-checker.nix
    ./development/terminals.nix
    # /drivers
    ./drivers/drivers.nix
    ./drivers/media.nix
    # /gaming
    # ./gaming/aagl.nix
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
    # ./security/vpn/wireguard.nix
    # ./security/vpn/xray.nix
    # /virtualization
    # ./virtualization/general.nix
    # ./virtualization/nemu/default.nix
    # /window-manager
    ./wm/gnome.nix
    ./wm/hyprland.nix
    # /windows
    ./windows/wine.nix
  ];
  nixpkgs.config = {
    rocmSupport = true;
    allowUnfree = true;
  };
  environment.systemPackages = with pkgs; [

    (mpv.override { scripts = [ mpvScripts.mpris ]; })
    spotify
    # gnome-secrets
    fragments
    figma-linux
    # yabridge
    # yabridgectl
    # wine-staging

    rar # Utility for RAR archives

    binutils # Tools for manipulating binaries (linker, assembler, etc.) (wrapper script)
    file # Program that shows the type of files
    htop # Interactive process viewer
    silver-searcher # Code-searching tool similar to ack, but faster
    lsof # Tool to list open files
    rsync # Fast incremental file transfer utility
    strace # System call tracer for Linux
    iotop # Tool to find out the processes doing the most IO
    man-pages # Linux development manual pages
    dnsutils # Domain name server
    whois # Intelligent WHOIS client from Debian
    usbutils # Tools for working with USB devices, such as lsusb
    pciutils # Collection of programs for inspecting and manipulating configuration of PCI devices

    sudo # A command to run commands as root
    dconf # dconf is a simple key/value storage system that is heavily optimised for reading.
    proot # User-space implementation of chroot, mount --bind and binfmt_misc
    dbus # Simple interprocess messaging system
    dbus-broker # Linux D-Bus Message Broker
    corectrl # Control your computer hardware via application profiles
    lm_sensors # Tools for reading hardware sensors
    pciutils # A collection of programs for inspecting and manipulating configuration of PCI devices
    udevil # Mount without password
    geoclue2 # Geolocation framework and some data providers

    #__ gtk & Themes Stuff __#
    adw-gtk3 # The theme from libadwaita ported to GTK-3
    colloid-gtk-theme # A modern and clean Gtk theme
    gtk_engines # Theme engines for GTK 2
    gtk3 # A multi-platform toolkit for creating graphical user interfaces
    gtk4 # A multi-platform toolkit for creating graphical user interfaces
    gtk4-layer-shell # A library to create panels and other desktop components for Wayland using the Layer Shell protocol and GTK4
    gtkmm2 # C++ interface to the GTK graphical user interface library
    gtkmm3 # C++ interface to the GTK graphical user interface library
    gtkmm4 # C++ interface to the GTK graphical user interface library
    gtksourceview
    kdePackages.breeze
    kdePackages.qt6ct
    libadwaita # Library to help with developing UI for mobile devices using GTK/GNOME
    libdbusmenu-gtk3 # Library for passing menu structures across DBus
    papirus-icon-theme # Pixel perfect icon theme for Linux
    webkitgtk_6_0 # Web content rendering engine, GTK port

    # Disks & Partitions & Files System
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

    #__ Wayland Stuff __#
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
    matugen # A material you color generation tool
    wf-recorder # Utility program for screen recording of wlroots-based compositors

    # cryptographic
    openssl # A cryptographic library that implements the SSL and TLS protocols
    nettle # Cryptographic library
    libgcrypt # General-purpose cryptographic library

    #__ System Tools __#
    busybox # Tiny versions of common UNIX utilities in a single small executable
    resources # Monitor your system resources and processes
    fdupes # Identifies duplicate files residing within specified directories

    # Image Viewer
    imv # A command line image viewer for tiling window managers
    feh # A light-weight image viewer
    loupe # A simple image viewer application written with GTK4 and Rust

    #__ Keyboard __#
    # fcitx5 # Next generation of fcitx

    #__ xdg Stuff __#
    xdg-dbus-proxy # DBus proxy for Flatpak and others
    xdg-desktop-portal # Desktop integration portals for sandboxed apps
    xdg-desktop-portal-gnome # Backend implementation for xdg-desktop-portal for the GNOME desktop environment
    xdg-desktop-portal-gtk # Desktop integration portals for sandboxed apps
    xdg-desktop-portal-hyprland # xdg-desktop-portal backend for Hyprland
    xdg-desktop-portal-wlr # xdg-desktop-portal backend for wlroots
    xdg-user-dirs # Tool to help manage well known user directories like the desktop folder and the music folder
    xdg-utils # A set of command line tools that assist applications with a variety of desktop integration tasks
    libxdg_basedir # Implementation of the XDG Base Directory specification

    #__ GNU Stuff __#
    autoconf # Part of the GNU Build System
    autoconf-archive # Archive of autoconf m4 macros
    automake # GNU standard-compliant makefile generator
    autobuild # Continuous integration tool
    libtool # GNU Libtool, a generic library support script
    bash # GNU Bourne-Again Shell, the de facto standard shell on Linux
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

    #__ Other __
    upower # D-Bus service for power management
    libsForQt5.qt5ct # Qt5 Configuration Tool
    bpftune # BPF-based auto-tuning of Linux system parameters
    axel # Console downloading program with some features for parallel connections for faster downloading
    cmake # Cross-platform, open-source build system generator
    ddcutil # Query and change Linux monitor settings using DDC/CI and USB
    gammastep # Screen color temperature manager
    gojq # Pure Go implementation of jq
    ripgrep # Utility that combines the usability of The Silver Searcher with the raw speed of grep
    rsync # Fast incremental file transfer utility
    starship # Minimal, blazing fast, and extremely customizable prompt for any shell
    tesseract # OCR engine
    tinyxml2 # Simple, small, efficient, C++ XML parser
    webp-pixbuf-loader # WebP GDK Pixbuf Loader library
    clblast # Tuned OpenCL BLAS library
    libbsd

    libselinux
    audit
    xmlto
    fop
    libdbusmenu
  ];
}
