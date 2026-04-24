{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.bluetooth.enable) {

  hardware = {
    bluetooth = {
      enable = true;
      settings.General = {
        Experimental = true;
        KernelExperimental = true;
      };
    };
  };
  environment.systemPackages = with pkgs;
    [
      blueberry # Bluetooth configuration tool
    ];
}
