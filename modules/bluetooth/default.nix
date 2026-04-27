{
  settings,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
in
mkIf (settings.modules.bluetooth.enable) {

  hardware = {
    bluetooth = {
      enable = true;
      settings.General = {
        Experimental = true;
        KernelExperimental = true;
        FastConnectable = "true";
        JustWorksRepairing = "always";
        Cache = false;
      };
    };
  };
  environment.systemPackages = with pkgs; [
    blueberry # Bluetooth configuration tool
  ];
}
