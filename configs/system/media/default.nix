{ pkgs, ... }: {
  home-manager.users.${settings.username} = {

    imports = [ ./mpv.nix ./rnnoise.nix ];
    home.packages = with pkgs; [
      # audio control
      pulsemixer
      pwvucontrol
      loupe # Simple image viewer application written with GTK4 and Rust
      celluloid # Simple GTK frontend for the mpv video player
    ];
  };
}
