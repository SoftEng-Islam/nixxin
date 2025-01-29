{ settings, pkgs, ... }: {
  home-manager.users.${settings.users.selected.username} = {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          hide_cursor = true;
          no_fade_in = false;
          disable_loading_bar = true;
          grace = 0;
        };
        # background = [{
        #   monitor = "";
        #   path = "$HOME/.cache/ignis/wallpaper";
        #   color = "rgba(25, 20, 20, 1.0)";
        #   blur_size = 0;
        #   blur_passes = 2;
        #   contrast = 0.9;
        #   brightness = 0.5;
        #   vibrancy = 0.17;
        #   vibrancy_darkness = 0;
        # }];
        # input-field = [{
        #   monitor = "";
        #   size = "250, 60";
        #   outline_thickness = 2;
        #   dots_size = 0.2;
        #   dots_spacing = 0.2;
        #   dots_center = true;
        #   outer_color = "rgba(0, 0, 0, 0)";
        #   inner_color = "rgba(0, 0, 0, 0.5)";
        #   font_color = "rgb(200, 200, 200)";
        #   fade_on_empty = false;
        #   placeholder_text =
        #     ''<i><span foreground="##cdd6f4">Input Password...</span></i>'';
        #   hide_input = false;
        #   position = "0, -120";
        #   halign = "center";
        #   valign = "center";
        # }];
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
}

# # INPUT FIELD
# input-field {
#     monitor =
#     size = 300, 40
#     outline_thickness = 2
#     dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
#     dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
#     dots_center = true
#     outer_color = $surface
#     inner_color = $surface
#     font_color = $onSurface
#     fade_on_empty = false
#     placeholder_text =
#     hide_input = false
#     position = 0, 150
#     halign = center
#     valign = bottom
# }

# # Hour-Time
# label {
#     monitor =
#     text = cmd[update:1000] echo -e "$(date +"%H")"
#     color = $primary
#     font_family = JetBrainsMono Bold
#     font_size = 180
#     position = 0, 150
#     halign = center
#     valign = center
# }

# # Minute-Time
# label {
#     monitor =
#     text = cmd[update:1000] echo -e "$(date +"%M")"
#     color = $onSurface
#     font_family = JetBrainsMono Bold
#     font_size = 180
#     position = 0, -75
#     halign = center
#     valign = center
# }

# # Date
# label {
#     monitor =
#     text = cmd[update:1000] echo -e "$(date +"%a, %b %d")"
#     color = $onSurface
#     font_family = JetBrainsMono Bold
#     position = 100, -100
#     halign = left
#     valign = top
# }

# # Date
# label {
#     monitor =
#     text = cmd[update:1000] primaryHex=$primaryHex bash ~/.config/hypr/scripts/hyprlock-time.sh
#     color = $onSurface
#     font_family = JetBrainsMono Bold
#     position = 100, -130
#     halign = left
#     valign = top
# }
