# ---- docs.nix ---- #
{ pkgs, ... }:
{
  imports = [
    ./console.nix
    # ./brightness_control.nix
    ./configuration.nix
    ./memory.nix
    ./display_manager.nix
    ./btop.nix
    ./nixos.nix
    ./ROCM.nix
    ./systemd.nix
    ./udev.nix
    ./resources.nix
    ./trace.nix
    ./systeminfo.nix
    ./radeon.nix # Optional If using Radeon drivers
  ];
  environment.systemPackages = with pkgs; [
    # Don't remove the gcc, required by many tools and packages.
    gcc
    e2fsprogs
    # smartmontools is already in systeminfo.nix
    util-linux
    uutils-coreutils-noprefix
  ];

  # Irqbalance - Spread interrupts across cores to reduce thermal hotspots
  services.irqbalance.enable = true;

  # Runtime filesystem expectations (some legacy apps)
  systemd.tmpfiles.rules = [
    "d /tmp/.X11-unix 1777 root root 10d"
    "d /tmp/.ICE-unix 1777 root root 10d"
  ];
}
