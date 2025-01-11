{ ... }: {
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
    ];
    windowrulev2 = [
      "float,class:^(floating)$,title:^(kitty)$"
      "size 50% 50%,class:^(floating)$,title:^(kitty)$"
      "center,class:^(floating)$,title:^(kitty)$"
      "float, title:^([Pp]icture[-s]?[Ii]n[-s]?[Pp]icture)(.*)$"
      "tile, class:(dev.warp.Warp)"
    ];
    layerrule = [
      "blur, swaync-control-center"
      "blur, gtk-layer-shell"
      "xray 1, gtk-layer-shell"
      "ignorezero, gtk-layer-shell"
      "ignorealpha 0.5, swaync-control-center"
    ];
  };
}
