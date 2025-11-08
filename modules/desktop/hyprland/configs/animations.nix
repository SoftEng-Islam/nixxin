{ settings, ... }:

let
  animationSpeed = settings.modules.desktop.hyprland.animationSpeed;
  animationDuration = if animationSpeed == "slow" then
    "4"
  else if animationSpeed == "medium" then
    "2.5"
  else
    "1.5";
  borderDuration = if animationSpeed == "slow" then
    "10"
  else if animationSpeed == "medium" then
    "6"
  else
    "3";

in {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings.animations = {
        enabled = true;
        bezier = [
          # "linear, 0, 0, 1, 1"
          # "md3_standard, 0.2, 0, 0, 1"
          # "md3_decel, 0.05, 0.7, 0.1, 1"
          # "md3_accel, 0.3, 0, 0.8, 0.15"
          # "overshot, 0.05, 0.9, 0.1, 1.1"
          # "crazyshot, 0.1, 1.5, 0.76, 0.92"
          # "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          # "menu_decel, 0.1, 1, 0, 1"
          # "menu_accel, 0.38, 0.04, 1, 0.07"
          # "easeInOutCirc, 0.85, 0, 0.15, 1"
          # "easeOutCirc, 0, 0.55, 0.45, 1"
          # "easeOutExpo, 0.16, 1, 0.3, 1"
          # "softAcDecel, 0.26, 0.26, 0.15, 1"
          # "md2, 0.4, 0, 0.2, 1"

          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 12, default"
          "border, 1, 6.0, easeOutQuint"
          "windows, 1, 5.5, easeOutQuint"
          "windowsIn, 1, 4.5, easeOutBack, popin 90%"
          "windowsOut, 1, 2.0, easeInOutQuint, popin 90%"
          "fadeIn, 1, 2.0, almostLinear"
          "fadeOut, 1, 1.8, almostLinear"
          "fade, 1, 3.5, quick"
          "layers, 1, 4.0, easeOutQuint"
          "layersIn, 1, 4.2, easeOutQuint, fade"
          "layersOut, 1, 1.8, easeInOutQuint, fade"
          "fadeLayersIn, 1, 2.0, almostLinear"
          "fadeLayersOut, 1, 1.6, almostLinear"
          "workspaces, 1, 2.2, almostLinear, fade"
          "workspacesIn, 1, 1.5, almostLinear, fade"
          "workspacesOut, 1, 2.2, almostLinear, fade"

        ];
      };
    };
  };
}
