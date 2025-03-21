{ settings, lib, pkgs, ... }:
let _imports = [ (./. + "/${settings.modules.display_manager.default}.nix") ];
in {
  imports = lib.flatten _imports;

  # Desktop Manager & Display Manager
  services.displayManager.enable = true;

  # ---- Set Default Session ---- #
  services.displayManager.defaultSession =
    settings.modules.display_manager.defaultSession;

  # ---- XSERVER ---- #
  services.xserver.enable = true;
}
