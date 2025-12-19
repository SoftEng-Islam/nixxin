{ settings, lib, pkgs, ... }: {
  # git clone https://github.com/Shanu-Kumawat/quickshell-overview ~/.config/quickshell/overview

  home-manager.users.${settings.user.username} = {
    home.file."~/.config/quickshell/overview".source = ./overview;
  };

  environment.systemPackages = with pkgs; [
    quickshell
    libsForQt5.qt5.qtsvg
    libsForQt5.qt5.qtimageformats
    libsForQt5.qt5.qtmultimedia
    kdePackages.qt5compat
  ];
}
