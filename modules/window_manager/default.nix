{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _imports =
    [ (lib.optional settings.window_manager.hyprland.enable ./hyprland) ];
in mkIf (settings.modules.window_manager.enable) {
  imports = lib.flatten _imports;

  services.seatd.enable = lib.mkForce false;
  # services.seatd.user = "root";
}
