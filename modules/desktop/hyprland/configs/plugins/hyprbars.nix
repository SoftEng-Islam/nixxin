{
  settings,
  lib,
  pkgs,
  ...
}:

{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      # Keep the plugin in the array so Home Manager installs and loads it
      plugins = [ pkgs.hyprlandPlugins.hyprbars ];

      # Inject raw Lua code at the bottom of hyprland.lua
      extraConfig = ''
        local noctalia = require("noctalia")

        if hl.plugin.hyprbars ~= nil then
          -- 1. Apply general hyprbars settings using Noctalia colors
          hl.config({
            plugin = {
              hyprbars = {
                bar_height = 35,
                bar_color = noctalia.colors.surface,
                ["col.text"] = noctalia.colors.on_surface,
                bar_text_font = "Sans",
                -- Title Text Improvements
                bar_text_font = "JetBrainsMono Nerd Font", -- Change this to your preferred system font
                bar_text_size = 12,
                bar_text_align = "left", -- Options: "left", "center", "right"
                bar_padding = 15,        -- Adds breathing room around the text
              }
            }
          })

          -- 2. Close Button (Rightmost)
          hl.plugin.hyprbars.add_button({
            bg_color = noctalia.colors.error,
            fg_color = noctalia.colors.on_error,
            size = 20,
            icon = "X",
            action = "hyprctl dispatch killactive"
          })

          -- 3. Fullscreen/Maximize Button (Middle)
          hl.plugin.hyprbars.add_button({
            bg_color = noctalia.colors.primary,
            fg_color = noctalia.colors.surface, -- Use surface color for contrast
            size = 20,
            icon = "=",
            action = "hyprctl dispatch fullscreen 1"
          })

          -- 4. Float/Minimize Button (Leftmost)
          hl.plugin.hyprbars.add_button({
            bg_color = noctalia.colors.secondary,
            fg_color = noctalia.colors.surface, -- Use surface color for contrast
            size = 20,
            icon = "~",
            action = "hyprctl dispatch togglefloating"
          })
        end
      '';
    };
  };
}
