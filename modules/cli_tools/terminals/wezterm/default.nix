{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ wezterm ];
  home-manager.users.${settings.user.username} = {
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      extraConfig = ''
        -- Pull in the wezterm API
        local wezterm = require 'wezterm'

        -- This table will hold the configuration.
        local config = {}

        -- In newer versions of wezterm, use the config_builder which will
        -- help provide clearer error messages
        if wezterm.config_builder then
          config = wezterm.config_builder()
        end

        -- This is where you actually apply your config choices.
        config.initial_rows = 25
        config.initial_cols = 100
        config.scrollback_lines = 10000


        -- ----------------------------
        -- Font size and color scheme.
        -- ----------------------------
        config.bidi_enabled = true
        config.bidi_direction = "AutoLeftToRight"
        config.bold_brightens_ansi_colors = "BrightAndBold"
        config.underline_position = -3.5
        config.underline_thickness = 1
        config.font = wezterm.font("${settings.modules.terminals.wezterm.fontFamily}", {weight="Regular", italic=true})
        config.font_size = ${
          toString settings.modules.terminals.wezterm.fontSize
        }
        config.font = wezterm.font_with_fallback({
          "JetBrains Nerd Font",
          "Amiri",
          "Noto Sans Arabic",
          "CaskaydiaCove Nerd Font"
        })
        -- disable ligatures
        -- config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

        -- ----------------------------
        -- Colors & Appearance
        -- ----------------------------
        config.color_scheme = "${settings.modules.terminals.wezterm.colorScheme}"
        config.window_padding = { left = 8, right = 15, top = 10, bottom = 10, }
        config.window_background_opacity = 0.9
        config.enable_tab_bar = true
        config.animation_fps = 1
        config.warn_about_missing_glyphs = false
        config.hide_tab_bar_if_only_one_tab = false
        config.window_close_confirmation = 'NeverPrompt'
        config.audible_bell = 'Disabled'
        config.colors = {
          -- The color of the scrollbar "thumb"; the portion that represents the current viewport
          scrollbar_thumb = '#161616',
        }


        -- Acceptable values are SteadyBlock, BlinkingBlock, SteadyUnderline, BlinkingUnderline, SteadyBar, and BlinkingBar.
        config.default_cursor_style = 'BlinkingBar'
        config.cursor_thickness = "2px"
        config.cursor_blink_ease_in = 'Constant'
        config.cursor_blink_ease_out = 'Constant'

        -- Specifies which render front-end to use. This option used to have more scope in earlier versions of wezterm, but today it allows three possible values:
        -- OpenGL - use GPU accelerated rasterization
        -- Software - use CPU-based rasterization.
        -- WebGpu - use GPU accelerated rasterization (Since: Version 20221119-145034-49b9839f)
        config.front_end = 'OpenGL'

        config.set_environment_variables = {
          TERMINFO_DIRS = '/home/${settings.user.username}/.nix-profile/share/terminfo',
          WSLENV = 'TERMINFO_DIRS',
        }
        config.term = '${settings.common.TERM}'

        -- Start zsh as login shell
        -- config.default_prog = { "/bin/zsh", "-l" }

        -- Always start new windows/tabs in this directory
        config.default_cwd = wezterm.home_dir

        config.mouse_bindings = {
          -- and make CTRL-Click open hyperlinks
          {
            event={Up={streak=1, button="Left"}},
            mods="CTRL",
            action="OpenLinkAtMouseCursor",
          },
        }

        -- copy_mode
        -- You can see the configuration in your version of wezterm by running..
        -- `wezterm show-keys --lua --key-table copy_mode`.

        config.enable_scroll_bar = true

        -- config.disable_default_key_bindings = true
        config.keys = {
          -- CTRL-SHIFT-t open new tab in new dir
          {
            key = 't',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.SpawnCommandInNewTab {
              cwd = wezterm.home_dir,
            },
          },
          -- CTRL-ALT-t open new tab in same dir
          {
            key = 't',
            mods = 'CTRL|ALT',
            action = wezterm.action.SpawnTab 'CurrentPaneDomain'
          },
          {
            key = 'c',
            mods = 'CTRL',
            action = wezterm.action_callback(function(window, pane)
              local sel = window:get_selection_text_for_pane(pane)
              if (not sel or sel == "") then
                window:perform_action(wezterm.action.SendKey{ key='c', mods='CTRL' }, pane)
              else
                window:perform_action(wezterm.action{ CopyTo = 'ClipboardAndPrimarySelection' }, pane)
              end
            end),
          },
          { key = 'v', mods = 'CTRL', action = wezterm.action.PasteFrom 'Clipboard' },
          { key = 'v', mods = 'SHIFT|CTRL', action = wezterm.action_callback(function(window, pane)
            window:perform_action(wezterm.action.SendKey{ key='v', mods='CTRL' }, pane) end),
          },
          { key = 'V', mods = 'SHIFT|CTRL', action = wezterm.action_callback(function(window, pane)
            window:perform_action(wezterm.action.SendKey{ key='v', mods='CTRL' }, pane) end),
          },
          { key = 'c', mods = 'ALT', action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection' },
          { key = 'v', mods = 'ALT', action = wezterm.action.PasteFrom 'Clipboard' },
        }

        -- Finally, return the configuration to wezterm:
        return config
      '';
    };
  };
}
