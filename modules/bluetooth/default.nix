{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.bluetooth.enable) {
  environment.systemPackages = with pkgs;
    [
      blueberry # Bluetooth configuration tool
    ];
}
