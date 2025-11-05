{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _browsers = with pkgs; [
    (lib.optional settings.modules.browsers.firefox.enable firefox)
    (lib.optional settings.modules.browsers.firefox-beta.enable firefox-beta)
    (lib.optional settings.modules.browsers.brave.enable brave)
    (lib.optional settings.modules.browsers.google-chrome.enable google-chrome)
    (lib.optional settings.modules.browsers.microsoft-edge.enable microsoft-edge)
  ];
in mkIf (settings.modules.browsers.enable) {
  environment.systemPackages = lib.flatten _browsers;
}
