# ---- docs.nix ---- #
{ settings, lib, pkgs, ... }:
let
  _docs = settings.modules.system.docs;
  HOME = settings.HOME;
in {

  # For Faster Rebuilding Disable These
  documentation = {
    enable = _docs.enable;
    doc.enable = _docs.doc.enable;
    man.enable = _docs.man.enable;
    man.generateCaches = _docs.man.generateCaches;
    dev.enable = _docs.dev.enable;
    info.enable = _docs.info.enable;
    nixos.enable = _docs.nixos.enable;
  };

  nix.package = pkgs.nixVersions.latest;
  nix.gc.automatic = false;
  nix.gc.dates = "03:15";
  nix.gc.options = "--delete-older-than 10d";
  nix = {
    settings = {
      sandbox = true;
      keep-outputs = false;
      max-jobs = "auto";
      keep-derivations = false;
      fallback = true; # don't fail if remote builder unavailable
      warn-dirty = true;
      min-free = 1073741824; # 1 GiB
      download-buffer-size = 536870912; # 512MiB
      use-xdg-base-directories = true;
      builders-use-substitutes = true;
      cores = 0;

      extra-sandbox-paths = [
        "/dev/kfd"
        "/sys/devices/virtual/kfd"
        "/dev/dri"
        "/dev/dri/renderD128"
        "/run/opengl-driver"
        "/run/binfmt"
      ];

      # https://bmcgee.ie/posts/2023/12/til-how-to-optimise-substitutions-in-nix/
      # http-connections = 128;

      # max-silent-time = 3600; # kills build after 1hr with no logging
      # max-substitution-jobs = 128;

      # Optimise new store contents - `nix-store optimise` cleans old
      auto-optimise-store = true;

      trusted-users = [ "@wheel" "root" ];
      allowed-users = [ "@wheel" "root" ];

      # Enable flakes
      experimental-features = [
        "nix-command"
        "flakes"
        "no-url-literals"
        "pipe-operators"
        "recursive-nix"
      ];

      trusted-substituters = [ "https://nix-community.cachix.org" ];
      substituters = [
        "https://cache.nixos.org"
        # high priority since it's almost always used
        "https://cache.nixos.org?priority=10"
        "https://hyprland.cachix.org?priority=10"
        #"https://cuda-maintainers.cachix.org"
        "https://devenv.cachix.org"
        "https://nix-community.cachix.org"
        #"https://nix-gaming.cachix.org"
        "https://nixpkgs-python.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
      ];

      # Enable cachix
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        # "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
    };

    # ---- extraOptions ---- #
    # extraOptions = ''
    #   sandbox = true
    #   max-jobs = auto
    #   auto-optimise-store = true
    #   experimental-features = nix-command flakes recursive-nix
    # '';
  };

  nixpkgs = {
    hostPlatform = lib.mkDefault "${settings.system.architecture}";
    config = {
      rocmSupport = settings.modules.system.rocm.enable;
      allowUnfree = true;
    };
  };

  # Upgrade System
  system = {
    autoUpgrade.enable = settings.system.upgrade.enable or false;
    autoUpgrade.upgrade = settings.system.upgrade.enable or false;
    autoUpgrade.dates = "daily";
    autoUpgrade.allowReboot = settings.system.upgrade.allowReboot or false;
    autoUpgrade.channel = settings.system.upgrade.channel;
    autoUpgrade.operation = "switch";
    autoUpgrade.flags = [ "--update-input" "nixpkgs" "--commit-lock-file" ];
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
    enable = true;
    script = "${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --upgrade";
    serviceConfig.Type = "oneshot";
  };

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # ------------------------------------------------
  # ---- Enable "nh" nix cli helper.
  # ------------------------------------------------
  # Alternative for `$ sudo nixos-rebuild switch --flake .#nixos`
  # nh os switch .#nixos
  # Or using an environment variable
  # environment.variables.FLAKE = "/home/${settings.user.username}/nixxin";
  # Than you can just run: nh os switch -H default
  # -H => is for hostname, Like in your terminal => `user@hostname`
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "${HOME}/nixxin";
  };

  programs.command-not-found.enable = false;
  programs.fuse.userAllowOther = true;

  # See https://nix.dev/permalink/stub-ld.
  #? what is nix-ld?
  # Nix-ld is a tool that allows you to run unpatched dynamic binaries on NixOS.
  # It works by creating a profile that contains the necessary libraries and
  # environment variables to run the binary.
  # It is similar to the `nix run` command, but it does not require
  # the binary to be built with Nix.
  programs.nix-ld = {
    enable = true;
    # Include libstdc++ in the nix-ld profile
    libraries = with pkgs; [
      # Standard compilers & runtime
      gcc # provides /run/current-system/sw/bin/gcc
      libgcc # libgcc_s, etc.
      glibc_multi # if you need multilib support

      stdenv.cc # C compiler environment
      stdenv.cc.cc # explicit cc
      stdenv.cc.cc.lib

      # Common native libraries used during build
      libfontenc
      fontconfig
      freetype
      libxext
      glib
      libpng12
      gcc
      libsm
      libice
      # windows.mcfgthreads
      zlib # compression
      zstd # compression
      xz # compression
      bzip2 # compression
      libssh # SSH support (if needed)
      openssl # TLS, crypto
      libxml2 # XML parsing (if your tooling needs it)
      systemd # for ldconfig and related
      util-linux # mount, etc.
      acl # access-control lists
      attr # file attributes
      curl # downloads
      libxrender
      libx11
      libxrandr

      libGL
      vkd3d
      libva
      libva-utils
      libdrm
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
    ];
  };

  # List services that you want to enable:
  services = {
    accounts-daemon.enable = true;
    udisks2.enable = true;
    fwupd.enable = true; # Firmware update daemon --- IGNORE ---

    # ACPI daemon
    # 🔌 It listens for power-related events from the system firmware (BIOS/UEFI), such as:
    # Power button press 💡
    # Lid close/open (on laptops)
    # Sleep/wake events 💤
    # Battery state changes 🔋
    # AC adapter plugged/unplugged 🔌
    acpid.enable = true;

    # The color management daemon.
    colord.enable = true;

    # An automatic device mounting daemon.
    devmon.enable = true;

    # A userspace virtual filesystem.
    gvfs.enable = true; # A lot of mpris packages require it.

    # Printing support through the CUPS daemon.
    # printing.enable = false; # Enable CUPS to print documents.
  };

  environment.variables = {
    NIX_AUTO_RUN = "1"; # auto-run programs using nix-index-database
    NIXPKGS_ALLOW_UNFREE = "1"; # support for non-free (proprietary) software.
    NIXPKGS_ALLOW_INSECURE = "1";
    # NIXPKGS_ALLOW_BROKEN = "1"; # allow broken packages to be installed.
    # NIXPKGS_ALLOW_UNFREE_OVERLAYS = "1"; # allow unfree overlays to be used.
    # NIXPKGS_ALLOW_BROKEN_OVERLAYS = "1"; # allow broken overlays to be used.
    NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM = "1";
  };

  home-manager.users.${settings.user.username} = {
    programs.home-manager.enable = true;
    home = {
      sessionPath = [
        "${HOME}/.bin"
        "${HOME}/.local/bin"
        "${HOME}/.cargo/bin"
        "${HOME}/.go/bin"
      ];

      sessionVariables = {
        # Set the default pager to less
        # This is useful for programs that use a pager, such as `man` or `git log`
        # It allows you to scroll through the output using the arrow keys or page up
        # and page down keys.
        # You can also use the space bar to scroll down one page at a time.
        # You can also use the `q` key to quit the pager.
        PAGER = "less";

        LESS = "-R";
        VIRTUAL_ENV_DISABLE_PROMPT = "1";
        PIPENV_SHELL_FANCY = "1";
        ERL_AFLAGS = "-kernel shell_history enabled";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # Nix Related Packages
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
    statix # Lints and suggestions for the nix programming language
    deadnix
    cachix

    # Nix language server
    nixd # Feature-rich Nix language server interoperating with C++ nix
    nixfmt
    nil # Yet another language server for Nix
    niv

    # Nix Formatters
    # nixfmt-rfc-style # Official formatter for Nix code [nixfmt file.nix]
    nixpkgs-fmt # Nix code formatter for nixpkgs [nixpkgs-fmt file.nix]

    nixdoc # Generate documentation for Nix functions
    node2nix # Generate Nix expressions to build NPM packages

    # Yet another nix cli helper
    nh

    fwupd
  ];
}
