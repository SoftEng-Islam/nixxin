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
        bar_text_font = ${settings.fonts.hyprbars.name}
        bar_text_size = ${toString settings.fonts.hyprbars.size}
        bar_height = 38
        bar_blur = true
        bar_padding = 10
        bar_button_padding = 12
        bar_precedence_over_border = false
        bar_part_of_window = true
        bar_color = $surface
        bar_text_align = left
        col.text = $primary

        # example buttons (R -> L)
        # hyprbars-button = Background Color, Size, On-click, Foreground
        # hyprbars-button = rgba(9141ACff),20, ▢ , hyprctl dispatch fullscreen 2, rgb(FFFFFF) # Fullscreen mode 2

        hyprbars-button = rgba(E62D42ff),20, , hyprctl dispatch killactive, rgb(FFFFFF) # Close
        hyprbars-button = rgba(3A944Aff),20, , hyprctl dispatch fullscreen 1, rgb(FFFFFF) # Maximize
        hyprbars-button = rgba(C88800ff),20, , hyprctl dispatch togglefloating, rgb(FFFFFF) # Minimize / Floating toggle
      }
    '';
  };
}
