{ pkgs, ... }: {
  # Download Managers & CLI Downloads Utility
  services = { aria2.enable.rpcSecretFile = true; };
  environment.systemPackages = with pkgs; [
    aria2 # Lightweight, multi-protocol, multi-source, command-line download utility
    ariang # Modern web frontend making aria2 easier to use
    axel # Console downloading program
    curl # A command line tool for transferring files with URL syntax
    fragments # Easy to use BitTorrent client for the GNOME desktop environment
    lux # Fast and simple video download library and CLI tool written in Go
    media-downloader # Qt/C++ GUI front end for yt-dlp and others
    motrix # Full-featured download manager
    persepolis # GUI for aria2
    qbittorrent # Featureful free software BitTorrent client
    qbittorrent-enhanced # Unofficial enhanced version of qBittorrent, a BitTorrent client
    qbittorrent-nox # Featureful free software BitTorrent client
    uget # Download manager using GTK and libcurl
    varia # Simple download manager based on aria2 and libadwaita
    wget2 # Successor of GNU Wget, a file and recursive website downloader
    yt-dlp # Command-line tool to download videos from YouTube.com and other sites (youtube-dl fork)
  ];
}
