{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.extraConfig = ''
      # ---- General Window Rules ---- #
      # windowrule = no_blur 1, match:class .*
      # windowrule = opacity 1.0 override 0.80 override, match:class .* # Applies transparency to EVERY WINDOW

      # ---- Popup/Context Menu Fix ---- #
      # Fix for right-click menus that extend beyond the parent window
      # This ensures clicks register on the popup even when outside the parent app
      windowrule = float 1, match:class (.*), match:title (.*menu.*)
      windowrule = stay_focused 1, match:class (.*), match:title (.*menu.*)


      # ---- Waydroid ---- #
      windowrule = fullscreen 1, match:class ^(Waydroid)$

      # ?
      windowrule = tile 1, match:class (dev.warp.Warp)
      windowrule = float 1, match:class ^(xdg-desktop-portal-gtk)$
      windowrule = dim_around 1, match:class ^(xdg-desktop-portal-gtk)$

      # ---- LFM ---- #
      windowrule = border_size 0, match:class ^(lfm)$
      windowrule = plugin:hyprbars:nobar 1, match:class ^(lfm)$

      # ---- Browsers ---- #
      # Force browsers to be tiled by default. Dialog/PiP rules below still float.
      windowrule = tile 1, match:class ^(zen(-.*)?|firefox(-.*)?|zen|zen-browser|zen-beta|firefoxdeveloperedition|firefox-beta|thunderbird|chromium|vivaldi(-.*)?|brave-browser(-.*)?|google-chrome(-.*)?|microsoft-edge(-.*)?|qutebrowser|librewolf|waterfox|floorp|falkon|org\\.gnome\\.Epiphany)$


      # ---- Dialogs ---- #
      # Fix: Force Dialogs & Pop-ups to Float
      windowrule = center 1, match:title ^(Choose wallpaper|File Upload|Library|Open File|Open Folder|Pick a File|Save As|Select a File|Rename [Ff]ile)(.*)$
      windowrule = float 1, match:title ^(Choose wallpaper|File Upload|Library|Open File|Open Folder|Pick a File|Save As|Select a File|Rename [Ff]ile)(.*)$
      windowrule = size 850 500, match:title ^(Choose wallpaper|File Upload|Library|Open File|Open Folder|Pick a File|Save As|Select a File|Rename [Ff]ile)(.*)$

      windowrule = float 1, match:class ^(firefox|thunar|gedit|krita), match:title ^(Open File|Save As)
      windowrule = float 1, match:class ^(file-roller|pavucontrol|blueman-manager)
      windowrule = float 1, match:class ^(xdg-desktop-portal|org.kde.kdialog)
      windowrule = center 1, match:class ^(.*), match:title ^(Open File|Save As)

      # ---- Picture-in-Picture ---- #
      windowrule = keep_aspect_ratio 1, match:title ^(Picture(-| )in(-| )[Pp]icture)$
      windowrule = move 73% 72%, match:title ^(Picture(-| )in(-| )[Pp]icture)$
      windowrule = size 25% 25%, match:title ^(Picture(-| )in(-| )[Pp]icture)$
      windowrule = float 1, match:title ^(Picture(-| )in(-| )[Pp]icture)$
      windowrule = pin 1, match:title ^(Picture(-| )in(-| )[Pp]icture)$
      windowrule = opacity 1.0 override 1.0 override, match:title ^(Picture-in-Picture)$

      # ---- Tearing Fix ---- #
      windowrule = immediate 1, match:class (steam_app)

      # ---- No shadow for tiled windows ---- #
      windowrule = no_shadow 1, match:float 0

      # ---- Layer Rules ---- #
      layerrule = xray 1, match:namespace .*
      layerrule = no_anim 1, match:namespace ^(walker|selection|overview|anyrun|indicator.*|osk|hyprpicker)$
      layerrule = ignore_alpha 0.6, match:namespace shell:*

      # ---- Blur Settings ---- #
      layerrule = blur 1, match:namespace swaync-control-center  # Apply blur to swaync control center
      layerrule = blur 1, match:namespace gtk-layer-shell        # Apply blur to GTK layer shell
      layerrule = blur 1, match:namespace shell:*                # Apply blur to all shell elements
      layerrule = blur 1, match:namespace launcher               # Apply blur to launcher
      layerrule = blur 1, match:namespace notifications          # Apply blur to notifications

      # idle inhibit while watching videos
      windowrule = idle_inhibit focus, match:class ^(mpv|.+exe|celluloid)$
      windowrule = idle_inhibit focus, match:class ^(zen)$, match:title ^(.*YouTube.*)$
      windowrule = idle_inhibit fullscreen, match:class ^(zen)$

      # Ignore maximize requests from apps. You'll probably like this.
      windowrule = suppress_event maximize, match:class .*

      # Fix some dragging issues with XWayland
      windowrule = no_focus 1, match:class ^$, match:title ^$, match:xwayland 1, match:float 1, match:fullscreen 0, match:pin 0

      # ----------------------
      # Wezterm specific rules
      # ----------------------
      windowrule = border_size 0, match:class (Wezterm)
      windowrule = no_dim 1, match:class (Wezterm)
      windowrule = no_shadow 1, match:class (Wezterm)
      windowrule = rounding 0, match:class (Wezterm)

      # --------------------
      # 0 A.D. rules
      # --------------------
      # windowrule = border_size 0, match:class ^(0ad)$
      # windowrule = no_dim 1, match:class ^(0ad)$
      # windowrule = no_shadow 1, match:class ^(0ad)$
      # windowrule = no_blur 1, match:class ^(0ad)$
      # windowrule = fullscreen 1, match:class ^(0ad)$
      # windowrule = no_anim 1, match:class ^(0ad)$

      # ===============================
      # Rofi Visual Enhancements
      # ===============================
      # Always float and center
      windowrule = float 1, match:class ^(Rofi)$
      windowrule = center 1, match:class ^(Rofi)$

      # # Remove borders & shadows
      # windowrule = border_size 0, match:class ^(Rofi)$

      # # Keep it above everything
      windowrule = stay_focused 1, match:class ^(Rofi)$
      # windowrule = pin 1, match:class ^(Rofi)$
      # layerrule = blur 1, match:namespace rofi
      # layerrule = ignore_alpha 0.5, match:namespace rofi

      # ----------------------
      # Nautilus specific rules
      # ----------------------
      # windowrule = opacity 0.85, match:class ^(org.gnome.Nautilus)$

      # ----------------------
      # MPV/IMV specific rules
      # ----------------------
      windowrule = opacity 1.0 override 1.0 override, match:title ^(.*mpv.*)$
      windowrule = no_dim 1, match:class ^(mpv)$
      windowrule = opacity 1.0 override 1.0 override, match:title ^(.*imv.*)$
      windowrule = idle_inhibit focus, match:class ^(mpv)$
      windowrule = no_blur 1, match:class ^(mpv)$

      # Extra rules for specific apps
      windowrule = idle_inhibit fullscreen, match:class ^(firefox)$
      windowrule = float 1, match:class ^(pavucontrol)$
      windowrule = float 1, match:class ^(SoundWireServer)$
      windowrule = float 1, match:class ^(.sameboy-wrapped)$
      windowrule = float 1, match:class ^(file_progress)$
      windowrule = float 1, match:class ^(confirm)$
      windowrule = float 1, match:class ^(dialog)$
      windowrule = float 1, match:class ^(download)$
      windowrule = float 1, match:class ^(notification)$
      windowrule = float 1, match:class ^(error)$
      windowrule = float 1, match:class ^(confirmreset)$
      windowrule = float 1, match:title ^(Open File)$
      windowrule = float 1, match:title ^(branchdialog)$
      windowrule = float 1, match:title ^(Confirm to replace files)$
      windowrule = float 1, match:title ^(File Operation Progress)$

      # -------------------------
      # xwaylandvideobridge rules
      # -------------------------
      windowrule = opacity 0.0 override, match:class ^(xwaylandvideobridge)$
      windowrule = no_anim 1, match:class ^(xwaylandvideobridge)$
      windowrule = no_initial_focus 1, match:class ^(xwaylandvideobridge)$
      windowrule = max_size 1 1, match:class ^(xwaylandvideobridge)$
      windowrule = no_blur 1, match:class ^(xwaylandvideobridge)$
    '';
  };
}
