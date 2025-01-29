{ settings, pkgs, ... }: {
  imports = [
    # ./cava.nix
    ./codex.nix
    ./feh.nix
    ./rnnoise.nix
  ];

  environment.systemPackages = with pkgs; [
    # Audio Control
    pulsemixer
    pwvucontrol

    celluloid # Simple GTK frontend for the mpv video player
    # Media Players
    (mpv.override { scripts = [ mpvScripts.mpris ]; })
    # clapper # A GNOME media player built using GTK4 toolkit and powered by GStreamer with OpenGL rendering
    # glide-media-player # Linux/macOS media player based on GStreamer and GTK
    # jellyfin-media-player # Jellyfin Desktop Client based on Plex Media Player
    playerctl # Command-line utility and library for controlling media players that implement MPRIS
    vlc # Cross-platform media player and streaming server

  ];
}
