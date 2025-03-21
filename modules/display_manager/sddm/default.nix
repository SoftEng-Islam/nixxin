{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  imgLink = (./. + "./orange_sunset.jpg");

in {
  services = {
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    displayManager.sddm.package = pkgs.plasma5Packages.sddm;
  };
  environment.systemPackages = with pkgs;
    [
      # sddm # QML based X11 display manager

      (sddm-chili-theme.override {
        themeConfig = {
          background = imgLink;
          ScreenWidth = 1920;
          ScreenHeight = 1080;
          blur = true;
          recursiveBlurLoops = 3;
          recursiveBlurRadius = 5;
        };
      })
    ];
}
