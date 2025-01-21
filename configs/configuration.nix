# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ settings, pkgs, ... }:

let
  gnome = if settings.gnome.enable then [ ./modules/wm/gnome ] else [ ];
  hyprland =
    if settings.hyprland.enable then [ ./modules/wm/hyprland ] else [ ];

in {
  imports = gnome ++ hyprland ++ [
    ./hardware.nix
    ./home.nix
    ./packages.nix
    ./styles

    ./modules/alfred
    # ./modules/anytype
    ./modules/btop
    ./modules/cli
    ./modules/dev
    ./modules/editors
    ./modules/fileManager
    ./modules/flags
    ./modules/media
    ./modules/qbittorrent
    ./modules/system
    ./modules/terminal

    ./modules/android.nix
    ./modules/applications.nix
    # ./modules/beesd.nix
    # ./modules/browser.nix
    ./modules/data-transferring.nix
    # ./modules/davinci.nix
    # ./modules/fcitx5.nix
    ./modules/fuzzel.nix
    ./modules/gaming.nix
    ./modules/gtk.nix
    ./modules/misc.nix
    # ./modules/printing.nix
    # ./modules/productivity.nix
    ./modules/qt.nix
    ./modules/wayland.nix
    ./modules/wine.nix
    ./modules/xdg.nix
    ./modules/xremap.nix
  ];
  documentation.dev.enable = true;
  documentation.doc.enable = true;
  documentation.info.enable = true;
  documentation.man.enable = true;
  documentation.nixos.enable = true;
  # ~~~~~~~~~~~~~~~~~~~
  # ~~~~~~~ nix ~~~~~~~
  # ~~~~~~~~~~~~~~~~~~~
  nix = {
    package = pkgs.nixVersions.latest;
    gc.automatic = true;
    gc.dates = "03:15";
    gc.options = "--delete-older-than 10d";
    settings = {
      # for nix-direnv
      sandbox = false;
      keep-outputs = false;
      keep-derivations = false;
      builders-use-substitutes = true;
      experimental-features =
        [ "nix-command" "flakes" "no-url-literals" "pipe-operators" ];
      substituters = [
        "https://cache.nixos.org"
        "https://cuda-maintainers.cachix.org"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://nixpkgs-python.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
      ];
      # trusted-substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
      ];
      trusted-users = [ "@wheel" "root" ];
      fallback = true;
      warn-dirty = false;
      auto-optimise-store = true;
    };
    extraOptions = ''
      sandbox = false
      max-jobs = 4
      auto-optimise-store = true
      experimental-features = nix-command flakes
    '';
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
  # ~~~~~~~~~~~~~~~~~~~~~~~
  # ~~~~~~~ nixpkgs ~~~~~~~
  # ~~~~~~~~~~~~~~~~~~~~~~~
  nixpkgs = {
    config = {
      rocmSupport = (if settings.gpuType == "amd" then true else false);
      allowUnfree = true;
    };
  };

  programs.nix-ld = {
    enable = true;
    #Include libstdc++ in the nix-ld profile
    libraries = [
      pkgs.stdenv.cc.cc
      pkgs.zlib
      pkgs.fuse3
      pkgs.icu
      pkgs.nss
      pkgs.openssl
      pkgs.curl
      pkgs.expat
      pkgs.xorg.libX11
      pkgs.vulkan-headers
      pkgs.vulkan-loader
      pkgs.vulkan-tools
    ];
  };

  # for home-manager, use programs.bash.initExtra instead
  programs.bash.interactiveShellInit = ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  '';
  programs.zsh.interactiveShellInit = ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  '';

  # ~~~~~~~~~~~~~~~~~~~~~~
  # ~~~~~~~ System ~~~~~~~
  # ~~~~~~~~~~~~~~~~~~~~~~
  system = {
    # autoUpgrade.enable = true;
    # autoUpgrade.allowReboot = true;
    # autoUpgrade.channel = "https://channels.nixos.org/nixos-24.05";
    stateVersion = settings.systemStateVersion;
  };
  environment.systemPackages = with pkgs; [
    # nix related
    # it provides the command `nom` works just like `nix`
    # with more details log output
    cached-nix-shell # fast nix-shell scripts
    direnv # Shell extension that manages your environment
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
    nix-prefetch-github
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
    nixdoc # Generate documentation for Nix functions
    nixfmt-rfc-style # Official formatter for Nix code [nixfmt file.nix]
    nixpkgs-fmt # Nix code formatter for nixpkgs [nixpkgs-fmt file.nix]
    node2nix # Generate Nix expressions to build NPM packages
  ];
}
