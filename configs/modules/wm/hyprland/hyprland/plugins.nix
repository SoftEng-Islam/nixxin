{ inputs, settings, pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
    ];
  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland.plugins = [
      inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
    ];
    wayland.windowManager.hyprland.settings.plugin = {
      hyprexpo = {
        columns = 3;
        gap_size = 5;
        bg_col = "rgb(111111)";
        workspace_method =
          "center current"; # [center/first] [workspace] e.g. first 1 or center m+1
        enable_gesture = true; # laptop touchpad
        gesture_fingers = 3; # 3 or 4
        gesture_distance = 300; # how far is the "max"
        gesture_positive = true; # positive = swipe down. Negative = swipe up.
      };
      hyprbars = {
        # Honestly idk if it works like css, but well, why not
        bar_text_font = "${settings.fontName}";
        bar_height = 30;
        bar_padding = 10;
        bar_button_padding = 5;
        bar_precedence_over_border = true;
        bar_part_of_window = true;
        bar_color = "rgba(0D141BFF)";
        col.text = "rgba(DCE3EEFF)";
        # example buttons (R -> L)
        # hyprbars-button = color, size, on-click
        # hyprbars-button = "rgb(DCE3EE), 13, 󰖭, hyprctl dispatch killactive;";
        # hyprbars-button = "rgb(DCE3EE), 13, 󰖯, hyprctl dispatch fullscreen 1;";
        # hyprbars-button = "rgb(DCE3EE), 13, 󰖰, hyprctl dispatch movetoworkspacesilent special;";
      };
    };
  };
}
