{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.printing.enable) {
  hardware.sane.enable = false;
  services.printing = {
    enable = true;
    drivers = with pkgs; [ samsung-unified-linux-driver ];
  };
}
