{ settings, pkgs, ... }: {
  environment.variables = {
    #for kde theming support
    QT_PLUGIN_PATH = [
      "${pkgs.libsForQt5.qqc2-desktop-style}/${pkgs.libsForQt5.qtbase.qtPluginPrefix}"
      "${pkgs.kdePackages.qqc2-desktop-style}/${pkgs.qt6Packages.qtbase.qtPluginPrefix}"
    ];
    QML2_IMPORT_PATH = [
      "${pkgs.libsForQt5.qqc2-desktop-style}/${pkgs.libsForQt5.qtbase.qtQmlPrefix}"
      "${pkgs.kdePackages.qqc2-desktop-style}/${pkgs.kdePackages.qtbase.qtQmlPrefix}"
    ];
  };
}
