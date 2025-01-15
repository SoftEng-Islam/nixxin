{ settings, ... }: {
  home-manager.users.${settings.username} = {
    wayland.windowManager.hyprland.settings = {
      workspace =
        [ "special,gapsin:24,gapsout:64" "10,border:false,rounding:false" ];
      #=> Window rules
      windowrule = [
        # "noblur,.*""
        # "opacity 0.89 override 0.89 override, .*" # Applies transparency to EVERY WINDOW

        "center, title:^(Choose wallpaper)(.*)$"
        "center, title:^(File Upload)(.*)$"
        "center, title:^(Library)(.*)$"
        "center, title:^(Open File)(.*)$"
        "center, title:^(Open Folder)(.*)$"
        "center, title:^(Save As)(.*)$"
        "center, title:^(Select a File)(.*)$"
        "float, ^(blueberry.py)$"
        "float, ^(guifetch)$" # FlafyDev/guifetch
        "float, ^(steam)$"
        # Dialogs
        "float,title:^(Choose wallpaper)(.*)$"
        "float,title:^(File Upload)(.*)$"
        "float,title:^(Library)(.*)$"
        "float,title:^(Open File)(.*)$"
        "float,title:^(Open Folder)(.*)$"
        "float,title:^(Save As)(.*)$"
        "float,title:^(Select a File)(.*)$"
        # Tearing
        "immediate,.*.exe"
      ];
      windowrulev2 = [
        "float,class:^(floating)$,title:^(kitty)$"
        "size 50% 50%,class:^(floating)$,title:^(kitty)$"
        "center,class:^(floating)$,title:^(kitty)$"
        "float, title:^([Pp]icture[-s]?[Ii]n[-s]?[Pp]icture)(.*)$"
        "tile, class:(dev.warp.Warp)"
        # Tearing
        "immediate,class:(steam_app)"
        # No shadow for tiled windows
        # "noshadow,floating:0"
      ];
      # ######## Layer rules ########
      layerrule = [
        # Blur settings
        "blur, swaync-control-center" # Apply blur to swaync control center
        "blur, gtk-layer-shell" # Apply blur to GTK layer shell
        "blur, shell:*" # Apply blur to all shell elements
        "blur, launcher" # Apply blur to launcher
        "blur, notifications" # Apply blur to notifications

        # Alpha/Transparency settings
        "ignorealpha 0.5, swaync-control-center" # Set transparency for swaync control center
        "ignorealpha 0.6, shell:*" # Set transparency for shell elements
        "ignorealpha 0.5, launcher" # Set transparency for launcher
        "ignorealpha 0.69, notifications" # Set transparency for notifications

        # X-ray and visibility settings
        "xray 1, gtk-layer-shell" # Apply x-ray effect to GTK layer shell
        "xray 1, .*" # Apply x-ray effect to all matching layers

        # Ignore settings for specific layers
        "ignorezero, gtk-layer-shell" # Ignore zero-sized GTK layer shell windows
        "ignorezero, .*" # Ignore zero-sized layers globally

        # No animation settings for specific layers
        "noanim, .*" # Disable animations for all matching layers
        "noanim, walker" # Disable animations for walker
        "noanim, selection" # Disable animations for selection
        "noanim, overview" # Disable animations for overview
        "noanim, indicator.*" # Disable animations for indicator layers
        "noanim, osk" # Disable animations for on-screen keyboard
        "noanim, hyprpicker" # Disable animations for hyprpicker
      ];
    };
  };
}
