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
          # "windows, 1, ${animationDuration}, md3_decel, popin 60%"
          # "windowsIn, 1, ${animationDuration}, md3_decel, popin 60%"
          # "windowsOut, 1, ${animationDuration}, md3_accel, popin 60%"
          # "border, 1, ${borderDuration}, default"
          # "fade, 1, ${animationDuration}, md3_decel"
          # "layersIn, 1, ${animationDuration}, menu_decel, slide"
          # "layersOut, 1, ${animationDuration}, menu_accel"
          # "fadeLayersIn, 1, ${animationDuration}, menu_decel"
          # "fadeLayersOut, 1, ${animationDuration}, menu_accel"
          # "workspaces, 1, ${animationDuration}, menu_decel, slide"
          # "specialWorkspace, 1, ${animationDuration}, md3_decel, slidevert"

          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };
    };
  };
}
