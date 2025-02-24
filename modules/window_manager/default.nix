{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.window_manager.enable) {
  imports = [ ./hyprland ];

  services.seatd.enable = lib.mkForce false;
  # services.seatd.user = "root";
}
