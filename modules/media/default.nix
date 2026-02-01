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
    nixpkgs.overlays = [
      (self: prev: { # Patch foot with an option that allows per-monitor scaling, so that DPI and stuff isn't so horrible.
        handbrake = prev.handbrake.overrideAttrs (old: rec {
          # version = "1.16.2"; # maybe lock version
          configureFlags = old.configureFlags ++ [ "--enable-vce" ];
          buildInputs = old.buildInputs
            ++ [ prev.amf-headers ]; # maybe provide radeon-like interface?
          # seb: NOTE this isn't going to work without actually having amf installed. Also handbrake appears to ignore this flag.
        });
      })
    ];
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

        (handbrake.override {
          useFfmpeg = true;
        }) # Tool for converting video files and ripping DVDs
        libmkv # Matroska (MKV) media container manipulation tools
        exiftool
      ];
  };
}
