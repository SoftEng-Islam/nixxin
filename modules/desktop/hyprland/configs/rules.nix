{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.extraConfig = ''
      # ---- General Window Rules ---- #
      # windowrule = noblur 1,.*
      # windowrule = opacity 1.0 override 0.80 override, .* # Applies transparency to EVERY WINDOW

      # ---- Popup/Context Menu Fix ---- #
      # Fix for right-click menus that extend beyond the parent window
      # This ensures clicks register on the popup even when outside the parent app
      windowrule = float 1, class:(.*), title:(.*menu.*)
      windowrule = stayfocused 1, class:(.*), title:(.*menu.*)


      # ---- Waydroid ---- #
      windowrule = fullscreen 1, class:^(Waydroid)$

      # ?
      windowrule = tile 1, class:(dev.warp.Warp)
      windowrule = float 1, class:^(xdg-desktop-portal-gtk)$
      windowrule = dimaround 1, class:^(xdg-desktop-portal-gtk)$

      # ---- LFM ---- #
      windowrule = noborder 1, class:^(lfm)$
      windowrule = plugin:hyprbars:nobar 1, class:^(lfm)$

      # ---- Browsers ---- #
      # Force browsers to be tiled by default. Dialog/PiP rules below still float.
      windowrule = tile 1, class:^(zen(-.*)?|firefox(-.*)?|zen|zen-browser|zen-beta|firefoxdeveloperedition|firefox-beta|thunderbird|chromium|vivaldi(-.*)?|brave-browser(-.*)?|google-chrome(-.*)?|microsoft-edge(-.*)?|qutebrowser|librewolf|waterfox|floorp|falkon|org\\.gnome\\.Epiphany)$


      # ---- Dialogs ---- #
      # Fix: Force Dialogs & Pop-ups to Float
      windowrule = center 1, title:^(Choose wallpaper|File Upload|Library|Open File|Open Folder|Pick a File|Save As|Select a File|Rename [Ff]ile)(.*)$
      windowrule = float 1, title:^(Choose wallpaper|File Upload|Library|Open File|Open Folder|Pick a File|Save As|Select a File|Rename [Ff]ile)(.*)$
      windowrule = size 850 500, title:^(Choose wallpaper|File Upload|Library|Open File|Open Folder|Pick a File|Save As|Select a File|Rename [Ff]ile)(.*)$

      windowrule = float 1, class:^(firefox|thunar|gedit|krita), title:^(Open File|Save As)
      windowrule = float 1, class:^(file-roller|pavucontrol|blueman-manager)
      windowrule = float 1, class:^(xdg-desktop-portal|org.kde.kdialog)
      windowrule = center 1, class:^(.*), title:^(Open File|Save As)

      # ---- Picture-in-Picture ---- #
      windowrule = keepaspectratio 1, title:^(Picture(-| )in(-| )[Pp]icture)$
      windowrule = move 73% 72%, title:^(Picture(-| )in(-| )[Pp]icture)$
      windowrule = size 25%, title:^(Picture(-| )in(-| )[Pp]icture)$
      windowrule = float 1, title:^(Picture(-| )in(-| )[Pp]icture)$
      windowrule = pin 1, title:^(Picture(-| )in(-| )[Pp]icture)$
      windowrule = opacity 1.0 override 1.0 override, title:^(Picture-in-Picture)$

      # ---- Tearing Fix ---- #
      windowrule = immediate 1, class:(steam_app)

      # ---- No shadow for tiled windows ---- #
      windowrule = noshadow 1, floating:0

      # ---- Layer Rules ---- #
      layerrule = xray 1, .*
      layerrule = noanim 1, ^(walker|selection|overview|anyrun|indicator.*|osk|hyprpicker)$
      layerrule = ignorealpha 0.6, shell:*

      # ---- Blur Settings ---- #
      layerrule = blur 1, swaync-control-center  # Apply blur to swaync control center
      layerrule = blur 1, gtk-layer-shell        # Apply blur to GTK layer shell
      layerrule = blur 1, shell:*                # Apply blur to all shell elements
      layerrule = blur 1, launcher               # Apply blur to launcher
      layerrule = blur 1, notifications          # Apply blur to notifications

      # idle inhibit while watching videos
      windowrule = idleinhibit focus, class:^(mpv|.+exe|celluloid)$
      windowrule = idleinhibit focus, class:^(zen)$, title:^(.*YouTube.*)$
      windowrule = idleinhibit fullscreen, class:^(zen)$

      # Ignore maximize requests from apps. You'll probably like this.
      windowrule = suppressevent maximize, class:.*

      # Fix some dragging issues with XWayland
      windowrule = nofocus 1, class:^$, title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0

      # ----------------------
      # Wezterm specific rules
      # ----------------------
      windowrule = noborder 1, class:(Wezterm)
      windowrule = nodim 1, class:(Wezterm)
      windowrule = noshadow 1, class:(Wezterm)
      windowrule = rounding 0, class:(Wezterm)

      # --------------------
      # 0 A.D. rules
      # --------------------
      # windowrule = noborder 1, class:^(0ad)$
      # windowrule = nodim 1, class:^(0ad)$
      # windowrule = noshadow 1, class:^(0ad)$
      # windowrule = noblur 1, class:^(0ad)$
      # windowrule = fullscreen 1, class:^(0ad)$
      # windowrule = noanim 1, class:^(0ad)$

      # ===============================
      # Rofi Visual Enhancements
      # ===============================
      # Always float and center
      windowrule = float 1, class:^(Rofi)$
      windowrule = center 1, class:^(Rofi)$

      # # Remove borders & shadows
      # windowrule = noborder 1, class:^(Rofi)$

      # # Keep it above everything
      windowrule = stayfocused 1, class:^(Rofi)$
      # windowrule = pin 1, class:^(Rofi)$
      # layerrule = blur 1, rofi
      # layerrule = ignorealpha 0.5, rofi

      # ----------------------
      # Nautilus specific rules
      # ----------------------
      # windowrule = opacity 0.85, class:^(org.gnome.Nautilus)$

      # ----------------------
      # MPV/IMV specific rules
      # ----------------------
      windowrule = opacity 1.0 override 1.0 override, title:^(.*mpv.*)$
      windowrule = nodim 1, class:^(mpv)$
      windowrule = opacity 1.0 override 1.0 override, title:^(.*imv.*)$
      windowrule = idleinhibit focus, class:^(mpv)$
      windowrule = noblur 1, class:^(mpv)$

      # Extra rules for specific apps
      windowrule = idleinhibit fullscreen, class:^(firefox)$
      windowrule = float 1, class:^(pavucontrol)$
      windowrule = float 1, class:^(SoundWireServer)$
      windowrule = float 1, class:^(.sameboy-wrapped)$
      windowrule = float 1, class:^(file_progress)$
      windowrule = float 1, class:^(confirm)$
      windowrule = float 1, class:^(dialog)$
      windowrule = float 1, class:^(download)$
      windowrule = float 1, class:^(notification)$
      windowrule = float 1, class:^(error)$
      windowrule = float 1, class:^(confirmreset)$
      windowrule = float 1, title:^(Open File)$
      windowrule = float 1, title:^(branchdialog)$
      windowrule = float 1, title:^(Confirm to replace files)$
      windowrule = float 1, title:^(File Operation Progress)$

      # -------------------------
      # xwaylandvideobridge rules
      # -------------------------
      windowrule = opacity 0.0 override, class:^(xwaylandvideobridge)$
      windowrule = noanim 1, class:^(xwaylandvideobridge)$
      windowrule = noinitialfocus 1, class:^(xwaylandvideobridge)$
      windowrule = maxsize 1 1, class:^(xwaylandvideobridge)$
      windowrule = noblur 1, class:^(xwaylandvideobridge)$
    '';
  };
}
