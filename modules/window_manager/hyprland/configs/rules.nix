{ settings, ... }: {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.extraConfig = ''
      # ---- General Window Rules ---- #
      # windowrule = noblur,.*
      # windowrule = opacity 0.89 override 0.89 override, .* # Applies transparency to EVERY WINDOW

      windowrule = float, ^(blueberry.py|guifetch|steam|pavucontrol)$
      windowrule = pin, ^(pavucontrol)$
      windowrule = size 900 500, ^(pavucontrol)$
      windowrulev2 = float, class:^(Waydroid|waydroid)$
      windowrulev2 = tile, class:(dev.warp.Warp)

      # ---- Dialogs ---- #
      windowrule = center, title:^(Choose wallpaper|File Upload|Library|Open File|Open Folder|Pick a File|Save As|Select a File)(.*)$
      windowrule = float, title:^(Choose wallpaper|File Upload|Library|Open File|Open Folder|Pick a File|Save As|Select a File)(.*)$

      # ---- Picture-in-Picture ---- #
      windowrulev2 = keepaspectratio, title:^(Picture(-| )in(-| )[Pp]icture)$
      windowrulev2 = move 73% 72%, title:^(Picture(-| )in(-| )[Pp]icture)$
      windowrulev2 = size 25%, title:^(Picture(-| )in(-| )[Pp]icture)$
      windowrulev2 = float, title:^(Picture(-| )in(-| )[Pp]icture)$
      windowrulev2 = pin, title:^(Picture(-| )in(-| )[Pp]icture)$

      # ---- Tearing Fix ---- #
      windowrule = immediate, .*\.exe
      windowrulev2 = immediate, class:(steam_app)

      # ---- No shadow for tiled windows ---- #
      windowrulev2 = noshadow, floating:0

      # ---- Layer Rules ---- #
      layerrule = xray 1, .*
      layerrule = noanim, ^(walker|selection|overview|anyrun|indicator.*|osk|hyprpicker)$
      layerrule = blur, shell:*
      layerrule = ignorealpha 0.6, shell:*

      # ---- Ignis-Specific Layer Rules ---- #
      layerrule = blur, ^(ignis_BAR.*)$
      layerrule = noanim, ^(ignis_NOTIFICATION_POPUP.*|ignis_CONTROL_CENTER.*)$

      # ---- Blur Settings ---- #
      layerrule = blur, swaync-control-center  # Apply blur to swaync control center
      layerrule = blur, gtk-layer-shell        # Apply blur to GTK layer shell
      layerrule = blur, shell:*                # Apply blur to all shell elements
      layerrule = blur, launcher               # Apply blur to launcher
      layerrule = blur, notifications          # Apply blur to notifications

      # ---- hyprbars Rules ---- #
      windowrulev2 = plugin:hyprbars:nobar, albert
    '';
  };
}
