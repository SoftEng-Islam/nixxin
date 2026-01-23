{ settings, pkgs, ... }:
let
  blue-filter = pkgs.writeShellScriptBin "run-blue-filter" ''
    # ${pkgs.hyprshade}/bin/hyprshade toggle ~/.config/hypr/shaders/blue-light-filter.glsl
    hyprshadeCurrent=$(hyprshade current)
    if ["$hyprshadeCurrent" = "blue-light-filter"] ; then
      ${pkgs.hyprshade}/bin/hyprshade off
      ${pkgs.libnotify}/bin/notify-send 'blue-light-filter ended'";
      exit
    fi
    ${pkgs.hyprshade}/bin/hyprshade on ~/.config/hypr/shaders/blue-light-filter.glsl
    start = "${pkgs.libnotify}/bin/notify-send 'blue-light-filter started'";
  '';
in { environment.systemPackages = [ blue-filter ]; }
