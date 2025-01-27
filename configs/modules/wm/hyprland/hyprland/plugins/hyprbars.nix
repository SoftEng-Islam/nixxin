{ settings, config, lib, inputs, pkgs, ... }:
let
  hyprbars = (pkgs.hyprlandPlugins.hyprbars.override {
    # Make sure it's using the same hyprland package as we are
    hyprland = config.wayland.windowManager.hyprland.package;
  }).overrideAttrs (old: {
    # Yeet the initialization notification (I hate it)
    postPatch = (old.postPatch or "") + ''
      ${lib.getExe pkgs.gnused} -i '/Initialized successfully/d' main.cpp
    '';
  });
in {
  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland.plugins = [
      # pkgs.hyprlandPlugins.hyprbars
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      hyprbars
    ];
    wayland.windowManager.hyprland.extraConfig = ''
      # ------------------ #
      # ---- hyprbars ---- #
      # ------------------ #
      plugin:hyprbars {
        # Honestly idk if it works like css, but well, why not
        bar_text_font = "${settings.fontName}"
        bar_text_size = ${toString settings.fontSize}
        bar_height = 40
        bar_padding = 15
        bar_button_padding = 5
        bar_precedence_over_border = true
        bar_part_of_window = true
        bar_color = rgba(0D141BFF)
        col.text = rgba(DCE3EEFF)
        # example buttons (R -> L)
        # hyprbars-button = color, size, on-click
        hyprbars-button = rgb(B91C1C), 20, , hyprctl dispatch killactive
        hyprbars-button = rgb(15803D), 20, , hyprctl dispatch fullscreen 1
        hyprbars-button = rgb(7E22CE), 20, , hyprctl dispatch togglefloating
      }
    '';
  };
}
