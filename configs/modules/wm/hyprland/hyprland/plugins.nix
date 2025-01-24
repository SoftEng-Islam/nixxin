{ inputs, settings, pkgs, ... }: {
  # imports = [ ./plugins/hyprspace.nix ];
  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland.plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprtrails
      inputs.hyprland-plugins.packages.${pkgs.system}.borders-plus-plus
    ];
    wayland.windowManager.hyprland.extraConfig = ''

      plugin:hyprtrails {
        color = rgba(ffaa00ff)
      }
      plugin:borders-plus-plus {
        add_borders = 1 # 0 - 9

        # You can add up to 9 borders
        col.border_1 = rgb(ffffff)
        col.border_2 = rgb(000000)

        # -1 means "default" as in the one defined in general:border_size
        border_size_1 = 2
        border_size_2 = 2

        # makes outer edges match rounding of the parent. turn on/off to better understand. default = on.
        natural_rounding = yes
      }

      # ------------------ #
      # ---- hyprexpo ---- #
      # ------------------ #
      # plugin:hyprexpo {
      #   columns = 3
      #   gap_size = 5
      #   bg_col = rgb(111111)

      #   # [center/first] [workspace] e.g. first 1 or center m+1
      #   workspace_method = center current

      #   enable_gesture = true # laptop touchpad
      #   gesture_fingers = 3 # 3 or 4
      #   gesture_distance = 300 # how far is the "max"
      #   gesture_positive = true # positive = swipe down. Negative = swipe up.
      # }
      # ------------------ #
      # ---- hyprbars ---- #
      # ------------------ #
      plugin:hyprbars {
        # Honestly idk if it works like css, but well, why not
        bar_text_font = "${settings.fontName}"
        bar_text_size = ${toString settings.fontSize}
        bar_height = 40
        bar_padding = 15
        bar_button_padding = 5
        bar_precedence_over_border = true
        bar_part_of_window = true
        bar_color = rgba(0D141BFF)
        col.text = rgba(DCE3EEFF)
        # example buttons (R -> L)
        # hyprbars-button = color, size, on-click
        hyprbars-button = rgb(B91C1C), 20, , hyprctl dispatch killactive
        hyprbars-button = rgb(15803D), 20, , hyprctl dispatch fullscreen 1
        hyprbars-button = rgb(7E22CE), 20, , hyprctl dispatch togglefloating
      }
    '';
  };
}
