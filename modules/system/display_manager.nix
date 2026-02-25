# Display/Login manager
{
  settings,
  lib,
  pkgs,
  ...
}:
{
  # Desktop Manager & Display Manager
  services.displayManager.enable = true;
  services.displayManager.sddm = {
    enable = true;
    theme = "sugar-candy";
    extraPackages = with pkgs; [
      sddm-sugar-candy
      qt5.qtgraphicaleffects
      qt5.qtquickcontrols2
      qt5.qtsvg
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
