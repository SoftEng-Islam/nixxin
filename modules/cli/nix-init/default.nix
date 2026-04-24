{ pkgs, ... }:
{
  # Command line tool to generate Nix packages from URLs
  programs.nix-init = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./config.toml);
  };
}
