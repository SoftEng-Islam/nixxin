{ settings, pkgs, ... }: {
  imports = [
    # ./cava.nix
    ./codex.nix
    ./feh.nix
    ./mpv.nix
    ./rnnoise.nix
  ];

  # literally can't be bothered anymore with user permissions.
  # So everything with root, add permissions 775 with group users in radarr and sonarr
  # (Under Media Management - Show Advanced | Under Subtitles)
  # Radarr & Sonarr: chmod 775
  # Bazarr: chmod 664
  # Prowlarr should just work
  # Deluge:
  #   Connection Manager: localhost:58846
  #   Preferences: Change download folder and enable Plugins-label

  environment.systemPackages = with pkgs; [
    # Audio Control
    pulsemixer
    pwvucontrol
    loupe # Simple image viewer application written with GTK4 and Rust
    celluloid # Simple GTK frontend for the mpv video player
  ];
}
