# ---- docs.nix ---- #
{ pkgs, ... }: {
  imports = [
    ./brightness_control.nix
    ./configuration.nix
    ./memory.nix
    ./display_manager.nix
    ./btop.nix
    ./nixos.nix
    ./radeon.nix # Optional If using Radeon drivers
    ./ROCM.nix
    ./systemd.nix
    ./udev.nix
    ./resources.nix
    ./trace.nix
  ];
  environment.systemPackages = with pkgs; [
    e2fsprogs
    smartmontools
    util-linux
  ];
}
