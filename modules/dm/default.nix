{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _imports = [
    (./. + settings.modules.dm.default + ".nix")
    # (lib.optional settings.modules.dm.greetd.enable ./greetd.nix)
    # (lib.optional settings.modules.dm.sddm.enable ./sddm.nix)
    # (lib.optional settings.modules.dm.tuigreet.enable ./tuigreet.nix)
  ];
in mkIf (settings.modules.dm.enable) {
  imports = lib.flatten _imports;

  # Desktop Manager & Display Manager
  services = {
    displayManager.enable = true;

    # ---- Set Default Session ---- #
    displayManager.defaultSession = settings.defaultSession;

    # ---- XSERVER ---- #
    xserver.enable = true;
  };
}
