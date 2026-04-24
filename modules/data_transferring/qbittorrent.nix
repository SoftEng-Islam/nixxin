{
  settings,
  lib,
  pkgs,
  ...
}:
let
  # Keep this in sync with qBittorrent's Session\\Port in
  # ~/.config/qBittorrent/qBittorrent.conf.
  torrentPort = 21750;
in
lib.mkIf (settings.modules.data_transferring.qbittorrent.enable or false) {
  networking.firewall.allowedTCPPorts = [ torrentPort ];
  networking.firewall.allowedUDPPorts = [ torrentPort ];

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
}
