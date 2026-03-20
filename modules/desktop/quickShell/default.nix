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

  environment.systemPackages = with pkgs; [
    quickshell
    libsForQt5.qt5.qtsvg
    libsForQt5.qt5.qtimageformats
    libsForQt5.qt5.qtmultimedia
    kdePackages.qt5compat
    qt6.qt5compat
    qt6.qtdeclarative
    libsForQt5.qt5.qtgraphicaleffects
  ];
}
