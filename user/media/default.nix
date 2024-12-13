{ pkgs, ... }:
# media - control and enjoy audio/video
{
  imports = [ ./mpv.nix ./rnnoise.nix ];

  home.packages = with pkgs; [
    # audio control
    pulsemixer
    pwvucontrol

    # audio
    # amberol # Small and simple sound and music player
    # spotify

    # images
    loupe # Simple image viewer application written with GTK4 and Rust
    # videos
    celluloid # Simple GTK frontend for the mpv video player

  ];

}
