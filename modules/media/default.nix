# ---- Media Players ---- #
# mpv is a free and open-source general-purpose video player, based on the MPlayer and mplayer2 projects, with great improvements above both.
{ lib, settings, pkgs, ... }:
let
  mediaPlayers = [
    # ---- VLC ---- #
    (lib.optional settings.system.mediaPlayers.vlc pkgs.vlc)

    # ---- clapper ---- #
    (lib.optional settings.system.mediaPlayers.clapper pkgs.clapper)

    # ---- glide ---- #
    (lib.optional settings.system.mediaPlayers.glide pkgs.glide-media-player)

    # ---- jellyfin ---- #
    (lib.optional settings.system.mediaPlayers.jellyfin
      pkgs.jellyfin-media-player)

    # ---- kdenlive ---- #
    (lib.optional settings.system.videoEditors.kdenlive pkgs.kdenlive)

    # ---- shotcut ---- #
    (lib.optional settings.system.videoEditors.shotcut pkgs.shotcut)
  ];

in {
  imports = [ ./celluloid ./cava.nix ./codex.nix ./mpv ];

  environment.systemPackages = with pkgs;
    lib.flatten mediaPlayers ++ [
      # Command-line utility and library for controlling media players that implement MPRIS
      playerctl

      # Audio Control
      pulsemixer
      pwvucontrol

    ];
}
