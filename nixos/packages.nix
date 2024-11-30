{ pkgs, ... }:
{
  nixpkgs.config = {
    rocmSupport = true;
    allowUnfree = true;
  };
  environment.systemPackages = with pkgs; [
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
    # pkgconf # Package compiler and linker metadata toolkit (wrapper script)
    steam-run # Run commands in the same FHS environment that is used for Steam

    #__ Editors __#
    curl # A command line tool for transferring files with URL syntax
    gedit # Former GNOME text editor
    git # Distributed version control system
    neovim # Vim text editor fork focused on extensibility and agility
    vim # The most popular clone of the VI editor
    vscode # Open source source code editor developed by Microsoft for Windows, Linux and macOS
    wget # Tool for retrieving files using HTTP, HTTPS, and FTP
    zed-editor

    #__ Package Managers __#
    # pkg # Package management tool for FreeBSD
    dpkg # The Debian package manager
    rpm # The RPM Package Manager
    pacman # A simple library-based package manager

    #__ Terminals __#
    eza # A modern, maintained replacement for ls
    foot # A fast, lightweight and minimalistic Wayland terminal emulator
    fish # Smart and user-friendly command line shell
    fzf # Command-line fuzzy finder written in Go
    fzf-zsh # wrap fzf to use in oh-my-zsh
    kitty # A modern, hackable, featureful, OpenGL based terminal emulator
    nanorc # Improved Nano Syntax Highlighting Files
    oh-my-zsh # A framework for managing your zsh configuration
    zsh # The Z shell
    zsh-autocomplete # Real-time type-ahead completion for Zsh. Asynchronous find-as-you-type autocompletion
    zsh-autosuggestions # Fish shell autosuggestions for Zsh
    zsh-completions # Additional completion definitions for zsh
    zsh-fzf-tab # Replace zsh's default completion selection menu with fzf!
    zsh-git-prompt # Informative git prompt for zsh
    zsh-syntax-highlighting # Fish shell like syntax highlighting for Zsh

    #__ Networking __#
    ntp # An implementation of the Network Time Protocol
    openresolv # A program to manage /etc/resolv.conf
    radvd # IPv6 Router Advertisement Daemon
    tcpdump # Network sniffer
    nssmdns # The mDNS Name Service Switch (NSS) plug-in
    nmap # A free and open source utility for network discovery and security auditing
    networkmanager
    networkmanagerapplet # NetworkManager control applet for GNOME
    networkmanager-openconnect # NetworkManager’s OpenConnect plugin
    wirelesstools # Wireless tools for Linux
    inetutils # Collection of common network programs
    ipset # Administration tool for IP sets
    ipcalc # Simple IP network calculator
    bind # Domain name server
    nftables # The project that aims to replace the existing {ip,ip6,arp,eb}tables framework
    networkmanager # Network configuration and management tool
    dhcpcd # A client for the Dynamic Host Configuration Protocol (DHCP)
    dhcping # Send DHCP request to find out if a DHCP server is running
    dnsmasq # An integrated DNS, DHCP and TFTP server for small networks
    # firewalld # Firewall daemon with D-Bus interface
    firewalld-gui # Firewall daemon with D-Bus interface
    hostapd # A user space daemon for access point and authentication servers
    iproute2 # A collection of utilities for controlling TCP/IP networking and traffic control in Linux
    # iptables # A program to configure the Linux IP packet filtering ruleset
    iptables-legacy # A program to configure the Linux IP packet filtering ruleset
    iwd # Wireless daemon for Linux
    iw # Tool to use nl80211
    networkd-dispatcher # Dispatcher service for systemd-networkd connection status changes
    routedns # DNS stub resolver, proxy and router
    trust-dns # A Rust based DNS client, server, and resolver
    mtr # A network diagnostics tool
    ethtool # Utility for controlling network drivers and hardware
    nettools # A set of tools for controlling the network subsystem in Linux
    #__ Media __#
    # vaapiVdpau # VDPAU driver for the VAAPI library
    # driversi686Linux.vaapiVdpau # VDPAU driver for the VAAPI library
    # driversi686Linux.libvdpau-va-gl # VDPAU driver with OpenGL/VAAPI backend
    libvdpau-va-gl # VDPAU driver with OpenGL/VAAPI backend
    # ffmpeg # A complete, cross-platform solution to record, convert and stream audio and video
    ffmpeg-full # A complete, cross-platform solution to record, convert and stream audio and video
    ffmpegthumbnailer # A lightweight video thumbnailer
    playerctl # Command-line utility and library for controlling media players that implement MPRIS
    aalib # ASCII art graphics library
    ab-av1 # AV1 re-encoding using ffmpeg, svt-av1 & vmaf
    alsa-lib # ALSA, the Advanced Linux Sound Architecture libraries
    aribb25 # Sample implementation of the ARIB STD-B25 standard
    avahi # mDNS/DNS-SD implementation
    clapper # A GNOME media player built using GTK4 toolkit and powered by GStreamer with OpenGL rendering
    dav1d # A cross-platform AV1 decoder focused on speed and correctness
    dejavu_fonts # A typeface family based on the Bitstream Vera fonts
    flac # Library and tools for encoding and decoding the FLAC lossless audio file format
    fluidsynth # Real-time software synthesizer based on the SoundFont 2 specifications
    glide-media-player # Linux/macOS media player based on GStreamer and GTK
    gst_all_1.gst-libav # FFmpeg/libav plugin for GStreamer
    gst_all_1.gst-plugins-bad # GStreamer Bad Plugins
    gst_all_1.gst-plugins-base # Base GStreamer plug-ins and helper libraries
    gst_all_1.gst-plugins-good # GStreamer Good Plugins
    gst_all_1.gst-plugins-rs # GStreamer plugins written in Rust
    gst_all_1.gst-plugins-ugly # Gstreamer Ugly Plugins
    gst_all_1.gstreamer # Open source multimedia framework
    gst_all_1.gst-vaapi # Set of VAAPI GStreamer Plug-ins
    jack2 # JACK audio connection kit, version 2 with jackdbus
    libaom # Alliance for Open Media AV1 codec library
    libass # Portable ASS/SSA subtitle renderer
    libavc1394 # Programming interface for the 1394 Trade Association AV/C (Audio/Video Control) Digital Interface Command Set
    libbluray # Library to access Blu-Ray disks for video playback
    libcaca # A graphics library that outputs text instead of pixels
    libcdio # A library for OS-independent CD-ROM and CD image access
    libdc1394 # Capture and control API for IIDC compliant cameras
    libdvdcss # A library for decrypting DVDs
    libdvdnav # A library that implements DVD navigation features such as DVD menus
    libdvdread # A library for reading DVDs
    libgcrypt # General-purpose cryptographic library
    libjpeg # A faster (using SIMD) libjpeg implementation
    libkate # A library for encoding and decoding Kate streams
    libmicrodns # Minimal mDNS resolver library, used by VLC
    libmodplug # MOD playing library
    libmtp # An implementation of Microsoft's Media Transfer Protocol
    libnfs # NFS client library
    libogg # Media container library to manipulate Ogg files
    libopus # Open, royalty-free, highly versatile audio codec
    libpng # The official reference implementation for the PNG file format with animation patch
    # libpulseaudio # Sound server for POSIX and Win32 systems
    # libraw1394 # Library providing direct access to the IEEE 1394 bus through the Linux 1394 subsystem's raw1394 user space interface
    # librsvg # A small library to render SVG images to Cairo surfaces
    # libsamplerate # Sample Rate Converter for audio
    # libshout # icecast 'c' language bindings
    # libssh2 # A client-side C library implementing the SSH2 protocol
    # libtheora # Library for Theora, a free and open video compression format
    # libtiger # A rendering library for Kate streams using Pango and Cairo
    # libvorbis # Vorbis audio compression reference implementation
    libvpx # WebM VP8/VP9 codec SDK
    lirc # Allows to receive and send infrared signals
    # mpg123 # Fast console MPEG Audio Player and decoder library
    mpv # General-purpose media player, fork of MPlayer and mplayer2
    ncurses # Free software emulation of curses in SVR4 and more
    openh264 # A codec library which supports H.264 encoding and decoding
    pcsclite # Middleware to access a smart card using SCard API (PC/SC)
    protobuf # Google's data interchange format
    rav1e # The fastest and safest AV1 encoder
    SDL_image # SDL image library
    smpeg # MPEG decoding library
    speex # An Open Source/Free Software patent-free audio compression format designed for speech
    speexdsp # An Open Source/Free Software patent-free audio compression format designed for speech
    srt # Secure, Reliable, Transport
    svt-av1 # AV1-compliant encoder/decoder library core
    twolame # A MP2 encoder
    udevil # Mount without password
    vcdimager # Full-featured mastering suite for authoring, disassembling and analyzing Video CDs and Super Video CDs
    vlc # Cross-platform media player and streaming server
    x264 # Library for encoding H264/AVC video streams
    x265 # Library for encoding H.265/HEVC video streams
    xvidcore # MPEG-4 video codec for PC

    #__ gtk & Themes Stuff __#
    # gtk2 # A multi-platform toolkit for creating graphical user interfaces
    adw-gtk3 # The theme from libadwaita ported to GTK-3
    colloid-gtk-theme # A modern and clean Gtk theme
    gnome-themes-extra
    gtk_engines # Theme engines for GTK 2
    # gtk-layer-shell # A library to create panels and other desktop components for Wayland using the Layer Shell protocol
    gtk4-layer-shell # A library to create panels and other desktop components for Wayland using the Layer Shell protocol and GTK4
    gtk3 # A multi-platform toolkit for creating graphical user interfaces
    gtk4 # A multi-platform toolkit for creating graphical user interfaces
    gtkmm2 # C++ interface to the GTK graphical user interface library
    gtkmm3 # C++ interface to the GTK graphical user interface library
    gtkmm4 # C++ interface to the GTK graphical user interface library
    kdePackages.breeze
    kdePackages.qt6ct
    libdbusmenu-gtk3 # Library for passing menu structures across DBus
    papirus-icon-theme # Pixel perfect icon theme for Linux

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

    #__ Drivers __#
    amdvlk # AMD Open Source Driver For Vulkan
    clinfo # Print all known information about all available OpenCL platforms and devices in the system
    glaxnimate # Simple vector animation program.
    glmark2 # OpenGL (ES) 2.0 benchmark
    gpu-viewer # A front-end to glxinfo, vulkaninfo, clinfo and es2_info
    hwdata # Hardware Database, including Monitors, pci.ids, usb.ids, and video cards
    libdrm # Direct Rendering Manager library and headers
    libva # An implementation for VA-API (Video Acceleration API)
    libva-utils # A collection of utilities and examples for VA-API
    # mesa # An open source 3D graphics library
    mesa-demos # Collection of demos and test programs for OpenGL and Mesa
    driversi686Linux.mesa # An open source 3D graphics library
    ocl-icd # OpenCL ICD Loader for opencl-headers-2023.12.14
    opencl-clang # A clang wrapper library with an OpenCL-oriented API and the ability to compile OpenCL C kernels to SPIR-V modules
    opencl-clhpp # OpenCL Host API C++ bindings
    opencl-headers # Khronos OpenCL headers version 2023.12.14

    #__ CLI Tools __#
    lsof # A tool to list open files
    lux # Fast and simple video download library and CLI tool written in Go
    yt-dlp # Command-line tool to download videos from YouTube.com and other sites (youtube-dl fork)
    # Hacking & security Tools
    hashcat # Fast password cracker
    hashcat-utils # Small utilities that are useful in advanced password cracking
    hcxtools # Tools for capturing wlan traffic and conversion to hashcat and John the Ripper formats

    #__ Gnome Stuff __#
    gnome-settings-daemon
    gnome-shell # Core user interface for the GNOME 3 desktop
    gdm # A program that manages graphical display servers and handles graphical user logins
    gjs # JavaScript bindings for GNOME
    gnome-bluetooth # Application that lets you manage Bluetooth in the GNOME desktop
    gnome-chess # Play the classic two-player boardgame of chess
    gnome-control-center # Utilities to configure the GNOME desktop
    # gnome-extension-manager # Desktop app for managing GNOME shell extensions
    gnome-firmware # Tool for installing firmware on devices
    gnome-keyring # Collection of components in GNOME that store secrets, passwords, keys, certificates and make them available to applications
    gnome-pomodoro # Time management utility for GNOME based on the pomodoro technique
    gnome-tweaks # A tool to customize advanced GNOME 3 options
    libgnome-keyring # Framework for managing passwords and other secrets
    pomodoro # Time management utility for GNOME based on the pomodoro technique

    #__ polkit-gnome __#
    polkit # A toolkit for defining and handling the policy that allows unprivileged processes to speak to privileged processes
    polkit_gnome # A dbus session bus service that is used to bring up authentication dialogs
    libsForQt5.polkit-qt # A Qt wrapper around PolKit

    #__ Gnome Nautilus __#
    nautilus # The file manager for GNOME
    # nautilus-python # Python bindings for the Nautilus Extension API
    # insync-nautilus # This package contains the Python extension and icons for integrating Insync with Nautilus
    # turtle # A graphical interface for version control intended to run on gnome and nautilus

    #__ Wayland Stuff __#
    anyrun # A wayland-native, highly customizable runner
    seatd # A minimal seat management daemon, and a universal seat management library
    slurp # Select a region in a Wayland compositor
    swww # Efficient animated wallpaper daemon for wayland, controlled at runtime
    wlroots # A modular Wayland compositor library
    wlr-protocols # Wayland roots protocol extensions
    wl-gammactl # Contrast, brightness, and gamma adjustments for Wayland
    wl-gammarelay-rs # A simple program that provides DBus interface to control display temperature and brightness under wayland without flickering
    wlogout # Wayland based logout menu
    # xwayland # An X server for interfacing X11 apps with the Wayland protocol
    uwsm # Universal wayland session manager

    #__ Hyprland __#
    # hyprgui # unstable GUI for configuring Hyprland written in Rust
    ags # A EWW-inspired widget system as a GJS library
    brightnessctl # This program allows you read and control device brightness
    fd # A simple, fast and user-friendly alternative to find
    gpu-screen-recorder # A screen recorder that has minimal impact on system performance by recording a window using the GPU only
    gpu-screen-recorder-gtk # GTK frontend for gpu-screen-recorder.
    hyprcursor # The hyprland cursor format, library and utilities
    hypridle # Hyprland's idle daemon
    hyprland # A dynamic tiling Wayland compositor that doesn't sacrifice on its looks
    hyprland-protocols # Wayland protocol extensions for Hyprland
    hyprlandPlugins.hyprbars # Hyprland window title plugin
    hyprlandPlugins.hyprexpo # Hyprland workspaces overview plugin
    hyprlang # The official implementation library for the hypr config language
    hyprlock # Hyprland's GPU-accelerated screen locking utility
    hyprpaper # A blazing fast wayland wallpaper utility
    hyprnotify # DBus Implementation of Freedesktop Notification spec for 'hyprctl notify'
    hyprlauncher # GUI for launching applications, written in Rust
    hyprpicker # A wlroots-compatible Wayland color picker that does not suck
    hyprshot # Hyprshot is an utility to easily take screenshots in Hyprland using your mouse.
    hyprutils # Small C++ library for utilities used across the Hypr* ecosystem
    hyprwayland-scanner # A Hyprland version of wayland-scanner in and for C++
    loupe # A simple image viewer application written with GTK4 and Rust
    matugen # A material you color generation tool
    wf-recorder # Utility program for screen recording of wlroots-based compositors

    #__ ASUS ROG Laptops __#
    # asusctl # A control daemon, CLI tools, and a collection of crates for interacting with ASUS ROG laptops
    # supergfxctl # A GPU switching utility, mostly for ASUS laptops

    #__ Android __#
    waydroid # Waydroid is a container-based approach to boot a full Android system on a regular GNU/Linux system like Ubuntu
    scrcpy # Display and control Android devices over USB or TCP/IP

    #__ Windows __#
    wine # An Open Source implementation of the Windows API on top of X, OpenGL, and Unix
    # wine64 # An Open Source implementation of the Windows API on top of X, OpenGL, and Unix
    winetricks # A script to install DLLs needed to work around problems in Wine
    dxvk # A Vulkan-based translation layer for Direct3D 9/10/11

    #__ Developer Tools __#
    # webkitgtk #---- Web content rendering engine, GTK port
    #webkitgtk_4_0 # Web content rendering engine, GTK port
    #webkitgtk_4_1 # Web content rendering engine, GTK port
    webkitgtk_6_0 # Web content rendering engine, GTK port
    at-spi2-atk # Assistive Technology Service Provider Interface protocol definitions and daemon for D-Bus
    atkmm # C++ wrappers for ATK accessibility toolkit
    beekeeper-studio # Modern and easy to use SQL client for MySQL, Postgres, SQLite, SQL Server, and more. Linux, MacOS, and Windows
    # bintools # Tools for manipulating binaries (linker, assembler, etc.) (wrapper script)
    bruno # Open-source IDE For exploring and testing APIs.
    bun # Incredibly fast JavaScript runtime, bundler, transpiler and package manager – all in one
    cairo # A 2D graphics library with support for multiple output devices
    cairomm # C++ bindings for the Cairo vector graphics library
    clang # A C language family frontend for LLVM (wrapper script)
    dbeaver-bin # Universal SQL Client for developers, DBA and analysts. Supports MySQL, PostgreSQL, MariaDB, SQLite, and more
    direnv # A shell extension that manages your environment
    gdk-pixbuf # A library for image loading and manipulation
    glib # C library of programming buildings blocks
    gobject-introspection-unwrapped
    gobject-introspection # A middleware layer between C libraries and language bindings
    harfbuzz # An OpenType text shaping engine
    llvmPackages_12.bintools # System binary utilities (wrapper script)
    ninja # Small build system with a focus on speed
    pango # A library for laying out and rendering of text, with an emphasis on internationalization
    pkg-config # A tool that allows packages to find out information about other packages (wrapper script)
    sqlite # A self-contained, serverless, zero-configuration, transactional SQL database engine
    sqlitebrowser # DB Browser for SQLite
    zlib # Lossless data-compression library
    # libsoup # HTTP client/server library for GNOME
    libsoup_3 # HTTP client/server library for GNOME
    # Developers Applications

    #__ Sass (Css) __#
    # sass # Tools and Ruby libraries for the CSS3 extension languages: Sass and SCSS
    dart-sass # The reference implementation of Sass, written in Dart
    libsass # A C/C++ implementation of a Sass compiler
    rsass # Sass reimplemented in rust with nom
    grass-sass # A Sass compiler written purely in Rust

    #__ Rust __#
    rust-analyzer # A modular compiler frontend for the Rust language
    rust-analyzer-unwrapped # Modular compiler frontend for the Rust language
    cargo # Downloads your Rust project's dependencies and builds your project
    cargo-tauri # Build smaller, faster, and more secure desktop applications with a web frontend
    rustc # A safe, concurrent, practical language (wrapper script)
    rustup # The Rust toolchain installer
    sassc # A front-end for libsass
    #rustfmt # Tool for formatting Rust code according to style guidelines

    #__ Python __#
    # python3 # A high-level dynamically-typed programming language
    # python313 # Python Version 3.13
    python312 # Python Version 3.12
    pyenv # Simple Python version management
    meson # An open source, fast and friendly build system made in Python
    python312Packages.build
    python312Packages.cairosvg
    python312Packages.certifi
    python312Packages.charset-normalizer
    python312Packages.click
    python312Packages.idna
    python312Packages.loguru
    python312Packages.markupsafe
    python312Packages.pillow
    python312Packages.psutil
    python312Packages.pycairo
    python312Packages.pygobject3
    python312Packages.pywal
    python312Packages.pywayland
    python312Packages.requests
    python312Packages.setuptools-scm
    python312Packages.urllib3
    python312Packages.wheel
    # python312Packages.ninja

    #__ Ruby __#
    ruby_3_3 # An object-oriented language for quick and easy programming
    rubyPackages.execjs
    #__ 3D Tools & Applications __#
    #blender-hip # 3D Creation/Animation/Publishing System

    #__ Games __#
    # zeroad

    #__ System Tools __#
    # ant # A Java-based build tool
    # xdg-dbus-proxy # DBus proxy for Flatpak and others
    busybox # Tiny versions of common UNIX utilities in a single small executable
    flatpak # Linux application sandboxing and distribution framework
    mangohud # A Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more
    openssl # A cryptographic library that implements the SSL and TLS protocols
    resources # Monitor your system resources and processes

    #__ Nodejs & JavaScript Stuff __#
    nodejs_22 # Event-driven I/O framework for the V8 JavaScript engine
    # nodePackages.npm # a package manager for JavaScript
    nodePackages.pnpm # Fast, disk space efficient package manager
    typescript # Superset of JavaScript that compiles to clean JavaScript output

    #__ CLI utils __#
    gum # Tasty Bubble Gum for your shell
    bluez # Official Linux Bluetooth protocol stack
    bluez-tools # A set of tools to manage bluetooth devices for linux
    # cava # Console-based Audio Visualizer for Alsa
    fastfetch # Like neofetch, but much faster because written in C
    file # A program that shows the type of files
    htop # An interactive process viewer
    lazygit # Simple terminal UI for git commands
    mediainfo # Supplies technical and tag information about a video or audio file
    nix-index # A files database for nixpkgs
    ranger # File manager with minimalistic curses interface
    tree # Command to produce a depth indented directory listing
    unzip # An extraction utility for archives compressed in .zip format
    zip # Compressor/archiver for creating and modifying zipfiles
    zram-generator # Systemd unit generator for zram devices

    #__ GUI utils __#
    dmenu # A generic, highly customizable, and efficient menu for the X Window System
    feh # A light-weight image viewer
    gromit-mpx # Desktop annotation tool
    imv # A command line image viewer for tiling window managers
    screenkey # A screencast tool to display your keys inspired by Screenflick

    #__ Notifications __#
    notify # Notify allows sending the output from any tool to Slack, Discord and Telegram
    libnotify # A library that sends desktop notifications to a notification daemon
    dunst # Lightweight and customizable notification daemon
    mako # A lightweight Wayland notification daemon

    #__ Xorg stuff __#
    xterm
    xclip # Tool to access the X clipboard from a console application
    xorg.xbacklight
    xorg.xprop
    xsel

    #__ Sound __#
    wireplumber # Modular session / policy manager for PipeWire
    pamixer # Pulseaudio command line mixer
    pipewire # Server and user space API to deal with multimedia pipelines
    # pulseaudio # Sound server for POSIX and Win32 systems
    pulseaudioFull # Sound server for POSIX and Win32 systems
    pavucontrol # PulseAudio Volume Control

    #__ Clipboard __#
    cliphist # Wayland clipboard manager
    gpaste # Clipboard management system with GNOME integration
    wl-clipboard # Command-line copy/paste utilities for Wayland
    clipman # A simple clipboard manager for Wayland
    fuzzel # Wayland-native application launcher, similar to rofi’s drun mode

    #__ Screenshotting __#
    grim # Grab images from a Wayland compositor
    grimblast # A helper for screenshots within Hyprland, based on grimshot
    swappy # A Wayland native snapshot editing tool, inspired by Snappy on macOS
    flameshot # Powerful yet simple to use screenshot software
    scrot # A command-line screen capture utility
    wayshot # A native, blazing-fast screenshot tool for wlroots based compositors such as sway and river

    #__ Keyboard __#
    fcitx5 # Next generation of fcitx

    #__ plymouth __#
    plymouth # Boot splash and boot logger
    nixos-bgrt-plymouth # BGRT theme with a spinning NixOS logo

    #__ Desktop apps __#
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
    xdg-desktop-portal # Desktop integration portals for sandboxed apps
    xdg-desktop-portal-wlr # xdg-desktop-portal backend for wlroots
    xdg-desktop-portal-gnome # Backend implementation for xdg-desktop-portal for the GNOME desktop environment
    xdg-desktop-portal-gtk # Desktop integration portals for sandboxed apps
    xdg-desktop-portal-hyprland # xdg-desktop-portal backend for Hyprland
    xdg-user-dirs # Tool to help manage well known user directories like the desktop folder and the music folder
    xdg-utils # A set of command line tools that assist applications with a variety of desktop integration tasks

    #__ GNU Stuff __#
    gnuchess # GNU Chess engine
    gdb # The GNU Project debugger
    bash # GNU Bourne-Again Shell, the de facto standard shell on Linux
    bc # GNU software calculator
    coreutils # The GNU Core Utilities
    gcc # GNU Compiler Collection, version 13.2.0 (wrapper script)
    glibc # The GNU C Library
    gnumake # A tool to control the generation of non-source files from sources
    libGL # Stub bindings using libglvnd
    libGLU # OpenGL utility library
    cups # A standards-based printing system for UNIX

    # __ Nixos Stuff __#
    fmt # Small, safe and fast formatting library
    nixfmt-rfc-style # Official formatter for Nix code
    # nixfmt-classic # An opinionated formatter for Nix
    nixpkgs-fmt # Nix code formatter for nixpkgs
    home-manager # A Nix-based user environment configurator

    #__ Other __
    # tlp # Advanced Power Management for Linux
    upower # D-Bus service for power management
    libsForQt5.qt5ct # Qt5 Configuration Tool
    # libsForQt5.qtstyleplugin-kvantum # SVG-based Qt5 theme engine plus a config tool and extra themes
    #boost # Collection of C++ libraries
    #booster # Fast and secure initramfs generator
    bpftune # BPF-based auto-tuning of Linux system parameters
    axel # Console downloading program with some features for parallel connections for faster downloading
    blueberry # Bluetooth configuration tool
    cairomm # C++ bindings for the Cairo vector graphics library
    cmake # Cross-platform, open-source build system generator
    ddcutil # Query and change Linux monitor settings using DDC/CI and USB
    fontconfig # A library for font customization and configuration
    # gammastep # Screen color temperature manager
    gojq # Pure Go implementation of jq
    ripgrep # Utility that combines the usability of The Silver Searcher with the raw speed of grep
    rsync # Fast incremental file transfer utility
    starship # Minimal, blazing fast, and extremely customizable prompt for any shell
    tesseract # OCR engine
    tinyxml2 # Simple, small, efficient, C++ XML parser
    webp-pixbuf-loader # WebP GDK Pixbuf Loader library
    yad # GUI dialog tool for shell scripts
    ydotool # Generic Linux command-line automation tool
    clblast # Tuned OpenCL BLAS library
    libbsd
    nettle
    libgcrypt
    libselinux
    audit
    xorg.xorgsgmldoctools
    xmlto
    fop

    #__ System and powermanagement utilies __#
    fwupd # The Linux Vendor Firmware Service is a secure portal which allows hardware vendors to upload firmware updates.
    bpftrace # High-level tracing language for Linux eBPF
    amd-ucodegen # Tool to generate AMD microcode files
    microcode-amd # AMD Processor microcode patch
  ];
}
