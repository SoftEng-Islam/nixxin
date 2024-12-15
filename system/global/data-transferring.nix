{ pkgs, ... }: {
  services = { aria2.enable = true; };
  environment.systemPackages = with pkgs; [
    # download managers
    motrix # Full-featured download manager
    # uget # Download manager using GTK and libcurl
    # fragments
    # Torrents
    qbittorrent
    qbittorrent-enhanced
    qbittorrent-nox

    curl # A command line tool for transferring files with URL syntax
    wget # Tool for retrieving files using HTTP, HTTPS, and FTP
    lux # Fast and simple video download library and CLI tool written in Go
    yt-dlp # Command-line tool to download videos from YouTube.com and other sites (youtube-dl fork)
    aria2
    varia
    persepolis
    ariang
    media-downloader
    # CLI Downloads Utility
    aria2
    axel
    curl
    wget2
    media-downloader
  ];
}
