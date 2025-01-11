{ settings, ... }: {
  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland = {
      settings.animations = {
        enabled = true;
        bezier = [
          # Linear transitions
          "linear, 0, 0, 1, 1" # Linear: constant velocity
          "liner, 1, 1, 1, 1" # Repeated 'linear' for any possible use case

          # Window transitions
          "winIn, 0.1, 1.1, 0.1, 1.1" # Window in with subtle acceleration
          "winOut, 0.3, -0.3, 0, 1" # Window out with a quick snap

          # Workspace transitions
          "workIn, 0.72, -0.07, 0.41, 0.98" # Workspace transition: smooth and natural
          "wind, 0.05, 0.9, 0.1, 1.05" # Slightly winding motion

          # Advanced easing functions
          "easeInOutCirc, 0.85, 0, 0.15, 1" # Ease in-out circle for a more rounded easing
          "easeOutCirc, 0, 0.55, 0.45, 1" # Ease out circle for decelerated smooth motion
          "easeOutExpo, 0.16, 1, 0.3, 1" # Expo ease-out for a more dramatic end
          "softAcDecel, 0.26, 0.26, 0.15, 1" # Soft deceleration with a nice curve

          # Special transition curves
          "md3_standard, 0.2, 0, 0, 1" # Standard MD3 transition
          "md3_decel, 0.05, 0.7, 0.1, 1" # MD3 deceleration: slows down quickly
          "md3_accel, 0.3, 0, 0.8, 0.15" # MD3 acceleration: speeds up smoothly

          # Miscellaneous curves
          "overshot, 0.05, 0.9, 0.1, 1.1" # Overshot transition for dramatic pullback
          "crazyshot, 0.1, 1.5, 0.76, 0.92" # Very fast but smooth transition
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0" # Hyprland-specific stretch effect
          "menu_decel, 0.1, 1, 0, 1" # Menu deceleration effect
          "menu_accel, 0.38, 0.04, 1, 0.07" # Menu acceleration

          # MD2 transition (use with shorter durations)
          "md2, 0.4, 0, 0.2, 1" # MD2: quick but smooth transition
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
          "specialWorkspace, 1, 5, workIn, slidevert"
        ];
      };
    };
  };
}
