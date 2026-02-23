{
  settings,
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  _pkgs = with pkgs; [
    # ---- VLC ---- #
    (lib.optional settings.modules.media.vlc vlc)
    # ---- clapper ---- #
    (lib.optional settings.modules.media.clapper clapper)
    # ---- glide ---- #
    (lib.optional settings.modules.media.glide glide-media-player)
    # ---- jellyfin ---- #
    (lib.optional settings.modules.media.jellyfin jellyfin-media-player)
    # ---- kdenlive ---- #
    (lib.optional settings.modules.media.kdenlive kdePackages.kdenlive)
    # ---- shotcut ---- #
    (lib.optional settings.modules.media.shotcut shotcut)
    # ---- constrict ---- #
    # Note: Constrict uses VA-API (ffmpeg *_vaapi). If GPU encoding appears to
    # fall back to CPU, validate VA-API works first (e.g. `vainfo --display drm`
    # and an `ffmpeg -vaapi_device ... -c:v h264_vaapi ...` test).
    (lib.optional (settings.modules.media.constrict or false) constrict)
  ];

in
{
  imports = lib.optionals (settings.modules.media.enable or false) [
    ./celluloid
    ./mpv
    # ./cava.nix
    ./codex.nix
    ./gstreamer.nix
    ./music.nix
    ./images.nix
    ./text.nix
  ];
  config = lib.mkIf (settings.modules.media.enable or false) {
    environment.systemPackages =
      with pkgs;
      lib.flatten _pkgs
      ++ [
        # Command-line utility and library for controlling media players that implement MPRIS
        playerctl

        # MOD playing library
        libmodplug

        # Audio Control
        pulsemixer # Cli and curses mixer for pulseaudio
        pwvucontrol # Pipewire Volume Control

        libnice
        glib.dev
        pkg-config

        libmkv # Matroska (MKV) media container manipulation tools
        exiftool

        # To Convert/Compress videos
        # handbrake
        # constrict

        # To upscale videos using AI
        # pkgs.update.video2x
      ];
  };
}
