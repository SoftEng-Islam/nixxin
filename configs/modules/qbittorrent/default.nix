{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      qbittorrent # Featureful free software BitTorrent client
      # (writeShellScriptBin "qbittorrent" ''
      #   export QT_LOGGING_RULES="qt.gui.imageio.warning=false"
      #   export QT_NETWORK_LOGGING_RULES="qt.network.http2.warning=false"
      #   exec /run/current-system/sw/bin/qbittorrent "$@"
      # '')
    ];
  home-manager.users.${settings.username} = {
    home.file."qbittorrent".source = ./qbittorrent/dist;
  };
}
