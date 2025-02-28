{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Featureful free software BitTorrent client
    # nix build nixpkgs#qbittorrent --print-out-paths --no-link
    qbittorrent
    (writeShellScriptBin "qbittorrent" ''
      export QT_LOGGING_RULES="qt.gui.imageio.warning=false"
      export QT_NETWORK_LOGGING_RULES="qt.network.http2.warning=false"
      exec ${qbittorrent}/bin/qbittorrent "$@"
      # exec ${qbittorrent}/bin/.qbittorrent-wrapped "$@"
    '')
  ];
  home-manager.users.${settings.user.username} = {
    home.file.".qbittorrent/".source = ./dist;
  };
}
