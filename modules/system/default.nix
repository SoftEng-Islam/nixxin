# ---- docs.nix ---- #
{ pkgs, ... }: {
  imports = [
    ./brightness_control.nix
    ./configuration.nix
    ./nixos.nix
    ./opengl.nix
    ./radeon.nix # Optional If using Radeon drivers
    ./ROCM.nix
    ./systemd.nix
    ./udev.nix
  ];
  environment.systemPackages = with pkgs; [
    e2fsprogs
    smartmontools
    util-linux
  ];
}
