{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ wezterm ];
  home-manager.users.${settings.user.username} = {
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      extraConfig = ''
        local wezterm = require 'wezterm'

        local config = {}
        config.front_end = 'WebGpu'
        config.font = wezterm.font 'PragmataPro Mono Liga'
        config.window_decorations = 'RESIZE'
        config.warn_about_missing_glyphs = false
        config.hide_tab_bar_if_only_one_tab = true
        config.color_scheme = 'nordfox'

        config.audible_bell = 'Disabled'

        config.set_environment_variables = {
          TERMINFO_DIRS = '/home/shinzui/.nix-profile/share/terminfo',
          WSLENV = 'TERMINFO_DIRS',
        }

        config.mouse_bindings = {
           -- and make CTRL-Click open hyperlinks
          {
            event={Up={streak=1, button="Left"}},
            mods="CTRL",
            action="OpenLinkAtMouseCursor",
          },
        }

        return config
      '';
    };
  };
}
