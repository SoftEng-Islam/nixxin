{ settings, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # https://gitlab.gnome.org/GNOME/eog
    eog

    #  https://gitlab.gnome.org/GNOME/loupe
    loupe # Simple image viewer application written with GTK4 and Rust

    # https://github.com/lxqt/lximage-qt/
  ];
}
