{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _imports = [
    (lib.optional settings.modules.window_manager.hyprland.enable ./hyprland)
  ];
in {
  imports = [ ./hyprland ];

  services.seatd.enable = lib.mkForce false;
  # services.seatd.user = "root";
}
