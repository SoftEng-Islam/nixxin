{ settings, ... }: {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.extraConfig = ''
      # ---- General Window Rules ---- #
      # windowrule = noblur,.*
      # windowrule = opacity 0.89 override 0.89 override, .* # Applies transparency to EVERY WINDOW


      windowrulev2 = float, class:^(Waydroid|waydroid)$
      windowrulev2 = tile, class:(dev.warp.Warp)

      # ---- Dialogs ---- #
      # Fix: Force Dialogs & Pop-ups to Float
      windowrule = center, title:^(Choose wallpaper|File Upload|Library|Open File|Open Folder|Pick a File|Save As|Select a File)(.*)$
      windowrule = float, title:^(Choose wallpaper|File Upload|Library|Open File|Open Folder|Pick a File|Save As|Select a File)(.*)$
      windowrulev2 = float,class:^(firefox|thunar|gedit|krita),title:^(Open File|Save As)
      windowrulev2 = float,class:^(file-roller|pavucontrol|blueman-manager)
      windowrulev2 = float,title:^(Open|Save|Preferences)
      windowrulev2 = float,class:^(xdg-desktop-portal|org.kde.kdialog|nemo)
      windowrulev2 = center, class:^(.*), title:^(Open File|Save As)
      windowrulev2 = float,title:^(.*Open.*|.*Save.*|.*Select.*|.*Browse.*)$
      windowrulev2 = center,title:^(.*Open.*|.*Save.*|.*Select.*|.*Browse.*)$

      windowrulev2 = noinitialfocus, class:.*
      windowrulev2 = idleinhibit focus, class:.*


      # ---- Picture-in-Picture ---- #
      windowrulev2 = keepaspectratio, title:^(Picture(-| )in(-| )[Pp]icture)$
      windowrulev2 = move 73% 72%, title:^(Picture(-| )in(-| )[Pp]icture)$
      windowrulev2 = size 25%, title:^(Picture(-| )in(-| )[Pp]icture)$
      windowrulev2 = float, title:^(Picture(-| )in(-| )[Pp]icture)$
      windowrulev2 = pin, title:^(Picture(-| )in(-| )[Pp]icture)$

      # ---- Tearing Fix ---- #
      windowrulev2 = immediate, class:(steam_app)

      # ---- No shadow for tiled windows ---- #
      windowrulev2 = noshadow, floating:0

      # ---- Layer Rules ---- #
      layerrule = xray 1, .*
      layerrule = noanim, ^(walker|selection|overview|anyrun|indicator.*|osk|hyprpicker)$
      layerrule = blur, shell:*
      layerrule = ignorealpha 0.6, shell:*

      # ---- Blur Settings ---- #
      layerrule = blur, swaync-control-center  # Apply blur to swaync control center
      layerrule = blur, gtk-layer-shell        # Apply blur to GTK layer shell
      layerrule = blur, shell:*                # Apply blur to all shell elements
      layerrule = blur, launcher               # Apply blur to launcher
      layerrule = blur, notifications          # Apply blur to notifications

      # ---- ulauncher Rules ---- #
      windowrulev2 = plugin:hyprbars:nobar, class:^(ulauncher)$
      windowrulev2 = stayfocused, class:^(ulauncher)$
      windowrulev2 = float, class:^(ulauncher)$
      windowrulev2 = center, class:^(ulauncher)$
      windowrulev2 = noborder, class:^(ulauncher)$
      windowrulev2 = noshadow, class:^(ulauncher)$
      windowrulev2 = noblur, class:^(ulauncher)$

      # idle inhibit while watching videos
      windowrulev2 = idleinhibit focus, class:^(mpv|.+exe|celluloid)$
      windowrulev2 = idleinhibit focus, class:^(zen)$, title:^(.*YouTube.*)$
      windowrulev2 = idleinhibit fullscreen, class:^(zen)$
    '';
  };
}
