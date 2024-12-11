{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ferdium # All your services in one place built by the community
    mumble # Low-latency, high quality voice chat software
    signal-desktop # Private, simple, and secure messenger
    slack # Desktop client for Slack
    zoom-us # zoom.us video conferencing application

    #__ Graphic Applications __#
    inkscape
    gimp
    blender-hip # 3D Creation/Animation/Publishing System

    # Download Manager
    motrix # Full-featured download manager
    # uget # Download manager using GTK and libcurl

    # Torrents
    qbittorrent
    qbittorrent-enhanced
    qbittorrent-nox
  ];
}
