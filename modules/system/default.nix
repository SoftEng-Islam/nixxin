# ---- docs.nix ---- #
{ settings, lib, pkgs, modulesPath, ... }:
let inherit (lib) mkIf;
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./configuration.nix
    ./file_systems.nix
    ./nixos.nix
    ./swap_devices.nix
    ./systemd.nix
  ];
}
