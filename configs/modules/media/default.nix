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

    # Command-line utility and library for controlling media players that implement MPRIS
    playerctl

    # ---- Media Players ---- #
    # mpv is a free and open-source general-purpose video player, based on the MPlayer and mplayer2 projects, with great improvements above both.
    (if settings.features.mediaPlayers.mpv then
      mpv.override { scripts = [ mpvScripts.mpris ]; }
    else
      "")

    # Simple GTK frontend for the mpv video player
    (if settings.features.mediaPlayers.celluloid then celluloid else "")

    # Cross-platform media player and streaming server
    (if settings.features.mediaPlayers.vlc then vlc else "")

    # A GNOME media player built using GTK4 toolkit and powered by GStreamer with OpenGL rendering
    (if settings.features.mediaPlayers.clapper then clapper else "")

    # Linux/macOS media player based on GStreamer and GTK
    (if settings.features.mediaPlayers.glide then glide-media-player else "")

    # Jellyfin Desktop Client based on Plex Media Player
    (if settings.features.mediaPlayers.jellyfin then
      jellyfin-media-player
    else
      "")

    # ---- Video Editors ---- #
    (if settings.features.videoEditors.kdenlive then kdenlive else "")
    (if settings.features.videoEditors.shotcut then shotcut else "")
  ];
}
