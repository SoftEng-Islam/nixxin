# Display/Login manager
{ settings, lib, pkgs, ... }:
let _imports = [ (./. + "/${settings.modules.hyprland.dm.default}.nix") ];
in {
  imports = lib.flatten _imports;

  # Desktop Manager & Display Manager
  services.displayManager.enable = true;

  # ---- Set Default Session ---- #
  services.displayManager.defaultSession =  settings.modules.hyprland.dm.defaultSession;

  # ---- XSERVER ---- #
  services.xserver.enable = true;
}
