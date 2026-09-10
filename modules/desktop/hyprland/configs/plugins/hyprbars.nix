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
        if hl.plugin.hyprbars ~= nil then
          -- 1. Apply general hyprbars settings
          hl.config({
            plugin = {
              hyprbars = {
                bar_height = 35,
                bar_color = "rgb(2a2a2a)",
                bar_text_font = "Sans",
              }
            }
          })

          -- 2. Add buttons using the dedicated Lua function
          hl.plugin.hyprbars.add_button({
            bg_color = "rgb(ff4040)",
            fg_color = "rgb(ffffff)",
            size = 12,
            icon = "X",
            action = "hyprctl dispatch 'hl.dsp.window.close()'"
          })

          hl.plugin.hyprbars.add_button({
            bg_color = "rgb(eeee11)",
            fg_color = "rgb(000000)",
            size = 12,
            icon = "_",
            action = "hyprctl dispatch 'hl.dsp.window.fullscreen(1)'"
          })
        end
      '';
    };
  };
}
