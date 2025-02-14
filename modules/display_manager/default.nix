{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _imports = [
    (./. + settings.modules.display_manager.default + ".nix")
    # (lib.optional settings.modules.display_manager.greetd.enable ./greetd.nix)
    # (lib.optional settings.modules.display_manager.sddm.enable ./sddm.nix)
    # (lib.optional settings.modules.display_manager.tuigreet.enable ./tuigreet.nix)
  ];
in mkIf (settings.modules.display_manager.enable) {
  imports = lib.flatten _imports;

  # Desktop Manager & Display Manager
  services = {
    displayManager.enable = true;

    # ---- Set Default Session ---- #
    displayManager.defaultSession = settings.display_manager.defaultSession;

    # ---- XSERVER ---- #
    xserver.enable = true;
  };
}
