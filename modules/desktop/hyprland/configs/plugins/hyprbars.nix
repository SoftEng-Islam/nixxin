{
  settings,
  libs,
  pkgs,
  ...
}:
let
  inherit (libs.hyprland.utils) hlDispatch;

  closeWindow = hlDispatch "hl.dsp.window.close()";
  toggleMaximize = hlDispatch "hl.dsp.window.fullscreen({ mode = 'maximized', action = 'toggle' })";
  toggleFloat = hlDispatch "hyprctl dispatch togglefloating";
in
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      # The package
      plugins = [ pkgs.hyprlandPlugins.hyprbars ];

      # The Plugin Settings
      settings.config.plugin.hyprbars = {
        bar_height = 20;
        on_double_click = toggleMaximize;
      };

      # The buttons options
      extraConfig = ''
        hl.plugin.hyprbars.add_button({ bg_color = "rgb(ff4040)", fg_color = "rgb(ffffff)", size = 10, icon = "", action = ${builtins.toJSON closeWindow} })
        hl.plugin.hyprbars.add_button({ bg_color = "rgb(eeee11)", fg_color = "rgb(000000)", size = 10, icon = "", action = ${builtins.toJSON toggleMaximize} })
        hl.plugin.hyprbars.add_button({ bg_color = "rgb(eeee11)", fg_color = "rgb(000000)", size = 10, icon = "", action = ${builtins.toJSON toggleFloat} })
      '';
    };
  };
}
