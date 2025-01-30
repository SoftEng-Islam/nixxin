{ settings, pkgs, ... }: {
  imports = [
    # ./discord
    # ./document_viewer
    ./editors
    # ./emails
    # ./emoji_handlers
    ./fileManager
    ./media
    ./notification_daemon
    # ./OSD
    # ./OSK
    ./qbittorrent
    # ./remote_workstation
    # ./screen_casting
    # ./screen_recording
    # ./screen_sharing
    # ./web_browsers
    ./applications.nix
    # ./beesd.nix
    ./data-transferring.nix
    ./gaming.nix
    ./misc.nix
    # ./printing.nix
    # ./productivity.nix
    # ./swhkd.nix
    ./wine.nix
    # ./wl-mirror.nix
    # ./wlhc.nix
  ];
}
