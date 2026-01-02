{ settings, ... }: {
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.extraConfig = ''
      # ---- General Window Rules ---- #
      # windowrule = noblur,.*
      # windowrule = opacity 1.0 override 0.80 override, .* # Applies transparency to EVERY WINDOW

      # ---- Popup/Context Menu Fix ---- #
      # Fix for right-click menus that extend beyond the parent window
      # This ensures clicks register on the popup even when outside the parent app
      windowrulev2 = stayfocused, class:^()$, title:^()$, floating:1
      windowrulev2 = minsize 1 1, class:^()$, title:^()$, floating:1

      # windowrulev2 = tile, class:^(Waydroid)$
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

      # ---- Picture-in-Picture ---- #
      windowrulev2 = keepaspectratio, title:^(Picture(-| )in(-| )[Pp]icture)$
      windowrulev2 = move 73% 72%, title:^(Picture(-| )in(-| )[Pp]icture)$
      windowrulev2 = size 25%, title:^(Picture(-| )in(-| )[Pp]icture)$
      windowrulev2 = float, title:^(Picture(-| )in(-| )[Pp]icture)$
      windowrulev2 = pin, title:^(Picture(-| )in(-| )[Pp]icture)$
      windowrulev2 = opacity 1.0 override 1.0 override, title:^(Picture-in-Picture)$"

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

      # idle inhibit while watching videos
      windowrulev2 = idleinhibit focus, class:^(mpv|.+exe|celluloid)$
      windowrulev2 = idleinhibit focus, class:^(zen)$, title:^(.*YouTube.*)$
      windowrulev2 = idleinhibit fullscreen, class:^(zen)$

      # Ignore maximize requests from apps. You'll probably like this.
      windowrule = suppressevent maximize, class:.*

      # Fix some dragging issues with XWayland
      windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0

      # ----------------------
      # Wezterm specific rules
      # ----------------------
      # windowrule = opacity 0.6 0.5, class:^(wezterm)$
      # windowrulev2 = blur,class:(Wezterm)
      windowrulev2 = noborder,class:(Wezterm)
      windowrulev2 = nodim,class:(Wezterm)
      windowrulev2 = noshadow,class:(Wezterm)
      windowrulev2 = rounding 0,class:(Wezterm)
      # windowrule = opacity 0.90 override 0.85 override,class:(Wezterm)

      # --------------------
      # 0 A.D. rules
      # --------------------
      # windowrule = noborder,class:^(0ad)$
      # windowrule = nodim,class:^(0ad)$
      # windowrule = noshadow,class:^(0ad)$
      # windowrule = noblur,class:^(0ad)$
      # windowrule = fullscreen,class:^(0ad)$
      # windowrule = noanim,class:^(0ad)$
      # windowrule = nofocus,class:^(0ad)$

      # ===============================
      # Rofi Visual Enhancements
      # ===============================
      # Always float and center
      windowrulev2 = float,class:^(Rofi)$
      windowrulev2 = center,class:^(Rofi)$

      # # Remove borders & shadows
      # windowrulev2 = noborder,class:^(Rofi)$

      # # Keep it above everything
      windowrulev2 = stayfocused,class:^(Rofi)$
      # windowrulev2 = pin,class:^(Rofi)$
      # layerrule = blur, rofi
      # layerrule = ignorealpha 0.5, rofi

      # ----------------------
      # Nautilus specific rules
      # ----------------------
      # windowrule = opacity 0.85, class:^(org.gnome.Nautilus)$

      # ----------------------
      # MPV/IMV spacific rules
      # ----------------------
      windowrule = opacity 1.0 override 1.0 override, title:^(.*mpv.*)$
      windowrule = nodim,class:^(mpv)$
      windowrule = opacity 1.0 override 1.0 override, title:^(.*imv.*)$
      windowrule = idleinhibit focus, class:^(mpv)$
      windowrule = noblur,class:^(mpv)$

      # Extra rules for specific apps
      windowrulev2 = idleinhibit fullscreen, class:^(firefox)$
      windowrulev2 = float,class:^(zenity)$
      windowrulev2 = center,class:^(zenity)$
      windowrulev2 = size 850 500,class:^(zenity)$
      windowrulev2 = float,class:^(pavucontrol)$
      windowrulev2 = float,class:^(SoundWireServer)$
      windowrulev2 = float,class:^(.sameboy-wrapped)$
      windowrulev2 = float,class:^(file_progress)$
      windowrulev2 = float,class:^(confirm)$
      windowrulev2 = float,class:^(dialog)$
      windowrulev2 = float,class:^(download)$
      windowrulev2 = float,class:^(notification)$
      windowrulev2 = float,class:^(error)$
      windowrulev2 = float,class:^(confirmreset)$
      windowrulev2 = float,title:^(Open File)$
      windowrulev2 = float,title:^(branchdialog)$
      windowrulev2 = float,title:^(Confirm to replace files)$
      windowrulev2 = float,title:^(File Operation Progress)$

      # -------------------------
      # xwaylandvideobridge rules
      # -------------------------
      windowrulev2 = opacity 0.0 override,class:^(xwaylandvideobridge)$
      windowrulev2 = noanim,class:^(xwaylandvideobridge)$
      windowrulev2 = noinitialfocus,class:^(xwaylandvideobridge)$
      windowrulev2 = maxsize 1 1,class:^(xwaylandvideobridge)$
      windowrulev2 = noblur,class:^(xwaylandvideobridge)$
    '';
  };
}
