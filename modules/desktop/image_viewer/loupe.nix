# https://gitlab.gnome.org/GNOME/loupe
{ pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      loupe # Simple image viewer application written with GTK4 and Rust
    ];
}
