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
    (lib.optional settings.modules.media.kdenlive kdenlive)
    # ---- shotcut ---- #
    (lib.optional settings.modules.media.shotcut shotcut)
  ];

in {
  imports = lib.optionals (settings.modules.media.enable) [
    ./celluloid
    ./mpv
    ./cava.nix
    ./codex.nix
    ./music.nix
  ];
  config = lib.optionals (settings.modules.media.enable) {
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
  };
}
