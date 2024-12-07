{ pkgs, ... }: {
  # documentation.nixos.enable = false; # .desktop

  nix = {
    # package = pkgs.nixStable;
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      sandbox = true
      max-jobs = 4
      auto-optimise-store = true
    '';
    settings.experimental-features =
      [ "nix-command" "flakes" "pipe-operators" ];
    settings.auto-optimise-store = true;
    settings.sandbox = false;
  };
  security.isolate.enable = false;
  environment.systemPackages = with pkgs; [
    fmt # Small, safe and fast formatting library
    home-manager # A Nix-based user environment configurator
    nix-index # A files database for nixpkgs
    nixpkgs-lint # A utility for Nixpkgs contributors to check Nixpkgs for common errors
    nixfmt-classic # An opinionated formatter for Nix
    # Nix Formatters:
    nixpkgs-fmt # Nix code formatter for nixpkgs [nixpkgs-fmt file.nix]
    nixfmt-rfc-style # Official formatter for Nix code [nixfmt file.nix]
    alejandra # Uncompromising Nix Code Formatter [alejandra file.nix]
    nixd # Feature-rich Nix language server interoperating with C++ nix
    nixdoc # Generate documentation for Nix functions
  ];
}
