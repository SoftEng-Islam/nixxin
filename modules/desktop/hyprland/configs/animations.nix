#  This module configures animation settings for Hyprland, optimized for AMD Ryzen 5 3400G APU performance.
{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland = {
      settings.animations = {
        enabled = true;

        # ╔═══════════════════════════════════════════════════════════════╗
        # ║                    Bezier Curves (Easing)                     ║
        # ╚═══════════════════════════════════════════════════════════════╝
        bezier = [
          "default,0.12,0.92,0.08,1.0"
          "wind,0.12,0.92,0.08,1.0"
          "overshot,0.18,0.95,0.22,1.03"
          "liner,1,1,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "easeOutQuint,0.23,1,0.32,1"
          "easeOutBack,0.25,1.5,0.5,1"
          "quick,0.15,0,0.1,1"
          "slidePop,0.25,1.2,0.35,1.05"
        ];

        # ╔═══════════════════════════════════════════════════════════════╗
        # ║              Animation Configuration - OPTIMIZED              ║
        # ║  Shorter durations for better APU performance                 ║
        # ╚═══════════════════════════════════════════════════════════════╝
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.0, easeOutQuint"
          "windows, 1, 4, wind, popin 60%"
          "windowsIn, 1, 5, overshot, popin 60%"
          "windowsOut, 1, 3, overshot, popin 60%"
          "windowsMove, 1, 3.5, overshot, slide"
          "fadeIn, 1, 1.2, slidePop"
          "fadeOut, 1, 1.0, slidePop"
          "fade, 1, 3.0, quick"
          "layers, 1, 3.5, easeOutQuint"
          "layersIn, 1, 3.8, easeOutQuint"
          "layersOut, 1, 1.5, easeOutQuint"
          "fadeLayersIn, 1, 1.8, almostLinear"
          "fadeLayersOut, 1, 1.4, almostLinear"
          "workspaces, 1, 2.0, easeOutQuint"
          "workspacesIn, 1, 1.3, easeOutQuint"
          "workspacesOut, 1, 2.0, easeOutQuint"
        ];
      };
    };
  };
}
