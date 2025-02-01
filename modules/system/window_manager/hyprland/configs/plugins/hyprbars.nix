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
        bar_padding = 10
        bar_button_padding = 12
        bar_precedence_over_border = true
        bar_part_of_window = true
        bar_color = rgba(262626ff)
        col.text = rgba(DCE3EEFF)
        # example buttons (R -> L)
        # hyprbars-button = color, size, on-click
        hyprbars-button = rgb(B91C1C),20,, hyprctl dispatch killactive
        hyprbars-button = rgb(7E22CE),20,*, hyprctl dispatch fullscreen 2
        hyprbars-button = rgb(15803D),20,+, hyprctl dispatch fullscreen 1
        hyprbars-button = rgb(CA8A04),20,-, hyprctl dispatch togglefloating
      }
    '';
  };
}
