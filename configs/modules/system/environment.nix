{ settings, pkgs, ... }: {
  # Environment Variables
  # find /nix/store -name "something"

  # /nix/store/jxhvcy7ckv5nzqqb1rxl72wv09dxa84x-gstreamer-1.24.7/lib/../libexec/gstreamer-1.0/gst-plugin-scanner -l /nix/store/r4qg6d6jybpyj4kjql45a5c42lwnyz25-localsearch-3.8.1/libexec/.localsearch-3-wrapped

  environment = {
    variables = {
      EDITOR = settings.editor;
      VISUAL = settings.visual;
      GTK_THEME = settings.gtkTheme;
      HYPRCURSOR_THEME = settings.cursorTheme;
      HYPRCURSOR_SIZE = toString settings.cursorSize;
      LANG = settings.locale;
      XKB_DEFAULT_RULES = "evdev";

      # GLFW_IM_MODULE = "ibus";
      # HIP_VISIBLE_DEVICES = "0,2";
      # LIBGL_DRI3_ENABLE = "1";
      # LIBGL_ALWAYS_INDIRECT = "1";

      # WLR_DRM_DEVICES = "/dev/dri/card1";
      # WLR_DRM_NO_ATOMIC = "1";
      # WLR_VSYNC = "1";

      HIP_PATH = "${pkgs.rocmPackages.hip-common}/libexec/hip";

      # Simple DirectMedia Layer (SDL) library to use the Wayland display server as its video driver.
      WAYLAND = "1";
      WAYLAND_DISPLAY = "wayland-0";

      SDL_VIDEODRIVER = "wayland";
      BEMENU_BACKEND = "wayland";
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland";
      ELM_ENGINE = "wayland_egl";
      ECORE_EVAS_ENGINE = "wayland_egl";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      ELECTRON_ENABLE_WAYLAND = "1";

      BUN_INSTALL = "$HOME/.bun";

      GDK_PIXBUF_MODULE_FILE =
        "${pkgs.librsvg}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache";

      GOPROXY = "direct";

      MOZ_DBUS_REMOTE = "1";
      MOZ_ENABLE_WAYLAND = "1";
      NIXPKGS_ALLOW_UNFREE = "1";

      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_PLATFORM_PLUGIN = "wayland";

      WINEESYNC = "1";
      WINEFSYNC = "1";

      RUST_BACKTRACE = "1";
      CARGO_PROFILE_DEV_BUILD_OVERRIDE_DEBUG = "true";

      # Colors #
      # Black = "033[30m";
      # Blue = "033[34m";
      # Cyan = "033[36m";
      # Green = "033[32m";
      # Magenta = "033[35m";
      # Red = "033[31m";
      # White = "033[37m";
      # Yellow = "033[33m";
      # # Bright (Bold) Colors:
      # B_Black = "033[90m";
      # B_Blue = "033[94m";
      # B_Cyan = "033[96m";
      # B_Green = "033[92m";
      # B_Magenta = "033[95m";
      # B_Red = "033[91m";
      # B_White = "033[97m";
      # B_Yellow = "033[93m";
      # text format
      nc = "033[0m";
      bold = "033[1m";
      italic = "033[3m";
      underline = "033[4m";
      strikeThrough = "033[9m";
      RESET = "033[0m"; # Reset color
      # Unicode Characters
      heart = "u2764"; # `echo -e "\u2764" Outputs a heart symbol (❤)`

      QUOTING_STYLE = "literal";
      PKG_CONFIG_PATH = "$HOME/.nix-profile/lib/pkgconfig:/usr/lib/pkgconfig";
      # PKG_CONFIG_PATH = "$(nix eval nixpkgs.zlib.dev.outPath --raw)/lib/pkgconfig:$PKG_CONFIG_PATH";
      # PKG_CONFIG_PATH = "${pkgs.glib}/lib/pkgconfig";
      GST_PLUGIN_PATH =
        "${pkgs.gst_all_1.gst-plugins-base}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-good}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-bad}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-ugly}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-libav}/lib/gstreamer-1.0";
      GI_TYPELIB_PATH = "${pkgs.glib}/lib/girepository-1.0:"
        + "${pkgs.gobject-introspection}/lib/girepository-1.0:"
        + "${pkgs.networkmanager}/lib/girepository-1.0:"
        + "${pkgs.gobject-introspection-unwrapped}/lib/girepository-1.0:"
        + "${pkgs.gst_all_1.gstreamer}/lib/girepository-1.0:"
        + "${pkgs.gst_all_1.gst-plugins-base}/lib/girepository-1.0:"
        + "${pkgs.gst_all_1.gst-plugins-ugly}/lib/girepository-1.0:"
        + "$GI_TYPELIB_PATH";
    };
    sessionVariables = {
      # FONTCONFIG_PATH = "/etc/fonts";
      # FONTCONFIG_FILE = "/etc/fonts/fonts.conf";
      # XDG_CACHE_HOME = "/tmp/.cache";
      XCURSOR_THEME = settings.cursorTheme;
      XCURSOR_SIZE = toString settings.cursorSize;
      # WLR_NO_HARDWARE_CURSORS = 1; # IF your cursor becomes invisible
      # Enables portal-based access for apps like VSCode on Wayland
      GTK_USE_PORTAL = "1";
      NIXOS_OZONE_WL = "1"; # Optional, hint electron apps to use wayland
      XDG_DATA_DIRS = [
        "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
        "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
      ];
    };
  };
}
