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
        config.window_padding = { left = 5, right = 5, top = 5, bottom = 5, }
        config.window_background_opacity = 1
        config.enable_tab_bar = true
        config.animation_fps = 1
        config.warn_about_missing_glyphs = false
        config.hide_tab_bar_if_only_one_tab = false
        config.window_close_confirmation = 'NeverPrompt'
        config.audible_bell = 'Disabled'


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
        config.default_prog = { "/bin/zsh", "-l" }

        -- Always start new windows/tabs in this directory
        config.default_cwd = wezterm.home_dir

        config.mouse_bindings = {
          -- and make CTRL-Click open hyperlinks
          {
            event={Up={streak=1, button="Left"}},
            mods="CTRL",
            action="OpenLinkAtMouseCursor",
          },
          -- super-t open new tab in new dir
          {
            key = 't',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.SpawnCommandInNewTab {
              cwd = wezterm.home_dir,
            },
          },
          -- shift-super-t open new tab in same dir
          {
            key = 't',
            mods = 'CTRL|ALT',
            action = wezterm.action.SpawnTab 'CurrentPaneDomain'
          },
        }

        -- copy_mode
        -- You can see the configuration in your version of wezterm by running..
        -- `wezterm show-keys --lua --key-table copy_mode`.

        config.enable_scroll_bar = true

        -- config.disable_default_key_bindings = true
        -- config.keys = {
        --   -- Make CTRL-C copy to clipboard
        --   {key="c", mods="CTRL", action="CopyTo", args={ "ClipboardAndPrimarySelection" }},
        --   -- Make CTRL-V paste from clipboard
        --   {key="v", mods="CTRL", action="PasteFrom", args={ "ClipboardAndPrimarySelection" }},
        --   -- Make CTRL-Shift-C Terminate the current process
        --   {key="c", mods="CTRL|SHIFT", action="SendString", args={ "\x03" }},
        -- }

        -- Finally, return the configuration to wezterm:
        return config
      '';
    };
  };
}
