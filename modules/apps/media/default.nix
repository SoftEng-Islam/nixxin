{ lib, settings, pkgs, ... }:
let
  inherit (lib) mkIf;
  _imports = [
    (lib.optional settings.modules.apps.media.celluloid ./celluloid)
    (lib.optional settings.modules.apps.media.mpv ./mpv)
    (lib.optional settings.modules.apps.media.cava ./cava.nix)
    (lib.optional settings.modules.apps.media.codex ./codex.nix)
  ];
  _pkgs = with pkgs; [
    # ---- VLC ---- #
    (lib.optional settings.modules.apps.media.vlc vlc)
    # ---- clapper ---- #
    (lib.optional settings.modules.apps.media.clapper clapper)
    # ---- glide ---- #
    (lib.optional settings.modules.apps.media.glide glide-media-player)
    # ---- jellyfin ---- #
    (lib.optional settings.modules.apps.media.jellyfin jellyfin-media-player)
    # ---- kdenlive ---- #
    (lib.optional settings.modules.apps.media.kdenlive kdenlive)
    # ---- shotcut ---- #
    (lib.optional settings.modules.apps.media.shotcut shotcut)
  ];

in mkIf (settings.modules.apps.media.enable) {
  imports = lib.flatten _imports;

  environment.systemPackages = with pkgs;
    lib.flatten _pkgs ++ [
      # Command-line utility and library for controlling media players that implement MPRIS
      playerctl

      # Audio Control
      pulsemixer
      pwvucontrol

      # Sound Player
      # recordbox
    ];
}
