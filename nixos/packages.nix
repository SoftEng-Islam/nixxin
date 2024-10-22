{ pkgs, ... }: {
	nixpkgs.config = {
		# rocmSupport = true;
		allowUnfree = true;
		permittedInsecurePackages = ["python-2.7.18.8" "electron-25.9.0"];
	};
	environment.systemPackages = with pkgs; [
		sudo # A command to run commands as root
		coreutils # The GNU Core Utilities
		# ----------- Editors ----------- #
		git
		curl # A command line tool for transferring files with URL syntax
		vim # The most popular clone of the VI editor
		wget # Tool for retrieving files using HTTP, HTTPS, and FTP
		gedit # Former GNOME text editor
		vscode # Open source source code editor developed by Microsoft for Windows, Linux and macOS
		# ----------- Terminals ----------- #
		bash # GNU Bourne-Again Shell, the de facto standard shell on Linux
		kitty # A modern, hackable, featureful, OpenGL based terminal emulator
		foot # A fast, lightweight and minimalistic Wayland terminal emulator
		zsh # The Z shell
		zsh-git-prompt # Informative git prompt for zsh
		fzf # Command-line fuzzy finder written in Go
		fzf-zsh # wrap fzf to use in oh-my-zsh
		zsh-fzf-tab # Replace zsh's default completion selection menu with fzf!
		zsh-completions # Additional completion definitions for zsh
		zsh-autocomplete # Real-time type-ahead completion for Zsh. Asynchronous find-as-you-type autocompletion
		zsh-autosuggestions # Fish shell autosuggestions for Zsh
		zsh-syntax-highlighting # Fish shell like syntax highlighting for Zsh
		oh-my-zsh # A framework for managing your zsh configuration 
		eza # A modern, maintained replacement for ls
		# ----------- Browsers ----------- #
		google-chrome # Freeware web browser developed by Google
		firefox
		#microsoft-edge # The web browser from Microsoft
		# ----------- Networking ----------- #
		dnsmasq # An integrated DNS, DHCP and TFTP server for small networks
		dhcpcd # A client for the Dynamic Host Configuration Protocol (DHCP)
		dhcping # Send DHCP request to find out if a DHCP server is running
		# firewalld # Firewall daemon with D-Bus interface
		# firewalld-gui # Firewall daemon with D-Bus interface
		iproute2 # A collection of utilities for controlling TCP/IP networking and traffic control in Linux
		iptables # A program to configure the Linux IP packet filtering ruleset
		iptables-legacy # A program to configure the Linux IP packet filtering ruleset
		networkd-dispatcher # Dispatcher service for systemd-networkd connection status changes
		trust-dns # A Rust based DNS client, server, and resolver
		routedns # DNS stub resolver, proxy and router
		hostapd # A user space daemon for access point and authentication servers
		# iwd # Wireless daemon for Linux
		# ----------- Notes ----------- #
		obsidian # A powerful knowledge base that works on top of a local folder of plain text Markdown files
		# ----------- Media ----------- #
		ffmpeg # A complete, cross-platform solution to record, convert and stream audio and video
		openh264 # A codec library which supports H.264 encoding and decoding
		xvidcore # MPEG-4 video codec for PC
		ab-av1 # AV1 re-encoding using ffmpeg, svt-av1 & vmaf
		svt-av1 # AV1-compliant encoder/decoder library core
		rav1e # The fastest and safest AV1 encoder
		libaom # Alliance for Open Media AV1 codec library
		gst_all_1.gstreamer # Open source multimedia framework
		gst_all_1.gst-plugins-ugly # Gstreamer Ugly Plugins
		gst_all_1.gst-plugins-good # GStreamer Good Plugins
		gst_all_1.gst-plugins-bad # GStreamer Bad Plugins
		gst_all_1.gst-plugins-rs # GStreamer plugins written in Rust
		gst_all_1.gst-libav # FFmpeg/libav plugin for GStreamer
		gst_all_1.gst-plugins-base # Base GStreamer plug-ins and helper libraries
		mpv # General-purpose media player, fork of MPlayer and mplayer2
		vlc # Cross-platform media player and streaming server
		glide-media-player # Linux/macOS media player based on GStreamer and GTK
		clapper # A GNOME media player built using GTK4 toolkit and powered by GStreamer with OpenGL rendering
		# ----------- Nix Stuff ----------- #
		fmt # Small, safe and fast formatting library
		nixpkgs-fmt # Nix code formatter for nixpkgs
		# dpkg # The Debian package manager
		# rpm # The RPM Package Manager
		# pacman # A simple library-based package manager
		# ----------- Icons & Themes ----------- #
		papirus-icon-theme # Pixel perfect icon theme for Linux
		# ----------- Social ----------- #
		# discord # All-in-one cross-platform voice and text chat for gamers
		# ----------- Disks & Partitions #
		fuse3 # Library that allows filesystems to be implemented in user space
		ntfs3g # FUSE-based NTFS driver with full write support
		efibootmgr # A Linux user-space application to modify the Intel Extensible Firmware Interface (EFI) Boot Manager
		# ----------- CLI Tools ----------- #
		lsof # A tool to list open files
		# yt-dlp # Command-line tool to download videos from YouTube.com and other sites (youtube-dl fork)
		# ----------- Hacking & security Tools ----------- #
		hashcat # Fast password cracker
		hashcat-utils # Small utilities that are useful in advanced password cracking
		hcxtools # Tools for capturing wlan traffic and conversion to hashcat and John the Ripper formats
		# ----------- Gnome Stuff ----------- #
		gnome.eog # GNOME image viewer
		gnome.totem # Movie player for the GNOME desktop based on GStreamer
		# gnome-usage # A nice way to view information about use of system resources, like memory and disk space
		# gnome.gpaste # Clipboard management system with GNOME integration
		gnome-photos # Access, organize and share your photos
		gnome.gnome-tweaks # A tool to customize advanced GNOME 3 options
		gnome.pomodoro # Time management utility for GNOME based on the pomodoro technique
		# gnome-recipes # Recipe management application for GNOME
		# gnome-extension-manager # Desktop app for managing GNOME shell extensions
		# gnome.gnome-chess # Play the classic two-player boardgame of chess
		# ----------- Hyprland ----------- #
		# hyprland # A dynamic tiling Wayland compositor that doesn't sacrifice on its looks
		# hyprland-protocols # Wayland protocol extensions for Hyprland
		# hyprlandPlugins.hyprexpo # Hyprland workspaces overview plugin
		# hyprlandPlugins.hyprbars # Plugins can be installed via a plugin entry in the Hyprland NixOS or Home Manager options.
		# xdg-desktop-portal-hyprland # xdg-desktop-portal backend for Hyprland
		# grimblast # A helper for screenshots within Hyprland, based on grimshot
		# fd # A simple, fast and user-friendly alternative to find
		# brightnessctl # This program allows you read and control device brightness
		# swww # Efficient animated wallpaper daemon for wayland, controlled at runtime
		# matugen # A material you color generation tool
		# hyprpicker # A wlroots-compatible Wayland color picker that does not suck
		# slurp # Select a region in a Wayland compositor
		# wf-recorder # Utility program for screen recording of wlroots-based compositors
		# wl-clipboard # Command-line copy/paste utilities for Wayland
		# wayshot # A native, blazing-fast screenshot tool for wlroots based compositors such as sway and river
		# swappy # A Wayland native snapshot editing tool, inspired by Snappy on macOS
		# asusctl # A control daemon, CLI tools, and a collection of crates for interacting with ASUS ROG laptops
		# supergfxctl # A GPU switching utility, mostly for ASUS laptops
		# Android
		# waydroid # Waydroid is a container-based approach to boot a full Android system on a regular GNU/Linux system like Ubuntu
		# Windows
		#wine # An Open Source implementation of the Windows API on top of X, OpenGL, and Unix
		#wine64 # An Open Source implementation of the Windows API on top of X, OpenGL, and Unix
		#winetricks # A script to install DLLs needed to work around problems in Wine
		# Downloaders
		#qbittorrent # Featureful free software BitTorrent client
		# Programming Langauges & Frameworks & Tools
		# rustup # The Rust toolchain installer
		# cargo-tauri # Build smaller, faster, and more secure desktop applications with a web frontend
		# nodejs_22 # Event-driven I/O framework for the V8 JavaScript engine
		# bun # Incredibly fast JavaScript runtime, bundler, transpiler and package manager – all in one
		git # Distributed version control system
		# dart-sass # The reference implementation of Sass, written in Dart
		# Drivers
		hwdata # Hardware Database, including Monitors, pci.ids, usb.ids, and video cards
		libva # An implementation for VA-API (Video Acceleration API)
		libdrm # Direct Rendering Manager library and headers
		#linuxKernel.packages.linux_6_11.amdgpu-pro # AMDGPU-PRO drivers
		# gpu-viewer # A front-end to glxinfo, vulkaninfo, clinfo and es2_info
		#lm_sensors # For monitoring temperatures and voltages
		#vulkan-tools # Khronos official Vulkan Tools and Utilities
		#vulkan-loader # LunarG Vulkan loader
		amdvlk # AMD Open Source Driver For Vulkan
		#driversi686Linux.amdvlk # AMD Open Source Driver For Vulkan
		#amd-blis # BLAS-compatible library optimized for AMD CPUs
		#rocmPackages.rocm-smi # System management interface for AMD GPUs supported by ROCm
		#rocmPackages.clr # AMD Common Language Runtime for hipamd, opencl, and rocclr
		#rocmPackages.hipcc # Compiler driver utility that calls clang or nvcc
		#rocmPackages.clang-ocl # OpenCL compilation with clang compiler
		#rocmPackages.rocm-thunk # Radeon open compute thunk interface
		# opencl-info # A tool to dump OpenCL platform/device information
		# opencl-clhpp # OpenCL Host API C++ bindings
		# opencl-clang # A clang wrapper library with an OpenCL-oriented API and the ability to compile OpenCL C kernels to SPIR-V modules
		# clinfo # Print all known information about all available OpenCL platforms and devices in the system
		rocm-opencl-icd
		glaxnimate
		mesa # An open source 3D graphics library
		# 3D Tools & Applications
		# blender-hip # 3D Creation/Animation/Publishing System
		# ----------- Games ----------- #
		# zeroadPackages.zeroad-unwrapped
		# zeroadPackages.zeroad-data
		# System Tools
		resources # Monitor your system resources and processes
		# mangohud # A Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more
		#openssl # A cryptographic library that implements the SSL and TLS protocols
		xdg-utils # A set of command line tools that assist applications with a variety of desktop integration tasks
		busybox # Tiny versions of common UNIX utilities in a single small executable
		# flatpak # Linux application sandboxing and distribution framework
	
		# Desktop apps
		audacity
		chromium
		telegram-desktop
		alacritty
		obs-studio
		kdenlive
		gparted
		zoom-us
		pcmanfm-qt
		polymc

		# Coding stuff
		gnumake
		gcc
		nodejs
		python
		(python3.withPackages (ps: with ps; [ requests ]))

		# CLI utils
		neofetch
		file
		tree
		fastfetch
		htop
		nix-index
		unzip
		scrot
		light
		lux
		mediainfo
		ranger
		zram-generator
		cava
		zip
		brightnessctl
		swww
		openssl
		lazygit
		bluez
		bluez-tools

		# GUI utils
		feh
		imv
		dmenu
		screenkey
		mako
		gromit-mpx

		# Xorg stuff
		#xterm
		#xclip
		#xorg.xbacklight

		# Wayland stuff
		xwayland
		wl-clipboard
		cliphist

		# WMs and stuff
		herbstluftwm
		hyprland
		seatd
		xdg-desktop-portal-hyprland
		# polybar
		# waybar

		# Sound
		pipewire
		pulseaudio
		pamixer

		# Screenshotting
		grim
		grimblast
		slurp
		flameshot
		swappy

		# Other
		home-manager
		spice-vdagent
		libsForQt5.qtstyleplugin-kvantum
		libsForQt5.qt5ct
		papirus-nord
	];

	fonts.packages = with pkgs; [
		jetbrains-mono
		noto-fonts
		noto-fonts-emoji
		twemoji-color-font
		font-awesome
		powerline-fonts
		powerline-symbols
		(nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
	];
}
