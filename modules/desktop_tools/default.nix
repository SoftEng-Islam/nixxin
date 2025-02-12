{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.desktop_tools.enable) {
  environment.systemPackages = with pkgs;
    [
      gromit-mpx # Desktop annotation tool
    ];
}
