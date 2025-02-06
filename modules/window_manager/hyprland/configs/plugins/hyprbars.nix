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
        bar_height = 40
        bar_blur = true
        bar_padding = 10
        bar_button_padding = 12
        bar_precedence_over_border = true
        bar_part_of_window = true
        bar_color = $surface
        bar_text_align = left
        col.text = $onSurface
        #col.text = $primary

        # example buttons (R -> L)
        # hyprbars-button = Background Color, Size, On-click, Foreground
        hyprbars-button = rgb(ff5165),20,, close-window, rgb(000000) # Close
        hyprbars-button = rgb(51ff7f),20,=, hyprctl dispatch fullscreen 1, rgb(FFFFFF) # Maximize
        hyprbars-button = rgb(fff651),20,-, hyprctl dispatch togglefloating, rgb(FFFFFF) # Minimize / Floating toggle
      }
    '';
  };
  environment.systemPackages = [ close-window ];
}
