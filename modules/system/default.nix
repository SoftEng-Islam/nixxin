# ---- docs.nix ---- #
{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  imports = [
    ./configuration.nix
    ./file_systems.nix
    ./nixos.nix
    ./swap_devices.nix
    ./systemd.nix
  ];
}
