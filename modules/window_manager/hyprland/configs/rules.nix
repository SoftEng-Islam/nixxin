{ settings, ... }: {
  home-manager.users.${settings.users.selected.username} = {
    wayland.windowManager.hyprland.extraConfig = ''
      # windowrule = noblur,.*
      # windowrule = opacity 0.89 override 0.89 override, .* # Applies transparency to EVERY WINDOW
      windowrule = float, ^(blueberry.py)$
      windowrule = float, ^(steam)$
      windowrule = float, ^(guifetch)$ # FlafyDev/guifetch
      windowrulev2 = float,class:^(Waydroid|waydroid)
      windowrulev2 = tile, class:(dev.warp.Warp)
      windowrulev2 = float, title:^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$
      windowrule = center, title:^(Open File)(.*)$
      windowrule = center, title:^(Select a File)(.*)$
      windowrule = center, title:^(Choose wallpaper)(.*)$
      windowrule = center, title:^(Open Folder)(.*)$
      windowrule = center, title:^(Save As)(.*)$
      windowrule = center, title:^(Library)(.*)$
      windowrule = center, title:^(File Upload)(.*)$
      windowrule = float,^(pavucontrol)$
      windowrule = pin,^(pavucontrol)$
      windowrule = size 900 500,^(pavucontrol)$
      windowrule = float,class:^(Material Settings)$

      # Picture-in-Picture
      windowrulev2 = keepaspectratio, title:^(Picture(-| )in(-| )[Pp]icture)$
      windowrulev2 = move 73% 72%,title:^(Picture(-| )in(-| )[Pp]icture)$
      windowrulev2 = size 25%, title:^(Picture(-| )in(-| )[Pp]icture)$
      windowrulev2 = float, title:^(Picture(-| )in(-| )[Pp]icture)$
      windowrulev2 = pin, title:^(Picture(-| )in(-| )[Pp]icture)$

      # Dialogs
      windowrule=float,title:^(Open File)(.*)$
      windowrule=float,title:^(Select a File)(.*)$
      windowrule=float,title:^(Choose wallpaper)(.*)$
      windowrule=float,title:^(Open Folder)(.*)$
      windowrule=float,title:^(Save As)(.*)$
      windowrule=float,title:^(Library)(.*)$
      windowrule=float,title:^(File Upload)(.*)$

      # Tearing
      windowrule=immediate,.*\.exe
      windowrulev2=immediate,class:(steam_app)

      # No shadow for tiled windows
      windowrulev2 = noshadow,floating:0

      # ---- Layer rules ---- #
      layerrule = xray 1, .*
      # layerrule = noanim, .*
      layerrule = noanim, walker
      layerrule = noanim, selection
      layerrule = noanim, overview
      layerrule = noanim, anyrun
      layerrule = noanim, indicator.*
      layerrule = noanim, osk
      layerrule = noanim, hyprpicker
      layerrule = blur, shell:*
      layerrule = ignorealpha 0.6, shell:*

      # ---- Layer rules ---- #
      layerrule = blur,^(ignis_BAR.*)$
      layerrule = noanim,^(ignis_NOTIFICATION_POPUP.*)$
      layerrule = noanim,^(ignis_CONTROL_CENTER.*)$

      # Blur settings
      layerrule = blur, swaync-control-center" # Apply blur to swaync control center
      layerrule = blur, gtk-layer-shell" # Apply blur to GTK layer shell
      layerrule = blur, shell:*" # Apply blur to all shell elements
      layerrule = blur, launcher" # Apply blur to launcher
      layerrule = blur, notifications" # Apply blur to notifications
    '';
  };
}
