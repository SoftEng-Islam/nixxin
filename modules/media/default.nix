{ settings, config, lib, pkgs, ... }:
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
  ];

in {
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
    environment.systemPackages = with pkgs;
      lib.flatten _pkgs ++ [
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
      ];
  };
}
