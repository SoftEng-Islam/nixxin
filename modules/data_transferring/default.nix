{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _imports = [
    # A command line tool for transferring files with URL syntax
    (lib.optional settings.modules.data_transferring.curl ./curl)

    # Featureful free software BitTorrent client
    (lib.optional settings.modules.data_transferring.qbittorrent ./qbittorrent)

    # Lightweight, multi-protocol, multi-source, command-line download utility
    (lib.optional settings.modules.data_transferring.aria2 ./aria.nix)
  ];
  _pkgs = with pkgs; [
    # Console downloading program
    (lib.optional settings.modules.data_transferring.axel axel)
    # Fast and simple video download library and CLI tool written in Go
    (lib.optional settings.modules.data_transferring.lux lux)
    # Successor of GNU Wget, a file and recursive website downloader
    (lib.optional settings.modules.data_transferring.wget2 wget2)
    # Command-line tool to download videos from YouTube.com and other sites (youtube-dl fork)
    (lib.optional settings.modules.data_transferring.yt-dlp yt-dlp)
    # Full-featured download manager
    (lib.optional settings.modules.data_transferring.motrix motrix)
    # C++ BitTorrent implementation focusing on efficiency and scalability
    (lib.optional settings.modules.data_transferring.libtorrent-rasterbar
      libtorrent-rasterbar)
    # Modern web frontend making aria2 easier to use
    (lib.optional settings.modules.data_transferring.ariang ariang)
    # Qt/C++ GUI front end for yt-dlp and others
    (lib.optional settings.modules.data_transferring.media-downloader
      media-downloader)
    # GUI for aria2
    (lib.optional settings.modules.data_transferring.persepolis persepolis)
    # Simple download manager based on aria2 and libadwaita
    (lib.optional settings.modules.data_transferring.varia varia)
  ];
in mkIf (settings.modules.data_transferring.enable) {
  imports = lib.flatten _imports;
  environment.systemPackages = lib.flatten _pkgs;

  # Download Managers & CLI Downloads Utility
  environment.variables = {
    QT_LOGGING_RULES = "qt.gui.imageio.warning=false";
    QT_NETWORK_LOGGING_RULES = "qt.network.http2.warning=false";
  };
}
