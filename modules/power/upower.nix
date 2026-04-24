{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.power.upower.enable or false) {
  # Upower, a DBus service that provides power management support to applications.
  services.upower.enable = true;
  environment.systemPackages = with pkgs; [ upower upower-notify ];
}
