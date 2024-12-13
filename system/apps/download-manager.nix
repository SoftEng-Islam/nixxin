{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    motrix # Full-featured download manager
    # uget # Download manager using GTK and libcurl
    # fragments

    # Torrents
    qbittorrent
    qbittorrent-enhanced
    qbittorrent-nox
  ];
}

