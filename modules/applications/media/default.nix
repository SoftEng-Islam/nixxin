{ lib, settings, pkgs, ... }:
let
  inherit (lib) mkIf;
  _imports = [
    (lib.optional settings.modules.applications.media.celluloid ./celluloid)
    (lib.optional settings.modules.applications.media.mpv ./mpv)
    (lib.optional settings.modules.applications.media.cava ./cava.nix)
    (lib.optional settings.modules.applications.media.codex ./codex.nix)
  ];
  _pkgs = with pkgs; [
    # ---- VLC ---- #
    (lib.optional settings.modules.applications.media.vlc vlc)
    # ---- clapper ---- #
    (lib.optional settings.modules.applications.media.clapper clapper)
    # ---- glide ---- #
    (lib.optional settings.modules.applications.media.glide glide-media-player)
    # ---- jellyfin ---- #
    (lib.optional settings.modules.applications.media.jellyfin
      jellyfin-media-player)
    # ---- kdenlive ---- #
    (lib.optional settings.modules.applications.media.kdenlive kdenlive)
    # ---- shotcut ---- #
    (lib.optional settings.modules.applications.media.shotcut shotcut)
  ];

in mkIf (settings.modules.applications.media.enable) {
  imports = lib.flatten _imports;

  environment.systemPackages = with pkgs;
    lib.flatten _pkgs ++ [
      # Command-line utility and library for controlling media players that implement MPRIS
      playerctl

      # Audio Control
      pulsemixer
      pwvucontrol
    ];
}
