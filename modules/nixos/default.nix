# ---- docs.nix ---- #
{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  # For Faster Rebuilding Disable These
  documentation = {
    enable = settings.modules.docs.enable;
    doc.enable = settings.modules.docs.doc.enable;
    man = {
      enable = settings.modules.docs.man.enable;
      generateCaches = settings.modules.docs.man.generateCaches;
    };
    dev.enable = settings.modules.docs.dev.enable;
    info.enable = settings.modules.docs.info.enable;
    nixos.enable = settings.modules.docs.nixos.enable;
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
      color = true;
      connect-timeout = 0; # 0 means no limit
      download-attempts = 10;
      # download-buffer-size = 536870912;
      http-connections = 0; # 0 means no limit
      keep-outputs = true;
      keep-derivations = true;
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
    config = {
      rocmSupport = settings.hardware.rocmSupport;
      allowUnfree = true;
    };
  };

  programs = {
    command-not-found.enable = false;

    # droidcam.enable = true; # camera
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
  };

  # Hackity HACK for working D-Bus activation
  # systemd.user.services.dbus.environment.DISPLAY = ":0";

  # ---- Optimization ---- #
  services.scx = {
    enable = true;
    scheduler = "scx_rusty";
    package = pkgs.scx.rustscheds;
  };
  # Tweaks improve boot times
  systemd.services."*" = { serviceConfig = { TimeoutStartSec = "30s"; }; };

  environment.systemPackages = with pkgs; [
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
