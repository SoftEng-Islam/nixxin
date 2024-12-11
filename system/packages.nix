{ pkgs, ... }: {
  nixpkgs.config = {
    rocmSupport = true;
    allowUnfree = true;
  };
  environment.systemPackages = with pkgs; [
    ouch # Command-line utility for easily compressing and decompressing files and directories
    wget # Tool for retrieving files using HTTP, HTTPS, and FTP
    psmisc # Set of small useful utilities that use the proc filesystem (such as fuser, killall and pstree)

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

    #__ CLI utils __#
    gum # Tasty Bubble Gum for your shell
    bluez # Official Linux Bluetooth protocol stack
    bluez-tools # A set of tools to manage bluetooth devices for linux
    fastfetch # Like neofetch, but much faster because written in C
    file # A program that shows the type of files
    htop # An interactive process viewer
    mediainfo # Supplies technical and tag information about a video or audio file
    ranger # File manager with minimalistic curses interface
    tree # Command to produce a depth indented directory listing
    unzip # An extraction utility for archives compressed in .zip format
    zip # Compressor/archiver for creating and modifying zipfiles

    #__ Notifications __#
    notify # Notify allows sending the output from any tool to Slack, Discord and Telegram
    libnotify # A library that sends desktop notifications to a notification daemon
    dunst # Lightweight and customizable notification daemon
    mako # A lightweight Wayland notification daemon

    #__ Clipboard __#
    cliphist # Wayland clipboard manager
    gpaste # Clipboard management system with GNOME integration
    wl-clipboard # Command-line copy/paste utilities for Wayland
    clipman # A simple clipboard manager for Wayland
    fuzzel # Wayland-native application launcher, similar to rofi’s drun mode

    # Image Viewer
    imv # A command line image viewer for tiling window managers
    feh # A light-weight image viewer
    loupe # A simple image viewer application written with GTK4 and Rust

    #__ Screenshotting __#
    grim # Grab images from a Wayland compositor
    grimblast # A helper for screenshots within Hyprland, based on grimshot
    swappy # A Wayland native snapshot editing tool, inspired by Snappy on macOS
    flameshot # Powerful yet simple to use screenshot software
    scrot # A command-line screen capture utility
    wayshot # A native, blazing-fast screenshot tool for wlroots based compositors such as sway and river

    #__ Keyboard __#
    # fcitx5 # Next generation of fcitx

    #__ Desktop apps __#
    gromit-mpx # Desktop annotation tool
    screenkey # A screencast tool to display your keys inspired by Screenflick
    akira-unstable # Native Linux Design application built in Vala and GTK
    lunacy # Free design software that keeps your flow with AI tools and built-in graphics
    firefox # Web browser built from Firefox source tree
    google-chrome # Freeware web browser developed by Google
    microsoft-edge # The web browser from Microsoft
    discord # All-in-one cross-platform voice and text chat for gamers
    zoom-us # zoom.us video conferencing application
    audacity # Sound editor with graphical UI
    obs-studio # Free and open source software for video recording and live streaming
    anki # Spaced repetition flashcard program
    gparted # Graphical disk partitioning tool
    telegram-desktop # Telegram Desktop messaging app
    obsidian # A powerful knowledge base that works on top of a local folder of plain text Markdown files
    drawio # A desktop application for creating diagrams
    qbittorrent # Featureful free software BitTorrent client
    motrix # A full-featured download manager

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

    #__ System and powermanagement utilies __#
    fwupd # The Linux Vendor Firmware Service is a secure portal which allows hardware vendors to upload firmware updates.
    bpftrace # High-level tracing language for Linux eBPF

    #__ ASUS ROG Laptops __#
    # asusctl # A control daemon, CLI tools, and a collection of crates for interacting with ASUS ROG laptops
    # supergfxctl # A GPU switching utility, mostly for ASUS laptops
  ];
}
