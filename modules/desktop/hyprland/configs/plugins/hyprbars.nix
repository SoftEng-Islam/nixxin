{
  settings,
  pkgs,
  ...
}:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      # The package
      plugins = [ pkgs.hyprlandPlugins.hyprbars ];

      # ------------------------------------------------------ hyprbars (plugin)
      # home-manager emits hl.plugin.load() at the top of hyprland.lua, but that
      # call only *registers* the path — Hyprland dlopen()s plugins after the
      # whole chunk has run and then reloads the config. So on the very first
      # pass hl.plugin.hyprbars is still nil and plugin:hyprbars:* config keys
      # do not exist yet; touching them unguarded aborts the rest of the file.
      # Everything that needs the plugin therefore sits behind this guard, which
      # also means a failed plugin load degrades to "no title bars" instead of
      # "no window rules".
      #
      # Note the button actions: under the lua config `hyprctl dispatch X` is a
      # wrapper for hl.dispatch(X), so the old `hyprctl dispatch killactive`
      # spelling is a lua error. They pass real lua expressions, single-quoted
      # so the shell keeps the inner double quotes.
      extraConfig = ''
        local noctalia = require("noctalia")
        if hl.plugin.hyprbars then
          -- macOS-like title bars. Plugin values register as
          -- "plugin:hyprbars:<name>", which lua addresses as
          -- plugin.hyprbars.<name> (':' -> '.', '-' -> '_').
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
                -- like macOS: plain circles, glyphs only appear on hover
                icon_on_hover              = false,
                inactive_button_color      = "rgb(4d4d4d)",
                on_double_click            = "hyprctl dispatch 'hl.dsp.window.fullscreen({ mode = \"maximized\" })'",
              },
            },
          })

          -- traffic lights (leftmost first): close, minimize, zoom.
          -- minimize targets kiwi-shell's special:minimized workspace, so the
          -- dock dims the window's dot and can restore it (dock icon click,
          -- alt-tab confirm, or any activation of the window)
          -- icon font+scale are hardcoded in hyprbars (sans @ 62% of button
          -- size), so clarity comes from heavy glyphs and larger buttons
          hl.plugin.hyprbars.add_button({
            bg_color = "rgb(ff5f57)", fg_color = "rgb(7d0f10)", size = 15, icon = "✖",
            action = "hyprctl dispatch 'hl.dsp.window.close()'",
          })
          hl.plugin.hyprbars.add_button({
            bg_color = "rgb(28c840)", fg_color = "rgb(0e650e)", size = 15, icon = "✚",
            action = "hyprctl dispatch 'hl.dsp.window.fullscreen({ mode = \"maximized\" })'",
          })
          hl.plugin.hyprbars.add_button({
            bg_color = "rgb(febc2e)", fg_color = "rgb(90591d)", size = 15, icon = "▬",
            action = "hyprctl dispatch 'hl.dsp.window.float({action = "set})'",
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
