{ lib, settings, pkgs, ... }:
let
  inherit (lib) mkIf;
  _imports = [
    (lib.optional settings.modules.media.celluloid ./celluloid)
    (lib.optional settings.modules.media.mpv ./mpv)
    (lib.optional settings.modules.media.cava ./cava.nix)
    (lib.optional settings.modules.media.codex ./codex.nix)
  ];
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
    (lib.optional settings.modules.media.kdenlive kdenlive)
    # ---- shotcut ---- #
    (lib.optional settings.modules.media.shotcut shotcut)
  ];

in mkIf (settings.modules.media.enable) {
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
