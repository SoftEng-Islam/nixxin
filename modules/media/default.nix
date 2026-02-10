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
    # ---- constrict ---- #
    (lib.optional (settings.modules.media.constrict or false) constrict)
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
    # nixpkgs.overlays = [
    #   (self: prev: { # Patch foot with an option that allows per-monitor scaling, so that DPI and stuff isn't so horrible.
    #     handbrake = prev.handbrake.overrideAttrs (old: rec {
    #       # version = "1.16.2"; # maybe lock version
    #       configureFlags = old.configureFlags ++ [ "--enable-vce" ];
    #       buildInputs = old.buildInputs
    #         ++ [ prev.amf-headers ]; # maybe provide radeon-like interface?
    #       # seb: NOTE this isn't going to work without actually having amf installed. Also handbrake appears to ignore this flag.
    #     });
    #   })
    # ];
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

        #  if you want the gui you can change ${lib.getExe pkgs.handbrake} to ${pkgs.handbrake}/bin/ghb
        (pkgs.writeShellApplication {
          name = "handbrake";
          text = ''
            # Prefer the VA-API render node (similar to: ffmpeg -hwaccel_device ...)
            export LIBVA_DRM_DEVICE="''${LIBVA_DRM_DEVICE:-/dev/dri/renderD128}"
            export LIBVA_DRIVERS_PATH="''${LIBVA_DRIVERS_PATH:-/run/opengl-driver/lib/dri}"
            ${
              lib.optionalString (settings.common.cpu.amdGPU or false)
              ''export LIBVA_DRIVER_NAME="''${LIBVA_DRIVER_NAME:-radeonsi}"''
            }

            export LD_LIBRARY_PATH="/run/opengl-driver/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
            exec ${pkgs.handbrake}/bin/ghb "$@"
          '';
        })

        libmkv # Matroska (MKV) media container manipulation tools
        exiftool

        # video2x
        # constrict
      ];
  };
}
