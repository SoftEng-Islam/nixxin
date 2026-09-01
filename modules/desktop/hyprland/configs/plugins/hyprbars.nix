{
  settings,
  lib,
  pkgs,
  ...
}:
let
  # Override hyprbars to remove the initialization notification
  hyprbars = pkgs.hyprlandPlugins.hyprbars.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      ${lib.getExe pkgs.gnused} -i '/Initialized successfully/d' main.cpp
    '';
  });

  # Helper script to close the active window
  close-window = pkgs.writeShellScriptBin "close-window" ''
    wid=$(hyprctl activewindow -j | jq -r '.address')
    if [ -n "$wid" ] && [ "$wid" != "null" ]; then
        hyprctl dispatch closewindow address:$wid
    fi
  '';
in
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.plugins = [ hyprbars ];

    wayland.windowManager.hyprland.extraConfig = ''
      # ╔═══════════════════════════════════════╗
      # ║           Hyprbars Plugin             ║
      # ║     Beautiful Window Title Bars       ║
      # ╚═══════════════════════════════════════╝

      plugin {
        hyprbars {
          # ────────────────────────────────────
          # Bar Appearance
          # ────────────────────────────────────
          enabled = true
          bar_height = 40
          bar_color = $surface
          bar_blur = true
          bar_part_of_window = true
          bar_precedence_over_border = true

          # ────────────────────────────────────
          # Title Text Styling
          # ────────────────────────────────────
          bar_title_enabled = true
          col.text = $primary
          bar_text_font = ${settings.modules.fonts.hyprbars.name}
          bar_text_size = ${toString settings.modules.fonts.hyprbars.size}
          bar_text_weight = normal
          bar_text_align = left

          # ────────────────────────────────────
          # Layout & Spacing
          # ────────────────────────────────────
          bar_padding = 10
          bar_button_padding = 12
          bar_buttons_alignment = right

          # ────────────────────────────────────
          # Interaction
          # ────────────────────────────────────
          icon_on_hover = false
          on_double_click = hyprctl dispatch fullscreen 1

          # ────────────────────────────────────
          # Window Buttons (Right to Left)
          # ────────────────────────────────────
          # Close button - Red with subtle hover
          hyprbars-button = rgba(E62D42ff), 20, , close-window, rgba(FFFFFF50)

          # Maximize button - Green with subtle hover
          hyprbars-button = rgba(3A944Aff), 20, =, hyprctl dispatch fullscreen 1, rgba(FFFFFF50)

          # Float/Minimize button - Orange with subtle hover
          hyprbars-button = rgba(C88800ff), 20, ~, hyprctl dispatch togglefloating, rgba(FFFFFF50)
        }
      }
    '';
  };

  environment.systemPackages = [
    close-window
    pkgs.jq
  ];
}
