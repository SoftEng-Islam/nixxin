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

        -- This will hold the configuration.
        if wezterm.config_builder then
          config = wezterm.config_builder()
        end

        -- This is where you actually apply your config choices.

        -- changing the font size and color scheme.
        config.font_size = ${
          toString settings.modules.terminals.wezterm.fontSize
        }
        config.font = wezterm.font "${settings.modules.terminals.wezterm.fontFamily}"
        config.color_scheme = "${settings.modules.terminals.wezterm.colorScheme}"

        config.enable_tab_bar = true

        config.window_padding = { left = 2, right = 2, top = 2, bottom = 2, }
        config.window_background_opacity = 0.7

        config.animation_fps = 1

        config.cursor_blink_ease_in = 'Constant'
        config.cursor_blink_ease_out = 'Constant'

        -- Specifies which render front-end to use. This option used to have more scope in earlier versions of wezterm, but today it allows three possible values:
        -- OpenGL - use GPU accelerated rasterization
        -- Software - use CPU-based rasterization.
        -- WebGpu - use GPU accelerated rasterization (Since: Version 20221119-145034-49b9839f)
        config.front_end = 'WebGpu'

        config.window_decorations = 'RESIZE'
        config.warn_about_missing_glyphs = false
        config.hide_tab_bar_if_only_one_tab = true

        config.audible_bell = 'Disabled'

        config.set_environment_variables = {
          TERMINFO_DIRS = '/home/${settings.user.username}/.nix-profile/share/terminfo',
          WSLENV = 'TERMINFO_DIRS',
        }
        config.term = 'wezterm'


        config.mouse_bindings = {
          -- and make CTRL-Click open hyperlinks
          {
            event={Up={streak=1, button="Left"}},
            mods="CTRL",
            action="OpenLinkAtMouseCursor",
          },
        }

        -- Window Background Image
        -- config.window_background_image = '/path/to/wallpaper.jpg'

        config.window_background_image_hsb = {
          -- Darken the background image by reducing it to 1/3rd
          brightness = 0.3,

          -- You can adjust the hue by scaling its value.
          -- a multiplier of 1.0 leaves the value unchanged.
          hue = 1.0,

          -- You can adjust the saturation also.
          saturation = 1.0,
        }
        -- Finally, return the configuration to wezterm:
        return config
      '';
    };
  };
}
