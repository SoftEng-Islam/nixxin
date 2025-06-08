{ settings, pkgs, ... }:
let _qt_gtk = settings.common.qt;
in {
  environment.variables = {
    # Enable automatic screen scaling for Qt apps
    QT_AUTO_SCREEN_SCALE_FACTOR = _qt_gtk.SCALE_FACTOR;
    QT_SCALE_FACTOR = _qt_gtk.SCALE_FACTOR;
    QT_QPA_PLATFORMTHEME = _qt_gtk.QT_QPA_PLATFORMTHEME;
    #  QT_PLATFORM_PLUGIN = "wayland";
    # Set the scale factor for Qt apps
    # Force QT to use wayland
    QT_QPA_PLATFORM = "wayland";
  };
  home-manager.users.${settings.user.username} = {
    qt = {
      enable = true;
      platformTheme.name = _qt_gtk.platformTheme;
      style.name = _qt_gtk.style;
    };
  };
  environment.systemPackages = with pkgs; [
    # QT & KDE Stuff
    adwaita-qt
    adwaita-qt6
    gsettings-qt
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5ct # Qt5 Configuration Tool
    libsForQt5.qwt
    qt5.qtgraphicaleffects
    qt5.qtimageformats
    qt5.qtquickcontrols2
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtsvg
    qt6.qtwayland
  ];
}
