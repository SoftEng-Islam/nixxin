{ settings, ... }: {
  home-manager.users.${settings.users.selected.username} = {
    wayland.windowManager.hyprland.settings = {
      workspace =
        [ "special,gapsin:24,gapsout:64" "10,border:false,rounding:false" ];
      #=> Window rules
      windowrule = [
        # "noblur,.*""
        # "opacity 0.89 override 0.89 override, .*" # Applies transparency to EVERY WINDOW

        "float,^(pavucontrol)$"
        "pin,^(pavucontrol)$"
        "size 900 500,^(pavucontrol)$"

        "float,class:^(Material Settings)$"

        # Dialogs
        "float, title:^(Choose wallpaper)(.*)$"
        "float, title:^(File Upload)(.*)$"
        "float, title:^(Library)(.*)$"
        "float, title:^(Open File)(.*)$"
        "float, title:^(Open Folder)(.*)$"
        "float, title:^(Save As)(.*)$"
        "float, title:^(Select a File)(.*)$"
        # Tearing
        "immediate,.*.exe"
      ];
      windowrulev2 = [
        "float, title:^([Pp]icture[-s]?[Ii]n[-s]?[Pp]icture)(.*)$"
        "tile, class:(dev.warp.Warp)"

        # No shadow for tiled windows
        # "noshadow,floating:0"
      ];
      # ######## Layer rules ########
      layerrule = [

        "blur,^(ignis_BAR.*)$"
        "noanim,^(ignis_NOTIFICATION_POPUP.*)$"
        "noanim,^(ignis_CONTROL_CENTER.*)$"

        # Blur settings
        "blur, swaync-control-center" # Apply blur to swaync control center
        "blur, gtk-layer-shell" # Apply blur to GTK layer shell
        "blur, shell:*" # Apply blur to all shell elements
        "blur, launcher" # Apply blur to launcher
        "blur, notifications" # Apply blur to notifications
      ];
    };
  };
}
