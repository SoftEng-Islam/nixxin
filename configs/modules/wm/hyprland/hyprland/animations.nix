{ settings, ... }: {
  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland = {
      settings.animations = {
        enabled = true;
        bezier = [
          "overshot, 0.05, 0.9, 0.1, 1.05"
          "smoothOut, 0.5, 0, 0.99, 0.99"
          "smoothIn, 0.5, -0.5, 0.68, 1.5"
          "rotate,0,0,1,1"
        ];
        animation = [
          "windows, 1, 4, overshot, slide"
          "windowsIn, 1, 2, smoothOut"
          "windowsOut, 1, 0.5, smoothOut"
          "windowsMove, 1, 3, smoothIn, slide"
          "border, 1, 5, default"
          "fade, 1, 4, smoothIn"
          "fadeDim, 1, 4, smoothIn"
          "workspaces, 1, 4, default"
          "borderangle, 1, 20, rotate, loop"
        ];
      };
    };
  };
}
