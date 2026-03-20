{
  settings,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  # git clone https://github.com/Shanu-Kumawat/quickshell-overview ~/.config/quickshell/overview
  # qs -c overview &
  # exec-once = qs -c overview
  # bind = Super, TAB, exec, qs ipc -c overview call overview toggle

  home-manager.users.${settings.user.username} = {
    home.file.".config/quickshell/overview".source = ./overview;
  };

  # For Hyprland QT Support and necessary environment variables
  environment.variables = {
    # QML_IMPORT_PATH = "${pkgs.hyprland-qt-support}/lib/qt-6/qml";
    # QML_IMPORT_PATH = "${pkgs.qt6.qt5compat}/lib/qt-6/qml:${pkgs.qt6.qtbase}/lib/qt-6/qml";
    QML2_IMPORT_PATH = "${pkgs.qt6.qt5compat}/lib/qt-6/qml:${pkgs.qt6.qtbase}/lib/qt-6/qml";
  };

  environment.systemPackages = with pkgs; [
    quickshell

    # Qt6 related kits for slove Qt5Compat problem）
    kdePackages.qt5compat
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtimageformats
    libsForQt5.qt5.qtmultimedia
    libsForQt5.qt5.qtsvg
    qt6.qt5compat
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtquick3d
    qt6.qtsvg
    qt6.qtwayland

    # alternate options
    # libsForQt5.qt5compat
    kdePackages.qt5compat
    libsForQt5.qt5.qtgraphicaleffects
  ];
}
