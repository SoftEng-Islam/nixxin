{ pkgs, ... }: {
  # Download Managers & CLI Downloads Utility

  environment.systemPackages = with pkgs; [
    # CLI Tools
    aria2 # Lightweight, multi-protocol, multi-source, command-line download utility
    axel # Console downloading program
    curl # A command line tool for transferring files with URL syntax
    lux # Fast and simple video download library and CLI tool written in Go
    wget2 # Successor of GNU Wget, a file and recursive website downloader
    yt-dlp # Command-line tool to download videos from YouTube.com and other sites (youtube-dl fork)

    # uget # Download manager using GTK and libcurl
    # fragments # Easy to use BitTorrent client for the GNOME desktop environment
    motrix # Full-featured download manager
    qbittorrent # Featureful free software BitTorrent client
    qbittorrent-enhanced # Unofficial enhanced version of qBittorrent, a BitTorrent client
    qbittorrent-nox # Featureful free software BitTorrent client

    ariang # Modern web frontend making aria2 easier to use
    media-downloader # Qt/C++ GUI front end for yt-dlp and others
    persepolis # GUI for aria2
    varia # Simple download manager based on aria2 and libadwaita
  ];
}
