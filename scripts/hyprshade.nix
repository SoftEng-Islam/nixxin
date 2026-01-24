{ settings, pkgs, ... }:
let
  blue-filter = pkgs.writeShellScriptBin "run-blue-filter" ''
    hyprshadeCurrent=$(hyprshade current)
    if ["$hyprshadeCurrent" = "blue-light-filter"] ; then
      ${pkgs.hyprshade}/bin/hyprshade off
      ${pkgs.libnotify}/bin/notify-send "blue-light-filter ended";
      exit
      else
        ${pkgs.hyprshade}/bin/hyprshade on ~/.config/hypr/shaders/blue-light-filter.glsl
        ${pkgs.libnotify}/bin/notify-send "blue-light-filter started";
    fi
  '';
in { environment.systemPackages = [ blue-filter ]; }
