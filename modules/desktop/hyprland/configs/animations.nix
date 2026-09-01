{ settings, ... }:

let
  animationSpeed = settings.modules.desktop.hyprland.animationSpeed;

  # ╔═══════════════════════════════════════════════════════════════════════╗
  # ║                  ANIMATION DURATION OPTIMIZATION                      ║
  # ║            Tuned for AMD Ryzen 5 3400G APU Performance                ║
  # ╚═══════════════════════════════════════════════════════════════════════╝

  # Reduced durations for better APU performance while maintaining smoothness
  animationDuration = if animationSpeed == "slow" then
    "2.5"  # Reduced from 3
  else if animationSpeed == "medium" then
    "1.8"  # Reduced from 2.0
  else
    "1.0"; # Fast mode unchanged

  borderDuration = if animationSpeed == "slow" then
    "6"    # Reduced from 8
  else if animationSpeed == "medium" then
    "4"    # Reduced from 5
  else
    "2";   # Fast mode unchanged

in {
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
          "global, 1, 10, default"                                    # Reduced from 12
          "border, 1, 5.0, easeOutQuint"                             # Reduced from 6.0
          "windows, 1, 4, wind, popin 60%"                           # Reduced from 5
          "windowsIn, 1, 5, overshot, popin 60%"                     # Reduced from 6
          "windowsOut, 1, 3, overshot, popin 60%"                    # Reduced from 4
          "windowsMove, 1, 3.5, overshot, slide"                     # Reduced from 4
          "fadeIn, 1, 1.2, slidePop"                                 # Reduced from 1.5
          "fadeOut, 1, 1.0, slidePop"                                # Reduced from 1.2
          "fade, 1, 3.0, quick"                                      # Reduced from 3.5
          "layers, 1, 3.5, easeOutQuint"                             # Reduced from 4.0
          "layersIn, 1, 3.8, easeOutQuint"                           # Reduced from 4.2
          "layersOut, 1, 1.5, easeOutQuint"                          # Reduced from 1.8
          "fadeLayersIn, 1, 1.8, almostLinear"                       # Reduced from 2.0
          "fadeLayersOut, 1, 1.4, almostLinear"                      # Reduced from 1.6
          "workspaces, 1, 2.0, easeOutQuint"                         # Reduced from 2.2
          "workspacesIn, 1, 1.3, easeOutQuint"                       # Reduced from 1.5
          "workspacesOut, 1, 2.0, easeOutQuint"                      # Reduced from 2.2
        ];
      };
    };
  };
}
