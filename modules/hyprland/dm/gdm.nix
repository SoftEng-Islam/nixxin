{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.autoSuspend = false;
}
