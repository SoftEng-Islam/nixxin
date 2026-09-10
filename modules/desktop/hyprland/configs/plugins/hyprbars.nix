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
      plugins = [ pkgs.hyprlandPlugins.hyprbars ];

      extraConfig = ''
        local noctalia = require("noctalia")
        if hl.plugin.hyprbars then
          hl.config({
            plugin = {
              hyprbars = {
                bar_height                 = 33,
                bar_color                  = noctalia.colors.surface,
                col                        = { text = noctalia.colors.on_surface },
                bar_text_size              = 13,
                bar_text_font              = "JetBrainsMono Nerd Font",
                bar_text_align             = "center",
                bar_buttons_alignment      = "right",
                bar_part_of_window         = true,
                bar_precedence_over_border = true,
                bar_padding                = 10,
                bar_button_padding         = 10,
                icon_on_hover              = false,
                inactive_button_color      = "rgb(4d4d4d)",
                on_double_click            = "hyprctl dispatch 'hl.dsp.window.fullscreen({ mode = \"maximized\" })'",
              },
            },
          })

          -- traffic lights (leftmost first): close, maximize, float
          hl.plugin.hyprbars.add_button({
            bg_color = "rgb(ff5f57)", fg_color = "rgb(7d0f10)", size = 15, icon = "✖",
            action = "hyprctl dispatch 'hl.dsp.window.close()'",
          })

          hl.plugin.hyprbars.add_button({
            bg_color = "rgb(28c840)", fg_color = "rgb(0e650e)", size = 15, icon = "✚",
            action = "hyprctl dispatch 'hl.dsp.window.fullscreen({ mode = \"maximized\" })'",
          })

          -- Floating button (Changed from minimize)
          hl.plugin.hyprbars.add_button({
            bg_color = "rgb(febc2e)", fg_color = "rgb(90591d)", size = 15, icon = "⬒",
            action = "hyprctl dispatch 'togglefloating'",
          })

          -- no title bars on games and shell popups
          hl.window_rule({ match = { class = "^(steam_app_.*)$" },     ["hyprbars:no_bar"] = true })
          hl.window_rule({ match = { class = "^(gjs)$" },              ["hyprbars:no_bar"] = true })
          hl.window_rule({ match = { class = "^(it.mijorus.smile)$" }, ["hyprbars:no_bar"] = true })
        end
      '';
    };
  };
}
