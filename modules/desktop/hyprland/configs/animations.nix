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
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "easeOutQuint,0.23,1,0.32,1"
          "easeOutBack,0.25,1.5,0.5,1" # for windowsIn popin
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 12, default"
          "border, 1, 6.0, easeOutQuint"
          "windows, 1, 5.5, easeOutQuint"
          "windowsIn, 1, 4.5, easeOutBack, popin 90%"
          "windowsOut, 1, 2.0, easeOutQuint, popin 90%"
          "fadeIn, 1, 2.0, almostLinear"
          "fadeOut, 1, 1.8, almostLinear"
          "fade, 1, 3.5, quick"
          "layers, 1, 4.0, easeOutQuint"
          "layersIn, 1, 4.2, easeOutQuint"
          "layersOut, 1, 1.8, easeOutQuint"
          "fadeLayersIn, 1, 2.0, almostLinear"
          "fadeLayersOut, 1, 1.6, almostLinear"
          "workspaces, 1, 2.2, easeOutQuint"
          "workspacesIn, 1, 1.5, easeOutQuint"
          "workspacesOut, 1, 2.2, easeOutQuint"
        ];
      };

    };
  };
}
