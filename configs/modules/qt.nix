{ pkgs, ... }: {
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
    qt6.qtwayland
    qt6ct
    qt6Packages.qt6ct
  ];
}
