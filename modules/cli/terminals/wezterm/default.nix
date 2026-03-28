{ settings, pkgs, ... }:
{
  home-manager.users.${settings.user.username} = {
    programs.wezterm = {
      enable = true;
      package = pkgs.wezterm;
      enableZshIntegration = true;
      enableBashIntegration = true;
      extraConfig = ''
        -- Pull in the wezterm API
        -- local wezterm = require 'wezterm'

        -- GPU & Performance
        local gpus = wezterm.gui.enumerate_gpus()

        -- Multiplexing config
        local act = wezterm.action

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
        config.font_size = ${toString settings.modules.terminals.wezterm.fontSize}
        config.font = wezterm.font_with_fallback({
          "CaskaydiaCove Nerd Font",
          "JetBrains Nerd Font",
          "Amiri"
        })
        -- disable ligatures
        -- config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

        -- ----------------------------
        -- Colors & Appearance
        -- ----------------------------
        config.color_scheme = "${settings.modules.terminals.wezterm.colorScheme}"
        config.window_padding = { left = 20, right = 20, top = 20, bottom = 50 }
        config.window_background_opacity = 1.0
        config.enable_tab_bar = true
        config.animation_fps = 1
        config.warn_about_missing_glyphs = false
        config.hide_tab_bar_if_only_one_tab = false
        config.window_close_confirmation = 'NeverPrompt'
        config.audible_bell = 'Disabled'
        config.colors = {
          -- The color of the scrollbar "thumb"; the portion that represents the current viewport
          scrollbar_thumb = '#414042',
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
        config.front_end = 'WebGpu'
        config.webgpu_preferred_adapter = gpus[1]
        config.animation_fps = 10
        config.max_fps = 50

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

        config.enable_scroll_bar = true

        -- ----------------------------
        -- Keybindings (converted from config/keybindings.lua)
        -- ----------------------------
        config.debug_key_events = true
        config.leader = { mods = "CTRL", key = "b", timeout_milliseconds = 1000 }
        config.keys = {
          -- CTRL-SHIFT-t open new tab in new dir
          {
            key = 't',
            mods = 'CTRL|SHIFT',
            action = act.SpawnCommandInNewTab {
              cwd = wezterm.home_dir,
            },
          },
          -- CTRL-ALT-t open new tab in same dir
          {
            key = 't',
            mods = 'CTRL|ALT',
            action = act.SpawnTab 'CurrentPaneDomain'
          },
          -- Smart Ctrl-c: copy selection, otherwise send Ctrl-c
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
          { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
          { key = 'v', mods = 'SHIFT|CTRL', action = wezterm.action_callback(function(window, pane)
            window:perform_action(wezterm.action.SendKey{ key='v', mods='CTRL' }, pane) end),
          },
          { key = 'V', mods = 'SHIFT|CTRL', action = wezterm.action_callback(function(window, pane)
            window:perform_action(wezterm.action.SendKey{ key='v', mods='CTRL' }, pane) end),
          },
          { key = 'c', mods = 'ALT', action = act.CopyTo 'ClipboardAndPrimarySelection' },
          { key = 'v', mods = 'ALT', action = act.PasteFrom 'Clipboard' },
          { mods = "LEADER|CTRL", key = ";",           action = act.SplitVertical    { domain = "CurrentPaneDomain" } },
          { mods = "LEADER|CTRL", key = "'",           action = act.SplitHorizontal  { domain = "CurrentPaneDomain" } },
          { mods = "LEADER|CTRL", key = "x",           action = act.CloseCurrentPane { confirm = false              } },
          { mods = "LEADER|CTRL", key = "h",           action = act.ActivatePaneDirection "Left"  },
          { mods = "LEADER|CTRL", key = "l",           action = act.ActivatePaneDirection "Right" },
          { mods = "LEADER|CTRL", key = "k",           action = act.ActivatePaneDirection "Up"    },
          { mods = "LEADER|CTRL", key = "j",           action = act.ActivatePaneDirection "Down"  },
          { mods = "LEADER|CTRL", key  = "a",          action = act.ActivateKeyTable { name = "activate_pane", one_shot = false } },
          { mods = "LEADER|CTRL", key  = "r",          action = act.ActivateKeyTable { name = "resize_pane"  , one_shot = false } },
          { mods = "LEADER|CTRL", key  = "c",          action = act.ActivateKeyTable { name = "rotate_pane"  , one_shot = false } },
          { mods = "LEADER|CTRL", key = "]",           action = act.RotatePanes "Clockwise"        },
          { mods = "LEADER|CTRL", key = "[",           action = act.RotatePanes "CounterClockwise" },
          { mods = "LEADER|CTRL", key = "p",           action = act{PaneSelect={alphabet="0123456789"}}},
        }

        config.key_tables = {
          activate_pane = {
            { key = 'LeftArrow',  action = act.ActivatePaneDirection 'Left'  },
            { key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },
            { key = 'UpArrow',    action = act.ActivatePaneDirection 'Up'    },
            { key = 'DownArrow',  action = act.ActivatePaneDirection 'Down'  },
            -- Cancel the mode by pressing escape
            { key = 'Escape', action = 'PopKeyTable' },
          },
          resize_pane = {
            { key = 'LeftArrow',  action = act.AdjustPaneSize { 'Left',  1 } },
            { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
            { key = 'UpArrow',    action = act.AdjustPaneSize { 'Up',    1 } },
            { key = 'DownArrow',  action = act.AdjustPaneSize { 'Down',  1 } },
            { key = 'Escape',     action = 'PopKeyTable' },
          },
          rotate_pane = {
            { key = 'RightArrow', action = act.RotatePanes "CounterClockwise" },
            { key = 'UpArrow',    action = act.RotatePanes "CounterClockwise" },
            { key = 'LeftArrow',  action = act.RotatePanes "Clockwise"        },
            { key = 'DownArrow',  action = act.RotatePanes "Clockwise"        },
            { key = 'Escape',     action = 'PopKeyTable' },
          },
        }

        -- Finally, return the configuration to wezterm:
        return config
      '';
    };
    # keybindings are now inlined above, no need to copy config directory
  };
}
