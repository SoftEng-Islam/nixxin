{ pkgs, ... }:
# let
#   defaultFont =
#     "${config.gtk.font.name},${builtins.toString config.gtk.font.size}";
# in
{
  qt = {
    enable = true;
    platformTheme.name = "qtct";

    # platformTheme = "gtk";
    # style.name = "adwaita-dark";
    # style.package = pkgs.adwaita-qt;
  };

  home.packages = [
    pkgs.qt6Packages.qtstyleplugin-kvantum
    pkgs.qt6Packages.qt6ct
    pkgs.libsForQt5.qtstyleplugin-kvantum
    pkgs.libsForQt5.qt5ct
  ];
  xdg.configFile = {
    # qtct config
    "qt5ct/qt5ct.conf".text = "";
    "qt6ct/qt6ct.conf".text = "";
  };
}
