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
  close-window = pkgs.writeShellScriptBin "close-window" ''
    wid=$(hyprctl activewindow -j | jq -r '.address')
    if [ -n "$wid" ] && [ "$wid" != "null" ]; then
        hyprctl dispatch closewindow address:$wid
    fi
  '';
in {
  home-manager.users.${settings.user.username} = {
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
        bar_height = 40
        bar_padding = 10
        bar_button_padding = 12

        bar_blur = true
        bar_text_align = left
        bar_part_of_window = true
        bar_precedence_over_border = true

        bar_color = $surface
        #col.text = $onSurface
        col.text = $primary

        # ---- Example buttons (R -> L) ---- #
        # hyprbars-button = Background Color, Size, On-click, Foreground Color
        hyprbars-button = rgba(E62D42ff),20,, close-window, rgba(FFFFFF50) # Close
        hyprbars-button = rgba(3A944Aff),20,=, hyprctl dispatch fullscreen 1, rgba(FFFFFF50) # Maximize
        hyprbars-button = rgba(C88800ff),20,~, hyprctl dispatch togglefloating, rgba(FFFFFF50) # Minimize / Floating toggle
      }
    '';
  };
  environment.systemPackages = [ close-window ];
}
