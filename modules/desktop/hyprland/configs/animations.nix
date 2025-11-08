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

          "global, 1, 12, default" # Slightly slower global speed
          "border, 1, 6.0, easeOutCubic" # Smooth border transitions
          "windows, 1, 5.5, easeOutCubic" # Slightly slower than before
          "windowsIn, 1, 4.5, easeOutBack, popin 90%" # Pop-in with gentle overshoot
          "windowsOut, 1, 2.0, easeInOutQuad, popin 90%" # Smooth exit
          "fadeIn, 1, 2.0, almostLinear" # Soft fade in
          "fadeOut, 1, 1.8, almostLinear" # Soft fade out
          "fade, 1, 3.5, quick" # Overall fade timing
          "layers, 1, 4.0, easeOutCubic" # Layer movement smooth
          "layersIn, 1, 4.2, easeOutCubic, fade" # Smooth layer entrance
          "layersOut, 1, 1.8, easeInOutQuad, fade" # Smooth layer exit
          "fadeLayersIn, 1, 2.0, almostLinear" # Layer fade in
          "fadeLayersOut, 1, 1.6, almostLinear" # Layer fade out
          "workspaces, 1, 2.2, almostLinear, fade" # Workspace switch smooth
          "workspacesIn, 1, 1.5, almostLinear, fade" # Workspace entry
          "workspacesOut, 1, 2.2, almostLinear, fade" # Workspace exit
        ];
      };
    };
  };
}
