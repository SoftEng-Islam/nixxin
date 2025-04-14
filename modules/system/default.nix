# ---- docs.nix ---- #
{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in { imports = [ ./configuration.nix ./nixos.nix ./radeon.nix ./systemd.nix ]; }
