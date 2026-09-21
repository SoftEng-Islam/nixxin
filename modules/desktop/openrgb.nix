{
  settings,
  pkgs,
  lib,
  ...
}:
lib.mkIf (settings.modules.desktop.openrgb.enable or false) {
  services.hardware.openrgb.enable = true;
  services.hardware.openrgb.motherboard = "amd";
  environment.systemPackages = with pkgs; [
    openrgb
  ];
}
