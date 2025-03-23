# Display/Login manager
{ settings, lib, pkgs, ... }:
let _imports = [ (./. + "/${settings.modules.dm.default}.nix") ];
in {
  imports = lib.flatten _imports;

  # Desktop Manager & Display Manager
  services.displayManager.enable = true;

  # ---- Set Default Session ---- #
  services.displayManager.defaultSession = settings.modules.dm.defaultSession;

  # ---- XSERVER ---- #
  services.xserver.enable = true;
}
