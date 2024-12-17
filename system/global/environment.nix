{ settings, pkgs, ... }: {
  # Environment Variables
  # find /nix/store -name "something"
  environment = {
    variables = {
      # GLFW_IM_MODULE = "ibus";
      # HIP_VISIBLE_DEVICES = "0,2";
      # LIBGL_DRI3_ENABLE = "1";
      # SDL_VIDEODRIVER = "wayland";
      HYPRCURSOR_THEME = settings.cursorTheme;
      HYPRCURSOR_SIZE = settings.cursorSize;
      _JAVA_AWT_WM_NONREPARENTING = "1";
      BEMENU_BACKEND = "wayland";
      BUN_INSTALL = "$HOME/.bun";
      CARGO_PROFILE_DEV_BUILD_OVERRIDE_DEBUG = "true";
      CLUTTER_BACKEND = "wayland";
      ECORE_EVAS_ENGINE = "wayland_egl";
      EDITOR = settings.editor;
      ELECTRON_ENABLE_WAYLAND = "1";
      ELM_ENGINE = "wayland_egl";
      WLR_DRM_DEVICES = "/dev/dri/card1";
      GDK_BACKEND = "wayland,x11,*";
      GTK_THEME = "Colloid-Dark";
      LANG = settings.locale;
      MOZ_DBUS_REMOTE = "1";
      MOZ_ENABLE_WAYLAND = "1";
      NIXPKGS_ALLOW_UNFREE = "1";
      GDK_PIXBUF_MODULE_FILE =
        "${pkgs.librsvg}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      RUST_BACKTRACE = "1";
      VISUAL = settings.visual;
      WAYLAND = "1";
      WINEESYNC = "1";
      WINEFSYNC = "1";
      WLR_DRM_NO_ATOMIC = "1";
      WLR_VSYNC = "1";
      XKB_DEFAULT_RULES = "evdev";

      # Colors #
      Black = "033[30m";
      Red = "033[31m";
      Green = "033[32m";
      Yellow = "033[33m";
      Blue = "033[34m";
      Magenta = "033[35m";
      Cyan = "033[36m";
      White = "033[37m";
      # Bright (Bold) Colors:
      B_Black = "033[90m";
      B_Red = "033[91m";
      B_Green = "033[92m";
      B_Yellow = "033[93m";
      B_Blue = "033[94m";
      B_Magenta = "033[95m";
      B_Cyan = "033[96m";
      B_White = "033[97m";
      # text format
      nc = "033[0m";
      bold = "033[1m";
      italic = "033[3m";
      underline = "033[4m";
      strikeThrough = "033[9m";
      RESET = "033[0m"; # Reset color
      # Unicode Characters
      heart = "u2764"; # `echo -e "\u2764" Outputs a heart symbol (❤)`

      PKG_CONFIG_PATH =
        "/nix/store/bj5cf0ysvyjpqdwdjw7rqqd74g0wrdn3-glib-2.80.2-dev/lib/pkgconfig";
      GST_PLUGIN_PATH =
        "/nix/store/01n130457xklp8b00ydwax22l0z3a62j-gst-plugins-base-1.24.3/lib/gstreamer-1.0:/nix/store/2dqc2lqhzacg2mb79677ik426a74axik-gst-plugins-good-1.24.3/lib/gstreamer-1.0:/nix/store/2syk2lmxxwx3cksqfjsb20zf5mdhrxir-gst-plugins-bad-1.24.3/lib/gstreamer-1.0:/nix/store/b88jfk9l912qgwmf98cp1024hmz05pd5-gst-plugins-ugly-1.24.3/lib/gstreamer-1.0:/nix/store/8llhhp5r452dkbz32kb7xxd1qpl5j433-gst-libav-1.24.3/lib/gstreamer-1.0";
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
      XCURSOR_THEME = settings.cursorTheme;
      # XCURSOR_SIZE = "${toString.settings.cursorSize}";

      # WLR_NO_HARDWARE_CURSORS = 1; # IF your cursor becomes invisible

      # Enables portal-based access for apps like VSCode on Wayland
      GTK_USE_PORTAL = "1";

      # NIXOS_OZONE_WL = "1"; # Optional, hint electron apps to use wayland
    };
  };
}
