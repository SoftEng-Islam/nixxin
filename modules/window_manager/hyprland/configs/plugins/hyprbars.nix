{ settings, lib, pkgs, ... }:
let
  hyprbars = (pkgs.hyprlandPlugins.hyprbars.override {
    # Make sure it's using the same hyprland package as we are
    hyprland = pkgs.hyprland;
  }).overrideAttrs (old: {
    # Yeet the initialization notification (I hate it)
    postPatch = (old.postPatch or "") + ''
      ${lib.getExe pkgs.gnused} -i '/Initialized successfully/d' main.cpp
    '';
  });
in {
  home-manager.users.${settings.users.selected.username} = {
    wayland.windowManager.hyprland.plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      hyprbars
    ];
    wayland.windowManager.hyprland.extraConfig = ''
      # ------------------ #
      # ---- hyprbars ---- #
      # ------------------ #
      plugin:hyprbars {
        # Honestly idk if it works like css, but well, why not
        bar_text_font = "${settings.fonts.hyprbars.name}"
        bar_text_size = ${toString settings.fonts.hyprbars.size}
        bar_height = 38
        bar_blur = true
        bar_padding = 10
        bar_button_padding = 12
        bar_precedence_over_border = true
        bar_part_of_window = true
        bar_color = $surface
        bar_text_align = left
        col.text = $primary
        # example buttons (R -> L)
        # hyprbars-button = color, size, on-click
        hyprbars-button = rgba(B91C1C60),20,, hyprctl dispatch killactive, rgb(ffffff)
        hyprbars-button = rgba(8E22CE60),20,0, hyprctl dispatch fullscreen 2, rgb(ffffff)
        hyprbars-button = rgba(4D4ED260),20,+, hyprctl dispatch fullscreen 1, rgb(ffffff)
        hyprbars-button = rgba(0E749060),20,~, hyprctl dispatch togglefloating, rgb(ffffff)
      }
    '';
  };
}
