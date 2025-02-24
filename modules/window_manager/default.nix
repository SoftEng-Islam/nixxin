{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _imports = [
    (lib.optional settings.modules.window_manager.hyprland.enable ./hyprland)
  ];
in mkIf (settings.modules.window_manager.enable) {
  imports = [ ./hyprland ];

  services.seatd.enable = lib.mkForce false;
  # services.seatd.user = "root";
}
