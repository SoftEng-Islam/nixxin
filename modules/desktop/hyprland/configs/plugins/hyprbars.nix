{
  settings,
  lib,
  pkgs,
  ...
}:

{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      plugins = [ pkgs.hyprlandPlugins.hyprbars ];

      extraConfig = ''
        local noctalia = require("noctalia")

        if hl.plugin.hyprbars ~= nil then
          hl.config({
            plugin = {
              hyprbars = {
                bar_height = 35,
                bar_color = noctalia.colors.surface,
                ["col.text"] = noctalia.colors.on_surface,
                bar_text_font = "JetBrainsMono Nerd Font",
                bar_text_size = 12,
                bar_text_align = "left",
                bar_padding = 15,
              }
            }
          })

          -- 2. Close Button
          hl.plugin.hyprbars.add_button({
            bg_color = noctalia.colors.error,
            fg_color = noctalia.colors.on_error,
            size = 20,
            icon = "X",
            on_click = "hyprctl dispatch killactive" -- Changed from 'action'
          })

          -- 3. Fullscreen/Maximize Button
          hl.plugin.hyprbars.add_button({
            bg_color = noctalia.colors.primary,
            fg_color = noctalia.colors.surface,
            size = 20,
            icon = "=",
            on_click = "hyprctl dispatch fullscreen 1" -- Changed from 'action'
          })

          -- 4. Float/Minimize Button
          hl.plugin.hyprbars.add_button({
            bg_color = noctalia.colors.secondary,
            fg_color = noctalia.colors.surface,
            size = 20,
            icon = "~",
            on_click = "hyprctl dispatch togglefloating" -- Changed from 'action'
          })
        end
      '';
    };
  };
}
