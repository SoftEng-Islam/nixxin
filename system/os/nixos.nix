{ pkgs, ... }: {
  # documentation.nixos.enable = false; # .desktop
  # documentation.nixos.enable = lib.mkForce false;
  # documentation.info.enable = false;
  # documentation.doc.enable = false;
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
        "https://nixos.tvix.store"

        "https://nix-community.cachix.org"
        "https://cache.thalheim.io"
      ];
      trusted-substituters =
        [ "https://nix-community.cachix.org" "https://cache.thalheim.io" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.thalheim.io-1:R7msbosLEZKrxk/lKxf9BTjOOH7Ax3H0Qj0/6wiHOgc="
      ];

      trusted-users = [ "@wheel" "root" ];

      fallback = true;
      warn-dirty = false;
      auto-optimise-store = true;

    };

    extraOptions = ''
      sandbox = true
      max-jobs = 4
      auto-optimise-store = true
    '';
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
    direnv
    fmt # Small, safe and fast formatting library
    home-manager # A Nix-based user environment configurator
    inxi
    nix-bash-completions
    nix-direnv
    nix-btm
    nix-doc
    nix-index # A files database for nixpkgs
    nix-prefetch
    nixfmt-classic # An opinionated formatter for Nix
    nixos-shell
    nixpkgs-lint # A utility for Nixpkgs contributors to check Nixpkgs for common errors
    nixpkgs-review
    # Nix Formatters:
    nixpkgs-fmt # Nix code formatter for nixpkgs [nixpkgs-fmt file.nix]
    nixfmt-rfc-style # Official formatter for Nix code [nixfmt file.nix]
    alejandra # Uncompromising Nix Code Formatter [alejandra file.nix]
    nixd # Feature-rich Nix language server interoperating with C++ nix
    nixdoc # Generate documentation for Nix functions
  ];
}
