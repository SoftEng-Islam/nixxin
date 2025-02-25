{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _browsers = with pkgs; [
    (lib.optional settings.modules.browsers.firefox firefox)
    (lib.optional settings.modules.browsers.firefox-beta firefox-beta)
    (lib.optional settings.modules.browsers.brave brave)
    (lib.optional settings.modules.browsers.google-chrome google-chrome)
    (lib.optional settings.modules.browsers.microsoft-edge microsoft-edge)
  ];
in mkIf (settings.modules.browsers.enable) {
  environment.systemPackages = lib.flatten _browsers;
}
