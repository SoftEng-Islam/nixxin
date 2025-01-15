{ settings, pkgs, ... }: {
  environment.variables = {
    # Enable automatic screen scaling for Qt applications
    QT_AUTO_SCREEN_SCALE_FACTOR = "2";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_PLATFORM_PLUGIN = "wayland";
    # Set the scale factor for Qt applications
    QT_SCALE_FACTOR = "2";
    # Force QT to use wayland
    QT_QPA_PLATFORM = "wayland";
  };
  home-manager.users.${settings.username} = {
    qt = {
      enable = true;
      platformTheme.name = settings.qtPlatformTheme;
      style.name = settings.qtStyle;
    };
  };
  environment.systemPackages = with pkgs; [
    # QT & KDE Stuff
    adwaita-qt
    adwaita-qt6
    gsettings-qt
    kdePackages.xdg-desktop-portal-kde
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5ct # Qt5 Configuration Tool
    libsForQt5.qwt
    qt5.full
    qt5.qtgraphicaleffects
    qt5.qtquickcontrols2
    qt5ct
    qt6
    qt6.qtwayland
    qt6ct
    qt6Packages.qt6ct
    qt5.qtimageformats
  ];
}
