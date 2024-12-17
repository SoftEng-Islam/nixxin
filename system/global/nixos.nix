{ pkgs, ... }: {
  # documentation.nixos.enable = false; # .desktop
  # documentation.nixos.enable = lib.mkForce false;
  # documentation.info.enable = false;
  # documentation.doc.enable = false;

  # See https://nix.dev/permalink/stub-ld.
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ stdenv.cc.cc ];

  nix = {
    # package = pkgs.nixStable;
    package = pkgs.nixVersions.latest;
    gc.automatic = true;
    gc.dates = "03:15";
    gc.options = "--delete-older-than 10d";
    settings = {
      # for nix-direnv
      keep-outputs = true;
      keep-derivations = true;
      experimental-features = [ "nix-command" "flakes" "pipe-operators" ];
      sandbox = false;
      substituters = [
        "https://cache.nixos.org"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-substituters = [ "https://nix-community.cachix.org" ];
      # trusted-public-keys = [
      #   "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      #   "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      # ];
      trusted-users = [ "@wheel" "root" ];
      fallback = true;
      warn-dirty = false;
      auto-optimise-store = true;
    };

    extraOptions = ''
      sandbox = false
      max-jobs = 4
      auto-optimise-store = true
    '';
  };

  nixpkgs = {
    config = {
      rocmSupport = false;
      allowUnfree = true;
    };
  };
  systemd.timers.nix-cleanup-gcroots = {
    timerConfig = {
      OnCalendar = [ "weekly" ];
      Persistent = true;
    };
    wantedBy = [ "timers.target" ];
  };
  systemd.services.nix-cleanup-gcroots = {
    serviceConfig = {
      Type = "oneshot";
      ExecStart = [
        # delete automatic gcroots older than 30 days
        "${pkgs.findutils}/bin/find /nix/var/nix/gcroots/auto /nix/var/nix/gcroots/per-user -type l -mtime +30 -delete"
        # created by nix-collect-garbage, might be stale
        "${pkgs.findutils}/bin/find /nix/var/nix/temproots -type f -mtime +10 -delete"
        # delete broken symlinks
        "${pkgs.findutils}/bin/find /nix/var/nix/gcroots -xtype l -delete"
      ];
    };
  };
  programs.command-not-found.enable = false;
  security.isolate.enable = false;
  environment.systemPackages = with pkgs; [
    direnv # Shell extension that manages your environment
    fmt # Small, safe and fast formatting library
    home-manager # A Nix-based user environment configurator
    inxi # Full featured CLI system information tool
    nix-bash-completions # Bash completions for Nix, NixOS, and NixOps
    nix-direnv # Fast, persistent use_nix implementation for direnv
    nix-btm # Rust tool to monitor Nix processes
    nix-doc # Interactive Nix documentation tool
    nix-index # A files database for nixpkgs
    nix-prefetch # Prefetch any fetcher function call, e.g. package sources
    nix-prefetch-github
    nixfmt-classic # An opinionated formatter for Nix
    nixos-shell # Spawns lightweight nixos vms in a shell
    nixpkgs-lint # A utility for Nixpkgs contributors to check Nixpkgs for common errors
    nixpkgs-review
    # Nix language server
    nixd # Feature-rich Nix language server interoperating with C++ nix
    nil # Yet another language server for Nix
    # Nix Formatters:
    nixpkgs-fmt # Nix code formatter for nixpkgs [nixpkgs-fmt file.nix]
    nixfmt-rfc-style # Official formatter for Nix code [nixfmt file.nix]
    alejandra # Uncompromising Nix Code Formatter [alejandra file.nix]
    nixdoc # Generate documentation for Nix functions
  ];
}
