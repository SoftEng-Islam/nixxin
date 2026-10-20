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
  hardware.printers = {
    ensurePrinters = [
      {
        name = "Samsung_M2020";
        deviceUri = "usb://Samsung/M2020%20Series?serial=0727B8GF8C00G3W";
        model = "Samsung_M2020_Series.ppd.gz";
      }
    ];
    ensureDefaultPrinter = "Samsung_M2020";
  };
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
