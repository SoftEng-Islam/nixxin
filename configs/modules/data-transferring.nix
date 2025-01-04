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

    motrix # Full-featured download manager
    qbittorrent # Featureful free software BitTorrent client
    libtorrent-rasterbar # C++ BitTorrent implementation focusing on efficiency and scalability
    ariang # Modern web frontend making aria2 easier to use
    media-downloader # Qt/C++ GUI front end for yt-dlp and others
    persepolis # GUI for aria2
    varia # Simple download manager based on aria2 and libadwaita
  ];
}
