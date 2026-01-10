{ settings, config, lib, pkgs, ... }:
let
  inherit (lib) optionals mkIf optional;
  data = settings.modules.data_transferring;
  _pkgs = with pkgs; [
    # Console downloading program
    (optional data.axel.enable axel)
    # Fast and simple video download library and CLI tool written in Go
    (optional data.lux.enable lux)
    # Successor of GNU Wget, a file and recursive website downloader
    (optional data.wget2.enable wget2)
    # Full-featured download manager
    (optional data.motrix.enable motrix)
    # C++ BitTorrent implementation focusing on efficiency and scalability
    (optional data.libtorrent-rasterbar.enable libtorrent-rasterbar)
    # Modern web frontend making aria2 easier to use
    (optional data.ariang.enable ariang)
    # Qt/C++ GUI front end for yt-dlp and others
    (optional data.media-downloader.enable media-downloader)
    # GUI for aria2
    (optional data.persepolis.enable persepolis)
    # Simple download manager based on aria2 and libadwaita
    (optional data.varia.enable varia)
    # Torrent client
    (optional data.deluge.enable deluge)
    # Streaming torrent app for Mac, Windows, and Linux
    (optional data.webtorrent_desktop.enable webtorrent_desktop)
    # Torrent client
    (optional data.transmission.enable transmission_4-gtk)
  ];
in {
  imports = optionals (data.enable or false) [
    ./curl
    ./qbittorrent
    ./aria.nix
    ./bitmagnet.nix
    ./torrent.nix
    ./yt-dlp.nix
  ];
  config = mkIf (settings.modules.data_transferring.enable or false) {
    environment.systemPackages = with pkgs;
      [
        # vdhcoapp
      ] ++ lib.flatten _pkgs;
    # Download Managers & CLI Downloads Utility
    environment.variables = {
      QT_LOGGING_RULES = "qt.gui.imageio.warning=false";
      QT_NETWORK_LOGGING_RULES = "qt.network.http2.warning=false";
    };
  };
}
