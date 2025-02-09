{ pkgs, lib, settings, ... }: {
  imports = [ ./hyprland ];
  services.seatd.enable = lib.mkForce false;
  services.seatd.user = "root";
}
