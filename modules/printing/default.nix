{
  settings,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
in
mkIf (settings.modules.printing.enable or false) {
  hardware.sane.enable = false;
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      samsung-unified-linux-driver_1_00_37
    ];
  };
  # Optional: Enable mDNS for auto-discovering network/Wi-Fi printers (M2020W)
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
