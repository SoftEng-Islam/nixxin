{ settings, pkgs, ... }: {
  imports = [ ./cava.nix ./codex.nix ./feh.nix ./mpv.nix ./rnnoise.nix ];
  services = {
    radarr = {
      enable = false;
      user = "root";
      group = "users";
      openFirewall = true;
    };
    sonarr = {
      enable = false;
      user = "root";
      group = "users";
      openFirewall = true;
    };
    bazarr = {
      enable = false;
      user = "root";
      group = "users";
      openFirewall = true;
    };
    prowlarr = {
      enable = false;
      openFirewall = true;
    };
    deluge = {
      enable = false;
      web.enable = true;
      user = "root";
      group = "users";
      openFirewall = true;
      web.openFirewall = true;
    };
  };

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
    # audio control
    pulsemixer
    pwvucontrol
    loupe # Simple image viewer application written with GTK4 and Rust
    celluloid # Simple GTK frontend for the mpv video player
  ];
}
