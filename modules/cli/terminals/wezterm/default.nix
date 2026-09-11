{
  settings,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  home-manager.users.${settings.user.username} = {
    programs.wezterm = {
      enable = true;
      package = inputs.wezterm.packages.${pkgs.stdenv.hostPlatform.system}.default;
      enableZshIntegration = true;
      enableBashIntegration = true;
      settings = {
        default_cursor_style = "SteadyBlock";
        font_size = lib.mkForce 15.0;
        font = lib.mkForce (
          lib.generators.mkLuaInline ''
            wezterm.font_with_fallback {
              {
                family = 'Berkeley Mono',
                weight = 'Medium',
              },
              {
                family = 'MonoLisa',
                weight = 'Medium',
                harfbuzz_features = { 'ss02=1', 'ss07=1' },
              },
              {
                family = 'TX-02',
                weight = 'Medium',
                style = 'Normal',
                harfbuzz_features = { 'ss02=1' },
              },
              {
                family = 'Liga SFMono Nerd Font',
                weight = 'Regular',
              },
              {
                family = 'JetBrains Mono Nerd Font',
                weight = 'Medium',
              },
            }
          ''
        );
        hide_tab_bar_if_only_one_tab = true;
        freetype_load_flags = "NO_HINTING";
        freetype_load_target = "Normal";
        line_height = 1.0;
        front_end = "OpenGL";
        window_background_opacity = lib.mkForce 0.7;
        # wayland_window_background_blur = true;
        warn_about_missing_glyphs = false;
      };
    };
    # keybindings are now inlined above, no need to copy config directory
    nix.settings = {

      substituters = [ "https://wezterm.cachix.org" ];
      trusted-public-keys = [ "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0=" ];
    };
  };
}
