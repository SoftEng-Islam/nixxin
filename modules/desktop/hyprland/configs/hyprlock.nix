{ settings, pkgs, ... }: {
  home-manager.users.${settings.user.username} = {
    programs.hyprlock = {
      enable = settings.modules.desktop.hyprland.lockscreen.enable or false;
      settings = {
        general = {
          hide_cursor = true;
          no_fade_in = false;
          disable_loading_bar = true;
          grace = 0;
        };
        background = [{
          monitor = "";
          path = "~/Pictures/lockScreen.png";
          color = "rgba(25, 20, 20, 1.0)";
          blur_size = 0;
          blur_passes = 2;
          contrast = 0.9;
          brightness = 0.5;
          vibrancy = 0.17;
          vibrancy_darkness = 0;
        }];
        input-field = [{
          monitor = "";
          size = "250, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(0, 0, 0, 0.5)";
          font_color = "rgb(200, 200, 200)";
          fade_on_empty = false;
          placeholder_text =
            ''<i><span foreground="##cdd6f4">Input Password...</span></i>'';
          hide_input = false;
          position = "0, -120";
          halign = "center";
          valign = "center";
        }];
        label = [{
          monitor = "";
          text = "$TIME";
          font_size = 120;
          position = "0, 80";
          valign = "center";
          halign = "center";
        }];
      };
    };
  };
  environment.systemPackages = with pkgs; [ hyprlock ];
}
