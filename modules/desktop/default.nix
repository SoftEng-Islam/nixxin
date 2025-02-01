{ settings, pkgs, ... }: {
  imports = [
    ./editors
    ./fileManager
    ./graphics
    ./image_viewer
    ./media
    ./notification_daemon
    ./qbittorrent
    ./applications.nix
    ./data-transferring.nix
    ./gaming.nix
    ./misc.nix
    ./wine.nix
  ];
}
