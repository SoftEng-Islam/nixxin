{ settings, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland.settings.plugin = {
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
        hyprbars-button = "rgb(DCE3EE), 13, 󰖭, hyprctl dispatch killactive;";
        hyprbars-button = "rgb(DCE3EE), 13, 󰖯, hyprctl dispatch fullscreen 1;";
        hyprbars-button =
          "rgb(DCE3EE), 13, 󰖰, hyprctl dispatch movetoworkspacesilent special;";
      };
    };
  };
}
