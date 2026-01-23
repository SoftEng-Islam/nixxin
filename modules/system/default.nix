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
    ./systeminfo.nix
  ];
  environment.systemPackages = with pkgs; [
    e2fsprogs
    smartmontools
    util-linux
    uutils-coreutils-noprefix
  ];

  # Runtime filesystem expectations (some legacy apps)
  systemd.tmpfiles.rules = [
    "d /tmp/.X11-unix 1777 root root 10d"
    "d /tmp/.ICE-unix 1777 root root 10d"
  ];
}
