{ pkgs, ... }: {
	nixpkgs.config = {
		rocmSupport = true;
		allowUnfree = true;
	#	permittedInsecurePackages = ["python-2.7.18.8" "electron-25.9.0"];
	};
	environment.systemPackages = with pkgs; [
		coreutils # The GNU Core Utilities
		sudo # A command to run commands as root

	# Editors
		curl # A command line tool for transferring files with URL syntax
		gedit # Former GNOME text editor
		git # Distributed version control system
		vim # The most popular clone of the VI editor
		#vscode # Open source source code editor developed by Microsoft for Windows, Linux and macOS
		zed-editor # High-performance, multiplayer code editor from the creators of Atom and Tree-sitter
		wget # Tool for retrieving files using HTTP, HTTPS, and FTP

	# Terminals
		bash # GNU Bourne-Again Shell, the de facto standard shell on Linux
		eza # A modern, maintained replacement for ls
		foot # A fast, lightweight and minimalistic Wayland terminal emulator
		fzf # Command-line fuzzy finder written in Go
		fzf-zsh # wrap fzf to use in oh-my-zsh
		kitty # A modern, hackable, featureful, OpenGL based terminal emulator
		oh-my-zsh # A framework for managing your zsh configuration 
		zsh # The Z shell
		zsh-autocomplete # Real-time type-ahead completion for Zsh. Asynchronous find-as-you-type autocompletion
		zsh-autosuggestions # Fish shell autosuggestions for Zsh
		zsh-completions # Additional completion definitions for zsh
		zsh-fzf-tab # Replace zsh's default completion selection menu with fzf!
		zsh-git-prompt # Informative git prompt for zsh
		zsh-syntax-highlighting # Fish shell like syntax highlighting for Zsh

	# Browsers
		firefox
		google-chrome # Freeware web browser developed by Google
	#	microsoft-edge # The web browser from Microsoft
		
	# Networking
		bind # Domain name server
		networkmanager # Network configuration and management tool
		dhcpcd # A client for the Dynamic Host Configuration Protocol (DHCP)
		dhcping # Send DHCP request to find out if a DHCP server is running
		dnsmasq # An integrated DNS, DHCP and TFTP server for small networks
		firewalld # Firewall daemon with D-Bus interface
		firewalld-gui # Firewall daemon with D-Bus interface
		hostapd # A user space daemon for access point and authentication servers
		iproute2 # A collection of utilities for controlling TCP/IP networking and traffic control in Linux
		iptables # A program to configure the Linux IP packet filtering ruleset
		iwd # Wireless daemon for Linux
		networkd-dispatcher # Dispatcher service for systemd-networkd connection status changes
		routedns # DNS stub resolver, proxy and router
		trust-dns # A Rust based DNS client, server, and resolver
		mtr # A network diagnostics tool
		ethtool # Utility for controlling network drivers and hardware

	# Notes
		obsidian # A powerful knowledge base that works on top of a local folder of plain text Markdown files
		
	# Media
		ffmpegthumbnailer # A lightweight video thumbnailer
		aalib # ASCII art graphics library
		ab-av1 # AV1 re-encoding using ffmpeg, svt-av1 & vmaf
		alsa-lib # ALSA, the Advanced Linux Sound Architecture libraries
		aribb25 # Sample implementation of the ARIB STD-B25 standard
		avahi # mDNS/DNS-SD implementation
		clapper # A GNOME media player built using GTK4 toolkit and powered by GStreamer with OpenGL rendering
		dav1d # A cross-platform AV1 decoder focused on speed and correctness
		dejavu_fonts # A typeface family based on the Bitstream Vera fonts
		ffmpeg # A complete, cross-platform solution to record, convert and stream audio and video
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
		libpulseaudio # Sound server for POSIX and Win32 systems
		libraw1394 # Library providing direct access to the IEEE 1394 bus through the Linux 1394 subsystem's raw1394 user space interface
		librsvg # A small library to render SVG images to Cairo surfaces
		libsamplerate # Sample Rate Converter for audio
		libshout # icecast 'c' language bindings
		libssh2 # A client-side C library implementing the SSH2 protocol
		libtheora # Library for Theora, a free and open video compression format
		libtiger # A rendering library for Kate streams using Pango and Cairo
		libva # An implementation for VA-API (Video Acceleration API)
		libvorbis # Vorbis audio compression reference implementation
		libvpx # WebM VP8/VP9 codec SDK
		lirc # Allows to receive and send infrared signals
		mpg123 # Fast console MPEG Audio Player and decoder library
		mpv # General-purpose media player, fork of MPlayer and mplayer2
		ncurses # Free software emulation of curses in SVR4 and more
		openh264 # A codec library which supports H.264 encoding and decoding
		pcsclite # Middleware to access a smart card using SCard API (PC/SC)
		projectm # Cross-platform Milkdrop-compatible music visualizer
		protobuf # Google's data interchange format
		qmplay2 # Qt-based Multimedia player
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

	# gtk & Themes Stuff
		gtk2 # A multi-platform toolkit for creating graphical user interfaces
		gtk3 # A multi-platform toolkit for creating graphical user interfaces
		gtk4 # A multi-platform toolkit for creating graphical user interfaces
		adw-gtk3 # The theme from libadwaita ported to GTK-3

	# Nix Stuff
		fmt # Small, safe and fast formatting library
		nixpkgs-fmt # Nix code formatter for nixpkgs
		# dpkg # The Debian package manager
		# rpm # The RPM Package Manager
		# pacman # A simple library-based package manager
		
	# Icons & Themes
		papirus-icon-theme # Pixel perfect icon theme for Linux
		
	# Social
		# discord # All-in-one cross-platform voice and text chat for gamers
		telegram-desktop
		
	# Disks & Partitions
		btrfs-progs # Utilities for the btrfs filesystem
		e2fsprogs # Tools for creating and checking ext2/ext3/ext4 filesystems
		efibootmgr # A Linux user-space application to modify the Intel Extensible Firmware Interface (EFI) Boot Manager
		efitools # Tools for manipulating UEFI secure boot platforms
		exfatprogs # exFAT filesystem userspace utilities
		f2fs-tools # Userland tools for the f2fs filesystem
		fuse3 # Library that allows filesystems to be implemented in user space
		ntfs3g # FUSE-based NTFS driver with full write support
		duf # Disk Usage/Free Utility

	# CLI Tools
		lsof # A tool to list open files
		lux # Fast and simple video download library and CLI tool written in Go
		yt-dlp # Command-line tool to download videos from YouTube.com and other sites (youtube-dl fork)
	# Hacking & security Tools
		hashcat # Fast password cracker
		hashcat-utils # Small utilities that are useful in advanced password cracking
		hcxtools # Tools for capturing wlan traffic and conversion to hashcat and John the Ripper formats
		
	# Gnome Stuff
		# gnome-extension-manager # Desktop app for managing GNOME shell extensions
		gnome-photos # Access, organize and share your photos
		# gnome-recipes # Recipe management application for GNOME
		# gnome-usage # A nice way to view information about use of system resources, like memory and disk space
		gnome.eog # GNOME image viewer
		gnome.gdm # A program that manages graphical display servers and handles graphical user logins
		gnome.gnome-chess # Play the classic two-player boardgame of chess
		# gnome.gnome-tweaks # A tool to customize advanced GNOME 3 options
		gnome.pomodoro # Time management utility for GNOME based on the pomodoro technique
		# gnome.totem # Movie player for the GNOME desktop based on GStreamer
		
	# Hyprland
		ags # A EWW-inspired widget system as a GJS library
		brightnessctl # This program allows you read and control device brightness
		fd # A simple, fast and user-friendly alternative to find
		hypridle # Hyprland's idle daemon
		hyprlang # The official implementation library for the hypr config language
		hyprcursor # The hyprland cursor format, library and utilities
		hyprland # A dynamic tiling Wayland compositor that doesn't sacrifice on its looks
		hyprland-protocols # Wayland protocol extensions for Hyprland
		hyprlandPlugins.hyprbars # Plugins can be installed via a plugin entry in the Hyprland NixOS or Home Manager options.
		hyprlandPlugins.hyprexpo # Hyprland workspaces overview plugin
		hyprlock # Hyprland's GPU-accelerated screen locking utility
		hyprpicker # A wlroots-compatible Wayland color picker that does not suck
		hyprpaper # A blazing fast wayland wallpaper utility
		hyprshot # Hyprshot is an utility to easily take screenshots in Hyprland using your mouse.
		hyprutils # Small C++ library for utilities used across the Hypr* ecosystem
		hyprwayland-scanner # A Hyprland version of wayland-scanner in and for C++
		hyprlandPlugins.hyprbars # Hyprland window title plugin
		hyprlandPlugins.hyprexpo # Hyprland workspaces overview plugin
		matugen # A material you color generation tool
		slurp # Select a region in a Wayland compositor
		swww # Efficient animated wallpaper daemon for wayland, controlled at runtime
		wf-recorder # Utility program for screen recording of wlroots-based compositors
		gpu-screen-recorder # A screen recorder that has minimal impact on system performance by recording a window using the GPU only
		gpu-screen-recorder-gtk # GTK frontend for gpu-screen-recorder.
		wl-gammarelay-rs # A simple program that provides DBus interface to control display temperature and brightness under wayland without flickering
		xdg-desktop-portal-hyprland # xdg-desktop-portal backend for Hyprland
		matugen # A material you color generation tool

	#  ASUS ROG Laptops
		# asusctl # A control daemon, CLI tools, and a collection of crates for interacting with ASUS ROG laptops
		# supergfxctl # A GPU switching utility, mostly for ASUS laptops
		
	# Android
		# waydroid # Waydroid is a container-based approach to boot a full Android system on a regular GNU/Linux system like Ubuntu
		scrcpy # Display and control Android devices over USB or TCP/IP

	# Windows
		wine # An Open Source implementation of the Windows API on top of X, OpenGL, and Unix
		wine64 # An Open Source implementation of the Windows API on top of X, OpenGL, and Unix
		winetricks # A script to install DLLs needed to work around problems in Wine
		dxvk # A Vulkan-based translation layer for Direct3D 9/10/11
		
	# Downloaders
		qbittorrent # Featureful free software BitTorrent client
		
	# Developer Tools
		sqlite # A self-contained, serverless, zero-configuration, transactional SQL database engine
		rustup # The Rust toolchain installer
		cargo-tauri # Build smaller, faster, and more secure desktop applications with a web frontend
		nodejs_22 # Event-driven I/O framework for the V8 JavaScript engine
		bun # Incredibly fast JavaScript runtime, bundler, transpiler and package manager – all in one
		sassc # A front-end for libsass
		sass # Tools and Ruby libraries for the CSS3 extension languages: Sass and SCSS
		dart-sass # The reference implementation of Sass, written in Dart
		libsass # A C/C++ implementation of a Sass compiler
		# grass-sass # A Sass compiler written purely in Rust
		# rsass # Sass reimplemented in rust with nom
		bruno # Open-source IDE For exploring and testing APIs.
		beekeeper-studio # Modern and easy to use SQL client for MySQL, Postgres, SQLite, SQL Server, and more. Linux, MacOS, and Windows
		dbeaver-bin # Universal SQL Client for developers, DBA and analysts. Supports MySQL, PostgreSQL, MariaDB, SQLite, and more
		sqlitebrowser # DB Browser for SQLite
		ruby_3_3 # An object-oriented language for quick and easy programming
		# rubyPackages.execjs
	# Drivers
		amdvlk # AMD Open Source Driver For Vulkan
		clinfo # Print all known information about all available OpenCL platforms and devices in the system
		glaxnimate # Simple vector animation program.
		hwdata # Hardware Database, including Monitors, pci.ids, usb.ids, and video cards
		libdrm # Direct Rendering Manager library and headers
		libva # An implementation for VA-API (Video Acceleration API)
		mesa # An open source 3D graphics library
		ocl-icd # OpenCL ICD Loader for opencl-headers-2023.12.14
		opencl-clang # A clang wrapper library with an OpenCL-oriented API and the ability to compile OpenCL C kernels to SPIR-V modules
		opencl-clhpp # OpenCL Host API C++ bindings
		opencl-headers # Khronos OpenCL headers version 2023.12.14
		opencl-info # A tool to dump OpenCL platform/device information
		#gpu-viewer # A front-end to glxinfo, vulkaninfo, clinfo and es2_info

	# 3D Tools & Applications
		# blender-hip # 3D Creation/Animation/Publishing System

	# Games
		# zeroadPackages.zeroad-unwrapped
		# zeroadPackages.zeroad-data

	# System Tools
		busybox # Tiny versions of common UNIX utilities in a single small executable
		flatpak # Linux application sandboxing and distribution framework
		# mangohud # A Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more
		openssl # A cryptographic library that implements the SSL and TLS protocols
		resources # Monitor your system resources and processes
		xdg-utils # A set of command line tools that assist applications with a variety of desktop integration tasks
	
	# Desktop apps
		anki # Spaced repetition flashcard program
		# audacity # Sound editor with graphical UI
		# chromium
		gparted # Graphical disk partitioning tool
		# obs-studio # Free and open source software for video recording and live streaming
		# zoom-us # zoom.us video conferencing application

	# Coding stuff
		gnumake # A tool to control the generation of non-source files from sources
		# ant # A Java-based build tool
		gcc # GNU Compiler Collection, version 13.2.0 (wrapper script)
		python3 # A high-level dynamically-typed programming language
		#(python3.withPackages (ps: with ps; [ requests ]))

	# CLI utils
		gum # Tasty Bubble Gum for your shell
		bluez # Official Linux Bluetooth protocol stack
		bluez-tools # A set of tools to manage bluetooth devices for linux
		cava # Console-based Audio Visualizer for Alsa
		fastfetch # Like neofetch, but much faster because written in C
		file # A program that shows the type of files
		htop # An interactive process viewer
		lazygit # Simple terminal UI for git commands
		# light # GNU/Linux application to control backlights
		mediainfo # Supplies technical and tag information about a video or audio file
		nix-index # A files database for nixpkgs
		ranger # File manager with minimalistic curses interface
		tree # Command to produce a depth indented directory listing
		unzip # An extraction utility for archives compressed in .zip format
		zip # Compressor/archiver for creating and modifying zipfiles
		zram-generator # Systemd unit generator for zram devices

	# GUI utils
		dmenu # A generic, highly customizable, and efficient menu for the X Window System
		feh # A light-weight image viewer
		gromit-mpx # Desktop annotation tool
		imv # A command line image viewer for tiling window managers
		screenkey # A screencast tool to display your keys inspired by Screenflick

	# Notifications
		libnotify # A library that sends desktop notifications to a notification daemon
		dunst # Lightweight and customizable notification daemon
		mako # A lightweight Wayland notification daemon

	# Xorg stuff
		xterm
		xclip # Tool to access the X clipboard from a console application
		# xorg.xbacklight

	# Wayland stuff
		seatd # A minimal seat management daemon, and a universal seat management library
		xwayland # An X server for interfacing X11 apps with the Wayland protocol

	# Sound
		pamixer # Pulseaudio command line mixer
		pipewire # Server and user space API to deal with multimedia pipelines
		pulseaudio # Sound server for POSIX and Win32 systems
		pavucontrol # PulseAudio Volume Control
	# Clipboard
		cliphist # Wayland clipboard manager
		gnome.gpaste # Clipboard management system with GNOME integration
		wl-clipboard # Command-line copy/paste utilities for Wayland
		fuzzel # Wayland-native application launcher, similar to rofi’s drun mode

	# Screenshotting
		grim # Grab images from a Wayland compositor
		grimblast # A helper for screenshots within Hyprland, based on grimshot
		swappy # A Wayland native snapshot editing tool, inspired by Snappy on macOS
		flameshot # Powerful yet simple to use screenshot software
		scrot # A command-line screen capture utility
		wayshot # A native, blazing-fast screenshot tool for wlroots based compositors such as sway and river

	# Other
		bees # Bees is a deduplication tool designed specifically for filesystems that use the Btrfs (B-tree file system).
		home-manager # A Nix-based user environment configurator
		libsForQt5.qt5ct # Qt5 Configuration Tool
		libsForQt5.qtstyleplugin-kvantum # SVG-based Qt5 theme engine plus a config tool and extra themes
		# spice-vdagent # Enhanced SPICE integration for linux QEMU guest
		boost # Collection of C++ libraries
		booster # Fast and secure initramfs generator
		bpftune # BPF-based auto-tuning of Linux system parameters
		dos2unix # Convert text files with DOS or Mac line breaks to Unix line breaks and vice versa
		dosfstools # Utilities for creating and checking FAT and VFAT file systems
		gvfs # Virtual Filesystem support library
		mtpfs # FUSE Filesystem providing access to MTP devices
		anyrun # A wayland-native, highly customizable runner
		axel # Console downloading program with some features for parallel connections for faster downloading
		bc # GNU software calculator
		blueberry # Bluetooth configuration tool
		cairomm # C++ bindings for the Cairo vector graphics library
		cmake # Cross-platform, open-source build system generator
		ddcutil # Query and change Linux monitor settings using DDC/CI and USB
		fish # Smart and user-friendly command line shell
		fontconfig # A library for font customization and configuration
		gammastep # Screen color temperature manager
		gjs # JavaScript bindings for GNOME
		gnome.gnome-bluetooth
		gnome.gnome-control-center
		gnome.gnome-keyring # Collection of components in GNOME that store secrets, passwords, keys, certificates and make them available to applications
		gobject-introspection # A middleware layer between C libraries and language bindings
		gojq # Pure Go implementation of jq
		gtk-layer-shell # A library to create panels and other desktop components for Wayland using the Layer Shell protocol
		gtkmm3 # C++ interface to the GTK graphical user interface library
		haskellPackages.gtksourceview3 # Binding to the GtkSourceView library
		gtksourceviewmm # C++ wrapper for gtksourceview
		libdbusmenu-gtk3 # Library for passing menu structures across DBus
		meson # An open source, fast and friendly build system made in Python
		nodePackages.npm # a package manager for JavaScript
		nodePackages.pnpm # Fast, disk space efficient package manager
		playerctl # Command-line utility and library for controlling media players that implement MPRIS
		polkit-gnome # A dbus session bus service that is used to bring up authentication dialogs
		python312Packages.build
		python312Packages.pillow
		python312Packages.psutil
		python312Packages.pywal
		python312Packages.pywayland
		python312Packages.setuptools-scm
		python312Packages.wheel
		ripgrep # Utility that combines the usability of The Silver Searcher with the raw speed of grep
		rsync # Fast incremental file transfer utility
		starship # Minimal, blazing fast, and extremely customizable prompt for any shell
		tesseract # OCR engine
		tinyxml2 # Simple, small, efficient, C++ XML parser
		typescript # Superset of JavaScript that compiles to clean JavaScript output
		upower # D-Bus service for power management
		webp-pixbuf-loader # WebP GDK Pixbuf Loader library
		wireplumber #  Modular session / policy manager for PipeWire
		wlogout # Wayland based logout menu
		xdg-user-dirs # Tool to help manage well known user directories like the desktop folder and the music folder
		xdg-user-dirs-gtk # Companion to xdg-user-dirs that integrates it into the GNOME desktop and GTK applications
		yad # GUI dialog tool for shell scripts
		ydotool # Generic Linux command-line automation tool
	];
}
