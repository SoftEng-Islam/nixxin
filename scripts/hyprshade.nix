{ pkgs, ... }:

let
  blueFilter = pkgs.writeShellScriptBin "run-blue-filter" ''
    hyprshadeCurrent=$(hyprshade current 2>/dev/null || "")

    if [ "$hyprshadeCurrent" = "blue-light-filter" ]; then
      ${pkgs.hyprshade}/bin/hyprshade off
      ${pkgs.libnotify}/bin/notify-send --icon=~/.nixxinIcons/invert_colors_off.svg "Blue Filter" "Ended"
    else
      ${pkgs.hyprshade}/bin/hyprshade on ~/.config/hypr/shaders/blue-light-filter.glsl
      ${pkgs.libnotify}/bin/notify-send --icon=~/.nixxinIcons/invert_colors.svg "Blue Filter" "Started"
    fi
  '';
in { environment.systemPackages = [ blueFilter ]; }
