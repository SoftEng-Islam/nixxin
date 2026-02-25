# Display/Login manager
{
  settings,
  lib,
  pkgs,
  ...
}:
let
  sugarTheme =
    if pkgs ? sddm-sugar-candy then
      {
        name = "sugar-candy";
        package = pkgs.sddm-sugar-candy;
      }
    else
      {
        name = "sugar-dark";
        package = pkgs.sddm-sugar-dark;
      };
in
{
  # Desktop Manager & Display Manager
  services.displayManager.enable = true;
  services.displayManager.sddm = {
    enable = true;
    theme = sugarTheme.name;
    extraPackages = [
      sugarTheme.package
      pkgs.qt6.qt5compat
      pkgs.qt6.qtsvg
    ];
    settings = {
      Theme = {
        CursorTheme = settings.common.cursor.name;
        CursorSize = settings.common.cursor.size;
      };
    };
  };

  # ---- Set Default Session ---- #
  services.displayManager.defaultSession = "hyprland";

  # ---- XSERVER ---- #
  services.xserver.enable = true;
  services.xserver.autorun = true;
}
