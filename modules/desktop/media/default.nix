# ---- Media Players ---- #
# mpv is a free and open-source general-purpose video player, based on the MPlayer and mplayer2 projects, with great improvements above both.
{ lib, settings, pkgs, ... }:
let
  mpvPlayer = lib.optional settings.system.mediaPlayers.mpv
    (pkgs.mpv.override { scripts = [ pkgs.mpvScripts.mpris ]; });

in {
  imports = [ ./cava.nix ./codex.nix ./rnnoise.nix ./mpv ];

  environment.systemPackages = with pkgs; [
    # Audio Control
    pulsemixer
    pwvucontrol

    # Command-line utility and library for controlling media players that implement MPRIS
    playerctl

    celluloid

    vlc
    # Simple GTK frontend for the mpv video player
    # (if settings.system.mediaPlayers.celluloid then celluloid else "")

    # Cross-platform media player and streaming server
    # (if settings.system.mediaPlayers.vlc then vlc else "")

    # A GNOME media player built using GTK4 toolkit and powered by GStreamer with OpenGL rendering
    # (if settings.system.mediaPlayers.clapper then clapper else "")

    # Linux/macOS media player based on GStreamer and GTK
    # (if settings.system.mediaPlayers.glide then glide-media-player else "")

    # Jellyfin Desktop Client based on Plex Media Player
    # (if settings.system.mediaPlayers.jellyfin then
    #   jellyfin-media-player
    # else
    #   "")

    # ---- Video Editors ---- #
    # (if settings.system.videoEditors.kdenlive then kdenlive else "")
    # (if settings.system.videoEditors.shotcut then shotcut else "")
  ];
}
