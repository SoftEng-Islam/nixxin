{ ... }: {
  wayland.windowManager.hyprland.settings = {
    layerrule = [
      "blur, swaync-control-center"
      "blur, gtk-layer-shell"
      "xray 1, gtk-layer-shell"
      "ignorezero, gtk-layer-shell"
      "ignorealpha 0.5, swaync-control-center"
    ];

    windowrule = [ "float,title:^(swayimg)(.*)$" ];
    windowrulev2 = [
      "float,class:^(floating)$,title:^(kitty)$"
      "size 50% 50%,class:^(floating)$,title:^(kitty)$"
      "center,class:^(floating)$,title:^(kitty)$"
    ];

    workspace =
      [ "special,gapsin:24,gapsout:64" "10,border:false,rounding:false" ];
  };
}
