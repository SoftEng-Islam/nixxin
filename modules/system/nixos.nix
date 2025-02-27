# ---- docs.nix ---- #
{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _docs = settings.modules.system.docs;
in {

  # For Faster Rebuilding Disable These
  documentation = {
    enable = _docs.enable;
    doc.enable = _docs.doc.enable;
    man = {
      enable = _docs.man.enable;
      generateCaches = _docs.man.generateCaches;
    };
    dev.enable = _docs.dev.enable;
    info.enable = _docs.info.enable;
    nixos.enable = _docs.nixos.enable;
  };

  nix = {
    package = pkgs.nixVersions.latest;
    gc = {
      automatic = false;
      dates = "03:15";
      options = "--delete-older-than 10d";
    };
    settings = {
      sandbox = false;
      # color = true;
      connect-timeout = 0; # 0 means no limit
      download-attempts = 10;
      # download-buffer-size = 536870912;
      http-connections = 0; # 0 means no limit
      keep-outputs = false;
      keep-derivations = false;
      # Enable flakes
      experimental-features =
        [ "nix-command" "flakes" "no-url-literals" "pipe-operators" ];

      builders-use-substitutes = true;
      substituters = [
        # high priority since it's almost always used
        "https://cache.nixos.org?priority=10"

        "https://cache.garnix.io"
        "https://cuda-maintainers.cachix.org"
        "https://devenv.cachix.org"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://nixpkgs-python.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
      ];
      trusted-substituters = [ "https://nix-community.cachix.org" ];
      # Enable cachix
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
      trusted-users = [ "@wheel" "root" "${settings.user.username}" ];
      allowed-users = [ "@wheel" "root" "${settings.user.username}" ];
      fallback = true;
      warn-dirty = false;
      # Auto clear nixos store
      auto-optimise-store = true;
    };
    extraOptions = ''
      sandbox = false
      max-jobs = 4
      auto-optimise-store = true
      experimental-features = nix-command flakes recursive-nix
    '';
  };

  nixpkgs = {
    hostPlatform = lib.mkDefault "${settings.system.architecture}";
    config = {
      rocmSupport = settings.global.rocm.enable;
      allowUnfree = true;
    };
  };

  system = {
    autoUpgrade.enable = settings.system.upgrade.enable;
    autoUpgrade.allowReboot = settings.system.upgrade.allowReboot;
    autoUpgrade.channel = settings.system.upgrade.channel;
    stateVersion = settings.system.stateVersion;
  };
  # ------------------------------------------------
  # ---- Enable automatic updates
  # ------------------------------------------------
  systemd.timers.nixos-upgrade = {
    enable = true;
    timerConfig.OnCalendar = "weekly";
    wantedBy = [ "timers.target" ];
  };
  systemd.services.nixos-upgrade = {
    script = "${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --upgrade";
    serviceConfig.Type = "oneshot";
  };

  programs = {
    command-not-found.enable = false;

    mtr.enable = true;
    fuse.userAllowOther = true;

    gnupg.agent.enable = true;
    gnupg.agent.enableSSHSupport = true;

    # ---- nh ---- #
    # Enable "nh" nix cli helper.
    nh = { enable = true; };

    # See https://nix.dev/permalink/stub-ld.
    # run unpatched dynamic binaries on NixOS
    nix-ld = {
      enable = true;
      # Include libstdc++ in the nix-ld profile
      libraries = with pkgs; [
        curl
        expat
        fontconfig
        freetype
        fuse3
        icu
        nss
        openssl
        stdenv.cc.cc
        util-linux
        vulkan-headers
        vulkan-loader
        vulkan-tools
        xorg.libX11
        zlib
      ];
    };
  };

  services = {
    # Forces the GPU to always run at full power.
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="drm", KERNEL=="card0", ATTR{power_dpm_state}="performance"
    '';

    dbus.enable = true;
    dbus.packages = [ pkgs.dconf ];
    dbus.implementation = "broker";
    accounts-daemon.enable = true;
    fwupd.enable = false;
    udisks2.enable = true;

    # Tumbler, A D-Bus thumbnailer service.
    tumbler.enable = true;

    # ACPI daemon
    acpid.enable = true;

    # Populates contents of /bin and /usr/bin/
    envfs.enable = true;

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.mouse.accelSpeed = "-0.5";

    # The color management daemon.
    colord.enable = true;

    # An automatic device mounting daemon.
    devmon.enable = true;

    # A DBus service that provides location information for accessing.
    geoclue2.enable = true;

    # A userspace virtual filesystem.
    gvfs.enable = true; # A lot of mpris packages require it.

    # Printing support through the CUPS daemon.
    printing.enable = false; # Enable CUPS to print documents.

    # sysprof profiling daemon.
    sysprof.enable = true; # Whether to enable sysprof profiling daemon.

    logind.extraConfig = ''
      # don’t shutdown when power button is short-pressed
      HandlePowerKey=ignore
    '';
    # ---- Optimization ---- #
    scx = {
      enable = true;
      scheduler = "scx_rusty";
      package = pkgs.scx.rustscheds;
    };
  };

  environment.variables = {
    NIX_AUTO_RUN = "1"; # auto-run programs using nix-index-database
    NIXOS_XDG_OPEN_USE_PORTAL = "1"; # needed to open apps after web login
    NIXOS_OZONE_WL = "1"; # Optional, hint electron apps to use wayland
    NIXPKGS_ALLOW_UNFREE = "1"; # support for non-free (proprietary) software.

    # NIXPKGS_ALLOW_INSECURE = "1";
  };

  home-manager.users.${settings.user.username} = {
    programs.home-manager.enable = true;
    home = {
      sessionPath =
        [ "$HOME/.bin" "$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/.go/bin" ];

      sessionVariables = {
        PAGER = "less";
        LESS = "-R";
        VIRTUAL_ENV_DISABLE_PROMPT = "1";
        PIPENV_SHELL_FANCY = "1";
        ERL_AFLAGS = "-kernel shell_history enabled";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # ---- Settings.nix Packages ---- #
    bibata-cursors
    proot # User-space implementation of chroot, mount --bind and binfmt_misc
    # matugen # A material you color generation tool

    gzip

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
    # gnuchess # GNU Chess engine
    gnumake # A tool to control the generation of non-source files from sources

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
    binutils
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

    dbus # Simple interprocess messaging system
    dbus-broker # Linux D-Bus Message Broker
    d-spy # D-Bus exploration tool
    libdbusmenu # Library for passing menu structures across DBus
    libdbusmenu-gtk3 # Library for passing menu structures across DBus

    # nix related
    # it provides the command `nom` works just like `nix`
    # with more details log output
    cached-nix-shell # fast nix-shell scripts
    fmt # Small, safe and fast formatting library
    home-manager # A Nix-based user environment configurator
    inxi # Full featured CLI system information tool
    nix-bash-completions # Bash completions for Nix, NixOS, and NixOps
    nix-btm # Rust tool to monitor Nix processes
    nix-direnv # Fast, persistent use_nix implementation for direnv
    nix-doc # Interactive Nix documentation tool
    nix-index # A files database for nixpkgs
    nix-output-monitor # Processes output of Nix commands to show helpful and pretty information
    nix-prefetch # Prefetch any fetcher function call, e.g. package sources
    nix-prefetch-git # Script used to obtain source hashes for fetchgit
    nix-prefetch-github # Prefetch sources from github
    nix-tree # Interactively browse a Nix store paths dependencies
    nixfmt-classic # An opinionated formatter for Nix
    nixos-install-tools # The essential commands from the NixOS installer as a package
    nixos-shell # Spawns lightweight nixos vms in a shell
    nixpkgs-lint # A utility for Nixpkgs contributors to check Nixpkgs for common errors
    nixpkgs-review
    statix # nvim-lint
    deadnix

    # Nix language server
    nixd # Feature-rich Nix language server interoperating with C++ nix
    nil # Yet another language server for Nix

    # Nix Formatters:
    alejandra # Uncompromising Nix Code Formatter [alejandra file.nix]
    nixfmt-rfc-style # Official formatter for Nix code [nixfmt file.nix]
    nixpkgs-fmt # Nix code formatter for nixpkgs [nixpkgs-fmt file.nix]

    nixdoc # Generate documentation for Nix functions
    node2nix # Generate Nix expressions to build NPM packages

    # Yet another nix cli helper
    nh

    (pkgs.writeShellScriptBin "toggle-services" ''
      SERVICES=("$@")

      toggleService() {
          SERVICE="$1"

          if [[ ! "$SERVICE" == *".service"* ]]; then SERVICE="''${SERVICE}.service"; fi

          if systemctl list-unit-files "$SERVICE" &>/dev/null; then
              if systemctl is-active --quiet "$SERVICE"; then
                  echo "Stopping \"$SERVICE\"..."
                  sudo systemctl stop "$SERVICE"
              else
                  echo "Starting \"$SERVICE\"..."
                  sudo systemctl start "$SERVICE"
              fi
          else
              echo "\"$SERVICE\" does not exist"
          fi
      }

      # Retain sudo
      trap "exit" INT TERM; trap "kill 0" EXIT; sudo -v || exit $?; sleep 1; while true; do sleep 60; sudo -nv; done 2>/dev/null &

      for i in "''${SERVICES[@]}"
      do
          toggleService "$i"
      done
    '')
  ];
}
