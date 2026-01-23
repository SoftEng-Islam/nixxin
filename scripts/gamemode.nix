{ settings, pkgs, ... }:
# Source: https://wiki.hyprland.org/Configuring/Uncommon-tips--tricks/
# For increased performance in games, or for less distractions at a keypress
# Edit to your liking of course. If animations are enabled, it disables all the pretty stuff. Otherwise, the script reloads your config to grab your defaults.
# The hotkey toggle will be WIN+F1, but you can change this to whatever you want.
let
  run-gamemode = pkgs.writeShellScriptBin "run-gamemode" ''
    hyprshadeCurrent=$(hyprshade current)
    HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
    if [ "$HYPRGAMEMODE" = 1 ] ; then
      gamemoded & disown
      hyprctl --batch "\
          keyword animations:enabled 0;\
          keyword decoration:shadow:enabled 0;\
          keyword decoration:blur:enabled 0;\
          keyword general:gaps_in 0;\
          keyword general:gaps_out 0;\
          keyword general:border_size 0;\
          keyword decoration:rounding 0"
    fi
    hyprctl reload
    if ["$hyprshadeCurrent" = "blue-light-filter"] ; then
      ${pkgs.hyprshade}/bin/hyprshade on ~/.config/hypr/shaders/blue-light-filter.glsl
      ${pkgs.libnotify}/bin/notify-send 'blue-light-filter started'";
    fi
  '';
in { environment.systemPackages = [ run-gamemode ]; }
