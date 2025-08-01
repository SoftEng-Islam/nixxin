{ settings, config, lib, pkgs, ... }:
let
  inherit (lib) optionals mkIf;
  _pkgs = with pkgs; [
    # Console downloading program
    (lib.optional settings.modules.data_transferring.axel.enable axel)
    # Fast and simple video download library and CLI tool written in Go
    (lib.optional settings.modules.data_transferring.lux.enable lux)
    # Successor of GNU Wget, a file and recursive website downloader
    (lib.optional settings.modules.data_transferring.wget2.enable wget2)
    # Command-line tool to download videos from YouTube.com and other sites (youtube-dl fork)
    (lib.optional settings.modules.data_transferring.yt-dlp.enable yt-dlp)
    # Full-featured download manager
    (lib.optional settings.modules.data_transferring.motrix.enable motrix)
    # C++ BitTorrent implementation focusing on efficiency and scalability
    (lib.optional settings.modules.data_transferring.libtorrent-rasterbar.enable
      libtorrent-rasterbar)
    # Modern web frontend making aria2 easier to use
    (lib.optional settings.modules.data_transferring.ariang.enable ariang)
    # Qt/C++ GUI front end for yt-dlp and others
    (lib.optional settings.modules.data_transferring.media-downloader.enable
      media-downloader)
    # GUI for aria2
    (lib.optional settings.modules.data_transferring.persepolis.enable persepolis)
    # Simple download manager based on aria2 and libadwaita
    (lib.optional settings.modules.data_transferring.varia.enable varia)
    # Torrent client
    (lib.optional settings.modules.data_transferring.deluge.enable deluge)

    # Streaming torrent app for Mac, Windows, and Linux
    (lib.optional settings.modules.data_transferring.webtorrent_desktop.enable
      webtorrent_desktop)

    # Torrent client
    (lib.optional settings.modules.data_transferring.transmission.enable
      transmission_4)
  ];
in {
  imports = optionals (settings.modules.data_transferring.enable or false) [
    ./curl
    ./qbittorrent
    ./aria.nix
    ./bitmagnet.nix
  ];
  config = mkIf (settings.modules.data_transferring.enable or false) {
    environment.systemPackages = lib.flatten _pkgs;
    # Download Managers & CLI Downloads Utility
    environment.variables = {
      QT_LOGGING_RULES = "qt.gui.imageio.warning=false";
      QT_NETWORK_LOGGING_RULES = "qt.network.http2.warning=false";
    };
  };
}
