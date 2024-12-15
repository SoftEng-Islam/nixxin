{ settings, pkgs, ... }: {
  wayland.windowManager.hyprland.settings = {
    env = [
      "HYPRCURSOR_THEME,${settings.cursorTheme}"
      "HYPRCURSOR_SIZE,${settings.cursorSize}"
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_DEKSTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "WLR_DRM_DEVICES,/dev/dri/card1"
      "GDK_BACKEND,wayland,x11,*"
      "QT_QPA_PLATFORM,wayland;xcb"
      "QT_QPA_PLATFORMTHEME,qt5ct"
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "CLUTTER_BACKEND,wayland"
      "GDK_PIXBUF_MODULE_FILE,${pkgs.librsvg}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache"
      "MOZ_ENABLE_WAYLAND,1"
      "XDG_SESSION_TYPE,wayland"
      "XDG_PICTURES_DIR,~/Pictures"
      "XDG_SCREENSHOTS_DIR,~/Pictures/Screenshots"
    ];
  };
}
