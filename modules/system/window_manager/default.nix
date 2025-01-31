{ pkgs, lib, settings, ... }: {
  imports = (lib.optional settings.hyprland.enable [ ./hyprland ]);
  services.seatd.enable = lib.mkForce false;
  services.seatd.user = "root";
}
