{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    zoom-us
    ferdium
    slack
    inkscape
    mumble
    signal-desktop
    uget
    motrix
    qbittorrent
    qbittorrent-enhanced
    qbittorrent-nox
    gimp
  ];
}
