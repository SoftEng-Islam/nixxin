# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ settings, pkgs, ... }: {
  imports = [
    ./hardware.nix
    ./home.nix
    ./packages.nix
    ./stylix
    ./modules/cli
    ./modules/dev
    ./modules/flags
    ./modules/media
    ./modules/terminal
    ./modules/wm/gnome
    ./modules/wm/hyprland

    ./modules/android.nix
    ./modules/anyrun.nix
    ./modules/applications.nix
    ./modules/audio.nix
    ./modules/boot.nix
    ./modules/cli-collection.nix
    ./modules/codex.nix
    ./modules/data-transferring.nix
    ./modules/dconf.nix
    ./modules/default-apps.nix
    ./modules/environment.nix
    ./modules/gaming.nix
    ./modules/locale.nix
    ./modules/nautilus.nix
    ./modules/networking.nix
    ./modules/power-management.nix
    ./modules/systemd.nix
    ./modules/users.nix
    ./modules/virtualisation.nix
    ./modules/wine.nix
    ./modules/xdg.nix
    ./modules/xremap.nix
    ./modules/zram.nix
  ];
  documentation.dev.enable = true;
  documentation.doc.enable = true;
  documentation.info.enable = true;
  documentation.man.enable = true;
  documentation.nixos.enable = true;
  environment.localBinInPath = true;
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
      keep-outputs = true;
      keep-derivations = true;
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
  # ~~~~~~~~~~~~~~~~~~~~~~~
  # ~~~~~~~ nixpkgs ~~~~~~~
  # ~~~~~~~~~~~~~~~~~~~~~~~
  nixpkgs = {
    config = {
      rocmSupport = (if settings.gpuType == "amd" then true else false);
      allowUnfree = true;
    };
  };

  # ~~~~~~~~~~~~~~~~~~~~~~
  # ~~~~~~~ System ~~~~~~~
  # ~~~~~~~~~~~~~~~~~~~~~~
  system = {
    # autoUpgrade.enable = true;
    # autoUpgrade.allowReboot = true;
    # autoUpgrade.channel = "https://channels.nixos.org/nixos-24.05";
    stateVersion = settings.systemStateVersion;
  };
}
