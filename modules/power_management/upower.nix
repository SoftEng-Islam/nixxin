{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.power_management.upower.enable) {
  # Upower, a DBus service that provides power management support to applications.
  services.upower = {
    enable = lib.mkForce true;
    package = pkgs.upower;
  };
}
