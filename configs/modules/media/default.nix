{ settings, pkgs, ... }: {
  imports = [
    # ./cava.nix
    ./codex.nix
    ./feh.nix
    ./rnnoise.nix
  ];

  environment.systemPackages = with pkgs; [
    # Audio Control
    pulsemixer
    pwvucontrol
    loupe # Simple image viewer application written with GTK4 and Rust
    celluloid # Simple GTK frontend for the mpv video player
  ];
}
