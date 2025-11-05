{ settings, lib, pkgs, ... }: {
  # https://man.finalrewind.org/1/feh
  # ------------------------------------
  # Feh - A fast and light image viewer.
  # ------------------------------------
  home-manager.users.${settings.user.username} = {
    programs.feh = {
      enable = true;
      package = pkgs.feh;
      buttons = {
        prev_img = [ 3 "C-3" ];
        zoom_in = 4;
        zoom_out = "C-4";
      };
      themes = {
        booth = [ "--full-screen" "--hide-pointer" "--slideshow-delay" "20" ];
        example = [ "--info" "foo bar" ];
        feh = [ "--image-bg" "black" ];
        imagemap = [
          "-rVq"
          "--thumb-width"
          "40"
          "--thumb-height"
          "30"
          "--index-info"
          "%n\\n%wx%h"
        ];
        present = [ "--full-screen" "--sort" "name" "--hide-pointer" ];
        webcam = [ "--multiwindow" "--reload" "20" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # https://gitlab.gnome.org/GNOME/eog
    eog

    #  https://gitlab.gnome.org/GNOME/loupe
    loupe # Simple image viewer application written with GTK4 and Rust

    # https://github.com/lxqt/lximage-qt/
  ];
}
