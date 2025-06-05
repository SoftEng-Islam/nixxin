{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  services.displayManager.gdm.wayland = true;
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.autoSuspend = false;
}
